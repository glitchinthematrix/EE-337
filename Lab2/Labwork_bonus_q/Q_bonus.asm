LED EQU P1
ORG 00H
LJMP MAIN
ORG 100H
MAIN:
	MOV SP,#0CFH;-----------------------Initialize STACK POINTER
	MOV 50H,#8;------------------------No of memory locations of Array A
	MOV 51H,#58H;------------------------Array A start location
	LCALL zeroOut;----------------------Clear memory
	MOV 50H,#8;------------------------No of memory locations of Array B
	MOV 51H,#70H;------------------------Array B start location
	LCALL zeroOut;----------------------Clear memory
	MOV 50H,#4;------------------------No of memory locations of source array
	MOV 51H,#53H;------------------------Source array start location
	MOV 52H,#58H;------------------------Destination array(A) start location
	LCALL bin2ascii;--------------------Write at memory location
	MOV 50H,#8;------------------------No of elements of Array A to be copied in Array B
	MOV 51H,#58H;------------------------Array A start location
	MOV 52H,#70H;------------------------Array B start location
	LCALL memcpy;-----------------------Copy block of memory to other location
	MOV 50H,#8;------------------------No of memory locations of Array B
	MOV 51H,#70H;------------------------Array B start location
	MOV 4FH,#2;------------------------User defined delay value
	LCALL display;----------------------Display the last four bits of elements on LEDs
	here:SJMP here;---------------------WHILE loop(Infinite Loop)
;----------------------------
display:
		MOV R2,50H
		MOV R0,51H
	START1:
		MOV A,@R0
		ANL A,#0F0H
		MOV LED,A
		LCALL DELAY
		INC R0
		DJNZ R2,START1
	STOP: SJMP STOP
	DELAY:
		SETB PSW.5
		MOV R3, 4FH
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
		RET
;---------------------------
zeroOut:
	SETB PSW.5
	MOV R0,51H
	MOV R2,50H
	START:
	MOV @R0,#0H
	INC R0
	DJNZ R2 ,START
	CLR PSW.5
	RET
;-----------------
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
memcpy:
	MOV R2,50H
	MOV R0,52H
	MOV A,51H
	SUBB A,R0
	JC READ_BEFORE_WRITE
	LCALL SORT
	STOPm:ret
	READ_BEFORE_WRITE:
	LCALL SORT_BACKWARDS
	SJMP STOPm
;------------------	
	SORT_BACKWARDS:
		MOV A,51H
		ADD A, R2
		MOV R0,A
		DEC R0
		MOV A,52H
		ADD A,R2
		MOV R1,A
		DEC R1
		STARTm:
			MOV A,@R0
			MOV @R1,A
			DEC R0
			DEC R1
			DJNZ R2, STARTm
		RET
;------------------	
	SORT:
		MOV R0,51H
		MOV R1,52H
		START2:
			MOV A,@R0
			MOV @R1,A
			INC R0
			INC R1
			DJNZ R2, START2
			RET
;-----------------	 


	

end		   