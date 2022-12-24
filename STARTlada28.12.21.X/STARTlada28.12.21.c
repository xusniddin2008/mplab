#include <stdio.h>
#include <stdlib.h>
#include <pic16f628a.h>

#define _XTAL_FREQ 4000000
#include <xc.h>


#pragma config FOSC = INTOSCIO  // Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config LVP = OFF         // Low-Voltage Programming Enable bit (RB4/PGM pin has PGM function, low-voltage programming enabled)
#pragma config CPD = ON         // Data EE Memory Code Protection bit (Data memory code-protected)
#pragma config CP = ON          // Flash Program Memory Code Protection bit (0000h to 07FFh code-protected)



unsigned char i = 0;
unsigned char u = 0;
unsigned char status = 0;
unsigned char starts = 0;

void zvuk() {
    PORTAbits.RA6 = 1;
    __delay_ms(60);
    PORTAbits.RA6 = 0;
}

void ohranastart() {
    PORTAbits.RA0 = 1;
    PORTBbits.RB4 = 1;
    PORTBbits.RB6 = 1;
    PORTBbits.RB7 = 1;
    PORTAbits.RA1 = 1;
}

void flicker() {
    while (PORTBbits.RB2 == 1 && PORTBbits.RB0 == 0) {
        PORTAbits.RA7 = 1;
        __delay_ms(260);
        PORTAbits.RA7 = 0;
        __delay_ms(160);
        if (PORTBbits.RB1 == 1) {
            ohranastart();
        }
    }
}

void ohrana() {
    PORTA = 0b00000000;
    PORTB = 0b00000000;
    starts = 0;
    status = 0;
}

void start() {
    PORTBbits.RB4 = 0;
    PORTBbits.RB6 = 0;
    PORTAbits.RA0 = 0;
    PORTBbits.RB7 = 1;
    __delay_ms(1000);
    PORTBbits.RB5 = 1;
    __delay_ms(1260);
    for (i = 0; i <= 10; i++) {
        __delay_ms(250);
        if (PORTBbits.RB2 == 1) {
            i = 11;
            starts = 1;
        }
    }
    PORTBbits.RB5 = 0;
    __delay_ms(100);
    PORTBbits.RB6 = 1;
    __delay_ms(100);
    PORTBbits.RB4 = 1;
    PORTAbits.RA0 = 1;
    u = 0;
    __delay_ms(500);
    if (PORTBbits.RB2 == 0) { 
        PORTBbits.RB6 = 0;
        PORTBbits.RB4 = 0;
        PORTAbits.RA0 = 0;
        PORTBbits.RB7 = 0;
    }
}

void stop() {
    PORTA = 0b10000000;
    PORTB = 0b00000000;
    starts = 0;
    status = 0;
    u = 0;
    __delay_ms(500);
}

void zajiganiya() {
    PORTBbits.RB6 = 1;
    PORTBbits.RB7 = 1;
    status = 2;
    __delay_ms(100);
}

void magnitafon() {
    PORTBbits.RB4 = 1;
    PORTAbits.RA0 = 1;
    __delay_ms(100);
    if (PORTBbits.RB1 == 1) {
        if (PORTBbits.RB2 == 1) {
            zvuk();
            __delay_ms(60);
            zvuk();
        } else {
            zvuk();
            start();
        }
    } else {
        status = 1;
    }
    //__delay_ms(100);
}

void main(void) {
    TRISA = 0b00001100;
    TRISB = 0b00000111;
    PORTA = 0b00000000;
    PORTB = 0b00000000;
    //PCON = 0b00001001;
    OPTION_REG = 0b10000000;
    CMCON = 0b00000111;
    PORTAbits.RA7 = 1;
    while (1) {

        while (PORTBbits.RB0 == 0) {
            __delay_ms(100);

            if (PORTBbits.RB0 == 0) {
                ohrana();
            }
            if (PORTBbits.RB0 == 0 && PORTBbits.RB2 == 1) {
                flicker();
            }
        }

        PORTAbits.RA7 = 1;
        if (PORTBbits.RB2 == 1) {
            PORTAbits.RA1 = 1;
            if (PORTBbits.RB1 == 1) {
                ohranastart();
            }
        } else {
            PORTAbits.RA1 = 0;
        }

        while (PORTBbits.RB1 == 1) {
            if (PORTBbits.RB1 == 1 && PORTAbits.RA2 == 1 && PORTBbits.RB2 == 0) {
                __delay_ms(100);
                if (PORTBbits.RB1 == 1 && PORTAbits.RA2 == 1) {
                    if (PORTAbits.RA3 == 1) {
                        zvuk();
                        __delay_ms(60);
                        zvuk();
                    } else {
                        zvuk();
                        start();
                    }
                }
            }

            if (PORTBbits.RB1 == 1 && PORTAbits.RA2 == 1 && PORTBbits.RB2 == 1) {
                __delay_ms(100);
                if (PORTBbits.RB1 == 1 && PORTAbits.RA2 == 1) {
                    stop();
                }
            }
            if (PORTBbits.RB2 == 1) {
                PORTAbits.RA1 = 1;
            } else {

            }
        }

        while (PORTAbits.RA2 == 1) {
            __delay_ms(100);
            if (status == 0 && PORTBbits.RB1 == 0 && PORTBbits.RB2 == 0) {
                __delay_ms(200);
                if (PORTAbits.RA2 == 1) {
                    __delay_ms(400);
                }
                if (PORTAbits.RA2 == 0) {
                    magnitafon();
                }
            } else if (status == 1 && PORTBbits.RB1 == 0 && PORTBbits.RB2 == 0) {
                __delay_ms(200);
                if (PORTAbits.RA2 == 1) {
                    __delay_ms(400);
                }
                if (PORTAbits.RA2 == 0) {
                    zajiganiya();
                }
            } else if (status == 2 && PORTBbits.RB1 == 0 && PORTBbits.RB2 == 0) {
                __delay_ms(200);
                if (PORTAbits.RA2 == 1) {
                    __delay_ms(400);
                }
                if (PORTAbits.RA2 == 0) {
                    PORTA = 0b10000000;
                    PORTB = 0b00000000;
                    status = 0;
                    __delay_ms(100);
                }
            }

            if (PORTAbits.RA2 == 1) {
                while (PORTAbits.RA2 == 1) {
                    __delay_ms(250);
                    u++;
                    if (u >= 20 && PORTBbits.RB2 == 0 && PORTAbits.RA2 == 0) {
                        u = 0;
                        if (PORTAbits.RA3 == 1) {
                            zvuk();
                            __delay_ms(60);
                            zvuk();
                        } else {
                            zvuk();
                            start();
                        }
                    }
                    if (u >= 20 && PORTBbits.RB2 == 1 && PORTAbits.RA2 == 0) {
                        u = 0;
                        stop();
                    }
                }

            }
        }
    }
    return;
}

