unit preseteditorform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, CheckLst, ExtCtrls, JvExExtCtrls,
  JvExtComponent, JvPanel, JvOfficeColorPanel, gnugettext, pngimage,
  JvExControls, JvGradient, TiledImage, Math, HSLRingPicker, Mask,
  JvExMask, JvSpin, mbXPImageComboBox, ImgList;

type
  Tpreseteditor = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    OkBtn: TButton;
    GroupBox2: TGroupBox;
    CancelBtn: TButton;
    TreeView1: TTreeView;
    Edit3: TEdit;
    Panel5: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    GroupBox3: TGroupBox;
    CheckListBox1: TCheckListBox;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    ColorPicker: TJvOfficeColorPanel;
    R: TScrollBar;
    G: TScrollBar;
    B: TScrollBar;
    fadenkreuz: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    speed: TTrackBar;
    gobo1: TTrackBar;
    gobo2: TTrackBar;
    gobo3: TTrackBar;
    gobo1rot: TTrackBar;
    gobo2rot: TTrackBar;
    goboextra: TTrackBar;
    color1: TTrackBar;
    color2: TTrackBar;
    iris: TTrackBar;
    shutter: TTrackBar;
    dimmer: TTrackBar;
    zoom: TTrackBar;
    focus: TTrackBar;
    prism: TTrackBar;
    frost: TTrackBar;
    special1: TTrackBar;
    special2: TTrackBar;
    special3: TTrackBar;
    moves: TTrackBar;
    Panel3: TPanel;
    CheckBox1: TCheckBox;
    fadenkreuz2: TPanel;
    TiledImage2: TTiledImage;
    Bevel3: TBevel;
    Bevel4: TBevel;
    positionxy2: TShape;
    VertTrack: TTrackBar;
    HorTrack: TTrackBar;
    colorpicker2: THSLRingPicker;
    GroupBox4: TGroupBox;
    shuttercheck: TCheckBox;
    prismacheck: TCheckBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    dimmerslider: TTrackBar;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    stroboslider: TTrackBar;
    irisslider: TTrackBar;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    fokusslider: TTrackBar;
    prismaslider: TTrackBar;
    Label39: TLabel;
    Label40: TLabel;
    Button1: TButton;
    GroupBox8: TGroupBox;
    Label41: TLabel;
    Label42: TLabel;
    goborot1slider: TTrackBar;
    Button2: TButton;
    GroupBox9: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    goborot2slider: TTrackBar;
    Button3: TButton;
    zoomvalue: TJvSpinEdit;
    Label45: TLabel;
    GroupBox10: TGroupBox;
    ImageList1: TImageList;
    mbXPImageComboBox1: TmbXPImageComboBox;
    gobolbl: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    procedure CheckListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure change(Sender: TObject);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadenkreuzMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadenkreuzMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ColorPickerColorChange(Sender: TObject);
    procedure PositionXYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TiledImage2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TiledImage2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TiledImage2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure positionxy2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure positionxy2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure dimmersliderChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure prismacheckMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shuttercheckMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    usemhcontrol:boolean;
    rgn:HRGN;
    LastPosX, LastPosY:integer;
    DoFinePos:boolean;
    Bmp : TImage;
    procedure TreeViewRefresh;
    procedure SetPanTilt;
  public
    { Public-Deklarationen }
    panval, tiltval, panfineval, tiltfineval:byte;
    selectedgobo:String;

    NodeGUID : array of array of array of TGUID;
    NodeIndex : array of array of array of TTreenode;
    procedure CheckState;
  end;

var
  preseteditor: Tpreseteditor;

implementation

uses pcdimmer, geraetesteuerungfrm;

{$R *.dfm}

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure Tpreseteditor.positionxy2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssShift, ssCtrl] then
  begin
    usemhcontrol:=not usemhcontrol;
    if usemhcontrol then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz2.Width,fadenkreuz2.Height,fadenkreuz2.Width,fadenkreuz2.Height);
      SetWindowRgn(fadenkreuz.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz.Handle, 0, True);
    end;
  end;
end;

procedure Tpreseteditor.CheckListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckState;
end;

procedure Tpreseteditor.TreeViewRefresh;
var
  i,j:integer;
  vendornode,devicenode,subnode:TTreenode;
begin
  TreeView1.Items.Clear;
  setlength(NodeGUID,0);
  setlength(NodeIndex,0);

  for i:=0 to length(mainform.devices)-1 do
  begin
    vendornode:=nil;
    devicenode:=nil;

    // Herausfinden, ob für Device-Vendor schon ein Top-Node vorhanden ist
    for j:=0 to Treeview1.Items.Count-1 do
    begin
      if (Treeview1.Items[j].Text=mainform.devices[i].vendor) and (Treeview1.Items[j].Parent.Index=-1) then
        vendornode:=Treeview1.Items[j];
    end;
    // Wenn kein DeviceVendorNode verfügbar -> erstellen
    if vendornode=nil then
    begin
      vendornode:=Treeview1.Items.Add(nil,mainform.devices[i].Vendor);
      setlength(NodeGUID,length(NodeGUID)+1);
      setlength(NodeIndex,length(NodeIndex)+1);
    end;

    vendornode.ImageIndex:=3;
    vendornode.SelectedIndex:=3;

    // Herausfinden, ob für DeviceTyp schon ein Sub-Node vorhanden ist
    for j:=0 to Treeview1.Items.Count-1 do
    begin
      if (Treeview1.Items[j].Parent.Index<>-1) and (Treeview1.Items[j].Parent.Text=mainform.devices[i].Vendor) and (Treeview1.Items[j].Text=mainform.devices[i].DeviceName) then
        if (Treeview1.Items[j].Parent.Parent.Index=-1) then
          devicenode:=Treeview1.Items[j];
    end;
    // Wenn kein DeviceTypNode verfügbar -> erstellen
    if devicenode=nil then
    begin
      devicenode:=Treeview1.Items.AddChild(vendornode,mainform.devices[i].DeviceName);
      setlength(NodeGUID[vendornode.index],length(NodeGUID[vendornode.index])+1);
      setlength(NodeIndex[vendornode.index],length(NodeIndex[vendornode.index])+1);
    end;

    devicenode.ImageIndex:=1;
    devicenode.SelectedIndex:=1;

    // Neuen Device-SubSubNode für Gerät erstellen
    subnode:=TreeView1.Items.AddChild(devicenode,mainform.devices[i].name);
    setlength(NodeGUID[vendornode.Index][devicenode.index],length(NodeGUID[vendornode.Index][devicenode.index])+1);
    setlength(NodeIndex[vendornode.Index][devicenode.index],length(NodeIndex[vendornode.Index][devicenode.index])+1);
    NodeGUID[vendornode.Index][devicenode.index][length(NodeGUID[vendornode.index][devicenode.Index])-1]:=mainform.devices[i].ID;
    NodeIndex[vendornode.Index][devicenode.index][length(NodeIndex[vendornode.index][devicenode.Index])-1]:=subnode;

    subnode.ImageIndex:=25;
    subnode.SelectedIndex:=70;
  end;

  for i:=0 to length(mainform.devicegroups)-1 do
  begin
    vendornode:=nil;
    devicenode:=nil;

    // Herausfinden, ob für Device-Vendor schon ein Top-Node vorhanden ist
    for j:=0 to Treeview1.Items.Count-1 do
    begin
      if (Treeview1.Items[j].Text=_('Programmintern')) and (Treeview1.Items[j].Parent.Index=-1) then
        vendornode:=Treeview1.Items[j];
    end;

    // Wenn kein DeviceVendorNode verfügbar -> erstellen
    if vendornode=nil then
    begin
      vendornode:=Treeview1.Items.Add(nil,_('Programmintern'));
      setlength(NodeGUID,length(NodeGUID)+1);
      setlength(NodeIndex,length(NodeIndex)+1);
    end;

    vendornode.Imageindex:=3;
    vendornode.Selectedindex:=3;

    // Herausfinden, ob für DeviceTyp schon ein Sub-Node vorhanden ist
    for j:=0 to Treeview1.Items.Count-1 do
    begin
      if (Treeview1.Items[j].Parent.Index<>-1) and (Treeview1.Items[j].Text=_('Gerätegruppen')) then
        if (Treeview1.Items[j].Parent.Parent.Index=-1) then
          devicenode:=Treeview1.Items[j];
    end;

    // Wenn kein DeviceTypNode verfügbar -> erstellen
    if devicenode=nil then
    begin
      devicenode:=Treeview1.Items.AddChild(vendornode,_('Gerätegruppen'));
      setlength(NodeGUID[vendornode.index],length(NodeGUID[vendornode.index])+1);
      setlength(NodeIndex[vendornode.index],length(NodeIndex[vendornode.index])+1);
    end;

    devicenode.ImageIndex:=1;
    devicenode.SelectedIndex:=1;

    // Neuen Device-SubSubNode für Gerät erstellen
    subnode:=TreeView1.Items.AddChild(devicenode,mainform.devicegroups[i].Name);
    setlength(NodeGUID[vendornode.Index][devicenode.index],length(NodeGUID[vendornode.Index][devicenode.index])+1);
    setlength(NodeIndex[vendornode.Index][devicenode.index],length(NodeIndex[vendornode.Index][devicenode.index])+1);
    NodeGUID[vendornode.Index][devicenode.index][length(NodeGUID[vendornode.index][devicenode.Index])-1]:=mainform.devicegroups[i].ID;
    NodeIndex[vendornode.Index][devicenode.index][length(NodeIndex[vendornode.index][devicenode.Index])-1]:=subnode;

    subnode.Imageindex:=25;
    subnode.Selectedindex:=25;
  end;
end;

procedure Tpreseteditor.FormShow(Sender: TObject);
var
  j:integer;
begin
  TreeViewRefresh;

  mbXPImageComboBox1.Clear;
  Imagelist1.Clear;

  for j:=0 to mainform.GoboPictures.Items.Count-1 do
  begin
{
    Rect.Left:=0;
    Rect.Top:=0;
    Rect.Right:=mainform.GoboPictures.Items.Items[j].PngImage.Width;
    Rect.Bottom:=mainform.GoboPictures.Items.Items[j].PngImage.Height;
    mainform.GoboPictures.Items.Items[j].PngImage.Draw(bmp.Picture.Bitmap.Canvas, Rect);

    ImageList1.Add(bmp.Picture.Bitmap, bmp.Picture.Bitmap);
}
    mbXPImageComboBox1.Items.Add(mainform.GoboPictures.Items.Items[j].Name);
  end;
//  mbXPImageComboBox1.Images:=ImageList1;

  gobolbl.caption:=selectedgobo;
end;

procedure Tpreseteditor.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if Button=mbRight then
  begin
    for i:=0 to Treeview1.items.count-1 do
      Treeview1.Deselect(Treeview1.items[i]);
  end;
  mainform.DeviceSelectionChanged(nil);
end;

procedure Tpreseteditor.change(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if (Sender=fadenkreuz) and Checklistbox1.Checked[0] then geraetesteuerung.set_channel(mainform.Devices[i].ID,'pan',round(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*255),round(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*255),0);
      if (Sender=fadenkreuz) and Checklistbox1.Checked[1] then geraetesteuerung.set_channel(mainform.Devices[i].ID,'tilt',round(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*255),round(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*255),0);
      if Sender=moves then geraetesteuerung.set_channel(mainform.Devices[i].ID,'move',moves.Position,moves.Position,0);
      if Sender=speed then geraetesteuerung.set_channel(mainform.Devices[i].ID,'speed',speed.Position,speed.Position,0);
      if Sender=gobo1 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'gobo1',gobo1.Position,gobo1.Position,0);
      if Sender=gobo1rot then geraetesteuerung.set_channel(mainform.Devices[i].ID,'gobo1rot',gobo1rot.Position,gobo1rot.Position,0);
      if Sender=gobo2 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'gobo2',gobo2.Position,gobo2.Position,0);
      if Sender=gobo2rot then geraetesteuerung.set_channel(mainform.Devices[i].ID,'gobo2rot',gobo2rot.Position,gobo2rot.Position,0);
      if Sender=gobo3 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'gobo3',gobo3.Position,gobo3.Position,0);
      if Sender=goboextra then geraetesteuerung.set_channel(mainform.Devices[i].ID,'extra',goboextra.Position,goboextra.Position,0);
      if Sender=color1 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'color1',color1.Position,color1.Position,0);
      if Sender=color2 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'color2',color2.Position,color2.Position,0);
      if (Sender=r) and Checklistbox1.Checked[12] then geraetesteuerung.set_channel(mainform.Devices[i].ID,'r',r.Position,r.Position,0);
      if (Sender=g) and Checklistbox1.Checked[13] then geraetesteuerung.set_channel(mainform.Devices[i].ID,'g',g.Position,g.Position,0);
      if (Sender=b) and Checklistbox1.Checked[14] then geraetesteuerung.set_channel(mainform.Devices[i].ID,'b',b.Position,b.Position,0);
      if Sender=iris then geraetesteuerung.set_channel(mainform.Devices[i].ID,'iris',iris.Position,iris.Position,0);
      if Sender=shutter then geraetesteuerung.set_channel(mainform.Devices[i].ID,'shutter',shutter.Position,shutter.Position,0);
      if Sender=dimmer then geraetesteuerung.set_channel(mainform.Devices[i].ID,'dimmer',dimmer.Position,dimmer.Position,0);
      if Sender=zoom then geraetesteuerung.set_channel(mainform.Devices[i].ID,'zoom',zoom.Position,zoom.Position,0);
      if Sender=focus then geraetesteuerung.set_channel(mainform.Devices[i].ID,'focus',focus.Position,focus.Position,0);
      if Sender=prism then geraetesteuerung.set_channel(mainform.Devices[i].ID,'prism',prism.Position,prism.Position,0);
      if Sender=frost then geraetesteuerung.set_channel(mainform.Devices[i].ID,'frost',frost.Position,frost.Position,0);
      if Sender=special1 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'special1',special1.Position,special1.Position,0);
      if Sender=special2 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'special2',special2.Position,special2.Position,0);
      if Sender=special3 then geraetesteuerung.set_channel(mainform.Devices[i].ID,'special3',special3.Position,special3.Position,0);
    end;
  end;
end;

procedure Tpreseteditor.TreeView1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j,k:integer;
  temp:TTreeNode;
  positionindevicearray, positioningrouparray:integer;
begin
  if Shift=[ssAlt] then
  if (Treeview1.SelectionCount=1) and (Treeview1.Selected.Parent.Index>-1) then
  if (Treeview1.Selected.Parent.Parent.Index=-1) then
  if (Treeview1.Selected.HasChildren) then
  begin
    // Oberobjekt deselektieren
    temp:=treeview1.Selected;
    treeview1.Deselect(treeview1.Selected);

    // Unterobjekte selektieren
    for i:=0 to temp.Count-1 do
      treeview1.Select(temp.Item[i],[ssCtrl]);
  end;

  // Alle Selektionen löschen
  for j:=0 to length(mainform.devices)-1 do
    mainform.DeviceSelected[j]:=false;

{
  // Selektionen neu setzen
  for i:=0 to Treeview1.SelectionCount-1 do
  begin
    // Geräteselektion aktualisieren
    if TreeView1.Selections[i].Parent.Index>-1 then
    if TreeView1.Selections[i].Parent.Parent.Index>-1 then
    for j:=0 to length(mainform.devices)-1 do
    begin
      if GUIDtoString(NodeGUID[TreeView1.Selections[i].Parent.Parent.Index][TreeView1.Selections[i].Parent.Index][Treeview1.selections[i].index])=GUIDtoString(mainform.Devices[j].ID) then
      begin
        mainform.DeviceSelected[j]:=true;
      end;
    end;
  end;
}
  for i:=0 to Treeview1.SelectionCount-1 do
  begin
    if (Treeview1.Selections[i].HasChildren=false) and Treeview1.Selections[i].Selected then
    begin
      positionindevicearray:=geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[Treeview1.Selections[i].Parent.Parent.Index][Treeview1.Selections[i].Parent.Index][Treeview1.Selections[i].Index]);
      positioningrouparray:=geraetesteuerung.GetGroupPositionInGroupArray(NodeGUID[Treeview1.Selections[i].Parent.Parent.Index][Treeview1.Selections[i].Parent.Index][Treeview1.Selections[i].Index]);

      if (positionindevicearray>-1) then
      begin
        // Ist Gerät
        mainform.deviceselected[positionindevicearray]:=true;
      end else
      begin
        // Ist Gruppe
        for k:=0 to length(mainform.DeviceGroups[positioningrouparray].IDs)-1 do
        begin
          for j:=0 to length(mainform.devices)-1 do
          begin
            if IsEqualGUID(mainform.deviceGroups[positioningrouparray].IDs[k],mainform.devices[j].ID) then
            begin
              mainform.DeviceSelected[j]:=true;
              break;
            end;
          end;
        end;
      end;
    end;
  end;

  change(nil);
  mainform.DeviceSelectionChanged(nil);
end;

procedure Tpreseteditor.fadenkreuzMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    PositionXY.Top:=Y-PositionXY.Height div 2;
    PositionXY.Left:=X-PositionXY.Width div 2;
  end else
  begin
    PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
    PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  end;
  change(fadenkreuz);
//  startscript(positionxy);
end;

procedure Tpreseteditor.fadenkreuzMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=x-(PositionXY.Width div 2);
    if ((y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=y-(PositionXY.Height div 2);
    PositionXY.Refresh;

//    startscript(positionxy);
    change(fadenkreuz);
  end;
end;

procedure Tpreseteditor.ColorPickerColorChange(Sender: TObject);
var
  Red,Green,Blue:byte;
begin
  TColor2RGB(colorpicker.SelectedColor,Red,Green,Blue);

  R.Position:=Red;
  G.Position:=Green;
  B.position:=Blue;
end;

procedure Tpreseteditor.PositionXYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    if ((PositionXY.Left+x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((PositionXY.Left+x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=PositionXY.Left+x-(PositionXY.Width div 2);
    if ((PositionXY.Top+y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((PositionXY.Top+y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=PositionXY.Top+y-(PositionXY.Height div 2);
    PositionXY.Refresh;

    change(fadenkreuz);
  end;
end;

procedure Tpreseteditor.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  if Node.HasChildren=false then
    mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@NodeGUID[Node.Parent.Parent.Index][Node.Parent.Index][Node.Index])].Name:=S;
end;

procedure Tpreseteditor.TreeView1Editing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  if Node.HasChildren then
    AllowEdit:=false;
end;

procedure Tpreseteditor.CheckState;
begin
  fadenkreuz.visible:=Checklistbox1.Checked[0] or Checklistbox1.Checked[1];
  moves.visible:=Checklistbox1.Checked[2];
  speed.visible:=Checklistbox1.Checked[3];
  gobo1.visible:=Checklistbox1.Checked[4];
  gobo1rot.visible:=Checklistbox1.Checked[5];
  gobo2.visible:=Checklistbox1.Checked[6];
  gobo2rot.visible:=Checklistbox1.Checked[7];
  gobo3.visible:=Checklistbox1.Checked[8];
  goboextra.visible:=Checklistbox1.Checked[9];
  color1.visible:=Checklistbox1.Checked[10];
  color2.visible:=Checklistbox1.Checked[11];
  colorpicker.visible:=Checklistbox1.Checked[12] or Checklistbox1.Checked[13] or Checklistbox1.Checked[14];
  r.visible:=Checklistbox1.Checked[12];
  g.visible:=Checklistbox1.Checked[13];
  b.visible:=Checklistbox1.Checked[14];
  iris.visible:=Checklistbox1.Checked[15];
  shutter.visible:=Checklistbox1.Checked[16];
  dimmer.visible:=Checklistbox1.Checked[17];
  zoom.visible:=Checklistbox1.Checked[18];
  focus.visible:=Checklistbox1.Checked[19];
  prism.visible:=Checklistbox1.Checked[20];
  frost.visible:=Checklistbox1.Checked[21];
  special1.visible:=Checklistbox1.Checked[22];
  special2.visible:=Checklistbox1.Checked[23];
  special3.visible:=Checklistbox1.Checked[24];
end;

procedure Tpreseteditor.Edit3Enter(Sender: TObject);
begin
  if Edit3.text=_('Suchtext hier eingeben...') then
  begin
    Edit3.Text:='';
    Edit3.Font.Color:=clBlack;
  end;
end;

procedure Tpreseteditor.Edit3Exit(Sender: TObject);
begin
  if Edit3.Text='' then
  begin
    Edit3.Text:=_('Suchtext hier eingeben...');
    Edit3.Font.Color:=clGray;
  end;
end;

procedure Tpreseteditor.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  Bmp := TImage.Create(self);
end;

procedure Tpreseteditor.CreateParams(var Params:TCreateParams);
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

procedure Tpreseteditor.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  panel2.visible:=checkbox1.checked;
  panel3.visible:=not checkbox1.checked;
  groupbox3.visible:=checkbox1.checked;

  if CheckBox1.Checked then
  begin
    groupbox2.height:=185;
    treeview1.height:=137;
  end else
  begin
    groupbox2.height:=345;
    treeview1.height:=297;
  end;
end;

procedure Tpreseteditor.TiledImage2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    if Shift=[ssCtrl] then
    begin
      DoFinePos:=true;
      PositionXY2.Top:=Y-PositionXY2.Height div 2;
      PositionXY2.Left:=X-PositionXY2.Width div 2;
    end else
    begin
      DoFinePos:=false;
      PositionXY2.Top:=Y-PositionXY2.Height div 2;
      PositionXY2.Left:=X-PositionXY2.Width div 2;
      LastPosX:=PositionXY2.Left;
      LastPosY:=PositionXY2.Top;
    end;
  end else
  begin
    PositionXY2.Top:=(fadenkreuz2.Height div 2)-(PositionXY2.Height div 2);
    PositionXY2.Left:=(fadenkreuz2.Width div 2)-(PositionXY2.Width div 2);
  end;
  SetPanTilt;
end;

procedure Tpreseteditor.TiledImage2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pan,tilt,r,phi:extended;
begin
  if (Shift=[ssLeft]) or (Shift=[ssLeft, ssCtrl]) then
  begin
    if usemhcontrol then
    begin
	    pan:=((x-(fadenkreuz2.Width/2))/fadenkreuz2.Width)*2;	//-1..0..1
	    tilt:=((y-(fadenkreuz2.Width/2))/fadenkreuz2.Height)*2;	//-1..0..1
      r:=sqrt(pan*pan+tilt*tilt);

      if (r<=1) then  // prüfen, ob Punkt innerhalb von maximalem Radius
      begin
        positionxy2.Left:=x-(positionxy2.Width div 2);
        positionxy2.Top:=y-(positionxy2.Height div 2);
      end else
      begin
        // Punkt an äußerem Radius entlangführen
        if (tilt>=0) then
          phi:=arccos(pan/r)
        else
          phi:=(2*Pi)-arccos(pan/r);

        if (Pi/2)>=phi then
          phi:=phi+(Pi*1.5)
        else
          phi:=phi-(Pi/2);
        phi:=2*Pi-phi;

        positionxy2.Left:=round((sin(phi)*fadenkreuz2.Width/2)+(fadenkreuz2.Width/2)-(positionxy2.Width/2));
        positionxy2.Top:=round((cos(phi)*fadenkreuz2.Height/2)+(fadenkreuz2.Height/2)-(positionxy2.Height/2));
      end;
      positionxy2.Refresh;
      SetPanTilt;
    end else
    begin
      if Shift=[ssLeft,ssCtrl] then
      begin
        DoFinePos:=true;
        if ((x-(positionxy2.Width div 2))>=0-(positionxy2.Width div 2)) and ((x-(positionxy2.Width div 2))<=fadenkreuz2.Width-(positionxy2.Width div 2)) then positionxy2.Left:=x-(positionxy2.Width div 2);
        if ((y-(positionxy2.Height div 2))>=0-(positionxy2.Height div 2)) and ((y-(positionxy2.Height div 2))<=fadenkreuz2.Height-(positionxy2.Height div 2)) then positionxy2.Top:=y-(positionxy2.Height div 2);
      end else
      begin
        DoFinePos:=false;
        if ((x-(positionxy2.Width div 2))>=0-(positionxy2.Width div 2)) and ((x-(positionxy2.Width div 2))<=fadenkreuz2.Width-(positionxy2.Width div 2)) then positionxy2.Left:=x-(positionxy2.Width div 2);
        if ((y-(positionxy2.Height div 2))>=0-(positionxy2.Height div 2)) and ((y-(positionxy2.Height div 2))<=fadenkreuz2.Height-(positionxy2.Height div 2)) then positionxy2.Top:=y-(positionxy2.Height div 2);
        LastPosX:=positionxy2.Left;
        LastPosY:=positionxy2.Top;
      end;

      positionxy2.Refresh;
      SetPanTilt;
    end;
  end;
end;

procedure Tpreseteditor.TiledImage2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssShift, ssCtrl] then
  begin
    usemhcontrol:=not usemhcontrol;
    VertTrack.Visible:=not usemhcontrol;
    HorTrack.Visible:=not usemhcontrol;

    if usemhcontrol then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz2.Width,fadenkreuz2.Height,fadenkreuz2.Width,fadenkreuz2.Height);
      SetWindowRgn(fadenkreuz2.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz2.Handle, 0, True);
    end;
  end;

  if Shift=[ssShift] then
  begin
    VertTrack.Visible:=not VertTrack.Visible;
    HorTrack.Visible:=VertTrack.Visible;
  end;
end;

procedure Tpreseteditor.positionxy2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pan, tilt, r, phi:extended;
begin
  if (Shift=[ssLeft]) or (Shift=[ssLeft,ssCtrl]) then
  begin
    if usemhcontrol then
    begin
	    pan:=(((positionxy2.Left+x)-(fadenkreuz2.Width/2))/fadenkreuz2.Width)*2;	//-1..0..1
	    tilt:=(((positionxy2.Top+y)-(fadenkreuz2.Width/2))/fadenkreuz2.Height)*2;	//-1..0..1
      r:=sqrt(pan*pan+tilt*tilt);

      if (r<=1) then  // prüfen, ob Punkt innerhalb von maximalem Radius
      begin
        positionxy2.Left:=(positionxy2.Left+x)-(positionxy2.Width div 2);
        positionxy2.Top:=(positionxy2.Top+y)-(positionxy2.Height div 2);
      end else
      begin
        // Punkt an äußerem Radius entlangführen
        if (tilt>=0) then
          phi:=arccos(pan/r)
        else
          phi:=(2*Pi)-arccos(pan/r);

        if (Pi/2)>=phi then
          phi:=phi+(Pi*1.5)
        else
          phi:=phi-(Pi/2);
        phi:=2*Pi-phi;

        positionxy2.Left:=round((sin(phi)*fadenkreuz2.Width/2)+(fadenkreuz2.Width/2)-(positionxy2.Width/2));
        positionxy2.Top:=round((cos(phi)*fadenkreuz2.Height/2)+(fadenkreuz2.Height/2)-(positionxy2.Height/2));
      end;
      positionxy2.Refresh;
      SetPanTilt;
    end else
    begin
      if Shift=[ssLeft,ssCtrl] then
      begin
        DoFinePos:=true;
        if ((positionxy2.Left+x-(positionxy2.Width div 2))>=0-(positionxy2.Width div 2)) and ((positionxy2.Left+x-(positionxy2.Width div 2))<=fadenkreuz2.Width-(positionxy2.Width div 2)) then positionxy2.Left:=positionxy2.Left+x-(positionxy2.Width div 2);
        if ((positionxy2.Top+y-(positionxy2.Height div 2))>=0-(positionxy2.Height div 2)) and ((positionxy2.Top+y-(positionxy2.Height div 2))<=fadenkreuz2.Height-(positionxy2.Height div 2)) then positionxy2.Top:=positionxy2.Top+y-(positionxy2.Height div 2);
      end else
      begin
        DoFinePos:=false;
        if ((positionxy2.Left+x-(positionxy2.Width div 2))>=0-(positionxy2.Width div 2)) and ((positionxy2.Left+x-(positionxy2.Width div 2))<=fadenkreuz2.Width-(positionxy2.Width div 2)) then positionxy2.Left:=positionxy2.Left+x-(positionxy2.Width div 2);
        if ((positionxy2.Top+y-(positionxy2.Height div 2))>=0-(positionxy2.Height div 2)) and ((positionxy2.Top+y-(positionxy2.Height div 2))<=fadenkreuz2.Height-(positionxy2.Height div 2)) then positionxy2.Top:=positionxy2.Top+y-(positionxy2.Height div 2);
        LastPosX:=positionxy2.Left;
        LastPosY:=positionxy2.Top;
      end;
      positionxy2.Refresh;
      SetPanTilt;
    end;
  end;
end;

procedure Tpreseteditor.Button1Click(Sender: TObject);
begin
  prismaslider.position:=127;
end;

procedure Tpreseteditor.Button2Click(Sender: TObject);
begin
  goborot1slider.position:=127;
end;

procedure Tpreseteditor.Button3Click(Sender: TObject);
begin
  goborot2slider.position:=127;
end;

procedure Tpreseteditor.dimmersliderChange(Sender: TObject);
var
  i:integer;
  R,G,B:byte;
begin
  if dimmerslider.position<0 then
    label27.Caption:=_('Dimmer')+_(' aus')
  else
    label27.Caption:=_('Dimmer')+' '+floattostrf(dimmerslider.position/2.55, ffFixed, 15, 1)+'%';
  if stroboslider.position<0 then
    label29.Caption:=_('Stroboskop')+_(' aus')
  else
    label29.Caption:=_('Stroboskop')+' '+floattostrf(stroboslider.position/2.55, ffFixed, 15, 1)+'%';
  if irisslider.position<0 then
    label33.Caption:=_('Iris')+_(' aus')
  else
    label33.Caption:=_('Iris')+' '+floattostrf(irisslider.position/2.55, ffFixed, 15, 1)+'%';
  if fokusslider.position<0 then
    label37.Caption:=_('Fokus')+_(' aus')
  else
    label37.Caption:=_('Fokus')+' '+floattostrf(fokusslider.position/2.55, ffFixed, 15, 1)+'%';

  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_gobo1rot(mainform.Devices[i].ID, goborot1slider.position);

      geraetesteuerung.set_gobo2rot(mainform.Devices[i].ID, goborot2slider.position);

      geraetesteuerung.set_prismarot(mainform.Devices[i].ID, prismaslider.position);

      if fokusslider.position>-1 then
        geraetesteuerung.set_channel(mainform.Devices[i].ID, 'FOCUS', -1, fokusslider.position, 0);

      if irisslider.position>-1 then
        geraetesteuerung.set_iris(mainform.Devices[i].ID, irisslider.position);

      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'PAN', -1, panval, 0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'PANFINE', -1, panfineval, 0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'TILT', -1, tiltval, 0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'TILTFINE', -1, tiltfineval, 0);

      TColor2RGB(colorpicker2.SelectedColor, R,G,B);
      geraetesteuerung.set_color(mainform.Devices[i].ID, R, G, B, 0, 0);

      selectedgobo:=mbXPImageComboBox1.Items[mbXPImageComboBox1.ItemIndex];
      gobolbl.caption:=selectedgobo;
      geraetesteuerung.set_gobo(mainform.Devices[i].ID, selectedgobo);

      if shuttercheck.state=cbChecked then
      begin
        // OFFEN
        geraetesteuerung.set_shutter(mainform.Devices[i].ID, 255);
      end else if shuttercheck.state=cbUnchecked then
      begin
        // ZU
        geraetesteuerung.set_shutter(mainform.Devices[i].ID, 0);
      end else if shuttercheck.state=cbGrayed then
      begin
        // UNBESTIMMT
      end;

      if stroboslider.position>-1 then
        geraetesteuerung.set_strobe(mainform.Devices[i].ID, stroboslider.position);
      if dimmerslider.position>-1 then
        geraetesteuerung.set_dimmer(mainform.Devices[i].ID, dimmerslider.position);
{
      if UpperCase(mainform.Devices[i].StrobeChannel)='DIMMER' then
      begin
        // Strobe und Dimmer auf gleichem Kanal -> Strobe nur bei Dimmer=255
        if dimmerslider.position=255 then
          geraetesteuerung.set_strobe(mainform.Devices[i].ID, stroboslider.position)
        else
        begin
          if UpperCase(mainform.Devices[i].ShutterChannel)='DIMMER' then
          begin
            if shuttercheck.state=cbUnchecked then
              geraetesteuerung.set_dimmer(mainform.Devices[i].ID, 0)
            else if shuttercheck.state=cbGrayed then
              geraetesteuerung.set_dimmer(mainform.Devices[i].ID, dimmerslider.position)
            else if shuttercheck.state=cbChecked then
              geraetesteuerung.set_dimmer(mainform.Devices[i].ID, 255);
          end else
            geraetesteuerung.set_dimmer(mainform.Devices[i].ID, dimmerslider.position);
        end;
      end else
      begin
        // getrennte Kanäle
        if UpperCase(mainform.Devices[i].ShutterChannel)='DIMMER' then
        begin
          if shuttercheck.state=cbUnchecked then
            geraetesteuerung.set_dimmer(mainform.Devices[i].ID, 0)
          else if shuttercheck.state=cbGrayed then
            geraetesteuerung.set_dimmer(mainform.Devices[i].ID, dimmerslider.position)
          else if shuttercheck.state=cbChecked then
            geraetesteuerung.set_dimmer(mainform.Devices[i].ID, 255);
        end else
          geraetesteuerung.set_dimmer(mainform.Devices[i].ID, dimmerslider.position);

        geraetesteuerung.set_strobe(mainform.Devices[i].ID, stroboslider.position);
      end;
}

      if prismacheck.state=cbChecked then
        geraetesteuerung.set_prisma(mainform.Devices[i].ID, 255)
      else if prismacheck.state=cbUnchecked then
        geraetesteuerung.set_prisma(mainform.Devices[i].ID, 0);
    end;
  end;
end;

procedure Tpreseteditor.SetPanTilt;
var
	phi,rad,x,y:Extended;
	pan, tilt:Extended;
begin
  if usemhcontrol then
  begin
    // Moving-Head-Steuerung (Polarkoordinaten)
    x:=((PositionXY2.Left+(PositionXY2.Width div 2)-(Fadenkreuz2.Width/2))/Fadenkreuz2.Width)*2;	//-1..0..1
    y:=((PositionXY2.Top+(PositionXY2.Height div 2)-(Fadenkreuz2.Width/2))/Fadenkreuz2.Height)*2;	//-1..0..1
    rad:=sqrt(x*x+y*y);
	
    if (rad>0) then
    begin
      if (y>=0) then
        phi:=arccos(x/rad)
      else
        phi:=6.283185307179586476925286766559-arccos(x/rad);
    end else
     phi:=64;
		
    rad:=128-((rad/2)*255);
    phi:=(phi/6.283185307179586476925286766559)*255;
    if 64>=phi then
      phi:=phi+191
    else
      phi:=phi-64;
	
    pan:=255-phi;
    tilt:=255-rad;

    panval:=trunc(pan);
    panfineval:=trunc(frac(pan)*255);
    tiltval:=trunc(tilt);
    tiltfineval:=trunc(frac(tilt)*255);
  end else
  begin
    if DoFinePos then
    begin
      panval:=trunc(((LastPosX+(PositionXY2.Width/2))/Fadenkreuz2.Width)*255)+(trunc(((PositionXY2.Left+(PositionXY2.Width/2))/Fadenkreuz2.Width)*zoomvalue.value)-round(zoomvalue.value/2));
      panfineval:=trunc(frac((((LastPosX+(PositionXY2.Width/2))/Fadenkreuz2.Width)*255)+((((PositionXY2.Left+(PositionXY2.Width/2))/Fadenkreuz2.Width)*zoomvalue.value)-(zoomvalue.value/2)))*255);
      tiltval:=trunc(((LastPosY+(PositionXY2.Height/2))/Fadenkreuz2.Height)*255)+(trunc(((PositionXY2.Top+(PositionXY2.Height/2))/Fadenkreuz2.Height)*zoomvalue.value)-round(zoomvalue.value/2));
      tiltfineval:=trunc(frac((((LastPosY+(PositionXY2.Height/2))/Fadenkreuz2.Height)*255)+((((PositionXY2.Top+(PositionXY2.Height/2))/Fadenkreuz2.Height)*zoomvalue.value)-(zoomvalue.value/2)))*255);
    end else
    begin
      panval:=trunc(((PositionXY2.Left+(PositionXY2.Width/2))/Fadenkreuz2.Width)*255);
      panfineval:=trunc(frac(((PositionXY2.Left+(PositionXY2.Width/2))/Fadenkreuz2.Width)*255)*255);
      tiltval:=trunc(((PositionXY2.Top+(PositionXY2.Height/2))/Fadenkreuz2.Height)*255);
      tiltfineval:=trunc(frac(((PositionXY2.Top+(PositionXY2.Height/2))/Fadenkreuz2.Height)*255)*255);
    end;
  end;
  dimmersliderchange(nil);
end;

procedure Tpreseteditor.FormDestroy(Sender: TObject);
begin
  Bmp.Free;
end;

procedure Tpreseteditor.prismacheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dimmersliderChange(nil);
end;

procedure Tpreseteditor.shuttercheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dimmersliderChange(nil);
end;

procedure Tpreseteditor.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
  Text,Suchtext:string;
begin
  if key=vk_return then
  begin
    LockWindow(Treeview1.Handle);
    Treeview1.FullCollapse;
    UnLockWindow(Treeview1.Handle);
    Suchtext:=lowercase(Edit3.Text);

    for i:=0 to Treeview1.Items.Count-1 do
    begin
      Treeview1.Deselect(Treeview1.Items[i]);

      Text:=copy(Treeview1.Items[i].Text,0,length(Treeview1.Items[i].Text));

      if pos(Suchtext, lowercase(Text))>0 then
      begin
        Treeview1.Select(Treeview1.Items[i]);
        if Treeview1.Items[i].HasChildren then
        begin
          Treeview1.Select(Treeview1.Items[i].getFirstChild);
          if Treeview1.Items[i].getFirstChild.HasChildren then
          begin
            Treeview1.Select(Treeview1.Items[i].getFirstChild.getFirstChild);
          end
        end;
        exit;
      end;
    end;
  end;
end;

end.
