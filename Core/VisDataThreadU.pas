{******************************************************************************}
{                                                                              }
{ Ur-Autor: Silhwan Hyun hsh@chollian.net (Version 1.0)                        }
{                                                                              }
{ Edit to Version B.3.1 by omata (Thorsten) - http://www.delphipraxis.net      }
{                                                                              }
{******************************************************************************}
unit VisDataThreadU;

interface

uses Classes, Windows, BassTypenU, BassDynamicU, fisSharedMemory, PluginCtrl;

const MaxChannels = 2;

type
  TVisDataThread = class(TThread)
  private
    { Private declarations }
    _BassDll:TBassDll;
    DriveThreadId : DWORD;
    VisTimer : HWND;
    fisSharedMemory1: TfisSharedMemory;
    ModuledelayMs : DWORD;
 //   PseudoSuspended : boolean;

    FThreadReady : boolean;
    FShareMemPointer : pointer;
    FUseExtDriver : boolean;
    FLatencyMs : DWORD;
    FDelayMS : DWORD;
    FDelayMSChanged : boolean;
    FspectrumNch : DWORD;
    FwaveformNch : DWORD;
    FChannelId : DWORD;
    FSampleRate : DWORD;
    FChannels : DWORD;
    FPosition : DWORD;
    FVisScale : word;
    FDataReadyMsg : hwnd;

    SpectrumData: array[0..2047] of float;
    WaveformData: array[0..1152*MaxChannels - 1] of smallint;
    WaitCounter : integer;
    procedure DoOnVisTimer;
  protected
    procedure SetDelayMS(delayMS : DWORD);
    procedure SetPosition(Position : DWORD);
    procedure SetExtDriver(OnOff : boolean);
  //  procedure SuspendVis;
  //  function  IsSuspended : boolean;
    procedure Execute; override;
  public
    constructor Create(var DataReadyMsg : hwnd; var MemPointer : pointer; BassDll:TBassDll);
    destructor  Destroy; override;
    function  Ready : boolean;
    procedure SetVisScale(VisScale : word);
    procedure SetVisModuleInfo(ModuleInfo : TVisModuleInfo);
    procedure SetDriveThreadId(ThreadId : DWORD);
    procedure ResumeVis;
    procedure InformVisDriver(MsgId, DataLength : DWORD);
    procedure SetChannelInfo(ChannelId, SampleRate, Channels : DWORD);

    property fisSharedMemory:TfisSharedMemory read fisSharedMemory1;
    property UseExtDriver : boolean read FUseExtDriver;
  end;

  // A Window API function "SetWaitableTimer" may not be executed normally if your
  // program is compiled with old Delphi versions (V4 and may be V5).
  // Because one of it's parameters is incorrectly declared in Delphi RTL.
  // ("lpDueTime" is declared as const instead of var)
  // So, I decided to use an alternate wrapper function to avoid this RTL bug.
  function MySetWaitableTimer(hTimer: THandle; var lpDueTime: TLargeInteger;
                              lPeriod: Longint; pfnCompletionRoutine: TFNTimerAPCRoutine;
                              lpArgToCompletionRoutine: Pointer; fResume: BOOL): BOOL; stdcall; external 'kernel32.dll' name 'SetWaitableTimer';
  
implementation

{ TVisDataThread }

constructor TVisDataThread.Create(var DataReadyMsg : hwnd; var MemPointer : pointer; BassDll:TBassDll);
begin
  _BassDll:=BassDll;
  FVisScale:=512;
  DriveThreadId := 0;
  // PseudoSuspended := true;
  fisSharedMemory1 := TfisSharedMemory.Create(nil);
  fisSharedMemory1.ShareName := 'VisOutSharedMemory';
  fisSharedMemory1.Size := 2600;
  fisSharedMemory1.TargetApplication := 'VisOut';
  if fisSharedMemory1.CreateMemory then begin
    FShareMemPointer := fisSharedMemory1.MapMemory;
    MemPointer := FShareMemPointer;
    VisTimer := CreateWaitableTimer(nil, false, 'VisTimer');
    if VisTimer <> 0 then begin
      FDataReadyMsg := fisSharedMemory1.SendingDataMsg;
      DataReadyMsg := FDataReadyMsg;
      FDelayMS := 0;
      ModuledelayMs := 0;
      FDelayMSChanged := false;
      FUseExtDriver := false;
      FThreadReady := true;
    end
  end
  else begin
    VisTimer := 0;
    FThreadReady := false;
  end;
  inherited Create(true);
end;

destructor  TVisDataThread.Destroy;
begin
  if VisTimer <> 0 then begin
    // Error occurs if TVisDataThread is terminated during suspended state.
    if not Suspended then
      Terminate;

    CancelWaitableTimer(VisTimer);
    CloseHandle(VisTimer);
  end;

  if FShareMemPointer <> nil then
    fisSharedMemory1.UnMapMemory(FShareMemPointer);
  if fisSharedMemory1 <> nil then
    fisSharedMemory1.CloseMemory;
  fisSharedMemory1.Free;

  inherited Destroy;
end;

function TVisDataThread.Ready : boolean;
begin
  result := FThreadReady;
end;

procedure TVisDataThread.Execute;
const _SECOND = 10000000;
var qwDueTime : int64;
    liDueTime : _LARGE_INTEGER;
begin
  if VisTimer = 0 then
    exit;

  // Create a negative 64-bit integer that will be used to
  // signal the timer 1/4 seconds from now.
  qwDueTime := -1 * (_SECOND div 4);

  // Copy the relative time into a LARGE_INTEGER.
  liDueTime.LowPart  := DWORD(qwDueTime and $FFFFFFFF);
  liDueTime.HighPart := longint(qwDueTime shr 32);
  if MySetWaitableTimer(VisTimer,	// handle to a timer object
                        TLargeInteger(liDueTime),	// when timer will become signaled
                        FDelayMS,	// periodic timer interval
                        nil,	// pointer to the completion routine
                        nil,	// data passed to the completion routine
                        false{flag for resume state}) then
    // Following sentences are repeated every FDelayMS interval all the time from initial
    //  start up to program end.
    repeat
      // We need to re-adjust timer interval according to the parameter "DelayMS" of vis plug-in.
      //  (in case we exchange vis plug-ins)
      if FDelayMSChanged then begin
        FDelayMSChanged := false;
        CancelWaitableTimer(VisTimer);
        MySetWaitableTimer(
          VisTimer,	TLargeInteger(liDueTime),	FDelayMS,	nil, nil, false);
      end;

      if WaitForSingleObject(VisTimer, 1000{1sec}) = WAIT_OBJECT_0 then begin
        //  if not PseudoSuspended then
        DoOnVisTimer
      end
      else Terminate;
    until Terminated
  else begin
(*      ErrMsg := SysErrorMessage(GetLastError);
      ShowErrorMsgBox(ErrMsg);*)
    Terminate;
  end;
end;

procedure TVisDataThread.DoOnVisTimer;
var i : word;
    p1, p3 : ^DWORD;
    p2 : PBYTE;
    BytesValid : DWORD;
begin
  if _BassDll.BASS_ChannelIsActive(FChannelId) <> BASS_ACTIVE_PLAYING then
    exit;

  BytesValid := _BassDll.Bass_ChannelGetdata(FChannelId, nil, BASS_DATA_AVAILABLE);
  if BytesValid < (2048 * FChannels) then
    exit;

  p1 := FShareMemPointer;
  inc(p1, 70); // Flag information is stored at byte offset 280 ~ 283

  // The flag is to be zero when rendering is completed.
  // But it won't be zero in some abnormal cases so I use limited wait cycle to prevent
  //  program from fallng in dead lock.
  if p1^ <> 0 then begin
    WaitCounter := WaitCounter + 1;
    if WaitCounter < 10 then
      exit;
  end;
  WaitCounter := 0;

  p3 := p1;
  inc(p1, 1);
  p1^ := FSampleRate;
  inc(p1, 1);

  // Set number of channels to 2 for multi channel streams.
  if FChannels > 2 then
    p1^ := 2
  else
    p1^ := FChannels;
  inc(p1, 1);
  p1^ := FPosition;
  inc(p1, 1);
  p2 := pointer(p1);

  if FspectrumNch > 0 then begin
    // Perform combined FFT if the value "spectrumNch" of vis is 1.
    if FspectrumNch = 1 then begin
      _BassDll.Bass_ChannelGetdata(FChannelId, @SpectrumData, BASS_DATA_FFT2048);

      {$Q- $R-}
      for i := 1 to 576 do begin
        if i < length(SpectrumData) then
          if SpectrumData[i] * FVisScale < 256 then
            p2^ := trunc(SpectrumData[i] * FVisScale);
        inc(p2);
      end;
      {$Q+ $R+}
    end
    else begin // FspectrumNch = 2
      // Perform combined FFT to reduce processing time for multi channel streams.
      if (FChannels = 1) or (FChannels > 2) then begin
        _BassDll.Bass_ChannelGetdata(FChannelId, @SpectrumData, BASS_DATA_FFT2048);

        {$Q- $R-}
        for i := 1 to 576 do begin
          if i < length(SpectrumData) then
            if SpectrumData[i] * FVisScale < 256 then
              p2^ := trunc(SpectrumData[i] * FVisScale);
          inc(p2);
        end;

        for i := 1 to 576 do begin
          if i < length(SpectrumData) then
            if SpectrumData[i] * FVisScale < 256 then
              p2^ := trunc(SpectrumData[i] * FVisScale);
          inc(p2);
        end;
        {$Q+ $R+}
      end
      else begin // if FChannels = 2 then
        // Add BASS_DATA_FFT_INDIVIDUAL flag for seperate FFT per each channel
        _BassDll.Bass_ChannelGetdata(FChannelId, @SpectrumData, BASS_DATA_FFT2048 + BASS_DATA_FFT_INDIVIDUAL);

        {$Q- $R-}
        for i := 1 to 576 do begin
          if i*2 < length(SpectrumData) then
            if SpectrumData[i*2] * FVisScale < 256 then
              p2^ := trunc(SpectrumData[i*2] * FVisScale);
          inc(p2);
        end;

        for i := 1 to 576 do begin
          if i*2+1 < length(SpectrumData) then
            if SpectrumData[i*2 + 1] * FVisScale < 256 then
              p2^ := trunc(SpectrumData[i*2 + 1] * FVisScale);
          inc(p2);
        end;
        {$Q+ $R+}
      end;
    end;
  end;

  if FwaveformNch > 0 then begin
    if FChannels = 1 then begin
      _BassDll.Bass_ChannelGetdata(FChannelId, @WaveformData, 1152);

    for i := 0 to 575 do begin
      //  p2^ := waveformdata[i] div 256;
      p2^ := Hi(WaveformData[i]);
      inc(p2);
    end;

    if FwaveformNch > 1 then
      for i := 0 to 575 do begin
        //  p2^ := waveformdata[i] div 256;
        p2^ := Hi(WaveformData[i]);
        inc(p2);
      end;
    end
    else if FChannels <= MaxChannels then begin
      _BassDll.Bass_ChannelGetdata(FChannelId, @WaveformData, 1152 * FChannels);

      for i := 0 to 575 do begin
        //  p2^ := waveformdata[i*2] div 256;
        p2^ := Hi(WaveformData[i * FChannels]);
        inc(p2);
      end;

      if FwaveformNch > 1 then
        for i := 0 to 575 do begin
          //  p2^ := waveformdata[i*2+1] div 256;
          p2^ := Hi(WaveformData[i * FChannels + 1]);
          inc(p2);
        end;
    end;
  end;

  p3^ := 1;  // Set flag to notify that new data is written.
  if FUseExtDriver then
    // Inform "VisOut.exe" that the data for vis plug-in are ready.
    fisSharedMemory1.InformDataReady(10{DataReady}, 2320)
   else
    PostThreadMessage(DriveThreadId, FDataReadyMsg, DataReady, 0);
end;

procedure TVisDataThread.SetDelayMS(delayMS : DWORD);
var tmpDelayMS : DWORD;
begin
  tmpDelayMS := delayMs;
  if tmpDelayMS < 10 then
    tmpDelayMS := 10;
  if tmpDelayMS <> FDelayMS then begin
    if FDelayMS <> 0 then     // if not initial start up
      FDelayMSChanged := true;
    FDelayMS := tmpDelayMS
  end;
end;

procedure TVisDataThread.SetDriveThreadId(ThreadId : DWORD);
begin
  DriveThreadId := ThreadId;
end;

procedure TVisDataThread.SetVisModuleInfo(ModuleInfo : TVisModuleInfo);
var PModuleInfo : ^TVisModuleInfo;
begin
  if FUseExtDriver then begin
    PModuleInfo := FShareMemPointer;
    FLatencyMS := PModuleInfo^.latencyMs;
    FspectrumNch := PModuleInfo^.spectrumNch;
    FwaveformNch := PModuleInfo^.waveformNch;
    ModuledelayMs := PModuleInfo^.delayMs;
  end
  else begin
    FLatencyMS := ModuleInfo.latencyMs;
    FspectrumNch := ModuleInfo.spectrumNch;
    FwaveformNch := ModuleInfo.waveformNch;
    ModuledelayMs := ModuleInfo.delayMs;
  end;
  SetDelayMS(ModuledelayMs);
end;

procedure TVisDataThread.SetChannelInfo(ChannelId, SampleRate, Channels : DWORD);
begin
  FChannelId := ChannelId;
  FSampleRate := SampleRate;
  FChannels := Channels;
end;

procedure TVisDataThread.SetPosition(Position : DWORD);
begin
  FPosition := Position;
end;

procedure TVisDataThread.SetVisScale(VisScale : word);
begin
  FVisScale := VisScale;
end;

procedure TVisDataThread.SetExtDriver(OnOff : boolean);
begin
  FUseExtDriver := OnOff;
end;

procedure TVisDataThread.InformVisDriver(MsgId, DataLength : DWORD);
begin
  if FUseExtDriver then
    fisSharedMemory1.InformDataReady(MsgId, DataLength)
  else
    PostThreadMessage(DriveThreadId, FDataReadyMsg, MsgId, DataLength);
end;

procedure TVisDataThread.ResumeVis;
var p1 : PDWORD;
begin
  WaitCounter := 0;
  p1 := FShareMemPointer;
  inc(p1, 70);
  p1^ := 0;   // Clear flag to notify that new data can be given.

  //  PseudoSuspended := false;
  //  SetDelayMS(ModuledelayMs);  // Restore timer interval
  if Suspended then
    Resume;
end;

end.
