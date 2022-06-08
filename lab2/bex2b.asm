DD 121, 33, -5, 242, -45, -12, 0
ld x7, 0(x6)
loop: ld x8, 8(x6)
beq x8, x0, end
blt x7, x8, skip
add x7, x8, x0
addi x9, x6, 8
skip: addi x6, x6,8
beq x0, x0, loop
end: ld x8, 0(x0)
sd x7, 0(x0)
sd x8, 0(x9)
