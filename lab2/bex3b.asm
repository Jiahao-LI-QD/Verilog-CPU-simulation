s1: DC "Please input an integer:\0"
s2: DC "Please input an address:(in Hex)\0"
s3: DC "The address that you input \0"
s4: DC "is not a memory address."
s5: DC "belongs to compile code."
addi x5, x0, s1
addi x6, x0, s2
addi x7, x0, s3
addi x10, x0, s4
addi x11, x0, s5
loop: 
ecall x0, x5, 4
ecall x30, x0, 5
ecall x0, x6, 4
ecall x31, x0, 5
add x8, x31, x0
slli x8, x8, 61
srli x8, x8, 61
bne x8, x0, jump2
addi x9, x9, end+4
blt x31, x9, jump1
sd x30, 0(x31)
beq x0, x0, loop


jump1:
ecall x7, x7, 4
ecall x0, x11, 4
beq x0, x0, loop


jump2:
ecall x7, x7, 4
ecall x0, x10, 4
end:beq x0, x0, loop