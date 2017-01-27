unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Menus, Buttons, messagesystem,
  Mask, JvExMask, JvSpin, JvFullColorDialogs;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

type
  TVUMeter = record
    Channel: Word;
    Color: TColor;
    Value:double;
    UseAsRGB:boolean;
  end;

  Tmainform = class(TForm)
    Button1: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Label3: TLabel;
    inputchannel: TJvSpinEdit;
    Label4: TLabel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    lampcount: TJvSpinEdit;
    changecount: TButton;
    Shape3: TShape;
    JvSpinEdit1: TJvSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    JvFullColorDialog1: TJvFullColorDialog;
    Label7: TLabel;
    Label8: TLabel;
    usevumeter: TCheckBox;
    Label9: TLabel;
    CheckBox1: TCheckBox;
    PopupMenu1: TPopupMenu;
    Adressendurchnummerieren1: TMenuItem;
    AllealsRGBnutzen1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure changecountClick(Sender: TObject);
    procedure Shape3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AllealsRGBnutzen1Click(Sender: TObject);
    procedure Adressendurchnummerieren1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    vumeter:array of TVUMeter;
    SelectedChannel:integer;
    procedure ProcessValue(Value: integer);
    procedure TColor2RGB(const AColor: TColor; var AR, AG, AB: Byte);
    function RGB2TColor(const AR, AG, AB: Byte): Integer;
    function GetModulePath2:String;
  end;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

procedure Tmainform.TColor2RGB(const AColor: TColor; var AR, AG, AB: Byte);
begin
  // convert hexa-decimal values to RGB
  AR := AColor and $FF;
  AG := (AColor shr 8) and $FF;
  AB := (AColor shr 16) and $FF;
end;

function Tmainform.RGB2TColor(const AR, AG, AB: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := AR + AG shl 8 + AB shl 16;
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

function Tmainform.GetModulePath2:String;
begin
  result:=GetModulePath;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tmainform.ProcessValue(Value: integer);
var
  i:integer;
  boxwidth:integer;
  R,G,B:byte;
begin
  // GUI aktualisieren (nur wenn sichtbar)
  if mainform.Showing then
  begin
    label9.visible:=false;
    for i:=0 to length(vumeter)-1 do
    begin
      if round(inputchannel.Value) = vumeter[i].Channel then
      begin
        label9.Visible:=true;
        exit;
      end;
    end;
  end;

  // Wert für jedes Element berechnen
  for i:=0 to length(vumeter)-1 do
  begin
    vumeter[i].value:=round((value-(256/length(vumeter))*i)*length(vumeter));
    if vumeter[i].value<0 then
      vumeter[i].value:=0
    else if vumeter[i].value>255 then
      vumeter[i].value:=255;
  end;

  // Werte an PC_DIMMER senden
  if usevumeter.Checked then
  begin
    for i:=0 to length(vumeter)-1 do
    begin
      if vumeter[i].UseAsRGB then
      begin
        TColor2RGB(vumeter[i].Color, R, G, B);
        SetDLLValues(vumeter[i].Channel, round(R*vumeter[i].Value/255), round(R*vumeter[i].Value/255), 0, 0);
        SetDLLValues(vumeter[i].Channel+1, round(G*vumeter[i].Value/255), round(G*vumeter[i].Value/255), 0, 0);
        SetDLLValues(vumeter[i].Channel+2, round(B*vumeter[i].Value/255), round(B*vumeter[i].Value/255), 0, 0);
      end else
      begin
        SetDLLValues(vumeter[i].Channel, round(vumeter[i].Value), round(vumeter[i].Value), 0, 0);
      end;
    end;
  end;
  
  // GUI aktualisieren (nur wenn sichtbar)
  if mainform.Showing then
  begin
    Label3.caption:=inttostr(Value);

    Paintbox1.Canvas.Brush.Style:=bsSolid;
    Paintbox1.Canvas.Pen.Style:=psSolid;

    boxwidth:=round(Paintbox1.Width/length(vumeter));
    for i:=0 to length(vumeter)-1 do
    begin
      TColor2RGB(vumeter[i].Color, R, G, B);

      if vumeter[i].Value<92 then vumeter[i].Value:=92;

      Paintbox1.Canvas.Brush.Color:=RGB2TColor(round(R*vumeter[i].Value/255), round(G*vumeter[i].Value/255), round(B*vumeter[i].Value/255));
      Paintbox1.Canvas.Pen.Color:=Paintbox1.Canvas.Brush.Color;

      Paintbox1.Canvas.Rectangle(boxwidth*i, 0, boxwidth*(i+1), Paintbox1.Height);
    end;
    Paintbox1.Canvas.Pen.Color:=clBlack;
    for i:=0 to length(vumeter)-2 do
    begin
      Paintbox1.Canvas.MoveTo(boxwidth*(i+1), 0);
      Paintbox1.Canvas.LineTo(boxwidth*(i+1), Paintbox1.Height);
    end;
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  i:integer;
begin
  setlength(vumeter, round(lampcount.value));
  for i:=0 to length(vumeter)-1 do
  begin
    vumeter[i].Channel:=i+1;
  end;
  vumeter[0].Color:=clLime;
  vumeter[1].Color:=clLime;
  vumeter[2].Color:=clLime;
  vumeter[3].Color:=clLime;
  vumeter[4].Color:=clYellow;
  vumeter[5].Color:=clYellow;
  vumeter[6].Color:=clYellow;
  vumeter[7].Color:=clRed;
end;

procedure Tmainform.changecountClick(Sender: TObject);
var
  oldlength,i:integer;
begin
  oldlength:=length(vumeter);

  setlength(vumeter, round(lampcount.value));

  if length(vumeter)>oldlength then
  begin
    for i:=oldlength to length(vumeter)-1 do
    begin
      vumeter[i].Channel:=i+1;
      vumeter[i].Color:=clWhite;
    end;
  end;
end;

procedure Tmainform.Shape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (SelectedChannel>-1) and (SelectedChannel<length(vumeter)) and JvFullColorDialog1.Execute then
  begin
    vumeter[SelectedChannel].Color:=JvFullColorDialog1.Color;
    shape3.Brush.Color:=vumeter[SelectedChannel].Color;
  end;
end;

procedure Tmainform.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    SelectedChannel:=trunc((X/Paintbox1.Width)*length(vumeter));
    label8.caption:=inttostr(SelectedChannel+1);

    if (SelectedChannel>-1) and (SelectedChannel<length(vumeter)) then
    begin
      shape3.Brush.Color:=vumeter[SelectedChannel].Color;
      jvspinedit1.Value:=vumeter[SelectedChannel].Channel;
      checkbox1.Checked:=vumeter[SelectedChannel].UseAsRGB;
      jvspinedit1.SetFocus;
      jvspinedit1.SelectAll;
    end;
  end;
end;

procedure Tmainform.JvSpinEdit1Change(Sender: TObject);
begin
  if (SelectedChannel>-1) and (SelectedChannel<length(vumeter)) then
  begin
    vumeter[SelectedChannel].Channel:=round(jvspinedit1.Value);
  end;
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (SelectedChannel>-1) and (SelectedChannel<length(vumeter)) then
  begin
    vumeter[SelectedChannel].UseAsRGB:=checkbox1.Checked;
  end;
end;

procedure Tmainform.AllealsRGBnutzen1Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(vumeter)-1 do
  begin
    vumeter[i].UseAsRGB:=true;
  end;
end;

procedure Tmainform.Adressendurchnummerieren1Click(Sender: TObject);
var
  i, Space:integer;
begin
  Space:=strtoint(InputBox('Auto-Adressierung', 'Bitte geben Sie die Kanalzahl eines einzelnen Gerätes an, damit die Abstände der Startadressen berechnet werden kann (bei Generic-Dimmern 1, RGB-Lampen 3, etc.)', '3'));

  for i:=0 to length(vumeter)-1 do
  begin
    vumeter[i].Channel:=i+i*(Space-1)+1;
  end;
end;

end.


