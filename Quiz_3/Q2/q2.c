#include "at89c5131.h"
#include "stdio.h"
sbit toggle = P3^7;
void Timer_init0();
void Timer_init1();
void init_serial();
sbit Parity = PSW^0;
sbit tb8 = SCON^3;
bit transmit_completed= 0;
float p,x,y,q,i;
float val;
unsigned char valstring[7];
void transmit_value(float val);
void main(){
	p=0;
	x=0;
	y=0;
	q=2.5;
Timer_init0();
Timer_init1();
init_serial();
while(1){
//transmit_value(val);
}
}


void timer0_isr(void) interrupt 1{
	toggle =~toggle;
TH0 = 0xCF;
TL0 = 0x2B;	
x = ((0.98078)*p)+((0.19509)*q);
y = ((0.98078)*q)-((0.19509)*p);	
p=x;
q=y;
i=p+2.5;
val=i;
}

void Timer_init0()	
{
TMOD |= 0X01;
TH0 = 0xCF;
TL0 = 0x2B;
TR0= 1;
ET0 =1;
}
void ISR_Serial(void) interrupt 4
{
TI = 0;
transmit_completed =1;
}
void Timer_init1()	
{
TMOD |= 0X20;
TH1 = 0xCC;
TR1 = 0;
}
void init_serial()
{
//Initialize serial communication and interrupts
SCON |= 0XC0;
ES = 1;
EA = 1;
}
/*void transmit_value(float val){
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
}*/
