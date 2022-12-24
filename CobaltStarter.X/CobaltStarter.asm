; Mehribon va Rahmli Alloh nomi bilan	    
	    LIST	p=16F628A
	    ;__CONFIG	02170H
	    __CONFIG	00010H
	    #include <P16f628A.INC>
	ERRORLEVEL      -302		    
PORTB	    equ		06h
TRISB	    equ		86h
STATUS	    equ		03h
PORTA	    equ		05h
TRISA	    equ		85h
Reg_1	    equ		20h
Reg_2	    equ		21h
Reg_3	    equ		22h
Regstart    equ		23h	    
VRCON	    equ		9Fh
    
	    ORG		0x000	    	   
;-------------------------------------------------------------------------------	    
	    bcf		STATUS,5
	    clrf	PORTA
	    clrf	PORTB
	    bsf		STATUS,5	    
	    bsf		PCON,3
	    bcf		PCON,1
	    bsf		PCON,0	    
	    MOVLW	b'10000000'	   
	    MOVWF	OPTION_REG	    
	    CLRF	TRISB
	    CLRF	TRISA
	    bsf		TRISA,1
	    bcf		TRISA,2
	    bsf		TRISA,2
	    bsf		TRISB,0
	    bsf		TRISB,1
	    bsf		TRISB,2
	    bcf		TRISA,0
	    bcf		TRISA,6
	    bcf		TRISA,7
	    bcf		TRISB,3
	    bcf		TRISB,4
	    bcf		TRISB,5
	    bcf		TRISB,6
	    bcf		TRISB,7
	    bcf		STATUS,5	    
	    MOVLW	7	    
	    MOVWF	CMCON         ; Comparators off, all pins digital I/O	    
;-------------------------------------------------------------------------------
;prerevaniya btfss	PORTA,2
	    ;goto	margat	    
;-------------------------------------------------------------------------------	    
	    
programma   btfss	PORTA,2
	    goto	ahrana1	    
	    goto	programma
;-------------------------------------------------------------------------------
tormoz	    clrf	PORTA
	    clrf	PORTB	    
	    goto	programma	    
;-------------------------------------------------------------------------------
start	    bcf		PORTB,4	    
	    bsf		PORTB,6
	    call	delaystart	    
	    bsf		PORTB,5
	    call	delay520ms
	    btfss	PORTB,0 ; knopka generator
	    call	delay3sek	    	    
	    bcf		PORTB,5	    
	    bsf		PORTB,4
	    bsf		PORTB,6	    
start1	    btfsc	PORTB,1
	    goto	tormoz
	    bcf		PORTB,5	    
	    bsf		PORTB,4
	    bsf		PORTB,6	    
	    goto	start1
;-------------------------------------------------------------------------------	    
ahrana1	    
	    movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
	    btfss	PORTA,2
	    goto	ahrana1

	    
	    
	    movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
            movwf       Reg_3
	    btfss	PORTA,2
	    goto	ahrana2
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop

	    goto	programma
;-------------------------------------------------------------------------------	    
ahrana2	    
	    movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
	    btfss	PORTA,2
	    goto	ahrana2
	    
	    movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
            movwf       Reg_3
	    btfss	PORTA,2
	    goto	start
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop     
	    goto	programma
;-------------------------------------------------------------------------------	    
ahrana3	    
	    movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
	    btfss	PORTA,2
	    goto	ahrana3

	    movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
            movwf       Reg_3
	    btfss	PORTA,2
	    goto	start
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop        
	    goto	programma	    
;-------------------------------------------------------------------------------	    
delayknopka movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
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
	    
delay3sek   movlw       .2
            movwf       Reg_1
            movlw       .7
            movwf       Reg_2
            movlw       .9
            movwf       Reg_3
	    btfsc	PORTB,0 ; knopka generator
	    return
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop            
	    return

delaystart  movlw       .73
            movwf       Reg_1
            movlw       .153
            movwf       Reg_2
            movlw       .7
            movwf       Reg_3
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
	    return	    
	    

bigdelay    movlw       .13
            movwf       Reg_1
            movlw       .57
            movwf       Reg_2
            movlw       .16
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
	    
delay20ms   movlw       .186
            movwf       Reg_1
            movlw       .4
            movwf       Reg_2
            movlw       .2
            movwf       Reg_3
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
	    return
	    
delay520ms  movlw       .75
            movwf       Reg_1
            movlw       .177
            movwf       Reg_2
            movlw       .3
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

	    

;-------------------------------------------------------------------------------	    
	    end






