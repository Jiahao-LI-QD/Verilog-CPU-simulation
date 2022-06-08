s1: DF 1.21, 5.85, -7.3, 23.1, -5.55
s2: DF 3.14, -2.1, 44.2, 11.0, -7.77

addi x6, x0, s2
addi x7, x0, 8
div x6, x6, x7
loop:
fld f0, s1(x5)
fld f1, s2(x5)
fmul.d f2, f1, f0
fadd.d f3, f2, f3
addi x5, x5, 8
blt x5, x6, loop
fsd f3,dst(x0)
ebreak x0, x0, 0
dst: DM 1