unit editmidievent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, szenenverwaltung, befehleditorform, gnugettext,
  Mask, JvExMask, JvSpin;

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
    SwitchValue : Word;
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

  Teditmidieventfrm = class(TForm)
    GroupBox1: TGroupBox;
    okbtn: TButton;
    cancelbtn: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    recordmidi: TCheckBox;
    message1b: TLabel;
    data1b: TLabel;
    data2b: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    message1a: TEdit;
    data1a: TEdit;
    data2a: TEdit;
    Label1: TLabel;
    data1chk: TRadioButton;
    data2chk: TRadioButton;
    usemidibacktrack: TCheckBox;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
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
    Label18: TLabel;
    MSGbox: TComboBox;
    Data1box: TComboBox;
    Shape4: TShape;
    Shape1: TShape;
    SwitchValue: TJvSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label19: TLabel;
    ScaleValue: TCheckBox;
    InvertSwitchValue: TCheckBox;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure data1aChange(Sender: TObject);
    procedure data2aChange(Sender: TObject);
    procedure message1aChange(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;

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
    procedure MSGboxSelect(Sender: TObject);
    procedure Data1boxSelect(Sender: TObject);
    procedure MSGboxDropDown(Sender: TObject);
    procedure MSGboxCloseUp(Sender: TObject);
    procedure Data1boxDropDown(Sender: TObject);
    procedure Data1boxCloseUp(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure SwitchValueChange(Sender: TObject);
    procedure ScaleValueMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InvertSwitchValueMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    ManualEditingOfCombobox2:boolean;
    nousersetting:boolean;
    Befehlposition:array of TBefehlposition;
    midisettings:boolean;
  public
    { Public-Deklarationen }
    AktuellerBefehl: TBefehl;
  end;

var
  editmidieventfrm: Teditmidieventfrm;

implementation

uses PCDIMMER, beatfrm, joysticksetupfrm;

{$R *.dfm}

procedure Teditmidieventfrm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Teditmidieventfrm.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Teditmidieventfrm.data1aChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Teditmidieventfrm.data2aChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;

procedure Teditmidieventfrm.message1aChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
end;


procedure Teditmidieventfrm.hEditChange(Sender: TObject);
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

  AktuellerBefehl.ArgInteger[length(AktuellerBefehl.ArgInteger)-1]:=strtoint(msEdit.Text)+strtoint(sEdit.text)*1000+strtoint(minEdit.Text)*60*1000+strtoint(hEdit.Text)*60*60*1000;
end;

procedure Teditmidieventfrm.Arg1EditChange(Sender: TObject);
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

  AktuellerBefehl.ArgInteger[0]:=strtoint(Arg1Edit.Text);
end;

procedure Teditmidieventfrm.Arg2EditChange(Sender: TObject);
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

  AktuellerBefehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
end;

procedure Teditmidieventfrm.Arg2bEditChange(Sender: TObject);
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

  AktuellerBefehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
end;

procedure Teditmidieventfrm.ComboBox1Select(Sender: TObject);
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
    if IsEqualGUID(AktuellerBefehl.Typ, Befehlposition[i].GUID) then
    begin
      Combobox2.ItemIndex:=Befehlposition[i].PositionCombobox2;
      ComboBox2Select(nil);
      break;
    end;
  end;
end;

procedure Teditmidieventfrm.ComboBox2Select(Sender: TObject);
var
  i,j:integer;
  cancel:boolean;
  SzenenData:PTreeData;
begin
  midisettings:=true;
  {$I EditBefehl.inc}
end;

procedure Teditmidieventfrm.Arg1ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[0]:=Arg1Combobox.ItemIndex;
end;

procedure Teditmidieventfrm.Arg2ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[1]:=Arg2Combobox.ItemIndex;
end;

procedure Teditmidieventfrm.Arg3ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[2]:=Arg3Combobox.ItemIndex;
end;

procedure Teditmidieventfrm.devicelistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.devices[devicelist.itemindex].ID;
end;

procedure Teditmidieventfrm.grouplistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.devicegroups[grouplist.itemindex].ID;
end;

procedure Teditmidieventfrm.effektlistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.effektsequenzereffekte[effektlist.itemindex].ID;

  ComboBox2Select(effektlist);
end;

procedure Teditmidieventfrm.Edit1Change(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.Name:=Edit1.text;
end;

procedure Teditmidieventfrm.Edit2Change(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.Beschreibung:=Edit2.text;
end;

procedure Teditmidieventfrm.OnValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.OnValue:=round(OnValue.Value/127*255);
end;

procedure Teditmidieventfrm.OffValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.OffValue:=round(OffValue.Value/127*255);
end;

procedure Teditmidieventfrm.FillTimeBox(time: integer);
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

procedure Teditmidieventfrm.Arg3EditChange(Sender: TObject);
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

  AktuellerBefehl.ArgInteger[2]:=strtoint(Arg3Edit.Text);
end;

procedure Teditmidieventfrm.FormShow(Sender: TObject);
var
  i,j:integer;
begin
  nousersetting:=true;
  Edit1.text:=AktuellerBefehl.Name;
  Edit2.text:=AktuellerBefehl.Beschreibung;
  OnValue.value:=(AktuellerBefehl.OnValue div 2);
  SwitchValue.value:=(AktuellerBefehl.SwitchValue div 2);
  InvertSwitchValue.checked:=(AktuellerBefehl.InvertSwitchValue);
  OffValue.Value:=(AktuellerBefehl.OffValue div 2);
  ScaleValue.checked:=AktuellerBefehl.ScaleValue;

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
      if IsEqualGUID(AktuellerBefehl.Typ, mainform.Befehlssystem[i].Steuerung[j].GUID) then
      begin
        Combobox1.ItemIndex:=i;
        ComboBox1Select(nil); // über Combobox1.Select wird Combobox2 gefüllt
        break;
      end;
    end;
  end;

  nousersetting:=false;
end;

procedure Teditmidieventfrm.MSGboxSelect(Sender: TObject);
begin
  data1box.Items.clear;

  case MSGbox.itemindex of
    0:
    begin
      message1a.text:='144';
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: G');
    end;
    1:
    begin
      message1a.text:='128';
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 0: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 1: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 2: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 3: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 4: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 5: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 6: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 7: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 8: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: G');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: G#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: A');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: A#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 9: B');

      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: C');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: C#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: D');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: D#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: E');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: F');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: F#');
      data1box.items.add(inttostr(data1box.items.count)+' - Oktave 10: G');
    end;
    2:
    begin
      message1a.text:='160';
      data1box.items.add('-');
    end;
    3:
    begin
      message1a.text:='176';
      data1box.items.add(inttostr(data1box.items.count)+' - Bank Select');
      data1box.items.add(inttostr(data1box.items.count)+' - Modulation wheel');
      data1box.items.add(inttostr(data1box.items.count)+' - Breath control');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Foot controller');
      data1box.items.add(inttostr(data1box.items.count)+' - Portamento time');
      data1box.items.add(inttostr(data1box.items.count)+' - Data Entry');
      data1box.items.add(inttostr(data1box.items.count)+' - Channel Volume');
      data1box.items.add(inttostr(data1box.items.count)+' - Balance');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Pan');
      data1box.items.add(inttostr(data1box.items.count)+' - Expression Controller');
      data1box.items.add(inttostr(data1box.items.count)+' - Effect control 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Effect control 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #1');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #2');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #3');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #4');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Bank Select');
      data1box.items.add(inttostr(data1box.items.count)+' - Modulation wheel');
      data1box.items.add(inttostr(data1box.items.count)+' - Breath control');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Foot controller');
      data1box.items.add(inttostr(data1box.items.count)+' - Portamento time');
      data1box.items.add(inttostr(data1box.items.count)+' - Data entry');
      data1box.items.add(inttostr(data1box.items.count)+' - Channel Volume');
      data1box.items.add(inttostr(data1box.items.count)+' - Balance');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Pan');
      data1box.items.add(inttostr(data1box.items.count)+' - Expression Controller');
      data1box.items.add(inttostr(data1box.items.count)+' - Effect control 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Effect control 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #1');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #2');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #3');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #4');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Damper pedal on/off (Sustain)');
      data1box.items.add(inttostr(data1box.items.count)+' - Portamento on/off');
      data1box.items.add(inttostr(data1box.items.count)+' - Sustenuto on/off');
      data1box.items.add(inttostr(data1box.items.count)+' - Soft pedal on/off');
      data1box.items.add(inttostr(data1box.items.count)+' - Legato Footswitch');
      data1box.items.add(inttostr(data1box.items.count)+' - Hold 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 1 (Sound Variation)');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 2 (Timbre)');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 3 (Release Time)');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 4 (Attack Time)');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 5 (Brightness)');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 6');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 7');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 8');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 9');
      data1box.items.add(inttostr(data1box.items.count)+' - Sound Controller 10');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #5');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #6');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #7');
      data1box.items.add(inttostr(data1box.items.count)+' - General Purpose Controller #8');
      data1box.items.add(inttostr(data1box.items.count)+' - Portamento Control');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Effects 1 (Reverb) Depth');
      data1box.items.add(inttostr(data1box.items.count)+' - Effects 2 (Tremolo) Depth');
      data1box.items.add(inttostr(data1box.items.count)+' - Effects 3 (Chorus) Depth');
      data1box.items.add(inttostr(data1box.items.count)+' - Effects 4 (Detune) Depth');
      data1box.items.add(inttostr(data1box.items.count)+' - Effects 5 (Phaser) Depth');
      data1box.items.add(inttostr(data1box.items.count)+' - Data entry +1');
      data1box.items.add(inttostr(data1box.items.count)+' - Data entry - 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Non- Registered Parameter Number LSB');
      data1box.items.add(inttostr(data1box.items.count)+' - Non- Registered Parameter Number MSB');
      data1box.items.add(inttostr(data1box.items.count)+' - Registered Parameter Number LSB');
      data1box.items.add(inttostr(data1box.items.count)+' - Registered Parameter Number MSB');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - Undefined');
      data1box.items.add(inttostr(data1box.items.count)+' - All Sound Off');
      data1box.items.add(inttostr(data1box.items.count)+' - Reset All Controllers');
      data1box.items.add(inttostr(data1box.items.count)+' - Local control on/off');
      data1box.items.add(inttostr(data1box.items.count)+' - All notes off');
      data1box.items.add(inttostr(data1box.items.count)+' - Omni mode off (+ all notes off)');
      data1box.items.add(inttostr(data1box.items.count)+' - Omni mode on (+ all notes off)');
      data1box.items.add(inttostr(data1box.items.count)+' - Poly mode on/off (+ all notes off)');
      data1box.items.add(inttostr(data1box.items.count)+' - Poly mode on');
    end;
    4:
    begin
      message1a.text:='192';
      data1box.items.add(inttostr(data1box.items.count)+' - Piano 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Piano 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Piano 3');
      data1box.items.add(inttostr(data1box.items.count)+' - Honky-Tonk');
      data1box.items.add(inttostr(data1box.items.count)+' - E. Piano 1');
      data1box.items.add(inttostr(data1box.items.count)+' - E. Piano 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Harpsichord');
      data1box.items.add(inttostr(data1box.items.count)+' - Clav.');
      data1box.items.add(inttostr(data1box.items.count)+' - Celesta');
      data1box.items.add(inttostr(data1box.items.count)+' - Glockenspiel');
      data1box.items.add(inttostr(data1box.items.count)+' - Music Box');
      data1box.items.add(inttostr(data1box.items.count)+' - Vibraphone');
      data1box.items.add(inttostr(data1box.items.count)+' - Marimba');
      data1box.items.add(inttostr(data1box.items.count)+' - Xylophone');
      data1box.items.add(inttostr(data1box.items.count)+' - Tubular-bell');
      data1box.items.add(inttostr(data1box.items.count)+' - Santur');
      data1box.items.add(inttostr(data1box.items.count)+' - Organ 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Organ 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Organ 3');
      data1box.items.add(inttostr(data1box.items.count)+' - Church Org. 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Reed Organ');
      data1box.items.add(inttostr(data1box.items.count)+' - Accordion Fr');
      data1box.items.add(inttostr(data1box.items.count)+' - Harmonica');
      data1box.items.add(inttostr(data1box.items.count)+' - Bandneon');
      data1box.items.add(inttostr(data1box.items.count)+' - Nylon-str. Gt');
      data1box.items.add(inttostr(data1box.items.count)+' - Steel-str. Gt');
      data1box.items.add(inttostr(data1box.items.count)+' - Jazz Gt.');
      data1box.items.add(inttostr(data1box.items.count)+' - Clean Gt.');
      data1box.items.add(inttostr(data1box.items.count)+' - Muted Gt.');
      data1box.items.add(inttostr(data1box.items.count)+' - Overdrive Gt');
      data1box.items.add(inttostr(data1box.items.count)+' - DistortionGt');
      data1box.items.add(inttostr(data1box.items.count)+' - Gt. Harmonics');
      data1box.items.add(inttostr(data1box.items.count)+' - Acoustic Bs.');
      data1box.items.add(inttostr(data1box.items.count)+' - Fingered Bs.');
      data1box.items.add(inttostr(data1box.items.count)+' - Picked Bs.');
      data1box.items.add(inttostr(data1box.items.count)+' - Fretless Bs.');
      data1box.items.add(inttostr(data1box.items.count)+' - Slap Bass 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Slap Bass 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Synth Bass 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Synth Bass 2');
      data1box.items.add(inttostr(data1box.items.count)+' - Violin');
      data1box.items.add(inttostr(data1box.items.count)+' - Viola');
      data1box.items.add(inttostr(data1box.items.count)+' - Cello');
      data1box.items.add(inttostr(data1box.items.count)+' - Contrabass');
      data1box.items.add(inttostr(data1box.items.count)+' - Tremelo Str');
      data1box.items.add(inttostr(data1box.items.count)+' - PizzicatoStr');
      data1box.items.add(inttostr(data1box.items.count)+' - Harp');
      data1box.items.add(inttostr(data1box.items.count)+' - Timpani');
      data1box.items.add(inttostr(data1box.items.count)+' - Strings');
      data1box.items.add(inttostr(data1box.items.count)+' - Slow Strings');
      data1box.items.add(inttostr(data1box.items.count)+' - Syn. Strings1');
      data1box.items.add(inttostr(data1box.items.count)+' - Syn. Strings2');
      data1box.items.add(inttostr(data1box.items.count)+' - Choir Aahs');
      data1box.items.add(inttostr(data1box.items.count)+' - Voice Oohs');
      data1box.items.add(inttostr(data1box.items.count)+' - SynVox');
      data1box.items.add(inttostr(data1box.items.count)+' - OrchestraHit');
      data1box.items.add(inttostr(data1box.items.count)+' - Trumpet');
      data1box.items.add(inttostr(data1box.items.count)+' - Trombone');
      data1box.items.add(inttostr(data1box.items.count)+' - Tuba');
      data1box.items.add(inttostr(data1box.items.count)+' - MutedTrumpet');
      data1box.items.add(inttostr(data1box.items.count)+' - French Horn');
      data1box.items.add(inttostr(data1box.items.count)+' - Brass 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Synth Brass1');
      data1box.items.add(inttostr(data1box.items.count)+' - Synth Brass2');
      data1box.items.add(inttostr(data1box.items.count)+' - Soprano Sax');
      data1box.items.add(inttostr(data1box.items.count)+' - Alto Sax');
      data1box.items.add(inttostr(data1box.items.count)+' - Tenor Sax');
      data1box.items.add(inttostr(data1box.items.count)+' - Baritone Sax');
      data1box.items.add(inttostr(data1box.items.count)+' - Oboe');
      data1box.items.add(inttostr(data1box.items.count)+' - English Horn');
      data1box.items.add(inttostr(data1box.items.count)+' - Bassoon');
      data1box.items.add(inttostr(data1box.items.count)+' - Clarinet');
      data1box.items.add(inttostr(data1box.items.count)+' - Piccolo');
      data1box.items.add(inttostr(data1box.items.count)+' - Flute');
      data1box.items.add(inttostr(data1box.items.count)+' - Recorder');
      data1box.items.add(inttostr(data1box.items.count)+' - Pan Flute');
      data1box.items.add(inttostr(data1box.items.count)+' - Bottle Blow');
      data1box.items.add(inttostr(data1box.items.count)+' - Shakuhachi');
      data1box.items.add(inttostr(data1box.items.count)+' - Whistle');
      data1box.items.add(inttostr(data1box.items.count)+' - Ocarina');
      data1box.items.add(inttostr(data1box.items.count)+' - Square Wave');
      data1box.items.add(inttostr(data1box.items.count)+' - Saw Wave');
      data1box.items.add(inttostr(data1box.items.count)+' - Syn. Calliope');
      data1box.items.add(inttostr(data1box.items.count)+' - Chiffer Lead');
      data1box.items.add(inttostr(data1box.items.count)+' - Charang');
      data1box.items.add(inttostr(data1box.items.count)+' - Solo Vox');
      data1box.items.add(inttostr(data1box.items.count)+' - 5th Saw Wave');
      data1box.items.add(inttostr(data1box.items.count)+' - Bass&Lead');
      data1box.items.add(inttostr(data1box.items.count)+' - Fantasia');
      data1box.items.add(inttostr(data1box.items.count)+' - Warm Pad');
      data1box.items.add(inttostr(data1box.items.count)+' - Polysynth');
      data1box.items.add(inttostr(data1box.items.count)+' - Space Voice');
      data1box.items.add(inttostr(data1box.items.count)+' - Bowed Glass');
      data1box.items.add(inttostr(data1box.items.count)+' - Metal Pad');
      data1box.items.add(inttostr(data1box.items.count)+' - Halo Pad');
      data1box.items.add(inttostr(data1box.items.count)+' - Sweep Pad');
      data1box.items.add(inttostr(data1box.items.count)+' - Ice Rain');
      data1box.items.add(inttostr(data1box.items.count)+' - Soundtrack');
      data1box.items.add(inttostr(data1box.items.count)+' - Crystal');
      data1box.items.add(inttostr(data1box.items.count)+' - Atmosphere');
      data1box.items.add(inttostr(data1box.items.count)+' - Brightness');
      data1box.items.add(inttostr(data1box.items.count)+' - Goblin');
      data1box.items.add(inttostr(data1box.items.count)+' - Echo Drops');
      data1box.items.add(inttostr(data1box.items.count)+' - Star Theme');
      data1box.items.add(inttostr(data1box.items.count)+' - Sitar');
      data1box.items.add(inttostr(data1box.items.count)+' - Banjo');
      data1box.items.add(inttostr(data1box.items.count)+' - Shamisen');
      data1box.items.add(inttostr(data1box.items.count)+' - Koto');
      data1box.items.add(inttostr(data1box.items.count)+' - Kalimba');
      data1box.items.add(inttostr(data1box.items.count)+' - Bag Pipe');
      data1box.items.add(inttostr(data1box.items.count)+' - Fiddle');
      data1box.items.add(inttostr(data1box.items.count)+' - Shannai');
      data1box.items.add(inttostr(data1box.items.count)+' - Tinkle Bell');
      data1box.items.add(inttostr(data1box.items.count)+' - Agogo');
      data1box.items.add(inttostr(data1box.items.count)+' - Steel Drums');
      data1box.items.add(inttostr(data1box.items.count)+' - Woodblock');
      data1box.items.add(inttostr(data1box.items.count)+' - Taiko');
      data1box.items.add(inttostr(data1box.items.count)+' - Melo Tom 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Synth Drum');
      data1box.items.add(inttostr(data1box.items.count)+' - Reverse Cym.');
      data1box.items.add(inttostr(data1box.items.count)+' - Gt. FretNoise');
      data1box.items.add(inttostr(data1box.items.count)+' - Breath Noise');
      data1box.items.add(inttostr(data1box.items.count)+' - Seashore');
      data1box.items.add(inttostr(data1box.items.count)+' - Bird');
      data1box.items.add(inttostr(data1box.items.count)+' - Telephone 1');
      data1box.items.add(inttostr(data1box.items.count)+' - Helicopter');
      data1box.items.add(inttostr(data1box.items.count)+' - Applause');
      data1box.items.add(inttostr(data1box.items.count)+' - Gun Shot');
    end;
    5:
    begin
      message1a.text:='208';
      data1box.items.add('-');
    end;
    6:
    begin
      message1a.text:='224';
      data1box.items.add('-');
    end;
    7:
    begin
      message1a.text:='245';
      data1box.items.add(inttostr(data1box.items.count)+' - ');
      data1box.items.add(inttostr(data1box.items.count)+' - Stop');
      data1box.items.add(inttostr(data1box.items.count)+' - Play');
      data1box.items.add(inttostr(data1box.items.count)+' - Deferred Play');
      data1box.items.add(inttostr(data1box.items.count)+' - Fast Forward');
      data1box.items.add(inttostr(data1box.items.count)+' - Rewind');
      data1box.items.add(inttostr(data1box.items.count)+' - Record Strobe');
      data1box.items.add(inttostr(data1box.items.count)+' - Record Exit');
      data1box.items.add(inttostr(data1box.items.count)+' - Record Ready');
      data1box.items.add(inttostr(data1box.items.count)+' - Pause');
      data1box.items.add('10 - Eject');
      data1box.items.add('11 - Chase');
      data1box.items.add('12 - ');
      data1box.items.add('13 - MMC Reset');
    end;
    8:
    begin
      message1a.text:='253';
      data1box.items.add(inttostr(data1box.items.count)+' - Stop');
      data1box.items.add(inttostr(data1box.items.count)+' - Play');
      data1box.items.add(inttostr(data1box.items.count)+' - Record On');
      data1box.items.add(inttostr(data1box.items.count)+' - Record Off');
      data1box.items.add(inttostr(data1box.items.count)+' - Record 2');
    end;
  end;
end;

procedure Teditmidieventfrm.Data1boxSelect(Sender: TObject);
begin
  Data1a.Text:=inttostr(Data1box.itemindex);
end;

procedure Teditmidieventfrm.MSGboxDropDown(Sender: TObject);
begin
  msgbox.Width:=200;
end;

procedure Teditmidieventfrm.MSGboxCloseUp(Sender: TObject);
begin
  msgbox.Width:=52;
end;

procedure Teditmidieventfrm.Data1boxDropDown(Sender: TObject);
begin
  data1box.Width:=200;
end;

procedure Teditmidieventfrm.Data1boxCloseUp(Sender: TObject);
begin
  data1box.Width:=52;
end;

procedure Teditmidieventfrm.CreateParams(var Params:TCreateParams);
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

procedure Teditmidieventfrm.ComboBox2Exit(Sender: TObject);
begin
  ManualEditingOfCombobox2:=false;
end;

procedure Teditmidieventfrm.ComboBox2Enter(Sender: TObject);
begin
  ManualEditingOfCombobox2:=true;
end;

procedure Teditmidieventfrm.SwitchValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.SwitchValue:=round(SwitchValue.Value/127*255);
end;

procedure Teditmidieventfrm.ScaleValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  AktuellerBefehl.ScaleValue:=ScaleValue.checked;
end;

procedure Teditmidieventfrm.InvertSwitchValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  AktuellerBefehl.InvertSwitchValue:=InvertSwitchValue.checked;
end;

end.
