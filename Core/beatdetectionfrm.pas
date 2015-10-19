unit beatdetectionfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, BassRecordingU, BassTypenU, BassPlayerExU,
  BassEquiliserU, FrameEquiliserU, ComCtrls, FramePlayListU, FrameChannelU,
  LiedU, BassChannelU, Bass, BassCD, gnugettext;

type
  TEingang = record
               CheckBox:TCheckBox;
               TrackBar:TTrackbar;
             end;

  Tbeatdetectionform = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    GbEingaenge: TGroupBox;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
    _FrameChannel:array of TFrameChannel;
    _BassPlayerEx: TBassPlayerEx;
    _Eingang:array of TEingang;
    _FrameEquiliser:TFrameEquiliser;
    initialized:boolean;
    procedure UpdateTimeEvent(BassPlayerEx: TBassPlayerEx;
                              var ChannelEvent:boolean);
    procedure addChannel(Bezeichnung:string; Volume:TBassVolume);
    procedure delChannel;
  public
    { Public-Deklarationen }
    procedure aktualisieren;
  end;

var
  beatdetectionform: Tbeatdetectionform;

implementation

{$R *.dfm}

procedure Tbeatdetectionform.UpdateTimeEvent(BassPlayerEx: TBassPlayerEx;
                                           var ChannelEvent: boolean);
//var
//  i:integer;
//  play, stop, pause:boolean;
begin
{
  play:=false;
  stop:=false;
  pause:=false;
  for i:=1 to BassPlayerEx.ChannelCount do begin
    case BassPlayerEx.Channel[i-1].Status of
      sndPlaying: play:=true;
      sndStopped: stop:=true;
      sndPaused:  pause:=true;
    end;
  end;
  BtnPlayAll.Enabled:=(stop or pause);
  BtnStopAll.Enabled:=(play or pause);
  BtnPauseAll.Enabled:=play;
  BtnRecordStart.Enabled:=not _BassPlayerEx.Recording.isRecording;
  BtnRecordStop.Enabled:=_BassPlayerEx.Recording.isRecording;
}
  aktualisieren;
end;

procedure Tbeatdetectionform.Button2Click(Sender: TObject);
begin
  _BassPlayerEx.Recording.Stop;
  Button1.Enabled:=true;
  Button2.Enabled:=false;
end;

procedure Tbeatdetectionform.CheckBoxClick(Sender: TObject);
var i, j:integer;
begin
  j:=0;
  for i:=1 to length(_Eingang) do
    if _Eingang[i-1].CheckBox.Checked then
      inc(j);
  if j = 0 then
    TCheckBox(Sender).Checked:=true;
  _BassPlayerEx.Recording.Aktiv[TCheckBox(Sender).Tag]:=
    TCheckBox(Sender).Checked;

  aktualisieren;
end;

procedure Tbeatdetectionform.TrackBarChange(Sender: TObject);
begin
  _BassPlayerEx.Recording.Volume[TTrackBar(Sender).Tag]:=
    TTrackBar(Sender).Position;
end;

procedure Tbeatdetectionform.aktualisieren;
var i:integer;
begin
  for i:=1 to length(_Eingang) do begin
    _Eingang[i-1].CheckBox.OnClick:=nil;
    _Eingang[i-1].CheckBox.Checked:=
      _BassPlayerEx.Recording.Aktiv[i-1];
    _Eingang[i-1].CheckBox.OnClick:=CheckBoxClick;
    _Eingang[i-1].TrackBar.OnChange:=nil;
    _Eingang[i-1].TrackBar.Position:=
      _BassPlayerEx.Recording.Volume[i-1];
    _Eingang[i-1].TrackBar.OnChange:=TrackBarChange;
  end;
end;

procedure Tbeatdetectionform.addChannel(Bezeichnung: string; Volume:TBassVolume);
var FrameChannel:TFrameChannel;
    BassChannel:TBassChannel;
    i, j:integer;
begin
  setlength(_FrameChannel, length(_FrameChannel)+1);

  BassChannel:=_BassPlayerEx.addChannel(Volume);
  BassChannel.Equiliser.addBand(   80, 18, 2);
  BassChannel.Equiliser.addBand(  170, 18, 3);
  BassChannel.Equiliser.addBand(  310, 18, 2);
  BassChannel.Equiliser.addBand(  600, 18, 1);
  BassChannel.Equiliser.addBand( 1000, 18, 0);
  BassChannel.Equiliser.addBand( 3000, 18, 1);
  BassChannel.Equiliser.addBand( 6000, 18, 2);
  BassChannel.Equiliser.addBand(10000, 18, 3);
  BassChannel.Equiliser.addBand(12000, 18, 2);
  BassChannel.Equiliser.addBand(14000, 18, 1);

  FrameChannel:=TFrameChannel.create(Self,
                                     Bezeichnung,
                                     BassChannel,
                                     BassChannel.Equiliser);

  _FrameChannel[length(_FrameChannel)-1]:=FrameChannel;
  for i:=1 to length(_FrameChannel) do begin
    _FrameChannel[i-1].Align:=alNone;
    _FrameChannel[i-1].ClearCrossfadingList;
    for j:=1 to length(_FrameChannel) do
      if _FrameChannel[i-1].BassChannel <> _FrameChannel[j-1].BassChannel then
        _FrameChannel[i-1].AddToCrossfadingList(
          _FrameChannel[j-1].Bezeichnung, _FrameChannel[j-1].BassChannel
        );
  end;
  for i:=length(_FrameChannel) downto 1 do
    _FrameChannel[i-1].Align:=alTop;
end;

procedure Tbeatdetectionform.delChannel;
var i, j:integer;
begin
  _BassPlayerEx.delChannel;
  _FrameChannel[length(_FrameChannel)-1].Free;
  setlength(_FrameChannel, length(_FrameChannel)-1);

  for i:=1 to length(_FrameChannel) do begin
    _FrameChannel[i-1].Align:=alNone;
    _FrameChannel[i-1].ClearCrossfadingList;
    for j:=1 to length(_FrameChannel) do
      if _FrameChannel[i-1].BassChannel <> _FrameChannel[j-1].BassChannel then
        _FrameChannel[i-1].AddToCrossfadingList(
          _FrameChannel[j-1].Bezeichnung, _FrameChannel[j-1].BassChannel
        );
  end;
  for i:=length(_FrameChannel) downto 1 do
    _FrameChannel[i-1].Align:=alTop;
end;

procedure Tbeatdetectionform.FormShow(Sender: TObject);
var
  Liste:TStringList;
  TrackBar:TTrackBar;
  CheckBox:TCheckBox;
  i:integer;
begin
  if not initialized then
  begin
    _BassPlayerEx:=TBassPlayerEx.Create(1, Self);
    _BassPlayerEx.Recording.Canvas:=PaintBox1.Canvas;
    _BassPlayerEx.OnUpdateTimeEvent:=UpdateTimeEvent;
    _BassPlayerEx.TimeUpdateEnable:=true;
    _BassPlayerEx.PaintUpdateEnable:=true;
    _BassPlayerEx.Volume:=60;
    _BassPlayerEx.Recording.Equiliser.addBand(80, 18, 2);
    _BassPlayerEx.Recording.Equiliser.addBand(170, 18, 3);
    _BassPlayerEx.Recording.Equiliser.addBand(310, 18, 2);
    _BassPlayerEx.Recording.Equiliser.addBand(600, 18, 1);
    _BassPlayerEx.Recording.Equiliser.addBand(1000, 18, 0);
    _BassPlayerEx.Recording.Equiliser.addBand(3000, 18, 1);
    _BassPlayerEx.Recording.Equiliser.addBand(6000, 18, 2);
    _BassPlayerEx.Recording.Equiliser.addBand(10000, 18, 3);
    _BassPlayerEx.Recording.Equiliser.addBand(12000, 18, 2);
    _BassPlayerEx.Recording.Equiliser.addBand(14000, 18, 1);

    _FrameEquiliser:=TFrameEquiliser.create(Panel1, _BassPlayerEx.Recording.Equiliser);
    _FrameEquiliser.Parent:=Panel1;
    _FrameEquiliser.Align:=alClient;

    Liste:=TStringList.Create;
    try
      _BassPlayerEx.Recording.GetInputs(Liste);
      setlength(_Eingang, Liste.count);
      for i:=1 to Liste.Count do begin
        CheckBox:=TCheckBox.Create(GbEingaenge);
        CheckBox.Parent:=GbEingaenge;
        CheckBox.Left:=10;
        CheckBox.Top:=(i-1) * (GbEingaenge.Height div (Liste.Count+1)) + 20;
        CheckBox.Caption:=Liste[i-1];
        CheckBox.Tag:=i-1;
        CheckBox.Checked:=_BassPlayerEx.Recording.Aktiv[i-1];
        CheckBox.OnClick:=CheckBoxClick;
        _Eingang[i-1].CheckBox:=CheckBox;

        TrackBar:=TTrackBar.Create(GbEingaenge);
        TrackBar.Parent:=GbEingaenge;
        TrackBar.Top:=(i-1) * (GbEingaenge.Height div (Liste.Count+1)) + 20;
        TrackBar.Left:=150;
        TrackBar.Min:=0;
        TrackBar.Max:=100;
        TrackBar.Width:=GbEingaenge.Width - TrackBar.Left - 10;
        TrackBar.Height:=20;
        TrackBar.ThumbLength:=10;
        TrackBar.Tag:=i-1;
        TrackBar.Position:=_BassPlayerEx.Recording.Volume[i-1];
        TrackBar.OnChange:=TrackBarChange;
        _Eingang[i-1].TrackBar:=TrackBar;
      end;
    finally
      Liste.free;
    end;
    setlength(_FrameChannel, 0);
    addChannel('1. Channel', 100);
    addChannel('2. Channel', 100);
  end;
  initialized:=true;
end;

procedure Tbeatdetectionform.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
  initialized:=false;
end;

procedure Tbeatdetectionform.Button1Click(Sender: TObject);
begin
  _BassPlayerEx.Recording.Start;
  Button1.Enabled:=false;
  Button2.Enabled:=true;
  Timer1.Enabled:=true;
end;

procedure Tbeatdetectionform.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled:=false;
  if initialized then
  begin
    if Button2.Enabled then
      _BassPlayerEx.Recording.Stop;
    _BassPlayerEx.Free;
  end;
end;

procedure Tbeatdetectionform.Timer1Timer(Sender: TObject);
begin
  label3.caption:=inttostr(round(_BassPlayerEx.Recording.fftdata[Trackbar1.Position] * 256 * Trackbar1.Position));
  label1.Caption:=floattostr(_BassPlayerEx.Recording.fftdata[Trackbar1.Position]);
  PaintBox1.Canvas.MoveTo(Trackbar1.Position,Paintbox1.Top);
  PaintBox1.Canvas.LineTo(Trackbar1.Position,Paintbox1.Height);
end;

end.
