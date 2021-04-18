
t1.s.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
   0:	fd010113          	addi	x2,x2,-48
   4:	02813423          	sd	x8,40(x2)
   8:	03010413          	addi	x8,x2,48
   c:	02a00793          	addi	x15,x0,42
  10:	fcf43c23          	sd	x15,-40(x8)
  14:	01b00793          	addi	x15,x0,27
  18:	fef43023          	sd	x15,-32(x8)
  1c:	fd843703          	ld	x14,-40(x8)
  20:	fe043783          	ld	x15,-32(x8)
  24:	00f707b3          	add	x15,x14,x15
  28:	fef43423          	sd	x15,-24(x8)
  2c:	00000793          	addi	x15,x0,0
  30:	00078513          	addi	x10,x15,0
  34:	02813403          	ld	x8,40(x2)
  38:	03010113          	addi	x2,x2,48
  3c:	00008067          	jalr	x0,0(x1)
