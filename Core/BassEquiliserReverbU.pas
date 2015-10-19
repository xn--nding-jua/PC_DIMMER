{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassEquiliserReverbU;

interface

uses BassTypenU, BassDynamicU, BassEquiliserSpecialU;

type
  TBassReverbLevel = 0..20;

  TBassEqulisierReverb = class(TBassEquiliserCustomSpecialFunktion)
    procedure SetEnable(const Value: boolean); override;
  private
    _fx:cardinal;
    _fxbuf: BASS_FXREVERB;
    _fxLevel:TBassReverbLevel;
    function GetLevel: TBassReverbLevel;
    procedure SetLevel(const Value: TBassReverbLevel);
  public
    constructor create;
    property Level:TBassReverbLevel read GetLevel write SetLevel;
  end;

implementation

{ TBassEqulisierFlanger }

constructor TBassEqulisierReverb.create;
begin
  inherited;
  _Name:='Reverb';
  _fxLevel:=20;
  _fx:=0;
end;

procedure TBassEqulisierReverb.SetLevel(const Value: TBassReverbLevel);
var BassDll:TBassDll;
begin
  _fxLevel:=Value;
  if assigned(_OnChannelInfo) then begin
    with _OnChannelInfo do
      BassDll:=xBassDll;
    if assigned(BassDll) then begin
      if _Enable then begin
        BassDll.BASS_FXGetParameters(_fx, @_fxbuf);
        // gives -96 when bar at 20
        _fxbuf.fReverbMix := -0.012*value*value*value;
        BassDll.BASS_FXSetParameters(_fx, @_fxbuf);
      end;
    end;
  end;
end;

function TBassEqulisierReverb.GetLevel: TBassReverbLevel;
begin
  Result:=_fxLevel;
end;

procedure TBassEqulisierReverb.SetEnable(const Value: boolean);
var BassDll:TBassDll;
    Channel:HSTREAM;
begin
  inherited;
  _Enable := Value;
  if assigned(_OnChannelInfo) then begin
    with _OnChannelInfo do begin
      BassDll:=xBassDll;
      Channel:=xChannel;
    end;
    if assigned(BassDll) then begin
      _Enable := Value;
      if Value then begin
        if _fx <> 0 then
          BassDll.BASS_ChannelRemoveFX(Channel, _fx);
        _fx := BassDll.BASS_ChannelSetFX(Channel, BASS_FX_REVERB, 1);
        BassDll.BASS_FXGetParameters(_fx, @_fxbuf);
        // gives -96 when bar at 20
        _fxbuf.fReverbMix := -0.012*_fxLevel*_fxLevel*_fxLevel;
        _fxbuf.fReverbTime := 1200;
        _fxbuf.fHighFreqRTRatio := 0.1;
        BassDll.BASS_FXSetParameters(_fx, @_fxbuf);
      end
      else begin
        BassDll.BASS_ChannelRemoveFX(Channel, _fx);
        _fx:=0;
      end;
    end;
  end;
end;

end.
