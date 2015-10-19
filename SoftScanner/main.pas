unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdDraws, AdClasses, AdSetupDlg, AdParticles, AdPng, IniFiles,
  AdSprites, DXPlay, DXClass, CHHighResTimer, Menus, antTaskbarIcon,
  JvSimpleXml, JvComponentBase, JvAppStorage, JvAppXMLStorage, WinSock,
  gnugettext;

const
  chan=15;
  maxscanner=8;

type
  TPartikelSetting = record
    name:string[255];
    used:boolean;

    Blendmode:byte;
    Lifetime:double;
    lifetimevariation:byte;
    createparticleallxsec:boolean;
    createparticleallxsecvalue:double;
    particlecount:integer;

    HugeStartvalue:double;
    HugeEndvalue:double;
    RotationStartvalue:Double;
    RotationEndvalue:Double;
    SpeedXStartvalue:Double;
    SpeedXEndvalue:Double;
    SpeedYStartvalue:Double;
    SpeedYEndvalue:Double;
    SpeedVariation:byte;

    Angle:Word;
    Open:Word;
    Angle2:Word;
    Strength:Word;
  end;

  TSoftscanner = record
    X:Byte;
    Xfine:Byte;
    Xcomplete:Word;
    Y:Byte;
    Yfine:Byte;
    Ycomplete:Word;
    Gobo:Byte;
    GoboRotation:Byte;
    R:Byte;
    G:Byte;
    B:Byte;
    Special:Byte;
    Focus:Byte;
    Width:Byte;
    Height:Byte;
    Dimmer:Byte;
    PartikelPresets:array[0..255] of TPartikelSetting;
  end;

  TFigur = class(TImageSpriteEx)
    private
    protected
      procedure DoMove(TimeGap:double);override;
    public
      XSpeed:integer;
      constructor Create(AParent:TSprite);override;
      procedure SetLine;
  end;

// Thread für Animation deklarieren
  TAnimationEvent = procedure () of object;
  TAnimationThread = class(TThread)
  private
    DimmerKernelTimer: TCHHighResTimer;
  protected
    procedure Execute; override;
  public
    constructor create;
    procedure TimerEvent(Sender: TObject);
  end;

  TMainform = class(TForm)
    DXPlay1: TDXPlay;
    ParticleRotationTimer: TCHHighResTimer;
    antTaskbarIcon1: TantTaskbarIcon;
    PopupMenu1: TPopupMenu;
    Beenden1: TMenuItem;
    Anzeigen1: TMenuItem;
    OpenDialog1: TOpenDialog;
    XML: TJvAppXMLFileStorage;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DXPlay1Message(Sender: TObject; From: TDXPlayPlayer;
      Data: Pointer; DataSize: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure ParticleRotationTimerTimer(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Anzeigen1Click(Sender: TObject);
		function GetFileVersionBuild(Const FileName:String):String;
    procedure DXPlay1SessionLost(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    function GetIPAddress:string;
  private
    { Private-Deklarationen }
    showinfo:boolean;
    directx:boolean;
    opengl:boolean;
    firststart:boolean;
    FileStream:TFileStream;
  public
    { Public-Deklarationen }
    AdDraw:TAdDraw;
    AdPerCounter:TAdPerformanceCounter;
    AdImageList:TAdImageList;
    AdSpriteEngine:TSpriteEngine;
    workingdirectory:string;
    MouseX,MouseY:integer;
    Einstellungen:TAdOptions;
    nodrawing:boolean;
    Blackout:boolean;
    actualgobowidth,actualgoboheight:double;
    aini:TIniFile;
    DSS200DDFfilePCD:string;
    NetworkPort:Word;
    LogMsg:TAdLogMessage;

    // Softscannerdaten
    Softscanner: TSoftscanner;
    PartSys: TAdParticleSystem;
    Scanner:array[0..maxscanner-1] of TFigur;

    // Globale Animationstimerdeklaration
    channelvalue:array[1..chan] of integer;
    channelvalue_temp:array[1..chan] of integer;
    channel_startvalue:array[1..chan] of Byte;
    channel_endvalue:array[1..chan] of integer;
    channel_fadetime:array[1..chan] of integer;
    channel_dimmactive:array[1..chan] of boolean;
    channel_steps:array[1..chan] of byte;
    channel_increase:array[1..chan] of integer;
    channel_value:array[1..chan] of byte;
    channel_candimm:array[1..chan] of boolean;

    _closing:boolean;

    procedure Idle(Sender:TObject;var Done:boolean);
    procedure WMMoving(var AMsg: TMessage); message WM_MOVING;
    procedure UpdateSoftScannerValues(address, value: integer);
    procedure LoadPreset(preset: byte);
    procedure ResetServer;
  end;

var
  Mainform: TMainform;

implementation

uses settingfrm, messagefrm;

{$R *.dfm}

type
  TStringArray = array of string;

procedure DevideString(AString:string;AChar:char;var AResult:TStringArray);
var
  s:string;
  p:integer;
begin
  SetLength(AResult,0);

  while length(AString) > 0 do
  begin
    //Search the next place where "AChar" apears in "AString"
    p := Pos(AChar,AString);

    if p = 0 then
    begin
      //If not found copy the whole string
      s := copy(AString,1,length(AString));
      AString := '';
    end
    else
    begin
      s := copy(AString,1,p-1);
      AString := copy(AString,p+1,length(AString)-p+1);
    end;

    //Add item
    SetLength(AResult,Length(AResult)+1);
    AResult[high(AResult)] := s;
  end;
end;

procedure TMainform.FormCreate(Sender: TObject);
var
  AdSetupDlg:TAdSetup;
  SR: TSearchRec;
  i:integer;
  nosetup:boolean;
  strs:TStringArray;
begin
  TranslateComponent(self);
  Application.OnException:=AppException;

  workingdirectory:=ExtractFilePath(paramstr(0));

  Settingform:=TSettingform.Create(self);
  messageform:=Tmessageform.Create(self);
  aini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'SoftScanner.ini');

  if FileExists(workingdirectory+'\'+'SoftScanner.partprst') then
  begin
    FileStream:=TFilestream.Create(workingdirectory+'\'+'SoftScanner.partprst',fmOpenRead);
    FileStream.ReadBuffer(SoftScanner.PartikelPresets,sizeof(SoftScanner.PartikelPresets));
    FileStream.Free;
  end;

  // Standardwert initialisieren
  Softscanner.PartikelPresets[0].name:='-= Standard =-';
  Softscanner.PartikelPresets[0].used:=true;
  Softscanner.PartikelPresets[0].Blendmode:=1;
  Softscanner.PartikelPresets[0].Lifetime:=0.5;
  Softscanner.PartikelPresets[0].lifetimevariation:=0;
  Softscanner.PartikelPresets[0].createparticleallxsec:=true;
  Softscanner.PartikelPresets[0].createparticleallxsecvalue:=15;
  Softscanner.PartikelPresets[0].particlecount:=200;
  Softscanner.PartikelPresets[0].HugeStartvalue:=1;
  Softscanner.PartikelPresets[0].HugeEndvalue:=1;
  Softscanner.PartikelPresets[0].RotationStartvalue:=0;
  Softscanner.PartikelPresets[0].RotationEndvalue:=0;
  Softscanner.PartikelPresets[0].SpeedXStartvalue:=100;
  Softscanner.PartikelPresets[0].SpeedXEndvalue:=100;
  Softscanner.PartikelPresets[0].SpeedYStartvalue:=100;
  Softscanner.PartikelPresets[0].SpeedYEndvalue:=100;
  Softscanner.PartikelPresets[0].SpeedVariation:=0;
  Softscanner.PartikelPresets[0].Angle:=0;
  Softscanner.PartikelPresets[0].Open:=360;
  Softscanner.PartikelPresets[0].Angle2:=0;
  Softscanner.PartikelPresets[0].Strength:=0;
  
  Settingform.PreparePresetList;

  _closing:=false;
  nosetup:=false;
  firststart:=true;

  for i:=0 to paramcount do
  begin
    if (paramstr(i)='/nosetup') or (paramstr(i)='-nosetup') then
      nosetup:=true;
  end;

  if nosetup=false then
  if aini.ValueExists('SoftScanner','ShowSetupScreen') then
  begin
    nosetup:=(aini.ReadInteger('SoftScanner','ShowSetupScreen',1)=0);
  end else
  begin
    aini.WriteInteger('SoftScanner', 'ShowSetupScreen', 1);
  end;

  if aini.ValueExists('DDF-Setup','PCDDDF') then
  begin
    DSS200DDFfilePCD := aini.ReadString('DDF-Setup','PCDDDF','C:\Programme\PHOENIXstudios\PC_DIMMER\Devices\PCDIMMER_DSS200Softscanner.pcdproj');
  end else
  begin
    DSS200DDFfilePCD := 'C:\Programme\PHOENIXstudios\PC_DIMMER\Devices\PCDIMMER_DSS200Softscanner.pcdproj';
    aini.WriteString('DDF-Setup','PCDDDF',DSS200DDFfilePCD);
  end;

  if aini.ValueExists('Network','Port') then
  begin
    NetworkPort:=aini.ReadInteger('Network','Port',6500);
  end else
  begin
    NetworkPort:=6500;
    aini.WriteInteger('Network', 'Port', 6500);
  end;

  nodrawing:=true;

  AdPerCounter := TAdPerformanceCounter.Create;
  AdDraw := TAdDraw.Create(self);
  AdDraw.LogFileName:=workingdirectory+'SoftScanner.log';
  AdDraw.AmbientColor := RGB(255,255,255);
  AdSpriteEngine := TSpriteEngine.Create(AdDraw);
  AdSpriteEngine.Surface:=AdDraw;

  AdSetupDlg := TAdSetup.Create(self);

  if nosetup=false then
  begin
    // Einstellungen über Setup-Dialog
    if not AdSetupDlg.Execute('SoftScanner Setup',#169+' by Christian Nöding',workingdirectory+'about.png',AdDraw,[dlgResolution, dlgAdvancedOptions, dlgPlugin],Mainform,TIniFile.Create(ExtractFilePath(ParamStr(0))+'SoftScanner.ini')) then
      halt;
  
    messageform.show;
    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add('SoftScanner '+GetFileVersionBuild(paramstr(0))+' gestartet.');
    LogMsg.Text:='SoftScanner '+GetFileVersionBuild(paramstr(0))+' gestartet.';
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
  end else
  begin
    messageform.show;
    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add('SoftScanner '+GetFileVersionBuild(paramstr(0))+' gestartet.');
    LogMsg.Text:='SoftScanner '+GetFileVersionBuild(paramstr(0))+' gestartet.';
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add('Lese Einstellungen...');
    LogMsg.Text:='Lese Einstellungen.';
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
    // Einstellungen aus INI-Datei laden
    addraw.DllName := ExtractFilePath(ParamStr(0))+aini.ReadString('SoftScanner','plugin','AndorraDX93D.lbr');

    if aini.ReadBool('SoftScanner','antialias',false) then addraw.Options := addraw.Options + [doAntialias];
    if aini.ReadBool('SoftScanner','vsync',false) then addraw.Options := addraw.Options + [doVSync];
    if aini.ReadBool('SoftScanner','fullscreen',false) then addraw.Options := addraw.Options + [doFullscreen];
    if aini.ReadBool('SoftScanner','hardware',true) then addraw.Options := addraw.Options + [doHardware];

    if aini.ReadBool('SoftScanner','curres',false) then
    begin
      addraw.Display.Width := Screen.Width;
      addraw.Display.Height := Screen.Height;
      addraw.Display.BitCount := 32;
    end else
    begin
      DevideString(aini.ReadString('SoftScanner','resolution','1024x768x32'),'x',strs);
      addraw.Display.Width := StrToInt(strs[0]);
      addraw.Display.Height := StrToInt(strs[1]);
      addraw.Display.BitCount := StrToInt(strs[2]);
    end;

    mainform.Width := StrToInt(strs[0]);
    mainform.Height := StrToInt(strs[1]);
    mainform.BorderStyle := bsNone;

    if aini.ReadBool('SoftScanner','fullscreen',false) then
    begin
      Top := 0;
      Left := 0;
    end else
    begin
      mainform.Position := poScreenCenter;
    end;
//    messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]:=messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]+' OK';
  end;

    Einstellungen:=AdDraw.Options;
    try
    directx:=addraw.DllName=ExtractFilePath(ParamStr(0))+'AndorraDX93D.lbr';
    opengl:=addraw.DllName=ExtractFilePath(ParamStr(0))+'AndorraOGL.lbr';
    if directx then
    begin
      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add('Initialisiere Grafik (DirectX)...');
      LogMsg.Text:=_('Initialisiere Grafik (DirectX)...');
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Info';
      AdDraw.Log.AddMessage(LogMsg);
    end else if opengl then
    begin
      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add('Initialisiere Grafik (OpenGL)...');
      LogMsg.Text:=_('Initialisiere Grafik (OpenGL)...');
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Info';
      AdDraw.Log.AddMessage(LogMsg);
    end else
    begin
      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add('Initialisiere Grafik...');
      LogMsg.Text:=_('Initialisiere Grafik...');
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Info';
      AdDraw.Log.AddMessage(LogMsg);
    end;

    if AdDraw.Initialize then
    begin
//      messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]:=messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]+' OK';
      Application.OnIdle := Idle;

      AdImageList := TAdImageList.Create(AdDraw);

      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Lese Gobodateien...'));
      LogMsg.Text:=_('Lese Gobodateien...');
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Info';
      AdDraw.Log.AddMessage(LogMsg);
      // Gobos einlesen
      if (FindFirst(workingdirectory+'\Gobos\*.*',faAnyFile-faDirectory,SR)=0) then
      begin
        repeat
          if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
          begin
            with AdImageList.Add(SR.Name) do
            begin
              Texture.LoadGraphicFromFile(workingdirectory+'\Gobos\'+SR.Name,true,clNone);
              settingform.GoboList.Items.Add(SR.Name);
              Restore;
            end;
          end;
        until FindNext(SR)<>0;
        FindClose(SR);
      end;
      settingform.GoboList.ItemIndex:=0;
//      messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]:=messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]+' OK ('+inttostr(settingform.GoboList.Items.Count)+')';

      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Erstelle Objekte...'));
      LogMsg.Text:=_('Erstelle Objekte...');
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Info';
      AdDraw.Log.AddMessage(LogMsg);
      // Normale Figur initialisieren
      for i:=0 to 0{maxscanner-1} do
      begin
        Scanner[i]:=TFigur.Create(AdSpriteEngine);
        with Scanner[i] do
        begin
          Image := AdImageList.Items[0];
          AnimActive := true;
          AnimLoop := true;
          AnimSpeed := 15;
          XSpeed := -(random(100)+50);
          SetLine;
        end;
      end;

      // Partikelsystem initialisieren
      PartSys := TAdParticleSystem.Create(AdDraw);
      PartSys.Texture := AdImageList.Items[0].Texture;
      PartSys.DefaultParticle.LifeTime := 0.5; //Angabe in Sekunden
    end
    else
    begin
      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Grafik-Initialisierungsfehler.'));
      ShowMessage('Error while initializing SoftScanner Engine. Try to use another display'+
                  'mode or another video adapter.');
      LogMsg.Text:='Error while initializing SoftScanner Engine. Try to use another display mode or another video adapter.';
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Error';
      AdDraw.Log.AddMessage(LogMsg);
      halt;
    end;
    except
      messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Grafik-Initialisierungsfehler.'));
      ShowMessage('Es ist ein Fehler beim Initialisieren der Oberfläche aufgetreten.'+#13#10+'Bitte versuchen Sie eine andere Grafik-Einstellung bzw. deaktivieren Sie die Funktion "Antialiasing".');
      LogMsg.Text:='Es ist ein Fehler beim Initialisieren der Oberfläche aufgetreten. Bitte versuchen Sie eine andere Grafik-Einstellung bzw. deaktivieren Sie die Funktion "Antialiasing"';
      LogMsg.Sender:='SoftScanner';
      LogMsg.Typ:='Error';
      AdDraw.Log.AddMessage(LogMsg);
    end;

  actualgobowidth:=AdImageList.Items[0].Width;
  actualgoboheight:=AdImageList.Items[0].Height;

  Softscanner.GoboRotation:=128;
  Softscanner.Dimmer:=255;
  Softscanner.R:=255;
  Softscanner.G:=255;
  Softscanner.B:=255;

  Softscanner.X:=128;
  Softscanner.Y:=128;
  Softscanner.Xcomplete:=32767;
  Softscanner.Ycomplete:=32767;
  SoftScanner.Special:=10;
  Softscanner.Width:=settingform.WidthBar.Position;
  Softscanner.Height:=settingform.HeightBar.Position;

  channel_candimm[1]:=true;
  channel_candimm[2]:=true;
  channel_candimm[3]:=true;
  channel_candimm[4]:=true;
  channel_candimm[5]:=true;
  channel_candimm[6]:=true;
  channel_candimm[7]:=true;
  channel_candimm[8]:=true;
  channel_candimm[9]:=true;
  channel_candimm[10]:=false;
  channel_candimm[11]:=true;
  channel_candimm[12]:=true;
  channel_candimm[13]:=true;
  channel_candimm[14]:=false;
  channel_candimm[15]:=false;

  messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Starte Netzwerkserver an ')+GetIPAddress+' @ '+inttostr(NetworkPort)+'...');
  LogMsg.Text:=_('Starte Netzwerkserver an Port ')+inttostr(NetworkPort)+'...';
  LogMsg.Sender:='SoftScanner';
  LogMsg.Typ:='Info';
  AdDraw.Log.AddMessage(LogMsg);
  DXPlay1.TCPIPSetting.Port:=NetworkPort;
  DXPlay1.TCPIPSetting.Enabled:=true;
  dxplay1.ProviderName := dxplay1.GetProviderNameFromGUID(StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}')); // TCP/IP als Provider
  DXPlay1.Open2(true,'DSS200-SoftScanner','SoftScanner');
//  messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]:=messageform.ListBox1.Items[messageform.ListBox1.ItemIndex]+' OK';

  nodrawing:=false;
  Blackout:=True;
end;

procedure TMainform.Idle(Sender: TObject; var Done: boolean);
var
  i:integer;
begin
  if nodrawing then exit;

  if AdDraw.CanDraw then
  begin
    AdPerCounter.Calculate;
    AdDraw.ClearSurface(clBlack);
    AdDraw.BeginScene;

    // Text zeichnen
    with AdDraw.Canvas do
    begin
      if showinfo then
      begin
        Textout(0,0,'DSS200 SoftScanner');
        Textout(0,15,GetFileVersionBuild(paramstr(0)));
        Textout(0,30,inttostr(AdPerCounter.FPS)+' FPS');

        Textout(0,50+15,_('F1 = Dieser Infotext'));
        Textout(0,50+30,_('F2 = Einstellungsfenster'));
        Textout(0,50+45,_('F3 = Fenster'));
        Textout(0,50+60,_('F4 = Vollbild'));
        Textout(0,50+75,_('F5 = Blackout'));
        Textout(0,50+105,_('F9 = Gobos im PC_DIMMER DDF aktualisieren'));
        Textout(0,50+120,_('STRG+F12 = Reset der Anzeige'));
        Textout(0,50+135,'');
        Textout(0,50+150,_('Tastenkürzel:'));
        Textout(0,50+165,_('STRG+Maus = Fenster verschieben'));
        Textout(0,50+180,_('STRG+Hoch/Runter = Gobo ändern'));
        Textout(0,50+195,'');
        Textout(0,50+210,_('Startparameter:'));
        Textout(0,50+225,_('/nosetup = Einstellungen direkt aus INI-Datei'));

        Textout(0,mainform.Height-15,'http://www.pcdimmer.de');
        Textout(mainform.Width-175,mainform.Height-15,'IP: '+GetIPAddress+' @ '+inttostr(NetworkPort));
      end;
      Release;
    end;

    if not Blackout then
    begin
      case SoftScanner.Special of
        0..9:
        begin
          // Statisches Bild zeichnen
          for i:=0 to 0{maxscanner-1} do
          begin
            Scanner[i].X:=(Softscanner.Xcomplete/65535)*mainform.Width-Scanner[i].Width/2;
            Scanner[i].Y:=(Softscanner.Ycomplete/65535)*mainform.Height-Scanner[i].Height/2;
            Scanner[i].Move(AdPerCounter.TimeGap / 1000);
            Scanner[i].Draw;
            Scanner[i].Dead;
          end;
        end;
        10..19:
        begin
          // Partikel zeichnen
//          PartSys.CreateParticles(1,TAdParticle,round((Softscanner.Xcomplete/65535)*mainform.Width),round((Softscanner.Ycomplete/65535)*mainform.Height));

          with settingform do
          if interval then
          begin
            if AdPerCounter.TimeGap < pc then
            begin
              pc2 := pc2 + AdPerCounter.TimeGap / pc;
            end
            else
            begin
              pc2 := AdPerCounter.TimeGap / pc;
            end;
            if pc2 >= 1 then
            begin
              PartSys.CreateParticles(round(pc2),TAdParticle,round((Softscanner.Xcomplete/65535)*mainform.Width),round((Softscanner.Ycomplete/65535)*mainform.Height));
              pc2 := 0;
            end;
          end
          else
          begin
            if PartSys.Items.Count = 0 then
            begin
              PartSys.CreateParticles(round(pc),TAdParticle,round((Softscanner.Xcomplete/65535)*mainform.Width),round((Softscanner.Ycomplete/65535)*mainform.Height));
            end;
          end;

          PartSys.Move(AdPerCounter.TimeGap / 1000);
          PartSys.Draw(0, 0);
          PartSys.Dead;
        end;
      end;
    end else
    begin
{
      with AdDraw.Canvas do
      begin
        Textout(mainform.width-25,0,'B/O');
        Textout(mainform.width-50,mainform.Height-15,'DSS200');
        Release;
      end;
}
    end;

    AdDraw.EndScene;
    AdDraw.Flip;
  end;
  Done := false;

  // Um 100% Auslastung zu vermeiden, dafür aber auf etliche FPS zu verzichten,
  // kann das sleep(x) genutzt werden.
  sleep(5);
end;

procedure TMainform.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Shift=[ssLeft] then
  begin
    MouseX := X;
    MouseY := Y;
    Softscanner.Xcomplete:=round((X/mainform.Width)*65535);
    Softscanner.Ycomplete:=round((Y/mainform.Height)*65535);
    if settingform.Showing then
    begin
      settingform.PositionXY.Left:=round((X/mainform.Width)*255);
      settingform.PositionXY.Top:=round((Y/mainform.Height)*255);
    end;
  end;

  if Shift=[ssLeft, ssCtrl] then
  begin
    ReleaseCapture;
    SendMessage(Handle, WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TMainform.FormDestroy(Sender: TObject);
begin
  _closing:=true;
  messageform.Show;
  messageform.ListBox1.Items.Clear;

  LogMsg.Text:=_('Speichere Presets...');
  LogMsg.Sender:='SoftScanner';
  LogMsg.Typ:='Info';
  AdDraw.Log.AddMessage(LogMsg);
  messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Speichere Presets...'));
  FileStream:=TFilestream.Create(workingdirectory+'\'+'SoftScanner.partprst',fmCreate);
  FileStream.WriteBuffer(SoftScanner.PartikelPresets,sizeof(SoftScanner.PartikelPresets));
  FileStream.Free;

  LogMsg.Text:=_('Entferne Objekte...');
  LogMsg.Sender:='SoftScanner';
  LogMsg.Typ:='Info';
  AdDraw.Log.AddMessage(LogMsg);
  messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Entferne Objekte...'));
  PartSys.Free;
  AdImageList.Free;
  AdPerCounter.Free;
  if directx then
  begin
    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Beende Grafik (DirectX)...'));
    LogMsg.Text:=_('Beende Grafik (DirectX)...');
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
  end else if opengl then
  begin
    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Beende Grafik (OpenGL)...'));
    LogMsg.Text:=_('Beende Grafik (OpenGL)...');
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
  end else
  begin
    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Beende Grafik...'));
    LogMsg.Text:=_('Beende Grafik...');
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
  end;

  LogMsg.Text:=_('SoftScanner beendet.');
  LogMsg.Sender:='SoftScanner';
  LogMsg.Typ:='Info';
  AdDraw.Log.AddMessage(LogMsg);

  AdDraw.Free;
  messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Beende Netzwerkserver...'));
  DXPlay1.Close;

  messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Beende SoftScanner.'));
  messageform.Close;
end;

procedure TMainform.FormShow(Sender: TObject);
begin
  antTaskbarIcon1.Visible:=true;

  if not firststart then
  begin
    // Anzeige resetten
    nodrawing:=true;
    addraw.Finalize;
    AdDraw.Options:=Einstellungen;
    AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    AdDraw.Initialize;
    nodrawing:=false;
  end else
  begin
    settingform.label4.Caption:=GetFileVersionBuild(paramstr(0));
    LoadPreset(0);

    messageform.ListBox1.ItemIndex:=messageform.ListBox1.Items.Add(_('Starte Dimmerkernel...'));
    LogMsg.Text:=_('Starte Dimmerkernel...');
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);
    TAnimationThread.create;

    messageform.close;

    LogMsg.Text:=_('SoftScanner erfolgreich gestartet.');
    LogMsg.Sender:='SoftScanner';
    LogMsg.Typ:='Info';
    AdDraw.Log.AddMessage(LogMsg);

    firststart:=false;
  end;
end;

procedure TMainform.WMMoving(var AMsg: TMessage);
begin
  if settingform.showing then
  begin
    settingform.top:=mainform.Top;
    settingform.left:=mainform.Left+mainform.Width;
  end;
end;

{ TFigur }
constructor TFigur.Create(AParent: TSprite);
begin
  inherited;
  X := (mainform.Width / 2) - (Width / 2);
  Y := (mainform.Height / 2) - (Height / 2);
  XSpeed := -150;
end;

procedure TFigur.DoMove(TimeGap: double);
begin
  inherited DoMove(TimeGap);

  Angle := Angle + 360*((mainform.Softscanner.GoboRotation-128)/128)*TimeGap;
  if Angle > 360 then Angle := 0;
end;


procedure TFigur.SetLine;
begin
{
  XSpeed := -XSpeed;
  if XSpeed > 0 then
  begin
    AnimStart := 0;
    AnimStop := 7;
    X := -96;
  end else
  begin
    AnimStart := 8;
    AnimStop := 15;
    X := Engine.SurfaceRect.Right+96;
  end;
  Y := Random(Engine.SurfaceRect.Right-96);
}
end;

procedure TMainform.DXPlay1Message(Sender: TObject; From: TDXPlayPlayer;
  Data: Pointer; DataSize: Integer);
type
  TDXChatMessage = record
    address:Word;
    startvalue:byte;
    endvalue:byte;
    fadetime:LongWord;
    Len: Word;
    Name: Array[0..0] of Char;
  end;
var
  name:string;
begin
//  TDXChatMessage(Data^).channel;
//  TDXChatMessage(Data^).value;
//  name

  if (TDXChatMessage(Data^).address>chan) or (TDXChatMessage(Data^).address<1) then exit;

  if (TDXChatMessage(Data^).Len>0) then
  begin
    SetLength(name,TDXChatMessage(Data^).Len);
    StrLCopy(pChar(name),TDXChatMessage(Data^).Name,TDXChatMessage(Data^).Len);

    if settingform.Showing then
    begin
      settingform.channellbl.Caption:='Kanal: '+inttostr(TDXChatMessage(Data^).address);
      settingform.startvaluelbl.Caption:='Startwert: '+inttostr(TDXChatMessage(Data^).startvalue);
      settingform.endvaluelbl.Caption:='Endwert: '+inttostr(TDXChatMessage(Data^).endvalue);
      settingform.fadetimelbl.Caption:='Fadezeit: '+inttostr(TDXChatMessage(Data^).fadetime);
      settingform.namelbl.Caption:='Kanalname: '+copy(name,2,length(name));
      settingform.endvaluelbl.Visible:=true;
      settingform.fadetimelbl.Visible:=true;
      settingform.namelbl.Visible:=true;
    end;
  end else
  begin
    if settingform.Showing then
    begin
      settingform.channellbl.Caption:='Kanal: '+inttostr(TDXChatMessage(Data^).address);
      settingform.startvaluelbl.Caption:='Wert: '+inttostr(TDXChatMessage(Data^).startvalue);
      settingform.endvaluelbl.Visible:=false;
      settingform.fadetimelbl.Visible:=false;
      settingform.namelbl.Visible:=false;
    end;
  end;

  // Animation für aktuellen Kanal aktualisieren
  channel_steps[TDXChatMessage(Data^).address] := Abs(TDXChatMessage(Data^).startvalue - TDXChatMessage(Data^).endvalue);
  if (TDXChatMessage(Data^).fadetime>0) and (channel_candimm[TDXChatMessage(Data^).address]) then
  begin
    // Fadetime>0
    if (channel_steps[TDXChatMessage(Data^).address]>0) then
    begin
      channel_startvalue[TDXChatMessage(Data^).address] := TDXChatMessage(Data^).startvalue;
      channel_value[TDXChatMessage(Data^).address] := TDXChatMessage(Data^).startvalue;
      channel_endvalue[TDXChatMessage(Data^).address] := TDXChatMessage(Data^).endvalue;
      channel_fadetime[TDXChatMessage(Data^).address] := TDXChatMessage(Data^).fadetime;
      channel_increase[TDXChatMessage(Data^).address] := 0;
      channel_dimmactive[TDXChatMessage(Data^).address] := True;
      // Animationstimer wurde gestartet und aktuelle Werte werden per SendMSG an Plugins übergeben
    end;
  end else
  begin
    // Fadetime=0
    channel_dimmactive[TDXChatMessage(Data^).address] := false;
    channel_value[TDXChatMessage(Data^).address] := TDXChatMessage(Data^).endvalue;

    UpdateSoftScannerValues(TDXChatMessage(Data^).address,TDXChatMessage(Data^).endvalue)
  end;
end;

procedure TMainform.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Shift=[ssLeft]) or (Shift=[ssRight]) then
  begin
    Softscanner.Xcomplete:=round((X/mainform.Width)*65535);
    Softscanner.Ycomplete:=round((Y/mainform.Height)*65535);
    if settingform.Showing then
    begin
      settingform.PositionXY.Left:=round((X/mainform.Width)*255);
      settingform.PositionXY.Top:=round((Y/mainform.Height)*255);
    end;
  end;
end;

procedure TMainform.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i,j,k:integer;
  ok:boolean;
begin
  if (Key=vk_f1) and (Shift=[]) then
  begin
    showinfo:=not showinfo;
  end;
  if (Key=vk_f2) and (Shift=[]) then
  begin
    if settingform.Showing then
    begin
      settingform.Hide;
    end else
    begin
      settingform.Show;
      settingform.Height:=625;
      settingform.Width:=250;
      settingform.top:=mainform.Top;
      settingform.left:=mainform.Left+mainform.Width;
    end;
  end;
  if (Key=vk_f3) and (Shift=[]) then
  begin
    firststart:=true;
    // Fenster
    nodrawing:=true;
    addraw.Finalize;

    AdDraw.Options:=Einstellungen;
    addraw.Options := addraw.Options - [doFullscreen];
    Einstellungen:=AdDraw.Options;
    mainform.Position := poScreenCenter;
    AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    AdDraw.Initialize;
    nodrawing:=false;
  end;
  if (Key=vk_f4) and (Shift=[]) then
  begin
    // Vollbild
    nodrawing:=true;
    addraw.Finalize;

    AdDraw.Options:=Einstellungen;
    addraw.Options := addraw.Options + [doFullscreen];
    Einstellungen:=AdDraw.Options;
    AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    AdDraw.Initialize;
    nodrawing:=false;
    mainform.top:=0;
    mainform.left:=0;
  end;
  if (Key=vk_f5) and (Shift=[]) then
  begin
    Blackout:=not Blackout;
  end;
  if (Key=vk_f9) and (Shift=[]) then
  begin
    case messagedlg('Die aktuellen Gobos werden hiermit in die PC_DIMMER-DDF-Datei eingepflegt (Dropdown-Listen "gobolist" und "presetlist"). Alle anderen Einstellungen bleiben dabei unverändert. Soll dafür folgende Datei verwendet werden?'+#13#10#13#10+DSS200DDFfilePCD, mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrCancel: // Cancel
      begin
        exit;
      end;
      mrYes: // Yes
      begin
      end;
      mrNo: // No
      begin
        if OpenDialog1.Execute then
        begin
          DSS200DDFfilePCD:=OpenDialog1.FileName;
          aini.WriteString('SoftScanner','PCDDDF',DSS200DDFfilePCD);
        end else
        begin
          exit;
        end;
      end;
    end;

    ok:=false;
    XML.Xml.LoadFromFile(DSS200DDFfilePCD);
    for j:=0 to XML.Xml.Root.Items.Count-1 do
    begin // <device>
      if XML.XML.Root.Items[j].Name='form' then
      begin // <form>
        for k:=0 to XML.XML.Root.Items[j].Items.Count-1 do
        begin
          if XML.XML.Root.Items[j].Items[k].Name='dropdown' then
          begin // <dropdown>
            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')='gobolist' then
            begin // goboliste gefunden
              // Gobos löschen
              XML.XML.Root.Items[j].Items[k].Items.Clear;

              // Aktuelle Gobos einfügen
              for i:=0 to settingform.GoboList.Items.Count-1 do
              begin
                XML.XML.Root.Items[j].Items[k].Items.Add('item');
                XML.XML.Root.Items[j].Items[k].Items[i].Properties.Add('caption',copy(settingform.GoboList.Items[i],0,length(settingform.GoboList.Items[i])-4));
                XML.XML.Root.Items[j].Items[k].Items[i].Properties.Add('value',i);
              end;
              ok:=true;
            end;


            if XML.XML.Root.Items[j].Items[k].Properties.Value('name')='presetlist' then
            begin // Presetliste gefunden
              // Presets löschen
              XML.XML.Root.Items[j].Items[k].Items.Clear;

              // Aktuelle Presets einfügen
              for i:=0 to settingform.Listbox1.Items.Count-1 do
              begin
                XML.XML.Root.Items[j].Items[k].Items.Add('item');
                XML.XML.Root.Items[j].Items[k].Items[i].Properties.Add('caption',settingform.Listbox1.Items[i]);
                XML.XML.Root.Items[j].Items[k].Items[i].Properties.Add('value',i);
              end;
              ok:=true;
            end;
          end;
        end;
      end;
    end;

    XML.Xml.SaveToFile(DSS200DDFfilePCD);
    if ok then
      ShowMessage('Änderungen erfolgreich abgeschlossen.')
    else
      ShowMessage('Es ist ein Fehler beim Aktualisieren aufgetreten. Möglicherweise existiert im DDF keine Dropdown-Komponente "gobolist" bzw. "presetlist"...');
  end;
  if (Key=vk_f12) and (Shift=[ssCtrl]) then
  begin
    // Anzeige resetten
    nodrawing:=true;
    addraw.Finalize;
    AdDraw.Options:=Einstellungen;
    AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    AdDraw.Initialize;
    nodrawing:=false;
    mainform.top:=0;
    mainform.left:=0;
  end;
  if (Key=vk_down) and (Shift=[ssCtrl])then
  begin
    if settingform.GoboList.ItemIndex<settingform.GoboList.Items.Count-1 then
    begin
      settingform.GoboList.ItemIndex:=settingform.GoboList.ItemIndex+1;
      settingform.GoboListChange(settingform.GoboList);
    end;
  end;
  if (Key=vk_up) and (Shift=[ssCtrl])then
  begin
    if settingform.GoboList.ItemIndex>0 then
    begin
      settingform.GoboList.ItemIndex:=settingform.GoboList.ItemIndex-1;
      settingform.GoboListChange(settingform.GoboList);
    end;
  end;
end;

procedure TMainForm.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if (Message.Result = htClient) and
     (ControlAtPos(Point(Message.xPos, Message.yPos), True, True) <> nil)
  then
    Message.Result := htCaption;
end;

procedure TMainform.ParticleRotationTimerTimer(Sender: TObject);
begin
  if Softscanner.GoboRotation>128 then
  begin
    if mainform.PartSys.DefaultParticle.RotStart<180 then
      mainform.PartSys.DefaultParticle.RotStart:=mainform.PartSys.DefaultParticle.RotStart+2
    else
      mainform.PartSys.DefaultParticle.RotStart:=0;

    if mainform.PartSys.DefaultParticle.RotEnd<180 then
      mainform.PartSys.DefaultParticle.RotEnd:=mainform.PartSys.DefaultParticle.RotEnd+2
    else
      mainform.PartSys.DefaultParticle.RotEnd:=0;
  end else
  begin
    if mainform.PartSys.DefaultParticle.RotStart>0 then
      mainform.PartSys.DefaultParticle.RotStart:=mainform.PartSys.DefaultParticle.RotStart-2
    else
      mainform.PartSys.DefaultParticle.RotStart:=180;

    if mainform.PartSys.DefaultParticle.RotEnd>0 then
      mainform.PartSys.DefaultParticle.RotEnd:=mainform.PartSys.DefaultParticle.RotEnd-2
    else
      mainform.PartSys.DefaultParticle.RotEnd:=180;
  end;
end;

procedure TMainform.Beenden1Click(Sender: TObject);
begin
  close;
end;

procedure TMainform.Anzeigen1Click(Sender: TObject);
begin
  if mainform.Showing then
    mainform.Hide
  else
    mainform.Show;
end;

//-------------------------------------------------

constructor TAnimationThread.Create;
begin
  inherited create(false);
  Priority := tpHigher;
  FreeOnTerminate := true;

  DimmerKernelTimer:=TCHHighResTimer.Create(DimmerKernelTimer);
  DimmerKernelTimer.Interval:=1;
  DimmerKernelTimer.OnTimer:=TimerEvent;

  DimmerKernelTimer.Enabled:=true;
end;

procedure TAnimationThread.Execute;
begin
//  inherited;

  while not mainform._closing do
  begin
    sleep(1);
  end;

  DimmerKernelTimer.Enabled:=false;

  Terminate;
end;

procedure TAnimationThread.TimerEvent(Sender: TObject);
var
  i:integer;
begin
  with mainform do
  begin
  for i:=1 to chan do
  begin
    if channel_dimmactive[i] then
    begin
      channel_increase[i]:=channel_increase[i]+1;
      if channel_steps[i]>0 then
      begin
        if channel_increase[i] >= Round(channel_fadetime[i] / channel_steps[i]) then
        begin
          channel_increase[i]:=0;
          if channel_startvalue[i]<channel_endvalue[i] then
          begin
            // Nach oben Dimmen
            channel_value[i]:=channel_value[i]+1;
          end else
          begin
            // Nach unten Dimmen
            channel_value[i]:=channel_value[i]-1;
          end;

          UpdateSoftScannerValues(i,channel_value[i]);
        end;
      end;

      if channel_value[i]=channel_endvalue[i] Then
        channel_dimmactive[i]:=false;
    end;
  end;
  end; // end von with mainform
end;

//-------------------------------------------------

procedure TMainform.UpdateSoftScannerValues(address,value:integer);
var
  actualscanner:integer;
begin
//  actualscanner:=address mod chan;
  actualscanner:=0;

  case address of
    1: Softscanner.X:=value;
    2: Softscanner.Xfine:=value;
    3: Softscanner.Y:=value;
    4: Softscanner.Yfine:=value;
    5:
    begin
      Softscanner.Gobo:=value;
      if Softscanner.Gobo<settingform.GoboList.Items.Count then
      begin
        settingform.GoboList.ItemIndex:=Softscanner.Gobo;
        settingform.GoboListChange(settingform.GoboList);
      end;
    end;
    6:
    begin
      Softscanner.GoboRotation:=value;

      if Softscanner.GoboRotation=128 then
        ParticleRotationTimer.Enabled:=false
      else
        ParticleRotationTimer.Enabled:=true;

      if Softscanner.GoboRotation<128 then
        ParticleRotationTimer.Interval:=round(100*(Softscanner.GoboRotation/128))
      else
        ParticleRotationTimer.Interval:=round(100*((128-(Softscanner.GoboRotation-128))/128))
    end;
    7:
    begin
      Softscanner.R:=value;
      AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    end;
    8:
    begin
      Softscanner.G:=value;
      AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    end;
    9:
    begin
      Softscanner.B:=value;
      AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    end;
    10: Softscanner.Special:=value;
    11:
    begin
      Softscanner.Width:=value;
      Scanner[actualscanner].Width:=actualgobowidth*(value/127);

      PartSys.DefaultParticle.SizeStart:=(value/127);
      PartSys.DefaultParticle.SizeEnd:=(value/127);
    end;
    12:
    begin
      Softscanner.Height:=value;
      Scanner[actualscanner].Height:=actualgobowidth*(value/127);

      PartSys.DefaultParticle.SizeStart:=(value/127);
      PartSys.DefaultParticle.SizeEnd:=(value/127);
    end;
    13:
    begin
      Softscanner.Dimmer:=value;
      AdDraw.AmbientColor := RGB(round(Softscanner.R*Softscanner.Dimmer/255),round(Softscanner.G*Softscanner.Dimmer/255),round(Softscanner.B*Softscanner.Dimmer/255));
    end;
    14:
    begin
      case value of
        0..99:
        begin
          mainform.Show;
          Blackout:=True;
        end;
        100..199:
        begin
          mainform.Show;
          Blackout:=False;
        end;
        200..255:
        begin
          mainform.Hide;
          Blackout:=false;
        end;
      end;
    end;
    15: // Presets laden
    begin
      LoadPreset(value);
    end;
  end;
  case address of
    1..2:
    begin
      Softscanner.Xcomplete:=Softscanner.X;
      Softscanner.Xcomplete:=Softscanner.Xcomplete shl 8;
      Softscanner.Xcomplete:=Softscanner.Xcomplete+Softscanner.Xfine;
    end;
    3..4:
    begin
      Softscanner.Ycomplete:=Softscanner.Y;
      Softscanner.Ycomplete:=Softscanner.Ycomplete shl 8;
      Softscanner.Ycomplete:=Softscanner.Ycomplete+Softscanner.Yfine;
    end;
  end;
end;

Function TMainform.GetFileVersionBuild(Const FileName: String): String;
  Var i, W: LongWord;
    P: Pointer;
    FI: PVSFixedFileInfo;
    version,zusatz,text,text2:string;
  Begin
    version := 'NoVersionInfo';
    i := GetFileVersionInfoSize(PChar(FileName), W);
    If i = 0 Then Exit;
    GetMem(P, i);
    Try
      If not GetFileVersionInfo(PChar(FileName), W, i, P)
        or not VerQueryValue(P, '\', Pointer(FI), W) Then Exit;
      version := IntToStr(FI^.dwFileVersionMS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionMS and $FFFF)
        + '.' + IntToStr(FI^.dwFileVersionLS shr 16)
        + '.' + IntToStr(FI^.dwFileVersionLS and $FFFF);
      If FI^.dwFileFlags and VS_FF_DEBUG        <> 0 Then zusatz := 'Debug';
      If FI^.dwFileFlags and VS_FF_PRERELEASE   <> 0 Then zusatz := 'Beta';
      If FI^.dwFileFlags and VS_FF_PRIVATEBUILD <> 0 Then zusatz := 'Private';
      If FI^.dwFileFlags and VS_FF_SPECIALBUILD <> 0 Then zusatz := 'Special';
    Finally
      FreeMem(P);
    End;

    text:=version; //4.0.0.0
    text2:=copy(text,0,pos('.',text)); // 4.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)); // 4.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0.0
    text2:=text2+copy(text,pos('.',text)-1,pos('.',text)-1); // 4.0.0.
    text:=copy(text,pos('.',text)+1,length(text)); // 0

    result:='Version '+text2+' Build '+text+' '+zusatz;
End;

procedure Tmainform.LoadPreset(preset: byte);
begin
  with Softscanner.PartikelPresets[preset] do
  begin
    case Blendmode of
      0: PartSys.DefaultParticle.BlendMode := bmAlpha;
      1: PartSys.DefaultParticle.BlendMode := bmAdd;
      2: PartSys.DefaultParticle.BlendMode := bmMask;
    end;
    PartSys.DefaultParticle.LifeTime := Lifetime;
    PartSys.DefaultParticle.LifeTimeVariation := lifetimevariation;
    if createparticleallxsec then
    begin
      settingform.pc := createparticleallxsecvalue;
      if settingform.pc < 0.1 then settingform.pc := 0.1;
      settingform.interval := true;
    end else
    begin
      settingform.pc := particlecount;
      settingform.interval := false;
    end;
    PartSys.DefaultParticle.SizeStart := HugeStartvalue;
    PartSys.DefaultParticle.SizeEnd   := HugeEndvalue;
    PartSys.DefaultParticle.RotStart := RotationStartvalue;
    PartSys.DefaultParticle.RotEnd   := RotationEndvalue;

    PartSys.DefaultParticle.SpeedXStart := SpeedXStartvalue;
    PartSys.DefaultParticle.SpeedXEnd := SpeedXEndvalue;
    PartSys.DefaultParticle.SpeedYStart := SpeedYStartvalue;
    PartSys.DefaultParticle.SpeedYEnd := SpeedYEndvalue;
    PartSys.DefaultParticle.SpeedVariation := SpeedVariation;

    PartSys.DefaultParticle.CreationAngle := Angle;
    PartSys.DefaultParticle.CreationAngleOpen  := Open;
    with mainform.PartSys.DefaultParticle.Force do
    begin
      X := cos(Angle2 * PI / 180)*Strength;
      Y := sin(Angle2 * PI / 180)*Strength;
    end;
  end;
  settingform.UpdateControls;
end;

procedure TMainform.DXPlay1SessionLost(Sender: TObject);
begin
  ResetServer;
end;

procedure Tmainform.ResetServer;
begin
  DXPlay1.Close;
  DXPlay1.TCPIPSetting.Port:=NetworkPort;
  DXPlay1.TCPIPSetting.Enabled:=true;
  dxplay1.ProviderName := dxplay1.GetProviderNameFromGUID(StringToGUID('{36E95EE0-8577-11CF-960C-0080C7534E82}')); // TCP/IP als Provider
  DXPlay1.Open2(true,'DSS200-SoftScanner','SoftScanner');
end;

procedure TMainform.AppException(Sender: TObject; E: Exception);
begin
// Nachricht:
// E.Message

// Fehlertyp:
// E.ClassName

// Verursacher:
// sender.ClassName
// TControl(Sender).Name
end;

function TMainform.GetIPAddress:string;
const
  sTxtIP  = '%d.%d.%d.%d';
var
    rSockVer   : Word;
    aWSAData   : TWSAData;
    szHostName : array[0..255] of Char;
    pHE        : PHostEnt;
begin
  Result:='';
  // WinSock Version 1.1 initialisieren
  rSockVer:=MakeWord(1, 1);
  WSAStartup(rSockVer, aWSAData );
  try
    FillChar(szHostName, SizeOf(szHostName), #0);
    GetHostName(szHostName, SizeOf(szHostName));
    pHE:=GetHostByName(szHostName);
    if (pHE<>nil) then with pHE^ do
      Result:=Format(sTxtIP,
                [Byte(h_addr^[0]), Byte(h_addr^[1]),
                 Byte(h_addr^[2]), Byte(h_addr^[3])]);
  finally
    WSACleanup;
  end;
end;

end.
