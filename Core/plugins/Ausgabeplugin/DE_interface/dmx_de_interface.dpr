library dmx_de_interface;

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
//  SetProcessAffinityMask(GetCurrentProcess, 1); // 1=CPU0 , 2=CPU1

  Application.CreateForm(TConfig, Config);
  Application.CreateForm(Ttimingform, timingform);
  @Config.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  config.startuptimer.Enabled:=true; // waits 2.5 Seconds and initializes the interface
end;

function DLLDestroy:boolean;stdcall;
begin
  // Alle Interrupt-Funktionen beenden
  UnregisterInputChangeNotification;
  UnregisterInterfaceChangeNotification;
  if config.UseBlockChange then
    UnRegisterInputChangeBlockNotification;

  Application.ProcessMessages;
  sleep(150);

  // Alle Timer beenden
  config.RefreshSometimesTimer.Enabled:=false;
  config.ScanForInterfacesTimer.Enabled:=false;
  config.ScanTimer.Enabled:=false;

  Application.ProcessMessages;
  sleep(150);

  // Alle Interfacelinks deaktivieren
  CloseAllLinks;

  // Funktionspointer auflösen
  @Config.RefreshDLLEvent:=nil;

  Application.ProcessMessages;
  sleep(150);

  // Forms entfernen
  timingform.free;
  Config.free;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Digital Enlightenment DMX512 (FX5)');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v6.2');
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
