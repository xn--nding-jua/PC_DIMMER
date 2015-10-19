library pc_dimmer_com;

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
  messagesystem in '..\..\..\messagesystem.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TConfig, Config);
  @Config.RefreshDLLValues:=CallbackSetDLLValues;
  @Config.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  config.Startup;
end;

function DLLDestroy:boolean;stdcall;
begin
  config.shutdown:=true;

//  if config.comport.Connected then
//		Config.comport.Disconnect;
  if config.comport2.Connected then
    config.comport2.Close;

	@config.RefreshDLLValues:=nil;
	@config.RefreshDLLEvent:=nil;

	Config.Free;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('128 Kanal PC_DIMMER Seriell');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v4.1');
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
  dllForm.ShowModal;
  dllForm.Free;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
var
  b:byte;
  t3,t2,t1:byte;
  rs232frame_new:array[0..5] of Byte;
  nsteps,stp:integer;
  timestep:longint;
  count:integer;
begin
// Routine für COM1 bis COM16

	if address>128 then exit;
  if (config.RadioGroup1.ItemIndex=1) then exit;

// im Puffer alles auf 0 setzen
  FillChar(rs232frame_new, SizeOf(rs232frame_new), 0);

  startvalue:=255-startvalue;
  endvalue:=255-endvalue;

  fadetime:=fadetime div 10;
  stp:=0;

  nsteps:=abs(startvalue-endvalue);

  if (nsteps<>0) and (fadetime<>0) then
  begin
    repeat
      inc(stp);
      timestep:=fadetime*stp;
      timestep:=round(timestep/nsteps);
    until (abs(((fadetime-((timestep*nsteps)/stp))*100)/fadetime) <= 15) or (stp>=4);
  end else
  begin
    timestep:=0;
    inc(stp);
  end;

  dec(address);
  b:=address;
  b:=b or $80;                                {erste byte high für Synchronisation}
  rs232frame_new[0]:=b;                           {erste Byte in Puffer schreiben}

//Steps in Byte 2 schreiben
  dec(stp);
  b:=0;
  b:=b or stp;
  rs232frame_new[1]:=b;                           {zweite Byte in Puffer schreiben}

// Fadezeiten in Byte 3..5 senden
  t1:=(lo(timestep) and $7F);
  timestep:=timestep shr 7;
  t2:=(lo(timestep) and $7F);
  timestep:=timestep shr 7;
  t3:=(lo(timestep) and $7F);
  rs232frame_new[2]:=t3;                           {dritte Byte in Puffer schreiben}
  rs232frame_new[3]:=t2;                           {vierte Byte in Puffer schreiben}
  rs232frame_new[4]:=t1;                           {fünfte Byte in Puffer schreiben}

// Endwert im Byte 6 senden
  b:=(endvalue div 2) and $7F;
  rs232frame_new[5]:=b;                           {sechste Byte in Puffer schreiben}

  count:=6;
  case config.RadioGroup2.ItemIndex of
    0:
    begin
      if config.comport.Connected then
        config.comport.SendData(@rs232frame_new,6);
    end;
    1:
    begin
      if config.comport2.Connected then
        config.comport2.Write(rs232frame_new,count);
    end;
  end;
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=config.issending;
  config.issending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
var
  b,Count:byte;
  rs232frame_new:array[0..5] of Byte;
begin
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if Data1>128 then exit;
      if config.RadioGroup1.ItemIndex=1 then
      begin
        FillChar(rs232frame_new, SizeOf(rs232frame_new), 0);

        b:=Integer(Data1);
        Dec(b);
        b:=b or $80;
        rs232frame_new[0]:=b; // Adresse
        b:=((255-Integer(Data2)) div 2) and $7F;
        rs232frame_new[5]:=b;

        count:=6;
        case config.RadioGroup2.ItemIndex of
          0:
          begin
            if config.comport.Connected then
              config.comport.SendData(@rs232frame_new,6);
          end;
          1:
          begin
            if config.comport2.Connected then
              config.comport2.Write(rs232frame_new,count);
          end;
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
