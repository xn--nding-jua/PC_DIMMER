unit joysticksetupfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, szenenverwaltung, befehleditorform, gnugettext,
  Mask, JvExMask, JvSpin, ExtCtrls;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  TBefehl = record
    ID : TGUID;
    Typ : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    OnValue : Word;
    SwitchValue:Word;
    InvertSwitchValue:boolean;
    OffValue : Word;
    ScaleValue:boolean;
    ArgInteger : array of Integer;
    ArgString : array of string[255];
    ArgGUID : array of TGUID;
  end;

  TBefehlposition = record
    GUID:TGUID;
    Bezeichnung:string;
    IntegerArgCount:Word;
    StringArgCount:Word;
    GUIDArgCount:Word;
    PositionCombobox2: integer;
  end;

  Tjoysticksetupform = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Button1: TButton;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    TrackBar2: TTrackBar;
    Label2: TLabel;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ZeitBox: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    hEdit: TEdit;
    minEdit: TEdit;
    sEdit: TEdit;
    msEdit: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Optionen1Box: TGroupBox;
    Arg1Label: TLabel;
    Arg1Edit: TEdit;
    Arg1Combobox: TComboBox;
    Optionen2Box: TGroupBox;
    Arg2Label: TLabel;
    Arg2Edit: TEdit;
    Arg2Combobox: TComboBox;
    devicelist: TComboBox;
    Optionen3Box: TGroupBox;
    Arg3Label: TLabel;
    Arg3Edit: TEdit;
    Arg3Combobox: TComboBox;
    OffValue: TJvSpinEdit;
    OnValue: TJvSpinEdit;
    grouplist: TComboBox;
    effektlist: TComboBox;
    CheckBox1: TCheckBox;
    invertaxis: TCheckBox;
    Shape4: TShape;
    Shape1: TShape;
    SwitchValue: TJvSpinEdit;
    Label3: TLabel;
    ScaleValue: TCheckBox;
    InvertSwitchValue: TCheckBox;
    CheckBox2: TCheckBox;
    procedure TrackBar2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure hEditChange(Sender: TObject);
    procedure Arg1EditChange(Sender: TObject);
    procedure Arg2EditChange(Sender: TObject);
    procedure Arg2bEditChange(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Arg1ComboboxSelect(Sender: TObject);
    procedure Arg2ComboboxSelect(Sender: TObject);
    procedure Arg3ComboboxSelect(Sender: TObject);
    procedure devicelistSelect(Sender: TObject);
    procedure grouplistSelect(Sender: TObject);
    procedure effektlistSelect(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure OnValueChange(Sender: TObject);
    procedure OffValueChange(Sender: TObject);
    procedure FillTimeBox(time: integer);
    procedure Arg3EditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure invertaxisMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
    procedure SwitchValueChange(Sender: TObject);
    procedure ScaleValueMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InvertSwitchValueMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    ManualEditingOfCombobox2:boolean;
    nousersetting:boolean;
    Befehlposition:array of TBefehlposition;
    midisettings:boolean;
  public
    { Public-Deklarationen }
  end;

var
  joysticksetupform: Tjoysticksetupform;

implementation

uses PCDIMMER, beatfrm;

{$R *.dfm}

procedure Tjoysticksetupform.TrackBar2Change(Sender: TObject);
begin
  if nousersetting then exit;

  Label2.caption:=inttostr(Trackbar2.position);
  mainform.JoystickEvents[Listbox1.itemindex].beschleunigung:=TrackBar2.Position;
end;

procedure Tjoysticksetupform.Button2Click(Sender: TObject);
begin
  Trackbar2.Position:=2000;
  Label2.caption:=inttostr(Trackbar2.position);
  mainform.JoystickEvents[Listbox1.itemindex].beschleunigung:=TrackBar2.Position;
end;

procedure Tjoysticksetupform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tjoysticksetupform.hEditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger)-1]:=strtoint(msEdit.Text)+strtoint(sEdit.text)*1000+strtoint(minEdit.Text)*60*1000+strtoint(hEdit.Text)*60*60*1000;
end;

procedure Tjoysticksetupform.Arg1EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  if s='-' then exit;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[0]:=strtoint(Arg1Edit.Text);
end;

procedure Tjoysticksetupform.Arg2EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  if s='-' then exit;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
end;

procedure Tjoysticksetupform.Arg2bEditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
end;

procedure Tjoysticksetupform.ComboBox1Select(Sender: TObject);
var
  i:integer;
begin
  Combobox2.Items.Clear;
  setlength(Befehlposition, 0);
  for i:=0 to length(mainform.Befehlssystem[Combobox1.itemindex].Steuerung)-1 do
  begin
    Combobox2.items.Add(mainform.Befehlssystem[Combobox1.itemindex].Steuerung[i].Bezeichnung);

    setlength(Befehlposition, length(Befehlposition)+1);
    Befehlposition[length(Befehlposition)-1].GUID:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].GUID;
    Befehlposition[length(Befehlposition)-1].Bezeichnung:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].Bezeichnung;
    Befehlposition[length(Befehlposition)-1].IntegerArgCount:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].IntegerArgCount;
    Befehlposition[length(Befehlposition)-1].StringArgCount:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].StringArgCount;
    Befehlposition[length(Befehlposition)-1].GUIDArgCount:=mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].GUIDArgCount;

    Befehlposition[length(Befehlposition)-1].PositionCombobox2:=Combobox2.Items.Count-1;
  end;

  // Aktuellen Befehl anzeigen
  for i:=0 to length(Befehlposition)-1 do
  begin
    if IsEqualGUID(mainform.JoystickEvents[Listbox1.itemindex].Befehl.Typ, Befehlposition[i].GUID) then
    begin
      Combobox2.ItemIndex:=Befehlposition[i].PositionCombobox2;
      ComboBox2Select(nil);
      break;
    end;
  end;
end;

procedure Tjoysticksetupform.ComboBox2Select(Sender: TObject);
var
  i,j:integer;
  cancel:boolean;
  AktuellerBefehl: TBefehl;
  SzenenData:PTreeData;
begin
  AktuellerBefehl.ID:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.ID;
  AktuellerBefehl.Typ:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.Typ;
  AktuellerBefehl.Name:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.Name;
  AktuellerBefehl.Beschreibung:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.Beschreibung;
  AktuellerBefehl.OnValue:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.OnValue;
  AktuellerBefehl.SwitchValue:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.SwitchValue;
  AktuellerBefehl.InvertSwitchValue:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.InvertSwitchValue;
  AktuellerBefehl.OffValue:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.OffValue;
  setlength(AktuellerBefehl.ArgInteger, length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger));
  for i:=0 to length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger)-1 do
    AktuellerBefehl.ArgInteger[i]:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[i];
  setlength(AktuellerBefehl.ArgString, length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgString));
  for i:=0 to length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgString)-1 do
    AktuellerBefehl.ArgString[i]:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgString[i];
  setlength(AktuellerBefehl.ArgGUID, length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID));
  for i:=0 to length(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID)-1 do
    AktuellerBefehl.ArgGUID[i]:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID[i];

  {$I EditBefehl.inc}

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ID:=AktuellerBefehl.ID;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.Typ:=AktuellerBefehl.Typ;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.Name:=AktuellerBefehl.Name;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.Beschreibung:=AktuellerBefehl.Beschreibung;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.OnValue:=AktuellerBefehl.OnValue;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.SwitchValue:=AktuellerBefehl.SwitchValue;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.InvertSwitchValue:=AktuellerBefehl.InvertSwitchValue;
  mainform.JoystickEvents[Listbox1.itemindex].Befehl.OffValue:=AktuellerBefehl.OffValue;
  setlength(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger, length(AktuellerBefehl.ArgInteger));
  for i:=0 to length(AktuellerBefehl.ArgInteger)-1 do
    mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[i]:=AktuellerBefehl.ArgInteger[i];
  setlength(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgString, length(AktuellerBefehl.ArgString));
  for i:=0 to length(AktuellerBefehl.ArgString)-1 do
    mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgString[i]:=AktuellerBefehl.ArgString[i];
  setlength(mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID, length(AktuellerBefehl.ArgGUID));
  for i:=0 to length(AktuellerBefehl.ArgGUID)-1 do
    mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID[i]:=AktuellerBefehl.ArgGUID[i];
end;

procedure Tjoysticksetupform.Arg1ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[0]:=Arg1Combobox.ItemIndex;
end;

procedure Tjoysticksetupform.Arg2ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[1]:=Arg2Combobox.ItemIndex;
end;

procedure Tjoysticksetupform.Arg3ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[2]:=Arg3Combobox.ItemIndex;
end;

procedure Tjoysticksetupform.devicelistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID[0]:=mainform.devices[devicelist.itemindex].ID;
end;

procedure Tjoysticksetupform.grouplistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID[0]:=mainform.devicegroups[grouplist.itemindex].ID;
end;

procedure Tjoysticksetupform.effektlistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgGUID[0]:=mainform.effektsequenzereffekte[effektlist.itemindex].ID;
end;

procedure Tjoysticksetupform.Edit1Change(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.Name:=Edit1.text;
end;

procedure Tjoysticksetupform.Edit2Change(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.Beschreibung:=Edit2.text;
end;

procedure Tjoysticksetupform.OnValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.OnValue:=round(OnValue.Value);
end;

procedure Tjoysticksetupform.OffValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.OffValue:=round(OffValue.Value);
end;

procedure Tjoysticksetupform.FillTimeBox(time: integer);
var
  t,h,min,s,ms:integer;
begin
  ZeitBox.Visible:=true;

  t:=time;
  h:=t div 3600000;
  t:=t mod 3600000;
  min:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  ms:=t;

  hEdit.text:=inttostr(h);
  minEdit.text:=inttostr(min);
  sEdit.text:=inttostr(s);
  msEdit.text:=inttostr(ms);
end;

procedure Tjoysticksetupform.Arg3EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  s:=TEdit(Sender).text;
  if s='-' then exit;
  i:=TEdit(Sender).selstart;
  mainform.input_number_minus(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ArgInteger[2]:=strtoint(Arg3Edit.Text);
end;

procedure Tjoysticksetupform.FormShow(Sender: TObject);
var
  i,j:integer;
begin
  nousersetting:=true;

  if listbox1.itemindex=-1 then
    Listbox1.itemindex:=0;
    
  Edit1.text:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.Name;
  Edit2.text:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.Beschreibung;
  OnValue.value:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.OnValue;
  SwitchValue.value:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.SwitchValue;
  InvertSwitchValue.checked:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.InvertSwitchValue;
  OffValue.Value:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.OffValue;
  ScaleValue.checked:=mainform.JoystickEvents[Listbox1.itemindex].Befehl.ScaleValue;
  Checkbox1.Checked:=mainform.JoystickEvents[Listbox1.itemindex].UseEvent;
  Checkbox2.Checked:=mainform.JoystickEvents[Listbox1.itemindex].PermanentUpdate;

  Radiobutton1.Checked:=not mainform.JoystickEvents[Listbox1.itemindex].positionrelativ;
  Radiobutton2.Checked:=mainform.JoystickEvents[Listbox1.itemindex].positionrelativ;
  invertaxis.Checked:=mainform.JoystickEvents[Listbox1.itemindex].invert;
  Trackbar2.Position:=mainform.JoystickEvents[Listbox1.itemindex].beschleunigung;

  devicelist.items.clear;
  for i:=0 to length(mainform.devices)-1 do
    devicelist.items.add(mainform.devices[i].Name);

  grouplist.items.clear;
  for i:=0 to length(mainform.DeviceGroups)-1 do
    grouplist.items.add(mainform.DeviceGroups[i].Name);

  effektlist.items.clear;
  for i:=0 to length(mainform.effektsequenzereffekte)-1 do
    effektlist.items.add(mainform.effektsequenzereffekte[i].name);

  Combobox1.Items.Clear;
  for i:=0 to length(mainform.Befehlssystem)-1 do
  begin
    Combobox1.Items.Add(mainform.Befehlssystem[i].Programmteil);
  end;

  // Aktuellen Befehl anzeigen
  for i:=0 to length(mainform.Befehlssystem)-1 do
  begin
    for j:=0 to length(mainform.Befehlssystem[i].Steuerung)-1 do
    begin
      if IsEqualGUID(mainform.JoystickEvents[Listbox1.itemindex].Befehl.Typ, mainform.Befehlssystem[i].Steuerung[j].GUID) then
      begin
        Combobox1.ItemIndex:=i;
        ComboBox1Select(nil); // über Combobox1.Select wird Combobox2 gefüllt
        break;
      end;
    end;
  end;

  Groupbox3.Enabled:=(Listbox1.ItemIndex>=0) and (Listbox1.ItemIndex<=7);

  nousersetting:=false;
end;

procedure Tjoysticksetupform.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormShow(nil);
end;

procedure Tjoysticksetupform.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormShow(nil);
end;

procedure Tjoysticksetupform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.JoystickEvents[Listbox1.itemindex].UseEvent:=Checkbox1.Checked;
end;

procedure Tjoysticksetupform.RadioButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].positionrelativ:=RadioButton2.Checked;
end;

procedure Tjoysticksetupform.invertaxisMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].invert:=invertaxis.Checked;
end;

procedure Tjoysticksetupform.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);

  if mainform.ShowButtonInTaskbar then
  begin
    Params.ExStyle:=WS_EX_APPWINDOW; // Params.ExStyle sorgt dafür, dass das Form einen eigenen Taskbareintrag erhält
    if mainform.ShowIconInTaskSwitcher then
    begin
      Params.WndParent:=GetDesktopWindow;
      self.ParentWindow := GetDesktopWindow;
    end;
  end;
end;

procedure Tjoysticksetupform.ComboBox2Enter(Sender: TObject);
begin
  ManualEditingOfCombobox2:=true;
end;

procedure Tjoysticksetupform.ComboBox2Exit(Sender: TObject);
begin
  ManualEditingOfCombobox2:=false;
end;

procedure Tjoysticksetupform.SwitchValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.SwitchValue:=round(SwitchValue.Value);
end;

procedure Tjoysticksetupform.ScaleValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.ScaleValue:=ScaleValue.checked;
end;

procedure Tjoysticksetupform.InvertSwitchValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  mainform.JoystickEvents[Listbox1.itemindex].Befehl.InvertSwitchValue:=InvertSwitchValue.checked;
end;

procedure Tjoysticksetupform.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.JoystickEvents[Listbox1.itemindex].PermanentUpdate:=Checkbox2.Checked;
end;

end.
