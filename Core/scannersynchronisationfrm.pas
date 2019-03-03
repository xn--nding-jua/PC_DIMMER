unit scannersynchronisationfrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Math, pngimage,
  JvExControls, JvGradient, Buttons, PngBitBtn, Mask, JvExMask, JvSpin,
  Menus, gnugettext;

type
  TRGBTripleArray = array[0..32768] of TRGBTriple;
  // 32768 = maximale Anzahl der Pixel in der Breite eines Bildes (also eine "ScanLine")
  pRGBTripleArray = ^TRGBTripleArray; // Pointer auf TRGBTripleArray

  Tscannersynchronisationform = class(TForm)
    Panel1: TPanel;
    JvGradient1: TJvGradient;
    Image1: TImage;
    Label34: TLabel;
    Label35: TLabel;
    InfoBtn: TPngBitBtn;
    RefreshPaintboxTimer: TTimer;
    Panel2: TPanel;
    Label4: TLabel;
    Bevel3: TBevel;
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
    Label33: TLabel;
    ResetPositions: TButton;
    lox: TJvSpinEdit;
    loy: TJvSpinEdit;
    rox: TJvSpinEdit;
    roy: TJvSpinEdit;
    lux: TJvSpinEdit;
    luy: TJvSpinEdit;
    rux: TJvSpinEdit;
    ruy: TJvSpinEdit;
    CalibrationPointsOutOfBounds: TCheckBox;
    ComboBox1: TComboBox;
    Panel3: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Label18: TLabel;
    Button2: TButton;
    Button3: TButton;
    Panel4: TPanel;
    Paintbox1: TPaintBox;
    PaintBox2: TPaintBox;
    Panel5: TPanel;
    Label17: TLabel;
    ActualSyncEdit: TComboBox;
    Button1: TButton;
    Label3: TLabel;
    AntialiasingCombobox: TComboBox;
    Panel6: TPanel;
    PreviewCheckbox: TCheckBox;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    copybtn: TButton;
    pastebtn: TButton;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RefreshPaintboxTimerTimer(Sender: TObject);
    procedure Paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Antialiasing4x;
    procedure Antialiasing16x;
    procedure PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ResetPositionsClick(Sender: TObject);
    procedure AntialiasingComboboxChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InfoBtnClick(Sender: TObject);
    procedure loxChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CalibrationPointsOutOfBoundsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormHide(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActualSyncEditSelect(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormResize(Sender: TObject);
    procedure copybtnClick(Sender: TObject);
    procedure pastebtnClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
  private
    { Private declarations }
    _Buffer,_BufferAntialiased, _Buffer2,_Buffer2Antialiased:TBitmap;
    A,B,C,D,P:TPoint;
    CopyA,CopyB,CopyC,CopyD:TPoint;
    Pb:TPoint;
    Abok,Bbok,Cbok,Dbok,Pok:boolean;
    antialiasvalue:byte;
    nouserchange:boolean;
  public
    { Public declarations }
    aktuellesgeraet:integer;
  end;

var
  scannersynchronisationform: Tscannersynchronisationform;

implementation

uses geraetesteuerungfrm, PCDIMMER;

{$R *.DFM}

procedure Tscannersynchronisationform.Antialiasing4x;
var
  y,x:integer;
  P1,P2,P3: PByteArray;
begin
    for y := 0 to _BufferAntialiased.Height-1 do
    begin
      P1 := _Buffer.ScanLine[2*y];
      P2 := _Buffer.ScanLine[2*y+1];
      P3 := _BufferAntialiased.ScanLine[y];
      for x := 0 to _BufferAntialiased.Width-1 do
      begin
        P3[x*3] := (P1[2*3*x]+P1[2*3*x+3]+P2[2*3*x]+P2[2*3*x+3]) div 4;
        P3[x*3+1] := (P1[2*3*x+1]+P1[2*3*x+4]+P2[2*3*x+1]+P2[2*3*x+4]) div 4;
        P3[x*3+2] := (P1[2*3*x+2]+P1[2*3*x+5]+P2[2*3*x+2]+P2[2*3*x+5]) div 4;
      end;
    end;
    for y := 0 to _Buffer2Antialiased.Height-1 do
    begin
      P1 := _Buffer2.ScanLine[2*y];
      P2 := _Buffer2.ScanLine[2*y+1];
      P3 := _Buffer2Antialiased.ScanLine[y];
      for x := 0 to _Buffer2Antialiased.Width-1 do
      begin
        P3[x*3] := (P1[2*3*x]+P1[2*3*x+3]+P2[2*3*x]+P2[2*3*x+3]) div 4;
        P3[x*3+1] := (P1[2*3*x+1]+P1[2*3*x+4]+P2[2*3*x+1]+P2[2*3*x+4]) div 4;
        P3[x*3+2] := (P1[2*3*x+2]+P1[2*3*x+5]+P2[2*3*x+2]+P2[2*3*x+5]) div 4;
      end;
    end;
end;

procedure Tscannersynchronisationform.Antialiasing16x;
var
  y,x:integer;
  P1,P2,P3,P4,P5: PByteArray;
begin
      for y := 0 to _BufferAntialiased.Height-1 do
      begin
        P1 := _Buffer.ScanLine[4*y];
        P2 := _Buffer.ScanLine[4*y+1];
        P3 := _Buffer.ScanLine[4*y+2];
        P4 := _Buffer.ScanLine[4*y+3];
        P5 := _BufferAntialiased.ScanLine[y];
        for x := 0 to _BufferAntialiased.Width-1 do
        begin
          P5[x*3] := (P1[4*3*x]+P1[4*3*x+3]+P1[4*3*x+6]+P1[4*3*x+9]+
                      P2[4*3*x]+P2[4*3*x+3]+P2[4*3*x+6]+P2[4*3*x+9]+
                      P3[4*3*x]+P3[4*3*x+3]+P3[4*3*x+6]+P3[4*3*x+9]+
                      P4[4*3*x]+P4[4*3*x+3]+P4[4*3*x+6]+P4[4*3*x+9]) div 16;
          P5[x*3+1] := (P1[4*3*x+1]+P1[4*3*x+4]+P1[4*3*x+7]+P1[4*3*x+10]+
                        P2[4*3*x+1]+P2[4*3*x+4]+P2[4*3*x+7]+P2[4*3*x+10]+
                        P3[4*3*x+1]+P3[4*3*x+4]+P3[4*3*x+7]+P3[4*3*x+10]+
                        P4[4*3*x+1]+P4[4*3*x+4]+P4[4*3*x+7]+P4[4*3*x+10]) div 16;
          P5[x*3+2] := (P1[4*3*x+2]+P1[4*3*x+5]+P1[4*3*x+8]+P1[4*3*x+11]+
                        P2[4*3*x+2]+P2[4*3*x+5]+P2[4*3*x+8]+P2[4*3*x+11]+
                        P3[4*3*x+2]+P3[4*3*x+5]+P3[4*3*x+8]+P3[4*3*x+11]+
                        P4[4*3*x+2]+P4[4*3*x+5]+P4[4*3*x+8]+P4[4*3*x+11]) div 16;
        end;
      end;
      for y := 0 to _Buffer2Antialiased.Height-1 do
      begin
        P1 := _Buffer2.ScanLine[4*y];
        P2 := _Buffer2.ScanLine[4*y+1];
        P3 := _Buffer2.ScanLine[4*y+2];
        P4 := _Buffer2.ScanLine[4*y+3];
        P5 := _Buffer2Antialiased.ScanLine[y];
        for x := 0 to _Buffer2Antialiased.Width-1 do
        begin
          P5[x*3] := (P1[4*3*x]+P1[4*3*x+3]+P1[4*3*x+6]+P1[4*3*x+9]+
                      P2[4*3*x]+P2[4*3*x+3]+P2[4*3*x+6]+P2[4*3*x+9]+
                      P3[4*3*x]+P3[4*3*x+3]+P3[4*3*x+6]+P3[4*3*x+9]+
                      P4[4*3*x]+P4[4*3*x+3]+P4[4*3*x+6]+P4[4*3*x+9]) div 16;
          P5[x*3+1] := (P1[4*3*x+1]+P1[4*3*x+4]+P1[4*3*x+7]+P1[4*3*x+10]+
                        P2[4*3*x+1]+P2[4*3*x+4]+P2[4*3*x+7]+P2[4*3*x+10]+
                        P3[4*3*x+1]+P3[4*3*x+4]+P3[4*3*x+7]+P3[4*3*x+10]+
                        P4[4*3*x+1]+P4[4*3*x+4]+P4[4*3*x+7]+P4[4*3*x+10]) div 16;
          P5[x*3+2] := (P1[4*3*x+2]+P1[4*3*x+5]+P1[4*3*x+8]+P1[4*3*x+11]+
                        P2[4*3*x+2]+P2[4*3*x+5]+P2[4*3*x+8]+P2[4*3*x+11]+
                        P3[4*3*x+2]+P3[4*3*x+5]+P3[4*3*x+8]+P3[4*3*x+11]+
                        P4[4*3*x+2]+P4[4*3*x+5]+P4[4*3*x+8]+P4[4*3*x+11]) div 16;
        end;
      end;
end;

procedure Tscannersynchronisationform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  antialiasvalue:=1;

  _Buffer:=TBitmap.Create;
  _Buffer.PixelFormat := pf24bit;
  _Buffer.Width:=4*Paintbox1.Width;
  _Buffer.Height:=4*Paintbox1.Height;

  _BufferAntialiased := TBitmap.Create;
  _BufferAntialiased.PixelFormat := pf24bit;
  _BufferAntialiased.Width := Paintbox1.Width;
  _BufferAntialiased.Height := Paintbox1.Height;

  _Buffer2:=TBitmap.Create;
  _Buffer2.PixelFormat := pf24bit;
  _Buffer2.Width:=4*Paintbox2.Width;
  _Buffer2.Height:=4*Paintbox2.Height;

  _Buffer2Antialiased := TBitmap.Create;
  _Buffer2Antialiased.PixelFormat := pf24bit;
  _Buffer2Antialiased.Width := Paintbox1.Width;
  _Buffer2Antialiased.Height := Paintbox1.Height;

  P.x:=127;
  P.y:=127;

  A.x:=0;
  A.y:=0;
  B.x:=255;
  B.y:=0;
  C.x:=255;
  C.y:=255;
  D.x:=0;
  D.y:=255;

  if ActualSyncEdit.itemindex >= 0 then
  begin
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x:=64;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y:=64;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x:=196;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y:=64;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x:=196;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y:=196;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x:=64;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y:=196;
  end;
  Pb.x:=127;
  Pb.y:=127;
end;

procedure Tscannersynchronisationform.PaintBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
//  if (Shift=[ssLeft]) then
  begin
    if ((X<=Paintbox2.Width) and (X>=0)) or CalibrationPointsOutOfBounds.Checked then
    begin
      if Abok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x:=trunc((X/Paintbox2.Width)*255);
        lox.Value:=trunc((X/Paintbox2.Width)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PAN',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x,0);
      end;
      if Bbok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x:=trunc((X/Paintbox2.Width)*255);
        rox.Value:=trunc((X/Paintbox2.Width)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PAN',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x,0);
      end;
      if Cbok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x:=trunc((X/Paintbox2.Width)*255);
        rux.Value:=trunc((X/Paintbox2.Width)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PAN',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x,0);
      end;
      if Dbok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x:=trunc((X/Paintbox2.Width)*255);
        lux.Value:=trunc((X/Paintbox2.Width)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PAN',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x,0);
      end;
    end;
    if ((Y<=Paintbox2.Height) and (Y>=0)) or CalibrationPointsOutOfBounds.Checked then
    begin
      if Abok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y:=trunc((Y/Paintbox2.Height)*255);
        loy.Value:=trunc((Y/Paintbox2.Height)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILT',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y,0);
      end;
      if Bbok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y:=trunc((Y/Paintbox2.Height)*255);
        roy.Value:=trunc((Y/Paintbox2.Height)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILT',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y,0);
      end;
      if Cbok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y:=trunc((Y/Paintbox2.Height)*255);
        ruy.Value:=trunc((Y/Paintbox2.Height)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILT',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y,0);
      end;
      if Dbok then
      begin
        mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y:=trunc((Y/Paintbox2.Height)*255);
        luy.Value:=trunc((Y/Paintbox2.Height)*255);
        geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILT',mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y,mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y,0);
      end;
    end;
  end;
end;

procedure Tscannersynchronisationform.RefreshPaintboxTimerTimer(Sender: TObject);
  function ScaleX1(X:integer):integer;
  begin
    result:=trunc((X/255)*Paintbox1.Width);
  end;
  function ScaleY1(Y:integer):integer;
  begin
    result:=trunc((Y/255)*Paintbox1.Height);
  end;
  function ScaleX2(X:integer):integer;
  begin
    result:=trunc((X/255)*Paintbox2.Width);
  end;
  function ScaleY2(Y:integer):integer;
  begin
    result:=trunc((Y/255)*Paintbox2.Height);
  end;
var
  P01x,P01y:single;
  Ab4,Bb4,Cb4,Db4:TPoint;
begin
  // Linkes Fenster zeichnen
  _Buffer.canvas.Pen.Width := antialiasvalue;
  case antialiasvalue of
    1:
    begin
      _Buffer.Canvas.Brush.Color:=clBtnFace;
      _Buffer.Canvas.Pen.Style:=psSolid;
      _Buffer.Canvas.Rectangle(0,0,_Buffer.Width div 4,_Buffer.Height div 4);
      _Buffer.Canvas.Pen.Color:=clBlack;
      _Buffer.Canvas.Brush.Color:=clBlack;
      // Punkt P zeichnen
      _Buffer.Canvas.Ellipse(ScaleX1(P.x*antialiasvalue)-10*antialiasvalue,ScaleY1(P.y*antialiasvalue)-10*antialiasvalue,ScaleX1(P.x*antialiasvalue)+10*antialiasvalue,ScaleY1(P.y*antialiasvalue)+10*antialiasvalue);
      BitBlt(Paintbox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SrcCopy);
    end;
    2:
    begin
      _Buffer.Canvas.Brush.Color:=clBtnFace;
      _Buffer.Canvas.Pen.Style:=psSolid;
      _Buffer.Canvas.Rectangle(0,0,_Buffer.Width div 2,_Buffer.Height div 2);
      _Buffer.Canvas.Pen.Color:=clBlack;
      _Buffer.Canvas.Brush.Color:=clBlack;
      // Punkt P zeichnen
      _Buffer.Canvas.Ellipse(ScaleX1(P.x*antialiasvalue)-10*antialiasvalue,ScaleY1(P.y*antialiasvalue)-10*antialiasvalue,ScaleX1(P.x*antialiasvalue)+10*antialiasvalue,ScaleY1(P.y*antialiasvalue)+10*antialiasvalue);
      Antialiasing4x; // Grafik noch ein wenig Glätten
      BitBlt(Paintbox1.Canvas.Handle,0,0,_BufferAntialiased.Width,_BufferAntialiased.Height,_BufferAntialiased.Canvas.Handle,0,0,SrcCopy);
    end;
    4:
    begin
      _Buffer.Canvas.Brush.Color:=clBtnFace;
      _Buffer.Canvas.Pen.Style:=psSolid;
      _Buffer.Canvas.Rectangle(0,0,_Buffer.Width,_Buffer.Height);
      _Buffer.Canvas.Pen.Color:=clBlack;
      _Buffer.Canvas.Brush.Color:=clBlack;
      // Punkt P zeichnen
      _Buffer.Canvas.Ellipse(ScaleX1(P.x*antialiasvalue)-10*antialiasvalue,ScaleY1(P.y*antialiasvalue)-10*antialiasvalue,ScaleX1(P.x*antialiasvalue)+10*antialiasvalue,ScaleY1(P.y*antialiasvalue)+10*antialiasvalue);
      Antialiasing16x;
      BitBlt(Paintbox1.Canvas.Handle,0,0,_BufferAntialiased.Width,_BufferAntialiased.Height,_BufferAntialiased.Canvas.Handle,0,0,SrcCopy);
    end;
  end;

  begin // Grundkalibrierung
    // Punkt auf der rechten Seite per bilineare Interpolation berechnen
    P01x:=P.x/255;
    P01y:=P.y/255;
    Pb.x:=trunc((1-P01x)*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x+(1-P01x)*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x+P01x*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x+P01x*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x);
    Pb.y:=trunc((1-P01x)*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y+(1-P01x)*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y+P01x*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y+P01x*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y);

    // rechtes Fenster zeichnen
    case antialiasvalue of
      1:
      begin
        _Buffer2.Canvas.Brush.Color:=clInactiveCaption;
        _Buffer2.Canvas.Pen.Color:=clBlack;
        _Buffer2.Canvas.Rectangle(0,0,_Buffer2.Width div 4,_Buffer2.Height div 4);
        _Buffer2.Canvas.Brush.Color:=clBtnFace;
        _Buffer2.Canvas.Pen.Color:=clBlack;
        _Buffer2.Canvas.Brush.Color:=clBtnFace;
        _Buffer2.Canvas.Brush.Style:=bsSolid;
      end;
      2:
      begin
        _Buffer2.Canvas.Brush.Color:=clInactiveCaption;
        _Buffer2.Canvas.Pen.Color:=clBlack;
        _Buffer2.Canvas.Rectangle(0,0,_Buffer2.Width div 2,_Buffer2.Height div 2);
        _Buffer2.Canvas.Brush.Color:=clBtnFace;
        _Buffer2.Canvas.Pen.Color:=clBlack;
        _Buffer2.Canvas.Brush.Color:=clBtnFace;
        _Buffer2.Canvas.Brush.Style:=bsSolid;
      end;
      4:
      begin
        _Buffer2.Canvas.Brush.Color:=clInactiveCaption;
        _Buffer2.Canvas.Pen.Color:=clBlack;
        _Buffer2.Canvas.Rectangle(0,0,_Buffer2.Width,_Buffer2.Height);
        _Buffer2.Canvas.Brush.Color:=clBtnFace;
        _Buffer2.Canvas.Pen.Color:=clBlack;
        _Buffer2.Canvas.Brush.Color:=clBtnFace;
        _Buffer2.Canvas.Brush.Style:=bsSolid;
      end;
    end;

    Ab4.x:=ScaleX2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x*antialiasvalue);
    Ab4.y:=ScaleY2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y*antialiasvalue);
    Bb4.x:=ScaleX2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x*antialiasvalue);
    Bb4.y:=ScaleY2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y*antialiasvalue);
    Cb4.x:=ScaleX2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x*antialiasvalue);
    Cb4.y:=ScaleY2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y*antialiasvalue);
    Db4.x:=ScaleX2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x*antialiasvalue);
    Db4.y:=ScaleY2(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y*antialiasvalue);

    _Buffer2.Canvas.Polygon([Ab4,Bb4,Cb4,Db4]);
    _Buffer2.Canvas.MoveTo(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x),ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y));
    _Buffer2.Canvas.LineTo(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x),ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y));
    _Buffer2.Canvas.LineTo(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x),ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y));
    _Buffer2.Canvas.LineTo(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x),ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y));
    _Buffer2.Canvas.LineTo(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x),ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y));

    _Buffer2.Canvas.Pen.Color:=clBlack;
    _Buffer2.Canvas.Brush.Style:=bsSolid;
    _Buffer2.Canvas.Brush.Color:=clRed;
    // Punkt Ab zeichnen
    _Buffer2.Canvas.Rectangle(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x)-antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y)-antialiasvalue*5,ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x)+antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y)+antialiasvalue*5);
    // Punkt Bb zeichnen
    _Buffer2.Canvas.Rectangle(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x)-antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y)-antialiasvalue*5,ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x)+antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y)+antialiasvalue*5);
    // Punkt Cb zeichnen
    _Buffer2.Canvas.Rectangle(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x)-antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y)-antialiasvalue*5,ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x)+antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y)+antialiasvalue*5);
    // Punkt Db zeichnen
    _Buffer2.Canvas.Rectangle(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x)-antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y)-antialiasvalue*5,ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x)+antialiasvalue*5,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y)+antialiasvalue*5);
    // Punkt Pb zeichnen
    if Pb.x>255 then Pb.x:=255;
    if Pb.x<0 then Pb.x:=0;
    if Pb.y>255 then Pb.y:=255;
    if Pb.y<0 then Pb.y:=0;
    _Buffer2.Canvas.Brush.Color:=clBlack;
    _Buffer2.Canvas.Ellipse(ScaleX2(antialiasvalue*PB.x)-antialiasvalue*5,ScaleY2(antialiasvalue*PB.y)-antialiasvalue*5,ScaleX2(antialiasvalue*PB.x)+antialiasvalue*5,ScaleY2(antialiasvalue*PB.y)+antialiasvalue*5);

    _Buffer2.Canvas.Brush.Style:=bsClear;
    _Buffer2.Canvas.Font.Size:=10*antialiasvalue;
    _Buffer2.Canvas.Font.Name:='Arial';
    _Buffer2.Canvas.TextOut(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x)+5*antialiasvalue,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y)+5*antialiasvalue,'LO');
    _Buffer2.Canvas.TextOut(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x)-25*antialiasvalue,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y)+5*antialiasvalue,'RO');
    _Buffer2.Canvas.TextOut(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x)-25*antialiasvalue,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y)-18*antialiasvalue,'RU');
    _Buffer2.Canvas.TextOut(ScaleX2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x)+5*antialiasvalue,ScaleY2(antialiasvalue*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y)-18*antialiasvalue,'LU');

    case antialiasvalue of
      1:
      begin
        BitBlt(Paintbox2.Canvas.Handle,0,0,_Buffer2.Width,_Buffer2.Height,_Buffer2.Canvas.Handle,0,0,SrcCopy);
      end;
      2:
      begin
        Antialiasing4x; // Grafik noch ein wenig Glätten
        BitBlt(Paintbox2.Canvas.Handle,0,0,_Buffer2Antialiased.Width,_Buffer2Antialiased.Height,_Buffer2Antialiased.Canvas.Handle,0,0,SrcCopy);
      end;
      4:
      begin
        Antialiasing16x;
        BitBlt(Paintbox2.Canvas.Handle,0,0,_Buffer2Antialiased.Width,_Buffer2Antialiased.Height,_Buffer2Antialiased.Canvas.Handle,0,0,SrcCopy);
      end;
    end;
  end;
end;

procedure Tscannersynchronisationform.Paintbox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  P01x, P01y, valuex,valuey:single;
begin
  if Shift=[ssLeft] then
  begin
    if (X<=Paintbox1.Width) and (X>=0) then
      P.x:=round((X/Paintbox1.Width)*255);
    if (Y<=Paintbox1.Height) and (Y>=0) then
      P.y:=round((Y/Paintbox1.Height)*255);

    if PreviewCheckbox.Checked then
    begin
      P01x:=(X/Paintbox1.Width);
      P01y:=(Y/Paintbox1.Height);
      valuex:=((1-P01x)*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x+(1-P01x)*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x+P01x*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x+P01x*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x);
      valuey:=((1-P01x)*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y+(1-P01x)*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y+P01x*(1-P01y)*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y+P01x*P01y*mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y);

      geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PAN',trunc(valuex),trunc(valuex),0);
      geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PANFINE',trunc(frac(valuex)*256),trunc(frac(valuex)*256),0);
      geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILT',trunc(valuey),trunc(valuey),0);
      geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILTFINE',trunc(frac(valuey)*256),trunc(frac(valuey)*256),0);
    end else
    begin
      geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'PAN',P.x,P.x,0);
      geraetesteuerung.set_channel(mainform.devices[aktuellesgeraet].ID,'TILT',P.y,P.y,0);
    end;
  end;
end;

procedure Tscannersynchronisationform.Paintbox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  NewX, NewY:integer;
begin
  RefreshPaintboxTimer.Interval:=50;

  NewX:=trunc((X/Paintbox1.Width)*255);
  NewY:=trunc((Y/Paintbox1.Height)*255);

  if (NewX>P.x-5) and (NewX<P.x+5) and (NewY>P.y-5) and (NewY<P.y+5) then
  begin
    Pok:=true;
    exit;
  end;
end;

procedure Tscannersynchronisationform.PaintBox2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  NewX, NewY:integer;
begin
  RefreshPaintboxTimer.Interval:=50;

  NewX:=trunc((X/Paintbox2.Width)*255);
  NewY:=trunc((Y/Paintbox2.Height)*255);

  Abok:=false;
  Bbok:=false;
  Cbok:=false;
  Dbok:=false;
  if (NewX>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x-5) and (NewX<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x+5) and (NewY>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y-5) and (NewY<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y+5) then
  begin
    Abok:=true;
    exit;
  end;
  if (NewX>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x-5) and (NewX<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x+5) and (NewY>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y-5) and (NewY<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y+5) then
  begin
    Bbok:=true;
    exit;
  end;
  if (NewX>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x-5) and (NewX<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x+5) and (NewY>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y-5) and (NewY<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y+5) then
  begin
    Cbok:=true;
    exit;
  end;
  if (NewX>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x-5) and (NewX<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x+5) and (NewY>mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y-5) and (NewY<mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y+5) then
  begin
    Dbok:=true;
    exit;
  end;
end;

procedure Tscannersynchronisationform.PaintBox2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Abok:=false;
  Bbok:=false;
  Cbok:=false;
  Dbok:=false;
  RefreshPaintboxTimer.Interval:=250;
end;

procedure Tscannersynchronisationform.Paintbox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RefreshPaintboxTimer.Interval:=250;
end;

procedure Tscannersynchronisationform.ResetPositionsClick(Sender: TObject);
begin
  nouserchange:=true;

  P.x:=127;
  P.y:=127;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x:=0;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y:=0;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x:=255;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y:=0;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x:=255;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y:=255;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x:=0;
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y:=255;
  Pb.x:=127;
  Pb.y:=127;

  lox.Value:=0;
  loy.Value:=0;
  rox.Value:=255;
  roy.Value:=0;
  rux.Value:=255;
  ruy.Value:=255;
  lux.Value:=0;
  luy.Value:=255;

  nouserchange:=false;
end;

procedure Tscannersynchronisationform.AntialiasingComboboxChange(Sender: TObject);
begin
  case AntialiasingCombobox.ItemIndex of
    0: antialiasvalue:=1;
    1:
    begin
      antialiasvalue:=2;
    end;
    2:
    begin
      antialiasvalue:=4;
    end;
  end;
end;

procedure Tscannersynchronisationform.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 16 do
    mainform.Devices[aktuellesgeraet].ScannerCalibrations[i]:=mainform.ScannerSyncTempArray[i];
end;

procedure Tscannersynchronisationform.FormShow(Sender: TObject);
var
  i:integer;
begin
  nouserchange:=true;

  // Für Abbrechen-Funktion alle Kalibrierdaten nochmal in ein Backup-Array kopieren
  for i:=0 to 16 do
    mainform.ScannerSyncTempArrayBackup[i]:=mainform.ScannerSyncTempArray[i];

  for i:=1 to 16 do
  begin
    if mainform.ScannerSyncTempArray[i].Name<>'' then
      ActualSyncEdit.Items[i]:=mainform.ScannerSyncTempArray[i].Name
    else
      ActualSyncEdit.Items[i]:=_('Kalibrierung ')+inttostr(i);
  end;

  ActualSyncEdit.ItemIndex:=mainform.devices[aktuellesgeraet].typeofscannercalibration;

  lox.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x;
  loy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y;
  rox.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x;
  roy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y;
  rux.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x;
  ruy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y;
  lux.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x;
  luy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y;

  if (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.X=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.X=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.X=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.X=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.Y=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.Y=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.Y=0) and (mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.Y=0) then
  begin
    ResetPositionsClick(nil);
  end;

  nouserchange:=false;
  RefreshPaintboxTimer.enabled:=true;
end;

procedure Tscannersynchronisationform.InfoBtnClick(Sender: TObject);
begin
  ShowMessage(
  _('Bitte richten Sie den Scheinwerfer über die vier roten Kästchen auf vier Kalibrationspositionen auf der Bühne aus, die möglichst von allen Scannern/MovingHeads erreicht werden können.')+#13#10+
  _('Diese vier Punkte werden bei aktivierter Synchronisationsfunktion von allen Scanner jeweils als Maximumwerte verwendet.')+#13#10#13#10+
  _('Tipp: durch Vertauschen von gegenüberliegenden Kästchen kann ein Invertieren, bzw. ein Rotieren der Bewegungsachsen erzeugt werden.')
  );
end;

procedure Tscannersynchronisationform.loxChange(Sender: TObject);
begin
  if nouserchange then exit;

  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x:=trunc(lox.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y:=trunc(loy.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x:=trunc(rox.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y:=trunc(roy.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x:=trunc(rux.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y:=trunc(ruy.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x:=trunc(lux.value);
  mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y:=trunc(luy.value);
end;

procedure Tscannersynchronisationform.Button3Click(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to 16 do
    mainform.Devices[aktuellesgeraet].ScannerCalibrations[i]:=mainform.ScannerSyncTempArrayBackup[i];
end;

procedure Tscannersynchronisationform.CalibrationPointsOutOfBoundsMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  lox.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  loy.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  rox.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  roy.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  rux.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  ruy.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  lux.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;
  luy.CheckMinValue:=not CalibrationPointsOutOfBounds.Checked;

  lox.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  loy.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  rox.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  roy.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  rux.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  ruy.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  lux.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;
  luy.CheckMaxValue:=not CalibrationPointsOutOfBounds.Checked;

  if CalibrationPointsOutOfBounds.Checked then
  begin
    lox.MaxValue:=1024;
    loy.MaxValue:=1024;
    rox.MaxValue:=1024;
    roy.MaxValue:=1024;
    rux.MaxValue:=1024;
    ruy.MaxValue:=1024;
    lux.MaxValue:=1024;
    luy.MaxValue:=1024;
  end else
  begin
    lox.MaxValue:=255;
    loy.MaxValue:=255;
    rox.MaxValue:=255;
    roy.MaxValue:=255;
    rux.MaxValue:=255;
    ruy.MaxValue:=255;
    lux.MaxValue:=255;
    luy.MaxValue:=255;
  end;
end;

procedure Tscannersynchronisationform.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    Button3.click;
end;

procedure Tscannersynchronisationform.FormHide(Sender: TObject);
begin
  RefreshPaintboxTimer.enabled:=false;
end;

procedure Tscannersynchronisationform.ComboBox1Change(Sender: TObject);
var
  atmp,btmp,ctmp,dtmp:TPoint;
begin
  nouserchange:=true;

  atmp:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA;
  btmp:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB;
  ctmp:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC;
  dtmp:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD;

  case Combobox1.itemindex of
    1:
    begin // Halbe Größe
      P.x:=127;
      P.y:=127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.X-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x-127) div 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y-127) div 2 + 127;
      Pb.x:=(Pb.x-127) div 2 + 127;
      Pb.y:=(Pb.y-127) div 2 + 127;
    end;
    2:
    begin // Doppelte Größe
      P.x:=127;
      P.y:=127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.X-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x-127) * 2 + 127;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y:=(mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y-127) * 2 + 127;
      Pb.x:=(Pb.x-127) * 2 + 127;
      Pb.y:=(Pb.y-127) * 2 + 127;
    end;
    3:
    begin // 90° nach Rechts
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA:=dtmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB:=atmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC:=btmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD:=ctmp;
    end;
    4: // 180°
    begin
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA:=ctmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB:=dtmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC:=atmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD:=btmp;
    end;
    5: // 90° nach Links
    begin
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA:=btmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB:=ctmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC:=dtmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD:=atmp;
    end;
    6: // Horizontal Spiegeln
    begin
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA:=dtmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB:=ctmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC:=btmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD:=atmp;
    end;
    7: // Vertikal Spiegeln
    begin
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA:=btmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB:=atmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC:=dtmp;
      mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD:=ctmp;
    end;
  end;

  lox.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x;
  loy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y;
  rox.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x;
  roy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y;
  rux.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x;
  ruy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y;
  lux.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x;
  luy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y;

  if Combobox1.ItemIndex>0 then
    Combobox1.ItemIndex:=0;

  nouserchange:=false;
end;

procedure Tscannersynchronisationform.Button1Click(Sender: TObject);
var
  i:integer;
begin
  if ActualSyncEdit.itemindex>0 then
  begin
    i:=ActualSyncEdit.itemindex;
    mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].Name:=InputBox(_('Scannerkalibrierung beschriften'),_('Geben Sie bitte einen neuen Namen für diese Kalibrierungsoption ein:'),mainform.devices[aktuellesgeraet].ScannerCalibrations[ActualSyncEdit.itemindex].Name);
    if mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].Name<>'' then
      ActualSyncEdit.Items[ActualSyncEdit.itemindex]:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].Name;
    ActualSyncEdit.itemindex:=i;
  end;
end;

procedure Tscannersynchronisationform.ActualSyncEditSelect(
  Sender: TObject);
begin
  nouserchange:=true;

  lox.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.x;
  loy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointA.y;
  rox.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.x;
  roy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointB.y;
  rux.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.x;
  ruy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointC.y;
  lux.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.x;
  luy.Value:=mainform.ScannerSyncTempArray[ActualSyncEdit.itemindex].PointD.y;

  nouserchange:=false;
end;

procedure Tscannersynchronisationform.CreateParams(var Params:TCreateParams);
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

procedure Tscannersynchronisationform.FormResize(Sender: TObject);
begin
  _Buffer.Width:=4*Paintbox1.Width;
  _Buffer.Height:=4*Paintbox1.Height;
  _BufferAntialiased.Width := Paintbox1.Width;
  _BufferAntialiased.Height := Paintbox1.Height;

  _Buffer2.Width:=4*Paintbox2.Width;
  _Buffer2.Height:=4*Paintbox2.Height;
  _Buffer2Antialiased.Width := Paintbox2.Width;
  _Buffer2Antialiased.Height := Paintbox2.Height;
end;

procedure Tscannersynchronisationform.copybtnClick(Sender: TObject);
begin
  CopyA.x:=round(lox.value);
  CopyA.y:=round(loy.value);
  CopyB.x:=round(rox.value);
  CopyB.y:=round(roy.value);
  CopyC.x:=round(lux.value);
  CopyC.y:=round(luy.value);
  CopyD.x:=round(rux.value);
  CopyD.y:=round(ruy.value);
end;

procedure Tscannersynchronisationform.pastebtnClick(Sender: TObject);
begin
  lox.value:=CopyA.X;
  loy.Value:=CopyA.Y;
  rox.value:=CopyB.X;
  roy.Value:=CopyB.Y;
  lux.value:=CopyC.X;
  luy.Value:=CopyC.Y;
  rux.value:=CopyD.X;
  ruy.Value:=CopyD.Y;
end;

procedure Tscannersynchronisationform.Splitter1Moved(Sender: TObject);
begin
  scannersynchronisationform.OnResize(nil);
end;

end.
