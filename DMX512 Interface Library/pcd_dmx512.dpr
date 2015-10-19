library pcd_dmx512;

uses
  SysUtils,
  Classes,
  LibUSB,
  WinTypes,
  Dialogs;

const
  cmd_SetSingleChannel=1;
{
  usb request for cmd_SetSingleChannel:
	bmRequestType:	ignored by device, should be USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT
	bRequest:		cmd_SetSingleChannel
	wValue:			value of channel to set [0 .. 255]
	wIndex:			channel index to set [0 .. 511]
	wLength:		ignored
}
  cmd_SetChannelRange=2;
{
  usb request for cmd_SetChannelRange:
	bmRequestType:	ignored by device, should be USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT
	bRequest:		cmd_SetChannelRange
	wValue:			number of channels to set [1 .. 512-wIndex]
	wIndex:			index of first channel to set [0 .. 511]
	wLength:		length of data, must be >= wValue
}

  cmd_StartBootloader=50;
  err_BadChannel=1;
  err_BadValue=2;
  USBDEV_SHARED_VENDOR=5824;//0x16C0
  USBDEV_SHARED_PRODUCT=1500;//0x05DC

{$R *.res}

type
  TSenderEvent = procedure () of object;
  TSenderThread = class(TThread)
  private
    FSenderEvent:TSenderEvent;
  protected
    procedure Execute; override;
  public
    constructor create(SenderEvent:TSenderEvent);
  end;

  
  TDMXArray = array[0..511] of byte;
  PDMXArray = ^TDMXArray;
  TSerial = array[0..15] of char;
  TSerialList = array[0..31] of TSerial;

  TDMXDevice = record
    Pointer:pusb_device;
    Handle:pusb_dev_handle;
    Name:string[64];
    Vendor:string[64];
    Serial:TSerial;
    Active:boolean;
    MaxChans:integer;
    MaxChangedChans:integer;
  end;

var
  DMXDevices:array of TDMXDevice;
  PointerToDMXArray:array of PDMXArray;
  Channelvalues:array of TDMXArray;
  ChannelvaluesChanged:array of array of Word;
  ChangedChannels:integer;
  TimeHandle:UINT;
  SenderThread:TThread;
  ThreadOnline:boolean;
  UseTimer:boolean;

  ConnectedInterfaces:TSerialList;
  OpenedInterfaces:TSerialList;

function SerialToSerialstring(Serial: TSERIAL): string;
var
  i: byte;
begin
  Result := '';
  for i := 0 to 15 do
    Result := Result + Serial[i];
end;

function SerialstringToSerial(Serialstr: string): TSERIAL;
var
  i: byte;
  len: byte;
begin
  len := length(Serialstr);
  if len > 16 then
    len := 16;
  for i := 0 to 15 do
    Result[i] := '0';
  for i := 1 to len do
    Result[i + 15 - len] := Serialstr[i];
end;

procedure TimerProc(hwnd:HWND; msg:UINT; idEvent:UINT; dwTimer:DWORD);stdcall;
var
  i,j:integer;
  buffer:array[0..7] of byte;
begin
  if UseTimer then
  begin
    // Veränderte Kanäle im Array überprüfen
    for i:=0 to length(PointerToDMXArray)-1 do
    begin
      for j:=0 to 511 do
      begin
        if PointerToDMXArray[i]^[j]<>Channelvalues[i][j] then
        begin
          Channelvalues[i][j]:=PointerToDMXArray[i]^[j];

          // ChannelvaluesChanged Array um einen Punkt erhöhen
          setlength(ChannelvaluesChanged[i], length(ChannelvaluesChanged[i])+1);
          ChannelvaluesChanged[i][length(ChannelvaluesChanged[i])-1]:=j+1;
          inc(ChangedChannels);
        end;
      end;
    end;

    if (ChangedChannels>0) then
    begin
      for i:=0 to length(DMXDevices)-1 do
      begin
        if DMXDevices[i].Active and Assigned(DMXDevices[i].Handle) then
        begin
          if (ChangedChannels>DMXDevices[i].MaxChangedChans) then
          begin
            // Gesamtes Universe senden, da zuviele Werte in dieser Zeit verändert
            usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetChannelRange, DMXDevices[i].MaxChans, 0, Channelvalues[i], DMXDevices[i].MaxChans, 5000);
          end else
          begin
            // Einzelne Kanäle senden, da nur wenige Kanäle geändert wurden
            for j:=length(ChannelvaluesChanged[i])-1 downto 0 do
            begin
              if (ChannelvaluesChanged[i][j]<=DMXDevices[i].MaxChans) then
                usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, Channelvalues[i][ChannelvaluesChanged[i][j]-1], ChannelvaluesChanged[i][j]-1, buffer, sizeof(buffer), 5000);
            end;
          end;
        end;
        setlength(ChannelvaluesChanged[i],0);
      end;
      ChangedChannels:=0;
    end;
  end;
end;

function GetAllConnectedInterfaces: TSerialList;stdcall;
var
  bus: pusb_bus;
  dev:pusb_device;
  udev:pusb_dev_handle;
  i, counter: integer;
  description, vendor: array[0..255] of char;
  serial:array[0..255] of char;
  pcd_serial:TSerial;
  justinhere:boolean;
begin
  // Diese Funktion listet lediglich alle angeschlossenen Interfaces auf

  for i:=0 to 31 do
    ConnectedInterfaces[i]:=SerialstringToSerial('0000000000000000');

  usb_init;
  usb_find_busses; // Finds all USB busses on system
  usb_find_devices; // Find all devices on all USB devices
  bus := usb_get_busses; // Return the list of USB busses found

  counter:=0;
  while Assigned(bus) do
  begin
    dev := bus^.devices;

    while Assigned(dev) do
    begin
      udev := usb_open(dev);
      if Assigned(udev) then
      begin
        if (dev^.descriptor.iProduct > 0) then
        begin
          usb_get_string_simple(udev, dev^.descriptor.iProduct, description, sizeof(description));
        end;

        if dev^.descriptor.iManufacturer > 0 then
        begin
          usb_get_string_simple(udev, dev^.descriptor.iManufacturer, vendor, sizeof(vendor));
        end;

        if (dev^.descriptor.iSerialNumber > 0) then
        begin
          usb_get_string_simple(udev, dev^.descriptor.iSerialNumber, serial, sizeof(serial));
        end;

        if (dev^.descriptor.idVendor=USBDEV_SHARED_VENDOR) and (dev^.descriptor.idProduct=USBDEV_SHARED_PRODUCT) and
          (vendor='www.pcdimmer.de') and (description='PC_DIMMER DMX512 Interface (uDMX)') then
        begin
          justinhere:=false;

          for i:=0 to 15 do
            pcd_serial[i]:=serial[i];

          for i:=0 to 31 do
          if ConnectedInterfaces[i]=pcd_serial then
          begin
            justinhere:=true;
            break;
          end;

          if (counter<=31) and (not justinhere) then
          begin
            ConnectedInterfaces[counter]:=pcd_serial;
            inc(counter);
          end;
        end else
        begin
        end;
        usb_close(udev);
      end;

      dev := dev^.next;
    end;
    bus := bus^.next;
  end;

  Result:=ConnectedInterfaces;
end;

function GetAllOpenedInterfaces: TSerialList;stdcall;
var
  i,counter:integer;
begin
  for i:=0 to 31 do
    OpenedInterfaces[i]:=SerialstringToSerial('0000000000000000');

  counter:=-1;
  for i:=0 to length(DMXDevices)-1 do
  begin
    if DMXDevices[i].Active then
    begin
      inc(counter);
      OpenedInterfaces[counter]:=DMXDevices[i].Serial;
    end;
  end;
  result:=OpenedInterfaces;
end;

procedure SearchForInterfaces;stdcall;
begin
  ConnectedInterfaces:=GetAllConnectedInterfaces;
  OpenedInterfaces:=GetAllOpenedInterfaces;
end;

function GetConnectedInterface(Number:integer):TSerial;stdcall;
begin
  result:=ConnectedInterfaces[Number];
end;

function GetOpenedInterface(Number:integer):TSerial;stdcall;
begin
  result:=OpenedInterfaces[Number];
end;

procedure SetInterfaceMode(Serial: TSerial; Mode: Byte);stdcall;
begin
  // For future use (perhaps DMXIN)
end;

procedure OpenLink(Serial: TSerial; DMXOutArray:PDMXArray);stdcall;
var
  bus: pusb_bus;
  dev:pusb_device;
  udev:pusb_dev_handle;
  i,Position: integer;
  description, vendor, serial_dev: array [0..255] of char;
  pcd_serial:TSerial;
  buffer:array[0..7] of byte;
begin
  if Serial=SerialstringToSerial('0000000000000000') then exit;

  UseTimer:=false;

//  usb_init;
//  usb_find_busses; // Finds all USB busses on system
//  usb_find_devices; // Find all devices on all USB devices
  bus := usb_get_busses; // Return the list of USB busses found

  while Assigned(bus) do
  begin
    dev := bus^.devices;

    while Assigned(dev) do
    begin
      udev := usb_open(dev);
      if Assigned(udev) then
      begin
        if (dev^.descriptor.iProduct > 0) then
        begin
          usb_get_string_simple(udev, dev^.descriptor.iProduct, description, sizeof(description));
        end;

        if dev^.descriptor.iManufacturer > 0 then
        begin
          usb_get_string_simple(udev, dev^.descriptor.iManufacturer, vendor, sizeof(vendor));
        end;

        serial_dev:='';
        if (dev^.descriptor.iSerialNumber > 0) then
        begin
          usb_get_string_simple(udev, dev^.descriptor.iSerialNumber, serial_dev, sizeof(serial_dev));
        end;

        if (dev^.descriptor.idVendor=USBDEV_SHARED_VENDOR) and (dev^.descriptor.idProduct=USBDEV_SHARED_PRODUCT) and
          (vendor='www.pcdimmer.de') and (description='PC_DIMMER DMX512 Interface (uDMX)') then
        begin
          // Gerät ist ein PC_DIMMER DMX512 (uDMX) Interface
          if (String(serial_dev)=SerialToSerialstring(serial)) then
          begin
            Position:=-1;

            for i:=0 to 15 do
              pcd_serial[i]:=serial[i];

            // Ist das Gerät bereits geöffnet?
            for i:=0 to length(DMXDevices)-1 do
            begin
              if DMXDevices[i].Serial=pcd_serial then
              begin
                Position:=i;
                break;
              end;
            end;

            if (Position=-1) then
            begin
              // Interface ist noch nicht geöffnet, also öffnen

              // Freie Stelle in Array suchen
              for i:=0 to length(DMXDevices)-1 do
              begin
                if DMXDevices[i].Serial=SerialstringToSerial('0000000000000000') then
                begin
                  Position:=i;
                  break;
                end;
              end;

              if Position=-1 then
              begin
                // keine Freie stelle in Array gefunden -> Array erweitern
                if length(DMXDevices)>31 then exit;

                setlength(DMXDevices, length(DMXDevices)+1);
                setlength(PointerToDMXArray, length(DMXDevices));
                setlength(Channelvalues, length(DMXDevices));
                setlength(ChannelvaluesChanged, length(DMXDevices));
                Position:=length(DMXDevices)-1;
              end;

              DMXDevices[Position].Pointer:=dev;
              DMXDevices[Position].Handle:=udev;

              DMXDevices[Position].Name:=String(description);
              DMXDevices[Position].Vendor:=String(vendor);

              DMXDevices[Position].MaxChans:=512;
              DMXDevices[Position].MaxChangedChans:=64;

              if pcd_serial='' then
                DMXDevices[Position].Serial:='n/a'
              else
                DMXDevices[Position].Serial:=pcd_serial;

              PointerToDMXArray[Position]:=DMXOutArray;
              DMXDevices[Position].Active:=true;

              // Letzten Kanal senden, damit Interface initialisiert wird:
              usb_control_msg(DMXDevices[Position].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, 0, DMXDevices[Position].MaxChans-1, buffer, sizeof(buffer), 5000);
            end else
            begin
              // Gerät ist bereits vorhanden und geöffnet -> Arraypointer aktualisieren
              DMXDevices[Position].Active:=false;
              PointerToDMXArray[Position]:=DMXOutArray;
              DMXDevices[Position].Active:=true;
            end;
          end;
        end;
      end;
      dev := dev^.next;
    end;
    bus := bus^.next;
  end;

  if UseTimer then
  begin
    ThreadOnline:=false;
    TimeHandle := SetTimer(0, 1, 1, @TimerProc);
  end else
  begin
    KillTimer(0, TimeHandle);
    if not ThreadOnline then
    begin
      Senderthread:=TSenderThread.create(nil);
    end;
  end;
end;

procedure SetCh(Serial:TSerial; Channel:Integer; Value:Byte);stdcall;
var
  i:integer;
  buffer:array[0..7] of byte;
begin
  for i:=0 to length(DMXDevices)-1 do
  begin
    if (DMXDevices[i].Serial=Serial) and DMXDevices[i].Active and Assigned(DMXDevices[i].Handle) then
    begin
      usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, Value, Channel-1, buffer, sizeof(buffer), 5000);
    end;
    break;
  end;
end;

procedure SetUniverse(Serial:TSerial; DMXOutArray:PDMXArray);stdcall;
var
  i:integer;
begin
  for i:=0 to length(DMXDevices)-1 do
  begin
    if (DMXDevices[i].Serial=Serial) and DMXDevices[i].Active and Assigned(DMXDevices[i].Handle) then
    begin
      usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetChannelRange, 512, 0, DMXOutArray^, 512, 5000);
    end;
    break;
  end;
end;

procedure CloseLink(Serial:TSerial);stdcall;
var
  i:integer;
begin
  for i:=0 to length(DMXDevices)-1 do
  begin
    if DMXDevices[i].Serial=Serial then
    begin
      DMXDevices[i].Active:=false;
      if Assigned(DMXDevices[i].Handle) then
        usb_close(DMXDevices[i].Handle);
      DMXDevices[i].Serial:='0000000000000000';
    end;
  end;
end;

procedure CloseAllLinks;stdcall;
var
  i:integer;
begin
  KillTimer(0, TimeHandle);

  for i:=0 to length(DMXDevices)-1 do
  begin
    DMXDevices[i].Active:=false;
    if Assigned(DMXDevices[i].Handle) then
      usb_close(DMXDevices[i].Handle);
    DMXDevices[i].Serial:='0000000000000000';
  end;

  setlength(DMXDevices, 0);
  setlength(PointerToDMXArray, 0);
  setlength(Channelvalues, 0);
  setlength(ChannelvaluesChanged, 0);
end;

procedure SetInterfaceAdvTxConfig(Serial:TSerial; MaxDMXChans: integer; MaxChangedChans:integer; UsingTimer:boolean);stdcall;
var
  i:integer;
begin
  for i:=0 to length(DMXDevices)-1 do
  begin
    if DMXDevices[i].Serial=serial then
    begin
      DMXDevices[i].MaxChans:=MaxDMXChans;
      DMXDevices[i].MaxChangedChans:=MaxChangedChans;
    end;
  end;

  UseTimer:=UsingTimer;
  if UseTimer then
  begin
    ThreadOnline:=false;
    TimeHandle := SetTimer(0, 1, 1, @TimerProc);
  end else
  begin
    KillTimer(0, TimeHandle);
    if not ThreadOnline then
    begin
      Senderthread:=TSenderThread.create(nil);
    end;
  end;
end;

////////////////////////////////////////

constructor TSenderThread.Create(SenderEvent:TSenderEvent);
begin
  inherited create(false);
  FSenderEvent:=SenderEvent;
  Priority := tpHigher;
  FreeOnTerminate := true;
end;

procedure TSenderThread.Execute;
var
  i,j:integer;
  buffer:array[0..7] of byte;
begin
  inherited;
  ThreadOnline:=true;
  
  repeat
    if not UseTimer then
    begin
      // Veränderte Kanäle im Array überprüfen
      for i:=0 to length(PointerToDMXArray)-1 do
      begin
        for j:=0 to 511 do
        begin
          if PointerToDMXArray[i]^[j]<>Channelvalues[i][j] then
          begin
            Channelvalues[i][j]:=PointerToDMXArray[i]^[j];

            // ChannelvaluesChanged Array um einen Punkt erhöhen
            setlength(ChannelvaluesChanged[i], length(ChannelvaluesChanged[i])+1);
            ChannelvaluesChanged[i][length(ChannelvaluesChanged[i])-1]:=j+1;
            inc(ChangedChannels);
          end;
        end;
      end;

      if (ChangedChannels>0) then
      begin
        for i:=0 to length(DMXDevices)-1 do
        begin
          if DMXDevices[i].Active and Assigned(DMXDevices[i].Handle) then
          begin
            if ChangedChannels>DMXDevices[i].MaxChangedChans then
            begin
              // Gesamtes Universe senden, da zuviele Werte in dieser Zeit verändert
              usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetChannelRange, DMXDevices[i].MaxChans, 0, Channelvalues[i], DMXDevices[i].MaxChans, 5000);
            end else
            begin
              // Einzelne Kanäle senden, da nur wenige Kanäle geändert wurden
              for j:=length(ChannelvaluesChanged[i])-1 downto 0 do
              begin
                if (ChannelvaluesChanged[i][j]<=DMXDevices[i].MaxChans) then
                  usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, Channelvalues[i][ChannelvaluesChanged[i][j]-1], ChannelvaluesChanged[i][j]-1, buffer, sizeof(buffer), 5000);
              end;
            end;
          end;
          setlength(ChannelvaluesChanged[i],0);
        end;
        ChangedChannels:=0;
      end;
    end;
    sleep(1);
  until not ThreadOnline;

  Terminate;
end;

////////////////////////////////////////

exports
  GetAllConnectedInterfaces,
  GetAllOpenedInterfaces,
  SearchForInterfaces,
  GetConnectedInterface,
  GetOpenedInterface,
  SetInterfaceMode,
  OpenLink,
  CloseLink,
  CloseAllLinks,
  SetInterfaceAdvTxConfig,
  SetCh,
  SetUniverse;

begin
end.
