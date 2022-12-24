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
Reg_4	    equ		24h	    
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
programma   movlw       .2
            movwf       Regstart
	    bsf		PORTA,7
	    btfss	PORTA,2
	    goto	ahrana
	    btfsc	PORTB,4
	    goto	ahrana
	    btfsc	PORTB,1
	    call	tormoz
	    btfsc	PORTA,1
	    goto	magnitafon
	    btfsc	PORTB,0 ; knopka generator
	    bsf		PORTB,7
	    btfss	PORTB,0 ; knopka generator
	    bcf		PORTB,7
	    goto	programma
;-------------------------------------------------------------------------------
magnitafon  btfsc	PORTB,0 ; knopka generator
	    goto	programma
	    call	delayknopka
	    btfsc	PORTA,1
	    call	knopkauderjatstart
magnitafon1 btfss	PORTA,2
	    goto	ahrana
	    btfsc	PORTB,0 ; knopka generator
	    bsf		PORTB,7
	    btfss	PORTB,0 ; knopka generator
	    bcf		PORTB,7	    
	    bsf		PORTA,7
	    bsf		PORTB,3
	    bsf		PORTA,0
	    btfsc	PORTB,1
	    call	tormozmag
	    btfsc	PORTA,1
	    goto	zajiganiya
	    goto	magnitafon1
;-------------------------------------------------------------------------------
tormozmag   btfsc	PORTB,0 ; knopka generator
	    goto	magnitafon1
	    btfsc	PORTA,1
	    call	startmag
	    bsf		PORTB,3
	    goto	magnitafon1
;-------------------------------------------------------------------------------
startmag    btfsc	PORTB,2 ;knopka karobka
	    goto	karobkamag	
	    bsf		PORTA,6
	    bcf		PORTB,3
	    bcf		PORTB,4
	    call	delayzvuk
	    bcf		PORTA,6	        
	    bsf		PORTB,6
	    bsf		PORTA,0	    
	    call	delaystart	    
	    bsf		PORTB,5
	    call	delay520ms
	    btfss	PORTB,0 ; knopka generator
	    call	delay3sek	    	    
	    bcf		PORTB,5
	    bsf		PORTB,3
	    bsf		PORTB,4
	    bsf		PORTB,6
	    bsf		PORTA,7
	    bsf		PORTA,0	    
	    call	bigdelay	    
	    btfss	PORTB,0 ; knopka generator
	    clrf	PORTB
	    btfss	PORTB,0 ; knopka generator
	    clrf	PORTA
	    bsf		PORTA,7
	    bsf		PORTB,3
	    btfsc	PORTB,0 ; knopka generator
	    goto	start1
	    return
;-------------------------------------------------------------------------------	    
karobkamag  bsf		PORTA,6	
	    call	delayzvuk
	    bcf		PORTA,6
	    call	delayzvuk
	    bsf		PORTA,6
	    call	delayzvuk
	    bcf		PORTA,6	    
	    call	delaystart
	    goto	magnitafon1    
;-------------------------------------------------------------------------------
zajiganiya  btfsc	PORTB,0 ; knopka generator
	    goto	magnitafon1
	    call	delayknopka
	    btfsc	PORTA,1
	    call	knopkauderjatstart
zajiganiya1 btfss	PORTA,2
	    goto	ahrana
	    btfsc	PORTB,0 ; knopka generator
	    bsf		PORTB,7
	    btfss	PORTB,0 ; knopka generator
	    bcf		PORTB,7	    
	    bsf		PORTA,0
	    bsf		PORTA,7
	    bsf		PORTB,3
	    bsf		PORTB,4
	    bsf		PORTB,6
	    btfsc	PORTB,1
	    call	tormozzaj
	    btfsc	PORTA,1
	    goto	metkaclrf	    
	    goto	zajiganiya1
;-------------------------------------------------------------------------------
startzaj    btfsc	PORTB,2 ;knopka karobka
	    goto	karobkazaj	
	    bsf		PORTA,6
	    bcf		PORTB,3
	    bcf		PORTB,4
	    call	delayzvuk
	    bcf		PORTA,6	        
	    bsf		PORTB,6
	    bsf		PORTA,0	    
	    call	delaystart	    
	    bsf		PORTB,5
	    call	delay520ms
	    btfss	PORTB,0 ; knopka generator
	    call	delay3sek	    	    
	    bcf		PORTB,5
	    bsf		PORTB,3
	    bsf		PORTB,4
	    bsf		PORTB,6
	    bsf		PORTA,7
	    bsf		PORTA,0	    
	    call	bigdelay	    
	    btfss	PORTB,0 ; knopka generator
	    clrf	PORTB
	    btfss	PORTB,0 ; knopka generator
	    clrf	PORTA
	    bsf		PORTA,7
	    bsf		PORTB,3
	    btfsc	PORTB,0 ; knopka generator
	    goto	start1
	    return
;-------------------------------------------------------------------------------	    
karobkazaj  bsf		PORTA,6	
	    call	delayzvuk
	    bcf		PORTA,6
	    call	delayzvuk
	    bsf		PORTA,6
	    call	delayzvuk
	    bcf		PORTA,6	    
	    call	delaystart
	    goto	zajiganiya1  	    
;-------------------------------------------------------------------------------
tormozzaj   btfsc	PORTB,0 ; knopka generator
	    goto	start1
	    btfsc	PORTA,1
	    call	startzaj
	    bsf		PORTB,3
	    goto	zajiganiya1	    
;-------------------------------------------------------------------------------
tormoz	    btfsc	PORTA,1
	    goto	start	    
	    goto	programma
;-------------------------------------------------------------------------------
start	    btfsc	PORTB,2 ;knopka karobka
	    goto	karobka	
	    bsf		PORTA,6
	    bcf		PORTB,3
	    bcf		PORTB,4
	    call	delayzvuk
	    bcf		PORTA,6	        
	    bsf		PORTB,6
	    bsf		PORTA,0	    
	    call	delaystart	    
	    bsf		PORTB,5
	    call	delay520ms
	    btfss	PORTB,0 ; knopka generator
	    call	delay3sek	    	    
	    bcf		PORTB,5
	    bsf		PORTB,3
	    bsf		PORTB,4
	    bsf		PORTB,6
	    bsf		PORTA,7
	    bsf		PORTA,0	    
	    call	bigdelay	    
	    btfss	PORTB,0 ; knopka generator
	    goto	metkaclrf
start1	    btfss	PORTA,2
	    goto	ahrana
	    bcf		PORTB,5
	    bsf		PORTB,3
	    bsf		PORTB,4
	    bsf		PORTB,6
	    bsf		PORTA,7
	    bsf		PORTA,0
	    btfsc	PORTB,0 ; knopka generator
	    bsf		PORTB,7
	    btfss	PORTB,0 ; knopka generator
	    goto	zajiganiya1
	    btfss	PORTB,0 ; knopka generator
	    bcf		PORTB,7
	    btfsc	PORTA,1
	    call	stop
	    goto	start1	
;-------------------------------------------------------------------------------
pavtor	    decfsz      Regstart,F
            goto        start
	    return
;-------------------------------------------------------------------------------	    
karobka	    bsf		PORTA,6	
	    call	delayzvuk
	    bcf		PORTA,6
	    call	delayzvuk
	    bsf		PORTA,6
	    call	delayzvuk
	    bcf		PORTA,6
	    bcf		PORTB,3
	    bcf		PORTB,6
	    bcf		PORTA,0
	    call	delaystart
	    goto	programma	    
;-------------------------------------------------------------------------------
helpstart   bsf		PORTA,6
	    bcf		PORTB,3
	    call	delayzvuk
	    bcf		PORTA,6
	    btfsc	PORTB,2 ;knopka karobka
	    return	    
	    bsf		PORTB,6
	    bsf		PORTA,0	    
	    call	delaystart	    
	    bsf		PORTB,5
	    call	delay520ms
	    btfss	PORTB,0 ; knopka generator
	    call	delay3sek	
helpstart1  bcf		PORTB,5
	    bsf		PORTB,3
	    bsf		PORTB,4	    
	    call	bigdelay	    
	    btfss	PORTB,0 ; knopka generator
	    goto	metkaclrfstart	    
	    goto	start1	
;-------------------------------------------------------------------------------
stop	    call	delayknopka
	    btfsc	PORTA,1
	    call	knopkauderjatstop
	    btfsc	PORTB,1
	    goto	metkaclrfstart
	    return
;-------------------------------------------------------------------------------	    
ahrana	    clrf	PORTA
	    clrf	PORTB
	    call	delayknopka
	    btfsc	PORTA,2
	    goto	programma
	    btfsc	PORTB,4
	    goto	cobalt_starter1
	    btfss	PORTB,0
	    call	ahrana
margat	    btfsc	PORTB,1
	    goto	ahranastart
	    bsf		PORTA,7
	    call	delaymargat
	    bcf		PORTA,7
	    call	delaymargat
	    btfsc	PORTB,0
	    
	    goto        margat
	    goto	ahrana
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------	    
cobalt_starter1	    
	    movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
	    btfsc	PORTB,4
	    goto	cobalt_starter1

	    
	    
	    movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
            movwf       Reg_3
	    btfsc	PORTB,4
	    goto	cobalt_starter2
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
cobalt_starter2	    
	    movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
	    btfsc	PORTB,4
	    goto	cobalt_starter2
	    
	    movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
            movwf       Reg_3
	    btfsc	PORTB,4
	    goto	cobalt_starter3
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop     
	    goto	ahrana
;-------------------------------------------------------------------------------	    
cobalt_starter3	    
	    movlw       .238
            movwf       Reg_1
            movlw       .65
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
	    btfsc	PORTB,4
	    goto	cobalt_starter3
	    
	    movlw       .85
            movwf       Reg_1
            movlw       .138
            movwf       Reg_2
            movlw       .3
            movwf       Reg_3
	    btfsc	PORTB,4
	    goto	cobalt_starter4
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop     
	    goto	ahrana	    
;-------------------------------------------------------------------------------	    
cobalt_starter4
	    btfsc	PORTB,2 ;knopka karobka
	    goto	karobka	
	    bsf		PORTA,6
	    
	    call	delayzvuk
	    bcf		PORTA,6	        
	    bsf		PORTB,6
	    bsf		PORTA,0	    
	    call	delaystart	    
	    bsf		PORTB,5
	    call	delay520ms
	    btfss	PORTB,0 ; knopka generator
	    call	delay3sek	    	    
	    bcf		PORTB,5
	    
	    
	    bsf		PORTB,6
	    bsf		PORTA,7
	    bsf		PORTA,0	    
	    call	bigdelay	    
	    btfss	PORTB,0 ; knopka generator
	    goto	metkaclrf
start2	    
	    bcf		PORTB,5
	    bsf		PORTB,3
	    
	    bsf		PORTB,6
	    bsf		PORTA,7
	    bsf		PORTA,0
	    btfsc	PORTB,0 ; knopka generator
	    bsf		PORTB,7
	    
	    
		    
	    call	delay10min	    
	    goto	ahrana	
;-------------------------------------------------------------------------------	    
ahranastart call	margat1
	    bsf		PORTB,7
	    bsf		PORTA,0
	    bsf		PORTB,3
	    bsf		PORTB,4
	    bsf		PORTB,6
	    btfsc	PORTB,0 ; knopka generator
	    bsf		PORTB,7
	    btfss	PORTB,0 ; knopka generator
	    bcf		PORTB,7
	    btfss	PORTA,2 ;knopka ohrana
	    goto	ahranastart
	    goto	start1
;-------------------------------------------------------------------------------	    
margat1	    bsf		PORTA,7
	    call	delaymargat
	    bcf		PORTA,7
	    call	delaymargat
	    return	    
;-------------------------------------------------------------------------------	    
knopkauderjatstart
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
startpoyla  btfsc	PORTA,1
	    goto	startpoyla
	    call	helpstart
;-------------------------------------------------------------------------------
knopkauderjatstop
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
	    btfss	PORTA,1
	    return
	    call	delayknopka
stoppoyla   btfsc	PORTA,1
	    goto	stoppoyla
	    call	metkaclrfstart
	    	    
	    
;-------------------------------------------------------------------------------	    
metkaclrf   btfsc	PORTB,0 ; knopka generator
	    goto	zajiganiya1
	    call	delayknopka
	    clrf	PORTA
	    clrf	PORTB
	    bsf		PORTA,7	    
	    goto	programma
;-------------------------------------------------------------------------------	    
metkaclrfstart	    
	    clrf	PORTA
	    clrf	PORTB
	    bsf		PORTA,7
	    call	bigdelay
	    goto	programma	    	    
;-------------------------------------------------------------------------------
delay10min  movlw       .177
            movwf       Reg_1
            movlw       .72
            movwf       Reg_2
            movlw       .35
            movwf       Reg_3
            movlw       .8
            movwf       Reg_4
	    btfsc	PORTB,1
	    goto	start1
            decfsz      Reg_1,F
            goto        $-3
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            decfsz      Reg_4,F
            goto        $-7
	    return
	    
delaymargat movlw       .153
            movwf       Reg_1
            movlw       .134
            movwf       Reg_2
            movlw       .2
            movwf       Reg_3
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5	    
	    return	
	    
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
	    
delayzvuk   movlw       .105
            movwf       Reg_1
            movlw       .85
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
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






