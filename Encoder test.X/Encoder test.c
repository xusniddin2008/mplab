#include <htc.h>
#include <stdio.h>
#include <pic12f1822.h>;
/*#include <xc.h>
#include <pic12f1822.h>
#include <stdio.h>
#include <stdlib.h>*/


#define _XTAL_FREQ 32000000L


// CONFIG
// ????????? ???????????? #pragma ?????? ?????????????? ????????? ????? ???????.
// ??????????? ???????????? ??????? ?????? #define ??? ????????? ? ??????????.
// CONFIG1
#pragma config FOSC = INTOSC // ????? ??????????? (?????????? INTOSC: ??????? ????? / ?????? ?? ?????? CLKIN)
#pragma config WDTE = OFF // ?????????? ?????? ??????? (WDT ????????)
#pragma config PWRTE = OFF // ???????- up Timer Enable (PWRT disabled)
#pragma config MCLRE = OFF // ????? ??????? ?????? MCLR (??????? ?????? MCLR / VPP - MCLR)
#pragma config CP = ON // ?????? ???? ????-?????? ????????? (?????? ???? ??????????? ?????? ?????????)
#pragma config CPD = ON // ?????? ???? ?????? ?????? (?????? ???? ?????? ?????? ?????????)
#pragma config BOREN = ON // ?????????? ?????? ??? ?????????? ?????????? (????? ??? ?????????? ?????????? ????????) 
#pragma config CLKOUTEN = OFF // ????? ????? ???????? (??????? CLKOUT ?????????. ??????? ????? / ?????? ??? ?????????? ?? ?????? CLKOUT)
#pragma config IESO = OFF // ?????????? / ??????? ???????????? (??????? ????? ??????????? / ???????? ????????????)
#pragma config FCMEN = OFF // ???????????????? Clock Monitor Enable (Fail-Safe Clock Monitor ???????)
// CONFIG2
#pragma config WRT = OFF // ?????? ?? ?????????? ?? ????-?????? (?????? ?? ?????? ?????????) 
#pragma config PLLEN = OFF // PLL Enable (4x PLL enabled)
#pragma config STVREN = ON // ????????? ?????? ???????????? / ?????????????? ???????????? ????? (???????????? ??? ????????????? ?????????? ????? ??????? ?????) 
#pragma config BORV = LO // ????? ?????????? ?????? ??? ?????????? ?????????? (?????????? ?????? ??? ?????????? ?????????? (Vbor), ?????????? ?? ??????? ?????? ????? ???????.)
#pragma config LVP = OFF // ON // ????????? ???????????????? ??????? ?????????? (???????????????? ??????? ?????????? ?????????)


unsigned char x = 0;
unsigned char y = 0;

unsigned char u = 0;
unsigned char i = 0;
unsigned char time = 0;
unsigned char qqq = 0b11111111;
unsigned char www = 0b11111111;
unsigned char www1;
unsigned char qqq1;
unsigned char sek = 50;
unsigned char intr = 0;

unsigned test_bit(unsigned aValue, unsigned aNumber) {
    return aValue & (1 << aNumber);
}

void up() {
    TRISA = 0b00110010;
    RA0 = 1;
    __delay_ms(100);
    RA0 = 0;
    TRISA = 0b00110011;
    qqq = ~qqq;
    www = ~www;
    qqq1 = ~qqq;
    www1 = ~www;
}

void upInner() {
    TRISA = 0b00110010;
    RA0 = 1;
    if (sek > 5000) {
        sek = 50;
    }
    for (time = sek; time > 0; time--) {
        __delay_ms(10);

    }
    /*RA0 = 0;
    TRISA = 0b00110011;
    __delay_ms(10); */
    qqq = ~qqq;
    www = ~www;
    qqq1 = ~qqq;
    www1 = ~www;
}

void down() {
    TRISA = 0b00110001;
    RA1 = 1;
    __delay_ms(100);
    RA1 = 0;
    TRISA = 0b00110011;
    qqq = ~qqq;
    www = ~www;
    qqq1 = ~qqq;
    www1 = ~www;
}

void downInner() {
    TRISA = 0b00110001;
    RA1 = 1;
    if (sek > 5000) {
        sek = 50;
    }
    for (time = sek; time > 0; time--) {
        __delay_ms(10);

    }
    /*RA1 = 0;
    TRISA = 0b00110011;
    __delay_ms(10);*/
    qqq = ~qqq;
    www = ~www;
    qqq1 = ~qqq;
    www1 = ~www;
}

void __interrupt() isr() {
    if (IOCAF4 == 1) {
        down();
        intr++;
        TRISA = 0b00110001;
        RA1 = 1;
        __delay_ms(100);
        RA1 = 1;
        TRISA = 0b00110011;
        IOCAF4 = 0;
    }
}

void main() {
    OSCCON = 0xF0;
    ANSELA = 0;
    ADCON0 = 0;
    IOCAN = 0b11111111;
    INTCON = 0b11111110;
    PORTA = 0b00000000;
    TRISA = 0b00110011;
    while (1) {

    }
    /*while (1) {
        if (RA5 == (test_bit(qqq, 0))) {
            up();            
            for (u = 0; u < 100; u++) {
                if (RA4 == (test_bit(qqq, 0))) {
                    upInner();
                    u = 0;
                    sek = sek * 1.1;
                }
                if (RA4 == (test_bit(qqq, 0))) {
                    upInner();
                    u = 0;
                    sek = sek * 1;
                }
                __delay_ms(1);
            }
            RA0 = 0;
            TRISA = 0b00110011;
        }
        if (RA4 == (test_bit(www, 0))) {
            down();
            for (u = 0; u < 100; u++) {
                if (RA5 == (test_bit(www, 0))) {
                    downInner();
                    u = 0;
                    sek = sek * 1;
                }
                if (RA5 == (test_bit(www, 0))) {
                    downInner();
                    u = 0;
                    sek = sek * 1;
                }
                __delay_ms(1);
            }
            RA1 = 0;
            TRISA = 0b00110011;
        }
        sek = 50;
    }*/
}
/* 
 * File:   Encoder test.c
 * Author: User
 *
 * Created on 26 ????? 2021 ?., 5:15
 */

