library Velleman_k8062;

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
  Classes,
  Windows,
  messagesystem in '..\..\..\messagesystem.pas',
  mainform in 'mainform.pas' {Form1};

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TForm1, Form1);
end;

procedure DLLStart;stdcall;
begin
  Form1.Startup;
end;

function DLLDestroy:boolean;stdcall;
begin
  try
	  Form1.Release;
  except
  end;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Velleman K8062 USBDMX');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v4.1');
end;

procedure DLLConfigure;stdcall;
begin
  ShowMessage('Dieses Plugin besitzt keine Einstellungen.');
end;

procedure DLLAbout;stdcall;
begin
  ShowMessage('Velleman K8062 USBDMX Interface-Plugin'+#10#13+'(c) 2010 by Christian Nöding');
end;

procedure DLLSenddata(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
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
      if (Integer(Data1)>length(Form1.DMXOutBuffer)) and (Integer(Data1)<=512) then
      begin
        setlength(Form1.DMXOutBuffer, Integer(Data1));
        Form1.ChannelCountChange;
      end;

      if Data1<length(Form1.DMXOutBuffer) then
        Form1.DMXOutBuffer[Integer(Data1)-1]:=Integer(Data2);
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
