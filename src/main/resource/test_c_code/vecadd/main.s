	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.align	3
.LC1:
	.word	10
	.word	11
	.word	12
	.word	13
	.word	14
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	ld	a4,0(a5)
	sd	a4,-40(s0)
	ld	a4,8(a5)
	sd	a4,-32(s0)
	lw	a5,16(a5)
	sw	a5,-24(s0)
	lui	a5,%hi(.LC1)
	addi	a5,a5,%lo(.LC1)
	ld	a4,0(a5)
	sd	a4,-64(s0)
	ld	a4,8(a5)
	sd	a4,-56(s0)
	lw	a5,16(a5)
	sw	a5,-48(s0)
	addi	a2,s0,-88
	addi	a4,s0,-64
	addi	a5,s0,-40
	li	a3,5
	mv	a1,a4
	mv	a0,a5
	call	vecadd
	li	a5,0
	mv	a0,a5
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	main, .-main
	.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"
