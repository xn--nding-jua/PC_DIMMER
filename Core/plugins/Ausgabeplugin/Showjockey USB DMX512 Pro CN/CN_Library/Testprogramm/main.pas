unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, pngimage, ExtCtrls, Mask, JvExMask, JvSpin;

type
  TDMXArray = array[0..511] of byte;
  PDMXArray = ^TDMXArray;
  TSerial = string[32];
  TSerialList = array[0..31] of TSerial;

  Tmainform = class(TForm)
    ScrollBar1: TScrollBar;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    XPManifest1: TXPManifest;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Button1: TButton;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    Button8: TButton;
    ListBox2: TListBox;
    Label1: TLabel;
    Label5: TLabel;
    ScrollBar2: TScrollBar;
    Label6: TLabel;
    Label7: TLabel;
    JvSpinEdit1: TJvSpinEdit;
    procedure ScrollBar1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Exit(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
  private
    { Private-Deklarationen }
    GetAllConnectedInterfaces:function:TSerialList;stdcall;
    GetAllOpenedInterfaces:function:TSerialList;stdcall;
    OpenLink:procedure(Serial: TSerial; DMXOutArray:PDMXArray);stdcall;
    CloseLink:procedure(Serial:TSerial);stdcall;
    CloseAllLinks:procedure;stdcall;
//    SetInterfaceAdvTxConfig:procedure(Serial:TSerial; MaxDMXChans: integer; MaxChangedChans:integer; TimerIntervall:integer);stdcall;
    DLL:THandle;
  public
    { Public-Deklarationen }
    DMXOutArray:TDMXArray;
  end;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

procedure Tmainform.ScrollBar1Change(Sender: TObject);
begin
  label1.Caption:=inttostr(Scrollbar1.position);
  DMXOutArray[0]:=Scrollbar1.Position;
end;

procedure Tmainform.Button1Click(Sender: TObject);
var
  i:integer;
  Serials:TSeriallist;
begin
  Serials:=GetAllConnectedInterfaces;

  Listbox1.Items.Clear;
  for i:=0 to 31 do
  begin
    if Serials[i]<>'00000000000000000000000000000000' then
      Listbox1.Items.Add(Serials[i]);
  end;

  Button2.Enabled:=Listbox1.ItemIndex>-1;
  Button3.Enabled:=Listbox1.ItemIndex>-1;
end;

procedure Tmainform.Button8Click(Sender: TObject);
var
  i:integer;
  Serials:TSeriallist;
begin
  Serials:=GetAllOpenedInterfaces;

  Listbox2.Items.Clear;
  for i:=0 to 31 do
  begin
    if (Serials[i]<>'00000000000000000000000000000000') then
      Listbox2.Items.Add(Serials[i]);
  end;
end;

procedure Tmainform.Button2Click(Sender: TObject);
begin
  if Listbox1.ItemIndex>-1 then
    OpenLink(Listbox1.Items[Listbox1.ItemIndex], @DMXOutArray);

  Button8Click(nil);
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  if Listbox1.ItemIndex>-1 then
    CloseLink(Listbox1.Items[Listbox1.ItemIndex]);

  Button8Click(nil);
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  CloseAllLinks;

  Button8Click(nil);
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAllLinks;
  FreeLibrary(DLL);
  DLL:=0;
end;

procedure Tmainform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Button2.Enabled:=Listbox1.ItemIndex>-1;
  Button3.Enabled:=Listbox1.ItemIndex>-1;
end;

procedure Tmainform.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Button2.Enabled:=Listbox1.ItemIndex>-1;
  Button3.Enabled:=Listbox1.ItemIndex>-1;
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  DLL:=LoadLibrary(PChar(ExtractFilePath(paramstr(0))+'\sj_dmx512.dll'));

  GetAllConnectedInterfaces:=GetProcAddress(DLL,'GetAllConnectedInterfaces');
  GetAllOpenedInterfaces:=GetProcAddress(DLL,'GetAllOpenedInterfaces');
  OpenLink:=GetProcAddress(DLL,'OpenLink');
  CloseLink:=GetProcAddress(DLL,'CloseLink');
  CloseAllLinks:=GetProcAddress(DLL,'CloseAllLinks');
//  SetInterfaceAdvTxConfig:=GetProcAddress(DLL,'SetInterfaceAdvTxConfig');

  Button1Click(nil);
end;

procedure Tmainform.ListBox1Exit(Sender: TObject);
begin
  Button2.Enabled:=Listbox1.ItemIndex>-1;
  Button3.Enabled:=Listbox1.ItemIndex>-1;
end;

procedure Tmainform.ScrollBar2Change(Sender: TObject);
begin
  label6.Caption:=inttostr(Scrollbar2.position);
  DMXOutArray[round(JvSpinEdit1.value)-1]:=Scrollbar2.Position;
end;

end.
