{******************************************************************************}
{                                                                              }
{ Version 2.0 by omata (Thorsten) - http://www.delphipraxis.net                }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassEquiliserSpecialU;

interface

uses BassTypenU, BassDynamicU;

type
  TBassEquiliserGetChannelInfoResult = record
                                         xBassDll:TBassDll;
                                         xChannel:HSTREAM;
                                       end;

  TBassEquiliserGetChannelInfo =
    function:TBassEquiliserGetChannelInfoResult of object;

  TBassEquiliserCustomSpecialFunktion = class
  private
  protected
    _OnChannelInfo:TBassEquiliserGetChannelInfo;
    _Name:string;
    _Enable:boolean;
    procedure SetEnable(const Value: boolean); virtual;
  public
    constructor create; reintroduce;
    property Name:string
      read _Name;
    property Enable:boolean
      read _Enable write SetEnable;
    property ChannelInfo:TBassEquiliserGetChannelInfo
      read _OnChannelInfo write _OnChannelInfo;
  end;

  TBassEquiliserSpecial = class
  private
    _Funktion: array of TBassEquiliserCustomSpecialFunktion;
  public
    constructor create;
    destructor destroy; override;
    procedure addFunktion(Funktion:TBassEquiliserCustomSpecialFunktion;
                          ChannelInfo:TBassEquiliserGetChannelInfo);
    procedure delFunktion(Name:string);
    function GetFunktion(
      Name: string;
      var Funktion:TBassEquiliserCustomSpecialFunktion):boolean;
    procedure Refresh;
  end;


implementation

uses SysUtils;

{ TBassEquiliserSpecialCustom }

constructor TBassEquiliserCustomSpecialFunktion.create;
begin
  _Name:='?';
  _Enable:=false;
end;

procedure TBassEquiliserCustomSpecialFunktion.SetEnable(const Value: boolean);
begin
  _Enable := Value;
end;

{ TBassEquiliserSpecial }

procedure TBassEquiliserSpecial.addFunktion(
                                 Funktion: TBassEquiliserCustomSpecialFunktion;
                                 ChannelInfo:TBassEquiliserGetChannelInfo);
var i:integer;
    abbruch:boolean;
begin
  i:=0;
  abbruch:=false;
  while (i < length(_Funktion)) and not abbruch do begin
    abbruch:=(_Funktion[i].Name = Funktion.Name);
    inc(i);
  end;
  if not abbruch then begin
    setlength(_Funktion, length(_Funktion)+1);
    _Funktion[length(_Funktion)-1]:=Funktion;
    Funktion.ChannelInfo:=ChannelInfo;
  end;
end;

constructor TBassEquiliserSpecial.create;
begin
  setlength(_Funktion, 0);
end;

procedure TBassEquiliserSpecial.delFunktion(Name: string);
var i:integer;
    gefunden:boolean;
begin
  gefunden:=false;
  for i:=1 to length(_Funktion) do begin
    if _Funktion[i-1].Name = Name then
      gefunden:=true;
    if gefunden then
      if i < length(_Funktion) then
        _Funktion[i-1]:=_Funktion[i];
  end;
  if gefunden then
    setlength(_Funktion, length(_Funktion)-1);
end;

destructor TBassEquiliserSpecial.destroy;
var i:integer;
begin
  for i:=1 to length(_Funktion) do
    _Funktion[i-1].free;
  inherited;
end;

function TBassEquiliserSpecial.GetFunktion(
                     Name: string;
                     var Funktion:TBassEquiliserCustomSpecialFunktion):boolean;
var i:integer;
    abbruch:boolean;
begin
  Funktion:=nil;
  i:=0;
  abbruch:=false;
  while (i < length(_Funktion)) and not abbruch do begin
    abbruch:=(_Funktion[i].Name = Name);
    if not abbruch then
      inc(i);
  end;
  if abbruch then
    Funktion:=_Funktion[i];
  Result:=abbruch;
end;

procedure TBassEquiliserSpecial.Refresh;
var i:integer;
begin
  for i:=1 to length(_Funktion) do
    _Funktion[i-1].SetEnable(_Funktion[i-1].Enable);
end;

end.
