; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

ORG 0000H
	ljmp MAIN

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

;---------------------------------------------------------------------------------------------
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
;--------
	READIP:
	MOV A,P1
	ANL A,#0FH
	MOV @R1,A
	SWAP A
	ORL A,#0FH
	MOV P1,A	
	RET
;---------------	
PACKNIBBLE:
	MOV A,4EH
	SWAP A
	ADD A,4FH
	MOV @R0,A
	RET
;--------------
	READNIBBLE:
	PUSH 1
	MOV R1,54H
	MOV 40H,#10
	MOV P1,#0FFH
	LCALL DELAY1
	MOV P1,#0FH
	MOV 40H,#2
	LCALL DELAY1
	LCALL READIP
	MOV 40H,#10
	LCALL DELAY1
	;MOV P1,#0FH
	MOV A,P1
	ANL A,#0FH
	CJNE A,#0FH,READNIBBLE
	POP 1
	RET
;--------------------------------------------------------------------------------------
	readValues:
	mov r0,51h
	mov r2,50h
loopd:MOV 54H,#4EH
      LCALL READNIBBLE
      MOV 54H,#4FH
	 LCALL READNIBBLE
	 LCALL PACKNIBBLE
	 inc r0
	 djnz r2 ,loopd
	 mov r2,50h
	 mov r0, 51h
	 ret
;-------------------------------------------------------------------------------------------
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
;-------------------------------------------------------------------------------------------
display_data:
	mov p1,#0fh
	mov r2,p1
	mov r0,51h
	inc r2
	mov a,#80h		 ;Put cursor on first row,0 column
	acall lcd_command	 
	again:mov a,@r0
	inc r0
	inc r0
	djnz r2, again
	lcall lcd_senddata
	acall delay;
	dec r0
	mov a,@r0
	lcall lcd_senddata
	lcall delay1
	mov   LCD_data,#01H  ;Clear LCD
    clr   LCD_rs         ;Selected command register
    clr   LCD_rw         ;We are writing in instruction register
    setb  LCD_en         ;Enable H->L
	acall delay
    clr   LCD_en
	lcall delay1
	ret
;------------------------------------------------------------------	
main:
	mov P2,#00h
    mov P1,#00h
	mov 51h,#60h
	mov 50h,#1
	lcall readValues
	mov 40h,#4
	mov 50h,#1
	mov 51h,#60h
	mov 52h,#63h
	lcall bin2ascii
	mov 51h,#63h
	mov 50h,#1
	restart:mov p1,#0fh
	mov a,p1
	anl p1,#0fh
	clr c 
	subb a,50h
	jz reset_lcd
	jnc reset_lcd
	lcall display_data
	sjmp restart
	reset_lcd:
	lcall lcd_init
	acall delay
	sjmp restart

	
end

