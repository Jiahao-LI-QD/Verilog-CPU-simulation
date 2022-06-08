F1: DF 1.0, 2.0
s2: DC "Iteration:\0"
s1: DC "a:"

fld f30, F1(x0)
fld f31, F1+8(x0)
ld x30, s1(x0)
addi x31, x0, s2
ecall f0, x30, 6
ecall x1, x31, 4
ecall x4, x0, 5

flt.d x1, f0, f30
bne x1, x0, less

fadd.d f2, f30, f10
fadd.d f3, f0, f10

loop:
addi x5, x5, 1
fadd.d f1, f2, f3
fdiv.d f1, f1, f31
fmul.d f4, f1, f1
beq x4, x5, end
flt.d x2, f0, f4 
beq x2, x0, mhigh
fadd.d f3, f1, f10
beq x0, x0, loop
mhigh:
fadd.d f2, f1, f10
beq x0, x0, loop

less:
fadd.d f2, f0, f10
fadd.d f3, f30, f10
beq x0, x0, loop

end:
ecall x0, f1, 1
