//?????? ???????? ???????????? ??????????
#include "main.h"
//--------------------------------------------------------------
unsigned char fl=0;
//--------------------------------------------------------------
#define _XTAL_FREQ 4000000
// PIC16F716 Configuration Bit Settings
// 'C' source line config statements
// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (RC oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF       // Brown-out Reset Enable bit (BOR enabled)
#pragma config BODENV = 40      // Brown-out Reset Voltage bit (VBOR set to 4.0V)
#pragma config CP = ON         // Code Protect (Program memory code protection is disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
unsigned int u;

void tezlik()
{       
        //if(u<999) return;
        //__delay_ms(0.8);
        //u=970;
        //if(u==999) while(1);
        //__delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        //if(u==999) while(1);
        __delay_ms(800);
        u=10;
        return;
    
//for(u=999;u>0;u--)
  //{
   //__delay_us(1000);
           
  //}
}
//--------------------------------------------------------------


void __interrupt() isr()
{
    if (INTF==1) {
        ledprint(u);        
        u=999;
        INTF=0; 
        //tezlik();
                
    }    
    if(T0IF)
    {
        TIM0_Callback();
        T0IF=0;        
    }
    
}
//--------------------------------------------


void main(void) {
    
    TRISA = 0x00;
    PORTA = 0xFF;
    TRISB = 0b00000001;
    PORTB = 0b00000000;
    OPTION_REG=0b01001011; //Prescaler 16
    //INTCON=0xA0;
    INTCON=0b11111000;
    //INTCON=0b10100000;
    TMR0=200;
    ECCPAS2 = 0;
    //INTEDG = 1; //rising edge
    //INTEDG=0; //falling edge
    //RBIF = 0;
    //RBIE = 1;
    //PEIE = 1;
    //GIE = 1;
            
    while(1)
    {
        
        for(u=999;u>0;u--)
        {
            //if(u<998)
            //{
                //u=999;
            //}
            __delay_us(127);
           
        }  
    }
    return;
    
    
}
