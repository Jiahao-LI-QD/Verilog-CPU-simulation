s1: DC "Input a decimal number:\0"

STACK: EQU 100000
lui sp, STACK >> 12
addi x31, x0, s1
addi x7, x0, 1
addi x8, x0, 2

ecall x0, x31, 4
ecall x5, x0, 5
loop1:
addi x9, x9, 1
rem x6, x5, x8
div x5, x5, x8
beq x6, x0, jump
sd x7, 0(sp)
jump:
addi sp, sp, -8
bne x5, x0, loop1

loop2:
addi x9, x9, -1
addi sp, sp, 8
ld x5, 0(sp)
ecall x1, x5, 0
bne x9, x0, loop2
