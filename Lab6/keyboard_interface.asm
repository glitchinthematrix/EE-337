; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
	ljmp MAIN
org 003bh
	ljmp detect_stuff
org 200h
start:
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
	  mov a,#80h
	  acall lcd_command	 ;send command to LCD
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
lcd_clear:
	acall delay
    mov   LCD_data,#01H  ;Clear LCD
    clr   LCD_rs         ;Selected command register
    clr   LCD_rw         ;We are writing in instruction register
    setb  LCD_en         ;Enable H->L
	acall delay
    clr   LCD_en
	acall delay_10ms
	
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
	 mov r6,#0
	 loop1: clr   a                 ;clear Accumulator for any previous data
         mov a,@R0         ;load the first character in accumulator
         jz    exit1              ;go to exit if zero
         acall lcd_senddata      ;send first char
         inc   r0              ;increment data pointer
		 mov a,r6
		 CJNE a,#16,nextinst
		 mov a,#80h
	     acall lcd_command	 ;send command to LCD
	     acall delay
		 mov r6,#00h
		 nextinst:mov a,@r0
		 CJNE a,#00h,loopback
		 mov r0,#7fh	
         loopback:lcall delay1
		 inc r6
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
DELAY1: 
	SETB PSW.5
		   MOV R3, 40H
	BACK2:
	MOV R2,#200
	BACK1:
	MOV R1,#0FFH
	BACK :
	DJNZ R1, BACK
	DJNZ R2, BACK1
	DJNZ R3,BACK2
	CLR PSW.5
	RET
delay_10ms:
	MOV R2,#40
	BACK01:
	MOV R1,#0FFH
	BACK0:
	DJNZ R1, BACK0
	DJNZ R2, BACK01
	RET
delay_1s:
	mov r3,#20
	BACK13:
	MOV R2,#200
	BACK11:
	MOV R1,#0FFH
	BACK10:
	DJNZ R1, BACK10
	DJNZ R2, BACK11
	DJNZ R3, BACK13
	RET

	
;-------------------------------------------
my_string1:
DB   "Key pressed is ", 00H
	
org 400h;ascii LUT
	kcode0: db '0','1','2','3';row0
	kcode1: db '4','5','6','7';row1
	kcode2: db '8','9','A','B';row2
	kcode3: db 'C','D','E','F';row3

		
;------------------		
MAIN:mov P1,#0f0h;
	mov IE,#80h
	mov a,0b1h		;IEN1, interrupt enable register
   ORL a,#01		;changing only the required bit, without changing the other bits
   mov 0b1h,a	
	mov 9cH,#0Fh		;KBLS (level selector), LSB as row, MSB as column
	mov 9dH,#0f0h		;KBE (Keyboard enable) LSB as interrupt, MSB as I/O
	mov 40h,#2
	MOV R0,#7FH
	MOV @R0,#41H;
	INC R0
	MOV @R0,#42H;
	INC R0
	MOV @R0,#43H;
	INC R0
	MOV @R0,#44H;
	INC R0
	MOV @R0,#45H;
	INC R0
	MOV @R0,#46H;
	INC R0
	MOV @R0,#47H;
	INC R0
	MOV @R0,#48H;
	INC R0
	MOV @R0,#49H;
	INC R0
	MOV @R0,#4AH;
	INC R0
	MOV @R0,#4BH;
	INC R0
	MOV @R0,#4CH;
	INC R0
	MOV @R0,#4DH;
	INC R0
	MOV @R0,#4EH;
	INC R0
	MOV @R0,#4FH;
	INC R0
	MOV @R0,#50H;
	INC R0
	MOV @R0,#51H;
	INC R0
	MOV @R0,#52H;
	INC R0
	MOV @R0,#53H;
	INC R0
	MOV @R0,#54H;
	INC R0
	MOV @R0,#55H;
	INC R0
	MOV @R0,#56H;
	INC R0
	MOV @R0,#57H;
	INC R0
	MOV @R0,#58H;
	INC R0
	MOV @R0,#59H;
	INC R0
	MOV @R0,#5AH;
	INC R0
	MOV @R0,#00H;
	INC R0
	lcall start
	
	detect_stuff:
	push 0
	push 1
	push 2
	push 3
	;push 6
	mov 7,a
	push 7
	acall delay_10ms
	mov a,p1
	anl a,#0f0h
	cjne a,#0f0h,donotexit
	ljmp exit_isr
	donotexit:
	acall lcd_clear
	acall delay
	mov a,#80h		 ;Put cursor on first row,0 column
	acall lcd_command	 ;send command to LCD
	mov   dptr,#my_string1   ;Load DPTR with sring1 Addr
	acall lcd_sendstring	   ;call text strings sending routine
	;start detecting rows
	mov p1, #11111110b
	mov a,p1
	anl a,#0f0h
	cjne a,#0f0h,row0
	mov p1, #11111101b
	mov a,p1
	anl a,#0f0h
	cjne a,#0f0h,row1
	mov p1, #11111011b
	mov a,p1
	anl a,#0f0h
	cjne a,#0f0h,row2
	mov p1, #11110111b
	mov a,p1
	anl a,#0f0h
	cjne a,#0f0h,row3
	row0:
	swap a
	mov dptr,#kcode0
	loopr0:rrc a
		 jnc send_to_lcd
		 inc dptr
		 sjmp loopr0
	
	row1:
	swap a
	mov dptr,#kcode1
	loopr1:rrc a
		 jnc send_to_lcd
		 inc dptr
		 sjmp loopr1
	
	
	row2:
	swap a
	mov dptr,#kcode2
	loopr2:rrc a
		 jnc send_to_lcd
		 inc dptr
		 sjmp loopr2
	
	row3:
	swap a
	mov dptr,#kcode3
	loopr3:rrc a
		 jnc send_to_lcd
		 inc dptr
		 sjmp loopr3
		 
	send_to_lcd:
	clr a
	movc a,@a+dptr
	acall lcd_senddata;
	acall delay_1s;
	
	
	exit_isr:
	mov 009EH,#00;
	mov a,009eh
	cjne a,#00h, exit_isr
	acall lcd_clear
	clr a
	mov a,#80h
	add a,r6
	acall lcd_command	 ;send command to LCD
	acall delay
	
	pop 7
	mov a,7
	;pop 6
	pop 3
	pop 2
	pop 1
	pop 0
	mov p1,#0f0h
	
	reti
	end
