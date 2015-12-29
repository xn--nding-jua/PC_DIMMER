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
  ShuttingDown:=false;
  config:=Tconfig.Create(Application);
  setupform:=tsetupform.create(Application);
  @Config.SetDLLEvent:=CallbackSetDLLValueEvent;
  @Config.SendMSG:=CallbackSendMessage;
end;

procedure DLLStart;stdcall;
begin
  // DLL wird bei FormShow() gestartet
  config.StartUp;
end;

function DLLDestroy:boolean;stdcall;
var
  CurrYear, CurrMonth, CurrDay: Word;
  LReg:TRegistry;
  Month, Day:string;
begin
  ShuttingDown:=true;

  // Letzte Temperaturwerte eintragen
  Config.Memo1.Lines.Add(DateToStr(now)+';'+TimeToStr(now)+';'+
    floattostrf(Config.CurrentTemp, ffFixed, 5, 1)+';'+
    floattostrf(config.CurrentTemp2Mean, ffFixed, 5, 1)+';'+
    floattostrf(config.CurrentTemp3Mean, ffFixed, 5, 1)+';'+
    floattostrf((Config.CurrentTemp-Config.TempVor15Minuten), ffFixed, 5, 1)+';'+
    floattostrf(Config.Kilowattstunden+(7.5*(1/3600)), ffFixed, 5, 6)+';'+
    floattostrf(Config.Kilowattstunden+(7.5*(1/3600))*0.24, ffFixed, 5, 6));

  config.chart.Options.AutoUpdateGraph:=false;
  if config.comport.Connected then
		Config.comport.Disconnect;
  Config.SekundenTimer.Enabled:=false;

  // Datei abspeichern
  if setupform.savefilestoedit.Text<>'' then
  begin
    if not DirectoryExists(setupform.savefilestoedit.Text) then
      CreateDir(setupform.savefilestoedit.Text);
    DecodeDate(Date(), CurrYear, CurrMonth, CurrDay);
    Month:=inttostr(CurrMonth);
    Day:=inttostr(CurrDay);
    if length(Month)<2 then
      Month:='0'+Month;
    if length(Day)<2 then
      Day:='0'+Day;
    Config.Memo1.Lines.SaveToFile(setupform.savefilestoedit.Text+'\'+inttostr(CurrYear)+Month+Day+'_'+
      stringreplace(TimeToStr(now), ':', '', [rfReplaceAll, rfIgnoreCase])+'_Temperatur.csv');
  end;

  Application.ProcessMessages;
  sleep(150);

  Config.Shutdown:=true;

  LReg:=TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;
  LReg.OpenKey('Software', True);
  LReg.OpenKey('PHOENIXstudios', True);
  LReg.OpenKey('PC_DIMMER', True);
  LReg.OpenKey(ExtractFileName(GetModulePath), True);
  LReg.WriteBool('Showing Plugin', config.Showing);
  LReg.Free;

  Application.ProcessMessages;
  sleep(150);

	@config.SetDLLEvent:=nil;

  setupform.release;
	Config.release;

  Application.ProcessMessages;
  sleep(150);

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
  Result := PChar('v1.8');
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
var
  i:integer;
begin
  if ShuttingDown then
    exit;

  case MSG of
    MSG_ACTUALCHANNELVALUE:
    begin
      if Integer(Data1)=round(setupform.temp2_msb.value) then
      begin
        config.temp2msb:=Integer(Data2);
      end;
      if Integer(Data1)=round(setupform.temp2_lsb.value) then
      begin
        config.temp2lsb:=Integer(Data2);
        config.CurrentTemp2[config.CurrentTemp2MeanIndex]:=(((config.temp2msb shl 8)+config.temp2lsb)-550)/10;
        config.CurrentTemp2MeanIndex:=config.CurrentTemp2MeanIndex+1;
        if config.CurrentTemp2MeanIndex>=length(config.CurrentTemp2) then
          config.CurrentTemp2MeanIndex:=0;
      end;

      if Integer(Data1)=round(setupform.temp3_msb.value) then
      begin
        config.temp3msb:=Integer(Data2);
      end;
      if Integer(Data1)=round(setupform.temp3_lsb.value) then
      begin
        config.temp3lsb:=Integer(Data2);
        config.CurrentTemp3[config.CurrentTemp3MeanIndex]:=(((config.temp3msb shl 8)+config.temp3lsb)-550)/10;
        config.CurrentTemp3MeanIndex:=config.CurrentTemp3MeanIndex+1;
        if config.CurrentTemp3MeanIndex>=length(config.CurrentTemp3) then
          config.CurrentTemp3MeanIndex:=0;
      end;

      config.CurrentTemp2Mean:=0;
      config.CurrentTemp3Mean:=0;
      for i:=0 to length(config.CurrentTemp2)-1 do
      begin
        config.CurrentTemp2Mean:=config.CurrentTemp2Mean+config.CurrentTemp2[i];
        config.CurrentTemp3Mean:=config.CurrentTemp3Mean+config.CurrentTemp3[i];
      end;
      config.CurrentTemp2Mean:=config.CurrentTemp2Mean/length(config.CurrentTemp2);
      config.CurrentTemp3Mean:=config.CurrentTemp3Mean/length(config.CurrentTemp3);

      config.temp2lbl.caption:=floattostrf(config.CurrentTemp2Mean, ffFixed, 5, 1)+'°C';
      config.temp3lbl.caption:=floattostrf(config.CurrentTemp3Mean, ffFixed, 5, 1)+'°C';
    end;
    MSG_EDITPLUGINSCENE:
    begin
      Config.Show;
    end;
    MSG_STARTPLUGINSCENE:
    begin
      if string(Data1)='{EB86EDF4-F750-420C-81D9-3023741988E8}' then
      begin
        //Temperaturregler: Ein
        if Config.FirstShow then
        begin
          Config.FirstShow:=false;
          Config.StartUp;
        end;
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
