library ArtNETlib;

uses
  Forms,
  Windows,
  Dialogs,
  mainfrm in 'mainfrm.pas' {mainform},
  aboutfrm in 'aboutfrm.pas' {aboutform};

type
  PDMXArray = ^TDMXArray;
  TDMXArray = array of byte;

{$R *.res}

procedure ArtNET_Activate(ReceiveDMXUniverse, ReceiveSingleValue:Pointer);stdcall;
begin
  Application.CreateForm(Tmainform, mainform);
  @mainform.ReceiveDMXUniverse:=ReceiveDMXUniverse;
  @mainform.ReceiveSingleValue:=ReceiveSingleValue;
  mainform.cbArtNETSubnetSelect(nil);
end;

procedure ArtNET_Deactivate;stdcall;
begin
  try
    mainform.udp.Listen:=false;
    mainform.ArtShutdown;

    mainform.ViewTimer.Enabled:=false;
    mainform.timer1.Enabled:=false;
    mainform.sendtimer.Enabled:=false;
    mainform.scantimer.Enabled:=false;
    mainform.udp.Close;

    @mainform.ReceiveDMXUniverse:=nil;
    @mainform.ReceiveSingleValue:=nil;

    mainform.Free;
  except
  end;
end;

procedure ArtNET_SendPollingRequest(IPAddress: String);stdcall;
begin
  mainform.lbArtNetNodes.Items.Clear;
  mainform.ArtSendOpPollRequest(IPAddress);
end;

procedure ArtNET_SetChannel(ArtNETSubNet:integer; ArtNetUniverse:integer; Channel:integer; Value:integer);stdcall;
begin
  if Channel<1 then Channel:=1;
  if Channel>512 then Channel:=512;
  if Value<0 then Value:=0;
  if Value>255 then Value:=255;

  if mainform.cbAllowAllUniverses.Checked then
  begin
    if ArtNETSubNet<0 then ArtNETSubNet:=0;
    if ArtNETSubNet>15 then ArtNETSubNet:=15;
    if ArtNetUniverse<0 then ArtNetUniverse:=0;
    if ArtNetUniverse>15 then ArtNetUniverse:=15;
    mainform.DMXOutUniverse[ArtNetSubNet][ArtNetUniverse][Channel-1]:=Value;
  end else
  begin
    if ArtNetUniverse<0 then ArtNetUniverse:=0;
    if ArtNetUniverse>3 then ArtNetUniverse:=3;
    mainform.DMXOutUniverseSpec[ArtNetUniverse][Channel-1]:=Value;
  end;
end;

procedure ArtNET_SendDMXUniverse(ArtNETSubNet:integer; ArtNetUniverse:integer; Buffer: PDMXArray; Length:integer);stdcall;
var
  i:integer;
begin
  if ArtNETSubNet<0 then ArtNETSubNet:=0;
  if ArtNETSubNet>15 then ArtNETSubNet:=15;
  if ArtNetUniverse<0 then ArtNetUniverse:=0;
  if ArtNetUniverse>15 then ArtNetUniverse:=15;

//  mainform.SendDMXUniverse(mainform.ArtBroadcastIP, ArtNETSubNet, ArtNetUniverse, Buffer^, Length);
  if mainform.cbAllowAllUniverses.Checked then
  begin
    if ArtNETSubNet<0 then ArtNETSubNet:=0;
    if ArtNETSubNet>15 then ArtNETSubNet:=15;
    if ArtNetUniverse<0 then ArtNetUniverse:=0;
    if ArtNetUniverse>15 then ArtNetUniverse:=15;
//    Move(Buffer^, mainform.DMXOutUniverse[ArtNetSubNet][ArtNetUniverse], 512);  // Move funktioniert hier nicht, da unterschiedliche Speicherbereiche, da eine DLL per STDCALL!!!
    for i:=0 to 511 do
      mainform.DMXOutUniverse[ArtNetSubNet][ArtNetUniverse][i]:=Buffer^[i];
  end else
  begin
    if ArtNetUniverse<0 then ArtNetUniverse:=0;
    if ArtNetUniverse>3 then ArtNetUniverse:=3;
//    Move(Buffer^, mainform.DMXOutUniverseSpec[ArtNetUniverse], 512);
    for i:=0 to 511 do
      mainform.DMXOutUniverseSpec[ArtNetUniverse][i]:=Buffer^[i];
  end;
end;

procedure ArtNET_SendDMXUniverse_RAW(ArtNETSubNet:integer; ArtNetUniverse:integer; Buffer: PDMXArray; Length:integer);stdcall;
begin
  if ArtNETSubNet<0 then ArtNETSubNet:=0;
  if ArtNETSubNet>15 then ArtNETSubNet:=15;
  if ArtNetUniverse<0 then ArtNetUniverse:=0;
  if ArtNetUniverse>15 then ArtNetUniverse:=15;

  mainform.SendDMXUniverse(mainform.ArtBroadcastIP, ArtNETSubNet, ArtNetUniverse, Buffer^, Length);
end;

procedure ArtNET_ShowConfig;stdcall;
begin
  mainform.showmodal;
end;

procedure ArtNET_ShowAbout;stdcall;
begin
  Application.CreateForm(Taboutform, aboutform);
  aboutform.showmodal;
  aboutform.free;
end;

procedure ArtNET_SetReceiveUniverseOnOff(ArtNETSubNet:integer; ArtNetUniverse:integer; Enabled: boolean);stdcall;
begin
  mainform.DMXInEnabled[ArtNETSubNet][ArtNetUniverse]:=Enabled;
end;

procedure ArtNET_SetConfig(ArtNetShortName, ArtNetLongName:String; ReceiverEnabled, AllowLoopback, SendContinuously, AllowAllUniverses:Boolean; UsedNetworkCard:integer; IPAddress, SubNetMask: String);stdcall;
var
  i:integer;
  short:string[18];
  long:string[64];
begin
  with mainform do
  begin
    short:=ArtNetShortName;
    for i := 0 to 17 do ArtShortName[i] := chr(0);
    for i:=1 to length(short) do
    begin
      if i<=18 then
        ArtShortName[i-1]:=short[i]
    end;

    long:=ArtNetLongName;
    for i := 0 to 63 do ArtLongName[i] := chr(0);
    for i:=1 to length(long) do
    begin
      if i<=64 then
        ArtLongName[i-1]:=long[i]
    end;

    cbReceiverEnabled.Checked:=ReceiverEnabled;
    cbLoopback.Checked:=AllowLoopback;
    cbSendUniversesRepeatingly.Checked:=SendContinuously;
    cbAllowAllUniverses.Checked:=AllowAllUniverses;

    cbMAC.ItemIndex:=UsedNetworkCard;
    cbMacSelect(nil);
    edipaddress.Text:=IPAddress;
    edsubnetmask.Text:=SubNetMask;
    ArtIP:=edipaddress.Text;
    ArtSubnetmask:=edsubnetmask.text;
  end;
end;

exports
  ArtNET_Activate,
  ArtNET_Deactivate,
  ArtNET_SendPollingRequest,
  ArtNET_SetChannel,
  ArtNET_SendDMXUniverse,
  ArtNET_SendDMXUniverse_RAW,
  ArtNET_ShowConfig,
  ArtNET_ShowAbout,
  ArtNET_SetReceiveUniverseOnOff,
  ArtNET_SetConfig;

begin
end.
