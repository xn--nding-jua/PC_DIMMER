library Cypress_USB2DMX;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  main in 'main.pas' {Main},
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  mainform:=tmainform.create(Application);
  @mainform.SetDLLValues:=CallbackSetDLLValues; // Lets you set value and fadeintime of a single channel
  @mainform.SetDLLValueEvent:=CallbackSetDLLValueEvent; // Lets you set values in the DataIn Window
  @mainform.SetDLLNames:=CallbackSetDLLNames; // Lets you set a name of a single channel
  @mainform.GetDLLValue:=CallbackGetDLLValue; // Causes the PC_DIMMER to send the current value of this channel
  @mainform.SendMSG:=CallbackSendMessage; // Sends a predefined message (see messagesystem.pas for more informations)
end;

procedure DLLStart;stdcall;
begin
  mainform.SetTransceiver(true);
end;

function DLLDestroy:boolean;stdcall;
begin
  mainform.SetTransceiver(false);

  try
    @mainform.SetDLLValues:=nil;
    @mainform.SetDLLValueEvent:=nil;
    @mainform.SetDLLNames:=nil;
    @mainform.GetDLLValue:=nil;
    @mainform.SendMSG:=nil;

	  mainform.free;
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
  Result := PChar('Cypress PSoC USB2DMX Interface');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.0');
end;

procedure DLLConfigure;stdcall;
begin
  mainform.ShowModal;
end;

procedure DLLAbout;stdcall;
begin
  about:=tabout.Create(nil);
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
  with mainform do
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if (Data1<=512) then
      begin
        mainform.SetChannel(Data1, Data2);
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
