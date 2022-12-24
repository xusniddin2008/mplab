
# 1 "main.c"

# 18 "C:\Program Files (x86)\Microchip\xc8\v2.00\pic\include\xc.h"
extern const char __xc8_OPTIM_SPEED;

extern double __fpnormalize(double);


# 13 "C:\Program Files (x86)\Microchip\xc8\v2.00\pic\include\c90\xc8debug.h"
#pragma intrinsic(__builtin_software_breakpoint)
extern void __builtin_software_breakpoint(void);

# 52 "C:\Program Files (x86)\Microchip\xc8\v2.00\pic\include\pic16f716.h"
extern volatile unsigned char INDF __at(0x000);

asm("INDF equ 00h");




extern volatile unsigned char TMR0 __at(0x001);

asm("TMR0 equ 01h");




extern volatile unsigned char PCL __at(0x002);

asm("PCL equ 02h");




extern volatile unsigned char STATUS __at(0x003);

asm("STATUS equ 03h");


typedef union {
struct {
unsigned C :1;
unsigned DC :1;
unsigned Z :1;
unsigned nPD :1;
unsigned nTO :1;
unsigned RP :2;
unsigned IRP :1;
};
struct {
unsigned :5;
unsigned RP0 :1;
unsigned RP1 :1;
};
struct {
unsigned CARRY :1;
unsigned :1;
unsigned ZERO :1;
};
} STATUSbits_t;
extern volatile STATUSbits_t STATUSbits __at(0x003);

# 159
extern volatile unsigned char FSR __at(0x004);

asm("FSR equ 04h");




extern volatile unsigned char PORTA __at(0x005);

asm("PORTA equ 05h");


typedef union {
struct {
unsigned RA0 :1;
unsigned RA1 :1;
unsigned RA2 :1;
unsigned RA3 :1;
unsigned RA4 :1;
};
} PORTAbits_t;
extern volatile PORTAbits_t PORTAbits __at(0x005);

# 210
extern volatile unsigned char PORTB __at(0x006);

asm("PORTB equ 06h");


extern volatile unsigned char DATACCP __at(0x006);

asm("DATACCP equ 06h");


typedef union {
struct {
unsigned RB0 :1;
unsigned RB1 :1;
unsigned RB2 :1;
unsigned RB3 :1;
unsigned RB4 :1;
unsigned RB5 :1;
unsigned RB6 :1;
unsigned RB7 :1;
};
struct {
unsigned :1;
unsigned DT1CK :1;
unsigned :1;
unsigned DCCP :1;
};
} PORTBbits_t;
extern volatile PORTBbits_t PORTBbits __at(0x006);

# 291
typedef union {
struct {
unsigned RB0 :1;
unsigned RB1 :1;
unsigned RB2 :1;
unsigned RB3 :1;
unsigned RB4 :1;
unsigned RB5 :1;
unsigned RB6 :1;
unsigned RB7 :1;
};
struct {
unsigned :1;
unsigned DT1CK :1;
unsigned :1;
unsigned DCCP :1;
};
} DATACCPbits_t;
extern volatile DATACCPbits_t DATACCPbits __at(0x006);

# 364
extern volatile unsigned char PCLATH __at(0x00A);

asm("PCLATH equ 0Ah");


typedef union {
struct {
unsigned PCLATH :5;
};
} PCLATHbits_t;
extern volatile PCLATHbits_t PCLATHbits __at(0x00A);

# 384
extern volatile unsigned char INTCON __at(0x00B);

asm("INTCON equ 0Bh");


typedef union {
struct {
unsigned RBIF :1;
unsigned INTF :1;
unsigned TMR0IF :1;
unsigned RBIE :1;
unsigned INTE :1;
unsigned TMR0IE :1;
unsigned PEIE :1;
unsigned GIE :1;
};
struct {
unsigned :2;
unsigned T0IF :1;
unsigned :2;
unsigned T0IE :1;
};
} INTCONbits_t;
extern volatile INTCONbits_t INTCONbits __at(0x00B);

# 462
extern volatile unsigned char PIR1 __at(0x00C);

asm("PIR1 equ 0Ch");


typedef union {
struct {
unsigned TMR1IF :1;
unsigned TMR2IF :1;
unsigned CCP1IF :1;
unsigned :3;
unsigned ADIF :1;
};
} PIR1bits_t;
extern volatile PIR1bits_t PIR1bits __at(0x00C);

# 501
extern volatile unsigned short TMR1 __at(0x00E);

asm("TMR1 equ 0Eh");




extern volatile unsigned char TMR1L __at(0x00E);

asm("TMR1L equ 0Eh");




extern volatile unsigned char TMR1H __at(0x00F);

asm("TMR1H equ 0Fh");




extern volatile unsigned char T1CON __at(0x010);

asm("T1CON equ 010h");


typedef union {
struct {
unsigned TMR1ON :1;
unsigned TMR1CS :1;
unsigned nT1SYNC :1;
unsigned T1OSCEN :1;
unsigned T1CKPS :2;
};
struct {
unsigned :2;
unsigned T1SYNC :1;
unsigned :1;
unsigned T1CKPS0 :1;
unsigned T1CKPS1 :1;
};
} T1CONbits_t;
extern volatile T1CONbits_t T1CONbits __at(0x010);

# 588
extern volatile unsigned char TMR2 __at(0x011);

asm("TMR2 equ 011h");




extern volatile unsigned char T2CON __at(0x012);

asm("T2CON equ 012h");


typedef union {
struct {
unsigned T2CKPS :2;
unsigned TMR2ON :1;
unsigned TOUTPS :4;
};
struct {
unsigned T2CKPS0 :1;
unsigned T2CKPS1 :1;
unsigned :1;
unsigned TOUTPS0 :1;
unsigned TOUTPS1 :1;
unsigned TOUTPS2 :1;
unsigned TOUTPS3 :1;
};
} T2CONbits_t;
extern volatile T2CONbits_t T2CONbits __at(0x012);

# 666
extern volatile unsigned short CCPR1 __at(0x015);

asm("CCPR1 equ 015h");




extern volatile unsigned char CCPR1L __at(0x015);

asm("CCPR1L equ 015h");




extern volatile unsigned char CCPR1H __at(0x016);

asm("CCPR1H equ 016h");




extern volatile unsigned char CCP1CON __at(0x017);

asm("CCP1CON equ 017h");


typedef union {
struct {
unsigned CCP1M :4;
unsigned DC1B :2;
unsigned P1M :2;
};
struct {
unsigned CCP1M0 :1;
unsigned CCP1M1 :1;
unsigned CCP1M2 :1;
unsigned CCP1M3 :1;
unsigned DC1B0 :1;
unsigned DC1B1 :1;
unsigned P1M0 :1;
unsigned P1M1 :1;
};
} CCP1CONbits_t;
extern volatile CCP1CONbits_t CCP1CONbits __at(0x017);

# 769
extern volatile unsigned char PWM1CON __at(0x018);

asm("PWM1CON equ 018h");


typedef union {
struct {
unsigned PDC :7;
unsigned PRSEN :1;
};
struct {
unsigned PDC0 :1;
unsigned PDC1 :1;
unsigned PDC2 :1;
unsigned PDC3 :1;
unsigned PDC4 :1;
unsigned PDC5 :1;
unsigned PDC6 :1;
};
} PWM1CONbits_t;
extern volatile PWM1CONbits_t PWM1CONbits __at(0x018);

# 839
extern volatile unsigned char ECCPAS __at(0x019);

asm("ECCPAS equ 019h");


typedef union {
struct {
unsigned PSSBD :2;
unsigned PSSAC :2;
unsigned ECCPAS0 :1;
unsigned :1;
unsigned ECCPAS2 :1;
unsigned ECCPASE :1;
};
struct {
unsigned PSSBD0 :1;
unsigned PSSBD1 :1;
unsigned PSSAC0 :1;
unsigned PSSAC1 :1;
unsigned :1;
unsigned ECCPAS1 :1;
};
} ECCPASbits_t;
extern volatile ECCPASbits_t ECCPASbits __at(0x019);

# 917
extern volatile unsigned char ADRES __at(0x01E);

asm("ADRES equ 01Eh");


typedef union {
struct {
unsigned ADRES :8;
};
} ADRESbits_t;
extern volatile ADRESbits_t ADRESbits __at(0x01E);

# 937
extern volatile unsigned char ADCON0 __at(0x01F);

asm("ADCON0 equ 01Fh");


typedef union {
struct {
unsigned ADON :1;
unsigned :1;
unsigned GO_nDONE :1;
unsigned CHS :3;
unsigned ADCS :2;
};
struct {
unsigned :2;
unsigned GO :1;
unsigned CHS0 :1;
unsigned CHS1 :1;
unsigned CHS2 :1;
unsigned ADCS0 :1;
unsigned ADCS1 :1;
};
struct {
unsigned :2;
unsigned nDONE :1;
};
struct {
unsigned :2;
unsigned GO_DONE :1;
};
} ADCON0bits_t;
extern volatile ADCON0bits_t ADCON0bits __at(0x01F);

# 1033
extern volatile unsigned char OPTION_REG __at(0x081);

asm("OPTION_REG equ 081h");


typedef union {
struct {
unsigned PS :3;
unsigned PSA :1;
unsigned T0SE :1;
unsigned T0CS :1;
unsigned INTEDG :1;
unsigned nRBPU :1;
};
struct {
unsigned PS0 :1;
unsigned PS1 :1;
unsigned PS2 :1;
};
} OPTION_REGbits_t;
extern volatile OPTION_REGbits_t OPTION_REGbits __at(0x081);

# 1103
extern volatile unsigned char TRISA __at(0x085);

asm("TRISA equ 085h");


typedef union {
struct {
unsigned TRISA0 :1;
unsigned TRISA1 :1;
unsigned TRISA2 :1;
unsigned TRISA3 :1;
unsigned TRISA4 :1;
};
} TRISAbits_t;
extern volatile TRISAbits_t TRISAbits __at(0x085);

# 1147
extern volatile unsigned char TRISB __at(0x086);

asm("TRISB equ 086h");


extern volatile unsigned char TRISCP __at(0x086);

asm("TRISCP equ 086h");


typedef union {
struct {
unsigned TRISB0 :1;
unsigned TRISB1 :1;
unsigned TRISB2 :1;
unsigned TRISB3 :1;
unsigned TRISB4 :1;
unsigned TRISB5 :1;
unsigned TRISB6 :1;
unsigned TRISB7 :1;
};
struct {
unsigned :1;
unsigned TT1CK :1;
unsigned :1;
unsigned TCCP :1;
};
} TRISBbits_t;
extern volatile TRISBbits_t TRISBbits __at(0x086);

# 1228
typedef union {
struct {
unsigned TRISB0 :1;
unsigned TRISB1 :1;
unsigned TRISB2 :1;
unsigned TRISB3 :1;
unsigned TRISB4 :1;
unsigned TRISB5 :1;
unsigned TRISB6 :1;
unsigned TRISB7 :1;
};
struct {
unsigned :1;
unsigned TT1CK :1;
unsigned :1;
unsigned TCCP :1;
};
} TRISCPbits_t;
extern volatile TRISCPbits_t TRISCPbits __at(0x086);

# 1301
extern volatile unsigned char PIE1 __at(0x08C);

asm("PIE1 equ 08Ch");


typedef union {
struct {
unsigned TMR1IE :1;
unsigned TMR2IE :1;
unsigned CCP1IE :1;
unsigned :3;
unsigned ADIE :1;
};
} PIE1bits_t;
extern volatile PIE1bits_t PIE1bits __at(0x08C);

# 1340
extern volatile unsigned char PCON __at(0x08E);

asm("PCON equ 08Eh");


typedef union {
struct {
unsigned nBOR :1;
unsigned nPOR :1;
};
struct {
unsigned nBO :1;
};
struct {
unsigned nBOD :1;
};
} PCONbits_t;
extern volatile PCONbits_t PCONbits __at(0x08E);

# 1382
extern volatile unsigned char PR2 __at(0x092);

asm("PR2 equ 092h");




extern volatile unsigned char ADCON1 __at(0x09F);

asm("ADCON1 equ 09Fh");


typedef union {
struct {
unsigned PCFG :3;
};
struct {
unsigned PCFG0 :1;
unsigned PCFG1 :1;
unsigned PCFG2 :1;
};
} ADCON1bits_t;
extern volatile ADCON1bits_t ADCON1bits __at(0x09F);

# 1435
extern volatile __bit ADCS0 __at(0xFE);


extern volatile __bit ADCS1 __at(0xFF);


extern volatile __bit ADIE __at(0x466);


extern volatile __bit ADIF __at(0x66);


extern volatile __bit ADON __at(0xF8);


extern volatile __bit CARRY __at(0x18);


extern volatile __bit CCP1IE __at(0x462);


extern volatile __bit CCP1IF __at(0x62);


extern volatile __bit CCP1M0 __at(0xB8);


extern volatile __bit CCP1M1 __at(0xB9);


extern volatile __bit CCP1M2 __at(0xBA);


extern volatile __bit CCP1M3 __at(0xBB);


extern volatile __bit CHS0 __at(0xFB);


extern volatile __bit CHS1 __at(0xFC);


extern volatile __bit CHS2 __at(0xFD);


extern volatile __bit DC __at(0x19);


extern volatile __bit DC1B0 __at(0xBC);


extern volatile __bit DC1B1 __at(0xBD);


extern volatile __bit DCCP __at(0x33);


extern volatile __bit DT1CK __at(0x31);


extern volatile __bit ECCPAS0 __at(0xCC);


extern volatile __bit ECCPAS1 __at(0xCD);


extern volatile __bit ECCPAS2 __at(0xCE);


extern volatile __bit ECCPASE __at(0xCF);


extern volatile __bit GIE __at(0x5F);


extern volatile __bit GO __at(0xFA);


extern volatile __bit GO_DONE __at(0xFA);


extern volatile __bit GO_nDONE __at(0xFA);


extern volatile __bit INTE __at(0x5C);


extern volatile __bit INTEDG __at(0x40E);


extern volatile __bit INTF __at(0x59);


extern volatile __bit IRP __at(0x1F);


extern volatile __bit P1M0 __at(0xBE);


extern volatile __bit P1M1 __at(0xBF);


extern volatile __bit PCFG0 __at(0x4F8);


extern volatile __bit PCFG1 __at(0x4F9);


extern volatile __bit PCFG2 __at(0x4FA);


extern volatile __bit PDC0 __at(0xC0);


extern volatile __bit PDC1 __at(0xC1);


extern volatile __bit PDC2 __at(0xC2);


extern volatile __bit PDC3 __at(0xC3);


extern volatile __bit PDC4 __at(0xC4);


extern volatile __bit PDC5 __at(0xC5);


extern volatile __bit PDC6 __at(0xC6);


extern volatile __bit PEIE __at(0x5E);


extern volatile __bit PRSEN __at(0xC7);


extern volatile __bit PS0 __at(0x408);


extern volatile __bit PS1 __at(0x409);


extern volatile __bit PS2 __at(0x40A);


extern volatile __bit PSA __at(0x40B);


extern volatile __bit PSSAC0 __at(0xCA);


extern volatile __bit PSSAC1 __at(0xCB);


extern volatile __bit PSSBD0 __at(0xC8);


extern volatile __bit PSSBD1 __at(0xC9);


extern volatile __bit RA0 __at(0x28);


extern volatile __bit RA1 __at(0x29);


extern volatile __bit RA2 __at(0x2A);


extern volatile __bit RA3 __at(0x2B);


extern volatile __bit RA4 __at(0x2C);


extern volatile __bit RB0 __at(0x30);


extern volatile __bit RB1 __at(0x31);


extern volatile __bit RB2 __at(0x32);


extern volatile __bit RB3 __at(0x33);


extern volatile __bit RB4 __at(0x34);


extern volatile __bit RB5 __at(0x35);


extern volatile __bit RB6 __at(0x36);


extern volatile __bit RB7 __at(0x37);


extern volatile __bit RBIE __at(0x5B);


extern volatile __bit RBIF __at(0x58);


extern volatile __bit RP0 __at(0x1D);


extern volatile __bit RP1 __at(0x1E);


extern volatile __bit T0CS __at(0x40D);


extern volatile __bit T0IE __at(0x5D);


extern volatile __bit T0IF __at(0x5A);


extern volatile __bit T0SE __at(0x40C);


extern volatile __bit T1CKPS0 __at(0x84);


extern volatile __bit T1CKPS1 __at(0x85);


extern volatile __bit T1OSCEN __at(0x83);


extern volatile __bit T1SYNC __at(0x82);


extern volatile __bit T2CKPS0 __at(0x90);


extern volatile __bit T2CKPS1 __at(0x91);


extern volatile __bit TCCP __at(0x433);


extern volatile __bit TMR0IE __at(0x5D);


extern volatile __bit TMR0IF __at(0x5A);


extern volatile __bit TMR1CS __at(0x81);


extern volatile __bit TMR1IE __at(0x460);


extern volatile __bit TMR1IF __at(0x60);


extern volatile __bit TMR1ON __at(0x80);


extern volatile __bit TMR2IE __at(0x461);


extern volatile __bit TMR2IF __at(0x61);


extern volatile __bit TMR2ON __at(0x92);


extern volatile __bit TOUTPS0 __at(0x93);


extern volatile __bit TOUTPS1 __at(0x94);


extern volatile __bit TOUTPS2 __at(0x95);


extern volatile __bit TOUTPS3 __at(0x96);


extern volatile __bit TRISA0 __at(0x428);


extern volatile __bit TRISA1 __at(0x429);


extern volatile __bit TRISA2 __at(0x42A);


extern volatile __bit TRISA3 __at(0x42B);


extern volatile __bit TRISA4 __at(0x42C);


extern volatile __bit TRISB0 __at(0x430);


extern volatile __bit TRISB1 __at(0x431);


extern volatile __bit TRISB2 __at(0x432);


extern volatile __bit TRISB3 __at(0x433);


extern volatile __bit TRISB4 __at(0x434);


extern volatile __bit TRISB5 __at(0x435);


extern volatile __bit TRISB6 __at(0x436);


extern volatile __bit TRISB7 __at(0x437);


extern volatile __bit TT1CK __at(0x431);


extern volatile __bit ZERO __at(0x1A);


extern volatile __bit nBO __at(0x470);


extern volatile __bit nBOD __at(0x470);


extern volatile __bit nBOR __at(0x470);


extern volatile __bit nDONE __at(0xFA);


extern volatile __bit nPD __at(0x1B);


extern volatile __bit nPOR __at(0x471);


extern volatile __bit nRBPU __at(0x40F);


extern volatile __bit nT1SYNC __at(0x82);


extern volatile __bit nTO __at(0x1C);


# 30 "C:\Program Files (x86)\Microchip\xc8\v2.00\pic\include\pic.h"
#pragma intrinsic(__nop)
extern void __nop(void);

# 78
__attribute__((__unsupported__("The " "FLASH_READ" " macro function is no longer supported. Please use the MPLAB X MCC."))) unsigned char __flash_read(unsigned short addr);

__attribute__((__unsupported__("The " "FLASH_WRITE" " macro function is no longer supported. Please use the MPLAB X MCC."))) void __flash_write(unsigned short addr, unsigned short data);

__attribute__((__unsupported__("The " "FLASH_ERASE" " macro function is no longer supported. Please use the MPLAB X MCC."))) void __flash_erase(unsigned short addr);


# 91
#pragma intrinsic(_delay)
extern __nonreentrant void _delay(unsigned long);
#pragma intrinsic(_delaywdt)
extern __nonreentrant void _delaywdt(unsigned long);

# 137
extern __bank0 unsigned char __resetbits;
extern __bank0 __bit __powerdown;
extern __bank0 __bit __timeout;

# 8 "led.h"
void ledprint(unsigned int number);
void TIM0_Callback(void);


# 10 "main.h"
#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = OFF
#pragma config BOREN = OFF
#pragma config BODENV = 40
#pragma config CP = ON

# 4 "main.c"
unsigned char fl=0;





#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = OFF
#pragma config BOREN = OFF
#pragma config BODENV = 40
#pragma config CP = ON

# 21
unsigned int u;

void tezlik()
{

# 30
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;

_delay((unsigned long)((800)*(4000000/4000.0)));
u=10;
return;

# 62
}



void __interrupt() isr()
{
if (INTF==1)
{
ledprint(u);
u=999;
INTF=0;


}
if(T0IF)
{
TIM0_Callback();
T0IF=0;
}

}



void main(void) {

TRISA = 0x00;
PORTA = 0xFF;
TRISB = 0b00000001;
PORTB = 0b00000000;
OPTION_REG=0b01001011;

INTCON=0b11111000;

TMR0=200;
ECCPAS2 = 0;

# 105
while(1)
{

for(u=999;u>0;u--)
{




_delay((unsigned long)((127)*(4000000/4000000.0)));

}
}
return;


}
