# 1 "SPEED.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "SPEED.c" 2
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\xc.h" 1 3
# 18 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\xc.h" 3
extern const char __xc8_OPTIM_SPEED;

extern double __fpnormalize(double);



# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\xc8debug.h" 1 3
# 13 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\xc8debug.h" 3
#pragma intrinsic(__builtin_software_breakpoint)
extern void __builtin_software_breakpoint(void);
# 23 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\xc.h" 2 3




# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 1 3




# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\htc.h" 1 3



# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\xc.h" 1 3
# 4 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\htc.h" 2 3
# 5 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 2 3








# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic_chip_select.h" 1 3
# 2288 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic_chip_select.h" 3
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 1 3
# 44 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\__at.h" 1 3
# 44 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 2 3








extern volatile unsigned char INDF __attribute__((address(0x000)));

__asm("INDF equ 00h");




extern volatile unsigned char TMR0 __attribute__((address(0x001)));

__asm("TMR0 equ 01h");




extern volatile unsigned char PCL __attribute__((address(0x002)));

__asm("PCL equ 02h");




extern volatile unsigned char STATUS __attribute__((address(0x003)));

__asm("STATUS equ 03h");


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
extern volatile STATUSbits_t STATUSbits __attribute__((address(0x003)));
# 159 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char FSR __attribute__((address(0x004)));

__asm("FSR equ 04h");




extern volatile unsigned char PORTA __attribute__((address(0x005)));

__asm("PORTA equ 05h");


typedef union {
    struct {
        unsigned RA0 :1;
        unsigned RA1 :1;
        unsigned RA2 :1;
        unsigned RA3 :1;
        unsigned RA4 :1;
    };
} PORTAbits_t;
extern volatile PORTAbits_t PORTAbits __attribute__((address(0x005)));
# 210 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PORTB __attribute__((address(0x006)));

__asm("PORTB equ 06h");


extern volatile unsigned char DATACCP __attribute__((address(0x006)));

__asm("DATACCP equ 06h");


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
extern volatile PORTBbits_t PORTBbits __attribute__((address(0x006)));
# 291 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
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
extern volatile DATACCPbits_t DATACCPbits __attribute__((address(0x006)));
# 364 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PCLATH __attribute__((address(0x00A)));

__asm("PCLATH equ 0Ah");


typedef union {
    struct {
        unsigned PCLATH :5;
    };
} PCLATHbits_t;
extern volatile PCLATHbits_t PCLATHbits __attribute__((address(0x00A)));
# 384 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char INTCON __attribute__((address(0x00B)));

__asm("INTCON equ 0Bh");


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
extern volatile INTCONbits_t INTCONbits __attribute__((address(0x00B)));
# 462 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PIR1 __attribute__((address(0x00C)));

__asm("PIR1 equ 0Ch");


typedef union {
    struct {
        unsigned TMR1IF :1;
        unsigned TMR2IF :1;
        unsigned CCP1IF :1;
        unsigned :3;
        unsigned ADIF :1;
    };
} PIR1bits_t;
extern volatile PIR1bits_t PIR1bits __attribute__((address(0x00C)));
# 501 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned short TMR1 __attribute__((address(0x00E)));

__asm("TMR1 equ 0Eh");




extern volatile unsigned char TMR1L __attribute__((address(0x00E)));

__asm("TMR1L equ 0Eh");




extern volatile unsigned char TMR1H __attribute__((address(0x00F)));

__asm("TMR1H equ 0Fh");




extern volatile unsigned char T1CON __attribute__((address(0x010)));

__asm("T1CON equ 010h");


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
extern volatile T1CONbits_t T1CONbits __attribute__((address(0x010)));
# 588 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char TMR2 __attribute__((address(0x011)));

__asm("TMR2 equ 011h");




extern volatile unsigned char T2CON __attribute__((address(0x012)));

__asm("T2CON equ 012h");


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
extern volatile T2CONbits_t T2CONbits __attribute__((address(0x012)));
# 666 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned short CCPR1 __attribute__((address(0x015)));

__asm("CCPR1 equ 015h");




extern volatile unsigned char CCPR1L __attribute__((address(0x015)));

__asm("CCPR1L equ 015h");




extern volatile unsigned char CCPR1H __attribute__((address(0x016)));

__asm("CCPR1H equ 016h");




extern volatile unsigned char CCP1CON __attribute__((address(0x017)));

__asm("CCP1CON equ 017h");


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
extern volatile CCP1CONbits_t CCP1CONbits __attribute__((address(0x017)));
# 769 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PWM1CON __attribute__((address(0x018)));

__asm("PWM1CON equ 018h");


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
extern volatile PWM1CONbits_t PWM1CONbits __attribute__((address(0x018)));
# 839 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char ECCPAS __attribute__((address(0x019)));

__asm("ECCPAS equ 019h");


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
extern volatile ECCPASbits_t ECCPASbits __attribute__((address(0x019)));
# 917 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char ADRES __attribute__((address(0x01E)));

__asm("ADRES equ 01Eh");


typedef union {
    struct {
        unsigned ADRES :8;
    };
} ADRESbits_t;
extern volatile ADRESbits_t ADRESbits __attribute__((address(0x01E)));
# 937 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char ADCON0 __attribute__((address(0x01F)));

__asm("ADCON0 equ 01Fh");


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
extern volatile ADCON0bits_t ADCON0bits __attribute__((address(0x01F)));
# 1033 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char OPTION_REG __attribute__((address(0x081)));

__asm("OPTION_REG equ 081h");


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
extern volatile OPTION_REGbits_t OPTION_REGbits __attribute__((address(0x081)));
# 1103 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char TRISA __attribute__((address(0x085)));

__asm("TRISA equ 085h");


typedef union {
    struct {
        unsigned TRISA0 :1;
        unsigned TRISA1 :1;
        unsigned TRISA2 :1;
        unsigned TRISA3 :1;
        unsigned TRISA4 :1;
    };
} TRISAbits_t;
extern volatile TRISAbits_t TRISAbits __attribute__((address(0x085)));
# 1147 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char TRISB __attribute__((address(0x086)));

__asm("TRISB equ 086h");


extern volatile unsigned char TRISCP __attribute__((address(0x086)));

__asm("TRISCP equ 086h");


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
extern volatile TRISBbits_t TRISBbits __attribute__((address(0x086)));
# 1228 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
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
extern volatile TRISCPbits_t TRISCPbits __attribute__((address(0x086)));
# 1301 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PIE1 __attribute__((address(0x08C)));

__asm("PIE1 equ 08Ch");


typedef union {
    struct {
        unsigned TMR1IE :1;
        unsigned TMR2IE :1;
        unsigned CCP1IE :1;
        unsigned :3;
        unsigned ADIE :1;
    };
} PIE1bits_t;
extern volatile PIE1bits_t PIE1bits __attribute__((address(0x08C)));
# 1340 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PCON __attribute__((address(0x08E)));

__asm("PCON equ 08Eh");


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
extern volatile PCONbits_t PCONbits __attribute__((address(0x08E)));
# 1382 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile unsigned char PR2 __attribute__((address(0x092)));

__asm("PR2 equ 092h");




extern volatile unsigned char ADCON1 __attribute__((address(0x09F)));

__asm("ADCON1 equ 09Fh");


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
extern volatile ADCON1bits_t ADCON1bits __attribute__((address(0x09F)));
# 1435 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic16f716.h" 3
extern volatile __bit ADCS0 __attribute__((address(0xFE)));


extern volatile __bit ADCS1 __attribute__((address(0xFF)));


extern volatile __bit ADIE __attribute__((address(0x466)));


extern volatile __bit ADIF __attribute__((address(0x66)));


extern volatile __bit ADON __attribute__((address(0xF8)));


extern volatile __bit CARRY __attribute__((address(0x18)));


extern volatile __bit CCP1IE __attribute__((address(0x462)));


extern volatile __bit CCP1IF __attribute__((address(0x62)));


extern volatile __bit CCP1M0 __attribute__((address(0xB8)));


extern volatile __bit CCP1M1 __attribute__((address(0xB9)));


extern volatile __bit CCP1M2 __attribute__((address(0xBA)));


extern volatile __bit CCP1M3 __attribute__((address(0xBB)));


extern volatile __bit CHS0 __attribute__((address(0xFB)));


extern volatile __bit CHS1 __attribute__((address(0xFC)));


extern volatile __bit CHS2 __attribute__((address(0xFD)));


extern volatile __bit DC __attribute__((address(0x19)));


extern volatile __bit DC1B0 __attribute__((address(0xBC)));


extern volatile __bit DC1B1 __attribute__((address(0xBD)));


extern volatile __bit DCCP __attribute__((address(0x33)));


extern volatile __bit DT1CK __attribute__((address(0x31)));


extern volatile __bit ECCPAS0 __attribute__((address(0xCC)));


extern volatile __bit ECCPAS1 __attribute__((address(0xCD)));


extern volatile __bit ECCPAS2 __attribute__((address(0xCE)));


extern volatile __bit ECCPASE __attribute__((address(0xCF)));


extern volatile __bit GIE __attribute__((address(0x5F)));


extern volatile __bit GO __attribute__((address(0xFA)));


extern volatile __bit GO_DONE __attribute__((address(0xFA)));


extern volatile __bit GO_nDONE __attribute__((address(0xFA)));


extern volatile __bit INTE __attribute__((address(0x5C)));


extern volatile __bit INTEDG __attribute__((address(0x40E)));


extern volatile __bit INTF __attribute__((address(0x59)));


extern volatile __bit IRP __attribute__((address(0x1F)));


extern volatile __bit P1M0 __attribute__((address(0xBE)));


extern volatile __bit P1M1 __attribute__((address(0xBF)));


extern volatile __bit PCFG0 __attribute__((address(0x4F8)));


extern volatile __bit PCFG1 __attribute__((address(0x4F9)));


extern volatile __bit PCFG2 __attribute__((address(0x4FA)));


extern volatile __bit PDC0 __attribute__((address(0xC0)));


extern volatile __bit PDC1 __attribute__((address(0xC1)));


extern volatile __bit PDC2 __attribute__((address(0xC2)));


extern volatile __bit PDC3 __attribute__((address(0xC3)));


extern volatile __bit PDC4 __attribute__((address(0xC4)));


extern volatile __bit PDC5 __attribute__((address(0xC5)));


extern volatile __bit PDC6 __attribute__((address(0xC6)));


extern volatile __bit PEIE __attribute__((address(0x5E)));


extern volatile __bit PRSEN __attribute__((address(0xC7)));


extern volatile __bit PS0 __attribute__((address(0x408)));


extern volatile __bit PS1 __attribute__((address(0x409)));


extern volatile __bit PS2 __attribute__((address(0x40A)));


extern volatile __bit PSA __attribute__((address(0x40B)));


extern volatile __bit PSSAC0 __attribute__((address(0xCA)));


extern volatile __bit PSSAC1 __attribute__((address(0xCB)));


extern volatile __bit PSSBD0 __attribute__((address(0xC8)));


extern volatile __bit PSSBD1 __attribute__((address(0xC9)));


extern volatile __bit RA0 __attribute__((address(0x28)));


extern volatile __bit RA1 __attribute__((address(0x29)));


extern volatile __bit RA2 __attribute__((address(0x2A)));


extern volatile __bit RA3 __attribute__((address(0x2B)));


extern volatile __bit RA4 __attribute__((address(0x2C)));


extern volatile __bit RB0 __attribute__((address(0x30)));


extern volatile __bit RB1 __attribute__((address(0x31)));


extern volatile __bit RB2 __attribute__((address(0x32)));


extern volatile __bit RB3 __attribute__((address(0x33)));


extern volatile __bit RB4 __attribute__((address(0x34)));


extern volatile __bit RB5 __attribute__((address(0x35)));


extern volatile __bit RB6 __attribute__((address(0x36)));


extern volatile __bit RB7 __attribute__((address(0x37)));


extern volatile __bit RBIE __attribute__((address(0x5B)));


extern volatile __bit RBIF __attribute__((address(0x58)));


extern volatile __bit RP0 __attribute__((address(0x1D)));


extern volatile __bit RP1 __attribute__((address(0x1E)));


extern volatile __bit T0CS __attribute__((address(0x40D)));


extern volatile __bit T0IE __attribute__((address(0x5D)));


extern volatile __bit T0IF __attribute__((address(0x5A)));


extern volatile __bit T0SE __attribute__((address(0x40C)));


extern volatile __bit T1CKPS0 __attribute__((address(0x84)));


extern volatile __bit T1CKPS1 __attribute__((address(0x85)));


extern volatile __bit T1OSCEN __attribute__((address(0x83)));


extern volatile __bit T1SYNC __attribute__((address(0x82)));


extern volatile __bit T2CKPS0 __attribute__((address(0x90)));


extern volatile __bit T2CKPS1 __attribute__((address(0x91)));


extern volatile __bit TCCP __attribute__((address(0x433)));


extern volatile __bit TMR0IE __attribute__((address(0x5D)));


extern volatile __bit TMR0IF __attribute__((address(0x5A)));


extern volatile __bit TMR1CS __attribute__((address(0x81)));


extern volatile __bit TMR1IE __attribute__((address(0x460)));


extern volatile __bit TMR1IF __attribute__((address(0x60)));


extern volatile __bit TMR1ON __attribute__((address(0x80)));


extern volatile __bit TMR2IE __attribute__((address(0x461)));


extern volatile __bit TMR2IF __attribute__((address(0x61)));


extern volatile __bit TMR2ON __attribute__((address(0x92)));


extern volatile __bit TOUTPS0 __attribute__((address(0x93)));


extern volatile __bit TOUTPS1 __attribute__((address(0x94)));


extern volatile __bit TOUTPS2 __attribute__((address(0x95)));


extern volatile __bit TOUTPS3 __attribute__((address(0x96)));


extern volatile __bit TRISA0 __attribute__((address(0x428)));


extern volatile __bit TRISA1 __attribute__((address(0x429)));


extern volatile __bit TRISA2 __attribute__((address(0x42A)));


extern volatile __bit TRISA3 __attribute__((address(0x42B)));


extern volatile __bit TRISA4 __attribute__((address(0x42C)));


extern volatile __bit TRISB0 __attribute__((address(0x430)));


extern volatile __bit TRISB1 __attribute__((address(0x431)));


extern volatile __bit TRISB2 __attribute__((address(0x432)));


extern volatile __bit TRISB3 __attribute__((address(0x433)));


extern volatile __bit TRISB4 __attribute__((address(0x434)));


extern volatile __bit TRISB5 __attribute__((address(0x435)));


extern volatile __bit TRISB6 __attribute__((address(0x436)));


extern volatile __bit TRISB7 __attribute__((address(0x437)));


extern volatile __bit TT1CK __attribute__((address(0x431)));


extern volatile __bit ZERO __attribute__((address(0x1A)));


extern volatile __bit nBO __attribute__((address(0x470)));


extern volatile __bit nBOD __attribute__((address(0x470)));


extern volatile __bit nBOR __attribute__((address(0x470)));


extern volatile __bit nDONE __attribute__((address(0xFA)));


extern volatile __bit nPD __attribute__((address(0x1B)));


extern volatile __bit nPOR __attribute__((address(0x471)));


extern volatile __bit nRBPU __attribute__((address(0x40F)));


extern volatile __bit nT1SYNC __attribute__((address(0x82)));


extern volatile __bit nTO __attribute__((address(0x1C)));
# 2288 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic_chip_select.h" 2 3
# 13 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 2 3
# 30 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 3
#pragma intrinsic(__nop)
extern void __nop(void);
# 78 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 3
__attribute__((__unsupported__("The " "FLASH_READ" " macro function is no longer supported. Please use the MPLAB X MCC."))) unsigned char __flash_read(unsigned short addr);

__attribute__((__unsupported__("The " "FLASH_WRITE" " macro function is no longer supported. Please use the MPLAB X MCC."))) void __flash_write(unsigned short addr, unsigned short data);

__attribute__((__unsupported__("The " "FLASH_ERASE" " macro function is no longer supported. Please use the MPLAB X MCC."))) void __flash_erase(unsigned short addr);



# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\eeprom_routines.h" 1 3
# 85 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 2 3






#pragma intrinsic(_delay)
extern __attribute__((nonreentrant)) void _delay(unsigned long);
#pragma intrinsic(_delaywdt)
extern __attribute__((nonreentrant)) void _delaywdt(unsigned long);
# 137 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\pic.h" 3
extern __bank0 unsigned char __resetbits;
extern __bank0 __bit __powerdown;
extern __bank0 __bit __timeout;
# 27 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\xc.h" 2 3
# 1 "SPEED.c" 2

# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 1 3



# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\__size_t.h" 1 3



typedef unsigned size_t;
# 4 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 2 3

# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\__null.h" 1 3
# 5 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 2 3






# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdarg.h" 1 3






typedef void * va_list[1];

#pragma intrinsic(__va_start)
extern void * __va_start(void);

#pragma intrinsic(__va_arg)
extern void * __va_arg(void *, ...);
# 11 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 2 3
# 43 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 3
struct __prbuf
{
 char * ptr;
 void (* func)(char);
};
# 85 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 3
# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\conio.h" 1 3







# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\errno.h" 1 3
# 29 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\errno.h" 3
extern int errno;
# 8 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\conio.h" 2 3




extern void init_uart(void);

extern char getch(void);
extern char getche(void);
extern void putch(char);
extern void ungetch(char);

extern __bit kbhit(void);



extern char * cgets(char *);
extern void cputs(const char *);
# 85 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 2 3



extern int cprintf(char *, ...);
#pragma printf_check(cprintf)



extern int _doprnt(struct __prbuf *, const register char *, register va_list);
# 180 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdio.h" 3
#pragma printf_check(vprintf) const
#pragma printf_check(vsprintf) const

extern char * gets(char *);
extern int puts(const char *);
extern int scanf(const char *, ...) __attribute__((unsupported("scanf() is not supported by this compiler")));
extern int sscanf(const char *, const char *, ...) __attribute__((unsupported("sscanf() is not supported by this compiler")));
extern int vprintf(const char *, va_list) __attribute__((unsupported("vprintf() is not supported by this compiler")));
extern int vsprintf(char *, const char *, va_list) __attribute__((unsupported("vsprintf() is not supported by this compiler")));
extern int vscanf(const char *, va_list ap) __attribute__((unsupported("vscanf() is not supported by this compiler")));
extern int vsscanf(const char *, const char *, va_list) __attribute__((unsupported("vsscanf() is not supported by this compiler")));

#pragma printf_check(printf) const
#pragma printf_check(sprintf) const
extern int sprintf(char *, const char *, ...);
extern int printf(const char *, ...);
# 2 "SPEED.c" 2

# 1 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdlib.h" 1 3






typedef unsigned short wchar_t;







typedef struct {
 int rem;
 int quot;
} div_t;
typedef struct {
 unsigned rem;
 unsigned quot;
} udiv_t;
typedef struct {
 long quot;
 long rem;
} ldiv_t;
typedef struct {
 unsigned long quot;
 unsigned long rem;
} uldiv_t;
# 65 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdlib.h" 3
extern double atof(const char *);
extern double strtod(const char *, const char **);
extern int atoi(const char *);
extern unsigned xtoi(const char *);
extern long atol(const char *);



extern long strtol(const char *, char **, int);

extern int rand(void);
extern void srand(unsigned int);
extern void * calloc(size_t, size_t);
extern div_t div(int numer, int denom);
extern udiv_t udiv(unsigned numer, unsigned denom);
extern ldiv_t ldiv(long numer, long denom);
extern uldiv_t uldiv(unsigned long numer,unsigned long denom);



extern unsigned long _lrotl(unsigned long value, unsigned int shift);
extern unsigned long _lrotr(unsigned long value, unsigned int shift);
extern unsigned int _rotl(unsigned int value, unsigned int shift);
extern unsigned int _rotr(unsigned int value, unsigned int shift);




extern void * malloc(size_t);
extern void free(void *);
extern void * realloc(void *, size_t);
# 104 "C:\\Program Files (x86)\\Microchip\\xc8\\v2.00\\pic\\include\\c90\\stdlib.h" 3
extern int atexit(void (*)(void));
extern char * getenv(const char *);
extern char ** environ;
extern int system(char *);
extern void qsort(void *, size_t, size_t, int (*)(const void *, const void *));
extern void * bsearch(const void *, void *, size_t, size_t, int(*)(const void *, const void *));
extern int abs(int);
extern long labs(long);

extern char * itoa(char * buf, int val, int base);
extern char * utoa(char * buf, unsigned val, int base);




extern char * ltoa(char * buf, long val, int base);
extern char * ultoa(char * buf, unsigned long val, int base);

extern char * ftoa(float f, int * status);
# 3 "SPEED.c" 2






#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = OFF
#pragma config BOREN = OFF
#pragma config BODENV = 40
#pragma config CP = ON


unsigned char n_count=0, R1=0, R2=0, R3=0, R4=0;




void segchar (unsigned int seg)
{
  switch (seg)
  {
    case 1:
      PORTB = 0b01100000;
      break;
    case 2:
      PORTB = 0b11011010;
      break;
    case 3:
      PORTB = 0b11110010;
      break;
    case 4:
      PORTB = 0b01100110;
      break;
    case 5:
      PORTB = 0b10110110;
      break;
    case 6:
      PORTB = 0b10111110;
      break;
    case 7:
      PORTB = 0b11100000;
      break;
    case 8:
      PORTB = 0b11111110;
      break;
    case 9:
      PORTB = 0b11110110;
      break;
    case 0:
      PORTB = 0b11111100;
      break;
  }
}



void ledprint(unsigned int number)
{
  R1 = number%10;
  R2 = number%100/10;
  R3 = number%1000/100;
}

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


void interrupt tmr0_int (void)
{
    TIM0_Callback();
    T0IF=0;
}


void main(void) {
    unsigned int i;
    TRISA = 0x00;
    PORTA = 0x00;
    TRISB = 0x00;
    PORTB = 0x00;
    OPTION_REG=0b00000111;
    INTCON=0xA0;
    TMR0=0;

    while(1)
    {
        for(i=0;i<10000;i++)
        {
          ledprint(i);
          _delay((unsigned long)((200)*(8000000/4000.0)));
        }
# 139 "SPEED.c"
    }
    return;
}
