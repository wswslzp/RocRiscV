
main:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
   0:	01000293          	addi	x5,x0,16
   4:	01100313          	addi	x6,x0,17

0000000000000008 <.L0>:
   8:	0062c463          	blt	x5,x6,10 <.L1>
   c:	00008067          	jalr	x0,0(x1)

0000000000000010 <.L1>:
  10:	40530333          	sub	x6,x6,x5
  14:	ff5ff06f          	jal	x0,8 <.L0>
