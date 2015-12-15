unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Registry, CHHighResTimer, jpeg, CPDrv;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    portchange: TComboBox;
    Label2: TLabel;
    ConfigOK: TButton;
    Abbrechen: TButton;
    Bevel1: TBevel;
    Label4: TLabel;
    DMXValueRefreshTimer: TCHHighResTimer;
    Edit2: TEdit;
    Label7: TLabel;
    Label3: TLabel;
    statuslabel: TLabel;
    Shape2: TShape;
    Image1: TImage;
    Label5: TLabel;
    comport: TCommPortDriver;
    procedure FormShow(Sender: TObject);
    procedure DMXValueRefreshTimerTimer(Sender: TObject);
    procedure input_number(var pos:integer; var s:string);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure portchangeDropDown(Sender: TObject);
    procedure portchangeCloseUp(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
    procedure portchangeSelect(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private-Deklarationen }
    ConnectionProblem:boolean;
    TimerInterval:Cardinal;
    procedure SendChannel(Channel:integer; Value: Byte);
    procedure SendEverything;
    procedure SetMasterFader(Value, Fadetime:Byte);
    procedure LoadPreset(Preset:Byte);
  public
    { Public-Deklarationen }
    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    rs232frame_new:array[0..511] of Byte;
    rs232frame:array[0..511] of Byte;
    ChannelvaluesChanged:array of Word;
    ChangedChannels:integer;
    maxchan:word;
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

procedure TConfig.FormShow(Sender: TObject);
begin
  Edit2.Text:=inttostr(TimerInterval);
  Edit2.Color:=clWindow;
end;

procedure TConfig.DMXValueRefreshTimerTimer(Sender: TObject);
var
  i:integer;
begin
  // Veränderte Kanäle im Array überprüfen
  for i:=0 to 511 do
  begin
    if rs232frame[i]<>rs232frame_new[i] then
    begin
      rs232frame[i]:=rs232frame_new[i];

      // ChannelvaluesChanged Array um einen Punkt erhöhen
      setlength(ChannelvaluesChanged, length(ChannelvaluesChanged)+1);
      ChannelvaluesChanged[length(ChannelvaluesChanged)-1]:=i+1;
      inc(ChangedChannels);
    end;
  end;

  if (ChangedChannels>0) then
  begin
    if (ChangedChannels>50) then
    begin
      // Gesamtes Universe senden, da zuviele Werte in dieser Zeit verändert
      SendEverything;
    end else
    begin
      // Einzelne Kanäle senden, da nur wenige Kanäle geändert wurden
      for i:=length(ChannelvaluesChanged)-1 downto 0 do
      begin
        SendChannel(ChannelvaluesChanged[i], rs232frame[ChannelvaluesChanged[i]-1]);
      end;
    end;
    setlength(ChannelvaluesChanged,0);
    ChangedChannels:=0;
  end;
end;

procedure TConfig.SendChannel(Channel:integer; Value: Byte);
var
  RS232Frame:array[0..2] of Byte;
begin
  if comport.Connected then
  begin
    case Channel of
      1..255:
      begin
        RS232Frame[0]:=Byte(2); // Kanal 1-255 oder 512 senden
        RS232Frame[1]:=Byte(Channel); // Kanalwert
      end;
      256..511:
      begin
        RS232Frame[0]:=Byte(3); // Kanal 256-511 senden
        RS232Frame[1]:=Byte(Channel-256); // Kanalwert
      end;
      512:
      begin
        RS232Frame[0]:=Byte(2);  // Kanal 1-255 oder 512 senden
        RS232Frame[1]:=Byte(0);  // Kanalwert
      end;
    end;

    RS232Frame[2]:=Byte(Value);

    connectionproblem:=(comport.SendData(@RS232Frame, 3)<>3);
    if connectionproblem then
    begin
      statuslabel.Caption:='Verbindungsproblem!';
      statuslabel.Font.Color:=clRed;
      DMXValueRefreshTimer.Interval:=2000;
    end else
    begin
      statuslabel.Caption:='Verbunden mit COM'+inttostr(comportnumber);
      statuslabel.Font.Color:=clGreen;
      DMXValueRefreshTimer.Interval:=TimerInterval;
    end;
  end;
end;

procedure TConfig.SendEverything;
var
  RS232BlockFrame1:array[0..257] of Byte;
  RS232BlockFrame2:array[0..258] of Byte;
  RS232Frame3:array[0..2] of Byte;
  i:integer;
begin
  if comport.Connected then
  begin
    // Kanal 1-255 senden
    RS232BlockFrame1[0]:=4; // Block für Kanal 1-255
    RS232BlockFrame1[1]:=1; // Startkanal=1
    RS232BlockFrame1[2]:=255; // Senden von 255 Bytes

    for i:=0 to 254 do
      RS232BlockFrame1[i+3]:=Byte(rs232frame[i]);

    comport.SendData(@RS232BlockFrame1, 258);

    // Kanal 256-511 senden
    RS232BlockFrame2[0]:=5; // Block für Kanal 256-511
    RS232BlockFrame2[1]:=0; // Startkanal=256
    RS232BlockFrame2[2]:=0; // Senden von 256 Bytes

    for i:=0 to 255 do
      RS232BlockFrame2[i+3]:=Byte(rs232frame[i+255]);

    comport.SendData(@RS232BlockFrame2, 259);

    // Kanal 512 senden
    RS232Frame3[0]:=Byte(2);  // Kanal 1-255 oder 512 senden
    RS232Frame3[1]:=Byte(0);  // Kanalwert
    RS232Frame3[2]:=Byte(rs232frame[511]);

    comport.SendData(@RS232Frame3, 3);
  end;
end;

procedure TConfig.SetMasterFader(Value, Fadetime:Byte);
var
  RS232Frame:array[0..2] of Byte;
begin
    RS232Frame[0]:=Byte(7);  // Masterfader verändern
    RS232Frame[1]:=Byte(Value);  // Masterfaderwert (0..200)
    RS232Frame[2]:=Byte(Fadetime);  // Fadetime (0..254)

    comport.SendData(@RS232Frame, 3);
end;

procedure TConfig.LoadPreset(Preset:Byte);
var
  RS232Frame:array[0..2] of Byte;
begin
    RS232Frame[0]:=Byte(12); // Presets laden
    RS232Frame[1]:=Byte(0);  // Kompatibilität (immer =0)
    RS232Frame[2]:=Byte(Preset);  // Preset-Nr (0..239)

    comport.SendData(@RS232Frame, 3);
end;

procedure TConfig.input_number(var pos:integer; var s:string);
var
  i:integer;
begin
  i:=1;
  while i<=length(s) do
    begin
      if (s[i]<'0') or (s[i]>'9') then
        begin
          delete(s,i,1);
          dec(pos);
        end
      else
        inc(i);
    end;
end;

procedure TConfig.Edit2Change(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;

  Edit2.Color:=$00BFBFFF;
end;

procedure TConfig.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LReg:TRegistry;
begin
  if key=vk_return then
  begin
    Edit2.Color:=clWindow;

    if (strtoint(Edit2.Text)<50) then
    begin
      showmessage('Die von Ihnen gewählte Timerzeit ('+Edit2.text+') liegt außerhalb des gültigen Bereichs (>=50ms). Ein niedrigerer Wert wird von Ihrem Interface nicht unterstützt.');
      Edit2.Text:='50';
    end;

    TimerInterval:=strtoint(Edit2.text);
    DMXValueRefreshTimer.Interval:=TimerInterval;

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
            LReg.WriteInteger('Timerspeed',TimerInterval);
          end;
        end;
      end;
    end;
    LReg.CloseKey;
    LReg.Free;
  end;
end;

procedure TConfig.portchangeDropDown(Sender: TObject);
begin
  portchange.Width:=265;
end;

procedure TConfig.portchangeCloseUp(Sender: TObject);
begin
  portchange.Width:=97;
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
  if portchange.Items.Count > 0 then
  begin
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    try
      if comport.Connected then
        comport.Disconnect;
    except
    end;
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
    comport.connect;

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
  serialport:integer;
  i:integer;
  TestHandle : integer;
begin
{
  // these API conversions are loaded dynamically by default
  LoadSetupApi;
  LoadConfigManagerApi;
}

	shutdown:=false;
	issending:=false;

  LReg := TRegistry.Create;
  LReg.RootKey:=HKEY_CURRENT_USER;

  serialport:=2;

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
	        if not LReg.ValueExists('Timerspeed') then
	          LReg.WriteInteger('Timerspeed',75);
	        TimerInterval:=LReg.ReadInteger('Timerspeed');
          if TimerInterval<=50 then
            TimerInterval:=50;
          DMXValueRefreshTimer.Interval:=TimerInterval;
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  try
    if comport.Connected then
	  	comport.disconnect;
  except
  end;
//{
// COM-Ports von 1 bis 16 abklappern
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
//}
{
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
}

  ActivateCOMPort(serialport);

  if portchange.Items.Count > 0 then
  begin
    portchangeSelect(nil);
    portchange.Visible:=true;
  end else
    portchange.Visible:=false;

{
  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
}
end;

end.
