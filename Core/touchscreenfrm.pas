unit touchscreenfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, PngBitBtn, ExtCtrls, PngImageList,
  HSLRingPicker, ComCtrls, TiledImage, gnugettext, Math, Mask, JvExMask,
  JvSpin, Registry, GR32;

type
  TSlidergroup = record
    Panel:TPanel;
    Slider:TTrackbar;
    Lbl:TLabel;
    Channel:String;
  end;
  Tdevicegroup = record
    Panel:TPanel;
    Lbl:TLabel;
    DeviceID:TGUID;
    DeviceVendor:String;
    DeviceName:String;
    Shape:TShape;
    slidergroup:array of Tslidergroup;
  end;

  Ttouchscreenform = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    pnglist: TPngImageCollection;
    devicebtn: TPngBitBtn;
    groupbtn: TPngBitBtn;
    blackoutbtn: TPngBitBtn;
    freezebtn: TPngBitBtn;
    Panel3: TPanel;
    Panel5: TPanel;
    nextgobo1btn: TPngBitBtn;
    prevgobo1btn: TPngBitBtn;
    nextgobo2btn: TPngBitBtn;
    prevgobo2btn: TPngBitBtn;
    nextcolor1btn: TPngBitBtn;
    prevcolor1btn: TPngBitBtn;
    nextcolor2btn: TPngBitBtn;
    prevcolor2btn: TPngBitBtn;
    rgbbtn: TPngBitBtn;
    dimmerbtn: TPngBitBtn;
    pantiltbtn: TPngBitBtn;
    switchmonitorbtn: TButton;
    gobobtn: TPngBitBtn;
    Timer1: TTimer;
    zoomvalue: TJvSpinEdit;
    zoomlbl: TLabel;
    downbtn: TPngBitBtn;
    upbtn: TPngBitBtn;
    fadenkreuz: TPanel;
    TiledImage2: TTiledImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    VertTrack: TTrackBar;
    HorTrack: TTrackBar;
    colorpicker: THSLRingPicker;
    dimmerpanel: TPanel;
    plusbtn: TButton;
    strobo100btn: TPngBitBtn;
    strobo75btn: TPngBitBtn;
    strobo25btn: TPngBitBtn;
    strobo0btn: TPngBitBtn;
    minusbtn: TButton;
    dimmerslider: TTrackBar;
    PaintBox1: TPaintBox;
    goborot1slider: TTrackBar;
    Button1: TButton;
    Button2: TButton;
    goborot2slider: TTrackBar;
    strobeslider: TTrackBar;
    strobeminus: TButton;
    strobeplus: TButton;
    Label1: TLabel;
    Label2: TLabel;
    prismarotplus: TButton;
    prismaslider: TTrackBar;
    prismarotminus: TButton;
    Label3: TLabel;
    irisplus: TButton;
    irisslider: TTrackBar;
    irisminus: TButton;
    Label4: TLabel;
    prismatriple: TButton;
    prismasingle: TButton;
    Shape1: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    prismarotstop: TButton;
    shutteropenbtn: TButton;
    shutterclosebtn: TButton;
    strobo85btn: TPngBitBtn;
    Shape6: TShape;
    Label8: TLabel;
    fokusplus: TButton;
    fokusslider: TTrackBar;
    fokusminus: TButton;
    channelbox: TScrollBox;
    chanbtn: TButton;
    channelboxtimer: TTimer;
    chantypebtn: TButton;
    SumChanbtn: TButton;
    colorsliderpanel: TPanel;
    Panel7: TPanel;
    amberslider: TTrackBar;
    whiteslider: TTrackBar;
    uvslider: TTrackBar;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure rgbbtnClick(Sender: TObject);
    procedure pantiltbtnClick(Sender: TObject);
    procedure dimmerbtnClick(Sender: TObject);
    procedure devicebtnClick(Sender: TObject);
    procedure groupbtnClick(Sender: TObject);
    procedure switchmonitorbtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure gobobtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TiledImage2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TiledImage2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TiledImage2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VertTrackChange(Sender: TObject);
    procedure HorTrackChange(Sender: TObject);
    procedure dimmersliderChange(Sender: TObject);
    procedure shutteropenbtnClick(Sender: TObject);
    procedure shutterclosebtnClick(Sender: TObject);
    procedure strobo100btnClick(Sender: TObject);
    procedure strobo75btnClick(Sender: TObject);
    procedure strobo25btnClick(Sender: TObject);
    procedure strobo0btnClick(Sender: TObject);
    procedure blackoutbtnClick(Sender: TObject);
    procedure freezebtnClick(Sender: TObject);
    procedure nextgobo1btnClick(Sender: TObject);
    procedure nextcolor1btnClick(Sender: TObject);
    procedure nextcolor2btnClick(Sender: TObject);
    procedure nextgobo2btnClick(Sender: TObject);
    procedure prevgobo1btnClick(Sender: TObject);
    procedure prevgobo2btnClick(Sender: TObject);
    procedure prevcolor1btnClick(Sender: TObject);
    procedure prevcolor2btnClick(Sender: TObject);
    procedure colorpickerChange(Sender: TObject);
    procedure PositionXYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PositionXYMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure upbtnClick(Sender: TObject);
    procedure downbtnClick(Sender: TObject);
    procedure goborot1sliderChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure goborot2sliderChange(Sender: TObject);
    procedure strobesliderChange(Sender: TObject);
    procedure irissliderChange(Sender: TObject);
    procedure prismasliderChange(Sender: TObject);
    procedure prismasingleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure strobo85btnClick(Sender: TObject);
    procedure minusbtnClick(Sender: TObject);
    procedure irisminusClick(Sender: TObject);
    procedure prismarotminusClick(Sender: TObject);
    procedure prismasingleClick(Sender: TObject);
    procedure prismatripleClick(Sender: TObject);
    procedure prismarotstopClick(Sender: TObject);
    procedure prismarotplusClick(Sender: TObject);
    procedure strobeplusClick(Sender: TObject);
    procedure strobeminusClick(Sender: TObject);
    procedure irisplusClick(Sender: TObject);
    procedure plusbtnClick(Sender: TObject);
    procedure fokussliderChange(Sender: TObject);
    procedure fokusplusClick(Sender: TObject);
    procedure fokusminusClick(Sender: TObject);
    procedure chanbtnClick(Sender: TObject);
    procedure channelboxtimerTimer(Sender: TObject);
    procedure chantypebtnClick(Sender: TObject);
    procedure SumChanbtnClick(Sender: TObject);
    procedure ambersliderChange(Sender: TObject);
    procedure whitesliderChange(Sender: TObject);
    procedure uvsliderChange(Sender: TObject);
  private
    { Private-Deklarationen }
    LastPosX, LastPosY:integer;
    DoFinePos:boolean;
    timer:byte;
    usemhcontrol:boolean;
    rgn:HRGN;
    GoboButtons:array of string;
    GoboOffset:integer;
    _Buffer:TBitmap32;
    buttonstyle:byte;
    BtnDown:TPoint;
    OverBtn:TPoint;
    PaintboxType:byte;
    maxbtns, yoffset, buttonheight, buttonwidth, maxlines:integer;
    ChannelSliderMode:byte;

    devicegroup:array of Tdevicegroup;
    slidergroup:array of Tslidergroup;

    procedure SetPanTilt;
    procedure DrawGradientH(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
    function UseGradient(Farbe: TColor; Direction: byte):TColor;
    procedure ChanSliderChange(Sender: TObject);
  public
    { Public-Deklarationen }
    procedure RefreshGoboList;
    procedure RefreshChannelbox;
    procedure RedrawPanel;
  end;

procedure LockWindow(const Handle: HWND);
procedure UnLockWindow(const Handle: HWND);

var
  touchscreenform: Ttouchscreenform;

implementation

uses PCDIMMER, geraetesteuerungfrm, sidebarfrm, buehnenansicht;

{$R *.dfm}

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

procedure Ttouchscreenform.rgbbtnClick(Sender: TObject);
begin
  paintbox1.Visible:=false;
  colorpicker.visible:=true;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=false;
  channelboxtimer.enabled:=channelbox.visible;

{
  colorpicker.Height:=panel4.Height;
  colorpicker.Width:=colorpicker.Height;
  colorpicker.Top:=0;
  colorpicker.Left:=(panel4.Width div 2)-(colorpicker.Width div 2);
}
end;

procedure Ttouchscreenform.pantiltbtnClick(Sender: TObject);
begin
  paintbox1.Visible:=false;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=true;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=true;
  zoomvalue.Visible:=true;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=false;
  channelboxtimer.enabled:=channelbox.visible;

  fadenkreuz.Height:=panel4.Height-16;
  fadenkreuz.Width:=fadenkreuz.Height;
  fadenkreuz.Top:=8;
  fadenkreuz.Left:=(panel4.Width div 2)-(fadenkreuz.Width div 2);

  bevel1.Height:=fadenkreuz.Height;
  bevel1.Left:=fadenkreuz.Width div 2;
  bevel2.Width:=fadenkreuz.Width;
  bevel2.Top:=fadenkreuz.Height div 2;

  PositionXY.Width:=fadenkreuz.Width div 15;
  PositionXY.Height:=PositionXY.Width;
  PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);
end;

procedure Ttouchscreenform.dimmerbtnClick(Sender: TObject);
begin
  paintbox1.Visible:=false;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=true;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=false;
  channelboxtimer.enabled:=channelbox.visible;
end;

procedure Ttouchscreenform.devicebtnClick(Sender: TObject);
begin
  yoffset:=0;
  PaintboxType:=0;

  paintbox1.Visible:=true;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=true;
  downbtn.Visible:=true;
  maxbtns:=trunc(paintbox1.width/buttonwidth)-1;
  channelbox.visible:=false;
  channelboxtimer.enabled:=channelbox.visible;

  Timer1Timer(nil);
end;

procedure Ttouchscreenform.groupbtnClick(Sender: TObject);
begin
  yoffset:=0;
  PaintboxType:=1;

  paintbox1.Visible:=true;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=true;
  downbtn.Visible:=true;
  maxbtns:=trunc(paintbox1.width/buttonwidth)-1;
  channelbox.visible:=false;
  channelboxtimer.enabled:=channelbox.visible;

  Timer1Timer(nil);
end;

procedure Ttouchscreenform.switchmonitorbtnClick(Sender: TObject);
var
  newmonitor:integer;
begin
  if touchscreenform.Monitor.MonitorNum=Screen.MonitorCount-1 then
  begin
    newmonitor:=0;
  end else
  begin
    newmonitor:=touchscreenform.Monitor.MonitorNum+1;
  end;

  touchscreenform.left:=Screen.Monitors[NewMonitor].Left+(Screen.Monitors[NewMonitor].Width div 2)-(touchscreenform.Width div 2);
  touchscreenform.top:=Screen.Monitors[NewMonitor].top+(Screen.Monitors[NewMonitor].Height div 2)-(touchscreenform.Height div 2);
//  touchscreenform.width:=Screen.Monitors[NewMonitor].width;
//  touchscreenform.height:=Screen.Monitors[NewMonitor].height;
end;

procedure Ttouchscreenform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  devicebtn.PngImage:=pnglist.Items.Items[0].PngImage;
  groupbtn.PngImage:=pnglist.Items.Items[1].PngImage;
  rgbbtn.PngImage:=pnglist.Items.Items[2].PngImage;
  pantiltbtn.PngImage:=pnglist.Items.Items[3].PngImage;
  blackoutbtn.PngImage:=pnglist.Items.Items[4].PngImage;
  gobobtn.PngImage:=pnglist.Items.Items[5].PngImage;
{
  shutteropenbtn.PngImage:=pnglist.Items.Items[9].PngImage;
  shutterclosebtn.PngImage:=pnglist.Items.Items[6].PngImage;
  dimmer0btn.PngImage:=pnglist.Items.Items[6].PngImage;
  dimmer25btn.PngImage:=pnglist.Items.Items[7].PngImage;
  dimmer75btn.PngImage:=pnglist.Items.Items[8].PngImage;
  dimmer100btn.PngImage:=pnglist.Items.Items[9].PngImage;
}

  strobo0btn.PngImage:=pnglist.Items.Items[6].PngImage;
  strobo25btn.PngImage:=pnglist.Items.Items[7].PngImage;
  strobo75btn.PngImage:=pnglist.Items.Items[16].PngImage;
  strobo85btn.PngImage:=pnglist.Items.Items[8].PngImage;
  strobo100btn.PngImage:=pnglist.Items.Items[9].PngImage;

  nextgobo1btn.PngImage:=pnglist.Items.Items[14].PngImage;
  prevgobo1btn.PngImage:=pnglist.Items.Items[14].PngImage;
  nextgobo2btn.PngImage:=pnglist.Items.Items[14].PngImage;
  prevgobo2btn.PngImage:=pnglist.Items.Items[14].PngImage;
  nextcolor1btn.PngImage:=pnglist.Items.Items[15].PngImage;
  prevcolor1btn.PngImage:=pnglist.Items.Items[15].PngImage;
  nextcolor2btn.PngImage:=pnglist.Items.Items[15].PngImage;
  prevcolor2btn.PngImage:=pnglist.Items.Items[15].PngImage;
  dimmerbtn.PngImage:=pnglist.Items.Items[10].PngImage;
  freezebtn.PngImage:=pnglist.Items.Items[11].PngImage;
  upbtn.PngImage:=pnglist.Items.Items[12].PngImage;
  downbtn.PngImage:=pnglist.Items.Items[13].PngImage;

  colorpicker.SelectedColor:=clRed;

  _Buffer:=TBitmap32.Create;
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;

  BtnDown.Y:=-1;
  BtnDown.X:=-1;
  OverBtn.Y:=-1;
  OverBtn.X:=-1;

  maxbtns:=7;
  yoffset:=0;
  buttonheight:=73;
  buttonwidth:=81;
end;

procedure Ttouchscreenform.CreateParams(var Params:TCreateParams);
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

procedure Ttouchscreenform.gobobtnClick(Sender: TObject);
begin
  paintbox1.Visible:=true;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=true;
  goborot2slider.visible:=true;
  button1.visible:=true;
  button2.visible:=true;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=false;
  channelboxtimer.enabled:=channelbox.visible;

  PaintboxType:=2;
  sidebarform.RefreshGoboList;

  RefreshGoboList;
  Timer1Timer(nil);
end;

procedure Ttouchscreenform.Timer1Timer(Sender: TObject);
begin
  if paintbox1.Visible and ((PaintboxType=0) or (PaintboxType=1)) then
  begin
    RedrawPanel;
    Timer1.Interval:=500;
  end;
  if paintbox1.visible and (PaintboxType=2) then
  begin
    RefreshGobolist;
    Timer1.Interval:=1000;
  end;
end;

procedure Ttouchscreenform.FormShow(Sender: TObject);
var
  LReg:TRegistry;
begin
  timer1.enabled:=true;

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
  			LReg.WriteBool('Showing Touchscreen',true);

        if not LReg.KeyExists('Touchscreen') then
	        LReg.CreateKey('Touchscreen');
	      if LReg.OpenKey('Touchscreen',true) then
	      begin
          if LReg.ValueExists('Width') then
            touchscreenform.ClientWidth:=LReg.ReadInteger('Width')
          else
            touchscreenform.ClientWidth:=785;
          if LReg.ValueExists('Height') then
            touchscreenform.ClientHeight:=LReg.ReadInteger('Height')
          else
            touchscreenform.ClientHeight:=619;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+touchscreenform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              touchscreenform.Left:=LReg.ReadInteger('PosX')
            else
              touchscreenform.Left:=0;
          end else
            touchscreenform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              touchscreenform.Top:=LReg.ReadInteger('PosY')
            else
              touchscreenform.Top:=0;
          end else
            touchscreenform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  touchscreenform.RefreshGoboList;
  if channelbox.visible then
    touchscreenform.RefreshChannelbox;
end;

procedure Ttouchscreenform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  timer1.enabled:=false;

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
          LReg.WriteBool('Showing Touchscreen',false);
        end;
      end;
    end;
	end;
end;

procedure Ttouchscreenform.TiledImage2MouseDown(Sender: TObject;
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
  SetPanTilt;
//  change(fadenkreuz);
end;

procedure Ttouchscreenform.TiledImage2MouseMove(Sender: TObject;
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
      SetPanTilt;
//      change(fadenkreuz);
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
      SetPanTilt;
//      change(fadenkreuz);
    end;
  end;
end;

procedure Ttouchscreenform.TiledImage2MouseUp(Sender: TObject;
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

procedure Ttouchscreenform.VertTrackChange(Sender: TObject);
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

procedure Ttouchscreenform.HorTrackChange(Sender: TObject);
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

procedure Ttouchscreenform.dimmersliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      //geraetesteuerung.set_channel(mainform.Devices[i].ID,'dimmer',255-dimmerslider.position,255-dimmerslider.position,0);
      geraetesteuerung.set_dimmer(mainform.Devices[i].ID, 255-dimmerslider.position, 500);
    end;
  end;
end;

procedure Ttouchscreenform.shutteropenbtnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_shutter(mainform.Devices[i].ID,255);
    end;
  end;
end;

procedure Ttouchscreenform.shutterclosebtnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_shutter(mainform.Devices[i].ID,0);
    end;
  end;
end;

procedure Ttouchscreenform.strobo100btnClick(Sender: TObject);
begin
  if strobeslider.position=0 then strobesliderChange(nil);
  strobeslider.position:=0;
end;

procedure Ttouchscreenform.strobo75btnClick(Sender: TObject);
begin
  if strobeslider.position=128 then strobesliderChange(nil);
  strobeslider.position:=128;
end;

procedure Ttouchscreenform.strobo25btnClick(Sender: TObject);
begin
  if strobeslider.position=192 then strobesliderChange(nil);
  strobeslider.position:=192;
end;

procedure Ttouchscreenform.strobo0btnClick(Sender: TObject);
begin
  if strobeslider.position=255 then strobesliderChange(nil);
  strobeslider.position:=255;
end;

procedure Ttouchscreenform.blackoutbtnClick(Sender: TObject);
begin
  mainform.BlackoutClick(nil);
end;

procedure Ttouchscreenform.freezebtnClick(Sender: TObject);
begin
  mainform.TBItem36Click(nil);
end;

procedure Ttouchscreenform.nextgobo1btnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
      geraetesteuerung.set_gobo1plus(mainform.Devices[i].ID);
  end;
end;

procedure Ttouchscreenform.nextcolor1btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].colors)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'COLOR1');

      for j:=0 to length(mainform.devices[i].colors)-1 do
      begin
        if (value>=mainform.devices[i].colorlevels[j]) and (value<=mainform.Devices[i].colorendlevels[j]) then
        begin
          if j<length(mainform.devices[i].colors) then
            value:=j+1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'COLOR1', -1, mainform.devices[i].colorlevels[value], 0, 0);
    end;
  end;
end;

procedure Ttouchscreenform.nextcolor2btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].colors2)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'COLOR2');

      for j:=0 to length(mainform.devices[i].colors2)-1 do
      begin
        if (value>=mainform.devices[i].colorlevels2[j]) and (value<=mainform.Devices[i].colorendlevels2[j]) then
        begin
          if j<length(mainform.devices[i].colors2) then
            value:=j+1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'COLOR2', -1, mainform.devices[i].colorlevels2[value], 0, 0);
    end;
  end;
end;

procedure Ttouchscreenform.nextgobo2btnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
      geraetesteuerung.set_gobo2plus(mainform.Devices[i].ID);
  end;
end;

procedure Ttouchscreenform.prevgobo1btnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
      geraetesteuerung.set_gobo1minus(mainform.Devices[i].ID);
  end;
end;

procedure Ttouchscreenform.prevgobo2btnClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
      geraetesteuerung.set_gobo2minus(mainform.Devices[i].ID);
  end;

  grafischebuehnenansicht.RedrawPictures:=true;
end;

procedure Ttouchscreenform.prevcolor1btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].colors)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'COLOR1');

      for j:=0 to length(mainform.devices[i].colors)-1 do
      begin
        if (value>=mainform.devices[i].colorlevels[j]) and (value<=mainform.Devices[i].colorendlevels[j]) then
        begin
          if j>0 then
            value:=j-1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'COLOR1', -1, mainform.devices[i].colorlevels[value], 0, 0);
    end;
  end;
end;

procedure Ttouchscreenform.prevcolor2btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].colors2)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'COLOR2');

      for j:=0 to length(mainform.devices[i].colors2)-1 do
      begin
        if (value>=mainform.devices[i].colorlevels2[j]) and (value<=mainform.Devices[i].colorendlevels2[j]) then
        begin
          if j>0 then
            value:=j-1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'COLOR2', -1, mainform.devices[i].colorlevels2[value], 0, 0);
    end;
  end;
end;

procedure Ttouchscreenform.colorpickerChange(Sender: TObject);
var
  i:integer;
  R,G,B:byte;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      TColor2RGB(colorpicker.SelectedColor, R, G, B);
      geraetesteuerung.set_color(mainform.devices[i].ID, R, G, B, 500, 0);
    end;
  end;
end;

procedure Ttouchscreenform.SetPanTilt;
var
  i:integer;
	phi,rad,x,y:Extended;
	pan, tilt:Extended;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
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
  end;
end;

procedure Ttouchscreenform.PositionXYMouseMove(Sender: TObject;
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
      SetPanTilt;
//      change(fadenkreuz);
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
      SetPanTilt;
//      change(fadenkreuz);
    end;
  end;
end;

procedure Ttouchscreenform.PositionXYMouseUp(Sender: TObject;
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
end;

procedure Ttouchscreenform.RefreshGoboList;
var
  i,j:integer;
  rect:Trect;
  GobosPerRow:integer;
begin
  if PaintboxType<>2 then exit;

  GobosPerRow:=7;

  _Buffer.Canvas.Brush.Color:=clBlack;
  _Buffer.Canvas.Rectangle(0, 0, _Buffer.Width, _Buffer.Height);

  GoboOffset:=0;

  setlength(GoboButtons, 0);
  for i:=GoboOffset to length(sidebarform.GoboList)-1 do
  begin
    if (i>(80+GoboOffset)) or (i>=length(sidebarform.GoboList)) then break; // nur maximal 41 Gobos anzeigen

    for j:=0 to mainform.GoboPictures.Items.Count-1 do
    begin
      if sidebarform.GoboList[i]=mainform.GoboPictures.Items.Items[j].Name then
      begin
        rect.Left:=(i-GoboOffset)*32-(trunc((i-GoboOffset)/GobosPerRow)*224);
        rect.Top:=trunc((i-GoboOffset)/GobosPerRow)*32;
        rect.Right:=((i-GoboOffset)*32-(trunc((i-GoboOffset)/GobosPerRow)*224)+32);
        rect.Bottom:=(trunc((i-GoboOffset)/GobosPerRow)*32)+32;

        mainform.GoboPictures.Items.Items[j].PngImage.Draw(_Buffer.Canvas, rect);
        setlength(GoboButtons, length(GoboButtons)+1);
        GoboButtons[length(GoboButtons)-1]:=mainform.GoboPictures.Items.Items[j].Name;

        break;
      end;
    end;
  end;
  BitBlt(Paintbox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Ttouchscreenform.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, j, k, OverGoboButton, GobosPerRow:integer;
  BestGobo1, BestGobo2:integer;
  MaxValueGobo1, MaxValueGobo2:single;
begin
  if (PaintboxType=0) then
  begin
    if (BtnDown.X>-1) and (BtnDown.Y>-1) and ((BtnDown.Y*maxbtns+BtnDown.Y+BtnDown.X)<length(mainform.DeviceSelected)) then
      mainform.DeviceSelected[BtnDown.Y*maxbtns+BtnDown.Y+BtnDown.X]:=not mainform.DeviceSelected[BtnDown.Y*maxbtns+BtnDown.Y+BtnDown.X];
    mainform.DeviceSelectionChanged(nil);
    grafischebuehnenansicht.RedrawPictures:=true;

    BtnDown.Y:=-1;
    BtnDown.X:=-1;
  end else if (PaintboxType=1) then
  begin
    if (BtnDown.X>-1) and (BtnDown.Y>-1) and ((BtnDown.Y*maxbtns+BtnDown.Y+BtnDown.X)<length(mainform.devicegroups)) then
      mainform.SelectDeviceGroup(mainform.devicegroups[BtnDown.Y*maxbtns+BtnDown.Y+BtnDown.X].ID, Shift=[ssCtrl]);
    grafischebuehnenansicht.RedrawPictures:=true;

    BtnDown.Y:=-1;
    BtnDown.X:=-1;
  end else if (PaintboxType=2) then
  begin
    GobosPerRow:=7;

    OverGoboButton:=(trunc(X/32)+1)+(trunc(Y/32)*GobosPerRow)-1+GoboOffset;

    if (OverGoboButton>-1) and (OverGoboButton<length(GoboButtons)) then
    begin
      for i:=0 to length(mainform.Devices)-1 do
      begin
        if mainform.DeviceSelected[i] then
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
                  if mainform.devices[i].bestgobos[j][k].GoboName=GoboButtons[OverGoboButton] then
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
          end;
        end;
      end;
    end;
    grafischebuehnenansicht.RedrawPictures:=true;
  end;
end;

procedure Ttouchscreenform.FormResize(Sender: TObject);
begin
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;

  maxbtns:=trunc(paintbox1.width/buttonwidth)-1;

{
  colorpicker.Height:=panel4.Height;
  colorpicker.Width:=colorpicker.Height;
  colorpicker.Top:=0;
  colorpicker.Left:=(panel4.Width div 2)-(colorpicker.Width div 2);
}

  fadenkreuz.Height:=panel4.Height-16;
  fadenkreuz.Width:=fadenkreuz.Height;
  fadenkreuz.Top:=8;
  fadenkreuz.Left:=(panel4.Width div 2)-(fadenkreuz.Width div 2);

  bevel1.Height:=fadenkreuz.Height;
  bevel1.Left:=fadenkreuz.Width div 2;
  bevel2.Width:=fadenkreuz.Width;
  bevel2.Top:=fadenkreuz.Height div 2;

  PositionXY.Width:=fadenkreuz.Width div 15;
  PositionXY.Height:=PositionXY.Width;
  PositionXY.Left:=(fadenkreuz.Width div 2)-(PositionXY.Width div 2);
  PositionXY.Top:=(fadenkreuz.Height div 2)-(PositionXY.Height div 2);

  Timer1.Interval:=25;
end;

// Erstellt ein Farbverlauf von oben nach unten
procedure Ttouchscreenform.DrawGradientH(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
var
  X,R,G,B:integer;
begin
  for X := Rect.Top to Rect.Bottom do
  begin
    R := Round(GetRValue(Color1) + ((GetRValue(Color2) - GetRValue(Color1)) * (X - Rect.Top) / (Rect.Bottom - Rect.Top)));
    G := Round(GetGValue(Color1) + ((GetGValue(Color2) - GetGValue(Color1)) * (X - Rect.Top) / (Rect.Bottom - Rect.Top)));
    B := Round(GetBValue(Color1) + ((GetBValue(Color2) - GetBValue(Color1)) * (X - Rect.Top) / (Rect.Bottom - Rect.Top)));

    Canvas.Pen.Color := RGB2TColor(R, G, B);
    Canvas.Pen.Width := 1;
    Canvas.Pen.Style := psInsideFrame;

    Canvas.MoveTo(Rect.Left, X);
    Canvas.LineTo(Rect.Right, X);
  end;
end;

function Ttouchscreenform.UseGradient(Farbe: TColor; Direction: byte):TColor;
var
  R,G,B:Byte;
  gradientvalue:integer;
begin
  gradientvalue:=0;

  if Direction=0 then
    gradientvalue:=50; // Dunkler
  if Direction=1 then
    gradientvalue:=-150; // Heller

  TColor2RGB(Farbe,R,G,B);

  if gradientvalue>0 then
  begin
    if (R-gradientvalue>=0) then R:=R-gradientvalue else R:=0;
    if (G-gradientvalue>=0) then G:=G-gradientvalue else G:=0;
    if (B-gradientvalue>=0) then B:=B-gradientvalue else B:=0;
  end else
  begin
    if (R-gradientvalue)<=255 then R:=R-gradientvalue else R:=255;
    if (G-gradientvalue)<=255 then G:=G-gradientvalue else G:=255;
    if (B-gradientvalue)<=255 then B:=B-gradientvalue else B:=255;
  end;

  Result:=RGB2TColor(R,G,B);
end;

procedure Ttouchscreenform.RedrawPanel;
var
  i, counter, line:integer;
  rect:Trect;
  textoffset:integer;
  text1,text2,text3:string;
begin
  if PaintboxType>1 then exit;

  _Buffer.Canvas.Brush.Style:=bsSolid;
  _Buffer.Canvas.Brush.Color:=clBtnFace;
  _Buffer.Canvas.Pen.Style:=psSolid;
  _Buffer.Canvas.Pen.Color:=clBtnFace;
  _Buffer.Canvas.Rectangle(0,0,_Buffer.Width,_Buffer.Height);
  _Buffer.Canvas.Pen.Color:=clBtnShadow;

  if PaintboxType=0 then
  begin
    line:=0;
    counter:=0;

    maxlines:=0;

    // Buttons mit Bild und Text zeichnen
    for i:=0 to length(mainform.devices)-1 do // Zeilenanzahl
    begin
      if counter>maxbtns then
      begin
        inc(line);
        counter:=0;
      end;

//      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) {or (((counter+1)*buttonwidth)>_Buffer.Width)} or
//      ((counter*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      _Buffer.Canvas.Brush.Color:=mainform.devices[i].Color;

      //  _Buffer.Canvas.Rectangle(counter*buttonwidth, yoffset+line*buttonheight, (counter+1)*buttonwidth, yoffset+(line+1)*buttonheight);
      rect.Top:=yoffset+line*buttonheight;
      rect.Bottom:=yoffset+(line+1)*buttonheight-1;
      rect.Left:=counter*buttonwidth;
      rect.Right:=(counter+1)*buttonwidth;

      if mainform.DeviceSelected[i] then
        buttonstyle:=1
      else
        buttonstyle:=0;
      DrawGradientH(_Buffer.Canvas,mainform.devices[i].Color,UseGradient(mainform.devices[i].Color,buttonstyle),rect);

      // Anzeige verändern, wenn Eigenschaft des Button aktiviert
      if mainform.DeviceSelected[i] then
      begin
        _Buffer.Canvas.Pen.Style:=psClear;
        _Buffer.Canvas.Brush.Color:=clRed;
        _Buffer.Canvas.Rectangle(counter*buttonwidth+2, yoffset+line*buttonheight+2, (counter+1)*buttonwidth-1, yoffset+line*buttonheight+8);
      end;
      _Buffer.Canvas.Brush.Style:=bsClear;

      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Size:=8;
      if mainform.DeviceSelected[i] then
      begin
        _Buffer.Canvas.Font.Style:=[fsBold];
        _Buffer.Canvas.Font.Color:=clGreen;
      end else
      begin
        _Buffer.Canvas.Font.Style:=[];
        _Buffer.Canvas.Font.Color:=clBlack;
      end;
      text1:=copy(mainform.devices[i].Name, 1, 10);
      text2:=copy(mainform.devices[i].Name, 11, 10);
      text3:=copy(mainform.devices[i].Name, 21, 10);

      if (BtnDown.Y=line) and (BtnDown.X=counter) then
        textoffset:=1
      else
        textoffset:=0;

      // Bild zeichnen
      rect.Top:=textoffset+yoffset+line*buttonheight+2;
      rect.Left:=textoffset+counter*buttonwidth+(buttonheight div 2)-16;
      rect.right:=textoffset+counter*buttonwidth+((buttonheight div 2)+32)-16;
      rect.Bottom:=textoffset+yoffset+line*buttonheight+2+32;
      mainform.devicepictures32.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[i].bildadresse)].PngImage.Draw(_Buffer.Canvas, rect);
      // Zentriert
      _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text1)/2), textoffset+yoffset+line*buttonheight+5+30, text1);
      _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text2)/2), textoffset+yoffset+line*buttonheight+17+30, text2);
      _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text3)/2), textoffset+yoffset+line*buttonheight+29+30, text3);
{
      // Bild zeichnen
      rect.Top:=textoffset+yoffset+line*buttonheight+10;
      rect.Left:=textoffset+counter*buttonwidth+8;
      rect.right:=textoffset+counter*buttonwidth+8+mainform.devices[i].picturesize;
      rect.Bottom:=textoffset+yoffset+line*buttonheight+10+mainform.devices[i].picturesize;
      mainform.devicepictures32.Items.Items[geraetesteuerung.GetImageIndex(mainform.devices[i].bildadresse)].PngImage.Draw(_Buffer.Canvas, rect);
      _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text1)-5, textoffset+yoffset+line*buttonheight+5, text1);
      _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text2)-5, textoffset+yoffset+line*buttonheight+17, text2);
      _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text3)-5, textoffset+yoffset+line*buttonheight+29, text3);
}
  {
      if Assigned(mainform.devices[i].PNG) and (mainform.devices[i].Picture<>'') and showiconsbtn.Checked then
      begin
        // Bild zeichnen
        rect.Top:=textoffset+yoffset+line*buttonheight+10;
        rect.Bottom:=textoffset+yoffset+line*buttonheight+10+mainform.devices[i].PNG.Height;
        rect.Left:=textoffset+counter*buttonwidth+8;
        rect.Right:=textoffset+counter*buttonwidth+8+mainform.devices[i].PNG.Width;
        mainform.devices[i].PNG.Draw(_Buffer.Canvas, rect);

        _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text1)-5, textoffset+yoffset+line*buttonheight+5, text1);
        _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text2)-5, textoffset+yoffset+line*buttonheight+17, text2);
        _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text3)-5, textoffset+yoffset+line*buttonheight+29, text3);
      end else
      begin
        _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text1)/2), textoffset+yoffset+line*buttonheight+5, text1);
        _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text2)/2), textoffset+yoffset+line*buttonheight+17, text2);
        _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text3)/2), textoffset+yoffset+line*buttonheight+29, text3);
      end;
  }

      _Buffer.Canvas.Font.Size:=7;
      _Buffer.Canvas.TextOut(counter*buttonwidth+3, yoffset+(line+1)*buttonheight-15, inttostr(mainform.devices[i].Startaddress));

      inc(counter);
    end;

    maxlines:=line;
    line:=0;
    counter:=0;

    // Striche für 3D-Effekt zeichnen (weiß)
    _Buffer.Canvas.Pen.Style:=psSolid;
    for i:=0 to length(mainform.devices)-1 do // Spaltenanzahl
    begin
      if counter>maxbtns then
      begin
        inc(line);
        counter:=0;
      end;

//      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) {or (((counter+1)*buttonwidth)>_Buffer.Width)} or
//      ((counter*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      if (BtnDown.Y=line) and (BtnDown.X=counter) then
        _Buffer.Canvas.Pen.Color:=clOlive
      else
      begin
        if (OverBtn.Y=line) and (OverBtn.X=counter) then
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.Canvas.Pen.Color:=clOlive
          else
            _Buffer.Canvas.Pen.Color:=clYellow;
        end else
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.Canvas.Pen.Color:=clBtnShadow
          else
            _Buffer.Canvas.Pen.Color:=clWhite;
        end;
      end;

      // horizontal               X               Y
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+line*buttonheight);
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+line*buttonheight+1);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-2, yoffset+line*buttonheight+1);

      // vertikal                 X               Y
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo(counter*buttonwidth, yoffset+(line+1)*buttonheight-1);
      _Buffer.Canvas.MoveTo(counter*buttonwidth+1, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo(counter*buttonwidth+1, yoffset+(line+1)*buttonheight-2);

      inc(counter);
    end;

    line:=0;
    counter:=0;

    // Striche für 3D-Effekt zeichnen (dunkel)
    _Buffer.Canvas.Pen.Style:=psSolid;
    for i:=0 to length(mainform.devices)-1 do // Spaltenanzahl
    begin
      if counter>maxbtns then
      begin
        inc(line);
        counter:=0;
      end;

//      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) {or (((counter+1)*buttonwidth)>_Buffer.Width)} or
//      ((counter*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      if (BtnDown.Y=line) and (BtnDown.X=counter) then
        _Buffer.Canvas.Pen.Color:=clYellow
      else
      begin
        if (OverBtn.Y=line) and (OverBtn.X=counter) then
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.Canvas.Pen.Color:=clYellow
          else
            _Buffer.Canvas.Pen.Color:=clOlive;
        end else
        begin
          if mainform.DeviceSelected[i] then
            _Buffer.Canvas.Pen.Color:=clWhite
          else
            _Buffer.Canvas.Pen.Color:=clBtnShadow;
        end;
      end;

      // horizontal               X               Y
      _Buffer.Canvas.MoveTo(counter*buttonwidth+1, yoffset+(line+1)*buttonheight-2);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+(line+1)*buttonheight-2);
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+(line+1)*buttonheight-1);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+(line+1)*buttonheight-1);

      // vertikal                 X               Y
      _Buffer.Canvas.MoveTo((counter+1)*buttonwidth-2, yoffset+line*buttonheight+1);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-2, yoffset+(line+1)*buttonheight-1);
      _Buffer.Canvas.MoveTo((counter+1)*buttonwidth-1, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+(line+1)*buttonheight-1);

      inc(counter);
    end;

  {
    // Punktierten Rahmen des markierten Buttons zeichen
    _Buffer.Canvas.Brush.Style:=bsClear;
    _Buffer.Canvas.Pen.Color:=clBlack;
    _Buffer.Canvas.Pen.Style:=psDot;
    for i:=0 to length(mainform.devices)-1 do // Spaltenanzahl
    if (SelectedBtn.Y=line) and (SelectedBtn.X=i) then
    begin
      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) or (((i+1)*buttonwidth)>_Buffer.Width) or
      ((i*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      _Buffer.Canvas.Rectangle(i*buttonwidth+5, yoffset+line*buttonheight+5, (i+1)*buttonwidth-5, yoffset+(line+1)*buttonheight-5);
      break;
    end;
  }
  end else if PaintboxType=1 then
  begin
    line:=0;
    counter:=0;

    maxlines:=0;

    // Buttons mit Bild und Text zeichnen
    for i:=0 to length(mainform.DeviceGroups)-1 do // Zeilenanzahl
    begin
      if counter>maxbtns then
      begin
        inc(line);
        counter:=0;
      end;

//      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) {or (((counter+1)*buttonwidth)>_Buffer.Width)} or
//      ((counter*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      _Buffer.Canvas.Brush.Color:=clWhite;

      //  _Buffer.Canvas.Rectangle(counter*buttonwidth, yoffset+line*buttonheight, (counter+1)*buttonwidth, yoffset+(line+1)*buttonheight);
      rect.Top:=yoffset+line*buttonheight;
      rect.Bottom:=yoffset+(line+1)*buttonheight-1;
      rect.Left:=counter*buttonwidth;
      rect.Right:=(counter+1)*buttonwidth;

      buttonstyle:=0;
      DrawGradientH(_Buffer.Canvas,clWhite,UseGradient(clWhite,buttonstyle),rect);

      _Buffer.Canvas.Brush.Style:=bsClear;

      _Buffer.Canvas.Font.Name:='Arial';
      _Buffer.Canvas.Font.Size:=8;
      _Buffer.Canvas.Font.Style:=[];
      _Buffer.Canvas.Font.Color:=clBlack;

      text1:=copy(mainform.devicegroups[i].Name, 1, 10);
      text2:=copy(mainform.devicegroups[i].Name, 11, 10);
      text3:=copy(mainform.devicegroups[i].Name, 21, 10);

      if (BtnDown.Y=line) and (BtnDown.X=counter) then
        textoffset:=1
      else
        textoffset:=0;

      // Bild zeichnen
      rect.Top:=textoffset+yoffset+line*buttonheight+2;
      rect.Left:=textoffset+counter*buttonwidth+(buttonheight div 2)-16;
      rect.right:=textoffset+counter*buttonwidth+((buttonheight div 2)+32)-16;
      rect.Bottom:=textoffset+yoffset+line*buttonheight+2+32;
      mainform.devicepictures32.Items.Items[geraetesteuerung.GetImageIndex(mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png')].PngImage.Draw(_Buffer.Canvas, rect);
      // Zentriert
      _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text1)/2), textoffset+yoffset+line*buttonheight+5+30, text1);
      _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text2)/2), textoffset+yoffset+line*buttonheight+17+30, text2);
      _Buffer.Canvas.TextOut(round(textoffset+(counter+1)*buttonwidth-buttonwidth/2-_Buffer.Canvas.TextWidth(text3)/2), textoffset+yoffset+line*buttonheight+29+30, text3);
{
      rect.Top:=textoffset+yoffset+line*buttonheight+10;
      rect.Left:=textoffset+counter*buttonwidth+8;
      rect.right:=textoffset+counter*buttonwidth+8+32;
      rect.Bottom:=textoffset+yoffset+line*buttonheight+10+32;
      mainform.devicepictures32.Items.Items[geraetesteuerung.GetImageIndex(mainform.pcdimmerdirectory+'\Devicepictures\32 x 32\par56silber.png')].PngImage.Draw(_Buffer.Canvas, rect);
      // Rechtsbündig
      _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text1)-5, textoffset+yoffset+line*buttonheight+5, text1);
      _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text2)-5, textoffset+yoffset+line*buttonheight+17, text2);
      _Buffer.Canvas.TextOut(textoffset+(counter+1)*buttonwidth-_Buffer.Canvas.TextWidth(text3)-5, textoffset+yoffset+line*buttonheight+29, text3);
}

//      _Buffer.Canvas.Font.Size:=7;
//      _Buffer.Canvas.TextOut(counter*buttonwidth+3, yoffset+(line+1)*buttonheight-15, mainform.devicegroups[i].Beschreibung);

      inc(counter);
    end;

    maxlines:=line;
    line:=0;
    counter:=0;

    // Striche für 3D-Effekt zeichnen (weiß)
    _Buffer.Canvas.Pen.Style:=psSolid;
    for i:=0 to length(mainform.DeviceGroups)-1 do // Spaltenanzahl
    begin
      if counter>maxbtns then
      begin
        inc(line);
        counter:=0;
      end;

//      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) {or (((counter+1)*buttonwidth)>_Buffer.Width)} or
//      ((counter*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      if (BtnDown.Y=line) and (BtnDown.X=counter) then
        _Buffer.Canvas.Pen.Color:=clOlive
      else
      begin
        if (OverBtn.Y=line) and (OverBtn.X=counter) then
        begin
          _Buffer.Canvas.Pen.Color:=clYellow;
        end else
        begin
          _Buffer.Canvas.Pen.Color:=clWhite;
        end;
      end;

      // horizontal               X               Y
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+line*buttonheight);
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+line*buttonheight+1);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-2, yoffset+line*buttonheight+1);

      // vertikal                 X               Y
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo(counter*buttonwidth, yoffset+(line+1)*buttonheight-1);
      _Buffer.Canvas.MoveTo(counter*buttonwidth+1, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo(counter*buttonwidth+1, yoffset+(line+1)*buttonheight-2);

      inc(counter);
    end;

    line:=0;
    counter:=0;

    // Striche für 3D-Effekt zeichnen (dunkel)
    _Buffer.Canvas.Pen.Style:=psSolid;
    for i:=0 to length(mainform.DeviceGroups)-1 do // Spaltenanzahl
    begin
      if counter>maxbtns then
      begin
        inc(line);
        counter:=0;
      end;

//      if ((yoffset+(line+1)*buttonheight)>_Buffer.Height) {or (((counter+1)*buttonwidth)>_Buffer.Width)} or
//      ((counter*buttonwidth)<0) or ((yoffset+line*buttonheight)<0) then continue;

      if (BtnDown.Y=line) and (BtnDown.X=counter) then
        _Buffer.Canvas.Pen.Color:=clYellow
      else
      begin
        if (OverBtn.Y=line) and (OverBtn.X=counter) then
        begin
          _Buffer.Canvas.Pen.Color:=clOlive;
        end else
        begin
          _Buffer.Canvas.Pen.Color:=clBtnShadow;
        end;
      end;

      // horizontal               X               Y
      _Buffer.Canvas.MoveTo(counter*buttonwidth+1, yoffset+(line+1)*buttonheight-2);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+(line+1)*buttonheight-2);
      _Buffer.Canvas.MoveTo(counter*buttonwidth, yoffset+(line+1)*buttonheight-1);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+(line+1)*buttonheight-1);

      // vertikal                 X               Y
      _Buffer.Canvas.MoveTo((counter+1)*buttonwidth-2, yoffset+line*buttonheight+1);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-2, yoffset+(line+1)*buttonheight-1);
      _Buffer.Canvas.MoveTo((counter+1)*buttonwidth-1, yoffset+line*buttonheight);
      _Buffer.Canvas.LineTo((counter+1)*buttonwidth-1, yoffset+(line+1)*buttonheight-1);

      inc(counter);
    end;
  end;

  BitBlt(Paintbox1.Canvas.Handle,0,0,_Buffer.Width,_Buffer.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);
end;

procedure Ttouchscreenform.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (PaintboxType>1) then exit;

  OverBtn.Y:=trunc((Y-yoffset)/buttonheight);
  OverBtn.X:=trunc((X)/buttonwidth);
  Timer1.Interval:=25;
end;

procedure Ttouchscreenform.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (PaintboxType>1) then exit;

  BtnDown.Y:=trunc((Y-yoffset)/buttonheight);
  BtnDown.X:=trunc((X)/buttonwidth);
end;

procedure Ttouchscreenform.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=(NewHeight>250) and (NewWidth>250)
end;

procedure Ttouchscreenform.upbtnClick(Sender: TObject);
begin
  yoffset:=yoffset+buttonheight{*trunc(Paintbox1.Height/buttonheight)};
  if yoffset>0 then yoffset:=0; // Anschlag nach oben setzen
  Timer1Timer(nil);
end;

procedure Ttouchscreenform.downbtnClick(Sender: TObject);
begin
  yoffset:=yoffset-buttonheight{*trunc(Paintbox1.Height/buttonheight)};
  if yoffset<(-1*buttonheight*maxlines) then yoffset:=-1*buttonheight*maxlines;
{
  if PaintboxType=0 then
  begin
    if yoffset<(-(trunc(length(mainform.devices) / maxbtns)+1-trunc(Paintbox1.Height/buttonheight))*buttonheight) then
      yoffset:=-1*(trunc(length(mainform.devices) / maxbtns)+1-trunc(Paintbox1.Height/buttonheight))*buttonheight;
  end else if PaintboxType=1 then
  begin
    if yoffset<(-(trunc(length(mainform.devicegroups) / maxbtns)+1-trunc(Paintbox1.Height/buttonheight))*buttonheight) then
      yoffset:=-1*(trunc(length(mainform.devicegroups) / maxbtns)+1-trunc(Paintbox1.Height/buttonheight))*buttonheight;
  end;
}
  Timer1Timer(nil);
end;

procedure Ttouchscreenform.goborot1sliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_gobo1rot(mainform.Devices[i].ID, goborot1slider.position);
    end;
  end;
end;

procedure Ttouchscreenform.Button1Click(Sender: TObject);
begin
  goborot1slider.position:=127;
end;

procedure Ttouchscreenform.Button2Click(Sender: TObject);
begin
  goborot2slider.position:=127;
end;

procedure Ttouchscreenform.goborot2sliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_gobo2rot(mainform.Devices[i].ID, goborot2slider.position);
    end;
  end;
end;

procedure Ttouchscreenform.strobesliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_strobe(mainform.Devices[i].ID, 255-strobeslider.position);
    end;
  end;
end;

procedure Ttouchscreenform.irissliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_iris(mainform.Devices[i].ID, 255-irisslider.position);
    end;
  end;
end;

procedure Ttouchscreenform.prismasliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_prismarot(mainform.Devices[i].ID, 255-prismaslider.position);
    end;
  end;
end;

procedure Ttouchscreenform.prismasingleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_prisma(mainform.Devices[i].ID, 0);
    end;
  end;
end;

procedure Ttouchscreenform.strobo85btnClick(Sender: TObject);
begin
  if strobeslider.position=64 then strobesliderChange(nil);
  strobeslider.position:=64;
end;

procedure Ttouchscreenform.minusbtnClick(Sender: TObject);
begin
  dimmerslider.position:=dimmerslider.position+25
end;

procedure Ttouchscreenform.irisminusClick(Sender: TObject);
begin
  irisslider.position:=irisslider.position+25
end;

procedure Ttouchscreenform.prismarotminusClick(Sender: TObject);
begin
  prismaslider.position:=prismaslider.position+25
end;

procedure Ttouchscreenform.prismasingleClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_prisma(mainform.Devices[i].ID, 0);
    end;
  end;
end;

procedure Ttouchscreenform.prismatripleClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_prisma(mainform.Devices[i].ID, 255);
    end;
  end;
end;

procedure Ttouchscreenform.prismarotstopClick(Sender: TObject);
begin
  prismaslider.Position:=127;
end;

procedure Ttouchscreenform.prismarotplusClick(Sender: TObject);
begin
  prismaslider.position:=prismaslider.position-25
end;

procedure Ttouchscreenform.strobeplusClick(Sender: TObject);
begin
  strobeslider.position:=strobeslider.position-25
end;

procedure Ttouchscreenform.strobeminusClick(Sender: TObject);
begin
  strobeslider.position:=strobeslider.position+25
end;

procedure Ttouchscreenform.irisplusClick(Sender: TObject);
begin
  irisslider.position:=irisslider.position-25
end;

procedure Ttouchscreenform.plusbtnClick(Sender: TObject);
begin
  dimmerslider.position:=dimmerslider.position-25
end;

procedure Ttouchscreenform.fokussliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'FOCUS', -1, 255-fokusslider.position, 0, 0);
    end;
  end;
end;

procedure Ttouchscreenform.fokusplusClick(Sender: TObject);
begin
  fokusslider.position:=fokusslider.position-25
end;

procedure Ttouchscreenform.fokusminusClick(Sender: TObject);
begin
  fokusslider.position:=fokusslider.position+25
end;

procedure Ttouchscreenform.chanbtnClick(Sender: TObject);
begin
  paintbox1.Visible:=false;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=true;
  channelboxtimer.enabled:=channelbox.visible;

  ChannelSliderMode:=0;
  RefreshChannelbox;
end;

procedure Ttouchscreenform.ChanSliderChange(Sender: TObject);
var
  i,j,k:integer;
begin
  case ChannelSliderMode of
    0:
    begin
      for i:=0 to length(devicegroup)-1 do
      begin
        for j:=0 to length(devicegroup[i].slidergroup)-1 do
        begin
          if Sender=devicegroup[i].slidergroup[j].Slider then
          begin
            geraetesteuerung.set_channel(devicegroup[i].DeviceID, devicegroup[i].slidergroup[j].Channel, -1, devicegroup[i].slidergroup[j].Slider.Position, 500);
            break;
          end;
        end;
      end;
    end;
    1:
    begin
      for i:=0 to length(devicegroup)-1 do
      begin
        for j:=0 to length(devicegroup[i].slidergroup)-1 do
        begin
          if Sender=devicegroup[i].slidergroup[j].Slider then
          begin
            for k:=0 to length(mainform.Devices)-1 do
            begin
              if mainform.DeviceSelected[k] then
              begin
                if (lowercase(mainform.devices[k].Vendor)=lowercase(devicegroup[i].DeviceVendor)) and (lowercase(mainform.devices[k].DeviceName)=lowercase(devicegroup[i].DeviceName)) then
                  geraetesteuerung.set_channel(mainform.devices[k].ID, devicegroup[i].slidergroup[j].Channel, -1, devicegroup[i].slidergroup[j].Slider.Position, 500);
              end;
            end;
            break;
          end;
        end;
      end;
    end;
    2:
    begin
      for i:=0 to length(slidergroup)-1 do
      begin
        if Sender=slidergroup[i].Slider then
        begin
          for j:=0 to length(mainform.Devices)-1 do
          begin
            if mainform.DeviceSelected[j] then
            begin
              geraetesteuerung.set_channel(mainform.devices[j].ID, slidergroup[i].Channel, -1, slidergroup[i].Slider.Position, 500);
            end;
          end;
          break;
        end;
      end;
    end;
  end;
end;

procedure Ttouchscreenform.RefreshChannelbox;
var
  AlreadyPresent:boolean;
  CurrentDeviceGroup, CurrentSliderGroup, ColCount, CurrentRow, CurrentCol:integer;
  i,j,k:integer;
  MaxHeight:integer;
  newtext:string;
begin
  LockWindow(channelbox.Handle);

  // Zunächst alle Slider entfernen (für Mode=0)
  for i:=0 to length(devicegroup)-1 do
  begin
    for j:=0 to length(devicegroup[i].slidergroup)-1 do
    begin
      devicegroup[i].slidergroup[j].Lbl.Free;
      devicegroup[i].slidergroup[j].Slider.Free;
      devicegroup[i].slidergroup[j].Panel.Free;
    end;
    setlength(devicegroup[i].slidergroup, 0);
    devicegroup[i].Lbl.Free;
    devicegroup[i].Panel.Free;
  end;
  setlength(devicegroup, 0);
  MaxHeight:=0;

  // Zunächst alle Slider entfernen (für Mode=1 und Mode=2)
  for i:=0 to length(SliderGroup)-1 do
  begin
    SliderGroup[i].Slider.Free;
    SliderGroup[i].Lbl.Free;
    SliderGroup[i].Panel.Free;
  end;
  setlength(SliderGroup, 0);


  case ChannelSliderMode of
    0:
    begin
      for i:=0 to length(mainform.devices)-1 do
      begin
        if mainform.DeviceSelected[i] then
        begin
          setlength(devicegroup, length(devicegroup)+1);
          CurrentDeviceGroup:=length(devicegroup)-1;

          devicegroup[CurrentDeviceGroup].DeviceID:=mainform.devices[i].ID;

          // Gerätefenster erzeugen
          ColCount:=trunc(channelbox.Width/250);
          if ColCount<1 then
            ColCount:=1;
          CurrentCol:=0;
          CurrentRow:=0;

          devicegroup[CurrentDeviceGroup].Panel:=TPanel.Create(devicegroup[CurrentDeviceGroup].Panel);
          devicegroup[CurrentDeviceGroup].Panel.Parent:=channelbox;
          devicegroup[CurrentDeviceGroup].Panel.Width:=channelbox.width-25;
          SetRoundMode(rmUp);
          devicegroup[CurrentDeviceGroup].Panel.Height:=16+75*round(length(mainform.devices[i].kanaltyp)/ColCount);
          SetRoundMode(rmNearest);
          if devicegroup[CurrentDeviceGroup].Panel.Height<16+75 then
            devicegroup[CurrentDeviceGroup].Panel.Height:=16+75;
          devicegroup[CurrentDeviceGroup].Panel.Top:=MaxHeight;
          MaxHeight:=MaxHeight+devicegroup[CurrentDeviceGroup].Panel.Height;
          devicegroup[CurrentDeviceGroup].Panel.Left:=0;
          devicegroup[CurrentDeviceGroup].Panel.BevelOuter:=bvNone;
          devicegroup[CurrentDeviceGroup].Panel.Name:='channelbox_devicepanel_'+inttostr(i);
          devicegroup[CurrentDeviceGroup].Panel.Caption:='';

          devicegroup[CurrentDeviceGroup].Shape:=TShape.Create(devicegroup[CurrentDeviceGroup].Shape);
          devicegroup[CurrentDeviceGroup].Shape.Parent:=devicegroup[CurrentDeviceGroup].Panel;
          devicegroup[CurrentDeviceGroup].Shape.Top:=8;
          devicegroup[CurrentDeviceGroup].Shape.Left:=0;
          devicegroup[CurrentDeviceGroup].Shape.Height:=14;
          devicegroup[CurrentDeviceGroup].Shape.Width:=channelbox.width-25;
          devicegroup[CurrentDeviceGroup].Shape.Brush.Color:=clNavy;
          devicegroup[CurrentDeviceGroup].Shape.Pen.Style:=psClear;
          devicegroup[CurrentDeviceGroup].Shape.Name:='channelbox_deviceshape_'+inttostr(i);

          devicegroup[CurrentDeviceGroup].Lbl:=TLabel.Create(devicegroup[CurrentDeviceGroup].Lbl);
          devicegroup[CurrentDeviceGroup].Lbl.Parent:=devicegroup[CurrentDeviceGroup].Panel;
          devicegroup[CurrentDeviceGroup].Lbl.Top:=8;
          devicegroup[CurrentDeviceGroup].Lbl.Left:=8;
          devicegroup[CurrentDeviceGroup].Lbl.Caption:=mainform.devices[i].Name;
          devicegroup[CurrentDeviceGroup].Lbl.Font.Color:=clWhite;
          devicegroup[CurrentDeviceGroup].Lbl.Font.Style:=[fsBold];
          devicegroup[CurrentDeviceGroup].Lbl.Name:='channelbox_devicelabel_'+inttostr(i);

          setlength(devicegroup[CurrentDeviceGroup].slidergroup, length(mainform.devices[i].kanaltyp));
          for j:=0 to length(mainform.devices[i].kanaltyp)-1 do
          begin
            // Kanalzug erzeugen
            devicegroup[CurrentDeviceGroup].slidergroup[j].Channel:=mainform.devices[i].kanaltyp[j];

            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel:=TPanel.Create(devicegroup[CurrentDeviceGroup].slidergroup[j].Panel);
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Parent:=devicegroup[CurrentDeviceGroup].Panel;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Width:=250;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Height:=75;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Top:=16+devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Height*CurrentRow;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Left:=250*CurrentCol;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.BevelOuter:=bvNone;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Name:='channelbox_dev'+inttostr(i)+'_panel_'+inttostr(j);
            devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Caption:='';

            devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl:=TLabel.Create(devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl);
            devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Parent:=devicegroup[CurrentDeviceGroup].slidergroup[j].Panel;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Top:=8;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Left:=8;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Caption:=mainform.devices[i].kanalname[j]+':';
            devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Name:='channelbox_dev'+inttostr(i)+'_label_'+inttostr(j);

            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider:=TTrackbar.Create(devicegroup[CurrentDeviceGroup].slidergroup[j].Slider);
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Parent:=devicegroup[CurrentDeviceGroup].slidergroup[j].Panel;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Top:=8+16;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Left:=5;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Width:=devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Width-5*2;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.TickMarks:=tmBoth;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.TickStyle:=tsNone;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Min:=0;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Max:=255;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.ThumbLength:=40;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.OnChange:=ChanSliderChange;
            devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Name:='channelbox_dev'+inttostr(i)+'_slider_'+inttostr(j);

            CurrentCol:=CurrentCol+1;
            if CurrentCol>=ColCount then
            begin
              CurrentCol:=0;
              CurrentRow:=CurrentRow+1;
            end;
          end;
        end;
      end;
    end;
    1:
    begin
      for i:=0 to length(mainform.devices)-1 do
      begin
        if mainform.DeviceSelected[i] then
        begin
          AlreadyPresent:=false;
          for k:=0 to length(devicegroup)-1 do
          begin
            if (lowercase(devicegroup[k].DeviceVendor)=lowercase(mainform.devices[i].Vendor)) and (lowercase(devicegroup[k].DeviceName)=lowercase(mainform.devices[i].DeviceName)) then
            begin
              AlreadyPresent:=true;
              break;
            end;
          end;

          if not AlreadyPresent then
          begin
            setlength(devicegroup, length(devicegroup)+1);
            CurrentDeviceGroup:=length(devicegroup)-1;

            devicegroup[CurrentDeviceGroup].DeviceID:=mainform.devices[i].ID;
            devicegroup[CurrentDeviceGroup].DeviceVendor:=mainform.devices[i].Vendor;
            devicegroup[CurrentDeviceGroup].DeviceName:=mainform.devices[i].DeviceName;

            // Gerätefenster erzeugen
            ColCount:=trunc(channelbox.Width/250);
            if ColCount<1 then
              ColCount:=1;
            CurrentCol:=0;
            CurrentRow:=0;

            devicegroup[CurrentDeviceGroup].Panel:=TPanel.Create(devicegroup[CurrentDeviceGroup].Panel);
            devicegroup[CurrentDeviceGroup].Panel.Parent:=channelbox;
            devicegroup[CurrentDeviceGroup].Panel.Width:=channelbox.width-25;
            SetRoundMode(rmUp);
            devicegroup[CurrentDeviceGroup].Panel.Height:=16+75*round(length(mainform.devices[i].kanaltyp)/ColCount);
            SetRoundMode(rmNearest);
            if devicegroup[CurrentDeviceGroup].Panel.Height<16+75 then
              devicegroup[CurrentDeviceGroup].Panel.Height:=16+75;
            devicegroup[CurrentDeviceGroup].Panel.Top:=MaxHeight;
            MaxHeight:=MaxHeight+devicegroup[CurrentDeviceGroup].Panel.Height;
            devicegroup[CurrentDeviceGroup].Panel.Left:=0;
            devicegroup[CurrentDeviceGroup].Panel.BevelOuter:=bvNone;
            devicegroup[CurrentDeviceGroup].Panel.Name:='channelbox_devicepanel_'+inttostr(i);
            devicegroup[CurrentDeviceGroup].Panel.Caption:='';

            devicegroup[CurrentDeviceGroup].Shape:=TShape.Create(devicegroup[CurrentDeviceGroup].Shape);
            devicegroup[CurrentDeviceGroup].Shape.Parent:=devicegroup[CurrentDeviceGroup].Panel;
            devicegroup[CurrentDeviceGroup].Shape.Top:=8;
            devicegroup[CurrentDeviceGroup].Shape.Left:=0;
            devicegroup[CurrentDeviceGroup].Shape.Height:=14;
            devicegroup[CurrentDeviceGroup].Shape.Width:=channelbox.width-25;
            devicegroup[CurrentDeviceGroup].Shape.Brush.Color:=clNavy;
            devicegroup[CurrentDeviceGroup].Shape.Pen.Style:=psClear;
            devicegroup[CurrentDeviceGroup].Shape.Name:='channelbox_deviceshape_'+inttostr(i);

            devicegroup[CurrentDeviceGroup].Lbl:=TLabel.Create(devicegroup[CurrentDeviceGroup].Lbl);
            devicegroup[CurrentDeviceGroup].Lbl.Parent:=devicegroup[CurrentDeviceGroup].Panel;
            devicegroup[CurrentDeviceGroup].Lbl.Top:=8;
            devicegroup[CurrentDeviceGroup].Lbl.Left:=8;
            devicegroup[CurrentDeviceGroup].Lbl.Caption:=mainform.devices[i].DeviceName;
            devicegroup[CurrentDeviceGroup].Lbl.Font.Color:=clWhite;
            devicegroup[CurrentDeviceGroup].Lbl.Font.Style:=[fsBold];
            devicegroup[CurrentDeviceGroup].Lbl.Name:='channelbox_devicelabel_'+inttostr(i);

            setlength(devicegroup[CurrentDeviceGroup].slidergroup, length(mainform.devices[i].kanaltyp));
            for j:=0 to length(mainform.devices[i].kanaltyp)-1 do
            begin
              // Kanalzug erzeugen
              devicegroup[CurrentDeviceGroup].slidergroup[j].Channel:=mainform.devices[i].kanaltyp[j];

              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel:=TPanel.Create(devicegroup[CurrentDeviceGroup].slidergroup[j].Panel);
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Parent:=devicegroup[CurrentDeviceGroup].Panel;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Width:=250;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Height:=75;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Top:=16+devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Height*CurrentRow;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Left:=250*CurrentCol;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.BevelOuter:=bvNone;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Name:='channelbox_dev'+inttostr(i)+'_panel_'+inttostr(j);
              devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Caption:='';

              devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl:=TLabel.Create(devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl);
              devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Parent:=devicegroup[CurrentDeviceGroup].slidergroup[j].Panel;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Top:=8;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Left:=8;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Caption:=mainform.devices[i].kanalname[j]+':';
              devicegroup[CurrentDeviceGroup].slidergroup[j].Lbl.Name:='channelbox_dev'+inttostr(i)+'_label_'+inttostr(j);

              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider:=TTrackbar.Create(devicegroup[CurrentDeviceGroup].slidergroup[j].Slider);
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Parent:=devicegroup[CurrentDeviceGroup].slidergroup[j].Panel;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Top:=8+16;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Left:=5;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Width:=devicegroup[CurrentDeviceGroup].slidergroup[j].Panel.Width-5*2;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.TickMarks:=tmBoth;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.TickStyle:=tsNone;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Min:=0;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Max:=255;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.ThumbLength:=40;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.OnChange:=ChanSliderChange;
              devicegroup[CurrentDeviceGroup].slidergroup[j].Slider.Name:='channelbox_dev'+inttostr(i)+'_slider_'+inttostr(j);

              CurrentCol:=CurrentCol+1;
              if CurrentCol>=ColCount then
              begin
                CurrentCol:=0;
                CurrentRow:=CurrentRow+1;
              end;
            end;
          end;
        end;
      end;
    end;
    2:
    begin
      // Routine für nur selektierte Geräte
      ColCount:=trunc(channelbox.Width/250);
      if ColCount<1 then
        ColCount:=1;
      CurrentCol:=0;
      CurrentRow:=0;

      for i:=0 to length(mainform.DeviceSelected)-1 do
      begin
        if mainform.DeviceSelected[i] then
        begin
          for j:=0 to length(mainform.devices[i].kanaltyp)-1 do
          begin
            AlreadyPresent:=false;
            for k:=0 to length(slidergroup)-1 do
            begin
              if lowercase(slidergroup[k].Channel)=lowercase(mainform.devices[i].kanaltyp[j]) then
              begin
                AlreadyPresent:=true;
                break;
              end;
            end;

            if not AlreadyPresent then
            begin
              // Kanalzug erzeugen
              setlength(slidergroup, length(slidergroup)+1);
              CurrentSliderGroup:=length(slidergroup)-1;

              slidergroup[CurrentSliderGroup].Channel:=mainform.devices[i].kanaltyp[j];

              slidergroup[CurrentSliderGroup].Panel:=TPanel.Create(slidergroup[CurrentSliderGroup].Panel);
              slidergroup[CurrentSliderGroup].Panel.Parent:=channelbox;
              slidergroup[CurrentSliderGroup].Panel.Width:=250;
              slidergroup[CurrentSliderGroup].Panel.Height:=75;
              slidergroup[CurrentSliderGroup].Panel.Top:=slidergroup[CurrentSliderGroup].Panel.Height*CurrentRow;
              slidergroup[CurrentSliderGroup].Panel.Left:=250*CurrentCol;
              slidergroup[CurrentSliderGroup].Panel.BevelOuter:=bvNone;
              slidergroup[CurrentSliderGroup].Panel.Name:='channelbox_panel_'+inttostr(CurrentSliderGroup);
              slidergroup[CurrentSliderGroup].Panel.Caption:='';


              slidergroup[CurrentSliderGroup].Lbl:=TLabel.Create(slidergroup[CurrentSliderGroup].Lbl);
              slidergroup[CurrentSliderGroup].Lbl.Parent:=slidergroup[CurrentSliderGroup].Panel;
              slidergroup[CurrentSliderGroup].Lbl.Top:=8;
              slidergroup[CurrentSliderGroup].Lbl.Left:=8;
              newtext:=lowercase(mainform.devices[i].kanaltyp[j]);
              newtext[1]:=uppercase(mainform.devices[i].kanaltyp[j])[1];
              slidergroup[CurrentSliderGroup].Lbl.Caption:=newtext+':';
              slidergroup[CurrentSliderGroup].Lbl.Name:='channelbox_label_'+inttostr(CurrentSliderGroup);

              slidergroup[CurrentSliderGroup].Slider:=TTrackbar.Create(slidergroup[CurrentSliderGroup].Lbl);
              slidergroup[CurrentSliderGroup].Slider.Parent:=slidergroup[CurrentSliderGroup].Panel;
              slidergroup[CurrentSliderGroup].Slider.Top:=8+16;
              slidergroup[CurrentSliderGroup].Slider.Left:=5;
              slidergroup[CurrentSliderGroup].Slider.Width:=slidergroup[CurrentSliderGroup].Panel.Width-5*2;
              slidergroup[CurrentSliderGroup].Slider.TickMarks:=tmBoth;
              slidergroup[CurrentSliderGroup].Slider.TickStyle:=tsNone;
              slidergroup[CurrentSliderGroup].Slider.Min:=0;
              slidergroup[CurrentSliderGroup].Slider.Max:=255;
              slidergroup[CurrentSliderGroup].Slider.ThumbLength:=40;
              slidergroup[CurrentSliderGroup].Slider.OnChange:=ChanSliderChange;
              slidergroup[CurrentSliderGroup].Slider.Name:='channelbox_slider_'+inttostr(CurrentSliderGroup);

              CurrentCol:=CurrentCol+1;
              if CurrentCol>=ColCount then
              begin
                CurrentCol:=0;
                CurrentRow:=CurrentRow+1;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  UnLockWindow(channelbox.Handle);
end;

procedure Ttouchscreenform.channelboxtimerTimer(Sender: TObject);
var
  i,j:integer;
begin
  for i:=0 to length(devicegroup)-1 do
  begin
    for j:=0 to length(devicegroup[i].slidergroup)-1 do
    begin
      if not devicegroup[i].slidergroup[j].Slider.Focused then
        devicegroup[i].slidergroup[j].Slider.Position:=geraetesteuerung.get_channel(devicegroup[i].DeviceID, devicegroup[i].slidergroup[j].Channel);
    end;
  end;
end;

procedure Ttouchscreenform.chantypebtnClick(Sender: TObject);
begin
  paintbox1.Visible:=false;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=true;
  channelboxtimer.enabled:=channelbox.visible;

  ChannelSliderMode:=1;
  RefreshChannelbox;
end;

procedure Ttouchscreenform.SumChanbtnClick(Sender: TObject);
begin
  paintbox1.Visible:=false;
  colorpicker.visible:=false;
  colorsliderpanel.visible:=colorpicker.visible;
  dimmerpanel.Visible:=false;
  fadenkreuz.Visible:=false;
  goborot1slider.visible:=false;
  goborot2slider.visible:=false;
  button1.visible:=false;
  button2.visible:=false;
  zoomlbl.Visible:=false;
  zoomvalue.Visible:=false;
  upbtn.Visible:=false;
  downbtn.Visible:=false;
  channelbox.visible:=true;
  channelboxtimer.enabled:=channelbox.visible;

  ChannelSliderMode:=2;
  RefreshChannelbox;
end;

procedure Ttouchscreenform.ambersliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'a',-1,255-amberslider.position,500);
    end;
  end;
end;

procedure Ttouchscreenform.whitesliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'w',-1,255-whiteslider.position,500);
    end;
  end;
end;

procedure Ttouchscreenform.uvsliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID,'uv',-1,255-uvslider.position,500);
    end;
  end;
end;

end.
