library dmxchaser128;

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
  config:=tconfig.create(Application);
  @Config.RefreshDLLValues:=CallbackSetDLLValues;
  @Config.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  config.Startup;
end;

function DLLDestroy:boolean;stdcall;
begin
  try
	  config.shutdown:=true;

//    repeat
//      sleep(1);
//    until config.Thread_closed;

	  try
	    if config.comport.Connected then
		  	Config.comport.Disconnect;
	  except
	  end;
	  @config.RefreshDLLValues:=nil;
	  Config.Release;
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
  Result := PChar('DMXChaser128');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v2.1');
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
{
	if address>config.maxchan then exit;
  FillChar(config.ChannelValues, SizeOf(config.ChannelValues), 0);
  config.ChannelValues[0]:=0;
  config.ChannelValues[address]:=endvalue;
  config.refreshsettings:=true;
//  config.comport.SendData(@config.ChannelValues,config.maxchan+1);
}
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=config.issending;
  config.issending:=false;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if ((Data1>config.maxchan) or (Data1<1)) then exit;

      if (config.shutdown=false) then
      begin
        config.ChannelValues[Integer(Data1)]:=Data2;
        config.refreshsettings:=true;
        if config.debugmode then
          config.ListBox1.ItemIndex:=config.ListBox1.Items.Add('Kanal: '+inttostr(Integer(Data1))+' Wert: '+inttostr(Integer(Data2)))
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
