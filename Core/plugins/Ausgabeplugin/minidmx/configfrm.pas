unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry;

const
  MDMX_256CH = 0;
  MDMX_512CH = 1;
// Rückgabewerte
  MDMX_OK = 0;
  MDMX_ERROR_SERIALPORT = 1;
  MDMX_ERROR_DEVICENOTFOUND = 2;
  MDMX_ERROR_CREATETHREAD = 3;
  MDMX_ERROR_PARAMOUTOFRANGE = 4;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;

  TConfig = class(TForm)
    ConfigOK: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    procedure ComboBox1Select(Sender: TObject);
    procedure RadioButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    issending:boolean;
    shutdown:boolean;
    LinkOnline:boolean;
    BadSendings:Cardinal;
    procedure SendData(Channel: Integer; Value: Integer);
    procedure OpenLink;
    procedure CloseLink;
    procedure Startup;
  end;

var
  Config: TConfig;

function MDMX_OpenSerialDevice(PortName : PChar; SerialMode : Integer):Integer; stdcall; external 'mdmxsvr.dll';
function MDMX_SetChannel(Channel: Integer; Value: Integer):Boolean; stdcall; external 'mdmxsvr.dll';
function MDMX_GetDMXTransmissions:Integer; stdcall; external 'mdmxsvr.dll';
procedure MDMX_Close; stdcall; external 'mdmxsvr.dll';

{
// Konstanten
#define MDMX_256CH = 0
#define MDMX_512CH = 1
// Rückgabewerte
#define MDMX_OK = 0
#define MDMX_ERROR_SERIALPORT = 1
#define MDMX_ERROR_DEVICENOTFOUND = 2
#define MDMX_ERROR_CREATETHREAD = 3
#define MDMX_ERROR_PARAMOUTOFRANGE = 4

// Funktion: MDMX_OpenSerialDevice
// Parameter:
//   portname:
//     Name der seriellen Schnittstelle (z.B. "COM1")
//   serialmode:
//     MDMX_256CH - 256 Kanäle senden (schneller)
//     MDMX_512CH - 512 Kanäle senden
// Rückgabewerte:
//   MDMX_OK - Funktion erfolgreich
//   MDMX_ERROR_SERIALPORT - Schnittstelle kann nicht geöffnet werden
//   MDMX_ERROR_DEVICENOTFOUND - MiniDMX-Dongle nicht gefunden
//   MDMX_ERROR_CREATETHREAD - Thread kann nicht gestartet werden

// Funktion: MDMX_SetChannel
// Parameter:
//   channel: 0-511 (DMX-Kanalnr. 1 bis 512)
//   value: 0-255
// Rückgabewerte:
//   MDMX_OK - Funktion erfolgreich
//   MDMX_ERROR_PARAMOUTOFRANGE - Parameter außerhalb des zulässigen Bereichs

// Funktion: MDMX_GetDMXTransmissions
// Parameter:
//   keine
// Rückgabewerte:
//   Anzahl erfolgreicher DMX-Sendungen seit dem letzten Aufruf oder seit
//   MDMX_OpenSerialDevice

// Funktion: MDMX_Close
// Parameter:
//   keine
// Rückgabewerte:
//   keine
}

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

procedure TConfig.SendData(Channel: Integer; Value: Integer);
var
  returnvalue:boolean;
begin
  returnvalue:=MDMX_SetChannel(Channel, Value);

  if (returnvalue=false) then
    BadSendings:=BadSendings+1;
end;

procedure TConfig.OpenLink;
var
  returnvalue:integer;
begin
  if comportnumber<1 then exit;

  returnvalue:=-1;

  if not LinkOnline then
  begin
    if Radiobutton1.Checked then
      returnvalue:=MDMX_OpenSerialDevice(PCHar('COM'+inttostr(comportnumber)), MDMX_256CH)
    else
      returnvalue:=MDMX_OpenSerialDevice(PCHar('COM'+inttostr(comportnumber)), MDMX_512CH);
  end;
  LinkOnline:=true;

  case returnvalue of
    MDMX_OK: listbox1.ItemIndex:=listbox1.Items.Add('Interface erfolgreich an COM'+inttostr(comportnumber)+' verbunden.');
    MDMX_ERROR_SERIALPORT: listbox1.ItemIndex:=listbox1.Items.Add('Schnittstelle COM'+inttostr(comportnumber)+' kann nicht geöffnet werden.');
    MDMX_ERROR_DEVICENOTFOUND: listbox1.ItemIndex:=listbox1.Items.Add('MiniDMX-Dongle kann an COM'+inttostr(comportnumber)+' nicht gefunden werden.');
    MDMX_ERROR_CREATETHREAD: listbox1.ItemIndex:=listbox1.Items.Add('Thread kann nicht gestartet werden.');
    else
      listbox1.ItemIndex:=listbox1.Items.Add('Unbekannter Fehler...');
  end;
  label3.Caption:=inttostr(MDMX_GetDMXTransmissions);
end;

procedure TConfig.CloseLink;
begin
  if (comportnumber<1) or (comportnumber>16) then exit;

  MDMX_Close;
  LinkOnline:=false;
  listbox1.ItemIndex:=listbox1.Items.Add('Verbindung mit COM'+inttostr(comportnumber)+' getrennt.');
end;

procedure TConfig.ComboBox1Select(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  CloseLink;

  if Combobox1.Items.Count > 0 then
  begin                  // COM 13
    temp:=copy(Combobox1.Items[Combobox1.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);
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
	        LReg.WriteInteger('COMPort',comportnumber);
        end;
      end;
    end;
  end;
  LReg.CloseKey;

  OpenLink;
end;

procedure TConfig.RadioButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LReg:TRegistry;
begin
  CloseLink;

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
          if Radiobutton1.Checked then
  	        LReg.WriteInteger('Mode',256)
          else
  	        LReg.WriteInteger('Mode',512);
        end;
      end;
    end;
  end;
  LReg.CloseKey;

  OpenLink;
end;

procedure TConfig.FormDestroy(Sender: TObject);
begin
	shutdown:=true;
  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
end;

procedure TConfig.ActivateCOMPort(portnumber: integer);
var
  i:integer;
  temp:String;
begin
  Combobox1.ItemIndex:=0;
  for i:=0 to Combobox1.items.count-1 do
  begin
    temp:=copy(Combobox1.Items[i],4,2);
    if temp[2]=' ' then
    begin
      // einstellig
      if portnumber=strtoint(temp[1]) then
      begin
        Combobox1.ItemIndex:=i;
        break;
      end;
    end else
    begin
      // zweistellig
      if portnumber=strtoint(temp) then
      begin
        Combobox1.ItemIndex:=i;
        break;
      end;
    end;
  end;
end;

procedure TConfig.FormShow(Sender: TObject);
begin
  Timer1.Enabled:=true;
  label3.Caption:=inttostr(MDMX_GetDMXTransmissions);
  label6.Caption:=inttostr(BadSendings);
end;

procedure TConfig.Timer1Timer(Sender: TObject);
begin
  label3.Caption:=inttostr(MDMX_GetDMXTransmissions);
  label6.Caption:=inttostr(BadSendings);
end;

procedure TConfig.FormHide(Sender: TObject);
begin
  Timer1.Enabled:=false;
end;

procedure Tconfig.startup;
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
  serialport:integer;
  TestHandle : integer;
begin
  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;

	shutdown:=false;
	issending:=false;
  BadSendings:=0;

  // enumerate all serial devices (COM port devices)
    SerialGUID := GUID_DEVINTERFACE_COMPORT;
//    SerialGUID := GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR;
  PnPHandle := SetupDiGetClassDevs(@SerialGUID, nil, 0, DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
  if PnPHandle = Pointer(INVALID_HANDLE_VALUE) then
    Exit;
  Combobox1.Items.BeginUpdate;
  Combobox1.Items.Clear;
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
            Combobox1.Items.Add(PortName + ' (' + DeviceDescription + ', ' + Bus+')');
          end;
          FreeMem(FunctionClassDeviceData);
        end;
      end;
	    CloseHandle(TestHandle);
    end;
    Inc(Devn);
  until not Success;
  SetupDiDestroyDeviceInfoList(PnPHandle);
  Combobox1.Items.EndUpdate;
{
// COM-Ports von 1 bis 16 abklappern
	Combobox1.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    Combobox1.Items.Add('COM '+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;
}

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  serialport:=1;

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
	        if not LReg.ValueExists('Mode') then
	          LReg.WriteInteger('Mode',256);
	        if LReg.ReadInteger('Mode')=256 then
            RadioButton1.Checked:=true
          else
            RadioButton2.Checked:=true;
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  Combobox1.ItemIndex:=0;

  ActivateCOMPort(serialport);
  comportnumber:=serialport;

  if Combobox1.Items.Count > 0 then
  begin
    Combobox1.Visible:=true;
    OpenLink;
  end else
    Combobox1.Visible:=false;
end;

end.
