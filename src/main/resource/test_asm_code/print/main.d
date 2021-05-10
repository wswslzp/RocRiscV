
main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	1f850513          	addi	x10,x10,504 # 102b4 <__libc_fini_array>
   100c4:	1a80006f          	jal	x0,1026c <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	e0418193          	addi	x3,x3,-508 # 11ed0 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11e30 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11e68 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	2c0000ef          	jal	x1,103a4 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	1cc50513          	addi	x10,x10,460 # 102b4 <__libc_fini_array>
   100f0:	17c000ef          	jal	x1,1026c <atexit>
   100f4:	21c000ef          	jal	x1,10310 <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	1780006f          	jal	x0,10280 <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11e30 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	58c50513          	addi	x10,x10,1420 # 116b0 <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11e30 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11e30 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11e38 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	54450513          	addi	x10,x10,1348 # 116b0 <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00113c23          	sd	x1,24(x2)
   10188:	00813823          	sd	x8,16(x2)
   1018c:	02010413          	addi	x8,x2,32
   10190:	000107b7          	lui	x15,0x10
   10194:	6a078793          	addi	x15,x15,1696 # 106a0 <__errno+0xc>
   10198:	fef43423          	sd	x15,-24(x8)
   1019c:	00000593          	addi	x11,x0,0
   101a0:	fe843503          	ld	x10,-24(x8)
   101a4:	058000ef          	jal	x1,101fc <printChars>
   101a8:	00000793          	addi	x15,x0,0
   101ac:	00078513          	addi	x10,x15,0
   101b0:	01813083          	ld	x1,24(x2)
   101b4:	01013403          	ld	x8,16(x2)
   101b8:	02010113          	addi	x2,x2,32
   101bc:	00008067          	jalr	x0,0(x1)

00000000000101c0 <printOneChar>:
   101c0:	fe010113          	addi	x2,x2,-32
   101c4:	00813c23          	sd	x8,24(x2)
   101c8:	02010413          	addi	x8,x2,32
   101cc:	00050793          	addi	x15,x10,0
   101d0:	00058713          	addi	x14,x11,0
   101d4:	fef407a3          	sb	x15,-17(x8)
   101d8:	00070793          	addi	x15,x14,0
   101dc:	fef42423          	sw	x15,-24(x8)
   101e0:	fef44783          	lbu	x15,-17(x8)
   101e4:	fe842703          	lw	x14,-24(x8)
   101e8:	10f70823          	sb	x15,272(x14)
   101ec:	00000013          	addi	x0,x0,0
   101f0:	01813403          	ld	x8,24(x2)
   101f4:	02010113          	addi	x2,x2,32
   101f8:	00008067          	jalr	x0,0(x1)

00000000000101fc <printChars>:
   101fc:	fd010113          	addi	x2,x2,-48
   10200:	02813423          	sd	x8,40(x2)
   10204:	03010413          	addi	x8,x2,48
   10208:	fca43c23          	sd	x10,-40(x8)
   1020c:	00058793          	addi	x15,x11,0
   10210:	fcf42a23          	sw	x15,-44(x8)
   10214:	00100313          	addi	x6,x0,1
   10218:	106008a3          	sb	x6,273(x0) # 111 <register_fini-0xff9f>
   1021c:	fe042623          	sw	x0,-20(x8)
   10220:	0280006f          	jal	x0,10248 <printChars+0x4c>
   10224:	fec42783          	lw	x15,-20(x8)
   10228:	fd843703          	ld	x14,-40(x8)
   1022c:	00f707b3          	add	x15,x14,x15
   10230:	0007c783          	lbu	x15,0(x15)
   10234:	fd442703          	lw	x14,-44(x8)
   10238:	10f70823          	sb	x15,272(x14)
   1023c:	fec42783          	lw	x15,-20(x8)
   10240:	0017879b          	addiw	x15,x15,1
   10244:	fef42623          	sw	x15,-20(x8)
   10248:	fec42783          	lw	x15,-20(x8)
   1024c:	fd843703          	ld	x14,-40(x8)
   10250:	00f707b3          	add	x15,x14,x15
   10254:	0007c783          	lbu	x15,0(x15)
   10258:	fc0796e3          	bne	x15,x0,10224 <printChars+0x28>
   1025c:	00000013          	addi	x0,x0,0
   10260:	02813403          	ld	x8,40(x2)
   10264:	03010113          	addi	x2,x2,48
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <atexit>:
   1026c:	00050593          	addi	x11,x10,0
   10270:	00000693          	addi	x13,x0,0
   10274:	00000613          	addi	x12,x0,0
   10278:	00000513          	addi	x10,x0,0
   1027c:	2040006f          	jal	x0,10480 <__register_exitproc>

0000000000010280 <exit>:
   10280:	ff010113          	addi	x2,x2,-16
   10284:	00000593          	addi	x11,x0,0
   10288:	00813023          	sd	x8,0(x2)
   1028c:	00113423          	sd	x1,8(x2)
   10290:	00050413          	addi	x8,x10,0
   10294:	298000ef          	jal	x1,1052c <__call_exitprocs>
   10298:	f4818793          	addi	x15,x3,-184 # 11e18 <_global_impure_ptr>
   1029c:	0007b503          	ld	x10,0(x15)
   102a0:	05853783          	ld	x15,88(x10)
   102a4:	00078463          	beq	x15,x0,102ac <exit+0x2c>
   102a8:	000780e7          	jalr	x1,0(x15)
   102ac:	00040513          	addi	x10,x8,0
   102b0:	3a0000ef          	jal	x1,10650 <_exit>

00000000000102b4 <__libc_fini_array>:
   102b4:	fe010113          	addi	x2,x2,-32
   102b8:	00813823          	sd	x8,16(x2)
   102bc:	00001797          	auipc	x15,0x1
   102c0:	41478793          	addi	x15,x15,1044 # 116d0 <__fini_array_end>
   102c4:	00001417          	auipc	x8,0x1
   102c8:	40440413          	addi	x8,x8,1028 # 116c8 <__init_array_end>
   102cc:	408787b3          	sub	x15,x15,x8
   102d0:	00913423          	sd	x9,8(x2)
   102d4:	00113c23          	sd	x1,24(x2)
   102d8:	4037d493          	srai	x9,x15,0x3
   102dc:	02048063          	beq	x9,x0,102fc <__libc_fini_array+0x48>
   102e0:	ff878793          	addi	x15,x15,-8
   102e4:	00878433          	add	x8,x15,x8
   102e8:	00043783          	ld	x15,0(x8)
   102ec:	fff48493          	addi	x9,x9,-1
   102f0:	ff840413          	addi	x8,x8,-8
   102f4:	000780e7          	jalr	x1,0(x15)
   102f8:	fe0498e3          	bne	x9,x0,102e8 <__libc_fini_array+0x34>
   102fc:	01813083          	ld	x1,24(x2)
   10300:	01013403          	ld	x8,16(x2)
   10304:	00813483          	ld	x9,8(x2)
   10308:	02010113          	addi	x2,x2,32
   1030c:	00008067          	jalr	x0,0(x1)

0000000000010310 <__libc_init_array>:
   10310:	fe010113          	addi	x2,x2,-32
   10314:	00813823          	sd	x8,16(x2)
   10318:	01213023          	sd	x18,0(x2)
   1031c:	00001417          	auipc	x8,0x1
   10320:	39840413          	addi	x8,x8,920 # 116b4 <__preinit_array_end>
   10324:	00001917          	auipc	x18,0x1
   10328:	39090913          	addi	x18,x18,912 # 116b4 <__preinit_array_end>
   1032c:	40890933          	sub	x18,x18,x8
   10330:	00113c23          	sd	x1,24(x2)
   10334:	00913423          	sd	x9,8(x2)
   10338:	40395913          	srai	x18,x18,0x3
   1033c:	00090e63          	beq	x18,x0,10358 <__libc_init_array+0x48>
   10340:	00000493          	addi	x9,x0,0
   10344:	00043783          	ld	x15,0(x8)
   10348:	00148493          	addi	x9,x9,1
   1034c:	00840413          	addi	x8,x8,8
   10350:	000780e7          	jalr	x1,0(x15)
   10354:	fe9918e3          	bne	x18,x9,10344 <__libc_init_array+0x34>
   10358:	00001417          	auipc	x8,0x1
   1035c:	36040413          	addi	x8,x8,864 # 116b8 <__init_array_start>
   10360:	00001917          	auipc	x18,0x1
   10364:	36890913          	addi	x18,x18,872 # 116c8 <__init_array_end>
   10368:	40890933          	sub	x18,x18,x8
   1036c:	40395913          	srai	x18,x18,0x3
   10370:	00090e63          	beq	x18,x0,1038c <__libc_init_array+0x7c>
   10374:	00000493          	addi	x9,x0,0
   10378:	00043783          	ld	x15,0(x8)
   1037c:	00148493          	addi	x9,x9,1
   10380:	00840413          	addi	x8,x8,8
   10384:	000780e7          	jalr	x1,0(x15)
   10388:	fe9918e3          	bne	x18,x9,10378 <__libc_init_array+0x68>
   1038c:	01813083          	ld	x1,24(x2)
   10390:	01013403          	ld	x8,16(x2)
   10394:	00813483          	ld	x9,8(x2)
   10398:	00013903          	ld	x18,0(x2)
   1039c:	02010113          	addi	x2,x2,32
   103a0:	00008067          	jalr	x0,0(x1)

00000000000103a4 <memset>:
   103a4:	00f00313          	addi	x6,x0,15
   103a8:	00050713          	addi	x14,x10,0
   103ac:	02c37a63          	bgeu	x6,x12,103e0 <memset+0x3c>
   103b0:	00f77793          	andi	x15,x14,15
   103b4:	0a079063          	bne	x15,x0,10454 <memset+0xb0>
   103b8:	06059e63          	bne	x11,x0,10434 <memset+0x90>
   103bc:	ff067693          	andi	x13,x12,-16
   103c0:	00f67613          	andi	x12,x12,15
   103c4:	00e686b3          	add	x13,x13,x14
   103c8:	00b73023          	sd	x11,0(x14)
   103cc:	00b73423          	sd	x11,8(x14)
   103d0:	01070713          	addi	x14,x14,16
   103d4:	fed76ae3          	bltu	x14,x13,103c8 <memset+0x24>
   103d8:	00061463          	bne	x12,x0,103e0 <memset+0x3c>
   103dc:	00008067          	jalr	x0,0(x1)
   103e0:	40c306b3          	sub	x13,x6,x12
   103e4:	00269693          	slli	x13,x13,0x2
   103e8:	00000297          	auipc	x5,0x0
   103ec:	005686b3          	add	x13,x13,x5
   103f0:	00c68067          	jalr	x0,12(x13)
   103f4:	00b70723          	sb	x11,14(x14)
   103f8:	00b706a3          	sb	x11,13(x14)
   103fc:	00b70623          	sb	x11,12(x14)
   10400:	00b705a3          	sb	x11,11(x14)
   10404:	00b70523          	sb	x11,10(x14)
   10408:	00b704a3          	sb	x11,9(x14)
   1040c:	00b70423          	sb	x11,8(x14)
   10410:	00b703a3          	sb	x11,7(x14)
   10414:	00b70323          	sb	x11,6(x14)
   10418:	00b702a3          	sb	x11,5(x14)
   1041c:	00b70223          	sb	x11,4(x14)
   10420:	00b701a3          	sb	x11,3(x14)
   10424:	00b70123          	sb	x11,2(x14)
   10428:	00b700a3          	sb	x11,1(x14)
   1042c:	00b70023          	sb	x11,0(x14)
   10430:	00008067          	jalr	x0,0(x1)
   10434:	0ff5f593          	andi	x11,x11,255
   10438:	00859693          	slli	x13,x11,0x8
   1043c:	00d5e5b3          	or	x11,x11,x13
   10440:	01059693          	slli	x13,x11,0x10
   10444:	00d5e5b3          	or	x11,x11,x13
   10448:	02059693          	slli	x13,x11,0x20
   1044c:	00d5e5b3          	or	x11,x11,x13
   10450:	f6dff06f          	jal	x0,103bc <memset+0x18>
   10454:	00279693          	slli	x13,x15,0x2
   10458:	00000297          	auipc	x5,0x0
   1045c:	005686b3          	add	x13,x13,x5
   10460:	00008293          	addi	x5,x1,0
   10464:	f98680e7          	jalr	x1,-104(x13)
   10468:	00028093          	addi	x1,x5,0 # 10458 <memset+0xb4>
   1046c:	ff078793          	addi	x15,x15,-16
   10470:	40f70733          	sub	x14,x14,x15
   10474:	00f60633          	add	x12,x12,x15
   10478:	f6c374e3          	bgeu	x6,x12,103e0 <memset+0x3c>
   1047c:	f3dff06f          	jal	x0,103b8 <memset+0x14>

0000000000010480 <__register_exitproc>:
   10480:	f4818793          	addi	x15,x3,-184 # 11e18 <_global_impure_ptr>
   10484:	0007b703          	ld	x14,0(x15)
   10488:	1f873783          	ld	x15,504(x14)
   1048c:	06078063          	beq	x15,x0,104ec <__register_exitproc+0x6c>
   10490:	0087a703          	lw	x14,8(x15)
   10494:	01f00813          	addi	x16,x0,31
   10498:	08e84663          	blt	x16,x14,10524 <__register_exitproc+0xa4>
   1049c:	02050863          	beq	x10,x0,104cc <__register_exitproc+0x4c>
   104a0:	00371813          	slli	x16,x14,0x3
   104a4:	01078833          	add	x16,x15,x16
   104a8:	10c83823          	sd	x12,272(x16)
   104ac:	3107a883          	lw	x17,784(x15)
   104b0:	00100613          	addi	x12,x0,1
   104b4:	00e6163b          	sllw	x12,x12,x14
   104b8:	00c8e8b3          	or	x17,x17,x12
   104bc:	3117a823          	sw	x17,784(x15)
   104c0:	20d83823          	sd	x13,528(x16)
   104c4:	00200693          	addi	x13,x0,2
   104c8:	02d50863          	beq	x10,x13,104f8 <__register_exitproc+0x78>
   104cc:	00270693          	addi	x13,x14,2
   104d0:	00369693          	slli	x13,x13,0x3
   104d4:	0017071b          	addiw	x14,x14,1
   104d8:	00e7a423          	sw	x14,8(x15)
   104dc:	00d787b3          	add	x15,x15,x13
   104e0:	00b7b023          	sd	x11,0(x15)
   104e4:	00000513          	addi	x10,x0,0
   104e8:	00008067          	jalr	x0,0(x1)
   104ec:	20070793          	addi	x15,x14,512
   104f0:	1ef73c23          	sd	x15,504(x14)
   104f4:	f9dff06f          	jal	x0,10490 <__register_exitproc+0x10>
   104f8:	3147a683          	lw	x13,788(x15)
   104fc:	00000513          	addi	x10,x0,0
   10500:	00c6e633          	or	x12,x13,x12
   10504:	00270693          	addi	x13,x14,2
   10508:	00369693          	slli	x13,x13,0x3
   1050c:	0017071b          	addiw	x14,x14,1
   10510:	30c7aa23          	sw	x12,788(x15)
   10514:	00e7a423          	sw	x14,8(x15)
   10518:	00d787b3          	add	x15,x15,x13
   1051c:	00b7b023          	sd	x11,0(x15)
   10520:	00008067          	jalr	x0,0(x1)
   10524:	fff00513          	addi	x10,x0,-1
   10528:	00008067          	jalr	x0,0(x1)

000000000001052c <__call_exitprocs>:
   1052c:	fb010113          	addi	x2,x2,-80
   10530:	f4818793          	addi	x15,x3,-184 # 11e18 <_global_impure_ptr>
   10534:	01813023          	sd	x24,0(x2)
   10538:	0007bc03          	ld	x24,0(x15)
   1053c:	03313423          	sd	x19,40(x2)
   10540:	03413023          	sd	x20,32(x2)
   10544:	01513c23          	sd	x21,24(x2)
   10548:	01613823          	sd	x22,16(x2)
   1054c:	04113423          	sd	x1,72(x2)
   10550:	04813023          	sd	x8,64(x2)
   10554:	02913c23          	sd	x9,56(x2)
   10558:	03213823          	sd	x18,48(x2)
   1055c:	01713423          	sd	x23,8(x2)
   10560:	00050a93          	addi	x21,x10,0
   10564:	00058b13          	addi	x22,x11,0
   10568:	00100a13          	addi	x20,x0,1
   1056c:	fff00993          	addi	x19,x0,-1
   10570:	1f8c3903          	ld	x18,504(x24)
   10574:	02090863          	beq	x18,x0,105a4 <__call_exitprocs+0x78>
   10578:	00892483          	lw	x9,8(x18)
   1057c:	fff4841b          	addiw	x8,x9,-1
   10580:	02044263          	blt	x8,x0,105a4 <__call_exitprocs+0x78>
   10584:	00349493          	slli	x9,x9,0x3
   10588:	009904b3          	add	x9,x18,x9
   1058c:	040b0463          	beq	x22,x0,105d4 <__call_exitprocs+0xa8>
   10590:	2084b783          	ld	x15,520(x9)
   10594:	05678063          	beq	x15,x22,105d4 <__call_exitprocs+0xa8>
   10598:	fff4041b          	addiw	x8,x8,-1
   1059c:	ff848493          	addi	x9,x9,-8
   105a0:	ff3416e3          	bne	x8,x19,1058c <__call_exitprocs+0x60>
   105a4:	04813083          	ld	x1,72(x2)
   105a8:	04013403          	ld	x8,64(x2)
   105ac:	03813483          	ld	x9,56(x2)
   105b0:	03013903          	ld	x18,48(x2)
   105b4:	02813983          	ld	x19,40(x2)
   105b8:	02013a03          	ld	x20,32(x2)
   105bc:	01813a83          	ld	x21,24(x2)
   105c0:	01013b03          	ld	x22,16(x2)
   105c4:	00813b83          	ld	x23,8(x2)
   105c8:	00013c03          	ld	x24,0(x2)
   105cc:	05010113          	addi	x2,x2,80
   105d0:	00008067          	jalr	x0,0(x1)
   105d4:	00892783          	lw	x15,8(x18)
   105d8:	0084b703          	ld	x14,8(x9)
   105dc:	fff7879b          	addiw	x15,x15,-1
   105e0:	04878e63          	beq	x15,x8,1063c <__call_exitprocs+0x110>
   105e4:	0004b423          	sd	x0,8(x9)
   105e8:	fa0708e3          	beq	x14,x0,10598 <__call_exitprocs+0x6c>
   105ec:	31092783          	lw	x15,784(x18)
   105f0:	008a16bb          	sllw	x13,x20,x8
   105f4:	00892b83          	lw	x23,8(x18)
   105f8:	00d7f7b3          	and	x15,x15,x13
   105fc:	0007879b          	addiw	x15,x15,0
   10600:	00079e63          	bne	x15,x0,1061c <__call_exitprocs+0xf0>
   10604:	000700e7          	jalr	x1,0(x14)
   10608:	00892783          	lw	x15,8(x18)
   1060c:	f77792e3          	bne	x15,x23,10570 <__call_exitprocs+0x44>
   10610:	1f8c3783          	ld	x15,504(x24)
   10614:	f92782e3          	beq	x15,x18,10598 <__call_exitprocs+0x6c>
   10618:	f59ff06f          	jal	x0,10570 <__call_exitprocs+0x44>
   1061c:	31492783          	lw	x15,788(x18)
   10620:	1084b583          	ld	x11,264(x9)
   10624:	00d7f7b3          	and	x15,x15,x13
   10628:	0007879b          	addiw	x15,x15,0
   1062c:	00079c63          	bne	x15,x0,10644 <__call_exitprocs+0x118>
   10630:	000a8513          	addi	x10,x21,0
   10634:	000700e7          	jalr	x1,0(x14)
   10638:	fd1ff06f          	jal	x0,10608 <__call_exitprocs+0xdc>
   1063c:	00892423          	sw	x8,8(x18)
   10640:	fa9ff06f          	jal	x0,105e8 <__call_exitprocs+0xbc>
   10644:	00058513          	addi	x10,x11,0
   10648:	000700e7          	jalr	x1,0(x14)
   1064c:	fbdff06f          	jal	x0,10608 <__call_exitprocs+0xdc>

0000000000010650 <_exit>:
   10650:	00000593          	addi	x11,x0,0
   10654:	00000613          	addi	x12,x0,0
   10658:	00000693          	addi	x13,x0,0
   1065c:	00000713          	addi	x14,x0,0
   10660:	00000793          	addi	x15,x0,0
   10664:	05d00893          	addi	x17,x0,93
   10668:	00000073          	ecall
   1066c:	00054463          	blt	x10,x0,10674 <_exit+0x24>
   10670:	0000006f          	jal	x0,10670 <_exit+0x20>
   10674:	ff010113          	addi	x2,x2,-16
   10678:	00813023          	sd	x8,0(x2)
   1067c:	00050413          	addi	x8,x10,0
   10680:	00113423          	sd	x1,8(x2)
   10684:	4080043b          	subw	x8,x0,x8
   10688:	00c000ef          	jal	x1,10694 <__errno>
   1068c:	00852023          	sw	x8,0(x10)
   10690:	0000006f          	jal	x0,10690 <_exit+0x40>

0000000000010694 <__errno>:
   10694:	f5818793          	addi	x15,x3,-168 # 11e28 <_impure_ptr>
   10698:	0007b503          	ld	x10,0(x15)
   1069c:	00008067          	jalr	x0,0(x1)
