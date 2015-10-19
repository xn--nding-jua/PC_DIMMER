unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, StdCtrls, XPMan;

type
  TSERIAL = array[0..15] of Char;
  TSERIALLIST = array[0..31] of TSERIAL;
  THOSTDEVICECHANGEPROC = procedure; stdcall;
  THOSTINPUTCHANGEPROC = procedure; stdcall;
  THOSTINPUTCHANGEPROCBLOCK = procedure(blocknumber: byte); stdcall; // >= v1.1

  Tmainform = class(TForm)
    Image1: TImage;
    Shape1: TShape;
    Label1: TLabel;
    cbConnectedInterfaces: TComboBox;
    Button1: TButton;
    cbBetriebsmodus: TComboBox;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    XPManifest1: TXPManifest;
    GroupBox1: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    ScrollBar6: TScrollBar;
    ScrollBar7: TScrollBar;
    ScrollBar8: TScrollBar;
    GroupBox2: TGroupBox;
    lbOpenedDevices: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cbBetriebsmodusSelect(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    DMXOutArray, DMXInArray: array[0..511] of Byte;
    function SerialToSerialstring(Serial: TSERIAL): string;
    function SerialstringToSerial(Serialstr: string): TSERIAL;
    procedure SearchForInterfaces;
    procedure ShowOpenedDevices;
  end;

var
  mainform: Tmainform;

function GetAllConnectedInterfaces: TSERIALLIST; stdcall external 'usbdmx.dll';
function GetAllOpenedInterfaces: TSERIALLIST; stdcall external 'usbdmx.dll';
function SetInterfaceMode(Serial: TSERIAL; Mode: byte): DWORD; stdcall external 'usbdmx.dll';
function OpenLink(Serial: TSERIAL; DMXOutArray: Pointer; DMXInArray: Pointer): DWORD; stdcall external 'usbdmx.dll';
function CloseLink(Serial: TSERIAL): DWORD; stdcall external 'usbdmx.dll';
function CloseAllLinks: DWORD; stdcall external 'usbdmx.dll';
function RegisterInterfaceChangeNotification(Proc: THOSTDEVICECHANGEPROC): DWORD; stdcall external 'usbdmx.dll';
function UnregisterInterfaceChangeNotification: DWORD; stdcall external 'usbdmx.dll';
function RegisterInputChangeNotification(Proc: THOSTINPUTCHANGEPROC): DWORD; stdcall external 'usbdmx.dll';
function UnregisterInputChangeNotification: DWORD; stdcall external 'usbdmx.dll';
function GetDeviceVersion(Serial: TSERIAL): DWORD; stdcall external 'usbdmx.dll';
function SetInterfaceAdvTxConfig(Serial: TSERIAL; Control: Byte; Breaktime: word; Marktime: word; Interbytetime: word; Interframetime: word; Channelcount: word; Startbyte: byte): DWORD; stdcall; stdcall external 'usbdmx.dll';
function StoreInterfaceAdvTxConfig(Serial: TSERIAL): DWORD; stdcall; stdcall external 'usbdmx.dll';
function RegisterInputChangeBlockNotification(Proc: THOSTINPUTCHANGEPROCBLOCK): DWORD; stdcall external 'usbdmx.dll';
function UnregisterInputChangeBlockNotification: DWORD; stdcall external 'usbdmx.dll';

implementation

{$R *.dfm}

// Diese Funktion wird bei neueren Delphi-Versionen nicht mehr benötigt,
// da das Array of Char automatisch zu einem String konvertiert wird
function Tmainform.SerialToSerialstring(Serial: TSERIAL): string;
var
  i: byte;
begin
  Result := '';
  for i := 0 to 15 do
    Result := Result + Serial[i];
end;

function Tmainform.SerialstringToSerial(Serialstr: string): TSERIAL;
var
  i: byte;
  len: byte;
begin
  len := length(Serialstr);
  if len > 16 then
    len := 16;
  for i := 0 to 15 do
    Result[i] := '0';
  for i := 1 to len do
    Result[i + 15 - len] := Serialstr[i];
end;

procedure Tmainform.SearchForInterfaces;
var
  i:integer;
begin
  cbConnectedInterfaces.Items.Clear;
  for i:=0 to length(GetAllConnectedInterfaces)-1 do
  begin
    if GetAllConnectedInterfaces[i]<>'0000000000000000' then
      cbConnectedInterfaces.Items.Add(GetAllConnectedInterfaces[i]);
  end;
  if cbConnectedInterfaces.Items.Count>0 then
    cbConnectedInterfaces.ItemIndex:=0;
end;

procedure Tmainform.ShowOpenedDevices;
var
  i:integer;
begin
  lbOpenedDevices.Items.Clear;

  for i:=0 to length(GetAllOpenedInterfaces)-1 do
  begin
    if GetAllOpenedInterfaces[i]<>'0000000000000000' then
      lbOpenedDevices.Items.Add(GetAllOpenedInterfaces[i]);
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  SearchForInterfaces;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  SearchForInterfaces;
end;

procedure Tmainform.Button2Click(Sender: TObject);
begin
  if cbConnectedInterfaces.ItemIndex>-1 then
  begin
    OpenLink(SerialstringToSerial(cbConnectedInterfaces.Items[cbConnectedInterfaces.itemindex]),@DMXOutArray,@DMXInArray);
    SetInterfaceMode(SerialstringToSerial(cbConnectedInterfaces.Items[cbConnectedInterfaces.itemindex]),cbBetriebsmodus.ItemIndex);
  end;

  ShowOpenedDevices;
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  if cbConnectedInterfaces.ItemIndex>-1 then
    CloseLink(SerialstringToSerial(cbConnectedInterfaces.Items[cbConnectedInterfaces.itemindex]));

  ShowOpenedDevices;
end;

procedure Tmainform.cbBetriebsmodusSelect(Sender: TObject);
begin
  if cbConnectedInterfaces.ItemIndex>-1 then
    SetInterfaceMode(SerialstringToSerial(cbConnectedInterfaces.Items[cbConnectedInterfaces.itemindex]),cbBetriebsmodus.ItemIndex);
end;

procedure Tmainform.Button4Click(Sender: TObject);
var
  tempstring:string;
begin
  if cbConnectedInterfaces.ItemIndex>-1 then
  begin
    tempstring:=inttohex(GetDeviceVersion(SerialstringToSerial(cbConnectedInterfaces.Items[cbConnectedInterfaces.itemindex])),3);
    insert('.',tempstring,2);
    ShowMessage(tempstring);
  end;
end;

procedure Tmainform.ScrollBar1Change(Sender: TObject);
var
  i:integer;
begin
  for i:=1 to 8 do
  begin
    if Sender=TScrollBar(FindComponent('ScrollBar'+inttostr(i))) then
    begin
      DMXOutArray[i-1]:=255-TScrollBar(FindComponent('ScrollBar'+inttostr(i))).Position;
      break;
    end;
  end;
end;

end.
