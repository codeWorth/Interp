	.file	"benchmark.c"
	.text
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.text
	.p2align 4
	.def	printf.constprop.0;	.scl	3;	.type	32;	.endef
	.seh_proc	printf.constprop.0
printf.constprop.0:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	$1, %ecx
	leaq	72(%rsp), %rbx
	movq	%rdx, 72(%rsp)
	movq	%r8, 80(%rsp)
	movq	%r9, 88(%rsp)
	movq	%rbx, 40(%rsp)
	call	*__imp___acrt_iob_func(%rip)
	movq	%rbx, %r8
	leaq	.LC0(%rip), %rdx
	movq	%rax, %rcx
	call	__mingw_vfprintf
	addq	$48, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.p2align 4
	.globl	GEN_TRIG_TABLE
	.def	GEN_TRIG_TABLE;	.scl	2;	.type	32;	.endef
	.seh_proc	GEN_TRIG_TABLE
GEN_TRIG_TABLE:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$80, %rsp
	.seh_stackalloc	80
	vmovaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	vmovaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	vmovaps	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	.seh_endprologue
	vmovsd	.LC3(%rip), %xmm7
	vmovsd	.LC4(%rip), %xmm6
	vxorps	%xmm8, %xmm8, %xmm8
	movq	$0x000000000, sineTable_4q(%rip)
	movl	$0x00000000, f_sineTable_4q(%rip)
	movl	$1, %edi
	leaq	sineTable_4q(%rip), %rsi
	leaq	f_sineTable_4q(%rip), %rbx
	.p2align 4
	.p2align 3
.L4:
	vcvtsi2sdl	%edi, %xmm8, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm7, %xmm0, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm0
	call	sin
	vmovsd	%xmm0, (%rsi,%rdi,8)
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, (%rbx,%rdi,4)
	incq	%rdi
	cmpq	$512, %rdi
	jne	.L4
	vmovaps	32(%rsp), %xmm6
	vmovaps	48(%rsp), %xmm7
	vmovaps	64(%rsp), %xmm8
	addq	$80, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.seh_endproc
	.p2align 4
	.globl	fastSinD
	.def	fastSinD;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinD
fastSinD:
	.seh_endprologue
	vmulsd	.LC5(%rip), %xmm0, %xmm1
	leaq	sineTable_4q(%rip), %rcx
	vcvttsd2sil	%xmm1, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	leal	128(%rax), %edx
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	andl	$511, %eax
	vfnmadd132sd	.LC6(%rip), %xmm0, %xmm1
	vmovsd	(%rcx,%rax,8), %xmm2
	movl	%edx, %eax
	vmulsd	.LC7(%rip), %xmm2, %xmm0
	andl	$511, %eax
	vfnmadd213sd	(%rcx,%rax,8), %xmm1, %xmm0
	vfmadd132sd	%xmm1, %xmm2, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	fastSinF
	.def	fastSinF;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinF
fastSinF:
	.seh_endprologue
	vmulss	.LC8(%rip), %xmm0, %xmm1
	leaq	f_sineTable_4q(%rip), %rcx
	vcvttss2sil	%xmm1, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	leal	128(%rax), %edx
	vcvtsi2ssl	%eax, %xmm1, %xmm1
	andl	$511, %eax
	vfnmadd132ss	.LC9(%rip), %xmm0, %xmm1
	vmovss	(%rcx,%rax,4), %xmm2
	movl	%edx, %eax
	vmulss	.LC10(%rip), %xmm2, %xmm0
	andl	$511, %eax
	vfnmadd213ss	(%rcx,%rax,4), %xmm1, %xmm0
	vfmadd132ss	%xmm1, %xmm2, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	fastSinSIMD
	.def	fastSinSIMD;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinSIMD
fastSinSIMD:
	subq	$24, %rsp
	.seh_stackalloc	24
	vmovaps	%xmm6, (%rsp)
	.seh_savexmm	%xmm6, 0
	.seh_endprologue
	vmovaps	(%rcx), %ymm1
	vmovdqa	.LC13(%rip), %ymm4
	leaq	f_sineTable_4q(%rip), %rax
	vmulps	.LC11(%rip), %ymm1, %ymm0
	vcvtps2dq	%ymm0, %ymm0
	vpand	%ymm4, %ymm0, %ymm5
	vcvtdq2ps	%ymm0, %ymm2
	vpaddd	.LC14(%rip), %ymm0, %ymm0
	vfmadd132ps	.LC12(%rip), %ymm1, %ymm2
	vxorps	%xmm1, %xmm1, %xmm1
	vcmpps	$0, %ymm1, %ymm1, %ymm1
	vmovaps	%ymm1, %ymm6
	vgatherdps	%ymm6, (%rax,%ymm5,4), %ymm3
	vpand	%ymm4, %ymm0, %ymm0
	vgatherdps	%ymm1, (%rax,%ymm0,4), %ymm4
	vmulps	.LC15(%rip), %ymm3, %ymm0
	vfmadd132ps	%ymm2, %ymm4, %ymm0
	vfmadd132ps	%ymm2, %ymm3, %ymm0
	vmovaps	%ymm0, (%rdx)
	vzeroupper
	vmovaps	(%rsp), %xmm6
	addq	$24, %rsp
	ret
	.seh_endproc
	.p2align 4
	.globl	chebSin
	.def	chebSin;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSin
chebSin:
	.seh_endprologue
	vmovss	.LC16(%rip), %xmm3
	vmovss	.LC18(%rip), %xmm2
	vmovss	.LC24(%rip), %xmm4
	vdivss	%xmm3, %xmm0, %xmm1
	vcvttss2sil	%xmm1, %edx
	movl	%edx, %eax
	movl	%edx, %ecx
	vxorps	%xmm1, %xmm1, %xmm1
	shrl	$31, %eax
	andl	$1, %ecx
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	addl	%edx, %eax
	sarl	%eax
	leal	(%rax,%rcx), %r8d
	subl	%ecx, %eax
	testl	%edx, %edx
	cmovg	%r8d, %eax
	negl	%eax
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	vfmadd132sd	.LC17(%rip), %xmm0, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm0
	vfmadd213ss	.LC19(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC20(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC21(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC22(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC23(%rip), %xmm0, %xmm2
	vsubss	%xmm3, %xmm1, %xmm0
	vaddss	%xmm3, %xmm1, %xmm3
	vaddss	%xmm4, %xmm0, %xmm0
	vsubss	%xmm4, %xmm3, %xmm3
	vmulss	%xmm3, %xmm0, %xmm0
	vmulss	%xmm2, %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	sum8
	.def	sum8;	.scl	2;	.type	32;	.endef
	.seh_proc	sum8
sum8:
	.seh_endprologue
	vmovaps	(%rcx), %ymm1
	vextractf128	$0x1, %ymm1, %xmm0
	vaddps	%xmm1, %xmm0, %xmm0
	vmovhlps	%xmm0, %xmm0, %xmm1
	vaddps	%xmm1, %xmm0, %xmm0
	vshufps	$1, %xmm0, %xmm0, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vzeroupper
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	call	__main
	leaq	32(%rsp), %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	vmovsd	.LC25(%rip), %xmm0
	vmovsd	.LC26(%rip), %xmm2
	vmovsd	.LC27(%rip), %xmm1
	.p2align 4
	.p2align 3
.L14:
	vaddsd	%xmm2, %xmm0, %xmm0
	vcomisd	%xmm0, %xmm1
	ja	.L14
	leaq	48(%rsp), %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	movl	56(%rsp), %eax
	leaq	.LC0(%rip), %rcx
	subl	40(%rsp), %eax
	movq	48(%rsp), %rdx
	subq	32(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf.constprop.0
	xorl	%eax, %eax
	addq	$72, %rsp
	ret
	.seh_endproc
	.globl	chebCoeffs
	.section .rdata,"dr"
	.align 16
chebCoeffs:
	.long	-1110474373
	.long	1004073975
	.long	-1187647768
	.long	908674213
	.long	-1295496101
	.long	789717965
	.globl	F_PI
	.align 4
F_PI:
	.long	1078530011
	.globl	f_sineTable_4q
	.bss
	.align 32
f_sineTable_4q:
	.space 2048
	.globl	sineTable_4q
	.align 32
sineTable_4q:
	.space 4096
	.section .rdata,"dr"
	.align 8
.LC3:
	.long	1413754136
	.long	1074340347
	.align 8
.LC4:
	.long	0
	.long	1063256064
	.align 8
.LC5:
	.long	1841940611
	.long	1079271216
	.align 8
.LC6:
	.long	1413754136
	.long	1065951739
	.align 8
.LC7:
	.long	0
	.long	1071644672
	.set	.LC8,.LC11
	.align 4
.LC9:
	.long	1011421147
	.align 4
.LC10:
	.long	1056964608
	.align 32
.LC11:
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.align 32
.LC12:
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.align 32
.LC13:
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.align 32
.LC14:
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.align 32
.LC15:
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.align 4
.LC16:
	.long	1078530011
	.align 8
.LC17:
	.long	1413754136
	.long	1075388923
	.align 4
.LC18:
	.long	789717965
	.align 4
.LC19:
	.long	-1295496101
	.align 4
.LC20:
	.long	908674213
	.align 4
.LC21:
	.long	-1187647768
	.align 4
.LC22:
	.long	1004073975
	.align 4
.LC23:
	.long	-1110474373
	.align 4
.LC24:
	.long	867941678
	.align 8
.LC25:
	.long	0
	.long	-1059238912
	.align 8
.LC26:
	.long	1196643804
	.long	1055193283
	.align 8
.LC27:
	.long	0
	.long	1088244736
	.ident	"GCC: (Rev1, Built by MSYS2 project) 11.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	sin;	.scl	2;	.type	32;	.endef
	.def	clock_gettime;	.scl	2;	.type	32;	.endef
