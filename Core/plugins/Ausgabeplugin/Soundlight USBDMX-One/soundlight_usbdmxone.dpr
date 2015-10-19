library soundlight_usbdmxone;

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
  Dialogs,
  SysUtils,
  Classes,
  Windows,
  configfrm in 'configfrm.pas' {Config},
  aboutfrm in 'aboutfrm.pas' {About},
  susbdmx in 'susbdmx.pas',
  U_Usb in 'U_Usb.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TConfig, Config);
  @Config.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  config.Startup;
  config.SearchForInterfaces;
end;

function DLLDestroy:boolean;stdcall;
begin
  // Alle Timer beenden
  config.RefreshSometimesTimer.Enabled:=false;
  config.DMXTimer.Enabled:=false;

  // Alle Interfacelinks deaktivieren
  config.DisconnectAllInterfaces;

  // Funktionspointer auflösen
  @Config.RefreshDLLEvent:=nil;

  // Forms entfernen
  Config.free;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Soundlight USBDMX-One');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.2');
end;

procedure DLLConfigure;stdcall;
begin
  Config.ShowModal;
end;

procedure DLLAbout;stdcall;
var
  dllForm: TForm;
begin
  dllForm :=TAbout.Create(Application);
  try
    dllForm.ShowModal;
  finally
    dllForm.Release;
  end;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=config.IsSending;
  config.IsSending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
var
  i,Value,Channel,ResultingChannel:integer;
begin
  case MSG of
    14:
    begin
      Channel:=Data1;
      Value:=Data2;

      for i:=0 to length(config.DMXOutArray)-1 do
      begin
        ResultingChannel:=Channel-config.Interfaces[i].UniverseOut;

        if (ResultingChannel>=0) and (ResultingChannel<=511) then
        begin
          config.DMXOutArray[i][ResultingChannel+1]:=Value;
        end;
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
