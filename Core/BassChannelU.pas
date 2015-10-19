{******************************************************************************}
{                                                                              }
{ Ur-Autor: Gandalfus (Version 1.00)                                           }
{ Homepage: http://www.blubplayer.de/                                          }
{                                                                              }
{ Edit to Version 1.23 by turboPascal (Matti)                                  }
{ Edit to Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net        }
{                                                                              }
{------------------------------------------------------------------------------}
{ FX-Teil:  Copyright (c) 2003-2004 JOBnik! [Arthur Aminov, ISRAEL]            }
{                                   e-mail: bass_fx@jobnik.tk                  }
{                                                                              }
{ Edit to Version 2.1-2.4 by omata (Thorsten)                                  }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassChannelU;

interface

uses
  Windows, StdCtrls, BassDynamicU, ExtCtrls, Classes, MMSystem, SysUtils,
  BassEquiliserU, BassTypenU, BassEquiliserSpecialU, Graphics, LiedU;

type
  TBassChannel = class;
  TBassChannelUpdateTimer = procedure (BassChannel:TBassChannel) of object;
  TBassChannelToVis = procedure (
    BassChannel:TBassChannel; mustSet:boolean = false
  ) of object;

  TWaveBufferArray = array of record
    Peak:DWord;
    Posi:QWord;
  end;
  TWaveBufferUpdateEvent = procedure (
    var WaveBufL, WaveBufR:TWaveBufferArray;
    Start, Ende, Max:QWORD; Complete:boolean
  ) of object;

  TScanThread = class(TThread)
  private
    _decoder : HSTREAM;
    _BassDll:TBassDll;
    _bpp : dword; // stream bytes per pixel
    _Width:DWord;
    _Start, _Ende, _Max:QWord;
    _Complete:boolean;
    _WaveBufL:TWaveBufferArray;
    _WaveBufR:TWaveBufferArray;
    _WaveBufferUpdateEvent:TWaveBufferUpdateEvent;
  protected
    procedure Execute; override;
    procedure ScanPeaks(decoder : HSTREAM);
    procedure StartScan(decoder:HSTREAM; Filename:string);
    procedure WriteData;
  public
    property WaveBufferUpdateEvent:TWaveBufferUpdateEvent
      read _WaveBufferUpdateEvent write _WaveBufferUpdateEvent;
    constructor create(Channel:HSTREAM;
                       Filename:string;
                       WavePicture:TPicture;
                       WaveBufferUpdateEvent:TWaveBufferUpdateEvent;
                       BassDll:TBassDll);
  end;

  TBassChannel = class
  private
    _Name:string;
    _Channel:HSTREAM;
    _BassDll:TBassDll;
    _Modus: TBassPlayerModus;
    _Volume:TBassVolume;
    _VolumeUpdate:boolean;
    _Balance:TBassBalance;
    _Lied:TLied;
    _GetLiedEvent:TGetLiedEvent;
    _GetFileEvent:TGetFileEvent;
    _OnLoad:TBassChannelUpdateTimer;
    _OnBassChannelToVis:TBassChannelToVis;
    _OnPlay:TBassChannelUpdateTimer;

    _FadeOut, _FadeAuto, _FadeStop: Boolean;
    _Fadetime: Integer; //in Sekunden
    _FadeStartVolume:TBassVolume;
    _Complete:boolean;
    _Normalisieren, _NormalisierenWarAn:boolean;

    _Start, _Ende, _MaxPeak:QWORD;
    _WavePicture:TPicture;
    _WaveBufL:TWaveBufferArray;
    _WaveBufR:TWaveBufferArray;

    _Equiliser:TBassEquiliser;
    _OnUpdateTimeTimer:TBassChannelUpdateTimer;
    _OnUpdatePaintTimer:TBassChannelUpdateTimer;
    _OnUpdateWaveTimer:TBassChannelUpdateTimer;

    _StartMODPlaytime: Integer;
    _SpeedinProzent: Integer;
    _NormalerMODSpeed: Integer;

    _Tempo:TBassTempo;
    _Samplerate:Cardinal;
    _Pitch:TBassPitch;

    _Phaser:boolean;
    _PhaserDryMix:TBassDryMix;
    _PhaserWetMix:TBassWetMix;
    _PhaserFeedback:TBassFeedback;
    _PhaserRate:TBassRate;
    _PhaserRange:TBassRange;
    _PhaserFreq:TBassFreq;
    _PhaserDSP:BASS_FX_DSPPHASER;

    function GetVolume: TBassVolume;
    procedure SetVolume(const Value: TBassVolume);
    function GetSecPosition: Longword;
    procedure SetSecPosition(const Value: Longword);
    function GetPlaybackSpeed: TBassProzent;
    procedure SetPlaybackSpeed(const Value: TBassProzent);
    procedure SetBalance(const Value: TBassBalance);
    function GetBalcance: TBassBalance;
    function GetStatus: TBassPlayerStatus;
    function GetRightPeak: dword;     // Peak = 0..32768
    function GetLeftPeak: dword;      // Peak = 0..32768
    function GetChannelInfo:TBassEquiliserGetChannelInfoResult;
    procedure DefaultUpdateTimer(BassChannel:TBassChannel);
    function GetSongTimeInfo(InfoStatus:TBassSongStatusInfo): TBassSongInfo;
    function GetEquiliser: TBassEquiliser;
    function GetMilliSecPosition: Longword;
    procedure SetMilliSecPosition(const Value: Longword);
    procedure SetTempo(const Value: TBassTempo);
    procedure SetSamplerate(const Value: Cardinal);
    procedure SetPitch(const Value: TBassPitch);
    function GetSamplerateMax: TBassSamplerate;
    function GetSamplerateMin: TBassSamplerate;
    procedure SetPhaser(const Value: boolean);
    procedure SetPhaserDryMix(const Value: TBassDryMix);
    procedure SetPhaserFeedback(const Value: TBassFeedback);
    procedure SetPhaserFreq(const Value: TBassFreq);
    procedure SetPhaserRange(const Value: TBassRange);
    procedure SetPhaserRate(const Value: TBassRate);
    procedure SetPhaserWetMix(const Value: TBassWetMix);
    procedure UpdatePhaser;
    procedure DrawSpectrum;
    procedure WaveBufferUpdateEvent(var WaveBufL, WaveBufR:TWaveBufferArray;
                                    Start, Ende, Max:QWORD; Complete:boolean);
    function GetisFadeOutPosition: boolean;
    function DefaultGetLiedEvent(var Lied:TLied):boolean;
    function DefaultGetFileEvent(var Dateiname:string):boolean;
    procedure SetNormalisieren(const Value: boolean);
  public
    constructor create(Name:string;
                       OnBassChannelToVis:TBassChannelToVis;
                       BassDll:TBassDll);
    destructor destroy; override;

    function GetFFTData(Sample:Cardinal): TBassFFTData;
    function GetFFTDataLong(Sample:Cardinal): TBassFFTDataLong;
    function GetWaveDataDWORD(Sample:Cardinal): TBassWaveDataDWORD;
    function GetWaveDataSMALLINT(Sample:Cardinal): TBassWaveDataSMALLINT;
    function GetWaveDataLong(Sample:Cardinal): TBassWaveDataLong;

    procedure Play;
    procedure Stop;
    procedure Pause;
    procedure UpdateTime;
    procedure UpdatePaint;

    function LoadFromFile(Dateiname:string): boolean;
    function LoadFromLied(Lied:TLied): boolean;
    function LoadNextLied:boolean;
    //Methoden fürs Internetradio
    function PlayNetStream(url: string): Boolean;
    procedure GetNetStreamInfo(ErgebnisListe: TStrings);

    function isFadingOK:boolean;
    procedure doFadingOut;
    procedure doFadingIn(StartVolume:TBassVolume = 0);
    procedure GetWavePicture(Canvas:TCanvas; Width, Height:integer);

    property OnLoad:TBassChannelUpdateTimer
      read _OnLoad write _OnLoad;
    property OnPlay:TBassChannelUpdateTimer
      read _OnPlay write _OnPlay;
    property Normalisieren:boolean
      read _Normalisieren write SetNormalisieren;
    property isComplete:boolean
      read _Complete;
    property Lied:TLied
      read _Lied;
    property Equiliser:TBassEquiliser
      read GetEquiliser;
    property Volume: TBassVolume
      read GetVolume write SetVolume;
    property Balance: TBassBalance
      read GetBalcance write SetBalance;
    property SecPosition: Longword
      read GetSecPosition write SetSecPosition; {in sekunden}
    property MilliSecPosition: Longword
      read GetMilliSecPosition write SetMilliSecPosition; {in millisekunden}
    property PlaybackSpeed: TBassProzent
      read GetPlaybackSpeed write SetPlaybackSpeed;

    property FadeTime: integer
      read _FadeTime write _FadeTime; //in Sekunden
    property FadeAuto:boolean
      read _FadeAuto write _FadeAuto;
    property FadeStop:boolean
      read _FadeStop write _FadeStop;
    property isFadeOutPosition:boolean
      read GetisFadeOutPosition;

    property Status: TBassPlayerStatus
      read GetStatus;
    property RightPeak: dword
      read GetRightPeak; //von 0 bis 128
    property LeftPeak: dword
      read GetLeftPeak;   //von 0 bis 128
    property Name:string
      read _Name;
    property SongTimeInfo[InfoStatus:TBassSongStatusInfo]: TBassSongInfo
      read GetSongTimeInfo;
    property OnUpdateTimeEvent:TBassChannelUpdateTimer
      read _OnUpdateTimeTimer write _OnUpdateTimeTimer;
    property OnUpdatePaintEvent:TBassChannelUpdateTimer
      read _OnUpdatePaintTimer write _OnUpdatePaintTimer;
    property OnUpdateWaveEvent:TBassChannelUpdateTimer
      read _OnUpdateWaveTimer write _OnUpdateWaveTimer;

    property Tempo:TBassTempo
      read _Tempo write SetTempo;
    property Samplerate:Cardinal
      read _Samplerate write SetSamplerate;
    property SamplerateMin:TBassSamplerate
      read GetSamplerateMin;
    property SamplerateMax:TBassSamplerate
      read GetSamplerateMax;
    property Pitch:TBassPitch
      read _Pitch write SetPitch;

    property Phaser:boolean
      read _Phaser write SetPhaser;
    property PhaserDryMix:TBassDryMix
      read _PhaserDryMix write SetPhaserDryMix;
    property PhaserWetMix:TBassWetMix
      read _PhaserWetMix write SetPhaserWetMix;
    property PhaserFeedback:TBassFeedback
      read _PhaserFeedback write SetPhaserFeedback;
    property PhaserRate:TBassRate
      read _PhaserRate write SetPhaserRate;
    property PhaserRange:TBassRange
      read _PhaserRange write SetPhaserRange;
    property PhaserFreq:TBassFreq
      read _PhaserFreq write SetPhaserFreq;

    property GetLiedEvent:TGetLiedEvent
      read _GetLiedEvent write _GetLiedEvent;
    property GetFileEvent:TGetFileEvent
      read _GetFileEvent write _GetFileEvent;

    property Modus: TBassPlayerModus
      read _Modus;
    property Channel:HSTREAM
      read _Channel;
  end;

implementation

{ TBassChannel }

constructor TBassChannel.create(Name:string;
                                OnBassChannelToVis:TBassChannelToVis;
                                BassDll:TBassDll);
begin
  _Name:=Name;
  _BassDll:=BassDll;
  _OnBassChannelToVis:=OnBassChannelToVis;
  _Lied:=nil;
  _GetLiedEvent:=DefaultGetLiedEvent;
  _GetFileEvent:=DefaultGetFileEvent;
  _VolumeUpdate:=true;
  _Modus := moNone;
  _Fadetime := 2;
  _Equiliser:=nil;
  _Tempo:=0;
  _Samplerate:=44100;
  _PhaserDryMix:=999;
  _PhaserWetMix:=-999;
  _PhaserFeedback:=-60;
  _PhaserRate:=2;
  _PhaserRange:=60;
  _PhaserFreq:=1000;
  _OnUpdateTimeTimer:=DefaultUpdateTimer;
  _OnUpdatePaintTimer:=DefaultUpdateTimer;
  _OnUpdateWaveTimer:=DefaultUpdateTimer;
  _OnLoad:=DefaultUpdateTimer;
  _OnPlay:=DefaultUpdateTimer;
  _WavePicture:=TPicture.Create;
  _WavePicture.Bitmap.Width:=1000;
  _WavePicture.Bitmap.Height:=100;
  _FadeAuto:=true;
  _FadeStop:=false;
  _Start:=0;
  _Ende:=0;
  _MaxPeak:=0;
  _Complete:=false;
  _Normalisieren:=true;
  setlength(_WaveBufL, 0);
  setlength(_WaveBufR, 0);
  DrawSpectrum;
end;

destructor TBassChannel.destroy;
begin
  if assigned(_Equiliser) then
    _Equiliser.free;
  if assigned(_Lied) then
    _Lied.free;
  _BassDll.Bass_StreamFree(_Channel);
  _BassDll.BASS_MusicFree(_Channel);
  _WavePicture.free;
  inherited;
end;

function TBassChannel.GetSecPosition: Longword;
var uptime: integer;
begin
  Result := 0;
  if _Channel > 0 then begin
    // Sound get Position
    if _Modus = moSamples then
      Result := round(
        _BassDll.BASS_ChannelBytes2Seconds(
          _Channel, _BassDll.BASS_ChannelGetPosition(_Channel)
        )
      );

    // Mod-Music get Position
    if _Modus = moMusik then
    begin
      uptime := timegettime;
      Result := (uptime - _startmodplaytime) div 1000;
    end;
  end;
end;

function TBassChannel.GetMilliSecPosition: Longword;
var uptime: integer;
begin
  Result := 0;
  if _Channel > 0 then begin
    // Sound get Position
    if _Modus = moSamples then
      Result :=
        round(  (round(_BassDll.BASS_ChannelBytes2Seconds(_Channel,
                       _BassDll.BASS_ChannelGetLength(_Channel)) * 1000) /
                                _BassDll.BASS_ChannelGetLength(_Channel))
                              * _BassDll.BASS_ChannelGetPosition(_Channel));
    // Mod-Music get Position
    if _Modus = moMusik then
    begin
      uptime := timegettime;
      Result := (uptime - _startmodplaytime) div 1000;
    end;
  end;
end;

procedure TBassChannel.SetSecPosition(const Value: Longword);
var pos: Longword;
begin
  _VolumeUpdate:=false;
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, 0, 0);
  if _Channel > 0 then begin
    // Sound set Position
    if _Modus = moSamples then
      _BassDll.BASS_ChannelSetPosition(
        _Channel, _BassDll.BASS_ChannelSeconds2Bytes(_Channel, Value)
      );

    // Mod-Music set Position
    if _Modus = moMusik then
    begin
      _startmodplaytime := timegettime - (Value * 1000);
      pos := round(SecPosition * (_SpeedinProzent / 100)) or $FFFF0000;
      _BassDll.BASS_ChannelSetPosition(_Channel, pos);
    end;
  end;
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, _Volume, 0);
  _VolumeUpdate:=true;
end;

procedure TBassChannel.SetMilliSecPosition(const Value: Longword);
var pos: Longword;
begin
  _VolumeUpdate:=false;
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, 0, 0);
  if _Channel > 0 then begin
    // Sound set Position
    if _Modus = moSamples then
      _BassDll.BASS_ChannelSetPosition(
         _Channel,
         round(     (_BassDll.BASS_ChannelGetLength(_Channel) /
               round(_BassDll.BASS_ChannelBytes2Seconds(_Channel,
                     _BassDll.BASS_ChannelGetLength(_Channel)) * 1000)) * Value)
      );

    // Mod-Music set Position
    if _Modus = moMusik then
    begin
      _startmodplaytime := timegettime - (Value * 1000);
      pos := round(SecPosition * (_SpeedinProzent / 100)) or $FFFF0000;
      _BassDll.BASS_ChannelSetPosition(_Channel, pos);
    end;
  end;
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, _Volume, 0);
  _VolumeUpdate:=true;
end;

function TBassChannel.GetVolume: TBassVolume;
var freq, vol:Cardinal;
    pan:integer;
begin
  Result:=_Volume;
  if _VolumeUpdate then begin
    if Status = sndPlaying then begin
      _BassDll.BASS_ChannelGetAttributes(_Channel, freq, vol, pan);
      Result:=vol;
      _Volume:=vol;
    end;
  end;
end;

procedure TBassChannel.SetVolume(const Value: TBassVolume);
begin
  _Volume:=Value;
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, Value, 0);
end;

function TBassChannel.GetPlaybackSpeed: TBassProzent;
begin
  Result := _SpeedinProzent;
end;

procedure TBassChannel.SetPlaybackSpeed(const Value: TBassProzent);
var Prozent:TBassProzent;
begin
  Prozent:=Value;
  if Prozent = 0 then
    Prozent := 100;

  if _Modus = moSamples then
  begin
    if     (round(44100 * (Prozent / 100)) > 100)
       and (round(44100 * (Prozent / 100)) < 100000) then
    begin //DirectSound erlaubt nur Frequenzen zwischen 100 and 100000.
      _BassDll.BASS_ChannelSetAttributes(
        _Channel, round(44100 * (Prozent / 100)), -1, -101
      );
    end;
  end;
  if _Modus = moMusik then
  begin
    _BassDll.BASS_MusicSetAttribute(
      _Channel,
      BASS_MUSIC_ATTRIB_SPEED,
      round(_normalermodspeed * (_SpeedinProzent / 100))
    );
  end;
  _SpeedinProzent := prozent;
end;

procedure TBassChannel.SetBalance(const Value: TBassBalance);
begin
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, -1, Value);
  _Balance := Value;
end;

function TBassChannel.GetFFTData(Sample:Cardinal): TBassFFTData;
begin
  if Status = sndPLAYING then
    _BassDll.BASS_ChannelGetData(_Channel, @Result, Sample);
end;

function TBassChannel.GetFFTDataLong(Sample:Cardinal): TBassFFTDataLong;
begin
  if Status = sndPLAYING then
    _BassDll.BASS_ChannelGetData(_Channel, @Result, Sample);
end;

function TBassChannel.GetWaveDataDWORD(Sample:Cardinal): TBassWaveDataDWORD;
begin
  if Status = sndPLAYING then
    _BassDll.BASS_ChannelGetData(_Channel, @Result, Sample);
end;

function TBassChannel.GetWaveDataSMALLINT(Sample:Cardinal): TBassWaveDataSMALLINT;
begin
  if Status = sndPLAYING then
    _BassDll.BASS_ChannelGetData(_Channel, @Result, Sample);
end;

function TBassChannel.GetWaveDataLong(Sample:Cardinal): TBassWaveDataLong;
begin
  if Status = sndPLAYING then
    _BassDll.BASS_ChannelGetData(_Channel, @Result, Sample);
end;

function TBassChannel.GetStatus: TBassPlayerStatus;
begin
  if _Channel = 0 then
    Result := sndNotLoaded
  else begin
    Result := sndSTOPPED;
    if _BassDll.BASS_ChannelIsSliding(_Channel) = BASS_SLIDE_VOL then
      Result := sndPLAYING
    else begin
      Case _BassDll.BASS_ChannelIsActive(_Channel) of
        0: Result := sndSTOPPED;
        1: Result := sndPLAYING;
        2: Result := sndSTALLED;
        3: Result := sndPAUSED;
      end;
    end;
  end;
end;

function TBassChannel.GetLeftPeak: dword;
begin
  Result := LOWORD(_BassDll.BASS_ChannelGetLevel(_Channel));
end;

function TBassChannel.GetRightPeak: dword;
begin
  Result := HIWORD(_BassDll.BASS_ChannelGetLevel(_Channel));
end;

procedure TBassChannel.Pause;
begin
  _BassDll.BASS_ChannelPause(_Channel);
  SetVolume(_Volume);
  _OnBassChannelToVis(Self, true);
  _OnPlay(Self);
end;

procedure TBassChannel.Play;
begin
  if Status = sndSTOPPED then
    _BassDll.BASS_ChannelPlay(_Channel, True);
  if Status in [sndPAUSED, sndSTALLED] then
    _BassDll.BASS_ChannelPlay(_Channel, False);

  SetVolume(_Volume);
  _OnBassChannelToVis(Self, true);
  _OnPlay(Self);
end;

procedure TBassChannel.Stop;
begin
  _BassDll.BASS_ChannelStop(_Channel);
  if _Modus = moSamples then
    SecPosition := 0;
end;

function TBassChannel.LoadFromLied(Lied:TLied): boolean;
var tmpVolume: TBassVolume;
    Ext:string;
begin
  _BassDll.BASS_ChannelSetAttributes(_Channel, -1, _Volume, 0);
  _Complete:=false;
  if assigned(_Lied) then
    _Lied.free;
  _Lied:=TLied.create(Lied);
  setlength(_WaveBufL, 0);
  setlength(_WaveBufR, 0);
  DrawSpectrum;
  tmpVolume := Volume;

  // stop is Sound playing
  if Status <> sndStopped then
    Stop;

  // freigeben wenn was läuft
  case _Modus of
    moSamples: _BassDll.BASS_StreamFree(_Channel);
    moMusik:   _BassDll.BASS_MusicFree(_Channel);
    moStream:  _BassDll.BASS_StreamFree(_Channel);
  end;

  Ext:=UpperCase(ExtractFileExt(Lied.Dateiname));
  if    (Ext = '.MO3')
     or (Ext = '.IT')
     or (Ext = '.XM')
     or (Ext = '.S3M')
     or (Ext = '.MTM')
     or (Ext = '.MOD')
     or (Ext = '.UMX') then
  begin //mod musik
    _Channel := _BassDll.BASS_MusicLoad(
      False,
      PChar(Lied.Dateiname), 0, 0,
         BASS_MUSIC_RAMP
      or BASS_MUSIC_CALCLEN
      or BASS_MUSIC_DECODE, 0
    );

    _StartModPlayTime := TimeGetTime;
    _NormalerModspeed := (
      _BassDll.BASS_MusicGetAttribute(_Channel, BASS_MUSIC_ATTRIB_SPEED)
    );
    _Modus := moMusik;

    // Volume zurücksetzen (nach laden von Mod-Music event. > 100 ?)
    if tmpVolume <> Volume then
      Volume := tmpVolume;

    Result := Boolean(_Channel);
  end
  else begin //Wav, MP3 usw.
    _Channel := _BassDll.BASS_StreamCreateFile(
      False, PChar(Lied.Dateiname),
      0, 0,
         BASS_STREAM_DECODE
      or BASS_STREAM_PRESCAN
    );
    Volume:=_Volume;
    _Modus := moSamples;
    Result := Boolean(_Channel);
  end;

  //sound veränderungen setzten wenn nötig:
  if PlaybackSpeed <> 100 then
    PlaybackSpeed := _SpeedinProzent; //100 = normal
  if Balance <> 0 then
    Balance := _Balance;     //0 = normal

  {$Q- $R-}
  try
    _Channel := _BassDll.BASS_FX_TempoCreate(_Channel, BASS_FX_FREESOURCE);
  except
    _Channel := _BassDll.BASS_FX_TempoCreate(_Channel, BASS_FX_FREESOURCE);
  end;
  {$Q+ $R+}

  SetPhaser(_Phaser);
  if assigned(_Equiliser) then
    if Assigned(_Equiliser.SpecialFunktion) then
      _Equiliser.SpecialFunktion.Refresh;

  _Start:=0;
  _Ende:=SongTimeInfo[SongTimeLength].asSecInteger;
  Lied.SecLaenge:=_Ende;
  TScanThread.Create(
    _Channel, Lied.Dateiname, _WavePicture, WaveBufferUpdateEvent, _BassDll
  );
  _OnLoad(Self);
  _OnBassChannelToVis(Self);
end;

function TBassChannel.PlayNetStream(url: string): Boolean;
begin
  if _BassDll.BASS_ChannelIsActive(_Channel) = 1 then
  begin //freigeben wenn schon was läuft
    case _Modus of
      moSamples: _BassDll.BASS_StreamFree(_Channel);
      moMusik:   _BassDll.BASS_MusicFree(_Channel);
      moStream:  _BassDll.BASS_StreamFree(_Channel);
    end;
  end;

  _Channel := _BassDll.BASS_StreamCreateURL(
    PChar(url), 0, BASS_STREAM_META, nil, 0
  );
  if _Channel = 0 then
    raise Exception.Create(_('Das kann leider nicht abgespielt werden.'));
  Result := _BassDll.BASS_ChannelPlay(_Channel, False);

  _Modus := moStream;
end;

procedure TBassChannel.GetNetStreamInfo(ErgebnisListe: TStrings);
var zspeicher: PChar;
    posi, count: integer;
begin
  zspeicher := _BassDll.BASS_StreamGetTags(_Channel, BASS_TAG_META);
  if assigned(zspeicher) then begin
    posi := Pos('StreamTitle=', zspeicher);
    if Posi > 0 then begin
      posi := posi + system.length('StreamTitle=') + 1;
      count := Pos(';', zspeicher) - posi - 1;
      ErgebnisListe.Append(Copy(zspeicher, posi, count));
    end;
  end;
end;

function TBassChannel.GetChannelInfo: TBassEquiliserGetChannelInfoResult;
begin
  Result.xChannel:=_Channel;
  Result.xBassDll:=_BassDll;
end;

procedure TBassChannel.DefaultUpdateTimer(BassChannel: TBassChannel);
begin
end;

procedure TBassChannel.UpdatePaint;
begin
  if assigned(_OnUpdatePaintTimer) then
    _OnUpdatePaintTimer(Self);
  if assigned(_OnUpdateWaveTimer) then
    _OnUpdateWaveTimer(Self);
end;

procedure TBassChannel.UpdateTime;
var vol, freq: cardinal;
    pan: integer;
begin
  if _FadeAuto then
    if _BassDll.BASS_ChannelGetPosition(_Channel) < _Start then
      _BassDll.BASS_ChannelSetPosition(_Channel, _Start);

  if _FadeOut then begin
    _BassDll.BASS_ChannelGetAttributes(_Channel, freq, vol, pan);
    if ((Vol <= 1) or (Status <> sndPlaying)) then begin
      if _FadeStop then
        Stop
      else
        Pause;

      _Volume:=_FadeStartVolume;
      _FadeOut:=false;
      if _FadeAuto then
        LoadNextLied;
    end;
  end;
  if assigned(_OnUpdateTimeTimer) then
    _OnUpdateTimeTimer(Self);
end;

function TBassChannel.GetSongTimeInfo(InfoStatus:TBassSongStatusInfo): TBassSongInfo;
var Time: Integer;
    m:string;
    Posi, Laenge:INT64;
begin
  if Status = sndNotLoaded then begin
    Result.asSecInteger:=0;
    Result.asMilliSecInteger:=0;
    Result.asSecString:='--:--';
    Result.asMilliSecString:='--:--:---';
  end
  else begin
    Posi:=round(
        _BassDll.BASS_ChannelGetPosition(_Channel)
      / _BassDll.BASS_FX_TempoGetRateRatio(_Channel)
    );
    Laenge:=round(
        _BassDll.BASS_ChannelGetLength(_Channel)
      / _BassDll.BASS_FX_TempoGetRateRatio(_Channel)
    );
    case InfoStatus of
      SongTimeUp:
        begin
          Result.asSecInteger:=
            round(_BassDll.BASS_ChannelBytes2Seconds(_Channel, Posi));
          Result.asMilliSecInteger:=
            round((round(_BassDll.BASS_ChannelBytes2Seconds(
              _Channel, Laenge) * 1000) / Laenge) * Posi
            );
        end;
      SongTimeDown:
        begin
          Result.asSecInteger:=
              round(_BassDll.BASS_ChannelBytes2Seconds(_Channel, Posi))
            - round(_BassDll.BASS_ChannelBytes2Seconds(_Channel, Laenge));
          Result.asMilliSecInteger:=
              round(
                round(
                  _BassDll.BASS_ChannelBytes2Seconds(_Channel, Laenge) * 1000
                ) / Laenge
              ) * Posi - round(
                _BassDll.BASS_ChannelBytes2Seconds(_Channel, Laenge) * 1000
              );
        end;
      SongTimeLength:
        begin
          Result.asSecInteger:=
            round(_BassDll.BASS_ChannelBytes2Seconds(_Channel, Laenge));
          Result.asMilliSecInteger:=
            round(_BassDll.BASS_ChannelBytes2Seconds(_Channel, Laenge) * 1000);
        end;
    end;
    if Result.asSecInteger <> 0 then begin
      Time := Trunc(Result.asSecInteger);
      Result.asSecString := Format('%.2d:%.2d', [Time div 60, abs(Time mod 60)]);
    end
    else begin
      Result.asSecString := '00:00';
    end;
    if Result.asMilliSecInteger <> 0 then begin
      if Result.asMilliSecInteger < 0 then
        m:='-'
      else
        m:='';
      Result.asMilliSecString :=
        m+Format('%.2d:%.2d:%.3d',
        [abs((Result.asMilliSecInteger div 1000) div 60),
         abs((Result.asMilliSecInteger div 1000) mod 60),
         abs(Result.asMilliSecInteger mod 1000)]
      );
    end
    else begin
      Result.asMilliSecString := '00:00:000';
    end;
  end;
end;

function TBassChannel.GetBalcance: TBassBalance;
var freq, vol:Cardinal;
    pan:integer;
begin
  if Status = sndPlaying then begin
    _BassDll.BASS_ChannelGetAttributes(_Channel, freq, vol, pan);
    Result:=pan;
  end
  else Result:=_Balance;
end;

function TBassChannel.GetEquiliser: TBassEquiliser;
begin
  if not assigned(_Equiliser) then
    _Equiliser:=TBassEquiliser.create(GetChannelInfo);
  Result:=_Equiliser;
end;

procedure TBassChannel.SetTempo(const Value: TBassTempo);
begin
  _Tempo:=Value;
  if Status = sndPlaying then
    _BassDll.BASS_FX_TempoSet(_Channel, _Tempo, 0, -100);
end;

procedure TBassChannel.SetSamplerate(const Value: Cardinal);
begin
  _Samplerate:=Value;
  if Status = sndPlaying then begin
    _BassDll.BASS_FX_TempoSet(_Channel, -100, _Samplerate, -100);
  end;
end;

procedure TBassChannel.SetPitch(const Value: TBassPitch);
begin
  _Pitch:=Value;
  if Status = sndPlaying then begin
    _BassDll.BASS_FX_TempoSet(_Channel, -100, 0, _Pitch);
  end;
end;

function TBassChannel.GetSamplerateMax: TBassSamplerate;
var info: BASS_CHANNELINFO;
begin
  _BassDll.BASS_ChannelGetInfo(_Channel, info);
  _Samplerate := info.freq;
  Result:=round(_Samplerate * BASSSAMPLERATEMAXP);
end;

function TBassChannel.GetSamplerateMin: TBassSamplerate;
var info: BASS_CHANNELINFO;
begin
  _BassDll.BASS_ChannelGetInfo(_Channel, info);
  _Samplerate := info.freq;
  Result:=round(_Samplerate * BASSSAMPLERATEMINP);
end;

procedure TBassChannel.SetPhaser(const Value: boolean);
begin
  _Phaser:=Value;
  if _Phaser then begin
    _BassDll.BASS_FX_DSP_Set(_Channel, BASS_FX_DSPFX_PHASER, 1);
    UpdatePhaser;
  end
  else _BassDll.BASS_FX_DSP_Remove(_Channel, BASS_FX_DSPFX_PHASER);
end;

procedure TBassChannel.SetPhaserDryMix(const Value: TBassDryMix);
begin
  _PhaserDryMix:=Value;
  UpdatePhaser;
end;

procedure TBassChannel.SetPhaserFeedback(const Value: TBassFeedback);
begin
  _PhaserFeedback:=Value;
  UpdatePhaser;
end;

procedure TBassChannel.SetPhaserFreq(const Value: TBassFreq);
begin
  _PhaserFreq:=Value;
  UpdatePhaser;
end;

procedure TBassChannel.SetPhaserRange(const Value: TBassRange);
begin
  _PhaserRange:=Value;
  UpdatePhaser;
end;

procedure TBassChannel.SetPhaserRate(const Value: TBassRate);
begin
  _PhaserRate:=Value;
  UpdatePhaser;
end;

procedure TBassChannel.SetPhaserWetMix(const Value: TBassWetMix);
begin
  _PhaserWetMix:=Value;
  UpdatePhaser;
end;

procedure TBassChannel.UpdatePhaser;
begin
  _BassDll.BASS_FX_DSP_GetParameters(
    _Channel, BASS_FX_DSPFX_PHASER, @_PhaserDSP
  );
  _PhaserDSP.fDryMix := _PhaserDryMix / 1000;
  _PhaserDSP.fWetMix := _PhaserWetMix / 1000;
  _PhaserDSP.fFeedback := _PhaserFeedback / 1000;
  _PhaserDSP.fRate := _PhaserRate / 10;
  _PhaserDSP.fRange := _PhaserRange / 10;
  _PhaserDSP.fFreq := _PhaserFreq / 10;
  _BassDll.BASS_FX_DSP_SetParameters(
    _Channel, BASS_FX_DSPFX_PHASER, @_PhaserDSP
  );
end;

procedure TBassChannel.doFadingOut;
begin
  _Complete:=false;
  _FadeStartVolume:=_Volume;
  _FadeOut:=true;
  _BassDll.BASS_ChannelSlideAttributes(
    _Channel, -1, 0, -101, trunc(_Fadetime * 1000)
  );
end;

procedure TBassChannel.doFadingIn(StartVolume:TBassVolume);
var Volume:TBassVolume;
begin
  if GetStatus = sndNotLoaded then
    LoadNextLied;
  if GetStatus <> sndNotLoaded then begin
    Volume:=_Volume;
    SetVolume(StartVolume);
    Play;
    _BassDll.BASS_ChannelSlideAttributes(
      _Channel, -1, Volume, -101, (_Fadetime * 1000)
    );
  end;
end;

function TBassChannel.isFadingOK: boolean;
begin
  if GetStatus = sndPlaying then
    Result:=    _Complete
            and not (_BassDll.BASS_ChannelIsSliding(_Channel) = BASS_SLIDE_VOL)
  else
    Result:=false;
end;

procedure TBassChannel.DrawSpectrum;
var i, ht, prozent : integer;
    peak:DWord;
begin
  //clear background
  _WavePicture.Bitmap.Canvas.Brush.Color := clBlack;
  _WavePicture.Bitmap.Canvas.FillRect(
    Rect(0, 0, _WavePicture.Bitmap.Width, _WavePicture.Bitmap.Height)
  );

  prozent:=100 - trunc((100 / MaxPeak) * _MaxPeak);
  if prozent < 0 then
    prozent:=0;
  if prozent > 100 then
    prozent:=100;
  if _Normalisieren then begin
    _NormalisierenWarAn:=true;
    if isFadingOK or (Status <> sndPlaying) then begin
      if _Complete then begin
        if 50 + prozent > 100 then begin
          if _Volume <> 100 then
            SetVolume(100);
        end
        else begin
          if _Volume <> 50 + prozent then
            SetVolume(50 + prozent);
        end;
      end
      else begin
        if _Volume <> 50 then
          SetVolume(50);
      end;
    end;
  end
  else begin
    if _NormalisierenWarAn then begin
      SetVolume(50);
      _NormalisierenWarAn:=false;
    end;
  end;

  //draw peaks
  ht := _WavePicture.Bitmap.Height div 2;
  for i:=1 to length(_WaveBufL) do begin
    with _WavePicture.Bitmap do begin
      peak:=_WaveBufL[i-1].Peak;
      if _Normalisieren then
        peak:=peak + trunc((peak / 100) * prozent);
      Canvas.MoveTo(i, ht);
	    Canvas.Pen.Color := clLime;
      Canvas.LineTo(i,ht-trunc((peak / MaxPeak) * ht));
      Canvas.Pen.Color := clLime;
      Canvas.MoveTo(i, ht+2);
      peak:=_WaveBufR[i-1].Peak;
      if _Normalisieren then
        peak:=peak + trunc((peak / 100) * prozent);
	    Canvas.LineTo(i, ht+2+trunc((peak / MaxPeak) * ht));
    end;
  end;
end;

procedure TBassChannel.WaveBufferUpdateEvent(
                                      var WaveBufL, WaveBufR: TWaveBufferArray;
                                      Start, Ende, Max:QWORD; Complete:boolean);
begin
  _WaveBufL:=WaveBufL;
  _WaveBufR:=WaveBufR;
  _Start:=Start;
  _Ende:=Ende;
  _Complete:=Complete;
  _MaxPeak:=Max;
  if Complete then
    DrawSpectrum;
end;

procedure TBassChannel.GetWavePicture(Canvas:TCanvas; Width, Height:integer);

  function PaintText(Canvas:TCanvas;
                     sectime:integer;
                     x, y:integer; Color:
                     TColor):string;
  var str:string;
  begin
    //format time
    str := '';
    if (sectime mod 60 < 10) then
      str := '0';
    str := str + inttostr(sectime mod 60);
    str := inttostr(sectime div 60) + ':' + str;

    Canvas.Font.Color := Color;
    Canvas.Font.Style := [fsBold];
    if x > Width - Canvas.TextWidth(str) - 5 then
      x:=x - Canvas.TextWidth(str) - 5;
    SetBkMode(Canvas.Handle, TRANSPARENT);
    Canvas.TextOut(x+2, y, str);
  end;

  procedure PaintLine(Canvas:TCanvas; x:integer; Color:TColor);
  begin
    //drawline
    Canvas.Pen.Color := Color;
    Canvas.MoveTo(x, 0);
    Canvas.LineTo(x, Height);
  end;

var x1, x2, x3, sectime1, sectime2, sectime3 : integer;
    bpp:dword;
begin
  // stream bytes per pixel
  bpp := _BassDll.BASS_ChannelGetLength(_Channel) div Width;

  // minimum 20ms per pixel (BASS_ChannelGetLevel scans 20ms)
  if (bpp < _BassDll.BASS_ChannelSeconds2Bytes(_Channel, 0.02)) then
    bpp := _BassDll.BASS_ChannelSeconds2Bytes(_Channel, 0.02);

  Canvas.StretchDraw(Rect(0, 0, Width, Height), _WavePicture.Graphic);

  if bpp > 0 then begin
    // stream bytes per pixel
    x1:=_BassDll.BASS_ChannelGetPosition(_Channel) div bpp;
    sectime1 := trunc(_BassDll.BASS_ChannelBytes2Seconds(
      _Channel, _BassDll.BASS_ChannelGetPosition(_Channel))
    );

    x2:=_Start div bpp; // stream bytes per pixel
    sectime2 := trunc(_BassDll.BASS_ChannelBytes2Seconds(_Channel, _Start));

    x3:=_Ende div bpp; // stream bytes per pixel
    sectime3 := trunc(_BassDll.BASS_ChannelBytes2Seconds(_Channel, _Ende));

    PaintLine(Canvas, x1, clWhite);
    if _FadeAuto then begin
      PaintLine(Canvas, x2, clRed);
      PaintLine(Canvas, x3, clRed);
    end;

    PaintText(Canvas, sectime1, x1, 0, clWhite);
    if _FadeAuto then begin
      PaintText(Canvas, sectime2, x2, Height - Canvas.TextHeight('X'), clWhite);
      PaintText(Canvas, sectime3, x3, Height - Canvas.TextHeight('X'), clWhite);
    end;
  end;
end;

function TBassChannel.GetisFadeOutPosition: boolean;
begin
  if _FadeAuto and _Complete then
    Result:=(_BassDll.BASS_ChannelGetPosition(_Channel) >= _Ende)
  else
    Result:=false;
end;

function TBassChannel.LoadNextLied:boolean;
var Lied:TLied;
    Dateiname:string;
begin
  if _GetLiedEvent(Lied) then
    Result:=LoadFromLied(Lied)
  else begin
    if _GetFileEvent(Dateiname) then
      Result:=LoadFromFile(Dateiname)
    else
      Result:=false;
  end;
end;

function TBassChannel.LoadFromFile(Dateiname:string): boolean;
var Lied:TLied;
begin
  Lied:=TLied.create(Dateiname);
  try
    Result:=LoadFromLied(Lied);
  finally
    Lied.free;
  end;
end;

function TBassChannel.DefaultGetFileEvent(var Dateiname: string): boolean;
begin
  Result:=false;
end;

function TBassChannel.DefaultGetLiedEvent(var Lied: TLied): boolean;
begin
  Result:=false;
end;

procedure TBassChannel.SetNormalisieren(const Value: boolean);
begin
  _Normalisieren:=Value;
  DrawSpectrum;
end;

{ TScanThread }

constructor TScanThread.create(Channel:HSTREAM;
                               Filename:string;
                               WavePicture:TPicture;
                               WaveBufferUpdateEvent:TWaveBufferUpdateEvent;
                               BassDll:TBassDll);
begin
  inherited create(false);
  _WaveBufferUpdateEvent:=WaveBufferUpdateEvent;
  _BassDll:=BassDll;
  _Width:=WavePicture.Bitmap.Width;
  _Start:=0;
  _Ende:=0;
  _Max:=0;
  Priority := tpLower;
  FreeOnTerminate := true;
  StartScan(Channel, Filename);
end;

procedure TScanThread.Execute;
var i:integer;
    abbruch:boolean;
begin
  inherited;
  _Complete:=false;
  ScanPeaks(_Decoder);
  i:=0;
  abbruch:=false;
  while (i < (length(_WaveBufL) div 100) * 25) and not abbruch do begin
    abbruch:=   (trunc((_WaveBufL[i].Peak / MaxPeak) * 100) > 5)
             or (trunc((_WaveBufR[i].Peak / MaxPeak) * 100) > 5);
    if not abbruch then
      inc(i);
  end;
  _Start:=_WaveBufL[i].Posi;

  i:=length(_WaveBufL)-1;
  abbruch:=false;
  while (i > i - (i div 100) * 25) and not abbruch do begin
    abbruch:=   (trunc((_WaveBufL[i].Peak / MaxPeak) * 100) > 20)
             or (trunc((_WaveBufR[i].Peak / MaxPeak) * 100) > 20);
    if not abbruch then
      dec(i);
  end;
  _Ende:=_WaveBufL[i].Posi;
  _Complete:=true;
  Synchronize(WriteData);
  _BassDll.BASS_StreamFree(_Decoder);
end;

procedure TScanThread.ScanPeaks(decoder : HSTREAM);
var cpos, level : DWord;
    peak : array[0..1] of DWORD;
    position : DWORD;
    counter, step : integer;
begin
  cpos := 0;
  peak[0] := 0;
  peak[1] := 0;
  counter := 0;
  step:=0;
  while not Self.Suspended do begin
    inc(step);
    if step > 500 then begin
      step:=0;
      Synchronize(WriteData);
    end;
    level := _BassDll.BASS_ChannelGetLevel(decoder); // scan peaks
    if (peak[0] < LOWORD(level)) then
      peak[0]:=LOWORD(level); // set left peak
		if (peak[1] < HIWORD(level)) then
      peak[1]:=HIWORD(level); // set right peak
    if _BassDll.BASS_ChannelIsActive(decoder) <> BASS_ACTIVE_PLAYING then begin
      position := cardinal(-1); // reached the end
		end
    else position := _BassDll.BASS_ChannelGetPosition(decoder) div _bpp;

    if position > cpos then begin
      if peak[0] > _Max then
        _Max:=peak[0];
      if peak[1] > _Max then
        _Max:=peak[1];

      inc(counter);
      if counter < length(_WaveBufL) then begin
        _WaveBufL[counter].Peak := peak[0];
        _WaveBufL[counter].Posi := _BassDll.BASS_ChannelGetPosition(decoder);
        _WaveBufR[counter].Peak := peak[1];
        _WaveBufR[counter].Posi := _BassDll.BASS_ChannelGetPosition(decoder);
      end;

      if (position >= _Width) then
        break;
      cpos := position;
    end;
    peak[0] := 0;
    peak[1] := 0;
  end;
end;

procedure TScanThread.StartScan(decoder: HSTREAM; Filename: string);
begin
  setlength(_WaveBufL, _Width);
  setlength(_WaveBufR, _Width);
  // stream bytes per pixel
  _bpp := _BassDll.BASS_ChannelGetLength(decoder) div _Width;

  // minimum 20ms per pixel (BASS_ChannelGetLevel scans 20ms)
  if (_bpp < _BassDll.BASS_ChannelSeconds2Bytes(decoder, 0.02)) then
    _bpp := _BassDll.BASS_ChannelSeconds2Bytes(decoder, 0.02);

  _Decoder := _BassDll.BASS_StreamCreateFile(
    false, PChar(filename), 0, 0, BASS_STREAM_DECODE
  );
	if (_Decoder = 0) then
    _Decoder := _BassDll.BASS_MusicLoad(
      false, PChar(filename), 0, 0, BASS_MUSIC_DECODE, 0
    );
  Self.Resume;
end;

procedure TScanThread.WriteData;
begin
  _WaveBufferUpdateEvent(_WaveBufL, _WaveBufR, _Start, _Ende, _Max, _Complete);
end;

end.


