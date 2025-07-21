	.file	"interp.c"
	.text
	.p2align 4
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	leaq	88(%rsp), %rbx
	movq	%rcx, %r12
	movq	%rdx, 88(%rsp)
	movq	%r8, 96(%rsp)
	movq	%r9, 104(%rsp)
	movq	%rbx, 40(%rsp)
	movl	$1, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movq	%rax, %rcx
	movq	%rbx, %r8
	movq	%r12, %rdx
	call	__mingw_vfprintf
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	ret
	.seh_endproc
	.p2align 4
	.globl	_fastSincInterp
	.def	_fastSincInterp;	.scl	2;	.type	32;	.endef
	.seh_proc	_fastSincInterp
_fastSincInterp:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$296, %rsp
	.seh_stackalloc	296
	vmovaps	%xmm6, 128(%rsp)
	.seh_savexmm	%xmm6, 128
	vmovaps	%xmm7, 144(%rsp)
	.seh_savexmm	%xmm7, 144
	vmovaps	%xmm8, 160(%rsp)
	.seh_savexmm	%xmm8, 160
	vmovaps	%xmm9, 176(%rsp)
	.seh_savexmm	%xmm9, 176
	vmovaps	%xmm10, 192(%rsp)
	.seh_savexmm	%xmm10, 192
	vmovaps	%xmm11, 208(%rsp)
	.seh_savexmm	%xmm11, 208
	vmovaps	%xmm12, 224(%rsp)
	.seh_savexmm	%xmm12, 224
	vmovaps	%xmm13, 240(%rsp)
	.seh_savexmm	%xmm13, 240
	vmovaps	%xmm14, 256(%rsp)
	.seh_savexmm	%xmm14, 256
	vmovaps	%xmm15, 272(%rsp)
	.seh_savexmm	%xmm15, 272
	.seh_endprologue
	movl	52(%rcx), %ebp
	movl	56(%rcx), %eax
	movq	(%rcx), %r9
	movslq	8(%rcx), %r12
	movl	12(%rcx), %edx
	movq	24(%rcx), %r10
	movl	32(%rcx), %r8d
	movq	40(%rcx), %rbx
	movl	48(%rcx), %esi
	cmpl	%ebp, %eax
	jle	.L12
	vmovaps	.LC3(%rip), %ymm10
	vmovdqa	.LC9(%rip), %ymm9
	movslq	%edx, %rdi
	decl	%eax
	imull	%ebp, %edx
	movslq	%ebp, %rcx
	subl	%ebp, %eax
	movl	%esi, %r11d
	shrl	$31, %r11d
	vxorps	%xmm0, %xmm0, %xmm0
	addq	%rcx, %rax
	vxorps	%xmm7, %xmm7, %xmm7
	vcvtsi2sdl	%r8d, %xmm0, %xmm0
	addl	%esi, %r11d
	leaq	(%rbx,%rcx,8), %r8
	leaq	8(%rbx,%rax,8), %rbp
	movslq	%edx, %rdx
	leal	-1(%rsi), %ebx
	sarl	%r11d
	vmovq	%xmm0, %r13
	addq	%r12, %rdx
	shrl	$3, %ebx
	negl	%r11d
	salq	$2, %rdi
	leaq	(%r9,%rdx,4), %r9
	salq	$3, %rbx
	vcmpps	$0, %ymm7, %ymm7, %ymm11
	.p2align 4
	.p2align 3
.L7:
	vmovq	%r13, %xmm7
	vmulsd	(%r8), %xmm7, %xmm7
	vcvttsd2sil	%xmm7, %eax
	leal	(%r11,%rax), %edx
	vbroadcastsd	%xmm7, %ymm7
	vmovd	%edx, %xmm4
	vpbroadcastd	%xmm4, %ymm4
	vpaddd	.LC2(%rip), %ymm4, %ymm4
	testl	%esi, %esi
	jle	.L9
	vbroadcastss	12+bessel_table(%rip), %ymm5
	vbroadcastss	16+bessel_table(%rip), %ymm13
	movslq	%eax, %rdx
	vxorpd	%xmm12, %xmm12, %xmm12
	vmovdqa	.LC11(%rip), %ymm8
	leaq	(%r10,%rdx,4), %rax
	addq	%rbx, %rdx
	leaq	f_sineTable_4q(%rip), %rcx
	leaq	32(%r10,%rdx,4), %r12
	vmovups	%ymm5, (%rsp)
	vbroadcastss	8+bessel_table(%rip), %ymm5
	vmovups	%ymm5, 32(%rsp)
	vbroadcastss	4+bessel_table(%rip), %ymm5
	vmovups	%ymm5, 64(%rsp)
	vbroadcastss	bessel_table(%rip), %ymm5
	vmovups	%ymm5, 96(%rsp)
	.p2align 4
	.p2align 3
.L6:
	vextracti128	$0x1, %ymm4, %xmm1
	vcvtdq2pd	%xmm4, %ymm0
	vmovups	(%rsp), %ymm2
	vxorps	%xmm6, %xmm6, %xmm6
	vcvtdq2pd	%xmm1, %ymm1
	addq	$32, %rax
	vpaddd	%ymm4, %ymm8, %ymm4
	vmovaps	%ymm11, %ymm15
	vsubpd	%ymm0, %ymm7, %ymm0
	vsubpd	%ymm1, %ymm7, %ymm1
	vcvtpd2psy	%ymm0, %xmm0
	vcvtpd2psy	%ymm1, %xmm1
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0
	vmulps	%ymm0, %ymm0, %ymm1
	vmulps	.LC5(%rip), %ymm0, %ymm0
	vsubps	%ymm1, %ymm10, %ymm1
	vmulps	.LC4(%rip), %ymm1, %ymm1
	vcmpps	$0, %ymm6, %ymm0, %ymm14
	vfmadd231ps	%ymm13, %ymm1, %ymm2
	vfmadd213ps	32(%rsp), %ymm1, %ymm2
	vfmadd213ps	64(%rsp), %ymm1, %ymm2
	vfmadd213ps	96(%rsp), %ymm2, %ymm1
	vmulps	.LC6(%rip), %ymm0, %ymm2
	vcvtps2dq	%ymm2, %ymm2
	vpaddq	.LC8(%rip), %ymm2, %ymm5
	vcvtdq2ps	%ymm2, %ymm3
	vpand	%ymm2, %ymm9, %ymm2
	vfmadd132ps	.LC7(%rip), %ymm0, %ymm3
	vgatherdps	%ymm15, (%rcx,%ymm2,4), %ymm6
	vmovaps	%ymm11, %ymm15
	vpand	%ymm9, %ymm5, %ymm2
	vgatherdps	%ymm15, (%rcx,%ymm2,4), %ymm5
	vmulps	.LC10(%rip), %ymm6, %ymm2
	vfmadd132ps	%ymm3, %ymm5, %ymm2
	vfmadd132ps	%ymm3, %ymm6, %ymm2
	vdivps	%ymm0, %ymm2, %ymm0
	vmulps	%ymm1, %ymm0, %ymm0
	vmulps	-32(%rax), %ymm0, %ymm0
	vblendvps	%ymm14, -32(%rax), %ymm0, %ymm0
	vextractf128	$0x1, %ymm0, %xmm1
	vaddps	%xmm0, %xmm1, %xmm0
	vmovhlps	%xmm0, %xmm0, %xmm1
	vaddps	%xmm1, %xmm0, %xmm0
	vshufps	$1, %xmm0, %xmm0, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm12, %xmm12
	cmpq	%rax, %r12
	jne	.L6
	vcvtsd2ss	%xmm12, %xmm12, %xmm0
.L5:
	addq	$8, %r8
	vmovss	%xmm0, (%r9)
	addq	%rdi, %r9
	cmpq	%r8, %rbp
	jne	.L7
	vzeroupper
.L12:
	vmovaps	128(%rsp), %xmm6
	vmovaps	144(%rsp), %xmm7
	vmovaps	160(%rsp), %xmm8
	vmovaps	176(%rsp), %xmm9
	vmovaps	192(%rsp), %xmm10
	vmovaps	208(%rsp), %xmm11
	vmovaps	224(%rsp), %xmm12
	vmovaps	240(%rsp), %xmm13
	vmovaps	256(%rsp), %xmm14
	vmovaps	272(%rsp), %xmm15
	addq	$296, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L9:
	vxorps	%xmm0, %xmm0, %xmm0
	jmp	.L5
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
	vmovsd	.LC12(%rip), %xmm7
	vmovsd	.LC13(%rip), %xmm6
	vxorps	%xmm8, %xmm8, %xmm8
	movq	$0x000000000, sineTable_4q(%rip)
	movl	$0x00000000, f_sineTable_4q(%rip)
	movl	$1, %edi
	leaq	sineTable_4q(%rip), %rsi
	leaq	f_sineTable_4q(%rip), %rbx
	.p2align 4
	.p2align 3
.L14:
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
	jne	.L14
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
	vmulsd	.LC14(%rip), %xmm0, %xmm1
	leaq	sineTable_4q(%rip), %rcx
	vcvttsd2sil	%xmm1, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	leal	128(%rax), %edx
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	vmulsd	.LC15(%rip), %xmm1, %xmm1
	andl	$511, %eax
	vmovsd	(%rcx,%rax,8), %xmm3
	movl	%edx, %eax
	vmulsd	.LC16(%rip), %xmm3, %xmm2
	andl	$511, %eax
	vsubsd	%xmm1, %xmm0, %xmm1
	vmovsd	(%rcx,%rax,8), %xmm0
	vmulsd	%xmm1, %xmm2, %xmm2
	vsubsd	%xmm2, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	%xmm3, %xmm0, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	fastSinF
	.def	fastSinF;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinF
fastSinF:
	.seh_endprologue
	vmulss	.LC17(%rip), %xmm0, %xmm1
	leaq	f_sineTable_4q(%rip), %rcx
	vcvttss2sil	%xmm1, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	leal	128(%rax), %edx
	vcvtsi2ssl	%eax, %xmm1, %xmm1
	vmulss	.LC18(%rip), %xmm1, %xmm1
	andl	$511, %eax
	vmovss	(%rcx,%rax,4), %xmm3
	movl	%edx, %eax
	vmulss	.LC19(%rip), %xmm3, %xmm2
	andl	$511, %eax
	vsubss	%xmm1, %xmm0, %xmm1
	vmovss	(%rcx,%rax,4), %xmm0
	vmulss	%xmm1, %xmm2, %xmm2
	vsubss	%xmm2, %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	vaddss	%xmm3, %xmm0, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	fastSinSIMD_d
	.def	fastSinSIMD_d;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSinSIMD_d
fastSinSIMD_d:
	subq	$24, %rsp
	.seh_stackalloc	24
	vmovaps	%xmm6, (%rsp)
	.seh_savexmm	%xmm6, 0
	.seh_endprologue
	vmovapd	(%rcx), %ymm2
	vmovdqa	.LC9(%rip), %ymm5
	leaq	sineTable_4q(%rip), %rax
	vmulpd	.LC20(%rip), %ymm2, %ymm0
	vcvtpd2dqy	%ymm0, %xmm0
	vmovdqa	%xmm0, %xmm1
	vpaddq	.LC8(%rip), %ymm1, %ymm3
	vcvtdq2pd	%xmm0, %ymm0
	vfmadd132pd	.LC21(%rip), %ymm2, %ymm0
	vpand	%ymm1, %ymm5, %ymm1
	vmovdqa	%xmm1, %xmm2
	vxorpd	%xmm1, %xmm1, %xmm1
	vcmppd	$0, %ymm1, %ymm1, %ymm1
	vmovapd	%ymm1, %ymm6
	vgatherdpd	%ymm6, (%rax,%xmm2,8), %ymm4
	vpand	%ymm5, %ymm3, %ymm2
	vgatherdpd	%ymm1, (%rax,%xmm2,8), %ymm3
	vmulpd	.LC22(%rip), %ymm4, %ymm1
	vfmadd132pd	%ymm0, %ymm3, %ymm1
	vfmadd132pd	%ymm1, %ymm4, %ymm0
	vmovapd	%ymm0, (%rdx)
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
	vmovss	.LC23(%rip), %xmm2
	vmovss	.LC31(%rip), %xmm4
	vdivss	%xmm2, %xmm0, %xmm1
	vcvttss2sil	%xmm1, %eax
	movl	%eax, %edx
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	notl	%edx
	shrl	$31, %edx
	andl	%eax, %edx
	incl	%edx
	sarx	%edx, %eax, %eax
	negl	%eax
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	vmulsd	.LC24(%rip), %xmm1, %xmm1
	vaddsd	%xmm0, %xmm1, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm3
	vmulss	.LC25(%rip), %xmm3, %xmm0
	vsubss	.LC26(%rip), %xmm0, %xmm0
	vmulss	%xmm3, %xmm0, %xmm0
	vaddss	.LC27(%rip), %xmm0, %xmm0
	vmulss	%xmm3, %xmm0, %xmm0
	vsubss	.LC28(%rip), %xmm0, %xmm0
	vmulss	%xmm3, %xmm0, %xmm0
	vaddss	.LC29(%rip), %xmm0, %xmm0
	vmulss	%xmm3, %xmm0, %xmm0
	vsubss	.LC30(%rip), %xmm0, %xmm0
	vsubss	%xmm2, %xmm1, %xmm3
	vaddss	%xmm2, %xmm1, %xmm2
	vaddss	%xmm4, %xmm3, %xmm3
	vsubss	%xmm4, %xmm2, %xmm2
	vmulss	%xmm2, %xmm3, %xmm2
	vmulss	%xmm2, %xmm0, %xmm0
	vmulss	%xmm1, %xmm0, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	chebSinSIMD
	.def	chebSinSIMD;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSinSIMD
chebSinSIMD:
	.seh_endprologue
	vmovaps	.LC5(%rip), %ymm3
	vmovaps	(%rcx), %ymm2
	vpcmpeqd	%ymm1, %ymm1, %ymm1
	vdivps	%ymm3, %ymm2, %ymm0
	vcvtps2dq	%ymm0, %ymm0
	vpxor	%ymm0, %ymm1, %ymm1
	vpsrad	$1, %ymm0, %ymm4
	vpsrld	$31, %ymm1, %ymm1
	vpand	%ymm1, %ymm0, %ymm0
	vpaddq	%ymm4, %ymm0, %ymm0
	vcvtdq2ps	%ymm0, %ymm0
	vfmadd132ps	.LC32(%rip), %ymm2, %ymm0
	vmovaps	.LC33(%rip), %ymm2
	vmulps	%ymm0, %ymm0, %ymm1
	vfmadd213ps	.LC34(%rip), %ymm1, %ymm2
	vaddps	%ymm3, %ymm0, %ymm3
	vaddps	.LC41(%rip), %ymm3, %ymm3
	vfmadd213ps	.LC35(%rip), %ymm1, %ymm2
	vfmadd213ps	.LC36(%rip), %ymm1, %ymm2
	vfmadd213ps	.LC37(%rip), %ymm1, %ymm2
	vfmadd213ps	.LC38(%rip), %ymm1, %ymm2
	vaddps	.LC39(%rip), %ymm0, %ymm1
	vaddps	.LC40(%rip), %ymm1, %ymm1
	vmulps	%ymm3, %ymm1, %ymm1
	vmulps	%ymm2, %ymm1, %ymm1
	vmulps	%ymm0, %ymm1, %ymm0
	vmovaps	%ymm0, (%rdx)
	vzeroupper
	ret
	.seh_endproc
	.p2align 4
	.globl	sum4
	.def	sum4;	.scl	2;	.type	32;	.endef
	.seh_proc	sum4
sum4:
	.seh_endprologue
	vmovapd	(%rcx), %ymm1
	vmovapd	%xmm1, %xmm0
	vextractf128	$0x1, %ymm1, %xmm1
	vaddpd	%xmm1, %xmm0, %xmm0
	vunpckhpd	%xmm0, %xmm0, %xmm1
	vaddsd	%xmm1, %xmm0, %xmm0
	vzeroupper
	ret
	.seh_endproc
	.p2align 4
	.globl	bessel0
	.def	bessel0;	.scl	2;	.type	32;	.endef
	.seh_proc	bessel0
bessel0:
	.seh_endprologue
	vmulsd	%xmm0, %xmm0, %xmm1
	vmulsd	.LC42(%rip), %xmm1, %xmm0
	vaddsd	.LC43(%rip), %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	.LC44(%rip), %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	.LC45(%rip), %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	.LC46(%rip), %xmm0, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	GEN_BESSEL_TABLE
	.def	GEN_BESSEL_TABLE;	.scl	2;	.type	32;	.endef
	.seh_proc	GEN_BESSEL_TABLE
GEN_BESSEL_TABLE:
	.seh_endprologue
	vmovaps	.LC47(%rip), %xmm0
	movl	$0x2fa0e3c6, 16+bessel_table(%rip)
	vmovaps	%xmm0, bessel_table(%rip)
	ret
	.seh_endproc
	.p2align 4
	.globl	fastBessel0_bakedDiv
	.def	fastBessel0_bakedDiv;	.scl	2;	.type	32;	.endef
	.seh_proc	fastBessel0_bakedDiv
fastBessel0_bakedDiv:
	.seh_endprologue
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtss2sd	16+bessel_table(%rip), %xmm1, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm2, %xmm3
	vcvtss2sd	12+bessel_table(%rip), %xmm1, %xmm2
	vaddsd	%xmm3, %xmm2, %xmm3
	vcvtss2sd	8+bessel_table(%rip), %xmm1, %xmm2
	vmulsd	%xmm0, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm3
	vcvtss2sd	4+bessel_table(%rip), %xmm1, %xmm2
	vcvtss2sd	bessel_table(%rip), %xmm1, %xmm1
	vmulsd	%xmm0, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm2
	vmulsd	%xmm0, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	ret
	.seh_endproc
	.p2align 4
	.globl	fastKaiser
	.def	fastKaiser;	.scl	2;	.type	32;	.endef
	.seh_proc	fastKaiser
fastKaiser:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	vmovsd	.LC49(%rip), %xmm1
	vmulsd	%xmm0, %xmm0, %xmm0
	vsubsd	%xmm0, %xmm1, %xmm0
	vxorpd	%xmm1, %xmm1, %xmm1
	vucomisd	%xmm0, %xmm1
	ja	.L30
	vsqrtsd	%xmm0, %xmm0, %xmm0
.L28:
	vmulsd	.LC50(%rip), %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtss2sd	16+bessel_table(%rip), %xmm1, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm0, %xmm2, %xmm3
	vcvtss2sd	12+bessel_table(%rip), %xmm1, %xmm2
	vaddsd	%xmm3, %xmm2, %xmm3
	vcvtss2sd	8+bessel_table(%rip), %xmm1, %xmm2
	vmulsd	%xmm0, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm3
	vcvtss2sd	4+bessel_table(%rip), %xmm1, %xmm2
	vcvtss2sd	bessel_table(%rip), %xmm1, %xmm1
	vmulsd	%xmm0, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm2, %xmm2
	vmulsd	%xmm0, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm0
	addq	$40, %rsp
	ret
.L30:
	call	sqrt
	jmp	.L28
	.seh_endproc
	.p2align 4
	.globl	writeID
	.def	writeID;	.scl	2;	.type	32;	.endef
	.seh_proc	writeID
writeID:
	.seh_endprologue
	movzbl	(%rdx), %eax
	movb	%al, (%rcx)
	movzbl	1(%rdx), %eax
	movb	%al, 1(%rcx)
	movzbl	2(%rdx), %eax
	movb	%al, 2(%rcx)
	movzbl	3(%rdx), %eax
	movb	%al, 3(%rcx)
	ret
	.seh_endproc
	.p2align 4
	.globl	getDataEntriesCount
	.def	getDataEntriesCount;	.scl	2;	.type	32;	.endef
	.seh_proc	getDataEntriesCount
getDataEntriesCount:
	.seh_endprologue
	movzwl	34(%rcx), %r8d
	movl	40(%rcx), %eax
	xorl	%edx, %edx
	shrw	$3, %r8w
	movzwl	%r8w, %r8d
	divl	%r8d
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC51:
	.ascii "RIFF\0"
	.align 8
.LC52:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC53:
	.ascii "WAVE\0"
	.align 8
.LC54:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC55:
	.ascii "fmt \0"
	.align 8
.LC56:
	.ascii "Format chunk \"%.4s\" should be \"fmt \" instead.\12\0"
	.align 8
.LC57:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC58:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC59:
	.ascii "Bit depth %d must be one of 16, 24, or 32.\12\0"
	.text
	.p2align 4
	.globl	verifyWavInfo
	.def	verifyWavInfo;	.scl	2;	.type	32;	.endef
	.seh_proc	verifyWavInfo
verifyWavInfo:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$4, %r8d
	leaq	.LC51(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L47
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC53(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L48
	leaq	12(%r12), %r13
	movl	$4, %r8d
	leaq	.LC55(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L49
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L50
	cmpw	$1, 20(%r12)
	jne	.L51
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L40
	cmpw	$32, %dx
	jne	.L52
.L40:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L47:
	movq	%r12, %rdx
	leaq	.LC52(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L33:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L50:
	leaq	.LC57(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L48:
	movq	%r13, %rdx
	leaq	.LC54(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L49:
	movq	%r13, %rdx
	leaq	.LC56(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L51:
	leaq	.LC58(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L52:
	leaq	.LC59(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L33
	.seh_endproc
	.section .rdata,"dr"
.LC60:
	.ascii "data\0"
	.text
	.p2align 4
	.globl	readWavInfo
	.def	readWavInfo;	.scl	2;	.type	32;	.endef
	.seh_proc	readWavInfo
readWavInfo:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$104, %rsp
	.seh_stackalloc	104
	.seh_endprologue
	movl	$1, %r8d
	leaq	.LC55(%rip), %rdi
	movq	%rdx, %r9
	movq	%rdx, %rbx
	movq	%rcx, %r12
	movl	$8, %edx
	leaq	48(%rsp), %rcx
	leaq	40(%rsp), %rsi
	call	fread
	leaq	56(%rsp), %rcx
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$4, %edx
	call	fread
	jmp	.L54
	.p2align 4
	.p2align 3
.L57:
	movl	$4, %r8d
	movq	%rdi, %rdx
	movq	%rsi, %rcx
	call	strncmp
	testl	%eax, %eax
	je	.L62
	movl	44(%rsp), %edx
	movl	$1, %r8d
	movq	%rbx, %rcx
	call	fseek
.L54:
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$8, %edx
	movq	%rsi, %rcx
	call	fread
	testq	%rax, %rax
	jne	.L57
.L56:
	leaq	68(%rsp), %rcx
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$16, %edx
	call	fread
	leaq	.LC60(%rip), %rdi
	jmp	.L58
	.p2align 4
	.p2align 3
.L61:
	movl	$4, %r8d
	movq	%rdi, %rdx
	movq	%rsi, %rcx
	call	strncmp
	testl	%eax, %eax
	je	.L63
	movl	44(%rsp), %edx
	movl	$1, %r8d
	movq	%rbx, %rcx
	call	fseek
.L58:
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$8, %edx
	movq	%rsi, %rcx
	call	fread
	testq	%rax, %rax
	jne	.L61
.L60:
	movq	80(%rsp), %rax
	vmovdqa	48(%rsp), %xmm0
	vmovdqa	64(%rsp), %xmm1
	movq	%rax, 32(%r12)
	movl	88(%rsp), %eax
	movl	%eax, 40(%r12)
	movq	%r12, %rax
	vmovdqu	%xmm0, (%r12)
	vmovdqu	%xmm1, 16(%r12)
	addq	$104, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	ret
	.p2align 4
	.p2align 3
.L62:
	movq	40(%rsp), %rax
	movq	%rax, 60(%rsp)
	jmp	.L56
	.p2align 4
	.p2align 3
.L63:
	movq	40(%rsp), %rax
	movq	%rax, 84(%rsp)
	jmp	.L60
	.seh_endproc
	.section .rdata,"dr"
.LC61:
	.ascii "Read all %d values...\12\0"
.LC62:
	.ascii "Bit depth %d not supported.\12\0"
	.text
	.p2align 4
	.globl	readWavData
	.def	readWavData;	.scl	2;	.type	32;	.endef
	.seh_proc	readWavData
readWavData:
	pushq	%r14
	.seh_pushreg	%r14
	movl	$8240, %eax
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	8240
	vmovaps	%xmm6, 8224(%rsp)
	.seh_savexmm	%xmm6, 8224
	.seh_endprologue
	movzwl	34(%r8), %r9d
	movl	40(%r8), %eax
	vxorps	%xmm6, %xmm6, %xmm6
	movq	%rcx, %rbx
	movl	%r9d, %ecx
	movq	%rdx, %rsi
	xorl	%edx, %edx
	shrw	$3, %cx
	movzwl	%cx, %ecx
	divl	%ecx
	movl	%eax, %r12d
	cmpw	$32, %r9w
	je	.L96
	cmpw	$24, %r9w
	je	.L97
	cmpw	$16, %r9w
	jne	.L78
	testl	%eax, %eax
	jle	.L79
	xorl	%ebp, %ebp
	leaq	32(%rsp), %r14
	.p2align 4
	.p2align 3
.L85:
	movl	%r12d, %edi
	movl	$2048, %eax
	movq	%rsi, %r9
	movl	$2, %edx
	subl	%ebp, %edi
	movq	%r14, %rcx
	cmpl	%eax, %edi
	cmovg	%eax, %edi
	movslq	%edi, %r8
	call	fread
	leal	-1(%rdi), %eax
	cmpl	$14, %eax
	jbe	.L87
	movl	%edi, %ecx
	movslq	%ebp, %rax
	shrl	$4, %ecx
	leaq	(%rbx,%rax,4), %rdx
	xorl	%eax, %eax
	salq	$5, %rcx
	.p2align 4
	.p2align 3
.L81:
	vpmovsxwd	(%r14,%rax), %ymm0
	vmovdqu	(%r14,%rax), %ymm2
	vcvtdq2ps	%ymm0, %ymm0
	vmovups	%ymm0, (%rdx,%rax,2)
	vextracti128	$0x1, %ymm2, %xmm0
	vpmovsxwd	%xmm0, %ymm0
	vcvtdq2ps	%ymm0, %ymm0
	vmovups	%ymm0, 32(%rdx,%rax,2)
	addq	$32, %rax
	cmpq	%rcx, %rax
	jne	.L81
	movl	%edi, %edx
	andl	$-16, %edx
	movl	%edx, %eax
	cmpl	%edx, %edi
	je	.L98
	vzeroupper
.L80:
	movl	%edi, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$6, %ecx
	jbe	.L83
	vmovdqa	32(%rsp,%rdx,2), %xmm0
	movslq	%ebp, %rcx
	addq	%rdx, %rcx
	movl	%r8d, %edx
	leaq	(%rbx,%rcx,4), %rcx
	andl	$-8, %edx
	addl	%edx, %eax
	vpmovsxwd	%xmm0, %xmm1
	vpsrldq	$8, %xmm0, %xmm0
	vpmovsxwd	%xmm0, %xmm0
	vcvtdq2ps	%xmm1, %xmm1
	vcvtdq2ps	%xmm0, %xmm0
	vmovups	%xmm1, (%rcx)
	vmovups	%xmm0, 16(%rcx)
	cmpl	%edx, %r8d
	je	.L82
.L83:
	movslq	%eax, %rcx
	leal	0(%rbp,%rax), %edx
	movswl	32(%rsp,%rcx,2), %ecx
	movslq	%edx, %rdx
	vcvtsi2ssl	%ecx, %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edi, %edx
	jge	.L82
	leal	(%rdx,%rbp), %ecx
	movslq	%edx, %rdx
	movswl	32(%rsp,%rdx,2), %edx
	movslq	%ecx, %rcx
	vcvtsi2ssl	%edx, %xmm6, %xmm0
	leal	2(%rax), %edx
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%edx, %edi
	jle	.L82
	leal	0(%rbp,%rdx), %ecx
	movslq	%edx, %rdx
	movswl	32(%rsp,%rdx,2), %edx
	movslq	%ecx, %rcx
	vcvtsi2ssl	%edx, %xmm6, %xmm0
	leal	3(%rax), %edx
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%edx, %edi
	jle	.L82
	leal	(%rdx,%rbp), %ecx
	movslq	%edx, %rdx
	movswl	32(%rsp,%rdx,2), %edx
	movslq	%ecx, %rcx
	vcvtsi2ssl	%edx, %xmm6, %xmm0
	leal	4(%rax), %edx
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%edx, %edi
	jle	.L82
	leal	0(%rbp,%rdx), %ecx
	movslq	%edx, %rdx
	movswl	32(%rsp,%rdx,2), %edx
	movslq	%ecx, %rcx
	vcvtsi2ssl	%edx, %xmm6, %xmm0
	leal	5(%rax), %edx
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%edx, %edi
	jle	.L82
	leal	0(%rbp,%rdx), %ecx
	movslq	%edx, %rdx
	addl	$6, %eax
	movswl	32(%rsp,%rdx,2), %edx
	movslq	%ecx, %rcx
	vcvtsi2ssl	%edx, %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%eax, %edi
	jle	.L82
	leal	0(%rbp,%rax), %edx
	cltq
	movswl	32(%rsp,%rax,2), %eax
	movslq	%edx, %rdx
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
.L82:
	addl	%edi, %ebp
	cmpl	%r12d, %ebp
	jl	.L85
.L79:
	movl	%r12d, %edx
	leaq	.LC61(%rip), %rcx
	call	printf
	nop
.L73:
	vmovaps	8224(%rsp), %xmm6
	movl	$1, %eax
	addq	$8240, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L97:
	leal	(%rax,%rax,2), %edi
	testl	%edi, %edi
	jle	.L79
	xorl	%r13d, %r13d
	leaq	32(%rsp), %r14
	.p2align 4
	.p2align 3
.L77:
	movl	%edi, %ebp
	movl	$1536, %eax
	movq	%rsi, %r9
	movl	$1, %edx
	subl	%r13d, %ebp
	movq	%r14, %rcx
	cmpl	%eax, %ebp
	cmovg	%eax, %ebp
	movslq	%ebp, %r8
	call	fread
	movq	%r14, %rax
	xorl	%r8d, %r8d
	.p2align 4
	.p2align 3
.L76:
	movsbl	2(%rax), %edx
	movzbl	(%rax), %r9d
	leal	(%r8,%r13), %ecx
	addl	$3, %r8d
	addq	$3, %rax
	sall	$16, %edx
	orl	%edx, %r9d
	movslq	%ecx, %rdx
	sarl	$31, %ecx
	imulq	$1431655766, %rdx, %rdx
	shrq	$32, %rdx
	subl	%ecx, %edx
	movsbl	-2(%rax), %ecx
	movslq	%edx, %rdx
	sall	$8, %ecx
	movzwl	%cx, %ecx
	orl	%r9d, %ecx
	vcvtsi2ssl	%ecx, %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	cmpl	%r8d, %ebp
	jg	.L76
	addl	%ebp, %r13d
	cmpl	%r13d, %edi
	jg	.L77
	jmp	.L79
	.p2align 4
	.p2align 3
.L96:
	testl	%eax, %eax
	jle	.L79
	xorl	%ebp, %ebp
	leaq	32(%rsp), %r14
	.p2align 4
	.p2align 3
.L72:
	movl	%r12d, %edi
	movl	$2048, %eax
	movq	%rsi, %r9
	movl	$4, %edx
	subl	%ebp, %edi
	movq	%r14, %rcx
	cmpl	%eax, %edi
	cmovg	%eax, %edi
	movslq	%edi, %r8
	call	fread
	leal	-1(%rdi), %eax
	cmpl	$6, %eax
	jbe	.L86
	movl	%edi, %edx
	movslq	%ebp, %rax
	shrl	$3, %edx
	leaq	(%rbx,%rax,4), %rcx
	xorl	%eax, %eax
	salq	$5, %rdx
	.p2align 4
	.p2align 3
.L68:
	vcvtdq2ps	(%r14,%rax), %ymm0
	vmovups	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L68
	movl	%edi, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%edi, %edx
	je	.L99
	vzeroupper
.L67:
	movl	%edi, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$2, %ecx
	jbe	.L70
	vcvtdq2ps	32(%rsp,%rdx,4), %xmm0
	movslq	%ebp, %rcx
	addq	%rcx, %rdx
	vmovups	%xmm0, (%rbx,%rdx,4)
	movl	%r8d, %edx
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%r8d, %edx
	je	.L69
.L70:
	leal	0(%rbp,%rax), %edx
	movslq	%eax, %rcx
	movslq	%edx, %rdx
	vcvtsi2ssl	32(%rsp,%rcx,4), %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %edi
	jle	.L69
	leal	0(%rbp,%rdx), %ecx
	addl	$2, %eax
	movslq	%edx, %rdx
	movslq	%ecx, %rcx
	vcvtsi2ssl	32(%rsp,%rdx,4), %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rcx,4)
	cmpl	%edi, %eax
	jge	.L69
	leal	(%rax,%rbp), %edx
	cltq
	movslq	%edx, %rdx
	vcvtsi2ssl	32(%rsp,%rax,4), %xmm6, %xmm0
	vmovss	%xmm0, (%rbx,%rdx,4)
.L69:
	addl	%edi, %ebp
	cmpl	%r12d, %ebp
	jl	.L72
	jmp	.L79
	.p2align 4
	.p2align 3
.L99:
	vzeroupper
	jmp	.L69
	.p2align 4
	.p2align 3
.L86:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L67
.L78:
	movzwl	%r9w, %edx
	leaq	.LC62(%rip), %rcx
	call	printf
	jmp	.L73
.L87:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L80
.L98:
	vzeroupper
	jmp	.L82
	.seh_endproc
	.p2align 4
	.globl	writeHeader
	.def	writeHeader;	.scl	2;	.type	32;	.endef
	.seh_proc	writeHeader
writeHeader:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$80, %rsp
	.seh_stackalloc	80
	.seh_endprologue
	vmovdqu	(%rcx), %xmm0
	movq	%r8, %rbx
	leaq	72(%rsp), %rcx
	movq	%r8, %r9
	movl	$1, %r8d
	movl	$1635017060, 56(%rsp)
	movl	$1179011410, 72(%rsp)
	movl	$1163280727, 52(%rsp)
	vmovdqa	%xmm0, 32(%rsp)
	movzwl	46(%rsp), %eax
	shrw	$3, %ax
	movzwl	%ax, %eax
	imull	%edx, %eax
	movabsq	$69263977830, %rdx
	movq	%rdx, 64(%rsp)
	movl	$8, %edx
	movl	%eax, 60(%rsp)
	addl	$52, %eax
	movl	%eax, 76(%rsp)
	call	fwrite
	leaq	52(%rsp), %rcx
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$4, %edx
	call	fwrite
	leaq	64(%rsp), %rcx
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$8, %edx
	call	fwrite
	leaq	32(%rsp), %rcx
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$16, %edx
	call	fwrite
	leaq	56(%rsp), %rcx
	movq	%rbx, %r9
	movl	$1, %r8d
	movl	$8, %edx
	call	fwrite
	nop
	addq	$80, %rsp
	popq	%rbx
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC63:
	.ascii "wb\0"
.LC66:
	.ascii "Cannot write %d bit depth!\12\0"
	.text
	.p2align 4
	.def	writeWavfile.part.0;	.scl	3;	.type	32;	.endef
	.seh_proc	writeWavfile.part.0
writeWavfile.part.0:
	pushq	%r15
	.seh_pushreg	%r15
	movl	$8264, %eax
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	8264
	vmovaps	%xmm6, 8240(%rsp)
	.seh_savexmm	%xmm6, 8240
	.seh_endprologue
	movq	%rdx, %rsi
	leaq	.LC63(%rip), %rdx
	movl	%r9d, %edi
	movq	%r8, %r15
	call	fopen
	vmovdqu	20(%rsi), %xmm3
	leaq	32(%rsp), %rcx
	movl	%edi, %edx
	movq	%rax, %r8
	movq	%rax, %r12
	vmovdqa	%xmm3, 32(%rsp)
	call	writeHeader
	movzwl	34(%rsi), %eax
	cmpw	$32, %ax
	je	.L133
	cmpw	$24, %ax
	je	.L134
	cmpw	$16, %ax
	jne	.L115
	testl	%edi, %edi
	jle	.L110
	vmovdqa	.LC65(%rip), %xmm6
	vmovdqa	.LC64(%rip), %ymm2
	xorl	%ebp, %ebp
	leaq	48(%rsp), %r14
	.p2align 4
	.p2align 3
.L122:
	movl	%edi, %esi
	movl	$2048, %eax
	subl	%ebp, %esi
	cmpl	%eax, %esi
	cmovg	%eax, %esi
	leal	-1(%rsi), %eax
	cmpl	$14, %eax
	jbe	.L125
	movl	%esi, %ecx
	movslq	%ebp, %rax
	shrl	$4, %ecx
	leaq	(%r15,%rax,4), %rdx
	xorl	%eax, %eax
	salq	$5, %rcx
	.p2align 4
	.p2align 3
.L118:
	vcvttps2dq	(%rdx,%rax,2), %ymm0
	vcvttps2dq	32(%rdx,%rax,2), %ymm1
	vpand	%ymm0, %ymm2, %ymm0
	vpand	%ymm1, %ymm2, %ymm1
	vpackusdw	%ymm1, %ymm0, %ymm0
	vpermq	$216, %ymm0, %ymm0
	vmovdqu	%ymm0, (%r14,%rax)
	addq	$32, %rax
	cmpq	%rax, %rcx
	jne	.L118
	movl	%esi, %edx
	andl	$-16, %edx
	movl	%edx, %eax
	cmpl	%edx, %esi
	je	.L119
.L117:
	movl	%esi, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$6, %ecx
	jbe	.L120
	movslq	%ebp, %rcx
	addq	%rdx, %rcx
	leaq	(%r15,%rcx,4), %rcx
	vcvttps2dq	(%rcx), %xmm0
	vcvttps2dq	16(%rcx), %xmm1
	vpand	%xmm0, %xmm6, %xmm0
	vpand	%xmm1, %xmm6, %xmm1
	vpackusdw	%xmm1, %xmm0, %xmm0
	vmovdqa	%xmm0, 48(%rsp,%rdx,2)
	movl	%r8d, %edx
	andl	$-8, %edx
	addl	%edx, %eax
	cmpl	%edx, %r8d
	je	.L119
.L120:
	leal	0(%rbp,%rax), %ecx
	movslq	%eax, %rdx
	movslq	%ecx, %rcx
	vcvttss2sil	(%r15,%rcx,4), %ecx
	movw	%cx, 48(%rsp,%rdx,2)
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jle	.L119
	movslq	%edx, %rcx
	addl	%ebp, %edx
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movw	%dx, 48(%rsp,%rcx,2)
	leal	2(%rax), %edx
	cmpl	%edx, %esi
	jle	.L119
	movslq	%edx, %rcx
	addl	%ebp, %edx
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movw	%dx, 48(%rsp,%rcx,2)
	leal	3(%rax), %edx
	cmpl	%edx, %esi
	jle	.L119
	movslq	%edx, %rcx
	addl	%ebp, %edx
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movw	%dx, 48(%rsp,%rcx,2)
	leal	4(%rax), %edx
	cmpl	%edx, %esi
	jle	.L119
	movslq	%edx, %rcx
	addl	%ebp, %edx
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movw	%dx, 48(%rsp,%rcx,2)
	leal	5(%rax), %edx
	cmpl	%edx, %esi
	jle	.L119
	movslq	%edx, %rcx
	addl	%ebp, %edx
	addl	$6, %eax
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movw	%dx, 48(%rsp,%rcx,2)
	cmpl	%eax, %esi
	jle	.L119
	movslq	%eax, %rdx
	addl	%ebp, %eax
	cltq
	vcvttss2sil	(%r15,%rax,4), %eax
	movw	%ax, 48(%rsp,%rdx,2)
.L119:
	movq	%r12, %r9
	movslq	%esi, %r8
	movl	$2, %edx
	movq	%r14, %rcx
	vzeroupper
	addl	%esi, %ebp
	call	fwrite
	vmovdqa	.LC64(%rip), %ymm2
	cmpl	%ebp, %edi
	jg	.L122
	vzeroupper
.L110:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L101:
	vmovaps	8240(%rsp), %xmm6
	addq	$8264, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L134:
	leal	(%rdi,%rdi,2), %edi
	testl	%edi, %edi
	jle	.L110
	xorl	%ebp, %ebp
	leaq	48(%rsp), %r14
	movl	$2863311531, %r13d
	.p2align 4
	.p2align 3
.L114:
	movl	%edi, %esi
	movl	$1536, %eax
	movq	%r14, %rdx
	subl	%ebp, %esi
	cmpl	%eax, %esi
	cmovg	%eax, %esi
	xorl	%ecx, %ecx
	.p2align 4
	.p2align 3
.L113:
	leal	0(%rbp,%rcx), %eax
	addl	$3, %ecx
	addq	$3, %rdx
	imulq	%r13, %rax
	shrq	$33, %rax
	vcvttss2sil	(%r15,%rax,4), %eax
	movb	%al, -3(%rdx)
	movb	%ah, -2(%rdx)
	sarl	$16, %eax
	movb	%al, -1(%rdx)
	cmpl	%ecx, %esi
	jg	.L113
	movq	%r12, %r9
	movslq	%esi, %r8
	movl	$1, %edx
	movq	%r14, %rcx
	addl	%esi, %ebp
	call	fwrite
	cmpl	%ebp, %edi
	jg	.L114
	jmp	.L110
	.p2align 4
	.p2align 3
.L133:
	testl	%edi, %edi
	jle	.L110
	xorl	%ebp, %ebp
	leaq	48(%rsp), %r14
	.p2align 4
	.p2align 3
.L109:
	movl	%edi, %esi
	movl	$2048, %eax
	subl	%ebp, %esi
	cmpl	%eax, %esi
	cmovg	%eax, %esi
	leal	-1(%rsi), %eax
	cmpl	$6, %eax
	jbe	.L124
	movl	%esi, %edx
	movslq	%ebp, %rax
	shrl	$3, %edx
	leaq	(%r15,%rax,4), %rcx
	xorl	%eax, %eax
	salq	$5, %rdx
	.p2align 4
	.p2align 3
.L105:
	vcvttps2dq	(%rcx,%rax), %ymm0
	vmovdqu	%ymm0, (%r14,%rax)
	addq	$32, %rax
	cmpq	%rax, %rdx
	jne	.L105
	movl	%esi, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%esi, %edx
	je	.L135
	vzeroupper
.L104:
	movl	%esi, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$2, %ecx
	jbe	.L107
	movslq	%ebp, %rcx
	addq	%rdx, %rcx
	vcvttps2dq	(%r15,%rcx,4), %xmm0
	vmovdqa	%xmm0, 48(%rsp,%rdx,4)
	movl	%r8d, %edx
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%r8d, %edx
	je	.L106
.L107:
	leal	0(%rbp,%rax), %edx
	movslq	%eax, %rcx
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movl	%edx, 48(%rsp,%rcx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jle	.L106
	movslq	%edx, %rcx
	addl	%ebp, %edx
	addl	$2, %eax
	movslq	%edx, %rdx
	vcvttss2sil	(%r15,%rdx,4), %edx
	movl	%edx, 48(%rsp,%rcx,4)
	cmpl	%eax, %esi
	jle	.L106
	movslq	%eax, %rdx
	addl	%ebp, %eax
	cltq
	vcvttss2sil	(%r15,%rax,4), %eax
	movl	%eax, 48(%rsp,%rdx,4)
.L106:
	movq	%r12, %r9
	movslq	%esi, %r8
	movl	$4, %edx
	movq	%r14, %rcx
	addl	%esi, %ebp
	call	fwrite
	cmpl	%ebp, %edi
	jg	.L109
	jmp	.L110
	.p2align 4
	.p2align 3
.L135:
	vzeroupper
	jmp	.L106
	.p2align 4
	.p2align 3
.L124:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L104
.L125:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L117
.L115:
	movzwl	%ax, %edx
	leaq	.LC66(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L101
	.seh_endproc
	.section .rdata,"dr"
.LC67:
	.ascii "rb\0"
	.align 8
.LC68:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC69:
	.ascii "Aborting.\12\0"
	.align 8
.LC70:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
	.text
	.p2align 4
	.globl	writeWavfile
	.def	writeWavfile;	.scl	2;	.type	32;	.endef
	.seh_proc	writeWavfile
writeWavfile:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rdx, %r14
	leaq	.LC67(%rip), %rdx
	movq	%rcx, %r12
	movq	%r8, %rbp
	movl	%r9d, %r15d
	call	fopen
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L137
	movq	%r12, %rdx
	leaq	.LC68(%rip), %rcx
	leaq	43(%rsp), %rbx
	leaq	.LC70(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L141
	.p2align 4
	.p2align 3
.L138:
	cmpb	$78, %al
	je	.L146
	movq	%rdi, %rcx
	call	printf
.L141:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	43(%rsp), %eax
	cmpb	$89, %al
	jne	.L138
	movq	%r13, %rcx
	call	fclose
.L137:
	movl	%r15d, %r9d
	movq	%rbp, %r8
	movq	%r14, %rdx
	movq	%r12, %rcx
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	writeWavfile.part.0
	.p2align 4
	.p2align 3
.L146:
	leaq	.LC69(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC71:
	.ascii "Out file should be last param!\0"
.LC72:
	.ascii "Unrecognized param %s\12\0"
	.text
	.p2align 4
	.globl	parseParams
	.def	parseParams;	.scl	2;	.type	32;	.endef
	.seh_proc	parseParams
parseParams:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rdx, %rdi
	movq	%r8, %rbp
	cmpl	$1, %ecx
	jle	.L167
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L166
	.p2align 4
	.p2align 3
.L173:
	cmpb	$0, 1(%rdx)
	jne	.L156
	movq	%rcx, 0(%rbp)
.L157:
	incl	%esi
	xorl	%edx, %edx
.L153:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L171
.L166:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L169
	cmpb	$104, 1(%rcx)
	jne	.L169
	cmpb	$0, 2(%rcx)
	je	.L168
	.p2align 4
	.p2align 3
.L169:
	testq	%rdx, %rdx
	je	.L172
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L173
.L156:
	cmpl	$115, %eax
	jne	.L159
	cmpb	$0, 1(%rdx)
	jne	.L159
	call	atof
	vmovsd	%xmm0, 16(%rbp)
	jmp	.L157
	.p2align 4
	.p2align 3
.L172:
	cmpb	$45, (%rcx)
	je	.L174
	cmpl	%ebx, %r12d
	jne	.L175
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L166
	.p2align 4
	.p2align 3
.L171:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L147:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L159:
	cmpl	$101, %eax
	jne	.L161
	cmpb	$0, 1(%rdx)
	jne	.L161
	call	atof
	vmovsd	%xmm0, 24(%rbp)
	jmp	.L157
	.p2align 4
	.p2align 3
.L161:
	cmpl	$100, %eax
	jne	.L163
	cmpb	$0, 1(%rdx)
	jne	.L163
	call	atof
	vmovsd	%xmm0, 32(%rbp)
	jmp	.L157
	.p2align 4
	.p2align 3
.L163:
	cmpl	$72, %eax
	je	.L176
.L165:
	leaq	.LC72(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L147
	.p2align 4
	.p2align 3
.L174:
	leaq	1(%rcx), %rdx
	jmp	.L153
	.p2align 4
	.p2align 3
.L176:
	cmpb	$0, 1(%rdx)
	jne	.L165
	call	atof
	vmovsd	%xmm0, 40(%rbp)
	jmp	.L157
	.p2align 4
	.p2align 3
.L168:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L175:
	leaq	.LC71(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L147
.L167:
	movl	$2, %eax
	jmp	.L147
	.seh_endproc
	.p2align 4
	.globl	padChannel
	.def	padChannel;	.scl	2;	.type	32;	.endef
	.seh_proc	padChannel
padChannel:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	.seh_endprologue
	movq	%rdx, %r10
	movl	16(%rdx), %edx
	testl	%r8d, %r8d
	jle	.L178
	movslq	%r8d, %rax
	movslq	%edx, %r11
	movl	%r8d, %esi
	leal	-1(%r8), %r9d
	addq	%rax, %r11
	leaq	0(,%r11,4), %rbx
	leaq	-4(%rbx), %rax
	cmpq	$24, %rax
	jbe	.L179
	cmpl	$2, %r9d
	jbe	.L179
	cmpl	$6, %r9d
	jbe	.L199
	movl	%r8d, %r9d
	vbroadcastss	%xmm3, %ymm0
	addq	%rcx, %rbx
	xorl	%eax, %eax
	shrl	$3, %r9d
	salq	$5, %r9
	.p2align 4
	.p2align 3
.L181:
	vmovups	%ymm0, (%rcx,%rax)
	vmovups	%ymm0, (%rbx,%rax)
	addq	$32, %rax
	cmpq	%r9, %rax
	jne	.L181
	movl	%r8d, %eax
	andl	$-8, %eax
	movl	%eax, %r9d
	cmpl	%eax, %r8d
	je	.L178
	movl	%r8d, %esi
	subl	%eax, %esi
	leal	-1(%rsi), %ebx
	cmpl	$2, %ebx
	jbe	.L183
.L180:
	vshufps	$0, %xmm3, %xmm3, %xmm0
	vmovups	%xmm0, (%rcx,%rax,4)
	addq	%r11, %rax
	vmovups	%xmm0, (%rcx,%rax,4)
	movl	%esi, %eax
	andl	$-4, %eax
	addl	%eax, %r9d
	cmpl	%eax, %esi
	je	.L178
.L183:
	leal	(%r8,%r9), %eax
	movslq	%r9d, %r11
	addl	%edx, %eax
	salq	$2, %r11
	cltq
	vmovss	%xmm3, (%rcx,%r11)
	vmovss	%xmm3, (%rcx,%rax,4)
	leal	1(%r9), %eax
	cmpl	%eax, %r8d
	jle	.L178
	addl	%r8d, %eax
	addl	$2, %r9d
	vmovss	%xmm3, 4(%rcx,%r11)
	addl	%edx, %eax
	cltq
	vmovss	%xmm3, (%rcx,%rax,4)
	cmpl	%r9d, %r8d
	jle	.L178
	addl	%r8d, %r9d
	vmovss	%xmm3, 8(%rcx,%r11)
	leal	(%r9,%rdx), %eax
	cltq
	vmovss	%xmm3, (%rcx,%rax,4)
.L178:
	testl	%edx, %edx
	jle	.L218
	movslq	12(%r10), %rax
	movq	(%r10), %r11
	movslq	8(%r10), %rbx
	cmpl	$1, %eax
	jne	.L219
	movslq	%r8d, %rsi
	movslq	%ebx, %rdi
	movl	%edx, %r10d
	leal	-1(%rdx), %ebp
	leaq	(%rcx,%rsi,4), %r9
	leaq	4(,%rdi,4), %rax
	leaq	(%r11,%rax), %r13
	movq	%r9, %r12
	subq	%r13, %r12
	cmpq	$24, %r12
	jbe	.L191
	cmpl	$2, %ebp
	jbe	.L191
	cmpl	$6, %ebp
	jbe	.L200
	shrl	$3, %r10d
	leaq	-4(%r11,%rax), %rbp
	xorl	%eax, %eax
	salq	$5, %r10
	.p2align 4
	.p2align 3
.L193:
	vmovups	0(%rbp,%rax), %ymm1
	vmovups	%ymm1, (%r9,%rax)
	addq	$32, %rax
	cmpq	%r10, %rax
	jne	.L193
	movl	%edx, %eax
	andl	$-8, %eax
	movl	%eax, %r9d
	cmpl	%eax, %edx
	je	.L218
	movl	%edx, %r10d
	subl	%eax, %r10d
	leal	-1(%r10), %ebp
	cmpl	$2, %ebp
	jbe	.L195
.L192:
	addq	%rax, %rdi
	addq	%rax, %rsi
	movl	%r10d, %eax
	vmovups	(%r11,%rdi,4), %xmm0
	andl	$-4, %eax
	addl	%eax, %r9d
	vmovups	%xmm0, (%rcx,%rsi,4)
	cmpl	%r10d, %eax
	je	.L218
.L195:
	leal	(%rbx,%r9), %eax
	cltq
	vmovss	(%r11,%rax,4), %xmm0
	leal	(%r8,%r9), %eax
	cltq
	vmovss	%xmm0, (%rcx,%rax,4)
	leal	1(%r9), %eax
	cmpl	%eax, %edx
	jle	.L218
	leal	(%rbx,%rax), %r10d
	addl	%r8d, %eax
	addl	$2, %r9d
	movslq	%r10d, %r10
	cltq
	vmovss	(%r11,%r10,4), %xmm0
	vmovss	%xmm0, (%rcx,%rax,4)
	cmpl	%r9d, %edx
	jle	.L218
	addl	%r9d, %ebx
	addl	%r9d, %r8d
	movslq	%ebx, %rbx
	movslq	%r8d, %r8
	vmovss	(%r11,%rbx,4), %xmm0
	vmovss	%xmm0, (%rcx,%r8,4)
.L218:
	vzeroupper
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L219:
	movslq	%r8d, %r8
	decl	%edx
	leaq	0(,%rax,4), %r10
	leaq	(%r11,%rbx,4), %r9
	addq	%r8, %rdx
	leaq	(%rcx,%r8,4), %rax
	leaq	4(%rcx,%rdx,4), %rdx
	.p2align 4
	.p2align 3
.L189:
	vmovss	(%r9), %xmm0
	addq	$4, %rax
	addq	%r10, %r9
	vmovss	%xmm0, -4(%rax)
	cmpq	%rdx, %rax
	jne	.L189
	vzeroupper
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L179:
	movq	%rcx, %rax
	leaq	4(%rcx,%r9,4), %r9
	.p2align 4
	.p2align 3
.L185:
	vmovss	%xmm3, (%rax)
	vmovss	%xmm3, (%rax,%r11,4)
	addq	$4, %rax
	cmpq	%r9, %rax
	jne	.L185
	jmp	.L178
	.p2align 4
	.p2align 3
.L191:
	leaq	-4(%r11,%rax), %rcx
	movl	%edx, %edx
	xorl	%eax, %eax
	.p2align 4
	.p2align 3
.L197:
	vmovss	(%rcx,%rax,4), %xmm0
	vmovss	%xmm0, (%r9,%rax,4)
	incq	%rax
	cmpq	%rdx, %rax
	jne	.L197
	vzeroupper
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L199:
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	jmp	.L180
.L200:
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	jmp	.L192
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC73:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC74:
	.ascii "curveDuration > 0.f\0"
.LC75:
	.ascii "upsamples != NULL\0"
.LC76:
	.ascii "Generated %d upsample times.\12\0"
.LC77:
	.ascii "\11Start to mid: %d\12\0"
.LC78:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC79:
	.ascii "Durations in samples: %f, %f, %f\12\0"
	.text
	.p2align 4
	.globl	upsampleCurve
	.def	upsampleCurve;	.scl	2;	.type	32;	.endef
	.seh_proc	upsampleCurve
upsampleCurve:
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$200, %rsp
	.seh_stackalloc	200
	vmovaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	vmovaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	vmovaps	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	vmovaps	%xmm9, 80(%rsp)
	.seh_savexmm	%xmm9, 80
	vmovaps	%xmm10, 96(%rsp)
	.seh_savexmm	%xmm10, 96
	vmovaps	%xmm11, 112(%rsp)
	.seh_savexmm	%xmm11, 112
	vmovaps	%xmm12, 128(%rsp)
	.seh_savexmm	%xmm12, 128
	vmovaps	%xmm13, 144(%rsp)
	.seh_savexmm	%xmm13, 144
	vmovaps	%xmm14, 160(%rsp)
	.seh_savexmm	%xmm14, 160
	vmovaps	%xmm15, 176(%rsp)
	.seh_savexmm	%xmm15, 176
	.seh_endprologue
	vxorps	%xmm6, %xmm6, %xmm6
	vxorpd	%xmm5, %xmm5, %xmm5
	movq	272(%rsp), %rbx
	vmovsd	%xmm0, %xmm0, %xmm9
	vcvtsi2sdl	256(%rsp), %xmm6, %xmm8
	vcvtsi2sdl	264(%rsp), %xmm6, %xmm0
	vdivsd	%xmm0, %xmm8, %xmm8
	vmovsd	%xmm2, %xmm2, %xmm10
	vmovsd	%xmm3, %xmm3, %xmm11
	vsubsd	%xmm2, %xmm8, %xmm8
	vdivsd	%xmm0, %xmm9, %xmm9
	vsubsd	%xmm3, %xmm8, %xmm8
	vcomisd	%xmm5, %xmm8
	vdivsd	%xmm0, %xmm1, %xmm12
	jbe	.L241
.L221:
	vaddsd	%xmm12, %xmm9, %xmm0
	vaddsd	%xmm8, %xmm8, %xmm14
	vsubsd	%xmm9, %xmm12, %xmm13
	vdivsd	%xmm0, %xmm14, %xmm14
	vdivsd	%xmm9, %xmm10, %xmm15
	vaddsd	%xmm14, %xmm14, %xmm0
	vdivsd	%xmm9, %xmm11, %xmm11
	vaddsd	%xmm14, %xmm15, %xmm7
	vdivsd	%xmm0, %xmm13, %xmm13
	vaddsd	%xmm11, %xmm7, %xmm0
	vroundsd	$10, %xmm0, %xmm0, %xmm0
	vcvttsd2sil	%xmm0, %ecx
	movl	%ecx, (%rbx)
	movslq	%ecx, %rcx
	salq	$3, %rcx
	call	malloc
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L242
.L222:
	movl	(%rbx), %r8d
	vroundsd	$10, %xmm7, %xmm7, %xmm7
	testl	%r8d, %r8d
	jle	.L232
	vroundsd	$10, %xmm15, %xmm15, %xmm2
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	jmp	.L231
	.p2align 4
	.p2align 3
.L243:
	vmulsd	%xmm9, %xmm0, %xmm0
.L228:
	vmovsd	%xmm0, (%r12,%rax,8)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L232
.L231:
	vcvtsi2sdl	%eax, %xmm6, %xmm0
	vcomisd	%xmm0, %xmm2
	ja	.L243
	vsubsd	%xmm15, %xmm0, %xmm4
	vcomisd	%xmm0, %xmm7
	jbe	.L240
	vmulsd	%xmm4, %xmm13, %xmm0
	vmulsd	%xmm4, %xmm0, %xmm0
	vmulsd	%xmm4, %xmm9, %xmm4
	vaddsd	%xmm4, %xmm0, %xmm0
	vaddsd	%xmm10, %xmm0, %xmm0
	vmovsd	%xmm0, (%r12,%rax,8)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L231
.L232:
	movl	%r8d, %edx
	leaq	.LC76(%rip), %rcx
	call	printf
	vcomisd	.LC46(%rip), %xmm15
	jb	.L225
	vroundsd	$10, %xmm15, %xmm15, %xmm0
	leaq	.LC77(%rip), %rcx
	vcvttsd2sil	%xmm0, %edx
	call	printf
.L225:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm7, %xmm6, %xmm6
	vxorpd	%xmm5, %xmm5, %xmm5
	vcomisd	%xmm5, %xmm6
	jbe	.L233
	leaq	.LC78(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L233:
	vmovsd	%xmm11, %xmm11, %xmm3
	vmovq	%xmm11, %r9
	vmovsd	%xmm14, %xmm14, %xmm2
	vmovq	%xmm14, %r8
	vmovsd	%xmm15, %xmm15, %xmm1
	vmovq	%xmm15, %rdx
	leaq	.LC79(%rip), %rcx
	call	printf
	nop
	vmovaps	32(%rsp), %xmm6
	movq	%r12, %rax
	vmovaps	48(%rsp), %xmm7
	vmovaps	64(%rsp), %xmm8
	vmovaps	80(%rsp), %xmm9
	vmovaps	96(%rsp), %xmm10
	vmovaps	112(%rsp), %xmm11
	vmovaps	128(%rsp), %xmm12
	vmovaps	144(%rsp), %xmm13
	vmovaps	160(%rsp), %xmm14
	vmovaps	176(%rsp), %xmm15
	addq	$200, %rsp
	popq	%rbx
	popq	%r12
	ret
	.p2align 4
	.p2align 3
.L240:
	vsubsd	%xmm14, %xmm4, %xmm4
	vmulsd	%xmm12, %xmm4, %xmm4
	vaddsd	%xmm10, %xmm4, %xmm4
	vaddsd	%xmm8, %xmm4, %xmm0
	jmp	.L228
	.p2align 4
	.p2align 3
.L241:
	movl	$136, %r8d
	leaq	.LC73(%rip), %rdx
	leaq	.LC74(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L221
.L242:
	movl	$155, %r8d
	leaq	.LC73(%rip), %rdx
	leaq	.LC75(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L222
	.seh_endproc
	.section .rdata,"dr"
.LC80:
	.ascii "windowSize % 8 == 0\0"
	.align 8
.LC81:
	.ascii "Upsampling %d samples from channel %d w/ window size = %d...\12\0"
.LC83:
	.ascii "Spinning up %d threads...\12\0"
.LC84:
	.ascii "Proc took %d milliseconds.\12\0"
	.align 8
.LC85:
	.ascii "Done upsampling channel %d...\12\0"
	.text
	.p2align 4
	.globl	dispatchFastSincInterp
	.def	dispatchFastSincInterp;	.scl	2;	.type	32;	.endef
	.seh_proc	dispatchFastSincInterp
dispatchFastSincInterp:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$168, %rsp
	.seh_stackalloc	168
	leaq	160(%rsp), %rbp
	.seh_setframe	%rbp, 160
	.seh_endprologue
	movl	112(%rbp), %esi
	movl	16(%rcx), %r13d
	movl	8(%rdx), %r15d
	movl	16(%rdx), %r14d
	movq	%rcx, %rbx
	movq	%rdx, %r10
	movl	%r8d, 96(%rbp)
	movq	%r9, 104(%rbp)
	testb	$7, %sil
	jne	.L297
.L245:
	leal	(%r14,%rsi), %ecx
	movq	%r10, 88(%rbp)
	movl	$32, %edx
	movl	%esi, %edi
	movslq	%ecx, %rcx
	shrl	$31, %edi
	salq	$2, %rcx
	call	*__imp__aligned_malloc(%rip)
	movq	88(%rbp), %r10
	addl	%esi, %edi
	movq	%rax, %r12
	sarl	%edi
	movq	(%r10), %r9
	movslq	12(%r10), %r11
	cmpl	$1, %esi
	jle	.L251
	leal	-1(%rdi), %eax
	movslq	%r14d, %r10
	leaq	4(,%rax,4), %r8
	movslq	%edi, %rax
	addq	%rax, %r10
	salq	$2, %r10
	leaq	(%r8,%r10), %rax
	testq	%rax, %rax
	jle	.L278
	cmpq	%r8, %r10
	jl	.L249
.L278:
	xorl	%edx, %edx
	movq	%r12, %rcx
	movl	%r11d, -100(%rbp)
	movq	%r9, -96(%rbp)
	movq	%r10, -112(%rbp)
	movq	%r8, -88(%rbp)
	call	memset
	xorl	%edx, %edx
	movq	-112(%rbp), %r10
	movq	-88(%rbp), %r8
	leaq	(%r12,%r10), %rcx
	call	memset
	movq	-96(%rbp), %r9
	movslq	-100(%rbp), %r11
.L251:
	testl	%r14d, %r14d
	jle	.L248
	cmpl	$1, %r11d
	jne	.L298
	movslq	%r15d, %r11
	leal	-1(%r14), %r8d
	movslq	%edi, %r10
	movl	%r14d, %edx
	leaq	4(,%r11,4), %rcx
	movl	%r8d, -96(%rbp)
	leaq	(%r12,%r10,4), %rax
	leaq	(%r9,%rcx), %r8
	movq	%r8, -88(%rbp)
	movq	%rax, %r8
	subq	-88(%rbp), %r8
	cmpq	$24, %r8
	jbe	.L258
	movl	-96(%rbp), %r8d
	cmpl	$2, %r8d
	jbe	.L258
	cmpl	$6, %r8d
	jbe	.L276
	leaq	-4(%r9,%rcx), %r8
	movl	%r14d, %ecx
	xorl	%edx, %edx
	shrl	$3, %ecx
	salq	$5, %rcx
	.p2align 4
	.p2align 3
.L260:
	vmovups	(%r8,%rdx), %ymm4
	vmovups	%ymm4, (%rax,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %rcx
	jne	.L260
	movl	%r14d, %eax
	andl	$-8, %eax
	movl	%eax, %ecx
	cmpl	%eax, %r14d
	je	.L295
	movl	%r14d, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %r8d
	cmpl	$2, %r8d
	jbe	.L299
	vzeroupper
.L259:
	leaq	(%r11,%rax), %r8
	addq	%r10, %rax
	vmovups	(%r9,%r8,4), %xmm0
	vmovups	%xmm0, (%r12,%rax,4)
	movl	%edx, %eax
	andl	$-4, %eax
	addl	%eax, %ecx
	cmpl	%eax, %edx
	je	.L248
.L264:
	leal	(%r15,%rcx), %eax
	cltq
	vmovss	(%r9,%rax,4), %xmm0
	leal	(%rdi,%rcx), %eax
	cltq
	vmovss	%xmm0, (%r12,%rax,4)
	leal	1(%rcx), %eax
	cmpl	%eax, %r14d
	jle	.L248
	leal	(%r15,%rax), %edx
	addl	%edi, %eax
	addl	$2, %ecx
	movslq	%edx, %rdx
	cltq
	vmovss	(%r9,%rdx,4), %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	cmpl	%ecx, %r14d
	jle	.L248
	leal	(%r15,%rcx), %eax
	addl	%ecx, %edi
	cltq
	movslq	%edi, %rdi
	vmovss	(%r9,%rax,4), %xmm0
	vmovss	%xmm0, (%r12,%rdi,4)
.L248:
	leal	1(%r15), %eax
	movl	%r13d, %edx
	leaq	.LC81(%rip), %rcx
	movl	%esi, %r9d
	movl	%eax, %r8d
	movl	%eax, -104(%rbp)
	call	printf
	xorl	%ecx, %ecx
	leaq	-80(%rbp), %rdx
	call	clock_gettime
	cmpl	$851967, %r13d
	jle	.L254
	xorl	%edi, %edi
	movl	$12, %r15d
.L255:
	movl	%r13d, %eax
	vxorps	%xmm0, %xmm0, %xmm0
	cltd
	idivl	%r15d
	vcvtsi2sdl	%eax, %xmm0, %xmm0
	vmulsd	.LC82(%rip), %xmm0, %xmm0
	call	lrint
	sall	$4, %eax
	movl	%eax, -88(%rbp)
	cmpl	$65535, %eax
	jle	.L279
	testb	%dil, %dil
	jne	.L279
	movl	%r15d, %edx
	leaq	.LC83(%rip), %rcx
	movq	%rsp, -120(%rbp)
	call	printf
	movslq	%r15d, %rdx
	leaq	15(,%rdx,8), %rax
	andq	$-16, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %rax
	movq	%rax, -96(%rbp)
	movq	%rdx, %rax
	salq	$6, %rax
	call	___chkstk_ms
	subq	%rax, %rsp
	leaq	32(%rsp), %r8
	testl	%r15d, %r15d
	jle	.L275
	leal	-1(%r15), %eax
	movq	104(%rbp), %rdi
	xorl	%r14d, %r14d
	movl	%esi, 112(%rbp)
	movl	%eax, -100(%rbp)
	movl	%r15d, %eax
	movq	%r8, %r15
	movq	%rax, -112(%rbp)
	xorl	%eax, %eax
	jmp	.L273
	.p2align 4
	.p2align 3
.L301:
	movl	-88(%rbp), %esi
	addl	%eax, %esi
	vmovd	%esi, %xmm0
.L272:
	vmovd	112(%rbp), %xmm3
	vmovdqu	(%rbx), %xmm2
	movl	%r13d, 16(%rbx)
	vpinsrd	$1, %edx, %xmm0, %xmm0
	movq	16(%rbx), %rcx
	movq	%r12, 24(%r15)
	movq	%rdi, 40(%r15)
	movq	%r15, %r8
	xorl	%edx, %edx
	addq	$64, %r15
	movq	%rcx, -48(%r15)
	movl	96(%rbp), %ecx
	vpinsrd	$1, %eax, %xmm3, %xmm1
	vmovdqu	%xmm2, -64(%r15)
	vpunpcklqdq	%xmm0, %xmm1, %xmm0
	movl	%ecx, -32(%r15)
	leaq	_fastSincInterp(%rip), %rcx
	vmovdqu	%xmm0, -16(%r15)
	call	*__imp__beginthread(%rip)
	movq	-96(%rbp), %rdx
	movq	%rax, (%rdx,%r14,8)
	incq	%r14
	movl	%esi, %eax
	cmpq	-112(%rbp), %r14
	je	.L300
.L273:
	movl	%r14d, %edx
	cmpl	%r14d, -100(%rbp)
	jne	.L301
	movl	-88(%rbp), %esi
	vmovd	%r13d, %xmm0
	addl	%eax, %esi
	jmp	.L272
	.p2align 4
	.p2align 3
.L300:
	movq	__imp_WaitForSingleObject(%rip), %rbx
	movq	%rdx, %rdi
	leaq	(%rdx,%r14,8), %rsi
	.p2align 4
	.p2align 3
.L274:
	movq	(%rdi), %rcx
	addq	$8, %rdi
	movl	$-1, %edx
	call	*%rbx
	cmpq	%rdi, %rsi
	jne	.L274
.L275:
	movq	-120(%rbp), %rsp
	leaq	-64(%rbp), %r13
.L270:
	movq	%r13, %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	movq	%r12, %rcx
	call	*__imp__aligned_free(%rip)
	movl	-56(%rbp), %ecx
	subl	-72(%rbp), %ecx
	movq	-64(%rbp), %rdx
	subq	-80(%rbp), %rdx
	movslq	%ecx, %rax
	sarl	$31, %ecx
	imulq	$1125899907, %rax, %rax
	imulq	$1000, %rdx, %rdx
	sarq	$50, %rax
	subl	%ecx, %eax
	leaq	.LC84(%rip), %rcx
	cltq
	addq	%rax, %rdx
	call	printf
	movl	-104(%rbp), %edx
	leaq	.LC85(%rip), %rcx
	call	printf
	nop
	leaq	8(%rbp), %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
	.p2align 4
	.p2align 3
.L279:
	movq	16(%rbx), %rax
	vmovdqu	(%rbx), %xmm5
	movl	%r13d, -8(%rbp)
	leaq	-64(%rbp), %r13
	movq	%r13, %rcx
	movq	%r12, -40(%rbp)
	movl	%esi, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -4(%rbp)
	movq	%rax, -48(%rbp)
	movl	96(%rbp), %eax
	movl	%eax, -32(%rbp)
	movq	104(%rbp), %rax
	vmovdqa	%xmm5, -64(%rbp)
	movq	%rax, -24(%rbp)
	call	_fastSincInterp
	jmp	.L270
	.p2align 4
	.p2align 3
.L254:
	testl	%r13d, %r13d
	leal	65535(%r13), %r15d
	cmovns	%r13d, %r15d
	sarl	$16, %r15d
	cmpl	$1, %r15d
	sete	%dil
	jmp	.L255
	.p2align 4
	.p2align 3
.L297:
	movq	%rdx, 88(%rbp)
	movl	$192, %r8d
	leaq	.LC73(%rip), %rdx
	leaq	.LC80(%rip), %rcx
	call	*__imp__assert(%rip)
	movq	88(%rbp), %r10
	jmp	.L245
.L249:
	addq	%r12, %r10
	xorl	%eax, %eax
	.p2align 4
	.p2align 3
.L252:
	movl	$0x00000000, (%r12,%rax,4)
	movl	$0x00000000, (%r10,%rax,4)
	incq	%rax
	cmpl	%eax, %edi
	jg	.L252
	jmp	.L251
.L295:
	vzeroupper
	jmp	.L248
	.p2align 4
	.p2align 3
.L298:
	movslq	%edi, %rdi
	leal	-1(%r14), %ecx
	movslq	%r15d, %rax
	salq	$2, %r11
	leaq	1(%rdi,%rcx), %rcx
	leaq	(%r9,%rax,4), %rdx
	leaq	(%r12,%rdi,4), %rax
	leaq	(%r12,%rcx,4), %rcx
	.p2align 4
	.p2align 3
.L257:
	vmovss	(%rdx), %xmm0
	addq	$4, %rax
	addq	%r11, %rdx
	vmovss	%xmm0, -4(%rax)
	cmpq	%rcx, %rax
	jne	.L257
	jmp	.L248
	.p2align 4
	.p2align 3
.L258:
	movl	%r14d, %r14d
	leaq	-4(%r9,%rcx), %rcx
	xorl	%edx, %edx
	.p2align 4
	.p2align 3
.L266:
	vmovss	(%rcx,%rdx,4), %xmm0
	vmovss	%xmm0, (%rax,%rdx,4)
	incq	%rdx
	cmpq	%rdx, %r14
	jne	.L266
	jmp	.L248
.L276:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	jmp	.L259
.L299:
	vzeroupper
	jmp	.L264
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC86:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC87:
	.ascii "Some param parse error occured\12\0"
.LC88:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC89:
	.ascii "Verified file header, continuing...\12\0"
.LC90:
	.ascii "data != NULL\0"
.LC91:
	.ascii "upsampledData != NULL\0"
	.align 8
.LC92:
	.ascii "Finished upsampling, writing result...\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$312, %rsp
	.seh_stackalloc	312
	.seh_endprologue
	movl	%ecx, %r12d
	movq	%rdx, %r13
	call	__main
	call	GEN_TRIG_TABLE
	leaq	256(%rsp), %r8
	movq	%r13, %rdx
	call	GEN_BESSEL_TABLE
	movl	%r12d, %ecx
	call	parseParams
	cmpl	$1, %eax
	je	.L320
	cmpl	$2, %eax
	je	.L321
	movq	256(%rsp), %r12
	leaq	.LC67(%rip), %rdx
	movq	%r12, %rcx
	call	fopen
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L322
	leaq	208(%rsp), %r12
	movq	%rax, %rdx
	movq	%r12, %rcx
	call	readWavInfo
	movq	%r12, %rcx
	call	verifyWavInfo
	testb	%al, %al
	jne	.L307
.L309:
	movl	$1, %eax
.L302:
	addq	$312, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L307:
	leaq	.LC89(%rip), %rcx
	call	printf
	movzwl	242(%rsp), %ecx
	xorl	%edx, %edx
	movl	248(%rsp), %eax
	shrw	$3, %cx
	movzwl	%cx, %ecx
	divl	%ecx
	cltq
	leaq	0(,%rax,4), %rcx
	call	malloc
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L323
.L308:
	movq	%r12, %r8
	movq	%r13, %rdx
	movq	%rbx, %rcx
	call	readWavData
	testb	%al, %al
	je	.L309
	movq	%r13, %rcx
	call	fclose
	movzwl	242(%rsp), %ecx
	xorl	%edx, %edx
	movl	248(%rsp), %eax
	vmovsd	296(%rsp), %xmm3
	vmovsd	288(%rsp), %xmm2
	vmovsd	280(%rsp), %xmm1
	vmovsd	272(%rsp), %xmm0
	shrw	$3, %cx
	movzwl	%cx, %ecx
	divl	%ecx
	movzwl	230(%rsp), %ecx
	cltd
	idivl	%ecx
	movl	%eax, %esi
	leaq	140(%rsp), %rax
	movq	%rax, 48(%rsp)
	movl	232(%rsp), %eax
	movl	%esi, 32(%rsp)
	movl	%eax, 40(%rsp)
	call	upsampleCurve
	movq	%rax, %r14
	movslq	140(%rsp), %rcx
	movzwl	230(%rsp), %eax
	imulq	%rax, %rcx
	salq	$2, %rcx
	call	malloc
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L324
.L310:
	movzwl	230(%rsp), %edx
	testl	%edx, %edx
	je	.L311
	xorl	%r15d, %r15d
	leaq	64(%rsp), %rbp
	leaq	96(%rsp), %rdi
	.p2align 4
	.p2align 3
.L312:
	movl	140(%rsp), %eax
	vmovd	%r15d, %xmm4
	movl	%r15d, 184(%rsp)
	movl	%edx, 188(%rsp)
	vpinsrd	$1, %edx, %xmm4, %xmm0
	movq	%rbx, 176(%rsp)
	movq	%r13, 144(%rsp)
	movl	%esi, 192(%rsp)
	vmovq	%xmm0, 152(%rsp)
	movq	%rbp, %rdx
	movl	$256, 32(%rsp)
	movq	%r14, %r9
	movq	%rdi, %rcx
	incl	%r15d
	vmovdqa	144(%rsp), %xmm5
	vmovdqa	176(%rsp), %xmm1
	movl	%eax, 160(%rsp)
	movq	160(%rsp), %rax
	movl	232(%rsp), %r8d
	movq	%rax, 112(%rsp)
	movq	192(%rsp), %rax
	vmovdqa	%xmm5, 96(%rsp)
	vmovdqa	%xmm1, 64(%rsp)
	movq	%rax, 80(%rsp)
	call	dispatchFastSincInterp
	movzwl	230(%rsp), %edx
	cmpl	%r15d, %edx
	jg	.L312
.L311:
	leaq	.LC92(%rip), %rcx
	call	printf
	movzwl	230(%rsp), %r9d
	movq	%r13, %r8
	movq	%r12, %rdx
	imull	140(%rsp), %r9d
	movq	264(%rsp), %rcx
	call	writeWavfile
	movq	%r13, %rcx
	call	free
	movq	%r14, %rcx
	call	free
	xorl	%eax, %eax
	jmp	.L302
.L321:
	leaq	.LC87(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L302
.L322:
	movq	%r12, %rdx
	leaq	.LC88(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L302
.L320:
	leaq	.LC86(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L302
.L323:
	movl	$345, %r8d
	leaq	.LC73(%rip), %rdx
	leaq	.LC90(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L308
.L324:
	movl	$361, %r8d
	leaq	.LC73(%rip), %rdx
	leaq	.LC91(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L310
	.seh_endproc
	.globl	bessel_table
	.bss
	.align 16
bessel_table:
	.space 20
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
	.align 32
.LC2:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.align 32
.LC3:
	.long	1182793728
	.long	1182793728
	.long	1182793728
	.long	1182793728
	.long	1182793728
	.long	1182793728
	.long	1182793728
	.long	1182793728
	.align 32
.LC4:
	.long	1012989952
	.long	1012989952
	.long	1012989952
	.long	1012989952
	.long	1012989952
	.long	1012989952
	.long	1012989952
	.long	1012989952
	.align 32
.LC5:
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.align 32
.LC6:
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.align 32
.LC7:
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.align 32
.LC8:
	.quad	549755814016
	.quad	549755814016
	.quad	549755814016
	.quad	549755814016
	.align 32
.LC9:
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.align 32
.LC10:
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.align 32
.LC11:
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.align 8
.LC12:
	.long	1413754136
	.long	1074340347
	.align 8
.LC13:
	.long	0
	.long	1063256064
	.align 8
.LC14:
	.long	1841940611
	.long	1079271216
	.align 8
.LC15:
	.long	1413754136
	.long	1065951739
	.align 8
.LC16:
	.long	0
	.long	1071644672
	.set	.LC17,.LC6
	.align 4
.LC18:
	.long	1011421147
	.align 4
.LC19:
	.long	1056964608
	.align 32
.LC20:
	.long	1610612736
	.long	1079271216
	.long	1610612736
	.long	1079271216
	.long	1610612736
	.long	1079271216
	.long	1610612736
	.long	1079271216
	.align 32
.LC21:
	.long	1610612736
	.long	-1081531909
	.long	1610612736
	.long	-1081531909
	.long	1610612736
	.long	-1081531909
	.long	1610612736
	.long	-1081531909
	.align 32
.LC22:
	.long	0
	.long	-1075838976
	.long	0
	.long	-1075838976
	.long	0
	.long	-1075838976
	.long	0
	.long	-1075838976
	.set	.LC23,.LC5
	.align 8
.LC24:
	.long	1413754136
	.long	1075388923
	.set	.LC25,.LC33
	.align 4
.LC26:
	.long	851987547
	.set	.LC27,.LC35
	.align 4
.LC28:
	.long	959835880
	.set	.LC29,.LC37
	.align 4
.LC30:
	.long	1037009275
	.set	.LC31,.LC40
	.align 32
.LC32:
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.align 32
.LC33:
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.align 32
.LC34:
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.align 32
.LC35:
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.align 32
.LC36:
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.align 32
.LC37:
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.align 32
.LC38:
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.align 32
.LC39:
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.align 32
.LC40:
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.align 32
.LC41:
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.align 8
.LC42:
	.long	477218588
	.long	1054634439
	.align 8
.LC43:
	.long	477218588
	.long	1060925895
	.align 8
.LC44:
	.long	0
	.long	1066401792
	.align 8
.LC45:
	.long	0
	.long	1070596096
	.align 8
.LC46:
	.long	0
	.long	1072693248
	.align 16
.LC47:
	.long	942997567
	.long	926220351
	.long	892665919
	.long	849404870
	.align 8
.LC49:
	.long	0
	.long	1087373312
	.align 8
.LC50:
	.long	0
	.long	1069416448
	.align 32
.LC64:
	.long	65535
	.long	65535
	.long	65535
	.long	65535
	.long	65535
	.long	65535
	.long	65535
	.long	65535
	.set	.LC65,.LC64
	.align 8
.LC82:
	.long	0
	.long	1068498944
	.ident	"GCC: (Rev1, Built by MSYS2 project) 11.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	sin;	.scl	2;	.type	32;	.endef
	.def	sqrt;	.scl	2;	.type	32;	.endef
	.def	strncmp;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	fseek;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	atof;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	clock_gettime;	.scl	2;	.type	32;	.endef
	.def	lrint;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
