s1: DF 1.0
s2: DC "n:"
ld x7, s2(x0)
fld f1, s1(x0)
fld f0, s1(x0)
ecall x6, x7, 5
addi x10, x10, 1
loop:
addi x5, x5, 1
add x8, x0, x5
addi x9, x8, -1
inloop:
beq x9, x0, out
mul x8, x9, x8
addi x9, x9,-1
bne x9, x0, inloop
out:
fcvt.d.l f2, x8
fdiv.d f3, f1, f2
fadd.d f0, f0, f3
bne x5, x6, loop
ecall x0, f0, 1