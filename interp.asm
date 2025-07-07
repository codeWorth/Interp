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
.LC7:
	.ascii "Out file should be last param!\0"
.LC8:
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
	jle	.L38
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L37
	.p2align 4
	.p2align 3
.L44:
	cmpb	$0, 1(%rdx)
	jne	.L27
	movq	%rcx, 0(%rbp)
.L28:
	incl	%esi
	xorl	%edx, %edx
.L24:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L42
.L37:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L40
	cmpb	$104, 1(%rcx)
	jne	.L40
	cmpb	$0, 2(%rcx)
	je	.L39
	.p2align 4
	.p2align 3
.L40:
	testq	%rdx, %rdx
	je	.L43
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L44
.L27:
	cmpl	$115, %eax
	jne	.L30
	cmpb	$0, 1(%rdx)
	jne	.L30
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L28
	.p2align 4
	.p2align 3
.L43:
	cmpb	$45, (%rcx)
	je	.L45
	cmpl	%ebx, %r12d
	jne	.L46
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L37
	.p2align 4
	.p2align 3
.L42:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L18:
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
.L30:
	cmpl	$101, %eax
	jne	.L32
	cmpb	$0, 1(%rdx)
	jne	.L32
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L28
	.p2align 4
	.p2align 3
.L32:
	cmpl	$100, %eax
	jne	.L34
	cmpb	$0, 1(%rdx)
	jne	.L34
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L28
	.p2align 4
	.p2align 3
.L34:
	cmpl	$72, %eax
	je	.L47
.L36:
	leaq	.LC8(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L18
	.p2align 4
	.p2align 3
.L45:
	leaq	1(%rcx), %rdx
	jmp	.L24
	.p2align 4
	.p2align 3
.L47:
	cmpb	$0, 1(%rdx)
	jne	.L36
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L28
	.p2align 4
	.p2align 3
.L39:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L46:
	leaq	.LC7(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L18
.L38:
	movl	$2, %eax
	jmp	.L18
	.seh_endproc
	.section .rdata,"dr"
.LC9:
	.ascii "RIFF\0"
	.align 8
.LC10:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC11:
	.ascii "WAVE\0"
	.align 8
.LC12:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC13:
	.ascii "fmt \0"
	.align 8
.LC14:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC15:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC16:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC17:
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
	leaq	.LC9(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L62
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC11(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L63
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC13(%rip), %rdx
	call	strncmp
	testl	%eax, %eax
	jne	.L64
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L65
	cmpw	$1, 20(%r12)
	jne	.L66
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L55
	cmpw	$32, %dx
	jne	.L67
.L55:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L62:
	movq	%r12, %rdx
	leaq	.LC10(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L48:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L65:
	leaq	.LC15(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L63:
	movq	%r13, %rdx
	leaq	.LC12(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L64:
	movq	%r13, %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L66:
	leaq	.LC16(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L67:
	leaq	.LC17(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L48
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC19:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC20:
	.ascii "curveDuration > 0.f\0"
.LC21:
	.ascii "Generated %d upsample times.\12\0"
.LC23:
	.ascii "\11Start to mid: %d\0"
.LC24:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC25:
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
	vcomiss	.LC18(%rip), %xmm8
	vdivss	%xmm0, %xmm1, %xmm12
	jbe	.L88
.L69:
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
	jle	.L89
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L78
	.p2align 4
	.p2align 3
.L90:
	vmulss	%xmm0, %xmm9, %xmm0
.L75:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L79
.L78:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L90
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L87
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L78
.L79:
	movl	%r8d, %edx
	leaq	.LC21(%rip), %rcx
	call	printf
	vcomiss	.LC22(%rip), %xmm10
	jb	.L72
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC23(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L72:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L80
	leaq	.LC24(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L80:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC25(%rip), %rcx
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
.L87:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L75
	.p2align 4
	.p2align 3
.L88:
	movl	$154, %r8d
	leaq	.LC19(%rip), %rdx
	leaq	.LC20(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L69
	.p2align 4
	.p2align 3
.L89:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L79
	.seh_endproc
	.section .rdata,"dr"
.LC27:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC28:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC29:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC30:
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
	movl	360(%rsp), %ebp
	movl	352(%rsp), %r14d
	movq	%rdx, 328(%rsp)
	movl	%ebp, %edx
	movl	%ecx, %r13d
	movl	%r8d, %ebx
	shrl	$31, %edx
	movq	%r9, %rsi
	leal	0(%rbp,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L92
	movl	$210, %r8d
	leaq	.LC19(%rip), %rdx
	leaq	.LC27(%rip), %rcx
	call	*__imp__assert(%rip)
.L92:
	movslq	%r14d, %rdi
	movq	%rdi, %rax
	salq	$2, %rax
	je	.L95
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L95
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L94:
	movl	%r14d, %edx
	leaq	.LC28(%rip), %rcx
	movl	%ebp, %r8d
	call	printf
	xorl	%ecx, %ecx
	leaq	48(%rsp), %rdx
	call	clock_gettime
	testl	%r14d, %r14d
	jle	.L104
	vmovq	.LC5(%rip), %xmm10
	vmovsd	.LC1(%rip), %xmm9
	movl	%ebp, %r14d
	vxorps	%xmm1, %xmm1, %xmm1
	vmovsd	.LC3(%rip), %xmm8
	vmovsd	.LC4(%rip), %xmm7
	shrl	$31, %r14d
	vcvtsi2ssl	%r13d, %xmm1, %xmm12
	addl	%ebp, %r14d
	vmovss	%xmm12, 44(%rsp)
	xorl	%r15d, %r15d
	sarl	%r14d
	negl	%r14d
	vmovapd	%xmm10, %xmm11
	.p2align 4
	.p2align 3
.L103:
	vmovss	44(%rsp), %xmm6
	xorl	%r10d, %r10d
	vmulss	(%rsi,%r15,4), %xmm6, %xmm3
	vcvttss2sil	%xmm3, %edx
	leal	(%r14,%rdx), %r9d
	movl	%edx, %ecx
	testl	%r9d, %r9d
	cmovns	%r9d, %r10d
	subl	%r14d, %ecx
	movl	%r10d, %eax
	incl	%ecx
	subl	%r14d, %eax
	subl	%edx, %eax
	cmpl	%ebx, %ecx
	cmovg	%ebx, %ecx
	movl	%ecx, %r8d
	subl	%r14d, %r8d
	subl	%edx, %r8d
	cmpl	%ecx, %r10d
	jge	.L105
	vmovsd	.LC6(%rip), %xmm6
	vmovsd	.LC26(%rip), %xmm5
	movslq	%r14d, %rcx
	movslq	%edx, %rdx
	addq	%rcx, %rdx
	movq	328(%rsp), %rcx
	cltq
	vxorpd	%xmm2, %xmm2, %xmm2
	vxorps	%xmm4, %xmm4, %xmm4
	leaq	sineTable_2q(%rip), %r10
	leaq	(%rcx,%rdx,4), %r11
	.p2align 4
	.p2align 3
.L102:
	leal	(%r9,%rax), %edx
	vcvtsi2ssl	%edx, %xmm1, %xmm0
	vsubss	%xmm0, %xmm3, %xmm0
	vucomiss	%xmm4, %xmm0
	jp	.L107
	vmovsd	%xmm5, %xmm5, %xmm13
	je	.L98
.L107:
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm9, %xmm0, %xmm0
	vmulsd	%xmm8, %xmm0, %xmm12
	vcvttsd2sil	%xmm12, %edx
	leal	1024(%rdx), %ecx
	movl	%edx, %r13d
	vcvtsi2sdl	%edx, %xmm1, %xmm13
	movl	%ecx, %ebp
	andl	$2047, %r13d
	andl	$2047, %ecx
	vfnmadd132sd	%xmm7, %xmm0, %xmm13
	andl	$2048, %ebp
	andb	$8, %dh
	vmovsd	(%r10,%r13,8), %xmm14
	vmovsd	(%r10,%rcx,8), %xmm15
	je	.L100
	vxorpd	%xmm11, %xmm14, %xmm14
.L100:
	testl	%ebp, %ebp
	je	.L101
	vxorpd	%xmm10, %xmm15, %xmm15
.L101:
	vmulsd	%xmm6, %xmm14, %xmm12
	vfnmadd132sd	%xmm13, %xmm15, %xmm12
	vfmadd132sd	%xmm12, %xmm14, %xmm13
	vdivsd	%xmm0, %xmm13, %xmm13
.L98:
	vcvtsi2sdl	(%r11,%rax,4), %xmm1, %xmm0
	vmulsd	%xmm13, %xmm0, %xmm0
	incq	%rax
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpl	%eax, %r8d
	jg	.L102
	vcvttsd2sil	%xmm2, %eax
.L97:
	movl	%eax, (%r12,%r15,4)
	incq	%r15
	cmpq	%r15, %rdi
	jne	.L103
.L104:
	leaq	64(%rsp), %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	movl	72(%rsp), %eax
	leaq	.LC29(%rip), %rcx
	subl	56(%rsp), %eax
	movq	64(%rsp), %rdx
	subq	48(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC30(%rip), %rcx
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
.L105:
	xorl	%eax, %eax
	jmp	.L97
.L95:
	xorl	%r12d, %r12d
	jmp	.L94
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
.LC32:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC33:
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
	je	.L156
	cmpw	$24, %r8w
	jne	.L130
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L133
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L133
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L132:
	cmpl	$7, %edi
	jle	.L138
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L135
	.p2align 4
	.p2align 3
.L155:
	vzeroupper
.L135:
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
	vpshufb	.LC31(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L155
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L134:
	testl	%ebx, %ebx
	jg	.L157
.L136:
	movl	%r12d, %edx
	leaq	.LC32(%rip), %rcx
	call	printf
.L124:
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
.L130:
	movzwl	%r8w, %edx
	leaq	.LC33(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L124
	.p2align 4
	.p2align 3
.L156:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L128
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L128
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L127:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L124
	.p2align 4
	.p2align 3
.L128:
	xorl	%r13d, %r13d
	jmp	.L127
	.p2align 4
	.p2align 3
.L157:
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
	je	.L147
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
	jle	.L147
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
	jle	.L147
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
	jle	.L147
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
	jle	.L147
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
	jle	.L147
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
	jle	.L147
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
	jle	.L147
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
	jle	.L147
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L136
	.p2align 4
	.p2align 3
.L133:
	xorl	%r13d, %r13d
	jmp	.L132
	.p2align 4
	.p2align 3
.L147:
	movl	%edx, %r12d
	jmp	.L136
	.p2align 4
	.p2align 3
.L138:
	xorl	%r12d, %r12d
	jmp	.L134
	.seh_endproc
	.section .rdata,"dr"
.LC34:
	.ascii "rb\0"
	.align 8
.LC35:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC36:
	.ascii "Aborting.\12\0"
	.align 8
.LC37:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC38:
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
	leaq	.LC34(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L159
	movq	%r12, %rdx
	leaq	.LC35(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC37(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L163
	.p2align 4
	.p2align 3
.L181:
	cmpb	$78, %al
	je	.L180
	movq	%rdi, %rcx
	call	printf
.L163:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L181
.L159:
	movq	%r12, %rcx
	leaq	.LC38(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L182
	cmpw	$24, %ax
	je	.L183
.L165:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L158:
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
.L180:
	leaq	.LC36(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L158
	.p2align 4
	.p2align 3
.L183:
	cmpl	$7, %ebp
	jle	.L171
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
.L167:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC39(%rip), %ymm1, %ymm0
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
	jne	.L167
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L166:
	testl	%ebp, %ebp
	jle	.L165
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L169:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L169
	jmp	.L165
	.p2align 4
	.p2align 3
.L182:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L165
.L171:
	xorl	%eax, %eax
	jmp	.L166
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC40:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC41:
	.ascii "Some param parse error occured\12\0"
.LC42:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC43:
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
	je	.L196
	cmpl	$2, %eax
	je	.L197
	movq	96(%rsp), %r13
	leaq	.LC34(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L198
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L189
.L190:
	movl	$1, %eax
.L184:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L189:
	leaq	.LC43(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L190
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
	je	.L184
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L184
.L197:
	leaq	.LC41(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L184
.L198:
	movq	%r13, %rdx
	leaq	.LC42(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L184
.L196:
	leaq	.LC40(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L184
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
	.set	.LC18,.LC5
	.align 4
.LC22:
	.long	1065353216
	.align 8
.LC26:
	.long	0
	.long	1072693248
	.align 32
.LC31:
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
.LC39:
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
