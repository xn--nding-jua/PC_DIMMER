library temperaturregler;

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
  messagesystem in '..\..\..\messagesystem.pas',
  setup in 'setup.pas' {setupform};

{$R *.res}

procedure DLLActivate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TConfig, Config);
  @Config.SetDLLEvent:=CallbackSetDLLValueEvent;
end;

function DLLDeactivate:boolean;stdcall;
begin
  Config.Shutdown:=true;

  if config.comport.Connected then
		Config.comport.Disconnect;

	@config.SetDLLEvent:=nil;
	Config.Free;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Temperaturregler');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.2');
end;

procedure DLLShow;stdcall;
begin
  Config.Show;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if Integer(Data1)=round(setupform.temp2_msb.value) then
      begin
        config.temp2msb:=Integer(Data2);
        config.CurrentTemp2:=(((config.temp2msb shl 8)+config.temp2lsb)-550)/10;
        config.temp2lbl.caption:=floattostrf(config.CurrentTemp2, ffFixed, 5, 1)+'°C';
      end;
      if Integer(Data1)=round(setupform.temp2_lsb.value) then
      begin
        config.temp2lsb:=Integer(Data2);
        config.CurrentTemp2:=(((config.temp2msb shl 8)+config.temp2lsb)-550)/10;
        config.temp2lbl.caption:=floattostrf(config.CurrentTemp2, ffFixed, 5, 1)+'°C';
      end;

      if Integer(Data1)=round(setupform.temp3_msb.value) then
      begin
        config.temp3msb:=Integer(Data2);
        config.CurrentTemp3:=(((config.temp3msb shl 8)+config.temp3lsb)-550)/10;
        config.temp3lbl.caption:=floattostrf(config.CurrentTemp3, ffFixed, 5, 1)+'°C';
      end;
      if Integer(Data1)=round(setupform.temp3_lsb.value) then
      begin
        config.temp3lsb:=Integer(Data2);
        config.CurrentTemp3:=(((config.temp3msb shl 8)+config.temp3lsb)-550)/10;
        config.temp3lbl.caption:=floattostrf(config.CurrentTemp3, ffFixed, 5, 1)+'°C';
      end;
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
