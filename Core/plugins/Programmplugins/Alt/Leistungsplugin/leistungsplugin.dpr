library Leistungsplugin;

uses
  Forms,
  SysUtils,
  Registry,
  Classes,
  Windows,
  Dialogs,
  settingfrm in 'settingfrm.pas' {Settings},
  messagesystem in '..\..\..\messagesystem.pas';

{$R *.res}

type TPluginRecord = packed record
  channel, value : byte;
end;
  PPluginRecord = ^TPluginRecord;

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Settings:=TSettings.Create(Application);
  @Settings.RefreshDLLValues:=CallbackSetDLLValues;
  @Settings.RefreshDLLNames:=CallbackSetDLLNames;
end;

function DLLDeactivate:boolean;stdcall;
begin
  Settings.Shutdown:=true;
  if Settings.Showing then
    Settings.Close;
  Settings.Release;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Leistungsplugin');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.2');
end;

procedure DLLShow;stdcall;
begin
  Settings.Show;
end;

procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
  if fadetime=0 then
    Settings.channelvalue[channel]:=endvalue;
  Settings.channelnames[channel]:=copy(channelname,2,length(channelname));
  if settings.Showing then Settings.Calculate.Enabled:=true;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  with Settings do
  case MSG of
		MSG_NEW:
	  begin
			NewFile
		end;
		MSG_OPEN:
    begin
		  if FileExists(Data1+'Leistungsplugin') then
				OpenFile(Data1+'Leistungsplugin')
		  else
				NewFile;
    end;
    MSG_SAVE:
    begin
    	SaveFile(Data1+'Leistungsplugin');
    end;
    MSG_ACTUALCHANNELVALUE:
    begin
      Settings.channelvalue[Integer(Data1)]:=Data2;
      if settings.Showing then Settings.Calculate.Enabled:=true;
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
