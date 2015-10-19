unit mainfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DSPack, DSUtil, DirectShow9, ScktComp, StdCtrls,
  ExtCtrls, ShellAPI, ComObj, OleServer, PowerPointXP, ActiveX, Menus,
  antTaskbarIcon, jpeg, Registry, Bass, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPServer, UdpSockUtil;

type
  TMediaCenterCommand = record
    Befehl: Word;
    Data1: Cardinal;
    Data2: Cardinal;
    Text: string[255];
  end;

  Tmainform = class(TForm)
    VideoWindow1: TVideoWindow;
    FilterGraph1: TFilterGraph;
    SampleGrabber1: TSampleGrabber;
    Filter1: TFilter;
    DSTrackBar1: TDSTrackBar;
    ServerSocket1: TServerSocket;
    Image1: TImage;
    Memo1: TMemo;
    PowerPointApplication1: TPowerPointApplication;
    antTaskbarIcon1: TantTaskbarIcon;
    PopupMenu1: TPopupMenu;
    MediaCenteranzeigenverbergen1: TMenuItem;
    Beenden1: TMenuItem;
    Porteinstellen1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Timer1: TTimer;
    UdpSocket: TUdpSockUtil;
    procedure FormCreate(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure Beenden1Click(Sender: TObject);
    procedure MediaCenteranzeigenverbergen1Click(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Porteinstellen1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VideoWindow1DblClick(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
    VideoInputDevices: TSysDevEnum;
    Videovolume:integer;
    KeepAspectRatio:boolean;
    sounddevice:integer;
    _chan:cardinal;
    procedure VideoLoadFile(FileName: string);
    procedure VideoPlay;
    procedure VideoPause;
    procedure VideoStop;
    procedure VideoSetVolume(Volume: integer);
    procedure VideoMute(Muted: integer);
    procedure VideoSetPosition(NewPosition:Integer); // in Millisekdungen
    function VideoGetPosition:integer; // in Millisekdungen
    function VideoGetLength:integer; // in Millisekdungen
    procedure VideoInputSearchForDevices;
    procedure VideoInputShowDevice(Device: integer); overload;
    procedure VideoInputShowDevice(Device: string); overload;
    procedure RenderDVD(FileName: string);
  public
    { Public-Deklarationen }
  end;

var
  mainform: Tmainform;

implementation

{$R *.dfm}

procedure Tmainform.VideoLoadFile(FileName: string);
begin
  FilterGraph1.Mode:=gmNormal;
  if not FilterGraph1.Active then
    FilterGraph1.Active := true;
  FilterGraph1.ClearGraph;
  FilterGraph1.RenderFile(FileName);
end;

procedure Tmainform.VideoPlay;
begin
  FilterGraph1.play;
end;

procedure Tmainform.VideoPause;
begin
  FilterGraph1.Pause;
end;

procedure Tmainform.VideoStop;
begin
  FilterGraph1.Stop;
  VideoSetPosition(0);
  DSTrackbar1.Position:=0;
end;

procedure Tmainform.VideoSetVolume(Volume: integer);
begin
  Videovolume:=Volume;
  FilterGraph1.Volume:=Videovolume;
end;

procedure Tmainform.VideoMute(Muted: integer);
begin
  if Muted=0 then
    FilterGraph1.Volume := 0
  else if Muted=127 then
  begin
    if FilterGraph1.Volume = 0 then
    begin
      FilterGraph1.Volume := Videovolume;
    end else
    begin
      FilterGraph1.Volume := 0;
    end;
  end else if Muted=255 then
    FilterGraph1.Volume := Videovolume;
end;

procedure Tmainform.VideoSetPosition(NewPosition:Integer);
var
  CurrentPos, NewPos, StopPos: int64;
begin
  (FilterGraph1 as IMediaSeeking).GetCurrentPosition(CurrentPos);
  (FilterGraph1 as IMediaSeeking).GetStopPosition(StopPos);
   NewPos:=MiliSecToRefTime(NewPosition);
  (FilterGraph1 as IMediaSeeking).SetPositions(NewPos, AM_SEEKING_AbsolutePositioning, StopPos, AM_SEEKING_NoPositioning);
  VideoWindow1.VMROptions.KeepAspectRatio:=KeepAspectRatio;
end;

function Tmainform.VideoGetPosition:integer;
var
  CurrentPos: int64;
begin
  if FilterGraph1.Active and (FilterGraph1.Mode=gmNormal) then
  begin
    (FilterGraph1 as IMediaSeeking).GetCurrentPosition(CurrentPos);
  end;
  Result:=RefTimeToMiliSec(CurrentPos);
end;

function Tmainform.VideoGetLength:integer;
var
  StopPos: int64;
begin
  if FilterGraph1.Active and (FilterGraph1.Mode=gmNormal) then
  begin
    (FilterGraph1 as IMediaSeeking).GetStopPosition(StopPos);
  end;
  Result:=RefTimeToMiliSec(StopPos);
end;

procedure Tmainform.VideoInputSearchForDevices;
var
  i:integer;
begin
  if VideoInputDevices<>nil then
  begin
    VideoInputDevices.Free;
    VideoInputDevices:=nil;
  end;
  VideoInputDevices:= TSysDevEnum.Create(CLSID_VideoInputDeviceCategory);

  for i:=0 to VideoInputDevices.CountFilters-1 do
  begin
    memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Found Video Input Device '+inttostr(i)+': '+VideoInputDevices.Filters[i].FriendlyName);
  end;
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
end;

procedure Tmainform.VideoInputShowDevice(Device: integer);
begin
  if Device < VideoInputDevices.CountFilters then
  begin
    FilterGraph1.Mode:=gmCapture;
    FilterGraph1.ClearGraph;
    FilterGraph1.Active := false;

    Filter1.BaseFilter.Moniker := VideoInputDevices.GetMoniker(Device);
    FilterGraph1.Active := true;

    with FilterGraph1 as ICaptureGraphBuilder2 do
      RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter1 as IBaseFilter, SampleGrabber1 as IBaseFilter, VideoWindow1 as IbaseFilter);

    FilterGraph1.Play;
  end;
end;

procedure Tmainform.VideoInputShowDevice(Device: string);
var
  i:integer;
begin
  for i := 0 to VideoInputDevices.CountFilters - 1 do
  begin
    if Device = VideoInputDevices.Filters[i].FriendlyName then
    begin
      FilterGraph1.Mode:=gmCapture;
      FilterGraph1.ClearGraph;
      FilterGraph1.Active := false;

      Filter1.BaseFilter.Moniker := VideoInputDevices.GetMoniker(i);
      FilterGraph1.Active := true;

      with FilterGraph1 as ICaptureGraphBuilder2 do
        RenderStream(@PIN_CATEGORY_PREVIEW, nil, Filter1 as IBaseFilter, SampleGrabber1 as IBaseFilter, VideoWindow1 as IbaseFilter);

      FilterGraph1.Play;

      break;
    end;
  end;
end;

procedure Tmainform.RenderDVD(FileName: string);
var
  Status:TAMDVDRenderStatus;
  DvdCmd: IDvdCmd;
  HR: HRESULT;
begin
  FilterGraph1.Mode:=gmDVD;
  FilterGraph1.ClearGraph;

  if not FilterGraph1.Active then
  begin
    FilterGraph1.Active := true;
    // Render DVD
    HR := FilterGraph1.RenderDvd(Status, FileName);

    if HR <> S_OK then
    begin
      case HR of
        HRESULT(E_INVALIDARG): Application.MessageBox('Invalid Argument.','Error', mb_ok);
        HRESULT(S_FALSE)     :
                      begin
                        if Status.hrVPEStatus <> 0 then Application.MessageBox(PChar(GetErrorString(Status.hrVPEStatus)), 'Error', mb_OK);
                        if Status.bDvdVolInvalid   then Application.MessageBox('The specified DVD volume to be played does not exist.', 'Error', mb_OK);
                        if Status.bDvdVolUnknown   then Application.MessageBox('No DVD volume is specified or isn''t found.', 'Error', mb_OK);
                        if Status.bNoLine21In      then Application.MessageBox('The video decoder doesn''t produce line 21 (closed captioning) data.', 'Error', mb_OK);
                        if Status.bNoLine21Out     then Application.MessageBox('The video decoder can''t be shown as closed captioning on video due to a problem with graph building.', 'Error', mb_OK);
                        if status.iNumStreamsFailed > 0 then Application.MessageBox('Can''t render one or more stream.', 'Error', mb_OK);
                      end;
        HRESULT(VFW_E_DVD_DECNOTENOUGH) : Application.MessageBox('There isn''t enough hardware or software decoders to decode all streams.','Error', mb_OK);
        HRESULT(VFW_E_DVD_RENDERFAIL)   : Application.MessageBox('Some basic error occurred in building the graph.'#13'Possibilities include the DVD Navigator filter or the video or audio renderer not instantiating,'#13'a trivial connection or pin enumeration failing, or none of the streams rendering.','Error', mb_OK);
      end;
      FilterGraph1.ClearGraph;
      exit;
    end;
    FilterGraph1.Play;
    with FilterGraph1 as IDVDControl2 do
    begin
      SetOption(DVD_NotifyParentalLevelChange,false); //not notify us when parental level changes
      SetOption(DVD_HMSF_TimeCodeEvents, true);       // use new HMSF timecode format
    end;
  end
  else
  begin
    FilterGraph1.Play;
    with FilterGraph1 as IDvdControl2 do PlayForwards(1.0,DVD_CMD_FLAG_None, DvdCmd);
  end;
end;

procedure Tmainform.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
begin
  Application.OnException:=AppException;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER MediaCenter Server') then
        LReg.CreateKey('PC_DIMMER MediaCenter Server');
      if LReg.OpenKey('PC_DIMMER MediaCenter Server',true) then
      begin
        if LReg.ValueExists('Serverport') then
        begin
          ServerSocket1.Active:=false;
          ServerSocket1.Port:=LReg.ReadInteger('Serverport');
          ServerSocket1.Active:=true;
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;

  Videovolume:=10000;
  VideoInputSearchForDevices;

  sounddevice:=0;
  BASS_Init(sounddevice+1, 44100, BASS_DEVICE_SPEAKERS, Handle, nil);

  memo1.lines.clear;
  memo1.Lines.Add('');
  memo1.Lines.Add('MediaCenter Server Logfile:');
  memo1.Lines.Add('-----------------------------------------');
  memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' MediaCenter Server erfolgreich gestartet.');
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
  screen.Cursor:=crNone;

//  UdpSocket.Open;
  
  Timer1.Enabled:=true;
end;

procedure Tmainform.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i,j:integer;
  strvar:string;
  MediaCenterCommand, MediaCenterResponse:TMediaCenterCommand;
begin
  Socket.ReceiveBuf(MediaCenterCommand, sizeof(MediaCenterCommand));

  case MediaCenterCommand.Befehl of
    0: VideoLoadFile(MediaCenterCommand.Text);
    1:
    begin
      VideoWindow1.Visible:=true;
      Image1.Visible:=false;
      VideoPlay;
      if VideoWindow1.VMROptions.KeepAspectRatio<>KeepAspectRatio then
        VideoWindow1.VMROptions.KeepAspectRatio:=KeepAspectRatio;
    end;
    2: VideoPause;
    3: VideoStop;
    4: VideoSetVolume(MediaCenterCommand.Data1);
    5: VideoMute(MediaCenterCommand.Data1);
    6:
    begin
      if MediaCenterCommand.Data1=0 then
        KeepAspectRatio:=false
      else if MediaCenterCommand.Data1=127 then
        KeepAspectRatio:=not KeepAspectRatio
      else if MediaCenterCommand.Data1=255 then
        KeepAspectRatio:=true;

      VideoWindow1.VMROptions.KeepAspectRatio:=KeepAspectRatio;
    end;
    7: VideoSetPosition(MediaCenterCommand.Data1);
    8:
    begin
      MediaCenterResponse.Befehl:=MediaCenterCommand.Befehl;
      MediaCenterResponse.Data1:=VideoGetPosition;
      MediaCenterResponse.Data2:=VideoGetLength;
      MediaCenterResponse.Text:='';
      for i:=0 to ServerSocket1.Socket.ActiveConnections-1 do
        ServerSocket1.Socket.Connections[i].SendBuf(MediaCenterResponse, sizeof(MediaCenterResponse));
    end;
    9:
    begin
      VideoInputSearchForDevices;

      for i:=0 to VideoInputDevices.CountFilters-1 do
      begin
        MediaCenterResponse.Befehl:=MediaCenterCommand.Befehl;
        MediaCenterResponse.Data1:=i;
        MediaCenterResponse.Data2:=VideoInputDevices.CountFilters;
        MediaCenterResponse.Text:=VideoInputDevices.Filters[i].FriendlyName;
        for j:=0 to ServerSocket1.Socket.ActiveConnections-1 do
          ServerSocket1.Socket.Connections[j].SendBuf(MediaCenterResponse, sizeof(MediaCenterResponse));
      end;
    end;
    10: VideoInputShowDevice(MediaCenterCommand.Data1);
    11: VideoInputShowDevice(MediaCenterCommand.Text);
    12:
    begin
      if MediaCenterCommand.Data1=0 then
        VideoWindow1.Visible:=false
      else if MediaCenterCommand.Data1=127 then
        VideoWindow1.Visible:=not VideoWindow1.Visible
      else if MediaCenterCommand.Data1=255 then
        VideoWindow1.Visible:=true;

      VideoWindow1.VMROptions.KeepAspectRatio:=KeepAspectRatio;
    end;
    13:
    begin
      if MediaCenterCommand.Data1=0 then
        VideoWindow1.FullScreen:=false
      else if MediaCenterCommand.Data1=127 then
        VideoWindow1.FullScreen:=not VideoWindow1.FullScreen
      else if MediaCenterCommand.Data1=255 then
        VideoWindow1.FullScreen:=true;
    end;
    14: RenderDVD(MediaCenterCommand.Text);

    20:
    begin
      if (ExtractFileExt(MediaCenterCommand.Text)='.bmp') or (ExtractFileExt(MediaCenterCommand.Text)='.jpg') then
      begin
        Image1.Picture.LoadFromFile(MediaCenterCommand.Text);
        try
          VideoWindow1.Visible:=false;
        except
        end;
        Image1.Visible:=true;
      end else
      begin
        memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Error: Falsches Bilddateiformat ('+ExtractFileExt(MediaCenterCommand.Text)+')');
        memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
      end;
    end;
    21:
    begin
      if MediaCenterCommand.Data1=0 then
        Image1.Visible:=false
      else if MediaCenterCommand.Data1=127 then
        Image1.Visible:=not Image1.Visible
      else if MediaCenterCommand.Data1=255 then
        Image1.Visible:=true;
    end;

    40:
    begin
      PowerPointApplication1.Connect;
      PowerPointApplication1.ShowStartupDialog:=TOleEnum(false);
      PowerPointApplication1.Visible:=TOleEnum(true);
      PowerPointApplication1.Presentations.Open(MediaCenterCommand.Text, TOleEnum(false), TOleEnum(false), TOleEnum(true));
      PowerPointApplication1.Presentations.Item(1).SlideShowSettings.Run;
//      PowerPointApplication1.Presentations.Item(1).Application.WindowState:=ppWindowMaximized;
//      PowerPointApplication1.Presentations.Application.WindowState:=ppWindowMaximized;
//      PowerPointApplication1.Presentations.Application.WindowState:=ppWindowMinimized;
      mainform.visible:=false;
      // strvar:=MediaCenterCommand.Text;
      // ShellExecute(Handle, 'open', PChar('POWERPNT.EXE'), '/s '+PChar(strvar), nil, SW_SHOW);
    end;
    41:
    begin
      if PowerPointApplication1.Presentations.Count>0 then
      begin
        if PowerPointApplication1.ActivePresentation.SlideShowWindow.View.CurrentShowPosition <= PowerPointApplication1.ActivePresentation.Slides.Count then
          PowerPointApplication1.ActivePresentation.SlideShowWindow.View.Next;
      end;
    end;
    42: if PowerPointApplication1.Presentations.Count>0 then PowerPointApplication1.ActivePresentation.SlideShowWindow.View.Previous;
    43: if PowerPointApplication1.Presentations.Count>0 then PowerPointApplication1.ActivePresentation.SlideShowWindow.View.GoToSlide(MediaCenterCommand.Data1, TOleEnum(false));
    44:
    begin
      mainform.visible:=true;
      PowerPointApplication1.Quit;
      PowerPointApplication1.Disconnect;
      mainform.visible:=true;
    end;

    60:
    begin
      if MediaCenterCommand.Data1=0 then
        Mainform.Visible:=false
      else if MediaCenterCommand.Data1=127 then
        Mainform.Visible:=not Mainform.Visible
      else if MediaCenterCommand.Data1=255 then
        Mainform.Visible:=true;
    end;
    61:
    begin
      strvar:=MediaCenterCommand.Text;
      ShellExecute(Handle, 'open', PChar(strvar), nil, nil, SW_SHOW);
    end;

    80:
    begin
      BASS_StreamFree(_chan);
      _chan:=0;
      strvar:=MediaCenterCommand.Text;
      _chan:=BASS_StreamCreateFile(false, PChar(strvar), 0, 0, BASS_SPEAKER_FRONT);
    end;
    81: BASS_ChannelPlay(_chan,false);
    82: BASS_ChannelPause(_chan);
    83:
    begin
      BASS_ChannelStop(_chan);
      BASS_ChannelSetPosition(_chan, BASS_ChannelSeconds2Bytes(_chan, 0), BASS_POS_BYTE);
    end;
    84: BASS_ChannelSetPosition(_chan, BASS_ChannelSeconds2Bytes(_chan, MediaCenterCommand.Data1/1000), BASS_POS_BYTE);
    85: BASS_SetVolume(MediaCenterCommand.Data1/100);
  end;

  memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Received CMD: '+inttostr(MediaCenterCommand.Befehl)+', Data1: '+inttostr(MediaCenterCommand.Data1)+', Data2: '+inttostr(MediaCenterCommand.Data2)+', Text: '+MediaCenterCommand.Text);

  if mainform.Visible then
    mainform.BringToFront;
end;

procedure Tmainform.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Error: '+SysErrorMessage(errorcode));
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
  ErrorCode:=0;
end;

procedure Tmainform.Beenden1Click(Sender: TObject);
begin
  close;
end;

procedure Tmainform.MediaCenteranzeigenverbergen1Click(Sender: TObject);
begin
  mainform.visible:=not mainform.visible;
end;

procedure Tmainform.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Client Connected ('+Socket.RemoteHost+', '+Socket.RemoteAddress+')');
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
  antTaskbarIcon1.Hint:='PC_DIMMER2010 MediaCenter Server [Verbunden]';
end;

procedure Tmainform.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Client Disconnected ('+Socket.RemoteHost+', '+Socket.RemoteAddress+')');
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
  antTaskbarIcon1.Hint:='PC_DIMMER2010 MediaCenter Server [Nicht verbunden]';
end;

procedure Tmainform.Porteinstellen1Click(Sender: TObject);
var
  LReg:TRegistry;
begin
  ServerSocket1.Active:=false;
  ServerSocket1.Port:=strtoint(InputBox('Port des MediaCenter Servers','Bitte geben Sie einen neuen IP-Port ein, auf dem der Server die Verbindung herstellen soll:',inttostr(ServerSocket1.Port)));
//  UdpSocket.RemotePort:=ServerSocket1.Port+1;
  ServerSocket1.Active:=true;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER MediaCenter Server') then
        LReg.CreateKey('PC_DIMMER MediaCenter Server');
      if LReg.OpenKey('PC_DIMMER MediaCenter Server',true) then
      begin
        LReg.WriteInteger('Serverport', ServerSocket1.Port);
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Tmainform.FormDestroy(Sender: TObject);
begin
  VideoStop;
  FilterGraph1.Stop;
  BASS_Free;
  screen.Cursor:=crDefault;

  memo1.Lines.Add('');
  memo1.Lines.Add('Video Window LogFile:');
  memo1.Lines.Add('-----------------------------------------');
  memo1.Lines.Add(FilterGraph1.LogFile);
  memo1.Lines.Add('');
  memo1.Lines.Add('');
  memo1.Lines.Add('MediaCenter Server erfolgreich beendet.');
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
end;

procedure Tmainform.VideoWindow1DblClick(Sender: TObject);
begin
  VideoWindow1.FullScreen:=not VideoWindow1.FullScreen;
end;

procedure TMainform.AppException(Sender: TObject; E: Exception);
begin
  memo1.lines.add(TimeToStr(now)+', '+DateToStr(now)+' Exception: '+E.Message+' ('+E.ClassName+'), '+sender.ClassName+', '+TControl(Sender).Name);
  memo1.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'\PC_DIMMER_MCS.log');
// Nachricht:
// E.Message

// Fehlertyp:
// E.ClassName

// Verursacher:
// sender.ClassName
// TControl(Sender).Name
end;

procedure Tmainform.Timer1Timer(Sender: TObject);
var
  CurrentPos: int64;
  CurrentPosMs:Cardinal;
begin
  // Videotimecode senden
  if FilterGraph1.Active and (FilterGraph1.Mode=gmNormal) then
  begin
    (FilterGraph1 as IMediaSeeking).GetCurrentPosition(CurrentPos);
    CurrentPosMs:=RefTimeToMiliSec(CurrentPos);
    UdpSocket.SendBuf(CurrentPosMs, sizeof(CurrentPosMs), 0);
  end;

  // Audiotimecode senden
  if BASS_ChannelIsActive(_chan)=BASS_ACTIVE_PLAYING then
  begin
    CurrentPosMs:=trunc(BASS_ChannelBytes2Seconds(_chan,BASS_ChannelGetPosition(_chan, BASS_POS_BYTE))*1000);
    UdpSocket.SendBuf(CurrentPosMs, sizeof(CurrentPosMs), 0);
  end;
end;

end.
