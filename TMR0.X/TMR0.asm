;**************** THE WELS THEORY ******************
;Descripción: Encendemos un led cada 30ms. La temporización
;conseguimos con el Timer0
;
;Para más información visita: www.thewelstheory.com
;Y sigueme en www.facebook.com/WelsTheory

List P=16F84A ; Procesador PIC16f84A
#include "p16f84a.inc" ;Incluye las librerias 
    
; CONFIGURACION DEL PIC16F84A
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _CP_OFF

;Definimos salida del LED
#DEFINE	    LED	    PORTB,4
 
CBLOCK	0x0C
ENDC

;CODIGO
    ORG	0
INICIO
    BSF	    STATUS,RP0
    BCF	    LED
    MOVLW   B'00000111'
    MOVWF   OPTION_REG		;Prescaler de 64 asigando al TMR0
    BCF	    STATUS,RP0
START
    BCF	    LED			;Comienza apagado
    CALL    Timer0_10ms		;Esperamos 10ms
    CALL    Timer0_10ms		;Esperamos 10ms
    CALL    Timer0_10ms		;Esperamos 10ms
    BSF	    LED			;Encendemos el LED
    CALL    Timer0_10ms		;Esperamos 10ms
    CALL    Timer0_10ms		;Esperamos 10ms
    CALL    Timer0_10ms		;Esperamos 10ms
    GOTO    START
     
    
TMR0_Carga10ms	EQU	.10	
Timer0_10ms
    MOVLW   TMR0_Carga10ms	    ;Carga el Timer0 con el valor que queremos
    MOVWF   TMR0
    BCF	    INTCON,T0IF		    ;Reseteamos el Flag de desbordamiento del TMR0
Timer0_Desbordamiento
    BTFSS   INTCON,T0IF		    ;¿Se ha desbordado el TMR0?
    GOTO    Timer0_Desbordamiento   ;Aún no, Repite.
    RETURN
    

    END


