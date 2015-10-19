unit buehnenansicht;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, Menus, Buttons, Registry,
  JvComponent, JvZlibMultiple, JvExExtCtrls, Printers, JvOfficeColorPanel,
  jpeg, pngimage;

const
  maxres=255;
  chan=512; // maximale Kanalzahl für PC_DIMMER

type
// Thread für Ansichtaktualisierung deklarieren
  TUpdateEvent = procedure () of object;
  TUpdateThread = class(TThread)
  private
    FUpdateEvent:TUpdateEvent;
  protected
    procedure Execute; override;
  public
    constructor create(UpdateEvent:TUpdateEvent);
  end;

  TCallbackValues = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;

  TDevice = record
    channel: Word;
    color: TColor;
    picture:string[255];
    picturesize:Byte;
    pictureangle:Byte;
    picturefliphor:boolean;
    pictureflipver:boolean;
    pictureispng:boolean;
    top: integer;
    left: integer;
  end;

  TBuehnenansicht = record
    Buehnenansicht_background:string[255];
    Buehnenansicht_width:integer;
    Buehnenansicht_height:integer;
    Buehnenansicht_panel:boolean;
  end;

type
  Tgrafischebuehnenansicht = class(TForm)
    stage: TImage;
    Button5: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    Button6: TButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Bevel4: TBevel;
    Label10: TLabel;
    Referenzbild: TImage;
    Label3: TLabel;
    zoom: TComboBox;
    Label11: TLabel;
    Referenzbild2: TImage;
    CheckBox1: TCheckBox;
    PopupMenu1: TPopupMenu;
    Panelausblenden1: TMenuItem;
    N1: TMenuItem;
    ffnen1: TMenuItem;
    Speichern1: TMenuItem;
    Zurcksetzen1: TMenuItem;
    Schlieen1: TMenuItem;
    N2: TMenuItem;
    Hintergrundndern1: TMenuItem;
    extanzeigen1: TMenuItem;
    Compress: TJvZlibMultiple;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    BhnenansichtalsBilddateispeichern1: TMenuItem;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Bhnenansichtausdrucken1: TMenuItem;
    Button2: TButton;
    Shape1: TShape;
    Label1: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel5: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Bevel6: TBevel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Bevel7: TBevel;
    Label20: TLabel;
    Label21: TLabel;
    Bevel8: TBevel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Bevel9: TBevel;
    NeuesGerthinzufgen1: TMenuItem;
    N3: TMenuItem;
    devicepicture_popup: TPopupMenu;
    Gertebildndern1: TMenuItem;
    Gertlschen1: TMenuItem;
    Kanalnummerndern1: TMenuItem;
    N4: TMenuItem;
    Kanalnamenndern1: TMenuItem;
    colorbox1: TJvOfficeColorPanel;
    Label14: TLabel;
    CheckBox2: TCheckBox;
    GroeFarbanzeige1: TMenuItem;
    CheckBox4: TCheckBox;
    Label22: TLabel;
    TrackBar1: TTrackBar;
    RotateBtn: TButton;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Label23: TLabel;
    FlipHorBtn: TButton;
    FlipVerBtn: TButton;
    procedure device_pictureMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpdateLevels();
    procedure FormCreate(Sender: TObject);
    procedure device_progressMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure device_pictureMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DeviceLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DeviceNumberMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DeviceColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure zoomChange(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panelausblenden1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure extanzeigen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure stageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure stageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure stageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BhnenansichtalsBilddateispeichern1Click(Sender: TObject);
    procedure Bhnenansichtausdrucken1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure openscene(scenefilename:string);
    procedure savescene(scenefilename:string);
    procedure createdevices(i:integer);
    procedure deletedevice(i:integer);
    procedure Gertebildndern1Click(Sender: TObject);
    procedure Gertlschen1Click(Sender: TObject);
    procedure Kanalnamenndern1Click(Sender: TObject);
    procedure Kanalnummerndern1Click(Sender: TObject);
    procedure colorbox1ColorChange(Sender: TObject);
    procedure colorbox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroeFarbanzeige1Click(Sender: TObject);
    procedure NewPanel;
    procedure CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Trackbar1Change(Sender: TObject);
    procedure searchpicture(Device: integer);
    procedure RotateBtnClick(Sender: TObject);
    procedure SmoothRotate(var aPng: TPNGObject; Angle: Extended; Device: integer);
    procedure FlipHorBtnClick(Sender: TObject);
    procedure FlipVerBtnClick(Sender: TObject);
    procedure VertikalSpiegeln(Bitmap : TBitmap; Device:Integer);
    procedure HorizontalSpiegeln(const Bitmap : TBitmap; Device:Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    startingup:boolean;
    buehnenansicht_record:TBuehnenansicht;
    Device_record:array of TDevice;
    workingdirectory:string;
    screentimeronline:boolean;
		aktualisieren:boolean;
    aktualisierechannel:array[1..chan] of boolean;
    minonedeviceselected:boolean;

    channelvalue:array[1..chan] of integer;
    channelnames:array[1..chan] of string;

    device_picture:array of TImage;
    device_progress:array of TProgressBar;
    device_label:array of TLabel;
    device_number:array of TLabel;
    device_selected:array of boolean;
    device_colorshape:array of TShape;

    Button:TButton;
    scrolling:boolean;
    x1,y1,x2,y2:integer;
    RefreshDLLValues:TCallbackValues;
    RefreshDLLNames:TCallbackNames;
    lastchan:Word;
    Filestream:TFileStream;
		actualdevice:Word;
	  filename,filepath:string;
    shutdown:boolean;
  end;

	procedure LockWindow(const Handle: HWND);
	procedure UnLockWindow(const Handle: HWND);

var
  grafischebuehnenansicht: Tgrafischebuehnenansicht;

implementation

{$R *.dfm}

procedure Tgrafischebuehnenansicht.VertikalSpiegeln(Bitmap : TBitmap; Device:Integer);
var j,w :Integer;
    help:TBitmap;
begin
  device_record[Device].pictureflipver:=not device_record[Device].pictureflipver;
  help := TBitmap.Create;
  try
    help.Width       := Bitmap.Width;
    help.Height      := Bitmap.Height;
    help.PixelFormat := Bitmap.PixelFormat;
    w := Bitmap.Width*sizeof(TRGBTriple);
    for j := 0 to Bitmap.Height-1 do
      move(Bitmap.Scanline[j]^,Help.Scanline[Bitmap.Height - 1 - j]^,w);
    Bitmap.Assign(help);
  finally
    help.free;
  end;
end;

procedure Tgrafischebuehnenansicht.HorizontalSpiegeln(const Bitmap: TBitmap; Device:Integer);
type
    TRGBArray=array[0..0] of TRGBTriple;
var i,j,w: Integer;
    rowin,rowout: ^TRGBArray;
begin
  device_record[Device].picturefliphor:=not device_record[Device].picturefliphor;
  w := bitmap.width*sizeof(TRGBTriple);
  Getmem(rowIn,w);
  try
    for j:= 0 to Bitmap.Height-1 do
    begin
      move(Bitmap.Scanline[j]^,rowin^,w);
      rowout := Bitmap.Scanline[j];
      for i := 0 to Bitmap.Width-1 do
        rowout[i] := rowin[Bitmap.Width-1-i];
    end;
    bitmap.Assign(bitmap);
  finally
    Freemem(rowin);
  end;
end;

procedure Tgrafischebuehnenansicht.SmoothRotate(var aPng: TPNGObject; Angle: Extended; Device: integer);

  {Supporting functions}
  function TrimInt(i, Min, Max: Integer): Integer;
  begin
    if      i>Max then Result:=Max
    else if i<Min then Result:=Min
    else               Result:=i;
  end;
  function IntToByte(i:Integer):Byte;
  begin
    if      i>255 then Result:=255
    else if i<0   then Result:=0
    else               Result:=i;
  end;
  function Min(A, B: Double): Double;
  begin
    if A < B then Result := A else Result := B;
  end;
  function Max(A, B: Double): Double;
  begin
    if A > B then Result := A else Result := B;
  end;
  function Ceil(A: Double): Integer;
  begin
    Result := Integer(Trunc(A));
    if Frac(A) > 0 then
      Inc(Result);
  end;
 
  {Calculates the png new size}
  function newsize: tsize;
  var
    fRadians: Extended;
    fCosine, fSine: Double;
    fPoint1x, fPoint1y, fPoint2x, fPoint2y, fPoint3x, fPoint3y: Double;
    fMinx, fMiny, fMaxx, fMaxy: Double;
  begin
    {Convert degrees to radians}
    fRadians := (2 * PI * Angle) / 360;
 
    fCosine := abs(cos(fRadians));
    fSine := abs(sin(fRadians));
 
    fPoint1x := (-apng.Height * fSine);
    fPoint1y := (apng.Height * fCosine);
    fPoint2x := (apng.Width * fCosine - apng.Height * fSine);
    fPoint2y := (apng.Height * fCosine + apng.Width * fSine);
    fPoint3x := (apng.Width * fCosine);
    fPoint3y := (apng.Width * fSine);
 
    fMinx := min(0,min(fPoint1x,min(fPoint2x,fPoint3x)));
    fMiny := min(0,min(fPoint1y,min(fPoint2y,fPoint3y)));
    fMaxx := max(fPoint1x,max(fPoint2x,fPoint3x));
    fMaxy := max(fPoint1y,max(fPoint2y,fPoint3y));
 
    Result.cx := ceil(fMaxx-fMinx);
    Result.cy := ceil(fMaxy-fMiny);
  end;
type
 TFColor  = record b,g,r:Byte end;
var
Top, Bottom, Left, Right, eww,nsw, fx,fy, wx,wy: Extended;
cAngle, sAngle:   Double;
xDiff, yDiff, ifx,ify, px,py, ix,iy, x,y, cx, cy: Integer;
nw,ne, sw,se: TFColor;
anw,ane, asw,ase: Byte;
P1,P2,P3:Pbytearray;
A1,A2,A3: pbytearray;
dst: TPNGObject;
IsAlpha: Boolean;
new_colortype: Integer;
begin
  if device_record[Device].pictureangle<3 then
    device_record[Device].pictureangle:=device_record[Device].pictureangle+1
  else
    device_record[Device].pictureangle:=0;

  {Only allows RGB and RGBALPHA images}
  if not (apng.Header.ColorType in [COLOR_RGBALPHA, COLOR_RGB]) then
    raise Exception.Create('Only COLOR_RGBALPHA and COLOR_RGB formats' +
    ' are supported');
  IsAlpha := apng.Header.ColorType in [COLOR_RGBALPHA];
  if IsAlpha then new_colortype := COLOR_RGBALPHA else
    new_colortype := COLOR_RGB;
 
  {Creates a copy}
  dst := tpngobject.Create;
  with newsize do
    dst.createblank(new_colortype, 8, cx, cy);
  cx := dst.width div 2; cy := dst.height div 2;
 
  {Gather some variables}
  Angle:=angle;
  Angle:=-Angle*Pi/180;
  sAngle:=Sin(Angle);
  cAngle:=Cos(Angle);
  xDiff:=(Dst.Width-apng.Width)div 2;
  yDiff:=(Dst.Height-apng.Height)div 2;
 
  {Iterates over each line}
  for y:=0 to Dst.Height-1 do
  begin
    P3:=Dst.scanline[y];
    if IsAlpha then A3 := Dst.AlphaScanline[y];
    py:=2*(y-cy)+1;
    {Iterates over each column}
    for x:=0 to Dst.Width-1 do
    begin
      px:=2*(x-cx)+1;
      fx:=(((px*cAngle-py*sAngle)-1)/ 2+cx)-xDiff;
      fy:=(((px*sAngle+py*cAngle)-1)/ 2+cy)-yDiff;
      ifx:=Round(fx);
      ify:=Round(fy);
 
      {Only continues if it does not exceed image boundaries}
      if(ifx>-1)and(ifx<apng.Width)and(ify>-1)and(ify<apng.Height)then
      begin
        {Obtains data to paint the new pixel}
        eww:=fx-ifx;
        nsw:=fy-ify;
        iy:=TrimInt(ify+1,0,apng.Height-1);
        ix:=TrimInt(ifx+1,0,apng.Width-1);
        P1:=apng.scanline[ify];
        P2:=apng.scanline[iy];
        if IsAlpha then A1 := apng.alphascanline[ify];
        if IsAlpha then A2 := apng.alphascanline[iy];
        nw.r:=P1[ifx*3];
        nw.g:=P1[ifx*3+1];
        nw.b:=P1[ifx*3+2];
        if IsAlpha then anw:=A1[ifx];
        ne.r:=P1[ix*3];
        ne.g:=P1[ix*3+1];
        ne.b:=P1[ix*3+2];
        if IsAlpha then ane:=A1[ix];
        sw.r:=P2[ifx*3];
        sw.g:=P2[ifx*3+1];
        sw.b:=P2[ifx*3+2];
        if IsAlpha then asw:=A2[ifx];
        se.r:=P2[ix*3];
        se.g:=P2[ix*3+1];
        se.b:=P2[ix*3+2];
        if IsAlpha then ase:=A2[ix];
 
 
        {Defines the new pixel}
        Top:=nw.b+eww*(ne.b-nw.b);
        Bottom:=sw.b+eww*(se.b-sw.b);
        P3[x*3+2]:=IntToByte(Round(Top+nsw*(Bottom-Top)));
        Top:=nw.g+eww*(ne.g-nw.g);
        Bottom:=sw.g+eww*(se.g-sw.g);
        P3[x*3+1]:=IntToByte(Round(Top+nsw*(Bottom-Top)));
        Top:=nw.r+eww*(ne.r-nw.r);
        Bottom:=sw.r+eww*(se.r-sw.r);
        P3[x*3]:=IntToByte(Round(Top+nsw*(Bottom-Top)));
 
        {Only for alpha}
        if IsAlpha then
        begin
          Top:=anw+eww*(ane-anw);
          Bottom:=asw+eww*(ase-asw);
          A3[x]:=IntToByte(Round(Top+nsw*(Bottom-Top)));
        end;
 
      end;
    end;
  end;
 
  apng.assign(dst);
  dst.free;
end;

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

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure LockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
end;

procedure UnlockWindow(const Handle: HWND);
begin
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0,
    RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

function levelstr(pos,max:integer):string;
begin
  result:='';
  str((pos*100) div max,result); result:=result+'%';
end;

procedure Tgrafischebuehnenansicht.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
begin
	shutdown:=false;
	startingup:=true;
	Paintbox1.canvas.Pen.mode:=pmNotXor;
  Paintbox1.canvas.Pen.style:=psDot;

  workingdirectory:=ExtractFilePath(paramstr(0));

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
        if not LReg.ValueExists('Last channel') then
          LReg.WriteInteger('Last channel',128);
        lastchan:=LReg.ReadInteger('Last channel');
        if lastchan<32 then lastchan:=32;
        if lastchan>chan then lastchan:=chan;

        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
	        if not LReg.ValueExists('Stageview Plugin - Last Stage') then
	          LReg.WriteBool('Stageview Plugin - Last Stage',true);
	        CheckBox3.Checked:=LReg.ReadBool('Stageview Plugin - Last Stage');
	      end;
      end;
    end;
  end;
  LReg.CloseKey;

  buehnenansicht_record.Buehnenansicht_width:=700;
  buehnenansicht_record.Buehnenansicht_height:=400;
  buehnenansicht_record.Buehnenansicht_panel:=true;

  // Kompatibilität zu letzten Version:
  if FileExists(workingdirectory+'Projekt\Bühnenansicht') then
  begin
  	MoveFile(PCHar(workingdirectory+'Projekt\Bühnenansicht'),PChar(workingdirectory+'Projekt\Bühnenansicht~'));
    CreateDirectory(PChar(workingdirectory+'Projekt\Bühnenansicht'),nil);
		MoveFile(PCHar(workingdirectory+'Projekt\Bühnenansicht~'),PChar(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht'));
  end;

  if ((CheckBox3.Checked) and (FileExists(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht'))) then
  	openscene(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht');

  TUpdateThread.create(UpdateLevels);
  startingup:=false;
end;

procedure Tgrafischebuehnenansicht.device_progressMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if Shift=[ssLeft] then
  begin
  for i:=0 to length(Device_record)-1 do
  if Sender=TProgressBar(device_progress[i]) then
  begin
    device_progress[i].Position:=trunc((x / device_progress[i].width)*255);
    device_progress[i].Position:=trunc((x / device_progress[i].width)*255)-1;
    device_progress[i].Position:=trunc((x / device_progress[i].width)*255);
    channelvalue[Device_record[i].channel]:=device_progress[i].Position;
	  RefreshDLLValues(Device_record[i].channel,channelvalue[Device_record[i].channel],channelvalue[Device_record[i].channel],0);
  end;
  end;
end;

procedure Tgrafischebuehnenansicht.device_pictureMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i,k:integer;
begin
  for i:=0 to length(Device_record)-1 do
  if Sender=TImage(device_picture[i]) then
  begin
    device_picture[i].Hint:=inttostr(i)+' ('+channelnames[device_record[i].channel]+')';

  if Shift = [ssLeft] then
  begin
	  if ((Sender=TImage(device_picture[i])) and (device_selected[i]=false)) then
	  begin
	    if ((device_picture[i].Left+x-(device_picture[i].Width div 2))>=0) and ((device_picture[i].Left+x-(device_picture[i].Width div 2))<=paintbox1.Width-device_picture[i].Width) then device_picture[i].Left:=device_picture[i].Left+x-(device_picture[i].Width div 2);
	    if ((device_picture[i].Top+y-(device_picture[i].Height div 2))>=0) and ((device_picture[i].Top+y-(device_picture[i].Height div 2))<=paintbox1.Height-device_picture[i].Height) then device_picture[i].Top:=device_picture[i].Top+y-(device_picture[i].Height div 2);
		  device_picture[i].Refresh;
	    Device_record[i].left:=device_picture[i].left;
	    Device_record[i].top:=device_picture[i].top;

	    device_progress[i].Top:=device_picture[i].Top+device_picture[i].Height;
	    device_progress[i].left:=device_picture[i].left;

	    device_label[i].Top:=device_picture[i].Top+device_picture[i].Height+8;
	    device_label[i].left:=device_picture[i].left;

	    device_number[i].Top:=device_picture[i].Top+Device_record[i].picturesize*16-10;
	    device_number[i].Left:=device_picture[i].Left;

	    device_colorshape[i].Top:=device_picture[i].Top;
	    device_colorshape[i].Left:=device_picture[i].Left+Device_record[i].picturesize*16-10;
	  end else
	  begin
		  for k:=0 to length(Device_record)-1 do
		    if ((device_selected[k])) then
		    begin
		      if ((device_picture[k].Left+x-(device_picture[k].Width div 2))>=0) and ((device_picture[k].Left+x-(device_picture[k].Width div 2))<=(paintbox1.Width-device_picture[k].Width)) then device_picture[k].Left:=device_picture[k].Left+x-(Device_record[i].picturesize*8);
		      if ((device_picture[k].Top+y-(device_picture[k].Height div 2))>=0) and ((device_picture[k].Top+y-(device_picture[k].Height div 2))<=(paintbox1.Height-device_picture[k].Height)) then device_picture[k].Top:=device_picture[k].Top+y-(Device_record[i].picturesize*8);
				  device_picture[k].Refresh;
		      Device_record[k].left:=device_picture[k].left;
		      Device_record[k].top:=device_picture[k].top;

		      device_progress[k].Top:=device_picture[k].Top+device_picture[k].Height;
		      device_progress[k].left:=device_picture[k].left;

		      device_label[k].Top:=device_picture[k].Top+device_picture[k].Height+8;
		      device_label[k].left:=device_picture[k].left;

		      device_number[k].Top:=device_picture[k].Top+Device_record[k].picturesize*16-10;
		      device_number[k].Left:=device_picture[k].Left;

		      device_colorshape[k].Top:=device_picture[k].Top;
		      device_colorshape[k].Left:=device_picture[k].Left+Device_record[k].picturesize*16-10;
		    end;
		end;
  end;
end;
end;

procedure Tgrafischebuehnenansicht.device_pictureMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i:integer;
begin
  for i:=0 to length(Device_record)-1 do
  	if Sender=TImage(device_picture[i]) then
    begin
    actualdevice:=i;

	  if (Shift=[ssCtrl]) and (Button=mbLeft) then
	    device_selected[i]:=not device_selected[i];

 	  if (Shift=[ssAlt]) and (Button=mbLeft) then
		begin
	    OpenDialog1.Filter:='Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*';
	    OpenDialog1.InitialDir:=workingdirectory+'Devicepictures';
	    opendialog1.FileName:='';
	    If OpenDialog1.Execute then
	    begin
	      device_picture[actualdevice].Picture.LoadFromFile(OpenDialog1.Filename);
	      device_record[actualdevice].picture:=OpenDialog1.Filename;
        if copy(device_record[actualdevice].picture,length(device_record[actualdevice].picture)-2,3)='png' then
          Device_record[actualdevice].pictureispng:=true
        else
          Device_record[actualdevice].pictureispng:=false;
	    end;
    end;

    if device_selected[i] then
    begin
      device_label[i].Font.Color:=clRed;
      device_number[i].Font.Color:=clRed;
    end else
    begin
      device_label[i].Font.Color:=clBlack;
      device_number[i].Font.Color:=clBlack;
    end;

	  if (Shift=[ssShift]) and (Button=mbLeft) then
	    deletedevice(i);

		panel2.Refresh;
	end;
end;

procedure Tgrafischebuehnenansicht.SpeedButton1Click(Sender: TObject);
begin
if messagedlg('Bühnenansicht zurücksetzen?',mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
		NewPanel;
  end;
end;

procedure Tgrafischebuehnenansicht.Button6Click(Sender: TObject);
begin
  OpenDialog1.Filter:='Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*';
  OpenDialog1.InitialDir:=workingdirectory+'Projekt\';
  If OpenDialog1.Execute then
  begin
    Stage.Picture.LoadFromFile(OpenDialog1.Filename);
    buehnenansicht_record.Buehnenansicht_background:=OpenDialog1.Filename;

    paintbox1.Canvas.Refresh;
  end;
end;

procedure Tgrafischebuehnenansicht.SpeedButton4Click(Sender: TObject);
begin
  opendialog1.Title:='PC_DIMMER Bühnenansicht öffnen...';
  opendialog1.Filter:='PC_DIMMER Bühnenansicht (*.pcdstge)|*.pcdstge|*.*|*.*';
  opendialog1.FileName:='';
  opendialog1.DefaultExt:='*.pcdstge';
  if opendialog1.execute then
    openscene(opendialog1.Filename);
end;

procedure Tgrafischebuehnenansicht.Button5Click(Sender: TObject);
begin
  close;
end;

procedure Tgrafischebuehnenansicht.SpeedButton3Click(Sender: TObject);
begin
  savedialog1.Title:='PC_DIMMER Bühnenansicht speichern...';
  savedialog1.Filter:='PC_DIMMER Bühnenansicht (*.pcdstge)|*.pcdstge|*.*|*.*';
  savedialog1.FileName:='';
  savedialog1.DefaultExt:='*.pcdstge';
  if savedialog1.execute then
    savescene(savedialog1.FileName);
end;

procedure Tgrafischebuehnenansicht.DeviceLabelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
  channelname:string[255];
begin
  if Button=mbRight then
  begin
    for i:=0 to length(Device_record)-1 do
      begin
        if Sender=TLabel(device_label[i]) then
        begin
          channelnames[Device_record[i].channel]:=InputBox('Beschriftung für "'+channelNames[Device_record[i].channel]+'"','Bitte geben Sie eine neue Bezeichnung für den aktuellen Kanal ein:',channelnames[Device_record[i].channel]);
          channelname:=channelnames[Device_record[i].channel]+#0;
          RefreshDLLNames(Device_record[i].channel,@channelname);
        end;
      end;
  end;
end;

procedure Tgrafischebuehnenansicht.DeviceNumberMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,oldvalue,channel:integer;
begin
	// Kanalnummer ändern
  //Device_record[i].channel
  for i:=0 to length(Device_record)-1 do
  if Sender=TLabel(device_number[i]) then
  begin
	  oldvalue:=Device_record[i].channel;
	  try
	  	channel:=strtoint(InputBox('Kanaleinstellung','Welcher Kanal soll für dieses Gerät gelten:',inttostr(Device_record[i].channel)));
      if channel>lastchan then
      	Device_record[i].channel:=lastchan
			else if channel<1 then
      	Device_record[i].channel:=1
      else
      	Device_record[i].channel:=channel;

//			screenupdate.Enabled:=true;
      aktualisierechannel[channel]:=true;
			aktualisieren:=true;
	  except
	  	Device_record[i].channel:=oldvalue;
	  end;
  end;
end;

procedure Tgrafischebuehnenansicht.DeviceColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i:integer;
begin
	//Farbe ändern
  for i:=0 to length(Device_record)-1 do
  if Sender=TShape(device_colorshape[i]) then
  begin
  	actualdevice:=i;
	  colorbox1.Top:=device_picture[actualdevice].Top;
	  colorbox1.Left:=device_picture[actualdevice].Left+32;
    colorbox1.Color:=device_record[actualdevice].color;
	  colorbox1.BringToFront;
	  colorbox1.Visible:=true;
  end;
end;

procedure Tgrafischebuehnenansicht.zoomChange(Sender: TObject);
begin
  case zoom.ItemIndex of
  0:
  begin
    stage.Stretch:=false;
    stage.Proportional:=false;
  end;
  1:
  begin
    stage.Stretch:=true;
    stage.Proportional:=true;
  end;
end;
end;

procedure Tgrafischebuehnenansicht.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if checkbox1.Checked then
  begin
  for i:=0 to length(Device_record)-1 do
    device_label[i].Visible:=true;
  end else
  begin
  for i:=0 to length(Device_record)-1 do
    device_label[i].Visible:=false;
  end;
end;

procedure Tgrafischebuehnenansicht.Panelausblenden1Click(Sender: TObject);
begin
  if panel1.Visible then
  begin
    panel1.Visible:=false;
    grafischebuehnenansicht.Width:=grafischebuehnenansicht.Width-panel1.Width;
  end else
  begin
    panel1.Visible:=true;
    grafischebuehnenansicht.Width:=grafischebuehnenansicht.Width+panel1.Width;
  end;
end;

procedure Tgrafischebuehnenansicht.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
	if not shutdown then
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
	        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
		        LReg.CreateKey(ExtractFileName(GetModulePath));
		      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
		      begin
							LReg.WriteBool('Showing Plugin',false);
		      end;
	      end;
	    end;
	  end;
	  LReg.CloseKey;
	end;
  
  buehnenansicht_record.Buehnenansicht_width:=grafischebuehnenansicht.Width;
  buehnenansicht_record.Buehnenansicht_height:=grafischebuehnenansicht.Height;
  buehnenansicht_record.Buehnenansicht_panel:=panel1.Visible;
end;

procedure Tgrafischebuehnenansicht.extanzeigen1Click(Sender: TObject);
begin
  Checkbox1.Checked:=not Checkbox1.Checked;
  CheckBox1MouseUp(Sender,mbLeft,[ssLeft],0,0);
end;

procedure Tgrafischebuehnenansicht.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
	        LReg.WriteBool('Stageview Plugin - Last Stage',CheckBox3.Checked);
          LReg.WriteInteger('PosX',grafischebuehnenansicht.Left);
          LReg.WriteInteger('PosY',grafischebuehnenansicht.Top);
        end;
      end;
    end;
  end;
  LReg.CloseKey;

    buehnenansicht_record.Buehnenansicht_width:=grafischebuehnenansicht.Width;
    buehnenansicht_record.Buehnenansicht_height:=grafischebuehnenansicht.Height;
    buehnenansicht_record.Buehnenansicht_panel:=panel1.Visible;

  	If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
	   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
  	If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Bühnenansicht') then
	   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Bühnenansicht');

    savescene(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht');
end;

procedure Tgrafischebuehnenansicht.FormShow(Sender: TObject);
var
  LReg:TRegistry;
  i,k,temp:integer;
  x:TPNGObject;
begin
//  grafischebuehnenansicht.DoubleBuffered:=true;
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
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
					LReg.WriteBool('Showing Plugin',true);

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+grafischebuehnenansicht.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              grafischebuehnenansicht.Left:=LReg.ReadInteger('PosX')
            else
              grafischebuehnenansicht.Left:=screen.DesktopLeft;
          end else
            grafischebuehnenansicht.Left:=screen.DesktopLeft;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              grafischebuehnenansicht.Top:=LReg.ReadInteger('PosY')
            else
              grafischebuehnenansicht.Top:=screen.DesktopTop;
          end else
            grafischebuehnenansicht.Top:=screen.DesktopTop;
	      end;
      end;
    end;
  end;
  LReg.CloseKey;

  screentimeronline:=false;
  grafischebuehnenansicht.Width:=buehnenansicht_record.Buehnenansicht_width;
  grafischebuehnenansicht.Height:=buehnenansicht_record.Buehnenansicht_height;
  panel1.Visible:=buehnenansicht_record.Buehnenansicht_panel;

// if ((CheckBox3.Checked) and (FileExists(workingdirectory+'Projekt\Bühnenansicht'))) then
//    openscene(workingdirectory+'Projekt\Bühnenansicht');

      if pos('\Projekt\',buehnenansicht_record.Buehnenansicht_background)>0 then
        buehnenansicht_record.Buehnenansicht_background:=workingdirectory+copy(buehnenansicht_record.Buehnenansicht_background,pos('Projekt\',buehnenansicht_record.Buehnenansicht_background),length(buehnenansicht_record.Buehnenansicht_background));

      if buehnenansicht_record.Buehnenansicht_background<>'' then
      if FileExists(buehnenansicht_record.Buehnenansicht_background) then
        Stage.Picture.LoadFromFile(buehnenansicht_record.Buehnenansicht_background)
      else
      if FileExists(filepath+ExtractFileName(buehnenansicht_record.Buehnenansicht_background)) then
        Stage.Picture.LoadFromFile(filepath+ExtractFileName(buehnenansicht_record.Buehnenansicht_background))
      else
        if messagedlg('Das Hintergrundbild "'+buehnenansicht_record.Buehnenansicht_background+'" für die Bühnenansicht wurde nicht gefunden. Möchten Sie jetzt danach suchen?',mtConfirmation,
          [mbYes,mbNo],0)=mrYes then
          begin
            opendialog1.Title:='Bilddatei öffnen...';
      	    OpenDialog1.Filter:='Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*';
            opendialog1.FileName:='';
            opendialog1.DefaultExt:='*.bmp;*.jpg;*.gif;*.ico;*.png';
            opendialog1.InitialDir:=workingdirectory+'Projekt\';
            if OpenDialog1.Execute then
            begin
              grafischebuehnenansicht.Stage.Picture.LoadFromFile(OpenDialog1.FileName);
              buehnenansicht_record.Buehnenansicht_background:=OpenDialog1.FileName;
            end;
          end else
          begin
	   	      stage.Picture:=Referenzbild2.Picture;
            buehnenansicht_record.Buehnenansicht_background:='';
          end;

  grafischebuehnenansicht.Width:=buehnenansicht_record.Buehnenansicht_width;
  grafischebuehnenansicht.Height:=buehnenansicht_record.Buehnenansicht_height;
  panel1.Visible:=buehnenansicht_record.Buehnenansicht_panel;
  screentimeronline:=true;
  for i:=1 to lastchan do
    aktualisierechannel[i]:=true;
  aktualisieren:=true;

  for i:=0 to length(device_record)-1 do
  begin
    if device_record[i].pictureispng then
    begin
      // Versuchen die Datei zu drehen (nur wenn PNG)
      x:=device_picture[i].Picture.Graphic As TPNGObject;
      temp:=device_record[i].pictureangle;
      device_record[i].pictureangle:=0;
      for k:=1 to temp do
        SmoothRotate(x,90,i);
    end else
    begin
      // Bild ist kein PNG, dann Hor/Ver-Flippen
      if device_record[i].picturefliphor then
      begin
        device_record[i].picturefliphor:=false;
        HorizontalSpiegeln(device_picture[i].Picture.Bitmap,i);
      end;
      if device_record[i].pictureflipver then
      begin
        device_record[i].pictureflipver:=false;
        VertikalSpiegeln(device_picture[i].Picture.Bitmap,i);
      end;
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.stageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i:integer;
begin
	If shift=[ssLeft] then
  begin
    minonedeviceselected:=false;

		for i:=0 to length(Device_record)-1 do
	    begin
	      device_selected[i]:=false;
      	device_label[i].Font.Color:=clBlack;
      	device_number[i].Font.Color:=clBlack;
	    end;
    Paintbox1.canvas.Brush.Style:=bsclear;
    x1:=X;
    y1:=Y;
    x2:=X;
    y2:=Y;
    Paintbox1.canvas.Rectangle(x1,y1,x2,y2);

    RotateBtn.enabled:=minonedeviceselected;
    FlipHorBtn.enabled:=minonedeviceselected;
    FlipVerBtn.enabled:=minonedeviceselected;
    TrackBar1.enabled:=minonedeviceselected;
  end;
end;


procedure Tgrafischebuehnenansicht.stageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
	i:integer;
begin
	If shift=[ssLeft] then
  begin
  	Paintbox1.canvas.Rectangle(x1,y1,x2,y2);
    x2:=X;
    y2:=Y;
    Paintbox1.canvas.Rectangle(x1,y1,x2,y2);

    minonedeviceselected:=false;
	  for i:=0 to length(Device_record)-1 do
    begin
      begin
        // X1=Links X2=Rechts                                                                      Y1=Oben Y2=Unten
    		if (device_picture[i].Left+(device_picture[i].Width div 2)<x1) and ((device_picture[i].Left+(device_picture[i].Width div 2))>x2) and (device_picture[i].Top+(device_picture[i].Height div 2)>y1) and ((device_picture[i].Top+(device_picture[i].Height div 2))<y2)
        or (device_picture[i].Left+(device_picture[i].Width div 2)>x1) and ((device_picture[i].Left+(device_picture[i].Width div 2))<x2) and (device_picture[i].Top+(device_picture[i].Height div 2)<y1) and ((device_picture[i].Top+(device_picture[i].Height div 2))>y2)
        or (device_picture[i].Left+(device_picture[i].Width div 2)>x1) and ((device_picture[i].Left+(device_picture[i].Width div 2))<x2) and (device_picture[i].Top+(device_picture[i].Height div 2)>y1) and ((device_picture[i].Top+(device_picture[i].Height div 2))<y2)
        or (device_picture[i].Left+(device_picture[i].Width div 2)<x1) and ((device_picture[i].Left+(device_picture[i].Width div 2))>x2) and (device_picture[i].Top+(device_picture[i].Height div 2)<y1) and ((device_picture[i].Top+(device_picture[i].Height div 2))>y2) then
	    		device_selected[i]:=true else device_selected[i]:=false;
		  	if device_selected[i] then
        begin
          minonedeviceselected:=true;
        	device_label[i].Font.Color:=clRed;
        	device_number[i].Font.Color:=clRed;
        end else
        begin
        	device_label[i].Font.Color:=clBlack;
        	device_number[i].Font.Color:=clBlack;
        end;
      end;
    end;

    RotateBtn.enabled:=minonedeviceselected;
    FlipHorBtn.enabled:=minonedeviceselected;
    FlipVerBtn.enabled:=minonedeviceselected;
    TrackBar1.enabled:=minonedeviceselected;

  end;
end;

procedure Tgrafischebuehnenansicht.stageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	paintbox1.canvas.Rectangle(x1,y1,x2,y2);
  x1:=X;
  y1:=Y;
  x2:=X;
  y2:=Y;
  paintbox1.canvas.Rectangle(x1,y1,x2,y2);
end;

procedure Tgrafischebuehnenansicht.BhnenansichtalsBilddateispeichern1Click(
  Sender: TObject);
var
	image1:TImage;
begin
  savedialog1.Title:='PC_DIMMER Bühnenansicht speichern...';
  savedialog1.Filter:='Windows-Bitmap (*.bmp)|*.bmp|*.*|*.*';
  savedialog1.FileName:='';
  savedialog1.DefaultExt:='*.bmp';
  if savedialog1.execute then
  begin
    image1:=TImage.Create(Self);
  	image1.Width:=panel2.Width;
	  image1.Height:=panel2.Height;
		panel2.PaintTo(image1.canvas,0,0);
	  image1.Picture.SaveToFile(savedialog1.FileName);
    image1.Free;
  end;
end;

procedure Tgrafischebuehnenansicht.Bhnenansichtausdrucken1Click(
  Sender: TObject);
var
	image1:TImage;
begin
	if messagedlg('Die gesamte Bühnenansicht mit dem Standarddrucker "'+Printer.Printers[Printer.PrinterIndex]+'" ausdrucken?',mtConfirmation,
	  [mbYes,mbNo],0)=mrYes then
	begin
    image1:=TImage.Create(Self);
  	image1.Width:=panel2.Width;
	  image1.Height:=panel2.Height;
		panel2.PaintTo(image1.canvas,0,0);
		printer.begindoc;
		printer.Canvas.StretchDraw(rect(0,0,image1.Width*5,image1.Height*5),image1.Picture.Graphic);
		printer.enddoc;
    image1.Free;
  end;
end;
  
procedure Tgrafischebuehnenansicht.FormResize(Sender: TObject);
begin
	paintbox1.Width:=stage.Width;
  paintbox1.Height:=stage.Height;
end;

procedure Tgrafischebuehnenansicht.Button2Click(Sender: TObject);
var
	i:integer;
begin
  // Arrays um eine Position erweitern
  setlength(device_picture,length(device_picture)+1);
  setlength(device_progress,length(device_progress)+1);
  setlength(device_label,length(device_label)+1);
  setlength(device_number,length(device_number)+1);
  setlength(device_colorshape,length(device_colorshape)+1);
  setlength(device_selected,length(device_selected)+1);
	setlength(Device_record,length(Device_record)+1);

  i:=length(Device_record)-1;
  Device_record[i].channel:=1;
  Device_record[i].pictureispng:=false;
	device_record[i].color:=clWhite;

  createdevices(i);

  if FileExists(workingdirectory+'Devicepictures\32 x 32\par56silber.png') then
  begin
    device_picture[i].Picture.LoadFromFile(workingdirectory+'Devicepictures\32 x 32\par56silber.png');
    Device_record[i].picture:=workingdirectory+'Devicepictures\32 x 32\par56silber.png';
    Device_record[i].pictureispng:=true;
  end;
  searchpicture(i);
end;

procedure Tgrafischebuehnenansicht.openscene(scenefilename:string);
var
  i,laenge:integer;
  errorindevicepicture:boolean;
begin
  LockWindow(panel2.Handle);
    screentimeronline:=false;
    errorindevicepicture:=false;

    filename:=extractfilename(scenefilename);
    filepath:=extractfilepath(scenefilename);

    if (filepath+filename)<>(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\Bühnenansicht') then
    	Compress.DecompressFile(filepath+filename,ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\',true,false);

    for i:=0 to length(Device_record)-1 do
    begin
    	device_picture[i].Free;
			device_progress[i].Free;
			device_label[i].Free;
			device_number[i].Free;
			device_colorshape[i].Free;
    end;

    if fileexists(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\Bühnenansicht') then
	    FileStream:=TFileStream.Create(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\Bühnenansicht',fmOpenRead)
    else
      FileStream:=TFileStream.Create(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\'+filename,fmOpenRead);
    FileStream.ReadBuffer(buehnenansicht_record,sizeof(buehnenansicht_record));
    FileStream.ReadBuffer(laenge,sizeof(laenge));
		setlength(Device_record,laenge);
	  setlength(device_picture,laenge);
	  setlength(device_progress,laenge);
	  setlength(device_label,laenge);
	  setlength(device_number,laenge);
	  setlength(device_colorshape,laenge);
	  setlength(device_selected,laenge);
    for i:=0 to laenge-1 do
    begin
    	FileStream.ReadBuffer(device_record[i].channel,sizeof(device_record[i].channel));
    	FileStream.ReadBuffer(device_record[i].color,sizeof(device_record[i].color));
    	FileStream.ReadBuffer(device_record[i].picture,sizeof(device_record[i].picture));
      FileStream.ReadBuffer(Device_record[i].picturesize,sizeof(Device_record[i].picturesize));
      FileStream.ReadBuffer(Device_record[i].pictureangle,sizeof(Device_record[i].pictureangle));
      FileStream.ReadBuffer(Device_record[i].picturefliphor,sizeof(Device_record[i].picturefliphor));
      FileStream.ReadBuffer(Device_record[i].pictureflipver,sizeof(Device_record[i].pictureflipver));
      FileStream.ReadBuffer(Device_record[i].pictureispng,sizeof(Device_record[i].pictureispng));
    	FileStream.ReadBuffer(device_record[i].top,sizeof(device_record[i].top));
    	FileStream.ReadBuffer(device_record[i].left,sizeof(device_record[i].left));
      createdevices(i);
    end;
    FileStream.Free;

    if pos('\Projekt\',buehnenansicht_record.Buehnenansicht_background)>0 then
      buehnenansicht_record.Buehnenansicht_background:=workingdirectory+copy(buehnenansicht_record.Buehnenansicht_background,pos('Projekt\',buehnenansicht_record.Buehnenansicht_background),length(buehnenansicht_record.Buehnenansicht_background));

	  UnLockWindow(panel2.Handle);

//{
    if not startingup then
    begin
      if buehnenansicht_record.Buehnenansicht_background<>'' then
      if FileExists(buehnenansicht_record.Buehnenansicht_background) then
        Stage.Picture.LoadFromFile(buehnenansicht_record.Buehnenansicht_background)
      else
      if FileExists(filepath+ExtractFileName(buehnenansicht_record.Buehnenansicht_background)) then
        Stage.Picture.LoadFromFile(filepath+ExtractFileName(buehnenansicht_record.Buehnenansicht_background))
      else
        if messagedlg('Das Hintergrundbild "'+buehnenansicht_record.Buehnenansicht_background+'" für die Bühnenansicht wurde nicht gefunden. Möchten Sie jetzt danach suchen?',mtConfirmation,
          [mbYes,mbNo],0)=mrYes then
          begin
            opendialog1.Title:='Bilddatei öffnen...';
      	    OpenDialog1.Filter:='Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*';
            opendialog1.FileName:='';
            opendialog1.DefaultExt:='*.bmp;*.jpg;*.gif;*.ico;*.png';
            if OpenDialog1.Execute then
            begin
              grafischebuehnenansicht.Stage.Picture.LoadFromFile(OpenDialog1.FileName);
              buehnenansicht_record.Buehnenansicht_background:=OpenDialog1.FileName;
            end;
          end else
          begin
	   	      stage.Picture:=Referenzbild2.Picture;
            buehnenansicht_record.Buehnenansicht_background:='';
          end;
    end;
//}

  if errorindevicepicture then
    MessageDlg('Einige Gerätebilder konnten nicht gefunden werden. Fehlende Bilder wurden durch Standardbilder ersetzt.', mtError, [mbOk], 0);

  if not startingup then
  begin
    grafischebuehnenansicht.Width:=buehnenansicht_record.Buehnenansicht_width;
    grafischebuehnenansicht.Height:=buehnenansicht_record.Buehnenansicht_height;
    panel1.Visible:=buehnenansicht_record.Buehnenansicht_panel;
    screentimeronline:=true;
  end;
end;

procedure Tgrafischebuehnenansicht.savescene(scenefilename:string);
var
  i,laenge:integer;
  filename,filepath:string;
begin
    buehnenansicht_record.Buehnenansicht_width:=grafischebuehnenansicht.Width;
    buehnenansicht_record.Buehnenansicht_height:=grafischebuehnenansicht.Height;
    buehnenansicht_record.Buehnenansicht_panel:=panel1.Visible;

    filename:=extractfilename(scenefilename);
    filepath:=extractfilepath(scenefilename);

    if pos('\Projekt\',buehnenansicht_record.Buehnenansicht_background)>0 then
      buehnenansicht_record.Buehnenansicht_background:=workingdirectory+copy(buehnenansicht_record.Buehnenansicht_background,pos('Projekt\',buehnenansicht_record.Buehnenansicht_background),length(buehnenansicht_record.Buehnenansicht_background));

  try
    FileStream:=TFileStream.Create(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\Bühnenansicht',fmCreate);
    FileStream.WriteBuffer(buehnenansicht_record,sizeof(buehnenansicht_record));
    laenge:=length(device_record);
    FileStream.WriteBuffer(laenge,sizeof(laenge));
    for i:=0 to laenge-1 do
    begin
    	FileStream.WriteBuffer(device_record[i].channel,sizeof(device_record[i].channel));
    	FileStream.WriteBuffer(device_record[i].color,sizeof(device_record[i].color));
    	FileStream.WriteBuffer(device_record[i].picture,sizeof(device_record[i].picture));
      FileStream.WriteBuffer(Device_record[i].picturesize,sizeof(Device_record[i].picturesize));
      FileStream.WriteBuffer(Device_record[i].pictureangle,sizeof(Device_record[i].pictureangle));
      FileStream.WriteBuffer(Device_record[i].picturefliphor,sizeof(Device_record[i].picturefliphor));
      FileStream.WriteBuffer(Device_record[i].pictureflipver,sizeof(Device_record[i].pictureflipver));
      FileStream.WriteBuffer(Device_record[i].pictureispng,sizeof(Device_record[i].pictureispng));
    	FileStream.WriteBuffer(device_record[i].top,sizeof(device_record[i].top));
    	FileStream.WriteBuffer(device_record[i].left,sizeof(device_record[i].left));
    end;
    FileStream.Free;

    if (filepath+filename)<>(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\Bühnenansicht') then
	    Compress.CompressDirectory(ExtractFilePath(paramstr(0))+'Projekt\Bühnenansicht\',false,filepath+filename);
  except
    ShowMessage('Bühnenansicht: Es ist ein Fehler beim Speichern der Szene aufgetreten.');
  end;
end;

procedure Tgrafischebuehnenansicht.createdevices(i:integer);
begin
    device_picture[i]:=TImage.create(self);
    if Device_record[i].picturesize=0 then
      Device_record[i].picturesize:=Trackbar1.Position;
    device_picture[i].Parent:=panel2;
    device_picture[i].PopupMenu:=devicepicture_popup;
    device_picture[i].OnMouseMove:=device_pictureMouseMove;
    device_picture[i].OnMouseUp:=device_pictureMouseUp;
    device_picture[i].Transparent:=true;
    device_picture[i].Top:=Device_record[i].top;
    device_picture[i].Left:=Device_record[i].Left;
    device_picture[i].Height:=Device_record[i].picturesize*16;
    device_picture[i].Width:=Device_record[i].picturesize*16;
    device_picture[i].Stretch:=true;
    device_picture[i].Proportional:=true;
    device_picture[i].Hint:=inttostr(i)+' ('+channelnames[device_record[i].channel]+')';
    device_picture[i].ShowHint:=true;
    if (length(device_record[i].picture)>0) and FileExists(device_record[i].picture) then
      device_picture[i].Picture.LoadFromFile(device_record[i].picture)
    else
      device_picture[i].Picture:=referenzbild.Picture;
    device_picture[i].Show;

    device_progress[i]:=TProgressBar.create(self);
    device_progress[i].Parent:=panel2;
    device_progress[i].OnMouseMove:=device_progressMouseMove;
    device_progress[i].Height:=9;
    device_progress[i].Width:=Device_record[i].picturesize*16;
    device_progress[i].Top:=device_picture[i].Top+Device_record[i].picturesize*16;
    device_progress[i].Left:=device_picture[i].Left;
    device_progress[i].Max:=255;
    device_progress[i].Smooth:=true;
    device_progress[i].Enabled:=true;
    device_progress[i].Position:=channelvalue[device_record[i].channel];
    device_progress[i].Show;

    device_label[i]:=TLabel.create(self);
    device_label[i].Parent:=panel2;
    device_label[i].OnMouseUp:=DeviceLabelMouseUp;
    device_label[i].Top:=device_picture[i].Top+device_picture[i].Height+8;
    device_label[i].Left:=device_picture[i].Left;
    device_label[i].Caption:=channelnames[Device_record[i].channel];
    device_label[i].Transparent:=false;
    device_label[i].Show;

    device_colorshape[i]:=TShape.Create(self);
    device_colorshape[i].Parent:=panel2;
    device_colorshape[i].OnMouseUp:=DeviceColorMouseUp;
    device_colorshape[i].Shape:=stCircle;
		device_colorshape[i].Brush.Color:=device_record[i].color;
		if Checkbox2.Checked then
    begin
	    device_colorshape[i].Height:=Device_record[i].picturesize*16;
	    device_colorshape[i].Width:=Device_record[i].picturesize*16;
	    device_colorshape[i].Top:=device_picture[i].Top;
	    device_colorshape[i].Left:=device_picture[i].Left;
    end else
    begin
	    device_colorshape[i].Height:=round(Device_record[i].picturesize*16/3);
   	  device_colorshape[i].Width:=round(Device_record[i].picturesize*16/3);
	    device_colorshape[i].Top:=device_picture[i].Top;
	    device_colorshape[i].Left:=device_picture[i].Left+Device_record[i].picturesize*16-10;
    end;
    device_colorshape[i].Show;

    device_number[i]:=TLabel.Create(self);
    device_number[i].Parent:=panel2;
    device_number[i].OnMouseUp:=DeviceNumberMouseUp;
    device_number[i].Caption:=inttostr(Device_record[i].channel);
    device_number[i].Font.Name:='Arial';
    device_number[i].Font.Size:=7;
    device_number[i].Top:=device_picture[i].Top+Device_record[i].picturesize*16-10;
    device_number[i].Left:=device_picture[i].Left;
    device_number[i].Transparent:=false;
    device_number[i].Show;

    if checkbox1.Checked then
      device_label[i].Visible:=true
    else
      device_label[i].Visible:=false;
end;

procedure Tgrafischebuehnenansicht.deletedevice(i:integer);
var
	letzteposition:integer;
begin
//  screenupdate.Enabled:=false;

  LockWindow(panel2.Handle);

  letzteposition:=length(Device_record)-1;

  if (i<>letzteposition) then
  begin
	  // zu löschende Arrayposition durch letzten Arraywert ersetzen
	  Device_record[i].channel:=Device_record[letzteposition].channel;
	  Device_record[i].color:=Device_record[letzteposition].color;
	  Device_record[i].top:=Device_record[letzteposition].top;
	  Device_record[i].left:=Device_record[letzteposition].left;

	  device_picture[i].Top:=device_picture[letzteposition].Top;
	  device_picture[i].Left:=device_picture[letzteposition].Left;
	  device_progress[i].Top:=device_progress[letzteposition].Top;
	  device_progress[i].Left:=device_progress[letzteposition].Left;
	  device_label[i].Top:=device_label[letzteposition].Top;
	  device_label[i].Left:=device_label[letzteposition].Left;
	  device_number[i].Top:=device_number[letzteposition].Top;
	  device_number[i].Left:=device_number[letzteposition].Left;
	  device_colorshape[i].Top:=device_colorshape[letzteposition].Top;
	  device_colorshape[i].Left:=device_colorshape[letzteposition].Left;

	 	device_progress[i].Position:=channelvalue[Device_record[i].channel];
	  device_label[i].Caption:=channelnames[Device_record[i].channel];
	  device_number[i].Caption:=inttostr(Device_record[i].channel);
		device_colorshape[i].Brush.Color:=device_record[i].color;
  end;
  
  // Komponenten killen
  device_picture[letzteposition].Free;
  device_progress[letzteposition].Free;
  device_label[letzteposition].Free;
  device_number[letzteposition].Free;
  device_colorshape[letzteposition].Free;

  // Alle Arrays um einen Wert kürzen
  setlength(device_picture,length(device_picture)-1);
  setlength(device_progress,length(device_progress)-1);
  setlength(device_label,length(device_label)-1);
  setlength(device_number,length(device_number)-1);
  setlength(device_colorshape,length(device_colorshape)-1);
  setlength(device_selected,length(device_selected)-1);
	setlength(Device_record,length(Device_record)-1);

  UnLockWindow(panel2.Handle);
end;

procedure Tgrafischebuehnenansicht.Gertebildndern1Click(Sender: TObject);
begin
  if (actualdevice<=length(device_record)-1) then
  begin
	    OpenDialog1.Filter:='Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*';
	    OpenDialog1.InitialDir:=workingdirectory+'Devicepictures';
	    opendialog1.FileName:='';
	    If OpenDialog1.Execute then
	    begin
	      device_picture[actualdevice].Picture.LoadFromFile(OpenDialog1.Filename);
	      device_record[actualdevice].picture:=OpenDialog1.Filename;
        if copy(device_record[actualdevice].picture,length(device_record[actualdevice].picture)-2,3)='png' then
          Device_record[actualdevice].pictureispng:=true
        else
          Device_record[actualdevice].pictureispng:=false;
	    end;
		panel2.Refresh;
  end;
end;

procedure Tgrafischebuehnenansicht.Gertlschen1Click(Sender: TObject);
begin
  if (actualdevice<=length(device_record)-1) then
  begin
		deletedevice(actualdevice);
		panel2.Refresh;
  end;
end;

procedure Tgrafischebuehnenansicht.Kanalnamenndern1Click(Sender: TObject);
var
  channelname:string[255];
begin
  if (actualdevice<=length(device_record)-1) then
  begin
	  channelnames[Device_record[actualdevice].channel]:=InputBox('Beschriftung für "'+channelNames[Device_record[actualdevice].channel]+'"','Bitte geben Sie eine neue Bezeichnung für den aktuellen Kanal ein:',channelnames[Device_record[actualdevice].channel]);
	  channelname:=channelnames[Device_record[actualdevice].channel]+#0;
	  RefreshDLLNames(Device_record[actualdevice].channel,@channelname);
  end;
end;

procedure Tgrafischebuehnenansicht.Kanalnummerndern1Click(Sender: TObject);
var
	oldvalue,channel:integer;
begin
  if (actualdevice<=length(device_record)-1) then
  begin
		  oldvalue:=Device_record[actualdevice].channel;
		  try
		  	channel:=strtoint(InputBox('Kanaleinstellung','Welcher Kanal soll für dieses Gerät gelten:',inttostr(Device_record[actualdevice].channel)));
	      if channel>lastchan then
	      	Device_record[actualdevice].channel:=lastchan
				else if channel<1 then
	      	Device_record[actualdevice].channel:=1
	      else
	      	Device_record[actualdevice].channel:=channel;

//				screenupdate.Enabled:=true;
				aktualisieren:=true;
		  except
		  	Device_record[actualdevice].channel:=oldvalue;
		  end;
	end;
end;

procedure Tgrafischebuehnenansicht.colorbox1ColorChange(Sender: TObject);
var
	R,G,B:byte;
  RGB:integer;
begin
 	device_record[actualdevice].color:=colorbox1.Color;

  RGB:=ColorToRGB(device_record[actualdevice].color);
  R:=round(GetRValue(RGB)*channelvalue[Device_record[actualdevice].channel] / 255);
  G:=round(GetGValue(RGB)*channelvalue[Device_record[actualdevice].channel] / 255);
  B:=round(GetBValue(RGB)*channelvalue[Device_record[actualdevice].channel] / 255);
  device_colorshape[actualdevice].Brush.Color:=RGB2TColor(R,G,B);

  colorbox1.Visible:=false;
//	screenupdate.Enabled:=true;
	aktualisieren:=true;
end;

procedure Tgrafischebuehnenansicht.colorbox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  colorbox1.Visible:=false;
end;

procedure Tgrafischebuehnenansicht.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i:integer;
begin
  for i:=0 to length(Device_record)-1 do
  begin
		if Checkbox2.Checked then
    begin
	    device_colorshape[i].Height:=Device_record[i].picturesize*16;
 	    device_colorshape[i].Width:=Device_record[i].picturesize*16;
 	    device_colorshape[i].Top:=device_picture[i].Top;
 	    device_colorshape[i].Left:=device_picture[i].Left;
    end else
    begin
	    device_colorshape[i].Height:=round(Device_record[i].picturesize*16/3);
   	  device_colorshape[i].Width:=round(Device_record[i].picturesize*16/3);
	    device_colorshape[i].Top:=device_picture[i].Top;
	    device_colorshape[i].Left:=device_picture[i].Left+Device_record[i].picturesize*16-10;
    end;
//    device_colorshape[i].Refresh;
  end;
end;

procedure Tgrafischebuehnenansicht.GroeFarbanzeige1Click(Sender: TObject);
begin
  Checkbox2.Checked:=not Checkbox2.Checked;
  CheckBox2MouseUp(Sender,mbLeft,[ssLeft],0,0);
end;

procedure Tgrafischebuehnenansicht.NewPanel;
var
	i:integer;
begin
  	LockWindow(panel2.Handle);
    for i:=1 to chan do
    begin
      stage.Picture:=Referenzbild2.Picture;
      zoom.ItemIndex:=0;
    end;

    trackbar1.Position:=2;
    buehnenansicht_record.Buehnenansicht_background:='';
    buehnenansicht_record.Buehnenansicht_width:=700;
    buehnenansicht_record.Buehnenansicht_height:=460;
    buehnenansicht_record.Buehnenansicht_panel:=true;

    for i:=0 to length(Device_record)-1 do
    begin
    	device_picture[i].Free;
			device_progress[i].Free;
			device_label[i].Free;
			device_number[i].Free;
			device_colorshape[i].Free;
    end;

		setlength(Device_record,0);
	  setlength(device_picture,0);
	  setlength(device_progress,0);
	  setlength(device_label,0);
	  setlength(device_number,0);
	  setlength(device_colorshape,0);
	  setlength(device_selected,0);
	  UnLockWindow(panel2.Handle);

	  grafischebuehnenansicht.Width:=buehnenansicht_record.Buehnenansicht_width;
	  grafischebuehnenansicht.Height:=buehnenansicht_record.Buehnenansicht_height;
	  panel1.Visible:=buehnenansicht_record.Buehnenansicht_panel;
end;

//-------------------------------------------------

constructor TUpdateThread.Create(UpdateEvent:TUpdateEvent);
begin
  inherited create(false);
  FUpdateEvent:=UpdateEvent;
  Priority := tpNormal;
  FreeOnTerminate := true;
end;

procedure TUpdateThread.Execute;
begin
  inherited;
  grafischebuehnenansicht.UpdateLevels();
  Terminate;
end;

procedure Tgrafischebuehnenansicht.UpdateLevels();
var
	R,G,B:byte;
  RGB:integer;
  i,k:integer;
begin
  repeat
    if (grafischebuehnenansicht.Visible and screentimeronline and aktualisieren) then
    begin
  		aktualisieren:=false;
      for k:=1 to lastchan do
      begin
        if aktualisierechannel[k] then
        begin
      	  for i:=0 to length(Device_record)-1 do
    	    begin
            if (device_record[i].channel=k) then
            begin
      	    	device_progress[i].Position:=channelvalue[Device_record[i].channel];
      	    	device_progress[i].Position:=channelvalue[Device_record[i].channel]-1;
      	    	device_progress[i].Position:=channelvalue[Device_record[i].channel];
      		    device_label[i].Caption:=channelnames[Device_record[i].channel];
      	      device_number[i].Caption:=inttostr(Device_record[i].channel);

      				RGB:=ColorToRGB(device_record[i].color);
      			  R:=round(GetRValue(RGB)*channelvalue[Device_record[i].channel] / 255);
      	      G:=round(GetGValue(RGB)*channelvalue[Device_record[i].channel] / 255);
      	      B:=round(GetBValue(RGB)*channelvalue[Device_record[i].channel] / 255);
      	      device_colorshape[i].Brush.Color:=RGB2TColor(R,G,B);
            end;
          end;
          aktualisierechannel[k]:=false;
        end;
  		end;
    end;
    sleep(1);
  until shutdown;
end;

//-------------------------------------------------

procedure Tgrafischebuehnenansicht.CheckBox4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i:integer;
begin
  for i:=0 to length(Device_record)-1 do
    device_colorshape[i].Visible:=Checkbox4.Checked;
end;

procedure Tgrafischebuehnenansicht.Trackbar1Change(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(Device_record)-1 do
  begin
    if (device_selected[i]) then
    begin
      device_record[i].picturesize:=TrackBar1.Position;
      searchpicture(i);
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.searchpicture(Device: integer);
var
  bildname,bildpfad:string;
  i:integer;
begin
  i:=Device;
    bildname:=ExtractFileName(device_record[i].picture);
    bildpfad:=ExtractFilePath(device_record[i].picture);
    if (Device_record[i].picturesize*16)<=32 then
      begin
        if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname;
        end;
      end
      else if (Device_record[i].picturesize*16)<=64 then
      begin
        if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname;
        end;
      end
      else if (Device_record[i].picturesize*16)<=96 then
      begin
        if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname;
        end;
      end
      else if (Device_record[i].picturesize*16)<=128 then
      begin
        if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'128x128\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'96 x 96\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'64 x 64\'+bildname;
        end
        else if FileExists(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname) then
        begin
          device_picture[i].Picture.LoadFromFile(copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname);
          device_record[i].picture:=copy(bildpfad,0,length(bildpfad)-8)+'32 x 32\'+bildname;
        end;
      end;

 	    device_colorshape[i].Top:=device_picture[i].Top;
 	    device_colorshape[i].Left:=device_picture[i].Left+Device_record[i].picturesize*16-10;
      device_colorshape[i].Height:=round(Device_record[i].picturesize*16/3);
      device_colorshape[i].Width:=round(Device_record[i].picturesize*16/3);

      device_picture[i].Width:=Device_record[i].picturesize*16;
      device_picture[i].height:=Device_record[i].picturesize*16;

      device_progress[i].Width:=Device_record[i].picturesize*16;
      device_progress[i].Top:=device_picture[i].Top+device_picture[i].Height;
 	    device_progress[i].left:=device_picture[i].left;

 	    device_label[i].Top:=device_picture[i].Top+device_picture[i].Height+8;
 	    device_label[i].left:=device_picture[i].left;

 	    device_number[i].Top:=device_picture[i].Top+Device_record[i].picturesize*16-10;
 	    device_number[i].Left:=device_picture[i].Left;
end;

procedure Tgrafischebuehnenansicht.RotateBtnClick(Sender: TObject);
var
  x:TPNGObject;
  i:integer;
begin
  for i:=0 to length(Device_record)-1 do
  begin
    if (device_selected[i]) then
    begin
      if device_record[i].pictureispng then
      begin
        x:=device_picture[i].Picture.Graphic As TPNGObject;
        SmoothRotate(x,90,i);
        device_picture[i].Refresh;
      end else
      begin
        ShowMessage('Leider können derzeit nur PNG-Dateien rotiert werden...'+#13#10#13#10+'Bitte benutzen Sie die Spiegelfunktionen, um das Bild horizontal und vertikal zu Spiegeln');
      end;
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.FlipHorBtnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(Device_record)-1 do
  begin
    if (device_selected[i]) then
    begin
      if not device_record[i].pictureispng then
        HorizontalSpiegeln(device_picture[i].Picture.Bitmap, i)
      else
        ShowMessage('Derzeit können PNG Dateien nicht gespiegelt werden.'+#13#10#13#10+'Bitte benutzen stattdesse Sie die Rotationsfunktion.');
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.FlipVerBtnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(Device_record)-1 do
  begin
    if (device_selected[i]) then
    begin
      if not device_record[i].pictureispng then
        VertikalSpiegeln(device_picture[i].Picture.Bitmap, i)
      else
        ShowMessage('Derzeit können PNG Dateien nicht gespiegelt werden.'+#13#10#13#10+'Bitte benutzen stattdesse Sie die Rotationsfunktion.');
    end;
  end;
end;

end.



