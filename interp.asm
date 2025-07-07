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
	.globl	chebSin
	.def	chebSin;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSin
chebSin:
	.seh_endprologue
	vmovss	.LC7(%rip), %xmm3
	vmovss	.LC9(%rip), %xmm2
	vmovss	.LC15(%rip), %xmm4
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
	vfmadd132sd	.LC8(%rip), %xmm0, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm0
	vfmadd213ss	.LC10(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC11(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC12(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC13(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC14(%rip), %xmm0, %xmm2
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
.LC16:
	.ascii "Out file should be last param!\0"
.LC17:
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
	jle	.L31
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L30
	.p2align 4
	.p2align 3
.L37:
	cmpb	$0, 1(%rdx)
	jne	.L20
	movq	%rcx, 0(%rbp)
.L21:
	incl	%esi
	xorl	%edx, %edx
.L17:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L35
.L30:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L33
	cmpb	$104, 1(%rcx)
	jne	.L33
	cmpb	$0, 2(%rcx)
	je	.L32
	.p2align 4
	.p2align 3
.L33:
	testq	%rdx, %rdx
	je	.L36
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L37
.L20:
	cmpl	$115, %eax
	jne	.L23
	cmpb	$0, 1(%rdx)
	jne	.L23
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L21
	.p2align 4
	.p2align 3
.L36:
	cmpb	$45, (%rcx)
	je	.L38
	cmpl	%ebx, %r12d
	jne	.L39
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L30
	.p2align 4
	.p2align 3
.L35:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L11:
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
.L23:
	cmpl	$101, %eax
	jne	.L25
	cmpb	$0, 1(%rdx)
	jne	.L25
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L21
	.p2align 4
	.p2align 3
.L25:
	cmpl	$100, %eax
	jne	.L27
	cmpb	$0, 1(%rdx)
	jne	.L27
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L21
	.p2align 4
	.p2align 3
.L27:
	cmpl	$72, %eax
	je	.L40
.L29:
	leaq	.LC17(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L11
	.p2align 4
	.p2align 3
.L38:
	leaq	1(%rcx), %rdx
	jmp	.L17
	.p2align 4
	.p2align 3
.L40:
	cmpb	$0, 1(%rdx)
	jne	.L29
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L21
	.p2align 4
	.p2align 3
.L32:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L39:
	leaq	.LC16(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L11
.L31:
	movl	$2, %eax
	jmp	.L11
	.seh_endproc
	.section .rdata,"dr"
.LC18:
	.ascii "RIFF\0"
	.align 8
.LC19:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC20:
	.ascii "WAVE\0"
	.align 8
.LC21:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC22:
	.ascii "fmt \0"
	.align 8
.LC23:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC24:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC25:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC26:
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
	leaq	.LC18(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L55
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC20(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L56
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC22(%rip), %rdx
	call	strncmp
	testl	%eax, %eax
	jne	.L57
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L58
	cmpw	$1, 20(%r12)
	jne	.L59
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L48
	cmpw	$32, %dx
	jne	.L60
.L48:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L55:
	movq	%r12, %rdx
	leaq	.LC19(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L41:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L58:
	leaq	.LC24(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L56:
	movq	%r13, %rdx
	leaq	.LC21(%rip), %rcx
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
	leaq	.LC23(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L59:
	leaq	.LC25(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L60:
	leaq	.LC26(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L41
	.seh_endproc
	.p2align 4
	.globl	pad
	.def	pad;	.scl	2;	.type	32;	.endef
	.seh_proc	pad
pad:
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
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movslq	%edx, %rdi
	movq	%rcx, %r13
	movl	%r8d, %ebx
	movl	%r9d, %esi
	leal	(%rdi,%r8,2), %ebp
	movslq	%ebp, %rcx
	salq	$2, %rcx
	je	.L64
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L64
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L63:
	movslq	%ebx, %r15
	leaq	0(,%rdi,4), %r8
	movq	%r13, %rdx
	leaq	0(,%r15,4), %r14
	leaq	(%r12,%r14), %rcx
	call	memcpy
	testl	%ebx, %ebx
	jle	.L61
	leaq	(%rdi,%r15,2), %rcx
	leal	-1(%rbp), %r9d
	movl	%ebx, %r8d
	salq	$2, %rcx
	leal	-1(%rbx), %edx
	movq	%rcx, %rax
	subq	%r14, %rax
	cmpq	%rax, %r14
	setle	%al
	testq	%rcx, %rcx
	setle	%r10b
	orb	%r10b, %al
	je	.L66
	cmpl	$2, %edx
	jbe	.L66
	cmpl	$6, %edx
	jbe	.L76
	shrl	$3, %r8d
	vmovd	%esi, %xmm0
	movq	%r12, %rax
	leaq	-32(%r12,%rcx), %rdx
	salq	$5, %r8
	vpbroadcastd	%xmm0, %ymm0
	addq	%r12, %r8
	.p2align 4
	.p2align 3
.L68:
	vmovdqa	%ymm0, (%rax)
	addq	$32, %rax
	vmovdqu	%ymm0, (%rdx)
	subq	$32, %rdx
	cmpq	%r8, %rax
	jne	.L68
	movl	%ebx, %eax
	andl	$-8, %eax
	movl	%eax, %edx
	cmpl	%eax, %ebx
	je	.L88
	movl	%ebx, %r8d
	subl	%eax, %r8d
	leal	-1(%r8), %r10d
	cmpl	$2, %r10d
	jbe	.L90
	vzeroupper
.L67:
	vmovd	%esi, %xmm1
	addq	%r12, %rcx
	vpshufd	$0, %xmm1, %xmm0
	vmovdqa	%xmm0, (%r12,%rax,4)
	notq	%rax
	vmovdqu	%xmm0, -12(%rcx,%rax,4)
	movl	%r8d, %eax
	andl	$-4, %eax
	addl	%eax, %edx
	cmpl	%eax, %r8d
	je	.L61
.L72:
	movl	%r9d, %ecx
	movslq	%edx, %rax
	leal	1(%rdx), %r8d
	subl	%edx, %ecx
	salq	$2, %rax
	movslq	%ecx, %rcx
	movl	%esi, (%r12,%rax)
	movl	%esi, (%r12,%rcx,4)
	cmpl	%r8d, %ebx
	jle	.L61
	movl	%r9d, %ecx
	addl	$2, %edx
	movl	%esi, 4(%r12,%rax)
	subl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	%esi, (%r12,%rcx,4)
	cmpl	%edx, %ebx
	jle	.L61
	subl	%edx, %r9d
	movl	%esi, 8(%r12,%rax)
	movslq	%r9d, %r9
	movl	%esi, (%r12,%r9,4)
.L61:
	movq	%r12, %rax
	addq	$40, %rsp
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
.L64:
	xorl	%r12d, %r12d
	jmp	.L63
.L90:
	vzeroupper
	jmp	.L72
	.p2align 4
	.p2align 3
.L66:
	movslq	%r9d, %r9
	movl	%ebx, %ebx
	movq	%r12, %rax
	leaq	(%r12,%r9,4), %rdx
	leaq	(%r12,%rbx,4), %rcx
	.p2align 4
	.p2align 3
.L74:
	movl	%esi, (%rax)
	addq	$4, %rax
	movl	%esi, (%rdx)
	subq	$4, %rdx
	cmpq	%rcx, %rax
	jne	.L74
	jmp	.L61
.L88:
	vzeroupper
	jmp	.L61
.L76:
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L67
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC27:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC28:
	.ascii "curveDuration > 0.f\0"
.LC29:
	.ascii "Generated %d upsample times.\12\0"
.LC31:
	.ascii "\11Start to mid: %d\0"
.LC32:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC33:
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
	jbe	.L111
.L92:
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
	jle	.L112
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L101
	.p2align 4
	.p2align 3
.L113:
	vmulss	%xmm0, %xmm9, %xmm0
.L98:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L102
.L101:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L113
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L110
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L101
.L102:
	movl	%r8d, %edx
	leaq	.LC29(%rip), %rcx
	call	printf
	vcomiss	.LC30(%rip), %xmm10
	jb	.L95
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC31(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L95:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L103
	leaq	.LC32(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L103:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC33(%rip), %rcx
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
.L110:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L98
	.p2align 4
	.p2align 3
.L111:
	movl	$166, %r8d
	leaq	.LC27(%rip), %rdx
	leaq	.LC28(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L92
	.p2align 4
	.p2align 3
.L112:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L102
	.seh_endproc
	.section .rdata,"dr"
.LC34:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC38:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC48:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC49:
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
	subq	$248, %rsp
	.seh_stackalloc	248
	vmovaps	%xmm6, 80(%rsp)
	.seh_savexmm	%xmm6, 80
	vmovaps	%xmm7, 96(%rsp)
	.seh_savexmm	%xmm7, 96
	vmovaps	%xmm8, 112(%rsp)
	.seh_savexmm	%xmm8, 112
	vmovaps	%xmm9, 128(%rsp)
	.seh_savexmm	%xmm9, 128
	vmovaps	%xmm10, 144(%rsp)
	.seh_savexmm	%xmm10, 144
	vmovaps	%xmm11, 160(%rsp)
	.seh_savexmm	%xmm11, 160
	vmovaps	%xmm12, 176(%rsp)
	.seh_savexmm	%xmm12, 176
	vmovaps	%xmm13, 192(%rsp)
	.seh_savexmm	%xmm13, 192
	vmovaps	%xmm14, 208(%rsp)
	.seh_savexmm	%xmm14, 208
	vmovaps	%xmm15, 224(%rsp)
	.seh_savexmm	%xmm15, 224
	.seh_endprologue
	movl	360(%rsp), %r13d
	movq	%rdx, %r14
	movl	%r13d, %edx
	movl	%ecx, 320(%rsp)
	movslq	%r8d, %r15
	shrl	$31, %edx
	movq	%r9, %rbp
	leal	0(%r13,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L115
	movl	$222, %r8d
	leaq	.LC27(%rip), %rdx
	leaq	.LC34(%rip), %rcx
	call	*__imp__assert(%rip)
.L115:
	vxorps	%xmm6, %xmm6, %xmm6
	vmovsd	.LC37(%rip), %xmm5
	vcvtsi2ssl	%r13d, %xmm6, %xmm0
	vmulss	.LC35(%rip), %xmm0, %xmm0
	vroundss	$10, %xmm0, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vfmadd132sd	.LC36(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edi
	movl	%edi, %r12d
	shrl	$31, %r12d
	addl	%edi, %r12d
	movl	%r12d, %esi
	andl	$-2, %r12d
	addl	%r15d, %r12d
	sarl	%esi
	movslq	%r12d, %rax
	salq	$2, %rax
	je	.L118
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L118
	leaq	32(%rax), %rbx
	andq	$-32, %rbx
	movq	%rax, -8(%rbx)
.L117:
	movslq	%esi, %r9
	leaq	0(,%r15,4), %r8
	movq	%r14, %rdx
	leaq	(%rbx,%r9,4), %rcx
	movq	%r9, 40(%rsp)
	call	memcpy
	cmpl	$1, %edi
	movq	40(%rsp), %r9
	jle	.L126
	leaq	(%r15,%r9,2), %rcx
	movl	%esi, %eax
	decl	%r12d
	salq	$2, %rcx
	salq	$2, %rax
	movq	%rcx, %rdx
	subq	%rax, %rdx
	cmpq	%rax, %rdx
	setge	%al
	testq	%rcx, %rcx
	setle	%dl
	orb	%dl, %al
	je	.L122
	cmpl	$7, %edi
	jle	.L122
	cmpl	$15, %edi
	jle	.L140
	movl	%esi, %r8d
	leaq	-32(%rbx,%rcx), %rax
	movq	%rbx, %rdx
	vpxor	%xmm0, %xmm0, %xmm0
	shrl	$3, %r8d
	movq	%rax, %r9
	decl	%r8d
	salq	$5, %r8
	subq	%r8, %r9
	leaq	-32(%r9), %r8
	.p2align 4
	.p2align 3
.L124:
	vmovdqa	%ymm0, (%rdx)
	subq	$32, %rax
	vmovdqu	%ymm0, 32(%rax)
	addq	$32, %rdx
	cmpq	%rax, %r8
	jne	.L124
	movl	%esi, %eax
	andl	$-8, %eax
	movl	%eax, %edx
	cmpl	%esi, %eax
	je	.L166
	vzeroupper
.L123:
	movl	%esi, %r8d
	subl	%eax, %r8d
	leal	-1(%r8), %r9d
	cmpl	$2, %r9d
	jbe	.L128
	vpxor	%xmm0, %xmm0, %xmm0
	addq	%rbx, %rcx
	vmovdqa	%xmm0, (%rbx,%rax,4)
	notq	%rax
	vmovdqu	%xmm0, -12(%rcx,%rax,4)
	movl	%r8d, %eax
	andl	$-4, %eax
	addl	%eax, %edx
	cmpl	%eax, %r8d
	je	.L126
.L128:
	movl	%r12d, %ecx
	movslq	%edx, %rax
	leal	1(%rdx), %r8d
	subl	%edx, %ecx
	salq	$2, %rax
	movslq	%ecx, %rcx
	movl	$0, (%rbx,%rax)
	movl	$0, (%rbx,%rcx,4)
	cmpl	%r8d, %esi
	jle	.L126
	movl	%r12d, %ecx
	addl	$2, %edx
	movl	$0, 4(%rbx,%rax)
	subl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	$0, (%rbx,%rcx,4)
	cmpl	%edx, %esi
	jle	.L126
	subl	%edx, %r12d
	movl	$0, 8(%rbx,%rax)
	movslq	%r12d, %rax
	movl	$0, (%rbx,%rax,4)
.L126:
	movslq	352(%rsp), %r15
	movq	%r15, %rax
	salq	$2, %rax
	je	.L120
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L120
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L132:
	movl	352(%rsp), %edx
	movl	%r13d, %r8d
	leaq	.LC38(%rip), %rcx
	call	printf
	leaq	48(%rsp), %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	movl	352(%rsp), %eax
	testl	%eax, %eax
	jle	.L139
	vmovaps	.LC40(%rip), %ymm14
	vmovaps	.LC41(%rip), %ymm13
	leal	-1(%rdi), %r13d
	vxorps	%xmm9, %xmm9, %xmm9
	vmovaps	.LC42(%rip), %ymm12
	vmovdqa	.LC43(%rip), %ymm5
	shrl	$3, %r13d
	vcvtsi2ssl	320(%rsp), %xmm6, %xmm6
	vmovdqa	.LC44(%rip), %ymm11
	vmovd	%xmm6, %r11d
	salq	$3, %r13
	xorl	%r10d, %r10d
	vcmpps	$0, %ymm9, %ymm9, %ymm6
	.p2align 4
	.p2align 3
.L138:
	vmovd	%r11d, %xmm1
	vmulss	0(%rbp,%r10,4), %xmm1, %xmm8
	vcvttss2sil	%xmm8, %eax
	movl	%eax, %edx
	vbroadcastss	%xmm8, %ymm8
	subl	%esi, %edx
	vmovd	%edx, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpaddd	.LC39(%rip), %ymm1, %ymm1
	testl	%edi, %edi
	jle	.L141
	movslq	%eax, %rdx
	vxorpd	%xmm10, %xmm10, %xmm10
	leaq	f_sineTable_4q(%rip), %rcx
	leaq	(%rbx,%rdx,4), %rax
	addq	%r13, %rdx
	leaq	32(%rbx,%rdx,4), %r8
	.p2align 4
	.p2align 3
.L137:
	vcvtdq2ps	%ymm1, %ymm2
	vmovaps	%ymm6, %ymm15
	addq	$32, %rax
	vpaddd	.LC47(%rip), %ymm1, %ymm1
	vsubps	%ymm2, %ymm8, %ymm2
	vmulps	%ymm14, %ymm2, %ymm2
	vmulps	%ymm13, %ymm2, %ymm0
	vcvtps2dq	%ymm0, %ymm0
	vpand	%ymm0, %ymm5, %ymm7
	vcvtdq2ps	%ymm0, %ymm3
	vpaddd	%ymm11, %ymm0, %ymm0
	vgatherdps	%ymm15, (%rcx,%ymm7,4), %ymm4
	vpand	%ymm0, %ymm5, %ymm0
	vmovaps	%ymm6, %ymm15
	vgatherdps	%ymm15, (%rcx,%ymm0,4), %ymm7
	vmulps	.LC45(%rip), %ymm4, %ymm0
	vfmadd132ps	%ymm12, %ymm2, %ymm3
	vfmadd132ps	%ymm3, %ymm7, %ymm0
	vfmadd132ps	%ymm3, %ymm4, %ymm0
	vcmpps	$0, %ymm9, %ymm2, %ymm3
	vdivps	%ymm2, %ymm0, %ymm0
	vcvtdq2ps	-32(%rax), %ymm2
	vblendvps	%ymm3, .LC46(%rip), %ymm0, %ymm0
	vmulps	%ymm0, %ymm2, %ymm2
	vextractf128	$0x1, %ymm2, %xmm0
	vaddps	%xmm2, %xmm0, %xmm0
	vmovhlps	%xmm0, %xmm0, %xmm2
	vaddps	%xmm2, %xmm0, %xmm0
	vshufps	$1, %xmm0, %xmm0, %xmm2
	vaddss	%xmm2, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm10, %xmm10
	cmpq	%rax, %r8
	jne	.L137
	vcvttsd2sil	%xmm10, %eax
.L136:
	movl	%eax, (%r12,%r10,4)
	incq	%r10
	cmpq	%r10, %r15
	jne	.L138
	vzeroupper
.L139:
	xorl	%ecx, %ecx
	leaq	64(%rsp), %rdx
	call	clock_gettime
	testq	%rbx, %rbx
	je	.L135
	movq	-8(%rbx), %rcx
	call	free
.L135:
	movl	72(%rsp), %eax
	subl	56(%rsp), %eax
	leaq	.LC48(%rip), %rcx
	movq	64(%rsp), %rdx
	subq	48(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC49(%rip), %rcx
	call	printf
	nop
	vmovaps	80(%rsp), %xmm6
	movq	%r12, %rax
	vmovaps	96(%rsp), %xmm7
	vmovaps	112(%rsp), %xmm8
	vmovaps	128(%rsp), %xmm9
	vmovaps	144(%rsp), %xmm10
	vmovaps	160(%rsp), %xmm11
	vmovaps	176(%rsp), %xmm12
	vmovaps	192(%rsp), %xmm13
	vmovaps	208(%rsp), %xmm14
	vmovaps	224(%rsp), %xmm15
	addq	$248, %rsp
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
.L141:
	xorl	%eax, %eax
	jmp	.L136
.L120:
	xorl	%r12d, %r12d
	jmp	.L132
.L118:
	xorl	%ebx, %ebx
	jmp	.L117
.L122:
	movslq	%r12d, %r12
	xorl	%eax, %eax
	leaq	(%rbx,%r12,4), %rdx
	.p2align 4
	.p2align 3
.L130:
	movl	$0, (%rbx,%rax,4)
	incq	%rax
	movl	$0, (%rdx)
	subq	$4, %rdx
	cmpl	%eax, %esi
	jg	.L130
	jmp	.L126
.L166:
	vzeroupper
	jmp	.L126
.L140:
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L123
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
.LC51:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC52:
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
	je	.L200
	cmpw	$24, %r8w
	jne	.L174
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L177
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L177
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L176:
	cmpl	$7, %edi
	jle	.L182
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L179
	.p2align 4
	.p2align 3
.L199:
	vzeroupper
.L179:
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
	vpshufb	.LC50(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L199
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L178:
	testl	%ebx, %ebx
	jg	.L201
.L180:
	movl	%r12d, %edx
	leaq	.LC51(%rip), %rcx
	call	printf
.L168:
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
.L174:
	movzwl	%r8w, %edx
	leaq	.LC52(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L168
	.p2align 4
	.p2align 3
.L200:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L172
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L172
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L171:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L168
	.p2align 4
	.p2align 3
.L172:
	xorl	%r13d, %r13d
	jmp	.L171
	.p2align 4
	.p2align 3
.L201:
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
	je	.L191
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
	jle	.L191
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
	jle	.L191
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
	jle	.L191
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
	jle	.L191
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
	jle	.L191
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
	jle	.L191
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
	jle	.L191
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
	jle	.L191
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L180
	.p2align 4
	.p2align 3
.L177:
	xorl	%r13d, %r13d
	jmp	.L176
	.p2align 4
	.p2align 3
.L191:
	movl	%edx, %r12d
	jmp	.L180
	.p2align 4
	.p2align 3
.L182:
	xorl	%r12d, %r12d
	jmp	.L178
	.seh_endproc
	.section .rdata,"dr"
.LC53:
	.ascii "rb\0"
	.align 8
.LC54:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC55:
	.ascii "Aborting.\12\0"
	.align 8
.LC56:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC57:
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
	leaq	.LC53(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L203
	movq	%r12, %rdx
	leaq	.LC54(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC56(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L207
	.p2align 4
	.p2align 3
.L225:
	cmpb	$78, %al
	je	.L224
	movq	%rdi, %rcx
	call	printf
.L207:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L225
.L203:
	movq	%r12, %rcx
	leaq	.LC57(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L226
	cmpw	$24, %ax
	je	.L227
.L209:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L202:
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
.L224:
	leaq	.LC55(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L202
	.p2align 4
	.p2align 3
.L227:
	cmpl	$7, %ebp
	jle	.L215
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
.L211:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC58(%rip), %ymm1, %ymm0
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
	jne	.L211
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L210:
	testl	%ebp, %ebp
	jle	.L209
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L213:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L213
	jmp	.L209
	.p2align 4
	.p2align 3
.L226:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L209
.L215:
	xorl	%eax, %eax
	jmp	.L210
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC59:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC60:
	.ascii "Some param parse error occured\12\0"
.LC61:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC62:
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
	je	.L240
	cmpl	$2, %eax
	je	.L241
	movq	96(%rsp), %r13
	leaq	.LC53(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L242
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L233
.L234:
	movl	$1, %eax
.L228:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L233:
	leaq	.LC62(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L234
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
	je	.L228
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L228
.L241:
	leaq	.LC60(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L228
.L242:
	movq	%r13, %rdx
	leaq	.LC61(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L228
.L240:
	leaq	.LC59(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L228
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
	.set	.LC7,.LC40
	.align 8
.LC8:
	.long	1413754136
	.long	1075388923
	.align 4
.LC9:
	.long	789717965
	.align 4
.LC10:
	.long	-1295496101
	.align 4
.LC11:
	.long	908674213
	.align 4
.LC12:
	.long	-1187647768
	.align 4
.LC13:
	.long	1004073975
	.align 4
.LC14:
	.long	-1110474373
	.align 4
.LC15:
	.long	867941678
	.set	.LC30,.LC46
	.align 4
.LC35:
	.long	1040187392
	.align 8
.LC36:
	.long	0
	.long	1075838976
	.align 8
.LC37:
	.long	0
	.long	1072693248
	.align 32
.LC39:
	.long	7
	.long	6
	.long	5
	.long	4
	.long	3
	.long	2
	.long	1
	.long	0
	.align 32
.LC40:
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.long	1078530011
	.align 32
.LC41:
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.align 32
.LC42:
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.align 32
.LC43:
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.align 32
.LC44:
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.align 32
.LC45:
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.align 32
.LC46:
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.align 32
.LC47:
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.long	8
	.align 32
.LC50:
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
.LC58:
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
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	clock_gettime;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
