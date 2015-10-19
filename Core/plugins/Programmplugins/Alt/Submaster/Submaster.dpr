library Submaster;

uses
  Forms,
  Dialogs,
  SysUtils,
  Registry,
  Classes,
  Windows,
  Graphics,
  main in 'main.pas' {mainform},
  kanalwahl in 'kanalwahl.pas' {kanalwahlform},
  messagesystem in '..\..\..\messagesystem.pas',
  midievent in 'midievent.pas' {midieventfrm},
  editmidievent in 'editmidievent.pas' {editmidieventfrm};

{$R *.res}

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  // Anwendungsfenster erstellen
  mainform:=Tmainform.Create(Application);
  kanalwahlform:=Tkanalwahlform.Create(Application);
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
    shutdown:=true;
    shutdownbypcdimmeroff:=true;
   	if showing then
    	close;
  end;

//  @mainform.RefreshDLLValues:=nil;
//  @mainform.RefreshDLLNames:=nil;
//  @mainform.SendMSG:=nil;

  kanalwahlform.Release;
  editmidieventfrm.Release;
  MIDIEVENTfrm.Release;
  mainform.release;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Submaster');
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
    mainform.channelvalue[channel]:=endvalue;
  mainform.channelnames[channel]:=copy(channelname,2,length(channelname));
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  with mainform do
  if not shutdown then
  case MSG of
    MSG_NEW:
    begin
      NewFile();
    end;
    MSG_OPEN:
    begin
      OpenFile(Data1+'Submaster\Submaster');
    end;
    MSG_SAVE:
    begin
      SaveFile(Data1+'Submaster\Submaster');
    end;
    MSG_ACTUALCHANNELVALUE:
    begin
      channelvalue[Integer(Data1)]:=Data2;
    end;
    MSG_FLASHMASTER:
    begin
      FlashmasterScrollbar.Position:=255-Data1;
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
