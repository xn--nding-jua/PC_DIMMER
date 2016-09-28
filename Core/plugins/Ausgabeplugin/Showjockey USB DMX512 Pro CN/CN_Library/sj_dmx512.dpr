library sj_dmx512;

uses
  SysUtils,
  Classes,
  LibUSB,
  WinTypes,
  Dialogs;

const
  USBDEV_SHARED_VENDOR=1155;//0x0483
  USBDEV_SHARED_PRODUCT=22526;//0x57FE
  reqIntLen=8;
  reqBulkLen=64;
  endpoint_Int_in=$81;
  endpoint_Int_out=$01;
  endpoint_Bulk_in=$82;
  endpoint_Bulk_out=$02;
  timeout=5000;

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
  TSerial = string[32];
  TSerialList = array[0..31] of TSerial;

  TDMXDevice = record
    Pointer:pusb_device;
    Handle:pusb_dev_handle;
    Name:string[64];
    Vendor:string[64];
    Serial:TSerial;
    Active:boolean;
    pipeIn:integer;
    maxPacketSizeIn:integer;
    pipeOut:integer;
    maxPacketSizeOut:integer;
  end;
  PDMXDevice = ^TDMXDevice;

var
  DMXDevices:array of TDMXDevice;
  PointerToDMXArray:array of PDMXArray;
  TimeHandle:UINT;
  SenderThread:TThread;
  ThreadOnline:boolean;
  UseTimer:boolean;

  ConnectedInterfaces:TSerialList;
  OpenedInterfaces:TSerialList;

function CharToSerialString(Chars: TSerial): string;
var
  i:integer;
  s:string;
begin
  for i:=0 to length(chars)-1 do
  begin
    s:=s+IntToHex(byte(chars[i]), 2);
  end;
  Result:=s;
end;

function BulkSync(Device:PDMXDevice; endpoint:integer; maxPacketSize: integer; var buffer:array of byte; size: integer):integer;
var
  buf:array of byte;
  nPacket:integer;
  nLeft:integer;
  transferred:integer;
  transferredAll:integer;
begin
  if size<=maxPacketSize then
  begin
//    usb_set_configuration(Device^.Handle, 1);
    usb_claim_interface(Device^.Handle, 0);

    Result:=usb_bulk_write(Device^.Handle, endpoint, buffer, size, 3000);
  end else
  begin
    setlength(buf, maxPacketSize);
    move(buffer[0], buf[0], maxPacketSize);
    nPacket:=maxPacketSize;
    nLeft:=size;
    transferredAll:=0;

    while(true) do
    begin
      if (nLeft<=0) then
        break;

      transferred:=usb_bulk_write(Device^.Handle, endpoint, buf, nPacket, 3000);

      nLeft:=nLeft-transferred;
      nPacket:=maxPacketSize;
      transferredAll:=transferredAll+transferred;
      move(buffer[transferredAll], buf[0], maxPacketSize);

    end;
    Result:=transferredAll;
  end;
end;

function sendShowJockeyDeviceBuffer(Device:PDMXDevice; var buffer:array of byte; size:integer):integer;
var
  retVal:integer;
  leftWriteSize:integer;
  alreadyWrittenSize:Word;
  writeSize:integer;
  maxPacketSizeOut:integer;
  writeBuffer:array of byte;
  bulkBuffer:array of byte;
  bulkDataSize:integer;
begin
  leftWriteSize:=size;
  alreadyWrittenSize:=0;
  maxPacketSizeOut:=Device.maxPacketSizeOut;
  setlength(writeBuffer, size);
  move(buffer[0], writeBuffer[0], size);
  setlength(bulkBuffer, Device.maxPacketSizeOut);
  bulkDataSize:=maxPacketSizeOut-2;

  while(leftWriteSize>0) do
  begin
    //move(alreadyWrittenSize, bulkBuffer[0], 2);
    bulkBuffer[0]:=alreadyWrittenSize;
    bulkBuffer[1]:=alreadyWrittenSize shr 8;

    if (leftWriteSize>bulkDataSize) then
      writeSize:=bulkDataSize
    else
      writeSize:=leftWriteSize;

    move(writeBuffer[alreadyWrittenSize], bulkBuffer[2], writeSize);
    retVal:=bulkSync(Device, Device^.pipeOut, Device^.maxPacketSizeOut, bulkBuffer, writeSize+2);

    if (retVal<0) then
    begin
      Result:=retVal;
      exit;
    end;
    leftWriteSize:=leftWriteSize-writeSize;
    alreadyWrittenSize:=alreadyWrittenSize+writeSize;
  end;
  Result:=alreadyWrittenSize;
end;

function getShowJockeyDeviceMode(Device:PDMXDevice):integer;
var
  cmd:array[0..2] of byte;
  answer:integer;
begin
  cmd[0]:=255;
  cmd[1]:=255;
  cmd[2]:=0;

  answer:=bulkSync(Device, Device^.pipeOut, Device^.maxPacketSizeOut, cmd, 3);
  showmessage('1:'+inttostr(answer));
  showmessage(usb_strerror);
  if (answer>0) then
  begin
    sleep(10);
    answer:=bulkSync(Device, Device^.pipeIn, Device^.maxPacketSizeIn, cmd, 3);
    showmessage('2:'+inttostr(answer));
    showmessage(usb_strerror);
    if (answer>0) then
    begin
      Showmessage(inttostr(cmd[0])+' '+inttostr(cmd[1])+' '+inttostr(cmd[2]));
      result:=cmd[2];
    end else
    begin
      result:=0;
    end;
  end else
  begin
    result:=0;
  end;
end;

function getShowJockeyDeviceBuffer(Device:PDMXDevice; var buffer:array of byte; size:integer):integer;
var
  cmd:array[0..2] of byte;
  readBuf:array of byte;
begin
  cmd[0]:=255;
  cmd[1]:=255;
  cmd[2]:=1;

  if (bulkSync(Device, Device^.pipeOut, Device^.maxPacketSizeOut, cmd[0], 3)=0) then
  begin
    Result:=-1;
    exit;
  end;

  sleep(10);
  setlength(readBuf, size);
  if (bulkSync(Device, Device^.pipeIn, Device^.maxPacketSizeIn, readBuf[0], size)=0) then
  begin
    Result:=-1;
    exit;
  end;
  move(readBuf[0], buffer[0], size);
  Result:=size;
end;

procedure TimerProc(hwnd:HWND; msg:UINT; idEvent:UINT; dwTimer:DWORD);stdcall;
var
  i:integer;
begin
  if UseTimer then
  begin
    for i:=0 to length(DMXDevices)-1 do
    begin
      if (DMXDevices[i].Active and Assigned(DMXDevices[i].Handle)) then
      begin
        //usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, Value, Channel-1, buffer, sizeof(buffer), 5000);
        sendShowJockeyDeviceBuffer(@DMXDevices[i], PointerToDMXArray[i]^, 512);
      end;
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
  s:string;
  justinhere:boolean;
begin
  // Diese Funktion listet lediglich alle angeschlossenen Interfaces auf

  for i:=0 to 31 do
    ConnectedInterfaces[i]:='00000000000000000000000000000000';

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
          (vendor='Showjockey Co.,Ltd') and (description='Showjockey Co.,Ltd.USB TO DMX512 Pro  ') then
        begin
          justinhere:=false;

          pcd_serial:=copy(serial, 1, 32);
          s:=CharToSerialString(pcd_serial);
          pcd_serial:=s;

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
    OpenedInterfaces[i]:='00000000000000000000000000000000';

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
  j,k,l:integer;
  s:string;
  description, vendor, serial_dev: array [0..255] of char;
  pcd_serial:TSerial;
begin
  if Serial='00000000000000000000000000000000' then exit;

  UseTimer:=true;

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
          (vendor='Showjockey Co.,Ltd') and (description='Showjockey Co.,Ltd.USB TO DMX512 Pro  ') then
        begin
          // Gerät ist ein Showjockey DMX512 Pro Interface

          pcd_serial:=copy(serial_dev, 1, 32);
          s:=CharToSerialString(pcd_serial);
          pcd_serial:=s;

          if (pcd_serial=serial) then
          begin
            Position:=-1;

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
                if DMXDevices[i].Serial='00000000000000000000000000000000' then
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
                Position:=length(DMXDevices)-1;
              end;

              DMXDevices[Position].Pointer:=dev;
              DMXDevices[Position].Handle:=udev;

              DMXDevices[Position].Name:=String(description);
              DMXDevices[Position].Vendor:=String(vendor);

              if pcd_serial='' then
                DMXDevices[Position].Serial:='n/a'
              else
                DMXDevices[Position].Serial:=pcd_serial;

              PointerToDMXArray[Position]:=DMXOutArray;
              DMXDevices[Position].Active:=true;

              for j:=0 to dev^.config[0].bNumInterfaces-1 do
              begin
                for k:=0 to dev^.config[0].iinterface[j].num_altsetting-1 do
                begin
                  for l:=0 to dev^.config[0].iinterface[j].altsetting[k].bNumEndpoints-1 do
                  begin
                    if dev^.config[0].iinterface[j].altsetting[k].endpoint[l].bmAttributes=USB_ENDPOINT_TYPE_BULK then
                    begin
                      if ((dev^.config[0].iinterface[j].altsetting[k].endpoint[l].bEndpointAddress and USB_ENDPOINT_DIR_MASK)=USB_ENDPOINT_IN) then
                      begin
                        // input
                        DMXDevices[Position].pipeIn:=dev^.config[0].iinterface[j].altsetting[k].endpoint[l].bEndpointAddress;
                        DMXDevices[Position].maxPacketSizeIn:=dev^.config[0].iinterface[j].altsetting[k].endpoint[l].wMaxPacketSize;
                        continue;
                      end else
                      begin
                        // output
                        DMXDevices[Position].pipeOut:=dev^.config[0].iinterface[j].altsetting[k].endpoint[l].bEndpointAddress;
                        DMXDevices[Position].maxPacketSizeOut:=dev^.config[0].iinterface[j].altsetting[k].endpoint[l].wMaxPacketSize;
                        continue;
                      end;
                    end;
                  end;
                end;
              end;
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
begin
  for i:=0 to length(DMXDevices)-1 do
  begin
    if (DMXDevices[i].Serial=Serial) and DMXDevices[i].Active and Assigned(DMXDevices[i].Handle) then
    begin
      //usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, Value, Channel-1, buffer, sizeof(buffer), 5000);
      sendShowJockeyDeviceBuffer(@DMXDevices[i], PointerToDMXArray[i]^, 512);
    end;
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
      //usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetChannelRange, 512, 0, DMXOutArray^, 512, 5000);
      sendShowJockeyDeviceBuffer(@DMXDevices[i], DMXOutArray^, 512);
    end;
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
      DMXDevices[i].Serial:='00000000000000000000000000000000';
    end;
  end;
end;

procedure CloseAllLinks;stdcall;
var
  i:integer;
begin
  if UseTimer then
  begin
    KillTimer(0, TimeHandle);
  end else
  begin
    ThreadOnline:=false;
  end;

  for i:=0 to length(DMXDevices)-1 do
  begin
    DMXDevices[i].Active:=false;
    if Assigned(DMXDevices[i].Handle) then
      usb_close(DMXDevices[i].Handle);
    DMXDevices[i].Serial:='00000000000000000000000000000000';
  end;
end;

procedure SetInterfaceAdvTxConfig(Serial:TSerial; MaxDMXChans: integer; MaxChangedChans:integer; UsingTimer:boolean);stdcall;
begin
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
  i:integer;
begin
  inherited;
  ThreadOnline:=true;

  repeat
    if not UseTimer then
    begin
      for i:=0 to length(DMXDevices)-1 do
      begin
        if (DMXDevices[i].Active and Assigned(DMXDevices[i].Handle)) then
        begin
          //usb_control_msg(DMXDevices[i].Handle, USB_TYPE_VENDOR OR USB_RECIP_DEVICE OR USB_ENDPOINT_OUT, cmd_SetSingleChannel, Value, Channel-1, buffer, sizeof(buffer), 5000);
          sendShowJockeyDeviceBuffer(@DMXDevices[i], PointerToDMXArray[i]^, 512);
        end;
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
