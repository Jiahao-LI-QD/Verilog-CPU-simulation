DD 1024, 2048, 4096, 8192
ld x5, 0(x0)
ld x6, 8(x0)
ld x7, 16(x0)
ld x8, 24(x0)
add x5, x5, x6
add x7, x8, x7
add x5, x5, x7
srli x5, x5, 2
sd x5, a(x0)
a: DM 1