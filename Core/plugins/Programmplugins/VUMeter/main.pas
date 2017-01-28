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
  TVUArray = record
    InputChannel: Integer;
    InputValue: byte;
    IsActive:boolean;
    vumeter:array of TVUMeter;
  end;

  Tmainform = class(TForm)
    JvFullColorDialog1: TJvFullColorDialog;
    PopupMenu1: TPopupMenu;
    Adressendurchnummerieren1: TMenuItem;
    AllealsRGBnutzen1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Label9: TLabel;
    Button1: TButton;
    PaintBox1: TPaintBox;
    Label11: TLabel;
    GroupBox1: TGroupBox;
    changecount: TButton;
    usevumeter: TCheckBox;
    Label4: TLabel;
    inputchannel: TJvSpinEdit;
    Label1: TLabel;
    lampcount: TJvSpinEdit;
    Label10: TLabel;
    JvSpinEdit2: TJvSpinEdit;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Label6: TLabel;
    Shape3: TShape;
    Label5: TLabel;
    JvSpinEdit1: TJvSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
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
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    SelectedRow:integer;
    procedure RedrawVUMeter;
  public
    { Public-Deklarationen }
    SetDLLValues:TCallbackValues;
    SetDLLEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
    SelectedChannel:integer;
    VUArray: array of TVUArray;
    procedure ProcessValue;
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

procedure Tmainform.ProcessValue;
var
  i,j:integer;
  R,G,B:byte;
begin
  // GUI aktualisieren (nur wenn sichtbar)
  if mainform.Showing then
  begin
    label9.visible:=false;
    for i:=0 to length(vuarray)-1 do
    begin
      for j:=0 to length(vuarray[i].vumeter)-1 do
      begin
        if round(vuarray[i].InputChannel) = vuarray[i].vumeter[j].Channel then
        begin
          label9.Visible:=true;
          exit;
        end;
      end;
    end;
  end;

  // Wert für jedes Element berechnen
  for i:=0 to length(vuarray)-1 do
  begin
    for j:=0 to length(vuarray[i].vumeter)-1 do
    begin
      vuarray[i].vumeter[j].value:=round((vuarray[i].InputValue-(256/length(vuarray[i].vumeter))*j)*length(vuarray[i].vumeter));
      if vuarray[i].vumeter[j].value<0 then
        vuarray[i].vumeter[j].value:=0
      else if vuarray[i].vumeter[j].value>255 then
        vuarray[i].vumeter[j].value:=255;
    end;
  end;

  // Werte an PC_DIMMER senden
  for i:=0 to length(vuarray)-1 do
  begin
    if vuarray[i].IsActive then
    begin
      for j:=0 to length(vuarray[i].vumeter)-1 do
      begin
        if vuarray[i].vumeter[j].UseAsRGB then
        begin
          if (vuarray[i].vumeter[j].Channel>=1) and (vuarray[i].vumeter[j].Channel<=8192) then
          begin
            TColor2RGB(vuarray[i].vumeter[j].Color, R, G, B);
            SetDLLValues(vuarray[i].vumeter[j].Channel, round(R*vuarray[i].vumeter[j].Value/255), round(R*vuarray[i].vumeter[j].Value/255), 0, 0);
            SetDLLValues(vuarray[i].vumeter[j].Channel+1, round(G*vuarray[i].vumeter[j].Value/255), round(G*vuarray[i].vumeter[j].Value/255), 0, 0);
            SetDLLValues(vuarray[i].vumeter[j].Channel+2, round(B*vuarray[i].vumeter[j].Value/255), round(B*vuarray[i].vumeter[j].Value/255), 0, 0);
          end;
        end else
        begin
          if (vuarray[i].vumeter[j].Channel>=1) and (vuarray[i].vumeter[j].Channel<=8192) then
            SetDLLValues(vuarray[i].vumeter[j].Channel, round(vuarray[i].vumeter[j].Value), round(vuarray[i].vumeter[j].Value), 0, 0);
        end;
      end;
    end;
  end;

  RedrawVUMeter;
end;

procedure Tmainform.changecountClick(Sender: TObject);
var
  oldlength, oldlength_rows,i,j:integer;
begin
  oldlength_rows:=length(vuarray);
  setlength(vuarray, round(JvSpinEdit2.Value));

  if (SelectedRow>-1) and (SelectedRow<length(vuarray)) then
  begin
    if length(vuarray[SelectedRow].vumeter)>oldlength_rows then
    begin
      for i:=oldlength_rows to length(vuarray)-1 do
      begin
        vuarray[i].InputChannel:=401;
        setlength(vuarray[i].vumeter, 8);
        for j:=0 to length(vuarray[i].vumeter)-1 do
        begin
          vuarray[i].vumeter[j].Channel:=j+1;
          vuarray[i].vumeter[j].Color:=clWhite;
          vuarray[i].vumeter[j].UseAsRGB:=false;
        end;
      end;
    end;

    oldlength:=length(vuarray[SelectedRow].vumeter);
    setlength(vuarray[SelectedRow].vumeter, round(lampcount.value));

    vuarray[SelectedRow].IsActive:=usevumeter.Checked;
    vuarray[SelectedRow].InputChannel:=round(inputchannel.Value);

    if length(vuarray[SelectedRow].vumeter)>oldlength then
    begin
      for i:=oldlength to length(vuarray[SelectedRow].vumeter)-1 do
      begin
        vuarray[SelectedRow].vumeter[i].Channel:=i+1;
        vuarray[SelectedRow].vumeter[i].Color:=clWhite;
      end;
    end;
  end;
  ProcessValue;
end;

procedure Tmainform.Shape3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (SelectedRow>-1) and (SelectedRow<length(vuarray)) and
    (SelectedChannel>-1) and (SelectedChannel<length(vuarray[SelectedRow].vumeter)) and
    JvFullColorDialog1.Execute then
  begin
    vuarray[SelectedRow].vumeter[SelectedChannel].Color:=JvFullColorDialog1.Color;
    shape3.Brush.Color:=vuarray[SelectedRow].vumeter[SelectedChannel].Color;
  end;
end;

procedure Tmainform.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    SelectedRow:=trunc((Y/Paintbox1.Height)*length(vuarray));

    if SelectedRow>=length(vuarray) then
      SelectedRow:=length(vuarray)-1;

    if (SelectedRow>-1) and (SelectedRow<length(vuarray)) then
    begin
      label3.caption:=inttostr(SelectedRow+1);

      SelectedChannel:=trunc((X/Paintbox1.Width)*length(vuarray[SelectedRow].vumeter));
      label8.caption:=inttostr(SelectedChannel+1);

      usevumeter.Checked:=vuarray[SelectedRow].IsActive;
      inputchannel.Value:=vuarray[SelectedRow].InputChannel;
      lampcount.Value:=length(vuarray[SelectedRow].vumeter);

      if (SelectedChannel>-1) and (SelectedChannel<length(vuarray[SelectedRow].vumeter)) then
      begin
        shape3.Brush.Color:=vuarray[SelectedRow].vumeter[SelectedChannel].Color;
        jvspinedit1.Value:=vuarray[SelectedRow].vumeter[SelectedChannel].Channel;
        checkbox1.Checked:=vuarray[SelectedRow].vumeter[SelectedChannel].UseAsRGB;
        jvspinedit1.SetFocus;
        jvspinedit1.SelectAll;
      end;
    end;
  end;
end;

procedure Tmainform.JvSpinEdit1Change(Sender: TObject);
begin
  if (SelectedRow>-1) and (SelectedRow<length(vuarray)) and
   (SelectedChannel>-1) and (SelectedChannel<length(vuarray[SelectedRow].vumeter)) then
  begin
    vuarray[SelectedRow].vumeter[SelectedChannel].Channel:=round(jvspinedit1.Value);
  end;
end;

procedure Tmainform.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (SelectedRow>-1) and (SelectedRow<length(vuarray)) and
   (SelectedChannel>-1) and (SelectedChannel<length(vuarray[SelectedRow].vumeter)) then
  begin
    vuarray[SelectedRow].vumeter[SelectedChannel].UseAsRGB:=checkbox1.Checked;
  end;
end;

procedure Tmainform.AllealsRGBnutzen1Click(Sender: TObject);
var
  i:integer;
begin
  if (SelectedRow>-1) and (SelectedRow<length(vuarray)) then
  begin
    for i:=0 to length(vuarray[SelectedRow].vumeter)-1 do
    begin
      vuarray[SelectedRow].vumeter[i].UseAsRGB:=true;
    end;
  end;
end;

procedure Tmainform.Adressendurchnummerieren1Click(Sender: TObject);
var
  i, Space:integer;
begin
  if (SelectedRow>-1) and (SelectedRow<length(vuarray)) then
  begin
    Space:=strtoint(InputBox('Auto-Adressierung', 'Bitte geben Sie die Gesamt-Kanalzahl eines einzelnen Gerätes an, damit die Abstände der Startadressen berechnet werden kann (bei Generic-Dimmern 1, RGB-Lampen 3, etc.)', '3'));

    for i:=0 to length(vuarray[SelectedRow].vumeter)-1 do
    begin
      vuarray[SelectedRow].vumeter[i].Channel:=i+i*(Space-1)+1;
    end;
  end;
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  RedrawVUMeter;
  Timer1.Enabled:=true;
end;

procedure Tmainform.RedrawVUMeter;
var
  i, j, boxwidth:integer;
  R,G,B:byte;
begin
  // GUI aktualisieren (nur wenn sichtbar)
  if mainform.Showing then
  begin
    Paintbox1.Canvas.Brush.Style:=bsSolid;
    Paintbox1.Canvas.Pen.Style:=psSolid;

    for i:=0 to length(vuarray)-1 do
    begin
      boxwidth:=round(Paintbox1.Width/length(vuarray[i].vumeter));
      for j:=0 to length(vuarray[i].vumeter)-1 do
      begin
        TColor2RGB(vuarray[i].vumeter[j].Color, R, G, B);

        if vuarray[i].vumeter[j].Value<92 then vuarray[i].vumeter[j].Value:=92;

        Paintbox1.Canvas.Brush.Color:=RGB2TColor(round(R*vuarray[i].vumeter[j].Value/255), round(G*vuarray[i].vumeter[j].Value/255), round(B*vuarray[i].vumeter[j].Value/255));
        Paintbox1.Canvas.Pen.Color:=Paintbox1.Canvas.Brush.Color;

        Paintbox1.Canvas.Rectangle(boxwidth*j, round(i*Paintbox1.Height/length(vuarray)), boxwidth*(j+1), round((i+1)*Paintbox1.Height/length(vuarray)));
      end;
    end;

    // Striche zeichnen
    Paintbox1.Canvas.Pen.Color:=clBlack;
    for i:=0 to length(vuarray)-1 do
    begin
      boxwidth:=round(Paintbox1.Width/length(vuarray[i].vumeter));
      for j:=0 to length(vuarray[i].vumeter)-2 do
      begin
        Paintbox1.Canvas.MoveTo(boxwidth*(j+1), round(i*Paintbox1.Height/length(vuarray)));
        Paintbox1.Canvas.LineTo(boxwidth*(j+1), round((i+1)*Paintbox1.Height/length(vuarray)));
      end;
    end;
  end;
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
begin
  RedrawVUMeter;
end;

procedure Tmainform.FormHide(Sender: TObject);
begin
  Timer1.Enabled:=false;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
end;

end.


