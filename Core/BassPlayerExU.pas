{******************************************************************************}
{                                                                              }
{ Ur-Autor: Gandalfus (Version 1.00)                                           }
{ Homepage: http://www.blubplayer.de/                                          }
{                                                                              }
{ Edit to Version 1.23 by turboPascal (Matti)                                  }
{ Edit to Version 2.0-2.4 by omata (Thorsten) - http://www.delphipraxis.net    }
{ Edit to Version B.3.0 by omata (Thorsten)                                    }
{ Edit to Version B.3.2 by omata (Thorsten)                                    }
{                                                                              }
{******************************************************************************}
unit BassPlayerExU;

interface

uses
  Windows, Forms, StdCtrls, Classes, Graphics, SysUtils, ExtCtrls, MMSystem,
  Messages, Controls, BassDynamicU, BassChannelU, BassRecordingU, BassTypenU,
  LiedU, VisPluginCtrl;

resourcestring
  ProductName    = 'BassPlayerEx';
  ProductVersion = 'B.3.2';

type
  TBassPlayerEx = class;
  TBassPlayerUpdateTimer = procedure (BassPlayer: TBassPlayerEx;
                                      var ChannelEvent:boolean) of object;

  TBassPlayerEx = class(TComponent)
  private
    { Private declarations }
    _BassDll:TBassDll;
    _BassChannel:array of TBassChannel;
    _Recording:TBassRecording;
    _GetLiedEvent:TGetLiedEvent;
    _GetFileEvent:TGetFileEvent;

    _VisControlForm:TVisControlForm;
    _OnBassChannelToVis:TBassChannelToVis;

    _UpdateTimeTimer:TTimer;
    _UpdatePaintTimer:TTimer;
    _OnUpdateTimeTimer:TBassPlayerUpdateTimer;
    _OnUpdatePaintTimer:TBassPlayerUpdateTimer;

    function GetCpuUsage: Single;
    function GetBassChannel(index: integer): TBassChannel;
    function GetUpdateTimeTimerInterval: integer;
    procedure SetUpdateTimeTimerInterval(const Value: integer);
    function GetUpdateTimeTimerEnable: boolean;
    procedure SetUpdateTimeTimerEnable(const Value: boolean);
    procedure UpdateTimeTimer(Sender: TObject);
    procedure UpdatePaintTimer(Sender: TObject);
    procedure DefaultUpdateTimer(BassPlayerEx: TBassPlayerEx;
                                 var ChannelEvent:boolean);
    function DefaultGetLiedEvent(var Lied:TLied):boolean;
    function DefaultGetFileEvent(var Dateiname:string):boolean;
    function GetUpdatePaintTimerEnable: boolean;
    function GetUpdatePaintTimerInterval: integer;
    procedure SetUpdatePaintTimerEnable(const Value: boolean);
    procedure SetUpdatePaintTimerInterval(const Value: integer);
    function GetVolume: TBassVolume;
    procedure SetVolume(const Value: TBassVolume);
    procedure OnBassChannelToVis(BassChannel:TBassChannel;
                                 mustSet:boolean = false);
  public
    { Public declarations }
    constructor Create(Device:integer; AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function ChannelCount:integer;
    function addChannel(Volume:TBassVolume):TBassChannel;
    procedure delChannel;

    procedure ShowVisControlForm;
    function RunVisPlugin(VismodName : string; VismodNo : word) : boolean;
    procedure QuitVisPlugin;

    property Recording:TBassRecording
      read _Recording;
    property Channel[index:integer]:TBassChannel
      read GetBassChannel;
    property CpuUsage: Single
      read GetCpuUsage;
    property OnUpdateTimeEvent:TBassPlayerUpdateTimer
      read _OnUpdateTimeTimer write _OnUpdateTimeTimer;
    property OnUpdatePaintEvent:TBassPlayerUpdateTimer
      read _OnUpdatePaintTimer write _OnUpdatePaintTimer;
  published { Published-Deklarationen }
    property Volume: TBassVolume
      read GetVolume write SetVolume;
    property TimeUpdateInterval:integer
      read GetUpdateTimeTimerInterval write SetUpdateTimeTimerInterval;
    property TimeUpdateEnable:boolean
      read GetUpdateTimeTimerEnable write SetUpdateTimeTimerEnable;
    property PaintUpdateInterval:integer
      read GetUpdatePaintTimerInterval write SetUpdatePaintTimerInterval;
    property PaintUpdateEnable:boolean
      read GetUpdatePaintTimerEnable write SetUpdatePaintTimerEnable;
    property GetLiedEvent:TGetLiedEvent
      read _GetLiedEvent write _GetLiedEvent;
    property GetFileEvent:TGetFileEvent
      read _GetFileEvent write _GetFileEvent;
  end;

implementation

{ TBassPlayerEx }
uses PluginCtrl, VisDrive;

constructor TBassPlayerEx.Create(Device:integer; AOwner: TComponent);
begin
  inherited Create(AOwner);
  _BassDll:=TBassDll.create;
  _GetLiedEvent:=DefaultGetLiedEvent;
  _GetFileEvent:=DefaultGetFileEvent;

  _VisControlForm:=TVisControlForm.create(AOwner, _BassDll);
  _OnBassChannelToVis:=OnBassChannelToVis;

  _UpdateTimeTimer:=TTimer.Create(Self);
  _UpdateTimeTimer.Interval:=250;
  _UpdateTimeTimer.Enabled:=false;
  _UpdateTimeTimer.OnTimer:=UpdateTimeTimer;
  _OnUpdateTimeTimer:=DefaultUpdateTimer;

  _UpdatePaintTimer:=TTimer.Create(Self);
  _UpdatePaintTimer.Interval:=55;
  _UpdatePaintTimer.Enabled:=false;
  _UpdatePaintTimer.OnTimer:=UpdatePaintTimer;
  _OnUpdatePaintTimer:=DefaultUpdateTimer;

  setlength(_BassChannel, 0);

{
  if _BassDll.BASS_GetVersion() <> dword(MAKELONG(2, 3)) then
    raise Exception.Create('Falsche Version der bass.dll (benötigt wird 2.2)');
}

  _BassDll.BASS_SetConfig(BASS_CONFIG_FLOATDSP, 1);

{
  if not _BassDll.BASS_Init(Device, 44100, 0, 0, nil) then
    raise Exception.Create('Soundkarte nicht vorhanden');
}

  _Recording:=TBassRecording.create(Device, _BassDll);
end;

destructor TBassPlayerEx.Destroy;
//var i:integer;
begin
//  for i:=1 to length(_BassChannel) do
//    _BassChannel[i-1].free;

  _UpdateTimeTimer.free;
  _UpdatePaintTimer.free;
//  _VisControlForm.free;
//  _Recording.free;
//  _BassDll.free;
  inherited destroy;
end;

function TBassPlayerEx.GetCPUusage: Single;
begin
  Result := _BassDll.BASS_GetCPU;
end;

function TBassPlayerEx.GetBassChannel(index: integer): TBassChannel;
begin
  Result:=_BassChannel[index];
end;

function TBassPlayerEx.ChannelCount: integer;
begin
  Result:=length(_BassChannel);
end;

function TBassPlayerEx.addChannel(Volume:TBassVolume): TBassChannel;
begin
  setlength(_BassChannel, length(_BassChannel)+1);
  Result:=TBassChannel.create('BassChannel'+inttostr(length(_BassChannel)),
                              _OnBassChannelToVis,
                              _BassDll);
  Result.GetLiedEvent:=_GetLiedEvent;
  Result.GetFileEvent:=_GetFileEvent;
  Result.Volume:=Volume;
  _BassChannel[length(_BassChannel)-1]:=Result;
end;

procedure TBassPlayerEx.delChannel;
begin
  _BassChannel[length(_BassChannel)-1].Free;
  setlength(_BassChannel, length(_BassChannel)-1);
end;

function TBassPlayerEx.GetUpdateTimeTimerInterval: integer;
begin
  Result:=_UpdateTimeTimer.Interval;
end;

procedure TBassPlayerEx.SetUpdateTimeTimerInterval(const Value: integer);
begin
  _UpdateTimeTimer.Interval:=Value;
end;

function TBassPlayerEx.GetUpdateTimeTimerEnable: boolean;
begin
  Result:=_UpdateTimeTimer.Enabled;
end;

procedure TBassPlayerEx.SetUpdateTimeTimerEnable(const Value: boolean);
begin
  _UpdateTimeTimer.Enabled:=Value;
end;

procedure TBassPlayerEx.UpdateTimeTimer(Sender: TObject);
var i:integer;
    ChannelEvent:boolean;
begin
  ChannelEvent:=true;
  _OnUpdateTimeTimer(Self, ChannelEvent);
  if ChannelEvent then
    for i:=1 to length(_BassChannel) do
      _BassChannel[i-1].UpdateTime;
end;

procedure TBassPlayerEx.UpdatePaintTimer(Sender: TObject);
var i:integer;
    ChannelEvent:boolean;
begin
  ChannelEvent:=true;
  _OnUpdatePaintTimer(Self, ChannelEvent);
  if ChannelEvent then
    for i:=1 to length(_BassChannel) do
      _BassChannel[i-1].UpdatePaint;
end;

procedure TBassPlayerEx.DefaultUpdateTimer(BassPlayerEx: TBassPlayerEx;
                                           var ChannelEvent:boolean);
begin
end;

function TBassPlayerEx.GetUpdatePaintTimerEnable: boolean;
begin
  Result:=_UpdatePaintTimer.Enabled;
end;

function TBassPlayerEx.GetUpdatePaintTimerInterval: integer;
begin
  Result:=_UpdatePaintTimer.Interval;
end;

procedure TBassPlayerEx.SetUpdatePaintTimerEnable(const Value: boolean);
begin
  _UpdatePaintTimer.Enabled:=Value;
end;

procedure TBassPlayerEx.SetUpdatePaintTimerInterval(const Value: integer);
begin
  _UpdatePaintTimer.Interval:=Value;
end;

function TBassPlayerEx.GetVolume: TBassVolume;
var i:integer;
begin
  i:=_BassDll.BASS_GetVolume;
  if i < 0 then
    i:=0;
  Result:=i;
end;

procedure TBassPlayerEx.SetVolume(const Value: TBassVolume);
begin
  _BassDll.BASS_SetVolume(Value);
end;

function TBassPlayerEx.DefaultGetLiedEvent(var Lied:TLied): boolean;
begin
  Result:=false;
end;

function TBassPlayerEx.DefaultGetFileEvent(var Dateiname: string): boolean;
begin
  Result:=false;
end;

procedure TBassPlayerEx.OnBassChannelToVis(BassChannel: TBassChannel;
                                           mustSet:boolean = false);
begin
  _VisControlForm.SetBassChannel(BassChannel, mustSet);
end;

procedure TBassPlayerEx.ShowVisControlForm;
begin
  _VisControlForm.Show;
end;

procedure TBassPlayerEx.QuitVisPlugin;
begin
  Stop_Vis;
  _VisControlForm.QuitVisPlugin;
end;

function TBassPlayerEx.RunVisPlugin(VismodName: string;
  VismodNo: word): boolean;
begin
  Stop_Vis;
  Result:=_VisControlForm.RunVisPlugin(VismodName, VismodNo);
end;

end.

