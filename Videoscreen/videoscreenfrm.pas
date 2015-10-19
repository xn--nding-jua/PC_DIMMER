unit videoscreenfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DSUtil, DirectShow9, ComCtrls, Menus, ExtCtrls, StdCtrls, Buttons, PngBitBtn,
  ToolWin;

type
  Tvideoscreenform = class(TForm)
    MainMenu1: TMainMenu;
    FilterGraph1: TFilterGraph;
    OpenVideoDialog: TOpenDialog;
    N3: TMenuItem;
    Logfileeinsehen1: TMenuItem;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Videoffnen2: TMenuItem;
    N4: TMenuItem;
    Abspielen2: TMenuItem;
    Pause2: TMenuItem;
    Stop2: TMenuItem;
    N5: TMenuItem;
    Vollbild2: TMenuItem;
    KeepAspectRatio1: TMenuItem;
    Stumm2: TMenuItem;
    WasbringtderVideoscreen1: TMenuItem;
    Filter2: TFilter;
    SampleGrabber2: TSampleGrabber;
    N7: TMenuItem;
    Anzeigeschlieen2: TMenuItem;
    Einstellungen1: TMenuItem;
    FilterGraph2: TFilterGraph;
    PopupMenu2: TPopupMenu;
    SampleGrabber1: TSampleGrabber;
    Filter1: TFilter;
    FilterGraph3: TFilterGraph;
    SampleGrabber3: TSampleGrabber;
    Filter3: TFilter;
    PopupMenu3: TPopupMenu;
    FilterGraph4: TFilterGraph;
    SampleGrabber4: TSampleGrabber;
    Filter4: TFilter;
    PopupMenu4: TPopupMenu;
    Videoffnen3: TMenuItem;
    N8: TMenuItem;
    Abspielen3: TMenuItem;
    Pause3: TMenuItem;
    Stop3: TMenuItem;
    N9: TMenuItem;
    Vollbild3: TMenuItem;
    KeepAspectRatio2: TMenuItem;
    Stumm3: TMenuItem;
    N10: TMenuItem;
    Videoschlieen1: TMenuItem;
    Videoffnen4: TMenuItem;
    N11: TMenuItem;
    Abspielen4: TMenuItem;
    Pause4: TMenuItem;
    Stop4: TMenuItem;
    N12: TMenuItem;
    Vollbild4: TMenuItem;
    KeepAspectRatio3: TMenuItem;
    Stumm4: TMenuItem;
    N13: TMenuItem;
    Videoschlieen2: TMenuItem;
    Videoffnen5: TMenuItem;
    N14: TMenuItem;
    Abspielen5: TMenuItem;
    Pause5: TMenuItem;
    Stop5: TMenuItem;
    N15: TMenuItem;
    Vollbild5: TMenuItem;
    KeepAspectRatio4: TMenuItem;
    Stumm5: TMenuItem;
    N16: TMenuItem;
    Videoschlieen3: TMenuItem;
    Videobild41: TMenuItem;
    Videobild42: TMenuItem;
    Videobild43: TMenuItem;
    Videobild44: TMenuItem;
    SingleView: TMenuItem;
    DoubleView: TMenuItem;
    QuadView: TMenuItem;
    Videopanel1: TPanel;
    Panel5: TPanel;
    TimeLabel1: TLabel;
    Timelabelms1: TLabel;
    Panel2: TPanel;
    DSTrackBar1: TDSTrackBar;
    VideoWindow1: TVideoWindow;
    VideoINKamera1: TMenuItem;
    VideoINKamera2: TMenuItem;
    VideoINKamera3: TMenuItem;
    VideoINKamera4: TMenuItem;
    Videopanel2: TPanel;
    Panel4: TPanel;
    Timelabel2: TLabel;
    Timelabelms2: TLabel;
    Panel6: TPanel;
    DSTrackBar2: TDSTrackBar;
    VideoWindow2: TVideoWindow;
    Videopanel3: TPanel;
    Panel7: TPanel;
    Timelabel3: TLabel;
    Timelabelms3: TLabel;
    Panel8: TPanel;
    DSTrackBar3: TDSTrackBar;
    VideoWindow3: TVideoWindow;
    Videopanel4: TPanel;
    Panel9: TPanel;
    Timelabel4: TLabel;
    Timelabelms4: TLabel;
    Panel10: TPanel;
    DSTrackBar4: TDSTrackBar;
    VideoWindow4: TVideoWindow;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    procedure Logfileeinsehen1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure VideoWindow1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VideoWindow2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VideoWindow3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VideoWindow4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VideoWindow1DblClick(Sender: TObject);
    procedure VideoWindow2DblClick(Sender: TObject);
    procedure VideoWindow3DblClick(Sender: TObject);
    procedure VideoWindow4DblClick(Sender: TObject);
    procedure FilterGraph1DSEvent(sender: TComponent; Event, Param1,
      Param2: Integer);
    procedure WasbringtderVideoscreen1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnSelectDevice1(sender: TObject);
    procedure OnSelectDevice2(sender: TObject);
    procedure OnSelectDevice3(sender: TObject);
    procedure OnSelectDevice4(sender: TObject);
    procedure Anzeigeschlieen1Click(Sender: TObject);
    procedure Anzeigeschlieen2Click(Sender: TObject);
    procedure Anzeigeschlieen3Click(Sender: TObject);
    procedure Anzeigeschlieen4Click(Sender: TObject);
    procedure Videoffnen2Click(Sender: TObject);
    procedure Videoffnen3Click(Sender: TObject);
    procedure Videoffnen4Click(Sender: TObject);
    procedure Videoffnen5Click(Sender: TObject);
    procedure Stumm2Click(Sender: TObject);
    procedure Stumm3Click(Sender: TObject);
    procedure Stumm4Click(Sender: TObject);
    procedure Stumm5Click(Sender: TObject);
    procedure KeepAspectRatio1Click(Sender: TObject);
    procedure KeepAspectRatio2Click(Sender: TObject);
    procedure KeepAspectRatio3Click(Sender: TObject);
    procedure KeepAspectRatio4Click(Sender: TObject);
    procedure Vollbild2Click(Sender: TObject);
    procedure Vollbild3Click(Sender: TObject);
    procedure Vollbild4Click(Sender: TObject);
    procedure Vollbild5Click(Sender: TObject);
    procedure Abspielen2Click(Sender: TObject);
    procedure Abspielen3Click(Sender: TObject);
    procedure Abspielen4Click(Sender: TObject);
    procedure Abspielen5Click(Sender: TObject);
    procedure Pause2Click(Sender: TObject);
    procedure Pause3Click(Sender: TObject);
    procedure Pause4Click(Sender: TObject);
    procedure Pause5Click(Sender: TObject);
    procedure Stop2Click(Sender: TObject);
    procedure Stop3Click(Sender: TObject);
    procedure Stop4Click(Sender: TObject);
    procedure Stop5Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SingleViewClick(Sender: TObject);
    procedure DoubleViewClick(Sender: TObject);
    procedure QuadViewClick(Sender: TObject);
  private
    { Private-Deklarationen }
    log:string;
  public
    { Public-Deklarationen }
    procedure SetVideoPosition(Screen:Byte; NewPosition:Integer);
    function GetPositionInMilliseconds(Screen:Byte):integer;
  end;

var
  videoscreenform: Tvideoscreenform;
  SysDev: TSysDevEnum;

implementation

{$R *.dfm}

procedure Tvideoscreenform.Logfileeinsehen1Click(Sender: TObject);
begin
  ShowMessage(log);
end;

procedure Tvideoscreenform.SetVideoPosition(Screen:Byte; NewPosition:Integer);
var
  CurrentPos, StopPos: int64;
begin
  case screen of
    1:
    begin
      (FilterGraph1 as IMediaSeeking).GetCurrentPosition(CurrentPos);
      (FilterGraph1 as IMediaSeeking).GetStopPosition(StopPos);
       CurrentPos:=MiliSecToRefTime(NewPosition);
      (FilterGraph1 as IMediaSeeking).SetPositions(CurrentPos, AM_SEEKING_AbsolutePositioning, StopPos, AM_SEEKING_NoPositioning);
    end;
    2:
    begin
      (FilterGraph2 as IMediaSeeking).GetCurrentPosition(CurrentPos);
      (FilterGraph2 as IMediaSeeking).GetStopPosition(StopPos);
       CurrentPos:=MiliSecToRefTime(NewPosition);
      (FilterGraph2 as IMediaSeeking).SetPositions(CurrentPos, AM_SEEKING_AbsolutePositioning, StopPos, AM_SEEKING_NoPositioning);
    end;
    3:
    begin
      (FilterGraph3 as IMediaSeeking).GetCurrentPosition(CurrentPos);
      (FilterGraph3 as IMediaSeeking).GetStopPosition(StopPos);
       CurrentPos:=MiliSecToRefTime(NewPosition);
      (FilterGraph3 as IMediaSeeking).SetPositions(CurrentPos, AM_SEEKING_AbsolutePositioning, StopPos, AM_SEEKING_NoPositioning);
    end;
    4:
    begin
      (FilterGraph4 as IMediaSeeking).GetCurrentPosition(CurrentPos);
      (FilterGraph4 as IMediaSeeking).GetStopPosition(StopPos);
       CurrentPos:=MiliSecToRefTime(NewPosition);
      (FilterGraph4 as IMediaSeeking).SetPositions(CurrentPos, AM_SEEKING_AbsolutePositioning, StopPos, AM_SEEKING_NoPositioning);
    end;
  end;
end;

procedure Tvideoscreenform.Timer1Timer(Sender: TObject);
var
  CurrentPos, StopPos: int64;
begin
  if FilterGraph1.Active and (FilterGraph1.Mode=gmNormal) then
  begin
    (FilterGraph1 as IMediaSeeking).GetCurrentPosition(CurrentPos);
    (FilterGraph1 as IMediaSeeking).GetStopPosition(StopPos);
    Timelabelms1.Caption:=inttostr(RefTimeToMiliSec(CurrentPos))+'ms';
  end;
  if FilterGraph2.Active and (FilterGraph2.Mode=gmNormal) then
  begin
    (FilterGraph2 as IMediaSeeking).GetCurrentPosition(CurrentPos);
    (FilterGraph2 as IMediaSeeking).GetStopPosition(StopPos);
    Timelabelms2.Caption:=inttostr(RefTimeToMiliSec(CurrentPos))+'ms';
  end;
  if FilterGraph3.Active and (FilterGraph3.Mode=gmNormal) then
  begin
    (FilterGraph3 as IMediaSeeking).GetCurrentPosition(CurrentPos);
    (FilterGraph3 as IMediaSeeking).GetStopPosition(StopPos);
    Timelabelms3.Caption:=inttostr(RefTimeToMiliSec(CurrentPos))+'ms';
  end;
  if FilterGraph4.Active and (FilterGraph4.Mode=gmNormal) then
  begin
    (FilterGraph4 as IMediaSeeking).GetCurrentPosition(CurrentPos);
    (FilterGraph4 as IMediaSeeking).GetStopPosition(StopPos);
    Timelabelms4.Caption:=inttostr(RefTimeToMiliSec(CurrentPos))+'ms';
  end;
end;

procedure Tvideoscreenform.FormShow(Sender: TObject);
begin
  if SingleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=false;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if DoubleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if QuadView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=true;
    Videopanel4.Visible:=true;
  end;

  Timer1.enabled:=true;
end;

procedure Tvideoscreenform.FormHide(Sender: TObject);
begin
  Timer1.enabled:=false;
end;

procedure Tvideoscreenform.VideoWindow1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    VideoWindow1.FullScreen:=false;
end;

procedure Tvideoscreenform.VideoWindow2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    VideoWindow2.FullScreen:=false;
end;

procedure Tvideoscreenform.VideoWindow3KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    VideoWindow3.FullScreen:=false;
end;

procedure Tvideoscreenform.VideoWindow4KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_escape then
    VideoWindow4.FullScreen:=false;
end;

procedure Tvideoscreenform.VideoWindow1DblClick(Sender: TObject);
begin
  VideoWindow1.FullScreen:=not VideoWindow1.FullScreen;
end;

procedure Tvideoscreenform.VideoWindow2DblClick(Sender: TObject);
begin
  VideoWindow2.FullScreen:=not VideoWindow2.FullScreen;
end;

procedure Tvideoscreenform.VideoWindow3DblClick(Sender: TObject);
begin
  VideoWindow3.FullScreen:=not VideoWindow3.FullScreen;
end;

procedure Tvideoscreenform.VideoWindow4DblClick(Sender: TObject);
begin
  VideoWindow4.FullScreen:=not VideoWindow4.FullScreen;
end;

procedure Tvideoscreenform.FilterGraph1DSEvent(sender: TComponent; Event,
  Param1, Param2: Integer);
begin
  log:=log+#13+#10+(GetEventCodeDef(event));
end;

procedure Tvideoscreenform.WasbringtderVideoscreen1Click(Sender: TObject);
begin
  ShowMessage('Für die Programmierung einer Lichtshow für eine bereits feststehende choreografische Darstellung kann der Videoscreen dazu benutzt werden, eine vorhandene Videoaufzeichnung des Tanzes zeitgleich mit dem Audioeffektplayer ablaufen zu lassen.'+#13#10#13#10+'Über die Befehle kann der Videoscreen direkt aus der Timeline des Audioeffektplayers gesteuert werden, sodass das Videobild perfekt auf die Lichtshow abgestimmt werden kann.');
end;

procedure Tvideoscreenform.FormCreate(Sender: TObject);
var
  i: integer;
  Device: TMenuItem;
begin
  SysDev:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);
  if SysDev.CountFilters > 0 then
    for i := 0 to SysDev.CountFilters - 1 do
    begin
      Device := TMenuItem.Create(VideoINKamera1);
      Device.Caption := SysDev.Filters[i].FriendlyName;
      Device.Tag := i;
      Device.OnClick := OnSelectDevice1;
      VideoINKamera1.Add(Device);

      Device := TMenuItem.Create(VideoINKamera2);
      Device.Caption := SysDev.Filters[i].FriendlyName;
      Device.Tag := i;
      Device.OnClick := OnSelectDevice2;
      VideoINKamera2.Add(Device);

      Device := TMenuItem.Create(VideoINKamera3);
      Device.Caption := SysDev.Filters[i].FriendlyName;
      Device.Tag := i;
      Device.OnClick := OnSelectDevice3;
      VideoINKamera3.Add(Device);

      Device := TMenuItem.Create(VideoINKamera4);
      Device.Caption := SysDev.Filters[i].FriendlyName;
      Device.Tag := i;
      Device.OnClick := OnSelectDevice4;
      VideoINKamera4.Add(Device);
    end;
    VideoINKamera1.Visible:=(VideoINKamera1.Count>0);
    VideoINKamera2.Visible:=(VideoINKamera2.Count>0);
    VideoINKamera3.Visible:=(VideoINKamera3.Count>0);
    VideoINKamera4.Visible:=(VideoINKamera4.Count>0);
end;

procedure Tvideoscreenform.OnSelectDevice1(sender: TObject);
begin
  FilterGraph1.Mode:=gmCapture;
  FilterGraph1.ClearGraph;
  FilterGraph1.Active := false;
  Filter1.BaseFilter.Moniker := SysDev.GetMoniker(TMenuItem(Sender).tag);
  FilterGraph1.Active := true;
  with FilterGraph1 as ICaptureGraphBuilder2 do
    RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter1 as IBaseFilter, SampleGrabber1 as IBaseFilter, VideoWindow1 as IbaseFilter);
  FilterGraph1.Play;
end;

procedure Tvideoscreenform.OnSelectDevice2(sender: TObject);
begin
  FilterGraph2.Mode:=gmCapture;
  FilterGraph2.ClearGraph;
  FilterGraph2.Active := false;
  Filter2.BaseFilter.Moniker := SysDev.GetMoniker(TMenuItem(Sender).tag);
  FilterGraph2.Active := true;
  with FilterGraph2 as ICaptureGraphBuilder2 do
    RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter2 as IBaseFilter, SampleGrabber2 as IBaseFilter, VideoWindow2 as IbaseFilter);
  FilterGraph2.Play;
end;

procedure Tvideoscreenform.OnSelectDevice3(sender: TObject);
begin
  FilterGraph3.Mode:=gmCapture;
  FilterGraph3.ClearGraph;
  FilterGraph3.Active := false;
  Filter3.BaseFilter.Moniker := SysDev.GetMoniker(TMenuItem(Sender).tag);
  FilterGraph3.Active := true;
  with FilterGraph3 as ICaptureGraphBuilder2 do
    RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter3 as IBaseFilter, SampleGrabber3 as IBaseFilter, VideoWindow3 as IbaseFilter);
  FilterGraph3.Play;
end;

procedure Tvideoscreenform.OnSelectDevice4(sender: TObject);
begin
  FilterGraph4.Mode:=gmCapture;
  FilterGraph4.ClearGraph;
  FilterGraph4.Active := false;
  Filter4.BaseFilter.Moniker := SysDev.GetMoniker(TMenuItem(Sender).tag);
  FilterGraph4.Active := true;
  with FilterGraph4 as ICaptureGraphBuilder2 do
    RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter4 as IBaseFilter, SampleGrabber4 as IBaseFilter, VideoWindow4 as IbaseFilter);
  FilterGraph4.Play;
end;

procedure Tvideoscreenform.Anzeigeschlieen1Click(Sender: TObject);
begin
  FilterGraph1.ClearGraph;
  FilterGraph1.Active := false;
end;

procedure Tvideoscreenform.Anzeigeschlieen2Click(Sender: TObject);
begin
  FilterGraph2.ClearGraph;
  FilterGraph2.Active := false;
end;

procedure Tvideoscreenform.Anzeigeschlieen3Click(Sender: TObject);
begin
  FilterGraph3.ClearGraph;
  FilterGraph3.Active := false;
end;

procedure Tvideoscreenform.Anzeigeschlieen4Click(Sender: TObject);
begin
  FilterGraph4.ClearGraph;
  FilterGraph4.Active := false;
end;

procedure Tvideoscreenform.Videoffnen2Click(Sender: TObject);
begin
  if OpenVideoDialog.Execute then
  begin
    FilterGraph1.Mode:=gmNormal;
    if not FilterGraph1.Active then FilterGraph1.Active := true;
    FilterGraph1.ClearGraph;
    FilterGraph1.RenderFile(OpenVideoDialog.FileName);
  end;
end;

procedure Tvideoscreenform.Videoffnen3Click(Sender: TObject);
begin
  if OpenVideoDialog.Execute then
  begin
    FilterGraph2.Mode:=gmNormal;
    if not FilterGraph2.Active then FilterGraph2.Active := true;
    FilterGraph2.ClearGraph;
    FilterGraph2.RenderFile(OpenVideoDialog.FileName);
  end;
end;

procedure Tvideoscreenform.Videoffnen4Click(Sender: TObject);
begin
  if OpenVideoDialog.Execute then
  begin
    FilterGraph3.Mode:=gmNormal;
    if not FilterGraph3.Active then FilterGraph3.Active := true;
    FilterGraph3.ClearGraph;
    FilterGraph3.RenderFile(OpenVideoDialog.FileName);
  end;
end;

procedure Tvideoscreenform.Videoffnen5Click(Sender: TObject);
begin
  if OpenVideoDialog.Execute then
  begin
    FilterGraph4.Mode:=gmNormal;
    if not FilterGraph4.Active then FilterGraph4.Active := true;
    FilterGraph4.ClearGraph;
    FilterGraph4.RenderFile(OpenVideoDialog.FileName);
  end;
end;

procedure Tvideoscreenform.Stumm2Click(Sender: TObject);
begin
  if FilterGraph1.Volume = 0 then
  begin
    FilterGraph1.Volume := 10000;
    Stumm2.checked:=false;
  end else
  begin
    FilterGraph1.Volume := 0;
    Stumm2.checked:=true;
  end;
end;

procedure Tvideoscreenform.Stumm3Click(Sender: TObject);
begin
  if FilterGraph2.Volume = 0 then
  begin
    FilterGraph2.Volume := 10000;
    Stumm3.checked:=false;
  end else
  begin
    FilterGraph2.Volume := 0;
    Stumm3.checked:=true;
  end;
end;

procedure Tvideoscreenform.Stumm4Click(Sender: TObject);
begin
  if FilterGraph3.Volume = 0 then
  begin
    FilterGraph3.Volume := 10000;
    Stumm4.checked:=false;
  end else
  begin
    FilterGraph3.Volume := 0;
    Stumm4.checked:=true;
  end;
end;

procedure Tvideoscreenform.Stumm5Click(Sender: TObject);
begin
  if FilterGraph4.Volume = 0 then
  begin
    FilterGraph4.Volume := 10000;
    Stumm5.checked:=false;
  end else
  begin
    FilterGraph4.Volume := 0;
    Stumm5.checked:=true;
  end;
end;

procedure Tvideoscreenform.KeepAspectRatio1Click(Sender: TObject);
begin
  if VideoWindow1.VMROptions.KeepAspectRatio then
  begin
    VideoWindow1.VMROptions.KeepAspectRatio:=false;
    KeepAspectRatio1.Checked:=false;
  end else
  begin
    VideoWindow1.VMROptions.KeepAspectRatio:=true;
    KeepAspectRatio1.Checked:=true;
  end;
end;

procedure Tvideoscreenform.KeepAspectRatio2Click(Sender: TObject);
begin
  if VideoWindow2.VMROptions.KeepAspectRatio then
  begin
    VideoWindow2.VMROptions.KeepAspectRatio:=false;
    KeepAspectRatio2.Checked:=false;
  end else
  begin
    VideoWindow2.VMROptions.KeepAspectRatio:=true;
    KeepAspectRatio2.Checked:=true;
  end;
end;

procedure Tvideoscreenform.KeepAspectRatio3Click(Sender: TObject);
begin
  if VideoWindow3.VMROptions.KeepAspectRatio then
  begin
    VideoWindow3.VMROptions.KeepAspectRatio:=false;
    KeepAspectRatio3.Checked:=false;
  end else
  begin
    VideoWindow3.VMROptions.KeepAspectRatio:=true;
    KeepAspectRatio3.Checked:=true;
  end;
end;

procedure Tvideoscreenform.KeepAspectRatio4Click(Sender: TObject);
begin
  if VideoWindow4.VMROptions.KeepAspectRatio then
  begin
    VideoWindow4.VMROptions.KeepAspectRatio:=false;
    KeepAspectRatio4.Checked:=false;
  end else
  begin
    VideoWindow4.VMROptions.KeepAspectRatio:=true;
    KeepAspectRatio4.Checked:=true;
  end;
end;

procedure Tvideoscreenform.Vollbild2Click(Sender: TObject);
begin
  VideoWindow1.FullScreen:=not VideoWindow1.FullScreen;
end;

procedure Tvideoscreenform.Vollbild3Click(Sender: TObject);
begin
  VideoWindow2.FullScreen:=not VideoWindow2.FullScreen;
end;

procedure Tvideoscreenform.Vollbild4Click(Sender: TObject);
begin
  VideoWindow3.FullScreen:=not VideoWindow3.FullScreen;
end;

procedure Tvideoscreenform.Vollbild5Click(Sender: TObject);
begin
  VideoWindow4.FullScreen:=not VideoWindow4.FullScreen;
end;

procedure Tvideoscreenform.Abspielen2Click(Sender: TObject);
begin
  FilterGraph1.play;
end;

procedure Tvideoscreenform.Abspielen3Click(Sender: TObject);
begin
  FilterGraph2.play;
end;

procedure Tvideoscreenform.Abspielen4Click(Sender: TObject);
begin
  FilterGraph3.play;
end;

procedure Tvideoscreenform.Abspielen5Click(Sender: TObject);
begin
  FilterGraph4.play;
end;

procedure Tvideoscreenform.Pause2Click(Sender: TObject);
begin
  FilterGraph1.Pause;
end;

procedure Tvideoscreenform.Pause3Click(Sender: TObject);
begin
  FilterGraph2.Pause;
end;

procedure Tvideoscreenform.Pause4Click(Sender: TObject);
begin
  FilterGraph3.Pause;
end;

procedure Tvideoscreenform.Pause5Click(Sender: TObject);
begin
  FilterGraph4.Pause;
end;

procedure Tvideoscreenform.Stop2Click(Sender: TObject);
begin
  FilterGraph1.Stop;
  SetVideoPosition(1,0);
  DSTrackbar1.Position:=0;
end;

procedure Tvideoscreenform.Stop3Click(Sender: TObject);
begin
  FilterGraph2.Stop;
  SetVideoPosition(2,0);
  DSTrackbar2.Position:=0;
end;

procedure Tvideoscreenform.Stop4Click(Sender: TObject);
begin
  FilterGraph3.Stop;
  SetVideoPosition(3,0);
  DSTrackbar3.Position:=0;
end;

procedure Tvideoscreenform.Stop5Click(Sender: TObject);
begin
  FilterGraph4.Stop;
  SetVideoPosition(4,0);
  DSTrackbar4.Position:=0;
end;

procedure Tvideoscreenform.FormResize(Sender: TObject);
begin
  if SingleView.Checked then
  begin
    Videopanel1.Width:=Videoscreenform.ClientWidth;
    Videopanel1.Height:=Videoscreenform.ClientHeight;
  end else
  if DoubleView.Checked then
  begin
    Videopanel1.Width:=(Videoscreenform.ClientWidth-10) div 2;
    Videopanel2.Width:=(Videoscreenform.ClientWidth-10) div 2;
    Videopanel1.Height:=Videoscreenform.ClientHeight;
    Videopanel2.Height:=Videoscreenform.ClientHeight;

    Videopanel2.Left:=5+Videopanel2.Width;
  end else
  if QuadView.Checked then
  begin
    Videopanel1.Width:=(Videoscreenform.ClientWidth-10) div 2;
    Videopanel2.Width:=(Videoscreenform.ClientWidth-10) div 2;
    Videopanel3.Width:=(Videoscreenform.ClientWidth-10) div 2;
    Videopanel4.Width:=(Videoscreenform.ClientWidth-10) div 2;
    Videopanel1.Height:=(Videoscreenform.ClientHeight-10) div 2;
    Videopanel2.Height:=(Videoscreenform.ClientHeight-10) div 2;
    Videopanel3.Height:=(Videoscreenform.ClientHeight-10) div 2;
    Videopanel4.Height:=(Videoscreenform.ClientHeight-10) div 2;

    Videopanel2.Left:=5+Videopanel1.Width;
    Videopanel4.Left:=5+Videopanel4.Width;
    Videopanel3.Top:=5+Videopanel1.Height;
    Videopanel4.Top:=5+Videopanel2.Height;
  end;
end;

procedure Tvideoscreenform.SingleViewClick(Sender: TObject);
begin
  SingleView.Checked:=true;
  DoubleView.Checked:=false;
  QuadView.Checked:=false;

  if SingleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=false;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if DoubleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if QuadView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=true;
    Videopanel4.Visible:=true;
  end;

  FormResize(nil);
end;

procedure Tvideoscreenform.DoubleViewClick(Sender: TObject);
begin
  SingleView.Checked:=false;
  DoubleView.Checked:=true;
  QuadView.Checked:=false;

  if SingleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=false;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if DoubleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if QuadView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=true;
    Videopanel4.Visible:=true;
  end;

  Videoscreenform.ClientHeight:=Videoscreenform.ClientHeight div 2;

  FormResize(nil);
end;

procedure Tvideoscreenform.QuadViewClick(Sender: TObject);
begin
  if DoubleView.Checked then
    Videoscreenform.ClientHeight:=Videoscreenform.ClientHeight * 2;

  SingleView.Checked:=false;
  DoubleView.Checked:=false;
  QuadView.Checked:=true;

  if SingleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=false;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if DoubleView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=false;
    Videopanel4.Visible:=false;
  end else
  if QuadView.Checked then
  begin
    Videopanel1.Visible:=true;
    Videopanel2.Visible:=true;
    Videopanel3.Visible:=true;
    Videopanel4.Visible:=true;
  end;

  FormResize(nil);
end;

function Tvideoscreenform.GetPositionInMilliseconds(Screen:Byte):integer;
var
  CurrentPos: int64;
begin
  case Screen of
  1:
  if FilterGraph1.Active and (FilterGraph1.Mode=gmNormal) then
  begin
    (FilterGraph1 as IMediaSeeking).GetCurrentPosition(CurrentPos);
  end;
  2:
  if FilterGraph2.Active and (FilterGraph2.Mode=gmNormal) then
  begin
    (FilterGraph2 as IMediaSeeking).GetCurrentPosition(CurrentPos);
  end;
  3:
  if FilterGraph3.Active and (FilterGraph3.Mode=gmNormal) then
  begin
    (FilterGraph3 as IMediaSeeking).GetCurrentPosition(CurrentPos);
  end;
  4:
  if FilterGraph4.Active and (FilterGraph4.Mode=gmNormal) then
  begin
    (FilterGraph4 as IMediaSeeking).GetCurrentPosition(CurrentPos);
  end;
  end;

  Result:=RefTimeToMiliSec(CurrentPos);
end;

end.
