#include "at89c5131.h"
#include "stdio.h"

void Timer_Init()	;
void init_serial();
void sdelay(int delay);
void delay_ms(int delay);
void transmit_value(float val);
void transmit_value1(float val);
void transmit_value2(float val);
void transmit_value3(float val);
void transmit_value4(float val);
sbit LED = P1^7;
sbit LED1 = P1^6;
sbit Parity = PSW^0;
sbit tb8 = SCON^3;
bit transmit_completed= 0;
float values[5] = {1.555,3.110,4.665,6.220,7.775};
unsigned char valstring[7] ;
unsigned char valstring1[7] ;
float val;


void main()
{

Timer_init();
init_serial();
LED = 1;	
while(1){
transmit_value(1.555);
transmit_value1(values[1]);
transmit_value2(values[2]);
transmit_value3(values[3]);
transmit_value4(values[4]);	

}
}
void ISR_Serial(void) interrupt 4
{
TI = 0;
transmit_completed =1;
}
void Timer_Init()	
{
TMOD |= 0X20;
TH1 = 0xCC;
TR1 = 1;

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
void transmit_value(float val){
	int i = 0;
 sprintf(valstring, " %1.3f\n",val);
	for(i=0;i<7;i++){
	ACC = valstring[i];
	ACC+=0;
	tb8 = Parity;
	SBUF = ACC;
	while(!transmit_completed);
	transmit_completed = 0;
	}
return;
}
void transmit_value1(float val){
	int i = 0;
 sprintf(valstring1, " %1.3f\n",val);
	for(i=0;i<7;i++){
	ACC = valstring1[i];
	ACC+=0;
	tb8 = Parity;
	SBUF = ACC;
	while(!transmit_completed);
	transmit_completed = 0;
	}
return;
}
void transmit_value2(float val){
	int i = 0;
 sprintf(valstring, " %1.3f\n",val);
	for(i=0;i<7;i++){
	ACC = valstring[i];
	ACC+=0;
	tb8 = Parity;
	SBUF = ACC;
	while(!transmit_completed);
	transmit_completed = 0;
	}
return;
}
void transmit_value3(float val){
	int i = 0;
 sprintf(valstring, " %1.3f\n",val);
	for(i=0;i<7;i++){
	ACC = valstring[i];
	ACC+=0;
	tb8 = Parity;
	SBUF = ACC;
	while(!transmit_completed);
	transmit_completed = 0;
	}
	return;

}
void transmit_value4(float val){
	int i = 0;
 sprintf(valstring, " %1.3f\n",val);
	for(i=0;i<7;i++){
	ACC = valstring[i];
	ACC+=0;
	tb8 = Parity;
	SBUF = ACC;
	while(!transmit_completed);
		
	transmit_completed = 0;
	}
	return;
}