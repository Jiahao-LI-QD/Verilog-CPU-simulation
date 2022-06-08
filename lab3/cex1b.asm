s1: DC "sum(1..n-1) Enter n:"
s2: DC "sum(1.."
s3: DC ")="
s4: DC "(n*(n-1))/2="

addi x30, x0, s1
addi x28, x0, s2
addi x29, x0, s3
addi x31, x0, s4

ecall x30, x30, 4
ecall x5, x0, 5
add x7, x5, x0
loop:
addi x5, x5, -1
beq x5, x0, end
add x6, x6, x5
beq x0, x0, loop
end:
ecall x28, x28, 4
ecall x7, x7, 0
ecall x29, x29, 4
ecall x0, x6, 0

addi x8, x7, -1
addi x9, x0, 2
mul x8, x8, x7
div x8, x8, x9
ecall x1, x31, 4
ecall x0, x8, 0