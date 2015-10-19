unit matrixeditorfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TiledImage, StdCtrls, Mask, JvExMask, JvSpin, GR32,
  ComCtrls, mbColorPickerControl, HSColorPicker, XPMan, GnuGetText, Menus,
  Buttons, HSLColorPicker, JvExExtCtrls, JvExtComponent, JvPanel,
  JvOfficeColorPanel;

type
  Tmatrixrecord = record
    enabled : boolean;
    device : TGUID;
    channel : byte;
    intensity : byte;
    delay : integer;
    r,g,b:byte;
    fadetime : integer;
    useonlyrgb:boolean;
  end;

  Tmatrixeditorform = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    rowcount: TJvSpinEdit;
    drawtimer: TTimer;
    GroupBox1: TGroupBox;
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
    Label11: TLabel;
    hedit: TEdit;
    minedit: TEdit;
    sedit: TEdit;
    msedit: TEdit;
    TrackBar2: TTrackBar;
    Label12: TLabel;
    colcount: TJvSpinEdit;
    Label13: TLabel;
    devicebox: TComboBox;
    stepslider: TScrollBar;
    stepcount: TJvSpinEdit;
    cancelbtn: TButton;
    Label4: TLabel;
    Label14: TLabel;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    PaintBox1: TPaintBox;
    NewMatrixBtn: TSpeedButton;
    OpenMatrixBtn: TSpeedButton;
    SaveMatrixBtn: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    AlleGerteselektieren1: TMenuItem;
    colorpicker: THSLColorPicker;
    ColorPicker2: TJvOfficeColorPanel;
    Button2: TButton;
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
    procedure drawtimerTimer(Sender: TObject);
    procedure heditChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure stepsliderEnter(Sender: TObject);
    procedure stepcountChange(Sender: TObject);
    procedure deviceboxSelect(Sender: TObject);
    procedure colcountChange(Sender: TObject);
    procedure okbtnClick(Sender: TObject);
    procedure stepsliderChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar2Change(Sender: TObject);
    procedure deviceboxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure SaveMatrixBtnClick(Sender: TObject);
    procedure OpenMatrixBtnClick(Sender: TObject);
    procedure NewMatrixBtnClick(Sender: TObject);
    procedure NewMatrix;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure AlleGerteselektieren1Click(Sender: TObject);
    procedure colorpickerChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ColorPicker2ColorChange(Sender: TObject);
  private
    { Private-Deklarationen }
    selectedrow:integer;
    selectedcol:integer;
    selected:array of array of boolean;

    _Buffer: TBitmap32;
    MouseDownPoint:TPoint;
    LastMousePoint:TPoint;
    FileStream:TFileStream;
  public
    { Public-Deklarationen }
    matrixarray:array of array of array of Tmatrixrecord;
    AllElementsSetWithDevice:boolean;
  end;

var
  matrixeditorform: Tmatrixeditorform;

implementation

uses geraetesteuerungfrm, PCDIMMER;

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

procedure Tmatrixeditorform.dimmersliderChange(Sender: TObject);
var
  i,j:integer;
begin
  label3.caption:=inttostr(round(dimmerslider.position/255*100))+'% ('+inttostr(dimmerslider.position)+')';
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
        matrixarray[stepslider.position][i][j].intensity:=dimmerslider.position;
//  matrixarray[stepslider.position][selectedrow][selectedcol].intensity:=dimmerslider.position;
  stepsliderChange(nil);
end;

procedure Tmatrixeditorform.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i,j,rectanglewidth, rectangleheight, devicepos:integer;
begin
  MouseDownPoint.X:=X;
  MouseDownPoint.Y:=Y;
  LastMousePoint.X:=X;
  LastMousePoint.Y:=Y;

  rectanglewidth:=round(paintbox1.Width/(colcount.value+1));
  rectangleheight:=round(paintbox1.Height/(rowcount.value+1));

  if Shift=[ssLeft, ssShift] then
  begin
    selectedcol:=(x div rectanglewidth);
    selectedrow:=(y div rectangleheight);
    if selectedrow>=length(matrixarray[0]) then
      selectedrow:=0;
    if selectedcol>=length(matrixarray[0][0]) then
      selectedcol:=0;
    selected[selectedrow][selectedcol]:=not selected[selectedrow][selectedcol];
  end else
  begin
    for i:=0 to length(selected)-1 do
      for j:=0 to length(selected[i])-1 do
        selected[i][j]:=false;

    selectedcol:=(x div rectanglewidth);
    selectedrow:=(y div rectangleheight);
    if selectedrow>=length(matrixarray[0]) then
      selectedrow:=0;
    if selectedcol>=length(matrixarray[0][0]) then
      selectedcol:=0;
    selected[selectedrow][selectedcol]:=true;
  end;

  devicepos:=geraetesteuerung.GetDevicePositionInDeviceArray(@matrixarray[0][selectedrow][selectedcol].device);

  if devicepos=-1 then
  begin
    devicepos:=geraetesteuerung.GetGroupPositionInGroupArray(matrixarray[0][selectedrow][selectedcol].device);

    if devicepos>-1 then
    begin
      devicebox.itemindex:=length(mainform.devices)+devicepos;
      deviceaddress.caption:=_('n/a');

      if mainform.devicegroups[devicepos].HasChanType[14] or mainform.devicegroups[devicepos].HasChanType[15] or mainform.devicegroups[devicepos].HasChanType[16] then
        hasrgb.Caption:=_('Ja')
      else
        hasrgb.Caption:=_('Nein');
      if mainform.devicegroups[devicepos].HasChanType[19] then
        hasdimmer.Caption:=_('Ja')
      else
        hasdimmer.Caption:=_('Nein');
    end else
    begin
      // keine Gruppe
      devicebox.itemindex:=-1;
    end;
  end else
  begin
    devicebox.itemindex:=devicepos;
    
    if mainform.devices[devicepos].MaxChan>1 then
      deviceaddress.Caption:=inttostr(mainform.devices[devicepos].Startaddress)+'...'+inttostr(mainform.devices[devicepos].Startaddress+mainform.devices[devicepos].MaxChan)
    else
      deviceaddress.caption:=inttostr(mainform.devices[devicepos].Startaddress);

    if mainform.devices[devicepos].hasRGB then
      hasrgb.Caption:=_('Ja')
    else
      hasrgb.Caption:=_('Nein');
    if mainform.devices[devicepos].hasDimmer then
      hasdimmer.Caption:=_('Ja')
    else
      hasdimmer.Caption:=_('Nein');
  end;

  chanactive.Checked:=matrixarray[stepslider.position][selectedrow][selectedcol].enabled;

//  colorpicker.SelectedColor:=RGB2TColor(matrixarray[stepslider.position][selectedrow][selectedcol].r, matrixarray[stepslider.position][selectedrow][selectedcol].g, matrixarray[stepslider.position][selectedrow][selectedcol].b);

  dimmerslider.Position:=matrixarray[stepslider.position][selectedrow][selectedcol].intensity;
  channeltype.ItemIndex:=matrixarray[stepslider.position][selectedrow][selectedcol].channel;
  delayedit.Value:=matrixarray[stepslider.position][selectedrow][selectedcol].delay;
  fadetimeedit.Value:=matrixarray[stepslider.position][selectedrow][selectedcol].fadetime;

  useonlyrgb.checked:=matrixarray[stepslider.position][selectedrow][selectedcol].useonlyrgb;
  channeltype.enabled:=not matrixarray[stepslider.position][selectedrow][selectedcol].useonlyrgb;
  dimmerslider.enabled:=not matrixarray[stepslider.position][selectedrow][selectedcol].useonlyrgb;

  colorpicker.enabled:=useonlyrgb.Checked;
end;

procedure Tmatrixeditorform.FormShow(Sender: TObject);
var
  i:integer;
begin
  setlength(selected, round(colcount.value));
  for i:=0 to length(selected)-1 do
    setlength(selected[i], round(rowcount.value));

  channeltype.Items.Clear;
  for i:=0 to length(mainform.DeviceChannelNames)-1 do
  begin
    channeltype.Items.Add(mainform.DeviceChannelNames[i]);
  end;

  devicebox.Items.Clear;
  for i:=0 to length(mainform.Devices)-1 do
  begin
    devicebox.Items.Add(mainform.devices[i].Name);
  end;
  for i:=0 to length(mainform.DeviceGroups)-1 do
  begin
    devicebox.Items.Add(mainform.devicegroups[i].Name);
  end;

  NewMatrix;

  drawtimer.Enabled:=true;
end;

procedure Tmatrixeditorform.rowcountChange(Sender: TObject);
var
  oldvalue,i,j,k:integer;
begin
  oldvalue:=length(matrixarray[0]);

  setlength(selected, round(rowcount.value));
  for i:=0 to length(selected)-1 do
    setlength(selected[i], round(colcount.value));

  for k:=0 to length(matrixarray)-1 do
  begin
    setlength(matrixarray[k], round(rowcount.value));

    for i:=oldvalue to length(matrixarray[k])-1 do
    begin
      setlength(matrixarray[k][i], round(colcount.value));

      for j:=0 to length(matrixarray[k][i])-1 do
      begin
        matrixarray[k][i][j].enabled:=true;
        matrixarray[k][i][j].device:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
        matrixarray[k][i][j].channel:=19;
        matrixarray[k][i][j].intensity:=0;
        matrixarray[k][i][j].delay:=0;

        matrixarray[k][i][j].r:=0;
        matrixarray[k][i][j].g:=0;
        matrixarray[k][i][j].b:=0;

        matrixarray[k][i][j].fadetime:=-1;
        matrixarray[k][i][j].useonlyrgb:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixarray[0][i][j].device)].hasRGB;;
      end;
    end;
  end;
end;

procedure Tmatrixeditorform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
end;

procedure Tmatrixeditorform.FormResize(Sender: TObject);
begin
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;
end;

procedure Tmatrixeditorform.channeltypeChange(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
        matrixarray[stepslider.position][i][j].channel:=channeltype.ItemIndex;
//  matrixarray[stepslider.position][selectedrow][selectedcol].channel:=channeltype.ItemIndex;
  stepsliderChange(nil);
end;

procedure Tmatrixeditorform.useonlyrgbMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i,j:integer;
begin
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
        matrixarray[stepslider.position][i][j].useonlyrgb:=useonlyrgb.Checked;
//  matrixarray[stepslider.position][selectedrow][selectedcol].useonlyrgb:=useonlyrgb.Checked;
  channeltype.Enabled:=not useonlyrgb.Checked;
  dimmerslider.Enabled:=not useonlyrgb.Checked;
  colorpicker.enabled:=useonlyrgb.Checked;
  stepsliderChange(nil);
end;

procedure Tmatrixeditorform.chanactiveMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i,j:integer;
begin
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
        matrixarray[stepslider.position][i][j].enabled:=chanactive.checked;
//  matrixarray[stepslider.position][selectedrow][selectedcol].enabled:=chanactive.checked;
  stepsliderChange(nil);
end;

procedure Tmatrixeditorform.AlleKanleaktivieren1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].enabled:=true;
    end;
  end;
end;

procedure Tmatrixeditorform.AlleKanledeaktivieren1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].enabled:=false;
    end;
  end;
end;

procedure Tmatrixeditorform.AlleKanleaufRGBschalten1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].useonlyrgb:=true;
    end;
  end;
end;

procedure Tmatrixeditorform.AlleKanleaufNormalschalten1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].useonlyrgb:=false;
    end;
  end;
end;

procedure Tmatrixeditorform.AlleKanleBlackout1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].intensity:=0;
      matrixarray[stepslider.position][i][j].r:=0;
      matrixarray[stepslider.position][i][j].g:=0;
      matrixarray[stepslider.position][i][j].b:=0;
    end;
  end;
end;

procedure Tmatrixeditorform.AlleDelayzeitenzurcksetzen1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].delay:=0;
    end;
  end;
end;

procedure Tmatrixeditorform.AlleFadezeitenzurcksetzen1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(matrixarray[stepslider.position])-1 do
  begin
    for j:=0 to length(matrixarray[stepslider.position][i])-1 do
    begin
      matrixarray[stepslider.position][i][j].fadetime:=-1;
    end;
  end;
end;

procedure Tmatrixeditorform.fadetimeeditChange(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
        matrixarray[stepslider.position][i][j].fadetime:=round(fadetimeedit.value);
//  matrixarray[stepslider.position][selectedrow][selectedcol].fadetime:=round(fadetimeedit.value);
end;

procedure Tmatrixeditorform.delayeditChange(
  Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
        matrixarray[stepslider.position][i][j].delay:=round(delayedit.value);
//  matrixarray[stepslider.position][selectedrow][selectedcol].delay:=round(delayedit.value);
end;

procedure Tmatrixeditorform.drawtimerTimer(
  Sender: TObject);
var
  i,j,rectanglewidth,rectangleheight:integer;
begin
  _Buffer.Canvas.Brush.Color := clGray;

  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.Brush.Color:=clBtnFace;
  _Buffer.Canvas.FillRect(_Buffer.ClipRect);
  _Buffer.Canvas.Pen.Style:=psSolid;

  rectanglewidth:=round(paintbox1.Width/(colcount.value+1));
  rectangleheight:=round(paintbox1.Height/(rowcount.value+1));

  for i:=0 to length(matrixarray[stepslider.position])-1 do
  for j:=0 to length(matrixarray[stepslider.position][i])-1 do
  begin
//    if (selectedrow=i) and (selectedcol=j) then
    if selected[i][j] or ((selectedrow=i) and (selectedcol=j)) then
      _Buffer.Canvas.Pen.Color:=clYellow
    else
    begin
      if matrixarray[stepslider.position][i][j].enabled then
        _Buffer.Canvas.Pen.Color:=clGreen
      else
        _Buffer.Canvas.Pen.Color:=clGray;
    end;

    if IsEqualGuid(matrixarray[0][i][j].device, StringToGUID('{00000000-0000-0000-0000-000000000000}')) then
    begin
      _Buffer.Canvas.Brush.Color:=clRed;
      _Buffer.Canvas.Brush.Style:=bsDiagCross;
    end else
    begin
      if matrixarray[stepslider.position][i][j].useonlyrgb then
        _Buffer.Canvas.Brush.Color:=RGB2TColor(matrixarray[stepslider.position][i][j].r,matrixarray[stepslider.position][i][j].g,matrixarray[stepslider.position][i][j].b)
      else
        _Buffer.Canvas.Brush.Color:=RGB2TColor(matrixarray[stepslider.position][i][j].intensity, matrixarray[stepslider.position][i][j].intensity, matrixarray[stepslider.position][i][j].intensity);

      _Buffer.Canvas.Brush.Style:=bsSolid;
    end;

    _Buffer.Canvas.Rectangle(rectanglewidth*j,rectangleheight*i,rectanglewidth*(j+1),rectangleheight*(i+1));
    _Buffer.Canvas.Brush.Style:=bsSolid;
  end;
  BitBlt(PaintBox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tmatrixeditorform.heditChange(Sender: TObject);
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

procedure Tmatrixeditorform.FormHide(Sender: TObject);
begin
  drawtimer.Enabled:=false;
  Timer1.enabled:=false;
end;

procedure Tmatrixeditorform.PaintBox1MouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  value:integer;
begin
  if Shift=[ssLeft] then
  begin
    matrixarray[stepslider.position][selectedrow][selectedcol].enabled:=true;
    chanactive.checked:=true;

    //value:=matrixarray[stepslider.position][selectedrow][selectedcol].intensity-(Y-MouseDownPoint.Y);
    value:=matrixarray[stepslider.position][selectedrow][selectedcol].intensity-5*(Y-LastMousePoint.Y);
    if value<0 then value:=0;
    if value>255 then value:=255;
    dimmerslider.Position:=value;

    matrixarray[stepslider.position][selectedrow][selectedcol].intensity:=value;
    drawtimerTimer(nil);

    if previewtodevices.Checked then
    begin
      // Werte ausgeben
      stepsliderchange(nil);
    end;
  end;
end;

procedure Tmatrixeditorform.stepsliderEnter(Sender: TObject);
begin
  stepslider.Max:=length(matrixarray)-1;
end;

procedure Tmatrixeditorform.stepcountChange(Sender: TObject);
var
  i,j,k,oldvalue:integer;
begin
  oldvalue:=length(matrixarray);
  setlength(matrixarray, round(stepcount.value));
  stepslider.Max:=round(stepcount.value)-1;

  for k:=oldvalue to length(matrixarray)-1 do
  begin
    setlength(matrixarray[k], round(rowcount.value));

    for i:=0 to length(matrixarray[k])-1 do
    begin
      setlength(matrixarray[k][i], round(colcount.value));

      for j:=0 to length(matrixarray[k][i])-1 do
      begin
        matrixarray[k][i][j].enabled:=true;
        matrixarray[k][i][j].device:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
        matrixarray[k][i][j].channel:=19;
        matrixarray[k][i][j].intensity:=0;
        matrixarray[k][i][j].delay:=0;

        matrixarray[k][i][j].r:=0;
        matrixarray[k][i][j].g:=0;
        matrixarray[k][i][j].b:=0;

        matrixarray[k][i][j].fadetime:=-1;
        matrixarray[k][i][j].useonlyrgb:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixarray[0][i][j].device)].hasRGB;
      end;
    end;
  end;
end;

procedure Tmatrixeditorform.deviceboxSelect(Sender: TObject);
var
  alreadyhere:boolean;
  i,j:integer;
  ID:TGUID;
begin
  alreadyhere:=false;

  if devicebox.ItemIndex<length(mainform.Devices) then
  begin
    // Gerät
    ID:=mainform.devices[devicebox.ItemIndex].ID;
  end else
  begin
    ID:=mainform.devicegroups[devicebox.ItemIndex-length(mainform.Devices)].ID;
  end;

  for i:=0 to length(matrixarray[0])-1 do
  begin
    for j:=0 to length(matrixarray[0][i])-1 do
    begin
      if IsEqualGuid(matrixarray[0][i][j].device, ID) then
      begin
        alreadyhere:=true;
        break;
      end;
    end;
    if alreadyhere then break;
  end;

  if not alreadyhere then
    matrixarray[0][selectedrow][selectedcol].device:=ID
  else
    Showmessage(_('Dieses Gerät wurde bereits in der aktuellen Matrixszene verwendet...'));
end;

procedure Tmatrixeditorform.colcountChange(Sender: TObject);
var
  oldvalue,i,j,k:integer;
begin
  oldvalue:=length(matrixarray[0][0]);

  setlength(selected, round(rowcount.value));
  for i:=0 to length(selected)-1 do
    setlength(selected[i], round(colcount.value));

  for k:=0 to length(matrixarray)-1 do
  begin
    for i:=0 to length(matrixarray[k])-1 do
    begin
      setlength(matrixarray[k][i], round(colcount.value));

      for j:=oldvalue to length(matrixarray[k][i])-1 do
      begin
        matrixarray[k][i][j].enabled:=true;
        matrixarray[k][i][j].device:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
        matrixarray[k][i][j].channel:=19;
        matrixarray[k][i][j].intensity:=0;
        matrixarray[k][i][j].delay:=0;

        matrixarray[k][i][j].r:=0;
        matrixarray[k][i][j].g:=0;
        matrixarray[k][i][j].b:=0;

        matrixarray[k][i][j].fadetime:=-1;
        matrixarray[k][i][j].useonlyrgb:=mainform.Devices[geraetesteuerung.GetDevicePositionInDeviceArray(@matrixarray[0][i][j].device)].hasRGB;;
      end;
    end;
  end;
end;

procedure Tmatrixeditorform.okbtnClick(Sender: TObject);
var
  i,j:integer;
begin
  AllElementsSetWithDevice:=true;

  for i:=0 to length(matrixarray[0])-1 do
  begin
    for j:=0 to length(matrixarray[0][i])-1 do
    begin
      if IsEqualGUID(matrixarray[0][i][j].device, StringToGUID('{00000000-0000-0000-0000-000000000000}')) then
      begin
        AllElementsSetWithDevice:=false;
        break;
      end;
    end;
    if not AllElementsSetWithDevice then break;
  end;

  if not AllElementsSetWithDevice then
  begin
    ShowMessage(_('Es wurden noch nicht alle Matrix-Elemente mit einem Gerät verbunden...'));
  end else
  begin
    ModalResult:=mrOK;
  end;
end;

procedure Tmatrixeditorform.stepsliderChange(Sender: TObject);
var
  i,j, fadetime:integer;
begin
  for i:=0 to length(matrixarray[stepslider.Position])-1 do
  for j:=0 to length(matrixarray[stepslider.Position][i])-1 do
  begin
    if matrixarray[stepslider.Position][i][j].enabled then
    begin
      // Fadetime setzen
      if matrixarray[stepslider.Position][i][j].fadetime=-1 then
        fadetime:=strtoint(hedit.text)*3600000+strtoint(minedit.text)*60000+strtoint(sedit.text)*1000+strtoint(msedit.text)
      else
        fadetime:=matrixarray[stepslider.Position][i][j].fadetime;

      if matrixarray[stepslider.Position][i][j].useonlyrgb then
      begin
        geraetesteuerung.set_channel(matrixarray[0][i][j].device, 'r', -1, matrixarray[stepslider.Position][i][j].r, fadetime, matrixarray[stepslider.Position][i][j].delay);
        geraetesteuerung.set_channel(matrixarray[0][i][j].device, 'g', -1, matrixarray[stepslider.Position][i][j].g, fadetime, matrixarray[stepslider.Position][i][j].delay);
        geraetesteuerung.set_channel(matrixarray[0][i][j].device, 'b', -1, matrixarray[stepslider.Position][i][j].b, fadetime, matrixarray[stepslider.Position][i][j].delay);
      end else
      begin
        geraetesteuerung.set_channel(matrixarray[0][i][j].device, mainform.DeviceChannelNames[matrixarray[stepslider.Position][i][j].channel], -1, matrixarray[stepslider.Position][i][j].intensity, fadetime, matrixarray[stepslider.Position][i][j].delay);
      end;
    end;
  end;
end;

procedure Tmatrixeditorform.Timer1Timer(Sender: TObject);
begin
  if stepslider.Position=stepslider.Max then
    stepslider.Position:=0
  else
    stepslider.Position:=stepslider.Position+1;
end;

procedure Tmatrixeditorform.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled:=checkbox1.Checked;
end;

procedure Tmatrixeditorform.TrackBar2Change(Sender: TObject);
begin
  timer1.Interval:=round((100-trackbar2.Position)/100*2000);
end;

procedure Tmatrixeditorform.deviceboxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  alreadyhere:boolean;
  i,j:integer;
  ID:TGUID;
begin
  alreadyhere:=false;

  if Index<length(mainform.Devices) then
  begin
    // Gerät
    ID:=mainform.devices[Index].ID;
  end else
  begin
    ID:=mainform.devicegroups[Index-length(mainform.Devices)].ID;
  end;

  for i:=0 to length(matrixarray[0])-1 do
  begin
    for j:=0 to length(matrixarray[0][i])-1 do
    begin
      if IsEqualGuid(matrixarray[0][i][j].device, ID) then
      begin
        alreadyhere:=true;
        break;
      end;
    end;
    if alreadyhere then break;
  end;

  if alreadyhere then
  begin
    (Control as TComboBox).Canvas.Brush.Color := clRed;
    (Control as TComboBox).Canvas.FillRect(Rect);
//    State:=[odDisabled];
  end else
  begin
//    State:=[];
  end;
  DrawText((Control as TComboBox).Canvas.Handle, Pchar(devicebox.Items[index]), Length(devicebox.Items[index]), rect, dt_left);
end;

procedure Tmatrixeditorform.SaveMatrixBtnClick(Sender: TObject);
var
  i,j,k, counter:integer;
begin
  if savedialog1.Execute then
  begin
		FileStream:=TFileStream.Create(savedialog1.FileName,fmCreate);

    // Projektversion
    counter:=mainform.currentprojectversion;
    Filestream.WriteBuffer(counter, sizeof(counter));

    // alle Elemente abspeichern
    counter:=length(matrixarray);
    Filestream.WriteBuffer(counter, sizeof(counter));
    counter:=length(matrixarray[0]);
    Filestream.WriteBuffer(counter, sizeof(counter));
    counter:=length(matrixarray[0][0]);
    Filestream.WriteBuffer(counter, sizeof(counter));

    for i:=0 to length(matrixarray)-1 do
    for j:=0 to length(matrixarray[i])-1 do
    for k:=0 to length(matrixarray[i][j])-1 do
    begin
      FileStream.WriteBuffer(matrixarray[i][j][k].enabled,sizeof(matrixarray[i][j][k].enabled));
      FileStream.WriteBuffer(matrixarray[i][j][k].device,sizeof(matrixarray[i][j][k].device));
      FileStream.WriteBuffer(matrixarray[i][j][k].channel,sizeof(matrixarray[i][j][k].channel));
      FileStream.WriteBuffer(matrixarray[i][j][k].intensity,sizeof(matrixarray[i][j][k].intensity));
      FileStream.WriteBuffer(matrixarray[i][j][k].delay,sizeof(matrixarray[i][j][k].delay));
      FileStream.WriteBuffer(matrixarray[i][j][k].r,sizeof(matrixarray[i][j][k].r));
      FileStream.WriteBuffer(matrixarray[i][j][k].g,sizeof(matrixarray[i][j][k].g));
      FileStream.WriteBuffer(matrixarray[i][j][k].b,sizeof(matrixarray[i][j][k].b));
      FileStream.WriteBuffer(matrixarray[i][j][k].fadetime,sizeof(matrixarray[i][j][k].fadetime));
      FileStream.WriteBuffer(matrixarray[i][j][k].useonlyrgb,sizeof(matrixarray[i][j][k].useonlyrgb));
    end;

    FileStream.Free;
  end;
end;

procedure Tmatrixeditorform.OpenMatrixBtnClick(Sender: TObject);
var
  i,j,k, Fileversion, steps, rows, cols:integer;
begin
  if opendialog1.Execute then
  begin
		FileStream:=TFileStream.Create(opendialog1.FileName,fmOpenRead);

    // Projektversion
    Filestream.ReadBuffer(Fileversion, sizeof(Fileversion));

    // alle Elemente abspeichern
    Filestream.ReadBuffer(steps, sizeof(steps));
    Filestream.ReadBuffer(rows, sizeof(rows));
    Filestream.ReadBuffer(cols, sizeof(cols));

    stepcount.value:=steps;
    rowcount.value:=rows;
    colcount.value:=cols;

//    setlength(matrixarray, steps);
    for i:=0 to length(matrixarray)-1 do
    begin
//      setlength(matrixarray[i], rows);
      for j:=0 to length(matrixarray[i])-1 do
      begin
//        setlength(matrixarray[i][j], cols);
        for k:=0 to length(matrixarray[i][j])-1 do
        begin
          FileStream.ReadBuffer(matrixarray[i][j][k].enabled,sizeof(matrixarray[i][j][k].enabled));
          FileStream.ReadBuffer(matrixarray[i][j][k].device,sizeof(matrixarray[i][j][k].device));
          FileStream.ReadBuffer(matrixarray[i][j][k].channel,sizeof(matrixarray[i][j][k].channel));
          FileStream.ReadBuffer(matrixarray[i][j][k].intensity,sizeof(matrixarray[i][j][k].intensity));
          FileStream.ReadBuffer(matrixarray[i][j][k].delay,sizeof(matrixarray[i][j][k].delay));
          FileStream.ReadBuffer(matrixarray[i][j][k].r,sizeof(matrixarray[i][j][k].r));
          FileStream.ReadBuffer(matrixarray[i][j][k].g,sizeof(matrixarray[i][j][k].g));
          FileStream.ReadBuffer(matrixarray[i][j][k].b,sizeof(matrixarray[i][j][k].b));
          FileStream.ReadBuffer(matrixarray[i][j][k].fadetime,sizeof(matrixarray[i][j][k].fadetime));
          FileStream.ReadBuffer(matrixarray[i][j][k].useonlyrgb,sizeof(matrixarray[i][j][k].useonlyrgb));
        end;
      end;
    end;

    FileStream.Free;
  end;
end;

procedure Tmatrixeditorform.NewMatrixBtnClick(Sender: TObject);
begin
  if messagedlg(_('Die bisherige Matrix wird nun gelöscht. Fortfahren?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    NewMatrix;
  end;
end;

procedure Tmatrixeditorform.NewMatrix;
var
  i,j,k:integer;
begin
  // Neue Matrix erzeugen
  setlength(matrixarray, 4);
  stepslider.Max:=3;
  stepslider.position:=0;

  for i:=0 to length(matrixarray)-1 do
  begin
    setlength(matrixarray[i], 2);
    for j:=0 to length(matrixarray[i])-1 do
      setlength(matrixarray[i][j], 2);
  end;

  for i:=0 to length(matrixarray)-1 do
  for j:=0 to length(matrixarray[i])-1 do
  for k:=0 to length(matrixarray[i][j])-1 do
  begin
    matrixarray[i][j][k].enabled:=true;
    matrixarray[i][j][k].device:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    matrixarray[i][j][k].channel:=19;
    matrixarray[i][j][k].intensity:=0;
    matrixarray[i][j][k].delay:=-1;

    matrixarray[i][j][k].r:=0;
    matrixarray[i][j][k].g:=0;
    matrixarray[i][j][k].b:=0;

    matrixarray[i][j][k].fadetime:=-1;
    matrixarray[i][j][k].useonlyrgb:=false;
  end;

  stepcount.value:=4;
  rowcount.value:=2;
  colcount.value:=2;
end;

procedure Tmatrixeditorform.CreateParams(var Params:TCreateParams);
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

procedure Tmatrixeditorform.AlleGerteselektieren1Click(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(selected)-1 do
    for j:=0 to length(selected[i])-1 do
      selected[i][j]:=true;
end;

procedure Tmatrixeditorform.colorpickerChange(Sender: TObject);
var
  r,g,b:byte;
  i,j:integer;
begin
  TColor2Rgb(colorpicker.SelectedColor, r,g,b);
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
      begin
        matrixarray[stepslider.position][i][j].r:=r;
        matrixarray[stepslider.position][i][j].g:=g;
        matrixarray[stepslider.position][i][j].b:=b;
      end;

{
  matrixarray[stepslider.position][selectedrow][selectedcol].r:=r;
  matrixarray[stepslider.position][selectedrow][selectedcol].g:=g;
  matrixarray[stepslider.position][selectedrow][selectedcol].b:=b;
}
  stepsliderChange(nil);
end;

procedure Tmatrixeditorform.Button2Click(Sender: TObject);
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

procedure Tmatrixeditorform.ColorPicker2ColorChange(Sender: TObject);
var
  r,g,b:byte;
  i,j:integer;
begin
  TColor2Rgb(colorpicker2.SelectedColor, r,g,b);
  for i:=0 to round(rowcount.value)-1 do
    for j:=0 to round(colcount.value)-1 do
      if selected[i][j] then
      begin
        matrixarray[stepslider.position][i][j].r:=r;
        matrixarray[stepslider.position][i][j].g:=g;
        matrixarray[stepslider.position][i][j].b:=b;
      end;

  stepsliderChange(nil);
end;

end.
