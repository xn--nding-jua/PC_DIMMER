        LIST
; P16C745.INC  Standard Header File, Version 1.00    Microchip Technology, Inc.
        NOLIST

; This header file defines configurations, registers, and other useful bits of
; information for the PIC16C745 microcontroller.  These names are taken to match 
; the data sheets as closely as possible.  

; Note that the processor must be selected before this file is 
; included.  The processor may be selected the following ways:

;       1. Command line switch:
;               C:\ MPASM MYFILE.ASM /PIC16C745
;       2. LIST directive in the source file
;               LIST   P=PIC16C745
;       3. Processor Type entry in the MPASM full-screen interface

;==========================================================================
;
;       Revision History
;
;==========================================================================

;Rev:   Date:    Reason:

;1.00   28 Sep 99 Initial Release

;==========================================================================
;
;       Verify Processor
;
;==========================================================================

        IFNDEF __16C745
           MESSG "Processor-header file mismatch.  Verify selected processor."
        ENDIF

;==========================================================================
;
;       Register Definitions
;
;==========================================================================

W                            EQU     H'0000'
F                            EQU     H'0001'

;----- Register Files------------------------------------------------------

INDF                         EQU     H'0000'
TMR0                         EQU     H'0001'
PCL                          EQU     H'0002'
STATUS                       EQU     H'0003'
FSR                          EQU     H'0004'
PORTA                        EQU     H'0005'
PORTB                        EQU     H'0006'
PORTC                        EQU     H'0007'
PCLATH                       EQU     H'000A'
INTCON                       EQU     H'000B'
PIR1                         EQU     H'000C'
PIR2                         EQU     H'000D'
TMR1L                        EQU     H'000E'
TMR1H                        EQU     H'000F'
T1CON                        EQU     H'0010'
TMR2                         EQU     H'0011'
T2CON                        EQU     H'0012'
CCPR1L                       EQU     H'0015'
CCPR1H                       EQU     H'0016'
CCP1CON                      EQU     H'0017'
RCSTA                        EQU     H'0018'
TXREG                        EQU     H'0019'
RCREG                        EQU     H'001A'
CCPR2L                       EQU     H'001B'
CCPR2H                       EQU     H'001C'
CCP2CON                      EQU     H'001D'
ADRES                        EQU     H'001E'
ADCON0                       EQU     H'001F'

OPTION_REG                   EQU     H'0081'
TRISA                        EQU     H'0085'
TRISB                        EQU     H'0086'
TRISC                        EQU     H'0087'
PIE1                         EQU     H'008C'
PIE2                         EQU     H'008D'
PCON                         EQU     H'008E'
PR2                          EQU     H'0092'
TXSTA                        EQU     H'0098'
SPBRG                        EQU     H'0099'
ADCON1                       EQU     H'009F'
UIR                          EQU     H'0190'
UIE                          EQU     H'0191'
UEIR                         EQU     H'0192'
UEIE                         EQU     H'0193'
USTAT                        EQU     H'0194'
UCTRL                        EQU     H'0195'
UADDR                        EQU     H'0196'
USWSTAT			     EQU     H'0197'
UEP0                         EQU     H'0198'
UEP1                         EQU     H'0199'
UEP2                         EQU     H'019A'

BD0OST                       EQU     H'01A0'
BD0OBC                       EQU     H'01A1'
BD0OAL                       EQU     H'01A2'
BD0IST                       EQU     H'01A4'
BD0IBC                       EQU     H'01A5'
BD0IAL                       EQU     H'01A6'

BD1OST                       EQU     H'01A8'
BD1OBC                       EQU     H'01A9'
BD1OAL                       EQU     H'01AA'
BD1IST                       EQU     H'01AC'
BD1IBC                       EQU     H'01AD'
BD1IAL			     EQU     H'01AE'

BD2OST                       EQU     H'01B0'
BD2OBC                       EQU     H'01B1'
BD2OAL                       EQU     H'01B2'
BD2IST                       EQU     H'01B4'
BD2IBC                       EQU     H'01B5'
BD2IAL			     EQU     H'01B6'


;----- STATUS Bits --------------------------------------------------------

IRP                          EQU     H'0007'
RP1                          EQU     H'0006'
RP0                          EQU     H'0005'
NOT_TO                       EQU     H'0004'
NOT_PD                       EQU     H'0003'
Z                            EQU     H'0002'
DC                           EQU     H'0001'
C                            EQU     H'0000'

;----- INTCON Bits --------------------------------------------------------

GIE                          EQU     H'0007'
PEIE                         EQU     H'0006'
T0IE                         EQU     H'0005'
INTE                         EQU     H'0004'
RBIE                         EQU     H'0003'
T0IF                         EQU     H'0002'
INTF                         EQU     H'0001'
RBIF                         EQU     H'0000'

;----- PIR1 Bits ----------------------------------------------------------

ADIF                         EQU     H'0006'
RCIF                         EQU     H'0005'
TXIF                         EQU     H'0004'
USBIF                        EQU     H'0003'
CCP1IF                       EQU     H'0002'
TMR2IF                       EQU     H'0001'
TMR1IF                       EQU     H'0000'

;----- PIR2 Bits ----------------------------------------------------------

CCP2IF                       EQU     H'0000'

;----- T1CON Bits ---------------------------------------------------------

T1CKPS1                      EQU     H'0005'
T1CKPS0                      EQU     H'0004'
T1OSCEN                      EQU     H'0003'
NOT_T1SYNC                   EQU     H'0002'
T1INSYNC                     EQU     H'0002'    ; Backward compatibility only
TMR1CS                       EQU     H'0001'
TMR1ON                       EQU     H'0000'

;----- T2CON Bits ---------------------------------------------------------

TOUTPS3                      EQU     H'0006'
TOUTPS2                      EQU     H'0005'
TOUTPS1                      EQU     H'0004'
TOUTPS0                      EQU     H'0003'
TMR2ON                       EQU     H'0002'
T2CKPS1                      EQU     H'0001'
T2CKPS0                      EQU     H'0000'

;----- CCP1CON Bits -------------------------------------------------------

DC1B1                        EQU     H'0005'
DC1B0                        EQU     H'0004'
CCP1M3                       EQU     H'0003'
CCP1M2                       EQU     H'0002'
CCP1M1                       EQU     H'0001'
CCP1M0                       EQU     H'0000'

;----- RCSTA Bits ---------------------------------------------------------

SPEN                         EQU     H'0007'
RX9                          EQU     H'0006'
RC9                          EQU     H'0006'    ; Backward compatibility only
NOT_RC8                      EQU     H'0006'    ; Backward compatibility only
RC8_9                        EQU     H'0006'    ; Backward compatibility only
SREN                         EQU     H'0005'
CREN                         EQU     H'0004'
FERR                         EQU     H'0002'
OERR                         EQU     H'0001'
RX9D                         EQU     H'0000'
RCD8                         EQU     H'0000'    ; Backward compatibility only

;----- CCP2CON Bits -------------------------------------------------------

DC2B1                        EQU     H'0005'
DC2B0                        EQU     H'0004'
CCP2M3                       EQU     H'0003'
CCP2M2                       EQU     H'0002'
CCP2M1                       EQU     H'0001'
CCP2M0                       EQU     H'0000'

;----- ADCON0 Bits --------------------------------------------------------

ADCS1                        EQU     H'0007'
ADCS0                        EQU     H'0006'
CHS2                         EQU     H'0005'
CHS1                         EQU     H'0004'
CHS0                         EQU     H'0003'
GO                           EQU     H'0002'
NOT_DONE                     EQU     H'0002'
GO_DONE                      EQU     H'0002'
ADON                         EQU     H'0000'

;----- OPTION Bits --------------------------------------------------------

NOT_RBPU                     EQU     H'0007'
INTEDG                       EQU     H'0006'
T0CS                         EQU     H'0005'
T0SE                         EQU     H'0004'
PSA                          EQU     H'0003'
PS2                          EQU     H'0002'
PS1                          EQU     H'0001'
PS0                          EQU     H'0000'


;----- PIE1 Bits ----------------------------------------------------------

ADIE                         EQU     H'0006'
RCIE                         EQU     H'0005'
TXIE                         EQU     H'0004'
USBIE                        EQU     H'0003'
CCP1IE                       EQU     H'0002'
TMR2IE                       EQU     H'0001'
TMR1IE                       EQU     H'0000'

;----- PIE2 Bits ----------------------------------------------------------

CCP2IE                       EQU     H'0000'

;----- PCON Bits ----------------------------------------------------------

NOT_POR                      EQU     H'0001'
NOT_BO                       EQU     H'0000'
NOT_BOR                      EQU     H'0000'

;----- TXSTA Bits ---------------------------------------------------------

CSRC                         EQU     H'0007'
TX9                          EQU     H'0006'
NOT_TX8                      EQU     H'0006'    ; Backward compatibility only
TX8_9                        EQU     H'0006'    ; Backward compatibility only
TXEN                         EQU     H'0005'
SYNC                         EQU     H'0004'
BRGH                         EQU     H'0002'
TRMT                         EQU     H'0001'
TX9D                         EQU     H'0000'
TXD8                         EQU     H'0000'    ; Backward compatibility only

;----- ADCON1 Bits --------------------------------------------------------

PCFG2                        EQU     H'0002'
PCFG1                        EQU     H'0001'
PCFG0                        EQU     H'0000'

;----- UIR/UIE Bits -----------------------------------------------------

STALL                        EQU     H'0005'
UIDLE                        EQU     H'0004'
TOK_DNE                      EQU     H'0003'
ACTIVITY                     EQU     H'0002'
UERR                         EQU     H'0001'
USB_RST                      EQU     H'0000'

;----- UEIR/UEIE Bits -----------------------------------------------------

BTS_ERR                      EQU     H'0007'
OWN_ERR                      EQU     H'0006'
WRT_ERR			     EQU     H'0005'
BTO_ERR                      EQU     H'0004'
DFN8                         EQU     H'0003'
CRC16                        EQU     H'0002'
CRC5                         EQU     H'0001'
PID_ERR                      EQU     H'0000'

;----- USTAT Bits ---------------------------------------------------------

ENDP1                        EQU     H'0004'
ENDP0                        EQU     H'0003'
IN                           EQU     H'0002'

;----- UCTRL Bits ---------------------------------------------------------

SE0			     EQU     H'0005'
PKT_DIS                      EQU     H'0004'
DEV_ATT                      EQU     H'0003'
RESUME                       EQU     H'0002'
SUSPND                       EQU     H'0001'
;----- UEPn Bits ---------------------------------------------------------

EP_CTL_DIS                   EQU     H'0003'
EP_OUT_EN                    EQU     H'0002'
EP_IN_EN                     EQU     H'0001'
EP_STALL                     EQU     H'0000'

;----- Buffer descriptor Bits ---------------------------------------------

UOWN                         EQU     H'0007'
OWN                          EQU     H'0007'
DATA01                       EQU     H'0006'
DTS                          EQU     H'0003'
BSTALL                       EQU     H'0002'
PID3                         EQU     H'0005'
PID2                         EQU     H'0004'
PID1                         EQU     H'0003'
PID0                         EQU     H'0002'
;==========================================================================
;
;       RAM Definition
;
;==========================================================================

        __MAXRAM H'01FF'
        __BADRAM H'8', H'9', H'13', H'14', H'88', H'89', H'8F'-H'91'
	__BADRAM H'93'-H'97', H'9A'-H'9E'
	__BADRAM H'105', H'107'-H'109', H'10C'-H'11F'
	__BADRAM H'185', H'187'-H'189', H'18C'-H'18F', H'19B'-H'19F'
	__BADRAM H'1E0'-H'1EF'
;==========================================================================
;
;       Configuration Bits
;
;==========================================================================

_CP_ALL                      EQU     H'00CF'
_CP_75                       EQU     H'15DF'
_CP_50                       EQU     H'2AEF'
_CP_OFF                      EQU     H'3FFF'
_PWRTE_OFF                   EQU     H'3FFF'
_PWRTE_ON                    EQU     H'3FF7'
_WDT_ON                      EQU     H'3FFF'
_WDT_OFF                     EQU     H'3FFB'
_HS_OSC                      EQU     H'3FFC'
_EC_OSC                      EQU     H'3FFD'
_H4_OSC                      EQU     H'3FFE'
_E4_OSC                      EQU     H'3FFF'

        LIST
