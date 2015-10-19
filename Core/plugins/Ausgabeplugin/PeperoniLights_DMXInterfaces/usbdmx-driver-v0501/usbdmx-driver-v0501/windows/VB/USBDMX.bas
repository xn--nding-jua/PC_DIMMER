Attribute VB_Name = "Defines"
Rem
Rem Module for accessing all Peperoni light usbdmx interfaces
Rem
Rem General remark: all functions return != 0 on success and 0 on failure
Rem
Rem Author:  Jan Menzel
Rem Version: 0.1
Rem Changes:
Rem 17.09.2004: first version

Option Explicit

Rem * usbdmx_version(): returns the DLL version number (16bit, 4 digits BCD)
Declare Function usbdmx_version Lib "usbdmx.dll" () As Integer

Rem * usbdmx_open(): open device Number and return a handle to it
Declare Function usbdmx_open Lib "usbdmx.dll" (ByVal number As Integer, ByRef handle As Long) As Boolean

Rem * usbdmx_close(): close handle to given device
Declare Function usbdmx_close Lib "usbdmx.dll" (ByVal handle As Long) As Boolean

Rem * usbdmx_device_id(): read the device id of the device
Declare Function usbdmx_device_id Lib "usbdmx.dll" (ByVal handle As Long, ByRef pid As Integer) As Boolean

Rem * usbdmx_is_XXX(): identify the device identified by the given handle.
Declare Function usbdmx_is_xswitch Lib "usbdmx.dll" (ByVal handle As Long) As Boolean
Declare Function usbdmx_is_rodin1 Lib "usbdmx.dll" (ByVal handle As Long) As Boolean
Declare Function usbdmx_is_rodin2 Lib "usbdmx.dll" (ByVal handle As Long) As Boolean
Declare Function usbdmx_is_rodint Lib "usbdmx.dll" (ByVal handle As Long) As Boolean
Declare Function usbdmx_is_usbdmx21 Lib "usbdmx.dll" (ByVal handle As Long) As Boolean

Rem * usbdmx_device_version(): Read the the device version of a device.
Rem * the device version is one of the values within the USBs configuration
Rem * descriptor (BcdDevice). pversion is only valid if the function returns TRUE.
Declare Function usbdmx_device_version Lib "usbdmx.dll" (ByVal handle As Long, ByRef pversion As Integer) As Boolean

Rem * usbdmx_tx_XXX(): Write or read the interfaces transmitter buffer.
Rem * usbdmx_tx2_XXX() addresses the buffer of the second transmitter, which
Rem * is only valid for usbdmx21 devices. The XXX_blocking() functions return
Rem * if the current frame has been transmitted compleately. They operate
Rem * the interface synronices with the transmitter. All other functions
Rem * operate asynchronously, they return immediately.
Declare Function usbdmx_tx_set Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx_set_blocking Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx2_set Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx2_set_blocking Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx_get_blocking Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx2_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_tx2_get_blocking Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean

Rem * usbdmx_rx_XXX(): Write or read the interfaces receiver buffer.
Rem * The XXX_blocking() functions return if the current frame has been
Rem * transmitted compleately. They operate the interface synronices with
Rem * the transmitter. All other functions operate asynchronously, they
Rem * return immediately.
Declare Function usbdmx_rx_set Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_rx_set_blocking Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_rx_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean
Declare Function usbdmx_rx_get_blocking Lib "usbdmx.dll" (ByVal handle As Long, ByRef buf As Byte, ByVal size As Integer) As Boolean

Rem * usbdmx_[rx|tx]_frames(): return a 32bit frame counter from the device.
Rem * Each device counts the transmitted/received frames. The framecounter
Rem * can overflow.
Declare Function usbdmx_tx_frames Lib "usbdmx.dll" (ByVal handle As Long, ByRef frames As Long) As Boolean
Declare Function usbdmx_rx_frames Lib "usbdmx.dll" (ByVal handle As Long, ByRef frames As Long) As Boolean

Rem * usbdmx_[rx|tx]_startcode_[set|get](): read/set the startcode of the
Rem * transmitter/receiver. The receiver only accepts frames with the
Rem * given startcode, all other are ignored. According to DMX512A
Rem * specification the startcode should be 0.
Declare Function usbdmx_tx_startcode_set Lib "usbdmx.dll" (ByVal handle As Long, ByVal startcode As Byte) As Boolean
Declare Function usbdmx_tx_startcode_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef startcode As Byte) As Boolean
Declare Function usbdmx_rx_startcode_set Lib "usbdmx.dll" (ByVal handle As Long, ByVal startcode As Byte) As Boolean
Declare Function usbdmx_rx_startcode_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef startcode As Byte) As Boolean

Rem * usbdmx_tx_slots_[set|get](): read/set the number of slots transmitted
Rem * per frame. Numbers above 512 or below 24 are not allowed.
Declare Function usbdmx_tx_slots_set Lib "usbdmx.dll" (ByVal handle As Long, ByVal slots As Integer) As Boolean
Declare Function usbdmx_tx_slots_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef slots As Integer) As Boolean

Rem * usbdmx_rx_slots_get(): read the number of slots received within the last frames.
Declare Function usbdmx_rx_slots_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef slots As Integer) As Boolean

Rem * usbdmx_tx_timing_XXX(): read/set the timing values of the transmitter.
Rem * each value is returned/set in seconds.
Declare Function usbdmx_tx_timing_set Lib "usbdmx.dll" (ByVal handle As Long, ByVal break As Single, ByVal mab As Single, ByVal interframe As Single) As Boolean
Declare Function usbdmx_tx_timing_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef break As Single, ByRef mab As Single, ByRef interframe As Single) As Boolean

Rem * usbdmx_id_led_XXX(): get/set the "id-led", the way the TX-led is handled:
Rem * id == 0:    the TX led is equal to the GL (good-link, USB-stauts) value
Rem * id == 0xff: the TX led shows just the transmitter state (active/deactivated)
Rem * other:      the TX led blinks the given number of times and then pauses
Declare Function usbdmx_id_led_set Lib "usbdmx.dll" (ByVal handle As Long, ByVal id As Byte) As Boolean
Declare Function usbdmx_id_led_get Lib "usbdmx.dll" (ByVal handle As Long, ByRef id As Byte) As Boolean

