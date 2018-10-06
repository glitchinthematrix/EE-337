org 00h
ljmp main

load_timer:
mov r1,#82h
clr c
clr a
subb a,@r1
mov tl0,a
clr a
mov r1,#81h
subb a,@r1
mov th0,a
ret

start_count:
acall load_timer
setb tr0
loop: jnb tf0,loop
clr tr0
clr tf0
ret


delay:

mov r2,#100
repeat:lcall start_count
		djnz r2,repeat
cpl p1.7
ret 

main:
mov p1,#00h
clr p1.7
mov r1,#81h
mov @r1,#4eh
mov r1,#82h
mov @r1,#20h
mov TMOD ,#01H
again: lcall delay
sjmp again

end