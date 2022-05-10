{$WARN COMPARING_SIGNED_UNSIGNED OFF}
{$WARN COMBINING_SIGNED_UNSIGNED OFF}

unit audioeffektplayerfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Grids, Mask,
  JvExMask, JvCombobox,
  Bass, bass_fx, CommonTypes, spectrum_vis, osc_vis, CheckLst, Menus,
  szenenverwaltung, Registry, JvToolEdit, EstimatedTime, PngBitBtn,
  GR32, GDIPAPI, GDIPOBJ, pngimage, gnugettext, MMSystem, TB2Item, TB2Dock,
  TB2Toolbar, messagesystem, SVATimer, JvExControls, JvLabel;

const
  maxaudioeffektlayers = 8;
  maxzoom=256;

type
  PTreeData = ^TTreeData;
  TTreeData = record
    NodeType: integer; // 0 Einfache Szenen, 1 Geräteszenen, 2 Audioszenen, 3 Bewegungsszenen, 4 Befehle, 5 Kombinationsszenen, 6 Presets, 7 Automatikszenen, 8 Effekt, 9 MediaCenter Szenen
    IsRootNode:boolean;
    IsCatNode:boolean;
    Caption:WideString;
    Beschreibung:WideString;
    Fadetime:WideString;
    ID:TGUID;
  end;

  Taudioeffektplayerform = class(TForm)
    PanelTop: TPanel;
    PanelLighteffects: TPanel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    audioeffekte_popupmenu: TPopupMenu;
    Effektlschen1: TMenuItem;
    MarkiertenEffektausfhren1: TMenuItem;
    MarkiertenEffektstoppen1: TMenuItem;
    MarkierteEffekteverschieben1: TMenuItem;
    MarkiertenEffektaufPositionXsetzen1: TMenuItem;
    N43: TMenuItem;
    Layer1: TMenuItem;
    Layerffnen1: TMenuItem;
    Layerspeichern1: TMenuItem;
    Layerlschen1: TMenuItem;
    LayerkopierenzuLayer1: TMenuItem;
    Effektliste1: TMenuItem;
    Effektlisteffnen1: TMenuItem;
    Effektlistespeichern1: TMenuItem;
    Effektlistelschen1: TMenuItem;
    N44: TMenuItem;
    RecordModus1: TMenuItem;
    N15: TMenuItem;
    RepeatModus1: TMenuItem;
    Repeataktiviert1: TMenuItem;
    N52: TMenuItem;
    SprungmarkeanaktuellePosition1: TMenuItem;
    Sprungmarkeverschieben1: TMenuItem;
    N51: TMenuItem;
    ZielmarkeanaktuellePosition1: TMenuItem;
    Zielmarkeverschieben1: TMenuItem;
    N53: TMenuItem;
    Importieren1: TMenuItem;
    Exportieren1: TMenuItem;
    N23: TMenuItem;
    Wavedarstellungzweifarbig1: TMenuItem;
    Mausklickssperren1: TMenuItem;
    N1: TMenuItem;
    PanelWaveform: TPanel;
    PanelRight: TPanel;
    AudioeffektplayerTimeLabel: TLabel;
    GroupBox1: TGroupBox;
    waveform_zoomin: TSpeedButton;
    waveform_zoomout: TSpeedButton;
    CheckBox9: TCheckBox;
    effekteein: TCheckBox;
    Repeataktiviert: TCheckBox;
    Wavezweifarbig: TCheckBox;
    lockmouse: TCheckBox;
    Wavedarstellung: TComboBox;
    TrackBar1: TTrackBar;
    Panel6: TPanel;
    audioeffektscrollbar: TScrollBar;
    waveform_scrollbar: TScrollBar;
    ScrollBar1: TScrollBar;
    Panel7: TPanel;
    waveform: TPaintBox;
    Splitter1: TSplitter;
    ScrolltimelineCheckbox: TCheckBox;
    ScalingLbl: TLabel;
    Videoseekingeinrichten1: TMenuItem;
    Splitter2: TSplitter;
    Layernamenbearbeiten1: TMenuItem;
    AddSzenePopup: TPopupMenu;
    ObjektausSzenenbibliothekstarten1: TMenuItem;
    ObjektausBibliothekstoppen1: TMenuItem;
    Direktszenehinzufgen1: TMenuItem;
    Effektstarten2: TMenuItem;
    Effektstoppen2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    CheckBPMTimer: TTimer;
    GroupBox5: TGroupBox;
    audioeffectplayer_volume: TTrackBar;
    Label4: TLabel;
    Panel1: TPanel;
    PlayEffektaudio: TPngBitBtn;
    PauseEffektaudio: TPngBitBtn;
    StopEffektaudio: TPngBitBtn;
    movefileup: TPngBitBtn;
    movefiledown: TPngBitBtn;
    recordbtn_on: TPngBitBtn;
    RunAllPreviousEffectsBtn: TPngBitBtn;
    recordbtn_off: TPngBitBtn;
    RunAllPreviousEffectsBtnOff: TPngBitBtn;
    audioeffektfilenamebox: TComboBox;
    Button20: TPngBitBtn;
    Button21: TPngBitBtn;
    bpmview: TLabel;
    bpmprogress: TProgressBar;
    synchronizing: TImage;
    nomouseimage: TImage;
    recordingimage: TImage;
    LayerCombobox: TJvCheckedComboBox;
    Shape3: TShape;
    Videoscreenbtn: TPngBitBtn;
    PanelControl: TPanel;
    Shape1: TShape;
    Bevel1: TBevel;
    Label1: TLabel;
    Panel2: TPanel;
    OpenEffektliste: TSpeedButton;
    SaveEffektliste: TSpeedButton;
    Button18: TPngBitBtn;
    DeleteEffekt: TPngBitBtn;
    Effektnachlinks: TPngBitBtn;
    Effektnachrechts: TPngBitBtn;
    EditEffekt: TPngBitBtn;
    CopyEffektBtn: TPngBitBtn;
    RefreshEffect: TPngBitBtn;
    seteffecttoactualpositionbtn: TPngBitBtn;
    layerbox: TComboBox;
    Effektliste: TStringGrid;
    Button2: TButton;
    PanelAudioeffects: TPanel;
    Bevel2: TBevel;
    Shape2: TShape;
    Label15: TLabel;
    save_eq: TLabel;
    reset_eq: TLabel;
    Button1: TButton;
    GroupBox3: TGroupBox;
    Shape5: TShape;
    equalizer_progressbar0: TProgressBar;
    equalizer_progressbar1: TProgressBar;
    equalizer_progressbar2: TProgressBar;
    equalizer_progressbar5: TProgressBar;
    equalizer_progressbar4: TProgressBar;
    equalizer_progressbar3: TProgressBar;
    equalizer_progressbar8: TProgressBar;
    equalizer_progressbar7: TProgressBar;
    equalizer_progressbar6: TProgressBar;
    equalizer_progressbar10: TProgressBar;
    equalizer_progressbar9: TProgressBar;
    GroupBox4: TGroupBox;
    Label21: TLabel;
    eq_label8: TLabel;
    eq_label1: TLabel;
    Label13: TLabel;
    eq_label2: TLabel;
    Label23: TLabel;
    eq_label3: TLabel;
    Label25: TLabel;
    eq_label5: TLabel;
    Label27: TLabel;
    eq_label6: TLabel;
    Label29: TLabel;
    eq_label7: TLabel;
    Label31: TLabel;
    eq_label4: TLabel;
    Label33: TLabel;
    eq_scrollbar8: TScrollBar;
    eq_scrollbar1: TScrollBar;
    eq_scrollbar2: TScrollBar;
    eq_scrollbar3: TScrollBar;
    eq_scrollbar5: TScrollBar;
    eq_scrollbar6: TScrollBar;
    eq_scrollbar7: TScrollBar;
    eq_scrollbar4: TScrollBar;
    eq_check1: TCheckBox;
    eq_check2: TCheckBox;
    eq_check3: TCheckBox;
    eq_check4: TCheckBox;
    eq_check5: TCheckBox;
    eq_check6: TCheckBox;
    eq_check7: TCheckBox;
    eq_check8: TCheckBox;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    Datei1: TTBSubmenuItem;
    Neu1: TTBItem;
    Dateiffnen1: TTBItem;
    Dateispeichern1: TTBItem;
    Ansicht1: TTBSubmenuItem;
    Waveformneuberechnen1: TTBItem;
    AktuellesLayeraktualisieren1: TTBItem;
    N3: TTBSeparatorItem;
    Anzeigedeaktivieren1: TTBItem;
    BPMErkennung1: TTBSubmenuItem;
    chkBPMCallback: TTBItem;
    BPMScanzyklus1: TTBItem;
    chkBeat: TTBItem;
    BPMScanlnge1: TTBItem;
    N6: TTBSeparatorItem;
    BPMWertneusuchen1: TTBItem;
    Einstellungen1: TTBSubmenuItem;
    vorlaufzeit1: TTBItem;
    nachlaufzeit1: TTBItem;
    EinblendzeitbeiEffektsynchronisation1: TTBItem;
    N2: TTBSubmenuItem;
    astenkrzel1: TTBItem;
    Popupmenu1: TTBItem;
    KompletteShowstreckenstauchen1: TMenuItem;
    sendtimecodetodll: TTBItem;
    TrackBar2: TTrackBar;
    ScrollbarRefreshTimer: TTimer;
    audioeffekttimer: TSVATimer;
    audioeffektplaytimer: TSVATimer;
    GetAudioeffektTimer: TSVATimer;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel4: TJvLabel;
    JvLabel5: TJvLabel;
    JvLabel6: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure FormCreate(Sender: TObject);
    procedure eq_check1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure eq_scrollbar8Change(Sender: TObject);
    procedure equalizer_progressbar0MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure equalizer_progressbar0MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure reset_eqClick(Sender: TObject);
    procedure reset_eqMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure reset_eqMouseLeave(Sender: TObject);
    procedure reset_eqMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure save_eqClick(Sender: TObject);
    procedure save_eqMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure save_eqMouseLeave(Sender: TObject);
    procedure save_eqMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure audioeffectplayer_volumeChange(Sender: TObject);
    procedure waveform_zoominClick(Sender: TObject);
    procedure waveform_zoomoutClick(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure OpenEffektaudioClick(Sender: TObject);
    procedure SaveEffektaudioClick(Sender: TObject);
    procedure PlayEffektaudioClick(Sender: TObject);
    procedure PauseEffektaudioClick(Sender: TObject);
    procedure StopEffektaudioClick(Sender: TObject);
    procedure recordbtn_offClick(Sender: TObject);
    procedure EditEffektClick(Sender: TObject);
    procedure DeleteEffektClick(Sender: TObject);
    procedure RefreshEffectClick(Sender: TObject);
    procedure AddDirektSzeneClick(Sender: TObject);
    procedure AddSzeneClick(Sender: TObject);
    procedure recordbtn_onClick(Sender: TObject);
    procedure layerboxChange(Sender: TObject);
    procedure layerboxKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox9Click(Sender: TObject);
    procedure effekteeinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RepeataktiviertMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure audioeffektfilenameboxChange(Sender: TObject);
    procedure audioeffektfilenameboxClick(Sender: TObject);
    procedure audioeffektfilenameboxDropDown(Sender: TObject);
    procedure audioeffektscrollbarChange(Sender: TObject);
    procedure waveform_scrollbarChange(Sender: TObject);
    procedure waveformMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure waveformMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure waveformMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MarkiertenEffektausfhren1Click(Sender: TObject);
    procedure MarkiertenEffektstoppen1Click(Sender: TObject);
    procedure MarkierteEffekteverschieben1Click(Sender: TObject);
    procedure MarkiertenEffektaufPositionXsetzen1Click(Sender: TObject);
    procedure Layerffnen1Click(Sender: TObject);
    procedure Layerspeichern1Click(Sender: TObject);
    procedure Layerlschen1Click(Sender: TObject);
    procedure LayerkopierenzuLayer1Click(Sender: TObject);
    procedure Effektlisteffnen1Click(Sender: TObject);
    procedure Effektlistespeichern1Click(Sender: TObject);
    procedure Effektlistelschen1Click(Sender: TObject);
    procedure RecordModus1Click(Sender: TObject);
    procedure Wavedarstellungzweifarbig1Click(Sender: TObject);
    procedure Repeataktiviert1Click(Sender: TObject);
    procedure SprungmarkeanaktuellePosition1Click(Sender: TObject);
    procedure Sprungmarkeverschieben1Click(Sender: TObject);
    procedure ZielmarkeanaktuellePosition1Click(Sender: TObject);
    procedure Zielmarkeverschieben1Click(Sender: TObject);
    procedure Importieren1Click(Sender: TObject);
    procedure Exportieren1Click(Sender: TObject);
    procedure audioeffekttimerTimer(Sender: TObject);
    procedure audioeffektplaytimerTimer(Sender: TObject);
    procedure OpenEffektlisteClick(Sender: TObject);
    procedure SaveEffektlisteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EffektnachlinksMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EffektnachrechtsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure EffektlisteDblClick(Sender: TObject);
    procedure EffektlisteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EffektlisteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EffektlisteDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure EffektlisteMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2Click(Sender: TObject);
    procedure CopyEffekt(Source, Destination,SourceLayer,DestinationLayer: integer);
    procedure EffektSort(iLo, iHi, Layer: Integer);
    procedure seteffecttoactualpositionbtnClick(Sender: TObject);
    procedure Neu1Click(Sender: TObject);
    procedure WavezweifarbigMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LayerComboboxChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure waveformDblClick(Sender: TObject);
    procedure Mausklickssperren1Click(Sender: TObject);
    procedure lockmouseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure WavedarstellungChange(Sender: TObject);
    procedure ScrollBar1Exit(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure TrackBar1Change(Sender: TObject);
    procedure astenkrzel1Click(Sender: TObject);
    procedure RescanAudiofile;
    procedure Waveformneuberechnen1Click(Sender: TObject);
    procedure Popupmenu1Click(Sender: TObject);
    procedure CopyEffektBtnClick(Sender: TObject);
    procedure AktuellesLayeraktualisieren1Click(Sender: TObject);
    procedure VideoscreenbtnClick(Sender: TObject);
    procedure Videoseekingeinrichten1Click(Sender: TObject);
    procedure Effektstarten1Click(Sender: TObject);
    procedure Layernamenbearbeiten1Click(Sender: TObject);
    procedure Effektstoppen1Click(Sender: TObject);
    procedure ObjektausBibliothekstoppen1Click(Sender: TObject);
    procedure Button18MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure layerboxDropDown(Sender: TObject);
    procedure layerboxCloseUp(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure nachlaufzeit1Click(Sender: TObject);
    procedure vorlaufzeit1Click(Sender: TObject);
    procedure Anzeigedeaktivieren1Click(Sender: TObject);
    procedure LoadAllEffectsBeforeNow;
    procedure PlayEffectScene(Layer, Effect: integer; DontFade:boolean);
    procedure EinblendzeitbeiEffektsynchronisation1Click(Sender: TObject);
    procedure CopyAudioeffektfile(Source, Destination:integer);
    procedure movefileupClick(Sender: TObject);
    procedure movefiledownClick(Sender: TObject);
    procedure RefreshAudioeffektfilenamebox;
    procedure RunAllPreviousEffectsBtnOffClick(Sender: TObject);
    procedure RunAllPreviousEffectsBtnClick(Sender: TObject);
    procedure DecodingBPM(newStream: Boolean; startSec, endSec: DOUBLE);
    function GetNewBPM(hBPM: DWORD): single;
    procedure bpmviewClick(Sender: TObject);
    procedure chkBPMCallbackClick(Sender: TObject);
    procedure BPMScanlnge1Click(Sender: TObject);
    procedure BPMWertneusuchen1Click(Sender: TObject);
    procedure BPMScanzyklus1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBPMTimerTimer(Sender: TObject);
    procedure KompletteShowstreckenstauchen1Click(Sender: TObject);
    procedure GetAudioeffektTimerTimer(Sender: TObject);
    procedure sendtimecodetodllClick(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure ScrolltimelineCheckboxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ScrolltimelineCheckboxMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ScrollbarRefreshTimerTimer(Sender: TObject);
    procedure waveformDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private-Deklarationen }
    NoAudiofile:boolean;
    EstimatedTime:TEstimatedTime;
    active:array of boolean;
    fadeoutvolume:boolean;
    FileStream:TFileStream;
    x1,y1,x2,y2:integer;
    mousedownposition:integer;
    destinationlayer:integer;
    copyeffecttothelayer:boolean;
    destinationposition:single;
    scanpeakpercentage:byte;
    R,G,B:Byte;
    GedrehteSchrift:HGDIOBJ;
    AktuellePosition:Int64;
    LastPosition:Double;

    hBPM: DWORD;               // decoding bpm handle
    orgBPM: single;             // original bpm
    info: BASS_CHANNELINFO;
    BPMstart,BPMstop:double;

    LastStartOfRectangle,LastEndOfRectangle,LastRow:integer;
    _scaling : single;
    _scrollbpp:dword;
    _mousepos : integer;
    _dragtimeline : boolean;
    _wavebufL_min : array of smallint;
    _wavebufL_max : array of smallint;
    _wavebufR_min : array of smallint;
    _wavebufR_max : array of smallint;
    _wavebufTime : array of Single;
    _wavedecodeb : array of smallint;
    zoomvert:integer;
    wavposa : integer;
    counta : integer;
    moving:boolean;
  public
    { Public-Deklarationen }
    _bpp : dword;
    _scroll : dword;
    _chan : array[0..3] of HSTREAM;
    _decodechan : HSTREAM;
    _audioeffektlayer:byte;
    _Buffer:TBitmap32;
    _mousedwn : integer;
    waveformscaling:extended;
    effektvorlaufzeit,effektnachlaufzeit,effektsynchrozeit:integer;
    bpmrefreshperiod:double;
    bpmvalue:single;
    bpmscanlength:integer;
    activelayer:array[0..7] of boolean;
    mouseoverlayer,mouseovereffect:integer;
    maxaudioeffekte:array[1..maxaudioeffektlayers] of integer;
    _effektaudioeffektpassed : array[1..maxaudioeffektlayers] of array of boolean;
    _stereowaveform : boolean;
    effektaudioeffektefilename:string;
    recordeffect:boolean;
    refreshingwaveform:boolean;
    timerenabled:boolean;
    dontscanforeffects:boolean;
    dorepeating:boolean;
    effectsenabled:boolean;
    aktualisierungsintervall,oldaktualisierungsintervall:Word;
    function EditDirectScene(Layer, Effect:integer):boolean;
    procedure DrawAudioeffekte;
    procedure RecordAudioeffekt(fadetime: Integer); overload;
    procedure RecordAudioeffekt(ID: TGUID; StopScene:boolean); overload;
    procedure RecordAudioeffekt(ID: TGUID; StopScene:boolean; Layer: integer; IgnoreRecordMode: boolean); overload;
    procedure ScanPeaks(decoder: HSTREAM);
    procedure DrawSpectrum(_Buffer:TCanvas);
    procedure DrawTimeline(_Buffer:TCanvas);
    procedure DrawEffects(_Buffer:TCanvas);
    procedure DrawActualPosition(_Buffer:TCanvas);
    procedure DrawTimecode_Line(_Buffer:TCanvas; position: Single; x,y,linestart,lineend,namey : integer; name : string; Beschreibung: string; cl : TColor; Effektlength:integer; IgnoreScaleAndLayerDrawing: boolean);
    procedure Check_audioeffektbuttons();
    procedure openeffektaudiofile(audioeeffektfile: string);
    function GetPositionInMilliseconds:integer;
    procedure MSGOpen;
    procedure MSGSave;
  end;

var
  audioeffektplayerform: Taudioeffektplayerform;

implementation

uses PCDIMMER, Optionen, devicescenefrm, geraetesteuerungfrm, progressscreen,
  videoscreenfrm, videoscreensynchronisierenfrm, layerbezeichnungenfrm,
  beatfrm, audioeffektplayerstretchfrm, effektsequenzerfrm;

{$R *.dfm}

{------------------------------------------
 ----------- CALLBACK FUNCTIONS -----------
 ------------------------------------------}

// get the bpm after period of time
procedure GetBPM_Callback(handle: DWORD; bpm: single; user: DWORD); stdcall;
var
  tmp: DWORD;
begin
  // don't bother to update the BPM view if it's zero
  if (bpm > 0) then
  begin
    tmp := handle;
    audioeffektplayerform.bpmview.Caption := FormatFloat('###.##', audioeffektplayerform.GetNewBPM(tmp))+' BPM';
  end;
end;

// get the bpm process detection in percents of a decoding channel
procedure GetBPM_Process(chan: DWORD; percent: single); stdcall;
begin
  // update the progress bar
  audioeffektplayerform.bpmprogress.position := round(percent);
  audioeffektplayerform.bpmprogress.visible:=percent<90;
end;

{-----------------------------------------
 --------- End CALLBACK FUNCTIONS --------
 -----------------------------------------}

procedure TColor2RGB(const Color: TColor);
begin
  // convert hexa-decimal values to RGB
  audioeffektplayerform.R := Color and $FF;
  audioeffektplayerform.G := (Color shr 8) and $FF;
  audioeffektplayerform.B := (Color shr 16) and $FF;
end;

// Erstellt ein Farbverlauf von links nach rechts
procedure DrawGradientV(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
var
  Y, R, G, B: Integer;
begin
  for Y := Rect.Left to Rect.Right do begin
    R := Round(GetRValue(Color1) + ((GetRValue(Color2) - GetRValue(Color1)) *
      Y / (Rect.Right - Rect.Left)));
    G := Round(GetGValue(Color1) + ((GetGValue(Color2) - GetGValue(Color1)) *
      Y / (Rect.Right - Rect.Left)));
    B := Round(GetBValue(Color1) + ((GetBValue(Color2) - GetBValue(Color1)) *
      Y / (Rect.Right - Rect.Left)));

    Canvas.Pen.Color := RGB(R, G, B);
    Canvas.Pen.Width := 1;
    Canvas.Pen.Style := psInsideFrame;

    Canvas.MoveTo(Y, Rect.Top);
    Canvas.LineTo(Y, Rect.Bottom);
  end;
end;

// Erstellt ein Farbverlauf von oben nach unten
procedure DrawGradientH(Canvas: TCanvas; Color1, Color2: TColor; Rect: TRect);
var
  X, R, G, B: Integer;
begin
  for X := Rect.Top to Rect.Bottom do begin
    R := Round(GetRValue(Color1) + ((GetRValue(Color2) - GetRValue(Color1)) *
      X / (Rect.Bottom - Rect.Top)));
    G := Round(GetGValue(Color1) + ((GetGValue(Color2) - GetGValue(Color1)) *
      X / (Rect.Bottom - Rect.Top)));
    B := Round(GetBValue(Color1) + ((GetBValue(Color2) - GetBValue(Color1)) *
      X / (Rect.Bottom - Rect.Top)));

    Canvas.Pen.Color := RGB(R, G, B);
    Canvas.Pen.Width := 1;
    Canvas.Pen.Style := psInsideFrame;

    Canvas.MoveTo(Rect.Left, X);
    Canvas.LineTo(Rect.Right, X);
  end;
end;


procedure Taudioeffektplayerform.CreateParams(var Params:TCreateParams);
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

procedure Taudioeffektplayerform.FormCreate(Sender: TObject);
var
  LReg:TRegistry;
  i,j,maxlength:integer;
begin
  TranslateComponent(self);

  _Buffer := TBitmap32.Create;
  _Buffer.Width:= audioeffektplayerform.waveform.Width;
  _Buffer.Height:= audioeffektplayerform.waveform.Height;

  bpmrefreshperiod:=10;
  bpmvalue:=60.0;
  bpmscanlength:=30;
  GedrehteSchrift:=CreateFont(10, 4, 2700, 0, fw_normal, 0, 0, 0, 1, 0, $10, 2, 4, PChar('Arial'));

  waveformscaling:=1;
  NoAudiofile:=true;
  Trackbar1.Height:=trunc(waveform.Height / 11 * 3);

  maxlength := maxzoom * waveform.Width +1;
  setlength(_wavebufL_max, maxlength);
  setlength(_wavebufL_min, maxlength);
  setlength(_wavebufR_max, maxlength);
  setlength(_wavebufR_min, maxlength);
  setlength(_wavebufTime, maxlength);
  setlength(_wavedecodeb, maxlength);

  dontscanforeffects:=true;
  effectsenabled:=true;
  zoomvert:=1000;
  _scaling:=1;

  EstimatedTime:=TEstimatedTime.Create;
  EstimatedTime.MinValue:=0;
  EstimatedTime.MaxValue:=100;

  // Audioeffektplayer initialisieren
	audioeffektfilenamebox.Items.Clear;
	audioeffektfilenamebox.Items.Add(_('Audiodatei hinzufügen...'));
  audioeffektfilenamebox.ItemIndex:=0;
  audioeffektfilenamebox.Text:=audioeffektfilenamebox.Items.Strings[0];
	layerbox.ItemIndex:=0;
  layerboxchange(nil);
  for i:=0 to (maxaudioeffektlayers-1) do
  begin
    LayerCombobox.Checked[i]:=true;
//    LayerCombobox.ItemEnabled[i]:=true;
  	activelayer[i]:=true;
  end;

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          if not LReg.ValueExists('Two-Color-Waveform') then
            LReg.WriteBool('Two-Color-Waveform',True);
          Wavedarstellungzweifarbig1.Checked:=LReg.ReadBool('Two-Color-Waveform');

          if not LReg.ValueExists('BPM-Scantime') then
            LReg.WriteInteger('BPM-Scantime',30);
          bpmscanlength:=LReg.ReadInteger('BPM-Scantime');
          if not LReg.ValueExists('BPM-Scancycle') then
            LReg.WriteInteger('BPM-Scancycle',10);
          bpmrefreshperiod:=LReg.ReadInteger('BPM-Scancycle');

          if not LReg.ValueExists('Vorlaufzeit für Effektsuche') then
            LReg.WriteInteger('Vorlaufzeit für Effektsuche',10);
          effektvorlaufzeit:=LReg.ReadInteger('Vorlaufzeit für Effektsuche');

          if not LReg.ValueExists('DLL-Timecode') then
            LReg.WriteBool('DLL-Timecode',false);
          sendtimecodetodll.Checked:=LReg.ReadBool('DLL-Timecode');

          if not LReg.ValueExists('Nachlaufzeit für Effektsuche') then
            LReg.WriteInteger('Nachlaufzeit für Effektsuche',100);
          effektnachlaufzeit:=LReg.ReadInteger('Nachlaufzeit für Effektsuche');
          if not LReg.ValueExists('Einblendzeit für Effektsynchronisation') then
            LReg.WriteInteger('Einblendzeit für Effektsynchronisation',1000);
          effektsynchrozeit:=LReg.ReadInteger('Einblendzeit für Effektsynchronisation');
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;

  for j:=1 to maxaudioeffektlayers do
	  for i:=0 to maxaudioeffekte[j]-1 do
  		_effektaudioeffektpassed[j][i]:=false;

  AudioeffectSpectrum   := TSpectrum.Create(waveform.Width, waveform.Height);
  AudioeffectSpectrum.Mode         := 1;
  AudioeffectSpectrum.DrawPeak     := true;
  AudioeffectSpectrum.Width        := 5;
  AudioeffectSpectrum.Height       := waveform.Height;
  AudioeffectSpectrum.LineFallOff  := 4;
  AudioeffectSpectrum.PeakFallOff  := 1;
  AudioeffectSpectrum.Pen := clBlue;
  AudioeffectSpectrum.Peak := clWhite;
  AudioeffectSpectrum.BackColor := clBlack;

  audioeffektplaytimer.Enabled:=false;

  Effektliste.Cells[1,0]:=_('Nr.');
  Effektliste.Cells[2,0]:=_('Zeitpunkt');
  Effektliste.Cells[3,0]:=_('Typ');
  Effektliste.Cells[4,0]:=_('Name');
  Effektliste.Cells[5,0]:=_('Dauer');
  Effektliste.Cells[6,0]:=_('Beschreibung');
end;

procedure Taudioeffektplayerform.eq_check1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,v:integer;
begin
for i:=1 to 8 do
  if Sender=TCheckBox(FindComponent('eq_check'+inttostr(i))) then
    if TCheckBox(FindComponent('eq_check'+inttostr(i))).Checked then
      begin
      for v:=0 to 3 do
      case i of
        1: fx[4][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_CHORUS, 1);
        2: fx[5][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_COMPRESSOR, 1);
        3: fx[6][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_DISTORTION, 1);
        4: fx[7][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_ECHO, 1);
        5: fx[8][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_FLANGER, 1);
        6: fx[9][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_GARGLE, 1);
        7: fx[10][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_I3DL2REVERB, 1);
        8: fx[11][v] := BASS_ChannelSetFX(_chan[v], BASS_FX_DX8_REVERB, 1);
      end;
      eq_scrollbar8Change(FindComponent('eq_scrollbar'+inttostr(i)));
      end
      else
      begin
      for v:=0 to 3 do
      case i of
        1: BASS_ChannelRemoveFX(_chan[v], fx[4][v]);
        2: BASS_ChannelRemoveFX(_chan[v], fx[5][v]);
        3: BASS_ChannelRemoveFX(_chan[v], fx[6][v]);
        4: BASS_ChannelRemoveFX(_chan[v], fx[7][v]);
        5: BASS_ChannelRemoveFX(_chan[v], fx[8][v]);
        6: BASS_ChannelRemoveFX(_chan[v], fx[9][v]);
        7: BASS_ChannelRemoveFX(_chan[v], fx[10][v]);
        8: BASS_ChannelRemoveFX(_chan[v], fx[11][v]);
      end;
    end;
end;

procedure Taudioeffektplayerform.eq_scrollbar8Change(Sender: TObject);
var
  v1,v2,v3,v4,v5,v6,v7,v8,i,k:integer;
begin
for i:=1 to 8 do
  if Sender=TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))) then
  begin
    v1 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    v2 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    v3 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position-30;
    v4 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    v5 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    v6 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    v7 := TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    v8 := 20-TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    // give exponential quality to trackbar as Bass more sensitive near 0
    for k:=0 to 3 do
    case i of
      1: begin BASS_FXGetParameters(fx[4][k], @pChorus); pChorus.fWetDryMix:=v1; BASS_FXSetParameters(fx[4][k], @pChorus); end;
      2: begin BASS_FXGetParameters(fx[5][k], @pCompressor); pCompressor.fGain:=v2; BASS_FXSetParameters(fx[5][k], @pCompressor); end;
      3: begin BASS_FXGetParameters(fx[6][k], @pDistortion); pDistortion.fGain:=v3; BASS_FXSetParameters(fx[6][k], @pDistortion); end;
      4: begin BASS_FXGetParameters(fx[7][k], @pEcho); pEcho.fWetDryMix:=v4; BASS_FXSetParameters(fx[7][k], @pEcho); end;
      5: begin BASS_FXGetParameters(fx[8][k], @pFlanger); pFlanger.fWetDryMix:=v5; BASS_FXSetParameters(fx[8][k], @pFlanger); end;
      6: begin BASS_FXGetParameters(fx[9][k], @pGargle); pGargle.dwRateHz:=v6; BASS_FXSetParameters(fx[9][k], @pGargle); end;
      7: begin BASS_FXGetParameters(fx[10][k], @pI3DL2Reverb); pI3DL2Reverb.flDensity:=v7; BASS_FXSetParameters(fx[10][k], @pI3DL2Reverb); end;
      8: begin BASS_FXGetParameters(fx[11][k], @pReverb); pReverb.fReverbMix := -0.012*v8*v8*v8; BASS_FXSetParameters(fx[11][k], @pReverb); end; // gives -96 when bar at 20
    end;
    TLabel(FindComponent('eq_label'+inttostr(i))).Caption:=inttostr(TScrollBar(FindComponent('eq_scrollbar'+inttostr(i))).position);
   end;
end;

procedure Taudioeffektplayerform.equalizer_progressbar0MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  i,k:integer;
begin
  if ((Shift=[ssCtrl]) or (Shift=[ssLeft])) then
  begin
    for i:=0 to 10 do
    if Sender=FindComponent('equalizer_progressbar'+inttostr(i)) then
    begin
      TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=30-trunc((y / TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).height)*30);
      TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=30-trunc((y / TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).height)*30)-1;
      TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=30-trunc((y / TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).height)*30);

      for k:=0 to 3 do
      begin
        BASS_FXGetParameters(eq[i][k], @p);
        p.fgain := 15-30+TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position;
        BASS_FXSetParameters(eq[i][k], @p);
      end;
    end;
  end;
end;

procedure Taudioeffektplayerform.equalizer_progressbar0MouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i,k:integer;
begin
  if ((Shift=[ssCtrl]) or (Shift=[ssLeft])) then
  begin
    for i:=0 to 10 do
    if Sender=FindComponent('equalizer_progressbar'+inttostr(i)) then
    begin
      TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=30-trunc((y / TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).height)*30);
      TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=30-trunc((y / TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).height)*30)-1;
      TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=30-trunc((y / TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).height)*30);

      for k:=0 to 3 do
      begin
        BASS_FXGetParameters(eq[i][k], @p);
        p.fgain := 15-30+TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position;
        BASS_FXSetParameters(eq[i][k], @p);
      end;
    end;
  end;
end;

procedure Taudioeffektplayerform.reset_eqClick(Sender: TObject);
var
  i,k:integer;
begin
  for i:=1 to 8 do
  begin
    TScrollbar(FindComponent('eq_scrollbar'+inttostr(i))).Position:=0;
    TCheckBox(FindComponent('eq_check'+inttostr(i))).Checked:=false;
  end;

  for k:=0 to 3 do
  begin
    BASS_ChannelRemoveFX(_chan[k], fx[4][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[5][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[6][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[7][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[8][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[9][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[10][k]);
    BASS_ChannelRemoveFX(_chan[k], fx[11][k]);
  end;

  for i:=0 to 10 do
  begin
    TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=15;

    for k:=0 to 3 do
    begin
      BASS_FXGetParameters(eq[i][k], @p);
      p.fgain := 15-30+TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position;
      BASS_FXSetParameters(eq[i][k], @p);
    end;
  end;
end;

procedure Taudioeffektplayerform.reset_eqMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  reset_eq.Font.Style:=[];
end;

procedure Taudioeffektplayerform.reset_eqMouseLeave(Sender: TObject);
begin
  reset_eq.Font.Style:=[];
end;

procedure Taudioeffektplayerform.reset_eqMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  reset_eq.Font.Style:=[fsBold];
end;

procedure Taudioeffektplayerform.save_eqClick(Sender: TObject);
var
  i:integer;
begin
  // Effekte speichern
  for i:=1 to 8 do
  begin
    mainform.Waveformdata_record.fadervalues[i]:=TScrollbar(FindComponent('eq_scrollbar'+inttostr(i))).position;
    mainform.Waveformdata_record.effekte[i]:=TCheckBox(FindComponent('eq_check'+inttostr(i))).checked;
  end;

  // Equalizer speichern
  for i:=0 to 10 do
    mainform.Waveformdata_record.equalizer[i]:=TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position;

  // Alle Arrays in großes Array speichern
	if length(mainform.effektaudio_record)>0 then
  begin
	  mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].waveform.fadervalues:=mainform.Waveformdata_record.fadervalues;
	  mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].waveform.equalizer:=mainform.Waveformdata_record.equalizer;
	  mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].waveform.effekte:=mainform.Waveformdata_record.effekte;
  end;
end;

procedure Taudioeffektplayerform.save_eqMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  save_eq.Font.Style:=[];
end;

procedure Taudioeffektplayerform.save_eqMouseLeave(Sender: TObject);
begin
  save_eq.Font.Style:=[];
end;

procedure Taudioeffektplayerform.save_eqMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  save_eq.Font.Style:=[fsBold];
end;

procedure Taudioeffektplayerform.audioeffectplayer_volumeChange(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  if Sender=audioeffectplayer_volume then
  begin
//    Bass_SetVolume(1-audioeffectplayer_volume.Position/100);
    BASS_ChannelSetAttribute(_chan[0], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
    BASS_ChannelSetAttribute(_chan[1], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
    BASS_ChannelSetAttribute(_chan[2], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
    BASS_ChannelSetAttribute(_chan[3], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
    mainform.Effektaudiodatei_record.volume:=100-audioeffectplayer_volume.Position;
    label4.caption:=inttostr(100-audioeffectplayer_volume.Position)+'%';
  end;
end;

procedure Taudioeffektplayerform.waveform_zoominClick(Sender: TObject);
var
  position:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if _scaling<maxzoom then
  begin
  	waveform_scrollbar.Enabled:=true;
    _bpp:=_bpp div 2;
    _scaling:=_scaling * 2;

    ScalingLbl.Caption:=inttostr(trunc(_scaling))+'x';

    if _scaling<>maxzoom then
    begin
      position:=(BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp - _scroll);

      while (trunc(position)>0) do
      begin
        position:=(BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp - _scroll);
        _scroll:=_scroll+1;
      end;
    end;
    if (BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width>0 then
      waveform_scrollbar.Max:=(BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width;
    if (_scroll<=waveform_scrollbar.Max) {and not ScrolltimelineCheckbox.Checked} then
      waveform_scrollbar.position:=_scroll;
  end;
end;

procedure Taudioeffektplayerform.waveform_zoomoutClick(Sender: TObject);
var
  position:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if _scaling>1 then
  begin
    _bpp:=_bpp * 2;
    _scaling:=_scaling/2;

    ScalingLbl.Caption:=inttostr(trunc(_scaling))+'x';

    _scroll:=0;

    if _scaling<>1 then
    begin
      position:=(BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp - _scroll);

      while position<>0 do
      begin
        position:=(BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp - _scroll);
        _scroll:=_scroll+1;
      end;
    end;
    if (BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width>0 then
      waveform_scrollbar.Max:=(BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width;
    if (_scroll<=waveform_scrollbar.Max) {and not ScrolltimelineCheckbox.Checked} then
      waveform_scrollbar.position:=_scroll;
    if not (_scaling>1) then
    	waveform_scrollbar.Enabled:=false;
  end else
  begin
  	waveform_scrollbar.Enabled:=false;
    if (BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width>0 then
      waveform_scrollbar.Max:=(BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width;
    if (_scroll<=waveform_scrollbar.Max) {and not ScrolltimelineCheckbox.Checked} then
      waveform_scrollbar.position:=_scroll;
  end;
end;

procedure Taudioeffektplayerform.Button20Click(Sender: TObject);
var
  i,j,itemindex:integer;
  zusatz,dateiname,dateipfad : string;
//  data : array[0..2000] of SmallInt;
  effektevorhanden:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  OpenDialog.Filter:='Audiodateien|*.wav;*.mp3|*.*|*.*';
  OpenDialog.Title:='Audiodatei öffnen';
  opendialog.FileName:='';
//  if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;

  effektevorhanden:=false;
  for i:=1 to maxaudioeffektlayers do
  begin
  	if maxaudioeffekte[i]>0 then
      effektevorhanden:=true;
  end;

  if effektevorhanden and not (audioeffektfilenamebox.ItemIndex=audioeffektfilenamebox.Items.Count-1) then
		if messagedlg(_('Der bestehenden Audiodatei sind einige Effekte zugeordnet, die möglicherweise noch nicht gespeichert sind. Dennoch fortfahren?'),mtWarning,
			[mbYes,mbNo],0)=mrNo then exit;

  if OpenDialog.Execute then
  begin
    if BASS_ChannelIsActive(_chan[0]) = BASS_ACTIVE_PLAYING then
      StopEffektaudioClick(nil);

  	if (Sender=audioeffektfilenamebox) or (audioeffektfilenamebox.ItemIndex=audioeffektfilenamebox.Items.Count-1) then
	  begin
      NoAudiofile:=false;
	    if audioeffektfilenamebox.ItemIndex=audioeffektfilenamebox.Items.Count-1 then
	    begin
	   	  setlength(mainform.effektaudio_record,length(mainform.effektaudio_record)+1);

		    for j:=1 to maxaudioeffektlayers do
				begin
		      maxaudioeffekte[j]:=0;
				  setlength(mainform.effektaudio_record[audioeffektfilenamebox.Items.Count-1].effektaudiodatei.layer[j].effekt,0);

          mainform.effektaudio_record[audioeffektfilenamebox.Items.Count-1].effektaudiodatei.layer[j].layeractive:=true;
          layercombobox.Checked[j-1]:=true;
          activelayer[j-1]:=true;
		    end;

        audioeffectplayer_volume.Position:=0;
    	  mainform.effektaudio_record[audioeffektfilenamebox.Items.Count-1].effektaudiodatei.volume:=100;

		  	Button20.Enabled:=true;
			  Button21.Enabled:=true;
        for j:=1 to maxaudioeffektlayers do
        begin
      	  mainform.effektaudio_record[audioeffektfilenamebox.Items.Count-1].effektaudiodatei.layername[j]:='Layer '+inttostr(j);
          LayerCombobox.Checked[j-1]:=true;
//          LayerCombobox.ItemEnabled[i]:=true;
          activelayer[j-1]:=true;
        end;
	    end;
      // Am Ende Text erstellen
		  audioeffektfilenamebox.Items.Add(audioeffektfilenamebox.Items.Strings[audioeffektfilenamebox.Items.Count-1]);
		end;
  	dateiname:=extractfilename(OpenDialog.FileName);
	  dateipfad:=extractfilepath(OpenDialog.FileName);

	  itemindex:=audioeffektfilenamebox.ItemIndex;
	  audioeffektfilenamebox.items.Strings[itemindex]:=inttostr(itemindex+1)+' - '+dateiname;
	  audioeffektfilenamebox.Text:=dateiname;
	  audioeffektfilenamebox.itemindex:=itemindex;

    if pos('\ProjectTemp\',dateiname)>0 then
      dateiname:=mainform.userdirectory+copy(dateiname,pos('ProjectTemp\',dateiname),length(dateiname));

	  mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.volume:=100;

	  mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei:=dateiname;
	  mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad:=dateipfad;

    effektaudioeffektefilename := OpenDialog.Filename;

	// Equalizer initiieren
	  for i:=0 to 3 do
	  begin
	    eq[0][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[1][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[2][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[3][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[4][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[5][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[6][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[7][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[8][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[9][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	    eq[10][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
	  end;

	// Set equalizer to flat and reverb off to start
	  p.fGain := 0;
	  p.fBandwidth := 18;
	  for i:=0 to 3 do
	  begin
	    p.fCenter := 80;
	    BASS_FXSetParameters(eq[0][i], @p);
	    p.fCenter := 125;
	    BASS_FXSetParameters(eq[1][i], @p);
	    p.fCenter := 180;
	    BASS_FXSetParameters(eq[2][i], @p);
	    p.fCenter := 300;
	    BASS_FXSetParameters(eq[3][i], @p);
	    p.fCenter := 600;
	    BASS_FXSetParameters(eq[4][i], @p);
	    p.fCenter := 1000;
	    BASS_FXSetParameters(eq[5][i], @p);
	    p.fCenter := 2000;
	    BASS_FXSetParameters(eq[6][i], @p);
	    p.fCenter := 3000;
	    BASS_FXSetParameters(eq[7][i], @p);
	    p.fCenter := 5000;
	    BASS_FXSetParameters(eq[8][i], @p);
	    p.fCenter := 8000;
	    BASS_FXSetParameters(eq[9][i], @p);
	    p.fCenter := 16000;
	    BASS_FXSetParameters(eq[10][i], @p);
	  end;

    // Alle Layers aktivieren
    for i:=1 to maxaudioeffektlayers do
    	activelayer[i-1]:=true;
    for i:=0 to LayerCombobox.Items.Count-1 do
    begin
      LayerCombobox.Checked[i]:=true;
    end;

    if length(effektaudioeffektefilename)>45 then zusatz:='...' else zusatz:='';
    waveform.Hint:=_('Darstellung von ')+effektaudioeffektefilename+zusatz;

    reset_eqClick(Sender);
    save_eqClick(Sender);

    if not (Sender=audioeffektfilenamebox) then
      audioeffektfilenameboxchange(nil);
	end;
end;

procedure Taudioeffektplayerform.Button21Click(Sender: TObject);
var
  index,i:integer;
  effektevorhanden:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  effektevorhanden:=false;
  for i:=1 to maxaudioeffektlayers do
  	if maxaudioeffekte[i]>0 then effektevorhanden:=true;

  if effektevorhanden then
		if messagedlg(_('Der bestehenden Audiodatei sind einige Effekte zugeordnet, die möglicherweise noch nicht gespeichert sind. Dennoch fortfahren?'),mtWarning,
			[mbYes,mbNo],0)=mrNo then exit;

	if (audioeffektfilenamebox.Items.Count>1) and (audioeffektfilenamebox.ItemIndex<audioeffektfilenamebox.Items.Count-1) then
  begin
    index:=audioeffektfilenamebox.ItemIndex;

    // Daten kopieren
    if (audioeffektfilenamebox.Items.Count>2) then
    for i:=audioeffektfilenamebox.ItemIndex to audioeffektfilenamebox.Items.Count-3 do // Count-3=letzter Eintrag, Count-2=neues 'Audiodatei hinzufügen...', Count-1=altes 'Audiodatei hinzufügen...'
    begin
      CopyAudioeffektfile(i+1,i);
      RefreshAudioeffektfilenamebox;
    end;

    // gesamte Arrays um ein Array kürzen
    setlength(mainform.effektaudio_record,length(mainform.effektaudio_record)-1);

    // den derzeitig vorletzten Eintrag wieder als 'Audiodatei hinzufügen...' setzen
		audioeffektfilenamebox.Items.Strings[audioeffektfilenamebox.Items.Count-2]:=_('Audiodatei hinzufügen...');
    // letzten Listeneintrag löschen
    audioeffektfilenamebox.Items.Delete(audioeffektfilenamebox.Items.Count-1);
    // Itemindex setzen
    if index=audioeffektfilenamebox.Items.Count-1 then
    	audioeffektfilenamebox.ItemIndex:=0
    else
		  audioeffektfilenamebox.ItemIndex:=index;
    audioeffektfilenameboxchange(Sender);
  end;

	if (audioeffektfilenamebox.Items.Count=1) then
  begin
    for i:=1 to maxaudioeffektlayers do
    begin
      maxaudioeffekte[i]:=0;
	    setlength(mainform.Effektaudiodatei_record.layer[i].effekt,0);
    end;
  	button18.Enabled:=false;
    seteffecttoactualpositionbtn.Enabled:=false;
//  	button20.Enabled:=false;
    button21.Enabled:=false;
    if audioeffektfilenamebox.Items.Count=1 then
    begin
	    Dateispeichern1.Enabled:=false;
      OpenEffektliste.Enabled:=false;
      SaveEffektliste.Enabled:=false;
    	Effektlistespeichern1.Enabled:=false;
      RepeatModus1.Enabled:=false;
      Videoseekingeinrichten1.Enabled:=false;
    	Effektlisteffnen1.Enabled:=false;
    	Effektlistelschen1.Enabled:=false;
    end;
    layerbox.ItemIndex:=0;
    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
	  layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.OpenEffektaudioClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  opendialog.Title:=_('PC_DIMMER Effektaudio öffnen...');
  opendialog.Filter:=_('PC_DIMMER Effektaudio (*.pcdeaud)|*.pcdeaud|*.*|*.*');
  opendialog.FileName:='';
  opendialog.DefaultExt:='*.pcdeaud';
//  if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
  if opendialog.execute then
  begin
    openeffektaudiofile(opendialog.filename);
  end;
end;

procedure Taudioeffektplayerform.SaveEffektaudioClick(Sender: TObject);
var
  filename,filepath:string;
 	laenge,Count,Count2,effektanzahl,i,j,k,l,m:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  savedialog.Title:=_('PC_DIMMER Effektaudio speichern...');
  savedialog.Filter:=_('PC_DIMMER Effektaudio (*.pcdeaud)|*.pcdeaud|*.*|*.*');
  savedialog.FileName:='';
  savedialog.DefaultExt:='*.pcdeaud';
  if savedialog.execute then
  begin
		audioeffektfilenameboxDropDown(nil);
    filename:=extractfilename(savedialog.filename);
    filepath:=extractfilepath(savedialog.filename);
//	  audioeffektfilenamebox.Width:=137;

    save_eqClick(Sender);

    If not DirectoryExists(mainform.userdirectory+'Temp') then
      ForceDirectories(mainform.userdirectory+'Temp');
    DeleteFile(mainform.userdirectory+'Temp\*.*');
    //Datei öffnen
		FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektaudio',fmCreate);

    // Projektversion
    count:=mainform.currentprojectversion;
    Filestream.WriteBuffer(Count, sizeof(Count));

    //Länge der Arrays feststellen und als erstes abspeichern
    laenge:=length(mainform.effektaudio_record);
    FileStream.WriteBuffer(laenge,sizeof(laenge));
    // nun alle Arrays einzeln nacheinander speichern
    for i:=0 to laenge-1 do
    begin
      if pos('\ProjectTemp\',mainform.effektaudio_record[i].audiopfad)>0 then
        mainform.effektaudio_record[i].audiopfad:=mainform.userdirectory+copy(mainform.effektaudio_record[i].audiopfad,pos('ProjectTemp\',mainform.effektaudio_record[i].audiopfad),length(mainform.effektaudio_record[i].audiopfad));

			Filestream.WriteBuffer(mainform.effektaudio_record[i].audiodatei,sizeof(mainform.effektaudio_record[i].audiodatei));
			Filestream.WriteBuffer(mainform.effektaudio_record[i].audiopfad,sizeof(mainform.effektaudio_record[i].audiopfad));
      Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layeranzahl,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layeranzahl));
      // Einzelne Layer und Effekte speichern
      for j:=1 to maxaudioeffektlayers do
      begin
        // Effektanzahl herausfinden und abspeichern
	      effektanzahl:=length(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt);
        FileStream.WriteBuffer(effektanzahl,sizeof(effektanzahl));
        // Effektarray abspeichern
        for k:=0 to effektanzahl-1 do
        begin
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ID,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ID));
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Name,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Name));
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Beschreibung,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Beschreibung));
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].StopScene,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].StopScene));
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].audioeffektposition,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].audioeffektposition));
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].UseIDScene,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].UseIDScene));
	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].fadetime,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].fadetime));
//	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ch,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ch));
//	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].active,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].active));
          Count:=length(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices);
	        Filestream.WriteBuffer(Count,sizeof(Count));
          for l:=0 to Count-1 do
          begin
  	        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ID,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ID));
            Count2:=length(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive);
  	        Filestream.WriteBuffer(Count2,sizeof(Count2));
            for m:=0 to Count2-1 do
            begin
  	          Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive[m],sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive[m]));
  	          Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue[m],sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue[m]));
  	          Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom[m],sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom[m]));
  	          Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom[m],sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom[m]));
  	          Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay[m],sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay[m]));
  	          Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime[m],sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime[m]));
            end;
          end;
      	end;
        Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.layer[j].layeractive,sizeof(mainform.effektaudio_record[i].effektaudiodatei.layer[j].layeractive));
      end;
			Filestream.WriteBuffer(mainform.effektaudio_record[i].waveform,sizeof(mainform.effektaudio_record[i].waveform));
      Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.repeatjump,sizeof(mainform.effektaudio_record[i].effektaudiodatei.repeatjump));
      Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.repeatdestination,sizeof(mainform.effektaudio_record[i].effektaudiodatei.repeatdestination));
      Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.repeatactive,sizeof(mainform.effektaudio_record[i].effektaudiodatei.repeatactive));
      Filestream.WriteBuffer(mainform.effektaudio_record[i].effektaudiodatei.volume,sizeof(mainform.effektaudio_record[i].effektaudiodatei.volume));
      Filestream.WriteBuffer(mainform.Effektaudio_record[i].effektaudiodatei.videoseeking,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.videoseeking));
      Filestream.WriteBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layername,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layername));
    end;
		//Datei wieder freigeben
    FileStream.Free;

    mainform.Compress.CompressDirectory(mainform.userdirectory+'Temp\',false,filepath+filename);
    inprogress.Hide;
    DeleteFile(mainform.userdirectory+'Temp\*.*');
  end;
end;

procedure Taudioeffektplayerform.PlayEffektaudioClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

{
  if RunAllPreviousEffectsBtn.visible and effectsenabled then
  begin
    LoadAllEffectsBeforeNow;
  end;
}

  BASS_ChannelSetPosition(_chan[1],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[2],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[3],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE), BASS_POS_BYTE);
  LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  if (videoscreenform<>nil) then
  if (videoscreenform.Showing) then
  begin
    if mainform.Effektaudiodatei_record.videoseeking[1].enabled then
      videoscreenform.Filtergraph1.Play;
    if mainform.Effektaudiodatei_record.videoseeking[2].enabled then
      videoscreenform.Filtergraph2.Play;
    if mainform.Effektaudiodatei_record.videoseeking[3].enabled then
      videoscreenform.Filtergraph3.Play;
    if mainform.Effektaudiodatei_record.videoseeking[4].enabled then
      videoscreenform.Filtergraph4.Play;
  end;

  audioeffektplaytimer.enabled:=true;
  PlayEffektaudio.Enabled:=false;
  StopEffektaudio.Enabled:=true;
  PauseEffektaudio.Enabled:=true;
  GetAudioeffektTimer.Enabled:=true;

//  if (mainform.sounddevicespeakers and 1)=1 then BASS_SetVolume(100) else BASS_SetVolume(0);
//  Bass_SetVolume(100-audioeffectplayer_volume.Position);
  BASS_ChannelPlay(_chan[0], False);
  if (mainform.sounddevicespeakers and 2)=2 then BASS_ChannelPlay(_chan[1], False);
  if (mainform.sounddevicespeakers and 4)=4 then BASS_ChannelPlay(_chan[2], False);
  if (mainform.sounddevicespeakers and 8)=8 then BASS_ChannelPlay(_chan[3], False);

  BASS_ChannelSetAttribute(_chan[0], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
  BASS_ChannelSetAttribute(_chan[1], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
  BASS_ChannelSetAttribute(_chan[2], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
  BASS_ChannelSetAttribute(_chan[3], BASS_ATTRIB_VOL, 1-audioeffectplayer_volume.Position/100);
  mainform.SendMSG(MSG_AUDIOEFFECTPLAYEREVENT, 0, 0);
end;

procedure Taudioeffektplayerform.PauseEffektaudioClick(Sender: TObject);
var
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for j:=1 to maxaudioeffektlayers do
	begin
    for i:=0 to maxaudioeffekte[j]-1 do
    begin
     	_effektaudioeffektpassed[j][i]:=false;
      if mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene then
        mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID);
    end;
  end;

  if videoscreenform<>nil then
  if (videoscreenform.Showing) then
  begin
    if mainform.Effektaudiodatei_record.videoseeking[1].enabled then
      videoscreenform.Filtergraph1.Pause;
    if mainform.Effektaudiodatei_record.videoseeking[2].enabled then
      videoscreenform.Filtergraph2.Pause;
    if mainform.Effektaudiodatei_record.videoseeking[3].enabled then
      videoscreenform.Filtergraph3.Pause;
    if mainform.Effektaudiodatei_record.videoseeking[4].enabled then
      videoscreenform.Filtergraph4.Pause;
  end;

  BASS_ChannelPause(_chan[0]);
  BASS_ChannelPause(_chan[1]);
  BASS_ChannelPause(_chan[2]);
  BASS_ChannelPause(_chan[3]);

  BASS_ChannelSetPosition(_chan[1],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[2],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[3],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE), BASS_POS_BYTE);
  LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  audioeffektplaytimer.enabled:=false;

  PlayEffektaudio.Enabled:=true;
  PauseEffektaudio.Enabled:=false;
  StopEffektaudio.Enabled:=true;

  waveform_zoomin.Enabled:=true;
  waveform_zoomout.Enabled:=true;
//	audioeffekttimerTimer(Sender);
  mainform.SendMSG(MSG_AUDIOEFFECTPLAYEREVENT, 1, 0);
end;

procedure Taudioeffektplayerform.StopEffektaudioClick(Sender: TObject);
var
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  for j:=1 to maxaudioeffektlayers do
	begin
    for i:=0 to maxaudioeffekte[j]-1 do
    begin
     	_effektaudioeffektpassed[j][i]:=false;
      if mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene then
        mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID);
    end;
  end;

  if videoscreenform<>nil then
  if (videoscreenform.Showing) then
  begin
    if mainform.Effektaudiodatei_record.videoseeking[1].enabled then
    begin
      videoscreenform.Filtergraph1.Stop;
      videoscreenform.SetVideoPosition(1,0);
    end;
    if mainform.Effektaudiodatei_record.videoseeking[2].enabled then
    begin
      videoscreenform.Filtergraph2.Stop;
      videoscreenform.SetVideoPosition(2,0);
    end;
    if mainform.Effektaudiodatei_record.videoseeking[3].enabled then
    begin
      videoscreenform.Filtergraph3.Stop;
      videoscreenform.SetVideoPosition(3,0);
    end;
    if mainform.Effektaudiodatei_record.videoseeking[4].enabled then
    begin
      videoscreenform.Filtergraph4.Stop;
      videoscreenform.SetVideoPosition(4,0);
    end;
  end;

  BASS_ChannelStop(_chan[0]);
  BASS_ChannelStop(_chan[1]);
  BASS_ChannelStop(_chan[2]);
  BASS_ChannelStop(_chan[3]);

{
  BASS_ChannelPause(_chan[0]);
  BASS_ChannelPause(_chan[1]);
  BASS_ChannelPause(_chan[2]);
  BASS_ChannelPause(_chan[3]);
}
  audioeffektplaytimer.enabled:=false;
  audioeffektscrollbar.Position:=0;

  fadeoutvolume:=false;
//  mainform.volumeslider.Position:=oldvolume;

  BASS_ChannelSetPosition(_chan[0],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[1],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[2],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
  BASS_ChannelSetPosition(_chan[3],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
  LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  PlayEffektaudio.Enabled:=true;
  PauseEffektaudio.Enabled:=false;
  StopEffektaudio.Enabled:=false;

  waveform_zoomin.Enabled:=true;
  waveform_zoomout.Enabled:=true;
//	audioeffekttimerTimer(Sender);
//	if effektliste.Enabled then effektliste.SetFocus;
  mainform.SendMSG(MSG_AUDIOEFFECTPLAYEREVENT, 2, 0);
end;

procedure Taudioeffektplayerform.recordbtn_offClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

	// Record ausschalten
	recordbtn_on.Visible:=true;
  recordbtn_off.Visible:=false;
  RecordModus1.Checked:=false;

  recordingimage.Visible:=RecordModus1.Checked;
end;

procedure Taudioeffektplayerform.EditEffektClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].UseIDScene then
    begin
      mainform.EditScene(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].ID);
    end else
    begin
      EditDirectScene(_audioeffektlayer, effektliste.Selection.Top-1);
    end;
    layerboxchange(nil);
  end;
end;

function Taudioeffektplayerform.EditDirectScene(Layer, Effect:integer):boolean;
var
  i,j,k,h,min,s,ms,t:integer;
  h_str,min_str,s_str,ms_str:string;
begin
  Result:=false;

  // Geräteszene editieren
  // Effektposition anzeigen
  t:=trunc(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].audioeffektposition*1000);
  h_str:=inttostr(t div 3600000); t:=t mod 3600000;
  min_str:=inttostr(t div 60000); t:=t mod 60000;
  s_str:=inttostr(t div 1000); t:=t mod 1000;
  ms_str:=inttostr(t);
  if length(min_str)=1 then min_str:='0'+min_str;
  if length(s_str)=1 then s_str:='0'+s_str;
  if length(ms_str)=1 then ms_str:='0'+ms_str;
  if length(ms_str)=2 then ms_str:='0'+ms_str;

  mainform.AktuelleDeviceScene.Name:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Name;
  mainform.AktuelleDeviceScene.Beschreibung:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Beschreibung;//effektliste.Cells[1,effektliste.Selection.Top]+' bei Zeit '+h_str+'h '+min_str+'min '+s_str+'s '+ms_str+'ms';
  devicesceneform.Szenenname.Text:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Name;
  devicesceneform.Szenenbeschreibung.Text:=mainform.AktuelleDeviceScene.Beschreibung;
  mainform.AktuelleDeviceScene.Fadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;

  t:=mainform.AktuelleDeviceScene.Fadetime;
  h:=t div 3600000;
  t:=t mod 3600000;
  min:=t div 60000;
  t:=t mod 60000;
  s:=t div 1000;
  t:=t mod 1000;
  ms:=t;

  devicesceneform.scenefade_time_h.Text:=inttostr(h);
  devicesceneform.scenefade_time_min.Text:=inttostr(min);
  devicesceneform.scenefade_time.Text:=inttostr(s);
  devicesceneform.scenefade_time_msec.Text:=inttostr(ms);

  setlength(mainform.AktuelleDeviceScene.Devices,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices));

  for i:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices)-1 do
  begin
    mainform.AktuelleDeviceScene.Devices[i].ID:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ID;
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanActive,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActive));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanValue,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValue));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActiveRandom));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValueRandom));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanDelay,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanDelay));
    setlength(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime,length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanFadetime));
    for j:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActive)-1 do
    begin
      mainform.AktuelleDeviceScene.Devices[i].ChanActive[j]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActive[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanValue[j]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValue[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[j]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActiveRandom[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[j]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValueRandom[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanDelay[j]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanDelay[j];
      mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[j]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanFadetime[j];
    end;
  end;

  setlength(mainform.AktuelleDeviceScene.Befehle, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle));
  setlength(mainform.AktuelleDeviceScene.Befehlswerte, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte));
  for i:=0 to length(mainform.AktuelleDeviceScene.Befehle)-1 do
  begin
    mainform.AktuelleDeviceScene.Befehle[i].ID:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ID;
    mainform.AktuelleDeviceScene.Befehle[i].Typ:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Typ;
    mainform.AktuelleDeviceScene.Befehle[i].Name:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Name;
    mainform.AktuelleDeviceScene.Befehle[i].Beschreibung:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Beschreibung;
    mainform.AktuelleDeviceScene.Befehle[i].OnValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].OnValue;
    mainform.AktuelleDeviceScene.Befehle[i].OffValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].OffValue;
    mainform.AktuelleDeviceScene.Befehle[i].SwitchValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].SwitchValue;
    mainform.AktuelleDeviceScene.Befehle[i].InvertSwitchValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].InvertSwitchValue;
    mainform.AktuelleDeviceScene.Befehle[i].ScaleValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ScaleValue;

    setlength(mainform.AktuelleDeviceScene.Befehle[i].ArgInteger, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgInteger));
    setlength(mainform.AktuelleDeviceScene.Befehle[i].ArgString, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgString));
    setlength(mainform.AktuelleDeviceScene.Befehle[i].ArgGUID, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgGUID));
    for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgInteger)-1 do
      mainform.AktuelleDeviceScene.Befehle[i].ArgInteger[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgInteger[k];
    for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgString)-1 do
      mainform.AktuelleDeviceScene.Befehle[i].ArgString[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgString[k];
    for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgGUID)-1 do
      mainform.AktuelleDeviceScene.Befehle[i].ArgGUID[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgGUID[k];

    setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive));
    setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValue));
    setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActiveRandom));
    setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValueRandom));
    setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanDelay));
    setlength(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime, length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanFadetime));
    for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive)-1 do
    begin
      mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive[k];
      mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValue[k];
      mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActiveRandom[k];
      mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValueRandom[k];
      mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanDelay[k];
      mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[k]:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanFadetime[k];
    end;
  end;

  devicesceneform.ShowModal;

  devicesceneform.Szenenname.Enabled:=true;
  devicesceneform.Szenenbeschreibung.Enabled:=true;

  if devicesceneform.ModalResult=mrOK then
  begin
    mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime:=mainform.AktuelleDeviceScene.Fadetime;

    setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices,length(mainform.AktuelleDeviceScene.Devices));
    for i:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices)-1 do
    begin
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ID:=mainform.AktuelleDeviceScene.Devices[i].ID;
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActive,length(mainform.AktuelleDeviceScene.Devices[i].ChanActive));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValue,length(mainform.AktuelleDeviceScene.Devices[i].ChanValue));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValueRandom,length(mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanDelay,length(mainform.AktuelleDeviceScene.Devices[i].ChanDelay));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanFadetime,length(mainform.AktuelleDeviceScene.Devices[i].ChanFadetime));
      for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActive)-1 do
      begin
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActive[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanActive[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValue[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanValue[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanActiveRandom[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanValueRandom[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanDelay[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanDelay[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[i].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Devices[i].ChanFadetime[k];
      end;
    end;

    setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle, length(mainform.AktuelleDeviceScene.Befehle));
    setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte, length(mainform.AktuelleDeviceScene.Befehlswerte));
    for i:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle)-1 do
    begin
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ID:=mainform.AktuelleDeviceScene.Befehle[i].ID;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Typ:=mainform.AktuelleDeviceScene.Befehle[i].Typ;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Name:=mainform.AktuelleDeviceScene.Befehle[i].Name;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Beschreibung:=mainform.AktuelleDeviceScene.Befehle[i].Beschreibung;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].OnValue:=mainform.AktuelleDeviceScene.Befehle[i].OnValue;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].OffValue:=mainform.AktuelleDeviceScene.Befehle[i].OffValue;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].SwitchValue:=mainform.AktuelleDeviceScene.Befehle[i].SwitchValue;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].InvertSwitchValue:=mainform.AktuelleDeviceScene.Befehle[i].InvertSwitchValue;
      mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ScaleValue:=mainform.AktuelleDeviceScene.Befehle[i].ScaleValue;

      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgInteger, length(mainform.AktuelleDeviceScene.Befehle[i].ArgInteger));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgString, length(mainform.AktuelleDeviceScene.Befehle[i].ArgString));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgGUID, length(mainform.AktuelleDeviceScene.Befehle[i].ArgGUID));
      for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgInteger)-1 do
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgInteger[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgInteger[k];
      for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgString)-1 do
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgString[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgString[k];
      for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgGUID)-1 do
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ArgGUID[k]:=mainform.AktuelleDeviceScene.Befehle[i].ArgGUID[k];

      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValue,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActiveRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValueRandom,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanDelay,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay));
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanFadetime,length(mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime));
      for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive)-1 do
      begin
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActive[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValue[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValue[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActiveRandom[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanActiveRandom[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValueRandom[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanValueRandom[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanDelay[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanDelay[k];
        mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanFadetime[k]:=mainform.AktuelleDeviceScene.Befehlswerte[i].ChanFadetime[k];
      end;
    end;

    // Fadezeit in Speicher schreiben
    t:=strtoint(devicesceneform.scenefade_time_msec.Text);
    t:=t+1000*strtoint(devicesceneform.scenefade_time.Text);
    t:=t+60*1000*strtoint(devicesceneform.scenefade_time_min.Text);
    t:=t+60*60*1000*strtoint(devicesceneform.scenefade_time_h.Text);

    mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Name:=devicesceneform.Szenenname.Text;
    mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Beschreibung:=devicesceneform.Szenenbeschreibung.Text;
    effektliste.Cells[4,Effect]:=mainform.AktuelleDeviceScene.Name;
    mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Fadetime:=t;
  end;
end;

procedure Taudioeffektplayerform.DeleteEffektClick(Sender: TObject);
var
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    if messagedlg(_('Alle markierten Effekte löschen?'),mtConfirmation,[mbYes,mbNo],0) = mrYes then
  	begin
      for i:=length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1 downto 0 do
  	 	begin
      	if active[i+1] then
        begin
  		    // Daten kopieren
  		    if (i<length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1) then
            for j:=i to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-2 do
              CopyEffekt(j+1,j,_audioeffektlayer,_audioeffektlayer);

  		    // gesamte Arrays um ein Element kürzen
  	      setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1);
  	      setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])-1);
  	      setlength(active,length(active)-1);
  	      maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]-1;
        end;
      end;

      for i:=0 to length(active)-1 do
        active[i]:=false;

  	  layerboxchange(nil);
  	  check_audioeffektbuttons();
  //		audioeffekttimerTimer(Sender);
    end;
  end;
end;

procedure Taudioeffektplayerform.RefreshEffectClick(Sender: TObject);
var
  i,j,PositionInDevicearray:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  PositionInDevicearray:=0;

if (_audioeffektlayer>0) and (effektliste.rowCount>1) then
begin
if messagedlg(_('Der aktuelle Effekt wird mit den aktuellen Kanalwerten aktualisiert. Fortsetzen?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.top-1].UseIDScene then
    begin
      for i:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.top-1].Devices)-1 do
      begin
        // Startadresse herausfinden
        for j:=0 to length(mainform.Devices)-1 do
        begin
          if IsEqualGUID(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.top-1].Devices[i].ID,mainform.Devices[j].ID) then
          begin
            PositionInDevicearray:=j;
            break;
          end;
        end;

        for j:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.top-1].Devices[i].ChanActive)-1 do
        begin
          if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.top-1].Devices[i].ChanActive[j] then
          begin
            mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.top-1].Devices[i].ChanValue[j]:=255-mainform.data.ch[mainform.Devices[PositionInDevicearray].Startaddress+j];
          end;
        end;
      end;
    end;
  end;
end;
end;

procedure Taudioeffektplayerform.AddDirektSzeneClick(Sender: TObject);
var
  j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if (_audioeffektlayer>0) and (audioeffektfilenamebox.Items.Count>1) then
  begin
    j:=maxaudioeffekte[_audioeffektlayer]-1;

    // Effektarrays um 1 erhöhen
   	setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
    setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
    maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
    j:=j+1;

    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].fadetime:=0;
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

    EditDirectScene(_audioeffektlayer, j);

    if effektliste.RowCount=2 then Check_audioeffektbuttons();

    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.AddSzeneClick(Sender: TObject);
var
  j:integer;
  position:single;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  position:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  if (_audioeffektlayer>0) and (audioeffektfilenamebox.Items.Count>1) then
  begin
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:=_('Objekt aus Bibliothek starten...');

//    if szenenverwaltungform.showmodal=mrOK then
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      Data:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

      j:=maxaudioeffekte[_audioeffektlayer]-1;

      // Effektarrays um 1 erhöhen
      setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
      setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
      maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
    	j:=j+1;

      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].fadetime:=0;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].StopScene:=false;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition := position;

      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].UseIDScene:=true;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].ID:=Data^.ID;

      {if effektliste.RowCount=2 then} Check_audioeffektbuttons();
//    	audioeffekttimerTimer(Sender);

      if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
        EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
      layerboxchange(nil);
    end;

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
  end;
end;

procedure Taudioeffektplayerform.recordbtn_onClick(Sender: TObject);
begin
	// Record einschalten
	recordbtn_on.Visible:=false;
  recordbtn_off.Visible:=true;
  RecordModus1.Checked:=true;

  recordingimage.Visible:=RecordModus1.Checked;
end;

procedure Taudioeffektplayerform.layerboxChange(Sender: TObject);
var
	i,j,k,lastrow,gesamtzeit:integer;
  effektnummer_str:string;
  t:integer;
  h,min,s,ms:string;
begin
  LockWindow(Effektliste.Handle);
//  lastrow:=0;
//  if Sender=nil then
  lastrow:=Effektliste.Row;

  _audioeffektlayer:=layerbox.ItemIndex;
  Trackbar2.Visible:=_audioeffektlayer>0;

  effektliste.RowCount:=2;
  Effektliste.Cells[1,0]:=_('Nr.');
  Effektliste.Cells[2,0]:=_('Zeitpunkt');
  Effektliste.Cells[3,0]:=_('Typ');
  Effektliste.Cells[4,0]:=_('Name');
  Effektliste.Cells[5,0]:=_('Dauer');
  Effektliste.Cells[6,0]:=_('Beschreibung');

  effektliste.Cells[0,1]:='';
  effektliste.Cells[1,1]:='';
  effektliste.Cells[2,1]:='';
  effektliste.Cells[3,1]:='';
  effektliste.Cells[4,1]:='';
  effektliste.Cells[5,1]:='';
  effektliste.Cells[6,1]:='';

  if _audioeffektlayer>0 then
  begin
    waveformscaling:=TrackBar2.Position/100;
    Trackbar1Change(nil);

    layerffnen1.Enabled:=true;
    Layernamenbearbeiten1.Enabled:=true;
    layerspeichern1.Enabled:=true;
    Layerlschen1.Enabled:=true;
    LayerkopierenzuLayer1.enabled:=true;

    LockWindow(effektliste.Handle);
    if maxaudioeffekte[_audioeffektlayer]>0 then
    begin
      for i:=0 to maxaudioeffekte[_audioeffektlayer]-1 do
      begin
        effektnummer_str:=inttostr(i);
        if length(effektnummer_str)<2 then effektnummer_str:='0'+effektnummer_str;
        if length(effektnummer_str)<3 then effektnummer_str:='0'+effektnummer_str;
        if length(effektnummer_str)<4 then effektnummer_str:='0'+effektnummer_str;
        effektliste.RowCount:=i+2;
        effektliste.Cells[1,i+1]:=effektnummer_str; // Effektnummer

        t:=trunc(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition*1000);
        h:=inttostr(t div 3600000); t:=t mod 3600000;
        min:=inttostr(t div 60000); t:=t mod 60000;
        s:=inttostr(t div 1000); t:=t mod 1000;
        ms:=inttostr(t);
        if length(min)=1 then min:='0'+min;
        if length(s)=1 then s:='0'+s;
        if length(ms)=1 then ms:='0'+ms;
        if length(ms)=2 then ms:='0'+ms;
        effektliste.Cells[2,i+1]:=h+':'+min+':'+s+':'+ms; // Zeitpunkt

        if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].UseIDScene then
        begin
          if mainform.DoesSceneExists(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
          begin
            // Einfache Szene
            for j:=0 to length(mainform.EinfacheSzenen)-1 do
            begin
              if IsEqualGUID(mainform.EinfacheSzenen[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Einfache Szene stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Einfache Szene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.EinfacheSzenen[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.EinfacheSzenen[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.EinfacheSzenen[j].Beschreibung;
                t:=mainform.EinfacheSzenen[j].einblendzeit;
                h:=inttostr(t div 3600000); t:=t mod 3600000;
                min:=inttostr(t div 60000); t:=t mod 60000;
                s:=inttostr(t div 1000); t:=t mod 1000;
                ms:=inttostr(t);
                if length(min)=1 then min:='0'+min;
                if length(s)=1 then s:='0'+s;
                if length(ms)=1 then ms:='0'+ms;
                if length(ms)=2 then ms:='0'+ms;
                if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms
                else
                  effektliste.Cells[5,i+1]:='-';

                effektliste.Cells[6,i+1]:=mainform.EinfacheSzenen[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=mainform.EinfacheSzenen[j].einblendzeit;
                break;
              end;
            end;
            // Geräteszenen
            for j:=0 to length(mainform.Devicescenes)-1 do
            begin
              if IsEqualGUID(mainform.Devicescenes[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Geräteszene stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Geräteszene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Devicescenes[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Devicescenes[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Devicescenes[j].Beschreibung;
                t:=mainform.Devicescenes[j].fadetime;
                h:=inttostr(t div 3600000); t:=t mod 3600000;
                min:=inttostr(t div 60000); t:=t mod 60000;
                s:=inttostr(t div 1000); t:=t mod 1000;
                ms:=inttostr(t);
                if length(min)=1 then min:='0'+min;
                if length(s)=1 then s:='0'+s;
                if length(ms)=1 then ms:='0'+ms;
                if length(ms)=2 then ms:='0'+ms;
                if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms
                else
                  effektliste.Cells[5,i+1]:='-';

                effektliste.Cells[6,i+1]:=mainform.Devicescenes[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=mainform.DeviceScenes[j].Fadetime;
                break;
              end;
            end;
            // Audioszene
            for j:=0 to length(mainform.Audioszenen)-1 do
            begin
              if IsEqualGUID(mainform.Audioszenen[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Audioszene stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Audioszene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Audioszenen[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Audioszenen[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Audioszenen[j].Beschreibung;
                t:=mainform.Audioszenen[j].dauer;
                h:=inttostr(t div 3600000); t:=t mod 3600000;
                min:=inttostr(t div 60000); t:=t mod 60000;
                s:=inttostr(t div 1000); t:=t mod 1000;
                ms:=inttostr(t);
                if length(min)=1 then min:='0'+min;
                if length(s)=1 then s:='0'+s;
                if length(ms)=1 then ms:='0'+ms;
                if length(ms)=2 then ms:='0'+ms;
                if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms
                else
                  effektliste.Cells[5,i+1]:='-';

                effektliste.Cells[6,i+1]:=mainform.Audioszenen[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=mainform.Audioszenen[j].dauer;
                break;
              end;
            end;
            // Bewegungsszene
            for j:=0 to length(mainform.Bewegungsszenen)-1 do
            begin
              if IsEqualGUID(mainform.Bewegungsszenen[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Bewegungsszene stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Bewegungsszene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Bewegungsszenen[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Bewegungsszenen[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Bewegungsszenen[j].Beschreibung;

                if mainform.Bewegungsszenen[j].repeats>0 then
                begin
                  t:=mainform.Bewegungsszenen[j].dauer*mainform.Bewegungsszenen[j].repeats;
                  h:=inttostr(t div 3600000); t:=t mod 3600000;
                  min:=inttostr(t div 60000); t:=t mod 60000;
                  s:=inttostr(t div 1000); t:=t mod 1000;
                  ms:=inttostr(t);
                  if length(min)=1 then min:='0'+min;
                  if length(s)=1 then s:='0'+s;
                  if length(ms)=1 then ms:='0'+ms;
                  if length(ms)=2 then ms:='0'+ms;

                  if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                    effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms
                  else
                    effektliste.Cells[5,i+1]:='-';
                end else
                begin
                  if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                    effektliste.Cells[5,i+1]:=_('Unbegrenzt')
                  else
                    effektliste.Cells[5,i+1]:='-';
                end;

                effektliste.Cells[6,i+1]:=mainform.Bewegungsszenen[j].Beschreibung; // Beschreibung
                if (mainform.Bewegungsszenen[j].repeats>0) and not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=mainform.Bewegungsszenen[j].dauer*mainform.Bewegungsszenen[j].repeats
                else
                  mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=0;
                break;
              end;
            end;
            // Befehl
            for j:=0 to length(mainform.Befehle2)-1 do
            begin
              if IsEqualGUID(mainform.Befehle2[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Befehl stoppen (nicht möglich!)') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Befehl starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Befehle2[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Befehle2[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Befehle2[j].Beschreibung;
                effektliste.Cells[5,i+1]:='-'; // Fadezeit
                effektliste.Cells[6,i+1]:=mainform.Befehle2[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=0;
                break;
              end;
            end;
            // Komposition
            for j:=0 to length(mainform.Kompositionsszenen)-1 do
            begin
              if IsEqualGUID(mainform.Kompositionsszenen[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Kombinationsszene stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Kombinationsszene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Kompositionsszenen[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Kompositionsszenen[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Kompositionsszenen[j].Beschreibung;
                effektliste.Cells[5,i+1]:='-'; // Fadezeit
                effektliste.Cells[6,i+1]:=mainform.Kompositionsszenen[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=0;
                break;
              end;
            end;
            // Automatikszene
            for j:=0 to length(mainform.Autoszenen)-1 do
            begin
              if IsEqualGUID(mainform.Autoszenen[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Automatikszene stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Automatikszene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Autoszenen[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Autoszenen[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Autoszenen[j].Beschreibung;
                t:=mainform.Autoszenen[j].fadetime;
                h:=inttostr(t div 3600000); t:=t mod 3600000;
                min:=inttostr(t div 60000); t:=t mod 60000;
                s:=inttostr(t div 1000); t:=t mod 1000;
                ms:=inttostr(t);
                if length(min)=1 then min:='0'+min;
                if length(s)=1 then s:='0'+s;
                if length(ms)=1 then ms:='0'+ms;
                if length(ms)=2 then ms:='0'+ms;
                if not mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms
                else
                  effektliste.Cells[5,i+1]:='-';

                effektliste.Cells[6,i+1]:=mainform.Autoszenen[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=mainform.Autoszenen[j].fadetime;
                break;
              end;
            end;
            // Effekt
            for j:=0 to length(mainform.Effektsequenzereffekte)-1 do
            begin
              if IsEqualGUID(mainform.Effektsequenzereffekte[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('Effekt stoppen') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('Effekt starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.Effektsequenzereffekte[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.Effektsequenzereffekte[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.Effektsequenzereffekte[j].Beschreibung;

                gesamtzeit:=0;
                if mainform.Effektsequenzereffekte[j].AnzahlderDurchlaufe>-1 then
                begin
                  for k:=0 to length(mainform.Effektsequenzereffekte[j].Effektschritte)-1 do
                  begin
                    gesamtzeit:=gesamtzeit{+mainform.Effektsequenzereffekte[j].Effektschritte[k].einblendzeit}+ mainform.Effektsequenzereffekte[j].Effektschritte[k].wartezeit;
                  end;
                  gesamtzeit:=gesamtzeit*mainform.Effektsequenzereffekte[j].AnzahlderDurchlaufe;
                end;

                t:=gesamtzeit;
                h:=inttostr(t div 3600000); t:=t mod 3600000;
                min:=inttostr(t div 60000); t:=t mod 60000;
                s:=inttostr(t div 1000); t:=t mod 1000;
                ms:=inttostr(t);
                if length(min)=1 then min:='0'+min;
                if length(s)=1 then s:='0'+s;
                if length(ms)=1 then ms:='0'+ms;
                if length(ms)=2 then ms:='0'+ms;
                if gesamtzeit=0 then
                  effektliste.Cells[5,i+1]:=_('Unendlich')
                else
                  effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms;
                effektliste.Cells[6,i+1]:=mainform.Effektsequenzereffekte[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=gesamtzeit;
                break;
              end;
            end;
            // MediaCenter Szene
            for j:=0 to length(mainform.MediaCenterSzenen)-1 do
            begin
              if IsEqualGUID(mainform.MediaCenterSzenen[j].ID,mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID) then
              begin
                if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene then
                  effektliste.Cells[3,i+1]:=_('MediaCenter Szene stoppen (nicht möglich)') // Typ
                else
                  effektliste.Cells[3,i+1]:=_('MediaCenter Szene starten'); // Typ
                effektliste.Cells[4,i+1]:=mainform.MediaCenterSzenen[j].Name; // Name
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=mainform.MediaCenterSzenen[j].Name;
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:=mainform.MediaCenterSzenen[j].Beschreibung;
                effektliste.Cells[5,i+1]:='-';
                effektliste.Cells[6,i+1]:=mainform.MediaCenterSzenen[j].Beschreibung; // Beschreibung
                mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=0;
                break;
              end;
            end;
          end else
          begin
            // FEHLER
            effektliste.Cells[3,i+1]:=_('Verwaister Szenenlink'); // Typ
            effektliste.Cells[4,i+1]:=GUIDtoString(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID); // Name
            mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name:=GUIDtoString(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID)+' '+_('(Fehlerhafter Link)');
            mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung:='';
            effektliste.Cells[5,i+1]:='-';
            effektliste.Cells[6,i+1]:=''; // Beschreibung
            mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime:=0;
          end;
        end else
        begin
          effektliste.Cells[3,i+1]:=_('Direktszene'); // Typ
          effektliste.Cells[4,i+1]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name; // Name
          t:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime;
          h:=inttostr(t div 3600000); t:=t mod 3600000;
          min:=inttostr(t div 60000); t:=t mod 60000;
          s:=inttostr(t div 1000); t:=t mod 1000;
          ms:=inttostr(t);
          if length(min)=1 then min:='0'+min;
          if length(s)=1 then s:='0'+s;
          if length(ms)=1 then ms:='0'+ms;
          if length(ms)=2 then ms:='0'+ms;
          effektliste.Cells[5,i+1]:=h+':'+min+':'+s+':'+ms;

          effektliste.Cells[6,i+1]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung; // Beschreibung
        end;
      end;
    end;
  end else
  begin
    waveformscaling:=1;
    Trackbar1Change(nil);
  end;

  setlength(active,Effektliste.RowCount);
  if Effektliste.FixedRows>1 then
    Effektliste.FixedRows:=1;
  if (lastrow<Effektliste.RowCount) and (Lastrow>0) then
    Effektliste.Row:=lastrow;
	Check_audioeffektbuttons();
  UnLockWindow(Effektliste.Handle);

  // Anzeige nach Möglichkeit in die Mitte Scrollen
  if Effektliste.Showing then
  if Effektliste.row>((Effektliste.Height div 15) div 2)-2 then
  for i:=1 to ((Effektliste.Height div 15) div 2)-2 do
  begin
    SendMessage(Effektliste.Handle,{ HWND of the Memo Control }
      WM_VSCROLL,    { Windows Message }
      SB_LINEDOWN,   { Scroll Command }
      0)             { Not Used }
  end;
end;

procedure Taudioeffektplayerform.layerboxKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    key := #0;
end;

procedure Taudioeffektplayerform.CheckBox9Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  _stereowaveform:=checkbox9.Checked;
//  audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.effekteeinMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  effectsenabled:=effekteein.Checked;
end;

procedure Taudioeffektplayerform.RepeataktiviertMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  dorepeating:=repeataktiviert.Checked;
  mainform.Effektaudiodatei_record.repeatactive:=Repeataktiviert.Checked;
end;

procedure Taudioeffektplayerform.audioeffektfilenameboxChange(
  Sender: TObject);
var
  i,j,k,l,effektanzahl:integer;
  zusatz : string;
  data : array[0..2000] of SmallInt;
  tempstring:string;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  dontscanforeffects:=true;
  if (length(audioeffektfilenamebox.Items.Strings[audioeffektfilenamebox.ItemIndex])>4) and
    not (audioeffektfilenamebox.ItemIndex=audioeffektfilenamebox.Items.Count-1) then
  begin
    i:=audioeffektfilenamebox.ItemIndex;

    if pos('\ProjectTemp\',mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad)>0 then
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad:=mainform.userdirectory+copy(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad,pos('ProjectTemp\',mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad),length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad));

    if not FileExists(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei) then
    begin
      tempstring:=mainform.SearchFileBeneathProject(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei);
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad:=ExtractFilePath(tempstring);
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei:=ExtractFileName(tempstring);
    end;
  
    if not FileExists(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei) then
    begin
      if messagedlg(_('Die Audiodatei "')+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei+_('" wurde nicht gefunden. Möchten Sie jetzt danach suchen?'),mtConfirmation,
        [mbYes,mbNo],0)=mrYes then
      begin
        OpenDialog.Filter:=_('Audiodateien|*.wav;*.mp3|*.*|*.*');
        OpenDialog.Title:=_('Audiodatei öffnen');
        opendialog.FileName:='';
//        if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
        if OpenDialog.Execute then
        begin
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad:=ExtractFilePath(OpenDialog.FileName);
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei:=ExtractFileName(OpenDialog.FileName);
          audioeffektfilenamebox.Items.Strings[audioeffektfilenamebox.ItemIndex]:=(inttostr(audioeffektfilenamebox.ItemIndex+1)+' - '+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei);
          audioeffektfilenamebox.ItemIndex:=i;
        end;
      end;
    end;

    // Audioeffekte öffnen
  //  mainform.Effektaudiodatei_record:=mainform.effektaudio_record.effektaudiodatei[audioeffektfilenamebox.itemindex];
    mainform.Effektaudiodatei_record.layeranzahl:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layeranzahl;
    for j:=1 to maxaudioeffektlayers do
    begin
      // Effektarraygrößen festlegen
      maxaudioeffekte[j]:=length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt);
      effektanzahl:=maxaudioeffekte[j];
      setlength(_effektaudioeffektpassed[j],effektanzahl);
      setlength(mainform.Effektaudiodatei_record.layer[j].effekt,effektanzahl);
      for i:=0 to effektanzahl-1 do
      begin
        mainform.Effektaudiodatei_record.layer[j].effekt[i].ID:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].ID;
        mainform.Effektaudiodatei_record.layer[j].effekt[i].Name:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Name;
        mainform.Effektaudiodatei_record.layer[j].effekt[i].Beschreibung:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Beschreibung;
        mainform.Effektaudiodatei_record.layer[j].effekt[i].StopScene:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].StopScene;
        mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].UseIDScene;
        mainform.Effektaudiodatei_record.layer[j].effekt[i].fadetime:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].fadetime;
        mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].audioeffektposition;
        setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices));
        for k:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices)-1 do
        begin
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ID:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ID;
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanActive,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanActive));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanValue,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanValue));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanActiveRandom,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanActiveRandom));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanValueRandom,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanValueRandom));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanDelay,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanDelay));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanFadetime,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanFadetime));
          for l:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanActive)-1 do
          begin
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanActive[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanActive[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanValue[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanValue[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanActiveRandom[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanActiveRandom[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanValueRandom[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanValueRandom[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanDelay[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanDelay[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Devices[k].ChanFadetime[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Devices[k].ChanFadetime[l];
          end;
        end;

        setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle));
        setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte,length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte));
        for k:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle)-1 do
        begin
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ID:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ID;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].Typ:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].Typ;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].Name:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].Name;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].Beschreibung:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].Beschreibung;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].OnValue:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].OnValue;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].OffValue:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].OffValue;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].SwitchValue:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].SwitchValue;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].InvertSwitchValue:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].InvertSwitchValue;
          mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ScaleValue:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ScaleValue;

          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgInteger, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ArgInteger));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgString, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ArgString));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgGUID, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ArgGUID));
          for l:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgInteger)-1 do
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgInteger[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ArgInteger[l];
          for l:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgString)-1 do
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgString[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ArgString[l];
          for l:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgGUID)-1 do
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehle[k].ArgGUID[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehle[k].ArgGUID[l];

          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanActive, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanActive));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanValue, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanValue));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanActiveRandom, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanActiveRandom));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanValueRandom, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanValueRandom));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanDelay, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanDelay));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanFadetime, length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanFadetime));
          for l:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanActive)-1 do
          begin
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanActive[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanActive[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanValue[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanValue[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanActiveRandom[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanActiveRandom[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanValueRandom[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanValueRandom[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanDelay[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanDelay[l];
            mainform.Effektaudiodatei_record.layer[j].effekt[i].Befehlswerte[k].ChanFadetime[l]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[i].Befehlswerte[k].ChanFadetime[l];
          end;
        end;
      end;
      layercombobox.Checked[j-1]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].layeractive;
      activelayer[j-1]:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].layeractive;
      mainform.Effektaudiodatei_record.repeatjump:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.repeatjump;
      mainform.Effektaudiodatei_record.repeatdestination:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.repeatdestination;
      mainform.Effektaudiodatei_record.repeatactive:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.repeatactive;
      mainform.Effektaudiodatei_record.volume:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.volume;
      mainform.Effektaudiodatei_record.videoseeking:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.videoseeking;
      mainform.Effektaudiodatei_record.layername:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layername;
      audioeffectplayer_volume.Position:=100-mainform.Effektaudiodatei_record.volume;
      repeataktiviert.Checked:=mainform.Effektaudiodatei_record.repeatactive;
      repeataktiviert1.Checked:=mainform.Effektaudiodatei_record.repeatactive;
    end;

    {
    for j:=1 to maxaudioeffektlayers do
    begin
      maxaudioeffekte[j]:=length(mainform.Effektaudiodatei_record.layer[j].effekt);
      setlength(_effektaudioeffektpassed[j],maxaudioeffekte[j]);
      if maxaudioeffekte[j]>0 then
        for i:=0 to maxaudioeffekte[j]-1 do
        begin
          _effektaudioeffektpassed[j][i]:=false;
          if mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene then
            mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID);
        end;
    end;
    }

    layerbox.ItemIndex:=0;
    layerboxChange(nil);

    audioeffektfilenamebox.Hint:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei;//audioeffektfilenamebox.Items[audioeffektfilenamebox.itemindex];

    BASS_ChannelStop(_chan[0]);
    BASS_ChannelStop(_chan[1]);
    BASS_ChannelStop(_chan[2]);
    BASS_ChannelStop(_chan[3]);

    BASS_ChannelSetPosition(_chan[0],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
    BASS_ChannelSetPosition(_chan[1],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
    BASS_ChannelSetPosition(_chan[2],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
    BASS_ChannelSetPosition(_chan[3],BASS_ChannelSeconds2Bytes(_chan[0], 0), BASS_POS_BYTE);
    LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

    audioeffektplaytimer.enabled:=false;
    audioeffektscrollbar.Position:=0;

    BASS_StreamFree(_chan[0]);
    BASS_StreamFree(_chan[1]);
    BASS_StreamFree(_chan[2]);
    BASS_StreamFree(_chan[3]);

    _chan[0]:=0;
    _chan[1]:=0;
    _chan[2]:=0;
    _chan[3]:=0;

    _scaling:=1;
    Trackbar1.Height:=trunc(waveform.Height / 11 * 3);
    waveform_scrollbar.Max:=waveform.Width;
    waveform_scrollbar.Enabled:=false;
    _scrollbpp:=BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div (waveform.Width*8);
    _bpp := BASS_ChannelSeconds2Bytes(_chan[0], 0.02);
    if (BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width>0 then
      waveform_scrollbar.Max:=(BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width;

    AudioeffectSpectrum.Free;
    AudioeffectSpectrum   := TSpectrum.Create(waveform.Width, waveform.Height);
    AudioeffectSpectrum.Mode         := 1;
    AudioeffectSpectrum.DrawPeak     := true;
    AudioeffectSpectrum.Width        := 5;
    AudioeffectSpectrum.Height       := waveform.Height;
    AudioeffectSpectrum.LineFallOff  := 4;
    AudioeffectSpectrum.PeakFallOff  := 1;
    AudioeffectSpectrum.Pen := clBlue;
    AudioeffectSpectrum.Peak := clWhite;
    AudioeffectSpectrum.BackColor := clBlack;

    effektaudioeffektefilename := mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiopfad+mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].audiodatei;

    _chan[0] := BASS_StreamCreateFile(false, PChar(effektaudioeffektefilename), 0, 0, BASS_STREAM_DECODE);
    _chan[1] := BASS_StreamCreateFile(false, PChar(effektaudioeffektefilename), 0, 0, BASS_SPEAKER_REAR);
    _chan[2] := BASS_StreamCreateFile(false, PChar(effektaudioeffektefilename), 0, 0, BASS_SPEAKER_CENLFE);
    _chan[3] := BASS_StreamCreateFile(false, PChar(effektaudioeffektefilename), 0, 0, BASS_SPEAKER_REAR2);

    _decodechan := BASS_StreamCreateFile(false, PChar(effektaudioeffektefilename), 0, 0, BASS_STREAM_DECODE OR BASS_MP3_SETPOS);

    // BPM-Erkennung
    BASS_ChannelGetInfo(_chan[0], info);
    _chan[0] := BASS_FX_TempoCreate(_chan[0], BASS_SAMPLE_LOOP Or BASS_FX_FREESOURCE);
    BASS_ChannelSetAttribute(_chan[0], BASS_ATTRIB_TEMPO, 0); // +-30 ist möglich
    BASS_ChannelSetAttribute(_chan[0], BASS_ATTRIB_TEMPO_FREQ, 44100); // Frequenz stufenlos von 0 bis 192000 möglich
    BASS_ChannelSetAttribute(_chan[0], BASS_ATTRIB_VOL, 1.0);

    DecodingBPM(true, AktuellePosition, AktuellePosition+bpmscanlength);

    if (chkBPMCallback.checked) then
      bpmview.Caption := FormatFloat('###.##', GetNewBPM(_chan[0]))+' BPM'
    else
      bpmview.Caption := FormatFloat('###.##', GetNewBPM(hBPM))+' BPM';

  // Equalizer initiieren
    for i:=0 to 3 do
    begin
      eq[0][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[1][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[2][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[3][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[4][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[5][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[6][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[7][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[8][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[9][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
      eq[10][i] := BASS_ChannelSetFX(_chan[i], BASS_FX_DX8_PARAMEQ, 1);
    end;

  // Set equalizer to flat and reverb off to start
      p.fGain := 0;
      p.fBandwidth := 18;
    for i:=0 to 3 do
    begin
      p.fCenter := 80;
      BASS_FXSetParameters(eq[0][i], @p);
      p.fCenter := 125;
      BASS_FXSetParameters(eq[1][i], @p);
      p.fCenter := 180;
      BASS_FXSetParameters(eq[2][i], @p);
      p.fCenter := 300;
      BASS_FXSetParameters(eq[3][i], @p);
      p.fCenter := 600;
      BASS_FXSetParameters(eq[4][i], @p);
      p.fCenter := 1000;
      BASS_FXSetParameters(eq[5][i], @p);
      p.fCenter := 2000;
      BASS_FXSetParameters(eq[6][i], @p);
      p.fCenter := 3000;
      BASS_FXSetParameters(eq[7][i], @p);
      p.fCenter := 5000;
      BASS_FXSetParameters(eq[8][i], @p);
      p.fCenter := 8000;
      BASS_FXSetParameters(eq[9][i], @p);
      p.fCenter := 16000;
      BASS_FXSetParameters(eq[10][i], @p);
    end;

      if length(effektaudioeffektefilename)>45 then zusatz:='...' else zusatz:='';
      waveform.Hint:=_('Darstellung von ')+copy(effektaudioeffektefilename,0,45)+zusatz;

      if length(ExtractFileName(effektaudioeffektefilename))>45 then zusatz:='...' else zusatz:='';
      audioeffektplayerform.Caption:=_('Audioeffektplayer - ')+copy(ExtractFileName(effektaudioeffektefilename),0,45)+zusatz;

    if _chan[0] <> 0 then
    begin
      for i:=0 to length(data)-1 do
        data[0] := 0;
      _bpp := BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div (waveform.Width);
      _scrollbpp:=BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div (waveform.Width*8);

      if (_bpp < BASS_ChannelSeconds2Bytes(_chan[0], 0.02)) then
        _bpp := BASS_ChannelSeconds2Bytes(_chan[0], 0.02);


      mainform.Waveformdata_record:=mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].waveform;

        for i:=1 to 8 do
        begin
          TScrollbar(FindComponent('eq_scrollbar'+inttostr(i))).position:=mainform.Waveformdata_record.fadervalues[i];
          TCheckBox(FindComponent('eq_check'+inttostr(i))).checked:=mainform.Waveformdata_record.effekte[i];
          eq_check1MouseUp(TCheckBox(FindComponent('eq_check'+inttostr(i))),mbLeft,[],0,0);
        end;

        for i:=0 to 10 do
        begin
          for k:=0 to 3 do
          begin
            TProgressBar(FindComponent('equalizer_progressbar'+inttostr(i))).Position:=mainform.Waveformdata_record.equalizer[i];
            BASS_FXGetParameters(eq[i][k], @p);
            p.fgain := 15-30+mainform.Waveformdata_record.equalizer[i];
            BASS_FXSetParameters(eq[i][k], @p);
          end;
        end;

      _stereowaveform:=checkbox9.Checked;

      waveform_scrollbar.Max:=0;
      audioeffektscrollbar.Max:=BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _scrollbpp;

      Check_audioeffektbuttons();

      if videoscreensynchronisierenform.Showing then
        videoscreensynchronisierenform.ValueRefresh;

      PlayEffektaudio.Enabled:=true;
      Saveeffektliste.Enabled:=true;
      Openeffektliste.Enabled:=true;
      Effektlistespeichern1.Enabled:=true;
      RepeatModus1.Enabled:=true;
      Videoseekingeinrichten1.Enabled:=true;
      Effektlisteffnen1.Enabled:=true;
      Effektlistelschen1.Enabled:=true;
      audioeffektscrollbar.Enabled:=true;
      effekteein.Enabled:=true;
      waveform_zoomin.Enabled:=true;
      waveform_zoomout.Enabled:=true;
      Scrollbar1.Max:=trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE)));
      TScanThread.create(_decodechan);
    end;
  end;
end;

procedure Taudioeffektplayerform.audioeffektfilenameboxClick(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

	if not audioeffektfilenamebox.Enabled then exit;

  // Neue Audiodatei hinzufügen (Klick auf letztes Element)
	if (audioeffektfilenamebox.ItemIndex=audioeffektfilenamebox.Items.Count-1) then
	begin
	  Button20Click(Sender);
	end;
end;

procedure Taudioeffektplayerform.audioeffektfilenameboxDropDown(
  Sender: TObject);
var
	j,k,l,m,effektanzahl:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  NoAudiofile:=(audioeffektfilenamebox.Items.Count=1);

  audioeffektplaytimer.enabled:=false;

  if (audioeffektfilenamebox.Items.Count>1) and (audioeffektfilenamebox.ItemIndex<audioeffektfilenamebox.Items.Count-1) then
  begin
  //  audioeffektfilenamebox.Width:=521;
    save_eqClick(Sender);

  //	  mainform.effektaudio_record.effektaudiodatei[audioeffektfilenamebox.ItemIndex]:=mainform.Effektaudiodatei_record;
    mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layeranzahl:=mainform.Effektaudiodatei_record.layeranzahl;
    for j:=1 to maxaudioeffektlayers do
    begin
      // Effektarraygrößen festlegen
      effektanzahl:=maxaudioeffekte[j];
      setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt,effektanzahl);
      for k:=0 to effektanzahl-1 do
      begin
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].ID:=mainform.Effektaudiodatei_record.layer[j].effekt[k].ID;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Name:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Name;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Beschreibung:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Beschreibung;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].StopScene:=mainform.Effektaudiodatei_record.layer[j].effekt[k].StopScene;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].UseIDScene:=mainform.Effektaudiodatei_record.layer[j].effekt[k].UseIDScene;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].fadetime:=mainform.Effektaudiodatei_record.layer[j].effekt[k].fadetime;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].audioeffektposition:=mainform.Effektaudiodatei_record.layer[j].effekt[k].audioeffektposition;
        setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices));
        for l:=0 to length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices)-1 do
        begin
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ID:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ID;
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanActive));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanValue));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanActiveRandom));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanValueRandom));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanDelay));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanFadetime));
          for m:=0 to length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive)-1 do
          begin
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive[m]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanActive[m];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue[m]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanValue[m];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom[m]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanActiveRandom[m];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom[m]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanValueRandom[m];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay[m]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanDelay[m];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime[m]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[l].ChanFadetime[m];
          end;
        end;

        setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle));
        setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte,length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte));
        for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle)-1 do
        begin
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ID:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ID;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].Typ:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Typ;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].Name:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Name;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].Beschreibung:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Beschreibung;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].OnValue:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OnValue;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].OffValue:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OffValue;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].SwitchValue:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].SwitchValue;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].InvertSwitchValue:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].InvertSwitchValue;
          mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ScaleValue:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ScaleValue;

          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgInteger, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgString, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgGUID, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID));
          for l:=0 to length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgInteger)-1 do
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgInteger[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger[l];
          for l:=0 to length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgString)-1 do
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgString[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString[l];
          for l:=0 to length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgGUID)-1 do
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehle[m].ArgGUID[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID[l];

          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanActive, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanValue, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanDelay, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay));
          setlength(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanFadetime, length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime));
          for l:=0 to length(mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanActive)-1 do
          begin
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanActive[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive[l];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanValue[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue[l];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom[l];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom[l];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanDelay[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay[l];
            mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].effekt[k].Befehlswerte[m].ChanFadetime[l]:=mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime[l];
          end;
        end;

      end;
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].layeractive:=activelayer[j-1];
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.repeatjump:=mainform.Effektaudiodatei_record.repeatjump;
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.repeatdestination:=mainform.Effektaudiodatei_record.repeatdestination;
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.repeatactive:=mainform.Effektaudiodatei_record.repeatactive;
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.volume:=100-audioeffectplayer_volume.Position;
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.videoseeking:=mainform.Effektaudiodatei_record.videoseeking;
      mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layername:=mainform.Effektaudiodatei_record.layername;
    end;
    mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].waveform:=mainform.Waveformdata_record;
  end;
end;

procedure Taudioeffektplayerform.audioeffektscrollbarChange(
  Sender: TObject);
//var
//  position,j,i:integer;
begin
{
	position:=BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE);

    // Auf Repeat-Sprungmarke überprüfen
    if ((Repeataktiviert.Checked) and (BASS_ChannelIsActive(_chan[0]) = BASS_ACTIVE_PLAYING) and (mainform.Effektaudiodatei_record.repeatjump<=position) and not (position>mainform.Effektaudiodatei_record.repeatjump+100000)) then
    begin
      for j:=1 to maxaudioeffektlayers do
	      for i:=0 to maxaudioeffekte[j]-1 do
          if (BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition)>mainform.Effektaudiodatei_record.repeatdestination) then
      			_effektaudioeffektpassed[j][i]:=false;

      BASS_ChannelSetPosition(_chan[0],mainform.Effektaudiodatei_record.repeatdestination);
      BASS_ChannelSetPosition(_chan[1],mainform.Effektaudiodatei_record.repeatdestination);
      BASS_ChannelSetPosition(_chan[2],mainform.Effektaudiodatei_record.repeatdestination);
      BASS_ChannelSetPosition(_chan[3],mainform.Effektaudiodatei_record.repeatdestination);
      LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
    end;
}
end;

procedure Taudioeffektplayerform.waveform_scrollbarChange(Sender: TObject);
begin
  if not (ScrolltimelineCheckbox.Checked and (BASS_ChannelIsActive(_chan[0]) = BASS_ACTIVE_PLAYING)) then
  begin
    _scroll:=waveform_scrollbar.position;
    if ScrolltimelineCheckbox.Checked then
    begin
      BASS_ChannelSetPosition(_chan[0],(_scroll)*_bpp, BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[1],(_scroll)*_bpp, BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[2],(_scroll)*_bpp, BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[3],(_scroll)*_bpp, BASS_POS_BYTE);
      LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
    end;
  end;
end;

procedure Taudioeffektplayerform.waveformMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,position:integer;
//  effektnummer_str:string;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if not timerenabled then exit;

  if (Mausklickssperren1.Checked=false) then
  begin
    x1:=X;
    y1:=Y;
    x2:=X;
    y2:=Y;

    //RightMouse
    if Button = mbRight then
    begin
      _mousedwn:=2;
      _mousepos:=X;
      if (waveform.Cursor=crSizeWE) then
      begin
        if (wavedarstellung.itemindex=0) and (_audioeffektlayer>0) then
        begin
          for i:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1 do
          begin
            active[i+1]:=false;
            if ((X>(BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition) / _bpp - _scroll)-3) and (X<(BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition) / _bpp - _scroll)+2)) then
            begin
              if (i+1>0) and (i+1<effektliste.RowCount) then
                Effektliste.Row:=i+1;
   			  		active[i+1]:=true;
            end;
          end;
        end else if (wavedarstellung.ItemIndex=1) and (_audioeffektlayer>0) then
        begin
          for i:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1 do
          begin
            active[i+1]:=false;
            if trunc(X + counta)-waveform.width div 2<length(_wavebufTime) then
            if (_wavebufTime[trunc(X + counta)-waveform.width div 2]>mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition-0.03) and (_wavebufTime[trunc(X + counta)-waveform.width div 2]<mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition+0.02) then
            begin
              if (i+1>0) and (i<effektliste.RowCount) then
                Effektliste.Row:=i+1;
   			  		active[i+1]:=true;
            end;
          end;
        end;
      end else
      begin
        if (wavedarstellung.itemindex=0) and not ScrolltimelineCheckbox.Checked then
        begin
          BASS_ChannelSetPosition(_chan[0],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[1],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[2],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[3],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

          if videoscreenform<>nil then
          if (videoscreenform.Showing) then
          begin
            for i:=1 to 4 do
            begin
              if mainform.Effektaudiodatei_record.videoseeking[i].enabled then
              begin
                videoscreenform.SetVideoPosition(i,trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE))*1000)-mainform.Effektaudiodatei_record.videoseeking[i].starttime);
              end;
            end;
          end;

          if RunAllPreviousEffectsBtn.visible and effectsenabled then
            LoadAllEffectsBeforeNow;
        end else if (wavedarstellung.ItemIndex=1) or ScrolltimelineCheckbox.Checked then
        begin
          mousedownposition:=counta;//_wavebufTime[(X + counta)-_buffer.width div 2];
        end;
      end;
    end;

    //LeftMouse
    if Button = mbLeft then
    begin
  	  _mousedwn:=1;
      _mousepos:=X;

  	  if (_audioeffektlayer>0)then
	    begin
			  for i:=0 to maxaudioeffekte[_audioeffektlayer]-1 do
		    begin
          if wavedarstellung.ItemIndex=0 then
          begin
		  	  	position:=trunc((BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition)  / _bpp) - _scroll);
			  	  if (position>x1) and (position<x2)
  				  or (position<x1) and (position>x2) then
    					active[i+1]:=true
	    			else
		    			active[i+1]:=false;
          end else if wavedarstellung.ItemIndex=1 then
          begin
            if trunc(x1 + counta)-waveform.width div 2<length(_wavebufTime) then
			  	  if (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition>_wavebufTime[trunc(x1 + counta)-waveform.width div 2]) and (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition<_wavebufTime[trunc(x2 + counta)-waveform.width div 2])
  				  or (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition<_wavebufTime[trunc(x1 + counta)-waveform.width div 2]) and (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition>_wavebufTime[trunc(x2 + counta)-waveform.width div 2]) then
    					active[i+1]:=true
	    			else
		    			active[i+1]:=false;
          end;
  		  end;
	  	end;
    end;
  end;
end;

procedure Taudioeffektplayerform.waveformMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i,position:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  if not timerenabled then exit;

  if mainform.shutdown then exit;

  _mousepos:=X;

  if (_mousedwn=0) then
  begin
    waveform.Cursor:=crDefault;
    destinationlayer:=0;
  end;

  if Mausklickssperren1.Checked=false then
  begin
    if ((effekteein.Checked)) then
    begin
      if (mouseovereffect=-1) then
      begin
        // only allow changing of layer, when no effect is possibly moved
        mouseoverlayer:=-1;
        if layerbox.ItemIndex=0 then
        begin
          for i:=1 to maxaudioeffektlayers do
          begin
            if (Y>=(waveform.Height / (maxaudioeffektlayers+3))*(i-1+3)) and (Y<=(waveform.Height / (maxaudioeffektlayers+3))*(i+3)) then
              mouseoverlayer:=i;
          end;
        end else
        begin
          mouseoverlayer:=layerbox.ItemIndex;
        end;
      end;

      
      if (_mousedwn=0) then
      begin
        mouseovereffect:=-1;

        if (mouseoverlayer>0) and (mouseovereffect=-1) and (y>waveform.height div 11 *3) then
        begin
          for i:=0 to length(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt)-1 do
 	        begin
            if wavedarstellung.ItemIndex=0 then
            begin
              if ((BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[i].audioeffektposition) / _bpp - _scroll)-3)>=0 then
 	            begin
                if ((X>(BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[i].audioeffektposition) / _bpp - _scroll)-2) and (X<(BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[i].audioeffektposition) / _bpp - _scroll)+2)) then
   	            begin
                  mouseovereffect:=i;
                  waveform.Cursor:=crSizeWE;
                end;
              end;
            end else if wavedarstellung.ItemIndex=1 then
            begin
              if (trunc((X-waveform.width div 2)*(maxzoom/_scaling) + counta)>=0) and (trunc((X-waveform.width div 2)*(maxzoom/_scaling) + counta)<length(_wavebufTime)) then
              if (_wavebufTime[trunc((X-waveform.width div 2)*(maxzoom/_scaling) + counta)]>=mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[i].audioeffektposition-0.04*((((maxzoom-_scaling)/maxzoom)*10)+1)) and (_wavebufTime[trunc((X-waveform.width div 2)*(maxzoom/_scaling) + counta)]<=mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[i].audioeffektposition+0.04*((((maxzoom-_scaling)/maxzoom)*10)+1)) then
              begin
                mouseovereffect:=i;
                waveform.Cursor:=crSizeWE;
              end;
            end;
          end;
        end;
      end;
    end;

    //RightMouse
    if _mousedwn = 2 then
    begin
      if ((mouseovereffect>-1) and (_dragtimeline=false) and (mouseoverlayer>0)) then
      begin
        if wavedarstellung.ItemIndex=0 then
        begin
          if (x>=0) and (x<=waveform.Width) then
          begin
            if layerbox.ItemIndex=0 then
            begin
              for i:=1 to maxaudioeffektlayers do
              begin
                if (Y>=(waveform.Height div (maxaudioeffektlayers+3))*(i-1+3)) and (Y<=(waveform.Height div (maxaudioeffektlayers+3))*(i+3)) then
                  destinationlayer:=i;
              end;
              if destinationlayer<>mouseoverlayer then
              begin
                waveform.Cursor:=crMultiDrag;
                copyeffecttothelayer:=true;
                destinationposition:=BASS_ChannelBytes2Seconds(_chan[0],(dword(x)+_scroll)*_bpp);
              end else
              begin
                waveform.Cursor:=crDefault;
                copyeffecttothelayer:=false;
                mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[mouseovereffect].audioeffektposition:=BASS_ChannelBytes2Seconds(_chan[0],(dword(x)+_scroll)*_bpp);
              end;
            end else
            begin
              waveform.Cursor:=crDefault;
              copyeffecttothelayer:=false;
              mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[mouseovereffect].audioeffektposition:=BASS_ChannelBytes2Seconds(_chan[0],(dword(x)+_scroll)*_bpp);
            end;
          end;
        end else if wavedarstellung.ItemIndex=1 then
        begin
          if trunc((X-waveform.width div 2)*(maxzoom/_scaling) + counta)<length(_wavebufTime) then
            mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt[mouseovereffect].audioeffektposition:=_wavebufTime[trunc((X-waveform.width div 2)*(maxzoom/_scaling) + counta)];
        end;
      end else
      begin
        if (wavedarstellung.ItemIndex=0) and not ScrolltimelineCheckbox.Checked then
        begin
          _dragtimeline:=true;
          BASS_ChannelSetPosition(_chan[0],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[1],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[2],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[3],(dword(x)+_scroll)*_bpp, BASS_POS_BYTE);
          LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
          if videoscreenform<>nil then
          if (videoscreenform.Showing) then
          begin
            for i:=1 to 4 do
            begin
              if mainform.Effektaudiodatei_record.videoseeking[i].enabled then
              begin
                videoscreenform.SetVideoPosition(i,trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE))*1000)-mainform.Effektaudiodatei_record.videoseeking[i].starttime);
              end;
            end;
          end;

          if RunAllPreviousEffectsBtn.visible and effectsenabled then
            LoadAllEffectsBeforeNow;
        end else if (wavedarstellung.ItemIndex=1) then
        begin
          if (trunc(X1*(maxzoom/_scaling)-X*(maxzoom/_scaling) + mousedownposition)>0) and (trunc(X1*(maxzoom/_scaling)-X*(maxzoom/_scaling) + mousedownposition)<length(_wavebufTime)) then
          begin
            _dragtimeline:=true;
            BASS_ChannelSetPosition(_chan[0],BASS_ChannelSeconds2Bytes(_chan[0],_wavebufTime[trunc(X1*(maxzoom/_scaling)-X*(maxzoom/_scaling) + mousedownposition)]), BASS_POS_BYTE);
            BASS_ChannelSetPosition(_chan[1],BASS_ChannelSeconds2Bytes(_chan[1],_wavebufTime[trunc(X1*(maxzoom/_scaling)-X*(maxzoom/_scaling) + mousedownposition)]), BASS_POS_BYTE);
            BASS_ChannelSetPosition(_chan[2],BASS_ChannelSeconds2Bytes(_chan[2],_wavebufTime[trunc(X1*(maxzoom/_scaling)-X*(maxzoom/_scaling) + mousedownposition)]), BASS_POS_BYTE);
            BASS_ChannelSetPosition(_chan[3],BASS_ChannelSeconds2Bytes(_chan[3],_wavebufTime[trunc(X1*(maxzoom/_scaling)-X*(maxzoom/_scaling) + mousedownposition)]), BASS_POS_BYTE);
            LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
          end;
        end else if ScrolltimelineCheckbox.Checked then
        begin
          _dragtimeline:=true;
          BASS_ChannelSetPosition(_chan[0],BASS_ChannelSeconds2Bytes(_chan[0],(dword(x)+_scroll)*_bpp), BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[1],BASS_ChannelSeconds2Bytes(_chan[1],(dword(x)+_scroll)*_bpp), BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[2],BASS_ChannelSeconds2Bytes(_chan[2],(dword(x)+_scroll)*_bpp), BASS_POS_BYTE);
          BASS_ChannelSetPosition(_chan[3],BASS_ChannelSeconds2Bytes(_chan[3],(dword(x)+_scroll)*_bpp), BASS_POS_BYTE);
          LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
        end;
      end;
    end;

    //LeftMouse
    if _mousedwn = 1 then
    begin
      x2:=X;
	    y2:=Y;

    	if _audioeffektlayer>0 then
	    begin
      	for i:=0 to maxaudioeffekte[_audioeffektlayer]-1 do
        begin
          if wavedarstellung.ItemIndex=0 then
          begin
		  	  	position:=trunc((BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition)  / _bpp) - _scroll);
			  	  if (position>x1) and (position<x2)
  				  or (position<x1) and (position>x2) then
    					active[i+1]:=true
	    			else
		    			active[i+1]:=false;
          end else if wavedarstellung.ItemIndex=1 then
          begin
            if trunc(x1 + counta)-waveform.width div 2<length(_wavebufTime) then
			  	  if (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition>_wavebufTime[trunc(x1 + counta)-waveform.width div 2]) and (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition<_wavebufTime[trunc(x2 + counta)-waveform.width div 2])
  				  or (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition<_wavebufTime[trunc(x1 + counta)-waveform.width div 2]) and (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition>_wavebufTime[trunc(x2 + counta)-waveform.width div 2]) then
    					active[i+1]:=true
	    			else
		    			active[i+1]:=false;
          end;
			  end;
      end;
    end;
  end;
end;

procedure Taudioeffektplayerform.waveformMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i,j:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if not timerenabled then exit;

  x1:=X;
  y1:=Y;
  x2:=X;
  y2:=Y;

  if Mausklickssperren1.Checked=false then
  begin
    _mousedwn := 0;
    _dragtimeline:=false;

    if Shift=[ssShift] then
    for j:=1 to maxaudioeffektlayers do
      for i:=0 to maxaudioeffekte[j]-1 do
  			_effektaudioeffektpassed[j][i]:=false;

    if (destinationlayer<>mouseoverlayer) and (mouseovereffect>-1) and (copyeffecttothelayer) then
    begin
      copyeffecttothelayer:=false;
      setlength(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt,length(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt)+1);
      setlength(_effektaudioeffektpassed[destinationlayer],length(_effektaudioeffektpassed[destinationlayer])+1);
      maxaudioeffekte[destinationlayer]:=maxaudioeffekte[destinationlayer]+1;

      CopyEffekt(mouseovereffect,length(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt)-1,mouseoverlayer,destinationlayer);

      if not (Shift=[ssCtrl]) then
      begin
        // alten Effekt löschen
        // Daten kopieren
        if (mouseovereffect<length(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt)-1) then
          for j:=mouseovereffect to length(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt)-2 do
            CopyEffekt(j+1,j,mouseoverlayer,mouseoverlayer);

        // gesamte Arrays um ein Element kürzen
        setlength(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt,length(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt)-1);
        setlength(_effektaudioeffektpassed[mouseoverlayer],length(_effektaudioeffektpassed[mouseoverlayer])-1);
        setlength(active,length(active)-1);
        maxaudioeffekte[mouseoverlayer]:=maxaudioeffekte[mouseoverlayer]-1;
      end;

      mainform.Effektaudiodatei_record.layer[destinationlayer].effekt[length(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt)-1].audioeffektposition:=destinationposition;
      if length(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt)>1 then
        EffektSort(Low(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt),High(mainform.Effektaudiodatei_record.layer[destinationlayer].effekt), destinationlayer);
      layerboxchange(nil);
    end;

    if (Shift=[ssAlt]) and (Button=mbLeft) then
    begin
      RescanAudiofile;
      exit;
    end;

    if ((waveform.Cursor=crSizeWE) and (Shift=[ssCtrl]) and (Button=mbLeft) and (_audioeffektlayer>0)) then
      EditEffekt.Click;
  end;

  if mouseoverlayer>0 then
  begin
    if length(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt),High(mainform.Effektaudiodatei_record.layer[mouseoverlayer].effekt), mouseoverlayer);
    layerboxchange(nil);
  end;

  if panelLighteffects.visible then
    Effektliste.SetFocus;
end;

procedure Taudioeffektplayerform.MarkiertenEffektausfhren1Click(
  Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  if _audioeffektlayer>0 then
  begin
  	for i:=0 to effektliste.RowCount-1 do
    begin
    	if active[i+1] then
      begin
        PlayEffectScene(_audioeffektlayer, i, false);
      end;
    end;
  end;
end;

procedure Taudioeffektplayerform.MarkiertenEffektstoppen1Click(
  Sender: TObject);
var
  i,k,l,PositionInDeviceArray:integer;
begin
  if not mainform.UserAccessGranted(2) then exit;

  PositionInDeviceArray:=0;

  if _audioeffektlayer>0 then
  begin
  	for i:=0 to length(active)-1 do
    begin
    	if active[i+1] then
      begin
        if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].UseIDScene then
          mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID);
      end  else
      begin
        // Geräteszene stoppen
        for k:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices)-1 do
        begin
          for l:=0 to length(mainform.Devices)-1 do
          begin
            if IsEqualGUID(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[k].ID,mainform.devices[l].ID) then
            begin
              PositionInDeviceArray:=l;
              break;
            end;
          end;

          for l:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[k].ChanActive)-1 do
          begin
            if mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[k].ChanActive[l] then
            begin
              geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),0);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure Taudioeffektplayerform.MarkierteEffekteverschieben1Click(
  Sender: TObject);
var
	i,move:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
  	move:=strtoint(InputBox(_('Verschieben von Effekt'),_('Um wie viele Millisekunden sollen die markierten Effekte verschoben werden:'),'0'));

  	for i:=0 to length(active)-1 do
    	if active[i+1] then
        mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition+(move/1000);

//  	audioeffekttimerTimer(sender);
    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.MarkiertenEffektaufPositionXsetzen1Click(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[Effektliste.Row-1].audioeffektposition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
//  	audioeffekttimerTimer(sender);
    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.Layerffnen1Click(Sender: TObject);
var
  openfile,effectfilepath,effectfilename:string;
  k,effektanzahl:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    opendialog.Title:=_('PC_DIMMER Effekt-Layer öffnen...');
    opendialog.Filter:=_('PC_DIMMER Effekt-Layer (*.pcdelyr)|*.pcdelyr|*.*|*.*');
    opendialog.FileName:='';
    opendialog.DefaultExt:='*.pcdelyr';
  //  if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
    if opendialog.execute then
    begin
      openfile:=opendialog.filename;

      effectfilepath:=ExtractFilepath(openfile);
      effectfilename:=ExtractFileName(openfile);

      If not DirectoryExists(mainform.userdirectory+'Temp') then
        ForceDirectories(mainform.userdirectory+'Temp');
      DeleteFile(mainform.userdirectory+'Temp\*.*');
      mainform.Compress.DecompressFile(effectfilepath+effectfilename,mainform.userdirectory+'Temp\',true,false);
      if not mainform.startingup then
        inprogress.Hide;

          if fileexists(mainform.userdirectory+'Temp\Effektlayer') then
            FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektlayer',fmOpenRead)
          else
            FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\'+effectfilename,fmOpenRead);
          // Effektanzahl herausfinden
          FileStream.ReadBuffer(effektanzahl,sizeof(effektanzahl));
          maxaudioeffekte[_audioeffektlayer]:=effektanzahl;
          // Effektarraygrößen festlegen
          setlength(_effektaudioeffektpassed[_audioeffektlayer],effektanzahl);
          setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,effektanzahl);
          // Effektarray laden
          for k:=0 to effektanzahl-1 do
          begin
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[k],sizeof(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[k]));
          end;
      FileStream.Free;
      DeleteFile(mainform.userdirectory+'Temp\*.*');

        layerboxChange(nil);
      end;

      Check_audioeffektbuttons()
  end;
end;

procedure Taudioeffektplayerform.Layerspeichern1Click(Sender: TObject);
var
  savefile,effectfilepath,effectfilename:string;
  k,effektanzahl:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    savedialog.Title:=_('PC_DIMMER Effekt-Layer speichern...');
    savedialog.Filter:=_('PC_DIMMER Effekt-Layer (*.pcdelyr)|*.pcdelyr|*.*|*.*');
    savedialog.FileName:='';
    savedialog.DefaultExt:='*.pcdelyr';
    if savedialog.execute then
      begin
        savefile:=savedialog.filename;

        effectfilepath:=ExtractFilepath(savefile);
        effectfilename:=ExtractFileName(savefile);

        If not DirectoryExists(mainform.userdirectory+'Temp') then
          ForceDirectories(mainform.userdirectory+'Temp');
        DeleteFile(mainform.userdirectory+'Temp\*.*');
        FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektlayer',fmCreate);
          // Effektanzahl herausfinden
          effektanzahl:=length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt);
          // Effektanzahl abspeichern
          FileStream.WriteBuffer(effektanzahl,sizeof(effektanzahl));
          // Effektarray abspeichern
          for k:=0 to effektanzahl-1 do
          begin
            Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[k],sizeof(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[k]));
          end;
        FileStream.Free;

        mainform.Compress.CompressDirectory(mainform.userdirectory+'Temp\',false,effectfilepath+effectfilename);
        DeleteFile(mainform.userdirectory+'Temp\*.*');
        inprogress.Hide;
      end;
  end;
end;

procedure Taudioeffektplayerform.Layerlschen1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

if messagedlg(_('Aktuellen Layer löschen?'),mtWarning,
  [mbYes,mbNo],0)=mrYes then
  begin
    effektliste.RowCount:=2;
    maxaudioeffekte[_audioeffektlayer]:=0;
	  setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,0);
  end;
end;

procedure Taudioeffektplayerform.LayerkopierenzuLayer1Click(
  Sender: TObject);
var
	i,j,k,ziellayer:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

	try
  	ziellayer:=strtoint(InputBox(_('Layer kopieren'),_('Bitte geben Sie das Ziellayer ein (1 bis ')+inttostr(maxaudioeffektlayers)+')',inttostr(_audioeffektlayer)));
  except
  	ShowMessage(_('Fehlerhafte Eingabe!'));
    Exit;
  end;

  if (ziellayer<=maxaudioeffektlayers) and (ziellayer>0) then
  begin
  	if maxaudioeffekte[ziellayer]>0 then
			if messagedlg(_('Das Ziellayer enthält bereits einige Effekte. Diese werden beim Kopiervorgang überschrieben. Fortsetzen?'),mtConfirmation,
		  	[mbYes,mbNo],0)=mrNo then exit;

			  setlength(_effektaudioeffektpassed[ziellayer],maxaudioeffekte[_audioeffektlayer]);
			  setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt,maxaudioeffekte[_audioeffektlayer]);

		    maxaudioeffekte[ziellayer]:=maxaudioeffekte[_audioeffektlayer];
			  for i:=0 to maxaudioeffekte[_audioeffektlayer]-1 do
			  begin
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].ID:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].ID;
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Name:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Name;
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Beschreibung:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Beschreibung;
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].StopScene:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].StopScene;
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].UseIDScene:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].UseIDScene;
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].fadetime:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].fadetime;
				  mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition;
          setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices));
          for j:=0 to length(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices)-1 do
          begin
            mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ID:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ID;
            setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanActive,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanActive));
            setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanValue,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanValue));
            setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanActiveRandom,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanActiveRandom));
            setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanValueRandom,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanValueRandom));
            setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanDelay,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanDelay));
            setlength(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanFadetime,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanFadetime));
            for k:=0 to length(mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanActive)-1 do
            begin
              mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanActive[k]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanActive[k];
              mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanValue[k]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanValue[k];
              mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanActiveRandom[k]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanActiveRandom[k];
              mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanValueRandom[k]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanValueRandom[k];
              mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanDelay[k]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanDelay[k];
              mainform.Effektaudiodatei_record.layer[ziellayer].effekt[i].Devices[j].ChanFadetime[k]:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].Devices[j].ChanFadetime[k];
            end;
          end;
			  end;
	end else
  	ShowMessage(_('Das Ziel liegt außerhalb der gültigen Layer!'));
end;

procedure Taudioeffektplayerform.Effektlisteffnen1Click(Sender: TObject);
var
  j,k,effektanzahl:integer;
  openfile,effectfilepath,effectfilename:string;
begin
  if not mainform.UserAccessGranted(1) then exit;

  opendialog.Title:=_('PC_DIMMER Effektliste öffnen...');
  opendialog.Filter:=_('PC_DIMMER Effektliste (*.pcdelst)|*.pcdelst|*.*|*.*');
  opendialog.FileName:='';
  opendialog.DefaultExt:='*.pcdelst';
//  if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
  if opendialog.execute then
  begin
    openfile:=opendialog.filename;

    effectfilepath:=ExtractFilepath(openfile);
    effectfilename:=ExtractFileName(openfile);

    If not DirectoryExists(mainform.userdirectory+'Temp') then
      ForceDirectories(mainform.userdirectory+'Temp');
    DeleteFile(mainform.userdirectory+'Temp\*.*');
    mainform.Compress.DecompressFile(effectfilepath+effectfilename,mainform.userdirectory+'Temp\',true,false);

		FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektliste',fmOpenRead);
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layeranzahl,sizeof(mainform.Effektaudiodatei_record.layeranzahl));
      // Einzelne Layer und Effekte laden
      for j:=1 to maxaudioeffektlayers do
      begin
        // Effektanzahl herausfinden
        FileStream.ReadBuffer(effektanzahl,sizeof(effektanzahl));
        maxaudioeffekte[j]:=effektanzahl;
        // Effektarraygrößen festlegen
        setlength(_effektaudioeffektpassed[j],effektanzahl);
        setlength(mainform.Effektaudiodatei_record.layer[j].effekt,effektanzahl);
        // Effektarrays laden
				for k:=0 to effektanzahl-1 do
        begin
        	Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k],sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k]));
        end;
        Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].layeractive,sizeof(mainform.Effektaudiodatei_record.layer[j].layeractive));
      end;
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatjump,sizeof(mainform.Effektaudiodatei_record.repeatjump));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatdestination,sizeof(mainform.Effektaudiodatei_record.repeatdestination));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatactive,sizeof(mainform.Effektaudiodatei_record.repeatactive));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.volume,sizeof(mainform.Effektaudiodatei_record.volume));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.videoseeking,sizeof(mainform.Effektaudiodatei_record.videoseeking));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layername,sizeof(mainform.Effektaudiodatei_record.layername));
		FileStream.Free;
    DeleteFile(mainform.userdirectory+'Temp\*.*');

    repeataktiviert.Checked:=mainform.Effektaudiodatei_record.repeatactive;
    repeataktiviert1.Checked:=mainform.Effektaudiodatei_record.repeatactive;

    for j:=1 to maxaudioeffektlayers do
    begin
      layercombobox.Checked[j-1]:=mainform.Effektaudiodatei_record.layer[j].layeractive;
    	activelayer[j-1]:=mainform.Effektaudiodatei_record.layer[j].layeractive;
    end;

    layerbox.ItemIndex:=0;
		layerboxChange(nil);
    end;

    Check_audioeffektbuttons();
  if not mainform.startingup then
    inprogress.Hide;
end;

procedure Taudioeffektplayerform.Effektlistespeichern1Click(
  Sender: TObject);
var
  j,k,effektanzahl:integer;
  savefile,effectfilepath,effectfilename:string;
begin
  if not mainform.UserAccessGranted(1) then exit;

  savedialog.Title:=('PC_DIMMER Effektliste speichern...');
  savedialog.Filter:=('PC_DIMMER Effektliste (*.pcdelst)|*.pcdelst|*.*|*.*');
  savedialog.FileName:='';
  savedialog.DefaultExt:='*.pcdelst';
  if savedialog.execute then
    begin
      savefile:=savedialog.filename;

      effectfilepath:=ExtractFilepath(savefile);
      effectfilename:=ExtractFileName(savefile);

      If not DirectoryExists(mainform.userdirectory+'Temp') then
        ForceDirectories(mainform.userdirectory+'Temp');
      DeleteFile(mainform.userdirectory+'Temp\*.*');
			FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektliste',fmCreate);
      // Einzelne Layer und Effekte speichern
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layeranzahl,sizeof(mainform.Effektaudiodatei_record.layeranzahl));
      for j:=1 to maxaudioeffektlayers do
      begin
        // Effektanzahl herausfinden
	      effektanzahl:=length(mainform.Effektaudiodatei_record.layer[j].effekt);
				// Effektanzahl abspeichern
        FileStream.WriteBuffer(effektanzahl,sizeof(effektanzahl));
        // Effektarray abspeichern
        for k:=0 to effektanzahl-1 do
        begin
	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k],sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k]));
        end;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].layeractive:=activelayer[j-1];
        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].layeractive,sizeof(mainform.Effektaudiodatei_record.layer[j].layeractive));
      end;
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatjump,sizeof(mainform.Effektaudiodatei_record.repeatjump));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatdestination,sizeof(mainform.Effektaudiodatei_record.repeatdestination));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatactive,sizeof(mainform.Effektaudiodatei_record.repeatactive));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.volume,sizeof(mainform.Effektaudiodatei_record.volume));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.videoseeking,sizeof(mainform.Effektaudiodatei_record.videoseeking));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layername,sizeof(mainform.Effektaudiodatei_record.layername));
			FileStream.Free;

      mainform.Compress.CompressDirectory(mainform.userdirectory+'Temp\',false,effectfilepath+effectfilename);
      inprogress.Hide;
      DeleteFile(mainform.userdirectory+'Temp\*.*');
    end;
end;

procedure Taudioeffektplayerform.Effektlistelschen1Click(Sender: TObject);
var
  j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if messagedlg(_('Gesamte Effektliste löschen?'),mtWarning,
    [mbYes,mbNo],0)=mrYes then
  begin
    for j:=1 to maxaudioeffektlayers do
		begin
      maxaudioeffekte[j]:=0;
		  setlength(mainform.Effektaudiodatei_record.layer[j].effekt,0);
    end;
    layerbox.ItemIndex:=0;
		layerboxChange(nil);
  end;
end;

procedure Taudioeffektplayerform.RecordModus1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if RecordModus1.Checked then
	begin
		recordbtn_on.Visible:=false;
	  recordbtn_off.Visible:=true;
  end else
	begin
		recordbtn_on.Visible:=true;
	  recordbtn_off.Visible:=false;
  end;
end;

procedure Taudioeffektplayerform.Wavedarstellungzweifarbig1Click(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  Wavedarstellungzweifarbig1.Checked:=not Wavedarstellungzweifarbig1.Checked;
  Wavezweifarbig.Checked:=Wavedarstellungzweifarbig1.Checked;
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.Repeataktiviert1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  Repeataktiviert1.Checked:=not Repeataktiviert1.Checked;
  Repeataktiviert.Checked:=Repeataktiviert1.Checked;
  mainform.Effektaudiodatei_record.repeatactive:=Repeataktiviert.Checked;
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.SprungmarkeanaktuellePosition1Click(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  mainform.Effektaudiodatei_record.repeatjump:=BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE);
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.Sprungmarkeverschieben1Click(
  Sender: TObject);
var
	i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  i:=(strtoint(InputBox(_('Repeat-Sprungmarke'),_('Bitte geben Sie eine Differenz zur neuen Position in ms ein:'),inttostr(0))));
  mainform.Effektaudiodatei_record.repeatjump:=BASS_ChannelSeconds2Bytes(_chan[0],BASS_ChannelBytes2Seconds(_chan[0],mainform.Effektaudiodatei_record.repeatjump)+i/1000);
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.ZielmarkeanaktuellePosition1Click(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  mainform.Effektaudiodatei_record.repeatdestination:=BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE);
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.Zielmarkeverschieben1Click(
  Sender: TObject);
var
	i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  i:=(strtoint(InputBox(_('Repeat-Zielmarke'),_('Bitte geben Sie eine Differenz zur neuen Position in ms ein:'),inttostr(0))));
  mainform.Effektaudiodatei_record.repeatdestination:=BASS_ChannelSeconds2Bytes(_chan[0],BASS_ChannelBytes2Seconds(_chan[0],mainform.Effektaudiodatei_record.repeatdestination)+i/1000);
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.Importieren1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  opendialog.Title:=_('PC_DIMMER Repeatmarken öffnen...');
  opendialog.Filter:=_('PC_DIMMER Repeatmarken (*.pcderpt)|*.pcderpt|*.*|*.*');
  opendialog.FileName:='';
  opendialog.DefaultExt:='*.pcderpt';
//  if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
  if opendialog.execute then
  begin
		FileStream:=TFileStream.Create(opendialog.FileName,fmOpenRead);
    Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatjump,sizeof(mainform.Effektaudiodatei_record.repeatjump));
    Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatdestination,sizeof(mainform.Effektaudiodatei_record.repeatdestination));
    Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatactive,sizeof(mainform.Effektaudiodatei_record.repeatactive));
    Filestream.ReadBuffer(mainform.Effektaudiodatei_record.volume,sizeof(mainform.Effektaudiodatei_record.volume));
		FileStream.Free;
		Repeataktiviert.Checked:=mainform.Effektaudiodatei_record.repeatactive;
		Repeataktiviert1.Checked:=mainform.Effektaudiodatei_record.repeatactive;
  end;
end;

procedure Taudioeffektplayerform.Exportieren1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  savedialog.Title:=_('PC_DIMMER Repeatmarken speichern...');
  savedialog.Filter:=_('PC_DIMMER Repeatmarken (*.pcderpt)|*.pcderpt|*.*|*.*');
  savedialog.FileName:='';
  savedialog.DefaultExt:='*.pcderpt';
  if savedialog.execute then
    begin
			FileStream:=TFileStream.Create(savedialog.FileName,fmCreate);
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatjump,sizeof(mainform.Effektaudiodatei_record.repeatjump));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatdestination,sizeof(mainform.Effektaudiodatei_record.repeatdestination));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatactive,sizeof(mainform.Effektaudiodatei_record.repeatactive));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.volume,sizeof(mainform.Effektaudiodatei_record.volume));
			FileStream.Free;
    end;
end;

procedure Taudioeffektplayerform.audioeffekttimerTimer(Sender: TObject);
var
  FFTData : TFFTData;
  t:integer;
  h,min,s,ms:string;
  CurrentPosition:Double;
begin
// This timer draws the waveform in the audioeffectplayer

  if Anzeigedeaktivieren1.checked then
  begin
    _Buffer.Canvas.Pen.Style:=psClear;
    _Buffer.Canvas.Brush.Color := clBlack;
    _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);
    _Buffer.Canvas.Pen.Style:=psSolid;
    _Buffer.Canvas.Pen.Color:=clWhite;
    _Buffer.Canvas.Font.Color:=clWhite;
    _Buffer.Canvas.Font.Size:=10;
    _Buffer.Canvas.Font.Style:=[];
    _Buffer.Canvas.TextOut(50,50,_('PC_DIMMER Audioeffektplayer'));
    _Buffer.Canvas.MoveTo(50,75);
    _Buffer.Canvas.Font.Size:=8;
    _Buffer.Canvas.TextOut(50,100,_('- Anzeige wurde in den Optionen deaktiviert - '));
  end else
  begin
    if not mainform.shutdown then
    begin
      if (timerenabled=false) and (NoAudiofile=false) and (audioeffektfilenamebox.itemindex<audioeffektfilenamebox.Items.Count-1) then
      begin
        // Audiodateiscanning...
        _Buffer.Canvas.Pen.Style:=psClear;
        _Buffer.Canvas.Brush.Color := clBlack;
        _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);
        _Buffer.Canvas.Pen.Style:=psSolid;
        _Buffer.Canvas.Pen.Color:=clWhite;
        _Buffer.Canvas.Font.Color:=clWhite;
        _Buffer.Canvas.Font.Size:=10;
        _Buffer.Canvas.Font.Style:=[];
        _Buffer.Canvas.TextOut(50,50,_('Scanne Audiodatei... ')+inttostr(scanpeakpercentage)+'%');
        _Buffer.Canvas.MoveTo(50,75);
        _Buffer.Canvas.Brush.Color := clBlue;
        _Buffer.Canvas.Rectangle(50,75,trunc(50+scanpeakpercentage/100*(waveform.width-100)),90);
        _Buffer.Canvas.Brush.Color := clBlack;
        EstimatedTime.Value:=scanpeakpercentage;
        _Buffer.Canvas.Font.Size:=8;
        _Buffer.Canvas.TextOut(50,100,_('Ungefähre Restdauer: ')+userfriendlytime(EstimatedTime.LeftTime));
      end else
      if ((timerenabled=false) and (NoAudiofile=true)) or (audioeffektfilenamebox.itemindex=audioeffektfilenamebox.Items.Count-1) then
      begin
        // keine Audiodatei geladen
        _Buffer.Canvas.Pen.Style:=psClear;
        _Buffer.Canvas.Brush.Color := clBlack;
        _Buffer.Canvas.FillRect(_Buffer.Canvas.ClipRect);
        _Buffer.Canvas.Pen.Style:=psSolid;
        _Buffer.Canvas.Pen.Color:=clWhite;
        _Buffer.Canvas.Font.Color:=clWhite;
        _Buffer.Canvas.Font.Size:=10;
        _Buffer.Canvas.Font.Style:=[];
        _Buffer.Canvas.TextOut(50,50,_('PC_DIMMER Audioeffektplayer'));
        _Buffer.Canvas.MoveTo(50,75);
        _Buffer.Canvas.Font.Size:=8;
        _Buffer.Canvas.TextOut(50,100,_('Bitte eine Audiodatei laden...'));
      end else
      begin
        // Timeranzeige aktualisieren, falls Playtimer nicht aktiviert
        if not audioeffektplaytimer.Enabled then
        begin
          CurrentPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
          t:=trunc(CurrentPosition*1000);
          AktuellePosition:=round(CurrentPosition);
          h:=inttostr(t div 3600000); t:=t mod 3600000;
          min:=inttostr(t div 60000); t:=t mod 60000;
          s:=inttostr(t div 1000); t:=t mod 1000;
          ms:=inttostr(t);
          if length(min)=1 then min:='0'+min;
          if length(s)=1 then s:='0'+s;
          if length(ms)=1 then ms:='0'+ms;
          if length(ms)=2 then ms:='0'+ms;
          AudioeffektplayerTimeLabel.Caption:= h+'h '+min+'min '+s+'s '+ms+'ms';
        end;
        case Wavedarstellung.itemindex of
          0..1: DrawAudioeffekte;
          2..3:
          begin
            // Spektraldarstellung
            if BASS_ChannelIsActive(_chan[0]) = BASS_ACTIVE_PLAYING then
            begin
              BASS_ChannelGetData(_chan[0], @FFTData, BASS_DATA_FFT1024);
              AudioeffectSpectrum.Draw(_Buffer.Canvas.Handle, FFTData, 0, 0);
              // kompletten Puffer auf Anzeige kopieren
            end;
          end;
        end;
      end;
    end;
  end;

  BitBlt(waveform.Canvas.Handle,0,0,waveform.Width,waveform.Height,_Buffer.Canvas.Handle,0,0,SRCCOPY);

  refreshingwaveform:=false;
end;

procedure Taudioeffektplayerform.DrawAudioeffekte;
begin
  if (not dontscanforeffects) and (not recordeffect) and (not refreshingwaveform) then
  begin
    refreshingwaveform:=true;

    if not mainform.shutdown then
    if timerenabled then
    begin
      if (_buffer.Width<>waveform.Width) or (_buffer.Height<>waveform.Height) then
      begin
        _buffer.Width:=waveform.Width;
        _buffer.Height:=waveform.Height;
      end;

      case Wavedarstellung.itemindex of
        0..1:
        begin
          // falls gewünscht, Anzeige scrollen lassen
          if (Wavedarstellung.itemindex=0) and ScrolltimelineCheckbox.checked then
            if ((BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp)-(waveform.Width div 2)>=waveform_scrollbar.Min) and ((BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp)-(waveform.Width div 2)<=waveform_scrollbar.Max) then
              _scroll:=(BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp)-(waveform.Width div 2);

          DrawSpectrum(_Buffer.Canvas); // Spektrum zeichnen
          DrawTimeline(_Buffer.Canvas); // Timeline zeichnen
          DrawEffects(_Buffer.Canvas); // Effekte zeichnen
          DrawActualPosition(_Buffer.Canvas);  // Aktuellen Positionsmarker zeichnen
        end;
      end;
    end;
    refreshingwaveform:=false;
  end;
end;

procedure Taudioeffektplayerform.audioeffektplaytimerTimer(
  Sender: TObject);
var
	t: integer;
  h,min,s,ms:string;
  CurrentPosition:Double;
begin
  if mainform.shutdown then exit;

// This timer generates the signal for the audioeffecttimeline and vumeter

// Timeline aktualisieren, wenn nicht nach Trackposition gesucht wird
    if (seeking_effektaudio = -1) then
      audioeffektscrollbar.Position:=BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _scrollbpp;

    // Timeranzeige aktualisieren
    CurrentPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
    t:=trunc(CurrentPosition*1000);
    AktuellePosition:=round(CurrentPosition);
    h:=inttostr(t div 3600000); t:=t mod 3600000;
    min:=inttostr(t div 60000); t:=t mod 60000;
    s:=inttostr(t div 1000); t:=t mod 1000;
    ms:=inttostr(t);
    if length(min)=1 then min:='0'+min;
    if length(s)=1 then s:='0'+s;
    if length(ms)=1 then ms:='0'+ms;
    if length(ms)=2 then ms:='0'+ms;
    AudioeffektplayerTimeLabel.Caption:= h+'h '+min+'min '+s+'s '+ms+'ms';

    //if (BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)>0) and (not StopEffektaudio.Enabled) then
    //  StopEffektaudio.Enabled:=true;

    // Am Ende stoppen
    if (CurrentPosition>=(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE))-0.5)) or (LastPosition>CurrentPosition) then //    if BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)>=(BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE)-20000) then
    begin
      StopEffektaudioClick(nil);
    end;

    // Aktuelle Position abspeichern:
    LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
end;

procedure Taudioeffektplayerform.OpenEffektlisteClick(Sender: TObject);
var
  j,k,m,n,effektanzahl:integer;
  openfile,effectfilepath,effectfilename:string;
begin
  if not mainform.UserAccessGranted(1) then exit;

  opendialog.Title:=_('PC_DIMMER Effektliste öffnen...');
  opendialog.Filter:=_('PC_DIMMER Effektliste (*.pcdelst)|*.pcdelst|*.*|*.*');
  opendialog.FileName:='';
  opendialog.DefaultExt:='*.pcdelst';
//  if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
  if opendialog.execute then
  begin
    openfile:=opendialog.filename;

    effectfilepath:=ExtractFilepath(openfile);
    effectfilename:=ExtractFileName(openfile);

    If not DirectoryExists(mainform.userdirectory+'Temp') then
      ForceDirectories(mainform.userdirectory+'Temp');
    DeleteFile(mainform.userdirectory+'Temp\*.*');
    mainform.Compress.DecompressFile(effectfilepath+effectfilename,mainform.userdirectory+'Temp\',true,false);

		FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektliste',fmOpenRead);
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layeranzahl,sizeof(mainform.Effektaudiodatei_record.layeranzahl));
      // Einzelne Layer und Effekte laden
      for j:=1 to maxaudioeffektlayers do
      begin
        // Effektanzahl herausfinden
        FileStream.ReadBuffer(effektanzahl,sizeof(effektanzahl));
        maxaudioeffekte[j]:=effektanzahl;
        // Effektarraygrößen festlegen
        setlength(_effektaudioeffektpassed[j],effektanzahl);
        setlength(mainform.Effektaudiodatei_record.layer[j].effekt,effektanzahl);
        // Effektarrays laden
        for k:=0 to effektanzahl-1 do
        begin
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].ID));
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Name, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Name));
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Beschreibung, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Beschreibung));
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].StopScene, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].StopScene));
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].audioeffektposition, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].audioeffektposition));
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].UseIDScene, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].UseIDScene));
          Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].fadetime, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].fadetime));

          FileStream.ReadBuffer(m,sizeof(m));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices, m);
          for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices)-1 do
          begin
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ID));

            FileStream.ReadBuffer(n,sizeof(n));
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActiveRandom, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValue, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValueRandom, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanDelay, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanFadetime, n);
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive)-1 do
            begin
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActiveRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActiveRandom[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValue[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValue[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValueRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValueRandom[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanDelay[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanDelay[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanFadetime[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanFadetime[n]));
            end;
          end;

          FileStream.ReadBuffer(m,sizeof(m));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle, m);
          for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle)-1 do
          begin
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ID));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Typ, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Typ));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Name, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Name));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Beschreibung, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Beschreibung));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OnValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OnValue));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].SwitchValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].SwitchValue));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OffValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OffValue));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].InvertSwitchValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].InvertSwitchValue));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ScaleValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ScaleValue));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].RunOnProjectLoad, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].RunOnProjectLoad));
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Category, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Category));

            FileStream.ReadBuffer(n,sizeof(n));
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger, n);
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger)-1 do
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger[n]));

            FileStream.ReadBuffer(n,sizeof(n));
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString, n);
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString)-1 do
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString[n]));

            FileStream.ReadBuffer(n,sizeof(n));
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID, n);
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID)-1 do
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID[n]));
          end;

          FileStream.ReadBuffer(m,sizeof(m));
          setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte, m);
          for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte)-1 do
          begin
            Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ID));

            FileStream.ReadBuffer(n,sizeof(n));
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay, n);
            setlength(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime, n);
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive)-1 do
            begin
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay[n]));
              Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime[n]));
            end;
          end;
        end;
        Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layer[j].layeractive,sizeof(mainform.Effektaudiodatei_record.layer[j].layeractive));

        layercombobox.Checked[j-1]:=mainform.Effektaudiodatei_record.layer[j].layeractive;
      	activelayer[j-1]:=layercombobox.Checked[j-1];
      end;
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatjump,sizeof(mainform.Effektaudiodatei_record.repeatjump));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatdestination,sizeof(mainform.Effektaudiodatei_record.repeatdestination));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.repeatactive,sizeof(mainform.Effektaudiodatei_record.repeatactive));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.volume,sizeof(mainform.Effektaudiodatei_record.volume));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.videoseeking,sizeof(mainform.Effektaudiodatei_record.videoseeking));
      Filestream.ReadBuffer(mainform.Effektaudiodatei_record.layername,sizeof(mainform.Effektaudiodatei_record.layername));

      FileStream.Free;
      DeleteFile(mainform.userdirectory+'Temp\*.*');

      repeataktiviert.Checked:=mainform.Effektaudiodatei_record.repeatactive;
      repeataktiviert1.Checked:=mainform.Effektaudiodatei_record.repeatactive;

      layerbox.ItemIndex:=0;
      layerboxChange(nil);
    end;

  Check_audioeffektbuttons();
  if not mainform.startingup then
    inprogress.Hide;
end;

procedure Taudioeffektplayerform.SaveEffektlisteClick(Sender: TObject);
var
  j,k,m,n,effektanzahl:integer;
  savefile,effectfilepath,effectfilename:string;
begin
  if not mainform.UserAccessGranted(1) then exit;

  savedialog.Title:=_('PC_DIMMER Effektliste speichern...');
  savedialog.Filter:=_('PC_DIMMER Effektliste (*.pcdelst)|*.pcdelst|*.*|*.*');
  savedialog.FileName:='';
  savedialog.DefaultExt:='*.pcdelst';
  if savedialog.execute then
    begin
      savefile:=savedialog.filename;

      effectfilepath:=ExtractFilepath(savefile);
      effectfilename:=ExtractFileName(savefile);

      If not DirectoryExists(mainform.userdirectory+'Temp') then
        ForceDirectories(mainform.userdirectory+'Temp');
      DeleteFile(mainform.userdirectory+'Temp\*.*');
			FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektliste',fmCreate);
      // Einzelne Layer und Effekte speichern
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layeranzahl,sizeof(mainform.Effektaudiodatei_record.layeranzahl));
      for j:=1 to maxaudioeffektlayers do
      begin
        // Effektanzahl herausfinden
	      effektanzahl:=length(mainform.Effektaudiodatei_record.layer[j].effekt);
				// Effektanzahl abspeichern
        FileStream.WriteBuffer(effektanzahl,sizeof(effektanzahl));
        // Effektarray abspeichern
        for k:=0 to effektanzahl-1 do
        begin
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].ID));
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Name, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Name));
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Beschreibung, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Beschreibung));
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].StopScene, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].StopScene));
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].audioeffektposition, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].audioeffektposition));
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].UseIDScene, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].UseIDScene));
          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].fadetime, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].fadetime));

          m:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices);
          FileStream.WriteBuffer(m,sizeof(m));
          for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices)-1 do
          begin
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ID));

            n:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive);
            FileStream.WriteBuffer(n,sizeof(n));
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive)-1 do
  	        begin
              Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActive[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActiveRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanActiveRandom[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValue[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValue[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValueRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanValueRandom[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanDelay[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanDelay[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanFadetime[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Devices[m].ChanFadetime[n]));
            end;
          end;

          m:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle);
          FileStream.WriteBuffer(m,sizeof(m));
          for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle)-1 do
          begin
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ID));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Typ, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Typ));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Name, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Name));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Beschreibung, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Beschreibung));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OnValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OnValue));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].SwitchValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].SwitchValue));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OffValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].OffValue));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].InvertSwitchValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].InvertSwitchValue));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ScaleValue, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ScaleValue));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].RunOnProjectLoad, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].RunOnProjectLoad));
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Category, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].Category));

            n:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger);
            FileStream.WriteBuffer(n,sizeof(n));
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger)-1 do
              Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgInteger[n]));

            n:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString);
            FileStream.WriteBuffer(n,sizeof(n));
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString)-1 do
              Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgString[n]));

            n:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID);
            FileStream.WriteBuffer(n,sizeof(n));
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID)-1 do
              Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehle[m].ArgGUID[n]));
          end;

          m:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte);
          FileStream.WriteBuffer(m,sizeof(m));
          for m:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte)-1 do
          begin
  	        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ID, sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ID));

            n:=length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive);
            FileStream.WriteBuffer(n,sizeof(n));
            for n:=0 to length(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive)-1 do
  	        begin
              Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActive[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanActiveRandom[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValue[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanValueRandom[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanDelay[n]));
  	          Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime[n], sizeof(mainform.Effektaudiodatei_record.layer[j].effekt[k].Befehlswerte[m].ChanFadetime[n]));
            end;
          end;
        end;
        mainform.effektaudio_record[audioeffektfilenamebox.ItemIndex].effektaudiodatei.layer[j].layeractive:=activelayer[j-1];
        Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layer[j].layeractive,sizeof(mainform.Effektaudiodatei_record.layer[j].layeractive));
      end;
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatjump,sizeof(mainform.Effektaudiodatei_record.repeatjump));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatdestination,sizeof(mainform.Effektaudiodatei_record.repeatdestination));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.repeatactive,sizeof(mainform.Effektaudiodatei_record.repeatactive));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.volume,sizeof(mainform.Effektaudiodatei_record.volume));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.videoseeking,sizeof(mainform.Effektaudiodatei_record.videoseeking));
      Filestream.WriteBuffer(mainform.Effektaudiodatei_record.layername,sizeof(mainform.Effektaudiodatei_record.layername));
			FileStream.Free;

      mainform.Compress.CompressDirectory(mainform.userdirectory+'Temp\',false,effectfilepath+effectfilename);
      inprogress.Hide;
      DeleteFile(mainform.userdirectory+'Temp\*.*');
    end;
end;

procedure Taudioeffektplayerform.Button1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  if panelLighteffects.visible then
  begin
    panelLighteffects.visible:=false;
    panelAudioeffects.visible:=true;
  end else
  begin
    save_eqClick(Sender);
    panelLighteffects.visible:=true;
    panelAudioeffects.visible:=false;
  end;
end;

procedure Taudioeffektplayerform.ScanPeaks(decoder : HSTREAM);
var
  i,maxlength : integer;
  maxvalL, minvalL,maxvalR,minvalR : smallint;
  totalmaxL, totalminL, totalmaxR, totalminR : smallint;
  killscan:boolean;
  scrollbereich:integer;
begin
  timerenabled:=false;
  Bass_ChannelSetPosition(decoder,0, BASS_POS_BYTE);
  EstimatedTime.Start;

//  scrollbereich:=trunc((4410));
  scrollbereich:=BASS_ChannelGetLength(decoder, BASS_POS_BYTE) div ((maxzoom * waveform.Width)+1);

  maxlength := maxzoom * waveform.Width +1;
  setlength(_wavebufL_max, maxlength);
  setlength(_wavebufL_min, maxlength);
  setlength(_wavebufR_max, maxlength);
  setlength(_wavebufR_min, maxlength);
  setlength(_wavebufTime, maxlength);
  setlength(_wavedecodeb, scrollbereich);

  totalmaxL:=0;
  totalminL:=0;
  totalmaxR:=0;
  totalminR:=0;
  wavposa:=1;
  zoomvert:=1000;

//  progressbar1.Visible:=true;
  killscan:=false;

  while not killscan do
  begin
    if Bass_ChannelGetPosition(decoder, BASS_POS_BYTE) < BASS_ChannelGetLength(decoder, BASS_POS_BYTE) then
    begin
      maxvalL := 0;
      minvalL := 0;
      maxvalR := 0;
      minvalR := 0;
      scanpeakpercentage:= trunc((Bass_ChannelGetPosition(decoder, BASS_POS_BYTE) / Bass_ChannelGetLength(decoder, BASS_POS_BYTE))*100);
      Bass_ChannelGetData(decoder, _wavedecodeb, scrollbereich);
      for i := 0 to (scrollbereich div 2) do
      if i*2<length(_wavedecodeb) then
      begin
        if _wavedecodeb[i*2] > maxvalL then maxvalL := _wavedecodeb[i*2];
        if _wavedecodeb[i*2] < minvalL then minvalL := _wavedecodeb[i*2];
        if i>0 then
        begin
          if _wavedecodeb[i*2-1] > maxvalR then maxvalR := _wavedecodeb[i*2-1];
          if _wavedecodeb[i*2-1] < minvalR then minvalR := _wavedecodeb[i*2-1];
        end;
      end;

      if totalmaxL < maxvalL then totalmaxL := maxvalL;
      if totalminL > minvalL then totalminL := minvalL;
      if totalmaxR < maxvalR then totalmaxR := maxvalR;
      if totalminR > minvalR then totalminR := minvalR;
/////////////////
/////////////////
      if wavposa<length(_wavebufTime) then
      begin
         _wavebufTime[wavposa] := Bass_ChannelBytes2Seconds(decoder, Bass_ChannelGetPosition(decoder, BASS_POS_BYTE));
         _wavebufL_max[wavposa] := maxvalL;
         _wavebufL_min[wavposa] := minvalL;
         _wavebufR_max[wavposa] := maxvalR;
         _wavebufR_min[wavposa] := minvalR;
      end;
/////////////////
      wavposa := wavposa + 1;
    end;

    if Bass_ChannelGetPosition(decoder, BASS_POS_BYTE) >= BASS_ChannelGetLength(decoder, BASS_POS_BYTE) then
    begin
      killscan:=true;
    end;
  end;
  timerenabled:=true;

  BASS_StreamFree(_decodechan);
  _decodechan:=0;
  dontscanforeffects:=false;
end;

procedure Taudioeffektplayerform.DrawSpectrum(_Buffer:TCanvas);
var
  i, j, ht,maxvalL,minvalL,maxvalR,minvalR,start,ende : integer;
  position:single;
begin
  _Buffer.Pen.Style:=psClear;
//  _Buffer.Brush.Color := clBlack;
//  _Buffer.FillRect(_Buffer.ClipRect);
  DrawGradientH(_Buffer, clBlack, clBlue, Rect(0, 0, waveform.width, trunc(waveform.Height / 11 * 1.5*waveformscaling)));
  DrawGradientH(_Buffer, clBlue, clBlack, Rect(0, trunc(waveform.Height / 11 * 1.5*waveformscaling), waveform.Width, trunc(waveform.Height / 11 * 3*waveformscaling)));
  _Buffer.Pen.Style:=psSolid;
  ht := (waveform.Height div 11);

  case Wavedarstellung.itemindex of
  0: // statische Anzeige
  begin
    // always seek for actual position
    position:=Bass_ChannelBytes2Seconds(_chan[0],trunc(_bpp*_scroll / (maxzoom / _Scaling)));
    if counta<length(_wavebufTime) then
    begin
      if _wavebufTime[counta]<position then
        repeat
          counta := counta + 1;
        until (counta>=length(_wavebufTime)) or (_wavebufTime[counta] >= position);
      if (counta>0) and (counta<length(_wavebufTime)) and (_wavebufTime[counta]>position) then
        repeat
          counta := counta - 1;
        until (counta=0) or (_wavebufTime[counta] <= position);
    end;

    for i := 1 to waveform.width do
    begin
    maxvalL:=0;
    minvalL:=0;
    maxvalR:=0;
    minvalR:=0;
    start:=trunc((i+ counta)*maxzoom / _scaling);
    ende:=(trunc((i+ counta)*maxzoom / _scaling+(maxzoom/_scaling)));
    for j:=start to ende do
    if (j>0) and (j<length(_wavebufL_max)) then
    begin
      if _wavebufL_max[j] > maxvalL then maxvalL := _wavebufL_max[j];
      if _wavebufL_min[j] < minvalL then minvalL := _wavebufL_min[j];
      if _wavebufR_max[j] > maxvalR then maxvalR := _wavebufR_max[j];
      if _wavebufR_min[j] < minvalR then minvalR := _wavebufR_min[j];
    end;

    if not _stereowaveform then
    begin
    // Mono-Waveform zeichnen
      if Wavedarstellungzweifarbig1.Checked then
  	    _Buffer.Pen.Color := clRed
      else
        _Buffer.Pen.Color := clGradientInactiveCaption;
      _Buffer.MoveTo(i, trunc(ht*1.5*waveformscaling));
      _Buffer.LineTo(i, trunc(ht*1.5*waveformscaling) - (maxvalL div (zoomvert)));
      if Wavedarstellungzweifarbig1.Checked then
  	    _Buffer.Pen.Color := clLime
      else
        _Buffer.Pen.Color := clGradientInactiveCaption;
      _Buffer.MoveTo(i, trunc(ht*1.5*waveformscaling));
      _Buffer.LineTo(i, trunc(ht*1.5*waveformscaling) - (minvalL div (zoomvert)));
    end else
    begin
    // Stereo-Waveform zeichnen
      if Wavedarstellungzweifarbig1.Checked then
  	    _Buffer.Pen.Color := clRed
      else
        _Buffer.Pen.Color := clGradientInactiveCaption;
      _Buffer.MoveTo(i, trunc(ht*0.75*waveformscaling) );
      _Buffer.LineTo(i, trunc(ht*0.75*waveformscaling) - (maxvalR div (zoomvert*2)));
      _Buffer.MoveTo(i, trunc(ht*0.75*waveformscaling) );
      _Buffer.LineTo(i, trunc(ht*0.75*waveformscaling) - (minvalR div (zoomvert*2)));

      if Wavedarstellungzweifarbig1.Checked then
  	    _Buffer.Pen.Color := clLime
      else
        _Buffer.Pen.Color := clGradientInactiveCaption;
      _Buffer.MoveTo(i, trunc(ht*2.25*waveformscaling) );
      _Buffer.LineTo(i, trunc(ht*2.25*waveformscaling) - (maxvalL div (zoomvert*2)));
      _Buffer.MoveTo(i, trunc(ht*2.25*waveformscaling) );
      _Buffer.LineTo(i, trunc(ht*2.25*waveformscaling)  - (minvalL div (zoomvert*2)));
    end;
    end;
  end;
  1: // Scrollende Anzeige
  begin
      position:=Bass_ChannelBytes2Seconds(_chan[0], Bass_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
      if moving = false then
        scrollbar1.Position := Trunc(position);

      // always seek for actual position
      if counta<length(_wavebufTime) then
      begin
        if _wavebufTime[counta]<position then
          repeat
            counta := counta + 1;
          until (counta>=length(_wavebufTime)) or (_wavebufTime[counta] >= position);
        if (counta>0) and (counta<length(_wavebufTime)) and (_wavebufTime[counta]>position) then
          repeat
            counta := counta - 1;
          until (counta=0) or (_wavebufTime[counta] <= position);
      end;

      // Waveform zeichnen
      for i := 1 to waveform.width do
      begin
        maxvalL:=0;
        minvalL:=0;
        maxvalR:=0;
        minvalR:=0;
        start:=trunc(((i-waveform.width/2) + counta/(maxzoom/_scaling)) );
        ende:=trunc(((i-waveform.width/2) + counta/(maxzoom/_scaling)) );
        for j:=start to ende do
        if (trunc(j*maxzoom/_scaling)>=0) and (trunc(j*maxzoom/_scaling)<length(_wavebufL_max)) then
        begin
          if _wavebufL_max[trunc(j*maxzoom/_scaling)] > maxvalL then maxvalL := _wavebufL_max[trunc(j*maxzoom/_scaling)];
          if _wavebufL_min[trunc(j*maxzoom/_scaling)] < minvalL then minvalL := _wavebufL_min[trunc(j*maxzoom/_scaling)];
          if _wavebufR_max[trunc(j*maxzoom/_scaling)] > maxvalR then maxvalR := _wavebufR_max[trunc(j*maxzoom/_scaling)];
          if _wavebufR_min[trunc(j*maxzoom/_scaling)] < minvalR then minvalR := _wavebufR_min[trunc(j*maxzoom/_scaling)];
        end;

        if not _stereowaveform then
        begin
          // Mono-Waveform
          if Wavedarstellungzweifarbig1.Checked then
      	    _Buffer.Pen.Color := clRed
          else
            _Buffer.Pen.Color := clGradientInactiveCaption;
          _Buffer.MoveTo(i, trunc(ht*1.5*waveformscaling));
          _Buffer.LineTo(i, trunc(ht*1.5*waveformscaling) - (maxvalL div (zoomvert)));

          if Wavedarstellungzweifarbig1.Checked then
      	    _Buffer.Pen.Color := clLime
          else
            _Buffer.Pen.Color := clGradientInactiveCaption;
          _Buffer.MoveTo(i, trunc(ht*1.5*waveformscaling));
          _Buffer.LineTo(i, trunc(ht*1.5*waveformscaling) - (minvalL div (zoomvert)));
        end else
        begin
          // Stereo-Waveform
          if Wavedarstellungzweifarbig1.Checked then
      	    _Buffer.Pen.Color := clRed
          else
            _Buffer.Pen.Color := clGradientInactiveCaption;
          _Buffer.MoveTo(i, trunc(ht*0.75*waveformscaling));
          _Buffer.LineTo(i, trunc(ht*0.75*waveformscaling) - (maxvalR div (zoomvert*2)));
          _Buffer.MoveTo(i, trunc(ht*0.75*waveformscaling));
          _Buffer.LineTo(i, trunc(ht*0.75*waveformscaling) - (minvalR div (zoomvert*2)));

          if Wavedarstellungzweifarbig1.Checked then
      	    _Buffer.Pen.Color := clLime
          else
            _Buffer.Pen.Color := clGradientInactiveCaption;
          _Buffer.MoveTo(i, trunc(ht*2.25*waveformscaling));
          _Buffer.LineTo(i, trunc(ht*2.25*waveformscaling) - (maxvalL div (zoomvert*2)));
          _Buffer.MoveTo(i, trunc(ht*2.25*waveformscaling));
          _Buffer.LineTo(i, trunc(ht*2.25*waveformscaling) - (minvalL div (zoomvert*2)));
        end;
      end;

      _Buffer.Pen.Color := clBlack;
      _Buffer.MoveTo(0, trunc(waveform.height div 11 * 1.5*waveformscaling));
      _Buffer.LineTo(waveform.width-1, trunc(waveform.height div 11 * 1.5*waveformscaling));
  end;
  end;
end;

procedure Taudioeffektplayerform.DrawTimeline(_Buffer:TCanvas);
var
  i:integer;
begin
  // Timeline zeichnen
  _Buffer.Brush.Color := clGray;
  _Buffer.Pen.Color:=clBlack;
  _Buffer.Pen.Style:=psSolid;
  if _audioeffektlayer=0 then
    _Buffer.Rectangle(0,(waveform.Height div 11 *3),waveform.Width,waveform.Height)
  else
    _Buffer.Rectangle(0,trunc((waveform.Height div 11 *3)*waveformscaling),waveform.Width,waveform.Height);
  _Buffer.Pen.Style:=psClear;

  if (mouseoverlayer>0) and (layerbox.ItemIndex=0) then
  begin
    _Buffer.Brush.Color := clSilver;
    _Buffer.Rectangle(0,(waveform.Height div 11 * (3+(mouseoverlayer-1))),waveform.Width,(waveform.Height div 11 * (4+(mouseoverlayer-1))));
  end;
  _Buffer.Pen.Style:=psSolid;
  _Buffer.Pen.Color:=clBlack;

  if (layerbox.ItemIndex=0) then
  begin
    for i:=1 to maxaudioeffektlayers do
    begin
      _Buffer.MoveTo(0,(waveform.Height div 11 *(2+i)));
      _Buffer.LineTo(waveform.Width,(waveform.Height div 11 *(2+i)));
      _Buffer.Font.Name:='Arial';
      _Buffer.Font.Size:=6;
      _Buffer.Font.Color:=clBlack;//clInactiveCaption;
      _Buffer.Brush.Style:=bsclear;
//      _Buffer.TextOut(2,waveform.Height div 11 *(2+i)+14,'Layer '+inttostr(i));
      _Buffer.TextOut(2,(waveform.Height div 11 *(2+i)+14),mainform.Effektaudiodatei_record.layername[i]);
      _Buffer.Brush.Style:=bsSolid;
    end;
  end else
  begin
    _Buffer.Font.Name:='Arial';
    _Buffer.Font.Size:=6;
    _Buffer.Font.Color:=clBlack;//clInactiveCaption;
    _Buffer.Brush.Style:=bsclear;
    _Buffer.TextOut(2,(waveform.Height div 11 * 3 + 2),mainform.Effektaudiodatei_record.layername[layerbox.ItemIndex]);
    _Buffer.Brush.Style:=bsSolid;
  end;
end;

procedure Taudioeffektplayerform.DrawEffects(_Buffer:TCanvas);
var
  i,j,k:integer;
  color:Tcolor;
  position:single;
  aktuelleslayer:integer;
begin
  aktuelleslayer:=_audioeffektlayer;

  case wavedarstellung.ItemIndex of
    0:
    begin
      // Audioeffekte anzeigen
      if aktuelleslayer=0 then
      begin
        for j:=1 to maxaudioeffektlayers do
        begin
  if _audioeffektlayer>0 then exit;
          if maxaudioeffekte[j]>0 then
            for i:=0 to maxaudioeffekte[j]-1 do
            begin
  if _audioeffektlayer>0 then exit;
                if effekteein.Checked then
                begin
                  color:=clYellow;
                  if activelayer[j-1] then
                  begin
                    // Unterschiedliche Farben für die einzelnen Layer
                    case j of
                      1: color:=clYellow;
                      2: color:=$000080FF;
                      3: color:=clRed;
                      4: color:=clGreen;
                      5: color:=clBlue;
                      6: color:=clFuchsia;
                      7: color:=clPurple;
                      8: color:=clMaroon;
                    end;

                    // Andere Farbe bei Selektion
  //	                if (effektliste.Selection.Top=j) or (active[j]) then
  //						      case j of
  //							      1: color:=$00DDFFFF;
  //							      2: color:=$009FCFFF;
  //							      3: color:=$00A6A6FF;
  //							      4: color:=$0055FF55;
  //							      5: color:=$00FFA8A8;
  //							      6: color:=$00FF9BFF;
  //							      7: color:=$00B700B7;
  //							      8: color:=$003C3CFF;
  //						    	end;

                  end else color:=clBlack;

                  if _effektaudioeffektpassed[j][i]=true then color:=clLime;
                end else
                begin
                  color:=clBlack;//clGray;
                end;
                // Effekte darstellen (8-fach-Darstellung)
                DrawTimecode_Line(_Buffer,mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition, (BASS_CHANNELSECONDS2BYTES(_chan[0],mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition) div _bpp - _scroll), ((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3)),((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3)),((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3))+(waveform.Height div (maxaudioeffektlayers+3)), ((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3))+(waveform.Height div (maxaudioeffektlayers+3))-12, inttostr(i), '', color, mainform.Effektaudiodatei_record.layer[j].effekt[i].fadetime, false);
              end;
        end;
      end else
      begin
        if maxaudioeffekte[aktuelleslayer]>0 then
          for i:=0 to maxaudioeffekte[aktuelleslayer]-1 do
            begin
              if _audioeffektlayer=0 then exit;
              if effekteein.Checked then
              begin
                if activelayer[aktuelleslayer-1] then color:=clYellow else color:=clGray;
                if i<length(_effektaudioeffektpassed[aktuelleslayer]) then
                  if _effektaudioeffektpassed[aktuelleslayer][i]=true then color:=clLime;
              end else
              begin
                color:=clGray;
              end;

              if active[i+1] then color:=clRed;
              if i=effektliste.Selection.Top-1 then color:=clWhite;
              // Effekte des aktuellen Layers anzeigen
              if i<length(mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt) then
                DrawTimeCode_Line(_Buffer,mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].audioeffektposition, (BASS_CHANNELSECONDS2BYTES(_chan[0],mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].audioeffektposition) div _bpp - _scroll), (waveform.Height div 11) * 3,(waveform.Height div 11) * 3, waveform.Height, waveform.Height - 15, inttostr(i), mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].Name, color, mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].fadetime, false);
                               //position: Single                                                                         x                                                                                                                                                 y                                  linestart                           lineend                namey                       name         Beschreibung cl     Blendzeit
            end;
      end;

      // Repeat-Marker anzeigen
      if Repeataktiviert.Checked then
      begin
        DrawTimecode_Line(_Buffer,BASS_ChannelBytes2Seconds(_chan[0],mainform.Effektaudiodatei_record.repeatjump), mainform.Effektaudiodatei_record.repeatjump div _bpp - _scroll, (waveform.Height div 11) * 3,0, waveform.Height, 135, 'Repeat-Sprung', '', clLime,-1, false);
        DrawTimecode_Line(_Buffer,BASS_ChannelBytes2Seconds(_chan[0],mainform.Effektaudiodatei_record.repeatdestination), mainform.Effektaudiodatei_record.repeatdestination div _bpp - _scroll, (waveform.Height div 11) * 3,0, waveform.Height, 135, 'Repeat-Ziel', '', clRed,-1, false);
      end;
    end;
    1:
    begin
        position:=Bass_ChannelBytes2Seconds(_chan[0], Bass_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
        if moving = false then
          scrollbar1.Position := Trunc(position);

        // always seek for actual position
        if counta<length(_wavebufTime) then
        begin
          if _wavebufTime[counta]<position then
            repeat
              counta := counta + 1;
            until (counta>=length(_wavebufTime)) or (_wavebufTime[counta] >= position);
          if (counta>0) and (counta<length(_wavebufTime)) and (_wavebufTime[counta]>position) then
            repeat
              counta := counta - 1;
            until (counta=0) or (_wavebufTime[counta] <= position);
        end;

        // Audioeffekte zeichnen
        if aktuelleslayer=0 then
        begin
          for j:=1 to maxaudioeffektlayers do
          begin
            if maxaudioeffekte[j]>0 then
            begin
              for i:=0 to maxaudioeffekte[j]-1 do
              begin
                if effekteein.Checked then
                begin
                  color:=clYellow;
                  if activelayer[j-1] then
                  begin
                    // Unterschiedliche Farben für die einzelnen Layer
                    case j of
                      1: color:=clYellow;
                      2: color:=$000080FF;
                      3: color:=clRed;
                      4: color:=clGreen;
                      5: color:=clBlue;
                      6: color:=clFuchsia;
                      7: color:=clPurple;
                      8: color:=clMaroon;
                    end;
                  end else
                  begin
                    color:=clGray;
                  end;

                  if _effektaudioeffektpassed[j][i]=true then
                    color:=clLime;
                end else
                begin
                  color:=clGray;
                end;

                // Effekte darstellen (8-fach-Darstellung)
                DrawTimecode_Line(_Buffer,mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition, trunc( BASS_CHANNELSECONDS2BYTES(_chan[0],mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition) div _bpp +(waveform.width/2) - trunc(counta/trunc(maxzoom/_scaling))), ((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3)),((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3)),((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3))+(waveform.Height div (maxaudioeffektlayers+3)), ((waveform.Height div (maxaudioeffektlayers+3))*(j-1+3))+(waveform.Height div (maxaudioeffektlayers+3))-12, inttostr(i), '', color, mainform.Effektaudiodatei_record.layer[j].effekt[i].fadetime, false);
              end;
            end;
          end;
        end else
        begin
          if maxaudioeffekte[aktuelleslayer]>0 then
          for i:=0 to maxaudioeffekte[aktuelleslayer]-1 do
          begin
            if effekteein.Checked then
            begin
              if activelayer[aktuelleslayer-1] then color:=clYellow else color:=clGray;
              if _effektaudioeffektpassed[aktuelleslayer][i]=true then color:=clLime;
            end else
            begin
              color:=clGray;
            end;

            if active[i+1] then color:=clRed;
            if i=effektliste.Selection.Top-1 then color:=clLime;
            // Effekte des aktuellen Layers anzeigen
            if Effektliste.RowCount>i-1 then
              DrawTimecode_Line(_Buffer,mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].audioeffektposition, trunc( BASS_CHANNELSECONDS2BYTES(_chan[0],mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].audioeffektposition) /_bpp + (waveform.width div 2) - counta/trunc(maxzoom/_scaling)), (waveform.Height div 11) * 3,(waveform.Height div 11) * 3, waveform.Height, waveform.Height - 15, inttostr(i), mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].Name, color, mainform.Effektaudiodatei_record.layer[aktuelleslayer].effekt[i].fadetime, false);
                                    //position: Single                                                                         x                                                                                                                                                 y                                  linestart                           lineend                namey                       name         Beschreibung cl     Blendzeit
          end;
        end;

  {
      // Repeat-Marker anzeigen
      if Repeataktiviert.Checked then
      begin
        DrawTimecode_Line(_Buffer,mainform.Effektaudiodatei_record.repeatjump, trunc( BASS_CHANNELSECONDS2BYTES(_chan[0],mainform.Effektaudiodatei_record.repeatjump /_bpp + (waveform.width div 2) - counta/trunc(maxzoom/_scaling)), (waveform.Height div 11) * 3,0, waveform.Height, 135, 'Repeat-Sprung', '', clLime,0, false);
        DrawTimecode_Line(_Buffer,mainform.Effektaudiodatei_record.repeatdestination, trunc( BASS_CHANNELSECONDS2BYTES(_chan[0],mainform.Effektaudiodatei_record.repeatdestination /_bpp + (waveform.width div 2) - counta/trunc(maxzoom/_scaling)), (waveform.Height div 11) * 3,0, waveform.Height, 135, 'Repeat-Ziel', '', clRed,0, false);
      end;
  }
    end;
  end;
end;

procedure Taudioeffektplayerform.DrawActualPosition(_Buffer:TCanvas);
begin
  case wavedarstellung.ItemIndex of
    0:
    begin
      // Aktuelle Position anzeigen
      DrawTimecode_Line(_Buffer, BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)), BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp - _scroll+1, (waveform.Height div 11) * 3, 0, waveform.Height, 0, '', '', TColor($000000),-1, true);
      DrawTimecode_Line(_Buffer, BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)), BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE) div _bpp - _scroll, (waveform.Height div 11) * 3, 0, waveform.Height, 0, '', '', TColor($FFFFFF),-1, true);
      if (_mousedwn=2) and (mouseovereffect>-1) then
      begin
//        DrawTimecode_Line(_Buffer, BASS_ChannelBytes2Seconds(_chan[0],_bpp*(_scroll+_mousepos+10)),_mousepos,0,0,waveform.Height div 11 * 3,0,'','',clBlack,-1, true);
        DrawTimecode_Line(_Buffer, BASS_ChannelBytes2Seconds(_chan[0],_bpp*(_scroll+_mousepos)),_mousepos,0,0,waveform.Height div 11 * 3,0,'','',clWhite,-1, true);
      end;

      // BPM-Detection-Bereich anzeigen
      DrawTimecode_Line(_Buffer, BPMstart*1000, BASS_ChannelSeconds2Bytes(_chan[0], BPMstart) div _bpp - _scroll, 0, 0, waveform.Height div 11 * 3, 16, 'BPM', '', clYellow, round(BPMstop*1000-BPMstart*1000), true);
    end;
    1:
    begin
      // Aktuelle Position zeichnen
      _Buffer.Pen.Color := clBlack;
      DrawTimecode_Line(_Buffer, BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)), waveform.Width div 2 +1, (waveform.Height div 11) * 3, 0, waveform.Height, 0, '', '', TColor($000000),-1, true);
      _Buffer.Pen.Color := clWhite;
      DrawTimecode_Line(_Buffer, BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)), waveform.Width div 2, (waveform.Height div 11) * 3, 0, waveform.Height, 0, '', '', TColor($FFFFFF),-1, true);
      _Buffer.Pen.Color := clBlack;
      if (_mousedwn=2) and (mouseovereffect>-1) then
      begin
        if trunc((_mousepos-waveform.width div 2)*(maxzoom/_scaling) + counta)<length(_wavebufTime) then
        begin
//          DrawTimecode_Line(_Buffer,_wavebufTime[trunc((_mousepos+10-waveform.width div 2)*(maxzoom/_scaling) + counta)],_mousepos,0,0,waveform.Height div 11 * 3,0,'','',clBlack,-1, false);
          DrawTimecode_Line(_Buffer,_wavebufTime[trunc((_mousepos-waveform.width div 2)*(maxzoom/_scaling) + counta)],_mousepos,0,0,waveform.Height div 11 * 3,0,'','',clWhite,-1, false);
        end;
      end;
    end;
  end;

  // Auswahlrechteck anzeigen
//  _Buffer.Pen.Mode:=pmNotXor;
//  _Buffer.Pen.Style:=psDashDot;
  _Buffer.Pen.Mode:=pmWhite;
 	_Buffer.Brush.Style:=bsclear;
 	_Buffer.Rectangle(x1,y1,x2,y2);
 	_Buffer.Pen.Mode:=pmCopy;
  _Buffer.Pen.Style:=psSolid;
end;

procedure Taudioeffektplayerform.DrawTimecode_Line(_Buffer:TCanvas; position : Single; x,y,linestart,lineend,namey : integer; name : string; Beschreibung: string; cl : TColor; Effektlength: integer; IgnoreScaleAndLayerDrawing: boolean);
var
  t: integer;
  str, h,min,s,ms :string;
  EndOfRectangle:integer;
begin
  _Buffer.Pen.Color := cl;
  _Buffer.MoveTo(x, (linestart+1));
  _Buffer.LineTo(x, lineend);

	_Buffer.Brush.Style:=bsSolid;
	_Buffer.Brush.Color:=cl;
  _Buffer.MoveTo(x,linestart);

  if Effektlength>-1 then
  begin
    EndOfRectangle:=x+(BASS_CHANNELSECONDS2BYTES(_chan[0],(Effektlength/1000)) div _bpp);
    if ((x<=LastEndOfRectangle) and (x>LastStartOfRectangle)) or ((EndOfRectangle>=LastEndOfRectangle) and (EndOfRectangle<LastStartOfRectangle)) then //(EndOfRectangle<=LastEndOfRectangle) then
      LastRow:=LastRow+1
    else
      LastRow:=0;

    if _audioeffektlayer>0 then
    begin
      _Buffer.Rectangle(x,trunc((linestart+1+LastRow*8)), EndOfRectangle,trunc((linestart+8+LastRow*8)));

      _Buffer.MoveTo(x,trunc((linestart+8+LastRow*8)));
      _Buffer.Pen.Color := clBlack;
      _Buffer.LineTo(EndOfRectangle,trunc((linestart+8+LastRow*8)));
      _Buffer.Pen.Color := cl;
    end else
    begin
      _Buffer.Rectangle(x,trunc((linestart+1+LastRow*2)), EndOfRectangle,trunc((linestart+3+LastRow*2)));
    end;

    LastStartOfRectangle:=x;
    LastEndOfRectangle:=EndOfRectangle;
  end;

  if (trunc(_scaling)>2) or IgnoreScaleAndLayerDrawing then
  begin
    _Buffer.Font.Style := [];
    if x > waveform.Width-30 then
      dec(x, 30);
    SetBkMode(_Buffer.Handle, TRANSPARENT);
    _Buffer.Font.Color := clBlack;
    _Buffer.Font.Name:='Arial';
    _Buffer.Font.Size:=5;
    if Effektlength>-1 then
    begin
      //Effektlänge berechnen
      t:=Effektlength;
      h:=inttostr(t div 3600000); t:=t mod 3600000;
      min:=inttostr(t div 60000); t:=t mod 60000;
      s:=inttostr(t div 1000); t:=t mod 1000;
      ms:=inttostr(t);
      if strtoint(h)>0 then str:=h+'h '+min+'min '+s+'s'
      else if strtoint(min)>0 then str:=min+'min '+s+'s'
      else if strtoint(s)>0 then str:=s+'s';
      if strtoint(ms)>0 then
      begin
        if length(str)>0 then
          str:=str+' '+ms+'ms'
        else
          str:=ms+'ms';
      end;
      _Buffer.TextOut(x+2, (y+1+LastRow*8), str);
    end;
    _Buffer.Font.Color := cl;
    _Buffer.Font.Size:=6;

    //Effektposition berechnen
    t:=trunc(position*1000);
    h:=inttostr(t div 3600000); t:=t mod 3600000;
    min:=inttostr(t div 60000); t:=t mod 60000;
    s:=inttostr(t div 1000); t:=t mod 1000;
    ms:=inttostr(t);
    if length(ms)=1 then ms:='00'+ms;
    if length(ms)=2 then ms:='0'+ms;
    if length(s)=1 then s:='0'+s;
    if h='0' then
      str := min+':'+s+':'+ms
    else
      str := h+':'+min+':'+s+':'+ms;

    _Buffer.TextOut(x+2, (y+8+LastRow*8), str); // Zeit
    if length(name)>0 then
      _Buffer.TextOut(x+2, (namey+3), name); // Nummer

    // Beschreibungstext anzeigen (nur wenn Einzellayer)
    if (length(beschreibung)>0) and ((layerbox.ItemIndex>0) or IgnoreScaleAndLayerDrawing) then
    begin
    	_Buffer.Brush.Style:=bsClear;
{
      // Text untereinander anzeigen
      for i:=1 to length(beschreibung) do
        _Buffer.TextOut(x+2, y+20+7*i, beschreibung[i]); // Beschreibung
}
      // Text um 90° gedreht anzeigen
      SelectObject(_Buffer.Handle, GedrehteSchrift);
      _Buffer.TextOut(x+12, (y+20+LastRow*8), beschreibung); // Beschreibung
    end;
  end;
end;

procedure Taudioeffektplayerform.Check_audioeffektbuttons();
var
  items:boolean;
begin
  if (effektliste.RowCount<=1) or (Effektliste.Cells[1,1]='') then
    items:=false else items:=true;

  if (_audioeffektlayer>0) and (audioeffektfilenamebox.Items.Count>1) then
  begin
    layerffnen1.Enabled:=true;
    layerspeichern1.Enabled:=true;
    button18.Enabled:=true;
    seteffecttoactualpositionbtn.Enabled:=true;
    MarkierteEffekteverschieben1.enabled:=true;
    MarkiertenEffektausfhren1.Enabled:=true;
    MarkiertenEffektstoppen1.Enabled:=true;
    MarkiertenEffektaufPositionXsetzen1.Enabled:=true;
  end else
  begin
    layerffnen1.Enabled:=false;
    layerspeichern1.Enabled:=false;
    layerlschen1.Enabled:=false;
    LayerkopierenzuLayer1.enabled:=false;
    button18.Enabled:=false;
    seteffecttoactualpositionbtn.Enabled:=false;
    MarkierteEffekteverschieben1.enabled:=false;
    MarkiertenEffektausfhren1.Enabled:=false;
    MarkiertenEffektstoppen1.Enabled:=false;
    MarkiertenEffektaufPositionXsetzen1.Enabled:=false;
    items:=false;
  end;

	layerbox.enabled:=audioeffektfilenamebox.Items.Count>1;
  Layernamenbearbeiten1.Enabled:=audioeffektfilenamebox.Items.Count>1;
	checkbox9.enabled:=audioeffektfilenamebox.Items.Count>1;
	Wavedarstellung.enabled:=audioeffektfilenamebox.Items.Count>1;

  Effektlschen1.Enabled:=items;

  DeleteEffekt.Enabled:=items;
  EditEffekt.Enabled:=items;
  CopyEffektBtn.Enabled:=items;
  Effektnachrechts.Enabled:=items;
  Effektnachlinks.Enabled:=items;
  RefreshEffect.Enabled:=items;

  movefileup.Enabled:=audioeffektfilenamebox.itemindex>0;
  movefiledown.Enabled:=audioeffektfilenamebox.itemindex<(audioeffektfilenamebox.Items.Count-2);
end;

procedure Taudioeffektplayerform.openeffektaudiofile(audioeeffektfile:string);
var
  filename,filepath:string;
  laenge,effektanzahl,i,j,k,l,m,Count,Count2, Fileversion:integer;
begin
    filename:=extractfilename(audioeeffektfile);
    filepath:=extractfilepath(audioeeffektfile);

    If not DirectoryExists(mainform.userdirectory+'Temp') then
      ForceDirectories(mainform.userdirectory+'Temp');
    DeleteFile(mainform.userdirectory+'Temp\*.*');
 		mainform.Compress.DecompressFile(filepath+filename,mainform.userdirectory+'Temp\',true,false);

    //Datei öffnen
    if fileexists(mainform.userdirectory+'Temp\Effektaudio') then
			FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\Effektaudio',fmOpenRead)
    else
    	FileStream:=TFileStream.Create(mainform.userdirectory+'Temp\'+filename,fmOpenRead);

    // Projektversion
    Filestream.ReadBuffer(FileVersion, sizeof(FileVersion));

    //Länge der Arrays als erstes auslesen
    FileStream.ReadBuffer(laenge,sizeof(laenge));
    // nun alle Array einzeln nacheinander lesen
    setlength(mainform.Effektaudio_record,laenge);

    for i:=0 to laenge-1 do
    begin
			Filestream.ReadBuffer(mainform.Effektaudio_record[i].audiodatei,sizeof(mainform.Effektaudio_record[i].audiodatei));
			Filestream.ReadBuffer(mainform.Effektaudio_record[i].audiopfad,sizeof(mainform.Effektaudio_record[i].audiopfad));
      // Einzelne Layer und Effekte laden
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layeranzahl,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layeranzahl));
      for j:=1 to maxaudioeffektlayers do
      begin
        // Effektanzahl herausfinden
        FileStream.ReadBuffer(effektanzahl,sizeof(effektanzahl));
        maxaudioeffekte[j]:=effektanzahl;
        // Effektarraygrößen festlegen
        setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt,effektanzahl);
        // Effektarray laden
        for k:=0 to effektanzahl-1 do
        begin
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ID,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].ID));
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Name,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Name));
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Beschreibung,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Beschreibung));
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].StopScene,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].StopScene));
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].audioeffektposition,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].audioeffektposition));
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].UseIDScene,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].UseIDScene));
         Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].fadetime,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].fadetime));
         Filestream.ReadBuffer(Count,sizeof(Count));
          setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices,Count);
          for l:=0 to Count-1 do
          begin
  	        Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ID,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ID));
	          Filestream.ReadBuffer(Count2,sizeof(Count2));
            setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive,Count2);
            setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue,Count2);
            setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom,Count2);
            setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom,Count2);
            setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay,Count2);
            setlength(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime,Count2);
            for m:=0 to Count2-1 do
            begin
	            Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive[m],sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActive[m]));
	            Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue[m],sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValue[m]));
	            Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom[m],sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanActiveRandom[m]));
	            Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom[m],sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanValueRandom[m]));
	            Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay[m],sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanDelay[m]));
	            Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime[m],sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].effekt[k].Devices[l].ChanFadetime[m]));
            end;
          end;
        end;
        Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].layeractive,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layer[j].layeractive));
      end;
			Filestream.ReadBuffer(mainform.Effektaudio_record[i].waveform,sizeof(mainform.Effektaudio_record[i].waveform));
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.repeatjump,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.repeatjump));
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.repeatdestination,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.repeatdestination));
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.repeatactive,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.repeatactive));
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.volume,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.volume));
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.videoseeking,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.videoseeking));
      Filestream.ReadBuffer(mainform.Effektaudio_record[i].effektaudiodatei.layername,sizeof(mainform.Effektaudio_record[i].effektaudiodatei.layername));
    end;
		//Datei wieder freigeben
    FileStream.Free;
    DeleteFile(mainform.userdirectory+'Temp\*.*');

        audioeffektfilenamebox.Clear;
        for i:=0 to laenge-1 do
        begin
          if not FileExists(mainform.Effektaudio_record[i].audiopfad+mainform.Effektaudio_record[i].audiodatei) then
            if pos('\ProjectTemp\',mainform.Effektaudio_record[i].audiopfad)>0 then
              mainform.Effektaudio_record[i].audiopfad:=mainform.userdirectory+copy(mainform.Effektaudio_record[i].audiopfad,pos('ProjectTemp\',mainform.Effektaudio_record[i].audiopfad),length(mainform.Effektaudio_record[i].audiopfad));

          if FileExists(mainform.Effektaudio_record[i].audiopfad+mainform.Effektaudio_record[i].audiodatei) then
          begin
            audioeffektfilenamebox.Items.Add(inttostr(i+1)+' - '+mainform.Effektaudio_record[i].audiodatei);
          end else
          if FileExists(mainform.project_folder+mainform.Effektaudio_record[i].audiodatei) then
          begin
            mainform.Effektaudio_record[i].audiopfad:=mainform.project_folder;
            audioeffektfilenamebox.Items.Add(inttostr(i+1)+' - '+mainform.Effektaudio_record[i].audiodatei);
          end else
          if (i>0) and FileExists(mainform.Effektaudio_record[i-1].audiopfad+mainform.Effektaudio_record[i].audiodatei) then
          begin
            mainform.Effektaudio_record[i].audiopfad:=mainform.Effektaudio_record[i-1].audiopfad;
            audioeffektfilenamebox.Items.Add(inttostr(i+1)+' - '+mainform.Effektaudio_record[i].audiodatei);
          end else
          begin
            if messagedlg(_('Die Audiodatei "')+mainform.Effektaudio_record[i].audiopfad+mainform.Effektaudio_record[i].audiodatei+_('" wurde nicht gefunden. Möchten Sie jetzt danach suchen?'),mtConfirmation,
              [mbYes,mbNo],0)=mrYes then
              begin
                OpenDialog.Filter:=_('Audiodateien|*.wav;*.mp3|*.*|*.*');
                OpenDialog.Title:=_('Audiodatei öffnen');
                opendialog.FileName:='';
//								    if mainform.project_folder<>'' then opendialog.InitialDir:=mainform.project_folder;
                if OpenDialog.Execute then
                begin
                  mainform.Effektaudio_record[i].audiopfad:=ExtractFilePath(OpenDialog.FileName);
                  mainform.Effektaudio_record[i].audiodatei:=ExtractFileName(OpenDialog.FileName);
                  audioeffektfilenamebox.Items.Add(inttostr(i+1)+' - '+ExtractFileName(OpenDialog.FileName));
                end;
              end else
                audioeffektfilenamebox.Items.Add(inttostr(i+1)+' - '+mainform.Effektaudio_record[i].audiodatei);
            end;
          end;
    audioeffektfilenamebox.items.Add(_('Audiodatei hinzufügen...'));
    audioeffektfilenamebox.ItemIndex:=0;
    audioeffektfilenameboxChange(nil);

    Dateispeichern1.Enabled:=true;
    Button20.Enabled:=true;
    Button21.Enabled:=true;
  if not mainform.startingup then
    inprogress.Hide;
end;

procedure Taudioeffektplayerform.EffektnachlinksMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    for i:=0 to length(active)-1 do
      if active[i+1] then
        if Button=mbLeft then
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition-(100/1000)
        else
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition-(10/1000);
        if Button=mbLeft then
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition-(100/1000)
        else
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition-(10/1000);
  //	audioeffekttimerTimer(Sender);
//    layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.EffektnachrechtsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if _audioeffektlayer>0 then
  begin
    for i:=0 to length(active)-1 do
      if active[i+1] then
        if Button=mbLeft then
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition+(100/1000)
        else
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition+(10/1000);
        if Button=mbLeft then
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition+(100/1000)
        else
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition+(10/1000);
  //	audioeffekttimerTimer(Sender);
//    layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.RecordAudioeffekt(fadetime: Integer); // Geräteszene aufnehmen
var
  i,j,k,l:integer;
  vorhanden:integer;
begin
  recordeffect:=true;

  if ((RecordModus1.Checked) and (_audioeffektlayer>0)) then
	begin
	  j:=maxaudioeffekte[_audioeffektlayer]-1;
	  // Effektarrays um 1 erhöhen
	  setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
	  setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
	  maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
	 	j:=j+1;

    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].fadetime:=fadetime;
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition := BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

    // Geräteszene generieren
    for i:=0 to length(mainform.devices)-1 do
    begin
      for l:=0 to mainform.devices[i].MaxChan-1 do
      begin
        if mainform.recordchannelvalue[(mainform.devices[i].Startaddress+l)]>-1 then
        begin
          // Gerät besitzt Kanal, welcher aufgenommen werden soll
          // Testen, ob Gerät nicht schon vorhanden
          vorhanden:=-1;
          for k:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices)-1 do
          begin
            if IsEqualGUID(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[k].ID,mainform.devices[i].ID) then
            begin
              vorhanden:=k;
              break;
            end;
          end;
          if vorhanden=-1 then
          begin
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[l].Devices)+1);
            vorhanden:=length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices)-1;
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanActive,mainform.devices[i].MaxChan);
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanValue,mainform.devices[i].MaxChan);
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanActiveRandom,mainform.devices[i].MaxChan);
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanValueRandom,mainform.devices[i].MaxChan);
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanDelay,mainform.devices[i].MaxChan);
            setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanFadetime,mainform.devices[i].MaxChan);
          end;
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ID:=mainform.devices[i].ID;
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanActive[l]:=true;
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanValue[l]:=255-mainform.recordchannelvalue[(mainform.devices[i].Startaddress+l)];
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanActiveRandom[l]:=false;
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanValueRandom[l]:=false;
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanDelay[l]:=0;
          mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].Devices[vorhanden].ChanFadetime[l]:=-1;
        end;
      end;
    end;

    for k:=1 to mainform.lastchan do
      mainform.recordchannelvalue[k]:=-1;

{
    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxchange(nil);

    if effektliste.RowCount = 2 then
      check_audioeffektbuttons();
}
  end;

  recordeffect:=false;
end;

procedure Taudioeffektplayerform.RecordAudioeffekt(ID: TGUID; StopScene:boolean); // ID-Szene
var
  j:integer;
begin
  recordeffect:=true;

  if ((RecordModus1.Checked) and (_audioeffektlayer>0)) then
  begin
		j:=maxaudioeffekte[_audioeffektlayer]-1;

		// Effektarrays um 1 erhöhen
		setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
		setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
		maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
		j:=j+1;

    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition := BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].ID:=ID;
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].UseIDScene:=true;
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].StopScene:=StopScene;

    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxchange(nil);
    if effektliste.RowCount = 2 then
      check_audioeffektbuttons();
  end;

  recordeffect:=false;
end;

procedure Taudioeffektplayerform.RecordAudioeffekt(ID: TGUID; StopScene:boolean; Layer: integer; IgnoreRecordMode: boolean);
var
  j:integer;
begin
  recordeffect:=true;

  if (((not IgnoreRecordMode) and RecordModus1.Checked)) or IgnoreRecordMode then
  begin
		j:=maxaudioeffekte[Layer]-1;

		// Effektarrays um 1 erhöhen
		setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt,length(mainform.Effektaudiodatei_record.layer[Layer].effekt)+1);
		setlength(_effektaudioeffektpassed[Layer],length(_effektaudioeffektpassed[Layer])+1);
		maxaudioeffekte[Layer]:=maxaudioeffekte[Layer]+1;
		j:=j+1;

    mainform.Effektaudiodatei_record.layer[Layer].effekt[j].audioeffektposition := BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

    mainform.Effektaudiodatei_record.layer[Layer].effekt[j].ID:=ID;
    mainform.Effektaudiodatei_record.layer[Layer].effekt[j].UseIDScene:=true;
    mainform.Effektaudiodatei_record.layer[Layer].effekt[j].StopScene:=StopScene;

    if length(mainform.Effektaudiodatei_record.layer[Layer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[Layer].effekt),High(mainform.Effektaudiodatei_record.layer[Layer].effekt), Layer);
    layerboxchange(nil);
    if effektliste.RowCount = 2 then
      check_audioeffektbuttons();
  end;

  recordeffect:=false;
end;

procedure Taudioeffektplayerform.FormShow(Sender: TObject);
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
  			LReg.WriteBool('Showing Audioeffektplayer',true);

        if not LReg.KeyExists('Audioeffektplayer') then
	        LReg.CreateKey('Audioeffektplayer');
	      if LReg.OpenKey('Audioeffektplayer',true) then
	      begin
            if LReg.ValueExists('Width') then
              Audioeffektplayerform.ClientWidth:=LReg.ReadInteger('Width')
            else
              Audioeffektplayerform.ClientWidth:=1016;
            if LReg.ValueExists('Height') then
              Audioeffektplayerform.ClientHeight:=LReg.ReadInteger('Height')
            else
              Audioeffektplayerform.ClientHeight:=562;

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+Audioeffektplayerform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              Audioeffektplayerform.Left:=LReg.ReadInteger('PosX')
            else
              Audioeffektplayerform.Left:=0;
          end else
            Audioeffektplayerform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')+Audioeffektplayerform.Height<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              Audioeffektplayerform.Top:=LReg.ReadInteger('PosY')
            else
              Audioeffektplayerform.Top:=0;
          end else
            Audioeffektplayerform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  if wavedarstellung.ItemIndex<0 then
    wavedarstellung.ItemIndex:=0;

  Effektliste.DoubleBuffered:=true;
  audioeffekttimer.Enabled:=true;
end;

procedure Taudioeffektplayerform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  mainform._KillAudioeffektVisualizer:=true;
  audioeffekttimer.Enabled:=false;

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
					LReg.WriteBool('Showing Audioeffektplayer',false);
	      end;
	    end;
	  end;
	  LReg.CloseKey;
    LReg.Free;
	end;
  mainform.SaveWindowPositions('audioeffektplayer');
end;

procedure Taudioeffektplayerform.EffektlisteDblClick(Sender: TObject);
var
  position:single;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if  _audioeffektlayer>0 then
  begin
    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>0 then
    begin
      position:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition;
      BASS_ChannelSetPosition(_chan[0],BASS_ChannelSeconds2Bytes(_chan[0],position), BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[1],BASS_ChannelSeconds2Bytes(_chan[1],position), BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[2],BASS_ChannelSeconds2Bytes(_chan[2],position), BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[3],BASS_ChannelSeconds2Bytes(_chan[3],position), BASS_POS_BYTE);
      LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
      audioeffektscrollbar.Position:=BASS_ChannelSeconds2Bytes(_chan[0],position) div abs(_scrollbpp);

      PlayEffectScene(_audioeffektlayer, effektliste.Selection.Top-1, false);
    end;
  end else
  begin
    layerbox.ItemIndex:=effektliste.Selection.Top;
    layerboxChange(nil);
  end;
end;

procedure Taudioeffektplayerform.EffektlisteKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if Mausklickssperren1.Checked then exit;

  case Key of
    vk_delete:if DeleteEffekt.Enabled then DeleteEffekt.Click;
    vk_return:if (EditEffekt.Enabled) and (Shift=[ssAlt]) then EditEffekt.Click;
    vk_space: if PlayEffektaudio.Enabled then PlayEffektaudio.Click else if PauseEffektaudio.Enabled then PauseEffektaudio.Click;
    190: if StopEffektaudio.Enabled then StopEffektaudio.Click;
    vk_home:
    begin
      BASS_ChannelSetPosition(_chan[0],0, BASS_POS_BYTE);
      for j:=1 to maxaudioeffektlayers do
        for i:=0 to maxaudioeffekte[j]-1 do
        begin
          _effektaudioeffektpassed[j][i]:=false;
          if mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene then
            mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID);
        end;
    end;
    vk_end: StopEffektaudioClick(nil);
    vk_prior: BASS_ChannelSetPosition(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)-1000000, BASS_POS_BYTE);
    vk_next: BASS_ChannelSetPosition(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE)+1000000, BASS_POS_BYTE);
    vk_add: waveform_zoominClick(nil);
    vk_subtract: waveform_zoomoutClick(nil);
  end;
  LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
  effektliste.SetFocus;
end;

procedure Taudioeffektplayerform.EffektlisteMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//  if Shift=[ssLeft] then
//	  audioeffekttimerTimer(sender);
end;

procedure Taudioeffektplayerform.EffektlisteDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
	AOffSet : TPoint;
	AHaken1 : TPoint;
	AHaken2 : TPoint;
	AHaken3 : TPoint;
	ARect : TRect;
begin
with Effektliste.Canvas do
begin
	if Rect.Top = 0 then
	begin
		Brush.Color := clBtnFace;
		FillRect(Rect);
		Pen.Color := clWhite;
		Rectangle(Rect);
		TextOut(Rect.Left, Rect.Top, Effektliste.Cells[ACol, ARow]);
		Exit;
	end;

  if (ARow=Effektliste.Row) then
  begin
    Brush.Color := clHighlight;
    Font.Color:=clHighlightText;
  end else
  begin
  	Brush.Color := clWhite;
    Font.Color:=clWindowText;
  end;
	FillRect(Rect);
  TextOut(Rect.Left, Rect.Top, Effektliste.Cells[ACol, ARow]);

	if (ARow>0) and (ACol = 0) then
	begin
		//Kasten zeichnen
		AOffSet.X := (Rect.Right - Rect.Left - 11) div 2;
		AOffSet.Y := (Rect.Bottom - Rect.Top - 11) div 2;

		ARect.Left := AOffSet.X + Rect.Left;
		ARect.Top := AOffSet.Y + Rect.Top;
		ARect.Right := AOffSet.X + Rect.Left + 11;
		ARect.Bottom := AOffSet.Y + Rect.Top + 11;

		Pen.Color := clGray;
		Rectangle(ARect);

    // Abfrage ob Haken zeichnen oder nicht
		if (ARow>0) then
    if active[ARow] then
		begin
			//Haken zeichnen
			AHaken1.X := ARect.Left + 2;
			AHaken1.Y := ARect.Top + 6;
			AHaken2.X := ARect.Left + 4;
			AHaken2.Y := ARect.Top + 8;
			AHaken3.X := ARect.Left + 9;
			AHaken3.Y := ARect.Top + 3;

			Pen.Color := clBlack; // Farbe des Häkchens

			MoveTo(AHaken1.X, AHaken1.Y - 0);
			LineTo(AHaken2.X, AHaken2.Y - 0);
			LineTo(AHaken3.X, AHaken3.Y - 0);

			MoveTo(AHaken1.X, AHaken1.Y - 1);
			LineTo(AHaken2.X, AHaken2.Y - 1);
			LineTo(AHaken3.X, AHaken3.Y - 1);

			MoveTo(AHaken1.X, AHaken1.Y - 2);
			LineTo(AHaken2.X, AHaken2.Y - 2);
			LineTo(AHaken3.X, AHaken3.Y - 2);
		end;
end;
TextOut(Rect.Left, Rect.Top, Effektliste.Cells[ACol, ARow]);
end;
end;

procedure Taudioeffektplayerform.EffektlisteMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if X<=15 then
  begin
    active[Effektliste.Row]:=not active[Effektliste.Row];
    layerboxChange(nil);
  end;
end;

procedure Taudioeffektplayerform.Label2Click(Sender: TObject);
begin
  layerbox.ItemIndex:=0;
  layerboxChange(nil);
end;

procedure Taudioeffektplayerform.CopyEffekt(Source, Destination,SourceLayer,DestinationLayer: integer);
var
  i,j,k,l:integer;
begin
  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].ID:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].ID;
  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Name:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Name;
  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Beschreibung:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Beschreibung;
  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].StopScene:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].StopScene;
  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].UseIDScene:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].UseIDScene;

  setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices));
  for k:=0 to length(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices)-1 do
  begin
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k];
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanActive,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanActive));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanValue,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanValue));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanActiveRandom,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanActiveRandom));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanValueRandom,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanValueRandom));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanDelay,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanDelay));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanFadetime,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanFadetime));
    for l:=0 to length(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanActive)-1 do
    begin
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanActive[l]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanActive[l];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanValue[l]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanValue[l];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanActiveRandom[l]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanActiveRandom[l];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanValueRandom[l]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanValueRandom[l];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanDelay[l]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanDelay[l];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Devices[k].ChanFadetime[l]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Devices[k].ChanFadetime[l];
    end;
  end;

  setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle));
  setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte,length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte));
  for i:=0 to length(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle)-1 do
  begin
    CreateGUID(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ID);
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].Typ:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].Typ;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].Name:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].Name;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].Beschreibung:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].Beschreibung;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].OnValue:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].OnValue;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].OffValue:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].OffValue;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].SwitchValue:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].SwitchValue;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].InvertSwitchValue:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].InvertSwitchValue;
    mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ScaleValue:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ScaleValue;

    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgInteger, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ArgInteger));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgString, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ArgString));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgGUID, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ArgGUID));
    for j:=0 to length(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgInteger)-1 do
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgInteger[j]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ArgInteger[j];
    for j:=0 to length(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgString)-1 do
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgString[j]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ArgString[j];
    for j:=0 to length(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgGUID)-1 do
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehle[i].ArgGUID[j]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehle[i].ArgGUID[j];

    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanActive, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanActive));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanValue, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanValue));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanActiveRandom, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanActiveRandom));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanValueRandom, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanValueRandom));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanDelay, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanDelay));
    setlength(mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanFadetime, length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanFadetime));
    for k:=0 to length(mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanActive)-1 do
    begin
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanActive[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanActive[k];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanValue[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanValue[k];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanActiveRAndom[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanActiveRandom[k];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanValueRandom[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanValueRandom[k];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanDelay[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanDelay[k];
      mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].Befehlswerte[i].ChanFadetime[k]:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].Befehlswerte[i].ChanFadetime[k];
    end;
  end;

  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].fadetime:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].fadetime;
  mainform.Effektaudiodatei_record.layer[DestinationLayer].effekt[Destination].audioeffektposition:=mainform.Effektaudiodatei_record.layer[SourceLayer].effekt[Source].audioeffektposition;
end;

procedure Taudioeffektplayerform.EffektSort(iLo, iHi, Layer: Integer);
var
  Lo, Hi: Integer;
  Pivot:Single;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := mainform.Effektaudiodatei_record.layer[Layer].effekt[(Lo + Hi) div 2].audioeffektposition;
  repeat
    while mainform.Effektaudiodatei_record.layer[Layer].effekt[Lo].audioeffektposition < Pivot do Inc(Lo) ;
    while mainform.Effektaudiodatei_record.layer[Layer].effekt[Hi].audioeffektposition > Pivot do Dec(Hi) ;
    if Lo <= Hi then
    begin

      // in folgenden drei Zeilen Arrayinhalte kopieren
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt,length(mainform.Effektaudiodatei_record.layer[Layer].effekt)+1);
      CopyEffekt(Lo,length(mainform.Effektaudiodatei_record.layer[Layer].effekt)-1,Layer,Layer);
//      T := A[Lo];
      CopyEffekt(Hi,Lo,Layer,Layer);
//      A[Hi] := T;
      CopyEffekt(length(mainform.Effektaudiodatei_record.layer[Layer].effekt)-1,Hi,Layer,Layer);
      setlength(mainform.Effektaudiodatei_record.layer[Layer].effekt,length(mainform.Effektaudiodatei_record.layer[Layer].effekt)-1);
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then EffektSort(iLo, Hi, Layer);
  if Lo < iHi then EffektSort(Lo, iHi, Layer);
end;

procedure Taudioeffektplayerform.seteffecttoactualpositionbtnClick(Sender: TObject);
var
  i,effecttomove:integer;
  foundnexteffect:boolean;
begin
  if not mainform.UserAccessGranted(1) then exit;

  effecttomove:=-1;
  foundnexteffect:=false;
  for i:=0 to length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1 do
  begin
    if (mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[i].audioeffektposition>BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE))) and (foundnexteffect=false) then
    begin
      foundnexteffect:=true;
      effecttomove:=i;
    end;
  end;

  if foundnexteffect then
  begin
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effecttomove].audioeffektposition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
//    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
//      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt));
    layerboxchange(nil);
  end;
end;

procedure Taudioeffektplayerform.Neu1Click(Sender: TObject);
var
  j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

// Audioeffektplayer zurücksetzen
  timerenabled:=false;
  BASS_ChannelStop(_chan[0]);
  BASS_ChannelStop(_chan[1]);
  BASS_ChannelStop(_chan[2]);
  BASS_ChannelStop(_chan[3]);
  BASS_StreamFree(_chan[0]);
  BASS_StreamFree(_chan[1]);
  BASS_StreamFree(_chan[2]);
  BASS_StreamFree(_chan[3]);
  _chan[0]:=0;
  _chan[1]:=0;
  _chan[2]:=0;
  _chan[3]:=0;
  BASS_Free;

  // Effektliste löschen
  for j:=1 to maxaudioeffektlayers do
  begin
    layercombobox.Checked[j-1]:=true;
    activelayer[j-1]:=true;
  end;

  // gesamte Arrays auf Null setzen
  setlength(mainform.effektaudio_record,0);
  // 'Audiodatei hinzufügen...' setzen
  audioeffektfilenamebox.Clear;
  audioeffektfilenamebox.ItemIndex:=audioeffektplayerform.audioeffektfilenamebox.Items.Add(_('Audiodatei hinzufügen...'));
  Button18.Enabled:=false;
//  	button20.Enabled:=false;
  button21.Enabled:=false;
  layerbox.ItemIndex:=0;
  layerboxChange(nil);
  Check_audioeffektbuttons();
end;

procedure Taudioeffektplayerform.WavezweifarbigMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  Wavedarstellungzweifarbig1.Checked:=not Wavedarstellungzweifarbig1.Checked;
  Wavezweifarbig.Checked:=Wavedarstellungzweifarbig1.Checked;
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.LayerComboboxChange(Sender: TObject);
var
	i:integer;
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  for i:=1 to maxaudioeffektlayers do
  begin
  	activelayer[i-1]:=layercombobox.Checked[i-1];
  end;

//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift=[ssCtrl]) and (key=75) and (_audioeffektlayer>0) and (effektliste.Selection.Top-1<length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)) then
  begin
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition-0.001;
    layerboxChange(nil);
//  	audioeffekttimerTimer(Sender);
  end;

  if (Shift=[ssCtrl]) and (key=76) and (_audioeffektlayer>0) and (effektliste.Selection.Top-1<length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)) then
  begin
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition+0.001;
    layerboxChange(nil);
//  	audioeffekttimerTimer(Sender);
  end;

  if (Shift=[ssShift]) and (key=75) and (_audioeffektlayer>0) and (effektliste.Selection.Top-1<length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)) then
  begin
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition-0.1;
    layerboxChange(nil);
//  	audioeffekttimerTimer(Sender);
  end;

  if (Shift=[ssShift]) and (key=76) and (_audioeffektlayer>0) and (effektliste.Selection.Top-1<length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)) then
  begin
    mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition:=mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[effektliste.Selection.Top-1].audioeffektposition+0.1;
    layerboxChange(nil);
//  	audioeffekttimerTimer(Sender);
  end;
end;

procedure Taudioeffektplayerform.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift=[ssCtrl]) or (Shift=[ssShift])) and (_audioeffektlayer>0) and ((key=75) or (key=76)) and (length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1) then
  begin
    EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxChange(nil);
//  	audioeffekttimerTimer(Sender);
  end;
end;

procedure Taudioeffektplayerform.waveformDblClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  if not timerenabled then exit;

  if (mouseoverlayer>0) and (layerbox.ItemIndex=0) then
    layerbox.ItemIndex:=mouseoverlayer
  else
    layerbox.ItemIndex:=0;
  layerboxChange(nil);
end;

procedure Taudioeffektplayerform.MSGOpen;
begin
  //
end;

procedure Taudioeffektplayerform.MSGSave;
begin
//
end;

procedure Taudioeffektplayerform.Mausklickssperren1Click(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  lockmouse.checked:=Mausklickssperren1.Checked;
end;

procedure Taudioeffektplayerform.lockmouseMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  Mausklickssperren1.Checked:=lockmouse.checked;
  nomouseimage.visible:=Mausklickssperren1.Checked;
end;

procedure Taudioeffektplayerform.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  moving:=true;
  Bass_ChannelSetPosition(_chan[0], Bass_ChannelSeconds2Bytes(_chan[0], Scrollbar1.position), BASS_POS_BYTE);
  LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
end;

procedure Taudioeffektplayerform.WavedarstellungChange(Sender: TObject);
begin
  case Wavedarstellung.itemindex of
  0:
  begin
    CheckBox9.Enabled:=true;
    Wavezweifarbig.Enabled:=true;
    ScrolltimelineCheckbox.Enabled:=true;
    audioeffekttimer.Interval:=aktualisierungsintervall;
    waveform_scrollbar.Visible:=true;
    scrollbar1.Visible:=false;
  end;
  1:
  begin
    CheckBox9.Enabled:=true;
    Wavezweifarbig.Enabled:=true;
    ScrolltimelineCheckbox.Enabled:=false;
    audioeffekttimer.Interval:=aktualisierungsintervall;
    waveform_scrollbar.Visible:=false;
    scrollbar1.Visible:=true;
  end;
  2:
  begin
    CheckBox9.Enabled:=false;
    Wavezweifarbig.Enabled:=false;
    ScrolltimelineCheckbox.Enabled:=false;
    audioeffekttimer.Interval:=aktualisierungsintervall;
    AudioeffectSpectrum.Mode:=1;
  end;
  end;
//	audioeffekttimerTimer(Sender);
end;

procedure Taudioeffektplayerform.ScrollBar1Exit(Sender: TObject);
begin
  moving:=false;
end;

procedure Taudioeffektplayerform.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if (mouse.CursorPos.X>audioeffektplayerform.Left+waveform.Left) and (mouse.CursorPos.X<audioeffektplayerform.Left+waveform.Left+waveform.Width) and (mouse.CursorPos.Y>audioeffektplayerform.Top+waveform.Top) and (mouse.CursorPos.Y<audioeffektplayerform.Top+waveform.Top+waveform.Height) and not (Mausklickssperren1.Checked) then
  begin
    moving:=true;
    Scrollbar1.Position:=Scrollbar1.Position-1;
    Bass_ChannelSetPosition(_chan[0], Bass_ChannelSeconds2Bytes(_chan[0], Scrollbar1.position), BASS_POS_BYTE);
    LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
    moving:=false;
  end;
end;

procedure Taudioeffektplayerform.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if (mouse.CursorPos.X>audioeffektplayerform.Left+waveform.Left) and (mouse.CursorPos.X<audioeffektplayerform.Left+waveform.Left+waveform.Width) and (mouse.CursorPos.Y>audioeffektplayerform.Top+waveform.Top) and (mouse.CursorPos.Y<audioeffektplayerform.Top+waveform.Top+waveform.Height) and not (Mausklickssperren1.Checked) then
  begin
    moving:=true;
    Scrollbar1.Position:=Scrollbar1.Position+1;
    Bass_ChannelSetPosition(_chan[0], Bass_ChannelSeconds2Bytes(_chan[0], Scrollbar1.position), BASS_POS_BYTE);
    LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
    moving:=false;
  end;
end;

procedure Taudioeffektplayerform.TrackBar1Change(Sender: TObject);
begin
  if Trackbar1.Position>0 then
    zoomvert:=round(Trackbar1.Position*(1/waveformscaling));
end;

procedure Taudioeffektplayerform.astenkrzel1Click(Sender: TObject);
begin
  ShowMessage(
  _('Waveform-Fenster:')+#13#10+
  _('ALT+Linksklick')+#9+_('Neuladen der Anzeige')+#13#10+
  _('SHIFT+Maus los')+#9+_('Alle ausgeführten Effekte zurücksetzen')+#13#10+
  _('Leertaste')+#9#9+_('Play/Pause')+#13#10+
  _('Pos1')+#9#9+_('Zum Anfang')+#13#10+
  _('Ende')+#9#9+_('Stop')+#13#10+
  _('Bild-Auf')+#9#9+_('Sprung nach rechts')+#13#10+
  _('Bild-Ab')+#9#9+_('Sprung nach links')
  );
end;

procedure Taudioeffektplayerform.RescanAudiofile;
begin
  Trackbar1.Height:=trunc(waveform.Height / 11 * 3);

  _scrollbpp:=BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div (waveform.Width*8);
  audioeffektscrollbar.Max:=BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _scrollbpp;

{
  _bpp := BASS_ChannelSeconds2Bytes(_chan[0], 0.02);

//    _bpp := BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div (waveform.Width);
  if (_bpp < BASS_ChannelSeconds2Bytes(_chan[0], 0.02)) then
    _bpp := BASS_ChannelSeconds2Bytes(_chan[0], 0.02);
}

  Scrollbar1.Max:=trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE)));
  TScanThread.create(_decodechan);


{
  waveform_scrollbar.Max:=waveform.Width;
  waveform_scrollbar.Enabled:=false;
  if (BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width>0 then
    waveform_scrollbar.Max:=(BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE) div _bpp)-waveform.Width;
}

  AudioeffectSpectrum.Free;
  AudioeffectSpectrum   := TSpectrum.Create(waveform.Width, waveform.Height);
  AudioeffectSpectrum.Mode         := 1;
  AudioeffectSpectrum.DrawPeak     := true;
  AudioeffectSpectrum.Width        := 5;
  AudioeffectSpectrum.Height       := waveform.Height;
  AudioeffectSpectrum.LineFallOff  := 4;
  AudioeffectSpectrum.PeakFallOff  := 1;
  AudioeffectSpectrum.Pen := clBlue;
  AudioeffectSpectrum.Peak := clWhite;
  AudioeffectSpectrum.BackColor := clBlack;
end;

procedure Taudioeffektplayerform.Waveformneuberechnen1Click(
  Sender: TObject);
begin
  RescanAudiofile;
end;

procedure Taudioeffektplayerform.Popupmenu1Click(Sender: TObject);
begin                           
  audioeffekte_popupmenu.Popup(audioeffektplayerform.Left+205,audioeffektplayerform.Top+42);
end;

procedure Taudioeffektplayerform.CopyEffektBtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
  setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
  maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;

  CopyEffekt(Effektliste.Row-1,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1,_audioeffektlayer,_audioeffektlayer);
  mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)-1].audioeffektposition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
  if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
    EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
  layerboxchange(nil);
end;

procedure Taudioeffektplayerform.AktuellesLayeraktualisieren1Click(
  Sender: TObject);
begin
  if _audioeffektlayer>0 then
  begin
    if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
      EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
    layerboxchange(nil);

    if effektliste.RowCount = 2 then
      check_audioeffektbuttons();
  end;
end;

procedure Taudioeffektplayerform.VideoscreenbtnClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

  if videoscreenform=nil then
    videoscreenform:=Tvideoscreenform.Create(videoscreenform);
  videoscreenform.show;
end;

procedure Taudioeffektplayerform.Videoseekingeinrichten1Click(
  Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  videoscreensynchronisierenform.show;
end;

function Taudioeffektplayerform.GetPositionInMilliseconds:integer;
begin
  Result:=trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE))*1000);
end;

procedure Taudioeffektplayerform.Effektstarten1Click(Sender: TObject);
var
  j:integer;
  position:single;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  position:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  if (_audioeffektlayer>0) and (audioeffektfilenamebox.Items.Count>1) then
  begin
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:=_('Effekt starten...');

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=true;

    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      Data:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

      j:=maxaudioeffekte[_audioeffektlayer]-1;

      // Effektarrays um 1 erhöhen
      setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
      setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
      maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
    	j:=j+1;

      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].fadetime:=0;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].StopScene:=false;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition := position;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].UseIDScene:=true;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].ID:=Data^.ID;

      Check_audioeffektbuttons();

      if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
        EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
      layerboxchange(nil);
    end;

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
  end;
end;

procedure Taudioeffektplayerform.Layernamenbearbeiten1Click(
  Sender: TObject);
var
  i:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  if layerbezeichnungenform.ShowModal=mrOK then
  begin
    mainform.Effektaudiodatei_record.layername[1]:=layerbezeichnungenform.LabeledEdit1.Text;
    mainform.Effektaudiodatei_record.layername[2]:=layerbezeichnungenform.LabeledEdit2.Text;
    mainform.Effektaudiodatei_record.layername[3]:=layerbezeichnungenform.LabeledEdit3.Text;
    mainform.Effektaudiodatei_record.layername[4]:=layerbezeichnungenform.LabeledEdit4.Text;
    mainform.Effektaudiodatei_record.layername[5]:=layerbezeichnungenform.LabeledEdit5.Text;
    mainform.Effektaudiodatei_record.layername[6]:=layerbezeichnungenform.LabeledEdit6.Text;
    mainform.Effektaudiodatei_record.layername[7]:=layerbezeichnungenform.LabeledEdit7.Text;
    mainform.Effektaudiodatei_record.layername[8]:=layerbezeichnungenform.LabeledEdit8.Text;
  end;
  for i:=1 to 8 do
    layerbox.Items[i]:=inttostr(i)+' ('+mainform.Effektaudiodatei_record.layername[i]+')';
end;

procedure Taudioeffektplayerform.Effektstoppen1Click(Sender: TObject);
var
  j:integer;
  position:single;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  position:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  if (_audioeffektlayer>0) and (audioeffektfilenamebox.Items.Count>1) then
  begin
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:=_('Effekt stoppen...');

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Effektmodus:=true;
    
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      Data:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

      j:=maxaudioeffekte[_audioeffektlayer]-1;

      // Effektarrays um 1 erhöhen
      setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
      setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
      maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
    	j:=j+1;

      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].StopScene:=true;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition:= position;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].UseIDScene:=true;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].ID:=Data^.ID;

      Check_audioeffektbuttons();

      if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
        EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
      layerboxchange(nil);
    end;

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
  end;
end;

procedure Taudioeffektplayerform.ObjektausBibliothekstoppen1Click(
  Sender: TObject);
var
  j:integer;
  position:single;
  Data:PTreeData;
begin
  if not mainform.UserAccessGranted(1) then exit;

  position:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));

  if (_audioeffektlayer>0) and (audioeffektfilenamebox.Items.Count>1) then
  begin
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)+1);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1]:=Tszenenverwaltungform.Create(self);
    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Caption:=_('Objekt aus Bibliothek stoppen...');

//    if szenenverwaltungform.showmodal=mrOK then
    if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].ShowModal=mrOK then
    begin
      if szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.SelectedCount=0 then exit;
      Data:=szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetNodeData(szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].VST.GetFirstSelected(false));

      j:=maxaudioeffekte[_audioeffektlayer]-1;

      // Effektarrays um 1 erhöhen
      setlength(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt,length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)+1);
      setlength(_effektaudioeffektpassed[_audioeffektlayer],length(_effektaudioeffektpassed[_audioeffektlayer])+1);
      maxaudioeffekte[_audioeffektlayer]:=maxaudioeffekte[_audioeffektlayer]+1;
    	j:=j+1;

      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].fadetime:=0;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].StopScene:=true;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].audioeffektposition := position;

      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].UseIDScene:=true;
      mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt[j].ID:=Data^.ID;

      {if effektliste.RowCount=2 then} Check_audioeffektbuttons();
//    	audioeffekttimerTimer(Sender);

      if length(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt)>1 then
        EffektSort(Low(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt),High(mainform.Effektaudiodatei_record.layer[_audioeffektlayer].effekt), _audioeffektlayer);
      layerboxchange(nil);
    end;

    szenenverwaltung_formarray[length(szenenverwaltung_formarray)-1].Free;
    setlength(szenenverwaltung_formarray,length(szenenverwaltung_formarray)-1);
  end;
end;

procedure Taudioeffektplayerform.Button18MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not mainform.UserAccessGranted(1) then exit;

  AddSzenePopup.Popup(audioeffektplayerform.Left+Panel2.Left+Button18.Left+x,audioeffektplayerform.Top+panelLighteffects.Top+Panel2.Top+Button18.Top+Button18.Height+15+y);
end;

procedure Taudioeffektplayerform.layerboxDropDown(Sender: TObject);
var
  i:integer;
begin
  layerbox.Width:=154;
  for i:=1 to 8 do
    layerbox.Items[i]:=inttostr(i)+' ('+mainform.Effektaudiodatei_record.layername[i]+')';
end;

procedure Taudioeffektplayerform.layerboxCloseUp(Sender: TObject);
begin
  layerbox.Width:=54;
end;

procedure Taudioeffektplayerform.FormDeactivate(Sender: TObject);
begin
  AlphaBlend:=mainform.blendoutforms;
  if mainform.blendoutforms then
    AlphaBlendValue:=mainform.blendvalue;
end;

procedure Taudioeffektplayerform.FormActivate(Sender: TObject);
begin
  AlphaBlend:=false;
  if mainform.blendoutforms then
    AlphaBlendValue:=255;
end;

procedure Taudioeffektplayerform.nachlaufzeit1Click(
  Sender: TObject);
var
  LReg:TRegistry;
begin
  if not mainform.UserAccessGranted(1) then exit;

  effektnachlaufzeit:=strtoint(InputBox(_('Nachlaufzeit bei Effekterkennung'),_('Bitte geben Sie eine Zeit in Millisekunden an, in der hinter der Positionsmarke nach nicht abgespielten Effekten gesucht werden soll (Standard: 100ms):'),inttostr(effektnachlaufzeit)));

  if effektnachlaufzeit<0 then
    effektnachlaufzeit:=0;

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          LReg.WriteInteger('Nachlaufzeit für Effektsuche',effektnachlaufzeit);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Taudioeffektplayerform.vorlaufzeit1Click(
  Sender: TObject);
var
  LReg:TRegistry;
begin
  if not mainform.UserAccessGranted(1) then exit;

  effektvorlaufzeit:=strtoint(InputBox(_('Vorlaufzeit bei Effekterkennung'),_('Bitte geben Sie eine Zeit in Millisekunden an, in der vor der Positionsmarke nach nicht abgespielten Effekten gesucht werden soll (Standard: 10ms):'),inttostr(effektvorlaufzeit)));

  if effektvorlaufzeit<0 then
    effektvorlaufzeit:=0;

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          LReg.WriteInteger('Vorlaufzeit für Effektsuche',effektvorlaufzeit);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Taudioeffektplayerform.Anzeigedeaktivieren1Click(
  Sender: TObject);
begin
  Anzeigedeaktivieren1.checked:=not Anzeigedeaktivieren1.Checked;

  if anzeigedeaktivieren1.Checked then
  begin
    oldaktualisierungsintervall:=aktualisierungsintervall;
    aktualisierungsintervall:=500;
    audioeffekttimer.Interval:=aktualisierungsintervall;
    timerenabled:=false;
  end else
  begin
    aktualisierungsintervall:=oldaktualisierungsintervall;
    audioeffekttimer.Interval:=aktualisierungsintervall;
    timerenabled:=true;
  end;
end;

procedure Taudioeffektplayerform.LoadAllEffectsBeforeNow;
var
  i,j:integer;
  position:Single;
  wasfreezed:boolean;
  alterkanalwert: array[1..chan] of byte;
begin
  position:=BASS_ChannelBytes2Seconds(audioeffektplayerform._chan[0],BASS_ChannelGetPosition(audioeffektplayerform._chan[0], BASS_POS_BYTE));

  for i:=1 to mainform.Lastchan do
  begin
    mainform.changedchannels[i]:=False;
    alterkanalwert[i]:=mainform.channel_value[i];
  end;

  // Ausgabe einfrieren
  wasfreezed:=mainform.IsFreezeMode;
  mainform.IsFreezeMode:=true;

  // Alle laufenden Effekte, die mit der Audioeffektdatei zu tun haben abbrechen
  for j:=1 to maxaudioeffektlayers do
	begin
    for i:=0 to maxaudioeffekte[j]-1 do
    begin
     	_effektaudioeffektpassed[j][i]:=false;
      if mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene then
        mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID);
    end;
  end;

  // alle Effekte bis zur aktuellen Position abspielen
  for j:=1 to maxaudioeffektlayers do
  begin
    if activelayer[j-1] then
    begin
     	if maxaudioeffekte[j]>0 then
      begin
        for i:=0 to maxaudioeffekte[j]-1 do
  	    begin
          if (mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition<=(position+(effektvorlaufzeit/1000))) then
		      begin
            if mainform.GetSceneInfo2(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID,'type')=_('Effekt') then
              PlayEffectScene(j, i, true);
          end;
        end;
      end;
    end;
  end;

  // alle Szenen bis zur aktuellen Position abspielen
  for j:=1 to maxaudioeffektlayers do
  begin
    if activelayer[j-1] then
    begin
     	if maxaudioeffekte[j]>0 then
      begin
        for i:=0 to maxaudioeffekte[j]-1 do
  	    begin
         	_effektaudioeffektpassed[j][i]:=false;

          if (mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition<=(position+(effektvorlaufzeit/1000))) then
		      begin
          	_effektaudioeffektpassed[j][i]:=true;

            if mainform.GetSceneInfo2(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID,'type')<>_('Effekt') then
              PlayEffectScene(j, i, true);
          end;
        end;
      end;
    end;
  end;

  // Ausgabe auftauen
  mainform.IsFreezeMode:=wasfreezed;

  // alle Kanäle ausgeben
  for i:=1 to mainform.lastchan do
  begin
    if mainform.changedchannels[i] then
    begin
      mainform.Senddata(i,255-alterkanalwert[i],255-mainform.channel_endvalue[i],effektsynchrozeit,0);
    end;
  end;
end;

procedure Taudioeffektplayerform.PlayEffectScene(Layer, Effect: integer; DontFade:boolean);
var
  i,k,l,PositionInDeviceArray,PositionInGroupArray:integer;
  pan,tilt:boolean;
  panchan,tiltchan:integer;
  ChannelFadetime, ChannelDelay, ChannelValue:integer;
begin
  if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].UseIDScene then
  begin
    // Szene aus Bibliothek abspielen
    if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].StopScene then
      mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].ID)
    else
      mainform.StartSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].ID, DontFade, DontFade, 255, -1);
  end else
  begin
    // Geräteszene abspielen
    for k:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices)-1 do
    begin
      panchan:=0;
      tiltchan:=0;
      pan:=false;
      tilt:=false;

      PositionInDeviceArray:=-1;
      PositionInGroupArray:=-1;

      for l:=0 to length(mainform.Devices)-1 do
      begin
        if IsEqualGUID(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[l].ID) then
        begin
          PositionInDeviceArray:=l;
          break;
        end;
      end;

      for l:=0 to length(mainform.devicegroups)-1 do
      begin
        if IsEqualGUID(mainform.devicegroups[l].ID,mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID) then
        begin
          PositionInGroupArray:=l;
          break;
        end;
      end;

      if PositionInDeviceArray>-1 then
      begin
        for l:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive)-1 do
        begin
          if (lowercase(mainform.devices[PositionInDeviceArray].kanaltyp[l])='pan') and (mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive[l]) then
          begin
            pan:=true;
            panchan:=k;
          end;
          if (lowercase(mainform.devices[PositionInDeviceArray].kanaltyp[l])='tilt') and (mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive[l]) then
          begin
            tilt:=true;
            tiltchan:=k;
          end;
        end;

        for l:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive)-1 do
        begin
          if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive[l] then
          begin
            if pan and tilt then
            begin
              mainform.devices[PositionInDeviceArray].PanStartvalue:=geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,'pan');
              mainform.devices[PositionInDeviceArray].PanEndvalue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[panchan];
              mainform.devices[PositionInDeviceArray].TiltStartvalue:=geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,'tilt');
              mainform.devices[PositionInDeviceArray].TiltEndvalue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[tiltchan];

              if DontFade then
              begin
                ChannelFadetime:=0;
                ChannelDelay:=0;
              end else
              begin
                if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]=-1 then
                begin
                  ChannelFadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;
                end else if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]<-1 then
                begin
                  ChannelFadetime:=Random(abs(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]));
                end else
                begin
                  ChannelFadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l];
                end;

                if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]=-1 then
                begin
                  ChannelDelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end else if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]<-1 then
                begin
                  ChannelDelay:=Random(abs(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]));
                end else
                begin
                  ChannelDelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end;
              end;

              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValueRandom[l] then
                ChannelValue:=Random(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l]+1)
              else
                ChannelValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l];

              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActiveRandom[l] then
              begin
                if ((Random(1025) mod 2)=0) then
                  geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),ChannelValue,ChannelFadetime,ChannelDelay)
              end else
                geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),ChannelValue,ChannelFadetime,ChannelDelay);
{
              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]=-1 then
              begin
                if DontFade then
                begin
                  tempfade:=0;
                  tempdelay:=0;
                end else
                begin
                  tempfade:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;
                  tempdelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end;

                geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l],tempfade,tempdelay);
              end else
              begin
                if DontFade then
                begin
                  tempfade:=0;
                  tempdelay:=0;
                end else
                begin
                  tempfade:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l];
                  tempdelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end;

                geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l],tempfade,tempdelay);
              end;
}
            end else
            begin
              if DontFade then
              begin
                ChannelFadetime:=0;
                ChannelDelay:=0;
              end else
              begin
                if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]=-1 then
                begin
                  ChannelFadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;
                end else if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]<-1 then
                begin
                  ChannelFadetime:=Random(abs(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]));
                end else
                begin
                  ChannelFadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l];
                end;

                if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]=-1 then
                begin
                  ChannelDelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end else if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]<-1 then
                begin
                  ChannelDelay:=Random(abs(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]));
                end else
                begin
                  ChannelDelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end;
              end;

              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValueRandom[l] then
                ChannelValue:=Random(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l]+1)
              else
                ChannelValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l];

              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActiveRandom[l] then
              begin
                if ((Random(1025) mod 2)=0) then
                  geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),ChannelValue,ChannelFadetime,ChannelDelay)
              end else
                geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),ChannelValue,ChannelFadetime,ChannelDelay);
{
              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]=-1 then
              begin
                if DontFade then
                begin
                  tempfade:=0;
                  tempdelay:=0;
                end else
                begin
                  tempfade:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;
                  tempdelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end;

                geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l],tempfade,tempdelay);
              end else
              begin
                if DontFade then
                begin
                  tempfade:=0;
                  tempdelay:=0;
                end else
                begin
                  tempfade:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l];
                  tempdelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
                end;

                geraetesteuerung.set_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l],geraetesteuerung.get_channel(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ID,mainform.devices[PositionInDeviceArray].kanaltyp[l]),mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l],tempfade,tempdelay);
              end;
}
            end;
          end;
        end;
      end else if PositionInGroupArray>-1 then
      begin
        for l:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive)-1 do
        begin
          if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActive[l] then
          begin
            if DontFade then
            begin
              ChannelFadetime:=0;
              ChannelDelay:=0;
            end else
            begin
              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]=-1 then
              begin
                ChannelFadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;
              end else if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]<-1 then
              begin
                ChannelFadetime:=Random(abs(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]));
              end else
              begin
                ChannelFadetime:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l];
              end;

              if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]=-1 then
              begin
                ChannelDelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
              end else if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]<-1 then
              begin
                ChannelDelay:=Random(abs(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l]));
              end else
              begin
                ChannelDelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
              end;
            end;

            if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValueRandom[l] then
              ChannelValue:=Random(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l]+1)
            else
              ChannelValue:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l];

            if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanActiveRandom[l] then
            begin
              if ((Random(1025) mod 2)=0) then
                geraetesteuerung.set_group(mainform.devicegroups[PositionInGroupArray].ID,mainform.DeviceChannelNames[l],-1,ChannelValue,ChannelFadetime,ChannelDelay)
            end else
              geraetesteuerung.set_group(mainform.devicegroups[PositionInGroupArray].ID,mainform.DeviceChannelNames[l],-1,ChannelValue,ChannelFadetime,ChannelDelay);
{
            if (mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l]=-1) then
            begin
              if DontFade then
              begin
                tempfade:=0;
                tempdelay:=0;
              end else
              begin
                tempfade:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].fadetime;
                tempdelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
              end;

              geraetesteuerung.set_group(mainform.devicegroups[PositionInGroupArray].ID,mainform.DeviceChannelNames[l],-1,mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l],tempfade,tempdelay);
            end else
            begin
              if DontFade then
              begin
                tempfade:=0;
                tempdelay:=0;
              end else
              begin
                tempfade:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanFadetime[l];
                tempdelay:=mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanDelay[l];
              end;

              geraetesteuerung.set_group(mainform.devicegroups[PositionInGroupArray].ID,mainform.DeviceChannelNames[l],-1,mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Devices[k].ChanValue[l],tempfade,tempdelay);
            end;
}
          end;
        end;
      end;
    end;

    // Szenenbefehle starten
    for i:=0 to length(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle)-1 do
    if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanActive[0] then
    begin
      if mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanFadetime[0]=-1 then
        mainform.StartDeviceSceneBefehl(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ID, mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Typ, mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValue[0], mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Fadetime, mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanDelay[0])
      else
        mainform.StartDeviceSceneBefehl(mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].ID, mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehle[i].Typ, mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanValue[0], mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanFadetime[0], mainform.Effektaudiodatei_record.layer[Layer].effekt[Effect].Befehlswerte[i].ChanDelay[0]);
    end;
  end;
end;

procedure Taudioeffektplayerform.EinblendzeitbeiEffektsynchronisation1Click(
  Sender: TObject);
var
  LReg:TRegistry;
begin
  if not mainform.UserAccessGranted(1) then exit;

  effektsynchrozeit:=strtoint(InputBox(_('Einblendzeit bei Effektsynchronisation'),_('Bitte geben Sie eine Zeit für das Einblenden beim Effektsynchronisieren in Millisekunden an (Standard: 1000ms):'),inttostr(effektsynchrozeit)));

  if effektsynchrozeit<0 then
    effektsynchrozeit:=0;

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          LReg.WriteInteger('Einblendzeit für Effektsynchronisation',effektsynchrozeit);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Taudioeffektplayerform.CopyAudioeffektfile(Source, Destination:integer);
var
  i,j,k,l:integer;
begin
  mainform.effektaudio_record[Destination].audiodatei:=mainform.effektaudio_record[Source].audiodatei;
  mainform.effektaudio_record[Destination].audiopfad:=mainform.effektaudio_record[Source].audiopfad;
  mainform.effektaudio_record[Destination].effektaudiodatei.layeranzahl:=mainform.effektaudio_record[Source].effektaudiodatei.layeranzahl;

  for i:=1 to maxaudioeffektlayers do
  begin
    setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt));
    for j:=0 to length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt)-1 do
    begin
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].ID:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].ID;
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Name:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Name;
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Beschreibung:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Beschreibung;
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].StopScene:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].StopScene;
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].audioeffektposition:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].audioeffektposition;
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].UseIDScene:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].UseIDScene;
      mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].fadetime:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].fadetime;

      setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices));
      for k:=0 to length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices)-1 do
      begin
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ID:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ID;

        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActive,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActive));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValue,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValue));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActiveRandom,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActiveRandom));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValueRandom,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValueRandom));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanDelay,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanDelay));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanFadetime,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanFadetime));

        for l:=0 to length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActive)-1 do
        begin
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActive[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActive[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValue[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValue[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActiveRandom[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanActiveRandom[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValueRandom[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanValueRandom[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanDelay[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanDelay[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanFadetime[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Devices[k].ChanFadetime[l];
        end;
      end;

      setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle));
      setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte,length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte));
      for k:=0 to length(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle)-1 do
      begin
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ID:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ID;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].Typ:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].Typ;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].Name:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].Name;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].Beschreibung:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].Beschreibung;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].OnValue:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].OnValue;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].OffValue:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].OffValue;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].SwitchValue:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].SwitchValue;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].InvertSwitchValue:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].InvertSwitchValue;
        mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ScaleValue:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ScaleValue;

        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgInteger, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgInteger));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgString, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgString));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgGUID, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgGUID));
        for l:=0 to length(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgInteger)-1 do
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgInteger[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgInteger[l];
        for l:=0 to length(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgString)-1 do
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgString[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgString[l];
        for l:=0 to length(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgGUID)-1 do
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgGUID[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehle[k].ArgGUID[l];

        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActive, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActive));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValue, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValue));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActiveRandom, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActiveRandom));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValueRandom, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValueRandom));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanDelay, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanDelay));
        setlength(mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanFadetime, length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanFadetime));
        for l:=0 to length(mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActive)-1 do
        begin
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActive[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActive[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValue[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValue[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActiveRAndom[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanActiveRandom[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValueRandom[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanValueRandom[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanDelay[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanDelay[l];
          mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanFadetime[l]:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].effekt[j].Befehlswerte[k].ChanFadetime[l];
        end;
      end;
    end;
    mainform.effektaudio_record[Destination].effektaudiodatei.layer[i].layeractive:=mainform.effektaudio_record[Source].effektaudiodatei.layer[i].layeractive;
    mainform.effektaudio_record[Destination].effektaudiodatei.layername[i]:=mainform.effektaudio_record[Source].effektaudiodatei.layername[i];
  end;

  mainform.effektaudio_record[Destination].effektaudiodatei.repeatjump:=mainform.effektaudio_record[Source].effektaudiodatei.repeatjump;
  mainform.effektaudio_record[Destination].effektaudiodatei.repeatdestination:=mainform.effektaudio_record[Source].effektaudiodatei.repeatdestination;
  mainform.effektaudio_record[Destination].effektaudiodatei.repeatactive:=mainform.effektaudio_record[Source].effektaudiodatei.repeatactive;
  mainform.effektaudio_record[Destination].effektaudiodatei.volume:=mainform.effektaudio_record[Source].effektaudiodatei.volume;

  for i:=1 to 4 do
  begin
    mainform.effektaudio_record[Destination].effektaudiodatei.videoseeking[i].enabled:=mainform.effektaudio_record[Source].effektaudiodatei.videoseeking[i].enabled;
    mainform.effektaudio_record[Destination].effektaudiodatei.videoseeking[i].starttime:=mainform.effektaudio_record[Source].effektaudiodatei.videoseeking[i].starttime;
    mainform.effektaudio_record[Destination].effektaudiodatei.videoseeking[i].endtime:=mainform.effektaudio_record[Source].effektaudiodatei.videoseeking[i].endtime;
  end;

  mainform.effektaudio_record[Destination].waveform._wavebufL:=mainform.effektaudio_record[Source].waveform._wavebufL;
  mainform.effektaudio_record[Destination].waveform._wavebufR:=mainform.effektaudio_record[Source].waveform._wavebufR;
  mainform.effektaudio_record[Destination].waveform.fadervalues:=mainform.effektaudio_record[Source].waveform.fadervalues;
  mainform.effektaudio_record[Destination].waveform.equalizer:=mainform.effektaudio_record[Source].waveform.equalizer;
  mainform.effektaudio_record[Destination].waveform.effekte:=mainform.effektaudio_record[Source].waveform.effekte;
end;

procedure Taudioeffektplayerform.movefileupClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if audioeffektfilenamebox.itemindex>0 then
  begin
    audioeffektfilenameboxDropDown(nil);
    
    setlength(mainform.effektaudio_record,length(mainform.effektaudio_record)+1);

    // aktuelle ans Ende
    CopyAudioeffektfile(audioeffektfilenamebox.ItemIndex,length(mainform.effektaudio_record)-1);
    // obere auf aktuelle
    CopyAudioeffektfile(audioeffektfilenamebox.ItemIndex-1,audioeffektfilenamebox.ItemIndex);
    // ende auf obere
    CopyAudioeffektfile(length(mainform.effektaudio_record)-1,audioeffektfilenamebox.ItemIndex-1);

    setlength(mainform.effektaudio_record,length(mainform.effektaudio_record)-1);

    audioeffektfilenamebox.itemindex:=audioeffektfilenamebox.ItemIndex-1;

    RefreshAudioeffektfilenamebox;
    Check_audioeffektbuttons;
  end;
end;

procedure Taudioeffektplayerform.movefiledownClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(1) then exit;

  if audioeffektfilenamebox.itemindex<(audioeffektfilenamebox.Items.Count-1) then
  begin
    setlength(mainform.effektaudio_record,length(mainform.effektaudio_record)+1);

    // aktuelle ans Ende
    CopyAudioeffektfile(audioeffektfilenamebox.ItemIndex,length(mainform.effektaudio_record)-1);
    // untere auf aktuelle
    CopyAudioeffektfile(audioeffektfilenamebox.ItemIndex+1,audioeffektfilenamebox.ItemIndex);
    // ende auf untere
    CopyAudioeffektfile(length(mainform.effektaudio_record)-1,audioeffektfilenamebox.ItemIndex+1);

    setlength(mainform.effektaudio_record,length(mainform.effektaudio_record)-1);

    audioeffektfilenamebox.itemindex:=audioeffektfilenamebox.itemindex+1;

    RefreshAudioeffektfilenamebox;
    Check_audioeffektbuttons;
  end;
end;

procedure Taudioeffektplayerform.RefreshAudioeffektfilenamebox;
var
  i,OldIndex:integer;
begin
  OldIndex:=audioeffektfilenamebox.itemindex;
  audioeffektfilenamebox.items.clear;

  for i:=0 to length(mainform.effektaudio_record)-1 do
    audioeffektfilenamebox.Items.Add(inttostr(i+1)+' - '+mainform.effektaudio_record[i].audiodatei);
	audioeffektfilenamebox.Items.Add(_('Audiodatei hinzufügen...'));

  audioeffektfilenamebox.itemindex:=OldIndex;
end;

procedure Taudioeffektplayerform.RunAllPreviousEffectsBtnOffClick(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2) then exit;

	RunAllPreviousEffectsBtn.Visible:=true;
  RunAllPreviousEffectsBtnOff.Visible:=false;

  synchronizing.Visible:=RunAllPreviousEffectsBtn.Visible;
end;

procedure Taudioeffektplayerform.RunAllPreviousEffectsBtnClick(Sender: TObject);
begin
	RunAllPreviousEffectsBtn.Visible:=false;
  RunAllPreviousEffectsBtnOff.Visible:=true;

  synchronizing.Visible:=RunAllPreviousEffectsBtn.Visible;
end;

procedure Taudioeffektplayerform.DecodingBPM(newStream: Boolean; startSec, endSec: DOUBLE);
begin
  BPMstart:=startSec;
  BPMstop:=endSec;

  if (newStream) then
  begin
    // Open file for bpm decoding detection
    hBPM := BASS_StreamCreateFile(FALSE, PChar(effektaudioeffektefilename), 0, 0, BASS_STREAM_DECODE);
  end;
                                                                                                                                                   
  orgBPM := BASS_FX_BPM_DecodeGet(hBPM, startSec, endSec, 0, BASS_FX_BPM_BKGRND Or BASS_FX_BPM_MULT2 Or BASS_FX_FREESOURCE, nil, @GetBPM_Process);
          //BASS_FX_BPM_DecodeGet(hBPM, startSec, endSec, 0, BASS_FX_BPM_BKGRND Or BASS_FX_BPM_MULT2 Or BASS_FX_FREESOURCE, proc: BPMPROGRESSPROC; user: Pointer): Single;

  // don't bother to update the BPM view if it's zero
  bpmview.Caption := FormatFloat('###.##', GetNewBPM(hBPM))+' BPM';
end;

function Taudioeffektplayerform.GetNewBPM(hBPM: DWORD): single;
begin
  bpmvalue:=BASS_FX_BPM_Translate(hBPM, BASS_FX_TempoGetRateRatio(_chan[0]) * 100, BASS_FX_BPM_TRAN_PERCENT2);
  if bpmvalue>300 then bpmvalue:=60;

  if beatform.Temposourcebox.ItemIndex=4 then
  begin
    beatform.UpdateBPM(bpmvalue);
  end;

  Result := bpmvalue;

  // or you could do it this way too :)
  // Result := orgBPM * BASS_FX_TempoGetRateRatio(_chan[0]);
end;

procedure Taudioeffektplayerform.bpmviewClick(Sender: TObject);
begin
  DecodingBPM(false, AktuellePosition, AktuellePosition+bpmscanlength);
end;

// BPM by period of seconds
procedure Taudioeffektplayerform.chkBPMCallbackClick(Sender: TObject);
begin
{
  if (chkBPMCallback.Checked) then
    BASS_FX_BPM_CallbackSet(_chan[0], @GetBPM_Callback, bpmrefreshperiod, 0, BASS_FX_BPM_MULT2, 0)
  else
    BASS_FX_BPM_Free(_chan[0]);
}
  CheckBPMTimer.Interval:=round(bpmrefreshperiod*1000);
  CheckBPMTimer.Enabled:=chkBPMCallback.Checked;
end;

// BPM-Position anzeigen
procedure Taudioeffektplayerform.BPMScanlnge1Click(Sender: TObject);
var
  LReg:TRegistry;
begin
  if not mainform.UserAccessGranted(1) then exit;

  bpmscanlength:=strtoint(InputBox(_('BPM-Scanlänge'),_('Bitte geben Sie eine Zeit in Sekunden an, in der vor der Positionsmarke der BPM-Wert ermittelt werden soll (Standard: 30s):'),inttostr(bpmscanlength)));

  if bpmscanlength<0 then
    bpmscanlength:=30;

  DecodingBPM(false, AktuellePosition, AktuellePosition+bpmscanlength);

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          LReg.WriteInteger('BPM-Scantime',bpmscanlength);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Taudioeffektplayerform.BPMWertneusuchen1Click(Sender: TObject);
begin
  DecodingBPM(false, AktuellePosition, AktuellePosition+bpmscanlength);
end;

procedure Taudioeffektplayerform.BPMScanzyklus1Click(Sender: TObject);
var
  LReg:TRegistry;
begin
  bpmrefreshperiod:=strtoint(InputBox(_('BPM-Scanzyklus'),_('Bitte geben Sie eine Zeit in Sekunden an, in der der BPM-Wert automatisch ermittelt werden soll (Standard: 10s):'),inttostr(round(bpmrefreshperiod))));

  if bpmrefreshperiod<0 then
    bpmrefreshperiod:=10;

  if (chkBPMCallback.Checked) then
    BASS_FX_BPM_CallbackSet(_chan[0], @GetBPM_Callback, bpmrefreshperiod, 0, BASS_FX_BPM_MULT2, nil)
  else
    BASS_FX_BPM_Free(_chan[0]);

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          LReg.WriteInteger('BPM-Scancycle',round(bpmrefreshperiod));
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Taudioeffektplayerform.FormDestroy(Sender: TObject);
begin
  BASS_FX_BPM_Free(_chan[0]);
  BASS_ChannelStop(_chan[0]);
  BASS_ChannelStop(_chan[1]);
  BASS_ChannelStop(_chan[2]);
  BASS_ChannelStop(_chan[3]);
  BASS_StreamFree(_chan[0]);
  BASS_StreamFree(_chan[1]);
  BASS_StreamFree(_chan[2]);
  BASS_StreamFree(_chan[3]);
  _chan[0]:=0;
  _chan[1]:=0;
  _chan[2]:=0;
  _chan[3]:=0;
  BASS_Free;
  _Buffer.Free;
end;

procedure Taudioeffektplayerform.CheckBPMTimerTimer(Sender: TObject);
begin
  DecodingBPM(false, AktuellePosition, AktuellePosition+bpmscanlength);
end;

procedure Taudioeffektplayerform.KompletteShowstreckenstauchen1Click(
  Sender: TObject);
var
  i,j:integer;
begin
  if not mainform.UserAccessGranted(1) then exit;

  audioeffektplayerstretchform.OldLength:=trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetLength(_chan[0], BASS_POS_BYTE))*1000);

  if (audioeffektplayerstretchform.showmodal=mrOK) then
  begin
    for i:=1 to maxaudioeffektlayers do
    begin
      for j:=length(mainform.Effektaudiodatei_record.layer[i].effekt)-1 downto 0 do
      begin
        mainform.Effektaudiodatei_record.layer[i].effekt[j].audioeffektposition:=mainform.Effektaudiodatei_record.layer[i].effekt[j].audioeffektposition*audioeffektplayerstretchform.factor;
      end;
    end;
  end;
end;

procedure Taudioeffektplayerform.GetAudioeffektTimerTimer(Sender: TObject);
var
  i,j:integer;
  position:Single;
begin
  if mainform.shutdown then
    GetAudioeffektTimer.Enabled:=false;

  if BASS_ChannelIsActive(audioeffektplayerform._chan[0]) = BASS_ACTIVE_PLAYING then
  begin
    if sendtimecodetodll.Checked then
      mainform.SendMSG(MSG_AUDIOEFFECTPLAYERTIMECODE, trunc(BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE))*1000), 0);

    position:=BASS_ChannelBytes2Seconds(audioeffektplayerform._chan[0],BASS_ChannelGetPosition(audioeffektplayerform._chan[0], BASS_POS_BYTE));
    // Auf Effekt überprüfen
    if effekteein.Checked then
    begin
      for j:=1 to maxaudioeffektlayers do
      begin
        if activelayer[j-1] then
        begin
          if maxaudioeffekte[j]>0 then
          begin
            for i:=maxaudioeffekte[j]-1 downto 0 do
            begin
              if (i<length(_effektaudioeffektpassed[j])) then
              if (_effektaudioeffektpassed[j][i]=false) then
              if (((mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition<=position+(effektvorlaufzeit/1000)) and (mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition>=position-(effektnachlaufzeit/1000)))) then
              begin
                _effektaudioeffektpassed[j][i]:=true;
                try
                  PlayEffectScene(j, i, false);
                except
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    // Auf Repeat-Sprungmarke überprüfen
    if ((Repeataktiviert.Checked) and (BASS_ChannelIsActive(_chan[0]) = BASS_ACTIVE_PLAYING) and (mainform.Effektaudiodatei_record.repeatjump<=BASS_ChannelSeconds2Bytes(_chan[0],position)) and not (BASS_ChannelSeconds2Bytes(_chan[0],position)>mainform.Effektaudiodatei_record.repeatjump+100000)) then
    begin
      for j:=1 to maxaudioeffektlayers do
      begin
        for i:=maxaudioeffekte[j]-1 downto 0 do
        begin
          if (BASS_ChannelSeconds2Bytes(_chan[0],mainform.Effektaudiodatei_record.layer[j].effekt[i].audioeffektposition)>mainform.Effektaudiodatei_record.repeatdestination) then
          begin
            _effektaudioeffektpassed[j][i]:=false;
            if mainform.Effektaudiodatei_record.layer[j].effekt[i].UseIDScene then
              mainform.StopSceneWithoutRecord(mainform.Effektaudiodatei_record.layer[j].effekt[i].ID);
          end;
        end;
      end;
        
      BASS_ChannelSetPosition(_chan[0],mainform.Effektaudiodatei_record.repeatdestination, BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[1],mainform.Effektaudiodatei_record.repeatdestination, BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[2],mainform.Effektaudiodatei_record.repeatdestination, BASS_POS_BYTE);
      BASS_ChannelSetPosition(_chan[3],mainform.Effektaudiodatei_record.repeatdestination, BASS_POS_BYTE);
      LastPosition:=BASS_ChannelBytes2Seconds(_chan[0],BASS_ChannelGetPosition(_chan[0], BASS_POS_BYTE));
    end;
  end;
end;

procedure Taudioeffektplayerform.sendtimecodetodllClick(Sender: TObject);
var
  LReg:TRegistry;
begin
  if not mainform.UserAccessGranted(1) then exit;

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
        if not LReg.KeyExists('Audioeffektplayer') then
          LReg.CreateKey('Audioeffektplayer');
        if LReg.OpenKey('Audioeffektplayer',true) then
        begin
          LReg.WriteBool('DLL-Timecode',sendtimecodetodll.Checked);
        end;
      end;
    end;
  end;

  LReg.CloseKey;
  LReg.Free;
end;

procedure Taudioeffektplayerform.TrackBar2Change(Sender: TObject);
begin
  if not mainform.UserAccessGranted(2, false) then exit;

  if _audioeffektlayer>0 then
    waveformscaling:=TrackBar2.Position/100
  else
    waveformscaling:=1;
  TrackBar1Change(nil);
end;

procedure Taudioeffektplayerform.ScrolltimelineCheckboxKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not mainform.UserAccessGranted(2) then exit;

  ScrollbarRefreshTimer.Enabled:=ScrolltimelineCheckbox.Checked;
end;

procedure Taudioeffektplayerform.ScrolltimelineCheckboxMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if not mainform.UserAccessGranted(2) then exit;

  ScrollbarRefreshTimer.Enabled:=ScrolltimelineCheckbox.Checked;
end;

procedure Taudioeffektplayerform.ScrollbarRefreshTimerTimer(
  Sender: TObject);
begin
  if (_scroll<=waveform_scrollbar.Max) and (BASS_ChannelIsActive(_chan[0]) = BASS_ACTIVE_PLAYING) then
    waveform_scrollbar.position:=_scroll;
end;

procedure Taudioeffektplayerform.waveformDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if ((Source=szenenverwaltung_formarray[0].VST) or (Source=effektsequenzer.VST)) then
  begin
    _mousedwn:=2;
    mouseovereffect:=-1;
    _dragtimeline:=false;

    waveformMouseMove(waveform, [ssLeft], X, Y);

    Accept:=true;
  end;
end;

end.
