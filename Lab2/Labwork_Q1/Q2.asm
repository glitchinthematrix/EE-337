;-------------
;Code: LED blink
;Author: Bhishma Dedhia
;-------------

;-------------
LED EQU P1.7

	ORG 00H
	LJMP MAIN
;-------------

	ORG 50H
		
DELAY: SETB PSW.5
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
	
;-------------
MAIN:
		MOV 4FH, #15
		MOV SP, #0CFH
LOOP:	
		SETB LED
		LCALL DELAY
		CLR LED
		LCALL DELAY
		SJMP LOOP
END		
	
