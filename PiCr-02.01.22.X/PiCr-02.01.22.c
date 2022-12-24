#define _XTAL_FREQ 4000000
#include <xc.h>

#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // GP3/MCLR pin function select (GP3/MCLR pin function is digital I/O, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = ON          // Code Protection bit (Program Memory code protection is enabled)
#pragma config CPD = ON         // Data Code Protection bit (Data memory code protection is enabled)

unsigned char Reg_1;
unsigned int i = 0;
unsigned int volt;
unsigned char codeAddress = 0b10110101;
unsigned char codeCommand = 0b01010000;
unsigned char codeCommandPlus = 0b01010000;
unsigned char loopBit;

/*void ms9And4ms() {
    for (i = 0; i < 555; i++) {
        GP2 = ~GP2;
    }
    GP2 = 0;
    __delay_us(5000);
}

void bit1() {
    for (i = 0; i < 31; i++) {
        GP2 = ~GP2;
    }
    GP2 = 0;
    __delay_us(1800);
}

void bit0() {
    for (i = 0; i < 30; i++) {
        GP2 = ~GP2;
    }
    GP2 = 0;
    __delay_us(540);
}*/

void ms9And4ms() {
    for (i = 0; i < 300; i++) {
        GP2 = 1;
        __delay_us(10);
        GP2 = 0;
    }
    GP2 = 0;
    __delay_us(4500);
}

void bit1() {
    for (i = 0; i < 19; i++) {
        GP2 = 1;
        __delay_us(10);
        GP2 = 0;
    }
    GP2 = 0;
    __delay_us(1650);
}

void bit0() {
    for (i = 0; i < 19; i++) {
        GP2 = 1;
        __delay_us(10);
        GP2 = 0;
    }
    GP2 = 0;
    __delay_us(450);
}

void commandd() {
    ms9And4ms();
    loopBit = 8;
    while (loopBit > 0) {
        loopBit--;
        if (!(codeAddress & (1 << loopBit))) {
            bit0();
        } else if (codeAddress & (1 << loopBit)) {
            bit1();
        }
    }
    codeAddress = ~codeAddress;
    loopBit = 8;
    while (loopBit > 0) {
        loopBit--;
        if (!(codeAddress & (1 << loopBit))) {
            bit0();
        } else if (codeAddress & (1 << loopBit)) {
            bit1();
        }
    }
    codeAddress = ~codeAddress;
    loopBit = 8;
    while (loopBit > 0) {
        loopBit--;
        if (!(codeCommand & (1 << loopBit))) {
            bit0();
        } else if (codeCommand & (1 << loopBit)) {
            bit1();
        }
    }
    codeCommand = ~codeCommand;
    loopBit = 8;
    while (loopBit > 0) {
        loopBit--;
        if (!(codeCommand & (1 << loopBit))) {
            bit0();
        } else if (codeCommand & (1 << loopBit)) {
            bit1();
        }
    }
    bit0();
    codeCommand = ~codeCommand;
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
                codeAddress = 0b10110101;
                codeCommand = 0b10000010;
                commandd();
            }
        }

        if (volt < 235 && volt > 210) { //qizil
            ADC();
            if (volt < 235 && volt > 210) {                
                codeAddress = 0b10110101;
                codeCommand = 0b10011000;
                commandd();
                __delay_ms(29);
                codeAddress = 0b11110101;
                codeCommand = 0b00001100;
                commandd();
            }
        }

        if (volt < 210 && volt > 200) { //yashil
            ADC();
            if (volt < 210 && volt > 200) {                
                codeAddress = 0b10110101;
                codeCommand = 0b00011010;
                commandd();
            }
        }

        if (volt < 200 && volt > 189) { //power
            ADC();
            if (volt < 200 && volt > 189) {
                codeAddress = 0b10110101;
                codeCommand = 0b01011000;
                commandd();
            }
        }

        if (volt < 189 && volt > 175) { //strelkachap
            ADC();
            if (volt < 189 && volt > 175) {
                codeAddress = 0b10110101;
                codeCommand = 0b01000010;
                commandd();
            }
        }

        if (volt < 175 && volt > 163) { //strelkaon
            ADC();
            if (volt < 175 && volt > 163) {
                codeAddress = 0b10110101;
                codeCommand = 0b11000010;
                commandd();
            }
        }

        if (volt < 163 && volt > 148) { //volumpas
            ADC();
            if (volt < 163 && volt > 148) {
                codeAddress = 0b10110101;
                codeCommand = 0b11010000;
                commandd();
            }
        }

        if (volt < 148 && volt > 70) { //volumtepa
            ADC();
            if (volt < 148 && volt > 70) {
                codeAddress = 0b10110101;
                codeCommand = 0b01010000;
                commandd();
            }
        }

        if (volt < 70 && volt > 1) { //strelkatepa
            ADC();
            if (volt < 70 && volt > 1) {
                codeAddress = 0b10110101;
                codeCommand = 0b00000010;
                commandd();
            }
        }
    }
}


