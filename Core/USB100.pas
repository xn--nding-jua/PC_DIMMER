unit usb100;

{$WEAKPACKAGEUNIT ON}

interface

uses
  JwaWinType;

const
  MAXIMUM_USB_STRING_LENGTH = 255;

  // values for the bits returned by the USB GET_STATUS command
  USB_GETSTATUS_SELF_POWERED          = $01;
  USB_GETSTATUS_REMOTE_WAKEUP_ENABLED = $02;

  USB_DEVICE_DESCRIPTOR_TYPE          = $01;
  USB_CONFIGURATION_DESCRIPTOR_TYPE   = $02;
  USB_STRING_DESCRIPTOR_TYPE          = $03;
  USB_INTERFACE_DESCRIPTOR_TYPE       = $04;
  USB_ENDPOINT_DESCRIPTOR_TYPE        = $05;

  // descriptor types defined by DWG documents
  USB_RESERVED_DESCRIPTOR_TYPE        = $06;
  USB_CONFIG_POWER_DESCRIPTOR_TYPE    = $07;
  USB_INTERFACE_POWER_DESCRIPTOR_TYPE = $08;

  //
  // Values for bmAttributes field of an
  // endpoint descriptor
  //
  USB_ENDPOINT_TYPE_MASK              = $03;

  USB_ENDPOINT_TYPE_CONTROL           = $00;
  USB_ENDPOINT_TYPE_ISOCHRONOUS       = $01;
  USB_ENDPOINT_TYPE_BULK              = $02;
  USB_ENDPOINT_TYPE_INTERRUPT         = $03;

  //
  // definitions for bits in the bmAttributes field of a
  // configuration descriptor.
  //
  USB_CONFIG_POWERED_MASK             = $c0;

  USB_CONFIG_BUS_POWERED              = $80;
  USB_CONFIG_SELF_POWERED             = $40;
  USB_CONFIG_REMOTE_WAKEUP            = $20;

  //
  // Endpoint direction bit, stored in address
  //
  USB_ENDPOINT_DIRECTION_MASK         = $80;

  //
  // USB defined request codes
  // see chapter 9 of the USB 1.0 specifcation for
  // more information.
  //

  // These are the correct values based on the USB 1.0
  // specification

  USB_REQUEST_GET_STATUS              = $00;
  USB_REQUEST_CLEAR_FEATURE           = $01;

  USB_REQUEST_SET_FEATURE             = $03;

  USB_REQUEST_SET_ADDRESS             = $05;
  USB_REQUEST_GET_DESCRIPTOR          = $06;
  USB_REQUEST_SET_DESCRIPTOR          = $07;
  USB_REQUEST_GET_CONFIGURATION       = $08;
  USB_REQUEST_SET_CONFIGURATION       = $09;
  USB_REQUEST_GET_INTERFACE           = $0A;
  USB_REQUEST_SET_INTERFACE           = $0B;
  USB_REQUEST_SYNC_FRAME              = $0C;

  //
  // defined USB device classes
  //

  USB_DEVICE_CLASS_RESERVED           = $00;
  USB_DEVICE_CLASS_AUDIO              = $01;
  USB_DEVICE_CLASS_COMMUNICATIONS     = $02;
  USB_DEVICE_CLASS_HUMAN_INTERFACE    = $03;
  USB_DEVICE_CLASS_MONITOR            = $04;
  USB_DEVICE_CLASS_PHYSICAL_INTERFACE = $05;
  USB_DEVICE_CLASS_POWER              = $06;
  USB_DEVICE_CLASS_PRINTER            = $07;
  USB_DEVICE_CLASS_STORAGE            = $08;
  USB_DEVICE_CLASS_HUB                = $09;
  USB_DEVICE_CLASS_VENDOR_SPECIFIC    = $FF;

  //
  // USB Core defined Feature selectors
  //

  USB_FEATURE_ENDPOINT_STALL         = $0000;
  USB_FEATURE_REMOTE_WAKEUP          = $0001;

  //
  // USB DWG defined Feature selectors
  //

  USB_FEATURE_INTERFACE_POWER_D0     = $0002;
  USB_FEATURE_INTERFACE_POWER_D1     = $0003;
  USB_FEATURE_INTERFACE_POWER_D2     = $0004;
  USB_FEATURE_INTERFACE_POWER_D3     = $0005;

type
  PUSB_DEVICE_DESCRIPTOR = ^USB_DEVICE_DESCRIPTOR;
  USB_DEVICE_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bcdUSB: USHORT;
    bDeviceClass: UCHAR;
    bDeviceSubClass: UCHAR;
    bDeviceProtocol: UCHAR;
    bMaxPacketSize0: UCHAR;
    idVendor: USHORT;
    idProduct: USHORT;
    bcdDevice: USHORT;
    iManufacturer: UCHAR;
    iProduct: UCHAR;
    iSerialNumber: UCHAR;
    bNumConfigurations: UCHAR;
  end;
  TUsbDeviceDescriptor = USB_DEVICE_DESCRIPTOR;
  PUsbDeviceDescriptor = PUSB_DEVICE_DESCRIPTOR;

  PUSB_ENDPOINT_DESCRIPTOR = ^USB_ENDPOINT_DESCRIPTOR;
  USB_ENDPOINT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bEndpointAddress: UCHAR;
    bmAttributes: UCHAR;
    wMaxPacketSize: USHORT;
    bInterval: UCHAR;
  end;
  TUsbEndpointDescriptor = USB_ENDPOINT_DESCRIPTOR;
  PUsbEndpointDescriptor = PUSB_ENDPOINT_DESCRIPTOR;

  PUSB_CONFIGURATION_DESCRIPTOR = ^USB_CONFIGURATION_DESCRIPTOR;
  USB_CONFIGURATION_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    wTotalLength: USHORT;
    bNumInterfaces: UCHAR;
    bConfigurationValue: UCHAR;
    iConfiguration: UCHAR;
    bmAttributes: UCHAR;
    MaxPower: UCHAR;
  end;
  TUsbConfigurationDescriptor = USB_CONFIGURATION_DESCRIPTOR;
  PUsbConfigurationDescriptor = PUSB_CONFIGURATION_DESCRIPTOR;

  PUSB_INTERFACE_DESCRIPTOR = ^USB_INTERFACE_DESCRIPTOR;
  USB_INTERFACE_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bInterfaceNumber: UCHAR;
    bAlternateSetting: UCHAR;
    bNumEndpoints: UCHAR;
    bInterfaceClass: UCHAR;
    bInterfaceSubClass: UCHAR;
    bInterfaceProtocol: UCHAR;
    iInterface: UCHAR;
  end;
  TUsbInterfaceDescriptor = USB_INTERFACE_DESCRIPTOR;
  PUsbInterfaceDescriptor = PUSB_INTERFACE_DESCRIPTOR;

  PUSB_STRING_DESCRIPTOR = ^USB_STRING_DESCRIPTOR;
  USB_STRING_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bString: array [0..0] of WCHAR;
  end;
  TUsbStringDescriptor = USB_STRING_DESCRIPTOR;
  PUsbStringDescriptor = PUSB_STRING_DESCRIPTOR;

  PUSB_COMMON_DESCRIPTOR = ^USB_COMMON_DESCRIPTOR;
  USB_COMMON_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
  end;
  TUsbCommonDescriptor = USB_COMMON_DESCRIPTOR;
  PUsbCommonDescriptor = PUSB_COMMON_DESCRIPTOR;

  //
  // Standard USB HUB definitions 
  //
  // See Chapter 11 USB core specification
  //

  PUSB_HUB_DESCRIPTOR = ^USB_HUB_DESCRIPTOR;
  USB_HUB_DESCRIPTOR = packed record
    bDescriptorLength: UCHAR;       // Length of this descriptor
    bDescriptorType: UCHAR;         // Hub configuration type
    bNumberOfPorts: UCHAR;          // number of ports on this hub
    wHubCharacteristics: USHORT;    // Hub Charateristics
    bPowerOnToPowerGood: UCHAR;     // port power on till power good in 2ms
    bHubControlCurrent: UCHAR;      // max current in mA
    //
    // room for 255 ports power control and removable bitmask
    bRemoveAndPowerMask: array [0..63] of UCHAR;
  end;
  TUsbHubDescriptor = USB_HUB_DESCRIPTOR;
  PUsbHubDescriptor = PUSB_HUB_DESCRIPTOR;

//
// Structures defined by various DWG feature documents
//

//
// See DWG USB Feature Specification: Interface Power Management
//
const
  USB_SUPPORT_D0_COMMAND = $01;
  USB_SUPPORT_D1_COMMAND = $02;
  USB_SUPPORT_D2_COMMAND = $04;
  USB_SUPPORT_D3_COMMAND = $08;

  USB_SUPPORT_D1_WAKEUP  = $10;
  USB_SUPPORT_D2_WAKEUP  = $20;

type
  PUSB_CONFIGURATION_POWER_DESCRIPTOR = ^USB_CONFIGURATION_POWER_DESCRIPTOR;
  USB_CONFIGURATION_POWER_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    SelfPowerConsumedD0: array [0..2] of UCHAR;
    bPowerSummaryId: UCHAR;
    bBusPowerSavingD1: UCHAR;
    bSelfPowerSavingD1: UCHAR;
    bBusPowerSavingD2: UCHAR;
    bSelfPowerSavingD2: UCHAR;
    bBusPowerSavingD3: UCHAR;
    bSelfPowerSavingD3: UCHAR;
    TransitionTimeFromD1: USHORT;
    TransitionTimeFromD2: USHORT;
    TransitionTimeFromD3: USHORT;
  end;
  TUsbConfigurationPowerDescriptor = USB_CONFIGURATION_POWER_DESCRIPTOR;
  PUsbConfigurationPowerDescriptor = PUSB_CONFIGURATION_POWER_DESCRIPTOR;

  PUSB_INTERFACE_POWER_DESCRIPTOR = ^USB_INTERFACE_POWER_DESCRIPTOR;
  USB_INTERFACE_POWER_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bmCapabilitiesFlags: UCHAR;
    bBusPowerSavingD1: UCHAR;
    bSelfPowerSavingD1: UCHAR;
    bBusPowerSavingD2: UCHAR;
    bSelfPowerSavingD2: UCHAR;
    bBusPowerSavingD3: UCHAR;
    bSelfPowerSavingD3: UCHAR;
    TransitionTimeFromD1: USHORT;
    TransitionTimeFromD2: USHORT;
    TransitionTimeFromD3: USHORT;
  end;
  TUsbInterfacePowerDescriptor = USB_INTERFACE_POWER_DESCRIPTOR;
  PUsbInterfacePowerDescriptor = PUSB_INTERFACE_POWER_DESCRIPTOR;

// test direction bit in the bEndpointAddress field of
// an endpoint descriptor.
function USB_ENDPOINT_DIRECTION_OUT(addr: Integer): Integer;
function USB_ENDPOINT_DIRECTION_IN(addr: Integer): Integer;

function USB_DESCRIPTOR_MAKE_TYPE_AND_INDEX(d, i: USHORT): USHORT;

implementation

function USB_ENDPOINT_DIRECTION_OUT(addr: Integer): Integer;
begin
  Result := not (addr and USB_ENDPOINT_DIRECTION_MASK);
end;

function USB_ENDPOINT_DIRECTION_IN(addr: Integer): Integer;
begin
  Result := addr and USB_ENDPOINT_DIRECTION_MASK;
end;

function USB_DESCRIPTOR_MAKE_TYPE_AND_INDEX(d, i: USHORT): USHORT;
begin
  Result := (d shl 8) or i;
end;

end.
