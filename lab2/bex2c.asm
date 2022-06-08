vec1: DD 1, 5, -7, 23, -5
vec2: DD 3, -2, 4, 11, -7
addi x10,x10,5
loop:ld x7, vec1(x6)
     ld x8, vec2(x6)
add x9, x7, x8
sd x9, dst(x6)
addi x6,x6,8
addi x5, x5, 1
bne x5, x10, loop
ebreak x0,x0,0
dst: DM 5

