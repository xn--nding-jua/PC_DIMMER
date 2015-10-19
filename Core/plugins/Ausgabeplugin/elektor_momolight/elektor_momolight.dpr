library elektor_momolight;

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
  messagesystem in '..\..\..\messagesystem.pas',
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
  Result := PChar('Elektor MoMoLight-Protokoll');
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
	result:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      // Kanalwerte in die entsprechenden Variablen speichern
      case Integer(Data1) of
        1: config.R1:=Integer(Data2);
        2: config.G1:=Integer(Data2);
        3: config.B1:=Integer(Data2);
        4: config.R2:=Integer(Data2);
        5: config.G2:=Integer(Data2);
        6: config.B2:=Integer(Data2);
        7: config.R3:=Integer(Data2);
        8: config.G3:=Integer(Data2);
        9: config.B3:=Integer(Data2);
      end;
      config.newvalues:=true;
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
  DLLConfigure,
  DLLAbout,
  DLLSendData,
  DLLIsSending,
  DLLSendMessage;

begin
end.
