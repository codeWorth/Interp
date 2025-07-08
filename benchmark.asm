	.file	"benchmark.c"
	.text
	.globl	sineTable_4q
	.bss
	.align 32
sineTable_4q:
	.space 4096
	.globl	f_sineTable_4q
	.align 32
f_sineTable_4q:
	.space 2048
	.text
	.globl	GEN_TRIG_TABLE
	.def	GEN_TRIG_TABLE;	.scl	2;	.type	32;	.endef
	.seh_proc	GEN_TRIG_TABLE
GEN_TRIG_TABLE:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	vcvtsi2sdl	-4(%rbp), %xmm0, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	vmovsd	.LC0(%rip), %xmm1
	vmulsd	%xmm1, %xmm0, %xmm0
	vmovsd	.LC1(%rip), %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, -16(%rbp)
	movq	-16(%rbp), %rax
	vmovq	%rax, %xmm0
	call	sin
	vmovq	%xmm0, %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	leaq	sineTable_4q(%rip), %rcx
	movq	%rax, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	vmovq	%rax, %xmm0
	call	sin
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	movl	-4(%rbp), %eax
	cltq
	salq	$2, %rax
	leaq	f_sineTable_4q(%rip), %rdx
	vmovss	%xmm0, (%rax,%rdx)
	incl	-4(%rbp)
.L2:
	cmpl	$511, -4(%rbp)
	jle	.L3
	nop
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	F_PI
	.section .rdata,"dr"
	.align 4
F_PI:
	.long	1078530011
	.text
	.globl	fastSinD
	.def	fastSinD;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinD
fastSinD:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	vmovsd	%xmm0, 16(%rbp)
	vmovsd	16(%rbp), %xmm1
	vmovsd	.LC2(%rip), %xmm0
	vmulsd	%xmm0, %xmm1, %xmm0
	vcvttsd2sil	%xmm0, %eax
	movl	%eax, -4(%rbp)
	vcvtsi2sdl	-4(%rbp), %xmm0, %xmm0
	vmovsd	.LC3(%rip), %xmm1
	vmulsd	%xmm1, %xmm0, %xmm0
	vmovsd	16(%rbp), %xmm1
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -16(%rbp)
	movl	-4(%rbp), %eax
	subl	$-128, %eax
	movl	%eax, -20(%rbp)
	andl	$511, -4(%rbp)
	andl	$511, -20(%rbp)
	movl	-4(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	sineTable_4q(%rip), %rdx
	vmovsd	(%rax,%rdx), %xmm0
	vmovsd	%xmm0, -32(%rbp)
	movl	-20(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	sineTable_4q(%rip), %rdx
	vmovsd	(%rax,%rdx), %xmm0
	vmovsd	%xmm0, -40(%rbp)
	vmovsd	-32(%rbp), %xmm1
	vmovsd	.LC4(%rip), %xmm0
	vmulsd	%xmm0, %xmm1, %xmm0
	vmulsd	-16(%rbp), %xmm0, %xmm0
	vmovsd	-40(%rbp), %xmm1
	vsubsd	%xmm0, %xmm1, %xmm0
	vmulsd	-16(%rbp), %xmm0, %xmm0
	vaddsd	-32(%rbp), %xmm0, %xmm0
	vmovq	%xmm0, %rax
	vmovq	%rax, %xmm0
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	fastSinF
	.def	fastSinF;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinF
fastSinF:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	vmovss	%xmm0, 16(%rbp)
	vmovss	.LC5(%rip), %xmm1
	vmovss	.LC6(%rip), %xmm0
	vdivss	%xmm1, %xmm0, %xmm0
	vmulss	16(%rbp), %xmm0, %xmm0
	vcvttss2sil	%xmm0, %eax
	movl	%eax, -4(%rbp)
	vcvtsi2ssl	-4(%rbp), %xmm1, %xmm1
	vmovss	.LC5(%rip), %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
	vmovss	.LC7(%rip), %xmm2
	vdivss	%xmm2, %xmm0, %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vmovss	16(%rbp), %xmm1
	vsubss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, -8(%rbp)
	movl	-4(%rbp), %eax
	subl	$-128, %eax
	movl	%eax, -12(%rbp)
	andl	$511, -4(%rbp)
	andl	$511, -12(%rbp)
	movl	-4(%rbp), %eax
	cltq
	salq	$2, %rax
	leaq	f_sineTable_4q(%rip), %rdx
	vmovss	(%rax,%rdx), %xmm0
	vmovss	%xmm0, -16(%rbp)
	movl	-12(%rbp), %eax
	cltq
	salq	$2, %rax
	leaq	f_sineTable_4q(%rip), %rdx
	vmovss	(%rax,%rdx), %xmm0
	vmovss	%xmm0, -20(%rbp)
	vmovss	-16(%rbp), %xmm1
	vmovss	.LC8(%rip), %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vmulss	-8(%rbp), %xmm0, %xmm0
	vmovss	-20(%rbp), %xmm1
	vsubss	%xmm0, %xmm1, %xmm0
	vmulss	-8(%rbp), %xmm0, %xmm0
	vaddss	-16(%rbp), %xmm0, %xmm0
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	fastSinSIMD
	.def	fastSinSIMD;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinSIMD
fastSinSIMD:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$720, %rsp
	.seh_stackalloc	720
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movq	%rcx, 608(%rbp)
	movq	%rdx, 616(%rbp)
	leaq	592(%rbp), %rax
	subq	$720, %rax
	addq	$31, %rax
	shrq	$5, %rax
	salq	$5, %rax
	vmovss	.LC5(%rip), %xmm1
	vmovss	.LC6(%rip), %xmm0
	vdivss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, 572(%rbp)
	vbroadcastss	572(%rbp), %ymm0
	vmovaps	%ymm0, 640(%rax)
	movq	608(%rbp), %rdx
	vmovaps	(%rdx), %ymm0
	vmulps	640(%rax), %ymm0, %ymm0
	vmovaps	%ymm0, (%rax)
	vcvtps2dq	(%rax), %ymm0
	vmovdqa	%ymm0, 608(%rax)
	vmovss	.LC5(%rip), %xmm1
	vmovss	.LC9(%rip), %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vmovss	.LC7(%rip), %xmm1
	vdivss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, 576(%rbp)
	vbroadcastss	576(%rbp), %ymm0
	vmovaps	%ymm0, 640(%rax)
	vmovdqa	608(%rax), %ymm0
	vmovdqa	%ymm0, 32(%rax)
	vmovdqa	32(%rax), %ymm0
	vcvtdq2ps	%ymm0, %ymm0
	vmovaps	%ymm0, 576(%rax)
	movq	608(%rbp), %rdx
	vmovaps	(%rdx), %ymm0
	vmovaps	640(%rax), %ymm1
	vmovaps	%ymm1, 128(%rax)
	vmovaps	576(%rax), %ymm1
	vmovaps	%ymm1, 96(%rax)
	vmovaps	%ymm0, 64(%rax)
	vmovaps	96(%rax), %ymm1
	vmovaps	64(%rax), %ymm0
	vfmadd231ps	128(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 544(%rax)
	movl	$128, 580(%rbp)
	vpbroadcastd	580(%rbp), %ymm0
	vmovdqa	%ymm0, 512(%rax)
	vmovdqa	608(%rax), %ymm0
	vpaddq	512(%rax), %ymm0, %ymm0
	vmovdqa	%ymm0, 480(%rax)
	movl	$511, 584(%rbp)
	vpbroadcastd	584(%rbp), %ymm0
	vmovdqa	%ymm0, 448(%rax)
	vmovdqa	608(%rax), %ymm0
	vpand	448(%rax), %ymm0, %ymm0
	vmovdqa	%ymm0, 608(%rax)
	vmovdqa	480(%rax), %ymm0
	vpand	448(%rax), %ymm0, %ymm0
	vmovdqa	%ymm0, 480(%rax)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, %ymm2
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, %ymm1
	vcmpps	$0, %ymm2, %ymm1, %ymm0
	vmovdqa	608(%rax), %ymm1
	vxorps	%xmm2, %xmm2, %xmm2
	vmovaps	%ymm2, %ymm3
	leaq	f_sineTable_4q(%rip), %rdx
	vgatherdps	%ymm0, (%rdx,%ymm1,4), %ymm3
	vmovaps	%ymm3, %ymm0
	vmovaps	%ymm0, 416(%rax)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, %ymm2
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, %ymm1
	vcmpps	$0, %ymm2, %ymm1, %ymm0
	vmovdqa	480(%rax), %ymm1
	vxorps	%xmm2, %xmm2, %xmm2
	vmovaps	%ymm2, %ymm3
	leaq	f_sineTable_4q(%rip), %rdx
	vgatherdps	%ymm0, (%rdx,%ymm1,4), %ymm3
	vmovaps	%ymm3, %ymm0
	vmovaps	%ymm0, 384(%rax)
	vmovss	.LC10(%rip), %xmm0
	vmovss	%xmm0, 588(%rbp)
	vbroadcastss	588(%rbp), %ymm0
	vmovaps	%ymm0, 640(%rax)
	vmovaps	640(%rax), %ymm0
	vmulps	416(%rax), %ymm0, %ymm0
	vmovaps	%ymm0, 224(%rax)
	vmovaps	544(%rax), %ymm0
	vmovaps	%ymm0, 192(%rax)
	vmovaps	384(%rax), %ymm0
	vmovaps	%ymm0, 160(%rax)
	vmovaps	192(%rax), %ymm1
	vmovaps	160(%rax), %ymm0
	vfmadd231ps	224(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 352(%rax)
	vmovaps	352(%rax), %ymm0
	vmovaps	%ymm0, 320(%rax)
	vmovaps	544(%rax), %ymm0
	vmovaps	%ymm0, 288(%rax)
	vmovaps	416(%rax), %ymm0
	vmovaps	%ymm0, 256(%rax)
	vmovaps	288(%rax), %ymm1
	vmovaps	256(%rax), %ymm0
	vfmadd231ps	320(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	%ymm1, %ymm0
	movq	616(%rbp), %rax
	vmovaps	%ymm0, (%rax)
	nop
	addq	$720, %rsp
	popq	%rbp
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
	.text
	.globl	chebSin
	.def	chebSin;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSin
chebSin:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	vmovss	%xmm0, 16(%rbp)
	vmovss	.LC5(%rip), %xmm0
	vmovss	%xmm0, -4(%rbp)
	vmovss	.LC11(%rip), %xmm0
	vmovss	%xmm0, -8(%rbp)
	vmovss	16(%rbp), %xmm0
	vdivss	-4(%rbp), %xmm0, %xmm0
	vcvttss2sil	%xmm0, %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	notl	%eax
	shrl	$31, %eax
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	andl	%edx, %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	incl	%eax
	movl	-12(%rbp), %edx
	sarx	%eax, %edx, %eax
	movl	%eax, -24(%rbp)
	vcvtss2sd	16(%rbp), %xmm1, %xmm1
	movl	-24(%rbp), %eax
	negl	%eax
	vcvtsi2sdl	%eax, %xmm0, %xmm0
	vmovsd	.LC12(%rip), %xmm2
	vmulsd	%xmm2, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	vmovss	16(%rbp), %xmm0
	vmulss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, -28(%rbp)
	vmovss	.LC13(%rip), %xmm0
	vmovss	%xmm0, -32(%rbp)
	vmovss	-32(%rbp), %xmm0
	vmulss	-28(%rbp), %xmm0, %xmm0
	vmovss	.LC14(%rip), %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, -36(%rbp)
	vmovss	-36(%rbp), %xmm0
	vmulss	-28(%rbp), %xmm0, %xmm0
	vmovss	.LC15(%rip), %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, -40(%rbp)
	vmovss	-40(%rbp), %xmm0
	vmulss	-28(%rbp), %xmm0, %xmm0
	vmovss	.LC16(%rip), %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, -44(%rbp)
	vmovss	-44(%rbp), %xmm0
	vmulss	-28(%rbp), %xmm0, %xmm0
	vmovss	.LC17(%rip), %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, -48(%rbp)
	vmovss	-48(%rbp), %xmm0
	vmulss	-28(%rbp), %xmm0, %xmm0
	vmovss	.LC18(%rip), %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, -52(%rbp)
	vmovss	16(%rbp), %xmm0
	vsubss	-4(%rbp), %xmm0, %xmm0
	vsubss	-8(%rbp), %xmm0, %xmm1
	vmovss	16(%rbp), %xmm0
	vaddss	-4(%rbp), %xmm0, %xmm0
	vaddss	-8(%rbp), %xmm0, %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vmulss	-52(%rbp), %xmm0, %xmm0
	vmulss	16(%rbp), %xmm0, %xmm0
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	chebSinSIMD
	.def	chebSinSIMD;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSinSIMD
chebSinSIMD:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$1280, %rsp
	.seh_stackalloc	1280
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movq	%rcx, 1168(%rbp)
	movq	%rdx, 1176(%rbp)
	leaq	1152(%rbp), %rax
	subq	$1280, %rax
	addq	$31, %rax
	shrq	$5, %rax
	salq	$5, %rax
	vmovss	.LC5(%rip), %xmm0
	vmovss	%xmm0, 1104(%rbp)
	vbroadcastss	1104(%rbp), %ymm0
	vmovaps	%ymm0, 1184(%rax)
	vmovss	.LC11(%rip), %xmm0
	vmovss	%xmm0, 1108(%rbp)
	vbroadcastss	1108(%rbp), %ymm0
	vmovaps	%ymm0, 1152(%rax)
	movl	$1, 1112(%rbp)
	vpbroadcastd	1112(%rbp), %ymm0
	vmovdqa	%ymm0, 1120(%rax)
	movq	1168(%rbp), %rdx
	vmovaps	(%rdx), %ymm0
	vdivps	1184(%rax), %ymm0, %ymm0
	vmovaps	%ymm0, (%rax)
	vcvtps2dq	(%rax), %ymm0
	vmovdqa	%ymm0, 1088(%rax)
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	vpxor	1088(%rax), %ymm0, %ymm0
	vmovdqa	%ymm0, 32(%rax)
	movl	$31, 1116(%rbp)
	vmovdqa	32(%rax), %ymm1
	vmovd	1116(%rbp), %xmm0
	vpsrld	%xmm0, %ymm1, %ymm0
	vmovdqa	%ymm0, %ymm1
	vmovdqa	%ymm1, %ymm0
	vpand	1088(%rax), %ymm0, %ymm0
	vmovdqa	%ymm0, 1056(%rax)
	vmovss	.LC5(%rip), %xmm1
	vmovss	.LC9(%rip), %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, 1120(%rbp)
	vbroadcastss	1120(%rbp), %ymm0
	vmovaps	%ymm0, 1024(%rax)
	vmovdqa	1088(%rax), %ymm0
	vmovdqa	%ymm0, 64(%rax)
	movl	$1, 1124(%rbp)
	vmovdqa	64(%rax), %ymm1
	vmovd	1124(%rbp), %xmm0
	vpsrad	%xmm0, %ymm1, %ymm0
	vmovdqa	%ymm0, %ymm1
	vmovdqa	%ymm1, %ymm0
	vpaddq	1056(%rax), %ymm0, %ymm0
	vmovdqa	%ymm0, 992(%rax)
	vmovdqa	992(%rax), %ymm0
	vmovdqa	%ymm0, 96(%rax)
	vmovdqa	96(%rax), %ymm0
	vcvtdq2ps	%ymm0, %ymm0
	vmovaps	%ymm0, 960(%rax)
	movq	1168(%rbp), %rdx
	vmovaps	(%rdx), %ymm0
	vmovaps	1024(%rax), %ymm1
	vmovaps	%ymm1, 192(%rax)
	vmovaps	960(%rax), %ymm1
	vmovaps	%ymm1, 160(%rax)
	vmovaps	%ymm0, 128(%rax)
	vmovaps	160(%rax), %ymm1
	vmovaps	128(%rax), %ymm0
	vfmadd231ps	192(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 928(%rax)
	vmovaps	928(%rax), %ymm0
	vmulps	%ymm0, %ymm0, %ymm0
	vmovaps	%ymm0, 896(%rax)
	vmovss	.LC13(%rip), %xmm0
	vmovss	%xmm0, 1128(%rbp)
	vbroadcastss	1128(%rbp), %ymm0
	vmovaps	%ymm0, 864(%rax)
	vmovss	.LC14(%rip), %xmm0
	vmovss	%xmm0, 1132(%rbp)
	vbroadcastss	1132(%rbp), %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	864(%rax), %ymm0
	vmovaps	%ymm0, 288(%rax)
	vmovaps	896(%rax), %ymm0
	vmovaps	%ymm0, 256(%rax)
	vmovaps	%ymm1, 224(%rax)
	vmovaps	256(%rax), %ymm1
	vmovaps	224(%rax), %ymm0
	vfmadd231ps	288(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 832(%rax)
	vmovss	.LC15(%rip), %xmm0
	vmovss	%xmm0, 1136(%rbp)
	vbroadcastss	1136(%rbp), %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	832(%rax), %ymm0
	vmovaps	%ymm0, 384(%rax)
	vmovaps	896(%rax), %ymm0
	vmovaps	%ymm0, 352(%rax)
	vmovaps	%ymm1, 320(%rax)
	vmovaps	352(%rax), %ymm1
	vmovaps	320(%rax), %ymm0
	vfmadd231ps	384(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 800(%rax)
	vmovss	.LC16(%rip), %xmm0
	vmovss	%xmm0, 1140(%rbp)
	vbroadcastss	1140(%rbp), %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	800(%rax), %ymm0
	vmovaps	%ymm0, 480(%rax)
	vmovaps	896(%rax), %ymm0
	vmovaps	%ymm0, 448(%rax)
	vmovaps	%ymm1, 416(%rax)
	vmovaps	448(%rax), %ymm1
	vmovaps	416(%rax), %ymm0
	vfmadd231ps	480(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 768(%rax)
	vmovss	.LC17(%rip), %xmm0
	vmovss	%xmm0, 1144(%rbp)
	vbroadcastss	1144(%rbp), %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	768(%rax), %ymm0
	vmovaps	%ymm0, 576(%rax)
	vmovaps	896(%rax), %ymm0
	vmovaps	%ymm0, 544(%rax)
	vmovaps	%ymm1, 512(%rax)
	vmovaps	544(%rax), %ymm1
	vmovaps	512(%rax), %ymm0
	vfmadd231ps	576(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 736(%rax)
	vmovss	.LC18(%rip), %xmm0
	vmovss	%xmm0, 1148(%rbp)
	vbroadcastss	1148(%rbp), %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	736(%rax), %ymm0
	vmovaps	%ymm0, 672(%rax)
	vmovaps	896(%rax), %ymm0
	vmovaps	%ymm0, 640(%rax)
	vmovaps	%ymm1, 608(%rax)
	vmovaps	640(%rax), %ymm1
	vmovaps	608(%rax), %ymm0
	vfmadd231ps	672(%rax), %ymm1, %ymm0
	vmovaps	%ymm0, 704(%rax)
	vmovaps	928(%rax), %ymm0
	vsubps	1184(%rax), %ymm0, %ymm0
	vsubps	1152(%rax), %ymm0, %ymm1
	vmovaps	928(%rax), %ymm0
	vaddps	1184(%rax), %ymm0, %ymm0
	vaddps	1152(%rax), %ymm0, %ymm0
	vmulps	%ymm0, %ymm1, %ymm0
	vmulps	704(%rax), %ymm0, %ymm0
	vmulps	928(%rax), %ymm0, %ymm0
	movq	1176(%rbp), %rax
	vmovaps	%ymm0, (%rax)
	nop
	addq	$1280, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	sum8
	.def	sum8;	.scl	2;	.type	32;	.endef
	.seh_proc	sum8
sum8:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$336, %rsp
	.seh_stackalloc	336
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movq	%rcx, 224(%rbp)
	leaq	208(%rbp), %rax
	subq	$336, %rax
	addq	$31, %rax
	shrq	$5, %rax
	salq	$5, %rax
	movq	224(%rbp), %rdx
	vmovaps	(%rdx), %ymm0
	vextractf128	$0x1, %ymm0, 192(%rbp)
	movq	224(%rbp), %rdx
	vmovaps	(%rdx), %ymm0
	vmovaps	%ymm0, (%rax)
	vmovaps	(%rax), %xmm0
	nop
	vmovaps	%xmm0, 176(%rbp)
	vmovaps	176(%rbp), %xmm0
	vmovaps	%xmm0, -48(%rbp)
	vmovaps	192(%rbp), %xmm0
	vmovaps	%xmm0, -64(%rbp)
	vmovaps	-48(%rbp), %xmm0
	vaddps	-64(%rbp), %xmm0, %xmm0
	vmovaps	%xmm0, 160(%rbp)
	vmovaps	160(%rbp), %xmm0
	vmovaps	%xmm0, 144(%rbp)
	vmovaps	160(%rbp), %xmm0
	vmovaps	%xmm0, -16(%rbp)
	vmovaps	160(%rbp), %xmm0
	vmovaps	%xmm0, -32(%rbp)
	vmovaps	-16(%rbp), %xmm0
	vmovlps	-24(%rbp), %xmm0, %xmm0
	nop
	vmovaps	%xmm0, 128(%rbp)
	vmovaps	144(%rbp), %xmm0
	vmovaps	%xmm0, 16(%rbp)
	vmovaps	128(%rbp), %xmm0
	vmovaps	%xmm0, 0(%rbp)
	vmovaps	16(%rbp), %xmm0
	vaddps	0(%rbp), %xmm0, %xmm0
	vmovaps	%xmm0, 112(%rbp)
	vmovaps	112(%rbp), %xmm0
	vmovaps	%xmm0, 96(%rbp)
	vmovaps	112(%rbp), %xmm0
	vmovaps	112(%rbp), %xmm1
	vshufps	$1, %xmm1, %xmm0, %xmm0
	vmovaps	%xmm0, 80(%rbp)
	vmovaps	96(%rbp), %xmm0
	vmovaps	%xmm0, 48(%rbp)
	vmovaps	80(%rbp), %xmm0
	vmovaps	%xmm0, 32(%rbp)
	vmovaps	48(%rbp), %xmm0
	vaddss	32(%rbp), %xmm0, %xmm0
	nop
	vmovaps	%xmm0, 64(%rbp)
	vmovaps	64(%rbp), %xmm0
	vmovaps	%xmm0, -80(%rbp)
	vmovss	-80(%rbp), %xmm0
	addq	$336, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC30:
	.ascii "failed on %f, %f instead of %f\12\0"
	.text
	.globl	testChebSIMD
	.def	testChebSIMD;	.scl	2;	.type	32;	.endef
	.seh_proc	testChebSIMD
testChebSIMD:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$312, %rsp
	.seh_stackalloc	312
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	vmovaps	%xmm6, 128(%rbp)
	.seh_savexmm	%xmm6, 256
	vmovaps	%xmm7, 144(%rbp)
	.seh_savexmm	%xmm7, 272
	vmovaps	%xmm8, 160(%rbp)
	.seh_savexmm	%xmm8, 288
	.seh_endprologue
	leaq	128(%rbp), %rax
	subq	$192, %rax
	addq	$31, %rax
	shrq	$5, %rax
	salq	$5, %rax
	movq	%rax, %rbx
	vmovsd	.LC19(%rip), %xmm0
	vmovsd	%xmm0, 120(%rbp)
	jmp	.L57
.L64:
	vmovsd	120(%rbp), %xmm1
	vmovsd	.LC20(%rip), %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovsd	120(%rbp), %xmm2
	vmovsd	.LC21(%rip), %xmm1
	vaddsd	%xmm1, %xmm2, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmovsd	120(%rbp), %xmm3
	vmovsd	.LC22(%rip), %xmm2
	vaddsd	%xmm2, %xmm3, %xmm2
	vcvtsd2ss	%xmm2, %xmm2, %xmm2
	vmovsd	120(%rbp), %xmm4
	vmovsd	.LC23(%rip), %xmm3
	vaddsd	%xmm3, %xmm4, %xmm3
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vmovsd	120(%rbp), %xmm5
	vmovsd	.LC24(%rip), %xmm4
	vaddsd	%xmm4, %xmm5, %xmm4
	vcvtsd2ss	%xmm4, %xmm4, %xmm4
	vmovsd	120(%rbp), %xmm6
	vmovsd	.LC25(%rip), %xmm5
	vaddsd	%xmm5, %xmm6, %xmm5
	vcvtsd2ss	%xmm5, %xmm5, %xmm5
	vmovsd	120(%rbp), %xmm7
	vmovsd	.LC26(%rip), %xmm6
	vaddsd	%xmm6, %xmm7, %xmm6
	vcvtsd2ss	%xmm6, %xmm6, %xmm6
	vmovsd	120(%rbp), %xmm8
	vmovsd	.LC27(%rip), %xmm7
	vaddsd	%xmm7, %xmm8, %xmm7
	vcvtsd2ss	%xmm7, %xmm7, %xmm7
	vmovss	%xmm7, 84(%rbp)
	vmovss	%xmm6, 80(%rbp)
	vmovss	%xmm5, 76(%rbp)
	vmovss	%xmm4, 72(%rbp)
	vmovss	%xmm3, 68(%rbp)
	vmovss	%xmm2, 64(%rbp)
	vmovss	%xmm1, 60(%rbp)
	vmovss	%xmm0, 56(%rbp)
	vmovss	84(%rbp), %xmm1
	vmovss	80(%rbp), %xmm0
	vunpcklps	%xmm1, %xmm0, %xmm1
	vmovss	76(%rbp), %xmm2
	vmovss	72(%rbp), %xmm0
	vunpcklps	%xmm2, %xmm0, %xmm0
	vmovlhps	%xmm1, %xmm0, %xmm1
	vmovss	68(%rbp), %xmm2
	vmovss	64(%rbp), %xmm0
	vunpcklps	%xmm2, %xmm0, %xmm2
	vmovss	60(%rbp), %xmm3
	vmovss	56(%rbp), %xmm0
	vunpcklps	%xmm3, %xmm0, %xmm0
	vmovlhps	%xmm2, %xmm0, %xmm0
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0
	vmovaps	%ymm0, %ymm1
	vmovaps	%ymm1, %ymm0
	vmovaps	%ymm0, 64(%rbx)
	leaq	32(%rbx), %rdx
	leaq	64(%rbx), %rax
	movq	%rax, %rcx
	call	chebSinSIMD
	vmovaps	32(%rbx), %ymm0
	leaq	-96(%rbp), %rax
	movq	%rax, 88(%rbp)
	vmovaps	%ymm0, (%rbx)
	vmovaps	(%rbx), %ymm0
	movq	88(%rbp), %rax
	vmovups	%ymm0, (%rax)
	nop
	movl	$1, 116(%rbp)
	jmp	.L59
.L63:
	vcvtsi2sdl	116(%rbp), %xmm0, %xmm0
	vmovsd	.LC27(%rip), %xmm1
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	120(%rbp), %xmm0, %xmm4
	vmovq	%xmm4, %rax
	vmovq	%rax, %xmm0
	call	sin
	vmovq	%xmm0, %rax
	movq	%rax, 104(%rbp)
	movl	116(%rbp), %eax
	decl	%eax
	cltq
	vmovss	-96(%rbp,%rax,4), %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmovsd	104(%rbp), %xmm1
	vsubsd	%xmm0, %xmm1, %xmm0
	vmovq	.LC28(%rip), %xmm1
	vandpd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, 96(%rbp)
	vmovsd	96(%rbp), %xmm0
	vcomisd	.LC29(%rip), %xmm0
	jbe	.L66
	movl	116(%rbp), %eax
	decl	%eax
	cltq
	vmovss	-96(%rbp,%rax,4), %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm2
	vcvtsi2sdl	116(%rbp), %xmm0, %xmm0
	vmovsd	.LC27(%rip), %xmm1
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	120(%rbp), %xmm0, %xmm1
	vmovsd	104(%rbp), %xmm0
	movq	104(%rbp), %rdx
	vmovq	%xmm2, %rax
	movq	%rax, %rcx
	vmovq	%rcx, %xmm2
	movq	%rax, %rcx
	vmovq	%xmm1, %rax
	movq	%rax, %r8
	vmovq	%r8, %xmm1
	vmovsd	%xmm0, %xmm0, %xmm3
	movq	%rdx, %r9
	movq	%rcx, %r8
	movq	%rax, %rdx
	leaq	.LC30(%rip), %rax
	movq	%rax, %rcx
	call	printf
	jmp	.L56
.L66:
	incl	116(%rbp)
.L59:
	cmpl	$8, 116(%rbp)
	jle	.L63
	vmovsd	120(%rbp), %xmm1
	vmovsd	.LC31(%rip), %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 120(%rbp)
.L57:
	vmovsd	.LC32(%rip), %xmm0
	vcomisd	120(%rbp), %xmm0
	ja	.L64
.L56:
	vmovaps	128(%rbp), %xmm6
	vmovaps	144(%rbp), %xmm7
	vmovaps	160(%rbp), %xmm8
	addq	$312, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	48(%rsp), %rbp
	.seh_setframe	%rbp, 48
	.seh_endprologue
	movq	%rcx, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%r8, 48(%rbp)
	movq	%r9, 56(%rbp)
	leaq	40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rbx
	movl	$1, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rbx, %r8
	movq	32(%rbp), %rdx
	movq	%rax, %rcx
	call	__mingw_vfprintf
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC34:
	.ascii "Spin up... \0"
.LC41:
	.ascii "done\12\0"
.LC45:
	.ascii "%f\12\0"
	.align 8
.LC46:
	.ascii "Double fast sin took %d milliseconds.\12\0"
	.align 8
.LC48:
	.ascii "Float fast sin took %d milliseconds.\12\0"
	.text
	.globl	benchmarkCallingFunc
	.def	benchmarkCallingFunc;	.scl	2;	.type	32;	.endef
	.seh_proc	benchmarkCallingFunc
benchmarkCallingFunc:
	pushq	%rbp
	.seh_pushreg	%rbp
	movl	$80176, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	80176
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	$0, 80044(%rbp)
	jmp	.L70
.L71:
	movl	80044(%rbp), %eax
	imull	$91, %eax, %eax
	movslq	%eax, %rdx
	imulq	$351843721, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$13, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$100000, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	vcvtsi2ssl	%edx, %xmm0, %xmm0
	vmovss	.LC33(%rip), %xmm1
	vdivss	%xmm1, %xmm0, %xmm0
	movl	80044(%rbp), %eax
	cltq
	vmovss	%xmm0, -96(%rbp,%rax,4)
	incl	80044(%rbp)
.L70:
	cmpl	$9999, 80044(%rbp)
	jle	.L71
	leaq	.LC34(%rip), %rax
	movq	%rax, %rcx
	call	printf
	vmovsd	.LC35(%rip), %xmm0
	vmovsd	%xmm0, 80032(%rbp)
	jmp	.L72
.L73:
	movq	80032(%rbp), %rax
	vmovq	%rax, %xmm0
	call	fastSinD
	vmovq	%xmm0, %rax
	movq	%rax, 79936(%rbp)
	vmovsd	80032(%rbp), %xmm1
	vmovsd	.LC36(%rip), %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 80032(%rbp)
.L72:
	vmovsd	.LC37(%rip), %xmm0
	vcomisd	80032(%rbp), %xmm0
	ja	.L73
	vmovss	.LC38(%rip), %xmm0
	vmovss	%xmm0, 80028(%rbp)
	jmp	.L74
.L75:
	movl	80028(%rbp), %eax
	vmovd	%eax, %xmm0
	call	fastSinF
	vmovd	%xmm0, %eax
	movl	%eax, 79944(%rbp)
	vmovss	80028(%rbp), %xmm1
	vmovss	.LC39(%rip), %xmm0
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, 80028(%rbp)
.L74:
	vmovss	.LC40(%rip), %xmm0
	vcomiss	80028(%rbp), %xmm0
	ja	.L75
	leaq	.LC41(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	79920(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 80016(%rbp)
	movl	$0, 80012(%rbp)
	jmp	.L76
.L84:
	movl	$0, 80008(%rbp)
	jmp	.L77
.L83:
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 80000(%rbp)
	movl	$0, 79996(%rbp)
	jmp	.L78
.L82:
	movl	80008(%rbp), %edx
	movl	80012(%rbp), %eax
	addl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1759218605, %rax, %rax
	shrq	$32, %rax
	sarl	$12, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$10000, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	cltq
	vmovss	-96(%rbp,%rax,4), %xmm1
	vmovss	.LC43(%rip), %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vcvtsi2ssl	79996(%rbp), %xmm1, %xmm1
	vsubss	%xmm1, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 79952(%rbp)
	vxorpd	%xmm0, %xmm0, %xmm0
	vucomisd	79952(%rbp), %xmm0
	jp	.L94
	vxorpd	%xmm0, %xmm0, %xmm0
	vucomisd	79952(%rbp), %xmm0
	je	.L79
.L94:
	vmovsd	79952(%rbp), %xmm1
	vmovsd	.LC0(%rip), %xmm0
	vmulsd	%xmm0, %xmm1, %xmm3
	vmovq	%xmm3, %rax
	vmovq	%rax, %xmm0
	call	fastSinD
	vmovq	%xmm0, %rax
	vmovsd	79952(%rbp), %xmm1
	vmovsd	.LC0(%rip), %xmm0
	vmulsd	%xmm0, %xmm1, %xmm0
	vmovq	%rax, %xmm4
	vdivsd	%xmm0, %xmm4, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	jmp	.L81
.L79:
	vmovss	.LC44(%rip), %xmm0
.L81:
	vmovss	%xmm0, 79948(%rbp)
	movl	79996(%rbp), %eax
	imull	80008(%rbp), %eax
	movl	80012(%rbp), %edx
	addl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1759218605, %rax, %rax
	shrq	$32, %rax
	sarl	$12, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$10000, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	cltq
	movl	39904(%rbp,%rax,4), %eax
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	vcvtss2sd	79948(%rbp), %xmm0, %xmm0
	vmulsd	%xmm0, %xmm1, %xmm0
	vmovsd	80000(%rbp), %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 80000(%rbp)
	incl	79996(%rbp)
.L78:
	cmpl	$4094, 79996(%rbp)
	jle	.L82
	vmovsd	80016(%rbp), %xmm0
	vaddsd	80000(%rbp), %xmm0, %xmm0
	vmovsd	%xmm0, 80016(%rbp)
	incl	80008(%rbp)
.L77:
	cmpl	$9999, 80008(%rbp)
	jle	.L83
	incl	80012(%rbp)
.L76:
	cmpl	$9, 80012(%rbp)
	jle	.L84
	vmovsd	80016(%rbp), %xmm0
	movq	80016(%rbp), %rax
	vmovsd	%xmm0, %xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC45(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	79904(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	movq	79904(%rbp), %rax
	movq	79920(%rbp), %rdx
	subq	%rdx, %rax
	imulq	$1000, %rax, %rcx
	movl	79912(%rbp), %eax
	movl	79928(%rbp), %edx
	subl	%edx, %eax
	movslq	%eax, %rdx
	imulq	$1125899907, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$18, %edx
	sarl	$31, %eax
	movl	%eax, %r8d
	movl	%edx, %eax
	subl	%r8d, %eax
	cltq
	addq	%rcx, %rax
	movq	%rax, %rdx
	leaq	.LC46(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	79920(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 80016(%rbp)
	movl	$0, 79992(%rbp)
	jmp	.L85
.L93:
	movl	$0, 79988(%rbp)
	jmp	.L86
.L92:
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovsd	%xmm0, 79976(%rbp)
	movl	$0, 79972(%rbp)
	jmp	.L87
.L91:
	movl	79988(%rbp), %edx
	movl	79992(%rbp), %eax
	addl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1759218605, %rax, %rax
	shrq	$32, %rax
	sarl	$12, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$10000, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	cltq
	vmovss	-96(%rbp,%rax,4), %xmm1
	vmovss	.LC43(%rip), %xmm0
	vmulss	%xmm0, %xmm1, %xmm0
	vcvtsi2ssl	79972(%rbp), %xmm1, %xmm1
	vsubss	%xmm1, %xmm0, %xmm0
	vmovss	%xmm0, 79968(%rbp)
	vxorps	%xmm0, %xmm0, %xmm0
	vucomiss	79968(%rbp), %xmm0
	jp	.L95
	vxorps	%xmm0, %xmm0, %xmm0
	vucomiss	79968(%rbp), %xmm0
	je	.L88
.L95:
	vcvtss2sd	79968(%rbp), %xmm0, %xmm0
	vmovsd	.LC0(%rip), %xmm1
	vmulsd	%xmm1, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm5
	vmovd	%xmm5, %eax
	vmovd	%eax, %xmm0
	call	fastSinF
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vcvtss2sd	79968(%rbp), %xmm1, %xmm1
	vmovsd	.LC0(%rip), %xmm2
	vmulsd	%xmm2, %xmm1, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	jmp	.L90
.L88:
	vmovss	.LC44(%rip), %xmm0
.L90:
	vmovss	%xmm0, 79964(%rbp)
	movl	79972(%rbp), %eax
	imull	79988(%rbp), %eax
	movl	79992(%rbp), %edx
	addl	%eax, %edx
	movslq	%edx, %rax
	imulq	$1759218605, %rax, %rax
	shrq	$32, %rax
	sarl	$12, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	imull	$10000, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	cltq
	movl	39904(%rbp,%rax,4), %eax
	vcvtsi2ssl	%eax, %xmm0, %xmm0
	vmulss	79964(%rbp), %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmovsd	79976(%rbp), %xmm1
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, 79976(%rbp)
	incl	79972(%rbp)
.L87:
	cmpl	$4094, 79972(%rbp)
	jle	.L91
	vmovsd	80016(%rbp), %xmm0
	vaddsd	79976(%rbp), %xmm0, %xmm0
	vmovsd	%xmm0, 80016(%rbp)
	incl	79988(%rbp)
.L86:
	cmpl	$9999, 79988(%rbp)
	jle	.L92
	incl	79992(%rbp)
.L85:
	cmpl	$9, 79992(%rbp)
	jle	.L93
	vmovsd	80016(%rbp), %xmm0
	movq	80016(%rbp), %rax
	vmovsd	%xmm0, %xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC45(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	79904(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	movq	79904(%rbp), %rax
	movq	79920(%rbp), %rdx
	subq	%rdx, %rax
	imulq	$1000, %rax, %rcx
	movl	79912(%rbp), %eax
	movl	79928(%rbp), %edx
	subl	%edx, %eax
	movslq	%eax, %rdx
	imulq	$1125899907, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$18, %edx
	sarl	$31, %eax
	movl	%eax, %r8d
	movl	%edx, %eax
	subl	%r8d, %eax
	cltq
	addq	%rcx, %rax
	movq	%rax, %rdx
	leaq	.LC48(%rip), %rax
	movq	%rax, %rcx
	call	printf
	nop
	addq	$80176, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	benchmarkFastSin
	.def	benchmarkFastSin;	.scl	2;	.type	32;	.endef
	.seh_proc	benchmarkFastSin
benchmarkFastSin:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	addq	$-128, %rsp
	.seh_stackalloc	128
	.seh_endprologue
	leaq	.LC34(%rip), %rax
	movq	%rax, %rcx
	call	printf
	vmovsd	.LC35(%rip), %xmm0
	vmovsd	%xmm0, -8(%rbp)
	jmp	.L97
.L98:
	movq	-8(%rbp), %rax
	vmovq	%rax, %xmm0
	call	fastSinD
	vmovq	%xmm0, %rax
	movq	%rax, -64(%rbp)
	vmovsd	-8(%rbp), %xmm1
	vmovsd	.LC36(%rip), %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -8(%rbp)
.L97:
	vmovsd	.LC37(%rip), %xmm0
	vcomisd	-8(%rbp), %xmm0
	ja	.L98
	vmovss	.LC38(%rip), %xmm0
	vmovss	%xmm0, -12(%rbp)
	jmp	.L99
.L100:
	movl	-12(%rbp), %eax
	vmovd	%eax, %xmm0
	call	fastSinF
	vmovd	%xmm0, %eax
	movl	%eax, -52(%rbp)
	vmovss	-12(%rbp), %xmm1
	vmovss	.LC39(%rip), %xmm0
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, -12(%rbp)
.L99:
	vmovss	.LC40(%rip), %xmm0
	vcomiss	-12(%rbp), %xmm0
	ja	.L100
	leaq	.LC41(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	-80(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	movl	$0, -16(%rbp)
	jmp	.L101
.L104:
	vmovsd	.LC35(%rip), %xmm0
	vmovsd	%xmm0, -24(%rbp)
	jmp	.L102
.L103:
	movq	-24(%rbp), %rax
	vmovq	%rax, %xmm0
	call	fastSinD
	vmovq	%xmm0, %rax
	movq	%rax, -48(%rbp)
	vmovsd	-24(%rbp), %xmm1
	vmovsd	.LC49(%rip), %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovsd	%xmm0, -24(%rbp)
.L102:
	vmovsd	.LC37(%rip), %xmm0
	vcomisd	-24(%rbp), %xmm0
	ja	.L103
	incl	-16(%rbp)
.L101:
	cmpl	$99, -16(%rbp)
	jle	.L104
	leaq	-96(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	movq	-96(%rbp), %rax
	movq	-80(%rbp), %rdx
	subq	%rdx, %rax
	imulq	$1000, %rax, %rcx
	movl	-88(%rbp), %eax
	movl	-72(%rbp), %edx
	subl	%edx, %eax
	movslq	%eax, %rdx
	imulq	$1125899907, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$18, %edx
	sarl	$31, %eax
	movl	%eax, %r8d
	movl	%edx, %eax
	subl	%r8d, %eax
	cltq
	addq	%rcx, %rax
	movq	%rax, %rdx
	leaq	.LC46(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	-80(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	movl	$0, -28(%rbp)
	jmp	.L105
.L108:
	vmovss	.LC38(%rip), %xmm0
	vmovss	%xmm0, -32(%rbp)
	jmp	.L106
.L107:
	movl	-32(%rbp), %eax
	vmovd	%eax, %xmm0
	call	fastSinF
	vmovd	%xmm0, %eax
	movl	%eax, -36(%rbp)
	vmovss	-32(%rbp), %xmm1
	vmovss	.LC50(%rip), %xmm0
	vaddss	%xmm0, %xmm1, %xmm0
	vmovss	%xmm0, -32(%rbp)
.L106:
	vmovss	.LC40(%rip), %xmm0
	vcomiss	-32(%rbp), %xmm0
	ja	.L107
	incl	-28(%rbp)
.L105:
	cmpl	$99, -28(%rbp)
	jle	.L108
	leaq	-96(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %ecx
	call	clock_gettime
	movq	-96(%rbp), %rax
	movq	-80(%rbp), %rdx
	subq	%rdx, %rax
	imulq	$1000, %rax, %rcx
	movl	-88(%rbp), %eax
	movl	-72(%rbp), %edx
	subl	%edx, %eax
	movslq	%eax, %rdx
	imulq	$1125899907, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$18, %edx
	sarl	$31, %eax
	movl	%eax, %r8d
	movl	%edx, %eax
	subl	%r8d, %eax
	cltq
	addq	%rcx, %rax
	movq	%rax, %rdx
	leaq	.LC48(%rip), %rax
	movq	%rax, %rcx
	call	printf
	nop
	subq	$-128, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	call	GEN_TRIG_TABLE
	call	testChebSIMD
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	1413754136
	.long	1074340347
	.align 8
.LC1:
	.long	0
	.long	1082130432
	.align 8
.LC2:
	.long	1841940611
	.long	1079271216
	.align 8
.LC3:
	.long	1413754136
	.long	1065951739
	.align 8
.LC4:
	.long	0
	.long	1071644672
	.align 4
.LC5:
	.long	1078530011
	.align 4
.LC6:
	.long	1132462080
	.align 4
.LC7:
	.long	1140850688
	.align 4
.LC8:
	.long	1056964608
	.align 4
.LC9:
	.long	-1073741824
	.align 4
.LC10:
	.long	-1090519040
	.align 4
.LC11:
	.long	-1279541970
	.align 8
.LC12:
	.long	1413754136
	.long	1075388923
	.align 4
.LC13:
	.long	789717965
	.align 4
.LC14:
	.long	-1295496101
	.align 4
.LC15:
	.long	908674213
	.align 4
.LC16:
	.long	-1187647768
	.align 4
.LC17:
	.long	1004073975
	.align 4
.LC18:
	.long	-1110474373
	.align 8
.LC19:
	.long	-1073741824
	.long	-1061976116
	.align 8
.LC20:
	.long	-350469331
	.long	1061828322
	.align 8
.LC21:
	.long	-1917273401
	.long	1061613574
	.align 8
.LC22:
	.long	810889825
	.long	1061398826
	.align 8
.LC23:
	.long	-755914244
	.long	1061184077
	.align 8
.LC24:
	.long	-350469331
	.long	1060779746
	.align 8
.LC25:
	.long	810889825
	.long	1060350250
	.align 8
.LC26:
	.long	-350469331
	.long	1059731170
	.align 8
.LC27:
	.long	-350469331
	.long	1058682594
	.align 16
.LC28:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC29:
	.long	-755914244
	.long	1062232653
	.align 8
.LC31:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC32:
	.long	0
	.long	1085507584
	.align 4
.LC33:
	.long	1148846080
	.align 8
.LC35:
	.long	0
	.long	-1059238912
	.align 8
.LC36:
	.long	-1864771721
	.long	1062233727
	.align 8
.LC37:
	.long	0
	.long	1088244736
	.align 4
.LC38:
	.long	-957718528
	.align 4
.LC39:
	.long	981677053
	.align 4
.LC40:
	.long	1189765120
	.align 4
.LC43:
	.long	1092616192
	.align 4
.LC44:
	.long	1065353216
	.align 8
.LC49:
	.long	1964002645
	.long	1065648159
	.align 4
.LC50:
	.long	1008992508
	.ident	"GCC: (Rev1, Built by MSYS2 project) 11.2.0"
	.def	sin;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	clock_gettime;	.scl	2;	.type	32;	.endef
