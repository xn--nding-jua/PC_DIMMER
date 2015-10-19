library pc_dimmer_com_32;

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
  Classes,
  Windows,
  configfrm in 'configfrm.pas' {Config},
  aboutfrm in 'aboutfrm.pas' {About};

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TConfig, Config);
end;

procedure DLLStart;stdcall;
begin
  config.Startup;
end;

function DLLDestroy:boolean;stdcall;
begin
  Config.comport.Disconnect;
  Config.Release;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('32 Kanal PC_DIMMER Seriell');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.2');
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
var
  b:byte;
  t3,t2,t1:byte;
  rs232frame:array[0..5] of Byte;
  nsteps,stp:integer;
  timestep:longint;
begin
	if address>32 then exit;

// im Puffer alles auf 0 setzen
  FillChar(rs232frame, SizeOf(rs232frame), 0);

  fadetime:=fadetime div 10;

  startvalue:=255-startvalue;
  endvalue:=255-endvalue;

  stp:=0;
  nsteps:=abs(startvalue-endvalue);
  if (nsteps<>0) and (fadetime<>0) then
  begin
    repeat
      inc(stp);
      timestep:=fadetime*stp;
      timestep:=round(timestep/nsteps);
    until (abs(((fadetime-((timestep*nsteps)/stp))*100)/fadetime) <= 15) or (stp>=4);
  end
  else
  begin
    timestep:=0;
    inc(stp);
  end;

  dec(address);
  dec(stp);
  b:=address shl 2;
  b:=b or $80;                                {erste byte high für Synchronisation}
  b:=b or stp;
  rs232frame[0]:=b;                               {erste Byte in Puffer schreiben}

// Fadezeiten in Byte 2..4 senden
  t1:=(lo(timestep) and $7F);
  timestep:=timestep shr 7;
  t2:=(lo(timestep) and $7F);
  timestep:=timestep shr 7;
  t3:=(lo(timestep) and $7F);
  rs232frame[1]:=t3;                               {zweite Byte in Puffer schreiben}
  rs232frame[2]:=t2;                               {dritte Byte in Puffer schreiben}
  rs232frame[3]:=t1;                               {vierte Byte in Puffer schreiben}

// Endwert im Byte 5 senden
  b:=(endvalue div 2) and $7F;
  rs232frame[4]:=b;                               {fünfte Byte in Puffer schreiben}
  config.comport.SendData(@rs232frame,6);
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin

end;

exports
  DLLCreate,
  DLLStart,
  DLLDestroy,
  DLLIdentify,
  DLLGetVersion,
  DLLGetName,
  DLLConfigure,
  DLLAbout,
  DLLSendData,
  DLLIsSending,
  DLLSendMessage;

begin
end.
