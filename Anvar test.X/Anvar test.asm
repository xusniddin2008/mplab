list p=12f675
	#include <P12f675.INC>
	ERRORLEVEL      -302
	__CONFIG  00054H
Reg_1		equ	    0x20		
Reg_2		equ	    0x21
Reg_3		equ	    0x22
STATUS		equ	    0x03
GPIO		equ	    0x05
TRISIO		equ	    0x85
;*******************************************************************************		
		org	    0x00
;*******************************************************************************
		bcf	    STATUS,5
		clrf	    GPIO
		bsf	    STATUS,5
		MOVLW	    b'10000000'
		MOVWF	    OPTION_REG	
		clrf	    TRISIO
		bcf	    TRISIO,1
		bsf	    TRISIO,5
		bcf	    STATUS,5
;*******************************************************************************
prog		btfss	    GPIO,5
		call	    anvar
		goto	    prog
;*******************************************************************************
anvar		bsf	    GPIO,1
		call	    delay_5sekund
		bcf	    GPIO,1
		return		
;*******************************************************************************
delay_5sekund movlw       .110
		movwf       Reg_1
		movlw       .94
		movwf       Reg_2
		movlw       .26
		movwf       Reg_3
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		decfsz      Reg_3,F
		goto        $-5
		nop
		return
;*******************************************************************************		
	
		end
	
	


