library Parallelport;

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
  configfrm in 'configfrm.pas' {Config},
  aboutfrm in 'aboutfrm.pas' {About};

{$R *.res}

var
  lptport:integer;
  lptsetting: byte;
  switchvalue:integer;
  prefading:boolean;

// inpout32.dll für LPT-Ausgang unter WinNT, Win2000 und WinXP laden
procedure Out32(PortAddress:word;Value:byte);stdcall;export;
external 'inpout32.DLL';
function Inp32(PortAddress:word):byte;stdcall;export;
external 'inpout32.DLL';

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
end;

procedure DLLStart;stdcall;
var
  LReg:TRegistry;
begin
  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
	        if not LReg.ValueExists('Parallelport Plugin LPT-Port') then
	          LReg.WriteInteger('Parallelport Plugin LPT-Port',888);
	        lptport:=LReg.ReadInteger('Parallelport Plugin LPT-Port');
	        if not LReg.ValueExists('Parallelport Plugin Switchvalue') then
	          LReg.WriteInteger('Parallelport Plugin Switchvalue',128);
	        switchvalue:=LReg.ReadInteger('Parallelport Plugin Switchvalue');
	        if not LReg.ValueExists('Parallelport Plugin Set Channel before dimming') then
	          LReg.WriteBool('Parallelport Plugin Set Channel before dimming',false);
	        prefading:=LReg.ReadBool('Parallelport Plugin Set Channel before dimming');
        end;
      end;
    end;
  end;

  lptsetting:=0;

  Out32(lptport,lptsetting);
end;

function DLLDestroy:boolean;stdcall;
begin
	Result:=true;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Parallelport Outputplugin');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.2');
end;

procedure DLLConfigure;stdcall;
var
  dllForm: TConfig;
  LReg:TRegistry;
begin
  dllForm :=TConfig.Create(Application);
  try
    begin
      dllForm.prefading.checked:=prefading;
      dllForm.switchvaluechange.ItemIndex:=round((255-switchvalue)*100/255);
      if lptport=888 then dllForm.lptchange.Itemindex:=0;
      if lptport=632 then dllForm.lptchange.Itemindex:=1;
      if lptport=956 then dllForm.lptchange.Itemindex:=2;
      dllForm.ShowModal;
      if dllForm.lptchange.Items[dllForm.lptchange.Itemindex]='LPT 1' then lptport:=888;
      if dllForm.lptchange.Items[dllForm.lptchange.Itemindex]='LPT 2' then lptport:=632;
      if dllForm.lptchange.Items[dllForm.lptchange.Itemindex]='LPT 3' then lptport:=956;
      switchvalue:=strtoint(copy(dllForm.switchvaluechange.Items[dllForm.switchvaluechange.ItemIndex],0,length(dllForm.switchvaluechange.Items[dllForm.switchvaluechange.ItemIndex])-1));
      switchvalue:=round((switchvalue*255)/100);
      prefading:=dllForm.prefading.checked;
    end;
  finally
    dllForm.Release;
  end;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  if LReg.OpenKey('Software', True) then
  begin
    if not LReg.KeyExists('PHOENIXstudios') then
      LReg.CreateKey('PHOENIXstudios');
    if LReg.OpenKey('PHOENIXstudios',true) then
    begin
      if not LReg.KeyExists('PC_DIMMER') then
        LReg.CreateKey('PC_DIMMER');
      if LReg.OpenKey('PC_DIMMER',true) then
      begin
        if not LReg.KeyExists(ExtractFileName(GetModulePath)) then
	        LReg.CreateKey(ExtractFileName(GetModulePath));
	      if LReg.OpenKey(ExtractFileName(GetModulePath),true) then
	      begin
	        LReg.WriteInteger('Parallelport Plugin LPT-Port',lptport);
	        LReg.WriteInteger('Parallelport Plugin Switchvalue',switchvalue);
	        LReg.WriteBool('Parallelport Plugin Set Channel before dimming',prefading);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
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

procedure DLLSendData(address, startvalue, endvalue, fadetime: integer;name:PChar);stdcall;
begin
if address>8 then exit;

if ((fadetime=0) or ((fadetime<>0) and prefading)) then
begin

if ((address>=1) and (address<=8)) then
begin
  if endvalue>=switchvalue then
  begin
    if address=1 then if (lptsetting and 1)=0 then lptsetting:=lptsetting + 1;
    if address=2 then if (lptsetting and 2)=0 then lptsetting:=lptsetting + 2;
    if address=3 then if (lptsetting and 4)=0 then lptsetting:=lptsetting + 4;
    if address=4 then if (lptsetting and 8)=0 then lptsetting:=lptsetting + 8;
    if address=5 then if (lptsetting and 16)=0 then lptsetting:=lptsetting + 16;
    if address=6 then if (lptsetting and 32)=0 then lptsetting:=lptsetting + 32;
    if address=7 then if (lptsetting and 64)=0 then lptsetting:=lptsetting + 64;
    if address=8 then if (lptsetting and 128)=0 then lptsetting:=lptsetting + 128;
  end else
  begin
    if address=1 then if (lptsetting and 1)=1 then lptsetting:=lptsetting - 1;
    if address=2 then if (lptsetting and 2)=2 then lptsetting:=lptsetting - 2;
    if address=3 then if (lptsetting and 4)=4 then lptsetting:=lptsetting - 4;
    if address=4 then if (lptsetting and 8)=8 then lptsetting:=lptsetting - 8;
    if address=5 then if (lptsetting and 16)=16 then lptsetting:=lptsetting - 16;
    if address=6 then if (lptsetting and 32)=32 then lptsetting:=lptsetting - 32;
    if address=7 then if (lptsetting and 64)=64 then lptsetting:=lptsetting - 64;
    if address=8 then if (lptsetting and 128)=128 then lptsetting:=lptsetting - 128;
  end;
end;
  Out32(lptport,lptsetting);
end;
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
