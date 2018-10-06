;-------------
;Code: Show the nibble
;Author: Bhishma Dedhia
;-------------
LED EQU P1

;DISPLAY:
ORG 00H
;----------
LJMP MAIN
ORG 50H
MAIN:
	MOV R2, #4H
	MOV 51H,#10H
	MOV 52H,#20H
	MOV 53H,#30H
	MOV 54H,#40H
	MOV 4FH, #2
	MOV SP, #0CFH
	MOV R2,50H
	MOV R0,#51H
START1:
	MOV A,@R0
	ANL A,#0F0H
	MOV LED,A
	LCALL DELAY
	INC R0
	DJNZ R2,START1
STOP: SJMP STOP
;-----------
DELAY:
	SETB PSW.4
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
		   

end