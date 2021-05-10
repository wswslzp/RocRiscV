	.file	"gemm.c"
	.option nopic
	.attribute arch, "rv64i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	__muldi3
	.align	2
	.globl	GEneralMatrixMul
	.type	GEneralMatrixMul, @function
GEneralMatrixMul:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	sd	s1,72(sp)
	addi	s0,sp,96
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	mv	a2,a3
	mv	a3,a4
	mv	a4,a5
	mv	a5,a2
	sw	a5,-76(s0)
	mv	a5,a3
	sw	a5,-80(s0)
	mv	a5,a4
	sw	a5,-84(s0)
	sw	zero,-36(s0)
	j	.L2
.L7:
	sw	zero,-40(s0)
	j	.L3
.L6:
	lw	a5,-36(s0)
	slli	a5,a5,3
	ld	a4,-72(s0)
	add	a5,a4,a5
	ld	a4,0(a5)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	zero,0(a5)
	sw	zero,-44(s0)
	j	.L4
.L5:
	lw	a5,-36(s0)
	slli	a5,a5,3
	ld	a4,-72(s0)
	add	a5,a4,a5
	ld	a4,0(a5)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	s1,0(a5)
	lw	a5,-36(s0)
	slli	a5,a5,3
	ld	a4,-56(s0)
	add	a5,a4,a5
	ld	a4,0(a5)
	lw	a5,-44(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a3,0(a5)
	lw	a5,-44(s0)
	slli	a5,a5,3
	ld	a4,-64(s0)
	add	a5,a4,a5
	ld	a4,0(a5)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	mv	a0,a3
	call	__muldi3
	mv	a5,a0
	sext.w	a4,a5
	lw	a5,-36(s0)
	slli	a5,a5,3
	ld	a3,-72(s0)
	add	a5,a3,a5
	ld	a3,0(a5)
	lw	a5,-40(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	addw	a4,s1,a4
	sext.w	a4,a4
	sw	a4,0(a5)
	lw	a5,-44(s0)
	addiw	a5,a5,1
	sw	a5,-44(s0)
.L4:
	lw	a4,-44(s0)
	lw	a5,-76(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L5
	lw	a5,-40(s0)
	addiw	a5,a5,1
	sw	a5,-40(s0)
.L3:
	lw	a4,-40(s0)
	lw	a5,-84(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L6
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L2:
	lw	a4,-36(s0)
	lw	a5,-76(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L7
	nop
	mv	a0,a5
	ld	ra,88(sp)
	ld	s0,80(sp)
	ld	s1,72(sp)
	addi	sp,sp,96
	jr	ra
	.size	GEneralMatrixMul, .-GEneralMatrixMul
	.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"
