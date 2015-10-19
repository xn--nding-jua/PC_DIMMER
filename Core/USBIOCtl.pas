{++

Copyright (c) 1998-99      Microsoft Corporation

Module Name:

        USBIOCTL.H

Abstract:

   structures common to the USBD and USB device drivers.

Environment:

    Kernel & user mode

Revision History:

    09-29-95 : created
    01-06-97 : added user mode hub ioctls

--}

unit usbioctl;

{$WEAKPACKAGEUNIT ON}

interface

uses
  JwaWinType, usb100;

const
  GUID_CLASS_USBHUB: TGUID             = '{f18a0e88-c30c-11d0-8815-00a0c906bed8}';
  GUID_CLASS_USB_DEVICE: TGUID         = '{A5DCBF10-6530-11D2-901F-00C04FB951ED}';
  GUID_USB_WMI_STD_DATA: TGUID         = '{4E623B20-CB14-11D1-B331-00A0C959BBD2}';
  GUID_USB_WMI_STD_NOTIFICATION: TGUID = '{4E623B20-CB14-11D1-B331-00A0C959BBD2}';

{
   USB IOCTLS
}

  USB_IOCTL_INTERNAL_INDEX = $0000;
  USB_IOCTL_INDEX          = $00ff;

{
   USB Internal IOCtls
}

{   IOCTL_INTERNAL_USB_SUBMIT_URB

    This IOCTL is used by client drivers to submit URB (USB Request Blocks)

    Parameters.Others.Argument1 = pointer to URB
}

  IOCTL_INTERNAL_USB_SUBMIT_URB = ($22 shl 16) or (USB_IOCTL_INTERNAL_INDEX shl 2) or ($03) or ($00 shl 14);

{   IOCTL_INTERNAL_USB_RESET_PORT
}

  IOCTL_INTERNAL_USB_RESET_PORT = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+1) shl 2) or ($03) or ($00 shl 14);


{   IOCTL_INTERNAL_USB_GET_ROOTHUB_PDO

    This IOCTL is used internally by the hub driver

    Parameters.Others.Argument1 = pointer to be filled in with RootHubPdo;
    Parameters.Others.Argument2 = pointer to be filled in with HcdDeviceObject;
}

  IOCTL_INTERNAL_USB_GET_ROOTHUB_PDO = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+3) shl 2) or ($03) or ($00 shl 14);


{   IOCTL_INTERNAL_USB_GET_PORT_STATUS

    This IOCTL returns the current port status

    Parameters.Others.Argument1 = pointer to port status register (ULONG)

    status bits are:

    USBD_PORT_ENABLED
}

  USBD_PORT_ENABLED   = $00000001;
  USBD_PORT_CONNECTED = $00000002;


  IOCTL_INTERNAL_USB_GET_PORT_STATUS = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+4) shl 2) or ($03) or ($00 shl 14);

{   IOCTL_INTERNAL_USB_ENABLE_PORT

    This IOCTL will request the hub to re-enable a disabled port
}

  IOCTL_INTERNAL_USB_ENABLE_PORT = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+5) shl 2) or ($03) or ($00 shl 14);

{   IOCTL_INTERNAL_USB_GET_HUB_COUNT

    This IOCTL is used internally by the hub driver

    Parameters.Others.Argument1 = pointer to be count of hubs in chain;
}

  IOCTL_INTERNAL_USB_GET_HUB_COUNT = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+6) shl 2) or ($03) or ($00 shl 14);

{   IOCTL_INTERNAL_USB_CYCLE_PORT

    This will simulate a plug/unplug on the port
}

  IOCTL_INTERNAL_USB_CYCLE_PORT          = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+7)  shl 2) or ($03) or ($00 shl 14);
  IOCTL_INTERNAL_USB_GET_HUB_NAME        = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+8)  shl 2) or ($00) or ($00 shl 14);
  IOCTL_INTERNAL_USB_GET_BUS_INFO        = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+9)  shl 2) or ($00) or ($00 shl 14);
  IOCTL_INTERNAL_USB_GET_CONTROLLER_NAME = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+10) shl 2) or ($00) or ($00 shl 14);
  IOCTL_INTERNAL_USB_GET_BUSGUID_INFO    = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+11) shl 2) or ($00) or ($00 shl 14);
  IOCTL_INTERNAL_USB_GET_PARENT_HUB_INFO = ($22 shl 16) or ((USB_IOCTL_INTERNAL_INDEX+12) shl 2) or ($00) or ($00 shl 14);

{
   USB Public IOCtls
}

{************************************************************
The following IOCTLS are always sent to the HCD symbolic name
*************************************************************}


{
   this ioctl is for adding debug hooks to HCDs
}

  IOCTL_USB_HCD_GET_STATS_1 = ($22 shl 16) or (USB_IOCTL_INDEX      shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_HCD_GET_STATS_2 = ($22 shl 16) or ((USB_IOCTL_INDEX+11) shl 2) or ($00) or ($00 shl 14);

{
   These ioctls are used for USB diagnostic and test applications
}

  IOCTL_USB_DIAGNOSTIC_MODE_ON  = ($22 shl 16) or ((USB_IOCTL_INDEX+1)  shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_DIAGNOSTIC_MODE_OFF = ($22 shl 16) or ((USB_IOCTL_INDEX+2)  shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_GET_ROOT_HUB_NAME   = ($22 shl 16) or ((USB_IOCTL_INDEX+3)  shl 2) or ($00) or ($00 shl 14);
  IOCTL_GET_HCD_DRIVERKEY_NAME  = ($22 shl 16) or ((USB_IOCTL_INDEX+10) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_HCD_DISABLE_PORT    = ($22 shl 16) or ((USB_IOCTL_INDEX+13) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_HCD_ENABLE_PORT     = ($22 shl 16) or ((USB_IOCTL_INDEX+14) shl 2) or ($00) or ($00 shl 14);

{*********************************************************
The following IOCTLS are always sent to symbolic names
created by usbhub
**********************************************************}

{
    Utility IOCTLS supported by the hub device
}

{
   These ioctls are supported by the hub driver for
   use by user mode USB utilities.
}


  IOCTL_USB_GET_NODE_INFORMATION                = ($22 shl 16) or ((USB_IOCTL_INDEX+3) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_GET_NODE_CONNECTION_INFORMATION     = ($22 shl 16) or ((USB_IOCTL_INDEX+4) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_GET_DESCRIPTOR_FROM_NODE_CONNECTION = ($22 shl 16) or ((USB_IOCTL_INDEX+5) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_GET_NODE_CONNECTION_NAME            = ($22 shl 16) or ((USB_IOCTL_INDEX+6) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_DIAG_IGNORE_HUBS_ON                 = ($22 shl 16) or ((USB_IOCTL_INDEX+7) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_DIAG_IGNORE_HUBS_OFF                = ($22 shl 16) or ((USB_IOCTL_INDEX+8) shl 2) or ($00) or ($00 shl 14);
  IOCTL_USB_GET_NODE_CONNECTION_DRIVERKEY_NAME  = ($22 shl 16) or ((USB_IOCTL_INDEX+9) shl 2) or ($00) or ($00 shl 14);

{
   structures for user mode ioctls
}

const
  UsbHub      = 0;
  UsbMIParent = 1;
type               
  USB_HUB_NODE = DWORD;
  TUsbHubNode  = USB_HUB_NODE;

type
  PUSB_HUB_INFORMATION = ^USB_HUB_INFORMATION;
  USB_HUB_INFORMATION = packed record
    {
       copy of data from hub descriptor
    }
    HubDescriptor: TUsbHubDescriptor;
    HubIsBusPowered: ByteBool;
  end;
  TUsbHubInformation = USB_HUB_INFORMATION;
  PUsbHubInformation = PUSB_HUB_INFORMATION;

  PUSB_MI_PARENT_INFORMATION = ^USB_MI_PARENT_INFORMATION;
  USB_MI_PARENT_INFORMATION = packed record
    NumberOfInterfaces: ULONG;
  end;
  TUsbMiParentInformation = USB_MI_PARENT_INFORMATION;
  PUsbMiParentInformation = PUSB_MI_PARENT_INFORMATION;

  PUSB_NODE_INFORMATION = ^USB_NODE_INFORMATION;
  USB_NODE_INFORMATION = packed record
    NodeType: TUsbHubNode;        // hub, mi parent
  case Boolean of
    False: (HubInformation: TUsbHubInformation;);
    True:  (MiParentInformation: TUsbMiParentInformation);
  end;
  TUsbNodeInformation = USB_NODE_INFORMATION;
  PUsbNodeInformation = PUSB_NODE_INFORMATION;

  PUSB_PIPE_INFO = ^USB_PIPE_INFO;
  USB_PIPE_INFO = packed record
    EndpointDescriptor: TUsbEndpointDescriptor;
    ScheduleOffset: ULONG;
  end;
  TUsbPipeInfo = USB_PIPE_INFO;
  PUsbPipeInfo = PUSB_PIPE_INFO;

const
  NoDeviceConnected        = 0;
  DeviceConnected          = 1;
  // failure codes, these map to fail reasons
  DeviceFailedEnumeration  = 2;
  DeviceGeneralFailure     = 3;
  DeviceCausedOvercurrent  = 4;
  DeviceNotEnoughPower     = 5;
  DeviceNotEnoughBandwidth = 6;
type
  USB_CONNECTION_STATUS = DWORD;
  PUSB_CONNECTION_STATUS = ^USB_CONNECTION_STATUS;
  TUsbConnectionStatus = USB_CONNECTION_STATUS;
  PUsbConnectionStatus = PUSB_CONNECTION_STATUS;

type
  PUSB_NODE_CONNECTION_INFORMATION = ^USB_NODE_CONNECTION_INFORMATION;
  USB_NODE_CONNECTION_INFORMATION = packed record
    ConnectionIndex: ULONG;
    // usb device descriptor returned by this device during enumeration
    DeviceDescriptor: TUsbDeviceDescriptor;
    CurrentConfigurationValue: UCHAR;
    LowSpeed: ByteBool;

    DeviceIsHub: ByteBool;

    DeviceAddress: USHORT;

    NumberOfOpenPipes: ULONG;

    ConnectionStatus: TUsbConnectionStatus;
    PipeList: array [0..0] of TUsbPipeInfo;
  end;
  TUsbNodeConnectionInformation = USB_NODE_CONNECTION_INFORMATION;
  PUsbNodeConnectionInformation = PUSB_NODE_CONNECTION_INFORMATION;

  PUSB_NODE_CONNECTION_DRIVERKEY_NAME = ^USB_NODE_CONNECTION_DRIVERKEY_NAME;
  USB_NODE_CONNECTION_DRIVERKEY_NAME = packed record
    ConnectionIndex: ULONG;  // INPUT
    ActualLength: ULONG;     // OUTPUT
    // unicode name for the devnode.
    DriverKeyName: array [0..0] of WideChar;  // OUTPUT
  end;
  TUsbNodeConnectionDriverKeyName = USB_NODE_CONNECTION_DRIVERKEY_NAME;
  PUsbNodeConnectionDriverKeyName = PUSB_NODE_CONNECTION_DRIVERKEY_NAME;

  PUSB_NODE_CONNECTION_NAME = ^USB_NODE_CONNECTION_NAME;
  USB_NODE_CONNECTION_NAME = packed record
    ConnectionIndex: ULONG;  // INPUT
    ActualLength: ULONG;     // OUTPUT
    // unicode symbolic name for this node if it is a hub or parent driver
    // null if this node is a device.
    NodeName: array [0..0] of WideChar;  // OUTPUT
  end;
  TUsbNodeConnectionName = USB_NODE_CONNECTION_NAME;
  PUsbNodeConnectionName = PUSB_NODE_CONNECTION_NAME;

  PUSB_HUB_NAME = ^USB_HUB_NAME;
  USB_HUB_NAME = packed record
    ActualLength: ULONG;     // OUTPUT
    // NULL terminated unicode symbolic name for the root hub
    HubName: array [0..0] of WideChar;  // OUTPUT
  end;
  TUsbHubName = USB_HUB_NAME;
  PUsbHubName = PUSB_HUB_NAME;

  PUSB_ROOT_HUB_NAME = ^USB_ROOT_HUB_NAME;
  USB_ROOT_HUB_NAME = packed record
    ActualLength: ULONG;     // OUTPUT
    // NULL terminated unicode symbolic name for the root hub
    RootHubName: array [0..0] of WideChar;  // OUTPUT
  end;
  TUsbRootHubName = USB_ROOT_HUB_NAME;
  PUsbRootHubName = PUSB_ROOT_HUB_NAME;

  PUSB_HCD_DRIVERKEY_NAME = ^USB_HCD_DRIVERKEY_NAME;
  USB_HCD_DRIVERKEY_NAME = packed record
    ActualLength: ULONG;     // OUTPUT
    // NULL terminated unicode driverkeyname for hcd
    DriverKeyName: array [0..0] of WideChar;  // OUTPUT
  end;
  TUsbHCDDriverKeyName = USB_HCD_DRIVERKEY_NAME;
  PUsbHCDDriverKeyName = PUSB_HCD_DRIVERKEY_NAME;

  PUSB_DESCRIPTOR_REQUEST = ^USB_DESCRIPTOR_REQUEST;
  USB_DESCRIPTOR_REQUEST = packed record
    ConnectionIndex: ULONG;
    SetupPacket: packed record
      bmRequest: UCHAR;
      bRequest: UCHAR;
      wValue: USHORT;
      wIndex: USHORT;
      wLength: USHORT;
    end;
    Data: array [0..0] of UCHAR;
  end;
  TUsbDescriptorRequest = USB_DESCRIPTOR_REQUEST;
  PUsbDescriptorRequest = PUSB_DESCRIPTOR_REQUEST;

{
   Structure for returning HCD debug and statistic information to
   a user mode application.
}

  PHCD_STAT_COUNTERS = ^HCD_STAT_COUNTERS;
  HCD_STAT_COUNTERS = packed record
    BytesTransferred: ULONG;

    IsoMissedCount: USHORT;
    DataOverrunErrorCount: USHORT;

    CrcErrorCount: USHORT;
    ScheduleOverrunCount: USHORT;

    TimeoutErrorCount: USHORT;
    InternalHcErrorCount: USHORT;

    BufferOverrunErrorCount: USHORT;
    SWErrorCount: USHORT;

    StallPidCount: USHORT;
    PortDisableCount: USHORT;
  end;
  THCDStatCounters = HCD_STAT_COUNTERS;
  PHCDStatCounters = PHCD_STAT_COUNTERS;

  PHCD_ISO_STAT_COUNTERS = ^HCD_ISO_STAT_COUNTERS;
  HCD_ISO_STAT_COUNTERS = packed record
    LateUrbs: USHORT;
    DoubleBufferedPackets: USHORT;

    TransfersCF_5ms: USHORT;
    TransfersCF_2ms: USHORT;

    TransfersCF_1ms: USHORT;
    MaxInterruptLatency: USHORT;

    BadStartFrame: USHORT;
    StaleUrbs: USHORT;

    IsoPacketNotAccesed: USHORT;
    IsoPacketHWError: USHORT;

    SmallestUrbPacketCount: USHORT;
    LargestUrbPacketCount: USHORT;

    IsoCRC_Error: USHORT;
    IsoOVERRUN_Error: USHORT;
    IsoINTERNAL_Error: USHORT;
    IsoUNKNOWN_Error: USHORT;

    IsoBytesTransferred: ULONG;

    LateMissedCount: USHORT;
    HWIsoMissedCount: USHORT;

    Reserved7: array [0..7] of ULONG;
  end;
  THCDIsoStatCounters = HCD_ISO_STAT_COUNTERS;
  PHCDIsoStatCounters = PHCD_ISO_STAT_COUNTERS;

  PHCD_STAT_INFORMATION_1 = ^HCD_STAT_INFORMATION_1;
  HCD_STAT_INFORMATION_1 = packed record
    Reserved1: ULONG;
    Reserved2: ULONG;
    ResetCounters: ULONG;
    TimeRead: Int64;
    // stat registers
    Counters: THCDStatCounters;
  end;
  THCDStatInformation1 = HCD_STAT_INFORMATION_1;
  PHCDStatInformation1 = PHCD_STAT_INFORMATION_1;

  PHCD_STAT_INFORMATION_2 = ^HCD_STAT_INFORMATION_2;
  HCD_STAT_INFORMATION_2 = packed record
    Reserved1: ULONG;
    Reserved2: ULONG;
    ResetCounters: ULONG;
    TimeRead: Int64;

    LockedMemoryUsed: Integer;
    // stat registers
    Counters: THCDStatCounters;
    IsoCounters: THCDIsoStatCounters;
  end;
  THCDStatInformation2 = HCD_STAT_INFORMATION_2;
  PHCDStatInformation2 = PHCD_STAT_INFORMATION_2;

{
   WMI related structures
}

// these index in to our array of guids
const
  WMI_USB_DRIVER_INFORMATION  = 0;
  WMI_USB_DRIVER_NOTIFICATION = 1;

const
    //  the following return a USB_CONNECTION_NOTIFICATION structure:
    EnumerationFailure    = 0;
    InsufficentBandwidth  = 1;
    InsufficentPower      = 2;
    OverCurrent           = 3;
    ResetOvercurrent      = 4;

    // the following return a USB_BUS_NOTIFICATION structure:
    AcquireBusInfo        = 5;

    // the following return a USB_ACQUIRE_INFO structure:
    AcquireHubName        = 6;
    AcquireControllerName = 7;

    // the following return a USB_HUB_NOTIFICATION structure:
    HubOvercurrent        = 8;
    HubPowerChange        = 9;
type
  USB_NOTIFICATION_TYPE = DWORD;
  TUsbNotificationType = USB_NOTIFICATION_TYPE;

type
  PUSB_NOTIFICATION = ^USB_NOTIFICATION;
  USB_NOTIFICATION = packed record
    // indicates type of notification
    NotificationType: TUsbNotificationType;
  end;
  TUsbNotification = USB_NOTIFICATION;
  PUsbNotification = PUSB_NOTIFICATION;

// this structure is used for connection notification codes
 
  PUSB_CONNECTION_NOTIFICATION = ^USB_CONNECTION_NOTIFICATION;
  USB_CONNECTION_NOTIFICATION = packed record
    // indicates type of notification
    NotificationType: TUsbNotification;

    {  valid for all connection notifictaion codes,
       0 indicates global condition for hub or parent
       this value will be a port number for devices
       attached to a hub, otherwise a one based
       index if the device is a child of a composite
       parent }
    ConnectionNumber: ULONG;

    {  valid for InsufficentBandwidth,
       the amount of bandwidth the device
       tried to allocate and was denied. }
    RequestedBandwidth: ULONG;

    {  valid for EnumerationFailure,
       gives some indication why the device failed
       to enumerate }
    EnumerationFailReason: ULONG;

    {  valid for InsufficentPower,
       the amount of power requested to configure
       this device. }
    PowerRequested: ULONG;

    {  length of the UNICODE symbolic name (in bytes) for the HUB
       that this device is attached to.
       not including NULL }
    HubNameLength: ULONG;
  end;
  TUsbConnectionNotification = USB_CONNECTION_NOTIFICATION;
  PUsbConnectionNotification = PUSB_CONNECTION_NOTIFICATION;

// This structure is used for the bus notification code 'AcquireBusInfo'

  PUSB_BUS_NOTIFICATION = ^USB_BUS_NOTIFICATION;
  USB_BUS_NOTIFICATION = packed record
    // indicates type of notification
    NotificationType: TUsbNotificationType;  // indicates type of notification
    TotalBandwidth: ULONG;
    ConsumedBandwidth: ULONG;

    { length of the UNICODE symbolic name (in bytes) for the controller
       that this device is attached to.
       not including NULL }
    ControllerNameLength: ULONG;
  end;
  TUsbBusNotification = USB_BUS_NOTIFICATION;
  PUsbBusNotification = PUSB_BUS_NOTIFICATION;

// used to acquire user mode filenames to open respective objects

  PUSB_ACQUIRE_INFO = ^USB_ACQUIRE_INFO;
  USB_ACQUIRE_INFO = packed record
    // indicates type of notification
    NotificationType: TUsbNotificationType;
    // TotalSize of this struct
    TotalSize: ULONG;

    Buffer: array [0..0] of WideChar;
  end;
  TUsbAquireInfo = USB_ACQUIRE_INFO;
  PUsbAquireInfo = PUSB_ACQUIRE_INFO;

implementation

end.
