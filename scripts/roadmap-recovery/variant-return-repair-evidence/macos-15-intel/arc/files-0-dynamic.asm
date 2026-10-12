/var/folders/20/jp1_0n3n7kndh6rnbqb5344m0000gn/T/fwp-arc-51629/files-0-dynamic-O2:
(__TEXT,__text) section
_fwp_ctx_swap:
00000001000006d0	pushq	%rbp
00000001000006d1	pushq	%rbx
00000001000006d2	pushq	%r12
00000001000006d4	pushq	%r13
00000001000006d6	pushq	%r14
00000001000006d8	pushq	%r15
00000001000006da	subq	$0x8, %rsp
00000001000006de	stmxcsr	(%rsp)
00000001000006e2	fnstcw	0x4(%rsp)
00000001000006e6	movq	%rsp, (%rdi)
00000001000006e9	movq	%rsi, %rsp
00000001000006ec	ldmxcsr	(%rsp)
00000001000006f0	fldcw	0x4(%rsp)
00000001000006f4	addq	$0x8, %rsp
00000001000006f8	popq	%r15
00000001000006fa	popq	%r14
00000001000006fc	popq	%r13
00000001000006fe	popq	%r12
0000000100000700	popq	%rbx
0000000100000701	popq	%rbp
0000000100000702	retq
0000000100000703	nopw	%cs:(%rax,%rax)
_main:
0000000100000710	pushq	%rbp
0000000100000711	movq	%rsp, %rbp
0000000100000714	pushq	%r14
0000000100000716	pushq	%rbx
0000000100000717	subq	$0x60, %rsp
000000010000071b	movq	0xa90e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100000722	movq	(%rax), %rax
0000000100000725	movq	%rax, -0x18(%rbp)
0000000100000729	leaq	_fwp_fn_table(%rip), %rax
0000000100000730	movq	%rax, _fwp_fns(%rip)
0000000100000737	movq	0xa902(%rip), %r14              ## literal pool symbol address: ___stdoutp
000000010000073e	movq	(%r14), %rax
0000000100000741	movq	%rax, _fwp_prog_out(%rip)
0000000100000748	movq	%rsi, _fwp_argv(%rip)
000000010000074f	leaq	_fwp_start_time(%rip), %rsi
0000000100000756	movl	$0x6, %edi
000000010000075b	callq	0x100009788                     ## symbol stub for: _clock_gettime
0000000100000760	leaq	0x9667(%rip), %rdi              ## literal pool for: "FWP_SEED"
0000000100000767	callq	0x1000097ca                     ## symbol stub for: _getenv
000000010000076c	testq	%rax, %rax
000000010000076f	je	0x100000797
0000000100000771	movq	%rax, %rbx
0000000100000774	cmpb	$0x0, (%rax)
0000000100000777	je	0x100000797
0000000100000779	leaq	-0x68(%rbp), %rsi
000000010000077d	movq	%rbx, %rdi
0000000100000780	movl	$0xa, %edx
0000000100000785	callq	0x100009878                     ## symbol stub for: _strtoull
000000010000078a	movq	-0x68(%rbp), %rax
000000010000078e	cmpb	$0x0, (%rax)
0000000100000791	je	0x100000860
0000000100000797	leaq	-0x58(%rbp), %rsi
000000010000079b	xorl	%edi, %edi
000000010000079d	callq	0x100009788                     ## symbol stub for: _clock_gettime
00000001000007a2	movq	(%r14), %rdi
00000001000007a5	movl	$0x10000, %ecx                  ## imm = 0x10000
00000001000007aa	xorl	%esi, %esi
00000001000007ac	xorl	%edx, %edx
00000001000007ae	callq	0x10000982a                     ## symbol stub for: _setvbuf
00000001000007b3	movl	$0x1, %esi
00000001000007b8	movl	$0xd, %edi
00000001000007bd	callq	0x10000983c                     ## symbol stub for: _signal
00000001000007c2	leaq	-0x58(%rbp), %rbx
00000001000007c6	movq	%rbx, %rdi
00000001000007c9	callq	0x100009806                     ## symbol stub for: _pthread_attr_init
00000001000007ce	movq	_fwp_main_stack(%rip), %rsi
00000001000007d5	movq	%rbx, %rdi
00000001000007d8	callq	0x10000980c                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007dd	leaq	_fwp_main_thread(%rip), %rdx
00000001000007e4	leaq	-0x70(%rbp), %rdi
00000001000007e8	movq	%rbx, %rsi
00000001000007eb	xorl	%ecx, %ecx
00000001000007ed	callq	0x100009812                     ## symbol stub for: _pthread_create
00000001000007f2	testl	%eax, %eax
00000001000007f4	je	0x100000832
00000001000007f6	leaq	-0x68(%rbp), %rsi
00000001000007fa	movl	$0x3, %edi
00000001000007ff	callq	0x1000097d0                     ## symbol stub for: _getrlimit
0000000100000804	movq	-0x68(%rbp), %rcx
0000000100000808	movabsq	$0x7fffffffffffffff, %rdx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100000812	cmpq	%rdx, %rcx
0000000100000815	movl	$0x800000, %edx                 ## imm = 0x800000
000000010000081a	cmoveq	%rdx, %rcx
000000010000081e	testl	%eax, %eax
0000000100000820	cmovneq	%rdx, %rcx
0000000100000824	movq	%rcx, _fwp_main_stack(%rip)
000000010000082b	callq	_fwp_main_thread
0000000100000830	jmp	0x10000083d
0000000100000832	movq	-0x70(%rbp), %rdi
0000000100000836	xorl	%esi, %esi
0000000100000838	callq	0x100009818                     ## symbol stub for: _pthread_join
000000010000083d	movq	(%r14), %rdi
0000000100000840	callq	0x1000097a0                     ## symbol stub for: _fflush
0000000100000845	movq	0xa7e4(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000084c	movq	(%rax), %rax
000000010000084f	cmpq	-0x18(%rbp), %rax
0000000100000853	jne	0x10000087a
0000000100000855	xorl	%eax, %eax
0000000100000857	addq	$0x60, %rsp
000000010000085b	popq	%rbx
000000010000085c	popq	%r14
000000010000085e	popq	%rbp
000000010000085f	retq
0000000100000860	movzbl	(%rbx), %eax
0000000100000863	cmpl	$0x2d, %eax
0000000100000866	je	0x100000797
000000010000086c	cmpl	$0x2b, %eax
000000010000086f	je	0x100000797
0000000100000875	jmp	0x1000007a2
000000010000087a	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
000000010000087f	nop
_fwp_main_thread:
0000000100000880	pushq	%rbp
0000000100000881	movq	%rsp, %rbp
0000000100000884	pushq	%r15
0000000100000886	pushq	%r14
0000000100000888	pushq	%r13
000000010000088a	pushq	%r12
000000010000088c	pushq	%rbx
000000010000088d	subq	$0x148, %rsp                    ## imm = 0x148
0000000100000894	movq	0xa795(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000089b	movq	(%rax), %rax
000000010000089e	movq	%rax, -0x30(%rbp)
00000001000008a2	cmpl	$0x0, 0xc74b(%rip)
00000001000008a9	jne	0x1000008b0
00000001000008ab	callq	_fwp_gc_init
00000001000008b0	movq	%rbp, 0xc7d9(%rip)
00000001000008b7	callq	0x100009764                     ## symbol stub for: __dyld_image_count
00000001000008bc	testl	%eax, %eax
00000001000008be	je	0x1000009c4
00000001000008c4	xorl	%ebx, %ebx
00000001000008c6	leaq	_fwp_gc(%rip), %r14
00000001000008cd	movl	$0x1, %r15d
00000001000008d3	jmp	0x1000008ef
00000001000008d5	testl	%esi, %esi
00000001000008d7	jne	0x10000095d
00000001000008dd	nopl	(%rax)
00000001000008e0	incl	%ebx
00000001000008e2	callq	0x100009764                     ## symbol stub for: __dyld_image_count
00000001000008e7	cmpl	%eax, %ebx
00000001000008e9	jae	0x1000009c4
00000001000008ef	movl	%ebx, %edi
00000001000008f1	callq	0x100009758                     ## symbol stub for: __dyld_get_image_header
00000001000008f6	testq	%rax, %rax
00000001000008f9	je	0x1000008e0
00000001000008fb	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
0000000100000901	jne	0x1000008e0
0000000100000903	movl	%ebx, %edi
0000000100000905	movq	%rax, %r12
0000000100000908	callq	0x10000975e                     ## symbol stub for: __dyld_get_image_vmaddr_slide
000000010000090d	movl	0x10(%r12), %edx
0000000100000912	testl	%edx, %edx
0000000100000914	je	0x1000008e0
0000000100000916	movq	%r12, %rcx
0000000100000919	addq	$0x20, %rcx
000000010000091d	xorl	%esi, %esi
000000010000091f	movl	%edx, %edi
0000000100000921	movq	%rcx, %r8
0000000100000924	jmp	0x10000093b
0000000100000926	nopw	%cs:(%rax,%rax)
0000000100000930	movl	0x4(%r8), %r9d
0000000100000934	addq	%r9, %r8
0000000100000937	decl	%edi
0000000100000939	je	0x1000008d5
000000010000093b	cmpl	$0x19, (%r8)
000000010000093f	jne	0x100000930
0000000100000941	movq	0x18(%r8), %r9
0000000100000945	addq	%rax, %r9
0000000100000948	cmpq	%r14, %r9
000000010000094b	ja	0x100000930
000000010000094d	movq	%r14, %r10
0000000100000950	subq	%r9, %r10
0000000100000953	cmpq	0x20(%r8), %r10
0000000100000957	cmovbl	%r15d, %esi
000000010000095b	jmp	0x100000930
000000010000095d	movl	0xc835(%rip), %esi
0000000100000963	jmp	0x10000097a
0000000100000965	nopw	%cs:(%rax,%rax)
0000000100000970	movl	0x4(%rcx), %edi
0000000100000973	addq	%rdi, %rcx
0000000100000976	decl	%edx
0000000100000978	je	0x1000009c4
000000010000097a	cmpl	$0x19, (%rcx)
000000010000097d	jne	0x100000970
000000010000097f	movl	0x3c(%rcx), %edi
0000000100000982	notl	%edi
0000000100000984	testb	$0x3, %dil
0000000100000988	jne	0x100000970
000000010000098a	movq	0x20(%rcx), %rdi
000000010000098e	testq	%rdi, %rdi
0000000100000991	je	0x100000970
0000000100000993	cmpl	$0x10, %esi
0000000100000996	je	0x1000012d0
000000010000099c	movq	0x18(%rcx), %r8
00000001000009a0	addq	%rax, %r8
00000001000009a3	movslq	%esi, %r9
00000001000009a6	shlq	$0x4, %r9
00000001000009aa	movq	%r8, 0x1090(%r9,%r14)
00000001000009b2	incl	%esi
00000001000009b4	movl	%esi, 0xc7de(%rip)
00000001000009ba	movq	%rdi, 0x1098(%r9,%r14)
00000001000009c2	jmp	0x100000970
00000001000009c4	cmpl	$0x0, 0xc62d(%rip)
00000001000009cb	setne	%cl
00000001000009ce	cmpl	$0x0, 0xc7c3(%rip)
00000001000009d5	setg	%al
00000001000009d8	andb	%cl, %al
00000001000009da	movzbl	%al, %ecx
00000001000009dd	movl	%ecx, 0xc619(%rip)
00000001000009e3	cmpl	$0x0, 0xc61a(%rip)
00000001000009ea	je	0x100000a02
00000001000009ec	leaq	_fwp_gc_report(%rip), %rdi
00000001000009f3	callq	0x100009776                     ## symbol stub for: _atexit
00000001000009f8	cmpl	$0x0, 0xc5fd(%rip)
00000001000009ff	setne	%al
0000000100000a02	testb	%al, %al
0000000100000a04	je	0x100000a49
0000000100000a06	cmpq	$0x0, 0xc61a(%rip)
0000000100000a0e	je	0x100000a49
0000000100000a10	movq	0xc801(%rip), %rax
0000000100000a17	subq	_fwp_gc(%rip), %rax
0000000100000a1e	cvtsi2sd	%rax, %xmm0
0000000100000a23	addsd	0xc7c5(%rip), %xmm0
0000000100000a2b	movsd	%xmm0, 0xc7bd(%rip)
0000000100000a33	movq	$0x0, 0xc7da(%rip)
0000000100000a3e	movq	$0x0, _fwp_gc(%rip)
0000000100000a49	movq	_fwp_main_stack(%rip), %rax
0000000100000a50	leaq	-0x170(%rbp), %r13
0000000100000a57	movq	%r13, _fwp_main_stack_top(%rip)
0000000100000a5e	movq	%rax, _fwp_main_stack_size(%rip)
0000000100000a65	leaq	_fwp_stack_guard_init.alt(%rip), %rax
0000000100000a6c	movq	%rax, -0xa0(%rbp)
0000000100000a73	movq	$0x10000, -0x98(%rbp)           ## imm = 0x10000
0000000100000a7e	movl	$0x0, -0x90(%rbp)
0000000100000a88	leaq	-0xa0(%rbp), %r14
0000000100000a8f	movq	%r14, %rdi
0000000100000a92	xorl	%esi, %esi
0000000100000a94	callq	0x100009836                     ## symbol stub for: _sigaltstack
0000000100000a99	testl	%eax, %eax
0000000100000a9b	jne	0x100000ade
0000000100000a9d	leaq	_fwp_segv(%rip), %rax
0000000100000aa4	movq	%rax, -0x88(%rbp)
0000000100000aab	movabsq	$0x4100000000, %rax             ## imm = 0x4100000000
0000000100000ab5	movq	%rax, -0x80(%rbp)
0000000100000ab9	leaq	-0x88(%rbp), %rbx
0000000100000ac0	movl	$0xb, %edi
0000000100000ac5	movq	%rbx, %rsi
0000000100000ac8	xorl	%edx, %edx
0000000100000aca	callq	0x100009830                     ## symbol stub for: _sigaction
0000000100000acf	movl	$0xa, %edi
0000000100000ad4	movq	%rbx, %rsi
0000000100000ad7	xorl	%edx, %edx
0000000100000ad9	callq	0x100009830                     ## symbol stub for: _sigaction
0000000100000ade	movq	_fwp_gc(%rip), %rbx
0000000100000ae5	cmpb	$0x0, _caf0.st(%rip)
0000000100000aec	movq	%rbx, %rax
0000000100000aef	jne	0x10000122a
0000000100000af5	leaq	_fc3(%rip), %rax
0000000100000afc	movq	%rax, -0x40(%rbp)
0000000100000b00	leaq	_fc4(%rip), %rax
0000000100000b07	movq	%rax, -0x38(%rbp)
0000000100000b0b	leaq	_fc2(%rip), %rdi
0000000100000b12	leaq	-0x40(%rbp), %rdx
0000000100000b16	movl	$0x2, %esi
0000000100000b1b	callq	_fwp_apply_owned
0000000100000b20	movq	%rax, %r12
0000000100000b23	movq	%rax, -0xe0(%rbp)
0000000100000b2a	movq	_fwp_cleanups(%rip), %rax
0000000100000b31	movq	%rax, -0xa0(%rbp)
0000000100000b38	leaq	_fwp_owner_release0(%rip), %rax
0000000100000b3f	movq	%rax, -0x98(%rbp)
0000000100000b46	leaq	-0xe0(%rbp), %rax
0000000100000b4d	movq	%rax, -0x90(%rbp)
0000000100000b54	movq	%r14, _fwp_cleanups(%rip)
0000000100000b5b	leaq	_s0(%rip), %rsi
0000000100000b62	movq	%r12, %rdi
0000000100000b65	callq	_fwp_p_attempt_owned
0000000100000b6a	cmpq	%r14, _fwp_cleanups(%rip)
0000000100000b71	jne	0x10000129e
0000000100000b77	movq	%rax, %r15
0000000100000b7a	movq	-0xa0(%rbp), %rax
0000000100000b81	movq	%rax, _fwp_cleanups(%rip)
0000000100000b88	leaq	_s0(%rip), %rax
0000000100000b8f	movq	%r12, %rdi
0000000100000b92	callq	_fwp_closure_drop
0000000100000b97	movq	%r15, -0xd8(%rbp)
0000000100000b9e	movq	_fwp_cleanups(%rip), %rax
0000000100000ba5	movq	%rax, -0x88(%rbp)
0000000100000bac	leaq	_fwp_owner_release1(%rip), %rax
0000000100000bb3	movq	%rax, -0x80(%rbp)
0000000100000bb7	leaq	-0xd8(%rbp), %rax
0000000100000bbe	movq	%rax, -0x78(%rbp)
0000000100000bc2	leaq	-0x88(%rbp), %r12
0000000100000bc9	movq	%r12, _fwp_cleanups(%rip)
0000000100000bd0	movq	%r15, %rdi
0000000100000bd3	callq	_f8
0000000100000bd8	cmpq	%r12, _fwp_cleanups(%rip)
0000000100000bdf	jne	0x10000129e
0000000100000be5	movq	%rax, %r14
0000000100000be8	movq	-0x88(%rbp), %rax
0000000100000bef	movq	%rax, _fwp_cleanups(%rip)
0000000100000bf6	movq	%r15, %rdi
0000000100000bf9	callq	_fwp_drop1
0000000100000bfe	movq	%r14, -0xd0(%rbp)
0000000100000c05	movq	_fwp_cleanups(%rip), %rax
0000000100000c0c	movq	%rax, -0x170(%rbp)
0000000100000c13	leaq	_fwp_owner_release2(%rip), %rax
0000000100000c1a	movq	%rax, -0x168(%rbp)
0000000100000c21	leaq	-0xd0(%rbp), %rax
0000000100000c28	movq	%rax, -0x160(%rbp)
0000000100000c2f	movq	%r13, _fwp_cleanups(%rip)
0000000100000c36	movq	%r14, %rdi
0000000100000c39	addq	$0x8, %rdi
0000000100000c3d	movq	(%r14), %rdx
0000000100000c40	movq	_fwp_prog_out(%rip), %rcx
0000000100000c47	movl	$0x1, %esi
0000000100000c4c	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100000c51	movq	_fwp_prog_out(%rip), %rsi
0000000100000c58	movl	$0xa, %edi
0000000100000c5d	callq	0x1000097b2                     ## symbol stub for: _fputc
0000000100000c62	cmpq	%r13, _fwp_cleanups(%rip)
0000000100000c69	jne	0x10000129e
0000000100000c6f	movq	-0x170(%rbp), %rax
0000000100000c76	movq	%rax, _fwp_cleanups(%rip)
0000000100000c7d	movq	%r14, %rax
0000000100000c80	subq	0xc3b1(%rip), %rax
0000000100000c87	movq	0xc3d2(%rip), %rcx
0000000100000c8e	shlq	$0x10, %rcx
0000000100000c92	cmpq	%rcx, %rax
0000000100000c95	jae	0x100000d11
0000000100000c97	movq	0xc3e2(%rip), %rcx
0000000100000c9e	movq	%rax, %rdx
0000000100000ca1	shrq	$0x10, %rdx
0000000100000ca5	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100000cac	leaq	(%rcx,%rdx), %rdi
0000000100000cb0	movzbl	(%rcx,%rdx), %ecx
0000000100000cb4	cmpb	$0x2, %cl
0000000100000cb7	setne	%dl
0000000100000cba	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100000cc0	setne	%sil
0000000100000cc4	orb	%dl, %sil
0000000100000cc7	jne	0x100000cd2
0000000100000cc9	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000cd0	jmp	0x100000cec
0000000100000cd2	cmpb	$0x1, %cl
0000000100000cd5	jne	0x100000d11
0000000100000cd7	movl	0x20(%rdi), %ecx
0000000100000cda	imulq	%rcx, %rax
0000000100000cde	shrq	$0x20, %rax
0000000100000ce2	addq	%rax, %rdi
0000000100000ce5	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000cec	movzbl	(%rdi), %eax
0000000100000cef	testl	%eax, %eax
0000000100000cf1	je	0x100000d11
0000000100000cf3	cmpl	$0x1, %eax
0000000100000cf6	jne	0x100000d02
0000000100000cf8	movq	%r14, %rdi
0000000100000cfb	callq	_fwp_rc_free_obj
0000000100000d00	jmp	0x100000d11
0000000100000d02	cmpl	$0xff, %eax
0000000100000d07	je	0x10000128a
0000000100000d0d	decb	%al
0000000100000d0f	movb	%al, (%rdi)
0000000100000d11	leaq	_fc3(%rip), %rax
0000000100000d18	movq	%rax, -0x50(%rbp)
0000000100000d1c	leaq	_fc4(%rip), %rax
0000000100000d23	movq	%rax, -0x48(%rbp)
0000000100000d27	leaq	_fc2(%rip), %rdi
0000000100000d2e	leaq	-0x50(%rbp), %rdx
0000000100000d32	movl	$0x2, %esi
0000000100000d37	callq	_fwp_apply_owned
0000000100000d3c	movq	%rax, %r14
0000000100000d3f	movq	%rax, -0xc8(%rbp)
0000000100000d46	movq	_fwp_cleanups(%rip), %rax
0000000100000d4d	movq	%rax, -0x158(%rbp)
0000000100000d54	leaq	_fwp_owner_release3(%rip), %rax
0000000100000d5b	movq	%rax, -0x150(%rbp)
0000000100000d62	leaq	-0xc8(%rbp), %rax
0000000100000d69	movq	%rax, -0x148(%rbp)
0000000100000d70	leaq	-0x158(%rbp), %r12
0000000100000d77	movq	%r12, _fwp_cleanups(%rip)
0000000100000d7e	leaq	_s1(%rip), %rsi
0000000100000d85	movq	%r14, %rdi
0000000100000d88	callq	_fwp_p_attempt_owned
0000000100000d8d	cmpq	%r12, _fwp_cleanups(%rip)
0000000100000d94	jne	0x10000129e
0000000100000d9a	movq	%rax, %r15
0000000100000d9d	movq	-0x158(%rbp), %rax
0000000100000da4	movq	%rax, _fwp_cleanups(%rip)
0000000100000dab	leaq	_s1(%rip), %rax
0000000100000db2	movq	%r14, %rdi
0000000100000db5	callq	_fwp_closure_drop
0000000100000dba	movq	%r15, -0xc0(%rbp)
0000000100000dc1	movq	_fwp_cleanups(%rip), %rax
0000000100000dc8	movq	%rax, -0x140(%rbp)
0000000100000dcf	leaq	_fwp_owner_release4(%rip), %rax
0000000100000dd6	movq	%rax, -0x138(%rbp)
0000000100000ddd	leaq	-0xc0(%rbp), %rax
0000000100000de4	movq	%rax, -0x130(%rbp)
0000000100000deb	leaq	-0x140(%rbp), %r12
0000000100000df2	movq	%r12, _fwp_cleanups(%rip)
0000000100000df9	movq	%r15, %rdi
0000000100000dfc	callq	_f8
0000000100000e01	cmpq	%r12, _fwp_cleanups(%rip)
0000000100000e08	jne	0x10000129e
0000000100000e0e	movq	%rax, %r14
0000000100000e11	movq	-0x140(%rbp), %rax
0000000100000e18	movq	%rax, _fwp_cleanups(%rip)
0000000100000e1f	movq	%r15, %rdi
0000000100000e22	callq	_fwp_drop1
0000000100000e27	movq	%r14, -0xb8(%rbp)
0000000100000e2e	movq	_fwp_cleanups(%rip), %rax
0000000100000e35	movq	%rax, -0x128(%rbp)
0000000100000e3c	leaq	_fwp_owner_release5(%rip), %rax
0000000100000e43	movq	%rax, -0x120(%rbp)
0000000100000e4a	leaq	-0xb8(%rbp), %rax
0000000100000e51	movq	%rax, -0x118(%rbp)
0000000100000e58	leaq	-0x128(%rbp), %r15
0000000100000e5f	movq	%r15, _fwp_cleanups(%rip)
0000000100000e66	movq	%r14, %rdi
0000000100000e69	addq	$0x8, %rdi
0000000100000e6d	movq	(%r14), %rdx
0000000100000e70	movq	_fwp_prog_out(%rip), %rcx
0000000100000e77	movl	$0x1, %esi
0000000100000e7c	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100000e81	movq	_fwp_prog_out(%rip), %rsi
0000000100000e88	movl	$0xa, %edi
0000000100000e8d	callq	0x1000097b2                     ## symbol stub for: _fputc
0000000100000e92	cmpq	%r15, _fwp_cleanups(%rip)
0000000100000e99	jne	0x10000129e
0000000100000e9f	movq	-0x128(%rbp), %rax
0000000100000ea6	movq	%rax, _fwp_cleanups(%rip)
0000000100000ead	movq	%r14, %rax
0000000100000eb0	subq	0xc181(%rip), %rax
0000000100000eb7	movq	0xc1a2(%rip), %rcx
0000000100000ebe	shlq	$0x10, %rcx
0000000100000ec2	cmpq	%rcx, %rax
0000000100000ec5	jae	0x100000f41
0000000100000ec7	movq	0xc1b2(%rip), %rcx
0000000100000ece	movq	%rax, %rdx
0000000100000ed1	shrq	$0x10, %rdx
0000000100000ed5	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100000edc	leaq	(%rcx,%rdx), %rdi
0000000100000ee0	movzbl	(%rcx,%rdx), %ecx
0000000100000ee4	cmpb	$0x2, %cl
0000000100000ee7	setne	%dl
0000000100000eea	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100000ef0	setne	%sil
0000000100000ef4	orb	%dl, %sil
0000000100000ef7	jne	0x100000f02
0000000100000ef9	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000f00	jmp	0x100000f1c
0000000100000f02	cmpb	$0x1, %cl
0000000100000f05	jne	0x100000f41
0000000100000f07	movl	0x20(%rdi), %ecx
0000000100000f0a	imulq	%rcx, %rax
0000000100000f0e	shrq	$0x20, %rax
0000000100000f12	addq	%rax, %rdi
0000000100000f15	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000f1c	movzbl	(%rdi), %eax
0000000100000f1f	testl	%eax, %eax
0000000100000f21	je	0x100000f41
0000000100000f23	cmpl	$0x1, %eax
0000000100000f26	jne	0x100000f32
0000000100000f28	movq	%r14, %rdi
0000000100000f2b	callq	_fwp_rc_free_obj
0000000100000f30	jmp	0x100000f41
0000000100000f32	cmpl	$0xff, %eax
0000000100000f37	je	0x100001294
0000000100000f3d	decb	%al
0000000100000f3f	movb	%al, (%rdi)
0000000100000f41	movq	$0x0, -0xb0(%rbp)
0000000100000f4c	movq	_fwp_cleanups(%rip), %rax
0000000100000f53	movq	%rax, -0x110(%rbp)
0000000100000f5a	leaq	_fwp_owner_release6(%rip), %rax
0000000100000f61	movq	%rax, -0x108(%rbp)
0000000100000f68	leaq	-0xb0(%rbp), %rax
0000000100000f6f	movq	%rax, -0x100(%rbp)
0000000100000f76	leaq	-0x110(%rbp), %r13
0000000100000f7d	movq	%r13, _fwp_cleanups(%rip)
0000000100000f84	xorpd	%xmm0, %xmm0
0000000100000f88	movapd	%xmm0, -0x60(%rbp)
0000000100000f8d	movl	$0x18, %edi
0000000100000f92	callq	_fwp_alloc_init
0000000100000f97	movq	%rax, %r14
0000000100000f9a	movabsq	$0x200000001, %r12              ## imm = 0x200000001
0000000100000fa4	movq	%r12, (%rax)
0000000100000fa7	xorpd	%xmm0, %xmm0
0000000100000fab	movupd	%xmm0, 0x8(%rax)
0000000100000fb0	leaq	-0x60(%rbp), %rax
0000000100000fb4	movq	%r14, %rax
0000000100000fb7	subq	0xc07a(%rip), %rax
0000000100000fbe	movq	0xc09b(%rip), %rcx
0000000100000fc5	shlq	$0x10, %rcx
0000000100000fc9	cmpq	%rcx, %rax
0000000100000fcc	jae	0x10000103e
0000000100000fce	movq	0xc0ab(%rip), %rcx
0000000100000fd5	movq	%rax, %rdx
0000000100000fd8	shrq	$0x10, %rdx
0000000100000fdc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100000fe3	leaq	(%rcx,%rdx), %r15
0000000100000fe7	movzbl	(%rcx,%rdx), %ecx
0000000100000feb	cmpb	$0x2, %cl
0000000100000fee	setne	%dl
0000000100000ff1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100000ff7	setne	%sil
0000000100000ffb	orb	%dl, %sil
0000000100000ffe	jne	0x100001013
0000000100001000	addq	$0x228, %r15                    ## imm = 0x228
0000000100001007	cmpb	$-0x1, (%r15)
000000010000100b	je	0x100001034
000000010000100d	movb	$0x1, (%r15)
0000000100001011	jmp	0x10000103e
0000000100001013	cmpb	$0x1, %cl
0000000100001016	jne	0x10000103e
0000000100001018	movl	0x20(%r15), %ecx
000000010000101c	imulq	%rcx, %rax
0000000100001020	shrq	$0x20, %rax
0000000100001024	addq	%rax, %r15
0000000100001027	addq	$0x228, %r15                    ## imm = 0x228
000000010000102e	cmpb	$-0x1, (%r15)
0000000100001032	jne	0x10000100d
0000000100001034	movq	%r15, %rdi
0000000100001037	callq	_fwp_rc_forget_slot
000000010000103c	jmp	0x10000100d
000000010000103e	cmpq	%r13, _fwp_cleanups(%rip)
0000000100001045	jne	0x10000129e
000000010000104b	movq	-0x110(%rbp), %rax
0000000100001052	movq	%r14, -0xa8(%rbp)
0000000100001059	movq	%rax, -0xf8(%rbp)
0000000100001060	leaq	_fwp_owner_release7(%rip), %rax
0000000100001067	movq	%rax, -0xf0(%rbp)
000000010000106e	leaq	-0xa8(%rbp), %rax
0000000100001075	movq	%rax, -0xe8(%rbp)
000000010000107c	leaq	-0xf8(%rbp), %r15
0000000100001083	movq	%r15, _fwp_cleanups(%rip)
000000010000108a	movq	$0x0, -0x70(%rbp)
0000000100001092	movq	%r14, -0x68(%rbp)
0000000100001096	movl	$0x18, %edi
000000010000109b	callq	_fwp_alloc_init
00000001000010a0	movq	%r12, (%rax)
00000001000010a3	movq	$0x0, 0x8(%rax)
00000001000010ab	movq	%r14, 0x10(%rax)
00000001000010af	leaq	-0x70(%rbp), %rcx
00000001000010b3	movq	%rax, %rcx
00000001000010b6	subq	0xbf7b(%rip), %rcx
00000001000010bd	movq	0xbf9c(%rip), %rdx
00000001000010c4	shlq	$0x10, %rdx
00000001000010c8	cmpq	%rdx, %rcx
00000001000010cb	jae	0x100001145
00000001000010cd	movq	0xbfac(%rip), %rdx
00000001000010d4	movq	%rcx, %rsi
00000001000010d7	shrq	$0x10, %rsi
00000001000010db	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
00000001000010e2	leaq	(%rdx,%rsi), %r14
00000001000010e6	movzbl	(%rdx,%rsi), %edx
00000001000010ea	cmpb	$0x2, %dl
00000001000010ed	setne	%sil
00000001000010f1	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000010f8	setne	%dil
00000001000010fc	orb	%sil, %dil
00000001000010ff	jne	0x100001114
0000000100001101	addq	$0x228, %r14                    ## imm = 0x228
0000000100001108	cmpb	$-0x1, (%r14)
000000010000110c	je	0x100001135
000000010000110e	movb	$0x1, (%r14)
0000000100001112	jmp	0x100001145
0000000100001114	cmpb	$0x1, %dl
0000000100001117	jne	0x100001145
0000000100001119	movl	0x20(%r14), %edx
000000010000111d	imulq	%rdx, %rcx
0000000100001121	shrq	$0x20, %rcx
0000000100001125	addq	%rcx, %r14
0000000100001128	addq	$0x228, %r14                    ## imm = 0x228
000000010000112f	cmpb	$-0x1, (%r14)
0000000100001133	jne	0x10000110e
0000000100001135	movq	%r14, %rdi
0000000100001138	movq	%rax, %r12
000000010000113b	callq	_fwp_rc_forget_slot
0000000100001140	movq	%r12, %rax
0000000100001143	jmp	0x10000110e
0000000100001145	cmpq	%r15, _fwp_cleanups(%rip)
000000010000114c	jne	0x10000129e
0000000100001152	movq	-0xf8(%rbp), %rdx
0000000100001159	movq	%rax, %rcx
000000010000115c	subq	0xbed5(%rip), %rcx
0000000100001163	movq	%rdx, _fwp_cleanups(%rip)
000000010000116a	movq	0xbeef(%rip), %rdx
0000000100001171	shlq	$0x10, %rdx
0000000100001175	cmpq	%rdx, %rcx
0000000100001178	jae	0x10000121c
000000010000117e	movq	0xbefb(%rip), %rdx
0000000100001185	movq	%rcx, %rsi
0000000100001188	shrq	$0x10, %rsi
000000010000118c	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100001193	leaq	(%rdx,%rsi), %rdi
0000000100001197	movzbl	(%rdx,%rsi), %edx
000000010000119b	cmpb	$0x2, %dl
000000010000119e	setne	%sil
00000001000011a2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000011a9	setne	%r8b
00000001000011ad	orb	%sil, %r8b
00000001000011b0	jne	0x1000011bb
00000001000011b2	addq	$0x228, %rdi                    ## imm = 0x228
00000001000011b9	jmp	0x1000011d5
00000001000011bb	cmpb	$0x1, %dl
00000001000011be	jne	0x10000121c
00000001000011c0	movl	0x20(%rdi), %edx
00000001000011c3	imulq	%rdx, %rcx
00000001000011c7	shrq	$0x20, %rcx
00000001000011cb	addq	%rcx, %rdi
00000001000011ce	addq	$0x228, %rdi                    ## imm = 0x228
00000001000011d5	movzbl	(%rdi), %ecx
00000001000011d8	testl	%ecx, %ecx
00000001000011da	je	0x10000121c
00000001000011dc	cmpl	$0x1, %ecx
00000001000011df	jne	0x100001210
00000001000011e1	movq	0x10(%rax), %r14
00000001000011e5	movq	%rax, %rdi
00000001000011e8	callq	_fwp_rc_free_obj
00000001000011ed	movq	%r14, %rcx
00000001000011f0	subq	0xbe41(%rip), %rcx
00000001000011f7	movq	0xbe62(%rip), %rdx
00000001000011fe	shlq	$0x10, %rdx
0000000100001202	movq	%r14, %rax
0000000100001205	cmpq	%rdx, %rcx
0000000100001208	jb	0x10000117e
000000010000120e	jmp	0x10000121c
0000000100001210	cmpl	$0xff, %ecx
0000000100001216	je	0x100001283
0000000100001218	decb	%cl
000000010000121a	movb	%cl, (%rdi)
000000010000121c	movb	$0x1, _caf0.st(%rip)
0000000100001223	movq	_fwp_gc(%rip), %rax
000000010000122a	cmpq	$0x0, 0xbfae(%rip)
0000000100001232	jne	0x1000012a3
0000000100001234	cmpl	$0x0, 0xbdbd(%rip)
000000010000123b	jne	0x1000012a3
000000010000123d	cmpq	%rax, %rbx
0000000100001240	jg	0x1000012a3
0000000100001242	xorpd	%xmm0, %xmm0
0000000100001246	ucomisd	0xbfc2(%rip), %xmm0
000000010000124e	jae	0x1000012a3
0000000100001250	movq	0x9de9(%rip), %rax              ## literal pool symbol address: ___stdoutp
0000000100001257	movq	(%rax), %rdi
000000010000125a	callq	0x1000097a0                     ## symbol stub for: _fflush
000000010000125f	movq	0x9dca(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100001266	movq	(%rax), %rax
0000000100001269	cmpq	-0x30(%rbp), %rax
000000010000126d	jne	0x1000012cb
000000010000126f	xorl	%eax, %eax
0000000100001271	addq	$0x148, %rsp                    ## imm = 0x148
0000000100001278	popq	%rbx
0000000100001279	popq	%r12
000000010000127b	popq	%r13
000000010000127d	popq	%r14
000000010000127f	popq	%r15
0000000100001281	popq	%rbp
0000000100001282	retq
0000000100001283	callq	_fwp_rc_wide_drop
0000000100001288	jmp	0x10000121c
000000010000128a	callq	_fwp_rc_wide_drop
000000010000128f	jmp	0x100000d11
0000000100001294	callq	_fwp_rc_wide_drop
0000000100001299	jmp	0x100000f41
000000010000129e	callq	0x100009770                     ## symbol stub for: _abort
00000001000012a3	movq	0x9d8e(%rip), %rcx              ## literal pool symbol address: ___stderrp
00000001000012aa	movq	(%rcx), %rdi
00000001000012ad	subq	%rax, %rbx
00000001000012b0	leaq	0x8b20(%rip), %rsi              ## literal pool for: "ARC unreclaimed bytes: %ld\n"
00000001000012b7	movq	%rbx, %rdx
00000001000012ba	xorl	%eax, %eax
00000001000012bc	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000012c1	movl	$0xc1, %edi
00000001000012c6	callq	0x10000978e                     ## symbol stub for: _exit
00000001000012cb	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
00000001000012d0	callq	_fwp_flush
00000001000012d5	movq	0x9d5c(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000012dc	movq	(%rax), %rdi
00000001000012df	leaq	0x87be(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000012e6	leaq	0x8b06(%rip), %rdx              ## literal pool for: "too many program data segments for the collector"
00000001000012ed	xorl	%eax, %eax
00000001000012ef	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000012f4	movl	$0x65, %edi
00000001000012f9	callq	0x10000978e                     ## symbol stub for: _exit
00000001000012fe	nop
_e1:
0000000100001300	pushq	%rbp
0000000100001301	movq	%rsp, %rbp
0000000100001304	movq	%rdi, %rax
0000000100001307	movq	(%rdi), %rdi
000000010000130a	movq	0xbd27(%rip), %rcx
0000000100001311	movq	%rdi, %rsi
0000000100001314	subq	%rcx, %rsi
0000000100001317	movq	0xbd42(%rip), %rdx
000000010000131e	shlq	$0x10, %rdx
0000000100001322	cmpq	%rdx, %rsi
0000000100001325	jae	0x100001395
0000000100001327	movq	0xbd52(%rip), %r9
000000010000132e	movq	%rsi, %r8
0000000100001331	shrq	$0x10, %r8
0000000100001335	imulq	$0x1228, %r8, %r10              ## imm = 0x1228
000000010000133c	leaq	(%r9,%r10), %r8
0000000100001340	movzbl	(%r9,%r10), %r9d
0000000100001345	cmpb	$0x2, %r9b
0000000100001349	setne	%r10b
000000010000134d	andq	$0xffff, %rsi                   ## imm = 0xFFFF
0000000100001354	setne	%r11b
0000000100001358	orb	%r10b, %r11b
000000010000135b	jne	0x10000136f
000000010000135d	addq	$0x228, %r8                     ## imm = 0x228
0000000100001364	cmpb	$0x0, (%r8)
0000000100001368	je	0x100001395
000000010000136a	jmp	0x100001490
000000010000136f	cmpb	$0x1, %r9b
0000000100001373	jne	0x100001395
0000000100001375	movl	0x20(%r8), %r9d
0000000100001379	imulq	%r9, %rsi
000000010000137d	shrq	$0x20, %rsi
0000000100001381	addq	%rsi, %r8
0000000100001384	addq	$0x228, %r8                     ## imm = 0x228
000000010000138b	cmpb	$0x0, (%r8)
000000010000138f	jne	0x100001490
0000000100001395	movq	0x8(%rax), %rsi
0000000100001399	movq	%rsi, %rax
000000010000139c	subq	%rcx, %rax
000000010000139f	cmpq	%rdx, %rax
00000001000013a2	jae	0x10000140c
00000001000013a4	movq	0xbcd5(%rip), %rdx
00000001000013ab	movq	%rax, %rcx
00000001000013ae	shrq	$0x10, %rcx
00000001000013b2	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
00000001000013b9	leaq	(%rdx,%r8), %rcx
00000001000013bd	movzbl	(%rdx,%r8), %edx
00000001000013c2	cmpb	$0x2, %dl
00000001000013c5	setne	%r8b
00000001000013c9	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000013cf	setne	%r9b
00000001000013d3	orb	%r8b, %r9b
00000001000013d6	jne	0x1000013e9
00000001000013d8	addq	$0x228, %rcx                    ## imm = 0x228
00000001000013df	cmpb	$0x0, (%rcx)
00000001000013e2	je	0x10000140c
00000001000013e4	jmp	0x100001490
00000001000013e9	cmpb	$0x1, %dl
00000001000013ec	jne	0x10000140c
00000001000013ee	movl	0x20(%rcx), %edx
00000001000013f1	imulq	%rdx, %rax
00000001000013f5	shrq	$0x20, %rax
00000001000013f9	addq	%rax, %rcx
00000001000013fc	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001403	cmpb	$0x0, (%rcx)
0000000100001406	jne	0x100001490
000000010000140c	callq	_fwp_p_attempt_owned
0000000100001411	movq	%rax, %rcx
0000000100001414	subq	0xbc1d(%rip), %rcx
000000010000141b	movq	0xbc3e(%rip), %rdx
0000000100001422	shlq	$0x10, %rdx
0000000100001426	cmpq	%rdx, %rcx
0000000100001429	jae	0x10000148e
000000010000142b	movq	0xbc4e(%rip), %rsi
0000000100001432	movq	%rcx, %rdx
0000000100001435	shrq	$0x10, %rdx
0000000100001439	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
0000000100001440	leaq	(%rsi,%rdi), %rdx
0000000100001444	movzbl	(%rsi,%rdi), %esi
0000000100001448	cmpb	$0x2, %sil
000000010000144c	setne	%dil
0000000100001450	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001457	setne	%r8b
000000010000145b	orb	%dil, %r8b
000000010000145e	jne	0x10000146e
0000000100001460	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001467	cmpb	$0x0, (%rdx)
000000010000146a	je	0x10000148e
000000010000146c	jmp	0x100001490
000000010000146e	cmpb	$0x1, %sil
0000000100001472	jne	0x10000148e
0000000100001474	movl	0x20(%rdx), %esi
0000000100001477	imulq	%rsi, %rcx
000000010000147b	shrq	$0x20, %rcx
000000010000147f	addq	%rcx, %rdx
0000000100001482	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001489	cmpb	$0x0, (%rdx)
000000010000148c	jne	0x100001490
000000010000148e	popq	%rbp
000000010000148f	retq
0000000100001490	callq	_fwp_flush
0000000100001495	movq	0x9b9c(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000149c	movq	(%rax), %rdi
000000010000149f	leaq	0x85fe(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000014a6	leaq	0x85ca(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
00000001000014ad	xorl	%eax, %eax
00000001000014af	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000014b4	movl	$0x65, %edi
00000001000014b9	callq	0x10000978e                     ## symbol stub for: _exit
00000001000014be	nop
_e2:
00000001000014c0	pushq	%rbp
00000001000014c1	movq	%rsp, %rbp
00000001000014c4	pushq	%rbx
00000001000014c5	subq	$0x18, %rsp
00000001000014c9	movq	%rdi, %rax
00000001000014cc	movq	0x9b5d(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
00000001000014d3	movq	(%rcx), %rcx
00000001000014d6	movq	%rcx, -0x10(%rbp)
00000001000014da	movq	(%rdi), %rdi
00000001000014dd	movq	0xbb54(%rip), %rcx
00000001000014e4	movq	%rdi, %rsi
00000001000014e7	subq	%rcx, %rsi
00000001000014ea	movq	0xbb6f(%rip), %rdx
00000001000014f1	shlq	$0x10, %rdx
00000001000014f5	cmpq	%rdx, %rsi
00000001000014f8	jae	0x100001568
00000001000014fa	movq	0xbb7f(%rip), %r9
0000000100001501	movq	%rsi, %r8
0000000100001504	shrq	$0x10, %r8
0000000100001508	imulq	$0x1228, %r8, %r10              ## imm = 0x1228
000000010000150f	leaq	(%r9,%r10), %r8
0000000100001513	movzbl	(%r9,%r10), %r9d
0000000100001518	cmpb	$0x2, %r9b
000000010000151c	setne	%r10b
0000000100001520	andq	$0xffff, %rsi                   ## imm = 0xFFFF
0000000100001527	setne	%r11b
000000010000152b	orb	%r10b, %r11b
000000010000152e	jne	0x100001542
0000000100001530	addq	$0x228, %r8                     ## imm = 0x228
0000000100001537	cmpb	$0x0, (%r8)
000000010000153b	je	0x100001568
000000010000153d	jmp	0x100001706
0000000100001542	cmpb	$0x1, %r9b
0000000100001546	jne	0x100001568
0000000100001548	movl	0x20(%r8), %r9d
000000010000154c	imulq	%r9, %rsi
0000000100001550	shrq	$0x20, %rsi
0000000100001554	addq	%rsi, %r8
0000000100001557	addq	$0x228, %r8                     ## imm = 0x228
000000010000155e	cmpb	$0x0, (%r8)
0000000100001562	jne	0x100001706
0000000100001568	movq	0x8(%rax), %rsi
000000010000156c	movq	%rsi, %r8
000000010000156f	subq	%rcx, %r8
0000000100001572	cmpq	%rdx, %r8
0000000100001575	jae	0x1000015e4
0000000100001577	movq	0xbb02(%rip), %r10
000000010000157e	movq	%r8, %r9
0000000100001581	shrq	$0x10, %r9
0000000100001585	imulq	$0x1228, %r9, %r11              ## imm = 0x1228
000000010000158c	leaq	(%r10,%r11), %r9
0000000100001590	movzbl	(%r10,%r11), %r10d
0000000100001595	cmpb	$0x2, %r10b
0000000100001599	setne	%r11b
000000010000159d	andq	$0xffff, %r8                    ## imm = 0xFFFF
00000001000015a4	setne	%bl
00000001000015a7	orb	%r11b, %bl
00000001000015aa	jne	0x1000015be
00000001000015ac	addq	$0x228, %r9                     ## imm = 0x228
00000001000015b3	cmpb	$0x0, (%r9)
00000001000015b7	je	0x1000015e4
00000001000015b9	jmp	0x100001706
00000001000015be	cmpb	$0x1, %r10b
00000001000015c2	jne	0x1000015e4
00000001000015c4	movl	0x20(%r9), %r10d
00000001000015c8	imulq	%r10, %r8
00000001000015cc	shrq	$0x20, %r8
00000001000015d0	addq	%r8, %r9
00000001000015d3	addq	$0x228, %r9                     ## imm = 0x228
00000001000015da	cmpb	$0x0, (%r9)
00000001000015de	jne	0x100001706
00000001000015e4	movq	0x10(%rax), %rax
00000001000015e8	movq	%rax, %r8
00000001000015eb	subq	%rcx, %r8
00000001000015ee	cmpq	%rdx, %r8
00000001000015f1	jae	0x10000165c
00000001000015f3	movq	0xba86(%rip), %rdx
00000001000015fa	movq	%r8, %rcx
00000001000015fd	shrq	$0x10, %rcx
0000000100001601	imulq	$0x1228, %rcx, %r9              ## imm = 0x1228
0000000100001608	leaq	(%rdx,%r9), %rcx
000000010000160c	movzbl	(%rdx,%r9), %edx
0000000100001611	cmpb	$0x2, %dl
0000000100001614	setne	%r9b
0000000100001618	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000161f	setne	%r10b
0000000100001623	orb	%r9b, %r10b
0000000100001626	jne	0x100001639
0000000100001628	addq	$0x228, %rcx                    ## imm = 0x228
000000010000162f	cmpb	$0x0, (%rcx)
0000000100001632	je	0x10000165c
0000000100001634	jmp	0x100001706
0000000100001639	cmpb	$0x1, %dl
000000010000163c	jne	0x10000165c
000000010000163e	movl	0x20(%rcx), %edx
0000000100001641	imulq	%rdx, %r8
0000000100001645	shrq	$0x20, %r8
0000000100001649	addq	%r8, %rcx
000000010000164c	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001653	cmpb	$0x0, (%rcx)
0000000100001656	jne	0x100001706
000000010000165c	movq	%rax, -0x20(%rbp)
0000000100001660	movq	%rsi, -0x18(%rbp)
0000000100001664	leaq	-0x20(%rbp), %rdx
0000000100001668	movl	$0x2, %esi
000000010000166d	callq	_fwp_apply_owned
0000000100001672	movq	%rax, %rcx
0000000100001675	subq	0xb9bc(%rip), %rcx
000000010000167c	movq	0xb9dd(%rip), %rdx
0000000100001683	shlq	$0x10, %rdx
0000000100001687	cmpq	%rdx, %rcx
000000010000168a	jae	0x1000016ef
000000010000168c	movq	0xb9ed(%rip), %rsi
0000000100001693	movq	%rcx, %rdx
0000000100001696	shrq	$0x10, %rdx
000000010000169a	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
00000001000016a1	leaq	(%rsi,%rdi), %rdx
00000001000016a5	movzbl	(%rsi,%rdi), %esi
00000001000016a9	cmpb	$0x2, %sil
00000001000016ad	setne	%dil
00000001000016b1	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000016b8	setne	%r8b
00000001000016bc	orb	%dil, %r8b
00000001000016bf	jne	0x1000016cf
00000001000016c1	addq	$0x228, %rdx                    ## imm = 0x228
00000001000016c8	cmpb	$0x0, (%rdx)
00000001000016cb	je	0x1000016ef
00000001000016cd	jmp	0x100001706
00000001000016cf	cmpb	$0x1, %sil
00000001000016d3	jne	0x1000016ef
00000001000016d5	movl	0x20(%rdx), %esi
00000001000016d8	imulq	%rsi, %rcx
00000001000016dc	shrq	$0x20, %rcx
00000001000016e0	addq	%rcx, %rdx
00000001000016e3	addq	$0x228, %rdx                    ## imm = 0x228
00000001000016ea	cmpb	$0x0, (%rdx)
00000001000016ed	jne	0x100001706
00000001000016ef	movq	0x993a(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
00000001000016f6	movq	(%rcx), %rcx
00000001000016f9	cmpq	-0x10(%rbp), %rcx
00000001000016fd	jne	0x100001734
00000001000016ff	addq	$0x18, %rsp
0000000100001703	popq	%rbx
0000000100001704	popq	%rbp
0000000100001705	retq
0000000100001706	callq	_fwp_flush
000000010000170b	movq	0x9926(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001712	movq	(%rax), %rdi
0000000100001715	leaq	0x8388(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000171c	leaq	0x8354(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001723	xorl	%eax, %eax
0000000100001725	callq	0x1000097ac                     ## symbol stub for: _fprintf
000000010000172a	movl	$0x65, %edi
000000010000172f	callq	0x10000978e                     ## symbol stub for: _exit
0000000100001734	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100001739	nopl	(%rax)
_e3:
0000000100001740	pushq	%rbp
0000000100001741	movq	%rsp, %rbp
0000000100001744	movq	%rdi, %rax
0000000100001747	movq	(%rdi), %rdi
000000010000174a	movq	0xb8e7(%rip), %rcx
0000000100001751	movq	%rdi, %rsi
0000000100001754	subq	%rcx, %rsi
0000000100001757	movq	0xb902(%rip), %rdx
000000010000175e	shlq	$0x10, %rdx
0000000100001762	cmpq	%rdx, %rsi
0000000100001765	jae	0x1000017d5
0000000100001767	movq	0xb912(%rip), %r9
000000010000176e	movq	%rsi, %r8
0000000100001771	shrq	$0x10, %r8
0000000100001775	imulq	$0x1228, %r8, %r10              ## imm = 0x1228
000000010000177c	leaq	(%r9,%r10), %r8
0000000100001780	movzbl	(%r9,%r10), %r9d
0000000100001785	cmpb	$0x2, %r9b
0000000100001789	setne	%r10b
000000010000178d	andq	$0xffff, %rsi                   ## imm = 0xFFFF
0000000100001794	setne	%r11b
0000000100001798	orb	%r10b, %r11b
000000010000179b	jne	0x1000017af
000000010000179d	addq	$0x228, %r8                     ## imm = 0x228
00000001000017a4	cmpb	$0x0, (%r8)
00000001000017a8	je	0x1000017d5
00000001000017aa	jmp	0x1000018d0
00000001000017af	cmpb	$0x1, %r9b
00000001000017b3	jne	0x1000017d5
00000001000017b5	movl	0x20(%r8), %r9d
00000001000017b9	imulq	%r9, %rsi
00000001000017bd	shrq	$0x20, %rsi
00000001000017c1	addq	%rsi, %r8
00000001000017c4	addq	$0x228, %r8                     ## imm = 0x228
00000001000017cb	cmpb	$0x0, (%r8)
00000001000017cf	jne	0x1000018d0
00000001000017d5	movq	0x8(%rax), %rsi
00000001000017d9	movq	%rsi, %rax
00000001000017dc	subq	%rcx, %rax
00000001000017df	cmpq	%rdx, %rax
00000001000017e2	jae	0x10000184c
00000001000017e4	movq	0xb895(%rip), %rdx
00000001000017eb	movq	%rax, %rcx
00000001000017ee	shrq	$0x10, %rcx
00000001000017f2	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
00000001000017f9	leaq	(%rdx,%r8), %rcx
00000001000017fd	movzbl	(%rdx,%r8), %edx
0000000100001802	cmpb	$0x2, %dl
0000000100001805	setne	%r8b
0000000100001809	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000180f	setne	%r9b
0000000100001813	orb	%r8b, %r9b
0000000100001816	jne	0x100001829
0000000100001818	addq	$0x228, %rcx                    ## imm = 0x228
000000010000181f	cmpb	$0x0, (%rcx)
0000000100001822	je	0x10000184c
0000000100001824	jmp	0x1000018d0
0000000100001829	cmpb	$0x1, %dl
000000010000182c	jne	0x10000184c
000000010000182e	movl	0x20(%rcx), %edx
0000000100001831	imulq	%rdx, %rax
0000000100001835	shrq	$0x20, %rax
0000000100001839	addq	%rax, %rcx
000000010000183c	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001843	cmpb	$0x0, (%rcx)
0000000100001846	jne	0x1000018d0
000000010000184c	callq	_fwp_p_file_with_owned
0000000100001851	movq	%rax, %rcx
0000000100001854	subq	0xb7dd(%rip), %rcx
000000010000185b	movq	0xb7fe(%rip), %rdx
0000000100001862	shlq	$0x10, %rdx
0000000100001866	cmpq	%rdx, %rcx
0000000100001869	jae	0x1000018ce
000000010000186b	movq	0xb80e(%rip), %rsi
0000000100001872	movq	%rcx, %rdx
0000000100001875	shrq	$0x10, %rdx
0000000100001879	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
0000000100001880	leaq	(%rsi,%rdi), %rdx
0000000100001884	movzbl	(%rsi,%rdi), %esi
0000000100001888	cmpb	$0x2, %sil
000000010000188c	setne	%dil
0000000100001890	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001897	setne	%r8b
000000010000189b	orb	%dil, %r8b
000000010000189e	jne	0x1000018ae
00000001000018a0	addq	$0x228, %rdx                    ## imm = 0x228
00000001000018a7	cmpb	$0x0, (%rdx)
00000001000018aa	je	0x1000018ce
00000001000018ac	jmp	0x1000018d0
00000001000018ae	cmpb	$0x1, %sil
00000001000018b2	jne	0x1000018ce
00000001000018b4	movl	0x20(%rdx), %esi
00000001000018b7	imulq	%rsi, %rcx
00000001000018bb	shrq	$0x20, %rcx
00000001000018bf	addq	%rcx, %rdx
00000001000018c2	addq	$0x228, %rdx                    ## imm = 0x228
00000001000018c9	cmpb	$0x0, (%rdx)
00000001000018cc	jne	0x1000018d0
00000001000018ce	popq	%rbp
00000001000018cf	retq
00000001000018d0	callq	_fwp_flush
00000001000018d5	movq	0x975c(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000018dc	movq	(%rax), %rdi
00000001000018df	leaq	0x81be(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000018e6	leaq	0x818a(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
00000001000018ed	xorl	%eax, %eax
00000001000018ef	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000018f4	movl	$0x65, %edi
00000001000018f9	callq	0x10000978e                     ## symbol stub for: _exit
00000001000018fe	nop
_e4:
0000000100001900	pushq	%rbp
0000000100001901	movq	%rsp, %rbp
0000000100001904	movq	(%rdi), %rdi
0000000100001907	movq	%rdi, %rax
000000010000190a	subq	0xb727(%rip), %rax
0000000100001911	movq	0xb748(%rip), %rcx
0000000100001918	shlq	$0x10, %rcx
000000010000191c	cmpq	%rcx, %rax
000000010000191f	jae	0x100001988
0000000100001921	movq	0xb758(%rip), %rdx
0000000100001928	movq	%rax, %rcx
000000010000192b	shrq	$0x10, %rcx
000000010000192f	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001936	leaq	(%rdx,%rsi), %rcx
000000010000193a	movzbl	(%rdx,%rsi), %edx
000000010000193e	cmpb	$0x2, %dl
0000000100001941	setne	%sil
0000000100001945	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000194b	setne	%r8b
000000010000194f	orb	%sil, %r8b
0000000100001952	jne	0x100001965
0000000100001954	addq	$0x228, %rcx                    ## imm = 0x228
000000010000195b	cmpb	$0x0, (%rcx)
000000010000195e	je	0x100001988
0000000100001960	jmp	0x100001a0c
0000000100001965	cmpb	$0x1, %dl
0000000100001968	jne	0x100001988
000000010000196a	movl	0x20(%rcx), %edx
000000010000196d	imulq	%rdx, %rax
0000000100001971	shrq	$0x20, %rax
0000000100001975	addq	%rax, %rcx
0000000100001978	addq	$0x228, %rcx                    ## imm = 0x228
000000010000197f	cmpb	$0x0, (%rcx)
0000000100001982	jne	0x100001a0c
0000000100001988	callq	_f4
000000010000198d	movq	%rax, %rcx
0000000100001990	subq	0xb6a1(%rip), %rcx
0000000100001997	movq	0xb6c2(%rip), %rdx
000000010000199e	shlq	$0x10, %rdx
00000001000019a2	cmpq	%rdx, %rcx
00000001000019a5	jae	0x100001a0a
00000001000019a7	movq	0xb6d2(%rip), %rsi
00000001000019ae	movq	%rcx, %rdx
00000001000019b1	shrq	$0x10, %rdx
00000001000019b5	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
00000001000019bc	leaq	(%rsi,%rdi), %rdx
00000001000019c0	movzbl	(%rsi,%rdi), %esi
00000001000019c4	cmpb	$0x2, %sil
00000001000019c8	setne	%dil
00000001000019cc	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000019d3	setne	%r8b
00000001000019d7	orb	%dil, %r8b
00000001000019da	jne	0x1000019ea
00000001000019dc	addq	$0x228, %rdx                    ## imm = 0x228
00000001000019e3	cmpb	$0x0, (%rdx)
00000001000019e6	je	0x100001a0a
00000001000019e8	jmp	0x100001a0c
00000001000019ea	cmpb	$0x1, %sil
00000001000019ee	jne	0x100001a0a
00000001000019f0	movl	0x20(%rdx), %esi
00000001000019f3	imulq	%rsi, %rcx
00000001000019f7	shrq	$0x20, %rcx
00000001000019fb	addq	%rcx, %rdx
00000001000019fe	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001a05	cmpb	$0x0, (%rdx)
0000000100001a08	jne	0x100001a0c
0000000100001a0a	popq	%rbp
0000000100001a0b	retq
0000000100001a0c	callq	_fwp_flush
0000000100001a11	movq	0x9620(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001a18	movq	(%rax), %rdi
0000000100001a1b	leaq	0x8082(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001a22	leaq	0x804e(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001a29	xorl	%eax, %eax
0000000100001a2b	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100001a30	movl	$0x65, %edi
0000000100001a35	callq	0x10000978e                     ## symbol stub for: _exit
0000000100001a3a	nopw	(%rax,%rax)
_e8:
0000000100001a40	pushq	%rbp
0000000100001a41	movq	%rsp, %rbp
0000000100001a44	movq	(%rdi), %rdi
0000000100001a47	movq	%rdi, %rax
0000000100001a4a	subq	0xb5e7(%rip), %rax
0000000100001a51	movq	0xb608(%rip), %rcx
0000000100001a58	shlq	$0x10, %rcx
0000000100001a5c	cmpq	%rcx, %rax
0000000100001a5f	jae	0x100001ac8
0000000100001a61	movq	0xb618(%rip), %rdx
0000000100001a68	movq	%rax, %rcx
0000000100001a6b	shrq	$0x10, %rcx
0000000100001a6f	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001a76	leaq	(%rdx,%rsi), %rcx
0000000100001a7a	movzbl	(%rdx,%rsi), %edx
0000000100001a7e	cmpb	$0x2, %dl
0000000100001a81	setne	%sil
0000000100001a85	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100001a8b	setne	%r8b
0000000100001a8f	orb	%sil, %r8b
0000000100001a92	jne	0x100001aa5
0000000100001a94	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001a9b	cmpb	$0x0, (%rcx)
0000000100001a9e	je	0x100001ac8
0000000100001aa0	jmp	0x100001b4c
0000000100001aa5	cmpb	$0x1, %dl
0000000100001aa8	jne	0x100001ac8
0000000100001aaa	movl	0x20(%rcx), %edx
0000000100001aad	imulq	%rdx, %rax
0000000100001ab1	shrq	$0x20, %rax
0000000100001ab5	addq	%rax, %rcx
0000000100001ab8	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001abf	cmpb	$0x0, (%rcx)
0000000100001ac2	jne	0x100001b4c
0000000100001ac8	callq	_f8
0000000100001acd	movq	%rax, %rcx
0000000100001ad0	subq	0xb561(%rip), %rcx
0000000100001ad7	movq	0xb582(%rip), %rdx
0000000100001ade	shlq	$0x10, %rdx
0000000100001ae2	cmpq	%rdx, %rcx
0000000100001ae5	jae	0x100001b4a
0000000100001ae7	movq	0xb592(%rip), %rsi
0000000100001aee	movq	%rcx, %rdx
0000000100001af1	shrq	$0x10, %rdx
0000000100001af5	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
0000000100001afc	leaq	(%rsi,%rdi), %rdx
0000000100001b00	movzbl	(%rsi,%rdi), %esi
0000000100001b04	cmpb	$0x2, %sil
0000000100001b08	setne	%dil
0000000100001b0c	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001b13	setne	%r8b
0000000100001b17	orb	%dil, %r8b
0000000100001b1a	jne	0x100001b2a
0000000100001b1c	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001b23	cmpb	$0x0, (%rdx)
0000000100001b26	je	0x100001b4a
0000000100001b28	jmp	0x100001b4c
0000000100001b2a	cmpb	$0x1, %sil
0000000100001b2e	jne	0x100001b4a
0000000100001b30	movl	0x20(%rdx), %esi
0000000100001b33	imulq	%rsi, %rcx
0000000100001b37	shrq	$0x20, %rcx
0000000100001b3b	addq	%rcx, %rdx
0000000100001b3e	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001b45	cmpb	$0x0, (%rdx)
0000000100001b48	jne	0x100001b4c
0000000100001b4a	popq	%rbp
0000000100001b4b	retq
0000000100001b4c	callq	_fwp_flush
0000000100001b51	movq	0x94e0(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001b58	movq	(%rax), %rdi
0000000100001b5b	leaq	0x7f42(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001b62	leaq	0x7f0e(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001b69	xorl	%eax, %eax
0000000100001b6b	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100001b70	movl	$0x65, %edi
0000000100001b75	callq	0x10000978e                     ## symbol stub for: _exit
0000000100001b7a	nopw	(%rax,%rax)
_e9:
0000000100001b80	pushq	%rbp
0000000100001b81	movq	%rsp, %rbp
0000000100001b84	movq	(%rdi), %rdi
0000000100001b87	movq	%rdi, %rax
0000000100001b8a	subq	0xb4a7(%rip), %rax
0000000100001b91	movq	0xb4c8(%rip), %rcx
0000000100001b98	shlq	$0x10, %rcx
0000000100001b9c	cmpq	%rcx, %rax
0000000100001b9f	jae	0x100001c08
0000000100001ba1	movq	0xb4d8(%rip), %rdx
0000000100001ba8	movq	%rax, %rcx
0000000100001bab	shrq	$0x10, %rcx
0000000100001baf	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001bb6	leaq	(%rdx,%rsi), %rcx
0000000100001bba	movzbl	(%rdx,%rsi), %edx
0000000100001bbe	cmpb	$0x2, %dl
0000000100001bc1	setne	%sil
0000000100001bc5	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100001bcb	setne	%r8b
0000000100001bcf	orb	%sil, %r8b
0000000100001bd2	jne	0x100001be5
0000000100001bd4	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001bdb	cmpb	$0x0, (%rcx)
0000000100001bde	je	0x100001c08
0000000100001be0	jmp	0x100001cae
0000000100001be5	cmpb	$0x1, %dl
0000000100001be8	jne	0x100001c08
0000000100001bea	movl	0x20(%rcx), %edx
0000000100001bed	imulq	%rdx, %rax
0000000100001bf1	shrq	$0x20, %rax
0000000100001bf5	addq	%rax, %rcx
0000000100001bf8	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001bff	cmpb	$0x0, (%rcx)
0000000100001c02	jne	0x100001cae
0000000100001c08	movq	(%rdi), %rdx
0000000100001c0b	addq	$0x8, %rdi
0000000100001c0f	movq	_fwp_prog_out(%rip), %rcx
0000000100001c16	movl	$0x1, %esi
0000000100001c1b	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100001c20	movq	_fwp_prog_out(%rip), %rsi
0000000100001c27	movl	$0xa, %edi
0000000100001c2c	callq	0x1000097b2                     ## symbol stub for: _fputc
0000000100001c31	xorl	%eax, %eax
0000000100001c33	subq	0xb3fe(%rip), %rax
0000000100001c3a	movq	0xb41f(%rip), %rcx
0000000100001c41	shlq	$0x10, %rcx
0000000100001c45	cmpq	%rax, %rcx
0000000100001c48	jbe	0x100001caa
0000000100001c4a	movq	0xb42f(%rip), %rdx
0000000100001c51	movq	%rax, %rcx
0000000100001c54	shrq	$0x10, %rcx
0000000100001c58	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001c5f	leaq	(%rdx,%rsi), %rcx
0000000100001c63	movzbl	(%rdx,%rsi), %edx
0000000100001c67	cmpb	$0x2, %dl
0000000100001c6a	setne	%sil
0000000100001c6e	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100001c74	setne	%dil
0000000100001c78	orb	%sil, %dil
0000000100001c7b	jne	0x100001c8b
0000000100001c7d	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001c84	cmpb	$0x0, (%rcx)
0000000100001c87	je	0x100001caa
0000000100001c89	jmp	0x100001cae
0000000100001c8b	cmpb	$0x1, %dl
0000000100001c8e	jne	0x100001caa
0000000100001c90	movl	0x20(%rcx), %edx
0000000100001c93	imulq	%rdx, %rax
0000000100001c97	shrq	$0x20, %rax
0000000100001c9b	addq	%rax, %rcx
0000000100001c9e	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001ca5	cmpb	$0x0, (%rcx)
0000000100001ca8	jne	0x100001cae
0000000100001caa	xorl	%eax, %eax
0000000100001cac	popq	%rbp
0000000100001cad	retq
0000000100001cae	callq	_fwp_flush
0000000100001cb3	movq	0x937e(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001cba	movq	(%rax), %rdi
0000000100001cbd	leaq	0x7de0(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001cc4	leaq	0x7dac(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001ccb	xorl	%eax, %eax
0000000100001ccd	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100001cd2	movl	$0x65, %edi
0000000100001cd7	callq	0x10000978e                     ## symbol stub for: _exit
0000000100001cdc	nopl	(%rax)
_fwp_cleanup_unwind:
0000000100001ce0	pushq	%rbp
0000000100001ce1	movq	%rsp, %rbp
0000000100001ce4	pushq	%rbx
0000000100001ce5	pushq	%rax
0000000100001ce6	movq	_fwp_cleanups(%rip), %rax
0000000100001ced	cmpq	%rdi, %rax
0000000100001cf0	je	0x100001d22
0000000100001cf2	movq	%rdi, %rbx
0000000100001cf5	nopw	%cs:(%rax,%rax)
0000000100001d00	testq	%rax, %rax
0000000100001d03	je	0x100001d29
0000000100001d05	movq	(%rax), %rcx
0000000100001d08	movq	%rcx, _fwp_cleanups(%rip)
0000000100001d0f	movq	0x10(%rax), %rdi
0000000100001d13	callq	*0x8(%rax)
0000000100001d16	movq	_fwp_cleanups(%rip), %rax
0000000100001d1d	cmpq	%rbx, %rax
0000000100001d20	jne	0x100001d00
0000000100001d22	addq	$0x8, %rsp
0000000100001d26	popq	%rbx
0000000100001d27	popq	%rbp
0000000100001d28	retq
0000000100001d29	callq	0x100009770                     ## symbol stub for: _abort
0000000100001d2e	nop
_fwp_flush:
0000000100001d30	pushq	%rbp
0000000100001d31	movq	%rsp, %rbp
0000000100001d34	movq	_fwp_prog_out(%rip), %rdi
0000000100001d3b	testq	%rdi, %rdi
0000000100001d3e	je	0x100001d45
0000000100001d40	callq	0x1000097a0                     ## symbol stub for: _fflush
0000000100001d45	movq	0x92f4(%rip), %rax              ## literal pool symbol address: ___stdoutp
0000000100001d4c	movq	(%rax), %rdi
0000000100001d4f	popq	%rbp
0000000100001d50	jmp	0x1000097a0                     ## symbol stub for: _fflush
0000000100001d55	nopw	%cs:(%rax,%rax)
_fwp_rc_forget_slot:
0000000100001d60	pushq	%rbp
0000000100001d61	movq	%rsp, %rbp
0000000100001d64	cmpb	$-0x1, (%rdi)
0000000100001d67	je	0x100001d6b
0000000100001d69	popq	%rbp
0000000100001d6a	retq
0000000100001d6b	movq	%rdi, %rax
0000000100001d6e	shrq	$0x11, %rax
0000000100001d72	xorl	%edi, %eax
0000000100001d74	movl	%eax, %ecx
0000000100001d76	shrl	$0x9, %ecx
0000000100001d79	xorl	%eax, %ecx
0000000100001d7b	movzbl	%cl, %ecx
0000000100001d7e	leaq	_fwp_gc(%rip), %rdx
0000000100001d85	movq	0x1218(%rdx,%rcx,8), %rax
0000000100001d8d	testq	%rax, %rax
0000000100001d90	je	0x100001dda
0000000100001d92	cmpq	%rdi, (%rax)
0000000100001d95	je	0x100001db7
0000000100001d97	nopw	(%rax,%rax)
0000000100001da0	movq	%rax, %rcx
0000000100001da3	movq	0x10(%rax), %rax
0000000100001da7	testq	%rax, %rax
0000000100001daa	je	0x100001dda
0000000100001dac	cmpq	%rdi, (%rax)
0000000100001daf	jne	0x100001da0
0000000100001db1	addq	$0x10, %rcx
0000000100001db5	jmp	0x100001dc2
0000000100001db7	leaq	(%rdx,%rcx,8), %rcx
0000000100001dbb	addq	$0x1218, %rcx                   ## imm = 0x1218
0000000100001dc2	movq	0x10(%rax), %rdx
0000000100001dc6	movq	%rdx, (%rcx)
0000000100001dc9	movq	%rax, %rdi
0000000100001dcc	callq	0x1000097be                     ## symbol stub for: _free
0000000100001dd1	decq	0xbc48(%rip)
0000000100001dd8	popq	%rbp
0000000100001dd9	retq
0000000100001dda	callq	_fwp_flush
0000000100001ddf	movq	0x9252(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001de6	movq	(%rax), %rdi
0000000100001de9	leaq	0x7cb4(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001df0	leaq	0x7cbc(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100001df7	xorl	%eax, %eax
0000000100001df9	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100001dfe	movl	$0x65, %edi
0000000100001e03	callq	0x10000978e                     ## symbol stub for: _exit
0000000100001e08	nopl	(%rax,%rax)
_fwp_p_attempt_owned:
0000000100001e10	pushq	%rbp
0000000100001e11	movq	%rsp, %rbp
0000000100001e14	pushq	%r15
0000000100001e16	pushq	%r14
0000000100001e18	pushq	%r12
0000000100001e1a	pushq	%rbx
0000000100001e1b	subq	$0x100, %rsp                    ## imm = 0x100
0000000100001e22	movq	%rdi, %rbx
0000000100001e25	movq	%rsi, -0x28(%rbp)
0000000100001e29	movq	_fwp_handlers(%rip), %rax
0000000100001e30	movq	%rax, -0x80(%rbp)
0000000100001e34	movq	_fwp_state_len(%rip), %rax
0000000100001e3b	movq	%rax, -0x68(%rbp)
0000000100001e3f	movq	_fwp_cleanups(%rip), %rax
0000000100001e46	movq	%rax, -0x60(%rbp)
0000000100001e4a	leaq	-0x118(%rbp), %rdi
0000000100001e51	movq	%rdi, _fwp_handlers(%rip)
0000000100001e58	callq	0x100009824                     ## symbol stub for: _setjmp
0000000100001e5d	testl	%eax, %eax
0000000100001e5f	je	0x100001e7e
0000000100001e61	movq	-0x78(%rbp), %rcx
0000000100001e65	movq	-0x68(%rbp), %rax
0000000100001e69	movq	%rax, _fwp_state_len(%rip)
0000000100001e70	movl	$0x1, %edx
0000000100001e75	leaq	_fwp_drop3(%rip), %rax
0000000100001e7c	jmp	0x100001e9c
0000000100001e7e	leaq	-0x28(%rbp), %rsi
0000000100001e82	movq	%rbx, %rdi
0000000100001e85	callq	_fwp_apply_borrowed
0000000100001e8a	xorl	%edx, %edx
0000000100001e8c	leaq	_fwp_drop2(%rip), %rcx
0000000100001e93	movq	%rax, %rsi
0000000100001e96	movq	%rcx, %rax
0000000100001e99	movq	%rsi, %rcx
0000000100001e9c	movl	%edx, %r14d
0000000100001e9f	movq	%rcx, %r12
0000000100001ea2	movq	%rcx, -0x40(%rbp)
0000000100001ea6	movq	-0x80(%rbp), %rcx
0000000100001eaa	movq	%rcx, _fwp_handlers(%rip)
0000000100001eb1	movq	%r12, -0x38(%rbp)
0000000100001eb5	movq	%rax, -0x30(%rbp)
0000000100001eb9	movq	_fwp_cleanups(%rip), %rax
0000000100001ec0	movq	%rax, -0x58(%rbp)
0000000100001ec4	leaq	_fwp_value_release(%rip), %rax
0000000100001ecb	movq	%rax, -0x50(%rbp)
0000000100001ecf	leaq	-0x38(%rbp), %rax
0000000100001ed3	movq	%rax, -0x48(%rbp)
0000000100001ed7	leaq	-0x58(%rbp), %r15
0000000100001edb	movq	%r15, _fwp_cleanups(%rip)
0000000100001ee2	movl	$0x10, %edi
0000000100001ee7	callq	_fwp_alloc_init
0000000100001eec	movl	%r14d, (%rax)
0000000100001eef	movl	$0x1, 0x4(%rax)
0000000100001ef6	movq	%r12, 0x8(%rax)
0000000100001efa	leaq	-0x40(%rbp), %rcx
0000000100001efe	movq	%rax, %rdx
0000000100001f01	subq	0xb130(%rip), %rdx
0000000100001f08	movq	0xb151(%rip), %rcx
0000000100001f0f	shlq	$0x10, %rcx
0000000100001f13	cmpq	%rcx, %rdx
0000000100001f16	jae	0x100001f92
0000000100001f18	movq	0xb161(%rip), %rsi
0000000100001f1f	movq	%rdx, %rcx
0000000100001f22	shrq	$0x10, %rcx
0000000100001f26	imulq	$0x1228, %rcx, %rdi             ## imm = 0x1228
0000000100001f2d	leaq	(%rsi,%rdi), %r14
0000000100001f31	movzbl	(%rsi,%rdi), %esi
0000000100001f35	cmpb	$0x2, %sil
0000000100001f39	setne	%dil
0000000100001f3d	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100001f44	setne	%r8b
0000000100001f48	orb	%dil, %r8b
0000000100001f4b	jne	0x100001f60
0000000100001f4d	addq	$0x228, %r14                    ## imm = 0x228
0000000100001f54	cmpb	$-0x1, (%r14)
0000000100001f58	je	0x100001f82
0000000100001f5a	movb	$0x1, (%r14)
0000000100001f5e	jmp	0x100001f92
0000000100001f60	cmpb	$0x1, %sil
0000000100001f64	jne	0x100001f92
0000000100001f66	movl	0x20(%r14), %esi
0000000100001f6a	imulq	%rsi, %rdx
0000000100001f6e	shrq	$0x20, %rdx
0000000100001f72	addq	%rdx, %r14
0000000100001f75	addq	$0x228, %r14                    ## imm = 0x228
0000000100001f7c	cmpb	$-0x1, (%r14)
0000000100001f80	jne	0x100001f5a
0000000100001f82	movq	%r14, %rdi
0000000100001f85	movq	%rax, %r12
0000000100001f88	callq	_fwp_rc_forget_slot
0000000100001f8d	movq	%r12, %rax
0000000100001f90	jmp	0x100001f5a
0000000100001f92	movq	-0x28(%rbp), %rcx
0000000100001f96	cmpq	$0x0, -0x30(%rbp)
0000000100001f9b	je	0x100001fb1
0000000100001f9d	cmpq	%r15, _fwp_cleanups(%rip)
0000000100001fa4	jne	0x100001fc1
0000000100001fa6	movq	-0x58(%rbp), %rcx
0000000100001faa	movq	%rcx, _fwp_cleanups(%rip)
0000000100001fb1	addq	$0x100, %rsp                    ## imm = 0x100
0000000100001fb8	popq	%rbx
0000000100001fb9	popq	%r12
0000000100001fbb	popq	%r14
0000000100001fbd	popq	%r15
0000000100001fbf	popq	%rbp
0000000100001fc0	retq
0000000100001fc1	callq	0x100009770                     ## symbol stub for: _abort
0000000100001fc6	nopw	%cs:(%rax,%rax)
_fwp_drop2:
0000000100001fd0	pushq	%rbp
0000000100001fd1	movq	%rsp, %rbp
0000000100001fd4	movq	%rdi, %rcx
0000000100001fd7	subq	0xb05a(%rip), %rcx
0000000100001fde	movq	0xb07b(%rip), %rax
0000000100001fe5	shlq	$0x10, %rax
0000000100001fe9	cmpq	%rax, %rcx
0000000100001fec	jae	0x100002061
0000000100001fee	movq	0xb08b(%rip), %rdx
0000000100001ff5	movq	%rcx, %rax
0000000100001ff8	shrq	$0x10, %rax
0000000100001ffc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100002003	leaq	(%rdx,%rsi), %rax
0000000100002007	movzbl	(%rdx,%rsi), %edx
000000010000200b	cmpb	$0x2, %dl
000000010000200e	setne	%sil
0000000100002012	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100002019	setne	%r8b
000000010000201d	orb	%sil, %r8b
0000000100002020	jne	0x10000202a
0000000100002022	addq	$0x228, %rax                    ## imm = 0x228
0000000100002028	jmp	0x100002043
000000010000202a	cmpb	$0x1, %dl
000000010000202d	jne	0x100002061
000000010000202f	movl	0x20(%rax), %edx
0000000100002032	imulq	%rdx, %rcx
0000000100002036	shrq	$0x20, %rcx
000000010000203a	addq	%rcx, %rax
000000010000203d	addq	$0x228, %rax                    ## imm = 0x228
0000000100002043	movzbl	(%rax), %ecx
0000000100002046	testl	%ecx, %ecx
0000000100002048	je	0x100002061
000000010000204a	cmpl	$0x1, %ecx
000000010000204d	jne	0x100002055
000000010000204f	popq	%rbp
0000000100002050	jmp	_fwp_rc_free_obj
0000000100002055	cmpl	$0xff, %ecx
000000010000205b	je	0x100002063
000000010000205d	decb	%cl
000000010000205f	movb	%cl, (%rax)
0000000100002061	popq	%rbp
0000000100002062	retq
0000000100002063	movq	%rax, %rdi
0000000100002066	popq	%rbp
0000000100002067	jmp	_fwp_rc_wide_drop
000000010000206c	nopl	(%rax)
_fwp_drop3:
0000000100002070	movq	0xafc1(%rip), %rcx
0000000100002077	movq	%rdi, %r8
000000010000207a	subq	%rcx, %r8
000000010000207d	movq	0xafdc(%rip), %rsi
0000000100002084	shlq	$0x10, %rsi
0000000100002088	cmpq	%rsi, %r8
000000010000208b	jae	0x10000215f
0000000100002091	movq	0xafe8(%rip), %rdx
0000000100002098	movq	%r8, %rax
000000010000209b	shrq	$0x10, %rax
000000010000209f	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
00000001000020a6	leaq	(%rdx,%r9), %rax
00000001000020aa	movzbl	(%rdx,%r9), %r9d
00000001000020af	cmpb	$0x2, %r9b
00000001000020b3	setne	%r10b
00000001000020b7	andq	$0xffff, %r8                    ## imm = 0xFFFF
00000001000020be	setne	%r11b
00000001000020c2	orb	%r10b, %r11b
00000001000020c5	jne	0x1000020cf
00000001000020c7	addq	$0x228, %rax                    ## imm = 0x228
00000001000020cd	jmp	0x1000020ee
00000001000020cf	cmpb	$0x1, %r9b
00000001000020d3	jne	0x10000215f
00000001000020d9	movl	0x20(%rax), %r9d
00000001000020dd	imulq	%r9, %r8
00000001000020e1	shrq	$0x20, %r8
00000001000020e5	addq	%r8, %rax
00000001000020e8	addq	$0x228, %rax                    ## imm = 0x228
00000001000020ee	movzbl	(%rax), %r8d
00000001000020f2	testl	%r8d, %r8d
00000001000020f5	je	0x10000215f
00000001000020f7	cmpl	$0x1, %r8d
00000001000020fb	jne	0x10000214c
00000001000020fd	pushq	%rbp
00000001000020fe	movq	%rsp, %rbp
0000000100002101	pushq	%rbx
0000000100002102	pushq	%rax
0000000100002103	movq	0x8(%rdi), %rax
0000000100002107	movq	%rax, %r8
000000010000210a	subq	%rcx, %r8
000000010000210d	cmpq	%rsi, %r8
0000000100002110	jae	0x1000021a6
0000000100002116	movq	%r8, %rcx
0000000100002119	shrq	$0x10, %rcx
000000010000211d	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100002124	leaq	(%rdx,%rsi), %rcx
0000000100002128	movzbl	(%rdx,%rsi), %edx
000000010000212c	cmpb	$0x2, %dl
000000010000212f	setne	%sil
0000000100002133	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000213a	setne	%r9b
000000010000213e	orb	%sil, %r9b
0000000100002141	jne	0x100002160
0000000100002143	addq	$0x228, %rcx                    ## imm = 0x228
000000010000214a	jmp	0x10000217a
000000010000214c	cmpl	$0xff, %r8d
0000000100002153	je	0x100002255
0000000100002159	decb	%r8b
000000010000215c	movb	%r8b, (%rax)
000000010000215f	retq
0000000100002160	cmpb	$0x1, %dl
0000000100002163	jne	0x1000021a6
0000000100002165	movl	0x20(%rcx), %edx
0000000100002168	imulq	%rdx, %r8
000000010000216c	shrq	$0x20, %r8
0000000100002170	addq	%r8, %rcx
0000000100002173	addq	$0x228, %rcx                    ## imm = 0x228
000000010000217a	movzbl	(%rcx), %edx
000000010000217d	testl	%edx, %edx
000000010000217f	je	0x1000021a6
0000000100002181	cmpl	$0x1, %edx
0000000100002184	jne	0x100002196
0000000100002186	movq	%rdi, %rbx
0000000100002189	movq	%rax, %rdi
000000010000218c	callq	_fwp_rc_free_obj
0000000100002191	movq	%rbx, %rdi
0000000100002194	jmp	0x1000021a6
0000000100002196	cmpl	$0xff, %edx
000000010000219c	je	0x10000225d
00000001000021a2	decb	%dl
00000001000021a4	movb	%dl, (%rcx)
00000001000021a6	movq	0x10(%rdi), %rax
00000001000021aa	movq	%rax, %rdx
00000001000021ad	subq	0xae84(%rip), %rdx
00000001000021b4	movq	0xaea5(%rip), %rcx
00000001000021bb	shlq	$0x10, %rcx
00000001000021bf	cmpq	%rcx, %rdx
00000001000021c2	jae	0x10000224a
00000001000021c8	movq	0xaeb1(%rip), %rsi
00000001000021cf	movq	%rdx, %rcx
00000001000021d2	shrq	$0x10, %rcx
00000001000021d6	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
00000001000021dd	leaq	(%rsi,%r8), %rcx
00000001000021e1	movzbl	(%rsi,%r8), %esi
00000001000021e6	cmpb	$0x2, %sil
00000001000021ea	setne	%r8b
00000001000021ee	andq	$0xffff, %rdx                   ## imm = 0xFFFF
00000001000021f5	setne	%r9b
00000001000021f9	orb	%r8b, %r9b
00000001000021fc	jne	0x100002207
00000001000021fe	addq	$0x228, %rcx                    ## imm = 0x228
0000000100002205	jmp	0x100002222
0000000100002207	cmpb	$0x1, %sil
000000010000220b	jne	0x10000224a
000000010000220d	movl	0x20(%rcx), %esi
0000000100002210	imulq	%rsi, %rdx
0000000100002214	shrq	$0x20, %rdx
0000000100002218	addq	%rdx, %rcx
000000010000221b	addq	$0x228, %rcx                    ## imm = 0x228
0000000100002222	movzbl	(%rcx), %edx
0000000100002225	testl	%edx, %edx
0000000100002227	je	0x10000224a
0000000100002229	cmpl	$0x1, %edx
000000010000222c	jne	0x10000223e
000000010000222e	movq	%rdi, %rbx
0000000100002231	movq	%rax, %rdi
0000000100002234	callq	_fwp_rc_free_obj
0000000100002239	movq	%rbx, %rdi
000000010000223c	jmp	0x10000224a
000000010000223e	cmpl	$0xff, %edx
0000000100002244	je	0x10000226d
0000000100002246	decb	%dl
0000000100002248	movb	%dl, (%rcx)
000000010000224a	addq	$0x8, %rsp
000000010000224e	popq	%rbx
000000010000224f	popq	%rbp
0000000100002250	jmp	_fwp_rc_free_obj
0000000100002255	movq	%rax, %rdi
0000000100002258	jmp	_fwp_rc_wide_drop
000000010000225d	movq	%rdi, %rbx
0000000100002260	movq	%rcx, %rdi
0000000100002263	callq	_fwp_rc_wide_drop
0000000100002268	jmp	0x100002191
000000010000226d	movq	%rdi, %rbx
0000000100002270	movq	%rcx, %rdi
0000000100002273	callq	_fwp_rc_wide_drop
0000000100002278	jmp	0x100002239
000000010000227a	nopw	(%rax,%rax)
_fwp_apply_borrowed:
0000000100002280	pushq	%rbp
0000000100002281	movq	%rsp, %rbp
0000000100002284	pushq	%r15
0000000100002286	pushq	%r14
0000000100002288	pushq	%r13
000000010000228a	pushq	%r12
000000010000228c	pushq	%rbx
000000010000228d	subq	$0xa8, %rsp
0000000100002294	movq	%rsi, %r13
0000000100002297	movq	%rdi, %rbx
000000010000229a	movq	_fwp_fns(%rip), %rcx
00000001000022a1	movl	(%rdi), %edx
00000001000022a3	shlq	$0x5, %rdx
00000001000022a7	movq	0x18(%rcx,%rdx), %rax
00000001000022ac	testq	%rax, %rax
00000001000022af	je	0x100002606
00000001000022b5	leaq	(%rcx,%rdx), %r12
00000001000022b9	leaq	(%rcx,%rdx), %r15
00000001000022bd	addq	$0x18, %r15
00000001000022c1	movl	$0x1, %r8d
00000001000022c7	xorl	%ecx, %ecx
00000001000022c9	nopl	(%rax)
00000001000022d0	testb	$0x1, %cl
00000001000022d3	movl	$0x0, %edx
00000001000022d8	cmovneq	%rbx, %rdx
00000001000022dc	movq	%rdx, -0xc8(%rbp)
00000001000022e3	movq	%r13, -0xc0(%rbp)
00000001000022ea	movq	%rax, -0xb8(%rbp)
00000001000022f1	movl	$0x0, -0xb0(%rbp)
00000001000022fb	movl	0x4(%rbx), %edx
00000001000022fe	movl	%edx, -0xac(%rbp)
0000000100002304	movq	%rbx, %rdx
0000000100002307	subq	0xad2a(%rip), %rdx
000000010000230e	movl	$0x0, -0xa8(%rbp)
0000000100002318	movq	0xad41(%rip), %rsi
000000010000231f	shlq	$0x10, %rsi
0000000100002323	cmpq	%rsi, %rdx
0000000100002326	movl	%r8d, -0x2c(%rbp)
000000010000232a	jae	0x100002370
000000010000232c	movq	0xad4d(%rip), %rsi
0000000100002333	movq	%rdx, %rdi
0000000100002336	shrq	$0x10, %rdi
000000010000233a	imulq	$0x1228, %rdi, %r8              ## imm = 0x1228
0000000100002341	leaq	(%rsi,%r8), %rdi
0000000100002345	movzbl	(%rsi,%r8), %esi
000000010000234a	cmpb	$0x2, %sil
000000010000234e	sete	%r9b
0000000100002352	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100002359	sete	%r8b
000000010000235d	andb	%r9b, %r8b
0000000100002360	cmpb	$0x1, %r8b
0000000100002364	jne	0x100002390
0000000100002366	leaq	0x228(%rdi), %r9
000000010000236d	jmp	0x1000023ac
000000010000236f	nop
0000000100002370	movl	$0x0, -0x30(%rbp)
0000000100002377	testb	$0x1, %cl
000000010000237a	je	0x100002460
0000000100002380	jmp	0x10000246a
0000000100002385	nopw	%cs:(%rax,%rax)
0000000100002390	cmpb	$0x1, %sil
0000000100002394	jne	0x10000240f
0000000100002396	movl	0x20(%rdi), %r9d
000000010000239a	imulq	%rdx, %r9
000000010000239e	shrq	$0x20, %r9
00000001000023a2	addq	%rdi, %r9
00000001000023a5	addq	$0x228, %r9                     ## imm = 0x228
00000001000023ac	cmpb	$0x0, (%r9)
00000001000023b0	setne	%r10b
00000001000023b4	je	0x1000023ee
00000001000023b6	movq	_fwp_cleanups(%rip), %r9
00000001000023bd	movq	%r9, -0xa0(%rbp)
00000001000023c4	leaq	_fwp_apply_release(%rip), %r9
00000001000023cb	movq	%r9, -0x98(%rbp)
00000001000023d2	leaq	-0xc8(%rbp), %r9
00000001000023d9	movq	%r9, -0x90(%rbp)
00000001000023e0	leaq	-0xa0(%rbp), %r9
00000001000023e7	movq	%r9, _fwp_cleanups(%rip)
00000001000023ee	testb	$0x1, %cl
00000001000023f1	movl	%r10d, -0x30(%rbp)
00000001000023f5	je	0x1000023fd
00000001000023f7	movl	-0x2c(%rbp), %r8d
00000001000023fb	jmp	0x10000246a
00000001000023fd	testb	%r8b, %r8b
0000000100002400	je	0x100002421
0000000100002402	addq	$0x228, %rdi                    ## imm = 0x228
0000000100002409	movl	-0x2c(%rbp), %r8d
000000010000240d	jmp	0x100002440
000000010000240f	movl	$0x0, -0x30(%rbp)
0000000100002416	testb	$0x1, %cl
0000000100002419	movl	-0x2c(%rbp), %r8d
000000010000241d	je	0x100002460
000000010000241f	jmp	0x10000246a
0000000100002421	cmpb	$0x1, %sil
0000000100002425	movl	-0x2c(%rbp), %r8d
0000000100002429	jne	0x100002460
000000010000242b	movl	0x20(%rdi), %eax
000000010000242e	imulq	%rax, %rdx
0000000100002432	shrq	$0x20, %rdx
0000000100002436	addq	%rdx, %rdi
0000000100002439	addq	$0x228, %rdi                    ## imm = 0x228
0000000100002440	movzbl	(%rdi), %eax
0000000100002443	testb	%al, %al
0000000100002445	je	0x100002460
0000000100002447	cmpb	$-0x2, %al
0000000100002449	jae	0x1000025f8
000000010000244f	incb	%al
0000000100002451	movb	%al, (%rdi)
0000000100002453	nopw	%cs:(%rax,%rax)
0000000100002460	movq	%rbx, -0xc8(%rbp)
0000000100002467	movq	(%r15), %rax
000000010000246a	movl	(%r12), %r12d
000000010000246e	subl	0x4(%rbx), %r12d
0000000100002472	cmpl	%r12d, %r8d
0000000100002475	movl	%r12d, -0x3c(%rbp)
0000000100002479	cmovbl	%r8d, %r12d
000000010000247d	movq	$0x0, -0x88(%rbp)
0000000100002488	movq	%r13, -0x80(%rbp)
000000010000248c	movq	%rax, -0x78(%rbp)
0000000100002490	movl	$0x0, -0x70(%rbp)
0000000100002497	movl	0x4(%rbx), %ecx
000000010000249a	movl	%ecx, -0x6c(%rbp)
000000010000249d	movl	$0x0, -0x68(%rbp)
00000001000024a4	movl	%r12d, %r14d
00000001000024a7	testl	%r12d, %r12d
00000001000024aa	je	0x100002540
00000001000024b0	movl	%r12d, -0x38(%rbp)
00000001000024b4	cmpq	$0x0, 0x18(%rax)
00000001000024b9	setne	%al
00000001000024bc	movl	%eax, -0x34(%rbp)
00000001000024bf	je	0x1000024ed
00000001000024c1	movq	_fwp_cleanups(%rip), %rax
00000001000024c8	movq	%rax, -0x60(%rbp)
00000001000024cc	leaq	_fwp_apply_release(%rip), %rax
00000001000024d3	movq	%rax, -0x58(%rbp)
00000001000024d7	leaq	-0x88(%rbp), %rax
00000001000024de	movq	%rax, -0x50(%rbp)
00000001000024e2	leaq	-0x60(%rbp), %rax
00000001000024e6	movq	%rax, _fwp_cleanups(%rip)
00000001000024ed	movq	%r13, -0x48(%rbp)
00000001000024f1	xorl	%r12d, %r12d
00000001000024f4	nopw	%cs:(%rax,%rax)
0000000100002500	movq	(%r15), %rax
0000000100002503	movl	0x4(%rbx), %esi
0000000100002506	addl	%r12d, %esi
0000000100002509	movq	%r13, %rdi
000000010000250c	movl	$0x1, %edx
0000000100002511	callq	*0x10(%rax)
0000000100002514	movl	-0x68(%rbp), %eax
0000000100002517	incl	%eax
0000000100002519	movl	%eax, -0x68(%rbp)
000000010000251c	incq	%r12
000000010000251f	addq	$0x8, %r13
0000000100002523	cmpq	%r12, %r14
0000000100002526	jne	0x100002500
0000000100002528	movq	-0x48(%rbp), %r13
000000010000252c	movl	-0x38(%rbp), %r12d
0000000100002530	movl	-0x34(%rbp), %r15d
0000000100002534	jmp	0x100002545
0000000100002536	nopw	%cs:(%rax,%rax)
0000000100002540	xorl	%r15d, %r15d
0000000100002543	xorl	%eax, %eax
0000000100002545	movl	%eax, -0x70(%rbp)
0000000100002548	movq	$0x0, -0xc8(%rbp)
0000000100002553	movl	$0x0, -0xb0(%rbp)
000000010000255d	movq	%rbx, %rdi
0000000100002560	movl	%r12d, %esi
0000000100002563	movq	%r13, %rdx
0000000100002566	callq	_fwp_apply_owned
000000010000256b	movq	%rax, %rbx
000000010000256e	testb	%r15b, %r15b
0000000100002571	movl	-0x2c(%rbp), %r8d
0000000100002575	je	0x100002593
0000000100002577	leaq	-0x60(%rbp), %rax
000000010000257b	cmpq	%rax, _fwp_cleanups(%rip)
0000000100002582	jne	0x10000276b
0000000100002588	movq	-0x60(%rbp), %rax
000000010000258c	movq	%rax, _fwp_cleanups(%rip)
0000000100002593	cmpb	$0x0, -0x30(%rbp)
0000000100002597	je	0x1000025bb
0000000100002599	leaq	-0xa0(%rbp), %rax
00000001000025a0	cmpq	%rax, _fwp_cleanups(%rip)
00000001000025a7	jne	0x10000276b
00000001000025ad	movq	-0xa0(%rbp), %rax
00000001000025b4	movq	%rax, _fwp_cleanups(%rip)
00000001000025bb	cmpl	-0x3c(%rbp), %r8d
00000001000025bf	jbe	0x100002756
00000001000025c5	leaq	(%r13,%r14,8), %r13
00000001000025ca	subl	%r12d, %r8d
00000001000025cd	movq	_fwp_fns(%rip), %rax
00000001000025d4	movl	(%rbx), %ecx
00000001000025d6	shlq	$0x5, %rcx
00000001000025da	leaq	(%rax,%rcx), %r12
00000001000025de	leaq	(%rax,%rcx), %r15
00000001000025e2	addq	$0x18, %r15
00000001000025e6	movq	0x18(%rax,%rcx), %rax
00000001000025eb	movb	$0x1, %cl
00000001000025ed	testq	%rax, %rax
00000001000025f0	jne	0x1000022d0
00000001000025f6	jmp	0x10000260c
00000001000025f8	callq	_fwp_rc_wide_dup
00000001000025fd	movl	-0x2c(%rbp), %r8d
0000000100002601	jmp	0x100002460
0000000100002606	movl	$0x1, %r8d
000000010000260c	movq	0xaa25(%rip), %rax
0000000100002613	movq	%rbx, %rdx
0000000100002616	subq	%rax, %rdx
0000000100002619	movq	0xaa40(%rip), %rcx
0000000100002620	shlq	$0x10, %rcx
0000000100002624	cmpq	%rcx, %rdx
0000000100002627	jae	0x10000269d
0000000100002629	movl	%r8d, %r10d
000000010000262c	movq	0xaa4d(%rip), %rdi
0000000100002633	movq	%rdx, %rsi
0000000100002636	shrq	$0x10, %rsi
000000010000263a	imulq	$0x1228, %rsi, %r8              ## imm = 0x1228
0000000100002641	leaq	(%rdi,%r8), %rsi
0000000100002645	movzbl	(%rdi,%r8), %edi
000000010000264a	cmpb	$0x2, %dil
000000010000264e	setne	%r8b
0000000100002652	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100002659	setne	%r9b
000000010000265d	orb	%r8b, %r9b
0000000100002660	jne	0x100002676
0000000100002662	addq	$0x228, %rsi                    ## imm = 0x228
0000000100002669	movl	%r10d, %r8d
000000010000266c	cmpb	$0x0, (%rsi)
000000010000266f	je	0x10000269d
0000000100002671	jmp	0x100002770
0000000100002676	cmpb	$0x1, %dil
000000010000267a	movl	%r10d, %r8d
000000010000267d	jne	0x10000269d
000000010000267f	movl	0x20(%rsi), %edi
0000000100002682	imulq	%rdi, %rdx
0000000100002686	shrq	$0x20, %rdx
000000010000268a	addq	%rdx, %rsi
000000010000268d	addq	$0x228, %rsi                    ## imm = 0x228
0000000100002694	cmpb	$0x0, (%rsi)
0000000100002697	jne	0x100002770
000000010000269d	movl	%r8d, %esi
00000001000026a0	testl	%r8d, %r8d
00000001000026a3	je	0x100002748
00000001000026a9	movq	0xa9d0(%rip), %rdx
00000001000026b0	movl	%esi, %r15d
00000001000026b3	xorl	%edi, %edi
00000001000026b5	jmp	0x1000026e0
00000001000026b7	nopw	(%rax,%rax)
00000001000026c0	addq	$0x228, %r9                     ## imm = 0x228
00000001000026c7	cmpb	$0x0, (%r9)
00000001000026cb	je	0x100002740
00000001000026cd	jmp	0x100002770
00000001000026d2	nopw	%cs:(%rax,%rax)
00000001000026e0	movq	(%r13,%rdi,8), %r8
00000001000026e5	subq	%rax, %r8
00000001000026e8	cmpq	%rcx, %r8
00000001000026eb	jae	0x100002740
00000001000026ed	movq	%r8, %r9
00000001000026f0	shrq	$0x10, %r9
00000001000026f4	imulq	$0x1228, %r9, %r10              ## imm = 0x1228
00000001000026fb	leaq	(%rdx,%r10), %r9
00000001000026ff	movzbl	(%rdx,%r10), %r10d
0000000100002704	cmpb	$0x2, %r10b
0000000100002708	setne	%r11b
000000010000270c	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100002713	setne	%r14b
0000000100002717	orb	%r11b, %r14b
000000010000271a	je	0x1000026c0
000000010000271c	cmpb	$0x1, %r10b
0000000100002720	jne	0x100002740
0000000100002722	movl	0x20(%r9), %r10d
0000000100002726	imulq	%r10, %r8
000000010000272a	shrq	$0x20, %r8
000000010000272e	addq	%r8, %r9
0000000100002731	addq	$0x228, %r9                     ## imm = 0x228
0000000100002738	cmpb	$0x0, (%r9)
000000010000273c	jne	0x100002770
000000010000273e	nop
0000000100002740	incq	%rdi
0000000100002743	cmpq	%rdi, %r15
0000000100002746	jne	0x1000026e0
0000000100002748	movq	%rbx, %rdi
000000010000274b	movq	%r13, %rdx
000000010000274e	callq	_fwp_apply
0000000100002753	movq	%rax, %rbx
0000000100002756	movq	%rbx, %rax
0000000100002759	addq	$0xa8, %rsp
0000000100002760	popq	%rbx
0000000100002761	popq	%r12
0000000100002763	popq	%r13
0000000100002765	popq	%r14
0000000100002767	popq	%r15
0000000100002769	popq	%rbp
000000010000276a	retq
000000010000276b	callq	0x100009770                     ## symbol stub for: _abort
0000000100002770	callq	_fwp_flush
0000000100002775	movq	0x88bc(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000277c	movq	(%rax), %rdi
000000010000277f	leaq	0x731e(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002786	leaq	0x72ea(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
000000010000278d	xorl	%eax, %eax
000000010000278f	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100002794	movl	$0x65, %edi
0000000100002799	callq	0x10000978e                     ## symbol stub for: _exit
000000010000279e	nop
_fwp_apply:
00000001000027a0	pushq	%rbp
00000001000027a1	movq	%rsp, %rbp
00000001000027a4	pushq	%r15
00000001000027a6	pushq	%r14
00000001000027a8	pushq	%r13
00000001000027aa	pushq	%r12
00000001000027ac	pushq	%rbx
00000001000027ad	subq	$0x38, %rsp
00000001000027b1	movq	%rdx, %rbx
00000001000027b4	movl	%esi, %r8d
00000001000027b7	movq	%rdi, %r15
00000001000027ba	movq	0x886f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000027c1	movq	(%rax), %rax
00000001000027c4	movq	%rax, -0x30(%rbp)
00000001000027c8	jmp	0x1000027ed
00000001000027ca	nopw	(%rax,%rax)
00000001000027d0	leaq	(%rbx,%r14,8), %rbx
00000001000027d4	xorl	%ecx, %ecx
00000001000027d6	movq	%rax, %r15
00000001000027d9	movq	-0x48(%rbp), %r14
00000001000027dd	movq	-0x50(%rbp), %rsp
00000001000027e1	movl	%edx, %r8d
00000001000027e4	cmpl	$0x1, %ecx
00000001000027e7	je	0x100002c96
00000001000027ed	movq	_fwp_fns(%rip), %rax
00000001000027f4	movl	(%r15), %ecx
00000001000027f7	movl	0x4(%r15), %r13d
00000001000027fb	shlq	$0x5, %rcx
00000001000027ff	leaq	(%rax,%rcx), %rdx
0000000100002803	movl	(%rax,%rcx), %r12d
0000000100002807	testq	%r13, %r13
000000010000280a	jne	0x100002850
000000010000280c	leal	-0x1(%r12), %eax
0000000100002811	cmpl	%r8d, %eax
0000000100002814	jae	0x100002850
0000000100002816	movq	%rbx, %rdi
0000000100002819	movq	%r8, %r15
000000010000281c	callq	*0x8(%rdx)
000000010000281f	movq	%r15, %r8
0000000100002822	movq	%rax, %r15
0000000100002825	cmpl	%r12d, %r8d
0000000100002828	je	0x100002aeb
000000010000282e	leaq	(%rbx,%r12,8), %rbx
0000000100002832	subl	%r12d, %r8d
0000000100002835	movl	$0x3, %ecx
000000010000283a	cmpl	$0x1, %ecx
000000010000283d	jne	0x1000027ed
000000010000283f	jmp	0x100002c96
0000000100002844	nopw	%cs:(%rax,%rax)
0000000100002850	movq	%r14, -0x48(%rbp)
0000000100002854	leal	(%r8,%r13), %r14d
0000000100002858	cmpl	%r12d, %r14d
000000010000285b	movq	%r8, -0x40(%rbp)
000000010000285f	jb	0x100002a8d
0000000100002865	movq	%rdx, -0x58(%rbp)
0000000100002869	movq	%rsp, -0x50(%rbp)
000000010000286d	movl	%r12d, %r14d
0000000100002870	cmpl	$0x2, %r12d
0000000100002874	movl	$0x1, %eax
0000000100002879	cmovael	%r12d, %eax
000000010000287d	shlq	$0x3, %rax
0000000100002881	callq	0x100009728                     ## symbol stub for: ____chkstk_darwin
0000000100002886	addq	$0xf, %rax
000000010000288a	andq	$-0x10, %rax
000000010000288e	subq	%rax, %rsp
0000000100002891	movq	%rsp, %rdi
0000000100002894	testq	%r13, %r13
0000000100002897	je	0x100002970
000000010000289d	cmpl	$0x3, %r13d
00000001000028a1	jbe	0x1000028b3
00000001000028a3	movq	%rdi, %rax
00000001000028a6	subq	%r15, %rax
00000001000028a9	addq	$-0x8, %rax
00000001000028ad	cmpq	$0x20, %rax
00000001000028b1	jae	0x100002922
00000001000028b3	xorl	%eax, %eax
00000001000028b5	movq	%r13, %rdx
00000001000028b8	movq	%rax, %rcx
00000001000028bb	andq	$0x3, %rdx
00000001000028bf	je	0x1000028e1
00000001000028c1	movq	%rax, %rcx
00000001000028c4	nopw	%cs:(%rax,%rax)
00000001000028d0	movq	0x8(%r15,%rcx,8), %rsi
00000001000028d5	movq	%rsi, (%rdi,%rcx,8)
00000001000028d9	incq	%rcx
00000001000028dc	decq	%rdx
00000001000028df	jne	0x1000028d0
00000001000028e1	subq	%r13, %rax
00000001000028e4	cmpq	$-0x4, %rax
00000001000028e8	ja	0x100002970
00000001000028ee	nop
00000001000028f0	movq	0x8(%r15,%rcx,8), %rax
00000001000028f5	movq	%rax, (%rdi,%rcx,8)
00000001000028f9	movq	0x10(%r15,%rcx,8), %rax
00000001000028fe	movq	%rax, 0x8(%rdi,%rcx,8)
0000000100002903	movq	0x18(%r15,%rcx,8), %rax
0000000100002908	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000290d	movq	0x20(%r15,%rcx,8), %rax
0000000100002912	movq	%rax, 0x18(%rdi,%rcx,8)
0000000100002917	addq	$0x4, %rcx
000000010000291b	cmpq	%rcx, %r13
000000010000291e	jne	0x1000028f0
0000000100002920	jmp	0x100002970
0000000100002922	movl	%r13d, %eax
0000000100002925	andl	$-0x4, %eax
0000000100002928	leaq	(,%r13,8), %rcx
0000000100002930	andq	$-0x20, %rcx
0000000100002934	xorl	%edx, %edx
0000000100002936	nopw	%cs:(%rax,%rax)
0000000100002940	movups	0x8(%r15,%rdx), %xmm0
0000000100002946	movups	0x18(%r15,%rdx), %xmm1
000000010000294c	movaps	%xmm0, (%rdi,%rdx)
0000000100002950	movaps	%xmm1, 0x10(%rdi,%rdx)
0000000100002955	addq	$0x20, %rdx
0000000100002959	cmpq	%rdx, %rcx
000000010000295c	jne	0x100002940
000000010000295e	cmpl	%r13d, %eax
0000000100002961	jne	0x1000028b5
0000000100002967	nopw	(%rax,%rax)
0000000100002970	subl	%r13d, %r14d
0000000100002973	movl	%r14d, -0x34(%rbp)
0000000100002977	movl	%r14d, %r14d
000000010000297a	cmpl	%r13d, %r12d
000000010000297d	je	0x100002a02
0000000100002983	cmpl	$0xd, -0x34(%rbp)
0000000100002987	ja	0x100002a27
000000010000298d	xorl	%eax, %eax
000000010000298f	movq	%r14, %rdx
0000000100002992	movq	%rax, %rcx
0000000100002995	andq	$0x3, %rdx
0000000100002999	je	0x1000029b4
000000010000299b	movq	%rax, %rcx
000000010000299e	nop
00000001000029a0	movq	(%rbx,%rcx,8), %rsi
00000001000029a4	leal	(%rcx,%r13), %r8d
00000001000029a8	movq	%rsi, (%rdi,%r8,8)
00000001000029ac	incq	%rcx
00000001000029af	decq	%rdx
00000001000029b2	jne	0x1000029a0
00000001000029b4	subq	%r14, %rax
00000001000029b7	cmpq	$-0x4, %rax
00000001000029bb	ja	0x100002a02
00000001000029bd	nopl	(%rax)
00000001000029c0	movq	(%rbx,%rcx,8), %rax
00000001000029c4	leal	(%rcx,%r13), %edx
00000001000029c8	movq	%rax, (%rdi,%rdx,8)
00000001000029cc	movq	0x8(%rbx,%rcx,8), %rax
00000001000029d1	leal	(%rcx,%r13), %edx
00000001000029d5	incl	%edx
00000001000029d7	movq	%rax, (%rdi,%rdx,8)
00000001000029db	movq	0x10(%rbx,%rcx,8), %rax
00000001000029e0	leal	0x2(%r13,%rcx), %edx
00000001000029e5	movq	%rax, (%rdi,%rdx,8)
00000001000029e9	movq	0x18(%rbx,%rcx,8), %rax
00000001000029ee	leal	(%rcx,%r13), %edx
00000001000029f2	addl	$0x3, %edx
00000001000029f5	movq	%rax, (%rdi,%rdx,8)
00000001000029f9	addq	$0x4, %rcx
00000001000029fd	cmpq	%rcx, %r14
0000000100002a00	jne	0x1000029c0
0000000100002a02	movq	-0x58(%rbp), %rax
0000000100002a06	callq	*0x8(%rax)
0000000100002a09	movl	$0x1, %ecx
0000000100002a0e	movq	-0x40(%rbp), %rsi
0000000100002a12	movl	%esi, %edx
0000000100002a14	subl	-0x34(%rbp), %edx
0000000100002a17	jne	0x1000027d0
0000000100002a1d	movl	%esi, %edx
0000000100002a1f	movq	%rax, %r14
0000000100002a22	jmp	0x1000027dd
0000000100002a27	leaq	-0x1(%r14), %rax
0000000100002a2b	movl	%eax, %ecx
0000000100002a2d	addl	%r13d, %ecx
0000000100002a30	jb	0x10000298d
0000000100002a36	shrq	$0x20, %rax
0000000100002a3a	movl	$0x0, %eax
0000000100002a3f	jne	0x10000298f
0000000100002a45	leaq	(%rdi,%r13,8), %rax
0000000100002a49	subq	%rbx, %rax
0000000100002a4c	cmpq	$0x20, %rax
0000000100002a50	jb	0x10000298d
0000000100002a56	movl	%r14d, %eax
0000000100002a59	andl	$-0x4, %eax
0000000100002a5c	xorl	%ecx, %ecx
0000000100002a5e	nop
0000000100002a60	movups	(%rbx,%rcx,8), %xmm0
0000000100002a64	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100002a69	leal	(%rcx,%r13), %edx
0000000100002a6d	movups	%xmm0, (%rdi,%rdx,8)
0000000100002a71	movups	%xmm1, 0x10(%rdi,%rdx,8)
0000000100002a76	addq	$0x4, %rcx
0000000100002a7a	cmpq	%rcx, %rax
0000000100002a7d	jne	0x100002a60
0000000100002a7f	cmpl	%r14d, %eax
0000000100002a82	jne	0x10000298f
0000000100002a88	jmp	0x100002a02
0000000100002a8d	movl	%r14d, %eax
0000000100002a90	cmpl	$0x7ff, %r14d                   ## imm = 0x7FF
0000000100002a97	ja	0x100002b03
0000000100002a99	leaq	(,%rax,8), %rdx
0000000100002aa1	addq	$0x17, %rdx
0000000100002aa5	shrq	$0x4, %rdx
0000000100002aa9	leaq	_fwp_gc(%rip), %rcx
0000000100002ab0	movzbl	0xbe8(%rdx,%rcx), %edx
0000000100002ab8	movl	0xb48(%rcx,%rdx,4), %esi
0000000100002abf	subq	%rsi, _fwp_gc(%rip)
0000000100002ac6	js	0x100002b03
0000000100002ac8	leaq	(%rdx,%rdx,2), %rdx
0000000100002acc	leaq	(%rcx,%rdx,8), %rcx
0000000100002ad0	addq	$0x788, %rcx                    ## imm = 0x788
0000000100002ad7	movq	(%rcx), %r12
0000000100002ada	testq	%r12, %r12
0000000100002add	je	0x100002af3
0000000100002adf	movq	(%r12), %rax
0000000100002ae3	notq	%rax
0000000100002ae6	movq	%rax, (%rcx)
0000000100002ae9	jmp	0x100002b22
0000000100002aeb	movq	%r15, %r14
0000000100002aee	jmp	0x100002c96
0000000100002af3	movq	0x8(%rcx), %r12
0000000100002af7	movq	0x10(%rcx), %rdx
0000000100002afb	subq	%r12, %rdx
0000000100002afe	cmpq	%rsi, %rdx
0000000100002b01	jae	0x100002b1a
0000000100002b03	leaq	0x8(,%rax,8), %rdi
0000000100002b0b	movl	$0x2, %esi
0000000100002b10	callq	_fwp_gc_alloc_slow
0000000100002b15	movq	%rax, %r12
0000000100002b18	jmp	0x100002b2a
0000000100002b1a	leaq	(%r12,%rsi), %rax
0000000100002b1e	movq	%rax, 0x8(%rcx)
0000000100002b22	movq	%r12, %rdi
0000000100002b25	callq	0x10000972e                     ## symbol stub for: ___bzero
0000000100002b2a	movl	(%r15), %eax
0000000100002b2d	movl	%eax, (%r12)
0000000100002b31	movl	%r14d, 0x4(%r12)
0000000100002b36	testq	%r13, %r13
0000000100002b39	movq	%r12, %r14
0000000100002b3c	movq	-0x40(%rbp), %rdi
0000000100002b40	je	0x100002c01
0000000100002b46	xorl	%eax, %eax
0000000100002b48	cmpl	$0x6, %r13d
0000000100002b4c	jb	0x100002b96
0000000100002b4e	movq	%r14, %rcx
0000000100002b51	subq	%r15, %rcx
0000000100002b54	cmpq	$0x1f, %rcx
0000000100002b58	jbe	0x100002b96
0000000100002b5a	movl	%r13d, %eax
0000000100002b5d	andl	$-0x4, %eax
0000000100002b60	leaq	(,%r13,8), %rcx
0000000100002b68	andq	$-0x20, %rcx
0000000100002b6c	xorl	%edx, %edx
0000000100002b6e	nop
0000000100002b70	movups	0x8(%r15,%rdx), %xmm0
0000000100002b76	movups	0x18(%r15,%rdx), %xmm1
0000000100002b7c	movups	%xmm0, 0x8(%r14,%rdx)
0000000100002b82	movups	%xmm1, 0x18(%r14,%rdx)
0000000100002b88	addq	$0x20, %rdx
0000000100002b8c	cmpq	%rdx, %rcx
0000000100002b8f	jne	0x100002b70
0000000100002b91	cmpl	%r13d, %eax
0000000100002b94	je	0x100002c01
0000000100002b96	movq	%r13, %rdx
0000000100002b99	movq	%rax, %rcx
0000000100002b9c	andq	$0x3, %rdx
0000000100002ba0	je	0x100002bc2
0000000100002ba2	movq	%rax, %rcx
0000000100002ba5	nopw	%cs:(%rax,%rax)
0000000100002bb0	movq	0x8(%r15,%rcx,8), %rsi
0000000100002bb5	movq	%rsi, 0x8(%r14,%rcx,8)
0000000100002bba	incq	%rcx
0000000100002bbd	decq	%rdx
0000000100002bc0	jne	0x100002bb0
0000000100002bc2	subq	%r13, %rax
0000000100002bc5	cmpq	$-0x4, %rax
0000000100002bc9	ja	0x100002c01
0000000100002bcb	nopl	(%rax,%rax)
0000000100002bd0	movq	0x8(%r15,%rcx,8), %rax
0000000100002bd5	movq	%rax, 0x8(%r14,%rcx,8)
0000000100002bda	movq	0x10(%r15,%rcx,8), %rax
0000000100002bdf	movq	%rax, 0x10(%r14,%rcx,8)
0000000100002be4	movq	0x18(%r15,%rcx,8), %rax
0000000100002be9	movq	%rax, 0x18(%r14,%rcx,8)
0000000100002bee	movq	0x20(%r15,%rcx,8), %rax
0000000100002bf3	movq	%rax, 0x20(%r14,%rcx,8)
0000000100002bf8	addq	$0x4, %rcx
0000000100002bfc	cmpq	%rcx, %r13
0000000100002bff	jne	0x100002bd0
0000000100002c01	testl	%edi, %edi
0000000100002c03	je	0x100002c96
0000000100002c09	movl	%edi, %eax
0000000100002c0b	cmpl	$0x13, %edi
0000000100002c0e	ja	0x100002cb8
0000000100002c14	xorl	%ecx, %ecx
0000000100002c16	movq	%rax, %rsi
0000000100002c19	movq	%rcx, %rdx
0000000100002c1c	andq	$0x3, %rsi
0000000100002c20	je	0x100002c45
0000000100002c22	movq	%rcx, %rdx
0000000100002c25	nopw	%cs:(%rax,%rax)
0000000100002c30	movq	(%rbx,%rdx,8), %rdi
0000000100002c34	leal	(%rdx,%r13), %r8d
0000000100002c38	movq	%rdi, 0x8(%r14,%r8,8)
0000000100002c3d	incq	%rdx
0000000100002c40	decq	%rsi
0000000100002c43	jne	0x100002c30
0000000100002c45	subq	%rax, %rcx
0000000100002c48	cmpq	$-0x4, %rcx
0000000100002c4c	ja	0x100002c96
0000000100002c4e	nop
0000000100002c50	movq	(%rbx,%rdx,8), %rcx
0000000100002c54	leal	(%rdx,%r13), %esi
0000000100002c58	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002c5d	movq	0x8(%rbx,%rdx,8), %rcx
0000000100002c62	leal	(%rdx,%r13), %esi
0000000100002c66	incl	%esi
0000000100002c68	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002c6d	movq	0x10(%rbx,%rdx,8), %rcx
0000000100002c72	leal	0x2(%r13,%rdx), %esi
0000000100002c77	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002c7c	movq	0x18(%rbx,%rdx,8), %rcx
0000000100002c81	leal	(%rdx,%r13), %esi
0000000100002c85	addl	$0x3, %esi
0000000100002c88	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002c8d	addq	$0x4, %rdx
0000000100002c91	cmpq	%rdx, %rax
0000000100002c94	jne	0x100002c50
0000000100002c96	movq	0x8393(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100002c9d	movq	(%rax), %rax
0000000100002ca0	cmpq	-0x30(%rbp), %rax
0000000100002ca4	jne	0x100002d1f
0000000100002ca6	movq	%r14, %rax
0000000100002ca9	leaq	-0x28(%rbp), %rsp
0000000100002cad	popq	%rbx
0000000100002cae	popq	%r12
0000000100002cb0	popq	%r13
0000000100002cb2	popq	%r14
0000000100002cb4	popq	%r15
0000000100002cb6	popq	%rbp
0000000100002cb7	retq
0000000100002cb8	leaq	-0x1(%rax), %rdx
0000000100002cbc	xorl	%ecx, %ecx
0000000100002cbe	movl	%edx, %esi
0000000100002cc0	addl	%r13d, %esi
0000000100002cc3	jb	0x100002c16
0000000100002cc9	shrq	$0x20, %rdx
0000000100002ccd	jne	0x100002c16
0000000100002cd3	leaq	(%r14,%r13,8), %rcx
0000000100002cd7	subq	%rbx, %rcx
0000000100002cda	addq	$0x8, %rcx
0000000100002cde	cmpq	$0x20, %rcx
0000000100002ce2	jb	0x100002c14
0000000100002ce8	movl	%eax, %ecx
0000000100002cea	andl	$-0x4, %ecx
0000000100002ced	xorl	%edx, %edx
0000000100002cef	nop
0000000100002cf0	movups	(%rbx,%rdx,8), %xmm0
0000000100002cf4	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100002cf9	leal	(%rdx,%r13), %esi
0000000100002cfd	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100002d03	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100002d09	addq	$0x4, %rdx
0000000100002d0d	cmpq	%rdx, %rcx
0000000100002d10	jne	0x100002cf0
0000000100002d12	cmpl	%eax, %ecx
0000000100002d14	jne	0x100002c16
0000000100002d1a	jmp	0x100002c96
0000000100002d1f	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100002d24	nopw	%cs:(%rax,%rax)
_fwp_apply_release:
0000000100002d30	pushq	%rbp
0000000100002d31	movq	%rsp, %rbp
0000000100002d34	pushq	%r14
0000000100002d36	pushq	%rbx
0000000100002d37	movq	(%rdi), %rbx
0000000100002d3a	movq	$0x0, (%rdi)
0000000100002d41	movl	0x20(%rdi), %eax
0000000100002d44	movl	0x18(%rdi), %ecx
0000000100002d47	movl	%eax, %edx
0000000100002d49	subl	%ecx, %edx
0000000100002d4b	je	0x100002d7a
0000000100002d4d	movq	0x10(%rdi), %rsi
0000000100002d51	movq	0x18(%rsi), %r8
0000000100002d55	testq	%r8, %r8
0000000100002d58	je	0x100002d7a
0000000100002d5a	movq	%rcx, %rax
0000000100002d5d	shlq	$0x3, %rax
0000000100002d61	addq	0x8(%rdi), %rax
0000000100002d65	movl	0x1c(%rdi), %esi
0000000100002d68	addl	%ecx, %esi
0000000100002d6a	movq	%rdi, %r14
0000000100002d6d	movq	%rax, %rdi
0000000100002d70	callq	*%r8
0000000100002d73	movq	%r14, %rdi
0000000100002d76	movl	0x20(%r14), %eax
0000000100002d7a	movl	%eax, 0x18(%rdi)
0000000100002d7d	testq	%rbx, %rbx
0000000100002d80	je	0x100002d8e
0000000100002d82	movq	%rbx, %rdi
0000000100002d85	popq	%rbx
0000000100002d86	popq	%r14
0000000100002d88	popq	%rbp
0000000100002d89	jmp	_fwp_closure_drop
0000000100002d8e	popq	%rbx
0000000100002d8f	popq	%r14
0000000100002d91	popq	%rbp
0000000100002d92	retq
0000000100002d93	nopw	%cs:(%rax,%rax)
_fwp_apply_owned:
0000000100002da0	pushq	%rbp
0000000100002da1	movq	%rsp, %rbp
0000000100002da4	pushq	%r15
0000000100002da6	pushq	%r14
0000000100002da8	pushq	%r13
0000000100002daa	pushq	%r12
0000000100002dac	pushq	%rbx
0000000100002dad	subq	$0xa8, %rsp
0000000100002db4	movq	%rdx, %rbx
0000000100002db7	movl	%esi, %r13d
0000000100002dba	movq	0x826f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100002dc1	movq	(%rax), %rax
0000000100002dc4	movq	%rax, -0x30(%rbp)
0000000100002dc8	movq	_fwp_fns(%rip), %rdx
0000000100002dcf	movl	(%rdi), %esi
0000000100002dd1	shlq	$0x5, %rsi
0000000100002dd5	movq	0x18(%rdx,%rsi), %rax
0000000100002dda	testq	%rax, %rax
0000000100002ddd	je	0x1000031f5
0000000100002de3	leaq	(%rdx,%rsi), %rcx
0000000100002de7	addq	%rdx, %rsi
0000000100002dea	addq	$0x18, %rsi
0000000100002dee	movq	%rdi, %r12
0000000100002df1	nopw	%cs:(%rax,%rax)
0000000100002e00	movq	%rsi, -0x58(%rbp)
0000000100002e04	movl	(%rcx), %r15d
0000000100002e07	movl	0x4(%r12), %r14d
0000000100002e0c	movq	%rdi, -0xb0(%rbp)
0000000100002e13	movq	%rbx, -0xa8(%rbp)
0000000100002e1a	movq	%rax, -0xa0(%rbp)
0000000100002e21	movl	$0x0, -0x98(%rbp)
0000000100002e2b	movl	%r14d, -0x94(%rbp)
0000000100002e32	movq	%rdi, %rcx
0000000100002e35	subq	0xa1fc(%rip), %rcx
0000000100002e3c	movl	%r13d, -0x90(%rbp)
0000000100002e43	movq	0xa216(%rip), %rdx
0000000100002e4a	shlq	$0x10, %rdx
0000000100002e4e	cmpq	%rdx, %rcx
0000000100002e51	jae	0x100002ec0
0000000100002e53	movq	0xa226(%rip), %rsi
0000000100002e5a	movq	%rcx, %rdx
0000000100002e5d	shrq	$0x10, %rdx
0000000100002e61	imulq	$0x1228, %rdx, %r8              ## imm = 0x1228
0000000100002e68	leaq	(%rsi,%r8), %rdx
0000000100002e6c	movzbl	(%rsi,%r8), %esi
0000000100002e71	cmpb	$0x2, %sil
0000000100002e75	setne	%r9b
0000000100002e79	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100002e80	setne	%r8b
0000000100002e84	orb	%r9b, %r8b
0000000100002e87	jne	0x100002ea0
0000000100002e89	addq	$0x228, %rdx                    ## imm = 0x228
0000000100002e90	cmpb	$0x0, (%rdx)
0000000100002e93	jne	0x100002ee0
0000000100002e95	jmp	0x100002ec0
0000000100002e97	nopw	(%rax,%rax)
0000000100002ea0	cmpb	$0x1, %sil
0000000100002ea4	jne	0x100002ec0
0000000100002ea6	movl	0x20(%rdx), %esi
0000000100002ea9	imulq	%rsi, %rcx
0000000100002ead	shrq	$0x20, %rcx
0000000100002eb1	addq	%rcx, %rdx
0000000100002eb4	addq	$0x228, %rdx                    ## imm = 0x228
0000000100002ebb	cmpb	$0x0, (%rdx)
0000000100002ebe	jne	0x100002ee0
0000000100002ec0	cmpq	$0x0, 0x18(%rax)
0000000100002ec5	je	0x100002ed1
0000000100002ec7	testq	%r14, %r14
0000000100002eca	jne	0x100002ee0
0000000100002ecc	cmpl	%r15d, %r13d
0000000100002ecf	jne	0x100002ee0
0000000100002ed1	xorl	%ecx, %ecx
0000000100002ed3	jmp	0x100002f0e
0000000100002ed5	nopw	%cs:(%rax,%rax)
0000000100002ee0	movq	_fwp_cleanups(%rip), %rcx
0000000100002ee7	movq	%rcx, -0x80(%rbp)
0000000100002eeb	leaq	_fwp_apply_release(%rip), %rcx
0000000100002ef2	movq	%rcx, -0x78(%rbp)
0000000100002ef6	leaq	-0xb0(%rbp), %rcx
0000000100002efd	movq	%rcx, -0x70(%rbp)
0000000100002f01	leaq	-0x80(%rbp), %rcx
0000000100002f05	movq	%rcx, _fwp_cleanups(%rip)
0000000100002f0c	movb	$0x1, %cl
0000000100002f0e	movq	%r13, -0x50(%rbp)
0000000100002f12	addl	%r14d, %r13d
0000000100002f15	cmpl	%r15d, %r13d
0000000100002f18	movq	%rdi, -0x40(%rbp)
0000000100002f1c	movl	%ecx, -0x44(%rbp)
0000000100002f1f	jb	0x100003268
0000000100002f25	movl	%r15d, %ecx
0000000100002f28	subl	%r14d, %ecx
0000000100002f2b	movl	%ecx, -0x34(%rbp)
0000000100002f2e	movl	%ecx, %ecx
0000000100002f30	movq	%rcx, -0x60(%rbp)
0000000100002f34	testq	%r14, %r14
0000000100002f37	jne	0x100002f60
0000000100002f39	testl	%r15d, %r15d
0000000100002f3c	je	0x100002f60
0000000100002f3e	movl	-0x34(%rbp), %ecx
0000000100002f41	movl	%ecx, -0x98(%rbp)
0000000100002f47	movq	%rbx, %rdi
0000000100002f4a	callq	*(%rax)
0000000100002f4c	movq	%rax, %r12
0000000100002f4f	movq	-0x60(%rbp), %r15
0000000100002f53	jmp	0x10000318a
0000000100002f58	nopl	(%rax,%rax)
0000000100002f60	movq	%rsp, -0x88(%rbp)
0000000100002f67	testl	%r15d, %r15d
0000000100002f6a	movl	$0x1, %eax
0000000100002f6f	cmovnel	%r15d, %eax
0000000100002f73	shlq	$0x3, %rax
0000000100002f77	callq	0x100009728                     ## symbol stub for: ____chkstk_darwin
0000000100002f7c	addq	$0xf, %rax
0000000100002f80	andq	$-0x10, %rax
0000000100002f84	subq	%rax, %rsp
0000000100002f87	movq	%rsp, %r13
0000000100002f8a	testq	%r14, %r14
0000000100002f8d	movq	-0x40(%rbp), %rdi
0000000100002f91	je	0x100003060
0000000100002f97	cmpl	$0x3, %r14d
0000000100002f9b	jbe	0x100002fad
0000000100002f9d	movq	%r13, %rax
0000000100002fa0	subq	%r12, %rax
0000000100002fa3	addq	$-0x8, %rax
0000000100002fa7	cmpq	$0x20, %rax
0000000100002fab	jae	0x100003013
0000000100002fad	xorl	%eax, %eax
0000000100002faf	movq	%r14, %rdx
0000000100002fb2	movq	%rax, %rcx
0000000100002fb5	andq	$0x3, %rdx
0000000100002fb9	je	0x100002fd2
0000000100002fbb	movq	%rax, %rcx
0000000100002fbe	nop
0000000100002fc0	movq	0x8(%r12,%rcx,8), %rsi
0000000100002fc5	movq	%rsi, (%r13,%rcx,8)
0000000100002fca	incq	%rcx
0000000100002fcd	decq	%rdx
0000000100002fd0	jne	0x100002fc0
0000000100002fd2	subq	%r14, %rax
0000000100002fd5	cmpq	$-0x4, %rax
0000000100002fd9	ja	0x100003060
0000000100002fdf	nop
0000000100002fe0	movq	0x8(%r12,%rcx,8), %rax
0000000100002fe5	movq	%rax, (%r13,%rcx,8)
0000000100002fea	movq	0x10(%r12,%rcx,8), %rax
0000000100002fef	movq	%rax, 0x8(%r13,%rcx,8)
0000000100002ff4	movq	0x18(%r12,%rcx,8), %rax
0000000100002ff9	movq	%rax, 0x10(%r13,%rcx,8)
0000000100002ffe	movq	0x20(%r12,%rcx,8), %rax
0000000100003003	movq	%rax, 0x18(%r13,%rcx,8)
0000000100003008	addq	$0x4, %rcx
000000010000300c	cmpq	%rcx, %r14
000000010000300f	jne	0x100002fe0
0000000100003011	jmp	0x100003060
0000000100003013	movl	%r14d, %eax
0000000100003016	andl	$-0x4, %eax
0000000100003019	leaq	(,%r14,8), %rcx
0000000100003021	andq	$-0x20, %rcx
0000000100003025	xorl	%edx, %edx
0000000100003027	nopw	(%rax,%rax)
0000000100003030	movups	0x8(%r12,%rdx), %xmm0
0000000100003036	movups	0x18(%r12,%rdx), %xmm1
000000010000303c	movaps	%xmm0, (%r13,%rdx)
0000000100003042	movaps	%xmm1, 0x10(%r13,%rdx)
0000000100003048	addq	$0x20, %rdx
000000010000304c	cmpq	%rdx, %rcx
000000010000304f	jne	0x100003030
0000000100003051	cmpl	%r14d, %eax
0000000100003054	jne	0x100002faf
000000010000305a	nopw	(%rax,%rax)
0000000100003060	cmpl	%r14d, %r15d
0000000100003063	movq	-0x60(%rbp), %r15
0000000100003067	je	0x100003160
000000010000306d	cmpl	$0x9, -0x34(%rbp)
0000000100003071	ja	0x100003108
0000000100003077	xorl	%eax, %eax
0000000100003079	movq	%r15, %rdx
000000010000307c	movq	%rax, %rcx
000000010000307f	andq	$0x3, %rdx
0000000100003083	je	0x1000030a5
0000000100003085	movq	%rax, %rcx
0000000100003088	nopl	(%rax,%rax)
0000000100003090	movq	(%rbx,%rcx,8), %rsi
0000000100003094	leal	(%r14,%rcx), %r8d
0000000100003098	movq	%rsi, (%r13,%r8,8)
000000010000309d	incq	%rcx
00000001000030a0	decq	%rdx
00000001000030a3	jne	0x100003090
00000001000030a5	subq	%r15, %rax
00000001000030a8	cmpq	$-0x4, %rax
00000001000030ac	ja	0x100003160
00000001000030b2	nopw	%cs:(%rax,%rax)
00000001000030c0	movq	(%rbx,%rcx,8), %rax
00000001000030c4	leal	(%r14,%rcx), %edx
00000001000030c8	movq	%rax, (%r13,%rdx,8)
00000001000030cd	movq	0x8(%rbx,%rcx,8), %rax
00000001000030d2	leal	(%r14,%rcx), %edx
00000001000030d6	incl	%edx
00000001000030d8	movq	%rax, (%r13,%rdx,8)
00000001000030dd	movq	0x10(%rbx,%rcx,8), %rax
00000001000030e2	leal	0x2(%r14,%rcx), %edx
00000001000030e7	movq	%rax, (%r13,%rdx,8)
00000001000030ec	movq	0x18(%rbx,%rcx,8), %rax
00000001000030f1	leal	(%r14,%rcx), %edx
00000001000030f5	addl	$0x3, %edx
00000001000030f8	movq	%rax, (%r13,%rdx,8)
00000001000030fd	addq	$0x4, %rcx
0000000100003101	cmpq	%rcx, %r15
0000000100003104	jne	0x1000030c0
0000000100003106	jmp	0x100003160
0000000100003108	leaq	-0x1(%r15), %rax
000000010000310c	movl	%eax, %ecx
000000010000310e	addl	%r14d, %ecx
0000000100003111	jb	0x100003077
0000000100003117	shrq	$0x20, %rax
000000010000311b	movl	$0x0, %eax
0000000100003120	jne	0x100003079
0000000100003126	movl	%r15d, %eax
0000000100003129	andl	$-0x4, %eax
000000010000312c	xorl	%ecx, %ecx
000000010000312e	nop
0000000100003130	movups	(%rbx,%rcx,8), %xmm0
0000000100003134	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100003139	leal	(%r14,%rcx), %edx
000000010000313d	movups	%xmm0, (%r13,%rdx,8)
0000000100003143	movups	%xmm1, 0x10(%r13,%rdx,8)
0000000100003149	addq	$0x4, %rcx
000000010000314d	cmpq	%rcx, %rax
0000000100003150	jne	0x100003130
0000000100003152	cmpl	%r15d, %eax
0000000100003155	jne	0x100003079
000000010000315b	nopl	(%rax,%rax)
0000000100003160	movq	-0x58(%rbp), %r14
0000000100003164	movq	(%r14), %rax
0000000100003167	movl	$0x1, %esi
000000010000316c	callq	*0x8(%rax)
000000010000316f	movl	-0x34(%rbp), %eax
0000000100003172	movl	%eax, -0x98(%rbp)
0000000100003178	movq	(%r14), %rax
000000010000317b	movq	%r13, %rdi
000000010000317e	callq	*(%rax)
0000000100003180	movq	%rax, %r12
0000000100003183	movq	-0x88(%rbp), %rsp
000000010000318a	cmpb	$0x0, -0x44(%rbp)
000000010000318e	movq	-0x50(%rbp), %r13
0000000100003192	movq	-0x40(%rbp), %rdi
0000000100003196	je	0x1000031b4
0000000100003198	leaq	-0x80(%rbp), %rax
000000010000319c	cmpq	%rax, _fwp_cleanups(%rip)
00000001000031a3	jne	0x100003754
00000001000031a9	movq	-0x80(%rbp), %rax
00000001000031ad	movq	%rax, _fwp_cleanups(%rip)
00000001000031b4	callq	_fwp_closure_drop
00000001000031b9	subl	-0x34(%rbp), %r13d
00000001000031bd	je	0x100003732
00000001000031c3	leaq	(%rbx,%r15,8), %rbx
00000001000031c7	movq	_fwp_fns(%rip), %rax
00000001000031ce	movl	(%r12), %edx
00000001000031d2	shlq	$0x5, %rdx
00000001000031d6	leaq	(%rax,%rdx), %rcx
00000001000031da	leaq	(%rax,%rdx), %rsi
00000001000031de	addq	$0x18, %rsi
00000001000031e2	movq	0x18(%rax,%rdx), %rax
00000001000031e7	movq	%r12, %rdi
00000001000031ea	testq	%rax, %rax
00000001000031ed	jne	0x100002e00
00000001000031f3	jmp	0x1000031f8
00000001000031f5	movq	%rdi, %r12
00000001000031f8	movq	0x9e39(%rip), %rax
00000001000031ff	movq	%r12, %rdx
0000000100003202	subq	%rax, %rdx
0000000100003205	movq	0x9e54(%rip), %rcx
000000010000320c	shlq	$0x10, %rcx
0000000100003210	cmpq	%rcx, %rdx
0000000100003213	jae	0x10000331e
0000000100003219	movq	0x9e60(%rip), %rdi
0000000100003220	movq	%rdx, %rsi
0000000100003223	shrq	$0x10, %rsi
0000000100003227	imulq	$0x1228, %rsi, %r8              ## imm = 0x1228
000000010000322e	leaq	(%rdi,%r8), %rsi
0000000100003232	movzbl	(%rdi,%r8), %edi
0000000100003237	cmpb	$0x2, %dil
000000010000323b	setne	%r8b
000000010000323f	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100003246	setne	%r9b
000000010000324a	orb	%r8b, %r9b
000000010000324d	jne	0x1000032fa
0000000100003253	addq	$0x228, %rsi                    ## imm = 0x228
000000010000325a	cmpb	$0x0, (%rsi)
000000010000325d	je	0x10000331e
0000000100003263	jmp	0x1000033b6
0000000100003268	movl	%r13d, %eax
000000010000326b	leaq	0x8(,%rax,8), %rdi
0000000100003273	callq	_fwp_alloc_init
0000000100003278	movq	-0x40(%rbp), %rdi
000000010000327c	movq	%rax, %r15
000000010000327f	movl	(%r12), %eax
0000000100003283	movl	%eax, (%r15)
0000000100003286	movl	%r13d, 0x4(%r15)
000000010000328a	movq	%r15, %rax
000000010000328d	subq	0x9da4(%rip), %rax
0000000100003294	movq	0x9dc5(%rip), %rcx
000000010000329b	shlq	$0x10, %rcx
000000010000329f	cmpq	%rcx, %rax
00000001000032a2	jae	0x100003431
00000001000032a8	movq	0x9dd1(%rip), %rcx
00000001000032af	movq	%rax, %rdx
00000001000032b2	shrq	$0x10, %rdx
00000001000032b6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000032bd	leaq	(%rcx,%rdx), %r13
00000001000032c1	movzbl	(%rcx,%rdx), %ecx
00000001000032c5	cmpb	$0x2, %cl
00000001000032c8	setne	%dl
00000001000032cb	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000032d1	setne	%sil
00000001000032d5	orb	%dl, %sil
00000001000032d8	jne	0x1000033fa
00000001000032de	addq	$0x228, %r13                    ## imm = 0x228
00000001000032e5	cmpb	$-0x1, (%r13)
00000001000032ea	je	0x100003420
00000001000032f0	movb	$0x1, (%r13)
00000001000032f5	jmp	0x100003431
00000001000032fa	cmpb	$0x1, %dil
00000001000032fe	jne	0x10000331e
0000000100003300	movl	0x20(%rsi), %edi
0000000100003303	imulq	%rdi, %rdx
0000000100003307	shrq	$0x20, %rdx
000000010000330b	addq	%rdx, %rsi
000000010000330e	addq	$0x228, %rsi                    ## imm = 0x228
0000000100003315	cmpb	$0x0, (%rsi)
0000000100003318	jne	0x1000033b6
000000010000331e	testl	%r13d, %r13d
0000000100003321	je	0x1000033e4
0000000100003327	movq	0x9d52(%rip), %rdx
000000010000332e	movl	%r13d, %esi
0000000100003331	xorl	%edi, %edi
0000000100003333	jmp	0x100003359
0000000100003335	nopw	%cs:(%rax,%rax)
0000000100003340	addq	$0x228, %r9                     ## imm = 0x228
0000000100003347	cmpb	$0x0, (%r9)
000000010000334b	jne	0x1000033b6
000000010000334d	incq	%rdi
0000000100003350	cmpq	%rdi, %rsi
0000000100003353	je	0x1000033e4
0000000100003359	movq	(%rbx,%rdi,8), %r8
000000010000335d	subq	%rax, %r8
0000000100003360	cmpq	%rcx, %r8
0000000100003363	jae	0x10000334d
0000000100003365	movq	%r8, %r9
0000000100003368	shrq	$0x10, %r9
000000010000336c	imulq	$0x1228, %r9, %r10              ## imm = 0x1228
0000000100003373	leaq	(%rdx,%r10), %r9
0000000100003377	movzbl	(%rdx,%r10), %r10d
000000010000337c	cmpb	$0x2, %r10b
0000000100003380	setne	%r11b
0000000100003384	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000338b	setne	%r14b
000000010000338f	orb	%r11b, %r14b
0000000100003392	je	0x100003340
0000000100003394	cmpb	$0x1, %r10b
0000000100003398	jne	0x10000334d
000000010000339a	movl	0x20(%r9), %r10d
000000010000339e	imulq	%r10, %r8
00000001000033a2	shrq	$0x20, %r8
00000001000033a6	addq	%r8, %r9
00000001000033a9	addq	$0x228, %r9                     ## imm = 0x228
00000001000033b0	cmpb	$0x0, (%r9)
00000001000033b4	je	0x10000334d
00000001000033b6	callq	_fwp_flush
00000001000033bb	movq	0x7c76(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000033c2	movq	(%rax), %rdi
00000001000033c5	leaq	0x66d8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000033cc	leaq	0x66a4(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
00000001000033d3	xorl	%eax, %eax
00000001000033d5	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000033da	movl	$0x65, %edi
00000001000033df	callq	0x10000978e                     ## symbol stub for: _exit
00000001000033e4	movq	%r12, %rdi
00000001000033e7	movl	%r13d, %esi
00000001000033ea	movq	%rbx, %rdx
00000001000033ed	callq	_fwp_apply
00000001000033f2	movq	%rax, %r12
00000001000033f5	jmp	0x100003732
00000001000033fa	cmpb	$0x1, %cl
00000001000033fd	jne	0x100003431
00000001000033ff	movl	0x20(%r13), %ecx
0000000100003403	imulq	%rcx, %rax
0000000100003407	shrq	$0x20, %rax
000000010000340b	addq	%rax, %r13
000000010000340e	addq	$0x228, %r13                    ## imm = 0x228
0000000100003415	cmpb	$-0x1, (%r13)
000000010000341a	jne	0x1000032f0
0000000100003420	movq	%r13, %rdi
0000000100003423	callq	_fwp_rc_forget_slot
0000000100003428	movq	-0x40(%rbp), %rdi
000000010000342c	jmp	0x1000032f0
0000000100003431	movq	%r15, -0x68(%rbp)
0000000100003435	movq	_fwp_cleanups(%rip), %rax
000000010000343c	movq	%rax, -0xc8(%rbp)
0000000100003443	leaq	_fwp_rc_cleanup_cell(%rip), %rax
000000010000344a	movq	%rax, -0xc0(%rbp)
0000000100003451	leaq	-0x68(%rbp), %rax
0000000100003455	movq	%rax, -0xb8(%rbp)
000000010000345c	leaq	-0xc8(%rbp), %r13
0000000100003463	movq	%r13, _fwp_cleanups(%rip)
000000010000346a	testq	%r14, %r14
000000010000346d	je	0x100003531
0000000100003473	xorl	%eax, %eax
0000000100003475	cmpl	$0x6, %r14d
0000000100003479	jb	0x1000034c6
000000010000347b	movq	%r15, %rcx
000000010000347e	subq	%r12, %rcx
0000000100003481	cmpq	$0x1f, %rcx
0000000100003485	jbe	0x1000034c6
0000000100003487	movl	%r14d, %eax
000000010000348a	andl	$-0x4, %eax
000000010000348d	leaq	(,%r14,8), %rcx
0000000100003495	andq	$-0x20, %rcx
0000000100003499	xorl	%edx, %edx
000000010000349b	nopl	(%rax,%rax)
00000001000034a0	movups	0x8(%r12,%rdx), %xmm0
00000001000034a6	movups	0x18(%r12,%rdx), %xmm1
00000001000034ac	movups	%xmm0, 0x8(%r15,%rdx)
00000001000034b2	movups	%xmm1, 0x18(%r15,%rdx)
00000001000034b8	addq	$0x20, %rdx
00000001000034bc	cmpq	%rdx, %rcx
00000001000034bf	jne	0x1000034a0
00000001000034c1	cmpl	%r14d, %eax
00000001000034c4	je	0x100003531
00000001000034c6	movq	%r14, %rdx
00000001000034c9	movq	%rax, %rcx
00000001000034cc	andq	$0x3, %rdx
00000001000034d0	je	0x1000034f2
00000001000034d2	movq	%rax, %rcx
00000001000034d5	nopw	%cs:(%rax,%rax)
00000001000034e0	movq	0x8(%r12,%rcx,8), %rsi
00000001000034e5	movq	%rsi, 0x8(%r15,%rcx,8)
00000001000034ea	incq	%rcx
00000001000034ed	decq	%rdx
00000001000034f0	jne	0x1000034e0
00000001000034f2	subq	%r14, %rax
00000001000034f5	cmpq	$-0x4, %rax
00000001000034f9	ja	0x100003531
00000001000034fb	nopl	(%rax,%rax)
0000000100003500	movq	0x8(%r12,%rcx,8), %rax
0000000100003505	movq	%rax, 0x8(%r15,%rcx,8)
000000010000350a	movq	0x10(%r12,%rcx,8), %rax
000000010000350f	movq	%rax, 0x10(%r15,%rcx,8)
0000000100003514	movq	0x18(%r12,%rcx,8), %rax
0000000100003519	movq	%rax, 0x18(%r15,%rcx,8)
000000010000351e	movq	0x20(%r12,%rcx,8), %rax
0000000100003523	movq	%rax, 0x20(%r15,%rcx,8)
0000000100003528	addq	$0x4, %rcx
000000010000352c	cmpq	%rcx, %r14
000000010000352f	jne	0x100003500
0000000100003531	cmpl	$0x0, -0x50(%rbp)
0000000100003535	je	0x1000035c6
000000010000353b	movq	-0x50(%rbp), %rcx
000000010000353f	movl	%ecx, %eax
0000000100003541	cmpl	$0x13, %ecx
0000000100003544	ja	0x100003645
000000010000354a	xorl	%ecx, %ecx
000000010000354c	movq	%rax, %rsi
000000010000354f	movq	%rcx, %rdx
0000000100003552	andq	$0x3, %rsi
0000000100003556	je	0x100003575
0000000100003558	movq	%rcx, %rdx
000000010000355b	nopl	(%rax,%rax)
0000000100003560	movq	(%rbx,%rdx,8), %r9
0000000100003564	leal	(%r14,%rdx), %r8d
0000000100003568	movq	%r9, 0x8(%r15,%r8,8)
000000010000356d	incq	%rdx
0000000100003570	decq	%rsi
0000000100003573	jne	0x100003560
0000000100003575	subq	%rax, %rcx
0000000100003578	cmpq	$-0x4, %rcx
000000010000357c	ja	0x1000035c6
000000010000357e	nop
0000000100003580	movq	(%rbx,%rdx,8), %rcx
0000000100003584	leal	(%r14,%rdx), %esi
0000000100003588	movq	%rcx, 0x8(%r15,%rsi,8)
000000010000358d	movq	0x8(%rbx,%rdx,8), %rcx
0000000100003592	leal	(%r14,%rdx), %esi
0000000100003596	incl	%esi
0000000100003598	movq	%rcx, 0x8(%r15,%rsi,8)
000000010000359d	movq	0x10(%rbx,%rdx,8), %rcx
00000001000035a2	leal	0x2(%r14,%rdx), %esi
00000001000035a7	movq	%rcx, 0x8(%r15,%rsi,8)
00000001000035ac	movq	0x18(%rbx,%rdx,8), %rcx
00000001000035b1	leal	(%r14,%rdx), %esi
00000001000035b5	addl	$0x3, %esi
00000001000035b8	movq	%rcx, 0x8(%r15,%rsi,8)
00000001000035bd	addq	$0x4, %rdx
00000001000035c1	cmpq	%rdx, %rax
00000001000035c4	jne	0x100003580
00000001000035c6	movq	-0x58(%rbp), %rax
00000001000035ca	movq	(%rax), %rax
00000001000035cd	movl	$0x1, %esi
00000001000035d2	callq	*0x8(%rax)
00000001000035d5	movq	%r15, %rax
00000001000035d8	subq	0x9a59(%rip), %rax
00000001000035df	movq	0x9a7a(%rip), %rcx
00000001000035e6	shlq	$0x10, %rcx
00000001000035ea	cmpq	%rcx, %rax
00000001000035ed	jae	0x1000036e3
00000001000035f3	movq	0x9a86(%rip), %rcx
00000001000035fa	movq	%rax, %rdx
00000001000035fd	shrq	$0x10, %rdx
0000000100003601	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003608	leaq	(%rcx,%rdx), %r12
000000010000360c	movzbl	(%rcx,%rdx), %ecx
0000000100003610	cmpb	$0x2, %cl
0000000100003613	setne	%dl
0000000100003616	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000361c	setne	%sil
0000000100003620	orb	%dl, %sil
0000000100003623	jne	0x1000036af
0000000100003629	addq	$0x228, %r12                    ## imm = 0x228
0000000100003630	cmpb	$-0x1, (%r12)
0000000100003635	je	0x1000036d6
000000010000363b	movb	$0x1, (%r12)
0000000100003640	jmp	0x1000036e3
0000000100003645	leaq	-0x1(%rax), %rdx
0000000100003649	xorl	%ecx, %ecx
000000010000364b	movl	%edx, %esi
000000010000364d	addl	%r14d, %esi
0000000100003650	jb	0x10000354c
0000000100003656	shrq	$0x20, %rdx
000000010000365a	jne	0x10000354c
0000000100003660	leaq	(%r15,%r14,8), %rcx
0000000100003664	subq	%rbx, %rcx
0000000100003667	addq	$0x8, %rcx
000000010000366b	cmpq	$0x20, %rcx
000000010000366f	jb	0x10000354a
0000000100003675	movl	%eax, %ecx
0000000100003677	andl	$-0x4, %ecx
000000010000367a	xorl	%edx, %edx
000000010000367c	nopl	(%rax)
0000000100003680	movups	(%rbx,%rdx,8), %xmm0
0000000100003684	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100003689	leal	(%r14,%rdx), %esi
000000010000368d	movups	%xmm0, 0x8(%r15,%rsi,8)
0000000100003693	movups	%xmm1, 0x18(%r15,%rsi,8)
0000000100003699	addq	$0x4, %rdx
000000010000369d	cmpq	%rdx, %rcx
00000001000036a0	jne	0x100003680
00000001000036a2	cmpl	%eax, %ecx
00000001000036a4	jne	0x10000354c
00000001000036aa	jmp	0x1000035c6
00000001000036af	cmpb	$0x1, %cl
00000001000036b2	jne	0x1000036e3
00000001000036b4	movl	0x20(%r12), %ecx
00000001000036b9	imulq	%rcx, %rax
00000001000036bd	shrq	$0x20, %rax
00000001000036c1	addq	%rax, %r12
00000001000036c4	addq	$0x228, %r12                    ## imm = 0x228
00000001000036cb	cmpb	$-0x1, (%r12)
00000001000036d0	jne	0x10000363b
00000001000036d6	movq	%r12, %rdi
00000001000036d9	callq	_fwp_rc_forget_slot
00000001000036de	jmp	0x10000363b
00000001000036e3	movq	-0x50(%rbp), %rax
00000001000036e7	movl	%eax, -0x98(%rbp)
00000001000036ed	movq	$0x0, -0x68(%rbp)
00000001000036f5	cmpq	%r13, _fwp_cleanups(%rip)
00000001000036fc	jne	0x100003754
00000001000036fe	movq	-0xc8(%rbp), %rax
0000000100003705	movq	%rax, _fwp_cleanups(%rip)
000000010000370c	cmpb	$0x0, -0x44(%rbp)
0000000100003710	movq	-0x40(%rbp), %rdi
0000000100003714	je	0x10000372a
0000000100003716	leaq	-0x80(%rbp), %rcx
000000010000371a	cmpq	%rcx, %rax
000000010000371d	jne	0x100003754
000000010000371f	movq	-0x80(%rbp), %rax
0000000100003723	movq	%rax, _fwp_cleanups(%rip)
000000010000372a	callq	_fwp_closure_drop
000000010000372f	movq	%r15, %r12
0000000100003732	movq	0x78f7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100003739	movq	(%rax), %rax
000000010000373c	cmpq	-0x30(%rbp), %rax
0000000100003740	jne	0x100003759
0000000100003742	movq	%r12, %rax
0000000100003745	leaq	-0x28(%rbp), %rsp
0000000100003749	popq	%rbx
000000010000374a	popq	%r12
000000010000374c	popq	%r13
000000010000374e	popq	%r14
0000000100003750	popq	%r15
0000000100003752	popq	%rbp
0000000100003753	retq
0000000100003754	callq	0x100009770                     ## symbol stub for: _abort
0000000100003759	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
000000010000375e	nop
_fwp_gc_alloc_slow:
0000000100003760	pushq	%rbp
0000000100003761	movq	%rsp, %rbp
0000000100003764	pushq	%r15
0000000100003766	pushq	%r14
0000000100003768	pushq	%r13
000000010000376a	pushq	%r12
000000010000376c	pushq	%rbx
000000010000376d	pushq	%rax
000000010000376e	movl	%esi, %ebx
0000000100003770	cmpl	$0x0, 0x987d(%rip)
0000000100003777	je	0x100003797
0000000100003779	cmpq	$0x4001, %rdi                   ## imm = 0x4001
0000000100003780	jb	0x1000037ab
0000000100003782	movl	%ebx, %esi
0000000100003784	addq	$0x8, %rsp
0000000100003788	popq	%rbx
0000000100003789	popq	%r12
000000010000378b	popq	%r13
000000010000378d	popq	%r14
000000010000378f	popq	%r15
0000000100003791	popq	%rbp
0000000100003792	jmp	_fwp_gc_alloc_big
0000000100003797	movq	%rdi, %r14
000000010000379a	callq	_fwp_gc_init
000000010000379f	movq	%r14, %rdi
00000001000037a2	cmpq	$0x4001, %rdi                   ## imm = 0x4001
00000001000037a9	jae	0x100003782
00000001000037ab	leaq	0xf(%rdi), %rax
00000001000037af	shrq	$0x4, %rax
00000001000037b3	leaq	_fwp_gc(%rip), %r15
00000001000037ba	movzbl	0xbe8(%rax,%r15), %r14d
00000001000037c3	movl	0xb48(%r15,%r14,4), %esi
00000001000037cb	cmpq	$0x0, _fwp_gc(%rip)
00000001000037d3	jns	0x100003871
00000001000037d9	cmpl	$0x0, 0x9814(%rip)
00000001000037e0	jne	0x1000037f3
00000001000037e2	movq	%rdi, %r12
00000001000037e5	movq	%rsi, %r13
00000001000037e8	callq	_fwp_gc_init
00000001000037ed	movq	%r13, %rsi
00000001000037f0	movq	%r12, %rdi
00000001000037f3	movl	0x9803(%rip), %ecx
00000001000037f9	testl	%ecx, %ecx
00000001000037fb	setne	%dl
00000001000037fe	movq	0x9823(%rip), %rax
0000000100003805	testq	%rax, %rax
0000000100003808	setne	%r8b
000000010000380c	andb	%dl, %r8b
000000010000380f	cmpb	$0x1, %r8b
0000000100003813	jne	0x100003833
0000000100003815	movq	0x9814(%rip), %rcx
000000010000381c	incq	%rcx
000000010000381f	movq	%rcx, 0x980a(%rip)
0000000100003826	cmpq	%rax, %rcx
0000000100003829	jge	0x1000038f5
000000010000382f	xorl	%eax, %eax
0000000100003831	jmp	0x100003840
0000000100003833	movl	$0x800000, %eax                 ## imm = 0x800000
0000000100003838	testl	%ecx, %ecx
000000010000383a	jne	0x100003900
0000000100003840	movq	0x99d1(%rip), %rcx
0000000100003847	subq	_fwp_gc(%rip), %rcx
000000010000384e	cvtsi2sd	%rcx, %xmm0
0000000100003853	addsd	0x9995(%rip), %xmm0
000000010000385b	movsd	%xmm0, 0x998d(%rip)
0000000100003863	movq	%rax, 0x99ae(%rip)
000000010000386a	movq	%rax, _fwp_gc(%rip)
0000000100003871	movl	%ebx, %eax
0000000100003873	imulq	$0x3c0, %rax, %rax              ## imm = 0x3C0
000000010000387a	addq	%rax, %r15
000000010000387d	leaq	(%r14,%r14,2), %rcx
0000000100003881	leaq	(%r15,%rcx,8), %rax
0000000100003885	addq	$0x8, %rax
0000000100003889	movq	0x8(%r15,%rcx,8), %r15
000000010000388e	testq	%r15, %r15
0000000100003891	je	0x10000389e
0000000100003893	movq	(%r15), %rcx
0000000100003896	notq	%rcx
0000000100003899	movq	%rcx, (%rax)
000000010000389c	jmp	0x1000038d4
000000010000389e	movq	0x8(%rax), %r15
00000001000038a2	movq	0x10(%rax), %rcx
00000001000038a6	subq	%r15, %rcx
00000001000038a9	cmpq	%rsi, %rcx
00000001000038ac	jae	0x1000038cc
00000001000038ae	movq	%rdi, %r15
00000001000038b1	movq	%rax, %rdi
00000001000038b4	movq	%rsi, %r12
00000001000038b7	movl	%r14d, %esi
00000001000038ba	movl	%ebx, %edx
00000001000038bc	callq	_fwp_gc_refill
00000001000038c1	movq	%r12, %rsi
00000001000038c4	movq	%r15, %rdi
00000001000038c7	movq	%rax, %r15
00000001000038ca	jmp	0x1000038d4
00000001000038cc	leaq	(%r15,%rsi), %rcx
00000001000038d0	movq	%rcx, 0x8(%rax)
00000001000038d4	cmpl	$0x1, %ebx
00000001000038d7	cmoveq	%rdi, %rsi
00000001000038db	movq	%r15, %rdi
00000001000038de	callq	0x10000972e                     ## symbol stub for: ___bzero
00000001000038e3	movq	%r15, %rax
00000001000038e6	addq	$0x8, %rsp
00000001000038ea	popq	%rbx
00000001000038eb	popq	%r12
00000001000038ed	popq	%r13
00000001000038ef	popq	%r14
00000001000038f1	popq	%r15
00000001000038f3	popq	%rbp
00000001000038f4	retq
00000001000038f5	movq	$0x0, 0x9730(%rip)
0000000100003900	callq	_fwp_gc_collect
0000000100003905	nopw	%cs:(%rax,%rax)
_fwp_gc_init:
0000000100003910	pushq	%rbp
0000000100003911	movq	%rsp, %rbp
0000000100003914	pushq	%r15
0000000100003916	pushq	%r14
0000000100003918	pushq	%r12
000000010000391a	pushq	%rbx
000000010000391b	movl	$0x1, 0x96cf(%rip)
0000000100003925	movaps	0x5f74(%rip), %xmm0
000000010000392c	movups	%xmm0, 0x921d(%rip)
0000000100003933	movaps	0x5f76(%rip), %xmm0
000000010000393a	movups	%xmm0, 0x921f(%rip)
0000000100003941	movaps	0x5f78(%rip), %xmm0
0000000100003948	movups	%xmm0, 0x9221(%rip)
000000010000394f	movaps	0x5f7a(%rip), %xmm0
0000000100003956	movups	%xmm0, 0x9223(%rip)
000000010000395d	movaps	0x5f7c(%rip), %xmm0
0000000100003964	movups	%xmm0, 0x9225(%rip)
000000010000396b	movaps	0x5f7e(%rip), %xmm0
0000000100003972	movups	%xmm0, 0x9227(%rip)
0000000100003979	movaps	0x5f80(%rip), %xmm0
0000000100003980	movups	%xmm0, 0x9229(%rip)
0000000100003987	movaps	0x5f82(%rip), %xmm0
000000010000398e	movups	%xmm0, 0x922b(%rip)
0000000100003995	movaps	0x5f84(%rip), %xmm0
000000010000399c	movups	%xmm0, 0x922d(%rip)
00000001000039a3	movaps	0x5f86(%rip), %xmm0
00000001000039aa	movups	%xmm0, 0x922f(%rip)
00000001000039b1	xorl	%ecx, %ecx
00000001000039b3	leaq	_fwp_gc(%rip), %rax
00000001000039ba	xorl	%edx, %edx
00000001000039bc	nopl	(%rax)
00000001000039c0	movl	%edx, %esi
00000001000039c2	shll	$0x4, %esi
00000001000039c5	decq	%rcx
00000001000039c8	movq	%rcx, %rdi
00000001000039cb	nopl	(%rax,%rax)
00000001000039d0	movq	%rdi, %rcx
00000001000039d3	incq	%rdi
00000001000039d6	cmpl	0xb4c(%rax,%rcx,4), %esi
00000001000039dd	ja	0x1000039d0
00000001000039df	movb	%dil, 0xbe8(%rdx,%rax)
00000001000039e7	cmpq	$0x400, %rdx                    ## imm = 0x400
00000001000039ee	je	0x100003a1d
00000001000039f0	movq	%rdx, %rsi
00000001000039f3	orq	$0x1, %rsi
00000001000039f7	movl	%esi, %edi
00000001000039f9	shll	$0x4, %edi
00000001000039fc	nopl	(%rax)
0000000100003a00	movq	%rcx, %r8
0000000100003a03	incq	%rcx
0000000100003a06	cmpl	0xb4c(%rax,%r8,4), %edi
0000000100003a0e	ja	0x100003a00
0000000100003a10	movb	%cl, 0xbe8(%rsi,%rax)
0000000100003a17	addq	$0x2, %rdx
0000000100003a1b	jmp	0x1000039c0
0000000100003a1d	movabsq	$0x1000000000, %rbx             ## imm = 0x1000000000
0000000100003a27	leaq	0x10000(%rbx), %rsi
0000000100003a2e	xorl	%edi, %edi
0000000100003a30	xorl	%edx, %edx
0000000100003a32	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003a37	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003a3d	xorl	%r9d, %r9d
0000000100003a40	callq	0x1000097fa                     ## symbol stub for: _mmap
0000000100003a45	cmpq	$-0x1, %rax
0000000100003a49	jne	0x100003aab
0000000100003a4b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100003a55	leaq	0x10000(%rbx), %rsi
0000000100003a5c	xorl	%edi, %edi
0000000100003a5e	xorl	%edx, %edx
0000000100003a60	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003a65	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003a6b	xorl	%r9d, %r9d
0000000100003a6e	callq	0x1000097fa                     ## symbol stub for: _mmap
0000000100003a73	cmpq	$-0x1, %rax
0000000100003a77	jne	0x100003aab
0000000100003a79	movabsq	$__mh_execute_header, %rbx
0000000100003a83	leaq	0x10000(%rbx), %rsi
0000000100003a8a	xorl	%edi, %edi
0000000100003a8c	xorl	%edx, %edx
0000000100003a8e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003a93	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003a99	xorl	%r9d, %r9d
0000000100003a9c	callq	0x1000097fa                     ## symbol stub for: _mmap
0000000100003aa1	cmpq	$-0x1, %rax
0000000100003aa5	je	0x100003cf8
0000000100003aab	testq	%rax, %rax
0000000100003aae	je	0x100003d59
0000000100003ab4	movq	%rax, 0x9585(%rip)
0000000100003abb	movq	%rbx, %rcx
0000000100003abe	orq	$0x10000, %rcx                  ## imm = 0x10000
0000000100003ac5	movq	%rcx, 0x957c(%rip)
0000000100003acc	addq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100003ad2	andq	$-0x10000, %rax                 ## imm = 0xFFFF0000
0000000100003ad8	movq	%rax, 0x9559(%rip)
0000000100003adf	shrq	$0x10, %rbx
0000000100003ae3	movq	%rbx, 0x956e(%rip)
0000000100003aea	imulq	$0x1228, %rbx, %rsi             ## imm = 0x1228
0000000100003af1	movq	%rsi, 0x9590(%rip)
0000000100003af8	xorl	%edi, %edi
0000000100003afa	xorl	%edx, %edx
0000000100003afc	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003b01	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003b07	xorl	%r9d, %r9d
0000000100003b0a	callq	0x1000097fa                     ## symbol stub for: _mmap
0000000100003b0f	cmpq	$-0x1, %rax
0000000100003b13	je	0x100003d59
0000000100003b19	movq	%rax, 0x9560(%rip)
0000000100003b20	leaq	0x5fb3(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003b27	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003b2c	movl	$0x1, %r14d
0000000100003b32	testq	%rax, %rax
0000000100003b35	je	0x100003b62
0000000100003b37	movq	%rax, %rbx
0000000100003b3a	leaq	0x5fa0(%rip), %rsi              ## literal pool for: "off"
0000000100003b41	movq	%rax, %rdi
0000000100003b44	callq	0x100009854                     ## symbol stub for: _strcmp
0000000100003b49	testl	%eax, %eax
0000000100003b4b	je	0x100003b5f
0000000100003b4d	cmpb	$0x30, (%rbx)
0000000100003b50	jne	0x100003b62
0000000100003b52	xorl	%r14d, %r14d
0000000100003b55	cmpb	$0x0, 0x1(%rbx)
0000000100003b59	setne	%r14b
0000000100003b5d	jmp	0x100003b62
0000000100003b5f	xorl	%r14d, %r14d
0000000100003b62	movl	%r14d, 0x948f(%rip)
0000000100003b69	leaq	0x5f77(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100003b70	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003b75	testq	%rax, %rax
0000000100003b78	je	0x100003b91
0000000100003b7a	movzbl	(%rax), %ecx
0000000100003b7d	testl	%ecx, %ecx
0000000100003b7f	je	0x100003b9a
0000000100003b81	cmpl	$0x30, %ecx
0000000100003b84	jne	0x100003b95
0000000100003b86	xorl	%ecx, %ecx
0000000100003b88	cmpb	$0x0, 0x1(%rax)
0000000100003b8c	setne	%cl
0000000100003b8f	jmp	0x100003b9a
0000000100003b91	xorl	%ecx, %ecx
0000000100003b93	jmp	0x100003b9a
0000000100003b95	movl	$0x1, %ecx
0000000100003b9a	movl	%ecx, 0x9464(%rip)
0000000100003ba0	leaq	0x5f33(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003ba7	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003bac	testq	%rax, %rax
0000000100003baf	je	0x100003bc9
0000000100003bb1	leaq	0x5f3c(%rip), %rsi              ## literal pool for: "full"
0000000100003bb8	movq	%rax, %rdi
0000000100003bbb	callq	0x100009854                     ## symbol stub for: _strcmp
0000000100003bc0	xorl	%ecx, %ecx
0000000100003bc2	testl	%eax, %eax
0000000100003bc4	setne	%cl
0000000100003bc7	jmp	0x100003bce
0000000100003bc9	movl	$0x1, %ecx
0000000100003bce	movl	%ecx, 0x9434(%rip)
0000000100003bd4	movl	$0x1, 0x9432(%rip)
0000000100003bde	leaq	0x5f14(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
0000000100003be5	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003bea	testq	%rax, %rax
0000000100003bed	je	0x100003c0b
0000000100003bef	movzbl	(%rax), %r15d
0000000100003bf3	testl	%r15d, %r15d
0000000100003bf6	je	0x100003c16
0000000100003bf8	cmpl	$0x30, %r15d
0000000100003bfc	jne	0x100003c10
0000000100003bfe	xorl	%r15d, %r15d
0000000100003c01	cmpb	$0x0, 0x1(%rax)
0000000100003c05	setne	%r15b
0000000100003c09	jmp	0x100003c16
0000000100003c0b	xorl	%r15d, %r15d
0000000100003c0e	jmp	0x100003c16
0000000100003c10	movl	$0x1, %r15d
0000000100003c16	movl	%r15d, 0x93ef(%rip)
0000000100003c1d	leaq	0x5ee3(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
0000000100003c24	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003c29	testq	%rax, %rax
0000000100003c2c	je	0x100003c3b
0000000100003c2e	movq	%rax, %rdi
0000000100003c31	callq	0x100009782                     ## symbol stub for: _atol
0000000100003c36	movq	%rax, %rbx
0000000100003c39	jmp	0x100003c3d
0000000100003c3b	xorl	%ebx, %ebx
0000000100003c3d	xorl	%eax, %eax
0000000100003c3f	testq	%rbx, %rbx
0000000100003c42	cmovgq	%rbx, %rax
0000000100003c46	movq	%rax, 0x93db(%rip)
0000000100003c4d	leaq	0x5e86(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003c54	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003c59	testq	%rax, %rax
0000000100003c5c	je	0x100003c92
0000000100003c5e	movq	%rax, %r14
0000000100003c61	movzbl	(%rax), %r12d
0000000100003c65	testb	%r12b, %r12b
0000000100003c68	je	0x100003c92
0000000100003c6a	leaq	0x5e70(%rip), %rsi              ## literal pool for: "off"
0000000100003c71	movq	%r14, %rdi
0000000100003c74	callq	0x100009854                     ## symbol stub for: _strcmp
0000000100003c79	testl	%eax, %eax
0000000100003c7b	je	0x100003c92
0000000100003c7d	cmpb	$0x30, %r12b
0000000100003c81	jne	0x100003d83
0000000100003c87	cmpb	$0x0, 0x1(%r14)
0000000100003c8c	jne	0x100003d83
0000000100003c92	testq	%rbx, %rbx
0000000100003c95	jg	0x100003d83
0000000100003c9b	testl	%r15d, %r15d
0000000100003c9e	jne	0x100003d83
0000000100003ca4	leaq	0x5ea7(%rip), %rdi              ## literal pool for: "FWP_REUSE_VERIFY"
0000000100003cab	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100003cb0	testq	%rax, %rax
0000000100003cb3	je	0x100003ccf
0000000100003cb5	movzbl	(%rax), %ecx
0000000100003cb8	testl	%ecx, %ecx
0000000100003cba	je	0x100003ccf
0000000100003cbc	cmpl	$0x30, %ecx
0000000100003cbf	jne	0x100003da2
0000000100003cc5	cmpb	$0x0, 0x1(%rax)
0000000100003cc9	jne	0x100003da2
0000000100003ccf	movl	$0x0, 0x931f(%rip)
0000000100003cd9	movq	$0x800000, 0x9534(%rip)         ## imm = 0x800000
0000000100003ce4	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
0000000100003cef	popq	%rbx
0000000100003cf0	popq	%r12
0000000100003cf2	popq	%r14
0000000100003cf4	popq	%r15
0000000100003cf6	popq	%rbp
0000000100003cf7	retq
0000000100003cf8	movl	$0x40010000, %esi               ## imm = 0x40010000
0000000100003cfd	xorl	%edi, %edi
0000000100003cff	xorl	%edx, %edx
0000000100003d01	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003d06	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003d0c	xorl	%r9d, %r9d
0000000100003d0f	callq	0x1000097fa                     ## symbol stub for: _mmap
0000000100003d14	cmpq	$-0x1, %rax
0000000100003d18	je	0x100003d29
0000000100003d1a	testq	%rax, %rax
0000000100003d1d	je	0x100003d59
0000000100003d1f	movl	$0x40000000, %ebx               ## imm = 0x40000000
0000000100003d24	jmp	0x100003ab4
0000000100003d29	movl	$0x10010000, %esi               ## imm = 0x10010000
0000000100003d2e	xorl	%edi, %edi
0000000100003d30	xorl	%edx, %edx
0000000100003d32	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003d37	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003d3d	xorl	%r9d, %r9d
0000000100003d40	callq	0x1000097fa                     ## symbol stub for: _mmap
0000000100003d45	leaq	0x1(%rax), %rcx
0000000100003d49	cmpq	$0x2, %rcx
0000000100003d4d	jb	0x100003d59
0000000100003d4f	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100003d54	jmp	0x100003ab4
0000000100003d59	movq	0x72d8(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003d60	movq	(%rax), %rcx
0000000100003d63	leaq	0x5e38(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100003d6a	movl	$0x13, %esi
0000000100003d6f	movl	$0x1, %edx
0000000100003d74	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100003d79	movl	$0x66, %edi
0000000100003d7e	callq	0x10000978e                     ## symbol stub for: _exit
0000000100003d83	callq	_fwp_flush
0000000100003d88	movq	0x72a9(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003d8f	movq	(%rax), %rdi
0000000100003d92	leaq	0x5d0b(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003d99	leaq	0x5d75(%rip), %rdx              ## literal pool for: "--gc arc cannot enable tracing, GC stress or GC verification"
0000000100003da0	jmp	0x100003dbf
0000000100003da2	callq	_fwp_flush
0000000100003da7	movq	0x728a(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003dae	movq	(%rax), %rdi
0000000100003db1	leaq	0x5cec(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003db8	leaq	0x5da4(%rip), %rdx              ## literal pool for: "--gc arc cannot retain released storage for reuse verification"
0000000100003dbf	xorl	%eax, %eax
0000000100003dc1	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100003dc6	movl	$0x65, %edi
0000000100003dcb	callq	0x10000978e                     ## symbol stub for: _exit
_fwp_gc_alloc_big:
0000000100003dd0	pushq	%rbp
0000000100003dd1	movq	%rsp, %rbp
0000000100003dd4	pushq	%r15
0000000100003dd6	pushq	%r14
0000000100003dd8	pushq	%r13
0000000100003dda	pushq	%r12
0000000100003ddc	pushq	%rbx
0000000100003ddd	pushq	%rax
0000000100003dde	movabsq	$0x4000000000000001, %rax       ## imm = 0x4000000000000001
0000000100003de8	cmpq	%rax, %rdi
0000000100003deb	jae	0x100004027
0000000100003df1	movl	%esi, %r14d
0000000100003df4	movq	%rdi, %rbx
0000000100003df7	subq	%rdi, _fwp_gc(%rip)
0000000100003dfe	jns	0x100003e90
0000000100003e04	cmpl	$0x0, 0x91e9(%rip)
0000000100003e0b	jne	0x100003e12
0000000100003e0d	callq	_fwp_gc_init
0000000100003e12	movl	0x91e4(%rip), %ecx
0000000100003e18	testl	%ecx, %ecx
0000000100003e1a	setne	%dl
0000000100003e1d	movq	0x9204(%rip), %rax
0000000100003e24	testq	%rax, %rax
0000000100003e27	setne	%sil
0000000100003e2b	andb	%dl, %sil
0000000100003e2e	cmpb	$0x1, %sil
0000000100003e32	jne	0x100003e52
0000000100003e34	movq	0x91f5(%rip), %rcx
0000000100003e3b	incq	%rcx
0000000100003e3e	movq	%rcx, 0x91eb(%rip)
0000000100003e45	cmpq	%rax, %rcx
0000000100003e48	jge	0x100004051
0000000100003e4e	xorl	%eax, %eax
0000000100003e50	jmp	0x100003e5f
0000000100003e52	movl	$0x800000, %eax                 ## imm = 0x800000
0000000100003e57	testl	%ecx, %ecx
0000000100003e59	jne	0x10000405c
0000000100003e5f	movq	0x93b2(%rip), %rcx
0000000100003e66	subq	_fwp_gc(%rip), %rcx
0000000100003e6d	cvtsi2sd	%rcx, %xmm0
0000000100003e72	addsd	0x9376(%rip), %xmm0
0000000100003e7a	movsd	%xmm0, 0x936e(%rip)
0000000100003e82	movq	%rax, 0x938f(%rip)
0000000100003e89	movq	%rax, _fwp_gc(%rip)
0000000100003e90	leaq	0xffff(%rbx), %r15
0000000100003e97	shrq	$0x10, %r15
0000000100003e9b	movq	%r15, %rdi
0000000100003e9e	callq	_fwp_gc_chunks
0000000100003ea3	movq	0x91d6(%rip), %rcx
0000000100003eaa	imulq	$0x1228, %rax, %r12             ## imm = 0x1228
0000000100003eb1	movb	$0x2, (%rcx,%r12)
0000000100003eb6	movb	%r14b, 0x1(%rcx,%r12)
0000000100003ebb	movw	$0x100, 0x3(%rcx,%r12)          ## imm = 0x100
0000000100003ec3	movl	%r15d, 0x10(%rcx,%r12)
0000000100003ec8	movq	%rbx, 0x18(%rcx,%r12)
0000000100003ecd	leaq	(%rcx,%r12), %r14
0000000100003ed1	addq	$0x228, %r14                    ## imm = 0x228
0000000100003ed8	cmpb	$-0x1, 0x228(%rcx,%r12)
0000000100003ee1	je	0x100004014
0000000100003ee7	movb	$0x0, (%r14)
0000000100003eeb	cmpq	$0x10001, %rbx                  ## imm = 0x10001
0000000100003ef2	jb	0x100003fe9
0000000100003ef8	movq	0x9181(%rip), %rcx
0000000100003eff	cmpq	$0x3, %r15
0000000100003f03	movl	$0x2, %r8d
0000000100003f09	cmovaeq	%r15, %r8
0000000100003f0d	leaq	-0x1(%r8), %rsi
0000000100003f11	addq	$-0x2, %r8
0000000100003f15	movl	%esi, %edx
0000000100003f17	andl	$0x3, %edx
0000000100003f1a	movl	$0x1, %edi
0000000100003f1f	cmpq	$0x3, %r8
0000000100003f23	jb	0x100003fab
0000000100003f29	leaq	(%r12,%rcx), %r8
0000000100003f2d	addq	$0x48b0, %r8                    ## imm = 0x48B0
0000000100003f34	andq	$-0x4, %rsi
0000000100003f38	negq	%rsi
0000000100003f3b	nopl	(%rax,%rax)
0000000100003f40	movb	$0x3, -0x3688(%r8)
0000000100003f48	movb	$0x1, -0x3684(%r8)
0000000100003f50	movl	%eax, -0x3678(%r8)
0000000100003f57	movb	$0x3, -0x2460(%r8)
0000000100003f5f	movb	$0x1, -0x245c(%r8)
0000000100003f67	movl	%eax, -0x2450(%r8)
0000000100003f6e	movb	$0x3, -0x1238(%r8)
0000000100003f76	movb	$0x1, -0x1234(%r8)
0000000100003f7e	movl	%eax, -0x1228(%r8)
0000000100003f85	movb	$0x3, -0x10(%r8)
0000000100003f8a	movb	$0x1, -0xc(%r8)
0000000100003f8f	movl	%eax, (%r8)
0000000100003f92	addq	$0x48a0, %r8                    ## imm = 0x48A0
0000000100003f99	leaq	(%rsi,%rdi), %r9
0000000100003f9d	addq	$0x4, %r9
0000000100003fa1	addq	$0x4, %rdi
0000000100003fa5	cmpq	$0x1, %r9
0000000100003fa9	jne	0x100003f40
0000000100003fab	testq	%rdx, %rdx
0000000100003fae	je	0x100003fe9
0000000100003fb0	imulq	$0x1228, %rdi, %rsi             ## imm = 0x1228
0000000100003fb7	addq	%rsi, %r12
0000000100003fba	addq	%r12, %rcx
0000000100003fbd	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003fc4	xorl	%esi, %esi
0000000100003fc6	nopw	%cs:(%rax,%rax)
0000000100003fd0	movb	$0x3, (%rcx,%rsi)
0000000100003fd4	movb	$0x1, 0x4(%rcx,%rsi)
0000000100003fd9	movl	%eax, 0x10(%rcx,%rsi)
0000000100003fdd	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100003fe4	cmpq	%rsi, %rdx
0000000100003fe7	jne	0x100003fd0
0000000100003fe9	shlq	$0x10, %rax
0000000100003fed	addq	0x9044(%rip), %rax
0000000100003ff4	movq	%rax, %rdi
0000000100003ff7	movq	%rbx, %rsi
0000000100003ffa	movq	%rax, %rbx
0000000100003ffd	callq	0x10000972e                     ## symbol stub for: ___bzero
0000000100004002	movq	%rbx, %rax
0000000100004005	addq	$0x8, %rsp
0000000100004009	popq	%rbx
000000010000400a	popq	%r12
000000010000400c	popq	%r13
000000010000400e	popq	%r14
0000000100004010	popq	%r15
0000000100004012	popq	%rbp
0000000100004013	retq
0000000100004014	movq	%r14, %rdi
0000000100004017	movq	%rax, %r13
000000010000401a	callq	_fwp_rc_forget_slot
000000010000401f	movq	%r13, %rax
0000000100004022	jmp	0x100003ee7
0000000100004027	movq	0x700a(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000402e	movq	(%rax), %rcx
0000000100004031	leaq	0x5b6a(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004038	movl	$0x13, %esi
000000010000403d	movl	$0x1, %edx
0000000100004042	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100004047	movl	$0x66, %edi
000000010000404c	callq	0x10000978e                     ## symbol stub for: _exit
0000000100004051	movq	$0x0, 0x8fd4(%rip)
000000010000405c	callq	_fwp_gc_collect
0000000100004061	nopw	%cs:(%rax,%rax)
_fwp_gc_refill:
0000000100004070	pushq	%rbp
0000000100004071	movq	%rsp, %rbp
0000000100004074	pushq	%r15
0000000100004076	pushq	%r14
0000000100004078	pushq	%r13
000000010000407a	pushq	%r12
000000010000407c	pushq	%rbx
000000010000407d	pushq	%rax
000000010000407e	movl	%edx, %r15d
0000000100004081	movl	%esi, %r12d
0000000100004084	movq	%rdi, %rbx
0000000100004087	movl	$0x1, %edi
000000010000408c	callq	_fwp_gc_chunks
0000000100004091	movq	%rax, %r14
0000000100004094	leaq	_fwp_gc(%rip), %rax
000000010000409b	movq	0x8fde(%rip), %rsi
00000001000040a2	imulq	$0x1228, %r14, %rdi             ## imm = 0x1228
00000001000040a9	leaq	(%rsi,%rdi), %r13
00000001000040ad	movb	$0x1, (%rsi,%rdi)
00000001000040b1	movb	%r15b, 0x1(%rsi,%rdi)
00000001000040b6	movb	%r12b, 0x2(%rsi,%rdi)
00000001000040bb	movb	$0x1, 0x4(%rsi,%rdi)
00000001000040c0	movl	%r12d, %ecx
00000001000040c3	movl	0xb48(%rax,%rcx,4), %ecx
00000001000040ca	movl	%ecx, 0x8(%rsi,%rdi)
00000001000040ce	movl	$0x10000, %eax                  ## imm = 0x10000
00000001000040d3	xorl	%edx, %edx
00000001000040d5	divl	%ecx
00000001000040d7	movl	%eax, 0xc(%rsi,%rdi)
00000001000040db	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
00000001000040e0	addq	%rcx, %rax
00000001000040e3	btq	$0x20, %rax
00000001000040e8	jae	0x1000040f1
00000001000040ea	xorl	%edx, %edx
00000001000040ec	divq	%rcx
00000001000040ef	jmp	0x1000040f5
00000001000040f1	xorl	%edx, %edx
00000001000040f3	divl	%ecx
00000001000040f5	movl	%eax, 0x20(%r13)
00000001000040f9	cmpq	$0x0, 0x991f(%rip)
0000000100004101	je	0x10000412e
0000000100004103	leaq	0x228(%r13), %r15
000000010000410a	xorl	%r12d, %r12d
000000010000410d	jmp	0x10000411c
000000010000410f	nop
0000000100004110	incq	%r12
0000000100004113	cmpq	$0x1000, %r12                   ## imm = 0x1000
000000010000411a	je	0x10000412e
000000010000411c	cmpb	$-0x1, (%r15,%r12)
0000000100004121	jne	0x100004110
0000000100004123	leaq	(%r15,%r12), %rdi
0000000100004127	callq	_fwp_rc_forget_slot
000000010000412c	jmp	0x100004110
000000010000412e	leaq	0x228(%r13), %rdi
0000000100004135	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000413a	callq	0x10000972e                     ## symbol stub for: ___bzero
000000010000413f	shlq	$0x10, %r14
0000000100004143	addq	0x8eee(%rip), %r14
000000010000414a	cmpl	$0x0, 0x8ebb(%rip)
0000000100004151	je	0x100004160
0000000100004153	movl	$0x10000, %esi                  ## imm = 0x10000
0000000100004158	movq	%r14, %rdi
000000010000415b	callq	0x10000972e                     ## symbol stub for: ___bzero
0000000100004160	movl	0x8(%r13), %eax
0000000100004164	leaq	(%r14,%rax), %rcx
0000000100004168	movq	%rcx, 0x8(%rbx)
000000010000416c	movl	0xc(%r13), %ecx
0000000100004170	imulq	%rax, %rcx
0000000100004174	addq	%r14, %rcx
0000000100004177	movq	%rcx, 0x10(%rbx)
000000010000417b	movq	%r14, %rax
000000010000417e	addq	$0x8, %rsp
0000000100004182	popq	%rbx
0000000100004183	popq	%r12
0000000100004185	popq	%r13
0000000100004187	popq	%r14
0000000100004189	popq	%r15
000000010000418b	popq	%rbp
000000010000418c	retq
000000010000418d	nopl	(%rax)
_fwp_gc_chunks:
0000000100004190	pushq	%rbp
0000000100004191	movq	%rsp, %rbp
0000000100004194	pushq	%r15
0000000100004196	pushq	%r14
0000000100004198	pushq	%rbx
0000000100004199	pushq	%rax
000000010000419a	movq	%rdi, %rbx
000000010000419d	xorl	%edx, %edx
000000010000419f	cmpq	$0x1, %rdi
00000001000041a3	setne	%dl
00000001000041a6	leaq	_fwp_gc(%rip), %rcx
00000001000041ad	movq	0x1068(%rcx,%rdx,8), %rax
00000001000041b5	movq	0x8ea4(%rip), %r14
00000001000041bc	movq	%rax, %rdi
00000001000041bf	subq	%r14, %rdi
00000001000041c2	jae	0x100004232
00000001000041c4	leaq	0x1068(,%rdx,8), %rsi
00000001000041cc	imulq	$0x1228, %rax, %r8              ## imm = 0x1228
00000001000041d3	addq	0x8ea6(%rip), %r8
00000001000041da	xorl	%edx, %edx
00000001000041dc	xorl	%r9d, %r9d
00000001000041df	jmp	0x100004202
00000001000041e1	nopw	%cs:(%rax,%rax)
00000001000041f0	xorl	%r9d, %r9d
00000001000041f3	decq	%rdx
00000001000041f6	addq	$0x1228, %r8                    ## imm = 0x1228
00000001000041fd	cmpq	%rdx, %rdi
0000000100004200	je	0x100004235
0000000100004202	cmpb	$0x0, (%r8)
0000000100004206	jne	0x1000041f0
0000000100004208	incq	%r9
000000010000420b	cmpq	%rbx, %r9
000000010000420e	jne	0x1000041f3
0000000100004210	incq	%rax
0000000100004213	movq	%rax, %rdi
0000000100004216	subq	%rdx, %rdi
0000000100004219	movq	%rdi, (%rsi,%rcx)
000000010000421d	subq	%rbx, 0x8fc4(%rip)
0000000100004224	subq	%rbx, %rax
0000000100004227	subq	%rdx, %rax
000000010000422a	movq	%rax, %r14
000000010000422d	jmp	0x1000042fc
0000000100004232	xorl	%r9d, %r9d
0000000100004235	subq	%r9, 0x8fac(%rip)
000000010000423c	subq	%r9, %r14
000000010000423f	addq	%r14, %rbx
0000000100004242	movq	0x8e1f(%rip), %rdi
0000000100004249	cmpq	%rbx, %rdi
000000010000424c	jae	0x1000042e1
0000000100004252	movq	0x8dff(%rip), %r15
0000000100004259	cmpq	%rbx, %r15
000000010000425c	jb	0x10000430a
0000000100004262	leaq	0x40(%rbx), %rax
0000000100004266	cmpq	%r15, %rax
0000000100004269	cmovbq	%rax, %r15
000000010000426d	movq	%r15, %rsi
0000000100004270	subq	%rdi, %rsi
0000000100004273	shlq	$0x10, %rdi
0000000100004277	addq	0x8dba(%rip), %rdi
000000010000427e	shlq	$0x10, %rsi
0000000100004282	movl	$0x3, %edx
0000000100004287	callq	0x100009800                     ## symbol stub for: _mprotect
000000010000428c	testl	%eax, %eax
000000010000428e	jne	0x10000430a
0000000100004290	movl	$0x1d, %edi
0000000100004295	callq	0x10000987e                     ## symbol stub for: _sysconf
000000010000429a	movq	0x8ddf(%rip), %rcx
00000001000042a1	imulq	$0x1228, 0x8dbc(%rip), %rdi     ## imm = 0x1228
00000001000042ac	addq	%rcx, %rdi
00000001000042af	imulq	$0x1228, %r15, %rdx             ## imm = 0x1228
00000001000042b6	addq	%rcx, %rdx
00000001000042b9	leaq	(%rax,%rdx), %rsi
00000001000042bd	decq	%rsi
00000001000042c0	negq	%rax
00000001000042c3	andq	%rax, %rdi
00000001000042c6	andq	%rax, %rsi
00000001000042c9	subq	%rdi, %rsi
00000001000042cc	movl	$0x3, %edx
00000001000042d1	callq	0x100009800                     ## symbol stub for: _mprotect
00000001000042d6	testl	%eax, %eax
00000001000042d8	jne	0x10000430a
00000001000042da	movq	%r15, 0x8d87(%rip)
00000001000042e1	movq	%rbx, 0x8d78(%rip)
00000001000042e8	shlq	$0x10, %rbx
00000001000042ec	cmpq	0x8d5d(%rip), %rbx
00000001000042f3	jbe	0x1000042fc
00000001000042f5	movq	%rbx, 0x8d54(%rip)
00000001000042fc	movq	%r14, %rax
00000001000042ff	addq	$0x8, %rsp
0000000100004303	popq	%rbx
0000000100004304	popq	%r14
0000000100004306	popq	%r15
0000000100004308	popq	%rbp
0000000100004309	retq
000000010000430a	movq	0x6d27(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004311	movq	(%rax), %rcx
0000000100004314	leaq	0x5887(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000431b	movl	$0x13, %esi
0000000100004320	movl	$0x1, %edx
0000000100004325	callq	0x1000097c4                     ## symbol stub for: _fwrite
000000010000432a	movl	$0x66, %edi
000000010000432f	callq	0x10000978e                     ## symbol stub for: _exit
0000000100004334	nopw	%cs:(%rax,%rax)
_fwp_gc_collect:
0000000100004340	pushq	%rbp
0000000100004341	movq	%rsp, %rbp
0000000100004344	callq	_fwp_flush
0000000100004349	movq	0x6ce8(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004350	movq	(%rax), %rdi
0000000100004353	leaq	0x574a(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000435a	leaq	0x5855(%rip), %rdx              ## literal pool for: "internal: tracing requested in an ARC executable"
0000000100004361	xorl	%eax, %eax
0000000100004363	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100004368	movl	$0x65, %edi
000000010000436d	callq	0x10000978e                     ## symbol stub for: _exit
0000000100004372	nopw	%cs:(%rax,%rax)
_fwp_closure_drop:
0000000100004380	pushq	%rbp
0000000100004381	movq	%rsp, %rbp
0000000100004384	pushq	%r15
0000000100004386	pushq	%r14
0000000100004388	pushq	%rbx
0000000100004389	subq	$0x238, %rsp                    ## imm = 0x238
0000000100004390	movq	%rdi, %rax
0000000100004393	subq	0x8c9e(%rip), %rax
000000010000439a	movq	0x8cbf(%rip), %rcx
00000001000043a1	shlq	$0x10, %rcx
00000001000043a5	cmpq	%rcx, %rax
00000001000043a8	jae	0x100004444
00000001000043ae	movq	%rdi, %rsi
00000001000043b1	movq	0x8cc8(%rip), %rcx
00000001000043b8	movq	%rax, %rdx
00000001000043bb	shrq	$0x10, %rdx
00000001000043bf	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000043c6	leaq	(%rcx,%rdx), %rdi
00000001000043ca	movzbl	(%rcx,%rdx), %ecx
00000001000043ce	cmpb	$0x2, %cl
00000001000043d1	setne	%dl
00000001000043d4	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000043da	setne	%r8b
00000001000043de	orb	%dl, %r8b
00000001000043e1	jne	0x1000043ec
00000001000043e3	addq	$0x228, %rdi                    ## imm = 0x228
00000001000043ea	jmp	0x100004406
00000001000043ec	cmpb	$0x1, %cl
00000001000043ef	jne	0x100004444
00000001000043f1	movl	0x20(%rdi), %ecx
00000001000043f4	imulq	%rcx, %rax
00000001000043f8	shrq	$0x20, %rax
00000001000043fc	addq	%rax, %rdi
00000001000043ff	addq	$0x228, %rdi                    ## imm = 0x228
0000000100004406	movzbl	(%rdi), %eax
0000000100004409	testl	%eax, %eax
000000010000440b	je	0x100004444
000000010000440d	cmpl	$0x1, %eax
0000000100004410	jne	0x100004435
0000000100004412	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100004419	callq	*(%rdi)
000000010000441b	movq	(%rax), %rdi
000000010000441e	testq	%rdi, %rdi
0000000100004421	je	0x100004452
0000000100004423	addq	$0x238, %rsp                    ## imm = 0x238
000000010000442a	popq	%rbx
000000010000442b	popq	%r14
000000010000442d	popq	%r15
000000010000442f	popq	%rbp
0000000100004430	jmp	_fwp_closure_drop_push
0000000100004435	cmpl	$0xff, %eax
000000010000443a	je	0x100004526
0000000100004440	decb	%al
0000000100004442	movb	%al, (%rdi)
0000000100004444	addq	$0x238, %rsp                    ## imm = 0x238
000000010000444b	popq	%rbx
000000010000444c	popq	%r14
000000010000444e	popq	%r15
0000000100004450	popq	%rbp
0000000100004451	retq
0000000100004452	leaq	-0x230(%rbp), %rbx
0000000100004459	movq	%rbx, -0x248(%rbp)
0000000100004460	movq	$0x0, -0x240(%rbp)
000000010000446b	movq	$0x40, -0x238(%rbp)
0000000100004476	movq	_fwp_cleanups(%rip), %rcx
000000010000447d	movq	%rcx, -0x30(%rbp)
0000000100004481	leaq	_fwp_closure_drop_release(%rip), %rcx
0000000100004488	movq	%rcx, -0x28(%rbp)
000000010000448c	leaq	-0x248(%rbp), %rdi
0000000100004493	movq	%rdi, -0x20(%rbp)
0000000100004497	leaq	-0x30(%rbp), %r15
000000010000449b	movq	%r15, _fwp_cleanups(%rip)
00000001000044a2	movq	%rax, %r14
00000001000044a5	movq	%rdi, (%rax)
00000001000044a8	callq	_fwp_closure_drop_push
00000001000044ad	nopl	(%rax)
00000001000044b0	movq	-0x240(%rbp), %rax
00000001000044b7	testq	%rax, %rax
00000001000044ba	je	0x1000044f1
00000001000044bc	movq	-0x248(%rbp), %rcx
00000001000044c3	leaq	-0x1(%rax), %rdx
00000001000044c7	movq	%rdx, -0x240(%rbp)
00000001000044ce	movq	-0x8(%rcx,%rax,8), %rdi
00000001000044d3	movq	_fwp_fns(%rip), %rax
00000001000044da	movl	(%rdi), %ecx
00000001000044dc	shlq	$0x5, %rcx
00000001000044e0	movq	0x18(%rax,%rcx), %rax
00000001000044e5	testq	%rax, %rax
00000001000044e8	je	0x100004538
00000001000044ea	xorl	%esi, %esi
00000001000044ec	callq	*0x8(%rax)
00000001000044ef	jmp	0x1000044b0
00000001000044f1	cmpq	%r15, _fwp_cleanups(%rip)
00000001000044f8	jne	0x100004566
00000001000044fa	movq	-0x30(%rbp), %rax
00000001000044fe	movq	%rax, _fwp_cleanups(%rip)
0000000100004505	movq	$0x0, (%r14)
000000010000450c	movq	-0x248(%rbp), %rdi
0000000100004513	cmpq	%rbx, %rdi
0000000100004516	je	0x100004444
000000010000451c	callq	0x1000097be                     ## symbol stub for: _free
0000000100004521	jmp	0x100004444
0000000100004526	addq	$0x238, %rsp                    ## imm = 0x238
000000010000452d	popq	%rbx
000000010000452e	popq	%r14
0000000100004530	popq	%r15
0000000100004532	popq	%rbp
0000000100004533	jmp	_fwp_rc_wide_drop
0000000100004538	callq	_fwp_flush
000000010000453d	movq	0x6af4(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004544	movq	(%rax), %rdi
0000000100004547	leaq	0x5556(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000454e	leaq	0x5692(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100004555	xorl	%eax, %eax
0000000100004557	callq	0x1000097ac                     ## symbol stub for: _fprintf
000000010000455c	movl	$0x65, %edi
0000000100004561	callq	0x10000978e                     ## symbol stub for: _exit
0000000100004566	callq	0x100009770                     ## symbol stub for: _abort
000000010000456b	nopl	(%rax,%rax)
_fwp_closure_drop_push:
0000000100004570	pushq	%rbp
0000000100004571	movq	%rsp, %rbp
0000000100004574	pushq	%r15
0000000100004576	pushq	%r14
0000000100004578	pushq	%r13
000000010000457a	pushq	%r12
000000010000457c	pushq	%rbx
000000010000457d	pushq	%rax
000000010000457e	movq	%rsi, %rbx
0000000100004581	movq	%rdi, %r14
0000000100004584	movq	0x8(%rdi), %r13
0000000100004588	cmpq	0x10(%rdi), %r13
000000010000458c	jne	0x1000045f3
000000010000458e	movq	%r13, %rax
0000000100004591	shrq	$0x3c, %rax
0000000100004595	jne	0x100004611
0000000100004597	movq	%r13, %rdi
000000010000459a	shlq	$0x4, %rdi
000000010000459e	callq	0x1000097e2                     ## symbol stub for: _malloc
00000001000045a3	testq	%rax, %rax
00000001000045a6	je	0x100004630
00000001000045ac	movq	%rax, %r15
00000001000045af	leaq	(,%r13,2), %rax
00000001000045b7	movq	%rax, -0x30(%rbp)
00000001000045bb	movq	(%r14), %r12
00000001000045be	leaq	(,%r13,8), %rdx
00000001000045c6	movq	%r15, %rdi
00000001000045c9	movq	%r12, %rsi
00000001000045cc	callq	0x1000097e8                     ## symbol stub for: _memcpy
00000001000045d1	leaq	0x18(%r14), %rax
00000001000045d5	cmpq	%rax, %r12
00000001000045d8	je	0x1000045e6
00000001000045da	movq	%r12, %rdi
00000001000045dd	callq	0x1000097be                     ## symbol stub for: _free
00000001000045e2	movq	0x8(%r14), %r13
00000001000045e6	movq	%r15, (%r14)
00000001000045e9	movq	-0x30(%rbp), %rax
00000001000045ed	movq	%rax, 0x10(%r14)
00000001000045f1	jmp	0x1000045f6
00000001000045f3	movq	(%r14), %r15
00000001000045f6	leaq	0x1(%r13), %rax
00000001000045fa	movq	%rax, 0x8(%r14)
00000001000045fe	movq	%rbx, (%r15,%r13,8)
0000000100004602	addq	$0x8, %rsp
0000000100004606	popq	%rbx
0000000100004607	popq	%r12
0000000100004609	popq	%r13
000000010000460b	popq	%r14
000000010000460d	popq	%r15
000000010000460f	popq	%rbp
0000000100004610	retq
0000000100004611	callq	_fwp_flush
0000000100004616	movq	0x6a1b(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000461d	movq	(%rax), %rdi
0000000100004620	leaq	0x547d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004627	leaq	0x55e7(%rip), %rdx              ## literal pool for: "closure cleanup too large"
000000010000462e	jmp	0x10000464d
0000000100004630	callq	_fwp_flush
0000000100004635	movq	0x69fc(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000463c	movq	(%rax), %rdi
000000010000463f	leaq	0x545e(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004646	leaq	0x55e2(%rip), %rdx              ## literal pool for: "out of memory"
000000010000464d	xorl	%eax, %eax
000000010000464f	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100004654	movl	$0x65, %edi
0000000100004659	callq	0x10000978e                     ## symbol stub for: _exit
000000010000465e	nop
_fwp_closure_drop_release:
0000000100004660	pushq	%rbp
0000000100004661	movq	%rsp, %rbp
0000000100004664	pushq	%r14
0000000100004666	pushq	%rbx
0000000100004667	movq	%rdi, %rbx
000000010000466a	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100004671	callq	*(%rdi)
0000000100004673	movq	$0x0, (%rax)
000000010000467a	movq	(%rbx), %rdi
000000010000467d	leaq	0x18(%rbx), %r14
0000000100004681	cmpq	%r14, %rdi
0000000100004684	je	0x10000468b
0000000100004686	callq	0x1000097be                     ## symbol stub for: _free
000000010000468b	movq	%r14, (%rbx)
000000010000468e	movq	$0x0, 0x8(%rbx)
0000000100004696	popq	%rbx
0000000100004697	popq	%r14
0000000100004699	popq	%rbp
000000010000469a	retq
000000010000469b	nopl	(%rax,%rax)
_fwp_rc_wide_drop:
00000001000046a0	pushq	%rbp
00000001000046a1	movq	%rsp, %rbp
00000001000046a4	pushq	%rbx
00000001000046a5	pushq	%rax
00000001000046a6	movq	%rdi, %rax
00000001000046a9	shrq	$0x11, %rax
00000001000046ad	xorl	%edi, %eax
00000001000046af	movl	%eax, %ecx
00000001000046b1	shrl	$0x9, %ecx
00000001000046b4	xorl	%eax, %ecx
00000001000046b6	movzbl	%cl, %eax
00000001000046b9	leaq	_fwp_gc(%rip), %rcx
00000001000046c0	movq	0x1218(%rcx,%rax,8), %rax
00000001000046c8	testq	%rax, %rax
00000001000046cb	je	0x1000046de
00000001000046cd	nopl	(%rax)
00000001000046d0	cmpq	%rdi, (%rax)
00000001000046d3	je	0x10000470c
00000001000046d5	movq	0x10(%rax), %rax
00000001000046d9	testq	%rax, %rax
00000001000046dc	jne	0x1000046d0
00000001000046de	callq	_fwp_flush
00000001000046e3	movq	0x694e(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000046ea	movq	(%rax), %rdi
00000001000046ed	leaq	0x53b0(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000046f4	leaq	0x53b8(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000046fb	xorl	%eax, %eax
00000001000046fd	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100004702	movl	$0x65, %edi
0000000100004707	callq	0x10000978e                     ## symbol stub for: _exit
000000010000470c	movq	0x8(%rax), %rcx
0000000100004710	decq	%rcx
0000000100004713	movq	%rcx, 0x8(%rax)
0000000100004717	cmpq	$0xfe, %rcx
000000010000471e	jne	0x10000472b
0000000100004720	movq	%rdi, %rbx
0000000100004723	callq	_fwp_rc_forget_slot
0000000100004728	movb	$-0x2, (%rbx)
000000010000472b	addq	$0x8, %rsp
000000010000472f	popq	%rbx
0000000100004730	popq	%rbp
0000000100004731	retq
0000000100004732	nopw	%cs:(%rax,%rax)
_fwp_rc_wide_dup:
0000000100004740	pushq	%rbp
0000000100004741	movq	%rsp, %rbp
0000000100004744	pushq	%r14
0000000100004746	pushq	%rbx
0000000100004747	movq	%rdi, %rbx
000000010000474a	movq	%rdi, %rax
000000010000474d	shrq	$0x11, %rax
0000000100004751	xorl	%ebx, %eax
0000000100004753	movl	%eax, %ecx
0000000100004755	shrl	$0x9, %ecx
0000000100004758	xorl	%eax, %ecx
000000010000475a	movzbl	%cl, %eax
000000010000475d	leaq	_fwp_gc(%rip), %rcx
0000000100004764	leaq	(%rcx,%rax,8), %r14
0000000100004768	addq	$0x1218, %r14                   ## imm = 0x1218
000000010000476f	movq	0x1218(%rcx,%rax,8), %rax
0000000100004777	testq	%rax, %rax
000000010000477a	je	0x1000047a3
000000010000477c	cmpq	%rbx, (%rax)
000000010000477f	je	0x1000047b0
0000000100004781	nopw	%cs:(%rax,%rax)
0000000100004790	movq	%rax, %r14
0000000100004793	movq	0x10(%rax), %rax
0000000100004797	testq	%rax, %rax
000000010000479a	je	0x1000047aa
000000010000479c	cmpq	%rbx, (%rax)
000000010000479f	jne	0x100004790
00000001000047a1	jmp	0x1000047ac
00000001000047a3	cmpb	$-0x2, (%rbx)
00000001000047a6	je	0x1000047be
00000001000047a8	jmp	0x100004814
00000001000047aa	xorl	%eax, %eax
00000001000047ac	addq	$0x10, %r14
00000001000047b0	cmpb	$-0x2, (%rbx)
00000001000047b3	jne	0x1000047f6
00000001000047b5	testq	%rax, %rax
00000001000047b8	jne	0x10000485d
00000001000047be	movl	$0x18, %edi
00000001000047c3	callq	0x1000097e2                     ## symbol stub for: _malloc
00000001000047c8	testq	%rax, %rax
00000001000047cb	je	0x100004833
00000001000047cd	movq	%rbx, (%rax)
00000001000047d0	movq	$0xff, 0x8(%rax)
00000001000047d8	movq	$0x0, 0x10(%rax)
00000001000047e0	movq	%rax, (%r14)
00000001000047e3	movb	$-0x1, (%rbx)
00000001000047e6	leaq	0x9233(%rip), %rax
00000001000047ed	movq	0x922c(%rip), %rcx
00000001000047f4	jmp	0x100004809
00000001000047f6	testq	%rax, %rax
00000001000047f9	je	0x100004814
00000001000047fb	movq	0x8(%rax), %rcx
00000001000047ff	cmpq	$-0x1, %rcx
0000000100004803	je	0x10000487c
0000000100004805	addq	$0x8, %rax
0000000100004809	incq	%rcx
000000010000480c	movq	%rcx, (%rax)
000000010000480f	popq	%rbx
0000000100004810	popq	%r14
0000000100004812	popq	%rbp
0000000100004813	retq
0000000100004814	callq	_fwp_flush
0000000100004819	movq	0x6818(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004820	movq	(%rax), %rdi
0000000100004823	leaq	0x527a(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000482a	leaq	0x5282(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100004831	jmp	0x100004899
0000000100004833	movq	0x67fe(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000483a	movq	(%rax), %rcx
000000010000483d	leaq	0x535e(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004844	movl	$0x13, %esi
0000000100004849	movl	$0x1, %edx
000000010000484e	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100004853	movl	$0x66, %edi
0000000100004858	callq	0x10000978e                     ## symbol stub for: _exit
000000010000485d	callq	_fwp_flush
0000000100004862	movq	0x67cf(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004869	movq	(%rax), %rdi
000000010000486c	leaq	0x5231(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004873	leaq	0x53c3(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
000000010000487a	jmp	0x100004899
000000010000487c	callq	_fwp_flush
0000000100004881	movq	0x67b0(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004888	movq	(%rax), %rdi
000000010000488b	leaq	0x5212(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004892	leaq	0x53c9(%rip), %rdx              ## literal pool for: "reference count overflow"
0000000100004899	xorl	%eax, %eax
000000010000489b	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000048a0	movl	$0x65, %edi
00000001000048a5	callq	0x10000978e                     ## symbol stub for: _exit
00000001000048aa	nopw	(%rax,%rax)
_fwp_alloc_init:
00000001000048b0	pushq	%rbp
00000001000048b1	movq	%rsp, %rbp
00000001000048b4	pushq	%rbx
00000001000048b5	pushq	%rax
00000001000048b6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
00000001000048bd	ja	0x1000049ad
00000001000048c3	leaq	0xf(%rdi), %rdx
00000001000048c7	shrq	$0x4, %rdx
00000001000048cb	leaq	_fwp_gc(%rip), %rax
00000001000048d2	movzbl	0xbe8(%rdx,%rax), %ecx
00000001000048da	movl	0xb48(%rax,%rcx,4), %esi
00000001000048e1	movq	_fwp_gc(%rip), %r8
00000001000048e8	movq	%r8, %r9
00000001000048eb	subq	%rsi, %r9
00000001000048ee	movq	%r9, _fwp_gc(%rip)
00000001000048f5	js	0x1000049ad
00000001000048fb	leaq	(%rcx,%rcx,2), %r9
00000001000048ff	leaq	(%rax,%r9,8), %r9
0000000100004903	addq	$0x8, %r9
0000000100004907	movq	(%r9), %rbx
000000010000490a	testq	%rbx, %rbx
000000010000490d	je	0x100004944
000000010000490f	movq	(%rbx), %rax
0000000100004912	notq	%rax
0000000100004915	movq	%rax, (%r9)
0000000100004918	andl	$0x7ff8, %edi                   ## imm = 0x7FF8
000000010000491e	cmpq	%rsi, %rdi
0000000100004921	jae	0x1000049ca
0000000100004927	leaq	(%rbx,%rdi), %rax
000000010000492b	notq	%rdi
000000010000492e	addq	%rsi, %rdi
0000000100004931	andq	$-0x8, %rdi
0000000100004935	addq	$0x8, %rdi
0000000100004939	movq	%rdi, %rsi
000000010000493c	movq	%rax, %rdi
000000010000493f	jmp	0x1000049c5
0000000100004944	movq	0x8(%r9), %rbx
0000000100004948	movq	0x10(%r9), %r10
000000010000494c	subq	%rbx, %r10
000000010000494f	cmpq	%rsi, %r10
0000000100004952	jb	0x10000497c
0000000100004954	leaq	(%rbx,%rsi), %rcx
0000000100004958	movq	%rcx, 0x8(%r9)
000000010000495c	testq	%rbx, %rbx
000000010000495f	jne	0x100004918
0000000100004961	movzbl	0xbe8(%rdx,%rax), %ecx
0000000100004969	movl	0xb48(%rax,%rcx,4), %esi
0000000100004970	subq	%rsi, %r8
0000000100004973	movq	%r8, _fwp_gc(%rip)
000000010000497a	js	0x1000049ad
000000010000497c	leaq	(%rcx,%rcx,2), %rdx
0000000100004980	leaq	(%rax,%rdx,8), %rcx
0000000100004984	addq	$0x8, %rcx
0000000100004988	movq	0x8(%rax,%rdx,8), %rbx
000000010000498d	testq	%rbx, %rbx
0000000100004990	je	0x10000499d
0000000100004992	movq	(%rbx), %rax
0000000100004995	notq	%rax
0000000100004998	movq	%rax, (%rcx)
000000010000499b	jmp	0x1000049c2
000000010000499d	movq	0x8(%rcx), %rbx
00000001000049a1	movq	0x10(%rcx), %rax
00000001000049a5	subq	%rbx, %rax
00000001000049a8	cmpq	%rsi, %rax
00000001000049ab	jae	0x1000049ba
00000001000049ad	xorl	%esi, %esi
00000001000049af	addq	$0x8, %rsp
00000001000049b3	popq	%rbx
00000001000049b4	popq	%rbp
00000001000049b5	jmp	_fwp_gc_alloc_slow
00000001000049ba	leaq	(%rbx,%rsi), %rax
00000001000049be	movq	%rax, 0x8(%rcx)
00000001000049c2	movq	%rbx, %rdi
00000001000049c5	callq	0x10000972e                     ## symbol stub for: ___bzero
00000001000049ca	movq	%rbx, %rax
00000001000049cd	addq	$0x8, %rsp
00000001000049d1	popq	%rbx
00000001000049d2	popq	%rbp
00000001000049d3	retq
00000001000049d4	nopw	%cs:(%rax,%rax)
_fwp_rc_cleanup_cell:
00000001000049e0	pushq	%rbp
00000001000049e1	movq	%rsp, %rbp
00000001000049e4	movq	%rdi, %rax
00000001000049e7	movq	(%rdi), %rdi
00000001000049ea	movq	$0x0, (%rax)
00000001000049f1	testq	%rdi, %rdi
00000001000049f4	je	0x1000049fc
00000001000049f6	popq	%rbp
00000001000049f7	jmp	_fwp_rc_free_obj
00000001000049fc	popq	%rbp
00000001000049fd	retq
00000001000049fe	nop
_fwp_rc_free_obj:
0000000100004a00	pushq	%rbp
0000000100004a01	movq	%rsp, %rbp
0000000100004a04	pushq	%r15
0000000100004a06	pushq	%r14
0000000100004a08	pushq	%rbx
0000000100004a09	pushq	%rax
0000000100004a0a	movq	%rdi, %rax
0000000100004a0d	subq	0x8624(%rip), %rax
0000000100004a14	movq	0x8645(%rip), %rcx
0000000100004a1b	shlq	$0x10, %rcx
0000000100004a1f	cmpq	%rcx, %rax
0000000100004a22	jae	0x100004b3f
0000000100004a28	movq	0x8651(%rip), %rcx
0000000100004a2f	movq	%rax, %rdx
0000000100004a32	shrq	$0x10, %rdx
0000000100004a36	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004a3d	leaq	(%rcx,%rdx), %rbx
0000000100004a41	movzbl	(%rcx,%rdx), %r14d
0000000100004a46	cmpb	$0x2, %r14b
0000000100004a4a	setne	%cl
0000000100004a4d	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100004a53	setne	%dl
0000000100004a56	orb	%cl, %dl
0000000100004a58	jne	0x100004a6b
0000000100004a5a	leaq	0x228(%rbx), %rax
0000000100004a61	cmpb	$0x1, (%rax)
0000000100004a64	je	0x100004a92
0000000100004a66	jmp	0x100004b3f
0000000100004a6b	cmpb	$0x1, %r14b
0000000100004a6f	jne	0x100004b3f
0000000100004a75	movl	0x20(%rbx), %ecx
0000000100004a78	imulq	%rcx, %rax
0000000100004a7c	shrq	$0x20, %rax
0000000100004a80	addq	%rbx, %rax
0000000100004a83	addq	$0x228, %rax                    ## imm = 0x228
0000000100004a89	cmpb	$0x1, (%rax)
0000000100004a8c	jne	0x100004b3f
0000000100004a92	movl	_fwp_reuse_verify(%rip), %eax
0000000100004a98	testl	%eax, %eax
0000000100004a9a	js	0x100004afb
0000000100004a9c	testl	%eax, %eax
0000000100004a9e	je	0x100004b14
0000000100004aa0	cmpb	$0x1, 0x1(%rbx)
0000000100004aa4	jne	0x100004ab2
0000000100004aa6	cmpb	$0x2, %r14b
0000000100004aaa	jne	0x100004ade
0000000100004aac	movq	0x18(%rbx), %rdx
0000000100004ab0	jmp	0x100004ae1
0000000100004ab2	movl	$0xdead, (%rdi)                 ## imm = 0xDEAD
0000000100004ab8	movl	0x4(%rdi), %edx
0000000100004abb	testq	%rdx, %rdx
0000000100004abe	je	0x100004b3f
0000000100004ac0	addq	$0x8, %rdi
0000000100004ac4	shlq	$0x3, %rdx
0000000100004ac8	leaq	0x4eb1(%rip), %rsi
0000000100004acf	addq	$0x8, %rsp
0000000100004ad3	popq	%rbx
0000000100004ad4	popq	%r14
0000000100004ad6	popq	%r15
0000000100004ad8	popq	%rbp
0000000100004ad9	jmp	0x1000097f4                     ## symbol stub for: _memset_pattern16
0000000100004ade	movl	0x8(%rbx), %edx
0000000100004ae1	movq	%rdi, %rbx
0000000100004ae4	movl	$0xdd, %esi
0000000100004ae9	callq	0x1000097ee                     ## symbol stub for: _memset
0000000100004aee	movq	$0x0, (%rbx)
0000000100004af5	movb	$0x0, 0x8(%rbx)
0000000100004af9	jmp	0x100004b3f
0000000100004afb	leaq	-0x1c(%rbp), %rax
0000000100004aff	movq	%rdi, %r15
0000000100004b02	movq	%rax, %rdi
0000000100004b05	callq	_fwp_rc_free_obj.cold.1
0000000100004b0a	movq	%r15, %rdi
0000000100004b0d	movl	-0x1c(%rbp), %eax
0000000100004b10	testl	%eax, %eax
0000000100004b12	jne	0x100004aa0
0000000100004b14	movq	_fwp_gc(%rip), %rbx
0000000100004b1b	callq	_fwp_mem_free
0000000100004b20	movq	_fwp_gc(%rip), %rax
0000000100004b27	subq	%rbx, %rax
0000000100004b2a	cvtsi2sd	%rax, %xmm0
0000000100004b2f	addsd	0x86d9(%rip), %xmm0
0000000100004b37	movsd	%xmm0, 0x86d1(%rip)
0000000100004b3f	addq	$0x8, %rsp
0000000100004b43	popq	%rbx
0000000100004b44	popq	%r14
0000000100004b46	popq	%r15
0000000100004b48	popq	%rbp
0000000100004b49	retq
0000000100004b4a	nopw	(%rax,%rax)
_fwp_mem_free:
0000000100004b50	testq	%rdi, %rdi
0000000100004b53	je	0x100004d65
0000000100004b59	movq	0x84d8(%rip), %rax
0000000100004b60	movq	%rdi, %rcx
0000000100004b63	subq	%rax, %rcx
0000000100004b66	movq	0x84f3(%rip), %rdx
0000000100004b6d	shlq	$0x10, %rdx
0000000100004b71	cmpq	%rdx, %rcx
0000000100004b74	jae	0x100004d65
0000000100004b7a	pushq	%rbp
0000000100004b7b	movq	%rsp, %rbp
0000000100004b7e	pushq	%r15
0000000100004b80	pushq	%r14
0000000100004b82	pushq	%r13
0000000100004b84	pushq	%r12
0000000100004b86	pushq	%rbx
0000000100004b87	pushq	%rax
0000000100004b88	movq	0x84f1(%rip), %r14
0000000100004b8f	testq	%r14, %r14
0000000100004b92	je	0x100004d57
0000000100004b98	movq	%rcx, %rbx
0000000100004b9b	shrq	$0x10, %rbx
0000000100004b9f	imulq	$0x1228, %rbx, %r15             ## imm = 0x1228
0000000100004ba6	addq	%r15, %r14
0000000100004ba9	movzbl	(%r14), %edx
0000000100004bad	cmpl	$0x2, %edx
0000000100004bb0	je	0x100004c5e
0000000100004bb6	cmpl	$0x1, %edx
0000000100004bb9	jne	0x100004d57
0000000100004bbf	movzbl	0x1(%r14), %eax
0000000100004bc4	movzbl	0x2(%r14), %r8d
0000000100004bc9	imulq	$0x3c0, %rax, %r9               ## imm = 0x3C0
0000000100004bd0	movl	0x8(%r14), %esi
0000000100004bd4	movzwl	%di, %eax
0000000100004bd7	xorl	%edx, %edx
0000000100004bd9	divl	%esi
0000000100004bdb	movq	$-0x2, %rdx
0000000100004be2	movl	%eax, %ecx
0000000100004be4	rolq	%cl, %rdx
0000000100004be7	leaq	_fwp_gc(%rip), %r15
0000000100004bee	addq	%r9, %r15
0000000100004bf1	movl	%eax, %ecx
0000000100004bf3	shrl	$0x3, %ecx
0000000100004bf6	andl	$0x1ff8, %ecx                   ## imm = 0x1FF8
0000000100004bfc	andq	%rdx, 0x28(%r14,%rcx)
0000000100004c01	leaq	(%r8,%r8,2), %r12
0000000100004c05	leaq	(%r14,%rax), %rbx
0000000100004c09	addq	$0x228, %rbx                    ## imm = 0x228
0000000100004c10	cmpb	$-0x1, 0x228(%r14,%rax)
0000000100004c19	je	0x100004d66
0000000100004c1f	leaq	(%r15,%r12,8), %r15
0000000100004c23	addq	$0x8, %r15
0000000100004c27	movb	$0x0, (%rbx)
0000000100004c2a	cmpl	$0x0, 0x83db(%rip)
0000000100004c31	je	0x100004c44
0000000100004c33	movl	%esi, %esi
0000000100004c35	movq	%rdi, %rbx
0000000100004c38	callq	0x10000972e                     ## symbol stub for: ___bzero
0000000100004c3d	movq	%rbx, %rdi
0000000100004c40	movl	0x8(%r14), %esi
0000000100004c44	movq	(%r15), %rax
0000000100004c47	notq	%rax
0000000100004c4a	movq	%rax, (%rdi)
0000000100004c4d	movq	%rdi, (%r15)
0000000100004c50	movl	%esi, %eax
0000000100004c52	addq	%rax, _fwp_gc(%rip)
0000000100004c59	jmp	0x100004d57
0000000100004c5e	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100004c65	addq	%rcx, %rax
0000000100004c68	cmpq	%rdi, %rax
0000000100004c6b	jne	0x100004d57
0000000100004c71	movq	0x18(%r14), %rax
0000000100004c75	addq	%rax, _fwp_gc(%rip)
0000000100004c7c	movb	$0x0, 0x3(%r14)
0000000100004c81	cmpb	$-0x1, 0x228(%r14)
0000000100004c89	je	0x100004d7d
0000000100004c8f	movb	$0x0, 0x228(%r14)
0000000100004c97	movl	0x10(%r14), %eax
0000000100004c9b	testq	%rax, %rax
0000000100004c9e	je	0x100004d30
0000000100004ca4	movq	0x83d5(%rip), %rcx
0000000100004cab	movl	%eax, %edx
0000000100004cad	andl	$0x3, %edx
0000000100004cb0	cmpl	$0x4, %eax
0000000100004cb3	jae	0x100004cb9
0000000100004cb5	xorl	%esi, %esi
0000000100004cb7	jmp	0x100004cf8
0000000100004cb9	leaq	(%rcx,%r15), %rdi
0000000100004cbd	movl	%eax, %r8d
0000000100004cc0	andl	$-0x4, %r8d
0000000100004cc4	xorl	%esi, %esi
0000000100004cc6	nopw	%cs:(%rax,%rax)
0000000100004cd0	movb	$0x0, (%rdi)
0000000100004cd3	movb	$0x0, 0x1228(%rdi)
0000000100004cda	movb	$0x0, 0x2450(%rdi)
0000000100004ce1	movb	$0x0, 0x3678(%rdi)
0000000100004ce8	addq	$0x4, %rsi
0000000100004cec	addq	$0x48a0, %rdi                   ## imm = 0x48A0
0000000100004cf3	cmpq	%rsi, %r8
0000000100004cf6	jne	0x100004cd0
0000000100004cf8	testq	%rdx, %rdx
0000000100004cfb	je	0x100004d30
0000000100004cfd	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100004d04	addq	%r15, %rsi
0000000100004d07	addq	%rsi, %rcx
0000000100004d0a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004d11	xorl	%esi, %esi
0000000100004d13	nopw	%cs:(%rax,%rax)
0000000100004d20	movb	$0x0, (%rcx,%rsi)
0000000100004d24	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100004d2b	cmpq	%rsi, %rdx
0000000100004d2e	jne	0x100004d20
0000000100004d30	addq	%rax, 0x84b1(%rip)
0000000100004d37	cmpq	0x833a(%rip), %rbx
0000000100004d3e	jae	0x100004d47
0000000100004d40	movq	%rbx, 0x8331(%rip)
0000000100004d47	cmpq	0x8322(%rip), %rbx
0000000100004d4e	jae	0x100004d57
0000000100004d50	movq	%rbx, 0x8319(%rip)
0000000100004d57	addq	$0x8, %rsp
0000000100004d5b	popq	%rbx
0000000100004d5c	popq	%r12
0000000100004d5e	popq	%r13
0000000100004d60	popq	%r14
0000000100004d62	popq	%r15
0000000100004d64	popq	%rbp
0000000100004d65	retq
0000000100004d66	movq	%rdi, %r13
0000000100004d69	movq	%rbx, %rdi
0000000100004d6c	callq	_fwp_rc_forget_slot
0000000100004d71	movq	%r13, %rdi
0000000100004d74	movl	0x8(%r14), %esi
0000000100004d78	jmp	0x100004c1f
0000000100004d7d	leaq	0x228(%r14), %rdi
0000000100004d84	callq	_fwp_rc_forget_slot
0000000100004d89	jmp	0x100004c8f
0000000100004d8e	nop
_fwp_value_release:
0000000100004d90	pushq	%rbp
0000000100004d91	movq	%rsp, %rbp
0000000100004d94	movq	%rdi, %rax
0000000100004d97	movq	(%rdi), %rdi
0000000100004d9a	movq	0x8(%rax), %rcx
0000000100004d9e	movq	$0x0, (%rax)
0000000100004da5	testq	%rcx, %rcx
0000000100004da8	setne	%al
0000000100004dab	testq	%rdi, %rdi
0000000100004dae	setne	%dl
0000000100004db1	andb	%al, %dl
0000000100004db3	cmpb	$0x1, %dl
0000000100004db6	jne	0x100004dbb
0000000100004db8	popq	%rbp
0000000100004db9	jmpq	*%rcx
0000000100004dbb	popq	%rbp
0000000100004dbc	retq
0000000100004dbd	nopl	(%rax)
_fwp_owned_entry2:
0000000100004dc0	pushq	%rbp
0000000100004dc1	movq	%rsp, %rbp
0000000100004dc4	subq	$0x20, %rsp
0000000100004dc8	movq	0x6261(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100004dcf	movq	(%rax), %rax
0000000100004dd2	movq	%rax, -0x8(%rbp)
0000000100004dd6	movq	(%rdi), %rax
0000000100004dd9	movdqu	0x8(%rdi), %xmm0
0000000100004dde	pshufd	$0x4e, %xmm0, %xmm0             ## xmm0 = xmm0[2,3,0,1]
0000000100004de3	movdqa	%xmm0, -0x20(%rbp)
0000000100004de8	leaq	-0x20(%rbp), %rdx
0000000100004dec	movq	%rax, %rdi
0000000100004def	movl	$0x2, %esi
0000000100004df4	callq	_fwp_apply_owned
0000000100004df9	movq	0x6230(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100004e00	movq	(%rcx), %rcx
0000000100004e03	cmpq	-0x8(%rbp), %rcx
0000000100004e07	jne	0x100004e0f
0000000100004e09	addq	$0x20, %rsp
0000000100004e0d	popq	%rbp
0000000100004e0e	retq
0000000100004e0f	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100004e14	nopw	%cs:(%rax,%rax)
_fwp_caps2:
0000000100004e20	testl	%esi, %esi
0000000100004e22	je	0x100004e32
0000000100004e24	movl	0x4(%rdi), %edx
0000000100004e27	addq	$0x8, %rdi
0000000100004e2b	xorl	%esi, %esi
0000000100004e2d	jmp	_fwp_args2
0000000100004e32	pushq	%rbp
0000000100004e33	movq	%rsp, %rbp
0000000100004e36	pushq	%rbx
0000000100004e37	pushq	%rax
0000000100004e38	cmpl	$0x0, 0x4(%rdi)
0000000100004e3c	je	0x100004f11
0000000100004e42	movq	0x8(%rdi), %rax
0000000100004e46	movq	%rdi, %rbx
0000000100004e49	movq	%rax, %rdi
0000000100004e4c	callq	_fwp_closure_drop
0000000100004e51	movq	%rbx, %rdi
0000000100004e54	cmpl	$0x2, 0x4(%rbx)
0000000100004e58	jb	0x100004f11
0000000100004e5e	movq	0x10(%rdi), %rdi
0000000100004e62	callq	_fwp_closure_drop
0000000100004e67	movq	%rbx, %rdi
0000000100004e6a	cmpl	$0x3, 0x4(%rbx)
0000000100004e6e	jb	0x100004f11
0000000100004e74	movq	0x18(%rdi), %rax
0000000100004e78	movq	%rax, %rdx
0000000100004e7b	subq	0x81b6(%rip), %rdx
0000000100004e82	movq	0x81d7(%rip), %rcx
0000000100004e89	shlq	$0x10, %rcx
0000000100004e8d	cmpq	%rcx, %rdx
0000000100004e90	jae	0x100004f11
0000000100004e92	movq	0x81e7(%rip), %rsi
0000000100004e99	movq	%rdx, %rcx
0000000100004e9c	shrq	$0x10, %rcx
0000000100004ea0	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
0000000100004ea7	leaq	(%rsi,%r8), %rcx
0000000100004eab	movzbl	(%rsi,%r8), %esi
0000000100004eb0	cmpb	$0x2, %sil
0000000100004eb4	setne	%r8b
0000000100004eb8	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100004ebf	setne	%r9b
0000000100004ec3	orb	%r8b, %r9b
0000000100004ec6	jne	0x100004ed1
0000000100004ec8	addq	$0x228, %rcx                    ## imm = 0x228
0000000100004ecf	jmp	0x100004eec
0000000100004ed1	cmpb	$0x1, %sil
0000000100004ed5	jne	0x100004f11
0000000100004ed7	movl	0x20(%rcx), %esi
0000000100004eda	imulq	%rsi, %rdx
0000000100004ede	shrq	$0x20, %rdx
0000000100004ee2	addq	%rdx, %rcx
0000000100004ee5	addq	$0x228, %rcx                    ## imm = 0x228
0000000100004eec	movzbl	(%rcx), %edx
0000000100004eef	testl	%edx, %edx
0000000100004ef1	je	0x100004f11
0000000100004ef3	cmpl	$0x1, %edx
0000000100004ef6	jne	0x100004f05
0000000100004ef8	movq	%rax, %rdi
0000000100004efb	callq	_fwp_rc_free_obj
0000000100004f00	movq	%rbx, %rdi
0000000100004f03	jmp	0x100004f11
0000000100004f05	cmpl	$0xff, %edx
0000000100004f0b	je	0x100004f1c
0000000100004f0d	decb	%dl
0000000100004f0f	movb	%dl, (%rcx)
0000000100004f11	addq	$0x8, %rsp
0000000100004f15	popq	%rbx
0000000100004f16	popq	%rbp
0000000100004f17	jmp	_fwp_rc_free_obj
0000000100004f1c	movq	%rcx, %rdi
0000000100004f1f	callq	_fwp_rc_wide_drop
0000000100004f24	jmp	0x100004f00
0000000100004f26	nopw	%cs:(%rax,%rax)
_fwp_args2:
0000000100004f30	pushq	%rbp
0000000100004f31	movq	%rsp, %rbp
0000000100004f34	pushq	%r15
0000000100004f36	pushq	%r14
0000000100004f38	pushq	%r12
0000000100004f3a	pushq	%rbx
0000000100004f3b	subq	$0x30, %rsp
0000000100004f3f	movq	%rdi, -0x38(%rbp)
0000000100004f43	leaq	_fwp_arg_drop2(%rip), %rax
0000000100004f4a	movq	%rax, -0x30(%rbp)
0000000100004f4e	movl	%esi, -0x28(%rbp)
0000000100004f51	movl	$0x0, -0x24(%rbp)
0000000100004f58	movq	_fwp_cleanups(%rip), %rax
0000000100004f5f	movq	%rax, -0x50(%rbp)
0000000100004f63	leaq	_fwp_args_release(%rip), %rax
0000000100004f6a	movq	%rax, -0x48(%rbp)
0000000100004f6e	leaq	-0x38(%rbp), %rax
0000000100004f72	movq	%rax, -0x40(%rbp)
0000000100004f76	leaq	-0x50(%rbp), %rbx
0000000100004f7a	movq	%rbx, _fwp_cleanups(%rip)
0000000100004f81	testl	%esi, %esi
0000000100004f83	setne	%al
0000000100004f86	testl	%edx, %edx
0000000100004f88	sete	%cl
0000000100004f8b	orb	%al, %cl
0000000100004f8d	je	0x100004fa6
0000000100004f8f	cmpl	$0x1, %esi
0000000100004f92	jbe	0x100005034
0000000100004f98	cmpl	$0x2, %esi
0000000100004f9b	je	0x1000050d7
0000000100004fa1	jmp	0x100005171
0000000100004fa6	movq	(%rdi), %rcx
0000000100004fa9	subq	0x8088(%rip), %rcx
0000000100004fb0	movq	0x80a9(%rip), %rax
0000000100004fb7	shlq	$0x10, %rax
0000000100004fbb	cmpq	%rax, %rcx
0000000100004fbe	jae	0x10000502d
0000000100004fc0	movq	0x80b9(%rip), %r8
0000000100004fc7	movq	%rcx, %rax
0000000100004fca	shrq	$0x10, %rax
0000000100004fce	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100004fd5	leaq	(%r8,%r9), %rax
0000000100004fd9	movzbl	(%r8,%r9), %r8d
0000000100004fde	cmpb	$0x2, %r8b
0000000100004fe2	setne	%r9b
0000000100004fe6	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100004fed	setne	%r10b
0000000100004ff1	orb	%r9b, %r10b
0000000100004ff4	jne	0x100004ffe
0000000100004ff6	addq	$0x228, %rax                    ## imm = 0x228
0000000100004ffc	jmp	0x100005019
0000000100004ffe	cmpb	$0x1, %r8b
0000000100005002	jne	0x10000502d
0000000100005004	movl	0x20(%rax), %r8d
0000000100005008	imulq	%r8, %rcx
000000010000500c	shrq	$0x20, %rcx
0000000100005010	addq	%rcx, %rax
0000000100005013	addq	$0x228, %rax                    ## imm = 0x228
0000000100005019	movzbl	(%rax), %ecx
000000010000501c	testb	%cl, %cl
000000010000501e	je	0x10000502d
0000000100005020	cmpb	$-0x2, %cl
0000000100005023	jae	0x100005192
0000000100005029	incb	%cl
000000010000502b	movb	%cl, (%rax)
000000010000502d	movl	$0x1, -0x24(%rbp)
0000000100005034	movl	$0x1, %eax
0000000100005039	subl	%esi, %eax
000000010000503b	cmpl	%edx, %eax
000000010000503d	jae	0x1000050d7
0000000100005043	movl	%eax, %eax
0000000100005045	movq	(%rdi,%rax,8), %rcx
0000000100005049	subq	0x7fe8(%rip), %rcx
0000000100005050	movq	0x8009(%rip), %rax
0000000100005057	shlq	$0x10, %rax
000000010000505b	cmpq	%rax, %rcx
000000010000505e	jae	0x1000050cd
0000000100005060	movq	0x8019(%rip), %r8
0000000100005067	movq	%rcx, %rax
000000010000506a	shrq	$0x10, %rax
000000010000506e	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100005075	leaq	(%r8,%r9), %rax
0000000100005079	movzbl	(%r8,%r9), %r8d
000000010000507e	cmpb	$0x2, %r8b
0000000100005082	setne	%r9b
0000000100005086	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000508d	setne	%r10b
0000000100005091	orb	%r9b, %r10b
0000000100005094	jne	0x10000509e
0000000100005096	addq	$0x228, %rax                    ## imm = 0x228
000000010000509c	jmp	0x1000050b9
000000010000509e	cmpb	$0x1, %r8b
00000001000050a2	jne	0x1000050cd
00000001000050a4	movl	0x20(%rax), %r8d
00000001000050a8	imulq	%r8, %rcx
00000001000050ac	shrq	$0x20, %rcx
00000001000050b0	addq	%rcx, %rax
00000001000050b3	addq	$0x228, %rax                    ## imm = 0x228
00000001000050b9	movzbl	(%rax), %ecx
00000001000050bc	testb	%cl, %cl
00000001000050be	je	0x1000050cd
00000001000050c0	cmpb	$-0x2, %cl
00000001000050c3	jae	0x1000051be
00000001000050c9	incb	%cl
00000001000050cb	movb	%cl, (%rax)
00000001000050cd	movl	$0x2, %eax
00000001000050d2	subl	%esi, %eax
00000001000050d4	movl	%eax, -0x24(%rbp)
00000001000050d7	movl	$0x2, %eax
00000001000050dc	subl	%esi, %eax
00000001000050de	cmpl	%edx, %eax
00000001000050e0	jae	0x100005171
00000001000050e6	movl	%eax, %eax
00000001000050e8	movq	(%rdi,%rax,8), %rax
00000001000050ec	subq	0x7f45(%rip), %rax
00000001000050f3	movq	0x7f66(%rip), %rcx
00000001000050fa	shlq	$0x10, %rcx
00000001000050fe	cmpq	%rcx, %rax
0000000100005101	jae	0x100005167
0000000100005103	movq	0x7f76(%rip), %rcx
000000010000510a	movq	%rax, %rdx
000000010000510d	shrq	$0x10, %rdx
0000000100005111	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005118	leaq	(%rcx,%rdx), %rdi
000000010000511c	movzbl	(%rcx,%rdx), %ecx
0000000100005120	cmpb	$0x2, %cl
0000000100005123	setne	%dl
0000000100005126	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000512c	setne	%r8b
0000000100005130	orb	%dl, %r8b
0000000100005133	jne	0x10000513e
0000000100005135	addq	$0x228, %rdi                    ## imm = 0x228
000000010000513c	jmp	0x100005158
000000010000513e	cmpb	$0x1, %cl
0000000100005141	jne	0x100005167
0000000100005143	movl	0x20(%rdi), %ecx
0000000100005146	imulq	%rcx, %rax
000000010000514a	shrq	$0x20, %rax
000000010000514e	addq	%rax, %rdi
0000000100005151	addq	$0x228, %rdi                    ## imm = 0x228
0000000100005158	movzbl	(%rdi), %eax
000000010000515b	testb	%al, %al
000000010000515d	je	0x100005167
000000010000515f	cmpb	$-0x2, %al
0000000100005161	jae	0x1000051b1
0000000100005163	incb	%al
0000000100005165	movb	%al, (%rdi)
0000000100005167	movl	$0x3, %eax
000000010000516c	subl	%esi, %eax
000000010000516e	movl	%eax, -0x24(%rbp)
0000000100005171	cmpq	%rbx, _fwp_cleanups(%rip)
0000000100005178	jne	0x1000051dd
000000010000517a	movq	-0x50(%rbp), %rax
000000010000517e	movq	%rax, _fwp_cleanups(%rip)
0000000100005185	addq	$0x30, %rsp
0000000100005189	popq	%rbx
000000010000518a	popq	%r12
000000010000518c	popq	%r14
000000010000518e	popq	%r15
0000000100005190	popq	%rbp
0000000100005191	retq
0000000100005192	movq	%rdi, %r14
0000000100005195	movq	%rax, %rdi
0000000100005198	movl	%esi, %r15d
000000010000519b	movl	%edx, %r12d
000000010000519e	callq	_fwp_rc_wide_dup
00000001000051a3	movl	%r12d, %edx
00000001000051a6	movq	%r14, %rdi
00000001000051a9	movl	%r15d, %esi
00000001000051ac	jmp	0x10000502d
00000001000051b1	movl	%esi, %r14d
00000001000051b4	callq	_fwp_rc_wide_dup
00000001000051b9	movl	%r14d, %esi
00000001000051bc	jmp	0x100005167
00000001000051be	movq	%rdi, %r14
00000001000051c1	movq	%rax, %rdi
00000001000051c4	movl	%esi, %r15d
00000001000051c7	movl	%edx, %r12d
00000001000051ca	callq	_fwp_rc_wide_dup
00000001000051cf	movl	%r12d, %edx
00000001000051d2	movq	%r14, %rdi
00000001000051d5	movl	%r15d, %esi
00000001000051d8	jmp	0x1000050cd
00000001000051dd	callq	0x100009770                     ## symbol stub for: _abort
00000001000051e2	nopw	%cs:(%rax,%rax)
_fwp_arg_drop2:
00000001000051f0	pushq	%rbp
00000001000051f1	movq	%rsp, %rbp
00000001000051f4	pushq	%r15
00000001000051f6	pushq	%r14
00000001000051f8	pushq	%rbx
00000001000051f9	pushq	%rax
00000001000051fa	movl	%edx, %r14d
00000001000051fd	movl	%esi, %r15d
0000000100005200	movq	%rdi, %rbx
0000000100005203	testl	%esi, %esi
0000000100005205	setne	%al
0000000100005208	testl	%edx, %edx
000000010000520a	sete	%cl
000000010000520d	orb	%al, %cl
000000010000520f	je	0x100005222
0000000100005211	cmpl	$0x1, %r15d
0000000100005215	jbe	0x10000522a
0000000100005217	cmpl	$0x2, %r15d
000000010000521b	je	0x100005242
000000010000521d	jmp	0x1000052ef
0000000100005222	movq	(%rbx), %rdi
0000000100005225	callq	_fwp_closure_drop
000000010000522a	movl	$0x1, %eax
000000010000522f	subl	%r15d, %eax
0000000100005232	cmpl	%r14d, %eax
0000000100005235	jae	0x100005242
0000000100005237	movl	%eax, %eax
0000000100005239	movq	(%rbx,%rax,8), %rdi
000000010000523d	callq	_fwp_closure_drop
0000000100005242	movl	$0x2, %eax
0000000100005247	subl	%r15d, %eax
000000010000524a	cmpl	%r14d, %eax
000000010000524d	jae	0x1000052ef
0000000100005253	movl	%eax, %eax
0000000100005255	movq	(%rbx,%rax,8), %rdi
0000000100005259	movq	%rdi, %rcx
000000010000525c	subq	0x7dd5(%rip), %rcx
0000000100005263	movq	0x7df6(%rip), %rax
000000010000526a	shlq	$0x10, %rax
000000010000526e	cmpq	%rax, %rcx
0000000100005271	jae	0x1000052ef
0000000100005273	movq	0x7e06(%rip), %rdx
000000010000527a	movq	%rcx, %rax
000000010000527d	shrq	$0x10, %rax
0000000100005281	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100005288	leaq	(%rdx,%rsi), %rax
000000010000528c	movzbl	(%rdx,%rsi), %edx
0000000100005290	cmpb	$0x2, %dl
0000000100005293	setne	%sil
0000000100005297	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000529e	setne	%r8b
00000001000052a2	orb	%sil, %r8b
00000001000052a5	jne	0x1000052af
00000001000052a7	addq	$0x228, %rax                    ## imm = 0x228
00000001000052ad	jmp	0x1000052c8
00000001000052af	cmpb	$0x1, %dl
00000001000052b2	jne	0x1000052ef
00000001000052b4	movl	0x20(%rax), %edx
00000001000052b7	imulq	%rdx, %rcx
00000001000052bb	shrq	$0x20, %rcx
00000001000052bf	addq	%rcx, %rax
00000001000052c2	addq	$0x228, %rax                    ## imm = 0x228
00000001000052c8	movzbl	(%rax), %ecx
00000001000052cb	testl	%ecx, %ecx
00000001000052cd	je	0x1000052ef
00000001000052cf	cmpl	$0x1, %ecx
00000001000052d2	jne	0x1000052e3
00000001000052d4	addq	$0x8, %rsp
00000001000052d8	popq	%rbx
00000001000052d9	popq	%r14
00000001000052db	popq	%r15
00000001000052dd	popq	%rbp
00000001000052de	jmp	_fwp_rc_free_obj
00000001000052e3	cmpl	$0xff, %ecx
00000001000052e9	je	0x1000052fa
00000001000052eb	decb	%cl
00000001000052ed	movb	%cl, (%rax)
00000001000052ef	addq	$0x8, %rsp
00000001000052f3	popq	%rbx
00000001000052f4	popq	%r14
00000001000052f6	popq	%r15
00000001000052f8	popq	%rbp
00000001000052f9	retq
00000001000052fa	movq	%rax, %rdi
00000001000052fd	addq	$0x8, %rsp
0000000100005301	popq	%rbx
0000000100005302	popq	%r14
0000000100005304	popq	%r15
0000000100005306	popq	%rbp
0000000100005307	jmp	_fwp_rc_wide_drop
000000010000530c	nopl	(%rax)
_fwp_args_release:
0000000100005310	pushq	%rbp
0000000100005311	movq	%rsp, %rbp
0000000100005314	movl	0x14(%rdi), %edx
0000000100005317	movl	$0x0, 0x14(%rdi)
000000010000531e	testl	%edx, %edx
0000000100005320	je	0x100005332
0000000100005322	movq	(%rdi), %rax
0000000100005325	movq	0x8(%rdi), %rcx
0000000100005329	movl	0x10(%rdi), %esi
000000010000532c	movq	%rax, %rdi
000000010000532f	popq	%rbp
0000000100005330	jmpq	*%rcx
0000000100005332	popq	%rbp
0000000100005333	retq
0000000100005334	nopw	%cs:(%rax,%rax)
_fwp_p_file_with_owned:
0000000100005340	pushq	%rbp
0000000100005341	movq	%rsp, %rbp
0000000100005344	pushq	%r15
0000000100005346	pushq	%r14
0000000100005348	pushq	%r13
000000010000534a	pushq	%r12
000000010000534c	pushq	%rbx
000000010000534d	subq	$0x478, %rsp                    ## imm = 0x478
0000000100005354	movq	%rsi, %r12
0000000100005357	movq	%rdi, %rbx
000000010000535a	movq	0x5ccf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005361	movq	(%rax), %rax
0000000100005364	movq	%rax, -0x30(%rbp)
0000000100005368	leaq	0x8(%rdi), %r15
000000010000536c	leaq	0x4908(%rip), %rsi              ## literal pool for: "r+b"
0000000100005373	movq	%r15, %rdi
0000000100005376	callq	0x1000097a6                     ## symbol stub for: _fopen
000000010000537b	testq	%rax, %rax
000000010000537e	jne	0x100005398
0000000100005380	leaq	0x48f8(%rip), %rsi              ## literal pool for: "w+b"
0000000100005387	movq	%r15, %rdi
000000010000538a	callq	0x1000097a6                     ## symbol stub for: _fopen
000000010000538f	testq	%rax, %rax
0000000100005392	je	0x100005818
0000000100005398	movq	%rax, %r14
000000010000539b	movq	%rbx, -0x478(%rbp)
00000001000053a2	movq	%rax, -0x450(%rbp)
00000001000053a9	movq	$0x0, -0x448(%rbp)
00000001000053b4	movq	_fwp_cleanups(%rip), %rax
00000001000053bb	movq	%rax, -0x430(%rbp)
00000001000053c2	leaq	_fwp_close_owned_scoped_file(%rip), %rax
00000001000053c9	movq	%rax, -0x428(%rbp)
00000001000053d0	leaq	-0x450(%rbp), %rax
00000001000053d7	movq	%rax, -0x420(%rbp)
00000001000053de	leaq	-0x430(%rbp), %rax
00000001000053e5	movq	%rax, _fwp_cleanups(%rip)
00000001000053ec	movq	%r15, %rdi
00000001000053ef	callq	0x100009860                     ## symbol stub for: _strlen
00000001000053f4	cmpq	$-0x11, %rax
00000001000053f8	jae	0x1000057c4
00000001000053fe	movq	%rax, %r13
0000000100005401	leaq	0x11(%rax), %rsi
0000000100005405	cmpq	$0x3fef, %rax                   ## imm = 0x3FEF
000000010000540b	movq	%r12, -0x480(%rbp)
0000000100005412	ja	0x10000546e
0000000100005414	leaq	0x20(%r13), %rcx
0000000100005418	shrq	$0x4, %rcx
000000010000541c	leaq	_fwp_gc(%rip), %rax
0000000100005423	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000542b	movl	%ecx, %edx
000000010000542d	movl	0xb48(%rax,%rdx,4), %ecx
0000000100005434	subq	%rcx, _fwp_gc(%rip)
000000010000543b	js	0x10000546e
000000010000543d	leaq	(%rdx,%rdx,2), %rdx
0000000100005441	leaq	(%rax,%rdx,8), %rax
0000000100005445	addq	$0x3c8, %rax                    ## imm = 0x3C8
000000010000544b	movq	(%rax), %rbx
000000010000544e	testq	%rbx, %rbx
0000000100005451	je	0x10000545e
0000000100005453	movq	(%rbx), %rcx
0000000100005456	notq	%rcx
0000000100005459	movq	%rcx, (%rax)
000000010000545c	jmp	0x100005487
000000010000545e	movq	0x8(%rax), %rbx
0000000100005462	movq	0x10(%rax), %rdx
0000000100005466	subq	%rbx, %rdx
0000000100005469	cmpq	%rcx, %rdx
000000010000546c	jae	0x100005480
000000010000546e	movq	%rsi, %rdi
0000000100005471	movl	$0x1, %esi
0000000100005476	callq	_fwp_gc_alloc_slow
000000010000547b	movq	%rax, %r12
000000010000547e	jmp	0x100005492
0000000100005480	addq	%rbx, %rcx
0000000100005483	movq	%rcx, 0x8(%rax)
0000000100005487	movq	%rbx, %rdi
000000010000548a	callq	0x10000972e                     ## symbol stub for: ___bzero
000000010000548f	movq	%rbx, %r12
0000000100005492	movq	%r14, (%r12)
0000000100005496	movq	$0x1, 0x8(%r12)
000000010000549f	movq	%r12, %rcx
00000001000054a2	subq	0x7b8f(%rip), %rcx
00000001000054a9	movq	0x7bb0(%rip), %rax
00000001000054b0	shlq	$0x10, %rax
00000001000054b4	cmpq	%rax, %rcx
00000001000054b7	jae	0x100005527
00000001000054b9	movq	0x7bc0(%rip), %rdx
00000001000054c0	movq	%rcx, %rax
00000001000054c3	shrq	$0x10, %rax
00000001000054c7	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000054ce	leaq	(%rdx,%rsi), %rbx
00000001000054d2	movzbl	(%rdx,%rsi), %edx
00000001000054d6	cmpb	$0x2, %dl
00000001000054d9	setne	%sil
00000001000054dd	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000054e4	setne	%dil
00000001000054e8	orb	%sil, %dil
00000001000054eb	jne	0x1000054fe
00000001000054ed	addq	$0x228, %rbx                    ## imm = 0x228
00000001000054f4	cmpb	$-0x1, (%rbx)
00000001000054f7	je	0x10000551d
00000001000054f9	movb	$0x1, (%rbx)
00000001000054fc	jmp	0x100005527
00000001000054fe	cmpb	$0x1, %dl
0000000100005501	jne	0x100005527
0000000100005503	movl	0x20(%rbx), %edx
0000000100005506	imulq	%rdx, %rcx
000000010000550a	shrq	$0x20, %rcx
000000010000550e	addq	%rcx, %rbx
0000000100005511	addq	$0x228, %rbx                    ## imm = 0x228
0000000100005518	cmpb	$-0x1, (%rbx)
000000010000551b	jne	0x1000054f9
000000010000551d	movq	%rbx, %rdi
0000000100005520	callq	_fwp_rc_forget_slot
0000000100005525	jmp	0x1000054f9
0000000100005527	movq	%r12, -0x448(%rbp)
000000010000552e	leaq	0x10(%r12), %rdi
0000000100005533	incq	%r13
0000000100005536	movq	%r15, %rsi
0000000100005539	movq	%r13, %rdx
000000010000553c	callq	0x1000097e8                     ## symbol stub for: _memcpy
0000000100005541	leaq	-0x430(%rbp), %rdi
0000000100005548	cmpq	%rdi, _fwp_cleanups(%rip)
000000010000554f	jne	0x1000057bf
0000000100005555	movq	-0x430(%rbp), %rax
000000010000555c	movq	%r12, -0x488(%rbp)
0000000100005563	movq	%r14, -0x460(%rbp)
000000010000556a	movq	%r12, -0x458(%rbp)
0000000100005571	movq	%rax, -0x450(%rbp)
0000000100005578	leaq	_fwp_close_owned_scoped_file(%rip), %rcx
000000010000557f	movq	%rcx, -0x448(%rbp)
0000000100005586	leaq	-0x460(%rbp), %rcx
000000010000558d	movq	%rcx, -0x440(%rbp)
0000000100005594	leaq	-0x450(%rbp), %r13
000000010000559b	movq	%r13, _fwp_cleanups(%rip)
00000001000055a2	movq	_fwp_handlers(%rip), %rcx
00000001000055a9	movq	%rcx, -0x398(%rbp)
00000001000055b0	movq	_fwp_state_len(%rip), %rcx
00000001000055b7	movq	%rcx, -0x380(%rbp)
00000001000055be	movq	%rax, -0x378(%rbp)
00000001000055c5	movq	%rdi, _fwp_handlers(%rip)
00000001000055cc	callq	0x100009824                     ## symbol stub for: _setjmp
00000001000055d1	testl	%eax, %eax
00000001000055d3	jne	0x1000057f2
00000001000055d9	leaq	-0x488(%rbp), %rsi
00000001000055e0	movq	-0x480(%rbp), %r12
00000001000055e7	movq	%r12, %rdi
00000001000055ea	callq	_fwp_apply_borrowed
00000001000055ef	movq	-0x398(%rbp), %rcx
00000001000055f6	movq	%rcx, _fwp_handlers(%rip)
00000001000055fd	movq	%rax, -0x470(%rbp)
0000000100005604	leaq	_fwp_drop5(%rip), %rcx
000000010000560b	movq	%rcx, -0x468(%rbp)
0000000100005612	movq	_fwp_cleanups(%rip), %rcx
0000000100005619	movq	%rcx, -0x4a0(%rbp)
0000000100005620	leaq	_fwp_value_release(%rip), %rcx
0000000100005627	movq	%rcx, -0x498(%rbp)
000000010000562e	leaq	-0x470(%rbp), %rcx
0000000100005635	movq	%rcx, -0x490(%rbp)
000000010000563c	leaq	-0x4a0(%rbp), %rbx
0000000100005643	movq	%rbx, _fwp_cleanups(%rip)
000000010000564a	movq	0x8(%rax), %r15
000000010000564e	movq	%r15, %rdx
0000000100005651	subq	0x79e0(%rip), %rdx
0000000100005658	movq	0x7a01(%rip), %rcx
000000010000565f	shlq	$0x10, %rcx
0000000100005663	cmpq	%rcx, %rdx
0000000100005666	jae	0x1000056d9
0000000100005668	movq	0x7a11(%rip), %rsi
000000010000566f	movq	%rdx, %rcx
0000000100005672	shrq	$0x10, %rcx
0000000100005676	imulq	$0x1228, %rcx, %rdi             ## imm = 0x1228
000000010000567d	leaq	(%rsi,%rdi), %rcx
0000000100005681	movzbl	(%rsi,%rdi), %esi
0000000100005685	cmpb	$0x2, %sil
0000000100005689	setne	%dil
000000010000568d	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100005694	setne	%r8b
0000000100005698	orb	%dil, %r8b
000000010000569b	jne	0x1000056a9
000000010000569d	addq	$0x228, %rcx                    ## imm = 0x228
00000001000056a4	movq	%rcx, %rdi
00000001000056a7	jmp	0x1000056c5
00000001000056a9	cmpb	$0x1, %sil
00000001000056ad	jne	0x1000056d9
00000001000056af	movl	0x20(%rcx), %esi
00000001000056b2	imulq	%rsi, %rdx
00000001000056b6	shrq	$0x20, %rdx
00000001000056ba	leaq	(%rcx,%rdx), %rdi
00000001000056be	addq	$0x228, %rdi                    ## imm = 0x228
00000001000056c5	movzbl	(%rdi), %ecx
00000001000056c8	testb	%cl, %cl
00000001000056ca	je	0x1000056d9
00000001000056cc	cmpb	$-0x2, %cl
00000001000056cf	jae	0x1000057a1
00000001000056d5	incb	%cl
00000001000056d7	movb	%cl, (%rdi)
00000001000056d9	cmpq	$0x0, -0x468(%rbp)
00000001000056e1	je	0x1000056fe
00000001000056e3	cmpq	%rbx, _fwp_cleanups(%rip)
00000001000056ea	jne	0x1000057bf
00000001000056f0	movq	-0x4a0(%rbp), %rcx
00000001000056f7	movq	%rcx, _fwp_cleanups(%rip)
00000001000056fe	movq	%rax, %rdi
0000000100005701	movq	$0x0, -0x470(%rbp)
000000010000570c	callq	_fwp_drop5
0000000100005711	cmpq	%r13, _fwp_cleanups(%rip)
0000000100005718	jne	0x1000057bf
000000010000571e	movq	-0x450(%rbp), %rax
0000000100005725	movq	%rax, _fwp_cleanups(%rip)
000000010000572c	movq	-0x458(%rbp), %rbx
0000000100005733	testq	%rbx, %rbx
0000000100005736	je	0x10000574e
0000000100005738	movq	(%rbx), %rdi
000000010000573b	testq	%rdi, %rdi
000000010000573e	je	0x10000575a
0000000100005740	callq	0x100009794                     ## symbol stub for: _fclose
0000000100005745	movq	$0x0, (%rbx)
000000010000574c	jmp	0x10000575a
000000010000574e	movq	-0x460(%rbp), %rdi
0000000100005755	callq	0x100009794                     ## symbol stub for: _fclose
000000010000575a	movq	-0x458(%rbp), %rdi
0000000100005761	movq	$0x0, -0x458(%rbp)
000000010000576c	callq	_fwp_file_drop
0000000100005771	movq	-0x478(%rbp), %rax
0000000100005778	movq	0x58b1(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000577f	movq	(%rax), %rax
0000000100005782	cmpq	-0x30(%rbp), %rax
0000000100005786	jne	0x100005813
000000010000578c	movq	%r15, %rax
000000010000578f	addq	$0x478, %rsp                    ## imm = 0x478
0000000100005796	popq	%rbx
0000000100005797	popq	%r12
0000000100005799	popq	%r13
000000010000579b	popq	%r14
000000010000579d	popq	%r15
000000010000579f	popq	%rbp
00000001000057a0	retq
00000001000057a1	movq	%rax, %r14
00000001000057a4	callq	_fwp_rc_wide_dup
00000001000057a9	movq	%r14, %rax
00000001000057ac	cmpq	$0x0, -0x468(%rbp)
00000001000057b4	jne	0x1000056e3
00000001000057ba	jmp	0x1000056fe
00000001000057bf	callq	0x100009770                     ## symbol stub for: _abort
00000001000057c4	callq	_fwp_flush
00000001000057c9	movq	0x5868(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000057d0	movq	(%rax), %rdi
00000001000057d3	leaq	0x42ca(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000057da	leaq	0x44ae(%rip), %rdx              ## literal pool for: "file path too long"
00000001000057e1	xorl	%eax, %eax
00000001000057e3	callq	0x1000097ac                     ## symbol stub for: _fprintf
00000001000057e8	movl	$0x65, %edi
00000001000057ed	callq	0x10000978e                     ## symbol stub for: _exit
00000001000057f2	movq	-0x398(%rbp), %rax
00000001000057f9	movq	-0x390(%rbp), %rdi
0000000100005800	movq	%rax, _fwp_handlers(%rip)
0000000100005807	movq	-0x388(%rbp), %rsi
000000010000580e	callq	_fwp_fail
0000000100005813	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100005818	callq	0x10000973a                     ## symbol stub for: ___error
000000010000581d	movl	(%rax), %edi
000000010000581f	callq	0x10000985a                     ## symbol stub for: _strerror
0000000100005824	movq	%rax, %r8
0000000100005827	leaq	0x445a(%rip), %rdx              ## literal pool for: "%s: %s"
000000010000582e	xorl	%eax, %eax
0000000100005830	leaq	-0x430(%rbp), %rbx
0000000100005837	movl	$0x400, %esi                    ## imm = 0x400
000000010000583c	movq	%rbx, %rdi
000000010000583f	movq	%r15, %rcx
0000000100005842	callq	0x100009842                     ## symbol stub for: _snprintf
0000000100005847	leaq	0x4435(%rip), %rdi              ## literal pool for: "open"
000000010000584e	movl	$0x4, %esi
0000000100005853	callq	_fwp_str_new
0000000100005858	movq	%rax, %r14
000000010000585b	movq	%rax, -0x450(%rbp)
0000000100005862	movq	%rbx, %rdi
0000000100005865	callq	0x100009860                     ## symbol stub for: _strlen
000000010000586a	movq	%rbx, %rdi
000000010000586d	movq	%rax, %rsi
0000000100005870	callq	_fwp_str_new
0000000100005875	movq	%rax, %rbx
0000000100005878	movq	%rax, -0x448(%rbp)
000000010000587f	movl	$0x18, %edi
0000000100005884	callq	_fwp_alloc_init
0000000100005889	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100005893	movq	%rcx, (%rax)
0000000100005896	movq	%r14, 0x8(%rax)
000000010000589a	movq	%rbx, 0x10(%rax)
000000010000589e	leaq	-0x450(%rbp), %rcx
00000001000058a5	leaq	_d0(%rip), %rsi
00000001000058ac	movq	%rax, %rdi
00000001000058af	callq	_fwp_fail
00000001000058b4	nopw	%cs:(%rax,%rax)
_fwp_drop5:
00000001000058c0	movq	0x7771(%rip), %rcx
00000001000058c7	movq	%rdi, %r8
00000001000058ca	subq	%rcx, %r8
00000001000058cd	movq	0x778c(%rip), %rsi
00000001000058d4	shlq	$0x10, %rsi
00000001000058d8	cmpq	%rsi, %r8
00000001000058db	jae	0x1000059ab
00000001000058e1	movq	0x7798(%rip), %rdx
00000001000058e8	movq	%r8, %rax
00000001000058eb	shrq	$0x10, %rax
00000001000058ef	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
00000001000058f6	leaq	(%rdx,%r9), %rax
00000001000058fa	movzbl	(%rdx,%r9), %r9d
00000001000058ff	cmpb	$0x2, %r9b
0000000100005903	setne	%r10b
0000000100005907	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000590e	setne	%r11b
0000000100005912	orb	%r10b, %r11b
0000000100005915	jne	0x10000591f
0000000100005917	addq	$0x228, %rax                    ## imm = 0x228
000000010000591d	jmp	0x10000593e
000000010000591f	cmpb	$0x1, %r9b
0000000100005923	jne	0x1000059ab
0000000100005929	movl	0x20(%rax), %r9d
000000010000592d	imulq	%r9, %r8
0000000100005931	shrq	$0x20, %r8
0000000100005935	addq	%r8, %rax
0000000100005938	addq	$0x228, %rax                    ## imm = 0x228
000000010000593e	movzbl	(%rax), %r8d
0000000100005942	testl	%r8d, %r8d
0000000100005945	je	0x1000059ab
0000000100005947	cmpl	$0x1, %r8d
000000010000594b	jne	0x10000599c
000000010000594d	pushq	%rbp
000000010000594e	movq	%rsp, %rbp
0000000100005951	pushq	%rbx
0000000100005952	pushq	%rax
0000000100005953	movq	0x8(%rdi), %rax
0000000100005957	movq	%rax, %r8
000000010000595a	subq	%rcx, %r8
000000010000595d	cmpq	%rsi, %r8
0000000100005960	jae	0x1000059ee
0000000100005966	movq	%r8, %rcx
0000000100005969	shrq	$0x10, %rcx
000000010000596d	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100005974	leaq	(%rdx,%rsi), %rcx
0000000100005978	movzbl	(%rdx,%rsi), %edx
000000010000597c	cmpb	$0x2, %dl
000000010000597f	setne	%sil
0000000100005983	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000598a	setne	%r9b
000000010000598e	orb	%sil, %r9b
0000000100005991	jne	0x1000059ac
0000000100005993	addq	$0x228, %rcx                    ## imm = 0x228
000000010000599a	jmp	0x1000059c6
000000010000599c	cmpl	$0xff, %r8d
00000001000059a3	je	0x100005a0b
00000001000059a5	decb	%r8b
00000001000059a8	movb	%r8b, (%rax)
00000001000059ab	retq
00000001000059ac	cmpb	$0x1, %dl
00000001000059af	jne	0x1000059ee
00000001000059b1	movl	0x20(%rcx), %edx
00000001000059b4	imulq	%rdx, %r8
00000001000059b8	shrq	$0x20, %r8
00000001000059bc	addq	%r8, %rcx
00000001000059bf	addq	$0x228, %rcx                    ## imm = 0x228
00000001000059c6	movzbl	(%rcx), %edx
00000001000059c9	testl	%edx, %edx
00000001000059cb	je	0x1000059ee
00000001000059cd	cmpl	$0x1, %edx
00000001000059d0	jne	0x1000059e2
00000001000059d2	movq	%rdi, %rbx
00000001000059d5	movq	%rax, %rdi
00000001000059d8	callq	_fwp_rc_free_obj
00000001000059dd	movq	%rbx, %rdi
00000001000059e0	jmp	0x1000059ee
00000001000059e2	cmpl	$0xff, %edx
00000001000059e8	je	0x100005a13
00000001000059ea	decb	%dl
00000001000059ec	movb	%dl, (%rcx)
00000001000059ee	movq	0x10(%rdi), %rax
00000001000059f2	movq	%rdi, %rbx
00000001000059f5	movq	%rax, %rdi
00000001000059f8	callq	_fwp_file_drop
00000001000059fd	movq	%rbx, %rdi
0000000100005a00	addq	$0x8, %rsp
0000000100005a04	popq	%rbx
0000000100005a05	popq	%rbp
0000000100005a06	jmp	_fwp_rc_free_obj
0000000100005a0b	movq	%rax, %rdi
0000000100005a0e	jmp	_fwp_rc_wide_drop
0000000100005a13	movq	%rdi, %rbx
0000000100005a16	movq	%rcx, %rdi
0000000100005a19	callq	_fwp_rc_wide_drop
0000000100005a1e	jmp	0x1000059dd
_fwp_close_owned_scoped_file:
0000000100005a20	pushq	%rbp
0000000100005a21	movq	%rsp, %rbp
0000000100005a24	pushq	%r14
0000000100005a26	pushq	%rbx
0000000100005a27	movq	%rdi, %rbx
0000000100005a2a	movq	0x8(%rdi), %r14
0000000100005a2e	testq	%r14, %r14
0000000100005a31	je	0x100005a49
0000000100005a33	movq	(%r14), %rdi
0000000100005a36	testq	%rdi, %rdi
0000000100005a39	je	0x100005a51
0000000100005a3b	callq	0x100009794                     ## symbol stub for: _fclose
0000000100005a40	movq	$0x0, (%r14)
0000000100005a47	jmp	0x100005a51
0000000100005a49	movq	(%rbx), %rdi
0000000100005a4c	callq	0x100009794                     ## symbol stub for: _fclose
0000000100005a51	movq	0x8(%rbx), %rdi
0000000100005a55	movq	$0x0, 0x8(%rbx)
0000000100005a5d	popq	%rbx
0000000100005a5e	popq	%r14
0000000100005a60	popq	%rbp
0000000100005a61	jmp	_fwp_file_drop
0000000100005a66	nopw	%cs:(%rax,%rax)
_fwp_fail:
0000000100005a70	pushq	%rbp
0000000100005a71	movq	%rsp, %rbp
0000000100005a74	pushq	%r15
0000000100005a76	pushq	%r14
0000000100005a78	pushq	%rbx
0000000100005a79	pushq	%rax
0000000100005a7a	movq	_fwp_handlers(%rip), %rax
0000000100005a81	testq	%rax, %rax
0000000100005a84	jne	0x100005ad6
0000000100005a86	movq	%rsi, %rbx
0000000100005a89	movq	%rdi, %r14
0000000100005a8c	callq	_fwp_flush
0000000100005a91	movq	0x55a0(%rip), %r15              ## literal pool symbol address: ___stderrp
0000000100005a98	movq	(%r15), %rcx
0000000100005a9b	leaq	0x4200(%rip), %rdi              ## literal pool for: "error: "
0000000100005aa2	movl	$0x7, %esi
0000000100005aa7	movl	$0x1, %edx
0000000100005aac	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100005ab1	movq	(%r15), %rdx
0000000100005ab4	movq	%r14, %rdi
0000000100005ab7	movq	%rbx, %rsi
0000000100005aba	callq	_fwp_display_top
0000000100005abf	movq	(%r15), %rsi
0000000100005ac2	movl	$0xa, %edi
0000000100005ac7	callq	0x1000097b2                     ## symbol stub for: _fputc
0000000100005acc	movl	$0x1, %edi
0000000100005ad1	callq	0x10000978e                     ## symbol stub for: _exit
0000000100005ad6	movq	%rdi, 0xa0(%rax)
0000000100005add	movq	%rsi, 0xa8(%rax)
0000000100005ae4	movq	0xb8(%rax), %rdi
0000000100005aeb	callq	_fwp_cleanup_unwind
0000000100005af0	movq	_fwp_handlers(%rip), %rdi
0000000100005af7	movl	$0x1, %esi
0000000100005afc	callq	0x1000097dc                     ## symbol stub for: _longjmp
0000000100005b01	nopw	%cs:(%rax,%rax)
_fwp_str_new:
0000000100005b10	pushq	%rbp
0000000100005b11	movq	%rsp, %rbp
0000000100005b14	pushq	%r15
0000000100005b16	pushq	%r14
0000000100005b18	pushq	%rbx
0000000100005b19	pushq	%rax
0000000100005b1a	movq	%rsi, %r14
0000000100005b1d	movq	%rdi, %rbx
0000000100005b20	addq	$0x9, %rsi
0000000100005b24	cmpq	$0x4000, %rsi                   ## imm = 0x4000
0000000100005b2b	ja	0x100005b86
0000000100005b2d	leaq	0x18(%r14), %rax
0000000100005b31	shrq	$0x4, %rax
0000000100005b35	leaq	_fwp_gc(%rip), %rcx
0000000100005b3c	movzbl	0xbe8(%rax,%rcx), %edx
0000000100005b44	movl	0xb48(%rcx,%rdx,4), %eax
0000000100005b4b	subq	%rax, _fwp_gc(%rip)
0000000100005b52	js	0x100005b86
0000000100005b54	leaq	(%rdx,%rdx,2), %rdx
0000000100005b58	leaq	(%rcx,%rdx,8), %rcx
0000000100005b5c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100005b63	movq	(%rcx), %r15
0000000100005b66	testq	%r15, %r15
0000000100005b69	je	0x100005b76
0000000100005b6b	movq	(%r15), %rax
0000000100005b6e	notq	%rax
0000000100005b71	movq	%rax, (%rcx)
0000000100005b74	jmp	0x100005b9f
0000000100005b76	movq	0x8(%rcx), %r15
0000000100005b7a	movq	0x10(%rcx), %rdx
0000000100005b7e	subq	%r15, %rdx
0000000100005b81	cmpq	%rax, %rdx
0000000100005b84	jae	0x100005b98
0000000100005b86	movq	%rsi, %rdi
0000000100005b89	movl	$0x1, %esi
0000000100005b8e	callq	_fwp_gc_alloc_slow
0000000100005b93	movq	%rax, %r15
0000000100005b96	jmp	0x100005ba7
0000000100005b98	addq	%r15, %rax
0000000100005b9b	movq	%rax, 0x8(%rcx)
0000000100005b9f	movq	%r15, %rdi
0000000100005ba2	callq	0x10000972e                     ## symbol stub for: ___bzero
0000000100005ba7	movq	%r14, (%r15)
0000000100005baa	leaq	0x8(%r15), %rdi
0000000100005bae	movq	%rbx, %rsi
0000000100005bb1	movq	%r14, %rdx
0000000100005bb4	callq	0x1000097e8                     ## symbol stub for: _memcpy
0000000100005bb9	movb	$0x0, 0x8(%r15,%r14)
0000000100005bbf	movq	%r15, %rax
0000000100005bc2	addq	$0x8, %rsp
0000000100005bc6	popq	%rbx
0000000100005bc7	popq	%r14
0000000100005bc9	popq	%r15
0000000100005bcb	popq	%rbp
0000000100005bcc	retq
0000000100005bcd	nopl	(%rax)
_fwp_file_drop:
0000000100005bd0	testq	%rdi, %rdi
0000000100005bd3	je	0x100005d20
0000000100005bd9	pushq	%rbp
0000000100005bda	movq	%rsp, %rbp
0000000100005bdd	pushq	%rbx
0000000100005bde	pushq	%rax
0000000100005bdf	movq	0x8(%rdi), %rax
0000000100005be3	testq	%rax, %rax
0000000100005be6	je	0x100005d1a
0000000100005bec	decq	%rax
0000000100005bef	movq	%rax, 0x8(%rdi)
0000000100005bf3	jne	0x100005d1a
0000000100005bf9	movq	(%rdi), %rax
0000000100005bfc	testq	%rax, %rax
0000000100005bff	je	0x100005c16
0000000100005c01	movq	%rdi, %rbx
0000000100005c04	movq	%rax, %rdi
0000000100005c07	callq	0x100009794                     ## symbol stub for: _fclose
0000000100005c0c	movq	%rbx, %rdi
0000000100005c0f	movq	$0x0, (%rbx)
0000000100005c16	movq	%rdi, %rax
0000000100005c19	subq	0x7418(%rip), %rax
0000000100005c20	movq	0x7439(%rip), %rcx
0000000100005c27	shlq	$0x10, %rcx
0000000100005c2b	cmpq	%rcx, %rax
0000000100005c2e	jae	0x100005d1a
0000000100005c34	movq	0x7445(%rip), %rdx
0000000100005c3b	movq	%rax, %rcx
0000000100005c3e	shrq	$0x10, %rcx
0000000100005c42	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100005c49	leaq	(%rdx,%rsi), %rcx
0000000100005c4d	movzbl	(%rdx,%rsi), %edx
0000000100005c51	cmpb	$0x2, %dl
0000000100005c54	setne	%sil
0000000100005c58	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005c5e	setne	%r8b
0000000100005c62	orb	%sil, %r8b
0000000100005c65	jne	0x100005c78
0000000100005c67	addq	$0x228, %rcx                    ## imm = 0x228
0000000100005c6e	cmpb	$0x1, (%rcx)
0000000100005c71	je	0x100005c9b
0000000100005c73	jmp	0x100005d1a
0000000100005c78	cmpb	$0x1, %dl
0000000100005c7b	jne	0x100005d1a
0000000100005c81	movl	0x20(%rcx), %edx
0000000100005c84	imulq	%rdx, %rax
0000000100005c88	shrq	$0x20, %rax
0000000100005c8c	addq	%rax, %rcx
0000000100005c8f	addq	$0x228, %rcx                    ## imm = 0x228
0000000100005c96	cmpb	$0x1, (%rcx)
0000000100005c99	jne	0x100005d1a
0000000100005c9b	movl	_fwp_reuse_verify(%rip), %ecx
0000000100005ca1	testl	%ecx, %ecx
0000000100005ca3	jns	0x100005ce5
0000000100005ca5	movq	%rdi, %rbx
0000000100005ca8	leaq	0x3ea3(%rip), %rdi              ## literal pool for: "FWP_REUSE_VERIFY"
0000000100005caf	callq	0x1000097ca                     ## symbol stub for: _getenv
0000000100005cb4	testq	%rax, %rax
0000000100005cb7	je	0x100005cd3
0000000100005cb9	movzbl	(%rax), %ecx
0000000100005cbc	testl	%ecx, %ecx
0000000100005cbe	je	0x100005cd5
0000000100005cc0	cmpl	$0x30, %ecx
0000000100005cc3	movq	%rbx, %rdi
0000000100005cc6	jne	0x100005cda
0000000100005cc8	xorl	%ecx, %ecx
0000000100005cca	cmpb	$0x0, 0x1(%rax)
0000000100005cce	setne	%cl
0000000100005cd1	jmp	0x100005cdf
0000000100005cd3	xorl	%ecx, %ecx
0000000100005cd5	movq	%rbx, %rdi
0000000100005cd8	jmp	0x100005cdf
0000000100005cda	movl	$0x1, %ecx
0000000100005cdf	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100005ce5	testl	%ecx, %ecx
0000000100005ce7	je	0x100005cef
0000000100005ce9	movb	$0x0, 0x10(%rdi)
0000000100005ced	jmp	0x100005d1a
0000000100005cef	movq	_fwp_gc(%rip), %rbx
0000000100005cf6	callq	_fwp_mem_free
0000000100005cfb	movq	_fwp_gc(%rip), %rax
0000000100005d02	subq	%rbx, %rax
0000000100005d05	cvtsi2sd	%rax, %xmm0
0000000100005d0a	addsd	0x74fe(%rip), %xmm0
0000000100005d12	movsd	%xmm0, 0x74f6(%rip)
0000000100005d1a	addq	$0x8, %rsp
0000000100005d1e	popq	%rbx
0000000100005d1f	popq	%rbp
0000000100005d20	retq
0000000100005d21	nopw	%cs:(%rax,%rax)
_fwp_display_top:
0000000100005d30	pushq	%rbp
0000000100005d31	movq	%rsp, %rbp
0000000100005d34	pushq	%rbx
0000000100005d35	subq	$0x18, %rsp
0000000100005d39	movq	%rdx, %rbx
0000000100005d3c	movq	%rsi, %rdx
0000000100005d3f	movq	%rdi, %rsi
0000000100005d42	xorps	%xmm0, %xmm0
0000000100005d45	movaps	%xmm0, -0x20(%rbp)
0000000100005d49	movq	$0x0, -0x10(%rbp)
0000000100005d51	leaq	-0x20(%rbp), %rdi
0000000100005d55	movl	$0x1, %ecx
0000000100005d5a	callq	_fwp_write
0000000100005d5f	movq	-0x20(%rbp), %rdi
0000000100005d63	testq	%rdi, %rdi
0000000100005d66	je	0x100005d7f
0000000100005d68	movq	-0x18(%rbp), %rdx
0000000100005d6c	movl	$0x1, %esi
0000000100005d71	movq	%rbx, %rcx
0000000100005d74	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100005d79	movq	-0x20(%rbp), %rdi
0000000100005d7d	jmp	0x100005d81
0000000100005d7f	xorl	%edi, %edi
0000000100005d81	callq	0x1000097be                     ## symbol stub for: _free
0000000100005d86	addq	$0x18, %rsp
0000000100005d8a	popq	%rbx
0000000100005d8b	popq	%rbp
0000000100005d8c	retq
0000000100005d8d	nopl	(%rax)
_fwp_write:
0000000100005d90	pushq	%rbp
0000000100005d91	movq	%rsp, %rbp
0000000100005d94	pushq	%r15
0000000100005d96	pushq	%r14
0000000100005d98	pushq	%r13
0000000100005d9a	pushq	%r12
0000000100005d9c	pushq	%rbx
0000000100005d9d	subq	$0x268, %rsp                    ## imm = 0x268
0000000100005da4	movq	0x5285(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005dab	movq	(%rax), %rax
0000000100005dae	movq	%rax, -0x30(%rbp)
0000000100005db2	movl	(%rdx), %eax
0000000100005db4	cmpq	$0x19, %rax
0000000100005db8	ja	0x10000707b
0000000100005dbe	movq	%rdx, %r15
0000000100005dc1	movq	%rsi, %r14
0000000100005dc4	movq	%rdi, %r13
0000000100005dc7	leaq	0x141e(%rip), %rdx
0000000100005dce	movslq	(%rdx,%rax,4), %rsi
0000000100005dd2	addq	%rdx, %rsi
0000000100005dd5	movq	%rdi, -0x278(%rbp)
0000000100005ddc	jmpq	*%rsi
0000000100005dde	leaq	0x3ec5(%rip), %rdx              ## literal pool for: "%lld"
0000000100005de5	jmp	0x100005dee
0000000100005de7	leaq	0x3ec1(%rip), %rdx              ## literal pool for: "%llu"
0000000100005dee	leaq	-0x270(%rbp), %rbx
0000000100005df5	movl	$0x200, %esi                    ## imm = 0x200
0000000100005dfa	movq	%rbx, %rdi
0000000100005dfd	movq	%r14, %rcx
0000000100005e00	xorl	%eax, %eax
0000000100005e02	callq	0x100009842                     ## symbol stub for: _snprintf
0000000100005e07	jmp	0x100007065
0000000100005e0c	cmpl	$0x13, %eax
0000000100005e0f	leaq	0x3ed3(%rip), %rax              ## literal pool for: "set{"
0000000100005e16	leaq	0x3ed1(%rip), %rsi              ## literal pool for: "map{"
0000000100005e1d	cmoveq	%rax, %rsi
0000000100005e21	movl	$0x4, %edx
0000000100005e26	movq	%r13, %rdi
0000000100005e29	callq	_buf_put
0000000100005e2e	cmpq	$0x0, (%r14)
0000000100005e32	je	0x100005f0e
0000000100005e38	movq	0x38(%r15), %rdx
0000000100005e3c	movq	0x8(%r14), %rsi
0000000100005e40	movq	-0x278(%rbp), %rbx
0000000100005e47	movq	%rbx, %rdi
0000000100005e4a	xorl	%ecx, %ecx
0000000100005e4c	callq	_fwp_write
0000000100005e51	cmpl	$0x12, (%r15)
0000000100005e55	jne	0x100005e7d
0000000100005e57	leaq	0x3e95(%rip), %rsi              ## literal pool for: ": "
0000000100005e5e	movl	$0x2, %edx
0000000100005e63	movq	%rbx, %rdi
0000000100005e66	callq	_buf_put
0000000100005e6b	movq	0x10(%r14), %rsi
0000000100005e6f	movq	0x40(%r15), %rdx
0000000100005e73	movq	%rbx, %rdi
0000000100005e76	xorl	%ecx, %ecx
0000000100005e78	callq	_fwp_write
0000000100005e7d	cmpq	$0x2, (%r14)
0000000100005e81	jb	0x100005f0e
0000000100005e87	leaq	0x20(%r14), %r13
0000000100005e8b	movl	$0x1, %r12d
0000000100005e91	jmp	0x100005eac
0000000100005e93	nopw	%cs:(%rax,%rax)
0000000100005ea0	incq	%r12
0000000100005ea3	addq	$0x10, %r13
0000000100005ea7	cmpq	(%r14), %r12
0000000100005eaa	jae	0x100005f0e
0000000100005eac	movl	$0x2, %edx
0000000100005eb1	movq	-0x278(%rbp), %rbx
0000000100005eb8	movq	%rbx, %rdi
0000000100005ebb	leaq	0x3e1a(%rip), %rsi              ## literal pool for: ", "
0000000100005ec2	callq	_buf_put
0000000100005ec7	movq	-0x8(%r13), %rsi
0000000100005ecb	movq	0x38(%r15), %rdx
0000000100005ecf	movq	%rbx, %rdi
0000000100005ed2	xorl	%ecx, %ecx
0000000100005ed4	callq	_fwp_write
0000000100005ed9	cmpl	$0x12, (%r15)
0000000100005edd	jne	0x100005ea0
0000000100005edf	movl	$0x2, %edx
0000000100005ee4	movq	-0x278(%rbp), %rbx
0000000100005eeb	movq	%rbx, %rdi
0000000100005eee	leaq	0x3dfe(%rip), %rsi              ## literal pool for: ": "
0000000100005ef5	callq	_buf_put
0000000100005efa	movq	(%r13), %rsi
0000000100005efe	movq	0x40(%r15), %rdx
0000000100005f02	movq	%rbx, %rdi
0000000100005f05	xorl	%ecx, %ecx
0000000100005f07	callq	_fwp_write
0000000100005f0c	jmp	0x100005ea0
0000000100005f0e	movb	$0x7d, -0x270(%rbp)
0000000100005f15	leaq	-0x270(%rbp), %rsi
0000000100005f1c	movl	$0x1, %edx
0000000100005f21	movq	-0x278(%rbp), %rdi
0000000100005f28	jmp	0x100007076
0000000100005f2d	movq	0x8(%r15), %rbx
0000000100005f31	testq	%rbx, %rbx
0000000100005f34	je	0x100006928
0000000100005f3a	leaq	0x3db5(%rip), %rsi              ## literal pool for: "Duration"
0000000100005f41	movq	%rbx, %rdi
0000000100005f44	callq	0x100009854                     ## symbol stub for: _strcmp
0000000100005f49	testl	%eax, %eax
0000000100005f4b	je	0x100006bd3
0000000100005f51	movq	%r15, -0x280(%rbp)
0000000100005f58	addq	$0x10, %r15
0000000100005f5c	movq	%rbx, %rdi
0000000100005f5f	callq	0x100009860                     ## symbol stub for: _strlen
0000000100005f64	movq	%r13, %rdi
0000000100005f67	movq	%rbx, %rsi
0000000100005f6a	movq	%rax, %rdx
0000000100005f6d	callq	_buf_put
0000000100005f72	movb	$0x20, -0x270(%rbp)
0000000100005f79	leaq	-0x270(%rbp), %rsi
0000000100005f80	movl	$0x1, %edx
0000000100005f85	movq	%r13, %rdi
0000000100005f88	callq	_buf_put
0000000100005f8d	xorl	%r12d, %r12d
0000000100005f90	jmp	0x100006949
0000000100005f95	cmpq	$0xfff, %r14                    ## imm = 0xFFF
0000000100005f9c	ja	0x100006764
0000000100005fa2	movl	%r14d, %eax
0000000100005fa5	jmp	0x100006767
0000000100005faa	movq	%r14, %xmm0
0000000100005faf	movq	%xmm0, -0x278(%rbp)
0000000100005fb7	ucomisd	%xmm0, %xmm0
0000000100005fbb	jp	0x1000071dd
0000000100005fc1	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100005fcb	andq	%r14, %rax
0000000100005fce	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
0000000100005fd8	cmpq	%rcx, %rax
0000000100005fdb	je	0x1000068e8
0000000100005fe1	movl	$0x1, %ebx
0000000100005fe6	leaq	-0x270(%rbp), %r14
0000000100005fed	nopl	(%rax)
0000000100005ff0	movq	%r14, %rdi
0000000100005ff3	movsd	-0x278(%rbp), %xmm0
0000000100005ffb	movl	%ebx, %esi
0000000100005ffd	callq	_fwp_format_g
0000000100006002	movq	%r14, %rdi
0000000100006005	xorl	%esi, %esi
0000000100006007	callq	0x10000986c                     ## symbol stub for: _strtod
000000010000600c	ucomisd	-0x278(%rbp), %xmm0
0000000100006014	jne	0x10000601c
0000000100006016	jnp	0x100006679
000000010000601c	incl	%ebx
000000010000601e	cmpl	$0x12, %ebx
0000000100006021	jne	0x100005ff0
0000000100006023	leaq	-0x270(%rbp), %rbx
000000010000602a	movq	%rbx, %rdi
000000010000602d	movsd	-0x278(%rbp), %xmm0
0000000100006035	movl	$0x11, %esi
000000010000603a	callq	_fwp_format_g
000000010000603f	movq	%rbx, %rdi
0000000100006042	jmp	0x100006680
0000000100006047	movb	$0x3c, -0x270(%rbp)
000000010000604e	leaq	-0x270(%rbp), %rsi
0000000100006055	movl	$0x1, %edx
000000010000605a	movq	%r13, %rdi
000000010000605d	callq	_buf_put
0000000100006062	movq	0x8(%r15), %rbx
0000000100006066	movq	%rbx, %rdi
0000000100006069	callq	0x100009860                     ## symbol stub for: _strlen
000000010000606e	movq	%r13, %rdi
0000000100006071	movq	%rbx, %rsi
0000000100006074	jmp	0x100006750
0000000100006079	movq	0x4fb0(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006080	movq	(%rax), %rax
0000000100006083	cmpq	-0x30(%rbp), %rax
0000000100006087	jne	0x1000071d8
000000010000608d	leaq	0x3c31(%rip), %rsi              ## literal pool for: "<opaque>"
0000000100006094	movl	$0x8, %edx
0000000100006099	movq	%r13, %rdi
000000010000609c	jmp	0x100006e26
00000001000060a1	leaq	0x8(%r14), %rsi
00000001000060a5	movq	(%r14), %rdx
00000001000060a8	movq	0x4f81(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000060af	movq	(%rax), %rax
00000001000060b2	testl	%ecx, %ecx
00000001000060b4	je	0x100006a86
00000001000060ba	cmpq	-0x30(%rbp), %rax
00000001000060be	jne	0x1000071d8
00000001000060c4	movq	%r13, %rdi
00000001000060c7	jmp	0x100006e26
00000001000060cc	movq	(%r14), %r9
00000001000060cf	movq	0x8(%r14), %r8
00000001000060d3	movq	%r9, %rax
00000001000060d6	orq	%r8, %rax
00000001000060d9	je	0x100006aa9
00000001000060df	xorl	%edi, %edi
00000001000060e1	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000060eb	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000060f5	movq	%r8, %rbx
00000001000060f8	nopl	(%rax,%rax)
0000000100006100	movq	%r8, %rcx
0000000100006103	shldq	$0x3f, %r9, %rcx
0000000100006108	shrq	%rbx
000000010000610b	movq	%rcx, %rsi
000000010000610e	addq	%rbx, %rsi
0000000100006111	adcq	$0x0, %rsi
0000000100006115	movq	%rsi, %rax
0000000100006118	mulq	%r10
000000010000611b	shrq	$0x2, %rdx
000000010000611f	leaq	(%rdx,%rdx,4), %rax
0000000100006123	subq	%rax, %rsi
0000000100006126	subq	%rsi, %rcx
0000000100006129	sbbq	$0x0, %rbx
000000010000612d	movq	%rcx, %rsi
0000000100006130	imulq	%r11, %rsi
0000000100006134	movq	%rcx, %rax
0000000100006137	mulq	%r10
000000010000613a	addq	%rsi, %rdx
000000010000613d	imulq	%r10, %rbx
0000000100006141	addq	%rdx, %rbx
0000000100006144	movq	%rax, %rcx
0000000100006147	addq	%rax, %rcx
000000010000614a	leaq	(%rcx,%rcx,4), %rcx
000000010000614e	movl	%r9d, %edx
0000000100006151	subl	%ecx, %edx
0000000100006153	orb	$0x30, %dl
0000000100006156	movb	%dl, -0x70(%rbp,%rdi)
000000010000615a	incq	%rdi
000000010000615d	cmpq	$0xa, %r9
0000000100006161	sbbq	$0x0, %r8
0000000100006165	movq	%rax, %r9
0000000100006168	movq	%rbx, %r8
000000010000616b	jae	0x100006100
000000010000616d	testl	%edi, %edi
000000010000616f	jg	0x100006ab2
0000000100006175	jmp	0x100006225
000000010000617a	movq	(%r14), %r9
000000010000617d	movq	0x8(%r14), %r10
0000000100006181	testq	%r10, %r10
0000000100006184	js	0x100006ad4
000000010000618a	movq	%r9, %rax
000000010000618d	orq	%r10, %rax
0000000100006190	je	0x100006bf2
0000000100006196	xorl	%edi, %edi
0000000100006198	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
00000001000061a2	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000061ac	movq	%r10, %rbx
00000001000061af	nop
00000001000061b0	movq	%r10, %rcx
00000001000061b3	shldq	$0x3f, %r9, %rcx
00000001000061b8	shrq	%rbx
00000001000061bb	movq	%rcx, %rsi
00000001000061be	addq	%rbx, %rsi
00000001000061c1	adcq	$0x0, %rsi
00000001000061c5	movq	%rsi, %rax
00000001000061c8	mulq	%r8
00000001000061cb	shrq	$0x2, %rdx
00000001000061cf	leaq	(%rdx,%rdx,4), %rax
00000001000061d3	subq	%rax, %rsi
00000001000061d6	subq	%rsi, %rcx
00000001000061d9	sbbq	$0x0, %rbx
00000001000061dd	movq	%rcx, %rsi
00000001000061e0	imulq	%r11, %rsi
00000001000061e4	movq	%rcx, %rax
00000001000061e7	mulq	%r8
00000001000061ea	addq	%rsi, %rdx
00000001000061ed	imulq	%r8, %rbx
00000001000061f1	addq	%rdx, %rbx
00000001000061f4	movq	%rax, %rcx
00000001000061f7	addq	%rax, %rcx
00000001000061fa	leaq	(%rcx,%rcx,4), %rcx
00000001000061fe	movl	%r9d, %edx
0000000100006201	subl	%ecx, %edx
0000000100006203	orb	$0x30, %dl
0000000100006206	movb	%dl, -0x70(%rbp,%rdi)
000000010000620a	incq	%rdi
000000010000620d	cmpq	$0xa, %r9
0000000100006211	sbbq	$0x0, %r10
0000000100006215	movq	%rax, %r9
0000000100006218	movq	%rbx, %r10
000000010000621b	jae	0x1000061b0
000000010000621d	testl	%edi, %edi
000000010000621f	jg	0x100006bfb
0000000100006225	xorl	%eax, %eax
0000000100006227	jmp	0x100007056
000000010000622c	movb	$0x5b, -0x270(%rbp)
0000000100006233	leaq	-0x270(%rbp), %rsi
000000010000623a	movl	$0x1, %edx
000000010000623f	movq	%r13, %rdi
0000000100006242	callq	_buf_put
0000000100006247	testq	%r14, %r14
000000010000624a	je	0x100006f44
0000000100006250	movq	0x38(%r15), %rdx
0000000100006254	movq	0x8(%r14), %rsi
0000000100006258	movq	%r13, %rdi
000000010000625b	xorl	%ecx, %ecx
000000010000625d	callq	_fwp_write
0000000100006262	movq	0x10(%r14), %r14
0000000100006266	testq	%r14, %r14
0000000100006269	je	0x100006f44
000000010000626f	leaq	0x3a66(%rip), %rbx              ## literal pool for: ", "
0000000100006276	nopw	%cs:(%rax,%rax)
0000000100006280	movl	$0x2, %edx
0000000100006285	movq	%r13, %rdi
0000000100006288	movq	%rbx, %rsi
000000010000628b	callq	_buf_put
0000000100006290	movq	0x8(%r14), %rsi
0000000100006294	movq	0x38(%r15), %rdx
0000000100006298	movq	%r13, %rdi
000000010000629b	xorl	%ecx, %ecx
000000010000629d	callq	_fwp_write
00000001000062a2	movq	0x10(%r14), %r14
00000001000062a6	testq	%r14, %r14
00000001000062a9	jne	0x100006280
00000001000062ab	jmp	0x100006f44
00000001000062b0	movslq	0x48(%r15), %rbx
00000001000062b4	movl	%ebx, %r12d
00000001000062b7	leaq	0x3(%rbx), %rsi
00000001000062bb	cmpq	$0x4000, %rsi                   ## imm = 0x4000
00000001000062c2	ja	0x100006bbe
00000001000062c8	leaq	0x12(%rbx), %rax
00000001000062cc	shrq	$0x4, %rax
00000001000062d0	leaq	_fwp_gc(%rip), %rcx
00000001000062d7	movzbl	0xbe8(%rax,%rcx), %edx
00000001000062df	movl	0xb48(%rcx,%rdx,4), %eax
00000001000062e6	subq	%rax, _fwp_gc(%rip)
00000001000062ed	js	0x100006bbe
00000001000062f3	leaq	(%rdx,%rdx,2), %rdx
00000001000062f7	leaq	(%rcx,%rdx,8), %rcx
00000001000062fb	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100006302	movq	(%rcx), %r15
0000000100006305	testq	%r15, %r15
0000000100006308	je	0x100006baa
000000010000630e	movq	(%r15), %rax
0000000100006311	notq	%rax
0000000100006314	movq	%rax, (%rcx)
0000000100006317	jmp	0x100006d42
000000010000631c	cmpq	$-0x1, %r14
0000000100006320	leaq	0x3990(%rip), %rax              ## literal pool for: "-1"
0000000100006327	leaq	0x37b7(%rip), %rcx              ## literal pool for: "0"
000000010000632e	cmoveq	%rax, %rcx
0000000100006332	cmpq	$0x1, %r14
0000000100006336	leaq	0x3977(%rip), %rbx              ## literal pool for: "+1"
000000010000633d	cmovneq	%rcx, %rbx
0000000100006341	movq	%rbx, %rdi
0000000100006344	callq	0x100009860                     ## symbol stub for: _strlen
0000000100006349	movq	0x4ce0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100006350	movq	(%rcx), %rcx
0000000100006353	cmpq	-0x30(%rbp), %rcx
0000000100006357	jne	0x1000071d8
000000010000635d	movq	%r13, %rdi
0000000100006360	movq	%rbx, %rsi
0000000100006363	jmp	0x100006e23
0000000100006368	movq	%r15, %r12
000000010000636b	leaq	0x3970(%rip), %rsi              ## literal pool for: "array["
0000000100006372	movl	$0x6, %edx
0000000100006377	movq	%r13, %rdi
000000010000637a	callq	_buf_put
000000010000637f	movq	(%r14), %rsi
0000000100006382	leaq	(,%rsi,2), %rax
000000010000638a	testq	%rax, %rax
000000010000638d	je	0x100006f44
0000000100006393	movq	0x38(%r12), %rdx
0000000100006398	movl	$0x8, %eax
000000010000639d	testq	%rdx, %rdx
00000001000063a0	je	0x100006c1d
00000001000063a6	movl	(%rdx), %ecx
00000001000063a8	cmpq	$0xa, %rcx
00000001000063ac	movq	-0x278(%rbp), %r13
00000001000063b3	ja	0x100006c24
00000001000063b9	leaq	0x3610(%rip), %rax
00000001000063c0	movq	(%rax,%rcx,8), %rax
00000001000063c4	jmp	0x100006c24
00000001000063c9	leaq	0x3905(%rip), %rsi              ## literal pool for: "bytes["
00000001000063d0	movl	$0x6, %edx
00000001000063d5	movq	%r13, %rdi
00000001000063d8	callq	_buf_put
00000001000063dd	cmpq	$0x0, (%r14)
00000001000063e1	movq	%r13, %rbx
00000001000063e4	je	0x100006491
00000001000063ea	movzbl	0x8(%r14), %ecx
00000001000063ef	leaq	0x38e9(%rip), %rdx              ## literal pool for: "%u"
00000001000063f6	leaq	-0x270(%rbp), %r15
00000001000063fd	movl	$0x200, %esi                    ## imm = 0x200
0000000100006402	movq	%r15, %rdi
0000000100006405	xorl	%eax, %eax
0000000100006407	callq	0x100009842                     ## symbol stub for: _snprintf
000000010000640c	movq	%r15, %rdi
000000010000640f	callq	0x100009860                     ## symbol stub for: _strlen
0000000100006414	movq	%rbx, %rdi
0000000100006417	movq	%r15, %rsi
000000010000641a	movq	%rax, %rdx
000000010000641d	callq	_buf_put
0000000100006422	cmpq	$0x2, (%r14)
0000000100006426	jb	0x100006491
0000000100006428	movl	$0x9, %r13d
000000010000642e	leaq	0x38aa(%rip), %r15              ## literal pool for: "%u"
0000000100006435	leaq	-0x270(%rbp), %r12
000000010000643c	nopl	(%rax)
0000000100006440	movl	$0x2, %edx
0000000100006445	movq	%rbx, %rdi
0000000100006448	leaq	0x388d(%rip), %rsi              ## literal pool for: ", "
000000010000644f	callq	_buf_put
0000000100006454	movzbl	(%r14,%r13), %ecx
0000000100006459	movl	$0x200, %esi                    ## imm = 0x200
000000010000645e	movq	%r12, %rdi
0000000100006461	movq	%r15, %rdx
0000000100006464	xorl	%eax, %eax
0000000100006466	callq	0x100009842                     ## symbol stub for: _snprintf
000000010000646b	movq	%r12, %rdi
000000010000646e	callq	0x100009860                     ## symbol stub for: _strlen
0000000100006473	movq	%rbx, %rdi
0000000100006476	movq	%r12, %rsi
0000000100006479	movq	%rax, %rdx
000000010000647c	callq	_buf_put
0000000100006481	leaq	0x1(%r13), %rax
0000000100006485	addq	$-0x7, %r13
0000000100006489	cmpq	(%r14), %r13
000000010000648c	movq	%rax, %r13
000000010000648f	jb	0x100006440
0000000100006491	movb	$0x5d, -0x70(%rbp)
0000000100006495	leaq	-0x70(%rbp), %rsi
0000000100006499	movl	$0x1, %edx
000000010000649e	movq	%rbx, %rdi
00000001000064a1	jmp	0x100007076
00000001000064a6	movd	%r14d, %xmm1
00000001000064ab	ucomiss	%xmm1, %xmm1
00000001000064ae	jp	0x1000071dd
00000001000064b4	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
00000001000064bb	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
00000001000064c2	je	0x1000068fa
00000001000064c8	cvtss2sd	%xmm1, %xmm0
00000001000064cc	leaq	-0x270(%rbp), %rbx
00000001000064d3	movq	%rbx, %rdi
00000001000064d6	movsd	%xmm0, -0x280(%rbp)
00000001000064de	movl	$0x1, %esi
00000001000064e3	movss	%xmm1, -0x278(%rbp)
00000001000064eb	callq	_fwp_format_g
00000001000064f0	movq	%rbx, %rdi
00000001000064f3	xorl	%esi, %esi
00000001000064f5	callq	0x100009872                     ## symbol stub for: _strtof
00000001000064fa	ucomiss	-0x278(%rbp), %xmm0
0000000100006501	jne	0x100006509
0000000100006503	jnp	0x100006679
0000000100006509	movq	%rbx, %rdi
000000010000650c	movsd	-0x280(%rbp), %xmm0
0000000100006514	movl	$0x2, %esi
0000000100006519	callq	_fwp_format_g
000000010000651e	movq	%rbx, %rdi
0000000100006521	xorl	%esi, %esi
0000000100006523	callq	0x100009872                     ## symbol stub for: _strtof
0000000100006528	ucomiss	-0x278(%rbp), %xmm0
000000010000652f	jne	0x100006537
0000000100006531	jnp	0x100006679
0000000100006537	movq	%rbx, %rdi
000000010000653a	movsd	-0x280(%rbp), %xmm0
0000000100006542	movl	$0x3, %esi
0000000100006547	callq	_fwp_format_g
000000010000654c	movq	%rbx, %rdi
000000010000654f	xorl	%esi, %esi
0000000100006551	callq	0x100009872                     ## symbol stub for: _strtof
0000000100006556	ucomiss	-0x278(%rbp), %xmm0
000000010000655d	jne	0x100006565
000000010000655f	jnp	0x100006679
0000000100006565	movq	%rbx, %rdi
0000000100006568	movsd	-0x280(%rbp), %xmm0
0000000100006570	movl	$0x4, %esi
0000000100006575	callq	_fwp_format_g
000000010000657a	movq	%rbx, %rdi
000000010000657d	xorl	%esi, %esi
000000010000657f	callq	0x100009872                     ## symbol stub for: _strtof
0000000100006584	ucomiss	-0x278(%rbp), %xmm0
000000010000658b	jne	0x100006593
000000010000658d	jnp	0x100006679
0000000100006593	movq	%rbx, %rdi
0000000100006596	movsd	-0x280(%rbp), %xmm0
000000010000659e	movl	$0x5, %esi
00000001000065a3	callq	_fwp_format_g
00000001000065a8	movq	%rbx, %rdi
00000001000065ab	xorl	%esi, %esi
00000001000065ad	callq	0x100009872                     ## symbol stub for: _strtof
00000001000065b2	ucomiss	-0x278(%rbp), %xmm0
00000001000065b9	jne	0x1000065c1
00000001000065bb	jnp	0x100006679
00000001000065c1	movq	%rbx, %rdi
00000001000065c4	movsd	-0x280(%rbp), %xmm0
00000001000065cc	movl	$0x6, %esi
00000001000065d1	callq	_fwp_format_g
00000001000065d6	movq	%rbx, %rdi
00000001000065d9	xorl	%esi, %esi
00000001000065db	callq	0x100009872                     ## symbol stub for: _strtof
00000001000065e0	ucomiss	-0x278(%rbp), %xmm0
00000001000065e7	jne	0x1000065ef
00000001000065e9	jnp	0x100006679
00000001000065ef	movq	%rbx, %rdi
00000001000065f2	movsd	-0x280(%rbp), %xmm0
00000001000065fa	movl	$0x7, %esi
00000001000065ff	callq	_fwp_format_g
0000000100006604	movq	%rbx, %rdi
0000000100006607	xorl	%esi, %esi
0000000100006609	callq	0x100009872                     ## symbol stub for: _strtof
000000010000660e	ucomiss	-0x278(%rbp), %xmm0
0000000100006615	jne	0x100006619
0000000100006617	jnp	0x100006679
0000000100006619	movq	%rbx, %rdi
000000010000661c	movsd	-0x280(%rbp), %xmm0
0000000100006624	movl	$0x8, %esi
0000000100006629	callq	_fwp_format_g
000000010000662e	movq	%rbx, %rdi
0000000100006631	xorl	%esi, %esi
0000000100006633	callq	0x100009872                     ## symbol stub for: _strtof
0000000100006638	movss	-0x278(%rbp), %xmm1
0000000100006640	ucomiss	%xmm1, %xmm0
0000000100006643	jne	0x100006647
0000000100006645	jnp	0x100006679
0000000100006647	movq	%rbx, %rdi
000000010000664a	movsd	-0x280(%rbp), %xmm0
0000000100006652	movl	$0x9, %esi
0000000100006657	callq	_fwp_format_g
000000010000665c	movq	%rbx, %rdi
000000010000665f	xorl	%esi, %esi
0000000100006661	callq	0x100009872                     ## symbol stub for: _strtof
0000000100006666	ucomiss	-0x278(%rbp), %xmm0
000000010000666d	jne	0x1000071c3
0000000100006673	jp	0x1000071c3
0000000100006679	leaq	-0x270(%rbp), %rdi
0000000100006680	movl	$0x2e, %esi
0000000100006685	callq	0x10000984e                     ## symbol stub for: _strchr
000000010000668a	testq	%rax, %rax
000000010000668d	jne	0x10000705e
0000000100006693	leaq	-0x270(%rbp), %rdi
000000010000669a	movl	$0x65, %esi
000000010000669f	callq	0x10000984e                     ## symbol stub for: _strchr
00000001000066a4	testq	%rax, %rax
00000001000066a7	jne	0x10000705e
00000001000066ad	leaq	0x3656(%rip), %rsi              ## literal pool for: "inf"
00000001000066b4	leaq	-0x270(%rbp), %rdi
00000001000066bb	callq	0x100009866                     ## symbol stub for: _strstr
00000001000066c0	testq	%rax, %rax
00000001000066c3	jne	0x10000705e
00000001000066c9	leaq	0x3636(%rip), %rsi              ## literal pool for: "NaN"
00000001000066d0	leaq	-0x270(%rbp), %rdi
00000001000066d7	callq	0x100009866                     ## symbol stub for: _strstr
00000001000066dc	testq	%rax, %rax
00000001000066df	jne	0x10000705e
00000001000066e5	leaq	0x363b(%rip), %rsi              ## literal pool for: ".0"
00000001000066ec	leaq	-0x270(%rbp), %rdi
00000001000066f3	movl	$0x200, %edx                    ## imm = 0x200
00000001000066f8	callq	0x10000974c                     ## symbol stub for: ___strcat_chk
00000001000066fd	jmp	0x10000705e
0000000100006702	movq	0x4927(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006709	movq	(%rax), %rax
000000010000670c	cmpq	-0x30(%rbp), %rax
0000000100006710	jne	0x1000071d8
0000000100006716	leaq	0x359d(%rip), %rsi              ## literal pool for: "<function>"
000000010000671d	movl	$0xa, %edx
0000000100006722	movq	%r13, %rdi
0000000100006725	jmp	0x100006e26
000000010000672a	leaq	0x359d(%rip), %rsi              ## literal pool for: "<file "
0000000100006731	movl	$0x6, %edx
0000000100006736	movq	%r13, %rdi
0000000100006739	callq	_buf_put
000000010000673e	addq	$0x10, %r14
0000000100006742	movq	%r14, %rdi
0000000100006745	callq	0x100009860                     ## symbol stub for: _strlen
000000010000674a	movq	%r13, %rdi
000000010000674d	movq	%r14, %rsi
0000000100006750	movq	%rax, %rdx
0000000100006753	callq	_buf_put
0000000100006758	movb	$0x3e, -0x270(%rbp)
000000010000675f	jmp	0x100006f4b
0000000100006764	movl	(%r14), %eax
0000000100006767	movq	0x18(%r15), %rcx
000000010000676b	movl	%eax, %r12d
000000010000676e	movq	(%rcx,%r12,8), %rbx
0000000100006772	movq	%rbx, %rdi
0000000100006775	callq	0x100009860                     ## symbol stub for: _strlen
000000010000677a	movq	%r13, %rdi
000000010000677d	movq	%rbx, %rsi
0000000100006780	movq	%rax, %rdx
0000000100006783	callq	_buf_put
0000000100006788	movq	0x28(%r15), %rax
000000010000678c	cmpl	$0x0, (%rax,%r12,4)
0000000100006791	jle	0x10000707b
0000000100006797	movq	%r12, %rcx
000000010000679a	xorl	%r12d, %r12d
000000010000679d	movq	%r15, -0x280(%rbp)
00000001000067a4	movq	%rcx, -0x290(%rbp)
00000001000067ab	movq	%r14, -0x288(%rbp)
00000001000067b2	jmp	0x1000067f9
00000001000067b4	nopw	%cs:(%rax,%rax)
00000001000067c0	movq	-0x278(%rbp), %r13
00000001000067c7	movq	%r13, %rdi
00000001000067ca	movq	%r15, %rsi
00000001000067cd	movq	%rbx, %rdx
00000001000067d0	xorl	%ecx, %ecx
00000001000067d2	callq	_fwp_write
00000001000067d7	incq	%r12
00000001000067da	movq	-0x280(%rbp), %r15
00000001000067e1	movq	0x28(%r15), %rax
00000001000067e5	movq	-0x290(%rbp), %rcx
00000001000067ec	movslq	(%rax,%rcx,4), %rax
00000001000067f0	cmpq	%rax, %r12
00000001000067f3	jge	0x10000707b
00000001000067f9	movq	%r15, %rax
00000001000067fc	movq	0x8(%r14,%r12,8), %r15
0000000100006801	movq	0x30(%rax), %rax
0000000100006805	movq	(%rax,%rcx,8), %rax
0000000100006809	movq	(%rax,%r12,8), %rbx
000000010000680d	movb	$0x20, -0x270(%rbp)
0000000100006814	movl	$0x1, %edx
0000000100006819	movq	%r13, %rdi
000000010000681c	leaq	-0x270(%rbp), %rsi
0000000100006823	callq	_buf_put
0000000100006828	movl	(%rbx), %eax
000000010000682a	cmpq	$0x10, %rax
000000010000682e	ja	0x1000067c0
0000000100006830	leaq	0xa1d(%rip), %rcx
0000000100006837	movslq	(%rcx,%rax,4), %rax
000000010000683b	addq	%rcx, %rax
000000010000683e	jmpq	*%rax
0000000100006840	movq	%r15, %rcx
0000000100006843	shrq	$0x3f, %rcx
0000000100006847	testl	%ecx, %ecx
0000000100006849	je	0x1000067c0
000000010000684f	movb	$0x28, -0x270(%rbp)
0000000100006856	movl	$0x1, %edx
000000010000685b	movq	-0x278(%rbp), %r13
0000000100006862	movq	%r13, %rdi
0000000100006865	leaq	-0x270(%rbp), %r14
000000010000686c	movq	%r14, %rsi
000000010000686f	callq	_buf_put
0000000100006874	movq	%r13, %rdi
0000000100006877	movq	%r15, %rsi
000000010000687a	movq	%rbx, %rdx
000000010000687d	xorl	%ecx, %ecx
000000010000687f	callq	_fwp_write
0000000100006884	movb	$0x29, -0x270(%rbp)
000000010000688b	movl	$0x1, %edx
0000000100006890	movq	%r13, %rdi
0000000100006893	movq	%r14, %rsi
0000000100006896	movq	-0x288(%rbp), %r14
000000010000689d	callq	_buf_put
00000001000068a2	jmp	0x1000067d7
00000001000068a7	xorl	%ecx, %ecx
00000001000068a9	cmpq	$0x1000, %r15                   ## imm = 0x1000
00000001000068b0	setae	%cl
00000001000068b3	jmp	0x100006847
00000001000068b5	movq	0x8(%r15), %rcx
00000001000068b9	jmp	0x100006843
00000001000068bb	movl	%r15d, %ecx
00000001000068be	shrl	$0x1f, %ecx
00000001000068c1	jmp	0x100006847
00000001000068c3	movq	0x8(%rbx), %rdi
00000001000068c7	testq	%rdi, %rdi
00000001000068ca	je	0x1000067c0
00000001000068d0	leaq	0x341f(%rip), %rsi              ## literal pool for: "Duration"
00000001000068d7	callq	0x100009854                     ## symbol stub for: _strcmp
00000001000068dc	xorl	%ecx, %ecx
00000001000068de	testl	%eax, %eax
00000001000068e0	setne	%cl
00000001000068e3	jmp	0x100006847
00000001000068e8	xorpd	%xmm0, %xmm0
00000001000068ec	movsd	-0x278(%rbp), %xmm1
00000001000068f4	ucomisd	%xmm0, %xmm1
00000001000068f8	jmp	0x100006900
00000001000068fa	xorps	%xmm0, %xmm0
00000001000068fd	ucomiss	%xmm0, %xmm1
0000000100006900	leaq	0x3403(%rip), %rax              ## literal pool for: "inf"
0000000100006907	leaq	0x3400(%rip), %rsi              ## literal pool for: "-inf"
000000010000690e	cmovaq	%rax, %rsi
0000000100006912	leaq	-0x270(%rbp), %rdi
0000000100006919	movl	$0x200, %edx                    ## imm = 0x200
000000010000691e	callq	0x100009752                     ## symbol stub for: ___strcpy_chk
0000000100006923	jmp	0x10000705e
0000000100006928	cmpl	$0x0, 0x10(%r15)
000000010000692d	je	0x100006f5f
0000000100006933	movq	%r15, %rax
0000000100006936	addq	$0x10, %r15
000000010000693a	movq	%rax, -0x280(%rbp)
0000000100006941	cmpl	$0x0, 0x48(%rax)
0000000100006945	setne	%r12b
0000000100006949	testb	%r12b, %r12b
000000010000694c	movl	$0x28, %eax
0000000100006951	movl	$0x7b, %ecx
0000000100006956	cmovnel	%eax, %ecx
0000000100006959	movb	%cl, -0x270(%rbp)
000000010000695f	leaq	-0x270(%rbp), %rsi
0000000100006966	movl	$0x1, %edx
000000010000696b	movq	%r13, %rdi
000000010000696e	callq	_buf_put
0000000100006973	cmpl	$0x0, (%r15)
0000000100006977	movq	-0x280(%rbp), %r15
000000010000697e	jle	0x100006a6b
0000000100006984	testb	%r12b, %r12b
0000000100006987	jne	0x1000069ba
0000000100006989	movq	0x18(%r15), %rax
000000010000698d	movq	(%rax), %rbx
0000000100006990	movq	%rbx, %rdi
0000000100006993	callq	0x100009860                     ## symbol stub for: _strlen
0000000100006998	movq	%r13, %rdi
000000010000699b	movq	%rbx, %rsi
000000010000699e	movq	%rax, %rdx
00000001000069a1	callq	_buf_put
00000001000069a6	leaq	0x3355(%rip), %rsi              ## literal pool for: " = "
00000001000069ad	movl	$0x3, %edx
00000001000069b2	movq	%r13, %rdi
00000001000069b5	callq	_buf_put
00000001000069ba	movq	0x8(%r14), %rsi
00000001000069be	movq	0x20(%r15), %rax
00000001000069c2	movq	(%rax), %rdx
00000001000069c5	movq	%r13, %rdi
00000001000069c8	xorl	%ecx, %ecx
00000001000069ca	callq	_fwp_write
00000001000069cf	cmpl	$0x2, 0x10(%r15)
00000001000069d4	jl	0x100006a6b
00000001000069da	movl	$0x1, %ebx
00000001000069df	jmp	0x100006a13
00000001000069e1	nopw	%cs:(%rax,%rax)
00000001000069f0	movq	0x8(%r14,%rbx,8), %rsi
00000001000069f5	movq	0x20(%r15), %rax
00000001000069f9	movq	(%rax,%rbx,8), %rdx
00000001000069fd	movq	%r13, %rdi
0000000100006a00	xorl	%ecx, %ecx
0000000100006a02	callq	_fwp_write
0000000100006a07	incq	%rbx
0000000100006a0a	movslq	0x10(%r15), %rax
0000000100006a0e	cmpq	%rax, %rbx
0000000100006a11	jge	0x100006a6b
0000000100006a13	movl	$0x2, %edx
0000000100006a18	movq	%r13, %rdi
0000000100006a1b	leaq	0x32ba(%rip), %rsi              ## literal pool for: ", "
0000000100006a22	callq	_buf_put
0000000100006a27	testb	%r12b, %r12b
0000000100006a2a	jne	0x1000069f0
0000000100006a2c	movq	0x18(%r15), %rax
0000000100006a30	movq	(%rax,%rbx,8), %r13
0000000100006a34	movq	%r13, %rdi
0000000100006a37	callq	0x100009860                     ## symbol stub for: _strlen
0000000100006a3c	movq	-0x278(%rbp), %rdi
0000000100006a43	movq	%r13, %rsi
0000000100006a46	movq	-0x278(%rbp), %r13
0000000100006a4d	movq	%rax, %rdx
0000000100006a50	callq	_buf_put
0000000100006a55	movl	$0x3, %edx
0000000100006a5a	movq	%r13, %rdi
0000000100006a5d	leaq	0x329e(%rip), %rsi              ## literal pool for: " = "
0000000100006a64	callq	_buf_put
0000000100006a69	jmp	0x1000069f0
0000000100006a6b	testb	%r12b, %r12b
0000000100006a6e	movl	$0x29, %eax
0000000100006a73	movl	$0x7d, %ecx
0000000100006a78	cmovnel	%eax, %ecx
0000000100006a7b	movb	%cl, -0x270(%rbp)
0000000100006a81	jmp	0x100006f4b
0000000100006a86	cmpq	-0x30(%rbp), %rax
0000000100006a8a	jne	0x1000071d8
0000000100006a90	movq	%r13, %rdi
0000000100006a93	addq	$0x268, %rsp                    ## imm = 0x268
0000000100006a9a	popq	%rbx
0000000100006a9b	popq	%r12
0000000100006a9d	popq	%r13
0000000100006a9f	popq	%r14
0000000100006aa1	popq	%r15
0000000100006aa3	popq	%rbp
0000000100006aa4	jmp	_fwp_escape
0000000100006aa9	movb	$0x30, -0x70(%rbp)
0000000100006aad	movl	$0x1, %edi
0000000100006ab2	movl	%edi, %eax
0000000100006ab4	cmpq	$0x8, %rax
0000000100006ab8	jae	0x100006ac4
0000000100006aba	xorl	%ecx, %ecx
0000000100006abc	movq	%rax, %rdx
0000000100006abf	jmp	0x100006d15
0000000100006ac4	cmpl	$0x20, %eax
0000000100006ac7	jae	0x100006c61
0000000100006acd	xorl	%ecx, %ecx
0000000100006acf	jmp	0x100006cbf
0000000100006ad4	movb	$0x2d, -0x270(%rbp)
0000000100006adb	xorl	%r8d, %r8d
0000000100006ade	negq	%r9
0000000100006ae1	movl	$0x0, %r11d
0000000100006ae7	sbbq	%r10, %r11
0000000100006aea	movl	$0x1, %r15d
0000000100006af0	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100006afa	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100006b04	movq	%r11, %r14
0000000100006b07	nopw	(%rax,%rax)
0000000100006b10	movq	%r11, %rcx
0000000100006b13	shldq	$0x3f, %r9, %rcx
0000000100006b18	shrq	%r14
0000000100006b1b	movq	%rcx, %rsi
0000000100006b1e	addq	%r14, %rsi
0000000100006b21	adcq	$0x0, %rsi
0000000100006b25	movq	%rsi, %rax
0000000100006b28	mulq	%r10
0000000100006b2b	movl	%r15d, %edi
0000000100006b2e	shrq	$0x2, %rdx
0000000100006b32	leaq	(%rdx,%rdx,4), %rax
0000000100006b36	subq	%rax, %rsi
0000000100006b39	subq	%rsi, %rcx
0000000100006b3c	sbbq	$0x0, %r14
0000000100006b40	movq	%rcx, %rsi
0000000100006b43	movq	%rcx, %rax
0000000100006b46	mulq	%r10
0000000100006b49	imulq	%rbx, %rsi
0000000100006b4d	addq	%rsi, %rdx
0000000100006b50	imulq	%r10, %r14
0000000100006b54	addq	%rdx, %r14
0000000100006b57	movq	%rax, %rcx
0000000100006b5a	addq	%rax, %rcx
0000000100006b5d	leaq	(%rcx,%rcx,4), %rcx
0000000100006b61	movl	%r9d, %edx
0000000100006b64	subl	%ecx, %edx
0000000100006b66	orb	$0x30, %dl
0000000100006b69	movb	%dl, -0x70(%rbp,%r8)
0000000100006b6e	incq	%r8
0000000100006b71	leal	0x1(%rdi), %r15d
0000000100006b75	cmpq	$0xa, %r9
0000000100006b79	sbbq	$0x0, %r11
0000000100006b7d	movq	%rax, %r9
0000000100006b80	movq	%r14, %r11
0000000100006b83	jae	0x100006b10
0000000100006b85	testl	%r8d, %r8d
0000000100006b88	jle	0x100006f87
0000000100006b8e	movl	%r8d, %eax
0000000100006b91	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100006b96	cmpq	$0x8, %rax
0000000100006b9a	jae	0x1000070a1
0000000100006ba0	xorl	%ecx, %ecx
0000000100006ba2	movq	%rax, %rdx
0000000100006ba5	jmp	0x100007184
0000000100006baa	movq	0x8(%rcx), %r15
0000000100006bae	movq	0x10(%rcx), %rdx
0000000100006bb2	subq	%r15, %rdx
0000000100006bb5	cmpq	%rax, %rdx
0000000100006bb8	jae	0x100006d3b
0000000100006bbe	movq	%rsi, %rdi
0000000100006bc1	movl	$0x1, %esi
0000000100006bc6	callq	_fwp_gc_alloc_slow
0000000100006bcb	movq	%rax, %r15
0000000100006bce	jmp	0x100006d4a
0000000100006bd3	movq	0x8(%r14), %rsi
0000000100006bd7	movq	%rsi, %rdx
0000000100006bda	sarq	$0x3f, %rdx
0000000100006bde	leaq	-0x270(%rbp), %rbx
0000000100006be5	movq	%rbx, %rdi
0000000100006be8	callq	_fwp_fmt_duration
0000000100006bed	jmp	0x100007065
0000000100006bf2	movb	$0x30, -0x70(%rbp)
0000000100006bf6	movl	$0x1, %edi
0000000100006bfb	movl	%edi, %eax
0000000100006bfd	cmpq	$0x8, %rax
0000000100006c01	jae	0x100006c0d
0000000100006c03	xorl	%ecx, %ecx
0000000100006c05	movq	%rax, %rdx
0000000100006c08	jmp	0x100007033
0000000100006c0d	cmpl	$0x20, %eax
0000000100006c10	jae	0x100006f96
0000000100006c16	xorl	%ecx, %ecx
0000000100006c18	jmp	0x100006fee
0000000100006c1d	movq	-0x278(%rbp), %r13
0000000100006c24	leaq	0x8(%r14), %rbx
0000000100006c28	movq	%rbx, %rcx
0000000100006c2b	testq	%rsi, %rsi
0000000100006c2e	jns	0x100006c34
0000000100006c30	movq	0x10(%r14), %rcx
0000000100006c34	cmpq	$0x1, %rax
0000000100006c38	je	0x100006e41
0000000100006c3e	cmpq	$0x8, %rax
0000000100006c42	je	0x100006e3c
0000000100006c48	cmpq	$0x2, %rax
0000000100006c4c	jne	0x100006e4d
0000000100006c52	cmpl	$0x1, (%rdx)
0000000100006c55	movzwl	(%rcx), %eax
0000000100006c58	movswq	%ax, %rsi
0000000100006c5c	jmp	0x100006e55
0000000100006c61	movl	%edi, %edx
0000000100006c63	andl	$0x1f, %edx
0000000100006c66	movq	%rax, %rcx
0000000100006c69	subq	%rdx, %rcx
0000000100006c6c	leaq	-0x260(%rbp), %rsi
0000000100006c73	movdqa	0x2cc5(%rip), %xmm0
0000000100006c7b	movq	%rax, %r8
0000000100006c7e	nop
0000000100006c80	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100006c8a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100006c91	pshufb	%xmm0, %xmm2
0000000100006c96	pshufb	%xmm0, %xmm1
0000000100006c9b	movdqa	%xmm2, -0x10(%rsi)
0000000100006ca0	movdqa	%xmm1, (%rsi)
0000000100006ca4	addq	$-0x20, %r8
0000000100006ca8	addq	$0x20, %rsi
0000000100006cac	cmpq	%r8, %rdx
0000000100006caf	jne	0x100006c80
0000000100006cb1	testq	%rdx, %rdx
0000000100006cb4	je	0x100007056
0000000100006cba	cmpl	$0x7, %edx
0000000100006cbd	jbe	0x100006d15
0000000100006cbf	movl	%edi, %edx
0000000100006cc1	andl	$0x7, %edx
0000000100006cc4	movq	%rax, %rsi
0000000100006cc7	subq	%rcx, %rsi
0000000100006cca	leaq	(%rcx,%rbp), %rdi
0000000100006cce	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100006cd5	movq	%rax, %rcx
0000000100006cd8	subq	%rdx, %rcx
0000000100006cdb	movq	0x2c6d(%rip), %xmm0
0000000100006ce3	nopw	%cs:(%rax,%rax)
0000000100006cf0	movq	-0x78(%rbp,%rsi), %xmm1
0000000100006cf6	pshufb	%xmm0, %xmm1
0000000100006cfb	movq	%xmm1, (%rdi)
0000000100006cff	addq	$-0x8, %rsi
0000000100006d03	addq	$0x8, %rdi
0000000100006d07	cmpq	%rsi, %rdx
0000000100006d0a	jne	0x100006cf0
0000000100006d0c	testq	%rdx, %rdx
0000000100006d0f	je	0x100007056
0000000100006d15	leaq	-0x70(%rbp), %rsi
0000000100006d19	addq	%rsi, %rdx
0000000100006d1c	decq	%rdx
0000000100006d1f	nop
0000000100006d20	movzbl	(%rdx), %esi
0000000100006d23	movb	%sil, -0x270(%rbp,%rcx)
0000000100006d2b	incq	%rcx
0000000100006d2e	decq	%rdx
0000000100006d31	cmpq	%rcx, %rax
0000000100006d34	jne	0x100006d20
0000000100006d36	jmp	0x100007056
0000000100006d3b	addq	%r15, %rax
0000000100006d3e	movq	%rax, 0x8(%rcx)
0000000100006d42	movq	%r15, %rdi
0000000100006d45	callq	0x10000972e                     ## symbol stub for: ___bzero
0000000100006d4a	movw	$0x7430, (%r15)                 ## imm = 0x7430
0000000100006d50	testl	%r12d, %r12d
0000000100006d53	jle	0x100006dfb
0000000100006d59	movq	%rbx, %rcx
0000000100006d5c	negq	%rcx
0000000100006d5f	leaq	(%r12,%r15), %rsi
0000000100006d63	incq	%rsi
0000000100006d66	xorl	%edi, %edi
0000000100006d68	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
0000000100006d72	jmp	0x100006dac
0000000100006d74	nopw	%cs:(%rax,%rax)
0000000100006d80	movb	$0x30, %r10b
0000000100006d83	movb	%r10b, (%rsi,%rdi)
0000000100006d87	testq	%rdx, %rdx
0000000100006d8a	setne	%dl
0000000100006d8d	testq	%r14, %r14
0000000100006d90	sets	%r10b
0000000100006d94	andb	%dl, %r10b
0000000100006d97	movzbl	%r10b, %edx
0000000100006d9b	subq	%rdx, %rax
0000000100006d9e	addq	%r9, %rax
0000000100006da1	decq	%rdi
0000000100006da4	movq	%rax, %r14
0000000100006da7	cmpq	%rdi, %rcx
0000000100006daa	je	0x100006dfb
0000000100006dac	movq	%r14, %rax
0000000100006daf	imulq	%r8
0000000100006db2	movq	%rdx, %rax
0000000100006db5	shrq	$0x3f, %rax
0000000100006db9	addq	%rdx, %rax
0000000100006dbc	leaq	(%rax,%rax,2), %r9
0000000100006dc0	movq	%r14, %rdx
0000000100006dc3	subq	%r9, %rdx
0000000100006dc6	negq	%r9
0000000100006dc9	addq	%r14, %r9
0000000100006dcc	addq	$0x3, %r9
0000000100006dd0	cmpq	$-0x3, %rdx
0000000100006dd4	cmovbq	%rdx, %r9
0000000100006dd8	testq	%r9, %r9
0000000100006ddb	je	0x100006d80
0000000100006ddd	cmpq	$0x1, %r9
0000000100006de1	jne	0x100006df0
0000000100006de3	movb	$0x2b, %r10b
0000000100006de6	xorl	%r9d, %r9d
0000000100006de9	jmp	0x100006d83
0000000100006deb	nopl	(%rax,%rax)
0000000100006df0	movb	$0x2d, %r10b
0000000100006df3	movl	$0x1, %r9d
0000000100006df9	jmp	0x100006d83
0000000100006dfb	movb	$0x0, 0x2(%r15,%rbx)
0000000100006e01	movq	%r15, %rdi
0000000100006e04	callq	0x100009860                     ## symbol stub for: _strlen
0000000100006e09	movq	0x4220(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100006e10	movq	(%rcx), %rcx
0000000100006e13	cmpq	-0x30(%rbp), %rcx
0000000100006e17	jne	0x1000071d8
0000000100006e1d	movq	%r13, %rdi
0000000100006e20	movq	%r15, %rsi
0000000100006e23	movq	%rax, %rdx
0000000100006e26	addq	$0x268, %rsp                    ## imm = 0x268
0000000100006e2d	popq	%rbx
0000000100006e2e	popq	%r12
0000000100006e30	popq	%r13
0000000100006e32	popq	%r14
0000000100006e34	popq	%r15
0000000100006e36	popq	%rbp
0000000100006e37	jmp	_buf_put
0000000100006e3c	movq	(%rcx), %rsi
0000000100006e3f	jmp	0x100006e59
0000000100006e41	cmpl	$0x0, (%rdx)
0000000100006e44	movzbl	(%rcx), %eax
0000000100006e47	movsbq	%al, %rsi
0000000100006e4b	jmp	0x100006e55
0000000100006e4d	cmpl	$0x2, (%rdx)
0000000100006e50	movl	(%rcx), %eax
0000000100006e52	movslq	%eax, %rsi
0000000100006e55	cmovneq	%rax, %rsi
0000000100006e59	movq	%r13, %rdi
0000000100006e5c	xorl	%ecx, %ecx
0000000100006e5e	callq	_fwp_write
0000000100006e63	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100006e6d	decq	%rax
0000000100006e70	testq	%rax, (%r14)
0000000100006e73	je	0x100006f44
0000000100006e79	movl	$0x1, %r15d
0000000100006e7f	jmp	0x100006ebd
0000000100006e81	cmpl	$0x1, (%rdx)
0000000100006e84	movzwl	(%rcx,%rsi), %eax
0000000100006e88	movswq	%ax, %rsi
0000000100006e8c	cmovneq	%rax, %rsi
0000000100006e90	movq	-0x278(%rbp), %r13
0000000100006e97	movq	%r13, %rdi
0000000100006e9a	xorl	%ecx, %ecx
0000000100006e9c	callq	_fwp_write
0000000100006ea1	incq	%r15
0000000100006ea4	movq	(%r14), %rax
0000000100006ea7	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100006eb1	andq	%rcx, %rax
0000000100006eb4	cmpq	%rax, %r15
0000000100006eb7	jae	0x100006f44
0000000100006ebd	movl	$0x2, %edx
0000000100006ec2	movq	%r13, %rdi
0000000100006ec5	leaq	0x2e10(%rip), %rsi              ## literal pool for: ", "
0000000100006ecc	callq	_buf_put
0000000100006ed1	movq	0x38(%r12), %rdx
0000000100006ed6	movl	$0x8, %eax
0000000100006edb	testq	%rdx, %rdx
0000000100006ede	je	0x100006ef3
0000000100006ee0	movl	(%rdx), %ecx
0000000100006ee2	cmpq	$0xa, %rcx
0000000100006ee6	ja	0x100006ef3
0000000100006ee8	leaq	0x2ae1(%rip), %rax
0000000100006eef	movq	(%rax,%rcx,8), %rax
0000000100006ef3	cmpq	$0x0, (%r14)
0000000100006ef7	movq	%rbx, %rcx
0000000100006efa	jns	0x100006f00
0000000100006efc	movq	0x10(%r14), %rcx
0000000100006f00	movq	%rax, %rsi
0000000100006f03	imulq	%r15, %rsi
0000000100006f07	cmpq	$0x1, %rax
0000000100006f0b	je	0x100006f26
0000000100006f0d	cmpq	$0x2, %rax
0000000100006f11	je	0x100006e81
0000000100006f17	cmpq	$0x8, %rax
0000000100006f1b	jne	0x100006f36
0000000100006f1d	movq	(%rcx,%rsi), %rsi
0000000100006f21	jmp	0x100006e90
0000000100006f26	cmpl	$0x0, (%rdx)
0000000100006f29	movzbl	(%rcx,%rsi), %eax
0000000100006f2d	movsbq	%al, %rsi
0000000100006f31	jmp	0x100006e8c
0000000100006f36	cmpl	$0x2, (%rdx)
0000000100006f39	movl	(%rcx,%rsi), %eax
0000000100006f3c	movslq	%eax, %rsi
0000000100006f3f	jmp	0x100006e8c
0000000100006f44	movb	$0x5d, -0x270(%rbp)
0000000100006f4b	leaq	-0x270(%rbp), %rsi
0000000100006f52	movl	$0x1, %edx
0000000100006f57	movq	%r13, %rdi
0000000100006f5a	jmp	0x100007076
0000000100006f5f	movq	0x40ca(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006f66	movq	(%rax), %rax
0000000100006f69	cmpq	-0x30(%rbp), %rax
0000000100006f6d	jne	0x1000071d8
0000000100006f73	leaq	0x2d85(%rip), %rsi              ## literal pool for: "()"
0000000100006f7a	movl	$0x2, %edx
0000000100006f7f	movq	%r13, %rdi
0000000100006f82	jmp	0x100006e26
0000000100006f87	xorl	%eax, %eax
0000000100006f89	movb	$0x0, -0x26f(%rbp,%rax)
0000000100006f91	jmp	0x10000705e
0000000100006f96	movl	%edi, %edx
0000000100006f98	andl	$0x1f, %edx
0000000100006f9b	movq	%rax, %rcx
0000000100006f9e	subq	%rdx, %rcx
0000000100006fa1	leaq	-0x260(%rbp), %rsi
0000000100006fa8	movdqa	0x2990(%rip), %xmm0
0000000100006fb0	movq	%rax, %r8
0000000100006fb3	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100006fbd	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100006fc4	pshufb	%xmm0, %xmm2
0000000100006fc9	pshufb	%xmm0, %xmm1
0000000100006fce	movdqa	%xmm2, -0x10(%rsi)
0000000100006fd3	movdqa	%xmm1, (%rsi)
0000000100006fd7	addq	$-0x20, %r8
0000000100006fdb	addq	$0x20, %rsi
0000000100006fdf	cmpq	%r8, %rdx
0000000100006fe2	jne	0x100006fb3
0000000100006fe4	testq	%rdx, %rdx
0000000100006fe7	je	0x100007056
0000000100006fe9	cmpl	$0x7, %edx
0000000100006fec	jbe	0x100007033
0000000100006fee	movl	%edi, %edx
0000000100006ff0	andl	$0x7, %edx
0000000100006ff3	movq	%rax, %rsi
0000000100006ff6	subq	%rcx, %rsi
0000000100006ff9	leaq	(%rcx,%rbp), %rdi
0000000100006ffd	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100007004	movq	%rax, %rcx
0000000100007007	subq	%rdx, %rcx
000000010000700a	movq	0x293e(%rip), %xmm0
0000000100007012	movq	-0x78(%rbp,%rsi), %xmm1
0000000100007018	pshufb	%xmm0, %xmm1
000000010000701d	movq	%xmm1, (%rdi)
0000000100007021	addq	$-0x8, %rsi
0000000100007025	addq	$0x8, %rdi
0000000100007029	cmpq	%rsi, %rdx
000000010000702c	jne	0x100007012
000000010000702e	testq	%rdx, %rdx
0000000100007031	je	0x100007056
0000000100007033	leaq	-0x70(%rbp), %rsi
0000000100007037	addq	%rsi, %rdx
000000010000703a	decq	%rdx
000000010000703d	nopl	(%rax)
0000000100007040	movzbl	(%rdx), %esi
0000000100007043	movb	%sil, -0x270(%rbp,%rcx)
000000010000704b	incq	%rcx
000000010000704e	decq	%rdx
0000000100007051	cmpq	%rcx, %rax
0000000100007054	jne	0x100007040
0000000100007056	movb	$0x0, -0x270(%rbp,%rax)
000000010000705e	leaq	-0x270(%rbp), %rbx
0000000100007065	movq	%rbx, %rdi
0000000100007068	callq	0x100009860                     ## symbol stub for: _strlen
000000010000706d	movq	%r13, %rdi
0000000100007070	movq	%rbx, %rsi
0000000100007073	movq	%rax, %rdx
0000000100007076	callq	_buf_put
000000010000707b	movq	0x3fae(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007082	movq	(%rax), %rax
0000000100007085	cmpq	-0x30(%rbp), %rax
0000000100007089	jne	0x1000071d8
000000010000708f	addq	$0x268, %rsp                    ## imm = 0x268
0000000100007096	popq	%rbx
0000000100007097	popq	%r12
0000000100007099	popq	%r13
000000010000709b	popq	%r14
000000010000709d	popq	%r15
000000010000709f	popq	%rbp
00000001000070a0	retq
00000001000070a1	cmpl	$0x20, %eax
00000001000070a4	jae	0x1000070aa
00000001000070a6	xorl	%ecx, %ecx
00000001000070a8	jmp	0x10000711f
00000001000070aa	movl	%r8d, %edx
00000001000070ad	andl	$0x1f, %edx
00000001000070b0	movq	%rax, %rcx
00000001000070b3	subq	%rdx, %rcx
00000001000070b6	movl	%edi, %esi
00000001000070b8	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
00000001000070be	leaq	(%rsi,%rbp), %r9
00000001000070c2	addq	$-0x80, %r9
00000001000070c6	movl	%edi, %r10d
00000001000070c9	andl	$0x1f, %r10d
00000001000070cd	subq	%r10, %rsi
00000001000070d0	xorl	%r10d, %r10d
00000001000070d3	movdqa	0x2865(%rip), %xmm0
00000001000070db	movdqu	-0x10(%r9), %xmm1
00000001000070e1	movdqu	(%r9), %xmm2
00000001000070e6	pshufb	%xmm0, %xmm2
00000001000070eb	pshufb	%xmm0, %xmm1
00000001000070f0	movdqu	%xmm2, -0x26f(%rbp,%r10)
00000001000070fa	movdqu	%xmm1, -0x25f(%rbp,%r10)
0000000100007104	addq	$0x20, %r10
0000000100007108	addq	$-0x20, %r9
000000010000710c	cmpq	%r10, %rsi
000000010000710f	jne	0x1000070db
0000000100007111	testq	%rdx, %rdx
0000000100007114	je	0x1000071b6
000000010000711a	cmpl	$0x7, %edx
000000010000711d	jbe	0x100007184
000000010000711f	movq	%rcx, %rsi
0000000100007122	movl	%r8d, %edx
0000000100007125	andl	$0x7, %edx
0000000100007128	movq	%rax, %rcx
000000010000712b	subq	%rdx, %rcx
000000010000712e	movq	%rsi, %r8
0000000100007131	negq	%r8
0000000100007134	leaq	(%r8,%rbp), %r9
0000000100007138	addq	$-0x70, %r9
000000010000713c	movl	%edi, %r8d
000000010000713f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100007146	addq	%r8, %r9
0000000100007149	addq	$-0x8, %r9
000000010000714d	movl	%edi, %r10d
0000000100007150	andl	$0x7, %r10d
0000000100007154	subq	%r10, %r8
0000000100007157	movq	0x27f1(%rip), %xmm0
000000010000715f	movq	(%r9), %xmm1
0000000100007164	pshufb	%xmm0, %xmm1
0000000100007169	movq	%xmm1, -0x26f(%rbp,%rsi)
0000000100007172	addq	$0x8, %rsi
0000000100007176	addq	$-0x8, %r9
000000010000717a	cmpq	%rsi, %r8
000000010000717d	jne	0x10000715f
000000010000717f	testq	%rdx, %rdx
0000000100007182	je	0x1000071b6
0000000100007184	leaq	-0x70(%rbp), %rsi
0000000100007188	addq	%rsi, %rdx
000000010000718b	decq	%rdx
000000010000718e	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
0000000100007194	nopw	%cs:(%rax,%rax)
00000001000071a0	movzbl	(%rdx), %esi
00000001000071a3	movb	%sil, -0x26f(%rbp,%rcx)
00000001000071ab	incq	%rcx
00000001000071ae	decq	%rdx
00000001000071b1	cmpq	%rcx, %rdi
00000001000071b4	jne	0x1000071a0
00000001000071b6	movb	$0x0, -0x26f(%rbp,%rax)
00000001000071be	jmp	0x10000705e
00000001000071c3	movq	%rbx, %rdi
00000001000071c6	movsd	-0x280(%rbp), %xmm0
00000001000071ce	movl	$0x9, %esi
00000001000071d3	jmp	0x10000603a
00000001000071d8	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
00000001000071dd	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
00000001000071e7	jmp	0x10000705e
00000001000071ec	repne		jmp	0x1000071ee
00000001000071ef	pushq	%rdx
00000001000071f1	jmp	0x1000071f2
00000001000071f3	pushq	%rdx
00000001000071f5	jmp	0x1000071f6
00000001000071f7	pushq	%rdx
00000001000071f9	jmp	0x1000071fa
00000001000071fb	decl	-0x4000011(%rsi)
0000000100007201	jmp	0x100007202
0000000100007203	.byte 0xff #bad opcode
0000000100007204	sti
0000000100007205	jmp	0x100007206
0000000100007207	.byte 0xff #bad opcode
0000000100007208	sti
0000000100007209	jmp	0x10000720a
000000010000720b	.byte 0xff #bad opcode
000000010000720c	sti
000000010000720d	jmp	0x10000720e
000000010000720f	jmpq	*%rax
0000000100007211	outb	%al, %dx
0000000100007212	.byte 0xff #bad opcode
0000000100007213	.byte 0xff #bad opcode
0000000100007214	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
0000000100007219	inl	%dx, %eax
000000010000721a	.byte 0xff #bad opcode
000000010000721b	pushq	-0x22000012(%rbp)
0000000100007221	.byte 0xf1 #bad opcode
0000000100007222	.byte 0xff #bad opcode
0000000100007223	ljmpl	*0x40ffffed(%rcx)
0000000100007229	lock
000000010000722a	.byte 0xff #bad opcode
000000010000722b	incl	-0x13(%rcx)
000000010000722e	.byte 0xff #bad opcode
000000010000722f	.byte 0xff #bad opcode
0000000100007230	jl	0x100007223
0000000100007232	.byte 0xff #bad opcode
0000000100007233	jmpq	*(%rax)
0000000100007235	inb	%dx, %al
0000000100007236	.byte 0xff #bad opcode
0000000100007237	jmpq	*(%rax)
0000000100007239	inb	%dx, %al
000000010000723a	.byte 0xff #bad opcode
000000010000723b	incl	%esp
000000010000723d	lock
000000010000723e	.byte 0xff #bad opcode
000000010000723f	pushq	(%rax)
0000000100007241	.byte 0xf1 #bad opcode
0000000100007242	.byte 0xff #bad opcode
0000000100007243	callq	*(%rsi)
0000000100007245	cmc
0000000100007246	.byte 0xff #bad opcode
0000000100007247	.byte 0xff #bad opcode
0000000100007248	cmc
000000010000724a	.byte 0xff #bad opcode
000000010000724b	decl	0x5bffffee(%rbp)
0000000100007251	outb	%al, %dx
0000000100007252	.byte 0xff #bad opcode
0000000100007253	.byte 0xff #bad opcode
0000000100007254	inb	%dx, %al
0000000100007255	cmc
0000000100007256	.byte 0xff #bad opcode
0000000100007257	.byte 0xff #bad opcode
0000000100007258	inb	%dx, %al
0000000100007259	cmc
000000010000725a	.byte 0xff #bad opcode
000000010000725b	.byte 0xff #bad opcode
000000010000725c	inb	%dx, %al
000000010000725d	cmc
000000010000725e	.byte 0xff #bad opcode
000000010000725f	.byte 0xff #bad opcode
0000000100007260	inb	%dx, %al
0000000100007261	cmc
0000000100007262	.byte 0xff #bad opcode
0000000100007263	jmpq	*-0xa(%rcx)
0000000100007266	.byte 0xff #bad opcode
0000000100007267	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000726b	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000726f	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007273	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007277	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000727b	jmpq	*-0xa(%rdi)
000000010000727e	.byte 0xff #bad opcode
000000010000727f	.byte 0xff #bad opcode
0000000100007280	inb	%dx, %al
0000000100007281	cmc
0000000100007282	.byte 0xff #bad opcode
0000000100007283	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007287	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000728b	callq	*-0xa(%rbx)
000000010000728e	.byte 0xff #bad opcode
000000010000728f	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007293	ljmpl	*-0xa(%rdi)
0000000100007296	.byte 0xff #bad opcode
0000000100007297	decl	(%rdi)
0000000100007299	.byte 0x1f #bad opcode
000000010000729a	testb	%al, (%rax)
000000010000729c	addb	%al, (%rax)
000000010000729e	addb	%al, (%rax)
_buf_put:
00000001000072a0	pushq	%rbp
00000001000072a1	movq	%rsp, %rbp
00000001000072a4	pushq	%r15
00000001000072a6	pushq	%r14
00000001000072a8	pushq	%r12
00000001000072aa	pushq	%rbx
00000001000072ab	movq	%rdi, %r14
00000001000072ae	movq	0x8(%rdi), %rdi
00000001000072b2	cmpq	$-0x1, %rdi
00000001000072b6	je	0x100007358
00000001000072bc	movq	%rdx, %rbx
00000001000072bf	movq	$-0x2, %rax
00000001000072c6	subq	%rdi, %rax
00000001000072c9	cmpq	%rdx, %rax
00000001000072cc	jb	0x100007358
00000001000072d2	leaq	(%rbx,%rdi), %rax
00000001000072d6	incq	%rax
00000001000072d9	movq	0x10(%r14), %rcx
00000001000072dd	cmpq	%rcx, %rax
00000001000072e0	jbe	0x10000730f
00000001000072e2	testq	%rcx, %rcx
00000001000072e5	movl	$0x40, %r15d
00000001000072eb	cmovneq	%rcx, %r15
00000001000072ef	movq	%rsi, %r12
00000001000072f2	cmpq	%rax, %r15
00000001000072f5	jae	0x100007317
00000001000072f7	nopw	(%rax,%rax)
0000000100007300	testq	%r15, %r15
0000000100007303	js	0x100007314
0000000100007305	addq	%r15, %r15
0000000100007308	cmpq	%rax, %r15
000000010000730b	jb	0x100007300
000000010000730d	jmp	0x100007317
000000010000730f	movq	(%r14), %rax
0000000100007312	jmp	0x100007335
0000000100007314	movq	%rax, %r15
0000000100007317	movq	(%r14), %rdi
000000010000731a	movq	%r15, %rsi
000000010000731d	callq	0x10000981e                     ## symbol stub for: _realloc
0000000100007322	testq	%rax, %rax
0000000100007325	je	0x100007358
0000000100007327	movq	%rax, (%r14)
000000010000732a	movq	%r15, 0x10(%r14)
000000010000732e	movq	0x8(%r14), %rdi
0000000100007332	movq	%r12, %rsi
0000000100007335	addq	%rax, %rdi
0000000100007338	movq	%rbx, %rdx
000000010000733b	callq	0x1000097e8                     ## symbol stub for: _memcpy
0000000100007340	addq	0x8(%r14), %rbx
0000000100007344	movq	%rbx, 0x8(%r14)
0000000100007348	movq	(%r14), %rax
000000010000734b	movb	$0x0, (%rax,%rbx)
000000010000734f	popq	%rbx
0000000100007350	popq	%r12
0000000100007352	popq	%r14
0000000100007354	popq	%r15
0000000100007356	popq	%rbp
0000000100007357	retq
0000000100007358	movq	0x3cd9(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000735f	movq	(%rax), %rcx
0000000100007362	leaq	0x2839(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100007369	movl	$0x13, %esi
000000010000736e	movl	$0x1, %edx
0000000100007373	callq	0x1000097c4                     ## symbol stub for: _fwrite
0000000100007378	movl	$0x66, %edi
000000010000737d	callq	0x10000978e                     ## symbol stub for: _exit
0000000100007382	nopw	%cs:(%rax,%rax)
_fwp_escape:
0000000100007390	pushq	%rbp
0000000100007391	movq	%rsp, %rbp
0000000100007394	pushq	%r15
0000000100007396	pushq	%r14
0000000100007398	pushq	%r13
000000010000739a	pushq	%r12
000000010000739c	pushq	%rbx
000000010000739d	subq	$0x18, %rsp
00000001000073a1	movq	%rdx, %r14
00000001000073a4	movq	%rsi, %r15
00000001000073a7	movq	%rdi, %rbx
00000001000073aa	movq	0x3c7f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000073b1	movq	(%rax), %rax
00000001000073b4	movq	%rax, -0x30(%rbp)
00000001000073b8	movb	$0x22, -0x40(%rbp)
00000001000073bc	leaq	-0x40(%rbp), %rsi
00000001000073c0	movl	$0x1, %edx
00000001000073c5	callq	_buf_put
00000001000073ca	testq	%r14, %r14
00000001000073cd	je	0x1000074c9
00000001000073d3	leaq	0x12a(%rip), %r12
00000001000073da	xorl	%r13d, %r13d
00000001000073dd	jmp	0x100007401
00000001000073df	movl	$0x2, %edx
00000001000073e4	movq	%rbx, %rdi
00000001000073e7	leaq	0x2948(%rip), %rsi              ## literal pool for: "\\r"
00000001000073ee	nop
00000001000073f0	callq	_buf_put
00000001000073f5	incq	%r13
00000001000073f8	cmpq	%r13, %r14
00000001000073fb	je	0x1000074c9
0000000100007401	movzbl	(%r15,%r13), %eax
0000000100007406	movzbl	%al, %ecx
0000000100007409	leal	-0x9(%rcx), %edx
000000010000740c	cmpl	$0x19, %edx
000000010000740f	ja	0x100007430
0000000100007411	movslq	(%r12,%rdx,4), %rdx
0000000100007415	addq	%r12, %rdx
0000000100007418	jmpq	*%rdx
000000010000741a	movl	$0x2, %edx
000000010000741f	movq	%rbx, %rdi
0000000100007422	leaq	0x290a(%rip), %rsi              ## literal pool for: "\\t"
0000000100007429	jmp	0x1000073f0
000000010000742b	nopl	(%rax,%rax)
0000000100007430	cmpl	$0x5c, %ecx
0000000100007433	jne	0x100007446
0000000100007435	movl	$0x2, %edx
000000010000743a	movq	%rbx, %rdi
000000010000743d	leaq	0x28e9(%rip), %rsi              ## literal pool for: "\\\\"
0000000100007444	jmp	0x1000073f0
0000000100007446	cmpb	$0x20, %al
0000000100007448	setae	%dl
000000010000744b	cmpb	$0x7f, %al
000000010000744d	setne	%sil
0000000100007451	testb	%sil, %dl
0000000100007454	jne	0x1000074b5
0000000100007456	movl	$0x10, %esi
000000010000745b	leaq	-0x40(%rbp), %r12
000000010000745f	movq	%r12, %rdi
0000000100007462	leaq	0x28d0(%rip), %rdx              ## literal pool for: "\\u{%x}"
0000000100007469	xorl	%eax, %eax
000000010000746b	callq	0x100009842                     ## symbol stub for: _snprintf
0000000100007470	movq	%r12, %rdi
0000000100007473	callq	0x100009860                     ## symbol stub for: _strlen
0000000100007478	movq	%rbx, %rdi
000000010000747b	movq	%r12, %rsi
000000010000747e	leaq	0x7f(%rip), %r12
0000000100007485	movq	%rax, %rdx
0000000100007488	jmp	0x1000073f0
000000010000748d	movl	$0x2, %edx
0000000100007492	movq	%rbx, %rdi
0000000100007495	leaq	0x288e(%rip), %rsi              ## literal pool for: "\\\""
000000010000749c	jmp	0x1000073f0
00000001000074a1	movl	$0x2, %edx
00000001000074a6	movq	%rbx, %rdi
00000001000074a9	leaq	0x2880(%rip), %rsi              ## literal pool for: "\\n"
00000001000074b0	jmp	0x1000073f0
00000001000074b5	movb	%al, -0x40(%rbp)
00000001000074b8	movl	$0x1, %edx
00000001000074bd	movq	%rbx, %rdi
00000001000074c0	leaq	-0x40(%rbp), %rsi
00000001000074c4	jmp	0x1000073f0
00000001000074c9	movb	$0x22, -0x40(%rbp)
00000001000074cd	leaq	-0x40(%rbp), %rsi
00000001000074d1	movl	$0x1, %edx
00000001000074d6	movq	%rbx, %rdi
00000001000074d9	callq	_buf_put
00000001000074de	movq	0x3b4b(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000074e5	movq	(%rax), %rax
00000001000074e8	cmpq	-0x30(%rbp), %rax
00000001000074ec	jne	0x1000074fd
00000001000074ee	addq	$0x18, %rsp
00000001000074f2	popq	%rbx
00000001000074f3	popq	%r12
00000001000074f5	popq	%r13
00000001000074f7	popq	%r14
00000001000074f9	popq	%r15
00000001000074fb	popq	%rbp
00000001000074fc	retq
00000001000074fd	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100007502	nop
0000000100007504	.byte 0x16 #bad opcode
0000000100007505	.byte 0xff #bad opcode
0000000100007506	.byte 0xff #bad opcode
0000000100007507	lcalll	*0x42ffffff(%rbp)
000000010000750d	.byte 0xff #bad opcode
000000010000750e	.byte 0xff #bad opcode
000000010000750f	incl	-0x1(%rdx)
0000000100007512	.byte 0xff #bad opcode
0000000100007513	.byte 0xff #bad opcode
0000000100007514	.byte 0xdb #bad opcode
0000000100007515	.byte 0xfe #bad opcode
0000000100007516	.byte 0xff #bad opcode
0000000100007517	incl	-0x1(%rdx)
000000010000751a	.byte 0xff #bad opcode
000000010000751b	incl	-0x1(%rdx)
000000010000751e	.byte 0xff #bad opcode
000000010000751f	incl	-0x1(%rdx)
0000000100007522	.byte 0xff #bad opcode
0000000100007523	incl	-0x1(%rdx)
0000000100007526	.byte 0xff #bad opcode
0000000100007527	incl	-0x1(%rdx)
000000010000752a	.byte 0xff #bad opcode
000000010000752b	incl	-0x1(%rdx)
000000010000752e	.byte 0xff #bad opcode
000000010000752f	incl	-0x1(%rdx)
0000000100007532	.byte 0xff #bad opcode
0000000100007533	incl	-0x1(%rdx)
0000000100007536	.byte 0xff #bad opcode
0000000100007537	incl	-0x1(%rdx)
000000010000753a	.byte 0xff #bad opcode
000000010000753b	incl	-0x1(%rdx)
000000010000753e	.byte 0xff #bad opcode
000000010000753f	incl	-0x1(%rdx)
0000000100007542	.byte 0xff #bad opcode
0000000100007543	incl	-0x1(%rdx)
0000000100007546	.byte 0xff #bad opcode
0000000100007547	incl	-0x1(%rdx)
000000010000754a	.byte 0xff #bad opcode
000000010000754b	incl	-0x1(%rdx)
000000010000754e	.byte 0xff #bad opcode
000000010000754f	incl	-0x1(%rdx)
0000000100007552	.byte 0xff #bad opcode
0000000100007553	incl	-0x1(%rdx)
0000000100007556	.byte 0xff #bad opcode
0000000100007557	incl	-0x1(%rdx)
000000010000755a	.byte 0xff #bad opcode
000000010000755b	incl	-0x1(%rdx)
000000010000755e	.byte 0xff #bad opcode
000000010000755f	incl	-0x1(%rdx)
0000000100007562	.byte 0xff #bad opcode
0000000100007563	incl	-0x1(%rdx)
0000000100007566	.byte 0xff #bad opcode
0000000100007567	decl	0xfffffff(%rcx)
000000010000756d	.byte 0x1f #bad opcode
000000010000756e	addb	%dl, 0x48(%rbp)
0000000100007572	movl	%esp, %ebp
0000000100007574	pushq	%r15
0000000100007576	pushq	%r14
0000000100007578	pushq	%r13
000000010000757a	pushq	%r12
000000010000757c	pushq	%rbx
000000010000757d	subq	$0x88, %rsp
0000000100007584	movq	0x3aa5(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000758b	movq	(%rax), %rax
000000010000758e	movq	%rax, -0x30(%rbp)
0000000100007592	movq	%rsi, %rax
0000000100007595	orq	%rdx, %rax
0000000100007598	je	0x100007869
000000010000759e	movq	%rdx, %r8
00000001000075a1	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
00000001000075ab	imulq	%rsi, %rcx
00000001000075af	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
00000001000075b9	movq	%rsi, %rax
00000001000075bc	mulq	%r9
00000001000075bf	addq	%rcx, %rdx
00000001000075c2	imulq	%r8, %r9
00000001000075c6	addq	%rdx, %r9
00000001000075c9	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
00000001000075d3	addq	%rax, %rcx
00000001000075d6	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
00000001000075e0	adcq	%r9, %rax
00000001000075e3	movq	%rax, %rdx
00000001000075e6	shrdq	$0xd, %rcx, %rdx
00000001000075eb	shldq	$0x33, %rcx, %rax
00000001000075f0	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
00000001000075fa	cmpq	%rax, %rcx
00000001000075fd	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
0000000100007602	sbbq	%rdx, %rax
0000000100007605	jae	0x100007886
000000010000760b	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
0000000100007615	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
000000010000761f	movq	%rsi, %rax
0000000100007622	mulq	%r9
0000000100007625	imulq	%rsi, %rcx
0000000100007629	addq	%rcx, %rdx
000000010000762c	imulq	%r8, %r9
0000000100007630	addq	%rdx, %r9
0000000100007633	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
000000010000763d	addq	%rax, %rcx
0000000100007640	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
000000010000764a	adcq	%r9, %rax
000000010000764d	movq	%rax, %rdx
0000000100007650	shrdq	$0xb, %rcx, %rdx
0000000100007655	shldq	$0x35, %rcx, %rax
000000010000765a	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
0000000100007664	cmpq	%rcx, %rax
0000000100007667	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
000000010000766e	jb	0x1000078a8
0000000100007674	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
000000010000767e	imulq	%rsi, %rcx
0000000100007682	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
000000010000768c	movq	%rsi, %rax
000000010000768f	mulq	%r9
0000000100007692	addq	%rcx, %rdx
0000000100007695	imulq	%r8, %r9
0000000100007699	addq	%rdx, %r9
000000010000769c	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
00000001000076a6	addq	%rax, %rcx
00000001000076a9	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
00000001000076b3	adcq	%r9, %rax
00000001000076b6	movq	%rax, %rdx
00000001000076b9	shrdq	$0x9, %rcx, %rdx
00000001000076be	shldq	$0x37, %rcx, %rax
00000001000076c3	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
00000001000076cd	cmpq	%rcx, %rax
00000001000076d0	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
00000001000076da	sbbq	%rax, %rdx
00000001000076dd	jb	0x1000079a8
00000001000076e3	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
00000001000076ed	imulq	%rsi, %rcx
00000001000076f1	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
00000001000076fb	movq	%rsi, %rax
00000001000076fe	mulq	%r9
0000000100007701	addq	%rcx, %rdx
0000000100007704	imulq	%r8, %r9
0000000100007708	addq	%rdx, %r9
000000010000770b	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
0000000100007715	addq	%rax, %rcx
0000000100007718	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
0000000100007722	adcq	%r9, %rax
0000000100007725	movq	%rax, %rdx
0000000100007728	shrdq	$0x6, %rcx, %rdx
000000010000772d	shldq	$0x3a, %rcx, %rax
0000000100007732	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
000000010000773c	cmpq	%rcx, %rax
000000010000773f	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
0000000100007749	sbbq	%rax, %rdx
000000010000774c	jb	0x1000079b9
0000000100007752	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
000000010000775c	imulq	%rsi, %rcx
0000000100007760	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
000000010000776a	movq	%rsi, %rax
000000010000776d	mulq	%r9
0000000100007770	addq	%rcx, %rdx
0000000100007773	imulq	%r8, %r9
0000000100007777	addq	%rdx, %r9
000000010000777a	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
0000000100007784	addq	%rax, %rcx
0000000100007787	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
0000000100007791	adcq	%r9, %rax
0000000100007794	movq	%rax, %rdx
0000000100007797	shrdq	$0x3, %rcx, %rdx
000000010000779c	shldq	$0x3d, %rcx, %rax
00000001000077a1	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
00000001000077ab	cmpq	%rcx, %rax
00000001000077ae	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
00000001000077b8	sbbq	%rax, %rdx
00000001000077bb	jb	0x1000079ca
00000001000077c1	testq	%r8, %r8
00000001000077c4	js	0x100007dec
00000001000077ca	xorl	%r10d, %r10d
00000001000077cd	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000077d7	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000077e1	movq	%r8, %r14
00000001000077e4	nopw	%cs:(%rax,%rax)
00000001000077f0	movq	%r8, %rcx
00000001000077f3	shldq	$0x3f, %rsi, %rcx
00000001000077f8	shrq	%r14
00000001000077fb	movq	%rcx, %r9
00000001000077fe	addq	%r14, %r9
0000000100007801	adcq	$0x0, %r9
0000000100007805	movq	%r9, %rax
0000000100007808	mulq	%r11
000000010000780b	shrq	$0x2, %rdx
000000010000780f	leaq	(%rdx,%rdx,4), %rax
0000000100007813	subq	%rax, %r9
0000000100007816	subq	%r9, %rcx
0000000100007819	sbbq	$0x0, %r14
000000010000781d	movq	%rcx, %r9
0000000100007820	imulq	%rbx, %r9
0000000100007824	movq	%rcx, %rax
0000000100007827	mulq	%r11
000000010000782a	addq	%r9, %rdx
000000010000782d	imulq	%r11, %r14
0000000100007831	addq	%rdx, %r14
0000000100007834	movq	%rax, %rcx
0000000100007837	addq	%rax, %rcx
000000010000783a	leaq	(%rcx,%rcx,4), %rcx
000000010000783e	movl	%esi, %edx
0000000100007840	subl	%ecx, %edx
0000000100007842	orb	$0x30, %dl
0000000100007845	movb	%dl, -0x70(%rbp,%r10)
000000010000784a	incq	%r10
000000010000784d	cmpq	$0xa, %rsi
0000000100007851	sbbq	$0x0, %r8
0000000100007855	movq	%rax, %rsi
0000000100007858	movq	%r14, %r8
000000010000785b	jae	0x1000077f0
000000010000785d	testl	%r10d, %r10d
0000000100007860	jg	0x100007873
0000000100007862	xorl	%eax, %eax
0000000100007864	jmp	0x100007986
0000000100007869	movb	$0x30, -0x70(%rbp)
000000010000786d	movl	$0x1, %r10d
0000000100007873	movl	%r10d, %eax
0000000100007876	cmpq	$0x8, %rax
000000010000787a	jae	0x10000789f
000000010000787c	xorl	%ecx, %ecx
000000010000787e	movq	%rax, %rdx
0000000100007881	jmp	0x100007962
0000000100007886	movq	%rdi, %r14
0000000100007889	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
0000000100007893	leaq	_fwp_fmt_duration.units(%rip), %rbx
000000010000789a	jmp	0x1000079d9
000000010000789f	cmpl	$0x20, %eax
00000001000078a2	jae	0x1000078c1
00000001000078a4	xorl	%ecx, %ecx
00000001000078a6	jmp	0x10000791b
00000001000078a8	movq	%rdi, %r14
00000001000078ab	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
00000001000078b5	leaq	0x3b64(%rip), %rbx
00000001000078bc	jmp	0x1000079d9
00000001000078c1	movl	%r10d, %edx
00000001000078c4	andl	$0x1f, %edx
00000001000078c7	movq	%rax, %rcx
00000001000078ca	subq	%rdx, %rcx
00000001000078cd	leaq	-0xa0(%rbp), %rsi
00000001000078d4	movdqa	0x2064(%rip), %xmm0
00000001000078dc	movq	%rax, %r8
00000001000078df	nop
00000001000078e0	movdqu	-0x90(%rbp,%r8), %xmm1
00000001000078ea	movdqu	-0x80(%rbp,%r8), %xmm2
00000001000078f1	pshufb	%xmm0, %xmm2
00000001000078f6	pshufb	%xmm0, %xmm1
00000001000078fb	movdqa	%xmm2, -0x10(%rsi)
0000000100007900	movdqa	%xmm1, (%rsi)
0000000100007904	addq	$-0x20, %r8
0000000100007908	addq	$0x20, %rsi
000000010000790c	cmpq	%r8, %rdx
000000010000790f	jne	0x1000078e0
0000000100007911	testq	%rdx, %rdx
0000000100007914	je	0x100007986
0000000100007916	cmpl	$0x7, %edx
0000000100007919	jbe	0x100007962
000000010000791b	movl	%r10d, %edx
000000010000791e	andl	$0x7, %edx
0000000100007921	movq	%rax, %rsi
0000000100007924	subq	%rcx, %rsi
0000000100007927	leaq	(%rcx,%rbp), %r8
000000010000792b	addq	$-0xb0, %r8
0000000100007932	movq	%rax, %rcx
0000000100007935	subq	%rdx, %rcx
0000000100007938	movq	0x2010(%rip), %xmm0
0000000100007940	movq	-0x78(%rbp,%rsi), %xmm1
0000000100007946	pshufb	%xmm0, %xmm1
000000010000794b	movq	%xmm1, (%r8)
0000000100007950	addq	$-0x8, %rsi
0000000100007954	addq	$0x8, %r8
0000000100007958	cmpq	%rsi, %rdx
000000010000795b	jne	0x100007940
000000010000795d	testq	%rdx, %rdx
0000000100007960	je	0x100007986
0000000100007962	leaq	-0x70(%rbp), %rsi
0000000100007966	addq	%rsi, %rdx
0000000100007969	decq	%rdx
000000010000796c	nopl	(%rax)
0000000100007970	movzbl	(%rdx), %esi
0000000100007973	movb	%sil, -0xb0(%rbp,%rcx)
000000010000797b	incq	%rcx
000000010000797e	decq	%rdx
0000000100007981	cmpq	%rcx, %rax
0000000100007984	jne	0x100007970
0000000100007986	movb	$0x0, -0xb0(%rbp,%rax)
000000010000798e	leaq	0x23be(%rip), %rsi              ## literal pool for: "%sns"
0000000100007995	leaq	-0xb0(%rbp), %rdx
000000010000799c	xorl	%eax, %eax
000000010000799e	callq	0x100009848                     ## symbol stub for: _sprintf
00000001000079a3	jmp	0x100007dc6
00000001000079a8	movq	%rdi, %r14
00000001000079ab	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
00000001000079b0	leaq	0x3a79(%rip), %rbx
00000001000079b7	jmp	0x1000079d9
00000001000079b9	movq	%rdi, %r14
00000001000079bc	movl	$0xf4240, %edx                  ## imm = 0xF4240
00000001000079c1	leaq	0x3a78(%rip), %rbx
00000001000079c8	jmp	0x1000079d9
00000001000079ca	movq	%rdi, %r14
00000001000079cd	movl	$0x3e8, %edx                    ## imm = 0x3E8
00000001000079d2	leaq	0x3a77(%rip), %rbx
00000001000079d9	xorl	%ecx, %ecx
00000001000079db	movq	%rsi, %rdi
00000001000079de	movq	%r8, %rsi
00000001000079e1	callq	0x100009734                     ## symbol stub for: ___divti3
00000001000079e6	movq	%rax, %rcx
00000001000079e9	movq	%rdx, %rsi
00000001000079ec	testq	%rdx, %rdx
00000001000079ef	js	0x100007aa0
00000001000079f5	movq	%rcx, %rax
00000001000079f8	orq	%rsi, %rax
00000001000079fb	je	0x100007b79
0000000100007a01	xorl	%r10d, %r10d
0000000100007a04	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100007a0e	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100007a18	movq	%rsi, %r12
0000000100007a1b	movq	%r14, %rdi
0000000100007a1e	nop
0000000100007a20	movq	%rsi, %r8
0000000100007a23	shldq	$0x3f, %rcx, %r8
0000000100007a28	shrq	%r12
0000000100007a2b	movq	%r8, %r9
0000000100007a2e	addq	%r12, %r9
0000000100007a31	adcq	$0x0, %r9
0000000100007a35	movq	%r9, %rax
0000000100007a38	mulq	%r11
0000000100007a3b	shrq	$0x2, %rdx
0000000100007a3f	leaq	(%rdx,%rdx,4), %rax
0000000100007a43	subq	%rax, %r9
0000000100007a46	subq	%r9, %r8
0000000100007a49	sbbq	$0x0, %r12
0000000100007a4d	movq	%r8, %r9
0000000100007a50	imulq	%r15, %r9
0000000100007a54	movq	%r8, %rax
0000000100007a57	mulq	%r11
0000000100007a5a	addq	%r9, %rdx
0000000100007a5d	imulq	%r11, %r12
0000000100007a61	addq	%rdx, %r12
0000000100007a64	movq	%rax, %rdx
0000000100007a67	addq	%rax, %rdx
0000000100007a6a	leaq	(%rdx,%rdx,4), %rdx
0000000100007a6e	movl	%ecx, %r8d
0000000100007a71	subl	%edx, %r8d
0000000100007a74	orb	$0x30, %r8b
0000000100007a78	movb	%r8b, -0x70(%rbp,%r10)
0000000100007a7d	incq	%r10
0000000100007a80	cmpq	$0xa, %rcx
0000000100007a84	sbbq	$0x0, %rsi
0000000100007a88	movq	%rax, %rcx
0000000100007a8b	movq	%r12, %rsi
0000000100007a8e	jae	0x100007a20
0000000100007a90	testl	%r10d, %r10d
0000000100007a93	jg	0x100007b86
0000000100007a99	xorl	%eax, %eax
0000000100007a9b	jmp	0x100007c76
0000000100007aa0	movb	$0x2d, -0xb0(%rbp)
0000000100007aa7	xorl	%r9d, %r9d
0000000100007aaa	negq	%rcx
0000000100007aad	movl	$0x0, %r11d
0000000100007ab3	sbbq	%rsi, %r11
0000000100007ab6	movl	$0x1, %r13d
0000000100007abc	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100007ac6	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100007ad0	movq	%r11, %r12
0000000100007ad3	nopw	%cs:(%rax,%rax)
0000000100007ae0	movq	%r11, %rsi
0000000100007ae3	shldq	$0x3f, %rcx, %rsi
0000000100007ae8	shrq	%r12
0000000100007aeb	movq	%rsi, %rdi
0000000100007aee	addq	%r12, %rdi
0000000100007af1	adcq	$0x0, %rdi
0000000100007af5	movq	%rdi, %rax
0000000100007af8	mulq	%r10
0000000100007afb	movl	%r13d, %r8d
0000000100007afe	shrq	$0x2, %rdx
0000000100007b02	leaq	(%rdx,%rdx,4), %rax
0000000100007b06	subq	%rax, %rdi
0000000100007b09	subq	%rdi, %rsi
0000000100007b0c	sbbq	$0x0, %r12
0000000100007b10	movq	%rsi, %rdi
0000000100007b13	movq	%rsi, %rax
0000000100007b16	mulq	%r10
0000000100007b19	imulq	%r15, %rdi
0000000100007b1d	addq	%rdi, %rdx
0000000100007b20	imulq	%r10, %r12
0000000100007b24	addq	%rdx, %r12
0000000100007b27	movq	%rax, %rdx
0000000100007b2a	addq	%rax, %rdx
0000000100007b2d	leaq	(%rdx,%rdx,4), %rdx
0000000100007b31	movl	%ecx, %esi
0000000100007b33	subl	%edx, %esi
0000000100007b35	orb	$0x30, %sil
0000000100007b39	movb	%sil, -0x70(%rbp,%r9)
0000000100007b3e	incq	%r9
0000000100007b41	leal	0x1(%r8), %r13d
0000000100007b45	cmpq	$0xa, %rcx
0000000100007b49	sbbq	$0x0, %r11
0000000100007b4d	movq	%rax, %rcx
0000000100007b50	movq	%r12, %r11
0000000100007b53	jae	0x100007ae0
0000000100007b55	testl	%r9d, %r9d
0000000100007b58	movq	%r14, %rdi
0000000100007b5b	jle	0x100007ba2
0000000100007b5d	movl	%r9d, %eax
0000000100007b60	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100007b65	cmpq	$0x8, %rax
0000000100007b69	jae	0x100007c83
0000000100007b6f	xorl	%ecx, %ecx
0000000100007b71	movq	%rax, %rdx
0000000100007b74	jmp	0x100007d75
0000000100007b79	movb	$0x30, -0x70(%rbp)
0000000100007b7d	movl	$0x1, %r10d
0000000100007b83	movq	%r14, %rdi
0000000100007b86	movl	%r10d, %eax
0000000100007b89	cmpq	$0x8, %rax
0000000100007b8d	jae	0x100007b99
0000000100007b8f	xorl	%ecx, %ecx
0000000100007b91	movq	%rax, %rdx
0000000100007b94	jmp	0x100007c52
0000000100007b99	cmpl	$0x20, %eax
0000000100007b9c	jae	0x100007ba9
0000000100007b9e	xorl	%ecx, %ecx
0000000100007ba0	jmp	0x100007c0b
0000000100007ba2	xorl	%eax, %eax
0000000100007ba4	jmp	0x100007da6
0000000100007ba9	movl	%r10d, %edx
0000000100007bac	andl	$0x1f, %edx
0000000100007baf	movq	%rax, %rcx
0000000100007bb2	subq	%rdx, %rcx
0000000100007bb5	leaq	-0xa0(%rbp), %rsi
0000000100007bbc	movdqa	0x1d7c(%rip), %xmm0
0000000100007bc4	movq	%rax, %r8
0000000100007bc7	nopw	(%rax,%rax)
0000000100007bd0	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100007bda	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100007be1	pshufb	%xmm0, %xmm2
0000000100007be6	pshufb	%xmm0, %xmm1
0000000100007beb	movdqa	%xmm2, -0x10(%rsi)
0000000100007bf0	movdqa	%xmm1, (%rsi)
0000000100007bf4	addq	$-0x20, %r8
0000000100007bf8	addq	$0x20, %rsi
0000000100007bfc	cmpq	%r8, %rdx
0000000100007bff	jne	0x100007bd0
0000000100007c01	testq	%rdx, %rdx
0000000100007c04	je	0x100007c76
0000000100007c06	cmpl	$0x7, %edx
0000000100007c09	jbe	0x100007c52
0000000100007c0b	movl	%r10d, %edx
0000000100007c0e	andl	$0x7, %edx
0000000100007c11	movq	%rax, %rsi
0000000100007c14	subq	%rcx, %rsi
0000000100007c17	leaq	(%rcx,%rbp), %r8
0000000100007c1b	addq	$-0xb0, %r8
0000000100007c22	movq	%rax, %rcx
0000000100007c25	subq	%rdx, %rcx
0000000100007c28	movq	0x1d20(%rip), %xmm0
0000000100007c30	movq	-0x78(%rbp,%rsi), %xmm1
0000000100007c36	pshufb	%xmm0, %xmm1
0000000100007c3b	movq	%xmm1, (%r8)
0000000100007c40	addq	$-0x8, %rsi
0000000100007c44	addq	$0x8, %r8
0000000100007c48	cmpq	%rsi, %rdx
0000000100007c4b	jne	0x100007c30
0000000100007c4d	testq	%rdx, %rdx
0000000100007c50	je	0x100007c76
0000000100007c52	leaq	-0x70(%rbp), %rsi
0000000100007c56	addq	%rsi, %rdx
0000000100007c59	decq	%rdx
0000000100007c5c	nopl	(%rax)
0000000100007c60	movzbl	(%rdx), %esi
0000000100007c63	movb	%sil, -0xb0(%rbp,%rcx)
0000000100007c6b	incq	%rcx
0000000100007c6e	decq	%rdx
0000000100007c71	cmpq	%rcx, %rax
0000000100007c74	jne	0x100007c60
0000000100007c76	movb	$0x0, -0xb0(%rbp,%rax)
0000000100007c7e	jmp	0x100007dae
0000000100007c83	cmpl	$0x20, %eax
0000000100007c86	jae	0x100007c8c
0000000100007c88	xorl	%ecx, %ecx
0000000100007c8a	jmp	0x100007d04
0000000100007c8c	movl	%r9d, %edx
0000000100007c8f	andl	$0x1f, %edx
0000000100007c92	movq	%rax, %rcx
0000000100007c95	subq	%rdx, %rcx
0000000100007c98	movl	%r8d, %esi
0000000100007c9b	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100007ca1	leaq	(%rsi,%rbp), %r10
0000000100007ca5	addq	$-0x80, %r10
0000000100007ca9	movl	%r8d, %r11d
0000000100007cac	andl	$0x1f, %r11d
0000000100007cb0	subq	%r11, %rsi
0000000100007cb3	xorl	%r11d, %r11d
0000000100007cb6	movdqa	0x1c82(%rip), %xmm0
0000000100007cbe	nop
0000000100007cc0	movdqu	-0x10(%r10), %xmm1
0000000100007cc6	movdqu	(%r10), %xmm2
0000000100007ccb	pshufb	%xmm0, %xmm2
0000000100007cd0	pshufb	%xmm0, %xmm1
0000000100007cd5	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100007cdf	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100007ce9	addq	$0x20, %r11
0000000100007ced	addq	$-0x20, %r10
0000000100007cf1	cmpq	%r11, %rsi
0000000100007cf4	jne	0x100007cc0
0000000100007cf6	testq	%rdx, %rdx
0000000100007cf9	je	0x100007da6
0000000100007cff	cmpl	$0x7, %edx
0000000100007d02	jbe	0x100007d75
0000000100007d04	movq	%rcx, %rsi
0000000100007d07	movl	%r9d, %edx
0000000100007d0a	andl	$0x7, %edx
0000000100007d0d	movq	%rax, %rcx
0000000100007d10	subq	%rdx, %rcx
0000000100007d13	movq	%rsi, %r9
0000000100007d16	negq	%r9
0000000100007d19	leaq	(%r9,%rbp), %r10
0000000100007d1d	addq	$-0x70, %r10
0000000100007d21	movl	%r8d, %r9d
0000000100007d24	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100007d2b	addq	%r9, %r10
0000000100007d2e	addq	$-0x8, %r10
0000000100007d32	movl	%r8d, %r11d
0000000100007d35	andl	$0x7, %r11d
0000000100007d39	subq	%r11, %r9
0000000100007d3c	movq	0x1c0c(%rip), %xmm0
0000000100007d44	nopw	%cs:(%rax,%rax)
0000000100007d50	movq	(%r10), %xmm1
0000000100007d55	pshufb	%xmm0, %xmm1
0000000100007d5a	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100007d63	addq	$0x8, %rsi
0000000100007d67	addq	$-0x8, %r10
0000000100007d6b	cmpq	%rsi, %r9
0000000100007d6e	jne	0x100007d50
0000000100007d70	testq	%rdx, %rdx
0000000100007d73	je	0x100007da6
0000000100007d75	leaq	-0x70(%rbp), %rsi
0000000100007d79	addq	%rsi, %rdx
0000000100007d7c	decq	%rdx
0000000100007d7f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100007d86	nopw	%cs:(%rax,%rax)
0000000100007d90	movzbl	(%rdx), %esi
0000000100007d93	movb	%sil, -0xaf(%rbp,%rcx)
0000000100007d9b	incq	%rcx
0000000100007d9e	decq	%rdx
0000000100007da1	cmpq	%rcx, %r8
0000000100007da4	jne	0x100007d90
0000000100007da6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100007dae	movq	(%rbx), %rcx
0000000100007db1	leaq	0x1f96(%rip), %rsi              ## literal pool for: "%s%s"
0000000100007db8	leaq	-0xb0(%rbp), %rdx
0000000100007dbf	xorl	%eax, %eax
0000000100007dc1	callq	0x100009848                     ## symbol stub for: _sprintf
0000000100007dc6	movq	0x3263(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007dcd	movq	(%rax), %rax
0000000100007dd0	cmpq	-0x30(%rbp), %rax
0000000100007dd4	jne	0x100007fd3
0000000100007dda	addq	$0x88, %rsp
0000000100007de1	popq	%rbx
0000000100007de2	popq	%r12
0000000100007de4	popq	%r13
0000000100007de6	popq	%r14
0000000100007de8	popq	%r15
0000000100007dea	popq	%rbp
0000000100007deb	retq
0000000100007dec	movb	$0x2d, -0xb0(%rbp)
0000000100007df3	xorl	%r10d, %r10d
0000000100007df6	negq	%rsi
0000000100007df9	movl	$0x0, %ebx
0000000100007dfe	sbbq	%r8, %rbx
0000000100007e01	movl	$0x1, %r12d
0000000100007e07	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100007e11	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100007e1b	movq	%rbx, %r15
0000000100007e1e	nop
0000000100007e20	movq	%rbx, %rcx
0000000100007e23	shldq	$0x3f, %rsi, %rcx
0000000100007e28	shrq	%r15
0000000100007e2b	movq	%rcx, %r8
0000000100007e2e	addq	%r15, %r8
0000000100007e31	adcq	$0x0, %r8
0000000100007e35	movq	%r8, %rax
0000000100007e38	mulq	%r11
0000000100007e3b	movl	%r12d, %r9d
0000000100007e3e	shrq	$0x2, %rdx
0000000100007e42	leaq	(%rdx,%rdx,4), %rax
0000000100007e46	subq	%rax, %r8
0000000100007e49	subq	%r8, %rcx
0000000100007e4c	sbbq	$0x0, %r15
0000000100007e50	movq	%rcx, %r8
0000000100007e53	movq	%rcx, %rax
0000000100007e56	mulq	%r11
0000000100007e59	imulq	%r14, %r8
0000000100007e5d	addq	%r8, %rdx
0000000100007e60	imulq	%r11, %r15
0000000100007e64	addq	%rdx, %r15
0000000100007e67	movq	%rax, %rcx
0000000100007e6a	addq	%rax, %rcx
0000000100007e6d	leaq	(%rcx,%rcx,4), %rcx
0000000100007e71	movl	%esi, %edx
0000000100007e73	subl	%ecx, %edx
0000000100007e75	orb	$0x30, %dl
0000000100007e78	movb	%dl, -0x70(%rbp,%r10)
0000000100007e7d	incq	%r10
0000000100007e80	leal	0x1(%r9), %r12d
0000000100007e84	cmpq	$0xa, %rsi
0000000100007e88	sbbq	$0x0, %rbx
0000000100007e8c	movq	%rax, %rsi
0000000100007e8f	movq	%r15, %rbx
0000000100007e92	jae	0x100007e20
0000000100007e94	testl	%r10d, %r10d
0000000100007e97	jle	0x100007eb1
0000000100007e99	movl	%r10d, %eax
0000000100007e9c	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100007ea1	cmpq	$0x8, %rax
0000000100007ea5	jae	0x100007eb8
0000000100007ea7	xorl	%ecx, %ecx
0000000100007ea9	movq	%rax, %rdx
0000000100007eac	jmp	0x100007f9c
0000000100007eb1	xorl	%eax, %eax
0000000100007eb3	jmp	0x100007fc6
0000000100007eb8	cmpl	$0x20, %eax
0000000100007ebb	jae	0x100007ec1
0000000100007ebd	xorl	%ecx, %ecx
0000000100007ebf	jmp	0x100007f37
0000000100007ec1	movl	%r10d, %edx
0000000100007ec4	andl	$0x1f, %edx
0000000100007ec7	movq	%rax, %rcx
0000000100007eca	subq	%rdx, %rcx
0000000100007ecd	movl	%r9d, %esi
0000000100007ed0	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100007ed6	leaq	(%rsi,%rbp), %r8
0000000100007eda	addq	$-0x80, %r8
0000000100007ede	movl	%r9d, %r11d
0000000100007ee1	andl	$0x1f, %r11d
0000000100007ee5	subq	%r11, %rsi
0000000100007ee8	xorl	%r11d, %r11d
0000000100007eeb	movdqa	0x1a4d(%rip), %xmm0
0000000100007ef3	movdqu	-0x10(%r8), %xmm1
0000000100007ef9	movdqu	(%r8), %xmm2
0000000100007efe	pshufb	%xmm0, %xmm2
0000000100007f03	pshufb	%xmm0, %xmm1
0000000100007f08	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100007f12	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100007f1c	addq	$0x20, %r11
0000000100007f20	addq	$-0x20, %r8
0000000100007f24	cmpq	%r11, %rsi
0000000100007f27	jne	0x100007ef3
0000000100007f29	testq	%rdx, %rdx
0000000100007f2c	je	0x100007fc6
0000000100007f32	cmpl	$0x7, %edx
0000000100007f35	jbe	0x100007f9c
0000000100007f37	movq	%rcx, %rsi
0000000100007f3a	movl	%r10d, %edx
0000000100007f3d	andl	$0x7, %edx
0000000100007f40	movq	%rax, %rcx
0000000100007f43	subq	%rdx, %rcx
0000000100007f46	movq	%rsi, %r8
0000000100007f49	negq	%r8
0000000100007f4c	leaq	(%r8,%rbp), %r10
0000000100007f50	addq	$-0x70, %r10
0000000100007f54	movl	%r9d, %r8d
0000000100007f57	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100007f5e	addq	%r8, %r10
0000000100007f61	addq	$-0x8, %r10
0000000100007f65	movl	%r9d, %r11d
0000000100007f68	andl	$0x7, %r11d
0000000100007f6c	subq	%r11, %r8
0000000100007f6f	movq	0x19d9(%rip), %xmm0
0000000100007f77	movq	(%r10), %xmm1
0000000100007f7c	pshufb	%xmm0, %xmm1
0000000100007f81	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100007f8a	addq	$0x8, %rsi
0000000100007f8e	addq	$-0x8, %r10
0000000100007f92	cmpq	%rsi, %r8
0000000100007f95	jne	0x100007f77
0000000100007f97	testq	%rdx, %rdx
0000000100007f9a	je	0x100007fc6
0000000100007f9c	leaq	-0x70(%rbp), %rsi
0000000100007fa0	addq	%rsi, %rdx
0000000100007fa3	decq	%rdx
0000000100007fa6	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100007fad	nopl	(%rax)
0000000100007fb0	movzbl	(%rdx), %esi
0000000100007fb3	movb	%sil, -0xaf(%rbp,%rcx)
0000000100007fbb	incq	%rcx
0000000100007fbe	decq	%rdx
0000000100007fc1	cmpq	%rcx, %r9
0000000100007fc4	jne	0x100007fb0
0000000100007fc6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100007fce	jmp	0x10000798e
0000000100007fd3	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100007fd8	nopl	(%rax,%rax)
_fwp_format_g:
0000000100007fe0	pushq	%rbp
0000000100007fe1	movq	%rsp, %rbp
0000000100007fe4	pushq	%r15
0000000100007fe6	pushq	%r14
0000000100007fe8	pushq	%r13
0000000100007fea	pushq	%r12
0000000100007fec	pushq	%rbx
0000000100007fed	subq	$0x98, %rsp
0000000100007ff4	movl	%esi, %r12d
0000000100007ff7	movq	%rdi, %rbx
0000000100007ffa	movq	0x302f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008001	movq	(%rax), %rax
0000000100008004	movq	%rax, -0x30(%rbp)
0000000100008008	decl	%r12d
000000010000800b	leaq	0x1d01(%rip), %rdx              ## literal pool for: "%.*e"
0000000100008012	leaq	-0x70(%rbp), %r13
0000000100008016	movl	$0x40, %esi
000000010000801b	movq	%r13, %rdi
000000010000801e	movl	%r12d, %ecx
0000000100008021	movsd	%xmm0, -0xb8(%rbp)
0000000100008029	movb	$0x1, %al
000000010000802b	callq	0x100009842                     ## symbol stub for: _snprintf
0000000100008030	movq	%r13, %rdi
0000000100008033	movl	$0x65, %esi
0000000100008038	callq	0x10000984e                     ## symbol stub for: _strchr
000000010000803d	movq	%rax, %r15
0000000100008040	leaq	0x1(%rax), %rdi
0000000100008044	callq	0x10000977c                     ## symbol stub for: _atoi
0000000100008049	movl	%eax, %r14d
000000010000804c	leal	-0x11(%r14), %eax
0000000100008050	cmpl	$-0x17, %eax
0000000100008053	ja	0x1000080be
0000000100008055	subq	%r13, %r15
0000000100008058	leaq	-0xb0(%rbp), %r12
000000010000805f	movl	$0x40, %ecx
0000000100008064	movq	%r12, %rdi
0000000100008067	movq	%r13, %rsi
000000010000806a	movq	%r15, %rdx
000000010000806d	callq	0x100009740                     ## symbol stub for: ___memcpy_chk
0000000100008072	movb	$0x0, -0xb0(%rbp,%r15)
000000010000807b	movq	%r12, %rdi
000000010000807e	movl	$0x2e, %esi
0000000100008083	callq	0x10000984e                     ## symbol stub for: _strchr
0000000100008088	testq	%rax, %rax
000000010000808b	sete	%al
000000010000808e	testq	%r15, %r15
0000000100008091	sete	%cl
0000000100008094	orb	%al, %cl
0000000100008096	jne	0x100008136
000000010000809c	nopl	(%rax)
00000001000080a0	movzbl	-0xb1(%rbp,%r15), %eax
00000001000080a9	cmpl	$0x30, %eax
00000001000080ac	jne	0x100008128
00000001000080ae	movb	$0x0, -0xb1(%rbp,%r15)
00000001000080b7	decq	%r15
00000001000080ba	jne	0x1000080a0
00000001000080bc	jmp	0x100008136
00000001000080be	subl	%r14d, %r12d
00000001000080c1	xorl	%ecx, %ecx
00000001000080c3	testl	%r12d, %r12d
00000001000080c6	cmovgl	%r12d, %ecx
00000001000080ca	leaq	0x1c51(%rip), %rdx              ## literal pool for: "%.*f"
00000001000080d1	movl	$0x190, %esi                    ## imm = 0x190
00000001000080d6	movq	%rbx, %rdi
00000001000080d9	movsd	-0xb8(%rbp), %xmm0
00000001000080e1	movb	$0x1, %al
00000001000080e3	callq	0x100009842                     ## symbol stub for: _snprintf
00000001000080e8	movq	%rbx, %rdi
00000001000080eb	callq	0x100009860                     ## symbol stub for: _strlen
00000001000080f0	movq	%rax, %r14
00000001000080f3	movq	%rbx, %rdi
00000001000080f6	movl	$0x2e, %esi
00000001000080fb	callq	0x10000984e                     ## symbol stub for: _strchr
0000000100008100	testq	%rax, %rax
0000000100008103	sete	%al
0000000100008106	testq	%r14, %r14
0000000100008109	sete	%cl
000000010000810c	orb	%al, %cl
000000010000810e	jne	0x10000816b
0000000100008110	movzbl	-0x1(%rbx,%r14), %eax
0000000100008116	cmpl	$0x30, %eax
0000000100008119	jne	0x10000818d
000000010000811b	movb	$0x0, -0x1(%rbx,%r14)
0000000100008121	decq	%r14
0000000100008124	jne	0x100008110
0000000100008126	jmp	0x10000816b
0000000100008128	cmpl	$0x2e, %eax
000000010000812b	jne	0x100008136
000000010000812d	movb	$0x0, -0xb1(%rbp,%r15)
0000000100008136	movl	%r14d, %eax
0000000100008139	shrl	$0x1f, %eax
000000010000813c	leal	0x2b(,%rax,2), %r8d
0000000100008144	movl	%r14d, %r9d
0000000100008147	negl	%r9d
000000010000814a	cmovsl	%r14d, %r9d
000000010000814e	leaq	0x1bc3(%rip), %rdx              ## literal pool for: "%se%c%02d"
0000000100008155	leaq	-0xb0(%rbp), %rcx
000000010000815c	movl	$0x190, %esi                    ## imm = 0x190
0000000100008161	movq	%rbx, %rdi
0000000100008164	xorl	%eax, %eax
0000000100008166	callq	0x100009842                     ## symbol stub for: _snprintf
000000010000816b	movq	0x2ebe(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008172	movq	(%rax), %rax
0000000100008175	cmpq	-0x30(%rbp), %rax
0000000100008179	jne	0x10000819a
000000010000817b	addq	$0x98, %rsp
0000000100008182	popq	%rbx
0000000100008183	popq	%r12
0000000100008185	popq	%r13
0000000100008187	popq	%r14
0000000100008189	popq	%r15
000000010000818b	popq	%rbp
000000010000818c	retq
000000010000818d	cmpl	$0x2e, %eax
0000000100008190	jne	0x10000816b
0000000100008192	movb	$0x0, -0x1(%rbx,%r14)
0000000100008198	jmp	0x10000816b
000000010000819a	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
000000010000819f	nop
_fwp_owned_entry3:
00000001000081a0	pushq	%rbp
00000001000081a1	movq	%rsp, %rbp
00000001000081a4	pushq	%r15
00000001000081a6	pushq	%r14
00000001000081a8	pushq	%rbx
00000001000081a9	subq	$0x18, %rsp
00000001000081ad	movq	%rdi, %rbx
00000001000081b0	movq	_fwp_cleanups(%rip), %rax
00000001000081b7	movq	%rax, -0x30(%rbp)
00000001000081bb	leaq	_fwp_entry_release3(%rip), %rax
00000001000081c2	movq	%rax, -0x28(%rbp)
00000001000081c6	movq	%rdi, -0x20(%rbp)
00000001000081ca	leaq	-0x30(%rbp), %r15
00000001000081ce	movq	%r15, _fwp_cleanups(%rip)
00000001000081d5	movq	(%rdi), %rdi
00000001000081d8	movq	0x8(%rbx), %rsi
00000001000081dc	callq	_fwp_p_file_with_owned
00000001000081e1	cmpq	%r15, _fwp_cleanups(%rip)
00000001000081e8	jne	0x1000082b5
00000001000081ee	movq	%rax, %r14
00000001000081f1	movq	-0x30(%rbp), %rax
00000001000081f5	movq	%rax, _fwp_cleanups(%rip)
00000001000081fc	movq	(%rbx), %rax
00000001000081ff	movq	(%rbx), %rdi
0000000100008202	movq	%rdi, %rcx
0000000100008205	subq	0x4e2c(%rip), %rcx
000000010000820c	movq	0x4e4d(%rip), %rax
0000000100008213	shlq	$0x10, %rax
0000000100008217	cmpq	%rax, %rcx
000000010000821a	jae	0x100008290
000000010000821c	movq	0x4e5d(%rip), %rdx
0000000100008223	movq	%rcx, %rax
0000000100008226	shrq	$0x10, %rax
000000010000822a	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008231	leaq	(%rdx,%rsi), %rax
0000000100008235	movzbl	(%rdx,%rsi), %edx
0000000100008239	cmpb	$0x2, %dl
000000010000823c	setne	%sil
0000000100008240	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008247	setne	%r8b
000000010000824b	orb	%sil, %r8b
000000010000824e	jne	0x100008258
0000000100008250	addq	$0x228, %rax                    ## imm = 0x228
0000000100008256	jmp	0x100008271
0000000100008258	cmpb	$0x1, %dl
000000010000825b	jne	0x100008290
000000010000825d	movl	0x20(%rax), %edx
0000000100008260	imulq	%rdx, %rcx
0000000100008264	shrq	$0x20, %rcx
0000000100008268	addq	%rcx, %rax
000000010000826b	addq	$0x228, %rax                    ## imm = 0x228
0000000100008271	movzbl	(%rax), %ecx
0000000100008274	testl	%ecx, %ecx
0000000100008276	je	0x100008290
0000000100008278	cmpl	$0x1, %ecx
000000010000827b	jne	0x100008284
000000010000827d	callq	_fwp_rc_free_obj
0000000100008282	jmp	0x100008290
0000000100008284	cmpl	$0xff, %ecx
000000010000828a	je	0x1000082ab
000000010000828c	decb	%cl
000000010000828e	movb	%cl, (%rax)
0000000100008290	movq	0x8(%rbx), %rax
0000000100008294	movq	0x8(%rbx), %rdi
0000000100008298	callq	_fwp_closure_drop
000000010000829d	movq	%r14, %rax
00000001000082a0	addq	$0x18, %rsp
00000001000082a4	popq	%rbx
00000001000082a5	popq	%r14
00000001000082a7	popq	%r15
00000001000082a9	popq	%rbp
00000001000082aa	retq
00000001000082ab	movq	%rax, %rdi
00000001000082ae	callq	_fwp_rc_wide_drop
00000001000082b3	jmp	0x100008290
00000001000082b5	callq	0x100009770                     ## symbol stub for: _abort
00000001000082ba	nopw	(%rax,%rax)
_fwp_caps3:
00000001000082c0	testl	%esi, %esi
00000001000082c2	je	0x1000082d2
00000001000082c4	movl	0x4(%rdi), %edx
00000001000082c7	addq	$0x8, %rdi
00000001000082cb	xorl	%esi, %esi
00000001000082cd	jmp	_fwp_args3
00000001000082d2	pushq	%rbp
00000001000082d3	movq	%rsp, %rbp
00000001000082d6	pushq	%rbx
00000001000082d7	pushq	%rax
00000001000082d8	cmpl	$0x0, 0x4(%rdi)
00000001000082dc	je	0x10000839e
00000001000082e2	movq	0x8(%rdi), %rax
00000001000082e6	movq	%rax, %rdx
00000001000082e9	subq	0x4d48(%rip), %rdx
00000001000082f0	movq	0x4d69(%rip), %rcx
00000001000082f7	shlq	$0x10, %rcx
00000001000082fb	cmpq	%rcx, %rdx
00000001000082fe	jae	0x100008386
0000000100008304	movq	0x4d75(%rip), %rsi
000000010000830b	movq	%rdx, %rcx
000000010000830e	shrq	$0x10, %rcx
0000000100008312	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
0000000100008319	leaq	(%rsi,%r8), %rcx
000000010000831d	movzbl	(%rsi,%r8), %esi
0000000100008322	cmpb	$0x2, %sil
0000000100008326	setne	%r8b
000000010000832a	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100008331	setne	%r9b
0000000100008335	orb	%r8b, %r9b
0000000100008338	jne	0x100008343
000000010000833a	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008341	jmp	0x10000835e
0000000100008343	cmpb	$0x1, %sil
0000000100008347	jne	0x100008386
0000000100008349	movl	0x20(%rcx), %esi
000000010000834c	imulq	%rsi, %rdx
0000000100008350	shrq	$0x20, %rdx
0000000100008354	addq	%rdx, %rcx
0000000100008357	addq	$0x228, %rcx                    ## imm = 0x228
000000010000835e	movzbl	(%rcx), %edx
0000000100008361	testl	%edx, %edx
0000000100008363	je	0x100008386
0000000100008365	cmpl	$0x1, %edx
0000000100008368	jne	0x10000837a
000000010000836a	movq	%rdi, %rbx
000000010000836d	movq	%rax, %rdi
0000000100008370	callq	_fwp_rc_free_obj
0000000100008375	movq	%rbx, %rdi
0000000100008378	jmp	0x100008386
000000010000837a	cmpl	$0xff, %edx
0000000100008380	je	0x1000083a9
0000000100008382	decb	%dl
0000000100008384	movb	%dl, (%rcx)
0000000100008386	cmpl	$0x2, 0x4(%rdi)
000000010000838a	jb	0x10000839e
000000010000838c	movq	0x10(%rdi), %rax
0000000100008390	movq	%rdi, %rbx
0000000100008393	movq	%rax, %rdi
0000000100008396	callq	_fwp_closure_drop
000000010000839b	movq	%rbx, %rdi
000000010000839e	addq	$0x8, %rsp
00000001000083a2	popq	%rbx
00000001000083a3	popq	%rbp
00000001000083a4	jmp	_fwp_rc_free_obj
00000001000083a9	movq	%rdi, %rbx
00000001000083ac	movq	%rcx, %rdi
00000001000083af	callq	_fwp_rc_wide_drop
00000001000083b4	jmp	0x100008375
00000001000083b6	nopw	%cs:(%rax,%rax)
_fwp_args3:
00000001000083c0	pushq	%rbp
00000001000083c1	movq	%rsp, %rbp
00000001000083c4	pushq	%r15
00000001000083c6	pushq	%r14
00000001000083c8	pushq	%r12
00000001000083ca	pushq	%rbx
00000001000083cb	subq	$0x30, %rsp
00000001000083cf	movq	%rdi, -0x38(%rbp)
00000001000083d3	leaq	_fwp_arg_drop3(%rip), %rax
00000001000083da	movq	%rax, -0x30(%rbp)
00000001000083de	movl	%esi, -0x28(%rbp)
00000001000083e1	movl	$0x0, -0x24(%rbp)
00000001000083e8	movq	_fwp_cleanups(%rip), %rax
00000001000083ef	movq	%rax, -0x50(%rbp)
00000001000083f3	leaq	_fwp_args_release(%rip), %rax
00000001000083fa	movq	%rax, -0x48(%rbp)
00000001000083fe	leaq	-0x38(%rbp), %rax
0000000100008402	movq	%rax, -0x40(%rbp)
0000000100008406	leaq	-0x50(%rbp), %rbx
000000010000840a	movq	%rbx, _fwp_cleanups(%rip)
0000000100008411	testl	%esi, %esi
0000000100008413	setne	%al
0000000100008416	testl	%edx, %edx
0000000100008418	sete	%cl
000000010000841b	orb	%al, %cl
000000010000841d	je	0x10000842d
000000010000841f	cmpl	$0x1, %esi
0000000100008422	jbe	0x1000084bb
0000000100008428	jmp	0x100008555
000000010000842d	movq	(%rdi), %rcx
0000000100008430	subq	0x4c01(%rip), %rcx
0000000100008437	movq	0x4c22(%rip), %rax
000000010000843e	shlq	$0x10, %rax
0000000100008442	cmpq	%rax, %rcx
0000000100008445	jae	0x1000084b4
0000000100008447	movq	0x4c32(%rip), %r8
000000010000844e	movq	%rcx, %rax
0000000100008451	shrq	$0x10, %rax
0000000100008455	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
000000010000845c	leaq	(%r8,%r9), %rax
0000000100008460	movzbl	(%r8,%r9), %r8d
0000000100008465	cmpb	$0x2, %r8b
0000000100008469	setne	%r9b
000000010000846d	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008474	setne	%r10b
0000000100008478	orb	%r9b, %r10b
000000010000847b	jne	0x100008485
000000010000847d	addq	$0x228, %rax                    ## imm = 0x228
0000000100008483	jmp	0x1000084a0
0000000100008485	cmpb	$0x1, %r8b
0000000100008489	jne	0x1000084b4
000000010000848b	movl	0x20(%rax), %r8d
000000010000848f	imulq	%r8, %rcx
0000000100008493	shrq	$0x20, %rcx
0000000100008497	addq	%rcx, %rax
000000010000849a	addq	$0x228, %rax                    ## imm = 0x228
00000001000084a0	movzbl	(%rax), %ecx
00000001000084a3	testb	%cl, %cl
00000001000084a5	je	0x1000084b4
00000001000084a7	cmpb	$-0x2, %cl
00000001000084aa	jae	0x100008576
00000001000084b0	incb	%cl
00000001000084b2	movb	%cl, (%rax)
00000001000084b4	movl	$0x1, -0x24(%rbp)
00000001000084bb	movl	$0x1, %eax
00000001000084c0	subl	%esi, %eax
00000001000084c2	cmpl	%edx, %eax
00000001000084c4	jae	0x100008555
00000001000084ca	movl	%eax, %eax
00000001000084cc	movq	(%rdi,%rax,8), %rax
00000001000084d0	subq	0x4b61(%rip), %rax
00000001000084d7	movq	0x4b82(%rip), %rcx
00000001000084de	shlq	$0x10, %rcx
00000001000084e2	cmpq	%rcx, %rax
00000001000084e5	jae	0x10000854b
00000001000084e7	movq	0x4b92(%rip), %rcx
00000001000084ee	movq	%rax, %rdx
00000001000084f1	shrq	$0x10, %rdx
00000001000084f5	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000084fc	leaq	(%rcx,%rdx), %rdi
0000000100008500	movzbl	(%rcx,%rdx), %ecx
0000000100008504	cmpb	$0x2, %cl
0000000100008507	setne	%dl
000000010000850a	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008510	setne	%r8b
0000000100008514	orb	%dl, %r8b
0000000100008517	jne	0x100008522
0000000100008519	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008520	jmp	0x10000853c
0000000100008522	cmpb	$0x1, %cl
0000000100008525	jne	0x10000854b
0000000100008527	movl	0x20(%rdi), %ecx
000000010000852a	imulq	%rcx, %rax
000000010000852e	shrq	$0x20, %rax
0000000100008532	addq	%rax, %rdi
0000000100008535	addq	$0x228, %rdi                    ## imm = 0x228
000000010000853c	movzbl	(%rdi), %eax
000000010000853f	testb	%al, %al
0000000100008541	je	0x10000854b
0000000100008543	cmpb	$-0x2, %al
0000000100008545	jae	0x100008595
0000000100008547	incb	%al
0000000100008549	movb	%al, (%rdi)
000000010000854b	movl	$0x2, %eax
0000000100008550	subl	%esi, %eax
0000000100008552	movl	%eax, -0x24(%rbp)
0000000100008555	cmpq	%rbx, _fwp_cleanups(%rip)
000000010000855c	jne	0x1000085a2
000000010000855e	movq	-0x50(%rbp), %rax
0000000100008562	movq	%rax, _fwp_cleanups(%rip)
0000000100008569	addq	$0x30, %rsp
000000010000856d	popq	%rbx
000000010000856e	popq	%r12
0000000100008570	popq	%r14
0000000100008572	popq	%r15
0000000100008574	popq	%rbp
0000000100008575	retq
0000000100008576	movq	%rdi, %r14
0000000100008579	movq	%rax, %rdi
000000010000857c	movl	%esi, %r15d
000000010000857f	movl	%edx, %r12d
0000000100008582	callq	_fwp_rc_wide_dup
0000000100008587	movl	%r12d, %edx
000000010000858a	movq	%r14, %rdi
000000010000858d	movl	%r15d, %esi
0000000100008590	jmp	0x1000084b4
0000000100008595	movl	%esi, %r14d
0000000100008598	callq	_fwp_rc_wide_dup
000000010000859d	movl	%r14d, %esi
00000001000085a0	jmp	0x10000854b
00000001000085a2	callq	0x100009770                     ## symbol stub for: _abort
00000001000085a7	nopw	(%rax,%rax)
_fwp_arg_drop3:
00000001000085b0	pushq	%rbp
00000001000085b1	movq	%rsp, %rbp
00000001000085b4	pushq	%r15
00000001000085b6	pushq	%r14
00000001000085b8	pushq	%rbx
00000001000085b9	pushq	%rax
00000001000085ba	testl	%esi, %esi
00000001000085bc	setne	%al
00000001000085bf	testl	%edx, %edx
00000001000085c1	sete	%cl
00000001000085c4	orb	%al, %cl
00000001000085c6	je	0x1000085d6
00000001000085c8	cmpl	$0x1, %esi
00000001000085cb	jbe	0x10000868c
00000001000085d1	jmp	0x1000086ac
00000001000085d6	movq	(%rdi), %rax
00000001000085d9	movq	%rax, %r8
00000001000085dc	subq	0x4a55(%rip), %r8
00000001000085e3	movq	0x4a76(%rip), %rcx
00000001000085ea	shlq	$0x10, %rcx
00000001000085ee	cmpq	%rcx, %r8
00000001000085f1	jae	0x10000868c
00000001000085f7	movq	0x4a82(%rip), %r9
00000001000085fe	movq	%r8, %rcx
0000000100008601	shrq	$0x10, %rcx
0000000100008605	imulq	$0x1228, %rcx, %r10             ## imm = 0x1228
000000010000860c	leaq	(%r9,%r10), %rcx
0000000100008610	movzbl	(%r9,%r10), %r9d
0000000100008615	cmpb	$0x2, %r9b
0000000100008619	setne	%r10b
000000010000861d	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100008624	setne	%r11b
0000000100008628	orb	%r10b, %r11b
000000010000862b	jne	0x100008636
000000010000862d	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008634	jmp	0x100008652
0000000100008636	cmpb	$0x1, %r9b
000000010000863a	jne	0x10000868c
000000010000863c	movl	0x20(%rcx), %r9d
0000000100008640	imulq	%r9, %r8
0000000100008644	shrq	$0x20, %r8
0000000100008648	addq	%r8, %rcx
000000010000864b	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008652	movzbl	(%rcx), %r8d
0000000100008656	testl	%r8d, %r8d
0000000100008659	je	0x10000868c
000000010000865b	cmpl	$0x1, %r8d
000000010000865f	jne	0x10000867d
0000000100008661	movq	%rdi, %rbx
0000000100008664	movq	%rax, %rdi
0000000100008667	movl	%edx, %r14d
000000010000866a	movl	%esi, %r15d
000000010000866d	callq	_fwp_rc_free_obj
0000000100008672	movl	%r15d, %esi
0000000100008675	movl	%r14d, %edx
0000000100008678	movq	%rbx, %rdi
000000010000867b	jmp	0x10000868c
000000010000867d	cmpl	$0xff, %r8d
0000000100008684	je	0x1000086b7
0000000100008686	decb	%r8b
0000000100008689	movb	%r8b, (%rcx)
000000010000868c	movl	$0x1, %eax
0000000100008691	subl	%esi, %eax
0000000100008693	cmpl	%edx, %eax
0000000100008695	jae	0x1000086ac
0000000100008697	movl	%eax, %eax
0000000100008699	movq	(%rdi,%rax,8), %rdi
000000010000869d	addq	$0x8, %rsp
00000001000086a1	popq	%rbx
00000001000086a2	popq	%r14
00000001000086a4	popq	%r15
00000001000086a6	popq	%rbp
00000001000086a7	jmp	_fwp_closure_drop
00000001000086ac	addq	$0x8, %rsp
00000001000086b0	popq	%rbx
00000001000086b1	popq	%r14
00000001000086b3	popq	%r15
00000001000086b5	popq	%rbp
00000001000086b6	retq
00000001000086b7	movq	%rdi, %rbx
00000001000086ba	movq	%rcx, %rdi
00000001000086bd	movl	%edx, %r14d
00000001000086c0	movl	%esi, %r15d
00000001000086c3	callq	_fwp_rc_wide_drop
00000001000086c8	jmp	0x100008672
00000001000086ca	nopw	(%rax,%rax)
_fwp_entry_release3:
00000001000086d0	pushq	%rbp
00000001000086d1	movq	%rsp, %rbp
00000001000086d4	pushq	%rbx
00000001000086d5	pushq	%rax
00000001000086d6	movq	(%rdi), %rax
00000001000086d9	movq	(%rdi), %rax
00000001000086dc	movq	%rax, %rdx
00000001000086df	subq	0x4952(%rip), %rdx
00000001000086e6	movq	0x4973(%rip), %rcx
00000001000086ed	shlq	$0x10, %rcx
00000001000086f1	cmpq	%rcx, %rdx
00000001000086f4	jae	0x10000877c
00000001000086fa	movq	0x497f(%rip), %rsi
0000000100008701	movq	%rdx, %rcx
0000000100008704	shrq	$0x10, %rcx
0000000100008708	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
000000010000870f	leaq	(%rsi,%r8), %rcx
0000000100008713	movzbl	(%rsi,%r8), %esi
0000000100008718	cmpb	$0x2, %sil
000000010000871c	setne	%r8b
0000000100008720	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100008727	setne	%r9b
000000010000872b	orb	%r8b, %r9b
000000010000872e	jne	0x100008739
0000000100008730	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008737	jmp	0x100008754
0000000100008739	cmpb	$0x1, %sil
000000010000873d	jne	0x10000877c
000000010000873f	movl	0x20(%rcx), %esi
0000000100008742	imulq	%rsi, %rdx
0000000100008746	shrq	$0x20, %rdx
000000010000874a	addq	%rdx, %rcx
000000010000874d	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008754	movzbl	(%rcx), %edx
0000000100008757	testl	%edx, %edx
0000000100008759	je	0x10000877c
000000010000875b	cmpl	$0x1, %edx
000000010000875e	jne	0x100008770
0000000100008760	movq	%rdi, %rbx
0000000100008763	movq	%rax, %rdi
0000000100008766	callq	_fwp_rc_free_obj
000000010000876b	movq	%rbx, %rdi
000000010000876e	jmp	0x10000877c
0000000100008770	cmpl	$0xff, %edx
0000000100008776	je	0x10000878f
0000000100008778	decb	%dl
000000010000877a	movb	%dl, (%rcx)
000000010000877c	movq	0x8(%rdi), %rax
0000000100008780	movq	0x8(%rdi), %rdi
0000000100008784	addq	$0x8, %rsp
0000000100008788	popq	%rbx
0000000100008789	popq	%rbp
000000010000878a	jmp	_fwp_closure_drop
000000010000878f	movq	%rdi, %rbx
0000000100008792	movq	%rcx, %rdi
0000000100008795	callq	_fwp_rc_wide_drop
000000010000879a	jmp	0x10000876b
000000010000879c	nopl	(%rax)
_f4:
00000001000087a0	pushq	%rbp
00000001000087a1	movq	%rsp, %rbp
00000001000087a4	pushq	%r15
00000001000087a6	pushq	%r14
00000001000087a8	pushq	%r13
00000001000087aa	pushq	%r12
00000001000087ac	pushq	%rbx
00000001000087ad	pushq	%rax
00000001000087ae	movl	$0x10088, %eax                  ## imm = 0x10088
00000001000087b3	callq	0x100009728                     ## symbol stub for: ____chkstk_darwin
00000001000087b8	subq	%rax, %rsp
00000001000087bb	popq	%rax
00000001000087bc	movq	%rdi, %rbx
00000001000087bf	movq	0x286a(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000087c6	movq	(%rax), %rax
00000001000087c9	movq	%rax, -0x30(%rbp)
00000001000087cd	callq	_fwp_file_dup
00000001000087d2	movq	%rbx, -0x100b0(%rbp)
00000001000087d9	leaq	_fwp_file_drop(%rip), %rax
00000001000087e0	movq	%rax, -0x100a8(%rbp)
00000001000087e7	movq	_fwp_cleanups(%rip), %rax
00000001000087ee	movq	%rax, -0x100a0(%rbp)
00000001000087f5	leaq	_fwp_value_release(%rip), %r12
00000001000087fc	movq	%r12, -0x10098(%rbp)
0000000100008803	leaq	-0x100b0(%rbp), %rax
000000010000880a	movq	%rax, -0x10090(%rbp)
0000000100008811	xorps	%xmm0, %xmm0
0000000100008814	movaps	%xmm0, -0x10060(%rbp)
000000010000881b	movq	$0x0, -0x10050(%rbp)
0000000100008826	leaq	-0x100a0(%rbp), %rax
000000010000882d	movq	%rax, -0x10088(%rbp)
0000000100008834	leaq	_fwp_file_buffer_cleanup(%rip), %rax
000000010000883b	movq	%rax, -0x10080(%rbp)
0000000100008842	leaq	-0x10060(%rbp), %rax
0000000100008849	movq	%rax, -0x10078(%rbp)
0000000100008850	leaq	-0x10088(%rbp), %r13
0000000100008857	movq	%r13, _fwp_cleanups(%rip)
000000010000885e	movq	(%rbx), %rcx
0000000100008861	testq	%rcx, %rcx
0000000100008864	je	0x100008a5b
000000010000886a	leaq	-0x10040(%rbp), %rdi
0000000100008871	movl	$0x1, %esi
0000000100008876	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000887b	callq	0x1000097b8                     ## symbol stub for: _fread
0000000100008880	testq	%rax, %rax
0000000100008883	je	0x1000088c8
0000000100008885	leaq	-0x10060(%rbp), %r14
000000010000888c	leaq	-0x10040(%rbp), %r15
0000000100008893	nopw	%cs:(%rax,%rax)
00000001000088a0	movq	%r14, %rdi
00000001000088a3	movq	%r15, %rsi
00000001000088a6	movq	%rax, %rdx
00000001000088a9	callq	_buf_put
00000001000088ae	movq	(%rbx), %rcx
00000001000088b1	movl	$0x1, %esi
00000001000088b6	movl	$0x10000, %edx                  ## imm = 0x10000
00000001000088bb	movq	%r15, %rdi
00000001000088be	callq	0x1000097b8                     ## symbol stub for: _fread
00000001000088c3	testq	%rax, %rax
00000001000088c6	jne	0x1000088a0
00000001000088c8	movq	(%rbx), %rdi
00000001000088cb	callq	0x10000979a                     ## symbol stub for: _ferror
00000001000088d0	testl	%eax, %eax
00000001000088d2	jne	0x100008d46
00000001000088d8	movq	-0x10060(%rbp), %rax
00000001000088df	movq	-0x10058(%rbp), %rsi
00000001000088e6	testq	%rax, %rax
00000001000088e9	leaq	0x14ac(%rip), %rdi              ## literal pool for: ""
00000001000088f0	cmovneq	%rax, %rdi
00000001000088f4	testq	%rsi, %rsi
00000001000088f7	je	0x100008a62
00000001000088fd	xorl	%ecx, %ecx
00000001000088ff	jmp	0x10000891c
0000000100008901	nopw	%cs:(%rax,%rax)
0000000100008910	incq	%rcx
0000000100008913	cmpq	%rsi, %rcx
0000000100008916	jae	0x100008a64
000000010000891c	movzbl	(%rdi,%rcx), %r10d
0000000100008921	testb	%r10b, %r10b
0000000100008924	jns	0x100008910
0000000100008926	leal	0x3e(%r10), %edx
000000010000892a	cmpb	$0x1e, %dl
000000010000892d	jae	0x100008942
000000010000892f	movl	$0x80, %edx
0000000100008934	movl	$0x1, %r9d
000000010000893a	movl	$0x1f, %r8d
0000000100008940	jmp	0x10000897e
0000000100008942	movl	%r10d, %edx
0000000100008945	andb	$-0x10, %dl
0000000100008948	cmpb	$-0x20, %dl
000000010000894b	jne	0x100008960
000000010000894d	movl	$0x800, %edx                    ## imm = 0x800
0000000100008952	movl	$0x2, %r9d
0000000100008958	movl	$0xf, %r8d
000000010000895e	jmp	0x10000897e
0000000100008960	leal	0x10(%r10), %edx
0000000100008964	cmpb	$0x4, %dl
0000000100008967	ja	0x100008ca8
000000010000896d	movl	$0x10000, %edx                  ## imm = 0x10000
0000000100008972	movl	$0x3, %r9d
0000000100008978	movl	$0x7, %r8d
000000010000897e	movl	%r9d, %r9d
0000000100008981	leaq	(%rcx,%r9), %r11
0000000100008985	cmpq	%rsi, %r11
0000000100008988	jae	0x100008ca8
000000010000898e	movzbl	0x1(%rdi,%rcx), %r11d
0000000100008994	movl	%r11d, %r14d
0000000100008997	andl	$-0x40, %r14d
000000010000899b	cmpl	$0x80, %r14d
00000001000089a2	jne	0x100008ca8
00000001000089a8	andl	%r10d, %r8d
00000001000089ab	leal	0x1(%r9), %r14d
00000001000089af	movl	%r8d, %r10d
00000001000089b2	shll	$0x6, %r10d
00000001000089b6	andl	$0x3f, %r11d
00000001000089ba	orl	%r10d, %r11d
00000001000089bd	cmpl	$0x2, %r14d
00000001000089c1	jne	0x1000089c8
00000001000089c3	movl	%r11d, %r14d
00000001000089c6	jmp	0x100008a26
00000001000089c8	movzbl	0x2(%rdi,%rcx), %r8d
00000001000089ce	movl	%r8d, %r10d
00000001000089d1	andl	$-0x40, %r10d
00000001000089d5	cmpl	$0x80, %r10d
00000001000089dc	jne	0x100008ca8
00000001000089e2	movl	%r11d, %r10d
00000001000089e5	shll	$0x6, %r10d
00000001000089e9	andl	$0x3f, %r8d
00000001000089ed	orl	%r10d, %r8d
00000001000089f0	cmpl	$0x3, %r14d
00000001000089f4	jne	0x1000089fe
00000001000089f6	movl	%r8d, %r14d
00000001000089f9	movl	%r11d, %r8d
00000001000089fc	jmp	0x100008a26
00000001000089fe	movzbl	0x3(%rdi,%rcx), %r14d
0000000100008a04	movl	%r14d, %r10d
0000000100008a07	andl	$-0x40, %r10d
0000000100008a0b	cmpl	$0x80, %r10d
0000000100008a12	jne	0x100008ca8
0000000100008a18	movl	%r8d, %r10d
0000000100008a1b	shll	$0x6, %r10d
0000000100008a1f	andl	$0x3f, %r14d
0000000100008a23	orl	%r10d, %r14d
0000000100008a26	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
0000000100008a2d	cmpl	$0x360, %r8d                    ## imm = 0x360
0000000100008a34	je	0x100008ca8
0000000100008a3a	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
0000000100008a41	ja	0x100008ca8
0000000100008a47	cmpl	%edx, %r14d
0000000100008a4a	jb	0x100008ca8
0000000100008a50	addq	%r9, %rcx
0000000100008a53	incq	%rcx
0000000100008a56	jmp	0x100008913
0000000100008a5b	leaq	0x133a(%rip), %rdi              ## literal pool for: ""
0000000100008a62	xorl	%esi, %esi
0000000100008a64	callq	_fwp_str_new
0000000100008a69	movq	%rax, %r14
0000000100008a6c	movq	-0x10060(%rbp), %rdi
0000000100008a73	callq	0x1000097be                     ## symbol stub for: _free
0000000100008a78	movq	%r14, %rax
0000000100008a7b	subq	0x45b6(%rip), %rax
0000000100008a82	movq	0x45d7(%rip), %rcx
0000000100008a89	shlq	$0x10, %rcx
0000000100008a8d	cmpq	%rcx, %rax
0000000100008a90	jae	0x100008b02
0000000100008a92	movq	0x45e7(%rip), %rcx
0000000100008a99	movq	%rax, %rdx
0000000100008a9c	shrq	$0x10, %rdx
0000000100008aa0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008aa7	leaq	(%rcx,%rdx), %r15
0000000100008aab	movzbl	(%rcx,%rdx), %ecx
0000000100008aaf	cmpb	$0x2, %cl
0000000100008ab2	setne	%dl
0000000100008ab5	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008abb	setne	%sil
0000000100008abf	orb	%dl, %sil
0000000100008ac2	jne	0x100008ad7
0000000100008ac4	addq	$0x228, %r15                    ## imm = 0x228
0000000100008acb	cmpb	$-0x1, (%r15)
0000000100008acf	je	0x100008af8
0000000100008ad1	movb	$0x1, (%r15)
0000000100008ad5	jmp	0x100008b02
0000000100008ad7	cmpb	$0x1, %cl
0000000100008ada	jne	0x100008b02
0000000100008adc	movl	0x20(%r15), %ecx
0000000100008ae0	imulq	%rcx, %rax
0000000100008ae4	shrq	$0x20, %rax
0000000100008ae8	addq	%rax, %r15
0000000100008aeb	addq	$0x228, %r15                    ## imm = 0x228
0000000100008af2	cmpb	$-0x1, (%r15)
0000000100008af6	jne	0x100008ad1
0000000100008af8	movq	%r15, %rdi
0000000100008afb	callq	_fwp_rc_forget_slot
0000000100008b00	jmp	0x100008ad1
0000000100008b02	movq	$0x0, -0x10060(%rbp)
0000000100008b0d	movq	%r14, -0x10070(%rbp)
0000000100008b14	leaq	_fwp_file_text_drop(%rip), %rax
0000000100008b1b	movq	%rax, -0x10068(%rbp)
0000000100008b22	movq	_fwp_cleanups(%rip), %rax
0000000100008b29	movq	%rax, -0x10040(%rbp)
0000000100008b30	movq	%r12, -0x10038(%rbp)
0000000100008b37	leaq	-0x10070(%rbp), %rax
0000000100008b3e	movq	%rax, -0x10030(%rbp)
0000000100008b45	leaq	-0x10040(%rbp), %r15
0000000100008b4c	movq	%r15, _fwp_cleanups(%rip)
0000000100008b53	movq	%r14, -0x40(%rbp)
0000000100008b57	movq	%rbx, -0x38(%rbp)
0000000100008b5b	movl	$0x18, %edi
0000000100008b60	callq	_fwp_alloc_init
0000000100008b65	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100008b6f	movq	%rcx, (%rax)
0000000100008b72	movq	%r14, 0x8(%rax)
0000000100008b76	movq	%rbx, 0x10(%rax)
0000000100008b7a	leaq	-0x40(%rbp), %rcx
0000000100008b7e	movq	%rax, %rcx
0000000100008b81	subq	0x44b0(%rip), %rcx
0000000100008b88	movq	0x44d1(%rip), %rdx
0000000100008b8f	shlq	$0x10, %rdx
0000000100008b93	cmpq	%rdx, %rcx
0000000100008b96	jae	0x100008c10
0000000100008b98	movq	0x44e1(%rip), %rdx
0000000100008b9f	movq	%rcx, %rsi
0000000100008ba2	shrq	$0x10, %rsi
0000000100008ba6	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100008bad	leaq	(%rdx,%rsi), %r14
0000000100008bb1	movzbl	(%rdx,%rsi), %edx
0000000100008bb5	cmpb	$0x2, %dl
0000000100008bb8	setne	%sil
0000000100008bbc	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008bc3	setne	%dil
0000000100008bc7	orb	%sil, %dil
0000000100008bca	jne	0x100008bdf
0000000100008bcc	addq	$0x228, %r14                    ## imm = 0x228
0000000100008bd3	cmpb	$-0x1, (%r14)
0000000100008bd7	je	0x100008c00
0000000100008bd9	movb	$0x1, (%r14)
0000000100008bdd	jmp	0x100008c10
0000000100008bdf	cmpb	$0x1, %dl
0000000100008be2	jne	0x100008c10
0000000100008be4	movl	0x20(%r14), %edx
0000000100008be8	imulq	%rdx, %rcx
0000000100008bec	shrq	$0x20, %rcx
0000000100008bf0	addq	%rcx, %r14
0000000100008bf3	addq	$0x228, %r14                    ## imm = 0x228
0000000100008bfa	cmpb	$-0x1, (%r14)
0000000100008bfe	jne	0x100008bd9
0000000100008c00	movq	%r14, %rdi
0000000100008c03	movq	%rax, %r12
0000000100008c06	callq	_fwp_rc_forget_slot
0000000100008c0b	movq	%r12, %rax
0000000100008c0e	jmp	0x100008bd9
0000000100008c10	cmpq	$0x0, -0x10068(%rbp)
0000000100008c18	movq	_fwp_cleanups(%rip), %rcx
0000000100008c1f	je	0x100008c38
0000000100008c21	cmpq	%r15, %rcx
0000000100008c24	jne	0x100008de3
0000000100008c2a	movq	-0x10040(%rbp), %rcx
0000000100008c31	movq	%rcx, _fwp_cleanups(%rip)
0000000100008c38	movq	$0x0, -0x10070(%rbp)
0000000100008c43	cmpq	%r13, %rcx
0000000100008c46	jne	0x100008de3
0000000100008c4c	movq	-0x10088(%rbp), %rcx
0000000100008c53	movq	%rcx, _fwp_cleanups(%rip)
0000000100008c5a	cmpq	$0x0, -0x100a8(%rbp)
0000000100008c62	je	0x100008c82
0000000100008c64	leaq	-0x100a0(%rbp), %rdx
0000000100008c6b	cmpq	%rdx, %rcx
0000000100008c6e	jne	0x100008de3
0000000100008c74	movq	-0x100a0(%rbp), %rcx
0000000100008c7b	movq	%rcx, _fwp_cleanups(%rip)
0000000100008c82	movq	0x23a7(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100008c89	movq	(%rcx), %rcx
0000000100008c8c	cmpq	-0x30(%rbp), %rcx
0000000100008c90	jne	0x100008d41
0000000100008c96	addq	$0x10088, %rsp                  ## imm = 0x10088
0000000100008c9d	popq	%rbx
0000000100008c9e	popq	%r12
0000000100008ca0	popq	%r13
0000000100008ca2	popq	%r14
0000000100008ca4	popq	%r15
0000000100008ca6	popq	%rbp
0000000100008ca7	retq
0000000100008ca8	cmpq	%r13, _fwp_cleanups(%rip)
0000000100008caf	jne	0x100008de3
0000000100008cb5	movq	-0x10088(%rbp), %rcx
0000000100008cbc	movq	%rcx, _fwp_cleanups(%rip)
0000000100008cc3	movq	%rax, %rdi
0000000100008cc6	callq	0x1000097be                     ## symbol stub for: _free
0000000100008ccb	movq	$0x0, -0x10060(%rbp)
0000000100008cd6	leaq	0x10ba(%rip), %rdi              ## literal pool for: "read"
0000000100008cdd	movl	$0x4, %esi
0000000100008ce2	callq	_fwp_str_new
0000000100008ce7	movq	%rax, %rbx
0000000100008cea	movq	%rax, -0x10040(%rbp)
0000000100008cf1	leaq	0x10a5(%rip), %rdi              ## literal pool for: "stream did not contain valid UTF-8"
0000000100008cf8	movl	$0x22, %esi
0000000100008cfd	callq	_fwp_str_new
0000000100008d02	movq	%rax, %r14
0000000100008d05	movq	%rax, -0x10038(%rbp)
0000000100008d0c	movl	$0x18, %edi
0000000100008d11	callq	_fwp_alloc_init
0000000100008d16	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100008d20	movq	%rcx, (%rax)
0000000100008d23	movq	%rbx, 0x8(%rax)
0000000100008d27	movq	%r14, 0x10(%rax)
0000000100008d2b	leaq	-0x10040(%rbp), %rcx
0000000100008d32	leaq	_d0(%rip), %rsi
0000000100008d39	movq	%rax, %rdi
0000000100008d3c	callq	_fwp_fail
0000000100008d41	callq	0x100009746                     ## symbol stub for: ___stack_chk_fail
0000000100008d46	callq	0x10000973a                     ## symbol stub for: ___error
0000000100008d4b	cmpq	%r13, _fwp_cleanups(%rip)
0000000100008d52	jne	0x100008de3
0000000100008d58	movl	(%rax), %ebx
0000000100008d5a	movq	-0x10088(%rbp), %rax
0000000100008d61	movq	%rax, _fwp_cleanups(%rip)
0000000100008d68	movq	-0x10060(%rbp), %rdi
0000000100008d6f	callq	0x1000097be                     ## symbol stub for: _free
0000000100008d74	movq	$0x0, -0x10060(%rbp)
0000000100008d7f	movl	%ebx, %edi
0000000100008d81	callq	0x10000985a                     ## symbol stub for: _strerror
0000000100008d86	movq	%rax, %rbx
0000000100008d89	leaq	0x1007(%rip), %rdi              ## literal pool for: "read"
0000000100008d90	movl	$0x4, %esi
0000000100008d95	callq	_fwp_str_new
0000000100008d9a	movq	%rax, %r14
0000000100008d9d	movq	%rax, -0x40(%rbp)
0000000100008da1	movq	%rbx, %rdi
0000000100008da4	callq	0x100009860                     ## symbol stub for: _strlen
0000000100008da9	movq	%rbx, %rdi
0000000100008dac	movq	%rax, %rsi
0000000100008daf	callq	_fwp_str_new
0000000100008db4	movq	%rax, %rbx
0000000100008db7	movq	%rax, -0x38(%rbp)
0000000100008dbb	movl	$0x18, %edi
0000000100008dc0	callq	_fwp_alloc_init
0000000100008dc5	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100008dcf	movq	%rcx, (%rax)
0000000100008dd2	movq	%r14, 0x8(%rax)
0000000100008dd6	movq	%rbx, 0x10(%rax)
0000000100008dda	leaq	-0x40(%rbp), %rcx
0000000100008dde	jmp	0x100008d32
0000000100008de3	callq	0x100009770                     ## symbol stub for: _abort
0000000100008de8	nopl	(%rax,%rax)
_fwp_file_dup:
0000000100008df0	pushq	%rbp
0000000100008df1	movq	%rsp, %rbp
0000000100008df4	testq	%rdi, %rdi
0000000100008df7	je	0x100008e0f
0000000100008df9	movq	0x8(%rdi), %rax
0000000100008dfd	cmpq	$-0x1, %rax
0000000100008e01	je	0x100008e11
0000000100008e03	testq	%rax, %rax
0000000100008e06	je	0x100008e30
0000000100008e08	incq	%rax
0000000100008e0b	movq	%rax, 0x8(%rdi)
0000000100008e0f	popq	%rbp
0000000100008e10	retq
0000000100008e11	callq	_fwp_flush
0000000100008e16	movq	0x221b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008e1d	movq	(%rax), %rdi
0000000100008e20	leaq	0xc7d(%rip), %rsi               ## literal pool for: "fwp: trap: %s\n"
0000000100008e27	leaq	0xe34(%rip), %rdx               ## literal pool for: "reference count overflow"
0000000100008e2e	jmp	0x100008e4d
0000000100008e30	callq	_fwp_flush
0000000100008e35	movq	0x21fc(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008e3c	movq	(%rax), %rdi
0000000100008e3f	leaq	0xc5e(%rip), %rsi               ## literal pool for: "fwp: trap: %s\n"
0000000100008e46	leaq	0xf27(%rip), %rdx               ## literal pool for: "internal: duplicate discarded file"
0000000100008e4d	xorl	%eax, %eax
0000000100008e4f	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100008e54	movl	$0x65, %edi
0000000100008e59	callq	0x10000978e                     ## symbol stub for: _exit
0000000100008e5e	nop
_fwp_file_buffer_cleanup:
0000000100008e60	pushq	%rbp
0000000100008e61	movq	%rsp, %rbp
0000000100008e64	pushq	%rbx
0000000100008e65	pushq	%rax
0000000100008e66	movq	%rdi, %rbx
0000000100008e69	movq	(%rdi), %rdi
0000000100008e6c	callq	0x1000097be                     ## symbol stub for: _free
0000000100008e71	movq	$0x0, (%rbx)
0000000100008e78	addq	$0x8, %rsp
0000000100008e7c	popq	%rbx
0000000100008e7d	popq	%rbp
0000000100008e7e	retq
0000000100008e7f	nop
_fwp_file_text_drop:
0000000100008e80	pushq	%rbp
0000000100008e81	movq	%rsp, %rbp
0000000100008e84	popq	%rbp
0000000100008e85	jmp	_fwp_rc_free_obj
0000000100008e8a	nopw	(%rax,%rax)
_fwp_owned_entry4:
0000000100008e90	pushq	%rbp
0000000100008e91	movq	%rsp, %rbp
0000000100008e94	pushq	%r15
0000000100008e96	pushq	%r14
0000000100008e98	pushq	%rbx
0000000100008e99	subq	$0x18, %rsp
0000000100008e9d	movq	%rdi, %rbx
0000000100008ea0	movq	_fwp_cleanups(%rip), %rax
0000000100008ea7	movq	%rax, -0x30(%rbp)
0000000100008eab	leaq	_fwp_entry_release4(%rip), %rax
0000000100008eb2	movq	%rax, -0x28(%rbp)
0000000100008eb6	movq	%rdi, -0x20(%rbp)
0000000100008eba	leaq	-0x30(%rbp), %r15
0000000100008ebe	movq	%r15, _fwp_cleanups(%rip)
0000000100008ec5	movq	(%rdi), %rdi
0000000100008ec8	callq	_f4
0000000100008ecd	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008ed4	jne	0x100008efd
0000000100008ed6	movq	%rax, %r14
0000000100008ed9	movq	-0x30(%rbp), %rax
0000000100008edd	movq	%rax, _fwp_cleanups(%rip)
0000000100008ee4	movq	(%rbx), %rax
0000000100008ee7	movq	(%rbx), %rdi
0000000100008eea	callq	_fwp_file_drop
0000000100008eef	movq	%r14, %rax
0000000100008ef2	addq	$0x18, %rsp
0000000100008ef6	popq	%rbx
0000000100008ef7	popq	%r14
0000000100008ef9	popq	%r15
0000000100008efb	popq	%rbp
0000000100008efc	retq
0000000100008efd	callq	0x100009770                     ## symbol stub for: _abort
0000000100008f02	nopw	%cs:(%rax,%rax)
_fwp_caps4:
0000000100008f10	movl	0x4(%rdi), %eax
0000000100008f13	testl	%esi, %esi
0000000100008f15	je	0x100008f24
0000000100008f17	testl	%eax, %eax
0000000100008f19	je	0x100008f4f
0000000100008f1b	movq	0x8(%rdi), %rdi
0000000100008f1f	jmp	_fwp_file_dup
0000000100008f24	testl	%eax, %eax
0000000100008f26	je	_fwp_rc_free_obj
0000000100008f2c	pushq	%rbp
0000000100008f2d	movq	%rsp, %rbp
0000000100008f30	pushq	%rbx
0000000100008f31	pushq	%rax
0000000100008f32	movq	0x8(%rdi), %rax
0000000100008f36	movq	%rdi, %rbx
0000000100008f39	movq	%rax, %rdi
0000000100008f3c	callq	_fwp_file_drop
0000000100008f41	movq	%rbx, %rdi
0000000100008f44	addq	$0x8, %rsp
0000000100008f48	popq	%rbx
0000000100008f49	popq	%rbp
0000000100008f4a	jmp	_fwp_rc_free_obj
0000000100008f4f	retq
_fwp_args4:
0000000100008f50	pushq	%rbp
0000000100008f51	movq	%rsp, %rbp
0000000100008f54	testl	%esi, %esi
0000000100008f56	setne	%al
0000000100008f59	testl	%edx, %edx
0000000100008f5b	sete	%cl
0000000100008f5e	orb	%al, %cl
0000000100008f60	je	0x100008f64
0000000100008f62	popq	%rbp
0000000100008f63	retq
0000000100008f64	movq	(%rdi), %rdi
0000000100008f67	popq	%rbp
0000000100008f68	jmp	_fwp_file_dup
0000000100008f6d	nopl	(%rax)
_fwp_arg_drop4:
0000000100008f70	pushq	%rbp
0000000100008f71	movq	%rsp, %rbp
0000000100008f74	testl	%esi, %esi
0000000100008f76	setne	%al
0000000100008f79	testl	%edx, %edx
0000000100008f7b	sete	%cl
0000000100008f7e	orb	%al, %cl
0000000100008f80	je	0x100008f84
0000000100008f82	popq	%rbp
0000000100008f83	retq
0000000100008f84	movq	(%rdi), %rdi
0000000100008f87	popq	%rbp
0000000100008f88	jmp	_fwp_file_drop
0000000100008f8d	nopl	(%rax)
_fwp_entry_release4:
0000000100008f90	pushq	%rbp
0000000100008f91	movq	%rsp, %rbp
0000000100008f94	movq	(%rdi), %rax
0000000100008f97	movq	(%rdi), %rdi
0000000100008f9a	popq	%rbp
0000000100008f9b	jmp	_fwp_file_drop
_f8:
0000000100008fa0	pushq	%rbp
0000000100008fa1	movq	%rsp, %rbp
0000000100008fa4	pushq	%r14
0000000100008fa6	pushq	%rbx
0000000100008fa7	subq	$0x20, %rsp
0000000100008fab	movq	%rdi, %rsi
0000000100008fae	xorps	%xmm0, %xmm0
0000000100008fb1	movaps	%xmm0, -0x30(%rbp)
0000000100008fb5	movq	$0x0, -0x20(%rbp)
0000000100008fbd	leaq	_d2(%rip), %rdx
0000000100008fc4	leaq	-0x30(%rbp), %rdi
0000000100008fc8	movl	$0x1, %ecx
0000000100008fcd	callq	_fwp_write
0000000100008fd2	movq	-0x30(%rbp), %rax
0000000100008fd6	movq	-0x28(%rbp), %rsi
0000000100008fda	testq	%rax, %rax
0000000100008fdd	leaq	0xdb8(%rip), %rdi               ## literal pool for: ""
0000000100008fe4	cmovneq	%rax, %rdi
0000000100008fe8	callq	_fwp_str_new
0000000100008fed	movq	%rax, %rbx
0000000100008ff0	movq	-0x30(%rbp), %rdi
0000000100008ff4	callq	0x1000097be                     ## symbol stub for: _free
0000000100008ff9	movq	%rbx, %rax
0000000100008ffc	movq	%rbx, %rcx
0000000100008fff	subq	0x4032(%rip), %rcx
0000000100009006	movq	0x4053(%rip), %rdx
000000010000900d	shlq	$0x10, %rdx
0000000100009011	cmpq	%rdx, %rcx
0000000100009014	jae	0x10000908a
0000000100009016	movq	0x4063(%rip), %rdx
000000010000901d	movq	%rcx, %rsi
0000000100009020	shrq	$0x10, %rsi
0000000100009024	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
000000010000902b	leaq	(%rdx,%rsi), %rbx
000000010000902f	movzbl	(%rdx,%rsi), %edx
0000000100009033	cmpb	$0x2, %dl
0000000100009036	setne	%sil
000000010000903a	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009041	setne	%dil
0000000100009045	orb	%sil, %dil
0000000100009048	jne	0x10000905b
000000010000904a	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009051	cmpb	$-0x1, (%rbx)
0000000100009054	je	0x10000907a
0000000100009056	movb	$0x1, (%rbx)
0000000100009059	jmp	0x10000908a
000000010000905b	cmpb	$0x1, %dl
000000010000905e	jne	0x10000908a
0000000100009060	movl	0x20(%rbx), %edx
0000000100009063	imulq	%rdx, %rcx
0000000100009067	shrq	$0x20, %rcx
000000010000906b	addq	%rcx, %rbx
000000010000906e	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009075	cmpb	$-0x1, (%rbx)
0000000100009078	jne	0x100009056
000000010000907a	movq	%rbx, %rdi
000000010000907d	movq	%rax, %r14
0000000100009080	callq	_fwp_rc_forget_slot
0000000100009085	movq	%r14, %rax
0000000100009088	jmp	0x100009056
000000010000908a	addq	$0x20, %rsp
000000010000908e	popq	%rbx
000000010000908f	popq	%r14
0000000100009091	popq	%rbp
0000000100009092	retq
0000000100009093	nopw	%cs:(%rax,%rax)
_fwp_gc_report:
00000001000090a0	pushq	%rbp
00000001000090a1	movq	%rsp, %rbp
00000001000090a4	pushq	%r15
00000001000090a6	pushq	%r14
00000001000090a8	pushq	%r13
00000001000090aa	pushq	%r12
00000001000090ac	pushq	%rbx
00000001000090ad	subq	$0xb8, %rsp
00000001000090b4	movq	0x415d(%rip), %rax
00000001000090bb	movq	_fwp_gc(%rip), %rcx
00000001000090c2	subq	%rcx, %rax
00000001000090c5	cvtsi2sd	%rax, %xmm0
00000001000090ca	addsd	0x411e(%rip), %xmm0
00000001000090d2	movsd	%xmm0, -0x50(%rbp)
00000001000090d7	movsd	%xmm0, 0x4111(%rip)
00000001000090df	movq	%rcx, 0x4132(%rip)
00000001000090e6	movq	0x1f4b(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000090ed	movq	(%rax), %r15
00000001000090f0	movq	0x40e9(%rip), %rax
00000001000090f7	movq	%rax, -0x30(%rbp)
00000001000090fb	movq	0x3f1e(%rip), %r14
0000000100009102	movsd	0x4106(%rip), %xmm0
000000010000910a	movsd	%xmm0, -0x38(%rbp)
000000010000910f	movq	0x3f3a(%rip), %r12
0000000100009116	movq	0x40b3(%rip), %r13
000000010000911d	movq	0x40b4(%rip), %rbx
0000000100009124	movsd	0x40cc(%rip), %xmm0
000000010000912c	movsd	%xmm0, -0x48(%rbp)
0000000100009131	movsd	0x40c7(%rip), %xmm0
0000000100009139	movsd	%xmm0, -0x40(%rbp)
000000010000913e	leaq	-0xe0(%rbp), %rsi
0000000100009145	xorl	%edi, %edi
0000000100009147	callq	0x1000097d6                     ## symbol stub for: _getrusage
000000010000914c	movq	$-0x1, %r8
0000000100009153	testl	%eax, %eax
0000000100009155	jne	0x100009170
0000000100009157	movq	-0xc0(%rbp), %rax
000000010000915e	leaq	0x3ff(%rax), %r8
0000000100009165	testq	%rax, %rax
0000000100009168	cmovnsq	%rax, %r8
000000010000916c	sarq	$0xa, %r8
0000000100009170	movq	%rbx, %xmm0
0000000100009175	movq	0x7e3(%rip), %xmm1
000000010000917d	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100009181	movapd	0x7e7(%rip), %xmm2
0000000100009189	subpd	%xmm2, %xmm0
000000010000918d	movapd	%xmm0, %xmm4
0000000100009191	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100009195	addsd	%xmm0, %xmm4
0000000100009199	movsd	0x7ef(%rip), %xmm6
00000001000091a1	mulsd	%xmm6, %xmm4
00000001000091a5	movq	%r13, %xmm5
00000001000091aa	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
00000001000091ae	subpd	%xmm2, %xmm5
00000001000091b2	movapd	%xmm5, %xmm3
00000001000091b6	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
00000001000091ba	addsd	%xmm5, %xmm3
00000001000091be	mulsd	%xmm6, %xmm3
00000001000091c2	movq	%r12, %xmm5
00000001000091c7	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
00000001000091cb	subpd	%xmm2, %xmm5
00000001000091cf	movapd	%xmm5, %xmm2
00000001000091d3	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
00000001000091d7	addsd	%xmm5, %xmm2
00000001000091db	mulsd	%xmm6, %xmm2
00000001000091df	movsd	-0x50(%rbp), %xmm0
00000001000091e4	movsd	-0x38(%rbp), %xmm1
00000001000091e9	addsd	%xmm1, %xmm0
00000001000091ed	mulsd	%xmm6, %xmm1
00000001000091f1	mulsd	%xmm6, %xmm0
00000001000091f5	cmpl	$0x0, 0x3e00(%rip)
00000001000091fc	leaq	0xcd0(%rip), %rax               ## literal pool for: " (collection off)"
0000000100009203	leaq	0xb92(%rip), %r9                ## literal pool for: ""
000000010000920a	cmoveq	%rax, %r9
000000010000920e	leaq	0xc0f(%rip), %rsi               ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100009215	movq	%r15, %rdi
0000000100009218	movq	-0x30(%rbp), %rdx
000000010000921c	movq	%r14, %rcx
000000010000921f	movsd	-0x48(%rbp), %xmm5
0000000100009224	movsd	-0x40(%rbp), %xmm6
0000000100009229	movb	$0x7, %al
000000010000922b	callq	0x1000097ac                     ## symbol stub for: _fprintf
0000000100009230	addq	$0xb8, %rsp
0000000100009237	popq	%rbx
0000000100009238	popq	%r12
000000010000923a	popq	%r13
000000010000923c	popq	%r14
000000010000923e	popq	%r15
0000000100009240	popq	%rbp
0000000100009241	retq
0000000100009242	nopw	%cs:(%rax,%rax)
_fwp_segv:
0000000100009250	movq	_fwp_main_stack_top(%rip), %rax
0000000100009257	testq	%rax, %rax
000000010000925a	je	0x100009284
000000010000925c	movq	0x18(%rsi), %rcx
0000000100009260	subq	_fwp_main_stack_size(%rip), %rax
0000000100009267	leaq	-0x100000(%rax), %rdx
000000010000926e	addq	$0x100000, %rax                 ## imm = 0x100000
0000000100009274	cmpq	%rcx, %rdx
0000000100009277	setbe	%dl
000000010000927a	cmpq	%rcx, %rax
000000010000927d	seta	%al
0000000100009280	testb	%al, %dl
0000000100009282	jne	0x10000928b
0000000100009284	xorl	%esi, %esi
0000000100009286	jmp	0x10000983c                     ## symbol stub for: _signal
000000010000928b	pushq	%rbp
000000010000928c	movq	%rsp, %rbp
000000010000928f	callq	_fwp_flush
0000000100009294	leaq	_fwp_segv.msg(%rip), %rsi
000000010000929b	movl	$0x1a, %edx
00000001000092a0	movl	$0x2, %edi
00000001000092a5	callq	0x100009884                     ## symbol stub for: _write
00000001000092aa	movl	$0x65, %edi
00000001000092af	callq	0x10000976a                     ## symbol stub for: __exit
00000001000092b4	nopw	%cs:(%rax,%rax)
_fwp_owner_release0:
00000001000092c0	pushq	%rbp
00000001000092c1	movq	%rsp, %rbp
00000001000092c4	movq	(%rdi), %rdi
00000001000092c7	popq	%rbp
00000001000092c8	jmp	_fwp_closure_drop
00000001000092cd	nopl	(%rax)
_fwp_owner_release1:
00000001000092d0	pushq	%rbp
00000001000092d1	movq	%rsp, %rbp
00000001000092d4	movq	(%rdi), %rdi
00000001000092d7	popq	%rbp
00000001000092d8	jmp	_fwp_drop1
00000001000092dd	nopl	(%rax)
_fwp_drop1:
00000001000092e0	pushq	%rbp
00000001000092e1	movq	%rsp, %rbp
00000001000092e4	pushq	%rbx
00000001000092e5	pushq	%rax
00000001000092e6	movq	0x3d4b(%rip), %rcx
00000001000092ed	movq	%rdi, %r8
00000001000092f0	subq	%rcx, %r8
00000001000092f3	movq	0x3d66(%rip), %rsi
00000001000092fa	shlq	$0x10, %rsi
00000001000092fe	cmpq	%rsi, %r8
0000000100009301	jae	0x1000093d2
0000000100009307	movq	0x3d72(%rip), %rdx
000000010000930e	movq	%r8, %rax
0000000100009311	shrq	$0x10, %rax
0000000100009315	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
000000010000931c	leaq	(%rdx,%r9), %rax
0000000100009320	movzbl	(%rdx,%r9), %r9d
0000000100009325	cmpb	$0x2, %r9b
0000000100009329	setne	%r10b
000000010000932d	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100009334	setne	%r11b
0000000100009338	orb	%r10b, %r11b
000000010000933b	jne	0x100009345
000000010000933d	addq	$0x228, %rax                    ## imm = 0x228
0000000100009343	jmp	0x100009364
0000000100009345	cmpb	$0x1, %r9b
0000000100009349	jne	0x1000093d2
000000010000934f	movl	0x20(%rax), %r9d
0000000100009353	imulq	%r9, %r8
0000000100009357	shrq	$0x20, %r8
000000010000935b	addq	%r8, %rax
000000010000935e	addq	$0x228, %rax                    ## imm = 0x228
0000000100009364	movzbl	(%rax), %r8d
0000000100009368	testl	%r8d, %r8d
000000010000936b	je	0x1000093d2
000000010000936d	cmpl	$0x1, %r8d
0000000100009371	jne	0x1000093c3
0000000100009373	movl	(%rdi), %eax
0000000100009375	cmpl	$0x1, %eax
0000000100009378	je	0x1000093d9
000000010000937a	testl	%eax, %eax
000000010000937c	jne	0x1000093d2
000000010000937e	movq	0x8(%rdi), %rax
0000000100009382	movq	%rax, %r8
0000000100009385	subq	%rcx, %r8
0000000100009388	cmpq	%rsi, %r8
000000010000938b	jae	0x1000093eb
000000010000938d	movq	%r8, %rcx
0000000100009390	shrq	$0x10, %rcx
0000000100009394	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
000000010000939b	leaq	(%rdx,%rsi), %rcx
000000010000939f	movzbl	(%rdx,%rsi), %edx
00000001000093a3	cmpb	$0x2, %dl
00000001000093a6	setne	%sil
00000001000093aa	andq	$0xffff, %r8                    ## imm = 0xFFFF
00000001000093b1	setne	%r9b
00000001000093b5	orb	%sil, %r9b
00000001000093b8	jne	0x1000093f6
00000001000093ba	addq	$0x228, %rcx                    ## imm = 0x228
00000001000093c1	jmp	0x100009410
00000001000093c3	cmpl	$0xff, %r8d
00000001000093ca	je	0x100009437
00000001000093cc	decb	%r8b
00000001000093cf	movb	%r8b, (%rax)
00000001000093d2	addq	$0x8, %rsp
00000001000093d6	popq	%rbx
00000001000093d7	popq	%rbp
00000001000093d8	retq
00000001000093d9	movq	0x8(%rdi), %rax
00000001000093dd	movq	%rdi, %rbx
00000001000093e0	movq	%rax, %rdi
00000001000093e3	callq	_fwp_drop3
00000001000093e8	movq	%rbx, %rdi
00000001000093eb	addq	$0x8, %rsp
00000001000093ef	popq	%rbx
00000001000093f0	popq	%rbp
00000001000093f1	jmp	_fwp_rc_free_obj
00000001000093f6	cmpb	$0x1, %dl
00000001000093f9	jne	0x1000093eb
00000001000093fb	movl	0x20(%rcx), %edx
00000001000093fe	imulq	%rdx, %r8
0000000100009402	shrq	$0x20, %r8
0000000100009406	addq	%r8, %rcx
0000000100009409	addq	$0x228, %rcx                    ## imm = 0x228
0000000100009410	movzbl	(%rcx), %edx
0000000100009413	testl	%edx, %edx
0000000100009415	je	0x1000093eb
0000000100009417	cmpl	$0x1, %edx
000000010000941a	jne	0x100009429
000000010000941c	movq	%rdi, %rbx
000000010000941f	movq	%rax, %rdi
0000000100009422	callq	_fwp_rc_free_obj
0000000100009427	jmp	0x1000093e8
0000000100009429	cmpl	$0xff, %edx
000000010000942f	je	0x100009445
0000000100009431	decb	%dl
0000000100009433	movb	%dl, (%rcx)
0000000100009435	jmp	0x1000093eb
0000000100009437	movq	%rax, %rdi
000000010000943a	addq	$0x8, %rsp
000000010000943e	popq	%rbx
000000010000943f	popq	%rbp
0000000100009440	jmp	_fwp_rc_wide_drop
0000000100009445	movq	%rdi, %rbx
0000000100009448	movq	%rcx, %rdi
000000010000944b	callq	_fwp_rc_wide_drop
0000000100009450	jmp	0x1000093e8
0000000100009452	nopw	%cs:(%rax,%rax)
_fwp_owner_release2:
0000000100009460	pushq	%rbp
0000000100009461	movq	%rsp, %rbp
0000000100009464	movq	(%rdi), %rdi
0000000100009467	movq	%rdi, %rcx
000000010000946a	subq	0x3bc7(%rip), %rcx
0000000100009471	movq	0x3be8(%rip), %rax
0000000100009478	shlq	$0x10, %rax
000000010000947c	cmpq	%rax, %rcx
000000010000947f	jae	0x1000094f4
0000000100009481	movq	0x3bf8(%rip), %rdx
0000000100009488	movq	%rcx, %rax
000000010000948b	shrq	$0x10, %rax
000000010000948f	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009496	leaq	(%rdx,%rsi), %rax
000000010000949a	movzbl	(%rdx,%rsi), %edx
000000010000949e	cmpb	$0x2, %dl
00000001000094a1	setne	%sil
00000001000094a5	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000094ac	setne	%r8b
00000001000094b0	orb	%sil, %r8b
00000001000094b3	jne	0x1000094bd
00000001000094b5	addq	$0x228, %rax                    ## imm = 0x228
00000001000094bb	jmp	0x1000094d6
00000001000094bd	cmpb	$0x1, %dl
00000001000094c0	jne	0x1000094f4
00000001000094c2	movl	0x20(%rax), %edx
00000001000094c5	imulq	%rdx, %rcx
00000001000094c9	shrq	$0x20, %rcx
00000001000094cd	addq	%rcx, %rax
00000001000094d0	addq	$0x228, %rax                    ## imm = 0x228
00000001000094d6	movzbl	(%rax), %ecx
00000001000094d9	testl	%ecx, %ecx
00000001000094db	je	0x1000094f4
00000001000094dd	cmpl	$0x1, %ecx
00000001000094e0	jne	0x1000094e8
00000001000094e2	popq	%rbp
00000001000094e3	jmp	_fwp_rc_free_obj
00000001000094e8	cmpl	$0xff, %ecx
00000001000094ee	je	0x1000094f6
00000001000094f0	decb	%cl
00000001000094f2	movb	%cl, (%rax)
00000001000094f4	popq	%rbp
00000001000094f5	retq
00000001000094f6	movq	%rax, %rdi
00000001000094f9	popq	%rbp
00000001000094fa	jmp	_fwp_rc_wide_drop
00000001000094ff	nop
_fwp_owner_release3:
0000000100009500	pushq	%rbp
0000000100009501	movq	%rsp, %rbp
0000000100009504	movq	(%rdi), %rdi
0000000100009507	popq	%rbp
0000000100009508	jmp	_fwp_closure_drop
000000010000950d	nopl	(%rax)
_fwp_owner_release4:
0000000100009510	pushq	%rbp
0000000100009511	movq	%rsp, %rbp
0000000100009514	movq	(%rdi), %rdi
0000000100009517	popq	%rbp
0000000100009518	jmp	_fwp_drop1
000000010000951d	nopl	(%rax)
_fwp_owner_release5:
0000000100009520	pushq	%rbp
0000000100009521	movq	%rsp, %rbp
0000000100009524	movq	(%rdi), %rdi
0000000100009527	movq	%rdi, %rcx
000000010000952a	subq	0x3b07(%rip), %rcx
0000000100009531	movq	0x3b28(%rip), %rax
0000000100009538	shlq	$0x10, %rax
000000010000953c	cmpq	%rax, %rcx
000000010000953f	jae	0x1000095b4
0000000100009541	movq	0x3b38(%rip), %rdx
0000000100009548	movq	%rcx, %rax
000000010000954b	shrq	$0x10, %rax
000000010000954f	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009556	leaq	(%rdx,%rsi), %rax
000000010000955a	movzbl	(%rdx,%rsi), %edx
000000010000955e	cmpb	$0x2, %dl
0000000100009561	setne	%sil
0000000100009565	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000956c	setne	%r8b
0000000100009570	orb	%sil, %r8b
0000000100009573	jne	0x10000957d
0000000100009575	addq	$0x228, %rax                    ## imm = 0x228
000000010000957b	jmp	0x100009596
000000010000957d	cmpb	$0x1, %dl
0000000100009580	jne	0x1000095b4
0000000100009582	movl	0x20(%rax), %edx
0000000100009585	imulq	%rdx, %rcx
0000000100009589	shrq	$0x20, %rcx
000000010000958d	addq	%rcx, %rax
0000000100009590	addq	$0x228, %rax                    ## imm = 0x228
0000000100009596	movzbl	(%rax), %ecx
0000000100009599	testl	%ecx, %ecx
000000010000959b	je	0x1000095b4
000000010000959d	cmpl	$0x1, %ecx
00000001000095a0	jne	0x1000095a8
00000001000095a2	popq	%rbp
00000001000095a3	jmp	_fwp_rc_free_obj
00000001000095a8	cmpl	$0xff, %ecx
00000001000095ae	je	0x1000095b6
00000001000095b0	decb	%cl
00000001000095b2	movb	%cl, (%rax)
00000001000095b4	popq	%rbp
00000001000095b5	retq
00000001000095b6	movq	%rax, %rdi
00000001000095b9	popq	%rbp
00000001000095ba	jmp	_fwp_rc_wide_drop
00000001000095bf	nop
_fwp_owner_release6:
00000001000095c0	pushq	%rbp
00000001000095c1	movq	%rsp, %rbp
00000001000095c4	movq	(%rdi), %rax
00000001000095c7	subq	0x3a6a(%rip), %rax
00000001000095ce	movq	0x3a8b(%rip), %rcx
00000001000095d5	shlq	$0x10, %rcx
00000001000095d9	cmpq	%rcx, %rax
00000001000095dc	jae	0x100009642
00000001000095de	movq	0x3a9b(%rip), %rcx
00000001000095e5	movq	%rax, %rdx
00000001000095e8	shrq	$0x10, %rdx
00000001000095ec	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000095f3	leaq	(%rcx,%rdx), %rdi
00000001000095f7	movzbl	(%rcx,%rdx), %ecx
00000001000095fb	cmpb	$0x2, %cl
00000001000095fe	setne	%dl
0000000100009601	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009607	setne	%sil
000000010000960b	orb	%dl, %sil
000000010000960e	jne	0x100009619
0000000100009610	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009617	jmp	0x100009633
0000000100009619	cmpb	$0x1, %cl
000000010000961c	jne	0x100009642
000000010000961e	movl	0x20(%rdi), %ecx
0000000100009621	imulq	%rcx, %rax
0000000100009625	shrq	$0x20, %rax
0000000100009629	addq	%rax, %rdi
000000010000962c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009633	movzbl	(%rdi), %eax
0000000100009636	cmpb	$0x2, %al
0000000100009638	jb	0x100009642
000000010000963a	cmpb	$-0x1, %al
000000010000963c	je	0x100009644
000000010000963e	decb	%al
0000000100009640	movb	%al, (%rdi)
0000000100009642	popq	%rbp
0000000100009643	retq
0000000100009644	popq	%rbp
0000000100009645	jmp	_fwp_rc_wide_drop
000000010000964a	nopw	(%rax,%rax)
_fwp_owner_release7:
0000000100009650	pushq	%rbp
0000000100009651	movq	%rsp, %rbp
0000000100009654	movq	(%rdi), %rax
0000000100009657	subq	0x39da(%rip), %rax
000000010000965e	movq	0x39fb(%rip), %rcx
0000000100009665	shlq	$0x10, %rcx
0000000100009669	cmpq	%rcx, %rax
000000010000966c	jae	0x1000096d2
000000010000966e	movq	0x3a0b(%rip), %rcx
0000000100009675	movq	%rax, %rdx
0000000100009678	shrq	$0x10, %rdx
000000010000967c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009683	leaq	(%rcx,%rdx), %rdi
0000000100009687	movzbl	(%rcx,%rdx), %ecx
000000010000968b	cmpb	$0x2, %cl
000000010000968e	setne	%dl
0000000100009691	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009697	setne	%sil
000000010000969b	orb	%dl, %sil
000000010000969e	jne	0x1000096a9
00000001000096a0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000096a7	jmp	0x1000096c3
00000001000096a9	cmpb	$0x1, %cl
00000001000096ac	jne	0x1000096d2
00000001000096ae	movl	0x20(%rdi), %ecx
00000001000096b1	imulq	%rcx, %rax
00000001000096b5	shrq	$0x20, %rax
00000001000096b9	addq	%rax, %rdi
00000001000096bc	addq	$0x228, %rdi                    ## imm = 0x228
00000001000096c3	movzbl	(%rdi), %eax
00000001000096c6	cmpb	$0x2, %al
00000001000096c8	jb	0x1000096d2
00000001000096ca	cmpb	$-0x1, %al
00000001000096cc	je	0x1000096d4
00000001000096ce	decb	%al
00000001000096d0	movb	%al, (%rdi)
00000001000096d2	popq	%rbp
00000001000096d3	retq
00000001000096d4	popq	%rbp
00000001000096d5	jmp	_fwp_rc_wide_drop
00000001000096da	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
00000001000096e0	pushq	%rbp
00000001000096e1	movq	%rsp, %rbp
00000001000096e4	pushq	%rbx
00000001000096e5	pushq	%rax
00000001000096e6	movq	%rdi, %rbx
00000001000096e9	leaq	0x462(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
00000001000096f0	callq	0x1000097ca                     ## symbol stub for: _getenv
00000001000096f5	testq	%rax, %rax
00000001000096f8	je	0x100009711
00000001000096fa	movzbl	(%rax), %ecx
00000001000096fd	testl	%ecx, %ecx
00000001000096ff	je	0x100009718
0000000100009701	cmpl	$0x30, %ecx
0000000100009704	jne	0x100009715
0000000100009706	xorl	%ecx, %ecx
0000000100009708	cmpb	$0x0, 0x1(%rax)
000000010000970c	setne	%cl
000000010000970f	jmp	0x100009718
0000000100009711	xorl	%ecx, %ecx
0000000100009713	jmp	0x100009718
0000000100009715	pushq	$0x1
0000000100009717	popq	%rcx
0000000100009718	movl	%ecx, (%rbx)
000000010000971a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100009720	addq	$0x8, %rsp
0000000100009724	popq	%rbx
0000000100009725	popq	%rbp
0000000100009726	retq
