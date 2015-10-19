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
;###############################################################################
; filename:	USB_MAIN.ASM
;		Sample mainline program
;
; This file implements a basic interrupt service routine and shows how the
; USB interrupt would be serviced, and also how InitUSB and PutUSB
; should be called.  It may be used as a reference, or as a starting point 
; from which to build an application.  
;
;###############################################################################
;
;	Author:			Dan Butler and Reston Condit
;	Company:		Microchip Technology Inc
;
;	Revision:		1.25
;	Date:			23 April 2002
;	Assembled using:	MPASM 2.80
;	Configuration Bits:	H4 Oscillator, WDT Off, Power up timer off
;	Revision History:
;	23 August 2000		DZB Changed descriptor pointers to 16 bits.
;	24 August 2000		DZB Moved EP1 & 2 configuration from USBReset
;				    to Set_Configuration to implement requirement in
;				    USB V1.1 spec paragraph 5.3.1.2
;	28 August 2000		DZB Force data toggle on OUT packets in PutUSB
;	20 March 2001		DZB Reduced use of common RAM
;	20 March 2001		DZB Put and Get use their own temp variable (GPtemp) to
;				    avoid collisions with the ISR's use of temp.
;	29 March 2001		DZB Fixed saving of bank bits in GetUSB
;	02 May 2001		DZB Implemented SHOW_ENUM_STATUS to show enumeration
;				    status on the PORTB LEDs: 0- Powered, 1- Default,
;				    2- addressed, 3- configured, 4- sleep, 
;				    5- EP0 Activity, 6- EP1 Activity, 7- EP2 Activity
;	03 August 2001		RAC Made distinct GetEP and PutEP macros for endpoints 1 
;				    and 2.  These functions are GetEP1, GetEP2, PutEP1, and 
;				    PutEP2.  Instances of the these macros are created in
;				    usb_ch9.asm.
;	08 August 2001		RAC Corrected various banking and paging issues.
;	15 August 2001		RAC Added Report_desc_index function in descript.asm.
;                           	    This function allows more than one report descriptor
;                           	    to be used.  
;	08 September 2001	RAC Correctly set DATA0/1 bit (BDndST:<6>) in 
;				    Set_Configuration (usb_ch9.asm). It wasn't being set 
;				    before. 
;	15 January 2002		RAC BD0OST was being written to after control was given
;				    to the SIE in HID_SET_REPORT.  This was fixed.
;	01 February 2002	RAC Made sure this version was consistent with the C
;				    version of the firmware.  Misc changes.
;	14 February 2002	RAC Corrected USBSleep and USBActivity to suspend and
;				    unsuspend the SIE respectively
;	25 February 2002	RAC Remote Wakeup initialization was moved from a 
;				    PORTB interrupt to the RA4 pin.  The move was made 
;				    because this firmware uses PORTB for USB status 
;				    outputs.  RA4 is a button on the PICDEM USB board.  
;				    For users who don't have the PICDEM USB PCB, RA4 is 
;				    active low.
;	5 March	2002		RAC Clear <UCTRL: SUSPND> bit in USBActivity rather than
;				    setting it.
;	12 March 2002		RAC Moved the code in USBError that clears the UEIR out 
;				    of the '#ifdef COUNTERRORS' condition.  This was done
; 				    so that this code is executed even if COUNTERROR is
;				    not defined.
;	14 March 2002		RAC Added interrupt enabled as a condition to calling all
;				    ISR functions
;	23 April 2002		RAC Changed the order in which USB interrupts are 
;				    serviced.  The Activity interrupt is now serviced
;				    before the Reset interrupt.
;
;   5 August 2005	Modified by Jean-Marc Lienher to add support for DMX512
;					Features. 
;################################################################################
;
;    include files:
;        P16C765.inc    Rev 1.00
;        usb_defs.inc   Rev 1.10
;
;################################################################################
#include <p16c745.inc>
#include "usb_defs.inc"
#include "dmx512.inc"

	__CONFIG  _H4_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF

unbanked	udata_shr
W_save		res	1	; register for saving W during ISR

bank0	udata
Status_save	res	1	; registers for saving context 
PCLATH_save	res	1	;  during ISR
FSR_save	res	1
CUR_STAT	res	1	; Direction cursor moves on the screen
COUNTER		res	1   
INNER		res	1
OUTER		res	1
PIRmasked	res	1

	extern	InitUSB
	extern	PutEP1
	extern	GetEP1
	extern	ServiceUSBInt
	extern	CheckSleep
	extern	RemoteWakeup	; Remote Wakeup works with the use of the RA4 pin (active low)
	extern	EP1_nb_rec_packet
	extern  EP1_nb_send_packet
	extern	EP1_control_direction

STARTUP	code
	pagesel	Main
	goto	Main
	nop
InterruptServiceVector
	movwf	W_save		; save W
	movf	STATUS,W
	clrf	STATUS		; force to page 0
	movwf	Status_save	; save STATUS
	movf	PCLATH,w
	movwf	PCLATH_save	; save PCLATH
	movf	FSR,w
	movwf	FSR_save	; save FSR
	pagesel TMR0TEST

; *************************************************************
; Interrupt Service Routine
; First we step through several stages, attempting to identify the source 
; of the interrupt.
; ******************************************************************

Process_ISR
TMR0TEST
	btfsc	INTCON,T0IE
	btfss	INTCON,T0IF
	goto	INTTEST
	nop			; insert TMR0 code call here
INTTEST
	btfsc	INTCON,INTE
	btfss	INTCON,INTF
	goto	RBTEST
	nop			; insert RB0/INT code call here
RBTEST
	btfsc	INTCON,RBIE
	btfss	INTCON,RBIF
	goto	PERIPHERALTEST
	nop			; insert PORTB Change code call here

PERIPHERALTEST
	btfss	INTCON,PEIE	; is there a peripheral interrupt?
	goto	EndISR		; all done....

TEST_PIR1
	banksel	PIR1
	movf	PIR1,w
	banksel	PIE1
	andwf	PIE1,w		; mask the enables with the flags
	banksel	PIRmasked
	movwf	PIRmasked

	pagesel	ServiceUSBInt
	btfsc	PIRmasked,USBIF	; USB interrupt flag
	call	ServiceUSBInt	; Service USB interrupt

	btfsc	PIRmasked,ADIF	; AD Done?
	nop

	;pagesel ServiceRCIF		; USART RX
	;btfsc	PIRmasked,RCIF
	;call	ServiceRCIF

	pagesel ServiceTXIF		; USART TX
	btfsc	PIRmasked,TXIF
	call	ServiceTXIF

	btfsc	PIRmasked,CCP1IF
	nop
	btfsc	PIRmasked,TMR2IF
	nop
	pagesel ServiceTMR1IF	;Timer 1
	btfsc	PIRmasked,TMR1IF
	call	ServiceTMR1IF
TEST_PIR2
	banksel	PIR2
	movf	PIR2,w
	banksel	PIE2
	andwf	PIE2,w
	banksel	PIRmasked
	movwf	PIRmasked
	btfsc	PIRmasked,CCP2IF
	nop

; ******************************************************************
; End ISR, restore context and return to the Main program
; ******************************************************************
EndISR
	clrf	STATUS		; select bank 0
	movf	FSR_save,w	; restore the FSR
	movwf	FSR
	movf	PCLATH_save,w	; restore PCLATH
	movwf	PCLATH
	movf	Status_save,w	; restore Status
	movwf	STATUS
	swapf	W_save,f	; restore W without corrupting STATUS
	swapf	W_save,w
	retfie

	code
; ******************************************************************
; test program that sets up the buffers and calls the ISR for processing.
;     
; ******************************************************************
Main
	movlw	.30		; delay 16 uS to wait for USB to reset
	movwf	W_save		; SIE before initializing registers
	decfsz	W_save,f	; inner is merely a convienient register
	goto	$-1		; to use for the delay counter.

; ******************************************************************
; Sets the probe control register to output the UCTRL register and
; USBDPRAM databus onto the probepins.  
; ******************************************************************
	clrf	PORTB
	clrf	PORTA
	banksel	TRISA		; Bank 1
	clrf	TRISB		; Set PORTB as all outputs
	movlw	H'01'		; RA0 as input
	movwf	TRISA		; 

	banksel	ADCON1
	movlw	H'07'		; RA as digital
	movwf	ADCON1
	
	pagesel	InitUSB		; These six lines of code show the appropriate
	call	InitUSB		;  way to initialize the USB. First, initialize
				;  the USB (wait for host enumeration) then wait
	ConfiguredUSB		;  until the enumeration process to complete.
	bcf	STATUS,RP0	; Make sure you include all pagesels and return to
	bcf	STATUS,RP1	;  the desired bank (in this case Bank 0.)

	pagesel InitDMX512	; start the endless DMX transmission
	call InitDMX512

; ******************************************************************
; Main loop, sends to host computer or recieves 8 bytes packets
; ******************************************************************
	pagesel CheckEP1
CheckEP1 				; Check Endpoint 1 for an OUT transaction
	bankisel BufferFromHost 	; point to lower banks
	banksel BufferFromHost

	pagesel PushEP1
	btfsc	PutGetUsbFlags, DontRecieve ; are we busy ?
	goto	PushEP1				; yes!

	bankisel BufferFromHost
	movlw BufferFromHost
	movwf FSR 			; point FSR to our buffer
	pagesel GetEP1
	call GetEP1 		; If data is ready, it will be copied.
	banksel BufferFromHost
	pagesel PushEP1
	btfss STATUS,C 		; was there any data for us?
	goto PushEP1 		; Nope. see if we must send something.

	pagesel	CheckEP1DataIn

CheckEP1DataIn:

		;**********************
		; use the BUFFER now !
		;**********************
	pagesel ReadBuffer
	call ReadBuffer
	pagesel CheckEP1
	
	banksel EP1_nb_send_packet
	movf EP1_nb_send_packet,w ; was all packets sent?
	btfss STATUS,Z
	goto CheckEP1	; no!
	btfsc EP1_control_direction,1	; writing data to host ?
	clrf  EP1_control_direction ; yes, end of transaction !

	btfss EP1_control_direction,0	; reading data from host ?
	goto CheckEP1 ; no !

	movf EP1_nb_rec_packet,w ; was all packets already read ?
	btfsc STATUS,Z
	goto CheckEP1 ; yes
	decf EP1_nb_rec_packet,f ; no, but is it the last one ?
	btfss STATUS,Z	
	goto CheckEP1 ;no !

; send a Zero length data packet to acknowledge good
; reception of host packets
	banksel	BD1IBC
	clrf	BD1IBC		; set byte count to 0
	movlw	0xc8
	movwf	BD1IST		; set owns bit

	banksel EP1_control_direction
	clrf EP1_control_direction	; this is the end of transaction
	goto CheckEP1
	
PushEP1:
	btfsc EP1_control_direction,1	; writing data to host ?
	goto PutBuffer		; yes

	btfsc EP1_control_direction,0	; reading data from host ?
	goto CheckEP1		; yes
	
	; we do nothing !

	pagesel CheckEP1
	goto CheckEP1	

; do nothing (in this "lite" version...)
PutBuffer

	goto 	CheckEP1

	end

