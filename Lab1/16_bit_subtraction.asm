;-----------------------------------------
; CodeName : 16 bit subtraction
; Author   : Bhishma Dedhia
;-----------------------------------------
org 0h
LJMP MAIN
org 100h
MAIN:
	MOV 60H,#0ffH
	MOV 61H,#0FFH
	MOV 70H,#0FCH
	MOV 71H,#0DEH  
	MOV A,71H;
	CPL A;
	MOV R2,A;
	INC R2;
	MOV A ,61H;
	ADD A, R2;
	MOV 64H,A;
	MOV A ,70H;
	CPL A;
	MOV R2,A;
	MOV A,60H;
	ADDC A , R2;
	MOV 63H,A
	MOV 20H,A
	CLR C;
	CLR A;
	ORL C,PSW.2;
	ADDC A ,#0H;
	JNZ OVERFLOW
	NOT_OVERFLOW:
	CLR C;
	ORL C,07H;
	CLR A;
	ADDC A,#0H;
	MOV 62H,A;
	LJMP HERE
	OVERFLOW:
	MOV A,60H;
	ADDC A , R2;
	CLR A;
	ADDC A,#0H;
	MOV 62H,A;
	HERE:
	SJMP HERE
END	
	
	
	
	
	