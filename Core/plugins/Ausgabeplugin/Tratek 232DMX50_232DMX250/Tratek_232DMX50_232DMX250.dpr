library Tratek_232DMX50_232DMX250;

uses
  Forms,
  messagesystem in 'messagesystem.pas',
  aboutfrm in 'aboutfrm.pas' {About};

{$R *.res}

function Start:boolean; stdcall; external 'if32.dll';
function Halt:boolean; stdcall; external 'if32.dll';
function SendToBuffer(Channel: integer; Value: Integer):boolean; stdcall; external 'if32.dll';
function Setup:boolean; stdcall; external 'if32.dll';

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
end;

procedure DLLStart;stdcall;
begin
  Start;
end;

function DLLDestroy:boolean;stdcall;
begin
  Halt;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Tratek 232DMX50/232DMX250');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.0');
end;

procedure DLLConfigure;stdcall;
begin
  Setup;
end;

procedure DLLAbout;stdcall;
begin
  about:=Tabout.create(nil);
  about.showmodal;
  about.release;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      try
        if (Integer(Data1)>0) and (Integer(Data1)<=512) then
          SendToBuffer(Integer(Data1), Integer(Data2));
      except
      end;
    end;
  end;
end;

exports
  DLLCreate,
  DLLStart,
  DLLDestroy,
  DLLIdentify,
  DLLGetVersion,
  DLLGetName,
  DLLAbout,
  DLLConfigure,
  DLLSendData,
  DLLIsSending,
  DLLSendMessage;

begin
end.
