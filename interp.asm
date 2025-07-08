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
	vmovsd	.LC2(%rip), %xmm7
	vmovsd	.LC3(%rip), %xmm6
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
	vmulsd	.LC4(%rip), %xmm0, %xmm1
	leaq	sineTable_4q(%rip), %rcx
	vcvttsd2sil	%xmm1, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	leal	128(%rax), %edx
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	andl	$511, %eax
	vfnmadd132sd	.LC5(%rip), %xmm0, %xmm1
	vmovsd	(%rcx,%rax,8), %xmm2
	movl	%edx, %eax
	vmulsd	.LC6(%rip), %xmm2, %xmm0
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
	vmulss	.LC7(%rip), %xmm0, %xmm1
	leaq	f_sineTable_4q(%rip), %rcx
	vcvttss2sil	%xmm1, %eax
	vxorps	%xmm1, %xmm1, %xmm1
	leal	128(%rax), %edx
	vcvtsi2ssl	%eax, %xmm1, %xmm1
	andl	$511, %eax
	vfnmadd132ss	.LC8(%rip), %xmm0, %xmm1
	vmovss	(%rcx,%rax,4), %xmm2
	movl	%edx, %eax
	vmulss	.LC9(%rip), %xmm2, %xmm0
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
	vmovdqa	.LC13(%rip), %ymm5
	leaq	f_sineTable_4q(%rip), %rax
	vmulps	.LC10(%rip), %ymm1, %ymm0
	vcvtps2dq	%ymm0, %ymm0
	vpaddq	.LC12(%rip), %ymm0, %ymm3
	vcvtdq2ps	%ymm0, %ymm2
	vfmadd132ps	.LC11(%rip), %ymm1, %ymm2
	vxorps	%xmm1, %xmm1, %xmm1
	vpand	%ymm0, %ymm5, %ymm0
	vcmpps	$0, %ymm1, %ymm1, %ymm1
	vmovaps	%ymm1, %ymm6
	vgatherdps	%ymm6, (%rax,%ymm0,4), %ymm4
	vpand	%ymm5, %ymm3, %ymm0
	vgatherdps	%ymm1, (%rax,%ymm0,4), %ymm3
	vmulps	.LC14(%rip), %ymm4, %ymm0
	vfmadd132ps	%ymm2, %ymm3, %ymm0
	vfmadd132ps	%ymm2, %ymm4, %ymm0
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
	vmovss	.LC15(%rip), %xmm3
	vmovss	.LC17(%rip), %xmm2
	vmovss	.LC23(%rip), %xmm4
	vdivss	%xmm3, %xmm0, %xmm1
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
	vfmadd132sd	.LC16(%rip), %xmm0, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm0
	vfmadd213ss	.LC18(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC19(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC20(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC21(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC22(%rip), %xmm0, %xmm2
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
	.globl	chebSinSIMD
	.def	chebSinSIMD;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSinSIMD
chebSinSIMD:
	.seh_endprologue
	vmovaps	.LC24(%rip), %ymm3
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
	vfmadd132ps	.LC25(%rip), %ymm2, %ymm0
	vmovaps	.LC26(%rip), %ymm2
	vmulps	%ymm0, %ymm0, %ymm1
	vfmadd213ps	.LC27(%rip), %ymm1, %ymm2
	vaddps	%ymm3, %ymm0, %ymm3
	vaddps	.LC34(%rip), %ymm3, %ymm3
	vfmadd213ps	.LC28(%rip), %ymm1, %ymm2
	vfmadd213ps	.LC29(%rip), %ymm1, %ymm2
	vfmadd213ps	.LC30(%rip), %ymm1, %ymm2
	vfmadd213ps	.LC31(%rip), %ymm1, %ymm2
	vaddps	.LC32(%rip), %ymm0, %ymm1
	vaddps	.LC33(%rip), %ymm1, %ymm1
	vmulps	%ymm3, %ymm1, %ymm1
	vmulps	%ymm2, %ymm1, %ymm1
	vmulps	%ymm0, %ymm1, %ymm0
	vmovaps	%ymm0, (%rdx)
	vzeroupper
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
	.p2align 4
	.globl	copyHeader
	.def	copyHeader;	.scl	2;	.type	32;	.endef
	.seh_proc	copyHeader
copyHeader:
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	vmovdqu	(%rdx), %xmm0
	movq	16(%rdx), %r10
	movq	24(%rdx), %r11
	movq	32(%rdx), %rdx
	movq	%rcx, %rax
	movq	%r10, 16(%rcx)
	movl	%r8d, 40(%rcx)
	movq	%r11, 24(%rcx)
	movq	%rdx, 32(%rcx)
	vmovdqu	%xmm0, (%rcx)
	addq	$56, %rsp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC35:
	.ascii "Out file should be last param!\0"
.LC36:
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
	jle	.L33
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L32
	.p2align 4
	.p2align 3
.L39:
	cmpb	$0, 1(%rdx)
	jne	.L22
	movq	%rcx, 0(%rbp)
.L23:
	incl	%esi
	xorl	%edx, %edx
.L19:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L37
.L32:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L35
	cmpb	$104, 1(%rcx)
	jne	.L35
	cmpb	$0, 2(%rcx)
	je	.L34
	.p2align 4
	.p2align 3
.L35:
	testq	%rdx, %rdx
	je	.L38
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L39
.L22:
	cmpl	$115, %eax
	jne	.L25
	cmpb	$0, 1(%rdx)
	jne	.L25
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L23
	.p2align 4
	.p2align 3
.L38:
	cmpb	$45, (%rcx)
	je	.L40
	cmpl	%ebx, %r12d
	jne	.L41
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L32
	.p2align 4
	.p2align 3
.L37:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L13:
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
.L25:
	cmpl	$101, %eax
	jne	.L27
	cmpb	$0, 1(%rdx)
	jne	.L27
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L23
	.p2align 4
	.p2align 3
.L27:
	cmpl	$100, %eax
	jne	.L29
	cmpb	$0, 1(%rdx)
	jne	.L29
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L23
	.p2align 4
	.p2align 3
.L29:
	cmpl	$72, %eax
	je	.L42
.L31:
	leaq	.LC36(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L13
	.p2align 4
	.p2align 3
.L40:
	leaq	1(%rcx), %rdx
	jmp	.L19
	.p2align 4
	.p2align 3
.L42:
	cmpb	$0, 1(%rdx)
	jne	.L31
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L23
	.p2align 4
	.p2align 3
.L34:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L41:
	leaq	.LC35(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L13
.L33:
	movl	$2, %eax
	jmp	.L13
	.seh_endproc
	.section .rdata,"dr"
.LC37:
	.ascii "RIFF\0"
	.align 8
.LC38:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC39:
	.ascii "WAVE\0"
	.align 8
.LC40:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC41:
	.ascii "fmt \0"
	.align 8
.LC42:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC43:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC44:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC45:
	.ascii "Bit depth %d must be one of 16, 24, or 32.\12\0"
	.text
	.p2align 4
	.globl	verifyHeader
	.def	verifyHeader;	.scl	2;	.type	32;	.endef
	.seh_proc	verifyHeader
verifyHeader:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$4, %r8d
	leaq	.LC37(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L57
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC39(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L58
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC41(%rip), %rdx
	call	strncmp
	testl	%eax, %eax
	jne	.L59
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L60
	cmpw	$1, 20(%r12)
	jne	.L61
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L50
	cmpw	$32, %dx
	jne	.L62
.L50:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L57:
	movq	%r12, %rdx
	leaq	.LC38(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L43:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L60:
	leaq	.LC43(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L58:
	movq	%r13, %rdx
	leaq	.LC40(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L59:
	movq	%r13, %rdx
	leaq	.LC42(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L61:
	leaq	.LC44(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L62:
	leaq	.LC45(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L43
	.seh_endproc
	.p2align 4
	.globl	padAndFloat
	.def	padAndFloat;	.scl	2;	.type	32;	.endef
	.seh_proc	padAndFloat
padAndFloat:
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
	vmovaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	.seh_endprologue
	movslq	%edx, %rbx
	movq	%rcx, %rdi
	movl	%r8d, %esi
	vmovaps	%xmm3, %xmm6
	leal	(%rbx,%r8,2), %ebp
	movslq	%ebp, %rcx
	salq	$2, %rcx
	je	.L66
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L66
	leaq	32(%rax), %r9
	andq	$-32, %r9
	movq	%rax, -8(%r9)
.L65:
	testl	%ebx, %ebx
	jle	.L73
	leal	-1(%rbx), %eax
	cmpl	$6, %eax
	jbe	.L86
	movl	%ebx, %edx
	movslq	%esi, %rax
	shrl	$3, %edx
	leaq	(%r9,%rax,4), %rcx
	xorl	%eax, %eax
	salq	$5, %rdx
	.p2align 4
	.p2align 3
.L71:
	vcvtdq2ps	(%rdi,%rax), %ymm0
	vmovups	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L71
	movl	%ebx, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%edx, %ebx
	je	.L73
.L70:
	movl	%ebx, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$2, %ecx
	jbe	.L75
	vcvtdq2ps	(%rdi,%rdx,4), %xmm0
	movslq	%esi, %rcx
	addq	%rcx, %rdx
	vmovups	%xmm0, (%r9,%rdx,4)
	movl	%r8d, %edx
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%edx, %r8d
	je	.L73
.L75:
	leal	(%rsi,%rax), %edx
	movslq	%eax, %r8
	vxorps	%xmm0, %xmm0, %xmm0
	movslq	%edx, %rdx
	vcvtsi2ssl	(%rdi,%r8,4), %xmm0, %xmm1
	leaq	0(,%r8,4), %rcx
	vmovss	%xmm1, (%r9,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %ebx
	jle	.L73
	addl	%esi, %edx
	addl	$2, %eax
	vcvtsi2ssl	4(%rdi,%rcx), %xmm0, %xmm1
	movslq	%edx, %rdx
	vmovss	%xmm1, (%r9,%rdx,4)
	cmpl	%eax, %ebx
	jle	.L73
	addl	%esi, %eax
	vcvtsi2ssl	8(%rdi,%rcx), %xmm0, %xmm0
	cltq
	vmovss	%xmm0, (%r9,%rax,4)
.L73:
	testl	%esi, %esi
	jle	.L63
	movslq	%esi, %rdx
	subl	%esi, %ebp
	movl	%esi, %r8d
	leal	-1(%rsi), %eax
	addq	%rdx, %rbx
	leaq	0(,%rbx,4), %rcx
	leaq	-4(%rcx), %rdx
	cmpq	$24, %rdx
	jbe	.L77
	cmpl	$2, %eax
	jbe	.L77
	cmpl	$6, %eax
	jbe	.L87
	movl	%esi, %edx
	vbroadcastss	%xmm6, %ymm0
	addq	%r9, %rcx
	xorl	%eax, %eax
	shrl	$3, %edx
	salq	$5, %rdx
	.p2align 4
	.p2align 3
.L79:
	vmovaps	%ymm0, (%r9,%rax)
	vmovups	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L79
	movl	%esi, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%edx, %esi
	je	.L63
	movl	%esi, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$2, %ecx
	jbe	.L82
.L78:
	vshufps	$0, %xmm6, %xmm6, %xmm0
	addq	%rdx, %rbx
	vmovaps	%xmm0, (%r9,%rdx,4)
	movl	%r8d, %edx
	vmovups	%xmm0, (%r9,%rbx,4)
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%edx, %r8d
	je	.L63
.L82:
	movslq	%eax, %rcx
	leal	0(%rbp,%rax), %edx
	movslq	%edx, %rdx
	salq	$2, %rcx
	vmovss	%xmm6, (%r9,%rcx)
	vmovss	%xmm6, (%r9,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jle	.L63
	addl	%ebp, %edx
	addl	$2, %eax
	vmovss	%xmm6, 4(%r9,%rcx)
	movslq	%edx, %rdx
	vmovss	%xmm6, (%r9,%rdx,4)
	cmpl	%eax, %esi
	jle	.L63
	addl	%ebp, %eax
	vmovss	%xmm6, 8(%r9,%rcx)
	cltq
	vmovss	%xmm6, (%r9,%rax,4)
.L63:
	movq	%r9, %rax
	vzeroupper
	vmovaps	32(%rsp), %xmm6
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4
	.p2align 3
.L66:
	xorl	%r9d, %r9d
	jmp	.L65
	.p2align 4
	.p2align 3
.L77:
	movl	%esi, %r8d
	movq	%r9, %rax
	movslq	%ebp, %rbp
	leaq	(%r9,%r8,4), %rdx
	.p2align 4
	.p2align 3
.L84:
	vmovss	%xmm6, (%rax)
	vmovss	%xmm6, (%rax,%rbp,4)
	addq	$4, %rax
	cmpq	%rax, %rdx
	jne	.L84
	jmp	.L63
.L86:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L70
.L87:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L78
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC46:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC47:
	.ascii "curveDuration > 0.f\0"
.LC48:
	.ascii "Generated %d upsample times.\12\0"
.LC50:
	.ascii "\11Start to mid: %d\0"
.LC51:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC52:
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
	movq	272(%rsp), %rbx
	vmovaps	%xmm0, %xmm9
	vcvtsi2ssl	256(%rsp), %xmm6, %xmm8
	vcvtsi2ssl	264(%rsp), %xmm6, %xmm0
	vdivss	%xmm0, %xmm8, %xmm8
	vmovaps	%xmm2, %xmm11
	vmovaps	%xmm3, %xmm14
	vsubss	%xmm2, %xmm8, %xmm8
	vdivss	%xmm0, %xmm9, %xmm9
	vsubss	%xmm3, %xmm8, %xmm8
	vcomiss	.LC1(%rip), %xmm8
	vdivss	%xmm0, %xmm1, %xmm12
	jbe	.L120
.L101:
	vaddss	%xmm12, %xmm9, %xmm0
	vaddss	%xmm8, %xmm8, %xmm7
	vsubss	%xmm9, %xmm12, %xmm13
	vdivss	%xmm0, %xmm7, %xmm7
	vdivss	%xmm9, %xmm11, %xmm10
	vaddss	%xmm7, %xmm7, %xmm0
	vdivss	%xmm9, %xmm14, %xmm14
	vaddss	%xmm7, %xmm10, %xmm15
	vdivss	%xmm0, %xmm13, %xmm13
	vaddss	%xmm14, %xmm15, %xmm0
	vroundss	$10, %xmm0, %xmm0, %xmm0
	vcvttss2sil	%xmm0, %ecx
	movl	%ecx, (%rbx)
	movslq	%ecx, %rcx
	salq	$2, %rcx
	call	malloc
	movl	(%rbx), %r8d
	vroundss	$10, %xmm15, %xmm15, %xmm15
	movq	%rax, %r12
	testl	%r8d, %r8d
	jle	.L121
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L110
	.p2align 4
	.p2align 3
.L122:
	vmulss	%xmm0, %xmm9, %xmm0
.L107:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L111
.L110:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L122
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L119
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L110
.L111:
	movl	%r8d, %edx
	leaq	.LC48(%rip), %rcx
	call	printf
	vcomiss	.LC49(%rip), %xmm10
	jb	.L104
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC50(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L104:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L112
	leaq	.LC51(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L112:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC52(%rip), %rcx
	vcvtss2sd	%xmm7, %xmm7, %xmm2
	vcvtss2sd	%xmm10, %xmm10, %xmm1
	vmovq	%xmm3, %r9
	vmovq	%xmm2, %r8
	vmovq	%xmm1, %rdx
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
.L119:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L107
	.p2align 4
	.p2align 3
.L120:
	movl	$172, %r8d
	leaq	.LC46(%rip), %rdx
	leaq	.LC47(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L101
	.p2align 4
	.p2align 3
.L121:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L111
	.seh_endproc
	.section .rdata,"dr"
.LC53:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC57:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC61:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC62:
	.ascii "Done upsampling, writing result...\12\0"
	.text
	.p2align 4
	.globl	fastSincInterp
	.def	fastSincInterp;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSincInterp
fastSincInterp:
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
	subq	$232, %rsp
	.seh_stackalloc	232
	vmovaps	%xmm6, 64(%rsp)
	.seh_savexmm	%xmm6, 64
	vmovaps	%xmm7, 80(%rsp)
	.seh_savexmm	%xmm7, 80
	vmovaps	%xmm8, 96(%rsp)
	.seh_savexmm	%xmm8, 96
	vmovaps	%xmm9, 112(%rsp)
	.seh_savexmm	%xmm9, 112
	vmovaps	%xmm10, 128(%rsp)
	.seh_savexmm	%xmm10, 128
	vmovaps	%xmm11, 144(%rsp)
	.seh_savexmm	%xmm11, 144
	vmovaps	%xmm12, 160(%rsp)
	.seh_savexmm	%xmm12, 160
	vmovaps	%xmm13, 176(%rsp)
	.seh_savexmm	%xmm13, 176
	vmovaps	%xmm14, 192(%rsp)
	.seh_savexmm	%xmm14, 192
	vmovaps	%xmm15, 208(%rsp)
	.seh_savexmm	%xmm15, 208
	.seh_endprologue
	movl	344(%rsp), %r13d
	movl	336(%rsp), %r14d
	movq	%rdx, %r12
	movl	%r13d, %edx
	movl	%ecx, 304(%rsp)
	movl	%r8d, %r15d
	shrl	$31, %edx
	movq	%r9, %rbp
	leal	0(%r13,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L124
	movl	$228, %r8d
	leaq	.LC46(%rip), %rdx
	leaq	.LC53(%rip), %rcx
	call	*__imp__assert(%rip)
.L124:
	vxorps	%xmm6, %xmm6, %xmm6
	vmovsd	.LC56(%rip), %xmm5
	movl	%r15d, %edx
	vxorps	%xmm3, %xmm3, %xmm3
	vcvtsi2ssl	%r13d, %xmm6, %xmm0
	vmulss	.LC54(%rip), %xmm0, %xmm0
	movq	%r12, %rcx
	movslq	%r14d, %r15
	vroundss	$10, %xmm0, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vfmadd132sd	.LC55(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edi
	movl	%edi, %esi
	shrl	$31, %esi
	addl	%edi, %esi
	sarl	%esi
	movl	%esi, %r8d
	call	padAndFloat
	movq	%rax, %rbx
	movq	%r15, %rax
	salq	$2, %rax
	je	.L127
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L127
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L126:
	movl	%r14d, %edx
	leaq	.LC57(%rip), %rcx
	movl	%r13d, %r8d
	call	printf
	xorl	%ecx, %ecx
	leaq	32(%rsp), %rdx
	call	clock_gettime
	testl	%r14d, %r14d
	jle	.L134
	vcvtsi2ssl	304(%rsp), %xmm6, %xmm6
	vmovaps	.LC25(%rip), %ymm15
	vmovd	%xmm6, %r10d
	vmovaps	.LC24(%rip), %ymm6
	leal	-1(%rdi), %r11d
	xorl	%r8d, %r8d
	shrl	$3, %r11d
	salq	$3, %r11
	.p2align 4
	.p2align 3
.L133:
	vmovd	%r10d, %xmm4
	vmulss	0(%rbp,%r8,4), %xmm4, %xmm8
	vcvttss2sil	%xmm8, %eax
	movl	%eax, %edx
	vbroadcastss	%xmm8, %ymm8
	subl	%esi, %edx
	vmovd	%edx, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpaddd	.LC58(%rip), %ymm2, %ymm2
	testl	%edi, %edi
	jle	.L135
	vmovaps	.LC34(%rip), %ymm9
	vmovaps	.LC59(%rip), %ymm7
	movslq	%eax, %rdx
	vxorpd	%xmm14, %xmm14, %xmm14
	vmovdqa	.LC60(%rip), %ymm5
	leaq	(%rbx,%rdx,4), %rax
	addq	%r11, %rdx
	vxorps	%xmm4, %xmm4, %xmm4
	leaq	32(%rbx,%rdx,4), %rcx
	vpcmpeqd	%ymm3, %ymm3, %ymm3
	.p2align 4
	.p2align 3
.L132:
	vcvtdq2ps	%ymm2, %ymm10
	addq	$32, %rax
	vpaddd	%ymm2, %ymm5, %ymm2
	vsubps	%ymm10, %ymm8, %ymm10
	vmulps	%ymm6, %ymm10, %ymm10
	vdivps	%ymm6, %ymm10, %ymm11
	vcmpps	$0, %ymm4, %ymm10, %ymm0
	vcvtps2dq	%ymm11, %ymm11
	vpxor	%ymm11, %ymm3, %ymm1
	vpsrad	$1, %ymm11, %ymm12
	vpsrld	$31, %ymm1, %ymm1
	vpand	%ymm1, %ymm11, %ymm11
	vpaddq	%ymm12, %ymm11, %ymm11
	vmovaps	.LC26(%rip), %ymm12
	vcvtdq2ps	%ymm11, %ymm11
	vfmadd132ps	%ymm15, %ymm10, %ymm11
	vmulps	%ymm11, %ymm11, %ymm1
	vfmadd213ps	.LC27(%rip), %ymm1, %ymm12
	vaddps	%ymm6, %ymm11, %ymm13
	vaddps	%ymm9, %ymm13, %ymm13
	vfmadd213ps	.LC28(%rip), %ymm1, %ymm12
	vfmadd213ps	.LC29(%rip), %ymm1, %ymm12
	vfmadd213ps	.LC30(%rip), %ymm1, %ymm12
	vfmadd213ps	.LC31(%rip), %ymm1, %ymm12
	vaddps	.LC32(%rip), %ymm11, %ymm1
	vaddps	.LC33(%rip), %ymm1, %ymm1
	vmulps	%ymm13, %ymm1, %ymm1
	vmulps	%ymm12, %ymm1, %ymm1
	vmulps	%ymm11, %ymm1, %ymm1
	vdivps	%ymm10, %ymm1, %ymm1
	vblendvps	%ymm0, %ymm7, %ymm1, %ymm1
	vmulps	-32(%rax), %ymm1, %ymm1
	vextractf128	$0x1, %ymm1, %xmm0
	vaddps	%xmm1, %xmm0, %xmm0
	vmovhlps	%xmm0, %xmm0, %xmm1
	vaddps	%xmm1, %xmm0, %xmm0
	vshufps	$1, %xmm0, %xmm0, %xmm1
	vaddss	%xmm1, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm14, %xmm14
	cmpq	%rax, %rcx
	jne	.L132
	vcvttsd2sil	%xmm14, %eax
.L131:
	movl	%eax, (%r12,%r8,4)
	incq	%r8
	cmpq	%r8, %r15
	jne	.L133
	vzeroupper
.L134:
	xorl	%ecx, %ecx
	leaq	48(%rsp), %rdx
	call	clock_gettime
	testq	%rbx, %rbx
	je	.L130
	movq	-8(%rbx), %rcx
	call	free
.L130:
	movl	56(%rsp), %eax
	subl	40(%rsp), %eax
	leaq	.LC61(%rip), %rcx
	movq	48(%rsp), %rdx
	subq	32(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC62(%rip), %rcx
	call	printf
	nop
	vmovaps	64(%rsp), %xmm6
	movq	%r12, %rax
	vmovaps	80(%rsp), %xmm7
	vmovaps	96(%rsp), %xmm8
	vmovaps	112(%rsp), %xmm9
	vmovaps	128(%rsp), %xmm10
	vmovaps	144(%rsp), %xmm11
	vmovaps	160(%rsp), %xmm12
	vmovaps	176(%rsp), %xmm13
	vmovaps	192(%rsp), %xmm14
	vmovaps	208(%rsp), %xmm15
	addq	$232, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4
	.p2align 3
.L135:
	xorl	%eax, %eax
	jmp	.L131
.L127:
	xorl	%r12d, %r12d
	jmp	.L126
	.seh_endproc
	.p2align 4
	.globl	getDataChunkCount
	.def	getDataChunkCount;	.scl	2;	.type	32;	.endef
	.seh_proc	getDataChunkCount
getDataChunkCount:
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
.LC64:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC65:
	.ascii "Bit depth %d not yet supported.\12\0"
	.text
	.p2align 4
	.globl	readWavfile
	.def	readWavfile;	.scl	2;	.type	32;	.endef
	.seh_proc	readWavfile
readWavfile:
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
	subq	$72, %rsp
	.seh_stackalloc	72
	.seh_endprologue
	movzwl	34(%rdx), %r8d
	movl	40(%rdx), %eax
	xorl	%edx, %edx
	movq	%rcx, %rsi
	movl	%r8d, %ecx
	shrw	$3, %cx
	movzwl	%cx, %ecx
	divl	%ecx
	movslq	%eax, %rdi
	movl	%edi, %ebx
	cmpw	$32, %r8w
	je	.L177
	cmpw	$24, %r8w
	jne	.L151
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L154
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L154
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L153:
	cmpl	$7, %edi
	jle	.L159
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L156
	.p2align 4
	.p2align 3
.L176:
	vzeroupper
.L156:
	movq	%rsi, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%r15, %rcx
	call	fread
	movq	%rsi, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%r14, %rcx
	addq	$32, %rbx
	call	fread
	vmovdqu	32(%rsp), %ymm1
	vpshufb	.LC63(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L176
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L155:
	testl	%ebx, %ebx
	jg	.L178
.L157:
	movl	%r12d, %edx
	leaq	.LC64(%rip), %rcx
	call	printf
.L145:
	movq	%r13, %rax
	addq	$72, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4
	.p2align 3
.L151:
	movzwl	%r8w, %edx
	leaq	.LC65(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L145
	.p2align 4
	.p2align 3
.L177:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L149
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L149
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L148:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L145
	.p2align 4
	.p2align 3
.L149:
	xorl	%r13d, %r13d
	jmp	.L148
	.p2align 4
	.p2align 3
.L178:
	leaq	32(%rsp), %rcx
	movq	%rsi, %r9
	movslq	%ebx, %r8
	movl	$3, %edx
	call	fread
	movzbl	33(%rsp), %edx
	movslq	%r12d, %rax
	leal	(%rbx,%rbx,2), %ecx
	movsbl	34(%rsp), %r8d
	movzbl	32(%rsp), %r9d
	salq	$2, %rax
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 0(%r13,%rax)
	leal	1(%r12), %edx
	cmpl	$1, %ebx
	je	.L168
	movzbl	36(%rsp), %edx
	movsbl	37(%rsp), %r8d
	movzbl	35(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 4(%r13,%rax)
	leal	2(%r12), %edx
	cmpl	$6, %ecx
	jle	.L168
	movzbl	39(%rsp), %edx
	movsbl	40(%rsp), %r8d
	movzbl	38(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 8(%r13,%rax)
	leal	3(%r12), %edx
	cmpl	$9, %ecx
	jle	.L168
	movzbl	42(%rsp), %edx
	movsbl	43(%rsp), %r8d
	movzbl	41(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 12(%r13,%rax)
	leal	4(%r12), %edx
	cmpl	$12, %ecx
	jle	.L168
	movzbl	45(%rsp), %edx
	movsbl	46(%rsp), %r8d
	movzbl	44(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 16(%r13,%rax)
	leal	5(%r12), %edx
	cmpl	$15, %ecx
	jle	.L168
	movzbl	48(%rsp), %edx
	movsbl	49(%rsp), %r8d
	movzbl	47(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 20(%r13,%rax)
	leal	6(%r12), %edx
	cmpl	$18, %ecx
	jle	.L168
	movzbl	51(%rsp), %edx
	movsbl	52(%rsp), %r8d
	movzbl	50(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 24(%r13,%rax)
	leal	7(%r12), %edx
	cmpl	$21, %ecx
	jle	.L168
	movzbl	54(%rsp), %edx
	movsbl	55(%rsp), %r8d
	movzbl	53(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 28(%r13,%rax)
	leal	8(%r12), %edx
	cmpl	$24, %ecx
	jle	.L168
	movzbl	57(%rsp), %edx
	movsbl	58(%rsp), %r8d
	movzbl	56(%rsp), %r9d
	sall	$8, %edx
	sall	$16, %r8d
	orl	%r9d, %edx
	orl	%r8d, %edx
	movl	%edx, 32(%r13,%rax)
	leal	9(%r12), %edx
	cmpl	$27, %ecx
	jle	.L168
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L157
	.p2align 4
	.p2align 3
.L154:
	xorl	%r13d, %r13d
	jmp	.L153
	.p2align 4
	.p2align 3
.L168:
	movl	%edx, %r12d
	jmp	.L157
	.p2align 4
	.p2align 3
.L159:
	xorl	%r12d, %r12d
	jmp	.L155
	.seh_endproc
	.section .rdata,"dr"
.LC66:
	.ascii "rb\0"
	.align 8
.LC67:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC68:
	.ascii "Aborting.\12\0"
	.align 8
.LC69:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC70:
	.ascii "wb\0"
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
	subq	$152, %rsp
	.seh_stackalloc	152
	.seh_endprologue
	movq	24(%rdx), %rbx
	movslq	%r9d, %r14
	movq	%rcx, %r12
	movq	8(%rdx), %r9
	movq	16(%rdx), %rcx
	movq	%r8, %r13
	movq	(%rdx), %r8
	movq	32(%rdx), %rdx
	leal	0(,%r14,4), %eax
	movq	%r14, %rbp
	movq	%rbx, 120(%rsp)
	movl	%eax, 136(%rsp)
	movq	%rbx, 72(%rsp)
	movl	%eax, 88(%rsp)
	movq	%rcx, 112(%rsp)
	movq	%rcx, 64(%rsp)
	movq	%r12, %rcx
	movq	%r9, 104(%rsp)
	movq	%rdx, 128(%rsp)
	movq	%rdx, 80(%rsp)
	leaq	.LC66(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L180
	movq	%r12, %rdx
	leaq	.LC67(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC69(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L184
	.p2align 4
	.p2align 3
.L202:
	cmpb	$78, %al
	je	.L201
	movq	%rdi, %rcx
	call	printf
.L184:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L202
.L180:
	movq	%r12, %rcx
	leaq	.LC70(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L203
	cmpw	$24, %ax
	je	.L204
.L186:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L179:
	addq	$152, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4
	.p2align 3
.L201:
	leaq	.LC68(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L179
	.p2align 4
	.p2align 3
.L204:
	cmpl	$7, %ebp
	jle	.L192
	leal	-8(%rbp), %r15d
	movq	%r13, %rsi
	leaq	96(%rsp), %rbx
	leaq	112(%rsp), %rdi
	shrl	$3, %r15d
	movl	%r15d, %eax
	salq	$5, %rax
	leaq	32(%r13,%rax), %r14
	.p2align 4
	.p2align 3
.L188:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC71(%rip), %ymm1, %ymm0
	vmovdqu	%ymm0, 96(%rsp)
	vzeroupper
	call	fwrite
	addq	$32, %rsi
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rdi, %rcx
	call	fwrite
	cmpq	%r14, %rsi
	jne	.L188
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L187:
	testl	%ebp, %ebp
	jle	.L186
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L190:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L190
	jmp	.L186
	.p2align 4
	.p2align 3
.L203:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L186
.L192:
	xorl	%eax, %eax
	jmp	.L187
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC72:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC73:
	.ascii "Some param parse error occured\12\0"
.LC74:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC75:
	.ascii "Verified file header, continuing...\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$184, %rsp
	.seh_stackalloc	184
	.seh_endprologue
	movl	%ecx, %r12d
	movq	%rdx, %r13
	call	__main
	call	GEN_TRIG_TABLE
	leaq	96(%rsp), %r8
	movq	%r13, %rdx
	movl	%r12d, %ecx
	call	parseParams
	cmpl	$1, %eax
	je	.L217
	cmpl	$2, %eax
	je	.L218
	movq	96(%rsp), %r13
	leaq	.LC66(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L219
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L210
.L211:
	movl	$1, %eax
.L205:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L210:
	leaq	.LC75(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L211
	movq	%r12, %rcx
	call	fclose
	movzwl	162(%rsp), %ecx
	xorl	%edx, %edx
	movl	168(%rsp), %eax
	vmovss	124(%rsp), %xmm3
	vmovss	120(%rsp), %xmm2
	vmovss	116(%rsp), %xmm1
	vmovss	112(%rsp), %xmm0
	shrw	$3, %cx
	movzwl	%cx, %ecx
	divl	%ecx
	movl	%eax, %r12d
	leaq	92(%rsp), %rax
	movq	%rax, 48(%rsp)
	movl	152(%rsp), %eax
	movl	%r12d, 32(%rsp)
	movl	%eax, 40(%rsp)
	call	upsampleCurve
	movl	%r12d, %r8d
	movq	%rbx, %rdx
	movl	$4095, 40(%rsp)
	movq	%rax, %r14
	movl	92(%rsp), %eax
	movl	152(%rsp), %ecx
	movq	%r14, %r9
	movl	%eax, 32(%rsp)
	call	fastSincInterp
	movq	%r14, %rcx
	movq	%rax, %r12
	call	free
	movl	92(%rsp), %r9d
	movq	%r13, %rdx
	movq	104(%rsp), %rcx
	movq	%r12, %r8
	call	writeWavfile
	movq	-8(%rbx), %rcx
	call	free
	xorl	%eax, %eax
	testq	%r12, %r12
	je	.L205
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L205
.L218:
	leaq	.LC73(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L205
.L219:
	movq	%r13, %rdx
	leaq	.LC74(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L205
.L217:
	leaq	.LC72(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L205
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
.LC0:
	.long	0
	.long	0
	.set	.LC1,.LC58
	.align 8
.LC2:
	.long	1413754136
	.long	1074340347
	.align 8
.LC3:
	.long	0
	.long	1063256064
	.align 8
.LC4:
	.long	1841940611
	.long	1079271216
	.align 8
.LC5:
	.long	1413754136
	.long	1065951739
	.align 8
.LC6:
	.long	0
	.long	1071644672
	.set	.LC7,.LC10
	.align 4
.LC8:
	.long	1011421147
	.align 4
.LC9:
	.long	1056964608
	.align 32
.LC10:
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.align 32
.LC11:
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.align 32
.LC12:
	.quad	549755814016
	.quad	549755814016
	.quad	549755814016
	.quad	549755814016
	.align 32
.LC13:
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.align 32
.LC14:
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.set	.LC15,.LC24
	.align 8
.LC16:
	.long	1413754136
	.long	1075388923
	.set	.LC17,.LC26
	.set	.LC18,.LC27
	.set	.LC19,.LC28
	.set	.LC20,.LC29
	.set	.LC21,.LC30
	.set	.LC22,.LC31
	.set	.LC23,.LC33
	.align 32
.LC24:
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.align 32
.LC25:
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.long	-1060565029
	.align 32
.LC26:
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.long	789717965
	.align 32
.LC27:
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.long	-1295496101
	.align 32
.LC28:
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.long	908674213
	.align 32
.LC29:
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.long	-1187647768
	.align 32
.LC30:
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.long	1004073975
	.align 32
.LC31:
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.long	-1110474373
	.align 32
.LC32:
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.long	-1068953637
	.align 32
.LC33:
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.long	867941678
	.align 32
.LC34:
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.long	-1279541970
	.set	.LC49,.LC59
	.align 4
.LC54:
	.long	1040187392
	.align 8
.LC55:
	.long	0
	.long	1075838976
	.align 8
.LC56:
	.long	0
	.long	1072693248
	.align 32
.LC58:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.align 32
.LC59:
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.align 32
.LC60:
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.align 32
.LC63:
	.byte	-1
	.byte	0
	.byte	1
	.byte	2
	.byte	-1
	.byte	3
	.byte	4
	.byte	5
	.byte	-1
	.byte	6
	.byte	7
	.byte	8
	.byte	-1
	.byte	9
	.byte	10
	.byte	11
	.byte	-1
	.byte	16
	.byte	17
	.byte	18
	.byte	-1
	.byte	19
	.byte	20
	.byte	21
	.byte	-1
	.byte	22
	.byte	23
	.byte	24
	.byte	-1
	.byte	25
	.byte	26
	.byte	27
	.align 32
.LC71:
	.byte	0
	.byte	1
	.byte	2
	.byte	4
	.byte	5
	.byte	6
	.byte	8
	.byte	9
	.byte	10
	.byte	12
	.byte	13
	.byte	14
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	16
	.byte	17
	.byte	18
	.byte	20
	.byte	21
	.byte	22
	.byte	24
	.byte	25
	.byte	26
	.byte	28
	.byte	29
	.byte	30
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.ident	"GCC: (Rev1, Built by MSYS2 project) 11.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	sin;	.scl	2;	.type	32;	.endef
	.def	atof;	.scl	2;	.type	32;	.endef
	.def	strncmp;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	clock_gettime;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
