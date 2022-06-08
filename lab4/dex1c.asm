exp: DC "12+34-*\0" ;(1+2)*(3-4)=-3
err: DC "Invaild operator!\0"
plus: DC "+"
minus: DC "-"
multiple: DC "*"
divide: DC "/"

ld x20, plus(x0)
ld x21, minus(x0)
ld x22, multiple(x0)
ld x23, divide(x0)
addi x25, x25, 0x30
addi x26, x26, 0x3a
addi x30, x30, err

lui sp, 0x100000 >> 12
addi x8, x8, 8
add x10, x10, sp
loop:
ld x5, 0(x31)
mul x6, x9, x8
sub x6, x0, x6
addi x6, x6, 56
sll x7, x5, x6
srli x7, x7, 56
addi x4, x4, 1
rem x9, x4, x8 
bne x9, x0, jump
addi x31, x31, 8
jump:
sd x7, 0(x10)
beq x7, x0, judge
addi x10, x10, -8
beq x0, x0, loop

load:
addi sp, sp, -8
ld x6, 0(sp)
addi sp, sp, -8
ld x7, 0(sp)

beq x5, x20, jia
beq x5, x21, jian
beq x5, x22, cheng
beq x5, x23, chu
ecall x0, x30, 4
ebreak x0, x0, 0

jia:
add x6, x7, x6
beq x0, x0, save

jian:
sub x6, x7, x6
beq x0, x0, save

cheng:
mul x6, x7, x6
beq x0, x0, save

chu:
div x6, x7, x6
beq x0, x0, save

save:
sd x6, 0(sp)
addi sp, sp, 8
sd x0, 0(sp)
addi x10, x10, -8
beq x0, x0, itr

judge:
add x10, sp, x0
addi sp, sp, 8

itr:
ld x5, 0(x10)
beq x5, x0, end
blt x5, x25, load
bge x5, x26, load
addi x5, x5, -0x30
sd x5, 0(sp)
addi x10, x10, -8
addi sp, sp, 8
beq x0, x0, itr

end: ebreak x0, x0, 0
