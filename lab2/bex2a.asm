DD -1, 55, -3, 7, 0
ld x7, 0(x6)
loop: ld x8, 8(x6)
beq x8, x0, end
bge x7, x8, skip
add x7, x8, x0
skip: addi x6, x6,8
beq x0, x0, loop
end: add x5, x7, x0
