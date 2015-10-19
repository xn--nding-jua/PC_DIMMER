unit USBDeviceTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms,
  JwaWinBase, JwaWinType, JwaDBT,
  Cfg, CfgMgr32,
  USB100, USBIOCtl, USBDesc;

type
  TUSBHostController = class;

  TUSBDeviceTree = class(TComponent)
  private
    FDeviceChangeEvent: TNotifyEvent;
    FUSBHostControllers: array of TUSBHostController;
    function GetCount: Integer;
    function GetUSBHostControllers(Idx: Integer): TUSBHostController;
    procedure Clear;
    function EventPipe(var Msg: TMessage): Boolean;
    procedure SetDeviceChangeEvent(const Notifier: TNotifyEvent);
    procedure DeviceChange;
  protected
    procedure DoDeviceChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RescanDevices;
    property Count: Integer read GetCount;
    property HostControllers[Idx: Integer]: TUSBHostController read GetUSBHostControllers;
  published
    property OnDeviceChange: TNotifyEvent read FDeviceChangeEvent write SetDeviceChangeEvent;
  end;

  TUSBDescriptor = record
    DescriptorType: UCHAR;
    case Integer of
      0:
        (CommonDescr: PUsbCommonDescriptor;);
      USB_DEVICE_DESCRIPTOR_TYPE:
        (DeviceDescr: PUsbDeviceDescriptor;);
      USB_CONFIGURATION_DESCRIPTOR_TYPE:
        (ConfigurationDescr: PUsbConfigurationDescriptor;);
      USB_STRING_DESCRIPTOR_TYPE:
        (StringDescr: PUsbStringDescriptor;);
      USB_INTERFACE_DESCRIPTOR_TYPE:
        (InterfaceDescr: PUsbInterfaceDescriptor;);
      USB_ENDPOINT_DESCRIPTOR_TYPE:
        (EndpointDescr: PUsbEndpointDescriptor;);
      USB_HID_DESCRIPTOR_TYPE:
        (HIDDescr: PUsbHIDDescriptor;);
  end;

  TUSBDevice = class(TObject)
  private
    FRoot: TUSBHostController;
    FParent: TUSBDevice;
    FFileName: string;
    FDriverKeyName: string;
    FDeviceInstance: DEVINST;
    FDeviceDescription: string;
    FConnectionIndex: Cardinal;
    FIsHub: Boolean;
    FIsRootHub: Boolean;
    FDevices: array of TUSBDevice;
    FDeviceInfo: TUsbNodeInformation;
    FConnectionInfo: TUsbNodeConnectionInformation;
    FLanguageID: LANGID;
    FManufacturer: WideString;
    FProduct: WideString;
    FSerialNumber: WideString;
    FConfigurationDescriptor: PUsbDescriptorRequest;
    FDescriptors: array of TUSBDescriptor;
    function GetCount: Integer;
    function GetDescriptorCount: Integer;
    function GetDevices(Idx: Integer): TUSBDevice;
    function GetDescriptors(Idx: Integer): TUSBDescriptor;
    procedure Clear;
    procedure ParseConfigurationDescriptor;
  public
    constructor Create(ARoot: TUSBHostController; AParent: TUSBDevice;
      AFileName: string; AHubHandle: THandle; AConnectionInfo: PUsbNodeConnectionInformation); virtual;
    destructor Destroy; override;
    procedure RescanDevices;
    property ConnectionIndex: Cardinal read FConnectionIndex;
    property ConnectionInfo: TUsbNodeConnectionInformation read FConnectionInfo;
    property Count: Integer read GetCount;
    property DescriptorCount: Integer read GetDescriptorCount;
    property Descriptors[Idx: Integer]: TUSBDescriptor read GetDescriptors;
    property DeviceDescription: string read FDeviceDescription;
    property Devices[Idx: Integer]: TUSBDevice read GetDevices;
    property DeviceInfo: TUsbNodeInformation read FDeviceInfo;
    property DeviceInstance: DEVINST read FDeviceInstance;
    property DriverKeyName: string read FDriverKeyName;
    property FileName: string read FFileName;
    property IsHub: Boolean read FIsHub;
    property IsRootHub: Boolean read FIsRootHub;
    property Parent: TUSBDevice read FParent;
    property Manufacturer: WideString read FManufacturer;
    property Product: WideString read FProduct;
    property SerialNumber: WideString read FSerialNumber;
  end;

  TUSBHostController = class(TObject)
  private
    FConnectionIndex: Cardinal;
    FFileName: string;
    FDriverKeyName: string;
    FDeviceInstance: DEVINST;
    FDeviceDescription: string;
    FRoot: TUSBDeviceTree;
    FRootHub: TUSBDevice;
    FDevicesConnected: Integer;
    FHubsConnected: Integer;
  public
    constructor Create(AFileName: string; AHCHandle: THandle; AConnectionIndex: Cardinal); virtual;
    destructor Destroy; override;
    procedure RescanDevices;
    property ConnectionIndex: Cardinal read FConnectionIndex;
    property DeviceDescription: string read FDeviceDescription;
    property DeviceInstance: DEVINST read FDeviceInstance;
    property DriverKeyName: string read FDriverKeyName;
    property FileName: string read FFileName;
    property Root: TUSBDeviceTree read FRoot;
    property RootHub: TUSBDevice read FRootHub;
    property DevicesConnected: Integer read FDevicesConnected;
    property HubsConnected: Integer read FHubsConnected;
  end;

procedure Register;

implementation

// the Windows.pas declaration is not correct
function DeviceIoControl(hDevice: THandle; dwIoControlCode: DWORD;
  lpInBuffer: Pointer; nInBufferSize: DWORD; lpOutBuffer: Pointer;
  nOutBufferSize: DWORD; lpBytesReturned: LPDWORD;
  lpOverlapped: POverlapped): BOOL; stdcall; external kernel32 name 'DeviceIoControl';

function GetRootHubName(Handle: THandle): string;
var
  NameRec: TUsbRootHubName;
  PNameRec: PUsbRootHubName;
  nBytes, Dummy: DWORD;
begin
  Result := '';
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  if DeviceIoControl(Handle, IOCTL_USB_GET_ROOT_HUB_NAME,
    @NameRec, SizeOf(NameRec), @NameRec, SizeOf(NameRec), @nBytes, nil) then
  begin
    nBytes := NameRec.ActualLength;
    PNameRec := AllocMem(nBytes);
    if DeviceIoControl(Handle, IOCTL_USB_GET_ROOT_HUB_NAME,
      @NameRec, SizeOf(NameRec), PNameRec, nBytes, @Dummy, nil) then
    begin
      Result := PWideChar(@PNameRec^.RootHubName[0]);
      if Result <> '' then
        Result := '\\.\' + Result;
    end;
    FreeMem(PNameRec);
  end;
end;

function GetExternalHubName(Handle: THandle; AConnectionIndex: Cardinal): string;
var
  NameRec: TUsbNodeConnectionName;
  PNameRec: PUsbNodeConnectionName;
  nBytes, Dummy: DWORD;
begin
  Result := '';
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  nBytes := 0;
  FillChar(NameRec, SizeOf(NameRec), #0);
  NameRec.ConnectionIndex := AConnectionIndex;
  if DeviceIoControl(Handle, IOCTL_USB_GET_NODE_CONNECTION_NAME,
    @NameRec, SizeOf(NameRec), @NameRec, SizeOf(NameRec), @nBytes, nil) then
  begin
    nBytes := NameRec.ActualLength;
    PNameRec := AllocMem(nBytes);
    PNameRec^.ConnectionIndex := AConnectionIndex;
    if DeviceIoControl(Handle, IOCTL_USB_GET_NODE_CONNECTION_NAME,
      PNameRec, nBytes, PNameRec, nBytes, @Dummy, nil) then
    begin
      Result := PWideChar(@PNameRec^.NodeName[0]);
      if Result <> '' then
        Result := '\\.\' + Result;
    end;
    FreeMem(PNameRec);
  end;
end;

function GetHCDDriverKeyName(Handle: THandle): string;
var
  NameRec: TUsbHCDDriverKeyName;
  PNameRec: PUsbHCDDriverKeyName;
  nBytes, Dummy: DWORD;
begin
  Result := '';
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  if DeviceIoControl(Handle, IOCTL_GET_HCD_DRIVERKEY_NAME,
    @NameRec, SizeOf(NameRec), @NameRec, SizeOf(NameRec), @nBytes, nil) then
  begin
    nBytes := NameRec.ActualLength;
    PNameRec := AllocMem(nBytes);
    if DeviceIoControl(Handle, IOCTL_GET_HCD_DRIVERKEY_NAME,
      @NameRec, SizeOf(NameRec), PNameRec, nBytes, @Dummy, nil) then
      Result := PWideChar(@PNameRec^.DriverKeyName[0]);
    FreeMem(PNameRec);
  end;
end;

function GetDriverKeyName(Handle: THandle; AConnectionIndex: Cardinal): string;
var
  NameRec: TUsbNodeConnectionDriverKeyName;
  PNameRec: PUsbNodeConnectionDriverKeyName;
  nBytes, Dummy: DWORD;
begin
  Result := '';
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  nBytes := 0;
  FillChar(NameRec, SizeOf(NameRec), #0);
  NameRec.ConnectionIndex := AConnectionIndex;
  if DeviceIoControl(Handle, IOCTL_USB_GET_NODE_CONNECTION_DRIVERKEY_NAME,
    @NameRec, SizeOf(NameRec), @NameRec, SizeOf(NameRec), @nBytes, nil) then
  begin
    nBytes := NameRec.ActualLength;
    PNameRec := AllocMem(nBytes);
    PNameRec^.ConnectionIndex := AConnectionIndex;
    if DeviceIoControl(Handle, IOCTL_USB_GET_NODE_CONNECTION_DRIVERKEY_NAME,
      PNameRec, nBytes, PNameRec, nBytes, @Dummy, nil) then
      Result := PWideChar(@PNameRec^.DriverKeyName[0]);
    FreeMem(PNameRec);
  end;
end;

function GetDeviceInfo(FileName: string): TUsbNodeInformation;
var
  nBytes: DWORD;
  Handle: THandle;
begin
  FillChar(Result, SizeOf(TUsbNodeInformation), 0);
  Handle := CreateFile(PChar(FileName), GENERIC_WRITE,
    FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    if not DeviceIoControl(Handle, IOCTL_USB_GET_NODE_INFORMATION,
      @Result, SizeOf(TUsbNodeInformation),
      @Result, SizeOf(TUsbNodeInformation), @nBytes, nil) then
      FillChar(Result, SizeOf(Result), 0);
    CloseHandle(Handle);
  end;
end;

function GetStrDescriptor(Handle: THandle; AConnectionIndex: Cardinal;
  StringIndex: Byte; LanguageID: LANGID): WideString;
var
  Buffer: array [0..SizeOf(TUsbDescriptorRequest) + MAXIMUM_USB_STRING_LENGTH + SizeOf(WideChar)] of Byte;
  StringDescReq: PUsbDescriptorRequest;
  StringDesc: PUsbStringDescriptor;
  nBytes, Dummy: DWORD;
  Dest: PWideChar;
begin
  Result := '';
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  StringDescReq := @Buffer[0];
  StringDesc := PUsbStringDescriptor(@StringDescReq^.Data[0]);
  nBytes := SizeOf(Buffer) - SizeOf(WideChar);
  FillChar(Buffer[0], SizeOf(Buffer), 0);
  StringDescReq^.ConnectionIndex := AConnectionIndex;
  StringDescReq^.SetupPacket.wValue := (USB_STRING_DESCRIPTOR_TYPE shl 8) or StringIndex;
  StringDescReq^.SetupPacket.wIndex := LanguageID;
  StringDescReq^.SetupPacket.wLength := nBytes - SizeOf(TUsbDescriptorRequest);
  if DeviceIoControl(Handle, IOCTL_USB_GET_DESCRIPTOR_FROM_NODE_CONNECTION,
    StringDescReq, nBytes, StringDescReq, nBytes, @Dummy, nil) then
    if StringIndex = 0 then
    begin
      SetLength(Result, StringDesc^.bLength div SizeOf(WideChar));
      Dest := PWideChar(Result);
      Move(StringDesc^.bString[0], Dest^, StringDesc^.bLength);
    end
    else
      Result := PWideChar(@StringDesc^.bString[0]);
end;

function GetStringDescriptor(Handle: THandle; AConnectionIndex: Cardinal;
  StringIndex: Byte; LanguageID: LANGID): WideString;
begin
  if StringIndex <> 0 then
    Result := GetStrDescriptor(Handle, AConnectionIndex, StringIndex, LanguageID)
  else
    Result := '';
end;

function GetConfigurationDescriptor(Handle: THandle; AConnectionIndex: Cardinal;
  ADescriptorIndex: Byte): PUsbDescriptorRequest;
var
  Buffer: array [0..SizeOf(TUsbDescriptorRequest) + SizeOf(TUsbConfigurationDescriptor)] of Byte;
  ConfigDescReq: PUsbDescriptorRequest;
  ConfigDesc: PUsbConfigurationDescriptor;
  nBytes, nBytesReturned: DWORD;
begin
  Result := nil;
  if Handle = INVALID_HANDLE_VALUE then
    Exit;
  FillChar(Buffer[0], SizeOf(Buffer), 0);
  nBytes := SizeOf(TUsbDescriptorRequest) + SizeOf(TUsbConfigurationDescriptor);
  ConfigDescReq := @Buffer[0];
  ConfigDesc := PUsbConfigurationDescriptor(@ConfigDescReq^.Data[0]);
  ConfigDescReq^.ConnectionIndex := AConnectionIndex;
  ConfigDescReq^.SetupPacket.wValue := (USB_CONFIGURATION_DESCRIPTOR_TYPE shl 8) or ADescriptorIndex;
  ConfigDescReq^.SetupPacket.wIndex := 0;
  ConfigDescReq^.SetupPacket.wLength := nBytes - SizeOf(TUsbDescriptorRequest);
  if DeviceIoControl(Handle, IOCTL_USB_GET_DESCRIPTOR_FROM_NODE_CONNECTION,
    ConfigDescReq, nBytes, ConfigDescReq, nBytes, @nBytesReturned, nil) then
  begin
    if (nBytesReturned = 0) or (ConfigDesc^.wTotalLength < SizeOf(TUsbConfigurationDescriptor)) then
      Exit;
    nBytes := ConfigDesc^.wTotalLength;
    ConfigDescReq := AllocMem(nBytes + SizeOf(TUsbDescriptorRequest));
    ConfigDesc := PUsbConfigurationDescriptor(@ConfigDescReq^.Data[0]);
    ConfigDescReq^.ConnectionIndex := AConnectionIndex;
    ConfigDescReq^.SetupPacket.wValue := (USB_CONFIGURATION_DESCRIPTOR_TYPE shl 8) or ADescriptorIndex;
    ConfigDescReq^.SetupPacket.wIndex := 0;
    ConfigDescReq^.SetupPacket.wLength := nBytes;
    nBytes := nBytes + SizeOf(TUsbDescriptorRequest);
    if DeviceIoControl(Handle, IOCTL_USB_GET_DESCRIPTOR_FROM_NODE_CONNECTION,
      ConfigDescReq, nBytes, ConfigDescReq, nBytes, @nBytesReturned, nil) then
        if (nBytesReturned <> 0) and (ConfigDesc^.wTotalLength = nBytes - SizeOf(TUsbDescriptorRequest)) then
          Result := ConfigDescReq;
    if Result = nil then
      FreeMem(ConfigDescReq);
  end;
end;

function GetDevInst(ADriverName: string): DEVINST;
var
  Dest, Next: DEVINST;
  WalkDone: Boolean;
  Buffer: array [0..1023] of TCHAR;
  S: string;
  Len: ULONG;
begin
  if CM_Locate_DevNode(Dest, nil, 0) = CR_SUCCESS then
  begin
    WalkDone := False;
    while not WalkDone do
    begin
      Len := Length(Buffer) - 1;
      if CM_Get_DevNode_Registry_Property(Dest, CM_DRP_DRIVER, nil,
        @Buffer[0], Len, 0) = CR_SUCCESS then
      begin
        S := PTCHAR(@Buffer[0]);
        if CompareText(ADriverName, S) = 0 then
        begin
          Result := Dest;
          Exit;
        end;
      end;
      if CM_Get_Child(Next, Dest, 0) = CR_SUCCESS then
        Dest := Next
      else
        while True do
        begin
          if CM_Get_Sibling(Next, Dest, 0) = CR_SUCCESS then
          begin
            Dest := Next;
            Break;
          end;
          if CM_Get_Parent(Next, Dest, 0) = CR_SUCCESS then
            Dest := Next
          else
          begin
            WalkDone := True;
            Break;
          end;
        end;
    end;
  end;
  Result := 0;
end;

function GetDeviceDescription(Inst: DEVINST): string;
var
  Buffer: array [0..1023] of TCHAR;
  Len: ULONG;
begin
  Len := Length(Buffer) - 1;
  if (Inst <> 0) and (CM_Get_DevNode_Registry_Property(Inst, CM_DRP_DEVICEDESC, nil,
    @Buffer[0], Len, 0) = CR_SUCCESS) then
    Result := PTCHAR(@Buffer[0])
  else
    Result := '';
end;

//============================================================================

constructor TUSBDeviceTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDeviceChangeEvent := nil;
  LoadConfigManagerAPI;
  RescanDevices;
  if not (csDesigning in ComponentState) then
    Application.HookMainWindow(EventPipe);
end;

destructor TUSBDeviceTree.Destroy;
begin
  // to prevent strange problems
  FDeviceChangeEvent := nil;
  if not (csDesigning in ComponentState) then
    Application.UnhookMainWindow(EventPipe);
  Clear;
  UnloadConfigManagerAPI;
  inherited Destroy;
end;

procedure TUSBDeviceTree.DoDeviceChange;
begin
  if Assigned(FDeviceChangeEvent) then
    FDeviceChangeEvent(Self);
end;

function TUSBDeviceTree.EventPipe(var Msg: TMessage): Boolean;
begin
  Result := True;
  if (Msg.Msg = WM_DEVICECHANGE) and (TWMDeviceChange(Msg).Event = DBT_DEVNODES_CHANGED) then
    DeviceChange;
end;

procedure TUSBDeviceTree.SetDeviceChangeEvent(const Notifier: TNotifyEvent);
begin
  if @FDeviceChangeEvent <> @Notifier then
  begin
    FDeviceChangeEvent := Notifier;
    if not (csLoading in ComponentState) then
      DeviceChange;
  end;
end;

procedure TUSBDeviceTree.DeviceChange;
begin
  RescanDevices;
  DoDeviceChange;
end;

procedure TUSBDeviceTree.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(FUSBHostControllers) - 1 do
    FreeAndNil(FUSBHostControllers[I]);
  SetLength(FUSBHostControllers, 0);
end;

procedure TUSBDeviceTree.RescanDevices;
var
  I: Cardinal;
  HCHandle: THandle;
  Name: string;
  HC: TUSBHostController;
begin
  if csDesigning in ComponentState then
    Exit;

  Clear;

  I := 0;
  repeat
    Name := Format('\\.\HCD%u', [I]);
    HCHandle := CreateFile(PChar(Name), GENERIC_WRITE,
    FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
    if HCHandle <> INVALID_HANDLE_VALUE then
    begin
      SetLength(FUSBHostControllers, Length(FUSBHostControllers) + 1);
      HC := TUSBHostController.Create(Name, HCHandle, I);
      FUSBHostControllers[Length(FUSBHostControllers) - 1] := HC;
      CloseHandle(HCHandle);
    end;
    Inc(I);
  until HCHandle = INVALID_HANDLE_VALUE;
end;

function TUSBDeviceTree.GetCount: Integer;
begin
  Result := Length(FUSBHostControllers);
end;

function TUSBDeviceTree.GetUSBHostControllers(Idx: Integer): TUSBHostController;
begin
  if (Idx >= 0) and (Idx < Count) then
    Result := FUSBHostControllers[Idx]
  else
    Result := nil;
end;

//============================================================================

constructor TUSBHostController.Create(AFileName: string; AHCHandle: THandle; AConnectionIndex: Cardinal);
begin
  inherited Create;
  FFileName := AFileName;
  FConnectionIndex := AConnectionIndex;
  FDriverKeyName := GetHCDDriverKeyName(AHCHandle);
  FDeviceInstance := GetDevInst(FDriverKeyName);
  FDeviceDescription := GetDeviceDescription(FDeviceInstance);
  FDevicesConnected := 0;
  FHubsConnected := 0;
  FRootHub := TUSBDevice.Create(Self, nil, GetRootHubName(AHCHandle), INVALID_HANDLE_VALUE, nil);
end;

destructor TUSBHostController.Destroy;
begin
  FRootHub.Free;
  inherited Destroy;
end;

procedure TUSBHostController.RescanDevices;
begin
  RootHub.RescanDevices;
end;

//============================================================================

constructor TUSBDevice.Create(ARoot: TUSBHostController; AParent: TUSBDevice;
  AFileName: string; AHubHandle: THandle; AConnectionInfo: PUsbNodeConnectionInformation);
var
  S: WideString;
begin
  inherited Create;
  FRoot := ARoot;
  FParent := AParent;
  FFileName := AFileName;

  FDeviceInstance := 0;
  FLanguageID := 0;
  FManufacturer := '';
  FProduct := '';
  FSerialNumber := '';
  FDriverKeyName := '';
  FDeviceDescription := '';
  FConfigurationDescriptor := nil;
  FConnectionIndex := 0;
  FillChar(FConnectionInfo, SizeOf(FConnectionInfo), 0);
  FillChar(FDeviceInfo, SizeOf(FDeviceInfo), 0);
  S := '';

  if AConnectionInfo <> nil then
  begin
    FConnectionInfo := AConnectionInfo^;
    FConnectionIndex := FConnectionInfo.ConnectionIndex;
  end;

  FIsRootHub := (ConnectionIndex = 0) and (AParent = nil);
  FIsHub := FConnectionInfo.DeviceIsHub or IsRootHub;
  if ConnectionIndex <> 0 then
  begin
    FDriverKeyName := GetDriverKeyName(AHubHandle, ConnectionIndex);
    FConfigurationDescriptor := GetConfigurationDescriptor(AHubHandle, ConnectionIndex, 0);
    ParseConfigurationDescriptor;
    FDeviceInstance := GetDevInst(FDriverKeyName);
    FDeviceDescription := GetDeviceDescription(FDeviceInstance);
    {
    S := GetStrDescriptor(AHubHandle, ConnectionIndex, 0, 0);
    if S <> '' then
    begin
      FLanguageID := LANGID(S[1]);
      FManufacturer := GetStringDescriptor(AHubHandle, ConnectionIndex,
        FConnectionInfo.DeviceDescriptor.iManufacturer, FLanguageID);
      FProduct := GetStringDescriptor(AHubHandle, ConnectionIndex,
        FConnectionInfo.DeviceDescriptor.iProduct, FLanguageID);
      FSerialNumber := GetStringDescriptor(AHubHandle, ConnectionIndex,
        FConnectionInfo.DeviceDescriptor.iSerialNumber, FLanguageID);
    end;
    }
  end
  else
  if IsRootHub then
    FDeviceDescription := 'Root Hub';

  if IsHub then
    Inc(ARoot.FHubsConnected)
  else
    Inc(ARoot.FDevicesConnected);

  if IsHub then
  begin
    FDeviceInfo := GetDeviceInfo(AFileName);
    RescanDevices;
  end;
end;

destructor TUSBDevice.Destroy;
begin
  Clear;
  if FConfigurationDescriptor <> nil then
    FreeMem(FConfigurationDescriptor);
  inherited Destroy;
end;

procedure TUSBDevice.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(FDevices) - 1 do
    FreeAndNil(FDevices[I]);
  SetLength(FDevices, 0);
end;

procedure TUSBDevice.RescanDevices;
var
  I: Cardinal;
  Hub: THandle;
  nBytes, Dummy: DWORD;
  PConnectionInfo: PUsbNodeConnectionInformation;
begin
  if not IsHub then
    Exit;
  Clear;
  SetLength(FDevices, Cardinal(DeviceInfo.HubInformation.HubDescriptor.bNumberOfPorts));

  Hub := CreateFile(PChar(FileName), GENERIC_WRITE,
    FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if Hub <> INVALID_HANDLE_VALUE then
  begin
    // a device should not have more than 30 endpoints
    nBytes := SizeOf(TUsbNodeConnectionInformation) + SizeOf(TUsbPipeInfo) * 30;
    PConnectionInfo := AllocMem(nBytes);
    for I := 1 to Count do
    begin
      PConnectionInfo^.ConnectionIndex := I;
      if DeviceIoControl(Hub, IOCTL_USB_GET_NODE_CONNECTION_INFORMATION,
        PConnectionInfo, nBytes, PConnectionInfo, nBytes, @Dummy, nil) then
        if (PConnectionInfo^.ConnectionStatus = DeviceConnected) and
          (PConnectionInfo^.CurrentConfigurationValue <> 0) then
          FDevices[I - 1] := TUSBDevice.Create(FRoot, Self,
            GetExternalHubName(Hub, I), Hub, PConnectionInfo);
    end;
    FreeMem(PConnectionInfo);
    CloseHandle(Hub);
  end;
end;

function TUSBDevice.GetCount: Integer;
begin
  Result := Length(FDevices);
end;

function TUSBDevice.GetDescriptorCount: Integer;
begin
  Result := Length(FDescriptors);
end;

function TUSBDevice.GetDevices(Idx: Integer): TUSBDevice;
begin
  if IsHub and (Idx >= 0) and (Idx < Count) then
    Result := FDevices[Idx]
  else
    Result := nil;
end;

function TUSBDevice.GetDescriptors(Idx: Integer): TUSBDescriptor;
begin
  if (Idx >= 0) and (Idx < DescriptorCount) then
    Result := FDescriptors[Idx]
  else
  begin
    Result.DescriptorType := 0;
    Result.CommonDescr := nil;
  end;
end;

procedure TUSBDevice.ParseConfigurationDescriptor;
var
  N: Integer;
  Descr: PUsbCommonDescriptor;
  DescrEnd: PChar;
  ConfigDescr: PUsbConfigurationDescriptor;
begin
  if FConfigurationDescriptor <> nil then
  begin
    ConfigDescr := PUsbConfigurationDescriptor(@FConfigurationDescriptor^.Data[0]);
    Descr := PUsbCommonDescriptor(ConfigDescr);
    DescrEnd := PChar(Descr) + ConfigDescr^.wTotalLength;
    N := 0;
    while (PChar(Descr) + SizeOf(TUsbCommonDescriptor) < DescrEnd) and
      (PChar(Descr) + Descr^.bLength < DescrEnd) do
    begin
      SetLength(FDescriptors, N + 1);
      FDescriptors[N].DescriptorType := Descr^.bDescriptorType;
      case Descr^.bDescriptorType of
        0:
          FDescriptors[N].CommonDescr := Descr;
        USB_DEVICE_DESCRIPTOR_TYPE:
          FDescriptors[N].DeviceDescr := PUsbDeviceDescriptor(Descr);
        USB_CONFIGURATION_DESCRIPTOR_TYPE:
          FDescriptors[N].ConfigurationDescr := PUsbConfigurationDescriptor(Descr);
        USB_STRING_DESCRIPTOR_TYPE:
          FDescriptors[N].StringDescr := PUsbStringDescriptor(Descr);
        USB_INTERFACE_DESCRIPTOR_TYPE:
          FDescriptors[N].InterfaceDescr := PUsbInterfaceDescriptor(Descr);
        USB_ENDPOINT_DESCRIPTOR_TYPE:
          FDescriptors[N].EndPointDescr := PUsbEndpointDescriptor(Descr);
      end;
      Inc(N);
      Descr := PUsbCommonDescriptor(PChar(Descr) + Descr^.bLength);
    end;
  end;
end;

//============================================================================

procedure Register;
begin
  RegisterComponents('Project JEDI', [TUSBDeviceTree]);
end;

end.
