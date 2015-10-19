{******************************************************************************}
{                                                                              }
{ Version 2.4 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit PlaylistU;

interface

uses Classes, SysUtils, ComCtrls, InterpretU, MPGTools, BassTypenU, LiedU;

type
  TPlaylist = class
  private
    _Interpret:TList;
    _MpegAudio:TMpegAudio;
  public
    constructor create;
    destructor destroy; override;
    procedure addDatei(Dateiname, Infos:string);
    procedure sort;
    function FindInterpret(Bezeichnung:string;
                           var Interpret:TInterpret):boolean;
    procedure GetTree(Tree:TTreeView);
    function GetLiedEvent(var Lied:TLied):boolean;
    function GetFileEvent(var Dateiname:string):boolean;
    function GetNextInterpret:TInterpret;
    function laden(Dateiname:string):boolean;
    procedure speichern(Dateiname:string);
    function Umlaute(Text:string):string;
  end;

implementation

{ TPlaylist }

constructor TPlaylist.create;
begin
  _Interpret:=TList.Create;
  _MpegAudio:=TMpegAudio.create;
end;

destructor TPlaylist.destroy;
var i:integer;
begin
  _MpegAudio.free;
  for i:=1 to _Interpret.Count do
    TInterpret(_Interpret.Items[i-1]).free;
  _Interpret.free;
  inherited;
end;

procedure TPlaylist.addDatei(Dateiname, Infos: string);
var Interpret:TInterpret;
    Lied:TLied;
begin
  Lied:=TLied.create(Dateiname, Infos, _MpegAudio);
  if not FindInterpret(Lied.Interpret, Interpret) then begin
    Interpret:=TInterpret.create(Lied.Interpret);
    _Interpret.Add(Interpret);
  end;
  Interpret.addLied(Lied);
end;

function TPlaylist.FindInterpret(Bezeichnung:string;
                                 var Interpret: TInterpret): boolean;
var i:integer;
    abbruch:boolean;
begin
  abbruch:=false;
  if Bezeichnung <> '' then begin
    Bezeichnung:=lowercase(Bezeichnung);
    i:=0;
    while (i < _Interpret.Count) and not abbruch do begin
      abbruch:=
        (lowercase(TInterpret(_Interpret.Items[i]).Bezeichnung) = Bezeichnung);
      if not abbruch then
        inc(i);
    end;
    if abbruch then
      Interpret:=TInterpret(_Interpret.Items[i]);
  end;
  Result:=abbruch;
end;

function TPlaylist.Umlaute(Text:string):string;
begin
  Text:=lowercase(Text);
  Text:=StringReplace(Text, 'ä', 'ae', [rfReplaceAll, rfIgnoreCase]);
  Text:=StringReplace(Text, 'ü', 'ue', [rfReplaceAll, rfIgnoreCase]);
  Text:=StringReplace(Text, 'ö', 'oe', [rfReplaceAll, rfIgnoreCase]);
  Text:=StringReplace(Text, 'ß', 'ss', [rfReplaceAll, rfIgnoreCase]);
  Result:=Text;
end;

procedure TPlaylist.sort;

  function Compare(Item1, Item2: Pointer): Integer;
  var Bez1, Bez2:string;
  begin
    Bez1:=Umlaute(TInterpret(Item1).Bezeichnung);
    Bez2:=Umlaute(TInterpret(Item2).Bezeichnung);
    if Bez1 < Bez2 then
      Result:=-1
    else if Bez1 > Bez2 then
      Result:=1
    else
      Result:=0;
  end;

begin
  _Interpret.Sort(@Compare);
end;

procedure TPlaylist.GetTree(Tree: TTreeView);
var i:integer;
    Interpret:TInterpret;
    ABCNode, Node:TTreeNode;
    oldABC, ABC:char;
begin
  sort;
  Tree.Items.BeginUpdate;
  Tree.Items.Clear;
  ABCNode:=nil;
  oldABC:=' ';
  for i:=1 to _Interpret.Count do begin
    Interpret:=_Interpret.Items[i-1];
    if Interpret.Bezeichnung <> '' then begin
      ABC:=upcase(Umlaute(copy(Interpret.Bezeichnung, 1, 1))[1]);
      if ABC in ['A'..'Z'] then begin
        if ABC <> oldABC then begin
          ABCNode:=Tree.Items.AddChild(nil, ABC);
          oldABC:=ABC;
        end;
      end
      else AbcNode:=nil;
    end;
    Node:=Tree.Items.AddChildObject(ABCNode, Interpret.Bezeichnung, Interpret);
    Interpret.GetTree(Node, Tree);
  end;
  Tree.Items.EndUpdate;
end;

function TPlaylist.GetLiedEvent(var Lied:TLied):boolean;
var Interpret:TInterpret;
begin
  Result:=false;
  Interpret:=GetNextInterpret;
  if assigned(Interpret) then begin
    Lied:=Interpret.GetNextLied;
    Result:=true;
  end;
end;

function TPlaylist.GetFileEvent(var Dateiname: string): boolean;
var Interpret:TInterpret;
    Lied:TLied;
begin
  Result:=false;
  Interpret:=GetNextInterpret;
  if assigned(Interpret) then begin
    Lied:=Interpret.GetNextLied;
    if assigned(Lied) then begin
      Dateiname:=Lied.Dateiname;
      Result:=true;
    end;
  end;
end;

function TPlaylist.GetNextInterpret: TInterpret;
begin
  if _Interpret.Count > 0 then
    Result:=_Interpret[random(_Interpret.Count)]
  else
    Result:=nil;
end;

function TPlaylist.laden(Dateiname: string):boolean;
var Datei:Textfile;
    Filename, Inhalt, Infos:string;
    Zeile:integer;
    EXTM3U:boolean;
begin
  Result:=true;
  try
    if FileExists(Dateiname) then begin
      assignfile(Datei, Dateiname);
      try
        reset(Datei);
        Zeile:=1;
        EXTM3U:=false;
        Infos:='';
        while not eof(Datei) do begin
          readln(Datei, Inhalt);
          if Zeile = 1 then begin
            EXTM3U:=true;
          end;
          if EXTM3U then begin
            if copy(Inhalt, 1, 8) = '#EXTINF:' then
              Infos:=Inhalt
            else
              Filename:=Inhalt;
          end
          else Filename:=Inhalt;

          if    not EXTM3U
             or (EXTM3U and (copy(Inhalt, 1, 8) <> '#EXTINF:')) then
          begin
            delete(Infos, 1, 8);
            if FileExists(Filename) then
              addDatei(Filename, Infos);
          end;
          inc(Zeile);
        end;
      finally
        closefile(Datei);
      end;
    end;
  except
    Result:=false;
  end;
end;

procedure TPlaylist.speichern(Dateiname: string);
var Datei:Textfile;
    Interpret:TInterpret;
    i:integer;
begin
  assignfile(Datei, Dateiname);
  try
    rewrite(Datei);
    writeln(Datei, '#EXTM3U');
    for i:=1 to _Interpret.Count do begin
      Interpret:=_Interpret.Items[i-1];
      if assigned(Interpret) then
        Interpret.speichern(Dateiname, Datei);
    end;
  finally
    closefile(Datei);
  end;
end;

initialization
randomize;
end.
