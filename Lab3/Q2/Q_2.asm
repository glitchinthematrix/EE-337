;------
;Author: Bhishma Dedhia
;Name: Binary to gray and gray to binary
;-----
STATUS EQU P1.3
POS3 EQU P1.2
POS2 EQU P1.1
POS1 EQU P1.0
LED1 EQU P1.4
LED2 EQU P1.5
LED3 EQU P1.6
;-----	
ORG 00H
LJMP MAIN
;-------------
ORG 50H
	GRAY2BINARY:
		MOV C,POS3
		MOV LED3,C
		CLR A
		ADDC A,#0
		MOV 20H,A
		MOV C,POS2
		CLR A
		ADDC A,#0
		XRL A,20H
		MOV 20H,A
		MOV C,00H
		MOV LED2,C
		CLR A
		ADDC A,#0
		MOV 20H,A
		MOV C,POS1
		CLR A
		ADDC A,#0
		XRL A,20H
		MOV 20H,A
		MOV C,00H
		MOV LED1,C
		RET
;-------------
	BINARY2GRAY:
		MOV C,POS3
		MOV LED3,C
		CLR A
		ADDC A,#0
		MOV 20H,A
		MOV C,POS2
		CLR A
		ADDC A,#0
		XRL A,20H
		MOV 20H,A
		MOV C ,00H
		MOV LED2,C
		CLR A
		MOV C,POS1
		CLR A
		ADDC A,#0
		MOV 40H,A
		MOV C,POS2
		CLR A
		ADDC A,#0
		XRL A,40H
		MOV 20H,A
		MOV C ,00H
		MOV LED1,C
		RET
;-------------

	MAIN:
		;SETB P1.3
		;SETB P1.2
		;SETB P1.1
		;SETB P1.0
		CLR P1.7
		JNB STATUS,B2G
		LCALL GRAY2BINARY
		SJMP MAIN
		B2G:
		LCALL BINARY2GRAY
		SJMP MAIN
	
	END