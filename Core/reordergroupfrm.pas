unit reordergroupfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngBitBtn, StdCtrls, Grids, Mask, JvExMask, JvSpin,
  ExtCtrls, gnugettext;

type
  Tgroupeditorform = class(TForm)
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupListBox: TComboBox;
    AddGroupBtn: TPngBitBtn;
    DeleteGroupBtn: TPngBitBtn;
    GroupNameEdit: TEdit;
    GroupDescEdit: TEdit;
    ActivateGroupBtn: TPngBitBtn;
    AddDeviceGroupWithoutDeselectBtn: TPngBitBtn;
    ShowGroupIDbtn: TButton;
    Panel2: TPanel;
    Button1: TButton;
    upbtn: TPngBitBtn;
    downbtn: TPngBitBtn;
    deletebtn: TPngBitBtn;
    FanningBox: TGroupBox;
    MasterLbl: TLabel;
    FanModeLbl: TLabel;
    DelayLbl: TLabel;
    morphlbl: TLabel;
    UseGroupMasterBox: TCheckBox;
    GroupMasterBox: TComboBox;
    FanningModeBox: TComboBox;
    DelayEdit: TEdit;
    MorphEdit: TJvSpinEdit;
    RefreshGroupBtn: TPngBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    AddDeviceBtn: TPngBitBtn;
    GroupActive: TCheckBox;
    groupupbtn: TPngBitBtn;
    groupdownbtn: TPngBitBtn;
    copybtn: TPngBitBtn;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure downbtnClick(Sender: TObject);
    procedure upbtnClick(Sender: TObject);
    procedure deletebtnClick(Sender: TObject);
    procedure DelayEditChange(Sender: TObject);
    procedure DelayEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MorphEditChange(Sender: TObject);
    procedure UseGroupMasterBoxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GroupMasterBoxSelect(Sender: TObject);
    procedure FanningModeBoxChange(Sender: TObject);
    procedure FanningModeBoxSelect(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure RefreshGroupBtnClick(Sender: TObject);
    procedure AddGroupBtnClick(Sender: TObject);
    procedure DeleteGroupBtnClick(Sender: TObject);
    procedure ActivateGroupBtnClick(Sender: TObject);
    procedure AddDeviceGroupWithoutDeselectBtnClick(Sender: TObject);
    procedure ShowGroupIDbtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GroupListBoxChange(Sender: TObject);
    procedure GroupNameEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GroupDescEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AddDeviceBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupActiveMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupNameEditExit(Sender: TObject);
    procedure GroupDescEditExit(Sender: TObject);
    procedure groupupbtnClick(Sender: TObject);
    procedure groupdownbtnClick(Sender: TObject);
    procedure copybtnClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure RefreshGrid;
    procedure CheckButtons;
  public
    { Public-Deklarationen }
    procedure GroupListChanged;
  end;

var
  groupeditorform: Tgroupeditorform;

implementation

uses PCDIMMER, geraetesteuerungfrm, geraeteremovedfrm, adddevicetogroupfrm,
  sidebarfrm;

{$R *.dfm}

procedure Tgroupeditorform.FormShow(Sender: TObject);
begin
  if (grouplistbox.itemindex<0) and (grouplistbox.items.count>0) then
  begin
    grouplistbox.itemindex:=0;
  end;
  RefreshGrid;

  if  (grouplistbox.items.count>0) and (grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    GroupNameEdit.text:=mainform.devicegroups[grouplistbox.itemindex].Name;
    GroupDescEdit.text:=mainform.devicegroups[grouplistbox.itemindex].Beschreibung;
    GroupActive.checked:=mainform.devicegroups[grouplistbox.itemindex].Active;
  end;
end;

procedure Tgroupeditorform.RefreshGrid;
var
  i,j,PositionInDeviceArray:integer;
  found:boolean;
  ID:TGuid;
  Name:String;
begin
  stringgrid1.Cells[0,0]:='';
  stringgrid1.Cells[1,0]:=_('Pos');
  stringgrid1.Cells[2,0]:=_('Gerätename');
  stringgrid1.Cells[3,0]:=_('Adresse');
  stringgrid1.Cells[4,0]:=_('Gerätetyp');
  stringgrid1.Cells[5,0]:=_('Hersteller');

  if (length(mainform.devicegroups)>0) and (Grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    if (length(mainform.devicegroups[Grouplistbox.itemindex].IDs)+1)<2 then
      stringgrid1.RowCount:=2
    else
      stringgrid1.RowCount:=length(mainform.devicegroups[Grouplistbox.itemindex].IDs)+1;

    if (length(mainform.devicegroups[Grouplistbox.itemindex].IDs)=0) then
    begin
      stringgrid1.Cells[0,1]:='';
      stringgrid1.Cells[1,1]:='-';
      stringgrid1.Cells[2,1]:='-';
      stringgrid1.Cells[3,1]:='-';
      stringgrid1.Cells[4,1]:='-';
      stringgrid1.Cells[5,1]:='-';
    end;

    for i:=0 to length(mainform.devicegroups[Grouplistbox.itemindex].IDs)-1 do
    begin
      PositionInDeviceArray:=geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.devicegroups[Grouplistbox.itemindex].IDs[i]);
      stringgrid1.Cells[1,i+1]:=inttostr(i+1);
      if PositionInDeviceArray<0 then break;
      stringgrid1.Cells[2,i+1]:=mainform.devices[PositionInDeviceArray].Name;
      if mainform.devices[PositionInDeviceArray].MaxChan=1 then
        stringgrid1.Cells[3,i+1]:=inttostr(mainform.devices[PositionInDeviceArray].Startaddress)
      else
        stringgrid1.Cells[3,i+1]:=inttostr(mainform.devices[PositionInDeviceArray].Startaddress)+'..'+inttostr(mainform.devices[PositionInDeviceArray].Startaddress+mainform.devices[PositionInDeviceArray].MaxChan-1);
      stringgrid1.Cells[4,i+1]:=mainform.devices[PositionInDeviceArray].DeviceName;
      stringgrid1.Cells[5,i+1]:=mainform.devices[PositionInDeviceArray].Vendor;
    end;

    if length(mainform.devicegroups[Grouplistbox.itemindex].IDs)>1 then
      stringgrid1.Row:=1;

    GroupMasterBox.Items.Clear;
    for i:=0 to length(mainform.devicegroups[Grouplistbox.itemindex].IDs)-1 do
    begin
      found:=false;
      ID:=mainform.devicegroups[Grouplistbox.itemindex].IDs[i];
      for j:=0 to length(mainform.devices)-1 do
      begin
        if IsEqualGUID(mainform.devices[j].ID,mainform.devicegroups[Grouplistbox.itemindex].IDs[i]) then
        begin
          found:=true;
          ID:=mainform.devices[j].ID;
          Name:=mainform.devices[j].Name;
          break;
        end;
      end;

      if found then
        GroupMasterBox.Items.Add(inttostr(GroupMasterBox.Items.Count+1)+': '+Name)
      else
        GroupMasterBox.Items.Add(GUIDtoString(ID));
    end;

    for j:=0 to length(mainform.DeviceGroups[Grouplistbox.itemindex].IDs)-1 do
    begin
      if IsEqualGUID(mainform.DeviceGroups[Grouplistbox.itemindex].IDs[j],mainform.DeviceGroups[Grouplistbox.itemindex].MasterDevice) then
      begin
        GroupMasterBox.ItemIndex:=j;
        break;
      end;
    end;
    FanningModeBox.ItemIndex:=mainform.DeviceGroups[Grouplistbox.itemindex].FanMode;
    MorphEdit.Value:=mainform.DeviceGroups[Grouplistbox.itemindex].FanMorph;
    UseGroupMasterBox.Checked:=mainform.DeviceGroups[Grouplistbox.itemindex].UseMaster;
    DelayEdit.text:=inttostr(mainform.DeviceGroups[Grouplistbox.itemindex].delay);
  end else
  begin
    stringgrid1.RowCount:=2;
    stringgrid1.Cells[0,1]:='';
    stringgrid1.Cells[1,1]:='-';
    stringgrid1.Cells[2,1]:='-';
    stringgrid1.Cells[3,1]:='-';
    stringgrid1.Cells[4,1]:='-';
    stringgrid1.Cells[5,1]:='-';
  end;

  CheckButtons;
  StringGrid1.Refresh;
end;

procedure Tgroupeditorform.CheckButtons;
begin
  upbtn.enabled:=stringgrid1.row>1;
  downbtn.enabled:=stringgrid1.row<(stringgrid1.rowcount-1);
  deletebtn.enabled:=((stringgrid1.row>0) and (stringgrid1.row<stringgrid1.rowcount) and (Grouplistbox.itemindex<length(mainform.devicegroups)) and (Grouplistbox.itemindex>-1) and (length(mainform.devicegroups[Grouplistbox.itemindex].IDs)>0));

  DeleteGroupBtn.enabled:=((Grouplistbox.itemindex)<length(mainform.DeviceGroups)) and (length(mainform.DeviceGroups)>0);
  copybtn.enabled:=((Grouplistbox.itemindex)<length(mainform.DeviceGroups)) and (length(mainform.DeviceGroups)>0);
  groupupbtn.enabled:=Grouplistbox.itemindex>0;
  groupdownbtn.enabled:=Grouplistbox.itemindex<(Grouplistbox.Items.Count-1);
  AddDeviceBtn.enabled:=DeleteGroupBtn.enabled;
  RefreshGroupBtn.enabled:=DeleteGroupBtn.enabled;
  ActivateGroupBtn.enabled:=DeleteGroupBtn.enabled;
  AddDeviceGroupWithoutDeselectBtn.enabled:=DeleteGroupBtn.enabled;
  ShowGroupIDbtn.Enabled:=DeleteGroupBtn.enabled;
end;

procedure Tgroupeditorform.StringGrid1Click(Sender: TObject);
begin
  CheckButtons;
end;

procedure Tgroupeditorform.StringGrid1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckButtons;
end;

procedure Tgroupeditorform.downbtnClick(Sender: TObject);
var
  ID:TGuid;
  IDActive:boolean;
  AktuellePosition:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  AktuellePosition:=stringgrid1.row;
  // Aktuelle ID kopieren
  ID:=mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row-1];
  IDActive:=mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row-1];
  // untere ID auf aktuelle kopieren
  mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row-1]:=mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row];
  mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row-1]:=mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row];
  // Gesicherte ID auf untere kopieren
  mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row]:=ID;
  mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row]:=IDActive;
  RefreshGrid;
  stringgrid1.row:=AktuellePosition+1;
  CheckButtons;
  StringGrid1.Refresh;
end;

procedure Tgroupeditorform.upbtnClick(Sender: TObject);
var
  ID:TGuid;
  IDActive:boolean;
  AktuellePosition:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  AktuellePosition:=stringgrid1.row;
  // Aktuelle ID kopieren
  ID:=mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row-1];
  IDActive:=mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row-1];
  // obere ID auf aktuelle kopieren
  mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row-1]:=mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row-2];
  mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row-1]:=mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row-2];
  // Gesicherte ID auf obere kopieren
  mainform.devicegroups[Grouplistbox.itemindex].IDs[stringgrid1.row-2]:=ID;
  mainform.devicegroups[Grouplistbox.itemindex].IDActive[stringgrid1.row-2]:=IDActive;
  RefreshGrid;
  stringgrid1.row:=AktuellePosition-1;
  CheckButtons;
  StringGrid1.Refresh;
end;

procedure Tgroupeditorform.deletebtnClick(Sender: TObject);
var
  i:integer;
  AktuellePosition:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  AktuellePosition:=stringgrid1.row;
  for i:=AktuellePosition-1 to length(mainform.devicegroups[Grouplistbox.itemindex].IDs)-2 do
  begin
    mainform.devicegroups[Grouplistbox.itemindex].IDs[i]:=mainform.devicegroups[Grouplistbox.itemindex].IDs[i+1];
    mainform.devicegroups[Grouplistbox.itemindex].IDActive[i]:=mainform.devicegroups[Grouplistbox.itemindex].IDActive[i+1];
    mainform.devicegroups[Grouplistbox.itemindex].Delays[i]:=mainform.devicegroups[Grouplistbox.itemindex].Delays[i+1];
  end;
  setlength(mainform.devicegroups[Grouplistbox.itemindex].IDs,length(mainform.devicegroups[Grouplistbox.itemindex].IDs)-1);
  setlength(mainform.devicegroups[Grouplistbox.itemindex].IDActive,length(mainform.devicegroups[Grouplistbox.itemindex].IDActive)-1);
  setlength(mainform.devicegroups[Grouplistbox.itemindex].Delays,length(mainform.devicegroups[Grouplistbox.itemindex].Delays)-1);

  setlength(mainform.DeviceGroups[grouplistbox.itemindex].HasChanType,length(mainform.DeviceChannelNames));
  geraetesteuerung.CheckDeviceGroupIntersection(grouplistbox.itemindex, mainform.DeviceGroups[grouplistbox.itemindex].HasChanType);

  RefreshGrid;

  if AktuellePosition<stringgrid1.RowCount then
    stringgrid1.row:=AktuellePosition
  else
    stringgrid1.row:=AktuellePosition-1;
  CheckButtons;
end;

procedure Tgroupeditorform.DelayEditChange(Sender: TObject);
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

procedure Tgroupeditorform.DelayEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>Grouplistbox.itemindex then
  begin
    mainform.devicegroups[Grouplistbox.itemindex].Delay:=strtoint(DelayEdit.text);
  end;
end;

procedure Tgroupeditorform.MorphEditChange(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  if (length(mainform.DeviceGroups)>Grouplistbox.itemindex) and (Grouplistbox.itemindex>-1) then
  begin
    mainform.devicegroups[Grouplistbox.itemindex].FanMorph:=round(MorphEdit.value);
  end;
end;

procedure Tgroupeditorform.UseGroupMasterBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (length(mainform.DeviceGroups)>Grouplistbox.itemindex) and (Grouplistbox.itemindex>-1) then
  begin
    mainform.devicegroups[Grouplistbox.itemindex].UseMaster:=UseGroupMasterBox.Checked;
  end;
end;

procedure Tgroupeditorform.GroupMasterBoxSelect(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>Grouplistbox.itemindex then
  begin
    mainform.devicegroups[Grouplistbox.itemindex].MasterDevice:=mainform.devicegroups[Grouplistbox.itemindex].IDs[GroupMasterBox.itemindex];
    mainform.devicegroups[Grouplistbox.itemindex].UseMaster:=true;
    UseGroupMasterBox.Checked:=true;
  end;
end;

procedure Tgroupeditorform.FanningModeBoxChange(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  case FanningModeBox.ItemIndex of
    0: MorphEdit.Enabled:=false;
    1: MorphEdit.Enabled:=false;
    2: MorphEdit.Enabled:=false;
    3: MorphEdit.Enabled:=false;
    4: MorphEdit.Enabled:=true;
    5: MorphEdit.Enabled:=true;
    6: MorphEdit.Enabled:=true;
    7: MorphEdit.Enabled:=true;
  end;
end;

procedure Tgroupeditorform.FanningModeBoxSelect(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (length(mainform.DeviceGroups)>Grouplistbox.itemindex) and (Grouplistbox.itemindex>-1) then
  begin
    mainform.devicegroups[Grouplistbox.itemindex].FanMode:=FanningModeBox.itemindex;
  end;

  case FanningModeBox.ItemIndex of
    0: MorphEdit.Enabled:=false;
    1: MorphEdit.Enabled:=false;
    2: MorphEdit.Enabled:=false;
    3: MorphEdit.Enabled:=false;
    4: MorphEdit.Enabled:=true;
    5: MorphEdit.Enabled:=true;
    6: MorphEdit.Enabled:=true;
    7: MorphEdit.Enabled:=true;
  end;
end;

procedure Tgroupeditorform.RefreshGroupBtnClick(Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.DeviceGroups[Grouplistbox.itemindex].IDs,0);
  setlength(mainform.DeviceGroups[Grouplistbox.itemindex].IDActive,0);
  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      setlength(mainform.DeviceGroups[Grouplistbox.itemindex].IDs,length(mainform.DeviceGroups[Grouplistbox.itemindex].IDs)+1);
      setlength(mainform.DeviceGroups[Grouplistbox.itemindex].IDActive,length(mainform.DeviceGroups[Grouplistbox.itemindex].IDActive)+1);
      setlength(mainform.DeviceGroups[Grouplistbox.itemindex].Delays,length(mainform.DeviceGroups[Grouplistbox.itemindex].Delays)+1);
      mainform.DeviceGroups[Grouplistbox.itemindex].IDs[length(mainform.DeviceGroups[Grouplistbox.itemindex].IDs)-1]:=mainform.devices[i].ID;
      mainform.DeviceGroups[Grouplistbox.itemindex].IDActive[length(mainform.DeviceGroups[Grouplistbox.itemindex].IDActive)-1]:=true;
    end;
  end;
  setlength(mainform.DeviceGroups[Grouplistbox.itemindex].HasChanType,length(mainform.DeviceChannelNames));
  geraetesteuerung.CheckDeviceGroupIntersection(grouplistbox.itemindex, mainform.DeviceGroups[grouplistbox.itemindex].HasChanType);

  RefreshGrid;
end;

procedure Tgroupeditorform.GroupListChanged;
var
  i,lastindex:integer;
begin
  // Eigene Gruppenlistbox aktualisieren
  lastindex:=grouplistbox.itemindex;
  grouplistbox.items.clear;
  for i:=0 to length(mainform.devicegroups)-1 do
  begin
    grouplistbox.items.add(mainform.devicegroups[i].Name);
  end;
  if (lastindex>-1) and (lastindex<grouplistbox.items.count) then
    grouplistbox.itemindex:=lastindex
  else if grouplistbox.Items.count>0 then
    grouplistbox.itemindex:=0;

  // Andere Gruppenlistboxes aktualisieren
  geraetesteuerung.GroupListChanged;
  sidebarform.GroupListChanged;
  RefreshGrid;
end;

procedure Tgroupeditorform.AddGroupBtnClick(Sender: TObject);
var
  i,lastindex:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.DeviceGroups,length(mainform.DeviceGroups)+1);
  mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Active:=true;
  CreateGUID(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].ID);
  mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Name:=_('Neue Gerätegruppe (')+inttostr(length(mainform.DeviceGroups))+')';

  mainform.DeviceGroups[length(mainform.DeviceGroups)-1].FanMorph:=1;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs,length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs)+1);
      setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive,length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive)+1);
      setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Delays,length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].Delays)+1);
      mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs[length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs)-1]:=mainform.devices[i].ID;
      mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive[length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDActive)-1]:=true;
    end;
  end;
  setlength(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].HasChanType, length(mainform.DeviceChannelNames));
  geraetesteuerung.CheckDeviceGroupIntersection(length(mainform.DeviceGroups)-1, mainform.DeviceGroups[length(mainform.DeviceGroups)-1].HasChanType);

  if length(mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs)>0 then
  begin
    mainform.DeviceGroups[length(mainform.DeviceGroups)-1].UseMaster:=true;
    mainform.DeviceGroups[length(mainform.DeviceGroups)-1].FanMode:=1;
    mainform.DeviceGroups[length(mainform.DeviceGroups)-1].MasterDevice:=mainform.DeviceGroups[length(mainform.DeviceGroups)-1].IDs[0];
  end;

  Grouplistbox.itemindex:=Grouplistbox.items.add(_('Neue Gerätegruppe'));

  lastindex:=GroupListbox.itemindex;
  GroupListChanged;
  Grouplistbox.itemindex:=lastindex;
  GroupListBoxChange(nil);

  if AddDeviceBtn.enabled then
    AddDeviceBtnClick(nil);
end;

procedure Tgroupeditorform.DeleteGroupBtnClick(Sender: TObject);
var
  i,k:integer;
  groupinuse:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if messagedlg(_('Möchten Sie diese Gruppe wirklich löschen?'),mtWarning,
    [mbYes,mbNo],0)=mrYes then
  begin
    if length(mainform.DeviceGroups)>0 then
    begin
      // Objektekopieren nur starten, wenn nicht letztes Element selektiert
      if Grouplistbox.itemindex<length(mainform.DeviceGroups) then
      begin
        groupinuse:=geraetesteuerung.FindDeviceConnections(mainform.DeviceGroups[Grouplistbox.itemindex].ID,askforremovingform.Treeview1);
        askforremovingform.Label4.Caption:=_('Gruppenname:');
        askforremovingform.devicenamelabel.Caption:=mainform.DeviceGroups[Grouplistbox.itemindex].Name;
        askforremovingform.Label2.Caption:=_('Beschreibung:');
        askforremovingform.devicedescription.Caption:=mainform.DeviceGroups[Grouplistbox.itemindex].Beschreibung;
        askforremovingform.Label6.Caption:=_('Geräteanzahl:');
        askforremovingform.startadresselabel.Caption:=inttostr(length(mainform.DeviceGroups[Grouplistbox.itemindex].IDs));
        // Gruppe wird noch verwendet -> Dialogbox anzeigen
        if groupinuse then
        begin
          askforremovingform.Label35.Caption:=_('Die zu löschende Gruppe wird noch verwendet. Bitte wählen Sie, wie weiter verfahren werden soll:');
          askforremovingform.Button1.Caption:=_('Gruppe löschen');
          askforremovingform.showmodal;
        end;

        if (groupinuse=false) or (askforremovingform.modalresult=mrOK) then
        begin
          for i:=Grouplistbox.itemindex to length(mainform.devicegroups)-2 do
          begin
            mainform.DeviceGroups[i].Active:=mainform.DeviceGroups[i+1].Active;
            mainform.DeviceGroups[i].ID:=mainform.DeviceGroups[i+1].ID;
            mainform.DeviceGroups[i].Name:=mainform.DeviceGroups[i+1].Name;
            mainform.DeviceGroups[i].Beschreibung:=mainform.DeviceGroups[i+1].Beschreibung;

            setlength(mainform.DeviceGroups[i].IDs,length(mainform.DeviceGroups[i+1].IDs));
            setlength(mainform.DeviceGroups[i].IDActive,length(mainform.DeviceGroups[i+1].IDActive));
            setlength(mainform.DeviceGroups[i].Delays,length(mainform.DeviceGroups[i+1].Delays));
            for k:=0 to length(mainform.DeviceGroups[i].IDs)-1 do
            begin
              mainform.DeviceGroups[i].IDs[k]:=mainform.DeviceGroups[i+1].IDs[k];
              mainform.DeviceGroups[i].IDActive[k]:=mainform.DeviceGroups[i+1].IDActive[k];
              mainform.DeviceGroups[i].Delays[k]:=mainform.DeviceGroups[i+1].Delays[k];
            end;
            mainform.DeviceGroups[i].MasterDevice:=mainform.DeviceGroups[i+1].MasterDevice;
            mainform.DeviceGroups[i].UseMaster:=mainform.DeviceGroups[i+1].UseMaster;
            mainform.DeviceGroups[i].FanMode:=mainform.DeviceGroups[i+1].FanMode;
            mainform.DeviceGroups[i].FanMorph:=mainform.DeviceGroups[i+1].FanMorph;
            mainform.DeviceGroups[i].Delay:=mainform.DeviceGroups[i+1].Delay;
          end;
          setlength(mainform.DeviceGroups,length(mainform.DeviceGroups)-1);
        end;
      end;
    end;
    if grouplistbox.itemindex=grouplistbox.items.Count-1 then
      grouplistbox.itemindex:=grouplistbox.items.Count-2;
    GroupListChanged;
  end;
end;

procedure Tgroupeditorform.ActivateGroupBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>Grouplistbox.itemindex then
  begin
    mainform.SelectDeviceGroup(mainform.DeviceGroups[Grouplistbox.itemindex].ID, false);
  end;
end;

procedure Tgroupeditorform.AddDeviceGroupWithoutDeselectBtnClick(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if length(mainform.DeviceGroups)>Grouplistbox.itemindex then
  begin
    mainform.SelectDeviceGroup(mainform.DeviceGroups[Grouplistbox.itemindex].ID, true);
  end;
end;

procedure Tgroupeditorform.ShowGroupIDbtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (length(mainform.DeviceGroups)>Grouplistbox.itemindex) and (grouplistbox.itemindex>-1) then
  begin
    InputBox(_('Gruppen-ID'),_('Die ID der aktuellen Gruppe lautet wie folgt:'),GUIDtoString(mainform.DeviceGroups[Grouplistbox.itemindex].ID));
  end;
end;

procedure Tgroupeditorform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tgroupeditorform.GroupListBoxChange(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1, false) then exit;

  if (grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    GroupNameEdit.text:=mainform.devicegroups[grouplistbox.itemindex].Name;
    GroupDescEdit.text:=mainform.devicegroups[grouplistbox.itemindex].Beschreibung;
    GroupActive.checked:=mainform.devicegroups[grouplistbox.itemindex].Active;
  end;
  RefreshGrid;
end;

procedure Tgroupeditorform.GroupNameEditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  lastindex:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (key=vk_return) and (Grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    lastindex:=GroupListbox.itemindex;

    mainform.DeviceGroups[grouplistbox.itemindex].Name:=groupnameedit.Text;
    grouplistbox.items[grouplistbox.ItemIndex]:=groupnameedit.Text;

    GroupListChanged;
    GroupListbox.itemindex:=lastindex;
    GroupListBoxChange(nil);
  end;
end;

procedure Tgroupeditorform.GroupDescEditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (key=vk_return) and (Grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    mainform.DeviceGroups[grouplistbox.itemindex].Beschreibung:=groupdescedit.text;
    GroupListChanged;
  end;
end;

procedure Tgroupeditorform.AddDeviceBtnClick(Sender: TObject);
var
  i,j:integer;
  vorhanden:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (Grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    adddevicetogroupform.DeviceAndGroupMode:=false;
    adddevicetogroupform.showmodal;

    if adddevicetogroupform.modalresult=mrOK then
    begin
      for i:=0 to length(mainform.devices)-1 do
      begin
        if adddevicetogroupform.listbox1.Selected[i] then
        begin
          vorhanden:=false;
          for j:=0 to length(mainform.DeviceGroups[grouplistbox.itemindex].IDs)-1 do
          begin
            if IsEqualGUID(mainform.devices[i].ID,mainform.DeviceGroups[grouplistbox.itemindex].IDs[j]) then
            begin
              vorhanden:=true;
              break;
            end;
          end;
          if not vorhanden then
          begin
            setlength(mainform.DeviceGroups[grouplistbox.itemindex].IDs,length(mainform.DeviceGroups[grouplistbox.itemindex].IDs)+1);
            setlength(mainform.DeviceGroups[grouplistbox.itemindex].IDActive,length(mainform.DeviceGroups[grouplistbox.itemindex].IDActive)+1);
            setlength(mainform.DeviceGroups[grouplistbox.itemindex].Delays,length(mainform.DeviceGroups[grouplistbox.itemindex].Delays)+1);
            mainform.DeviceGroups[grouplistbox.itemindex].IDs[length(mainform.DeviceGroups[grouplistbox.itemindex].IDs)-1]:=mainform.devices[i].ID;
            mainform.DeviceGroups[grouplistbox.itemindex].IDActive[length(mainform.DeviceGroups[grouplistbox.itemindex].IDActive)-1]:=true;
          end;
        end;
      end;

      setlength(mainform.DeviceGroups[grouplistbox.itemindex].HasChanType,length(mainform.DeviceChannelNames));
      geraetesteuerung.CheckDeviceGroupIntersection(grouplistbox.itemindex, mainform.DeviceGroups[grouplistbox.itemindex].HasChanType);

      RefreshGrid;
    end;
  end;
end;

procedure Tgroupeditorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure Tgroupeditorform.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
  with StringGrid1.Canvas do
  begin
    if Rect.Top = 0 then
    begin
      Brush.Color := clBtnFace;
      FillRect(Rect);
      Pen.Color := clWhite;
      Rectangle(Rect);
      TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
      Exit;
    end;

    if (ACol=Stringgrid1.Col) and (ARow=Stringgrid1.Row) then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end else
    begin
      Brush.Color := clWhite;
      Font.Color:=clWindowText;
    end;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);


    if (ARow>0) and (ACol = 0) and (Grouplistbox.itemindex>-1) and (Grouplistbox.itemindex<length(mainform.devicegroups)) and ((ARow-1)<length(mainform.devicegroups[Grouplistbox.itemindex].IDs)) then
    begin
      //Kasten zeichnen
      AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
      AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

      ARect.Left := AOffSet.X + Rect.Left;
      ARect.Top := AOffSet.Y + Rect.Top;
      ARect.Right := AOffSet.X + Rect.Left + 11;
      ARect.Bottom := AOffSet.Y + Rect.Top + 11;

      Pen.Color := clGray;
      Rectangle(ARect);

      // Abfrage ob Haken zeichnen oder nicht
      if (ARow>0) and (Grouplistbox.itemindex<length(mainform.devicegroups)) and ((ARow-1)<length(mainform.devicegroups[Grouplistbox.itemindex].IDActive)) then
      if mainform.devicegroups[Grouplistbox.itemindex].IDActive[ARow-1] then
      begin
        //Haken zeichnen
        AHaken1.X := ARect.Left + 2;
        AHaken1.Y := ARect.Top + 6;
        AHaken2.X := ARect.Left + 4;
        AHaken2.Y := ARect.Top + 8;
        AHaken3.X := ARect.Left + 9;
        AHaken3.Y := ARect.Top + 3;

        Pen.Color := clBlack; // Farbe des Häkchens

        MoveTo(AHaken1.X, AHaken1.Y - 0);
        LineTo(AHaken2.X, AHaken2.Y - 0);
        LineTo(AHaken3.X, AHaken3.Y - 0);

        MoveTo(AHaken1.X, AHaken1.Y - 1);
        LineTo(AHaken2.X, AHaken2.Y - 1);
        LineTo(AHaken3.X, AHaken3.Y - 1);

        MoveTo(AHaken1.X, AHaken1.Y - 2);
        LineTo(AHaken2.X, AHaken2.Y - 2);
        LineTo(AHaken3.X, AHaken3.Y - 2);
      end;
    end;
    TextOut(Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure Tgroupeditorform.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Grouplistbox.itemindex = -1 then begin
    Exit;
  end;

  if (StringGrid1.Col=0) and (StringGrid1.Row>0) and (Grouplistbox.itemindex<length(mainform.devicegroups)) and ((StringGrid1.Row-1)<length(mainform.devicegroups[Grouplistbox.itemindex].IDActive)) then
  begin
    mainform.devicegroups[Grouplistbox.itemindex].IDActive[StringGrid1.Row-1]:=not mainform.devicegroups[Grouplistbox.itemindex].IDActive[StringGrid1.Row-1];
		StringGrid1.Refresh;
  end;
end;

procedure Tgroupeditorform.GroupActiveMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    mainform.DeviceGroups[grouplistbox.itemindex].Active:=GroupActive.Checked;
  end;
end;

procedure Tgroupeditorform.CreateParams(var Params:TCreateParams);
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

procedure Tgroupeditorform.GroupNameEditExit(Sender: TObject);
var
  lastindex:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (Grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    lastindex:=GroupListbox.itemindex;

    mainform.DeviceGroups[grouplistbox.itemindex].Name:=groupnameedit.Text;
    grouplistbox.items[grouplistbox.ItemIndex]:=groupnameedit.Text;

    GroupListChanged;
    GroupListbox.itemindex:=lastindex;
    GroupListBoxChange(nil);
  end;
end;

procedure Tgroupeditorform.GroupDescEditExit(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (Grouplistbox.itemindex>-1) and (grouplistbox.itemindex<length(mainform.devicegroups)) then
  begin
    mainform.DeviceGroups[grouplistbox.itemindex].Beschreibung:=groupdescedit.text;
    GroupListChanged;
  end;
end;

procedure Tgroupeditorform.groupupbtnClick(Sender: TObject);
var
  source, destination:integer;
  k:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if Grouplistbox.ItemIndex=0 then exit;

  // Am Ende neue Gruppe einfügen
  setlength(mainform.DeviceGroups, length(mainform.DeviceGroups)+1);

  // obere Gruppe ans Ende kopieren
  source:=Grouplistbox.ItemIndex-1;
  destination:=length(mainform.DeviceGroups)-1;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  mainform.DeviceGroups[destination].ID:=mainform.DeviceGroups[source].ID;
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name;
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  // aktuelle Gruppe nach oben kopieren
  source:=Grouplistbox.ItemIndex;
  destination:=Grouplistbox.ItemIndex-1;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  mainform.DeviceGroups[destination].ID:=mainform.DeviceGroups[source].ID;
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name;
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  // letzte Gruppe auf aktuelle Position kopieren
  source:=length(mainform.DeviceGroups)-1;
  destination:=Grouplistbox.ItemIndex;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  mainform.DeviceGroups[destination].ID:=mainform.DeviceGroups[source].ID;
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name;
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  // Array wieder um eins kürzen und Gruppenbox setzen
  setlength(mainform.DeviceGroups, length(mainform.DeviceGroups)-1);
  GroupListBox.itemindex:=GroupListBox.itemindex-1;
  GroupListChanged;
end;

procedure Tgroupeditorform.groupdownbtnClick(Sender: TObject);
var
  source, destination:integer;
  k:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if Grouplistbox.ItemIndex=(length(mainform.DeviceGroups)-1) then exit;

  // Am Ende neue Gruppe einfügen
  setlength(mainform.DeviceGroups, length(mainform.DeviceGroups)+1);

  // untere Gruppe ans Ende kopieren
  source:=Grouplistbox.ItemIndex+1;
  destination:=length(mainform.DeviceGroups)-1;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  mainform.DeviceGroups[destination].ID:=mainform.DeviceGroups[source].ID;
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name;
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  // aktuelle Gruppe nach unten kopieren
  source:=Grouplistbox.ItemIndex;
  destination:=Grouplistbox.ItemIndex+1;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  mainform.DeviceGroups[destination].ID:=mainform.DeviceGroups[source].ID;
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name;
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  // letzte Gruppe auf aktuelle Position kopieren
  source:=length(mainform.DeviceGroups)-1;
  destination:=Grouplistbox.ItemIndex;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  mainform.DeviceGroups[destination].ID:=mainform.DeviceGroups[source].ID;
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name;
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  // Array wieder um eins kürzen und Gruppenbox setzen
  setlength(mainform.DeviceGroups, length(mainform.DeviceGroups)-1);
  GroupListBox.itemindex:=GroupListBox.itemindex+1;
  GroupListChanged;
end;

procedure Tgroupeditorform.copybtnClick(Sender: TObject);
var
  k, source, destination:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  // Am Ende neue Gruppe einfügen
  setlength(mainform.DeviceGroups, length(mainform.DeviceGroups)+1);

  // aktuelle Gruppe ans Ende kopieren
  source:=Grouplistbox.ItemIndex;

  destination:=length(mainform.DeviceGroups)-1;
  mainform.DeviceGroups[destination].Active:=mainform.DeviceGroups[source].Active;
  CreateGUID(mainform.DeviceGroups[destination].ID);
  mainform.DeviceGroups[destination].Name:=mainform.DeviceGroups[source].Name+' - '+_('Kopie');
  mainform.DeviceGroups[destination].Beschreibung:=mainform.DeviceGroups[source].Beschreibung;

  setlength(mainform.DeviceGroups[destination].IDs,length(mainform.DeviceGroups[source].IDs));
  setlength(mainform.DeviceGroups[destination].IDActive,length(mainform.DeviceGroups[source].IDActive));
  setlength(mainform.DeviceGroups[destination].Delays,length(mainform.DeviceGroups[source].Delays));
  for k:=0 to length(mainform.DeviceGroups[destination].IDs)-1 do
  begin
    mainform.DeviceGroups[destination].IDs[k]:=mainform.DeviceGroups[source].IDs[k];
    mainform.DeviceGroups[destination].IDActive[k]:=mainform.DeviceGroups[source].IDActive[k];
    mainform.DeviceGroups[destination].Delays[k]:=mainform.DeviceGroups[source].Delays[k];
  end;
  mainform.DeviceGroups[destination].MasterDevice:=mainform.DeviceGroups[source].MasterDevice;
  mainform.DeviceGroups[destination].UseMaster:=mainform.DeviceGroups[source].UseMaster;
  mainform.DeviceGroups[destination].FanMode:=mainform.DeviceGroups[source].FanMode;
  mainform.DeviceGroups[destination].FanMorph:=mainform.DeviceGroups[source].FanMorph;
  mainform.DeviceGroups[destination].Delay:=mainform.DeviceGroups[source].Delay;

  setlength(mainform.DeviceGroups[destination].HasChanType,length(mainform.DeviceGroups[source].HasChanType));
  for k:=0 to length(mainform.DeviceGroups[destination].HasChanType)-1 do
  begin
    mainform.DeviceGroups[destination].HasChanType[k]:=mainform.DeviceGroups[source].HasChanType[k];
  end;

  GroupListBox.Items.Add(mainform.DeviceGroups[destination].Name);
end;

end.
