;-----------------------------------------
; CodeName : 16 bit addition
; Author   : Bhishma Dedhia
;-----------------------------------------
org 0h
LJMP MAIN
org 100h
MAIN:
	MOV 60H,#36H
	MOV 61H,#78H
	MOV 70H,#3AH
	MOV 71H,#79H 
	MOV A,61H;LSB of the first
	ADD A,71H;Adding LSB of one with the other
	MOV 64H ,A;
	CLR A; Clearing accumulator
	MOV A,60H;MSB of the first
	ADDC A,70H;Adding the MSB together
	MOV 63H,A;
	MOV 20H, A;MSB1
	CLR C;
	ORL C,07H;
	CLR A;
	ADDC A,#0H;
	MOV 62H,A;
    HERE:SJMP HERE
END	
	
	
	
	