{******************************************************************************}
{                                                                              }
{ Ur-Autor: Silhwan Hyun hsh@chollian.net (Version 1.0)                        }
{                                                                              }
{ Edit to Version B.3.1 by omata (Thorsten) - http://www.delphipraxis.net      }
{                                                                              }
{******************************************************************************}
unit VisPluginCtrl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, ExtCtrls, PluginCtrl, BassChannelU, VisDataThreadU,
  BassDynamicU, BassTypenU, VisDrive;

type
  TVisControlForm = class(TForm)
    PluginList: TListBox;
    btnConfigure: TButton;
    Label3: TLabel;
    btnStart: TButton;
    Descript: TEdit;
    Label2: TLabel;
    btnStop: TButton;
    VisModules: TStringGrid;
    btnClose: TButton;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure PluginListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfigureClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    _Vismod : TVismod;
    _IndexNum,
    _NumVismod : integer;
    _BassChannel:TBassChannel;
    _VisDataThread:TVisDataThread;
    _DataReadyMsg : hwnd;
    _ShareMemPointer : pointer;
    _MessageHandle : hwnd;
    _VisWindowHandle : HWND;
    _AppHWND     : THandle;
    _ParentHWND  : HWND;
    _SyncVisWindow : boolean;
    _GoVisOut : boolean;
    _WaitingVisualizer : boolean;
    procedure GetPluginInfo;
    procedure ProcMessage(var Msg: TMessage);

    procedure Schalter_aktualisieren;
  public
    { Public declarations }
    constructor create(AOwner:TComponent; BassDll:TBassDll); reintroduce;
    destructor destroy; override;
    procedure SetBassChannel(BassChannel:TBassChannel; mustSet:boolean);
    function RunVisPlugin(VismodName : string; VismodNo : word) : boolean;
    procedure QuitVisPlugin;
    property SyncVisWindow:boolean read _SyncVisWindow write _SyncVisWindow;
  end;

var
  VisControlForm: TVisControlForm;

implementation

{$R *.DFM}

uses ioPlug;

procedure TVisControlForm.GetPluginInfo;
var PluginName : string;
    Visheader : PWinampVisHeader;
    i : integer;
begin
  _IndexNum := PluginList.ItemIndex;
  PluginName := GetProgDir + 'Plugins\' + PluginList.Items[_IndexNum];
  LoadVisModule(PluginName, Visheader, _Vismod, _NumVismod, 0);
  if _NumVismod <> 0 then begin
    Descript.Text := string(Visheader^.description);
    VisModules.RowCount := _NumVismod;
    for i := 1 to _NumVismod do
      VisModules.Cells[0, i-1] := _Vismod[i-1].description;
  end;
end;

procedure TVisControlForm.FormShow(Sender: TObject);
var SearchRec : TSearchRec;
begin
  _IndexNum := -1;
  _NumVismod := 0;
  PluginList.Clear;

  if FindFirst(GetProgDir + 'Plugins\vis_*.dll', 0, SearchRec) = 0 then begin
    PluginList.Items.Add(SearchRec.Name);
    while FindNext(SearchRec) = 0 do
      PluginList.Items.Add(SearchRec.Name);
  end;
  FindClose(SearchRec);

  if PluginList.Items.Count > 0 then begin
    PluginList.ItemIndex := 0;
    GetPluginInfo;
  end
  else begin
    Descript.Text := '';
    VisModules.RowCount := 0;
  end;
  Schalter_aktualisieren;
end;

procedure TVisControlForm.PluginListClick(Sender: TObject);
begin
  if PluginList.ItemIndex <> _IndexNum then begin
    UnloadVisModule;
    GetPluginInfo;
  end;
end;

procedure TVisControlForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  QuitVisPlugin;
  UnloadVisModule;
end;

procedure TVisControlForm.btnConfigureClick(Sender: TObject);
var NewSelection : TGridRect;
    PluginName : string;
    Visheader : PWinampVisHeader;
begin
  // Reload vis plug-in if it is released.
  if _NumVismod = 0 then
    if PluginList.Items.Count > 0 then begin
      _IndexNum := PluginList.ItemIndex;
      PluginName := GetProgDir + 'Plugins\' + PluginList.Items[_IndexNum];
      LoadVisModule(PluginName, Visheader, _Vismod, _NumVismod, 0);
      if _NumVismod = 0 then
        exit;
    end
    else exit;

  NewSelection := VisModules.Selection;
  if NewSelection.Top > (_NumVismod - 1) then
    exit;

  btnConfigure.Enabled:=false;
  try
    _Vismod[NewSelection.Top].Config(_Vismod[NewSelection.Top]);
  finally
    btnConfigure.Enabled:=true;
  end;
end;

procedure TVisControlForm.btnStartClick(Sender: TObject);
begin
  UnloadVisModule;
  _NumVismod := 0;
  RunVisPlugin(
    GetProgDir + 'Plugins\' + PluginList.Items[_IndexNum], VisModules.Selection.Top
  );
end;

procedure TVisControlForm.btnStopClick(Sender: TObject);
begin
  QuitVisPlugin;
end;

procedure TVisControlForm.btnCloseClick(Sender: TObject);
begin
  close;
end;

constructor TVisControlForm.create(AOwner: TComponent; BassDll:TBassDll);
begin
  inherited create(AOwner);
  _BassChannel:=nil;
  _VisDataThread:=TVisDataThread.Create(_DataReadyMsg, _ShareMemPointer, BassDll);
  _MessageHandle := AllocateHWnd(ProcMessage);
  _AppHWND := Application.Handle;
  _ParentHWND := (AOwner as TWinControl).Handle;
  if _VisDataThread.Ready then
    _VisDataThread.SetVisScale(512);
  Schalter_aktualisieren;
end;

procedure TVisControlForm.SetBassChannel(BassChannel: TBassChannel; mustSet:boolean);
begin
  if mustSet then begin
    _BassChannel:=BassChannel;
    _VisDataThread.SetChannelInfo(BassChannel.Channel, 0, 2);
  end
  else begin
    if not assigned(_BassChannel) then begin
      _BassChannel:=BassChannel;
      _VisDataThread.SetChannelInfo(BassChannel.Channel, 0, 2);
    end
    else begin
      if     (_BassChannel.Channel <> BassChannel.Channel)
         and (BassChannel.Status = sndPlaying) then
      begin
        _BassChannel:=BassChannel;
        _VisDataThread.SetChannelInfo(BassChannel.Channel, 0, 2);
      end;
    end;
  end;
  Schalter_aktualisieren;
end;

procedure TVisControlForm.ProcMessage(var Msg: TMessage);
var
   PVisModuleInfo : ^TVisModuleInfo;
   PDriveThreadInfo : ^TVisDriveThreadInfo;
(*   PChannelInfo : ^TChannelInfo;
   PTitle : PChar;
   ExtCode : string;
   TagP : pchar;
   TagVer : word;
   MP3Tag : MP3TagRec;
   PlaybackSec : float;
   _title : array[0..255] of char;
   _length_in_ms : integer;*)
begin
   if Msg.Msg = _DataReadyMsg then   // message is from vis plug-in driver ?
   begin
      if Msg.wParam = VisModuleLoaded then      // vis plug-in loaded ?
      begin
         if _VisDataThread.UseExtDriver then
            PVisModuleInfo := _ShareMemPointer
         else
            PVisModuleInfo := pointer(Msg.lParam);
         _VisDataThread.SetVisModuleInfo(PVisModuleInfo^);
      end else if Msg.wParam = StartVisOut then // vis plug-in started ?
      begin
         if Msg.lParam <> 0 then
         begin
            if _VisDataThread.UseExtDriver then
            begin
               _VisWindowHandle := Msg.lParam;
               _VisDataThread.fisSharedMemory.TargetApplication := 'VisOut';
            end else
            begin
               PDriveThreadInfo := pointer(Msg.lParam);
               _VisDataThread.SetDriveThreadId(PDriveThreadInfo^.ThreadId);
               _VisWindowHandle := PDriveThreadInfo^.VisWinHandle;
            end;

            _GoVisOut := true;
            if (_BassChannel.Status  = sndPlaying) and _VisDataThread.Suspended then
               _VisDataThread.ResumeVis;
         end;
         _WaitingVisualizer := false;
      end else
      if Msg.wParam = EndVisOut then       // vis plug-in ended ?
      begin
         _VisWindowHandle := 0;
         _GoVisOut := false;
         if not _VisDataThread.Suspended then
            _VisDataThread.Suspend;
      end {else
      if Msg.wParam = QueryStatus then      // query from driver of vis plug-in ?
      begin
         if Msg.lParam = stPlayerMode then
            InformPlayerStatus(stPlayerMode)
         else if Msg.lParam = stStreamInfo then
            InformPlayerStatus(stStreamInfo)
         else if Msg.lParam = stSyncWindows then
            InformPlayerStatus(stSyncWindows);
      end};

      exit;
   end;

(*
   case Msg.Msg of
      WM_NewFFTData    : if Assigned(FOnNewFFTData) then
                            FOnNewFFTData(Self, BandOut);
      WM_GetMeta       : begin     // BASS received Metadata in a Shoutcast stream
                            PTitle := pointer(Msg.lParam);
                            FStreamInfo.Title := string(PTitle);
                            InformPlayerStatus(stStreamInfo);
                            if Assigned(OnGetMeta) then
                               FOnGetMeta(Self, FStreamInfo.Title);
                         end;
      WM_DownLoaded    : begin     // BASS finished download of an internet stream
                            FDownloaded := true;
                            ExtCode := UpperCase(ExtractFileExt(FStreamName));
                            if (ExtCode = '.MP3') or (ExtCode = '.MP2') or (ExtCode = '.MP1') then
                            begin
                               TagP := BASS_StreamGetTags(DecodeChannel, BASS_TAG_ID3);
                               if TagP = nil then
                               begin
                                  TagP := BASS_StreamGetTags(DecodeChannel, BASS_TAG_ID3V2);
                                  if TagP = nil then
                                     TagVer := 0
                                  else
                                     TagVer := 2;
                               end else
                                  TagVer := 1;
                            end else
                               TagVer := 0;

                            FStreamInfo.FileSize := BASS_StreamGetFilePosition(DecodeChannel, BASS_FILEPOS_END);

                            if (TagVer = 1) or (TagVer = 2) then
                              if MPEG.ReadFromTagStream(TagP, FStreamInfo.FileSize, TagVer, MP3Tag) then
                                 with FStreamInfo do
                                 begin
                                    Title := MP3Tag.Title;
                                    Artist := MP3Tag.Artist;
                                    Album := MP3Tag.Album;
                                    Year := MP3Tag.Year;
                                    Genre := MP3Tag.Genre;
                                    Track := MP3Tag.Track;
                                    Comment := MP3Tag.Comment;
                                 end;

                         // Now we can get the exact playback length of an internet stream after finishing download.
                            PlaybackSec := BASS_ChannelBytes2Seconds(DecodeChannel, BASS_StreamGetLength(DecodeChannel));
                            FStreamInfo.Duration := round(1000 * PlaybackSec);  // in mili seconds
                            if Assigned(OnDownloaded) then
                               FOnDownloaded(Self, IntToStr(FStreamInfo.Duration));
                         end;

      WM_BASS_StreamCreate : PlayChannel := Msg.WParam;  // Message from output plug-in emulator
      WM_GetChannelInfo : begin    // The basic characteristics of a stream to be played
                                   // are received from Winamp input plug-in.
                            PChannelInfo := pointer(Msg.lParam);
                            FStreamInfo.Channels := PChannelInfo^.Channels;
                            FStreamInfo.SampleRate := PChannelInfo^.SampleRate;
                            FStreamInfo.BitRate := PChannelInfo^.BitRate;
                            if Assigned(OnGetChannelInfo) then
                               FOnGetChannelInfo(Self, pointer(Msg.lParam));
                         end;
   // We do not know the Channels & SampleRate of opened stream file before Winamp
   // input plug-in informs to output plug-in, if the file type is the one which is
   // supported only by Winamp input plug-in.
   // WM_StartPlay message is used to receive the Channels & SampleRate of opened
   // stream file at starting playback from output plug-in emulator.
   // We still cannot know the Channels & SampleRate of opened stream file if its related
   // Winamp input plug-in is the type which directly sound out (= not thru output plug-in emulator).
      WM_StartPlay     : begin             // Message from output plug-in emulator
                        //    BASS_ChannelPlay(PlayChannel, true);
                            NowStarting := false;
                            UsesOutputPlugin := true;
                            APlugin.SetVolume(FOutputVolume);
                            PChannelInfo := pointer(Msg.lParam);
                            FStreamInfo.Channels := PChannelInfo^.Channels;
                            FStreamInfo.SampleRate := PChannelInfo^.SampleRate;
                            FStreamInfo.BitsPerSample := PChannelInfo^.BitsPerSample;
                            if FStreamInfo.Duration = 0 then  // for internet stream
                            begin
                           //    FStreamInfo.Duration := APlugin.GetLength;
                               APlugin.GetFileInfo(nil, _title, _length_in_ms);
                               if (_length_in_ms > 0) then
                               begin
                                  with FStreamInfo do
                                  begin
                                    Title := string( _title);
                                    Duration := _length_in_ms;
                                  end;
                               end;
                            end;
                            InformPlayerStatus(stStreamInfo);
                            if Assigned(OnPluginStartPlay) then
                               FOnPluginStartPlay(Self, pointer(Msg.lParam));
                            VisDataThread.SetChannelInfo(PlayChannel,
                                                         FStreamInfo.SampleRate,
                                                         FStreamInfo.Channels);
                            SetSoundEffect(FSoundEffects);
                            if Assigned(FOnNewFFTData) then
                               TimerFFT.Enabled := true;
                         end;
      WM_WA_MPEG_EOF   : begin           // Winamp input plug-in reached the end of stream
                            SetReachedEnd;
                            NowStarting := false;
                            if UsesOutputPlugin then
                               while BASS_ChannelIsActive(PlayChannel) = BASS_ACTIVE_PLAYING do
                               begin
                                  WinProcessMessages;
                                  sleep(50);
                               end;

                            APlugin.Stop;
                            PlayChannel := 0;
                            ClearEffectHandle;
                            SetPlayerMode(plmStopped);
                            if Assigned(FOnPlayEnd) then
                               FOnPlayEnd(Self);
                         end;

    //  Use of WM_BASS_StreamFree may cause problem because of reset PlayChannel after set by opening playing channel
    //  WM_BASS_StreamFree   : PlayChannel := 0;        // Message from output plug-in emulator

    //  WM_GetChannelData : omodWrite2;                // message requesting sample data for BASS playing channel
      WM_GetToEnd      : begin                       // BASS reached the end of stream
                            SetPlayerMode(plmStopped);
                            while BASS_ChannelIsActive(PlayChannel) = BASS_ACTIVE_PLAYING do
                            begin
                               WinProcessMessages;
                               sleep(50);
                            end;
                            if Assigned(FOnPlayEnd) then
                               FOnPlayEnd(Self);
                         end;

      WM_PluginFirst_Changed : if Msg.lParam = 0 then  // Message from PluginConfigForm
                                  FPluginFirst := false
                               else
                                  FPluginFirst := true;

      WM_QueryEndSession : begin
            // TimerFFT should be disabled soon after receiving WM_QueryEndSession
            // message to prevent problems at log off or shut down system.
                              TimerFFT.Enabled := false;
                              Msg.Result := 1;    // Allow system termination
                           end;
   end;*)
end;

destructor TVisControlForm.destroy;
begin
  Stop_Vis;
  _VisDataThread.Terminate;
  _VisDataThread.free;
  DestroyFakeWindow;
  DeallocateHWnd(_MessageHandle);
  inherited;
end;
(*
function TVisControlForm.GetVisWindowHandle: HWND;
begin
  result := _VisWindowHandle;
end;

procedure TVisControlForm.HideVisWindow;
begin
  if _GoVisOut then
    _VisDataThread.InformVisDriver(MinimizeWindow, 0);
end;

procedure TVisControlForm.intQuitVisPlugin;
begin
  if not _VisDataThread.Ready then
    exit;

  _GoVisOut := false;
  if not _VisDataThread.Suspended then
    _VisDataThread.Suspend;

{  if VisDataThread.UseExtDriver then begin
    // Inform "VisOut.exe" that it's time to end
    if FindWindow('TApplication', 'VisOut') <> 0 then
      VisDataThread.InformVisDriver(QuitProg, 0);
  end
  else } Stop_Vis2;

  if _VisWindowHandle <> 0 then
    repeat
      WinProcessMessages;
      sleep(20);
    until _VisWindowHandle = 0;
end;

procedure TVisControlForm.ShowVisWindow;
begin
  if _GoVisOut then
    _VisDataThread.InformVisDriver(RestoreWindow, 0);
end;
*)

procedure TVisControlForm.QuitVisPlugin;
begin
  if not _VisDataThread.Ready then
    exit;

  _GoVisOut := false;
  if not _VisDataThread.Suspended then
    _VisDataThread.Suspend;
(*
  if _VisDataThread.UseExtDriver then begin
    // Inform "VisOut.exe" that it's time to end
    if FindWindow('TApplication', 'VisOut') <> 0 then
      _VisDataThread.InformVisDriver(QuitProg, 0);
  end
  else *) Stop_Vis;

  if _VisWindowHandle <> 0 then
    repeat
      WinProcessMessages;
      sleep(20);
    until _VisWindowHandle = 0;
end;

function TVisControlForm.RunVisPlugin(VismodName: string; VismodNo: word): boolean;
var ProcId : DWORD;
    ChannelIs : TChannelAttrb;
(*    TimerStat : boolean;
    CmdLineStr : string;
    VisOutHandle : HWND;
    SyncWord : word;
    StartupInfo: TStartupInfo;
    BeginPath: PChar;
    ProcessInfo : _PROCESS_INFORMATION;*)
begin
  // Winamp visualization plug-ins are designed to be run in their own user
  // interface thread.
  // I made a program named "VisOut.exe" to run Winamp visualization plug-ins in a
  // seperate process.
  // (Since Ver 1.7) I also have made a sub unit(=VisDrive.pas), which is merged into
  // TBASSPlayer at compile time, which takes charges of running Winamp visualization
  // plug-ins in a seperate thread without using "VisOut.exe".
  // So you can use one of the driving methods of Winamp visualization plug-ins - by
  // internal driver of TBASSPlayer or by external driver(=VisOut.exe).
  // The visualization data are fed to the vis plug-in driver via shared memory
  // regardless of driving method.

  result := false;

(*  if not VisDataThread.Ready then begin
    ShowErrorMsgBox('Cannot run Winamp visualization plug-ins');
    exit;
  end;*)

  if not FileExists(VismodName) then begin
(*    ShowErrorMsgBox('Specified visualization plug-in does not exist'); *)
    exit;
  end;

(*  if WaitingVisualizer then   // prohibit duplicate request to run vis plug-in
    exit;
*)
  if _VisWindowHandle <> 0 then
    if IsWindow(_VisWindowHandle) then
      QuitVisPlugin;

(*  _VisDataThread.SetExtDriver(FUseExtVisDriver);

  if VisDataThread.UseExtDriver then begin
    VisOutHandle := FindWindow('TApplication', 'VisOut');
    if VisOutHandle <> 0 then begin // VisOut.exe is running ?
      GetWindowThreadProcessId(VisOutHandle, @ProcId); // get process identifier
      if ProcId = VisProcId then  // if VisOut.exe is being run by this program then quit it
        VisDataThread.InformVisDriver(QuitProg, 0)
      else begin
        // Multiple instance of VisOut.exe is not allowed because they will use
        // same address space obtained by fisSharedMemory1.
        ShowErrorMsgBox('Visout.exe is being run by another program');
        exit;
      end;
    end;
  end;

  WaitingVisualizer := true;
  TimerStat := TimerFFT.Enabled;
  TimerFFT.Enabled := false;
*)
  GetWindowThreadProcessId(_AppHWND, @ProcId);
(*
  if VisDataThread.UseExtDriver then begin
    if FSyncVisWindow then
      SyncWord := 1
     else
      SyncWord := 0;

    CmdLineStr := GetProgDir + 'VisOut.exe'
                    + ' "'   + VismodName
                    + '" '   + intToStr(VismodNo)
                    + ' '    + intToStr(int64(ProcId))
                    + ' '    + intToStr(ParentHWND{MainWinHwnd})
                    + ' '    + intToStr(MessageHandle)
                    + ' "'   + FStreamInfo.Title
                    + ' " '  + intToStr(FStreamInfo.Channels)
                    + ' '    + intToStr(FStreamInfo.SampleRate)
                    + ' '    + intToStr(FStreamInfo.BitRate)
                    + ' '    + intToStr(FStreamInfo.Duration)
                    + ' '    + intToStr(ord(FPlayerMode))
                    + ' '    + intToStr(SyncWord);

    FillChar (StartupInfo, Sizeof(StartupInfo), 0);
    StartupInfo.cb := Sizeof(StartupInfo);
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := SW_NORMAL;
    BeginPath := pchar(GetProgDir);
    Result := CreateProcess(nil, pchar(CmdLineStr),
                            nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                            nil, BeginPath, StartupInfo, ProcessInfo);

    if Result then begin
      VisProcId := ProcessInfo.dwProcessId;
      CloseHandle(ProcessInfo.hThread);
      CloseHandle(ProcessInfo.hProcess);
    end
    else ShowErrorMsgBox('Failed to run VisOut.exe');
  end
  else begin
    ChannelIs.Title := FStreamInfo.Title;
    ChannelIs.SampleRate := FStreamInfo.SampleRate;
    ChannelIs.BitRate := FStreamInfo.BitRate;
    ChannelIs.Duration := FStreamInfo.Duration;
    ChannelIs.Channels := FStreamInfo.Channels;*)
    Start_Vis(VismodName, _ParentHWND, _MessageHandle, _DataReadyMsg, _ShareMemPointer,
              VismodNo, _SyncVisWindow, ord(_BassChannel.Modus), ChannelIs);
(*  end;
  TimerFFT.Enabled := TimerStat;*)
end;

procedure TVisControlForm.Schalter_aktualisieren;
begin
  if assigned(_BassChannel) then begin
    btnStart.Enabled:=(_BassChannel.Status <> sndNotLoaded);
    btnStop.Enabled:=(_BassChannel.Status <> sndNotLoaded);
  end
  else begin
    btnStart.Enabled:=false;
    btnStop.Enabled:=false;
  end;
end;

end.
