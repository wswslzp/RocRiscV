main:
    add t0, zero, 0x10
    add t1, zero, 0x11
.L0:
    blt t0, t1, .L1
    jalr zero, 0(x1)
.L1:
    sub t1, t1, t0
    jal zero, .L0
