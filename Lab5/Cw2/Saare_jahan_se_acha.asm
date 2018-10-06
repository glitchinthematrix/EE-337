;----------
;Sarejahanseacha
;Bhishma Dedhia
;----------
org 0000h
	
ljmp main

org 001bh
ljmp isr_t1
;-------------
main:
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;komal ga for 0.66
mov r1,#83h
mov r0,#84h
mov @r1,#0dh
mov @r0,#90h

mov r2,#66
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;--------------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting re for 0.66
mov r1,#83h
mov r0,#84h
mov @r1,#0eh
mov @r0,#78h

mov r2,#66
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;------------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting sa for 0.33
mov r1,#83h
mov r0,#84h
mov @r1,#10h
mov @r0,#47h

mov r2,#33
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-------------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting re for 0.66
mov r1,#83h
mov r0,#84h
mov @r1,#0eh
mov @r0,#78h

mov r2,#66
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-----------------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting lower_ni for 0.33
mov r1,#83h
mov r0,#84h
mov @r1,#11h
mov @r0,#5ch

mov r2,#33
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-------------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting Sa for 1
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
;--------------
;pausing for 0.33
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
mov r2,#33
acall load_timer
setb et1
setb ea
setb tr1
here1: mov a,r2
jnz here1
clr ea
clr tr1
;---------------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting lower_Pa for 0.33
mov r1,#83h
mov r0,#84h
mov @r1,#15h
mov @r0,#0b4h

mov r2,#33
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-----------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting lower_dha for 0.33
mov r1,#83h
mov r0,#84h
mov @r1,#13h
mov @r0,#88h

mov r2,#33
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;-----------
mov tmod, #11h
mov p1,#00h
mov r1,#81h
mov r0,#82h
mov @r1,#4eh
mov @r0,#20h
;setting lower_Pa for 0.33
mov r1,#83h
mov r0,#84h
mov @r1,#15h
mov @r0,#0b4h

mov r2,#33
acall load_timer

setb et1
setb ea
setb tr1
acall fgenerator
clr ea
clr tr1
;------------
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

mov r2,#66
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

mov r2,#33
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

mov r2,#66
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

mov r2,#33
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
;setting ga for 1
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
LJMP main
;------------
isr_t1:
dec r2
acall load_timer
reti
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
again: lcall delay
mov a,r2
cjne a,#0,again
ret
;-----------
delay:
lcall start_count
cpl p0.3
ret 
;-----------
start_count:
acall load_timer1
setb tr0
loop: jnb tf0,loop
clr tr0
clr tf0
ret
;-----------
end
	