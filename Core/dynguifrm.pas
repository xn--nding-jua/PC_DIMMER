unit dynguifrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, PngBitBtn, ExtCtrls, PngImageList,
  HSLRingPicker, ComCtrls, TiledImage, gnugettext, Math, Mask, JvExMask,
  JvSpin, Registry, GR32, JvExExtCtrls, JvExtComponent, JvPanel,
  JvOfficeColorPanel, HSLColorPicker;

type
  Tdynguiform = class(TForm)
    pnglist: TPngImageCollection;
    Timer1: TTimer;
    strobopanel: TPanel;
    strobo100btn: TPngBitBtn;
    strobo85btn: TPngBitBtn;
    strobo75btn: TPngBitBtn;
    strobo25btn: TPngBitBtn;
    strobo0btn: TPngBitBtn;
    strobeslider: TTrackBar;
    strobeplus: TButton;
    strobeminus: TButton;
    prismapanel: TPanel;
    prismaslider: TTrackBar;
    prismarotplus: TButton;
    prismarotminus: TButton;
    irispanel: TPanel;
    irisslider: TTrackBar;
    irisplus: TButton;
    irisminus: TButton;
    gobopanel: TPanel;
    nextgobo1btn: TPngBitBtn;
    prevgobo1btn: TPngBitBtn;
    nextgobo2btn: TPngBitBtn;
    prevgobo2btn: TPngBitBtn;
    goborot1slider: TTrackBar;
    Button1: TButton;
    goborot2slider: TTrackBar;
    Button2: TButton;
    focuspanel: TPanel;
    fokusslider: TTrackBar;
    fokusplus: TButton;
    fokusminus: TButton;
    dimmerpanel: TPanel;
    dimmerslider: TTrackBar;
    plusbtn: TButton;
    minusbtn: TButton;
    colorpanel: TPanel;
    nextcolor1btn: TPngBitBtn;
    prevcolor1btn: TPngBitBtn;
    nextcolor2btn: TPngBitBtn;
    prevcolor2btn: TPngBitBtn;
    colorpicker: THSLRingPicker;
    xypanel: TPanel;
    fadenkreuz: TPanel;
    TiledImage2: TTiledImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    PositionXY: TShape;
    VertTrack: TTrackBar;
    HorTrack: TTrackBar;
    zoomvalue: TJvSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Button3: TButton;
    colorpicker2: TJvOfficeColorPanel;
    zoompanel: TPanel;
    Shape4: TShape;
    Label9: TLabel;
    zoomslider: TTrackBar;
    zoomplus: TButton;
    zoomminus: TButton;
    Label10: TLabel;
    colorpicker3: THSLColorPicker;
    Shape10: TShape;
    dim100: TPngBitBtn;
    dim75: TPngBitBtn;
    dim50: TPngBitBtn;
    dim25: TPngBitBtn;
    dim0: TPngBitBtn;
    prismatriple: TPngBitBtn;
    prismarotstop: TPngBitBtn;
    prismasingle: TPngBitBtn;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    shutteropenbtn: TPngBitBtn;
    shutterclosebtn: TPngBitBtn;
    PaintBox1: TPaintBox;
    Shape19: TShape;
    Button4: TButton;
    whiteslider: TTrackBar;
    Label11: TLabel;
    amberslider: TTrackBar;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
//    procedure CreateParams(var Params:TCreateParams);override;
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
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
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
    procedure colorpicker2ColorChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure zoomplusClick(Sender: TObject);
    procedure zoomminusClick(Sender: TObject);
    procedure zoomsliderChange(Sender: TObject);
    procedure dim100Click(Sender: TObject);
    procedure dim75Click(Sender: TObject);
    procedure dim50Click(Sender: TObject);
    procedure dim25Click(Sender: TObject);
    procedure dim0Click(Sender: TObject);
    procedure colorpicker3Change(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Shape10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure whitesliderChange(Sender: TObject);
    procedure ambersliderChange(Sender: TObject);
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
    procedure SetPanTilt;
  public
    { Public-Deklarationen }
    mywidth:integer;
    procedure RefreshGoboList;
  end;

var
  dynguiform: Tdynguiform;

implementation

uses PCDIMMER, geraetesteuerungfrm, sidebarfrm, buehnenansicht;

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

procedure Tdynguiform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);

  nextcolor1btn.PngImage:=pnglist.Items.Items[6].PngImage;
  prevcolor1btn.PngImage:=pnglist.Items.Items[5].PngImage;
  nextcolor2btn.PngImage:=pnglist.Items.Items[6].PngImage;
  prevcolor2btn.PngImage:=pnglist.Items.Items[5].PngImage;

  dim100.PngImage:=pnglist.Items.Items[4].PngImage;
  dim75.PngImage:=pnglist.Items.Items[3].PngImage;
  dim50.PngImage:=pnglist.Items.Items[2].PngImage;
  dim25.PngImage:=pnglist.Items.Items[1].PngImage;
  dim0.PngImage:=pnglist.Items.Items[0].PngImage;

  strobo0btn.PngImage:=pnglist.Items.Items[13].PngImage;
  strobo25btn.PngImage:=pnglist.Items.Items[14].PngImage;
  strobo75btn.PngImage:=pnglist.Items.Items[16].PngImage;
  strobo85btn.PngImage:=pnglist.Items.Items[17].PngImage;
  strobo100btn.PngImage:=pnglist.Items.Items[18].PngImage;

  prismatriple.PngImage:=pnglist.Items.Items[12].PngImage;
  prismarotstop.PngImage:=pnglist.Items.Items[8].PngImage;
  prismasingle.PngImage:=pnglist.Items.Items[10].PngImage;

  nextgobo1btn.PngImage:=pnglist.Items.Items[9].PngImage;
  prevgobo1btn.PngImage:=pnglist.Items.Items[7].PngImage;
  nextgobo2btn.PngImage:=pnglist.Items.Items[9].PngImage;
  prevgobo2btn.PngImage:=pnglist.Items.Items[7].PngImage;

  shutteropenbtn.PngImage:=pnglist.Items.Items[4].PngImage;
  shutterclosebtn.PngImage:=pnglist.Items.Items[0].PngImage;

  colorpicker.SelectedColor:=clRed;

  _Buffer:=TBitmap32.Create;
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;
end;

{
procedure Tdynguiform.CreateParams(var Params:TCreateParams);
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
}

procedure Tdynguiform.Timer1Timer(Sender: TObject);
begin
  if paintbox1.visible then
  begin
    RefreshGobolist;
    Timer1.Interval:=1000;
  end;
end;

procedure Tdynguiform.FormShow(Sender: TObject);
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
  			LReg.WriteBool('Showing DynGUI',true);

        if not LReg.KeyExists('DynGUI') then
	        LReg.CreateKey('DynGUI');
	      if LReg.OpenKey('DynGUI',true) then
	      begin
{
          if LReg.ValueExists('Width') then
            dynguiform.ClientWidth:=LReg.ReadInteger('Width')
          else
            dynguiform.ClientWidth:=1073;
          if LReg.ValueExists('Height') then
            dynguiform.ClientHeight:=LReg.ReadInteger('Height')
          else
            dynguiform.ClientHeight:=260;
}
          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+dynguiform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              dynguiform.Left:=LReg.ReadInteger('PosX')
            else
              dynguiform.Left:=0;
          end else
            dynguiform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              dynguiform.Top:=LReg.ReadInteger('PosY')
            else
              dynguiform.Top:=0;
          end else
            dynguiform.Top:=285;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  clientheight:=260;
  clientwidth:=160;

  dynguiform.RefreshGoboList;
end;

procedure Tdynguiform.FormHide(Sender: TObject);
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
          LReg.WriteBool('Showing DynGUI',false);
        end;
      end;
    end;
	end;
end;

procedure Tdynguiform.TiledImage2MouseDown(Sender: TObject;
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

procedure Tdynguiform.TiledImage2MouseMove(Sender: TObject;
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

procedure Tdynguiform.TiledImage2MouseUp(Sender: TObject;
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

procedure Tdynguiform.VertTrackChange(Sender: TObject);
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

procedure Tdynguiform.HorTrackChange(Sender: TObject);
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

procedure Tdynguiform.dimmersliderChange(Sender: TObject);
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

procedure Tdynguiform.shutteropenbtnClick(Sender: TObject);
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

procedure Tdynguiform.shutterclosebtnClick(Sender: TObject);
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

procedure Tdynguiform.strobo100btnClick(Sender: TObject);
begin
  if strobeslider.position=0 then strobesliderChange(nil);
  strobeslider.position:=0;
end;

procedure Tdynguiform.strobo75btnClick(Sender: TObject);
begin
  if strobeslider.position=128 then strobesliderChange(nil);
  strobeslider.position:=128;
end;

procedure Tdynguiform.strobo25btnClick(Sender: TObject);
begin
  if strobeslider.position=192 then strobesliderChange(nil);
  strobeslider.position:=192;
end;

procedure Tdynguiform.strobo0btnClick(Sender: TObject);
begin
  if strobeslider.position=255 then strobesliderChange(nil);
  strobeslider.position:=255;
end;

procedure Tdynguiform.nextgobo1btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].gobos)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO1');

      for j:=0 to length(mainform.devices[i].gobos)-1 do
      begin
        if (value>=mainform.devices[i].gobolevels[j]) and (value<=mainform.Devices[i].goboendlevels[j]) then
        begin
          if j<length(mainform.devices[i].gobos) then
            value:=j+1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[value], 0, 0);
    end;
  end;

  grafischebuehnenansicht.doimmediaterefresh:=true;
end;

procedure Tdynguiform.nextcolor1btnClick(Sender: TObject);
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

procedure Tdynguiform.nextcolor2btnClick(Sender: TObject);
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

procedure Tdynguiform.nextgobo2btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].gobos2)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO2');

      for j:=0 to length(mainform.devices[i].gobos2)-1 do
      begin
        if (value>=mainform.devices[i].gobolevels2[j]) and (value<=mainform.Devices[i].goboendlevels2[j]) then
        begin
          if j<length(mainform.devices[i].gobos2) then
            value:=j+1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, mainform.devices[i].gobolevels2[value], 0, 0);
    end;
  end;

  grafischebuehnenansicht.doimmediaterefresh:=true;
end;

procedure Tdynguiform.prevgobo1btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].gobos)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO1');

      for j:=0 to length(mainform.devices[i].gobos)-1 do
      begin
        if (value>=mainform.devices[i].gobolevels[j]) and (value<=mainform.Devices[i].goboendlevels[j]) then
        begin
          if j>0 then
            value:=j-1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO1', -1, mainform.devices[i].gobolevels[value], 0, 0);
    end;
  end;

  grafischebuehnenansicht.doimmediaterefresh:=true;
end;

procedure Tdynguiform.prevgobo2btnClick(Sender: TObject);
var
  i, j, value:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      if length(mainform.devices[i].gobos2)=0 then
        continue;

      value:=geraetesteuerung.get_channel(mainform.devices[i].ID, 'GOBO2');

      for j:=0 to length(mainform.devices[i].gobos2)-1 do
      begin
        if (value>=mainform.devices[i].gobolevels2[j]) and (value<=mainform.Devices[i].goboendlevels2[j]) then
        begin
          if j>0 then
            value:=j-1
          else
            value:=j;
          break;
        end;
      end;

      geraetesteuerung.set_channel(mainform.devices[i].ID, 'GOBO2', -1, mainform.devices[i].gobolevels2[value], 0, 0);
    end;
  end;

  grafischebuehnenansicht.doimmediaterefresh:=true;
end;

procedure Tdynguiform.prevcolor1btnClick(Sender: TObject);
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

procedure Tdynguiform.prevcolor2btnClick(Sender: TObject);
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

procedure Tdynguiform.colorpickerChange(Sender: TObject);
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

procedure Tdynguiform.SetPanTilt;
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

procedure Tdynguiform.PositionXYMouseMove(Sender: TObject;
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

procedure Tdynguiform.PositionXYMouseUp(Sender: TObject;
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

procedure Tdynguiform.RefreshGoboList;
var
  i,j:integer;
  rect:Trect;
  GobosPerRow:integer;
begin
  GobosPerRow:=trunc(Paintbox1.width/32);

  _Buffer.Canvas.Brush.Color:=clBlack;
  _Buffer.Canvas.Rectangle(0, 0, _Buffer.Width, _Buffer.Height);

  GoboOffset:=0;

  setlength(GoboButtons, 0);
  for i:=GoboOffset to length(sidebarform.GoboList)-1 do
  begin
    if (i>(80+GoboOffset)) or (i>=length(sidebarform.GoboList)) then break; // nur maximal 30 Gobos anzeigen

    for j:=0 to mainform.GoboPictures.Items.Count-1 do
    begin
      if sidebarform.GoboList[i]=mainform.GoboPictures.Items.Items[j].Name then
      begin
        rect.Left:=(i-GoboOffset)*32-(trunc((i-GoboOffset)/GobosPerRow)*(GobosPerRow*32));
        rect.Top:=trunc((i-GoboOffset)/GobosPerRow)*32;
        rect.Right:=((i-GoboOffset)*32-(trunc((i-GoboOffset)/GobosPerRow)*(GobosPerRow*32))+32);
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

procedure Tdynguiform.PaintBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, j, k, OverGoboButton, GobosPerRow:integer;
  BestGobo1, BestGobo2:integer;
  MaxValueGobo1, MaxValueGobo2:single;
begin
  GobosPerRow:=trunc(Paintbox1.width/32);

  OverGoboButton:=(trunc(X/32)+1)+(trunc(Y/32)*GobosPerRow)-1+GoboOffset;

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

  grafischebuehnenansicht.doimmediaterefresh:=true;
end;

procedure Tdynguiform.FormResize(Sender: TObject);
begin
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;
end;

procedure Tdynguiform.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
//  Resize:=(NewHeight=260) and (NewWidth>250)
end;

procedure Tdynguiform.goborot1sliderChange(Sender: TObject);
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

procedure Tdynguiform.Button1Click(Sender: TObject);
begin
  goborot1slider.position:=127;
end;

procedure Tdynguiform.Button2Click(Sender: TObject);
begin
  goborot2slider.position:=127;
end;

procedure Tdynguiform.goborot2sliderChange(Sender: TObject);
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

procedure Tdynguiform.strobesliderChange(Sender: TObject);
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

procedure Tdynguiform.irissliderChange(Sender: TObject);
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

procedure Tdynguiform.prismasliderChange(Sender: TObject);
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

procedure Tdynguiform.prismasingleMouseUp(Sender: TObject;
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

procedure Tdynguiform.strobo85btnClick(Sender: TObject);
begin
  if strobeslider.position=64 then strobesliderChange(nil);
  strobeslider.position:=64;
end;

procedure Tdynguiform.minusbtnClick(Sender: TObject);
begin
  dimmerslider.position:=dimmerslider.position+25
end;

procedure Tdynguiform.irisminusClick(Sender: TObject);
begin
  irisslider.position:=irisslider.position+25
end;

procedure Tdynguiform.prismarotminusClick(Sender: TObject);
begin
  prismaslider.position:=prismaslider.position+25
end;

procedure Tdynguiform.prismasingleClick(Sender: TObject);
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

procedure Tdynguiform.prismatripleClick(Sender: TObject);
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

procedure Tdynguiform.prismarotstopClick(Sender: TObject);
begin
  prismaslider.Position:=127;
end;

procedure Tdynguiform.prismarotplusClick(Sender: TObject);
begin
  prismaslider.position:=prismaslider.position-25
end;

procedure Tdynguiform.strobeplusClick(Sender: TObject);
begin
  strobeslider.position:=strobeslider.position-25
end;

procedure Tdynguiform.strobeminusClick(Sender: TObject);
begin
  strobeslider.position:=strobeslider.position+25
end;

procedure Tdynguiform.irisplusClick(Sender: TObject);
begin
  irisslider.position:=irisslider.position-25
end;

procedure Tdynguiform.plusbtnClick(Sender: TObject);
begin
  dimmerslider.position:=dimmerslider.position-25
end;

procedure Tdynguiform.fokussliderChange(Sender: TObject);
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

procedure Tdynguiform.fokusplusClick(Sender: TObject);
begin
  fokusslider.position:=fokusslider.position-25
end;

procedure Tdynguiform.fokusminusClick(Sender: TObject);
begin
  fokusslider.position:=fokusslider.position+25
end;

procedure Tdynguiform.colorpicker2ColorChange(Sender: TObject);
var
  i:integer;
  R,G,B:byte;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      TColor2RGB(colorpicker2.SelectedColor, R, G, B);
      geraetesteuerung.set_color(mainform.devices[i].ID, R, G, B, 500, 0);
    end;
  end;
end;

procedure Tdynguiform.Button3Click(Sender: TObject);
begin
  if colorpicker.Visible then
  begin
    colorpicker.Visible:=false;
    colorpicker2.Visible:=true;
    colorpicker3.Visible:=false;
  end else if colorpicker2.Visible then
  begin
    colorpicker.Visible:=false;
    colorpicker2.Visible:=false;
    colorpicker3.Visible:=true;
  end else if colorpicker3.Visible then
  begin
    colorpicker.Visible:=true;
    colorpicker2.Visible:=false;
    colorpicker3.Visible:=false;
  end;
end;

procedure Tdynguiform.zoomplusClick(Sender: TObject);
begin
  zoomslider.position:=zoomslider.position-25
end;

procedure Tdynguiform.zoomminusClick(Sender: TObject);
begin
  zoomslider.position:=zoomslider.position+25
end;

procedure Tdynguiform.zoomsliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'ZOOM', -1, 255-irisslider.position, 0);
    end;
  end;
end;

procedure Tdynguiform.dim100Click(Sender: TObject);
begin
  if dimmerslider.position=0 then dimmersliderChange(nil);
  dimmerslider.position:=0;
end;

procedure Tdynguiform.dim75Click(Sender: TObject);
begin
  if dimmerslider.position=64 then dimmersliderChange(nil);
  dimmerslider.position:=64;
end;

procedure Tdynguiform.dim50Click(Sender: TObject);
begin
  if dimmerslider.position=128 then dimmersliderChange(nil);
  dimmerslider.position:=128;
end;

procedure Tdynguiform.dim25Click(Sender: TObject);
begin
  if dimmerslider.position=192 then dimmersliderChange(nil);
  dimmerslider.position:=192;
end;

procedure Tdynguiform.dim0Click(Sender: TObject);
begin
  if dimmerslider.position=255 then dimmersliderChange(nil);
  dimmerslider.position:=255;
end;

procedure Tdynguiform.colorpicker3Change(Sender: TObject);
var
  i:integer;
  R,G,B:byte;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      TColor2RGB(colorpicker3.SelectedColor, R, G, B);
      geraetesteuerung.set_color(mainform.devices[i].ID, R, G, B, 500, 0);
    end;
  end;
end;

procedure Tdynguiform.FormClick(Sender: TObject);
begin
  if dynguiform.BorderStyle=bsSingle then
  begin
    dynguiform.BorderStyle:=bsNone;
    dynguiform.Align:=alBottom;
    dynguiform.ClientHeight:=260;
  end else
  begin
    dynguiform.BorderStyle:=bsSingle;
    dynguiform.Align:=alNone;
    dynguiform.ClientHeight:=260;
    dynguiform.ClientWidth:=mywidth;
  end;
end;

procedure Tdynguiform.Shape10MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FormClick(sender);
end;

procedure Tdynguiform.Button4Click(Sender: TObject);
begin
  if gobopanel.Width<496 then
  begin
    gobopanel.Width:=496;
    paintbox1.Width:=330;
    button4.Caption:='<';
    button4.left:=472;
    dynguiform.ClientWidth:=dynguiform.ClientWidth+200;
  end else
  begin
    gobopanel.Width:=296;
    paintbox1.Width:=130;
    button4.Caption:='>';
    button4.left:=272;
    dynguiform.ClientWidth:=dynguiform.ClientWidth-200;
  end;

  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;

  RefreshGobolist;
end;

procedure Tdynguiform.whitesliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'W', -1, 255-whiteslider.position, 500);
    end;
  end;
end;

procedure Tdynguiform.ambersliderChange(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to length(mainform.Devices)-1 do
  begin
    if mainform.DeviceSelected[i] then
    begin
      geraetesteuerung.set_channel(mainform.Devices[i].ID, 'A', -1, 255-amberslider.position, 500);
    end;
  end;
end;

end.
