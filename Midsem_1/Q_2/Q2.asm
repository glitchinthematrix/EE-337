led equ p1.7 
switch equ p1.3

;------
;name: Bhishma;
;LED toggle
;----
org 000h
ljmp main
org 30h
DELAY: SETB PSW.5
	   MOV R3, 4FH
BACK2:
	   MOV R5,#200
BACK1:
	   MOV R1,#0FFH
BACK:
	   DJNZ R1, BACK
	   DJNZ R5, BACK1
	   DJNZ R3, BACK2
	   CLR PSW.5
	   RET
	   
DELAY1: SETB PSW.5
	   MOV R3, #10
BACK4:
	   MOV R5,#100
BACK5:
	   MOV R1,#0FFH
BACK6:
	   DJNZ R1, BACK6
	   DJNZ R5, BACK5
	   DJNZ R3, BACK4
	   CLR PSW.5
	   RET
DELAY2: SETB PSW.5
	   MOV R3, #5
BACK8:
	   MOV R5,#50
BACK9:
	   MOV R1,#0FFH
BACK10:
	   DJNZ R1, BACK10
	   DJNZ R5, BACK9
	   DJNZ R3, BACK8
	   CLR PSW.5
	   RET
   
MAIN:	
		MOV 4FH, #80
		mov p1,#0ffh
LOOP:	mov c,switch
		clr a
		addc a,#0
		mov 20h,a
		LCALL delay
		cpl led
		mov c,switch
		clr a
		addc a,#0
		xrl a,20h
		cjne a,#00,halve_period
		sjmp loop
special_case:
		mov c,switch
		clr a
		addc a,#0
		mov 20h,a
		lcall delay1
		cpl led
		mov c,switch
		clr a
		addc a,#0
		xrl a,20h
		cjne a,#00,main
		sjmp special_case

		
halve_period:
		mov b, #2
		mov a,4fh
		div ab
		mov 4fh,a
		cjne a,#5,loop
		sjmp special_case
END		