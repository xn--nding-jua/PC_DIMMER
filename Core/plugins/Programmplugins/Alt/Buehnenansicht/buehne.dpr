library buehne;

uses
  Forms,
  Dialogs,
  SysUtils,
  Registry,
  Classes,
  Windows,
  buehnenansicht in 'buehnenansicht.pas' {grafischebuehnenansicht},
  messagesystem in '..\..\..\messagesystem.pas';

{$R *.res}

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  grafischebuehnenansicht:=Tgrafischebuehnenansicht.Create(Application);
  @grafischebuehnenansicht.RefreshDLLValues:=CallbackSetDLLValues;
  @grafischebuehnenansicht.RefreshDLLNames:=CallbackSetDLLNames;
end;

function DLLDeactivate:boolean;stdcall;
begin
  grafischebuehnenansicht.shutdown:=true;
	grafischebuehnenansicht.screentimeronline:=false;
  if grafischebuehnenansicht.Showing then
    grafischebuehnenansicht.Close;
  grafischebuehnenansicht.Release;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Grafische B'+#252+'hnenansicht');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.5');
end;

procedure DLLShow;stdcall;
begin
  grafischebuehnenansicht.Show;
end;

// Daten PC_DIMMER -> Plugin
procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
  if fadetime=0 then
    grafischebuehnenansicht.channelvalue[channel]:=endvalue;

  grafischebuehnenansicht.channelnames[channel]:=copy(channelname,2,length(channelname));
  grafischebuehnenansicht.aktualisierechannel[channel]:=true;
  if grafischebuehnenansicht.Showing then grafischebuehnenansicht.aktualisieren:=true;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  with grafischebuehnenansicht do
  case MSG of
    MSG_NEW:
    begin
			NewPanel;
    end;
    MSG_OPEN:
    begin
	  	if ((CheckBox3.Checked) and (FileExists(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht'))) then
  			openscene(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht');
    end;
    MSG_SAVE:
    begin
	    buehnenansicht_record.Buehnenansicht_width:=grafischebuehnenansicht.Width;
	    buehnenansicht_record.Buehnenansicht_height:=grafischebuehnenansicht.Height;
	    buehnenansicht_record.Buehnenansicht_panel:=panel1.Visible;

	  	If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt') then
		   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt');
	  	If not DirectoryExists(ExtractFilepath(paramstr(0))+'Projekt\Bühnenansicht') then
		   	CreateDir(ExtractFilepath(paramstr(0))+'Projekt\Bühnenansicht');

	    savescene(workingdirectory+'Projekt\Bühnenansicht\Bühnenansicht');
    end;
    MSG_ACTUALCHANNELVALUE:
    begin
      channelvalue[Integer(Data1)]:=Data2;
      aktualisierechannel[Integer(Data1)]:=true;
      if Showing then aktualisieren:=true;
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
