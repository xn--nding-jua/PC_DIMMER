unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CHHighResTimer, Mask, JvExMask, JvSpin;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  Tmainform = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    RefreshTimer: TCHHighResTimer;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    GroupBox4: TGroupBox;
    input2: TCheckBox;
    input3: TCheckBox;
    input4: TCheckBox;
    input5: TCheckBox;
    input6: TCheckBox;
    input7: TCheckBox;
    input8: TCheckBox;
    input9: TCheckBox;
    input0: TCheckBox;
    input1: TCheckBox;
    Timer1: TTimer;
    procedure RefreshTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLValueEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    issending:boolean;

    interface_open: integer;
    dmxout: array[0..511] of char;
    procedure CloseConnections;
    procedure Startup;
  end;

var
  mainform: Tmainform;

implementation

const
  DHC_OPEN = 1;
  DHC_CLOSE = 2;
  DHC_DMXOUTOFF = 3;
  DHC_DMXOUT = 4;
  DHC_PORTREAD = 5;
  DHC_PORTCONFIG = 6;
  DHC_RESET = 11;

function DasHardCommand(Command, Param: integer; Bloc: PChar): integer; cdecl; external 'DasHard_Siudi12.dll';

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

procedure Tmainform.RefreshTimerTimer(Sender: TObject);
var
  v:integer;
begin
  // DMX512 Senden
  v:=DasHardCommand(DHC_DMXOUT, 512, dmxout);
  if v < 0 then
  begin
    DasHardCommand(DHC_CLOSE, 0, nil);
    interface_open:=DasHardCommand(DHC_OPEN, 0, nil);
    RefreshTimer.Interval:=500;
  end else
  begin
    RefreshTimer.Interval:=50;
  end;
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  Timer1.enabled:=true;
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  portinfo:Word;
begin
  portinfo:=0;
  if checkbox1.Checked then portinfo:=portinfo OR 4;
  if checkbox2.Checked then portinfo:=portinfo OR 8;
  if checkbox3.Checked then portinfo:=portinfo OR 16;
  if checkbox4.Checked then portinfo:=portinfo OR 32;
  if checkbox5.Checked then portinfo:=portinfo OR 64;
  if checkbox6.Checked then portinfo:=portinfo OR 128;
  if checkbox7.Checked then portinfo:=portinfo OR 256;
  if checkbox8.Checked then portinfo:=portinfo OR 512;

  DasHardCommand(DHC_PORTCONFIG, portinfo, nil);
end;

procedure Tmainform.FormHide(Sender: TObject);
begin
  Timer1.enabled:=false;
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
var
  v:integer;
begin
  v:=DasHardCommand(DHC_PORTREAD, 0, nil);

  input0.Checked:=(v AND 1)=1;
  input1.Checked:=(v AND 2)=2;
  input2.Checked:=(v AND 4)=4;
  input3.Checked:=(v AND 8)=8;
  input4.Checked:=(v AND 16)=16;
  input5.Checked:=(v AND 32)=32;
  input6.Checked:=(v AND 64)=64;
  input7.Checked:=(v AND 128)=128;
  input8.Checked:=(v AND 256)=256;
  input9.Checked:=(v AND 512)=512;
end;

procedure Tmainform.CloseConnections;
begin
  RefreshTimer.Enabled:=false;
  Timer1.Enabled:=false;

  if interface_open > 0 then
    interface_open:=DasHardCommand(DHC_CLOSE, 0, nil);
end;

procedure Tmainform.Startup;
begin
  // Activate Outputplugin
  issending:=false;

  interface_open := DasHardCommand(DHC_OPEN, 0, nil);

  if interface_open > 0 then
    DasHardCommand(DHC_DMXOUTOFF, 0, nil);
end;

end.
