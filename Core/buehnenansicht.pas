unit buehnenansicht;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Mask, Menus, Buttons, Registry,
  JvComponent, JvZlibMultiple, JvExExtCtrls, Printers, JvOfficeColorPanel,
  jpeg, JvComponentBase, JvExtComponent, JvPanel, JvAppStorage,
  JvAppXMLStorage, ddfwindowfrm, PngBitBtn, Grids, pcdutils,
  JvExMask, JvSpin, gnugettext, Math, GR32, pngimage;

const
  {$I GlobaleKonstanten.inc}

type
  TSelectedIcons = record
    IsBuehnenansichtdevice: boolean;
    X:integer;
    Y:Integer;
    DeviceNumber: Word;
    Copy: Word;
    PictureSize:byte;
    Channel:Word;
    Distance:double;
  end;

  TLastMouseOverHighlightDevice = record
    ID: TGUID;
    Dimmer:Byte;
    R:Byte;
    G:Byte;
    B:Byte;
    A:Byte;
    W:Byte;
    ShutterOpenOrClose:byte;
  end;

  Tgrafischebuehnenansicht = class(TForm)
    Stage: TImage;
    Button5: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Bevel3: TBevel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
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
    BhnenansichtalsBilddateispeichern1: TMenuItem;
    Panel2: TPanel;
    Paintbox1: TPaintBox;
    Bhnenansichtausdrucken1: TMenuItem;
    Button2: TButton;
    Label12: TLabel;
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
    NeuesGerthinzufgen1: TMenuItem;
    N3: TMenuItem;
    devicepicture_popup: TPopupMenu;
    Gertebildndern1: TMenuItem;
    Gertlschen1: TMenuItem;
    Kanalnummerndern1: TMenuItem;
    N4: TMenuItem;
    Kanalnamenndern1: TMenuItem;
    colorbox1: TJvOfficeColorPanel;
    CheckBox2: TCheckBox;
    GroeFarbanzeige1: TMenuItem;
    CheckBox5: TCheckBox;
    DeviceSelectedTimer: TTimer;
    Button1: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Bevel1: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Button3: TButton;
    BankSelect: TComboBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    Label22: TLabel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Label23: TLabel;
    Button6: TButton;
    TrackBar1: TTrackBar;
    FlipHorBtn: TButton;
    FlipVerBtn: TButton;
    Bevel2: TBevel;
    Label13: TLabel;
    Label11: TLabel;
    BankCopy: TComboBox;
    AddBtn: TPngBitBtn;
    ChangeBtn: TPngBitBtn;
    DeleteBtn: TPngBitBtn;
    CheckBox3: TCheckBox;
    Iconsverriegeln1: TMenuItem;
    NureinGertefensterffneneinaus1: TMenuItem;
    N5: TMenuItem;
    NeuesGerthinzufgen2: TMenuItem;
    Label6: TLabel;
    RefreshTimer: TTimer;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label14: TLabel;
    CheckBox4: TCheckBox;
    CheckBox6: TCheckBox;
    Label24: TLabel;
    Label25: TLabel;
    TrackBar2: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panelausblenden1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure extanzeigen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure StageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BhnenansichtalsBilddateispeichern1Click(Sender: TObject);
    procedure Bhnenansichtausdrucken1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MSGOpen;
    procedure openscene(scenefilename:string);
    procedure savescene(scenefilename:string);
    procedure deletedevice(i:integer);
    procedure Gertebildndern1Click(Sender: TObject);
    procedure Gertlschen1Click(Sender: TObject);
    procedure Kanalnamenndern1Click(Sender: TObject);
    procedure Kanalnummerndern1Click(Sender: TObject);
    procedure colorbox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroeFarbanzeige1Click(Sender: TObject);
    procedure NewPanel;
    procedure Trackbar1Change(Sender: TObject);
    procedure SmoothRotate(var aPng: TPNGObject; Angle: Extended);
    procedure FlipHorBtnClick(Sender: TObject);
    procedure FlipVerBtnClick(Sender: TObject);
    procedure VertikalSpiegeln(Bitmap : TBitmap; Device:Integer);
    procedure HorizontalSpiegeln(const Bitmap : TBitmap; Device:Integer);
    procedure VertikalSpiegelnDevice(Bitmap : TBitmap; Device:Integer);
    procedure HorizontalSpiegelnDevice(const Bitmap : TBitmap; Device:Integer);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure RefreshStageView;

    procedure DeviceSelectedTimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure ChangeBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure BankSelectSelect(Sender: TObject);
    procedure BankCopySelect(Sender: TObject);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NureinGertefensterffneneinaus1Click(Sender: TObject);
    procedure Iconsverriegeln1Click(Sender: TObject);
    procedure NeuesGerthinzufgen2Click(Sender: TObject);
    procedure colorbox1ColorChange(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Paintbox1Paint(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure CheckBox6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
  private
    { Private-Deklarationen }
    Puffer1, Puffer2:TBitmap;
    startingup:boolean;

    LastDevice, LastBuehnenansichtdevice:integer;
    Counter:integer;
    oldvalues:array[1..8192] of byte;
    SelectedIcons:array of TSelectedIcons;
    pngobject:TPNGObject;
    procedure DrawGrafischeBuehnenansichtDevices(_Buffer:TCanvas);
    procedure DrawGrafischeBuehnenansicht(_Buffer:TCanvas);
    procedure GetSelectedIcons(X,Y:integer);
    procedure ArrangeIcons(X1, Y1, X2, Y2:Integer);
    procedure SortSelectedIcons(Low, High:Integer);
    procedure SmoothResize(apng:tpngobject; NuWidth,NuHeight:integer);
  public
    { Public-Deklarationen }
    aktualisierungsintervall:integer;

    MouseOnDevice, MouseOnDeviceHover, MouseOnBuehnenansichtdevice, MouseOnDeviceCopy, MouseOnLabel, MouseOnNumber, MouseOnBuehnenansichtNumber, MouseOnBuehnenansichtLabel, MouseOnProgress, MouseOnBuehnenansichtProgress, MouseOnBuehnenansichtColor:integer;
    MouseOnDeviceID:TGUID;
    LastMouseOverHighlightDevice:TLastMouseOverHighlightDevice;
    MouseDownPoint,MouseUpPoint:TPoint;
    ShowAuswahl:boolean;
    Auswahl:TRect;
    RedrawPictures:boolean;
    ProcessorFriendlyRedraw:boolean;
    StopDeviceMoving:boolean;
    
    dorefresh:boolean;
    Button:TButton;
    scrolling:boolean;
    Filestream:TFileStream;
	  filename,filepath:string;
    SaveToBMP:boolean;
    procedure MSGSave;
    function ClickOnDevice(X,Y:integer; ssShift: TShiftState):integer;
    function ClickOnBuehnenansichtDevice(X,Y:integer):integer;
    function ClickOnLabel(X,Y:integer):integer;
    function ClickOnNumber(X,Y:integer):integer;
    function ClickOnBuehnenansichtNumber(X,Y:integer):integer;
    function ClickOnBuehnenansichtLabel(X,Y:integer):integer;
    function ClickOnProgress(X,Y:integer):integer;
    function ClickOnBuehnenansichtProgress(X,Y:integer):integer;
    function ClickOnBuehnenansichtColor(X,Y:integer):integer;
    procedure SaveStageviewToFile(Filetype: string);
  end;

var
  grafischebuehnenansicht: Tgrafischebuehnenansicht;

implementation

uses PCDIMMER, geraetesteuerungfrm, PngImageList, nodecontrolfrm;

{$R *.dfm}

procedure Tgrafischebuehnenansicht.VertikalSpiegeln(Bitmap : TBitmap; Device:Integer);
var j,w :Integer;
    help:TBitmap;
begin
  mainform.buehnenansichtdevices[Device].pictureflipver:=not mainform.buehnenansichtdevices[Device].pictureflipver;
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
  mainform.buehnenansichtdevices[Device].picturefliphor:=not mainform.buehnenansichtdevices[Device].picturefliphor;
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

procedure Tgrafischebuehnenansicht.VertikalSpiegelnDevice(Bitmap : TBitmap; Device:Integer);
var j,w :Integer;
    help:TBitmap;
begin
  mainform.devices[Device].pictureflipver:=not mainform.devices[Device].pictureflipver;
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

procedure Tgrafischebuehnenansicht.HorizontalSpiegelnDevice(const Bitmap: TBitmap; Device:Integer);
type
    TRGBArray=array[0..0] of TRGBTriple;
var i,j,w: Integer;
    rowin,rowout: ^TRGBArray;
begin
  mainform.devices[Device].picturefliphor:=not mainform.devices[Device].picturefliphor;
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

procedure Tgrafischebuehnenansicht.SmoothRotate(var aPng: TPNGObject; Angle: Extended);
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

procedure Tgrafischebuehnenansicht.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  MouseOnBuehnenansichtdevice:=-1;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnDeviceCopy:=-1;
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtColor:=-1;
  LastDevice:=-1;
  LastBuehnenansichtDevice:=-1;

  aktualisierungsintervall:=50;

  Puffer1:=TBitmap.Create;
  Puffer1.Width:= Paintbox1.Width;
  Puffer1.Height:= Paintbox1.Height;
  Puffer2:=TBitmap.Create;
  Puffer2.Width:= Paintbox1.Width;
  Puffer2.Height:= Paintbox1.Height;

	startingup:=true;

  setlength(mainform.buehnenansicht_background, 1);
  mainform.buehnenansicht_background[0]:='';
  mainform.buehnenansichtsetup.Buehnenansicht_width:=880;
  mainform.buehnenansichtsetup.Buehnenansicht_height:=450;
  mainform.buehnenansichtsetup.Buehnenansicht_panel:=true;

  pngobject:=TPNGObject.Create;

  startingup:=false;
end;

procedure Tgrafischebuehnenansicht.SpeedButton1Click(Sender: TObject);
begin
if messagedlg(_('Die gesamte Bühnenansicht wird zurückgesetzt. Fortfahren?'),mtConfirmation,
  [mbYes,mbNo],0)=mrYes then
  begin
		NewPanel;
  end;
end;

procedure Tgrafischebuehnenansicht.Button6Click(Sender: TObject);
begin
  OpenDialog1.Filter:=_('Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*');
  OpenDialog1.InitialDir:=mainform.userdirectory+'ProjectTemp\';
  If OpenDialog1.Execute then
  begin
    Stage.Picture.LoadFromFile(OpenDialog1.Filename);
    mainform.buehnenansicht_background[BankSelect.ItemIndex]:=OpenDialog1.Filename;
  end;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.SpeedButton4Click(Sender: TObject);
begin
  opendialog1.Title:=_('PC_DIMMER Bühnenansicht öffnen...');
  opendialog1.Filter:=_('PC_DIMMER Bühnenansicht (*.pcdstge)|*.pcdstge|*.*|*.*');
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
  savedialog1.Title:=_('PC_DIMMER Bühnenansicht speichern...');
  savedialog1.Filter:=_('PC_DIMMER Bühnenansicht (*.pcdstge)|*.pcdstge|*.*|*.*');
  savedialog1.FileName:='';
  savedialog1.DefaultExt:='*.pcdstge';
  if savedialog1.execute then
    savescene(savedialog1.FileName);
end;

procedure Tgrafischebuehnenansicht.CheckBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          LReg.WriteBool('Show text',checkbox1.checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  RedrawPictures:=true;

  mainform.CheckBox1.Checked:=Checkbox1.Checked;
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
  mainform.buehnenansichtsetup.Buehnenansicht_panel:=panel1.Visible;
  mainform.buehnenansichtsetup.Buehnenansicht_width:=grafischebuehnenansicht.Width;
end;

procedure Tgrafischebuehnenansicht.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  RefreshTimer.enabled:=(PageControl1.ActivePageIndex=0) and (mainform.panel1.Visible);
  
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
						LReg.WriteBool('Showing Buehnenansicht',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
	end;

  mainform.buehnenansichtsetup.Buehnenansicht_width:=grafischebuehnenansicht.Width;
  mainform.buehnenansichtsetup.Buehnenansicht_height:=grafischebuehnenansicht.Height;
  mainform.buehnenansichtsetup.Buehnenansicht_panel:=panel1.Visible;
  mainform.SaveWindowPositions('buehnenansicht');
end;

procedure Tgrafischebuehnenansicht.extanzeigen1Click(Sender: TObject);
begin
  Checkbox1.Checked:=not Checkbox1.Checked;
  CheckBox1MouseUp(Sender,mbLeft,[ssLeft],0,0);
end;

procedure Tgrafischebuehnenansicht.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MSGSave;
end;

procedure Tgrafischebuehnenansicht.FormShow(Sender: TObject);
var
  LReg:TRegistry;
begin
  if BankSelect.Itemindex=-1 then
    BankSelect.ItemIndex:=0;

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
				LReg.WriteBool('Showing Buehnenansicht',true);

        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          if LReg.ValueExists('Width') then
            grafischebuehnenansicht.ClientWidth:=LReg.ReadInteger('Width')
          else
            grafischebuehnenansicht.ClientWidth:=692;
          if LReg.ValueExists('Height') then
            grafischebuehnenansicht.ClientHeight:=LReg.ReadInteger('Height')
          else
            grafischebuehnenansicht.ClientHeight:=396;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+grafischebuehnenansicht.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              grafischebuehnenansicht.Left:=LReg.ReadInteger('PosX')
            else
              grafischebuehnenansicht.Left:=0;
          end else
            grafischebuehnenansicht.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+grafischebuehnenansicht.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              grafischebuehnenansicht.Top:=LReg.ReadInteger('PosY')
            else
              grafischebuehnenansicht.Top:=0;
          end else
            grafischebuehnenansicht.Top:=0;


          if LReg.ValueExists('Show text') then
          begin
            if LReg.ReadBool('Show text')<>checkbox1.Checked then
            begin
              checkbox1.checked:=LReg.ReadBool('Show text');
              CheckBox1MouseUp(nil, mbLeft, [], 0, 0);
            end;
          end else
          begin
            checkbox1.checked:=true;
          end;

          if LReg.ValueExists('Huge colorshapes') then
          begin
            if LReg.ReadBool('Huge colorshapes')<>checkbox2.Checked then
            begin
              checkbox2.checked:=LReg.ReadBool('Huge colorshapes');
              CheckBox2MouseUp(nil, mbLeft, [], 0, 0);
            end;
          end else
          begin
            checkbox2.checked:=false;
          end;

          if LReg.ValueExists('Only one DDF at time') then
          begin
            if LReg.ReadBool('Only one DDF at time')<>checkbox5.Checked then
            begin
              checkbox5.checked:=LReg.ReadBool('Only one DDF at time');
              CheckBox5MouseUp(nil, mbLeft, [], 0, 0);
            end;
          end else
          begin
            checkbox5.checked:=false;
          end;

          if LReg.ValueExists('Lock icons') then
          begin
            if LReg.ReadBool('Lock icons')<>checkbox3.Checked then
            begin
              checkbox3.checked:=LReg.ReadBool('Lock icons');
              CheckBox3MouseUp(nil, mbLeft, [], 0, 0);
            end;
          end else
          begin
            checkbox3.checked:=false;
          end;

          if LReg.ValueExists('AutoGrid') then
          begin
            if LReg.ReadBool('AutoGrid')<>checkbox4.Checked then
            begin
              checkbox4.checked:=LReg.ReadBool('AutoGrid');
              CheckBox4MouseUp(nil, mbLeft, [], 0, 0);
            end;
          end else
          begin
            checkbox4.checked:=true;
          end;


          if LReg.ValueExists('GridSize') then
          begin
            if LReg.ReadInteger('GridSize')<>Combobox1.Itemindex then
            begin
              Combobox1.Itemindex:=LReg.ReadInteger('GridSize');
              mainform.ComboBox1.ItemIndex:=Combobox1.Itemindex;
            end;
          end else
          begin
            Combobox1.Itemindex:=3;
            mainform.ComboBox1.ItemIndex:=Combobox1.Itemindex;
          end;
				end;
      end;
    end;
  end;
  LReg.CloseKey;

  grafischebuehnenansicht.Width:=mainform.buehnenansichtsetup.Buehnenansicht_width;
  grafischebuehnenansicht.Height:=mainform.buehnenansichtsetup.Buehnenansicht_height;
  panel1.Visible:=mainform.buehnenansichtsetup.Buehnenansicht_panel;

  if pos('\ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex])>0 then
    mainform.buehnenansicht_background[BankSelect.ItemIndex]:=mainform.userdirectory+copy(mainform.buehnenansicht_background[BankSelect.ItemIndex],pos('ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex]),length(mainform.buehnenansicht_background[BankSelect.ItemIndex]));

  if mainform.buehnenansicht_background[BankSelect.ItemIndex]<>'' then
  begin
    if FileExists(mainform.buehnenansicht_background[BankSelect.ItemIndex]) then
      Stage.Picture.LoadFromFile(mainform.buehnenansicht_background[BankSelect.ItemIndex])
    else
    begin
      if FileExists(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
        Stage.Picture.LoadFromFile(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
      else if FileExists(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
        Stage.Picture.LoadFromFile(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
      else
      begin
        if messagedlg(_('Das Hintergrundbild "')+mainform.buehnenansicht_background[BankSelect.ItemIndex]+_('" für die Bühnenansicht wurde nicht gefunden. Möchten Sie jetzt danach suchen?'),mtConfirmation,
          [mbYes,mbNo],0)=mrYes then
        begin
          opendialog1.Title:=_('Bilddatei öffnen...');
          OpenDialog1.Filter:=_('Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*');
          opendialog1.FileName:='';
          opendialog1.DefaultExt:='*.bmp;*.jpg;*.gif;*.ico;*.png';
          opendialog1.InitialDir:=mainform.userdirectory+'ProjectTemp\';
          if OpenDialog1.Execute then
          begin
            grafischebuehnenansicht.Stage.Picture.LoadFromFile(OpenDialog1.FileName);
            mainform.buehnenansicht_background[BankSelect.ItemIndex]:=OpenDialog1.FileName;
          end;
        end else
        begin
          stage.Picture:=Referenzbild2.Picture;
          mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
        end;
      end;
    end;
  end;
  grafischebuehnenansicht.Width:=mainform.buehnenansichtsetup.Buehnenansicht_width;
  grafischebuehnenansicht.Height:=mainform.buehnenansichtsetup.Buehnenansicht_height;

  mainform.DeviceSelectionChanged(nil);
  RefreshTimer.enabled:=true;
  dorefresh:=true;

  if combobox1.ItemIndex=-1 then
    combobox1.itemindex:=3;
end;

procedure Tgrafischebuehnenansicht.StageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	i,j:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  MouseDownPoint.X:=X;
  MouseDownPoint.Y:=Y;

  paintbox1.PopupMenu:=popupmenu1;

  if Shift=[ssLeft, ssAlt] then
    GetSelectedIcons(MouseDownPoint.X, MouseDownPoint.Y);

  if ClickOnProgress(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if ClickOnBuehnenansichtProgress(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if ClickOnLabel(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if ClickOnNumber(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if ClickOnBuehnenansichtNumber(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if ClickOnBuehnenansichtLabel(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if ClickOnBuehnenansichtColor(X,Y)>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if (ClickOnDevice(X,Y, Shift)>-1) or (ClickOnBuehnenansichtDevice(X,Y)>-1) then
  begin
    ProcessorFriendlyRedraw:=true;

    paintbox1.PopupMenu:=nil;

    for i:=0 to length(mainform.devices)-1 do
    for j:=0 to length(mainform.devices[i].OldPos)-1 do
    begin
      mainform.devices[i].OldPos[j].X:=mainform.devices[i].Left[j];
      mainform.devices[i].OldPos[j].Y:=mainform.devices[i].Top[j];
    end;

    for i:=0 to length(mainform.buehnenansichtdevices)-1 do
    begin
      mainform.buehnenansichtdevices[i].OldPos.X:=mainform.buehnenansichtdevices[i].Left;
      mainform.buehnenansichtdevices[i].OldPos.Y:=mainform.buehnenansichtdevices[i].Top;
    end;
  end else
  begin
    DeviceSelectedTimer.enabled:=true;

    If (shift=[ssLeft,ssCtrl]) and not (Shift=[ssCtrl,ssShift]) then
    begin
      for i:=0 to length(mainform.DeviceSelected)-1 do
        mainform.DeviceSelected[i]:=false;
      mainform.DeviceSelectionChanged(nil);
    end;

    If (shift=[ssLeft]) or (shift=[ssLeft,ssShift]) then
    begin
      for i:=0 to length(mainform.buehnenansichtdevices)-1 do
      begin
        mainform.buehnenansichtdevices[i].selected:=false;
      end;
      for i:=0 to length(mainform.devices)-1 do
      for j:=0 to length(mainform.devices[i].selected)-1 do
      begin
        mainform.devices[i].selected[j]:=false;
      end;

      Auswahl.Left:=X;
      Auswahl.Top:=Y;
      Auswahl.Right:=X;
      Auswahl.Bottom:=Y;
      ShowAuswahl:=true;
    end;

    if not (Shift=[ssLeft,ssShift,ssCtrl]) and (Shift=[ssLeft,ssShift]) then
    begin
      for i:=0 to length(mainform.DeviceSelected)-1 do
        mainform.DeviceSelected[i]:=false;
      mainform.DeviceSelectionChanged(nil);

      Auswahl.Left:=X;
      Auswahl.Top:=Y;
      Auswahl.Right:=X;
      Auswahl.Bottom:=Y;
      ShowAuswahl:=true;
    end;

    if (Shift=[ssLeft,ssShift,ssCtrl]) and not (Shift=[ssLeft,ssShift]) then
    begin
      Auswahl.Left:=X;
      Auswahl.Top:=Y;
      Auswahl.Right:=X;
      Auswahl.Bottom:=Y;
      ShowAuswahl:=true;
    end;
  end;
end;


procedure Tgrafischebuehnenansicht.StageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
	i,j,k,l,m:integer;
  value:integer;
  dobreak:boolean;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  dorefresh:=(Shift=[ssLeft]) or (Shift=[ssLeft, ssAlt]);

  /////////// DeviceHoverEffect
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  dobreak:=false;
  for i:=0 to length(mainform.devices)-1 do
  begin
    for j:=0 to length(mainform.devices[i].bank)-1 do
    begin
      if mainform.devices[i].ShowInStageview then
      if mainform.devices[i].bank[j]=BankSelect.Itemindex then
      begin
        // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
        if (mainform.devices[i].left[j]<=X)
        and ((mainform.devices[i].left[j]+mainform.devices[i].picturesize)>=X)
        and (mainform.devices[i].Top[j]<=Y)
        and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize)>=Y) then
        begin
          MouseOnDeviceID:=mainform.devices[i].ID;
          MouseOnDeviceHover:=i;
          dobreak:=true;
          break;
        end;
      end;
    end;
    if dobreak then
      break;
  end;
  if not dobreak then
  begin
    MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
    MouseOnDeviceHover:=-1;
  end;


/////////// DeviceHighlight
  if CheckBox6.Checked then
  begin
    // Altes Gerät zurücksetzen
    geraetesteuerung.set_color(LastMouseOverHighlightDevice.ID, LastMouseOverHighlightDevice.R, LastMouseOverHighlightDevice.G, LastMouseOverHighlightDevice.B, 150, 0);
    geraetesteuerung.set_shutter(LastMouseOverHighlightDevice.ID, LastMouseOverHighlightDevice.ShutterOpenOrClose);
    geraetesteuerung.set_dimmer(LastMouseOverHighlightDevice.ID, LastMouseOverHighlightDevice.Dimmer, 150, 0);
    geraetesteuerung.set_channel(LastMouseOverHighlightDevice.ID, 'a', -1, LastMouseOverHighlightDevice.A, 150, 0);
    geraetesteuerung.set_channel(LastMouseOverHighlightDevice.ID, 'w', -1, LastMouseOverHighlightDevice.W, 150, 0);

    // Aktuelle Werte speichern
    if not IsEqualGUID(LastMouseOverHighlightDevice.ID, MouseOnDeviceID) then
    begin
      LastMouseOverHighlightDevice.ID:=MouseOnDeviceID;
      LastMouseOverHighlightDevice.Dimmer:=geraetesteuerung.get_dimmer(MouseOnDeviceID);
      LastMouseOverHighlightDevice.R:=geraetesteuerung.get_channel(MouseOnDeviceID, 'R');
      LastMouseOverHighlightDevice.G:=geraetesteuerung.get_channel(MouseOnDeviceID, 'G');
      LastMouseOverHighlightDevice.B:=geraetesteuerung.get_channel(MouseOnDeviceID, 'B');
      LastMouseOverHighlightDevice.A:=geraetesteuerung.get_channel(MouseOnDeviceID, 'A');
      LastMouseOverHighlightDevice.W:=geraetesteuerung.get_channel(MouseOnDeviceID, 'W');
      LastMouseOverHighlightDevice.ShutterOpenOrClose:=geraetesteuerung.get_shutter(MouseOnDeviceID);
    end;

    // Aktuelles Gerät setzen
    if MouseOnDeviceHover>-1 then
    begin
      geraetesteuerung.set_shutter(MouseOnDeviceID, 255);
      geraetesteuerung.set_color(MouseOnDeviceID, 255, 255, 255, 150, 0);
      geraetesteuerung.set_dimmer(MouseOnDeviceID, 255, 150, 0);
      geraetesteuerung.set_channel(MouseOnDeviceID, 'a', -1, 255, 150,0 );
      geraetesteuerung.set_channel(MouseOnDeviceID, 'w', -1, 255, 150,0 );
    end;
  end;
////////////

  if MouseOnDevice>-1 then
  begin
    if CheckBox3.Checked then exit;

    if mainform.devices[MouseOnDevice].hasDimmer then
    begin
      for k:=0 to length(mainform.devices[MouseOnDevice].kanaltyp)-1 do
      if lowercase(mainform.devices[MouseOnDevice].kanaltyp[k])='dimmer' then
        Paintbox1.Hint:=mainform.devices[MouseOnDevice].Name+' ('+mainform.levelstr(255-mainform.data.ch[mainform.devices[MouseOnDevice].Startaddress+k])+_('), Geräteicon')
    end else
    begin
      Paintbox1.Hint:=_('Geräteicon, ')+mainform.devices[MouseOnDevice].Name;
    end;

    if (Shift=[ssLeft]) or (Shift=[ssLeft, ssAlt]) then
    begin
      // Linke Maustaste
      RedrawPictures:=true;

      if (mainform.devices[MouseOnDevice].selected[MouseOnDeviceCopy]=false) then
      begin // einzelnes Gerätebild verschieben
        // Sender GeräteBild
        mainform.devices[MouseOnDevice].Left[MouseOnDeviceCopy]:=X-round(mainform.devices[MouseOnDevice].picturesize/2);
        mainform.devices[MouseOnDevice].Top[MouseOnDeviceCopy]:=Y-round(mainform.devices[MouseOnDevice].picturesize/2);

        for m:=0 to length(mainform.Devices)-1 do
        begin
          if (mainform.Devices[m].MatrixDeviceLevel=2) and (IsEqualGUID(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[MouseOnDevice].ID)) then
          begin
            mainform.Devices[m].left[MouseOnDeviceCopy]:=X-round(mainform.Devices[m].picturesize/2)+mainform.Devices[m].picturesize*mainform.Devices[m].MatrixXPosition;
            mainform.Devices[m].top[MouseOnDeviceCopy]:=Y-round(mainform.Devices[m].picturesize/2)+mainform.Devices[m].picturesize*mainform.Devices[m].MatrixYPosition;
          end;
        end;

        // Sender GeräteBild Ende
      end else
      begin
        if Shift=[ssLeft, ssAlt] then
        begin
          ArrangeIcons(MouseDownPoint.X, MouseDownPoint.Y, X, Y);
        end else
        begin
          // Andere GeräteBilder
          for k:=0 to length(mainform.devices)-1 do
          for l:=0 to length(mainform.devices[k].selected)-1 do
          begin
            if (mainform.devices[k].ShowInStageview and (mainform.devices[k].bank[l]=BankSelect.Itemindex) and (mainform.devices[k].selected[l])) then
            begin
              StopDeviceMoving:=(mainform.devices[k].OldPos[l].X-(MouseDownPoint.X-X)<0) or (mainform.devices[k].OldPos[l].X-(MouseDownPoint.X-X+mainform.devices[k].picturesize)>paintbox1.Width) or (mainform.devices[k].OldPos[l].Y-(MouseDownPoint.Y-Y)<0) or (mainform.devices[k].OldPos[l].Y-(MouseDownPoint.Y-Y+mainform.devices[k].picturesize)>paintbox1.Height);
              if not StopDeviceMoving then
              begin
                mainform.devices[k].Left[l]:=mainform.devices[k].OldPos[l].X-(MouseDownPoint.X-X);
                mainform.devices[k].Top[l]:=mainform.devices[k].OldPos[l].Y-(MouseDownPoint.Y-Y);
              end;
            end;
          end;
          // Andere GeräteBilder Ende

          // Andere Kanal-Bilder
          for k:=0 to length(mainform.buehnenansichtdevices)-1 do
          begin
            if ((mainform.buehnenansichtdevices[k].selected)) then
            begin
              StopDeviceMoving:=(mainform.buehnenansichtdevices[k].OldPos.X-(MouseDownPoint.X-X)<0) or (mainform.buehnenansichtdevices[k].OldPos.X-(MouseDownPoint.X-X+mainform.buehnenansichtdevices[k].picturesize)>paintbox1.Width) or (mainform.buehnenansichtdevices[k].OldPos.Y-(MouseDownPoint.Y-Y)<0) or (mainform.buehnenansichtdevices[k].OldPos.Y-(MouseDownPoint.Y-Y+mainform.buehnenansichtdevices[k].picturesize)>paintbox1.Height);
              if not StopDeviceMoving then
              begin
                mainform.buehnenansichtdevices[k].left:=mainform.buehnenansichtdevices[k].OldPos.X-(MouseDownPoint.X-X);
                mainform.buehnenansichtdevices[k].top:=mainform.buehnenansichtdevices[k].OldPos.Y-(MouseDownPoint.Y-Y);
              end;
            end;
          end;
          // Andere Kanal-Bilder Ende
        end;
      end;
      // Ende von Linke Maustaste
    end;
  end else if MouseOnBuehnenansichtDevice>-1 then
  begin
    if CheckBox3.Checked then exit;

    Paintbox1.Hint:=_('Kanalicon, Kanal: ')+inttostr(mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].channel)+' ('+inttostr(mainform.channel_value[mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].channel])+')';

    if (Shift=[ssLeft]) or (Shift=[ssLeft, ssAlt]) then
    begin
      // Linke Maustaste
      RedrawPictures:=true;

      if (mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].selected=false) then
      begin // einzelnes Gerätebild verschieben
        // Sender KanalBild
        mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].Left:=X-round(mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].picturesize/2);
        mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].Top:=Y-round(mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].picturesize/2);
        // Sender KanalBild Ende
      end else
      begin
        if Shift=[ssLeft, ssAlt] then
        begin
          ArrangeIcons(MouseDownPoint.X, MouseDownPoint.Y, X, Y);
        end else
        begin
          // Andere KanalBilder
          for k:=0 to length(mainform.Buehnenansichtdevices)-1 do
          begin
            if ((mainform.Buehnenansichtdevices[k].selected)) then
            begin
              StopDeviceMoving:=(mainform.Buehnenansichtdevices[k].OldPos.X-(MouseDownPoint.X-X)<0) or (mainform.Buehnenansichtdevices[k].OldPos.X-(MouseDownPoint.X-X+mainform.Buehnenansichtdevices[k].picturesize)>paintbox1.Width) or (mainform.Buehnenansichtdevices[k].OldPos.Y-(MouseDownPoint.Y-Y)<0) or (mainform.Buehnenansichtdevices[k].OldPos.Y-(MouseDownPoint.Y-Y+mainform.Buehnenansichtdevices[k].picturesize)>paintbox1.Height);
              if not StopDeviceMoving then
              begin
                mainform.Buehnenansichtdevices[k].Left:=mainform.Buehnenansichtdevices[k].OldPos.X-(MouseDownPoint.X-X);
                mainform.Buehnenansichtdevices[k].Top:=mainform.Buehnenansichtdevices[k].OldPos.Y-(MouseDownPoint.Y-Y);
              end;
            end;
          end;
          // Andere KanalBilder Ende

          // Andere Geräte-Bilder
          for k:=0 to length(mainform.devices)-1 do
          for l:=0 to length(mainform.devices[k].selected)-1 do
          begin
            if (mainform.devices[k].ShowInStageview and (mainform.devices[k].bank[l]=BankSelect.Itemindex) and (mainform.devices[k].selected[l])) then
            begin
              StopDeviceMoving:=(mainform.devices[k].OldPos[l].X-(MouseDownPoint.X-X)<0) or (mainform.devices[k].OldPos[l].X-(MouseDownPoint.X-X+mainform.devices[k].picturesize)>paintbox1.Width) or (mainform.devices[k].OldPos[l].Y-(MouseDownPoint.Y-Y)<0) or (mainform.devices[k].OldPos[l].Y-(MouseDownPoint.Y-Y+mainform.devices[k].picturesize)>paintbox1.Height);
              if not StopDeviceMoving then
              begin
                mainform.devices[k].left[l]:=mainform.devices[k].OldPos[l].X-(MouseDownPoint.X-X);
                mainform.devices[k].top[l]:=mainform.devices[k].OldPos[l].Y-(MouseDownPoint.Y-Y);
              end;
            end;
          end;
          // Andere Geräte-Bilder Ende
        end;
      end;
      // Ende von Linke Maustaste
    end;
  end else if MouseOnProgress>-1 then
  begin
    if Shift=[ssLeft] then
    begin
      value:=round(((X-mainform.devices[MouseOnProgress].left[MouseOnDeviceCopy])/mainform.devices[MouseOnProgress].picturesize)*255);
      if value<0 then value:=0;
      if value>255 then value:=255;
//      geraetesteuerung.set_channel(mainform.devices[MouseOnProgress].ID,'DIMMER',value,value,0);
      if mainform.devices[MouseOnProgress].hasDimmer then
        geraetesteuerung.set_dimmer(mainform.devices[MouseOnProgress].ID,value)
      else if mainform.devices[MouseOnProgress].hasFog then
        geraetesteuerung.set_channel(mainform.devices[MouseOnProgress].ID,'FOG',value,value,0);
    end;
  end else if MouseOnBuehnenansichtProgress>-1 then
  begin
    if Shift=[ssLeft] then
    begin
      value:=round(((X-mainform.buehnenansichtdevices[MouseOnBuehnenansichtProgress].left)/mainform.buehnenansichtdevices[MouseOnBuehnenansichtProgress].picturesize)*255);
      if value<0 then value:=0;
      if value>255 then value:=255;
      mainform.Senddata(mainform.buehnenansichtdevices[MouseOnBuehnenansichtProgress].channel, 255-value, 255-value, 0);
//      mainform.channel_value[mainform.buehnenansichtdevices[MouseOnBuehnenansichtProgress].channel]:=value;
    end;
  end else if MouseOnBuehnenansichtColor>-1 then
  begin
  end else if MouseOnLabel>-1 then
  begin
  end else if MouseOnNumber>-1 then
  begin
  end else if MouseOnBuehnenansichtNumber>-1 then
  begin
  end else if MouseOnBuehnenansichtLabel>-1 then
  begin
  end else
  begin
    If shift=[ssLeft] then
    begin
      Auswahl.Right:=X;
      Auswahl.Bottom:=Y;
      ShowAuswahl:=true;

      for i:=0 to length(mainform.buehnenansichtdevices)-1 do
      begin
        if mainform.buehnenansichtdevices[i].bank=BankSelect.Itemindex then
        begin
          // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
          if (mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2)<Auswahl.Left) and ((mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2))>Auswahl.Right) and (mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2)>Auswahl.Top) and ((mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2))<Auswahl.Bottom)
          or (mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2)>Auswahl.Left) and ((mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2))<Auswahl.Right) and (mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2)<Auswahl.Top) and ((mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2))>Auswahl.Bottom)
          or (mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2)>Auswahl.Left) and ((mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2))<Auswahl.Right) and (mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2)>Auswahl.Top) and ((mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2))<Auswahl.Bottom)
          or (mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2)<Auswahl.Left) and ((mainform.buehnenansichtdevices[i].left+(mainform.buehnenansichtdevices[i].picturesize div 2))>Auswahl.Right) and (mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2)<Auswahl.Top) and ((mainform.buehnenansichtdevices[i].Top+(mainform.buehnenansichtdevices[i].picturesize div 2))>Auswahl.Bottom) then
            mainform.buehnenansichtdevices[i].selected:=true else mainform.buehnenansichtdevices[i].selected:=false;
        end;
      end;

      for i:=0 to length(mainform.devices)-1 do
      for j:=0 to length(mainform.devices[i].bank)-1 do
      begin
        if (mainform.devices[i].ShowInStageview and (mainform.devices[i].bank[j]=BankSelect.Itemindex)) then
        begin
          // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
          if (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Bottom)
          or (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Bottom)
          or (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Bottom)
          or (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Bottom) then
            mainform.devices[i].selected[j]:=true else mainform.devices[i].selected[j]:=false;
        end;
      end;
    end;

    If (shift=[ssLeft,ssShift]) or (shift=[ssLeft,ssShift,ssCtrl]) then
    begin
      Auswahl.Right:=X;
      Auswahl.Bottom:=Y;
      ShowAuswahl:=true;

      for i:=0 to length(mainform.devices)-1 do
      for j:=0 to length(mainform.devices[i].bank)-1 do
      begin
        if (mainform.devices[i].ShowInStageview and (mainform.devices[i].bank[j]=BankSelect.Itemindex)) then
        begin
          // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
          if (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Bottom)
          or (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Bottom)
          or (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)>Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))<Auswahl.Bottom)
          or (mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Left) and ((mainform.devices[i].left[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Right) and (mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2)<Auswahl.Top) and ((mainform.devices[i].Top[j]+(mainform.devices[i].picturesize div 2))>Auswahl.Bottom) then
          begin
            mainform.DeviceSelected[i]:=true;
          end else
          begin
            if (shift=[ssLeft,ssShift]) then
              mainform.DeviceSelected[i]:=false; // if no Ctrl pressed, remove DeviceSelection again, if not within rectangle
          end;
        end;
      end;
    end;
  end;
  dorefresh:=true;
end;

procedure Tgrafischebuehnenansicht.StageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	j,k,m,oldvalue,channel,raster:integer;
  ddfwindowposition:integer;
  toppos, leftpos:single;
begin
  if not mainform.UserAccessGranted(2) then exit;

  ProcessorFriendlyRedraw:=false;

  MouseUpPoint.X:=X;
  MouseUpPoint.Y:=Y;

  paintbox1.PopupMenu:=popupmenu1;

  if MouseOnDevice>-1 then
  begin
    paintbox1.PopupMenu:=nil;
    
    // Strg+Klick
    if (Shift=[ssCtrl]) and (Button=mbLeft) and not (Shift=[ssCtrl,ssShift]) then
    begin
      mainform.devices[MouseOnDevice].selected[MouseOnDeviceCopy]:=not mainform.devices[MouseOnDevice].selected[MouseOnDeviceCopy];
    end;

    // Rechtsklick mit STRG oder Linksklick mit Shift
    if ((Shift=[ssCtrl]) and (Button=mbRight)) or ((Shift=[ssShift]) and (Button=mbLeft)) then
    begin
      mainform.DeviceSelected[MouseOnDevice]:=not mainform.DeviceSelected[MouseOnDevice];
      mainform.DeviceSelectionChanged(nil);
    end;

    // Nur Rechtsklick
    if (Shift=[]) and (Button=mbRight) then
    begin
      if Checkbox5.Checked then
      begin
        for j:=0 to length(ddfwindows)-1 do
        begin
          if ddfwindows[j].Showing then
            ddfwindows[j].Close;
          ddfwindows[j].Free;
        end;
        setlength(ddfwindows,0);
      end;

      ddfwindowposition:=-1;

      for j:=0 to length(ddfwindows)-1 do
      begin
        if IsEqualGUID(ddfwindows[j].thisddfwindowDeviceID,mainform.devices[MouseOnDevice].ID) then
        begin
          ddfwindowposition:=j;
          break;
        end;
      end;

      if ddfwindowposition=-1 then
      for j:=0 to length(ddfwindows)-1 do
      begin
        if ddfwindows[j].readyfordelete then
        begin
          ddfwindowposition:=j;
        end;
      end;
      
      if ddfwindowposition=-1 then
      begin
        setlength(ddfwindows,length(ddfwindows)+1);
        ddfwindows[length(ddfwindows)-1]:=TDDFWindow.Create(self);
        ddfwindowposition:=length(ddfwindows)-1;
      end;
      ddfwindows[ddfwindowposition].readyfordelete:=false;
      ddfwindows[ddfwindowposition].thisddfwindowDeviceID:=mainform.devices[MouseOnDevice].ID;
      ddfwindows[ddfwindowposition].Top:=grafischebuehnenansicht.Top+panel2.Top+16+mainform.devices[MouseOnDevice].Top[MouseOnDeviceCopy]+(mainform.devices[MouseOnDevice].picturesize div 2);
      ddfwindows[ddfwindowposition].Left:=grafischebuehnenansicht.Left+panel2.left+mainform.devices[MouseOnDevice].Left[MouseOnDeviceCopy]+(mainform.devices[MouseOnDevice].picturesize div 2);
      ddfwindows[ddfwindowposition].loadDDF(mainform.devices[MouseOnDevice].ID);
    end;

    if Checkbox4.Checked and (not (Checkbox3.Checked)) then
    begin
      raster:=32;
      case Combobox1.ItemIndex of
        0: raster:=8;
        1: raster:=16;
        2: raster:=24;
        3: raster:=32;
        4: raster:=48;
        5: raster:=64;
      end;

      // Geräte am Raster ausrichten
      for j:=0 to length(mainform.devices)-1 do
      begin
        for k:=0 to length(mainform.devices[j].left)-1 do
        begin
          toppos:=mainform.devices[j].Top[k]/raster;
          leftpos:=mainform.devices[j].Left[k]/raster;

          if frac(toppos)<0.5 then
            toppos:=trunc(toppos)
          else
            toppos:=trunc(toppos)+1;

          if frac(leftpos)<0.5 then
            leftpos:=trunc(leftpos)
          else
            leftpos:=trunc(leftpos)+1;

          mainform.devices[j].Top[k]:=round(toppos*raster);
          mainform.devices[j].Left[k]:=round(leftpos*raster);
        end;
      end;
      for k:=0 to length(mainform.buehnenansichtdevices)-1 do
      begin
        toppos:=mainform.buehnenansichtdevices[k].top/raster;
        leftpos:=mainform.buehnenansichtdevices[k].left/raster;

        if frac(toppos)<0.5 then
          toppos:=trunc(toppos)
        else
          toppos:=trunc(toppos)+1;

        if frac(leftpos)<0.5 then
          leftpos:=trunc(leftpos)
        else
          leftpos:=trunc(leftpos)+1;

        mainform.buehnenansichtdevices[k].top:=round(toppos*raster);
        mainform.buehnenansichtdevices[k].left:=round(leftpos*raster);
      end;
    end;
    ProcessorFriendlyRedraw:=false;
    RedrawPictures:=true;
  end else if MouseOnBuehnenansichtDevice>-1 then
  begin
    paintbox1.PopupMenu:=devicepicture_popup;

    // Strg+Klick
 	  if (Shift=[ssCtrl]) and (Button=mbLeft) and not (Shift=[ssCtrl,ssShift]) then
    begin
      mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].selected:=not mainform.Buehnenansichtdevices[MouseOnBuehnenansichtDevice].selected;
    end;

    if Checkbox4.Checked and (not (Checkbox3.Checked)) then
    begin
      raster:=32;
      case Combobox1.ItemIndex of
        0: raster:=8;
        1: raster:=16;
        2: raster:=24;
        3: raster:=32;
        4: raster:=48;
        5: raster:=64;
      end;

      // Geräte am Raster ausrichten
      for j:=0 to length(mainform.devices)-1 do
      begin
        for k:=0 to length(mainform.devices[j].left)-1 do
        begin
          toppos:=mainform.devices[j].Top[k]/raster;
          leftpos:=mainform.devices[j].Left[k]/raster;

          if frac(toppos)<0.5 then
            toppos:=trunc(toppos)
          else
            toppos:=trunc(toppos)+1;

          if frac(leftpos)<0.5 then
            leftpos:=trunc(leftpos)
          else
            leftpos:=trunc(leftpos)+1;

          mainform.devices[j].Top[k]:=round(toppos*raster);
          mainform.devices[j].Left[k]:=round(leftpos*raster);
        end;
      end;
      for k:=0 to length(mainform.buehnenansichtdevices)-1 do
      begin
        toppos:=mainform.buehnenansichtdevices[k].top/raster;
        leftpos:=mainform.buehnenansichtdevices[k].left/raster;

        if frac(toppos)<0.5 then
          toppos:=trunc(toppos)
        else
          toppos:=trunc(toppos)+1;

        if frac(leftpos)<0.5 then
          leftpos:=trunc(leftpos)
        else
          leftpos:=trunc(leftpos)+1;

        mainform.buehnenansichtdevices[k].top:=round(toppos*raster);
        mainform.buehnenansichtdevices[k].left:=round(leftpos*raster);
      end;
    end;
    ProcessorFriendlyRedraw:=false;
    RedrawPictures:=true;
  end else if MouseOnProgress>-1 then
  begin
    paintbox1.PopupMenu:=nil;
  end else if MouseOnBuehnenansichtProgress>-1 then
  begin
    paintbox1.PopupMenu:=nil;
{
  end else if MouseOnBuehnenansichtColor>-1 then
  begin
  	//Farbe ändern
    paintbox1.PopupMenu:=nil;
    colorbox1.Top:=mainform.buehnenansichtdevices[MouseOnBuehnenansichtColor].Top;
    colorbox1.Left:=mainform.buehnenansichtdevices[MouseOnBuehnenansichtColor].Left+mainform.buehnenansichtdevices[MouseOnBuehnenansichtColor].picturesize;
    colorbox1.SelectedColor:=mainform.buehnenansichtdevices[MouseOnBuehnenansichtColor].color;
    colorbox1.BringToFront;
    colorbox1.Visible:=(mainform.buehnenansichtdevices[MouseOnBuehnenansichtColor].bank=BankSelect.Itemindex);
}
  end else if MouseOnLabel>-1 then
  begin
    if not mainform.UserAccessGranted(1) then exit;

    paintbox1.PopupMenu:=nil;
    if Button=mbRight then
    begin
      if mainform.Devices[MouseOnLabel].MatrixDeviceLevel=0 then
        mainform.Devices[MouseOnLabel].Name:=InputBox(_('Beschriftung für "')+mainform.Devices[MouseOnLabel].Name+'"',_('Bitte geben Sie eine neue Bezeichnung für das aktuelle Gerät ein:'),mainform.Devices[MouseOnLabel].Name)
      else begin
        mainform.Devices[MouseOnLabel].Name:='[M] '+InputBox(_('Beschriftung für "')+mainform.Devices[MouseOnLabel].Name+'"',_('Bitte geben Sie eine neue Bezeichnung für das gewählte Matrix-Gerät ein:'),copy(mainform.Devices[MouseOnLabel].Name, 5, length(mainform.Devices[MouseOnLabel].Name)));

        for m:=0 to length(mainform.Devices)-1 do
        begin
          if (mainform.Devices[m].MatrixDeviceLevel=2) and (IsEqualGUID(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[MouseOnLabel].ID)) then
          begin
            mainform.Devices[m].Name:='[M '+inttostr(mainform.Devices[m].MatrixXPosition+1)+'x'+inttostr(mainform.Devices[m].MatrixYPosition+1)+'] '+copy(mainform.Devices[MouseOnLabel].Name, 5, length(mainform.Devices[MouseOnLabel].Name));
          end;
        end;
      end;

      for k:=0 to mainform.Devices[MouseOnLabel].MaxChan-1 do
        mainform.data.Names[mainform.Devices[MouseOnLabel].Startaddress+k]:=mainform.Devices[MouseOnLabel].Name+': '+mainform.Devices[MouseOnLabel].Kanalname[k];
    end;
  end else if MouseOnNumber>-1 then
  begin
    if not mainform.UserAccessGranted(1) then exit;

    paintbox1.PopupMenu:=nil;
    if Button=mbRight then
    begin
    	// Kanalnummer ändern
      if mainform.Devices[MouseOnNumber].MatrixDeviceLevel=0 then
      begin
        try
          channel:=strtoint(InputBox(_('Kanaleinstellung'),_('Welche Startadresse soll für dieses Gerät gelten:'),inttostr(mainform.devices[MouseOnNumber].Startaddress)));
          geraetesteuerung.ChangeDeviceStartaddress(mainform.devices[MouseOnNumber].ID, channel);
        except
        end;
      end else
      begin
        try
          channel:=strtoint(InputBox(_('Kanaleinstellung'),_('Welche Startadresse soll für dieses Matrix-Gerät gelten:'),inttostr(mainform.devices[MouseOnNumber].Startaddress)));
          geraetesteuerung.ChangeDeviceStartaddress(mainform.devices[MouseOnNumber].ID, channel);

          for m:=0 to length(mainform.Devices)-1 do
          begin
            if (mainform.Devices[m].MatrixDeviceLevel=2) and (IsEqualGUID(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[MouseOnNumber].ID)) then
            begin
              geraetesteuerung.ChangeDeviceStartaddress(mainform.Devices[m].ID, geraetesteuerung.GetMatrixDeviceStartAddress(mainform.Devices[m].MatrixMainDeviceID, mainform.devices[m].MatrixXPosition, mainform.devices[m].MatrixYPosition));
            end;
          end;
        except
        end;
      end;
    end;
  end else if MouseOnBuehnenansichtNumber>-1 then
  begin
    if not mainform.UserAccessGranted(1) then exit;

    paintbox1.PopupMenu:=nil;
    if Button=mbRight then
    begin
    	// Kanalnummer ändern
  	  oldvalue:=mainform.buehnenansichtdevices[MouseOnBuehnenansichtNumber].channel;
  	  try
  	  	channel:=strtoint(InputBox(_('Kanaleinstellung'),_('Welcher Kanal soll für dieses Gerät gelten:'),inttostr(mainform.buehnenansichtdevices[MouseOnBuehnenansichtNumber].channel)));
        if channel>mainform.lastchan then
        	mainform.buehnenansichtdevices[MouseOnBuehnenansichtNumber].channel:=mainform.lastchan
  			else if channel<1 then
        	mainform.buehnenansichtdevices[MouseOnBuehnenansichtNumber].channel:=1
        else
        	mainform.buehnenansichtdevices[MouseOnBuehnenansichtNumber].channel:=channel;
  	  except
  	  	mainform.buehnenansichtdevices[MouseOnBuehnenansichtNumber].channel:=oldvalue;
  	  end;
    end;
  end else if MouseOnBuehnenansichtLabel>-1 then
  begin
    if not mainform.UserAccessGranted(1) then exit;

    paintbox1.PopupMenu:=nil;
    if Button=mbRight then
    begin
    	// Kanalname ändern
      Kanalnamenndern1Click(Kanalnamenndern1);
    end;
  end else
  begin
    DeviceSelectedTimer.enabled:=false;

    Auswahl.Left:=X;
    Auswahl.Top:=Y;
    Auswahl.Right:=X;
    Auswahl.Bottom:=Y;
    ShowAuswahl:=false;

    mainform.DeviceSelectionChanged(nil);
  end;

	dorefresh:=true;
	RefreshTimerTimer(sender);

  MouseOnBuehnenansichtdevice:=-1;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnDeviceCopy:=-1;
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtColor:=-1;
end;

procedure Tgrafischebuehnenansicht.BhnenansichtalsBilddateispeichern1Click(
  Sender: TObject);
var
	image1:TImage;
begin
  savedialog1.Title:=_('PC_DIMMER Bühnenansicht speichern...');
  savedialog1.Filter:=_('Windows-Bitmap (*.bmp)|*.bmp|*.*|*.*');
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
	if messagedlg(_('Die gesamte Bühnenansicht mit dem Standarddrucker "')+Printer.Printers[Printer.PrinterIndex]+_('" ausdrucken?'),mtConfirmation,
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
  
procedure Tgrafischebuehnenansicht.Button2Click(Sender: TObject);
var
	i:integer;
begin
	setlength(mainform.buehnenansichtdevices,length(mainform.buehnenansichtdevices)+1);

  i:=length(mainform.buehnenansichtdevices)-1;
  mainform.buehnenansichtdevices[i].picture:=mainform.pcdimmerdirectory+'Devicepictures\32 x 32\par56silber.png';
  mainform.buehnenansichtdevices[i].channel:=1;
  mainform.buehnenansichtdevices[i].pictureispng:=true;
	mainform.buehnenansichtdevices[i].color:=clWhite;
  mainform.buehnenansichtdevices[i].top:=0;
  mainform.buehnenansichtdevices[i].left:=0;
  mainform.buehnenansichtdevices[i].picturesize:=32;
  mainform.buehnenansichtdevices[i].bank:=0;
  mainform.buehnenansichtdevices[i].color:=clYellow;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.openscene(scenefilename:string);
var
  i,laenge:integer;
  text:string;
begin
    filename:=extractfilename(scenefilename);
    filepath:=extractfilepath(scenefilename);

    // Temp-Verzeichnis reinigen
    mainform.DeleteDirectory(mainform.userdirectory+'Temp');
    CreateDir(mainform.userdirectory+'Temp');

    if (filepath+filename)<>(mainform.userdirectory+'ProjectTemp\Bühnenansicht\Bühnenansicht') then
    	Compress.DecompressFile(filepath+filename,mainform.userdirectory+'Temp\',true,false);

    if fileexists(mainform.userdirectory+'Temp\Bühnenansicht') then
	    FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Bühnenansicht',fmOpenRead)
    else
      FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\'+filename,fmOpenRead);
    FileStream.ReadBuffer(mainform.buehnenansichtsetup,sizeof(mainform.buehnenansichtsetup));

    FileStream.ReadBuffer(laenge,sizeof(laenge));
    grafischebuehnenansicht.BankSelect.Clear;
    grafischebuehnenansicht.BankCopy.Clear;
    for i:=0 to laenge-1 do
    begin
      FileStream.ReadBuffer(text, sizeof(text));
      grafischebuehnenansicht.BankSelect.Items.Add(text);
      grafischebuehnenansicht.BankCopy.Items.Add(text);
    end;
    mainform.BankSelect.Items:=BankSelect.Items;
    mainform.BankSelect.Itemindex:=BankSelect.Itemindex;
    mainform.BankCopy.Items:=BankCopy.Items;
    mainform.BankCopy.Itemindex:=BankCopy.Itemindex;

    FileStream.ReadBuffer(laenge,sizeof(laenge));
		setlength(mainform.buehnenansichtdevices,laenge);
    for i:=0 to laenge-1 do
    begin
    	FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].channel,sizeof(mainform.buehnenansichtdevices[i].channel));
    	FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].color,sizeof(mainform.buehnenansichtdevices[i].color));
    	FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].picture,sizeof(mainform.buehnenansichtdevices[i].picture));
      FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].picturesize,sizeof(mainform.buehnenansichtdevices[i].picturesize));
      FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].pictureangle,sizeof(mainform.buehnenansichtdevices[i].pictureangle));
      FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].picturefliphor,sizeof(mainform.buehnenansichtdevices[i].picturefliphor));
      FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].pictureflipver,sizeof(mainform.buehnenansichtdevices[i].pictureflipver));
      FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].pictureispng,sizeof(mainform.buehnenansichtdevices[i].pictureispng));
    	FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].top,sizeof(mainform.buehnenansichtdevices[i].top));
    	FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].left,sizeof(mainform.buehnenansichtdevices[i].left));
    	FileStream.ReadBuffer(mainform.buehnenansichtdevices[i].bank,sizeof(mainform.buehnenansichtdevices[i].bank));
    end;
    FileStream.Free;

    // Temp-Verzeichnis reinigen
    mainform.DeleteDirectory(mainform.userdirectory+'Temp');
    CreateDir(mainform.userdirectory+'Temp');

    if pos('\ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex])>0 then
      mainform.buehnenansicht_background[BankSelect.ItemIndex]:=mainform.userdirectory+copy(mainform.buehnenansicht_background[BankSelect.ItemIndex],pos('ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex]),length(mainform.buehnenansicht_background[BankSelect.ItemIndex]));

//{
    if not startingup then
    begin
      if mainform.buehnenansicht_background[BankSelect.ItemIndex]<>'' then
      if FileExists(mainform.buehnenansicht_background[BankSelect.ItemIndex]) then
        Stage.Picture.LoadFromFile(mainform.buehnenansicht_background[BankSelect.ItemIndex])
      else
      if FileExists(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
        Stage.Picture.LoadFromFile(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
      else if FileExists(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
        Stage.Picture.LoadFromFile(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
      else
        if messagedlg(_('Das Hintergrundbild "')+mainform.buehnenansicht_background[BankSelect.ItemIndex]+_('" für die Bühnenansicht wurde nicht gefunden. Möchten Sie jetzt danach suchen?'),mtConfirmation,
          [mbYes,mbNo],0)=mrYes then
          begin
            opendialog1.Title:=_('Bilddatei öffnen...');
      	    OpenDialog1.Filter:=_('Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*');
            opendialog1.FileName:='';
            opendialog1.DefaultExt:='*.bmp;*.jpg;*.gif;*.ico;*.png';
            if OpenDialog1.Execute then
            begin
              grafischebuehnenansicht.Stage.Picture.LoadFromFile(OpenDialog1.FileName);
              mainform.buehnenansicht_background[BankSelect.ItemIndex]:=OpenDialog1.FileName;
            end;
          end else
          begin
	   	      stage.Picture:=Referenzbild2.Picture;
            mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
          end;
    end;
//}

  if not startingup then
  begin
    grafischebuehnenansicht.Width:=mainform.buehnenansichtsetup.Buehnenansicht_width;
    grafischebuehnenansicht.Height:=mainform.buehnenansichtsetup.Buehnenansicht_height;
    panel1.Visible:=mainform.buehnenansichtsetup.Buehnenansicht_panel;
  end;
end;

procedure Tgrafischebuehnenansicht.savescene(scenefilename:string);
var
  i,laenge:integer;
  filename,filepath:string;
  text:string;
begin
  mainform.buehnenansichtsetup.Buehnenansicht_width:=grafischebuehnenansicht.Width;
  mainform.buehnenansichtsetup.Buehnenansicht_height:=grafischebuehnenansicht.Height;
  mainform.buehnenansichtsetup.Buehnenansicht_panel:=panel1.Visible;

  filename:=extractfilename(scenefilename);
  filepath:=extractfilepath(scenefilename);

  if pos('\ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex])>0 then
    mainform.buehnenansicht_background[BankSelect.ItemIndex]:=mainform.userdirectory+copy(mainform.buehnenansicht_background[BankSelect.ItemIndex],pos('ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex]),length(mainform.buehnenansicht_background[BankSelect.ItemIndex]));

  try
    // Temp-Verzeichnis reinigen
    mainform.DeleteDirectory(mainform.userdirectory+'Temp');
    CreateDir(mainform.userdirectory+'Temp');

    FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Bühnenansicht',fmCreate);
    FileStream.WriteBuffer(mainform.buehnenansichtsetup,sizeof(mainform.buehnenansichtsetup));

    laenge:=BankSelect.Items.Count;
    FileStream.WriteBuffer(laenge,sizeof(laenge));
    for i:=0 to BankSelect.Items.Count-1 do
    begin
      text:=BankSelect.Items[i];
      FileStream.WriteBuffer(text, sizeof(text));
    end;

    laenge:=length(mainform.buehnenansichtdevices);
    FileStream.WriteBuffer(laenge,sizeof(laenge));
    for i:=0 to laenge-1 do
    begin
    	FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].channel,sizeof(mainform.buehnenansichtdevices[i].channel));
    	FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].color,sizeof(mainform.buehnenansichtdevices[i].color));
    	FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].picture,sizeof(mainform.buehnenansichtdevices[i].picture));
      FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].picturesize,sizeof(mainform.buehnenansichtdevices[i].picturesize));
      FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].pictureangle,sizeof(mainform.buehnenansichtdevices[i].pictureangle));
      FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].picturefliphor,sizeof(mainform.buehnenansichtdevices[i].picturefliphor));
      FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].pictureflipver,sizeof(mainform.buehnenansichtdevices[i].pictureflipver));
      FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].pictureispng,sizeof(mainform.buehnenansichtdevices[i].pictureispng));
    	FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].top,sizeof(mainform.buehnenansichtdevices[i].top));
    	FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].left,sizeof(mainform.buehnenansichtdevices[i].left));
    	FileStream.WriteBuffer(mainform.buehnenansichtdevices[i].bank,sizeof(mainform.buehnenansichtdevices[i].bank));
    end;
    FileStream.Free;

    if (filepath+filename)<>(mainform.userdirectory+'Temp\Bühnenansicht') then
	    Compress.CompressDirectory(mainform.userdirectory+'Temp\',false,filepath+filename);

    // Temp-Verzeichnis reinigen
    mainform.DeleteDirectory(mainform.userdirectory+'Temp');
    CreateDir(mainform.userdirectory+'Temp');
  except
    ShowMessage(_('Bühnenansicht: Es ist ein Fehler beim Speichern der Szene aufgetreten.'));
  end;
end;

procedure Tgrafischebuehnenansicht.deletedevice(i:integer);
var
	letzteposition:integer;
begin
  letzteposition:=length(mainform.buehnenansichtdevices)-1;

  if (i<>letzteposition) then
  begin
	  // zu löschende Arrayposition durch letzten Arraywert ersetzen
	  mainform.buehnenansichtdevices[i].channel:=mainform.buehnenansichtdevices[letzteposition].channel;
	  mainform.buehnenansichtdevices[i].color:=mainform.buehnenansichtdevices[letzteposition].color;
	  mainform.buehnenansichtdevices[i].top:=mainform.buehnenansichtdevices[letzteposition].top;
	  mainform.buehnenansichtdevices[i].left:=mainform.buehnenansichtdevices[letzteposition].left;
	  mainform.buehnenansichtdevices[i].picture:=mainform.buehnenansichtdevices[letzteposition].picture;
	  mainform.buehnenansichtdevices[i].picturesize:=mainform.buehnenansichtdevices[letzteposition].picturesize;
	  mainform.buehnenansichtdevices[i].pictureangle:=mainform.buehnenansichtdevices[letzteposition].pictureangle;
	  mainform.buehnenansichtdevices[i].picturefliphor:=mainform.buehnenansichtdevices[letzteposition].picturefliphor;
	  mainform.buehnenansichtdevices[i].pictureflipver:=mainform.buehnenansichtdevices[letzteposition].pictureflipver;
	  mainform.buehnenansichtdevices[i].pictureispng:=mainform.buehnenansichtdevices[letzteposition].pictureispng;
	  mainform.buehnenansichtdevices[i].bank:=mainform.buehnenansichtdevices[letzteposition].bank;
	  mainform.buehnenansichtdevices[i].selected:=mainform.buehnenansichtdevices[letzteposition].selected;
  end;
	setlength(mainform.buehnenansichtdevices,length(mainform.buehnenansichtdevices)-1);
end;

procedure Tgrafischebuehnenansicht.Gertebildndern1Click(Sender: TObject);
begin
  if (LastBuehnenansichtdevice<=length(mainform.buehnenansichtdevices)-1) and (LastBuehnenansichtdevice>-1) then
  begin
    OpenDialog1.Filter:=_('PNG-Datei (*.png)|*.png');
    OpenDialog1.InitialDir:=mainform.pcdimmerdirectory+'Devicepictures\32 x 32\';
    opendialog1.FileName:='';
    opendialog1.Options:=[ofNoChangeDir, ofEnableSizing];
    If OpenDialog1.Execute then
    begin
      mainform.buehnenansichtdevices[LastBuehnenansichtdevice].picture:=OpenDialog1.Filename;
    end;
    opendialog1.Options:=[ofEnableSizing];

	  dorefresh:=true;
    RedrawPictures:=true;
  	RefreshTimerTimer(sender);
  end;
end;

procedure Tgrafischebuehnenansicht.Gertlschen1Click(Sender: TObject);
begin
  if (LastBuehnenansichtdevice<=length(mainform.buehnenansichtdevices)-1) and (LastBuehnenansichtdevice>-1) then
  begin
    deletedevice(LastBuehnenansichtdevice);
  end;
end;

procedure Tgrafischebuehnenansicht.Kanalnamenndern1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (LastBuehnenansichtdevice<=length(mainform.buehnenansichtdevices)-1) then
  begin
	  mainform.data.names[mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel]:=InputBox(_('Beschriftung für "')+mainform.data.names[mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel]+'"',_('Bitte geben Sie eine neue Bezeichnung für den aktuellen Kanal ein:'),mainform.data.names[mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel]);
    mainform.pluginsaktualisieren(Sender);
  end;
end;

procedure Tgrafischebuehnenansicht.Kanalnummerndern1Click(Sender: TObject);
var
	oldvalue,channel:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (LastBuehnenansichtdevice<=length(mainform.buehnenansichtdevices)-1) then
  begin
		  oldvalue:=mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel;
		  try
		  	channel:=strtoint(InputBox(_('Kanaleinstellung'),_('Welcher Kanal soll für dieses Gerät gelten:'),inttostr(mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel)));
	      if channel>mainform.lastchan then
	      	mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel:=mainform.lastchan
				else if channel<1 then
	      	mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel:=1
	      else
	      	mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel:=channel;
		  except
		  	mainform.buehnenansichtdevices[LastBuehnenansichtdevice].channel:=oldvalue;
		  end;
	end;
end;

procedure Tgrafischebuehnenansicht.colorbox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  colorbox1.Visible:=false;
end;

procedure Tgrafischebuehnenansicht.CheckBox2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          LReg.WriteBool('Huge colorshapes',checkbox2.checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  RedrawPictures:=true;

  mainform.CheckBox2.Checked:=Checkbox2.Checked;
end;

procedure Tgrafischebuehnenansicht.GroeFarbanzeige1Click(Sender: TObject);
begin
  Checkbox2.Checked:=not Checkbox2.Checked;
  CheckBox2MouseUp(Sender,mbLeft,[ssLeft],0,0);
end;

procedure Tgrafischebuehnenansicht.NewPanel;
begin
  application.ProcessMessages;
  sleep(100);

  stage.Picture:=Referenzbild2.Picture;

  trackbar1.Position:=2;
  mainform.buehnenansichtsetup.Buehnenansicht_width:=880;
  mainform.buehnenansichtsetup.Buehnenansicht_height:=450;
  mainform.buehnenansichtsetup.Buehnenansicht_panel:=true;

  BankSelect.Clear;
  BankCopy.Clear;
  BankSelect.Items.Add(_('Bühne 1'));
  BankCopy.Items.Add(_('Bühne 1'));
  BankSelect.Itemindex:=0;
  mainform.BankSelect.Items:=BankSelect.Items;
  mainform.BankSelect.Itemindex:=BankSelect.Itemindex;
  mainform.BankCopy.Items:=BankCopy.Items;
  mainform.BankCopy.Itemindex:=BankCopy.Itemindex;
  setlength(mainform.buehnenansicht_background,1);
  mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';

  setlength(mainform.buehnenansichtdevices,0);

  grafischebuehnenansicht.Width:=mainform.buehnenansichtsetup.Buehnenansicht_width;
  grafischebuehnenansicht.Height:=mainform.buehnenansichtsetup.Buehnenansicht_height;
  panel1.Visible:=mainform.buehnenansichtsetup.Buehnenansicht_panel;

  SaveStageviewToFile('jpg');
end;

procedure Tgrafischebuehnenansicht.Trackbar1Change(Sender: TObject);
var
  i,j:integer;
begin
  label6.caption:=inttostr(TrackBar1.Position)+'x'+inttostr(TrackBar1.Position)+'px';

  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if (mainform.buehnenansichtdevices[i].selected) then
      mainform.buehnenansichtdevices[i].picturesize:=TrackBar1.Position;
  end;
  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].selected)-1 do
  begin
    if (mainform.devices[i].selected[j]) then
      mainform.devices[i].picturesize:=TrackBar1.Position;
  end;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.FlipHorBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if (mainform.buehnenansichtdevices[i].selected) then
    begin
      mainform.buehnenansichtdevices[i].picturefliphor:=not mainform.buehnenansichtdevices[i].picturefliphor;
    end;
  end;

  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].selected)-1 do
  begin
    if (mainform.devices[i].selected[j]) then
    begin
      mainform.devices[i].picturefliphor:=not mainform.devices[i].picturefliphor;
    end;
  end;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.FlipVerBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if (mainform.buehnenansichtdevices[i].selected) then
    begin
      mainform.buehnenansichtdevices[i].pictureflipver:=not mainform.buehnenansichtdevices[i].pictureflipver;
    end;
  end;

  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].selected)-1 do
  begin
    if (mainform.devices[i].selected[j]) then
    begin
      mainform.devices[i].pictureflipver:=not mainform.devices[i].pictureflipver;
    end;
  end;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.CreateParams(var Params:TCreateParams);
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

procedure Tgrafischebuehnenansicht.RefreshStageView;
begin
  filename:='';
  filepath:='';

  if (BankSelect.ItemIndex>-1) and (BankSelect.ItemIndex<length(mainform.buehnenansicht_background)) then
  begin
    if pos('\ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex])>0 then
      mainform.buehnenansicht_background[BankSelect.ItemIndex]:=mainform.userdirectory+copy(mainform.buehnenansicht_background[BankSelect.ItemIndex],pos('ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex]),length(mainform.buehnenansicht_background[BankSelect.ItemIndex]));

    if not startingup then
    begin
      if mainform.buehnenansicht_background[BankSelect.ItemIndex]<>'' then
      begin
        if FileExists(mainform.buehnenansicht_background[BankSelect.ItemIndex]) then
          Stage.Picture.LoadFromFile(mainform.buehnenansicht_background[BankSelect.ItemIndex])
        else
        begin
          if FileExists(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
            Stage.Picture.LoadFromFile(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
          else if FileExists(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
            Stage.Picture.LoadFromFile(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
          else
          begin
            if messagedlg(_('Das Hintergrundbild "')+mainform.buehnenansicht_background[BankSelect.ItemIndex]+_('" für die Bühnenansicht wurde nicht gefunden. Möchten Sie jetzt danach suchen?'),mtConfirmation,
              [mbYes,mbNo],0)=mrYes then
            begin
              opendialog1.Title:=_('Bilddatei öffnen...');
              OpenDialog1.Filter:=_('Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*');
              opendialog1.FileName:='';
              opendialog1.DefaultExt:='*.bmp;*.jpg;*.gif;*.ico;*.png';
              if OpenDialog1.Execute then
              begin
                grafischebuehnenansicht.Stage.Picture.LoadFromFile(OpenDialog1.FileName);
                mainform.buehnenansicht_background[BankSelect.ItemIndex]:=OpenDialog1.FileName;
              end;
            end else
            begin
              stage.Picture:=Referenzbild2.Picture;
              mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
            end;
          end;
        end;
      end else
      begin
        stage.Picture:=Referenzbild2.Picture;
        mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
      end;
    end;
  end;

  if not startingup then
  begin
    grafischebuehnenansicht.Width:=mainform.buehnenansichtsetup.Buehnenansicht_width;
    grafischebuehnenansicht.Height:=mainform.buehnenansichtsetup.Buehnenansicht_height;
    panel1.Visible:=mainform.buehnenansichtsetup.Buehnenansicht_panel;
  end;
end;

procedure Tgrafischebuehnenansicht.MSGOpen;
begin
    if pos('\ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex])>0 then
      mainform.buehnenansicht_background[BankSelect.ItemIndex]:=mainform.userdirectory+copy(mainform.buehnenansicht_background[BankSelect.ItemIndex],pos('ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex]),length(mainform.buehnenansicht_background[BankSelect.ItemIndex]));

//{
    if (not startingup) and (BankSelect.ItemIndex>-1) and (BankSelect.ItemIndex<length(mainform.buehnenansicht_background)) then
    begin
      if mainform.buehnenansicht_background[BankSelect.ItemIndex]<>'' then
      begin
        if FileExists(mainform.buehnenansicht_background[BankSelect.ItemIndex]) then
          Stage.Picture.LoadFromFile(mainform.buehnenansicht_background[BankSelect.ItemIndex])
        else
        begin
          if FileExists(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
            Stage.Picture.LoadFromFile(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
          else if FileExists(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
            Stage.Picture.LoadFromFile(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
          else
          begin
            if messagedlg(_('Das Hintergrundbild "')+mainform.buehnenansicht_background[BankSelect.ItemIndex]+_('" für die Bühnenansicht wurde nicht gefunden. Möchten Sie jetzt danach suchen?'),mtConfirmation,
              [mbYes,mbNo],0)=mrYes then
            begin
              opendialog1.Title:=_('Bilddatei öffnen...');
              OpenDialog1.Filter:=_('Bilddateien (*.bmp;*.jpg;*.gif;*.ico;*.png)|*.bmp;*.jpg;*.gif;*.ico;*.png|Alle Dateien (*.*)|*.*');
              opendialog1.FileName:='';
              opendialog1.DefaultExt:='*.bmp;*.jpg;*.gif;*.ico;*.png';
              if OpenDialog1.Execute then
              begin
                grafischebuehnenansicht.Stage.Picture.LoadFromFile(OpenDialog1.FileName);
                mainform.buehnenansicht_background[BankSelect.ItemIndex]:=OpenDialog1.FileName;
              end;
            end else
            begin
              stage.Picture:=Referenzbild2.Picture;
              mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
            end;
          end;
        end;
      end;
    end;
//}

  grafischebuehnenansicht.Width:=mainform.buehnenansichtsetup.Buehnenansicht_width;
  grafischebuehnenansicht.Height:=mainform.buehnenansichtsetup.Buehnenansicht_height;
  panel1.Visible:=mainform.buehnenansichtsetup.Buehnenansicht_panel;

  SaveStageviewToFile('jpg');

  BankSelect.ItemIndex:=0;
  BankSelectSelect(nil);
  mainform.BankSelect.Items:=BankSelect.Items;
  mainform.BankSelect.Itemindex:=BankSelect.Itemindex;
  mainform.BankCopy.Items:=BankCopy.Items;
  mainform.BankCopy.Itemindex:=BankCopy.Itemindex;
end;

procedure Tgrafischebuehnenansicht.MSGSave;
begin
  mainform.buehnenansichtsetup.Buehnenansicht_width:=grafischebuehnenansicht.Width;
  mainform.buehnenansichtsetup.Buehnenansicht_height:=grafischebuehnenansicht.Height;
  mainform.buehnenansichtsetup.Buehnenansicht_panel:=panel1.Visible;
end;

procedure Tgrafischebuehnenansicht.DeviceSelectedTimerTimer(
  Sender: TObject);
begin
  mainform.DeviceSelectionChanged(nil);
  if (BankSelect.Itemindex<0) and (BankSelect.Items.Count>0) then
    BankSelect.Itemindex:=0;
end;

procedure Tgrafischebuehnenansicht.Button1Click(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.devices)-1 do
    mainform.DeviceSelected[i]:=false;

  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].bank)-1 do
  begin
    if (mainform.devices[i].selected[j]) then
    begin
      mainform.DeviceSelected[i]:=true;
      break;
    end;
  end;
  mainform.DeviceSelectionChanged(nil);
end;

procedure Tgrafischebuehnenansicht.CheckBox5MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          LReg.WriteBool('Only one DDF at time',checkbox5.checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  mainform.CheckBox5.Checked:=Checkbox5.Checked;
end;

procedure Tgrafischebuehnenansicht.RefreshTimerTimer(Sender: TObject);
var
  i:integer;
begin
  RefreshTimer.Interval:=mainform.Rfr_Buehnenansicht;

  if not dorefresh then
  begin
    for i:=1 to mainform.lastchan do
    begin
      if (oldvalues[i]<>(mainform.channel_value[i])) then
      begin
        dorefresh:=true;
        break;
      end;
    end;
  end;
  Move(mainform.channel_value, oldvalues, sizeof(mainform.channel_value));

  // von Zeit zu Zeit aktualisieren
  if Counter>=trunc(mainform.Rfr_Buehnenansicht/10) then
  begin
    dorefresh:=true;
    Counter:=0;
  end;
  Counter:=Counter+1;

  if not (dorefresh or RedrawPictures) then exit;
  dorefresh:=false;

  if grafischebuehnenansicht.Showing or nodecontrolform.showing or ((mainform.pagecontrol1.ActivePageIndex=0) and (mainform.Panel1.Visible)) then
  begin
    if ((Puffer1.Width<mainform.Paintbox1.Width) or (Puffer2.Width<mainform.Paintbox1.Width)) then
    begin
      Puffer1.Width:=mainform.Paintbox1.Width;
      Puffer2.Width:=mainform.Paintbox1.Width;
      RedrawPictures:=true;
    end else if ((Puffer1.Width<Paintbox1.Width) or (Puffer2.Width<Paintbox1.Width)) then
    begin
      Puffer1.Width:=Paintbox1.Width;
      Puffer2.Width:=Paintbox1.Width;
      RedrawPictures:=true;
    end else
    begin
      if ((Puffer1.Width<>Paintbox1.Width) or (Puffer2.Width<>Paintbox1.Width)) and
        ((Puffer1.Width>mainform.Paintbox1.Width) and (Puffer2.Width>mainform.Paintbox1.Width)) then
      begin
        Puffer1.Width:=Paintbox1.Width;
        Puffer2.Width:=Paintbox1.Width;
        RedrawPictures:=true;
      end;
    end;

    if ((Puffer1.Height<mainform.Paintbox1.Height) or (Puffer2.Height<mainform.Paintbox1.Height)) then
    begin
      Puffer1.Height:=mainform.Paintbox1.Height;
      Puffer2.Height:=mainform.Paintbox1.Height;
      RedrawPictures:=true;
    end else if ((Puffer1.Height<Paintbox1.Height) or (Puffer2.Height<Paintbox1.Height)) then
    begin
      Puffer1.Height:=Paintbox1.Height;
      Puffer2.Height:=Paintbox1.Height;
      RedrawPictures:=true;
    end else
    begin
      if ((Puffer1.Height<>Paintbox1.Height) or (Puffer2.Height<>Paintbox1.Height)) and
        ((Puffer1.Height>mainform.Paintbox1.Width) and (Puffer2.Height>mainform.Paintbox1.Width)) then
      begin
        Puffer1.Height:=Paintbox1.Height;
        Puffer2.Height:=Paintbox1.Height;
        RedrawPictures:=true;
      end;
    end;

    if RedrawPictures then
    begin
      RedrawPictures:=false;
      Puffer1.Canvas.Pen.Style:=psClear;
      Puffer1.Canvas.Brush.Color:=clWhite;
      Puffer1.Canvas.Brush.Style:=bsSolid;
      Puffer1.Canvas.Rectangle(0,0,Puffer1.Width, Puffer1.Height);

      // Hintergrundbild kopieren
      Puffer1.Canvas.Draw(0,0,grafischebuehnenansicht.Stage.Picture.Graphic);

      // Gerätebilder zeichnen
      DrawGrafischeBuehnenansichtDevices(Puffer1.Canvas);
    end;

    Puffer1.Canvas.Pen.Style:=psClear;
    BitBlt(Puffer2.Canvas.Handle,0,0,Puffer1.Width,Puffer1.Height,Puffer1.Canvas.Handle,0,0,SRCCOPY);

    // Optionen und Anzeigen zeichnen
    DrawGrafischeBuehnenansicht(Puffer2.Canvas);

    if ShowAuswahl then
    begin
      Puffer2.Canvas.Pen.mode:=pmNotXor;
      Puffer2.Canvas.Pen.style:=psDot;
      Puffer2.Canvas.Brush.Style:=bsclear;
      Puffer2.Canvas.Rectangle(Auswahl);
    end;

    if grafischebuehnenansicht.Showing then
    begin
      BitBlt(Paintbox1.Canvas.Handle,0,0,Paintbox1.Width,Paintbox1.Height,Puffer2.Canvas.Handle,0,0,SRCCOPY);
    end;
    
    if nodecontrolform.Showing then
    begin
      nodecontrolform.StageviewBuffer.Width:=Puffer2.Width;
      nodecontrolform.StageviewBuffer.Height:=Puffer2.Height;
      BitBlt(nodecontrolform.StageviewBuffer.Canvas.Handle,0,0,nodecontrolform.StageviewBuffer.Width,nodecontrolform.StageviewBuffer.Height,Puffer2.Canvas.Handle,0,0,SRCCOPY);
    end;

    if (mainform.pagecontrol1.ActivePageIndex=0) and (mainform.panel1.Visible) then
    begin
      BitBlt(mainform._MainformPreBuffer.Canvas.Handle,0,0,mainform.Paintbox1.Width,mainform.Paintbox1.Height,Puffer2.Canvas.Handle,0,0,SRCCOPY);
      mainform.RefreshMainformScreen:=true;
    end;

    if SaveToBMP then
    begin
      SaveToBMP:=false;
      SaveStageviewToFile('jpg');

{
      image1:=TImage.Create(Self);
	    image1.Width:=paintbox1.Width;
      image1.Height:=paintbox1.Height;

      BitBlt(image1.Canvas.Handle, 0, 0, image1.width, image1.height, Puffer2.Canvas.Handle, 0, 0 , SRCCOPY);

      try
//        image1.Picture.SaveToFile(mainform.userdirectory+'stageview.bmp');
        mainform.SavePng(image1.Picture.Bitmap, mainform.userdirectory+'stageview.png');
        mainform.SaveJpg(image1.Picture.Bitmap, mainform.userdirectory+'stageview.jpg');
      except
      end;
      image1.Free;
}
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Tgrafischebuehnenansicht.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Tgrafischebuehnenansicht.Button3Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  geraetesteuerung.show;
end;

procedure Tgrafischebuehnenansicht.AddBtnClick(Sender: TObject);
begin
  BankSelect.ItemIndex:=BankSelect.Items.Add(_('Bühne ')+inttostr(BankSelect.Items.Count+1));
  BankCopy.Items.Add(_('Bühne ')+inttostr(BankSelect.Items.Count));

  setlength(mainform.buehnenansicht_background, length(mainform.buehnenansicht_background)+1);
  mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
    mainform.BankSelect.Items:=BankSelect.Items;
    mainform.BankSelect.Itemindex:=BankSelect.Itemindex;
    mainform.BankCopy.Items:=BankCopy.Items;
    mainform.BankCopy.Itemindex:=BankCopy.Itemindex;

  BankSelectSelect(nil);
end;

procedure Tgrafischebuehnenansicht.ChangeBtnClick(Sender: TObject);
var
  text:string;
  i:integer;
begin
  text:=InputBox(_('Neue Bühnenbezeichnung'),_('Bitte geben Sie eine neue Bezeichnung für diese Bühne:'),BankSelect.Items[BankSelect.ItemIndex]);
  i:=BankSelect.ItemIndex;
  BankSelect.Items[i]:=text;
  BankCopy.Items[i]:=text;
end;

procedure Tgrafischebuehnenansicht.DeleteBtnClick(Sender: TObject);
var
  i,j:integer;
begin
  if BankSelect.ItemIndex>0 then
  begin
    for i:=BankSelect.ItemIndex to BankSelect.Items.Count-2 do
    begin
      BankSelect.Items[i]:=BankSelect.Items[i+1];
      BankCopy.Items[i]:=BankCopy.Items[i+1];
      mainform.buehnenansicht_background[i]:=mainform.buehnenansicht_background[i+1];
    end;

    BankSelect.Items.Delete(BankSelect.Items.Count-1);
    BankCopy.Items.Delete(BankCopy.Items.Count-1);
    BankSelect.ItemIndex:=BankSelect.Items.Count-1;
    setlength(mainform.buehnenansicht_background, length(mainform.buehnenansicht_background)-1);
    mainform.BankSelect.Items:=BankSelect.Items;
    mainform.BankSelect.Itemindex:=BankSelect.Itemindex;
    mainform.BankCopy.Items:=BankCopy.Items;
    mainform.BankCopy.Itemindex:=BankCopy.Itemindex;

    for i:=0 to length(mainform.devices)-1 do
    for j:=0 to length(mainform.devices[i].bank)-1 do
    begin
      if mainform.devices[i].bank[j]>bankselect.Items.Count-1 then
        mainform.devices[i].bank[j]:=bankselect.items.count-1;
    end;
    for i:=0 to length(mainform.buehnenansichtdevices)-1 do
    begin
      if mainform.buehnenansichtdevices[i].bank>bankselect.Items.Count-1 then
        mainform.buehnenansichtdevices[i].bank:=bankselect.items.count-1;
    end;
  end;
  BankSelectSelect(nil);
end;

procedure Tgrafischebuehnenansicht.BankSelectSelect(Sender: TObject);
var
  i:integer;
begin
  // Zunächst alle Geräte deselektieren
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    mainform.buehnenansichtdevices[i].selected:=false;
  end;

  if mainform.buehnenansicht_background[BankSelect.ItemIndex]<>'' then
  begin
    if pos('\ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex])>0 then
      mainform.buehnenansicht_background[BankSelect.ItemIndex]:=mainform.userdirectory+copy(mainform.buehnenansicht_background[BankSelect.ItemIndex],pos('ProjectTemp\',mainform.buehnenansicht_background[BankSelect.ItemIndex]),length(mainform.buehnenansicht_background[BankSelect.ItemIndex]));

    if FileExists(mainform.buehnenansicht_background[BankSelect.ItemIndex]) then
      Stage.Picture.LoadFromFile(mainform.buehnenansicht_background[BankSelect.ItemIndex])
    else if FileExists(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
      Stage.Picture.LoadFromFile(filepath+ExtractFileName(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
    else if FileExists(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex])) then
      Stage.Picture.LoadFromFile(mainform.SearchFileBeneathProject(mainform.buehnenansicht_background[BankSelect.ItemIndex]))
    else
    begin
      stage.Picture:=Referenzbild2.Picture;
      mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
    end;
  end else
  begin
    stage.Picture:=Referenzbild2.Picture;
    mainform.buehnenansicht_background[BankSelect.ItemIndex]:='';
  end;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.BankCopySelect(Sender: TObject);
var
  i,j,m:integer;
begin
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if (mainform.buehnenansichtdevices[i].selected) then
    begin
      mainform.buehnenansichtdevices[i].bank:=BankCopy.ItemIndex;
    end;
  end;

  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].bank)-1 do
  begin
    if mainform.devices[i].MatrixDeviceLevel>0 then
    begin
      if (mainform.devices[i].selected[j]) then
      begin
        mainform.devices[i].bank[j]:=BankCopy.ItemIndex;

        for m:=0 to length(mainform.devices)-1 do
        begin
          if (mainform.devices[m].MatrixDeviceLevel>0) and IsEqualGUID(mainform.devices[i].MatrixMainDeviceID, mainform.devices[m].MatrixMainDeviceID) then
          begin
            mainform.devices[m].bank[j]:=BankCopy.ItemIndex;
          end;
        end;
      end;
    end else
    begin
      if (mainform.devices[i].selected[j]) then
      begin
        mainform.devices[i].bank[j]:=BankCopy.ItemIndex;
      end;
    end;
  end;
  BankSelectSelect(nil);

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.CheckBox3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          LReg.WriteBool('Lock icons',checkbox3.checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  mainform.CheckBox3.Checked:=Checkbox3.Checked;
end;

procedure Tgrafischebuehnenansicht.NureinGertefensterffneneinaus1Click(
  Sender: TObject);
begin
  Checkbox5.Checked:=not Checkbox5.Checked;
  CheckBox5MouseUp(Sender,mbLeft,[ssLeft],0,0);
end;

procedure Tgrafischebuehnenansicht.Iconsverriegeln1Click(Sender: TObject);
begin
  Checkbox3.Checked:=not Checkbox3.Checked;
  CheckBox3MouseUp(Sender,mbLeft,[ssLeft],0,0);
end;

procedure Tgrafischebuehnenansicht.NeuesGerthinzufgen2Click(
  Sender: TObject);
var
  i, oldlength:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  oldlength:=length(mainform.devices);

  geraetesteuerung.Gerthinzufgen1Click(grafischebuehnenansicht);

  for i:=length(mainform.devices)-1 downto oldlength do
  begin
    mainform.Devices[i].ShowInStageview:=true;
  end;
end;

function Tgrafischebuehnenansicht.ClickOnDevice(X,Y:integer; ssShift: TShiftState):integer;
var
  i,j,position:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;
  for i:=0 to length(mainform.devices)-1 do
	for j:=0 to length(mainform.devices[i].bank)-1 do
  begin
    if mainform.devices[i].ShowInStageview then
    if mainform.devices[i].bank[j]=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
  		if (mainform.devices[i].left[j]<=X)
      and ((mainform.devices[i].left[j]+mainform.devices[i].picturesize)>=X)
      and (mainform.devices[i].Top[j]<=Y)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize)>=Y) then
      begin
        position:=i;

        if ssShift=[ssLeft] then
          if mainform.Devices[position].MatrixDeviceLevel=2 then
            position:=Geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.Devices[position].MatrixMainDeviceID);

        MouseOnDeviceCopy:=j;
      end;
    end;
  end;

  MouseOnDevice:=position;
  MouseOnDeviceHover:=position;
  if (MouseOnDevice>-1) and (MouseOnDevice<length(mainform.devices)) then
    MouseOnDeviceID:=mainform.devices[MouseOnDevice].ID;
  LastDevice:=position;
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnBuehnenansichtDevice(X,Y:integer):integer;
var
  i,position:integer;
begin
  position:=-1;
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if mainform.buehnenansichtdevices[i].bank=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
  		if (mainform.buehnenansichtdevices[i].left<=X)
      and ((mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize)>=X)
      and (mainform.buehnenansichtdevices[i].Top<=Y)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize)>=Y) then
      begin
        position:=i;
      end;
    end;
  end;

  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnBuehnenansichtdevice:=position;
  LastBuehnenansichtDevice:=position;
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnLabel(X,Y:integer):integer;
var
  i,j,position:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;
  if checkbox1.checked then
  for i:=0 to length(mainform.devices)-1 do
	for j:=0 to length(mainform.devices[i].bank)-1 do
  begin
    if mainform.devices[i].ShowInStageview then
    if mainform.devices[i].bank[j]=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
  		if (mainform.devices[i].left[j]<=X)
      and ((mainform.devices[i].left[j]+mainform.devices[i].picturesize)>=X)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize+1+8)<=Y)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize+9+8+8)>=Y) then
      begin
        position:=i;

        if mainform.Devices[position].MatrixDeviceLevel=2 then
          position:=Geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.Devices[position].MatrixMainDeviceID);

        MouseOnDeviceCopy:=j;
      end;
    end;
  end;

  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnLabel:=position;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnProgress(X,Y:integer):integer;
var
  i,j,position:integer;
  offset:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;

  if checkbox1.checked then
    offset:=11+8
  else
    offset:=2+8;

  for i:=0 to length(mainform.devices)-1 do
	for j:=0 to length(mainform.devices[i].bank)-1 do
  begin
    if mainform.devices[i].ShowInStageview then
    if mainform.devices[i].bank[j]=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
   		if (mainform.devices[i].left[j]<=X)
      and ((mainform.devices[i].left[j]+mainform.devices[i].picturesize)>=X)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize+2+offset)<=Y)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize+9+offset)>=Y) then
      begin
        position:=i;
        MouseOnDeviceCopy:=j;
      end;
    end;
  end;

  MouseOnBuehnenansichtdevice:=-1;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=position;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnBuehnenansichtProgress(X,Y:integer):integer;
var
  i,position:integer;
  offset:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;

  offset:=2+8;

  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if mainform.buehnenansichtdevices[i].bank=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
   		if (mainform.buehnenansichtdevices[i].left<=X)
      and ((mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize)>=X)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize+2+offset)<=Y)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize+9+offset)>=Y) then
      begin
        position:=i;
      end;
    end;
  end;

  LastBuehnenansichtDevice:=position;
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtProgress:=position;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnNumber(X,Y:integer):integer;
var
  i,j,position:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;

  for i:=0 to length(mainform.devices)-1 do
	for j:=0 to length(mainform.devices[i].bank)-1 do
  begin
    if mainform.devices[i].ShowInStageview then
    if mainform.devices[i].bank[j]=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
  		if (mainform.devices[i].left[j]<=X)
      and ((mainform.devices[i].left[j]+10)>=X)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize+8-8)<=Y)
      and ((mainform.devices[i].Top[j]+mainform.devices[i].picturesize+8)>=Y) then
      begin
        position:=i;

        if mainform.Devices[position].MatrixDeviceLevel=2 then
          position:=Geraetesteuerung.GetDevicePositionInDeviceArray(@mainform.Devices[position].MatrixMainDeviceID);

        MouseOnDeviceCopy:=j;
      end;
    end;
  end;

  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnLabel:=-1;
  MouseOnNumber:=position;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnBuehnenansichtNumber(X,Y:integer):integer;
var
  i,position:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;

  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if mainform.buehnenansichtdevices[i].bank=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
  		if (mainform.buehnenansichtdevices[i].left<=X)
      and ((mainform.buehnenansichtdevices[i].left+10)>=X)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize-5+8)<=Y)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize+8)>=Y) then
      begin
        position:=i;
      end;
    end;
  end;

  LastBuehnenansichtDevice:=position;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=position;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnBuehnenansichtLabel(X,Y:integer):integer;
var
  i,position:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;

  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if mainform.buehnenansichtdevices[i].bank=BankSelect.Itemindex then
    begin
      // Auswahl.Left=Links Auswahl.Right=Rechts                                                                      Auswahl.Top=Oben Auswahl.Bottom=Unten
  		if (mainform.buehnenansichtdevices[i].left<=X)
      and ((mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize)>=X)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize+1+8+8)<=Y)
      and ((mainform.buehnenansichtdevices[i].Top+mainform.buehnenansichtdevices[i].picturesize+9+8+8+8)>=Y) then  //TODO
      begin
        position:=i;
      end;
    end;
  end;

  LastBuehnenansichtDevice:=position;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=position;
  MouseOnBuehnenansichtColor:=-1;

  result:=position;
end;

function Tgrafischebuehnenansicht.ClickOnBuehnenansichtColor(X,Y:integer):integer;
var
  i,position:integer;
begin
  position:=-1;
  MouseOnDeviceCopy:=-1;

  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if mainform.buehnenansichtdevices[i].bank=BankSelect.Itemindex then
    begin
  		if ((mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-10)<=X)
      and ((mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize)>=X)
      and ((mainform.buehnenansichtdevices[i].Top)<=Y)
      and ((mainform.buehnenansichtdevices[i].Top+10)>=Y) then
      begin
        position:=i;
      end;
    end;
  end;

  LastBuehnenansichtDevice:=position;
  MouseOnDevice:=-1;
  MouseOnDeviceHover:=-1;
  MouseOnDeviceID:=StringToGUID('{00000000-0000-0000-0000-000000000000}');
  MouseOnLabel:=-1;
  MouseOnNumber:=-1;
  MouseOnProgress:=-1;
  MouseOnBuehnenansichtdevice:=-1;
  MouseOnBuehnenansichtProgress:=-1;
  MouseOnBuehnenansichtNumber:=-1;
  MouseOnBuehnenansichtLabel:=-1;
  MouseOnBuehnenansichtColor:=position;

  result:=position;
end;

procedure TGrafischeBuehnenansicht.DrawGrafischeBuehnenansichtDevices(_Buffer:TCanvas);
var
  i,j,k,l:integer;
  rect:TRect;
  gobolevel:byte;
begin
  // Canvas bereit machen
  _Buffer.Pen.mode:=pmCopy;
  _Buffer.Pen.style:=psClear;
  _Buffer.Brush.Color:=clWhite;
  _Buffer.Brush.Style:=bsSolid;

  // Geräte zeichnen
  for i:=0 to length(mainform.devices)-1 do
  if mainform.devices[i].ShowInStageview then
  begin
    for j:=0 to length(mainform.devices[i].top)-1 do
    begin
      if mainform.devices[i].bank[j]<>bankselect.itemindex then continue;

      rect.Top:=mainform.devices[i].top[j];
      rect.Left:=mainform.devices[i].left[j];

      // Bild zeichnen
      rect.right:=mainform.devices[i].left[j]+mainform.devices[i].picturesize;
      rect.Bottom:=mainform.devices[i].top[j]+mainform.devices[i].picturesize;

      case mainform.devices[i].picturesize of
        0..48: // 32px
        begin
          pngobject.Assign(mainform.devicepictures32.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[i].bildadresse)].PngImage);
        end;
        49..80: // 64px
        begin
          pngobject.Assign(mainform.devicepictures64.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[i].bildadresse)].PngImage);
        end;
        81..111: // 96px
        begin
          pngobject.Assign(mainform.devicepictures96.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[i].bildadresse)].PngImage);
        end;
        112..255: // 128px
        begin
          pngobject.Assign(mainform.devicepictures128.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[i].bildadresse)].PngImage);
        end;
      end;
      if not ProcessorFriendlyRedraw then
      begin
        if not ((mainform.devices[i].picturesize=32) or
          (mainform.devices[i].picturesize=64) or
          (mainform.devices[i].picturesize=96) or
          (mainform.devices[i].picturesize=128)) then
          SmoothResize(pngobject, mainform.devices[i].picturesize, mainform.devices[i].picturesize);
        if mainform.devices[i].pictureangle>0 then
          SmoothRotate(pngobject, mainform.devices[i].pictureangle);
      end;
      pngobject.Draw(_Buffer, rect);

      // Gobos 1 darstellen
      if mainform.devices[i].hasGobo then
      begin
        gobolevel:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO1');
        for k:=0 to length(mainform.devices[i].gobos)-1 do
        begin
          if (gobolevel>=mainform.devices[i].gobolevels[k]) and (gobolevel<=mainform.devices[i].goboendlevels[k]) then
          begin
            for l:=0 to mainform.GoboPictures.Items.Count-1 do
            begin
              if mainform.GoboPictures.Items.Items[l].Name=mainform.devices[i].gobos[k] then
              begin
                rect.left:=mainform.devices[i].left[j]+mainform.devices[i].picturesize;
                rect.top:=mainform.devices[i].top[j];
                rect.right:=mainform.devices[i].left[j]+mainform.devices[i].picturesize+32;
                rect.Bottom:=mainform.devices[i].top[j]+32;
                mainform.GoboPictures.Items.Items[l].PngImage.Draw(_Buffer, rect);
                break;
              end;
            end;
            break;
          end;
        end;
      end;
      // Gobos 2 darstellen
      if mainform.devices[i].hasGobo2 then
      begin
        gobolevel:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO2');
        for k:=0 to length(mainform.devices[i].gobos2)-1 do
        begin
          if (gobolevel>=mainform.devices[i].gobolevels2[k]) and (gobolevel<=mainform.devices[i].goboendlevels2[k]) then
          begin
            for l:=0 to mainform.GoboPictures.Items.Count-1 do
            begin
              if mainform.GoboPictures.Items.Items[l].Name=mainform.devices[i].gobos2[k] then
              begin
                if mainform.devices[i].hasGobo then
                begin
                  rect.left:=mainform.devices[i].left[j]+mainform.devices[i].picturesize+32;
                  rect.top:=mainform.devices[i].top[j];
                  rect.right:=mainform.devices[i].left[j]+mainform.devices[i].picturesize+64;
                  rect.Bottom:=mainform.devices[i].top[j]+32;
                end else
                begin
                  rect.left:=mainform.devices[i].left[j]+mainform.devices[i].picturesize;
                  rect.top:=mainform.devices[i].top[j];
                  rect.right:=mainform.devices[i].left[j]+mainform.devices[i].picturesize+32;
                  rect.Bottom:=mainform.devices[i].top[j]+32;
                end;
                mainform.GoboPictures.Items.Items[l].PngImage.Draw(_Buffer, rect);
                break;
              end;
            end;
            break;
          end;
        end;
      end;
    end;
  end;

  ////////////////////////////////////////////////////////////////////////////

  // Kanalicons zeichnen
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  if mainform.buehnenansichtdevices[i].bank=BankSelect.ItemIndex then
  begin
    rect.Top:=mainform.buehnenansichtdevices[i].top;
    rect.Left:=mainform.buehnenansichtdevices[i].left;

    // Bild zeichnen
    rect.right:=mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize;
    rect.Bottom:=mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize;

    case mainform.buehnenansichtdevices[i].picturesize of
      0..48:
      begin
        pngobject.Assign(mainform.devicepictures32.Items.Items[geraetesteuerung.GetImageIndex(mainform.buehnenansichtdevices[i].picture)].PngImage);
      end;
      49..80:
      begin
        pngobject.Assign(mainform.devicepictures64.Items.Items[geraetesteuerung.GetImageIndex(mainform.buehnenansichtdevices[i].picture)].PngImage);
      end;
      81..111:
      begin
        pngobject.Assign(mainform.devicepictures96.Items.Items[geraetesteuerung.GetImageIndex(mainform.buehnenansichtdevices[i].picture)].PngImage);
      end;
      112..255:
      begin
        pngobject.Assign(mainform.devicepictures128.Items.Items[geraetesteuerung.GetImageIndex(mainform.buehnenansichtdevices[i].picture)].PngImage);
      end;
    end;
    if not ProcessorFriendlyRedraw then
    begin
      if not ((mainform.buehnenansichtdevices[i].picturesize=32) or
        (mainform.buehnenansichtdevices[i].picturesize=64) or
        (mainform.buehnenansichtdevices[i].picturesize=96) or
        (mainform.buehnenansichtdevices[i].picturesize=128)) then
        SmoothResize(pngobject, mainform.buehnenansichtdevices[i].picturesize, mainform.buehnenansichtdevices[i].picturesize);
      if mainform.buehnenansichtdevices[i].pictureangle>0 then
        SmoothRotate(pngobject, mainform.buehnenansichtdevices[i].pictureangle);
    end;
    pngobject.Draw(_Buffer, rect);
  end;
end;

procedure TGrafischeBuehnenansicht.DrawGrafischeBuehnenansicht(_Buffer:TCanvas);
var
	R,G,B,R2,G2,B2,R3,G3,B3:byte;
  RGB, RGB3, shuttervalue:integer;
  //RGB2:integer;
  AmberR,AmberG,AmberB,Amber,White,UV:byte;

//  AmberRs,AmberGs,AmberBs,Ambers:double;
//  AmberRGratio:single;

  Farbradwert,Farbradwert2:byte;
  Dimmerwert:byte;
  i,j,l:integer;
  topval,leftval:integer;
  rect:TRect;
  offset:integer;
  NewStartaddress, UniverseNr:integer;
begin
  // Canvas bereit machen
  _Buffer.Pen.mode:=pmCopy;
  _Buffer.Pen.style:=psClear;
  _Buffer.Brush.Color:=clWhite;
  _Buffer.Brush.Style:=bsSolid;

  // Geräteeigenschaften zeichnen
  for i:=0 to length(mainform.devices)-1 do
  if mainform.devices[i].ShowInStageview then
  begin
    for j:=0 to length(mainform.devices[i].top)-1 do
    begin
      if mainform.devices[i].bank[j]<>bankselect.itemindex then continue;

      rect.Top:=mainform.devices[i].top[j];
      rect.Left:=mainform.devices[i].left[j];
      rect.right:=mainform.devices[i].left[j]+mainform.devices[i].picturesize;
      rect.Bottom:=mainform.devices[i].top[j]+mainform.devices[i].picturesize;

      _Buffer.Font.Size:=7;
      _Buffer.Font.Name:='Arial';
      _Buffer.Brush.Style:=bsClear;

      // Startadresse anzeigen
      _Buffer.Brush.Style:=bsSolid;
      if mainform.devices[i].selected[j] then
        _Buffer.Font.Color:=clRed
      else
        _Buffer.Font.Color:=clBlack;
      if mainform.DeviceSelected[i] then
        _Buffer.Brush.Color:=clSkyBlue
      else
        _Buffer.Brush.Color:=clWhite;
      if IsEqualGUID(mainform.devices[i].ID, MouseOnDeviceID) then
        _Buffer.Brush.Color:=$008080FF;

      if mainform.devices[i].Startaddress<=512 then
      begin
        _Buffer.TextOut(mainform.devices[i].left[j],mainform.devices[i].top[j]+mainform.devices[i].picturesize,inttostr(mainform.devices[i].Startaddress));
      end else
      begin
        UniverseNr:=trunc(mainform.devices[i].Startaddress/512);
        NewStartaddress:=mainform.devices[i].Startaddress-(UniverseNr*512);
        _Buffer.TextOut(mainform.devices[i].left[j],mainform.devices[i].top[j]+mainform.devices[i].picturesize,'U'+inttostr(UniverseNr+1)+': '+inttostr(NewStartaddress)+' ('+inttostr(mainform.devices[i].Startaddress)+')');
      end;

      // Namen anzeigen
      if checkbox1.checked then
        _Buffer.TextOut(mainform.devices[i].left[j],mainform.devices[i].top[j]+mainform.devices[i].picturesize+9,mainform.devices[i].Name);
      _Buffer.Font.Color:=clBlack;

      // Dimmerbar anzeigen
      if mainform.Devices[i].hasDimmer then
      begin
        Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);
        if checkbox1.checked then
          offset:=11+8
        else
          offset:=2+8;

        // Umrandung zeichnen
        _Buffer.Brush.Color:=ClMedGray;
        _Buffer.Pen.Style:=psSolid;
        _Buffer.Rectangle(mainform.devices[i].left[j], mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+2,mainform.devices[i].left[j]+mainform.devices[i].picturesize,mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+9);

        // Hintergrund zeichnen
        _Buffer.Pen.Color:=clSilver;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.Pen.Color:=clMedGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.Pen.Color:=clGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.Pen.Color:=clGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.Pen.Color:=clMedGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);

        // Füllung zeichnen
        _Buffer.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,128);//$00FFFFFF;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,192);//$00A4FFA4;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,255);//$0000FF00;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,96);//$0000B000;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.Pen.Color:=GetColor3(0,128,255,Dimmerwert,clRed,clYellow,clLime,64);//$00008000;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);

        // Wert in Prozent anzeigen
        _Buffer.Font.Size:=7;
        _Buffer.Font.Name:='Arial';
        _Buffer.Brush.Style:=bsClear;
        _Buffer.Pen.Style:=psClear;
        _Buffer.Font.Color:=clBlack;
        _Buffer.TextOut(mainform.devices[i].left[j]+mainform.devices[i].picturesize+3, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset, mainform.levelstr(Dimmerwert));
      end else if mainform.Devices[i].hasFog then
      begin
        // Nebelbar anzeigen
        Dimmerwert:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'fog');
        if checkbox1.checked then
          offset:=11+8
        else
          offset:=2+8;

        // Umrandung zeichnen
        _Buffer.Brush.Color:=ClMedGray;
        _Buffer.Pen.Style:=psSolid;
        _Buffer.Rectangle(mainform.devices[i].left[j], mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+2,mainform.devices[i].left[j]+mainform.devices[i].picturesize,mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+9);

        // Hintergrund zeichnen
        _Buffer.Pen.Color:=clSilver;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.Pen.Color:=clMedGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.Pen.Color:=clGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.Pen.Color:=clGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.Pen.Color:=clMedGray;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-1), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);

        // Füllung zeichnen
        _Buffer.Pen.Color:=$00FFFFFF;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+3);
        _Buffer.Pen.Color:=$00E0E0E0;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+4);
        _Buffer.Pen.Color:=$00FFFFFF;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+5);
        _Buffer.Pen.Color:=$00B0B0B0;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+6);
        _Buffer.Pen.Color:=$00808080;
        _Buffer.MoveTo(mainform.devices[i].left[j]+1, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);
        _Buffer.LineTo(round(mainform.devices[i].left[j]+1+((mainform.devices[i].picturesize-2)*(Dimmerwert/255))), mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset+7);

        // Wert in Prozent anzeigen
        _Buffer.Font.Size:=7;
        _Buffer.Font.Name:='Arial';
        _Buffer.Brush.Style:=bsClear;
        _Buffer.Pen.Style:=psClear;
        _Buffer.Font.Color:=clBlack;
        _Buffer.TextOut(mainform.devices[i].left[j]+mainform.devices[i].picturesize+3, mainform.devices[i].top[j]+mainform.devices[i].picturesize+offset , mainform.levelstr(Dimmerwert));
      end;

      // Farbball anzeigen
      _Buffer.Brush.Style:=bsSolid;
      _Buffer.Pen.Style:=psSolid;
      _Buffer.Pen.Color:=clBlack;
      if mainform.devices[i].hasRGB then
      begin
        // RGB
        if mainform.devices[i].hasDIMMER then
        begin
          Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);
          AmberR:=geraetesteuerung.get_channel(mainform.devices[i].ID,'R');
          AmberG:=geraetesteuerung.get_channel(mainform.devices[i].ID,'G');
          AmberB:=geraetesteuerung.get_channel(mainform.devices[i].ID,'B');
          Amber:=geraetesteuerung.get_channel(mainform.devices[i].ID,'A');
          White:=geraetesteuerung.get_channel(mainform.devices[i].ID,'W');
          UV:=geraetesteuerung.get_channel(mainform.devices[i].ID,'UV');

          if mainform.devices[i].hasAmber then
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[i].AmberRatioR, mainform.devices[i].AmberRatioG, mainform.devices[i].AmberMixingCompensateRG, mainform.devices[i].AmberMixingCompensateBlue, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
          end else
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
//            _Buffer.Brush.Color:=RGB2TColor(round(AmberR*(Dimmerwert/255)),round(AmberG*(Dimmerwert/255)),round(AmberB*(Dimmerwert/255)));
          end;
        end else
        begin
          // kein Dimmer im Gerät
          AmberR:=geraetesteuerung.get_channel(mainform.devices[i].ID,'R');
          AmberG:=geraetesteuerung.get_channel(mainform.devices[i].ID,'G');
          AmberB:=geraetesteuerung.get_channel(mainform.devices[i].ID,'B');
          Amber:=geraetesteuerung.get_channel(mainform.devices[i].ID,'A');
          White:=geraetesteuerung.get_channel(mainform.devices[i].ID,'W');
          UV:=geraetesteuerung.get_channel(mainform.devices[i].ID,'UV');

          if mainform.devices[i].hasAmber then
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[i].AmberRatioR, mainform.devices[i].AmberRatioG, mainform.devices[i].AmberMixingCompensateRG, mainform.devices[i].AmberMixingCompensateBlue, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(R, G, B);
          end else
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(R, G, B);
          end;
        end;
      end else if mainform.devices[i].hasCMY then
      begin
        // CMY
        if mainform.devices[i].hasDIMMER then
        begin
          Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);
          AmberR:=255-geraetesteuerung.get_channel(mainform.devices[i].ID,'C');
          AmberG:=255-geraetesteuerung.get_channel(mainform.devices[i].ID,'M');
          AmberB:=255-geraetesteuerung.get_channel(mainform.devices[i].ID,'Y');
          Amber:=geraetesteuerung.get_channel(mainform.devices[i].ID,'A');
          White:=geraetesteuerung.get_channel(mainform.devices[i].ID,'W');
          UV:=geraetesteuerung.get_channel(mainform.devices[i].ID,'UV');

          if mainform.devices[i].hasAmber then
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[i].AmberRatioR, mainform.devices[i].AmberRatioG, mainform.devices[i].AmberMixingCompensateRG, mainform.devices[i].AmberMixingCompensateBlue, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
          end else
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(round(R*(Dimmerwert/255)),round(G*(Dimmerwert/255)),round(B*(Dimmerwert/255)));
//            _Buffer.Brush.Color:=RGB2TColor(round(AmberR*(Dimmerwert/255)),round(AmberG*(Dimmerwert/255)),round(AmberB*(Dimmerwert/255)));
          end;
        end else
        begin
          // kein Dimmer im Gerät
          AmberR:=255-geraetesteuerung.get_channel(mainform.devices[i].ID,'C');
          AmberG:=255-geraetesteuerung.get_channel(mainform.devices[i].ID,'M');
          AmberB:=255-geraetesteuerung.get_channel(mainform.devices[i].ID,'Y');
          Amber:=geraetesteuerung.get_channel(mainform.devices[i].ID,'A');
          White:=geraetesteuerung.get_channel(mainform.devices[i].ID,'W');
          UV:=geraetesteuerung.get_channel(mainform.devices[i].ID,'UV');

          if mainform.devices[i].hasAmber then
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, Amber, mainform.devices[i].AmberRatioR, mainform.devices[i].AmberRatioG, mainform.devices[i].AmberMixingCompensateRG, mainform.devices[i].AmberMixingCompensateBlue, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(R, G, B);
          end else
          begin
            geraetesteuerung.ConvertRGBAWUVtoRGB(AmberR, AmberG, AmberB, 0, 128, 128, false, false, White, UV, R, G, B);
            _Buffer.Brush.Color:=RGB2TColor(R, G, B);
//            _Buffer.Brush.Color:=RGB2TColor(AmberR,AmberG,AmberB);
          end;
        end;
      end else if (mainform.devices[i].hasColor or mainform.devices[i].hasColor2) then
      begin
        if (mainform.devices[i].hasColor and mainform.devices[i].hasColor2) then
        begin
          // COLOR1 & COLOR2
          Farbradwert:=geraetesteuerung.get_channel(mainform.devices[i].ID,'COLOR1');
          Farbradwert2:=geraetesteuerung.get_channel(mainform.devices[i].ID,'COLOR2');

          for l:=0 to length(mainform.devices[i].colorlevels)-1 do
          begin
            if (mainform.devices[i].colorlevels[l]<=Farbradwert) and
              (mainform.devices[i].colorendlevels[l]>=Farbradwert) then
            begin
//              RGB:=ColorToRGB(mainform.devices[i].colors[l]);
              TColor2RGB(mainform.devices[i].colors[l], R, G, B);
              break;
            end;
          end;
          for l:=0 to length(mainform.devices[i].colorlevels2)-1 do
          begin
            if (mainform.devices[i].colorlevels2[l]<=Farbradwert2) and
              (mainform.devices[i].colorendlevels2[l]>=Farbradwert2) then
            begin
//              RGB2:=ColorToRGB(mainform.devices[i].colors2[l]);
              TColor2RGB(mainform.devices[i].colors2[l], R2, G2, B2);
              break;
            end;
          end;

          R3:=round((R/255)*(R2/255)*255);
          G3:=round((G/255)*(G2/255)*255);
          B3:=round((B/255)*(B2/255)*255);
          RGB3:=RGB2TColor(R3,G3,B3);

          if mainform.devices[i].hasDimmer then
          begin
            Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);

            _Buffer.Brush.Color:=RGB2TColor(round(R3*Dimmerwert/255),round(G3*Dimmerwert/255),round(B3*Dimmerwert/255));
          end else
          begin
            _Buffer.Brush.Color:=RGB3;
          end;
        end else if mainform.devices[i].hasColor then
        begin
          // COLOR1
          Farbradwert:=geraetesteuerung.get_channel(mainform.devices[i].ID,'COLOR1');

          for l:=0 to length(mainform.devices[i].colorlevels)-1 do
          begin
            if (mainform.devices[i].colorlevels[l]<=Farbradwert) and
              (mainform.devices[i].colorendlevels[l]>=Farbradwert) then
            begin
              if mainform.devices[i].hasDimmer then
              begin
                Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);

                RGB:=ColorToRGB(mainform.devices[i].colors[l]);
                R:=round(GetRValue(RGB)*Dimmerwert / 255);
                G:=round(GetGValue(RGB)*Dimmerwert / 255);
                B:=round(GetBValue(RGB)*Dimmerwert / 255);

                _Buffer.Brush.Color:=RGB2TColor(R,G,B);
              end else
              begin
                _Buffer.Brush.Color:=mainform.devices[i].colors[l];
              end;
              break;
            end;
          end;
        end else
        begin
          // COLOR2
          Farbradwert2:=geraetesteuerung.get_channel(mainform.devices[i].ID,'COLOR2');

          for l:=0 to length(mainform.devices[i].colorlevels2)-1 do
          begin
            if (mainform.devices[i].colorlevels2[l]<=Farbradwert2) and
              (mainform.devices[i].colorendlevels2[l]>=Farbradwert2) then
            begin
              if mainform.devices[i].hasDimmer then
              begin
                Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);

                RGB:=ColorToRGB(mainform.devices[i].colors2[l]);
                R:=round(GetRValue(RGB)*Dimmerwert / 255);
                G:=round(GetGValue(RGB)*Dimmerwert / 255);
                B:=round(GetBValue(RGB)*Dimmerwert / 255);

                _Buffer.Brush.Color:=RGB2TColor(R,G,B);
              end else
              begin
                _Buffer.Brush.Color:=mainform.devices[i].colors2[l];
              end;
              break;
            end;
          end;
        end;
      end else
      begin
        // nur Farbfilter
        if mainform.Devices[i].hasDimmer then
        begin
          Dimmerwert:=geraetesteuerung.get_dimmer(mainform.devices[i].ID);
          RGB:=ColorToRGB(mainform.devices[i].color);
          R:=round(GetRValue(RGB)*Dimmerwert / 255);
          G:=round(GetGValue(RGB)*Dimmerwert / 255);
          B:=round(GetBValue(RGB)*Dimmerwert / 255);
          _Buffer.Brush.Color:=RGB2TColor(R,G,B);
        end else if mainform.Devices[i].hasFog then
        begin
          Dimmerwert:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'FOG');
          R:=Dimmerwert;
          G:=Dimmerwert;
          B:=Dimmerwert;
          _Buffer.Brush.Color:=RGB2TColor(R,G,B);
        end else
        begin
          _Buffer.Brush.Color:=mainform.devices[i].color;
          _Buffer.Pen.Color:=clBlack;
        end;
      end;
      if mainform.Devices[i].hasShutter then
      begin
        shuttervalue:=geraetesteuerung.get_shutter(mainform.devices[i].ID);
        if (shuttervalue=0) or (shuttervalue=255) then
        begin
          TColor2RGB(_Buffer.Brush.Color, R, G, B);
          R:=round(R*shuttervalue/255);
          G:=round(G*shuttervalue/255);
          B:=round(B*shuttervalue/255);
          _Buffer.Brush.Color:=RGB2TColor(R, G, B);
        end;
      end;

      if mainform.devices[i].hasPANTILT then
      begin
        if not Checkbox2.Checked then
        begin
    	    Topval:=round(mainform.devices[i].Top[j]+(mainform.devices[i].picturesize*(geraetesteuerung.get_channel(mainform.devices[i].ID, 'TILT')/255))-(mainform.devices[i].picturesize/3.2/2));
    	    Leftval:=round(mainform.devices[i].left[j]+mainform.devices[i].picturesize-(mainform.devices[i].picturesize*((255-geraetesteuerung.get_channel(mainform.devices[i].ID, 'PAN'))/255))+(mainform.devices[i].picturesize/3.2/2));
          _Buffer.Ellipse(Leftval-round(mainform.devices[i].picturesize/3.2),
                                Topval,
                                Leftval,
                                Topval+round(mainform.devices[i].picturesize/3.2));
        end else
        begin
          _Buffer.Ellipse(mainform.devices[i].left[j],
                                mainform.devices[i].top[j],
                                mainform.devices[i].left[j]+mainform.devices[i].picturesize,
                                mainform.devices[i].top[j]+mainform.devices[i].picturesize);
        end;
      end else
      begin
        if not Checkbox2.Checked then
        begin
          _Buffer.Ellipse(mainform.devices[i].left[j]+mainform.devices[i].picturesize-round(mainform.devices[i].picturesize/3.4),
                                mainform.devices[i].top[j],
                                mainform.devices[i].left[j]+mainform.devices[i].picturesize,
                                mainform.devices[i].top[j]+round(mainform.devices[i].picturesize/3.4));
        end else
        begin
          _Buffer.Ellipse(mainform.devices[i].left[j],
                                mainform.devices[i].top[j],
                                mainform.devices[i].left[j]+mainform.devices[i].picturesize,
                                mainform.devices[i].top[j]+mainform.devices[i].picturesize);
        end;
      end;
    end;
  end;

  ////////////////////////////////////////////////////////////////////////////

  // Kanalicons zeichnen
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  if mainform.buehnenansichtdevices[i].bank=BankSelect.ItemIndex then
  begin
    rect.Top:=mainform.buehnenansichtdevices[i].top;
    rect.Left:=mainform.buehnenansichtdevices[i].left;
    rect.right:=mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize;
    rect.Bottom:=mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize;

    // Startadresse anzeigen
    _Buffer.Font.Size:=7;
    _Buffer.Font.Name:='Arial';
    _Buffer.Brush.Style:=bsSolid;
    _Buffer.Brush.Color:=clWhite;
    if mainform.buehnenansichtdevices[i].selected then
      _Buffer.Font.Color:=clRed
    else
      _Buffer.Font.Color:=clBlack;
    _Buffer.Pen.Style:=psClear;
    _Buffer.TextOut(mainform.buehnenansichtdevices[i].left,mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize,inttostr(mainform.buehnenansichtdevices[i].channel));

    // Dimmerbar anzeigen
    Dimmerwert:=mainform.channel_value[mainform.buehnenansichtdevices[i].channel];
    offset:=2+8;

    // Umrandung zeichnen
    _Buffer.Brush.Color:=ClMedGray;
    _Buffer.Pen.Style:=psSolid;
    _Buffer.Rectangle(mainform.buehnenansichtdevices[i].left, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+2,mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize,mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+9);

    // Hintergrund zeichnen
    _Buffer.Pen.Color:=clSilver;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+3);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-1), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+3);
    _Buffer.Pen.Color:=clMedGray;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+4);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-1), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+4);
    _Buffer.Pen.Color:=clGray;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+5);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-1), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+5);
    _Buffer.Pen.Color:=clGray;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+6);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-1), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+6);
    _Buffer.Pen.Color:=clMedGray;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+7);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-1), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+7);

    // Füllung zeichnen
    _Buffer.Pen.Color:=$00FFFFFF;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+3);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+1+((mainform.buehnenansichtdevices[i].picturesize-2)*(Dimmerwert/255))), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+3);
    _Buffer.Pen.Color:=$00A4FFA4;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+4);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+1+((mainform.buehnenansichtdevices[i].picturesize-2)*(Dimmerwert/255))), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+4);
    _Buffer.Pen.Color:=$0000FF00;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+5);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+1+((mainform.buehnenansichtdevices[i].picturesize-2)*(Dimmerwert/255))), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+5);
    _Buffer.Pen.Color:=$0000B000;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+6);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+1+((mainform.buehnenansichtdevices[i].picturesize-2)*(Dimmerwert/255))), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+6);
    _Buffer.Pen.Color:=$00008000;
    _Buffer.MoveTo(mainform.buehnenansichtdevices[i].left+1, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+7);
    _Buffer.LineTo(round(mainform.buehnenansichtdevices[i].left+1+((mainform.buehnenansichtdevices[i].picturesize-2)*(Dimmerwert/255))), mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset+7);

    // Wert in Prozent anzeigen
    _Buffer.Font.Size:=7;
    _Buffer.Font.Name:='Arial';
    _Buffer.Brush.Style:=bsClear;
    _Buffer.Pen.Style:=psClear;
    if mainform.buehnenansichtdevices[i].selected then
      _Buffer.Font.Color:=clRed
    else
      _Buffer.Font.Color:=clBlack;
    _Buffer.TextOut(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize+3, mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset, mainform.levelstr(Dimmerwert));

    offset:=2+8+2+8;
    // Namen anzeigen
    if checkbox1.checked then
      _Buffer.TextOut(mainform.buehnenansichtdevices[i].left,mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize+offset,mainform.data.Names[mainform.buehnenansichtdevices[i].channel]);
    _Buffer.Font.Color:=clBlack;

{
    // Grün
    _Buffer.Pen.Color:=$00FFFFFF;
    _Buffer.Pen.Color:=$00A4FFA4;
    _Buffer.Pen.Color:=$0000FF00;
    _Buffer.Pen.Color:=$0000B000;
    _Buffer.Pen.Color:=$00008000;

    //Blau
    _Buffer.Pen.Color:=clNavy;
    _Buffer.Pen.Color:=clBlue;
    _Buffer.Pen.Color:=clBlue;
    _Buffer.Pen.Color:=$00FF4242;
    _Buffer.Pen.Color:=clNavy;
}
    // Farbball anzeigen
    _Buffer.Brush.Style:=bsSolid;
    _Buffer.Pen.Style:=psSolid;
    _Buffer.Pen.Color:=clBlack;
    // nur Farbfilter
    Dimmerwert:=mainform.channel_value[mainform.buehnenansichtdevices[i].channel];
    RGB:=ColorToRGB(mainform.buehnenansichtdevices[i].color);
    R:=round(GetRValue(RGB)*Dimmerwert / 255);
    G:=round(GetGValue(RGB)*Dimmerwert / 255);
    B:=round(GetBValue(RGB)*Dimmerwert / 255);
    _Buffer.Brush.Color:=RGB2TColor(R,G,B);

    if not Checkbox2.Checked then
    begin
      _Buffer.Ellipse(mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize-round(mainform.buehnenansichtdevices[i].picturesize/(mainform.buehnenansichtdevices[i].picturesize/10)),
                            mainform.buehnenansichtdevices[i].top,
                            mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize,
                            mainform.buehnenansichtdevices[i].top+round(mainform.buehnenansichtdevices[i].picturesize/(mainform.buehnenansichtdevices[i].picturesize/10)));
    end else
    begin
      _Buffer.Ellipse(mainform.buehnenansichtdevices[i].left,
                            mainform.buehnenansichtdevices[i].top,
                            mainform.buehnenansichtdevices[i].left+mainform.buehnenansichtdevices[i].picturesize,
                            mainform.buehnenansichtdevices[i].top+mainform.buehnenansichtdevices[i].picturesize);
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.colorbox1ColorChange(Sender: TObject);
begin
  if (LastBuehnenansichtdevice<=length(mainform.buehnenansichtdevices)-1) and (LastBuehnenansichtdevice>-1) then
  begin
   	mainform.buehnenansichtdevices[LastBuehnenansichtdevice].color:=colorbox1.SelectedColor;
  end;
  colorbox1.Visible:=false;
end;

procedure Tgrafischebuehnenansicht.Button4Click(Sender: TObject);
var
  i,j,raster:integer;
  toppos, leftpos:single;
begin
  raster:=32;
  case Combobox1.ItemIndex of
    0: raster:=8;
    1: raster:=16;
    2: raster:=24;
    3: raster:=32;
    4: raster:=48;
    5: raster:=64;
  end;

  for i:=0 to length(mainform.devices)-1 do
  begin
    for j:=0 to length(mainform.devices[i].top)-1 do
    begin
      toppos:=mainform.devices[i].top[j]/raster;
      leftpos:=mainform.devices[i].left[j]/raster;

      if frac(toppos)<0.5 then
        toppos:=trunc(toppos)
      else
        toppos:=trunc(toppos)+1;

      if frac(leftpos)<0.5 then
        leftpos:=trunc(leftpos)
      else
        leftpos:=trunc(leftpos)+1;

      mainform.devices[i].top[j]:=round(toppos*raster);
      mainform.devices[i].left[j]:=round(leftpos*raster);
    end;
  end;
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    toppos:=mainform.buehnenansichtdevices[i].top/raster;
    leftpos:=mainform.buehnenansichtdevices[i].left/raster;

    if frac(toppos)<0.5 then
      toppos:=trunc(toppos)
    else
      toppos:=trunc(toppos)+1;

    if frac(leftpos)<0.5 then
      leftpos:=trunc(leftpos)
    else
      leftpos:=trunc(leftpos)+1;

    mainform.buehnenansichtdevices[i].top:=round(toppos*raster);
    mainform.buehnenansichtdevices[i].left:=round(leftpos*raster);
  end;
  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.CheckBox4MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          LReg.WriteBool('AutoGrid',checkbox4.checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tgrafischebuehnenansicht.Paintbox1Paint(Sender: TObject);
begin
  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.GetSelectedIcons(X,Y:integer);
var
  i,j,LeftSided:integer;
begin
  setlength(SelectedIcons, 0);
  
  // zunächste alle Selektierten Geräte herausfinden
  for i:=0 to length(mainform.buehnenansichtdevices)-1 do
  begin
    if (mainform.buehnenansichtdevices[i].selected) then
    begin
      setlength(SelectedIcons, length(SelectedIcons)+1);

      SelectedIcons[length(SelectedIcons)-1].IsBuehnenansichtdevice:=true;
      SelectedIcons[length(SelectedIcons)-1].DeviceNumber:=i;
      SelectedIcons[length(SelectedIcons)-1].X:=mainform.buehnenansichtdevices[i].left;
      SelectedIcons[length(SelectedIcons)-1].Y:=mainform.buehnenansichtdevices[i].top;
      SelectedIcons[length(SelectedIcons)-1].PictureSize:=mainform.buehnenansichtdevices[i].picturesize;
      SelectedIcons[length(SelectedIcons)-1].Channel:=mainform.buehnenansichtdevices[i].channel;

      if (SelectedIcons[length(SelectedIcons)-1].X-X)<0 then LeftSided:=-1 else LeftSided:=1;
      SelectedIcons[length(SelectedIcons)-1].Distance:=LeftSided*sqrt(power((SelectedIcons[length(SelectedIcons)-1].X-X),2)+power((SelectedIcons[length(SelectedIcons)-1].Y-Y),2))+(random(1000)/1000000000);
    end;
  end;
  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].selected)-1 do
  begin
    if (mainform.devices[i].selected[j]) then
    begin
      setlength(SelectedIcons, length(SelectedIcons)+1);
      SelectedIcons[length(SelectedIcons)-1].IsBuehnenansichtdevice:=false;
      SelectedIcons[length(SelectedIcons)-1].DeviceNumber:=i;
      SelectedIcons[length(SelectedIcons)-1].X:=mainform.devices[i].left[j];
      SelectedIcons[length(SelectedIcons)-1].Y:=mainform.devices[i].top[j];
      SelectedIcons[length(SelectedIcons)-1].Copy:=j;
      SelectedIcons[length(SelectedIcons)-1].PictureSize:=mainform.devices[i].picturesize;
      SelectedIcons[length(SelectedIcons)-1].Channel:=mainform.devices[i].Startaddress;

      if (SelectedIcons[length(SelectedIcons)-1].X-X)<0 then LeftSided:=-1 else LeftSided:=1;
      SelectedIcons[length(SelectedIcons)-1].Distance:=LeftSided*sqrt(power((SelectedIcons[length(SelectedIcons)-1].X-X),2)+power((SelectedIcons[length(SelectedIcons)-1].Y-Y),2))+(random(1000)/1000000000);
    end;
  end;

  // Reihenfolge der Geräte bestimmen
  if length(SelectedIcons)>1 then
    SortSelectedIcons(0, length(SelectedIcons)-1);

  // Distanz von Pixel auf Icons umrechnen
  for i:=0 to length(SelectedIcons)-1 do
    SelectedIcons[i].Distance:=round((SelectedIcons[i].Distance+round(SelectedIcons[i].picturesize/2))/32);
end;

procedure Tgrafischebuehnenansicht.ArrangeIcons(X1, Y1, X2, Y2:Integer);
var
  i, Nulldurchgang:integer;
  DistanceX, DistanceY:integer;
  DistanceBetweenEachIconX, DistanceBetweenEachIconY:double;
begin
  // Nulldurchgang zwische L und R finden
  Nulldurchgang:=0;
  for i:=0 to length(SelectedIcons)-1 do
  begin
    if SelectedIcons[i].Distance>=0 then
    begin
      Nulldurchgang:=i;
      break;
    end;
  end;

  if Nulldurchgang=0 then
  begin
    // Icon links außen wird verschoben
    // X1, X1=Startpunkt   X2, Y2=Endpunkt
    // Abstand in Pixeln zwischen beiden Punkten

    DistanceX:=SelectedIcons[length(SelectedIcons)-1].X-X2;
    DistanceY:=SelectedIcons[length(SelectedIcons)-1].Y-Y2;

    DistanceBetweenEachIconX:=DistanceX / (length(SelectedIcons)-1);
    DistanceBetweenEachIconY:=DistanceY / (length(SelectedIcons)-1);

    // nun alle X- und Y-Positionswerte rechts von Icon zuweisen
    for i:=0 to length(SelectedIcons)-1 do
    begin
      if SelectedIcons[i].IsBuehnenansichtdevice then
      begin
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].left:=round(   SelectedIcons[length(SelectedIcons)-1].X-(DistanceBetweenEachIconX*(length(SelectedIcons)-1-i))   -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].top:= round(   SelectedIcons[length(SelectedIcons)-1].Y-(DistanceBetweenEachIconY*(length(SelectedIcons)-1-i))   -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
      end else
      begin
        mainform.devices[SelectedIcons[i].DeviceNumber].left[SelectedIcons[i].Copy]:=round(   SelectedIcons[length(SelectedIcons)-1].X-(DistanceBetweenEachIconX*(length(SelectedIcons)-1-i))  -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
        mainform.devices[SelectedIcons[i].DeviceNumber].top[SelectedIcons[i].Copy]:= round(   SelectedIcons[length(SelectedIcons)-1].Y-(DistanceBetweenEachIconY*(length(SelectedIcons)-1-i))  -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
      end;
    end;
  end else if Nulldurchgang=(length(SelectedIcons)-1) then
  begin
    // Icon rechts außen wird verschoben
    // X1, X1=Startpunkt   X2, Y2=Endpunkt
    // Abstand in Pixeln zwischen beiden Punkten

    DistanceX:=SelectedIcons[0].X-X2;
    DistanceY:=SelectedIcons[0].Y-Y2;

    DistanceBetweenEachIconX:=DistanceX / (length(SelectedIcons)-1);
    DistanceBetweenEachIconY:=DistanceY / (length(SelectedIcons)-1);

    // nun alle X- und Y-Positionswerte rechts von Icon zuweisen
    for i:=0 to length(SelectedIcons)-1 do
    begin
      if SelectedIcons[i].IsBuehnenansichtdevice then
      begin
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].left:=round(   SelectedIcons[0].X-(DistanceBetweenEachIconX*i)  -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))    );
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].top:= round(   SelectedIcons[0].Y-(DistanceBetweenEachIconY*i)  -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))    );
      end else
      begin
        mainform.devices[SelectedIcons[i].DeviceNumber].left[SelectedIcons[i].Copy]:=round(   SelectedIcons[0].X-(DistanceBetweenEachIconX*i)   -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))   );
        mainform.devices[SelectedIcons[i].DeviceNumber].top[SelectedIcons[i].Copy]:= round(   SelectedIcons[0].Y-(DistanceBetweenEachIconY*i)   -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))   );
      end;
    end;
  end else
  begin
    // Icon in der Mitte wird verschoben

    // Abstand in Pixeln zwischen beiden Punkten
    DistanceX:=SelectedIcons[length(SelectedIcons)-1].X-X2;
    DistanceY:=SelectedIcons[length(SelectedIcons)-1].Y-Y2;

    DistanceBetweenEachIconX:=DistanceX / (length(SelectedIcons)-1-Nulldurchgang);
    DistanceBetweenEachIconY:=DistanceY / (length(SelectedIcons)-1-Nulldurchgang);

    // nun alle X- und Y-Positionswerte rechts von Icon zuweisen
    for i:=Nulldurchgang to length(SelectedIcons)-1 do
    begin
      if SelectedIcons[i].IsBuehnenansichtdevice then
      begin
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].left:=round(   SelectedIcons[length(SelectedIcons)-1].X-(DistanceBetweenEachIconX*(length(SelectedIcons)-1-i))   -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].top:= round(   SelectedIcons[length(SelectedIcons)-1].Y-(DistanceBetweenEachIconY*(length(SelectedIcons)-1-i))   -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
      end else
      begin
        mainform.devices[SelectedIcons[i].DeviceNumber].left[SelectedIcons[i].Copy]:=round(   SelectedIcons[length(SelectedIcons)-1].X-(DistanceBetweenEachIconX*(length(SelectedIcons)-1-i))  -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
        mainform.devices[SelectedIcons[i].DeviceNumber].top[SelectedIcons[i].Copy]:= round(   SelectedIcons[length(SelectedIcons)-1].Y-(DistanceBetweenEachIconY*(length(SelectedIcons)-1-i))  -round(SelectedIcons[i].picturesize/2)*(length(SelectedIcons)-1-i)/(length(SelectedIcons)-1)    );
      end;
    end;

    // Abstand in Pixeln zwischen beiden Punkten
    DistanceX:=SelectedIcons[0].X-X2;
    DistanceY:=SelectedIcons[0].Y-Y2;

    DistanceBetweenEachIconX:=DistanceX / (Nulldurchgang);
    DistanceBetweenEachIconY:=DistanceY / (Nulldurchgang);

    // nun alle X- und Y-Positionswerte rechts von Icon zuweisen
    for i:=0 to Nulldurchgang do
    begin
      if SelectedIcons[i].IsBuehnenansichtdevice then
      begin
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].left:=round(   SelectedIcons[0].X-(DistanceBetweenEachIconX*i)  -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))    );
        mainform.buehnenansichtdevices[SelectedIcons[i].DeviceNumber].top:= round(   SelectedIcons[0].Y-(DistanceBetweenEachIconY*i)  -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))    );
      end else
      begin
        mainform.devices[SelectedIcons[i].DeviceNumber].left[SelectedIcons[i].Copy]:=round(   SelectedIcons[0].X-(DistanceBetweenEachIconX*i)   -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))   );
        mainform.devices[SelectedIcons[i].DeviceNumber].top[SelectedIcons[i].Copy]:= round(   SelectedIcons[0].Y-(DistanceBetweenEachIconY*i)   -round(SelectedIcons[i].picturesize/2)*(i/(length(SelectedIcons)-1))   );
      end;
    end;
  end;
end;

procedure Tgrafischebuehnenansicht.SortSelectedIcons(Low, High:Integer);
var
  Lo, Hi: Integer;
  Pivot:double;
begin
  Lo := Low;
  Hi := High;

  Pivot := SelectedIcons[(Lo + Hi) div 2].Distance;
  repeat
    while SelectedIcons[Lo].Distance < Pivot do Inc(Lo) ;
    while SelectedIcons[Hi].Distance > Pivot do Dec(Hi) ;
    if Lo <= Hi then
    begin

      // in folgenden drei Zeilen Arrayinhalte kopieren
      setlength(SelectedIcons,length(SelectedIcons)+1);

      SelectedIcons[length(SelectedIcons)-1].IsBuehnenansichtdevice:=SelectedIcons[Lo].IsBuehnenansichtdevice;
      SelectedIcons[length(SelectedIcons)-1].DeviceNumber:=SelectedIcons[Lo].DeviceNumber;
      SelectedIcons[length(SelectedIcons)-1].X:=SelectedIcons[Lo].X;
      SelectedIcons[length(SelectedIcons)-1].Y:=SelectedIcons[Lo].Y;
      SelectedIcons[length(SelectedIcons)-1].Copy:=SelectedIcons[Lo].Copy;
      SelectedIcons[length(SelectedIcons)-1].PictureSize:=SelectedIcons[Lo].PictureSize;
      SelectedIcons[length(SelectedIcons)-1].Channel:=SelectedIcons[Lo].Channel;
      SelectedIcons[length(SelectedIcons)-1].Distance:=SelectedIcons[Lo].Distance;

      SelectedIcons[Lo].IsBuehnenansichtdevice:=SelectedIcons[Hi].IsBuehnenansichtdevice;
      SelectedIcons[Lo].DeviceNumber:=SelectedIcons[Hi].DeviceNumber;
      SelectedIcons[Lo].X:=SelectedIcons[Hi].X;
      SelectedIcons[Lo].Y:=SelectedIcons[Hi].Y;
      SelectedIcons[Lo].Copy:=SelectedIcons[Hi].Copy;
      SelectedIcons[Lo].PictureSize:=SelectedIcons[Hi].PictureSize;
      SelectedIcons[Lo].Channel:=SelectedIcons[Hi].Channel;
      SelectedIcons[Lo].Distance:=SelectedIcons[Hi].Distance;

      SelectedIcons[Hi].IsBuehnenansichtdevice:=SelectedIcons[length(SelectedIcons)-1].IsBuehnenansichtdevice;
      SelectedIcons[Hi].DeviceNumber:=SelectedIcons[length(SelectedIcons)-1].DeviceNumber;
      SelectedIcons[Hi].X:=SelectedIcons[length(SelectedIcons)-1].X;
      SelectedIcons[Hi].Y:=SelectedIcons[length(SelectedIcons)-1].Y;
      SelectedIcons[Hi].Copy:=SelectedIcons[length(SelectedIcons)-1].Copy;
      SelectedIcons[Hi].PictureSize:=SelectedIcons[length(SelectedIcons)-1].PictureSize;
      SelectedIcons[Hi].Channel:=SelectedIcons[length(SelectedIcons)-1].Channel;
      SelectedIcons[Hi].Distance:=SelectedIcons[length(SelectedIcons)-1].Distance;

      setlength(SelectedIcons,length(SelectedIcons)-1);

      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > Low then SortSelectedIcons(Low, Hi);
  if Lo < High then SortSelectedIcons(Lo, High);
end;

procedure Tgrafischebuehnenansicht.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if MouseOnDeviceHover>-1 then
    geraetesteuerung.set_dimmer(MouseOnDeviceID, geraetesteuerung.get_dimmer(MouseOnDeviceID)+1, 0, 0);
end;

procedure Tgrafischebuehnenansicht.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if MouseOnDeviceHover>-1 then
    geraetesteuerung.set_dimmer(MouseOnDeviceID, geraetesteuerung.get_dimmer(MouseOnDeviceID)-1, 0, 0);
end;

procedure Tgrafischebuehnenansicht.CheckBox6MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mainform.CheckBox6.Checked:=Checkbox6.Checked;
end;

procedure Tgrafischebuehnenansicht.SaveStageviewToFile(Filetype: string);
var
  image1:TImage;
begin
  image1:=TImage.Create(Self);
  image1.Width:=paintbox1.Width;
  image1.Height:=paintbox1.Height;

  BitBlt(image1.Canvas.Handle, 0, 0, image1.width, image1.height, Puffer2.Canvas.Handle, 0, 0 , SRCCOPY);

  if Filetype='bmp' then
    image1.Picture.SaveToFile(mainform.userdirectory+'stageview.bmp')
  else if Filetype='png' then
    mainform.SavePng(image1.Picture.Bitmap, mainform.userdirectory+'stageview.png')
  else
    mainform.SaveJpg(image1.Picture.Bitmap, mainform.userdirectory+'stageview.jpg');

  image1.Free;
end;

procedure Tgrafischebuehnenansicht.FormDestroy(Sender: TObject);
begin
  pngobject.free;
end;

procedure Tgrafischebuehnenansicht.SmoothResize(apng:tpngobject; NuWidth,NuHeight:integer);
var
  xscale, yscale         : Single;
  sfrom_y, sfrom_x       : Single;
  ifrom_y, ifrom_x       : Integer;
  to_y, to_x             : Integer;
  weight_x, weight_y     : array[0..1] of Single;
  weight                 : Single;
  new_red, new_green     : Integer;
  new_blue, new_alpha    : Integer;
  new_colortype          : Integer;
  total_red, total_green : Single;
  total_blue, total_alpha: Single;
  IsAlpha                : Boolean;
  ix, iy                 : Integer;
  bTmp : TPNGObject;
  sli, slo : pRGBLine;
  ali, alo: pbytearray;
begin
  new_alpha:=0;
  if not (apng.Header.ColorType in [COLOR_RGBALPHA, COLOR_RGB]) then
    raise Exception.Create('Only COLOR_RGBALPHA and COLOR_RGB formats' +
    ' are supported');
  IsAlpha := apng.Header.ColorType in [COLOR_RGBALPHA];
  if IsAlpha then new_colortype := COLOR_RGBALPHA else
    new_colortype := COLOR_RGB;
  bTmp := Tpngobject.CreateBlank(new_colortype, 8, NuWidth, NuHeight);
  xscale := bTmp.Width / (apng.Width-1);
  yscale := bTmp.Height / (apng.Height-1);
  for to_y := 0 to bTmp.Height-1 do begin
    sfrom_y := to_y / yscale;
    ifrom_y := Trunc(sfrom_y);
    weight_y[1] := sfrom_y - ifrom_y;
    weight_y[0] := 1 - weight_y[1];
    for to_x := 0 to bTmp.Width-1 do begin
      sfrom_x := to_x / xscale;
      ifrom_x := Trunc(sfrom_x);
      weight_x[1] := sfrom_x - ifrom_x;
      weight_x[0] := 1 - weight_x[1];

      total_red   := 0.0;
      total_green := 0.0;
      total_blue  := 0.0;
      total_alpha  := 0.0;
      for ix := 0 to 1 do begin
        for iy := 0 to 1 do begin
          sli := apng.Scanline[ifrom_y + iy];
          if IsAlpha then ali := apng.AlphaScanline[ifrom_y + iy];
          new_red := sli[ifrom_x + ix].rgbtRed;
          new_green := sli[ifrom_x + ix].rgbtGreen;
          new_blue := sli[ifrom_x + ix].rgbtBlue;
          if IsAlpha then new_alpha := ali[ifrom_x + ix];
          weight := weight_x[ix] * weight_y[iy];
          total_red   := total_red   + new_red   * weight;
          total_green := total_green + new_green * weight;
          total_blue  := total_blue  + new_blue  * weight;
          if IsAlpha then total_alpha  := total_alpha  + new_alpha  * weight;
        end;
      end;
      slo := bTmp.ScanLine[to_y];
      if IsAlpha then alo := bTmp.AlphaScanLine[to_y];
      slo[to_x].rgbtRed := Round(total_red);
      slo[to_x].rgbtGreen := Round(total_green);
      slo[to_x].rgbtBlue := Round(total_blue);
      if isAlpha then alo[to_x] := Round(total_alpha);
    end;
  end;
  apng.Assign(bTmp);
  bTmp.Free;
end;

procedure Tgrafischebuehnenansicht.TrackBar2Change(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(mainform.devices)-1 do
  for j:=0 to length(mainform.devices[i].selected)-1 do
  begin
    if (mainform.devices[i].selected[j]) then
      mainform.devices[i].pictureangle:=Trackbar2.Position;
  end;

  RedrawPictures:=true;
end;

procedure Tgrafischebuehnenansicht.ComboBox1Select(Sender: TObject);
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
        if not LReg.KeyExists('Buehnenansicht') then
	        LReg.CreateKey('Buehnenansicht');
	      if LReg.OpenKey('Buehnenansicht',true) then
	      begin
          LReg.WriteInteger('GridSize',Combobox1.ItemIndex);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

end.
