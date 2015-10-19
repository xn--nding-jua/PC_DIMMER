{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassEquiliserEchoU;

interface

uses BassTypenU, BassDynamicU, BassEquiliserSpecialU;

type
  TBassEchoLength = 0..50000;

  TBassEqulisierEcho = class(TBassEquiliserCustomSpecialFunktion)
    procedure SetEnable(const Value: boolean); override;
  private
    _echbuf: array[TBassEchoLength, 0..1] of Single; // buffer
    _echpos: Integer; // cur.pos
    _echdsp: HDSP; // DSP handle Echo
    _echbuflen:TBassEchoLength;
  public
    constructor create;
    property Length:TBassEchoLength read _echbuflen write _echbuflen; 
  end;

implementation

procedure EchoProcedure(handle: HDSP; Channel: DWORD; buffer: Pointer;
                        length: DWORD; user: DWORD); stdcall;
var a: DWORD;
    d: PSingle;
    l, r: Single;
    BassEqulisierEcho:TBassEqulisierEcho;
begin
  BassEqulisierEcho:=TBassEqulisierEcho(user);
  d := buffer;
  a := 0;
  while (a < (length div 4)) do begin
    l := d^ + (BassEqulisierEcho._echbuf[BassEqulisierEcho._echpos, 1] / 2);
    inc(d);
    r := d^ + (BassEqulisierEcho._echbuf[BassEqulisierEcho._echpos, 0] / 2);
    Dec(d);

    { Basic "bathroom" reverb }
    d^ := l;
    BassEqulisierEcho._echbuf[BassEqulisierEcho._echpos, 0] := l;
    inc(d);
    d^ := r;
    BassEqulisierEcho._echbuf[BassEqulisierEcho._echpos, 1] := r;

    BassEqulisierEcho._echpos := BassEqulisierEcho._echpos + 1;
    if    (BassEqulisierEcho._echpos = high(TBassEchoLength))
       or (BassEqulisierEcho._echpos >= BassEqulisierEcho._echbuflen) then
    begin
      BassEqulisierEcho._echpos := 0;
    end;

    inc(d);
    a := a + 2;
  end;
end;

{ TBassEqulisierEcho }

constructor TBassEqulisierEcho.create;
begin
  inherited;
  _Name:='Echo';
  _echdsp:=0;
  _echbuflen:=1200;
end;

procedure TBassEqulisierEcho.SetEnable(const Value: boolean);
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
      if _echdsp <> 0 then
        BassDll.BASS_ChannelRemoveDSP(Channel, _echdsp);
      FillChar(_echbuf, SizeOf(_echbuf), 0);
      _echpos := 0;
      _echdsp := BassDll.BASS_ChannelSetDSP(
        Channel, @Echoprocedure, INTEGER(Self), 1
      );
    end
    else begin
      BassDll.BASS_ChannelRemoveDSP(Channel, _echdsp);
      _echdsp:=0;
    end;
  end;
end;

end.
