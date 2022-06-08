addi sp, sp, 0
addi a0, x0, 5
addi t0, x0, 0; a=0
addi t1, x0, 1; b=1

add a2, t1, x0
add a1, t0, x0
jal x1, Fib
ecall x0, a1, 0
ebreak x0, x0, 0

Fib:
blt t0, a0, recu ; y!=0
jalr x0, 0(x1)

recu:
addi sp, sp, -8
sd x1, 0(sp)
addi a0, a0, -1
add a3, x0, a2
add a2, a1, a2
add a1, a3, x0
jal x1, Fib
ld x1, 0(sp)
addi sp, sp, 8
jalr x0, 0(x1)