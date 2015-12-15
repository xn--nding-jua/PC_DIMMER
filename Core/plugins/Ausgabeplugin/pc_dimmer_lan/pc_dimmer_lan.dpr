library pc_dimmer_lan;

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
  ScktComp,
  DXPlay,
  configfrm in 'configfrm.pas' {Config},
  aboutfrm in 'aboutfrm.pas' {About},
  DXPlayFm in 'DXPlayFm.pas' {DelphiXDXPlayForm};

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  config:=tconfig.create(Application);
  DelphiXDXPlayForm:=TDelphiXDXPlayForm.Create(config);
  @Config.RefreshDLLValues:=CallbackSetDLLValues;
  @Config.RefreshDLLNames:=CallbackSetDLLNames;
  @Config.RequestDLLValue:=CallbackGetDLLValue;
  @Config.RefreshDLLEvent:=CallbackSetDLLValueEvent;
end;

procedure DLLStart;stdcall;
begin
  config.DXplay1.Open;
end;

function DLLDestroy:boolean;stdcall;
begin
  if config.DXplay1.Opened then
    config.DXplay1.Close;

  DelphiXDXPlayForm.Release;
  Config.Release;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('PC_DIMMER Netzwerk');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v4.0');
end;

procedure DLLConfigure;stdcall;
begin
  config.ShowModal;
end;

procedure DLLAbout;stdcall;
begin
  about:=Tabout.create(nil);
  about.showmodal;
  about.release;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
type
  TDXChatMessage = record
    address:word;
    startvalue:byte;
    endvalue:byte;
    fadetime:LongWord;
    Len: Word;
    Name: Array[0..0] of Char;
  end;
var
  i:integer;
  nachricht:^TDXChatMessage;
  MsgSize:Integer;
begin
  if not config.DXPlay1.Opened then exit;

  MsgSize:=sizeof(TDXChatMessage)+length(name);
  GetMem(nachricht,MsgSize);

  TDXChatMessage(nachricht^).address:=address;
  TDXChatMessage(nachricht^).startvalue:=startvalue;
  TDXChatMessage(nachricht^).endvalue:=endvalue;
  TDXChatMessage(nachricht^).fadetime:=fadetime;

  TDXChatMessage(nachricht^).Len:=length(name);
  StrLCopy(TDXChatMessage(nachricht^).Name, pChar(name), length(name));

  for i:=0 to config.DXPlay1.Players.Count-1 do
  begin
    if config.DXPlay1.Players.Players[i].Name<>config.DXPlay1.LocalPlayer.Name then
      config.DXPlay1.SendMessage(config.DXPlay1.Players.Players[i].ID,nachricht,MsgSize);
  end;
end;

function DLLIsSending:boolean;stdcall;
begin
	result:=config.issending;
  config.issending:=false;
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
