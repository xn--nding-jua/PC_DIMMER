unit leistungssteuerungfrm2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, StdCtrls, TiledImage, Buttons, GR32,
  PngSpeedButton, Mask, JvExMask, JvSpin, gnugettext, PngImageList,
  dxGDIPlusClasses, JvExControls, JvLabel;

const
  SmallWidth=15;
  SmallHeight=55;
  HugeWidth=282;
  HugeHeight=629;

type
  Tleistungssteuerungform2 = class(TForm)
    Image3: TImage;
    Shape1: TShape;
    Shape2: TShape;
    TiledImage1: TTiledImage;
    Timer1: TTimer;
    PngSpeedButton1: TPngSpeedButton;
    Timer2: TTimer;
    JvSpinEdit1: TJvSpinEdit;
    Label1: TLabel;
    JvSpinEdit2: TJvSpinEdit;
    Label2: TLabel;
    PaintBox1: TPaintBox;
    pngimages: TPngImageCollection;
    Image2: TImage;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure JvSpinEdit2Change(Sender: TObject);
    procedure PngSpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private-Deklarationen }
    timer:byte;
    power:array[0..11] of integer;
    _Buffer: TBitmap32;
  public
    { Public-Deklarationen }
    maxpower:array[0..11] of integer;
  end;

var
  leistungssteuerungform2: Tleistungssteuerungform2;

implementation

uses PCDIMMER, geraetesteuerungfrm;

{$R *.dfm}

procedure Tleistungssteuerungform2.Timer1Timer(Sender: TObject);
begin
  if timer>=5 then
  begin
    Timer1.Enabled:=false;
    timer:=0;
    PngSpeedButton1.Down:=false;
    Timer2.enabled:=false;
    leistungssteuerungform2.ClientWidth:=SmallWidth;
    leistungssteuerungform2.ClientHeight:=SmallHeight;
    leistungssteuerungform2.Left:=screen.Width-leistungssteuerungform2.ClientWidth;
    leistungssteuerungform2.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight;
  end;

  timer:=timer+1;
end;

procedure Tleistungssteuerungform2.FormClick(Sender: TObject);
begin
  if leistungssteuerungform2.ClientWidth=HugeWidth then
  begin
    Timer2.enabled:=false;
    leistungssteuerungform2.ClientWidth:=SmallWidth;
    leistungssteuerungform2.ClientHeight:=SmallHeight;
    PngSpeedButton1.Down:=false;
    Timer1.Enabled:=false;
    timer:=0;
  end else
  begin
    Timer2.enabled:=true;
    leistungssteuerungform2.ClientWidth:=HugeWidth;
    leistungssteuerungform2.ClientHeight:=HugeHeight;
    leistungssteuerungform2.BringToFront;
  end;

  leistungssteuerungform2.Left:=screen.Width-leistungssteuerungform2.ClientWidth;
  leistungssteuerungform2.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight;
end;

procedure Tleistungssteuerungform2.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer2.enabled:=true;
  Timer1.Enabled:=not PngSpeedButton1.Down;
  timer:=0;
  leistungssteuerungform2.ClientWidth:=HugeWidth;
  leistungssteuerungform2.ClientHeight:=HugeHeight;
  leistungssteuerungform2.BringToFront;

  if (Shift=[]) and (not PngSpeedButton1.Down) then
  begin
    leistungssteuerungform2.Left:=screen.Width-leistungssteuerungform2.ClientWidth;
    leistungssteuerungform2.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight;
  end else
  begin
    PngSpeedButton1.Down:=true;
    ReleaseCapture;
    leistungssteuerungform2.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure Tleistungssteuerungform2.FormShow(Sender: TObject);
begin
  leistungssteuerungform2.Left:=screen.Width-leistungssteuerungform2.ClientWidth;
  leistungssteuerungform2.Top:=mainform.top+mainform.dxRibbon1.height+SmallHeight;

  JvSpinEdit1Change(nil);
end;

procedure Tleistungssteuerungform2.FormCreate(Sender: TObject);
var
  i:integer;
begin
  TranslateComponent(self);

  _Buffer := TBitmap32.Create;
  _Buffer.Width:= PaintBox1.Width;
  _Buffer.Height:= PaintBox1.Height;

  leistungssteuerungform2.ClientWidth:=SmallWidth;
  leistungssteuerungform2.ClientHeight:=SmallHeight;

  for i:=0 to 11 do
  begin
    maxpower[i]:=3680;
  end;
end;

procedure Tleistungssteuerungform2.FormHide(Sender: TObject);
begin
  Timer2.enabled:=false;
end;

procedure Tleistungssteuerungform2.Timer2Timer(Sender: TObject);
var
  i,value1,temp:integer;
  Rect: TRect;
begin
  for i:=0 to 11 do
  begin
    power[i]:=0;
  end;

  for i:=0 to length(mainform.devices)-1 do
  begin
    if mainform.devices[i].UseInPowerdiagram then
    begin
      if mainform.devices[i].AlwaysOn then
      begin
        power[mainform.devices[i].Phase-1]:=power[mainform.devices[i].Phase-1]+mainform.devices[i].Power;
      end else
      begin
        power[mainform.devices[i].Phase-1]:=power[mainform.devices[i].Phase-1]+round(mainform.devices[i].Power*(geraetesteuerung.get_channel(mainform.devices[i].ID, mainform.devices[i].kanaltyp[mainform.devices[i].ChannelForPower])/255));
      end;
    end;
  end;

{
  for i:=0 to 5 do
  begin
    value1:=round((power[i]/maxpower[i])*100);
    TLabel(FindComponent('percent'+inttostr(i+1))).Caption:=inttostr(value1)+'%';
    case value1 of
      0..75:
      begin
        TLabel(FindComponent('percent'+inttostr(i+1))).font.color:=clBlack;
      end;
      76..85:
      begin
        TLabel(FindComponent('percent'+inttostr(i+1))).font.color:=clYellow;
      end;
      86..95:
      begin
        TLabel(FindComponent('percent'+inttostr(i+1))).font.color:=$000080FF;
      end;
      else begin
        TLabel(FindComponent('percent'+inttostr(i+1))).font.color:=clRed;
      end;
    end;

    value1:=8+round((power[i]/maxpower[i])*196);
    value2:=TImage(FindComponent('bar'+inttostr(i+1))).Width;
    if value1<>value2 then
      TImage(FindComponent('bar'+inttostr(i+1))).Width:=value1;
  end;
}
  _Buffer.Canvas.Pen.Style:=psClear;
  _Buffer.Canvas.Brush.Color := clBtnFace;
  _Buffer.Canvas.FillRect(_Buffer.ClipRect);
  for i:=0 to trunc(Paintbox1.Height/21)+1 do
    _Buffer.Canvas.Draw(0,21*i,TiledImage1.Picture.Graphic);

  for i:=0 to 11 do
  begin
    _Buffer.Canvas.Brush.Style:=bsSolid;

    // Prozenz berechnen
    value1:=round((power[i]/maxpower[i])*100);
    case value1 of
      0..75:
      begin
        _Buffer.Canvas.Font.Color:=clBlack;
      end;
      76..85:
      begin
        _Buffer.Canvas.Font.Color:=clYellow;
      end;
      86..95:
      begin
        _Buffer.Canvas.Font.Color:=$000080FF;
      end;
      else begin
        _Buffer.Canvas.Font.Color:=clRed;
      end;
    end;

    // Füllung zeichnen
    Rect.Top:=48*i;
    Rect.Left:=0;
    Rect.Right:=217;
    Rect.Bottom:=48+48*i;
    Rect.TopLeft.X:=0;
    Rect.TopLeft.Y:=48*i;
    Rect.BottomRight.X:=217;
    Rect.BottomRight.Y:=48+48*i;
    pngimages.Items.Items[0].PngImage.Draw(_Buffer.Canvas, Rect);
    _Buffer.Canvas.Brush.Color := clBlack;

    temp:=round((power[i]/maxpower[i])*203)+7;
    if temp>210 then temp:=210;
    _Buffer.Canvas.Rectangle(temp, 48*i+9, 210, 48*i+48-9);

    // Rahmen drüberzeichnen
    pngimages.Items.Items[1].PngImage.Draw(_Buffer.Canvas, Rect);

    // Text ausgeben
    _Buffer.Canvas.Font.Style:=[fsBold];
    _Buffer.Canvas.Brush.Color := clBtnFace;
    _Buffer.Canvas.Brush.Style:=bsClear;
    _Buffer.Canvas.TextOut(217, 16+(i*48), inttostr(value1)+'%');
  end;

  // und das ganze auch natürlich noch zeichnen
  BitBlt(PaintBox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Tleistungssteuerungform2.JvSpinEdit1Change(Sender: TObject);
begin
  JvSpinEdit2.Value:=maxpower[round(JvSpinEdit1.Value)-1];
end;

procedure Tleistungssteuerungform2.JvSpinEdit2Change(Sender: TObject);
begin
  maxpower[round(JvSpinEdit1.Value)-1]:=round(JvSpinEdit2.Value);
end;

procedure Tleistungssteuerungform2.PngSpeedButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormMouseMove(nil, [], 0,0);
end;

procedure Tleistungssteuerungform2.PngSpeedButton1Click(Sender: TObject);
begin
  FormMouseMove(nil, [], 0,0);
end;

procedure Tleistungssteuerungform2.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer2.enabled:=true;
  Timer1.Enabled:=not PngSpeedButton1.Down;
  timer:=0;
end;

end.
