ORG 000h
	ljmp main
	
	org 100h
	main:
	mov r1,#00h
	mov r2,#00h
	
	repeat:	mov a,73h
	add a,51h
	mov 73h,a
	clr a
	addc a,#0
	mov 20h,a
	mov a,72h
	add a,52h
	mov 72h,a
	clr a
	addc a,#0
	mov 21h,a
	mov  a,72h
	add a,20h
	mov 72h,a
	clr a
	addc a,#0
	mov 22h,a
	mov a,71h
	add a,21h
	mov 71h,a
	clr a
	addc a,#0
	mov 23h,a
	mov a,71h
	add a,22h
	mov 71h,a
	clr a
	addc a,#0
	mov 24h,a
	mov a,70h
	add a,23h
	add a,24h
	mov 70h,a
		
	
	mov a,r1
	add a,#1
	mov r1,a
    clr a
	addc a,r2
	mov r2,a
	mov a,61h
	cjne a, 1,repeat
	mov a,60h
	cjne a,2,repeat
	here:sjmp here
	
	
	end
	

	