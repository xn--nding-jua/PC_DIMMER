unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, DMX4ALL_Defines, Mask, JvExMask,
  JvSpin, XPMan;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = procedure(address:integer);stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; ARG:Variant);stdcall;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    Shape1: TShape;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Button7: TButton;
    Button8: TButton;
    GroupBox4: TGroupBox;
    Button9: TButton;
    Button10: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    GroupBox5: TGroupBox;
    Button18: TButton;
    Button19: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    endch: TJvSpinEdit;
    startch: TJvSpinEdit;
    Label1: TLabel;
    XPManifest1: TXPManifest;
    Label2: TLabel;
    Label3: TLabel;
    Button21: TButton;
    Button22: TButton;
    ListBox1: TListBox;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Edit1: TEdit;
    Button26: TButton;
    Button1: TButton;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure ConfigOKClick(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    function ErrorStr(ErrorCode: integer):string;
    function ProductStr(ProductID: integer):string;
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;
    DMXOutArray, DMXInArray: PData;

  end;

var
  mainform: Tmainform;

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

procedure Tmainform.FormCreate(Sender: TObject);
begin
  issending:=false;
end;

function TMainform.ErrorStr(ErrorCode: integer):string;
begin
  case ErrorCode of
    0: result:='Es liegt kein Fehler vor.';
    1: result:='COM-Port nicht verfügbar...';
    2: result:='Kein DMX4ALL-Interface gefunden...';
    3: result:='USB Verbindung konnte nicht geöffnet werden...';
    4: result:='Ungültiger Port...';
    10: result:='Übertragung fehlgeschlagen...';
  else
    result:='Unbekannter Fehler (Error '+inttostr(ErrorCode)+')...';
  end;
end;

function TMainform.ProductStr(ProductID: integer):string;
begin
  case ProductID of
    0: result:='Kein DMX4ALL-Interface gefunden!';
    2: result:='Mini-USB-DMX-Interface';
    3: result:='PC-DMX-Interface V3';
    4: result:='PC-DMX-Interface V4';
    5: result:='Easy-Light-Control';
    6: result:='USB-DMX STAGE-PROFI';
    7: result:='LAN-DMX STAGE-PROFI';
    8: result:='DMX-Player S';
    9: result:='DMX-Player XL';
    10: result:='DMX-Player XS';
    11: result:='DMX-Player M';
    20: result:='DMX-IN STAGE-PROFI';
  else
    result:='Unbekanntes Interface (ID '+inttostr(ProductID)+')...';
  end;
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte zu Universe 1...');
  if Dmx4allSetUniverse(0) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte zu Universe 2...');
  if Dmx4allSetUniverse(1) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button5Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte zu Universe 5...');
  if Dmx4allSetUniverse(4) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button6Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte zu Universe 8...');
  if Dmx4allSetUniverse(7) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button7Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte auf Martin-Pinbelegung...');
  if Dmx4allSetPinout(false) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button8Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte auf Internationale-Pinbelegung...');
  if Dmx4allSetPinout(true) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button9Click(Sender: TObject);
begin
  memo1.Lines.Add('Setze COM-Port Eigenschaften...');
  if Dmx4allSetComParameters(19200) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button10Click(Sender: TObject);
begin
  memo1.Lines.Add('Setze COM-Port Eigenschaften...');
  if Dmx4allSetComParameters(38400) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button12Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte zu Universe 16...');
  if Dmx4allSetUniverse(15) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button13Click(Sender: TObject);
var
  ID:integer;
begin
  memo1.Lines.Add('Ermittle Produkt-ID...');
  if Dmx4allGetProductID(@ID) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';

  showmessage(ProductStr(ID));
end;

procedure Tmainform.Button14Click(Sender: TObject);
var
  ID:integer;
begin
  memo1.Lines.Add('Ermittle Fehler-ID...');
  if Dmx4allLastError(@ID) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';

  showmessage(ErrorStr(ID));
end;

procedure Tmainform.Button15Click(Sender: TObject);
begin
  memo1.Lines.Add('Starte Interface neu...');
  if Dmx4allRebootInterface then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button16Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte Blackout ein...');
  if Dmx4allSetBlackOut(true) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button17Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte Blackout aus...');
  if Dmx4allSetBlackOut(false) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button19Click(Sender: TObject);
begin
  if radiobutton1.Checked then
  begin
    memo1.Lines.Add('Schalte Merging ein (Replace-Mode)...');

    if Dmx4allSetMerge(true, round(startch.value), round(endch.value), 0) then
      memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
    else
      memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
  end else
  begin
    memo1.Lines.Add('Schalte Merging ein (HTP-Mode)...');

    if Dmx4allSetMerge(true, round(startch.value), round(endch.value), 1) then
      memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
    else
      memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
  end;
end;

procedure Tmainform.ConfigOKClick(Sender: TObject);
begin
  close;
end;

procedure Tmainform.Button21Click(Sender: TObject);
begin
  memo1.lines.Clear;
end;

procedure Tmainform.Button22Click(Sender: TObject);
var
  numDevs, PortIndex:DWORD;
  Desc:array[0..49] of char;
  i:integer;
begin
  setlength(DMXOutArray, 512);

  Listbox1.Items.Clear;

  // Nach Interfaces suchen
  Dmx4allCreateInterfaceList(@numDevs);

  if numDevs>0 then
  begin
    for i:=0 to numDevs-1 do
    begin
      Dmx4allGetInterfaceDetail(i, @PortIndex, Desc, 50);

      Listbox1.Items.add(Desc+' (COM'+inttostr(PortIndex)+')');
    end;
  end;
end;

procedure Tmainform.Button23Click(Sender: TObject);
begin
  Dmx4allOpenPort(strtoint(Edit1.text));
end;

procedure Tmainform.Button24Click(Sender: TObject);
begin
  Dmx4allSetDmxCh(1,127);
end;

procedure Tmainform.Button25Click(Sender: TObject);
begin
  Dmx4allClosePort;
end;

procedure Tmainform.Button26Click(Sender: TObject);
begin
  Dmx4allSetDmx(1, 512, DMXOutArray);
end;

procedure Tmainform.Button18Click(Sender: TObject);
begin
  memo1.Lines.Add('Schalte Merging aus...');

  if Dmx4allSetMerge(false, round(startch.value), round(endch.value), 1) then
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'OK'
  else
    memo1.Lines[memo1.Lines.Count-1]:=memo1.Lines[memo1.Lines.Count-1]+'Error';
end;

procedure Tmainform.Button1Click(Sender: TObject);
var
  channels:integer;
begin
  Dmx4allGetNrOfChannelsIn(@channels);
  showmessage(inttostr(channels));

  setlength(DMXInArray, 512);
  if Dmx4allGetInDmx(1, 512, DMXInArray) then showmessage('OK') else showmessage('Reading DMX-In failed!');
  showmessage(inttostr(length(DMXInArray)));

  Memo2.Lines.Clear;
  Memo2.Lines.Add(inttostr(1)+': '+inttostr(DMXInArray[0]));
  Memo2.Lines.Add(inttostr(2)+': '+inttostr(DMXInArray[1]));
  Memo2.Lines.Add(inttostr(3)+': '+inttostr(DMXInArray[2]));
  Memo2.Lines.Add(inttostr(4)+': '+inttostr(DMXInArray[3]));
  Memo2.Lines.Add(inttostr(5)+': '+inttostr(DMXInArray[4]));
  Memo2.Lines.Add(inttostr(6)+': '+inttostr(DMXInArray[5]));
  Memo2.Lines.Add(inttostr(7)+': '+inttostr(DMXInArray[6]));
  Memo2.Lines.Add(inttostr(8)+': '+inttostr(DMXInArray[7]));
  Memo2.Lines.Add(inttostr(9)+': '+inttostr(DMXInArray[8]));
  Memo2.Lines.Add(inttostr(10)+': '+inttostr(DMXInArray[9]));
end;

end.
