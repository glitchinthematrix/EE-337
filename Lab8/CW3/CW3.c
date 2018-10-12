#include "at89c5131.h"
#include "stdio.h"
sbit CS_BAR = P1^4;									// Chip Select for the ADC
sbit LCD_rs = P0^0;  								// LCD Register Select
sbit LCD_rw = P0^1;  								// LCD Read/Write
sbit LCD_en = P0^2;  								// LCD Enable
sbit LCD_busy = P2^7;								// LCD Busy Flag
sbit ONULL = P1^0;
sbit RS=P0^0;
sbit RW=P0^1;
sbit EN=P0^2;
sbit LED = P1^7;
sbit LED1 = P1^6;
sbit Parity = PSW^0;
sbit tb8 = SCON^3;
void lcd_init(void);
void lcd_cmd(unsigned int i);
void lcd_char(unsigned char ch);
void lcd_write_string(unsigned char *s);
void port_init(void);
void keypad_init(void);
void sdelay(int delay);
unsigned char read_keypad(void);
void Timer_Init();
void init_serial();

unsigned char c = 'N';
void msdelay(unsigned int time)
{
	int i,j;
	for(i=0;i<time;i++)
	{
		for(j=0;j<382;j++);
	}
}

void main(void){
Timer_init();
init_serial();
lcd_init();
keypad_init();
lcd_cmd(0x80);
lcd_write_string("Key Pressed:\0");
while(1);	
}


void keypad_interrupt(void) interrupt 8
{ unsigned char pressed = read_keypad();
	KBF = 00;
	lcd_cmd(0x8D);
	lcd_char(pressed);
	msdelay(10);
	if(c=='Y'){
	ACC = pressed;
   ACC +=0;	
	 tb8 = Parity;
   SBUF = ACC;	
	}
}	
void keypad_init(void)
{
      P1=0xF0;
      KBE=0xF0;  //MOV 0x9D,#0xF0  ;KBE
      KBLS=0x0F;   //MOV 0x9C,#0x0F  ;KBLS
	  KBF=00; //0x9E,#00    ;KBF
      IEN1=0x01;   //MOV 0xB1,#0x01  ;IE1
		  EA=1;
}	
unsigned char read_keypad(void)
{

   unsigned char key=0,row=0,col=0,no=0,no_1=0,temp=0;
	 unsigned int i=0;
	 unsigned char final_val=0;
	
	 P1= 0xF0;
	
   temp=((~P1) & 0xF0)>>4; //row
	 i=0;
	 while(i<=3)
	 {
      if(((temp>>i)&0x01)==1)
      {
				row=i;
				break;
			}
      i++;			
   }
   P1=0x0F;
   temp=((~P1) & 0x0F); //col 
   i=0;
	 while(i<=3)
	 {
      if(((temp>>i) & 0x01)==1)
      {
				col=i;			
				break;
			}
      i++;			
   }
	 //col=i;
	 no=(4*row)+col;
	 //delay_in_ms(15);
	 P1=0xF0;
   temp=((~P1) & 0xF0)>>4; //row 
	 i=0;
	 while(i<=3)
	 {
      if(((temp>>i) & 0x01)==1)
      {
				row=i;	
			  break;
			}
      i++;			
   }
   P1=0x0F;
	 temp=((~P1)&0x0F);
   i=0;
	 while(i<=3)
	 {
      if(((temp>>i) & 0x01)==1)
      {
				col=i;	
				break;
			}
      i++;			
   }	 
	 //col=i;
   no_1=4*row+col;
   if(no==no_1)
	 {
		  final_val=no;
	 }
	 final_val += 48;
   
	 if(final_val > 57 && final_val < 65)
		final_val += 7;
	 
	 P1=0xF0;
	 
	 while(P1!= 0xF0)
	 		 P1= 0xF0;
	 
	  KBF=0x00;
	  while(KBF); //Wait till flag gets cleared
	 	 
	 return final_val;
}



/**
 * FUNCTION_PURPOSE: A delay of 15us for a 24 MHz crystal
 * FUNCTION_INPUTS: void
 * FUNCTION_OUTPUTS: none
 */

void lcd_cmd(unsigned int i)
{
	RS=0;
	RW=0;
	EN=1;
	P2=i;
	msdelay(10);
	EN=0;
}
void lcd_char(unsigned char ch)
{
	RS=1;
	RW=0;
	EN=1;
	P2=ch;
	msdelay(10);
	EN=0;
}
void lcd_write_string(unsigned char *s)
{
	while(*s!='\0')
	{
		lcd_char(*s++);
	}
}
void lcd_init(void)
{
	//port_init();
	lcd_cmd(0x38);
	msdelay(4);
	lcd_cmd(0x06);
	msdelay(4);
	lcd_cmd(0x0C);
	msdelay(4);
	lcd_cmd(0x01);
	msdelay(4);
	lcd_cmd(0x80);
}
void port_init(void)
{
	P2=0x00;
	EN=0;
	RS=0;
	RW=0;
}
void ISR_Serial(void) interrupt 4
{
if (TI==1){
	TI = 0;}
else if (RI == 1){
	c = SBUF;
	RI=0;
}
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
SCON |= 0XD0;
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
