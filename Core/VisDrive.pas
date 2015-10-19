{******************************************************************************}
{                                                                              }
{ Ur-Autor: Silhwan Hyun hsh@chollian.net (Version 1.0)                        }
{                                                                              }
{ Edit to Version B.3.1 by omata (Thorsten) - http://www.delphipraxis.net      }
{                                                                              }
{******************************************************************************}
unit VisDrive;

interface

uses
  Windows, SysUtils, Messages, mmsystem, PluginCtrl, ioplug, Forms;


type
   TChannelAttrb = record
      Title : string;
      SampleRate : LongInt;
      BitRate   : LongInt;
      Duration : DWORD;        // Song duration in mili second
      Channels : Word;
   end;

  procedure Start_Vis(VisPlugin : string; MainWin, MessageHandle, StatusMsg : HWND;
                      ShareMemPointer : pointer;
                      ModuleNum : integer; SyncMain : boolean;
                      PlayerModeId : integer; ChannelIs : TChannelAttrb{; FakeWin : HWND});
  procedure Stop_Vis;
  procedure Stop_Vis2;

implementation

  procedure HideVisWindow; forward;
  procedure ShowVisWindow; forward;
  procedure SetStatus(StatusId : DWORD); forward;

var
   hInst : HWND;             // handle to program (hinstance)
   MainWinHandle : HWND;     // handle to main window
   MainProcId : DWORD;
   MainThreadId : DWORD;
   DriveThreadId : DWORD = 0;
   FakeWinHandle : HWND = 0; // handle to fake Winamp window
   VisDLLHandle : THandle = 0;
   VisWinHandle : HWND = 0;  // handle to visualizer
   VisDataPointer : pointer;

   PluginName : string;
   LoadedVisDLL : string = '';
   Vismod : TVismod;
   VismodCounter : integer = 0;
   VismodIndex : integer = -1;

   OldWindowProc: Pointer;
   MsgHandle : HWND;
   DataReadyMsg : HWND;
   EndByProgram : boolean;

   PlayerMode : TPlayerMode = plmStandby;
   ChannelAttrb : TChannelAttrb;
   SyncWithMain : boolean;
   SongPosition : DWORD = 0;

   VisModuleInfo : TVisModuleInfo;
   VisDriveThreadInfo : TVisDriveThreadInfo;
   GoRendering : boolean;
   VisualizerQuitted : boolean;

   getVisHeader2 : function : pointer; stdcall;

procedure PopUpMainWindow;
var
   WinHwnd : HWND;
   BaseWindowHandle : HWND;
   ProcId : DWORD;
   ClassName : array[0..255] of Char;
begin
 // get the handle of the window laid just below visualizer
   BaseWindowHandle := VisWinHandle;
   repeat
      WinHwnd := GetWindow(BaseWindowHandle, GW_HWNDNEXT);
      BaseWindowHandle := WinHwnd;             // for next iteration
      if WinHwnd <> 0 then
         if IsWindowVisible(WinHwnd) then
            if not IsIconic(WinHwnd) then
            begin
               GetClassName(WinHwnd, ClassName, SizeOf(ClassName));
               if string(ClassName) <> 'TApplication' then
                  break;
            end;
   until (WinHwnd = 0);

   if WinHwnd <> 0 then  // found a window
   begin
      GetWindowThreadProcessId(WinHwnd, @ProcId); // get the process Id.
      if ProcId = MainProcId then   // Is it Main program's process Id. ?
         exit;
   end else
      exit;


  // get the handle of a main program's window
   repeat
      BaseWindowHandle := WinHwnd;    // for next iteration
      WinHwnd := GetWindow(BaseWindowHandle, GW_HWNDNEXT);
      if WinHwnd <> 0 then
         if IsWindowVisible(WinHwnd) then
            if not IsIconic(WinHwnd) then
            begin
               GetClassName(WinHwnd, ClassName, SizeOf(ClassName));
               if string(ClassName) <> 'TApplication' then
               begin
                  GetWindowThreadProcessId(WinHwnd, @ProcId);
                  if ProcId = MainProcId then  // Is it main program's process Id. ?
                     break;
               end;
            end;
   until (WinHwnd = 0);

   if WinHwnd = 0 then
      exit;

 // Put the windows of main program just below the visualizer
   SetWindowPos(WinHwnd, VisWinHandle, 0, 0, 0, 0,
                                          SWP_NOACTIVATE+SWP_NOMOVE+SWP_NOSIZE);
end;

function NewWindowProc(WindowHandle: hWnd; TheMessage: DWORD;
  ParamW: WParam; ParamL: LParam): longInt; stdcall;
var
   BaseWindowHandle, WinHwnd : HWND;
   ProcId : DWORD;
begin
  // Following message handling is to set up synchronized action between the windows of
  // main program and the one of vis plug-in for the case that visualizer gets
  // focus, hides or shows.

  // Put the windows of main program just below the visualizer when visualizer gets focus.
   if (TheMessage = WM_ACTIVATEAPP) then
   begin
      if (ParamW <> 0) and SyncWithMain then
      begin
         PopUpMainWindow;
         NewWindowProc := 0;  // Exit here
         exit;
      end;
   end else

 // Restore(=minimized state to normal state) the windows of main program when visualizer
 // restores.
   if (TheMessage = WM_SIZE) then
   begin
      if (ParamW = SIZE_RESTORED) and SyncWithMain  then
      begin
         WinHwnd := GetWindow(MainWinHandle, GW_HWNDFIRST);

      // main program may have several visible windows so investigate every visible
      // windows and restores it if its owner is main program.
         repeat
            BaseWindowHandle := WinHwnd;
            WinHwnd := GetWindow(BaseWindowHandle, GW_HWNDNEXT);
            GetWindowThreadProcessId(WinHwnd, @ProcId);
            if ProcId = MainProcId then
               if IsWindowVisible(WinHwnd) then
                  if IsIconic(WinHwnd) then
                     ShowWindow(WinHwnd, SW_RESTORE);
         until (WinHwnd = 0);

      end;
   end else if (TheMessage = WM_WINDOWPOSCHANGING) then
      GoRendering := false
   else if (TheMessage = WM_WINDOWPOSCHANGED) then
      GoRendering := true
   else if (TheMessage = WM_DESTROY) then
   begin
      PostMessage(MsgHandle, DataReadyMsg, EndVisOut, 0);
      if not EndByProgram then
      begin
         VisualizerQuitted := true;
      // Inform message handlers that visualizer is closed
         PostThreadMessage(DriveThreadId, WM_QUIT, 0, 0);
      end;
   end;

 // Call the original Window procedure
   NewWindowProc := CallWindowProc(OldWindowProc, WindowHandle, TheMessage,
                                         ParamW, ParamL);
end;

// This WindowProc function processes some essential Winamp IPC messages sent from
// visualization plug-in to fake Winamp window, to deceive visualization plug-ins
// as if the cooperator of them(= visualization plug-ins) is Winamp ver 2.4.
// See Winamp_IPC.txt for Winamp IPC messages.
function WindowProc(hWnd, Msg, wParam, lParam : Longint) : Longint; stdcall;
var
   TitleP : pchar;
begin
   Result := 0;  // Put default value

   if Msg = WM_WA_IPC then
   begin
      if LParam = IPC_GETVERSION then
         Result := $2040    // acts as if the main program is Winamp ver 2.4
      else if LParam = IPC_ISPLAYING then
      begin
         if PlayerMode = plmPlaying then
            Result := 1
         else if PlayerMode = plmPaused then
            Result := 3
         else
            Result := 0;
      end else if LParam = IPC_GETINFO then
      begin
         if WParam = 0 then           // Sample rate
            Result := ChannelAttrb.SampleRate
         else if WParam = 1 then      // Bit rate
            Result := ChannelAttrb.BitRate
         else if WParam = 2 then      // Channels
            Result := ChannelAttrb.Channels;
      end
      else if LParam = IPC_GETOUTPUTTIME then
      begin
         if WParam = 0 then      // position in miliseconds
            if PlayerMode <> plmPlaying then
               Result := -1
            else
               Result := SongPosition
         else if WParam = 1 then      // song length in seconds
            Result := ChannelAttrb.Duration div 1000
      end

  // Response to message WM_GETTEXT is to hand over the title of playing stream file to
  // vis plug-in.
  // You must add ' - Winamp' to the title string because some visualization plug-ins
  // show erroneous operation if it is missed (ex. vis_Bass-C.dll)
   end else if Msg = WM_GETTEXT then
   begin
      TitleP := pchar(ChannelAttrb.Title + ' - Winamp' + chr(0));
      Move(TitleP^, (pointer(lParam))^, length(ChannelAttrb.Title)+10);
      Result := length(ChannelAttrb.Title)+10;
   end else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam);

end;

// Create a fake window which acts like the one of Winamp's main window
function CreateFakeWindow : HWND;
var
   WinAtom : TAtom;
   wClass : TWNDCLASSEX;
begin
   if FakeWinHandle <> 0 then   // Avoid duplicate creation of fake Winamp window
   begin
      result := FakeWinHandle;
      exit;
   end;

   hInst := GetModuleHandle(nil); // get the application instance


   with wClass do
   begin
      cbSize        := sizeof(wClass);
      Style         := CS_PARENTDC {or CS_VREDRAW};
      lpfnWndProc   := @WindowProc;
      cbClsExtra    := 0;
      cbWndExtra    := 0;
      hInstance     := hInst;
      hIcon         := 0{LoadIcon(hInst, 'MAINICON')};;
      hCursor       := LoadCursor(0, IDC_ARROW);
      hbrBackground := COLOR_BTNFACE + 1;
      lpszMenuName  := nil;
      lpszClassName := 'Winamp v1.x';
      hIconSm       := 0;
   end;

  // Once our class is registered we can start making windows with it
   WinAtom := windows.RegisterClassEx(wClass);

   if WinAtom <> 0 then
      result := CreateWindowEx(0, 'Winamp v1.x', 'Winamp 2.40',
                                  WS_POPUP,      // no-frame, non-visible window
                                  5, 5, 25, 25,  // x, y, width, height
                                  MainWinHandle, 0, hInst, nil)
   else
      result := 0;
end;

function DestroyFakeWindow : boolean;
begin
   if FakeWinHandle <> 0 then
   begin
      result := DestroyWindow(FakeWinHandle); 	// handle to window to be destroyed
      if result then
      begin
         FakeWinHandle := 0;
         windows.UnRegisterClass('Winamp v1.x', hInst);
      end;
   end else
      result := false;
end;

function UnloadVisModule2 : integer;
var
   i : integer;
begin
   result := -1;
   if VismodCounter = 0 then
      exit;

  { if IsWindow(VisWinHandle) then
      if not VisualizerQuitted then }
         if Vismod[VismodIndex] <> nil then
            Vismod[VismodIndex]^.Quit(Vismod[VismodIndex]);

   getVisHeader2 := nil;
   if VisDLLHandle <> 0 then
   begin
      FreeLibrary(VisDLLHandle);
      VisDLLHandle := 0;
      LoadedVisDLL := '';
   end;

   for i := 0 to (maxVismodNum - 1) do
      Vismod[i] := nil;
   VismodCounter := 0;
   VisWinHandle := 0;
   VismodIndex := -1;
   result := 0;
end;

procedure LoadVisModule2(PluginName : string;
                         var Vismod : TVismod;
                         var NumVismod : integer;
                         ParentHandle : HWND);
var
   i : integer;
   Visheader : PWinampVisHeader;
begin
   NumVismod := 0;
   getVisHeader2 := nil;

   if VisDLLHandle <> 0 then
      UnloadVisModule2;
   VisDLLHandle := LoadLibrary(pchar(PluginName));
   if (VisDLLHandle = 0) then
   begin
     MessageBox(MainWinHandle, _('Failed loading vis module'), _('Error'), MB_OK or MB_ICONERROR);
     exit;
   end;

   getVisHeader2 := GetProcAddress(VisDLLHandle, 'winampVisGetHeader');
   if @getVisHeader2 <> nil then
   begin
      LoadedVisDLL := PluginName;
   end else
   begin   // Unload if not a valid Vis module
      FreeLibrary(VisDLLHandle);
      VisDLLHandle := 0;
   end;

   Visheader := getVisHeader2;
   if VisHeader = nil then
      exit;

   for i := 0 to (maxVismodNum - 1) do
   begin
      Vismod[i] := Visheader.getModule(i);
      if Vismod[i] <> nil then
      begin
         Vismod[i]^.hwndParent := ParentHandle;
         Vismod[i]^.hDllInstance := VisDLLHandle;
         inc(NumVismod);
      end else
         break;
   end;
   VismodIndex := -1;
end;


function StartVisModule2(ModuleNum : word) : integer;
begin
   if VismodCounter = 0 then
   begin
      result := -1;
      exit;
   end;
   if (ModuleNum > VismodCounter - 1) then
   begin
      result := -2;
      exit;
   end;
   if VismodIndex = ModuleNum then
   begin
      result := -3;
      exit;
   end;

   if VismodIndex > -1 then
      if Vismod[VismodIndex] <> nil then
         Vismod[VismodIndex]^.Quit(Vismod[VismodIndex]);

   VismodIndex := ModuleNum;
   Vismod[VismodIndex]^.sRate := ChannelAttrb.SampleRate;
   Vismod[VismodIndex]^.nCh := ChannelAttrb.Channels;
   result := Vismod[VismodIndex]^.init(Vismod[VismodIndex]);
end;

function LookAtAllWindows(Handle: HWnd; Temp: Longint): BOOL; stdcall;
var
   ThreadId : DWORD;
   ProcId : DWORD;
begin
   result := true;

   if IsWindowVisible(Handle) then
   begin
   // get identifier of the thread which created window
      ThreadId := GetWindowThreadProcessId(Handle, @ProcId);
      if ThreadId = DriveThreadId then
      begin
         if Handle <> FakeWinHandle then
         begin
            VisWinHandle := Handle;
            result := false;
         end;
      end else
  // I have found that dwVis_hThreadId is different from the creator's for some plug-ins
  // Check again with identifier of the processor which created the threads
      if ProcId = MainProcId then
      begin
         if ThreadId <> MainThreadId then
            if Handle <> FakeWinHandle then
            begin
               VisWinHandle := Handle;
               result := false;
            end;
      end;
   end;
end;

procedure RenderToVis;
var
   p1 : PDWORD;
   p2 : PBYTE;
   RenderResult : integer;
begin
   if EndByProgram or VisualizerQuitted then
      exit;
  { if not GoRendering then
      exit; }

   p1 := VisDataPointer;
   inc(p1, 70{=280/4}); // Flag information is stored at byte offset 280 ~ 283.
   if p1^ = 0 then      // New data is not given ?
      exit;

   inc(p1, 1);
   Vismod[VismodIndex]^.sRate := p1^;
   inc(p1, 1);
   Vismod[VismodIndex]^.nCh := p1^;
   inc(p1, 1);
   SongPosition := p1^;
   inc(p1, 1);

   p2 := pointer(p1);

   if VisModuleInfo.spectrumNch > 0 then
   begin
      Move(p2^, Vismod[VismodIndex]^.SpectrumData[1, 1], 576);
      inc(p2, 576);

      if VisModuleInfo.spectrumNch > 1 then
      begin
        Move(p2^, Vismod[VismodIndex]^.SpectrumData[2, 1], 576);
         inc(p2, 576);
      end;
   end;

   if VisModuleInfo.waveformNch > 0 then
   begin
      Move(p2^, Vismod[VismodIndex]^.waveformData[1, 1], 576);
      inc(p2, 576);

      if VisModuleInfo.waveformNch > 1 then
         Move(p2^, Vismod[VismodIndex]^.waveformData[2, 1], 576);
   end;

  { try }
     RenderResult := Vismod[VismodIndex].Render(Vismod[VismodIndex]);
  { except
   // Neglect some kind of exceptions
     on E: EMathError do RenderResult := 0;
     else
        Application.HandleException(Self);
   end; }

   if RenderResult <> 0 then
   begin
      Vismod[VismodIndex].Quit(Vismod[VismodIndex]);
      VisualizerQuitted := true;
   end;

   p1 := VisDataPointer;
   inc(p1, 70);
   try
     p1^ := 0;    // Reset flag to notify that rendering is completed.
   except
   end;  
end;

function VisNewThread(lpParam : pointer) : DWORD; stdcall;
var
   VisModNum : integer;
   MsgReturn : longbool;
   Msg : TMsg;
   RepeatCounter : integer;
begin
  Result:=0;
   GoRendering := false;
   FakeWinHandle := CreateFakeWindow;
   if (FakeWinHandle = 0) then  // if failed to create fake window(= window to emulate Winamp)
   begin
    // Inform main thread that vis-drive-thread failed to create fake window.
      PostMessage(MsgHandle, DataReadyMsg, StartVisOut, 0);
      DriveThreadId := 0;
    //  EndThread(0);
      ExitThread(0);
   end;

   VisModNum := integer(lpParam);
   SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_BELOW_NORMAL{THREAD_PRIORITY_LOWEST});
   LoadVisModule2(PluginName, Vismod, VismodCounter, FakeWinHandle);
   if (VismodCounter > 0) and (VisModNum >= 0) and (VisModNum < VismodCounter) then
   begin
     VisModuleInfo.delayMs := Vismod[VisModNum]^.delayMs;
     VisModuleInfo.latencyMs := Vismod[VisModNum]^.latencyMs;
     VisModuleInfo.spectrumNch := Vismod[VisModNum]^.spectrumNch;
     VisModuleInfo.waveformNch := Vismod[VisModNum]^.waveformNch;
     PostMessage(MsgHandle, DataReadyMsg, VisModuleLoaded, DWORD(@VisModuleInfo));
     if StartVisModule2(VisModNum) = 0 then
     begin
        RepeatCounter := 0;

      // Wait until vis window is created
        repeat
           EnumWindows(@LookAtAllWindows, 0);
           if VisWinHandle <> 0 then
           begin
              VisualizerQuitted := false;
              GoRendering := true;
              VisDriveThreadInfo.ThreadId := DriveThreadId;
              VisDriveThreadInfo.VisWinHandle := VisWinHandle;
          // Inform main thread that the vis module has been launched successfully.
              PostMessage(MsgHandle, DataReadyMsg, StartVisOut, DWORD(@VisDriveThreadInfo));
              OldWindowProc := Pointer(SetWindowLong(VisWinHandle, GWL_WNDPROC,
                                                       LongInt(@NewWindowProc)));
           end;
           sleep(50);
           WinProcessMessages;
           inc(RepeatCounter);
        until (VisWinHandle <> 0) or (RepeatCounter = 100);

        if (VisWinHandle <> 0) then   // if vis window is created.
        begin
           EndByProgram := false;

           repeat
             MsgReturn := GetMessage(Msg, 0, 0, 0);
             if ((Msg.message = WM_QUIT) or (Msg.message = WM_CLOSE)) then
                VisualizerQuitted := true
             else if Msg.message = DataReadyMsg then
             begin
               case Msg.wParam of
                 DataReady : RenderToVis;
                 MinimizeWindow : HideVisWindow;
                 RestoreWindow : ShowVisWindow;
                 InformPlayerMode..InformSyncWindows : SetStatus(Msg.wParam);
               end;
               Continue;
             end;

             TranslateMessage(Msg);
             DispatchMessage(Msg);
           until (integer(MsgReturn) <= 0) or VisualizerQuitted;

        end else // vis window is not created
           PostMessage(MsgHandle, DataReadyMsg, StartVisOut, 0);
     end else    // Failed to launch vis module
        PostMessage(MsgHandle, DataReadyMsg, StartVisOut, 0);
   end else      // Failed to load vis module
     PostMessage(MsgHandle, DataReadyMsg, StartVisOut, 0);

   UnloadVisModule2;
   DestroyFakeWindow;
   DriveThreadId := 0;
 //  EndThread(0);
   ExitThread(0);
end;


procedure Start_Vis(VisPlugin : string; MainWin, MessageHandle, StatusMsg : HWND;
                    ShareMemPointer : pointer;
                    ModuleNum : integer; SyncMain : boolean;
                    PlayerModeId : integer; ChannelIs : TChannelAttrb{; FakeWin : HWND});
var
   ThreadHandle : HWND;
begin
   if (VisPlugin <> '') and (ModuleNum >= 0) then
   begin
      if DriveThreadId <> 0 then
         Stop_Vis;

      MainWinHandle := MainWin;
      MsgHandle := MessageHandle;
      DataReadyMsg := StatusMsg;
      VisDataPointer := ShareMemPointer;
      MainThreadId := GetWindowThreadProcessId(MainWinHandle, @MainProcId);

      PluginName := VisPlugin;
      SyncWithMain := SyncMain;
      case PlayerModeId of
        0 : PlayerMode := plmStandby;
        1 : PlayerMode := plmReady;
        2 : PlayerMode := plmStopped;
        3 : PlayerMode := plmPlaying;
        4 : PlayerMode := plmPaused;
      end;
      ChannelAttrb := ChannelIs;
   //   FakeWinHandle := FakeWin;

   // "BeginThread" invokes system error when floating point exception is occured by vis module
   //   ThreadHandle := BeginThread(nil, 0, @VisNewThread, pointer(ModuleNum), 0, VisDriveThreadId);
      ThreadHandle := CreateThread(nil, 0, @VisNewThread, pointer(ModuleNum), 0, DriveThreadId);
      if ThreadHandle <> 0 then
         CloseHandle(ThreadHandle)
      else
         MessageBox(MainWinHandle, _('Unable to create thread !'), _('Error!'), MB_ICONEXCLAMATION or MB_ICONWARNING);
   end;
end;

procedure Stop_Vis;
begin
   EndByProgram := true;
   if (DriveThreadId <> 0) then
   begin
      PostThreadMessage(DriveThreadId, WM_QUIT, 0, 0);

      repeat
         Sleep(50);
         WinProcessMessages;
      until DriveThreadId = 0;
   end;
end;

// Nearly same as Stop_Vis. Why is this needed ?
// I have gotton an error with Stop_vis, if I run demo program as follows.
//  - Run demo program then play a song.
//  - Run vis plug-in.
//  - (while a song is being played and vis plug-in is running) log off or shut down system.
// So I have decided to use Stop_Vis2 instead of Stop_Vis when an instance of TBASSPlayer
//  is destroyed.
procedure Stop_Vis2;
begin
   EndByProgram := true;
   if (DriveThreadId <> 0) then
      PostThreadMessage(DriveThreadId, WM_QUIT, 0, 0);
end;

procedure HideVisWindow;
begin
   CloseWindow(VisWinHandle);
end;

procedure ShowVisWindow;
begin
   if IsIconic(VisWinHandle) then
      OpenIcon(VisWinHandle);
end;


procedure SetStatus(StatusId : DWORD);
var
   p1 : PDWORD;
   p2 : PBYTE;
   ModeNum : DWORD;
   TitleBuf : array[0..255] of char;
begin
   p1 := VisDataPointer;

   if StatusId = InformPlayerMode then
   begin
      ModeNum := p1^;
      case ModeNum of
         0 : PlayerMode := plmStandby;
         1 : PlayerMode := plmReady;
         2 : PlayerMode := plmStopped;
         3 : PlayerMode := plmPlaying;
         4 : PlayerMode := plmPaused;
         else
            PlayerMode := plmStandby;
      end;
   end else if StatusId = InformStreamInfo then
   begin
      inc(p1, 1);
      ChannelAttrb.SampleRate := p1^;
      inc(p1, 1);
      ChannelAttrb.BitRate := p1^;
      inc(p1, 1);
      ChannelAttrb.Channels := p1^;
      inc(p1, 1);
      ChannelAttrb.Duration := p1^;
      inc(p1, 1);
      p2 := pointer(p1);
      move(p2^, TitleBuf, 256);
      ChannelAttrb.Title := StrPas(TitleBuf);
   end else if StatusId = InformSyncWindows then
   begin
      inc(p1, 69);
      if p1^ = 0 then
         SyncWithMain := false
      else
         SyncWithMain := true;
   end;

end;

end.
