a: EQU 0x1234587811223333
lui x6, (a & 0xffffffff) >> 12 
addi x6, x6, a & 0xfff
lui x7, (a >> 44 )+ 1
addi x7, x7, ( a >> 32 ) & 0xfff
slli x7, x7, 32
add x5, x6, x7
