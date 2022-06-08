s1: DC "n! Enter n:"
s2: DC "!="

addi x30, x0, s1
ld x31, s2(x0)

ecall x30, x30, 4
ecall x5, x0, 5
add x7, x5, x0
add x6, x5, x0
loop:
addi x5, x5, -1
beq x5, x0, end
mul x6, x6, x5
beq x0, x0, loop
end:
ecall x7, x7, 0
ecall x31, x31, 3
ecall x0, x6, 0
ebreak x0, x0, 0