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
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "Out file should be last param!\0"
.LC1:
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
	jle	.L23
	movslq	%ecx, %r13
	movl	$1, %ebx
	xorl	%esi, %esi
	xorl	%edx, %edx
	leal	-1(%rcx), %r12d
	jmp	.L22
	.p2align 4
	.p2align 3
.L29:
	cmpb	$0, 1(%rdx)
	jne	.L12
	movq	%rcx, 0(%rbp)
.L13:
	incl	%esi
	xorl	%edx, %edx
.L9:
	incq	%rbx
	cmpq	%rbx, %r13
	je	.L27
.L22:
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L25
	cmpb	$104, 1(%rcx)
	jne	.L25
	cmpb	$0, 2(%rcx)
	je	.L24
	.p2align 4
	.p2align 3
.L25:
	testq	%rdx, %rdx
	je	.L28
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L29
.L12:
	cmpl	$115, %eax
	jne	.L15
	cmpb	$0, 1(%rdx)
	jne	.L15
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 16(%rbp)
	jmp	.L13
	.p2align 4
	.p2align 3
.L28:
	cmpb	$45, (%rcx)
	je	.L30
	cmpl	%ebx, %r12d
	jne	.L31
	incq	%rbx
	movq	%rcx, 8(%rbp)
	incl	%esi
	cmpq	%rbx, %r13
	jne	.L22
	.p2align 4
	.p2align 3
.L27:
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.L3:
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
.L15:
	cmpl	$101, %eax
	jne	.L17
	cmpb	$0, 1(%rdx)
	jne	.L17
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 20(%rbp)
	jmp	.L13
	.p2align 4
	.p2align 3
.L17:
	cmpl	$100, %eax
	jne	.L19
	cmpb	$0, 1(%rdx)
	jne	.L19
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 24(%rbp)
	jmp	.L13
	.p2align 4
	.p2align 3
.L19:
	cmpl	$72, %eax
	je	.L32
.L21:
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L3
	.p2align 4
	.p2align 3
.L30:
	leaq	1(%rcx), %rdx
	jmp	.L9
	.p2align 4
	.p2align 3
.L32:
	cmpb	$0, 1(%rdx)
	jne	.L21
	call	atof
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, 28(%rbp)
	jmp	.L13
	.p2align 4
	.p2align 3
.L24:
	movl	$1, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L31:
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$2, %eax
	jmp	.L3
.L23:
	movl	$2, %eax
	jmp	.L3
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "RIFF\0"
	.align 8
.LC3:
	.ascii "Invalid RIFF header tag %.4s.\12\0"
.LC4:
	.ascii "WAVE\0"
	.align 8
.LC5:
	.ascii "Format %.4s is not .wav, this program only handles wave files currently.\12\0"
.LC6:
	.ascii "fmt \0"
	.align 8
.LC7:
	.ascii "First chunk %.4s should be format chunk instead.\12\0"
	.align 8
.LC8:
	.ascii "Chunk size %d should be 16 for PCM.\12\0"
.LC9:
	.ascii "Audio must be uncompressed.\12\0"
	.align 8
.LC10:
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
	leaq	.LC2(%rip), %rdx
	movq	%rcx, %r12
	call	strncmp
	testl	%eax, %eax
	jne	.L47
	leaq	8(%r12), %r13
	movl	$4, %r8d
	leaq	.LC4(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
	testl	%eax, %eax
	jne	.L48
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC6(%rip), %rdx
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
	leaq	.LC3(%rip), %rcx
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
	leaq	.LC8(%rip), %rcx
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
	leaq	.LC5(%rip), %rcx
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
	leaq	.LC7(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L51:
	leaq	.LC9(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%r12
	popq	%r13
	ret
	.p2align 4
	.p2align 3
.L52:
	leaq	.LC10(%rip), %rcx
	call	printf
	xorl	%eax, %eax
	jmp	.L33
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC11:
	.ascii "Use the following params:\12\11-i\11in file path\12\11-s\11start rate\12\11-e\11end rate\12\11-d\11start delay time\12\11-H\11end hold time\12\11out file path\12\0"
	.align 8
.LC12:
	.ascii "Some param parse error occured\12\0"
.LC13:
	.ascii "rb\0"
.LC14:
	.ascii "Unable to open file at %s\12\0"
	.align 8
.LC15:
	.ascii "Verified file header, continuing...\12\0"
.LC17:
	.ascii "%d\11\0"
.LC18:
	.ascii "\12\0"
.LC19:
	.ascii "Read all %d values...\12\0"
	.align 8
.LC20:
	.ascii "Bit depth %d not yet supported.\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
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
	movl	%ecx, %r12d
	movq	%rdx, %r13
	call	__main
	leaq	32(%rsp), %r8
	movq	%r13, %rdx
	movl	%r12d, %ecx
	call	parseParams
	cmpl	$1, %eax
	je	.L80
	cmpl	$2, %eax
	je	.L81
	movq	32(%rsp), %r13
	leaq	.LC13(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L82
	leaq	96(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
	movq	%r13, %rcx
	movl	$1, %r13d
	call	verifyHeader
	testb	%al, %al
	jne	.L83
.L53:
	movl	%r13d, %eax
	addq	$152, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
.L83:
	leaq	.LC15(%rip), %rcx
	call	printf
	movzwl	130(%rsp), %edx
	movl	136(%rsp), %edi
	cmpw	$24, %dx
	jne	.L58
	movl	$24, %ecx
	xorl	%edx, %edx
	movl	%edi, %eax
	divl	%ecx
	movl	%eax, %ebp
	movq	%rbp, %rcx
	movq	%rbp, %rsi
	salq	$2, %rcx
	je	.L61
	addq	$32, %rcx
	call	malloc
	testq	%rax, %rax
	je	.L61
	leaq	32(%rax), %rbx
	andq	$-32, %rbx
	movq	%rax, -8(%rbx)
.L60:
	cmpl	$215, %edi
	ja	.L84
	testl	%esi, %esi
	jne	.L85
	xorl	%edx, %edx
	leaq	.LC19(%rip), %rcx
	call	printf
	testq	%rbx, %rbx
	jne	.L68
.L67:
	movq	%r12, %rcx
	xorl	%r13d, %r13d
	call	fclose
	jmp	.L53
.L58:
	leaq	.LC20(%rip), %rcx
	call	printf
	jmp	.L53
.L81:
	leaq	.LC12(%rip), %rcx
	movl	$1, %r13d
	call	printf
	jmp	.L53
.L82:
	movq	%r13, %rdx
	leaq	.LC14(%rip), %rcx
	movl	$1, %r13d
	call	printf
	jmp	.L53
.L80:
	leaq	.LC11(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L53
.L85:
	leaq	64(%rsp), %r13
	movq	%rbp, %r8
	movq	%r12, %r9
	movl	$3, %edx
	movq	%r13, %rcx
	leal	(%rsi,%rsi,2), %esi
	call	fread
	movq	%r13, %rcx
	xorl	%r8d, %r8d
.L65:
	movzbl	1(%rcx), %edx
	movzbl	(%rcx), %eax
	addq	$3, %rcx
	movsbl	-1(%rcx), %r9d
	sall	$8, %edx
	orl	%eax, %edx
	sall	$16, %r9d
	orl	%r9d, %edx
	movl	%edx, (%rbx,%r8,4)
	leal	1(%r8), %edx
	incq	%r8
	leal	(%r8,%r8,2), %eax
	cmpl	%eax, %esi
	jg	.L65
	leaq	.LC19(%rip), %rcx
	call	printf
.L68:
	movq	-8(%rbx), %rcx
	call	free
	jmp	.L67
.L61:
	xorl	%ebx, %ebx
	jmp	.L60
.L84:
	leaq	64(%rsp), %rcx
	movq	%r12, %r9
	movl	$4, %r8d
	movl	$3, %edx
	call	fread
	movq	%r12, %r9
	leaq	80(%rsp), %rcx
	movl	$4, %r8d
	movl	$3, %edx
	xorl	%r12d, %r12d
	leaq	.LC17(%rip), %rsi
	call	fread
	vmovdqu	64(%rsp), %ymm1
	vpshufb	.LC16(%rip), %ymm1, %ymm0
	vpsrad	$8, %ymm0, %ymm0
	vmovdqa	%ymm0, (%rbx)
	vzeroupper
.L63:
	movl	(%rbx,%r12,4), %edx
	movq	%rsi, %rcx
	incq	%r12
	call	printf
	cmpq	$8, %r12
	jne	.L63
	leaq	.LC18(%rip), %rcx
	xorl	%r13d, %r13d
	call	printf
	jmp	.L53
	.seh_endproc
	.section .rdata,"dr"
	.align 32
.LC16:
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
	.ident	"GCC: (Rev1, Built by MSYS2 project) 11.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	atof;	.scl	2;	.type	32;	.endef
	.def	strncmp;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
