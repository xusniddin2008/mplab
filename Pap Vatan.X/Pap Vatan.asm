list p=12f675
	#include <P12f675.INC>
	ERRORLEVEL      -302
	__CONFIG  00054H
	;__CONFIG	_MCLRE_OFF & _PWRTE_OFF & _WDT_OFF & _INTRC_OSC_NOCLKOUT & _BODEN_OFF
Reg_1		equ	    0x20		
Reg_2		equ	    0x21
Reg_3		equ	    0x22
Regdata		equ	    0x23		
Reg_info	equ	    0x24
Regprog1	equ	    0x25
Regprog2	equ	    0x26
Regadres	equ	    0x29
var		equ	    0x30
STATUS_temp	equ	    0x31
W_temp		equ	    0x32	
STATUS		equ	    0x03
GPIO		equ	    0x05
TRISIO		equ	    0x85
OSCCAL		equ	    0x90
EEData		equ	    0x9A         ; EEPROM - ??????
EECon1		equ	    0x9C         ; EECON1 - ????1.
EEAdr		equ	    0x9B         ; EEPROM - ?????
EECon2		equ	    0x9D         ; EECON2 - ????2.		
;*******************************************************************************
		org         2100h       ; ????????? ? EEPROM ?????? ??????.
		DE          5           ; ??????????????? ??????
		org	    0x00
;*******************************************************************************

;*******************************************************************************		
		bcf	    STATUS,5
		movlw	    b'00000111'
		movwf	    CMCON
		clrf	    GPIO
		bsf	    STATUS,5
		call	    0x3FF
		movwf	    OSCCAL		
		MOVLW	    b'00000000'
		MOVWF	    OPTION_REG						    
		movlw	    b'00000000'
		movwf	    ANSEL
		clrf	    TRISIO
		bsf	    TRISIO,0
		bsf	    TRISIO,1
		bcf	    TRISIO,4
		bcf	    STATUS,5		
		;movlw	    b'00000000'
		;movwf	    Regdata
;*******************************************************************************
start		call	    Read
		btfss	    GPIO,1
		call	    pap_pap
		btfss	    GPIO,0
		call	    pap
		goto	    start
;*******************************************************************************		
pap_pap		call	    delay240ms
		btfsc	    GPIO,1
		return
		btfss	    Regdata,0
		return		
		movlw	    b'10000010'
		movwf	    Regdata
		call	    Write				
		bsf	    GPIO,4
		call	    delay24ms
		bcf	    GPIO,4
		call	    delay100ms
		bsf	    GPIO,4
		call	    delay24ms
		bcf	    GPIO,4
		
		return
;*******************************************************************************
pap		call	    delay240ms
		btfsc	    GPIO,0
		return
		btfsc	    Regdata,0
		return		
		movlw	    b'10000001'
		movwf	    Regdata
		call	    Write
		
		
		bsf	    GPIO,4
		call	    delay24ms
		bcf	    GPIO,4
		
		return
;*******************************************************************************		
; ?????? ?????? ? ????????????????? ?????? EEPROM (???)
Write       clrf       INTCON      ; ?????????? ?????? ??????????
	    bsf        STATUS,5    ; ??????? ? ?????? ????.
            movf       Regadres,W
            movwf      EEAdr       ; ??????????? W ? ??????? EEAdr
            movf       Regdata,W     ; ??????????? ?????? ?? Reg_4 ? ??????? W
            movwf      EEData      ; ??????????? W ? EEPROM
            
            bsf        EECon1,2    ; ????????? ??????.
            movlw      0x55         ; ????????????
            movwf      EECon2      ; ?????????
            movlw      0xAA         ; ??? ??????.
            movwf      EECon2      ; ----"----
            bsf        EECon1,1    ; ----"----
            bcf        EECon1,4    ; ???????? ???? ?????????? ?? ?????????
            bcf        STATUS,5    ; ??????? ? ??????? ????.
            return
;*******************************************************************************
; ?????? ?????? ?? ????????????????? ?????? EEPROM (???)
Read        bsf        STATUS,5    ; ??????? ? ?????? ????.
            movf       Regadres,W
            movwf      EEAdr       ; ??????????? W ? ??????? EEAdr
            
            bsf        EECon1,0    ; ???????????????? ??????.
            
            movf       EEData,W    ; ??????????? ? W ?? EEPROM
            movwf      Regdata       ; ??????????? ?? W ? ??????? Reg_4
            bcf        STATUS,5    ; ??????? ? ??????? ????.
	    return
;*******************************************************************************
delay24ms	movlw       .41
		movwf       Reg_1
		movlw       .32
		movwf       Reg_2
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		nop
		nop
		return
;*******************************************************************************
delay100ms	movlw       .221
		movwf       Reg_1
		movlw       .130
		movwf       Reg_2
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		nop
		nop
		return
;*******************************************************************************
delay240ms	movlw       .195
		movwf       Reg_1
		movlw       .234
		movwf       Reg_2
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3

		return
;*******************************************************************************		
		end
	
	





