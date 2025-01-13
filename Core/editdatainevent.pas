unit editdatainevent;

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

  Teditdataineventfrm = class(TForm)
    GroupBox1: TGroupBox;
    okbtn: TButton;
    cancelbtn: TButton;
    Label2: TLabel;
    Label3: TLabel;
    message1b: TLabel;
    data1b: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    data1a: TEdit;
    message1a: TEdit;
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
    Label1: TLabel;
    Timer1: TTimer;
    Shape4: TShape;
    Shape1: TShape;
    Label4: TLabel;
    SwitchValue: TJvSpinEdit;
    Label13: TLabel;
    Label12: TLabel;
    ScaleValue: TCheckBox;
    InvertSwitchValue: TCheckBox;
    Button1: TButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
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
    procedure Timer1Timer(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Exit(Sender: TObject);
    procedure SwitchValueChange(Sender: TObject);
    procedure ScaleValueMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InvertSwitchValueMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    ManualEditingOfCombobox2:boolean;
    nousersetting:boolean;
    Befehlposition:array of TBefehlposition;
    midisettings:boolean;
    takelastdatainvalue:boolean;
  public
    { Public-Deklarationen }
    AktuellerBefehl: TBefehl;
    address,endvalue:integer;
  end;

var
  editdataineventfrm: Teditdataineventfrm;

implementation

uses PCDIMMER, beatfrm, joysticksetupfrm;

{$R *.dfm}

procedure Teditdataineventfrm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_escape then
    modalresult:=mrCancel;
end;

procedure Teditdataineventfrm.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Teditdataineventfrm.hEditChange(Sender: TObject);
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

procedure Teditdataineventfrm.Arg1EditChange(Sender: TObject);
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

procedure Teditdataineventfrm.Arg2EditChange(Sender: TObject);
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

procedure Teditdataineventfrm.Arg2bEditChange(Sender: TObject);
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

procedure Teditdataineventfrm.ComboBox1Select(Sender: TObject);
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

procedure Teditdataineventfrm.ComboBox2Select(Sender: TObject);
var
  i,j:integer;
  cancel:boolean;
  SzenenData:PTreeData;
begin
  {$I EditBefehl.inc}
end;

procedure Teditdataineventfrm.Arg1ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[0]:=Arg1Combobox.ItemIndex;
end;

procedure Teditdataineventfrm.Arg2ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[1]:=Arg2Combobox.ItemIndex;
end;

procedure Teditdataineventfrm.Arg3ComboboxSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgInteger[2]:=Arg3Combobox.ItemIndex;
end;

procedure Teditdataineventfrm.devicelistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.devices[devicelist.itemindex].ID;
end;

procedure Teditdataineventfrm.grouplistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.devicegroups[grouplist.itemindex].ID;
end;

procedure Teditdataineventfrm.effektlistSelect(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.ArgGUID[0]:=mainform.effektsequenzereffekte[effektlist.itemindex].ID;

  ComboBox2Select(effektlist);
end;

procedure Teditdataineventfrm.Edit1Change(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.Name:=Edit1.text;
end;

procedure Teditdataineventfrm.Edit2Change(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.Beschreibung:=Edit2.text;
end;

procedure Teditdataineventfrm.OnValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.OnValue:=round(OnValue.Value);
end;

procedure Teditdataineventfrm.OffValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.OffValue:=round(OffValue.Value);
end;

procedure Teditdataineventfrm.FillTimeBox(time: integer);
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

procedure Teditdataineventfrm.Arg3EditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  if nousersetting then exit;

  if length(AktuellerBefehl.ArgString)>2 then
    AktuellerBefehl.ArgString[2]:=Arg3Edit.Text
  else
  begin
    s:=TEdit(Sender).text;
    if s='-' then exit;
    i:=TEdit(Sender).selstart;
    mainform.input_number_minus(i,s);
    TEdit(Sender).text:=s;
    TEdit(Sender).selstart:=i;

    AktuellerBefehl.ArgInteger[2]:=strtoint(Arg3Edit.Text);
  end;
end;

procedure Teditdataineventfrm.FormShow(Sender: TObject);
var
  i,j:integer;
begin
  nousersetting:=true;
  Edit1.text:=AktuellerBefehl.Name;
  Edit2.text:=AktuellerBefehl.Beschreibung;
  OnValue.value:=AktuellerBefehl.OnValue;
  SwitchValue.value:=AktuellerBefehl.SwitchValue;
  InvertSwitchValue.checked:=AktuellerBefehl.InvertSwitchValue;
  OffValue.Value:=AktuellerBefehl.OffValue;
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
  Timer1.enabled:=true;

  nousersetting:=false;
end;

procedure Teditdataineventfrm.Timer1Timer(Sender: TObject);
begin
  Message1b.caption:=inttostr(address);
  Data1b.caption:=inttostr(endvalue);

  if takelastdatainvalue then
  begin
    Message1a.text:=inttostr(address);
    Data1a.text:=inttostr(endvalue);
    takelastdatainvalue:=false;
  end;
end;

procedure Teditdataineventfrm.CreateParams(var Params:TCreateParams);
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

procedure Teditdataineventfrm.ComboBox2Enter(Sender: TObject);
begin
  ManualEditingOfCombobox2:=true;
end;

procedure Teditdataineventfrm.ComboBox2Exit(Sender: TObject);
begin
  ManualEditingOfCombobox2:=false;
end;

procedure Teditdataineventfrm.SwitchValueChange(Sender: TObject);
begin
  if nousersetting then exit;

  AktuellerBefehl.SwitchValue:=round(SwitchValue.Value);
end;

procedure Teditdataineventfrm.ScaleValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  AktuellerBefehl.ScaleValue:=ScaleValue.checked;
end;

procedure Teditdataineventfrm.InvertSwitchValueMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nousersetting then exit;

  AktuellerBefehl.InvertSwitchValue:=InvertSwitchValue.checked;
end;

procedure Teditdataineventfrm.Button1Click(Sender: TObject);
begin
  takelastdatainvalue:=true;
end;

procedure Teditdataineventfrm.FormHide(Sender: TObject);
begin
  Timer1.enabled:=false;
end;

procedure Teditdataineventfrm.okbtnClick(Sender: TObject);
begin
  if InvertSwitchValue.Checked then
  begin
    if (mainform.Befehlssystem[Combobox1.itemindex].Steuerung[Combobox2.itemindex].InputValueOnly and (SwitchValue.Value<255)) then
    begin
      if messagedlg(_('Sie nutzen das invertierte Eingangssignal, aber haben noch eine Schaltschwelle unterhalb von 255 eingestellt. Soll die Schaltschwelle auf 255 gesetzt werden, um den vollen Wertebereich nutzen zu können?'),mtConfirmation, [mbYes,mbNo],0)=mrYes then
      begin
        SwitchValue.Value:=255;
      end;
    end;
  end else
  begin
    if (mainform.Befehlssystem[Combobox1.itemindex].Steuerung[Combobox2.itemindex].InputValueOnly and (SwitchValue.Value>0)) then
    begin
      if messagedlg(_('Sie nutzen das Eingangssignal, aber haben noch eine Schaltschwelle oberhalb von 0 eingestellt. Soll die Schaltschwelle auf 0 gesetzt werden, um den vollen Wertebereich nutzen zu können?'),mtConfirmation, [mbYes,mbNo],0)=mrYes then
      begin
        SwitchValue.Value:=0;
      end;
    end;
  end;
end;

end.
