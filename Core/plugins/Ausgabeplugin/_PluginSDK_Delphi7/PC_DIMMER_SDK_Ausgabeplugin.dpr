library PC_DIMMER_SDK_Ausgabeplugin;

uses
  Forms,
  Dialogs,
  Classes,
  Windows,
  SysUtils,
  main in 'main.pas' {Main},
  aboutfrm in 'aboutfrm.pas' {About},
  messagesystem in 'messagesystem.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  mainform:=Tmainform.create(Application)
  @mainform.SetDLLValues:=CallbackSetDLLValues; // Lets you set value and fadeintime of a single channel
  @mainform.SetDLLValueEvent:=CallbackSetDLLValueEvent; // Lets you set values in the DataIn Window
  @mainform.SetDLLNames:=CallbackSetDLLNames; // Lets you set a name of a single channel
  @mainform.GetDLLValue:=CallbackGetDLLValue; // Causes the PC_DIMMER to send the current value of this channel
  @mainform.SendMSG:=CallbackSendMessage; // Sends a predefined message (see messagesystem.pas for more informations)
end;

procedure DLLStart;stdcall;
begin
	// DLLStart will be run after the DLLCreate directly.
	// Start some Timers or do something else
end;

function DLLDestroy:boolean;stdcall;
begin
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
  Result := PChar('PC_DIMMER Output-Plugindemo für Delphi');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v0.1');
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
  // Here you can add your code to output the data to everywhere you want (only Start- and Endvalue will be sent! Use DLLSendMessage to get the channelvalues during dimming)
//  showmessage('Dimm Ch '+inttostr(address)+' from '+inttostr(startvalue)+' to '+inttostr(endvalue)+' in '+inttostr(fadetime)+'ms ('+name+')');
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
    MSG_NEW:
    begin
      ShowMessage('MSG_NEW, '+String(Data1));
    end;
    MSG_OPEN:
    begin
      ShowMessage('MSG_OPEN, '+String(Data1));
    end;
    MSG_SAVE:
    begin
      ShowMessage('MSG_SAVE, '+String(Data1));
    end;
    MSG_ACTUALCHANNELVALUE:
    begin
      // Here all values during dimming will be sent. Data1 contains the Channel (1...8192) and Data2 contains the Value (0..255) as Integer.
      try
        mainform.label5.caption:='Ch: '+inttostr(Integer(Data1))+', Value: '+inttostr(Integer(Data2));
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
