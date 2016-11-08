.data
.global main
main:

mov r10,#0
add r10,r10,#1
	cmp r10,#1
	bleq MBIen
	beq start


start:
mov r0,#0
loop:
bl getchar
cmp r0,#0
beq loop
