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
;	filename:	USB_CH9.ASM
;
; Implements the chapter 9 enumeration commands for Microchip's
; PIC16C7x5 parts.
;
; ###############################################################################
;
;	Author(s):		Dan Butler and Reston Condit
;	Company:		Microchip Technology Inc
;
;	Revision:		1.25
;	Date:			23 April 2002
;	Assembled using:	MPASM 2.80
;################################################################################
;
;	include files:
;		P16C765.inc	Rev 1.00
;		usb_defs.inc	Rev 1.00
;
;################################################################################

#include <p16C765.inc>
#include "usb_defs.inc"

	errorlevel -302		; supress "register not in bank0, check page bits" message

#define	SHOW_ENUM_STATUS

unbanked	udata_shr		; these will get assigned to unbanked RAM (0x70-0x7F)
temp			res	1	; short term temp register used in Get Interface
GPtemp			res	1	; temporary storage location used in Get and PutEPn

	global	BufferDescriptor
	global	BufferData
	global	temp
	global	temp2
	global	EP0_maxLength
	global	EP0_start
	global	EP0_end

bank0	udata
BufferDescriptor	res	3
BufferData		res	8
USBMaskedInterrupts	res	1
USB_Curr_Config		res	1
USB_status_device	res	1	; status of device
USB_dev_req		res	1
USB_address_pending	res	1
USBMaskedErrors		res	1
PIDs 			res	1
EP0_start		res	2	; pointer to first byte of data to send
EP0_end			res	1	; pointer to last byte of data to send
EP0_maxLength		res	1
temp2			res	1
bufindex		res	1
USB_Interface		res	3	; allow 3 interfaces to have alternate endpoints
inner			res	1
outer			res	1
dest_ptr		res	1	; used in buffer copies for Get and
source_ptr		res	1	; Put USB calls
hid_dest_ptr		res	1	; used in buffer copies for HIDSetReport
hid_source_ptr		res	1	;
counter			res	1
bytecounter		res	1	; saved copy that will be returned in W
RP_save			res	1	; save bank bits while copying buffers
IS_IDLE			res	1
USB_USTAT		res	1	; copy of the USTAT register before clearing TOK_DNE
EP1_nb_rec_packet 	res 1	; quantity of packet to be recieved
EP1_nb_send_packet 	res 1	; quantity of packet to be sent
EP1_control_direction res 1 ; 0x02 = host Read, 0x01 = host write 

	global	USB_Curr_Config 
	global	USB_status_device
	global	USB_dev_req
	global	USB_Interface
	global	EP1_nb_rec_packet
	global 	EP1_nb_send_packet
	global 	EP1_control_direction

#ifdef	COUNTERRORS
USB_PID_ERR		res	2	; 16 bit counters for each error condition
USB_CRC5_ERR		res	2
USB_CRC16_ERR		res	2
USB_DFN8_ERR		res	2
USB_BTO_ERR		res	2
USB_WRT_ERR		res	2
USB_OWN_ERR		res	2
USB_BTS_ERR		res	2
#endif

	extern	Config_desc_index
	extern	Descriptions
	extern	string_index
	extern	String0
	extern	String0_end
	extern	DeviceDescriptor
	extern	StringDescriptions

; **********************************************************************
; This section contains the functions to interface with the main 
; application.
; **********************************************************************

interface	code

; **********************************************************************
; GETEP1 and GETEP2
;
; Note:  These functions are macros defined in usb_defs.inc.
;        To save ROM, delete the instances below that you will not need.
;
; Enter with buffer pointer in IRP+FSR.  
; Each function checks the UOWNs bit for the particular OUT endpoint, 
; and copies the buffer if available.  Upon completion of the function, 
; the bank bits are restored to the state they were in when this 
; function was entered.
;
; Returns the bytecount in the W register and return status in the carry
; bit as follows:
; 0 - no buffer available,
; 1 - Buffer copied and buffer made available for next transfer.
; 
; The number of bytes moved is returned in W reg.
; **********************************************************************

	GETEP1		; create instance of GETEP1
;	GETEP2		; create instance of GETEP2

; **********************************************************************
; PUTEP1 and PUTEP2
;
; Note:  These functions are macros defined in usb_defs.inc.
;        To save ROM, delete the instances below that you will not need.
;
; Enter with bytecount in W and buffer pointer in IRP+FSR.
;
; Tests the UOWNs bit for the IN side of the specified Endpoint.
; If we own the buffer, the buffer pointed to by the FSR is copied
; to the EPn IN buffer, then the UOWNs bit is set so the data will be
; TX'd next time polled.  
;
; Returns the status in the carry bit as follows:
; 1 - buffer available and copied.
; 0 - buffer not available (try again later)
; **********************************************************************

	PUTEP1		; create instance of PUTEP1
;	PUTEP2		; create instance of PUTEP2

; *********************************************************************
; Stall Endpoint.
; Sets the stall bit in the Endpoint Control Register.  For the control
; Endpoint, this implements a Protocol stall and is used when the request
; is invalid for the current device state.  For non-control Endpoints,
; this is a Functional Stall, meaning that the device needs outside 
; intervention and trying again later won't help until it's been serviced.
; enter with endpoint # to stall in Wreg.
; *********************************************************************
StallUSBEP
	;bsf	STATUS,IRP	; select banks 2/3 for indirect addressing
	bankisel UEP0
	andlw	0x03		; try to keep things under control
	addlw	low UEP0	; add address of endpoint control reg
	movwf	FSR
	bsf	INDF,EP_STALL	; set stall bit
	return

; *********************************************************************
; Unstall Endpoint.
; Sets the stall bit in the Endpoint Control Register.  For the control
; Endpoint, this implements a Protocol stall and is used when the request
; is invalid for the current device state.  For non-control Endpoints,
; this is a Functional Stall, meaning that the device needs outside 
; intervention and trying again later won't help until it's been serviced.
; enter with endpoint # to stall in Wreg.
; *********************************************************************
UnstallUSBEP
	;bsf	STATUS,IRP	; select banks 2/3 (indirect)
	bankisel UEP0
	andlw	0x03		; try to keep things under control
	addlw	low UEP0	; add address of endpoint control reg
	movwf	FSR
	bcf	INDF,EP_STALL	; clear stall bit
	return

; *********************************************************************
; CheckSleep
; Checks the USB Sleep bit.  If the bit is set, the
; Endpoint, this implements a Protocol stall and is used when the request
; is invalid for the current device state.  For non-control Endpoints,
; this is a Functional Stall, meaning that the device needs outside 
; intervention and trying again later won't help until it's been serviced.
; enter with endpoint # to stall in Wreg.
; *********************************************************************
CheckSleep
	global	CheckSleep

	banksel	IS_IDLE
	btfss	IS_IDLE,0	; test the bus idle bit
	return

	;bsf 	STATUS,RP0  	; point to bank 3
	banksel UIR
	bcf 	UIR,ACTIVITY
	bsf 	UIE,ACTIVITY	; enable the USB activity interrupt
	bsf 	UCTRL,SUSPND	; put USB regulator and transciever in low power state
	sleep   		; and go to sleep
	nop
	bcf 	UCTRL,SUSPND
	bcf 	UIR,UIDLE
	bsf 	UIE,UIDLE
	bcf 	UIR,ACTIVITY
	bcf 	UIE,ACTIVITY

	return

; *********************************************************************
; Remote Wakeup
; Checks USB_status_device to see if the host enabled Remote Wakeup
; If so, perform Remote wakeup and disable remote wakeup feature
; It is called by PortBChange.  
; *********************************************************************
RemoteWakeup
	global	RemoteWakeup

	banksel USB_status_device
	btfss	USB_status_device, 1
	return

	banksel UCTRL
	;bsf	STATUS, RP0	; BANK 3
	bcf	UCTRL, SUSPND
	bsf	UIE,UIDLE
	bcf	UIR,UIDLE
	bcf	UIE,ACTIVITY
	bcf	UIR,ACTIVITY
	bsf	UCTRL, 2	; RESUME SIGNALING
	banksel inner
	;bcf	STATUS, RP0	; BANK 2

	clrf	inner
	movlw	0x80
	movwf	outer
	pagesel RemoteLoop
RemoteLoop	
	decfsz	inner, f
	goto	RemoteLoop
	decfsz	outer, f
	goto	RemoteLoop

	banksel UCTRL
	;bsf	STATUS, RP0	; BANK 3
	bcf	UCTRL, 2	; Clear Resume bit
	return


; *********************************************************************
; USB Soft Detach
; Clears the DEV_ATT bit, electrically disconnecting the device to the bus.
; This removes the device from the bus, then reconnects so it can be
; re-enumerated by the host.  This is envisioned as a last ditch effort
; by the software.
; *********************************************************************
SoftDetachUSB
	global	SoftDetachUSB

	banksel	UCTRL
	bcf	UCTRL,DEV_ATT	; clear attach bit

	banksel outer
	;bcf	STATUS, RP0	; bank 2
    
	clrf	outer
	clrf	inner
	pagesel	SoftDetachLoop
SoftDetachLoop
	incfsz	inner,f
	goto	SoftDetachLoop
	incfsz	outer,f
	goto	SoftDetachLoop

	pagesel	InitUSB
	call	InitUSB		; reinitialize the USB peripheral
	return


; ******************************************************************
; Init USB
; Initializes the USB peripheral, sets up the interrupts
; ******************************************************************
InitUSB
	global	InitUSB

	banksel	USWSTAT
	clrf	USWSTAT		; default to powered state
	movlw	0x01		; mask all USB interrupts except reset
	movwf	UIE
	clrf	UIR		; clear all USB Interrupt flags
	movlw	0x08		; Device attached
	movwf	UCTRL

	banksel USB_Curr_Config
	;bcf	STATUS, RP0	; bank 2
	clrf	USB_Curr_Config
	movlw	1
	movwf	USB_status_device
	clrf	USB_Interface
	clrf	USB_Interface+1
	clrf	USB_Interface+2
	movlw	0xFF
	movwf	USB_dev_req	; no device requests in process
#ifdef COUNTERRORS
	clrf	USB_PID_ERR
	clrf	USB_PID_ERR+1
	clrf	USB_CRC5_ERR
	clrf	USB_CRC5_ERR+1
	clrf	USB_CRC16_ERR
	clrf	USB_CRC16_ERR+1
	clrf	USB_DFN8_ERR
	clrf	USB_DFN8_ERR+1
	clrf	USB_BTO_ERR
	clrf	USB_BTO_ERR+1
	clrf	USB_WRT_ERR
	clrf	USB_WRT_ERR+1
	clrf	USB_OWN_ERR
	clrf	USB_OWN_ERR+1
	clrf	USB_BTS_ERR
	clrf	USB_BTS_ERR+1
#endif

	banksel	EP1_nb_rec_packet
	clrf	EP1_nb_rec_packet
	clrf	EP1_nb_send_packet
	clrf	EP1_control_direction

	banksel PIR1		; bank 0
	bcf 	PIR1,USBIF	; clear the USB flag
    banksel PIE1
	;bsf 	STATUS,RP0	; bank 1
	bsf 	PIE1,USBIE	; enable usb interrupt
	bsf  	INTCON, 6	; enable global and peripheral interrupts
	bsf 	INTCON, 7

	return


; ******************************************************************
; DeInit USB
; Shuts down the USB peripheral, clears the interrupt enable.
; ******************************************************************
DeInitUSB
	global	DeInitUSB

	banksel	UCTRL
	bcf	UCTRL,DEV_ATT	; D+/D- go high Z
	bsf	UCTRL,SUSPND	; Place USB module in low power mode.

	clrf	USWSTAT		; set device state to powered.

	banksel PIE1
	;bcf	STATUS,RP1	; select bank 1
	bcf	PIE1,USBIE	; clear USB interrupt enable

	return


core	code
; The functions below are the core functions
; ******************************************************************
; USB interrupt triggered, Why?
; Poll the USB interrupt flags to find the cause.
; ******************************************************************
ServiceUSBInt
	global	ServiceUSBInt

	banksel	UIR
	movf	UIR,w		; get the USB interrupt register
	andwf	UIE,w		; mask off the disabled interrupts
	;bcf	STATUS, RP0	; BANK 2
	banksel USB_Curr_Config
 
	pagesel	ExitServiceUSBInt
	btfsc	STATUS,Z	; is there any unmasked interrupts?
	goto	ExitServiceUSBInt	; no, bail out.

	movwf	USBMaskedInterrupts
	pagesel	TokenDone
	btfsc	USBMaskedInterrupts,ACTIVITY
	call	USBActivity
	pagesel	USBReset
	btfsc	USBMaskedInterrupts,USB_RST
	call	USBReset
	pagesel	USBStall
	btfsc	USBMaskedInterrupts,TOK_DNE	; was it a token done?
	call	TokenDone
	pagesel	USBActivity
	btfsc	USBMaskedInterrupts,STALL
	call	USBStall
	pagesel	USBError
	btfsc	USBMaskedInterrupts,UERR
	call	USBError
	pagesel	USBSleep
	btfsc	USBMaskedInterrupts,UIDLE
	call	USBSleep
	pagesel	ServiceUSBInt
	goto	ServiceUSBInt

ExitServiceUSBInt
	banksel	PIR1
	bcf 	PIR1,USBIF
	return

; ******************************************************************
; USB Reset interrupt triggered (SE0)
; initialize the Buffer Descriptor Table,
; Transition to the DEFAULT state,
; Set address to 0
; enable the USB
; ******************************************************************
USBReset	; START IN BANK2

	clrf	USB_Curr_Config
	clrf	IS_IDLE
	;bsf 	STATUS, RP0	; bank 3
	banksel UIR
	
	bcf 	UIR,TOK_DNE	; hit this 4 times to clear out the
	bcf 	UIR,TOK_DNE	; USTAT FIFO
	bcf 	UIR,TOK_DNE
	bcf 	UIR,TOK_DNE
	
	movlw	0x8
	movwf	BD0OBC
	movlw	USB_Buffer	; Endpoint 0 OUT gets a buffer
	movwf	BD0OAL		; set up buffer address
	movlw	0x88		; set owns bit (SIE can write)
	movwf	BD0OST
	
	movlw	USB_Buffer+8	; Endpoint 0 IN gets a buffer
	movwf	BD0IAL		; set up buffer address
	movlw	0x08		; Clear owns bit (PIC can write)
	movwf	BD0IST

	clrf	UADDR		; set USB Address to 0
	clrf	UIR		; clear all the USB interrupt flags
	banksel	PIR1		; switch to bank 0
	bcf 	PIR1,USBIF

; Set up the Endpoint Control Registers.  The following patterns are defined
; ENDPT_DISABLED - endpoint not used
; ENDPT_IN_ONLY  - endpoint supports IN transactions only
; ENDPT_OUT_ONLY - endpoint supports OUT transactions only
; ENDPT_CONTROL  - Supports IN, OUT and CONTROL transactions - Only use with EP0
; ENDPT_NON_CONTROL - Supports both IN and OUT transactions

	banksel	UEP0
	movlw	ENDPT_CONTROL
	movwf	UEP0		; endpoint 0 is a control pipe and requires an ACK
	
	movlw	0x3B		; enable all interrupts except activity
	movwf	UIE
	
	movlw	0xFF		; enable all error interrupts
	movwf	UEIE
	
	movlw	DEFAULT_STATE
	movwf	USWSTAT

	banksel	EP1_nb_rec_packet
	clrf	EP1_nb_rec_packet
	clrf	EP1_nb_send_packet
	clrf	EP1_control_direction

	banksel USB_status_device
	;bcf 	STATUS,RP0	; select bank 2
	movlw	0x01
	movwf	USB_status_device ; Self powered, remote wakeup disabled
	;bcf 	STATUS,RP1	; bank 0

	;bsf 	STATUS,RP1
	banksel USB_status_device
	return  		; to keep straight with host controller tests

; ******************************************************************
; Enable Wakeup on interupt and Activity interrupt then put the 
; device to sleep to save power.  Activity on the D+/D- lines will
; set the ACTIVITY interrupt, waking up the part.
; ******************************************************************
USBSleep  ; starts from bank2
	;bsf 	STATUS, RP0	; up to bank 3
	banksel UIE
	bcf 	UIE,UIDLE
	bcf 	UIR,UIDLE
	bcf 	UIR,ACTIVITY
	bsf 	UIE,ACTIVITY
	bsf 	UCTRL, SUSPND
	banksel	PIR1		; switch to bank 0
	bcf	PIR1,USBIF

	;bsf	STATUS, RP1	; switch to bank 2
	banksel IS_IDLE
	bsf 	IS_IDLE, 0

	return

; ******************************************************************
; This is activated by the STALL bit in the UIR register.  It really
; just tells us that the SIE sent a STALL handshake.  So far, Don't 
; see that any action is required.  Clear the bit and move on.
; ******************************************************************
USBStall  ; starts in bank 2
	;bsf 	STATUS, RP0	; bank 3
	banksel UIR
	bcf 	UIR, STALL	; clear STALL

	banksel	PIR1		; switch to bank 0
	bcf	PIR1,USBIF
	;bsf	STATUS,RP1	; bank 2
	banksel USB_status_device
	return

 
; ******************************************************************
; The SIE detected an error.  This code increments the appropriate 
; error counter and clears the flag.
; ******************************************************************
USBError  ; starts in bank 2
	;bsf 	STATUS, RP0	; bank 3
	banksel UIR
	bcf 	UIR,UERR
	movf	UEIR,w		; get the error register
	andwf	UEIE,w		; mask with the enables
	clrf	UEIR
	banksel	PIR1		; switch to bank 0
	bcf 	PIR1,USBIF	; clear the USB interrupt flag.
	;bsf 	STATUS,RP1	; switch to bank 2
	banksel USB_status_device
	movwf	USBMaskedErrors	; save the masked errors	

#ifdef COUNTERRORS
	btfss	USBMaskedErrors,PID_ERR
	goto	CRC5Error
	INCREMENT16 USB_PID_ERR
CRC5Error
	btfss	USBMaskedErrors,CRC5
	goto	CRC16Error
	INCREMENT16 USB_CRC5_ERR
CRC16Error
	btfss	USBMaskedErrors,CRC16
	goto	DFN8Error
	INCREMENT16 USB_CRC16_ERR
DFN8Error
	btfss	USBMaskedErrors,DFN8
	goto	BTOError
	INCREMENT16 USB_DFN8_ERR
BTOError
	btfss	USBMaskedErrors,BTO_ERR
	goto	WRTError
	INCREMENT16 USB_BTO_ERR
WRTError
	btfss	USBMaskedErrors,WRT_ERR
	goto	OWNError
	INCREMENT16 USB_WRT_ERR
OWNError
	btfss	USBMaskedErrors,OWN_ERR
	goto	BTSError
	INCREMENT16 USB_OWN_ERR
BTSError
	btfss	USBMaskedErrors,BTS_ERR
	goto	EndError
	INCREMENT16 USB_BTS_ERR
EndError
#endif
	banksel	USBMaskedInterrupts 
	return

; ******************************************************************
; Service the Activity Interrupt.  This is only enabled when the
; device is put to sleep as a result of inactivity on the bus.  This
; code wakes up the part, disables the activity interrupt and reenables
; the idle interrupt.
; ******************************************************************
USBActivity  ; starts in bank 2
	;bsf 	STATUS, RP0	; Bank 3
	banksel UIE
	bcf 	UIE,ACTIVITY	; clear the Activity and Idle bits
	bcf 	UIR,ACTIVITY
	bcf 	UIR,UIDLE
	bsf 	UIE,UIDLE
	bcf 	UCTRL, SUSPND

	banksel	PIR1		; switch to bank 0
	bcf 	PIR1,USBIF	; clear the USB interrupt flag.
	;bsf 	STATUS,RP1	; switch to bank 2
	banksel USB_status_device

	clrf	IS_IDLE

	return

; ******************************************************************
; Process token done interrupt...  Most of the work gets done through
; this interrupt.  Token Done is signaled in response to an In, Out,
; or Setup transaction.
; ******************************************************************
TokenDone  ; starts in bank 2
	COPYBUFFERDESCRIPTOR	; copy BD from dual port to unbanked RAM
	banksel	USTAT
	movf	USTAT,w		; copy USTAT register before...
	bcf 	UIR,TOK_DNE	; clearing the token done interrupt.

	banksel	PIR1		; switch to bank 0
	bcf 	PIR1,USBIF	; clear the USB interrupt flag.
	;bsf 	STATUS,RP1	; switch to bank 2
	banksel USB_USTAT

	movwf	USB_USTAT	; Save USTAT 


; check UOWN bit here if desired
	movf	BufferDescriptor,w  ; get the first byte of the BD
	andlw	0x3c		; save the PIDs
	movwf	PIDs

	xorlw	TOKEN_IN
	pagesel	TokenInPID
	btfsc	STATUS,Z
	goto	TokenInPID

	movf	PIDs,w
	xorlw	TOKEN_OUT
	pagesel	TokenOutPID
	btfsc	STATUS,Z
	goto	TokenOutPID

	movf	PIDs,w
	xorlw	TOKEN_SETUP
	pagesel	TokenSetupPID
	btfsc	STATUS,Z
	goto	TokenSetupPID

	return  		; should never get here...

; ******************************************************************
; Process out tokens (data is sent by the host computer)
; For EP0, just turn the buffer around.  There should be no EP0 
; tokens to deal with.
; EP1 and EP2 have live data destined for the application
; ******************************************************************
TokenOutPID  ; STARTS IN BANK like USB_USTAT
	movf	USB_USTAT,w	; get the status register
	pagesel	tryEP1
	btfss	STATUS,Z	; was it EP0?
	goto	tryEP1 		; no, try EP1

	movf	USB_dev_req,w
	xorlw	HID_SET_REPORT
	pagesel	ResetEP0OutBuffer
	btfss	STATUS,Z
	goto	ResetEP0OutBuffer

HIDSetReport

; ******************************************************************
; You must write your own SET_REPORT routine.  The following 
; commented out code is provided if you desire to make a SET_REPORT
; look like a EP1 OUT Interrupt transfer.  Uncomment it and use it
; if you desire this functionality.
; ******************************************************************
;	movlw	0xFF
;	movwf	USB_dev_req	; clear the request type
;	banksel	BD1IST
;	movf	BD0OST,w
;	movwf	BD1OST		; Copy status register to EP1 Out
;	movf	BD0OAL,w	; get EP0 Out buffer address
;	bcf 	STATUS,RP0	; bank 2
;	movwf	hid_source_ptr
;	bsf 	STATUS,RP0	; bank 3
;	movf	BD1OAL,w	; get EP1 Out Buffer Address
;	bcf 	STATUS,RP0	; bank 2
;	movwf	hid_dest_ptr
;	bsf 	STATUS,RP0	; bank 3
;	movf	BD0OBC,w	; Get byte count
;	movwf	BD1OBC		; copy to EP1 Byte count
;	bcf 	STATUS,RP0	; bank 2
;	movwf	counter
;	bankisel BD1IST		; indirectly to bank 3
;HIDSRCopyLoop
;	movf	hid_source_ptr,w
;	movwf	FSR
;	movf	INDF,w
;	movwf	temp
;	movf	hid_dest_ptr,w
;	movwf	FSR
;	movf	temp,w
;	movwf	INDF
;	incf	hid_source_ptr,f
;	incf	hid_dest_ptr,f
;	decfsz	counter,f
;	goto	HIDSRCopyLoop
;
;	bsf 	STATUS,RP0	; bank 3
;	movlw	0x08
;	movwf	BD0OST		; REset EP0 Status back to SIE

ResetEP0OutBuffer
	;bsf 	STATUS,RP0	; no, just reset buffer and move on.
	banksel BD0OBC

	movlw	0x08		; it's EP0.. buffer already copied,
	movwf	BD0OBC		; just reset the buffer
	movlw	0x88
	movwf	BD0OST		; set OWN and DTS Bit
	pagesel	Send_0Len_pkt
	;bcf 	STATUS,RP0	; bank 2
	banksel USB_status_device
	goto	Send_0Len_pkt
	return

tryEP1  ; bank 3
	xorlw	0x08		; was it EP1?
	pagesel	tryEP2
	btfss	STATUS,Z
	goto	tryEP2

; **** Add Callout here to service EP1 in transactions.  ****
	bsf EP1_control_direction,3 ; a data is ready !
	return

tryEP2  ; bank 3
	movf	USB_USTAT,w
	xorlw	0x10		; was it EP2?
	btfsc	STATUS,Z
	return  		; unrecognized EP (Should never take this exit)

; **** Add Callout here to service EP2 in transactions.  ****
	return

; ******************************************************************
; Process in tokens (data is sent by the device)
; ******************************************************************
TokenInPID  ; starts in bank like USB_USTAT
; Assumes EP0 vars are setup in a previous call to setup.  
EP0_in
	movf	USB_USTAT,w	; get the status register
	andlw	0x18		; save only EP bits (we already know it's an IN)
	pagesel	tryEP1in
	btfss	STATUS,Z	; was it EP0?
	goto	tryEP1in	; no, try EP1

	movf	USB_dev_req,w
	xorlw	GET_DESCRIPTOR
	pagesel	check_GSD
	btfss	STATUS,Z
	goto	check_GSD
	pagesel	copy_descriptor_to_EP0
	call	copy_descriptor_to_EP0
	goto	exitEP0in

; Check for Get String Descriptor
check_GSD
	movf	USB_dev_req,w
	xorlw	GET_STRING_DESCRIPTOR
	pagesel	check_SA
	btfss	STATUS,Z
	goto	check_SA
	pagesel	copy_descriptor_to_EP0
	call	copy_descriptor_to_EP0
	pagesel	exitEP0in
	goto	exitEP0in

; Check for Set Address
check_SA
	movf	USB_dev_req,w
	xorlw	SET_ADDRESS
	pagesel	check_SF
	btfss	STATUS,Z
	goto	check_SF
	pagesel	finish_set_address
	call	finish_set_address
	pagesel	exitEP0in
	goto	exitEP0in

check_SF
	movf	USB_dev_req,w
	xorlw	SET_FEATURE
	pagesel	check_CF
	btfss	STATUS,Z
	goto	check_CF
	pagesel	exitEP0in
	goto	exitEP0in

check_CF
	movf	USB_dev_req,w
	xorlw	CLEAR_FEATURE
	pagesel	Class_Specific
	btfss	STATUS,Z
	goto	Class_Specific
	movf	BufferData+4, w	; clear endpoint 1 stall bit
	xorlw	1			
	pagesel	clear_EP2	
	btfss	STATUS,Z
	goto	clear_EP2
	;bsf 	STATUS, RP0	; bank 3
	banksel UEP1
	bsf 	UEP1, EP_STALL
	;bcf 	STATUS, RP0	; bank 2
	banksel USB_status_device
	pagesel	exitEP0in
	goto	exitEP0in
clear_EP2
	movf	BufferData+wIndex, w	; clear endpoint 2 stall bit
	xorlw	2
	pagesel	exitEP0in
	btfss	STATUS,Z
	goto	exitEP0in
	;bsf 	STATUS, RP0	; bank 3
	banksel UEP2
	bsf 	UEP2, EP_STALL
	;bcf 	STATUS, RP0	; bank 2
	banksel USB_status_device
	pagesel	exitEP0in
	goto	exitEP0in

Class_Specific
	pagesel	Check_Class_Specific_IN
	goto	Check_Class_Specific_IN

exitEP0in
	return


; ******************************************************************
; though not required, it might be nice to have a callback function here
; that would take some action like setting up the next buffer when the
; previous one is complete.  Not necessary because the same functionality
; can be provided through the PutUSB call.  
; ******************************************************************
tryEP1in  ; starts in bank banksel USB_status_device
	xorlw	0x08		; was it EP1?
	pagesel	tryEP1in
	btfss	STATUS,Z
	goto	tryEP2in
; **** Add Callout here to service EP1 in transactions.  ****
	bsf EP1_control_direction,2 ; a data is requiered !
	return

tryEP2in  ; starts in bank banksel USB_status_device
; **** Add Callout here to service EP2 in transactions.  ****
	return
; ******************************************************************
; Return a zero length packet on EP0 In
; ******************************************************************
Send_0Len_pkt
	global	Send_0Len_pkt

	banksel	BD0IBC
	clrf	BD0IBC		; set byte count to 0
	movlw	0xc8
	movwf	BD0IST		; set owns bit
	;bcf	STATUS,RP0	; back to bank 2
	banksel USB_status_device
	clrf	USB_dev_req
	return

; ********************************************************************
; process setup tokens
; ******************************************************************

TokenSetupPID  ; starts in bank banksel USB_status_device
	;bsf 	STATUS,IRP	; indirectly to pages 2-3
	bankisel BD0OBC
	movf	BufferDescriptor+ADDRESS,w ; get the status register
	movwf	FSR ; save in the FSR.
	movf	INDF,w
	movwf	BufferData	; in shared RAM
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+1
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+2
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+3
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+4
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+5
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+6
	incf	FSR,f
	movf	INDF,w
	movwf	BufferData+7

	movf	USB_USTAT,w	; get the status register
	andlw	0x18		; save only EP bits (we already know it's an IN)
	pagesel	TokenSetupEP1
	btfss	STATUS,Z	; was it EP0?
	goto	TokenSetupEP1	; no, try EP1

	;bsf 	STATUS, RP0	; bank 3
	banksel BD0OBC
	movlw	0x08
	movwf	BD0OBC		; reset the byte count too.
	movwf	BD0IST		; return the in buffer to us (dequeue any pending requests)
	;bcf 	STATUS, RP0	; bank 2
	banksel USB_status_device
	movf	BufferData+bmRequestType, w
	xorlw	HID_SET_REPORT	; set EP0 OUT UOWNs back to SIE
	movlw	0x88		; set DATA0/DATA1 packet according to request type
	btfsc	STATUS, Z
	movlw	0xC8
	;bsf 	STATUS, RP0	; bank 3
	banksel BD0OST
	movwf	BD0OST		

	bcf 	UCTRL,PKT_DIS	; Assuming there is nothing to dequeue, clear the packet disable bit

	;bcf 	STATUS,RP0	; bank 2
	banksel USB_status_device
	clrf	USB_dev_req	; clear the device request..

	movf	BufferData+bmRequestType,w
	pagesel	HostToDevice
	btfsc	STATUS,Z
	goto	HostToDevice

	movf	BufferData+bmRequestType,w
	xorlw	0x01		; test for host to Interface tokens
	pagesel	HostToInterface
	btfsc	STATUS,Z
	goto	HostToInterface

	movf	BufferData+bmRequestType,w
	xorlw	0x02		; test for host to Endpoint tokens
	pagesel	HostToEndpoint
	btfsc	STATUS,Z
	goto	HostToEndpoint

	movf	BufferData+bmRequestType,w
	xorlw	0x80		; test for device to Host tokens
	pagesel	DeviceToHost
	btfsc	STATUS,Z
	goto	DeviceToHost
 
	movf	BufferData+bmRequestType,w
	xorlw	0x81		; test for device to Interface tokens
	pagesel	InterfaceToHost
	btfsc	STATUS,Z
	goto	InterfaceToHost

	movf	BufferData+bmRequestType,w
	xorlw	0x82		; test for device to Endpoint tokens
	pagesel	EndpointToHost
	btfsc	STATUS,Z
	goto	EndpointToHost

	movf	BufferData+bmRequestType,w
	andlw	0x60		; mask off type bits
	xorlw	0x20		; test for class specific
	pagesel	ClassSpecificRequest
	btfsc	STATUS,Z	; was it a standard request?
	goto	ClassSpecificRequest ; nope, see if it was a class specific request

CheckForVendorRequest
	movf	BufferData+bmRequestType,w
	andlw	0x60		; mask off type bits
	xorlw	0x40		; test for vendor specific
	pagesel	wrongstate
	btfss	STATUS,Z	; was it a standard request?
	goto	wrongstate
	pagesel	CheckVendor
	goto	CheckVendor	; nope, see if it was a vendor specific
	return

TokenSetupEP1:

	banksel UIR
	bcf 	UIR,TOK_DNE	; hit this 4 times to clear out the
	bcf 	UIR,TOK_DNE	; USTAT FIFO
	bcf 	UIR,TOK_DNE
	bcf 	UIR,TOK_DNE

	banksel BD1OST

	movf	BD1OST,w
	andlw	0x40		; save only the data 0/1 bit
	xorlw	0x40		; toggle the data o/1 bit
	iorlw	0x80		; set owns bit and DTS bit

	;movlw	0x88		; set DATA0/DATA1 packet according to request type
	movwf	BD1OST

	movlw	0x08		; reset byte counter
	movwf	BD1OBC
	movwf	BD1IST		; return the in buffer to us (dequeue any pending requests)

	bcf 	UCTRL,PKT_DIS	; Assuming there is nothing to dequeue, clear the packet disable bit
	
	banksel EP1_nb_rec_packet
	clrf 	EP1_nb_rec_packet
	clrf 	EP1_nb_send_packet
	clrf	EP1_control_direction

	btfsc	BufferData,7
	bsf		EP1_control_direction,1
	btfss	BufferData,7
	bsf		EP1_control_direction,0
	

	banksel BufferData

	pagesel TokenSetupEP1Read
	btfsc 	BufferData,7
	goto 	TokenSetupEP1Read
	pagesel TokenSetupEP1Write

TokenSetupEP1Write:
	movf 	BufferData+6,w	; nb bytes to be recieved Low
	andlw 	0x07			; we reicve byte by 8 bytes packet
	btfss 	STATUS,Z
	bsf 	EP1_nb_rec_packet, 0 ; the last one will be padded!
	rrf 	BufferData+6,f	; divide by 8
	rrf 	BufferData+6,f
	rrf 	BufferData+6,w
	andlw	0x1F
	addwf	EP1_nb_rec_packet,f
 	movf 	BufferData+7,w
	andlw 	0x07
	movwf	BufferData+7	; nb bytes to be recieved High
	rlf		BufferData+7,f  ; multiply by 32
	rlf		BufferData+7,f
	rlf		BufferData+7,f
	rlf		BufferData+7,f
	rlf		BufferData+7,w	
	andlw	0xE0
	addwf	EP1_nb_rec_packet,f ; ok, now we know how many packet will be recieved
	return

TokenSetupEP1Read:
	movf 	BufferData+6,w	; nb bytes to be sent Low
	andlw 	0x07			; we send bytes by 8 bytes packets
	btfss 	STATUS,Z
	bsf 	EP1_nb_send_packet, 0 ; the last one will not be full
	rrf 	BufferData+6,f		; divide by 8
	rrf 	BufferData+6,f
	rrf 	BufferData+6,w
	andlw	0x1F
	addwf	EP1_nb_send_packet,f ; add to the number of packet to be sent
 	movf 	BufferData+7,w
	andlw 	0x07
	movwf	BufferData+7	; nb bytes to be sent High
	rlf		BufferData+7,f  ; divide by 8 and multiply by 256 = * 32
	rlf		BufferData+7,f
	rlf		BufferData+7,f
	rlf		BufferData+7,f
	rlf		BufferData+7,w
	andlw	0xE0
	addwf	EP1_nb_send_packet,f  ; now we have the number of packet to be sent


	return

TokenSetupEP1Abort:
	banksel	BD1IBC
	clrf	BD1IBC		; set byte count to 0
	movlw	0xc8
	movwf	BD1IST		; set owns bit
	return

; now test bRequest to see what the request was.

CheckForStandardRequest
; bmRequestType told us it was a Host to Device transfer.  Now look at
; the specifics to see what's up
HostToDevice  ; starts in bank 2
	movf	BufferData+bRequest,w ; what was our request
	xorlw	CLEAR_FEATURE
	pagesel	Clear_Device_Feature
	btfsc	STATUS,Z
	goto	Clear_Device_Feature

	movf	BufferData+bRequest,w ; was our request Set Address
	xorlw	SET_ADDRESS
	pagesel	Set_Address
	btfsc	STATUS,Z
	goto	Set_Address

	movf	BufferData+bRequest,w ; was our request Set Configuration
	xorlw	SET_CONFIGURATION
	pagesel	Set_Configuration
	btfsc	STATUS,Z
	goto	Set_Configuration
	
	movf	BufferData+bRequest,w ; was our request Set Feature
	xorlw	SET_FEATURE
	pagesel	Set_Device_Feature
	btfsc	STATUS,Z
	goto	Set_Device_Feature

	pagesel	wrongstate
	goto	wrongstate

HostToInterface  ; starts in bank banksel USB_status_device
	movf	BufferData+bRequest,w ; what was our request
	xorlw	CLEAR_FEATURE 
	pagesel	Clear_Interface_Feature
	btfsc	STATUS,Z
	goto	Clear_Interface_Feature

	movf	BufferData+bRequest,w ; was our request Set Interface
	xorlw	SET_INTERFACE
	pagesel	Set_Interface
	btfsc	STATUS,Z
	goto	Set_Interface

	movf	BufferData+bRequest,w ; was our request Set Feature
	xorlw	SET_FEATURE
	pagesel	Set_Interface_Feature
	btfsc	STATUS,Z
	goto	Set_Interface_Feature

	pagesel	wrongstate
	goto	wrongstate

HostToEndpoint  ; starts in banksel USB_status_device
	movf	BufferData+bRequest,w ; what was our request
	xorlw	CLEAR_FEATURE
	pagesel	Clear_Endpoint_Feature
	btfsc	STATUS,Z
	goto	Clear_Endpoint_Feature

	movf	BufferData+bRequest,w ; was our request Set Feature
	xorlw	SET_FEATURE
	pagesel	Set_Endpoint_Feature
	btfsc	STATUS,Z
	goto	Set_Endpoint_Feature

DeviceToHost  ; starts in banksel USB_status_device
	movf	BufferData+bRequest,w ; what was our request
	xorlw	GET_CONFIGURATION
	pagesel	Get_Configuration
	btfsc	STATUS,Z
	goto	Get_Configuration

	movf	BufferData+bRequest,w ; was our request Get Decriptor?
	xorlw	GET_DESCRIPTOR
	pagesel	Get_Descriptor
	btfsc	STATUS,Z
	goto	Get_Descriptor

	movf	BufferData+bRequest,w ; was our request Get Status?
	xorlw	GET_STATUS
	pagesel	Get_Device_Status
	btfsc	STATUS,Z
	goto	Get_Device_Status

InterfaceToHost  ; starts in bank banksel USB_status_device
	movf	BufferData+bRequest,w ; was our request Get Interface?
	xorlw	GET_INTERFACE
	pagesel	Get_Interface
	btfsc	STATUS,Z
	goto	Get_Interface

	movf	BufferData+bRequest,w ; was our request Get Status?
	xorlw	GET_STATUS
	pagesel	Get_Interface_Status
	btfsc	STATUS,Z
	goto	Get_Interface_Status

	movf	BufferData+bRequest,w ; was our request Get Decriptor?
	xorlw	GET_DESCRIPTOR
	pagesel	Get_Descriptor
	btfsc	STATUS,Z
	goto	Get_Descriptor

EndpointToHost  ; starts in banksel USB_status_device
	movf	BufferData+bRequest,w ; was our request Get Status?
	xorlw	GET_STATUS
	pagesel	Get_Endpoint_Status
	btfsc	STATUS,Z
	goto	Get_Endpoint_Status

	pagesel	wrongstate	; unrecognised token, stall EP0
	goto	wrongstate

	return

; ******************************************************************
; Get Descriptor
; Handles the three different Get Descriptor commands
; ******************************************************************
Get_Descriptor  ; starts in bank2

GetCh9Descriptor
	movlw	high StartGDIndex ; set up PCLATH with the current address
	movwf	PCLATH		; set up pclath for the computed goto
	bcf 	STATUS, C
	movf	BufferData+(wValue+1),w	; move descriptor type into w
	andlw	0x03		; keep things under control
	addlw	low StartGDIndex
	btfsc	STATUS,C	; was there an overflow?
	incf	PCLATH,f	; yes, bump PCLATH
	movwf	PCL		; adjust PC
StartGDIndex						
	goto	wrongstate	; 0
	goto	Get_Device_Descriptor ; 1
	goto	Get_Config_Descriptor ; 2
	goto	Get_String_Descriptor ; 3


; *********************************************************************
; Looks up the offset of the device descriptor via the low order byte
; of wValue.  The pointers are set up and the data is copied to the 
; buffer, then the flags are set.
;
; EP0_start points to the first word to transfer
; EP0_end points to the last, limited to the least of the message length
; or the number of bytes requested in the message (wLength).
; EP0_maxLength is the number of bytes to transfer at a time, 8 bytes
; ******************************************************************
Get_Device_Descriptor  ; starts in bank banksel USB_status_device
	movlw	GET_DESCRIPTOR
	movwf	USB_dev_req	; currently processing a get descriptor request
	
	movlw	8
	movwf	EP0_maxLength

	movlw	low DeviceDescriptor
	movwf	EP0_start
	movlw	high DeviceDescriptor
	movwf	EP0_start+1
	pagesel	Descriptions
	call	Descriptions	; get length of device descriptor
	movwf	EP0_end		; save length

	movf	BufferData+(wLength+1),f ; move it to itself, check for non zero.
	pagesel	DeviceEndPtr
	btfss	STATUS,Z	; if zero, we need to compare EP0_end to requested length.
	goto	DeviceEndPtr	; if not, no need to compare.  EP0_end is shorter than request length

	subwf	BufferData+wLength,w ; compare against requested length
	movf	BufferData+wLength,w
	btfss	STATUS,C
	movwf	EP0_end

DeviceEndPtr
	incf	EP0_end,f
	pagesel	copy_descriptor_to_EP0
	call	copy_descriptor_to_EP0

	return


; *********************************************************************
; Looks up the offset of the config descriptor via the low order byte
; of wValue.  The pointers are set up and the data is copied to the 
; buffer, then the flags are set.
;
; EP0_start points to the first word to transfer
; EP0_end points to the last, limited to the least of the message length
; or the number of bytes requested in the message (wLength).
; EP0_maxLength is the number of bytes to transfer at a time, 8 bytes
; ******************************************************************
Get_Config_Descriptor  ; starts in bank2
	movlw	GET_DESCRIPTOR
	movwf	USB_dev_req	; currently processing a get descriptor request

	bcf 	STATUS,C
	rlf 	BufferData+wValue,w
	pagesel	Config_desc_index
	call	Config_desc_index ; translate index to offset into descriptor table
	movwf	EP0_start
	bcf 	STATUS,C
	rlf 	BufferData+wValue,w
	addlw	1		; point to high order byte
	call	Config_desc_index ; translate index to offset into descriptor table
	movwf	EP0_start+1

	movlw	2		; bump pointer by 2 to get the complete descriptor 
	addwf	EP0_start,f	; length, not just config descriptor
	btfsc	STATUS,C
	incf	EP0_start+1,f
	pagesel	Descriptions
	call	Descriptions	; get length of the config descriptor
	movwf	EP0_end 	; Get message length

	movlw	2		; move EP0_start pointer back to beginning
	subwf	EP0_start,f
	btfss	STATUS,C
	decf	EP0_start+1,f

	movf	BufferData+(wLength+1),f ; test for 0
	pagesel	CmpLowerByte
	btfsc	STATUS,Z
	goto	CmpLowerByte
	pagesel	ConfigEndPtr
	goto	ConfigEndPtr	; if not, no need to compare.  EP0_end is shorter than request length

CmpLowerByte
	movf	EP0_end,w
	subwf	BufferData+wLength,w ; compare against requested length
	pagesel	ConfigEndPtr
	btfsc	STATUS,C
	goto	ConfigEndPtr
LimitSize
	movf	BufferData+wLength,w ; if requested length is shorter..
	movwf	EP0_end		; save it.
ConfigEndPtr

	movlw	8
	movwf	EP0_maxLength
	incf	EP0_end,f

	pagesel	copy_descriptor_to_EP0
	call	copy_descriptor_to_EP0
	return

; ******************************************************************
; Set up to return String descriptors
; Looks up the offset of the string descriptor via the low order byte
; of wValue.  The pointers are set up and the data is copied to the 
; buffer, then the flags are set.
; ******************************************************************
Get_String_Descriptor  ; starts in bank2
	movlw	GET_STRING_DESCRIPTOR
	movwf	USB_dev_req	; currently processing a get descriptor request

	movf	BufferData+wIndex,w
	pagesel	not_string0
	btfss	STATUS,Z
	goto	not_string0
	movf	BufferData+(wIndex+1),w
	btfss	STATUS,Z
	goto	not_string0
	movlw	low String0
	movwf	EP0_start
	movlw	high String0
	movwf	EP0_start+1
	pagesel	found_string
	goto	found_string

not_string0
	movlw	high (String0+2)
	movwf	EP0_start+1
	movlw	low (String0+2)
	movwf	EP0_start
	clrf	inner

check_langid
	pagesel	StringDescriptions
	call	StringDescriptions
	incf	EP0_start,f
	subwf	BufferData+wIndex, w
	pagesel	wrong_langid 
	btfss	STATUS, Z
	goto	wrong_langid
	pagesel	StringDescriptions
	call	StringDescriptions
	subwf	BufferData+(wIndex+1), w
	pagesel	right_langid 
	btfsc	STATUS, Z
	goto	right_langid

wrong_langid
	incf	EP0_start,f
	incf	inner,f
	movlw	low String0_end	; compare EP0_start to the addr of
	subwf	EP0_start,w	; the last langid
	pagesel	check_langid
	btfss	STATUS,C	; if EP0_start is equal or lager,
	goto	check_langid	; we've checked all langid and didn't find it
	clrf	USB_dev_req	; clear USB_dev_req, since GET_descriptor is over
	pagesel	wrongstate
	goto	wrongstate

right_langid
	movlw	6		; number of strings we have per language + 1
	subwf	BufferData+wValue,w
	pagesel	right_string
	btfss	STATUS,C
	goto	right_string
	clrf	USB_dev_req
	pagesel	wrongstate
	goto	wrongstate

right_string
	rlf 	BufferData+wValue,w
	movwf	EP0_start+1
	movf	inner,w
	pagesel	string_index
	call	string_index
	movwf	EP0_start
	incf	EP0_start+1,f
	movf	inner,w
	call	string_index
	movwf	EP0_start+1

found_string
	pagesel	StringDescriptions
	call	StringDescriptions ; get length of the string descriptor
	movwf	EP0_end		; save length
	
	subwf	BufferData+wLength,w ; compare against requested length
	movf	BufferData+wLength,w ; if requested length is shorter..
	btfss	STATUS,C
	movwf	EP0_end		; save it.

	movlw	8		; each transfer may be 8 bytes long
	movwf	EP0_maxLength

	incf	EP0_end,f
	pagesel	copy_descriptor_to_EP0
	call	copy_descriptor_to_EP0
	return

; ******************************************************************
; Stalls the EP0 endpoint to signal that the command was not recognised.
; This gets reset as the result of a Setup Transaction.
; ******************************************************************
wrongstate
	global	wrongstate

	banksel	UEP0
	bsf	UEP0,EP_STALL
	;bcf	STATUS,RP0	; back to page 2
	banksel USB_status_device
	return

; ******************************************************************
; Loads the device status byte into the EP0 In Buffer.
; ******************************************************************
Get_Device_Status  ; starts in bank banksel USB_status_device
	;bsf 	STATUS,RP0
	banksel BD0IAL
	movf	BD0IAL,w	; get buffer pointer
	movwf	FSR
	;bcf 	STATUS,RP0	; bank 2
	banksel USB_status_device
	;bsf 	STATUS,IRP	; select indirectly banks 2-3
	bankisel BD0IAL
	movf	USB_status_device,w ; get device status byte
	movwf	INDF
	incf	FSR,f
	clrf	INDF

	;bsf 	STATUS,RP0	; bank 3
	banksel BD0IBC
	movlw	0x02
	movwf	BD0IBC		; set byte count to 2
	movlw	0xC8
	movwf	BD0IST		; Data 1 packet, set owns bit
	return

; ******************************************************************
; A do nothing response.  Always returns a two byte record, with all
; bits zero.
; ******************************************************************
Get_Interface_Status ; starts in bank banksel USB_status_device
	;bsf 	STATUS, RP0	; bank 3
	banksel USWSTAT
	movf	USWSTAT,w
	xorlw	ADDRESS_STATE
	pagesel	Get_Interface_Status2
	btfss	STATUS, Z
	goto	Get_Interface_Status2
	
	banksel USB_status_device
	;bcf 	STATUS, RP0	; bank 2
	movf	BufferData+wIndex, w
	pagesel	Get_Interface_Status2
	btfss	STATUS, Z
	goto	Get_Interface_Status2

Get_Interface_Status2
	;bsf 	STATUS, RP0	; bank3
	banksel USWSTAT
	movf	USWSTAT,w
	xorlw	CONFIG_STATE
	pagesel	wrongstate
	btfss	STATUS, Z
	goto	wrongstate
	
	;bcf 	STATUS, RP0
	banksel USB_status_device
	movf	BufferData+wIndex,w ; if Interface < NUM_INTERFACES
	sublw	(NUM_INTERFACES-1)
	pagesel	wrongstate
	btfss	STATUS, C
	goto	wrongstate

Get_Interface_Status_end
	movf	BufferData+wIndex,w ; get interface ID
	addlw	low USB_Interface
	movwf	FSR
	;bcf 	STATUS,IRP 	; USB_Interface is in bank 0 !
	bankisel USB_Interface
	movf	INDF,w
	movwf	temp		; store in temp register

	;bsf 	STATUS,RP0	; bank3
	banksel BD0IAL
	movf	BD0IAL,w	; get address of buffer
	movwf	FSR
	;bsf 	STATUS,IRP 	; buffer is in bank 3 !
	bankisel BD0IAL
	movf	temp,w		; load temp
	movwf	INDF		; write byte to buffer
	
	movlw	0x02
	movwf	BD0IBC		; set byte count to 2
	movlw	0xc8		; DATA1 packet, DTS enabled
	movwf	BD0IST		; give buffer back to SIE
	return	

; ******************************************************************
; Returns the Endpoint stall bit via a 2 byte in buffer
; ******************************************************************
Get_Endpoint_Status  ; starts in bank banksel USB_status_device
	movlw	0x0f
	andwf	BufferData+wIndex,w ; get endpoint, strip off direction bit
	xorlw	0x01		; is it EP1?
	pagesel	get_EP1_status
	btfsc	STATUS,Z
	goto	get_EP1_status

	movlw	0x0f
	andwf	BufferData+wIndex,w ; get endpoint, strip off direction bit
	xorlw	0x02		; is it EP2?
	pagesel	wrongstate
	btfss	STATUS,Z
	goto	wrongstate

get_EP2_status
	bcf 	STATUS,C
	;bsf 	STATUS,RP0
	banksel UEP2
	btfsc	UEP2,EP_STALL
	bsf 	STATUS,C
	pagesel	build_status_buffer
	goto	build_status_buffer

get_EP1_status
	bcf 	STATUS,C
	;bsf 	STATUS,RP0
	banksel UEP1
	btfsc	UEP1,EP_STALL
	bsf 	STATUS,C
 
build_status_buffer
	;bsf		STATUS, IRP	; buffer is in bank 3!
	bankisel BD0IAL
	movf	BD0IAL,w	; get address of buffer
	movwf	FSR
	clrf	INDF		; clear byte 0 in buffer
	rlf 	INDF,f		; rotate in carry bit (EP_stall bit)
	incf	FSR,f		; bump pointer
	clrf	INDF		; clear byte

	movlw	0x02
	movwf	BD0IBC		; set byte count to 2
	movlw	0xC8
	movwf	BD0IST		; Data 1 packet, set owns bit
	return

; *********************************************************************
; The low order byte of wValue now has the new device address as assigned
; from the host.  Save it in the UADDR, transition to the ADDRESSED state
; and clear the current configuration.
; This assumes the SIE has already sent the status stage of the transaction
; as implied by Figure 3-35 of the DOS (Rev A-7)
; ******************************************************************
Set_Address  ; starts in bank banksel USB_status_device
	movf	BufferData+wValue,w ; new address in low order byte of wValue
	movwf	USB_address_pending
	pagesel	wrongstate
	btfsc	USB_address_pending, 7
	goto	wrongstate
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt	; send zero length packet
	movlw	SET_ADDRESS
	movwf	USB_dev_req	; currently processing a get descriptor request
	return

finish_set_address  ; starts in bank 2
	clrf	USB_dev_req	; no request pending
	clrf	USB_Curr_Config	; make sure current configuration is 0
	movf	USB_address_pending,w
	;bsf 	STATUS, RP0
	banksel UADDR
	movwf	UADDR		; set the device address
	pagesel	endfinishsetaddr
	btfsc	STATUS,Z	; was address 0?
	goto	endfinishsetaddr ; yes: don't change state

	movlw	ADDRESS_STATE	; non-zero: transition to addressed state
	movwf	USWSTAT		; transition to addressed state

endfinishsetaddr
	return

; ******************************************************************
; only feature valid for device feature is Device Remote wakeup
; ******************************************************************
Clear_Device_Feature  ; starts in bank banksel USB_status_device
	movf	BufferData+wValue,w
	xorlw	0x01		; was it a Device Remote wakeup? If not, return STALL,
	pagesel	wrongstate
	btfss	STATUS,Z	; since we only implement this feature on this device.
	goto	wrongstate

right_state_clear_feature
	bcf	USB_status_device,1 ; set device remote wakeup
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

; ******************************************************************
; Only endpoint feature is Endpoint halt.
; ******************************************************************
Clear_Endpoint_Feature  ; starts in bank 2
	movf	BufferData+wValue, w
	pagesel	wrongstate
	btfss	STATUS, Z	; only valid feature is 0 (Remote Wakeup)
	goto	wrongstate
	movf	BufferData+(wValue+1), w
	btfss	STATUS, Z
	goto	wrongstate

	;bsf 	STATUS, RP0	; bank3
	banksel USWSTAT
	movlw	0x03		; if ((USWSTAT & 0x03) == ADDRESS_STATE)
	andwf	USWSTAT, w			
	xorlw	ADDRESS_STATE
	pagesel clear_endpoint_feature2
	btfss	STATUS, Z
	goto	clear_endpoint_feature2
	;bcf 	STATUS, RP0	; bank2
	banksel USB_status_device
	movlw	0x0F		; if ((Bufferdata+wIndex & 0x07) = 0)
	andwf	BufferData+wIndex, w
	btfss 	STATUS, Z
	goto	clear_endpoint_feature2	
	;bsf 	STATUS, RP0	; bank 3
	banksel UEP0
	bcf 	UEP0, 0			
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

clear_endpoint_feature2
	;bsf 	STATUS, RP0
	banksel USWSTAT
	movlw	0x03		; if ((USWSTAT & 0X03) == CONFIG_STATE)
	andwf	USWSTAT, w
	xorlw	CONFIG_STATE
	pagesel wrongstate
	btfss	STATUS, Z
	goto	wrongstate
	;bcf 	STATUS, RP0	; bank2
	banksel USB_status_device
	movlw	0x0F
	andwf	BufferData+wIndex, w ; if (BufferData+wIndex < 3)
	sublw	2
	pagesel wrongstate
	btfss	STATUS, C	
	goto	wrongstate
	;bsf 	STATUS, IRP ; UEP0 is in bank 3!
	bankisel UEP0
	movlw	0x0F
	andwf	BufferData+wIndex,w
	;bsf 	STATUS, RP0 	; bank3
	banksel UEP0
	addlw	UEP0&0xFF
	movwf	FSR
	bcf 	INDF, 0
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

Clear_Interface_Feature ; starts in bankbanksel USB_status_device
	pagesel	wrongstate
	goto	wrongstate

; ******************************************************************
; only feature valid for device feature is Device Remote wakeup
; ******************************************************************
Set_Device_Feature  ; starts in bank banksel USB_status_device
	movf	BufferData+wValue,w ; get high order byte of wValue
	xorlw	0x01		; was it a Device Remote wakeup?
	pagesel	wrongstate
	btfss	STATUS,Z
	goto	wrongstate	; request error
	bsf 	USB_status_device,1 ; set device remote wakeup
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

; ******************************************************************
; Only endpoint feature is Endpoint halt.
; ******************************************************************
Set_Endpoint_Feature  ; starts in bank banksel USB_status_device
	movf	BufferData+wValue, w
	pagesel	wrongstate
	btfss	STATUS, Z	; only valid feature is 0 (Remote Wakeup)
	goto	wrongstate
	movf	BufferData+(wValue+1), w
	btfss	STATUS, Z
	goto	wrongstate

	;bsf 	STATUS, RP0	; bank3
	banksel USWSTAT
	movlw	0x03		; if ((USWSTAT & 0x03) == ADDRESS_STATE)
	andwf	USWSTAT, w			
	xorlw	ADDRESS_STATE
	pagesel set_endpoint_feature2
	btfss	STATUS, Z
	goto	set_endpoint_feature2
	;bcf 	STATUS, RP0	; bank2
	banksel USB_status_device
	movlw	0x0F		; if ((Bufferdata+wIndex & 0x07) = 0)
	andwf	BufferData+wIndex, w
	btfss 	STATUS, Z
	goto	set_endpoint_feature2	
	;bsf 	STATUS, RP0	; bank 3
	banksel UEP0
	bsf 	UEP0, 0			
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

set_endpoint_feature2
	;bsf 	STATUS, RP0
	banksel USWSTAT
	movlw	0x03		; if ((USWSTAT & 0X03) == CONFIG_STATE)
	andwf	USWSTAT, w
	xorlw	CONFIG_STATE
	pagesel wrongstate
	btfss	STATUS, Z
	goto	wrongstate
	;bcf 	STATUS, RP0	; bank2
	banksel USB_status_device
	movlw	0x0F
	andwf	BufferData+wIndex, w ; if (BufferData+wIndex < 3)
	sublw	2
	pagesel wrongstate
	btfss	STATUS, C	
	goto	wrongstate
	;bsf 	STATUS, IRP ; UEP0 is in bank 3
	bankisel UEP0
	movlw	0x0F
	andwf	BufferData+wIndex,w
	banksel UEP0
	;bsf 	STATUS, RP0 	; bank3
	addlw	UEP0&0xFF
	movwf	FSR
	bsf 	INDF, 0
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

Set_Interface_Feature; starts in bank 2
	pagesel	wrongstate
	goto	wrongstate	; invalid request

; ********************************************************************
; Get configuration returns a single byte Data1 packet indicating the 
; configuration in use.
; Default State- undefined
; Addressed State  - returns 0
; Configured state - returns current configured state.
; ******************************************************************
Get_Configuration  ; starts in bank banksel USB_status_device
	;bsf 	STATUS, RP0
	banksel BD0IAL
	movf	low BD0IAL,w	; get address of buffer
	movwf	FSR
	banksel USB_status_device
	;bcf 	STATUS, RP0
	;bsf 	STATUS,IRP	; indirectly to banks 2-3
	bankisel BD0IAL
	movf	USB_Curr_Config,w
	movwf	INDF		; write byte to buffer
	;bsf 	STATUS, RP0
	banksel BD0IBC
	movlw	0x01
	movwf	BD0IBC		; set byte count to 1
	movlw	0xc8		; DATA1 packet, DTS enabled
	movwf	BD0IST		; give buffer back to SIE
	return

; ******************************************************************
; Set configuration uses the configuration selected by the low order
; byte of wValue.  Sets up a zero length data1 packet as a reply.
; ******************************************************************
Set_Configuration  ; starts in bank 2
; All we do is set a meaningless number.  This'll 
; need more code here to actually give meaning to each configuration
; we choose.
	movf	BufferData+wValue,w ; is it a valid configuration?
	sublw	NUM_CONFIGURATIONS
	pagesel	wrongstate
	btfss	STATUS,C	; if config <= num configs, request appears valid
	goto	wrongstate

	movf	BufferData+wValue,w
	movwf	USB_Curr_Config	; store new state in configuration

	pagesel	AckSetConfigCmd
	btfsc	STATUS,Z	; was the configuration zero?
	goto	AckSetConfigCmd	; yes: stay in the addressed state

	banksel USWSTAT
	;bsf 	STATUS, RP0 	; bank 3
	movlw	CONFIG_STATE	; No: transition to configured
	movwf	USWSTAT		; save new state.

AckSetConfigCmd
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt

; These configure the EP1 and EP2  endpoints.  Change these as necessary
; for your application.
	banksel	BD1OAL
	movlw	USB_Buffer+0x10	; Endpoint 1 OUT gets a buffer
	movwf	BD1OAL		; set up buffer address
	movlw	8
	movwf	BD1OBC		; set byte count
	movlw	0x88		; set own bit of EP1 (SIE can write)
	movwf	BD1OST

	movlw	8	
	movwf	BD1IBC		; set byte count
	movlw	USB_Buffer+0x18	; Endpoint 1 IN gets a buffer
	movwf	BD1IAL		; set up buffer address
	movlw	0x48		; set own bit of EP1 (PIC can write)
	movwf	BD1IST

	movlw	USB_Buffer+0x20	; Endpoint 2 OUT gets a buffer
	movwf	BD2OAL		; set up buffer address
	movlw	8
	movwf	BD2OBC		; set byte count
	movlw	0x88		; set own bit of EP2 (SIE can write)
	movwf	BD2OST

	movlw	8	
	movwf	BD2IBC		; set byte count
	movlw	USB_Buffer+0x20	; EP1 In and EP2 In share a buffer
	movwf	BD2IAL		; set up buffer address
	movlw	0x48		; set own bit of EP2 (PIC can write)
	movwf	BD2IST
; Set up the Endpoint Control Registers.  The following patterns are defined
; ENDPT_DISABLED - endpoint not used
; ENDPT_IN_ONLY  - endpoint supports IN transactions only
; ENDPT_OUT_ONLY - endpoint supports OUT transactions only
; ENDPT_CONTROL - Supports IN, OUT and CONTROL transactions - Only use with EP0
; ENDPT_NON_CONTROL - Supports both IN and OUT transactions
	movlw	ENDPT_CONTROL
	movwf	UEP1		; enable EP's 1 and 2 for In and Outs...
	movlw	ENDPT_DISABLED
	movwf	UEP2

;pagesel SetConfiguration; call SetConfiguration etc. after configuration changed
;movfUSB_Curr_Config,w; if you have multiple configurations
;callSetConfiguration
;pagesel Set_Configuration
	return


; ********************************************************************
; Get interface returns a single byte Data1 packet indicating the 
; interface in use.
; Default State- undefined
; Addressed State  - Not valid - returns stall
; Configured state - returns current configured state.
; ******************************************************************
Get_Interface  ; STARTS IN BANK banksel USB_status_device
	;bsf 	STATUS, RP0
	banksel USWSTAT
	movf	USWSTAT,w	; Only valid in the configured state
	xorlw	CONFIG_STATE
	pagesel	wrongstate
	btfss	STATUS, Z
	goto	wrongstate

	;bcf 	STATUS, RP0
	banksel USB_status_device
	movf	BufferData+wIndex,w ; if Interface < NUM_INTERFACES
	sublw	(NUM_INTERFACES-1)
	pagesel	wrongstate
	btfss	STATUS, C
	goto	wrongstate

	movf	BufferData+wIndex,w ; get interface ID
	addlw	low USB_Interface
	movwf	FSR
	;bcf 	STATUS,IRP ; USB_Interface is in bank 0
	bankisel USB_Interface
	movf	INDF,w
	movwf	temp		; store in temp register

	;bsf 	STATUS,RP0	; bank 3
	banksel BD0IAL
	movf	BD0IAL,w	; get address of buffer
	;bsf 	STATUS,IRP ; buffer is in bank 3
	bankisel BD0IAL
	movwf	FSR
	movf	temp,w		; load temp
	movwf	INDF		; write byte to buffer

	movlw	0x01
	movwf	BD0IBC		; set byte count to 1
	movlw	0xc8		; DATA1 packet, DTS enabled
	movwf	BD0IST		; give buffer back to SIE
	return

; ******************************************************************
; Set configuration uses the configuration selected by the low order
; byte of wValue.  Sets up a zero length data1 packet as a reply.
; ******************************************************************
Set_Interface  ; start bank banksel USB_status_device
	;bsf 	STATUS, RP0	; bank3
	banksel USWSTAT
	movf	USWSTAT,w	; test to make sure we're configured
	;bcf 	STATUS,RP0	; bank2
	banksel USB_status_device
	andlw	0x03
	xorlw	CONFIG_STATE
	pagesel	wrongstate
	btfss	STATUS,Z
	goto	wrongstate

	movf	BufferData+wIndex,w ; get interface
	addlw	low USB_Interface	; add offset to array
	movwf	FSR
	;bcf 	STATUS,IRP	; indirectly to banks 0
	bankisel USB_Interface
	movf	BufferData+wValue,w ; get alternate interface
	movwf	INDF		; store in array
; All we do is set a meaningless number.  This'll 
; need more code here to actually give meaning to each configuration
; we choose.
	pagesel	Send_0Len_pkt
	call	Send_0Len_pkt
	return

; *********************************************************************
; copies the next chunk of buffer descriptor over to the EP0 In buffer.
; Inputs:
;	EP0_start - points to first byte of configuration table to transfer
;	EP0_end - total number of bytes to transfer
;	EP0_maxLength - maximum number of bytes that can be sent during
;	a single transfer
;
; toggles the data0/1 bit before setting the UOWN bit over to SIE.
; ******************************************************************
copy_descriptor_to_EP0
	global	copy_descriptor_to_EP0
	banksel	BD0IAL
	bankisel BD0IAL
	movf	BD0IAL,w	; get buffer address
	movwf	FSR		 
	banksel bufindex
	clrf	bufindex	; bufindex = 0
gdd_loop
	movf	bufindex,w	; while (bufindex < EP0_maxLength)
	subwf	EP0_maxLength,w	;  && (EP0_start < EP0_end)
	pagesel	end_gdd_loop
	btfsc	STATUS,Z
	goto	end_gdd_loop

	pagesel	gdd_copy_loop
	decfsz	EP0_end, f
	goto	gdd_copy_loop
	pagesel	end_gdd_loop_short_packet
	goto	end_gdd_loop_short_packet

gdd_copy_loop
	pagesel	Descriptions
	call	Descriptions
	movwf	INDF

	incf	bufindex,f
	incf	FSR,f
	pagesel	gdd_loop
	incfsz	EP0_start,f
	goto	gdd_loop
	incf	EP0_start+1,f
	goto	gdd_loop

end_gdd_loop_short_packet
	clrf	USB_dev_req	; we're sending a short packet, clear the device request
end_gdd_loop
	movf	bufindex,w	; write number of bytes to byte count
	;bsf 	STATUS,RP0	; Bank 3
	banksel BD0IBC
	movwf	BD0IBC
	movlw	(0x01<<DATA01)	; toggle data0/1 bit
	xorwf	BD0IST,w
	andlw	(0x01<<DATA01)	; clear PID bits
	iorlw	0x88		; set OWN and DTS bits
	movwf	BD0IST		; write the whole mess back
	banksel USB_status_device
	pagesel	copy_descriptor_to_EP0
	return
; *********************************************************************
; SetConfiguration
; 
; This function is called when the host issues a Set Configuration 
; command.  The housekeeping within USB is handled within the CH9 commands
; This function should be filled in to give meaning to the command within
; the application.
;
; SetConfiguration is called from within the ISR so this function should
; be kept as short as possible.
; *********************************************************************
SetConfiguration
	global	SetConfiguration
	return

ClassSpecificRequest
	return

Check_Class_Specific_IN
	return

;*********************************************************************
; Vendor Specific calls
; control is transferred here when bmRequestType bits 5 & 6 = 10 indicating
; the request is a vendor specific request.  This function then would 
; interpret the bRequest field to determine what action is required.
; The end of each vendor specific command should be terminated with a 
; return.  
; *********************************************************************
CheckVendor
	global	CheckVendor
	return	; *** remove this line and uncomment out the remainder

	end
