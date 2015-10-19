{******************************************************************************}
{                                                                              }
{ Version 2.4 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit InterpretU;

interface

uses ComCtrls, Classes, SysUtils, LiedU;

type
  TInterpret = class
  private
    _Bezeichnung:string;
    _Lieder:TList;
    function GetItem(index: integer): TLied;
  public
    constructor create(Bezeichnung:string);
    destructor destroy; override;
    procedure addLied(Lied:TLied);
    function Count:integer;
    function isFileIn(Dateiname:string): boolean;
    function GetNextLied:TLied;
    procedure GetTree(Node:TTreeNode; Tree:TTreeView);
    procedure speichern(Dateiname:string; const Datei:TextFile);
    property Bezeichnung:string read _Bezeichnung;
    property Item[index:integer]:TLied read GetItem;
  end;

implementation

{ TInterpret }

constructor TInterpret.create(Bezeichnung:string);
begin
  _Lieder:=TList.Create;
  _Bezeichnung:=Bezeichnung;
end;

destructor TInterpret.destroy;
var i:integer;
begin
  for i:=1 to _Lieder.Count do
    TList(_Lieder.Items[i-1]).free;
  _Lieder.free;
  inherited;
end;

procedure TInterpret.addLied(Lied:TLied);
begin
  if not isFileIn(Lied.Dateiname) then
    _Lieder.Add(Lied);
end;

function TInterpret.Count: integer;
begin
  Result:=_Lieder.Count;
end;

function TInterpret.GetItem(index: integer): TLied;
begin
  Result:=_Lieder[index];
end;

procedure TInterpret.GetTree(Node:TTreeNode; Tree:TTreeView);
var i:integer;
    Lied:TLied;
begin
  for i:=1 to _Lieder.Count do begin
    Lied:=_Lieder.Items[i-1];
    Tree.Items.AddChildObject(Node, Lied.Bezeichnung, Lied);
  end;
end;

function TInterpret.isFileIn(Dateiname:string): boolean;
var i:integer;
    abbruch:boolean;
begin
  abbruch:=false;
  if Dateiname <> '' then begin
    i:=0;
    while (i < _Lieder.Count) and not abbruch do begin
      abbruch:=(TLied(_Lieder.Items[i]).Dateiname = Dateiname);
      if not abbruch then
        inc(i);
    end;
  end;
  Result:=abbruch;
end;

function TInterpret.GetNextLied: TLied;
begin
  if _Lieder.Count > 0 then
    Result:=_Lieder[random(_Lieder.Count)]
  else
    Result:=nil;
end;

procedure TInterpret.speichern(Dateiname:string; const Datei:TextFile);
var i:integer;
    Lied:TLied;
begin
  for i:=1 to _Lieder.Count do begin
    Lied:=_Lieder.Items[i-1];
    if assigned(Lied) then
      Lied.speichern(Dateiname, Datei);
  end;
end;

initialization
randomize;
end.
