#define _XTAL_FREQ 4000000
#include <xc.h>
#define   blijniy    GP0
#define   gabarit    GP1
#define   gabaritButton    GP2
#define   zajiganiyaButton    GP3
#define   photoResistor    GP4
#define   sentrZamokButton    GP5

#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // GP3/MCLR pin function select (GP3/MCLR pin function is digital I/O, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = ON          // Code Protection bit (Program Memory code protection is enabled)
#pragma config CPD = ON         // Data Code Protection bit (Data memory code protection is enabled)

unsigned int gabOn = 150;
unsigned int gabOff = 48;
unsigned int blijOn = 200;
unsigned int blijOff = 50;
unsigned int i;
unsigned int volt;

void ADC() {
    __delay_ms(2);
    ADON = 1;
    __delay_ms(15);
    GO_DONE = 1;
    while (GO_DONE);
    volt = ADRESH;
    ADON = 0;
}

void gabaritOn() {
    for (i = 0; i <= 235; i++) {
        ADC();
        if (zajiganiyaButton == 0 || volt < 140) {
            return;
        }
        __delay_ms(1);
    }
    if (volt > blijOn) {
        blijniy = 1;
    }
    if (volt > gabOn) {
        gabarit = 1;
    }
}

void gabaritOff() {
    for (i = 0; i <= 435; i++) {
        ADC();
        if (zajiganiyaButton == 0 || volt > 48) {
            return;
        }
        __delay_ms(1);
    }
    if (volt < gabOff) {
        gabarit = 0;
    }
}

void blijniyOn() {
    for (i = 0; i <= 235; i++) {
        ADC();
        if (zajiganiyaButton == 0 || volt < 190) {
            return;
        }
        __delay_ms(1);
    }
    if (volt > blijOn) {
        blijniy = 1;
    }
}

void blijniyOff() {
    for (i = 0; i <= 435; i++) {
        ADC();
        if (zajiganiyaButton == 0 || volt > 60) {
            return;
        }
    }
    if (volt < blijOff) {
        blijniy = 0;
    }
}

void sentrZamok() {
    gabarit = 1;
    blijniy = 1;
    for (i = 0; i <= 10000; i++) {
        if (zajiganiyaButton == 1) {
            i = 10000;
        } else {
            __delay_ms(1);
        }
    }
    gabarit = 0;
    blijniy = 0;
}

void __interrupt() isr() {
    if (INTF) {
        INTF = 0;
        blijniy = 0;
        while (zajiganiyaButton == 1) {
            if (GP2 == 0) {
                gabarit = 1;
            } else {
                gabarit = 0;
            }
        }
        if (GP2 == 0) {
            gabarit = 1;
        }
    }
}

void main(void) {
    TRISIO = 0b00111100;
    GPIO = 0b00000000;
    CMCON = 0x07;
    INTCON = 0b10010000;
    OPTION_REGbits.INTEDG = 0;
    ADCON0 = 0b00001100;
    ANSEL = 0b00011000;
    while (1) {
        while (zajiganiyaButton == 1) {
            ADC();
            if (volt > gabOn && gabarit == 0) {
                gabaritOn();
            }
            if (volt > blijOn && blijniy == 0) {
                blijniyOn();
            }
            if (volt < blijOff && blijniy == 1) {
                blijniyOff();
            }
            if (volt < gabOff && gabarit == 1) {
                gabaritOff();
            }
        }
        if (sentrZamokButton == 0) {
            ADC();
            if (volt > gabOn) {
                sentrZamok();
            }
        }
        if (GP2 == 1) {
            gabarit = 0;
            blijniy = 0;
        }
        if (GP2 == 0) {
            gabarit = 1;
        }
    }
}
