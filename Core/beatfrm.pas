{$WARN COMPARING_SIGNED_UNSIGNED OFF}
{$WARN COMBINING_SIGNED_UNSIGNED OFF}

unit beatfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IAeverProgressBar, ComCtrls, Registry, bass,
  messagesystem, gnugettext, Mask, JvExMask, JvSpin, GR32,
  Math, SVATimer;

const
  samples_count:integer=1024;
  samples_high:integer=1023;
  bands:integer=32;//muss dann auch noch in der deklaration von BandHistory geändert werden.
  ChannelThresholdLevel=1000;//Grenze der minimalen Lautstärke, bei der ein Beat erkannt wird.

type
  THistArray= array[0..43] of Single;
  Tbeatform = class(TForm)
    beat_syncLabel: TLabel;
    audioinput: TLabel;
    audio_empfindlichkeit_micin: TTrackBar;
    vu_meter_micin: TIAeverProgressBar;
    temposlider: TTrackBar;
    record_volume: TTrackBar;
    Temposourcebox: TComboBox;
    ManualSyncButton: TButton;
    beat_syncBtn: TButton;
    beat: TPanel;
    beat_audioin_selection: TComboBox;
    soundcardselect: TComboBox;
    TrackBar1: TTrackBar;
    timelbl: TLabel;
    bpm: TJvSpinEdit;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    JvSpinEdit1: TJvSpinEdit;
    JvSpinEdit3: TJvSpinEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Shape1: TShape;
    Label6: TLabel;
    CheckBox2: TCheckBox;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    JvSpinEdit2: TJvSpinEdit;
    Label11: TLabel;
    JvSpinEdit4: TJvSpinEdit;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox4: TCheckBox;
    JvSpinEdit5: TJvSpinEdit;
    JvSpinEdit6: TJvSpinEdit;
    Label12: TLabel;
    Label13: TLabel;
    JvSpinEdit7: TJvSpinEdit;
    Label14: TLabel;
    ComboBox1: TComboBox;
    BeatTimer: TSVATimer;
    procedure TemposourceboxChange(Sender: TObject);
    procedure CreateParams(var Params:TCreateParams);override;
    procedure soundcardselectChange(Sender: TObject);
    procedure beat_audioin_selectionChange(Sender: TObject);
    procedure record_volumeChange(Sender: TObject);
    procedure beat_syncBtnClick(Sender: TObject);
    procedure ManualSyncButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure temposliderChange(Sender: TObject);
    procedure bpmChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SaveValues;

    // BeatDetection
    procedure BeatTimerTimer(Sender: TObject);
    function IsBeat:Boolean;
    procedure DoBeat;
    procedure DoAnalyse;
    function AverageBandEnergy(History:THistArray):Single;
    function AverageBandEnergy2(i:Integer):Single;
    function fBandLastValue(i:Integer):Single;
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TemposourceboxDropDown(Sender: TObject);
    procedure JvSpinEdit1Change(Sender: TObject);
    procedure JvSpinEdit3Change(Sender: TObject);
    procedure CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvSpinEdit2Change(Sender: TObject);
    procedure JvSpinEdit4Change(Sender: TObject);
    procedure CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvSpinEdit7Change(Sender: TObject);
    procedure JvSpinEdit5Change(Sender: TObject);
    procedure JvSpinEdit6Change(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    // Ende von BeatDetection
  private
    { Private-Deklarationen }
    beat_syncFirstclick:boolean;
    beat_starttime,beat_endtime: TTimeStamp;
    lastsoundcard, lastsoundsource:integer;
    _Buffer: TBitmap32;

    // BeatDetection
    Channel	: HRECORD;	// recording channel
    LastBeat:Cardinal;//GetTickCount beim letzten erkannten Beat
    BandHistory:array [0..31] of THistArray;//Alte Werte der Bänder gespeichert
    FFTAnalyse:array [0..31] of Single;//Alte Werte der Bänder gespeichert
    LastBPMs:array[0..4] of Integer;
    LastBPMCounter:Byte;
    LastBPMBeat:Int64;
    Histposition:Byte;//Aktuelle Stelle im Band History Array
    fSelectedBand:Integer;//Ausgewähltes Band
    fWaitingTime:Integer;//minimale Zeit bis zum nächsten Beat
    fDetectingFactor:Single;//Faktor um den der Ausschlag vom Durchschnitt abweichen muss.
    // Ende BeatDetection
  public
    { Public-Deklarationen }
    mylastbeat:TTimeStamp;
    TimeBetweenBeats:Cardinal;
    _BeatBuffer:array of Word;
    _BeatCounter:integer;
    procedure MSGSave;
    procedure CalculateBeatTime;
    procedure UpdateBPM(value:extended);
  end;

var
  beatform: Tbeatform;

function DuffRecording(handle : HRECORD; const Buffer : Pointer; Length : DWORD; user : Pointer) : Boolean; stdcall;

implementation

uses PCDIMMER, kontrollpanelform, audioeffektplayerfrm;

{$R *.dfm}

procedure Tbeatform.TemposourceboxChange(Sender: TObject);
var
	LReg:TRegistry;
begin
  mainform.lastbeatsource:=Temposourcebox.ItemIndex;

  BASS_RecordFree;
  BeatTimer.Enabled:=false;
  mainform.AudioIn.StopAtOnce;
  Timer1.Enabled:=false;
  ClientHeight:=244;

  checkbox1.visible:=false;
  checkbox2.visible:=false;
  JvSpinEdit1.Visible:=false;
  JvSpinEdit3.visible:=false;
  GroupBox1.visible:=false;

  case Temposourcebox.ItemIndex of
    0: // Temposlider
    begin
      temposlider.Visible:=true;
      record_volume.Visible:=false;
      beat_audioin_selection.Visible:=false;
      soundcardselect.Visible:=false;
      vu_meter_micin.Visible:=false;
      mainform.BeatInterval:=temposlider.Position;
      mainform.BeatEnabled:=true;
//      Timeline_timer.Interval:=temposlider.Position;
      audio_empfindlichkeit_micin.Visible:=false;
      beat.Color:=clblack;
      beatform.beat.Color:=clblack;
      beat_syncBtn.visible:=true;
      bpm.visible:=true;
      ManualSyncButton.Visible:=false;
      UpdateBPM(StrToFloat(bpm.text));
    end;
    1: // Soundkarte
    begin
      mainform.BeatEnabled:=false;
      temposlider.Visible:=false;
      record_volume.Visible:=true;
      beat_audioin_selection.Visible:=true;
      soundcardselect.Visible:=true;
      vu_meter_micin.Visible:=true;
      audio_empfindlichkeit_micin.Visible:=true;
      bpm.visible:=false;
      if (Not mainform.AudioIn.Start(mainform.AudioIn)) then
        ShowMessage(mainform.AudioIn.ErrorMessage)
      else
      begin
        mainform.AudioMin := 0;
        mainform.AudioMax := 0;
      end;
      soundcardselectChange(nil);
      beat_syncBtn.visible:=false;
      ManualSyncButton.Visible:=false;

      // Letzte Einstellungen aus Registry lesen
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
            if not LReg.KeyExists('Beattool') then
              LReg.CreateKey('Beattool');
            if LReg.OpenKey('Beattool',true) then
            begin
              if not LReg.ValueExists('Last Soundcard') then
                LReg.WriteInteger('Last Soundcard',0);
              lastsoundcard:=LReg.ReadInteger('Last Soundcard');

              if not LReg.ValueExists('Last Soundsource') then
                LReg.WriteInteger('Last Soundsource',0);
              lastsoundsource:=LReg.ReadInteger('Last Soundsource');
            end;
          end;
        end;
      end;
      LReg.CloseKey;
      LReg.Free;

      soundcardselect.ItemIndex:=lastsoundcard;
      soundcardselectChange(soundcardselect);
      beat_audioin_selection.ItemIndex:=lastsoundsource;
      beat_audioin_selectionChange(beat_audioin_selection);
      beatform.Timer1.Enabled:=true;
    end;
    2: // Plugin
    begin
      temposlider.Visible:=false;
      record_volume.Visible:=false;
      beat_audioin_selection.Visible:=false;
      mainform.BeatEnabled:=false;
      soundcardselect.Visible:=false;
      vu_meter_micin.Visible:=false;
      audio_empfindlichkeit_micin.Visible:=false;
      beat.Color:=clblack;
      beatform.beat.Color:=clblack;
      beat_syncBtn.visible:=false;
      bpm.visible:=false;
      ManualSyncButton.Visible:=false;
    end;
    3: // Manuell
    begin
      temposlider.Visible:=false;
      record_volume.Visible:=false;
      beat_audioin_selection.Visible:=false;
      soundcardselect.Visible:=false;
      vu_meter_micin.Visible:=false;
      audio_empfindlichkeit_micin.Visible:=false;
      beat.Color:=clblack;
      beatform.beat.Color:=clblack;
      beat_syncBtn.visible:=false;
      bpm.visible:=false;
      ManualSyncButton.Visible:=false;

      mainform.BeatEnabled:=false;
      ManualSyncButton.Visible:=true;
    end;
    4: // Audioeffektplayer
    begin
      temposlider.Visible:=false;
      record_volume.Visible:=false;
      beat_audioin_selection.Visible:=false;
      soundcardselect.Visible:=false;
      vu_meter_micin.Visible:=false;
      mainform.BeatInterval:=round((60/audioeffektplayerform.bpmvalue)*1000);
      mainform.BeatEnabled:=true;
      audio_empfindlichkeit_micin.Visible:=false;
      beat.Color:=clblack;
      beatform.beat.Color:=clblack;
      beat_syncBtn.visible:=true;
      bpm.visible:=false;
      ManualSyncButton.Visible:=true;
    end;
    5: // MidiClock
    begin
      temposlider.Visible:=true;
      record_volume.Visible:=false;
      beat_audioin_selection.Visible:=false;
      soundcardselect.Visible:=false;
      vu_meter_micin.Visible:=false;
      mainform.BeatInterval:=temposlider.Position;
      mainform.BeatEnabled:=true;
      audio_empfindlichkeit_micin.Visible:=false;
      beat.Color:=clblack;
      beatform.beat.Color:=clblack;
      beat_syncBtn.visible:=false;
      bpm.visible:=true;
      ManualSyncButton.Visible:=false;
      UpdateBPM(StrToFloat(bpm.text));
    end;
    6:
    begin
      // FFT
      checkbox1.visible:=true;
      checkbox2.visible:=true;
      JvSpinEdit1.Visible:=true;
      JvSpinEdit3.visible:=true;
      GroupBox1.visible:=true;

      temposlider.Visible:=true;
      mainform.BeatInterval:=temposlider.Position;
      mainform.BeatEnabled:=true;
      record_volume.Visible:=false;
      beat_audioin_selection.Visible:=true;
      soundcardselect.Visible:=true;
      vu_meter_micin.Visible:=false;
      audio_empfindlichkeit_micin.Visible:=false;
      bpm.visible:=true;
      ManualSyncButton.Visible:=false;
      beat_syncBtn.visible:=false;
      UpdateBPM(StrToFloat(bpm.text));
      if (Not mainform.AudioIn.Start(mainform.AudioIn)) then
        ShowMessage(mainform.AudioIn.ErrorMessage)
      else
      begin
        mainform.AudioMin := 0;
        mainform.AudioMax := 0;
      end;
      soundcardselectChange(nil);

      // Letzte Einstellungen aus Registry lesen
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
            if not LReg.KeyExists('Beattool') then
              LReg.CreateKey('Beattool');
            if LReg.OpenKey('Beattool',true) then
            begin
              if not LReg.ValueExists('Last Soundcard') then
                LReg.WriteInteger('Last Soundcard',0);
              lastsoundcard:=LReg.ReadInteger('Last Soundcard');

              if not LReg.ValueExists('Last Soundsource') then
                LReg.WriteInteger('Last Soundsource',0);
              lastsoundsource:=LReg.ReadInteger('Last Soundsource');

              if not LReg.ValueExists('FFT Responsetime') then
                LReg.WriteInteger('FFT Responsetime',0);
              JvSpinEdit3.value:=LReg.ReadInteger('FFT Responsetime');

              if not LReg.ValueExists('FFT Sensitivity') then
                LReg.WriteFloat('FFT Sensitivity',0);
              JvSpinEdit1.value:=LReg.ReadFloat('FFT Sensitivity');

              if not LReg.ValueExists('FFT Band') then
                LReg.WriteInteger('FFT Band',0);
              fSelectedBand:=LReg.ReadInteger('FFT Band');
            end;
          end;
        end;
      end;
      LReg.CloseKey;
      LReg.Free;

      soundcardselect.ItemIndex:=lastsoundcard;
      soundcardselectChange(soundcardselect);
      beat_audioin_selection.ItemIndex:=lastsoundsource;
      beat_audioin_selectionChange(beat_audioin_selection);

      BeatTimer.enabled:=true;
      Channel := BASS_RecordStart(44100, 1, 0, @DuffRecording, nil);
      beatform.Timer1.Enabled:=true;
      beatform.ClientHeight:=327;
    end;
  end;

  beat.Color:=clblack;
end;

procedure Tbeatform.soundcardselectChange(Sender: TObject);
var
	k:integer;
  dName:PChar;
  RecordDeviceInfo:BASS_DEVICEINFO;
begin
  // Aufnahmegeräte für Beat-Detection initialisieren
  soundcardselect.Hint:=_('Soundkarte: ')+soundcardselect.Items.Strings[soundcardselect.ItemIndex];
	BASS_RecordInit(soundcardselect.ItemIndex);
  mainform.AudioIn.WaveDevice:=soundcardselect.ItemIndex;
//	k := soundcardselect.ItemIndex;
  beat_audioin_selection.Clear;

	k := 0;
	dName := BASS_RecordGetInputName(k);
	while dName <> nil do
	begin
		beat_audioin_selection.Items.Add(StrPas(dName));
		// wird das Gerät derzeit verwendet?
    BASS_RecordGetDeviceInfo(k, RecordDeviceInfo);
		if (RecordDeviceInfo.flags and BASS_INPUT_ON) = 0 then
    begin
      beat_audioin_selection.ItemIndex := k;
    end;
		Inc(k);
		dName := BASS_RecordGetInputName(k);
	end;

  if lastsoundsource<beat_audioin_selection.Items.Count then
    beat_audioin_selection.ItemIndex:=lastsoundsource
  else
    beat_audioin_selection.ItemIndex:=0;
  beat_audioin_selectionChange(Self);	// Infos in Groupbox anzeigen

  // Lautstärke und -regler auf 50% setzen (um eventuell Rückkopplungen zu vermeiden)
  record_volume.Position:=50;
  BASS_RecordSetInput(beat_audioin_selection.ItemIndex, BASS_INPUT_ON, 0.5);
  beatform.soundcardselect.ItemIndex:=soundcardselect.ItemIndex;

  // Aufnahmegeräte für Beat-Detection initialisieren
  soundcardselect.Hint:=_('Soundkarte: ')+soundcardselect.Items.Strings[soundcardselect.ItemIndex];
  lastsoundcard:=soundcardselect.ItemIndex;
end;

procedure Tbeatform.beat_audioin_selectionChange(Sender: TObject);
var
	i: Integer;
  r: Boolean;
  RecordDeviceVolume:single;
begin
  mainform.debuglistbox.ItemIndex:=mainform.debuglistbox.Items.Add('['+inttostr(mainform.debuglistbox.Items.Count)+'] ['+Timetostr(now)+'] ['+Datetostr(now)+_('] AUDIO: Setting up Audio-Input...'));
  mainform.debuglistbox.Items.SaveToFile(mainform.userdirectory+'\PC_DIMMER.log');

  beat_audioin_selection.Hint:=_('Audio-Eingang: ')+beat_audioin_selection.Items.Strings[beat_audioin_selection.ItemIndex];
	// Das ausgewählte Gerät aktivieren
    r := True;
    i := 0;
    // erst alle Eingänge deaktivieren...
	while r do
  begin
    BASS_RecordGetInput(i, RecordDeviceVolume);
	  r := BASS_RecordSetInput(i, BASS_INPUT_OFF, RecordDeviceVolume);
    Inc(i);
  end;
    // ...und dann ausgewähltes wieder aktivieren.
  record_volume.Position:=50;
	BASS_RecordSetInput(beat_audioin_selection.ItemIndex, BASS_INPUT_ON, 0.5);
  lastsoundsource:=beat_audioin_selection.ItemIndex;
  SaveValues;
end;

procedure Tbeatform.record_volumeChange(Sender: TObject);
begin
	BASS_RecordSetInput(beat_audioin_selection.ItemIndex, BASS_INPUT_ON, (100-record_volume.Position)/100);
end;

procedure Tbeatform.beat_syncBtnClick(Sender: TObject);
begin
  if temposourcebox.itemindex=0 then
  begin
    if beat_syncFirstclick then
    begin
      beat_starttime:=DateTimeToTimeStamp(now);
      beat_syncbtn.Caption:=_('Stop');
      beat_syncFirstclick:=false;
    end else
    begin
      beat_endtime:=DateTimeToTimeStamp(now);
      UpdateBPM(60/((beat_endtime.Time - beat_starttime.Time)/1000));
      beat_syncbtn.Caption:=_('Beat-Sync');
      beat_syncFirstclick:=true;
    end;
  end;
end;

procedure Tbeatform.ManualSyncButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if temposourcebox.itemindex=3 then
    mainform.ExecuteBeat(nil);
end;

procedure Tbeatform.FormCreate(Sender: TObject);
var
  RecordDeviceInfo:BASS_DeviceInfo;
  dName: PChar;
  i,k:integer;
begin
  TranslateComponent(self);

  // BeatDetection
  Histposition:=0;
  fWaitingTime:=300;
  fSelectedBand:=4;
  fDetectingFactor:=2.0;
  lastbeat:=gettickcount;
  // Ende BeatDetection

  i:=0;
  while (BASS_RecordGetDeviceInfo(i,RecordDeviceInfo)) do
  begin
    beatform.soundcardselect.Items.Add(RecordDeviceInfo.name);
    i := i + 1;
    BASS_RecordGetDeviceInfo(i,RecordDeviceInfo);
  end;
  beatform.soundcardselect.ItemIndex:=0;
  beatform.soundcardselect.Text:=beatform.soundcardselect.Items.Strings[0];

  _Buffer:=TBitmap32.Create;
  _Buffer.Width:=Paintbox1.Width;
  _Buffer.Height:=Paintbox1.Height;
  setlength(_BeatBuffer, Paintbox1.Width);

  // Aufnahmegeräte für Beat-Detection initialisieren
  BASS_RecordInit(0);
  k := 0;
  dName := BASS_RecordGetInputName(k);
  beatform.beat_audioin_selection.Clear;
  while dName <> nil do
  begin
    beatform.beat_audioin_selection.Items.Add(StrPas(dName));
    // wird das Gerät derzeit verwendet?
    BASS_RecordGetDeviceInfo(k,RecordDeviceInfo);
    if (RecordDeviceInfo.flags and BASS_INPUT_ON) = 0 then
      beatform.beat_audioin_selection.ItemIndex := k;
    Inc(k);
    dName := BASS_RecordGetInputName(k);
  end;
  beatform.beat_audioin_selectionChange(Self);	// Infos in Groupbox anzeigen

  // Lautstärke und -regler auf 50% setzen (um eventuell Rückkopplungen zu vermeiden)
  beatform.record_volume.Position:=50;
  BASS_RecordSetInput(beatform.beat_audioin_selection.ItemIndex, BASS_INPUT_ON, (100-beatform.record_volume.Position)/100);

  beat_syncFirstclick:=true;
  mylastbeat:=DateTimeToTimeStamp(now);
end;

procedure Tbeatform.FormShow(Sender: TObject);
var
	LReg:TRegistry;
begin
  if Temposourcebox.itemindex=0 then
    vu_meter_micin.Visible:=false;

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
  			LReg.WriteBool('Showing Beattool',true);

        if not LReg.KeyExists('Beattool') then
	        LReg.CreateKey('Beattool');
	      if LReg.OpenKey('Beattool',true) then
	      begin
          if LReg.ValueExists('AlphaValue') then
            beatform.AlphaBlendValue:=LReg.ReadInteger('AlphaValue');

          if LReg.ValueExists('PosX') then
          begin
            if (not (LReg.ReadInteger('PosX')+beatform.Width<screen.DesktopLeft)) and (not (LReg.ReadInteger('PosX')>screen.DesktopWidth+screen.DesktopLeft)) then
              beatform.Left:=LReg.ReadInteger('PosX')
            else
              beatform.Left:=0;
          end else
            beatform.Left:=0;

          if LReg.ValueExists('PosY') then
          begin
            if (not (LReg.ReadInteger('PosY')<screen.DesktopTop)) and (not (LReg.ReadInteger('PosY')>screen.DesktopHeight+screen.DesktopTop)) then
              beatform.Top:=LReg.ReadInteger('PosY')
            else
              beatform.Top:=0;
          end else
            beatform.Top:=0;
				end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  checkbox4.Checked:=mainform.BeatImpuls.Active;
  JvSpinEdit4.value:=mainform.BeatImpuls.Channel;
  JvSpinEdit5.value:=mainform.BeatImpuls.OnValue;
  JvSpinEdit6.value:=mainform.BeatImpuls.OffValue;

  Timer1.Enabled:=true;
end;

procedure Tbeatform.TrackBar1Change(Sender: TObject);
begin
  beatform.AlphaBlendValue:=Trackbar1.Position;
end;

procedure Tbeatform.MSGSave;
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
        if not LReg.KeyExists('Beattool') then
	        LReg.CreateKey('Beattool');
	      if LReg.OpenKey('Beattool',true) then
	      begin
          LReg.WriteInteger('PosX',beatform.Left);
          LReg.WriteInteger('PosY',beatform.Top);
          LReg.WriteInteger('AlphaValue',beatform.AlphaBlendValue);
	      end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tbeatform.FormHide(Sender: TObject);
var
  LReg:TRegistry;
begin
  Timer1.enabled:=false;

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
          LReg.WriteBool('Showing Beattool',false);
        end;
      end;
    end;
    SaveValues;
	end;
end;

procedure Tbeatform.UpdateBPM(value:extended);
var
  time:integer;
  text:string;
begin
  if value=0 then value:=60.0;

  time:=round((1/(value/60))*1000);

  text:=floattostrf(value, ffGeneral , 4, 2);

	mainform.dxRibbonStatusBar1.Panels[1].Text:=inttostr(time)+'ms / '+text+' BPM';
  mainform.beatinterval:=round(time);
  bpm.value:=value;
  temposlider.position:=Round(60000-(value*100));

  kontrollpanel.temposlider.position:=Round(60000-(value*100));
	kontrollpanel.edit1.Text:=text;
  kontrollpanel.beattime_blinker.Interval:=round(time);

  mainform.SendMSG(MSG_SYSTEMSPEED,time,value);
end;

procedure Tbeatform.temposliderChange(Sender: TObject);
begin
  UpdateBPM((60000-temposlider.position)/100);
end;

procedure Tbeatform.CalculateBeatTime;
var
  CurrentBeat:TTimeStamp;
begin
  CurrentBeat:=DateTimeToTimeStamp(now);

  TimeBetweenBeats:=Currentbeat.Time-myLastbeat.Time;
  mylastbeat:=DateTimeToTimeStamp(now);

  if TimeBetweenBeats<1000 then
    timelbl.caption:=inttostr(TimeBetweenBeats)+' ms ('+FloatToStrF((60/(TimeBetweenBeats/1000)), ffFixed, 4, 2)+' BPM)'
  else
    timelbl.Caption:=FloatToStrF((TimeBetweenBeats/1000), ffFixed, 8, 2)+' s ('+FloatToStrF((60/(TimeBetweenBeats/1000)), ffFixed, 4, 2)+' BPM)';
end;

procedure Tbeatform.bpmChange(Sender: TObject);
begin
  UpdateBPM(bpm.value);
end;

procedure Tbeatform.Timer1Timer(Sender: TObject);
var
  i:integer;
  WidthOfBand:integer;
begin
  _Buffer.Canvas.Pen.Style:=psSolid;
  _Buffer.Canvas.Pen.Color:=clBlack;
  _Buffer.Canvas.Brush.Color:=clBlack;
  _Buffer.Canvas.Rectangle(0, 0, _Buffer.Width, _Buffer.Height);

  case Temposourcebox.ItemIndex of
    1:
    begin
      _Buffer.Canvas.Pen.Color:=clLime;
      for i:=length(_Beatbuffer)-2 downto 0 do
      begin
        if _Beatbuffer[i]>round(audio_empfindlichkeit_micin.position*327.68) then
        begin
          _Buffer.Canvas.Pen.Color:=clYellow;
          _Buffer.Canvas.MoveTo(i+1, _Buffer.Height-round((_Beatbuffer[i+1]/32768)*_Buffer.Height));
          _Buffer.Canvas.LineTo(i, _Buffer.Height-round((_Beatbuffer[i]/32768)*_Buffer.Height));
          _Buffer.Canvas.LineTo(i, _Buffer.Height);
          _Buffer.Canvas.Pen.Color:=clLime;
        end else
        begin
          _Buffer.Canvas.MoveTo(i+1, _Buffer.Height-round((_Beatbuffer[i+1]/32768)*_Buffer.Height));
          _Buffer.Canvas.LineTo(i, _Buffer.Height-round((_Beatbuffer[i]/32768)*_Buffer.Height));
        end;
      end;

      _Buffer.Canvas.Pen.Color:=clRed;
      _Buffer.Canvas.MoveTo(0, _Buffer.Height-round((beatform.audio_empfindlichkeit_micin.position/100)*_Buffer.Height));
      _Buffer.Canvas.LineTo(_Buffer.Width, _Buffer.Height-round((beatform.audio_empfindlichkeit_micin.position/100)*_Buffer.Height));
    end;
    6:
    begin
      WidthOfBand:=round(_Buffer.Width/(bands));
      _Buffer.Canvas.Brush.Color:=clBlue;
      _Buffer.Canvas.Brush.Style:=bsSolid;
      _Buffer.Canvas.Pen.Style:=psClear;
      _Buffer.Canvas.Pen.Color:=clYellow;
      for i:=0 to bands-1 do
      begin
        if i=fSelectedBand then
        begin
          _Buffer.Canvas.Brush.Color:=clRed;
          _Buffer.Canvas.Rectangle(i*WidthOfBand, _Buffer.Height, (i+1)*WidthOfBand, _Buffer.Height-round(FFTAnalyse[i]*_Buffer.Height));
          _Buffer.Canvas.Brush.Color:=clBlue;
        end else
        begin
          _Buffer.Canvas.Rectangle(i*WidthOfBand, _Buffer.Height, (i+1)*WidthOfBand, _Buffer.Height-round(FFTAnalyse[i]*_Buffer.Height));
        end;
        _Buffer.Canvas.Pen.Style:=psSolid;
        _Buffer.Canvas.MoveTo(i*WidthOfBand, _Buffer.Height-round(FFTAnalyse[i]*_Buffer.Height));
        _Buffer.Canvas.LineTo((i+1)*WidthOfBand, _Buffer.Height-round(FFTAnalyse[i]*_Buffer.Height));
        _Buffer.Canvas.Pen.Style:=psClear;

        if mainform.FFTDataIn[i].Active then
        begin
          if (mainform.FFTDataIn[i].Channel>0) and (mainform.FFTDataIn[i].Channel<=mainform.lastchan) then
            mainform.ExecuteDataInEvent(mainform.FFTDataIn[i].Channel, round(mainform.FFTDataIn[i].Faktor*FFTAnalyse[i]));
        end;
      end;
    end;
  end;
  BitBlt(Paintbox1.Canvas.Handle, 0, 0, _Buffer.Width, _Buffer.Height, _Buffer.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure Tbeatform.BeatTimerTimer(Sender: TObject);
var
  fft : array[0..1024] of Single;
  i : Integer;
  bound_lower,bound_upper:Integer;//untere, obere Grenze zum erstellen der Bänder
  Sum:Single;//Energie eines Bandes
begin
  //Daten abfragen(alle X-Sekunden)
  BASS_ChannelGetData(Channel, @fft, BASS_DATA_FFT1024); // get the FFT data
  
  //FFT in Bänder aufteilen
  bound_lower:=0;
  for i := 0 to bands - 1 do
  begin
    //Bandbreite bestimmen
    bound_upper:=Trunc(Power(2, i * 10.0 / (BANDS - 1)));
    if bound_upper>1023 then
      bound_upper:=1023;
    if bound_upper<=bound_lower then // mindestens 1 FFT bin verwenden
      bound_upper:=bound_lower+1;
  
    Sum:=0;
    while bound_lower<bound_upper do
    begin
      Sum:=Sum + fft[bound_lower+1];
      inc(bound_lower);
    end;
    //Amplitude speichern
    BandHistory[i,Histposition]:=sum;
    if sum>FFTAnalyse[i] then
    begin
      FFTAnalyse[i]:=sum;
    end else
    begin
      if FFTAnalyse[i]>=0.03 then
        FFTAnalyse[i]:=FFTAnalyse[i]-(0.03)
      else
        FFTAnalyse[i]:=0;
    end;
  end;
  HistPosition:=HistPosition+1;
  if HistPosition>43 then HistPosition:=0;

  if IsBeat then
    DoBeat;
  DoAnalyse;
end;

//Erkennung ob ein Beat stattfand
function Tbeatform.IsBeat:Boolean;
begin
  Result:=False;
  if LOWORD(BASS_ChannelGetLevel(Channel)) >= ChannelThresholdLevel then
  begin
    if AverageBandEnergy(BandHistory[fSelectedBand])*fDetectingFactor<BandHistory[fSelectedBand,HistPosition-1] then
    begin
      if gettickcount>(lastbeat+fWaitingTime) then
      begin
        Result:=True;
        lastbeat:=gettickcount;
      end;
    end;
  end;
end;

procedure Tbeatform.DoBeat;
var
  BeatNow,frequency:Int64;
  ZeitZwischenBeats:extended;
  i:integer;
  stable: boolean;
  MeanBPM:extended;
begin
  if (Temposourcebox.ItemIndex=6) then
  begin
    QueryPerformanceFrequency(frequency);
    if frequency>0 then
    begin
      checkbox1.Checked:=not checkbox1.Checked;

      // Zeit zwischen letztem und aktuellen Beat messen
      QueryPerformanceCounter(BeatNow);
      ZeitZwischenBeats:=((BeatNow-LastBPMBeat)/frequency);

      if ZeitZwischenBeats>0 then
      begin
        LastBPMCounter:=LastBPMCounter+1;
        if LastBPMCounter>4 then LastBPMCounter:=0;
        if (round(60/ZeitZwischenBeats)>0) and (round(60/ZeitZwischenBeats)<360) then
          LastBPMs[LastBPMCounter]:=round(60/ZeitZwischenBeats);

        for i:=0 to 4 do
        begin
          TLabel(FindComponent('Label'+inttostr(i+1))).Caption:=inttostr(LastBPMs[i]);
        end;

        // Checken, ob BPM innerhalb Toleranz stabil
        stable:=true;

        MeanBPM:=(LastBPMs[0]+LastBPMs[1]+LastBPMs[2]+LastBPMs[3]+LastBPMs[4])/5;
        Label6.Caption:=inttostr(round(MeanBPM));
        for i:=0 to 4 do
        begin
          if ((MeanBPM-10)<LastBPMs[i]) and ((MeanBPM+10)>LastBPMs[i]) then
          begin
            TLabel(FindComponent('Label'+inttostr(i+1))).Font.Color:=clGreen;
          end else
          begin
            TLabel(FindComponent('Label'+inttostr(i+1))).Font.Color:=clRed;
            stable:=false;
          end;
        end;

        Label7.visible:=stable;
        shape1.visible:=stable;
        if stable then
        begin
          MeanBPM:=(LastBPMs[0]+LastBPMs[1]+LastBPMs[2]+LastBPMs[3]+LastBPMs[4])/5;
          if CheckBox2.Checked then
            UpdateBPM(MeanBPM);
        end;
      end;
      // Neue Zeitmarke für Differenzmessung zum nächsten Tick setzen
      QueryPerformanceCounter(LastBPMBeat);
    end;
  end;
end;

procedure Tbeatform.DoAnalyse;
begin
//
end;

//Durchschnittsenergie eines Bandes berechnen
function Tbeatform.AverageBandEnergy(History:THistArray):Single;
var
  i: Integer;
begin
  Result:=0;
  for i := 0 to 44 - 1 do
  begin
    Result:=Result+History[i];
  end;
  Result:=1/44*Result;
end;

function Tbeatform.AverageBandEnergy2(i:Integer):Single;
begin
  Result:=AverageBandEnergy(BandHistory[i]);
end;

function Tbeatform.fBandLastValue(i:Integer):Single;
begin
  Result:=BandHistory[i][Histposition-1];
end;

//---------------------------------------------------------
// Recording callback für Bass-Aufnahme - not doing anything with the data
function DuffRecording(handle : HRECORD; const Buffer : Pointer; Length : DWORD; user : Pointer) : Boolean; stdcall;
begin
  Result := True;	// continue recording
end;
//---------------------------------------------------------

procedure Tbeatform.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case Temposourcebox.itemindex of
    6:
    begin
      fSelectedBand:=trunc((X/Paintbox1.Width)*bands);
      label9.caption:=inttostr(fSelectedBand+1);
      combobox1.ItemIndex:=fSelectedBand;

      if mainform.FFTDataIn[fSelectedBand].Channel=0 then
        mainform.FFTDataIn[fSelectedBand].Channel:=1;
      if mainform.FFTDataIn[fSelectedBand].Faktor=0 then
        mainform.FFTDataIn[fSelectedBand].Faktor:=255;
      Checkbox3.checked:=mainform.FFTDataIn[fSelectedBand].Active;
      JvSpinEdit2.Value:=mainform.FFTDataIn[fSelectedBand].Channel;
      JvSpinEdit4.Value:=mainform.FFTDataIn[fSelectedBand].Faktor;
    end;
  end;
end;

procedure Tbeatform.TemposourceboxDropDown(Sender: TObject);
begin
  BASS_RecordFree;
  BeatTimer.Enabled:=false;
  mainform.AudioIn.StopAtOnce;
  Timer1.Enabled:=false;
  label7.visible:=false;
  shape1.visible:=false;
  label1.caption:='...';
  label2.caption:='...';
  label3.caption:='...';
  label4.caption:='...';
  label5.caption:='...';
  label6.caption:='...';
end;

procedure Tbeatform.JvSpinEdit1Change(Sender: TObject);
begin
  fDetectingFactor:=JvSpinEdit1.value;
end;

procedure Tbeatform.JvSpinEdit3Change(Sender: TObject);
begin
  fWaitingTime:=round(JvSpinEdit3.value);
end;

procedure Tbeatform.CheckBox3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mainform.FFTDataIn[fSelectedBand].Active:=Checkbox3.Checked;
end;

procedure Tbeatform.JvSpinEdit2Change(Sender: TObject);
begin
  mainform.FFTDataIn[fSelectedBand].Channel:=round(JvSpinEdit2.Value);
end;

procedure Tbeatform.JvSpinEdit4Change(Sender: TObject);
begin
  mainform.FFTDataIn[fSelectedBand].Faktor:=JvSpinEdit4.Value;
end;

procedure Tbeatform.SaveValues;
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
        if not LReg.KeyExists('Beattool') then
          LReg.CreateKey('Beattool');
        if LReg.OpenKey('Beattool',true) then
        begin
          LReg.WriteInteger('Last Soundcard',lastsoundcard);
          LReg.WriteInteger('Last Soundsource',lastsoundsource);
          LReg.WriteInteger('FFT Responsetime',round(JvSpinEdit3.value));
          LReg.WriteFloat('FFT Sensitivity',JvSpinEdit1.value);
          LReg.WriteInteger('FFT Band',fSelectedBand);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure Tbeatform.CheckBox4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mainform.BeatImpuls.Active:=Checkbox4.Checked;
end;

procedure Tbeatform.JvSpinEdit7Change(Sender: TObject);
begin
  mainform.BeatImpuls.Channel:=round(JvSpinEdit7.value);
end;

procedure Tbeatform.JvSpinEdit5Change(Sender: TObject);
begin
  mainform.BeatImpuls.OnValue:=round(JvSpinEdit5.value);
end;

procedure Tbeatform.JvSpinEdit6Change(Sender: TObject);
begin
  mainform.BeatImpuls.OffValue:=round(JvSpinEdit6.value);
end;

procedure Tbeatform.CreateParams(var Params:TCreateParams);
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

procedure Tbeatform.ComboBox1Select(Sender: TObject);
begin
  fSelectedBand:=combobox1.ItemIndex;
  label9.caption:=inttostr(fSelectedBand+1);

  if mainform.FFTDataIn[fSelectedBand].Channel=0 then
    mainform.FFTDataIn[fSelectedBand].Channel:=1;
  if mainform.FFTDataIn[fSelectedBand].Faktor=0 then
    mainform.FFTDataIn[fSelectedBand].Faktor:=255;
  Checkbox3.checked:=mainform.FFTDataIn[fSelectedBand].Active;
  JvSpinEdit2.Value:=mainform.FFTDataIn[fSelectedBand].Channel;
  JvSpinEdit4.Value:=mainform.FFTDataIn[fSelectedBand].Faktor;
end;

end.
