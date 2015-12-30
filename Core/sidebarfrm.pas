unit sidebarfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, HSLColorPicker, ExtCtrls, Buttons, PngSpeedButton,
  pngimage, gnugettext, TiledImage, Math, ComCtrls,
  dxGDIPlusClasses, Mask, JvExMask, JvSpin, HSLRingPicker;

const
  SmallWidth=15;
  SmallHeight=55;
  HugeWidth=250;
  HugeHeight=670;

type
  pRGBArray = ^TRGBTripleArray;
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array [0..31] of TRGBTriple;

  Tsidebarform = class(TForm)
    fadenkreuz: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    dimmer: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    R: TScrollBar;
    G: TScrollBar;
    B: TScrollBar;
    Label5: TLabel;
    grouplistbox: TComboBox;
    Button1: TButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    PngSpeedButton1: TPngSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    Image1: TImage;
    Image2: TImage;
    dimmerlabel: TLabel;
    TiledImage1: TTiledImage;
    TiledImage2: TTiledImage;
    Button2: TButton;
    VertTrack: TTrackBar;
    HorTrack: TTrackBar;
    Label9: TLabel;
    PaintBox1: TPaintBox;
    Button3: TButton;
    Button4: TButton;
    zoomvalue: TJvSpinEdit;
    Image3: TImage;
    Image4: TImage;
    Label10: TLabel;
    strobebar: TScrollBar;
    strobelbl: TLabel;
    Label12: TLabel;
    goborot1: TScrollBar;
    goborot2: TScrollBar;
    W: TScrollBar;
    Label11: TLabel;
    Label13: TLabel;
    A: TScrollBar;
    colorpicker: THSLRingPicker;
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fadenkreuzMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure fadenkreuzMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PositionXYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure grouplistboxSelect(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure PngSpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TiledImage1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure TiledImage2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PositionXYMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure HorTrackChange(Sender: TObject);
    procedure VertTrackChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure REnter(Sender: TObject);
    procedure RExit(Sender: TObject);
    procedure colorpickerChange(Sender: TObject);
    procedure colorpickerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private-Deklarationen }
    timer:byte;
    usemhcontrol:boolean;
    rgn:HRGN;
    PictureToCompare1, PictureToCompare2, PictureToCompare2Rotated:TBitmap;
    OverGoboButton:integer;
    GoboButtons:array of string;
    LastPosX, LastPosY:integer;
    DoFinePos:boolean;
    dontchangesliders:boolean;
    dontchangecolorfield:boolean;
    usersetting:boolean;
  public
    { Public-Deklarationen }
    Gobolist:array of string;
    GoboOffset:byte;
    procedure GroupListChanged;
    procedure RefreshGoboList;
    procedure RefreshGoboCorrelation;
    procedure RotateBitmap(Source, Destination:TBitmap; iRotationAxis, jRotationAxis:integer; Angle: integer);
    function ZNCC(Bild1, Bild2: TBitmap):Single;
  end;

var
  sidebarform: Tsidebarform;

implementation

uses PCDIMMER, geraetesteuerungfrm, reordergroupfrm, PngImageList,
  ProgressScreenSmallFrm, buehnenansicht;

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

procedure Tsidebarform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  PictureToCompare1:=TBitmap.Create;
  PictureToCompare1.PixelFormat := pf24bit;
  PictureToCompare1.Width:=32;
  PictureToCompare1.Height:=32;
  PictureToCompare2:=TBitmap.Create;
  PictureToCompare2.PixelFormat := pf24bit;
  PictureToCompare2.Width:=32;
  PictureToCompare2.Height:=32;
  PictureToCompare2Rotated:=TBitmap.Create;
  PictureToCompare2Rotated.PixelFormat := pf24bit;
  PictureToCompare2Rotated.Width:=32;
  PictureToCompare2Rotated.Height:=32;


  sidebarform.ClientWidth:=SmallWidth;
  sidebarform.ClientHeight:=SmallHeight;
end;

procedure Tsidebarform.FormClick(Sender: TObject);
begin
  if sidebarform.ClientWidth=HugeWidth then
  begin
    sidebarform.ClientWidth:=SmallWidth;
    sidebarform.ClientHeight:=SmallHeight;
    PngSpeedButton1.Down:=false;
    Timer1.Enabled:=false;
    timer:=0;
  end else
  begin
    sidebarform.ClientWidth:=HugeWidth;
    sidebarform.ClientHeight:=HugeHeight;
    sidebarform.BringToFront;
  end;

  sidebarform.Left:=screen.Width-sidebarform.ClientWidth;
  sidebarform.Top:=mainform.top+mainform.dxRibbon1.height;
end;

procedure Tsidebarform.FormShow(Sender: TObject);
begin
  sidebarform.Left:=screen.Width-sidebarform.ClientWidth;
  sidebarform.Top:=mainform.top+mainform.dxRibbon1.height;
end;

procedure Tsidebarform.fadenkreuzMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then
  begin
    if Shift=[ssCtrl] then
    begin
      DoFinePos:=true;
      PositionXY.Top:=Y-PositionXY.Height div 2;
      PositionXY.Left:=X-PositionXY.Width div 2;
    end else
    begin
      DoFinePos:=false;
      PositionXY.Top:=Y-PositionXY.Height div 2;
      PositionXY.Left:=X-PositionXY.Width div 2;
      LastPosX:=PositionXY.Left;
      LastPosY:=PositionXY.Top;
    end;
  end else
  begin
    PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
    PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  end;
  change(fadenkreuz);
end;

procedure Tsidebarform.fadenkreuzMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pan,tilt,r,phi:extended;
begin
  timer:=0;

  if (Shift=[ssLeft]) or (Shift=[ssLeft, ssCtrl]) then
  begin
    if usemhcontrol then
    begin
	    pan:=((x-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1
	    tilt:=((y-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1
      r:=sqrt(pan*pan+tilt*tilt);

      if (r<=1) then  // prüfen, ob Punkt innerhalb von maximalem Radius
      begin
        PositionXY.Left:=x-(PositionXY.Width div 2);
        PositionXY.Top:=y-(PositionXY.Height div 2);
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

        PositionXY.Left:=round((sin(phi)*fadenkreuz.Width/2)+(fadenkreuz.Width/2)-(PositionXY.Width/2));
        PositionXY.Top:=round((cos(phi)*fadenkreuz.Height/2)+(fadenkreuz.Height/2)-(PositionXY.Height/2));
      end;
      PositionXY.Refresh;
      change(fadenkreuz);
    end else
    begin
      if Shift=[ssLeft,ssCtrl] then
      begin
        DoFinePos:=true;
        if ((x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=x-(PositionXY.Width div 2);
        if ((y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=y-(PositionXY.Height div 2);
      end else
      begin
        DoFinePos:=false;
        if ((x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=x-(PositionXY.Width div 2);
        if ((y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=y-(PositionXY.Height div 2);
        LastPosX:=PositionXY.Left;
        LastPosY:=PositionXY.Top;
      end;
      
      PositionXY.Refresh;
      change(fadenkreuz);
    end;
  end;
end;

procedure Tsidebarform.PositionXYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  pan, tilt, r, phi:extended;
begin
  timer:=0;

  if (Shift=[ssLeft]) or (Shift=[ssLeft,ssCtrl]) then
  begin
    if usemhcontrol then
    begin
	    pan:=(((PositionXY.Left+x)-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1
	    tilt:=(((PositionXY.Top+y)-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1
      r:=sqrt(pan*pan+tilt*tilt);

      if (r<=1) then  // prüfen, ob Punkt innerhalb von maximalem Radius
      begin
        PositionXY.Left:=(PositionXY.Left+x)-(PositionXY.Width div 2);
        PositionXY.Top:=(PositionXY.Top+y)-(PositionXY.Height div 2);
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

        PositionXY.Left:=round((sin(phi)*fadenkreuz.Width/2)+(fadenkreuz.Width/2)-(PositionXY.Width/2));
        PositionXY.Top:=round((cos(phi)*fadenkreuz.Height/2)+(fadenkreuz.Height/2)-(PositionXY.Height/2));
      end;
      PositionXY.Refresh;
      change(fadenkreuz);
    end else
    begin
      if Shift=[ssLeft,ssCtrl] then
      begin
        DoFinePos:=true;
        if ((PositionXY.Left+x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((PositionXY.Left+x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=PositionXY.Left+x-(PositionXY.Width div 2);
        if ((PositionXY.Top+y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((PositionXY.Top+y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=PositionXY.Top+y-(PositionXY.Height div 2);
      end else
      begin
        DoFinePos:=false;
        if ((PositionXY.Left+x-(PositionXY.Width div 2))>=0-(PositionXY.Width div 2)) and ((PositionXY.Left+x-(PositionXY.Width div 2))<=fadenkreuz.Width-(PositionXY.Width div 2)) then PositionXY.Left:=PositionXY.Left+x-(PositionXY.Width div 2);
        if ((PositionXY.Top+y-(PositionXY.Height div 2))>=0-(PositionXY.Height div 2)) and ((PositionXY.Top+y-(PositionXY.Height div 2))<=fadenkreuz.Height-(PositionXY.Height div 2)) then PositionXY.Top:=PositionXY.Top+y-(PositionXY.Height div 2);
        LastPosX:=PositionXY.Left;
        LastPosY:=PositionXY.Top;
      end;
      PositionXY.Refresh;
      change(fadenkreuz);
    end;
  end;
end;

procedure Tsidebarform.change(Sender: TObject);
var
  i, j, k, kanalwert,Rdiff,Gdiff,Bdiff,temp,temp2,bestcolor,bestcolor2:integer;
  Rdev,Gdev,Bdev:byte;
  colorchannelvalues:array of integer;
  colorchannelvalues2:array of integer;

	phi,rad,x,y:Extended;
	pan, tilt, panfine, tiltfine:Extended;

  BestGobo1, BestGobo2:integer;
  MaxValueGobo1, MaxValueGobo2, ZNCCResult:single;
  rect:Trect;
begin
  timer:=0;
  dimmerlabel.Caption:=inttostr(dimmer.Position)+' ('+inttostr((dimmer.Position*100) div 255)+'%)';
  strobelbl.Caption:=inttostr(strobebar.Position)+' ('+inttostr((strobebar.Position*100) div 255)+'%)';

  rect.Left:=0;
  rect.Top:=0;
  rect.Right:=32;
  rect.Bottom:=32;

  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if (Sender=fadenkreuz) then
      begin
        if usemhcontrol then
        begin
          // Moving-Head-Steuerung (Polarkoordinaten)
          x:=((PositionXY.Left+(PositionXY.Width div 2)-(fadenkreuz.Width/2))/fadenkreuz.Width)*2;	//-1..0..1
          y:=((PositionXY.Top+(PositionXY.Height div 2)-(fadenkreuz.Width/2))/fadenkreuz.Height)*2;	//-1..0..1
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

      		geraetesteuerung.set_channel(mainform.Devices[i].ID,'pan',trunc(pan),trunc(pan),0);
      		geraetesteuerung.set_channel(mainform.Devices[i].ID,'panfine',trunc(frac(pan)*255),trunc(frac(pan)*255),0);
    	  	geraetesteuerung.set_channel(mainform.Devices[i].ID,'tilt',trunc(tilt),trunc(tilt),0);
  	  	  geraetesteuerung.set_channel(mainform.Devices[i].ID,'tiltfine',trunc(frac(tilt)*255),trunc(frac(tilt)*255),0);
        end else
        begin
          if DoFinePos then
          begin
            geraetesteuerung.set_channel(mainform.Devices[i].ID,'pan',-1,trunc(((LastPosX+(PositionXY.Width/2))/Fadenkreuz.Width)*255)+(trunc(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*zoomvalue.value)-round(zoomvalue.value/2)),0);
        		geraetesteuerung.set_channel(mainform.Devices[i].ID,'panfine',-1,trunc(frac((((LastPosX+(PositionXY.Width/2))/Fadenkreuz.Width)*255)+((((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*zoomvalue.value)-(zoomvalue.value/2)))*255),0);
            geraetesteuerung.set_channel(mainform.Devices[i].ID,'tilt',-1,trunc(((LastPosY+(PositionXY.Height/2))/Fadenkreuz.Height)*255)+(trunc(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*zoomvalue.value)-round(zoomvalue.value/2)),0);
  	    	  geraetesteuerung.set_channel(mainform.Devices[i].ID,'tiltfine',-1,trunc(frac((((LastPosY+(PositionXY.Height/2))/Fadenkreuz.Height)*255)+((((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*zoomvalue.value)-(zoomvalue.value/2)))*255),0);
          end else
          begin
            geraetesteuerung.set_channel(mainform.Devices[i].ID,'pan',trunc(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*255),trunc(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*255),0);
        		geraetesteuerung.set_channel(mainform.Devices[i].ID,'panfine',trunc(frac(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*255)*255),trunc(frac(((PositionXY.Left+(PositionXY.Width/2))/Fadenkreuz.Width)*255)*255),0);
            geraetesteuerung.set_channel(mainform.Devices[i].ID,'tilt',trunc(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*255),trunc(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*255),0);
  	    	  geraetesteuerung.set_channel(mainform.Devices[i].ID,'tiltfine',trunc(frac(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*255)*255),trunc(frac(((PositionXY.Top+(PositionXY.Height/2))/Fadenkreuz.Height)*255)*255),0);
          end;
        end;
      end;

{
      if (Sender=r) then geraetesteuerung.set_channel(mainform.Devices[i].ID,'r',255-r.Position,255-r.Position,0);
      if (Sender=g) then geraetesteuerung.set_channel(mainform.Devices[i].ID,'g',255-g.Position,255-g.Position,0);
      if (Sender=b) then geraetesteuerung.set_channel(mainform.Devices[i].ID,'b',255-b.Position,255-b.Position,0);
}
      if ((Sender=r) or (Sender=g) or (Sender=b)) then
      begin
        geraetesteuerung.set_color(mainform.devices[i].ID, 255-r.Position,255-g.Position,255-b.Position,0,0);
      end;

      if Sender=a then
        geraetesteuerung.set_channel(mainform.devices[i].ID, 'A', 255-a.position, 255-a.position, 0, 0);

      if Sender=w then
        geraetesteuerung.set_channel(mainform.devices[i].ID, 'W', 255-w.position, 255-w.position, 0, 0);

      if Sender=dimmer then
        geraetesteuerung.set_dimmer(mainform.Devices[i].ID, dimmer.position);
//        geraetesteuerung.set_channel(mainform.Devices[i].ID,'dimmer', -1, dimmer.Position, 0);

      if Sender=strobebar then
        geraetesteuerung.set_strobe(mainform.Devices[i].ID, strobebar.position);

      if Sender=goborot1 then
        geraetesteuerung.set_gobo1rot(mainform.Devices[i].ID, goborot1.position);

      if Sender=goborot2 then
        geraetesteuerung.set_gobo1rot(mainform.Devices[i].ID, goborot2.position);

      if Sender=image3 then
        geraetesteuerung.set_shutter(mainform.Devices[i].ID, 255);
//        geraetesteuerung.set_channel(mainform.Devices[i].ID,'shutter', -1, 255, 0);

      if Sender=image4 then
        geraetesteuerung.set_shutter(mainform.Devices[i].ID, 0);
//        geraetesteuerung.set_channel(mainform.Devices[i].ID,'shutter', -1, 0, 0);

      if Sender=Paintbox1 then
      begin
        if mainform.devices[i].hasGobo or mainform.devices[i].hasGobo2 then
        begin
          // GoboButton[j] = Gewähltes Gobo
          BestGobo1:=-1;
          BestGobo2:=-1;
          MaxValueGobo1:=0;
          MaxValueGobo2:=0;

          // Gobo1 durchsuchen
          if mainform.devices[i].hasGobo then
          begin
            // sofern gleiche Gobos, dann 100%ige Übereinstimmung festlegen
            for j:=0 to length(mainform.devices[i].gobos)-1 do
            begin
              if mainform.devices[i].gobos[j]=GoboButtons[OverGoboButton] then
              begin
                MaxValueGobo1:=100;
                BestGobo1:=j;
              end;
            end;

            // falls kein identisches Gobo gefunden, dann auf Korrelationswert zurückgreifen
            if MaxValueGobo1<100 then
            for j:=0 to length(mainform.devices[i].bestgobos)-1 do
            begin
              for k:=0 to length(mainform.devices[i].bestgobos[j])-1 do
              begin
                if mainform.devices[i].bestgobos[j][k].Goboname=GoboButtons[OverGoboButton] then
                begin
                  if mainform.devices[i].bestgobos[j][k].Percent>MaxValueGobo1 then
                  begin
                    MaxValueGobo1:=mainform.devices[i].bestgobos[j][k].Percent;
                    BestGobo1:=j;
                  end;
                  break;
                end;
              end;
            end;
          end;

          // Gobo2 durchsuchen
          if mainform.devices[i].hasGobo2 then
          begin
            // sofern gleiche Gobos, dann 100%ige Übereinstimmung festlegen
            for j:=0 to length(mainform.devices[i].gobos2)-1 do
            begin
              if mainform.devices[i].gobos2[j]=GoboButtons[OverGoboButton] then
              begin
                MaxValueGobo2:=100;
                BestGobo2:=j;
              end;
            end;

            // falls kein identisches Gobo gefunden, dann auf Korrelationswert zurückgreifen
            if MaxValueGobo2<100 then
            for j:=0 to length(mainform.devices[i].bestgobos2)-1 do
            begin
              for k:=0 to length(mainform.devices[i].bestgobos2[j])-1 do
              begin
                if mainform.devices[i].bestgobos2[j][k].GoboName=GoboButtons[OverGoboButton] then
                begin
                  if mainform.devices[i].bestgobos2[j][k].Percent>MaxValueGobo2 then
                  begin
                    MaxValueGobo2:=mainform.devices[i].bestgobos2[j][k].Percent;
                    BestGobo2:=j;
                  end;
                  break;
                end;
              end;
            end;
          end;

          if mainform.devices[i].hasGobo2 and (MaxValueGobo2>MaxValueGobo1) then
          begin
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, 0, 0);
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, mainform.devices[i].gobolevels2[BestGobo2], 0);
          end else if mainform.devices[i].hasGobo and (MaxValueGobo1>MaxValueGobo2) then
          begin
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[BestGobo1], 0);
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, 0, 0);
          end else if mainform.devices[i].hasGobo and (MaxValueGobo1>0) then
          begin
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[BestGobo1], 0);
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, 0, 0);
          end;

{

          // Gobo1 durchsuchen
          if mainform.devices[i].hasGobo then
          begin
            for k:=0 to length(mainform.devices[i].gobos)-1 do
            begin
              for l:=0 to mainform.GoboPictures.Items.Count-1 do
              begin
                if mainform.devices[i].gobos[k]=mainform.GoboPictures.Items.Items[l].Name then
                begin
                  // Gobo in Liste gefunden -> Bild kopieren
                  mainform.GoboPictures.Items.Items[l].PngImage.Draw(PictureToCompare2.Canvas, rect);

                  // Welches Gobo wurde angeklickt?
                  for j:=0 to mainform.GoboPictures.Items.Count-1 do
                  begin
                    if mainform.GoboPictures.Items.Items[j].Name=GoboButtons[OverGoboButton] then
                    begin
                      mainform.GoboPictures.Items.Items[j].PngImage.Draw(PictureToCompare1.Canvas, rect);
                      break;
                    end;
                  end;

                  // Kreuz-Korrelation ausführen
                  for m:=0 to 23 do
                  begin
                    if MaxValueGobo1>90 then break; // wir brauchen ja keine 100% übereinstimmung

                    RotateBitmap(PictureToCompare2, PictureToCompare2Rotated, 16, 16, m*15);
                    ZNCCResult:=ZNCC(PictureToCompare1, PictureToCompare2rotated);
                    if ZNCCResult>MaxValueGobo1 then
                    begin
                      MaxValueGobo1:=ZNCCResult;
                      BestGobo1:=k;
                    end;
                  end;
                  break;
                end;
              end;
            end;
          end;

          // Gobo2 durchsuchen
          if mainform.devices[i].hasGobo2 and (MaxValueGobo1<90) then // nur ausführen, wenn Gobo1 nicht doll
          begin
            for k:=0 to length(mainform.devices[i].gobos2)-1 do
            begin
              for l:=0 to mainform.GoboPictures.Items.Count-1 do
              begin
                if mainform.devices[i].gobos2[k]=mainform.GoboPictures.Items.Items[l].Name then
                begin
                  // Gobo gefunden -> Bild kopieren
                  mainform.GoboPictures.Items.Items[l].PngImage.Draw(PictureToCompare2.Canvas, rect);

                  // Welches Gobo wurde angeklickt?
                  for j:=0 to mainform.GoboPictures.Items.Count-1 do
                  begin
                    if mainform.GoboPictures.Items.Items[j].Name=GoboButtons[OverGoboButton] then
                    begin
                      mainform.GoboPictures.Items.Items[j].PngImage.Draw(PictureToCompare1.Canvas, rect);
                      break;
                    end;
                  end;

                  // Kreuz-Korrelation ausführen
                  for m:=0 to 23 do
                  begin
                    if MaxValueGobo2>90 then break; // wir brauchen ja keine 100% übereinstimmung

                    RotateBitmap(PictureToCompare2, PictureToCompare2Rotated, 16, 16, m*15);
                    ZNCCResult:=ZNCC(PictureToCompare1, PictureToCompare2rotated);
                    if ZNCCResult>MaxValueGobo2 then
                    begin
                      MaxValueGobo2:=ZNCCResult;
                      BestGobo2:=k;
                    end;
                  end;
                end;
              end;
            end;
          end;

//          label10.caption:='Gobo1: '+inttostr(round(MaxValueGobo1))+'% Gobo2: '+inttostr(round(MaxValueGobo2))+'%';

          if mainform.devices[i].hasGobo2 and (MaxValueGobo2>MaxValueGobo1) then
          begin
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, 0, 0);
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, mainform.devices[i].gobolevels2[BestGobo2], 0);
          end else if mainform.devices[i].hasGobo and (MaxValueGobo1>MaxValueGobo2) then
          begin
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[BestGobo1], 0);
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, 0, 0);
          end else if mainform.devices[i].hasGobo and (MaxValueGobo1>0) then
          begin
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[BestGobo1], 0);
            geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, 0, 0);
          end;
}
        end;
      end;
    end;
  end;
end;

procedure Tsidebarform.Button1Click(Sender: TObject);
begin
  mainform.DeSelectAllDevices;
end;

procedure Tsidebarform.GroupListChanged;
var
  i,lastindex:integer;
begin
  lastindex:=grouplistbox.itemindex;
  grouplistbox.items.Clear;
  for i:=0 to length(mainform.devicegroups)-1 do
  begin
    grouplistbox.items.add(mainform.devicegroups[i].Name);
  end;
  if (lastindex>-1) and (lastindex<grouplistbox.items.count) then
    grouplistbox.itemindex:=lastindex
  else if grouplistbox.Items.count>0 then
    grouplistbox.itemindex:=0;
end;

procedure Tsidebarform.grouplistboxSelect(Sender: TObject);
begin
  if length(mainform.DeviceGroups)>=Grouplistbox.itemindex then
  begin
    mainform.SelectDeviceGroup(mainform.deviceGroups[Grouplistbox.itemindex].ID, Checkbox1.Checked);
  end;
end;

procedure Tsidebarform.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  usersetting:=false;

  Timer1.Enabled:=not PngSpeedButton1.Down;
  timer:=0;
  sidebarform.ClientWidth:=HugeWidth;
  sidebarform.ClientHeight:=HugeHeight;
  RefreshGoboList;
  sidebarform.BringToFront;

  if (Shift=[]) and (not PngSpeedButton1.Down) then
  begin
    sidebarform.Left:=screen.Width-sidebarform.ClientWidth;
    sidebarform.Top:=mainform.top+mainform.dxRibbon1.height;
  end else
  begin
    PngSpeedButton1.Down:=true;
    ReleaseCapture;
    sidebarform.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure Tsidebarform.Timer1Timer(Sender: TObject);
begin
  if timer>=2 then
  begin
    Timer1.Enabled:=false;
    timer:=0;
    PngSpeedButton1.Down:=false;
    sidebarform.ClientWidth:=SmallWidth;
    sidebarform.ClientHeight:=SmallHeight;
    sidebarform.Left:=screen.Width-sidebarform.ClientWidth;
    sidebarform.Top:=mainform.top+mainform.dxRibbon1.height;
  end;

  timer:=timer+1;
end;

procedure Tsidebarform.PngSpeedButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormMouseMove(nil, [], 0,0);
end;

procedure Tsidebarform.Shape1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormClick(nil);
end;

procedure Tsidebarform.TiledImage1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Timer1.Enabled:=not PngSpeedButton1.Down;
  timer:=0;
end;

procedure Tsidebarform.PngSpeedButton1Click(Sender: TObject);
begin
  FormMouseMove(nil, [], 0,0);
end;

procedure Tsidebarform.TiledImage2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssShift, ssCtrl] then
  begin
    usemhcontrol:=not usemhcontrol;
    VertTrack.Visible:=not usemhcontrol;
    HorTrack.Visible:=not usemhcontrol;

    if usemhcontrol then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
      SetWindowRgn(fadenkreuz.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz.Handle, 0, True);
    end;
  end;

  if Shift=[ssShift] then
  begin
    VertTrack.Visible:=not VertTrack.Visible;
    HorTrack.Visible:=VertTrack.Visible;
  end;
end;

procedure Tsidebarform.PositionXYMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Shift=[ssShift, ssCtrl] then
  begin
    usemhcontrol:=not usemhcontrol;
    if usemhcontrol then
    begin
      rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
      SetWindowRgn(fadenkreuz.Handle, rgn, True);
    end else
    begin
      SetWindowRgn(fadenkreuz.Handle, 0, True);
    end;
  end;

  if Shift=[ssShift] then
  begin
    VertTrack.Visible:=not VertTrack.Visible;
    HorTrack.Visible:=VertTrack.Visible;
  end;
end;

procedure Tsidebarform.Button2Click(Sender: TObject);
begin
  usemhcontrol:=not usemhcontrol;
  VertTrack.Visible:=not usemhcontrol;
  HorTrack.Visible:=not usemhcontrol;
  
  if usemhcontrol then
  begin
    rgn := CreateRoundRectRgn(1,1,fadenkreuz.Width,fadenkreuz.Height,fadenkreuz.Width,fadenkreuz.Height);
    SetWindowRgn(fadenkreuz.Handle, rgn, True);
  end else
  begin
    SetWindowRgn(fadenkreuz.Handle, 0, True);
  end;
end;

procedure Tsidebarform.HorTrackChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'pan',trunc(HorTrack.Position/257),trunc(HorTrack.Position/257),0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'panfine',trunc(frac(HorTrack.Position/257)*255),trunc(frac(HorTrack.Position/257)*255),0);
    end;
  end;

  PositionXY.Left:=round((HorTrack.Position/65535)*fadenkreuz.Width-(PositionXY.Width/2));
end;

procedure Tsidebarform.VertTrackChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'tilt',trunc(VertTrack.Position/257),trunc(VertTrack.Position/257),0);
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'tiltfine',trunc(frac(VertTrack.Position/257)*255),trunc(frac(VertTrack.Position/257)*255),0);
    end;
  end;

  PositionXY.Top:=round((VertTrack.Position/65535)*fadenkreuz.Height-(PositionXY.Height/2));
end;

PROCEDURE Tsidebarform.RotateBitmap(Source, Destination:TBitmap; iRotationAxis, jRotationAxis:integer; Angle: integer);
const
  Black : RGBTriple = (rgbtBlue:0; rgbtGreen:0; rgbtRed:0);
VAR
  i, j           :  Word;
  BW, BH         :  Word;
  iOriginal      :  Integer;
  iPrime         :  Integer;
  iPrimeRotated  :  Integer;
  jOriginal      :  Integer;
  jPrime         :  Integer;
  jPrimeRotated  :  Integer;
{$IFDEF Paletted}
  RowOriginal    :  pByteArray;
  RowRotated     :  pByteArray;
{$ELSE}
  RowOriginal    :  pRGBArray;
  RowRotated     :  pRGBArray;
{$ENDIF}
  sinTheta       :  Double;
  cosTheta       :  Double;
  Theta          :  Double; // radians
  POriginalStart :  Pointer;
  POriginal      :  Pointer;
  ScanlineBytes  :  Integer;
  iRot, jRot     :  Integer;
  jPrimeSinTheta :  Double;
  jPrimeCosTheta :  Double;
begin
  // The size of BitmapRotated is the same as BitmapOriginal.  PixelFormat
  // must also match since 24-bit GBR triplets are assumed in ScanLine.
  Destination.Width  := Source.Width;
  Destination.Height := Source.Height;
  Destination.PixelFormat := Source.PixelFormat; //Copy PixelFormat
{$IFDEF Paletted}
  Destination.Palette := CopyPalette(Source.Palette); //Copy Palette
{$ENDIF}
  // Convert degrees to radians.  Use minus sign to force clockwise rotation.
  Theta := -Angle/180 * PI;
  sinTheta := SIN(Theta);
  cosTheta := COS(Theta);

  //Get Size of each ScanLine (Allow for DWORD Alignment and DIB Orientation)
  ScanlineBytes := Integer(Source.Scanline[1])
                 - Integer(Source.Scanline[0]);

  BW := Source.Width  - 1; //Prevent Repeated Calls to TBitMap.Width
  BH := Source.Height - 1; //Prevent Repeated Calls to TBitMap.Height
  iRot := (2 * iRotationAxis) + 1; //Simplify Calculation within Inner Loop
  jRot := (2 * jRotationAxis) + 1; //Simplify Calculation within Outer Loop

  //Remove all calls to Scanline method from within loops by using local pointers

  RowRotated     := Destination.ScanLine[BH]; //Last BitmapRotated Scanline
  POriginalStart := Source.ScanLine[0]; //First BitmapOriginal Scanline
  // Step through each row of rotated image.
  for j := BH downto 0 do
    begin
      // Assume the bitmap has an even number of pixels in both dimensions and
      // the axis of rotation is to be the exact middle of the image -- so this
      // axis of rotation is not at the middle of any pixel.

      // The transformation (i,j) to (iPrime, jPrime) puts the center of each
      // pixel at odd-numbered coordinates.  The left and right sides of each
      // pixel (as well as the top and bottom) then have even-numbered coordinates.

      // The point (iRotationAxis, jRotationAxis) identifies the axis of rotation.

      // For a 640 x 480 pixel image, the center point is (320, 240).  Pixels
      // numbered (index i) 0..319 are left of this point along the "X" axis and
      // pixels numbered 320..639 are right of this point.  Likewise, vertically
      // pixels are numbered (index j) 0..239 above the axis of rotation and
      // 240..479 below the axis of rotation.

      // The subtraction (i, j) - (iRotationAxis, jRotationAxis) moves the axis of
      // rotation from (i, j) to (iRotationAxis, jRotationAxis), which is the
      // center of the bitmap in this implementation.
      jPrime := (2 * j) - jRot;
      jPrimeSinTheta := jPrime * sinTheta; //Simplify Calculation within Loop
      jPrimeCosTheta := jPrime * cosTheta; //Simplify Calculation within Loop
      POriginal := POriginalStart; //Pointer to First BitmapOriginal Scanline
      for i := BW downto 0 do
        begin
          // Rotate (iPrime, jPrime) to location of desired pixel
          // Transform back to pixel coordinates of image, including translation
          // of origin from axis of rotation to origin of image.
          // Make sure (iOriginal, jOriginal) is in BitmapOriginal.  If not,
          // assign blue color to corner points.
          iPrime := (2 * i) - iRot;
          iPrimeRotated := ROUND(iPrime * cosTheta - jPrimeSinTheta);
          iOriginal := (iPrimeRotated - 1) div 2 + iRotationAxis;
          if (iOriginal >= 0) and (iOriginal <= BW) then
            begin //Only Calaculate jPrimeRotated and jOriginal if Necessary
              jPrimeRotated := ROUND(iPrime * sinTheta + jPrimeCosTheta);
              jOriginal := (jPrimeRotated - 1) div 2 + jRotationAxis;
              if (jOriginal >= 0) and (jOriginal <= BH) then
                begin
                  // Assign pixel from rotated space to current pixel in BitmapRotated
                  RowOriginal   := Pointer(Integer(POriginal) + (jOriginal * ScanLineBytes));
                  RowRotated[i] := RowOriginal[iOriginal];
                end
              else
{$IFDEF Paletted}
                RowRotated[i] := 0;
{$ELSE}
                RowRotated[i] := Black;
{$ENDIF}
            end
          else
{$IFDEF Paletted}
            RowRotated[i] := 0;
{$ELSE}
            RowRotated[i] := Black;
{$ENDIF}
        end;
      Dec(Integer(RowRotated), ScanLineBytes); //Move Pointer to Previous BitmapRotated Scanline
    end;
end; {RotateBitmap}

function Tsidebarform.ZNCC(Bild1, Bild2: TBitmap):Single;
var
  x, y:integer;
  P1,P2:array[0..31] of PRGBTripleArray;

  a, b, zaehler, nenner1, nenner2, nenner, summe1, summe2, mean1, mean2:single;

  ZNCCvalue:Extended;
begin
  // ZeroMeanNormalizedCross-Correlation (ZNCC) (wird MAXIMAL bei guter Übereinstimmung)
  zaehler:=0.0;
  nenner1:=0.0;
  nenner2:=0.0;
  summe1:=0.0;
  summe2:=0.0;

  // Bildformat auf 24bit reduzieren (also ohne Alpha-Kanal)
  Bild1.PixelFormat := pf24bit;
  Bild2.PixelFormat := pf24bit;

  // Summen bilden
  for y:=0 to Bild1.Height-1 do
  begin
    P1[y]:=Bild1.ScanLine[y];
    P2[y]:=Bild2.ScanLine[y];

    for x:=0 to Bild1.Width-1 do
    begin
      summe1:=summe1+RGB2TColor(P1[y][x].rgbtRed, P1[y][x].rgbtGreen, P1[y][x].rgbtBlue);
      summe2:=summe2+RGB2TColor(P2[y][x].rgbtRed, P2[y][x].rgbtGreen, P2[y][x].rgbtBlue);
    end;
  end;

  mean1:=(1/power((Bild1.Width-1)+(Bild1.Height-1)+1,2))*summe1;
  mean2:=(1/power((Bild1.Width-1)+(Bild1.Height-1)+1,2))*summe2;
  for x:=0 to Bild1.Width-1 do
  begin
    for y:=0 to Bild1.Height-1 do
    begin
      a:=RGB2TColor(P1[y][x].rgbtRed, P1[y][x].rgbtGreen, P1[y][x].rgbtBlue)-mean1;
      b:=RGB2TColor(P2[y][x].rgbtRed, P2[y][x].rgbtGreen, P2[y][x].rgbtBlue)-mean2;
      zaehler:=zaehler+(a*b);
      nenner1:=nenner1+power(a, 2);
      nenner2:=nenner2+power(b, 2);
    end;
  end;
  nenner:=sqrt(nenner1*nenner2);

  if nenner>0 then
    ZNCCvalue:=zaehler/nenner
  else
    ZNCCvalue:=0.0;

  result:=ZNCCvalue*100;
end;

procedure Tsidebarform.FormDestroy(Sender: TObject);
begin
  PictureToCompare1.Free;
  PictureToCompare2.Free;
  PictureToCompare2Rotated.Free;
end;

procedure Tsidebarform.RefreshGoboList;
var
  i,j:integer;
  rect:Trect;
begin
  Paintbox1.Canvas.Brush.Color:=clBlack;
  Paintbox1.Canvas.Rectangle(0, 0, Paintbox1.Width, Paintbox1.Height);

  setlength(GoboButtons, 0);
  for i:=GoboOffset to length(GoboList)-1 do
  begin
    if (i>(20+GoboOffset)) or (i>=length(GoboList)) then break; // nur maximal 21 Gobos anzeigen

    for j:=0 to mainform.GoboPictures.Items.Count-1 do
    begin
      if GoboList[i]=mainform.GoboPictures.Items.Items[j].Name then
      begin
        rect.Left:=(i-GoboOffset)*32-(trunc((i-GoboOffset)/7)*224);
        rect.Top:=trunc((i-GoboOffset)/7)*32;
        rect.Right:=((i-GoboOffset)*32-(trunc((i-GoboOffset)/7)*224)+32);
        rect.Bottom:=(trunc((i-GoboOffset)/7)*32)+32;

        mainform.GoboPictures.Items.Items[j].PngImage.Draw(Paintbox1.Canvas, rect);
        setlength(GoboButtons, length(GoboButtons)+1);
        GoboButtons[length(GoboButtons)-1]:=mainform.GoboPictures.Items.Items[j].Name;

        break;
      end;
    end;
  end;
end;

procedure Tsidebarform.RefreshGoboCorrelation;
var
  i,j,k,m:integer;
  rect:Trect;
  MaxValueGobo1, MaxValueGobo2, ZNCCResult:single;
  GoboStepCount,GoboStep:integer;
begin
  rect.Left:=0;
  rect.Top:=0;
  rect.Right:=32;
  rect.Bottom:=32;

  GoboStepCount:=0;
  GoboStep:=0;
  for i:=0 to length(mainform.devices)-1 do
  begin
    GoboStepCount:=GoboStepCount+length(mainform.devices[i].gobos)+length(mainform.devices[i].gobos2);
  end;
  GoboStepCount:=GoboStepCount*mainform.GoboPictures.Items.Count;

  ProgressScreenSmall.Label1.Caption:=_('Gobo-Korrelation wird aktualisiert...');
  ProgressScreenSmall.Label2.Caption:=_('Es werden ')+inttostr(GoboStepCount)+_(' Gobos verglichen.');
  ProgressScreenSmall.ProgressBar1.Max:=GoboStepCount;
  ProgressScreenSmall.Show;

  // Alle Geräte durchiterieren
  for i:=0 to length(mainform.devices)-1 do
  begin
    // Gobo1
    if mainform.devices[i].hasGobo then
    begin
      for j:=0 to length(mainform.devices[i].gobos)-1 do
      begin
        // Kreukorrelation für jedes Gobo durchführen
        setlength(mainform.devices[i].bestgobos[j], mainform.GoboPictures.Items.Count);

        // Aktuelles Geräte-Gobo finden
        for k:=0 to mainform.GoboPictures.Items.Count-1 do
        begin
          if mainform.devices[i].gobos[j]=mainform.GoboPictures.Items.Items[k].Name then
          begin
            // Gerätegobo in Liste gefunden -> Bild kopieren
            mainform.GoboPictures.Items.Items[k].PngImage.Draw(PictureToCompare1.Canvas, rect);
            break;
          end;
        end;

        // Alle installierten Gobos durchsuchen und entsprechend Wertigkeitsliste erstellen
        for k:=0 to mainform.GoboPictures.Items.Count-1 do
        begin
          mainform.GoboPictures.Items.Items[k].PngImage.Draw(PictureToCompare2.Canvas, rect);
          
          // Kreuz-Korrelation ausführen
          MaxValueGobo1:=0;
          for m:=0 to 23 do
          begin
            if MaxValueGobo1>90 then break; // wir brauchen ja keine 100% übereinstimmung

            RotateBitmap(PictureToCompare2, PictureToCompare2Rotated, 16, 16, m*15);
            ZNCCResult:=ZNCC(PictureToCompare1, PictureToCompare2rotated);
            if ZNCCResult>MaxValueGobo1 then
            begin
              MaxValueGobo1:=ZNCCResult;
            end;
          end;
          mainform.devices[i].bestgobos[j][k].GoboName:=mainform.GoboPictures.Items.Items[k].Name;
          mainform.devices[i].bestgobos[j][k].Percent:=MaxValueGobo1;

          GoboStep:=GoboStep+1;
          if (GoboStep mod 10 = 0) then
          begin
            ProgressScreenSmall.ProgressBar1.Position:=GoboStep;
            ProgressScreenSmall.Refresh;
          end;
        end;
      end;
    end;

    // Gobo2
    if mainform.devices[i].hasGobo2 then
    begin
      for j:=0 to length(mainform.devices[i].gobos2)-1 do
      begin
        // Kreukorrelation für jedes Gobo durchführen
        setlength(mainform.devices[i].bestgobos2[j], mainform.GoboPictures.Items.Count);

        // Aktuelles Geräte-Gobo finden
        for k:=0 to mainform.GoboPictures.Items.Count-1 do
        begin
          if mainform.devices[i].gobos2[j]=mainform.GoboPictures.Items.Items[k].Name then
          begin
            // Gerätegobo in Liste gefunden -> Bild kopieren
            mainform.GoboPictures.Items.Items[k].PngImage.Draw(PictureToCompare1.Canvas, rect);
            break;
          end;
        end;

        // Alle installierten Gobos durchsuchen und entsprechend Wertigkeitsliste erstellen
        for k:=0 to mainform.GoboPictures.Items.Count-1 do
        begin
          mainform.GoboPictures.Items.Items[k].PngImage.Draw(PictureToCompare2.Canvas, rect);

          // Kreuz-Korrelation ausführen
          MaxValueGobo2:=0;
          for m:=0 to 23 do
          begin
            if MaxValueGobo2>90 then break; // wir brauchen ja keine 100% übereinstimmung

            RotateBitmap(PictureToCompare2, PictureToCompare2Rotated, 16, 16, m*15);
            ZNCCResult:=ZNCC(PictureToCompare1, PictureToCompare2rotated);
            if ZNCCResult>MaxValueGobo2 then
            begin
              MaxValueGobo2:=ZNCCResult;
            end;
          end;

          mainform.devices[i].bestgobos2[j][k].GoboName:=mainform.GoboPictures.Items.Items[k].Name;
          mainform.devices[i].bestgobos2[j][k].Percent:=MaxValueGobo2;

          GoboStep:=GoboStep+1;
          if (GoboStep mod 10 = 0) then
          begin
            ProgressScreenSmall.ProgressBar1.Position:=GoboStep;
            ProgressScreenSmall.Refresh;
          end;
        end;
      end;
    end;
  end;

  ProgressScreenSmall.Hide;
end;

procedure Tsidebarform.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  OverGoboButton:=(trunc(X/32)+1)+(trunc(Y/32)*7)-1{+GoboOffset};
  if (OverGoboButton<length(GoboButtons)) and (OverGoboButton>-1) then
  begin
    change(Paintbox1);
  end;
  grafischebuehnenansicht.doimmediaterefresh:=true;
end;

procedure Tsidebarform.Button3Click(Sender: TObject);
begin
  GoboOffset:=GoboOffset+1;
  RefreshGoboList;
end;

procedure Tsidebarform.Button4Click(Sender: TObject);
begin
  if GoboOffset>=1 then
    GoboOffset:=GoboOffset-1;
  RefreshGoboList;
end;

procedure Tsidebarform.REnter(Sender: TObject);
begin
  dontchangecolorfield:=false;
  dontchangesliders:=true;
end;

procedure Tsidebarform.RExit(Sender: TObject);
begin
  dontchangesliders:=false;
end;

procedure Tsidebarform.colorpickerChange(Sender: TObject);
var
  Red,Green,Blue:byte;
begin
  if not usersetting then exit;

  timer:=0;

  TColor2RGB(colorpicker.SelectedColor,Red,Green,Blue);

  if not dontchangesliders then
  begin
    R.Position:=255-Red;
    G.Position:=255-Green;
    B.position:=255-Blue;
  end;
end;

procedure Tsidebarform.colorpickerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  usersetting:=true;
  timer:=0;
  dontchangecolorfield:=true;
end;

end.
