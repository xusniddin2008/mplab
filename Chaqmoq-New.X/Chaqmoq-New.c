//#define F_CPU 400000UL
#include <avr/io.h>
#include <avr/interrupt.h>
unsigned char i;
unsigned char y;
unsigned char data = 1;

void adcTest() {
    wait1(2);
    ADCSRA |= (1 << ADEN);
    wait1(8);
    ADCSRA |= (1 << ADSC);
    while (!ADSC);
    OSCCAL = ADCH >> 1;
    ADCSRA |= (0 << ADEN);
}

void wait(unsigned char t) {
    TCNT0 = 0;
    while (TCNT0 < t) {
    }
    TCNT0 = 0;
    while (TCNT0 < t) {
    }
    if (t > 0) {
        adcTest();
    }
}

void wait1(unsigned char t) {
    TCNT0 = 0;
    while (TCNT0 < t) {
    }
    TCNT0 = 0;
    while (TCNT0 < t) {
    }
}

void timer(unsigned char time1, unsigned char time2, unsigned char pb0, unsigned char pb1) {
    if (pb0 == 1) {
        PORTB |= (1 << PB0);
    }
    if (pb1 == 1) {
        PORTB |= (1 << PB1);
    }
    wait(time1);
    if (pb0 == 1) {
        PORTB &= ~(1 << PB0);
    }
    if (pb1 == 1) {
        PORTB &= ~(1 << PB1);
    }
    wait(time2);
}

void forLoop(unsigned char time1, unsigned char time2, unsigned char pb0, unsigned char pb1, unsigned char loop) {
    for (i = 0; i <= loop; i++) {
        if (pb0 == 1) {
            PORTB |= (1 << PB0);
        }
        if (pb1 == 1) {
            PORTB |= (1 << PB1);
        }
        wait(time1);
        if (pb0 == 1) {
            PORTB &= ~(1 << PB0);
        }
        if (pb1 == 1) {
            PORTB &= ~(1 << PB1);
        }
        wait(time2);
    }
}

void EEPROMwrite() {
    while (EECR & (1 << EEWE)) { //???? ???????????? ????? ????????? ????????? ????????? ? ???????
    }
    EEAR = 1; //????????????? ?????
    EEDR = data; //????? ?????? ? ???????
    EECR |= (1 << EEMWE); //????????? ??????
    EECR |= (1 << EEWE); //????? ???? ? ??????
}

void EEPROMread() {
    while (EECR & (1 << EEWE)) { //???? ???????????? ????? ????????? ????????? ????????? ? ???????
    }
    EEAR = 1; //????????????? ?????
    EECR |= (1 << EERE); //????????? ???????? ?????????? ?? ?????? ? ??????? ??????
    data = EEDR; //?????????? ?????????
}

prog() {
    switch (data) {
        case 1:
            timer(38, 0, 1, 0);
            timer(38, 0, 0, 1);
            break;
        case 2:
            forLoop(38, 38, 1, 0, 1);
            wait1(110);
            forLoop(38, 38, 0, 1, 1);
            wait1(110);
            break;
        case 3:
            forLoop(38, 38, 1, 0, 2);
            wait1(110);
            forLoop(38, 38, 0, 1, 2);
            wait1(110);
            break;
        case 4:
            forLoop(38, 38, 1, 0, 3);
            wait1(110);
            forLoop(38, 38, 0, 1, 3);
            wait1(110);
            break;
        case 5:
            forLoop(38, 38, 1, 0, 4);
            wait1(110);
            forLoop(38, 38, 0, 1, 4);
            wait1(110);
            break;
        case 6:
            forLoop(38, 38, 1, 1, 1);
            wait1(255);
            break;
        case 7:
            forLoop(38, 38, 1, 1, 3);
            wait1(255);
            break;
        case 8:
            while (y <= 7) {
                timer(38, 38, 1, 1);
                timer(38, 38, 1, 1);
                y++;
            }
            if (y == 8) {
                wait1(255);
                wait1(145);
                PORTB = 0b00000011;
                y++;
            }
            break;
            case 9:
                forLoop(38, 38, 1, 1, 6);
                wait1(255);
                break;
            case 10:
                while (y <= 2) {
                    forLoop(38, 38, 1, 1, 2);
                    wait1(255);
                    y++;
                }
                if (y == 3) {
                    PORTB = 0b00000011;
                    y++;
                }
                break;
            case 11:
                while (y <= 5) {
                    timer(38, 38, 1, 1);
                    y++;
                }
                if (y == 6) {
                    PORTB = 0b00000000;
                    wait1(255);
                    wait1(145);
                    PORTB = 0b00000011;
                    y++;
                }
                break;
            case 12:
                PORTB = 0b00000011;
                break;
    }
}

ISR(PCINT0_vect) {
    wait1(59);
    if ((PINB & (1 << 2)) == 0) {
        data++;
        PORTB = 0b00000000;
        y = 0;
        while ((PINB & (1 << 2)) == 0) {
        }
        EEPROMwrite();
    }
}

int main(void) {
    DDRB = 0b00010011;
    CLKPR = 0b00000011;
    ADMUX = 0b00100011;
    ADCSRA = 0b11000000;
    GIMSK = 0b00100000;
    PCMSK = 0b00000100;
    MCUCR |= (1 << ISC00) | (1 << ISC01);
    TCCR0A = 0x00;
    TCCR0B = (1 << CS02) | (0 << CS01) | (1 << CS00);
    SREG |= (1 << SREG_I);
    EEPROMread();
    while (1) {
        if (data < 1 || data > 12) {
            data = 1;
        }
        prog();
    }
}