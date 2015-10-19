{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{                                                                              }
{------------------------------------------------------------------------------}
{ FX-Teil:  Copyright (c) 2003-2004 JOBnik! [Arthur Aminov, ISRAEL]            }
{                                   e-mail: bass_fx@jobnik.tk                  }
{                                                                              }
{ Edit to Version 2.1-2.4 by omata (Thorsten)                                  }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{ Edit to Version B.3.1 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit FrameChannelU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, BassPlayerExU, BassChannelU, ExtCtrls,
  FrameEquiliserU, BassEquiliserU, BassTypenU, BassEquiliserSpecialU,
  BassEquiliserEchoU, BassEquiliserRotateU, BassEquiliserFlangerU,
  BassEquiliserReverbU, GR32, GR32_Image;

type
  TFrameChannel = class(TFrame)
    GbChannel: TGroupBox;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TsSteuerung: TTabSheet;
    LaUp: TLabel;
    LaDown: TLabel;
    LaStatus: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    VolLabel: TLabel;
    BtnLoadPlay: TButton;
    BtnPlay: TButton;
    BtnPause: TButton;
    BtnLoad: TButton;
    BtnStop: TButton;
    TrackBarVolume: TTrackBar;
    TrackBarBalance: TTrackBar;
    TrackBarPosition: TTrackBar;
    EdLied: TEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    CoCrossfading: TComboBox;
    CbCrossfading: TCheckBox;
    BtnCrossfading: TButton;
    TsEquiliser: TTabSheet;
    PaEquiliser: TPanel;
    TsEffekte: TTabSheet;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    CbEcho: TCheckBox;
    CbFlange: TCheckBox;
    CbRotate: TCheckBox;
    TbReverb: TTrackBar;
    TbEcho: TTrackBar;
    TbRotate: TTrackBar;
    TabSheet2: TTabSheet;
    LaTempo: TLabel;
    LaSamplerate: TLabel;
    LaPitch: TLabel;
    TbTempo: TTrackBar;
    TbSamplerate: TTrackBar;
    TbPitch: TTrackBar;
    TabSheet3: TTabSheet;
    LaDryMix: TLabel;
    LaWetMix: TLabel;
    LaFeedback: TLabel;
    LaRate: TLabel;
    LaRange: TLabel;
    LaFreq: TLabel;
    TbDryMix: TTrackBar;
    TbWetMix: TTrackBar;
    TbFeedback: TTrackBar;
    TbRate: TTrackBar;
    TbRange: TTrackBar;
    TbFreq: TTrackBar;
    CbPhaser: TCheckBox;
    Bevel1: TBevel;
    PbWave: TPaintBox;
    CbNormalisieren: TCheckBox;
    procedure BtnLoadClick(Sender: TObject);
    procedure BtnLoadPlayClick(Sender: TObject);
    procedure BtnPlayClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure BtnPauseClick(Sender: TObject);
    procedure TrackBarPositionChange(Sender: TObject);
    procedure TrackBarVolumeChange(Sender: TObject);
    procedure CbEchoClick(Sender: TObject);
    procedure CbFlangeClick(Sender: TObject);
    procedure CbRotateClick(Sender: TObject);
    procedure TrackBarBalanceChange(Sender: TObject);
    procedure TbReverbChange(Sender: TObject);
    procedure TbTempoChange(Sender: TObject);
    procedure TbSamplerateChange(Sender: TObject);
    procedure TbPitchChange(Sender: TObject);
    procedure CbPhaserClick(Sender: TObject);
    procedure TbDryMixChange(Sender: TObject);
    procedure TbWetMixChange(Sender: TObject);
    procedure TbFeedbackChange(Sender: TObject);
    procedure TbRateChange(Sender: TObject);
    procedure TbRangeChange(Sender: TObject);
    procedure TbFreqChange(Sender: TObject);
    procedure TbEchoChange(Sender: TObject);
    procedure TbRotateChange(Sender: TObject);
    procedure BtnCrossfadingClick(Sender: TObject);
    procedure CoCrossfadingChange(Sender: TObject);
    procedure PbWavePaint(Sender: TObject);
    procedure CbCrossfadingClick(Sender: TObject);
    procedure CbNormalisierenClick(Sender: TObject);
  private
    { Private-Deklarationen }
    _BassChannel:TBassChannel;
    _Bezeichnung:string;
    _PlayFormListFlag: boolean;
    _noAwnChangePos: boolean;
    _FrameEquiliser:TFrameEquiliser;
    _Crossfading:boolean;
    procedure UpdateTimeEvent(BassChannel:TBassChannel);
    procedure UpdateWave(BassChannel:TBassChannel);
    procedure Schalter_aktualisieren;
    procedure doCrossfading(manuell:boolean);
    procedure OnLoad(BassChannel:TBassChannel);
  public
    { Public-Deklarationen }
    constructor create(AOwner:TComponent;
                       Bezeichnung:string;
                       BassChannel:TBassChannel;
                       Equiliser:TBassEquiliser); reintroduce;
    procedure ClearCrossfadingList;
    procedure AddToCrossfadingList(ChannelBez:string; BassChannel:TBassChannel);
    procedure Vollbild;
    property BassChannel:TBassChannel read _BassChannel;
    property Bezeichnung:string read _Bezeichnung;
  end;

implementation

{$R *.dfm}
uses LiedU;

{ TFrameChannel }

constructor TFrameChannel.create(AOwner: TComponent;
                                 Bezeichnung:string;
                                 BassChannel:TBassChannel;
                                 Equiliser:TBassEquiliser);
var BassEqulisierReverb:TBassEqulisierReverb;
begin
  inherited create(AOwner);
  Self.Name:=BassChannel.Name;
  GbChannel.Caption:=Bezeichnung;
  LaUp.Parent.DoubleBuffered:=true;
  LaDown.Parent.DoubleBuffered:=true;
  BassChannel.OnLoad:=OnLoad;
  _Bezeichnung:=Bezeichnung;
  _FrameEquiliser:=TFrameEquiliser.create(Self, Equiliser);
  _FrameEquiliser.Parent:=PaEquiliser;
  _FrameEquiliser.Align:=alClient;

  _BassChannel:=BassChannel;
  _BassChannel.OnUpdateTimeEvent:=UpdateTimeEvent;
  _BassChannel.OnUpdateWaveEvent:=UpdateWave;

  _BassChannel.Equiliser.addSpecialFunktion(TBassEqulisierEcho.create);
  _BassChannel.Equiliser.addSpecialFunktion(TBassEqulisierRotate.create);
  _BassChannel.Equiliser.addSpecialFunktion(TBassEqulisierFlanger.create);
  BassEqulisierReverb:=TBassEqulisierReverb.create;
  BassEqulisierReverb.Enable:=true;
  _BassChannel.Equiliser.addSpecialFunktion(BassEqulisierReverb);

  _Crossfading:=false;

  TrackBarVolume.Position := BassChannel.Volume;
  TbTempo.Min:=low(TBassTempo);
  TbTempo.Max:=high(TBassTempo);
  TbTempo.Position:=_BassChannel.Tempo;
  ClearCrossfadingList;
  PbWave.Parent.DoubleBuffered := true;
end;

procedure TFrameChannel.BtnLoadClick(Sender: TObject);
begin
  BtnLoad.Enabled:=false;
  if not _BassChannel.LoadNextLied then
    MessageDlg('Kein Lied in der Playlist', mtError, [mbOK], 0);
end;

procedure TFrameChannel.BtnLoadPlayClick(Sender: TObject);
begin
  BtnLoadPlay.Enabled:=false;
  if _BassChannel.LoadNextLied then
    _BassChannel.Play
  else
    MessageDlg('Kein Lied in der Playlist', mtError, [mbOK], 0);
end;

procedure TFrameChannel.BtnPlayClick(Sender: TObject);
begin
  _Crossfading:=false;
  _BassChannel.Play;
  TrackBarPosition.Max :=
    _BassChannel.SongTimeInfo[SongTimeLength].asMilliSecInteger;
end;

procedure TFrameChannel.BtnStopClick(Sender: TObject);
begin
  _BassChannel.Stop;
  _PlayFormListFlag := False;
end;

procedure TFrameChannel.BtnPauseClick(Sender: TObject);
begin
  _BassChannel.Pause;
end;

procedure TFrameChannel.TrackBarPositionChange(Sender: TObject);
begin
  if _noAwnChangePos then
    _noAwnChangePos := False
  else
    _BassChannel.MilliSecPosition := TrackBarPosition.Position;
end;

procedure TFrameChannel.TrackBarVolumeChange(Sender: TObject);
begin
  _BassChannel.Volume := TrackBarVolume.Position;
  VolLabel.Caption := Format('Volume: %d %%', [_BassChannel.Volume]);
end;

procedure TFrameChannel.CbEchoClick(Sender: TObject);
var Funktion:TBassEquiliserCustomSpecialFunktion;
begin
  if _BassChannel.Equiliser.SpecialFunktion.GetFunktion('Echo', Funktion) then
    Funktion.Enable:=CbEcho.Checked;
end;

procedure TFrameChannel.CbFlangeClick(Sender: TObject);
var Funktion:TBassEquiliserCustomSpecialFunktion;
begin
  if _BassChannel.Equiliser.SpecialFunktion.GetFunktion('Flanger', Funktion) then
    Funktion.Enable:=CbFlange.Checked;
end;

procedure TFrameChannel.CbRotateClick(Sender: TObject);
var Funktion:TBassEquiliserCustomSpecialFunktion;
begin
  if _BassChannel.Equiliser.SpecialFunktion.GetFunktion('Rotate', Funktion) then
    Funktion.Enable:=CbRotate.Checked;
end;

procedure TFrameChannel.TbReverbChange(Sender: TObject);
var Funktion:TBassEquiliserCustomSpecialFunktion;
begin
  if _BassChannel.Equiliser.SpecialFunktion.GetFunktion('Reverb', Funktion) then
    TBassEqulisierReverb(Funktion).Level:=20 - TbReverb.Position;
end;

procedure TFrameChannel.TbEchoChange(Sender: TObject);
var Funktion:TBassEquiliserCustomSpecialFunktion;
begin
  if _BassChannel.Equiliser.SpecialFunktion.GetFunktion('Echo', Funktion) then
    TBassEqulisierEcho(Funktion).Length:=TbEcho.Position;
end;

procedure TFrameChannel.TbRotateChange(Sender: TObject);
var Funktion:TBassEquiliserCustomSpecialFunktion;
begin
  if _BassChannel.Equiliser.SpecialFunktion.GetFunktion('Rotate', Funktion) then
    TBassEqulisierRotate(Funktion).Time:=TbRotate.Position;
end;

procedure TFrameChannel.UpdateTimeEvent(BassChannel: TBassChannel);
var Status:TBassPlayerStatus;
    Lied:TLied;
    Complete:boolean;
begin
  _noAwnChangePos := True;
  TrackBarPosition.Position := BassChannel.MilliSecPosition;
  LaUp.Caption := BassChannel.SongTimeInfo[SongTimeUp].asMilliSecString;
  LaDown.Caption := BassChannel.SongTimeInfo[SongTimeDown].asMilliSecString;
  Lied:=_BassChannel.Lied;
  if assigned(Lied) then
    EdLied.Text:=Lied.Interpret + ' - ' +  Lied.Titel
  else
    EdLied.Text:='';
  Status:=BassChannel.Status;
  case Status of
    sndNotLoaded: LaStatus.Caption := '- Unload -';
    sndSTOPPED:   LaStatus.Caption := '- Stop -';
    sndPLAYING:   begin
                    LaStatus.Caption := '- Play -';
                    if CbCrossfading.Checked then
                      if not _Crossfading and BassChannel.isFadeOutPosition then
                        doCrossfading(false);
                  end;
    sndSTALLED:   LaStatus.Caption := '- Stall -';
    sndPAUSED :   LaStatus.Caption := '- Pause -';
  end;
  if Status <> sndPlaying then
    _Crossfading:=false;
  Complete:=BassChannel.isComplete or (Status = sndNotLoaded);
  BtnLoadPlay.Enabled:=Complete;
  BtnLoad.Enabled:=Complete;
  BtnPlay.Enabled:=    ((Status = sndStopped) or (Status = sndPaused))
                   and not (Status = sndNotLoaded);
  BtnStop.Enabled:=    ((Status = sndPlaying) or (Status = sndPaused))
                   and not (Status = sndNotLoaded);
  BtnPause.Enabled:=(Status = sndPlaying) and not (Status = sndNotLoaded);
  TrackBarVolume.Position:=_BassChannel.Volume;
  Schalter_aktualisieren;
end;

procedure TFrameChannel.UpdateWave(BassChannel: TBassChannel);
begin
  PbWave.Repaint;
end;

procedure TFrameChannel.TrackBarBalanceChange(Sender: TObject);
begin
  _BassChannel.Balance:=TrackBarBalance.Position;
end;

procedure TFrameChannel.TbTempoChange(Sender: TObject);
begin
  LaTempo.Caption :=
    'Tempo = ' + IntToStr(TbTempo.Position) + '%';
  _BassChannel.Tempo:=TbTempo.Position;
end;

procedure TFrameChannel.TbSamplerateChange(Sender: TObject);
begin
  LaSamplerate.Caption :=
    'Samplerate = ' + IntToStr(TbSamplerate.Position) + 'Hz';
  _BassChannel.Samplerate:=TbSamplerate.Position;
end;

procedure TFrameChannel.TbPitchChange(Sender: TObject);
begin
  LaPitch.Caption :=
    'Pitch Scaling = ' + IntToStr(TbPitch.Position) + 'semitones';
  _BassChannel.Pitch:=TbPitch.Position;
end;

procedure TFrameChannel.CbPhaserClick(Sender: TObject);
begin
  _BassChannel.Phaser:=CbPhaser.Checked;
end;

procedure TFrameChannel.TbDryMixChange(Sender: TObject);
begin
  _BassChannel.PhaserDryMix:=TbDryMix.Position; 
end;

procedure TFrameChannel.TbWetMixChange(Sender: TObject);
begin
  _BassChannel.PhaserWetMix:=TbWetMix.Position;
end;

procedure TFrameChannel.TbFeedbackChange(Sender: TObject);
begin
  _BassChannel.PhaserFeedback:=TbFeedback.Position;
end;

procedure TFrameChannel.TbRateChange(Sender: TObject);
begin
  _BassChannel.PhaserRate:=TbRate.Position;
end;

procedure TFrameChannel.TbRangeChange(Sender: TObject);
begin
  _BassChannel.PhaserRange:=TbRange.Position;
end;

procedure TFrameChannel.TbFreqChange(Sender: TObject);
begin
  _BassChannel.PhaserFreq:=TbFreq.Position;
end;

procedure TFrameChannel.AddToCrossfadingList(ChannelBez: string;
  BassChannel: TBassChannel);
begin
  CoCrossfading.Items.AddObject(ChannelBez, BassChannel);
  CoCrossfading.ItemIndex:=0;
  CbCrossfading.Checked:=BassChannel.FadeAuto;
  Schalter_aktualisieren;
end;

procedure TFrameChannel.ClearCrossfadingList;
begin
  CoCrossfading.Items.Clear;
  CoCrossfading.ItemIndex:=-1;
  Schalter_aktualisieren;
end;

procedure TFrameChannel.Schalter_aktualisieren;
var Channel:TObject;
    isComplete:boolean;
begin
  CoCrossfading.Enabled:=(CoCrossfading.Items.Count > 0);
  CbCrossfading.Enabled:=(CoCrossfading.ItemIndex >= 0);
  isComplete:=false;
  if CoCrossfading.ItemIndex >= 0 then begin
    Channel:=CoCrossfading.Items.Objects[CoCrossfading.ItemIndex];
    if Channel is TBassChannel then
      isComplete:=TBassChannel(Channel).isComplete;
  end;
  BtnCrossfading.Enabled:=     (CoCrossfading.ItemIndex >= 0)
                           and BassChannel.isFadingOK
                           and isComplete;

  if not CbCrossfading.Enabled then
    CbCrossfading.Checked:=false;
end;

procedure TFrameChannel.BtnCrossfadingClick(Sender: TObject);
begin
  doCrossfading(true);
end;

procedure TFrameChannel.CoCrossfadingChange(Sender: TObject);
begin
  Schalter_aktualisieren;
end;

procedure TFrameChannel.doCrossfading(manuell:boolean);
var Channel:TObject;
begin
  if CoCrossfading.ItemIndex >= 0 then begin
    Channel:=CoCrossfading.Items.Objects[CoCrossfading.ItemIndex];
    if Channel is TBassChannel then begin
      _Crossfading:=true;
      TBassChannel(Channel).doFadingIn(25);
      BassChannel.FadeStop:=not manuell;
      BassChannel.FadeTime:=3;
      BassChannel.doFadingOut;
      BassChannel.FadeTime:=2;
    end;
  end;
end;

procedure TFrameChannel.PbWavePaint(Sender: TObject);
begin
  _BassChannel.GetWavePicture(PbWave.Canvas, PbWave.Width, PbWave.Height);
end;

procedure TFrameChannel.CbCrossfadingClick(Sender: TObject);
begin
  _BassChannel.FadeAuto:=CbCrossfading.Checked;
end;

procedure TFrameChannel.OnLoad(BassChannel:TBassChannel);
begin
  TbSamplerate.Min:=_BassChannel.SamplerateMin;
  TbSamplerate.Max:=_BassChannel.SamplerateMax;
  TbSamplerate.Position:=_BassChannel.Samplerate;
  TbSamplerate.PageSize:=round(_BassChannel.Samplerate * 0.01); // by 1%
  TrackBarPosition.Max :=
    _BassChannel.SongTimeInfo[SongTimeLength].asMilliSecInteger;
  _Crossfading:=false;
  _BassChannel.Equiliser.Start;
  VolLabel.Caption := Format('Volume: %d %%', [_BassChannel.Volume]);
end;

procedure TFrameChannel.CbNormalisierenClick(Sender: TObject);
begin
  BassChannel.Normalisieren:=CbNormalisieren.Checked;
end;

procedure TFrameChannel.Vollbild;
begin
end;

end.
