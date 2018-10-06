;-----------------------------------------
; CodeName : 8 bit adder
; Author   : Bhishma Dedhia
;-----------------------------------------
org 0h
LJMP MAIN
org 100h
MAIN:
	mov 50H, #8FH
	mov 60H, #7FH
	mov A, 50H
	add A,60H
	mov 70H, A
	mov A,#0
	addc A,#0
	mov 71h, A
				
HERE:SJMP HERE
END		