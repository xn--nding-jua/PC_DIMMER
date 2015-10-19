{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassEquiliserRotateU;

interface

uses BassTypenU, BassDynamicU, BassEquiliserSpecialU;

type
  TBassRotateTime = 1..100;

  TBassEqulisierRotate = class(TBassEquiliserCustomSpecialFunktion)
    procedure SetEnable(const Value: boolean); override;
  private
    _rotpos: Single;   // current Pos
    _rotdsp: HDSP; // DSP handle Rotate
    _rottime:TBassRotateTime;
  public
    constructor create;
    property Time:TBassRotateTime read _rottime write _rottime;
  end;

implementation

function fmod(a, b: Single): Single;
begin
  Result := a - (b * Trunc(a / b));
end;

procedure RotateProcedure(handle: HDSP; Channel: DWORD; buffer: Pointer;
                          length: DWORD; user: DWORD); stdcall;
var a: DWORD;
    d: PSingle;
    BassEqulisierRotate:TBassEqulisierRotate;
begin
  BassEqulisierRotate:=TBassEqulisierRotate(user);
  d := buffer;
  a := 0;
  while (a < (length div 4)) do begin
    d^ := d^ * Abs(Sin(BassEqulisierRotate._rotpos));
    Inc(d);
    d^ := d^ * Abs(Cos(BassEqulisierRotate._rotpos));
    BassEqulisierRotate._rotpos :=
        fmod(BassEqulisierRotate._rotpos
      + (BassEqulisierRotate._rottime / 100000), Pi
    );
    Inc(d);
    a := a + 2;
  end;
end;

{ TBassEqulisierRotate }

constructor TBassEqulisierRotate.create;
begin
  inherited;
  _Name:='Rotate';
  _rotdsp:=0;
  _rottime:=3;
end;

procedure TBassEqulisierRotate.SetEnable(const Value: boolean);
var BassDll:TBassDll;
    Channel:HSTREAM;
begin
  inherited;
  if assigned(_OnChannelInfo) then begin
    with _OnChannelInfo do begin
      BassDll:=xBassDll;
      Channel:=xChannel;
    end;
    if assigned(BassDll) then begin
      _Enable := Value;
      if Value then begin
        if _rotdsp <> 0 then
          BassDll.BASS_ChannelRemoveDSP(Channel, _rotdsp);
        _rotpos := 0.7853981;
        _rotdsp := BassDll.BASS_ChannelSetDSP(
          Channel, @RotateProcedure, INTEGER(Self), 2
        );
      end
      else begin
        BassDll.BASS_ChannelRemoveDSP(Channel, _rotdsp);
        _rotdsp:=0;
      end;
    end;
  end;
end;

end.
