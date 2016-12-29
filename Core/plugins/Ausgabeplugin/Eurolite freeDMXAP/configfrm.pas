unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock, IdUDPClient, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdGlobal, IdSocketHandle, ExtCtrls,
  CHHighResTimer, ComCtrls, Registry, Mask, JvExMask, JvSpin;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TChangedChannel = record
    Address:Word;
    Value:Byte;
  end;

  Tconfig = class(TForm)
    Button1: TButton;
    udpserver: TIdUDPServer;
    udpclient: TIdUDPClient;
    Button2: TButton;
    TimeoutTimer: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SendTimer: TCHHighResTimer;
    GUITimer: TTimer;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    Label5: TLabel;
    Label6: TLabel;
    Shape1: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Button4: TButton;
    Shape5: TShape;
    Shape6: TShape;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Edit1: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edit2: TJvSpinEdit;
    edit3: TJvSpinEdit;
    StartupTimer: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure udpserverUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure TimeoutTimerTimer(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
    procedure GUITimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure StartupTimerTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    TimeOut:integer;
    Connected:boolean;
    procedure FctConnectionRequest;
    procedure FctSendAlive;
    procedure FctDisconnect;
    procedure FctSendDMX;
  public
    { Public-Deklarationen }
    ChangedChannels:array of TChangedChannel;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    isstartup:boolean;
    procedure Startup;
  end;

var
  config: Tconfig;

implementation

{$R *.dfm}

procedure Tconfig.startup;
begin
  isstartup:=true;
  StartupTimer.Enabled:=true;
end;

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure Tconfig.FctConnectionRequest;
var
  Buffer:TIdBytes;
begin
  setlength(Buffer, 4);
  Buffer[0]:=229;
  Buffer[1]:=udpserver.DefaultPort AND 127;
  Buffer[2]:=(udpserver.DefaultPort AND 16256) div 128;
  Buffer[3]:=(udpserver.DefaultPort AND 49152) div 16384;
  udpclient.SendBuffer(Buffer);
end;

procedure Tconfig.FctSendAlive;
var
  Buffer:TIdBytes;
begin
  setlength(Buffer, 1);
  Buffer[0]:=170;
  udpclient.SendBuffer(Buffer);
end;

procedure Tconfig.FctDisconnect;
var
  Buffer:TIdBytes;
begin
  setlength(Buffer, 1);
  Buffer[0]:=172;
  udpclient.SendBuffer(Buffer);
end;

procedure Tconfig.FctSendDMX;
var
  Buffer:TIdBytes;
  i:integer;
begin
  // zu sendende Daten zusammenstellen
  // immer 100 Kanäle senden, sofern vorhanden
  setlength(Buffer, 0);
  for i:=0 to 99 do
  begin
    if i>=length(ChangedChannels) then
      break
    else begin
      setlength(Buffer, length(Buffer)+3);

      if ((i<(length(ChangedChannels))-1) and (i<99)) then
      begin
        // Erste oder mittlere Kanalwerte
        Buffer[length(Buffer)-3]:=192 + (((ChangedChannels[i].Address-1) shr 6) AND 6 + (ChangedChannels[i].Value shr 7));
        Buffer[length(Buffer)-2]:=(ChangedChannels[i].Address-1) mod 128;
        Buffer[length(Buffer)-1]:=ChangedChannels[i].Value AND 127;
      end else
      begin
        // Abschlusspaket
        Buffer[length(Buffer)-3]:=128 + (((ChangedChannels[i].Address-1) shr 6) AND 6 + (ChangedChannels[i].Value shr 7));
        Buffer[length(Buffer)-2]:=(ChangedChannels[i].Address-1) mod 128;
        Buffer[length(Buffer)-1]:=ChangedChannels[i].Value AND 127;
      end;
    end;
  end;

  // Daten senden
  udpclient.SendBuffer(Buffer);

  // Gesendete Daten aus Queue löschen
  for i:=0 to length(ChangedChannels)-1 do
  begin
    ChangedChannels[i]:=ChangedChannels[i+1];
  end;
  if length(ChangedChannels)>=100 then
    setlength(ChangedChannels, length(ChangedChannels)-100)
  else
    setlength(ChangedChannels, 0)
end;

procedure Tconfig.Button1Click(Sender: TObject);
begin
  udpserver.DefaultPort:=round(edit3.value);
  udpserver.Active:=true;

  udpclient.Host:=edit1.Text;
  udpclient.Port:=round(edit2.value);
  udpclient.Active:=true;

  FctConnectionRequest;
  TimeoutTimer.Enabled:=true;
  SendTimer.enabled:=true;
  Connected:=true; // workaround: eigentlich sollte bei Eintreffen von Alive-Meldungen connected:=true gesetzt werden
  // leider empfängt UDPserver nicht, sofern kein Fenster angezeigt wird :-(
end;

procedure Tconfig.Button2Click(Sender: TObject);
begin
  FctDisconnect;
  
  udpserver.Active:=false;
  udpclient.Active:=false;
  TimeoutTimer.Enabled:=false;
  SendTimer.Enabled:=false;
  shape1.Brush.Color:=clRed;
  shape2.Brush.Color:=clRed;
  progressbar1.Position:=0;
  label5.Caption:='0%';
end;

procedure Tconfig.udpserverUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  i:integer;
  IgnoreNumber:integer;
begin
  IgnoreNumber:=-1;

  for i:=0 to length(Adata)-1 do
  begin
    if i<>IgnoreNumber then
    begin
      if AData[i]=170 then
      begin
        shape1.Brush.Color:=clLime;
        config.TimeOut:=0;
        shape2.Brush.Color:=clLime;
        Connected:=true;
      end else if AData[i]=167 then
      begin
        shape2.Brush.Color:=clLime;
        Connected:=true;
      end else if AData[i]=160 then
      begin
        shape2.Brush.Color:=clRed;
        Connected:=false;
      end else if AData[i]=240 then
      begin
        if (i+1)<length(AData) then
        begin
          label5.caption:=inttostr(AData[i+1])+'%';
          progressbar1.Position:=AData[i+1];
        end else
          label5.caption:='FEHLER!';
        IgnoreNumber:=i+1;
      end;
    end;
  end;
end;

procedure Tconfig.TimeoutTimerTimer(Sender: TObject);
begin
  FctSendAlive;
  
{
  // UdpServer empfängt nicht, wenn Fenster nicht angezeigt wird. Ohne Workaround wird einfach
  // nun stumpf Alive-Signal gesendet...
  TimeOut:=TimeOut+1;

  if Connected then
  begin
    FctSendAlive;
  end;

  if TimeOut=6 then
  begin
    shape1.Brush.Color:=clRed;
    shape2.Brush.Color:=clRed;
    TimeOut:=0;
    FctDisconnect;
    FctConnectionRequest;
  end;
}
end;

procedure Tconfig.SendTimerTimer(Sender: TObject);
begin
  if Connected then
    FctSendDMX;
end;

procedure Tconfig.GUITimerTimer(Sender: TObject);
begin
  label2.caption:=inttostr(6-Timeout)+'s';
  label4.caption:=inttostr(length(ChangedChannels))+' Pakete';
end;

procedure Tconfig.FormShow(Sender: TObject);
begin
  GUITimer.Enabled:=true;
end;

procedure Tconfig.FormHide(Sender: TObject);
begin
  GUITimer.Enabled:=false;
end;

procedure Tconfig.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LReg:TRegistry;
begin
  GUITimer.Enabled:=false;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
          LReg.CreateKey(ExtractFileName(GetModulePath));
        if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
        begin
          LReg.WriteString('IPAddress',edit1.text);
          LReg.WriteInteger('PortAP',round(edit2.value));
          LReg.WriteInteger('PortLocal',round(edit3.value));
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tconfig.Button3Click(Sender: TObject);
begin
  setlength(ChangedChannels, 8);
  ChangedChannels[0].Address:=1;
  ChangedChannels[0].Value:=0;
  ChangedChannels[1].Address:=2;
  ChangedChannels[1].Value:=1;
  ChangedChannels[2].Address:=3;
  ChangedChannels[2].Value:=2;
  ChangedChannels[3].Address:=4;
  ChangedChannels[3].Value:=3;
  ChangedChannels[4].Address:=5;
  ChangedChannels[4].Value:=4;
  ChangedChannels[5].Address:=6;
  ChangedChannels[5].Value:=5;
  ChangedChannels[6].Address:=7;
  ChangedChannels[6].Value:=6;
  ChangedChannels[7].Address:=8;
  ChangedChannels[7].Value:=7;
end;

procedure Tconfig.StartupTimerTimer(Sender: TObject);
var
  LReg:TRegistry;
begin
  StartupTimer.Enabled:=false;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
          LReg.CreateKey(ExtractFileName(GetModulePath));
        if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
        begin
          if not LReg.ValueExists('IPAddress') then
            LReg.WriteString('IPAddress','192.168.4.1');
          edit1.text:=LReg.ReadString('IPAddress');
          if not LReg.ValueExists('PortAP') then
            LReg.WriteInteger('PortAP',10100);
          edit2.value:=LReg.ReadInteger('PortAP');
          if not LReg.ValueExists('PortLocal') then
            LReg.WriteInteger('PortLocal',10101);
          edit3.value:=LReg.ReadInteger('PortLocal');
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Button1Click(nil);
end;

procedure Tconfig.Button4Click(Sender: TObject);
begin
  close;
end;

end.
