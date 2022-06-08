dir: DC "John"
DC "11111"
DC "Nick"
DC "22222"
DC "Sara"
DC "11111"
DC "Nick"
DC "33333"
DD 0

s1: DC "Please enter:"
c: DC " "
addi x11, x0, c
addi x6, x0, 0x39
addi x12, x0, 0x2f
addi x30, x0, s1
addi x31, x0, s1 - 8
loop:
ecall x0, x30, 4
ecall x5, x0, 8
add x7, x5, x0
slli x5, x5, 56
srli x5, x5, 56
if: blt x6, x5, name
if2: blt x12, x5, phone

name:
addi x8, x0, 0

loop1: 
ld x9, 0(x8)
bne x7, x9, jump1
addi x10, x8, 8
ecall x1, x8, 4
ecall x1, x11, 4
ecall x0, x10, 4
jump1:
addi x8, x8, 16
bne x8, x31, loop1
beq x0, x0, loop

phone:
addi x8, x0, 8

loop2: 
ld x9, 0(x8)
bne x7, x9, jump2
addi x10, x8, -8
ecall x1, x10, 4
ecall x1, x11, 4
ecall x0, x8, 4
jump2:
addi x8, x8, 16
bge x31, x8,loop2
beq x0,x0,loop
