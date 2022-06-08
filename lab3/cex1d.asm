s1: DC "Find all divisors.\0"
s2: DC "Enter i:\0"
s3: DC "Divisors\0"
s4: DC ":prime\0"
s5: DC ":not prime\0"

ld x29, s2(x0)
addi x30, x0, s1
addi x31, x0, s3
addi x27, x0, s4
addi x28, x0, s5
addi x12, x0, 2

ecall x0, x30, 4
ecall x5, x29, 5
ecall x0, x31, 4
add x6, x0, x0
add x8, x0, x0

loop:
addi x6, x6, 1
addi x9, x0, 2
div x11, x6, x9
rem x7, x5, x6
bne x7, x0, skip
sd x6, dst(x8)
addi x8, x8, 8
ecall x1, x6, 0

jump:
rem x10, x6, x9
beq x6, x12, two
beq x10, x0, np
two:
addi x9, x9, 1
blt x9, x11,jump
ecall x0, x27, 4
beq x6, x5, end
beq x0, x0, loop

np:
ecall x0, x28, 4
beq x6, x5, end
beq x0, x0, loop

skip: 
beq x6, x5, end
beq x0, x0, loop
end: 
ebreak x0, x0, 0
dst: DM 1