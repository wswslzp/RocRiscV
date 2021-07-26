
main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e63          	bne	x11,x0,10390 <memset+0x90>
   10318:	ff067693          	andi	x13,x12,-16
   1031c:	00f67613          	andi	x12,x12,15
   10320:	00e686b3          	add	x13,x13,x14
   10324:	00b73023          	sd	x11,0(x14)
   10328:	00b73423          	sd	x11,8(x14)
   1032c:	01070713          	addi	x14,x14,16
   10330:	fed76ae3          	bltu	x14,x13,10324 <memset+0x24>
   10334:	00061463          	bne	x12,x0,1033c <memset+0x3c>
   10338:	00008067          	jalr	x0,0(x1)
   1033c:	40c306b3          	sub	x13,x6,x12
   10340:	00269693          	slli	x13,x13,0x2
   10344:	00000297          	auipc	x5,0x0
   10348:	005686b3          	add	x13,x13,x5
   1034c:	00c68067          	jalr	x0,12(x13)
   10350:	00b70723          	sb	x11,14(x14)
   10354:	00b706a3          	sb	x11,13(x14)
   10358:	00b70623          	sb	x11,12(x14)
   1035c:	00b705a3          	sb	x11,11(x14)
   10360:	00b70523          	sb	x11,10(x14)
   10364:	00b704a3          	sb	x11,9(x14)
   10368:	00b70423          	sb	x11,8(x14)
   1036c:	00b703a3          	sb	x11,7(x14)
   10370:	00b70323          	sb	x11,6(x14)
   10374:	00b702a3          	sb	x11,5(x14)
   10378:	00b70223          	sb	x11,4(x14)
   1037c:	00b701a3          	sb	x11,3(x14)
   10380:	00b70123          	sb	x11,2(x14)
   10384:	00b700a3          	sb	x11,1(x14)
   10388:	00b70023          	sb	x11,0(x14)
   1038c:	00008067          	jalr	x0,0(x1)
   10390:	0ff5f593          	andi	x11,x11,255
   10394:	00859693          	slli	x13,x11,0x8
   10398:	00d5e5b3          	or	x11,x11,x13
   1039c:	01059693          	slli	x13,x11,0x10
   103a0:	00d5e5b3          	or	x11,x11,x13
   103a4:	02059693          	slli	x13,x11,0x20
   103a8:	00d5e5b3          	or	x11,x11,x13
   103ac:	f6dff06f          	jal	x0,10318 <memset+0x18>
   103b0:	00279693          	slli	x13,x15,0x2
   103b4:	00000297          	auipc	x5,0x0
   103b8:	005686b3          	add	x13,x13,x5
   103bc:	00008293          	addi	x5,x1,0
   103c0:	f98680e7          	jalr	x1,-104(x13)
   103c4:	00028093          	addi	x1,x5,0 # 103b4 <memset+0xb4>
   103c8:	ff078793          	addi	x15,x15,-16
   103cc:	40f70733          	sub	x14,x14,x15
   103d0:	00f60633          	add	x12,x12,x15
   103d4:	f6c374e3          	bgeu	x6,x12,1033c <memset+0x3c>
   103d8:	f3dff06f          	jal	x0,10314 <memset+0x14>

00000000000103dc <__register_exitproc>:
   103dc:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   103e0:	0007b703          	ld	x14,0(x15)
   103e4:	1f873783          	ld	x15,504(x14)
   103e8:	06078063          	beq	x15,x0,10448 <__register_exitproc+0x6c>
   103ec:	0087a703          	lw	x14,8(x15)
   103f0:	01f00813          	addi	x16,x0,31
   103f4:	08e84663          	blt	x16,x14,10480 <__register_exitproc+0xa4>
   103f8:	02050863          	beq	x10,x0,10428 <__register_exitproc+0x4c>
   103fc:	00371813          	slli	x16,x14,0x3
   10400:	01078833          	add	x16,x15,x16
   10404:	10c83823          	sd	x12,272(x16)
   10408:	3107a883          	lw	x17,784(x15)
   1040c:	00100613          	addi	x12,x0,1
   10410:	00e6163b          	sllw	x12,x12,x14
   10414:	00c8e8b3          	or	x17,x17,x12
   10418:	3117a823          	sw	x17,784(x15)
   1041c:	20d83823          	sd	x13,528(x16)
   10420:	00200693          	addi	x13,x0,2
   10424:	02d50863          	beq	x10,x13,10454 <__register_exitproc+0x78>
   10428:	00270693          	addi	x13,x14,2
   1042c:	00369693          	slli	x13,x13,0x3
   10430:	0017071b          	addiw	x14,x14,1
   10434:	00e7a423          	sw	x14,8(x15)
   10438:	00d787b3          	add	x15,x15,x13
   1043c:	00b7b023          	sd	x11,0(x15)
   10440:	00000513          	addi	x10,x0,0
   10444:	00008067          	jalr	x0,0(x1)
   10448:	20070793          	addi	x15,x14,512
   1044c:	1ef73c23          	sd	x15,504(x14)
   10450:	f9dff06f          	jal	x0,103ec <__register_exitproc+0x10>
   10454:	3147a683          	lw	x13,788(x15)
   10458:	00000513          	addi	x10,x0,0
   1045c:	00c6e633          	or	x12,x13,x12
   10460:	00270693          	addi	x13,x14,2
   10464:	00369693          	slli	x13,x13,0x3
   10468:	0017071b          	addiw	x14,x14,1
   1046c:	30c7aa23          	sw	x12,788(x15)
   10470:	00e7a423          	sw	x14,8(x15)
   10474:	00d787b3          	add	x15,x15,x13
   10478:	00b7b023          	sd	x11,0(x15)
   1047c:	00008067          	jalr	x0,0(x1)
   10480:	fff00513          	addi	x10,x0,-1
   10484:	00008067          	jalr	x0,0(x1)

0000000000010488 <__call_exitprocs>:
   10488:	fb010113          	addi	x2,x2,-80
   1048c:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   10490:	01813023          	sd	x24,0(x2)
   10494:	0007bc03          	ld	x24,0(x15)
   10498:	03313423          	sd	x19,40(x2)
   1049c:	03413023          	sd	x20,32(x2)
   104a0:	01513c23          	sd	x21,24(x2)
   104a4:	01613823          	sd	x22,16(x2)
   104a8:	04113423          	sd	x1,72(x2)
   104ac:	04813023          	sd	x8,64(x2)
   104b0:	02913c23          	sd	x9,56(x2)
   104b4:	03213823          	sd	x18,48(x2)
   104b8:	01713423          	sd	x23,8(x2)
   104bc:	00050a93          	addi	x21,x10,0
   104c0:	00058b13          	addi	x22,x11,0
   104c4:	00100a13          	addi	x20,x0,1
   104c8:	fff00993          	addi	x19,x0,-1
   104cc:	1f8c3903          	ld	x18,504(x24)
   104d0:	02090863          	beq	x18,x0,10500 <__call_exitprocs+0x78>
   104d4:	00892483          	lw	x9,8(x18)
   104d8:	fff4841b          	addiw	x8,x9,-1
   104dc:	02044263          	blt	x8,x0,10500 <__call_exitprocs+0x78>
   104e0:	00349493          	slli	x9,x9,0x3
   104e4:	009904b3          	add	x9,x18,x9
   104e8:	040b0463          	beq	x22,x0,10530 <__call_exitprocs+0xa8>
   104ec:	2084b783          	ld	x15,520(x9)
   104f0:	05678063          	beq	x15,x22,10530 <__call_exitprocs+0xa8>
   104f4:	fff4041b          	addiw	x8,x8,-1
   104f8:	ff848493          	addi	x9,x9,-8
   104fc:	ff3416e3          	bne	x8,x19,104e8 <__call_exitprocs+0x60>
   10500:	04813083          	ld	x1,72(x2)
   10504:	04013403          	ld	x8,64(x2)
   10508:	03813483          	ld	x9,56(x2)
   1050c:	03013903          	ld	x18,48(x2)
   10510:	02813983          	ld	x19,40(x2)
   10514:	02013a03          	ld	x20,32(x2)
   10518:	01813a83          	ld	x21,24(x2)
   1051c:	01013b03          	ld	x22,16(x2)
   10520:	00813b83          	ld	x23,8(x2)
   10524:	00013c03          	ld	x24,0(x2)
   10528:	05010113          	addi	x2,x2,80
   1052c:	00008067          	jalr	x0,0(x1)
   10530:	00892783          	lw	x15,8(x18)
   10534:	0084b703          	ld	x14,8(x9)
   10538:	fff7879b          	addiw	x15,x15,-1
   1053c:	04878e63          	beq	x15,x8,10598 <__call_exitprocs+0x110>
   10540:	0004b423          	sd	x0,8(x9)
   10544:	fa0708e3          	beq	x14,x0,104f4 <__call_exitprocs+0x6c>
   10548:	31092783          	lw	x15,784(x18)
   1054c:	008a16bb          	sllw	x13,x20,x8
   10550:	00892b83          	lw	x23,8(x18)
   10554:	00d7f7b3          	and	x15,x15,x13
   10558:	0007879b          	addiw	x15,x15,0
   1055c:	00079e63          	bne	x15,x0,10578 <__call_exitprocs+0xf0>
   10560:	000700e7          	jalr	x1,0(x14)
   10564:	00892783          	lw	x15,8(x18)
   10568:	f77792e3          	bne	x15,x23,104cc <__call_exitprocs+0x44>
   1056c:	1f8c3783          	ld	x15,504(x24)
   10570:	f92782e3          	beq	x15,x18,104f4 <__call_exitprocs+0x6c>
   10574:	f59ff06f          	jal	x0,104cc <__call_exitprocs+0x44>
   10578:	31492783          	lw	x15,788(x18)
   1057c:	1084b583          	ld	x11,264(x9)
   10580:	00d7f7b3          	and	x15,x15,x13
   10584:	0007879b          	addiw	x15,x15,0
   10588:	00079c63          	bne	x15,x0,105a0 <__call_exitprocs+0x118>
   1058c:	000a8513          	addi	x10,x21,0
   10590:	000700e7          	jalr	x1,0(x14)
   10594:	fd1ff06f          	jal	x0,10564 <__call_exitprocs+0xdc>
   10598:	00892423          	sw	x8,8(x18)
   1059c:	fa9ff06f          	jal	x0,10544 <__call_exitprocs+0xbc>
   105a0:	00058513          	addi	x10,x11,0
   105a4:	000700e7          	jalr	x1,0(x14)
   105a8:	fbdff06f          	jal	x0,10564 <__call_exitprocs+0xdc>

00000000000105ac <_exit>:
   105ac:	00000593          	addi	x11,x0,0
   105b0:	00000613          	addi	x12,x0,0
   105b4:	00000693          	addi	x13,x0,0
   105b8:	00000713          	addi	x14,x0,0
   105bc:	00000793          	addi	x15,x0,0
   105c0:	05d00893          	addi	x17,x0,93
   105c4:	00000073          	ecall
   105c8:	00054463          	blt	x10,x0,105d0 <_exit+0x24>
   105cc:	0000006f          	jal	x0,105cc <_exit+0x20>
   105d0:	ff010113          	addi	x2,x2,-16
   105d4:	00813023          	sd	x8,0(x2)
   105d8:	00050413          	addi	x8,x10,0
   105dc:	00113423          	sd	x1,8(x2)
   105e0:	4080043b          	subw	x8,x0,x8
   105e4:	00c000ef          	jal	x1,105f0 <__errno>
   105e8:	00852023          	sw	x8,0(x10)
   105ec:	0000006f          	jal	x0,105ec <_exit+0x40>

00000000000105f0 <__errno>:
   105f0:	f5818793          	addi	x15,x3,-168 # 11d70 <_impure_ptr>
   105f4:	0007b503          	ld	x10,0(x15)
   105f8:	00008067          	jalr	x0,0(x1)

src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6
src/main/resource/test_asm_code/memacc/main:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <register_fini>:
   100b0:	ffff0797          	auipc	x15,0xffff0
   100b4:	f5078793          	addi	x15,x15,-176 # 0 <register_fini-0x100b0>
   100b8:	00078863          	beq	x15,x0,100c8 <register_fini+0x18>
   100bc:	00000517          	auipc	x10,0x0
   100c0:	15450513          	addi	x10,x10,340 # 10210 <__libc_fini_array>
   100c4:	1040006f          	jal	x0,101c8 <atexit>
   100c8:	00008067          	jalr	x0,0(x1)

00000000000100cc <_start>:
   100cc:	00002197          	auipc	x3,0x2
   100d0:	d4c18193          	addi	x3,x3,-692 # 11e18 <__global_pointer$>
   100d4:	f6018513          	addi	x10,x3,-160 # 11d78 <_edata>
   100d8:	f9818613          	addi	x12,x3,-104 # 11db0 <__BSS_END__>
   100dc:	40a60633          	sub	x12,x12,x10
   100e0:	00000593          	addi	x11,x0,0
   100e4:	21c000ef          	jal	x1,10300 <memset>
   100e8:	00000517          	auipc	x10,0x0
   100ec:	12850513          	addi	x10,x10,296 # 10210 <__libc_fini_array>
   100f0:	0d8000ef          	jal	x1,101c8 <atexit>
   100f4:	178000ef          	jal	x1,1026c <__libc_init_array>
   100f8:	00012503          	lw	x10,0(x2)
   100fc:	00810593          	addi	x11,x2,8
   10100:	00000613          	addi	x12,x0,0
   10104:	07c000ef          	jal	x1,10180 <main>
   10108:	0d40006f          	jal	x0,101dc <exit>

000000000001010c <__do_global_dtors_aux>:
   1010c:	f601c783          	lbu	x15,-160(x3) # 11d78 <_edata>
   10110:	04079463          	bne	x15,x0,10158 <__do_global_dtors_aux+0x4c>
   10114:	ffff0797          	auipc	x15,0xffff0
   10118:	eec78793          	addi	x15,x15,-276 # 0 <register_fini-0x100b0>
   1011c:	02078863          	beq	x15,x0,1014c <__do_global_dtors_aux+0x40>
   10120:	ff010113          	addi	x2,x2,-16
   10124:	00001517          	auipc	x10,0x1
   10128:	4d850513          	addi	x10,x10,1240 # 115fc <__FRAME_END__>
   1012c:	00113423          	sd	x1,8(x2)
   10130:	00000097          	auipc	x1,0x0
   10134:	000000e7          	jalr	x1,0(x0) # 0 <register_fini-0x100b0>
   10138:	00813083          	ld	x1,8(x2)
   1013c:	00100793          	addi	x15,x0,1
   10140:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10144:	01010113          	addi	x2,x2,16
   10148:	00008067          	jalr	x0,0(x1) # 10130 <__do_global_dtors_aux+0x24>
   1014c:	00100793          	addi	x15,x0,1
   10150:	f6f18023          	sb	x15,-160(x3) # 11d78 <_edata>
   10154:	00008067          	jalr	x0,0(x1)
   10158:	00008067          	jalr	x0,0(x1)

000000000001015c <frame_dummy>:
   1015c:	ffff0797          	auipc	x15,0xffff0
   10160:	ea478793          	addi	x15,x15,-348 # 0 <register_fini-0x100b0>
   10164:	00078c63          	beq	x15,x0,1017c <frame_dummy+0x20>
   10168:	f6818593          	addi	x11,x3,-152 # 11d80 <object.5473>
   1016c:	00001517          	auipc	x10,0x1
   10170:	49050513          	addi	x10,x10,1168 # 115fc <__FRAME_END__>
   10174:	00000317          	auipc	x6,0x0
   10178:	00000067          	jalr	x0,0(x0) # 0 <register_fini-0x100b0>
   1017c:	00008067          	jalr	x0,0(x1)

0000000000010180 <main>:
   10180:	fe010113          	addi	x2,x2,-32
   10184:	00813c23          	sd	x8,24(x2)
   10188:	02010413          	addi	x8,x2,32
   1018c:	11000793          	addi	x15,x0,272
   10190:	fef43423          	sd	x15,-24(x8)
   10194:	fe843783          	ld	x15,-24(x8)
   10198:	0007b783          	ld	x15,0(x15)
   1019c:	fef43023          	sd	x15,-32(x8)
   101a0:	fe843783          	ld	x15,-24(x8)
   101a4:	0facf737          	lui	x14,0xfacf
   101a8:	00471713          	slli	x14,x14,0x4
   101ac:	ace70713          	addi	x14,x14,-1330 # faceace <__global_pointer$+0xfabccb6>
   101b0:	00e7b023          	sd	x14,0(x15)
   101b4:	00000793          	addi	x15,x0,0
   101b8:	00078513          	addi	x10,x15,0
   101bc:	01813403          	ld	x8,24(x2)
   101c0:	02010113          	addi	x2,x2,32
   101c4:	00008067          	jalr	x0,0(x1)

00000000000101c8 <atexit>:
   101c8:	00050593          	addi	x11,x10,0
   101cc:	00000693          	addi	x13,x0,0
   101d0:	00000613          	addi	x12,x0,0
   101d4:	00000513          	addi	x10,x0,0
   101d8:	2040006f          	jal	x0,103dc <__register_exitproc>

00000000000101dc <exit>:
   101dc:	ff010113          	addi	x2,x2,-16
   101e0:	00000593          	addi	x11,x0,0
   101e4:	00813023          	sd	x8,0(x2)
   101e8:	00113423          	sd	x1,8(x2)
   101ec:	00050413          	addi	x8,x10,0
   101f0:	298000ef          	jal	x1,10488 <__call_exitprocs>
   101f4:	f4818793          	addi	x15,x3,-184 # 11d60 <_global_impure_ptr>
   101f8:	0007b503          	ld	x10,0(x15)
   101fc:	05853783          	ld	x15,88(x10)
   10200:	00078463          	beq	x15,x0,10208 <exit+0x2c>
   10204:	000780e7          	jalr	x1,0(x15)
   10208:	00040513          	addi	x10,x8,0
   1020c:	3a0000ef          	jal	x1,105ac <_exit>

0000000000010210 <__libc_fini_array>:
   10210:	fe010113          	addi	x2,x2,-32
   10214:	00813823          	sd	x8,16(x2)
   10218:	00001797          	auipc	x15,0x1
   1021c:	40078793          	addi	x15,x15,1024 # 11618 <__fini_array_end>
   10220:	00001417          	auipc	x8,0x1
   10224:	3f040413          	addi	x8,x8,1008 # 11610 <__init_array_end>
   10228:	408787b3          	sub	x15,x15,x8
   1022c:	00913423          	sd	x9,8(x2)
   10230:	00113c23          	sd	x1,24(x2)
   10234:	4037d493          	srai	x9,x15,0x3
   10238:	02048063          	beq	x9,x0,10258 <__libc_fini_array+0x48>
   1023c:	ff878793          	addi	x15,x15,-8
   10240:	00878433          	add	x8,x15,x8
   10244:	00043783          	ld	x15,0(x8)
   10248:	fff48493          	addi	x9,x9,-1
   1024c:	ff840413          	addi	x8,x8,-8
   10250:	000780e7          	jalr	x1,0(x15)
   10254:	fe0498e3          	bne	x9,x0,10244 <__libc_fini_array+0x34>
   10258:	01813083          	ld	x1,24(x2)
   1025c:	01013403          	ld	x8,16(x2)
   10260:	00813483          	ld	x9,8(x2)
   10264:	02010113          	addi	x2,x2,32
   10268:	00008067          	jalr	x0,0(x1)

000000000001026c <__libc_init_array>:
   1026c:	fe010113          	addi	x2,x2,-32
   10270:	00813823          	sd	x8,16(x2)
   10274:	01213023          	sd	x18,0(x2)
   10278:	00001417          	auipc	x8,0x1
   1027c:	38840413          	addi	x8,x8,904 # 11600 <__init_array_start>
   10280:	00001917          	auipc	x18,0x1
   10284:	38090913          	addi	x18,x18,896 # 11600 <__init_array_start>
   10288:	40890933          	sub	x18,x18,x8
   1028c:	00113c23          	sd	x1,24(x2)
   10290:	00913423          	sd	x9,8(x2)
   10294:	40395913          	srai	x18,x18,0x3
   10298:	00090e63          	beq	x18,x0,102b4 <__libc_init_array+0x48>
   1029c:	00000493          	addi	x9,x0,0
   102a0:	00043783          	ld	x15,0(x8)
   102a4:	00148493          	addi	x9,x9,1
   102a8:	00840413          	addi	x8,x8,8
   102ac:	000780e7          	jalr	x1,0(x15)
   102b0:	fe9918e3          	bne	x18,x9,102a0 <__libc_init_array+0x34>
   102b4:	00001417          	auipc	x8,0x1
   102b8:	34c40413          	addi	x8,x8,844 # 11600 <__init_array_start>
   102bc:	00001917          	auipc	x18,0x1
   102c0:	35490913          	addi	x18,x18,852 # 11610 <__init_array_end>
   102c4:	40890933          	sub	x18,x18,x8
   102c8:	40395913          	srai	x18,x18,0x3
   102cc:	00090e63          	beq	x18,x0,102e8 <__libc_init_array+0x7c>
   102d0:	00000493          	addi	x9,x0,0
   102d4:	00043783          	ld	x15,0(x8)
   102d8:	00148493          	addi	x9,x9,1
   102dc:	00840413          	addi	x8,x8,8
   102e0:	000780e7          	jalr	x1,0(x15)
   102e4:	fe9918e3          	bne	x18,x9,102d4 <__libc_init_array+0x68>
   102e8:	01813083          	ld	x1,24(x2)
   102ec:	01013403          	ld	x8,16(x2)
   102f0:	00813483          	ld	x9,8(x2)
   102f4:	00013903          	ld	x18,0(x2)
   102f8:	02010113          	addi	x2,x2,32
   102fc:	00008067          	jalr	x0,0(x1)

0000000000010300 <memset>:
   10300:	00f00313          	addi	x6,x0,15
   10304:	00050713          	addi	x14,x10,0
   10308:	02c37a63          	bgeu	x6,x12,1033c <memset+0x3c>
   1030c:	00f77793          	andi	x15,x14,15
   10310:	0a079063          	bne	x15,x0,103b0 <memset+0xb0>
   10314:	06059e6