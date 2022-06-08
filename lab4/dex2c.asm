str1: DC "first statement\0"
str2: DC "second statement\0"

lui sp, 0x100000 >> 12
addi x30, x0, str1
addi x31, x0, str2

jal x1, lench
jal x1, appch
ecall x0, x30, 4
ebreak x0, x0, 0

lench:
sd x30, -8(sp)
loop1:
lb a0, 0(x30)
addi x30, x30, 1
beq a0, x0, end1
addi s0, s0, 1
beq x0, x0, loop1

end1:
ld x30, -8(sp)
sd s0, 8(sp)
jalr x0, 0(x1)

appch:
sd x1, 0(sp)
ld a0, 8(sp)
add a0, x30, a0
add a2, x31, x0
loop2:
lb a1, 0(a2)
beq a1, x0, end2
jal x1, appch1
beq x0, x0, loop2

appch1:
sb a1, 0(a0)
sb x0, 0(a2)
addi a0, a0, 1
addi a2, a0, 1
jalr x0, 0(x1)

end2:
ld x1, 0(sp)
jalr x0, 0(x1)