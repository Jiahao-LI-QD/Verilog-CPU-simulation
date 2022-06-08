ORG 0x1000000
DC "sampled test\0"

ORG 0x700
str1: DC "The order start:\0"
str2: DC "The number to delete\0?"
str3: DC "String insert\0?"

ORG 0x0
lui a7, 0x1000000>>12
STACK: EQU 0x100000 ;stack
lui sp, STACK>>12
addi x29, x0, str1
addi x30, x0, str2
addi x31, x0, str3

ecall x0, x29, 4
ecall x6, x0, 5
addi x6, x6, -1

ecall x0, x30, 4
ecall x7, x0, 5

addi a0, sp, 0x800
ecall x0, x31, 4
ecall a0, x0, 9

jal x1, insch
jal x1, delch

ecall x0, a7, 4
ebreak x0, x0, 0

insch:
add a2, a7, x6
sd x1, 0(sp)
sd a2, -8(sp)
loop1:
lb a1, 0(a0)
beq a1, x0, end1
jal x1, insch1
ld a2, -8(sp)
addi a2, a2, 1
addi a0, a0, 1
beq x0, x0, loop1

end1:
ld x1, 0(sp)
jalr x0, 0(x1)

insch1:
lb a3, 0(a2)
sb a1, 0(a2)
addi a2, a2, 1
add a1, x0, a3
bne a1, x0, insch1
sb a1, 0(a2)
jalr x0, 0(x1)

delch:
add a2, a7, x6
sd x1, 0(sp)
sd a2, -8(sp)
loop2:
jal x1, delch1
beq x5, x7, end2
addi x5, x5, 1
ld a2, -8(sp)
beq x0, x0, loop2

end2:
ld x1, 0(sp)
jalr x0, 0(x1)

delch1:
lb a1, 1(a2)
sb a1, 0(a2)
addi a2, a2, 1
bne a1, x0, delch1
jalr x0, 0(x1)