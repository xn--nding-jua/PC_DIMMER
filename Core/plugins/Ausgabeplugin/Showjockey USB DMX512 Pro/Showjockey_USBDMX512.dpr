library Showjockey_USBDMX512;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  SysUtils,
  main in 'main.pas' {Main},
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas',
  U_Usb in 'U_Usb.pas';

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
  mainform.pVID_PID:='vid_0483&pid_57fe';

  mainform.ConnectDevices;
end;

function DLLDestroy:boolean;stdcall;
begin
  mainform.DisconnectDevices;

  try
    @mainform.SetDLLValues:=nil;
    @mainform.SetDLLValueEvent:=nil;
    @mainform.SetDLLNames:=nil;
    @mainform.GetDLLValue:=nil;
    @mainform.SendMSG:=nil;

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
  Result := PChar('Showjockey USB DMX512');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.1');
end;

procedure DLLConfigure;stdcall;
begin
  mainform.ShowModal;
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
      DMXOUTBuffer[trunc(Integer(Data1)/513)][Integer(Data1)-512*trunc(Integer(Data1)/513)-1]:=Integer(Data2);
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
