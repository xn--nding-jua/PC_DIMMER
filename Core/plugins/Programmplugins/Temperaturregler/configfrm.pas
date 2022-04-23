unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry, Mask, JvExMask,
  JvSpin, JvExControls, JvSwitch, ComCtrls, JvSimScope, JvLED, gnugettext,
  messagesystem, JvChart, pngimage, IdHttp, DECCipher, DECHash, DECFmt,
  DECRandom;

const
  blowfishscramblekey = 'rejnbfui34w87fr243hf8bv8734g38zbf873cb48';

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  TTempElement = record
    Source:byte; // 0=offline, 1=uart, 2=http, 3=dmx
    name:string[255];
    http_setting:array[0..4] of string[255]; // url, nutzer, password, start-string, stop-string
    dmx_setting:array[0..1] of word; // msb, lsb
    percentage:single;
    mean_max:byte;

    TempSensorRawValue:single;
    TempValues:array[0..14] of Single;
    TempNonZeroCount:integer;
    TempMean:single;
    TempMeanIndex:integer;
  end;
  TConfig = class(TForm)
    comport: TCommPortDriver;
    ServiceTimer: TTimer;
    RegisterPluginCommands: TTimer;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    deltatemplbl: TLabel;
    Label33: TLabel;
    stromverbrauchlbl: TLabel;
    stromkostenlbl: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    tempcurrentlbl: TLabel;
    Label14: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    heizenled: TJvLED;
    Label8: TLabel;
    Label26: TLabel;
    hystereseled: TJvLED;
    tempokled: TJvLED;
    Label27: TLabel;
    nachtabsled: TJvLED;
    Label24: TLabel;
    Label9: TLabel;
    tempon: TJvSwitch;
    Button1: TButton;
    GroupBox5: TGroupBox;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    CheckBox2: TCheckBox;
    absenkung_h_startedit: TJvSpinEdit;
    absenkung_min_startedit: TJvSpinEdit;
    absenkung_h_stopedit: TJvSpinEdit;
    absenkung_min_stopedit: TJvSpinEdit;
    absenkung_temp: TJvSpinEdit;
    GroupBox6: TGroupBox;
    Label13: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    tempsoll: TJvSpinEdit;
    tempmin: TJvSpinEdit;
    tempmax: TJvSpinEdit;
    Button2: TButton;
    GroupBox7: TGroupBox;
    tempminlbl: TLabel;
    tempmeanlbl: TLabel;
    tempmaxlbl: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label34: TLabel;
    TimeToSollwertLbl: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    chart: TJvChart;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Button3: TButton;
    Button4: TButton;
    ch1lbl: TLabel;
    ch2lbl: TLabel;
    ch3lbl: TLabel;
    ch4lbl: TLabel;
    ch8lbl: TLabel;
    ch7lbl: TLabel;
    ch6lbl: TLabel;
    ch5lbl: TLabel;
    label35: TLabel;
    procedure comportReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure ActivateCOMPort(portnumber, baudrate: integer);
    procedure tempminChange(Sender: TObject);
    procedure tempmaxChange(Sender: TObject);
    procedure temponOn(Sender: TObject);
    procedure temponOff(Sender: TObject);
    procedure ServiceTimerTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RegisterPluginCommandsTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
    function EncryptPwd(Pwd: string):string;
    function DecryptPwd(Pwd: string):string;
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    Shutdown:boolean;

    TempElements:array[0..7] of TTempElement;
    t_amb:single;

    Nachtabsenkung:integer;
    TempVorXMinuten:Single;
    ServiceTimerCounter:integer;
    FuenfzehnminutenCounter:Word;
    RegelungNeuGestartet:Boolean;
    Heizbetrieb:Boolean;
    Strompreis, Kilowattstunden:Single;

    GrowingIndex:integer;
    OverallMin, OverallMax:double;

    SetDLLValues:TCallbackValues;
    SetDLLEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;

    setup_autoconnect:boolean;
    setup_mixmsblsb:boolean;
    setup_datain_temp, setup_datain_min, setup_datain_mean, setup_datain_max, setup_datain_heateron:double;
    setup_scale:double;
    setup_logdirectory:string;
    setup_installedpower:double;
    setup_priceperkwh:double;
    setup_deltattime:double;

    function CalcMaximum:Single;
    function CalcMinimum:Single;
    function CalcMean:Single;
    function RoundToByte(Temperatur: Single):Byte;
    procedure StartUp;
    procedure SavePng(Bitmap: TBitmap; Destination:string);
    function GetHTTPTemperature(channel: integer):double;
  end;

var
  Config: TConfig;

implementation

uses
  JwaWinType,
  SetupApi, Cfg, CfgMgr32, setup;

{$R *.dfm}

// Delphi wrapper for CM_Get_Device_ID

function GetDeviceID(Inst: DEVINST): string;
var
  Buffer: PTSTR;
  Size: ULONG;
begin
  CM_Get_Device_ID_Size(Size, Inst, 0);
  // Required! See DDK help for CM_Get_Device_ID
  Inc(Size);
  Buffer := AllocMem(Size * SizeOf(TCHAR));
  CM_Get_Device_ID(Inst, Buffer, Size, 0);
  Result := Buffer;
  FreeMem(Buffer);
end;

// Delphi wrapper for SetupDiGetDeviceRegistryProperty

function GetRegistryPropertyString(PnPHandle: HDEVINFO; const DevData: TSPDevInfoData; Prop: DWORD): string;
var
  BytesReturned: DWORD;
  RegDataType: DWORD;
  Buffer: array [0..1023] of TCHAR;
begin
  BytesReturned := 0;
  RegDataType := 0;
  Buffer[0] := #0;
  SetupDiGetDeviceRegistryProperty(PnPHandle, DevData, Prop,
    RegDataType, PByte(@Buffer[0]), SizeOf(Buffer), BytesReturned);
  Result := Buffer;
end;

function ExtractBus(DeviceID: string): string;
begin
  Result := Copy(DeviceID, 1, Pos('\', DeviceID) - 1);
end;

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

// Code for HTTP-Sensor
function GetURLAsString(const aURL, Username, Password: string): string;
var
  lHTTP: TIdHTTP;
  webpage:string;
begin
  webpage:='';

  lHTTP := TIdHTTP.Create;
  lHTTP.Request.Clear;
  lHTTP.ReadTimeout:=5000;
  lHTTP.RedirectMaximum:=15;
  lHTTP.HandleRedirects:=true;

  if (Username<>'') and (Password<>'') then
  begin
    lHTTP.Request.BasicAuthentication:= true;
    lHTTP.Request.Username := Username;
    lHTTP.Request.Password := Password;
  end;

  try
    webpage:=lHTTP.Get(aURL);
  finally
    lHTTP.Free;
  end;

  Result:=webpage;
end;

function TConfig.GetHTTPTemperature(channel: integer):double;
var
  website:string;
  temperature:string;
begin
  website:=GetURLAsString(TempElements[channel].http_setting[0], TempElements[channel].http_setting[1], DecryptPwd(TempElements[channel].http_setting[2]));

  if website<>'' then
  begin
    temperature:=copy(website, pos(TempElements[channel].http_setting[3], website)+length(TempElements[channel].http_setting[3]), 10);
    temperature:=copy(temperature, 1, pos(TempElements[channel].http_setting[4], temperature)-1);

    temperature:=stringreplace(temperature, '.', ',', []);

    try
      result:=strtofloat(temperature);
    except
      result:=-999.9;
    end;
  end else
  begin
    result:=-999.9;
  end;
end;

procedure TConfig.comportReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
var
  i: integer;
  s, ss: string;
  t_uart_temp:single;
begin
  try
    // Convert incoming data into a string
    s := StringOfChar( ' ', DataSize );
    move( DataPtr^, pchar(s)^, DataSize );
    // Exit if s is empty. This usually occurs when one or more NULL characters
    // (chr(0)) are received.

  //  while pos( #0, s ) > 0 do
  //    delete( s, pos( #0, s ), 1 );
    if s = '' then
      exit;

    // Remove line feeds from the string
    i := pos( #10, s );
    while i <> 0 do
    begin
      delete( s, i, 1 );
      i := pos( #10, s );
    end;
    // Remove carriage returns from the string (break lines)
    i := pos( #13, s );

    while i <> 0 do
    begin
      ss := copy( s, 1, i-1 );
      delete( s, 1, i );
      i := pos( #13, s );
    end;

    if (length(ss)>2) and (ss[1]='A') and (ss[length(ss)]='E') then
    begin
      // "A" und "E" aus Nachricht entfernen
      ss:=copy(ss, 2, length(ss)-2);

      if setup_mixmsblsb then
      begin
        t_uart_temp:=integer(ss[1]) shl 8;
        t_uart_temp:=t_uart_temp+integer(ss[2]);
      end else
      begin
        t_uart_temp:=integer(ss[2]) shl 8;
        t_uart_temp:=t_uart_temp+integer(ss[1]);
      end;

      for i:=0 to length(TempElements)-1 do
      begin
        if TempElements[i].Source=1 then
          TempElements[i].TempSensorRawValue:=((t_uart_temp/2047)*200)-50;
      end;
    end;
  except
  end;
end;

procedure TConfig.ActivateCOMPort(portnumber, baudrate: integer);
begin
  if comport.Connected then
    comport.Disconnect;
  case portnumber of
    1: comport.port:=pnCOM1;   2: comport.port:=pnCOM2;
    3: comport.port:=pnCOM3;   4: comport.port:=pnCOM4;
    5: comport.port:=pnCOM5;   6: comport.port:=pnCOM6;
    7: comport.port:=pnCOM7;   8: comport.port:=pnCOM8;
    9: comport.port:=pnCOM9;   10: comport.port:=pnCOM10;
    11: comport.port:=pnCOM11;   12: comport.port:=pnCOM12;
    13: comport.port:=pnCOM13;   14: comport.port:=pnCOM14;
    15: comport.port:=pnCOM15;   16: comport.port:=pnCOM16;
  end;
  comport.BaudRateValue:=baudrate;
  comport.Connect;
end;

procedure TConfig.tempminChange(Sender: TObject);
begin
  if tempmin.Value>tempmax.value then
    tempmin.value:=tempmax.value;
end;

procedure TConfig.tempmaxChange(Sender: TObject);
begin
  if tempmax.Value<tempmin.value then
    tempmax.value:=tempmin.value;
end;

procedure TConfig.temponOn(Sender: TObject);
begin
  RegelungNeuGestartet:=true;
  label14.Caption:=_('Temperaturregler aktiviert...');
  label14.Font.Color:=clBlack;
end;

procedure TConfig.temponOff(Sender: TObject);
begin
  label14.Caption:=_('Temperaturregler deaktiviert...');
  label14.Font.Color:=clBlack;
end;

function TConfig.CalcMaximum:Single;
var
  i:integer;
  maxvalue:double;
begin
  maxvalue:=-200;
  for i:=GrowingIndex-1 downto GrowingIndex-16 do
  begin
    if (chart.Data.ValueCount>0) and (i<chart.Data.ValueCount) and (i>0) and (chart.Options.PenCount>0) then
    begin
      if chart.data.Value[0, i]>maxvalue then
        maxvalue:=chart.data.Value[0, i];
    end;
  end;
  result:=maxvalue;
end;

function TConfig.CalcMinimum:Single;
var
  i:integer;
  minvalue:double;
begin
  minvalue:=200;
  for i:=GrowingIndex-1 downto GrowingIndex-16 do
  begin
    if (chart.Data.ValueCount>0) and (i<chart.Data.ValueCount) and (i>0) and (chart.Options.PenCount>0) then
    begin
      if chart.data.Value[0, i]<minvalue then
        minvalue:=chart.data.Value[0, i];
    end;
  end;
  result:=minvalue;
end;

function TConfig.CalcMean:Single;
var
  i, Values:integer;
  Mean:Double;
begin
  Mean:=0;
  Values:=0;
  for i:=GrowingIndex-1 downto GrowingIndex-16 do
  begin
    if (chart.Data.ValueCount>0) and (i<chart.Data.ValueCount) and (i>0) and (chart.Options.PenCount>0) then
    begin
      Mean:=Mean+chart.data.Value[0, i];
      inc(Values);
    end;
  end;
  if Values>0 then
    Mean:=Mean/Values;

  result:=Mean;
end;

procedure TConfig.ServiceTimerTimer(Sender: TObject);
var
  ReglerTemperaturWert:Single;
  TempMinVal, TempMeanVal, TempMaxVal:Single;
  Tagesminuten:Word;
  HttpTemperature:double;

  ZeitBisSollwert:Single;
  ZeitBisSollwert_h, ZeitBisSollwert_min: integer;

  i,j:integer;

  displaymax, displaymin:double;
begin
  // ServiceTimer wird jede Sekunden aufgerufen
  try
    ServiceTimerCounter:=ServiceTimerCounter+1;
    if config.Showing then
    begin
      label35.caption:=inttostr(round(60-ServiceTimerCounter))+'s';
    end;

    if ServiceTimerCounter>59 then
    begin
      // 60 Sekunden sind um
      ServiceTimerCounter:=0;

      for i:=0 to length(TempElements)-1 do
      begin
        // UART-Werte (Source=1) werden direkt in UART-Empfangsroutine eingetragen
        if TempElements[i].Source=0 then
        begin
          // Offline
          TempElements[i].TempSensorRawValue:=0;
        end else if TempElements[i].Source=2 then
        begin
          // HTTP-Werte
          HttpTemperature:=GetHTTPTemperature(i);
          if HttpTemperature>-999.9 then
            TempElements[i].TempSensorRawValue:=HttpTemperature;
        end else if TempElements[i].Source=3 then
        begin
          // DMX-Werte
          TempElements[i].TempSensorRawValue:=(((GetDLLValue(TempElements[i].dmx_setting[0]) shl 8)+GetDLLValue(TempElements[i].dmx_setting[1]))-550)/10;
        end;
      end;

      if (GrowingIndex=0) then
      begin
        // Startup
        for i:=0 to length(TempElements)-1 do
        begin
          TempElements[i].TempMeanIndex:=TempElements[i].mean_max;

          for j:=0 to length(TempElements[i].TempValues)-1 do
          begin
            TempElements[i].TempValues[j]:=TempElements[i].TempSensorRawValue; // flood the whole array with the first read value
          end;
        end;
      end else
      begin
        // Normalbetrieb

        // Aktuellen Temperaturwert in Ringbuffer für Mittelwert schreiben (1..15 Werte alle 60s = 1..15 Minuten)
        for i:=0 to length(TempElements)-1 do
        begin
          TempElements[i].TempMeanIndex:=TempElements[i].TempMeanIndex+1;
          if TempElements[i].TempMeanIndex>=TempElements[i].mean_max then
            TempElements[i].TempMeanIndex:=0;

          TempElements[i].TempValues[TempElements[i].TempMeanIndex]:=TempElements[i].TempSensorRawValue; // 0 .. MeanMax-1
        end;
      end;

      for i:=0 to length(TempElements)-1 do
      begin
        // Mittelwert über alle Messwerte bilden
        TempElements[i].TempMean:=0;
        TempElements[i].TempNonZeroCount:=0;
        for j:=0 to TempElements[i].mean_max-1 do
        begin
          if TempElements[i].TempValues[j]<>0 then
          begin
            TempElements[i].TempMean:=TempElements[i].TempMean+TempElements[i].TempValues[j];
            TempElements[i].TempNonZeroCount:=TempElements[i].TempNonZeroCount+1;
          end;
        end;

        if TempElements[i].TempNonZeroCount>0 then
          TempElements[i].TempMean:=TempElements[i].TempMean/TempElements[i].TempNonZeroCount;
      end;

      t_amb:=0;
      for i:=0 to length(TempElements)-1 do
      begin
        t_amb:=t_amb+(TempElements[i].TempMean*TempElements[i].percentage);
      end;

      // Temperaturen in Scope schreiben
      chart.Data.Timestamp[GrowingIndex]:=now;
      chart.Data.Value[0, GrowingIndex]:=t_amb;
      chart.Data.Value[1, GrowingIndex]:=(tempsoll.value+Nachtabsenkung+tempmax.value);
      chart.Data.Value[2, GrowingIndex]:=(tempsoll.value+Nachtabsenkung+tempmin.value);
      chart.Data.Value[3, GrowingIndex]:=TempElements[0].TempMean;
      chart.Data.Value[4, GrowingIndex]:=TempElements[1].TempMean;
      chart.Data.Value[5, GrowingIndex]:=TempElements[2].TempMean;
      chart.Data.Value[6, GrowingIndex]:=TempElements[3].TempMean;
      chart.Data.Value[7, GrowingIndex]:=TempElements[4].TempMean;
      GrowingIndex:=GrowingIndex+1;

      TempMinVal:=CalcMinimum;
      TempMeanVal:=CalcMean;
      TempMaxVal:=CalcMaximum;

      if GrowingIndex>5 then
      begin
        OverallMin:=200;
        OverallMax:=-200;
        for i:=5 to GrowingIndex-1 do
        begin
          if chart.Data.Value[0, i]<OverallMin then
            OverallMin:=chart.Data.Value[0, i];
          if chart.Data.Value[0, i]>OverallMax then
            OverallMax:=chart.Data.Value[0, i];
        end;
      end else
      begin
        OverallMin:=-10;
        OverallMax:=35;
      end;

      displaymax:=(tempsoll.value+Nachtabsenkung+tempmax.value);
      if (tempsoll.value+Nachtabsenkung+tempmin.value)>displaymax then
        displaymax:=(tempsoll.value+Nachtabsenkung+tempmin.value);
      if OverallMax>displaymax then
        displaymax:=OverallMax;

      displaymin:=(tempsoll.value+Nachtabsenkung+tempmax.value);
      if (tempsoll.value+Nachtabsenkung+tempmin.value)<displaymin then
        displaymin:=(tempsoll.value+Nachtabsenkung+tempmin.value);
      if OverallMin<displaymin then
        displaymin:=OverallMin;

      chart.Options.PrimaryYAxis.YMax:=round(trunc(displaymax/5)+0.99)*5;
      chart.Options.PrimaryYAxis.YMin:=round(trunc(displaymin/5)-0.99)*5;
      chart.Options.PrimaryYAxis.YDivisions:=trunc((chart.Options.PrimaryYAxis.YMax / 5) + (abs(chart.Options.PrimaryYAxis.YMin) / 5));

      // Temperatur in Label anzeigen
      if config.Showing then
      begin
        tempcurrentlbl.Caption:=floattostrf(t_amb, ffFixed, 5, 1)+'°C';
        tempminlbl.Caption:=floattostrf(TempMinVal, ffFixed, 5, 1)+'°C';
        tempmeanlbl.Caption:=floattostrf(TempMeanVal, ffFixed, 5, 1)+'°C';
        tempmaxlbl.Caption:=floattostrf(TempMaxVal, ffFixed, 5, 1)+'°C';

        for i:=0 to 7 do
        begin
          TLabel(FindComponent('ch'+inttostr(i+1)+'lbl')).Caption:=TempElements[i].name+': '+floattostrf(TempElements[i].TempSensorRawValue, ffFixed, 5, 1)+'°C / '+floattostrf(TempElements[i].TempMean, ffFixed, 5, 1)+'°C';
        end;
      end;

      // Aktuelle Temperatur als Kanalwert an PC_DIMMER senden
      if round(setup_datain_temp)>0 then
        SetDLLEvent(round(setup_datain_temp), RoundToByte(t_amb));
      // Minimale Temperatur als Kanalwert an PC_DIMMER senden
      if round(setup_datain_min)>0 then
        SetDLLEvent(round(setup_datain_min), RoundToByte(TempMinVal));
      // Mittelwert der Temperatur als Kanalwert an PC_DIMMER senden
      if round(setup_datain_mean)>0 then
        SetDLLEvent(round(setup_datain_mean), RoundToByte(TempMeanVal));
      // Maximale Temperatur als Kanalwert an PC_DIMMER senden
      if round(setup_datain_max)>0 then
        SetDLLEvent(round(setup_datain_max), RoundToByte(TempMaxVal));


      if tempon.StateOn then
      begin
        ReglerTemperaturWert:=t_amb; // Alternativ TempMeanVal, oder eine der anderen Tempeaturen: TempElements[...].TempMean

        // Nachtabsenkung
        if Checkbox2.Checked then
        begin
          Tagesminuten:=strtoint(copy(TimeToStr(now), 1, 2))*60; // Stunden zu Minuten
          Tagesminuten:=Tagesminuten+strtoint(copy(TimeToStr(now), 4, 2)); // Minuten

          // Nachtabsenkung zwischen 22:30 = 1350 und 05:00 = 300
          if (Tagesminuten>=((absenkung_h_startedit.value*60)+absenkung_min_startedit.value)) or (Tagesminuten<=((absenkung_h_stopedit.value*60)+absenkung_min_stopedit.value)) then
          begin
            nachtabsled.Status:=true;
            Nachtabsenkung:=round(absenkung_temp.value); // 7°C weniger als Solltemperatur
          end else
          begin
            nachtabsled.Status:=false;
            Nachtabsenkung:=0; // keine Absenkung
          end;
        end else
        begin
          nachtabsled.Status:=false;
          Nachtabsenkung:=0; // keine Absenkung
        end;

        if ReglerTemperaturWert>(tempsoll.value+Nachtabsenkung+tempmax.Value) then
        begin
          // Zu Warm -> Ausschalten
          if round(setup_datain_heateron)>0 then
            SetDLLEvent(round(setup_datain_heateron), 0);
          Heizbetrieb:=false;
          heizenled.active:=false;
          heizenled.status:=false;
          label14.Caption:=_('Heizung aus');
          label14.Font.Color:=clBlack;
        end;
        tempokled.Status:=(ReglerTemperaturWert>(tempsoll.value+Nachtabsenkung+tempmax.Value));

        if ReglerTemperaturWert<(tempsoll.value+Nachtabsenkung+tempmin.Value) then
        begin
          // Zu Kalt -> Einschalten
          if round(setup_datain_heateron)>0 then
            SetDLLEvent(round(setup_datain_heateron), 255);
          Heizbetrieb:=true;
          heizenled.active:=true;
          label14.Caption:=_('Heizung ein');
          label14.Font.Color:=clRed;
        end;

        if (ReglerTemperaturWert>(tempsoll.value+Nachtabsenkung+tempmin.Value)) and (ReglerTemperaturWert<(tempsoll.value+Nachtabsenkung+tempmax.Value)) then
        begin
          // Temperatur im Hysteresebereich
          if RegelungNeuGestartet then
          begin
            // Aufheizen, da Sollwert noch nicht erreicht und Regelung gerade eingeschaltet
            RegelungNeuGestartet:=false;
            if round(setup_datain_heateron)>0 then
              SetDLLEvent(round(setup_datain_heateron), 255);
            Heizbetrieb:=true;
            heizenled.active:=true;
            label14.Caption:=_('Heizung ein');
            label14.Font.Color:=clRed;
            hystereseled.status:=false;
          end else
          begin
            // -> nichts ändern (Hysteresebetrieb)
            if Heizbetrieb then
            begin
              // Im Begriff des Aufheizens
              label14.Caption:=_('Heizung ein');
              label14.Font.Color:=clRed;
              hystereseled.status:=false;
            end else
            begin
              label14.Caption:=_('Heizung aus (Hysterese)');
              label14.Font.Color:=clGreen;
              hystereseled.status:=true;
            end;
          end;
        end else
        begin
          hystereseled.status:=false;
        end;
      end else
      begin
        // Regelung ausgeschaltet
        if round(setup_datain_heateron)>0 then
          SetDLLEvent(round(setup_datain_heateron), 0);
        Heizbetrieb:=false;
        tempokled.Status:=false;
        hystereseled.status:=false;
        heizenled.active:=false;
        heizenled.status:=false;
      end;


      // Berechnung von Delta-T alle x Minuten
      inc(FuenfzehnminutenCounter);
      if FuenfzehnminutenCounter>=round(setup_deltattime) then
      begin
        // x Minuten sind um
        FuenfzehnminutenCounter:=0;

        if TempVorXMinuten>-1000 then
        begin
          // Temperaturänderung anzeigen
          deltatemplbl.caption:=floattostrf((t_amb-TempVorXMinuten), ffFixed, 5, 1)+'°C';
          if (t_amb-TempVorXMinuten)>0 then
          begin
            deltatemplbl.Font.Color:=clGreen;
          end else if (t_amb-TempVorXMinuten)<0 then
          begin
            deltatemplbl.Font.Color:=clRed;
          end else
          begin
            deltatemplbl.Font.Color:=clBlack;
          end;

          // Zeit bis zum Erreichen des Sollwertes anzeigen
          begin
            ZeitBisSollwert:=(tempsoll.value-t_amb)/((t_amb-TempVorXMinuten)/round(setup_deltattime)); // Zeit in Minuten bis Sollwert erreicht wird
            if ZeitBisSollwert<0 then
            begin
              TimeToSollwertLbl.caption:='...';
            end else
            begin
              ZeitBisSollwert_h:=trunc(ZeitBisSollwert/60);
              ZeitBisSollwert_min:=round(ZeitBisSollwert-(60*ZeitBisSollwert_h));
              TimeToSollwertLbl.caption:=inttostr(ZeitBisSollwert_h)+'h '+inttostr(ZeitBisSollwert_min)+'min'
            end;
          end;
        end;
        // Temperaturwerte und Kosten in CSV-Datei speichern
        Memo1.Lines.Add(DateToStr(now)+';'+TimeToStr(now)+';'+
          floattostrf(t_amb, ffFixed, 5, 1)+';'+
          floattostrf(config.TempElements[0].TempMean, ffFixed, 5, 1)+';'+
          floattostrf(config.TempElements[1].TempMean, ffFixed, 5, 1)+';'+
          floattostrf(config.TempElements[2].TempMean, ffFixed, 5, 1)+';'+
          floattostrf((t_amb-TempVorXMinuten), ffFixed, 5, 1)+';'+
          floattostrf(Kilowattstunden+((setup_installedpower/1000)*(1/3600)), ffFixed, 5, 6)+';'+
          floattostrf(Kilowattstunden+((setup_installedpower/1000)*(1/3600))*(setup_priceperkwh/100), ffFixed, 5, 6));

        TempVorXMinuten:=t_amb;
      end;
    end; // End of 60s timer

    // Berechnen des Strompreises
    if Heizbetrieb then
    begin
      Kilowattstunden:=Kilowattstunden+((setup_installedpower/1000)*(1/3600)); // ?.?kW*(1/3600) --> kWh
      Strompreis:=Kilowattstunden*(setup_priceperkwh/100); //kWh * ?.??ct/kWh --> Preis

      stromverbrauchlbl.Caption:=floattostrf(Kilowattstunden, ffFixed, 5, 3)+' kWh';
      stromkostenlbl.Caption:=floattostrf(Strompreis, ffFixed, 5, 2)+' €';
    end;
  except
  end;
end;

function TConfig.RoundToByte(Temperatur: Single):Byte;
var
  TempInteger:integer;
begin
  TempInteger:=round(Temperatur*setup_scale);
  if TempInteger>255 then
    TempInteger:=255
  else if TempInteger<0 then
    TempInteger:=0;
  result:=TempInteger;
end;

procedure TConfig.FormHide(Sender: TObject);
var
  LReg:TRegistry;
  i:integer;
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
          LReg.WriteInteger('COMPort',comportnumber);
    	    LReg.WriteInteger('Baudrate',baudrate);

          // Generelle Einstellungen
          LReg.WriteBool('AutoConnectComPort', setup_autoconnect);
          LReg.WriteBool('Vertausche L und H', setup_mixmsblsb);
          LReg.WriteBool('Regler ein', tempon.StateOn);

          // Temperatureinstellungen
          LReg.WriteFloat('Temperatursollwert', tempsoll.Value);
          LReg.WriteFloat('Einschaltschwelle', tempmin.Value);
          LReg.WriteFloat('Ausschaltschwelle', tempmax.Value);

          // Nachtabsenkung
          LReg.WriteBool('Verwende Nachtabsenkung', Checkbox2.Checked);
          LReg.WriteInteger('Absenkung um',round(absenkung_temp.value));
          LReg.WriteInteger('Absenkung ab h',round(absenkung_h_startedit.value));
          LReg.WriteInteger('Absenkung ab min',round(absenkung_min_startedit.value));
          LReg.WriteInteger('Absenkung bis h',round(absenkung_h_stopedit.value));
          LReg.WriteInteger('Absenkung bis min',round(absenkung_min_stopedit.value));

          // Erweiterte Einstellungen
          LReg.WriteInteger('ChTemp', round(setup_datain_temp));
          LReg.WriteInteger('ChMin', round(setup_datain_min));
          LReg.WriteInteger('ChMean', round(setup_datain_mean));
          LReg.WriteInteger('ChMax', round(setup_datain_max));
          LReg.WriteInteger('ChHeizungEin', round(setup_datain_heateron));
          LReg.WriteFloat('Skalierungsfaktor', setup_scale);

          // Sonstige Einstellungen
          LReg.WriteInteger('Installierte elektrische Leistung', round(setup_installedpower));
          LReg.WriteFloat('Preis pro kWh', setup_priceperkwh);
          LReg.WriteFloat('Zeit für Delta T', setup_deltattime);

          // Verzeichnis für Dateien speichern
          LReg.WriteString('Datafolder', setup_logdirectory);

          // Sensor-Einstellungen
          for i:=0 to length(TempElements)-1 do
          begin
            LReg.CloseKey;
            if LReg.OpenKey('Software\PHOENIXstudios\PC_DIMMER\'+ExtractFileName(GetModulePath)+'\TempElement'+inttostr(i+1), true) then
            begin
              LReg.WriteInteger('Source', TempElements[i].Source);
              LReg.WriteString('Name', TempElements[i].Name);
              LReg.WriteString('HTTP1', TempElements[i].http_setting[0]);
              LReg.WriteString('HTTP2', TempElements[i].http_setting[1]);
              LReg.WriteString('HTTP3', TempElements[i].http_setting[2]);
              LReg.WriteString('HTTP4', TempElements[i].http_setting[3]);
              LReg.WriteString('HTTP5', TempElements[i].http_setting[4]);
              LReg.WriteInteger('DMX1', TempElements[i].dmx_setting[0]);
              LReg.WriteInteger('DMX2', TempElements[i].dmx_setting[1]);
              LReg.WriteFloat('Percentage', TempElements[i].percentage);
              LReg.WriteInteger('MeanMax', TempElements[i].mean_max);
            end;
          end;
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=Shutdown;
  if not Shutdown then
    Hide;
end;

procedure TConfig.Button1Click(Sender: TObject);
const
  GUID_DEVINTERFACE_COMPORT: TGUID                = '{86e0d1e0-8089-11d0-9ce4-08003e301f73}';
  GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR: TGUID = '{4D36E978-E325-11CE-BFC1-08002BE10318}';
var
  PnPHandle: HDEVINFO;
  DevData: TSPDevInfoData;
  DeviceInterfaceData: TSPDeviceInterfaceData;
  FunctionClassDeviceData: PSPDeviceInterfaceDetailData;
  Success: LongBool;
  Devn: Integer;
  BytesReturned: DWORD;
  SerialGUID: TGUID;
  Inst: DEVINST;
  RegKey: HKEY;
  RegBuffer: array [0..1023] of Char;
  RegSize, RegType: DWORD;
  FriendlyName: string;
  PortName: string;
  DeviceDescription: string;
  Bus: string;
  i:integer;


  temp:string;
  TestHandle:THAndle;
begin
  setupform:=tsetupform.create(nil);

  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;

  // enumerate all serial devices (COM port devices)
  SerialGUID := GUID_DEVINTERFACE_COMPORT;
//  SerialGUID := GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR;
  PnPHandle := SetupDiGetClassDevs(@SerialGUID, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
  if PnPHandle = INVALID_HANDLE_VALUE then   // Pointer()
    Exit;

  setupform.portchange.Items.BeginUpdate;
  setupform.portchange.Items.Clear;
  Devn := 0;
  repeat
    DeviceInterfaceData.cbSize := SizeOf(TSPDeviceInterfaceData);
    Success := SetupDiEnumDeviceInterfaces(PnPHandle, nil, SerialGUID, Devn, DeviceInterfaceData);
    if Success then
    begin
      TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(Devn+1)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
//    	if (TestHandle > 0) then
      begin
        DevData.cbSize := SizeOf(DevData);
        BytesReturned := 0;
        // get size required for call
        SetupDiGetDeviceInterfaceDetail(PnPHandle, @DeviceInterfaceData, nil, 0, BytesReturned, @DevData);
        if (BytesReturned <> 0) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
        begin
          // allocate buffer and initialize it for call
          FunctionClassDeviceData := AllocMem(BytesReturned);
          FunctionClassDeviceData.cbSize := SizeOf(TSPDeviceInterfaceDetailData);

          if SetupDiGetDeviceInterfaceDetail(PnPHandle, @DeviceInterfaceData,
            FunctionClassDeviceData, BytesReturned, BytesReturned, @DevData) then
          begin
            // gives the friendly name of the device as shown in Device Manager
            FriendlyName := GetRegistryPropertyString(PnPHandle, DevData, SPDRP_FRIENDLYNAME);
            // gives a device description
            DeviceDescription := GetRegistryPropertyString(PnPHandle, DevData, SPDRP_DEVICEDESC);
            // now try to get the assigned COM port name
            RegKey := SetupDiOpenDevRegKey(PnPHandle, DevData, DICS_FLAG_GLOBAL, 0, DIREG_DEV, KEY_READ);
            RegType := REG_SZ;
            RegSize := SizeOf(RegBuffer);
            RegQueryValueEx(RegKey, 'PortName', nil, @RegType, @RegBuffer[0], @RegSize);
            RegCloseKey(RegKey);
            PortName := RegBuffer;
            Inst := DevData.DevInst;
            CM_Get_Parent(Inst, Inst, 0);
            Bus := ExtractBus(GetDeviceID(Inst));
            setupform.portchange.Items.Add(PortName + ' (' + DeviceDescription + ', ' + Bus+')');
          end;
          FreeMem(FunctionClassDeviceData);
        end;
      end;
	    CloseHandle(TestHandle);
    end;
    Inc(Devn);
  until not Success;
  SetupDiDestroyDeviceInfoList(PnPHandle);
  setupform.portchange.Items.EndUpdate;

  setupform.portchange.Visible:=(setupform.portchange.Items.Count>0);

  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;


{
  // COM-Ports von 1 bis 16 abklappern
	setupform.portchange.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    setupform.portchange.Items.Add('COM'+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;
}

  Application.ProcessMessages;
  sleep(150);

  setupform.portchange.Visible:=(setupform.portchange.Items.Count>0);

  setupform.autoconnectcheckbox.Checked:=setup_autoconnect;
  setupform.checkbox2.Checked:=setup_mixmsblsb;
  setupform.datainchtemp.value:=setup_datain_temp;
  setupform.datainchmin.value:=setup_datain_min;
  setupform.datainchmean.value:=setup_datain_mean;
  setupform.datainchmax.value:=setup_datain_max;
  setupform.datainchon.value:=setup_datain_heateron;
  setupform.TempFaktor.value:=setup_scale;
  setupform.savefilestoedit.Text:=setup_logdirectory;
  setupform.MaxInstalledPowerEdit.Value:=setup_installedpower;
  setupform.PricePerkWhEdit.Value:=setup_priceperkwh;
  setupform.TimeForDeltaTEdit.Value:=setup_deltattime;
  for i:=0 to length(TempElements)-1 do
  begin
    TCombobox(setupform.FindComponent('ch'+inttostr(i+1)+'_src')).ItemIndex:=TempElements[i].Source;
    TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_msb')).Value:=TempElements[i].dmx_setting[0];
    TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_lsb')).Value:=TempElements[i].dmx_setting[1];
    TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_url')).Text:=TempElements[i].http_setting[0];
    TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_usr')).Text:=TempElements[i].http_setting[1];
    TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_pwd')).Text:=DecryptPwd(TempElements[i].http_setting[2]);
    TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_start')).Text:=TempElements[i].http_setting[3];
    TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_stop')).Text:=TempElements[i].http_setting[4];
    TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_percent')).Value:=round(TempElements[i].percentage*100);
    TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_mean')).Value:=TempElements[i].mean_max;
    TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_name')).Text:=TempElements[i].name;
  end;

  setupform.ShowModal;

  if setupform.portchange.items.Count>0 then
  begin
    temp:=copy(setupform.portchange.Items[setupform.portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);
    baudrate:=strtoint(setupform.baudratechange.Items[setupform.baudratechange.Itemindex]);
  end;


  Label6.Caption:='('+inttostr(round(setupform.TimeForDeltaTEdit.Value))+'min)';

  setup_autoconnect:=setupform.autoconnectcheckbox.Checked;
  setup_mixmsblsb:=setupform.checkbox2.Checked;
  setup_datain_temp:=setupform.datainchtemp.value;
  setup_datain_min:=setupform.datainchmin.value;
  setup_datain_mean:=setupform.datainchmean.value;
  setup_datain_max:=setupform.datainchmax.value;
  setup_datain_heateron:=setupform.datainchon.value;
  setup_scale:=setupform.TempFaktor.value;
  setup_logdirectory:=setupform.savefilestoedit.Text;
  setup_installedpower:=setupform.MaxInstalledPowerEdit.Value;
  setup_priceperkwh:=setupform.PricePerkWhEdit.Value;
  setup_deltattime:=setupform.TimeForDeltaTEdit.Value;
  for i:=0 to length(TempElements)-1 do
  begin
    TempElements[i].Source:=TCombobox(setupform.FindComponent('ch'+inttostr(i+1)+'_src')).ItemIndex;
    TempElements[i].dmx_setting[0]:=round(TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_msb')).Value);
    TempElements[i].dmx_setting[1]:=round(TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_lsb')).Value);
    TempElements[i].http_setting[0]:=TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_url')).Text;
    TempElements[i].http_setting[1]:=TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_usr')).Text;
    TempElements[i].http_setting[2]:=EncryptPwd(TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_pwd')).Text);
    TempElements[i].http_setting[3]:=TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_start')).Text;
    TempElements[i].http_setting[4]:=TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_stop')).Text;
    TempElements[i].percentage:=TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_percent')).Value/100;
    TempElements[i].mean_max:=round(TJvSpinEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_mean')).Value);
    TempElements[i].name:=TEdit(setupform.FindComponent('ch'+inttostr(i+1)+'_name')).Text;

    if TempElements[i].Source=0 then
      TempElements[i].percentage:=0;
  end;

  Application.ProcessMessages;
  sleep(150);
  setupform.release;
end;

procedure TConfig.Button2Click(Sender: TObject);
begin
  if button2.Caption='>>' then
  begin
    button2.Caption:='<<';

    chart.Visible:=true;
    panel2.Visible:=chart.Visible;
    panel4.Visible:=chart.Visible;

    config.ClientWidth:=1322;
    config.ClientHeight:=453;
  end else
  begin
    button2.Caption:='>>';

    config.ClientWidth:=310;
    config.ClientHeight:=350;

    chart.Visible:=false;
    panel2.Visible:=chart.Visible;
    panel4.Visible:=chart.Visible;
  end;
end;

procedure TConfig.StartUp;
var
  LReg:TRegistry;
  i:integer;
begin
  Shutdown:=false;
  RegelungNeuGestartet:=false;
  Heizbetrieb:=false;
  TempVorXMinuten:=-1000;

  comportnumber:=2;
  baudrate:=115200;

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
	        if not LReg.ValueExists('COMPort') then
	          LReg.WriteInteger('COMPort',1);
	        comportnumber:=LReg.ReadInteger('COMPort');
	        if not LReg.ValueExists('Baudrate') then
	          LReg.WriteInteger('Baudrate',38400);
	        baudrate:=LReg.ReadInteger('Baudrate');

          // Generelle Einstellungen
	        if LReg.ValueExists('AutoConnectComPort') then
            setup_autoconnect:=LReg.ReadBool('AutoConnectComPort');
	        if LReg.ValueExists('Vertausche L und H') then
            setup_mixmsblsb:=LReg.ReadBool('Vertausche L und H');
	        if LReg.ValueExists('Regler ein') then
            tempon.StateOn:=LReg.ReadBool('Regler ein');

          try
            // Temperatureinstellungen
            if LReg.ValueExists('Temperatursollwert') then
              tempsoll.Value:=LReg.ReadFloat('Temperatursollwert');
            if LReg.ValueExists('Einschaltschwelle') then
              tempmin.Value:=LReg.ReadFloat('Einschaltschwelle');
            if LReg.ValueExists('Ausschaltschwelle') then
              tempmax.Value:=LReg.ReadFloat('Ausschaltschwelle');
  	        if LReg.ValueExists('Skalierungsfaktor') then
              setup_scale:=LReg.ReadFloat('Skalierungsfaktor');
          except
            tempsoll.Value:=19.0;
            tempmin.Value:=-1.0;
            tempmax.Value:=1.0;
            setup_scale:=10.0;
          end;

          // Nachtabsenkung
	        if LReg.ValueExists('Verwende Nachtabsenkung') then
            Checkbox2.Checked:=LReg.ReadBool('Verwende Nachtabsenkung');
	        if LReg.ValueExists('Absenkung um') then
            absenkung_temp.value:=LReg.ReadInteger('Absenkung um');
	        if LReg.ValueExists('Absenkung ab h') then
            absenkung_h_startedit.value:=LReg.ReadInteger('Absenkung ab h');
	        if LReg.ValueExists('Absenkung ab min') then
            absenkung_min_startedit.value:=LReg.ReadInteger('Absenkung ab min');
	        if LReg.ValueExists('Absenkung bis h') then
            absenkung_h_stopedit.value:=LReg.ReadInteger('Absenkung bis h');
	        if LReg.ValueExists('Absenkung bis min') then
            absenkung_min_stopedit.value:=LReg.ReadInteger('Absenkung bis min');

          // Erweiterte Einstellungen
	        if LReg.ValueExists('ChTemp') then
            setup_datain_temp:=LReg.ReadInteger('ChTemp');
	        if LReg.ValueExists('ChMin') then
            setup_datain_min:=LReg.ReadInteger('ChMin');
	        if LReg.ValueExists('ChMean') then
            setup_datain_mean:=LReg.ReadInteger('ChMean');
	        if LReg.ValueExists('ChMax') then
            setup_datain_max:=LReg.ReadInteger('ChMax');
	        if LReg.ValueExists('ChHeizungEin') then
            setup_datain_heateron:=LReg.ReadInteger('ChHeizungEin');

          // Sonstige Einstellungen
	        if LReg.ValueExists('Installierte elektrische Leistung') then
            setup_installedpower:=LReg.ReadInteger('Installierte elektrische Leistung');
          try
            if LReg.ValueExists('Preis pro kWh') then
              setup_priceperkwh:=LReg.ReadFloat('Preis pro kWh');
            if LReg.ValueExists('Zeit für Delta T') then
              setup_deltattime:=LReg.ReadFloat('Zeit für Delta T');
          except
            setup_priceperkwh:=28.0;
            setup_deltattime:=15;
          end;

          // Verzeichnis für Dateien
          if LReg.ValueExists('Datafolder') then
            setup_logdirectory:=LReg.ReadString('Datafolder');

          // Sensor-Einstellungen
          for i:=0 to length(TempElements)-1 do
          begin
            LReg.CloseKey;
            if LReg.OpenKey('Software\PHOENIXstudios\PC_DIMMER\'+ExtractFileName(GetModulePath)+'\TempElement'+inttostr(i+1), true) then
            begin
              if LReg.ValueExists('Source') then
                TempElements[i].Source:=LReg.ReadInteger('Source');
              if LReg.ValueExists('Name') then
                TempElements[i].Name:=LReg.ReadString('Name');
              if LReg.ValueExists('HTTP1') then
                TempElements[i].http_setting[0]:=LReg.ReadString('HTTP1');
              if LReg.ValueExists('HTTP2') then
                TempElements[i].http_setting[1]:=LReg.ReadString('HTTP2');
              if LReg.ValueExists('HTTP3') then
                TempElements[i].http_setting[2]:=LReg.ReadString('HTTP3');
              if LReg.ValueExists('HTTP4') then
                TempElements[i].http_setting[3]:=LReg.ReadString('HTTP4');
              if LReg.ValueExists('HTTP5') then
                TempElements[i].http_setting[4]:=LReg.ReadString('HTTP5');
              if LReg.ValueExists('DMX1') then
                TempElements[i].dmx_setting[0]:=LReg.ReadInteger('DMX1');
              if LReg.ValueExists('DMX2') then
                TempElements[i].dmx_setting[1]:=LReg.ReadInteger('DMX2');
              if LReg.ValueExists('Percentage') then
                TempElements[i].percentage:=LReg.ReadFloat('Percentage');
              if LReg.ValueExists('MeanMax') then
                TempElements[i].mean_max:=LReg.ReadInteger('MeanMax');
            end;
          end;
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(_('Datum; Uhrzeit; Temperatur 1 [°C]; Temperatur 2 [°C]; Temperatur 3 [°C]; Temperatur 4 [°C]; Delta-Temp [°C]; Verbrauch [kWh]; Kosten [€]'));

  Label6.Caption:='('+inttostr(round(setup_deltattime))+'min)';


  // Chart vorbereiten
//  chart.Options.PenValueLabels[0]:=true;
  chart.Options.PenCount:=8;
  chart.Options.PenUnit.Clear;

  chart.Options.PenColor[0]:=clblack;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[1]:=false;
  chart.Options.PenColor[1]:=clred;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[2]:=false;
  chart.Options.PenColor[2]:=cllime;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[3]:=false;
  chart.Options.PenColor[3]:=clfuchsia;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[4]:=false;
  chart.Options.PenColor[4]:=clolive;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[5]:=false;
  chart.Options.PenColor[5]:=clteal;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[6]:=false;
  chart.Options.PenColor[6]:=clMaroon;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenValueLabels[7]:=false;
  chart.Options.PenColor[7]:=clgray;
  chart.Options.PenUnit.Add('°C');

  chart.Options.PenLineWidth:=2;
  chart.Options.XAxisDateTimeMode:=true;
  chart.Options.XAxisDateTimeFormat:='hh:mm:ss';
  chart.Options.XAxisDivisionMarkers:=true;
  chart.Options.XAxisValuesPerDivision:=15; // 15 Werte pro Div @ 1Min pro Sample -> 15 Minuten pro Div

  chart.Options.AxisFont.Name:='Calibri';
  chart.Options.AxisFont.Size:=8;

  if setup_autoconnect then
  begin
    // Automatisch mit letzten Comport und Baudrate verbinden
    ActivateCOMPort(comportnumber, baudrate);
  end;

  ServiceTimerCounter:=58;
  ServiceTimer.Enabled:=true;
end;

procedure TConfig.RegisterPluginCommandsTimer(Sender: TObject);
begin
  RegisterPluginCommands.Enabled:=false;

  SendMSG(MSG_CREATEPLUGINSCENE, '{EB86EDF4-F750-420C-81D9-3023741988E8}', 'Temperaturregler: Ein');
  SendMSG(MSG_CREATEPLUGINSCENE, '{4950EE57-ACAC-4BB3-ACA6-9CBD4D9F1B56}', 'Temperaturregler: Aus');
end;

procedure TConfig.SavePng(Bitmap: TBitmap; Destination:string);
var
  Png: TPNGObject;
begin
  Png := TPNGObject.Create;
  try
    Png.Transparent:=false;
    Png.Assign(Bitmap);
    Png.SaveToFile(Destination);
  finally
    Png.Free;
  end;
end;

procedure TConfig.Button3Click(Sender: TObject);
begin
  ActivateCOMPort(comportnumber, baudrate);
end;

procedure TConfig.Button4Click(Sender: TObject);
begin
  comport.Disconnect;
end;

function TConfig.EncryptPwd(Pwd: string):string;
begin
  result:='';
  with TCipher_Blowfish.Create do
  try
    Init(blowfishscramblekey);
    result:=EncodeBinary(Pwd, TFormat_Copy);
  finally
    Free;
  end;
end;

function TConfig.DecryptPwd(Pwd: string):string;
begin
  result:='';

  with TCipher_Blowfish.Create do
  try
    Init(blowfishscramblekey);
    result:=DecodeBinary(Pwd, TFormat_Copy);
  finally
    Free;
  end;
end;

end.
