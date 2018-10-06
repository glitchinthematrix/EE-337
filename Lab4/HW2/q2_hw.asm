; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
	ljmp MAIN

org 200h
start:
      mov P2,#00h
      mov P1,#00h
	  ;initial delay for lcd power up

	;here1:setb p1.0
      	  acall delay
	;clr p1.0
	  acall delay
	;sjmp here1


	  acall lcd_init      ;initialise LCD
	
	  acall delay
	  acall delay
	  acall delay
	  mov a,#80h		 ;Put cursor on first row,5 column
	  acall lcd_command	 ;send command to LCD
	  acall delay
	  mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
	  acall lcd_sendstring	   ;call text strings sending routine
	  acall delay

	  mov a,#0C0h		  ;Put cursor on second row,3 column
	  acall lcd_command
	  acall delay
	  mov   R0, #7FH
	  acall lcd_sendstring_array
	  
	  ret
			//stay here 

;------------------------LCD Initialisation routine----------------------------------------------------
lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine

;-----------------------command sending routine-------------------------------------
 lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
;-----------------------data sending routine-------------------------------------		     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine

;-----------------------text strings sending routine-------------------------------------
lcd_sendstring:
	 push 0e0h
	 loopx: clr   a                 ;clear Accumulator for any previous data
         movc  a,@a+dptr       ;load the first character in accumulator
         jz    exit              ;go to exit if zero
         acall lcd_senddata      ;send first char
         inc   dptr              ;increment data pointer
         sjmp  loopx    ;jump back to send the next character
exit:    pop 0e0h
         ret                     ;End of routine
;----------------------------------------------------------------------------------------
lcd_sendstring_array:
	 push 0E0H
	 loop1: clr   a                 ;clear Accumulator for any previous data
         mov a,@R0         ;load the first character in accumulator
         jz    exit1              ;go to exit if zero
         acall lcd_senddata      ;send first char
         inc   r0              ;increment data pointer
         sjmp  loop1   ;jump back to send the next character
exit1:    pop 0E0H
         ret                     ;End of routine		 

;----------------------delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loopa:	 djnz r1, loopa
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret

;------------- ROM text strings---------------------------------------------------------------
org 300h
my_string1:
         DB   "  EE 337-Lab 4  ", 00H
main:

	MOV R0,#7FH
	MOV @R0,#20h;
	INC R0
	MOV @R0,'B';B
	INC R0
	MOV @R0,#48H;H
	INC R0
	MOV @R0,#49H;I
	INC R0
	MOV @R0,#53H;S
	INC R0
	MOV @R0,#48H;H
	INC R0
	MOV @R0,#4DH;M
	INC R0
	MOV @R0,#41H;A
	INC R0
	MOV @R0,#20H;
	INC R0
	MOV @R0,#44H;D
	INC R0
	MOV @R0,#45H;E
	INC R0
	MOV @R0,#44H;D
	INC R0
	MOV @R0,#48H;H
	INC R0
	MOV @R0,#49H;I
	INC R0
	MOV @R0,#41H;A
	INC R0
	MOV @R0,#20H;
	INC R0
	MOV @R0,#00H;
	LCALL START
	HERE: SJMP HERE;
	
	
end

