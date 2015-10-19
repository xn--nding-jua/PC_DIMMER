unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, ExtCtrls, Registry, WinSock, DXPlay;

const
	chan=8192;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackValue = procedure(address:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    ConfigOK: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    Button1: TButton;
    Label6: TLabel;
    DXPlay1: TDXPlay;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    fadezeit_label: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit1: TEdit;
    Edit4: TEdit;
    Label2: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Button2: TButton;
    procedure DXPlay1Message(Sender: TObject; From: TDXPlayPlayer;
      Data: Pointer; DataSize: Integer);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DXPlay1Open(Sender: TObject);
    procedure DXPlay1AddPlayer(Sender: TObject; Player: TDXPlayPlayer);
    procedure DXPlay1DeletePlayer(Sender: TObject; Player: TDXPlayPlayer);
    procedure DXPlay1Close(Sender: TObject);
    procedure DXPlay1SessionLost(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    function GetIPAddress:string;
    procedure CheckSession;
  public
    { Public-Deklarationen }
    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    RequestDLLValue:TCallbackValue;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    lastchan:Word;
  end;

var
  Config: TConfig;

implementation

{$R *.dfm}

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

function TConfig.GetIPAddress:string;
const
  sTxtIP  = '%d.%d.%d.%d';
var
    rSockVer   : Word;
    aWSAData   : TWSAData;
    szHostName : array[0..255] of Char;
    pHE        : PHostEnt;
begin
  Result:='';
  // WinSock Version 1.1 initialisieren
  rSockVer:=MakeWord(1, 1);
  WSAStartup(rSockVer, aWSAData );
  try
    FillChar(szHostName, SizeOf(szHostName), #0);
    GetHostName(szHostName, SizeOf(szHostName));
    pHE:=GetHostByName(szHostName);
    if (pHE<>nil) then with pHE^ do
      Result:=Format(sTxtIP,
                [Byte(h_addr^[0]), Byte(h_addr^[1]),
                 Byte(h_addr^[2]), Byte(h_addr^[3])]);
  finally
    WSACleanup;
  end;
end;


procedure TConfig.DXPlay1Message(Sender: TObject; From: TDXPlayPlayer;
  Data: Pointer; DataSize: Integer);
type
  TDXChatMessage = record
    address:word;
    startvalue:byte;
    endvalue:byte;
    fadetime:LongWord;
    Len: Word;
    Name: Array[0..0] of Char;
  end;
var
  name:string;
  t,h,min,s,ms:integer;
begin
  SetLength(name,TDXChatMessage(Data^).Len);
  StrLCopy(pChar(name),TDXChatMessage(Data^).Name,TDXChatMessage(Data^).Len);

//  TDXChatMessage(Data^).address;
//  TDXChatMessage(Data^).startvalue;
//  TDXChatMessage(Data^).endvalue;
//  TDXChatMessage(Data^).fadetime;
//  name

  IsSending:=true;
  RefreshDLLValues(TDXChatMessage(Data^).address,TDXChatMessage(Data^).startvalue,TDXChatMessage(Data^).endvalue,TDXChatMessage(Data^).fadetime,0);
  RefreshDLLNames(TDXChatMessage(Data^).address,PChar(copy(name,1,length(name))));

  if config.Showing then
  begin
    Edit1.Text:=inttostr(TDXChatMessage(Data^).address);
    Edit4.Text:=inttostr(round(TDXChatMessage(Data^).startvalue/255*100))+'%';
    Edit3.Text:=inttostr(round(TDXChatMessage(Data^).endvalue/255*100))+'%';
    Edit2.Text:=inttostr(TDXChatMessage(Data^).fadetime)+' ms';
    edit1.Hint:=name;

    t:=TDXChatMessage(Data^).fadetime;
    h:=t div 3600000;
    t:=t mod 3600000;
    min:=t div 60000;
    t:=t mod 60000;
    s:=t div 1000;
    t:=t mod 1000;
    ms:=t;
    fadezeit_label.Caption:='Fadezeit: '+inttostr(h)+'h '+inttostr(min)+'min '+inttostr(s)+'s '+inttostr(ms)+'ms';
  end;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  label6.Caption:=GetIPAddress;
  label2.visible:=DXPlay1.IsHost;
end;

procedure TConfig.Button1Click(Sender: TObject);
begin
  if DXplay1.Opened then
    DXplay1.Close;
  DXplay1.Open;

  CheckSession;
end;

procedure TConfig.DXPlay1Open(Sender: TObject);
begin
  label2.visible:=DXPlay1.IsHost;
end;

procedure TConfig.DXPlay1AddPlayer(Sender: TObject; Player: TDXPlayPlayer);
var
  i:integer;
  text:string;
begin
  if not (dxplay1.Players.Count>1) then exit;

  text:='';
  for i:=1 to dxplay1.Players.Count-1 do
    text:=text+dxplay1.Players.Players[i].Name+'  ';

  CheckSession;
end;

procedure TConfig.DXPlay1DeletePlayer(Sender: TObject;
  Player: TDXPlayPlayer);
begin
  CheckSession;
end;

procedure TConfig.DXPlay1Close(Sender: TObject);
begin
  CheckSession;
end;

procedure TConfig.DXPlay1SessionLost(Sender: TObject);
begin
  CheckSession;
end;

procedure TConfig.CheckSession;
begin
  if dxplay1.Opened then
  begin
    Label5.Caption:='Verbunden mit "'+DXPlay1.SessionName;
    Label5.Font.Color:=clGreen;
  end else
  begin
    Label5.Caption:='Nicht verbunden...';
    Label5.Font.Color:=clRed;
  end;
end;

procedure TConfig.Button2Click(Sender: TObject);
begin
  if DXPlay1.Opened then
    DXPlay1.Close;

  CheckSession;
end;

end.
