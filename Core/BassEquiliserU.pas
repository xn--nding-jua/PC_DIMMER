{******************************************************************************}
{                                                                              }
{ Ur-Autor: Gandalfus (Version 1.00)                                           }
{ Homepage: http://www.blubplayer.de/                                          }
{                                                                              }
{ Edit to Version 1.23 by turboPascal (Matti)                                  }
{ Edit to Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net        }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassEquiliserU;

interface

uses SysUtils, BassTypenU, BassDynamicU, BassEquiliserSpecialU;

type
  TBassEquiliserFrequenz = 1..20000;
  TBassEquiliserBandbreite = 1..10000;
  TBassEquiliserGain = -15 .. 15;
  TBassEquiliserBand = record
                         par: BASS_FXPARAMEQ; // band of eq
                         hnd: HFX;            // band handle
                       end;

  TBassEquiliser = class
  private
    _Band: array of TBassEquiliserBand;
    _Special:TBassEquiliserSpecial;
    _Enabled:boolean;
    _OnChannelInfo:TBassEquiliserGetChannelInfo;
    procedure Remove(Handle:Cardinal);
    procedure Update(BassEquliserBand:TBassEquiliserBand);
    function GetFrequenz(index: integer): TBassEquiliserFrequenz;
    function GetGain(index: integer): TBassEquiliserGain;
    function GetSpecial: TBassEquiliserSpecial;
  public
    constructor create(ChannelInfo:TBassEquiliserGetChannelInfo);
    destructor destroy; override;
    function count:integer;
    procedure Start;
    procedure Stop;
    procedure Init;
    procedure ResetDefaultValues;
    procedure addBand(Frequenz:TBassEquiliserFrequenz;
                      Bandbreite: TBassEquiliserBandbreite;
                      Gain: TBassEquiliserGain);
    procedure delBand(Frequenz:TBassEquiliserFrequenz); overload;
    procedure delBand(Index:integer); overload;
    procedure ClearAllBand;

    procedure SetFrequenzGain(Frequenz:TBassEquiliserFrequenz;
                              Gain:TBassEquiliserGain);
    procedure SetIndexGain(Index:integer; Gain:TBassEquiliserGain);

    procedure addSpecialFunktion(Funktion: TBassEquiliserCustomSpecialFunktion);
    property SpecialFunktion:TBassEquiliserSpecial read GetSpecial;
    property Frequenz[index:integer]: TBassEquiliserFrequenz read GetFrequenz;
    property Gain[index:integer]: TBassEquiliserGain read GetGain;
    property Enabled:boolean read _Enabled;
    property OnChannelInfo:TBassEquiliserGetChannelInfo write _OnChannelInfo;
  end;

implementation

{ TBassEquliserClass }

function TBassEquiliser.count: integer;
begin
  Result:=length(_Band);
end;

constructor TBassEquiliser.create(ChannelInfo:TBassEquiliserGetChannelInfo);
begin
  _Special:=nil;
  _OnChannelInfo:=ChannelInfo;
  _Enabled:=false;
  setlength(_Band, 0);
end;

destructor TBassEquiliser.destroy;
begin
  setlength(_Band, 0);
  if assigned(_Special) then
    _Special.free;
  inherited;
end;

procedure TBassEquiliser.Init;
var i:integer;
    BassDll:TBassDll;
    Channel:HSTREAM;
begin
  if _Enabled then begin
    with _OnChannelInfo do begin
      BassDll:=xBassDll;
      Channel:=xChannel;
    end;
    if assigned(BassDll) then begin
      for i := 1 to length(_Band) do begin
        _Band[i-1].hnd :=
          BassDll.BASS_ChannelSetFX(Channel, BASS_FX_PARAMEQ, 1);
        BassDll.BASS_FXSetParameters(_Band[i-1].hnd, @_Band[i-1].par);
      end;
    end;
  end;
end;

procedure TBassEquiliser.ResetDefaultValues;
var i:integer;
begin
  for i := 1 to length(_Band) do
    _Band[i-1].par.fGain:=0;
end;

procedure TBassEquiliser.Remove(Handle:Cardinal);
var BassDll:TBassDll;
    Channel:HSTREAM;
begin
  with _OnChannelInfo do begin
    BassDll:=xBassDll;
    Channel:=xChannel;
  end;
  if assigned(BassDll) then
    BassDll.BASS_ChannelRemoveFX(Channel, Handle);
end;

procedure TBassEquiliser.Update(BassEquliserBand:TBassEquiliserBand);
var BassDll:TBassDll;
    Channel:HSTREAM;
begin
  if _Enabled then begin
    with _OnChannelInfo do begin
      BassDll:=xBassDll;
      Channel:=xChannel;
    end;
    // Player im stop modus nichts verändern
    if assigned(BassDll) then begin
      if BassDll.BASS_ChannelIsActive(Channel) <> 0 then
        BassDll.BASS_FXSetParameters(
          BassEquliserBand.hnd, @BassEquliserBand.par
        );
    end;
  end;
end;

procedure TBassEquiliser.Start;
begin
  _Enabled:=true;
  Init;
end;

procedure TBassEquiliser.Stop;
var i:integer;
    Band:TBassEquiliserBand;
begin
  for i:=1 to length(_Band) do begin
    Band:=_Band[i-1];
    Band.par.fGain:=0;
    Update(Band);
  end;
  _Enabled:=false;
end;

procedure TBassEquiliser.addBand(Frequenz: TBassEquiliserFrequenz;
                                 Bandbreite: TBassEquiliserBandbreite;
                                 Gain: TBassEquiliserGain);
begin
  setlength(_Band, length(_Band)+1);
  _Band[length(_Band)-1].par.fCenter:=Frequenz;
  _Band[length(_Band)-1].par.fBandwidth:=Bandbreite;
  _Band[length(_Band)-1].par.fGain:=Gain;
  init;
end;

procedure TBassEquiliser.delBand(Frequenz: TBassEquiliserFrequenz);
var i:integer;
    gefunden:boolean;
begin
  gefunden:=false;
  for i:=1 to length(_Band)-1 do begin
    if _Band[i-1].par.fCenter = Frequenz then begin
      gefunden:=true;
      Remove(_Band[i-1].hnd);
    end;
    if gefunden and (i < length(_Band)) then
      _Band[i-1]:=_Band[i];
  end;
  if gefunden then
    setlength(_Band, length(_Band)-1);
end;

procedure TBassEquiliser.delBand(Index: integer);
var i:integer;
begin
  if length(_Band) > 0 then begin
    Remove(_Band[index].hnd);
    for i:=Index+1 to length(_Band)-1 do
      _Band[i-1]:=_Band[i];
    setlength(_Band, length(_Band)-1);
  end;
end;

procedure TBassEquiliser.SetFrequenzGain(Frequenz: TBassEquiliserFrequenz;
  Gain: TBassEquiliserGain);
var i:integer;
    gefunden:boolean;
begin
  gefunden:=false;
  i:=0;
  while (i < length(_Band)) and not gefunden do begin
    if _Band[i].par.fCenter = Frequenz then begin
      gefunden:=true;
      _Band[i].par.fGain:=Gain;
      Update(_Band[i]);
    end;
    inc(i);
  end;
end;

procedure TBassEquiliser.SetIndexGain(Index: integer;
  Gain: TBassEquiliserGain);
begin
  _Band[index].par.fGain:=Gain;
  Update(_Band[index]);
end;

function TBassEquiliser.GetFrequenz(index: integer): TBassEquiliserFrequenz;
begin
  Result:=trunc(_Band[index].par.fCenter);
end;

procedure TBassEquiliser.ClearAllBand;
var i:integer;
begin
  for i:=1 to length(_Band) do
    Remove(_Band[i-1].hnd);
  _Enabled:=false;
end;

function TBassEquiliser.GetGain(index: integer): TBassEquiliserGain;
begin
  Result:=trunc(_Band[index].par.fGain);
end;

function TBassEquiliser.GetSpecial: TBassEquiliserSpecial;
begin
  if not assigned(_Special) then
    _Special:=TBassEquiliserSpecial.create;
  Result:=_Special;
end;

procedure TBassEquiliser.addSpecialFunktion(
  Funktion: TBassEquiliserCustomSpecialFunktion);
begin
  SpecialFunktion.addFunktion(Funktion, _OnChannelInfo);
end;

end.
