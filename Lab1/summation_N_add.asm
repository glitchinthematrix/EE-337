;-----------------------------------------
; CodeName : Summation n numbers
; Author   : Bhishma Dedhia
;-----------------------------------------
org 0h
LJMP main
org 100h
	main:
	MOV 50H, #03
	MOV A,50H;number to be stored
	MOV R2,#0
	MOV R0,#50H;adrress to be stored
	MOV R1,#0;
	LJMP process
	
    process:
	MOV R3,A
	MOV A, R1
	INC R2
	ADD A, R2
	INC R0
	MOV @R0 , A
	MOV R1, A
	MOV A, R3
	DEC A
	JNZ process
	HERE:SJMP HERE
END	
	
	
	
	