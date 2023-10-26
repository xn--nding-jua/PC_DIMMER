unit befehleditorform2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gnugettext, Mask, JvExMask, JvSpin, pngimage,
  ExtCtrls, JvExControls, JvGradient, mbXPImageComboBox, ImgList,
  PngImageList;

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
    RunOnProjectLoad : boolean;
    ArgInteger : array of Integer;
    ArgString : array of string[255];
    ArgGUID : array of TGUID;
    Category:string[255];
  end;

  TBefehlposition = record
    GUID:TGUID;
    Bezeichnung:string;
    IntegerArgCount:Word;
    StringArgCount:Word;
    GUIDArgCount:Word;
    PositionCombobox2: integer;
  end;

  Tbefehlseditor2 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    ComboBox1old: TComboBox;
    ComboBox2: TComboBox;
    Arg1Label: TLabel;
    Arg1Edit: TEdit;
    Arg2Label: TLabel;
    Arg2Edit: TEdit;
    Button1: TButton;
    Button2: TButton;
    ZeitBox: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    hEdit: TEdit;
    minEdit: TEdit;
    sEdit: TEdit;
    msEdit: TEdit;
    Optionen1Box: TGroupBox;
    Optionen2Box: TGroupBox;
    devicelist: TComboBox;
    Arg1Combobox: TComboBox;
    Optionen3Box: TGroupBox;
    Arg3Label: TLabel;
    Arg3Edit: TEdit;
    Arg2Combobox: TComboBox;
    Arg3Combobox: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    OffValue: TJvSpinEdit;
    OnValue: TJvSpinEdit;
    grouplist: TComboBox;
    effektlist: TComboBox;
    Panel5: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    CheckBox1: TCheckBox;
    Shape4: TShape;
    Shape1: TShape;
    ComboBox1: TmbXPImageComboBox;
    PngImageList1: TPngImageList;
    Label13: TLabel;
    Label8: TLabel;
    SwitchValue: TJvSpinEdit;
    Label12: TLabel;
    ScaleValue: TCheckBox;
    InvertSwitchValue: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
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
    ShowInputValueToo:boolean;
    ShowValueParameters:boolean;
  end;

var
  befehlseditor_array2: array of Tbefehlseditor2;

implementation

uses PCDIMMER, szenenverwaltung, beatfrm, joysticksetupfrm;

{$R *.dfm}

procedure Tbefehlseditor2.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  ShowInputValueToo:=false;
end;

procedure Tbefehlseditor2.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Tbefehlseditor2.FormShow(Sender: TObject);
var
  i,j:integer;
begin
  nousersetting:=true;

  Label13.Visible:=ShowValueParameters;
  Label8.Visible:=ShowValueParameters;
  Label12.Visible:=ShowValueParameters;
  OffValue.Visible:=ShowValueParameters;
  SwitchValue.Visible:=ShowValueParameters;
  OnValue.Visible:=ShowValueParameters;
  InvertSwitchValue.Visible:=ShowValueParameters;
  ScaleValue.Visible:=ShowValueParameters;

  Edit1.text:=AktuellerBefehl.Name;
  Edit2.text:=AktuellerBefehl.Beschreibung;

  Checkbox1.Checked:=AktuellerBefehl.RunOnProjectLoad;

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
    Combobox1.Images:=PngImageList1;
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

procedure Tbefehlseditor2.hEditChange(Sender: TObject);
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

procedure Tbefehlseditor2.Arg1EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  if length(AktuellerBefehl.ArgString)>0 then
    AktuellerBefehl.ArgString[0]:=Arg1Edit.Text
  else
  begin
    s:=TEdit(Sender).text;
    if s='-' then exit;
    i:=TEdit(Sender).selstart;
    mainform.input_number_minus(i,s);
    TEdit(Sender).text:=s;
    TEdit(Sender).selstart:=i;
    AktuellerBefehl.ArgInteger[0]:=strtoint(Arg1Edit.Text);
  end;
end;

procedure Tbefehlseditor2.Arg2EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  if length(AktuellerBefehl.ArgString)>1 then
    AktuellerBefehl.ArgString[1]:=Arg2Edit.Text
  else
  begin
    s:=TEdit(Sender).text;
    if s='-' then exit;
    i:=TEdit(Sender).selstart;
    mainform.input_number_minus(i,s);
    TEdit(Sender).text:=s;
    TEdit(Sender).selstart:=i;
    AktuellerBefehl.ArgInteger[1]:=strtoint(Arg2Edit.Text);
  end;
end;

procedure Tbefehlseditor2.Arg2bEditChange(Sender: TObject);
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

procedure Tbefehlseditor2.ComboBox1Select(Sender: TObject);
var
  i:integer;
begin
  Combobox2.Items.Clear;
  setlength(Befehlposition, 0);
  for i:=0 to length(mainform.Befehlssystem[Combobox1.itemindex].Steuerung)-1 do
  begin
    if ShowInputValueToo or (not mainform.Befehlssystem[Combobox1.Itemindex].Steuerung[i].InputValueOnly) then
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
  Combobox2.DroppedDown:=true;
end;

procedure Tbefehlseditor2.ComboBox2Select(Sender: TObject);
var
  i,j:integer;
  cancel:boolean;
  SzenenData:PTreeData;
begin
  {$I EditBefehl.inc}

  if (not (Sender=effektlist)) then
  begin
    if effektlist.Visible and (effektlist.Items.Count>0) then
      effektlist.DroppedDown:=true;
    if grouplist.Visible and (grouplist.Items.Count>0) then
      grouplist.DroppedDown:=true;
    if devicelist.Visible and (devicelist.Items.Count>0) then
      devicelist.DroppedDown:=true;
  end;
end;

procedure Tbefehlseditor2.Arg1ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[0]:=Arg1Combobox.ItemIndex;
end;

procedure Tbefehlseditor2.Arg2ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[1]:=Arg2Combobox.ItemIndex;
end;

procedure Tbefehlseditor2.Arg3ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[2]:=Arg3Combobox.ItemIndex;
end;

procedure Tbefehlseditor2.devicelistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.devices[devicelist.itemindex].ID;
end;

procedure Tbefehlseditor2.grouplistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.devicegroups[grouplist.itemindex].ID;
end;

procedure Tbefehlseditor2.effektlistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.effektsequenzereffekte[effektlist.itemindex].ID;

  ComboBox2Select(effektlist);
end;

procedure Tbefehlseditor2.Edit1Change(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.Name:=Edit1.text;
end;

procedure Tbefehlseditor2.Edit2Change(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.Beschreibung:=Edit2.text;
end;

procedure Tbefehlseditor2.OnValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.OnValue:=round(OnValue.Value);
end;

procedure Tbefehlseditor2.OffValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.OffValue:=round(OffValue.Value);
end;

procedure Tbefehlseditor2.FillTimeBox(time: integer);
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

procedure Tbefehlseditor2.Arg3EditChange(Sender: TObject);
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

procedure Tbefehlseditor2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ShowInputValueToo:=false;
end;

procedure Tbefehlseditor2.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AktuellerBefehl.RunOnProjectLoad:=Checkbox1.Checked;
end;

procedure Tbefehlseditor2.CheckBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  AktuellerBefehl.RunOnProjectLoad:=Checkbox1.Checked;
end;

procedure Tbefehlseditor2.CreateParams(var Params:TCreateParams);
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

procedure Tbefehlseditor2.ComboBox2Enter(Sender: TObject);
begin
  ManualEditingOfCombobox2:=true;
end;

procedure Tbefehlseditor2.ComboBox2Exit(Sender: TObject);
begin
  ManualEditingOfCombobox2:=false;
end;

procedure Tbefehlseditor2.SwitchValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.SwitchValue:=round(SwitchValue.Value);
end;

procedure Tbefehlseditor2.ScaleValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  AktuellerBefehl.ScaleValue:=ScaleValue.checked;
end;

procedure Tbefehlseditor2.InvertSwitchValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  AktuellerBefehl.InvertSwitchValue:=InvertSwitchValue.checked;
end;

end.
