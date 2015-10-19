unit ambilight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Mask, JvExMask, JvSpin, Registry,
  dxGDIPlusClasses, Buttons, PngBitBtn, gnugettext, GR32, GraphUtil;

type
  Tambilightform = class(TForm)
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sliderr: TTrackBar;
    sliderg: TTrackBar;
    sliderb: TTrackBar;
    sliderbrightness: TTrackBar;
    GroupBox4: TGroupBox;
    compensate43: TCheckBox;
    Label5: TLabel;
    slidersaturation: TTrackBar;
    Label6: TLabel;
    sliderluminance: TTrackBar;
    lblr: TLabel;
    lblg: TLabel;
    lblb: TLabel;
    lblbrightness: TLabel;
    lblsaturation: TLabel;
    lblluminance: TLabel;
    pixeloffsetedit: TJvSpinEdit;
    Label7: TLabel;
    compensate43edit: TJvSpinEdit;
    Label9: TLabel;
    AutoSaturationCheck: TCheckBox;
    Timer2: TTimer;
    fadingcheck: TCheckBox;
    fadingspeededit: TJvSpinEdit;
    Label8: TLabel;
    compensate169: TCheckBox;
    Label16: TLabel;
    Label18: TLabel;
    MaxSaturation: TJvSpinEdit;
    ambiareaedit: TJvSpinEdit;
    Label11: TLabel;
    Label10: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    GroupBox6: TGroupBox;
    PaintBox1: TPaintBox;
    Timer3: TTimer;
    Image2: TImage;
    Image3: TImage;
    Label21: TLabel;
    PaintBox2: TPaintBox;
    Panel1: TPanel;
    Image1: TImage;
    GroupBox5: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    timerintervaledit: TJvSpinEdit;
    startaddressedit: TJvSpinEdit;
    Button1: TButton;
    Bevel1: TBevel;
    GroupBox7: TGroupBox;
    Panel2: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    OKBtn: TButton;
    devbox0: TListBox;
    devbox2: TListBox;
    devbox1: TListBox;
    devbox3: TListBox;
    devbox4: TListBox;
    add4: TPngBitBtn;
    rem4: TPngBitBtn;
    rem1: TPngBitBtn;
    add1: TPngBitBtn;
    rem0: TPngBitBtn;
    add0: TPngBitBtn;
    rem3: TPngBitBtn;
    add3: TPngBitBtn;
    rem2: TPngBitBtn;
    add2: TPngBitBtn;
    Shape3: TShape;
    Button2: TButton;
    sendtodatain: TCheckBox;
    autoon: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure sliderrChange(Sender: TObject);
    procedure slidersaturationChange(Sender: TObject);
    procedure slidergChange(Sender: TObject);
    procedure sliderbChange(Sender: TObject);
    procedure sliderbrightnessChange(Sender: TObject);
    procedure sliderluminanceChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure fadingcheckMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure timerintervaleditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AutoSaturationCheckMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Timer3Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKBtnClick(Sender: TObject);
    procedure add0Click(Sender: TObject);
    procedure rem0Click(Sender: TObject);
    procedure rem1Click(Sender: TObject);
    procedure rem2Click(Sender: TObject);
    procedure rem3Click(Sender: TObject);
    procedure rem4Click(Sender: TObject);
    procedure add1Click(Sender: TObject);
    procedure add2Click(Sender: TObject);
    procedure add3Click(Sender: TObject);
    procedure add4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
  private
    { Private-Deklarationen }
    Screenshot: TBitmap32;
    RGBValues:array[0..4] of array[0..2] of byte;
    RGBSollwertValues:array[0..4] of array[0..2] of byte;
    PreviewBuffer:TBitmap;
    procedure RefreshPreview;
    procedure SendValues;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure AddAmbilightDevice(Position:integer);
    procedure DeleteCurrentAmbilightDevice(Position:integer);
    procedure GetScreenShot(Position:integer; Bmp: TBitmap32);
    procedure CalculateAmbilight(Position: integer);
  public
    { Public-Deklarationen }
    procedure RefreshListboxes;
  end;

var
  ambilightform: Tambilightform;

implementation

uses pcdimmer, geraetesteuerungfrm, adddevicetogroupfrm;

{$R *.dfm}

procedure TColor2RGB(const Color: TColor; var R, G, B: Byte);
begin
  // convert hexa-decimal values to RGB
  R := Color and $FF;
  G := (Color shr 8) and $FF;
  B := (Color shr 16) and $FF;
end;

function RGB2TColor(const R, G, B: Byte): Integer;
begin
  // convert hexa-decimal values to RGB
  Result := R + G shl 8 + B shl 16;
end;

procedure Tambilightform.GetScreenShot(Position: integer; Bmp: TBitmap32);
var
  breite,hoehe, Bottom, Right, Xmove, Ymove: integer;
  DC : HDC;
  hWin : Cardinal;
  SideOffset,TopBottomOffset,PixelOffset,AmbiArea:integer;
const
  CAPTUREBLT = $40000000;
begin
  hWin := GetDesktopWindow;
  DC := GetDC(hWin);
  breite := GetDeviceCaps(DC, HORZRES);
  hoehe := GetDeviceCaps(DC, VERTRES);

  SideOffset:=0;
  TopBottomOffset:=0;
  if compensate43.checked then
    SideOffset:=round(compensate43edit.value);
  if compensate169.checked then
    TopBottomOffset:=round(compensate43edit.value);

  AmbiArea:=round(ambiareaedit.value);

  try
    Right:=AmbiArea;
    Bottom:=AmbiArea;
    Xmove:=0;
    Ymove:=0;
    PixelOffset:=round(PixelOffsetEdit.value);

    case Position of
      0: // Middle
      begin
        Bottom:=2*AmbiArea;
        Right:=3*AmbiArea;
        Xmove:=(breite div 2)-(Right div 2);
        Ymove:=(hoehe div 2)-(Bottom div 2);
      end;
      1: // Left
      begin
        Bottom:=hoehe-2*PixelOffset-TopBottomOffset;
        Right:=AmbiArea;
        Xmove:=PixelOffset+SideOffset;
        Ymove:=PixelOffset+(TopBottomOffset div 2);
      end;
      2: // Top
      begin
        Bottom:=AmbiArea;
        Right:=breite-2*AmbiArea-2*PixelOffset-2*SideOffset;
        Xmove:=AmbiArea+PixelOffset+SideOffset;
        Ymove:=PixelOffset+TopBottomOffset;
      end;
      3: // Right
      begin
        Bottom:=hoehe-2*PixelOffset-TopBottomOffset;
        Right:=AmbiArea;
        Xmove:=breite-AmbiArea-PixelOffset-SideOffset;
        Ymove:=PixelOffset+(TopBottomOffset div 2);
      end;
      4: // Bottom
      begin
        Bottom:=AmbiArea;
        Right:=breite-2*AmbiArea-2*PixelOffset-2*SideOffset;
        Xmove:=AmbiArea+PixelOffset+SideOffset;
        Ymove:=hoehe-AmbiArea-PixelOffset-TopBottomOffset;
      end;
    end;

    Bmp.Width := Right;
    Bmp.Height := Bottom;

    BitBlt(Bmp.Canvas.Handle,
           0,
           0,
           Right,
           Bottom,
           DC,
           Xmove,
           Ymove,
           SRCCOPY or CAPTUREBLT) ;
  finally
    ReleaseDC(hWin, DC) ;
  end;
end;

procedure Tambilightform.CalculateAmbilight(Position: integer);
var
  Color: TColor32;
  x, y, i, end_r, end_g, end_b, pixelcount, teiler: integer;
  ColorArray_r: array of integer;
  ColorArray_g: array of integer;
  ColorArray_b: array of integer;

  Hue, Luminance, Saturation:Word;
  EndColor:TColor;
  r,g,b:byte;
  MaximumFound:boolean;
  SaturationFactor:Single;
begin
  GetScreenShot(Position, Screenshot);
//  Image1.Picture.Bitmap.Assign(Screenshot);

  SetLength(ColorArray_r, (Screenshot.Width * Screenshot.Height));
  SetLength(ColorArray_g, (Screenshot.Width * Screenshot.Height));
  SetLength(ColorArray_b, (Screenshot.Width * Screenshot.Height));

  end_r := 0;
  end_g := 0;
  end_b := 0;
  pixelcount := 0;
  teiler := 0;

  for i := 0 to high(ColorArray_r) do
  begin
    ColorArray_r[i] := 0;
    ColorArray_g[i] := 0;
    ColorArray_b[i] := 0;
  end;

  for y := 0 to Screenshot.Height - 1 do
  begin
    for x := 0 to Screenshot.Width - 1 do
    begin
      Color := WinColor(Screenshot.Pixel[x, y]);
      ColorArray_r[pixelcount] := GetRValue(Color);
      ColorArray_g[pixelcount] := GetGValue(Color);
      ColorArray_b[pixelcount] := GetBValue(Color);
      inc(pixelcount);
    end;
  end;

  for i := 0 to high(ColorArray_r) do
  begin
    if (ColorArray_r[i] >= 0) and (ColorArray_g[i] >= 0) and (ColorArray_b[i] >= 0) then
      if (ColorArray_r[i] <= 255) and (ColorArray_g[i] <= 255) and (ColorArray_b[i] <= 255) then
      begin
        inc(teiler);
        end_r := end_r + ColorArray_r[i];
        end_g := end_g + ColorArray_g[i];
        end_b := end_b + ColorArray_b[i];
      end;
  end;

  // Endwerte berechnen
  end_r := round(end_r div teiler);
  end_g := round(end_g div teiler);
  end_b := round(end_b div teiler);



  // Ab hier Farbfilterkorrekturen
  // ========================================

  // Für Sättigungskorrektur entsprechend HSL-Werte erzeugen
  ColorRGBToHLS(RGB(end_r, end_g, end_b), Hue, Luminance, Saturation);

  // Luminanz nachstellen
  if round(Luminance*((255-sliderluminance.position)/128))>65535 then
    Luminance:=65535
  else
    if round(Luminance*((255-sliderluminance.position)/128))<0 then
      Luminance:=0
    else
      Luminance:=round(Luminance*((255-sliderluminance.position)/128));

  // Sättigung einstellen
  if AutoSaturationCheck.checked then
  begin
    // Sättigung automatisch maximieren
    MaximumFound:=false;
    SaturationFactor:=1.0;
    repeat
      TColor2RGB(ColorHLSToRGB(Hue, Luminance, round(Saturation*SaturationFactor)),r,g,b);

      SaturationFactor:=SaturationFactor+0.01;
      TColor2RGB(ColorHLSToRGB(Hue, Luminance, round(Saturation*SaturationFactor)),r,g,b);

      if (r=255) or (g=255) or (b=255) or (SaturationFactor>(MaxSaturation.value / 100)) then
      begin
        SaturationFactor:=SaturationFactor-0.01;
        MaximumFound:=true;
      end;
    until (MaximumFound=true);
    if ambilightform.Showing then
    begin
      if position=0 then
      begin
        lblsaturation.caption:=inttostr(round(SaturationFactor*100))+'%';
        slidersaturation.position:=round(512-((SaturationFactor*100-0)+128));
      end;
    end;
    Saturation:=round(Saturation*SaturationFactor);
  end else
  begin
    if round(Saturation*((512-slidersaturation.position)/128))>65535 then
      Saturation:=65535
    else
      if round(Saturation*((512-slidersaturation.position)/128))<0 then
        Saturation:=0
      else
        Saturation:=round(Saturation*((512-slidersaturation.position)/128));
  end;

  EndColor:=ColorHLSToRGB(Hue, Luminance, Saturation);
  TColor2RGB(EndColor,r,g,b);

  // RGB-Werte korrigieren, Helligkeit anpassen und ins Sollwert-Array schreiben
  RGBSollwertValues[Position][0]:=round(((255-sliderbrightness.position)/255)*r*((255-sliderr.position)/255));
  RGBSollwertValues[Position][1]:=round(((255-sliderbrightness.position)/255)*g*((255-sliderg.position)/255));
  RGBSollwertValues[Position][2]:=round(((255-sliderbrightness.position)/255)*b*((255-sliderb.position)/255));
end;

procedure Tambilightform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  Screenshot := TBitmap32.Create;

  PreviewBuffer := TBitmap.Create;
  PreviewBuffer.Width:=Paintbox1.Width;
  PreviewBuffer.Height:=Paintbox1.Height;

  LoadSettings;
end;

procedure Tambilightform.Timer1Timer(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to 4 do
    CalculateAmbilight(i);

  if not fadingcheck.Checked then
  begin
    for i:=0 to 4 do
      for j:=0 to 2 do
        RGBValues[i][j]:=RGBSollwertValues[i][j];

    if ambilightform.showing then
      RefreshPreview;
  end;
  SendValues;
end;

procedure Tambilightform.sliderrChange(Sender: TObject);
begin
  lblr.caption:=inttostr(round(((255-sliderr.position)/2.55)))+'%';
end;

procedure Tambilightform.slidersaturationChange(Sender: TObject);
begin
  lblsaturation.caption:=inttostr(round(((512-slidersaturation.position)/1.28)))+'%';
end;

procedure Tambilightform.sliderluminanceChange(Sender: TObject);
begin
  lblluminance.caption:=inttostr(round(((255-sliderluminance.position)/1.28)))+'%';
end;

procedure Tambilightform.slidergChange(Sender: TObject);
begin
  lblg.caption:=inttostr(round(((255-sliderg.position)/2.55)))+'%';
end;

procedure Tambilightform.sliderbChange(Sender: TObject);
begin
  lblb.caption:=inttostr(round(((255-sliderb.position)/2.55)))+'%';
end;

procedure Tambilightform.sliderbrightnessChange(Sender: TObject);
begin
  lblbrightness.caption:=inttostr(round(((255-sliderbrightness.position)/2.55)))+'%';
end;

procedure Tambilightform.Button1Click(Sender: TObject);
begin
  sliderr.position:=0;
  sliderg.position:=0;
  sliderb.position:=0;
  sliderbrightness.position:=0;
  slidersaturation.position:=384;
  sliderluminance.position:=127;
end;

procedure Tambilightform.Timer2Timer(Sender: TObject);
var
  i,j:integer;
  Steps:integer;
begin
  for i:=0 to 4 do
  begin
    for j:=0 to 2 do
    begin
      Steps:=0;
      if RGBSollwertValues[i][j]<RGBValues[i][j] then
      begin
        Steps:=RGBSollwertValues[i][j]-RGBValues[i][j];
      end else if RGBSollwertValues[i][j]>RGBValues[i][j] then
      begin
        Steps:=RGBSollwertValues[i][j]-RGBValues[i][j];
      end;

      if ((Steps div round(fadingspeededit.value))=0) then
        RGBValues[i][j]:=RGBSollwertValues[i][j]
      else
        RGBValues[i][j]:=RGBValues[i][j]+(Steps div round(fadingspeededit.value));
    end;
  end;
  RefreshPreview;
end;

procedure Tambilightform.fadingcheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Timer2.Enabled:=fadingcheck.checked;
end;

procedure Tambilightform.timerintervaleditChange(Sender: TObject);
begin
  Timer1.Interval:=round(timerintervaledit.Value);
end;

procedure Tambilightform.FormShow(Sender: TObject);
begin
  Timer2.enabled:=true;
  Timer3.enabled:=true;
  RefreshListboxes;

  if not Timer1.Enabled then
  begin
    if messagedlg(_('Möchten Sie das Ambilight einschalten?'),mtConfirmation,
    [mbYes,mbNo],0)=mrYes then
    begin
      Button2Click(nil);
    end;
  end;
end;

procedure Tambilightform.AutoSaturationCheckMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  slidersaturation.Enabled:=not AutoSaturationCheck.Checked;
  label5.enabled:=slidersaturation.Enabled;
  lblsaturation.Enabled:=slidersaturation.Enabled;
  if not AutoSaturationCheck.Checked then
    lblsaturation.Caption:=inttostr(round((512-slidersaturation.position)/1.28))+'%';
end;

procedure Tambilightform.Timer3Timer(Sender: TObject);
var
  MonitorType:byte;
  Pixelfaktor:Single;
  PixelOffset, Bereichsbreite, Offset169, Offset43:integer;
  postop,posbottom,posleft,posright:integer;
begin
  PreviewBuffer.Canvas.Pen.Style:=psSolid;

  // Testen welches Monitorformat
  MonitorType:=0;
  PixelFaktor:=1;
  if (Monitor.Width*(10/16)=Monitor.Height) then
  begin
    MonitorType:=4;
    label21.caption:='16:10';
    PixelFaktor:=PreviewBuffer.Width/Monitor.Width;
  end;
  if (Monitor.Width*(9/16)=Monitor.Height) then
  begin
    MonitorType:=3;
    label21.caption:='16:9';
    PixelFaktor:=PreviewBuffer.Width/Monitor.Width;
  end;
  if (Monitor.Width*(4/5)=Monitor.Height) then
  begin
    MonitorType:=2;
    label21.caption:='5:4';
    PixelFaktor:=PreviewBuffer.Height/Monitor.Height;
  end;
  if (Monitor.Width*(3/4)=Monitor.Height) then
  begin
    MonitorType:=1;
    label21.caption:='4:3';
    PixelFaktor:=PreviewBuffer.Width/Monitor.Width;
  end;
  if MonitorType=0 then
    label21.caption:='???';

  // Werte aus GUI laden
  PixelOffset:=round(pixeloffsetedit.value*PixelFaktor);
  Bereichsbreite:=round(ambiareaedit.value*PixelFaktor);
  if compensate169.Checked then
    Offset169:=round(compensate43edit.value*PixelFaktor) // oben/unten
  else
    Offset169:=0;
  if compensate43.checked then
    Offset43:=round(compensate43edit.value*PixelFaktor) // links/rechts
  else
    Offset43:=0;

  PreviewBuffer.Canvas.Brush.Color:=clBlack;
  PreviewBuffer.Canvas.Pen.Color:=clBlack;
  PreviewBuffer.Canvas.Rectangle(0, 0, PreviewBuffer.Width, PreviewBuffer.Height);
  PreviewBuffer.Canvas.Brush.Color:=clNavy;
  case MonitorType of
    1:
    begin
      PreviewBuffer.Canvas.Rectangle(0, 0, PreviewBuffer.Width, PreviewBuffer.Height); //4:3

      PreviewBuffer.Canvas.Pen.Style:=psclear;
      PreviewBuffer.Canvas.Brush.Color:=clYellow;

      // Top
      posleft:=Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      postop:=(PreviewBuffer.Height-round((PreviewBuffer.Width*(3/4))))+PixelOffset+Offset169;
      posbottom:=postop+Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Bottom
      posleft:=Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      posbottom:=round(PreviewBuffer.Width*(3/4))-PixelOffset-Offset169;
      postop:=posbottom-Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Left
      posleft:=Offset43+PixelOffset;
      posright:=posleft+Bereichsbreite;
      postop:=PreviewBuffer.Height-round(PreviewBuffer.Width*(3/4))+PixelOffset+Offset169;
      posbottom:=round(PreviewBuffer.Width*(3/4))-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Right
      posleft:=PreviewBuffer.Width-Offset43-PixelOffset-Bereichsbreite;
      posright:=posleft+Bereichsbreite;
      postop:=PreviewBuffer.Height-round(PreviewBuffer.Width*(3/4))+PixelOffset+Offset169;
      posbottom:=round(PreviewBuffer.Width*(3/4))-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Mitte
      posleft:=(PreviewBuffer.Width div 2)-round(1.5*Bereichsbreite);
      posright:=posleft+3*Bereichsbreite;
      postop:=(PreviewBuffer.Height div 2)-Bereichsbreite;
      posbottom:=postop+2*Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);
    end;
    2:
    begin
      PreviewBuffer.Canvas.Rectangle((PreviewBuffer.Width-round(PreviewBuffer.Height*(5/4))), 0, round(PreviewBuffer.Height*(5/4)), PreviewBuffer.Height); //5:4

      PreviewBuffer.Canvas.Pen.Style:=psclear;
      PreviewBuffer.Canvas.Brush.Color:=clYellow;

      // Top
      posleft:=(PreviewBuffer.Width-round(PreviewBuffer.Height*(5/4)))+Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      postop:=PixelOffset+Offset169;
      posbottom:=postop+Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Bottom
      posleft:=(PreviewBuffer.Width-round(PreviewBuffer.Height*(5/4)))+Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      posbottom:=PreviewBuffer.Height-PixelOffset-Offset169;
      postop:=posbottom-Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Left
      posleft:=(PreviewBuffer.Width-round(PreviewBuffer.Height*(5/4)))+Offset43+PixelOffset;
      posright:=posleft+Bereichsbreite;
      postop:=PixelOffset+Offset169;
      posbottom:=PreviewBuffer.Height-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Right
      posleft:=round(PreviewBuffer.Height*(5/4))-Offset43-PixelOffset-Bereichsbreite;
      posright:=posleft+Bereichsbreite;
      postop:=PixelOffset+Offset169;
      posbottom:=PreviewBuffer.Height-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Mitte
      posleft:=(PreviewBuffer.Width div 2)-round(1.5*Bereichsbreite);
      posright:=posleft+3*Bereichsbreite;
      postop:=(PreviewBuffer.Height div 2)-Bereichsbreite;
      posbottom:=postop+2*Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);
    end;
    3:
    begin
      PreviewBuffer.Canvas.Rectangle(0, (PreviewBuffer.Height-round((PreviewBuffer.Width*(9/16)))), PreviewBuffer.Width, round(PreviewBuffer.Width*(9/16))); //16:9


      PreviewBuffer.Canvas.Pen.Style:=psclear;
      PreviewBuffer.Canvas.Brush.Color:=clYellow;

      // Top
      posleft:=Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      postop:=(PreviewBuffer.Height-round((PreviewBuffer.Width*(9/16))))+PixelOffset+Offset169;
      posbottom:=postop+Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Bottom
      posleft:=Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      posbottom:=round(PreviewBuffer.Width*(9/16))-PixelOffset-Offset169;
      postop:=posbottom-Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Left
      posleft:=Offset43+PixelOffset;
      posright:=posleft+Bereichsbreite;
      postop:=PreviewBuffer.Height-round(PreviewBuffer.Width*(9/16))+PixelOffset+Offset169;
      posbottom:=round(PreviewBuffer.Width*(9/16))-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Right
      posleft:=PreviewBuffer.Width-Offset43-PixelOffset-Bereichsbreite;
      posright:=posleft+Bereichsbreite;
      postop:=PreviewBuffer.Height-round(PreviewBuffer.Width*(9/16))+PixelOffset+Offset169;
      posbottom:=round(PreviewBuffer.Width*(9/16))-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Mitte
      posleft:=(PreviewBuffer.Width div 2)-round(1.5*Bereichsbreite);
      posright:=posleft+3*Bereichsbreite;
      postop:=(PreviewBuffer.Height div 2)-Bereichsbreite;
      posbottom:=postop+2*Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);
    end;
    4:
    begin
      PreviewBuffer.Canvas.Rectangle(0, (PreviewBuffer.Height-round((PreviewBuffer.Width*(10/16)))), PreviewBuffer.Width, round(PreviewBuffer.Width*(10/16))); //16:10

      PreviewBuffer.Canvas.Pen.Style:=psclear;
      PreviewBuffer.Canvas.Brush.Color:=clYellow;

      // Top
      posleft:=Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      postop:=(PreviewBuffer.Height-round((PreviewBuffer.Width*(10/16))))+PixelOffset+Offset169;
      posbottom:=postop+Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Bottom
      posleft:=Offset43+PixelOffset+Bereichsbreite;
      posright:=PreviewBuffer.Width-posleft;
      posbottom:=round(PreviewBuffer.Width*(10/16))-PixelOffset-Offset169;
      postop:=posbottom-Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Left
      posleft:=Offset43+PixelOffset;
      posright:=posleft+Bereichsbreite;
      postop:=PreviewBuffer.Height-round(PreviewBuffer.Width*(10/16))+PixelOffset+Offset169;
      posbottom:=round(PreviewBuffer.Width*(10/16))-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Right
      posleft:=PreviewBuffer.Width-Offset43-PixelOffset-Bereichsbreite;
      posright:=posleft+Bereichsbreite;
      postop:=PreviewBuffer.Height-round(PreviewBuffer.Width*(10/16))+PixelOffset+Offset169;
      posbottom:=round(PreviewBuffer.Width*(10/16))-PixelOffset-Offset169;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);

      // Mitte
      posleft:=(PreviewBuffer.Width div 2)-round(1.5*Bereichsbreite);
      posright:=posleft+3*Bereichsbreite;
      postop:=(PreviewBuffer.Height div 2)-Bereichsbreite;
      posbottom:=postop+2*Bereichsbreite;
      PreviewBuffer.Canvas.Rectangle(posleft, postop, posright, posbottom);
    end;
  end;

  BitBlt(Paintbox1.Canvas.Handle, 0, 0, Paintbox1.Width, Paintbox1.Height, PreviewBuffer.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure Tambilightform.FormDestroy(Sender: TObject);
begin
  Screenshot.Free;
  PreviewBuffer.Free;
end;

procedure Tambilightform.FormHide(Sender: TObject);
begin
  Timer2.enabled:=false;
  Timer3.enabled:=false;
end;

procedure Tambilightform.RefreshPreview;
begin
  // GUI aktualisieren
  PreviewBuffer.Canvas.Pen.Style:=psClear;

  // Middle
  PreviewBuffer.Canvas.Brush.Color:=RGB2TColor(RGBValues[0][0], RGBValues[0][1], RGBValues[0][2]);
  PreviewBuffer.Canvas.Rectangle(33, 25, 88+33, 64+25);

  // Left
  PreviewBuffer.Canvas.Brush.Color:=RGB2TColor(RGBValues[1][0], RGBValues[1][1], RGBValues[1][2]);
  PreviewBuffer.Canvas.Rectangle(0, 25, 34, PreviewBuffer.Height-25);

  // Top
  PreviewBuffer.Canvas.Brush.Color:=RGB2TColor(RGBValues[2][0], RGBValues[2][1], RGBValues[2][2]);
  PreviewBuffer.Canvas.Rectangle(0, 0, PreviewBuffer.Width+1, 26);

  // Right
  PreviewBuffer.Canvas.Brush.Color:=RGB2TColor(RGBValues[3][0], RGBValues[3][1], RGBValues[3][2]);
  PreviewBuffer.Canvas.Rectangle(PreviewBuffer.Width-33, 25, PreviewBuffer.Width+1, PreviewBuffer.Height-25);

  // Bottom
  PreviewBuffer.Canvas.Brush.Color:=RGB2TColor(RGBValues[4][0], RGBValues[4][1], RGBValues[4][2]);
  PreviewBuffer.Canvas.Rectangle(0, PreviewBuffer.Height-26, PreviewBuffer.Width+1, PreviewBuffer.Height+1);

  BitBlt(Paintbox2.Canvas.Handle, 0, 0, Paintbox2.Width+1, Paintbox2.Height, PreviewBuffer.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure Tambilightform.SendValues;
var
  i,j:integer;
  fadetime:integer;
begin
  if fadingcheck.Checked then
    fadetime:=50*round(fadingspeededit.value)
  else
    fadetime:=0;

  for i:=0 to length(mainform.ambilights)-1 do
  begin
    for j:=0 to length(mainform.ambilights[i])-1 do
    begin
      geraetesteuerung.set_channel(mainform.ambilights[i][j], 'R', -1, RGBSollwertValues[i][0], fadetime);
      geraetesteuerung.set_channel(mainform.ambilights[i][j], 'G', -1, RGBSollwertValues[i][1], fadetime);
      geraetesteuerung.set_channel(mainform.ambilights[i][j], 'B', -1, RGBSollwertValues[i][2], fadetime);
    end;

    if sendtodatain.Checked then
    begin
      mainform.ExecuteDataInEvent(round(startaddressedit.value)+i*3, RGBSollwertValues[i][0]);
      mainform.ExecuteDataInEvent(round(startaddressedit.value)+i*3+1, RGBSollwertValues[i][1]);
      mainform.ExecuteDataInEvent(round(startaddressedit.value)+i*3+2, RGBSollwertValues[i][2]);
    end;
  end;
end;

procedure Tambilightform.SaveSettings;
var
  LReg:TRegistry;
begin
  LReg:=TRegistry.Create;
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
        if not LReg.KeyExists('Ambilight') then
          LReg.CreateKey('Ambilight');
        if LReg.OpenKey('Ambilight',true) then
        begin
          LReg.WriteInteger('R',sliderr.Position);
          LReg.WriteInteger('G',sliderg.Position);
          LReg.WriteInteger('B',sliderb.Position);
          LReg.WriteInteger('H',sliderbrightness.Position);
          LReg.WriteInteger('S',slidersaturation.Position);
          LReg.WriteInteger('L',sliderluminance.Position);
          LReg.WriteInteger('Pixels for compensation',round(compensate43edit.value));
          LReg.WriteInteger('Pixels from frame',round(pixeloffsetedit.Value));
          LReg.WriteInteger('Scanwidth',round(ambiareaedit.Value));
          LReg.WriteInteger('Maximum saturation',round(MaxSaturation.Value));
          LReg.WriteInteger('Blenddamping',round(fadingspeededit.Value));
          LReg.WriteInteger('Timer interval',round(timerintervaledit.Value));
          LReg.WriteInteger('Startchannel',round(startaddressedit.Value));
          LReg.WriteBool('Compensate 4:3 Video',compensate43.checked);
          LReg.WriteBool('Compensate 16:9 Video',compensate169.checked);
          LReg.WriteBool('Send Values to DataIN',sendtodatain.checked);
          LReg.WriteBool('Auto activate',autoon.checked);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Tambilightform.LoadSettings;
var
  LReg:TRegistry;
begin
  LReg:=TRegistry.Create;
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
        if not LReg.KeyExists('Ambilight') then
          LReg.CreateKey('Ambilight');
        if LReg.OpenKey('Ambilight',true) then
        begin
          if LReg.ValueExists('R') then
            sliderr.Position:=LReg.ReadInteger('R');
          if LReg.ValueExists('G') then
            sliderg.Position:=LReg.ReadInteger('G');
          if LReg.ValueExists('B') then
            sliderb.Position:=LReg.ReadInteger('B');
          if LReg.ValueExists('H') then
            sliderbrightness.Position:=LReg.ReadInteger('H');
          if LReg.ValueExists('S') then
            slidersaturation.Position:=LReg.ReadInteger('S');
          if LReg.ValueExists('L') then
            sliderluminance.Position:=LReg.ReadInteger('L');
          if LReg.ValueExists('Pixels for compensation') then
            compensate43edit.value:=LReg.ReadInteger('Pixels for compensation');
          if LReg.ValueExists('Pixels from frame') then
            pixeloffsetedit.Value:=LReg.ReadInteger('Pixels from frame',);
          if LReg.ValueExists('Scanwidth') then
            ambiareaedit.Value:=LReg.ReadInteger('Scanwidth');
          if LReg.ValueExists('Maximum saturation') then
            MaxSaturation.Value:=LReg.ReadInteger('Maximum saturation');
          if LReg.ValueExists('Blenddamping') then
            fadingspeededit.Value:=LReg.ReadInteger('Blenddamping');
          if LReg.ValueExists('Timer interval') then
            timerintervaledit.Value:=LReg.ReadInteger('Timer interval');
          if LReg.ValueExists('Startchannel') then
            startaddressedit.Value:=LReg.ReadInteger('Startchannel');
          if LReg.ValueExists('Compensate 4:3 Video') then
            compensate43.checked:=LReg.ReadBool('Compensate 4:3 Video');
          if LReg.ValueExists('Compensate 16:9 Video') then
            compensate169.checked:=LReg.ReadBool('Compensate 16:9 Video');
          if LReg.ValueExists('Send Values to DataIN') then
            sendtodatain.checked:=LReg.ReadBool('Send Values to DataIN');
          if LReg.ValueExists('Auto activate') then
            autoon.checked:=LReg.ReadBool('Auto activate');

          if autoon.Checked and (Timer1.enabled=false) then
            Button2Click(nil);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Tambilightform.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveSettings;
end;

procedure Tambilightform.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure Tambilightform.RefreshListboxes;
var
  i,j:integer;
begin
  devbox0.Items.Clear;
  devbox1.Items.Clear;
  devbox2.Items.Clear;
  devbox3.Items.Clear;
  devbox4.Items.Clear;

  for i:=0 to length(mainform.ambilights)-1 do
    for j:=0 to length(mainform.ambilights[i])-1 do
      TListbox(FindComponent('devbox'+inttostr(i))).Items.Add(mainform.devices[geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.ambilights[i][j])].Name);
end;

procedure Tambilightform.add0Click(Sender: TObject);
begin
  AddAmbilightDevice(0);
end;

procedure Tambilightform.rem0Click(Sender: TObject);
begin
  DeleteCurrentAmbilightDevice(0);
end;

procedure Tambilightform.AddAmbilightDevice(Position:integer);
var
  i,j:integer;
  vorhanden:boolean;
begin
  adddevicetogroupform.showmodal;

  if adddevicetogroupform.modalresult=mrOK then
  begin
    for i:=0 to length(mainform.devices)-1 do
    begin
      if adddevicetogroupform.listbox1.Selected[i] then
      begin
        vorhanden:=false;
        for j:=0 to length(mainform.ambilights[Position])-1 do
        begin
          if IsEqualGUID(mainform.devices[i].ID,mainform.ambilights[Position][j]) then
          begin
            vorhanden:=true;
            break;
          end;
        end;
        if not vorhanden then
        begin
          setlength(mainform.ambilights[Position],length(mainform.ambilights[Position])+1);
          mainform.ambilights[Position][length(mainform.ambilights[Position])-1]:=mainform.devices[i].ID;
        end;
      end;
    end;
    RefreshListboxes;
  end;
end;

procedure Tambilightform.DeleteCurrentAmbilightDevice(Position:integer);
var
  i:integer;
begin
  if TListbox(FindComponent('devbox'+inttostr(Position))).ItemIndex>-1 then
  begin
    for i:=TListbox(FindComponent('devbox'+inttostr(Position))).ItemIndex to length(mainform.ambilights[Position])-2 do
      mainform.ambilights[Position][i]:=mainform.ambilights[Position][i+1];

    setlength(mainform.ambilights[Position],length(mainform.ambilights[Position])-1);
    RefreshListboxes;
  end;
end;


procedure Tambilightform.rem1Click(Sender: TObject);
begin
  DeleteCurrentAmbilightDevice(1);
end;

procedure Tambilightform.rem2Click(Sender: TObject);
begin
  DeleteCurrentAmbilightDevice(2);
end;

procedure Tambilightform.rem3Click(Sender: TObject);
begin
  DeleteCurrentAmbilightDevice(3);
end;

procedure Tambilightform.rem4Click(Sender: TObject);
begin
  DeleteCurrentAmbilightDevice(4);
end;

procedure Tambilightform.add1Click(Sender: TObject);
begin
  AddAmbilightDevice(1);
end;

procedure Tambilightform.add2Click(Sender: TObject);
begin
  AddAmbilightDevice(2);
end;

procedure Tambilightform.add3Click(Sender: TObject);
begin
  AddAmbilightDevice(3);
end;

procedure Tambilightform.add4Click(Sender: TObject);
begin
  AddAmbilightDevice(4);
end;

procedure Tambilightform.Button2Click(Sender: TObject);
var
  LReg:TRegistry;
begin
  if Timer1.enabled then
  begin
    Timer1.enabled:=false;
    Button2.Caption:=_('Ambilight einschalten');
  end else
  begin
    Timer1.enabled:=true;
    Button2.Caption:=_('Ambilight ausschalten');
  end;

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
        LReg.WriteBool('Ambilight active',Timer1.enabled);
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tambilightform.CreateParams(var Params:TCreateParams);
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

end.
