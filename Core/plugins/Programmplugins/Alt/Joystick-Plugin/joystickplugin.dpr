library Joystickplugin;

{ Wichtiger Hinweis zur DLL-Speicherverwaltung: ShareMem muss sich in der
  ersten Unit der unit-Klausel der Bibliothek und des Projekts befinden (Projekt-
  Quelltext anzeigen), falls die DLL Prozeduren oder Funktionen exportiert, die
  Strings als Parameter oder Funktionsergebnisse übergeben. Das gilt für alle
  Strings, die von oder an die DLL übergeben werden -- sogar für diejenigen, die
  sich in Records und Klassen befinden. Sharemem ist die Schnittstellen-Unit zur
  Verwaltungs-DLL für gemeinsame Speicherzugriffe, BORLNDMM.DLL.
  Um die Verwendung von BORLNDMM.DLL zu vermeiden, können Sie String-
  Informationen als PChar- oder ShortString-Parameter übergeben. }

uses
  Forms,
  SysUtils,
  Registry,
  Classes,
  Windows,
  settingfrm in 'settingfrm.pas' {Settings};

{$R *.res}

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Settings:=TSettings.Create(Application);
  @Settings.RefreshDLLValues:=CallbackSetDLLValues;
  @Settings.RefreshDLLNames:=CallbackSetDLLNames;
end;

function DLLDeactivate:boolean;stdcall;
begin
  Settings.shutdown:=true;
  Settings.Release;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Joystick Plugin');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.2');
end;

procedure DLLShow;stdcall;
begin
  Settings.Show;
end;

procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
begin
  Settings.channelvalue[channel]:=endvalue;
  Settings.channelnames[channel]:=copy(channelname,2,length(channelname));
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin

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
