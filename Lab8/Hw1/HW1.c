#include "at89c5131.h"
#include "stdio.h"

void Timer_Init()	;
void init_serial();
void sdelay(int delay);
void delay_ms(int delay);
sbit LED = P1^7;
sbit LED1 = P1^6;
sbit Parity = PSW^0;
sbit tb8 = SCON^3;


void main()
{
Timer_init();
init_serial();
LED = 1;	
SBUF = 0x41;
while(1);
}
void ISR_Serial(void) interrupt 4
{
LED=~LED;
//LED1=~LED1;
//delay_ms(1000);	
TI = 0;
ACC = 0x41;
ACC +=0;	
tb8 = Parity;
SBUF = ACC;	
}
void Timer_Init()	
{
TMOD = 0X20;
TH1 = 0xFD;
TH1 = 0xCC;
TR1 = 1;
TMOD |= 0X20;
}

void init_serial()
{
//Initialize serial communication and interrupts
SCON |= 0XC0;
ES = 1;
EA = 1;
}
void sdelay(int delay)
{
	char d=0;
	while(delay>0)
	{
		for(d=0;d<5;d++);
		delay--;
	}
}
void delay_ms(int delay)
{
	int d=0;
	while(delay>0)
	{
		for(d=0;d<382;d++);
		delay--;
	}
}
