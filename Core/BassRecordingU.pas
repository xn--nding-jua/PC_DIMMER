{******************************************************************************}
{                                                                              }
{ Ur-Autor: Gandalfus (Version 1.00)                                           }
{ Homepage: http://www.blubplayer.de/                                          }
{                                                                              }
{ Edit to Version 1.23 by turboPascal (Matti)                                  }
{ Edit to Version 2.0-2.2 by omata (Thorsten) - http://www.delphipraxis.net    }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassRecordingU;

interface

uses Graphics, Windows, Types, Classes, SysUtils, BassDynamicU, BassTypenU,
     BassEquiliserU, BassEquiliserSpecialU, Dialogs;

type
  WAVHdr = packed record
    riff: array[0..3] of char;
    len: DWord;
    cWavFmt: array[0..7] of char;
    dwHdrLen: DWord;
    wFormat: Word;
    wNumChannels: Word;
    dwSampleRate: DWord;
    dwBytesPerSec: DWord;
    wBlockAlign: Word;
    wBitsPerSample: Word;
    cData: array[0..3] of char;
    dwDataLen: DWord;
  end;

  TBassRecording = class
  private
    _BassDll:TBassDll;
    _WaveStream: TFileStream;
    _WaveHdr: WAVHDR; // WAV header
    _RecordChannel: HRECORD; // recording Channel
    _isRecording: Boolean;
    _Canvas:TCanvas;
    _inDateiSchreiben:boolean;
    _Equiliser:TBassEquiliser;
    function GetAktivInputIndex: integer;
    procedure SetAktivInputIndex(Index: integer);
    function GetVolume(InputIndex: cardinal): byte;
    procedure SetVolume(InputIndex:cardinal; Volume: byte);
    function GetAktiv(InputIndex: cardinal): boolean;
    procedure SetAktiv(InputIndex: cardinal; const Value: boolean);
    function GetChannelInfo:TBassEquiliserGetChannelInfoResult;
  public
    fftdata:array[0..1024] of single;
    constructor create(Device:integer; BassDll:TBassDll);
    destructor destroy; override;
    procedure Start(FileName: string = '');
    procedure Stop;
    procedure GetInputs(Inputs: TStrings);
    function GetEquiliser: TBassEquiliser;
    property isRecording:boolean
      read _isRecording;
    property Aktiv[InputIndex:cardinal]:boolean
      read GetAktiv write SetAktiv;
    property AktivInputIndex:integer
      read GetAktivInputIndex write SetAktivInputIndex;
    property Volume[InputIndex:cardinal]:byte
      read GetVolume write SetVolume;
    property inDateiSchreiben:boolean
      read _inDateiSchreiben write _inDateiSchreiben;
    property Canvas:TCanvas
      read _Canvas write _Canvas;
    property Equiliser:TBassEquiliser
      read GetEquiliser;
  end;

implementation

{ TBassRecording }

constructor TBassRecording.create(Device:integer; BassDll:TBassDll);
begin
  _WaveStream:=nil;
  _isRecording := false;
  _BassDll:=BassDll;
  _Canvas:=nil;
  _inDateiSchreiben:=false;
  _Equiliser:=nil;

{
  if Device > 0 then
    dec(Device);

  if not _BassDll.BASS_RecordInit(Device) then
    ShowMessage('Aufnahme kann nicht initialisiert werden');
}
end;

destructor TBassRecording.destroy;
begin
  if _isRecording then
    Stop;
  if assigned(_Equiliser) then
    _Equiliser.free;
  _BassDll.BASS_RecordFree;
  inherited;
end;

// This is called while recording audio
function RecordingCallback(Handle: HRECORD; buffer: Pointer; length,
                           user: DWord): boolean; stdcall;
var
    i:integer;
    BassRecording:TBassRecording;
begin
  BassRecording:=TBassRecording(user);
  // Copy new buffer contents to the memory buffer
  if assigned(BassRecording._WaveStream) then
    BassRecording._WaveStream.Write(buffer^, length);

//  BassRecording._BassDll.BASS_ChannelGetData(Handle, @fft, BASS_DATA_FFT512);
//  BassRecording._BassDll.BASS_ChannelGetData(Handle, @BassRecording.fftdata, BASS_DATA_FFT512);
  BassRecording._BassDll.BASS_ChannelGetData(Handle, @BassRecording.fftdata, BASS_DATA_FFT1024);
  if assigned(BassRecording._Canvas) then begin
    BassRecording._Canvas.lock; //nur mal zur sicherheit ka ob das notwendig ist
    BassRecording._Canvas.Brush.Color := clBlack;
    BassRecording._Canvas.Pen.Color := clBlack;
    BassRecording._Canvas.Rectangle(BassRecording._Canvas.ClipRect);
    BassRecording._Canvas.Pen.Color := clRed;
    BassRecording._Canvas.brush.Color := clRed;
    for i:= 1 to 512 do
    begin
      BassRecording._Canvas.MoveTo(
        i, BassRecording._Canvas.ClipRect.Bottom
      );
      BassRecording._Canvas.LineTo(
        i,   BassRecording._Canvas.ClipRect.Bottom-
        round(BassRecording.fftdata[i] * BassRecording._Canvas.ClipRect.Bottom * i)
      );
    end;
    BassRecording._Canvas.Unlock;
  end;

  // Allow recording to continue
  Result := True;
end;

function TBassRecording.GetAktivInputIndex: integer;
var i: integer;
    abbruch:boolean;
begin
  abbruch:=false;
  Result := -1;
  i := 0;
  while assigned(_BassDll.BASS_RecordGetInputName(i)) and not abbruch do begin
    if (_BassDll.BASS_RecordGetInput(i) and BASS_INPUT_OFF) = 0 then begin
      Result := i;
      abbruch:=true;
    end;
    Inc(i);
  end;
end;

procedure TBassRecording.GetInputs(Inputs: TStrings);
var i: integer;
    dName: PChar;
begin
  i := 0;
  dName := _BassDll.BASS_RecordGetInputName(i);
  while assigned(dName) do begin
    Inputs.Append(StrPas(dName));
    Inc(i);
    dName := _BassDll.BASS_RecordGetInputName(i);
  end;
end;

function TBassRecording.GetVolume(InputIndex: cardinal): byte;
var p:cardinal;
begin
  p:=_BassDll.BASS_RecordGetInput(InputIndex);
  if LoWord(p) > 100 then
    p:=0
  else
    p:=LoWord(p);
  Result:=p;
end;

procedure TBassRecording.SetVolume(InputIndex:cardinal; Volume: byte);
begin
  _BassDll.BASS_RecordSetInput(InputIndex, BASS_INPUT_LEVEL or Volume);
end;

procedure TBassRecording.SetAktivInputIndex(Index: integer);
var i: integer;
begin
  i := 0;
  // first disable all inputs, then...
  while _BassDll.BASS_RecordSetInput(i, BASS_INPUT_OFF) do
    Inc(i);
  // ...enable the selected.
  _BassDll.BASS_RecordSetInput(Index, BASS_INPUT_ON);
end;

procedure TBassRecording.Start(FileName: string);
begin
  if _isRecording then
    Stop;
  //File Stream
  if Filename <> '' then begin
    _WaveStream := TFileStream.Create(FileName, fmCreate);

    // generate header for WAV file
    _WaveHdr.riff := 'RIFF';
    _WaveHdr.len := 36;
    _WaveHdr.cWavFmt := 'WAVEfmt ';
    _WaveHdr.dwHdrLen := 16;
    _WaveHdr.wFormat := 1;
    _WaveHdr.wNumChannels := 2;
    _WaveHdr.dwSampleRate := 44100;
    _WaveHdr.wBlockAlign := 4;
    _WaveHdr.dwBytesPerSec := 176400;
    _WaveHdr.wBitsPerSample := 16;
    _WaveHdr.cData := 'data';
    _WaveHdr.dwDataLen := 0;

    _WaveStream.Write(_WaveHdr, SizeOf(WAVHDR));
  end;
  // start recording @ 44100hz 16-bit stereo
  _RecordChannel := _BassDll.BASS_RecordStart(
    44100, 2, 0, @RecordingCallback, INTEGER(Self)
  );
  if _RecordChannel = 0 then begin
    if assigned(_WaveStream) then
      _WaveStream.Free;
    _WaveStream:=nil;
//    ShowMessage('Aufnahme kann nicht gestartet werden');
  end;
  _isRecording := True;
  if assigned(_Equiliser) then
    _Equiliser.Init;
end;

procedure TBassRecording.Stop;
var i: integer;
begin
  if _isRecording then begin
    _isRecording := false;
    _BassDll.BASS_ChannelStop(_RecordChannel);

    if assigned(_WaveStream) then begin
      // complete the WAV header
      _WaveStream.Position := 4;
      i := _WaveStream.Size - 8;
      _WaveStream.Write(i, 4);
      i := i - $24;
      _WaveStream.Position := 40;
      _WaveStream.Write(i, 4);
      _WaveStream.Position := 0;

      _WaveStream.Free;
      _WaveStream:=nil;
    end;
    if assigned(_Canvas) then begin
      _Canvas.Brush.Color:=clBtnFace;
      _Canvas.FillRect(_Canvas.ClipRect);
    end;
  end;
  if assigned(_Equiliser) then
    _Equiliser.Init;
end;

function TBassRecording.GetAktiv(InputIndex: cardinal): boolean;
begin
  Result:=((_BassDll.BASS_RecordGetInput(InputIndex) and BASS_INPUT_OFF) = 0);
end;

procedure TBassRecording.SetAktiv(InputIndex: cardinal; const Value: boolean);
begin
  _BassDll.BASS_RecordSetInput(InputIndex, BASS_INPUT_ON);
end;

function TBassRecording.GetEquiliser: TBassEquiliser;
begin
  if not assigned(_Equiliser) then
    _Equiliser:=TBassEquiliser.create(GetChannelInfo);
  Result:=_Equiliser;
end;

function TBassRecording.GetChannelInfo: TBassEquiliserGetChannelInfoResult;
begin
  Result.xChannel:=_RecordChannel;
  Result.xBassDll:=_BassDll;
end;

end.
