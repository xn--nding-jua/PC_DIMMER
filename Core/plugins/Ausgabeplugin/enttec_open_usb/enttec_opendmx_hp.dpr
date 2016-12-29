library enttec_opendmx_hp;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  main in 'main.pas' {Main},
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas',
  D2XXUnit in 'D2XXUnit.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  mainform:=tmainform.create(Application);
  @mainform.RefreshDLLValues:=CallbackSetDLLValues;
  @mainform.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  mainform.ConnectToInterface;
end;

function DLLDestroy:boolean;stdcall;
begin
  try
    mainform.Button4Click(nil);

    mainform.SlowTimer.Enabled:=false;

    Application.ProcessMessages;
    sleep(150);

	  @mainform.RefreshDLLValues:=nil;
    @mainform.RefreshDLLEvent:=nil;

	  mainform.Release;
  except
  end;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Enttec OpenDMX / JMS USB2DMX / eBay-IF');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v5.0');
end;

procedure DLLConfigure;stdcall;
begin
  mainform.ShowModal;
end;

procedure DLLAbout;stdcall;
begin
  about:=tabout.create(nil);
  about.showmodal;
  about.release;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=mainform.issending;
  mainform.issending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if Integer(Data1)<513 then
      begin
        // Data1 = 1..512
        mainform.DMXOutputBuffer[Integer(Data1)]:=Integer(Data2);
        mainform.NewDataForOutput:=true;
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
