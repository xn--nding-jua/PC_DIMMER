library temperaturregler;

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
  Graphics,
  Registry,
  configfrm in 'configfrm.pas' {Config},
  setup in 'setup.pas' {setupform},
  messagesystem in 'messagesystem.pas',
  aboutfrm in 'aboutfrm.pas' {About};

var
  ShuttingDown:boolean;
  
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
//  SetProcessAffinityMask(GetCurrentProcess, 1); // 1=CPU0 , 2=CPU1

  ShuttingDown:=false;
  config:=Tconfig.Create(Application);

  @Config.SetDLLEvent:=CallbackSetDLLValueEvent;
  @Config.SendMSG:=CallbackSendMessage;
  @Config.GetDLLValue:=CallbackGetDLLValue;
end;

procedure DLLStart;stdcall;
begin
  config.StartUp;
end;

function DLLDestroy:boolean;stdcall;
var
  CurrYear, CurrMonth, CurrDay: Word;
  LReg:TRegistry;
  Month, Day:string;
begin
  ShuttingDown:=true;

  config.chart.Options.AutoUpdateGraph:=false;
  if config.comport.Connected then
		Config.comport.Disconnect;
  Config.ServiceTimer.Enabled:=false;

  // Datei abspeichern
  if config.setup_logdirectory<>'' then
  begin
    // Letzte Temperaturwerte eintragen
    Config.Memo1.Lines.Add(DateToStr(now)+';'+TimeToStr(now)+';'+
      floattostrf(Config.t_amb, ffFixed, 5, 1)+';'+
      floattostrf(config.TempElements[0].TempMean, ffFixed, 5, 1)+';'+
      floattostrf(config.TempElements[1].TempMean, ffFixed, 5, 1)+';'+
      floattostrf(config.TempElements[2].TempMean, ffFixed, 5, 1)+';'+
      floattostrf((Config.t_amb-Config.TempVorXMinuten), ffFixed, 5, 1)+';'+
      floattostrf(Config.Kilowattstunden+((config.setup_installedpower/1000)*(1/3600)), ffFixed, 5, 6)+';'+
      floattostrf(Config.Kilowattstunden+((config.setup_installedpower/1000)*(1/3600))*(config.setup_priceperkwh/100), ffFixed, 5, 6));

    if not DirectoryExists(config.setup_logdirectory) then
      CreateDir(config.setup_logdirectory);
    DecodeDate(Date(), CurrYear, CurrMonth, CurrDay);
    Month:=inttostr(CurrMonth);
    Day:=inttostr(CurrDay);
    if length(Month)<2 then
      Month:='0'+Month;
    if length(Day)<2 then
      Day:='0'+Day;

    Config.Memo1.Lines.SaveToFile(config.setup_logdirectory+'\'+inttostr(CurrYear)+Month+Day+'_'+
      stringreplace(TimeToStr(now), ':', '', [rfReplaceAll, rfIgnoreCase])+'_Temperatur.csv');
    config.SavePng(config.chart.Picture.Bitmap, config.setup_logdirectory+'\'+inttostr(CurrYear)+Month+Day+'_'+
      stringreplace(TimeToStr(now), ':', '', [rfReplaceAll, rfIgnoreCase])+'_Temperatur.png');
  end;

  Config.Shutdown:=true;
  @Config.SetDLLEvent:=nil;
  @Config.SendMSG:=nil;
  @Config.GetDLLValue:=nil;

  LReg:=TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  LReg.OpenKey('Software', True);
  LReg.OpenKey('PHOENIXstudios', True);
  LReg.OpenKey('PC_DIMMER', True);
  LReg.OpenKey(ExtractFileName(GetModulePath), True);
  LReg.WriteBool('Showing Plugin', config.Showing);
  LReg.CloseKey;
  LReg.Free;

  config.close;
	Config.Release;

  Result:=True;
end;

function DLLIdentify:PChar;stdcall;
begin
  Result:=PChar('Input');
end;

function DLLGetName:PChar;stdcall;
begin
  Result := PChar('Temperaturregler');
end;

function DLLGetVersion:PChar;stdcall;
begin
  Result := PChar('v2.5');
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
  Config.Show;
end;

procedure DLLAbout;stdcall;
begin
  about := tabout.Create(nil);
  about.ShowModal;
  about.release;
end;

procedure DLLSendData(address, startvalue, endvalue, fadetime:integer;name:PChar);stdcall;
begin
end;

procedure DLLSendMessage(MSG:Byte; Data1, Data2:Variant);stdcall;
begin
  if ShuttingDown then
    exit;

  try
    case MSG of
      MSG_ACTUALCHANNELVALUE:
      begin
      end;
      MSG_EDITPLUGINSCENE:
      begin
      if (string(Data1)='{EB86EDF4-F750-420C-81D9-3023741988E8}') or
        (string(Data1)='{4950EE57-ACAC-4BB3-ACA6-9CBD4D9F1B56}') then
        Config.Show;
      end;
      MSG_STARTPLUGINSCENE:
      begin
        if string(Data1)='{EB86EDF4-F750-420C-81D9-3023741988E8}' then
        begin
          //Temperaturregler: Ein
          Config.tempon.StateOn:=true;
          Config.tempon.OnOn(nil);
        end;
        if string(Data1)='{4950EE57-ACAC-4BB3-ACA6-9CBD4D9F1B56}' then
        begin
          //Temperaturregler: Aus
          Config.tempon.StateOn:=false;
          Config.tempon.OnOff(nil);
        end;
      end;
    end;
  except
  end;
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
