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
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$88, %rsp
	.seh_stackalloc	88
	vmovaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	vmovaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	vmovaps	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	.seh_endprologue
	vmovsd	.LC1(%rip), %xmm7
	vmovsd	.LC2(%rip), %xmm6
	vxorps	%xmm8, %xmm8, %xmm8
	movq	$0x000000000, sineTable_2q(%rip)
	movl	$1, %ebx
	leaq	sineTable_2q(%rip), %rsi
	.p2align 4
	.p2align 3
.L4:
	vcvtsi2sdl	%ebx, %xmm8, %xmm0
	vmulsd	%xmm7, %xmm0, %xmm0
	vmulsd	%xmm6, %xmm0, %xmm0
	call	sin
	vmovsd	%xmm0, (%rsi,%rbx,8)
	incq	%rbx
	cmpq	$2048, %rbx
	jne	.L4
	vmovaps	32(%rsp), %xmm6
	vmovaps	48(%rsp), %xmm7
	vmovaps	64(%rsp), %xmm8
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.seh_endproc
	.p2align 4
	.globl	fastSin
	.def	fastSin;	.scl	2;	.type	32;	.endef
	.seh_proc	fastSin
fastSin:
	.seh_endprologue
	vmulsd	.LC3(%rip), %xmm0, %xmm1
	leaq	sineTable_2q(%rip), %rcx
	vcvttsd2sil	%xmm1, %eax
	leal	1024(%rax), %edx
	movl	%eax, %r9d
	vxorps	%xmm1, %xmm1, %xmm1
	movl	%edx, %r8d
	andl	$2047, %r9d
	andl	$2047, %edx
	vcvtsi2sdl	%eax, %xmm1, %xmm1
	vmovsd	(%rcx,%r9,8), %xmm2
	vfnmadd132sd	.LC4(%rip), %xmm0, %xmm1
	andl	$2048, %r8d
	vmovsd	(%rcx,%rdx,8), %xmm3
	testb	$8, %ah
	je	.L7
	vxorpd	.LC5(%rip), %xmm2, %xmm2
.L7:
	testl	%r8d, %r8d
	je	.L8
	vxorpd	.LC5(%rip), %xmm3, %xmm3
.L8:
	vmulsd	.LC6(%rip), %xmm2, %xmm0
	vfnmadd132sd	%xmm1, %xmm3, %xmm0
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
	.globl	min
	.def	min;	.scl	2;	.type	32;	.endef
	.seh_proc	min
min:
	.seh_endprologue
	cmpl	%ecx, %edx
	movl	%ecx, %eax
	cmovle	%edx, %eax
	ret
	.seh_endproc
	.p2align 4
	.globl	max
	.def	max;	.scl	2;	.type	32;	.endef
	.seh_proc	max
max:
	.seh_endprologue
	cmpl	%ecx, %edx
	movl	%ecx, %eax
	cmovge	%edx, %eax
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
	jle	.L41
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L40
	.p2align 4
	.p2align 3
.L47:
	cmpb	$0, 1(%rdx)
	jne	.L30
	movq	%rcx, 0(%rbp)
.L31:
	incl	%esi
	xorl	%edx, %edx
.L27:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L45
.L40:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L43
	cmpb	$104, 1(%rcx)
	jne	.L43
	cmpb	$0, 2(%rcx)
	je	.L42
	.p2align 4
	.p2align 3
.L43:
	testq	%rdx, %rdx
	je	.L46
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L47
.L30:
	cmpl	$115, %eax
	jne	.L33
	cmpb	$0, 1(%rdx)
	jne	.L33
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L31
	.p2align 4
	.p2align 3
.L46:
	cmpb	$45, (%rcx)
	je	.L48
	cmpl	%ebx, %r12d
	jne	.L49
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L40
	.p2align 4
	.p2align 3
.L45:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L21:
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
.L33:
	cmpl	$101, %eax
	jne	.L35
	cmpb	$0, 1(%rdx)
	jne	.L35
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L31
	.p2align 4
	.p2align 3
.L35:
	cmpl	$100, %eax
	jne	.L37
	cmpb	$0, 1(%rdx)
	jne	.L37
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L31
	.p2align 4
	.p2align 3
.L37:
	cmpl	$72, %eax
	je	.L50
.L39:
	leaq	.LC17(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L21
	.p2align 4
	.p2align 3
.L48:
	leaq	1(%rcx), %rdx
	jmp	.L27
	.p2align 4
	.p2align 3
.L50:
	cmpb	$0, 1(%rdx)
	jne	.L39
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L31
	.p2align 4
	.p2align 3
.L42:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L49:
	leaq	.LC16(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L21
.L41:
	movl	$2, %eax
	jmp	.L21
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
	jne	.L65
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC20(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L66
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC22(%rip), %rdx
	call	strncmp
	testl	%eax, %eax
	jne	.L67
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L68
	cmpw	$1, 20(%r12)
	jne	.L69
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L58
	cmpw	$32, %dx
	jne	.L70
.L58:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L65:
	movq	%r12, %rdx
	leaq	.LC19(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L51:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L68:
	leaq	.LC24(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L66:
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
.L67:
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
.L69:
	leaq	.LC25(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L70:
	leaq	.LC26(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L51
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC28:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC29:
	.ascii "curveDuration > 0.f\0"
.LC30:
	.ascii "Generated %d upsample times.\12\0"
.LC32:
	.ascii "\11Start to mid: %d\0"
.LC33:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC34:
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
	vcomiss	.LC27(%rip), %xmm8
	vdivss	%xmm0, %xmm1, %xmm12
	jbe	.L91
.L72:
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
	jle	.L92
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L81
	.p2align 4
	.p2align 3
.L93:
	vmulss	%xmm0, %xmm9, %xmm0
.L78:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L82
.L81:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L93
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L90
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L81
.L82:
	movl	%r8d, %edx
	leaq	.LC30(%rip), %rcx
	call	printf
	vcomiss	.LC31(%rip), %xmm10
	jb	.L75
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC32(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L75:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L83
	leaq	.LC33(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L83:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC34(%rip), %rcx
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
.L90:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L78
	.p2align 4
	.p2align 3
.L91:
	movl	$154, %r8d
	leaq	.LC28(%rip), %rdx
	leaq	.LC29(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L72
	.p2align 4
	.p2align 3
.L92:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L82
	.seh_endproc
	.section .rdata,"dr"
.LC36:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC37:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC38:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC39:
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
	movl	360(%rsp), %edi
	movl	352(%rsp), %ebp
	movq	%rdx, %r14
	movl	%edi, %edx
	movl	%ecx, %r13d
	movl	%r8d, %ebx
	shrl	$31, %edx
	movq	%r9, %rsi
	leal	(%rdi,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L95
	movl	$210, %r8d
	leaq	.LC28(%rip), %rdx
	leaq	.LC36(%rip), %rcx
	call	*__imp__assert(%rip)
.L95:
	movslq	%ebp, %r15
	movq	%r15, %rax
	salq	$2, %rax
	je	.L98
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L98
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L97:
	movl	%ebp, %edx
	leaq	.LC37(%rip), %rcx
	movl	%edi, %r8d
	call	printf
	xorl	%ecx, %ecx
	leaq	48(%rsp), %rdx
	call	clock_gettime
	testl	%ebp, %ebp
	jle	.L107
	vmovsd	.LC1(%rip), %xmm15
	vmovss	.LC7(%rip), %xmm5
	movl	%edi, %ebp
	vxorps	%xmm3, %xmm3, %xmm3
	vmovsd	.LC8(%rip), %xmm14
	vmovss	.LC9(%rip), %xmm13
	shrl	$31, %ebp
	vcvtsi2ssl	%r13d, %xmm3, %xmm0
	vmovss	.LC10(%rip), %xmm12
	addl	%edi, %ebp
	vmovss	%xmm0, 44(%rsp)
	xorl	%r13d, %r13d
	sarl	%ebp
	negl	%ebp
	.p2align 4
	.p2align 3
.L106:
	vmovss	44(%rsp), %xmm6
	xorl	%r8d, %r8d
	vmulss	(%rsi,%r13,4), %xmm6, %xmm8
	vcvttss2sil	%xmm8, %eax
	leal	0(%rbp,%rax), %r10d
	movl	%eax, %ecx
	testl	%r10d, %r10d
	cmovns	%r10d, %r8d
	subl	%ebp, %ecx
	movl	%r8d, %edx
	incl	%ecx
	subl	%ebp, %edx
	subl	%eax, %edx
	cmpl	%ebx, %ecx
	cmovg	%ebx, %ecx
	movl	%ecx, %r9d
	subl	%ebp, %r9d
	subl	%eax, %r9d
	cmpl	%ecx, %r8d
	jge	.L108
	vmovss	.LC11(%rip), %xmm11
	vmovss	.LC15(%rip), %xmm6
	cltq
	movslq	%ebp, %rcx
	addq	%rcx, %rax
	movslq	%edx, %rdx
	vxorpd	%xmm4, %xmm4, %xmm4
	leaq	(%r14,%rax,4), %r11
	vxorps	%xmm7, %xmm7, %xmm7
	.p2align 4
	.p2align 3
.L105:
	leal	(%r10,%rdx), %eax
	vcvtsi2ssl	%eax, %xmm3, %xmm0
	vsubss	%xmm0, %xmm8, %xmm0
	vucomiss	%xmm7, %xmm0
	jp	.L110
	vmovsd	.LC35(%rip), %xmm1
	je	.L101
.L110:
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm15, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm2
	vdivss	%xmm5, %xmm2, %xmm1
	vcvttss2sil	%xmm1, %ecx
	movl	%ecx, %eax
	movl	%ecx, %r8d
	vcvtss2sd	%xmm2, %xmm2, %xmm2
	shrl	$31, %eax
	andl	$1, %r8d
	addl	%ecx, %eax
	sarl	%eax
	leal	(%rax,%r8), %edi
	subl	%r8d, %eax
	testl	%ecx, %ecx
	cmovg	%edi, %eax
	negl	%eax
	vcvtsi2sdl	%eax, %xmm3, %xmm1
	vfmadd132sd	%xmm14, %xmm2, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm2
	vaddss	%xmm5, %xmm1, %xmm10
	vmovaps	%xmm2, %xmm9
	vsubss	%xmm6, %xmm10, %xmm10
	vfmadd132ss	%xmm13, %xmm12, %xmm9
	vfmadd132ss	%xmm2, %xmm11, %xmm9
	vfmadd213ss	.LC12(%rip), %xmm2, %xmm9
	vfmadd213ss	.LC13(%rip), %xmm2, %xmm9
	vfmadd213ss	.LC14(%rip), %xmm2, %xmm9
	vsubss	%xmm5, %xmm1, %xmm2
	vaddss	%xmm6, %xmm2, %xmm2
	vmulss	%xmm10, %xmm2, %xmm2
	vmulss	%xmm9, %xmm2, %xmm2
	vmulss	%xmm1, %xmm2, %xmm1
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	vdivsd	%xmm0, %xmm1, %xmm1
.L101:
	vcvtsi2sdl	(%r11,%rdx,4), %xmm3, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	incq	%rdx
	vaddsd	%xmm0, %xmm4, %xmm4
	cmpl	%edx, %r9d
	jg	.L105
	vcvttsd2sil	%xmm4, %eax
.L100:
	movl	%eax, (%r12,%r13,4)
	incq	%r13
	cmpq	%r13, %r15
	jne	.L106
.L107:
	leaq	64(%rsp), %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	movl	72(%rsp), %eax
	leaq	.LC38(%rip), %rcx
	subl	56(%rsp), %eax
	movq	64(%rsp), %rdx
	subq	48(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC39(%rip), %rcx
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
.L108:
	xorl	%eax, %eax
	jmp	.L100
.L98:
	xorl	%r12d, %r12d
	jmp	.L97
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
.LC41:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC42:
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
	je	.L153
	cmpw	$24, %r8w
	jne	.L127
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L130
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L130
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L129:
	cmpl	$7, %edi
	jle	.L135
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L132
	.p2align 4
	.p2align 3
.L152:
	vzeroupper
.L132:
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
	vpshufb	.LC40(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L152
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L131:
	testl	%ebx, %ebx
	jg	.L154
.L133:
	movl	%r12d, %edx
	leaq	.LC41(%rip), %rcx
	call	printf
.L121:
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
.L127:
	movzwl	%r8w, %edx
	leaq	.LC42(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L121
	.p2align 4
	.p2align 3
.L153:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L125
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L125
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L124:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L121
	.p2align 4
	.p2align 3
.L125:
	xorl	%r13d, %r13d
	jmp	.L124
	.p2align 4
	.p2align 3
.L154:
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
	je	.L144
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
	jle	.L144
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
	jle	.L144
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
	jle	.L144
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
	jle	.L144
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
	jle	.L144
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
	jle	.L144
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
	jle	.L144
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
	jle	.L144
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L133
	.p2align 4
	.p2align 3
.L130:
	xorl	%r13d, %r13d
	jmp	.L129
	.p2align 4
	.p2align 3
.L144:
	movl	%edx, %r12d
	jmp	.L133
	.p2align 4
	.p2align 3
.L135:
	xorl	%r12d, %r12d
	jmp	.L131
	.seh_endproc
	.section .rdata,"dr"
.LC43:
	.ascii "rb\0"
	.align 8
.LC44:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC45:
	.ascii "Aborting.\12\0"
	.align 8
.LC46:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC47:
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
	leaq	.LC43(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L156
	movq	%r12, %rdx
	leaq	.LC44(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC46(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L160
	.p2align 4
	.p2align 3
.L178:
	cmpb	$78, %al
	je	.L177
	movq	%rdi, %rcx
	call	printf
.L160:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L178
.L156:
	movq	%r12, %rcx
	leaq	.LC47(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L179
	cmpw	$24, %ax
	je	.L180
.L162:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L155:
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
.L177:
	leaq	.LC45(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L155
	.p2align 4
	.p2align 3
.L180:
	cmpl	$7, %ebp
	jle	.L168
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
.L164:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC48(%rip), %ymm1, %ymm0
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
	jne	.L164
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L163:
	testl	%ebp, %ebp
	jle	.L162
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L166:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L166
	jmp	.L162
	.p2align 4
	.p2align 3
.L179:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L162
.L168:
	xorl	%eax, %eax
	jmp	.L163
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC49:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC50:
	.ascii "Some param parse error occured\12\0"
.LC51:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC52:
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
	je	.L193
	cmpl	$2, %eax
	je	.L194
	movq	96(%rsp), %r13
	leaq	.LC43(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L195
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L186
.L187:
	movl	$1, %eax
.L181:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L186:
	leaq	.LC52(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L187
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
	je	.L181
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L181
.L194:
	leaq	.LC50(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L181
.L195:
	movq	%r13, %rdx
	leaq	.LC51(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L181
.L193:
	leaq	.LC49(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L181
	.seh_endproc
	.globl	sineTable_2q
	.bss
	.align 32
sineTable_2q:
	.space 16384
	.set	.LC0,.LC5+8
	.section .rdata,"dr"
	.align 8
.LC1:
	.long	1413754136
	.long	1074340347
	.align 8
.LC2:
	.long	0
	.long	1061158912
	.align 8
.LC3:
	.long	1841940611
	.long	1082416944
	.align 8
.LC4:
	.long	1413754136
	.long	1062806011
	.align 16
.LC5:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC6:
	.long	0
	.long	1071644672
	.align 4
.LC7:
	.long	1078530011
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
	.set	.LC27,.LC5
	.align 4
.LC31:
	.long	1065353216
	.align 8
.LC35:
	.long	0
	.long	1072693248
	.align 32
.LC40:
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
.LC48:
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
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
