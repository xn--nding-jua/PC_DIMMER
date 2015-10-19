{******************************************************************************}
{                                                                              }
{ Version 2.4 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit LiedU;

interface

uses SysUtils, MPGTools;

type
  TLied = class;
  TGetLiedEvent = function(var Lied:TLied):boolean of object;
  TGetFileEvent = function(var Dateiname:string):boolean of object;
  TMusikInfo = record
                 Lied      : string;
                 Interpret : string;
               end;

  TLied = class
  private
    _Dateiname:string;
    _Interpret:string;
    _Titel:string;
    _SecLaenge:integer;
    function GetBezeichnung: string;
    function FileToMusikInfo(Dateiname: string): TMusikInfo;
    function GetInterpret: string;
  public
    constructor create(Dateiname:string;
                       Infos:string = '';
                       MpegAudio:TMpegAudio = nil); overload;
    constructor create(Lied:TLied); overload;
    procedure speichern(Dateiname:string; const Datei:TextFile);
    property Dateiname:string read _Dateiname;
    property SecLaenge:integer read _SecLaenge write _SecLaenge;
    property Interpret:string read GetInterpret;
    property Titel:string read _titel;
    property Bezeichnung:string read GetBezeichnung;
  end;

implementation

{ TLied }

constructor TLied.create(Dateiname:string;
                         Infos: string;
                         MpegAudio:TMpegAudio);
var Freigabe:boolean;
    p:integer;
begin
  if not assigned(MpegAudio) then begin
    MpegAudio:=TMPEGAudio.Create;
    Freigabe:=true;
  end
  else Freigabe:=false;
  try
    _Dateiname:=Dateiname;
    _Interpret:='';
    if FileExists(Dateiname) then begin
      if Infos = '' then begin
        if lowercase(ExtractFileExt(Dateiname)) = 'mp3' then begin
          MpegAudio.FileName:=Dateiname;
          if     MpegAudio.isTagged
             and (MpegAudio.Artist <> '')
             and (MpegAudio.Title <> '') then
          begin
            _Interpret:=MpegAudio.Artist;
            _Titel:=MpegAudio.Title;
            _SecLaenge:=MpegAudio.Duration;
          end
          else begin
            with FileToMusikInfo(Dateiname) do begin
              _Interpret:=Interpret;
              _Titel:=Lied;
              _SecLaenge:=0;
            end;
          end;
        end
        else begin
          with FileToMusikInfo(Dateiname) do begin
            _Interpret:=Interpret;
            _Titel:=Lied;
            _SecLaenge:=0;
          end;
        end;
      end
      else begin
        p:=pos(',', Infos);
        with FileToMusikInfo(copy(Infos, p+1, length(Infos))) do begin
          _Interpret:=Interpret;
          _Titel:=Lied;
          if not TryStrToInt(copy(Infos, 1, p-1), _SecLaenge) then
            _SecLaenge:=0;
        end;
      end;
    end;
  finally
    if Freigabe then
      MpegAudio.free;
  end;
end;

constructor TLied.create(Lied: TLied);
begin
  _Dateiname:=Lied._Dateiname;
  _Interpret:=Lied._Interpret;
  _Titel:=Lied._Titel;
  _SecLaenge:=Lied._SecLaenge;
end;

function TLied.GetBezeichnung: string;
var str:string;
begin
  str := '';
  if _SecLaenge >= 0 then begin
    if (_SecLaenge mod 60 < 10) then
      str := '0';
    str := str + inttostr(_SecLaenge mod 60);
    str := inttostr(_SecLaenge div 60) + ':' + str;
  end;
  if str <> '' then
    str:=str + ' - ';
  Result:=str + _Titel;
end;

function TLied.FileToMusikInfo(Dateiname: string): TMusikInfo;
var Trenner,Ende:byte;
begin
  Dateiname:=StringReplace(Dateiname, '_', ' ', [rfReplaceAll]);
  Dateiname:=ExtractFilename(Dateiname);
  Ende:=pos('.MP3', uppercase(Dateiname));
  delete(Dateiname, Ende, length(Dateiname)-Ende+1);
  Trenner:=pos(' - ', Dateiname);
  if Trenner = 0 then
    Trenner:=pos('-', Dateiname)
  else
    inc(Trenner);
  with Result do begin
    Interpret:=trim(copy(Dateiname, 1, Trenner-1));
    delete(Dateiname, 1, Trenner);
    Lied:=trim(Dateiname);
  end;
end;

function TLied.GetInterpret: string;
begin
  if _Interpret = '' then
    Result:=' kein Interpret'
  else
    Result:=_Interpret;
end;

procedure TLied.speichern(Dateiname:string; const Datei: TextFile);
var Filename:string;
begin
  Filename:=_Dateiname;
  if ExtractFilePath(_Dateiname) = ExtractFilePath(Dateiname) then
    Filename:=ExtractFilename(_Dateiname);
  writeln(
    Datei,
    '#EXTINF:' + inttostr(_SecLaenge) + ',' + _Interpret + ' - ' + _Titel
  );
  writeln(Datei, Filename);
end;

end.
