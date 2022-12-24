#include <xc.h>


#define _XTAL_FREQ 4000000

// CONFIG
#pragma config FOSC = INTRCIO   // Oscillator Selection bits (INTOSC oscillator: I/O function on GP4/OSC2/CLKOUT pin, I/O function on GP5/OSC1/CLKIN)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-Up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // GP3/MCLR pin function select (GP3/MCLR pin function is digital I/O, MCLR internally tied to VDD)
#pragma config BOREN = OFF      // Brown-out Detect Enable bit (BOD disabled)
#pragma config CP = ON          // Code Protection bit (Program Memory code protection is enabled)
#pragma config CPD = ON         // Data Code Protection bit (Data memory code protection is enabled)

unsigned char x=0;
unsigned char y=1;


void main(void) {
    TRISIO = 0b00001000;
    GPIO = 0b00000000;
    //OPTION_REG = (~1<<7); 
    while(1)
    {
        if(GPIO3 == 1){
            __delay_ms(2260);// 2000ms
            if(x==0){
                if(GPIO3 == 1){
                    GPIO = (1<<1);
                    __delay_ms(2220);//1840ms
                    GPIO = (0<<1);                    
                    x=1;
                    y=0;
            }
            
            }
            
            
        }
        else{
            __delay_ms(10);//600ms
            if(y==0){
                if(GPIO3 == 0){
                    GPIO = (1<<0);
                    __delay_ms(2220);//1840ms
                    GPIO = (0<<0);                    
                    y=1;
                    x=0;
            }
            
            }
            
        }
        
        
            
        
    }    
    return;
}
