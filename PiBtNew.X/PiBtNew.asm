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
	    
	    movlw   0xFD		;4.84V
	    movwf   powermax
	    movlw   0xF4		;4.69V
	    movwf   powermin
	    movlw   0xF4		; 4.64V
	    movwf   yashilmax
	    movlw   0xEC		; 4.56V
	    movwf   yashilmin
	    movlw   0xEC		; 4.46V
	    movwf   qizilmax
	    movlw   0xCF		; 4.38V
	    movwf   qizilmin
	    movlw   0xCF		; 3.77V
	    movwf   volumtepamax
	    movlw   0x55		; 3.69V
	    movwf   volumtepamin
	    movlw   0x55		; 0.01V
	    movwf   volumpasmax
	    movlw   0x02		; 0.06V
	    movwf   volumpasmin
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
LED	    MOVFW	powermax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	power		; LED an
	    
	    	    
	    MOVFW	yashilmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	yashil		; LED an

	    MOVFW	qizilmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	qizil		; LED an
	    
	    MOVFW	volumtepamax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	volumtepa	; LED an
	   

	    MOVFW	volumpasmax
	    subwf	f1, w		; w:=f1-w 
	    btfss	STATUS, C
	    call	volumpas	; LED an	    
	    return
;***********************************************************************
power	    MOVFW	powermin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmpower
	    return
	    
yashil	    MOVFW	yashilmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	yashiluderjat
	    return	    
	    
qizil	    MOVFW	qizilmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	qiziluderjat
	    return
	    
volumtepa   MOVFW	volumtepamin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmvolumtepa
	    return	
	    
volumpas    MOVFW	volumpasmin
	    subwf	f1, w		; w:=f1-w 
	    btfsc	STATUS, C
	    call	cmvolumpas
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
qiziluderjat	call	delay250ms
		call	UMessen1
		
		MOVFW	qizilmax
		subwf	f1, w		; w:=f1-w 
		btfsc	STATUS, C
		
		call	cmqizil		
		call	cmmute
		
		call	delay250ms
		
krug		call	UMessen1
		MOVFW	qizilmax
		subwf	f1, w		; w:=f1-w 
		btfss	STATUS, C
		
		
		goto	krug
		goto	Mainloop
;-----------------------------------------------------------------------------
yashiluderjat	call	delay250ms
		call	UMessen1
		
		MOVFW	yashilmax
		subwf	f1, w		; w:=f1-w 
		btfsc	STATUS, C
		
		call	cmyashil			
		call	cmpause
		
		call	delay250ms
		
krug1		call	UMessen1
		MOVFW	yashilmax
		subwf	f1, w		; w:=f1-w 
		btfss	STATUS, C
		
		
		goto	krug1
		goto	Mainloop		
;-----------------------------------------------------------------------------	
poweruderjat
		call	delay250ms
		call	UMessen1
		
		MOVFW	powermax
		subwf	f1, w		; w:=f1-w 
		btfsc	STATUS, C
		
		call	cmpower	
		call	cmequalizer
		
		call	delay250ms
		
krug2		call	UMessen1
		MOVFW	powermax
		subwf	f1, w		; w:=f1-w 
		btfss	STATUS, C
		
		
		goto	krug2
		goto	Mainloop		
;-----------------------------------------------------------------------------			
cmstrelkapas	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101000
		call    metka10101010101000
		call    metka10101000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
cmqizil
		call	bt
		call	delayy9ms
		call	delayy4.5ms
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000
		call    metka101000
		call    metka101010101000
		call    metka101000
		call    metka101000
		call    metka1000
		call    metka10101000
		call    metka1000
		call    metka101010101000
		call    metka1000
		call    metka10101000
		call    metka1000
		call    Send_1;      // 88
		call    Send_0;      // 89
		movlw	d'32'
		call	Big_delay
		call	cmstrelkatepa
		goto	Mainloop
		
		
cmmute		call	cmmute1
		call	delayy9ms
		call	delayy4.5ms
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000
		call    metka101000
		call    metka101010101000
		call    metka101000
		call    metka10101010101000
		call    metka1000
		call    metka10101000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka10101000
		call    metka1000
		call    Send_1;      // 88
		call    Send_0;      // 89
		movlw	d'32'
		call	Big_delay
		return		
cmyashil
		call	bt
		call	delayy9ms
		call	delayy4.5ms
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000
		call    metka101000
		call    metka101010101000
		call    metka101000
		call    metka10101000
		call    metka10101000
		call    metka1000
		call    metka10101000
		call    metka101000
		call    metka1000
		call    metka10101000
		call    metka1000
		call    Send_1;      // 88
		call    Send_0;      // 89
		movlw	d'32'
		call	Big_delay
		call	cmstrelkaon
		goto	Mainloop
		
		
cmpause		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101010101000
		call    metka1000
		call    metka101000	
		call    metka101000	
		call    metka1000
		call    metka1000
		call    metka10101000
		call    metka101000
		call    Send_1;      // 88
		call    Send_0;      // 89
		movlw	d'32'
		call	Big_delay
		return
	
cmpower		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka10101000
		call    metka101000
		call    metka1000
		call    metka1010101000
		call    metka101000
		call    metka10101000
		call    metka1000
		call    metka1000
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return

cmequalizer	call	delayy9ms
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
		movlw	d'320'
		call	Big_delay
		return
		
cmstrelkachap	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka10101000
		call    metka101010101000
		call    metka101000	
		call    metka101000	
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000
		call    Send_1;      // 89
		call    Send_0;      // 90
		movlw	d'32'
		call	Big_delay
		return
cmstrelkaon	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101000
		call    metka1000
		call    metka101010101000
		call    metka1010101000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000	
		call    Send_1;      // 89
		call    Send_0;      // 90
		movlw	d'32'
		call	Big_delay
		return
cmvolumpas	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101000	
		call    metka1000
		call    metka101000	
		call    metka1010101010101000
		call    metka101000
		call    metka1000
		call    metka1000
		call    metka1000
		call    Send_1;      // 89
		call    Send_0;      // 90
		movlw	d'32'
		call	Big_delay
		return
cmvolumtepa	call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka10101000
		call    metka101000
		call    metka101010101000
		call    metka101000
		call    metka101000
		call    metka1000
		call    metka1000
		call    metka1000
		call    Send_1;      // 89
		call    Send_0;      // 90
		movlw	d'32'
		call	Big_delay
		return
cmstrelkatepa
		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101010101010101000
		call    metka101000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka1000
		call    metka101000
		call    Send_1;      // 88
		call    Send_0;      // 89
		movlw	d'32'
		call	Big_delay
		return
		
yarmi		call    metka1000
		call    metka101000
		call    metka1000
		call    metka101000		
		call    metka101000
		call    metka101000
		call    metka10101000
		call    metka101000		
		return
bt		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101000
		call    metka1000
		call    metka1000
		call    metka101000
		call    metka10101000
		call    metka1010101000
		call    metka101000
		call    metka1000
		call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
		
cmmute1		call	delayy9ms
		call	delayy4.5ms
		call	yarmi
		call    metka101000
		call    metka10101000
		call    metka1000
		call    metka101010101000
		call    metka1000
		call    metka10101000
		call    metka1000
		call    metka1000
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
		
metka101010101010101000	
		call    Send_1;      // 43
		call    Send_0;      // 43		
metka1010101010101000	
		call    Send_1;      // 43
		call    Send_0;      // 43		
metka10101010101000	
		call    Send_1;      // 43
		call    Send_0;      // 43		
metka101010101000	
		call    Send_1;      // 43
		call    Send_0;      // 43		
metka1010101000	call    Send_1;      // 43
		call    Send_0;      // 43		
metka10101000	call    Send_1;      // 43
		call    Send_0;      // 43
metka101000	call    Send_1;      // 43
		call    Send_0;      // 43
metka1000	call    Send_1;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_0;      // 43		
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

delay250ms	movlw       .186
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
		
;-----------------------------------------------------------------------------	
		end









