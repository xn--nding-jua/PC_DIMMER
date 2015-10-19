unit DXPlayFm;

interface
{$INCLUDE DelphiXcfg.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DXPlay, ActiveX, DXETable, DIB,
{$IfDef StandardDX}
  DirectDraw, DirectPlay;
{$Else}
  DirectX;
{$EndIf}

type
  TDelphiXDXPlayForm = class(TForm)
    NextButton: TButton;
    CancelButton: TButton;
    Bevel2: TBevel;
    JoinGameGetPlayerListTimer: TTimer;
    Image1: TImage;
    NewGameSessionName: TEdit;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    JoinGamePlayerList: TListBox;
    JoinGameSessionList: TListBox;
    Label7: TLabel;
    JoinGamePlayerName: TEdit;
    Button1: TButton;
    procedure NextButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure JoinGameSessionListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JoinGamePlayerNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JoinGameGetPlayerListTimerTimer(Sender: TObject);
    procedure JoinGameSessionListClick(Sender: TObject);
    procedure JoinGamePlayerListClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FProviderGUID: TGUID;
    dpDesc: TDPSessionDesc2;
    hr: HRESULT;
    procedure InitDirectPlay;
    procedure SearchForSessionUsers;
  public
    DPlay: {$IfDef DX7}IDirectPlay4A{$Else}IDirectPlay8Address{$EndIf};
    DXPlay: TCustomDXPlay;
    PlayerName: string;
    ProviderName: string;
    SessionName: string;
  end;

var
  DelphiXDXPlayForm: TDelphiXDXPlayForm;

implementation

uses DXConsts;

{$R *.DFM}

procedure TDelphiXDXPlayForm.InitDirectPlay;
var
  DPlay1: {$IfDef DX7}IDirectPlay{$Else}IDirectPlay8Server{$EndIf};
begin
  if DXDirectPlayCreate(FProviderGUID, {$IfNDef DX7}@{$EndIf}DPlay1, nil)<>0 then
    raise EDXPlayError.CreateFmt(SCannotInitialized, [SDirectPlay]);

  DPlay := DPlay1 as {$IfDef DX7}IDirectPlay4A{$Else}IDirectPlay8Address{$EndIf}
end;

function EnumSessionsCallback(const lpThisSD: TDPSessionDesc2;
    var lpdwTimeOut: DWORD; dwFlags: DWORD; lpContext: Pointer): BOOL; stdcall;
var
  Guid: PGUID;
begin
  if dwFlags and DPESC_TIMEDOUT<>0 then
  begin
    Result := False;
    Exit;
  end;

  Guid := New(PGUID);
  Move(lpThisSD.guidInstance, Guid^, SizeOf(TGUID));
  TDelphiXDXPlayForm(lpContext).JoinGameSessionList.Items.AddObject(lpThisSD.lpszSessionNameA, Pointer(Guid));

  Result := True;
end;

function EnumPlayersCallback2(TDPID: TDPID; dwPlayerType: DWORD;
  const lpName: TDPName; dwFlags: DWORD; lpContext: Pointer): BOOL; stdcall;
begin
  with lpName do
  begin
    if lpszShortNameA<>nil then
      TDelphiXDXPlayForm(lpContext).JoinGamePlayerList.Items.Add(lpszShortNameA);
  end;

  Result := True;
end;

procedure TDelphiXDXPlayForm.SearchForSessionUsers;
var
  dpDesc: TDPSessionDesc2;
  hr: HRESULT;
  TempDPlay: IDirectPlay4A;
  DPlay1: IDirectPlay;
begin
  JoinGamePlayerList.Items.Clear;

  TempDPlay := DPlay;
  if TempDPlay=nil then
  begin
    if DXDirectPlayCreate(FProviderGUID, DPlay1, nil)<>0 then
      Exit;
    TempDPlay := DPlay1 as IDirectPlay4A;
    DPlay1 := nil;
  end;            
  try
    FillChar(dpDesc, SizeOf(dpDesc), 0);
    dpDesc.dwSize := SizeOf(dpDesc);
    dpDesc.guidInstance := PGUID(JoinGameSessionList.Items.Objects[JoinGameSessionList.ItemIndex])^;
    dpDesc.guidApplication := DXPlayStringToGUID(DXPlay.GUID);

    hr := TempDPlay.Open(dpDesc, DPOPEN_JOIN);
    if hr<>0 then Exit;
    try
      TempDPlay.EnumPlayers(PGUID(nil), @EnumPlayersCallback2, Self, DPENUMPLAYERS_REMOTE);
    finally
      TempDPlay.Close;
    end;
  finally
    TempDPlay := nil;                          
  end;
end;


procedure TDelphiXDXPlayForm.FormShow(Sender: TObject);
var
  i:integer;
begin
  FProviderGUID := StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}');
  InitDirectPlay;

  if DPlay=nil then InitDirectPlay;

  for i:=0 to JoinGameSessionList.Items.Count-1 do
    Dispose(PGUID(JoinGameSessionList.Items.Objects[i]));
  JoinGameSessionList.Items.Clear;

  FillChar(dpDesc, SizeOf(dpDesc), 0);
  dpDesc.dwSize := SizeOf(dpDesc);
  dpDesc.guidApplication := DXPlayStringToGUID(DXPlay.GUID);

  hr := DPlay.EnumSessions(dpDesc, 0, @EnumSessionsCallback, Self, DPENUMSESSIONS_AVAILABLE);

  if JoinGameSessionList.items.Count>0 then
  begin
    JoinGameSessionList.itemindex:=0;

    NextButton.enabled:=true;
  end;

  if hr=DPERR_USERCANCEL then Exit;
  if hr<>0 then
    raise EDXPlayError.Create(SDXPlaySessionListCannotBeAcquired);
end;

procedure TDelphiXDXPlayForm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to JoinGameSessionList.Items.Count-1 do
    Dispose(PGUID(JoinGameSessionList.Items.Objects[i]));
end;

procedure TDelphiXDXPlayForm.NextButtonClick(Sender: TObject);
begin
  // Bildschirm 3->4: Abschlieﬂen (Client)
  if DPlay=nil then InitDirectPlay;

  {  Session connection  }
  FillChar(dpDesc, SizeOf(dpDesc), 0);
  dpDesc.dwSize := SizeOf(dpDesc);
  dpDesc.guidInstance := PGUID(JoinGameSessionList.Items.Objects[JoinGameSessionList.ItemIndex])^;
  dpDesc.guidApplication := DXPlayStringToGUID(DXPlay.GUID);

  hr := DPlay.Open(dpDesc, DPOPEN_JOIN);
  if hr=DPERR_USERCANCEL then Exit;
  if hr<>0 then
  begin
    DPlay := nil;
    raise EDXPlayError.CreateFmt(SDXPlaySessionCannotOpened, [NewGameSessionName.Text]);
  end;

  PlayerName := JoinGamePlayerName.Text;
  ProviderName := dxplay.GetProviderNameFromGUID(StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}'));
  SessionName := JoinGameSessionList.Items[JoinGameSessionList.ItemIndex];

  Tag := 1;
  Close;
end;

procedure TDelphiXDXPlayForm.JoinGameGetPlayerListTimerTimer(
  Sender: TObject);
begin
  JoinGameGetPlayerListTimer.Enabled := False;
  SearchForSessionUsers;
end;

procedure TDelphiXDXPlayForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDelphiXDXPlayForm.JoinGameSessionListClick(Sender: TObject);
begin
  JoinGamePlayerList.Clear;
  if JoinGameSessionList.ItemIndex<>-1 then
  begin
    JoinGameGetPlayerListTimer.Enabled := False;
    JoinGameGetPlayerListTimer.Enabled := True;
  end;
  NextButton.Enabled := (JoinGameSessionList.ItemIndex<>-1) and (JoinGamePlayerName.Text<>'');
end;

procedure TDelphiXDXPlayForm.JoinGameSessionListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if JoinGameSessionList.ItemIndex=-1 then Exit;

  if Key=VK_RETURN then
  begin
    if NextButton.Enabled then
    begin
      NextButtonClick(nil);
      Key := 0;
    end else if JoinGamePlayerName.Text='' then
    begin
      JoinGamePlayerName.SetFocus;
      Key := 0;
    end;
  end;
end;

procedure TDelphiXDXPlayForm.JoinGamePlayerNameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if JoinGamePlayerName.Text='' then Exit;

  if Key=VK_RETURN then
  begin
    if NextButton.Enabled then
    begin
      NextButtonClick(nil);
      Key := 0;
    end else if JoinGameSessionList.ItemIndex=-1 then
    begin
      JoinGameSessionList.SetFocus;
      Key := 0;         
    end;
  end;
end;

procedure TDelphiXDXPlayForm.JoinGamePlayerListClick(Sender: TObject);
begin
  NextButton.Enabled := (JoinGameSessionList.ItemIndex<>-1) and (JoinGamePlayerName.Text<>'');
end;

procedure TDelphiXDXPlayForm.Button1Click(Sender: TObject);
begin
  SearchForSessionUsers;
end;

end.

