unit configfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPDrv, ExtCtrls, Registry, pngimage,
  CHHighResTimer;

type
  TCallback = procedure(address,startvalue,endvalue,fadetime:integer);stdcall;
  TCallbackEvent = procedure(address,endvalue:integer);stdcall;

  TConfig = class(TForm)
    Label1: TLabel;
    comport: TCommPortDriver;
    ConfigOK: TButton;
    Abbrechen: TButton;
    Image1: TImage;
    Bevel3: TBevel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    baudratechange: TComboBox;
    Label2: TLabel;
    portchange: TComboBox;
    Label4: TLabel;
    Label12: TLabel;
    GroupBox3: TGroupBox;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    Label3: TLabel;
    versionlbl: TLabel;
    lastchanlbl: TLabel;
    scenelbl: TLabel;
    dmxpinlbl: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    RefreshDMXValuesTimer: TCHHighResTimer;
    ListBox1: TListBox;
    DebugBtn: TButton;
    Edit2: TEdit;
    Button4: TButton;
    SuchTimer: TTimer;
    Button5: TButton;
    CheckBox1: TCheckBox;
    TimeOutLbl: TLabel;
    TimeOutTimer: TTimer;
    procedure portchangeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure baudratechangeChange(Sender: TObject);
    procedure InitializeInterface;
    procedure comportReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure input_number(var pos:integer; var s:string);
    procedure RefreshDMXValuesTimerTimer(Sender: TObject);
    procedure DebugBtnClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SuchTimerTimer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimeOutTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActivateCOMPort(portnumber: integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    debugmode:boolean;
    comportnumber:integer;
    baudrate:integer;
    rs232_inframe:array of byte;
    RefreshDLLValues:TCallback;
    RefreshDLLEvent:TCallbackEvent;
    issending:boolean;
    shutdown:boolean;
    ChannelValues:array[0..128] of Byte;
    rs232frame:array of array[0..128] of Byte;
    rs232frame_locked:boolean;
    maxchan:byte;
    lastanswer:char;
    refreshsettings:boolean;
    controllerready:boolean;
    sendcontinuosly:boolean;
    showidlelabel:boolean;
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

procedure TConfig.portchangeChange(Sender: TObject);
var
  LReg:TRegistry;
  temp:string;
begin
  if portchange.Items.Count > 0 then
  begin                  // COM 13
    temp:=copy(portchange.Items[portchange.Itemindex],4,2);
    if temp[2]=' ' then
      comportnumber:=strtoint(temp[1])
    else
      comportnumber:=strtoint(temp);

    try
      if config.comport.Connected then
        Config.comport.Disconnect;
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

    if Sender=portchange then
      InitializeInterface;

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
end;

procedure TConfig.Button1Click(Sender: TObject);
begin
  Listbox1.ItemIndex:=Listbox1.Items.Add('Sende: "Szene speichern" ('+inttostr(230+Combobox2.ItemIndex)+')');
  if Combobox2.Items.Count>0 then
    config.comport.SendByte(230+Combobox2.ItemIndex);
end;

procedure TConfig.Button2Click(Sender: TObject);
begin
  Listbox1.ItemIndex:=Listbox1.Items.Add('Sende: "Szene laden" ('+inttostr(240+Combobox2.ItemIndex)+')');
  if Combobox2.Items.Count>0 then
    config.comport.SendByte(240+Combobox2.ItemIndex);
end;

procedure TConfig.baudratechangeChange(Sender: TObject);
var
  LReg:TRegistry;
begin
  baudrate:=strtoint(baudratechange.Items[baudratechange.Itemindex]);
  try
    if config.comport.Connected then
	  	Config.comport.Disconnect;
  except
  end;
  comport.BaudRateValue:=baudrate;

  case baudratechange.ItemIndex of
    0: RefreshDMXValuesTimer.Interval:=25;
    1: RefreshDMXValuesTimer.Interval:=50;
  end;

  if Sender=baudratechange then
    InitializeInterface;
    
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
end;

procedure TConfig.InitializeInterface;
begin
  SuchTimer.enabled:=true;
  Label12.Caption:='Suche...';
  Label12.Font.Color:=clBlack;
  Label12.Alignment:=taCenter;

  if comport.Connected then
    comport.Disconnect;
  if Listbox1.ItemIndex>0 then
    Listbox1.ItemIndex:=Listbox1.Items.Add('');
  Listbox1.ItemIndex:=Listbox1.Items.Add('Initialisiere Interface...');
  Listbox1.ItemIndex:=Listbox1.Items.Add('--------------------------');
  comport.connect;

  controllerready:=false;
  maxchan:=strtoint(Edit1.text);
  Listbox1.ItemIndex:=Listbox1.Items.Add('Sende: Kanalanzahl ('+inttostr(maxchan)+')');
  comport.SendByte(maxchan);
  Listbox1.ItemIndex:=Listbox1.Items.Add('Sende: "GetStatus" (200)');
  comport.SendByte(200);
end;

procedure TConfig.comportReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
var
  s: string;
  wert:byte;
  character:char;
  i:integer;
begin
  // Convert incoming data into a string
  s := StringOfChar( ' ', DataSize );
  move( DataPtr^, pchar(s)^, DataSize );
  if (s[1]='T') and (length(s)>1) then
    s:=copy(s,2,length(s));
  if (s[1]='A') and (length(s)>1) then
    s:=copy(s,2,length(s));
  if (s[1]='H') and (length(s)>1) then
    s:=copy(s,2,length(s));

{
Info		200		    X	      09	    128	  4	  0		        !
        Befehl    Antwort Version	MaxCh	Mem	0=Standard	Ende
}
  character:=s[1];
  lastanswer:=character;

  if character='A' then
  begin
{
    label12.Caption:='Interface verbunden';
    label12.Font.Color:=clGreen;
//    listbox1.ItemIndex:=Listbox1.Items.Add(character+' - Acknowledged');
}
    controllerready:=true;
  end else
  if character='H' then
  begin
    controllerready:=true;
    label12.Caption:='Interface verbunden';
    label12.Font.Color:=clGreen;
    listbox1.ItemIndex:=Listbox1.Items.Add('Empfange: '+character+' - Interface OK');
  end else
  if character='T' then
  begin
    if config.Showing then
    begin
      showidlelabel:=true;
      TimeOutLbl.Visible:=true;
      TimeOutTimer.enabled:=true;
    end;
//    listbox1.ItemIndex:=Listbox1.Items.Add('Empfange: '+character+' - Timeout (Leerlauf)');
  end else
  if character='X' then
  begin
    controllerready:=true;
    label12.Caption:='Interface verbunden';
    label12.Font.Color:=clGreen;
    listbox1.ItemIndex:=Listbox1.Items.Add('Empfange: '+character+' - Interface-Info:');

    wert:=Byte(s[2]); // Version einlesen
    DecimalSeparator := '.';
    versionlbl.Caption:=floattostrf(wert/10,ffGeneral,2,1);
    listbox1.ItemIndex:=Listbox1.Items.Add('  Version: '+floattostrf(wert/10,ffGeneral,2,1));
    wert:=Byte(s[3]); // Letzten Kanal einlesen
    lastchanlbl.Caption:=inttostr(wert);
    listbox1.ItemIndex:=Listbox1.Items.Add('  Last Chan: '+inttostr(wert));
    wert:=Byte(s[4]); // Szenenspeicherzahl einlesen
    scenelbl.Caption:=inttostr(wert);
    listbox1.ItemIndex:=Listbox1.Items.Add('  Scenememory: '+inttostr(wert));

    Combobox2.Items.Clear;
    for i:=0 to wert-1 do
    begin
      Combobox2.Items.Add(inttostr(i+1));
    end;

    if s[5]<>'!' then
    begin
      wert:=Byte(s[5]); // Einlesen, ob Pins vertauscht
      case wert of
        0:
        begin
          dmxpinlbl.Caption:='NEIN';
          listbox1.ItemIndex:=Listbox1.Items.Add(  'PIN Swap: No');
        end;
        255:
        begin
          dmxpinlbl.Caption:='JA';
          listbox1.ItemIndex:=Listbox1.Items.Add(  'PIN Swap: Yes');
        end;
      end;
    end;
  end else
  begin
    listbox1.ItemIndex:=Listbox1.Items.Add('Empfange: '+character+' - Undefined (Baudrate OK?)');
  end;
end;

procedure TConfig.Button3Click(Sender: TObject);
begin
  InitializeInterface;
end;

procedure TConfig.Edit1Change(Sender: TObject);
var
  s:string;
  i:integer;
  LReg:TRegistry;
begin
  s:=TEdit(Sender).text;
  i:=TEdit(Sender).selstart;
  input_number(i,s);
  TEdit(Sender).text:=s;
  TEdit(Sender).selstart:=i;
  maxchan:=strtoint(Edit1.text);

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
	        LReg.WriteInteger('Last Chan',maxchan);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
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

procedure TConfig.RefreshDMXValuesTimerTimer(Sender: TObject);
begin
  if refreshsettings or sendcontinuosly then
    if comport.Connected and controllerready then
    begin
      comport.SendData(@ChannelValues,maxchan+1);
      refreshsettings:=false;
    end;
end;

procedure TConfig.DebugBtnClick(Sender: TObject);
begin
  if config.Width>393 then
  begin
    config.Width:=393;
    debugmode:=false;
    debugbtn.Caption:='Debug >>';
  end else
  begin
    config.Width:=593;
    debugmode:=true;
    debugbtn.Caption:='<< Debug';
  end;
end;

procedure TConfig.Button4Click(Sender: TObject);
begin
  Listbox1.ItemIndex:=Listbox1.Items.Add('Sende: Ping (210)');
  comport.SendByte(210);
end;

procedure TConfig.SuchTimerTimer(Sender: TObject);
begin
  SuchTimer.enabled:=false;
  if not controllerready then
  begin
    label12.Caption:='Interface nicht gefunden...';
    label12.Font.Color:=clRed;
  end else
  begin
    label12.Caption:='Interface verbunden';
    label12.Font.Color:=clGreen;
  end;
end;

procedure TConfig.Button5Click(Sender: TObject);
begin
  listbox1.Items.Clear;
end;

procedure TConfig.CheckBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LReg:TRegistry;
begin
  sendcontinuosly:=Checkbox1.Checked;

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
	        LReg.WriteBool('Send Continuosly',sendcontinuosly);
        end;
      end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;
end;

procedure TConfig.TimeOutTimerTimer(Sender: TObject);
begin
  if not showidlelabel then
  begin
    TimeOutTimer.enabled:=false;
    TimeOutLbl.visible:=false;
  end;

  showidlelabel:=false;
end;

procedure TConfig.FormDestroy(Sender: TObject);
begin
  // unload API conversions
  UnloadSetupApi;
  UnloadConfigManagerApi;
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

procedure TConfig.Startup;
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
  serialport,regbaudrate:integer;
  TestHandle : integer;
begin
  FillChar(ChannelValues, SizeOf(ChannelValues), 0);
  ChannelValues[0]:=0;

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
	        if not LReg.ValueExists('COMPort') then
	          LReg.WriteInteger('COMPort',2);
	        serialport:=LReg.ReadInteger('COMPort');
	        if not LReg.ValueExists('Baudrate') then
	          LReg.WriteInteger('Baudrate',115200);
	        regbaudrate:=LReg.ReadInteger('Baudrate');
	        if not LReg.ValueExists('Last Chan') then
	          LReg.WriteInteger('Last Chan',64);
	        maxchan:=LReg.ReadInteger('Last Chan');
          if maxchan>128 then maxchan:=128;
          Edit1.Text:=inttostr(maxchan);
	        if not LReg.ValueExists('Send Continuosly') then
	          LReg.WriteBool('Send Continuosly',false);
	        sendcontinuosly:=LReg.ReadBool('Send Continuosly');
	      end;
 			end;
    end;
  end;
  LReg.CloseKey;
  LReg.Free;

  try
    if config.comport.Connected then
	  	Config.comport.Disconnect;
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
{
// COM-Ports von 1 bis 16 abklappern
	portchange.Clear;
	for i:=1 to 16 do
	begin
	  TestHandle := CreateFile(PChar('\\.\COM'+IntToStr(i)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,FILE_FLAG_OVERLAPPED,LongInt(0));
	  if (TestHandle > 0) then
	  begin
	    portchange.Items.Add('COM '+inttostr(i));
	    CloseHandle(TestHandle);
	  end;
	end;
}

  Edit1.Text:=inttostr(maxchan);

  ActivateCOMPort(serialport);

  if portchange.Items.Count > 0 then
  begin
    portchangeChange(nil);
    portchange.Visible:=true;
  end else
    portchange.Visible:=false;
  case regbaudrate of
    115200: baudratechange.ItemIndex:=0;
    57600: baudratechange.ItemIndex:=1;
  else
    baudratechange.ItemIndex:=0;
  end;
  baudratechangeChange(nil);

  Checkbox1.Checked:=sendcontinuosly;

  InitializeInterface;
end;

end.
