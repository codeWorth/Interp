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
	vmovdqa	.LC12(%rip), %ymm4
	leaq	f_sineTable_4q(%rip), %rax
	vmulps	.LC10(%rip), %ymm1, %ymm0
	vcvtps2dq	%ymm0, %ymm0
	vpand	%ymm4, %ymm0, %ymm5
	vcvtdq2ps	%ymm0, %ymm2
	vpaddd	.LC13(%rip), %ymm0, %ymm0
	vfmadd132ps	.LC11(%rip), %ymm1, %ymm2
	vxorps	%xmm1, %xmm1, %xmm1
	vcmpps	$0, %ymm1, %ymm1, %ymm1
	vmovaps	%ymm1, %ymm6
	vgatherdps	%ymm6, (%rax,%ymm5,4), %ymm3
	vpand	%ymm4, %ymm0, %ymm0
	vgatherdps	%ymm1, (%rax,%ymm0,4), %ymm4
	vmulps	.LC14(%rip), %ymm3, %ymm0
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
	vmovss	.LC15(%rip), %xmm3
	vmovss	.LC17(%rip), %xmm2
	vmovss	.LC23(%rip), %xmm4
	vdivss	%xmm3, %xmm0, %xmm1
	vcvttss2sil	%xmm1, %eax
	movl	%eax, %edx
	movl	%eax, %ecx
	vxorps	%xmm1, %xmm1, %xmm1
	shrl	$31, %edx
	sarl	$31, %ecx
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	addl	%eax, %edx
	andl	$1, %eax
	xorl	%ecx, %eax
	sarl	%edx
	andl	$1, %ecx
	negl	%edx
	addl	%ecx, %eax
	subl	%eax, %edx
	vcvtsi2sdl	%edx, %xmm1, %xmm1
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
.LC24:
	.ascii "Out file should be last param!\0"
.LC25:
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
	jle	.L32
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L31
	.p2align 4
	.p2align 3
.L38:
	cmpb	$0, 1(%rdx)
	jne	.L21
	movq	%rcx, 0(%rbp)
.L22:
	incl	%esi
	xorl	%edx, %edx
.L18:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L36
.L31:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L34
	cmpb	$104, 1(%rcx)
	jne	.L34
	cmpb	$0, 2(%rcx)
	je	.L33
	.p2align 4
	.p2align 3
.L34:
	testq	%rdx, %rdx
	je	.L37
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L38
.L21:
	cmpl	$115, %eax
	jne	.L24
	cmpb	$0, 1(%rdx)
	jne	.L24
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L22
	.p2align 4
	.p2align 3
.L37:
	cmpb	$45, (%rcx)
	je	.L39
	cmpl	%ebx, %r12d
	jne	.L40
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L31
	.p2align 4
	.p2align 3
.L36:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L12:
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
.L24:
	cmpl	$101, %eax
	jne	.L26
	cmpb	$0, 1(%rdx)
	jne	.L26
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L22
	.p2align 4
	.p2align 3
.L26:
	cmpl	$100, %eax
	jne	.L28
	cmpb	$0, 1(%rdx)
	jne	.L28
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L22
	.p2align 4
	.p2align 3
.L28:
	cmpl	$72, %eax
	je	.L41
.L30:
	leaq	.LC25(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L12
	.p2align 4
	.p2align 3
.L39:
	leaq	1(%rcx), %rdx
	jmp	.L18
	.p2align 4
	.p2align 3
.L41:
	cmpb	$0, 1(%rdx)
	jne	.L30
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L22
	.p2align 4
	.p2align 3
.L33:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L40:
	leaq	.LC24(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L12
.L32:
	movl	$2, %eax
	jmp	.L12
	.seh_endproc
	.section .rdata,"dr"
.LC26:
	.ascii "RIFF\0"
	.align 8
.LC27:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC28:
	.ascii "WAVE\0"
	.align 8
.LC29:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC30:
	.ascii "fmt \0"
	.align 8
.LC31:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC32:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC33:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC34:
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
	leaq	.LC26(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L56
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC28(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L57
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC30(%rip), %rdx
	call	strncmp
	testl	%eax, %eax
	jne	.L58
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L59
	cmpw	$1, 20(%r12)
	jne	.L60
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L49
	cmpw	$32, %dx
	jne	.L61
.L49:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L56:
	movq	%r12, %rdx
	leaq	.LC27(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L42:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L59:
	leaq	.LC32(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L57:
	movq	%r13, %rdx
	leaq	.LC29(%rip), %rcx
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
	leaq	.LC31(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L60:
	leaq	.LC33(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L61:
	leaq	.LC34(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L42
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
	je	.L65
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L65
	leaq	32(%rax), %r9
	andq	$-32, %r9
	movq	%rax, -8(%r9)
.L64:
	testl	%ebx, %ebx
	jle	.L72
	leal	-1(%rbx), %eax
	cmpl	$6, %eax
	jbe	.L85
	movl	%ebx, %edx
	movslq	%esi, %rax
	shrl	$3, %edx
	leaq	(%r9,%rax,4), %rcx
	xorl	%eax, %eax
	salq	$5, %rdx
	.p2align 4
	.p2align 3
.L70:
	vcvtdq2ps	(%rdi,%rax), %ymm0
	vmovups	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L70
	movl	%ebx, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%edx, %ebx
	je	.L72
.L69:
	movl	%ebx, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$2, %ecx
	jbe	.L74
	vcvtdq2ps	(%rdi,%rdx,4), %xmm0
	movslq	%esi, %rcx
	addq	%rcx, %rdx
	vmovups	%xmm0, (%r9,%rdx,4)
	movl	%r8d, %edx
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%edx, %r8d
	je	.L72
.L74:
	leal	(%rsi,%rax), %edx
	movslq	%eax, %r8
	vxorps	%xmm0, %xmm0, %xmm0
	movslq	%edx, %rdx
	vcvtsi2ssl	(%rdi,%r8,4), %xmm0, %xmm1
	leaq	0(,%r8,4), %rcx
	vmovss	%xmm1, (%r9,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %ebx
	jle	.L72
	addl	%esi, %edx
	addl	$2, %eax
	vcvtsi2ssl	4(%rdi,%rcx), %xmm0, %xmm1
	movslq	%edx, %rdx
	vmovss	%xmm1, (%r9,%rdx,4)
	cmpl	%eax, %ebx
	jle	.L72
	addl	%esi, %eax
	vcvtsi2ssl	8(%rdi,%rcx), %xmm0, %xmm0
	cltq
	vmovss	%xmm0, (%r9,%rax,4)
.L72:
	testl	%esi, %esi
	jle	.L62
	movslq	%esi, %rdx
	subl	%esi, %ebp
	movl	%esi, %r8d
	leal	-1(%rsi), %eax
	addq	%rdx, %rbx
	leaq	0(,%rbx,4), %rcx
	leaq	-4(%rcx), %rdx
	cmpq	$24, %rdx
	jbe	.L76
	cmpl	$2, %eax
	jbe	.L76
	cmpl	$6, %eax
	jbe	.L86
	movl	%esi, %edx
	vbroadcastss	%xmm6, %ymm0
	addq	%r9, %rcx
	xorl	%eax, %eax
	shrl	$3, %edx
	salq	$5, %rdx
	.p2align 4
	.p2align 3
.L78:
	vmovaps	%ymm0, (%r9,%rax)
	vmovups	%ymm0, (%rcx,%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L78
	movl	%esi, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%edx, %esi
	je	.L62
	movl	%esi, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %ecx
	cmpl	$2, %ecx
	jbe	.L81
.L77:
	vshufps	$0, %xmm6, %xmm6, %xmm0
	addq	%rdx, %rbx
	vmovaps	%xmm0, (%r9,%rdx,4)
	movl	%r8d, %edx
	vmovups	%xmm0, (%r9,%rbx,4)
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%edx, %r8d
	je	.L62
.L81:
	movslq	%eax, %rcx
	leal	0(%rbp,%rax), %edx
	movslq	%edx, %rdx
	salq	$2, %rcx
	vmovss	%xmm6, (%r9,%rcx)
	vmovss	%xmm6, (%r9,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jle	.L62
	addl	%ebp, %edx
	addl	$2, %eax
	vmovss	%xmm6, 4(%r9,%rcx)
	movslq	%edx, %rdx
	vmovss	%xmm6, (%r9,%rdx,4)
	cmpl	%eax, %esi
	jle	.L62
	addl	%ebp, %eax
	vmovss	%xmm6, 8(%r9,%rcx)
	cltq
	vmovss	%xmm6, (%r9,%rax,4)
.L62:
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
.L65:
	xorl	%r9d, %r9d
	jmp	.L64
	.p2align 4
	.p2align 3
.L76:
	movl	%esi, %r8d
	movq	%r9, %rax
	movslq	%ebp, %rbp
	leaq	(%r9,%r8,4), %rdx
	.p2align 4
	.p2align 3
.L83:
	vmovss	%xmm6, (%rax)
	vmovss	%xmm6, (%rax,%rbp,4)
	addq	$4, %rax
	cmpq	%rax, %rdx
	jne	.L83
	jmp	.L62
.L85:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L69
.L86:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L77
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC35:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC36:
	.ascii "curveDuration > 0.f\0"
.LC37:
	.ascii "Generated %d upsample times.\12\0"
.LC39:
	.ascii "\11Start to mid: %d\0"
.LC40:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC41:
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
	jbe	.L119
.L100:
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
	jle	.L120
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L109
	.p2align 4
	.p2align 3
.L121:
	vmulss	%xmm0, %xmm9, %xmm0
.L106:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L110
.L109:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L121
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L118
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L109
.L110:
	movl	%r8d, %edx
	leaq	.LC37(%rip), %rcx
	call	printf
	vcomiss	.LC38(%rip), %xmm10
	jb	.L103
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC39(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L103:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L111
	leaq	.LC40(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L111:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC41(%rip), %rcx
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
.L118:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L106
	.p2align 4
	.p2align 3
.L119:
	movl	$171, %r8d
	leaq	.LC35(%rip), %rdx
	leaq	.LC36(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L100
	.p2align 4
	.p2align 3
.L120:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L110
	.seh_endproc
	.section .rdata,"dr"
.LC42:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC46:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC47:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC48:
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
	movl	344(%rsp), %ebp
	movl	336(%rsp), %r14d
	movq	%rdx, %r12
	movl	%ebp, %edx
	movl	%ecx, 304(%rsp)
	movl	%r8d, %r15d
	shrl	$31, %edx
	movq	%r9, %r13
	leal	0(%rbp,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L123
	movl	$227, %r8d
	leaq	.LC35(%rip), %rdx
	leaq	.LC42(%rip), %rcx
	call	*__imp__assert(%rip)
.L123:
	vxorps	%xmm6, %xmm6, %xmm6
	vmovsd	.LC45(%rip), %xmm7
	movl	%r15d, %edx
	vxorps	%xmm3, %xmm3, %xmm3
	vcvtsi2ssl	%ebp, %xmm6, %xmm0
	vmulss	.LC43(%rip), %xmm0, %xmm0
	movq	%r12, %rcx
	movslq	%r14d, %r15
	vroundss	$10, %xmm0, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vfmadd132sd	.LC44(%rip), %xmm7, %xmm0
	vcvttsd2sil	%xmm0, %ebx
	movl	%ebx, %esi
	shrl	$31, %esi
	addl	%ebx, %esi
	sarl	%esi
	movl	%esi, %r8d
	call	padAndFloat
	movq	%rax, %rdi
	movq	%r15, %rax
	salq	$2, %rax
	je	.L126
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L126
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L125:
	movl	%r14d, %edx
	leaq	.LC46(%rip), %rcx
	movl	%ebp, %r8d
	call	printf
	xorl	%ecx, %ecx
	leaq	32(%rsp), %rdx
	call	clock_gettime
	testl	%r14d, %r14d
	jle	.L137
	vmovsd	.LC2(%rip), %xmm15
	vmovss	.LC15(%rip), %xmm4
	vcvtsi2ssl	304(%rsp), %xmm6, %xmm0
	xorl	%r11d, %r11d
	vmovsd	.LC16(%rip), %xmm14
	vmovss	.LC17(%rip), %xmm13
	vmovd	%xmm0, %ebp
	vmovss	.LC18(%rip), %xmm12
	.p2align 4
	.p2align 3
.L136:
	vmovd	%ebp, %xmm5
	vmulss	0(%r13,%r11,4), %xmm5, %xmm8
	vcvttss2sil	%xmm8, %eax
	testl	%ebx, %ebx
	jle	.L138
	vmovss	.LC23(%rip), %xmm5
	movl	%eax, %ecx
	cltq
	vxorpd	%xmm3, %xmm3, %xmm3
	subl	%esi, %ecx
	leaq	(%rdi,%rax,4), %r8
	vxorps	%xmm7, %xmm7, %xmm7
	leal	(%rbx,%rcx), %r9d
	.p2align 4
	.p2align 3
.L135:
	vcvtsi2ssl	%ecx, %xmm6, %xmm0
	vsubss	%xmm0, %xmm8, %xmm0
	vucomiss	%xmm7, %xmm0
	jp	.L139
	je	.L131
.L139:
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmovss	.LC22(%rip), %xmm10
	incl	%ecx
	addq	$4, %r8
	vmulsd	%xmm15, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm2
	vdivss	%xmm4, %xmm2, %xmm1
	vcvttss2sil	%xmm1, %edx
	movl	%edx, %eax
	movl	%edx, %r10d
	vcvtss2sd	%xmm2, %xmm2, %xmm2
	shrl	$31, %eax
	sarl	$31, %r10d
	addl	%edx, %eax
	andl	$1, %edx
	xorl	%r10d, %edx
	sarl	%eax
	andl	$1, %r10d
	negl	%eax
	addl	%edx, %r10d
	subl	%r10d, %eax
	vcvtsi2sdl	%eax, %xmm6, %xmm1
	vfmadd132sd	%xmm14, %xmm2, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm2
	vaddss	%xmm4, %xmm1, %xmm11
	vmovaps	%xmm2, %xmm9
	vsubss	%xmm5, %xmm11, %xmm11
	vfmadd132ss	%xmm13, %xmm12, %xmm9
	vfmadd213ss	.LC19(%rip), %xmm2, %xmm9
	vfmadd213ss	.LC20(%rip), %xmm2, %xmm9
	vfmadd213ss	.LC21(%rip), %xmm2, %xmm9
	vfmadd231ss	%xmm9, %xmm2, %xmm10
	vsubss	%xmm4, %xmm1, %xmm9
	vcvtss2sd	-4(%r8), %xmm6, %xmm2
	vaddss	%xmm5, %xmm9, %xmm9
	vmulss	%xmm11, %xmm9, %xmm9
	vmulss	%xmm10, %xmm9, %xmm9
	vmulss	%xmm1, %xmm9, %xmm1
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	vdivsd	%xmm0, %xmm1, %xmm1
	vfmadd231sd	%xmm1, %xmm2, %xmm3
	cmpl	%r9d, %ecx
	jne	.L135
.L134:
	vcvttsd2sil	%xmm3, %eax
.L130:
	movl	%eax, (%r12,%r11,4)
	incq	%r11
	cmpq	%r11, %r15
	jne	.L136
.L137:
	xorl	%ecx, %ecx
	leaq	48(%rsp), %rdx
	call	clock_gettime
	testq	%rdi, %rdi
	je	.L129
	movq	-8(%rdi), %rcx
	call	free
.L129:
	movl	56(%rsp), %eax
	subl	40(%rsp), %eax
	leaq	.LC47(%rip), %rcx
	movq	48(%rsp), %rdx
	subq	32(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC48(%rip), %rcx
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
.L131:
	vcvtss2sd	(%r8), %xmm6, %xmm0
	incl	%ecx
	addq	$4, %r8
	vaddsd	%xmm0, %xmm3, %xmm3
	cmpl	%ecx, %r9d
	jne	.L135
	jmp	.L134
	.p2align 4
	.p2align 3
.L138:
	xorl	%eax, %eax
	jmp	.L130
.L126:
	xorl	%r12d, %r12d
	jmp	.L125
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
.LC50:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC51:
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
	je	.L180
	cmpw	$24, %r8w
	jne	.L154
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L157
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L157
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L156:
	cmpl	$7, %edi
	jle	.L162
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L159
	.p2align 4
	.p2align 3
.L179:
	vzeroupper
.L159:
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
	vpshufb	.LC49(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L179
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L158:
	testl	%ebx, %ebx
	jg	.L181
.L160:
	movl	%r12d, %edx
	leaq	.LC50(%rip), %rcx
	call	printf
.L148:
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
.L154:
	movzwl	%r8w, %edx
	leaq	.LC51(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L148
	.p2align 4
	.p2align 3
.L180:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L152
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L152
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L151:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L148
	.p2align 4
	.p2align 3
.L152:
	xorl	%r13d, %r13d
	jmp	.L151
	.p2align 4
	.p2align 3
.L181:
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
	je	.L171
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
	jle	.L171
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
	jle	.L171
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
	jle	.L171
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
	jle	.L171
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
	jle	.L171
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
	jle	.L171
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
	jle	.L171
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
	jle	.L171
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L160
	.p2align 4
	.p2align 3
.L157:
	xorl	%r13d, %r13d
	jmp	.L156
	.p2align 4
	.p2align 3
.L171:
	movl	%edx, %r12d
	jmp	.L160
	.p2align 4
	.p2align 3
.L162:
	xorl	%r12d, %r12d
	jmp	.L158
	.seh_endproc
	.section .rdata,"dr"
.LC52:
	.ascii "rb\0"
	.align 8
.LC53:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC54:
	.ascii "Aborting.\12\0"
	.align 8
.LC55:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC56:
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
	leaq	.LC52(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L183
	movq	%r12, %rdx
	leaq	.LC53(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC55(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L187
	.p2align 4
	.p2align 3
.L205:
	cmpb	$78, %al
	je	.L204
	movq	%rdi, %rcx
	call	printf
.L187:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L205
.L183:
	movq	%r12, %rcx
	leaq	.LC56(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L206
	cmpw	$24, %ax
	je	.L207
.L189:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L182:
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
.L204:
	leaq	.LC54(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L182
	.p2align 4
	.p2align 3
.L207:
	cmpl	$7, %ebp
	jle	.L195
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
.L191:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC57(%rip), %ymm1, %ymm0
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
	jne	.L191
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L190:
	testl	%ebp, %ebp
	jle	.L189
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L193:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L193
	jmp	.L189
	.p2align 4
	.p2align 3
.L206:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L189
.L195:
	xorl	%eax, %eax
	jmp	.L190
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC58:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC59:
	.ascii "Some param parse error occured\12\0"
.LC60:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC61:
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
	je	.L220
	cmpl	$2, %eax
	je	.L221
	movq	96(%rsp), %r13
	leaq	.LC52(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L222
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L213
.L214:
	movl	$1, %eax
.L208:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L213:
	leaq	.LC61(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L214
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
	je	.L208
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L208
.L221:
	leaq	.LC59(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L208
.L222:
	movq	%r13, %rdx
	leaq	.LC60(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L208
.L220:
	leaq	.LC58(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L208
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
	.set	.LC1,.LC0
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
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.align 32
.LC13:
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
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
	.align 4
.LC15:
	.long	1078530011
	.align 8
.LC16:
	.long	1413754136
	.long	1075388923
	.align 4
.LC17:
	.long	789717965
	.align 4
.LC18:
	.long	-1295496101
	.align 4
.LC19:
	.long	908674213
	.align 4
.LC20:
	.long	-1187647768
	.align 4
.LC21:
	.long	1004073975
	.align 4
.LC22:
	.long	-1110474373
	.align 4
.LC23:
	.long	867941678
	.align 4
.LC38:
	.long	1065353216
	.align 4
.LC43:
	.long	1040187392
	.align 8
.LC44:
	.long	0
	.long	1075838976
	.align 8
.LC45:
	.long	0
	.long	1072693248
	.align 32
.LC49:
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
.LC57:
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
