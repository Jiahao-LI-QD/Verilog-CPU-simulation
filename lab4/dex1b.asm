s1: DC "Input a string:\0"
s2: DC "not palindrome.\0"
s3: DC "palindrome\0"
STACK: EQU 0x100000
lui sp, STACK >> 12
addi x31, x0, s1
addi x8, x8, 8
ecall x0, x31, 4
ecall sp, x0, 9

add x4, sp, x0
add x7, x7, sp
addi x30, sp, -8
loop1:
rem x6, x5, x8
ld x9, 0(x7)
addi x5, x5, 1
mul x6, x6, x8
sub x6, x0, x6
addi x6, x6, 56
sll x9, x9, x6
srli x9, x9, 56
beq x9, x0, over
addi sp, sp, -8
sd x9, 0(sp)
bne x6, x0, jump
addi x7, x7, 8
jump:
beq x0, x0, loop1

over: 
ld x11, 0(sp)
ld x12, 0(x30)
bne x11, x12, np
bge sp, x30, p
addi sp, sp, 8
addi x30, x30,-8
beq x0, x0, over

np:
addi x29, x0, s2
ecall x0, x29, 4
beq x0, x0, end

p:
addi x29, x0, s3
ecall x0, x29, 4
end: ebreak x0, x0, 0



