;-----------------------------------------
; CodeName : Array sorter
; Author   : Bhishma Dedhia
;-----------------------------------------

org 0h
LJMP MAIN
org 100h
MAIN:
	MOV 60H,#0FAH
	MOV 61H,#06H
	MOV 62H,#05H
	MOV 63H,#03H
	MOV 64H,#00H
	
	MOV R5,#05
	MOV R0,#60H
	MOV R1,#70H
	HERE:
	MOV A,@R0
	MOV @R1,A
	INC R0
	INC R1
	DJNZ R5 ,HERE
	   MOV R2,#05H
	   DEC R2
LOOP2:	
     	MOV R0,#70H
       MOV R3,#04H
LOOP1:	MOV A ,@R0
		INC R0
		MOV R5,A
		CLR C
		SUBB A,@R0
		JC SKIP
    MOV A,R5
	XCH A,@R0
	DEC R0
	MOV @R0,A
	INC R0
	SKIP: DJNZ R3, LOOP1
	      DJNZ R2,LOOP2
   STOP: SJMP STOP
	
END
	
	
	
	
	
	
	
e