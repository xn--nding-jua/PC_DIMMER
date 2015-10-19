;                            Software License Agreement
;
; The software supplied herewith by Microchip Technology Incorporated (the "Company")
; for its PICmicro(r) Microcontroller is intended and supplied to you, the Company's
; customer, for use solely and exclusively on Microchip PICmicro Microcontroller
; products.
;
; The software is owned by the Company and/or its supplier, and is protected under
; applicable copyright laws. All rights are reserved. Any use in violation of the
; foregoing restrictions may subject the user to criminal sanctions under applicable
; laws, as well as to civil liability for the breach of the terms and conditions of
; this license.
;
; THIS SOFTWARE IS PROVIDED IN AN "AS IS" CONDITION. NO WARRANTIES, WHETHER EXPRESS,
; IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. THE
; COMPANY SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL OR
; CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
;
; ###############################################################################
;	filename:	DESCRIPT.ASM
;
; This file contains a set of descriptors for a custom
; USB to DMX 512 Interface.  
;
; ###############################################################################
;
;	Author:			Dan Butler and Reston Condit
;					Jean-Marc Lienher
;	Company:		Microchip Technology Inc
;					www.oksidizer.com
;
;	Revision:		1.50
;	Date:			26 August 2004
;	Assembled using:	MPASM 3.60
;################################################################################
;
;	include files:
;		P16C765.inc	Rev 1.00
;		usb_defs.inc	Rev 1.23
;
;################################################################################
#include <p16C765.inc>
#include "usb_defs.inc"

USBBANK	code
	global	Config_desc_index
	global	Descriptions
	global	string_index
	global	DeviceDescriptor
	global	String0
	global	String0_end
	global	StringDescriptions

	extern	EP0_start
	extern	temp		; temp var used in get config index
	extern	temp2 		; another temp, in bank2 

; ******************************************************************
; Given a configuration descriptor index, returns the beginning address
; of the descriptor within the descriptions table
; ******************************************************************
Config_desc_index
	movwf	temp
	movlw	HIGH CDI_start
	movwf	PCLATH
	movlw	low CDI_start
	addwf	temp,w
	btfsc	STATUS,C
	incf	PCLATH,f
	movwf	PCL
CDI_start			; this table calculates the offsets for each 
	retlw	low  Config1	; configuration descriptor from the beginning
	retlw	high Config1	; of the table
	; more configurations can be added here
	; retlw   low Config2
	; retlw   high Config2
	; etc....

; ******************************************************************
; This table is polled by the host immediately after USB Reset has been released.
; This table defines the maximum packet size EP0 can take.
; See section 9.6.1 of the Rev 1.0 USB specification.
; These fields are application DEPENDENT. Modify these to meet
; your specifications.
; the offset is passed in P0 and P1 (P0 is low order byte).
; ******************************************************************
Descriptions
	banksel	EP0_start
	movf	EP0_start+1,w
	movwf	PCLATH
	movf	EP0_start,w
	movwf	PCL

DeviceDescriptor
StartDevDescr
	retlw	0x12		; bLengthLength of this descriptor
	retlw	0x01		; bDescType This is a DEVICE descriptor
	retlw	0x10		; bcdUSBUSB revision 1.10 (low byte)
	retlw	0x01		; high byte
	retlw	0x00		; bDeviceClasszero means each interface operates independently
	retlw	0x00		; bDeviceSubClass
	retlw	0x00		; bDeviceProtocol
	retlw	0x08		; bMaxPacketSize0 - inited in UsbInit()

	retlw	0x03		; idVendor - 0x0403 is FTDI Vendor ID
	retlw	0x04		; high order byte
					
	retlw	0x88		; idProduct O'ksi'D product id from FTDI
	retlw	0xE0
	retlw	0x00		; bcdDevice
	retlw	0x00
	retlw	0x01		; iManufacturer
	retlw	0x02		; iProduct
	retlw	0x03		; iSerialNumber - 3
	retlw	NUM_CONFIGURATIONS	; bNumConfigurations

; ******************************************************************
; This table is retrieved by the host after the address has been set.
; This table defines the configurations available for the device.
; See section 9.6.2 of the Rev 1.0 USB specification (page 184).
; These fields are application DEPENDENT. 
; Modify these to meet your specifications.
; ******************************************************************
Config1
	retlw	0x09		; bLengthLength of this descriptor
	retlw	0x02		; bDescType2 = CONFIGURATION
	retlw	EndConfig1 - Config1
	retlw	0x00
	retlw	0x01		; bNumInterfacesNumber of interfaces
	retlw	0x01		; bConfigValueConfiguration Value
	retlw	0x04		; iConfigString Index for this config = #01
	retlw	0x80		; bmAttributesattributes - bus powered
	retlw	0x80		; MaxPowerself-powered draws 256 mA from the bus.
Interface1
	retlw	0x09		; length of descriptor
	retlw	INTERFACE
	retlw	0x00		; number of interface, 0 based array
	retlw	0x00		; alternate setting
	retlw	0x02		; number of endpoints used in this interface
	retlw	0xff		; interface class - assigned by the USB
	retlw	0xff		;  
	retlw	0xff		;  
	retlw	0x05		; index to string descriptor that describes this interface
Endpoint1
	retlw	0x07		; length of descriptor
	retlw	ENDPOINT
	retlw	0x81		; EP1, In
	retlw	0x00		; Control Interrupt
	retlw	0x08		; max packet size (8 bytes) low order byte
	retlw	0x00		; max packet size (8 bytes) high order byte
	retlw	0x0A		; (polling interval (ms))
Endpoint2
	retlw	0x07		; length of descriptor
	retlw	ENDPOINT
	retlw	0x01		; EP1, Out
	retlw	0x00		; Control (0x03 Interrupt)
	retlw	0x08		; max packet size (8 bytes) low order byte
	retlw	0x00		; max packet size (8 bytes) high order byte
	retlw	0x00		; (polling interval (ms))
EndConfig1

	
StringDescriptions
	banksel	EP0_start
	movf	EP0_start+1,w
	movwf	PCLATH
	movf	EP0_start,w
	movwf	PCL

; ******************************************************************
; Given a configuration descriptor index, returns the beginning address
; of the descriptor within the descriptions table
; ******************************************************************
string_index	; langid in W reg, string offset in EP0_start
	movwf	temp
	bcf 	STATUS,C
	rlf 	temp, f
	pagesel	langid_index
	call	langid_index
	movwf	temp2
	incf	temp, f
	pagesel	langid_index
	call	langid_index
	movwf	temp

	movf	temp, w
	movwf	PCLATH
	movf	temp2,w
	addwf	EP0_start+1,w
	btfsc	STATUS,C
	incf	PCLATH, f
	movwf	PCL

langid_index
	movlw	high langids
	movwf	PCLATH
	movlw	low langids
	addwf	temp, w
	btfsc	STATUS,C
	incf	PCLATH,f
	movwf	PCL

langids
	retlw	low lang_1
	retlw	high lang_1

lang_1	; english
	retlw	low  String0	; LangIDs
	retlw	high String0
	retlw	low  String1_l1 ; OksiD
	retlw	high String1_l1
	retlw	low  String2_l1 ; USB DMX512
	retlw	high String2_l1
	retlw	low  String3_l1 ; ######## (serial number)
	retlw	high String3_l1
	retlw	low  String4_l1 ; Configuration 1
	retlw	high String4_l1
	retlw	low  String5_l1 ; EP1 In/Out 
	retlw	high String5_l1
	retlw	low  String6_l1
	retlw	high String6_l1

String0
	retlw	low (String1_l1 - String0)	; length of string 
	retlw	0x03		; descriptor type 3?
	retlw	0x09		; language ID (as defined by MS 0x0409)
	retlw	0x04
String0_end
String1_l1
	retlw	String2_l1-String1_l1	; length of string
	retlw	0x03		; string descriptor type 3
	retlw	'O'
	retlw	0x00
	retlw	'k'
	retlw	0x00
	retlw	's'
	retlw	0x00
	retlw	'i'
	retlw	0x00
	retlw	'D'
	retlw	0x00
String2_l1
	retlw	String3_l1-String2_l1
	retlw	0x03
	retlw	'U'
	retlw	0x00
	retlw	'S'
	retlw	0x00
	retlw	'B'
	retlw	0x00
	retlw	' '
	retlw	0x00
	retlw	'D'
	retlw	0x00
	retlw	'M'
	retlw	0x00
	retlw	'X'
	retlw	0x00
	retlw	'5'
	retlw	0x00
	retlw	'1'
	retlw	0x00
	retlw	'2'
	retlw	0x00
String3_l1
	retlw	String4_l1-String3_l1
	retlw	0x03
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
	retlw	'#'
	retlw	0x00
String4_l1
	retlw	String5_l1-String4_l1
	retlw	0x03
	retlw	'C'
	retlw	0x00
	retlw	'o'
	retlw	0x00
	retlw	'n'
	retlw	0x00
	retlw	'f'
	retlw	0x00
	retlw	'i'
	retlw	0x00
	retlw	'g'
	retlw	0x00
	retlw	'u'
	retlw	0x00
	retlw	'r'
	retlw	0x00
	retlw	'a'
	retlw	0x00
	retlw	't'
	retlw	0x00
	retlw	'i'
	retlw	0x00
	retlw	'o'
	retlw	0x00
	retlw	'n'
	retlw	0x00
	retlw	' '
	retlw	0x00
	retlw	'1'
	retlw	0x00
String5_l1
	retlw	String6_l1-String5_l1
	retlw	0x03
	retlw	'E'
	retlw	0x00
	retlw	'P'
	retlw	0x00
	retlw	'1'
	retlw	0x00
	retlw	' '
	retlw	0x00
	retlw	'I'
	retlw	0x00
	retlw	'N'
	retlw	0x00
	retlw	'/'
	retlw	0x00
	retlw	'O'
	retlw	0x00
	retlw	'U'
	retlw	0x00
	retlw	'T'
	retlw	0x00
String6_l1
	

	end
