ORG 00h
LJMP MAIN


load_timer:
mov r1,82h
clr c
clr a
subb a,@r1
mov tl0,a
clr a
mov r1,81h
subb a,@r1
mov th0,a


MAIN:
lcall load_timer

end