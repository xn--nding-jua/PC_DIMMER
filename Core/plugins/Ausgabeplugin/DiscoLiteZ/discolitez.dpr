library DiscoLiteZ;

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
  lptsetting:array[0..3] of byte;
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
	        if not LReg.ValueExists('DiscoLiteZ Plugin LPT-Port') then
	          LReg.WriteInteger('DiscoLiteZ Plugin LPT-Port',888);
	        lptport:=LReg.ReadInteger('DiscoLiteZ Plugin LPT-Port');
	        if not LReg.ValueExists('DiscoLiteZ Plugin Switchvalue') then
	          LReg.WriteInteger('DiscoLiteZ Plugin Switchvalue',128);
	        switchvalue:=LReg.ReadInteger('DiscoLiteZ Plugin Switchvalue');
	        if not LReg.ValueExists('DiscoLiteZ Plugin Set Channel before dimming') then
	          LReg.WriteBool('DiscoLiteZ Plugin Set Channel before dimming',false);
	        prefading:=LReg.ReadBool('DiscoLiteZ Plugin Set Channel before dimming');
	      end;
      end;
    end;
  end;

  lptsetting[0]:=0;
  lptsetting[1]:=0;
  lptsetting[2]:=0;
  lptsetting[3]:=0;

  Out32(lptport+2,0);
  Out32(lptport,0);

  Out32(lptport+2,1);
  Out32(lptport,lptsetting[0]);

  Out32(lptport+2,2);
  Out32(lptport,lptsetting[1]);

  Out32(lptport+2,0);
  Out32(lptport,lptsetting[2]);

  Out32(lptport+2,4);
  Out32(lptport+2,8);
  Out32(lptport,lptsetting[3]);

  Out32(lptport+2,0);
  Out32(lptport,0);
end;

function DLLDestroy:boolean;stdcall;
begin
	result:=true;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result := PChar('Output');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('DiscoLiteZ Outputplugin');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v3.5');
end;

procedure DLLConfigure;stdcall;
var
  LReg:TRegistry;
begin
  config:=tconfig.create(nil);
  try
    begin
      config.switchvaluechange.ItemIndex:=round((255-switchvalue)*100/255);
      config.prefading.Checked:=prefading;
      if lptport=888 then config.lptchange.Itemindex:=0;
      if lptport=632 then config.lptchange.Itemindex:=1;
      if lptport=956 then config.lptchange.Itemindex:=2;
      config.ShowModal;
      if config.lptchange.Items[config.lptchange.Itemindex]='LPT 1' then lptport:=888;
      if config.lptchange.Items[config.lptchange.Itemindex]='LPT 2' then lptport:=632;
      if config.lptchange.Items[config.lptchange.Itemindex]='LPT 3' then lptport:=956;
      switchvalue:=strtoint(copy(config.switchvaluechange.Items[config.switchvaluechange.ItemIndex],0,length(config.switchvaluechange.Items[config.switchvaluechange.ItemIndex])-1));
      switchvalue:=round((switchvalue*255)/100);
      prefading:=config.prefading.Checked;
    end;
  finally
    config.Release;
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
	        LReg.WriteInteger('DiscoLiteZ Plugin LPT-Port',lptport);
	        LReg.WriteInteger('DiscoLiteZ Plugin Switchvalue',switchvalue);
	        LReg.WriteBool('DiscoLiteZ Plugin Set Channel before dimming',prefading);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
end;

procedure DLLAbout;stdcall;
begin
  about:=tabout.create(nil);
  about.showmodal;
  about.release;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime: integer;name:PChar);stdcall;
begin
if address>32 then exit;

if ((fadetime=0) or ((fadetime<>0) and prefading)) then
begin

if ((address>=1) and (address<=8)) then
begin
  if endvalue>=switchvalue then
  begin
    if address=1 then if (lptsetting[0] and 1)=0 then lptsetting[0]:=lptsetting[0] + 1;
    if address=2 then if (lptsetting[0] and 2)=0 then lptsetting[0]:=lptsetting[0] + 2;
    if address=3 then if (lptsetting[0] and 4)=0 then lptsetting[0]:=lptsetting[0] + 4;
    if address=4 then if (lptsetting[0] and 8)=0 then lptsetting[0]:=lptsetting[0] + 8;
    if address=5 then if (lptsetting[0] and 16)=0 then lptsetting[0]:=lptsetting[0] + 16;
    if address=6 then if (lptsetting[0] and 32)=0 then lptsetting[0]:=lptsetting[0] + 32;
    if address=7 then if (lptsetting[0] and 64)=0 then lptsetting[0]:=lptsetting[0] + 64;
    if address=8 then if (lptsetting[0] and 128)=0 then lptsetting[0]:=lptsetting[0] + 128;
  end else
  begin
    if address=1 then if (lptsetting[0] and 1)=1 then lptsetting[0]:=lptsetting[0] - 1;
    if address=2 then if (lptsetting[0] and 2)=2 then lptsetting[0]:=lptsetting[0] - 2;
    if address=3 then if (lptsetting[0] and 4)=4 then lptsetting[0]:=lptsetting[0] - 4;
    if address=4 then if (lptsetting[0] and 8)=8 then lptsetting[0]:=lptsetting[0] - 8;
    if address=5 then if (lptsetting[0] and 16)=16 then lptsetting[0]:=lptsetting[0] - 16;
    if address=6 then if (lptsetting[0] and 32)=32 then lptsetting[0]:=lptsetting[0] - 32;
    if address=7 then if (lptsetting[0] and 64)=64 then lptsetting[0]:=lptsetting[0] - 64;
    if address=8 then if (lptsetting[0] and 128)=128 then lptsetting[0]:=lptsetting[0] - 128;
  end;
end;

if ((address>8) and (address<=16)) then
begin
  if endvalue>=switchvalue then
  begin
    if address=9 then if (lptsetting[1] and 1)=0 then lptsetting[1]:=lptsetting[1] + 1;
    if address=10 then if (lptsetting[1] and 2)=0 then lptsetting[1]:=lptsetting[1] + 2;
    if address=11 then if (lptsetting[1] and 4)=0 then lptsetting[1]:=lptsetting[1] + 4;
    if address=12 then if (lptsetting[1] and 8)=0 then lptsetting[1]:=lptsetting[1] + 8;
    if address=13 then if (lptsetting[1] and 16)=0 then lptsetting[1]:=lptsetting[1] + 16;
    if address=14 then if (lptsetting[1] and 32)=0 then lptsetting[1]:=lptsetting[1] + 32;
    if address=15 then if (lptsetting[1] and 64)=0 then lptsetting[1]:=lptsetting[1] + 64;
    if address=16 then if (lptsetting[1] and 128)=0 then lptsetting[1]:=lptsetting[1] + 128;
  end else
  begin
    if address=9 then if (lptsetting[1] and 1)=1 then lptsetting[1]:=lptsetting[1] - 1;
    if address=10 then if (lptsetting[1] and 2)=2 then lptsetting[1]:=lptsetting[1] - 2;
    if address=11 then if (lptsetting[1] and 4)=4 then lptsetting[1]:=lptsetting[1] - 4;
    if address=12 then if (lptsetting[1] and 8)=8 then lptsetting[1]:=lptsetting[1] - 8;
    if address=13 then if (lptsetting[1] and 16)=16 then lptsetting[1]:=lptsetting[1] - 16;
    if address=14 then if (lptsetting[1] and 32)=32 then lptsetting[1]:=lptsetting[1] - 32;
    if address=15 then if (lptsetting[1] and 64)=64 then lptsetting[1]:=lptsetting[1] - 64;
    if address=16 then if (lptsetting[1] and 128)=128 then lptsetting[1]:=lptsetting[1] - 128;
  end;
end;

if ((address>16) and (address<=24)) then
begin
  if endvalue>=switchvalue then
  begin
    if address=17 then if (lptsetting[2] and 1)=0 then lptsetting[2]:=lptsetting[2] + 1;
    if address=18 then if (lptsetting[2] and 2)=0 then lptsetting[2]:=lptsetting[2] + 2;
    if address=19 then if (lptsetting[2] and 4)=0 then lptsetting[2]:=lptsetting[2] + 4;
    if address=20 then if (lptsetting[2] and 8)=0 then lptsetting[2]:=lptsetting[2] + 8;
    if address=21 then if (lptsetting[2] and 16)=0 then lptsetting[2]:=lptsetting[2] + 16;
    if address=22 then if (lptsetting[2] and 32)=0 then lptsetting[2]:=lptsetting[2] + 32;
    if address=23 then if (lptsetting[2] and 64)=0 then lptsetting[2]:=lptsetting[2] + 64;
    if address=24 then if (lptsetting[2] and 128)=0 then lptsetting[2]:=lptsetting[2] + 128;
  end else
  begin
    if address=17 then if (lptsetting[2] and 1)=1 then lptsetting[2]:=lptsetting[2] - 1;
    if address=18 then if (lptsetting[2] and 2)=2 then lptsetting[2]:=lptsetting[2] - 2;
    if address=19 then if (lptsetting[2] and 4)=4 then lptsetting[2]:=lptsetting[2] - 4;
    if address=20 then if (lptsetting[2] and 8)=8 then lptsetting[2]:=lptsetting[2] - 8;
    if address=21 then if (lptsetting[2] and 16)=16 then lptsetting[2]:=lptsetting[2] - 16;
    if address=22 then if (lptsetting[2] and 32)=32 then lptsetting[2]:=lptsetting[2] - 32;
    if address=23 then if (lptsetting[2] and 64)=64 then lptsetting[2]:=lptsetting[2] - 64;
    if address=24 then if (lptsetting[2] and 128)=128 then lptsetting[2]:=lptsetting[2] - 128;
  end;
end;

if ((address>24) and (address<=32)) then
begin
  if endvalue>=switchvalue then
  begin
    if address=25 then if (lptsetting[3] and 1)=0 then lptsetting[3]:=lptsetting[3] + 1;
    if address=26 then if (lptsetting[3] and 2)=0 then lptsetting[3]:=lptsetting[3] + 2;
    if address=27 then if (lptsetting[3] and 4)=0 then lptsetting[3]:=lptsetting[3] + 4;
    if address=28 then if (lptsetting[3] and 8)=0 then lptsetting[3]:=lptsetting[3] + 8;
    if address=29 then if (lptsetting[3] and 16)=0 then lptsetting[3]:=lptsetting[3] + 16;
    if address=30 then if (lptsetting[3] and 32)=0 then lptsetting[3]:=lptsetting[3] + 32;
    if address=31 then if (lptsetting[3] and 64)=0 then lptsetting[3]:=lptsetting[3] + 64;
    if address=32 then if (lptsetting[3] and 128)=0 then lptsetting[3]:=lptsetting[3] + 128;
  end else
  begin
    if address=25 then if (lptsetting[3] and 1)=1 then lptsetting[3]:=lptsetting[3] - 1;
    if address=26 then if (lptsetting[3] and 2)=2 then lptsetting[3]:=lptsetting[3] - 2;
    if address=27 then if (lptsetting[3] and 4)=4 then lptsetting[3]:=lptsetting[3] - 4;
    if address=28 then if (lptsetting[3] and 8)=8 then lptsetting[3]:=lptsetting[3] - 8;
    if address=29 then if (lptsetting[3] and 16)=16 then lptsetting[3]:=lptsetting[3] - 16;
    if address=30 then if (lptsetting[3] and 32)=32 then lptsetting[3]:=lptsetting[3] - 32;
    if address=31 then if (lptsetting[3] and 64)=64 then lptsetting[3]:=lptsetting[3] - 64;
    if address=32 then if (lptsetting[3] and 128)=128 then lptsetting[3]:=lptsetting[3] - 128;
  end;
end;

  Out32(lptport+2,0);
  Out32(lptport,0);

  Out32(lptport+2,1);
  Out32(lptport,lptsetting[0]);

  Out32(lptport+2,2);
  Out32(lptport,lptsetting[1]);

  Out32(lptport+2,0);
  Out32(lptport,lptsetting[2]);

  Out32(lptport+2,4);
  Out32(lptport+2,8);
  Out32(lptport,lptsetting[3]);

  Out32(lptport+2,0);
  Out32(lptport,0);
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
