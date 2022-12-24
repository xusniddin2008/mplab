#define _XTAL_FREQ 4000000
#include <xc.h>

#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // GP3/MCLR pin function select (GP3/MCLR pin function is digital I/O, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = ON          // Code Protection bit (Program Memory code protection is enabled)
#pragma config CPD = ON         // Data Code Protection bit (Data memory code protection is enabled)

unsigned int i;
unsigned char UpDown;
unsigned int timesUp;
unsigned int timesDown;

void delay_ms(int x) {
    for (int i = 0; i <= x; i++) {
        __delay_ms(1);
    }
}

void ReadEEPROM() {
    EEADR = 0x02; // Write The Address From Which We Wonna Get Data
    EECON1bits.RD = 1; // Start The Read Operation
    while (RD) {
    }
    if (EEDATA >= 20) {
        timesUp = EEDATA;
    }
    __delay_ms(100);
    EEADR = 0x01; // Write The Address From Which We Wonna Get Data
    EECON1bits.RD = 1; // Start The Read Operation
    while (RD) {
    }
    if (EEDATA >= 20) {
        timesDown = EEDATA;
    }
    __delay_ms(100);
    EEADR = 0x10; // Write The Address From Which We Wonna Get Data
    EECON1bits.RD = 1; // Start The Read Operation
    while (RD) {
    }
    if (EEDATA == 50 || EEDATA == 60) {
        UpDown = EEDATA;
    }
}

void WriteEEPROM(int data, int adress) {
    EEADR = adress;
    EEDATA = data;
    WREN = 1;
    EECON2 = 0x55;
    EECON2 = 0xAA;
    WR = 1;
    while (WR) {
    }
    WREN = 0;
    //ReadEEPROM();
}

void up(int time) {
    GPIObits.GP1 = 1;
    delay_ms(time * 40);
    GPIObits.GP1 = 0;
}

void down(int time) {
    GPIObits.GP0 = 1;
    delay_ms(time * 40);
    GPIObits.GP0 = 0;
}

void main(void) {
    RP0 = 0;
    GPIO = 0b00000000;
    CMCON = 0b00000111;
    RP0 = 1;
    TRISIO = 0b00001100;
    OPTION_REG = 0b10000000;
    //INTCON = 0b00000000;
    ANSEL = 0b00000000;
    RP0 = 0;
    ReadEEPROM();
    while (1) {
        /*if (UpDown == 60) {
            GPIObits.GP4 = 1;
            GPIObits.GP5 = 0;
        } else if (UpDown == 50) {
            GPIObits.GP5 = 1;
            GPIObits.GP4 = 0;
        }*/
        i = 0;
        while (GPIO2 == 1) {
            __delay_ms(50);
            while (GPIO2 == 1) {
                __delay_ms(100);
                if (GPIO2 == 0 && i < 2 && UpDown == 60) {
                    timesUp = timesUp + 1;
                    WriteEEPROM(timesUp, 0x02);
                    up(1);
                } else if (GPIO2 == 0 && i < 2 && UpDown == 50) {
                    timesDown = timesDown + 1;
                    WriteEEPROM(timesDown, 0x01);
                    down(1);
                }
                i++;
                if (i >= 100) {
                    while (GPIO2 == 1) {
                    }
                    /*for (int z = 0; z < 3; z++) {
                        GPIObits.GP4 = 1;
                        GPIObits.GP5 = 1;
                        __delay_ms(1000);
                        GPIObits.GP4 = 0;
                        GPIObits.GP5 = 0;
                        __delay_ms(1000);
                    }*/
                    timesUp = 22;
                    timesDown = 22;
                    UpDown = 50;
                    WriteEEPROM(timesUp, 0x02);
                    WriteEEPROM(timesDown, 0x01);
                    WriteEEPROM(UpDown, 0x10);
                    up(timesUp);
                    down(timesDown);
                }
            }            
        }
        if (GPIO3 == 1 && UpDown == 50) {
            __delay_ms(1000);
            if (GPIO3 == 1 && UpDown == 50) {
                up(timesUp);
                UpDown = 60;
                WriteEEPROM(UpDown, 0x10);
            }
        } else if (GPIO3 == 0 && UpDown == 60) {
            __delay_ms(100);
            if (GPIO3 == 0 && UpDown == 60) {
                down(timesDown);
                UpDown = 50;
                WriteEEPROM(UpDown, 0x10);
            }
        }
    }
    return;
}

