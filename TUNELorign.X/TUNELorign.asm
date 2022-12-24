list p=12f675
	#include <P12f675.INC>
	ERRORLEVEL      -302    	
	__CONFIG	_MCLRE_OFF & _PWRTE_OFF & _WDT_OFF & _INTRC_OSC_NOCLKOUT & _BODEN_OFF
count		equ	0x26	
loops		equ	0x27	
loops2		equ	0x28
f0		equ	0x29	
f1		equ	0x2A
Uon1		equ	0x2B
Uon2		equ	0x2D
Uoff2		equ	0x2E
Reg_1		equ	0x31		
Reg_2		equ	0x32
Reg_3		equ	0x33		
	
		org	0x00	
		goto	Init
		
		org	0x04
		
	    movlw       .221
            movwf       Reg_1
            movlw       .130
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            nop
            nop

	    btfsc	TRISIO,2
	    return	    
	    bcf	    INTCON, INTF	    
analog	    bcf	    GPIO,5
	    ;btfss   TRISIO,3
	    ;call    sentrzamok
	    btfss   TRISIO,2
	    bsf	    GPIO,4
	    btfss   TRISIO,2
	    goto    analog
	    btfsc   TRISIO,2
	    bcf	    GPIO,4
	    btfsc   TRISIO,1	    
	    goto    Mainloop
	    goto    analog
	    
		
Init	    bcf	    STATUS, RP0		; Bank 0
	    clrf    GPIO			; aus!
	    movlw   b'00000111'
	    movwf   CMCON			; Comparator aus
	    bsf	    STATUS, RP0		; Bank 1
	   
	    bsf	    TRISIO,1
	    bsf	    TRISIO,2
	    bsf	    TRISIO,3
	    bcf	    TRISIO,5		; GP5 output f?r Schalttransistor oder LED
	    bcf	    TRISIO,4
	    bcf	    OPTION_REG,7	  ; podtyaguyushiy rezistor yoqildi
	    bcf	    OPTION_REG, INTEDG	;peredniy front
	    
	    bsf	    WPU, WPU1		;podtyaguyeshshiy rezistor gpio1 ga o`rnatildi	    
	    bsf	    WPU, WPU2	    
	    bsf	    WPU, WPU0
	    bcf	    STATUS, RP0		; Bank0 ; internen Taktgenerator kalibrieren
	    bsf	    STATUS, RP0		; Bank 1
	    movlw	    b'00000000'
	    movwf   OSCCAL			; 4-MHz-Kalibrierung
	    bcf	    STATUS, RP0		; Bank 0

	; Interrupt
	    bsf	    INTCON, GIE		; Int deaktiviert
	    bcf	    INTCON, PEIE		; Int deaktiviert
	    bsf	    INTCON, INTE		; Int deaktiviert
	    bcf	    INTCON, T0IE
	    bcf	    INTCON, GPIE
;******************************************************************************	
	    BSF	    ADCON0, ADON		
	    BCF	    ADCON0, CHS1	
	    BCF	    ADCON0, CHS0	
	    BSF	    STATUS,RP0	
	    clrf    ANSEL
	    BSF	    ANSEL, ADCS0	
	    BSF	    ANSEL, ANS0	
	    BCF	    STATUS,RP0		
	    BCF	    ADCON0, VCFG	
	    BCF	    ADCON0, ADFM
	    
	    movlw   0x47
	    movwf   Uon2
	    
	    movlw   0x27		; Uoff1  1,6V	   
	    movwf   Uoff2	
	    
	    movlw   0x81
	    movwf   Uon1
	    
	    ;movlw   0x42
	    ;movwf   Uoff1
;***********************************************************************
Mainloop    btfss	TRISIO,3
	    call	sentrzamok
	    btfss	TRISIO,2
	    goto	analog
	    btfsc	TRISIO,1
	    goto	zajiganiya
	    call	delay_4sekund
Mainloop1   btfss	TRISIO,3
	    call	sentrzamok
	    btfsc	TRISIO,1
	    goto	zajiganiya
	    btfss	TRISIO,2
	    call	analog
	    call	UMessen1	; AN0 nach f1,f0  (f1 is entscheidend)
	    call	LED		; LED ein-/ausschalten	    
	    goto	Mainloop1
;***********************************************************************
zajiganiya  bcf	    GPIO,5
	    bcf	    GPIO,4
	    goto	Mainloop
;***********************************************************************	    
UMessen1    BSF		ADCON0, 1	; ADC starten
loop	    BTFSC	ADCON0, 1	; ist der ADC fertig?
	    GOTO	loop		; nein, weiter warten
	    movfw	ADRESH		; obere  8 Bit auslesen
	    movwf	f1		; obere  8-Bit nach f1
	    bsf		STATUS,RP0	; Bank1
	    movfw	ADRESL		; untere 2 Bit auslesen, werden aber  nicht ben?tigt
	    bcf		STATUS,RP0	; Bank0
	    movwf	f0		; untere 2-Bit nach f0	    
	    clrf	count		; Warten, damit der ADC sich erholen kann
warten	    DECFSZ	count, f
	    goto	warten
	    return
;***********************************************************************	    
LED	    MOVFW	Uoff2
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	ochirish	      

	    MOVFW	Uon2
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	gabarityoqish
	    
	    MOVFW	Uon1
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	blijniyyoqish
	    
	    return	    
;***********************************************************************
sentrzamok  BSF		ADCON0, 1	; ADC starten
loopsentr   BTFSC	ADCON0, 1	; ist der ADC fertig?
	    GOTO	loopsentr		; nein, weiter warten
	    movfw	ADRESH		; obere  8 Bit auslesen
	    movwf	f1		; obere  8-Bit nach f1
	    bsf		STATUS,RP0	; Bank1
	    movfw	ADRESL		; untere 2 Bit auslesen, werden aber  nicht ben?tigt
	    bcf		STATUS,RP0	; Bank0
	    movwf	f0		; untere 2-Bit nach f0	    
	    clrf	count		; Warten, damit der ADC sich erholen kann
wartensentr DECFSZ	count, f
	    goto	wartensentr	    
	    
	    MOVFW	Uon2
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    return
	    bsf		GPIO,5
	    bsf		GPIO,4
	    movlw       .79
            movwf       Reg_1
            movlw       .25
            movwf       Reg_2
            movlw       .77
            movwf       Reg_3
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop
	    bcf		GPIO,5
	    bcf		GPIO,4
	    return
;***********************************************************************	    
UMessenonoff
	    BSF		ADCON0, 1	; ADC starten
looponoff   BTFSC	ADCON0, 1	; ist der ADC fertig?
	    GOTO	looponoff		; nein, weiter warten
	    movfw	ADRESH		; obere  8 Bit auslesen
	    movwf	f1		; obere  8-Bit nach f1
	    bsf		STATUS,RP0	; Bank1
	    movfw	ADRESL		; untere 2 Bit auslesen, werden aber  nicht ben?tigt
	    bcf		STATUS,RP0	; Bank0
	    movwf	f0		; untere 2-Bit nach f0	    
	    clrf	count		; Warten, damit der ADC sich erholen kann
wartenonoff DECFSZ	count, f
	    goto	wartenonoff	    
	    return
;***********************************************************************	    
blijniyyoqish
	     movlw       .85
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
	    call    UMessenonoff
	    MOVFW   Uon1
	    subwf   f1, w		; w:=f1-w 
	    btfsc   STATUS, C
	    bsf	    GPIO,5
	    return	        
	    
gabarityoqish
	    movlw       .85
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
	    call    UMessenonoff
	    MOVFW   Uon2
	    subwf   f1, w		; w:=f1-w 
	    btfsc   STATUS, C
	    bsf	    GPIO,4
	    return	    
;***********************************************************************
ochirish    btfss	GPIO,4
	    return	    
	    movlw       .223
            movwf       Reg_1
            movlw       .187
            movwf       Reg_2
            movlw       .51
            movwf       Reg_3
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
            decfsz      Reg_3,F
            goto        $-5
            nop
            nop
	    call	UMessenonoff
	    MOVFW	Uoff2
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	off
	    return
	    
off	    bcf		GPIO,5		; LED aus
	    bcf		GPIO,4		; LED aus
	    return
;***********************************************************************	    
delay_4sekund
	    movlw       .190
            movwf       Reg_1
            movlw       .75
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
	    return	    
		end









