s1: DC "Find all divisors.\0"
s2: DC "Enter i:"
s3: DC "Divisors:\0"

ld x29, s2(x0)
addi x30, x0, s1
addi x31, x0, s3

ecall x0, x30, 4
ecall x5, x29, 5
ecall x0, x31, 4
add x6, x0, x0
loop:
addi x6, x6, 1
rem x7, x5, x6
bne x7, x0, skip
ecall x0, x6, 0

skip: 
beq x6, x5, end
beq x0, x0, loop
end: 
ebreak x0, x0, 0