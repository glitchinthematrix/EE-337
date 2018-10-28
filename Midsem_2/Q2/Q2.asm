LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable



org 00h
	ljmp main
org 0003h
	ljmp isr_it0
org 000bh
	ljmp isr_t0
	
org 200h
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
;------------------------
	DELAY1: 
	push 1
	SETB PSW.4
		   MOV R3, 40H
	BACK3: 
		   MOV R4, #10
	BACK2:	   
		   MOV R5,#200
	BACK1:
		   MOV R1,#0FFH
	BACK:
		   DJNZ R1, BACK
		   DJNZ R5, BACK1
		   DJNZ R4, BACK2
		   DJNZ R3, BACK3
		   CLR PSW.4
		  pop 1
	   RET
;---------------------	
bin2ascii:
	MOV R2,53H
	MOV R0, 54H
	mov r1,55h
	START4:
	MOV A, @R0
	ANL A,#0F0H
	SWAP A
	LCALL CONVERT_TO_ASCII
	inc r1
	MOV A ,@R0
	ANL A,#0FH
	LCALL CONVERT_TO_ASCII
	inc r1
	inc r0
	DJNZ R2,START4
	RET
	
;----------------------	  
	CONVERT_TO_ASCII:
	    CLR C
		MOV R7,A
		SUBB A, #0AH
		JC NOT_A_ONWARDS;
			MOV A,R7
			ADD A,#37H
			MOV @R1,A
			RET
		
		NOT_A_ONWARDS:
			MOV A,R7
			ADD A,#30H
			MOV @R1,A
			RET
		
org 500h
	main:
	acall lcd_init
	mov tmod,#09h
	mov tcon,#11h
	mov th0,#00h
	mov tl0,#00h
	mov 50h,#00
	mov 51h,#00
	mov 52h,#00
	mov 53h,#3
	mov 54h,#50h
	mov 55h,#60h
	mov ie,#83h
	mov r4,#00h
	here: sjmp here
;------------------
my_string1:
DB   "  PULSE WIDTH  ", 00H
my_string2:
DB   "COUNT IS ", 00H	
;------------------	
	isr_it0:
	clr tr0
	mov 51h,th0
	mov 52h,tl0
	inc r4
	mov a, r4
	cjne a,#4, exit_isr
	mov a,#80h
	acall lcd_command
	mov   dptr,#my_string1  
	acall lcd_sendstring
	mov a,#0c0h
	acall lcd_command
	mov   dptr,#my_string2  
	acall lcd_sendstring
	lcall bin2ascii
	mov r0,#60h
	mov r2,#6
	loopd: mov a,@r0
	acall lcd_senddata
	inc r0
	dec r2
	jnz loopd
	mov a,#20h
	acall lcd_senddata
	mov r4,#0
	
	
	exit_isr:
	mov 50h,#00
	mov 51h,#00
	mov 52h,#00
	mov tl0,#00
	mov th0,#00
	setb tr0
	
	reti
;-------------------
	isr_t0:
	mov a,50h
	inc a
	mov 50h,a
	reti
;-----------------	

end