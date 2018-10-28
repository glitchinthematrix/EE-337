#include "at89c5131.h"
#include "stdio.h"
sbit led = P2^0;
void SPI_Init();
void sdelay(int delay);
void delay_ms(int delay);
void timer_init();

sbit C0 = P1^7;	
char high=239,low=190;
sbit CS_BAR = P3^4;
sbit FS = P3^5;	
bit transmit_completed= 0;
bit complete = 0;
bit part_1 = 1;
bit part_2 = 0;
bit part_3=0;
unsigned char x=1;

unsigned char count=0, it=0;
char test [] = {0xEF,0xBE,  0xF1,0x8C,  0xF2,0xFE,  0xF3,0xCE,
								0xF5,0x29,  0xF6,0x3F,  0xF7,0x50,  0xF7,0xDF,
								0xF7,0xDF,  0xF7,0x50,  0xF6,0x3F,  0xF5,0x29,
								0xF3,0xCE,  0xF2,0xFE,  0xF1,0x8C,  0xEF,0xBE 
								
};
unsigned char serial_data;						// To check if spi data transmit is complete
unsigned int triangle_value = 0;
unsigned int triangle_value_buf = 0;
unsigned int i=0;
unsigned int j=1;
unsigned int k=150;
/*
unsigned int sine_values[32] = {0x0800,
0x098F,
0x0B0F,
0x0C71,
0x0DA7,
0x0EA6,
0x0F63,
0x0FD8,
0x0FFF,
0x0FD9,
0x0F64,
0x0EA8,
0x0DA9,
0x0C74,
0x0B12,
0x0992,
0x0803,
0x0673,
0x04F3,
0x0391,
0x025A,
0x015B,
0x009D,
0x0028,
0x0000,
0x0026,
0x0099,
0x0156,
0x0253,
0x0389,
0x04EA,
0x066A};*/
void main(void)
{
SPI_Init();
timer_init();
while(1)
	{
		CS_BAR = 0;  
		FS = 1;  
		FS = 0;    
		         							// falling edge of CS bar
		SPDAT= (triangle_value>>8)&(0xFF);	
								// first 4 bits will be address of the channel
		while(!transmit_completed);								// wait for the transmit complete flag							// save the 
		transmit_completed = 0;    								// make the flag 0
	        							// falling edge of CS bar
		SPDAT= triangle_value;

		while(!transmit_completed);	
		transmit_completed = 0; 
		CS_BAR = 1;
	//	i+=1;
	//	led=~led;
		/*if (i==32){
		i=0;
		}*/
		/*if(i==0){
		should_increase =1;
		}*/
	
		
		
	
		//sdelay(2);
	
}
	}
void timer_init()
{
 TMOD=0x11;		
 TL1 =190;	
 TH1 =239;		
 TL0 =0xA2; 		
 TH0 =0x3F;
	EA=1;
	ET0=1;
	ET1=1;
	TR0=1;
	//TR1=1;
	
}	

void SPI_Init()
{
	
	CS_BAR = 1;	                  	// DISABLE ADC SLAVE SELECT-CS 
	FS = 1;
	SPCON |= 0x20;               	 	// P1.1(SSBAR) is available as standard I/O pin 
	SPCON |= 0x01;                	// Fclk Periph/4 AND Fclk Periph=12MHz ,HENCE SCK IE. BAUD RATE=3000KHz 
	SPCON |= 0x10;               	 	// Master mode 
	SPCON |=0x08;               	// CPOL=0; transmit mode example|| SCK is 0 at idle state
	SPCON &= ~0x04;                	// CPHA=0; transmit mode example 
	IEN1 |= 0x04;                	 	// enable spi interrupt 
	EA=1;                         	// enable interrupts 
	SPCON |= 0x40;                	// run spi;ENABLE SPI INTERFACE SPEN= 1 
//	IPH0 |=0x10;
//	IPL0 |=0x10;
}

void it_SPI(void) interrupt 9 /* interrupt address is 0x004B, (Address -3)/8 = interrupt no.*/
{
	switch	( SPSTA )         /* read and clear spi status register */
	{

		case 0x80:	
		   /* read receive data */
		transmit_completed=1;/* set software flag */
		serial_data=SPDAT;
 		break;

		case 0x10:
			
		break;
	
		case 0x40:
		break;
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
void sdelay(int delay)//1us delay
{
	char d=0;
	while(delay>0)
	{
		for(d=0;d<5;d++);
		delay--;
	}
}
void TIMER1_ISR (void) interrupt 3
{

	TR1=0;
	TL1 = low ;
	TH1 = high;
    complete  = ~ complete;
	if(complete){
	triangle_value = triangle_value_buf;}
	else{
	triangle_value =0;}
	TR1=1;
  
}

void TIMER0_ISR (void) interrupt 1

{
	TR0=0;
	TL0 =0xA2;
	TH0 =0x3F;
	x--;
	if(x==0)
	{
			if(it==32)
		{
			TR0=0;
			TR1=0;
		}
		else
		{
		P3_7 = ~P3_7;
	  high= test[it];
 		low= test[it+1];
	it=it+2;
		x=250;
	TR1=1;
		}
	}
	
			if(i==49){
		part_1 = 0;
		part_2=1;
		i=0;}
		if(j==50){
		part_2 = 0;
		part_3 = 1;
		j=1;	
		}
		if(k==1){
		part_3=0;
		part_1 =1;
			k=150;
		}
		/*if(i==0){
		should_increase =1;
		}*/
		if(part_1){
		triangle_value_buf = triangle_value_buf +4095/50;
			i+=1;
		}
		else if(part_2){
			triangle_value_buf=4095;
			j+=1;
		}
		else if(part_3){
			triangle_value_buf = triangle_value_buf -4095/150;
			k-=1;
		}
	TR0=1;

	
}