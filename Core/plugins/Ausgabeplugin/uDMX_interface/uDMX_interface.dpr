library uDMX_interface;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas',
  main in 'main.pas' {Mainform},
  LibUSB in 'LibUSB.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  mainform:=tmainform.create(Application);
  mainform.uDMXTimer.Enabled:=true;
end;

procedure DLLStart;stdcall;
begin
  mainform.Startup;
end;

function DLLDestroy:boolean;stdcall;
begin
  mainform.uDMXTimer.Enabled:=false;
  mainform.Release;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('uDMX Interface und kompatibel (z.B. LIXADA)');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.2');
end;

procedure DLLConfigure;stdcall;
begin
  mainform.showmodal;
end;

procedure DLLAbout;stdcall;
begin
  about:=Tabout.create(nil);
  about.showmodal;
  about.release;
end;

procedure DLLSenddata(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
  // Here you can add your code to output the data to everywhere you want (only Start- and Endvalue will be sent! Use DLLSendMessage to get the channelvalues during dimming)
end;

function DLLIsSending:boolean;stdcall;
begin
  // preserves a feedback, if the current plugin is sending data
	result:=mainform.issending;
  mainform.issending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  // called on every MSG-Event
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      mainform.Channelvalues[Integer(Data1)]:=Integer(Data2);
      if Data1<=mainform.maxchans then
        mainform.sendvalues:=true;
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
