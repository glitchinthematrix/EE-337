;----------
;Saregamapa
;Bhishma Dedhia
;----------
org 0000h
	
ljmp main

org 001bh
ljmp isr_t1
	
;----------	
main:
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting sa
mov r1,#83h
mov r0,#84h
mov @r1,#10h
mov @r0,#47h

mov r2,#100
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting re
mov r1,#83h
mov r0,#84h
mov @r1,#0eh
mov @r0,#78h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-----------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting ga
mov r1,#83h
mov r0,#84h
mov @r1,#0dh
mov @r0,#05h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-----------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting ma
mov r1,#83h
mov r0,#84h
mov @r1,#0ch
mov @r0,#35h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting pa
mov r1,#83h
mov r0,#84h
mov @r1,#0ah
mov @r0,#0dah

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;---------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting dha
mov r1,#83h
mov r0,#84h
mov @r1,#09h
mov @r0,#0c4h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting ni
mov r1,#83h
mov r0,#84h
mov @r1,#08h
mov @r0,#0aeh

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;----------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting upper_sa
mov r1,#83h
mov r0,#84h
mov @r1,#08h
mov @r0,#23h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1

;----------------
;pause
mov 40h,#1
acall delay1
;--------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting upper_sa
mov r1,#83h
mov r0,#84h
mov @r1,#08h
mov @r0,#23h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;--------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting ni
mov r1,#83h
mov r0,#84h
mov @r1,#08h
mov @r0,#0aeh

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;----------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting dha
mov r1,#83h
mov r0,#84h
mov @r1,#09h
mov @r0,#0c4h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;--------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting pa
mov r1,#83h
mov r0,#84h
mov @r1,#0ah
mov @r0,#0dah

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-------------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting ma
mov r1,#83h
mov r0,#84h
mov @r1,#0ch
mov @r0,#35h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;---------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting ga
mov r1,#83h
mov r0,#84h
mov @r1,#0dh
mov @r0,#05h

mov r2,#100
acall load_timer
setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;---------------
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting re
mov r1,#83h
mov r0,#84h
mov @r1,#0eh
mov @r0,#78h
isr_t1:
dec r2
acall load_timer
reti
;-----------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting sa
mov r1,#83h
mov r0,#84h
mov @r1,#10h
mov @r0,#47h

mov r2,#100
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
here: sjmp here
;-------------

load_timer:
mov r1,#82h
clr c
clr a
subb a,@r1
mov tl1,a
clr a
mov r1,#81h
subb a,@r1
mov th1,a
ret
;------------
load_timer1:
mov r1,#84h
clr c
clr a
subb a,@r1
mov tl0,a
clr a
mov r1,#83h
subb a,@r1
mov th0,a
ret
;-----------
fgenerator:

clr p0.3
again:
acall load_timer1
setb tr0
loop: jnb tf0,loop
cpl p0.3
clr tr0
clr tf0
mov a,r2
cjne a,#0,again
ret
;-----------

DELAY1: 
	SETB PSW.5
		   MOV R3, 40H
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
	
	
	