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
  DXPlayFm in 'DXPlayFm.pas' {DelphiXDXPlayForm},
  aboutfrm in 'aboutfrm.pas' {About};

{$R *.res}
{$R plugin_icon.res}

function GetModulePath : String;
var
  QueryRes: TMemoryBasicInformation;
  LBuffer: String;
begin
  VirtualQuery(@GetModulePath, QueryRes, SizeOf(QueryRes));
  SetLength(LBuffer, MAX_PATH);
  SetLength(LBuffer, GetModuleFileName(Cardinal(QueryRes.AllocationBase),
  PChar(LBuffer), Length(LBuffer)));
  result:=LBuffer;
end;

procedure DLLCreate(CallbackSetDLLValues,CallbackSetDLLValueEvent,CallbackSetDLLNames,CallbackGetDLLValue,CallbackSendMessage:Pointer);stdcall;
begin
  Settings:=TSettings.Create(Application);
end;

procedure DLLStart;stdcall;
begin
end;

function DLLDestroy:boolean;stdcall;
var
  LReg:TRegistry;
begin
  Settings.shutdown:=true;
  if Settings.DXPlay1.Opened then
    Settings.DXPlay1.Close;

  LReg:=TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  LReg.OpenKey('Software', True);
  LReg.OpenKey('PHOENIXstudios', True);
  LReg.OpenKey('PC_DIMMER', True);
  LReg.OpenKey(ExtractFileName(GetModulePath), True);
  LReg.WriteBool('Showing Plugin', settings.Showing);
  LReg.Free;

  if settings.Showing then
    Settings.Close;
  Settings.release;
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
  Result := PChar('v1.2');
end;

function DLLGetResourceData(const ResName: PChar; Buffer: Pointer; var Length: Integer):boolean;stdcall;
var
  S: TResourceStream;
  L: Integer;
begin
  Result := False;
  if (Buffer = nil) or (Length <= 0) then Exit;
  try
    S := TResourceStream.Create(HInstance, UpperCase(ResName), RT_RCDATA);
    try
      L := S.Size;
      if Length < L then Exit;
      S.ReadBuffer(Buffer^, L);
      Length := L;
      Result := True;
    finally
      S.Free;
    end;
  except
  end;
end;

function DLLGetResourceSize(const ResName: PChar): Integer; stdcall;
var
  S: TResourceStream;
begin
  Result := 0;
  try
    S := TResourceStream.Create(HInstance, UpperCase(ResName), RT_RCDATA);
    try
      Result := S.Size;
    finally
      S.Free;
    end;
  except
  end;
end;

procedure DLLShow;stdcall;
begin
  Settings.Show;
end;

procedure DLLAbout;stdcall;
begin
  about := tabout.Create(nil);
  about.ShowModal;
  about.release;
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
  DLLGetResourceData,
  DLLGetResourceSize,
  DLLShow,
  DLLAbout,
  DLLSendData,
  DLLSendMessage;

begin
end.
