;-------------
;Code: zeroOut
;Author: Bhishma Dedhia
;-------------

zeroOut:
SETB PSW.5
MOV R0,#51H
MOV R2,50H
START:
MOV @R0,#0H
INC R0
DJNZ R2 START
CLR PSW.5
RET