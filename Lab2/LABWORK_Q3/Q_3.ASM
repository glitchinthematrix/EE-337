;-------------
;Code: MEMORY COPY
;Author: Bhishma Dedhia
;-------------
ORG 0H
LJMP MAIN
ORG 50H
;memcpy:
;-------------

MAIN:
	MOV R2,50H
	MOV R0,52H
	MOV A,51H
	SUBB A,R0
	JC READ_BEFORE_WRITE
	LCALL SORT
	STOP:SJMP STOP
	READ_BEFORE_WRITE:
	LCALL SORT_BACKWARDS
	SJMP STOP
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
	START1:
		MOV A,@R0
		MOV @R1,A
		DEC R0
		DEC R1
		DJNZ R2, START1
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


END
	
	
	
	
	
	
	
		
		
		
		
	
		
	