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
	vmovdqa	.LC9(%rip), %ymm4
	leaq	f_sineTable_4q(%rip), %rax
	vmulps	.LC7(%rip), %ymm1, %ymm0
	vcvtps2dq	%ymm0, %ymm0
	vpand	%ymm4, %ymm0, %ymm5
	vcvtdq2ps	%ymm0, %ymm2
	vpaddd	.LC10(%rip), %ymm0, %ymm0
	vfmadd132ps	.LC8(%rip), %ymm1, %ymm2
	vxorps	%xmm1, %xmm1, %xmm1
	vcmpps	$0, %ymm1, %ymm1, %ymm1
	vmovaps	%ymm1, %ymm6
	vgatherdps	%ymm6, (%rax,%ymm5,4), %ymm3
	vpand	%ymm4, %ymm0, %ymm0
	vgatherdps	%ymm1, (%rax,%ymm0,4), %ymm4
	vmulps	.LC11(%rip), %ymm3, %ymm0
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
	vmovss	.LC12(%rip), %xmm3
	vmovss	.LC14(%rip), %xmm2
	vmovss	.LC20(%rip), %xmm4
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
	vfmadd132sd	.LC13(%rip), %xmm0, %xmm1
	vcvtsd2ss	%xmm1, %xmm1, %xmm1
	vmulss	%xmm1, %xmm1, %xmm0
	vfmadd213ss	.LC15(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC16(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC17(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC18(%rip), %xmm0, %xmm2
	vfmadd213ss	.LC19(%rip), %xmm0, %xmm2
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
.LC21:
	.ascii "Out file should be last param!\0"
.LC22:
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
	leaq	.LC22(%rip), %rcx
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
	leaq	.LC21(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L13
.L33:
	movl	$2, %eax
	jmp	.L13
	.seh_endproc
	.section .rdata,"dr"
.LC23:
	.ascii "RIFF\0"
	.align 8
.LC24:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC25:
	.ascii "WAVE\0"
	.align 8
.LC26:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC27:
	.ascii "fmt \0"
	.align 8
.LC28:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC29:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC30:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC31:
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
	leaq	.LC23(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L57
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC25(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L58
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC27(%rip), %rdx
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
	leaq	.LC24(%rip), %rcx
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
	leaq	.LC26(%rip), %rcx
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
	leaq	.LC28(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L61:
	leaq	.LC30(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L62:
	leaq	.LC31(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L43
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
	je	.L66
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L66
	leaq	32(%rax), %r12
	andq	$-32, %r12
	movq	%rax, -8(%r12)
.L65:
	movslq	%ebx, %r15
	leaq	0(,%rdi,4), %r8
	movq	%r13, %rdx
	leaq	0(,%r15,4), %r14
	leaq	(%r12,%r14), %rcx
	call	memcpy
	testl	%ebx, %ebx
	jle	.L63
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
	je	.L68
	cmpl	$2, %edx
	jbe	.L68
	cmpl	$6, %edx
	jbe	.L78
	shrl	$3, %r8d
	vmovd	%esi, %xmm0
	movq	%r12, %rax
	leaq	-32(%r12,%rcx), %rdx
	salq	$5, %r8
	vpbroadcastd	%xmm0, %ymm0
	addq	%r12, %r8
	.p2align 4
	.p2align 3
.L70:
	vmovdqa	%ymm0, (%rax)
	addq	$32, %rax
	vmovdqu	%ymm0, (%rdx)
	subq	$32, %rdx
	cmpq	%r8, %rax
	jne	.L70
	movl	%ebx, %eax
	andl	$-8, %eax
	movl	%eax, %edx
	cmpl	%eax, %ebx
	je	.L90
	movl	%ebx, %r8d
	subl	%eax, %r8d
	leal	-1(%r8), %r10d
	cmpl	$2, %r10d
	jbe	.L92
	vzeroupper
.L69:
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
	je	.L63
.L74:
	movl	%r9d, %ecx
	movslq	%edx, %rax
	leal	1(%rdx), %r8d
	subl	%edx, %ecx
	salq	$2, %rax
	movslq	%ecx, %rcx
	movl	%esi, (%r12,%rax)
	movl	%esi, (%r12,%rcx,4)
	cmpl	%r8d, %ebx
	jle	.L63
	movl	%r9d, %ecx
	addl	$2, %edx
	movl	%esi, 4(%r12,%rax)
	subl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	%esi, (%r12,%rcx,4)
	cmpl	%edx, %ebx
	jle	.L63
	subl	%edx, %r9d
	movl	%esi, 8(%r12,%rax)
	movslq	%r9d, %r9
	movl	%esi, (%r12,%r9,4)
.L63:
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
.L66:
	xorl	%r12d, %r12d
	jmp	.L65
.L92:
	vzeroupper
	jmp	.L74
	.p2align 4
	.p2align 3
.L68:
	movslq	%r9d, %r9
	movl	%ebx, %ebx
	movq	%r12, %rax
	leaq	(%r12,%r9,4), %rdx
	leaq	(%r12,%rbx,4), %rcx
	.p2align 4
	.p2align 3
.L76:
	movl	%esi, (%rax)
	addq	$4, %rax
	movl	%esi, (%rdx)
	subq	$4, %rdx
	cmpq	%rcx, %rax
	jne	.L76
	jmp	.L63
.L90:
	vzeroupper
	jmp	.L63
.L78:
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L69
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC32:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
.LC33:
	.ascii "curveDuration > 0.f\0"
.LC34:
	.ascii "Generated %d upsample times.\12\0"
.LC36:
	.ascii "\11Start to mid: %d\0"
.LC37:
	.ascii "\11Mid to end: %d\12\0"
	.align 8
.LC38:
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
	jbe	.L113
.L94:
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
	jle	.L114
	vroundss	$10, %xmm10, %xmm10, %xmm1
	movslq	%r8d, %rdx
	xorl	%eax, %eax
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	jmp	.L103
	.p2align 4
	.p2align 3
.L115:
	vmulss	%xmm0, %xmm9, %xmm0
.L100:
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	je	.L104
.L103:
	vcvtsi2sdl	%eax, %xmm6, %xmm4
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vcomisd	%xmm4, %xmm1
	ja	.L115
	vsubss	%xmm10, %xmm0, %xmm0
	vcomisd	%xmm4, %xmm15
	jbe	.L112
	vmulss	%xmm0, %xmm13, %xmm2
	vmulss	%xmm0, %xmm9, %xmm3
	vfmadd132ss	%xmm2, %xmm3, %xmm0
	vaddss	%xmm11, %xmm0, %xmm0
	vmovss	%xmm0, (%r12,%rax,4)
	incq	%rax
	cmpq	%rax, %rdx
	jne	.L103
.L104:
	movl	%r8d, %edx
	leaq	.LC34(%rip), %rcx
	call	printf
	vcomiss	.LC35(%rip), %xmm10
	jb	.L97
	vroundss	$10, %xmm10, %xmm10, %xmm0
	leaq	.LC36(%rip), %rcx
	vcvttss2sil	%xmm0, %edx
	call	printf
.L97:
	vcvtsi2sdl	(%rbx), %xmm6, %xmm6
	vsubsd	%xmm15, %xmm6, %xmm6
	vcomisd	.LC0(%rip), %xmm6
	jbe	.L105
	leaq	.LC37(%rip), %rcx
	vcvttsd2sil	%xmm6, %edx
	call	printf
.L105:
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	leaq	.LC38(%rip), %rcx
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
.L112:
	vsubss	%xmm7, %xmm0, %xmm0
	vfmadd132ss	%xmm12, %xmm11, %xmm0
	vaddss	%xmm8, %xmm0, %xmm0
	jmp	.L100
	.p2align 4
	.p2align 3
.L113:
	movl	$166, %r8d
	leaq	.LC32(%rip), %rdx
	leaq	.LC33(%rip), %rcx
	call	*__imp__assert(%rip)
	jmp	.L94
	.p2align 4
	.p2align 3
.L114:
	vcvtss2sd	%xmm15, %xmm15, %xmm15
	jmp	.L104
	.seh_endproc
	.section .rdata,"dr"
.LC40:
	.ascii "windowSize%2 == 1\0"
	.align 8
.LC43:
	.ascii "Upsampling %d samples w/ window size = %d...\12\0"
	.align 8
.LC44:
	.ascii "Proc took %d seconds and %d milliseconds.\12\0"
	.align 8
.LC45:
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
	movl	408(%rsp), %edi
	movq	%rdx, %r13
	movl	%edi, %edx
	movl	%ecx, 368(%rsp)
	movslq	%r8d, %r12
	shrl	$31, %edx
	movq	%r9, %rsi
	leal	(%rdi,%rdx), %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	je	.L117
	movl	$222, %r8d
	leaq	.LC32(%rip), %rdx
	leaq	.LC40(%rip), %rcx
	call	*__imp__assert(%rip)
.L117:
	vxorps	%xmm6, %xmm6, %xmm6
	vmovsd	.LC39(%rip), %xmm2
	vcvtsi2ssl	%edi, %xmm6, %xmm0
	vmulss	.LC41(%rip), %xmm0, %xmm0
	vroundss	$10, %xmm0, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	vfmadd132sd	.LC42(%rip), %xmm2, %xmm0
	vcvttsd2sil	%xmm0, %r15d
	movl	%r15d, %eax
	shrl	$31, %eax
	addl	%r15d, %eax
	movl	%eax, %ebp
	andl	$-2, %eax
	leal	(%rax,%r12), %ebx
	sarl	%ebp
	movslq	%ebx, %rax
	salq	$2, %rax
	je	.L120
	leaq	32(%rax), %rcx
	call	malloc
	testq	%rax, %rax
	je	.L120
	leaq	32(%rax), %rdx
	andq	$-32, %rdx
	movq	%rdx, %r14
	movq	%rax, -8(%rdx)
.L119:
	movslq	%ebp, %r10
	leaq	0(,%r12,4), %r8
	movq	%r13, %rdx
	leaq	(%r14,%r10,4), %rcx
	movq	%r10, 40(%rsp)
	call	memcpy
	cmpl	$1, %r15d
	movq	40(%rsp), %r10
	jle	.L128
	leaq	(%r12,%r10,2), %rcx
	movl	%ebp, %eax
	decl	%ebx
	salq	$2, %rcx
	salq	$2, %rax
	movq	%rcx, %rdx
	subq	%rax, %rdx
	cmpq	%rax, %rdx
	setge	%al
	testq	%rcx, %rcx
	setle	%dl
	orb	%dl, %al
	je	.L124
	cmpl	$7, %r15d
	jle	.L124
	cmpl	$15, %r15d
	jle	.L160
	movl	%ebp, %r8d
	leaq	-32(%r14,%rcx), %rax
	movq	%r14, %rdx
	vpxor	%xmm0, %xmm0, %xmm0
	shrl	$3, %r8d
	movq	%rax, %r10
	decl	%r8d
	salq	$5, %r8
	subq	%r8, %r10
	leaq	-32(%r10), %r8
.L126:
	vmovdqa	%ymm0, (%rdx)
	subq	$32, %rax
	vmovdqu	%ymm0, 32(%rax)
	addq	$32, %rdx
	cmpq	%rax, %r8
	jne	.L126
	movl	%ebp, %edx
	andl	$-8, %edx
	movl	%edx, %eax
	cmpl	%ebp, %edx
	je	.L200
	vzeroupper
.L125:
	movl	%ebp, %r8d
	subl	%edx, %r8d
	leal	-1(%r8), %r10d
	cmpl	$2, %r10d
	jbe	.L130
	vpxor	%xmm0, %xmm0, %xmm0
	addq	%r14, %rcx
	vmovdqa	%xmm0, (%r14,%rdx,4)
	notq	%rdx
	vmovdqu	%xmm0, -12(%rcx,%rdx,4)
	movl	%r8d, %edx
	andl	$-4, %edx
	addl	%edx, %eax
	cmpl	%r8d, %edx
	je	.L128
.L130:
	movl	%ebx, %ecx
	movslq	%eax, %rdx
	leal	1(%rax), %r8d
	subl	%eax, %ecx
	salq	$2, %rdx
	movslq	%ecx, %rcx
	movl	$0, (%r14,%rdx)
	movl	$0, (%r14,%rcx,4)
	cmpl	%r8d, %ebp
	jle	.L128
	movl	%ebx, %ecx
	addl	$2, %eax
	movl	$0, 4(%r14,%rdx)
	subl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	$0, (%r14,%rcx,4)
	cmpl	%eax, %ebp
	jle	.L128
	subl	%eax, %ebx
	movl	$0, 8(%r14,%rdx)
	movslq	%ebx, %rax
	movl	$0, (%r14,%rax,4)
.L128:
	movslq	400(%rsp), %r11
	movq	%r11, %rcx
	salq	$2, %rcx
	je	.L122
	addq	$32, %rcx
	movq	%r11, 40(%rsp)
	call	malloc
	testq	%rax, %rax
	movq	40(%rsp), %r11
	je	.L122
	leaq	32(%rax), %rdx
	movq	%rdx, %rbx
	andq	$-32, %rbx
	movq	%rax, -8(%rbx)
.L134:
	movl	400(%rsp), %edx
	movl	%edi, %r8d
	leaq	.LC43(%rip), %rcx
	movq	%r11, 40(%rsp)
	call	printf
	xorl	%ecx, %ecx
	leaq	96(%rsp), %rdx
	call	clock_gettime
	movl	400(%rsp), %eax
	movq	40(%rsp), %r11
	testl	%eax, %eax
	jle	.L159
	movl	%edi, %eax
	vcvtsi2ssl	368(%rsp), %xmm6, %xmm0
	xorl	%r13d, %r13d
	vmovss	%xmm0, 92(%rsp)
	shrl	$31, %eax
	leaq	sineTable_4q(%rip), %r12
	addl	%edi, %eax
	sarl	%eax
	movl	%eax, %r10d
	leal	-1(%r15), %eax
	shrl	$3, %eax
	negl	%r10d
	leaq	0(,%rax,8), %r9
	.p2align 4
	.p2align 3
.L158:
	vmovss	92(%rsp), %xmm2
	vmulss	(%rsi,%r13,4), %xmm2, %xmm2
	vcvttss2sil	%xmm2, %edx
	testl	%r15d, %r15d
	jle	.L161
	leal	(%rdx,%r10), %eax
	movslq	%edx, %rdx
	vxorpd	%xmm8, %xmm8, %xmm8
	vcvtsi2ssl	%eax, %xmm6, %xmm15
	vsubss	%xmm15, %xmm2, %xmm15
	leal	1(%rax), %ecx
	vcvtsi2ssl	%ecx, %xmm6, %xmm14
	vsubss	%xmm14, %xmm2, %xmm14
	leal	2(%rax), %ecx
	vcvtsi2ssl	%ecx, %xmm6, %xmm13
	vsubss	%xmm13, %xmm2, %xmm13
	leal	3(%rax), %ecx
	vcvtss2sd	%xmm15, %xmm15, %xmm3
	vcvtsi2ssl	%ecx, %xmm6, %xmm12
	vsubss	%xmm12, %xmm2, %xmm12
	leal	4(%rax), %ecx
	vcvtsi2ssl	%ecx, %xmm6, %xmm11
	vsubss	%xmm11, %xmm2, %xmm11
	leal	5(%rax), %ecx
	vcvtsi2ssl	%ecx, %xmm6, %xmm10
	vsubss	%xmm10, %xmm2, %xmm10
	leal	6(%rax), %ecx
	addl	$7, %eax
	vmovsd	%xmm3, 40(%rsp)
	vcvtss2sd	%xmm14, %xmm14, %xmm3
	vcvtsi2ssl	%ecx, %xmm6, %xmm9
	vsubss	%xmm9, %xmm2, %xmm9
	vcvtsi2ssl	%eax, %xmm6, %xmm0
	vsubss	%xmm0, %xmm2, %xmm2
	leaq	(%r14,%rdx,4), %rax
	addq	%r9, %rdx
	leaq	32(%r14,%rdx,4), %rcx
	vmovsd	%xmm3, 48(%rsp)
	vcvtss2sd	%xmm13, %xmm13, %xmm3
	vmovsd	%xmm3, 56(%rsp)
	vcvtss2sd	%xmm12, %xmm12, %xmm3
	vmovsd	%xmm3, 64(%rsp)
	vcvtss2sd	%xmm11, %xmm11, %xmm3
	vmovsd	%xmm3, 72(%rsp)
	vcvtss2sd	%xmm10, %xmm10, %xmm3
	vmovsd	%xmm3, 80(%rsp)
	vcvtss2sd	%xmm9, %xmm9, %xmm3
	vmovq	%xmm3, %rbp
	vcvtss2sd	%xmm2, %xmm2, %xmm3
	vmovq	%xmm3, %rdi
	vxorps	%xmm3, %xmm3, %xmm3
	.p2align 4
	.p2align 3
.L157:
	vucomiss	%xmm3, %xmm15
	jp	.L169
	movq	.LC39(%rip), %rdx
	vmovq	%rdx, %xmm4
	je	.L139
.L169:
	vmovsd	.LC2(%rip), %xmm5
	vmulsd	40(%rsp), %xmm5, %xmm1
	vmulsd	.LC4(%rip), %xmm1, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	vfnmadd132sd	.LC5(%rip), %xmm1, %xmm0
	vmovsd	(%r12,%rdx,8), %xmm5
	andl	$511, %r8d
	vmulsd	.LC6(%rip), %xmm5, %xmm4
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm4
	vfmadd132sd	%xmm0, %xmm5, %xmm4
	vdivsd	%xmm1, %xmm4, %xmm4
.L139:
	vcvtsi2sdl	(%rax), %xmm6, %xmm1
	vucomiss	%xmm3, %xmm14
	vfmadd132sd	%xmm1, %xmm8, %xmm4
	jp	.L170
	vmovsd	%xmm1, %xmm1, %xmm0
	je	.L141
.L170:
	vmovsd	.LC2(%rip), %xmm5
	vmulsd	48(%rsp), %xmm5, %xmm8
	vmulsd	.LC4(%rip), %xmm8, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm8, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm5
	vmulsd	.LC6(%rip), %xmm5, %xmm5
	vmovq	%rdx, %xmm7
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm5
	vfmadd132sd	%xmm5, %xmm7, %xmm0
	vdivsd	%xmm8, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
.L141:
	vaddsd	%xmm0, %xmm4, %xmm4
	vucomiss	%xmm3, %xmm13
	jp	.L171
	vmovsd	%xmm1, %xmm1, %xmm0
	je	.L143
.L171:
	vmovsd	.LC2(%rip), %xmm7
	vmulsd	56(%rsp), %xmm7, %xmm5
	vmulsd	.LC4(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm5, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm8
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm8
	vfmadd132sd	%xmm8, %xmm7, %xmm0
	vdivsd	%xmm5, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
.L143:
	vaddsd	%xmm0, %xmm4, %xmm4
	vucomiss	%xmm3, %xmm12
	jp	.L172
	vmovsd	%xmm1, %xmm1, %xmm0
	je	.L145
.L172:
	vmovsd	64(%rsp), %xmm7
	vmulsd	.LC2(%rip), %xmm7, %xmm5
	vmulsd	.LC4(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm5, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm8
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm8
	vfmadd132sd	%xmm8, %xmm7, %xmm0
	vdivsd	%xmm5, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
.L145:
	vaddsd	%xmm0, %xmm4, %xmm4
	vucomiss	%xmm3, %xmm11
	jp	.L173
	vmovsd	%xmm1, %xmm1, %xmm0
	je	.L147
.L173:
	vmovsd	72(%rsp), %xmm7
	vmulsd	.LC2(%rip), %xmm7, %xmm5
	vmulsd	.LC4(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm5, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm8
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm8
	vfmadd132sd	%xmm8, %xmm7, %xmm0
	vdivsd	%xmm5, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
.L147:
	vaddsd	%xmm0, %xmm4, %xmm4
	vucomiss	%xmm3, %xmm10
	jp	.L174
	vmovsd	%xmm1, %xmm1, %xmm0
	je	.L149
.L174:
	vmovsd	80(%rsp), %xmm7
	vmulsd	.LC2(%rip), %xmm7, %xmm5
	vmulsd	.LC4(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm5, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm8
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm8
	vfmadd132sd	%xmm8, %xmm7, %xmm0
	vdivsd	%xmm5, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
.L149:
	vaddsd	%xmm0, %xmm4, %xmm4
	vucomiss	%xmm3, %xmm9
	jp	.L175
	vmovsd	%xmm1, %xmm1, %xmm8
	je	.L151
.L175:
	vmovq	%rbp, %xmm7
	vmulsd	.LC2(%rip), %xmm7, %xmm5
	vmulsd	.LC4(%rip), %xmm5, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm5, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm8
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm8
	vfmadd132sd	%xmm0, %xmm7, %xmm8
	vdivsd	%xmm5, %xmm8, %xmm8
	vmulsd	%xmm1, %xmm8, %xmm8
.L151:
	vaddsd	%xmm8, %xmm4, %xmm8
	vucomiss	%xmm3, %xmm2
	jp	.L176
	je	.L153
.L176:
	vmovq	%rdi, %xmm7
	vmulsd	.LC2(%rip), %xmm7, %xmm4
	addq	$32, %rax
	vmulsd	.LC4(%rip), %xmm4, %xmm0
	vcvttsd2sil	%xmm0, %edx
	leal	128(%rdx), %r8d
	vcvtsi2sdl	%edx, %xmm6, %xmm0
	andl	$511, %edx
	movq	(%r12,%rdx,8), %rdx
	vfnmadd132sd	.LC5(%rip), %xmm4, %xmm0
	andl	$511, %r8d
	vmovq	%rdx, %xmm7
	vmulsd	.LC6(%rip), %xmm7, %xmm5
	vfnmadd213sd	(%r12,%r8,8), %xmm0, %xmm5
	vfmadd132sd	%xmm5, %xmm7, %xmm0
	vdivsd	%xmm4, %xmm0, %xmm0
	vfmadd231sd	%xmm0, %xmm1, %xmm8
	cmpq	%rax, %rcx
	jne	.L157
.L156:
	vcvttsd2sil	%xmm8, %eax
.L138:
	movl	%eax, (%rbx,%r13,4)
	incq	%r13
	cmpq	%r13, %r11
	jne	.L158
.L159:
	xorl	%ecx, %ecx
	leaq	112(%rsp), %rdx
	call	clock_gettime
	testq	%r14, %r14
	je	.L137
	movq	-8(%r14), %rcx
	call	free
.L137:
	movl	120(%rsp), %eax
	subl	104(%rsp), %eax
	leaq	.LC44(%rip), %rcx
	movq	112(%rsp), %rdx
	subq	96(%rsp), %rdx
	movslq	%eax, %r8
	sarl	$31, %eax
	imulq	$1125899907, %r8, %r8
	sarq	$50, %r8
	subl	%eax, %r8d
	call	printf
	leaq	.LC45(%rip), %rcx
	call	printf
	nop
	vmovaps	128(%rsp), %xmm6
	movq	%rbx, %rax
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
	popq	%r14
	popq	%r15
	ret
	.p2align 4
	.p2align 3
.L153:
	addq	$32, %rax
	vaddsd	%xmm8, %xmm1, %xmm8
	cmpq	%rax, %rcx
	jne	.L157
	jmp	.L156
.L161:
	xorl	%eax, %eax
	jmp	.L138
.L122:
	xorl	%ebx, %ebx
	jmp	.L134
.L120:
	xorl	%r14d, %r14d
	jmp	.L119
.L124:
	movslq	%ebx, %rbx
	xorl	%eax, %eax
	leaq	(%r14,%rbx,4), %rdx
.L132:
	movl	$0, (%r14,%rax,4)
	incq	%rax
	movl	$0, (%rdx)
	subq	$4, %rdx
	cmpl	%eax, %ebp
	jg	.L132
	jmp	.L128
.L160:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L125
.L200:
	vzeroupper
	jmp	.L128
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
.LC47:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC48:
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
	je	.L234
	cmpw	$24, %r8w
	jne	.L208
	movslq	%edi, %rcx
	salq	$2, %rcx
	je	.L211
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L211
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L210:
	cmpl	$7, %edi
	jle	.L216
	leal	-8(%rdi), %r12d
	movq	%r13, %rbx
	leaq	32(%rsp), %r15
	leaq	48(%rsp), %r14
	shrl	$3, %r12d
	leal	1(%r12), %ebp
	movq	%rbp, %r12
	salq	$5, %rbp
	addq	%r13, %rbp
	jmp	.L213
	.p2align 4
	.p2align 3
.L233:
	vzeroupper
.L213:
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
	vpshufb	.LC46(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, -32(%rbx)
	cmpq	%rbp, %rbx
	jne	.L233
	sall	$3, %r12d
	subl	%r12d, %edi
	movl	%edi, %ebx
	vzeroupper
.L212:
	testl	%ebx, %ebx
	jg	.L235
.L214:
	movl	%r12d, %edx
	leaq	.LC47(%rip), %rcx
	call	printf
.L202:
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
.L208:
	movzwl	%r8w, %edx
	leaq	.LC48(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L202
	.p2align 4
	.p2align 3
.L234:
	movq	%rdi, %rcx
	salq	$2, %rcx
	je	.L206
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L206
	leaq	32(%rax), %r13
	andq	$-32, %r13
	movq	%rax, -8(%r13)
.L205:
	movq	%rsi, %r9
	movq	%rdi, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fread
	jmp	.L202
	.p2align 4
	.p2align 3
.L206:
	xorl	%r13d, %r13d
	jmp	.L205
	.p2align 4
	.p2align 3
.L235:
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
	je	.L225
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
	jle	.L225
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
	jle	.L225
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
	jle	.L225
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
	jle	.L225
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
	jle	.L225
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
	jle	.L225
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
	jle	.L225
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
	jle	.L225
	movzbl	60(%rsp), %edx
	addl	$10, %r12d
	movsbl	61(%rsp), %ecx
	movzbl	59(%rsp), %r8d
	sall	$8, %edx
	sall	$16, %ecx
	orl	%r8d, %edx
	orl	%ecx, %edx
	movl	%edx, 36(%r13,%rax)
	jmp	.L214
	.p2align 4
	.p2align 3
.L211:
	xorl	%r13d, %r13d
	jmp	.L210
	.p2align 4
	.p2align 3
.L225:
	movl	%edx, %r12d
	jmp	.L214
	.p2align 4
	.p2align 3
.L216:
	xorl	%r12d, %r12d
	jmp	.L212
	.seh_endproc
	.section .rdata,"dr"
.LC49:
	.ascii "rb\0"
	.align 8
.LC50:
	.ascii "File %s already exists! Overwrite (Y/N)?\11\0"
.LC51:
	.ascii "Aborting.\12\0"
	.align 8
.LC52:
	.ascii "Unrecognized response. Overwrite (Y/N)?\11\0"
.LC53:
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
	leaq	.LC49(%rip), %rdx
	movq	%r8, 96(%rsp)
	movq	%r8, 48(%rsp)
	movq	%r9, 56(%rsp)
	call	fopen
	testq	%rax, %rax
	je	.L237
	movq	%r12, %rdx
	leaq	.LC50(%rip), %rcx
	leaq	96(%rsp), %rbx
	leaq	.LC52(%rip), %rdi
	call	printf
	movq	__imp___acrt_iob_func(%rip), %rsi
	jmp	.L241
	.p2align 4
	.p2align 3
.L259:
	cmpb	$78, %al
	je	.L258
	movq	%rdi, %rcx
	call	printf
.L241:
	xorl	%ecx, %ecx
	call	*%rsi
	movl	$5, %edx
	movq	%rbx, %rcx
	movq	%rax, %r8
	call	fgets
	movzbl	96(%rsp), %eax
	cmpb	$89, %al
	jne	.L259
.L237:
	movq	%r12, %rcx
	leaq	.LC53(%rip), %rdx
	call	fopen
	leaq	48(%rsp), %rcx
	movl	$1, %r8d
	movl	$44, %edx
	movq	%rax, %r9
	movq	%rax, %r12
	call	fwrite
	movzwl	82(%rsp), %eax
	cmpw	$32, %ax
	je	.L260
	cmpw	$24, %ax
	je	.L261
.L243:
	movq	%r12, %rcx
	call	fclose
	movl	$1, %eax
.L236:
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
.L258:
	leaq	.LC51(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L236
	.p2align 4
	.p2align 3
.L261:
	cmpl	$7, %ebp
	jle	.L249
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
.L245:
	vmovdqa	(%rsi), %ymm1
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	movq	%rbx, %rcx
	vpshufb	.LC54(%rip), %ymm1, %ymm0
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
	jne	.L245
	leal	8(,%r15,8), %eax
	subl	%eax, %ebp
.L244:
	testl	%ebp, %ebp
	jle	.L243
	cltq
	leal	-1(%rbp), %edx
	leaq	44(%rsp), %rsi
	leaq	0(%r13,%rax,4), %rbx
	addq	%rdx, %rax
	leaq	4(%r13,%rax,4), %rdi
	.p2align 4
	.p2align 3
.L247:
	movl	(%rbx), %eax
	movq	%r12, %r9
	movl	$1, %r8d
	movl	$3, %edx
	movq	%rsi, %rcx
	addq	$4, %rbx
	movl	%eax, 44(%rsp)
	call	fwrite
	cmpq	%rbx, %rdi
	jne	.L247
	jmp	.L243
	.p2align 4
	.p2align 3
.L260:
	movq	%r12, %r9
	movq	%r14, %r8
	movl	$4, %edx
	movq	%r13, %rcx
	call	fwrite
	jmp	.L243
.L249:
	xorl	%eax, %eax
	jmp	.L244
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC55:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC56:
	.ascii "Some param parse error occured\12\0"
.LC57:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC58:
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
	je	.L274
	cmpl	$2, %eax
	je	.L275
	movq	96(%rsp), %r13
	leaq	.LC49(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L276
	leaq	128(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	call	verifyHeader
	testb	%al, %al
	jne	.L267
.L268:
	movl	$1, %eax
.L262:
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L267:
	leaq	.LC58(%rip), %rcx
	call	printf
	movq	%r13, %rdx
	movq	%r12, %rcx
	call	readWavfile
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L268
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
	je	.L262
	movq	-8(%r12), %rcx
	movl	%eax, 76(%rsp)
	call	free
	movl	76(%rsp), %eax
	jmp	.L262
.L275:
	leaq	.LC56(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L262
.L276:
	movq	%r13, %rdx
	leaq	.LC57(%rip), %rcx
	call	printf
	movl	$1, %eax
	jmp	.L262
.L274:
	leaq	.LC55(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L262
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
	.align 32
.LC7:
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.long	1117976963
	.align 32
.LC8:
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.long	-1136062501
	.align 32
.LC9:
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.quad	2194728288767
	.align 32
.LC10:
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.align 32
.LC11:
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.long	-1090519040
	.align 4
.LC12:
	.long	1078530011
	.align 8
.LC13:
	.long	1413754136
	.long	1075388923
	.align 4
.LC14:
	.long	789717965
	.align 4
.LC15:
	.long	-1295496101
	.align 4
.LC16:
	.long	908674213
	.align 4
.LC17:
	.long	-1187647768
	.align 4
.LC18:
	.long	1004073975
	.align 4
.LC19:
	.long	-1110474373
	.align 4
.LC20:
	.long	867941678
	.align 4
.LC35:
	.long	1065353216
	.align 8
.LC39:
	.long	0
	.long	1072693248
	.align 4
.LC41:
	.long	1040187392
	.align 8
.LC42:
	.long	0
	.long	1075838976
	.align 32
.LC46:
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
.LC54:
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
