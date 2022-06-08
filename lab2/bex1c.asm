a: DD 0xAAAABBBBCCCCDDDD
b: DD 0x4444333322221111
s: DM 8
ld x5, a(x0)
ld x6, b(x0)
add x7, x5, x6
sub x8, x5, x6
sub x9, x6, x5
and x10, x5, x6
or x11, x5, x6
xor x12, x5, x6
xori x13, x5, -1
xori x14, x6, -1
sd x7, s(x0)
sd x8, s+8(x0)
sd x9, s+16(x0)
sd x10, s+24(x0)
sd x11, s+32(x0)
sd x12, s+40(x0)
sd x13, s+48(x0)
sd x14, s+56(x0)