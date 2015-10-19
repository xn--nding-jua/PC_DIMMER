{*++

Copyright (c) 1997-1998 Microsoft Corporation

Module Name:

    USBDESC.H

Abstract:

    This is a header file for USB descriptors which are not yet in
    a standard system header file.

Environment:

    user mode

Revision History:

    03-06-1998 : created

--*}

unit USBDesc;

{$WEAKPACKAGEUNIT ON}

interface

uses
  JwaWinType;

//*****************************************************************************
// D E F I N E S
//*****************************************************************************

const
  USB_HID_DESCRIPTOR_TYPE = $21;

  //
  // USB Device Class Definition for Audio Devices
  // Appendix A.  Audio Device Class Codes
  //

  // A.2  Audio Interface Subclass Codes
  //
  USB_AUDIO_SUBCLASS_UNDEFINED        = $00;
  USB_AUDIO_SUBCLASS_AUDIOCONTROL     = $01;
  USB_AUDIO_SUBCLASS_AUDIOSTREAMING   = $02;
  USB_AUDIO_SUBCLASS_MIDISTREAMING    = $03;

  // A.4  Audio Class-Specific Descriptor Types
  //
  USB_AUDIO_CS_UNDEFINED              = $20;
  USB_AUDIO_CS_DEVICE                 = $21;
  USB_AUDIO_CS_CONFIGURATION          = $23;
  USB_AUDIO_CS_STRING                 = $24;
  USB_AUDIO_CS_INTERFACE              = $24;
  USB_AUDIO_CS_ENDPOINT               = $25;

  // A.5  Audio Class-Specific AC (Audio Control) Interface Descriptor Subtypes
  //
  USB_AUDIO_AC_UNDEFINED              = $00;
  USB_AUDIO_AC_HEADER                 = $01;
  USB_AUDIO_AC_INPUT_TERMINAL         = $02;
  USB_AUDIO_AC_OUTPUT_TERMINAL        = $03;
  USB_AUDIO_AC_MIXER_UNIT             = $04;
  USB_AUDIO_AC_SELECTOR_UNIT          = $05;
  USB_AUDIO_AC_FEATURE_UNIT           = $06;
  USB_AUDIO_AC_PROCESSING_UNIT        = $07;
  USB_AUDIO_AC_EXTENSION_UNIT         = $08;

  // A.6  Audio Class-Specific AS (Audio Streaming) Interface Descriptor Subtypes
  //
  USB_AUDIO_AS_UNDEFINED              = $00;
  USB_AUDIO_AS_GENERAL                = $01;
  USB_AUDIO_AS_FORMAT_TYPE            = $02;
  USB_AUDIO_AS_FORMAT_SPECIFIC        = $03;

  // A.7 Processing Unit Process Types
  //
  USB_AUDIO_PROCESS_UNDEFINED         = $00;
  USB_AUDIO_PROCESS_UPDOWNMIX         = $01;
  USB_AUDIO_PROCESS_DOLBYPROLOGIC     = $02;
  USB_AUDIO_PROCESS_3DSTEREOEXTENDER  = $03;
  USB_AUDIO_PROCESS_REVERBERATION     = $04;
  USB_AUDIO_PROCESS_CHORUS            = $05;
  USB_AUDIO_PROCESS_DYNRANGECOMP      = $06;


//*****************************************************************************
// T Y P E D E F S
//*****************************************************************************

type
  // HID Class HID Descriptor
  //
  POptionalDescriptors = ^TOptionalDescriptors;
  TOptionalDescriptors = packed record
    bDescriptorType: UCHAR;
    wDescriptorLength: USHORT;
  end;

  PUSB_HID_DESCRIPTOR = ^USB_HID_DESCRIPTOR;
  USB_HID_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bcdHID: USHORT;
    bCountryCode: UCHAR;
    bNumDescriptors: UCHAR;
    OptionalDescriptors: array [0..0] of TOptionalDescriptors;
  end;
  TUsbHIDDescriptor = USB_HID_DESCRIPTOR;
  PUsbHIDDescriptor = PUSB_HID_DESCRIPTOR;

  // Common Class Endpoint Descriptor
  //
  PUSB_ENDPOINT_DESCRIPTOR2 = ^USB_ENDPOINT_DESCRIPTOR2;
  USB_ENDPOINT_DESCRIPTOR2 = packed record
    bLength: UCHAR;             // offset 0, size 1
    bDescriptorType: UCHAR;     // offset 1, size 1
    bEndpointAddress: UCHAR;    // offset 2, size 1
    bmAttributes: UCHAR;        // offset 3, size 1
    wMaxPacketSize: USHORT;     // offset 4, size 2
    wInterval: USHORT;          // offset 6, size 2
    bSyncAddress: UCHAR;        // offset 8, size 1
  end;

  // Common Class Interface Descriptor
  //
  PUSB_INTERFACE_DESCRIPTOR2 = ^USB_INTERFACE_DESCRIPTOR2;
  USB_INTERFACE_DESCRIPTOR2 = packed record
    bLength: UCHAR;             // offset 0, size 1
    bDescriptorType: UCHAR;     // offset 1, size 1
    bInterfaceNumber: UCHAR;    // offset 2, size 1
    bAlternateSetting: UCHAR;   // offset 3, size 1
    bNumEndpoints: UCHAR;       // offset 4, size 1
    bInterfaceClass: UCHAR;     // offset 5, size 1
    bInterfaceSubClass: UCHAR;  // offset 6, size 1
    bInterfaceProtocol: UCHAR;  // offset 7, size 1
    iInterface: UCHAR;          // offset 8, size 1
    wNumClasses: USHORT;        // offset 9, size 2
  end;

  //
  // USB Device Class Definition for Audio Devices
  //

  PUSB_AUDIO_COMMON_DESCRIPTOR = ^USB_AUDIO_COMMON_DESCRIPTOR;
  USB_AUDIO_COMMON_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
  end;

  // 4.3.2 Class-Specific AC (Audio Control) Interface Descriptor
  //
  PUSB_AUDIO_AC_INTERFACE_HEADER_DESCRIPTOR = ^USB_AUDIO_AC_INTERFACE_HEADER_DESCRIPTOR;
  USB_AUDIO_AC_INTERFACE_HEADER_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bcdADC: USHORT;
    wTotalLength: USHORT;
    bInCollection: UCHAR;
    baInterfaceNr: array [0..0] of UCHAR;
  end;

  // 4.3.2.1 Input Terminal Descriptor
  //
  PUSB_AUDIO_INPUT_TERMINAL_DESCRIPTOR = ^USB_AUDIO_INPUT_TERMINAL_DESCRIPTOR;
  USB_AUDIO_INPUT_TERMINAL_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bTerminalID: UCHAR;
    wTerminalType: USHORT;
    bAssocTerminal: UCHAR;
    bNrChannels: UCHAR;
    wChannelConfig: USHORT;
    iChannelNames: UCHAR;
    iTerminal: UCHAR;
  end;

  // 4.3.2.2 Output Terminal Descriptor
  //
  PUSB_AUDIO_OUTPUT_TERMINAL_DESCRIPTOR = ^USB_AUDIO_OUTPUT_TERMINAL_DESCRIPTOR;
  USB_AUDIO_OUTPUT_TERMINAL_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bTerminalID: UCHAR;
    wTerminalType: USHORT;
    bAssocTerminal: UCHAR;
    bSoruceID: UCHAR;
    iTerminal: UCHAR;
  end;

  // 4.3.2.3 Mixer Unit Descriptor
  //
  PUSB_AUDIO_MIXER_UNIT_DESCRIPTOR = ^USB_AUDIO_MIXER_UNIT_DESCRIPTOR;
  USB_AUDIO_MIXER_UNIT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bUnitID: UCHAR;
    bNrInPins: UCHAR;
    baSourceID: array [0..0] of UCHAR;
  end;

  // 4.3.2.4 Selector Unit Descriptor
  //
  PUSB_AUDIO_SELECTOR_UNIT_DESCRIPTOR = ^USB_AUDIO_SELECTOR_UNIT_DESCRIPTOR;
  USB_AUDIO_SELECTOR_UNIT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bUnitID: UCHAR;
    bNrInPins: UCHAR;
    baSourceID: array [0..0] of UCHAR;
  end;

  // 4.3.2.5 Feature Unit Descriptor
  //
  PUSB_AUDIO_FEATURE_UNIT_DESCRIPTOR = ^USB_AUDIO_FEATURE_UNIT_DESCRIPTOR;
  USB_AUDIO_FEATURE_UNIT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bUnitID: UCHAR;
    bSourceID: UCHAR;
    bControlSize: UCHAR;
    bmaControls: array [0..0] of UCHAR;
  end;

  // 4.3.2.6 Processing Unit Descriptor
  //
  PUSB_AUDIO_PROCESSING_UNIT_DESCRIPTOR = ^USB_AUDIO_PROCESSING_UNIT_DESCRIPTOR;
  USB_AUDIO_PROCESSING_UNIT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bUnitID: UCHAR;
    wProcessType: USHORT;
    bNrInPins: UCHAR;
    baSourceID: array [0..0] of UCHAR;
  end;

  // 4.3.2.7 Extension Unit Descriptor
  //
  PUSB_AUDIO_EXTENSION_UNIT_DESCRIPTOR = ^USB_AUDIO_EXTENSION_UNIT_DESCRIPTOR;
  USB_AUDIO_EXTENSION_UNIT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bUnitID: UCHAR;
    wExtensionCode: USHORT;
    bNrInPins: UCHAR;
    baSourceID: array [0..0] of UCHAR;
  end;

  // 4.5.2 Class-Specific AS Interface Descriptor
  //
  PUSB_AUDIO_GENERAL_DESCRIPTOR = ^USB_AUDIO_GENERAL_DESCRIPTOR;
  USB_AUDIO_GENERAL_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bTerminalLink: UCHAR;
    bDelay: UCHAR;
    wFormatTag: USHORT;
  end;

  // 4.6.1.2 Class-Specific AS Endpoint Descriptor
  //
  PUSB_AUDIO_ENDPOINT_DESCRIPTOR = ^USB_AUDIO_ENDPOINT_DESCRIPTOR;
  USB_AUDIO_ENDPOINT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bmAttributes: UCHAR;
    bLockDelayUnits: UCHAR;
    wLockDelay: USHORT;
  end;

  //
  // USB Device Class Definition for Audio Data Formats
  //

  PUSB_AUDIO_COMMON_FORMAT_DESCRIPTOR = ^USB_AUDIO_COMMON_FORMAT_DESCRIPTOR;
  USB_AUDIO_COMMON_FORMAT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bFormatType: UCHAR;
  end;

  // 2.1.5 Type I   Format Type Descriptor
  // 2.3.1 Type III Format Type Descriptor
  //
  PUSB_AUDIO_TYPE_I_OR_III_FORMAT_DESCRIPTOR = ^USB_AUDIO_TYPE_I_OR_III_FORMAT_DESCRIPTOR;
  USB_AUDIO_TYPE_I_OR_III_FORMAT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bFormatType: UCHAR;
    bNrChannels: UCHAR;
    bSubframeSize: UCHAR;
    bBitResolution: UCHAR;
    bSamFreqType: UCHAR;
  end;

  // 2.2.6 Type II  Format Type Descriptor
  //
  PUSB_AUDIO_TYPE_II_FORMAT_DESCRIPTOR = ^USB_AUDIO_TYPE_II_FORMAT_DESCRIPTOR;
  USB_AUDIO_TYPE_II_FORMAT_DESCRIPTOR = packed record
    bLength: UCHAR;
    bDescriptorType: UCHAR;
    bDescriptorSubtype: UCHAR;
    bFormatType: UCHAR;
    wMaxBitRate: USHORT;
    wSamplesPerFrame: USHORT;
    bSamFreqType: UCHAR;
  end;

implementation

end.
