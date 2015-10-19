;******************************************************************************
;
;                   Copyright (c) 2005, Jean-Marc Lienher
;                       All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions
; are met:
;
;       Redistributions of source code must retain the above copyright
;	notice, this list of conditions and the following disclaimer.
;
;       Redistributions in binary form must reproduce the above copyright
;	notice, this list of conditions and the following disclaimer in the
;	documentation and/or other materials provided with the distribution.
;
;	Neither the name of the author nor the names of its contributors
;	may be used to endorse or promote products derived from this software
;	without specific prior written permission.
;
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
; A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
; CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
;******************************************************************************
;                                                                             *
;    Filename: 		dmx512.asm                                               *
;    Date: 			21.7.2005                                                 *
;    File Version:  1.0                                                       *
;                                                                             *
;    Author:  Jean-Marc Lienher                                               *
;******************************************************************************

#include <p16C765.inc>
#define NO_DMX512_DECL	1
#include "dmx512.inc"


bank0	udata
BufferFromHost		res	8	; Location for data to be read from host
PutGetUsbFlags		res 1	; don't get and don't send flags
	global PutGetUsbFlags
	global BufferFromHost


TxFlags					res 1
NbChannelToSend			res 1
BufferFromPointer		res 1
LastTxPacket			res 1


;**********************************************************

TxFlagsBreakSent		EQU	H'0000'
TxFlagsStartSent		EQU H'0001'
TxFlagsLastBuffer		EQU H'0002'
TxFlagsBreakInit		EQU	H'0003'
TxFlagsBreakEnd			EQU	H'0004'
TxFlagsBreakPre			EQU	H'0005'
TxFlagsBreakBeforePre	EQU H'0006'

; FIXME bug, these values seems to be random... why ???
BREAK_TMR1LOW			EQU D'220'		; 88uS	= 88 * 3 = 264 -> (256 + 256) - 264 = 248
										; but add 10uS after seen on the Oscilloscope
BREAK_TMR1HIGH			EQU H'FE'
BREAKPRE_TMR1LOW		EQU D'100'		; 88uS	= 88 * 3 = 264 -> (256 + 256) - 264 = 248
										; add 44uS after seen scope!
BREAKPRE_TMR1HIGH		EQU H'FF'
BREAKEND_TMR1LOW		EQU D'232'		; 8uS = 8 * 3 = 24 -> 256 - 24 = 232
BREAKEND_TMR1HIGH		EQU H'FF'

;************************* CODE ***************************
DMX512	code
;**********************************************************

InitDMX512
	global InitDMX512
	banksel BufferFromPointer

	clrf	BufferFromPointer
	clrf	NbChannelToSend
	clrf	TxFlags
	movlw 	H'FF'
	movwf	LastTxPacket
	clrf	PutGetUsbFlags

	; timer 1
	banksel	T1CON
	bcf		T1CON, TMR1ON		; stop timer
	bcf		T1CON, TMR1CS		; internal clock Fint/4= 6MHz
	; bug in the data sheet ! Fint/4 !!!
	bcf		T1CON, T1CKPS1		; prescaler divide by 2
	bsf		T1CON, T1CKPS0		; -> t = .33uS
	banksel	PIE1
	bsf		PIE1, TMR1IE		; enable timer 1 interrupt

	;USART
	banksel	TRISC
	bcf		TRISC, 6		; TX pin output (5V = logic 1, 0V = logic 0)
	bsf		TRISC, 7		; RX pin input
	banksel TXSTA
	bsf		TXSTA, TXEN		; transmit enable
	bsf		TXSTA, BRGH		; high baud rate
	bsf		TXSTA, TX9		; send 9 bit
	bsf		TXSTA, TX9D		; 9th bit is a '1' ( 2nd stop bit )
	bcf 	TXSTA, SYNC 	; asynchronous
	banksel SPBRG
	movlw	D'5'
	movwf	SPBRG			; 250kbauds
	banksel RCSTA
	;bsf 	RCSTA, RX9		; 9 bits reciever
	bsf 	RCSTA, CREN 	; reciever enabled
	bsf 	RCSTA, SPEN 	; USART enabled

	; interrupt
	banksel INTCON
	bsf		INTCON, PEIE
	bsf		INTCON, GIE
	
; let's go, we start the endless process of transmitting DMX 512 channels	
	bcf		PORTA, 1
	banksel	PORTB
	bsf		PORTB, 0		; Set the DMX line transciever as output
	banksel	PIE1
	bsf 	PIE1, TXIE 		; TX interrupt enabled
	
	return
;**********************************************************

ServiceTXIF
	global ServiceTXIF
	banksel	TxFlags
	pagesel	CheckStartServiceTXIF
	btfsc	TxFlags, TxFlagsBreakSent	; must we send the break ?
	goto	CheckStartServiceTXIF		; no

	pagesel DoNothingServiceTXIF
	btfsc	TxFlags, TxFlagsBreakInit	; already initiated ?
	goto	DoNothingServiceTXIF		; yes, nothing to do here.	

	bsf		TxFlags, TxFlagsBreakInit	; we are initiating a break
	
	banksel TMR1L				; BUG BUG !!!
	movlw	H'0'				
	movwf	TMR1L
	movlw	H'FF'
	movwf	TMR1H
	banksel T1CON
	bsf		T1CON,	TMR1ON				; run timer
	
	pagesel DoNothingServiceTXIF
	goto 	DoNothingServiceTXIF	

CheckStartServiceTXIF
	banksel TxFlags
	pagesel SendDataServiceTXIF
	btfsc	TxFlags, TxFlagsStartSent	; must we send the start ?
	goto	SendDataServiceTXIF			; no

	banksel TXREG
	movlw	D'0'						; send the DMX 0 start code
	movwf	TXREG
	banksel TxFlags
	bsf		TxFlags, TxFlagsStartSent	; ok we sent it.

	pagesel ExitServiceTXIF
	goto ExitServiceTXIF
	
SendDataServiceTXIF
	banksel NbChannelToSend
	movfw	NbChannelToSend		; do we have something to send ?
	pagesel DoNothingServiceTXIF
	btfsc	STATUS, Z		
	goto 	DoNothingServiceTXIF ; no !

	banksel BufferFromHost
	bankisel BufferFromHost
	movlw	BufferFromHost+1	; read our data
	movwf	FSR
	movfw	BufferFromPointer
	addwf	FSR
	movfw	INDF
	banksel	TXREG
	movwf	TXREG		; send it!

	banksel NbChannelToSend
	decf	NbChannelToSend, F	; did we sent the last byte of the buffer ?
	pagesel ExitServiceTXIF
	btfss	STATUS, Z
	goto 	ExitServiceTXIF		; no!
	
	btfss	TxFlags, TxFlagsLastBuffer	; skip if this was channel 512
	bcf		PutGetUsbFlags, DontRecieve	; enable to get the next USB data

	btfss	TxFlags, TxFlagsLastBuffer	; skip if this was channel 512
	goto	ExitServiceTXIF
	
	clrf	TxFlags						; initial state

ExitServiceTXIF
	banksel BufferFromPointer
	incf	BufferFromPointer, F
	return

DoNothingServiceTXIF
	banksel	PIE1
	bcf 	PIE1, TXIE 		; TX interrupt disabled
	return
;**********************************************************
	
ServiceTMR1IF
	global ServiceTMR1IF

	banksel T1CON
	bcf		T1CON,	TMR1ON				; stop timer

	banksel	TxFlags
	pagesel	ExitServiceTMR1IF			; break sent ?
	btfsc	TxFlags, TxFlagsBreakSent
	goto	ExitServiceTMR1IF			; yes, we have nothing to do here

	pagesel ExitServiceEndOfBreakEnd
	btfsc	TxFlags, TxFlagsBreakPre	; Was it the time before break ?
	goto	StartBreakServiceTMR1IF	; no

	pagesel AfterPreServiceTMR1IF
	btfsc	TxFlags, TxFlagsBreakBeforePre	; Was it the time before break ?
	goto	AfterPreServiceTMR1IF	; no

	bsf		TxFlags, TxFlagsBreakBeforePre
	banksel TMR1L
	movlw	BREAKPRE_TMR1LOW				; put the pre break time in the timer
	movwf	TMR1L
	movlw	BREAKPRE_TMR1HIGH
	movwf	TMR1H
	banksel T1CON
	bsf		T1CON,	TMR1ON				; run timer

	pagesel ExitServiceTMR1IF
	goto ExitServiceTMR1IF

AfterPreServiceTMR1IF
	bsf		TxFlags, TxFlagsBreakPre
;**** put RX pin in break state (low) *****
	banksel	PORTC
	bcf		PORTC, 6					; TX pin low
	banksel	TRISC
	bcf		TRISC, 6					; TX pin as output
	banksel RCSTA
	bcf		RCSTA, SPEN					; disable serial port !
	
	banksel TMR1L
	movlw	BREAK_TMR1LOW				; put the break time in the timer
	movwf	TMR1L
	movlw	BREAK_TMR1HIGH
	movwf	TMR1H
	banksel T1CON
	bsf		T1CON,	TMR1ON				; run timer

	pagesel ExitServiceTMR1IF
	goto ExitServiceTMR1IF


StartBreakServiceTMR1IF
	banksel	TxFlags
	pagesel ExitServiceEndOfBreakEnd
	btfsc	TxFlags, TxFlagsBreakEnd	; is this the end of the up time after break ?
	goto	ExitServiceEndOfBreakEnd	; yes

	bsf		TxFlags, TxFlagsBreakEnd	; this is the end of the pin low time

	banksel	PORTC
	bsf		PORTC, 6					; TX pin high	

	banksel TMR1L
	movlw	BREAKEND_TMR1LOW				; put the end of break time in the timer
	movwf	TMR1L
	movlw	BREAKEND_TMR1HIGH
	movwf	TMR1H
	banksel T1CON
	bsf		T1CON,	TMR1ON				; run timer

	pagesel ExitServiceTMR1IF
	goto ExitServiceTMR1IF

ExitServiceEndOfBreakEnd
	banksel TxFlags
	bsf		TxFlags, TxFlagsBreakSent
	banksel RCSTA
	bsf		RCSTA, SPEN					; enable serial port !
	banksel PutGetUsbFlags
	bcf		PutGetUsbFlags, DontRecieve	; enable to get the first USB data
	banksel	PIE1
	bsf 	PIE1, TXIE 		; TX interrupt enabled

ExitServiceTMR1IF
	banksel PIR1
	bcf		PIR1,TMR1IF
	return
;**********************************************************

ReadBuffer
	global ReadBuffer
	banksel BufferFromHost

	clrf	BufferFromPointer	; set our pointer to the first data

	;check if we don't have lost any packet
	decf	BufferFromHost+0, W
	subwf	LastTxPacket,	W
	btfss	STATUS, Z
	return						; Too bad, we've lost some packet! ignore this one

	movfw	BufferFromHost+0	; save our packet id
	movwf	LastTxPacket

	banksel	BufferFromHost
	movfw	BufferFromHost+0	; this is the packet id (0-73)
	sublw	D'73'			; 512 / 7 == 73.14
	pagesel ReadBufferLastOne
	btfsc	STATUS, Z			; we have 7 byte per packet except for the last one	
	goto	ReadBufferLastOne				
	movlw	D'7'				
	movwf	NbChannelToSend

	banksel	PutGetUsbFlags
	bsf		PutGetUsbFlags, DontRecieve	; don't recieve USB packet until this one is sent to DMX output
	banksel	PIE1
	bsf 	PIE1, TXIE 		; TX interrupt enabled
		
	return

ReadBufferLastOne
	movlw	D'1'			; only one byte for the last one
	movwf	NbChannelToSend
	bsf		TxFlags, TxFlagsLastBuffer	; indicate that this is the last buffer
	movlw 	H'FF'
	movwf	LastTxPacket		; 0 minus 1 equal 0xFF

	banksel	PutGetUsbFlags
	bsf		PutGetUsbFlags, DontRecieve	; don't recieve USB packet until this one is sent to DMX output

	banksel	PIE1
	bsf 	PIE1, TXIE 		; TX interrupt enabled
	
	return
;**********************************************************
	end
