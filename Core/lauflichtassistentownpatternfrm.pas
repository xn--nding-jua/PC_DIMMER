unit lauflichtassistentownpatternfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TiledImage, StdCtrls, Mask, JvExMask, JvSpin, GR32,
  ComCtrls, mbColorPickerControl, HSColorPicker, XPMan, GnuGetText, Menus,
  HSLColorPicker, JvExExtCtrls, JvExtComponent, JvPanel, JvOfficeColorPanel,
  HSLRingPicker;

type
  Tlauflichtassistentownpatternform = class(TForm)
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    rowcount: TJvSpinEdit;
    drawtimer: TTimer;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    devicename: TLabel;
    Label6: TLabel;
    deviceaddress: TLabel;
    Label8: TLabel;
    hasrgb: TLabel;
    Label10: TLabel;
    hasdimmer: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    channeltype: TComboBox;
    delayedit: TJvSpinEdit;
    fadetimeedit: TJvSpinEdit;
    Label3: TLabel;
    Label2: TLabel;
    dimmerslider: TTrackBar;
    useonlyrgb: TCheckBox;
    chanactive: TCheckBox;
    Panel3: TPanel;
    okbtn: TButton;
    PopupMenu1: TPopupMenu;
    AlleKanleaufRGBschalten1: TMenuItem;
    AlleKanleaufNormalschalten1: TMenuItem;
    AlleKanleBlackout1: TMenuItem;
    AlleKanledeaktivieren1: TMenuItem;
    AlleKanleaktivieren1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    AlleFadezeitenzurcksetzen1: TMenuItem;
    AlleDelayzeitenzurcksetzen1: TMenuItem;
    Label7: TLabel;
    Label9: TLabel;
    previewtodevices: TCheckBox;
    Panel4: TPanel;
    PaintBox2: TPaintBox;
    Panel5: TPanel;
    Label11: TLabel;
    hedit: TEdit;
    minedit: TEdit;
    sedit: TEdit;
    msedit: TEdit;
    TrackBar2: TTrackBar;
    Label12: TLabel;
    AlleKanleselektieren1: TMenuItem;
    Button1: TButton;
    showanimation: TCheckBox;
    ColorPicker2: TJvOfficeColorPanel;
    Button2: TButton;
    N4: TMenuItem;
    Diagonalselektieren1: TMenuItem;
    Label13: TLabel;
    hasamber: TLabel;
    Label15: TLabel;
    haswhite: TLabel;
    Label14: TLabel;
    amberslider: TTrackBar;
    Label16: TLabel;
    whiteslider: TTrackBar;
    colorpicker: THSLRingPicker;
    procedure dimmersliderChange(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure rowcountChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure channeltypeChange(Sender: TObject);
    procedure useonlyrgbMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chanactiveMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AlleKanleaktivieren1Click(Sender: TObject);
    procedure AlleKanledeaktivieren1Click(Sender: TObject);
    procedure AlleKanleaufRGBschalten1Click(Sender: TObject);
    procedure AlleKanleaufNormalschalten1Click(Sender: TObject);
    procedure AlleKanleBlackout1Click(Sender: TObject);
    procedure AlleDelayzeitenzurcksetzen1Click(Sender: TObject);
    procedure AlleFadezeitenzurcksetzen1Click(Sender: TObject);
    procedure fadetimeeditChange(Sender: TObject);
    procedure delayeditChange(Sender: TObject);
    procedure previewtodevicesMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure drawtimerTimer(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure heditChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure AlleKanleselektieren1Click(Sender: TObject);
    procedure ColorPickerChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure showanimationMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure ambersliderChange(Sender: TObject);
    procedure whitesliderChange(Sender: TObject);
    procedure Diagonalselektieren1Click(Sender: TObject);
    procedure ColorPicker2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    selectedrow:integer;
    selectedcol:integer;
    sourcerow:integer;
    sourcecol:integer;
    selected:array of array of boolean;

    _Buffer: TBitmap32;
    lauflichtcounter:integer;
    MouseDownPoint:TPoint;
    LastMousePoint:TPoint;
  public
    { Public-Deklarationen }
    devicecount:integer;
    procedure DrawPreview;
    function Max(Value, MaxValue: integer):integer;
  end;

var
  lauflichtassistentownpatternform: Tlauflichtassistentownpatternform;

implementation

uses geraetesteuerungfrm, lauflichtassistentfrm, PCDIMMER;

{$R *.dfm}

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

function RGBAW2TColor(const R, G, B, A, W: Byte): Integer;
var
  Rint, Gint, Bint:integer;
  Rbyte, Gbyte, Bbyte: byte;
begin
  // convert hexa-decimal values to RGB
  Rint:=R+W+A;
  Gint:=round(G+W+(A*0.75));
  Bint:=B+W;

  if Rint>255 then Rint:=255;
  if Gint>255 then Gint:=255;
  if Bint>255 then Bint:=255;
  
  Rbyte:=Rint;
  Gbyte:=Gint;
  Bbyte:=Bint;
  
  Result := Rbyte + Gbyte shl 8 + Bbyte shl 16;
end;

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

procedure Tlauflichtassistentownpatternform.dimmersliderChange(Sender: TObject);
var
  i,j:integer;
begin
  label3.caption:=inttostr(round(dimmerslider.position/255*100))+'% ('+inttostr(dimmerslider.position)+')';
//  lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].intensity:=dimmerslider.position;
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
        lauflichtassistentform.lauflichtarray[i][j].intensity:=dimmerslider.position;
end;

procedure Tlauflichtassistentownpatternform.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, j, rectanglewidth, rectangleheight, devicepos:integer;
begin
  MouseDownPoint.X:=X;
  MouseDownPoint.Y:=Y;
  LastMousePoint.X:=X;
  LastMousePoint.Y:=Y;

  rectanglewidth:=round(paintbox1.Width/devicecount);
  rectangleheight:=round(paintbox1.Height/(rowcount.value+1));

  if Shift=[ssLeft, ssShift] then
  begin
    selectedcol:=(x div rectanglewidth);
    selectedrow:=(y div rectangleheight);
    selected[selectedrow][selectedcol]:=not selected[selectedrow][selectedcol];
  end else if Shift=[ssLeft, ssCtrl] then
  begin
    for i:=0 to length(selected)-1 do
      for j:=0 to length(selected[i])-1 do
        selected[i][j]:=false;

    selectedcol:=(x div rectanglewidth);
    selectedrow:=(y div rectangleheight);
    selected[selectedrow][selectedcol]:=true;

    sourcecol:=selectedcol;
    sourcerow:=selectedrow;
  end else if Shift=[ssLeft, ssAlt] then
  begin
    for i:=0 to length(selected)-1 do
      for j:=0 to length(selected[i])-1 do
        selected[i][j]:=false;

    selectedcol:=(x div rectanglewidth);
    selectedrow:=(y div rectangleheight);
    selected[selectedrow][selectedcol]:=true;

    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].enabled:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].enabled;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].intensity:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].intensity;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].channel:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].channel;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].delay:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].delay;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].fadetime:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].fadetime;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].r:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].r;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].g:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].g;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].b:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].b;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].a:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].a;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].w:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].w;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb:=lauflichtassistentform.lauflichtarray[sourcerow][sourcecol].useonlyrgb;
  end else
  begin
    for i:=0 to length(selected)-1 do
      for j:=0 to length(selected[i])-1 do
        selected[i][j]:=false;

    selectedcol:=(x div rectanglewidth);
    selectedrow:=(y div rectangleheight);
    selected[selectedrow][selectedcol]:=true;
  end;
  
  devicepos:=geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[selectedcol]);

  if devicepos=-1 then
  begin
    devicepos:=geraetesteuerung.GetGroupPositionInGroupArray(lauflichtassistentform.lauflichtdevices[selectedcol]);

    devicename.Caption:=mainform.devicegroups[devicepos].Name;
    deviceaddress.caption:=_('n/a');


    if mainform.devicegroups[devicepos].HasChanType[14] or mainform.devicegroups[devicepos].HasChanType[15] or mainform.devicegroups[devicepos].HasChanType[16] then
      hasrgb.Caption:=_('Ja')
    else
      hasrgb.Caption:=_('Nein');
    if mainform.devicegroups[devicepos].HasChanType[41] then
      hasamber.Caption:=_('Ja')
    else
      hasamber.Caption:=_('Nein');
    if mainform.devicegroups[devicepos].HasChanType[40] then
      haswhite.Caption:=_('Ja')
    else
      haswhite.Caption:=_('Nein');
    if mainform.devicegroups[devicepos].HasChanType[19] then
      hasdimmer.Caption:=_('Ja')
    else
      hasdimmer.Caption:=_('Nein');
  end else
  begin
    devicename.Caption:=mainform.devices[devicepos].Name;
    if mainform.devices[devicepos].MaxChan>1 then
      deviceaddress.Caption:=inttostr(mainform.devices[devicepos].Startaddress)+'...'+inttostr(mainform.devices[devicepos].Startaddress+mainform.devices[devicepos].MaxChan)
    else
      deviceaddress.caption:=inttostr(mainform.devices[devicepos].Startaddress);

    if mainform.devices[devicepos].hasRGB then
      hasrgb.Caption:=_('Ja')
    else
      hasrgb.Caption:=_('Nein');
    if mainform.devices[devicepos].hasAmber then
      hasamber.Caption:=_('Ja')
    else
      hasamber.Caption:=_('Nein');
    if mainform.devices[devicepos].hasWhite then
      haswhite.Caption:=_('Ja')
    else
      haswhite.Caption:=_('Nein');
    if mainform.devices[devicepos].hasDimmer then
      hasdimmer.Caption:=_('Ja')
    else
      hasdimmer.Caption:=_('Nein');
  end;

  chanactive.Checked:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].enabled;

//  colorpicker.SelectedColor:=RGB2TColor(lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].r, lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].g, lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].b);
  dimmerslider.Position:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].intensity;
  amberslider.Position:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].a;
  whiteslider.Position:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].w;
  channeltype.ItemIndex:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].channel;
  delayedit.Value:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].delay;
  fadetimeedit.Value:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].fadetime;

  useonlyrgb.checked:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb;
  channeltype.enabled:=not lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb;
  dimmerslider.enabled:=not lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb;
  amberslider.enabled:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb;
  whiteslider.enabled:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb;

  colorpicker.enabled:=useonlyrgb.Checked;
end;

procedure Tlauflichtassistentownpatternform.FormShow(Sender: TObject);
var
  i:integer;
begin
  setlength(selected, round(rowcount.value));
  for i:=0 to length(selected)-1 do
    setlength(selected[i], devicecount);

  channeltype.Items.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
  begin
    channeltype.Items.Add(mainform.DeviceChannelNames[i]);
  end;
  previewtodevices.Checked:=lauflichtassistentform.previewtodevices.Checked;
  drawtimer.Enabled:=true;
end;

procedure Tlauflichtassistentownpatternform.rowcountChange(Sender: TObject);
var
  i, j:integer;
  rowadded:boolean;
  position:integer;
  oldlength:integer;
begin
  rowadded:=round(rowcount.Value)>length(lauflichtassistentform.lauflichtarray);

  oldlength:=length(lauflichtassistentform.lauflichtarray);

  setlength(lauflichtassistentform.lauflichtarray, round(rowcount.value));
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
    setlength(lauflichtassistentform.lauflichtarray[i], devicecount);

  setlength(selected, round(rowcount.value));
  for i:=0 to length(selected)-1 do
    setlength(selected[i], devicecount);

  if rowadded then
  begin
    for j:=oldlength to length(lauflichtassistentform.lauflichtarray)-1 do
    for i:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[j][i].enabled:=true;
      lauflichtassistentform.lauflichtarray[j][i].delay:=0;
      lauflichtassistentform.lauflichtarray[j][i].fadetime:=-1;
      lauflichtassistentform.lauflichtarray[j][i].intensity:=0;
      lauflichtassistentform.lauflichtarray[j][i].r:=0;
      lauflichtassistentform.lauflichtarray[j][i].g:=0;
      lauflichtassistentform.lauflichtarray[j][i].b:=0;
      lauflichtassistentform.lauflichtarray[j][i].a:=0;
      lauflichtassistentform.lauflichtarray[j][i].w:=0;
      lauflichtassistentform.lauflichtarray[j][i].channel:=19;

      position:=geraetesteuerung.GetDevicePositionInDeviceArray(@lauflichtassistentform.lauflichtdevices[i]);
      if position>-1 then
      begin
        // Gerät
        lauflichtassistentform.lauflichtarray[j][i].useonlyrgb:=mainform.Devices[position].hasRGB;
      end;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
end;

procedure Tlauflichtassistentownpatternform.FormResize(Sender: TObject);
begin
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
end;

procedure Tlauflichtassistentownpatternform.channeltypeChange(
  Sender: TObject);
var
  i,j:integer;
begin
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
        lauflichtassistentform.lauflichtarray[i][j].channel:=channeltype.ItemIndex;
//  lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].channel:=channeltype.ItemIndex;
end;

procedure Tlauflichtassistentownpatternform.useonlyrgbMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i,j:integer;
begin
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
        lauflichtassistentform.lauflichtarray[i][j].useonlyrgb:=useonlyrgb.Checked;
//  lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].useonlyrgb:=useonlyrgb.Checked;
  channeltype.Enabled:=not useonlyrgb.Checked;
  dimmerslider.Enabled:=not useonlyrgb.Checked;
  colorpicker.enabled:=useonlyrgb.Checked;
  amberslider.enabled:=useonlyrgb.Checked;
  whiteslider.enabled:=useonlyrgb.Checked;
end;

procedure Tlauflichtassistentownpatternform.chanactiveMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i,j:integer;
begin
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
        lauflichtassistentform.lauflichtarray[i][j].enabled:=chanactive.checked;
//  lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].enabled:=chanactive.checked;
end;

procedure Tlauflichtassistentownpatternform.AlleKanleaktivieren1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].enabled:=true;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.AlleKanledeaktivieren1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].enabled:=false;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.AlleKanleaufRGBschalten1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].useonlyrgb:=true;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.AlleKanleaufNormalschalten1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].useonlyrgb:=false;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.AlleKanleBlackout1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].intensity:=0;
      lauflichtassistentform.lauflichtarray[i][j].r:=0;
      lauflichtassistentform.lauflichtarray[i][j].g:=0;
      lauflichtassistentform.lauflichtarray[i][j].b:=0;
      lauflichtassistentform.lauflichtarray[i][j].a:=0;
      lauflichtassistentform.lauflichtarray[i][j].w:=0;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.AlleDelayzeitenzurcksetzen1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].delay:=0;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.AlleFadezeitenzurcksetzen1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtarray)-1 do
  begin
    for j:=0 to devicecount-1 do
    begin
      lauflichtassistentform.lauflichtarray[i][j].fadetime:=-1;
    end;
  end;
end;

procedure Tlauflichtassistentownpatternform.fadetimeeditChange(
  Sender: TObject);
var
  i,j:integer;
begin
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
        lauflichtassistentform.lauflichtarray[i][j].fadetime:=round(fadetimeedit.value);
//  lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].fadetime:=round(fadetimeedit.value);
end;

procedure Tlauflichtassistentownpatternform.delayeditChange(
  Sender: TObject);
var
  i,j:integer;
begin
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
        lauflichtassistentform.lauflichtarray[i][j].delay:=round(delayedit.value);
//  lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].delay:=round(delayedit.value);
end;

procedure Tlauflichtassistentownpatternform.previewtodevicesMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  lauflichtassistentform.previewtodevices.Checked:=previewtodevices.Checked;
end;

procedure Tlauflichtassistentownpatternform.DrawPreview;
var
  i,abstand:integer;
begin
  if devicecount<=0 then exit;

  // Lauflichvorschau darstellen
  lauflichtcounter:=lauflichtcounter+1;
  if lauflichtcounter>=length(lauflichtassistentform.lauflichtarray) then
    lauflichtcounter:=0;

  abstand:=round((paintbox2.Width-25)/devicecount);

  paintbox2.Canvas.Brush.Color:=groupbox1.Color;
  paintbox2.Canvas.Pen.Style:=psClear;
  paintbox2.Canvas.Rectangle(0,0,paintbox2.Width,paintbox2.Height);

  for i:=0 to devicecount-1 do
  begin
    // Eigenes Muster
    if lauflichtassistentform.lauflichtarray[lauflichtcounter][i].enabled then
    begin
      if lauflichtassistentform.lauflichtarray[lauflichtcounter][i].useonlyrgb then
        paintbox2.Canvas.Brush.Color:=RGBAW2TColor(lauflichtassistentform.lauflichtarray[lauflichtcounter][i].r,lauflichtassistentform.lauflichtarray[lauflichtcounter][i].g,lauflichtassistentform.lauflichtarray[lauflichtcounter][i].b,lauflichtassistentform.lauflichtarray[lauflichtcounter][i].a,lauflichtassistentform.lauflichtarray[lauflichtcounter][i].w)
      else
        paintbox2.canvas.Brush.Color:=RGB2TColor(lauflichtassistentform.lauflichtarray[lauflichtcounter][i].intensity,lauflichtassistentform.lauflichtarray[lauflichtcounter][i].intensity, lauflichtassistentform.lauflichtarray[lauflichtcounter][i].intensity);
    end else
      paintbox2.canvas.Brush.Color:=clBlack;
    paintbox2.Canvas.Rectangle(round(abstand*i+abstand/2),0,round(abstand*i+abstand/2)+25,41);
    paintbox2.Canvas.Brush.Color:=groupbox1.Color;
  end;
end;

procedure Tlauflichtassistentownpatternform.drawtimerTimer(
  Sender: TObject);
var
  i,j,rectanglewidth,rectangleheight:integer;
begin
  _Buffer.Canvas.Brush.Color := clGray;

  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.Brush.Color:=clBtnFace;
  _Buffer.Canvas.FillRect(_Buffer.ClipRect);
  _Buffer.Canvas.Pen.Style:=psSolid;

  rectanglewidth:=round(paintbox1.Width/devicecount);
  rectangleheight:=round(paintbox1.Height/(rowcount.value+1));

  for i:=0 to round(rowcount.Value)-1 do
  begin
    // Zeilen durchiterieren
    if i>length(lauflichtassistentform.lauflichtarray) then break;

    for j:=0 to devicecount-1 do
    begin
      if j>length(lauflichtassistentform.lauflichtarray[i]) then break;

      // Spalten zeichnen
//      if (selectedrow=i) and (selectedcol=j) then
      if selected[i][j] or ((selectedrow=i) and (selectedcol=j)) then
        _Buffer.Canvas.Pen.Color:=clYellow
      else
      begin
        if lauflichtassistentform.lauflichtarray[i][j].enabled then
          _Buffer.Canvas.Pen.Color:=clGreen
        else
          _Buffer.Canvas.Pen.Color:=clGray;
      end;
      if lauflichtassistentform.lauflichtarray[i][j].useonlyrgb then
        _Buffer.Canvas.Brush.Color:=RGBAW2TColor(lauflichtassistentform.lauflichtarray[i][j].r,lauflichtassistentform.lauflichtarray[i][j].g,lauflichtassistentform.lauflichtarray[i][j].b,lauflichtassistentform.lauflichtarray[i][j].a,lauflichtassistentform.lauflichtarray[i][j].w)
      else
        _Buffer.Canvas.Brush.Color:=RGB2TColor(lauflichtassistentform.lauflichtarray[i][j].intensity, lauflichtassistentform.lauflichtarray[i][j].intensity, lauflichtassistentform.lauflichtarray[i][j].intensity);
      _Buffer.Canvas.Rectangle(rectanglewidth*j,rectangleheight*i,rectanglewidth*(j+1),rectangleheight*(i+1));
    end;
  end;
  BitBlt(PaintBox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tlauflichtassistentownpatternform.TrackBar2Change(
  Sender: TObject);
begin
  if Sender=trackbar2 then
    lauflichtassistentform.trackbar2.Position:=trackbar2.Position;
end;

procedure Tlauflichtassistentownpatternform.heditChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  mainform.input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  lauflichtassistentform.hedit.Text:=hedit.Text;
  lauflichtassistentform.minedit.Text:=minedit.Text;
  lauflichtassistentform.sedit.Text:=sedit.Text;
  lauflichtassistentform.msedit.Text:=msedit.Text;

  lauflichtassistentform.lauflichtfadetime:=strtoint(hedit.Text)*3600000+strtoint(minedit.Text)*60000+strtoint(sedit.Text)*1000+strtoint(msedit.Text);
end;

procedure Tlauflichtassistentownpatternform.FormHide(Sender: TObject);
begin
  drawtimer.Enabled:=false;
end;

procedure Tlauflichtassistentownpatternform.PaintBox1MouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  value:integer;
begin
  if Shift=[ssLeft] then
  begin
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].enabled:=true;
    chanactive.checked:=true;

    //value:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].intensity-(Y-MouseDownPoint.Y);
    value:=lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].intensity-5*(Y-LastMousePoint.Y);
    if value<0 then value:=0;
    if value>255 then value:=255;
    dimmerslider.Position:=value;

    LastMousePoint.X:=X;
    LastMousePoint.Y:=Y;

    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].intensity:=value;
    drawtimerTimer(nil);
  end;
end;

procedure Tlauflichtassistentownpatternform.CreateParams(var Params:TCreateParams);
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

function Tlauflichtassistentownpatternform.Max(Value, MaxValue: integer):integer;
begin
  if Value>MaxValue then
    result:=MaxValue
  else
    result:=Value;
end;

procedure Tlauflichtassistentownpatternform.AlleKanleselektieren1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(selected)-1 do
    for j:=0 to length(selected[i])-1 do
      selected[i][j]:=true;
end;

procedure Tlauflichtassistentownpatternform.ColorPickerChange(
  Sender: TObject);
var
  r,g,b:byte;
  i,j:integer;
begin
  TColor2Rgb(colorpicker.SelectedColor, r,g,b);
{
  if selectedrow<length(lauflichtassistentform.lauflichtarray) then
  if selectedcol<length(lauflichtassistentform.lauflichtarray[selectedrow]) then
  begin
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].r:=r;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].g:=g;
    lauflichtassistentform.lauflichtarray[selectedrow][selectedcol].b:=b;
  end;
}
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
      begin
        lauflichtassistentform.lauflichtarray[i][j].r:=max(r,255);
        lauflichtassistentform.lauflichtarray[i][j].g:=max(g,255);
        lauflichtassistentform.lauflichtarray[i][j].b:=max(b,255);
      end;
end;

procedure Tlauflichtassistentownpatternform.Button1Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(lauflichtassistentform.lauflichtdevices)-1 do
  begin
    geraetesteuerung.set_dimmer(lauflichtassistentform.lauflichtdevices[i], 255, 500);
  end;
end;

procedure Tlauflichtassistentownpatternform.showanimationMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  drawtimer.Enabled:=showanimation.Checked;
end;

procedure Tlauflichtassistentownpatternform.Button2Click(Sender: TObject);
begin
  if colorpicker.Visible then
  begin
    colorpicker.Visible:=false;
    colorpicker2.Visible:=true;
  end else
  begin
    colorpicker.Visible:=true;
    colorpicker2.Visible:=false;
  end;
end;

procedure Tlauflichtassistentownpatternform.ambersliderChange(
  Sender: TObject);
var
  i,j:integer;
begin
  // change amber-color
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
      begin
        lauflichtassistentform.lauflichtarray[i][j].a:=amberslider.position;
      end;
end;

procedure Tlauflichtassistentownpatternform.whitesliderChange(
  Sender: TObject);
var
  i,j:integer;
begin
  // change white-color
  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
      begin
        lauflichtassistentform.lauflichtarray[i][j].w:=whiteslider.position;
      end;
end;

procedure Tlauflichtassistentownpatternform.Diagonalselektieren1Click(
  Sender: TObject);
var
  i,j,colcounter:integer;
begin
  for i:=0 to length(selected)-1 do
    for j:=0 to length(selected[i])-1 do
      selected[i][j]:=false;

  colcounter:=0;

  for i:=0 to length(selected)-1 do
    for j:=0 to length(selected[i])-1 do
    begin
      if (j=colcounter) then
      begin
        selected[i][j]:=true;
        colcounter:=colcounter+1;
        break;
      end;
    end;
end;

procedure Tlauflichtassistentownpatternform.ColorPicker2MouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  r,g,b:byte;
  i,j:integer;
begin
  TColor2Rgb(colorpicker2.SelectedColor, r,g,b);

  for j:=0 to devicecount-1 do
    for i:=0 to round(rowcount.value)-1 do
      if selected[i][j] then
      begin
        lauflichtassistentform.lauflichtarray[i][j].r:=max(r,255);
        lauflichtassistentform.lauflichtarray[i][j].g:=max(g,255);
        lauflichtassistentform.lauflichtarray[i][j].b:=max(b,255);
      end;
end;

end.

