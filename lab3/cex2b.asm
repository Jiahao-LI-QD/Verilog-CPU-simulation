s1: DF 1.0
s2: DC "n:"
ld x7, s2(x0)
fld f1, s1(x0)
fld f0, s1(x0)
ecall x6, x7, 5
fadd.d f3, f3, f0
loop:
addi x5, x5, 1
blt x6, x5, end
fadd.d f2, f0, f2
fdiv.d f3, f3, f2
fadd.d f1, f3, f1
beq x0, x0, loop
end:
ecall x0, f1, 1