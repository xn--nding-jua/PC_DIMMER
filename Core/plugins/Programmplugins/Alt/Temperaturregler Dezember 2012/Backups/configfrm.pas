unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry, CPort, Mask, JvExMask,
  JvSpin, JvExControls, JvSwitch, ComCtrls, JvSimScope, JvLED;

type
  TCallbackValues = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;
  TCallbackNames = procedure(address:integer;channelname:PChar);stdcall;
  TCallbackGetValue = function(address:integer):integer;stdcall;
  TCallbackSendMessage = procedure(MSG: Byte; Data1, Data2:Variant);stdcall;

  TConfig = class(TForm)
    comport: TCommPortDriver;
    GroupBox3: TGroupBox;
    tempcurrentlbl: TLabel;
    Label10: TLabel;
    tempmin: TJvSpinEdit;
    Label11: TLabel;
    tempmax: TJvSpinEdit;
    Label14: TLabel;
    tempon: TJvSwitch;
    Bevel1: TBevel;
    Bevel3: TBevel;
    tempminbar: TTrackBar;
    tempmaxbar: TTrackBar;
    GroupBox4: TGroupBox;
    scope: TJvSimScope;
    tempminlbl: TLabel;
    tempmeanlbl: TLabel;
    tempmaxlbl: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    SekundenTimer: TTimer;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CheckBox1: TCheckBox;
    heizenled: TJvLED;
    Label8: TLabel;
    Label26: TLabel;
    hystereseled: TJvLED;
    tempokled: TJvLED;
    Label27: TLabel;
    scope2: TJvSimScope;
    Button3: TButton;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    temp2lbl: TLabel;
    Label1: TLabel;
    temp3lbl: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    deltatemplbl: TLabel;
    tempsoll: TJvSpinEdit;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure comportReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure ActivateCOMPort(portnumber: integer);
    procedure tempminChange(Sender: TObject);
    procedure tempmaxChange(Sender: TObject);
    procedure tempminbarChange(Sender: TObject);
    procedure tempmaxbarChange(Sender: TObject);
    procedure temponOn(Sender: TObject);
    procedure temponOff(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SekundenTimerTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    Shutdown:boolean;

    CurrentTemp:Single;
    TempVor15Minuten:Single;
    FuenfzehnminutenCounter:Word;
    Temp2msb, Temp2lsb, Temp3msb, Temp3lsb:byte;
    CurrentTemp2, CurrentTemp3:Single;
    TemperaturArray:array[0..599] of Smallint;
    TemperaturArrayPointer:Word;
    RegelungNeuGestartet:Boolean;
    Heizbetrieb:Boolean;

    SetDLLValues:TCallbackValues;
    SetDLLEvent:TCallbackEvent;
    SetDLLNames:TCallbackNames;
    GetDLLValue:TCallbackGetValue;
    SendMSG:TCallbackSendMessage;

    function CalcMaximum:Single;
    function CalcMinimum:Single;
    function CalcMean:Single;
    function RoundToByte(Temperatur: Single):Byte;
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

procedure TConfig.FormCreate(Sender: TObject);
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

  LReg:TRegistry;
  serialport, regbaudrate:integer;
  TestHandle : integer;
begin
  Application.CreateForm(Tsetupform, setupform);

  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;

  Shutdown:=false;
  for i:=0 to length(TemperaturArray)-1 do
    TemperaturArray[i]:=-32768;
  RegelungNeuGestartet:=false;
  Heizbetrieb:=false;

  serialport:=2;
  regbaudrate:=115200;

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
	        serialport:=LReg.ReadInteger('COMPort');
	        if not LReg.ValueExists('Baudrate') then
	          LReg.WriteInteger('Baudrate',38400);
	        regbaudrate:=LReg.ReadInteger('Baudrate');

	        if LReg.ValueExists('Vertausche L und H') then
            setupform.Checkbox2.Checked:=LReg.ReadBool('Vertausche L und H');
	        if LReg.ValueExists('Regler ein') then
            tempon.StateOn:=LReg.ReadBool('Regler ein');
	        if LReg.ValueExists('Verwende Mittelwert als Referenz') then
            Checkbox1.Checked:=LReg.ReadBool('Verwende Mittelwert als Referenz');
	        if LReg.ValueExists('ChTemp') then
            setupform.datainchtemp.value:=LReg.ReadInteger('ChTemp');
	        if LReg.ValueExists('ChMin') then
            setupform.datainchmin.value:=LReg.ReadInteger('ChMin');
	        if LReg.ValueExists('ChMean') then
            setupform.datainchmean.value:=LReg.ReadInteger('ChMean');
	        if LReg.ValueExists('ChMax') then
            setupform.datainchmax.value:=LReg.ReadInteger('ChMax');
	        if LReg.ValueExists('ChHeizungEin') then
            setupform.datainchon.value:=LReg.ReadInteger('ChHeizungEin');
	        if LReg.ValueExists('Skalierungsfaktor') then
            setupform.TempFaktor.Value:=LReg.ReadFloat('Skalierungsfaktor');
	        if LReg.ValueExists('Einschaltschwelle') then
            tempmin.Value:=LReg.ReadFloat('Einschaltschwelle');
	        if LReg.ValueExists('Ausschaltschwelle') then
            tempmax.Value:=LReg.ReadFloat('Ausschaltschwelle');
	        if LReg.ValueExists('Temp2LSB') then
            setupform.temp2_lsb.value:=LReg.ReadInteger('Temp2LSB');
	        if LReg.ValueExists('Temp2MSB') then
            setupform.temp2_msb.value:=LReg.ReadInteger('Temp2MSB');
	        if LReg.ValueExists('Temp3LSB') then
            setupform.temp3_lsb.value:=LReg.ReadInteger('Temp3LSB');
	        if LReg.ValueExists('Temp3MSB') then
            setupform.temp3_msb.value:=LReg.ReadInteger('Temp3MSB');
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  // enumerate all serial devices (COM port devices)
    SerialGUID := GUID_DEVINTERFACE_COMPORT;
//    SerialGUID := GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR;
  PnPHandle := SetupDiGetClassDevs(@SerialGUID, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
  if PnPHandle = Pointer(INVALID_HANDLE_VALUE) then
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

// COM-Ports von 1 bis 16 abklappern
//	portchange.Clear;
//	for i:=1 to 16 do
//	begin
//	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
//	  if (TestHandle > 0) then
//	  begin
//	    portchange.Items.Add('COM'+inttostr(i));
//	    CloseHandle(TestHandle);
//	  end;
//	end;

  ActivateCOMPort(serialport);

  setupform.portchange.Visible:=(setupform.portchange.Items.Count>0);
  setupform.portchangeSelect(Sender);

  case regbaudrate of
    115200: setupform.baudratechange.ItemIndex:=0;
    57600: setupform.baudratechange.ItemIndex:=1;
    38400: setupform.baudratechange.ItemIndex:=2;
    19200: setupform.baudratechange.ItemIndex:=3;
    9600: setupform.baudratechange.ItemIndex:=4;
  else
    setupform.baudratechange.ItemIndex:=0;
  end;
  setupform.baudratechangeSelect(Sender);

  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
end;

procedure TConfig.comportReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
var
  i: integer;
  s, ss: string;
begin
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

    if setupform.CheckBox2.Checked then
    begin
      CurrentTemp:=integer(ss[1]) shl 8;
      CurrentTemp:=CurrentTemp+integer(ss[2]);
    end else
    begin
      CurrentTemp:=integer(ss[2]) shl 8;
      CurrentTemp:=CurrentTemp+integer(ss[1]);
    end;
    CurrentTemp:=((CurrentTemp/2047)*200)-50;
    SekundenTimer.Enabled:=true;
  end;
end;

procedure TConfig.ActivateCOMPort(portnumber: integer);
var
  i:integer;
  temp:String;
begin
  setupform.portchange.ItemIndex:=0;
  for i:=0 to setupform.portchange.items.count-1 do
  begin
    temp:=copy(setupform.portchange.Items[i],4,2);
    if temp[2]=' ' then
    begin
      // einstellig
      if portnumber=strtoint(temp[1]) then
      begin
        setupform.portchange.ItemIndex:=i;
        break;
      end;
    end else
    begin
      // zweistellig
      if portnumber=strtoint(temp) then
      begin
        setupform.portchange.ItemIndex:=i;
        break;
      end;
    end;
  end;
end;

procedure TConfig.tempminChange(Sender: TObject);
begin
  if tempmin.Value>tempmax.value then
    tempmin.value:=tempmax.value;
  tempminbar.position:=round(tempmin.Value);
end;

procedure TConfig.tempmaxChange(Sender: TObject);
begin
  if tempmax.Value<tempmin.value then
    tempmax.value:=tempmin.value;
  tempmaxbar.position:=round(tempmax.Value);
end;

procedure TConfig.tempminbarChange(Sender: TObject);
begin
  if tempminbar.Position>tempmaxbar.Position then
    tempminbar.Position:=tempmaxbar.Position;
  tempmin.value:=tempminbar.position;
end;

procedure TConfig.tempmaxbarChange(Sender: TObject);
begin
  if tempmaxbar.Position<tempminbar.Position then
    tempmaxbar.Position:=tempminbar.Position;
  tempmax.value:=tempmaxbar.position;
end;

procedure TConfig.temponOn(Sender: TObject);
begin
  RegelungNeuGestartet:=true;
  label14.Caption:='Temperaturregler aktiviert...';
  label14.Font.Color:=clBlack;
end;

procedure TConfig.temponOff(Sender: TObject);
begin
  label14.Caption:='Temperaturregler deaktiviert...';
  label14.Font.Color:=clBlack;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  scope.Active:=true;
  scope2.Active:=true;
end;

function TConfig.CalcMaximum:Single;
var
  i:integer;
  Maximum:Double;
begin
  Maximum:=-200;
  for i:=0 to length(TemperaturArray)-1 do
  begin
    if (TemperaturArray[i]>-32768) and ((TemperaturArray[i]/1000) > Maximum) then
    begin
      Maximum:=TemperaturArray[i]/1000;
    end;
  end;
  result:=Maximum;
end;

function TConfig.CalcMinimum:Single;
var
  i:integer;
  Minimum:Double;
begin
  Minimum:=200;
  for i:=0 to length(TemperaturArray)-1 do
  begin
    if (TemperaturArray[i]>-32768) and ((TemperaturArray[i]/1000) < Minimum) then
    begin
      Minimum:=TemperaturArray[i]/1000;
    end;
  end;
  result:=Minimum;
end;

function TConfig.CalcMean:Single;
var
  i, Values:integer;
  Mean:Double;
begin
  Mean:=0;
  Values:=0;
  for i:=0 to length(TemperaturArray)-1 do
  begin
    if (TemperaturArray[i]>-32768) then
    begin
      Mean:=Mean+TemperaturArray[i]/1000;
      inc(Values);
    end;
  end;
  if Values>0 then
    Mean:=Mean/Values;

  result:=Mean;
end;

procedure TConfig.SekundenTimerTimer(Sender: TObject);
var
  ReglerTemperaturWert:Single;
  TempMinVal, TempMeanVal, TempMaxVal:Single;
begin
  // TemperaturArray aktualisieren
  TemperaturArray[TemperaturArrayPointer]:=round(CurrentTemp*1000);
  inc(TemperaturArrayPointer);
  if TemperaturArrayPointer>=length(TemperaturArray) then
    TemperaturArrayPointer:=0;

  TempMinVal:=CalcMinimum;
  TempMeanVal:=CalcMean;
  TempMaxVal:=CalcMaximum;

  // Temperatur in Scope anzeigen
  scope.Lines.Lines[0].Position:=round(CurrentTemp/0.3);
  scope.Lines.Lines[1].Position:=round(tempmax.value/0.3);
  scope.Lines.Lines[2].Position:=round(tempmin.value/0.3);
  scope2.Lines.Lines[0].Position:=round(CurrentTemp/0.3);
  scope2.Lines.Lines[1].Position:=round(tempmax.value/0.3);
  scope2.Lines.Lines[2].Position:=round(tempmin.value/0.3);

  // Temperatur in Label anzeigen
  if config.Showing then
  begin
    tempcurrentlbl.caption:=floattostrf(CurrentTemp, ffFixed, 5, 1)+'°C';
    tempminlbl.Caption:=floattostrf(TempMinVal, ffFixed, 5, 1)+'°C';
    tempmeanlbl.Caption:=floattostrf(TempMeanVal, ffFixed, 5, 1)+'°C';
    tempmaxlbl.Caption:=floattostrf(TempMaxVal, ffFixed, 5, 1)+'°C';
  end;

  if tempon.StateOn then
  begin
    // Aktuelle Temperatur als Kanalwert an PC_DIMMER senden
    SetDLLEvent(round(setupform.datainchtemp.Value), RoundToByte(CurrentTemp));
    // Minimale Temperatur als Kanalwert an PC_DIMMER senden
    SetDLLEvent(round(setupform.datainchmin.Value), RoundToByte(TempMinVal));
    // Mittelwert der Temperatur als Kanalwert an PC_DIMMER senden
    SetDLLEvent(round(setupform.datainchmean.Value), RoundToByte(TempMeanVal));
    // Maximale Temperatur als Kanalwert an PC_DIMMER senden
    SetDLLEvent(round(setupform.datainchmax.Value), RoundToByte(TempMaxVal));

    if CheckBox1.Checked then
      ReglerTemperaturWert:=TempMeanVal
    else
      ReglerTemperaturWert:=CurrentTemp;

    if ReglerTemperaturWert>tempmax.Value then
    begin
      // Zu Warm -> Ausschalten
      SetDLLEvent(round(setupform.datainchon.Value), 0);
      Heizbetrieb:=false;
      heizenled.active:=false;
      heizenled.status:=false;
      label14.Caption:=_('Heizung aus');
      label14.Font.Color:=clBlack;
    end;
    tempokled.Status:=(ReglerTemperaturWert>tempmax.Value);

    if ReglerTemperaturWert<tempmin.Value then
    begin
      // Zu Kalt -> Einschalten
      SetDLLEvent(round(setupform.datainchon.Value), 255);
      Heizbetrieb:=true;
      heizenled.active:=true;
      label14.Caption:=_('Heizung ein');
      label14.Font.Color:=clRed;
    end;

    if (ReglerTemperaturWert>tempmin.Value) and (ReglerTemperaturWert<tempmax.Value) then
    begin
      // Temperatur im Hysteresebereich
      if RegelungNeuGestartet then
      begin
        // Aufheizen, da Sollwert noch nicht erreicht und Regelung gerade eingeschaltet
        RegelungNeuGestartet:=false;
        SetDLLEvent(round(setupform.datainchon.Value), 255);
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
    SetDLLEvent(round(setupform.datainchon.Value), 0);
    Heizbetrieb:=false;
    tempokled.Status:=false;
    hystereseled.status:=false;
    heizenled.active:=false;
    heizenled.status:=false;
  end;

  inc(FuenfzehnminutenCounter);
  if FuenfzehnminutenCounter>=900 then
  begin
    // 15 Minuten sind um
    FuenfzehnminutenCounter:=0;

    deltatemplbl.caption:=floattostrf((CurrentTemp-TempVor15Minuten), ffFixed, 5, 1)+'°C';

    TempVor15Minuten:=CurrentTemp;
  end;
end;

function TConfig.RoundToByte(Temperatur: Single):Byte;
var
  TempInteger:integer;
begin
  TempInteger:=round(Temperatur*setupform.TempFaktor.Value);
  if TempInteger>255 then
    TempInteger:=255
  else if TempInteger<0 then
    TempInteger:=0;
  result:=TempInteger;
end;

procedure TConfig.Button3Click(Sender: TObject);
begin
  scope2.Visible:=not scope2.Visible;
  scope.Visible:=not scope.Visible;

  if scope.Visible then
  begin
    label20.Caption:='5min';
    label19.Caption:='4min';
    label18.Caption:='3min';
    label17.Caption:='2min';
    label16.Caption:='1min';
  end else
  begin
    label20.Caption:='5h';
    label19.Caption:='4h';
    label18.Caption:='3h';
    label17.Caption:='2h';
    label16.Caption:='1h';
  end;
end;

procedure TConfig.FormHide(Sender: TObject);
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
          LReg.WriteInteger('COMPort',comportnumber);
    	    LReg.WriteInteger('Baudrate',baudrate);
          LReg.WriteBool('Vertausche L und H', setupform.Checkbox2.Checked);
          LReg.WriteBool('Regler ein', tempon.StateOn);
          LReg.WriteBool('Verwende Mittelwert als Referenz', Checkbox1.Checked);
          LReg.WriteInteger('ChTemp', round(setupform.datainchtemp.value));
          LReg.WriteInteger('ChMin', round(setupform.datainchmin.value));
          LReg.WriteInteger('ChMean', round(setupform.datainchmean.value));
          LReg.WriteInteger('ChMax', round(setupform.datainchmax.value));
          LReg.WriteInteger('ChHeizungEin', round(setupform.datainchon.value));
          LReg.WriteFloat('Skalierungsfaktor', setupform.TempFaktor.Value);
          LReg.WriteFloat('Einschaltschwelle', tempmin.Value);
          LReg.WriteFloat('Ausschaltschwelle', tempmax.Value);
          LReg.WriteInteger('Temp2LSB', round(setupform.temp2_lsb.value));
          LReg.WriteInteger('Temp2MSB', round(setupform.temp2_msb.value));
          LReg.WriteInteger('Temp3LSB', round(setupform.temp3_lsb.value));
          LReg.WriteInteger('Temp3MSB', round(setupform.temp3_msb.value));
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
begin
  setupform.ShowModal;
end;

procedure TConfig.FormDestroy(Sender: TObject);
begin
	setupform.Free;
end;

end.
