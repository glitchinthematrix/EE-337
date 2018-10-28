;-----------
;Name: Bhishma Dedhia
;Program: COunting
;----------

org 000h5
	ljmp main
	;-------------
	check_ones_and_zeros:
	mov r5,#00
	mov r4,#00
	clr c
	orl c,00h
	jc go_to_one
	inc r5 
	sjmp next
	go_to_one: inc r4
	next:clr c
	orl c,01h
	jc go_to_one1
	inc r5 
	sjmp next1
	go_to_one1: inc r4
	next1:clr c
	orl c,02h
	jc go_to_one2
	inc r5 
	sjmp next2
	go_to_one2: inc r4
    next2:clr c
	orl c,03h
	jc go_to_one3
	inc r5 
	sjmp next3
	go_to_one3: inc r4
	next3:clr c
	orl c,04h
	jc go_to_one4
	inc r5 
	sjmp next4
	go_to_one4: inc r4
	next4:clr c
	orl c,05h
	jc go_to_one5
	inc r5 
	sjmp next5
	go_to_one5: inc r4
	next5:clr c
	orl c,06h
	jc go_to_one6
	inc r5 
	sjmp next6
	go_to_one6: inc r4
	next6:clr c
	orl c,07h
	jc go_to_one7
	inc r5
    sjmp next7
	go_to_one7: inc r4
	next7:ret
	;------------
	main:
	mov 60h,#00
	mov 61h,#00
	mov r0,#50h
	mov r2,#5
	repeat:mov 20h,@r0
	lcall check_ones_and_zeros;
	mov a,r4
	add a,60h
	mov 60h,a
	mov a,r5
	add a,61h
	mov 61h,a
	inc r0
	djnz r2,repeat
	here:sjmp here
	
	end
	
	