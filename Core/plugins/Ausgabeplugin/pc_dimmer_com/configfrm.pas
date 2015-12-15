unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime,delay:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    comport: TCommPortDriver;
    portchange: TComboBox;
    Label2: TLabel;
    baudratechange: TComboBox;
    Label3: TLabel;
    ConfigOK: TButton;
    Abbrechen: TButton;
    Image1: TImage;
    Label4: TLabel;
    rs232input: TCheckBox;
    Bevel2: TBevel;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Label5: TLabel;
    statuslabel: TLabel;
    procedure comportReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure rs232inputMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
    procedure portchangeSelect(Sender: TObject);
    procedure baudratechangeSelect(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    rs232frame:array of array[0..5] of Byte;
    rs232frame_locked:boolean;
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

procedure TConfig.comportReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
begin
if (rs232input.Checked) and (shutdown=false) then
begin
  move( DataPtr, rs232_inframe, SizeOf(DataPtr) );

  if (rs232_inframe[0]>127) and (rs232_inframe[5]<128) then
  begin
		issending:=true;
//		RefreshDLLValues(rs232_inframe[0]-127,255-(rs232_inframe[5]*2),255-(rs232_inframe[5]*2),0,0);
    RefreshDLLEvent(rs232_inframe[0]-127,255-(rs232_inframe[5]*2));
  end;
end;
end;

procedure TConfig.rs232inputMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
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
	        LReg.WriteBool('RS232 Input',rs232input.checked);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.Button1Click(Sender: TObject);
var
  i, TestHandle:integer;
begin
  if config.comport.Connected then
  	Config.comport.Disconnect;

	portchange.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    portchange.Items.Add('COM'+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;
end;

procedure TConfig.ActivateCOMPort(portnumber: integer);
var
  i:integer;
  temp:String;
begin
  portchange.ItemIndex:=0;
  for i:=0 to portchange.items.count-1 do
  begin
    temp:=copy(portchange.Items[i],4,2);
    if temp[2]=' ' then
    begin
      // einstellig
      if portnumber=strtoint(temp[1]) then
      begin
        portchange.ItemIndex:=i;
        break;
      end;
    end else
    begin
      // zweistellig
      if portnumber=strtoint(temp) then
      begin
        portchange.ItemIndex:=i;
        break;
      end;
    end;
  end;
end;

procedure TConfig.portchangeSelect(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  if (portchange.Items.Count>0) and (portchange.itemindex>-1) then
  begin
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    if comport.Connected then
      comport.Disconnect;
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
    statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber)+' @ '+inttostr(baudrate);
    statuslabel.Font.Color:=clGreen;
  end else
  begin
    statuslabel.Caption:='Nicht verbunden...';
    statuslabel.Font.Color:=clRed;
  end;
end;

procedure TConfig.baudratechangeSelect(Sender: TObject);
var
  LReg:TRegistry;
begin
  baudrate:=strtoint(baudratechange.Items[baudratechange.Itemindex]);

  if comport.Connected then
   	comport.Disconnect;
  comport.BaudRateValue:=baudrate;
  if (portchange.ItemIndex>-1) then
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
	        LReg.WriteInteger('Baudrate',baudrate);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  if comport.Connected then
  begin
    statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber)+' @ '+inttostr(baudrate);
    statuslabel.Font.Color:=clGreen;
  end else
  begin
    statuslabel.Caption:='Nicht verbunden...';
    statuslabel.Font.Color:=clRed;
  end;
end;

procedure TConfig.startup;
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
  regbaudrate:=115200;

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
	        if not LReg.ValueExists('Dimmtype') then
	          LReg.WriteInteger('Dimmtype',1);
	        case LReg.ReadInteger('Dimmtype') of
            1: RadioGroup1.ItemIndex:=0;
            2: RadioGroup1.ItemIndex:=1;
          end;
	        if not LReg.ValueExists('COMPort') then
	          LReg.WriteInteger('COMPort',2);
	        serialport:=LReg.ReadInteger('COMPort');
	        if not LReg.ValueExists('Baudrate') then
	          LReg.WriteInteger('Baudrate',115200);
	        regbaudrate:=LReg.ReadInteger('Baudrate');
	        if not LReg.ValueExists('RS232 Input') then
	          LReg.WriteBool('RS232 Input',false);
	        rs232input.checked:=LReg.ReadBool('RS232 Input');
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

  case regbaudrate of
    115200: baudratechange.ItemIndex:=0;
    57600: baudratechange.ItemIndex:=1;
    38400: baudratechange.ItemIndex:=2;
    9600: baudratechange.ItemIndex:=3;
  else
    baudratechange.ItemIndex:=0;
  end;

  baudratechangeSelect(nil);

  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
end;

end.
