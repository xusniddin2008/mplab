//?????? ???????? ???????????? ??????????
#include "led.h"
//--------------------------------------------------------------
unsigned char n_count=0, R1=0, R2=0, R3=0, R4=0;
unsigned int q1=0, q2=0;
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
void ledprint(unsigned int number)
{
    q1 = number;
    q2 = number%10;
    R1 = number%10;
    R2 = number%100/10;
    R3 = number%1000/100;
}
//--------------------------------------------

//--------------------------------------------
void TIM0_Callback(void)
{
  if(n_count==2)
  {
      if(q1>=100)
      {
        PORTAbits.RA1 = 0;
        PORTAbits.RA0 = 0;
        PORTAbits.RA2 = 1;    
        segchar(R3);    
      }
  }    
  if(n_count==1)
  {   
      if(q1>=10)
      {
        PORTAbits.RA0 = 0;
        PORTAbits.RA2 = 0;
        PORTAbits.RA1 = 1;    
        segchar(R2);    
      }
  }   
  if(n_count==0)
  {
    PORTAbits.RA2 = 0;
    PORTAbits.RA1 = 0;
    PORTAbits.RA0 = 1;    
    segchar(R1);    
  }
  
  
 
  n_count++;
  if (n_count>2) n_count=0;
}
//--------------------------------------------
//--------------------------------------------------------------
