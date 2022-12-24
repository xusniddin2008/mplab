list p=12f675
	#include <P12f675.INC>
	ERRORLEVEL      -302    	
	__CONFIG  00054H
	;__CONFIG	_MCLRE_OFF & _PWRTE_OFF & _WDT_OFF & _INTRC_OSC_NOCLKOUT & _BODEN_OFF
	#define   IR_LED    GPIO,2 ; ???????????? ?????????
count		equ	0x20	
f0		equ	0x23	
f1		equ	0x24	 
strelkapasmax	equ	0x25	
strelkapasmin	equ	0x26	
qizilmax	equ	0x27
qizilmin	equ	0x28
powermax	equ	0x29
powermin	equ	0x2A
strelkachapmax	equ	0x2B
strelkachapmin	equ	0x2C
strelkaonmax	equ	0x2D
strelkaonmin	equ	0x2E
Reg_1		equ	0x32		
Reg_2		equ	0x33
Reg_3		equ	0x34
volumpasmax	equ	0x38
volumpasmin	equ	0x39
volumtepamax	equ	0x3A
volumtepamin	equ	0x3B
strelkatepamax	equ	0x3C
strelkatepamin	equ	0x3D
fCOUNTER	equ	0x3E
fCOUNTER2	equ	0x3F 
yashilmax	equ	0x40
yashilmin	equ	0x41	
	org	0x00
	goto	Init
;***********************************************************************
Init	    bcf	    STATUS, RP0		; Bank 0
	    clrf    GPIO			; aus!
	    movlw   b'00000111'
	    movwf   CMCON			; Comparator aus
	    bsf	    STATUS, RP0		; Bank 1
	    bcf	    TRISIO,2
	    bsf	    TRISIO,4
	    bsf	    STATUS, RP0		; Bank 1
	    call    0x3FF
	    movwf   OSCCAL			; 4-MHz-Kalibrierung
	    bcf	    STATUS, RP0		; Bank 0
	    bcf	    INTCON, GIE		; Int deaktiviert
;******************************************************************************
	    BSF	    ADCON0, ADON	; ADON=1
	    BSF	    ADCON0, CHS1	; ADCHS1=0
	    BSF	    ADCON0, CHS0	; ADCHS0=0
	    BSF	    STATUS,RP0	; Bank1
	    clrf    ANSEL
	    BSF	    ANSEL, ADCS0	; ADCS0=1 Fosc/8
	    BSF	    ANSEL, ANS3
	    BCF	    STATUS,RP0	; Bank0
	    BCF	    ADCON0, VCFG	; RA2=digital
	    BCF	    ADCON0, ADFM	; ADFM=1 linksb?ndig
	    
	    movlw   0xFC		;4.85V	    
	    movwf   strelkapasmax
	    movlw   0xE4		;4.45V
	    movwf   strelkapasmin
	    movlw   0xE4		; 4.45V
	    movwf   qizilmax
	    movlw   0xCF		; 3.97V
	    movwf   qizilmin
	    movlw   0xCF		; 3.97V
	    movwf   yashilmax
	    movlw   0xC5 		; 3.80V
	    movwf   yashilmin
	    movlw   0xC5		; 3.80V
	    movwf   powermax
	    movlw   0xBE		; 3.55V
	    movwf   powermin
	    movlw   0xBE		; 3.55V
	    movwf   strelkachapmax
	    movlw   0xAE		; 3.32V
	    movwf   strelkachapmin
	    movlw   0xAE		; 3.32V
	    movwf   strelkaonmax
	    movlw   0x9F		; 3.08V
	    movwf   strelkaonmin
	    movlw   0x9F		; 3.08V
	    movwf   volumpasmax
	    movlw   0x92		; 2.85V
	    movwf   volumpasmin
	    movlw   0x92		; 2.85V
	    movwf   volumtepamax	    
	    movlw   0x44		; 1.32V
	    movwf   volumtepamin	    
	    movlw   0x44		; 1.32V
	    movwf   strelkatepamax
	    movlw   0x01		; 0.00V
	    movwf   strelkatepamin
;***********************************************************************
Mainloop    call	UMessen1	; AN0 nach f1,f0  (f1 is entscheidend)
	    call	LED		; LED ein-/ausschalten
	    goto	Mainloop
;***********************************************************************
UMessen1    BSF	    ADCON0, 1	; ADC starten	    
loop	    BTFSC   ADCON0, 1	; ist der ADC fertig?
	    GOTO    loop		; nein, weiter warten	    
	    movfw   ADRESH		; obere  8 Bit auslesen
	    movwf   f1		; obere  8-Bit nach f1
	    bsf	    STATUS,RP0	; Bank1
	    movfw   ADRESL		; untere 2 Bit auslesen, werden aber  nicht ben?tigt
	    bcf	    STATUS,RP0	; Bank0
	    movwf   f0		; untere 2-Bit nach f0
            movlw       .165
            movwf       Reg_1
            movlw       .51
            movwf       Reg_2
            decfsz      Reg_1,F
            goto        $-1
            decfsz      Reg_2,F
            goto        $-3
	    return
;***********************************************************************
LED	    MOVFW	strelkapasmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	strelkapas		; LED an

	    MOVFW	qizilmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	qizil		; LED an
	    
	    MOVFW	yashilmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	yashil		; LED an

	    MOVFW	powermax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	power		; LED an

	    MOVFW	strelkachapmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	strelkachap	; LED an

	    MOVFW	strelkaonmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	strelkaon	; LED an

	    MOVFW	volumpasmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	volumpas	; LED an

	    MOVFW	volumtepamax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	volumtepa	; LED an

	    MOVFW	strelkatepamax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	strelkatepa	; LED an
	    return
;***********************************************************************
strelkapas  MOVFW	strelkapasmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmstrelkapas
	    return
qizil	    MOVFW	qizilmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmqizil
	    return
yashil	    MOVFW	yashilmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmyashil
	    return	    
power	    MOVFW	powermin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmpower
	    return
strelkachap MOVFW	strelkachapmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmstrelkachap
	    return	
strelkaon   MOVFW	strelkaonmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmstrelkaon
	    return	
volumpas    MOVFW	volumpasmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmvolumpas
	    return	
volumtepa   MOVFW	volumtepamin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmvolumtepa
	    return	
strelkatepa MOVFW	strelkatepamin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmstrelkatepa
	    return	
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Big_delay ;=770*x+1     x=(delay-5)/770 ???????? ?????????? call ? return.
        movwf   fCOUNTER2
        clrf    fCOUNTER
BD_Loop94
        decfsz  fCOUNTER,1
        goto    BD_Loop94
        decfsz  fCOUNTER2,1
        goto    BD_Loop94
        return
;-----------------------------------------------------------------------------
	
	
cmstrelkachap	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_1;      // 42
		call    Send_0;      // 43
		call    Send_0;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_1;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43		
		movlw	d'32'
		call	Big_delay
		return

cmqizil		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_1;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call    Send_1;      // 35
		call    Send_0;      // 36
		call    Send_0;      // 37
		call    Send_0;      // 38
		call    Send_1;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43		
		movlw	d'32'
		call	Big_delay
		return

cmyashil	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_1;      // 42
		call    Send_0;      // 43
		call    Send_0;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43		
		movlw	d'32'
		call	Big_delay
		return
	
cmpower		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_1;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call	Send_1;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
		
	
cmstrelkapas	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_1;      // 42
		call    Send_0;      // 43
		call	Send_0;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
		
	
cmstrelkatepa	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_1;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call	Send_1;      // 35
		call    Send_0;      // 36
		call    Send_0;      // 37
		call    Send_0;      // 38
		call    Send_1;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
cmvolumpas	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_1;      // 42
		call    Send_0;      // 43
		call	Send_1;      // 35
		call    Send_0;      // 36
		call    Send_0;      // 37
		call    Send_0;      // 38
		call    Send_1;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
cmvolumtepa	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_1;      // 40
		call    Send_0;      // 41
		call    Send_1;      // 42
		call    Send_0;      // 43
		call	Send_0;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_1;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
		

cmstrelkaon	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    Send_1;      // 38
		call    Send_0;      // 39
		call    Send_1;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_0;      // 43
		call	Send_1;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_1;      // 39
		call    Send_0;      // 40
		call    Send_0;      // 41
		call    Send_0;      // 42
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
yarmi		call    Send_1;      // 86
		call    Send_0;      // 87
		call    Send_1;      // 88
		call    Send_0;      // 89
		call    Send_0;      // 0
		call    Send_0;      // 1
		call    Send_1;      // 2
		call    Send_0;      // 3
		call    Send_0;      // 4
		call    Send_0;      // 5
		call    Send_1;      // 6
		call    Send_0;      // 7
		call    Send_1;      // 8
		call    Send_0;      // 9
		call    Send_1;      // 10
		call    Send_0;      // 11
		call    Send_1;      // 12
		call    Send_0;      // 13
		call    Send_1;      // 14
		call    Send_0;      // 15
		call    Send_0;      // 16
		call    Send_0;      // 17
		call    Send_1;      // 19
		call    Send_0;      // 20
		call    Send_1;      // 21
		call    Send_0;      // 22
		call    Send_0;      // 23
		call    Send_0;      // 24
		call    Send_1;      // 25
		call    Send_0;      // 26
		call    Send_1;      // 27
		call    Send_0;      // 28
		call    Send_1;      // 29
		call    Send_0;      // 30
		call    Send_0;      // 31
		call    Send_0;      // 32
		call    Send_1;      // 33
		call    Send_0;      // 34
		call    Send_0;      // 35
		call    Send_0;      // 36
		call    Send_1;      // 37
		call    Send_0;      // 38
		call    Send_0;      // 39
		call    Send_0;      // 40
		call    Send_1;      // 41
		call    Send_0;      // 42
		return

		
Send_1 		movlw   d'19'	    ; 527 millisekund
		movwf   Reg_1
Send1_Loop	bsf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		bcf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		decfsz  Reg_1,1
		goto    Send1_Loop
		return
;-----------------------------------------------------------------------------		
Send_0		movlw   d'19'	;527 millisekund
		movwf   Reg_1
Send0_Loop	bcf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		bcf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		decfsz  Reg_1,1
		goto    Send0_Loop
		return
;-----------------------------------------------------------------------------
delayy9ms       movlw   d'185'
		movwf   Reg_1
Send0_Loopp	bsf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		bcf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		decfsz  Reg_1,1
		goto    Send0_Loopp
		movlw   d'132'
		movwf   Reg_1
Send0_Loopp1	bsf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		bcf     IR_LED
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		decfsz  Reg_1,1
		goto    Send0_Loopp1
		return
delayy4.5ms	movlw       .170
		movwf       Reg_1
		movlw       .6
		movwf       Reg_2
		decfsz      Reg_1,F
		goto        $-1
		decfsz      Reg_2,F
		goto        $-3
		return
;-----------------------------------------------------------------------------	
		end









