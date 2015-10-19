unit timingfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExMask, JvSpin, Mask;

type
  Ttimingform = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    breaktimescrollbar: TScrollBar;
    marktimescrollbar: TScrollBar;
    interbytetimescrollbar: TScrollBar;
    interframetimescrollbar: TScrollBar;
    breaktimelabel: TLabel;
    marktimelabel: TLabel;
    interbytetimelabel: TLabel;
    interframetimelabel: TLabel;
    Label9: TLabel;
    maxchansedit: TJvSpinEdit;
    Label10: TLabel;
    startbyteedit: TJvSpinEdit;
    useinterbytedelaycheckbox: TCheckBox;
    okbutton: TButton;
    useinterframedelaycheckbox: TCheckBox;
    saveineeprombutton: TButton;
    resetbutton: TButton;
    procedure resetbuttonClick(Sender: TObject);
    procedure saveineeprombuttonClick(Sender: TObject);
    procedure breaktimescrollbarChange(Sender: TObject);
    procedure marktimescrollbarChange(Sender: TObject);
    procedure interbytetimescrollbarChange(Sender: TObject);
    procedure interframetimescrollbarChange(Sender: TObject);
    procedure maxchanseditChange(Sender: TObject);
    procedure startbyteeditChange(Sender: TObject);
    procedure useinterbytedelaycheckboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure useinterframedelaycheckboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    function getbreaktime(time:integer):string;
    function getmarktime(time:integer):string;
    function getinterbytetime(time:integer):string;
    function getinterframetime(time:integer):string;
  public
    { Public-Deklarationen }
    CurrentInterface:string;
  end;

var
  timingform: Ttimingform;

implementation

uses
  configfrm;

{$R *.dfm}

procedure Ttimingform.resetbuttonClick(Sender: TObject);
begin
  breaktimescrollbar.Position:=17;
  marktimescrollbar.Position:=13;
  interbytetimescrollbar.Position:=0;
  interframetimescrollbar.Position:=0;
  maxchansedit.Value:=512;
  startbyteedit.Value:=0;
  useinterbytedelaycheckbox.Checked:=false;
  useinterframedelaycheckbox.Checked:=false;

  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
end;

procedure Ttimingform.saveineeprombuttonClick(Sender: TObject);
begin
  StoreInterfaceAdvTxConfig(config.SerialstringToSerial(CurrentInterface));
end;

procedure Ttimingform.breaktimescrollbarChange(Sender: TObject);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
  breaktimelabel.Caption:=inttostr(breaktimescrollbar.Position)+' ('+getbreaktime(breaktimescrollbar.Position)+'us)';
end;

procedure Ttimingform.marktimescrollbarChange(Sender: TObject);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
  marktimelabel.Caption:=inttostr(marktimescrollbar.Position)+' ('+getmarktime(marktimescrollbar.Position)+'us)';
end;

procedure Ttimingform.interbytetimescrollbarChange(Sender: TObject);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
  interbytetimelabel.Caption:=inttostr(interbytetimescrollbar.Position)+' ('+getinterbytetime(interbytetimescrollbar.Position)+'us)';
end;

procedure Ttimingform.interframetimescrollbarChange(Sender: TObject);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
  interframetimelabel.Caption:=inttostr(interframetimescrollbar.Position)+' ('+getinterframetime(interframetimescrollbar.Position)+'us)';
end;

procedure Ttimingform.maxchanseditChange(Sender: TObject);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
end;

procedure Ttimingform.startbyteeditChange(Sender: TObject);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
end;

procedure Ttimingform.useinterbytedelaycheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
end;

procedure Ttimingform.useinterframedelaycheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetInterfaceAdvTxConfig(Config.SerialstringToSerial(CurrentInterface), Byte(1), breaktimescrollbar.Position, marktimescrollbar.Position, interbytetimescrollbar.Position, interframetimescrollbar.Position, round(maxchansedit.value), round(startbyteedit.value));
end;

function Ttimingform.getbreaktime(time:integer):string;
begin
  result:=inttostr(round(time*5.3330739+5));
end;

function Ttimingform.getmarktime(time:integer):string;
begin
  result:=inttostr(round(time*0.6660105+1));
end;

function Ttimingform.getinterbytetime(time:integer):string;
begin
  result:=inttostr(round(time*0.6660105+1));
end;

function Ttimingform.getinterframetime(time:integer):string;
begin
  result:=inttostr(round(time*21.333318+21));
end;


end.
