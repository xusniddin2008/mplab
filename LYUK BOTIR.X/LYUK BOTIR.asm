LIST	p=16F630
	    ;__CONFIG	02170H
	    __CONFIG	03054H
	    #include <P16f630.INC>
	ERRORLEVEL      -302
Reg_1		equ	    0x20		
Reg_2		equ	    0x21
Reg_3		equ	    0x22
Reg_info	equ	    0x23		
STATUS		equ	    0x03
PORTA		equ	    0x05
PORTC		equ	    0x07		
TRISA		equ	    0x85
TRISC		equ	    0x87	
;*******************************************************************************		
		org	    0x00
;*******************************************************************************
		bcf	    STATUS,5
		movlw	    b'00000111'
		movwf	    CMCON
		clrf	    PORTA
		clrf	    PORTC
		bsf	    STATUS,5
		call	    0x3FF
		movwf	    OSCCAL		
		MOVLW	    b'00000000'
		MOVWF	    OPTION_REG	
		clrf	    TRISA
		clrf	    TRISC
		bcf	    TRISC,0
		bcf	    TRISC,1
		bsf	    TRISC,5
		bsf	    TRISA,2
		bsf	    TRISA,1
		bcf	    STATUS,5
		movlw	    b'00000000'
		movwf	    Reg_info
;*******************************************************************************
prog		call	    blok		
		btfss	    PORTA,1
		call	    aux
		goto	    prog
;*******************************************************************************
blok		btfsc	    PORTA,2
		return	
		call	    delay50ms
		btfsc	    PORTA,2
		return
		btfsc	    PORTC,5
		return
		call	    sekund_3.5		
		btfsc	    PORTC,5
		return
		call	    delay_20msekund
		call	    sekund_10.5info		
		bcf	    PORTC,0
		return		
;*******************************************************************************
aux		call	    delay50ms
		btfsc	    PORTA,1
		return
		btfss	    Reg_info,0
		call	    sekund_10.5aux		
		btfsc	    Reg_info,0
		call	    sekund_3.5aux
		
		return		
;*******************************************************************************		
sekund_3.5	bsf	    PORTC,1
		call	    delay_3.5		
		bcf	    PORTC,1
		return
;*******************************************************************************		
sekund_3.5aux	bsf	    PORTC,1
		call	    aux_3.5		
		bcf	    PORTC,1
		return		
;*******************************************************************************
sekund_10.5info	bsf	    PORTC,0
		call	    delay_1		
		;btfsc	    PORTC,5
		;return		
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return		
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		;btfsc	    PORTC,5
		;return	
		call	    delay_1		
		return	
;*******************************************************************************		
sekund_10.5aux	bsf	    PORTC,0
		call	    aux_10.5		
		bcf	    PORTC,0
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
		bcf	    PORTC,0
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
		bcf	    PORTC,1
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
delay_20msekund ;movlw       .238
		;movwf       Reg_1
		;movlw       .65
		;movwf       Reg_2
		;decfsz      Reg_1,F
		;goto        $-1
		;decfsz      Reg_2,F
		;goto        $-3
		;nop
		
		movlw       .173
		movwf       Reg_1
		movlw       .19
		movwf       Reg_2
		movlw       .6
		movwf       Reg_3
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		decfsz      Reg_3,F
		goto        $-5
		nop
		nop

		return
		
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
	
	


