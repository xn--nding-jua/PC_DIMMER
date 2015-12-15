library nodleu1_interface;

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
  timingfrm in 'timingfrm.pas' {timingform};

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  SetProcessAffinityMask(GetCurrentProcess, 1); // 1=CPU0 , 2=CPU1

  config:=tconfig.create(Application);
  timingform:=ttimingform.create(config);
  @Config.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  config.startup;
  config.SearchForInterfaces;
end;

function DLLDestroy:boolean;stdcall;
begin
  // Alle Timer beenden
  config.RefreshSometimesTimer.Enabled:=false;
  config.ScanForInterfacesTimer.Enabled:=false;
  config.ScanTimer.Enabled:=false;

  Application.ProcessMessages;
  sleep(50);

  // Alle Interfacelinks deaktivieren
  CloseAllLinks;

  Application.ProcessMessages;
  sleep(150);

  // Alle Interrupt-Funktionen beenden
  UnregisterInputChangeNotification;
  UnregisterInterfaceChangeNotification;
//  if config.UseBlockChange then
//    UnRegisterInputChangeBlockNotification;

  Application.ProcessMessages;
  sleep(150);

  // Funktionspointer auflösen
  @Config.RefreshDLLEvent:=nil;

  Application.ProcessMessages;
  sleep(150);

  // Forms entfernen
  timingform.release;
  Config.release;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('NodleU1 DMX-Interface');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.1');
end;

procedure DLLConfigure;stdcall;
begin
  Config.ShowModal;
end;

procedure DLLAbout;stdcall;
begin
  about:=tabout.create(nil);
  about.showmodal;
  about.release;
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

      for i:=0 to 31 do
      begin
        ResultingChannel:=Channel-config.DE_Interfaces[i].Startaddress;

        if (ResultingChannel>=0) and (ResultingChannel<=511) then
        begin
          config.DMXOutArray[i][ResultingChannel]:=Value;
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
