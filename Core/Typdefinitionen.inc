{*********************************************************************************}
{**                                                                             **}
{** PC_DIMMER Typdefinitionen                                                   **}
{** Objektprototypen, Definitionen, etc.                                        **}
{**                                                                             **}
{*********************************************************************************}

  // Szenentypen
  TFigur = record
    ID : TGUID;
    Name : string[255];
    invertpan : boolean;
    inverttilt : boolean;
    posx : array of Word;
    posy : array of Word;
    Gesamtlaenge : Single;
  end;

  TEinfacheszene = record
    ID : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    einblendzeit : Cardinal;
    kanal : array[1..chan] of byte;
    kanalaktiv : array[1..chan] of boolean;
    Category:string[255];
  end;

  TBewegungsszenenDeviceChannel_pre425 = record
    ChanActive: boolean;
    invertx : boolean;
    inverty : boolean;
    mittelpunktx : Word;
    mittelpunkty : Word;
    scalex : Word;
    scaley : Word;
    x : boolean;
    y : boolean;
    mixXY:boolean;
    offset : Word;
  end;
  TBewegungsszenenDeviceChannel = record
    ChanActive: boolean;
    invertx : boolean;
    inverty : boolean;
    mittelpunktx : Word;
    mittelpunkty : Word;
    scalex : Word;
    scaley : Word;
    x : boolean;
    y : boolean;
    mixXY:boolean;
    offset : Word;
    delay : integer;
  end;
  TSzeneAnPosition = record
    ID:TGUID;
    Position:integer;
    Name:String[255];
  end;
  TBewegungsszenenDevice = record
    ID: TGUID;
    DeviceChannel: array of TBewegungsszenenDeviceChannel;
    Szenen: array of array of TSzeneAnPosition;
  end;
  TBewegungsszene = record
    ID : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    IsBeatControlled:boolean;
    figur : TGUID;
    dauer : Cardinal;
    DontFade : Boolean;
    repeats : Integer;
    Devices : array of TBewegungsszenenDevice;
    identischespurgeschwidigkeit : boolean;
    startpositionrelativ:boolean;
    Category:string[255];
  end;
  TBewegungsszeneAktiv = record
    Aktiv : boolean;
    Zeit : array of array of Cardinal;
    Repeats : array of array of Word;
    Position : array of array of Word;
  end;

  TAudioszeneOld = record
    ID : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    Datei : string[255];
    dauer : Cardinal;
  end;
  TAudioszene = record
    ID : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    Datei : string[255];
    Dauer : Cardinal;
    Volume:Single;
    FadeinTime:Cardinal;
    FadeoutTime:Cardinal;
    matrix1:array[0..7] of single;
    matrix2:array[0..7] of array[0..1] of single;
    matrix4:array[0..7] of array[0..3] of single;
    matrix6:array[0..7] of array[0..5] of single;
    matrix:array[0..7] of array[0..7] of single;
    Kanalsettings:array[0..7] of byte;
    Category:string[255];
  end;
  TAudioszeneCHAN = record
    StandardHandle: DWORD;
    MixerHandle: DWORD;
  end;

  TBefehl = record
    ID : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    Typ : Byte;
    Arg1 : Integer;
    Arg2 : Integer;
    Arg3 : TGUID;
  end;

  TBefehl2 = record
    ID : TGUID;
    Typ : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    OnValue : Word;
    SwitchValue : Word;
    OffValue : Word;
    InvertSwitchValue : boolean;
    ScaleValue:boolean;
    RunOnProjectLoad : boolean;
    ArgInteger : array of Integer;
    ArgString : array of string[255];
    ArgGUID : array of TGUID;
    Category:string[255];
  end;

  TBefehlssystemSteuerung = record
    Bezeichnung : string;
    GUID : TGUID;
    InputValueOnly : boolean;
    IntegerArgCount : Word;
    StringArgCount : Word;
    GUIDArgCount : Word;
    CurrentValue : Word;
  end;
  TBefehlssystem = record
    Programmteil : string;
    ProgrammteilGUID : TGUID;
    Steuerung : array of TBefehlssystemSteuerung;
  end;

  TKompositionsszene = record
    ID : TGUID;
    Name : string[255];
    Beschreibung : string[255];
    IDs : array of TGUID;
    StopScene: array of boolean;
    Category:string[255];
  end;

  // Typen für Tastencodes
  TOldTastencode = record
    active : boolean;
    Hotkey : TShortCut;
    Global : boolean;
    Typ : Word;
    Arg1 : Integer;
    Arg2 : Integer;
    Arg3 : TGUID;
  end;
  TTastencode = record
    ID : TGUID;
    active : boolean;
    Hotkey : TShortCut;
    Global : boolean;
    Repeated : boolean;
    UseKeyUp : boolean;
    KeyDownValue : Word;
    KeyUpValue : Word;

    Befehl : TBefehl2;
  end;

  TOldJoystickEvent = record
    Typ : Byte;
    UseEvent:boolean;
    Arg1 : Integer;
    Arg2 : Integer;
    Arg3 : TGUID;
    positionrelativ:boolean;
    deaktivierterbereich:Word;
    beschleunigung:Word;
    offset: Integer;
  end;
  TJoystickEvent = record
    ID : TGUID;
    Befehl:TBefehl2;

    UseEvent:boolean;
    positionrelativ:boolean;
    invert:boolean;
    deaktivierterbereich:Word;
    beschleunigung:Word;
    offset: Integer;
    PermanentUpdate:boolean;
  end;

  // Typen für Ablauftimer
  TAblaufTimer = record
               Aktiviert:boolean;
               Name:String[255];
               Beschreibung:String[255];
               Datum:String[10];
               Uhrzeit:String[8];
               TimerTyp:Byte;
               Skriptdatei:String[255];
               LoadTyp:byte;
               LoadID:TGUID;
               Weekday:array[1..7] of boolean;
              end;

  // Typen für Effekttimeline
  TTimeline = record
               Name: string[255];
               value : array of array[1..chan] of byte;
               checked : array[1..chan] of boolean;
               steps : Word;
               blendzeit:Word;
               blitzfunktion:boolean;
               blitzzeit:Word;
               pendeln:boolean;
               zufall:boolean;
              end;

  // Einstellungen für Desktop und Projektdatei
  TDesktopproperties = record
               name : string[30];
               top : array of Word;
               left : array of Word;
               height : array of Word;
               width : array of Word;
               visible : array of Boolean;
               MainTop : Word;
               MainLeft : Word;
               MainWidth : Word;
               MainHeight : Word;
              end;

  TData = record
            page : Word;
            preheatvalue:byte;
            ch : array of byte;
            Names : array of string[255];
            sdirect : array of boolean;
            manfade : array of boolean;
            combine : array of boolean;
            Shortcutnames : array[0..16] of string[20];
            openhistory : array[0..4] of string[255];
          end;
  TAct = record
            opt : array of string;
            ch_ready : array of boolean;
            start : array of TDateTime;
            wt : array of TDateTime;
          end;
  TGammaRamp = packed record
            R : array[0..255] of word;
            G : array[0..255] of word;
            B : array[0..255] of word;
          end;
  TProject = packed record
            ch : array of byte;
            Names : array of string[255];
            sdirect : array of boolean;
            page : byte;
            combine : array of boolean;
            Shortcutnames : array[0..16] of string[20];
          end;

  // Typen für MIDI-Input
  TMidiTimecode = record
    h : Byte;
    min : Byte;
    s : Byte;
    Frame : byte;
    Framemode : byte;

    MSBh, LSBh : Byte;
    MSBmin, LSBmin : Byte;
    MSBs, LSBs : Byte;
    MSBframe, LSBframe : Byte;
  end;
  TMidiEventArray = record
            ID : TGUID;
            MIDIMessage:Byte;
            MIDIData1:Byte;
            MIDIData2:Byte;

            Typ:Word;
            Wert1:integer;
            Wert2:integer;
            Arg3:TGUID;

            Befehl:TBefehl2;

            Data1orData2:byte;
            UseMidiBacktrack:boolean;
            IstWert:byte;
            IstState:boolean;

            ExternMidiValue:byte;
            ExternMidiSwitchState:boolean;
          end;
  TSendValueOfSelectedDevicesToMidi = record
            MSG:Byte;
            Data1:Byte;
            UseData2:boolean;
            LastValue:byte;
          end;

  // Typen für Data-Input
  TDataInEventArray = record
            ID : TGUID;
            Channel:Word;
            Value:Word;

            Befehl:TBefehl2;

            Typ:Word;
            Wert1:Integer;
            Wert2:Integer;
            Arg3:TGUID;
          end;

  // Typ für Nebelmaschinensteuerung
  TFogTimer = record
            duration:Cardinal;
            interval:Cardinal;
            level:byte;
            fanlevel:byte;
            levelchannel:array[1..chan] of boolean;
            fanchannel:array[1..chan] of boolean;
          end;

  // Typ für LED-Blinken an Tastatur
  TKeyType = (ktCapsLock, ktNumLock, ktScrollLock);

  // Typ für Gerätesteuerung
  TScannerCalibration = record
    Name:string[255];
    PointA,PointB,PointC,PointD:TPoint;
  end;
  TGoboCorrelation = record
    GoboName: string[255];
    Percent: single;
  end;
  TDevice = record
    ID:TGUID;
    Name:string[255];
    DeviceName:string[255];
    Beschreibung:string[255];
    Vendor:string[255];
    Bildadresse:String[255];
    Startaddress: Word;
    MaxChan: Byte;
    invertpan:boolean;
    inverttilt:boolean;

    typeofscannercalibration:byte;

    PanStartvalue:integer;
    PanFineStartvalue:integer;
    TiltStartvalue:integer;
    TiltFineStartvalue:integer;
    PanEndvalue:integer;
    PanFineEndvalue:integer;
    TiltEndvalue:integer;
    TiltFineEndvalue:integer;
    CalibrationpointA:TPoint;
    CalibrationpointB:TPoint;
    CalibrationpointC:TPoint;
    CalibrationpointD:TPoint;
    CalibrationpointAsync:TPoint;
    CalibrationpointBsync:TPoint;
    CalibrationpointCsync:TPoint;
    CalibrationpointDsync:TPoint;

    ScannerCalibrations:array[0..16] of TScannerCalibration;

    KanalMinValue:array of byte;
    KanalMaxValue:array of byte;
    kanaltyp:array of string[255];
    kanalname:array of string[255];
    kanalfade:array of boolean;
    kanaldimmcurve:array of byte;
    kanalabsolutedimmcurve:array of byte;
    autoscening:boolean;

    // Bühnenansichtdarstellung
    ShowInStageview:boolean;
    color: TColor;
    picturesize:Byte;
    pictureangle:Word;
    picturefliphor:boolean;
    pictureflipver:boolean;
    pictureispng:boolean;
    top: array of integer;
    left: array of integer;
    zaxis: array of integer;
    OldPos:array of TPoint;
    bank: array of integer;
    selected: array of boolean;

    // Erweiterte Einstellungen
    hasDimmer:boolean;
    hasShutter:boolean;
    hasVirtualRGBAWDimmer:boolean;
    hasRGB:boolean;
    hasCMY:boolean;
    hasAmber:boolean;
    hasWhite:boolean;
    hasUV:boolean;
    hasFog:boolean;
    hasPANTILT:boolean;
    hasColor:boolean;
    hasColor2:boolean;
    hasGobo:boolean;
    hasGobo2:boolean;
    colors:array of TColor;
    colorlevels:array of byte;
    colorendlevels:array of byte;
    colornames:array of string[255];
    colortolerance:byte;

    UseAmberMixing:boolean;
    AmberMixingCompensateRG:boolean;
    AmberMixingCompensateBlue:boolean;
    AmberRatioR:byte;
    AmberRatioG:byte;

    colors2:array of TColor;
    colorlevels2:array of byte;
    colorendlevels2:array of byte;
    colornames2:array of string[255];

    gobos:array of string[255];
    gobolevels:array of byte;
    goboendlevels:array of byte;
    gobonames:array of string[255];
    bestgobos:array of array of TGoboCorrelation;

    gobos2:array of string[255];
    gobolevels2:array of byte;
    goboendlevels2:array of byte;
    gobonames2:array of string[255];
    bestgobos2:array of array of TGoboCorrelation;

    ShutterOpenValue:byte;
    ShutterCloseValue:byte;
    ShutterChannel:string[255];
    StrobeOffValue:byte;
    StrobeMinValue:byte;
    StrobeMaxValue:byte;
    StrobeChannel:string[255];
    DimmerOffValue:byte;
    DimmerMaxValue:byte;
    FogOffValue:byte;
    FogMaxValue:byte;
    Gobo1RotLeftminValue:byte;
    Gobo1RotLeftValue:byte;
    Gobo1RotOffValue:byte;
    Gobo1RotRightminValue:byte;
    Gobo1RotRightValue:byte;
    Gobo1RotChannel:string[255];
    Gobo2RotLeftminValue:byte;
    Gobo2RotLeftValue:byte;
    Gobo2RotOffValue:byte;
    Gobo2RotRightminValue:byte;
    Gobo2RotRightValue:byte;
    Gobo2RotChannel:string[255];
    PrismaSingleValue:byte;
    PrismaTripleValue:byte;
    PrismaRotOffValue:byte;
    PrismaRotLeftminValue:byte;
    PrismaRotLeftmaxValue:byte;
    PrismaRotRightminValue:byte;
    PrismaRotRightmaxValue:byte;
    PrismaRotChannel:string[255];
    IrisCloseValue:byte;
    IrisOpenValue:byte;
    IrisMinValue:byte;
    IrisMaxValue:byte;

    UseChannelBasedPower:boolean;
    AlwaysOn:boolean;
    ChannelForPower:byte;
    CalcPowerAboveValue:byte;
    Power:integer;
    UseFullPowerOnChannelvalue:boolean;
    ContinuousPower:integer;
    Phase:byte;

    MatrixDeviceLevel:byte; // 0=No, 1=Main, 2=Sub-Device
    MatrixMainDeviceID:TGUID;
    MatrixOrderType:byte; // 1-6
    MatrixXCount, MatrixYCount:byte;
    MatrixXPosition, MatrixYPosition:shortint; // Ursprünglich als Byte gedacht... aber eine Matrix mit mehr als 127 wird im PC_DIMMER nie verwendet werden können
  end;

  TDevicePreset = record
    ID:TGUID;
    Name:string[255];
    Beschreibung:string[255];
    ChanTyp : array of string[255];
    ChanValue : array of byte;
    ChanActive : array of boolean;
    Category: string[255];

    UseNewInterface:boolean;
    Color:TColor;
    Shutter:byte;
    Dimmer:integer;
    Iris:integer;
    Focus:integer;
    PrismaRot:byte;
    PrismaEnabled:byte;
    Strobe:integer;
    Pan, Tilt, PanFine, TiltFine:byte;
    Gobo:string[255];
    GoboRot1:Byte;
    GoboRot2:Byte;
  end;
  TDeviceGroup = record
    Active:boolean;
    ID:TGUID;
    IDs:array of TGUID;
    IDActive:array of boolean;
    Delays:array of Cardinal;
    MasterDevice:TGUID;
    UseMaster:boolean;
    Delay:Cardinal;
    Name:string[255];
    Beschreibung:string[255];
    FanMode:Byte;
    FanMorph:Integer;
    HasChanType:array of Boolean;
  end;

  TDeviceSceneDevice = record
    ID: TGUID;
    ChanActive:array of boolean;
    ChanActiveRandom:array of boolean;
    ChanValue:array of byte;
    ChanValueRandom:array of boolean;
    ChanDelay:array of Integer;
    ChanFadetime:array of Integer;
  end;
  TDeviceScene = record
    ID:TGUID;
    Name:string[255];
    Beschreibung:string[255];
    Devices:array of TDeviceSceneDevice;
    Befehle:array of TBefehl2;
    Befehlswerte:array of TDeviceSceneDevice;
    Fadetime:Cardinal;
    Category:string[255];
  end;

  TAutoszene = record
    ID:TGUID;
    Name: string[255];
    Beschreibung: string[255];
    fadetime: Cardinal;
    R: byte;
    G: byte;
    B: byte;
    A: integer;
    W: integer;
    accuracy:byte;
    helligkeit:byte;
    Category:string[255];
  end;

  // Typen für Effektaudio
  TEffekt = record
               ID : TGUID; // ID der jeweiligen Szene - nur wenn UseIDScene=true
               Name : string[255];
               Beschreibung : string[255];
               StopScene : boolean;
               audioeffektposition : Single; //audioeffekt gibt die Position des Effektes an
               UseIDScene: boolean;  // Normale, oder Audioeffektszene?
               fadetime : Cardinal;  //fadetime gibt die Einblendzeit in ms für den aktuellen Effekt an
               Devices:array of TDeviceSceneDevice;
               Befehle: array of TBefehl2;
               Befehlswerte:array of TDeviceSceneDevice;
             end;
  TLayer = record
               effekt : array of TEffekt;
               layeractive : boolean;
             end;
  TVideoseeking = record
               enabled:boolean;
               starttime:Integer;
               endtime:Integer;
             end;
  TEffektaudiodatei = packed record
               layeranzahl:Byte;
               layer : array[1..maxaudioeffektlayers] of TLayer; // abhängig von TEFFEKT.DEVICES !!!
               layername : array[1..maxaudioeffektlayers] of String[255];
               repeatjump : Int64;
               repeatdestination : Int64;
               repeatactive:boolean;
               volume:Byte;
               videoseeking : array[1..4] of TVideoseeking;
             end;
  TWaveformdata = record
               _wavebufL : array[0..400] of QWord;
               _wavebufR : array[0..400] of QWord;
               fadervalues : array[1..8] of byte;
               equalizer : array[0..10] of 0..30;
               effekte : array[1..8] of boolean;
              end;
  TEffektaudio = packed record
               audiodatei : string[255];
               audiopfad : string[255];
               effektaudiodatei : TEffektaudiodatei; // abhängig von TLAYER.TEFFEKT.DEVICES !!!
               waveform : TWaveformdata;
              end;

  // Typen für Effekte
  TRunningEffekt = record
    Aktiv:boolean;
    PleaseStopOnNextStep:boolean;
    rueckwaerts:boolean;
    AktuellerSchritt:integer;
    Zeit:Cardinal;
    Durchlauf:Integer;
    AnzahlderSchritte:Word;
    SingleStep:boolean;
    LastScene: array of TGUID;
    AnzahlBeats:Word;
    Beatgesteuert:boolean;
    DeactivateZeitsteuerung:boolean;
  end;
  TEffektschritt = record
    IDs : array of TGUID;
    Typ:Byte; // 0=Direktszene, 1=Szenenverwaltung-ID, 2=Effekt-ID
    Name : string[255];
    Beschreibung : string[255];
    einblendzeit : Cardinal;
    wartezeit : Cardinal;
    AnzahlBeats:Word;
    ActivateTimecontrol:boolean;
    DeactivateLastScene:boolean;
    Devices:array of TDeviceSceneDevice;
    Befehle: array of TBefehl2;
    Befehlswerte:array of TDeviceSceneDevice;
  end;
  TEffektsequenzereffekt = record
    ID:TGUID;
    Name : string[255];
    Beschreibung : string[255];
    TabPosition : Word;
    Effektschritte : array of TEffektschritt;
    AnzahlderDurchlaufe : Integer;
    Repeating:boolean;
    modus : byte; // normal, rückwärts, pendeln, zufall
    intensitaet:byte;
    speed:Integer;
    startwithstepone:boolean;
    blackoutonstop:boolean;
    Stopscene:TGUID;
    Startscene:TGUID;
  end;

  // Typen für DataIn-Softpatch
  TSoftpatch = record
    Channel:Word;
    RouteToInputChan:array of Word;
  end;
  TSoftpatch2 = record
    Channel2:Word;
    RouteToPC_DIMMERChan:array of Word;
  end;

  // Typen für Bühnenansicht
  TBuehnenansichtDevice = record
    channel: Word;
    color: TColor;
    picture:string[255];
    picturesize:Byte;
    pictureangle:Word;
    picturefliphor:boolean;
    pictureflipver:boolean;
    pictureispng:boolean;
    top: integer;
    left: integer;
    bank: integer;
    OldPos:TPoint;
    selected:boolean;
  end;
  TBuehnenansicht = record
    Buehnenansicht_background:string[255];
    Buehnenansicht_width:integer;
    Buehnenansicht_height:integer;
    Buehnenansicht_panel:boolean;
  end;

  TKontrollpanelButton = record
    ID: TGUID;
    Name: string[30];
    TypName:string[30];
    Color: TColor;
    Typ: integer;
    Time: string[30];
    Shortcut: TShortCut;
    Picture: string[255];
    PNG:TPNGObject;

    Active:boolean;
    Visible:boolean;
    Enabled:boolean;
    Down:boolean;
  end;
  Tkontrollpanelrecord = record
    zeilenanzahl:integer;
    spaltenanzahl:integer;
    ID:array[0..24] of array[0..24] of TGUID;
    buttonname:array[0..24] of array[0..24] of string[30];
    buttonfarbe:array[0..24] of array[0..24] of TColor;
    buttontyp:array[0..24] of array[0..24] of byte;
    buttonshortcut:array[0..24] of array[0..24] of TShortCut;
    buttonglyph:array[0..24] of array[0..24] of String[255];
    formwidth:integer;
    formheight:integer;
    formtop:integer;
    formleft:integer;
    NoOptions:boolean;
  end;

  TLeistungsdaten = record
  	channel : array of Word;
    phase : array of byte;
    leistung : array of Word;
    deactivatechannelonoverload : array of boolean;
    ampere : array[1..10] of Word;
    usesinus:boolean;
  end;

  TDimmerKernelChannel = Record
    ChannelType:Byte; // 0=Normaler Dimmer, 1=Audiodateilautstärke, 2=Szenenbefehle
    Index:Integer;
    IndexGUID:TGUID;
    BefehlTyp:TGUID;
    Start:boolean;
    channel:Word;
    SetStartvalue:boolean;
    channel_startvalue:Word;
    channel_endvalue:Word;
    channel_fadetime:Cardinal;
    channel_delay:Cardinal;
    channel_steps:Word;
    channel_increase:Cardinal;
    CurrentValue:Word;
    DeleteChannel:Boolean;
    DontSetValues:Boolean;
    IsDelayedChan:Boolean;
    IsPanTiltChannel:Boolean;
    FineChannel:Word;
    FadeDirection:Byte;
  end;

  TSubmasterfader = record
    active:array[1..chan] of boolean;
    name:string[30];
  end;

  TDeviceChannelSelection = record
    ID: TGUID;
    ChanActive:array of boolean;
    ChanValue:array of byte;
    ChanDelay:array of Integer;
  end;
  TSubmasterbank = record
    BankName:string[255];
    Submasterdevices:array[1..16] of array of TDeviceChannelSelection;
    SubmasterName:array[1..16] of string[30];

    UseScene:array[1..16] of boolean;
    SubmasterScene:array[1..16] of TGUID;

    CurrentValue:array[1..16] of Byte;

    UseBefehl:array[1..16] of boolean;
    Befehl:array[1..16] of TBefehl2;
  end;

  Tcuelistbankitems = record
    ID:TGUID;
    OwnDescription:string[255];
    Typ:byte;
    UseFadetime:boolean;
    FadeTime:Integer;
    LiveTime:Integer;
    StopCueIfTimeOver:boolean;
  end;
  TCueListbank = record
    BankName:string[255];
    cuelistbankitems:array of Tcuelistbankitems;
  end;

  TTimeCodePlayer = record
    BankName:string[255];
    timecodeplayerbankitems:array of TGUID;
    Time:array of Cardinal;
    Frame:array of Byte;
  end;

  TIREvent = record
    ID:TGUID;
    fernbedienung:string[255];
    taste:string[255];
    taste_raw:string[255];
  end;

  TMediaCenterCommand = record
    Befehl: Word;
    Data1: Cardinal;
    Data2: Cardinal;
    Text: string[255];
  end;

  TMediaCenterScene = record
    ID:TGUID;
    Name: string[255];
    Beschreibung: string[255];
    Adresse: string[32];
    Port: integer;
    Befehl: Word;
    Data1: Cardinal;
    Data2: Cardinal;
    Text: string[255];
    Category:string[255];
  end;

  TPluginScene = record
    ID:TGUID;
    Name: string[255];
    Category:string[255];
  end;

  TFFTDataIn = record
    Active:boolean;
    Channel:Word;
    Faktor:Extended;
  end;

  TBeatImpuls = record
    Active:boolean;
    Channel:Word;
    OnValue:byte;
    OffValue:byte;
    SceneOnBeatLost:TGUID;
    SceneOnBeatStart:TGUID;
    Timeout:integer;
    SendVolumeToDataIn:boolean;
    SendVolumeToDataInChannel:Word;
  end;

  TTerminalSystem = record
    BefehlsTyp:TGUID;
    IntegerArg1, IntegerArg2:integer;
    StringArg1, StringArg2:string;
    GUID1, GUID2:TGUID;
  end;

  TPartyMuckenModul = record
    Name:string[255];
    ControlMode:byte;
    UsePanTilt:boolean;
    UseRandom:boolean;
    MaxFadetime:Word;
    MaxPanTiltTime:Word;
    MaxDelayTime:Word;
    UseRed, UseGreen, UseBlue, UseAmber, UseWhite:boolean;
    MaxRed, MaxGreen, MaxBlue, MaxAmber, MaxWhite:Byte;
    AllowMixing:boolean;
    NoBlackDevices:boolean;
    UseRGB, UseAW, UseUV, UseDimmer, UseColor12:boolean;
    MaxLuminance:Word;
    MinLuminance:Word;
  end;

  TPresetScene = record
    ID:TGUID;
    Name:string[255];
    Beschreibung:string[255];
    Category: string[255];

    Devices : array of TGUID;

    Color:TColor;
    Shutter:byte;
    Dimmer:integer;
    Iris:integer;
    Focus:integer;
    PrismaRot:byte;
    PrismaEnabled:byte;
    Strobe:integer;
    Pan, Tilt, PanFine, TiltFine:byte;
    Gobo:string[255];
    GoboRot1:Byte;
    GoboRot2:Byte;
  end;

  TCodeScene = record
    ID:TGUID;
    Name:string[255];
    Beschreibung:string[255];
    Category: string[255];
    Code: String;
    Variables:array of Variant;
  end;

  TNodeControlNode = record
    ID:TGUID;
    Name:string[255];
    X,Y,Z:Word;
    R,G,B,A,W,Dimmer:byte;
    UseRGB,UseA,UseW,UseDimmer:boolean;
  end;
  TNodeControlSet = record
    ID:TGUID;
    Name:string[255];
    stretching:integer;
    contrast:integer;
    fadetime:cardinal;
    ChangeRGB, ChangeA, ChangeW, ChangeDimmer:boolean;
    StageViewScaling:integer;
    NodeControlNodes:array of TNodeControlNode;
  end;

  TUserAccount = record
    ID:TGUID;
    Name:string[255];
    PasswordScrambled:string[255];
    Password:string[255];
    AccessLevel:integer;
  end;

  TXCtlScribblePad = record
    ScribbleNeedsUpdate:boolean;
    TopText: string[8];
    BotText: string[8];
    Color: byte; // 0=BLACK, 1=RED, 2=GREEN, 3=YELLOW, 4=BLUE, 5=PINK, 6=CYAN, 7=WHITE
    Inverted: boolean;
  end;
  // Buttons can be of type OFF, FLASHING, ON
  TXCtlChannel = record
    CorrespondingID: TGUID;
    CorrespondingChannel: integer;
    CorrespondingChannelName: string;

    ChannelNeedsUpdate:boolean;
    FaderEnabled:boolean;
    Faderposition:Word; // 0...16383
    LastFaderposition:Word; // 0...16383
    Meterlevel:byte; // 0...8
    DialLevel:byte; // 0..255 ->0..12

    Rec: byte; // 0=OFF, 1=ON, 2=FLASHING
    Solo: byte; // 0=OFF, 1=ON, 2=FLASHING
    Mute:byte; // 0=OFF, 1=ON, 2=FLASHING
    Select:byte; // 0=OFF, 1=ON, 2=FLASHING
  end;
  TXTouch = record
    IPAddress:string;
    ChannelOffset:Word;
    ScribblePad:array[0..7] of TXCtlScribblePad;
    Channel:array[0..7] of TXCtlChannel;
    FaderNeedsUpdate:boolean;
    Masterfader:Word; // 0...16383
    JogDialValue:Byte;
    SegmentDisplay:array[0..11] of char;
    ButtonLightOn:array[0..102] of Byte;
    DisplayOnlyUsedChannels:boolean;
    DisplayMode:byte; // 0=(Selected) Devices, 1=DMX-Channels, 2=Befehle
  end;
  TXTouchPCDDeviceOrGroup = record
    ID:TGUID;
    IsDevice:boolean;
    ChannelsToDisplay:Byte;
  end;

  TElgatoStreamDeckButton = record
    Pressed:boolean;
    ButtonType:byte; // 0=undefined, 1=Kontrollpanel, 2=SelectDeviceOrGroup, 3=DataIn
    KontrollpanelX, KontrollpanelY:integer;
    DeviceOrGroupID:TGUID;
    DataInChannel:Word;
    Befehl:TBefehl2;
    UseHoldToChange:boolean;
    Increment:integer;
    CurrentValue:integer;
  end;
  TElgatoStreamDeck = record
    HidDevice:TJvHidDevice;
    Online:boolean;
    Serial:string[64];
    ButtonCount:byte;
    Brightness:Byte;
    UseAutoModeOnLastButton:boolean;
    CurrentButtonMode:byte;
    Buttons:array[0..31] of TElgatoStreamDeckButton;
  end;
