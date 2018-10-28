;-----------------------------------------
; CodeName :signed number Array sorter
; Author   : Bhishma Dedhia
;-----------------------------------------

org 000h
LJMP MAIN
;------------
compare_signed_number:
	clr c
	mov A,@r0
	cpl a
	inc a
	cjne a,#80h,next
	dec a
	next:mov 70h,a
	add a,r6
	MOV 20H,A
	CLR C;
	CLR A;
	ORL C,PSW.2;
	ADDC A ,#0H;
	JNZ OVERFLOW
	NOT_OVERFLOW:
	CLR C;
	ORL C,07H;
	LJMP exit
	OVERFLOW:
	MOV A,r6;
	ADDC A ,70h ;
	exit: 
	ret




;------------
org 100h
MAIN:
	  MOV R2,#06H
	  DEC R2
LOOP2:	
     	MOV R0,#50H
       MOV R3,#05H
LOOP1:	MOV 6,@R0
		MOV 5,@r0
		INC R0
		lcall compare_signed_number
		JC SKIP
    MOV A,R5
	XCH A,@R0
	DEC R0
	MOV @R0,A
	INC R0
	SKIP: DJNZ R3, LOOP1
	      DJNZ R2,LOOP2
   STOP: SJMP STOP
   
 ;----------- 
 
 
 c16_bit_subtractor:
 
 
END
	
	
