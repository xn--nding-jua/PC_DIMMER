unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry, CHHighResTimer;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    comport: TCommPortDriver;
    portchange: TComboBox;
    Label2: TLabel;
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    Label3: TLabel;
    statuslabel: TLabel;
    SendTimer: TCHHighResTimer;
    procedure ActivateCOMPort(portnumber: integer);
    procedure portchangeSelect(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
    ConnectionProblem:boolean;
  public
    { Public-Deklarationen }
    ChannelValues:array[1..512] of Byte;
    ChannelChanged:array[1..512] of boolean;

    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    procedure Startup;
  end;

var
  Config: TConfig;

implementation

uses
  JwaWinType,
  SetupApi, Cfg, CfgMgr32;

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

procedure TConfig.ActivateCOMPort(portnumber: integer);
var
  i:integer;
  temp:String;
begin
  if portchange.Items.Count=0 then exit;

  portchange.ItemIndex:=0;

  for i:=0 to portchange.items.count-1 do
  begin
    temp:=copy(portchange.Items[i],4,2);
    if temp[2]=' ' then
    begin
      // einstellig
      if portnumber=strtoint(temp[1]) then
      begin
        if (i>=0) and (i<portchange.items.count) then
          portchange.ItemIndex:=i;
        break;
      end;
    end else
    begin
      // zweistellig
      if portnumber=strtoint(temp) then
      begin
        if (i>=0) and (i<portchange.items.count) then
          portchange.ItemIndex:=i;
        break;
      end;
    end;
  end;
  portchangeSelect(nil);
end;

procedure TConfig.portchangeSelect(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  if portchange.Items.Count > 0 then
  begin                
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    if config.comport.Connected then
      Config.comport.Disconnect;
    case comportnumber of
      1: comport.port:=pnCOM1;   2: comport.port:=pnCOM2;
      3: comport.port:=pnCOM3;   4: comport.port:=pnCOM4;
      5: comport.port:=pnCOM5;   6: comport.port:=pnCOM6;
      7: comport.port:=pnCOM7;   8: comport.port:=pnCOM8;
      9: comport.port:=pnCOM9;   10: comport.port:=pnCOM10;
      11: comport.port:=pnCOM11;   12: comport.port:=pnCOM12;
      13: comport.port:=pnCOM13;   14: comport.port:=pnCOM14;
      15: comport.port:=pnCOM15;   16: comport.port:=pnCOM16;
    end;
    if portchange.ItemIndex>-1 then
      comport.Connect;

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
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;

  if comport.Connected then
  begin
    statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
    statuslabel.Font.Color:=clGreen;
  end else
  begin
    statuslabel.Caption:='Nicht verbunden...';
    statuslabel.Font.Color:=clRed;
  end;
end;

procedure TConfig.SendTimerTimer(Sender: TObject);
var
  b:integer;
  i:integer;
  rs232frame:array of Byte;
  SizeOfArray:Cardinal;
begin
  for i:=1 to 512 do
  begin
    if ChannelChanged[i] then
    begin
      ChannelChanged[i]:=false;

      // In Binärmodus schalten
      setlength(rs232frame, 1);
      rs232frame[length(rs232frame)-1]:=1;
      // Laut Byte-Stuffing muss hier eine Null folgen
      setlength(rs232frame, length(rs232frame)+1);
      rs232frame[length(rs232frame)-1]:=0;

      if (i<=255) then
      begin
        // Kanal 1-255 senden
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=2;
        // Kanalnummer eintragen
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=i;
        // Laut Byte-Stuffing muss hier eine Null folgen, falls Kanal=1
        if rs232frame[length(rs232frame)-1]=1 then
        begin
          setlength(rs232frame, length(rs232frame)+1);
          rs232frame[length(rs232frame)-1]:=0;
        end;

        // Kanalwert eintragen
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=ChannelValues[i];
        // Laut Byte-Stuffing muss hier eine Null folgen, falls Kanalwert=1
        if rs232frame[length(rs232frame)-1]=1 then
        begin
          setlength(rs232frame, length(rs232frame)+1);
          rs232frame[length(rs232frame)-1]:=0;
        end;
      end else if (i>=256) and (i<=511) then
      begin
        // Kanal 256-511 senden
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=3;
        // Kanalnummer eintragen
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=i-256;
        // Laut Byte-Stuffing muss hier eine Null folgen, falls Kanal=1
        if rs232frame[length(rs232frame)-1]=1 then
        begin
          setlength(rs232frame, length(rs232frame)+1);
          rs232frame[length(rs232frame)-1]:=0;
        end;

        // Kanalwert eintragen
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=ChannelValues[i];
        // Laut Byte-Stuffing muss hier eine Null folgen, falls Kanalwert=1
        if rs232frame[length(rs232frame)-1]=1 then
        begin
          setlength(rs232frame, length(rs232frame)+1);
          rs232frame[length(rs232frame)-1]:=0;
        end;
      end else if i=512 then
      begin
        // Kanal 256-511 senden
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=2;
        // Kanalnummer eintragen
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=0;

        // Kanalwert eintragen
        setlength(rs232frame, length(rs232frame)+1);
        rs232frame[length(rs232frame)-1]:=ChannelValues[i];
        // Laut Byte-Stuffing muss hier eine Null folgen, falls Kanalwert=1
        if rs232frame[length(rs232frame)-1]=1 then
        begin
          setlength(rs232frame, length(rs232frame)+1);
          rs232frame[length(rs232frame)-1]:=0;
        end;
      end;

      if comport.Connected then
      begin
        SizeOfArray:=length(rs232frame);
        connectionproblem:=(comport.SendData(@rs232frame, SizeOfArray)<>SizeOfArray);
        if connectionproblem then
        begin
          statuslabel.Caption:='Verbindungsproblem!';
          statuslabel.Font.Color:=clRed;
          SendTimer.Interval:=2000;
        end else
        begin
          statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
          statuslabel.Font.Color:=clGreen;
          SendTimer.Interval:=50;
        end;
      end;
    end;
  end;
end;

procedure Tconfig.Startup;
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

  LReg:TRegistry;
  serialport, regbaudrate:integer;
  TestHandle : integer;
begin
  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;

	shutdown:=false;
	issending:=false;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  serialport:=2;

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
	          LReg.WriteInteger('COMPort',2);
	        serialport:=LReg.ReadInteger('COMPort');
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  try
    if comport.Connected then
	  	comport.Disconnect;
  except
  end;

  // enumerate all serial devices (COM port devices)
    SerialGUID := GUID_DEVINTERFACE_COMPORT;
//    SerialGUID := GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR;
  PnPHandle := SetupDiGetClassDevs(@SerialGUID, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
  if PnPHandle = Pointer(INVALID_HANDLE_VALUE) then
    Exit;
  portchange.Items.BeginUpdate;
  portchange.Items.Clear;
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
            portchange.Items.Add(PortName + ' (' + DeviceDescription + ', ' + Bus+')');
          end;
          FreeMem(FunctionClassDeviceData);
        end;
      end;
	    CloseHandle(TestHandle);
    end;
    Inc(Devn);
  until not Success;
  SetupDiDestroyDeviceInfoList(PnPHandle);
  portchange.Items.EndUpdate;

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

  portchange.Visible:=(portchange.Items.Count>0);
  portchangeSelect(nil);

  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;

  SendTimer.Enabled:=true;
end;

end.
