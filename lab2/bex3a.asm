s1: DC "What is your name?\0"
c1: DC "Hello "
c2: DC "!"

addi x30, x0, s1
ecall x0, x30, 4
addi x5, x0, dst
ecall x5, x0, 9

addi x31, x0, c1
ecall x31, x31,4
ecall x5, x5, 4

addi x6, x0, c2
ecall x0, x6, 4
ebreak x0,x0,0
dst: DM 1
