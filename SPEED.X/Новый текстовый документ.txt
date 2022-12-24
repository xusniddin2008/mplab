#include <xc.h>
#include <stdio.h>
#include <stdlib.h>

#define _XTAL_FREQ 8000000


// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config BODENV = 40      // Brown-out Reset Voltage bit (VBOR set to 4.0V)
#pragma config CP = ON          // Code Protect (Program memory code protection is enabled)

//--------------------------------------------------------------
unsigned char n_count=0, R1=0, R2=0, R3=0, R4=0;
//--------------------------------------------------------------



void segchar (unsigned int seg)
{
  switch (seg)
  {
    case 1:
      PORTB = 0b01100000;//1
      break;
    case 2:
      PORTB = 0b11011010;//2
      break;
    case 3:
      PORTB = 0b11110010;//3
      break;
    case 4:
      PORTB = 0b01100110;//4
      break;
    case 5:
      PORTB = 0b10110110;//5
      break;
    case 6:
      PORTB = 0b10111110;//6
      break;
    case 7:
      PORTB = 0b11100000;//7
      break;
    case 8:
      PORTB = 0b11111110;//8
      break;
    case 9:
      PORTB = 0b11110110;//9
      break;
    case 0:
      PORTB = 0b11111100;//0
      break;
  }
}
//--------------------------------------------------------------

//--------------------------------------------------------------
void ledprint(unsigned int number)
{
  R1 = number%10;
  R2 = number%100/10;
  R3 = number%1000/100;  
}
//--------------------------------------------
void TIM0_Callback(void)
{
  if(n_count==0)
  {
    PORTAbits.RA2 = 1;
    segchar(R1);
    PORTAbits.RA0 = 0;
  }
  else if(n_count==1)
  {
    PORTAbits.RA0 = 1;
    segchar(R2);
    PORTAbits.RA1 = 0;
  }
  else if(n_count==2)
  {
    PORTAbits.RA1 = 1;
    segchar(R3);
    PORTAbits.RA2 = 0;
  }
 
  n_count++;
  if (n_count>2) n_count=0;
}

//--------------------------------------------------------------
void interrupt tmr0_int (void)
{
    TIM0_Callback();
    T0IF=0;
}
//--------------------------------------------

void main(void) {
    unsigned int i;
    TRISA = 0x00;
    PORTA = 0x00;
    TRISB = 0x00;
    PORTB = 0x00;
    OPTION_REG=0b00000111; //Prescaler 16
    INTCON=0xA0;
    TMR0=0;
    
    while(1)
    {
        for(i=0;i<10000;i++)
        {
          ledprint(i);
          __delay_ms(200);
        }
        
        //PORTB = 0b01100000;//1
        //__delay_ms(100);
        //PORTB = 0b11011010;//2
        //__delay_ms(100);
        //PORTB = 0b11110010;//3
        //__delay_ms(100);
        //PORTB = 0b01100110;//4
        //__delay_ms(100);
        //PORTB = 0b10110110;//5
        //__delay_ms(100);
        //PORTB = 0b10111110;//6
        //__delay_ms(100);
        //PORTB = 0b11100000;//7
        //__delay_ms(100);
        //PORTB = 0b11111110;//8
        //__delay_ms(100);
        //PORTB = 0b11110110;//9
        //__delay_ms(100);
        //PORTB = 0b11111100;//0
        //__delay_ms(100);
    }
    return;
}
