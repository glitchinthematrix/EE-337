org 0000h
	
ljmp main

org 000bh	
ljmp isr_t0

main:
mov tmod, #01h
mov r1,#83h
mov r0,#84h
mov @r1,#4eh
mov @r0,#20h
mov r2,#100
clr p1.7
setb et0
setb ea
setb tr0
here:sjmp here


isr_t0:
dec r2
acall load_timer0
mov a,r2
cjne a,#0,cont
cpl p1.7
mov r2,#100
cont:
reti
;-----------
load_timer0:
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
































end