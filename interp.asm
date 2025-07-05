	.file	"interp.c"
	.text
.Ltext0:
	.file 0 "C:/Users/agcum/Documents/Code/Interp" "C:/Users/agcum/Documents/Code/Interp/interp.c"
	.p2align 4
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
.LVL0:
.LFB8:
	.file 1 "C:/msys64/mingw64/x86_64-w64-mingw32/include/stdio.h"
	.loc 1 369 1 view -0
	.loc 1 369 1 is_stmt 0 view .LVU1
	pushq	%r12
	.seh_pushreg	%r12
.LCFI0:
	pushq	%rbx
	.seh_pushreg	%rbx
.LCFI1:
	subq	$56, %rsp
	.seh_stackalloc	56
.LCFI2:
	.seh_endprologue
	.loc 1 370 3 is_stmt 1 view .LVU2
	.loc 1 371 3 view .LVU3
	.loc 1 371 35 view .LVU4
	leaq	88(%rsp), %rbx
	.loc 1 369 1 is_stmt 0 view .LVU5
	movq	%rdx, 88(%rsp)
	movq	%rcx, %r12
	.loc 1 372 14 view .LVU6
	movl	$1, %ecx
.LVL1:
	.loc 1 369 1 view .LVU7
	movq	%r8, 96(%rsp)
	movq	%r9, 104(%rsp)
	.loc 1 371 35 view .LVU8
	movq	%rbx, 40(%rsp)
	.loc 1 372 3 is_stmt 1 view .LVU9
	.loc 1 372 14 is_stmt 0 view .LVU10
	call	*__imp___acrt_iob_func(%rip)
.LVL2:
	movq	%rbx, %r8
	movq	%r12, %rdx
	movq	%rax, %rcx
	call	__mingw_vfprintf
.LVL3:
	.loc 1 373 3 is_stmt 1 view .LVU11
	.loc 1 374 3 view .LVU12
	.loc 1 375 1 is_stmt 0 view .LVU13
	addq	$56, %rsp
.LCFI3:
	popq	%rbx
.LCFI4:
	popq	%r12
.LCFI5:
.LVL4:
	.loc 1 375 1 view .LVU14
	ret
.LFE8:
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
.LVL5:
.LFB50:
	.file 2 "C:/Users/agcum/Documents/Code/Interp/interp.c"
	.loc 2 44 71 is_stmt 1 view -0
	.loc 2 44 71 is_stmt 0 view .LVU16
	pushq	%r13
	.seh_pushreg	%r13
.LCFI6:
	pushq	%r12
	.seh_pushreg	%r12
.LCFI7:
	pushq	%rbp
	.seh_pushreg	%rbp
.LCFI8:
	pushq	%rdi
	.seh_pushreg	%rdi
.LCFI9:
	pushq	%rsi
	.seh_pushreg	%rsi
.LCFI10:
	pushq	%rbx
	.seh_pushreg	%rbx
.LCFI11:
	subq	$40, %rsp
	.seh_stackalloc	40
.LCFI12:
	.seh_endprologue
	.loc 2 45 5 is_stmt 1 view .LVU17
.LVL6:
	.loc 2 46 5 view .LVU18
	.loc 2 48 5 view .LVU19
.LBB2:
	.loc 2 48 10 view .LVU20
	.loc 2 48 23 view .LVU21
.LBE2:
	.loc 2 44 71 is_stmt 0 view .LVU22
	movq	%rdx, %rdi
	movq	%r8, %rbp
.LBB3:
	.loc 2 48 23 view .LVU23
	cmpl	$1, %ecx
	jle	.L23
	movslq	%ecx, %r13
	movl	$1, %ebx
.LBE3:
	.loc 2 46 9 view .LVU24
	xorl	%esi, %esi
	.loc 2 45 17 view .LVU25
	xorl	%edx, %edx
.LVL7:
.LBB4:
	.loc 2 56 33 view .LVU26
	leal	-1(%rcx), %r12d
	jmp	.L22
.LVL8:
	.p2align 4,,10
	.p2align 3
.L29:
	.loc 2 64 16 view .LVU27
	cmpb	$0, 1(%rdx)
	jne	.L12
	.loc 2 65 17 is_stmt 1 view .LVU28
	.loc 2 65 32 is_stmt 0 view .LVU29
	movq	%rcx, 0(%rbp)
.LVL9:
.L13:
	.loc 2 78 13 is_stmt 1 view .LVU30
	.loc 2 78 24 is_stmt 0 view .LVU31
	addl	$1, %esi
.LVL10:
	.loc 2 79 13 is_stmt 1 view .LVU32
	.loc 2 79 19 is_stmt 0 view .LVU33
	xorl	%edx, %edx
.LVL11:
.L9:
	.loc 2 48 32 is_stmt 1 discriminator 2 view .LVU34
	.loc 2 48 23 discriminator 2 view .LVU35
	addq	$1, %rbx
.LVL12:
	.loc 2 48 23 is_stmt 0 discriminator 2 view .LVU36
	cmpq	%rbx, %r13
	je	.L27
.LVL13:
.L22:
	.loc 2 49 9 is_stmt 1 view .LVU37
	.loc 2 49 13 is_stmt 0 view .LVU38
	movq	(%rdi,%rbx,8), %rcx
	cmpb	$45, (%rcx)
	jne	.L25
	cmpb	$104, 1(%rcx)
	jne	.L25
	.loc 2 49 12 view .LVU39
	cmpb	$0, 2(%rcx)
	je	.L24
	.p2align 4,,10
	.p2align 3
.L25:
	.loc 2 53 9 is_stmt 1 view .LVU40
	.loc 2 53 12 is_stmt 0 view .LVU41
	testq	%rdx, %rdx
	je	.L28
	.loc 2 64 13 is_stmt 1 view .LVU42
	.loc 2 64 17 is_stmt 0 view .LVU43
	movzbl	(%rdx), %eax
	cmpl	$105, %eax
	je	.L29
.L12:
	.loc 2 66 20 is_stmt 1 view .LVU44
	.loc 2 66 24 is_stmt 0 view .LVU45
	cmpl	$115, %eax
	jne	.L15
	.loc 2 66 23 view .LVU46
	cmpb	$0, 1(%rdx)
	jne	.L15
	.loc 2 67 17 is_stmt 1 view .LVU47
	.loc 2 67 36 is_stmt 0 view .LVU48
	call	atof
.LVL14:
	.loc 2 67 36 view .LVU49
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, 16(%rbp)
	jmp	.L13
.LVL15:
	.p2align 4,,10
	.p2align 3
.L28:
	.loc 2 54 13 is_stmt 1 view .LVU50
	.loc 2 54 16 is_stmt 0 view .LVU51
	cmpb	$45, (%rcx)
	je	.L30
	.loc 2 56 20 is_stmt 1 view .LVU52
	.loc 2 56 23 is_stmt 0 view .LVU53
	cmpl	%ebx, %r12d
	jne	.L31
	.loc 2 60 17 is_stmt 1 view .LVU54
	.loc 2 48 23 is_stmt 0 view .LVU55
	addq	$1, %rbx
.LVL16:
	.loc 2 60 33 view .LVU56
	movq	%rcx, 8(%rbp)
	.loc 2 61 17 is_stmt 1 view .LVU57
	.loc 2 61 28 is_stmt 0 view .LVU58
	addl	$1, %esi
.LVL17:
	.loc 2 48 32 is_stmt 1 view .LVU59
	.loc 2 48 23 view .LVU60
	cmpq	%rbx, %r13
	jne	.L22
	.p2align 4,,10
	.p2align 3
.L27:
	.loc 2 48 23 is_stmt 0 view .LVU61
.LBE4:
	.loc 2 82 36 view .LVU62
	xorl	%eax, %eax
	cmpl	$6, %esi
	setne	%al
	addl	%eax, %eax
.LVL18:
.L3:
	.loc 2 83 1 view .LVU63
	addq	$40, %rsp
.LCFI13:
	popq	%rbx
.LCFI14:
	popq	%rsi
.LCFI15:
	popq	%rdi
.LCFI16:
.LVL19:
	.loc 2 83 1 view .LVU64
	popq	%rbp
.LCFI17:
.LVL20:
	.loc 2 83 1 view .LVU65
	popq	%r12
.LCFI18:
	popq	%r13
.LCFI19:
	ret
.LVL21:
	.p2align 4,,10
	.p2align 3
.L15:
.LCFI20:
.LBB5:
	.loc 2 68 20 is_stmt 1 view .LVU66
	.loc 2 68 24 is_stmt 0 view .LVU67
	cmpl	$101, %eax
	jne	.L17
	.loc 2 68 23 view .LVU68
	cmpb	$0, 1(%rdx)
	jne	.L17
	.loc 2 69 17 is_stmt 1 view .LVU69
	.loc 2 69 34 is_stmt 0 view .LVU70
	call	atof
.LVL22:
	.loc 2 69 34 view .LVU71
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, 20(%rbp)
	jmp	.L13
.LVL23:
	.p2align 4,,10
	.p2align 3
.L17:
	.loc 2 70 20 is_stmt 1 view .LVU72
	.loc 2 70 24 is_stmt 0 view .LVU73
	cmpl	$100, %eax
	jne	.L19
	.loc 2 70 23 view .LVU74
	cmpb	$0, 1(%rdx)
	jne	.L19
	.loc 2 71 17 is_stmt 1 view .LVU75
	.loc 2 71 37 is_stmt 0 view .LVU76
	call	atof
.LVL24:
	.loc 2 71 37 view .LVU77
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, 24(%rbp)
	jmp	.L13
.LVL25:
	.p2align 4,,10
	.p2align 3
.L19:
	.loc 2 72 20 is_stmt 1 view .LVU78
	.loc 2 72 24 is_stmt 0 view .LVU79
	cmpl	$72, %eax
	je	.L32
.L21:
	.loc 2 75 17 is_stmt 1 view .LVU80
	leaq	.LC1(%rip), %rcx
	call	printf
.LVL26:
	.loc 2 76 17 view .LVU81
	.loc 2 76 24 is_stmt 0 view .LVU82
	movl	$2, %eax
	jmp	.L3
.LVL27:
	.p2align 4,,10
	.p2align 3
.L30:
	.loc 2 55 17 is_stmt 1 view .LVU83
	.loc 2 55 23 is_stmt 0 view .LVU84
	leaq	1(%rcx), %rdx
.LVL28:
	.loc 2 55 23 view .LVU85
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L32:
	.loc 2 72 23 view .LVU86
	cmpb	$0, 1(%rdx)
	jne	.L21
	.loc 2 73 17 is_stmt 1 view .LVU87
	.loc 2 73 36 is_stmt 0 view .LVU88
	call	atof
.LVL29:
	.loc 2 73 36 view .LVU89
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, 28(%rbp)
	jmp	.L13
.LVL30:
	.p2align 4,,10
	.p2align 3
.L24:
	.loc 2 50 20 view .LVU90
	movl	$1, %eax
.LBE5:
	.loc 2 83 1 view .LVU91
	addq	$40, %rsp
.LCFI21:
	popq	%rbx
.LCFI22:
.LVL31:
	.loc 2 83 1 view .LVU92
	popq	%rsi
.LCFI23:
.LVL32:
	.loc 2 83 1 view .LVU93
	popq	%rdi
.LCFI24:
.LVL33:
	.loc 2 83 1 view .LVU94
	popq	%rbp
.LCFI25:
.LVL34:
	.loc 2 83 1 view .LVU95
	popq	%r12
.LCFI26:
	popq	%r13
.LCFI27:
	ret
.LVL35:
.L31:
.LCFI28:
.LBB6:
	.loc 2 57 17 is_stmt 1 view .LVU96
	leaq	.LC0(%rip), %rcx
	call	printf
.LVL36:
	.loc 2 58 17 view .LVU97
	.loc 2 58 24 is_stmt 0 view .LVU98
	movl	$2, %eax
	jmp	.L3
.LVL37:
.L23:
	.loc 2 48 23 view .LVU99
	movl	$2, %eax
.LBE6:
	.loc 2 82 5 is_stmt 1 view .LVU100
	jmp	.L3
.LFE50:
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
.LVL38:
.LFB51:
	.loc 2 85 44 view -0
	.loc 2 85 44 is_stmt 0 view .LVU102
	pushq	%r13
	.seh_pushreg	%r13
.LCFI29:
	pushq	%r12
	.seh_pushreg	%r12
.LCFI30:
	subq	$40, %rsp
	.seh_stackalloc	40
.LCFI31:
	.seh_endprologue
	.loc 2 86 5 is_stmt 1 view .LVU103
	.loc 2 86 9 is_stmt 0 view .LVU104
	movl	$4, %r8d
	leaq	.LC2(%rip), %rdx
	.loc 2 85 44 view .LVU105
	movq	%rcx, %r12
	.loc 2 86 9 view .LVU106
	call	strncmp
.LVL39:
	.loc 2 86 8 view .LVU107
	testl	%eax, %eax
	jne	.L47
	.loc 2 91 5 is_stmt 1 view .LVU108
	.loc 2 91 23 is_stmt 0 view .LVU109
	leaq	8(%r12), %r13
	.loc 2 91 9 view .LVU110
	movl	$4, %r8d
	leaq	.LC4(%rip), %rdx
	movq	%r13, %rcx
	call	strncmp
.LVL40:
	.loc 2 91 8 view .LVU111
	testl	%eax, %eax
	jne	.L48
	.loc 2 96 5 is_stmt 1 view .LVU112
	.loc 2 96 9 is_stmt 0 view .LVU113
	leaq	12(%r12), %rcx
	movl	$4, %r8d
	leaq	.LC6(%rip), %rdx
	call	strncmp
.LVL41:
	.loc 2 96 8 view .LVU114
	testl	%eax, %eax
	jne	.L49
.LVL42:
.LBB9:
.LBI9:
	.loc 2 85 6 is_stmt 1 view .LVU115
.LBB10:
	.loc 2 101 5 view .LVU116
	.loc 2 101 15 is_stmt 0 view .LVU117
	movl	16(%r12), %edx
	.loc 2 101 8 view .LVU118
	cmpl	$16, %edx
	jne	.L50
	.loc 2 106 5 is_stmt 1 view .LVU119
	.loc 2 106 8 is_stmt 0 view .LVU120
	cmpw	$1, 20(%r12)
	jne	.L51
	.loc 2 111 5 is_stmt 1 view .LVU121
	.loc 2 111 15 is_stmt 0 view .LVU122
	movzwl	34(%r12), %edx
	.loc 2 111 32 view .LVU123
	movl	%edx, %eax
	andl	$-9, %eax
	.loc 2 111 58 view .LVU124
	cmpw	$16, %ax
	je	.L40
	cmpw	$32, %dx
	jne	.L52
.L40:
	.loc 2 116 12 view .LVU125
	movl	$1, %eax
.LVL43:
	.loc 2 116 12 view .LVU126
.LBE10:
.LBE9:
	.loc 2 117 1 view .LVU127
	addq	$40, %rsp
.LCFI32:
	popq	%r12
.LCFI33:
.LVL44:
	.loc 2 117 1 view .LVU128
	popq	%r13
.LCFI34:
.LVL45:
	.loc 2 117 1 view .LVU129
	ret
.LVL46:
	.p2align 4,,10
	.p2align 3
.L47:
.LCFI35:
	.loc 2 87 9 is_stmt 1 view .LVU130
	movq	%r12, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
.LVL47:
	.loc 2 88 9 view .LVU131
	.loc 2 88 16 is_stmt 0 view .LVU132
	xorl	%eax, %eax
.L33:
	.loc 2 117 1 view .LVU133
	addq	$40, %rsp
.LCFI36:
	popq	%r12
.LCFI37:
.LVL48:
	.loc 2 117 1 view .LVU134
	popq	%r13
.LCFI38:
	ret
.LVL49:
	.p2align 4,,10
	.p2align 3
.L50:
.LCFI39:
.LBB14:
.LBB11:
	.loc 2 102 9 is_stmt 1 view .LVU135
	leaq	.LC8(%rip), %rcx
	call	printf
.LVL50:
	.loc 2 103 9 view .LVU136
	.loc 2 103 16 is_stmt 0 view .LVU137
	xorl	%eax, %eax
.LBE11:
.LBE14:
	.loc 2 117 1 view .LVU138
	addq	$40, %rsp
.LCFI40:
	popq	%r12
.LCFI41:
.LVL51:
	.loc 2 117 1 view .LVU139
	popq	%r13
.LCFI42:
.LVL52:
	.loc 2 117 1 view .LVU140
	ret
.LVL53:
	.p2align 4,,10
	.p2align 3
.L48:
.LCFI43:
	.loc 2 92 9 is_stmt 1 view .LVU141
	movq	%r13, %rdx
	leaq	.LC5(%rip), %rcx
	call	printf
.LVL54:
	.loc 2 93 9 view .LVU142
	.loc 2 93 16 is_stmt 0 view .LVU143
	xorl	%eax, %eax
	.loc 2 117 1 view .LVU144
	addq	$40, %rsp
.LCFI44:
	popq	%r12
.LCFI45:
.LVL55:
	.loc 2 117 1 view .LVU145
	popq	%r13
.LCFI46:
.LVL56:
	.loc 2 117 1 view .LVU146
	ret
.LVL57:
	.p2align 4,,10
	.p2align 3
.L49:
.LCFI47:
	.loc 2 97 9 is_stmt 1 view .LVU147
	movq	%r13, %rdx
	leaq	.LC7(%rip), %rcx
	call	printf
.LVL58:
	.loc 2 98 9 view .LVU148
	.loc 2 98 16 is_stmt 0 view .LVU149
	xorl	%eax, %eax
	.loc 2 117 1 view .LVU150
	addq	$40, %rsp
.LCFI48:
	popq	%r12
.LCFI49:
.LVL59:
	.loc 2 117 1 view .LVU151
	popq	%r13
.LCFI50:
.LVL60:
	.loc 2 117 1 view .LVU152
	ret
.LVL61:
	.p2align 4,,10
	.p2align 3
.L51:
.LCFI51:
.LBB15:
.LBB12:
	.loc 2 107 9 is_stmt 1 view .LVU153
	leaq	.LC9(%rip), %rcx
	call	printf
.LVL62:
	.loc 2 108 9 view .LVU154
	.loc 2 108 16 is_stmt 0 view .LVU155
	xorl	%eax, %eax
.LBE12:
.LBE15:
	.loc 2 117 1 view .LVU156
	addq	$40, %rsp
.LCFI52:
	popq	%r12
.LCFI53:
.LVL63:
	.loc 2 117 1 view .LVU157
	popq	%r13
.LCFI54:
.LVL64:
	.loc 2 117 1 view .LVU158
	ret
.LVL65:
	.p2align 4,,10
	.p2align 3
.L52:
.LCFI55:
.LBB16:
.LBB13:
	.loc 2 112 9 is_stmt 1 view .LVU159
	leaq	.LC10(%rip), %rcx
	call	printf
.LVL66:
	.loc 2 113 9 view .LVU160
	.loc 2 113 16 is_stmt 0 view .LVU161
	xorl	%eax, %eax
	jmp	.L33
.LBE13:
.LBE16:
.LFE51:
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
.LC16:
	.ascii "Read all %d bytes...\12\0"
	.align 8
.LC17:
	.ascii "Bit depth %d not yet supported.\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
.LVL67:
.LFB52:
	.loc 2 119 40 is_stmt 1 view -0
	.loc 2 119 40 is_stmt 0 view .LVU163
	pushq	%r14
	.seh_pushreg	%r14
.LCFI56:
	pushq	%r13
	.seh_pushreg	%r13
.LCFI57:
	pushq	%r12
	.seh_pushreg	%r12
.LCFI58:
	pushq	%rbp
	.seh_pushreg	%rbp
.LCFI59:
	pushq	%rdi
	.seh_pushreg	%rdi
.LCFI60:
	pushq	%rsi
	.seh_pushreg	%rsi
.LCFI61:
	pushq	%rbx
	.seh_pushreg	%rbx
.LCFI62:
	subq	$160, %rsp
	.seh_stackalloc	160
.LCFI63:
	movaps	%xmm6, 144(%rsp)
	.seh_savexmm	%xmm6, 144
.LCFI64:
	.seh_endprologue
	.loc 2 119 40 view .LVU164
	movl	%ecx, %r12d
	movq	%rdx, %r13
	call	__main
.LVL68:
	.loc 2 120 5 is_stmt 1 view .LVU165
	.loc 2 121 5 view .LVU166
	.loc 2 121 26 is_stmt 0 view .LVU167
	leaq	64(%rsp), %r8
	movq	%r13, %rdx
	movl	%r12d, %ecx
	call	parseParams
.LVL69:
	.loc 2 123 5 is_stmt 1 view .LVU168
	.loc 2 123 8 is_stmt 0 view .LVU169
	cmpl	$1, %eax
	je	.L68
	.loc 2 126 12 is_stmt 1 view .LVU170
	.loc 2 126 15 is_stmt 0 view .LVU171
	cmpl	$2, %eax
	je	.L69
	.loc 2 131 5 is_stmt 1 view .LVU172
	.loc 2 132 5 view .LVU173
	.loc 2 132 14 is_stmt 0 view .LVU174
	movq	64(%rsp), %r13
.LVL70:
	.loc 2 132 14 view .LVU175
	leaq	.LC13(%rip), %rdx
	movq	%r13, %rcx
	call	fopen
.LVL71:
	.loc 2 132 14 view .LVU176
	movq	%rax, %r12
.LVL72:
	.loc 2 133 5 is_stmt 1 view .LVU177
	.loc 2 133 8 is_stmt 0 view .LVU178
	testq	%rax, %rax
	je	.L70
	.loc 2 138 5 is_stmt 1 view .LVU179
	.loc 2 139 5 view .LVU180
	leaq	96(%rsp), %r13
	movq	%rax, %r9
	movl	$1, %r8d
	movl	$44, %edx
	movq	%r13, %rcx
	call	fread
.LVL73:
	.loc 2 141 5 view .LVU181
	.loc 2 141 9 is_stmt 0 view .LVU182
	movq	%r13, %rcx
	.loc 2 144 16 view .LVU183
	movl	$1, %r13d
	.loc 2 141 9 view .LVU184
	call	verifyHeader
.LVL74:
	.loc 2 141 8 view .LVU185
	testb	%al, %al
	jne	.L71
.LVL75:
.L53:
	.loc 2 187 1 view .LVU186
	movaps	144(%rsp), %xmm6
	movl	%r13d, %eax
	addq	$160, %rsp
.LCFI65:
	popq	%rbx
.LCFI66:
	popq	%rsi
.LCFI67:
	popq	%rdi
.LCFI68:
	popq	%rbp
.LCFI69:
	popq	%r12
.LCFI70:
	popq	%r13
.LCFI71:
	popq	%r14
.LCFI72:
	ret
.LVL76:
.L71:
.LCFI73:
	.loc 2 142 9 is_stmt 1 view .LVU187
	leaq	.LC15(%rip), %rcx
	call	printf
.LVL77:
	.loc 2 147 5 view .LVU188
	.loc 2 147 15 is_stmt 0 view .LVU189
	movzwl	130(%rsp), %eax
	.loc 2 147 8 view .LVU190
	cmpw	$24, %ax
	jne	.L58
.LBB17:
	.loc 2 148 9 is_stmt 1 view .LVU191
	.loc 2 148 38 is_stmt 0 view .LVU192
	movl	136(%rsp), %ecx
	movq	%rcx, %r14
	.loc 2 148 25 view .LVU193
	call	malloc
.LVL78:
	movq	%rax, %rsi
.LVL79:
	.loc 2 150 9 is_stmt 1 view .LVU194
	.loc 2 151 9 view .LVU195
	.loc 2 153 9 view .LVU196
	.loc 2 153 28 view .LVU197
	cmpl	$8, %r14d
	jbe	.L64
	movq	%rax, %rbp
	movl	$8, %edi
	leaq	32(%rsp), %rbx
.LBB18:
.LBB19:
	.loc 2 159 21 is_stmt 0 view .LVU198
	pxor	%xmm6, %xmm6
.LVL80:
	.p2align 4,,10
	.p2align 3
.L60:
	.loc 2 159 21 view .LVU199
.LBE19:
.LBE18:
	.loc 2 154 13 view .LVU200
	movl	$3, %edx
	movq	%rbx, %rcx
	movq	%r12, %r9
	movl	%edi, %r13d
.LVL81:
	.loc 2 154 13 is_stmt 1 view .LVU201
	movl	$8, %r8d
	.loc 2 153 28 is_stmt 0 view .LVU202
	addl	$8, %edi
.LVL82:
	.loc 2 153 28 view .LVU203
	addq	$32, %rbp
	.loc 2 154 13 view .LVU204
	call	fread
.LVL83:
	.loc 2 155 13 is_stmt 1 view .LVU205
.LBB30:
	.loc 2 155 18 view .LVU206
	.loc 2 155 31 view .LVU207
.LBB20:
	.loc 2 156 17 view .LVU208
	.loc 2 157 17 view .LVU209
	.loc 2 158 17 view .LVU210
	.loc 2 159 17 view .LVU211
	.loc 2 160 17 view .LVU212
.LBE20:
	.loc 2 155 37 view .LVU213
	.loc 2 155 31 view .LVU214
.LBB21:
	.loc 2 156 17 view .LVU215
	.loc 2 157 17 view .LVU216
	.loc 2 158 17 view .LVU217
	.loc 2 159 17 view .LVU218
	.loc 2 160 17 view .LVU219
.LBE21:
	.loc 2 155 37 view .LVU220
	.loc 2 155 31 view .LVU221
.LBB22:
	.loc 2 156 17 view .LVU222
	.loc 2 157 17 view .LVU223
	.loc 2 158 17 view .LVU224
	.loc 2 159 17 view .LVU225
	.loc 2 160 17 view .LVU226
.LBE22:
	.loc 2 155 37 view .LVU227
	.loc 2 155 31 view .LVU228
.LBB23:
	.loc 2 156 17 view .LVU229
	.loc 2 157 17 view .LVU230
	.loc 2 158 17 view .LVU231
	.loc 2 159 17 view .LVU232
	.loc 2 160 17 view .LVU233
.LBE23:
	.loc 2 155 37 view .LVU234
	.loc 2 155 31 view .LVU235
.LBB24:
	.loc 2 156 17 view .LVU236
	.loc 2 157 17 view .LVU237
	.loc 2 158 17 view .LVU238
	.loc 2 159 17 view .LVU239
	.loc 2 160 17 view .LVU240
.LBE24:
	.loc 2 155 37 view .LVU241
	.loc 2 155 31 view .LVU242
.LBB25:
	.loc 2 156 17 view .LVU243
	.loc 2 157 17 view .LVU244
	.loc 2 158 17 view .LVU245
	.loc 2 159 17 view .LVU246
	.loc 2 160 17 view .LVU247
.LBE25:
	.loc 2 155 37 view .LVU248
	.loc 2 155 31 view .LVU249
.LBB26:
	.loc 2 156 17 view .LVU250
	.loc 2 157 17 view .LVU251
	.loc 2 158 17 view .LVU252
	.loc 2 159 17 view .LVU253
	.loc 2 160 17 view .LVU254
.LBE26:
	.loc 2 155 37 view .LVU255
	.loc 2 155 31 view .LVU256
.LBB27:
	.loc 2 156 17 view .LVU257
	.loc 2 157 17 view .LVU258
	.loc 2 158 17 view .LVU259
	movzwl	32(%rsp), %eax
	.loc 2 156 39 is_stmt 0 view .LVU260
	movzbl	52(%rsp), %ecx
	movzbl	55(%rsp), %edx
.LVL84:
	.loc 2 156 39 view .LVU261
.LBE27:
.LBE30:
	.loc 2 153 36 view .LVU262
	movl	136(%rsp), %r14d
	movd	%eax, %xmm0
	movzwl	38(%rsp), %eax
	pinsrw	$1, 35(%rsp), %xmm0
.LBB31:
.LBB28:
	.loc 2 156 25 view .LVU263
	movd	%edx, %xmm4
	.loc 2 156 39 view .LVU264
	movzbl	43(%rsp), %edx
.LVL85:
	.loc 2 156 39 view .LVU265
	movd	%eax, %xmm3
	movzwl	44(%rsp), %eax
	pinsrw	$1, 41(%rsp), %xmm3
	movd	%eax, %xmm1
	movzwl	50(%rsp), %eax
	pinsrw	$1, 47(%rsp), %xmm1
	punpckldq	%xmm3, %xmm0
	movd	%eax, %xmm2
	pinsrw	$1, 53(%rsp), %xmm2
	movzbl	46(%rsp), %eax
	punpckldq	%xmm2, %xmm1
	movd	%ecx, %xmm2
	movzbl	40(%rsp), %ecx
	punpcklqdq	%xmm1, %xmm0
	movd	%eax, %xmm1
	movzbl	49(%rsp), %eax
	.loc 2 156 25 view .LVU266
	punpckldq	%xmm4, %xmm2
	.loc 2 156 39 view .LVU267
	movd	%ecx, %xmm3
	.loc 2 156 25 view .LVU268
	movd	%edx, %xmm4
.LVL86:
	.loc 2 156 25 view .LVU269
	movd	%eax, %xmm5
	.loc 2 156 39 view .LVU270
	movzbl	34(%rsp), %eax
	.loc 2 156 25 view .LVU271
	punpckldq	%xmm4, %xmm3
	punpckldq	%xmm5, %xmm1
	punpcklqdq	%xmm2, %xmm1
	.loc 2 159 21 view .LVU272
	movdqa	%xmm0, %xmm2
	punpcklwd	%xmm6, %xmm0
	.loc 2 156 25 view .LVU273
	pslld	$24, %xmm1
	.loc 2 159 21 view .LVU274
	punpckhwd	%xmm6, %xmm2
	.loc 2 157 21 view .LVU275
	psrad	$8, %xmm1
	.loc 2 159 21 view .LVU276
	por	%xmm2, %xmm1
.LVL87:
	.loc 2 159 17 is_stmt 1 view .LVU277
	.loc 2 160 17 view .LVU278
	.loc 2 156 39 is_stmt 0 view .LVU279
	movd	%eax, %xmm2
	movzbl	37(%rsp), %eax
	.loc 2 160 35 view .LVU280
	movups	%xmm1, -16(%rbp)
.LBE28:
	.loc 2 155 37 is_stmt 1 view .LVU281
.LVL88:
	.loc 2 155 31 view .LVU282
	.loc 2 155 31 is_stmt 0 view .LVU283
.LBE31:
	.loc 2 153 28 is_stmt 1 view .LVU284
.LBB32:
.LBB29:
	.loc 2 156 25 is_stmt 0 view .LVU285
	movd	%eax, %xmm5
	punpckldq	%xmm5, %xmm2
	punpcklqdq	%xmm3, %xmm2
	pslld	$24, %xmm2
	.loc 2 157 21 view .LVU286
	psrad	$8, %xmm2
	.loc 2 159 21 view .LVU287
	por	%xmm2, %xmm0
	.loc 2 160 35 view .LVU288
	movups	%xmm0, -32(%rbp)
.LBE29:
.LBE32:
	.loc 2 153 28 view .LVU289
	cmpl	%edi, %r14d
	ja	.L60
.LVL89:
.L59:
	.loc 2 165 9 is_stmt 1 view .LVU290
	.loc 2 165 46 is_stmt 0 view .LVU291
	subl	%r13d, %r14d
.LVL90:
	.loc 2 166 9 is_stmt 1 view .LVU292
	.loc 2 166 12 is_stmt 0 view .LVU293
	testl	%r14d, %r14d
	jg	.L72
.L61:
	.loc 2 177 9 is_stmt 1 view .LVU294
	movl	%r13d, %edx
	leaq	.LC16(%rip), %rcx
.LBE17:
	.loc 2 186 12 is_stmt 0 view .LVU295
	xorl	%r13d, %r13d
.LBB37:
	.loc 2 177 9 view .LVU296
	call	printf
.LVL91:
.LBE37:
	.loc 2 184 5 is_stmt 1 view .LVU297
	movq	%r12, %rcx
	call	fclose
.LVL92:
	.loc 2 186 5 view .LVU298
	.loc 2 186 12 is_stmt 0 view .LVU299
	jmp	.L53
.LVL93:
.L58:
	.loc 2 180 9 is_stmt 1 view .LVU300
	movzwl	%ax, %edx
	leaq	.LC17(%rip), %rcx
	call	printf
.LVL94:
	.loc 2 181 9 view .LVU301
	.loc 2 181 16 is_stmt 0 view .LVU302
	jmp	.L53
.LVL95:
.L69:
	.loc 2 127 9 is_stmt 1 view .LVU303
	leaq	.LC12(%rip), %rcx
	.loc 2 128 16 is_stmt 0 view .LVU304
	movl	$1, %r13d
.LVL96:
	.loc 2 127 9 view .LVU305
	call	printf
.LVL97:
	.loc 2 128 9 is_stmt 1 view .LVU306
	.loc 2 128 16 is_stmt 0 view .LVU307
	jmp	.L53
.LVL98:
.L70:
	.loc 2 134 9 is_stmt 1 view .LVU308
	movq	%r13, %rdx
	leaq	.LC14(%rip), %rcx
	.loc 2 135 16 is_stmt 0 view .LVU309
	movl	$1, %r13d
	.loc 2 134 9 view .LVU310
	call	printf
.LVL99:
	.loc 2 135 9 is_stmt 1 view .LVU311
	.loc 2 135 16 is_stmt 0 view .LVU312
	jmp	.L53
.LVL100:
.L68:
	.loc 2 124 9 is_stmt 1 view .LVU313
	leaq	.LC11(%rip), %rcx
	.loc 2 125 16 is_stmt 0 view .LVU314
	xorl	%r13d, %r13d
.LVL101:
	.loc 2 124 9 view .LVU315
	call	printf
.LVL102:
	.loc 2 125 9 is_stmt 1 view .LVU316
	.loc 2 125 16 is_stmt 0 view .LVU317
	jmp	.L53
.LVL103:
.L72:
.LBB38:
	.loc 2 167 13 is_stmt 1 view .LVU318
	leaq	32(%rsp), %rbx
	movq	%r12, %r9
	movl	$3, %edx
	movslq	%r14d, %r8
	movq	%rbx, %rcx
	call	fread
.LVL104:
	.loc 2 168 13 view .LVU319
.LBB33:
	.loc 2 168 18 view .LVU320
	.loc 2 168 31 view .LVU321
	movslq	%r13d, %rdx
	movq	%rbx, %rax
	leaq	(%rsi,%rdx,4), %r9
.LBE33:
	.loc 2 167 13 is_stmt 0 view .LVU322
	xorl	%edx, %edx
.LVL105:
.L62:
.LBB36:
.LBB34:
	.loc 2 169 17 is_stmt 1 discriminator 3 view .LVU323
	.loc 2 169 25 is_stmt 0 discriminator 3 view .LVU324
	movsbl	2(%rax), %r8d
.LVL106:
	.loc 2 170 17 is_stmt 1 discriminator 3 view .LVU325
	.loc 2 172 21 is_stmt 0 discriminator 3 view .LVU326
	movzwl	(%rax), %ecx
.LBE34:
	.loc 2 168 31 discriminator 3 view .LVU327
	addq	$3, %rax
.LVL107:
.LBB35:
	.loc 2 170 21 discriminator 3 view .LVU328
	sall	$16, %r8d
.LVL108:
	.loc 2 171 17 is_stmt 1 discriminator 3 view .LVU329
	.loc 2 172 17 discriminator 3 view .LVU330
	.loc 2 173 17 discriminator 3 view .LVU331
	.loc 2 172 21 is_stmt 0 discriminator 3 view .LVU332
	orl	%r8d, %ecx
	movl	%ecx, (%r9,%rdx,4)
.LBE35:
	.loc 2 168 45 is_stmt 1 discriminator 3 view .LVU333
.LVL109:
	.loc 2 168 31 discriminator 3 view .LVU334
	addq	$1, %rdx
.LVL110:
	.loc 2 168 31 is_stmt 0 discriminator 3 view .LVU335
	cmpl	%edx, %r14d
	jg	.L62
	jmp	.L61
.LVL111:
.L64:
	.loc 2 168 31 discriminator 3 view .LVU336
.LBE36:
	.loc 2 150 13 view .LVU337
	xorl	%r13d, %r13d
	jmp	.L59
.LBE38:
.LFE52:
	.seh_endproc
	.section	.debug_frame,"dr"
.Lframe0:
	.long	.LECIE0-.LSCIE0
.LSCIE0:
	.long	0xffffffff
	.byte	0x3
	.ascii "\0"
	.uleb128 0x1
	.sleb128 -8
	.uleb128 0x10
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE0:
.LSFDE0:
	.long	.LEFDE0-.LASFDE0
.LASFDE0:
	.secrel32	.Lframe0
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.byte	0x4
	.long	.LCFI0-.LFB8
	.byte	0xe
	.uleb128 0x10
	.byte	0x8c
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI1-.LCFI0
	.byte	0xe
	.uleb128 0x18
	.byte	0x83
	.uleb128 0x3
	.byte	0x4
	.long	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0x50
	.byte	0x4
	.long	.LCFI3-.LCFI2
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI4-.LCFI3
	.byte	0xc3
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI5-.LCFI4
	.byte	0xcc
	.byte	0xe
	.uleb128 0x8
	.align 8
.LEFDE0:
.LSFDE2:
	.long	.LEFDE2-.LASFDE2
.LASFDE2:
	.secrel32	.Lframe0
	.quad	.LFB50
	.quad	.LFE50-.LFB50
	.byte	0x4
	.long	.LCFI6-.LFB50
	.byte	0xe
	.uleb128 0x10
	.byte	0x8d
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI7-.LCFI6
	.byte	0xe
	.uleb128 0x18
	.byte	0x8c
	.uleb128 0x3
	.byte	0x4
	.long	.LCFI8-.LCFI7
	.byte	0xe
	.uleb128 0x20
	.byte	0x86
	.uleb128 0x4
	.byte	0x4
	.long	.LCFI9-.LCFI8
	.byte	0xe
	.uleb128 0x28
	.byte	0x85
	.uleb128 0x5
	.byte	0x4
	.long	.LCFI10-.LCFI9
	.byte	0xe
	.uleb128 0x30
	.byte	0x84
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI11-.LCFI10
	.byte	0xe
	.uleb128 0x38
	.byte	0x83
	.uleb128 0x7
	.byte	0x4
	.long	.LCFI12-.LCFI11
	.byte	0xe
	.uleb128 0x60
	.byte	0x4
	.long	.LCFI13-.LCFI12
	.byte	0xa
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.long	.LCFI14-.LCFI13
	.byte	0xc3
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.long	.LCFI15-.LCFI14
	.byte	0xc4
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.long	.LCFI16-.LCFI15
	.byte	0xc5
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.long	.LCFI17-.LCFI16
	.byte	0xc6
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI18-.LCFI17
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI19-.LCFI18
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI20-.LCFI19
	.byte	0xb
	.byte	0x4
	.long	.LCFI21-.LCFI20
	.byte	0xa
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.long	.LCFI22-.LCFI21
	.byte	0xc3
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.long	.LCFI23-.LCFI22
	.byte	0xc4
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.long	.LCFI24-.LCFI23
	.byte	0xc5
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.long	.LCFI25-.LCFI24
	.byte	0xc6
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI26-.LCFI25
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI27-.LCFI26
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI28-.LCFI27
	.byte	0xb
	.align 8
.LEFDE2:
.LSFDE4:
	.long	.LEFDE4-.LASFDE4
.LASFDE4:
	.secrel32	.Lframe0
	.quad	.LFB51
	.quad	.LFE51-.LFB51
	.byte	0x4
	.long	.LCFI29-.LFB51
	.byte	0xe
	.uleb128 0x10
	.byte	0x8d
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI30-.LCFI29
	.byte	0xe
	.uleb128 0x18
	.byte	0x8c
	.uleb128 0x3
	.byte	0x4
	.long	.LCFI31-.LCFI30
	.byte	0xe
	.uleb128 0x40
	.byte	0x4
	.long	.LCFI32-.LCFI31
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI33-.LCFI32
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI34-.LCFI33
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI35-.LCFI34
	.byte	0xb
	.byte	0x4
	.long	.LCFI36-.LCFI35
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI37-.LCFI36
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI38-.LCFI37
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI39-.LCFI38
	.byte	0xb
	.byte	0x4
	.long	.LCFI40-.LCFI39
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI41-.LCFI40
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI42-.LCFI41
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI43-.LCFI42
	.byte	0xb
	.byte	0x4
	.long	.LCFI44-.LCFI43
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI45-.LCFI44
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI46-.LCFI45
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI47-.LCFI46
	.byte	0xb
	.byte	0x4
	.long	.LCFI48-.LCFI47
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI49-.LCFI48
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI50-.LCFI49
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI51-.LCFI50
	.byte	0xb
	.byte	0x4
	.long	.LCFI52-.LCFI51
	.byte	0xa
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI53-.LCFI52
	.byte	0xcc
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI54-.LCFI53
	.byte	0xcd
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI55-.LCFI54
	.byte	0xb
	.align 8
.LEFDE4:
.LSFDE6:
	.long	.LEFDE6-.LASFDE6
.LASFDE6:
	.secrel32	.Lframe0
	.quad	.LFB52
	.quad	.LFE52-.LFB52
	.byte	0x4
	.long	.LCFI56-.LFB52
	.byte	0xe
	.uleb128 0x10
	.byte	0x8e
	.uleb128 0x2
	.byte	0x4
	.long	.LCFI57-.LCFI56
	.byte	0xe
	.uleb128 0x18
	.byte	0x8d
	.uleb128 0x3
	.byte	0x4
	.long	.LCFI58-.LCFI57
	.byte	0xe
	.uleb128 0x20
	.byte	0x8c
	.uleb128 0x4
	.byte	0x4
	.long	.LCFI59-.LCFI58
	.byte	0xe
	.uleb128 0x28
	.byte	0x86
	.uleb128 0x5
	.byte	0x4
	.long	.LCFI60-.LCFI59
	.byte	0xe
	.uleb128 0x30
	.byte	0x85
	.uleb128 0x6
	.byte	0x4
	.long	.LCFI61-.LCFI60
	.byte	0xe
	.uleb128 0x38
	.byte	0x84
	.uleb128 0x7
	.byte	0x4
	.long	.LCFI62-.LCFI61
	.byte	0xe
	.uleb128 0x40
	.byte	0x83
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI63-.LCFI62
	.byte	0xe
	.uleb128 0xe0
	.byte	0x4
	.long	.LCFI64-.LCFI63
	.byte	0x97
	.uleb128 0xa
	.byte	0x4
	.long	.LCFI65-.LCFI64
	.byte	0xa
	.byte	0xd7
	.byte	0xe
	.uleb128 0x40
	.byte	0x4
	.long	.LCFI66-.LCFI65
	.byte	0xc3
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.long	.LCFI67-.LCFI66
	.byte	0xc4
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.long	.LCFI68-.LCFI67
	.byte	0xc5
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.long	.LCFI69-.LCFI68
	.byte	0xc6
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.long	.LCFI70-.LCFI69
	.byte	0xcc
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.long	.LCFI71-.LCFI70
	.byte	0xcd
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.long	.LCFI72-.LCFI71
	.byte	0xce
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.long	.LCFI73-.LCFI72
	.byte	0xb
	.align 8
.LEFDE6:
	.text
.Letext0:
	.file 3 "C:/msys64/mingw64/x86_64-w64-mingw32/include/vadefs.h"
	.file 4 "C:/msys64/mingw64/x86_64-w64-mingw32/include/corecrt.h"
	.file 5 "C:/msys64/mingw64/x86_64-w64-mingw32/include/stdint.h"
	.file 6 "C:/msys64/mingw64/x86_64-w64-mingw32/include/stdlib.h"
	.file 7 "C:/msys64/mingw64/x86_64-w64-mingw32/include/string.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0xcbd
	.word	0x5
	.byte	0x1
	.byte	0x8
	.secrel32	.Ldebug_abbrev0
	.uleb128 0x19
	.ascii "GNU C17 11.2.0 -mtune=generic -march=x86-64 -g -O3\0"
	.byte	0x1d
	.secrel32	.LASF0
	.secrel32	.LASF1
	.secrel32	.LLRL28
	.quad	0
	.secrel32	.Ldebug_line0
	.uleb128 0x6
	.ascii "__gnuc_va_list\0"
	.byte	0x3
	.byte	0x18
	.byte	0x1d
	.long	0x70
	.uleb128 0x1a
	.byte	0x8
	.ascii "__builtin_va_list\0"
	.long	0x88
	.uleb128 0x5
	.byte	0x1
	.byte	0x6
	.ascii "char\0"
	.uleb128 0x14
	.long	0x88
	.uleb128 0x6
	.ascii "va_list\0"
	.byte	0x3
	.byte	0x1f
	.byte	0x1a
	.long	0x59
	.uleb128 0x6
	.ascii "size_t\0"
	.byte	0x4
	.byte	0x23
	.byte	0x2c
	.long	0xb4
	.uleb128 0x5
	.byte	0x8
	.byte	0x7
	.ascii "long long unsigned int\0"
	.uleb128 0x5
	.byte	0x8
	.byte	0x5
	.ascii "long long int\0"
	.uleb128 0x5
	.byte	0x2
	.byte	0x7
	.ascii "short unsigned int\0"
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii "long int\0"
	.uleb128 0x8
	.long	0x88
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.ascii "unsigned int\0"
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.ascii "long unsigned int\0"
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.ascii "unsigned char\0"
	.uleb128 0x1b
	.ascii "_iobuf\0"
	.byte	0x30
	.byte	0x1
	.byte	0x21
	.byte	0xa
	.long	0x1d3
	.uleb128 0x2
	.ascii "_ptr\0"
	.byte	0x1
	.byte	0x25
	.byte	0xb
	.long	0x108
	.byte	0
	.uleb128 0x2
	.ascii "_cnt\0"
	.byte	0x1
	.byte	0x26
	.byte	0x9
	.long	0xf5
	.byte	0x8
	.uleb128 0x2
	.ascii "_base\0"
	.byte	0x1
	.byte	0x27
	.byte	0xb
	.long	0x108
	.byte	0x10
	.uleb128 0x2
	.ascii "_flag\0"
	.byte	0x1
	.byte	0x28
	.byte	0x9
	.long	0xf5
	.byte	0x18
	.uleb128 0x2
	.ascii "_file\0"
	.byte	0x1
	.byte	0x29
	.byte	0x9
	.long	0xf5
	.byte	0x1c
	.uleb128 0x2
	.ascii "_charbuf\0"
	.byte	0x1
	.byte	0x2a
	.byte	0x9
	.long	0xf5
	.byte	0x20
	.uleb128 0x2
	.ascii "_bufsiz\0"
	.byte	0x1
	.byte	0x2b
	.byte	0x9
	.long	0xf5
	.byte	0x24
	.uleb128 0x2
	.ascii "_tmpfname\0"
	.byte	0x1
	.byte	0x2c
	.byte	0xb
	.long	0x108
	.byte	0x28
	.byte	0
	.uleb128 0x6
	.ascii "FILE\0"
	.byte	0x1
	.byte	0x2f
	.byte	0x19
	.long	0x143
	.uleb128 0x5
	.byte	0x8
	.byte	0x4
	.ascii "double\0"
	.uleb128 0x5
	.byte	0x4
	.byte	0x4
	.ascii "float\0"
	.uleb128 0x5
	.byte	0x10
	.byte	0x4
	.ascii "long double\0"
	.uleb128 0x5
	.byte	0x1
	.byte	0x6
	.ascii "signed char\0"
	.uleb128 0x6
	.ascii "uint8_t\0"
	.byte	0x5
	.byte	0x24
	.byte	0x19
	.long	0x132
	.uleb128 0x5
	.byte	0x2
	.byte	0x5
	.ascii "short int\0"
	.uleb128 0x6
	.ascii "uint16_t\0"
	.byte	0x5
	.byte	0x26
	.byte	0x19
	.long	0xdf
	.uleb128 0x6
	.ascii "int32_t\0"
	.byte	0x5
	.byte	0x27
	.byte	0xe
	.long	0xf5
	.uleb128 0x6
	.ascii "uint32_t\0"
	.byte	0x5
	.byte	0x28
	.byte	0x14
	.long	0x10d
	.uleb128 0x1c
	.byte	0x7
	.byte	0x4
	.long	0x10d
	.byte	0x2
	.byte	0x7
	.byte	0xe
	.long	0x285
	.uleb128 0xe
	.ascii "EXEC\0"
	.byte	0
	.uleb128 0xe
	.ascii "HELP\0"
	.byte	0x1
	.uleb128 0xe
	.ascii "ERROR\0"
	.byte	0x2
	.byte	0
	.uleb128 0x6
	.ascii "ParseResult\0"
	.byte	0x2
	.byte	0xb
	.byte	0x3
	.long	0x260
	.uleb128 0xf
	.byte	0x20
	.byte	0xd
	.long	0x309
	.uleb128 0x2
	.ascii "inFile\0"
	.byte	0x2
	.byte	0xe
	.byte	0x11
	.long	0x309
	.byte	0
	.uleb128 0x2
	.ascii "outFile\0"
	.byte	0x2
	.byte	0xf
	.byte	0x11
	.long	0x309
	.byte	0x8
	.uleb128 0x2
	.ascii "startSpd\0"
	.byte	0x2
	.byte	0x10
	.byte	0xb
	.long	0x1ea
	.byte	0x10
	.uleb128 0x2
	.ascii "endSpd\0"
	.byte	0x2
	.byte	0x11
	.byte	0xb
	.long	0x1ea
	.byte	0x14
	.uleb128 0x2
	.ascii "delayTime\0"
	.byte	0x2
	.byte	0x12
	.byte	0xb
	.long	0x1ea
	.byte	0x18
	.uleb128 0x2
	.ascii "holdTime\0"
	.byte	0x2
	.byte	0x13
	.byte	0xb
	.long	0x1ea
	.byte	0x1c
	.byte	0
	.uleb128 0x8
	.long	0x90
	.uleb128 0x10
	.long	0x309
	.uleb128 0x6
	.ascii "Params\0"
	.byte	0x2
	.byte	0x14
	.byte	0x3
	.long	0x299
	.uleb128 0xf
	.byte	0x2c
	.byte	0x16
	.long	0x42a
	.uleb128 0x2
	.ascii "chunkID\0"
	.byte	0x2
	.byte	0x17
	.byte	0xa
	.long	0x42a
	.byte	0
	.uleb128 0x2
	.ascii "chunkSize\0"
	.byte	0x2
	.byte	0x18
	.byte	0xe
	.long	0x24f
	.byte	0x4
	.uleb128 0x2
	.ascii "format\0"
	.byte	0x2
	.byte	0x19
	.byte	0xa
	.long	0x42a
	.byte	0x8
	.uleb128 0x2
	.ascii "fmtChunkID\0"
	.byte	0x2
	.byte	0x1a
	.byte	0xa
	.long	0x42a
	.byte	0xc
	.uleb128 0x2
	.ascii "fmtChunkSize\0"
	.byte	0x2
	.byte	0x1b
	.byte	0xe
	.long	0x24f
	.byte	0x10
	.uleb128 0x2
	.ascii "audioFormat\0"
	.byte	0x2
	.byte	0x1c
	.byte	0xe
	.long	0x22e
	.byte	0x14
	.uleb128 0x2
	.ascii "numChannels\0"
	.byte	0x2
	.byte	0x1d
	.byte	0xe
	.long	0x22e
	.byte	0x16
	.uleb128 0x2
	.ascii "sampleRate\0"
	.byte	0x2
	.byte	0x1e
	.byte	0xe
	.long	0x24f
	.byte	0x18
	.uleb128 0x2
	.ascii "byteRate\0"
	.byte	0x2
	.byte	0x1f
	.byte	0xe
	.long	0x24f
	.byte	0x1c
	.uleb128 0x2
	.ascii "blockAlign\0"
	.byte	0x2
	.byte	0x20
	.byte	0xe
	.long	0x22e
	.byte	0x20
	.uleb128 0x2
	.ascii "bitDepth\0"
	.byte	0x2
	.byte	0x21
	.byte	0xe
	.long	0x22e
	.byte	0x22
	.uleb128 0x2
	.ascii "dataChunkID\0"
	.byte	0x2
	.byte	0x22
	.byte	0xa
	.long	0x42a
	.byte	0x24
	.uleb128 0x2
	.ascii "dataChunkSize\0"
	.byte	0x2
	.byte	0x23
	.byte	0xe
	.long	0x24f
	.byte	0x28
	.byte	0
	.uleb128 0x15
	.long	0x88
	.long	0x43a
	.uleb128 0x16
	.long	0xb4
	.byte	0x3
	.byte	0
	.uleb128 0x6
	.ascii "WavHeader\0"
	.byte	0x2
	.byte	0x24
	.byte	0x3
	.long	0x322
	.uleb128 0x14
	.long	0x43a
	.uleb128 0xf
	.byte	0x3
	.byte	0x26
	.long	0x486
	.uleb128 0x2
	.ascii "byte0\0"
	.byte	0x2
	.byte	0x27
	.byte	0xd
	.long	0x211
	.byte	0
	.uleb128 0x2
	.ascii "byte1\0"
	.byte	0x2
	.byte	0x28
	.byte	0xd
	.long	0x211
	.byte	0x1
	.uleb128 0x2
	.ascii "byte2\0"
	.byte	0x2
	.byte	0x29
	.byte	0xd
	.long	0x211
	.byte	0x2
	.byte	0
	.uleb128 0x6
	.ascii "LE24BitInt\0"
	.byte	0x2
	.byte	0x2a
	.byte	0x3
	.long	0x451
	.uleb128 0xa
	.ascii "fclose\0"
	.byte	0x1
	.word	0x263
	.byte	0xf
	.long	0xf5
	.long	0x4b3
	.uleb128 0x4
	.long	0x4b3
	.byte	0
	.uleb128 0x8
	.long	0x1d3
	.uleb128 0x10
	.long	0x4b3
	.uleb128 0xa
	.ascii "malloc\0"
	.byte	0x6
	.word	0x219
	.byte	0x11
	.long	0x4d7
	.long	0x4d7
	.uleb128 0x4
	.long	0xa5
	.byte	0
	.uleb128 0x1d
	.byte	0x8
	.uleb128 0x10
	.long	0x4d7
	.uleb128 0xa
	.ascii "fread\0"
	.byte	0x1
	.word	0x27d
	.byte	0x12
	.long	0xa5
	.long	0x506
	.uleb128 0x4
	.long	0x4d9
	.uleb128 0x4
	.long	0xa5
	.uleb128 0x4
	.long	0xa5
	.uleb128 0x4
	.long	0x4b8
	.byte	0
	.uleb128 0xa
	.ascii "fopen\0"
	.byte	0x1
	.word	0x278
	.byte	0x11
	.long	0x4b3
	.long	0x524
	.uleb128 0x4
	.long	0x30e
	.uleb128 0x4
	.long	0x30e
	.byte	0
	.uleb128 0xd
	.ascii "strncmp\0"
	.byte	0x7
	.byte	0x56
	.byte	0xf
	.long	0xf5
	.long	0x548
	.uleb128 0x4
	.long	0x309
	.uleb128 0x4
	.long	0x309
	.uleb128 0x4
	.long	0xa5
	.byte	0
	.uleb128 0xd
	.ascii "__mingw_vfprintf\0"
	.byte	0x1
	.byte	0xc1
	.byte	0xf
	.long	0xf5
	.long	0x575
	.uleb128 0x4
	.long	0x4b8
	.uleb128 0x4
	.long	0x30e
	.uleb128 0x4
	.long	0x95
	.byte	0
	.uleb128 0xd
	.ascii "__acrt_iob_func\0"
	.byte	0x1
	.byte	0x5d
	.byte	0x17
	.long	0x4b3
	.long	0x597
	.uleb128 0x4
	.long	0x10d
	.byte	0
	.uleb128 0xa
	.ascii "atof\0"
	.byte	0x6
	.word	0x1af
	.byte	0x12
	.long	0x1e0
	.long	0x5af
	.uleb128 0x4
	.long	0x309
	.byte	0
	.uleb128 0xd
	.ascii "strcmp\0"
	.byte	0x7
	.byte	0x3f
	.byte	0xf
	.long	0xf5
	.long	0x5cd
	.uleb128 0x4
	.long	0x309
	.uleb128 0x4
	.long	0x309
	.byte	0
	.uleb128 0x17
	.ascii "main\0"
	.byte	0x77
	.byte	0x5
	.long	0xf5
	.quad	.LFB52
	.quad	.LFE52-.LFB52
	.uleb128 0x1
	.byte	0x9c
	.long	0x905
	.uleb128 0xb
	.ascii "argc\0"
	.byte	0x77
	.byte	0xe
	.long	0xf5
	.secrel32	.LLST12
	.secrel32	.LVUS12
	.uleb128 0xb
	.ascii "argv\0"
	.byte	0x77
	.byte	0x20
	.long	0x905
	.secrel32	.LLST13
	.secrel32	.LVUS13
	.uleb128 0x11
	.ascii "params\0"
	.byte	0x78
	.byte	0xc
	.long	0x313
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x7
	.ascii "result\0"
	.byte	0x79
	.byte	0x11
	.long	0x285
	.secrel32	.LLST14
	.secrel32	.LVUS14
	.uleb128 0x7
	.ascii "inFile\0"
	.byte	0x83
	.byte	0xb
	.long	0x4b3
	.secrel32	.LLST15
	.secrel32	.LVUS15
	.uleb128 0x11
	.ascii "header\0"
	.byte	0x8a
	.byte	0xf
	.long	0x43a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x12
	.secrel32	.LLRL16
	.long	0x7bb
	.uleb128 0x7
	.ascii "data\0"
	.byte	0x94
	.byte	0x12
	.long	0x90a
	.secrel32	.LLST17
	.secrel32	.LVUS17
	.uleb128 0x7
	.ascii "byteCount\0"
	.byte	0x96
	.byte	0xd
	.long	0xf5
	.secrel32	.LLST18
	.secrel32	.LVUS18
	.uleb128 0x11
	.ascii "chunk\0"
	.byte	0x97
	.byte	0x14
	.long	0x90f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -192
	.uleb128 0x7
	.ascii "remaining\0"
	.byte	0xa5
	.byte	0xd
	.long	0xf5
	.secrel32	.LLST19
	.secrel32	.LVUS19
	.uleb128 0x12
	.secrel32	.LLRL20
	.long	0x6fb
	.uleb128 0x7
	.ascii "i\0"
	.byte	0x9b
	.byte	0x16
	.long	0xf5
	.secrel32	.LLST21
	.secrel32	.LVUS21
	.uleb128 0x13
	.secrel32	.LLRL22
	.uleb128 0x7
	.ascii "val\0"
	.byte	0x9c
	.byte	0x19
	.long	0x23f
	.secrel32	.LLST23
	.secrel32	.LVUS23
	.byte	0
	.byte	0
	.uleb128 0x12
	.secrel32	.LLRL24
	.long	0x72f
	.uleb128 0x7
	.ascii "i\0"
	.byte	0xa8
	.byte	0x16
	.long	0xf5
	.secrel32	.LLST25
	.secrel32	.LVUS25
	.uleb128 0x13
	.secrel32	.LLRL26
	.uleb128 0x7
	.ascii "val\0"
	.byte	0xa9
	.byte	0x19
	.long	0x23f
	.secrel32	.LLST27
	.secrel32	.LVUS27
	.byte	0
	.byte	0
	.uleb128 0x3
	.quad	.LVL78
	.long	0x4bd
	.long	0x747
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7e
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL83
	.long	0x4de
	.long	0x76f
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x33
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x1
	.byte	0x38
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL91
	.long	0xa79
	.long	0x78e
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC16
	.byte	0
	.uleb128 0x9
	.quad	.LVL104
	.long	0x4de
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0x91
	.sleb128 -192
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x33
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x8
	.byte	0x7e
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0xc
	.quad	.LVL68
	.long	0xcb1
	.uleb128 0x3
	.quad	.LVL69
	.long	0x957
	.long	0x7ed
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.byte	0
	.uleb128 0x3
	.quad	.LVL71
	.long	0x506
	.long	0x812
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	.LC13
	.byte	0
	.uleb128 0x3
	.quad	.LVL73
	.long	0x4de
	.long	0x83c
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x8
	.byte	0x2c
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x59
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL74
	.long	0x91f
	.long	0x855
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.byte	0
	.uleb128 0x3
	.quad	.LVL77
	.long	0xa79
	.long	0x874
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC15
	.byte	0
	.uleb128 0x3
	.quad	.LVL92
	.long	0x499
	.long	0x88c
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL94
	.long	0xa79
	.long	0x8ab
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC17
	.byte	0
	.uleb128 0x3
	.quad	.LVL97
	.long	0xa79
	.long	0x8ca
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC12
	.byte	0
	.uleb128 0x3
	.quad	.LVL99
	.long	0xa79
	.long	0x8e9
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC14
	.byte	0
	.uleb128 0x9
	.quad	.LVL102
	.long	0xa79
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC11
	.byte	0
	.byte	0
	.uleb128 0x8
	.long	0x309
	.uleb128 0x8
	.long	0x23f
	.uleb128 0x15
	.long	0x486
	.long	0x91f
	.uleb128 0x16
	.long	0xb4
	.byte	0x7
	.byte	0
	.uleb128 0x1e
	.ascii "verifyHeader\0"
	.byte	0x2
	.byte	0x55
	.byte	0x6
	.long	0x949
	.byte	0x1
	.long	0x949
	.uleb128 0x1f
	.ascii "header\0"
	.byte	0x2
	.byte	0x55
	.byte	0x24
	.long	0x952
	.byte	0
	.uleb128 0x5
	.byte	0x1
	.byte	0x2
	.ascii "_Bool\0"
	.uleb128 0x8
	.long	0x44c
	.uleb128 0x17
	.ascii "parseParams\0"
	.byte	0x2c
	.byte	0xd
	.long	0x285
	.quad	.LFB50
	.quad	.LFE50-.LFB50
	.uleb128 0x1
	.byte	0x9c
	.long	0xa74
	.uleb128 0xb
	.ascii "argc\0"
	.byte	0x2c
	.byte	0x1d
	.long	0xf5
	.secrel32	.LLST2
	.secrel32	.LVUS2
	.uleb128 0xb
	.ascii "argv\0"
	.byte	0x2c
	.byte	0x2f
	.long	0x905
	.secrel32	.LLST3
	.secrel32	.LVUS3
	.uleb128 0xb
	.ascii "params\0"
	.byte	0x2c
	.byte	0x3f
	.long	0xa74
	.secrel32	.LLST4
	.secrel32	.LVUS4
	.uleb128 0x7
	.ascii "param\0"
	.byte	0x2d
	.byte	0x11
	.long	0x309
	.secrel32	.LLST5
	.secrel32	.LVUS5
	.uleb128 0x7
	.ascii "foundParams\0"
	.byte	0x2e
	.byte	0x9
	.long	0xf5
	.secrel32	.LLST6
	.secrel32	.LVUS6
	.uleb128 0x13
	.secrel32	.LLRL7
	.uleb128 0x7
	.ascii "i\0"
	.byte	0x30
	.byte	0xe
	.long	0xf5
	.secrel32	.LLST8
	.secrel32	.LVUS8
	.uleb128 0xc
	.quad	.LVL14
	.long	0x597
	.uleb128 0xc
	.quad	.LVL22
	.long	0x597
	.uleb128 0xc
	.quad	.LVL24
	.long	0x597
	.uleb128 0x3
	.quad	.LVL26
	.long	0xa79
	.long	0xa4a
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.byte	0
	.uleb128 0xc
	.quad	.LVL29
	.long	0x597
	.uleb128 0x9
	.quad	.LVL36
	.long	0xa79
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x8
	.long	0x313
	.uleb128 0x20
	.ascii "printf\0"
	.byte	0x1
	.word	0x170
	.byte	0x5
	.long	0xf5
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xb1f
	.uleb128 0x21
	.ascii "__format\0"
	.byte	0x1
	.word	0x170
	.byte	0x19
	.long	0x309
	.secrel32	.LLST0
	.secrel32	.LVUS0
	.uleb128 0x22
	.uleb128 0x23
	.ascii "__retval\0"
	.byte	0x1
	.word	0x172
	.byte	0x7
	.long	0xf5
	.secrel32	.LLST1
	.secrel32	.LVUS1
	.uleb128 0x24
	.ascii "__local_argv\0"
	.byte	0x1
	.word	0x173
	.byte	0x15
	.long	0x70
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x3
	.quad	.LVL2
	.long	0x575
	.long	0xb04
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0x9
	.quad	.LVL3
	.long	0x548
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.byte	0
	.byte	0
	.uleb128 0x25
	.long	0x91f
	.quad	.LFB51
	.quad	.LFE51-.LFB51
	.uleb128 0x1
	.byte	0x9c
	.long	0xcb1
	.uleb128 0x18
	.long	0x939
	.secrel32	.LLST9
	.secrel32	.LVUS9
	.uleb128 0x26
	.long	0x91f
	.quad	.LBI9
	.byte	.LVU115
	.secrel32	.LLRL10
	.byte	0x2
	.byte	0x55
	.byte	0x6
	.long	0xbc7
	.uleb128 0x18
	.long	0x939
	.secrel32	.LLST11
	.secrel32	.LVUS11
	.uleb128 0x3
	.quad	.LVL50
	.long	0xa79
	.long	0xb8c
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.byte	0
	.uleb128 0x3
	.quad	.LVL62
	.long	0xa79
	.long	0xbab
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC9
	.byte	0
	.uleb128 0x9
	.quad	.LVL66
	.long	0xa79
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.byte	0
	.byte	0
	.uleb128 0x3
	.quad	.LVL39
	.long	0x524
	.long	0xbf1
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x1
	.byte	0x34
	.byte	0
	.uleb128 0x3
	.quad	.LVL40
	.long	0x524
	.long	0xc1b
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	.LC4
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x1
	.byte	0x34
	.byte	0
	.uleb128 0x3
	.quad	.LVL41
	.long	0x524
	.long	0xc45
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x7c
	.sleb128 12
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x1
	.byte	0x34
	.byte	0
	.uleb128 0x3
	.quad	.LVL47
	.long	0xa79
	.long	0xc6a
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL54
	.long	0xa79
	.long	0xc8f
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.uleb128 0x9
	.quad	.LVL58
	.long	0xa79
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x27
	.ascii "__main\0"
	.ascii "__main\0"
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"dr"
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.word	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS12:
	.uleb128 0
	.uleb128 .LVU165
	.uleb128 .LVU165
	.uleb128 .LVU177
	.uleb128 .LVU177
	.uleb128 .LVU303
	.uleb128 .LVU303
	.uleb128 .LVU308
	.uleb128 .LVU308
	.uleb128 .LVU313
	.uleb128 .LVU313
	.uleb128 .LVU318
	.uleb128 .LVU318
	.uleb128 0
.LLST12:
	.byte	0x6
	.quad	.LVL67
	.byte	0x4
	.uleb128 .LVL67-.LVL67
	.uleb128 .LVL68-1-.LVL67
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL68-1-.LVL67
	.uleb128 .LVL72-.LVL67
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL72-.LVL67
	.uleb128 .LVL95-.LVL67
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL95-.LVL67
	.uleb128 .LVL98-.LVL67
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL98-.LVL67
	.uleb128 .LVL100-.LVL67
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL100-.LVL67
	.uleb128 .LVL103-.LVL67
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL103-.LVL67
	.uleb128 .LFE52-.LVL67
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0
.LVUS13:
	.uleb128 0
	.uleb128 .LVU165
	.uleb128 .LVU165
	.uleb128 .LVU175
	.uleb128 .LVU175
	.uleb128 .LVU303
	.uleb128 .LVU303
	.uleb128 .LVU305
	.uleb128 .LVU305
	.uleb128 .LVU313
	.uleb128 .LVU313
	.uleb128 .LVU315
	.uleb128 .LVU315
	.uleb128 0
.LLST13:
	.byte	0x6
	.quad	.LVL67
	.byte	0x4
	.uleb128 .LVL67-.LVL67
	.uleb128 .LVL68-1-.LVL67
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL68-1-.LVL67
	.uleb128 .LVL70-.LVL67
	.uleb128 0x1
	.byte	0x5d
	.byte	0x4
	.uleb128 .LVL70-.LVL67
	.uleb128 .LVL95-.LVL67
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL95-.LVL67
	.uleb128 .LVL96-.LVL67
	.uleb128 0x1
	.byte	0x5d
	.byte	0x4
	.uleb128 .LVL96-.LVL67
	.uleb128 .LVL100-.LVL67
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL100-.LVL67
	.uleb128 .LVL101-.LVL67
	.uleb128 0x1
	.byte	0x5d
	.byte	0x4
	.uleb128 .LVL101-.LVL67
	.uleb128 .LFE52-.LVL67
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS14:
	.uleb128 .LVU168
	.uleb128 .LVU176
	.uleb128 .LVU303
	.uleb128 .LVU306
	.uleb128 .LVU313
	.uleb128 .LVU316
.LLST14:
	.byte	0x6
	.quad	.LVL69
	.byte	0x4
	.uleb128 .LVL69-.LVL69
	.uleb128 .LVL71-1-.LVL69
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL95-.LVL69
	.uleb128 .LVL97-1-.LVL69
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL100-.LVL69
	.uleb128 .LVL102-1-.LVL69
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS15:
	.uleb128 .LVU177
	.uleb128 .LVU181
	.uleb128 .LVU181
	.uleb128 .LVU186
	.uleb128 .LVU187
	.uleb128 .LVU303
	.uleb128 .LVU308
	.uleb128 .LVU311
	.uleb128 .LVU311
	.uleb128 .LVU313
	.uleb128 .LVU318
	.uleb128 0
.LLST15:
	.byte	0x6
	.quad	.LVL72
	.byte	0x4
	.uleb128 .LVL72-.LVL72
	.uleb128 .LVL73-1-.LVL72
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL73-1-.LVL72
	.uleb128 .LVL75-.LVL72
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL76-.LVL72
	.uleb128 .LVL95-.LVL72
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL98-.LVL72
	.uleb128 .LVL99-1-.LVL72
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL99-1-.LVL72
	.uleb128 .LVL100-.LVL72
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL103-.LVL72
	.uleb128 .LFE52-.LVL72
	.uleb128 0x1
	.byte	0x5c
	.byte	0
.LVUS17:
	.uleb128 .LVU194
	.uleb128 .LVU199
	.uleb128 .LVU199
	.uleb128 .LVU300
	.uleb128 .LVU318
	.uleb128 .LVU336
	.uleb128 .LVU336
	.uleb128 0
.LLST17:
	.byte	0x6
	.quad	.LVL79
	.byte	0x4
	.uleb128 .LVL79-.LVL79
	.uleb128 .LVL80-.LVL79
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL80-.LVL79
	.uleb128 .LVL93-.LVL79
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL103-.LVL79
	.uleb128 .LVL111-.LVL79
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL111-.LVL79
	.uleb128 .LFE52-.LVL79
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS18:
	.uleb128 .LVU195
	.uleb128 .LVU199
	.uleb128 .LVU201
	.uleb128 .LVU203
	.uleb128 .LVU203
	.uleb128 .LVU283
	.uleb128 .LVU336
	.uleb128 0
.LLST18:
	.byte	0x6
	.quad	.LVL79
	.byte	0x4
	.uleb128 .LVL79-.LVL79
	.uleb128 .LVL80-.LVL79
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL81-.LVL79
	.uleb128 .LVL82-.LVL79
	.uleb128 0x3
	.byte	0x75
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL82-.LVL79
	.uleb128 .LVL88-.LVL79
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL111-.LVL79
	.uleb128 .LFE52-.LVL79
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS19:
	.uleb128 .LVU292
	.uleb128 .LVU300
	.uleb128 .LVU318
	.uleb128 .LVU336
.LLST19:
	.byte	0x6
	.quad	.LVL90
	.byte	0x4
	.uleb128 .LVL90-.LVL90
	.uleb128 .LVL93-.LVL90
	.uleb128 0x1
	.byte	0x5e
	.byte	0x4
	.uleb128 .LVL103-.LVL90
	.uleb128 .LVL111-.LVL90
	.uleb128 0x1
	.byte	0x5e
	.byte	0
.LVUS21:
	.uleb128 .LVU207
	.uleb128 .LVU214
	.uleb128 .LVU214
	.uleb128 .LVU221
	.uleb128 .LVU221
	.uleb128 .LVU228
	.uleb128 .LVU228
	.uleb128 .LVU235
	.uleb128 .LVU235
	.uleb128 .LVU242
	.uleb128 .LVU242
	.uleb128 .LVU249
	.uleb128 .LVU249
	.uleb128 .LVU256
	.uleb128 .LVU256
	.uleb128 .LVU282
	.uleb128 .LVU282
	.uleb128 .LVU290
.LLST21:
	.byte	0x6
	.quad	.LVL83
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x33
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x34
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x35
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x2
	.byte	0x36
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL88-.LVL83
	.uleb128 0x2
	.byte	0x37
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL88-.LVL83
	.uleb128 .LVL89-.LVL83
	.uleb128 0x2
	.byte	0x38
	.byte	0x9f
	.byte	0
.LVUS23:
	.uleb128 .LVU209
	.uleb128 .LVU210
	.uleb128 .LVU210
	.uleb128 .LVU211
	.uleb128 .LVU211
	.uleb128 .LVU212
	.uleb128 .LVU212
	.uleb128 .LVU216
	.uleb128 .LVU216
	.uleb128 .LVU217
	.uleb128 .LVU217
	.uleb128 .LVU218
	.uleb128 .LVU218
	.uleb128 .LVU219
	.uleb128 .LVU219
	.uleb128 .LVU223
	.uleb128 .LVU223
	.uleb128 .LVU224
	.uleb128 .LVU224
	.uleb128 .LVU225
	.uleb128 .LVU225
	.uleb128 .LVU226
	.uleb128 .LVU226
	.uleb128 .LVU230
	.uleb128 .LVU230
	.uleb128 .LVU231
	.uleb128 .LVU231
	.uleb128 .LVU232
	.uleb128 .LVU232
	.uleb128 .LVU233
	.uleb128 .LVU233
	.uleb128 .LVU237
	.uleb128 .LVU237
	.uleb128 .LVU238
	.uleb128 .LVU238
	.uleb128 .LVU239
	.uleb128 .LVU239
	.uleb128 .LVU240
	.uleb128 .LVU240
	.uleb128 .LVU244
	.uleb128 .LVU244
	.uleb128 .LVU245
	.uleb128 .LVU245
	.uleb128 .LVU246
	.uleb128 .LVU246
	.uleb128 .LVU247
	.uleb128 .LVU247
	.uleb128 .LVU251
	.uleb128 .LVU251
	.uleb128 .LVU252
	.uleb128 .LVU252
	.uleb128 .LVU253
	.uleb128 .LVU253
	.uleb128 .LVU254
	.uleb128 .LVU254
	.uleb128 .LVU258
	.uleb128 .LVU258
	.uleb128 .LVU259
	.uleb128 .LVU259
	.uleb128 .LVU261
	.uleb128 .LVU261
	.uleb128 .LVU265
	.uleb128 .LVU265
	.uleb128 .LVU269
	.uleb128 .LVU269
	.uleb128 .LVU277
	.uleb128 .LVU277
	.uleb128 .LVU278
	.uleb128 .LVU278
	.uleb128 .LVU290
.LLST23:
	.byte	0x6
	.quad	.LVL83
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -190
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -190
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -190
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -192
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -190
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -192
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -187
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -187
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -187
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -189
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -187
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -189
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -184
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -184
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -184
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -186
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -184
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -186
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -181
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -181
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -181
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -183
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -181
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -183
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -178
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -178
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -178
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -180
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -178
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -180
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -175
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -175
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -175
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -177
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -175
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -177
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -172
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -172
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -172
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -174
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -172
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -174
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL83-.LVL83
	.uleb128 0xb
	.byte	0x91
	.sleb128 -169
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.LVL83
	.uleb128 .LVL84-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -169
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL84-.LVL83
	.uleb128 .LVL85-.LVL83
	.uleb128 0x7
	.byte	0x71
	.sleb128 0
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL85-.LVL83
	.uleb128 .LVL86-.LVL83
	.uleb128 0x7
	.byte	0x85
	.sleb128 0
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL86-.LVL83
	.uleb128 .LVL87-.LVL83
	.uleb128 0xd
	.byte	0x91
	.sleb128 -169
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL87-.LVL83
	.uleb128 .LVL87-.LVL83
	.uleb128 0x16
	.byte	0x91
	.sleb128 -169
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -171
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL87-.LVL83
	.uleb128 .LVL89-.LVL83
	.uleb128 0x17
	.byte	0x91
	.sleb128 -169
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x38
	.byte	0x26
	.byte	0x91
	.sleb128 -171
	.byte	0x94
	.byte	0x2
	.byte	0xa
	.word	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x9f
	.byte	0
.LVUS25:
	.uleb128 .LVU321
	.uleb128 .LVU323
	.uleb128 .LVU323
	.uleb128 .LVU334
	.uleb128 .LVU334
	.uleb128 .LVU335
.LLST25:
	.byte	0x6
	.quad	.LVL104
	.byte	0x4
	.uleb128 .LVL104-.LVL104
	.uleb128 .LVL105-.LVL104
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL105-.LVL104
	.uleb128 .LVL109-.LVL104
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL109-.LVL104
	.uleb128 .LVL110-.LVL104
	.uleb128 0x3
	.byte	0x71
	.sleb128 1
	.byte	0x9f
	.byte	0
.LVUS27:
	.uleb128 .LVU325
	.uleb128 .LVU328
	.uleb128 .LVU328
	.uleb128 .LVU329
	.uleb128 .LVU329
	.uleb128 .LVU330
	.uleb128 .LVU330
	.uleb128 .LVU331
.LLST27:
	.byte	0x6
	.quad	.LVL106
	.byte	0x4
	.uleb128 .LVL106-.LVL106
	.uleb128 .LVL107-.LVL106
	.uleb128 0xa
	.byte	0x70
	.sleb128 2
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL107-.LVL106
	.uleb128 .LVL108-.LVL106
	.uleb128 0xa
	.byte	0x70
	.sleb128 -1
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x48
	.byte	0x24
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL108-.LVL106
	.uleb128 .LVL108-.LVL106
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL108-.LVL106
	.uleb128 .LVL108-.LVL106
	.uleb128 0x19
	.byte	0x71
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x33
	.byte	0x1e
	.byte	0x91
	.sleb128 0
	.byte	0x22
	.byte	0x8
	.byte	0xc0
	.byte	0x1c
	.byte	0x94
	.byte	0x1
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x21
	.byte	0x9f
	.byte	0
.LVUS2:
	.uleb128 0
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 .LVU63
	.uleb128 .LVU63
	.uleb128 .LVU99
	.uleb128 .LVU99
	.uleb128 0
.LLST2:
	.byte	0x6
	.quad	.LVL5
	.byte	0x4
	.uleb128 .LVL5-.LVL5
	.uleb128 .LVL8-.LVL5
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL8-.LVL5
	.uleb128 .LVL18-.LVL5
	.uleb128 0x3
	.byte	0x7c
	.sleb128 1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL18-.LVL5
	.uleb128 .LVL37-.LVL5
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL37-.LVL5
	.uleb128 .LFE50-.LVL5
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU26
	.uleb128 .LVU26
	.uleb128 .LVU64
	.uleb128 .LVU64
	.uleb128 .LVU66
	.uleb128 .LVU66
	.uleb128 .LVU94
	.uleb128 .LVU94
	.uleb128 .LVU96
	.uleb128 .LVU96
	.uleb128 .LVU99
	.uleb128 .LVU99
	.uleb128 0
.LLST3:
	.byte	0x6
	.quad	.LVL5
	.byte	0x4
	.uleb128 .LVL5-.LVL5
	.uleb128 .LVL7-.LVL5
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL7-.LVL5
	.uleb128 .LVL19-.LVL5
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL19-.LVL5
	.uleb128 .LVL21-.LVL5
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.LVL5
	.uleb128 .LVL33-.LVL5
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL33-.LVL5
	.uleb128 .LVL35-.LVL5
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL35-.LVL5
	.uleb128 .LVL37-.LVL5
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL37-.LVL5
	.uleb128 .LFE50-.LVL5
	.uleb128 0x1
	.byte	0x51
	.byte	0
.LVUS4:
	.uleb128 0
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 .LVU65
	.uleb128 .LVU65
	.uleb128 .LVU66
	.uleb128 .LVU66
	.uleb128 .LVU95
	.uleb128 .LVU95
	.uleb128 .LVU96
	.uleb128 .LVU96
	.uleb128 0
.LLST4:
	.byte	0x6
	.quad	.LVL5
	.byte	0x4
	.uleb128 .LVL5-.LVL5
	.uleb128 .LVL8-.LVL5
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL8-.LVL5
	.uleb128 .LVL20-.LVL5
	.uleb128 0x1
	.byte	0x56
	.byte	0x4
	.uleb128 .LVL20-.LVL5
	.uleb128 .LVL21-.LVL5
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.LVL5
	.uleb128 .LVL34-.LVL5
	.uleb128 0x1
	.byte	0x56
	.byte	0x4
	.uleb128 .LVL34-.LVL5
	.uleb128 .LVL35-.LVL5
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL35-.LVL5
	.uleb128 .LFE50-.LVL5
	.uleb128 0x1
	.byte	0x56
	.byte	0
.LVUS5:
	.uleb128 .LVU18
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 .LVU30
	.uleb128 .LVU33
	.uleb128 .LVU34
	.uleb128 .LVU34
	.uleb128 .LVU49
	.uleb128 .LVU50
	.uleb128 .LVU63
	.uleb128 .LVU66
	.uleb128 .LVU71
	.uleb128 .LVU72
	.uleb128 .LVU77
	.uleb128 .LVU78
	.uleb128 .LVU81
	.uleb128 .LVU83
	.uleb128 .LVU89
	.uleb128 .LVU90
	.uleb128 .LVU97
	.uleb128 .LVU99
	.uleb128 0
.LLST5:
	.byte	0x6
	.quad	.LVL6
	.byte	0x4
	.uleb128 .LVL6-.LVL6
	.uleb128 .LVL8-.LVL6
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.LVL6
	.uleb128 .LVL9-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL10-.LVL6
	.uleb128 .LVL11-.LVL6
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL11-.LVL6
	.uleb128 .LVL14-1-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL15-.LVL6
	.uleb128 .LVL18-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL21-.LVL6
	.uleb128 .LVL22-1-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL23-.LVL6
	.uleb128 .LVL24-1-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL25-.LVL6
	.uleb128 .LVL26-1-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL27-.LVL6
	.uleb128 .LVL29-1-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL30-.LVL6
	.uleb128 .LVL36-1-.LVL6
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL37-.LVL6
	.uleb128 .LFE50-.LVL6
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS6:
	.uleb128 .LVU19
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 .LVU63
	.uleb128 .LVU66
	.uleb128 .LVU93
	.uleb128 .LVU96
	.uleb128 .LVU99
	.uleb128 .LVU99
	.uleb128 0
.LLST6:
	.byte	0x6
	.quad	.LVL6
	.byte	0x4
	.uleb128 .LVL6-.LVL6
	.uleb128 .LVL8-.LVL6
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.LVL6
	.uleb128 .LVL18-.LVL6
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL21-.LVL6
	.uleb128 .LVL32-.LVL6
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL35-.LVL6
	.uleb128 .LVL37-.LVL6
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL37-.LVL6
	.uleb128 .LFE50-.LVL6
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS8:
	.uleb128 .LVU21
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 .LVU35
	.uleb128 .LVU35
	.uleb128 .LVU36
	.uleb128 .LVU37
	.uleb128 .LVU56
	.uleb128 .LVU66
	.uleb128 .LVU92
	.uleb128 .LVU96
	.uleb128 .LVU99
	.uleb128 .LVU99
	.uleb128 0
.LLST8:
	.byte	0x6
	.quad	.LVL6
	.byte	0x4
	.uleb128 .LVL6-.LVL6
	.uleb128 .LVL8-.LVL6
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.LVL6
	.uleb128 .LVL11-.LVL6
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL11-.LVL6
	.uleb128 .LVL12-.LVL6
	.uleb128 0x3
	.byte	0x73
	.sleb128 1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.LVL6
	.uleb128 .LVL16-.LVL6
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL21-.LVL6
	.uleb128 .LVL31-.LVL6
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL35-.LVL6
	.uleb128 .LVL37-.LVL6
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL37-.LVL6
	.uleb128 .LFE50-.LVL6
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU14
	.uleb128 .LVU14
	.uleb128 0
.LLST0:
	.byte	0x6
	.quad	.LVL0
	.byte	0x4
	.uleb128 .LVL0-.LVL0
	.uleb128 .LVL1-.LVL0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL1-.LVL0
	.uleb128 .LVL4-.LVL0
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL4-.LVL0
	.uleb128 .LFE8-.LVL0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 .LVU11
	.uleb128 0
.LLST1:
	.byte	0x8
	.quad	.LVL3
	.uleb128 .LFE8-.LVL3
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS9:
	.uleb128 0
	.uleb128 .LVU107
	.uleb128 .LVU107
	.uleb128 .LVU128
	.uleb128 .LVU128
	.uleb128 .LVU129
	.uleb128 .LVU129
	.uleb128 .LVU130
	.uleb128 .LVU130
	.uleb128 .LVU134
	.uleb128 .LVU134
	.uleb128 .LVU135
	.uleb128 .LVU135
	.uleb128 .LVU139
	.uleb128 .LVU139
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU141
	.uleb128 .LVU141
	.uleb128 .LVU145
	.uleb128 .LVU145
	.uleb128 .LVU146
	.uleb128 .LVU146
	.uleb128 .LVU147
	.uleb128 .LVU147
	.uleb128 .LVU151
	.uleb128 .LVU151
	.uleb128 .LVU152
	.uleb128 .LVU152
	.uleb128 .LVU153
	.uleb128 .LVU153
	.uleb128 .LVU157
	.uleb128 .LVU157
	.uleb128 .LVU158
	.uleb128 .LVU158
	.uleb128 .LVU159
	.uleb128 .LVU159
	.uleb128 0
.LLST9:
	.byte	0x6
	.quad	.LVL38
	.byte	0x4
	.uleb128 .LVL38-.LVL38
	.uleb128 .LVL39-1-.LVL38
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL39-1-.LVL38
	.uleb128 .LVL44-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL44-.LVL38
	.uleb128 .LVL45-.LVL38
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL45-.LVL38
	.uleb128 .LVL46-.LVL38
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL46-.LVL38
	.uleb128 .LVL48-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL48-.LVL38
	.uleb128 .LVL49-.LVL38
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL49-.LVL38
	.uleb128 .LVL51-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL51-.LVL38
	.uleb128 .LVL52-.LVL38
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL52-.LVL38
	.uleb128 .LVL53-.LVL38
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL53-.LVL38
	.uleb128 .LVL55-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL55-.LVL38
	.uleb128 .LVL56-.LVL38
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL56-.LVL38
	.uleb128 .LVL57-.LVL38
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL57-.LVL38
	.uleb128 .LVL59-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL59-.LVL38
	.uleb128 .LVL60-.LVL38
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL60-.LVL38
	.uleb128 .LVL61-.LVL38
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL61-.LVL38
	.uleb128 .LVL63-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL63-.LVL38
	.uleb128 .LVL64-.LVL38
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL64-.LVL38
	.uleb128 .LVL65-.LVL38
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL65-.LVL38
	.uleb128 .LFE51-.LVL38
	.uleb128 0x1
	.byte	0x5c
	.byte	0
.LVUS11:
	.uleb128 .LVU115
	.uleb128 .LVU126
	.uleb128 .LVU135
	.uleb128 .LVU139
	.uleb128 .LVU139
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU141
	.uleb128 .LVU153
	.uleb128 .LVU157
	.uleb128 .LVU157
	.uleb128 .LVU158
	.uleb128 .LVU158
	.uleb128 .LVU159
	.uleb128 .LVU159
	.uleb128 0
.LLST11:
	.byte	0x6
	.quad	.LVL42
	.byte	0x4
	.uleb128 .LVL42-.LVL42
	.uleb128 .LVL43-.LVL42
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL49-.LVL42
	.uleb128 .LVL51-.LVL42
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL51-.LVL42
	.uleb128 .LVL52-.LVL42
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL52-.LVL42
	.uleb128 .LVL53-.LVL42
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL61-.LVL42
	.uleb128 .LVL63-.LVL42
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL63-.LVL42
	.uleb128 .LVL64-.LVL42
	.uleb128 0x3
	.byte	0x7d
	.sleb128 -8
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL64-.LVL42
	.uleb128 .LVL65-.LVL42
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL65-.LVL42
	.uleb128 .LFE51-.LVL42
	.uleb128 0x1
	.byte	0x5c
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"dr"
	.long	0x3c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB52
	.quad	.LFE52-.LFB52
	.quad	0
	.quad	0
	.section	.debug_rnglists,"dr"
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.word	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL7:
	.byte	0x5
	.quad	.LBB2
	.byte	0x4
	.uleb128 .LBB2-.LBB2
	.uleb128 .LBE2-.LBB2
	.byte	0x4
	.uleb128 .LBB3-.LBB2
	.uleb128 .LBE3-.LBB2
	.byte	0x4
	.uleb128 .LBB4-.LBB2
	.uleb128 .LBE4-.LBB2
	.byte	0x4
	.uleb128 .LBB5-.LBB2
	.uleb128 .LBE5-.LBB2
	.byte	0x4
	.uleb128 .LBB6-.LBB2
	.uleb128 .LBE6-.LBB2
	.byte	0
.LLRL10:
	.byte	0x5
	.quad	.LBB9
	.byte	0x4
	.uleb128 .LBB9-.LBB9
	.uleb128 .LBE9-.LBB9
	.byte	0x4
	.uleb128 .LBB14-.LBB9
	.uleb128 .LBE14-.LBB9
	.byte	0x4
	.uleb128 .LBB15-.LBB9
	.uleb128 .LBE15-.LBB9
	.byte	0x4
	.uleb128 .LBB16-.LBB9
	.uleb128 .LBE16-.LBB9
	.byte	0
.LLRL16:
	.byte	0x5
	.quad	.LBB17
	.byte	0x4
	.uleb128 .LBB17-.LBB17
	.uleb128 .LBE17-.LBB17
	.byte	0x4
	.uleb128 .LBB37-.LBB17
	.uleb128 .LBE37-.LBB17
	.byte	0x4
	.uleb128 .LBB38-.LBB17
	.uleb128 .LBE38-.LBB17
	.byte	0
.LLRL20:
	.byte	0x5
	.quad	.LBB18
	.byte	0x4
	.uleb128 .LBB18-.LBB18
	.uleb128 .LBE18-.LBB18
	.byte	0x4
	.uleb128 .LBB30-.LBB18
	.uleb128 .LBE30-.LBB18
	.byte	0x4
	.uleb128 .LBB31-.LBB18
	.uleb128 .LBE31-.LBB18
	.byte	0x4
	.uleb128 .LBB32-.LBB18
	.uleb128 .LBE32-.LBB18
	.byte	0
.LLRL22:
	.byte	0x5
	.quad	.LBB19
	.byte	0x4
	.uleb128 .LBB19-.LBB19
	.uleb128 .LBE19-.LBB19
	.byte	0x4
	.uleb128 .LBB20-.LBB19
	.uleb128 .LBE20-.LBB19
	.byte	0x4
	.uleb128 .LBB21-.LBB19
	.uleb128 .LBE21-.LBB19
	.byte	0x4
	.uleb128 .LBB22-.LBB19
	.uleb128 .LBE22-.LBB19
	.byte	0x4
	.uleb128 .LBB23-.LBB19
	.uleb128 .LBE23-.LBB19
	.byte	0x4
	.uleb128 .LBB24-.LBB19
	.uleb128 .LBE24-.LBB19
	.byte	0x4
	.uleb128 .LBB25-.LBB19
	.uleb128 .LBE25-.LBB19
	.byte	0x4
	.uleb128 .LBB26-.LBB19
	.uleb128 .LBE26-.LBB19
	.byte	0x4
	.uleb128 .LBB27-.LBB19
	.uleb128 .LBE27-.LBB19
	.byte	0x4
	.uleb128 .LBB28-.LBB19
	.uleb128 .LBE28-.LBB19
	.byte	0x4
	.uleb128 .LBB29-.LBB19
	.uleb128 .LBE29-.LBB19
	.byte	0
.LLRL24:
	.byte	0x5
	.quad	.LBB33
	.byte	0x4
	.uleb128 .LBB33-.LBB33
	.uleb128 .LBE33-.LBB33
	.byte	0x4
	.uleb128 .LBB36-.LBB33
	.uleb128 .LBE36-.LBB33
	.byte	0
.LLRL26:
	.byte	0x5
	.quad	.LBB34
	.byte	0x4
	.uleb128 .LBB34-.LBB34
	.uleb128 .LBE34-.LBB34
	.byte	0x4
	.uleb128 .LBB35-.LBB34
	.uleb128 .LBE35-.LBB34
	.byte	0
.LLRL28:
	.byte	0x7
	.quad	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.quad	.LFB52
	.uleb128 .LFE52-.LFB52
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
	.section	.debug_line_str,"dr"
.LASF1:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\0"
.LASF0:
	.ascii "C:\\Users\\agcum\\Documents\\Code\\Interp\\interp.c\0"
	.ident	"GCC: (Rev1, Built by MSYS2 project) 11.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	atof;	.scl	2;	.type	32;	.endef
	.def	strncmp;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fread;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
