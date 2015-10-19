unit PowerButton;

///////////////////////////////////////////////////////////////////////////////////////
//Dies ist eine Komponente um den Powerknopf anzusteuern.
//Eigenschaften:
//PowerOffEnable:boolean
//  >false lässt den Pc nicht mehr herunterfahren
//Ereignisse:
//  OnPowerbuttonpress
//  >Wird ausgeführt wenn der Powerbutton gedrückt wurde
//
//Programmed by CTV => www.ctvnet.ch
//
//Komponente darf frei für alles verwendet werden. Copyright darf nicht entfernt werden
///////////////////////////////////////////////////////////////////////////////////////



interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus, ShellApi, ExtCtrls;

const
  //PBT_APMQUERYSUSPEND       = 536; {Request for permission to suspend.}
  
  WM_POWERBROADCAST               = $0218;

  PBT_APMQUERYSUSPEND             = $0000;
  PBT_APMQUERYSTANDBY             = $0001;

  PBT_APMQUERYSUSPENDFAILED       = $0002;
  PBT_APMQUERYSTANDBYFAILED       = $0003;

  PBT_APMSUSPEND                  = $0004;
  PBT_APMSTANDBY                  = $0005;

  PBT_APMRESUMECRITICAL           = $0006;
  PBT_APMRESUMESUSPEND            = $0007;
  PBT_APMRESUMESTANDBY            = $0008;

  PBTF_APMRESUMEFROMFAILURE       = $00000001;

  PBT_APMBATTERYLOW               = $0009;
  PBT_APMPOWERSTATUSCHANGE        = $000A;

  PBT_APMOEMEVENT                 = $000B;
  PBT_APMRESUMEAUTOMATIC          = $0012;

type

  TPowerButton = class(TComponent)
  private
    FHooked: Boolean;
    FOnPowerbuttonPress : TNotifyEvent;
    FOnPowerBroadCast : TNotifyEvent;
    FOnPower : TNotifyEvent;
    FOnQueryShutdown : TNotifyEvent;
    PPowerOffEnable:Boolean;
    //procedure WMPOWERBROADCAST(var msg: TMessage); message WM_POWERBROADCAST;
    //procedure WMPOWER(var msg: TMessage); message WM_POWER;
    //procedure WMQUERYENDSESSION(var msg: TMessage); message WM_QUERYENDSESSION;
    function MessageHook(var Msg: TMessage): Boolean;
  protected
    procedure DoPowerbuttonPress; dynamic;
    procedure DoPowerBroadCast; dynamic;
    procedure DoPower; dynamic;
    procedure DoQueryShutdown; dynamic;
  public
    Version,Hersteller:string;
    //IResultHi,IResultLo,ILParamHi,ILParamLo,IWParamHi,ILParam,IWParamLo,IWparam,Imsg,IResult:integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    {events}
    property OnPowerbuttonPress: TNotifyEvent read FOnPowerbuttonPress write FOnPowerbuttonPress;
    property OnPowerBroadCast: TNotifyEvent read FOnPowerBroadCast write FOnPowerBroadCast;
    property OnPower: TNotifyEvent read FOnPower write FOnPower;
    property OnQueryShutdown: TNotifyEvent read FOnQueryShutdown write FOnQueryShutdown;
    {properties}
    property PowerOffEnable : boolean read PPowerOffEnable write PPowerOffEnable;

  end;

procedure Register;

implementation

// runonNTEx
// Copyright (c) 1995 - 2002 by -=Assarbad [GoP]=-
// Extended by SCP
function runonNTEx: boolean;
var
  lpVerInfo : TOSVersionInfo;
begin
  FillChar(lpVerInfo, SizeOf(lpVerInfo), 0);
  lpVerInfo.dwOSVersionInfoSize := SizeOf(lpVerInfo);
  GetVersionEx(lpVerInfo);
  result := (lpVerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT);
end;

procedure Register;
begin
  RegisterComponents('System', [TPowerButton]);
end;

constructor TPowerButton.create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Version:='1.0.0.1';
  Hersteller:='CTVNet.ch';
  FOnPowerbuttonPress := nil;
  FOnPowerBroadCast := nil;
  FOnPower := nil;
  FOnQueryShutdown := nil;

  FHooked := False;
  if not (csDesigning in ComponentState) then
  begin
    Application.HookMainWindow(MessageHook);
    FHooked := True;
  end;

end;

destructor TPowerButton.Destroy;
begin
  if FHooked then Application.UnhookMainWindow(MessageHook);
  inherited Destroy;
end;

Procedure TPowerButton.DoPowerbuttonPress;
begin
  if Assigned(FOnPowerbuttonPress) then FOnPowerbuttonPress(Self);
end;

Procedure TPowerButton.DoPowerBroadCast;
begin
  if Assigned(FOnPowerBroadCast) then FOnPowerBroadCast(Self);
  DoPowerbuttonPress;
end;

Procedure TPowerButton.DoPower;
begin
  if Assigned(FOnPower) then FOnPower(Self);
  DoPowerbuttonPress;
end;

Procedure TPowerButton.DoQueryShutdown;
begin
  if Assigned(FOnQueryShutdown) then FOnQueryShutdown(Self);
  DoPowerbuttonPress;
end;
(*
procedure TPowerButton.WMPOWERBROADCAST(var msg: TMessage);
begin
  {
  IResultHi:=msg.ResultHi;
  IResultLo:=msg.ResultLo;
  ILParamHi:=msg.LParamHi;
  ILParamLo:=msg.LParamLo;
  IWParamHi:=msg.WParamHi;
  ILParam:=msg.LParam;
  IWParamLo:=msg.WParamLo;
  Imsg:=msg.Msg;
  IResult:=msg.result;
  IWparam:=msg.WParam;
  }
  if (msg.WParam = PBT_APMQUERYSUSPEND) then
  begin
    if PPowerOffEnable then
      msg.Result := 1
    else
    begin
      If runonNTEx then
        msg.Result := BROADCAST_QUERY_DENY //winNT,2k,XP
      else
        msg.Result := PWR_FAIL; //win95/98
    end;

    DoPowerbuttonPress;
  end;
end;

procedure TPowerButton.WMPOWER(var msg: TMessage);
begin
  DoPower;
end;

procedure TPowerButton.WMQUERYENDSESSION(var msg: TMessage);
begin
  msg.Result := LResult(PPowerOffEnable);
  DoQueryShutdown;
end;
*)

function TPowerButton.MessageHook(var Msg: TMessage): Boolean;
begin
  result := false;
  {
  IResultHi:=msg.ResultHi;
  IResultLo:=msg.ResultLo;
  ILParamHi:=msg.LParamHi;
  ILParamLo:=msg.LParamLo;
  IWParamHi:=msg.WParamHi;
  ILParam:=msg.LParam;
  IWParamLo:=msg.WParamLo;
  Imsg:=msg.Msg;
  IResult:=msg.result;
  IWparam:=msg.WParam;
  }
  if (msg.msg=WM_POWERBROADCAST) and (msg.WParam=PBT_APMQUERYSUSPEND) then
  begin
    if not PPowerOffEnable then
    begin
      result := true;
      If runonNTEx then
        msg.Result := BROADCAST_QUERY_DENY //winNT,2k,XP
      else
        msg.Result := PWR_FAIL; //win95/98
    end;

    DoPowerBroadCast;
  end;

  if (msg.msg=WM_POWER) and (msg.WParam=PWR_SUSPENDREQUEST)  then //excute Event
  begin
    if not PPowerOffEnable then
    begin
      result := true;
      msg.Result := PWR_FAIL;
    end;

    DoPower;
  end;

  if (msg.msg=WM_QUERYENDSESSION) then //excute Event
  begin
    result := true;
    msg.Result := LResult(PPowerOffEnable);
    
    DoQueryShutdown;
  end;
end;


end.


