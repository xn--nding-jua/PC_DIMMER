unit nodecontrolfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, mbColorPickerControl, HSColorPicker,
  HexaColorPicker, HRingPicker, mbTrackBarPicker, VColorPicker,
  HSLRingPicker, XPMan, Buttons, PngBitBtn, gnugettext, dxGDIPlusClasses,
  Registry, Mask, JvExMask, JvSpin, HColorPicker, LColorPicker, pngimage,
  pcdUtils;

type
  Tnodecontrolform = class(TForm)
    RedrawTimer: TTimer;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    nodelist: TListBox;
    addbtn: TPngBitBtn;
    removebtn: TPngBitBtn;
    renamebtn: TPngBitBtn;
    Panel3: TPanel;
    Image1: TImage;
    addnodecontrolsetsbtn: TPngBitBtn;
    removenodecontrolsetsbtn: TPngBitBtn;
    editnodecontrolsetsbtn: TPngBitBtn;
    nodecontrolsetscombobox: TComboBox;
    GroupBox2: TGroupBox;
    amberslider: TVColorPicker;
    whiteslider: TVColorPicker;
    dimmerslider: TScrollBar;
    dimmercheckbox: TCheckBox;
    whitecheckbox: TCheckBox;
    ambercheckbox: TCheckBox;
    rgbcheckbox: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    narrowslider: TScrollBar;
    contrastslider: TScrollBar;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    fadetimemsedit: TJvSpinEdit;
    colorpicker: THSLRingPicker;
    Label6: TLabel;
    scalebox: TComboBox;
    setrgbcheckbox: TCheckBox;
    setambercheckbox: TCheckBox;
    setdimmercheckbox: TCheckBox;
    setwhitecheckbox: TCheckBox;
    procedure RedrawTimerTimer(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure addbtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure dimmersliderChange(Sender: TObject);
    procedure nodelistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure removebtnClick(Sender: TObject);
    procedure renamebtnClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure rgbcheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure nodecontrolsetscomboboxChange(Sender: TObject);
    procedure addnodecontrolsetsbtnClick(Sender: TObject);
    procedure removenodecontrolsetsbtnClick(Sender: TObject);
    procedure editnodecontrolsetsbtnClick(Sender: TObject);
    procedure nodelistClick(Sender: TObject);
    procedure nodelistKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure colorpickerMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure scaleboxChange(Sender: TObject);
    procedure setrgbcheckboxClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ShadowCanvas: TBitmap;
    MouseOnNode:integer;
    RoomHeight:word;
    StageViewScaling:double;
    PNGImage:TPNGObject;

    CurrentMousePositionX, CurrentMousePositionY:integer;
    CurrentMouseMoveShiftState:TShiftState;
    HandleMouseMove:boolean;

    procedure RecalculateDistances;
    procedure RefreshNodeList;
  public
    { Public declarations }
    StageviewBuffer:TBitmap;
    PleaseRecalculateDistances:boolean;
    procedure MSGSave;
    procedure MSGOpen;
    procedure MSGNew;
    procedure CheckButtons;
    procedure GUItoNodesets;
    procedure GUItoNode;
  end;

var
  nodecontrolform: Tnodecontrolform;

implementation

uses buehnenansicht, PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Tnodecontrolform.RedrawTimerTimer(Sender: TObject);
var
  i, textposition:integer;
  X,Y:integer;
  Shift:TShiftState;
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
    exit;

  if HandleMouseMove then
  begin
    X:=CurrentMousePositionX;
    Y:=CurrentMousePositionY;
    Shift:=CurrentMouseMoveShiftState;

    HandleMouseMove:=false;

    if (shift=[ssLeft]) and (nodelist.ItemIndex>-1) then
    begin
      if X<0 then
        mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.ItemIndex].X:=0
      else if X>(Paintbox1.Width) then
        mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.ItemIndex].X:=Paintbox1.Width
      else
        mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.ItemIndex].X:=X;

      if Y<0 then
        mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.ItemIndex].Y:=0
      else if Y>(Paintbox1.Height) then
        mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.ItemIndex].Y:=Paintbox1.Height
      else
        mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.ItemIndex].Y:=Y;

      PleaseRecalculateDistances:=true;
    end;
  end;

  if not grafischebuehnenansicht.RefreshTimer.Enabled then
  begin
    grafischebuehnenansicht.RefreshTimerTimer(nil);
  end;

  ShadowCanvas.Canvas.Font.Name:='Calibri';
  ShadowCanvas.Canvas.Font.Size:=7;

  ShadowCanvas.Canvas.Brush.Style:=bsSolid;
  ShadowCanvas.Canvas.Brush.Color:=clWhite;
  ShadowCanvas.Canvas.Pen.Style:=psSolid;
  ShadowCanvas.Canvas.Pen.Color:=clWhite;

  ShadowCanvas.Canvas.Rectangle(0, 0, ShadowCanvas.Width, ShadowCanvas.Height);

  // grafische Bühnenansicht kopieren
  // BitBlt will not scale
  //  BitBlt(ShadowCanvas.Canvas.Handle, 0, 0, StageviewBuffer.width, StageviewBuffer.height, StageviewBuffer.canvas.handle, 0, 0, SrcCopy);
  // StretchBlt is around 160x slower than BitBlt since Windows 7. So we have to use a different solution
  //  StretchBlt(ShadowCanvas.Canvas.Handle, 0, 0, round(StageviewBuffer.width/StageViewScaling), round(StageviewBuffer.height/StageViewScaling), StageviewBuffer.canvas.handle, 0, 0, StageviewBuffer.Width, StageviewBuffer.Height, SrcCopy);
  // Use TPNGObject to scale

  PNGImage.Assign(StageviewBuffer);
  if (StageViewScaling>1) then
    SmoothResize(PNGImage, round(StageviewBuffer.width/StageViewScaling), round(StageviewBuffer.height/StageViewScaling));
  BitBlt(ShadowCanvas.Canvas.Handle, 0, 0, round(StageviewBuffer.width/StageViewScaling), round(StageviewBuffer.height/StageViewScaling), PNGImage.canvas.handle, 0, 0, SrcCopy);

  for i:=0 to length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1 do
  begin
    X:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].X-16;
    Y:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Y-16;

    if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].UseRGB then
    begin
      ShadowCanvas.Canvas.Brush.Color:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].R + (mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].G shl 8) + (mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].B shl 16);
      ShadowCanvas.Canvas.Pen.Color:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].R + (mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].G shl 8) + (mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].B shl 16);
    end else
    begin
      ShadowCanvas.Canvas.Brush.Color:=clWhite;
      ShadowCanvas.Canvas.Pen.Color:=clWhite;
    end;
    ShadowCanvas.Canvas.Rectangle(X, Y, X+32, Y+32);
    ShadowCanvas.Canvas.Draw(X, Y, Image1.Picture.Graphic);

    ShadowCanvas.Canvas.Pen.Color:=clWhite;
    ShadowCanvas.Canvas.Brush.Color:=clWhite;
    textposition:=Y+22;
    textposition:=textposition+10;
    ShadowCanvas.Canvas.TextOut(X, textposition, mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Name);
    if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].UseA then
    begin
      textposition:=textposition+10;
      ShadowCanvas.Canvas.TextOut(X, textposition, _('Amber')+': '+floattostrf(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].A/2.55, ffFixed, 3, 1)+'%');
    end;
    if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].UseW then
    begin
      textposition:=textposition+10;
      ShadowCanvas.Canvas.TextOut(X, textposition, _('Weiß')+': '+floattostrf(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].W/2.55, ffFixed, 3, 1)+'%');
    end;
    if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].UseDimmer then
    begin
      textposition:=textposition+10;
      ShadowCanvas.Canvas.TextOut(X, textposition, _('Dimmer')+': '+floattostrf(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Dimmer/2.55, ffFixed, 3, 1)+'%');
    end;
  end;

  BitBlt(Paintbox1.Canvas.Handle, 0, 0, ShadowCanvas.Width, ShadowCanvas.Height, ShadowCanvas.Canvas.Handle, 0, 0, SrcCopy);

  if PleaseRecalculateDistances then
  begin
    PleaseRecalculateDistances:=false;
    RecalculateDistances;
  end;
end;

procedure Tnodecontrolform.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  CurrentMousePositionX:=X;
  CurrentMousePositionY:=Y;
  CurrentMouseMoveShiftState:=Shift;
  HandleMouseMove:=true;
end;

procedure Tnodecontrolform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  PNGImage:=TPNGObject.Create;

  Randomize;

  StageviewBuffer:=TBitmap.Create;
  StageviewBuffer.Width:=560;
  StageviewBuffer.Height:=432;

  StageViewScaling:=1;

  ShadowCanvas:=TBitmap.Create;
  ShadowCanvas.Width:=Paintbox1.Width;
  ShadowCanvas.Height:=Paintbox1.Height;
  RoomHeight:=400;
end;

procedure Tnodecontrolform.addbtnClick(Sender: TObject);
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
    exit;

  setlength(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes, length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)+1);
  CreateGUID(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1].ID);
  mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1].Name:=_('Neuer Knoten')+' '+inttostr(length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes));
  mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1].UseRGB:=true;
  mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1].X:=16;
  mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1].Y:=16;
  nodelist.Items.add(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1].Name);
  nodelist.itemindex:=nodelist.items.count-1;
  RefreshNodeList;
  PleaseRecalculateDistances:=true;
  CheckButtons;
end;

procedure Tnodecontrolform.RecalculateDistances;
  function Saturate(Input, Min, Max: double):double;
  begin
    if Input>Max then
      result:=Max
    else if Input<Min then
      result:=Min
    else
      result:=Input;
  end;
var
  i, j, k:integer;
  factor, dX, dY,dZ, d2d,d3d, dMax2d,dMax3d, narrow, narrowcorrection, contrast:double;
  R,G,B,A,W,Dimmer,Rj,Gj,Bj,Aj,Wj,Dimmerj:double;
begin
  narrow:=(254000-narrowslider.Position)/1000;
  contrast:=contrastslider.position/10;
  narrowcorrection:=255/(255-narrow);
  dMax2d:=sqrt(ShadowCanvas.Width*ShadowCanvas.Width+ShadowCanvas.Height*ShadowCanvas.Height);
  dMax3d:=sqrt(ShadowCanvas.Width*ShadowCanvas.Width+ShadowCanvas.Height*ShadowCanvas.Height+RoomHeight*RoomHeight);

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.devices[i].ShowInStageview then
    begin
      for j:=0 to length(mainform.devices[i].top)-1 do
      begin
        if mainform.devices[i].bank[j]<>grafischebuehnenansicht.bankselect.itemindex then continue;

        R:=0;
        G:=0;
        B:=0;
        A:=0;
        W:=0;
        Dimmer:=0;

        for k:=0 to length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1 do
        begin
          dX:=abs(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].X*StageViewScaling-mainform.devices[i].left[j]);
          dY:=abs(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].Y*StageViewScaling-mainform.devices[i].top[j]);
          //dZ:=abs(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].Z-mainform.devices[i].zaxis[j]);
          d2d:=sqrt(dX*dX+dY*dY);
          //d3d:=sqrt(dX*dX+dY*dY+dZ*dZ);
          factor:=((dMax2d-d2d)/dMax2d);

          Rj:=(factor*mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].R-narrow)*narrowcorrection*contrast;
          Gj:=(factor*mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].G-narrow)*narrowcorrection*contrast;
          Bj:=(factor*mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].B-narrow)*narrowcorrection*contrast;
          R:=R+Saturate(Rj,0,255);
          G:=G+Saturate(Gj,0,255);
          B:=B+Saturate(Bj,0,255);

          if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].UseA then
          begin
            Aj:=(factor*mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].A-narrow)*narrowcorrection*contrast;
            A:=A+Saturate(Aj,0,255);
          end;

          if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].UseW then
          begin
            Wj:=(factor*mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].W-narrow)*narrowcorrection*contrast;
            W:=W+Saturate(Wj,0,255);
          end;

          if mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].UseDimmer then
          begin
            Dimmerj:=(factor*mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[k].Dimmer-narrow)*narrowcorrection*contrast;
            Dimmer:=Dimmer+Saturate(Dimmerj,0,255);
          end;
        end;

        if setrgbcheckbox.Checked then geraetesteuerung.set_color(mainform.devices[i].ID, round(Saturate(R,0,255)), round(Saturate(G,0,255)), round(Saturate(B,0,255)), round(fadetimemsedit.value), 0);
        if setambercheckbox.Checked then geraetesteuerung.set_channel(mainform.devices[i].ID, 'A', -1, round(Saturate(A,0,255)), round(fadetimemsedit.value), 0);
        if setwhitecheckbox.Checked then geraetesteuerung.set_channel(mainform.devices[i].ID, 'W', -1, round(Saturate(W,0,255)), round(fadetimemsedit.value), 0);
        if setdimmercheckbox.Checked then geraetesteuerung.set_channel(mainform.devices[i].ID, 'Dimmer', -1, round(Saturate(Dimmer,0,255)), round(fadetimemsedit.value), 0);
      end;
    end;
  end;
end;

procedure Tnodecontrolform.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
  			LReg.WriteBool('Showing NodeControl',true);

        if not LReg.KeyExists('NodeControl') then
	        LReg.CreateKey('NodeControl');
	      if LReg.OpenKey('NodeControl',true) then
	      begin
          if LReg.ValueExists('Width') then
            nodecontrolform.ClientWidth:=LReg.ReadInteger('Width')
          else
            nodecontrolform.ClientWidth:=761;
          if LReg.ValueExists('Heigth') then
            nodecontrolform.ClientHeight:=LReg.ReadInteger('Heigth')
          else
            nodecontrolform.ClientHeight:=546;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+nodecontrolform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              nodecontrolform.Left:=LReg.ReadInteger('PosX')
            else
              nodecontrolform.Left:=0;
          end else
            nodecontrolform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+nodecontrolform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              nodecontrolform.Top:=LReg.ReadInteger('PosY')
            else
              nodecontrolform.Top:=0;
          end else
            nodecontrolform.Top:=0;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;


  RedrawTimer.Enabled:=true;
  amberslider.SelectedColor:=$0005A9FA;
  amberslider.Value:=0;
  CheckButtons;
end;

procedure Tnodecontrolform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  RedrawTimer.Enabled:=false;

	if not mainform.shutdown then
  begin
	  LReg := TRegistry.Create;
	  LReg.RootKey:=HKEY_CURRENT_USER;

	  if LReg.OpenKey('Software', True) then
	  begin
	    if not LReg.KeyExists('PHOENIXstudios') then
	      LReg.CreateKey('PHOENIXstudios');
	    if LReg.OpenKey('PHOENIXstudios',true) then
	    begin
	      if not LReg.KeyExists('PC_DIMMER') then
	        LReg.CreateKey('PC_DIMMER');
	      if LReg.OpenKey('PC_DIMMER',true) then
	      begin
					LReg.WriteBool('Showing NodeControl',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('nodecontrol');
end;

procedure Tnodecontrolform.dimmersliderChange(Sender: TObject);
begin
  GUItoNodesets;
  GUItoNode;
end;

procedure Tnodecontrolform.nodelistMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    colorpicker.SelectedColor:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].R + (mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].G shl 8) + (mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].B shl 16);
    amberslider.value:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].A;
    whiteslider.value:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].W;
    dimmerslider.position:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].Dimmer;

    rgbcheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseRGB;
    ambercheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseA;
    whitecheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseW;
    dimmercheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseDimmer;
  end;
end;

procedure Tnodecontrolform.removebtnClick(Sender: TObject);
var
  i:integer;
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
    exit;

  if nodelist.itemindex>-1 then
  begin
    for i:=nodelist.ItemIndex to length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-2 do
    begin
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].ID:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].ID;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Name:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].Name;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].X:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].X;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Y:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].Y;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].R:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].R;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].G:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].G;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].B:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].B;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].A:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].A;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].W:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].W;
      mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Dimmer:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i+1].Dimmer;
    end;
    setlength(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes, length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1);
    RefreshNodeList;
  end;
  PleaseRecalculateDistances:=true;
  CheckButtons;
end;

procedure Tnodecontrolform.RefreshNodeList;
var
  i, LastIndex:integer;
begin
  LastIndex:=nodelist.itemindex;

  nodelist.Items.Clear;
  for i:=0 to length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1 do
  begin
    nodelist.items.add(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Name);
  end;

  if LastIndex=-1 then
    nodelist.itemindex:=nodelist.Items.count-1
  else
    nodelist.itemindex:=LastIndex;
end;

procedure Tnodecontrolform.renamebtnClick(Sender: TObject);
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
    exit;

  if nodelist.itemindex>-1 then
  begin
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].Name:=InputBox(_('Neue Bezeichnung'), _('Bitte geben Sie eine neue Bezeichnung für diesen Knoten ein...'), mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].Name);
    RefreshNodeList;
  end;
end;

procedure Tnodecontrolform.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
    exit;

  for i:=0 to length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1 do
  begin
    if (X>mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].X-16) and
      (X<mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].X+16) and
      (Y>mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Y-16) and
      (Y<mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Y+16) then
    begin
      MouseOnNode:=i;
      if (MouseOnNode>-1) and (nodelist.items.count>0) and (MouseOnNode<nodelist.Items.count) then
      begin
        nodelist.itemindex:=MouseOnNode;
        nodelistMouseUp(nodelist, mbLeft, [ssLeft], 0, 0);
        nodelistClick(nodelist);
      end;
      break;
    end;
  end;
end;

procedure Tnodecontrolform.FormResize(Sender: TObject);
begin
  ShadowCanvas.Width:=Paintbox1.Width;
  ShadowCanvas.Height:=Paintbox1.Height;
end;

procedure Tnodecontrolform.rgbcheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  GUItoNode;
end;

procedure Tnodecontrolform.CreateParams(var Params:TCreateParams);
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

procedure Tnodecontrolform.MSGSave;
begin
  CheckButtons;
end;

procedure Tnodecontrolform.MSGOpen;
var
  i:integer;
begin
  nodecontrolsetscombobox.Items.Clear;
  nodelist.Items.Clear;
  
  for i:=0 to length(mainform.NodeControlSets)-1 do
  begin
    nodecontrolsetscombobox.Items.Add(mainform.NodeControlSets[i].Name);
  end;
  nodecontrolsetscombobox.Itemindex:=0;
  nodecontrolsetscomboboxchange(nil);
  
  CheckButtons;
end;

procedure Tnodecontrolform.MSGNew;
begin
  setlength(mainform.NodeControlSets, 0);
  setlength(mainform.NodeControlSets, 1);
  CreateGUID(mainform.NodeControlSets[0].ID);
  mainform.NodeControlSets[0].Name:=_('Neue Knotensteuerung');
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].stretching:=128000;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].contrast:=20;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].fadetime:=75;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].ChangeRGB:=true;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].StageViewScaling:=5;
  setlength(mainform.NodeControlSets[0].NodeControlNodes, 0);

  MSGOpen;
end;

procedure Tnodecontrolform.nodecontrolsetscomboboxChange(Sender: TObject);
var
  i:integer;
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
  begin
    nodelist.Items.clear;
    CheckButtons;
    exit;
  end;

  nodelist.items.clear;
  for i:=0 to length(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes)-1 do
  begin
    nodelist.items.add(mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[i].Name);
  end;
  nodelist.itemindex:=0;
  CheckButtons;
  PleaseRecalculateDistances:=true;
end;

procedure Tnodecontrolform.addnodecontrolsetsbtnClick(Sender: TObject);
begin
  setlength(mainform.NodeControlSets, length(mainform.NodeControlSets)+1);
  CreateGUID(mainform.NodeControlSets[length(mainform.NodeControlSets)-1].ID);
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].Name:=_('Neue Knotensteuerung');
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].stretching:=128000;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].contrast:=20;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].fadetime:=75;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].ChangeRGB:=true;
  mainform.NodeControlSets[length(mainform.NodeControlSets)-1].StageViewScaling:=5;
  nodecontrolsetscombobox.itemindex:=nodecontrolsetscombobox.Items.add(mainform.NodeControlSets[length(mainform.NodeControlSets)-1].Name);
  nodecontrolsetscomboboxChange(nil);
end;

procedure Tnodecontrolform.removenodecontrolsetsbtnClick(Sender: TObject);
var
  i, j, oldindex:integer;
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.ItemIndex=-1) then
    exit;

  for i:=nodecontrolsetscombobox.ItemIndex to length(mainform.NodeControlSets)-2 do
  begin
    mainform.NodeControlSets[i].ID:=mainform.NodeControlSets[i+1].ID;
    mainform.NodeControlSets[i].Name:=mainform.NodeControlSets[i+1].Name;

    setlength(mainform.NodeControlSets[i].NodeControlNodes, length(mainform.NodeControlSets[i+1].NodeControlNodes));
    for j:=0 to length(mainform.NodeControlSets[i].NodeControlNodes)-1 do
    begin
      mainform.NodeControlSets[i].NodeControlNodes[j].ID:=mainform.NodeControlSets[i+1].NodeControlNodes[j].ID;
      mainform.NodeControlSets[i].NodeControlNodes[j].Name:=mainform.NodeControlSets[i+1].NodeControlNodes[j].Name;
      mainform.NodeControlSets[i].NodeControlNodes[j].X:=mainform.NodeControlSets[i+1].NodeControlNodes[j].X;
      mainform.NodeControlSets[i].NodeControlNodes[j].Y:=mainform.NodeControlSets[i+1].NodeControlNodes[j].Y;
      mainform.NodeControlSets[i].NodeControlNodes[j].Z:=mainform.NodeControlSets[i+1].NodeControlNodes[j].Z;
      mainform.NodeControlSets[i].NodeControlNodes[j].R:=mainform.NodeControlSets[i+1].NodeControlNodes[j].R;
      mainform.NodeControlSets[i].NodeControlNodes[j].G:=mainform.NodeControlSets[i+1].NodeControlNodes[j].G;
      mainform.NodeControlSets[i].NodeControlNodes[j].B:=mainform.NodeControlSets[i+1].NodeControlNodes[j].B;
      mainform.NodeControlSets[i].NodeControlNodes[j].A:=mainform.NodeControlSets[i+1].NodeControlNodes[j].A;
      mainform.NodeControlSets[i].NodeControlNodes[j].W:=mainform.NodeControlSets[i+1].NodeControlNodes[j].W;
      mainform.NodeControlSets[i].NodeControlNodes[j].Dimmer:=mainform.NodeControlSets[i+1].NodeControlNodes[j].Dimmer;
      mainform.NodeControlSets[i].NodeControlNodes[j].UseRGB:=mainform.NodeControlSets[i+1].NodeControlNodes[j].UseRGB;
      mainform.NodeControlSets[i].NodeControlNodes[j].UseA:=mainform.NodeControlSets[i+1].NodeControlNodes[j].UseA;
      mainform.NodeControlSets[i].NodeControlNodes[j].UseW:=mainform.NodeControlSets[i+1].NodeControlNodes[j].UseW;
      mainform.NodeControlSets[i].NodeControlNodes[j].UseDimmer:=mainform.NodeControlSets[i+1].NodeControlNodes[j].USeDimmer;
    end;
  end;
  setlength(mainform.NodeControlSets, length(mainform.NodeControlSets)-1);
  oldindex:=nodecontrolsetscombobox.itemindex;
  nodecontrolsetscombobox.Items.Delete(nodecontrolsetscombobox.itemindex);
  if oldindex<nodecontrolsetscombobox.Items.count-1 then
    nodecontrolsetscombobox.itemindex:=oldindex
  else
    nodecontrolsetscombobox.itemindex:=nodecontrolsetscombobox.items.count-1;

  nodecontrolsetscomboboxChange(nil);

  CheckButtons;
end;

procedure Tnodecontrolform.editnodecontrolsetsbtnClick(Sender: TObject);
var
  oldindex:integer;
begin
  if (length(mainform.NodeControlSets)=0) or (nodecontrolsetscombobox.itemindex=-1) or
    (nodecontrolsetscombobox.itemindex>=length(mainform.NodeControlSets)) then
    exit;

  if nodecontrolsetscombobox.itemindex>-1 then
  begin
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].Name:=InputBox(_('Neue Bezeichnung'), _('Bitte geben Sie eine neue Bezeichnung ein...'), mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].Name);
    oldindex:=nodecontrolsetscombobox.itemindex;
    nodecontrolsetscombobox.Items[nodecontrolsetscombobox.itemindex]:=mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].Name;
    nodecontrolsetscombobox.itemindex:=oldindex;
    nodecontrolsetscomboboxChange(nil);
  end;
end;

procedure Tnodecontrolform.CheckButtons;
begin
  if (nodecontrolsetscombobox.ItemIndex>=0) and (nodecontrolsetscombobox.ItemIndex<length(mainform.NodeControlSets)) then
  begin
    narrowslider.position:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].stretching;
    contrastslider.position:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].contrast;
    fadetimemsedit.value:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].fadetime;

    setrgbcheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].ChangeRGB;
    setambercheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].ChangeA;
    setwhitecheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].ChangeW;
    setdimmercheckbox.Checked:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].ChangeDimmer;
    scalebox.ItemIndex:=mainform.NodeControlSets[nodecontrolsetscombobox.ItemIndex].StageViewScaling;
    scaleboxChange(nil);
  end;

  removenodecontrolsetsbtn.Enabled:=nodecontrolsetscombobox.ItemIndex>=0;
  editnodecontrolsetsbtn.Enabled:=removenodecontrolsetsbtn.Enabled;
  nodelist.Enabled:=removenodecontrolsetsbtn.Enabled;
  addbtn.Enabled:=removenodecontrolsetsbtn.Enabled;

  removebtn.Enabled:=nodelist.ItemIndex>=0;
  renamebtn.Enabled:=removebtn.Enabled;
  Groupbox2.visible:=removebtn.Enabled;
end;

procedure Tnodecontrolform.nodelistClick(Sender: TObject);
begin
  CheckButtons;
end;

procedure Tnodecontrolform.nodelistKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  nodelistMouseUp(nil, mbLeft, [ssLeft], 0, 0);
end;

procedure Tnodecontrolform.colorpickerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    GUItoNodesets;
    GUItoNode;
  end;
end;

procedure Tnodecontrolform.scaleboxChange(Sender: TObject);
begin
  case scalebox.itemindex of
    0: StageViewScaling:=1;
    1: StageViewScaling:=1/0.9;
    2: StageViewScaling:=1/0.8;
    3: StageViewScaling:=1/0.7;
    4: StageViewScaling:=1/0.6;
    5: StageViewScaling:=1/0.5;
    6: StageViewScaling:=1/0.4;
    7: StageViewScaling:=1/0.3;
    8: StageViewScaling:=1/0.2;
  end;

  if (length(mainform.NodeControlSets)>0) and (nodecontrolsetscombobox.itemindex>-1) and
    (nodecontrolsetscombobox.itemindex<length(mainform.NodeControlSets)) then
  begin
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].StageViewScaling:=scalebox.itemindex;
  end;

  PleaseRecalculateDistances:=true;
end;

procedure Tnodecontrolform.setrgbcheckboxClick(Sender: TObject);
begin
  GUItoNodesets;
end;

procedure Tnodecontrolform.GUItoNodesets;
begin
  if  (length(mainform.NodeControlSets)>0) and (nodecontrolsetscombobox.itemindex>-1) and
    (nodecontrolsetscombobox.itemindex<length(mainform.NodeControlSets)) then
  begin
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].stretching:=narrowslider.Position;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].contrast:=contrastslider.Position;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].fadetime:=round(fadetimemsedit.value);

    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].ChangeRGB:=setrgbcheckbox.Checked;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].ChangeA:=setambercheckbox.Checked;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].ChangeW:=setwhitecheckbox.Checked;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].ChangeDimmer:=setdimmercheckbox.Checked;

    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.GUItoNode;
begin
  if  (length(mainform.NodeControlSets)>0) and (nodecontrolsetscombobox.itemindex>-1) and
    (nodecontrolsetscombobox.itemindex<length(mainform.NodeControlSets)) and (nodelist.itemindex>-1) then
  begin
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].R:=colorpicker.SelectedColor;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].G:=colorpicker.SelectedColor shr 8;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].B:=colorpicker.SelectedColor shr 16;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].A:=amberslider.Value;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].W:=whiteslider.Value;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].Dimmer:=dimmerslider.position;

    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseRGB:=rgbcheckbox.checked;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseA:=ambercheckbox.checked;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseW:=whitecheckbox.checked;
    mainform.NodeControlSets[nodecontrolsetscombobox.itemindex].NodeControlNodes[nodelist.itemindex].UseDimmer:=dimmercheckbox.checked;

    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.FormDestroy(Sender: TObject);
begin
  PNGImage.Free;
end;

end.
