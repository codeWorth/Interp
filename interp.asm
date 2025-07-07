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
	.globl	chebSin
	.def	chebSin;	.scl	2;	.type	32;	.endef
	.seh_proc	chebSin
chebSin:
	.seh_endprologue
	vmovss	.LC10(%rip), %xmm3
	vmovss	.LC12(%rip), %xmm2
	vmovss	.LC18(%rip), %xmm4
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
	vfmadd132sd	.LC11(%rip), %xmm0, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm0
	vfmadd213ss	.LC13(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC14(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC15(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC16(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC17(%rip), %xmm0, %xmm2
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
.LC19:
	.ascii "Out file should be last param!\0"
.LC20:
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
	jle	.L34
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L33
	.p2align 4
	.p2align 3
.L40:
	cmpb	$0, 1(%rdx)
	jne	.L23
	movq	%rcx, 0(%rbp)
.L24:
	incl	%esi
	xorl	%edx, %edx
.L20:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L38
.L33:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L36
	cmpb	$104, 1(%rcx)
	jne	.L36
	cmpb	$0, 2(%rcx)
	je	.L35
	.p2align 4
	.p2align 3
.L36:
	testq	%rdx, %rdx
	je	.L39
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L40
.L23:
	cmpl	$115, %eax
	jne	.L26
	cmpb	$0, 1(%rdx)
	jne	.L26
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L24
	.p2align 4
	.p2align 3
.L39:
	cmpb	$45, (%rcx)
	je	.L41
	cmpl	%ebx, %r12d
	jne	.L42
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L33
	.p2align 4
	.p2align 3
.L38:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L14:
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
.L26:
	cmpl	$101, %eax
	jne	.L28
	cmpb	$0, 1(%rdx)
	jne	.L28
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L24
	.p2align 4
	.p2align 3
.L28:
	cmpl	$100, %eax
	jne	.L30
	cmpb	$0, 1(%rdx)
	jne	.L30
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L24
	.p2align 4
	.p2align 3
.L30:
	cmpl	$72, %eax
	je	.L43
.L32:
	leaq	.LC20(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L14
	.p2align 4
	.p2align 3
.L41:
	leaq	1(%rcx), %rdx
	jmp	.L20
	.p2align 4
	.p2align 3
.L43:
	cmpb	$0, 1(%rdx)
	jne	.L32
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L24
	.p2align 4
	.p2align 3
.L35:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L42:
	leaq	.LC19(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L14
.L34:
	movl	$2, %eax
	jmp	.L14
	.seh_endproc
	.section .rdata,"dr"
.LC21:
	.ascii "RIFF\0"
	.align 8
.LC22:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC23:
	.ascii "WAVE\0"
	.align 8
.LC24:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC25:
	.ascii "fmt \0"
	.align 8
.LC26:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC27:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC28:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC29:
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
	leaq	.LC21(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L58
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC23(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L59
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC25(%rip), %rdx
	call	strncmp
	testl	%eax, %eax
	jne	.L60
	movl	16(%r12), %edx
	cmpl	$16, %edx
	jne	.L61
	cmpw	$1, 20(%r12)
	jne	.L62
	movzwl	34(%r12), %edx
	movl	%edx, %eax
	andl	$-9, %eax
	cmpw	$16, %ax
	je	.L51
	cmpw	$32, %dx
	jne	.L63
.L51:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L58:
	movq	%r12, %rdx
	leaq	.LC22(%rip), %rcx
	call	printf
	xorl	%eax, %eax
.L44:
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L61:
	leaq	.LC27(%rip), %rcx
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
	leaq	.LC24(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L60:
	movq	%r13, %rdx
	leaq	.LC26(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L62:
	leaq	.LC28(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L63:
	leaq	.LC29(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L44
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC30:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC31:
	.ascii "curveDuration > 0.f\0"
.LC32:
	.ascii "Generated %d upsample times.\12\0"
.LC34:
	.ascii "\11Start to mid: %d\0"
.LC35:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC36:
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
	jbe	.L84
.L65:
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
	jle	.L85
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L74
	.p2align 4
	.p2align 3
.L86:
	vmulss	%xmm0, %xmm9, %xmm0
.L71:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L75
.L74:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L86
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L83
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L74
.L75:
	movl	%r8d, %edx
	leaq	.LC32(%rip), %rcx
	call	printf
	vcomiss	.LC33(%rip), %xmm10
	jb	.L68
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC34(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L68:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L76
	leaq	.LC35(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L76:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC36(%rip), %rcx
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
.L83:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L71
	.p2align 4
	.p2align 3
.L84:
	movl	$154, %r8d
	leaq	.LC30(%rip), %rdx
	leaq	.LC31(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L65
	.p2align 4
	.p2align 3
.L85:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L75
	.seh_endproc
	.section .rdata,"dr"
.LC37:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC38:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC39:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC40:
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
	subq	$184, %rsp
	.seh_stackalloc	184
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
	.seh_endprologue
	movl	296(%rsp), %r13d
	movl	288(%rsp), %r15d
	movq	%rdx, %rdi
	movl	%r13d, %edx
	movl	%ecx, %r14d
	movl	%r8d, %ebx
	shrl	$31, %edx
	movq	%r9, %rsi
	leal	0(%r13,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L88
	movl	$210, %r8d
	leaq	.LC30(%rip), %rdx
	leaq	.LC37(%rip), %rcx
	call	*__imp__assert(%rip)
.L88:
	movslq	%r15d, %rbp
	movq	%rbp, %rax
	salq	$2, %rax
	je	.L91
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L91
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L90:
	movl	%r15d, %edx
	leaq	.LC38(%rip), %rcx
	movl	%r13d, %r8d
	call	printf
	xorl	%ecx, %ecx
	leaq	32(%rsp), %rdx
	call	clock_gettime
	testl	%r15d, %r15d
	jle	.L100
	vmovsd	.LC2(%rip), %xmm9
	vmovsd	.LC4(%rip), %xmm8
	movl	%r13d, %r10d
	vxorps	%xmm2, %xmm2, %xmm2
	vmovsd	.LC5(%rip), %xmm7
	vmovsd	.LC6(%rip), %xmm6
	shrl	$31, %r10d
	xorl	%r11d, %r11d
	addl	%r13d, %r10d
	leaq	sineTable_4q(%rip), %r9
	vcvtsi2ssl	%r14d, %xmm2, %xmm10
	sarl	%r10d
	negl	%r10d
	.p2align 4
	.p2align 3
.L99:
	vmulss	(%rsi,%r11,4), %xmm10, %xmm4
	xorl	%r14d, %r14d
	vcvttss2sil	%xmm4, %r8d
	leal	(%r10,%r8), %ecx
	movl	%r8d, %r13d
	testl	%ecx, %ecx
	cmovns	%ecx, %r14d
	subl	%r10d, %r13d
	movl	%r14d, %eax
	incl	%r13d
	subl	%r10d, %eax
	subl	%r8d, %eax
	cmpl	%ebx, %r13d
	cmovg	%ebx, %r13d
	movl	%r13d, %edx
	subl	%r10d, %edx
	subl	%r8d, %edx
	cmpl	%r13d, %r14d
	jge	.L101
	movslq	%r8d, %r8
	movslq	%r10d, %r13
	cltq
	vxorpd	%xmm3, %xmm3, %xmm3
	addq	%r13, %r8
	vxorps	%xmm5, %xmm5, %xmm5
	leaq	(%rdi,%r8,4), %r8
	.p2align 4
	.p2align 3
.L98:
	leal	(%rcx,%rax), %r13d
	vcvtsi2ssl	%r13d, %xmm2, %xmm0
	vsubss	%xmm0, %xmm4, %xmm0
	vucomiss	%xmm5, %xmm0
	jp	.L102
	je	.L94
.L102:
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm9, %xmm0, %xmm0
	vmulsd	%xmm8, %xmm0, %xmm1
	vcvttsd2sil	%xmm1, %r13d
	leal	128(%r13), %r14d
	vcvtsi2sdl	%r13d, %xmm2, %xmm1
	andl	$511, %r13d
	vmovsd	(%r9,%r13,8), %xmm12
	andl	$511, %r14d
	vfnmadd132sd	%xmm7, %xmm0, %xmm1
	vmulsd	%xmm6, %xmm12, %xmm11
	vfnmadd213sd	(%r9,%r14,8), %xmm1, %xmm11
	vfmadd132sd	%xmm11, %xmm12, %xmm1
	vdivsd	%xmm0, %xmm1, %xmm1
	vcvtsi2sdl	(%r8,%rax,4), %xmm2, %xmm0
	incq	%rax
	vfmadd231sd	%xmm0, %xmm1, %xmm3
	cmpl	%eax, %edx
	jg	.L98
.L97:
	vcvttsd2sil	%xmm3, %eax
.L93:
	movl	%eax, (%r12,%r11,4)
	incq	%r11
	cmpq	%r11, %rbp
	jne	.L99
.L100:
	leaq	48(%rsp), %rdx
	xorl	%ecx, %ecx
	call	clock_gettime
	movl	56(%rsp), %eax
	leaq	.LC39(%rip), %rcx
	subl	40(%rsp), %eax
	movq	48(%rsp), %rdx
	subq	32(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC40(%rip), %rcx
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
	addq	$184, %rsp
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
.L94:
	vcvtsi2sdl	(%r8,%rax,4), %xmm2, %xmm0
	incq	%rax
	vaddsd	%xmm0, %xmm3, %xmm3
	cmpl	%eax, %edx
	jg	.L98
	jmp	.L97
	.p2align 4
	.p2align 3
.L101:
	xorl	%eax, %eax
	jmp	.L93
.L91:
	xorl	%r12d, %r12d
	jmp	.L90
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
.LC42:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC43:
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
	je	.L144
	cmpw	$24, %r8w
	jne	.L118
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L121
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L121
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L120:
	cmpl	$7, %edi
	jle	.L126
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L123
	.p2align 4
	.p2align 3
.L143:
	vzeroupper
.L123:
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
	vpshufb	.LC41(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L143
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L122:
	testl	%ebx, %ebx
	jg	.L145
.L124:
	movl	%r12d, %edx
	leaq	.LC42(%rip), %rcx
	call	printf
.L112:
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
.L118:
	movzwl	%r8w, %edx
	leaq	.LC43(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L112
	.p2align 4
	.p2align 3
.L144:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L116
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L116
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L115:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L112
	.p2align 4
	.p2align 3
.L116:
	xorl	%r13d, %r13d
	jmp	.L115
	.p2align 4
	.p2align 3
.L145:
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
	je	.L135
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
	jle	.L135
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
	jle	.L135
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
	jle	.L135
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
	jle	.L135
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
	jle	.L135
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
	jle	.L135
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
	jle	.L135
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
	jle	.L135
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L124
	.p2align 4
	.p2align 3
.L121:
	xorl	%r13d, %r13d
	jmp	.L120
	.p2align 4
	.p2align 3
.L135:
	movl	%edx, %r12d
	jmp	.L124
	.p2align 4
	.p2align 3
.L126:
	xorl	%r12d, %r12d
	jmp	.L122
	.seh_endproc
	.section .rdata,"dr"
.LC44:
	.ascii "rb\0"
	.align 8
.LC45:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC46:
	.ascii "Aborting.\12\0"
	.align 8
.LC47:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC48:
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
	leaq	.LC44(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L147
	movq	%r12, %rdx
	leaq	.LC45(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC47(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L151
	.p2align 4
	.p2align 3
.L169:
	cmpb	$78, %al
	je	.L168
	movq	%rdi, %rcx
	call	printf
.L151:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L169
.L147:
	movq	%r12, %rcx
	leaq	.LC48(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L170
	cmpw	$24, %ax
	je	.L171
.L153:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L146:
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
.L168:
	leaq	.LC46(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L146
	.p2align 4
	.p2align 3
.L171:
	cmpl	$7, %ebp
	jle	.L159
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
.L155:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC49(%rip), %ymm1, %ymm0
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
	jne	.L155
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L154:
	testl	%ebp, %ebp
	jle	.L153
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L157:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L157
	jmp	.L153
	.p2align 4
	.p2align 3
.L170:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L153
.L159:
	xorl	%eax, %eax
	jmp	.L154
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC50:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC51:
	.ascii "Some param parse error occured\12\0"
.LC52:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC53:
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
	je	.L184
	cmpl	$2, %eax
	je	.L185
	movq	96(%rsp), %r13
	leaq	.LC44(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L186
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L177
.L178:
	movl	$1, %eax
.L172:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L177:
	leaq	.LC53(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L178
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
	je	.L172
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L172
.L185:
	leaq	.LC51(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L172
.L186:
	movq	%r13, %rdx
	leaq	.LC52(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L172
.L184:
	leaq	.LC50(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L172
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
	.align 4
.LC7:
	.long	1117976963
	.align 4
.LC8:
	.long	1011421147
	.align 4
.LC9:
	.long	1056964608
	.align 4
.LC10:
	.long	1078530011
	.align 8
.LC11:
	.long	1413754136
	.long	1075388923
	.align 4
.LC12:
	.long	789717965
	.align 4
.LC13:
	.long	-1295496101
	.align 4
.LC14:
	.long	908674213
	.align 4
.LC15:
	.long	-1187647768
	.align 4
.LC16:
	.long	1004073975
	.align 4
.LC17:
	.long	-1110474373
	.align 4
.LC18:
	.long	867941678
	.align 4
.LC33:
	.long	1065353216
	.align 32
.LC41:
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
.LC49:
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
