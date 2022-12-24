//?????? ???????? ???????????? ??????????
#ifndef MAIN_H
#define MAIN_H
//--------------------------------------------------------------
#include <xc.h>
#include "led.h"
//--------------------------------------------------------------
#define _XTAL_FREQ 4000000
// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config BODENV = 40      // Brown-out Reset Voltage bit (VBOR set to 4.0V)
#pragma config CP = ON          // Code Protect (Program memory code protection is enabled)
//--------------------------------------------------------------
#endif /* MAIN_H */
