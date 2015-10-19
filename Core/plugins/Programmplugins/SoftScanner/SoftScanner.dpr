library SoftScanner;

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
  Registry,
  Classes,
  Windows,
  Dialogs,
  settingfrm in 'settingfrm.pas' {Settings},
  messagesystem in '..\..\..\messagesystem.pas',
  DXPlayFm in 'DXPlayFm.pas' {DelphiXDXPlayForm};

{$R *.res}

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Application.CreateForm(TSettings, Settings);
end;

procedure DLLStart;stdcall;
begin
end;

function DLLDestroy:boolean;stdcall;
begin
  Settings.shutdown:=true;
  if Settings.DXPlay1.Opened then
    Settings.DXPlay1.Close;

  Settings.Close;
  Settings.Free;
  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('SoftScanner Client');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v1.1');
end;

procedure DLLShow;stdcall;
begin
  Settings.Show;
end;

procedure DLLSendData(channel, startvalue, endvalue, fadetime:integer; channelname:PChar);stdcall;
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
  name:PChar;
begin
  if not Settings.DXPlay1.Opened then exit;

  name:=channelname;
  MsgSize:=sizeof(TDXChatMessage)+length(name);
  GetMem(nachricht,MsgSize);

  TDXChatMessage(nachricht^).address:=channel-settings.startaddress+1;
  TDXChatMessage(nachricht^).startvalue:=startvalue;
  TDXChatMessage(nachricht^).endvalue:=endvalue;
  TDXChatMessage(nachricht^).fadetime:=fadetime;

  TDXChatMessage(nachricht^).Len:=length(name);
  StrLCopy(TDXChatMessage(nachricht^).Name, pChar(name), length(name));

  for i:=0 to Settings.DXPlay1.Players.Count-1 do
  begin
    if Settings.DXPlay1.Players.Players[i].Name<>Settings.DXPlay1.LocalPlayer.Name then
      Settings.DXPlay1.SendMessage(Settings.DXPlay1.Players.Players[i].ID,nachricht,MsgSize);
  end;
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
{
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
  name:PChar;
}
begin
{
  if not Settings.DXPlay1.Opened then exit;

  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      name:='Kein Name';
      MsgSize:=sizeof(TDXChatMessage)+length(name);
      GetMem(nachricht,MsgSize);

      TDXChatMessage(nachricht^).address:=Integer(Data1)+settings.startaddress-1;
      TDXChatMessage(nachricht^).startvalue:=Integer(Data2);
      TDXChatMessage(nachricht^).endvalue:=Integer(Data2);
      TDXChatMessage(nachricht^).fadetime:=0;

      TDXChatMessage(nachricht^).Len:=length(name);
      StrLCopy(TDXChatMessage(nachricht^).Name, pChar(name), length(name));

      for i:=0 to Settings.DXPlay1.Players.Count-1 do
      begin
        if Settings.DXPlay1.Players.Players[i].Name<>Settings.DXPlay1.LocalPlayer.Name then
          Settings.DXPlay1.SendMessage(Settings.DXPlay1.Players.Players[i].ID,nachricht,MsgSize);
      end;
    end;
  end;
}
end;

exports
  DLLCreate,
  DLLStart,
  DLLDestroy,
  DLLIdentify,
  DLLGetVersion,
  DLLGetName,
  DLLShow,
  DLLSendData,
  DLLSendMessage;

begin
end.
