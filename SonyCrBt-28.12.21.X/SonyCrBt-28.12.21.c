#define _XTAL_FREQ 4000000
#include <xc.h>

#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // GP3/MCLR pin function select (GP3/MCLR pin function is digital I/O, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = ON          // Code Protection bit (Program Memory code protection is enabled)
#pragma config CPD = ON         // Data Code Protection bit (Data memory code protection is enabled)

unsigned int i = 0;
unsigned int volt;
unsigned char codeCommand = 0b01010000;
unsigned char codeAddress = 0b10110101;
unsigned char codeAddressPlus = 0b01010000;
unsigned char loopBit;

void ms2_4And0_6ms() {
    for (i = 0; i < 80; i++) {
        GP2 = 1;
        __delay_us(12);
        GP2 = 0;
    }
    GP2 = 0;
    __delay_us(600);
}

void bit1() {
    for (i = 0; i < 40; i++) {
        GP2 = 1;
        __delay_us(12);
        GP2 = 0;
    }
    GP2 = 0;
    __delay_us(600);
}

void bit0() {
    for (i = 0; i < 20; i++) {
        GP2 = 1;
        __delay_us(12);
        GP2 = 0;
    }
    GP2 = 0;
    __delay_us(600);
}

char commandd(unsigned char loopBit1, unsigned char loopBit2, unsigned char loopBit3) {
    ms2_4And0_6ms();
    loopBit = 8;
    while (loopBit > loopBit1) {
        loopBit--;
        if (!(codeCommand & (1 << loopBit))) {
            bit0();
        } else if (codeCommand & (1 << loopBit)) {
            bit1();
        }
    }

    loopBit = 8;
    while (loopBit > loopBit2) {
        loopBit--;
        if (!(codeAddress & (1 << loopBit))) {
            bit0();
        } else if (codeAddress & (1 << loopBit)) {
            bit1();
        }
    }

    loopBit = 8;
    while (loopBit > loopBit3) {
        loopBit--;
        if (!(codeAddressPlus & (1 << loopBit))) {
            bit0();
        } else if (codeAddressPlus & (1 << loopBit)) {
            bit1();
        }
    }
}

void ADC() {
    ADON = 1;
    __delay_ms(3);
    __delay_us(200);
    GO_DONE = 1;
    while (GO_DONE);
    volt = ADRESH;
    ADON = 0;
}

void ADC1() {
    ADON = 1;
    __delay_ms(30);
    GO_DONE = 1;
    while (GO_DONE);
    volt = ADRESH;
    ADON = 0;
}

void main(void) {
    TRISIO = 0b00010000;
    CMCON = 0b00000111;
    ADCON0 = 0b00001100;
    ANSEL = 0b01111000;
    OPTION_REG = 0b10000011; // Prescaler (1:256) is assigned to the timer TMR0
    INTCON = 0b1000000; // Enable interrupt TMR0 and Global Interrupts
    PIE1bits.ADIE = 1;

    while (1) {
        ADC1();
        if (volt < 252 && volt > 235) { //strelkapas
            ADC();
            if (volt < 252 && volt > 235) {
                codeCommand = 0b01001100;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }

        if (volt < 235 && volt > 210) { //qizil
            ADC();
            if (volt < 235 && volt > 210) {
                codeCommand = 0b00101000;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);                
            }
        }

        if (volt < 210 && volt > 200) { //yashil
            ADC();
            if (volt < 210 && volt > 200) {
                codeCommand = 0b10000010;
                codeAddress = 0b01000010;
                codeAddressPlus = 0b00000000;
                commandd(0, 0, 4);
            }
        }

        if (volt < 200 && volt > 189) { //power
            ADC();
            if (volt < 200 && volt > 189) {
                codeCommand = 0b01100010;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }

        if (volt < 189 && volt > 175) { //strelkachap
            ADC();
            if (volt < 189 && volt > 175) {
                codeCommand = 0b10101100;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }

        if (volt < 175 && volt > 163) { //strelkaon
            ADC();
            if (volt < 175 && volt > 163) {
                codeCommand = 0b00101100;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }

        if (volt < 163 && volt > 148) { //volumpas
            ADC();
            if (volt < 163 && volt > 148) {
                codeCommand = 0b11001000;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }

        if (volt < 148 && volt > 70) { //volumtepa
            ADC();
            if (volt < 148 && volt > 70) {
                codeCommand = 0b01001000;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }

        if (volt < 70 && volt > 1) { //strelkatepa
            ADC();
            if (volt < 70 && volt > 1) {
                codeCommand = 0b11001100;
                codeAddress = 0b01000010;
                commandd(0, 1, 8);
            }
        }
    }
}


