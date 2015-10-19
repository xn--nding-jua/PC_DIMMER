library Geraetesteuerung;

uses
  Forms,
  Dialogs,
  SysUtils,
  Registry,
  Classes,
  Windows,
  Graphics,
  main in 'main.pas' {mainform},
  messagesystem in '..\..\..\messagesystem.pas',
  midievent in 'midievent.pas' {midieventfrm},
  editmidievent in 'editmidievent.pas' {editmidieventfrm};

{$R *.res}

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  // Anwendungsfenster erstellen
  mainform:=Tmainform.Create(Application);
  MIDIEVENTfrm:=TMIDIEVENTfrm.Create(Application);
  editmidieventfrm:=Teditmidieventfrm.Create(Application);

  @mainform.RefreshDLLValues:=CallbackSetDLLValues;
  @mainform.RefreshDLLNames:=CallbackSetDLLNames;
  @mainform.SendMSG:=CallbackSendMessage;
end;

function DLLDeactivate:boolean;stdcall;
begin
  with mainform do
  begin
    shutdownbypcdimmeroff:=true;
   	if showing then
    	close;
  end;

  @mainform.RefreshDLLValues:=nil;
  @mainform.RefreshDLLNames:=nil;
  @mainform.SendMSG:=nil;

  editmidieventfrm.Release;
  MIDIEVENTfrm.Release;
  mainform.release;

//  Application.ProcessMessages;
//  sleep(100);

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Gerätesteuerung');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.0');
end;

procedure DLLShow;stdcall;
begin
  mainform.Show;
end;

// Daten PC_DIMMER -> Plugin
procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
  if fadetime=0 then
  begin
    mainform.channelvalue[channel]:=endvalue;
    mainform.RefreshGUI:=true;;
  end;
  mainform.channelnames[channel]:=copy(channelname,2,length(channelname));
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  with mainform do
  case MSG of
    MSG_NEW:
    begin
      NewFile;
    end;
    MSG_OPEN:
    begin
      OpenFile(Data1+'Gerätesteuerung\Gerätesteuerung');
    end;
    MSG_SAVE:
    begin
      SaveFile(Data1+'Gerätesteuerung\Gerätesteuerung');
    end;
    MSG_ACTUALCHANNELVALUE:
    begin
      channelvalue[Integer(Data1)]:=Data2;
      RefreshGUI:=true;;
    end;
    MSG_FLASHMASTER:
    begin
      flashmastervalue:=Data1;
    end;
    MSG_MIDIIN:
    begin
      MidiInput(Data1[0],Data1[1],Data1[2]);
    end;
  end;
end;

exports
  DLLActivate,
  DLLDeactivate,
  DLLIdentify,
  DLLGetVersion,
  DLLGetName,
  DLLShow,
  DLLSendData,
  DLLSendMessage;
begin
end.
