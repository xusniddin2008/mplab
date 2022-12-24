list p=12f675

	#include <P12f675.INC>

	ERRORLEVEL      -302    	


	__CONFIG  00014H	
	#define   IR_LED    GPIO,2 ; ???????????? ?????????


count		equ	0x26	
loops		equ	0x27	
loops2		equ	0x28	


f0		equ	0x29	
f1		equ	0x2A	 

powermax	equ	0x2B	
powermin	equ	0x2C	
modemax		equ	0x2D
modemin		equ	0x2E
seekmax		equ	0x37
seekmin		equ	0x38
volumtepamax	equ	0x39
volumtepamin	equ	0x30
volumpasmax	equ	0x3A
volumpasmin	equ	0x3B
fCOUNTER	equ	0x3C ; ??????? ?????? ??? ?????????? ???????????.
fCOUNTER2	equ	0x3D ; ???????2.
Sec1		equ	0x3E	
Reg_1		equ	0x31		
Reg_2		equ	0x32
Reg_3		equ	0x33
Reg_4		equ	0x34
Reg_5		equ	0x35
Reg_6		equ	0x36		
		


	org	0x00

	goto	Init

;***********************************************************************
; Initialisierung
;
Init
	; IO-Pins
	    bcf	    STATUS, RP0		; Bank 0
	    clrf    GPIO			; aus!
	    movlw   b'00000111'
	    movwf   CMCON			; Comparator aus
	    bsf	    STATUS, RP0		; Bank 1
	   
	    bsf	    TRISIO,1
	    bcf	    TRISIO,2
	    bsf	    TRISIO,3
	    bcf	    TRISIO,5		; GP5 output f?r Schalttransistor oder LED
	    bsf	    TRISIO,4
	    bsf	    OPTION_REG,7	  ; podtyaguyushiy rezistor o`chirildi
	    bcf	    WPU, WPU1		;podtyaguyeshshiy rezistor gpio1 ga o`rnatilmadi
	    bcf	    WPU, WPU2
	    bcf	    WPU, WPU0
	    bcf	    STATUS, RP0		; Bank0 ; internen Taktgenerator kalibrieren
	    bsf	    STATUS, RP0		; Bank 1
	    call    0x3FF
	    movwf   OSCCAL			; 4-MHz-Kalibrierung
	    bcf	    STATUS, RP0		; Bank 0

	; Interrupt
	    bcf	    INTCON, GIE		; Int deaktiviert
;******************************************************************************
; ADC initialisieren
	; ADC einschalten
	    BSF	    ADCON0, ADON	; ADON=1
	; ADC-Eingang AN0 ausw?hlen
	    BSF	    ADCON0, CHS1	; ADCHS1=0
	    BSF	    ADCON0, CHS0	; ADCHS0=0
	; ADC speed f?r 1,25 ... 5 MHz einstellen
	    BSF	    STATUS,RP0	; Bank1
	    clrf    ANSEL
	    BSF	    ANSEL, ADCS0	; ADCS0=1 Fosc/8
	; AN0,1 analog
	    ;BSF	    ANSEL, ANS0	; AN1=analog
	    BSF	    ANSEL, ANS3
	    BCF	    STATUS,RP0	; Bank0
	; Daten linksb?ndig
	    BCF	    ADCON0, VCFG	; RA2=digital
	    BCF	    ADCON0, ADFM	; ADFM=1 linksb?ndig

	;LED-Schaltspannungen festlegen
	    	
	    movlw   0xFD		;4.84V
	    movwf   powermax
	
	    movlw   0xF4		;4.69V
	    movwf   powermin

	    
	    movlw   0xF4		; 4.64V
	    movwf   modemax

	    movlw   0xEC		; 4.56V
	    movwf   modemin
	    
	    
	    movlw   0xEC		; 4.46V
	    movwf   seekmax
	    
	    movlw   0xCF		; 4.38V
	    movwf   seekmin
	    
	    
	    movlw   0xCF		; 3.77V
	    movwf   volumtepamax
	    
	    movlw   0x55		; 3.69V
	    movwf   volumtepamin
	    
	    
	    movlw   0x55		; 0.01V
	    movwf   volumpasmax
	    
	    movlw   0x02		; 0.06V
	    movwf   volumpasmin
;***********************************************************************
;Main 
Mainloop
	; Messen
	call	UMessen1	; AN0 nach f1,f0  (f1 is entscheidend)
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
; LED ein/aus-schalten
LED
	
	MOVFW	powermax
	subwf	f1, w		; w:=f1-w 
	btfss	STATUS, C
	call	power		; LED an
	
	
	MOVFW	modemax
	subwf	f1, w		; w:=f1-w 
	btfss	STATUS, C
	call	mode		; LED an
	
	
	MOVFW	seekmax
	subwf	f1, w		; w:=f1-w 
	btfss	STATUS, C
	call	seek		; LED an
	
	
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
; pr?fen ob f1<Uoff
power	MOVFW	powermin
	subwf	f1, w		; w:=f1-w 
	btfsc	STATUS, C
	call	cmpower
	movlw   d'30'
        call    Big_delay
	return
	
mode	MOVFW	modemin
	subwf	f1, w		; w:=f1-w 
	btfsc	STATUS, C
	call	cmmode
	movlw   d'30'
        call    Big_delay
	return
	
seek	MOVFW	seekmin
	subwf	f1, w		; w:=f1-w 
	btfsc	STATUS, C
	call	cmseek
	movlw   d'30'
        call    Big_delay
	return
	
volumtepa MOVFW	volumtepamin
	subwf	f1, w		; w:=f1-w 
	btfsc	STATUS, C
	call	cmvolumtepa
	movlw   d'30'
        call    Big_delay
	return	
	
volumpas MOVFW	volumpasmin
	subwf	f1, w		; w:=f1-w 
	btfsc	STATUS, C
	call	cmvolumpas
	movlw   d'30'
        call    Big_delay
	return	
	
;***********************************************************************

;-----------------------------------------------------------------------------


Main_Loop:
        ;call    Transmit_CMD1
        movlw   d'30'
        call    Big_delay
        ;call    Transmit_CMD1
        movlw   d'30'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        c;all    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   d'150'
        call    Big_delay
        ;call    Transmit_CMD2
        movlw   0
        call    Big_delay
        call    Big_delay
        call    Big_delay
        call    Big_delay
        call    Big_delay
        call    Big_delay
        goto    Main_Loop


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;                  ? ? ? ? ? ? ? ? ?   ? ? ? ? ? ? ?
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;-----------------------------------------------------------------------------
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
delay
        movwf   fCOUNTER
D_Loop36
        decfsz  fCOUNTER,1
        goto    D_Loop36
        return
;-----------------------------------------------------------------------------
cmpower		call	delayy9ms
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
		call    Send_0;      // 43
		call    Send_0;      // 43
		call    Send_1;      // 43
		call    Send_0;      // 43
		movlw	d'32'
		call	Big_delay
		return
;-----------------------------------------------------------------------------
cmmode
		call	delayy9ms
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
	
;-----------------------------------------------------------------------------
cmseek
		call	delayy9ms
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
;-----------------------------------------------------------------------------
	
	
cmvolumtepa	
		call	delayy9ms
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
	
;-----------------------------------------------------------------------------
	
cmvolumpas
		call	delayy9ms
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
	
	
;-----------------------------------------------------------------------------
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
;-----------------------------------------------------------------------------	
Send_1 ; ???????????? 527 ???.
        movlw   d'20'
        movwf   fCOUNTER
Send1_Loop
        bsf     IR_LED
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
        decfsz  fCOUNTER,1
        goto    Send1_Loop
        return
;-----------------------------------------------------------------------------
Send_0 ; ???????????? 527 ???.
        movlw   d'20'
        movwf   fCOUNTER
Send0_Loop
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
        decfsz  fCOUNTER,1
        goto    Send0_Loop
        return
;-----------------------------------------------------------------------------
delayy9ms 
	 
        movlw   d'200'
        movwf   fCOUNTER
Send0_Loopp
        bsf     IR_LED
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
        decfsz  fCOUNTER,1
        goto    Send0_Loopp
	
	movlw   d'132'
        movwf   fCOUNTER
Send0_Loopp1
        bsf     IR_LED
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
        decfsz  fCOUNTER,1
        goto    Send0_Loopp1
        return
	
	
delayy4.5ms	
	movlw       .215
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



