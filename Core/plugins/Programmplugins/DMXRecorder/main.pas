unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Menus, Buttons, messagesystem,
  CHHighResTimer, Mask, JvExMask, JvSpin;

const
  chan=512;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

type
  Tpluginscene = record
    ID: TGUID;
    Name: string;
  end;

  Tmainform = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    RecordTimer: TCHHighResTimer;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    intervaledit: TJvSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox2: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label4: TLabel;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RecordTimerTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure intervaleditChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    DMXValues, DMXValuesOld:array[1..chan] of array[1..3] of integer;
    PastTime:array[1..chan] of Cardinal;


    RecordTime:Cardinal;

    SetDLLValues:TCallbackValues;
    SetDLLEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;
  end;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

procedure Tmainform.Button2Click(Sender: TObject);
begin
  RecordTime:=0;
  Listbox1.Items.Clear;

  RecordTimer.Enabled:=True;

  Button2.Enabled:=False;
  Button3.Enabled:=True;
end;

procedure Tmainform.Button3Click(Sender: TObject);
begin
  RecordTimer.Enabled:=False;

  Button2.Enabled:=True;
  Button3.Enabled:=False;
end;

procedure Tmainform.RecordTimerTimer(Sender: TObject);
var
  i:integer;
begin
  RecordTime:=RecordTime+round(intervaledit.value);

  for i:=1 to 512 do
  begin
    // die Zeiten der einzelnen Kanäle noch inkrementieren
    PastTime[i]:=PastTime[i]+round(intervaledit.value);


    // Startwert ist Unterschiedlich zu Endwert oder Endwert ist unterschiedlich zu letztem Endwert
    if (DMXValues[i][1]<>DMXValues[i][2]) or (DMXValues[i][2]<>DMXValuesOld[i][2]) then
    begin
      if Radiobutton1.Checked then
        PastTime[i]:=RecordTime; // Absolute Zeit eintragen

      if CheckBox1.Checked and Radiobutton4.Checked then
      begin
        if Checkbox2.Checked then
          ListBox1.ItemIndex:=ListBox1.Items.Add(inttostr(PastTime[i])+' '+inttostr(i)+' '+inttostr(DMXValues[i][1])+' '+inttostr(DMXValues[i][2])+' '+inttostr(DMXValues[i][3]))
        else
          ListBox1.ItemIndex:=ListBox1.Items.Add(inttostr(PastTime[i])+'ms Ch: '+inttostr(i)+' from: '+inttostr(DMXValues[i][1])+' to: '+inttostr(DMXValues[i][2])+' in: '+inttostr(DMXValues[i][3])+'ms');
      end else
      begin
        if Checkbox2.Checked then
          Listbox1.ItemIndex:=Listbox1.Items.Add(inttostr(PastTime[i])+' '+inttostr(i)+' '+inttostr(DMXValues[i][2]))
        else
          Listbox1.ItemIndex:=Listbox1.Items.Add(inttostr(PastTime[i])+'ms Ch: '+inttostr(i)+' to '+inttostr(DMXValues[i][2]));
      end;

      // Werte zurücksetzen
      if (DMXValues[i][1]<>DMXValues[i][2]) then
        DMXValues[i][1]:=DMXValues[i][2]; // Startwert nun auf Endwert setzen, damit es nicht ununterbrochen Aufnimmt - wir gehen einfach mal davon aus, dass der Fade beendet wird

      PastTime[i]:=0;
      DMXValuesOld[i][1]:=DMXValues[i][1];
      DMXValuesOld[i][2]:=DMXValues[i][2];
      DMXValuesOld[i][3]:=DMXValues[i][3];
    end;
  end;
end;

procedure Tmainform.Button4Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    Listbox1.Items.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure Tmainform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tmainform.intervaleditChange(Sender: TObject);
begin
  RecordTimer.Interval:=round(intervaledit.Value);
end;

end.


