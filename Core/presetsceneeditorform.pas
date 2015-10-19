unit presetsceneeditorform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, CheckLst, ExtCtrls, JvExExtCtrls,
  JvExtComponent, JvPanel, JvOfficeColorPanel, gnugettext, pngimage,
  JvExControls, JvGradient, TiledImage, Math, HSLRingPicker, Mask,
  JvExMask, JvSpin, mbXPImageComboBox, ImgList;

type
  Tpresetsceneeditor = class(TForm)
    Panel1: TPanel;
    Panel5: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    Panel3: TPanel;
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
    mbXPImageComboBox1: TmbXPImageComboBox;
    gobolbl: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    Panel2: TPanel;
    Panel11: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    TreeView1: TTreeView;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Edit3: TEdit;
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
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
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    usemhcontrol:boolean;
    rgn:HRGN;
    LastPosX, LastPosY:integer;
    DoFinePos:boolean;
    Bmp : TImage;
    procedure SetPanTilt;
    procedure UpdateSelection;
  public
    { Public-Deklarationen }
    panval, tiltval, panfineval, tiltfineval:byte;
    selectedgobo:string;

    NodeGUID : array of array of array of TGUID;
    NodeIndex : array of array of array of TTreenode;

    SelectedDevices:array of TGUID;
    procedure TreeViewRefresh;
  end;

var
  presetsceneeditor: Tpresetsceneeditor;

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

procedure Tpresetsceneeditor.positionxy2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssShift, ssCtrl] then
  begin
    usemhcontrol:=not usemhcontrol;
    if usemhcontrol then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz2.Width,fadenkreuz2.Height,fadenkreuz2.Width,fadenkreuz2.Height);
      SetWindowRgn(fadenkreuz2.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz2.Handle, 0, True);
    end;
  end;
end;

procedure Tpresetsceneeditor.TreeViewRefresh;
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

procedure Tpresetsceneeditor.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if Button=mbRight then
  begin
    for i:=0 to Treeview1.items.count-1 do
      Treeview1.Deselect(Treeview1.items[i]);
  end;
//  mainform.DeviceSelectionChanged(nil);
  UpdateSelection
end;

procedure Tpresetsceneeditor.TreeView1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  temp:TTreeNode;
//  positionindevicearray, positioningrouparray:integer;
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

{
  // Alle Selektionen löschen
  for j:=0 to length(mainform.devices)-1 do
    mainform.DeviceSelected[j]:=false;

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

  mainform.DeviceSelectionChanged(nil);
}
  UpdateSelection
end;

procedure Tpresetsceneeditor.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  Bmp := TImage.Create(self);
end;

procedure Tpresetsceneeditor.CreateParams(var Params:TCreateParams);
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

procedure Tpresetsceneeditor.TiledImage2MouseDown(Sender: TObject;
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

procedure Tpresetsceneeditor.TiledImage2MouseMove(Sender: TObject;
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

procedure Tpresetsceneeditor.TiledImage2MouseUp(Sender: TObject;
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

procedure Tpresetsceneeditor.positionxy2MouseMove(Sender: TObject;
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

procedure Tpresetsceneeditor.Button1Click(Sender: TObject);
begin
  prismaslider.position:=127;
end;

procedure Tpresetsceneeditor.Button2Click(Sender: TObject);
begin
  goborot1slider.position:=127;
end;

procedure Tpresetsceneeditor.Button3Click(Sender: TObject);
begin
  goborot2slider.position:=127;
end;

procedure Tpresetsceneeditor.dimmersliderChange(Sender: TObject);
var
  i:integer;
  R,G,B:byte;
begin
  if dimmerslider.position<0 then
    label27.Caption:=_('Dimmer')+' aus'
  else
    label27.Caption:=_('Dimmer')+' '+floattostrf(dimmerslider.position/2.55, ffFixed, 15, 1)+'%';
  if stroboslider.position<0 then
    label29.Caption:=_('Stroboskop')+' aus'
  else
    label29.Caption:=_('Stroboskop')+' '+floattostrf(stroboslider.position/2.55, ffFixed, 15, 1)+'%';
  if irisslider.position<0 then
    label33.Caption:=_('Iris')+' aus'
  else
    label33.Caption:=_('Iris')+' '+floattostrf(irisslider.position/2.55, ffFixed, 15, 1)+'%';
  if fokusslider.position<0 then
    label37.Caption:=_('Fokus')+' aus'
  else
    label37.Caption:=_('Fokus')+' '+floattostrf(fokusslider.position/2.55, ffFixed, 15, 1)+'%';

  for i:=0 to length(SelectedDevices)-1 do
  begin
    geraetesteuerung.set_gobo1rot(SelectedDevices[i], goborot1slider.position);

    geraetesteuerung.set_gobo2rot(SelectedDevices[i], goborot2slider.position);

    geraetesteuerung.set_prismarot(SelectedDevices[i], prismaslider.position);

    if fokusslider.position>-1 then
      geraetesteuerung.set_channel(SelectedDevices[i], 'FOCUS', -1, fokusslider.position, 0);

    if irisslider.position>-1 then
      geraetesteuerung.set_iris(SelectedDevices[i], irisslider.position);

    geraetesteuerung.set_channel(SelectedDevices[i], 'PAN', -1, panval, 0);
    geraetesteuerung.set_channel(SelectedDevices[i], 'PANFINE', -1, panfineval, 0);
    geraetesteuerung.set_channel(SelectedDevices[i], 'TILT', -1, tiltval, 0);
    geraetesteuerung.set_channel(SelectedDevices[i], 'TILTFINE', -1, tiltfineval, 0);

    TColor2RGB(colorpicker2.SelectedColor, R,G,B);
    geraetesteuerung.set_color(SelectedDevices[i], R, G, B, 0, 0);

    selectedgobo:=mbXPImageComboBox1.Items[mbXPImageComboBox1.ItemIndex];
    gobolbl.caption:=selectedgobo;
    geraetesteuerung.set_gobo(SelectedDevices[i], selectedgobo);

    if shuttercheck.state=cbChecked then
    begin
      // OFFEN
      geraetesteuerung.set_shutter(SelectedDevices[i], 255);
    end else if shuttercheck.state=cbUnchecked then
    begin
      // ZU
      geraetesteuerung.set_shutter(SelectedDevices[i], 0);
    end else if shuttercheck.state=cbGrayed then
    begin
      // UNBESTIMMT
    end;

    if stroboslider.position>-1 then
      geraetesteuerung.set_strobe(SelectedDevices[i], stroboslider.position);
    if dimmerslider.position>-1 then
      geraetesteuerung.set_dimmer(SelectedDevices[i], dimmerslider.position);
{
    if UpperCase(mainform.Devices[i].StrobeChannel)='DIMMER' then
    begin
      // Strobe und Dimmer auf gleichem Kanal -> Strobe nur bei Dimmer=255
      if dimmerslider.position=255 then
        geraetesteuerung.set_strobe(SelectedDevices[i], stroboslider.position)
      else
      begin
        if UpperCase(mainform.Devices[i].ShutterChannel)='DIMMER' then
        begin
          if shuttercheck.state=cbUnchecked then
            geraetesteuerung.set_dimmer(SelectedDevices[i], 0)
          else if shuttercheck.state=cbGrayed then
            geraetesteuerung.set_dimmer(SelectedDevices[i], dimmerslider.position)
          else if shuttercheck.state=cbChecked then
            geraetesteuerung.set_dimmer(SelectedDevices[i], 255);
        end else
          geraetesteuerung.set_dimmer(SelectedDevices[i], dimmerslider.position);
      end;
    end else
    begin
      // getrennte Kanäle
      if UpperCase(mainform.Devices[i].ShutterChannel)='DIMMER' then
      begin
        if shuttercheck.state=cbUnchecked then
          geraetesteuerung.set_dimmer(SelectedDevices[i], 0)
        else if shuttercheck.state=cbGrayed then
          geraetesteuerung.set_dimmer(SelectedDevices[i], dimmerslider.position)
        else if shuttercheck.state=cbChecked then
          geraetesteuerung.set_dimmer(SelectedDevices[i], 255);
      end else
        geraetesteuerung.set_dimmer(SelectedDevices[i], dimmerslider.position);

      geraetesteuerung.set_strobe(SelectedDevices[i], stroboslider.position);
    end;
}

    if prismacheck.state=cbChecked then
      geraetesteuerung.set_prisma(SelectedDevices[i], 255)
    else if prismacheck.state=cbUnchecked then
      geraetesteuerung.set_prisma(SelectedDevices[i], 0);
  end;
end;

procedure Tpresetsceneeditor.SetPanTilt;
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

procedure Tpresetsceneeditor.FormDestroy(Sender: TObject);
begin
  Bmp.Free;
end;

procedure Tpresetsceneeditor.prismacheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dimmersliderChange(nil);
end;

procedure Tpresetsceneeditor.shuttercheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dimmersliderChange(nil);
end;

procedure Tpresetsceneeditor.TreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin
  UpdateSelection;
end;

procedure Tpresetsceneeditor.UpdateSelection;
var
  i:integer;
begin
  setlength(SelectedDevices, 0);

  // Selektierte Geräte in Preset speichern
  for i:=0 to Treeview1.SelectionCount-1 do
  begin
    if (Treeview1.Selections[i].HasChildren=false) {and Treeview1.Selections[i].Selected} then
    begin
      setlength(SelectedDevices, length(SelectedDevices)+1);
      SelectedDevices[length(SelectedDevices)-1]:=NodeGUID[Treeview1.Selections[i].Parent.Parent.Index][Treeview1.Selections[i].Parent.Index][Treeview1.Selections[i].Index];
    end;
  end;
end;

procedure Tpresetsceneeditor.FormShow(Sender: TObject);
begin
  UpdateSelection;
end;

procedure Tpresetsceneeditor.Edit3Enter(Sender: TObject);
begin
  if Edit3.text=_('Suchtext hier eingeben...') then
  begin
    Edit3.Text:='';
    Edit3.Font.Color:=clBlack;
  end;
end;

procedure Tpresetsceneeditor.Edit3Exit(Sender: TObject);
begin
  if Edit3.Text='' then
  begin
    Edit3.Text:=_('Suchtext hier eingeben...');
    Edit3.Font.Color:=clGray;
  end;
end;

procedure Tpresetsceneeditor.Edit3KeyUp(Sender: TObject; var Key: Word;
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
