unit nodecontrolfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, mbColorPickerControl, HSColorPicker,
  HexaColorPicker, HRingPicker, mbTrackBarPicker, VColorPicker,
  HSLRingPicker, XPMan, Buttons, PngBitBtn, gnugettext, dxGDIPlusClasses;

type
  TSetPoint = record
    X,Y,Z:Word;
    R,G,B,A,W,Dimmer:byte;
    UseRGB,UseA,UseW,UseDimmer:boolean;
    Name:string;
  end;

  Tnodecontrolform = class(TForm)
    RedrawTimer: TTimer;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    nodelist: TListBox;
    GroupBox2: TGroupBox;
    amberslider: TVColorPicker;
    whiteslider: TVColorPicker;
    dimmerslider: TScrollBar;
    colorpicker: THSLRingPicker;
    dimmercheckbox: TCheckBox;
    whitecheckbox: TCheckBox;
    ambercheckbox: TCheckBox;
    addbtn: TPngBitBtn;
    removebtn: TPngBitBtn;
    renamebtn: TPngBitBtn;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    narrowslider: TScrollBar;
    Label2: TLabel;
    contrastslider: TScrollBar;
    GroupBox4: TGroupBox;
    fadetimemsedit: TEdit;
    Label3: TLabel;
    rgbcheckbox: TCheckBox;
    GroupBox5: TGroupBox;
    setrgbcheckbox: TCheckBox;
    setambercheckbox: TCheckBox;
    setdimmercheckbox: TCheckBox;
    setwhitecheckbox: TCheckBox;
    Image1: TImage;
    procedure RedrawTimerTimer(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure addbtnClick(Sender: TObject);
    procedure narrowsliderChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ambersliderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure whitesliderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dimmersliderChange(Sender: TObject);
    procedure nodelistMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure removebtnClick(Sender: TObject);
    procedure colorpickerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure renamebtnClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ambercheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure whitecheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dimmercheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure rgbcheckboxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    Nodes:array of TSetPoint;
    ShadowCanvas: TBitmap;
    MouseOnNode:integer;
    RoomHeight:word;
    PleaseRecalculateDistances:boolean;
    procedure RecalculateDistances;
    procedure RefreshNodeList;
  public
    { Public declarations }
    StageviewBuffer:TBitmap;
  end;

var
  nodecontrolform: Tnodecontrolform;

implementation

uses buehnenansicht, PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Tnodecontrolform.RedrawTimerTimer(Sender: TObject);
var
  i, textposition:integer;
begin
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
  BitBlt(ShadowCanvas.Canvas.Handle, 0, 0, StageviewBuffer.width, StageviewBuffer.height, StageviewBuffer.canvas.handle, 0, 0, SrcCopy);

  for i:=0 to length(Nodes)-1 do
  begin
    if Nodes[i].UseRGB then
    begin
      ShadowCanvas.Canvas.Brush.Color:=Nodes[i].R + (Nodes[i].G shl 8) + (Nodes[i].B shl 16);
      ShadowCanvas.Canvas.Pen.Color:=Nodes[i].R + (Nodes[i].G shl 8) + (Nodes[i].B shl 16);
    end else
    begin
      ShadowCanvas.Canvas.Brush.Color:=clWhite;
      ShadowCanvas.Canvas.Pen.Color:=clWhite;
    end;
    ShadowCanvas.Canvas.Rectangle(Nodes[i].X, Nodes[i].Y, Nodes[i].X+32, Nodes[i].Y+32);
    ShadowCanvas.Canvas.Draw(Nodes[i].X, Nodes[i].Y, Image1.Picture.Graphic);

    ShadowCanvas.Canvas.Pen.Color:=clWhite;
    ShadowCanvas.Canvas.Brush.Color:=clWhite;
    textposition:=Nodes[i].Y+22;
    textposition:=textposition+10;
    ShadowCanvas.Canvas.TextOut(Nodes[i].X, textposition, Nodes[i].Name);
    if ambercheckbox.Checked then
    begin
      textposition:=textposition+10;
      ShadowCanvas.Canvas.TextOut(Nodes[i].X, textposition, _('Amber')+': '+floattostrf(Nodes[i].A/2.55, ffFixed, 3, 1)+'%');
    end;
    if whitecheckbox.Checked then
    begin
      textposition:=textposition+10;
      ShadowCanvas.Canvas.TextOut(Nodes[i].X, textposition, _('Weiß')+': '+floattostrf(Nodes[i].W/2.55, ffFixed, 3, 1)+'%');
    end;
    if Dimmercheckbox.Checked then
    begin
      textposition:=textposition+10;
      ShadowCanvas.Canvas.TextOut(Nodes[i].X, textposition, _('Dimmer')+': '+floattostrf(Nodes[i].Dimmer/2.55, ffFixed, 3, 1)+'%');
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
  if (shift=[ssLeft]) and (nodelist.ItemIndex>-1) then
  begin
    Nodes[nodelist.ItemIndex].X:=X-16;
    Nodes[nodelist.ItemIndex].Y:=Y-16;

    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.FormCreate(Sender: TObject);
begin
  Randomize;

  StageviewBuffer:=TBitmap.Create;
  StageviewBuffer.Width:=560;
  StageviewBuffer.Height:=432;

  ShadowCanvas:=TBitmap.Create;
  ShadowCanvas.Width:=Paintbox1.Width;
  ShadowCanvas.Height:=Paintbox1.Height;
  RoomHeight:=400;
end;

procedure Tnodecontrolform.addbtnClick(Sender: TObject);
begin
  setlength(Nodes, length(Nodes)+1);
  Nodes[length(Nodes)-1].Name:=_('Neuer Knoten')+' '+inttostr(length(Nodes));
  Nodes[length(Nodes)-1].UseRGB:=true;
  nodelist.Items.add(Nodes[length(Nodes)-1].Name);
  nodelist.itemindex:=nodelist.items.count-1;
  RefreshNodeList;
  PleaseRecalculateDistances:=true;
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

        for k:=0 to length(Nodes)-1 do
        begin
          dX:=abs(Nodes[k].X-mainform.devices[i].left[j]);
          dY:=abs(Nodes[k].Y-mainform.devices[i].top[j]);
          //dZ:=abs(Nodes[k].Z-mainform.devices[i].zaxis[j]);
          d2d:=sqrt(dX*dX+dY*dY);
          //d3d:=sqrt(dX*dX+dY*dY+dZ*dZ);
          factor:=((dMax2d-d2d)/dMax2d);

          Rj:=(factor*Nodes[k].R-narrow)*narrowcorrection*contrast;
          Gj:=(factor*Nodes[k].G-narrow)*narrowcorrection*contrast;
          Bj:=(factor*Nodes[k].B-narrow)*narrowcorrection*contrast;
          R:=R+Saturate(Rj,0,255);
          G:=G+Saturate(Gj,0,255);
          B:=B+Saturate(Bj,0,255);

          if Nodes[k].UseA then
          begin
            Aj:=(factor*Nodes[k].A-narrow)*narrowcorrection*contrast;
            A:=A+Saturate(Aj,0,255);
          end;

          if Nodes[k].UseW then
          begin
            Wj:=(factor*Nodes[k].W-narrow)*narrowcorrection*contrast;
            W:=W+Saturate(Wj,0,255);
          end;

          if Nodes[k].UseDimmer then
          begin
            Dimmerj:=(factor*Nodes[k].Dimmer-narrow)*narrowcorrection*contrast;
            Dimmer:=Dimmer+Saturate(Dimmerj,0,255);
          end;
        end;

        if setrgbcheckbox.Checked then geraetesteuerung.set_color(mainform.devices[i].ID, round(Saturate(R,0,255)), round(Saturate(G,0,255)), round(Saturate(B,0,255)), strtoint(fadetimemsedit.text), 0);
        if setambercheckbox.Checked then geraetesteuerung.set_channel(mainform.devices[i].ID, 'A', -1, round(Saturate(A,0,255)), strtoint(fadetimemsedit.text), 0);
        if setwhitecheckbox.Checked then geraetesteuerung.set_channel(mainform.devices[i].ID, 'W', -1, round(Saturate(W,0,255)), strtoint(fadetimemsedit.text), 0);
        if setdimmercheckbox.Checked then geraetesteuerung.set_channel(mainform.devices[i].ID, 'Dimmer', -1, round(Saturate(Dimmer,0,255)), strtoint(fadetimemsedit.text), 0);
      end;
    end;
  end;
end;

procedure Tnodecontrolform.narrowsliderChange(Sender: TObject);
begin
  PleaseRecalculateDistances:=true;
end;

procedure Tnodecontrolform.FormShow(Sender: TObject);
begin
  RedrawTimer.Enabled:=true;
  amberslider.SelectedColor:=$0005A9FA;
  amberslider.Value:=0;
end;

procedure Tnodecontrolform.FormHide(Sender: TObject);
begin
  RedrawTimer.Enabled:=false;
end;

procedure Tnodecontrolform.ambersliderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].A:=amberslider.Value;
    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.whitesliderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].W:=whiteslider.Value;
    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.dimmersliderChange(Sender: TObject);
begin
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].Dimmer:=dimmerslider.position;
    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.nodelistMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    colorpicker.SelectedColor:=Nodes[nodelist.itemindex].R + (Nodes[nodelist.itemindex].G shl 16) + (Nodes[nodelist.itemindex].B shl 16);
    amberslider.value:=Nodes[nodelist.itemindex].A;
    whiteslider.value:=Nodes[nodelist.itemindex].W;
    dimmerslider.position:=Nodes[nodelist.itemindex].Dimmer;

    rgbcheckbox.Checked:=Nodes[nodelist.itemindex].UseRGB;
    ambercheckbox.Checked:=Nodes[nodelist.itemindex].UseA;
    whitecheckbox.Checked:=Nodes[nodelist.itemindex].UseW;
    dimmercheckbox.Checked:=Nodes[nodelist.itemindex].UseDimmer;
  end;
end;

procedure Tnodecontrolform.removebtnClick(Sender: TObject);
var
  i:integer;
begin
  if nodelist.itemindex>-1 then
  begin
    for i:=nodelist.ItemIndex to length(Nodes)-2 do
    begin
      Nodes[i].X:=Nodes[i+1].X;
      Nodes[i].Y:=Nodes[i+1].Y;
      Nodes[i].R:=Nodes[i+1].R;
      Nodes[i].G:=Nodes[i+1].G;
      Nodes[i].B:=Nodes[i+1].B;
      Nodes[i].A:=Nodes[i+1].A;
      Nodes[i].W:=Nodes[i+1].W;
      Nodes[i].Dimmer:=Nodes[i+1].Dimmer;
      Nodes[i].Name:=Nodes[i+1].Name;
    end;
    setlength(Nodes, length(Nodes)-1);
    RefreshNodeList;
  end;
  PleaseRecalculateDistances:=true;
end;

procedure Tnodecontrolform.RefreshNodeList;
var
  i, LastIndex:integer;
begin
  LastIndex:=nodelist.itemindex;

  nodelist.Items.Clear;
  for i:=0 to length(Nodes)-1 do
  begin
    nodelist.items.add(Nodes[i].Name);
  end;

  if LastIndex=-1 then
    nodelist.itemindex:=nodelist.Items.count-1
  else
    nodelist.itemindex:=LastIndex;
end;

procedure Tnodecontrolform.colorpickerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Shift=[ssLeft]) and (nodelist.ItemIndex>-1) then
  begin
    Nodes[nodelist.itemindex].R:=colorpicker.SelectedColor;
    Nodes[nodelist.itemindex].G:=colorpicker.SelectedColor shr 8;
    Nodes[nodelist.itemindex].B:=colorpicker.SelectedColor shr 16;

    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.renamebtnClick(Sender: TObject);
begin
  if nodelist.itemindex>-1 then
  begin
    Nodes[nodelist.itemindex].Name:=InputBox(_('Neue Bezeichnung'), _('Bitte geben Sie eine neue Bezeichnung für diesen Knoten ein...'), Nodes[nodelist.itemindex].Name);
    RefreshNodeList;
  end;
end;

procedure Tnodecontrolform.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=0 to length(Nodes)-1 do
  begin
    if (X>Nodes[i].X) and (X<Nodes[i].X+32) and (Y>Nodes[i].Y) and (Y<Nodes[i].Y+32) then
    begin
      MouseOnNode:=i;
      if (MouseOnNode>-1) and (nodelist.items.count>0) and (MouseOnNode<nodelist.Items.count) then
      begin
        nodelist.itemindex:=MouseOnNode;
      end;
      break;
    end;
  end;
end;

procedure Tnodecontrolform.ambercheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].UseA:=ambercheckbox.checked;
    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.whitecheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].UseW:=whitecheckbox.checked;
    PleaseRecalculateDistances:=true;
  end;
end;

procedure Tnodecontrolform.dimmercheckboxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].UseDimmer:=dimmercheckbox.checked;
    PleaseRecalculateDistances:=true;
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
  if nodelist.ItemIndex>-1 then
  begin
    Nodes[nodelist.itemindex].UseRGB:=rgbcheckbox.checked;
    PleaseRecalculateDistances:=true;
  end;
end;

end.
