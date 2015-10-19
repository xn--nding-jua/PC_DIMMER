library dmxcontrol_bridge;

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
  messagesystem in 'messagesystem.pas';

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
//  config:=TConfig.Create(nil);
  Application.CreateForm(TConfig, Config);
  @Config.RefreshDLLValues:=CallbackSetDLLValues;
  @Config.SendMSG:=CallbackSendMessage;
end;

procedure DLLStart;
begin
end;

function DLLDestroy:boolean;stdcall;
begin
  try
	  @config.RefreshDLLValues:=nil;
	  @config.SendMSG:=nil;
    Config.DeletePC_DIMMERHandle;
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
  Result := PChar('DMXControl Bridge');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.3');
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
  aCopyData : TCopyDataStruct;
  hTargetWnd : hWnd;
  daten:array[0..3] of integer;
const
  WM_CopyData = 74;
begin
  hTargetWnd := config.DMXCONTROL_HWND;

  daten[0]:=address;
  daten[1]:=startvalue;
  daten[2]:=endvalue;
  daten[3]:=fadetime;

  with aCopyData do
  begin
    dwData := 1;
    lpData := @daten;
    cbData := sizeof(daten);// + 1;
  end;
  if hTargetWnd <> 0 then
    SendMessage(hTargetWnd, WM_CopyData, LongInt(config.handle), LongInt(@aCopyData));

  if config.SendChannelnames.checked then
  begin
    with aCopyData do
    begin
      dwData := 2;
      lpData := PChar(copy(name,2,length(name)));
      cbData := StrLen(PChar(copy(name,2,length(name)))) + 1;
    end;
    if hTargetWnd <> 0 then
      SendMessage(hTargetWnd, WM_CopyData, LongInt(config.handle), LongInt(@aCopyData));
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
  DLLAbout,
  DLLConfigure,
  DLLSendData,
  DLLIsSending,
  DLLSendMessage;

begin
end.
