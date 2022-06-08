addi sp, sp, 0
addi a1, x0, 8
addi a2, x0, 15
jal x1, gcd
ecall x0, a1, 0
ebreak x0, x0, 0

gcd:
bne a2, x0, recu ; y!=0
jalr x0, 0(x1)

recu:
sd x1, -8(sp)
addi sp, sp, -8
rem a0, a1, a2
add a1, x0, a2 
add a2, x0, a0
jal x1, gcd
ld x1, 0(sp)
addi sp, sp,8
jalr x0, 0(x1)