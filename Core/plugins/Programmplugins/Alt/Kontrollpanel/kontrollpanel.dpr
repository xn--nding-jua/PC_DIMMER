library kontrollpanel;

uses
  Forms,
  Dialogs,
  SysUtils,
  Registry,
  Classes,
  Windows,
  Graphics,
  szenenpanelfrm in 'szenenpanelfrm.pas' {mainform},
  insscene in 'insscene.pas' {insscenedlg},
  presskey in 'presskey.pas' {presskeyfrm},
  editskript in 'editskript.pas' {editskriptfrm},
  Action in 'action.pas' {ActionDlg},
  midievent in 'midievent.pas' {midieventfrm},
  editmidievent in 'editmidievent.pas' {editmidieventfrm},
  messagesystem in '..\..\..\messagesystem.pas';

{$R *.res}

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  // Anwendungsfenster erstellen
  mainform:=Tmainform.Create(Application);
  insscenedlg:=Tinsscenedlg.Create(Application);
  presskeyfrm:=Tpresskeyfrm.Create(Application);
  editskriptfrm:=Teditskriptfrm.Create(Application);
  ActionDlg:=TActionDlg.Create(Application);
  midieventfrm:=Tmidieventfrm.Create(Application);
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
	  CheckFileExists.Enabled:=false;
	  try
      if mediaplayer1.DeviceID<>0 then
				mediaplayer1.Stop;
	  except
	  end;
   	if showing then
    	close;
  end;

  @mainform.RefreshDLLValues:=nil;
  @mainform.RefreshDLLNames:=nil;
  @mainform.SendMSG:=nil;

  editskriptfrm.Release;
  ActionDlg.Release;
  presskeyfrm.Release;
  insscenedlg.Release;
  midieventfrm.Release;
  editmidieventfrm.Release;
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
  Result := PChar('Kontrollpanel');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.2');
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
  case MSG of
		MSG_SYSTEMSPEED:
    begin
      if tempokoppeln.Checked then
      begin
	      MSGFROMMAINPROGRAM:=true;
	    	temposlider.Position:=Data1;
	      MSGFROMMAINPROGRAM:=false;
      end;
    end;
    MSG_NEW:
    begin
			NewPanel;
    end;
    MSG_OPEN:
    begin
    	MSGOpen(nil);
    end;
    MSG_SAVE:
    begin
    	MSGSave(nil);
    end;
    MSG_ACTUALCHANNELVALUE:
    begin
      channelvalue[Integer(Data1)]:=Data2;
    end;
    MSG_MIDIIN:
    begin
      midiinput(data1[0],data1[1],data1[2]);
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
