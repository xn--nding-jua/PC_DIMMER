unit pcdMEVP;

interface

uses
  Classes, Contnrs, Windows, syncObjs;

const
  // Konstanten für MEVP-3D-Visualizer
  // memory map version / Dll version
  MEVP_VERSION=12;
  MEVP_NB_UNIVERSES=4;
  MEVP_MAX_FIXTURES=1000;
  MEVP_DMX_MAX_CHANNEL=512;
  MEVP_DMX_ARRAY_SIZE=MEVP_NB_UNIVERSES * MEVP_DMX_MAX_CHANNEL;
  MEVP_MAX_STR_LEN=300;

  MEVP_CLOSE_VISUALIZER=0;
  MEVP_SET_LANGUAGE=1;
  MEVP_READ_PATCH=2;

  MEVP_CREATE_SHARED_MEM=0;
  MEVP_FREE_SHARED_MEM=1;
  MEVP_WRITE_PATCH=2;


type
  PMevpCommand = ^TMevpCommand;
  TMevpCommand = Record
    Address: smallint;
    Data: byte;
  end;

  TDasMevWriteDmx = function(iUniverse:integer; DmxArray:Pointer):integer; cdecl;

  TMevpOutArray = Array[0..3, 0..511] of Byte;

  TPCDMevpThread = class(TThread)
  private
    FMEVPDLL: THandle;
    FCmdQueue: TQueue;
    FThreadWakeUp: TEvent;
    FDasMevWriteDmx: TDasMevWriteDmx;
    FOutArray: TMevpOutArray;

  protected
    procedure Execute; override;
  public
    constructor Create(MEVPDLL: THandle; CmdQueue: TQueue; DasMevWriteDmx: TDasMevWriteDmx);
    destructor Destroy; override;
    procedure WakeUp;
  end;

  TPCDMevp = class
  private
    FThread: TPCDMevpThread;
    FMEVPDLLPath: string;
    FMEVPDLL: THandle;
    FCmdQueue: TQueue;
    FMaxQueueSize: integer;
    FLanguage: integer;
    FUseThread: boolean;
    FThreadPriority: TThreadPriority;
    FRunning: boolean;
    FOutArray: TMevpOutArray;

    // Funktionsprototypen für 3D Visualizer
    FDasMevStart : function(sController:PChar; sPassWrd:PChar):integer; cdecl;
    FDasMevCommand : function(iType:integer; iParam:integer):integer; cdecl;
    FDasMevWriteDmx : TDasMevWriteDmx;
    FDasMevGetFixtureParam : function(iIndex:integer; iDmxAddress:Pointer; iDmxUniverse:Pointer; iNbChannels:Pointer; sName:PChar; fPosX, fPosY, fPosZ, fRotX, fRotY, fRotZ:Pointer):integer; cdecl;
    FDasMevGetVersion : function : integer; cdecl;

    procedure SetMevpDllPath(APath: String);
    procedure SetLanguage(ALanguage: integer);
    procedure SetUseThread(AUse: boolean);
    procedure SetThreadPriority(APriority: TThreadPriority);
    procedure StartMevp;
    procedure InitDLL;
    procedure CloseDLL;
    procedure SetChannelT(AAddress: smallint; AData: byte);
    procedure SetChannelNT(AAddress: smallint; AData: byte);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start;
    procedure Stop;
    procedure SetChannel(AAddress: smallint; AData: byte);
    property MEVPDLLPath: string read FMEVPDLLPath write SetMevpDllPath;
    property Language: integer read FLanguage write SetLanguage;
    property UseThread: boolean read FUseThread write SetUseThread;
    property ThreadPriority: TThreadPriority read FThreadPriority write setThreadPriority;
    property Running: boolean read FRunning;
  end;

implementation

uses
  messagesystem, sysutils, gnugettext;

var
  CritSect : TRTLCriticalSection;

constructor TPCDMevp.Create;
begin
  if (gnugettext.GetCurrentLanguage='en') then
  begin
    FLanguage := 0;
  end else if (gnugettext.GetCurrentLanguage='de') then
  begin
    FLanguage := 1;
  end;

  FThread := nil;
  FMEVPDLLPath := '';
  FMEVPDLL := 0;
  FCmdQueue := TQueue.Create;
  FMaxQueueSize := 1000;
  FUseThread := false;
  FThreadPriority := tpNormal;
  FRunning := false;
end;

destructor TPCDMevp.Destroy;
var
  LTmpPtr: PMevpCommand;
begin
  if FThread <> nil then
    Stop;

  while FCmdQueue.Count > 0 do
  begin
    LTmpPtr := PMevpCommand(FCmdQueue.Pop);
    FreeMem(LTmpPtr);
  end;

  if FMEVPDLL <> 0 then
    CloseDLL;

  FCmdQueue.Destroy;
end;

procedure TPCDMevp.Start;
begin
  if FMEVPDLL = 0 then
    InitDLL;

  StartMevp;

  if FUseThread and (FThread = nil) then
  begin
    FThread := TPCDMevpThread.Create(FMEVPDLL, FCmdQueue, FDasMevWriteDmx);
    FThread.Priority := FThreadPriority;
  end;

  FRunning := true;
end;

procedure TPCDMevp.Stop;
begin
  if FThread <> nil then
  begin
    FThread.Destroy;
    FThread := nil;
  end;

  if FMEVPDLL <> 0 then
    CloseDLL;

  FRunning := false;
end;

procedure TPCDMevp.SetMevpDllPath(APath: String);
begin
  if FRunning then
  begin
    Stop;
    FMEVPDLLPath := APath;
    Start;
  end else
  begin
    FMEVPDLLPath := APath;
  end;
end;

procedure TPCDMevp.SetThreadPriority(APriority: TThreadPriority);
begin
  FThreadPriority := APriority;
  if FThread <> nil then
    FThread.Priority := APriority;
end;

constructor TPCDMevpThread.Create(MEVPDLL: THandle; CmdQueue: TQueue; DasMevWriteDmx: TDasMevWriteDmx);
begin
  FMEVPDLL := MEVPDLL;
  FCmdQueue := CmdQueue;
  FDasMevWriteDmx := DasMevWriteDmx;
  FThreadWakeUp := TEvent.Create(nil, True, False, 'mevpthread.wakeup');

  inherited Create(false);
end;

destructor TPCDMevpThread.Destroy;
begin
  Terminate;
  WakeUp;
  inherited Destroy;

  FThreadWakeUp.Free;
end;

procedure TPCDMevp.SetLanguage(ALanguage: integer);
begin
  FLanguage := ALanguage;
  if (FMEVPDLL <> 0) and (@FDasMevCommand <> nil) then
    FDasMevCommand(MEVP_SET_LANGUAGE, FLanguage);
end;

procedure TPCDMevp.SetUseThread(AUse: boolean);
begin
  if AUse <> FUseThread then
  begin
    if FRunning then
    begin
      Stop;
      FUseThread := AUse;
      Start;
    end else
      FUseThread := AUse;
  end;
end;

procedure TPCDMevp.StartMevp;
var
  LName, LCode: PChar;
begin
  // 3D Visualizer starten
  if (FMEVPDLL <> 0) and (@FDasMevStart <> nil) then
  begin
    LName := PChar('PC_DIMMER2012');
    LCode := PCHar('ArkJst');
    FDasMevStart(LName, LCode);
  end;

  // Sprache des 3D-Visualizers setzen
  if (FMEVPDLL<>0) and (@FDasMevCommand <> nil) then
    FDasMevCommand(MEVP_SET_LANGUAGE, FLanguage);
end;

procedure TPCDMevp.InitDLL;
begin
  if FileExists(MEVPDLLPath) then
  begin
    SetCurrentDir(ExtractFilePath(MEVPDLLPath));

    if FMEVPDLL=0 then
    begin
      FMEVPDLL := LoadLibrary(PChar(MEVPDLLPath));
      FDasMevStart := GetProcAddress(FMEVPDLL,'DasMevStart');
      FDasMevCommand := GetProcAddress(FMEVPDLL,'DasMevCommand');
      FDasMevWriteDmx := GetProcAddress(FMEVPDLL,'DasMevWriteDmx');
      FDasMevGetFixtureParam := GetProcAddress(FMEVPDLL,'DasMevGetFixtureParam');
      FDasMevGetVersion := GetProcAddress(FMEVPDLL,'DasMevGetVersion');
    end;
  end;
end;

procedure TPCDMevp.CloseDLL;
begin
  if (FMEVPDLL <> 0) then
  begin
    if (@FDasMevCommand <> nil) then
      FDasMevCommand(MEVP_CLOSE_VISUALIZER, -1);

    FDasMevStart := nil;
    FDasMevCommand := nil;
    FDasMevWriteDmx := nil;
    FDasMevGetFixtureParam := nil;
    FDasMevGetVersion := nil;
    FreeLibrary(FMEVPDLL);
    FMEVPDLL := 0;
  end;
end;

procedure TPCDMevpThread.WakeUp;
begin
  FThreadWakeUp.SetEvent;
end;

procedure TPCDMevpThread.Execute;
var
  LTmpPtr: PMevpCommand;
  LQueueCount: integer;
  LChanged: array[0..3] of boolean;
  LUniverse: integer;
  LAddress: integer;
  LQueueSize: integer;
begin
  while not Terminated do
  begin
    LChanged[0] := false; LChanged[1] := false; LChanged[2] := false; LChanged[3] := false;
    EnterCriticalSection(CritSect);
    LQueueCount := FCmdQueue.Count;
    LeaveCriticalSection(CritSect);

    while (not Terminated) and (LQueueCount > 0) do
    begin
      LTmpPtr := nil;

      // take command from queue
      EnterCriticalSection(CritSect);
      if FCmdQueue.Count > 0 then
      begin
        LTmpPtr := PMevpCommand(FCmdQueue.Pop);
      end;
      LeaveCriticalSection(CritSect);

      if LTmpPtr <> nil then
      begin
      // process command
        if @FDasMevWriteDmx<>nil then
        begin
          LUniverse := (LTmpPtr^.Address-1) div 512;
          LAddress := LTmpPtr^.Address-1-(LUniverse*512);
          FOutArray[LUniverse, LAddress] := LTmpPtr^.Data;
          LChanged[LUniverse] := true;
        end;
        FreeMem(LTmpPtr);
      end;

      EnterCriticalSection(CritSect);
      LQueueCount := FCmdQueue.Count;
      LeaveCriticalSection(CritSect);
    end;

    for LUniverse := 0 to 3 do
      if LChanged[LUniverse] then
        FDasMevWriteDmx(LUniverse, @FOutArray[LUniverse]);

    EnterCriticalSection(CritSect);
    LQueueSize := FCmdQueue.Count;
    LeaveCriticalSection(CritSect);

    if LQueueSize = 0 then
    begin
      FThreadWakeUp.WaitFor(10000);
      FThreadWakeUp.ResetEvent;
    end;
  end;
end;

procedure TPCDMevp.SetChannel(AAddress: smallint; AData: byte);
begin
  if FRunning and (FMEVPDLL<>0) and (AAddress <= 2048) then
  begin
    if FUseThread then
      SetChannelT(AAddress, AData)
    else
      SetChannelNT(AAddress, AData);
  end
end;

procedure TPCDMevp.SetChannelNT(AAddress: smallint; AData: byte);
var
  LUniverse: integer;
  LAddress: integer;
begin
  if @FDasMevWriteDmx<>nil then
  begin
    LUniverse := (AAddress-1) div 512;
    LAddress := AAddress-1-(LUniverse*512);
    FOutArray[LUniverse, LAddress] := AData;
    FDasMevWriteDmx(LUniverse, @FOutArray[LUniverse]);
  end;
end;

procedure TPCDMevp.SetChannelT(AAddress: smallint; AData: byte);
var
  LTmpPtr: PMevpCommand;
begin
  // If queue is full make some place
  EnterCriticalSection(CritSect);
  if FCmdQueue.Count > FMaxQueueSize then
  begin
    LTmpPtr := PMevpCommand(FCmdQueue.Pop);
    FreeMem(LTmpPtr);
  end;
  LeaveCriticalSection(CritSect);

  // Create new record
  GetMem(LTmpPtr, sizeof(TMevpCommand));
  try
    LTmpPtr^.Address := AAddress;
    LTmpPtr^.Data := AData;

    EnterCriticalSection(CritSect);
    FCmdQueue.Push(LTmpPtr);
    LeaveCriticalSection(CritSect);

    if FThread <> nil then
      FThread.WakeUp;
  except
    FreeMem(LTmpPtr);
    //raise;
  end;
end;

initialization
  InitializeCriticalSection(CritSect);

finalization
  DeleteCriticalSection(CritSect);

end.
