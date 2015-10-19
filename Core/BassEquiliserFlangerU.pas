{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassEquiliserFlangerU;

interface

uses BassTypenU, BassDynamicU, BassEquiliserSpecialU;

const
  FLABUFLEN =  350;  // Flangebuffer length

type
  TBassEqulisierFlanger = class(TBassEquiliserCustomSpecialFunktion)
    procedure SetEnable(const Value: boolean); override;
  private
    _flabuf: array[0..FLABUFLEN - 1, 0..1] of Single; // buffer
    _flapos: Integer; // cur.pos
    _flas, _flasinc: Single; // sweep pos/increment
    _fladsp: HDSP; // DSP handle Flange
  public
    constructor create;
  end;

implementation

function fmod(a, b: Single): Single;
begin
  Result := a - (b * Trunc(a / b));
end;

procedure FlangeProcedure(handle: HDSP; Channel: DWORD; buffer: Pointer;
                          length: DWORD; user: DWORD); stdcall;
var a: DWORD;
    d: PSingle;
    f, s: Single;
    p1, p2: Integer;
    BassEqulisierFlanger:TBassEqulisierFlanger;
begin
  BassEqulisierFlanger:=TBassEqulisierFlanger(user);
  d := buffer;

  a := 0;
  while (a < (length div 4)) do begin
    p1 := Trunc(  BassEqulisierFlanger._flapos
                + BassEqulisierFlanger._flas) mod FLABUFLEN;
    p2 := (p1 + 1) mod FLABUFLEN;
    f := fmod(BassEqulisierFlanger._flas, 1);

    s := d^ + (  (BassEqulisierFlanger._flabuf[p1, 0] * (1 - f))
               + (BassEqulisierFlanger._flabuf[p2, 0] * f));
    BassEqulisierFlanger._flabuf[BassEqulisierFlanger._flapos, 0] := d^;
    d^ := s;

    Inc(d);
    s := d^ + (  (BassEqulisierFlanger._flabuf[p1, 1] * (1 - f))
               + (BassEqulisierFlanger._flabuf[p2, 1] * f));
    BassEqulisierFlanger._flabuf[BassEqulisierFlanger._flapos, 1] := d^;
    d^ := s;

    BassEqulisierFlanger._flapos := BassEqulisierFlanger._flapos + 1;
    if (BassEqulisierFlanger._flapos = FLABUFLEN) then
      BassEqulisierFlanger._flapos := 0;

    BassEqulisierFlanger._flas :=   BassEqulisierFlanger._flas
                                  + BassEqulisierFlanger._flasinc;
    if    (BassEqulisierFlanger._flas < 0.0)
       or (BassEqulisierFlanger._flas > FLABUFLEN) then
    begin
      BassEqulisierFlanger._flasinc := -BassEqulisierFlanger._flasinc;
    end;
    Inc(d);
    a := a + 2;
  end;
end;

{ TBassEqulisierFlanger }

constructor TBassEqulisierFlanger.create;
begin
  inherited;
  _Name:='Flanger';
  _fladsp:=0;
end;

procedure TBassEqulisierFlanger.SetEnable(const Value: boolean);
var BassDll:TBassDll;
    Channel:HSTREAM;
begin
  inherited;
  with _OnChannelInfo do begin
    BassDll:=xBassDll;
    Channel:=xChannel;
  end;
  if assigned(BassDll) then begin
    _Enable := Value;
    if Value then begin
      if _fladsp <> 0 then
        BassDll.BASS_ChannelRemoveDSP(Channel, _fladsp);
      FillChar(_flabuf, SizeOf(_flabuf), 0);
      _flapos := 0;
      _flas := FLABUFLEN / 2;
      _flasinc := 0.002;
      _fladsp := BassDll.BASS_ChannelSetDSP(
        Channel, @Flangeprocedure, INTEGER(Self), 0
      );
    end
    else begin
      BassDll.BASS_ChannelRemoveDSP(Channel, _fladsp);
      _fladsp:=0;
    end;
  end;
end;

end.
