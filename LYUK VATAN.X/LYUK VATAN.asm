list p=12f675
	#include <P12f675.INC>
	ERRORLEVEL      -302
	__CONFIG  00054H
	;__CONFIG	_MCLRE_OFF & _PWRTE_OFF & _WDT_OFF & _INTRC_OSC_NOCLKOUT & _BODEN_OFF
Reg_1		equ	    0x20		
Reg_2		equ	    0x21
Reg_3		equ	    0x22
Reg_info	equ	    0x23		
STATUS		equ	    0x03
GPIO		equ	    0x05
TRISIO		equ	    0x85
		
		
;*******************************************************************************		
		org	    0x00
;*******************************************************************************
		bcf	    STATUS,5
		movlw	    b'00000111'
		movwf	    CMCON
		clrf	    GPIO
		bsf	    STATUS,5
		call	    0x3FF
		movwf	    OSCCAL
		movlw	    b'10000000'
		movwf	    OSCCAL
		MOVLW	    b'10000000'
		MOVWF	    OPTION_REG						    
		movlw	    b'00000000'
		movwf	    ANSEL
		clrf	    TRISIO
		bcf	    TRISIO,0
		bcf	    TRISIO,1
		bsf	    TRISIO,2
		bsf	    TRISIO,3
		bsf	    TRISIO,5
		bcf	    STATUS,5
		movlw	    b'00000000'
		movwf	    Reg_info
;*******************************************************************************
prog		call	    blok
		btfss	    GPIO,5
		call	    aux
		goto	    prog
;*******************************************************************************
blok		btfsc	    GPIO,3
		return		
		call	    delay50ms
		btfsc	    GPIO,3
		return		
		btfsc	    GPIO,2
		return
		call	    sekund_3.5
		btfsc	    GPIO,2
		return
		call	    delay_20msekund
		call	    sekund_10.5info
		bcf	    GPIO,0
		return		
;*******************************************************************************
aux		call	    delay50ms
		btfsc	    GPIO,5
		return		
		btfss	    Reg_info,0
		call	    sekund_10.5aux		
		btfsc	    Reg_info,0
		call	    sekund_3.5aux
		
		return		
;*******************************************************************************		
sekund_3.5	bsf	    GPIO,1
		call	    delay_3.5
		bcf	    GPIO,1
		return
;*******************************************************************************		
sekund_3.5aux	bsf	    GPIO,1
		call	    aux_3.5
		bcf	    GPIO,1
		return		
;*******************************************************************************
sekund_10.5info	bsf	    GPIO,0
		call	    delay_1
		btfsc	    GPIO,2
		return		
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return		
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1
		btfsc	    GPIO,2
		return	
		call	    delay_1		
		return	
;*******************************************************************************		
sekund_10.5aux	bsf	    GPIO,0
		call	    aux_10.5
		bcf	    GPIO,0
		return
;*******************************************************************************		
delay_3.5	movlw	    b'00000000'
		movwf	    Reg_info
		movlw       .102
		movwf       Reg_1
		movlw       .194
		movwf       Reg_2
		movlw       .18
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
aux_10.5	movlw	    b'00000001'
		;movwf	    Reg_info
		;movlw       .55
		;movwf       Reg_1
		;movlw       .1
		;movwf       Reg_2
		;movlw       .63
		;movwf       Reg_3
		;decfsz      Reg_1,F
		;goto        $-1
		;decfsz      Reg_2,F
		;goto        $-3
		;decfsz      Reg_3,F
		;goto        $-5
		movwf	    Reg_info
		movlw       .102
		movwf       Reg_1
		movlw       .194
		movwf       Reg_2
		movlw       .21
		movwf       Reg_3
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		decfsz      Reg_3,F
		goto        $-5
		nop
		bcf	    GPIO,0
		goto	    prog
;*******************************************************************************
aux_3.5		movlw	    b'00000000'
		movwf	    Reg_info
		movlw       .102
		movwf       Reg_1
		movlw       .194
		movwf       Reg_2
		movlw       .21
		movwf       Reg_3
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		decfsz      Reg_3,F
		goto        $-5
		nop
		bcf	    GPIO,1
		goto	    prog
;*******************************************************************************
delay_1		;movlw	    b'00000001'
		;movwf	    Reg_info		
		movlw       .200
		movwf       Reg_1
		movlw       .60
		movwf       Reg_2
		movlw       .6
		movwf       Reg_3
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		decfsz      Reg_3,F
		goto        $-5	
		return		
;*******************************************************************************
delay_20msekund movlw       .238
		movwf       Reg_1
		movlw       .65
		movwf       Reg_2
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		nop
		return
		
;*******************************************************************************		
delay50ms   movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop

	    return
;*******************************************************************************	    
		end
	
	


