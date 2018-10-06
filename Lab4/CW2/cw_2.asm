; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

org 0000h
	ljmp main
org 200h
;---------------------------------------------------------------------------	
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
;----------------------lcd delay routine-----------------------------------------------------
delay:	 push 0
	 push 1
         mov r0,#1
loop2:	 mov r1,#255
	 loopa:	 djnz r1, loopa
	 djnz r0, loop2
	 pop 1
	 pop 0 
	 ret
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

;--------------------------	
	DELAY1: 
	push 1
	push 3
	SETB PSW.5
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
		   CLR PSW.5
		   pop 3
		  pop 1
	   RET 
;---------------------------
bin2ascii:
	MOV R2,50H
	START4:
	MOV R0, 51H
	MOV A, @R0
	ANL A,#0F0H
	SWAP A
	LCALL CONVERT_TO_ASCII
	LCALL INCREMENT_POINTER_WRITE
	MOV A ,@R0
	ANL A,#0FH
	LCALL CONVERT_TO_ASCII
	LCALL INCREMENT_POINTER_WRITE
	LCALL INCREMENT_POINTER_READ
	DJNZ R2,START4
	RET
	
;----------------------	  
	CONVERT_TO_ASCII:
	    CLR C
		MOV R3,A
		SUBB A, #0AH
		JC NOT_A_ONWARDS;
			MOV A,R3
			ADD A,#37H
			MOV R1,52H
			MOV @R1,A
			RET
		
		NOT_A_ONWARDS:
			MOV A,R3
			ADD A,#30H
			MOV R1,52H
			MOV @R1,A
			RET
		
;-----------------------	
	 INCREMENT_POINTER_WRITE:
		MOV A,52H
		INC A
		MOV 52H,A
		RET
;-----------------------
	 INCREMENT_POINTER_READ:
			MOV A,51H
			INC A
			MOV 51H,A
			RET
;-----------------------------------------------
clear_lcd:
		mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
;-------------------------------------------------------------------------------------------	
	checkinput:
	mov p1,#0fh
	mov a,p1
	mov r3,a
	lcall delay1
	mov p1,#0fh
	mov a,p1
	cjne a,3h,checkinput
	swap a
	anl a,#0f0h
	mov r1,a
	ret 
;----------------------------	
	printout:
	mov 51h,r1
	mov 50h,#16
	mov 52h,#10h
	lcall bin2ascii
	mov r0,#10h
	mov r2,#4
	mov a,#80h;Put cursor on first row,0 column
	acall lcd_command	 
	repeat: mov a,@r0
			lcall lcd_senddata
			acall delay;
			inc r0
			mov a,@r0
			lcall lcd_senddata
			acall delay;
			mov a,#20h
			acall lcd_senddata
			inc r0
			djnz r2,repeat
	mov r2,#4
	mov a,#0C0h		  ;Put cursor on second row,3 column
	acall lcd_command
	repeat1: mov a,@r0
			lcall lcd_senddata
			acall delay;
			inc r0
			mov a,@r0
			lcall lcd_senddata
			acall delay;
			mov a,#20h
			acall lcd_senddata
			inc r0
			djnz r2,repeat1 
  
	mov 40h,#10
	acall delay1
	acall clear_lcd
	mov a,#80h;Put cursor on first row,0 column
	acall lcd_command	
	mov r2,#4
	repeat2: mov a,@r0
			lcall lcd_senddata
			acall delay;
			inc r0
			mov a,@r0
			lcall lcd_senddata
			acall delay;
			mov a,#20h
			acall lcd_senddata
			inc r0
			djnz r2,repeat2
	mov r2,#4
	mov a,#0C0h		  ;Put cursor on second row,3 column
	acall lcd_command
	repeat3: mov a,@r0
			lcall lcd_senddata
			acall delay;
			inc r0
			mov a,@r0
			lcall lcd_senddata
			acall delay;
			mov a,#20h
			acall lcd_senddata
			inc r0
			djnz r2,repeat3 
	acall delay1
	acall clear_lcd
			
	ret

;---------------------------
	main:
	acall lcd_init
	mov 40h,#4
	mov 70h,#10h
	mov 71h,#11h
	mov 72h,#12h
	mov 73h,#13h
	mov 74h,#14h
	mov 75h,#15h
	mov 76h,#16h
	mov 77h,#17h
	mov 78h,#18h
	mov 79h,#19h
	mov 7ah,#1ah
	mov 7bh,#1bh
	mov 7ch,#1ch
	mov 7dh,#1dh
	mov 7eh,#1eh
	mov 7fh,#1fh

repeat4:lcall checkinput
	lcall printout
	sjmp repeat4
	end	
	