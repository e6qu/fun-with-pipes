/var/folders/20/jp1_0n3n7kndh6rnbqb5344m0000gn/T/fwp-arc-10722/files-1-dynamic-O2:
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
000000010000071b	movq	0x990e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100000722	movq	(%rax), %rax
0000000100000725	movq	%rax, -0x18(%rbp)
0000000100000729	leaq	_fwp_fn_table(%rip), %rax
0000000100000730	movq	%rax, _fwp_fns(%rip)
0000000100000737	movq	0x9902(%rip), %r14              ## literal pool symbol address: ___stdoutp
000000010000073e	movq	(%r14), %rax
0000000100000741	movq	%rax, _fwp_prog_out(%rip)
0000000100000748	movq	%rsi, _fwp_argv(%rip)
000000010000074f	leaq	_fwp_start_time(%rip), %rsi
0000000100000756	movl	$0x6, %edi
000000010000075b	callq	0x100009618                     ## symbol stub for: _clock_gettime
0000000100000760	leaq	0x94f7(%rip), %rdi              ## literal pool for: "FWP_SEED"
0000000100000767	callq	0x10000965a                     ## symbol stub for: _getenv
000000010000076c	testq	%rax, %rax
000000010000076f	je	0x100000797
0000000100000771	movq	%rax, %rbx
0000000100000774	cmpb	$0x0, (%rax)
0000000100000777	je	0x100000797
0000000100000779	leaq	-0x68(%rbp), %rsi
000000010000077d	movq	%rbx, %rdi
0000000100000780	movl	$0xa, %edx
0000000100000785	callq	0x100009708                     ## symbol stub for: _strtoull
000000010000078a	movq	-0x68(%rbp), %rax
000000010000078e	cmpb	$0x0, (%rax)
0000000100000791	je	0x100000860
0000000100000797	leaq	-0x58(%rbp), %rsi
000000010000079b	xorl	%edi, %edi
000000010000079d	callq	0x100009618                     ## symbol stub for: _clock_gettime
00000001000007a2	movq	(%r14), %rdi
00000001000007a5	movl	$0x10000, %ecx                  ## imm = 0x10000
00000001000007aa	xorl	%esi, %esi
00000001000007ac	xorl	%edx, %edx
00000001000007ae	callq	0x1000096ba                     ## symbol stub for: _setvbuf
00000001000007b3	movl	$0x1, %esi
00000001000007b8	movl	$0xd, %edi
00000001000007bd	callq	0x1000096cc                     ## symbol stub for: _signal
00000001000007c2	leaq	-0x58(%rbp), %rbx
00000001000007c6	movq	%rbx, %rdi
00000001000007c9	callq	0x100009696                     ## symbol stub for: _pthread_attr_init
00000001000007ce	movq	_fwp_main_stack(%rip), %rsi
00000001000007d5	movq	%rbx, %rdi
00000001000007d8	callq	0x10000969c                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007dd	leaq	_fwp_main_thread(%rip), %rdx
00000001000007e4	leaq	-0x70(%rbp), %rdi
00000001000007e8	movq	%rbx, %rsi
00000001000007eb	xorl	%ecx, %ecx
00000001000007ed	callq	0x1000096a2                     ## symbol stub for: _pthread_create
00000001000007f2	testl	%eax, %eax
00000001000007f4	je	0x100000832
00000001000007f6	leaq	-0x68(%rbp), %rsi
00000001000007fa	movl	$0x3, %edi
00000001000007ff	callq	0x100009660                     ## symbol stub for: _getrlimit
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
0000000100000838	callq	0x1000096a8                     ## symbol stub for: _pthread_join
000000010000083d	movq	(%r14), %rdi
0000000100000840	callq	0x100009630                     ## symbol stub for: _fflush
0000000100000845	movq	0x97e4(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
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
000000010000087a	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
000000010000087f	nop
_fwp_main_thread:
0000000100000880	pushq	%rbp
0000000100000881	movq	%rsp, %rbp
0000000100000884	pushq	%r15
0000000100000886	pushq	%r14
0000000100000888	pushq	%r12
000000010000088a	pushq	%rbx
000000010000088b	subq	$0x150, %rsp                    ## imm = 0x150
0000000100000892	movq	0x9797(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100000899	movq	(%rax), %rax
000000010000089c	movq	%rax, -0x28(%rbp)
00000001000008a0	cmpl	$0x0, 0xb74d(%rip)
00000001000008a7	jne	0x1000008ae
00000001000008a9	callq	_fwp_gc_init
00000001000008ae	movq	%rbp, 0xb7db(%rip)
00000001000008b5	callq	0x1000095f4                     ## symbol stub for: __dyld_image_count
00000001000008ba	testl	%eax, %eax
00000001000008bc	je	0x1000009c4
00000001000008c2	xorl	%ebx, %ebx
00000001000008c4	leaq	_fwp_gc(%rip), %r14
00000001000008cb	movl	$0x1, %r15d
00000001000008d1	jmp	0x1000008ef
00000001000008d3	testl	%esi, %esi
00000001000008d5	jne	0x10000095d
00000001000008db	nopl	(%rax,%rax)
00000001000008e0	incl	%ebx
00000001000008e2	callq	0x1000095f4                     ## symbol stub for: __dyld_image_count
00000001000008e7	cmpl	%eax, %ebx
00000001000008e9	jae	0x1000009c4
00000001000008ef	movl	%ebx, %edi
00000001000008f1	callq	0x1000095e8                     ## symbol stub for: __dyld_get_image_header
00000001000008f6	testq	%rax, %rax
00000001000008f9	je	0x1000008e0
00000001000008fb	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
0000000100000901	jne	0x1000008e0
0000000100000903	movl	%ebx, %edi
0000000100000905	movq	%rax, %r12
0000000100000908	callq	0x1000095ee                     ## symbol stub for: __dyld_get_image_vmaddr_slide
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
0000000100000939	je	0x1000008d3
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
000000010000095d	movl	0xb835(%rip), %esi
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
0000000100000996	je	0x1000011c7
000000010000099c	movq	0x18(%rcx), %r8
00000001000009a0	addq	%rax, %r8
00000001000009a3	movslq	%esi, %r9
00000001000009a6	shlq	$0x4, %r9
00000001000009aa	movq	%r8, 0x1090(%r9,%r14)
00000001000009b2	incl	%esi
00000001000009b4	movl	%esi, 0xb7de(%rip)
00000001000009ba	movq	%rdi, 0x1098(%r9,%r14)
00000001000009c2	jmp	0x100000970
00000001000009c4	cmpl	$0x0, 0xb62d(%rip)
00000001000009cb	setne	%cl
00000001000009ce	cmpl	$0x0, 0xb7c3(%rip)
00000001000009d5	setg	%al
00000001000009d8	andb	%cl, %al
00000001000009da	movzbl	%al, %ecx
00000001000009dd	movl	%ecx, 0xb619(%rip)
00000001000009e3	cmpl	$0x0, 0xb61a(%rip)
00000001000009ea	je	0x100000a02
00000001000009ec	leaq	_fwp_gc_report(%rip), %rdi
00000001000009f3	callq	0x100009606                     ## symbol stub for: _atexit
00000001000009f8	cmpl	$0x0, 0xb5fd(%rip)
00000001000009ff	setne	%al
0000000100000a02	testb	%al, %al
0000000100000a04	je	0x100000a49
0000000100000a06	cmpq	$0x0, 0xb61a(%rip)
0000000100000a0e	je	0x100000a49
0000000100000a10	movq	0xb801(%rip), %rax
0000000100000a17	subq	_fwp_gc(%rip), %rax
0000000100000a1e	cvtsi2sd	%rax, %xmm0
0000000100000a23	addsd	0xb7c5(%rip), %xmm0
0000000100000a2b	movsd	%xmm0, 0xb7bd(%rip)
0000000100000a33	movq	$0x0, 0xb7da(%rip)
0000000100000a3e	movq	$0x0, _fwp_gc(%rip)
0000000100000a49	movq	_fwp_main_stack(%rip), %rax
0000000100000a50	leaq	-0x130(%rbp), %r12
0000000100000a57	movq	%r12, _fwp_main_stack_top(%rip)
0000000100000a5e	movq	%rax, _fwp_main_stack_size(%rip)
0000000100000a65	leaq	_fwp_stack_guard_init.alt(%rip), %rax
0000000100000a6c	movq	%rax, -0x60(%rbp)
0000000100000a70	movq	$0x10000, -0x58(%rbp)           ## imm = 0x10000
0000000100000a78	movl	$0x0, -0x50(%rbp)
0000000100000a7f	leaq	-0x60(%rbp), %rdi
0000000100000a83	xorl	%esi, %esi
0000000100000a85	callq	0x1000096c6                     ## symbol stub for: _sigaltstack
0000000100000a8a	testl	%eax, %eax
0000000100000a8c	jne	0x100000ac9
0000000100000a8e	leaq	_fwp_segv(%rip), %rax
0000000100000a95	movq	%rax, -0x78(%rbp)
0000000100000a99	movabsq	$0x4100000000, %rax             ## imm = 0x4100000000
0000000100000aa3	movq	%rax, -0x70(%rbp)
0000000100000aa7	leaq	-0x78(%rbp), %rbx
0000000100000aab	movl	$0xb, %edi
0000000100000ab0	movq	%rbx, %rsi
0000000100000ab3	xorl	%edx, %edx
0000000100000ab5	callq	0x1000096c0                     ## symbol stub for: _sigaction
0000000100000aba	movl	$0xa, %edi
0000000100000abf	movq	%rbx, %rsi
0000000100000ac2	xorl	%edx, %edx
0000000100000ac4	callq	0x1000096c0                     ## symbol stub for: _sigaction
0000000100000ac9	movq	_fwp_gc(%rip), %rbx
0000000100000ad0	cmpb	$0x0, _caf0.st(%rip)
0000000100000ad7	movq	%rbx, %rax
0000000100000ada	jne	0x100001123
0000000100000ae0	movq	0x9a99(%rip), %rax
0000000100000ae7	movq	%rax, -0x50(%rbp)
0000000100000aeb	movups	0x9a7e(%rip), %xmm0
0000000100000af2	movaps	%xmm0, -0x60(%rbp)
0000000100000af6	movupd	0x9a8a(%rip), %xmm0
0000000100000afe	movapd	%xmm0, -0x170(%rbp)
0000000100000b06	movq	_fwp_cleanups(%rip), %rax
0000000100000b0d	movq	%rax, -0x78(%rbp)
0000000100000b11	leaq	_fwp_owner_release0(%rip), %rax
0000000100000b18	movq	%rax, -0x70(%rbp)
0000000100000b1c	leaq	-0x170(%rbp), %rax
0000000100000b23	movq	%rax, -0x68(%rbp)
0000000100000b27	leaq	-0x78(%rbp), %r14
0000000100000b2b	movq	%r14, _fwp_cleanups(%rip)
0000000100000b32	leaq	_s0(%rip), %rsi
0000000100000b39	leaq	-0x60(%rbp), %rdi
0000000100000b3d	callq	_fwp_p_attempt_owned
0000000100000b42	cmpq	%r14, _fwp_cleanups(%rip)
0000000100000b49	jne	0x100001195
0000000100000b4f	movq	%rax, %r15
0000000100000b52	movq	-0x78(%rbp), %rax
0000000100000b56	movq	%rax, _fwp_cleanups(%rip)
0000000100000b5d	leaq	-0x60(%rbp), %rax
0000000100000b61	leaq	_s0(%rip), %rax
0000000100000b68	leaq	_fc3(%rip), %rdi
0000000100000b6f	callq	_fwp_closure_drop
0000000100000b74	leaq	_fc4(%rip), %rdi
0000000100000b7b	callq	_fwp_closure_drop
0000000100000b80	movq	%r15, -0xa0(%rbp)
0000000100000b87	movq	_fwp_cleanups(%rip), %rax
0000000100000b8e	movq	%rax, -0x130(%rbp)
0000000100000b95	leaq	_fwp_owner_release1(%rip), %rax
0000000100000b9c	movq	%rax, -0x128(%rbp)
0000000100000ba3	leaq	-0xa0(%rbp), %rax
0000000100000baa	movq	%rax, -0x120(%rbp)
0000000100000bb1	movq	%r12, _fwp_cleanups(%rip)
0000000100000bb8	movq	%r15, %rdi
0000000100000bbb	callq	_f8
0000000100000bc0	cmpq	%r12, _fwp_cleanups(%rip)
0000000100000bc7	jne	0x100001195
0000000100000bcd	movq	%rax, %r14
0000000100000bd0	movq	-0x130(%rbp), %rax
0000000100000bd7	movq	%rax, _fwp_cleanups(%rip)
0000000100000bde	movq	%r15, %rdi
0000000100000be1	callq	_fwp_drop2
0000000100000be6	movq	%r14, -0x98(%rbp)
0000000100000bed	movq	_fwp_cleanups(%rip), %rax
0000000100000bf4	movq	%rax, -0x118(%rbp)
0000000100000bfb	leaq	_fwp_owner_release2(%rip), %rax
0000000100000c02	movq	%rax, -0x110(%rbp)
0000000100000c09	leaq	-0x98(%rbp), %rax
0000000100000c10	movq	%rax, -0x108(%rbp)
0000000100000c17	leaq	-0x118(%rbp), %r15
0000000100000c1e	movq	%r15, _fwp_cleanups(%rip)
0000000100000c25	movq	%r14, %rdi
0000000100000c28	addq	$0x8, %rdi
0000000100000c2c	movq	(%r14), %rdx
0000000100000c2f	movq	_fwp_prog_out(%rip), %rcx
0000000100000c36	movl	$0x1, %esi
0000000100000c3b	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100000c40	movq	_fwp_prog_out(%rip), %rsi
0000000100000c47	movl	$0xa, %edi
0000000100000c4c	callq	0x100009642                     ## symbol stub for: _fputc
0000000100000c51	cmpq	%r15, _fwp_cleanups(%rip)
0000000100000c58	jne	0x100001195
0000000100000c5e	movq	-0x118(%rbp), %rax
0000000100000c65	movq	%rax, _fwp_cleanups(%rip)
0000000100000c6c	movq	%r14, %rax
0000000100000c6f	subq	0xb3c2(%rip), %rax
0000000100000c76	movq	0xb3e3(%rip), %rcx
0000000100000c7d	shlq	$0x10, %rcx
0000000100000c81	cmpq	%rcx, %rax
0000000100000c84	jae	0x100000d00
0000000100000c86	movq	0xb3f3(%rip), %rcx
0000000100000c8d	movq	%rax, %rdx
0000000100000c90	shrq	$0x10, %rdx
0000000100000c94	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100000c9b	leaq	(%rcx,%rdx), %rdi
0000000100000c9f	movzbl	(%rcx,%rdx), %ecx
0000000100000ca3	cmpb	$0x2, %cl
0000000100000ca6	setne	%dl
0000000100000ca9	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100000caf	setne	%sil
0000000100000cb3	orb	%dl, %sil
0000000100000cb6	jne	0x100000cc1
0000000100000cb8	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000cbf	jmp	0x100000cdb
0000000100000cc1	cmpb	$0x1, %cl
0000000100000cc4	jne	0x100000d00
0000000100000cc6	movl	0x20(%rdi), %ecx
0000000100000cc9	imulq	%rcx, %rax
0000000100000ccd	shrq	$0x20, %rax
0000000100000cd1	addq	%rax, %rdi
0000000100000cd4	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000cdb	movzbl	(%rdi), %eax
0000000100000cde	testl	%eax, %eax
0000000100000ce0	je	0x100000d00
0000000100000ce2	cmpl	$0x1, %eax
0000000100000ce5	jne	0x100000cf1
0000000100000ce7	movq	%r14, %rdi
0000000100000cea	callq	_fwp_rc_free_obj
0000000100000cef	jmp	0x100000d00
0000000100000cf1	cmpl	$0xff, %eax
0000000100000cf6	je	0x100001181
0000000100000cfc	decb	%al
0000000100000cfe	movb	%al, (%rdi)
0000000100000d00	movq	0x98a1(%rip), %rax
0000000100000d07	movq	%rax, -0x140(%rbp)
0000000100000d0e	movups	0x9883(%rip), %xmm0
0000000100000d15	movaps	%xmm0, -0x150(%rbp)
0000000100000d1c	movupd	0x988c(%rip), %xmm0
0000000100000d24	movapd	%xmm0, -0x160(%rbp)
0000000100000d2c	movq	_fwp_cleanups(%rip), %rax
0000000100000d33	movq	%rax, -0x100(%rbp)
0000000100000d3a	leaq	_fwp_owner_release3(%rip), %rax
0000000100000d41	movq	%rax, -0xf8(%rbp)
0000000100000d48	leaq	-0x160(%rbp), %rax
0000000100000d4f	movq	%rax, -0xf0(%rbp)
0000000100000d56	leaq	-0x100(%rbp), %r14
0000000100000d5d	movq	%r14, _fwp_cleanups(%rip)
0000000100000d64	leaq	_s1(%rip), %rsi
0000000100000d6b	leaq	-0x150(%rbp), %rdi
0000000100000d72	callq	_fwp_p_attempt_owned
0000000100000d77	cmpq	%r14, _fwp_cleanups(%rip)
0000000100000d7e	jne	0x100001195
0000000100000d84	movq	%rax, %r15
0000000100000d87	movq	-0x100(%rbp), %rax
0000000100000d8e	movq	%rax, _fwp_cleanups(%rip)
0000000100000d95	leaq	-0x150(%rbp), %rax
0000000100000d9c	leaq	_s1(%rip), %rax
0000000100000da3	leaq	_fc3(%rip), %rdi
0000000100000daa	callq	_fwp_closure_drop
0000000100000daf	leaq	_fc4(%rip), %rdi
0000000100000db6	callq	_fwp_closure_drop
0000000100000dbb	movq	%r15, -0x90(%rbp)
0000000100000dc2	movq	_fwp_cleanups(%rip), %rax
0000000100000dc9	movq	%rax, -0xe8(%rbp)
0000000100000dd0	leaq	_fwp_owner_release4(%rip), %rax
0000000100000dd7	movq	%rax, -0xe0(%rbp)
0000000100000dde	leaq	-0x90(%rbp), %rax
0000000100000de5	movq	%rax, -0xd8(%rbp)
0000000100000dec	leaq	-0xe8(%rbp), %r12
0000000100000df3	movq	%r12, _fwp_cleanups(%rip)
0000000100000dfa	movq	%r15, %rdi
0000000100000dfd	callq	_f8
0000000100000e02	cmpq	%r12, _fwp_cleanups(%rip)
0000000100000e09	jne	0x100001195
0000000100000e0f	movq	%rax, %r14
0000000100000e12	movq	-0xe8(%rbp), %rax
0000000100000e19	movq	%rax, _fwp_cleanups(%rip)
0000000100000e20	movq	%r15, %rdi
0000000100000e23	callq	_fwp_drop2
0000000100000e28	movq	%r14, -0x88(%rbp)
0000000100000e2f	movq	_fwp_cleanups(%rip), %rax
0000000100000e36	movq	%rax, -0xd0(%rbp)
0000000100000e3d	leaq	_fwp_owner_release5(%rip), %rax
0000000100000e44	movq	%rax, -0xc8(%rbp)
0000000100000e4b	leaq	-0x88(%rbp), %rax
0000000100000e52	movq	%rax, -0xc0(%rbp)
0000000100000e59	leaq	-0xd0(%rbp), %r15
0000000100000e60	movq	%r15, _fwp_cleanups(%rip)
0000000100000e67	movq	%r14, %rdi
0000000100000e6a	addq	$0x8, %rdi
0000000100000e6e	movq	(%r14), %rdx
0000000100000e71	movq	_fwp_prog_out(%rip), %rcx
0000000100000e78	movl	$0x1, %esi
0000000100000e7d	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100000e82	movq	_fwp_prog_out(%rip), %rsi
0000000100000e89	movl	$0xa, %edi
0000000100000e8e	callq	0x100009642                     ## symbol stub for: _fputc
0000000100000e93	cmpq	%r15, _fwp_cleanups(%rip)
0000000100000e9a	jne	0x100001195
0000000100000ea0	movq	-0xd0(%rbp), %rax
0000000100000ea7	movq	%rax, _fwp_cleanups(%rip)
0000000100000eae	movq	%r14, %rax
0000000100000eb1	subq	0xb180(%rip), %rax
0000000100000eb8	movq	0xb1a1(%rip), %rcx
0000000100000ebf	shlq	$0x10, %rcx
0000000100000ec3	cmpq	%rcx, %rax
0000000100000ec6	jae	0x100000f42
0000000100000ec8	movq	0xb1b1(%rip), %rcx
0000000100000ecf	movq	%rax, %rdx
0000000100000ed2	shrq	$0x10, %rdx
0000000100000ed6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100000edd	leaq	(%rcx,%rdx), %rdi
0000000100000ee1	movzbl	(%rcx,%rdx), %ecx
0000000100000ee5	cmpb	$0x2, %cl
0000000100000ee8	setne	%dl
0000000100000eeb	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100000ef1	setne	%sil
0000000100000ef5	orb	%dl, %sil
0000000100000ef8	jne	0x100000f03
0000000100000efa	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000f01	jmp	0x100000f1d
0000000100000f03	cmpb	$0x1, %cl
0000000100000f06	jne	0x100000f42
0000000100000f08	movl	0x20(%rdi), %ecx
0000000100000f0b	imulq	%rcx, %rax
0000000100000f0f	shrq	$0x20, %rax
0000000100000f13	addq	%rax, %rdi
0000000100000f16	addq	$0x228, %rdi                    ## imm = 0x228
0000000100000f1d	movzbl	(%rdi), %eax
0000000100000f20	testl	%eax, %eax
0000000100000f22	je	0x100000f42
0000000100000f24	cmpl	$0x1, %eax
0000000100000f27	jne	0x100000f33
0000000100000f29	movq	%r14, %rdi
0000000100000f2c	callq	_fwp_rc_free_obj
0000000100000f31	jmp	0x100000f42
0000000100000f33	cmpl	$0xff, %eax
0000000100000f38	je	0x10000118b
0000000100000f3e	decb	%al
0000000100000f40	movb	%al, (%rdi)
0000000100000f42	movq	$0x0, -0x80(%rbp)
0000000100000f4a	movq	_fwp_cleanups(%rip), %rax
0000000100000f51	movq	%rax, -0xb8(%rbp)
0000000100000f58	leaq	_fwp_owner_release6(%rip), %rax
0000000100000f5f	movq	%rax, -0xb0(%rbp)
0000000100000f66	leaq	-0x80(%rbp), %rax
0000000100000f6a	movq	%rax, -0xa8(%rbp)
0000000100000f71	leaq	-0xb8(%rbp), %r15
0000000100000f78	movq	%r15, _fwp_cleanups(%rip)
0000000100000f7f	xorpd	%xmm0, %xmm0
0000000100000f83	movapd	%xmm0, -0x40(%rbp)
0000000100000f88	movl	$0x18, %edi
0000000100000f8d	callq	_fwp_alloc_init
0000000100000f92	movabsq	$0x200000001, %rcx              ## imm = 0x200000001
0000000100000f9c	movq	%rcx, (%rax)
0000000100000f9f	xorpd	%xmm0, %xmm0
0000000100000fa3	movupd	%xmm0, 0x8(%rax)
0000000100000fa8	leaq	-0x40(%rbp), %rcx
0000000100000fac	movq	%rax, %rcx
0000000100000faf	subq	0xb082(%rip), %rcx
0000000100000fb6	movq	0xb0a3(%rip), %rdx
0000000100000fbd	shlq	$0x10, %rdx
0000000100000fc1	cmpq	%rdx, %rcx
0000000100000fc4	jae	0x10000103e
0000000100000fc6	movq	0xb0b3(%rip), %rdx
0000000100000fcd	movq	%rcx, %rsi
0000000100000fd0	shrq	$0x10, %rsi
0000000100000fd4	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100000fdb	leaq	(%rdx,%rsi), %r14
0000000100000fdf	movzbl	(%rdx,%rsi), %edx
0000000100000fe3	cmpb	$0x2, %dl
0000000100000fe6	setne	%sil
0000000100000fea	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100000ff1	setne	%dil
0000000100000ff5	orb	%sil, %dil
0000000100000ff8	jne	0x10000100d
0000000100000ffa	addq	$0x228, %r14                    ## imm = 0x228
0000000100001001	cmpb	$-0x1, (%r14)
0000000100001005	je	0x10000102e
0000000100001007	movb	$0x1, (%r14)
000000010000100b	jmp	0x10000103e
000000010000100d	cmpb	$0x1, %dl
0000000100001010	jne	0x10000103e
0000000100001012	movl	0x20(%r14), %edx
0000000100001016	imulq	%rdx, %rcx
000000010000101a	shrq	$0x20, %rcx
000000010000101e	addq	%rcx, %r14
0000000100001021	addq	$0x228, %r14                    ## imm = 0x228
0000000100001028	cmpb	$-0x1, (%r14)
000000010000102c	jne	0x100001007
000000010000102e	movq	%r14, %rdi
0000000100001031	movq	%rax, %r12
0000000100001034	callq	_fwp_rc_forget_slot
0000000100001039	movq	%r12, %rax
000000010000103c	jmp	0x100001007
000000010000103e	cmpq	%r15, _fwp_cleanups(%rip)
0000000100001045	jne	0x100001195
000000010000104b	movq	-0xb8(%rbp), %rcx
0000000100001052	movq	%rcx, _fwp_cleanups(%rip)
0000000100001059	movq	%rax, %rcx
000000010000105c	subq	0xafd5(%rip), %rcx
0000000100001063	movq	0xaff6(%rip), %rdx
000000010000106a	shlq	$0x10, %rdx
000000010000106e	cmpq	%rdx, %rcx
0000000100001071	jae	0x100001115
0000000100001077	movq	0xb002(%rip), %rdx
000000010000107e	movq	%rcx, %rsi
0000000100001081	shrq	$0x10, %rsi
0000000100001085	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
000000010000108c	leaq	(%rdx,%rsi), %rdi
0000000100001090	movzbl	(%rdx,%rsi), %edx
0000000100001094	cmpb	$0x2, %dl
0000000100001097	setne	%sil
000000010000109b	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000010a2	setne	%r8b
00000001000010a6	orb	%sil, %r8b
00000001000010a9	jne	0x1000010b4
00000001000010ab	addq	$0x228, %rdi                    ## imm = 0x228
00000001000010b2	jmp	0x1000010ce
00000001000010b4	cmpb	$0x1, %dl
00000001000010b7	jne	0x100001115
00000001000010b9	movl	0x20(%rdi), %edx
00000001000010bc	imulq	%rdx, %rcx
00000001000010c0	shrq	$0x20, %rcx
00000001000010c4	addq	%rcx, %rdi
00000001000010c7	addq	$0x228, %rdi                    ## imm = 0x228
00000001000010ce	movzbl	(%rdi), %ecx
00000001000010d1	testl	%ecx, %ecx
00000001000010d3	je	0x100001115
00000001000010d5	cmpl	$0x1, %ecx
00000001000010d8	jne	0x100001109
00000001000010da	movq	0x10(%rax), %r14
00000001000010de	movq	%rax, %rdi
00000001000010e1	callq	_fwp_rc_free_obj
00000001000010e6	movq	%r14, %rcx
00000001000010e9	subq	0xaf48(%rip), %rcx
00000001000010f0	movq	0xaf69(%rip), %rdx
00000001000010f7	shlq	$0x10, %rdx
00000001000010fb	movq	%r14, %rax
00000001000010fe	cmpq	%rdx, %rcx
0000000100001101	jb	0x100001077
0000000100001107	jmp	0x100001115
0000000100001109	cmpl	$0xff, %ecx
000000010000110f	je	0x10000117a
0000000100001111	decb	%cl
0000000100001113	movb	%cl, (%rdi)
0000000100001115	movb	$0x1, _caf0.st(%rip)
000000010000111c	movq	_fwp_gc(%rip), %rax
0000000100001123	cmpq	$0x0, 0xb0b5(%rip)
000000010000112b	jne	0x10000119a
000000010000112d	cmpl	$0x0, 0xaec4(%rip)
0000000100001134	jne	0x10000119a
0000000100001136	cmpq	%rax, %rbx
0000000100001139	jg	0x10000119a
000000010000113b	xorpd	%xmm0, %xmm0
000000010000113f	ucomisd	0xb0c9(%rip), %xmm0
0000000100001147	jae	0x10000119a
0000000100001149	movq	0x8ef0(%rip), %rax              ## literal pool symbol address: ___stdoutp
0000000100001150	movq	(%rax), %rdi
0000000100001153	callq	0x100009630                     ## symbol stub for: _fflush
0000000100001158	movq	0x8ed1(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000115f	movq	(%rax), %rax
0000000100001162	cmpq	-0x28(%rbp), %rax
0000000100001166	jne	0x1000011c2
0000000100001168	xorl	%eax, %eax
000000010000116a	addq	$0x150, %rsp                    ## imm = 0x150
0000000100001171	popq	%rbx
0000000100001172	popq	%r12
0000000100001174	popq	%r14
0000000100001176	popq	%r15
0000000100001178	popq	%rbp
0000000100001179	retq
000000010000117a	callq	_fwp_rc_wide_drop
000000010000117f	jmp	0x100001115
0000000100001181	callq	_fwp_rc_wide_drop
0000000100001186	jmp	0x100000d00
000000010000118b	callq	_fwp_rc_wide_drop
0000000100001190	jmp	0x100000f42
0000000100001195	callq	0x100009600                     ## symbol stub for: _abort
000000010000119a	movq	0x8e97(%rip), %rcx              ## literal pool symbol address: ___stderrp
00000001000011a1	movq	(%rcx), %rdi
00000001000011a4	subq	%rax, %rbx
00000001000011a7	leaq	0x8ab9(%rip), %rsi              ## literal pool for: "ARC unreclaimed bytes: %ld\n"
00000001000011ae	movq	%rbx, %rdx
00000001000011b1	xorl	%eax, %eax
00000001000011b3	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000011b8	movl	$0xc1, %edi
00000001000011bd	callq	0x10000961e                     ## symbol stub for: _exit
00000001000011c2	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
00000001000011c7	callq	_fwp_flush
00000001000011cc	movq	0x8e65(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000011d3	movq	(%rax), %rdi
00000001000011d6	leaq	0x8757(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000011dd	leaq	0x8a9f(%rip), %rdx              ## literal pool for: "too many program data segments for the collector"
00000001000011e4	xorl	%eax, %eax
00000001000011e6	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000011eb	movl	$0x65, %edi
00000001000011f0	callq	0x10000961e                     ## symbol stub for: _exit
00000001000011f5	nopw	%cs:(%rax,%rax)
_e1:
0000000100001200	pushq	%rbp
0000000100001201	movq	%rsp, %rbp
0000000100001204	movq	%rdi, %rax
0000000100001207	movq	(%rdi), %rdi
000000010000120a	movq	0xae27(%rip), %rcx
0000000100001211	movq	%rdi, %rsi
0000000100001214	subq	%rcx, %rsi
0000000100001217	movq	0xae42(%rip), %rdx
000000010000121e	shlq	$0x10, %rdx
0000000100001222	cmpq	%rdx, %rsi
0000000100001225	jae	0x100001295
0000000100001227	movq	0xae52(%rip), %r9
000000010000122e	movq	%rsi, %r8
0000000100001231	shrq	$0x10, %r8
0000000100001235	imulq	$0x1228, %r8, %r10              ## imm = 0x1228
000000010000123c	leaq	(%r9,%r10), %r8
0000000100001240	movzbl	(%r9,%r10), %r9d
0000000100001245	cmpb	$0x2, %r9b
0000000100001249	setne	%r10b
000000010000124d	andq	$0xffff, %rsi                   ## imm = 0xFFFF
0000000100001254	setne	%r11b
0000000100001258	orb	%r10b, %r11b
000000010000125b	jne	0x10000126f
000000010000125d	addq	$0x228, %r8                     ## imm = 0x228
0000000100001264	cmpb	$0x0, (%r8)
0000000100001268	je	0x100001295
000000010000126a	jmp	0x100001390
000000010000126f	cmpb	$0x1, %r9b
0000000100001273	jne	0x100001295
0000000100001275	movl	0x20(%r8), %r9d
0000000100001279	imulq	%r9, %rsi
000000010000127d	shrq	$0x20, %rsi
0000000100001281	addq	%rsi, %r8
0000000100001284	addq	$0x228, %r8                     ## imm = 0x228
000000010000128b	cmpb	$0x0, (%r8)
000000010000128f	jne	0x100001390
0000000100001295	movq	0x8(%rax), %rsi
0000000100001299	movq	%rsi, %rax
000000010000129c	subq	%rcx, %rax
000000010000129f	cmpq	%rdx, %rax
00000001000012a2	jae	0x10000130c
00000001000012a4	movq	0xadd5(%rip), %rdx
00000001000012ab	movq	%rax, %rcx
00000001000012ae	shrq	$0x10, %rcx
00000001000012b2	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
00000001000012b9	leaq	(%rdx,%r8), %rcx
00000001000012bd	movzbl	(%rdx,%r8), %edx
00000001000012c2	cmpb	$0x2, %dl
00000001000012c5	setne	%r8b
00000001000012c9	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000012cf	setne	%r9b
00000001000012d3	orb	%r8b, %r9b
00000001000012d6	jne	0x1000012e9
00000001000012d8	addq	$0x228, %rcx                    ## imm = 0x228
00000001000012df	cmpb	$0x0, (%rcx)
00000001000012e2	je	0x10000130c
00000001000012e4	jmp	0x100001390
00000001000012e9	cmpb	$0x1, %dl
00000001000012ec	jne	0x10000130c
00000001000012ee	movl	0x20(%rcx), %edx
00000001000012f1	imulq	%rdx, %rax
00000001000012f5	shrq	$0x20, %rax
00000001000012f9	addq	%rax, %rcx
00000001000012fc	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001303	cmpb	$0x0, (%rcx)
0000000100001306	jne	0x100001390
000000010000130c	callq	_fwp_p_attempt_owned
0000000100001311	movq	%rax, %rcx
0000000100001314	subq	0xad1d(%rip), %rcx
000000010000131b	movq	0xad3e(%rip), %rdx
0000000100001322	shlq	$0x10, %rdx
0000000100001326	cmpq	%rdx, %rcx
0000000100001329	jae	0x10000138e
000000010000132b	movq	0xad4e(%rip), %rsi
0000000100001332	movq	%rcx, %rdx
0000000100001335	shrq	$0x10, %rdx
0000000100001339	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
0000000100001340	leaq	(%rsi,%rdi), %rdx
0000000100001344	movzbl	(%rsi,%rdi), %esi
0000000100001348	cmpb	$0x2, %sil
000000010000134c	setne	%dil
0000000100001350	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001357	setne	%r8b
000000010000135b	orb	%dil, %r8b
000000010000135e	jne	0x10000136e
0000000100001360	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001367	cmpb	$0x0, (%rdx)
000000010000136a	je	0x10000138e
000000010000136c	jmp	0x100001390
000000010000136e	cmpb	$0x1, %sil
0000000100001372	jne	0x10000138e
0000000100001374	movl	0x20(%rdx), %esi
0000000100001377	imulq	%rsi, %rcx
000000010000137b	shrq	$0x20, %rcx
000000010000137f	addq	%rcx, %rdx
0000000100001382	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001389	cmpb	$0x0, (%rdx)
000000010000138c	jne	0x100001390
000000010000138e	popq	%rbp
000000010000138f	retq
0000000100001390	callq	_fwp_flush
0000000100001395	movq	0x8c9c(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000139c	movq	(%rax), %rdi
000000010000139f	leaq	0x858e(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000013a6	leaq	0x855a(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
00000001000013ad	xorl	%eax, %eax
00000001000013af	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000013b4	movl	$0x65, %edi
00000001000013b9	callq	0x10000961e                     ## symbol stub for: _exit
00000001000013be	nop
_e2:
00000001000013c0	pushq	%rbp
00000001000013c1	movq	%rsp, %rbp
00000001000013c4	pushq	%rbx
00000001000013c5	subq	$0x18, %rsp
00000001000013c9	movq	%rdi, %rax
00000001000013cc	movq	0x8c5d(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
00000001000013d3	movq	(%rcx), %rcx
00000001000013d6	movq	%rcx, -0x10(%rbp)
00000001000013da	movq	(%rdi), %rdi
00000001000013dd	movq	0xac54(%rip), %rcx
00000001000013e4	movq	%rdi, %rsi
00000001000013e7	subq	%rcx, %rsi
00000001000013ea	movq	0xac6f(%rip), %rdx
00000001000013f1	shlq	$0x10, %rdx
00000001000013f5	cmpq	%rdx, %rsi
00000001000013f8	jae	0x100001468
00000001000013fa	movq	0xac7f(%rip), %r9
0000000100001401	movq	%rsi, %r8
0000000100001404	shrq	$0x10, %r8
0000000100001408	imulq	$0x1228, %r8, %r10              ## imm = 0x1228
000000010000140f	leaq	(%r9,%r10), %r8
0000000100001413	movzbl	(%r9,%r10), %r9d
0000000100001418	cmpb	$0x2, %r9b
000000010000141c	setne	%r10b
0000000100001420	andq	$0xffff, %rsi                   ## imm = 0xFFFF
0000000100001427	setne	%r11b
000000010000142b	orb	%r10b, %r11b
000000010000142e	jne	0x100001442
0000000100001430	addq	$0x228, %r8                     ## imm = 0x228
0000000100001437	cmpb	$0x0, (%r8)
000000010000143b	je	0x100001468
000000010000143d	jmp	0x100001606
0000000100001442	cmpb	$0x1, %r9b
0000000100001446	jne	0x100001468
0000000100001448	movl	0x20(%r8), %r9d
000000010000144c	imulq	%r9, %rsi
0000000100001450	shrq	$0x20, %rsi
0000000100001454	addq	%rsi, %r8
0000000100001457	addq	$0x228, %r8                     ## imm = 0x228
000000010000145e	cmpb	$0x0, (%r8)
0000000100001462	jne	0x100001606
0000000100001468	movq	0x8(%rax), %rsi
000000010000146c	movq	%rsi, %r8
000000010000146f	subq	%rcx, %r8
0000000100001472	cmpq	%rdx, %r8
0000000100001475	jae	0x1000014e4
0000000100001477	movq	0xac02(%rip), %r10
000000010000147e	movq	%r8, %r9
0000000100001481	shrq	$0x10, %r9
0000000100001485	imulq	$0x1228, %r9, %r11              ## imm = 0x1228
000000010000148c	leaq	(%r10,%r11), %r9
0000000100001490	movzbl	(%r10,%r11), %r10d
0000000100001495	cmpb	$0x2, %r10b
0000000100001499	setne	%r11b
000000010000149d	andq	$0xffff, %r8                    ## imm = 0xFFFF
00000001000014a4	setne	%bl
00000001000014a7	orb	%r11b, %bl
00000001000014aa	jne	0x1000014be
00000001000014ac	addq	$0x228, %r9                     ## imm = 0x228
00000001000014b3	cmpb	$0x0, (%r9)
00000001000014b7	je	0x1000014e4
00000001000014b9	jmp	0x100001606
00000001000014be	cmpb	$0x1, %r10b
00000001000014c2	jne	0x1000014e4
00000001000014c4	movl	0x20(%r9), %r10d
00000001000014c8	imulq	%r10, %r8
00000001000014cc	shrq	$0x20, %r8
00000001000014d0	addq	%r8, %r9
00000001000014d3	addq	$0x228, %r9                     ## imm = 0x228
00000001000014da	cmpb	$0x0, (%r9)
00000001000014de	jne	0x100001606
00000001000014e4	movq	0x10(%rax), %rax
00000001000014e8	movq	%rax, %r8
00000001000014eb	subq	%rcx, %r8
00000001000014ee	cmpq	%rdx, %r8
00000001000014f1	jae	0x10000155c
00000001000014f3	movq	0xab86(%rip), %rdx
00000001000014fa	movq	%r8, %rcx
00000001000014fd	shrq	$0x10, %rcx
0000000100001501	imulq	$0x1228, %rcx, %r9              ## imm = 0x1228
0000000100001508	leaq	(%rdx,%r9), %rcx
000000010000150c	movzbl	(%rdx,%r9), %edx
0000000100001511	cmpb	$0x2, %dl
0000000100001514	setne	%r9b
0000000100001518	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000151f	setne	%r10b
0000000100001523	orb	%r9b, %r10b
0000000100001526	jne	0x100001539
0000000100001528	addq	$0x228, %rcx                    ## imm = 0x228
000000010000152f	cmpb	$0x0, (%rcx)
0000000100001532	je	0x10000155c
0000000100001534	jmp	0x100001606
0000000100001539	cmpb	$0x1, %dl
000000010000153c	jne	0x10000155c
000000010000153e	movl	0x20(%rcx), %edx
0000000100001541	imulq	%rdx, %r8
0000000100001545	shrq	$0x20, %r8
0000000100001549	addq	%r8, %rcx
000000010000154c	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001553	cmpb	$0x0, (%rcx)
0000000100001556	jne	0x100001606
000000010000155c	movq	%rax, -0x20(%rbp)
0000000100001560	movq	%rsi, -0x18(%rbp)
0000000100001564	leaq	-0x20(%rbp), %rdx
0000000100001568	movl	$0x2, %esi
000000010000156d	callq	_fwp_apply_owned
0000000100001572	movq	%rax, %rcx
0000000100001575	subq	0xaabc(%rip), %rcx
000000010000157c	movq	0xaadd(%rip), %rdx
0000000100001583	shlq	$0x10, %rdx
0000000100001587	cmpq	%rdx, %rcx
000000010000158a	jae	0x1000015ef
000000010000158c	movq	0xaaed(%rip), %rsi
0000000100001593	movq	%rcx, %rdx
0000000100001596	shrq	$0x10, %rdx
000000010000159a	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
00000001000015a1	leaq	(%rsi,%rdi), %rdx
00000001000015a5	movzbl	(%rsi,%rdi), %esi
00000001000015a9	cmpb	$0x2, %sil
00000001000015ad	setne	%dil
00000001000015b1	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000015b8	setne	%r8b
00000001000015bc	orb	%dil, %r8b
00000001000015bf	jne	0x1000015cf
00000001000015c1	addq	$0x228, %rdx                    ## imm = 0x228
00000001000015c8	cmpb	$0x0, (%rdx)
00000001000015cb	je	0x1000015ef
00000001000015cd	jmp	0x100001606
00000001000015cf	cmpb	$0x1, %sil
00000001000015d3	jne	0x1000015ef
00000001000015d5	movl	0x20(%rdx), %esi
00000001000015d8	imulq	%rsi, %rcx
00000001000015dc	shrq	$0x20, %rcx
00000001000015e0	addq	%rcx, %rdx
00000001000015e3	addq	$0x228, %rdx                    ## imm = 0x228
00000001000015ea	cmpb	$0x0, (%rdx)
00000001000015ed	jne	0x100001606
00000001000015ef	movq	0x8a3a(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
00000001000015f6	movq	(%rcx), %rcx
00000001000015f9	cmpq	-0x10(%rbp), %rcx
00000001000015fd	jne	0x100001634
00000001000015ff	addq	$0x18, %rsp
0000000100001603	popq	%rbx
0000000100001604	popq	%rbp
0000000100001605	retq
0000000100001606	callq	_fwp_flush
000000010000160b	movq	0x8a26(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001612	movq	(%rax), %rdi
0000000100001615	leaq	0x8318(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000161c	leaq	0x82e4(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001623	xorl	%eax, %eax
0000000100001625	callq	0x10000963c                     ## symbol stub for: _fprintf
000000010000162a	movl	$0x65, %edi
000000010000162f	callq	0x10000961e                     ## symbol stub for: _exit
0000000100001634	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100001639	nopl	(%rax)
_e3:
0000000100001640	pushq	%rbp
0000000100001641	movq	%rsp, %rbp
0000000100001644	movq	%rdi, %rax
0000000100001647	movq	(%rdi), %rdi
000000010000164a	movq	0xa9e7(%rip), %rcx
0000000100001651	movq	%rdi, %rsi
0000000100001654	subq	%rcx, %rsi
0000000100001657	movq	0xaa02(%rip), %rdx
000000010000165e	shlq	$0x10, %rdx
0000000100001662	cmpq	%rdx, %rsi
0000000100001665	jae	0x1000016d5
0000000100001667	movq	0xaa12(%rip), %r9
000000010000166e	movq	%rsi, %r8
0000000100001671	shrq	$0x10, %r8
0000000100001675	imulq	$0x1228, %r8, %r10              ## imm = 0x1228
000000010000167c	leaq	(%r9,%r10), %r8
0000000100001680	movzbl	(%r9,%r10), %r9d
0000000100001685	cmpb	$0x2, %r9b
0000000100001689	setne	%r10b
000000010000168d	andq	$0xffff, %rsi                   ## imm = 0xFFFF
0000000100001694	setne	%r11b
0000000100001698	orb	%r10b, %r11b
000000010000169b	jne	0x1000016af
000000010000169d	addq	$0x228, %r8                     ## imm = 0x228
00000001000016a4	cmpb	$0x0, (%r8)
00000001000016a8	je	0x1000016d5
00000001000016aa	jmp	0x1000017d0
00000001000016af	cmpb	$0x1, %r9b
00000001000016b3	jne	0x1000016d5
00000001000016b5	movl	0x20(%r8), %r9d
00000001000016b9	imulq	%r9, %rsi
00000001000016bd	shrq	$0x20, %rsi
00000001000016c1	addq	%rsi, %r8
00000001000016c4	addq	$0x228, %r8                     ## imm = 0x228
00000001000016cb	cmpb	$0x0, (%r8)
00000001000016cf	jne	0x1000017d0
00000001000016d5	movq	0x8(%rax), %rsi
00000001000016d9	movq	%rsi, %rax
00000001000016dc	subq	%rcx, %rax
00000001000016df	cmpq	%rdx, %rax
00000001000016e2	jae	0x10000174c
00000001000016e4	movq	0xa995(%rip), %rdx
00000001000016eb	movq	%rax, %rcx
00000001000016ee	shrq	$0x10, %rcx
00000001000016f2	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
00000001000016f9	leaq	(%rdx,%r8), %rcx
00000001000016fd	movzbl	(%rdx,%r8), %edx
0000000100001702	cmpb	$0x2, %dl
0000000100001705	setne	%r8b
0000000100001709	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000170f	setne	%r9b
0000000100001713	orb	%r8b, %r9b
0000000100001716	jne	0x100001729
0000000100001718	addq	$0x228, %rcx                    ## imm = 0x228
000000010000171f	cmpb	$0x0, (%rcx)
0000000100001722	je	0x10000174c
0000000100001724	jmp	0x1000017d0
0000000100001729	cmpb	$0x1, %dl
000000010000172c	jne	0x10000174c
000000010000172e	movl	0x20(%rcx), %edx
0000000100001731	imulq	%rdx, %rax
0000000100001735	shrq	$0x20, %rax
0000000100001739	addq	%rax, %rcx
000000010000173c	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001743	cmpb	$0x0, (%rcx)
0000000100001746	jne	0x1000017d0
000000010000174c	callq	_fwp_p_file_with_owned
0000000100001751	movq	%rax, %rcx
0000000100001754	subq	0xa8dd(%rip), %rcx
000000010000175b	movq	0xa8fe(%rip), %rdx
0000000100001762	shlq	$0x10, %rdx
0000000100001766	cmpq	%rdx, %rcx
0000000100001769	jae	0x1000017ce
000000010000176b	movq	0xa90e(%rip), %rsi
0000000100001772	movq	%rcx, %rdx
0000000100001775	shrq	$0x10, %rdx
0000000100001779	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
0000000100001780	leaq	(%rsi,%rdi), %rdx
0000000100001784	movzbl	(%rsi,%rdi), %esi
0000000100001788	cmpb	$0x2, %sil
000000010000178c	setne	%dil
0000000100001790	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001797	setne	%r8b
000000010000179b	orb	%dil, %r8b
000000010000179e	jne	0x1000017ae
00000001000017a0	addq	$0x228, %rdx                    ## imm = 0x228
00000001000017a7	cmpb	$0x0, (%rdx)
00000001000017aa	je	0x1000017ce
00000001000017ac	jmp	0x1000017d0
00000001000017ae	cmpb	$0x1, %sil
00000001000017b2	jne	0x1000017ce
00000001000017b4	movl	0x20(%rdx), %esi
00000001000017b7	imulq	%rsi, %rcx
00000001000017bb	shrq	$0x20, %rcx
00000001000017bf	addq	%rcx, %rdx
00000001000017c2	addq	$0x228, %rdx                    ## imm = 0x228
00000001000017c9	cmpb	$0x0, (%rdx)
00000001000017cc	jne	0x1000017d0
00000001000017ce	popq	%rbp
00000001000017cf	retq
00000001000017d0	callq	_fwp_flush
00000001000017d5	movq	0x885c(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000017dc	movq	(%rax), %rdi
00000001000017df	leaq	0x814e(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000017e6	leaq	0x811a(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
00000001000017ed	xorl	%eax, %eax
00000001000017ef	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000017f4	movl	$0x65, %edi
00000001000017f9	callq	0x10000961e                     ## symbol stub for: _exit
00000001000017fe	nop
_e4:
0000000100001800	pushq	%rbp
0000000100001801	movq	%rsp, %rbp
0000000100001804	movq	(%rdi), %rdi
0000000100001807	movq	%rdi, %rax
000000010000180a	subq	0xa827(%rip), %rax
0000000100001811	movq	0xa848(%rip), %rcx
0000000100001818	shlq	$0x10, %rcx
000000010000181c	cmpq	%rcx, %rax
000000010000181f	jae	0x100001888
0000000100001821	movq	0xa858(%rip), %rdx
0000000100001828	movq	%rax, %rcx
000000010000182b	shrq	$0x10, %rcx
000000010000182f	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001836	leaq	(%rdx,%rsi), %rcx
000000010000183a	movzbl	(%rdx,%rsi), %edx
000000010000183e	cmpb	$0x2, %dl
0000000100001841	setne	%sil
0000000100001845	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000184b	setne	%r8b
000000010000184f	orb	%sil, %r8b
0000000100001852	jne	0x100001865
0000000100001854	addq	$0x228, %rcx                    ## imm = 0x228
000000010000185b	cmpb	$0x0, (%rcx)
000000010000185e	je	0x100001888
0000000100001860	jmp	0x10000190c
0000000100001865	cmpb	$0x1, %dl
0000000100001868	jne	0x100001888
000000010000186a	movl	0x20(%rcx), %edx
000000010000186d	imulq	%rdx, %rax
0000000100001871	shrq	$0x20, %rax
0000000100001875	addq	%rax, %rcx
0000000100001878	addq	$0x228, %rcx                    ## imm = 0x228
000000010000187f	cmpb	$0x0, (%rcx)
0000000100001882	jne	0x10000190c
0000000100001888	callq	_f4
000000010000188d	movq	%rax, %rcx
0000000100001890	subq	0xa7a1(%rip), %rcx
0000000100001897	movq	0xa7c2(%rip), %rdx
000000010000189e	shlq	$0x10, %rdx
00000001000018a2	cmpq	%rdx, %rcx
00000001000018a5	jae	0x10000190a
00000001000018a7	movq	0xa7d2(%rip), %rsi
00000001000018ae	movq	%rcx, %rdx
00000001000018b1	shrq	$0x10, %rdx
00000001000018b5	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
00000001000018bc	leaq	(%rsi,%rdi), %rdx
00000001000018c0	movzbl	(%rsi,%rdi), %esi
00000001000018c4	cmpb	$0x2, %sil
00000001000018c8	setne	%dil
00000001000018cc	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000018d3	setne	%r8b
00000001000018d7	orb	%dil, %r8b
00000001000018da	jne	0x1000018ea
00000001000018dc	addq	$0x228, %rdx                    ## imm = 0x228
00000001000018e3	cmpb	$0x0, (%rdx)
00000001000018e6	je	0x10000190a
00000001000018e8	jmp	0x10000190c
00000001000018ea	cmpb	$0x1, %sil
00000001000018ee	jne	0x10000190a
00000001000018f0	movl	0x20(%rdx), %esi
00000001000018f3	imulq	%rsi, %rcx
00000001000018f7	shrq	$0x20, %rcx
00000001000018fb	addq	%rcx, %rdx
00000001000018fe	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001905	cmpb	$0x0, (%rdx)
0000000100001908	jne	0x10000190c
000000010000190a	popq	%rbp
000000010000190b	retq
000000010000190c	callq	_fwp_flush
0000000100001911	movq	0x8720(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001918	movq	(%rax), %rdi
000000010000191b	leaq	0x8012(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001922	leaq	0x7fde(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001929	xorl	%eax, %eax
000000010000192b	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100001930	movl	$0x65, %edi
0000000100001935	callq	0x10000961e                     ## symbol stub for: _exit
000000010000193a	nopw	(%rax,%rax)
_e8:
0000000100001940	pushq	%rbp
0000000100001941	movq	%rsp, %rbp
0000000100001944	movq	(%rdi), %rdi
0000000100001947	movq	%rdi, %rax
000000010000194a	subq	0xa6e7(%rip), %rax
0000000100001951	movq	0xa708(%rip), %rcx
0000000100001958	shlq	$0x10, %rcx
000000010000195c	cmpq	%rcx, %rax
000000010000195f	jae	0x1000019c8
0000000100001961	movq	0xa718(%rip), %rdx
0000000100001968	movq	%rax, %rcx
000000010000196b	shrq	$0x10, %rcx
000000010000196f	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001976	leaq	(%rdx,%rsi), %rcx
000000010000197a	movzbl	(%rdx,%rsi), %edx
000000010000197e	cmpb	$0x2, %dl
0000000100001981	setne	%sil
0000000100001985	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000198b	setne	%r8b
000000010000198f	orb	%sil, %r8b
0000000100001992	jne	0x1000019a5
0000000100001994	addq	$0x228, %rcx                    ## imm = 0x228
000000010000199b	cmpb	$0x0, (%rcx)
000000010000199e	je	0x1000019c8
00000001000019a0	jmp	0x100001a4c
00000001000019a5	cmpb	$0x1, %dl
00000001000019a8	jne	0x1000019c8
00000001000019aa	movl	0x20(%rcx), %edx
00000001000019ad	imulq	%rdx, %rax
00000001000019b1	shrq	$0x20, %rax
00000001000019b5	addq	%rax, %rcx
00000001000019b8	addq	$0x228, %rcx                    ## imm = 0x228
00000001000019bf	cmpb	$0x0, (%rcx)
00000001000019c2	jne	0x100001a4c
00000001000019c8	callq	_f8
00000001000019cd	movq	%rax, %rcx
00000001000019d0	subq	0xa661(%rip), %rcx
00000001000019d7	movq	0xa682(%rip), %rdx
00000001000019de	shlq	$0x10, %rdx
00000001000019e2	cmpq	%rdx, %rcx
00000001000019e5	jae	0x100001a4a
00000001000019e7	movq	0xa692(%rip), %rsi
00000001000019ee	movq	%rcx, %rdx
00000001000019f1	shrq	$0x10, %rdx
00000001000019f5	imulq	$0x1228, %rdx, %rdi             ## imm = 0x1228
00000001000019fc	leaq	(%rsi,%rdi), %rdx
0000000100001a00	movzbl	(%rsi,%rdi), %esi
0000000100001a04	cmpb	$0x2, %sil
0000000100001a08	setne	%dil
0000000100001a0c	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001a13	setne	%r8b
0000000100001a17	orb	%dil, %r8b
0000000100001a1a	jne	0x100001a2a
0000000100001a1c	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001a23	cmpb	$0x0, (%rdx)
0000000100001a26	je	0x100001a4a
0000000100001a28	jmp	0x100001a4c
0000000100001a2a	cmpb	$0x1, %sil
0000000100001a2e	jne	0x100001a4a
0000000100001a30	movl	0x20(%rdx), %esi
0000000100001a33	imulq	%rsi, %rcx
0000000100001a37	shrq	$0x20, %rcx
0000000100001a3b	addq	%rcx, %rdx
0000000100001a3e	addq	$0x228, %rdx                    ## imm = 0x228
0000000100001a45	cmpb	$0x0, (%rdx)
0000000100001a48	jne	0x100001a4c
0000000100001a4a	popq	%rbp
0000000100001a4b	retq
0000000100001a4c	callq	_fwp_flush
0000000100001a51	movq	0x85e0(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001a58	movq	(%rax), %rdi
0000000100001a5b	leaq	0x7ed2(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001a62	leaq	0x7e9e(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001a69	xorl	%eax, %eax
0000000100001a6b	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100001a70	movl	$0x65, %edi
0000000100001a75	callq	0x10000961e                     ## symbol stub for: _exit
0000000100001a7a	nopw	(%rax,%rax)
_e9:
0000000100001a80	pushq	%rbp
0000000100001a81	movq	%rsp, %rbp
0000000100001a84	movq	(%rdi), %rdi
0000000100001a87	movq	%rdi, %rax
0000000100001a8a	subq	0xa5a7(%rip), %rax
0000000100001a91	movq	0xa5c8(%rip), %rcx
0000000100001a98	shlq	$0x10, %rcx
0000000100001a9c	cmpq	%rcx, %rax
0000000100001a9f	jae	0x100001b08
0000000100001aa1	movq	0xa5d8(%rip), %rdx
0000000100001aa8	movq	%rax, %rcx
0000000100001aab	shrq	$0x10, %rcx
0000000100001aaf	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001ab6	leaq	(%rdx,%rsi), %rcx
0000000100001aba	movzbl	(%rdx,%rsi), %edx
0000000100001abe	cmpb	$0x2, %dl
0000000100001ac1	setne	%sil
0000000100001ac5	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100001acb	setne	%r8b
0000000100001acf	orb	%sil, %r8b
0000000100001ad2	jne	0x100001ae5
0000000100001ad4	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001adb	cmpb	$0x0, (%rcx)
0000000100001ade	je	0x100001b08
0000000100001ae0	jmp	0x100001bae
0000000100001ae5	cmpb	$0x1, %dl
0000000100001ae8	jne	0x100001b08
0000000100001aea	movl	0x20(%rcx), %edx
0000000100001aed	imulq	%rdx, %rax
0000000100001af1	shrq	$0x20, %rax
0000000100001af5	addq	%rax, %rcx
0000000100001af8	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001aff	cmpb	$0x0, (%rcx)
0000000100001b02	jne	0x100001bae
0000000100001b08	movq	(%rdi), %rdx
0000000100001b0b	addq	$0x8, %rdi
0000000100001b0f	movq	_fwp_prog_out(%rip), %rcx
0000000100001b16	movl	$0x1, %esi
0000000100001b1b	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100001b20	movq	_fwp_prog_out(%rip), %rsi
0000000100001b27	movl	$0xa, %edi
0000000100001b2c	callq	0x100009642                     ## symbol stub for: _fputc
0000000100001b31	xorl	%eax, %eax
0000000100001b33	subq	0xa4fe(%rip), %rax
0000000100001b3a	movq	0xa51f(%rip), %rcx
0000000100001b41	shlq	$0x10, %rcx
0000000100001b45	cmpq	%rax, %rcx
0000000100001b48	jbe	0x100001baa
0000000100001b4a	movq	0xa52f(%rip), %rdx
0000000100001b51	movq	%rax, %rcx
0000000100001b54	shrq	$0x10, %rcx
0000000100001b58	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100001b5f	leaq	(%rdx,%rsi), %rcx
0000000100001b63	movzbl	(%rdx,%rsi), %edx
0000000100001b67	cmpb	$0x2, %dl
0000000100001b6a	setne	%sil
0000000100001b6e	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100001b74	setne	%dil
0000000100001b78	orb	%sil, %dil
0000000100001b7b	jne	0x100001b8b
0000000100001b7d	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001b84	cmpb	$0x0, (%rcx)
0000000100001b87	je	0x100001baa
0000000100001b89	jmp	0x100001bae
0000000100001b8b	cmpb	$0x1, %dl
0000000100001b8e	jne	0x100001baa
0000000100001b90	movl	0x20(%rcx), %edx
0000000100001b93	imulq	%rdx, %rax
0000000100001b97	shrq	$0x20, %rax
0000000100001b9b	addq	%rax, %rcx
0000000100001b9e	addq	$0x228, %rcx                    ## imm = 0x228
0000000100001ba5	cmpb	$0x0, (%rcx)
0000000100001ba8	jne	0x100001bae
0000000100001baa	xorl	%eax, %eax
0000000100001bac	popq	%rbp
0000000100001bad	retq
0000000100001bae	callq	_fwp_flush
0000000100001bb3	movq	0x847e(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001bba	movq	(%rax), %rdi
0000000100001bbd	leaq	0x7d70(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001bc4	leaq	0x7d3c(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
0000000100001bcb	xorl	%eax, %eax
0000000100001bcd	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100001bd2	movl	$0x65, %edi
0000000100001bd7	callq	0x10000961e                     ## symbol stub for: _exit
0000000100001bdc	nopl	(%rax)
_fwp_cleanup_unwind:
0000000100001be0	pushq	%rbp
0000000100001be1	movq	%rsp, %rbp
0000000100001be4	pushq	%rbx
0000000100001be5	pushq	%rax
0000000100001be6	movq	_fwp_cleanups(%rip), %rax
0000000100001bed	cmpq	%rdi, %rax
0000000100001bf0	je	0x100001c22
0000000100001bf2	movq	%rdi, %rbx
0000000100001bf5	nopw	%cs:(%rax,%rax)
0000000100001c00	testq	%rax, %rax
0000000100001c03	je	0x100001c29
0000000100001c05	movq	(%rax), %rcx
0000000100001c08	movq	%rcx, _fwp_cleanups(%rip)
0000000100001c0f	movq	0x10(%rax), %rdi
0000000100001c13	callq	*0x8(%rax)
0000000100001c16	movq	_fwp_cleanups(%rip), %rax
0000000100001c1d	cmpq	%rbx, %rax
0000000100001c20	jne	0x100001c00
0000000100001c22	addq	$0x8, %rsp
0000000100001c26	popq	%rbx
0000000100001c27	popq	%rbp
0000000100001c28	retq
0000000100001c29	callq	0x100009600                     ## symbol stub for: _abort
0000000100001c2e	nop
_fwp_flush:
0000000100001c30	pushq	%rbp
0000000100001c31	movq	%rsp, %rbp
0000000100001c34	movq	_fwp_prog_out(%rip), %rdi
0000000100001c3b	testq	%rdi, %rdi
0000000100001c3e	je	0x100001c45
0000000100001c40	callq	0x100009630                     ## symbol stub for: _fflush
0000000100001c45	movq	0x83f4(%rip), %rax              ## literal pool symbol address: ___stdoutp
0000000100001c4c	movq	(%rax), %rdi
0000000100001c4f	popq	%rbp
0000000100001c50	jmp	0x100009630                     ## symbol stub for: _fflush
0000000100001c55	nopw	%cs:(%rax,%rax)
_fwp_rc_forget_slot:
0000000100001c60	pushq	%rbp
0000000100001c61	movq	%rsp, %rbp
0000000100001c64	cmpb	$-0x1, (%rdi)
0000000100001c67	je	0x100001c6b
0000000100001c69	popq	%rbp
0000000100001c6a	retq
0000000100001c6b	movq	%rdi, %rax
0000000100001c6e	shrq	$0x11, %rax
0000000100001c72	xorl	%edi, %eax
0000000100001c74	movl	%eax, %ecx
0000000100001c76	shrl	$0x9, %ecx
0000000100001c79	xorl	%eax, %ecx
0000000100001c7b	movzbl	%cl, %ecx
0000000100001c7e	leaq	_fwp_gc(%rip), %rdx
0000000100001c85	movq	0x1218(%rdx,%rcx,8), %rax
0000000100001c8d	testq	%rax, %rax
0000000100001c90	je	0x100001cda
0000000100001c92	cmpq	%rdi, (%rax)
0000000100001c95	je	0x100001cb7
0000000100001c97	nopw	(%rax,%rax)
0000000100001ca0	movq	%rax, %rcx
0000000100001ca3	movq	0x10(%rax), %rax
0000000100001ca7	testq	%rax, %rax
0000000100001caa	je	0x100001cda
0000000100001cac	cmpq	%rdi, (%rax)
0000000100001caf	jne	0x100001ca0
0000000100001cb1	addq	$0x10, %rcx
0000000100001cb5	jmp	0x100001cc2
0000000100001cb7	leaq	(%rdx,%rcx,8), %rcx
0000000100001cbb	addq	$0x1218, %rcx                   ## imm = 0x1218
0000000100001cc2	movq	0x10(%rax), %rdx
0000000100001cc6	movq	%rdx, (%rcx)
0000000100001cc9	movq	%rax, %rdi
0000000100001ccc	callq	0x10000964e                     ## symbol stub for: _free
0000000100001cd1	decq	0xad48(%rip)
0000000100001cd8	popq	%rbp
0000000100001cd9	retq
0000000100001cda	callq	_fwp_flush
0000000100001cdf	movq	0x8352(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100001ce6	movq	(%rax), %rdi
0000000100001ce9	leaq	0x7c44(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100001cf0	leaq	0x7c4c(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100001cf7	xorl	%eax, %eax
0000000100001cf9	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100001cfe	movl	$0x65, %edi
0000000100001d03	callq	0x10000961e                     ## symbol stub for: _exit
0000000100001d08	nopl	(%rax,%rax)
_fwp_p_attempt_owned:
0000000100001d10	pushq	%rbp
0000000100001d11	movq	%rsp, %rbp
0000000100001d14	pushq	%r15
0000000100001d16	pushq	%r14
0000000100001d18	pushq	%r12
0000000100001d1a	pushq	%rbx
0000000100001d1b	subq	$0x100, %rsp                    ## imm = 0x100
0000000100001d22	movq	%rdi, %rbx
0000000100001d25	movq	%rsi, -0x28(%rbp)
0000000100001d29	movq	_fwp_handlers(%rip), %rax
0000000100001d30	movq	%rax, -0x80(%rbp)
0000000100001d34	movq	_fwp_state_len(%rip), %rax
0000000100001d3b	movq	%rax, -0x68(%rbp)
0000000100001d3f	movq	_fwp_cleanups(%rip), %rax
0000000100001d46	movq	%rax, -0x60(%rbp)
0000000100001d4a	leaq	-0x118(%rbp), %rdi
0000000100001d51	movq	%rdi, _fwp_handlers(%rip)
0000000100001d58	callq	0x1000096b4                     ## symbol stub for: _setjmp
0000000100001d5d	testl	%eax, %eax
0000000100001d5f	je	0x100001d7e
0000000100001d61	movq	-0x78(%rbp), %rcx
0000000100001d65	movq	-0x68(%rbp), %rax
0000000100001d69	movq	%rax, _fwp_state_len(%rip)
0000000100001d70	movl	$0x1, %edx
0000000100001d75	leaq	_fwp_drop4(%rip), %rax
0000000100001d7c	jmp	0x100001d9c
0000000100001d7e	leaq	-0x28(%rbp), %rsi
0000000100001d82	movq	%rbx, %rdi
0000000100001d85	callq	_fwp_apply_borrowed
0000000100001d8a	xorl	%edx, %edx
0000000100001d8c	leaq	_fwp_drop3(%rip), %rcx
0000000100001d93	movq	%rax, %rsi
0000000100001d96	movq	%rcx, %rax
0000000100001d99	movq	%rsi, %rcx
0000000100001d9c	movl	%edx, %r14d
0000000100001d9f	movq	%rcx, %r12
0000000100001da2	movq	%rcx, -0x40(%rbp)
0000000100001da6	movq	-0x80(%rbp), %rcx
0000000100001daa	movq	%rcx, _fwp_handlers(%rip)
0000000100001db1	movq	%r12, -0x38(%rbp)
0000000100001db5	movq	%rax, -0x30(%rbp)
0000000100001db9	movq	_fwp_cleanups(%rip), %rax
0000000100001dc0	movq	%rax, -0x58(%rbp)
0000000100001dc4	leaq	_fwp_value_release(%rip), %rax
0000000100001dcb	movq	%rax, -0x50(%rbp)
0000000100001dcf	leaq	-0x38(%rbp), %rax
0000000100001dd3	movq	%rax, -0x48(%rbp)
0000000100001dd7	leaq	-0x58(%rbp), %r15
0000000100001ddb	movq	%r15, _fwp_cleanups(%rip)
0000000100001de2	movl	$0x10, %edi
0000000100001de7	callq	_fwp_alloc_init
0000000100001dec	movl	%r14d, (%rax)
0000000100001def	movl	$0x1, 0x4(%rax)
0000000100001df6	movq	%r12, 0x8(%rax)
0000000100001dfa	leaq	-0x40(%rbp), %rcx
0000000100001dfe	movq	%rax, %rdx
0000000100001e01	subq	0xa230(%rip), %rdx
0000000100001e08	movq	0xa251(%rip), %rcx
0000000100001e0f	shlq	$0x10, %rcx
0000000100001e13	cmpq	%rcx, %rdx
0000000100001e16	jae	0x100001e92
0000000100001e18	movq	0xa261(%rip), %rsi
0000000100001e1f	movq	%rdx, %rcx
0000000100001e22	shrq	$0x10, %rcx
0000000100001e26	imulq	$0x1228, %rcx, %rdi             ## imm = 0x1228
0000000100001e2d	leaq	(%rsi,%rdi), %r14
0000000100001e31	movzbl	(%rsi,%rdi), %esi
0000000100001e35	cmpb	$0x2, %sil
0000000100001e39	setne	%dil
0000000100001e3d	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100001e44	setne	%r8b
0000000100001e48	orb	%dil, %r8b
0000000100001e4b	jne	0x100001e60
0000000100001e4d	addq	$0x228, %r14                    ## imm = 0x228
0000000100001e54	cmpb	$-0x1, (%r14)
0000000100001e58	je	0x100001e82
0000000100001e5a	movb	$0x1, (%r14)
0000000100001e5e	jmp	0x100001e92
0000000100001e60	cmpb	$0x1, %sil
0000000100001e64	jne	0x100001e92
0000000100001e66	movl	0x20(%r14), %esi
0000000100001e6a	imulq	%rsi, %rdx
0000000100001e6e	shrq	$0x20, %rdx
0000000100001e72	addq	%rdx, %r14
0000000100001e75	addq	$0x228, %r14                    ## imm = 0x228
0000000100001e7c	cmpb	$-0x1, (%r14)
0000000100001e80	jne	0x100001e5a
0000000100001e82	movq	%r14, %rdi
0000000100001e85	movq	%rax, %r12
0000000100001e88	callq	_fwp_rc_forget_slot
0000000100001e8d	movq	%r12, %rax
0000000100001e90	jmp	0x100001e5a
0000000100001e92	movq	-0x28(%rbp), %rcx
0000000100001e96	cmpq	$0x0, -0x30(%rbp)
0000000100001e9b	je	0x100001eb1
0000000100001e9d	cmpq	%r15, _fwp_cleanups(%rip)
0000000100001ea4	jne	0x100001ec1
0000000100001ea6	movq	-0x58(%rbp), %rcx
0000000100001eaa	movq	%rcx, _fwp_cleanups(%rip)
0000000100001eb1	addq	$0x100, %rsp                    ## imm = 0x100
0000000100001eb8	popq	%rbx
0000000100001eb9	popq	%r12
0000000100001ebb	popq	%r14
0000000100001ebd	popq	%r15
0000000100001ebf	popq	%rbp
0000000100001ec0	retq
0000000100001ec1	callq	0x100009600                     ## symbol stub for: _abort
0000000100001ec6	nopw	%cs:(%rax,%rax)
_fwp_drop3:
0000000100001ed0	pushq	%rbp
0000000100001ed1	movq	%rsp, %rbp
0000000100001ed4	movq	%rdi, %rcx
0000000100001ed7	subq	0xa15a(%rip), %rcx
0000000100001ede	movq	0xa17b(%rip), %rax
0000000100001ee5	shlq	$0x10, %rax
0000000100001ee9	cmpq	%rax, %rcx
0000000100001eec	jae	0x100001f61
0000000100001eee	movq	0xa18b(%rip), %rdx
0000000100001ef5	movq	%rcx, %rax
0000000100001ef8	shrq	$0x10, %rax
0000000100001efc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100001f03	leaq	(%rdx,%rsi), %rax
0000000100001f07	movzbl	(%rdx,%rsi), %edx
0000000100001f0b	cmpb	$0x2, %dl
0000000100001f0e	setne	%sil
0000000100001f12	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100001f19	setne	%r8b
0000000100001f1d	orb	%sil, %r8b
0000000100001f20	jne	0x100001f2a
0000000100001f22	addq	$0x228, %rax                    ## imm = 0x228
0000000100001f28	jmp	0x100001f43
0000000100001f2a	cmpb	$0x1, %dl
0000000100001f2d	jne	0x100001f61
0000000100001f2f	movl	0x20(%rax), %edx
0000000100001f32	imulq	%rdx, %rcx
0000000100001f36	shrq	$0x20, %rcx
0000000100001f3a	addq	%rcx, %rax
0000000100001f3d	addq	$0x228, %rax                    ## imm = 0x228
0000000100001f43	movzbl	(%rax), %ecx
0000000100001f46	testl	%ecx, %ecx
0000000100001f48	je	0x100001f61
0000000100001f4a	cmpl	$0x1, %ecx
0000000100001f4d	jne	0x100001f55
0000000100001f4f	popq	%rbp
0000000100001f50	jmp	_fwp_rc_free_obj
0000000100001f55	cmpl	$0xff, %ecx
0000000100001f5b	je	0x100001f63
0000000100001f5d	decb	%cl
0000000100001f5f	movb	%cl, (%rax)
0000000100001f61	popq	%rbp
0000000100001f62	retq
0000000100001f63	movq	%rax, %rdi
0000000100001f66	popq	%rbp
0000000100001f67	jmp	_fwp_rc_wide_drop
0000000100001f6c	nopl	(%rax)
_fwp_drop4:
0000000100001f70	movq	0xa0c1(%rip), %rcx
0000000100001f77	movq	%rdi, %r8
0000000100001f7a	subq	%rcx, %r8
0000000100001f7d	movq	0xa0dc(%rip), %rsi
0000000100001f84	shlq	$0x10, %rsi
0000000100001f88	cmpq	%rsi, %r8
0000000100001f8b	jae	0x10000205f
0000000100001f91	movq	0xa0e8(%rip), %rdx
0000000100001f98	movq	%r8, %rax
0000000100001f9b	shrq	$0x10, %rax
0000000100001f9f	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100001fa6	leaq	(%rdx,%r9), %rax
0000000100001faa	movzbl	(%rdx,%r9), %r9d
0000000100001faf	cmpb	$0x2, %r9b
0000000100001fb3	setne	%r10b
0000000100001fb7	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100001fbe	setne	%r11b
0000000100001fc2	orb	%r10b, %r11b
0000000100001fc5	jne	0x100001fcf
0000000100001fc7	addq	$0x228, %rax                    ## imm = 0x228
0000000100001fcd	jmp	0x100001fee
0000000100001fcf	cmpb	$0x1, %r9b
0000000100001fd3	jne	0x10000205f
0000000100001fd9	movl	0x20(%rax), %r9d
0000000100001fdd	imulq	%r9, %r8
0000000100001fe1	shrq	$0x20, %r8
0000000100001fe5	addq	%r8, %rax
0000000100001fe8	addq	$0x228, %rax                    ## imm = 0x228
0000000100001fee	movzbl	(%rax), %r8d
0000000100001ff2	testl	%r8d, %r8d
0000000100001ff5	je	0x10000205f
0000000100001ff7	cmpl	$0x1, %r8d
0000000100001ffb	jne	0x10000204c
0000000100001ffd	pushq	%rbp
0000000100001ffe	movq	%rsp, %rbp
0000000100002001	pushq	%rbx
0000000100002002	pushq	%rax
0000000100002003	movq	0x8(%rdi), %rax
0000000100002007	movq	%rax, %r8
000000010000200a	subq	%rcx, %r8
000000010000200d	cmpq	%rsi, %r8
0000000100002010	jae	0x1000020a6
0000000100002016	movq	%r8, %rcx
0000000100002019	shrq	$0x10, %rcx
000000010000201d	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100002024	leaq	(%rdx,%rsi), %rcx
0000000100002028	movzbl	(%rdx,%rsi), %edx
000000010000202c	cmpb	$0x2, %dl
000000010000202f	setne	%sil
0000000100002033	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000203a	setne	%r9b
000000010000203e	orb	%sil, %r9b
0000000100002041	jne	0x100002060
0000000100002043	addq	$0x228, %rcx                    ## imm = 0x228
000000010000204a	jmp	0x10000207a
000000010000204c	cmpl	$0xff, %r8d
0000000100002053	je	0x100002155
0000000100002059	decb	%r8b
000000010000205c	movb	%r8b, (%rax)
000000010000205f	retq
0000000100002060	cmpb	$0x1, %dl
0000000100002063	jne	0x1000020a6
0000000100002065	movl	0x20(%rcx), %edx
0000000100002068	imulq	%rdx, %r8
000000010000206c	shrq	$0x20, %r8
0000000100002070	addq	%r8, %rcx
0000000100002073	addq	$0x228, %rcx                    ## imm = 0x228
000000010000207a	movzbl	(%rcx), %edx
000000010000207d	testl	%edx, %edx
000000010000207f	je	0x1000020a6
0000000100002081	cmpl	$0x1, %edx
0000000100002084	jne	0x100002096
0000000100002086	movq	%rdi, %rbx
0000000100002089	movq	%rax, %rdi
000000010000208c	callq	_fwp_rc_free_obj
0000000100002091	movq	%rbx, %rdi
0000000100002094	jmp	0x1000020a6
0000000100002096	cmpl	$0xff, %edx
000000010000209c	je	0x10000215d
00000001000020a2	decb	%dl
00000001000020a4	movb	%dl, (%rcx)
00000001000020a6	movq	0x10(%rdi), %rax
00000001000020aa	movq	%rax, %rdx
00000001000020ad	subq	0x9f84(%rip), %rdx
00000001000020b4	movq	0x9fa5(%rip), %rcx
00000001000020bb	shlq	$0x10, %rcx
00000001000020bf	cmpq	%rcx, %rdx
00000001000020c2	jae	0x10000214a
00000001000020c8	movq	0x9fb1(%rip), %rsi
00000001000020cf	movq	%rdx, %rcx
00000001000020d2	shrq	$0x10, %rcx
00000001000020d6	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
00000001000020dd	leaq	(%rsi,%r8), %rcx
00000001000020e1	movzbl	(%rsi,%r8), %esi
00000001000020e6	cmpb	$0x2, %sil
00000001000020ea	setne	%r8b
00000001000020ee	andq	$0xffff, %rdx                   ## imm = 0xFFFF
00000001000020f5	setne	%r9b
00000001000020f9	orb	%r8b, %r9b
00000001000020fc	jne	0x100002107
00000001000020fe	addq	$0x228, %rcx                    ## imm = 0x228
0000000100002105	jmp	0x100002122
0000000100002107	cmpb	$0x1, %sil
000000010000210b	jne	0x10000214a
000000010000210d	movl	0x20(%rcx), %esi
0000000100002110	imulq	%rsi, %rdx
0000000100002114	shrq	$0x20, %rdx
0000000100002118	addq	%rdx, %rcx
000000010000211b	addq	$0x228, %rcx                    ## imm = 0x228
0000000100002122	movzbl	(%rcx), %edx
0000000100002125	testl	%edx, %edx
0000000100002127	je	0x10000214a
0000000100002129	cmpl	$0x1, %edx
000000010000212c	jne	0x10000213e
000000010000212e	movq	%rdi, %rbx
0000000100002131	movq	%rax, %rdi
0000000100002134	callq	_fwp_rc_free_obj
0000000100002139	movq	%rbx, %rdi
000000010000213c	jmp	0x10000214a
000000010000213e	cmpl	$0xff, %edx
0000000100002144	je	0x10000216d
0000000100002146	decb	%dl
0000000100002148	movb	%dl, (%rcx)
000000010000214a	addq	$0x8, %rsp
000000010000214e	popq	%rbx
000000010000214f	popq	%rbp
0000000100002150	jmp	_fwp_rc_free_obj
0000000100002155	movq	%rax, %rdi
0000000100002158	jmp	_fwp_rc_wide_drop
000000010000215d	movq	%rdi, %rbx
0000000100002160	movq	%rcx, %rdi
0000000100002163	callq	_fwp_rc_wide_drop
0000000100002168	jmp	0x100002091
000000010000216d	movq	%rdi, %rbx
0000000100002170	movq	%rcx, %rdi
0000000100002173	callq	_fwp_rc_wide_drop
0000000100002178	jmp	0x100002139
000000010000217a	nopw	(%rax,%rax)
_fwp_apply_borrowed:
0000000100002180	pushq	%rbp
0000000100002181	movq	%rsp, %rbp
0000000100002184	pushq	%r15
0000000100002186	pushq	%r14
0000000100002188	pushq	%r13
000000010000218a	pushq	%r12
000000010000218c	pushq	%rbx
000000010000218d	subq	$0xa8, %rsp
0000000100002194	movq	%rsi, %r13
0000000100002197	movq	%rdi, %rbx
000000010000219a	movq	_fwp_fns(%rip), %rcx
00000001000021a1	movl	(%rdi), %edx
00000001000021a3	shlq	$0x5, %rdx
00000001000021a7	movq	0x18(%rcx,%rdx), %rax
00000001000021ac	testq	%rax, %rax
00000001000021af	je	0x100002506
00000001000021b5	leaq	(%rcx,%rdx), %r12
00000001000021b9	leaq	(%rcx,%rdx), %r15
00000001000021bd	addq	$0x18, %r15
00000001000021c1	movl	$0x1, %r8d
00000001000021c7	xorl	%ecx, %ecx
00000001000021c9	nopl	(%rax)
00000001000021d0	testb	$0x1, %cl
00000001000021d3	movl	$0x0, %edx
00000001000021d8	cmovneq	%rbx, %rdx
00000001000021dc	movq	%rdx, -0xc8(%rbp)
00000001000021e3	movq	%r13, -0xc0(%rbp)
00000001000021ea	movq	%rax, -0xb8(%rbp)
00000001000021f1	movl	$0x0, -0xb0(%rbp)
00000001000021fb	movl	0x4(%rbx), %edx
00000001000021fe	movl	%edx, -0xac(%rbp)
0000000100002204	movq	%rbx, %rdx
0000000100002207	subq	0x9e2a(%rip), %rdx
000000010000220e	movl	$0x0, -0xa8(%rbp)
0000000100002218	movq	0x9e41(%rip), %rsi
000000010000221f	shlq	$0x10, %rsi
0000000100002223	cmpq	%rsi, %rdx
0000000100002226	movl	%r8d, -0x2c(%rbp)
000000010000222a	jae	0x100002270
000000010000222c	movq	0x9e4d(%rip), %rsi
0000000100002233	movq	%rdx, %rdi
0000000100002236	shrq	$0x10, %rdi
000000010000223a	imulq	$0x1228, %rdi, %r8              ## imm = 0x1228
0000000100002241	leaq	(%rsi,%r8), %rdi
0000000100002245	movzbl	(%rsi,%r8), %esi
000000010000224a	cmpb	$0x2, %sil
000000010000224e	sete	%r9b
0000000100002252	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100002259	sete	%r8b
000000010000225d	andb	%r9b, %r8b
0000000100002260	cmpb	$0x1, %r8b
0000000100002264	jne	0x100002290
0000000100002266	leaq	0x228(%rdi), %r9
000000010000226d	jmp	0x1000022ac
000000010000226f	nop
0000000100002270	movl	$0x0, -0x30(%rbp)
0000000100002277	testb	$0x1, %cl
000000010000227a	je	0x100002360
0000000100002280	jmp	0x10000236a
0000000100002285	nopw	%cs:(%rax,%rax)
0000000100002290	cmpb	$0x1, %sil
0000000100002294	jne	0x10000230f
0000000100002296	movl	0x20(%rdi), %r9d
000000010000229a	imulq	%rdx, %r9
000000010000229e	shrq	$0x20, %r9
00000001000022a2	addq	%rdi, %r9
00000001000022a5	addq	$0x228, %r9                     ## imm = 0x228
00000001000022ac	cmpb	$0x0, (%r9)
00000001000022b0	setne	%r10b
00000001000022b4	je	0x1000022ee
00000001000022b6	movq	_fwp_cleanups(%rip), %r9
00000001000022bd	movq	%r9, -0xa0(%rbp)
00000001000022c4	leaq	_fwp_apply_release(%rip), %r9
00000001000022cb	movq	%r9, -0x98(%rbp)
00000001000022d2	leaq	-0xc8(%rbp), %r9
00000001000022d9	movq	%r9, -0x90(%rbp)
00000001000022e0	leaq	-0xa0(%rbp), %r9
00000001000022e7	movq	%r9, _fwp_cleanups(%rip)
00000001000022ee	testb	$0x1, %cl
00000001000022f1	movl	%r10d, -0x30(%rbp)
00000001000022f5	je	0x1000022fd
00000001000022f7	movl	-0x2c(%rbp), %r8d
00000001000022fb	jmp	0x10000236a
00000001000022fd	testb	%r8b, %r8b
0000000100002300	je	0x100002321
0000000100002302	addq	$0x228, %rdi                    ## imm = 0x228
0000000100002309	movl	-0x2c(%rbp), %r8d
000000010000230d	jmp	0x100002340
000000010000230f	movl	$0x0, -0x30(%rbp)
0000000100002316	testb	$0x1, %cl
0000000100002319	movl	-0x2c(%rbp), %r8d
000000010000231d	je	0x100002360
000000010000231f	jmp	0x10000236a
0000000100002321	cmpb	$0x1, %sil
0000000100002325	movl	-0x2c(%rbp), %r8d
0000000100002329	jne	0x100002360
000000010000232b	movl	0x20(%rdi), %eax
000000010000232e	imulq	%rax, %rdx
0000000100002332	shrq	$0x20, %rdx
0000000100002336	addq	%rdx, %rdi
0000000100002339	addq	$0x228, %rdi                    ## imm = 0x228
0000000100002340	movzbl	(%rdi), %eax
0000000100002343	testb	%al, %al
0000000100002345	je	0x100002360
0000000100002347	cmpb	$-0x2, %al
0000000100002349	jae	0x1000024f8
000000010000234f	incb	%al
0000000100002351	movb	%al, (%rdi)
0000000100002353	nopw	%cs:(%rax,%rax)
0000000100002360	movq	%rbx, -0xc8(%rbp)
0000000100002367	movq	(%r15), %rax
000000010000236a	movl	(%r12), %r12d
000000010000236e	subl	0x4(%rbx), %r12d
0000000100002372	cmpl	%r12d, %r8d
0000000100002375	movl	%r12d, -0x3c(%rbp)
0000000100002379	cmovbl	%r8d, %r12d
000000010000237d	movq	$0x0, -0x88(%rbp)
0000000100002388	movq	%r13, -0x80(%rbp)
000000010000238c	movq	%rax, -0x78(%rbp)
0000000100002390	movl	$0x0, -0x70(%rbp)
0000000100002397	movl	0x4(%rbx), %ecx
000000010000239a	movl	%ecx, -0x6c(%rbp)
000000010000239d	movl	$0x0, -0x68(%rbp)
00000001000023a4	movl	%r12d, %r14d
00000001000023a7	testl	%r12d, %r12d
00000001000023aa	je	0x100002440
00000001000023b0	movl	%r12d, -0x38(%rbp)
00000001000023b4	cmpq	$0x0, 0x18(%rax)
00000001000023b9	setne	%al
00000001000023bc	movl	%eax, -0x34(%rbp)
00000001000023bf	je	0x1000023ed
00000001000023c1	movq	_fwp_cleanups(%rip), %rax
00000001000023c8	movq	%rax, -0x60(%rbp)
00000001000023cc	leaq	_fwp_apply_release(%rip), %rax
00000001000023d3	movq	%rax, -0x58(%rbp)
00000001000023d7	leaq	-0x88(%rbp), %rax
00000001000023de	movq	%rax, -0x50(%rbp)
00000001000023e2	leaq	-0x60(%rbp), %rax
00000001000023e6	movq	%rax, _fwp_cleanups(%rip)
00000001000023ed	movq	%r13, -0x48(%rbp)
00000001000023f1	xorl	%r12d, %r12d
00000001000023f4	nopw	%cs:(%rax,%rax)
0000000100002400	movq	(%r15), %rax
0000000100002403	movl	0x4(%rbx), %esi
0000000100002406	addl	%r12d, %esi
0000000100002409	movq	%r13, %rdi
000000010000240c	movl	$0x1, %edx
0000000100002411	callq	*0x10(%rax)
0000000100002414	movl	-0x68(%rbp), %eax
0000000100002417	incl	%eax
0000000100002419	movl	%eax, -0x68(%rbp)
000000010000241c	incq	%r12
000000010000241f	addq	$0x8, %r13
0000000100002423	cmpq	%r12, %r14
0000000100002426	jne	0x100002400
0000000100002428	movq	-0x48(%rbp), %r13
000000010000242c	movl	-0x38(%rbp), %r12d
0000000100002430	movl	-0x34(%rbp), %r15d
0000000100002434	jmp	0x100002445
0000000100002436	nopw	%cs:(%rax,%rax)
0000000100002440	xorl	%r15d, %r15d
0000000100002443	xorl	%eax, %eax
0000000100002445	movl	%eax, -0x70(%rbp)
0000000100002448	movq	$0x0, -0xc8(%rbp)
0000000100002453	movl	$0x0, -0xb0(%rbp)
000000010000245d	movq	%rbx, %rdi
0000000100002460	movl	%r12d, %esi
0000000100002463	movq	%r13, %rdx
0000000100002466	callq	_fwp_apply_owned
000000010000246b	movq	%rax, %rbx
000000010000246e	testb	%r15b, %r15b
0000000100002471	movl	-0x2c(%rbp), %r8d
0000000100002475	je	0x100002493
0000000100002477	leaq	-0x60(%rbp), %rax
000000010000247b	cmpq	%rax, _fwp_cleanups(%rip)
0000000100002482	jne	0x10000266b
0000000100002488	movq	-0x60(%rbp), %rax
000000010000248c	movq	%rax, _fwp_cleanups(%rip)
0000000100002493	cmpb	$0x0, -0x30(%rbp)
0000000100002497	je	0x1000024bb
0000000100002499	leaq	-0xa0(%rbp), %rax
00000001000024a0	cmpq	%rax, _fwp_cleanups(%rip)
00000001000024a7	jne	0x10000266b
00000001000024ad	movq	-0xa0(%rbp), %rax
00000001000024b4	movq	%rax, _fwp_cleanups(%rip)
00000001000024bb	cmpl	-0x3c(%rbp), %r8d
00000001000024bf	jbe	0x100002656
00000001000024c5	leaq	(%r13,%r14,8), %r13
00000001000024ca	subl	%r12d, %r8d
00000001000024cd	movq	_fwp_fns(%rip), %rax
00000001000024d4	movl	(%rbx), %ecx
00000001000024d6	shlq	$0x5, %rcx
00000001000024da	leaq	(%rax,%rcx), %r12
00000001000024de	leaq	(%rax,%rcx), %r15
00000001000024e2	addq	$0x18, %r15
00000001000024e6	movq	0x18(%rax,%rcx), %rax
00000001000024eb	movb	$0x1, %cl
00000001000024ed	testq	%rax, %rax
00000001000024f0	jne	0x1000021d0
00000001000024f6	jmp	0x10000250c
00000001000024f8	callq	_fwp_rc_wide_dup
00000001000024fd	movl	-0x2c(%rbp), %r8d
0000000100002501	jmp	0x100002360
0000000100002506	movl	$0x1, %r8d
000000010000250c	movq	0x9b25(%rip), %rax
0000000100002513	movq	%rbx, %rdx
0000000100002516	subq	%rax, %rdx
0000000100002519	movq	0x9b40(%rip), %rcx
0000000100002520	shlq	$0x10, %rcx
0000000100002524	cmpq	%rcx, %rdx
0000000100002527	jae	0x10000259d
0000000100002529	movl	%r8d, %r10d
000000010000252c	movq	0x9b4d(%rip), %rdi
0000000100002533	movq	%rdx, %rsi
0000000100002536	shrq	$0x10, %rsi
000000010000253a	imulq	$0x1228, %rsi, %r8              ## imm = 0x1228
0000000100002541	leaq	(%rdi,%r8), %rsi
0000000100002545	movzbl	(%rdi,%r8), %edi
000000010000254a	cmpb	$0x2, %dil
000000010000254e	setne	%r8b
0000000100002552	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100002559	setne	%r9b
000000010000255d	orb	%r8b, %r9b
0000000100002560	jne	0x100002576
0000000100002562	addq	$0x228, %rsi                    ## imm = 0x228
0000000100002569	movl	%r10d, %r8d
000000010000256c	cmpb	$0x0, (%rsi)
000000010000256f	je	0x10000259d
0000000100002571	jmp	0x100002670
0000000100002576	cmpb	$0x1, %dil
000000010000257a	movl	%r10d, %r8d
000000010000257d	jne	0x10000259d
000000010000257f	movl	0x20(%rsi), %edi
0000000100002582	imulq	%rdi, %rdx
0000000100002586	shrq	$0x20, %rdx
000000010000258a	addq	%rdx, %rsi
000000010000258d	addq	$0x228, %rsi                    ## imm = 0x228
0000000100002594	cmpb	$0x0, (%rsi)
0000000100002597	jne	0x100002670
000000010000259d	movl	%r8d, %esi
00000001000025a0	testl	%r8d, %r8d
00000001000025a3	je	0x100002648
00000001000025a9	movq	0x9ad0(%rip), %rdx
00000001000025b0	movl	%esi, %r15d
00000001000025b3	xorl	%edi, %edi
00000001000025b5	jmp	0x1000025e0
00000001000025b7	nopw	(%rax,%rax)
00000001000025c0	addq	$0x228, %r9                     ## imm = 0x228
00000001000025c7	cmpb	$0x0, (%r9)
00000001000025cb	je	0x100002640
00000001000025cd	jmp	0x100002670
00000001000025d2	nopw	%cs:(%rax,%rax)
00000001000025e0	movq	(%r13,%rdi,8), %r8
00000001000025e5	subq	%rax, %r8
00000001000025e8	cmpq	%rcx, %r8
00000001000025eb	jae	0x100002640
00000001000025ed	movq	%r8, %r9
00000001000025f0	shrq	$0x10, %r9
00000001000025f4	imulq	$0x1228, %r9, %r10              ## imm = 0x1228
00000001000025fb	leaq	(%rdx,%r10), %r9
00000001000025ff	movzbl	(%rdx,%r10), %r10d
0000000100002604	cmpb	$0x2, %r10b
0000000100002608	setne	%r11b
000000010000260c	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100002613	setne	%r14b
0000000100002617	orb	%r11b, %r14b
000000010000261a	je	0x1000025c0
000000010000261c	cmpb	$0x1, %r10b
0000000100002620	jne	0x100002640
0000000100002622	movl	0x20(%r9), %r10d
0000000100002626	imulq	%r10, %r8
000000010000262a	shrq	$0x20, %r8
000000010000262e	addq	%r8, %r9
0000000100002631	addq	$0x228, %r9                     ## imm = 0x228
0000000100002638	cmpb	$0x0, (%r9)
000000010000263c	jne	0x100002670
000000010000263e	nop
0000000100002640	incq	%rdi
0000000100002643	cmpq	%rdi, %r15
0000000100002646	jne	0x1000025e0
0000000100002648	movq	%rbx, %rdi
000000010000264b	movq	%r13, %rdx
000000010000264e	callq	_fwp_apply
0000000100002653	movq	%rax, %rbx
0000000100002656	movq	%rbx, %rax
0000000100002659	addq	$0xa8, %rsp
0000000100002660	popq	%rbx
0000000100002661	popq	%r12
0000000100002663	popq	%r13
0000000100002665	popq	%r14
0000000100002667	popq	%r15
0000000100002669	popq	%rbp
000000010000266a	retq
000000010000266b	callq	0x100009600                     ## symbol stub for: _abort
0000000100002670	callq	_fwp_flush
0000000100002675	movq	0x79bc(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000267c	movq	(%rax), %rdi
000000010000267f	leaq	0x72ae(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002686	leaq	0x727a(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
000000010000268d	xorl	%eax, %eax
000000010000268f	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100002694	movl	$0x65, %edi
0000000100002699	callq	0x10000961e                     ## symbol stub for: _exit
000000010000269e	nop
_fwp_apply:
00000001000026a0	pushq	%rbp
00000001000026a1	movq	%rsp, %rbp
00000001000026a4	pushq	%r15
00000001000026a6	pushq	%r14
00000001000026a8	pushq	%r13
00000001000026aa	pushq	%r12
00000001000026ac	pushq	%rbx
00000001000026ad	subq	$0x38, %rsp
00000001000026b1	movq	%rdx, %rbx
00000001000026b4	movl	%esi, %r8d
00000001000026b7	movq	%rdi, %r15
00000001000026ba	movq	0x796f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000026c1	movq	(%rax), %rax
00000001000026c4	movq	%rax, -0x30(%rbp)
00000001000026c8	jmp	0x1000026ed
00000001000026ca	nopw	(%rax,%rax)
00000001000026d0	leaq	(%rbx,%r14,8), %rbx
00000001000026d4	xorl	%ecx, %ecx
00000001000026d6	movq	%rax, %r15
00000001000026d9	movq	-0x48(%rbp), %r14
00000001000026dd	movq	-0x50(%rbp), %rsp
00000001000026e1	movl	%edx, %r8d
00000001000026e4	cmpl	$0x1, %ecx
00000001000026e7	je	0x100002b96
00000001000026ed	movq	_fwp_fns(%rip), %rax
00000001000026f4	movl	(%r15), %ecx
00000001000026f7	movl	0x4(%r15), %r13d
00000001000026fb	shlq	$0x5, %rcx
00000001000026ff	leaq	(%rax,%rcx), %rdx
0000000100002703	movl	(%rax,%rcx), %r12d
0000000100002707	testq	%r13, %r13
000000010000270a	jne	0x100002750
000000010000270c	leal	-0x1(%r12), %eax
0000000100002711	cmpl	%r8d, %eax
0000000100002714	jae	0x100002750
0000000100002716	movq	%rbx, %rdi
0000000100002719	movq	%r8, %r15
000000010000271c	callq	*0x8(%rdx)
000000010000271f	movq	%r15, %r8
0000000100002722	movq	%rax, %r15
0000000100002725	cmpl	%r12d, %r8d
0000000100002728	je	0x1000029eb
000000010000272e	leaq	(%rbx,%r12,8), %rbx
0000000100002732	subl	%r12d, %r8d
0000000100002735	movl	$0x3, %ecx
000000010000273a	cmpl	$0x1, %ecx
000000010000273d	jne	0x1000026ed
000000010000273f	jmp	0x100002b96
0000000100002744	nopw	%cs:(%rax,%rax)
0000000100002750	movq	%r14, -0x48(%rbp)
0000000100002754	leal	(%r8,%r13), %r14d
0000000100002758	cmpl	%r12d, %r14d
000000010000275b	movq	%r8, -0x40(%rbp)
000000010000275f	jb	0x10000298d
0000000100002765	movq	%rdx, -0x58(%rbp)
0000000100002769	movq	%rsp, -0x50(%rbp)
000000010000276d	movl	%r12d, %r14d
0000000100002770	cmpl	$0x2, %r12d
0000000100002774	movl	$0x1, %eax
0000000100002779	cmovael	%r12d, %eax
000000010000277d	shlq	$0x3, %rax
0000000100002781	callq	0x1000095b8                     ## symbol stub for: ____chkstk_darwin
0000000100002786	addq	$0xf, %rax
000000010000278a	andq	$-0x10, %rax
000000010000278e	subq	%rax, %rsp
0000000100002791	movq	%rsp, %rdi
0000000100002794	testq	%r13, %r13
0000000100002797	je	0x100002870
000000010000279d	cmpl	$0x3, %r13d
00000001000027a1	jbe	0x1000027b3
00000001000027a3	movq	%rdi, %rax
00000001000027a6	subq	%r15, %rax
00000001000027a9	addq	$-0x8, %rax
00000001000027ad	cmpq	$0x20, %rax
00000001000027b1	jae	0x100002822
00000001000027b3	xorl	%eax, %eax
00000001000027b5	movq	%r13, %rdx
00000001000027b8	movq	%rax, %rcx
00000001000027bb	andq	$0x3, %rdx
00000001000027bf	je	0x1000027e1
00000001000027c1	movq	%rax, %rcx
00000001000027c4	nopw	%cs:(%rax,%rax)
00000001000027d0	movq	0x8(%r15,%rcx,8), %rsi
00000001000027d5	movq	%rsi, (%rdi,%rcx,8)
00000001000027d9	incq	%rcx
00000001000027dc	decq	%rdx
00000001000027df	jne	0x1000027d0
00000001000027e1	subq	%r13, %rax
00000001000027e4	cmpq	$-0x4, %rax
00000001000027e8	ja	0x100002870
00000001000027ee	nop
00000001000027f0	movq	0x8(%r15,%rcx,8), %rax
00000001000027f5	movq	%rax, (%rdi,%rcx,8)
00000001000027f9	movq	0x10(%r15,%rcx,8), %rax
00000001000027fe	movq	%rax, 0x8(%rdi,%rcx,8)
0000000100002803	movq	0x18(%r15,%rcx,8), %rax
0000000100002808	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000280d	movq	0x20(%r15,%rcx,8), %rax
0000000100002812	movq	%rax, 0x18(%rdi,%rcx,8)
0000000100002817	addq	$0x4, %rcx
000000010000281b	cmpq	%rcx, %r13
000000010000281e	jne	0x1000027f0
0000000100002820	jmp	0x100002870
0000000100002822	movl	%r13d, %eax
0000000100002825	andl	$-0x4, %eax
0000000100002828	leaq	(,%r13,8), %rcx
0000000100002830	andq	$-0x20, %rcx
0000000100002834	xorl	%edx, %edx
0000000100002836	nopw	%cs:(%rax,%rax)
0000000100002840	movups	0x8(%r15,%rdx), %xmm0
0000000100002846	movups	0x18(%r15,%rdx), %xmm1
000000010000284c	movaps	%xmm0, (%rdi,%rdx)
0000000100002850	movaps	%xmm1, 0x10(%rdi,%rdx)
0000000100002855	addq	$0x20, %rdx
0000000100002859	cmpq	%rdx, %rcx
000000010000285c	jne	0x100002840
000000010000285e	cmpl	%r13d, %eax
0000000100002861	jne	0x1000027b5
0000000100002867	nopw	(%rax,%rax)
0000000100002870	subl	%r13d, %r14d
0000000100002873	movl	%r14d, -0x34(%rbp)
0000000100002877	movl	%r14d, %r14d
000000010000287a	cmpl	%r13d, %r12d
000000010000287d	je	0x100002902
0000000100002883	cmpl	$0xd, -0x34(%rbp)
0000000100002887	ja	0x100002927
000000010000288d	xorl	%eax, %eax
000000010000288f	movq	%r14, %rdx
0000000100002892	movq	%rax, %rcx
0000000100002895	andq	$0x3, %rdx
0000000100002899	je	0x1000028b4
000000010000289b	movq	%rax, %rcx
000000010000289e	nop
00000001000028a0	movq	(%rbx,%rcx,8), %rsi
00000001000028a4	leal	(%rcx,%r13), %r8d
00000001000028a8	movq	%rsi, (%rdi,%r8,8)
00000001000028ac	incq	%rcx
00000001000028af	decq	%rdx
00000001000028b2	jne	0x1000028a0
00000001000028b4	subq	%r14, %rax
00000001000028b7	cmpq	$-0x4, %rax
00000001000028bb	ja	0x100002902
00000001000028bd	nopl	(%rax)
00000001000028c0	movq	(%rbx,%rcx,8), %rax
00000001000028c4	leal	(%rcx,%r13), %edx
00000001000028c8	movq	%rax, (%rdi,%rdx,8)
00000001000028cc	movq	0x8(%rbx,%rcx,8), %rax
00000001000028d1	leal	(%rcx,%r13), %edx
00000001000028d5	incl	%edx
00000001000028d7	movq	%rax, (%rdi,%rdx,8)
00000001000028db	movq	0x10(%rbx,%rcx,8), %rax
00000001000028e0	leal	0x2(%r13,%rcx), %edx
00000001000028e5	movq	%rax, (%rdi,%rdx,8)
00000001000028e9	movq	0x18(%rbx,%rcx,8), %rax
00000001000028ee	leal	(%rcx,%r13), %edx
00000001000028f2	addl	$0x3, %edx
00000001000028f5	movq	%rax, (%rdi,%rdx,8)
00000001000028f9	addq	$0x4, %rcx
00000001000028fd	cmpq	%rcx, %r14
0000000100002900	jne	0x1000028c0
0000000100002902	movq	-0x58(%rbp), %rax
0000000100002906	callq	*0x8(%rax)
0000000100002909	movl	$0x1, %ecx
000000010000290e	movq	-0x40(%rbp), %rsi
0000000100002912	movl	%esi, %edx
0000000100002914	subl	-0x34(%rbp), %edx
0000000100002917	jne	0x1000026d0
000000010000291d	movl	%esi, %edx
000000010000291f	movq	%rax, %r14
0000000100002922	jmp	0x1000026dd
0000000100002927	leaq	-0x1(%r14), %rax
000000010000292b	movl	%eax, %ecx
000000010000292d	addl	%r13d, %ecx
0000000100002930	jb	0x10000288d
0000000100002936	shrq	$0x20, %rax
000000010000293a	movl	$0x0, %eax
000000010000293f	jne	0x10000288f
0000000100002945	leaq	(%rdi,%r13,8), %rax
0000000100002949	subq	%rbx, %rax
000000010000294c	cmpq	$0x20, %rax
0000000100002950	jb	0x10000288d
0000000100002956	movl	%r14d, %eax
0000000100002959	andl	$-0x4, %eax
000000010000295c	xorl	%ecx, %ecx
000000010000295e	nop
0000000100002960	movups	(%rbx,%rcx,8), %xmm0
0000000100002964	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100002969	leal	(%rcx,%r13), %edx
000000010000296d	movups	%xmm0, (%rdi,%rdx,8)
0000000100002971	movups	%xmm1, 0x10(%rdi,%rdx,8)
0000000100002976	addq	$0x4, %rcx
000000010000297a	cmpq	%rcx, %rax
000000010000297d	jne	0x100002960
000000010000297f	cmpl	%r14d, %eax
0000000100002982	jne	0x10000288f
0000000100002988	jmp	0x100002902
000000010000298d	movl	%r14d, %eax
0000000100002990	cmpl	$0x7ff, %r14d                   ## imm = 0x7FF
0000000100002997	ja	0x100002a03
0000000100002999	leaq	(,%rax,8), %rdx
00000001000029a1	addq	$0x17, %rdx
00000001000029a5	shrq	$0x4, %rdx
00000001000029a9	leaq	_fwp_gc(%rip), %rcx
00000001000029b0	movzbl	0xbe8(%rdx,%rcx), %edx
00000001000029b8	movl	0xb48(%rcx,%rdx,4), %esi
00000001000029bf	subq	%rsi, _fwp_gc(%rip)
00000001000029c6	js	0x100002a03
00000001000029c8	leaq	(%rdx,%rdx,2), %rdx
00000001000029cc	leaq	(%rcx,%rdx,8), %rcx
00000001000029d0	addq	$0x788, %rcx                    ## imm = 0x788
00000001000029d7	movq	(%rcx), %r12
00000001000029da	testq	%r12, %r12
00000001000029dd	je	0x1000029f3
00000001000029df	movq	(%r12), %rax
00000001000029e3	notq	%rax
00000001000029e6	movq	%rax, (%rcx)
00000001000029e9	jmp	0x100002a22
00000001000029eb	movq	%r15, %r14
00000001000029ee	jmp	0x100002b96
00000001000029f3	movq	0x8(%rcx), %r12
00000001000029f7	movq	0x10(%rcx), %rdx
00000001000029fb	subq	%r12, %rdx
00000001000029fe	cmpq	%rsi, %rdx
0000000100002a01	jae	0x100002a1a
0000000100002a03	leaq	0x8(,%rax,8), %rdi
0000000100002a0b	movl	$0x2, %esi
0000000100002a10	callq	_fwp_gc_alloc_slow
0000000100002a15	movq	%rax, %r12
0000000100002a18	jmp	0x100002a2a
0000000100002a1a	leaq	(%r12,%rsi), %rax
0000000100002a1e	movq	%rax, 0x8(%rcx)
0000000100002a22	movq	%r12, %rdi
0000000100002a25	callq	0x1000095be                     ## symbol stub for: ___bzero
0000000100002a2a	movl	(%r15), %eax
0000000100002a2d	movl	%eax, (%r12)
0000000100002a31	movl	%r14d, 0x4(%r12)
0000000100002a36	testq	%r13, %r13
0000000100002a39	movq	%r12, %r14
0000000100002a3c	movq	-0x40(%rbp), %rdi
0000000100002a40	je	0x100002b01
0000000100002a46	xorl	%eax, %eax
0000000100002a48	cmpl	$0x6, %r13d
0000000100002a4c	jb	0x100002a96
0000000100002a4e	movq	%r14, %rcx
0000000100002a51	subq	%r15, %rcx
0000000100002a54	cmpq	$0x1f, %rcx
0000000100002a58	jbe	0x100002a96
0000000100002a5a	movl	%r13d, %eax
0000000100002a5d	andl	$-0x4, %eax
0000000100002a60	leaq	(,%r13,8), %rcx
0000000100002a68	andq	$-0x20, %rcx
0000000100002a6c	xorl	%edx, %edx
0000000100002a6e	nop
0000000100002a70	movups	0x8(%r15,%rdx), %xmm0
0000000100002a76	movups	0x18(%r15,%rdx), %xmm1
0000000100002a7c	movups	%xmm0, 0x8(%r14,%rdx)
0000000100002a82	movups	%xmm1, 0x18(%r14,%rdx)
0000000100002a88	addq	$0x20, %rdx
0000000100002a8c	cmpq	%rdx, %rcx
0000000100002a8f	jne	0x100002a70
0000000100002a91	cmpl	%r13d, %eax
0000000100002a94	je	0x100002b01
0000000100002a96	movq	%r13, %rdx
0000000100002a99	movq	%rax, %rcx
0000000100002a9c	andq	$0x3, %rdx
0000000100002aa0	je	0x100002ac2
0000000100002aa2	movq	%rax, %rcx
0000000100002aa5	nopw	%cs:(%rax,%rax)
0000000100002ab0	movq	0x8(%r15,%rcx,8), %rsi
0000000100002ab5	movq	%rsi, 0x8(%r14,%rcx,8)
0000000100002aba	incq	%rcx
0000000100002abd	decq	%rdx
0000000100002ac0	jne	0x100002ab0
0000000100002ac2	subq	%r13, %rax
0000000100002ac5	cmpq	$-0x4, %rax
0000000100002ac9	ja	0x100002b01
0000000100002acb	nopl	(%rax,%rax)
0000000100002ad0	movq	0x8(%r15,%rcx,8), %rax
0000000100002ad5	movq	%rax, 0x8(%r14,%rcx,8)
0000000100002ada	movq	0x10(%r15,%rcx,8), %rax
0000000100002adf	movq	%rax, 0x10(%r14,%rcx,8)
0000000100002ae4	movq	0x18(%r15,%rcx,8), %rax
0000000100002ae9	movq	%rax, 0x18(%r14,%rcx,8)
0000000100002aee	movq	0x20(%r15,%rcx,8), %rax
0000000100002af3	movq	%rax, 0x20(%r14,%rcx,8)
0000000100002af8	addq	$0x4, %rcx
0000000100002afc	cmpq	%rcx, %r13
0000000100002aff	jne	0x100002ad0
0000000100002b01	testl	%edi, %edi
0000000100002b03	je	0x100002b96
0000000100002b09	movl	%edi, %eax
0000000100002b0b	cmpl	$0x13, %edi
0000000100002b0e	ja	0x100002bb8
0000000100002b14	xorl	%ecx, %ecx
0000000100002b16	movq	%rax, %rsi
0000000100002b19	movq	%rcx, %rdx
0000000100002b1c	andq	$0x3, %rsi
0000000100002b20	je	0x100002b45
0000000100002b22	movq	%rcx, %rdx
0000000100002b25	nopw	%cs:(%rax,%rax)
0000000100002b30	movq	(%rbx,%rdx,8), %rdi
0000000100002b34	leal	(%rdx,%r13), %r8d
0000000100002b38	movq	%rdi, 0x8(%r14,%r8,8)
0000000100002b3d	incq	%rdx
0000000100002b40	decq	%rsi
0000000100002b43	jne	0x100002b30
0000000100002b45	subq	%rax, %rcx
0000000100002b48	cmpq	$-0x4, %rcx
0000000100002b4c	ja	0x100002b96
0000000100002b4e	nop
0000000100002b50	movq	(%rbx,%rdx,8), %rcx
0000000100002b54	leal	(%rdx,%r13), %esi
0000000100002b58	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002b5d	movq	0x8(%rbx,%rdx,8), %rcx
0000000100002b62	leal	(%rdx,%r13), %esi
0000000100002b66	incl	%esi
0000000100002b68	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002b6d	movq	0x10(%rbx,%rdx,8), %rcx
0000000100002b72	leal	0x2(%r13,%rdx), %esi
0000000100002b77	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002b7c	movq	0x18(%rbx,%rdx,8), %rcx
0000000100002b81	leal	(%rdx,%r13), %esi
0000000100002b85	addl	$0x3, %esi
0000000100002b88	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100002b8d	addq	$0x4, %rdx
0000000100002b91	cmpq	%rdx, %rax
0000000100002b94	jne	0x100002b50
0000000100002b96	movq	0x7493(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100002b9d	movq	(%rax), %rax
0000000100002ba0	cmpq	-0x30(%rbp), %rax
0000000100002ba4	jne	0x100002c1f
0000000100002ba6	movq	%r14, %rax
0000000100002ba9	leaq	-0x28(%rbp), %rsp
0000000100002bad	popq	%rbx
0000000100002bae	popq	%r12
0000000100002bb0	popq	%r13
0000000100002bb2	popq	%r14
0000000100002bb4	popq	%r15
0000000100002bb6	popq	%rbp
0000000100002bb7	retq
0000000100002bb8	leaq	-0x1(%rax), %rdx
0000000100002bbc	xorl	%ecx, %ecx
0000000100002bbe	movl	%edx, %esi
0000000100002bc0	addl	%r13d, %esi
0000000100002bc3	jb	0x100002b16
0000000100002bc9	shrq	$0x20, %rdx
0000000100002bcd	jne	0x100002b16
0000000100002bd3	leaq	(%r14,%r13,8), %rcx
0000000100002bd7	subq	%rbx, %rcx
0000000100002bda	addq	$0x8, %rcx
0000000100002bde	cmpq	$0x20, %rcx
0000000100002be2	jb	0x100002b14
0000000100002be8	movl	%eax, %ecx
0000000100002bea	andl	$-0x4, %ecx
0000000100002bed	xorl	%edx, %edx
0000000100002bef	nop
0000000100002bf0	movups	(%rbx,%rdx,8), %xmm0
0000000100002bf4	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100002bf9	leal	(%rdx,%r13), %esi
0000000100002bfd	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100002c03	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100002c09	addq	$0x4, %rdx
0000000100002c0d	cmpq	%rdx, %rcx
0000000100002c10	jne	0x100002bf0
0000000100002c12	cmpl	%eax, %ecx
0000000100002c14	jne	0x100002b16
0000000100002c1a	jmp	0x100002b96
0000000100002c1f	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100002c24	nopw	%cs:(%rax,%rax)
_fwp_apply_release:
0000000100002c30	pushq	%rbp
0000000100002c31	movq	%rsp, %rbp
0000000100002c34	pushq	%r14
0000000100002c36	pushq	%rbx
0000000100002c37	movq	(%rdi), %rbx
0000000100002c3a	movq	$0x0, (%rdi)
0000000100002c41	movl	0x20(%rdi), %eax
0000000100002c44	movl	0x18(%rdi), %ecx
0000000100002c47	movl	%eax, %edx
0000000100002c49	subl	%ecx, %edx
0000000100002c4b	je	0x100002c7a
0000000100002c4d	movq	0x10(%rdi), %rsi
0000000100002c51	movq	0x18(%rsi), %r8
0000000100002c55	testq	%r8, %r8
0000000100002c58	je	0x100002c7a
0000000100002c5a	movq	%rcx, %rax
0000000100002c5d	shlq	$0x3, %rax
0000000100002c61	addq	0x8(%rdi), %rax
0000000100002c65	movl	0x1c(%rdi), %esi
0000000100002c68	addl	%ecx, %esi
0000000100002c6a	movq	%rdi, %r14
0000000100002c6d	movq	%rax, %rdi
0000000100002c70	callq	*%r8
0000000100002c73	movq	%r14, %rdi
0000000100002c76	movl	0x20(%r14), %eax
0000000100002c7a	movl	%eax, 0x18(%rdi)
0000000100002c7d	testq	%rbx, %rbx
0000000100002c80	je	0x100002c8e
0000000100002c82	movq	%rbx, %rdi
0000000100002c85	popq	%rbx
0000000100002c86	popq	%r14
0000000100002c88	popq	%rbp
0000000100002c89	jmp	_fwp_closure_drop
0000000100002c8e	popq	%rbx
0000000100002c8f	popq	%r14
0000000100002c91	popq	%rbp
0000000100002c92	retq
0000000100002c93	nopw	%cs:(%rax,%rax)
_fwp_apply_owned:
0000000100002ca0	pushq	%rbp
0000000100002ca1	movq	%rsp, %rbp
0000000100002ca4	pushq	%r15
0000000100002ca6	pushq	%r14
0000000100002ca8	pushq	%r13
0000000100002caa	pushq	%r12
0000000100002cac	pushq	%rbx
0000000100002cad	subq	$0xa8, %rsp
0000000100002cb4	movq	%rdx, %rbx
0000000100002cb7	movl	%esi, %r13d
0000000100002cba	movq	0x736f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100002cc1	movq	(%rax), %rax
0000000100002cc4	movq	%rax, -0x30(%rbp)
0000000100002cc8	movq	_fwp_fns(%rip), %rdx
0000000100002ccf	movl	(%rdi), %esi
0000000100002cd1	shlq	$0x5, %rsi
0000000100002cd5	movq	0x18(%rdx,%rsi), %rax
0000000100002cda	testq	%rax, %rax
0000000100002cdd	je	0x1000030f5
0000000100002ce3	leaq	(%rdx,%rsi), %rcx
0000000100002ce7	addq	%rdx, %rsi
0000000100002cea	addq	$0x18, %rsi
0000000100002cee	movq	%rdi, %r12
0000000100002cf1	nopw	%cs:(%rax,%rax)
0000000100002d00	movq	%rsi, -0x58(%rbp)
0000000100002d04	movl	(%rcx), %r15d
0000000100002d07	movl	0x4(%r12), %r14d
0000000100002d0c	movq	%rdi, -0xb0(%rbp)
0000000100002d13	movq	%rbx, -0xa8(%rbp)
0000000100002d1a	movq	%rax, -0xa0(%rbp)
0000000100002d21	movl	$0x0, -0x98(%rbp)
0000000100002d2b	movl	%r14d, -0x94(%rbp)
0000000100002d32	movq	%rdi, %rcx
0000000100002d35	subq	0x92fc(%rip), %rcx
0000000100002d3c	movl	%r13d, -0x90(%rbp)
0000000100002d43	movq	0x9316(%rip), %rdx
0000000100002d4a	shlq	$0x10, %rdx
0000000100002d4e	cmpq	%rdx, %rcx
0000000100002d51	jae	0x100002dc0
0000000100002d53	movq	0x9326(%rip), %rsi
0000000100002d5a	movq	%rcx, %rdx
0000000100002d5d	shrq	$0x10, %rdx
0000000100002d61	imulq	$0x1228, %rdx, %r8              ## imm = 0x1228
0000000100002d68	leaq	(%rsi,%r8), %rdx
0000000100002d6c	movzbl	(%rsi,%r8), %esi
0000000100002d71	cmpb	$0x2, %sil
0000000100002d75	setne	%r9b
0000000100002d79	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100002d80	setne	%r8b
0000000100002d84	orb	%r9b, %r8b
0000000100002d87	jne	0x100002da0
0000000100002d89	addq	$0x228, %rdx                    ## imm = 0x228
0000000100002d90	cmpb	$0x0, (%rdx)
0000000100002d93	jne	0x100002de0
0000000100002d95	jmp	0x100002dc0
0000000100002d97	nopw	(%rax,%rax)
0000000100002da0	cmpb	$0x1, %sil
0000000100002da4	jne	0x100002dc0
0000000100002da6	movl	0x20(%rdx), %esi
0000000100002da9	imulq	%rsi, %rcx
0000000100002dad	shrq	$0x20, %rcx
0000000100002db1	addq	%rcx, %rdx
0000000100002db4	addq	$0x228, %rdx                    ## imm = 0x228
0000000100002dbb	cmpb	$0x0, (%rdx)
0000000100002dbe	jne	0x100002de0
0000000100002dc0	cmpq	$0x0, 0x18(%rax)
0000000100002dc5	je	0x100002dd1
0000000100002dc7	testq	%r14, %r14
0000000100002dca	jne	0x100002de0
0000000100002dcc	cmpl	%r15d, %r13d
0000000100002dcf	jne	0x100002de0
0000000100002dd1	xorl	%ecx, %ecx
0000000100002dd3	jmp	0x100002e0e
0000000100002dd5	nopw	%cs:(%rax,%rax)
0000000100002de0	movq	_fwp_cleanups(%rip), %rcx
0000000100002de7	movq	%rcx, -0x80(%rbp)
0000000100002deb	leaq	_fwp_apply_release(%rip), %rcx
0000000100002df2	movq	%rcx, -0x78(%rbp)
0000000100002df6	leaq	-0xb0(%rbp), %rcx
0000000100002dfd	movq	%rcx, -0x70(%rbp)
0000000100002e01	leaq	-0x80(%rbp), %rcx
0000000100002e05	movq	%rcx, _fwp_cleanups(%rip)
0000000100002e0c	movb	$0x1, %cl
0000000100002e0e	movq	%r13, -0x50(%rbp)
0000000100002e12	addl	%r14d, %r13d
0000000100002e15	cmpl	%r15d, %r13d
0000000100002e18	movq	%rdi, -0x40(%rbp)
0000000100002e1c	movl	%ecx, -0x44(%rbp)
0000000100002e1f	jb	0x100003168
0000000100002e25	movl	%r15d, %ecx
0000000100002e28	subl	%r14d, %ecx
0000000100002e2b	movl	%ecx, -0x34(%rbp)
0000000100002e2e	movl	%ecx, %ecx
0000000100002e30	movq	%rcx, -0x60(%rbp)
0000000100002e34	testq	%r14, %r14
0000000100002e37	jne	0x100002e60
0000000100002e39	testl	%r15d, %r15d
0000000100002e3c	je	0x100002e60
0000000100002e3e	movl	-0x34(%rbp), %ecx
0000000100002e41	movl	%ecx, -0x98(%rbp)
0000000100002e47	movq	%rbx, %rdi
0000000100002e4a	callq	*(%rax)
0000000100002e4c	movq	%rax, %r12
0000000100002e4f	movq	-0x60(%rbp), %r15
0000000100002e53	jmp	0x10000308a
0000000100002e58	nopl	(%rax,%rax)
0000000100002e60	movq	%rsp, -0x88(%rbp)
0000000100002e67	testl	%r15d, %r15d
0000000100002e6a	movl	$0x1, %eax
0000000100002e6f	cmovnel	%r15d, %eax
0000000100002e73	shlq	$0x3, %rax
0000000100002e77	callq	0x1000095b8                     ## symbol stub for: ____chkstk_darwin
0000000100002e7c	addq	$0xf, %rax
0000000100002e80	andq	$-0x10, %rax
0000000100002e84	subq	%rax, %rsp
0000000100002e87	movq	%rsp, %r13
0000000100002e8a	testq	%r14, %r14
0000000100002e8d	movq	-0x40(%rbp), %rdi
0000000100002e91	je	0x100002f60
0000000100002e97	cmpl	$0x3, %r14d
0000000100002e9b	jbe	0x100002ead
0000000100002e9d	movq	%r13, %rax
0000000100002ea0	subq	%r12, %rax
0000000100002ea3	addq	$-0x8, %rax
0000000100002ea7	cmpq	$0x20, %rax
0000000100002eab	jae	0x100002f13
0000000100002ead	xorl	%eax, %eax
0000000100002eaf	movq	%r14, %rdx
0000000100002eb2	movq	%rax, %rcx
0000000100002eb5	andq	$0x3, %rdx
0000000100002eb9	je	0x100002ed2
0000000100002ebb	movq	%rax, %rcx
0000000100002ebe	nop
0000000100002ec0	movq	0x8(%r12,%rcx,8), %rsi
0000000100002ec5	movq	%rsi, (%r13,%rcx,8)
0000000100002eca	incq	%rcx
0000000100002ecd	decq	%rdx
0000000100002ed0	jne	0x100002ec0
0000000100002ed2	subq	%r14, %rax
0000000100002ed5	cmpq	$-0x4, %rax
0000000100002ed9	ja	0x100002f60
0000000100002edf	nop
0000000100002ee0	movq	0x8(%r12,%rcx,8), %rax
0000000100002ee5	movq	%rax, (%r13,%rcx,8)
0000000100002eea	movq	0x10(%r12,%rcx,8), %rax
0000000100002eef	movq	%rax, 0x8(%r13,%rcx,8)
0000000100002ef4	movq	0x18(%r12,%rcx,8), %rax
0000000100002ef9	movq	%rax, 0x10(%r13,%rcx,8)
0000000100002efe	movq	0x20(%r12,%rcx,8), %rax
0000000100002f03	movq	%rax, 0x18(%r13,%rcx,8)
0000000100002f08	addq	$0x4, %rcx
0000000100002f0c	cmpq	%rcx, %r14
0000000100002f0f	jne	0x100002ee0
0000000100002f11	jmp	0x100002f60
0000000100002f13	movl	%r14d, %eax
0000000100002f16	andl	$-0x4, %eax
0000000100002f19	leaq	(,%r14,8), %rcx
0000000100002f21	andq	$-0x20, %rcx
0000000100002f25	xorl	%edx, %edx
0000000100002f27	nopw	(%rax,%rax)
0000000100002f30	movups	0x8(%r12,%rdx), %xmm0
0000000100002f36	movups	0x18(%r12,%rdx), %xmm1
0000000100002f3c	movaps	%xmm0, (%r13,%rdx)
0000000100002f42	movaps	%xmm1, 0x10(%r13,%rdx)
0000000100002f48	addq	$0x20, %rdx
0000000100002f4c	cmpq	%rdx, %rcx
0000000100002f4f	jne	0x100002f30
0000000100002f51	cmpl	%r14d, %eax
0000000100002f54	jne	0x100002eaf
0000000100002f5a	nopw	(%rax,%rax)
0000000100002f60	cmpl	%r14d, %r15d
0000000100002f63	movq	-0x60(%rbp), %r15
0000000100002f67	je	0x100003060
0000000100002f6d	cmpl	$0x9, -0x34(%rbp)
0000000100002f71	ja	0x100003008
0000000100002f77	xorl	%eax, %eax
0000000100002f79	movq	%r15, %rdx
0000000100002f7c	movq	%rax, %rcx
0000000100002f7f	andq	$0x3, %rdx
0000000100002f83	je	0x100002fa5
0000000100002f85	movq	%rax, %rcx
0000000100002f88	nopl	(%rax,%rax)
0000000100002f90	movq	(%rbx,%rcx,8), %rsi
0000000100002f94	leal	(%r14,%rcx), %r8d
0000000100002f98	movq	%rsi, (%r13,%r8,8)
0000000100002f9d	incq	%rcx
0000000100002fa0	decq	%rdx
0000000100002fa3	jne	0x100002f90
0000000100002fa5	subq	%r15, %rax
0000000100002fa8	cmpq	$-0x4, %rax
0000000100002fac	ja	0x100003060
0000000100002fb2	nopw	%cs:(%rax,%rax)
0000000100002fc0	movq	(%rbx,%rcx,8), %rax
0000000100002fc4	leal	(%r14,%rcx), %edx
0000000100002fc8	movq	%rax, (%r13,%rdx,8)
0000000100002fcd	movq	0x8(%rbx,%rcx,8), %rax
0000000100002fd2	leal	(%r14,%rcx), %edx
0000000100002fd6	incl	%edx
0000000100002fd8	movq	%rax, (%r13,%rdx,8)
0000000100002fdd	movq	0x10(%rbx,%rcx,8), %rax
0000000100002fe2	leal	0x2(%r14,%rcx), %edx
0000000100002fe7	movq	%rax, (%r13,%rdx,8)
0000000100002fec	movq	0x18(%rbx,%rcx,8), %rax
0000000100002ff1	leal	(%r14,%rcx), %edx
0000000100002ff5	addl	$0x3, %edx
0000000100002ff8	movq	%rax, (%r13,%rdx,8)
0000000100002ffd	addq	$0x4, %rcx
0000000100003001	cmpq	%rcx, %r15
0000000100003004	jne	0x100002fc0
0000000100003006	jmp	0x100003060
0000000100003008	leaq	-0x1(%r15), %rax
000000010000300c	movl	%eax, %ecx
000000010000300e	addl	%r14d, %ecx
0000000100003011	jb	0x100002f77
0000000100003017	shrq	$0x20, %rax
000000010000301b	movl	$0x0, %eax
0000000100003020	jne	0x100002f79
0000000100003026	movl	%r15d, %eax
0000000100003029	andl	$-0x4, %eax
000000010000302c	xorl	%ecx, %ecx
000000010000302e	nop
0000000100003030	movups	(%rbx,%rcx,8), %xmm0
0000000100003034	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100003039	leal	(%r14,%rcx), %edx
000000010000303d	movups	%xmm0, (%r13,%rdx,8)
0000000100003043	movups	%xmm1, 0x10(%r13,%rdx,8)
0000000100003049	addq	$0x4, %rcx
000000010000304d	cmpq	%rcx, %rax
0000000100003050	jne	0x100003030
0000000100003052	cmpl	%r15d, %eax
0000000100003055	jne	0x100002f79
000000010000305b	nopl	(%rax,%rax)
0000000100003060	movq	-0x58(%rbp), %r14
0000000100003064	movq	(%r14), %rax
0000000100003067	movl	$0x1, %esi
000000010000306c	callq	*0x8(%rax)
000000010000306f	movl	-0x34(%rbp), %eax
0000000100003072	movl	%eax, -0x98(%rbp)
0000000100003078	movq	(%r14), %rax
000000010000307b	movq	%r13, %rdi
000000010000307e	callq	*(%rax)
0000000100003080	movq	%rax, %r12
0000000100003083	movq	-0x88(%rbp), %rsp
000000010000308a	cmpb	$0x0, -0x44(%rbp)
000000010000308e	movq	-0x50(%rbp), %r13
0000000100003092	movq	-0x40(%rbp), %rdi
0000000100003096	je	0x1000030b4
0000000100003098	leaq	-0x80(%rbp), %rax
000000010000309c	cmpq	%rax, _fwp_cleanups(%rip)
00000001000030a3	jne	0x100003654
00000001000030a9	movq	-0x80(%rbp), %rax
00000001000030ad	movq	%rax, _fwp_cleanups(%rip)
00000001000030b4	callq	_fwp_closure_drop
00000001000030b9	subl	-0x34(%rbp), %r13d
00000001000030bd	je	0x100003632
00000001000030c3	leaq	(%rbx,%r15,8), %rbx
00000001000030c7	movq	_fwp_fns(%rip), %rax
00000001000030ce	movl	(%r12), %edx
00000001000030d2	shlq	$0x5, %rdx
00000001000030d6	leaq	(%rax,%rdx), %rcx
00000001000030da	leaq	(%rax,%rdx), %rsi
00000001000030de	addq	$0x18, %rsi
00000001000030e2	movq	0x18(%rax,%rdx), %rax
00000001000030e7	movq	%r12, %rdi
00000001000030ea	testq	%rax, %rax
00000001000030ed	jne	0x100002d00
00000001000030f3	jmp	0x1000030f8
00000001000030f5	movq	%rdi, %r12
00000001000030f8	movq	0x8f39(%rip), %rax
00000001000030ff	movq	%r12, %rdx
0000000100003102	subq	%rax, %rdx
0000000100003105	movq	0x8f54(%rip), %rcx
000000010000310c	shlq	$0x10, %rcx
0000000100003110	cmpq	%rcx, %rdx
0000000100003113	jae	0x10000321e
0000000100003119	movq	0x8f60(%rip), %rdi
0000000100003120	movq	%rdx, %rsi
0000000100003123	shrq	$0x10, %rsi
0000000100003127	imulq	$0x1228, %rsi, %r8              ## imm = 0x1228
000000010000312e	leaq	(%rdi,%r8), %rsi
0000000100003132	movzbl	(%rdi,%r8), %edi
0000000100003137	cmpb	$0x2, %dil
000000010000313b	setne	%r8b
000000010000313f	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100003146	setne	%r9b
000000010000314a	orb	%r8b, %r9b
000000010000314d	jne	0x1000031fa
0000000100003153	addq	$0x228, %rsi                    ## imm = 0x228
000000010000315a	cmpb	$0x0, (%rsi)
000000010000315d	je	0x10000321e
0000000100003163	jmp	0x1000032b6
0000000100003168	movl	%r13d, %eax
000000010000316b	leaq	0x8(,%rax,8), %rdi
0000000100003173	callq	_fwp_alloc_init
0000000100003178	movq	-0x40(%rbp), %rdi
000000010000317c	movq	%rax, %r15
000000010000317f	movl	(%r12), %eax
0000000100003183	movl	%eax, (%r15)
0000000100003186	movl	%r13d, 0x4(%r15)
000000010000318a	movq	%r15, %rax
000000010000318d	subq	0x8ea4(%rip), %rax
0000000100003194	movq	0x8ec5(%rip), %rcx
000000010000319b	shlq	$0x10, %rcx
000000010000319f	cmpq	%rcx, %rax
00000001000031a2	jae	0x100003331
00000001000031a8	movq	0x8ed1(%rip), %rcx
00000001000031af	movq	%rax, %rdx
00000001000031b2	shrq	$0x10, %rdx
00000001000031b6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000031bd	leaq	(%rcx,%rdx), %r13
00000001000031c1	movzbl	(%rcx,%rdx), %ecx
00000001000031c5	cmpb	$0x2, %cl
00000001000031c8	setne	%dl
00000001000031cb	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000031d1	setne	%sil
00000001000031d5	orb	%dl, %sil
00000001000031d8	jne	0x1000032fa
00000001000031de	addq	$0x228, %r13                    ## imm = 0x228
00000001000031e5	cmpb	$-0x1, (%r13)
00000001000031ea	je	0x100003320
00000001000031f0	movb	$0x1, (%r13)
00000001000031f5	jmp	0x100003331
00000001000031fa	cmpb	$0x1, %dil
00000001000031fe	jne	0x10000321e
0000000100003200	movl	0x20(%rsi), %edi
0000000100003203	imulq	%rdi, %rdx
0000000100003207	shrq	$0x20, %rdx
000000010000320b	addq	%rdx, %rsi
000000010000320e	addq	$0x228, %rsi                    ## imm = 0x228
0000000100003215	cmpb	$0x0, (%rsi)
0000000100003218	jne	0x1000032b6
000000010000321e	testl	%r13d, %r13d
0000000100003221	je	0x1000032e4
0000000100003227	movq	0x8e52(%rip), %rdx
000000010000322e	movl	%r13d, %esi
0000000100003231	xorl	%edi, %edi
0000000100003233	jmp	0x100003259
0000000100003235	nopw	%cs:(%rax,%rax)
0000000100003240	addq	$0x228, %r9                     ## imm = 0x228
0000000100003247	cmpb	$0x0, (%r9)
000000010000324b	jne	0x1000032b6
000000010000324d	incq	%rdi
0000000100003250	cmpq	%rdi, %rsi
0000000100003253	je	0x1000032e4
0000000100003259	movq	(%rbx,%rdi,8), %r8
000000010000325d	subq	%rax, %r8
0000000100003260	cmpq	%rcx, %r8
0000000100003263	jae	0x10000324d
0000000100003265	movq	%r8, %r9
0000000100003268	shrq	$0x10, %r9
000000010000326c	imulq	$0x1228, %r9, %r10              ## imm = 0x1228
0000000100003273	leaq	(%rdx,%r10), %r9
0000000100003277	movzbl	(%rdx,%r10), %r10d
000000010000327c	cmpb	$0x2, %r10b
0000000100003280	setne	%r11b
0000000100003284	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000328b	setne	%r14b
000000010000328f	orb	%r11b, %r14b
0000000100003292	je	0x100003240
0000000100003294	cmpb	$0x1, %r10b
0000000100003298	jne	0x10000324d
000000010000329a	movl	0x20(%r9), %r10d
000000010000329e	imulq	%r10, %r8
00000001000032a2	shrq	$0x20, %r8
00000001000032a6	addq	%r8, %r9
00000001000032a9	addq	$0x228, %r9                     ## imm = 0x228
00000001000032b0	cmpb	$0x0, (%r9)
00000001000032b4	je	0x10000324d
00000001000032b6	callq	_fwp_flush
00000001000032bb	movq	0x6d76(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000032c2	movq	(%rax), %rdi
00000001000032c5	leaq	0x6668(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000032cc	leaq	0x6634(%rip), %rdx              ## literal pool for: "internal: counted owner escaped ARC contract"
00000001000032d3	xorl	%eax, %eax
00000001000032d5	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000032da	movl	$0x65, %edi
00000001000032df	callq	0x10000961e                     ## symbol stub for: _exit
00000001000032e4	movq	%r12, %rdi
00000001000032e7	movl	%r13d, %esi
00000001000032ea	movq	%rbx, %rdx
00000001000032ed	callq	_fwp_apply
00000001000032f2	movq	%rax, %r12
00000001000032f5	jmp	0x100003632
00000001000032fa	cmpb	$0x1, %cl
00000001000032fd	jne	0x100003331
00000001000032ff	movl	0x20(%r13), %ecx
0000000100003303	imulq	%rcx, %rax
0000000100003307	shrq	$0x20, %rax
000000010000330b	addq	%rax, %r13
000000010000330e	addq	$0x228, %r13                    ## imm = 0x228
0000000100003315	cmpb	$-0x1, (%r13)
000000010000331a	jne	0x1000031f0
0000000100003320	movq	%r13, %rdi
0000000100003323	callq	_fwp_rc_forget_slot
0000000100003328	movq	-0x40(%rbp), %rdi
000000010000332c	jmp	0x1000031f0
0000000100003331	movq	%r15, -0x68(%rbp)
0000000100003335	movq	_fwp_cleanups(%rip), %rax
000000010000333c	movq	%rax, -0xc8(%rbp)
0000000100003343	leaq	_fwp_rc_cleanup_cell(%rip), %rax
000000010000334a	movq	%rax, -0xc0(%rbp)
0000000100003351	leaq	-0x68(%rbp), %rax
0000000100003355	movq	%rax, -0xb8(%rbp)
000000010000335c	leaq	-0xc8(%rbp), %r13
0000000100003363	movq	%r13, _fwp_cleanups(%rip)
000000010000336a	testq	%r14, %r14
000000010000336d	je	0x100003431
0000000100003373	xorl	%eax, %eax
0000000100003375	cmpl	$0x6, %r14d
0000000100003379	jb	0x1000033c6
000000010000337b	movq	%r15, %rcx
000000010000337e	subq	%r12, %rcx
0000000100003381	cmpq	$0x1f, %rcx
0000000100003385	jbe	0x1000033c6
0000000100003387	movl	%r14d, %eax
000000010000338a	andl	$-0x4, %eax
000000010000338d	leaq	(,%r14,8), %rcx
0000000100003395	andq	$-0x20, %rcx
0000000100003399	xorl	%edx, %edx
000000010000339b	nopl	(%rax,%rax)
00000001000033a0	movups	0x8(%r12,%rdx), %xmm0
00000001000033a6	movups	0x18(%r12,%rdx), %xmm1
00000001000033ac	movups	%xmm0, 0x8(%r15,%rdx)
00000001000033b2	movups	%xmm1, 0x18(%r15,%rdx)
00000001000033b8	addq	$0x20, %rdx
00000001000033bc	cmpq	%rdx, %rcx
00000001000033bf	jne	0x1000033a0
00000001000033c1	cmpl	%r14d, %eax
00000001000033c4	je	0x100003431
00000001000033c6	movq	%r14, %rdx
00000001000033c9	movq	%rax, %rcx
00000001000033cc	andq	$0x3, %rdx
00000001000033d0	je	0x1000033f2
00000001000033d2	movq	%rax, %rcx
00000001000033d5	nopw	%cs:(%rax,%rax)
00000001000033e0	movq	0x8(%r12,%rcx,8), %rsi
00000001000033e5	movq	%rsi, 0x8(%r15,%rcx,8)
00000001000033ea	incq	%rcx
00000001000033ed	decq	%rdx
00000001000033f0	jne	0x1000033e0
00000001000033f2	subq	%r14, %rax
00000001000033f5	cmpq	$-0x4, %rax
00000001000033f9	ja	0x100003431
00000001000033fb	nopl	(%rax,%rax)
0000000100003400	movq	0x8(%r12,%rcx,8), %rax
0000000100003405	movq	%rax, 0x8(%r15,%rcx,8)
000000010000340a	movq	0x10(%r12,%rcx,8), %rax
000000010000340f	movq	%rax, 0x10(%r15,%rcx,8)
0000000100003414	movq	0x18(%r12,%rcx,8), %rax
0000000100003419	movq	%rax, 0x18(%r15,%rcx,8)
000000010000341e	movq	0x20(%r12,%rcx,8), %rax
0000000100003423	movq	%rax, 0x20(%r15,%rcx,8)
0000000100003428	addq	$0x4, %rcx
000000010000342c	cmpq	%rcx, %r14
000000010000342f	jne	0x100003400
0000000100003431	cmpl	$0x0, -0x50(%rbp)
0000000100003435	je	0x1000034c6
000000010000343b	movq	-0x50(%rbp), %rcx
000000010000343f	movl	%ecx, %eax
0000000100003441	cmpl	$0x13, %ecx
0000000100003444	ja	0x100003545
000000010000344a	xorl	%ecx, %ecx
000000010000344c	movq	%rax, %rsi
000000010000344f	movq	%rcx, %rdx
0000000100003452	andq	$0x3, %rsi
0000000100003456	je	0x100003475
0000000100003458	movq	%rcx, %rdx
000000010000345b	nopl	(%rax,%rax)
0000000100003460	movq	(%rbx,%rdx,8), %r9
0000000100003464	leal	(%r14,%rdx), %r8d
0000000100003468	movq	%r9, 0x8(%r15,%r8,8)
000000010000346d	incq	%rdx
0000000100003470	decq	%rsi
0000000100003473	jne	0x100003460
0000000100003475	subq	%rax, %rcx
0000000100003478	cmpq	$-0x4, %rcx
000000010000347c	ja	0x1000034c6
000000010000347e	nop
0000000100003480	movq	(%rbx,%rdx,8), %rcx
0000000100003484	leal	(%r14,%rdx), %esi
0000000100003488	movq	%rcx, 0x8(%r15,%rsi,8)
000000010000348d	movq	0x8(%rbx,%rdx,8), %rcx
0000000100003492	leal	(%r14,%rdx), %esi
0000000100003496	incl	%esi
0000000100003498	movq	%rcx, 0x8(%r15,%rsi,8)
000000010000349d	movq	0x10(%rbx,%rdx,8), %rcx
00000001000034a2	leal	0x2(%r14,%rdx), %esi
00000001000034a7	movq	%rcx, 0x8(%r15,%rsi,8)
00000001000034ac	movq	0x18(%rbx,%rdx,8), %rcx
00000001000034b1	leal	(%r14,%rdx), %esi
00000001000034b5	addl	$0x3, %esi
00000001000034b8	movq	%rcx, 0x8(%r15,%rsi,8)
00000001000034bd	addq	$0x4, %rdx
00000001000034c1	cmpq	%rdx, %rax
00000001000034c4	jne	0x100003480
00000001000034c6	movq	-0x58(%rbp), %rax
00000001000034ca	movq	(%rax), %rax
00000001000034cd	movl	$0x1, %esi
00000001000034d2	callq	*0x8(%rax)
00000001000034d5	movq	%r15, %rax
00000001000034d8	subq	0x8b59(%rip), %rax
00000001000034df	movq	0x8b7a(%rip), %rcx
00000001000034e6	shlq	$0x10, %rcx
00000001000034ea	cmpq	%rcx, %rax
00000001000034ed	jae	0x1000035e3
00000001000034f3	movq	0x8b86(%rip), %rcx
00000001000034fa	movq	%rax, %rdx
00000001000034fd	shrq	$0x10, %rdx
0000000100003501	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003508	leaq	(%rcx,%rdx), %r12
000000010000350c	movzbl	(%rcx,%rdx), %ecx
0000000100003510	cmpb	$0x2, %cl
0000000100003513	setne	%dl
0000000100003516	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000351c	setne	%sil
0000000100003520	orb	%dl, %sil
0000000100003523	jne	0x1000035af
0000000100003529	addq	$0x228, %r12                    ## imm = 0x228
0000000100003530	cmpb	$-0x1, (%r12)
0000000100003535	je	0x1000035d6
000000010000353b	movb	$0x1, (%r12)
0000000100003540	jmp	0x1000035e3
0000000100003545	leaq	-0x1(%rax), %rdx
0000000100003549	xorl	%ecx, %ecx
000000010000354b	movl	%edx, %esi
000000010000354d	addl	%r14d, %esi
0000000100003550	jb	0x10000344c
0000000100003556	shrq	$0x20, %rdx
000000010000355a	jne	0x10000344c
0000000100003560	leaq	(%r15,%r14,8), %rcx
0000000100003564	subq	%rbx, %rcx
0000000100003567	addq	$0x8, %rcx
000000010000356b	cmpq	$0x20, %rcx
000000010000356f	jb	0x10000344a
0000000100003575	movl	%eax, %ecx
0000000100003577	andl	$-0x4, %ecx
000000010000357a	xorl	%edx, %edx
000000010000357c	nopl	(%rax)
0000000100003580	movups	(%rbx,%rdx,8), %xmm0
0000000100003584	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100003589	leal	(%r14,%rdx), %esi
000000010000358d	movups	%xmm0, 0x8(%r15,%rsi,8)
0000000100003593	movups	%xmm1, 0x18(%r15,%rsi,8)
0000000100003599	addq	$0x4, %rdx
000000010000359d	cmpq	%rdx, %rcx
00000001000035a0	jne	0x100003580
00000001000035a2	cmpl	%eax, %ecx
00000001000035a4	jne	0x10000344c
00000001000035aa	jmp	0x1000034c6
00000001000035af	cmpb	$0x1, %cl
00000001000035b2	jne	0x1000035e3
00000001000035b4	movl	0x20(%r12), %ecx
00000001000035b9	imulq	%rcx, %rax
00000001000035bd	shrq	$0x20, %rax
00000001000035c1	addq	%rax, %r12
00000001000035c4	addq	$0x228, %r12                    ## imm = 0x228
00000001000035cb	cmpb	$-0x1, (%r12)
00000001000035d0	jne	0x10000353b
00000001000035d6	movq	%r12, %rdi
00000001000035d9	callq	_fwp_rc_forget_slot
00000001000035de	jmp	0x10000353b
00000001000035e3	movq	-0x50(%rbp), %rax
00000001000035e7	movl	%eax, -0x98(%rbp)
00000001000035ed	movq	$0x0, -0x68(%rbp)
00000001000035f5	cmpq	%r13, _fwp_cleanups(%rip)
00000001000035fc	jne	0x100003654
00000001000035fe	movq	-0xc8(%rbp), %rax
0000000100003605	movq	%rax, _fwp_cleanups(%rip)
000000010000360c	cmpb	$0x0, -0x44(%rbp)
0000000100003610	movq	-0x40(%rbp), %rdi
0000000100003614	je	0x10000362a
0000000100003616	leaq	-0x80(%rbp), %rcx
000000010000361a	cmpq	%rcx, %rax
000000010000361d	jne	0x100003654
000000010000361f	movq	-0x80(%rbp), %rax
0000000100003623	movq	%rax, _fwp_cleanups(%rip)
000000010000362a	callq	_fwp_closure_drop
000000010000362f	movq	%r15, %r12
0000000100003632	movq	0x69f7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100003639	movq	(%rax), %rax
000000010000363c	cmpq	-0x30(%rbp), %rax
0000000100003640	jne	0x100003659
0000000100003642	movq	%r12, %rax
0000000100003645	leaq	-0x28(%rbp), %rsp
0000000100003649	popq	%rbx
000000010000364a	popq	%r12
000000010000364c	popq	%r13
000000010000364e	popq	%r14
0000000100003650	popq	%r15
0000000100003652	popq	%rbp
0000000100003653	retq
0000000100003654	callq	0x100009600                     ## symbol stub for: _abort
0000000100003659	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
000000010000365e	nop
_fwp_gc_alloc_slow:
0000000100003660	pushq	%rbp
0000000100003661	movq	%rsp, %rbp
0000000100003664	pushq	%r15
0000000100003666	pushq	%r14
0000000100003668	pushq	%r13
000000010000366a	pushq	%r12
000000010000366c	pushq	%rbx
000000010000366d	pushq	%rax
000000010000366e	movl	%esi, %ebx
0000000100003670	cmpl	$0x0, 0x897d(%rip)
0000000100003677	je	0x100003697
0000000100003679	cmpq	$0x4001, %rdi                   ## imm = 0x4001
0000000100003680	jb	0x1000036ab
0000000100003682	movl	%ebx, %esi
0000000100003684	addq	$0x8, %rsp
0000000100003688	popq	%rbx
0000000100003689	popq	%r12
000000010000368b	popq	%r13
000000010000368d	popq	%r14
000000010000368f	popq	%r15
0000000100003691	popq	%rbp
0000000100003692	jmp	_fwp_gc_alloc_big
0000000100003697	movq	%rdi, %r14
000000010000369a	callq	_fwp_gc_init
000000010000369f	movq	%r14, %rdi
00000001000036a2	cmpq	$0x4001, %rdi                   ## imm = 0x4001
00000001000036a9	jae	0x100003682
00000001000036ab	leaq	0xf(%rdi), %rax
00000001000036af	shrq	$0x4, %rax
00000001000036b3	leaq	_fwp_gc(%rip), %r15
00000001000036ba	movzbl	0xbe8(%rax,%r15), %r14d
00000001000036c3	movl	0xb48(%r15,%r14,4), %esi
00000001000036cb	cmpq	$0x0, _fwp_gc(%rip)
00000001000036d3	jns	0x100003771
00000001000036d9	cmpl	$0x0, 0x8914(%rip)
00000001000036e0	jne	0x1000036f3
00000001000036e2	movq	%rdi, %r12
00000001000036e5	movq	%rsi, %r13
00000001000036e8	callq	_fwp_gc_init
00000001000036ed	movq	%r13, %rsi
00000001000036f0	movq	%r12, %rdi
00000001000036f3	movl	0x8903(%rip), %ecx
00000001000036f9	testl	%ecx, %ecx
00000001000036fb	setne	%dl
00000001000036fe	movq	0x8923(%rip), %rax
0000000100003705	testq	%rax, %rax
0000000100003708	setne	%r8b
000000010000370c	andb	%dl, %r8b
000000010000370f	cmpb	$0x1, %r8b
0000000100003713	jne	0x100003733
0000000100003715	movq	0x8914(%rip), %rcx
000000010000371c	incq	%rcx
000000010000371f	movq	%rcx, 0x890a(%rip)
0000000100003726	cmpq	%rax, %rcx
0000000100003729	jge	0x1000037f5
000000010000372f	xorl	%eax, %eax
0000000100003731	jmp	0x100003740
0000000100003733	movl	$0x800000, %eax                 ## imm = 0x800000
0000000100003738	testl	%ecx, %ecx
000000010000373a	jne	0x100003800
0000000100003740	movq	0x8ad1(%rip), %rcx
0000000100003747	subq	_fwp_gc(%rip), %rcx
000000010000374e	cvtsi2sd	%rcx, %xmm0
0000000100003753	addsd	0x8a95(%rip), %xmm0
000000010000375b	movsd	%xmm0, 0x8a8d(%rip)
0000000100003763	movq	%rax, 0x8aae(%rip)
000000010000376a	movq	%rax, _fwp_gc(%rip)
0000000100003771	movl	%ebx, %eax
0000000100003773	imulq	$0x3c0, %rax, %rax              ## imm = 0x3C0
000000010000377a	addq	%rax, %r15
000000010000377d	leaq	(%r14,%r14,2), %rcx
0000000100003781	leaq	(%r15,%rcx,8), %rax
0000000100003785	addq	$0x8, %rax
0000000100003789	movq	0x8(%r15,%rcx,8), %r15
000000010000378e	testq	%r15, %r15
0000000100003791	je	0x10000379e
0000000100003793	movq	(%r15), %rcx
0000000100003796	notq	%rcx
0000000100003799	movq	%rcx, (%rax)
000000010000379c	jmp	0x1000037d4
000000010000379e	movq	0x8(%rax), %r15
00000001000037a2	movq	0x10(%rax), %rcx
00000001000037a6	subq	%r15, %rcx
00000001000037a9	cmpq	%rsi, %rcx
00000001000037ac	jae	0x1000037cc
00000001000037ae	movq	%rdi, %r15
00000001000037b1	movq	%rax, %rdi
00000001000037b4	movq	%rsi, %r12
00000001000037b7	movl	%r14d, %esi
00000001000037ba	movl	%ebx, %edx
00000001000037bc	callq	_fwp_gc_refill
00000001000037c1	movq	%r12, %rsi
00000001000037c4	movq	%r15, %rdi
00000001000037c7	movq	%rax, %r15
00000001000037ca	jmp	0x1000037d4
00000001000037cc	leaq	(%r15,%rsi), %rcx
00000001000037d0	movq	%rcx, 0x8(%rax)
00000001000037d4	cmpl	$0x1, %ebx
00000001000037d7	cmoveq	%rdi, %rsi
00000001000037db	movq	%r15, %rdi
00000001000037de	callq	0x1000095be                     ## symbol stub for: ___bzero
00000001000037e3	movq	%r15, %rax
00000001000037e6	addq	$0x8, %rsp
00000001000037ea	popq	%rbx
00000001000037eb	popq	%r12
00000001000037ed	popq	%r13
00000001000037ef	popq	%r14
00000001000037f1	popq	%r15
00000001000037f3	popq	%rbp
00000001000037f4	retq
00000001000037f5	movq	$0x0, 0x8830(%rip)
0000000100003800	callq	_fwp_gc_collect
0000000100003805	nopw	%cs:(%rax,%rax)
_fwp_gc_init:
0000000100003810	pushq	%rbp
0000000100003811	movq	%rsp, %rbp
0000000100003814	pushq	%r15
0000000100003816	pushq	%r14
0000000100003818	pushq	%r12
000000010000381a	pushq	%rbx
000000010000381b	movl	$0x1, 0x87cf(%rip)
0000000100003825	movaps	0x5f04(%rip), %xmm0
000000010000382c	movups	%xmm0, 0x831d(%rip)
0000000100003833	movaps	0x5f06(%rip), %xmm0
000000010000383a	movups	%xmm0, 0x831f(%rip)
0000000100003841	movaps	0x5f08(%rip), %xmm0
0000000100003848	movups	%xmm0, 0x8321(%rip)
000000010000384f	movaps	0x5f0a(%rip), %xmm0
0000000100003856	movups	%xmm0, 0x8323(%rip)
000000010000385d	movaps	0x5f0c(%rip), %xmm0
0000000100003864	movups	%xmm0, 0x8325(%rip)
000000010000386b	movaps	0x5f0e(%rip), %xmm0
0000000100003872	movups	%xmm0, 0x8327(%rip)
0000000100003879	movaps	0x5f10(%rip), %xmm0
0000000100003880	movups	%xmm0, 0x8329(%rip)
0000000100003887	movaps	0x5f12(%rip), %xmm0
000000010000388e	movups	%xmm0, 0x832b(%rip)
0000000100003895	movaps	0x5f14(%rip), %xmm0
000000010000389c	movups	%xmm0, 0x832d(%rip)
00000001000038a3	movaps	0x5f16(%rip), %xmm0
00000001000038aa	movups	%xmm0, 0x832f(%rip)
00000001000038b1	xorl	%ecx, %ecx
00000001000038b3	leaq	_fwp_gc(%rip), %rax
00000001000038ba	xorl	%edx, %edx
00000001000038bc	nopl	(%rax)
00000001000038c0	movl	%edx, %esi
00000001000038c2	shll	$0x4, %esi
00000001000038c5	decq	%rcx
00000001000038c8	movq	%rcx, %rdi
00000001000038cb	nopl	(%rax,%rax)
00000001000038d0	movq	%rdi, %rcx
00000001000038d3	incq	%rdi
00000001000038d6	cmpl	0xb4c(%rax,%rcx,4), %esi
00000001000038dd	ja	0x1000038d0
00000001000038df	movb	%dil, 0xbe8(%rdx,%rax)
00000001000038e7	cmpq	$0x400, %rdx                    ## imm = 0x400
00000001000038ee	je	0x10000391d
00000001000038f0	movq	%rdx, %rsi
00000001000038f3	orq	$0x1, %rsi
00000001000038f7	movl	%esi, %edi
00000001000038f9	shll	$0x4, %edi
00000001000038fc	nopl	(%rax)
0000000100003900	movq	%rcx, %r8
0000000100003903	incq	%rcx
0000000100003906	cmpl	0xb4c(%rax,%r8,4), %edi
000000010000390e	ja	0x100003900
0000000100003910	movb	%cl, 0xbe8(%rsi,%rax)
0000000100003917	addq	$0x2, %rdx
000000010000391b	jmp	0x1000038c0
000000010000391d	movabsq	$0x1000000000, %rbx             ## imm = 0x1000000000
0000000100003927	leaq	0x10000(%rbx), %rsi
000000010000392e	xorl	%edi, %edi
0000000100003930	xorl	%edx, %edx
0000000100003932	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003937	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
000000010000393d	xorl	%r9d, %r9d
0000000100003940	callq	0x10000968a                     ## symbol stub for: _mmap
0000000100003945	cmpq	$-0x1, %rax
0000000100003949	jne	0x1000039ab
000000010000394b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100003955	leaq	0x10000(%rbx), %rsi
000000010000395c	xorl	%edi, %edi
000000010000395e	xorl	%edx, %edx
0000000100003960	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003965	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
000000010000396b	xorl	%r9d, %r9d
000000010000396e	callq	0x10000968a                     ## symbol stub for: _mmap
0000000100003973	cmpq	$-0x1, %rax
0000000100003977	jne	0x1000039ab
0000000100003979	movabsq	$__mh_execute_header, %rbx
0000000100003983	leaq	0x10000(%rbx), %rsi
000000010000398a	xorl	%edi, %edi
000000010000398c	xorl	%edx, %edx
000000010000398e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003993	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003999	xorl	%r9d, %r9d
000000010000399c	callq	0x10000968a                     ## symbol stub for: _mmap
00000001000039a1	cmpq	$-0x1, %rax
00000001000039a5	je	0x100003bf8
00000001000039ab	testq	%rax, %rax
00000001000039ae	je	0x100003c59
00000001000039b4	movq	%rax, 0x8685(%rip)
00000001000039bb	movq	%rbx, %rcx
00000001000039be	orq	$0x10000, %rcx                  ## imm = 0x10000
00000001000039c5	movq	%rcx, 0x867c(%rip)
00000001000039cc	addq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000039d2	andq	$-0x10000, %rax                 ## imm = 0xFFFF0000
00000001000039d8	movq	%rax, 0x8659(%rip)
00000001000039df	shrq	$0x10, %rbx
00000001000039e3	movq	%rbx, 0x866e(%rip)
00000001000039ea	imulq	$0x1228, %rbx, %rsi             ## imm = 0x1228
00000001000039f1	movq	%rsi, 0x8690(%rip)
00000001000039f8	xorl	%edi, %edi
00000001000039fa	xorl	%edx, %edx
00000001000039fc	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003a01	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003a07	xorl	%r9d, %r9d
0000000100003a0a	callq	0x10000968a                     ## symbol stub for: _mmap
0000000100003a0f	cmpq	$-0x1, %rax
0000000100003a13	je	0x100003c59
0000000100003a19	movq	%rax, 0x8660(%rip)
0000000100003a20	leaq	0x5f43(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003a27	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003a2c	movl	$0x1, %r14d
0000000100003a32	testq	%rax, %rax
0000000100003a35	je	0x100003a62
0000000100003a37	movq	%rax, %rbx
0000000100003a3a	leaq	0x5f30(%rip), %rsi              ## literal pool for: "off"
0000000100003a41	movq	%rax, %rdi
0000000100003a44	callq	0x1000096e4                     ## symbol stub for: _strcmp
0000000100003a49	testl	%eax, %eax
0000000100003a4b	je	0x100003a5f
0000000100003a4d	cmpb	$0x30, (%rbx)
0000000100003a50	jne	0x100003a62
0000000100003a52	xorl	%r14d, %r14d
0000000100003a55	cmpb	$0x0, 0x1(%rbx)
0000000100003a59	setne	%r14b
0000000100003a5d	jmp	0x100003a62
0000000100003a5f	xorl	%r14d, %r14d
0000000100003a62	movl	%r14d, 0x858f(%rip)
0000000100003a69	leaq	0x5f07(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100003a70	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003a75	testq	%rax, %rax
0000000100003a78	je	0x100003a91
0000000100003a7a	movzbl	(%rax), %ecx
0000000100003a7d	testl	%ecx, %ecx
0000000100003a7f	je	0x100003a9a
0000000100003a81	cmpl	$0x30, %ecx
0000000100003a84	jne	0x100003a95
0000000100003a86	xorl	%ecx, %ecx
0000000100003a88	cmpb	$0x0, 0x1(%rax)
0000000100003a8c	setne	%cl
0000000100003a8f	jmp	0x100003a9a
0000000100003a91	xorl	%ecx, %ecx
0000000100003a93	jmp	0x100003a9a
0000000100003a95	movl	$0x1, %ecx
0000000100003a9a	movl	%ecx, 0x8564(%rip)
0000000100003aa0	leaq	0x5ec3(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003aa7	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003aac	testq	%rax, %rax
0000000100003aaf	je	0x100003ac9
0000000100003ab1	leaq	0x5ecc(%rip), %rsi              ## literal pool for: "full"
0000000100003ab8	movq	%rax, %rdi
0000000100003abb	callq	0x1000096e4                     ## symbol stub for: _strcmp
0000000100003ac0	xorl	%ecx, %ecx
0000000100003ac2	testl	%eax, %eax
0000000100003ac4	setne	%cl
0000000100003ac7	jmp	0x100003ace
0000000100003ac9	movl	$0x1, %ecx
0000000100003ace	movl	%ecx, 0x8534(%rip)
0000000100003ad4	movl	$0x1, 0x8532(%rip)
0000000100003ade	leaq	0x5ea4(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
0000000100003ae5	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003aea	testq	%rax, %rax
0000000100003aed	je	0x100003b0b
0000000100003aef	movzbl	(%rax), %r15d
0000000100003af3	testl	%r15d, %r15d
0000000100003af6	je	0x100003b16
0000000100003af8	cmpl	$0x30, %r15d
0000000100003afc	jne	0x100003b10
0000000100003afe	xorl	%r15d, %r15d
0000000100003b01	cmpb	$0x0, 0x1(%rax)
0000000100003b05	setne	%r15b
0000000100003b09	jmp	0x100003b16
0000000100003b0b	xorl	%r15d, %r15d
0000000100003b0e	jmp	0x100003b16
0000000100003b10	movl	$0x1, %r15d
0000000100003b16	movl	%r15d, 0x84ef(%rip)
0000000100003b1d	leaq	0x5e73(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
0000000100003b24	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003b29	testq	%rax, %rax
0000000100003b2c	je	0x100003b3b
0000000100003b2e	movq	%rax, %rdi
0000000100003b31	callq	0x100009612                     ## symbol stub for: _atol
0000000100003b36	movq	%rax, %rbx
0000000100003b39	jmp	0x100003b3d
0000000100003b3b	xorl	%ebx, %ebx
0000000100003b3d	xorl	%eax, %eax
0000000100003b3f	testq	%rbx, %rbx
0000000100003b42	cmovgq	%rbx, %rax
0000000100003b46	movq	%rax, 0x84db(%rip)
0000000100003b4d	leaq	0x5e16(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003b54	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003b59	testq	%rax, %rax
0000000100003b5c	je	0x100003b92
0000000100003b5e	movq	%rax, %r14
0000000100003b61	movzbl	(%rax), %r12d
0000000100003b65	testb	%r12b, %r12b
0000000100003b68	je	0x100003b92
0000000100003b6a	leaq	0x5e00(%rip), %rsi              ## literal pool for: "off"
0000000100003b71	movq	%r14, %rdi
0000000100003b74	callq	0x1000096e4                     ## symbol stub for: _strcmp
0000000100003b79	testl	%eax, %eax
0000000100003b7b	je	0x100003b92
0000000100003b7d	cmpb	$0x30, %r12b
0000000100003b81	jne	0x100003c83
0000000100003b87	cmpb	$0x0, 0x1(%r14)
0000000100003b8c	jne	0x100003c83
0000000100003b92	testq	%rbx, %rbx
0000000100003b95	jg	0x100003c83
0000000100003b9b	testl	%r15d, %r15d
0000000100003b9e	jne	0x100003c83
0000000100003ba4	leaq	0x5e37(%rip), %rdi              ## literal pool for: "FWP_REUSE_VERIFY"
0000000100003bab	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100003bb0	testq	%rax, %rax
0000000100003bb3	je	0x100003bcf
0000000100003bb5	movzbl	(%rax), %ecx
0000000100003bb8	testl	%ecx, %ecx
0000000100003bba	je	0x100003bcf
0000000100003bbc	cmpl	$0x30, %ecx
0000000100003bbf	jne	0x100003ca2
0000000100003bc5	cmpb	$0x0, 0x1(%rax)
0000000100003bc9	jne	0x100003ca2
0000000100003bcf	movl	$0x0, 0x841f(%rip)
0000000100003bd9	movq	$0x800000, 0x8634(%rip)         ## imm = 0x800000
0000000100003be4	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
0000000100003bef	popq	%rbx
0000000100003bf0	popq	%r12
0000000100003bf2	popq	%r14
0000000100003bf4	popq	%r15
0000000100003bf6	popq	%rbp
0000000100003bf7	retq
0000000100003bf8	movl	$0x40010000, %esi               ## imm = 0x40010000
0000000100003bfd	xorl	%edi, %edi
0000000100003bff	xorl	%edx, %edx
0000000100003c01	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c06	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c0c	xorl	%r9d, %r9d
0000000100003c0f	callq	0x10000968a                     ## symbol stub for: _mmap
0000000100003c14	cmpq	$-0x1, %rax
0000000100003c18	je	0x100003c29
0000000100003c1a	testq	%rax, %rax
0000000100003c1d	je	0x100003c59
0000000100003c1f	movl	$0x40000000, %ebx               ## imm = 0x40000000
0000000100003c24	jmp	0x1000039b4
0000000100003c29	movl	$0x10010000, %esi               ## imm = 0x10010000
0000000100003c2e	xorl	%edi, %edi
0000000100003c30	xorl	%edx, %edx
0000000100003c32	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c37	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c3d	xorl	%r9d, %r9d
0000000100003c40	callq	0x10000968a                     ## symbol stub for: _mmap
0000000100003c45	leaq	0x1(%rax), %rcx
0000000100003c49	cmpq	$0x2, %rcx
0000000100003c4d	jb	0x100003c59
0000000100003c4f	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100003c54	jmp	0x1000039b4
0000000100003c59	movq	0x63d8(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003c60	movq	(%rax), %rcx
0000000100003c63	leaq	0x5dc8(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100003c6a	movl	$0x13, %esi
0000000100003c6f	movl	$0x1, %edx
0000000100003c74	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100003c79	movl	$0x66, %edi
0000000100003c7e	callq	0x10000961e                     ## symbol stub for: _exit
0000000100003c83	callq	_fwp_flush
0000000100003c88	movq	0x63a9(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003c8f	movq	(%rax), %rdi
0000000100003c92	leaq	0x5c9b(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003c99	leaq	0x5d05(%rip), %rdx              ## literal pool for: "--gc arc cannot enable tracing, GC stress or GC verification"
0000000100003ca0	jmp	0x100003cbf
0000000100003ca2	callq	_fwp_flush
0000000100003ca7	movq	0x638a(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003cae	movq	(%rax), %rdi
0000000100003cb1	leaq	0x5c7c(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003cb8	leaq	0x5d34(%rip), %rdx              ## literal pool for: "--gc arc cannot retain released storage for reuse verification"
0000000100003cbf	xorl	%eax, %eax
0000000100003cc1	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100003cc6	movl	$0x65, %edi
0000000100003ccb	callq	0x10000961e                     ## symbol stub for: _exit
_fwp_gc_alloc_big:
0000000100003cd0	pushq	%rbp
0000000100003cd1	movq	%rsp, %rbp
0000000100003cd4	pushq	%r15
0000000100003cd6	pushq	%r14
0000000100003cd8	pushq	%r13
0000000100003cda	pushq	%r12
0000000100003cdc	pushq	%rbx
0000000100003cdd	pushq	%rax
0000000100003cde	movabsq	$0x4000000000000001, %rax       ## imm = 0x4000000000000001
0000000100003ce8	cmpq	%rax, %rdi
0000000100003ceb	jae	0x100003f27
0000000100003cf1	movl	%esi, %r14d
0000000100003cf4	movq	%rdi, %rbx
0000000100003cf7	subq	%rdi, _fwp_gc(%rip)
0000000100003cfe	jns	0x100003d90
0000000100003d04	cmpl	$0x0, 0x82e9(%rip)
0000000100003d0b	jne	0x100003d12
0000000100003d0d	callq	_fwp_gc_init
0000000100003d12	movl	0x82e4(%rip), %ecx
0000000100003d18	testl	%ecx, %ecx
0000000100003d1a	setne	%dl
0000000100003d1d	movq	0x8304(%rip), %rax
0000000100003d24	testq	%rax, %rax
0000000100003d27	setne	%sil
0000000100003d2b	andb	%dl, %sil
0000000100003d2e	cmpb	$0x1, %sil
0000000100003d32	jne	0x100003d52
0000000100003d34	movq	0x82f5(%rip), %rcx
0000000100003d3b	incq	%rcx
0000000100003d3e	movq	%rcx, 0x82eb(%rip)
0000000100003d45	cmpq	%rax, %rcx
0000000100003d48	jge	0x100003f51
0000000100003d4e	xorl	%eax, %eax
0000000100003d50	jmp	0x100003d5f
0000000100003d52	movl	$0x800000, %eax                 ## imm = 0x800000
0000000100003d57	testl	%ecx, %ecx
0000000100003d59	jne	0x100003f5c
0000000100003d5f	movq	0x84b2(%rip), %rcx
0000000100003d66	subq	_fwp_gc(%rip), %rcx
0000000100003d6d	cvtsi2sd	%rcx, %xmm0
0000000100003d72	addsd	0x8476(%rip), %xmm0
0000000100003d7a	movsd	%xmm0, 0x846e(%rip)
0000000100003d82	movq	%rax, 0x848f(%rip)
0000000100003d89	movq	%rax, _fwp_gc(%rip)
0000000100003d90	leaq	0xffff(%rbx), %r15
0000000100003d97	shrq	$0x10, %r15
0000000100003d9b	movq	%r15, %rdi
0000000100003d9e	callq	_fwp_gc_chunks
0000000100003da3	movq	0x82d6(%rip), %rcx
0000000100003daa	imulq	$0x1228, %rax, %r12             ## imm = 0x1228
0000000100003db1	movb	$0x2, (%rcx,%r12)
0000000100003db6	movb	%r14b, 0x1(%rcx,%r12)
0000000100003dbb	movw	$0x100, 0x3(%rcx,%r12)          ## imm = 0x100
0000000100003dc3	movl	%r15d, 0x10(%rcx,%r12)
0000000100003dc8	movq	%rbx, 0x18(%rcx,%r12)
0000000100003dcd	leaq	(%rcx,%r12), %r14
0000000100003dd1	addq	$0x228, %r14                    ## imm = 0x228
0000000100003dd8	cmpb	$-0x1, 0x228(%rcx,%r12)
0000000100003de1	je	0x100003f14
0000000100003de7	movb	$0x0, (%r14)
0000000100003deb	cmpq	$0x10001, %rbx                  ## imm = 0x10001
0000000100003df2	jb	0x100003ee9
0000000100003df8	movq	0x8281(%rip), %rcx
0000000100003dff	cmpq	$0x3, %r15
0000000100003e03	movl	$0x2, %r8d
0000000100003e09	cmovaeq	%r15, %r8
0000000100003e0d	leaq	-0x1(%r8), %rsi
0000000100003e11	addq	$-0x2, %r8
0000000100003e15	movl	%esi, %edx
0000000100003e17	andl	$0x3, %edx
0000000100003e1a	movl	$0x1, %edi
0000000100003e1f	cmpq	$0x3, %r8
0000000100003e23	jb	0x100003eab
0000000100003e29	leaq	(%r12,%rcx), %r8
0000000100003e2d	addq	$0x48b0, %r8                    ## imm = 0x48B0
0000000100003e34	andq	$-0x4, %rsi
0000000100003e38	negq	%rsi
0000000100003e3b	nopl	(%rax,%rax)
0000000100003e40	movb	$0x3, -0x3688(%r8)
0000000100003e48	movb	$0x1, -0x3684(%r8)
0000000100003e50	movl	%eax, -0x3678(%r8)
0000000100003e57	movb	$0x3, -0x2460(%r8)
0000000100003e5f	movb	$0x1, -0x245c(%r8)
0000000100003e67	movl	%eax, -0x2450(%r8)
0000000100003e6e	movb	$0x3, -0x1238(%r8)
0000000100003e76	movb	$0x1, -0x1234(%r8)
0000000100003e7e	movl	%eax, -0x1228(%r8)
0000000100003e85	movb	$0x3, -0x10(%r8)
0000000100003e8a	movb	$0x1, -0xc(%r8)
0000000100003e8f	movl	%eax, (%r8)
0000000100003e92	addq	$0x48a0, %r8                    ## imm = 0x48A0
0000000100003e99	leaq	(%rsi,%rdi), %r9
0000000100003e9d	addq	$0x4, %r9
0000000100003ea1	addq	$0x4, %rdi
0000000100003ea5	cmpq	$0x1, %r9
0000000100003ea9	jne	0x100003e40
0000000100003eab	testq	%rdx, %rdx
0000000100003eae	je	0x100003ee9
0000000100003eb0	imulq	$0x1228, %rdi, %rsi             ## imm = 0x1228
0000000100003eb7	addq	%rsi, %r12
0000000100003eba	addq	%r12, %rcx
0000000100003ebd	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003ec4	xorl	%esi, %esi
0000000100003ec6	nopw	%cs:(%rax,%rax)
0000000100003ed0	movb	$0x3, (%rcx,%rsi)
0000000100003ed4	movb	$0x1, 0x4(%rcx,%rsi)
0000000100003ed9	movl	%eax, 0x10(%rcx,%rsi)
0000000100003edd	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100003ee4	cmpq	%rsi, %rdx
0000000100003ee7	jne	0x100003ed0
0000000100003ee9	shlq	$0x10, %rax
0000000100003eed	addq	0x8144(%rip), %rax
0000000100003ef4	movq	%rax, %rdi
0000000100003ef7	movq	%rbx, %rsi
0000000100003efa	movq	%rax, %rbx
0000000100003efd	callq	0x1000095be                     ## symbol stub for: ___bzero
0000000100003f02	movq	%rbx, %rax
0000000100003f05	addq	$0x8, %rsp
0000000100003f09	popq	%rbx
0000000100003f0a	popq	%r12
0000000100003f0c	popq	%r13
0000000100003f0e	popq	%r14
0000000100003f10	popq	%r15
0000000100003f12	popq	%rbp
0000000100003f13	retq
0000000100003f14	movq	%r14, %rdi
0000000100003f17	movq	%rax, %r13
0000000100003f1a	callq	_fwp_rc_forget_slot
0000000100003f1f	movq	%r13, %rax
0000000100003f22	jmp	0x100003de7
0000000100003f27	movq	0x610a(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003f2e	movq	(%rax), %rcx
0000000100003f31	leaq	0x5afa(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100003f38	movl	$0x13, %esi
0000000100003f3d	movl	$0x1, %edx
0000000100003f42	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100003f47	movl	$0x66, %edi
0000000100003f4c	callq	0x10000961e                     ## symbol stub for: _exit
0000000100003f51	movq	$0x0, 0x80d4(%rip)
0000000100003f5c	callq	_fwp_gc_collect
0000000100003f61	nopw	%cs:(%rax,%rax)
_fwp_gc_refill:
0000000100003f70	pushq	%rbp
0000000100003f71	movq	%rsp, %rbp
0000000100003f74	pushq	%r15
0000000100003f76	pushq	%r14
0000000100003f78	pushq	%r13
0000000100003f7a	pushq	%r12
0000000100003f7c	pushq	%rbx
0000000100003f7d	pushq	%rax
0000000100003f7e	movl	%edx, %r15d
0000000100003f81	movl	%esi, %r12d
0000000100003f84	movq	%rdi, %rbx
0000000100003f87	movl	$0x1, %edi
0000000100003f8c	callq	_fwp_gc_chunks
0000000100003f91	movq	%rax, %r14
0000000100003f94	leaq	_fwp_gc(%rip), %rax
0000000100003f9b	movq	0x80de(%rip), %rsi
0000000100003fa2	imulq	$0x1228, %r14, %rdi             ## imm = 0x1228
0000000100003fa9	leaq	(%rsi,%rdi), %r13
0000000100003fad	movb	$0x1, (%rsi,%rdi)
0000000100003fb1	movb	%r15b, 0x1(%rsi,%rdi)
0000000100003fb6	movb	%r12b, 0x2(%rsi,%rdi)
0000000100003fbb	movb	$0x1, 0x4(%rsi,%rdi)
0000000100003fc0	movl	%r12d, %ecx
0000000100003fc3	movl	0xb48(%rax,%rcx,4), %ecx
0000000100003fca	movl	%ecx, 0x8(%rsi,%rdi)
0000000100003fce	movl	$0x10000, %eax                  ## imm = 0x10000
0000000100003fd3	xorl	%edx, %edx
0000000100003fd5	divl	%ecx
0000000100003fd7	movl	%eax, 0xc(%rsi,%rdi)
0000000100003fdb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100003fe0	addq	%rcx, %rax
0000000100003fe3	btq	$0x20, %rax
0000000100003fe8	jae	0x100003ff1
0000000100003fea	xorl	%edx, %edx
0000000100003fec	divq	%rcx
0000000100003fef	jmp	0x100003ff5
0000000100003ff1	xorl	%edx, %edx
0000000100003ff3	divl	%ecx
0000000100003ff5	movl	%eax, 0x20(%r13)
0000000100003ff9	cmpq	$0x0, 0x8a1f(%rip)
0000000100004001	je	0x10000402e
0000000100004003	leaq	0x228(%r13), %r15
000000010000400a	xorl	%r12d, %r12d
000000010000400d	jmp	0x10000401c
000000010000400f	nop
0000000100004010	incq	%r12
0000000100004013	cmpq	$0x1000, %r12                   ## imm = 0x1000
000000010000401a	je	0x10000402e
000000010000401c	cmpb	$-0x1, (%r15,%r12)
0000000100004021	jne	0x100004010
0000000100004023	leaq	(%r15,%r12), %rdi
0000000100004027	callq	_fwp_rc_forget_slot
000000010000402c	jmp	0x100004010
000000010000402e	leaq	0x228(%r13), %rdi
0000000100004035	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000403a	callq	0x1000095be                     ## symbol stub for: ___bzero
000000010000403f	shlq	$0x10, %r14
0000000100004043	addq	0x7fee(%rip), %r14
000000010000404a	cmpl	$0x0, 0x7fbb(%rip)
0000000100004051	je	0x100004060
0000000100004053	movl	$0x10000, %esi                  ## imm = 0x10000
0000000100004058	movq	%r14, %rdi
000000010000405b	callq	0x1000095be                     ## symbol stub for: ___bzero
0000000100004060	movl	0x8(%r13), %eax
0000000100004064	leaq	(%r14,%rax), %rcx
0000000100004068	movq	%rcx, 0x8(%rbx)
000000010000406c	movl	0xc(%r13), %ecx
0000000100004070	imulq	%rax, %rcx
0000000100004074	addq	%r14, %rcx
0000000100004077	movq	%rcx, 0x10(%rbx)
000000010000407b	movq	%r14, %rax
000000010000407e	addq	$0x8, %rsp
0000000100004082	popq	%rbx
0000000100004083	popq	%r12
0000000100004085	popq	%r13
0000000100004087	popq	%r14
0000000100004089	popq	%r15
000000010000408b	popq	%rbp
000000010000408c	retq
000000010000408d	nopl	(%rax)
_fwp_gc_chunks:
0000000100004090	pushq	%rbp
0000000100004091	movq	%rsp, %rbp
0000000100004094	pushq	%r15
0000000100004096	pushq	%r14
0000000100004098	pushq	%rbx
0000000100004099	pushq	%rax
000000010000409a	movq	%rdi, %rbx
000000010000409d	xorl	%edx, %edx
000000010000409f	cmpq	$0x1, %rdi
00000001000040a3	setne	%dl
00000001000040a6	leaq	_fwp_gc(%rip), %rcx
00000001000040ad	movq	0x1068(%rcx,%rdx,8), %rax
00000001000040b5	movq	0x7fa4(%rip), %r14
00000001000040bc	movq	%rax, %rdi
00000001000040bf	subq	%r14, %rdi
00000001000040c2	jae	0x100004132
00000001000040c4	leaq	0x1068(,%rdx,8), %rsi
00000001000040cc	imulq	$0x1228, %rax, %r8              ## imm = 0x1228
00000001000040d3	addq	0x7fa6(%rip), %r8
00000001000040da	xorl	%edx, %edx
00000001000040dc	xorl	%r9d, %r9d
00000001000040df	jmp	0x100004102
00000001000040e1	nopw	%cs:(%rax,%rax)
00000001000040f0	xorl	%r9d, %r9d
00000001000040f3	decq	%rdx
00000001000040f6	addq	$0x1228, %r8                    ## imm = 0x1228
00000001000040fd	cmpq	%rdx, %rdi
0000000100004100	je	0x100004135
0000000100004102	cmpb	$0x0, (%r8)
0000000100004106	jne	0x1000040f0
0000000100004108	incq	%r9
000000010000410b	cmpq	%rbx, %r9
000000010000410e	jne	0x1000040f3
0000000100004110	incq	%rax
0000000100004113	movq	%rax, %rdi
0000000100004116	subq	%rdx, %rdi
0000000100004119	movq	%rdi, (%rsi,%rcx)
000000010000411d	subq	%rbx, 0x80c4(%rip)
0000000100004124	subq	%rbx, %rax
0000000100004127	subq	%rdx, %rax
000000010000412a	movq	%rax, %r14
000000010000412d	jmp	0x1000041fc
0000000100004132	xorl	%r9d, %r9d
0000000100004135	subq	%r9, 0x80ac(%rip)
000000010000413c	subq	%r9, %r14
000000010000413f	addq	%r14, %rbx
0000000100004142	movq	0x7f1f(%rip), %rdi
0000000100004149	cmpq	%rbx, %rdi
000000010000414c	jae	0x1000041e1
0000000100004152	movq	0x7eff(%rip), %r15
0000000100004159	cmpq	%rbx, %r15
000000010000415c	jb	0x10000420a
0000000100004162	leaq	0x40(%rbx), %rax
0000000100004166	cmpq	%r15, %rax
0000000100004169	cmovbq	%rax, %r15
000000010000416d	movq	%r15, %rsi
0000000100004170	subq	%rdi, %rsi
0000000100004173	shlq	$0x10, %rdi
0000000100004177	addq	0x7eba(%rip), %rdi
000000010000417e	shlq	$0x10, %rsi
0000000100004182	movl	$0x3, %edx
0000000100004187	callq	0x100009690                     ## symbol stub for: _mprotect
000000010000418c	testl	%eax, %eax
000000010000418e	jne	0x10000420a
0000000100004190	movl	$0x1d, %edi
0000000100004195	callq	0x10000970e                     ## symbol stub for: _sysconf
000000010000419a	movq	0x7edf(%rip), %rcx
00000001000041a1	imulq	$0x1228, 0x7ebc(%rip), %rdi     ## imm = 0x1228
00000001000041ac	addq	%rcx, %rdi
00000001000041af	imulq	$0x1228, %r15, %rdx             ## imm = 0x1228
00000001000041b6	addq	%rcx, %rdx
00000001000041b9	leaq	(%rax,%rdx), %rsi
00000001000041bd	decq	%rsi
00000001000041c0	negq	%rax
00000001000041c3	andq	%rax, %rdi
00000001000041c6	andq	%rax, %rsi
00000001000041c9	subq	%rdi, %rsi
00000001000041cc	movl	$0x3, %edx
00000001000041d1	callq	0x100009690                     ## symbol stub for: _mprotect
00000001000041d6	testl	%eax, %eax
00000001000041d8	jne	0x10000420a
00000001000041da	movq	%r15, 0x7e87(%rip)
00000001000041e1	movq	%rbx, 0x7e78(%rip)
00000001000041e8	shlq	$0x10, %rbx
00000001000041ec	cmpq	0x7e5d(%rip), %rbx
00000001000041f3	jbe	0x1000041fc
00000001000041f5	movq	%rbx, 0x7e54(%rip)
00000001000041fc	movq	%r14, %rax
00000001000041ff	addq	$0x8, %rsp
0000000100004203	popq	%rbx
0000000100004204	popq	%r14
0000000100004206	popq	%r15
0000000100004208	popq	%rbp
0000000100004209	retq
000000010000420a	movq	0x5e27(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004211	movq	(%rax), %rcx
0000000100004214	leaq	0x5817(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000421b	movl	$0x13, %esi
0000000100004220	movl	$0x1, %edx
0000000100004225	callq	0x100009654                     ## symbol stub for: _fwrite
000000010000422a	movl	$0x66, %edi
000000010000422f	callq	0x10000961e                     ## symbol stub for: _exit
0000000100004234	nopw	%cs:(%rax,%rax)
_fwp_gc_collect:
0000000100004240	pushq	%rbp
0000000100004241	movq	%rsp, %rbp
0000000100004244	callq	_fwp_flush
0000000100004249	movq	0x5de8(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004250	movq	(%rax), %rdi
0000000100004253	leaq	0x56da(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000425a	leaq	0x57e5(%rip), %rdx              ## literal pool for: "internal: tracing requested in an ARC executable"
0000000100004261	xorl	%eax, %eax
0000000100004263	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100004268	movl	$0x65, %edi
000000010000426d	callq	0x10000961e                     ## symbol stub for: _exit
0000000100004272	nopw	%cs:(%rax,%rax)
_fwp_closure_drop:
0000000100004280	pushq	%rbp
0000000100004281	movq	%rsp, %rbp
0000000100004284	pushq	%r15
0000000100004286	pushq	%r14
0000000100004288	pushq	%rbx
0000000100004289	subq	$0x238, %rsp                    ## imm = 0x238
0000000100004290	movq	%rdi, %rax
0000000100004293	subq	0x7d9e(%rip), %rax
000000010000429a	movq	0x7dbf(%rip), %rcx
00000001000042a1	shlq	$0x10, %rcx
00000001000042a5	cmpq	%rcx, %rax
00000001000042a8	jae	0x100004344
00000001000042ae	movq	%rdi, %rsi
00000001000042b1	movq	0x7dc8(%rip), %rcx
00000001000042b8	movq	%rax, %rdx
00000001000042bb	shrq	$0x10, %rdx
00000001000042bf	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000042c6	leaq	(%rcx,%rdx), %rdi
00000001000042ca	movzbl	(%rcx,%rdx), %ecx
00000001000042ce	cmpb	$0x2, %cl
00000001000042d1	setne	%dl
00000001000042d4	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000042da	setne	%r8b
00000001000042de	orb	%dl, %r8b
00000001000042e1	jne	0x1000042ec
00000001000042e3	addq	$0x228, %rdi                    ## imm = 0x228
00000001000042ea	jmp	0x100004306
00000001000042ec	cmpb	$0x1, %cl
00000001000042ef	jne	0x100004344
00000001000042f1	movl	0x20(%rdi), %ecx
00000001000042f4	imulq	%rcx, %rax
00000001000042f8	shrq	$0x20, %rax
00000001000042fc	addq	%rax, %rdi
00000001000042ff	addq	$0x228, %rdi                    ## imm = 0x228
0000000100004306	movzbl	(%rdi), %eax
0000000100004309	testl	%eax, %eax
000000010000430b	je	0x100004344
000000010000430d	cmpl	$0x1, %eax
0000000100004310	jne	0x100004335
0000000100004312	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100004319	callq	*(%rdi)
000000010000431b	movq	(%rax), %rdi
000000010000431e	testq	%rdi, %rdi
0000000100004321	je	0x100004352
0000000100004323	addq	$0x238, %rsp                    ## imm = 0x238
000000010000432a	popq	%rbx
000000010000432b	popq	%r14
000000010000432d	popq	%r15
000000010000432f	popq	%rbp
0000000100004330	jmp	_fwp_closure_drop_push
0000000100004335	cmpl	$0xff, %eax
000000010000433a	je	0x100004426
0000000100004340	decb	%al
0000000100004342	movb	%al, (%rdi)
0000000100004344	addq	$0x238, %rsp                    ## imm = 0x238
000000010000434b	popq	%rbx
000000010000434c	popq	%r14
000000010000434e	popq	%r15
0000000100004350	popq	%rbp
0000000100004351	retq
0000000100004352	leaq	-0x230(%rbp), %rbx
0000000100004359	movq	%rbx, -0x248(%rbp)
0000000100004360	movq	$0x0, -0x240(%rbp)
000000010000436b	movq	$0x40, -0x238(%rbp)
0000000100004376	movq	_fwp_cleanups(%rip), %rcx
000000010000437d	movq	%rcx, -0x30(%rbp)
0000000100004381	leaq	_fwp_closure_drop_release(%rip), %rcx
0000000100004388	movq	%rcx, -0x28(%rbp)
000000010000438c	leaq	-0x248(%rbp), %rdi
0000000100004393	movq	%rdi, -0x20(%rbp)
0000000100004397	leaq	-0x30(%rbp), %r15
000000010000439b	movq	%r15, _fwp_cleanups(%rip)
00000001000043a2	movq	%rax, %r14
00000001000043a5	movq	%rdi, (%rax)
00000001000043a8	callq	_fwp_closure_drop_push
00000001000043ad	nopl	(%rax)
00000001000043b0	movq	-0x240(%rbp), %rax
00000001000043b7	testq	%rax, %rax
00000001000043ba	je	0x1000043f1
00000001000043bc	movq	-0x248(%rbp), %rcx
00000001000043c3	leaq	-0x1(%rax), %rdx
00000001000043c7	movq	%rdx, -0x240(%rbp)
00000001000043ce	movq	-0x8(%rcx,%rax,8), %rdi
00000001000043d3	movq	_fwp_fns(%rip), %rax
00000001000043da	movl	(%rdi), %ecx
00000001000043dc	shlq	$0x5, %rcx
00000001000043e0	movq	0x18(%rax,%rcx), %rax
00000001000043e5	testq	%rax, %rax
00000001000043e8	je	0x100004438
00000001000043ea	xorl	%esi, %esi
00000001000043ec	callq	*0x8(%rax)
00000001000043ef	jmp	0x1000043b0
00000001000043f1	cmpq	%r15, _fwp_cleanups(%rip)
00000001000043f8	jne	0x100004466
00000001000043fa	movq	-0x30(%rbp), %rax
00000001000043fe	movq	%rax, _fwp_cleanups(%rip)
0000000100004405	movq	$0x0, (%r14)
000000010000440c	movq	-0x248(%rbp), %rdi
0000000100004413	cmpq	%rbx, %rdi
0000000100004416	je	0x100004344
000000010000441c	callq	0x10000964e                     ## symbol stub for: _free
0000000100004421	jmp	0x100004344
0000000100004426	addq	$0x238, %rsp                    ## imm = 0x238
000000010000442d	popq	%rbx
000000010000442e	popq	%r14
0000000100004430	popq	%r15
0000000100004432	popq	%rbp
0000000100004433	jmp	_fwp_rc_wide_drop
0000000100004438	callq	_fwp_flush
000000010000443d	movq	0x5bf4(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004444	movq	(%rax), %rdi
0000000100004447	leaq	0x54e6(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000444e	leaq	0x5622(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100004455	xorl	%eax, %eax
0000000100004457	callq	0x10000963c                     ## symbol stub for: _fprintf
000000010000445c	movl	$0x65, %edi
0000000100004461	callq	0x10000961e                     ## symbol stub for: _exit
0000000100004466	callq	0x100009600                     ## symbol stub for: _abort
000000010000446b	nopl	(%rax,%rax)
_fwp_closure_drop_push:
0000000100004470	pushq	%rbp
0000000100004471	movq	%rsp, %rbp
0000000100004474	pushq	%r15
0000000100004476	pushq	%r14
0000000100004478	pushq	%r13
000000010000447a	pushq	%r12
000000010000447c	pushq	%rbx
000000010000447d	pushq	%rax
000000010000447e	movq	%rsi, %rbx
0000000100004481	movq	%rdi, %r14
0000000100004484	movq	0x8(%rdi), %r13
0000000100004488	cmpq	0x10(%rdi), %r13
000000010000448c	jne	0x1000044f3
000000010000448e	movq	%r13, %rax
0000000100004491	shrq	$0x3c, %rax
0000000100004495	jne	0x100004511
0000000100004497	movq	%r13, %rdi
000000010000449a	shlq	$0x4, %rdi
000000010000449e	callq	0x100009672                     ## symbol stub for: _malloc
00000001000044a3	testq	%rax, %rax
00000001000044a6	je	0x100004530
00000001000044ac	movq	%rax, %r15
00000001000044af	leaq	(,%r13,2), %rax
00000001000044b7	movq	%rax, -0x30(%rbp)
00000001000044bb	movq	(%r14), %r12
00000001000044be	leaq	(,%r13,8), %rdx
00000001000044c6	movq	%r15, %rdi
00000001000044c9	movq	%r12, %rsi
00000001000044cc	callq	0x100009678                     ## symbol stub for: _memcpy
00000001000044d1	leaq	0x18(%r14), %rax
00000001000044d5	cmpq	%rax, %r12
00000001000044d8	je	0x1000044e6
00000001000044da	movq	%r12, %rdi
00000001000044dd	callq	0x10000964e                     ## symbol stub for: _free
00000001000044e2	movq	0x8(%r14), %r13
00000001000044e6	movq	%r15, (%r14)
00000001000044e9	movq	-0x30(%rbp), %rax
00000001000044ed	movq	%rax, 0x10(%r14)
00000001000044f1	jmp	0x1000044f6
00000001000044f3	movq	(%r14), %r15
00000001000044f6	leaq	0x1(%r13), %rax
00000001000044fa	movq	%rax, 0x8(%r14)
00000001000044fe	movq	%rbx, (%r15,%r13,8)
0000000100004502	addq	$0x8, %rsp
0000000100004506	popq	%rbx
0000000100004507	popq	%r12
0000000100004509	popq	%r13
000000010000450b	popq	%r14
000000010000450d	popq	%r15
000000010000450f	popq	%rbp
0000000100004510	retq
0000000100004511	callq	_fwp_flush
0000000100004516	movq	0x5b1b(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000451d	movq	(%rax), %rdi
0000000100004520	leaq	0x540d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004527	leaq	0x5577(%rip), %rdx              ## literal pool for: "closure cleanup too large"
000000010000452e	jmp	0x10000454d
0000000100004530	callq	_fwp_flush
0000000100004535	movq	0x5afc(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000453c	movq	(%rax), %rdi
000000010000453f	leaq	0x53ee(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004546	leaq	0x5572(%rip), %rdx              ## literal pool for: "out of memory"
000000010000454d	xorl	%eax, %eax
000000010000454f	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100004554	movl	$0x65, %edi
0000000100004559	callq	0x10000961e                     ## symbol stub for: _exit
000000010000455e	nop
_fwp_closure_drop_release:
0000000100004560	pushq	%rbp
0000000100004561	movq	%rsp, %rbp
0000000100004564	pushq	%r14
0000000100004566	pushq	%rbx
0000000100004567	movq	%rdi, %rbx
000000010000456a	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100004571	callq	*(%rdi)
0000000100004573	movq	$0x0, (%rax)
000000010000457a	movq	(%rbx), %rdi
000000010000457d	leaq	0x18(%rbx), %r14
0000000100004581	cmpq	%r14, %rdi
0000000100004584	je	0x10000458b
0000000100004586	callq	0x10000964e                     ## symbol stub for: _free
000000010000458b	movq	%r14, (%rbx)
000000010000458e	movq	$0x0, 0x8(%rbx)
0000000100004596	popq	%rbx
0000000100004597	popq	%r14
0000000100004599	popq	%rbp
000000010000459a	retq
000000010000459b	nopl	(%rax,%rax)
_fwp_rc_wide_drop:
00000001000045a0	pushq	%rbp
00000001000045a1	movq	%rsp, %rbp
00000001000045a4	pushq	%rbx
00000001000045a5	pushq	%rax
00000001000045a6	movq	%rdi, %rax
00000001000045a9	shrq	$0x11, %rax
00000001000045ad	xorl	%edi, %eax
00000001000045af	movl	%eax, %ecx
00000001000045b1	shrl	$0x9, %ecx
00000001000045b4	xorl	%eax, %ecx
00000001000045b6	movzbl	%cl, %eax
00000001000045b9	leaq	_fwp_gc(%rip), %rcx
00000001000045c0	movq	0x1218(%rcx,%rax,8), %rax
00000001000045c8	testq	%rax, %rax
00000001000045cb	je	0x1000045de
00000001000045cd	nopl	(%rax)
00000001000045d0	cmpq	%rdi, (%rax)
00000001000045d3	je	0x10000460c
00000001000045d5	movq	0x10(%rax), %rax
00000001000045d9	testq	%rax, %rax
00000001000045dc	jne	0x1000045d0
00000001000045de	callq	_fwp_flush
00000001000045e3	movq	0x5a4e(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000045ea	movq	(%rax), %rdi
00000001000045ed	leaq	0x5340(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000045f4	leaq	0x5348(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000045fb	xorl	%eax, %eax
00000001000045fd	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100004602	movl	$0x65, %edi
0000000100004607	callq	0x10000961e                     ## symbol stub for: _exit
000000010000460c	movq	0x8(%rax), %rcx
0000000100004610	decq	%rcx
0000000100004613	movq	%rcx, 0x8(%rax)
0000000100004617	cmpq	$0xfe, %rcx
000000010000461e	jne	0x10000462b
0000000100004620	movq	%rdi, %rbx
0000000100004623	callq	_fwp_rc_forget_slot
0000000100004628	movb	$-0x2, (%rbx)
000000010000462b	addq	$0x8, %rsp
000000010000462f	popq	%rbx
0000000100004630	popq	%rbp
0000000100004631	retq
0000000100004632	nopw	%cs:(%rax,%rax)
_fwp_rc_wide_dup:
0000000100004640	pushq	%rbp
0000000100004641	movq	%rsp, %rbp
0000000100004644	pushq	%r14
0000000100004646	pushq	%rbx
0000000100004647	movq	%rdi, %rbx
000000010000464a	movq	%rdi, %rax
000000010000464d	shrq	$0x11, %rax
0000000100004651	xorl	%ebx, %eax
0000000100004653	movl	%eax, %ecx
0000000100004655	shrl	$0x9, %ecx
0000000100004658	xorl	%eax, %ecx
000000010000465a	movzbl	%cl, %eax
000000010000465d	leaq	_fwp_gc(%rip), %rcx
0000000100004664	leaq	(%rcx,%rax,8), %r14
0000000100004668	addq	$0x1218, %r14                   ## imm = 0x1218
000000010000466f	movq	0x1218(%rcx,%rax,8), %rax
0000000100004677	testq	%rax, %rax
000000010000467a	je	0x1000046a3
000000010000467c	cmpq	%rbx, (%rax)
000000010000467f	je	0x1000046b0
0000000100004681	nopw	%cs:(%rax,%rax)
0000000100004690	movq	%rax, %r14
0000000100004693	movq	0x10(%rax), %rax
0000000100004697	testq	%rax, %rax
000000010000469a	je	0x1000046aa
000000010000469c	cmpq	%rbx, (%rax)
000000010000469f	jne	0x100004690
00000001000046a1	jmp	0x1000046ac
00000001000046a3	cmpb	$-0x2, (%rbx)
00000001000046a6	je	0x1000046be
00000001000046a8	jmp	0x100004714
00000001000046aa	xorl	%eax, %eax
00000001000046ac	addq	$0x10, %r14
00000001000046b0	cmpb	$-0x2, (%rbx)
00000001000046b3	jne	0x1000046f6
00000001000046b5	testq	%rax, %rax
00000001000046b8	jne	0x10000475d
00000001000046be	movl	$0x18, %edi
00000001000046c3	callq	0x100009672                     ## symbol stub for: _malloc
00000001000046c8	testq	%rax, %rax
00000001000046cb	je	0x100004733
00000001000046cd	movq	%rbx, (%rax)
00000001000046d0	movq	$0xff, 0x8(%rax)
00000001000046d8	movq	$0x0, 0x10(%rax)
00000001000046e0	movq	%rax, (%r14)
00000001000046e3	movb	$-0x1, (%rbx)
00000001000046e6	leaq	0x8333(%rip), %rax
00000001000046ed	movq	0x832c(%rip), %rcx
00000001000046f4	jmp	0x100004709
00000001000046f6	testq	%rax, %rax
00000001000046f9	je	0x100004714
00000001000046fb	movq	0x8(%rax), %rcx
00000001000046ff	cmpq	$-0x1, %rcx
0000000100004703	je	0x10000477c
0000000100004705	addq	$0x8, %rax
0000000100004709	incq	%rcx
000000010000470c	movq	%rcx, (%rax)
000000010000470f	popq	%rbx
0000000100004710	popq	%r14
0000000100004712	popq	%rbp
0000000100004713	retq
0000000100004714	callq	_fwp_flush
0000000100004719	movq	0x5918(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004720	movq	(%rax), %rdi
0000000100004723	leaq	0x520a(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000472a	leaq	0x5212(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100004731	jmp	0x100004799
0000000100004733	movq	0x58fe(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000473a	movq	(%rax), %rcx
000000010000473d	leaq	0x52ee(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004744	movl	$0x13, %esi
0000000100004749	movl	$0x1, %edx
000000010000474e	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100004753	movl	$0x66, %edi
0000000100004758	callq	0x10000961e                     ## symbol stub for: _exit
000000010000475d	callq	_fwp_flush
0000000100004762	movq	0x58cf(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004769	movq	(%rax), %rdi
000000010000476c	leaq	0x51c1(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004773	leaq	0x5353(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
000000010000477a	jmp	0x100004799
000000010000477c	callq	_fwp_flush
0000000100004781	movq	0x58b0(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004788	movq	(%rax), %rdi
000000010000478b	leaq	0x51a2(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004792	leaq	0x5359(%rip), %rdx              ## literal pool for: "reference count overflow"
0000000100004799	xorl	%eax, %eax
000000010000479b	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000047a0	movl	$0x65, %edi
00000001000047a5	callq	0x10000961e                     ## symbol stub for: _exit
00000001000047aa	nopw	(%rax,%rax)
_fwp_alloc_init:
00000001000047b0	pushq	%rbp
00000001000047b1	movq	%rsp, %rbp
00000001000047b4	pushq	%rbx
00000001000047b5	pushq	%rax
00000001000047b6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
00000001000047bd	ja	0x1000048ad
00000001000047c3	leaq	0xf(%rdi), %rdx
00000001000047c7	shrq	$0x4, %rdx
00000001000047cb	leaq	_fwp_gc(%rip), %rax
00000001000047d2	movzbl	0xbe8(%rdx,%rax), %ecx
00000001000047da	movl	0xb48(%rax,%rcx,4), %esi
00000001000047e1	movq	_fwp_gc(%rip), %r8
00000001000047e8	movq	%r8, %r9
00000001000047eb	subq	%rsi, %r9
00000001000047ee	movq	%r9, _fwp_gc(%rip)
00000001000047f5	js	0x1000048ad
00000001000047fb	leaq	(%rcx,%rcx,2), %r9
00000001000047ff	leaq	(%rax,%r9,8), %r9
0000000100004803	addq	$0x8, %r9
0000000100004807	movq	(%r9), %rbx
000000010000480a	testq	%rbx, %rbx
000000010000480d	je	0x100004844
000000010000480f	movq	(%rbx), %rax
0000000100004812	notq	%rax
0000000100004815	movq	%rax, (%r9)
0000000100004818	andl	$0x7ff8, %edi                   ## imm = 0x7FF8
000000010000481e	cmpq	%rsi, %rdi
0000000100004821	jae	0x1000048ca
0000000100004827	leaq	(%rbx,%rdi), %rax
000000010000482b	notq	%rdi
000000010000482e	addq	%rsi, %rdi
0000000100004831	andq	$-0x8, %rdi
0000000100004835	addq	$0x8, %rdi
0000000100004839	movq	%rdi, %rsi
000000010000483c	movq	%rax, %rdi
000000010000483f	jmp	0x1000048c5
0000000100004844	movq	0x8(%r9), %rbx
0000000100004848	movq	0x10(%r9), %r10
000000010000484c	subq	%rbx, %r10
000000010000484f	cmpq	%rsi, %r10
0000000100004852	jb	0x10000487c
0000000100004854	leaq	(%rbx,%rsi), %rcx
0000000100004858	movq	%rcx, 0x8(%r9)
000000010000485c	testq	%rbx, %rbx
000000010000485f	jne	0x100004818
0000000100004861	movzbl	0xbe8(%rdx,%rax), %ecx
0000000100004869	movl	0xb48(%rax,%rcx,4), %esi
0000000100004870	subq	%rsi, %r8
0000000100004873	movq	%r8, _fwp_gc(%rip)
000000010000487a	js	0x1000048ad
000000010000487c	leaq	(%rcx,%rcx,2), %rdx
0000000100004880	leaq	(%rax,%rdx,8), %rcx
0000000100004884	addq	$0x8, %rcx
0000000100004888	movq	0x8(%rax,%rdx,8), %rbx
000000010000488d	testq	%rbx, %rbx
0000000100004890	je	0x10000489d
0000000100004892	movq	(%rbx), %rax
0000000100004895	notq	%rax
0000000100004898	movq	%rax, (%rcx)
000000010000489b	jmp	0x1000048c2
000000010000489d	movq	0x8(%rcx), %rbx
00000001000048a1	movq	0x10(%rcx), %rax
00000001000048a5	subq	%rbx, %rax
00000001000048a8	cmpq	%rsi, %rax
00000001000048ab	jae	0x1000048ba
00000001000048ad	xorl	%esi, %esi
00000001000048af	addq	$0x8, %rsp
00000001000048b3	popq	%rbx
00000001000048b4	popq	%rbp
00000001000048b5	jmp	_fwp_gc_alloc_slow
00000001000048ba	leaq	(%rbx,%rsi), %rax
00000001000048be	movq	%rax, 0x8(%rcx)
00000001000048c2	movq	%rbx, %rdi
00000001000048c5	callq	0x1000095be                     ## symbol stub for: ___bzero
00000001000048ca	movq	%rbx, %rax
00000001000048cd	addq	$0x8, %rsp
00000001000048d1	popq	%rbx
00000001000048d2	popq	%rbp
00000001000048d3	retq
00000001000048d4	nopw	%cs:(%rax,%rax)
_fwp_rc_cleanup_cell:
00000001000048e0	pushq	%rbp
00000001000048e1	movq	%rsp, %rbp
00000001000048e4	movq	%rdi, %rax
00000001000048e7	movq	(%rdi), %rdi
00000001000048ea	movq	$0x0, (%rax)
00000001000048f1	testq	%rdi, %rdi
00000001000048f4	je	0x1000048fc
00000001000048f6	popq	%rbp
00000001000048f7	jmp	_fwp_rc_free_obj
00000001000048fc	popq	%rbp
00000001000048fd	retq
00000001000048fe	nop
_fwp_rc_free_obj:
0000000100004900	pushq	%rbp
0000000100004901	movq	%rsp, %rbp
0000000100004904	pushq	%r15
0000000100004906	pushq	%r14
0000000100004908	pushq	%rbx
0000000100004909	pushq	%rax
000000010000490a	movq	%rdi, %rax
000000010000490d	subq	0x7724(%rip), %rax
0000000100004914	movq	0x7745(%rip), %rcx
000000010000491b	shlq	$0x10, %rcx
000000010000491f	cmpq	%rcx, %rax
0000000100004922	jae	0x100004a3f
0000000100004928	movq	0x7751(%rip), %rcx
000000010000492f	movq	%rax, %rdx
0000000100004932	shrq	$0x10, %rdx
0000000100004936	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000493d	leaq	(%rcx,%rdx), %rbx
0000000100004941	movzbl	(%rcx,%rdx), %r14d
0000000100004946	cmpb	$0x2, %r14b
000000010000494a	setne	%cl
000000010000494d	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100004953	setne	%dl
0000000100004956	orb	%cl, %dl
0000000100004958	jne	0x10000496b
000000010000495a	leaq	0x228(%rbx), %rax
0000000100004961	cmpb	$0x1, (%rax)
0000000100004964	je	0x100004992
0000000100004966	jmp	0x100004a3f
000000010000496b	cmpb	$0x1, %r14b
000000010000496f	jne	0x100004a3f
0000000100004975	movl	0x20(%rbx), %ecx
0000000100004978	imulq	%rcx, %rax
000000010000497c	shrq	$0x20, %rax
0000000100004980	addq	%rbx, %rax
0000000100004983	addq	$0x228, %rax                    ## imm = 0x228
0000000100004989	cmpb	$0x1, (%rax)
000000010000498c	jne	0x100004a3f
0000000100004992	movl	_fwp_reuse_verify(%rip), %eax
0000000100004998	testl	%eax, %eax
000000010000499a	js	0x1000049fb
000000010000499c	testl	%eax, %eax
000000010000499e	je	0x100004a14
00000001000049a0	cmpb	$0x1, 0x1(%rbx)
00000001000049a4	jne	0x1000049b2
00000001000049a6	cmpb	$0x2, %r14b
00000001000049aa	jne	0x1000049de
00000001000049ac	movq	0x18(%rbx), %rdx
00000001000049b0	jmp	0x1000049e1
00000001000049b2	movl	$0xdead, (%rdi)                 ## imm = 0xDEAD
00000001000049b8	movl	0x4(%rdi), %edx
00000001000049bb	testq	%rdx, %rdx
00000001000049be	je	0x100004a3f
00000001000049c0	addq	$0x8, %rdi
00000001000049c4	shlq	$0x3, %rdx
00000001000049c8	leaq	0x4e41(%rip), %rsi
00000001000049cf	addq	$0x8, %rsp
00000001000049d3	popq	%rbx
00000001000049d4	popq	%r14
00000001000049d6	popq	%r15
00000001000049d8	popq	%rbp
00000001000049d9	jmp	0x100009684                     ## symbol stub for: _memset_pattern16
00000001000049de	movl	0x8(%rbx), %edx
00000001000049e1	movq	%rdi, %rbx
00000001000049e4	movl	$0xdd, %esi
00000001000049e9	callq	0x10000967e                     ## symbol stub for: _memset
00000001000049ee	movq	$0x0, (%rbx)
00000001000049f5	movb	$0x0, 0x8(%rbx)
00000001000049f9	jmp	0x100004a3f
00000001000049fb	leaq	-0x1c(%rbp), %rax
00000001000049ff	movq	%rdi, %r15
0000000100004a02	movq	%rax, %rdi
0000000100004a05	callq	_fwp_rc_free_obj.cold.1
0000000100004a0a	movq	%r15, %rdi
0000000100004a0d	movl	-0x1c(%rbp), %eax
0000000100004a10	testl	%eax, %eax
0000000100004a12	jne	0x1000049a0
0000000100004a14	movq	_fwp_gc(%rip), %rbx
0000000100004a1b	callq	_fwp_mem_free
0000000100004a20	movq	_fwp_gc(%rip), %rax
0000000100004a27	subq	%rbx, %rax
0000000100004a2a	cvtsi2sd	%rax, %xmm0
0000000100004a2f	addsd	0x77d9(%rip), %xmm0
0000000100004a37	movsd	%xmm0, 0x77d1(%rip)
0000000100004a3f	addq	$0x8, %rsp
0000000100004a43	popq	%rbx
0000000100004a44	popq	%r14
0000000100004a46	popq	%r15
0000000100004a48	popq	%rbp
0000000100004a49	retq
0000000100004a4a	nopw	(%rax,%rax)
_fwp_mem_free:
0000000100004a50	testq	%rdi, %rdi
0000000100004a53	je	0x100004c65
0000000100004a59	movq	0x75d8(%rip), %rax
0000000100004a60	movq	%rdi, %rcx
0000000100004a63	subq	%rax, %rcx
0000000100004a66	movq	0x75f3(%rip), %rdx
0000000100004a6d	shlq	$0x10, %rdx
0000000100004a71	cmpq	%rdx, %rcx
0000000100004a74	jae	0x100004c65
0000000100004a7a	pushq	%rbp
0000000100004a7b	movq	%rsp, %rbp
0000000100004a7e	pushq	%r15
0000000100004a80	pushq	%r14
0000000100004a82	pushq	%r13
0000000100004a84	pushq	%r12
0000000100004a86	pushq	%rbx
0000000100004a87	pushq	%rax
0000000100004a88	movq	0x75f1(%rip), %r14
0000000100004a8f	testq	%r14, %r14
0000000100004a92	je	0x100004c57
0000000100004a98	movq	%rcx, %rbx
0000000100004a9b	shrq	$0x10, %rbx
0000000100004a9f	imulq	$0x1228, %rbx, %r15             ## imm = 0x1228
0000000100004aa6	addq	%r15, %r14
0000000100004aa9	movzbl	(%r14), %edx
0000000100004aad	cmpl	$0x2, %edx
0000000100004ab0	je	0x100004b5e
0000000100004ab6	cmpl	$0x1, %edx
0000000100004ab9	jne	0x100004c57
0000000100004abf	movzbl	0x1(%r14), %eax
0000000100004ac4	movzbl	0x2(%r14), %r8d
0000000100004ac9	imulq	$0x3c0, %rax, %r9               ## imm = 0x3C0
0000000100004ad0	movl	0x8(%r14), %esi
0000000100004ad4	movzwl	%di, %eax
0000000100004ad7	xorl	%edx, %edx
0000000100004ad9	divl	%esi
0000000100004adb	movq	$-0x2, %rdx
0000000100004ae2	movl	%eax, %ecx
0000000100004ae4	rolq	%cl, %rdx
0000000100004ae7	leaq	_fwp_gc(%rip), %r15
0000000100004aee	addq	%r9, %r15
0000000100004af1	movl	%eax, %ecx
0000000100004af3	shrl	$0x3, %ecx
0000000100004af6	andl	$0x1ff8, %ecx                   ## imm = 0x1FF8
0000000100004afc	andq	%rdx, 0x28(%r14,%rcx)
0000000100004b01	leaq	(%r8,%r8,2), %r12
0000000100004b05	leaq	(%r14,%rax), %rbx
0000000100004b09	addq	$0x228, %rbx                    ## imm = 0x228
0000000100004b10	cmpb	$-0x1, 0x228(%r14,%rax)
0000000100004b19	je	0x100004c66
0000000100004b1f	leaq	(%r15,%r12,8), %r15
0000000100004b23	addq	$0x8, %r15
0000000100004b27	movb	$0x0, (%rbx)
0000000100004b2a	cmpl	$0x0, 0x74db(%rip)
0000000100004b31	je	0x100004b44
0000000100004b33	movl	%esi, %esi
0000000100004b35	movq	%rdi, %rbx
0000000100004b38	callq	0x1000095be                     ## symbol stub for: ___bzero
0000000100004b3d	movq	%rbx, %rdi
0000000100004b40	movl	0x8(%r14), %esi
0000000100004b44	movq	(%r15), %rax
0000000100004b47	notq	%rax
0000000100004b4a	movq	%rax, (%rdi)
0000000100004b4d	movq	%rdi, (%r15)
0000000100004b50	movl	%esi, %eax
0000000100004b52	addq	%rax, _fwp_gc(%rip)
0000000100004b59	jmp	0x100004c57
0000000100004b5e	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100004b65	addq	%rcx, %rax
0000000100004b68	cmpq	%rdi, %rax
0000000100004b6b	jne	0x100004c57
0000000100004b71	movq	0x18(%r14), %rax
0000000100004b75	addq	%rax, _fwp_gc(%rip)
0000000100004b7c	movb	$0x0, 0x3(%r14)
0000000100004b81	cmpb	$-0x1, 0x228(%r14)
0000000100004b89	je	0x100004c7d
0000000100004b8f	movb	$0x0, 0x228(%r14)
0000000100004b97	movl	0x10(%r14), %eax
0000000100004b9b	testq	%rax, %rax
0000000100004b9e	je	0x100004c30
0000000100004ba4	movq	0x74d5(%rip), %rcx
0000000100004bab	movl	%eax, %edx
0000000100004bad	andl	$0x3, %edx
0000000100004bb0	cmpl	$0x4, %eax
0000000100004bb3	jae	0x100004bb9
0000000100004bb5	xorl	%esi, %esi
0000000100004bb7	jmp	0x100004bf8
0000000100004bb9	leaq	(%rcx,%r15), %rdi
0000000100004bbd	movl	%eax, %r8d
0000000100004bc0	andl	$-0x4, %r8d
0000000100004bc4	xorl	%esi, %esi
0000000100004bc6	nopw	%cs:(%rax,%rax)
0000000100004bd0	movb	$0x0, (%rdi)
0000000100004bd3	movb	$0x0, 0x1228(%rdi)
0000000100004bda	movb	$0x0, 0x2450(%rdi)
0000000100004be1	movb	$0x0, 0x3678(%rdi)
0000000100004be8	addq	$0x4, %rsi
0000000100004bec	addq	$0x48a0, %rdi                   ## imm = 0x48A0
0000000100004bf3	cmpq	%rsi, %r8
0000000100004bf6	jne	0x100004bd0
0000000100004bf8	testq	%rdx, %rdx
0000000100004bfb	je	0x100004c30
0000000100004bfd	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100004c04	addq	%r15, %rsi
0000000100004c07	addq	%rsi, %rcx
0000000100004c0a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004c11	xorl	%esi, %esi
0000000100004c13	nopw	%cs:(%rax,%rax)
0000000100004c20	movb	$0x0, (%rcx,%rsi)
0000000100004c24	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100004c2b	cmpq	%rsi, %rdx
0000000100004c2e	jne	0x100004c20
0000000100004c30	addq	%rax, 0x75b1(%rip)
0000000100004c37	cmpq	0x743a(%rip), %rbx
0000000100004c3e	jae	0x100004c47
0000000100004c40	movq	%rbx, 0x7431(%rip)
0000000100004c47	cmpq	0x7422(%rip), %rbx
0000000100004c4e	jae	0x100004c57
0000000100004c50	movq	%rbx, 0x7419(%rip)
0000000100004c57	addq	$0x8, %rsp
0000000100004c5b	popq	%rbx
0000000100004c5c	popq	%r12
0000000100004c5e	popq	%r13
0000000100004c60	popq	%r14
0000000100004c62	popq	%r15
0000000100004c64	popq	%rbp
0000000100004c65	retq
0000000100004c66	movq	%rdi, %r13
0000000100004c69	movq	%rbx, %rdi
0000000100004c6c	callq	_fwp_rc_forget_slot
0000000100004c71	movq	%r13, %rdi
0000000100004c74	movl	0x8(%r14), %esi
0000000100004c78	jmp	0x100004b1f
0000000100004c7d	leaq	0x228(%r14), %rdi
0000000100004c84	callq	_fwp_rc_forget_slot
0000000100004c89	jmp	0x100004b8f
0000000100004c8e	nop
_fwp_value_release:
0000000100004c90	pushq	%rbp
0000000100004c91	movq	%rsp, %rbp
0000000100004c94	movq	%rdi, %rax
0000000100004c97	movq	(%rdi), %rdi
0000000100004c9a	movq	0x8(%rax), %rcx
0000000100004c9e	movq	$0x0, (%rax)
0000000100004ca5	testq	%rcx, %rcx
0000000100004ca8	setne	%al
0000000100004cab	testq	%rdi, %rdi
0000000100004cae	setne	%dl
0000000100004cb1	andb	%al, %dl
0000000100004cb3	cmpb	$0x1, %dl
0000000100004cb6	jne	0x100004cbb
0000000100004cb8	popq	%rbp
0000000100004cb9	jmpq	*%rcx
0000000100004cbb	popq	%rbp
0000000100004cbc	retq
0000000100004cbd	nopl	(%rax)
_fwp_owned_entry2:
0000000100004cc0	pushq	%rbp
0000000100004cc1	movq	%rsp, %rbp
0000000100004cc4	subq	$0x20, %rsp
0000000100004cc8	movq	0x5361(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100004ccf	movq	(%rax), %rax
0000000100004cd2	movq	%rax, -0x8(%rbp)
0000000100004cd6	movq	(%rdi), %rax
0000000100004cd9	movdqu	0x8(%rdi), %xmm0
0000000100004cde	pshufd	$0x4e, %xmm0, %xmm0             ## xmm0 = xmm0[2,3,0,1]
0000000100004ce3	movdqa	%xmm0, -0x20(%rbp)
0000000100004ce8	leaq	-0x20(%rbp), %rdx
0000000100004cec	movq	%rax, %rdi
0000000100004cef	movl	$0x2, %esi
0000000100004cf4	callq	_fwp_apply_owned
0000000100004cf9	movq	0x5330(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100004d00	movq	(%rcx), %rcx
0000000100004d03	cmpq	-0x8(%rbp), %rcx
0000000100004d07	jne	0x100004d0f
0000000100004d09	addq	$0x20, %rsp
0000000100004d0d	popq	%rbp
0000000100004d0e	retq
0000000100004d0f	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100004d14	nopw	%cs:(%rax,%rax)
_fwp_caps2:
0000000100004d20	testl	%esi, %esi
0000000100004d22	je	0x100004d32
0000000100004d24	movl	0x4(%rdi), %edx
0000000100004d27	addq	$0x8, %rdi
0000000100004d2b	xorl	%esi, %esi
0000000100004d2d	jmp	_fwp_args2
0000000100004d32	pushq	%rbp
0000000100004d33	movq	%rsp, %rbp
0000000100004d36	pushq	%rbx
0000000100004d37	pushq	%rax
0000000100004d38	cmpl	$0x0, 0x4(%rdi)
0000000100004d3c	je	0x100004e11
0000000100004d42	movq	0x8(%rdi), %rax
0000000100004d46	movq	%rdi, %rbx
0000000100004d49	movq	%rax, %rdi
0000000100004d4c	callq	_fwp_closure_drop
0000000100004d51	movq	%rbx, %rdi
0000000100004d54	cmpl	$0x2, 0x4(%rbx)
0000000100004d58	jb	0x100004e11
0000000100004d5e	movq	0x10(%rdi), %rdi
0000000100004d62	callq	_fwp_closure_drop
0000000100004d67	movq	%rbx, %rdi
0000000100004d6a	cmpl	$0x3, 0x4(%rbx)
0000000100004d6e	jb	0x100004e11
0000000100004d74	movq	0x18(%rdi), %rax
0000000100004d78	movq	%rax, %rdx
0000000100004d7b	subq	0x72b6(%rip), %rdx
0000000100004d82	movq	0x72d7(%rip), %rcx
0000000100004d89	shlq	$0x10, %rcx
0000000100004d8d	cmpq	%rcx, %rdx
0000000100004d90	jae	0x100004e11
0000000100004d92	movq	0x72e7(%rip), %rsi
0000000100004d99	movq	%rdx, %rcx
0000000100004d9c	shrq	$0x10, %rcx
0000000100004da0	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
0000000100004da7	leaq	(%rsi,%r8), %rcx
0000000100004dab	movzbl	(%rsi,%r8), %esi
0000000100004db0	cmpb	$0x2, %sil
0000000100004db4	setne	%r8b
0000000100004db8	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100004dbf	setne	%r9b
0000000100004dc3	orb	%r8b, %r9b
0000000100004dc6	jne	0x100004dd1
0000000100004dc8	addq	$0x228, %rcx                    ## imm = 0x228
0000000100004dcf	jmp	0x100004dec
0000000100004dd1	cmpb	$0x1, %sil
0000000100004dd5	jne	0x100004e11
0000000100004dd7	movl	0x20(%rcx), %esi
0000000100004dda	imulq	%rsi, %rdx
0000000100004dde	shrq	$0x20, %rdx
0000000100004de2	addq	%rdx, %rcx
0000000100004de5	addq	$0x228, %rcx                    ## imm = 0x228
0000000100004dec	movzbl	(%rcx), %edx
0000000100004def	testl	%edx, %edx
0000000100004df1	je	0x100004e11
0000000100004df3	cmpl	$0x1, %edx
0000000100004df6	jne	0x100004e05
0000000100004df8	movq	%rax, %rdi
0000000100004dfb	callq	_fwp_rc_free_obj
0000000100004e00	movq	%rbx, %rdi
0000000100004e03	jmp	0x100004e11
0000000100004e05	cmpl	$0xff, %edx
0000000100004e0b	je	0x100004e1c
0000000100004e0d	decb	%dl
0000000100004e0f	movb	%dl, (%rcx)
0000000100004e11	addq	$0x8, %rsp
0000000100004e15	popq	%rbx
0000000100004e16	popq	%rbp
0000000100004e17	jmp	_fwp_rc_free_obj
0000000100004e1c	movq	%rcx, %rdi
0000000100004e1f	callq	_fwp_rc_wide_drop
0000000100004e24	jmp	0x100004e00
0000000100004e26	nopw	%cs:(%rax,%rax)
_fwp_args2:
0000000100004e30	pushq	%rbp
0000000100004e31	movq	%rsp, %rbp
0000000100004e34	pushq	%r15
0000000100004e36	pushq	%r14
0000000100004e38	pushq	%r12
0000000100004e3a	pushq	%rbx
0000000100004e3b	subq	$0x30, %rsp
0000000100004e3f	movq	%rdi, -0x38(%rbp)
0000000100004e43	leaq	_fwp_arg_drop2(%rip), %rax
0000000100004e4a	movq	%rax, -0x30(%rbp)
0000000100004e4e	movl	%esi, -0x28(%rbp)
0000000100004e51	movl	$0x0, -0x24(%rbp)
0000000100004e58	movq	_fwp_cleanups(%rip), %rax
0000000100004e5f	movq	%rax, -0x50(%rbp)
0000000100004e63	leaq	_fwp_args_release(%rip), %rax
0000000100004e6a	movq	%rax, -0x48(%rbp)
0000000100004e6e	leaq	-0x38(%rbp), %rax
0000000100004e72	movq	%rax, -0x40(%rbp)
0000000100004e76	leaq	-0x50(%rbp), %rbx
0000000100004e7a	movq	%rbx, _fwp_cleanups(%rip)
0000000100004e81	testl	%esi, %esi
0000000100004e83	setne	%al
0000000100004e86	testl	%edx, %edx
0000000100004e88	sete	%cl
0000000100004e8b	orb	%al, %cl
0000000100004e8d	je	0x100004ea6
0000000100004e8f	cmpl	$0x1, %esi
0000000100004e92	jbe	0x100004f34
0000000100004e98	cmpl	$0x2, %esi
0000000100004e9b	je	0x100004fd7
0000000100004ea1	jmp	0x100005071
0000000100004ea6	movq	(%rdi), %rcx
0000000100004ea9	subq	0x7188(%rip), %rcx
0000000100004eb0	movq	0x71a9(%rip), %rax
0000000100004eb7	shlq	$0x10, %rax
0000000100004ebb	cmpq	%rax, %rcx
0000000100004ebe	jae	0x100004f2d
0000000100004ec0	movq	0x71b9(%rip), %r8
0000000100004ec7	movq	%rcx, %rax
0000000100004eca	shrq	$0x10, %rax
0000000100004ece	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100004ed5	leaq	(%r8,%r9), %rax
0000000100004ed9	movzbl	(%r8,%r9), %r8d
0000000100004ede	cmpb	$0x2, %r8b
0000000100004ee2	setne	%r9b
0000000100004ee6	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100004eed	setne	%r10b
0000000100004ef1	orb	%r9b, %r10b
0000000100004ef4	jne	0x100004efe
0000000100004ef6	addq	$0x228, %rax                    ## imm = 0x228
0000000100004efc	jmp	0x100004f19
0000000100004efe	cmpb	$0x1, %r8b
0000000100004f02	jne	0x100004f2d
0000000100004f04	movl	0x20(%rax), %r8d
0000000100004f08	imulq	%r8, %rcx
0000000100004f0c	shrq	$0x20, %rcx
0000000100004f10	addq	%rcx, %rax
0000000100004f13	addq	$0x228, %rax                    ## imm = 0x228
0000000100004f19	movzbl	(%rax), %ecx
0000000100004f1c	testb	%cl, %cl
0000000100004f1e	je	0x100004f2d
0000000100004f20	cmpb	$-0x2, %cl
0000000100004f23	jae	0x100005092
0000000100004f29	incb	%cl
0000000100004f2b	movb	%cl, (%rax)
0000000100004f2d	movl	$0x1, -0x24(%rbp)
0000000100004f34	movl	$0x1, %eax
0000000100004f39	subl	%esi, %eax
0000000100004f3b	cmpl	%edx, %eax
0000000100004f3d	jae	0x100004fd7
0000000100004f43	movl	%eax, %eax
0000000100004f45	movq	(%rdi,%rax,8), %rcx
0000000100004f49	subq	0x70e8(%rip), %rcx
0000000100004f50	movq	0x7109(%rip), %rax
0000000100004f57	shlq	$0x10, %rax
0000000100004f5b	cmpq	%rax, %rcx
0000000100004f5e	jae	0x100004fcd
0000000100004f60	movq	0x7119(%rip), %r8
0000000100004f67	movq	%rcx, %rax
0000000100004f6a	shrq	$0x10, %rax
0000000100004f6e	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100004f75	leaq	(%r8,%r9), %rax
0000000100004f79	movzbl	(%r8,%r9), %r8d
0000000100004f7e	cmpb	$0x2, %r8b
0000000100004f82	setne	%r9b
0000000100004f86	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100004f8d	setne	%r10b
0000000100004f91	orb	%r9b, %r10b
0000000100004f94	jne	0x100004f9e
0000000100004f96	addq	$0x228, %rax                    ## imm = 0x228
0000000100004f9c	jmp	0x100004fb9
0000000100004f9e	cmpb	$0x1, %r8b
0000000100004fa2	jne	0x100004fcd
0000000100004fa4	movl	0x20(%rax), %r8d
0000000100004fa8	imulq	%r8, %rcx
0000000100004fac	shrq	$0x20, %rcx
0000000100004fb0	addq	%rcx, %rax
0000000100004fb3	addq	$0x228, %rax                    ## imm = 0x228
0000000100004fb9	movzbl	(%rax), %ecx
0000000100004fbc	testb	%cl, %cl
0000000100004fbe	je	0x100004fcd
0000000100004fc0	cmpb	$-0x2, %cl
0000000100004fc3	jae	0x1000050be
0000000100004fc9	incb	%cl
0000000100004fcb	movb	%cl, (%rax)
0000000100004fcd	movl	$0x2, %eax
0000000100004fd2	subl	%esi, %eax
0000000100004fd4	movl	%eax, -0x24(%rbp)
0000000100004fd7	movl	$0x2, %eax
0000000100004fdc	subl	%esi, %eax
0000000100004fde	cmpl	%edx, %eax
0000000100004fe0	jae	0x100005071
0000000100004fe6	movl	%eax, %eax
0000000100004fe8	movq	(%rdi,%rax,8), %rax
0000000100004fec	subq	0x7045(%rip), %rax
0000000100004ff3	movq	0x7066(%rip), %rcx
0000000100004ffa	shlq	$0x10, %rcx
0000000100004ffe	cmpq	%rcx, %rax
0000000100005001	jae	0x100005067
0000000100005003	movq	0x7076(%rip), %rcx
000000010000500a	movq	%rax, %rdx
000000010000500d	shrq	$0x10, %rdx
0000000100005011	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005018	leaq	(%rcx,%rdx), %rdi
000000010000501c	movzbl	(%rcx,%rdx), %ecx
0000000100005020	cmpb	$0x2, %cl
0000000100005023	setne	%dl
0000000100005026	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000502c	setne	%r8b
0000000100005030	orb	%dl, %r8b
0000000100005033	jne	0x10000503e
0000000100005035	addq	$0x228, %rdi                    ## imm = 0x228
000000010000503c	jmp	0x100005058
000000010000503e	cmpb	$0x1, %cl
0000000100005041	jne	0x100005067
0000000100005043	movl	0x20(%rdi), %ecx
0000000100005046	imulq	%rcx, %rax
000000010000504a	shrq	$0x20, %rax
000000010000504e	addq	%rax, %rdi
0000000100005051	addq	$0x228, %rdi                    ## imm = 0x228
0000000100005058	movzbl	(%rdi), %eax
000000010000505b	testb	%al, %al
000000010000505d	je	0x100005067
000000010000505f	cmpb	$-0x2, %al
0000000100005061	jae	0x1000050b1
0000000100005063	incb	%al
0000000100005065	movb	%al, (%rdi)
0000000100005067	movl	$0x3, %eax
000000010000506c	subl	%esi, %eax
000000010000506e	movl	%eax, -0x24(%rbp)
0000000100005071	cmpq	%rbx, _fwp_cleanups(%rip)
0000000100005078	jne	0x1000050dd
000000010000507a	movq	-0x50(%rbp), %rax
000000010000507e	movq	%rax, _fwp_cleanups(%rip)
0000000100005085	addq	$0x30, %rsp
0000000100005089	popq	%rbx
000000010000508a	popq	%r12
000000010000508c	popq	%r14
000000010000508e	popq	%r15
0000000100005090	popq	%rbp
0000000100005091	retq
0000000100005092	movq	%rdi, %r14
0000000100005095	movq	%rax, %rdi
0000000100005098	movl	%esi, %r15d
000000010000509b	movl	%edx, %r12d
000000010000509e	callq	_fwp_rc_wide_dup
00000001000050a3	movl	%r12d, %edx
00000001000050a6	movq	%r14, %rdi
00000001000050a9	movl	%r15d, %esi
00000001000050ac	jmp	0x100004f2d
00000001000050b1	movl	%esi, %r14d
00000001000050b4	callq	_fwp_rc_wide_dup
00000001000050b9	movl	%r14d, %esi
00000001000050bc	jmp	0x100005067
00000001000050be	movq	%rdi, %r14
00000001000050c1	movq	%rax, %rdi
00000001000050c4	movl	%esi, %r15d
00000001000050c7	movl	%edx, %r12d
00000001000050ca	callq	_fwp_rc_wide_dup
00000001000050cf	movl	%r12d, %edx
00000001000050d2	movq	%r14, %rdi
00000001000050d5	movl	%r15d, %esi
00000001000050d8	jmp	0x100004fcd
00000001000050dd	callq	0x100009600                     ## symbol stub for: _abort
00000001000050e2	nopw	%cs:(%rax,%rax)
_fwp_arg_drop2:
00000001000050f0	pushq	%rbp
00000001000050f1	movq	%rsp, %rbp
00000001000050f4	pushq	%r15
00000001000050f6	pushq	%r14
00000001000050f8	pushq	%rbx
00000001000050f9	pushq	%rax
00000001000050fa	movl	%edx, %r14d
00000001000050fd	movl	%esi, %r15d
0000000100005100	movq	%rdi, %rbx
0000000100005103	testl	%esi, %esi
0000000100005105	setne	%al
0000000100005108	testl	%edx, %edx
000000010000510a	sete	%cl
000000010000510d	orb	%al, %cl
000000010000510f	je	0x100005122
0000000100005111	cmpl	$0x1, %r15d
0000000100005115	jbe	0x10000512a
0000000100005117	cmpl	$0x2, %r15d
000000010000511b	je	0x100005142
000000010000511d	jmp	0x1000051ef
0000000100005122	movq	(%rbx), %rdi
0000000100005125	callq	_fwp_closure_drop
000000010000512a	movl	$0x1, %eax
000000010000512f	subl	%r15d, %eax
0000000100005132	cmpl	%r14d, %eax
0000000100005135	jae	0x100005142
0000000100005137	movl	%eax, %eax
0000000100005139	movq	(%rbx,%rax,8), %rdi
000000010000513d	callq	_fwp_closure_drop
0000000100005142	movl	$0x2, %eax
0000000100005147	subl	%r15d, %eax
000000010000514a	cmpl	%r14d, %eax
000000010000514d	jae	0x1000051ef
0000000100005153	movl	%eax, %eax
0000000100005155	movq	(%rbx,%rax,8), %rdi
0000000100005159	movq	%rdi, %rcx
000000010000515c	subq	0x6ed5(%rip), %rcx
0000000100005163	movq	0x6ef6(%rip), %rax
000000010000516a	shlq	$0x10, %rax
000000010000516e	cmpq	%rax, %rcx
0000000100005171	jae	0x1000051ef
0000000100005173	movq	0x6f06(%rip), %rdx
000000010000517a	movq	%rcx, %rax
000000010000517d	shrq	$0x10, %rax
0000000100005181	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100005188	leaq	(%rdx,%rsi), %rax
000000010000518c	movzbl	(%rdx,%rsi), %edx
0000000100005190	cmpb	$0x2, %dl
0000000100005193	setne	%sil
0000000100005197	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000519e	setne	%r8b
00000001000051a2	orb	%sil, %r8b
00000001000051a5	jne	0x1000051af
00000001000051a7	addq	$0x228, %rax                    ## imm = 0x228
00000001000051ad	jmp	0x1000051c8
00000001000051af	cmpb	$0x1, %dl
00000001000051b2	jne	0x1000051ef
00000001000051b4	movl	0x20(%rax), %edx
00000001000051b7	imulq	%rdx, %rcx
00000001000051bb	shrq	$0x20, %rcx
00000001000051bf	addq	%rcx, %rax
00000001000051c2	addq	$0x228, %rax                    ## imm = 0x228
00000001000051c8	movzbl	(%rax), %ecx
00000001000051cb	testl	%ecx, %ecx
00000001000051cd	je	0x1000051ef
00000001000051cf	cmpl	$0x1, %ecx
00000001000051d2	jne	0x1000051e3
00000001000051d4	addq	$0x8, %rsp
00000001000051d8	popq	%rbx
00000001000051d9	popq	%r14
00000001000051db	popq	%r15
00000001000051dd	popq	%rbp
00000001000051de	jmp	_fwp_rc_free_obj
00000001000051e3	cmpl	$0xff, %ecx
00000001000051e9	je	0x1000051fa
00000001000051eb	decb	%cl
00000001000051ed	movb	%cl, (%rax)
00000001000051ef	addq	$0x8, %rsp
00000001000051f3	popq	%rbx
00000001000051f4	popq	%r14
00000001000051f6	popq	%r15
00000001000051f8	popq	%rbp
00000001000051f9	retq
00000001000051fa	movq	%rax, %rdi
00000001000051fd	addq	$0x8, %rsp
0000000100005201	popq	%rbx
0000000100005202	popq	%r14
0000000100005204	popq	%r15
0000000100005206	popq	%rbp
0000000100005207	jmp	_fwp_rc_wide_drop
000000010000520c	nopl	(%rax)
_fwp_args_release:
0000000100005210	pushq	%rbp
0000000100005211	movq	%rsp, %rbp
0000000100005214	movl	0x14(%rdi), %edx
0000000100005217	movl	$0x0, 0x14(%rdi)
000000010000521e	testl	%edx, %edx
0000000100005220	je	0x100005232
0000000100005222	movq	(%rdi), %rax
0000000100005225	movq	0x8(%rdi), %rcx
0000000100005229	movl	0x10(%rdi), %esi
000000010000522c	movq	%rax, %rdi
000000010000522f	popq	%rbp
0000000100005230	jmpq	*%rcx
0000000100005232	popq	%rbp
0000000100005233	retq
0000000100005234	nopw	%cs:(%rax,%rax)
_fwp_p_file_with_owned:
0000000100005240	pushq	%rbp
0000000100005241	movq	%rsp, %rbp
0000000100005244	pushq	%r15
0000000100005246	pushq	%r14
0000000100005248	pushq	%r13
000000010000524a	pushq	%r12
000000010000524c	pushq	%rbx
000000010000524d	subq	$0x478, %rsp                    ## imm = 0x478
0000000100005254	movq	%rsi, %r12
0000000100005257	movq	%rdi, %rbx
000000010000525a	movq	0x4dcf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005261	movq	(%rax), %rax
0000000100005264	movq	%rax, -0x30(%rbp)
0000000100005268	leaq	0x8(%rdi), %r15
000000010000526c	leaq	0x4898(%rip), %rsi              ## literal pool for: "r+b"
0000000100005273	movq	%r15, %rdi
0000000100005276	callq	0x100009636                     ## symbol stub for: _fopen
000000010000527b	testq	%rax, %rax
000000010000527e	jne	0x100005298
0000000100005280	leaq	0x4888(%rip), %rsi              ## literal pool for: "w+b"
0000000100005287	movq	%r15, %rdi
000000010000528a	callq	0x100009636                     ## symbol stub for: _fopen
000000010000528f	testq	%rax, %rax
0000000100005292	je	0x100005718
0000000100005298	movq	%rax, %r14
000000010000529b	movq	%rbx, -0x478(%rbp)
00000001000052a2	movq	%rax, -0x450(%rbp)
00000001000052a9	movq	$0x0, -0x448(%rbp)
00000001000052b4	movq	_fwp_cleanups(%rip), %rax
00000001000052bb	movq	%rax, -0x430(%rbp)
00000001000052c2	leaq	_fwp_close_owned_scoped_file(%rip), %rax
00000001000052c9	movq	%rax, -0x428(%rbp)
00000001000052d0	leaq	-0x450(%rbp), %rax
00000001000052d7	movq	%rax, -0x420(%rbp)
00000001000052de	leaq	-0x430(%rbp), %rax
00000001000052e5	movq	%rax, _fwp_cleanups(%rip)
00000001000052ec	movq	%r15, %rdi
00000001000052ef	callq	0x1000096f0                     ## symbol stub for: _strlen
00000001000052f4	cmpq	$-0x11, %rax
00000001000052f8	jae	0x1000056c4
00000001000052fe	movq	%rax, %r13
0000000100005301	leaq	0x11(%rax), %rsi
0000000100005305	cmpq	$0x3fef, %rax                   ## imm = 0x3FEF
000000010000530b	movq	%r12, -0x480(%rbp)
0000000100005312	ja	0x10000536e
0000000100005314	leaq	0x20(%r13), %rcx
0000000100005318	shrq	$0x4, %rcx
000000010000531c	leaq	_fwp_gc(%rip), %rax
0000000100005323	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000532b	movl	%ecx, %edx
000000010000532d	movl	0xb48(%rax,%rdx,4), %ecx
0000000100005334	subq	%rcx, _fwp_gc(%rip)
000000010000533b	js	0x10000536e
000000010000533d	leaq	(%rdx,%rdx,2), %rdx
0000000100005341	leaq	(%rax,%rdx,8), %rax
0000000100005345	addq	$0x3c8, %rax                    ## imm = 0x3C8
000000010000534b	movq	(%rax), %rbx
000000010000534e	testq	%rbx, %rbx
0000000100005351	je	0x10000535e
0000000100005353	movq	(%rbx), %rcx
0000000100005356	notq	%rcx
0000000100005359	movq	%rcx, (%rax)
000000010000535c	jmp	0x100005387
000000010000535e	movq	0x8(%rax), %rbx
0000000100005362	movq	0x10(%rax), %rdx
0000000100005366	subq	%rbx, %rdx
0000000100005369	cmpq	%rcx, %rdx
000000010000536c	jae	0x100005380
000000010000536e	movq	%rsi, %rdi
0000000100005371	movl	$0x1, %esi
0000000100005376	callq	_fwp_gc_alloc_slow
000000010000537b	movq	%rax, %r12
000000010000537e	jmp	0x100005392
0000000100005380	addq	%rbx, %rcx
0000000100005383	movq	%rcx, 0x8(%rax)
0000000100005387	movq	%rbx, %rdi
000000010000538a	callq	0x1000095be                     ## symbol stub for: ___bzero
000000010000538f	movq	%rbx, %r12
0000000100005392	movq	%r14, (%r12)
0000000100005396	movq	$0x1, 0x8(%r12)
000000010000539f	movq	%r12, %rcx
00000001000053a2	subq	0x6c8f(%rip), %rcx
00000001000053a9	movq	0x6cb0(%rip), %rax
00000001000053b0	shlq	$0x10, %rax
00000001000053b4	cmpq	%rax, %rcx
00000001000053b7	jae	0x100005427
00000001000053b9	movq	0x6cc0(%rip), %rdx
00000001000053c0	movq	%rcx, %rax
00000001000053c3	shrq	$0x10, %rax
00000001000053c7	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000053ce	leaq	(%rdx,%rsi), %rbx
00000001000053d2	movzbl	(%rdx,%rsi), %edx
00000001000053d6	cmpb	$0x2, %dl
00000001000053d9	setne	%sil
00000001000053dd	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000053e4	setne	%dil
00000001000053e8	orb	%sil, %dil
00000001000053eb	jne	0x1000053fe
00000001000053ed	addq	$0x228, %rbx                    ## imm = 0x228
00000001000053f4	cmpb	$-0x1, (%rbx)
00000001000053f7	je	0x10000541d
00000001000053f9	movb	$0x1, (%rbx)
00000001000053fc	jmp	0x100005427
00000001000053fe	cmpb	$0x1, %dl
0000000100005401	jne	0x100005427
0000000100005403	movl	0x20(%rbx), %edx
0000000100005406	imulq	%rdx, %rcx
000000010000540a	shrq	$0x20, %rcx
000000010000540e	addq	%rcx, %rbx
0000000100005411	addq	$0x228, %rbx                    ## imm = 0x228
0000000100005418	cmpb	$-0x1, (%rbx)
000000010000541b	jne	0x1000053f9
000000010000541d	movq	%rbx, %rdi
0000000100005420	callq	_fwp_rc_forget_slot
0000000100005425	jmp	0x1000053f9
0000000100005427	movq	%r12, -0x448(%rbp)
000000010000542e	leaq	0x10(%r12), %rdi
0000000100005433	incq	%r13
0000000100005436	movq	%r15, %rsi
0000000100005439	movq	%r13, %rdx
000000010000543c	callq	0x100009678                     ## symbol stub for: _memcpy
0000000100005441	leaq	-0x430(%rbp), %rdi
0000000100005448	cmpq	%rdi, _fwp_cleanups(%rip)
000000010000544f	jne	0x1000056bf
0000000100005455	movq	-0x430(%rbp), %rax
000000010000545c	movq	%r12, -0x488(%rbp)
0000000100005463	movq	%r14, -0x460(%rbp)
000000010000546a	movq	%r12, -0x458(%rbp)
0000000100005471	movq	%rax, -0x450(%rbp)
0000000100005478	leaq	_fwp_close_owned_scoped_file(%rip), %rcx
000000010000547f	movq	%rcx, -0x448(%rbp)
0000000100005486	leaq	-0x460(%rbp), %rcx
000000010000548d	movq	%rcx, -0x440(%rbp)
0000000100005494	leaq	-0x450(%rbp), %r13
000000010000549b	movq	%r13, _fwp_cleanups(%rip)
00000001000054a2	movq	_fwp_handlers(%rip), %rcx
00000001000054a9	movq	%rcx, -0x398(%rbp)
00000001000054b0	movq	_fwp_state_len(%rip), %rcx
00000001000054b7	movq	%rcx, -0x380(%rbp)
00000001000054be	movq	%rax, -0x378(%rbp)
00000001000054c5	movq	%rdi, _fwp_handlers(%rip)
00000001000054cc	callq	0x1000096b4                     ## symbol stub for: _setjmp
00000001000054d1	testl	%eax, %eax
00000001000054d3	jne	0x1000056f2
00000001000054d9	leaq	-0x488(%rbp), %rsi
00000001000054e0	movq	-0x480(%rbp), %r12
00000001000054e7	movq	%r12, %rdi
00000001000054ea	callq	_fwp_apply_borrowed
00000001000054ef	movq	-0x398(%rbp), %rcx
00000001000054f6	movq	%rcx, _fwp_handlers(%rip)
00000001000054fd	movq	%rax, -0x470(%rbp)
0000000100005504	leaq	_fwp_drop6(%rip), %rcx
000000010000550b	movq	%rcx, -0x468(%rbp)
0000000100005512	movq	_fwp_cleanups(%rip), %rcx
0000000100005519	movq	%rcx, -0x4a0(%rbp)
0000000100005520	leaq	_fwp_value_release(%rip), %rcx
0000000100005527	movq	%rcx, -0x498(%rbp)
000000010000552e	leaq	-0x470(%rbp), %rcx
0000000100005535	movq	%rcx, -0x490(%rbp)
000000010000553c	leaq	-0x4a0(%rbp), %rbx
0000000100005543	movq	%rbx, _fwp_cleanups(%rip)
000000010000554a	movq	0x8(%rax), %r15
000000010000554e	movq	%r15, %rdx
0000000100005551	subq	0x6ae0(%rip), %rdx
0000000100005558	movq	0x6b01(%rip), %rcx
000000010000555f	shlq	$0x10, %rcx
0000000100005563	cmpq	%rcx, %rdx
0000000100005566	jae	0x1000055d9
0000000100005568	movq	0x6b11(%rip), %rsi
000000010000556f	movq	%rdx, %rcx
0000000100005572	shrq	$0x10, %rcx
0000000100005576	imulq	$0x1228, %rcx, %rdi             ## imm = 0x1228
000000010000557d	leaq	(%rsi,%rdi), %rcx
0000000100005581	movzbl	(%rsi,%rdi), %esi
0000000100005585	cmpb	$0x2, %sil
0000000100005589	setne	%dil
000000010000558d	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100005594	setne	%r8b
0000000100005598	orb	%dil, %r8b
000000010000559b	jne	0x1000055a9
000000010000559d	addq	$0x228, %rcx                    ## imm = 0x228
00000001000055a4	movq	%rcx, %rdi
00000001000055a7	jmp	0x1000055c5
00000001000055a9	cmpb	$0x1, %sil
00000001000055ad	jne	0x1000055d9
00000001000055af	movl	0x20(%rcx), %esi
00000001000055b2	imulq	%rsi, %rdx
00000001000055b6	shrq	$0x20, %rdx
00000001000055ba	leaq	(%rcx,%rdx), %rdi
00000001000055be	addq	$0x228, %rdi                    ## imm = 0x228
00000001000055c5	movzbl	(%rdi), %ecx
00000001000055c8	testb	%cl, %cl
00000001000055ca	je	0x1000055d9
00000001000055cc	cmpb	$-0x2, %cl
00000001000055cf	jae	0x1000056a1
00000001000055d5	incb	%cl
00000001000055d7	movb	%cl, (%rdi)
00000001000055d9	cmpq	$0x0, -0x468(%rbp)
00000001000055e1	je	0x1000055fe
00000001000055e3	cmpq	%rbx, _fwp_cleanups(%rip)
00000001000055ea	jne	0x1000056bf
00000001000055f0	movq	-0x4a0(%rbp), %rcx
00000001000055f7	movq	%rcx, _fwp_cleanups(%rip)
00000001000055fe	movq	%rax, %rdi
0000000100005601	movq	$0x0, -0x470(%rbp)
000000010000560c	callq	_fwp_drop6
0000000100005611	cmpq	%r13, _fwp_cleanups(%rip)
0000000100005618	jne	0x1000056bf
000000010000561e	movq	-0x450(%rbp), %rax
0000000100005625	movq	%rax, _fwp_cleanups(%rip)
000000010000562c	movq	-0x458(%rbp), %rbx
0000000100005633	testq	%rbx, %rbx
0000000100005636	je	0x10000564e
0000000100005638	movq	(%rbx), %rdi
000000010000563b	testq	%rdi, %rdi
000000010000563e	je	0x10000565a
0000000100005640	callq	0x100009624                     ## symbol stub for: _fclose
0000000100005645	movq	$0x0, (%rbx)
000000010000564c	jmp	0x10000565a
000000010000564e	movq	-0x460(%rbp), %rdi
0000000100005655	callq	0x100009624                     ## symbol stub for: _fclose
000000010000565a	movq	-0x458(%rbp), %rdi
0000000100005661	movq	$0x0, -0x458(%rbp)
000000010000566c	callq	_fwp_file_drop
0000000100005671	movq	-0x478(%rbp), %rax
0000000100005678	movq	0x49b1(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000567f	movq	(%rax), %rax
0000000100005682	cmpq	-0x30(%rbp), %rax
0000000100005686	jne	0x100005713
000000010000568c	movq	%r15, %rax
000000010000568f	addq	$0x478, %rsp                    ## imm = 0x478
0000000100005696	popq	%rbx
0000000100005697	popq	%r12
0000000100005699	popq	%r13
000000010000569b	popq	%r14
000000010000569d	popq	%r15
000000010000569f	popq	%rbp
00000001000056a0	retq
00000001000056a1	movq	%rax, %r14
00000001000056a4	callq	_fwp_rc_wide_dup
00000001000056a9	movq	%r14, %rax
00000001000056ac	cmpq	$0x0, -0x468(%rbp)
00000001000056b4	jne	0x1000055e3
00000001000056ba	jmp	0x1000055fe
00000001000056bf	callq	0x100009600                     ## symbol stub for: _abort
00000001000056c4	callq	_fwp_flush
00000001000056c9	movq	0x4968(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000056d0	movq	(%rax), %rdi
00000001000056d3	leaq	0x425a(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000056da	leaq	0x443e(%rip), %rdx              ## literal pool for: "file path too long"
00000001000056e1	xorl	%eax, %eax
00000001000056e3	callq	0x10000963c                     ## symbol stub for: _fprintf
00000001000056e8	movl	$0x65, %edi
00000001000056ed	callq	0x10000961e                     ## symbol stub for: _exit
00000001000056f2	movq	-0x398(%rbp), %rax
00000001000056f9	movq	-0x390(%rbp), %rdi
0000000100005700	movq	%rax, _fwp_handlers(%rip)
0000000100005707	movq	-0x388(%rbp), %rsi
000000010000570e	callq	_fwp_fail
0000000100005713	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100005718	callq	0x1000095ca                     ## symbol stub for: ___error
000000010000571d	movl	(%rax), %edi
000000010000571f	callq	0x1000096ea                     ## symbol stub for: _strerror
0000000100005724	movq	%rax, %r8
0000000100005727	leaq	0x43ea(%rip), %rdx              ## literal pool for: "%s: %s"
000000010000572e	xorl	%eax, %eax
0000000100005730	leaq	-0x430(%rbp), %rbx
0000000100005737	movl	$0x400, %esi                    ## imm = 0x400
000000010000573c	movq	%rbx, %rdi
000000010000573f	movq	%r15, %rcx
0000000100005742	callq	0x1000096d2                     ## symbol stub for: _snprintf
0000000100005747	leaq	0x43c5(%rip), %rdi              ## literal pool for: "open"
000000010000574e	movl	$0x4, %esi
0000000100005753	callq	_fwp_str_new
0000000100005758	movq	%rax, %r14
000000010000575b	movq	%rax, -0x450(%rbp)
0000000100005762	movq	%rbx, %rdi
0000000100005765	callq	0x1000096f0                     ## symbol stub for: _strlen
000000010000576a	movq	%rbx, %rdi
000000010000576d	movq	%rax, %rsi
0000000100005770	callq	_fwp_str_new
0000000100005775	movq	%rax, %rbx
0000000100005778	movq	%rax, -0x448(%rbp)
000000010000577f	movl	$0x18, %edi
0000000100005784	callq	_fwp_alloc_init
0000000100005789	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100005793	movq	%rcx, (%rax)
0000000100005796	movq	%r14, 0x8(%rax)
000000010000579a	movq	%rbx, 0x10(%rax)
000000010000579e	leaq	-0x450(%rbp), %rcx
00000001000057a5	leaq	_d0(%rip), %rsi
00000001000057ac	movq	%rax, %rdi
00000001000057af	callq	_fwp_fail
00000001000057b4	nopw	%cs:(%rax,%rax)
_fwp_drop6:
00000001000057c0	movq	0x6871(%rip), %rcx
00000001000057c7	movq	%rdi, %r8
00000001000057ca	subq	%rcx, %r8
00000001000057cd	movq	0x688c(%rip), %rsi
00000001000057d4	shlq	$0x10, %rsi
00000001000057d8	cmpq	%rsi, %r8
00000001000057db	jae	0x1000058ab
00000001000057e1	movq	0x6898(%rip), %rdx
00000001000057e8	movq	%r8, %rax
00000001000057eb	shrq	$0x10, %rax
00000001000057ef	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
00000001000057f6	leaq	(%rdx,%r9), %rax
00000001000057fa	movzbl	(%rdx,%r9), %r9d
00000001000057ff	cmpb	$0x2, %r9b
0000000100005803	setne	%r10b
0000000100005807	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000580e	setne	%r11b
0000000100005812	orb	%r10b, %r11b
0000000100005815	jne	0x10000581f
0000000100005817	addq	$0x228, %rax                    ## imm = 0x228
000000010000581d	jmp	0x10000583e
000000010000581f	cmpb	$0x1, %r9b
0000000100005823	jne	0x1000058ab
0000000100005829	movl	0x20(%rax), %r9d
000000010000582d	imulq	%r9, %r8
0000000100005831	shrq	$0x20, %r8
0000000100005835	addq	%r8, %rax
0000000100005838	addq	$0x228, %rax                    ## imm = 0x228
000000010000583e	movzbl	(%rax), %r8d
0000000100005842	testl	%r8d, %r8d
0000000100005845	je	0x1000058ab
0000000100005847	cmpl	$0x1, %r8d
000000010000584b	jne	0x10000589c
000000010000584d	pushq	%rbp
000000010000584e	movq	%rsp, %rbp
0000000100005851	pushq	%rbx
0000000100005852	pushq	%rax
0000000100005853	movq	0x8(%rdi), %rax
0000000100005857	movq	%rax, %r8
000000010000585a	subq	%rcx, %r8
000000010000585d	cmpq	%rsi, %r8
0000000100005860	jae	0x1000058ee
0000000100005866	movq	%r8, %rcx
0000000100005869	shrq	$0x10, %rcx
000000010000586d	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100005874	leaq	(%rdx,%rsi), %rcx
0000000100005878	movzbl	(%rdx,%rsi), %edx
000000010000587c	cmpb	$0x2, %dl
000000010000587f	setne	%sil
0000000100005883	andq	$0xffff, %r8                    ## imm = 0xFFFF
000000010000588a	setne	%r9b
000000010000588e	orb	%sil, %r9b
0000000100005891	jne	0x1000058ac
0000000100005893	addq	$0x228, %rcx                    ## imm = 0x228
000000010000589a	jmp	0x1000058c6
000000010000589c	cmpl	$0xff, %r8d
00000001000058a3	je	0x10000590b
00000001000058a5	decb	%r8b
00000001000058a8	movb	%r8b, (%rax)
00000001000058ab	retq
00000001000058ac	cmpb	$0x1, %dl
00000001000058af	jne	0x1000058ee
00000001000058b1	movl	0x20(%rcx), %edx
00000001000058b4	imulq	%rdx, %r8
00000001000058b8	shrq	$0x20, %r8
00000001000058bc	addq	%r8, %rcx
00000001000058bf	addq	$0x228, %rcx                    ## imm = 0x228
00000001000058c6	movzbl	(%rcx), %edx
00000001000058c9	testl	%edx, %edx
00000001000058cb	je	0x1000058ee
00000001000058cd	cmpl	$0x1, %edx
00000001000058d0	jne	0x1000058e2
00000001000058d2	movq	%rdi, %rbx
00000001000058d5	movq	%rax, %rdi
00000001000058d8	callq	_fwp_rc_free_obj
00000001000058dd	movq	%rbx, %rdi
00000001000058e0	jmp	0x1000058ee
00000001000058e2	cmpl	$0xff, %edx
00000001000058e8	je	0x100005913
00000001000058ea	decb	%dl
00000001000058ec	movb	%dl, (%rcx)
00000001000058ee	movq	0x10(%rdi), %rax
00000001000058f2	movq	%rdi, %rbx
00000001000058f5	movq	%rax, %rdi
00000001000058f8	callq	_fwp_file_drop
00000001000058fd	movq	%rbx, %rdi
0000000100005900	addq	$0x8, %rsp
0000000100005904	popq	%rbx
0000000100005905	popq	%rbp
0000000100005906	jmp	_fwp_rc_free_obj
000000010000590b	movq	%rax, %rdi
000000010000590e	jmp	_fwp_rc_wide_drop
0000000100005913	movq	%rdi, %rbx
0000000100005916	movq	%rcx, %rdi
0000000100005919	callq	_fwp_rc_wide_drop
000000010000591e	jmp	0x1000058dd
_fwp_close_owned_scoped_file:
0000000100005920	pushq	%rbp
0000000100005921	movq	%rsp, %rbp
0000000100005924	pushq	%r14
0000000100005926	pushq	%rbx
0000000100005927	movq	%rdi, %rbx
000000010000592a	movq	0x8(%rdi), %r14
000000010000592e	testq	%r14, %r14
0000000100005931	je	0x100005949
0000000100005933	movq	(%r14), %rdi
0000000100005936	testq	%rdi, %rdi
0000000100005939	je	0x100005951
000000010000593b	callq	0x100009624                     ## symbol stub for: _fclose
0000000100005940	movq	$0x0, (%r14)
0000000100005947	jmp	0x100005951
0000000100005949	movq	(%rbx), %rdi
000000010000594c	callq	0x100009624                     ## symbol stub for: _fclose
0000000100005951	movq	0x8(%rbx), %rdi
0000000100005955	movq	$0x0, 0x8(%rbx)
000000010000595d	popq	%rbx
000000010000595e	popq	%r14
0000000100005960	popq	%rbp
0000000100005961	jmp	_fwp_file_drop
0000000100005966	nopw	%cs:(%rax,%rax)
_fwp_fail:
0000000100005970	pushq	%rbp
0000000100005971	movq	%rsp, %rbp
0000000100005974	pushq	%r15
0000000100005976	pushq	%r14
0000000100005978	pushq	%rbx
0000000100005979	pushq	%rax
000000010000597a	movq	_fwp_handlers(%rip), %rax
0000000100005981	testq	%rax, %rax
0000000100005984	jne	0x1000059d6
0000000100005986	movq	%rsi, %rbx
0000000100005989	movq	%rdi, %r14
000000010000598c	callq	_fwp_flush
0000000100005991	movq	0x46a0(%rip), %r15              ## literal pool symbol address: ___stderrp
0000000100005998	movq	(%r15), %rcx
000000010000599b	leaq	0x4190(%rip), %rdi              ## literal pool for: "error: "
00000001000059a2	movl	$0x7, %esi
00000001000059a7	movl	$0x1, %edx
00000001000059ac	callq	0x100009654                     ## symbol stub for: _fwrite
00000001000059b1	movq	(%r15), %rdx
00000001000059b4	movq	%r14, %rdi
00000001000059b7	movq	%rbx, %rsi
00000001000059ba	callq	_fwp_display_top
00000001000059bf	movq	(%r15), %rsi
00000001000059c2	movl	$0xa, %edi
00000001000059c7	callq	0x100009642                     ## symbol stub for: _fputc
00000001000059cc	movl	$0x1, %edi
00000001000059d1	callq	0x10000961e                     ## symbol stub for: _exit
00000001000059d6	movq	%rdi, 0xa0(%rax)
00000001000059dd	movq	%rsi, 0xa8(%rax)
00000001000059e4	movq	0xb8(%rax), %rdi
00000001000059eb	callq	_fwp_cleanup_unwind
00000001000059f0	movq	_fwp_handlers(%rip), %rdi
00000001000059f7	movl	$0x1, %esi
00000001000059fc	callq	0x10000966c                     ## symbol stub for: _longjmp
0000000100005a01	nopw	%cs:(%rax,%rax)
_fwp_str_new:
0000000100005a10	pushq	%rbp
0000000100005a11	movq	%rsp, %rbp
0000000100005a14	pushq	%r15
0000000100005a16	pushq	%r14
0000000100005a18	pushq	%rbx
0000000100005a19	pushq	%rax
0000000100005a1a	movq	%rsi, %r14
0000000100005a1d	movq	%rdi, %rbx
0000000100005a20	addq	$0x9, %rsi
0000000100005a24	cmpq	$0x4000, %rsi                   ## imm = 0x4000
0000000100005a2b	ja	0x100005a86
0000000100005a2d	leaq	0x18(%r14), %rax
0000000100005a31	shrq	$0x4, %rax
0000000100005a35	leaq	_fwp_gc(%rip), %rcx
0000000100005a3c	movzbl	0xbe8(%rax,%rcx), %edx
0000000100005a44	movl	0xb48(%rcx,%rdx,4), %eax
0000000100005a4b	subq	%rax, _fwp_gc(%rip)
0000000100005a52	js	0x100005a86
0000000100005a54	leaq	(%rdx,%rdx,2), %rdx
0000000100005a58	leaq	(%rcx,%rdx,8), %rcx
0000000100005a5c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100005a63	movq	(%rcx), %r15
0000000100005a66	testq	%r15, %r15
0000000100005a69	je	0x100005a76
0000000100005a6b	movq	(%r15), %rax
0000000100005a6e	notq	%rax
0000000100005a71	movq	%rax, (%rcx)
0000000100005a74	jmp	0x100005a9f
0000000100005a76	movq	0x8(%rcx), %r15
0000000100005a7a	movq	0x10(%rcx), %rdx
0000000100005a7e	subq	%r15, %rdx
0000000100005a81	cmpq	%rax, %rdx
0000000100005a84	jae	0x100005a98
0000000100005a86	movq	%rsi, %rdi
0000000100005a89	movl	$0x1, %esi
0000000100005a8e	callq	_fwp_gc_alloc_slow
0000000100005a93	movq	%rax, %r15
0000000100005a96	jmp	0x100005aa7
0000000100005a98	addq	%r15, %rax
0000000100005a9b	movq	%rax, 0x8(%rcx)
0000000100005a9f	movq	%r15, %rdi
0000000100005aa2	callq	0x1000095be                     ## symbol stub for: ___bzero
0000000100005aa7	movq	%r14, (%r15)
0000000100005aaa	leaq	0x8(%r15), %rdi
0000000100005aae	movq	%rbx, %rsi
0000000100005ab1	movq	%r14, %rdx
0000000100005ab4	callq	0x100009678                     ## symbol stub for: _memcpy
0000000100005ab9	movb	$0x0, 0x8(%r15,%r14)
0000000100005abf	movq	%r15, %rax
0000000100005ac2	addq	$0x8, %rsp
0000000100005ac6	popq	%rbx
0000000100005ac7	popq	%r14
0000000100005ac9	popq	%r15
0000000100005acb	popq	%rbp
0000000100005acc	retq
0000000100005acd	nopl	(%rax)
_fwp_file_drop:
0000000100005ad0	testq	%rdi, %rdi
0000000100005ad3	je	0x100005c20
0000000100005ad9	pushq	%rbp
0000000100005ada	movq	%rsp, %rbp
0000000100005add	pushq	%rbx
0000000100005ade	pushq	%rax
0000000100005adf	movq	0x8(%rdi), %rax
0000000100005ae3	testq	%rax, %rax
0000000100005ae6	je	0x100005c1a
0000000100005aec	decq	%rax
0000000100005aef	movq	%rax, 0x8(%rdi)
0000000100005af3	jne	0x100005c1a
0000000100005af9	movq	(%rdi), %rax
0000000100005afc	testq	%rax, %rax
0000000100005aff	je	0x100005b16
0000000100005b01	movq	%rdi, %rbx
0000000100005b04	movq	%rax, %rdi
0000000100005b07	callq	0x100009624                     ## symbol stub for: _fclose
0000000100005b0c	movq	%rbx, %rdi
0000000100005b0f	movq	$0x0, (%rbx)
0000000100005b16	movq	%rdi, %rax
0000000100005b19	subq	0x6518(%rip), %rax
0000000100005b20	movq	0x6539(%rip), %rcx
0000000100005b27	shlq	$0x10, %rcx
0000000100005b2b	cmpq	%rcx, %rax
0000000100005b2e	jae	0x100005c1a
0000000100005b34	movq	0x6545(%rip), %rdx
0000000100005b3b	movq	%rax, %rcx
0000000100005b3e	shrq	$0x10, %rcx
0000000100005b42	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100005b49	leaq	(%rdx,%rsi), %rcx
0000000100005b4d	movzbl	(%rdx,%rsi), %edx
0000000100005b51	cmpb	$0x2, %dl
0000000100005b54	setne	%sil
0000000100005b58	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005b5e	setne	%r8b
0000000100005b62	orb	%sil, %r8b
0000000100005b65	jne	0x100005b78
0000000100005b67	addq	$0x228, %rcx                    ## imm = 0x228
0000000100005b6e	cmpb	$0x1, (%rcx)
0000000100005b71	je	0x100005b9b
0000000100005b73	jmp	0x100005c1a
0000000100005b78	cmpb	$0x1, %dl
0000000100005b7b	jne	0x100005c1a
0000000100005b81	movl	0x20(%rcx), %edx
0000000100005b84	imulq	%rdx, %rax
0000000100005b88	shrq	$0x20, %rax
0000000100005b8c	addq	%rax, %rcx
0000000100005b8f	addq	$0x228, %rcx                    ## imm = 0x228
0000000100005b96	cmpb	$0x1, (%rcx)
0000000100005b99	jne	0x100005c1a
0000000100005b9b	movl	_fwp_reuse_verify(%rip), %ecx
0000000100005ba1	testl	%ecx, %ecx
0000000100005ba3	jns	0x100005be5
0000000100005ba5	movq	%rdi, %rbx
0000000100005ba8	leaq	0x3e33(%rip), %rdi              ## literal pool for: "FWP_REUSE_VERIFY"
0000000100005baf	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100005bb4	testq	%rax, %rax
0000000100005bb7	je	0x100005bd3
0000000100005bb9	movzbl	(%rax), %ecx
0000000100005bbc	testl	%ecx, %ecx
0000000100005bbe	je	0x100005bd5
0000000100005bc0	cmpl	$0x30, %ecx
0000000100005bc3	movq	%rbx, %rdi
0000000100005bc6	jne	0x100005bda
0000000100005bc8	xorl	%ecx, %ecx
0000000100005bca	cmpb	$0x0, 0x1(%rax)
0000000100005bce	setne	%cl
0000000100005bd1	jmp	0x100005bdf
0000000100005bd3	xorl	%ecx, %ecx
0000000100005bd5	movq	%rbx, %rdi
0000000100005bd8	jmp	0x100005bdf
0000000100005bda	movl	$0x1, %ecx
0000000100005bdf	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100005be5	testl	%ecx, %ecx
0000000100005be7	je	0x100005bef
0000000100005be9	movb	$0x0, 0x10(%rdi)
0000000100005bed	jmp	0x100005c1a
0000000100005bef	movq	_fwp_gc(%rip), %rbx
0000000100005bf6	callq	_fwp_mem_free
0000000100005bfb	movq	_fwp_gc(%rip), %rax
0000000100005c02	subq	%rbx, %rax
0000000100005c05	cvtsi2sd	%rax, %xmm0
0000000100005c0a	addsd	0x65fe(%rip), %xmm0
0000000100005c12	movsd	%xmm0, 0x65f6(%rip)
0000000100005c1a	addq	$0x8, %rsp
0000000100005c1e	popq	%rbx
0000000100005c1f	popq	%rbp
0000000100005c20	retq
0000000100005c21	nopw	%cs:(%rax,%rax)
_fwp_display_top:
0000000100005c30	pushq	%rbp
0000000100005c31	movq	%rsp, %rbp
0000000100005c34	pushq	%rbx
0000000100005c35	subq	$0x18, %rsp
0000000100005c39	movq	%rdx, %rbx
0000000100005c3c	movq	%rsi, %rdx
0000000100005c3f	movq	%rdi, %rsi
0000000100005c42	xorps	%xmm0, %xmm0
0000000100005c45	movaps	%xmm0, -0x20(%rbp)
0000000100005c49	movq	$0x0, -0x10(%rbp)
0000000100005c51	leaq	-0x20(%rbp), %rdi
0000000100005c55	movl	$0x1, %ecx
0000000100005c5a	callq	_fwp_write
0000000100005c5f	movq	-0x20(%rbp), %rdi
0000000100005c63	testq	%rdi, %rdi
0000000100005c66	je	0x100005c7f
0000000100005c68	movq	-0x18(%rbp), %rdx
0000000100005c6c	movl	$0x1, %esi
0000000100005c71	movq	%rbx, %rcx
0000000100005c74	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100005c79	movq	-0x20(%rbp), %rdi
0000000100005c7d	jmp	0x100005c81
0000000100005c7f	xorl	%edi, %edi
0000000100005c81	callq	0x10000964e                     ## symbol stub for: _free
0000000100005c86	addq	$0x18, %rsp
0000000100005c8a	popq	%rbx
0000000100005c8b	popq	%rbp
0000000100005c8c	retq
0000000100005c8d	nopl	(%rax)
_fwp_write:
0000000100005c90	pushq	%rbp
0000000100005c91	movq	%rsp, %rbp
0000000100005c94	pushq	%r15
0000000100005c96	pushq	%r14
0000000100005c98	pushq	%r13
0000000100005c9a	pushq	%r12
0000000100005c9c	pushq	%rbx
0000000100005c9d	subq	$0x268, %rsp                    ## imm = 0x268
0000000100005ca4	movq	0x4385(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005cab	movq	(%rax), %rax
0000000100005cae	movq	%rax, -0x30(%rbp)
0000000100005cb2	movl	(%rdx), %eax
0000000100005cb4	cmpq	$0x19, %rax
0000000100005cb8	ja	0x100006f7b
0000000100005cbe	movq	%rdx, %r15
0000000100005cc1	movq	%rsi, %r14
0000000100005cc4	movq	%rdi, %r13
0000000100005cc7	leaq	0x141e(%rip), %rdx
0000000100005cce	movslq	(%rdx,%rax,4), %rsi
0000000100005cd2	addq	%rdx, %rsi
0000000100005cd5	movq	%rdi, -0x278(%rbp)
0000000100005cdc	jmpq	*%rsi
0000000100005cde	leaq	0x3e55(%rip), %rdx              ## literal pool for: "%lld"
0000000100005ce5	jmp	0x100005cee
0000000100005ce7	leaq	0x3e51(%rip), %rdx              ## literal pool for: "%llu"
0000000100005cee	leaq	-0x270(%rbp), %rbx
0000000100005cf5	movl	$0x200, %esi                    ## imm = 0x200
0000000100005cfa	movq	%rbx, %rdi
0000000100005cfd	movq	%r14, %rcx
0000000100005d00	xorl	%eax, %eax
0000000100005d02	callq	0x1000096d2                     ## symbol stub for: _snprintf
0000000100005d07	jmp	0x100006f65
0000000100005d0c	cmpl	$0x13, %eax
0000000100005d0f	leaq	0x3e63(%rip), %rax              ## literal pool for: "set{"
0000000100005d16	leaq	0x3e61(%rip), %rsi              ## literal pool for: "map{"
0000000100005d1d	cmoveq	%rax, %rsi
0000000100005d21	movl	$0x4, %edx
0000000100005d26	movq	%r13, %rdi
0000000100005d29	callq	_buf_put
0000000100005d2e	cmpq	$0x0, (%r14)
0000000100005d32	je	0x100005e0e
0000000100005d38	movq	0x38(%r15), %rdx
0000000100005d3c	movq	0x8(%r14), %rsi
0000000100005d40	movq	-0x278(%rbp), %rbx
0000000100005d47	movq	%rbx, %rdi
0000000100005d4a	xorl	%ecx, %ecx
0000000100005d4c	callq	_fwp_write
0000000100005d51	cmpl	$0x12, (%r15)
0000000100005d55	jne	0x100005d7d
0000000100005d57	leaq	0x3e25(%rip), %rsi              ## literal pool for: ": "
0000000100005d5e	movl	$0x2, %edx
0000000100005d63	movq	%rbx, %rdi
0000000100005d66	callq	_buf_put
0000000100005d6b	movq	0x10(%r14), %rsi
0000000100005d6f	movq	0x40(%r15), %rdx
0000000100005d73	movq	%rbx, %rdi
0000000100005d76	xorl	%ecx, %ecx
0000000100005d78	callq	_fwp_write
0000000100005d7d	cmpq	$0x2, (%r14)
0000000100005d81	jb	0x100005e0e
0000000100005d87	leaq	0x20(%r14), %r13
0000000100005d8b	movl	$0x1, %r12d
0000000100005d91	jmp	0x100005dac
0000000100005d93	nopw	%cs:(%rax,%rax)
0000000100005da0	incq	%r12
0000000100005da3	addq	$0x10, %r13
0000000100005da7	cmpq	(%r14), %r12
0000000100005daa	jae	0x100005e0e
0000000100005dac	movl	$0x2, %edx
0000000100005db1	movq	-0x278(%rbp), %rbx
0000000100005db8	movq	%rbx, %rdi
0000000100005dbb	leaq	0x3daa(%rip), %rsi              ## literal pool for: ", "
0000000100005dc2	callq	_buf_put
0000000100005dc7	movq	-0x8(%r13), %rsi
0000000100005dcb	movq	0x38(%r15), %rdx
0000000100005dcf	movq	%rbx, %rdi
0000000100005dd2	xorl	%ecx, %ecx
0000000100005dd4	callq	_fwp_write
0000000100005dd9	cmpl	$0x12, (%r15)
0000000100005ddd	jne	0x100005da0
0000000100005ddf	movl	$0x2, %edx
0000000100005de4	movq	-0x278(%rbp), %rbx
0000000100005deb	movq	%rbx, %rdi
0000000100005dee	leaq	0x3d8e(%rip), %rsi              ## literal pool for: ": "
0000000100005df5	callq	_buf_put
0000000100005dfa	movq	(%r13), %rsi
0000000100005dfe	movq	0x40(%r15), %rdx
0000000100005e02	movq	%rbx, %rdi
0000000100005e05	xorl	%ecx, %ecx
0000000100005e07	callq	_fwp_write
0000000100005e0c	jmp	0x100005da0
0000000100005e0e	movb	$0x7d, -0x270(%rbp)
0000000100005e15	leaq	-0x270(%rbp), %rsi
0000000100005e1c	movl	$0x1, %edx
0000000100005e21	movq	-0x278(%rbp), %rdi
0000000100005e28	jmp	0x100006f76
0000000100005e2d	movq	0x8(%r15), %rbx
0000000100005e31	testq	%rbx, %rbx
0000000100005e34	je	0x100006828
0000000100005e3a	leaq	0x3d45(%rip), %rsi              ## literal pool for: "Duration"
0000000100005e41	movq	%rbx, %rdi
0000000100005e44	callq	0x1000096e4                     ## symbol stub for: _strcmp
0000000100005e49	testl	%eax, %eax
0000000100005e4b	je	0x100006ad3
0000000100005e51	movq	%r15, -0x280(%rbp)
0000000100005e58	addq	$0x10, %r15
0000000100005e5c	movq	%rbx, %rdi
0000000100005e5f	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100005e64	movq	%r13, %rdi
0000000100005e67	movq	%rbx, %rsi
0000000100005e6a	movq	%rax, %rdx
0000000100005e6d	callq	_buf_put
0000000100005e72	movb	$0x20, -0x270(%rbp)
0000000100005e79	leaq	-0x270(%rbp), %rsi
0000000100005e80	movl	$0x1, %edx
0000000100005e85	movq	%r13, %rdi
0000000100005e88	callq	_buf_put
0000000100005e8d	xorl	%r12d, %r12d
0000000100005e90	jmp	0x100006849
0000000100005e95	cmpq	$0xfff, %r14                    ## imm = 0xFFF
0000000100005e9c	ja	0x100006664
0000000100005ea2	movl	%r14d, %eax
0000000100005ea5	jmp	0x100006667
0000000100005eaa	movq	%r14, %xmm0
0000000100005eaf	movq	%xmm0, -0x278(%rbp)
0000000100005eb7	ucomisd	%xmm0, %xmm0
0000000100005ebb	jp	0x1000070dd
0000000100005ec1	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100005ecb	andq	%r14, %rax
0000000100005ece	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
0000000100005ed8	cmpq	%rcx, %rax
0000000100005edb	je	0x1000067e8
0000000100005ee1	movl	$0x1, %ebx
0000000100005ee6	leaq	-0x270(%rbp), %r14
0000000100005eed	nopl	(%rax)
0000000100005ef0	movq	%r14, %rdi
0000000100005ef3	movsd	-0x278(%rbp), %xmm0
0000000100005efb	movl	%ebx, %esi
0000000100005efd	callq	_fwp_format_g
0000000100005f02	movq	%r14, %rdi
0000000100005f05	xorl	%esi, %esi
0000000100005f07	callq	0x1000096fc                     ## symbol stub for: _strtod
0000000100005f0c	ucomisd	-0x278(%rbp), %xmm0
0000000100005f14	jne	0x100005f1c
0000000100005f16	jnp	0x100006579
0000000100005f1c	incl	%ebx
0000000100005f1e	cmpl	$0x12, %ebx
0000000100005f21	jne	0x100005ef0
0000000100005f23	leaq	-0x270(%rbp), %rbx
0000000100005f2a	movq	%rbx, %rdi
0000000100005f2d	movsd	-0x278(%rbp), %xmm0
0000000100005f35	movl	$0x11, %esi
0000000100005f3a	callq	_fwp_format_g
0000000100005f3f	movq	%rbx, %rdi
0000000100005f42	jmp	0x100006580
0000000100005f47	movb	$0x3c, -0x270(%rbp)
0000000100005f4e	leaq	-0x270(%rbp), %rsi
0000000100005f55	movl	$0x1, %edx
0000000100005f5a	movq	%r13, %rdi
0000000100005f5d	callq	_buf_put
0000000100005f62	movq	0x8(%r15), %rbx
0000000100005f66	movq	%rbx, %rdi
0000000100005f69	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100005f6e	movq	%r13, %rdi
0000000100005f71	movq	%rbx, %rsi
0000000100005f74	jmp	0x100006650
0000000100005f79	movq	0x40b0(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005f80	movq	(%rax), %rax
0000000100005f83	cmpq	-0x30(%rbp), %rax
0000000100005f87	jne	0x1000070d8
0000000100005f8d	leaq	0x3bc1(%rip), %rsi              ## literal pool for: "<opaque>"
0000000100005f94	movl	$0x8, %edx
0000000100005f99	movq	%r13, %rdi
0000000100005f9c	jmp	0x100006d26
0000000100005fa1	leaq	0x8(%r14), %rsi
0000000100005fa5	movq	(%r14), %rdx
0000000100005fa8	movq	0x4081(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005faf	movq	(%rax), %rax
0000000100005fb2	testl	%ecx, %ecx
0000000100005fb4	je	0x100006986
0000000100005fba	cmpq	-0x30(%rbp), %rax
0000000100005fbe	jne	0x1000070d8
0000000100005fc4	movq	%r13, %rdi
0000000100005fc7	jmp	0x100006d26
0000000100005fcc	movq	(%r14), %r9
0000000100005fcf	movq	0x8(%r14), %r8
0000000100005fd3	movq	%r9, %rax
0000000100005fd6	orq	%r8, %rax
0000000100005fd9	je	0x1000069a9
0000000100005fdf	xorl	%edi, %edi
0000000100005fe1	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100005feb	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100005ff5	movq	%r8, %rbx
0000000100005ff8	nopl	(%rax,%rax)
0000000100006000	movq	%r8, %rcx
0000000100006003	shldq	$0x3f, %r9, %rcx
0000000100006008	shrq	%rbx
000000010000600b	movq	%rcx, %rsi
000000010000600e	addq	%rbx, %rsi
0000000100006011	adcq	$0x0, %rsi
0000000100006015	movq	%rsi, %rax
0000000100006018	mulq	%r10
000000010000601b	shrq	$0x2, %rdx
000000010000601f	leaq	(%rdx,%rdx,4), %rax
0000000100006023	subq	%rax, %rsi
0000000100006026	subq	%rsi, %rcx
0000000100006029	sbbq	$0x0, %rbx
000000010000602d	movq	%rcx, %rsi
0000000100006030	imulq	%r11, %rsi
0000000100006034	movq	%rcx, %rax
0000000100006037	mulq	%r10
000000010000603a	addq	%rsi, %rdx
000000010000603d	imulq	%r10, %rbx
0000000100006041	addq	%rdx, %rbx
0000000100006044	movq	%rax, %rcx
0000000100006047	addq	%rax, %rcx
000000010000604a	leaq	(%rcx,%rcx,4), %rcx
000000010000604e	movl	%r9d, %edx
0000000100006051	subl	%ecx, %edx
0000000100006053	orb	$0x30, %dl
0000000100006056	movb	%dl, -0x70(%rbp,%rdi)
000000010000605a	incq	%rdi
000000010000605d	cmpq	$0xa, %r9
0000000100006061	sbbq	$0x0, %r8
0000000100006065	movq	%rax, %r9
0000000100006068	movq	%rbx, %r8
000000010000606b	jae	0x100006000
000000010000606d	testl	%edi, %edi
000000010000606f	jg	0x1000069b2
0000000100006075	jmp	0x100006125
000000010000607a	movq	(%r14), %r9
000000010000607d	movq	0x8(%r14), %r10
0000000100006081	testq	%r10, %r10
0000000100006084	js	0x1000069d4
000000010000608a	movq	%r9, %rax
000000010000608d	orq	%r10, %rax
0000000100006090	je	0x100006af2
0000000100006096	xorl	%edi, %edi
0000000100006098	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
00000001000060a2	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000060ac	movq	%r10, %rbx
00000001000060af	nop
00000001000060b0	movq	%r10, %rcx
00000001000060b3	shldq	$0x3f, %r9, %rcx
00000001000060b8	shrq	%rbx
00000001000060bb	movq	%rcx, %rsi
00000001000060be	addq	%rbx, %rsi
00000001000060c1	adcq	$0x0, %rsi
00000001000060c5	movq	%rsi, %rax
00000001000060c8	mulq	%r8
00000001000060cb	shrq	$0x2, %rdx
00000001000060cf	leaq	(%rdx,%rdx,4), %rax
00000001000060d3	subq	%rax, %rsi
00000001000060d6	subq	%rsi, %rcx
00000001000060d9	sbbq	$0x0, %rbx
00000001000060dd	movq	%rcx, %rsi
00000001000060e0	imulq	%r11, %rsi
00000001000060e4	movq	%rcx, %rax
00000001000060e7	mulq	%r8
00000001000060ea	addq	%rsi, %rdx
00000001000060ed	imulq	%r8, %rbx
00000001000060f1	addq	%rdx, %rbx
00000001000060f4	movq	%rax, %rcx
00000001000060f7	addq	%rax, %rcx
00000001000060fa	leaq	(%rcx,%rcx,4), %rcx
00000001000060fe	movl	%r9d, %edx
0000000100006101	subl	%ecx, %edx
0000000100006103	orb	$0x30, %dl
0000000100006106	movb	%dl, -0x70(%rbp,%rdi)
000000010000610a	incq	%rdi
000000010000610d	cmpq	$0xa, %r9
0000000100006111	sbbq	$0x0, %r10
0000000100006115	movq	%rax, %r9
0000000100006118	movq	%rbx, %r10
000000010000611b	jae	0x1000060b0
000000010000611d	testl	%edi, %edi
000000010000611f	jg	0x100006afb
0000000100006125	xorl	%eax, %eax
0000000100006127	jmp	0x100006f56
000000010000612c	movb	$0x5b, -0x270(%rbp)
0000000100006133	leaq	-0x270(%rbp), %rsi
000000010000613a	movl	$0x1, %edx
000000010000613f	movq	%r13, %rdi
0000000100006142	callq	_buf_put
0000000100006147	testq	%r14, %r14
000000010000614a	je	0x100006e44
0000000100006150	movq	0x38(%r15), %rdx
0000000100006154	movq	0x8(%r14), %rsi
0000000100006158	movq	%r13, %rdi
000000010000615b	xorl	%ecx, %ecx
000000010000615d	callq	_fwp_write
0000000100006162	movq	0x10(%r14), %r14
0000000100006166	testq	%r14, %r14
0000000100006169	je	0x100006e44
000000010000616f	leaq	0x39f6(%rip), %rbx              ## literal pool for: ", "
0000000100006176	nopw	%cs:(%rax,%rax)
0000000100006180	movl	$0x2, %edx
0000000100006185	movq	%r13, %rdi
0000000100006188	movq	%rbx, %rsi
000000010000618b	callq	_buf_put
0000000100006190	movq	0x8(%r14), %rsi
0000000100006194	movq	0x38(%r15), %rdx
0000000100006198	movq	%r13, %rdi
000000010000619b	xorl	%ecx, %ecx
000000010000619d	callq	_fwp_write
00000001000061a2	movq	0x10(%r14), %r14
00000001000061a6	testq	%r14, %r14
00000001000061a9	jne	0x100006180
00000001000061ab	jmp	0x100006e44
00000001000061b0	movslq	0x48(%r15), %rbx
00000001000061b4	movl	%ebx, %r12d
00000001000061b7	leaq	0x3(%rbx), %rsi
00000001000061bb	cmpq	$0x4000, %rsi                   ## imm = 0x4000
00000001000061c2	ja	0x100006abe
00000001000061c8	leaq	0x12(%rbx), %rax
00000001000061cc	shrq	$0x4, %rax
00000001000061d0	leaq	_fwp_gc(%rip), %rcx
00000001000061d7	movzbl	0xbe8(%rax,%rcx), %edx
00000001000061df	movl	0xb48(%rcx,%rdx,4), %eax
00000001000061e6	subq	%rax, _fwp_gc(%rip)
00000001000061ed	js	0x100006abe
00000001000061f3	leaq	(%rdx,%rdx,2), %rdx
00000001000061f7	leaq	(%rcx,%rdx,8), %rcx
00000001000061fb	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100006202	movq	(%rcx), %r15
0000000100006205	testq	%r15, %r15
0000000100006208	je	0x100006aaa
000000010000620e	movq	(%r15), %rax
0000000100006211	notq	%rax
0000000100006214	movq	%rax, (%rcx)
0000000100006217	jmp	0x100006c42
000000010000621c	cmpq	$-0x1, %r14
0000000100006220	leaq	0x3920(%rip), %rax              ## literal pool for: "-1"
0000000100006227	leaq	0x3747(%rip), %rcx              ## literal pool for: "0"
000000010000622e	cmoveq	%rax, %rcx
0000000100006232	cmpq	$0x1, %r14
0000000100006236	leaq	0x3907(%rip), %rbx              ## literal pool for: "+1"
000000010000623d	cmovneq	%rcx, %rbx
0000000100006241	movq	%rbx, %rdi
0000000100006244	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100006249	movq	0x3de0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100006250	movq	(%rcx), %rcx
0000000100006253	cmpq	-0x30(%rbp), %rcx
0000000100006257	jne	0x1000070d8
000000010000625d	movq	%r13, %rdi
0000000100006260	movq	%rbx, %rsi
0000000100006263	jmp	0x100006d23
0000000100006268	movq	%r15, %r12
000000010000626b	leaq	0x3900(%rip), %rsi              ## literal pool for: "array["
0000000100006272	movl	$0x6, %edx
0000000100006277	movq	%r13, %rdi
000000010000627a	callq	_buf_put
000000010000627f	movq	(%r14), %rsi
0000000100006282	leaq	(,%rsi,2), %rax
000000010000628a	testq	%rax, %rax
000000010000628d	je	0x100006e44
0000000100006293	movq	0x38(%r12), %rdx
0000000100006298	movl	$0x8, %eax
000000010000629d	testq	%rdx, %rdx
00000001000062a0	je	0x100006b1d
00000001000062a6	movl	(%rdx), %ecx
00000001000062a8	cmpq	$0xa, %rcx
00000001000062ac	movq	-0x278(%rbp), %r13
00000001000062b3	ja	0x100006b24
00000001000062b9	leaq	0x35a0(%rip), %rax
00000001000062c0	movq	(%rax,%rcx,8), %rax
00000001000062c4	jmp	0x100006b24
00000001000062c9	leaq	0x3895(%rip), %rsi              ## literal pool for: "bytes["
00000001000062d0	movl	$0x6, %edx
00000001000062d5	movq	%r13, %rdi
00000001000062d8	callq	_buf_put
00000001000062dd	cmpq	$0x0, (%r14)
00000001000062e1	movq	%r13, %rbx
00000001000062e4	je	0x100006391
00000001000062ea	movzbl	0x8(%r14), %ecx
00000001000062ef	leaq	0x3879(%rip), %rdx              ## literal pool for: "%u"
00000001000062f6	leaq	-0x270(%rbp), %r15
00000001000062fd	movl	$0x200, %esi                    ## imm = 0x200
0000000100006302	movq	%r15, %rdi
0000000100006305	xorl	%eax, %eax
0000000100006307	callq	0x1000096d2                     ## symbol stub for: _snprintf
000000010000630c	movq	%r15, %rdi
000000010000630f	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100006314	movq	%rbx, %rdi
0000000100006317	movq	%r15, %rsi
000000010000631a	movq	%rax, %rdx
000000010000631d	callq	_buf_put
0000000100006322	cmpq	$0x2, (%r14)
0000000100006326	jb	0x100006391
0000000100006328	movl	$0x9, %r13d
000000010000632e	leaq	0x383a(%rip), %r15              ## literal pool for: "%u"
0000000100006335	leaq	-0x270(%rbp), %r12
000000010000633c	nopl	(%rax)
0000000100006340	movl	$0x2, %edx
0000000100006345	movq	%rbx, %rdi
0000000100006348	leaq	0x381d(%rip), %rsi              ## literal pool for: ", "
000000010000634f	callq	_buf_put
0000000100006354	movzbl	(%r14,%r13), %ecx
0000000100006359	movl	$0x200, %esi                    ## imm = 0x200
000000010000635e	movq	%r12, %rdi
0000000100006361	movq	%r15, %rdx
0000000100006364	xorl	%eax, %eax
0000000100006366	callq	0x1000096d2                     ## symbol stub for: _snprintf
000000010000636b	movq	%r12, %rdi
000000010000636e	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100006373	movq	%rbx, %rdi
0000000100006376	movq	%r12, %rsi
0000000100006379	movq	%rax, %rdx
000000010000637c	callq	_buf_put
0000000100006381	leaq	0x1(%r13), %rax
0000000100006385	addq	$-0x7, %r13
0000000100006389	cmpq	(%r14), %r13
000000010000638c	movq	%rax, %r13
000000010000638f	jb	0x100006340
0000000100006391	movb	$0x5d, -0x70(%rbp)
0000000100006395	leaq	-0x70(%rbp), %rsi
0000000100006399	movl	$0x1, %edx
000000010000639e	movq	%rbx, %rdi
00000001000063a1	jmp	0x100006f76
00000001000063a6	movd	%r14d, %xmm1
00000001000063ab	ucomiss	%xmm1, %xmm1
00000001000063ae	jp	0x1000070dd
00000001000063b4	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
00000001000063bb	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
00000001000063c2	je	0x1000067fa
00000001000063c8	cvtss2sd	%xmm1, %xmm0
00000001000063cc	leaq	-0x270(%rbp), %rbx
00000001000063d3	movq	%rbx, %rdi
00000001000063d6	movsd	%xmm0, -0x280(%rbp)
00000001000063de	movl	$0x1, %esi
00000001000063e3	movss	%xmm1, -0x278(%rbp)
00000001000063eb	callq	_fwp_format_g
00000001000063f0	movq	%rbx, %rdi
00000001000063f3	xorl	%esi, %esi
00000001000063f5	callq	0x100009702                     ## symbol stub for: _strtof
00000001000063fa	ucomiss	-0x278(%rbp), %xmm0
0000000100006401	jne	0x100006409
0000000100006403	jnp	0x100006579
0000000100006409	movq	%rbx, %rdi
000000010000640c	movsd	-0x280(%rbp), %xmm0
0000000100006414	movl	$0x2, %esi
0000000100006419	callq	_fwp_format_g
000000010000641e	movq	%rbx, %rdi
0000000100006421	xorl	%esi, %esi
0000000100006423	callq	0x100009702                     ## symbol stub for: _strtof
0000000100006428	ucomiss	-0x278(%rbp), %xmm0
000000010000642f	jne	0x100006437
0000000100006431	jnp	0x100006579
0000000100006437	movq	%rbx, %rdi
000000010000643a	movsd	-0x280(%rbp), %xmm0
0000000100006442	movl	$0x3, %esi
0000000100006447	callq	_fwp_format_g
000000010000644c	movq	%rbx, %rdi
000000010000644f	xorl	%esi, %esi
0000000100006451	callq	0x100009702                     ## symbol stub for: _strtof
0000000100006456	ucomiss	-0x278(%rbp), %xmm0
000000010000645d	jne	0x100006465
000000010000645f	jnp	0x100006579
0000000100006465	movq	%rbx, %rdi
0000000100006468	movsd	-0x280(%rbp), %xmm0
0000000100006470	movl	$0x4, %esi
0000000100006475	callq	_fwp_format_g
000000010000647a	movq	%rbx, %rdi
000000010000647d	xorl	%esi, %esi
000000010000647f	callq	0x100009702                     ## symbol stub for: _strtof
0000000100006484	ucomiss	-0x278(%rbp), %xmm0
000000010000648b	jne	0x100006493
000000010000648d	jnp	0x100006579
0000000100006493	movq	%rbx, %rdi
0000000100006496	movsd	-0x280(%rbp), %xmm0
000000010000649e	movl	$0x5, %esi
00000001000064a3	callq	_fwp_format_g
00000001000064a8	movq	%rbx, %rdi
00000001000064ab	xorl	%esi, %esi
00000001000064ad	callq	0x100009702                     ## symbol stub for: _strtof
00000001000064b2	ucomiss	-0x278(%rbp), %xmm0
00000001000064b9	jne	0x1000064c1
00000001000064bb	jnp	0x100006579
00000001000064c1	movq	%rbx, %rdi
00000001000064c4	movsd	-0x280(%rbp), %xmm0
00000001000064cc	movl	$0x6, %esi
00000001000064d1	callq	_fwp_format_g
00000001000064d6	movq	%rbx, %rdi
00000001000064d9	xorl	%esi, %esi
00000001000064db	callq	0x100009702                     ## symbol stub for: _strtof
00000001000064e0	ucomiss	-0x278(%rbp), %xmm0
00000001000064e7	jne	0x1000064ef
00000001000064e9	jnp	0x100006579
00000001000064ef	movq	%rbx, %rdi
00000001000064f2	movsd	-0x280(%rbp), %xmm0
00000001000064fa	movl	$0x7, %esi
00000001000064ff	callq	_fwp_format_g
0000000100006504	movq	%rbx, %rdi
0000000100006507	xorl	%esi, %esi
0000000100006509	callq	0x100009702                     ## symbol stub for: _strtof
000000010000650e	ucomiss	-0x278(%rbp), %xmm0
0000000100006515	jne	0x100006519
0000000100006517	jnp	0x100006579
0000000100006519	movq	%rbx, %rdi
000000010000651c	movsd	-0x280(%rbp), %xmm0
0000000100006524	movl	$0x8, %esi
0000000100006529	callq	_fwp_format_g
000000010000652e	movq	%rbx, %rdi
0000000100006531	xorl	%esi, %esi
0000000100006533	callq	0x100009702                     ## symbol stub for: _strtof
0000000100006538	movss	-0x278(%rbp), %xmm1
0000000100006540	ucomiss	%xmm1, %xmm0
0000000100006543	jne	0x100006547
0000000100006545	jnp	0x100006579
0000000100006547	movq	%rbx, %rdi
000000010000654a	movsd	-0x280(%rbp), %xmm0
0000000100006552	movl	$0x9, %esi
0000000100006557	callq	_fwp_format_g
000000010000655c	movq	%rbx, %rdi
000000010000655f	xorl	%esi, %esi
0000000100006561	callq	0x100009702                     ## symbol stub for: _strtof
0000000100006566	ucomiss	-0x278(%rbp), %xmm0
000000010000656d	jne	0x1000070c3
0000000100006573	jp	0x1000070c3
0000000100006579	leaq	-0x270(%rbp), %rdi
0000000100006580	movl	$0x2e, %esi
0000000100006585	callq	0x1000096de                     ## symbol stub for: _strchr
000000010000658a	testq	%rax, %rax
000000010000658d	jne	0x100006f5e
0000000100006593	leaq	-0x270(%rbp), %rdi
000000010000659a	movl	$0x65, %esi
000000010000659f	callq	0x1000096de                     ## symbol stub for: _strchr
00000001000065a4	testq	%rax, %rax
00000001000065a7	jne	0x100006f5e
00000001000065ad	leaq	0x35e6(%rip), %rsi              ## literal pool for: "inf"
00000001000065b4	leaq	-0x270(%rbp), %rdi
00000001000065bb	callq	0x1000096f6                     ## symbol stub for: _strstr
00000001000065c0	testq	%rax, %rax
00000001000065c3	jne	0x100006f5e
00000001000065c9	leaq	0x35c6(%rip), %rsi              ## literal pool for: "NaN"
00000001000065d0	leaq	-0x270(%rbp), %rdi
00000001000065d7	callq	0x1000096f6                     ## symbol stub for: _strstr
00000001000065dc	testq	%rax, %rax
00000001000065df	jne	0x100006f5e
00000001000065e5	leaq	0x35cb(%rip), %rsi              ## literal pool for: ".0"
00000001000065ec	leaq	-0x270(%rbp), %rdi
00000001000065f3	movl	$0x200, %edx                    ## imm = 0x200
00000001000065f8	callq	0x1000095dc                     ## symbol stub for: ___strcat_chk
00000001000065fd	jmp	0x100006f5e
0000000100006602	movq	0x3a27(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006609	movq	(%rax), %rax
000000010000660c	cmpq	-0x30(%rbp), %rax
0000000100006610	jne	0x1000070d8
0000000100006616	leaq	0x352d(%rip), %rsi              ## literal pool for: "<function>"
000000010000661d	movl	$0xa, %edx
0000000100006622	movq	%r13, %rdi
0000000100006625	jmp	0x100006d26
000000010000662a	leaq	0x352d(%rip), %rsi              ## literal pool for: "<file "
0000000100006631	movl	$0x6, %edx
0000000100006636	movq	%r13, %rdi
0000000100006639	callq	_buf_put
000000010000663e	addq	$0x10, %r14
0000000100006642	movq	%r14, %rdi
0000000100006645	callq	0x1000096f0                     ## symbol stub for: _strlen
000000010000664a	movq	%r13, %rdi
000000010000664d	movq	%r14, %rsi
0000000100006650	movq	%rax, %rdx
0000000100006653	callq	_buf_put
0000000100006658	movb	$0x3e, -0x270(%rbp)
000000010000665f	jmp	0x100006e4b
0000000100006664	movl	(%r14), %eax
0000000100006667	movq	0x18(%r15), %rcx
000000010000666b	movl	%eax, %r12d
000000010000666e	movq	(%rcx,%r12,8), %rbx
0000000100006672	movq	%rbx, %rdi
0000000100006675	callq	0x1000096f0                     ## symbol stub for: _strlen
000000010000667a	movq	%r13, %rdi
000000010000667d	movq	%rbx, %rsi
0000000100006680	movq	%rax, %rdx
0000000100006683	callq	_buf_put
0000000100006688	movq	0x28(%r15), %rax
000000010000668c	cmpl	$0x0, (%rax,%r12,4)
0000000100006691	jle	0x100006f7b
0000000100006697	movq	%r12, %rcx
000000010000669a	xorl	%r12d, %r12d
000000010000669d	movq	%r15, -0x280(%rbp)
00000001000066a4	movq	%rcx, -0x290(%rbp)
00000001000066ab	movq	%r14, -0x288(%rbp)
00000001000066b2	jmp	0x1000066f9
00000001000066b4	nopw	%cs:(%rax,%rax)
00000001000066c0	movq	-0x278(%rbp), %r13
00000001000066c7	movq	%r13, %rdi
00000001000066ca	movq	%r15, %rsi
00000001000066cd	movq	%rbx, %rdx
00000001000066d0	xorl	%ecx, %ecx
00000001000066d2	callq	_fwp_write
00000001000066d7	incq	%r12
00000001000066da	movq	-0x280(%rbp), %r15
00000001000066e1	movq	0x28(%r15), %rax
00000001000066e5	movq	-0x290(%rbp), %rcx
00000001000066ec	movslq	(%rax,%rcx,4), %rax
00000001000066f0	cmpq	%rax, %r12
00000001000066f3	jge	0x100006f7b
00000001000066f9	movq	%r15, %rax
00000001000066fc	movq	0x8(%r14,%r12,8), %r15
0000000100006701	movq	0x30(%rax), %rax
0000000100006705	movq	(%rax,%rcx,8), %rax
0000000100006709	movq	(%rax,%r12,8), %rbx
000000010000670d	movb	$0x20, -0x270(%rbp)
0000000100006714	movl	$0x1, %edx
0000000100006719	movq	%r13, %rdi
000000010000671c	leaq	-0x270(%rbp), %rsi
0000000100006723	callq	_buf_put
0000000100006728	movl	(%rbx), %eax
000000010000672a	cmpq	$0x10, %rax
000000010000672e	ja	0x1000066c0
0000000100006730	leaq	0xa1d(%rip), %rcx
0000000100006737	movslq	(%rcx,%rax,4), %rax
000000010000673b	addq	%rcx, %rax
000000010000673e	jmpq	*%rax
0000000100006740	movq	%r15, %rcx
0000000100006743	shrq	$0x3f, %rcx
0000000100006747	testl	%ecx, %ecx
0000000100006749	je	0x1000066c0
000000010000674f	movb	$0x28, -0x270(%rbp)
0000000100006756	movl	$0x1, %edx
000000010000675b	movq	-0x278(%rbp), %r13
0000000100006762	movq	%r13, %rdi
0000000100006765	leaq	-0x270(%rbp), %r14
000000010000676c	movq	%r14, %rsi
000000010000676f	callq	_buf_put
0000000100006774	movq	%r13, %rdi
0000000100006777	movq	%r15, %rsi
000000010000677a	movq	%rbx, %rdx
000000010000677d	xorl	%ecx, %ecx
000000010000677f	callq	_fwp_write
0000000100006784	movb	$0x29, -0x270(%rbp)
000000010000678b	movl	$0x1, %edx
0000000100006790	movq	%r13, %rdi
0000000100006793	movq	%r14, %rsi
0000000100006796	movq	-0x288(%rbp), %r14
000000010000679d	callq	_buf_put
00000001000067a2	jmp	0x1000066d7
00000001000067a7	xorl	%ecx, %ecx
00000001000067a9	cmpq	$0x1000, %r15                   ## imm = 0x1000
00000001000067b0	setae	%cl
00000001000067b3	jmp	0x100006747
00000001000067b5	movq	0x8(%r15), %rcx
00000001000067b9	jmp	0x100006743
00000001000067bb	movl	%r15d, %ecx
00000001000067be	shrl	$0x1f, %ecx
00000001000067c1	jmp	0x100006747
00000001000067c3	movq	0x8(%rbx), %rdi
00000001000067c7	testq	%rdi, %rdi
00000001000067ca	je	0x1000066c0
00000001000067d0	leaq	0x33af(%rip), %rsi              ## literal pool for: "Duration"
00000001000067d7	callq	0x1000096e4                     ## symbol stub for: _strcmp
00000001000067dc	xorl	%ecx, %ecx
00000001000067de	testl	%eax, %eax
00000001000067e0	setne	%cl
00000001000067e3	jmp	0x100006747
00000001000067e8	xorpd	%xmm0, %xmm0
00000001000067ec	movsd	-0x278(%rbp), %xmm1
00000001000067f4	ucomisd	%xmm0, %xmm1
00000001000067f8	jmp	0x100006800
00000001000067fa	xorps	%xmm0, %xmm0
00000001000067fd	ucomiss	%xmm0, %xmm1
0000000100006800	leaq	0x3393(%rip), %rax              ## literal pool for: "inf"
0000000100006807	leaq	0x3390(%rip), %rsi              ## literal pool for: "-inf"
000000010000680e	cmovaq	%rax, %rsi
0000000100006812	leaq	-0x270(%rbp), %rdi
0000000100006819	movl	$0x200, %edx                    ## imm = 0x200
000000010000681e	callq	0x1000095e2                     ## symbol stub for: ___strcpy_chk
0000000100006823	jmp	0x100006f5e
0000000100006828	cmpl	$0x0, 0x10(%r15)
000000010000682d	je	0x100006e5f
0000000100006833	movq	%r15, %rax
0000000100006836	addq	$0x10, %r15
000000010000683a	movq	%rax, -0x280(%rbp)
0000000100006841	cmpl	$0x0, 0x48(%rax)
0000000100006845	setne	%r12b
0000000100006849	testb	%r12b, %r12b
000000010000684c	movl	$0x28, %eax
0000000100006851	movl	$0x7b, %ecx
0000000100006856	cmovnel	%eax, %ecx
0000000100006859	movb	%cl, -0x270(%rbp)
000000010000685f	leaq	-0x270(%rbp), %rsi
0000000100006866	movl	$0x1, %edx
000000010000686b	movq	%r13, %rdi
000000010000686e	callq	_buf_put
0000000100006873	cmpl	$0x0, (%r15)
0000000100006877	movq	-0x280(%rbp), %r15
000000010000687e	jle	0x10000696b
0000000100006884	testb	%r12b, %r12b
0000000100006887	jne	0x1000068ba
0000000100006889	movq	0x18(%r15), %rax
000000010000688d	movq	(%rax), %rbx
0000000100006890	movq	%rbx, %rdi
0000000100006893	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100006898	movq	%r13, %rdi
000000010000689b	movq	%rbx, %rsi
000000010000689e	movq	%rax, %rdx
00000001000068a1	callq	_buf_put
00000001000068a6	leaq	0x32e5(%rip), %rsi              ## literal pool for: " = "
00000001000068ad	movl	$0x3, %edx
00000001000068b2	movq	%r13, %rdi
00000001000068b5	callq	_buf_put
00000001000068ba	movq	0x8(%r14), %rsi
00000001000068be	movq	0x20(%r15), %rax
00000001000068c2	movq	(%rax), %rdx
00000001000068c5	movq	%r13, %rdi
00000001000068c8	xorl	%ecx, %ecx
00000001000068ca	callq	_fwp_write
00000001000068cf	cmpl	$0x2, 0x10(%r15)
00000001000068d4	jl	0x10000696b
00000001000068da	movl	$0x1, %ebx
00000001000068df	jmp	0x100006913
00000001000068e1	nopw	%cs:(%rax,%rax)
00000001000068f0	movq	0x8(%r14,%rbx,8), %rsi
00000001000068f5	movq	0x20(%r15), %rax
00000001000068f9	movq	(%rax,%rbx,8), %rdx
00000001000068fd	movq	%r13, %rdi
0000000100006900	xorl	%ecx, %ecx
0000000100006902	callq	_fwp_write
0000000100006907	incq	%rbx
000000010000690a	movslq	0x10(%r15), %rax
000000010000690e	cmpq	%rax, %rbx
0000000100006911	jge	0x10000696b
0000000100006913	movl	$0x2, %edx
0000000100006918	movq	%r13, %rdi
000000010000691b	leaq	0x324a(%rip), %rsi              ## literal pool for: ", "
0000000100006922	callq	_buf_put
0000000100006927	testb	%r12b, %r12b
000000010000692a	jne	0x1000068f0
000000010000692c	movq	0x18(%r15), %rax
0000000100006930	movq	(%rax,%rbx,8), %r13
0000000100006934	movq	%r13, %rdi
0000000100006937	callq	0x1000096f0                     ## symbol stub for: _strlen
000000010000693c	movq	-0x278(%rbp), %rdi
0000000100006943	movq	%r13, %rsi
0000000100006946	movq	-0x278(%rbp), %r13
000000010000694d	movq	%rax, %rdx
0000000100006950	callq	_buf_put
0000000100006955	movl	$0x3, %edx
000000010000695a	movq	%r13, %rdi
000000010000695d	leaq	0x322e(%rip), %rsi              ## literal pool for: " = "
0000000100006964	callq	_buf_put
0000000100006969	jmp	0x1000068f0
000000010000696b	testb	%r12b, %r12b
000000010000696e	movl	$0x29, %eax
0000000100006973	movl	$0x7d, %ecx
0000000100006978	cmovnel	%eax, %ecx
000000010000697b	movb	%cl, -0x270(%rbp)
0000000100006981	jmp	0x100006e4b
0000000100006986	cmpq	-0x30(%rbp), %rax
000000010000698a	jne	0x1000070d8
0000000100006990	movq	%r13, %rdi
0000000100006993	addq	$0x268, %rsp                    ## imm = 0x268
000000010000699a	popq	%rbx
000000010000699b	popq	%r12
000000010000699d	popq	%r13
000000010000699f	popq	%r14
00000001000069a1	popq	%r15
00000001000069a3	popq	%rbp
00000001000069a4	jmp	_fwp_escape
00000001000069a9	movb	$0x30, -0x70(%rbp)
00000001000069ad	movl	$0x1, %edi
00000001000069b2	movl	%edi, %eax
00000001000069b4	cmpq	$0x8, %rax
00000001000069b8	jae	0x1000069c4
00000001000069ba	xorl	%ecx, %ecx
00000001000069bc	movq	%rax, %rdx
00000001000069bf	jmp	0x100006c15
00000001000069c4	cmpl	$0x20, %eax
00000001000069c7	jae	0x100006b61
00000001000069cd	xorl	%ecx, %ecx
00000001000069cf	jmp	0x100006bbf
00000001000069d4	movb	$0x2d, -0x270(%rbp)
00000001000069db	xorl	%r8d, %r8d
00000001000069de	negq	%r9
00000001000069e1	movl	$0x0, %r11d
00000001000069e7	sbbq	%r10, %r11
00000001000069ea	movl	$0x1, %r15d
00000001000069f0	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000069fa	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100006a04	movq	%r11, %r14
0000000100006a07	nopw	(%rax,%rax)
0000000100006a10	movq	%r11, %rcx
0000000100006a13	shldq	$0x3f, %r9, %rcx
0000000100006a18	shrq	%r14
0000000100006a1b	movq	%rcx, %rsi
0000000100006a1e	addq	%r14, %rsi
0000000100006a21	adcq	$0x0, %rsi
0000000100006a25	movq	%rsi, %rax
0000000100006a28	mulq	%r10
0000000100006a2b	movl	%r15d, %edi
0000000100006a2e	shrq	$0x2, %rdx
0000000100006a32	leaq	(%rdx,%rdx,4), %rax
0000000100006a36	subq	%rax, %rsi
0000000100006a39	subq	%rsi, %rcx
0000000100006a3c	sbbq	$0x0, %r14
0000000100006a40	movq	%rcx, %rsi
0000000100006a43	movq	%rcx, %rax
0000000100006a46	mulq	%r10
0000000100006a49	imulq	%rbx, %rsi
0000000100006a4d	addq	%rsi, %rdx
0000000100006a50	imulq	%r10, %r14
0000000100006a54	addq	%rdx, %r14
0000000100006a57	movq	%rax, %rcx
0000000100006a5a	addq	%rax, %rcx
0000000100006a5d	leaq	(%rcx,%rcx,4), %rcx
0000000100006a61	movl	%r9d, %edx
0000000100006a64	subl	%ecx, %edx
0000000100006a66	orb	$0x30, %dl
0000000100006a69	movb	%dl, -0x70(%rbp,%r8)
0000000100006a6e	incq	%r8
0000000100006a71	leal	0x1(%rdi), %r15d
0000000100006a75	cmpq	$0xa, %r9
0000000100006a79	sbbq	$0x0, %r11
0000000100006a7d	movq	%rax, %r9
0000000100006a80	movq	%r14, %r11
0000000100006a83	jae	0x100006a10
0000000100006a85	testl	%r8d, %r8d
0000000100006a88	jle	0x100006e87
0000000100006a8e	movl	%r8d, %eax
0000000100006a91	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100006a96	cmpq	$0x8, %rax
0000000100006a9a	jae	0x100006fa1
0000000100006aa0	xorl	%ecx, %ecx
0000000100006aa2	movq	%rax, %rdx
0000000100006aa5	jmp	0x100007084
0000000100006aaa	movq	0x8(%rcx), %r15
0000000100006aae	movq	0x10(%rcx), %rdx
0000000100006ab2	subq	%r15, %rdx
0000000100006ab5	cmpq	%rax, %rdx
0000000100006ab8	jae	0x100006c3b
0000000100006abe	movq	%rsi, %rdi
0000000100006ac1	movl	$0x1, %esi
0000000100006ac6	callq	_fwp_gc_alloc_slow
0000000100006acb	movq	%rax, %r15
0000000100006ace	jmp	0x100006c4a
0000000100006ad3	movq	0x8(%r14), %rsi
0000000100006ad7	movq	%rsi, %rdx
0000000100006ada	sarq	$0x3f, %rdx
0000000100006ade	leaq	-0x270(%rbp), %rbx
0000000100006ae5	movq	%rbx, %rdi
0000000100006ae8	callq	_fwp_fmt_duration
0000000100006aed	jmp	0x100006f65
0000000100006af2	movb	$0x30, -0x70(%rbp)
0000000100006af6	movl	$0x1, %edi
0000000100006afb	movl	%edi, %eax
0000000100006afd	cmpq	$0x8, %rax
0000000100006b01	jae	0x100006b0d
0000000100006b03	xorl	%ecx, %ecx
0000000100006b05	movq	%rax, %rdx
0000000100006b08	jmp	0x100006f33
0000000100006b0d	cmpl	$0x20, %eax
0000000100006b10	jae	0x100006e96
0000000100006b16	xorl	%ecx, %ecx
0000000100006b18	jmp	0x100006eee
0000000100006b1d	movq	-0x278(%rbp), %r13
0000000100006b24	leaq	0x8(%r14), %rbx
0000000100006b28	movq	%rbx, %rcx
0000000100006b2b	testq	%rsi, %rsi
0000000100006b2e	jns	0x100006b34
0000000100006b30	movq	0x10(%r14), %rcx
0000000100006b34	cmpq	$0x1, %rax
0000000100006b38	je	0x100006d41
0000000100006b3e	cmpq	$0x8, %rax
0000000100006b42	je	0x100006d3c
0000000100006b48	cmpq	$0x2, %rax
0000000100006b4c	jne	0x100006d4d
0000000100006b52	cmpl	$0x1, (%rdx)
0000000100006b55	movzwl	(%rcx), %eax
0000000100006b58	movswq	%ax, %rsi
0000000100006b5c	jmp	0x100006d55
0000000100006b61	movl	%edi, %edx
0000000100006b63	andl	$0x1f, %edx
0000000100006b66	movq	%rax, %rcx
0000000100006b69	subq	%rdx, %rcx
0000000100006b6c	leaq	-0x260(%rbp), %rsi
0000000100006b73	movdqa	0x2c55(%rip), %xmm0
0000000100006b7b	movq	%rax, %r8
0000000100006b7e	nop
0000000100006b80	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100006b8a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100006b91	pshufb	%xmm0, %xmm2
0000000100006b96	pshufb	%xmm0, %xmm1
0000000100006b9b	movdqa	%xmm2, -0x10(%rsi)
0000000100006ba0	movdqa	%xmm1, (%rsi)
0000000100006ba4	addq	$-0x20, %r8
0000000100006ba8	addq	$0x20, %rsi
0000000100006bac	cmpq	%r8, %rdx
0000000100006baf	jne	0x100006b80
0000000100006bb1	testq	%rdx, %rdx
0000000100006bb4	je	0x100006f56
0000000100006bba	cmpl	$0x7, %edx
0000000100006bbd	jbe	0x100006c15
0000000100006bbf	movl	%edi, %edx
0000000100006bc1	andl	$0x7, %edx
0000000100006bc4	movq	%rax, %rsi
0000000100006bc7	subq	%rcx, %rsi
0000000100006bca	leaq	(%rcx,%rbp), %rdi
0000000100006bce	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100006bd5	movq	%rax, %rcx
0000000100006bd8	subq	%rdx, %rcx
0000000100006bdb	movq	0x2bfd(%rip), %xmm0
0000000100006be3	nopw	%cs:(%rax,%rax)
0000000100006bf0	movq	-0x78(%rbp,%rsi), %xmm1
0000000100006bf6	pshufb	%xmm0, %xmm1
0000000100006bfb	movq	%xmm1, (%rdi)
0000000100006bff	addq	$-0x8, %rsi
0000000100006c03	addq	$0x8, %rdi
0000000100006c07	cmpq	%rsi, %rdx
0000000100006c0a	jne	0x100006bf0
0000000100006c0c	testq	%rdx, %rdx
0000000100006c0f	je	0x100006f56
0000000100006c15	leaq	-0x70(%rbp), %rsi
0000000100006c19	addq	%rsi, %rdx
0000000100006c1c	decq	%rdx
0000000100006c1f	nop
0000000100006c20	movzbl	(%rdx), %esi
0000000100006c23	movb	%sil, -0x270(%rbp,%rcx)
0000000100006c2b	incq	%rcx
0000000100006c2e	decq	%rdx
0000000100006c31	cmpq	%rcx, %rax
0000000100006c34	jne	0x100006c20
0000000100006c36	jmp	0x100006f56
0000000100006c3b	addq	%r15, %rax
0000000100006c3e	movq	%rax, 0x8(%rcx)
0000000100006c42	movq	%r15, %rdi
0000000100006c45	callq	0x1000095be                     ## symbol stub for: ___bzero
0000000100006c4a	movw	$0x7430, (%r15)                 ## imm = 0x7430
0000000100006c50	testl	%r12d, %r12d
0000000100006c53	jle	0x100006cfb
0000000100006c59	movq	%rbx, %rcx
0000000100006c5c	negq	%rcx
0000000100006c5f	leaq	(%r12,%r15), %rsi
0000000100006c63	incq	%rsi
0000000100006c66	xorl	%edi, %edi
0000000100006c68	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
0000000100006c72	jmp	0x100006cac
0000000100006c74	nopw	%cs:(%rax,%rax)
0000000100006c80	movb	$0x30, %r10b
0000000100006c83	movb	%r10b, (%rsi,%rdi)
0000000100006c87	testq	%rdx, %rdx
0000000100006c8a	setne	%dl
0000000100006c8d	testq	%r14, %r14
0000000100006c90	sets	%r10b
0000000100006c94	andb	%dl, %r10b
0000000100006c97	movzbl	%r10b, %edx
0000000100006c9b	subq	%rdx, %rax
0000000100006c9e	addq	%r9, %rax
0000000100006ca1	decq	%rdi
0000000100006ca4	movq	%rax, %r14
0000000100006ca7	cmpq	%rdi, %rcx
0000000100006caa	je	0x100006cfb
0000000100006cac	movq	%r14, %rax
0000000100006caf	imulq	%r8
0000000100006cb2	movq	%rdx, %rax
0000000100006cb5	shrq	$0x3f, %rax
0000000100006cb9	addq	%rdx, %rax
0000000100006cbc	leaq	(%rax,%rax,2), %r9
0000000100006cc0	movq	%r14, %rdx
0000000100006cc3	subq	%r9, %rdx
0000000100006cc6	negq	%r9
0000000100006cc9	addq	%r14, %r9
0000000100006ccc	addq	$0x3, %r9
0000000100006cd0	cmpq	$-0x3, %rdx
0000000100006cd4	cmovbq	%rdx, %r9
0000000100006cd8	testq	%r9, %r9
0000000100006cdb	je	0x100006c80
0000000100006cdd	cmpq	$0x1, %r9
0000000100006ce1	jne	0x100006cf0
0000000100006ce3	movb	$0x2b, %r10b
0000000100006ce6	xorl	%r9d, %r9d
0000000100006ce9	jmp	0x100006c83
0000000100006ceb	nopl	(%rax,%rax)
0000000100006cf0	movb	$0x2d, %r10b
0000000100006cf3	movl	$0x1, %r9d
0000000100006cf9	jmp	0x100006c83
0000000100006cfb	movb	$0x0, 0x2(%r15,%rbx)
0000000100006d01	movq	%r15, %rdi
0000000100006d04	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100006d09	movq	0x3320(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100006d10	movq	(%rcx), %rcx
0000000100006d13	cmpq	-0x30(%rbp), %rcx
0000000100006d17	jne	0x1000070d8
0000000100006d1d	movq	%r13, %rdi
0000000100006d20	movq	%r15, %rsi
0000000100006d23	movq	%rax, %rdx
0000000100006d26	addq	$0x268, %rsp                    ## imm = 0x268
0000000100006d2d	popq	%rbx
0000000100006d2e	popq	%r12
0000000100006d30	popq	%r13
0000000100006d32	popq	%r14
0000000100006d34	popq	%r15
0000000100006d36	popq	%rbp
0000000100006d37	jmp	_buf_put
0000000100006d3c	movq	(%rcx), %rsi
0000000100006d3f	jmp	0x100006d59
0000000100006d41	cmpl	$0x0, (%rdx)
0000000100006d44	movzbl	(%rcx), %eax
0000000100006d47	movsbq	%al, %rsi
0000000100006d4b	jmp	0x100006d55
0000000100006d4d	cmpl	$0x2, (%rdx)
0000000100006d50	movl	(%rcx), %eax
0000000100006d52	movslq	%eax, %rsi
0000000100006d55	cmovneq	%rax, %rsi
0000000100006d59	movq	%r13, %rdi
0000000100006d5c	xorl	%ecx, %ecx
0000000100006d5e	callq	_fwp_write
0000000100006d63	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100006d6d	decq	%rax
0000000100006d70	testq	%rax, (%r14)
0000000100006d73	je	0x100006e44
0000000100006d79	movl	$0x1, %r15d
0000000100006d7f	jmp	0x100006dbd
0000000100006d81	cmpl	$0x1, (%rdx)
0000000100006d84	movzwl	(%rcx,%rsi), %eax
0000000100006d88	movswq	%ax, %rsi
0000000100006d8c	cmovneq	%rax, %rsi
0000000100006d90	movq	-0x278(%rbp), %r13
0000000100006d97	movq	%r13, %rdi
0000000100006d9a	xorl	%ecx, %ecx
0000000100006d9c	callq	_fwp_write
0000000100006da1	incq	%r15
0000000100006da4	movq	(%r14), %rax
0000000100006da7	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100006db1	andq	%rcx, %rax
0000000100006db4	cmpq	%rax, %r15
0000000100006db7	jae	0x100006e44
0000000100006dbd	movl	$0x2, %edx
0000000100006dc2	movq	%r13, %rdi
0000000100006dc5	leaq	0x2da0(%rip), %rsi              ## literal pool for: ", "
0000000100006dcc	callq	_buf_put
0000000100006dd1	movq	0x38(%r12), %rdx
0000000100006dd6	movl	$0x8, %eax
0000000100006ddb	testq	%rdx, %rdx
0000000100006dde	je	0x100006df3
0000000100006de0	movl	(%rdx), %ecx
0000000100006de2	cmpq	$0xa, %rcx
0000000100006de6	ja	0x100006df3
0000000100006de8	leaq	0x2a71(%rip), %rax
0000000100006def	movq	(%rax,%rcx,8), %rax
0000000100006df3	cmpq	$0x0, (%r14)
0000000100006df7	movq	%rbx, %rcx
0000000100006dfa	jns	0x100006e00
0000000100006dfc	movq	0x10(%r14), %rcx
0000000100006e00	movq	%rax, %rsi
0000000100006e03	imulq	%r15, %rsi
0000000100006e07	cmpq	$0x1, %rax
0000000100006e0b	je	0x100006e26
0000000100006e0d	cmpq	$0x2, %rax
0000000100006e11	je	0x100006d81
0000000100006e17	cmpq	$0x8, %rax
0000000100006e1b	jne	0x100006e36
0000000100006e1d	movq	(%rcx,%rsi), %rsi
0000000100006e21	jmp	0x100006d90
0000000100006e26	cmpl	$0x0, (%rdx)
0000000100006e29	movzbl	(%rcx,%rsi), %eax
0000000100006e2d	movsbq	%al, %rsi
0000000100006e31	jmp	0x100006d8c
0000000100006e36	cmpl	$0x2, (%rdx)
0000000100006e39	movl	(%rcx,%rsi), %eax
0000000100006e3c	movslq	%eax, %rsi
0000000100006e3f	jmp	0x100006d8c
0000000100006e44	movb	$0x5d, -0x270(%rbp)
0000000100006e4b	leaq	-0x270(%rbp), %rsi
0000000100006e52	movl	$0x1, %edx
0000000100006e57	movq	%r13, %rdi
0000000100006e5a	jmp	0x100006f76
0000000100006e5f	movq	0x31ca(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006e66	movq	(%rax), %rax
0000000100006e69	cmpq	-0x30(%rbp), %rax
0000000100006e6d	jne	0x1000070d8
0000000100006e73	leaq	0x2d15(%rip), %rsi              ## literal pool for: "()"
0000000100006e7a	movl	$0x2, %edx
0000000100006e7f	movq	%r13, %rdi
0000000100006e82	jmp	0x100006d26
0000000100006e87	xorl	%eax, %eax
0000000100006e89	movb	$0x0, -0x26f(%rbp,%rax)
0000000100006e91	jmp	0x100006f5e
0000000100006e96	movl	%edi, %edx
0000000100006e98	andl	$0x1f, %edx
0000000100006e9b	movq	%rax, %rcx
0000000100006e9e	subq	%rdx, %rcx
0000000100006ea1	leaq	-0x260(%rbp), %rsi
0000000100006ea8	movdqa	0x2920(%rip), %xmm0
0000000100006eb0	movq	%rax, %r8
0000000100006eb3	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100006ebd	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100006ec4	pshufb	%xmm0, %xmm2
0000000100006ec9	pshufb	%xmm0, %xmm1
0000000100006ece	movdqa	%xmm2, -0x10(%rsi)
0000000100006ed3	movdqa	%xmm1, (%rsi)
0000000100006ed7	addq	$-0x20, %r8
0000000100006edb	addq	$0x20, %rsi
0000000100006edf	cmpq	%r8, %rdx
0000000100006ee2	jne	0x100006eb3
0000000100006ee4	testq	%rdx, %rdx
0000000100006ee7	je	0x100006f56
0000000100006ee9	cmpl	$0x7, %edx
0000000100006eec	jbe	0x100006f33
0000000100006eee	movl	%edi, %edx
0000000100006ef0	andl	$0x7, %edx
0000000100006ef3	movq	%rax, %rsi
0000000100006ef6	subq	%rcx, %rsi
0000000100006ef9	leaq	(%rcx,%rbp), %rdi
0000000100006efd	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100006f04	movq	%rax, %rcx
0000000100006f07	subq	%rdx, %rcx
0000000100006f0a	movq	0x28ce(%rip), %xmm0
0000000100006f12	movq	-0x78(%rbp,%rsi), %xmm1
0000000100006f18	pshufb	%xmm0, %xmm1
0000000100006f1d	movq	%xmm1, (%rdi)
0000000100006f21	addq	$-0x8, %rsi
0000000100006f25	addq	$0x8, %rdi
0000000100006f29	cmpq	%rsi, %rdx
0000000100006f2c	jne	0x100006f12
0000000100006f2e	testq	%rdx, %rdx
0000000100006f31	je	0x100006f56
0000000100006f33	leaq	-0x70(%rbp), %rsi
0000000100006f37	addq	%rsi, %rdx
0000000100006f3a	decq	%rdx
0000000100006f3d	nopl	(%rax)
0000000100006f40	movzbl	(%rdx), %esi
0000000100006f43	movb	%sil, -0x270(%rbp,%rcx)
0000000100006f4b	incq	%rcx
0000000100006f4e	decq	%rdx
0000000100006f51	cmpq	%rcx, %rax
0000000100006f54	jne	0x100006f40
0000000100006f56	movb	$0x0, -0x270(%rbp,%rax)
0000000100006f5e	leaq	-0x270(%rbp), %rbx
0000000100006f65	movq	%rbx, %rdi
0000000100006f68	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100006f6d	movq	%r13, %rdi
0000000100006f70	movq	%rbx, %rsi
0000000100006f73	movq	%rax, %rdx
0000000100006f76	callq	_buf_put
0000000100006f7b	movq	0x30ae(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006f82	movq	(%rax), %rax
0000000100006f85	cmpq	-0x30(%rbp), %rax
0000000100006f89	jne	0x1000070d8
0000000100006f8f	addq	$0x268, %rsp                    ## imm = 0x268
0000000100006f96	popq	%rbx
0000000100006f97	popq	%r12
0000000100006f99	popq	%r13
0000000100006f9b	popq	%r14
0000000100006f9d	popq	%r15
0000000100006f9f	popq	%rbp
0000000100006fa0	retq
0000000100006fa1	cmpl	$0x20, %eax
0000000100006fa4	jae	0x100006faa
0000000100006fa6	xorl	%ecx, %ecx
0000000100006fa8	jmp	0x10000701f
0000000100006faa	movl	%r8d, %edx
0000000100006fad	andl	$0x1f, %edx
0000000100006fb0	movq	%rax, %rcx
0000000100006fb3	subq	%rdx, %rcx
0000000100006fb6	movl	%edi, %esi
0000000100006fb8	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100006fbe	leaq	(%rsi,%rbp), %r9
0000000100006fc2	addq	$-0x80, %r9
0000000100006fc6	movl	%edi, %r10d
0000000100006fc9	andl	$0x1f, %r10d
0000000100006fcd	subq	%r10, %rsi
0000000100006fd0	xorl	%r10d, %r10d
0000000100006fd3	movdqa	0x27f5(%rip), %xmm0
0000000100006fdb	movdqu	-0x10(%r9), %xmm1
0000000100006fe1	movdqu	(%r9), %xmm2
0000000100006fe6	pshufb	%xmm0, %xmm2
0000000100006feb	pshufb	%xmm0, %xmm1
0000000100006ff0	movdqu	%xmm2, -0x26f(%rbp,%r10)
0000000100006ffa	movdqu	%xmm1, -0x25f(%rbp,%r10)
0000000100007004	addq	$0x20, %r10
0000000100007008	addq	$-0x20, %r9
000000010000700c	cmpq	%r10, %rsi
000000010000700f	jne	0x100006fdb
0000000100007011	testq	%rdx, %rdx
0000000100007014	je	0x1000070b6
000000010000701a	cmpl	$0x7, %edx
000000010000701d	jbe	0x100007084
000000010000701f	movq	%rcx, %rsi
0000000100007022	movl	%r8d, %edx
0000000100007025	andl	$0x7, %edx
0000000100007028	movq	%rax, %rcx
000000010000702b	subq	%rdx, %rcx
000000010000702e	movq	%rsi, %r8
0000000100007031	negq	%r8
0000000100007034	leaq	(%r8,%rbp), %r9
0000000100007038	addq	$-0x70, %r9
000000010000703c	movl	%edi, %r8d
000000010000703f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100007046	addq	%r8, %r9
0000000100007049	addq	$-0x8, %r9
000000010000704d	movl	%edi, %r10d
0000000100007050	andl	$0x7, %r10d
0000000100007054	subq	%r10, %r8
0000000100007057	movq	0x2781(%rip), %xmm0
000000010000705f	movq	(%r9), %xmm1
0000000100007064	pshufb	%xmm0, %xmm1
0000000100007069	movq	%xmm1, -0x26f(%rbp,%rsi)
0000000100007072	addq	$0x8, %rsi
0000000100007076	addq	$-0x8, %r9
000000010000707a	cmpq	%rsi, %r8
000000010000707d	jne	0x10000705f
000000010000707f	testq	%rdx, %rdx
0000000100007082	je	0x1000070b6
0000000100007084	leaq	-0x70(%rbp), %rsi
0000000100007088	addq	%rsi, %rdx
000000010000708b	decq	%rdx
000000010000708e	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
0000000100007094	nopw	%cs:(%rax,%rax)
00000001000070a0	movzbl	(%rdx), %esi
00000001000070a3	movb	%sil, -0x26f(%rbp,%rcx)
00000001000070ab	incq	%rcx
00000001000070ae	decq	%rdx
00000001000070b1	cmpq	%rcx, %rdi
00000001000070b4	jne	0x1000070a0
00000001000070b6	movb	$0x0, -0x26f(%rbp,%rax)
00000001000070be	jmp	0x100006f5e
00000001000070c3	movq	%rbx, %rdi
00000001000070c6	movsd	-0x280(%rbp), %xmm0
00000001000070ce	movl	$0x9, %esi
00000001000070d3	jmp	0x100005f3a
00000001000070d8	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
00000001000070dd	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
00000001000070e7	jmp	0x100006f5e
00000001000070ec	repne		jmp	0x1000070ee
00000001000070ef	pushq	%rdx
00000001000070f1	jmp	0x1000070f2
00000001000070f3	pushq	%rdx
00000001000070f5	jmp	0x1000070f6
00000001000070f7	pushq	%rdx
00000001000070f9	jmp	0x1000070fa
00000001000070fb	decl	-0x4000011(%rsi)
0000000100007101	jmp	0x100007102
0000000100007103	.byte 0xff #bad opcode
0000000100007104	sti
0000000100007105	jmp	0x100007106
0000000100007107	.byte 0xff #bad opcode
0000000100007108	sti
0000000100007109	jmp	0x10000710a
000000010000710b	.byte 0xff #bad opcode
000000010000710c	sti
000000010000710d	jmp	0x10000710e
000000010000710f	jmpq	*%rax
0000000100007111	outb	%al, %dx
0000000100007112	.byte 0xff #bad opcode
0000000100007113	.byte 0xff #bad opcode
0000000100007114	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
0000000100007119	inl	%dx, %eax
000000010000711a	.byte 0xff #bad opcode
000000010000711b	pushq	-0x22000012(%rbp)
0000000100007121	.byte 0xf1 #bad opcode
0000000100007122	.byte 0xff #bad opcode
0000000100007123	ljmpl	*0x40ffffed(%rcx)
0000000100007129	lock
000000010000712a	.byte 0xff #bad opcode
000000010000712b	incl	-0x13(%rcx)
000000010000712e	.byte 0xff #bad opcode
000000010000712f	.byte 0xff #bad opcode
0000000100007130	jl	0x100007123
0000000100007132	.byte 0xff #bad opcode
0000000100007133	jmpq	*(%rax)
0000000100007135	inb	%dx, %al
0000000100007136	.byte 0xff #bad opcode
0000000100007137	jmpq	*(%rax)
0000000100007139	inb	%dx, %al
000000010000713a	.byte 0xff #bad opcode
000000010000713b	incl	%esp
000000010000713d	lock
000000010000713e	.byte 0xff #bad opcode
000000010000713f	pushq	(%rax)
0000000100007141	.byte 0xf1 #bad opcode
0000000100007142	.byte 0xff #bad opcode
0000000100007143	callq	*(%rsi)
0000000100007145	cmc
0000000100007146	.byte 0xff #bad opcode
0000000100007147	.byte 0xff #bad opcode
0000000100007148	cmc
000000010000714a	.byte 0xff #bad opcode
000000010000714b	decl	0x5bffffee(%rbp)
0000000100007151	outb	%al, %dx
0000000100007152	.byte 0xff #bad opcode
0000000100007153	.byte 0xff #bad opcode
0000000100007154	inb	%dx, %al
0000000100007155	cmc
0000000100007156	.byte 0xff #bad opcode
0000000100007157	.byte 0xff #bad opcode
0000000100007158	inb	%dx, %al
0000000100007159	cmc
000000010000715a	.byte 0xff #bad opcode
000000010000715b	.byte 0xff #bad opcode
000000010000715c	inb	%dx, %al
000000010000715d	cmc
000000010000715e	.byte 0xff #bad opcode
000000010000715f	.byte 0xff #bad opcode
0000000100007160	inb	%dx, %al
0000000100007161	cmc
0000000100007162	.byte 0xff #bad opcode
0000000100007163	jmpq	*-0xa(%rcx)
0000000100007166	.byte 0xff #bad opcode
0000000100007167	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000716b	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000716f	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007173	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007177	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000717b	jmpq	*-0xa(%rdi)
000000010000717e	.byte 0xff #bad opcode
000000010000717f	.byte 0xff #bad opcode
0000000100007180	inb	%dx, %al
0000000100007181	cmc
0000000100007182	.byte 0xff #bad opcode
0000000100007183	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007187	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000718b	callq	*-0xa(%rbx)
000000010000718e	.byte 0xff #bad opcode
000000010000718f	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100007193	ljmpl	*-0xa(%rdi)
0000000100007196	.byte 0xff #bad opcode
0000000100007197	decl	(%rdi)
0000000100007199	.byte 0x1f #bad opcode
000000010000719a	testb	%al, (%rax)
000000010000719c	addb	%al, (%rax)
000000010000719e	addb	%al, (%rax)
_buf_put:
00000001000071a0	pushq	%rbp
00000001000071a1	movq	%rsp, %rbp
00000001000071a4	pushq	%r15
00000001000071a6	pushq	%r14
00000001000071a8	pushq	%r12
00000001000071aa	pushq	%rbx
00000001000071ab	movq	%rdi, %r14
00000001000071ae	movq	0x8(%rdi), %rdi
00000001000071b2	cmpq	$-0x1, %rdi
00000001000071b6	je	0x100007258
00000001000071bc	movq	%rdx, %rbx
00000001000071bf	movq	$-0x2, %rax
00000001000071c6	subq	%rdi, %rax
00000001000071c9	cmpq	%rdx, %rax
00000001000071cc	jb	0x100007258
00000001000071d2	leaq	(%rbx,%rdi), %rax
00000001000071d6	incq	%rax
00000001000071d9	movq	0x10(%r14), %rcx
00000001000071dd	cmpq	%rcx, %rax
00000001000071e0	jbe	0x10000720f
00000001000071e2	testq	%rcx, %rcx
00000001000071e5	movl	$0x40, %r15d
00000001000071eb	cmovneq	%rcx, %r15
00000001000071ef	movq	%rsi, %r12
00000001000071f2	cmpq	%rax, %r15
00000001000071f5	jae	0x100007217
00000001000071f7	nopw	(%rax,%rax)
0000000100007200	testq	%r15, %r15
0000000100007203	js	0x100007214
0000000100007205	addq	%r15, %r15
0000000100007208	cmpq	%rax, %r15
000000010000720b	jb	0x100007200
000000010000720d	jmp	0x100007217
000000010000720f	movq	(%r14), %rax
0000000100007212	jmp	0x100007235
0000000100007214	movq	%rax, %r15
0000000100007217	movq	(%r14), %rdi
000000010000721a	movq	%r15, %rsi
000000010000721d	callq	0x1000096ae                     ## symbol stub for: _realloc
0000000100007222	testq	%rax, %rax
0000000100007225	je	0x100007258
0000000100007227	movq	%rax, (%r14)
000000010000722a	movq	%r15, 0x10(%r14)
000000010000722e	movq	0x8(%r14), %rdi
0000000100007232	movq	%r12, %rsi
0000000100007235	addq	%rax, %rdi
0000000100007238	movq	%rbx, %rdx
000000010000723b	callq	0x100009678                     ## symbol stub for: _memcpy
0000000100007240	addq	0x8(%r14), %rbx
0000000100007244	movq	%rbx, 0x8(%r14)
0000000100007248	movq	(%r14), %rax
000000010000724b	movb	$0x0, (%rax,%rbx)
000000010000724f	popq	%rbx
0000000100007250	popq	%r12
0000000100007252	popq	%r14
0000000100007254	popq	%r15
0000000100007256	popq	%rbp
0000000100007257	retq
0000000100007258	movq	0x2dd9(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000725f	movq	(%rax), %rcx
0000000100007262	leaq	0x27c9(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100007269	movl	$0x13, %esi
000000010000726e	movl	$0x1, %edx
0000000100007273	callq	0x100009654                     ## symbol stub for: _fwrite
0000000100007278	movl	$0x66, %edi
000000010000727d	callq	0x10000961e                     ## symbol stub for: _exit
0000000100007282	nopw	%cs:(%rax,%rax)
_fwp_escape:
0000000100007290	pushq	%rbp
0000000100007291	movq	%rsp, %rbp
0000000100007294	pushq	%r15
0000000100007296	pushq	%r14
0000000100007298	pushq	%r13
000000010000729a	pushq	%r12
000000010000729c	pushq	%rbx
000000010000729d	subq	$0x18, %rsp
00000001000072a1	movq	%rdx, %r14
00000001000072a4	movq	%rsi, %r15
00000001000072a7	movq	%rdi, %rbx
00000001000072aa	movq	0x2d7f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000072b1	movq	(%rax), %rax
00000001000072b4	movq	%rax, -0x30(%rbp)
00000001000072b8	movb	$0x22, -0x40(%rbp)
00000001000072bc	leaq	-0x40(%rbp), %rsi
00000001000072c0	movl	$0x1, %edx
00000001000072c5	callq	_buf_put
00000001000072ca	testq	%r14, %r14
00000001000072cd	je	0x1000073c9
00000001000072d3	leaq	0x12a(%rip), %r12
00000001000072da	xorl	%r13d, %r13d
00000001000072dd	jmp	0x100007301
00000001000072df	movl	$0x2, %edx
00000001000072e4	movq	%rbx, %rdi
00000001000072e7	leaq	0x28d8(%rip), %rsi              ## literal pool for: "\\r"
00000001000072ee	nop
00000001000072f0	callq	_buf_put
00000001000072f5	incq	%r13
00000001000072f8	cmpq	%r13, %r14
00000001000072fb	je	0x1000073c9
0000000100007301	movzbl	(%r15,%r13), %eax
0000000100007306	movzbl	%al, %ecx
0000000100007309	leal	-0x9(%rcx), %edx
000000010000730c	cmpl	$0x19, %edx
000000010000730f	ja	0x100007330
0000000100007311	movslq	(%r12,%rdx,4), %rdx
0000000100007315	addq	%r12, %rdx
0000000100007318	jmpq	*%rdx
000000010000731a	movl	$0x2, %edx
000000010000731f	movq	%rbx, %rdi
0000000100007322	leaq	0x289a(%rip), %rsi              ## literal pool for: "\\t"
0000000100007329	jmp	0x1000072f0
000000010000732b	nopl	(%rax,%rax)
0000000100007330	cmpl	$0x5c, %ecx
0000000100007333	jne	0x100007346
0000000100007335	movl	$0x2, %edx
000000010000733a	movq	%rbx, %rdi
000000010000733d	leaq	0x2879(%rip), %rsi              ## literal pool for: "\\\\"
0000000100007344	jmp	0x1000072f0
0000000100007346	cmpb	$0x20, %al
0000000100007348	setae	%dl
000000010000734b	cmpb	$0x7f, %al
000000010000734d	setne	%sil
0000000100007351	testb	%sil, %dl
0000000100007354	jne	0x1000073b5
0000000100007356	movl	$0x10, %esi
000000010000735b	leaq	-0x40(%rbp), %r12
000000010000735f	movq	%r12, %rdi
0000000100007362	leaq	0x2860(%rip), %rdx              ## literal pool for: "\\u{%x}"
0000000100007369	xorl	%eax, %eax
000000010000736b	callq	0x1000096d2                     ## symbol stub for: _snprintf
0000000100007370	movq	%r12, %rdi
0000000100007373	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100007378	movq	%rbx, %rdi
000000010000737b	movq	%r12, %rsi
000000010000737e	leaq	0x7f(%rip), %r12
0000000100007385	movq	%rax, %rdx
0000000100007388	jmp	0x1000072f0
000000010000738d	movl	$0x2, %edx
0000000100007392	movq	%rbx, %rdi
0000000100007395	leaq	0x281e(%rip), %rsi              ## literal pool for: "\\\""
000000010000739c	jmp	0x1000072f0
00000001000073a1	movl	$0x2, %edx
00000001000073a6	movq	%rbx, %rdi
00000001000073a9	leaq	0x2810(%rip), %rsi              ## literal pool for: "\\n"
00000001000073b0	jmp	0x1000072f0
00000001000073b5	movb	%al, -0x40(%rbp)
00000001000073b8	movl	$0x1, %edx
00000001000073bd	movq	%rbx, %rdi
00000001000073c0	leaq	-0x40(%rbp), %rsi
00000001000073c4	jmp	0x1000072f0
00000001000073c9	movb	$0x22, -0x40(%rbp)
00000001000073cd	leaq	-0x40(%rbp), %rsi
00000001000073d1	movl	$0x1, %edx
00000001000073d6	movq	%rbx, %rdi
00000001000073d9	callq	_buf_put
00000001000073de	movq	0x2c4b(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000073e5	movq	(%rax), %rax
00000001000073e8	cmpq	-0x30(%rbp), %rax
00000001000073ec	jne	0x1000073fd
00000001000073ee	addq	$0x18, %rsp
00000001000073f2	popq	%rbx
00000001000073f3	popq	%r12
00000001000073f5	popq	%r13
00000001000073f7	popq	%r14
00000001000073f9	popq	%r15
00000001000073fb	popq	%rbp
00000001000073fc	retq
00000001000073fd	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100007402	nop
0000000100007404	.byte 0x16 #bad opcode
0000000100007405	.byte 0xff #bad opcode
0000000100007406	.byte 0xff #bad opcode
0000000100007407	lcalll	*0x42ffffff(%rbp)
000000010000740d	.byte 0xff #bad opcode
000000010000740e	.byte 0xff #bad opcode
000000010000740f	incl	-0x1(%rdx)
0000000100007412	.byte 0xff #bad opcode
0000000100007413	.byte 0xff #bad opcode
0000000100007414	.byte 0xdb #bad opcode
0000000100007415	.byte 0xfe #bad opcode
0000000100007416	.byte 0xff #bad opcode
0000000100007417	incl	-0x1(%rdx)
000000010000741a	.byte 0xff #bad opcode
000000010000741b	incl	-0x1(%rdx)
000000010000741e	.byte 0xff #bad opcode
000000010000741f	incl	-0x1(%rdx)
0000000100007422	.byte 0xff #bad opcode
0000000100007423	incl	-0x1(%rdx)
0000000100007426	.byte 0xff #bad opcode
0000000100007427	incl	-0x1(%rdx)
000000010000742a	.byte 0xff #bad opcode
000000010000742b	incl	-0x1(%rdx)
000000010000742e	.byte 0xff #bad opcode
000000010000742f	incl	-0x1(%rdx)
0000000100007432	.byte 0xff #bad opcode
0000000100007433	incl	-0x1(%rdx)
0000000100007436	.byte 0xff #bad opcode
0000000100007437	incl	-0x1(%rdx)
000000010000743a	.byte 0xff #bad opcode
000000010000743b	incl	-0x1(%rdx)
000000010000743e	.byte 0xff #bad opcode
000000010000743f	incl	-0x1(%rdx)
0000000100007442	.byte 0xff #bad opcode
0000000100007443	incl	-0x1(%rdx)
0000000100007446	.byte 0xff #bad opcode
0000000100007447	incl	-0x1(%rdx)
000000010000744a	.byte 0xff #bad opcode
000000010000744b	incl	-0x1(%rdx)
000000010000744e	.byte 0xff #bad opcode
000000010000744f	incl	-0x1(%rdx)
0000000100007452	.byte 0xff #bad opcode
0000000100007453	incl	-0x1(%rdx)
0000000100007456	.byte 0xff #bad opcode
0000000100007457	incl	-0x1(%rdx)
000000010000745a	.byte 0xff #bad opcode
000000010000745b	incl	-0x1(%rdx)
000000010000745e	.byte 0xff #bad opcode
000000010000745f	incl	-0x1(%rdx)
0000000100007462	.byte 0xff #bad opcode
0000000100007463	incl	-0x1(%rdx)
0000000100007466	.byte 0xff #bad opcode
0000000100007467	decl	0xfffffff(%rcx)
000000010000746d	.byte 0x1f #bad opcode
000000010000746e	addb	%dl, 0x48(%rbp)
0000000100007472	movl	%esp, %ebp
0000000100007474	pushq	%r15
0000000100007476	pushq	%r14
0000000100007478	pushq	%r13
000000010000747a	pushq	%r12
000000010000747c	pushq	%rbx
000000010000747d	subq	$0x88, %rsp
0000000100007484	movq	0x2ba5(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000748b	movq	(%rax), %rax
000000010000748e	movq	%rax, -0x30(%rbp)
0000000100007492	movq	%rsi, %rax
0000000100007495	orq	%rdx, %rax
0000000100007498	je	0x100007769
000000010000749e	movq	%rdx, %r8
00000001000074a1	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
00000001000074ab	imulq	%rsi, %rcx
00000001000074af	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
00000001000074b9	movq	%rsi, %rax
00000001000074bc	mulq	%r9
00000001000074bf	addq	%rcx, %rdx
00000001000074c2	imulq	%r8, %r9
00000001000074c6	addq	%rdx, %r9
00000001000074c9	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
00000001000074d3	addq	%rax, %rcx
00000001000074d6	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
00000001000074e0	adcq	%r9, %rax
00000001000074e3	movq	%rax, %rdx
00000001000074e6	shrdq	$0xd, %rcx, %rdx
00000001000074eb	shldq	$0x33, %rcx, %rax
00000001000074f0	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
00000001000074fa	cmpq	%rax, %rcx
00000001000074fd	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
0000000100007502	sbbq	%rdx, %rax
0000000100007505	jae	0x100007786
000000010000750b	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
0000000100007515	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
000000010000751f	movq	%rsi, %rax
0000000100007522	mulq	%r9
0000000100007525	imulq	%rsi, %rcx
0000000100007529	addq	%rcx, %rdx
000000010000752c	imulq	%r8, %r9
0000000100007530	addq	%rdx, %r9
0000000100007533	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
000000010000753d	addq	%rax, %rcx
0000000100007540	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
000000010000754a	adcq	%r9, %rax
000000010000754d	movq	%rax, %rdx
0000000100007550	shrdq	$0xb, %rcx, %rdx
0000000100007555	shldq	$0x35, %rcx, %rax
000000010000755a	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
0000000100007564	cmpq	%rcx, %rax
0000000100007567	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
000000010000756e	jb	0x1000077a8
0000000100007574	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
000000010000757e	imulq	%rsi, %rcx
0000000100007582	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
000000010000758c	movq	%rsi, %rax
000000010000758f	mulq	%r9
0000000100007592	addq	%rcx, %rdx
0000000100007595	imulq	%r8, %r9
0000000100007599	addq	%rdx, %r9
000000010000759c	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
00000001000075a6	addq	%rax, %rcx
00000001000075a9	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
00000001000075b3	adcq	%r9, %rax
00000001000075b6	movq	%rax, %rdx
00000001000075b9	shrdq	$0x9, %rcx, %rdx
00000001000075be	shldq	$0x37, %rcx, %rax
00000001000075c3	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
00000001000075cd	cmpq	%rcx, %rax
00000001000075d0	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
00000001000075da	sbbq	%rax, %rdx
00000001000075dd	jb	0x1000078a8
00000001000075e3	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
00000001000075ed	imulq	%rsi, %rcx
00000001000075f1	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
00000001000075fb	movq	%rsi, %rax
00000001000075fe	mulq	%r9
0000000100007601	addq	%rcx, %rdx
0000000100007604	imulq	%r8, %r9
0000000100007608	addq	%rdx, %r9
000000010000760b	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
0000000100007615	addq	%rax, %rcx
0000000100007618	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
0000000100007622	adcq	%r9, %rax
0000000100007625	movq	%rax, %rdx
0000000100007628	shrdq	$0x6, %rcx, %rdx
000000010000762d	shldq	$0x3a, %rcx, %rax
0000000100007632	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
000000010000763c	cmpq	%rcx, %rax
000000010000763f	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
0000000100007649	sbbq	%rax, %rdx
000000010000764c	jb	0x1000078b9
0000000100007652	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
000000010000765c	imulq	%rsi, %rcx
0000000100007660	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
000000010000766a	movq	%rsi, %rax
000000010000766d	mulq	%r9
0000000100007670	addq	%rcx, %rdx
0000000100007673	imulq	%r8, %r9
0000000100007677	addq	%rdx, %r9
000000010000767a	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
0000000100007684	addq	%rax, %rcx
0000000100007687	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
0000000100007691	adcq	%r9, %rax
0000000100007694	movq	%rax, %rdx
0000000100007697	shrdq	$0x3, %rcx, %rdx
000000010000769c	shldq	$0x3d, %rcx, %rax
00000001000076a1	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
00000001000076ab	cmpq	%rcx, %rax
00000001000076ae	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
00000001000076b8	sbbq	%rax, %rdx
00000001000076bb	jb	0x1000078ca
00000001000076c1	testq	%r8, %r8
00000001000076c4	js	0x100007cec
00000001000076ca	xorl	%r10d, %r10d
00000001000076cd	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000076d7	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000076e1	movq	%r8, %r14
00000001000076e4	nopw	%cs:(%rax,%rax)
00000001000076f0	movq	%r8, %rcx
00000001000076f3	shldq	$0x3f, %rsi, %rcx
00000001000076f8	shrq	%r14
00000001000076fb	movq	%rcx, %r9
00000001000076fe	addq	%r14, %r9
0000000100007701	adcq	$0x0, %r9
0000000100007705	movq	%r9, %rax
0000000100007708	mulq	%r11
000000010000770b	shrq	$0x2, %rdx
000000010000770f	leaq	(%rdx,%rdx,4), %rax
0000000100007713	subq	%rax, %r9
0000000100007716	subq	%r9, %rcx
0000000100007719	sbbq	$0x0, %r14
000000010000771d	movq	%rcx, %r9
0000000100007720	imulq	%rbx, %r9
0000000100007724	movq	%rcx, %rax
0000000100007727	mulq	%r11
000000010000772a	addq	%r9, %rdx
000000010000772d	imulq	%r11, %r14
0000000100007731	addq	%rdx, %r14
0000000100007734	movq	%rax, %rcx
0000000100007737	addq	%rax, %rcx
000000010000773a	leaq	(%rcx,%rcx,4), %rcx
000000010000773e	movl	%esi, %edx
0000000100007740	subl	%ecx, %edx
0000000100007742	orb	$0x30, %dl
0000000100007745	movb	%dl, -0x70(%rbp,%r10)
000000010000774a	incq	%r10
000000010000774d	cmpq	$0xa, %rsi
0000000100007751	sbbq	$0x0, %r8
0000000100007755	movq	%rax, %rsi
0000000100007758	movq	%r14, %r8
000000010000775b	jae	0x1000076f0
000000010000775d	testl	%r10d, %r10d
0000000100007760	jg	0x100007773
0000000100007762	xorl	%eax, %eax
0000000100007764	jmp	0x100007886
0000000100007769	movb	$0x30, -0x70(%rbp)
000000010000776d	movl	$0x1, %r10d
0000000100007773	movl	%r10d, %eax
0000000100007776	cmpq	$0x8, %rax
000000010000777a	jae	0x10000779f
000000010000777c	xorl	%ecx, %ecx
000000010000777e	movq	%rax, %rdx
0000000100007781	jmp	0x100007862
0000000100007786	movq	%rdi, %r14
0000000100007789	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
0000000100007793	leaq	_fwp_fmt_duration.units(%rip), %rbx
000000010000779a	jmp	0x1000078d9
000000010000779f	cmpl	$0x20, %eax
00000001000077a2	jae	0x1000077c1
00000001000077a4	xorl	%ecx, %ecx
00000001000077a6	jmp	0x10000781b
00000001000077a8	movq	%rdi, %r14
00000001000077ab	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
00000001000077b5	leaq	0x2c64(%rip), %rbx
00000001000077bc	jmp	0x1000078d9
00000001000077c1	movl	%r10d, %edx
00000001000077c4	andl	$0x1f, %edx
00000001000077c7	movq	%rax, %rcx
00000001000077ca	subq	%rdx, %rcx
00000001000077cd	leaq	-0xa0(%rbp), %rsi
00000001000077d4	movdqa	0x1ff4(%rip), %xmm0
00000001000077dc	movq	%rax, %r8
00000001000077df	nop
00000001000077e0	movdqu	-0x90(%rbp,%r8), %xmm1
00000001000077ea	movdqu	-0x80(%rbp,%r8), %xmm2
00000001000077f1	pshufb	%xmm0, %xmm2
00000001000077f6	pshufb	%xmm0, %xmm1
00000001000077fb	movdqa	%xmm2, -0x10(%rsi)
0000000100007800	movdqa	%xmm1, (%rsi)
0000000100007804	addq	$-0x20, %r8
0000000100007808	addq	$0x20, %rsi
000000010000780c	cmpq	%r8, %rdx
000000010000780f	jne	0x1000077e0
0000000100007811	testq	%rdx, %rdx
0000000100007814	je	0x100007886
0000000100007816	cmpl	$0x7, %edx
0000000100007819	jbe	0x100007862
000000010000781b	movl	%r10d, %edx
000000010000781e	andl	$0x7, %edx
0000000100007821	movq	%rax, %rsi
0000000100007824	subq	%rcx, %rsi
0000000100007827	leaq	(%rcx,%rbp), %r8
000000010000782b	addq	$-0xb0, %r8
0000000100007832	movq	%rax, %rcx
0000000100007835	subq	%rdx, %rcx
0000000100007838	movq	0x1fa0(%rip), %xmm0
0000000100007840	movq	-0x78(%rbp,%rsi), %xmm1
0000000100007846	pshufb	%xmm0, %xmm1
000000010000784b	movq	%xmm1, (%r8)
0000000100007850	addq	$-0x8, %rsi
0000000100007854	addq	$0x8, %r8
0000000100007858	cmpq	%rsi, %rdx
000000010000785b	jne	0x100007840
000000010000785d	testq	%rdx, %rdx
0000000100007860	je	0x100007886
0000000100007862	leaq	-0x70(%rbp), %rsi
0000000100007866	addq	%rsi, %rdx
0000000100007869	decq	%rdx
000000010000786c	nopl	(%rax)
0000000100007870	movzbl	(%rdx), %esi
0000000100007873	movb	%sil, -0xb0(%rbp,%rcx)
000000010000787b	incq	%rcx
000000010000787e	decq	%rdx
0000000100007881	cmpq	%rcx, %rax
0000000100007884	jne	0x100007870
0000000100007886	movb	$0x0, -0xb0(%rbp,%rax)
000000010000788e	leaq	0x234e(%rip), %rsi              ## literal pool for: "%sns"
0000000100007895	leaq	-0xb0(%rbp), %rdx
000000010000789c	xorl	%eax, %eax
000000010000789e	callq	0x1000096d8                     ## symbol stub for: _sprintf
00000001000078a3	jmp	0x100007cc6
00000001000078a8	movq	%rdi, %r14
00000001000078ab	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
00000001000078b0	leaq	0x2b79(%rip), %rbx
00000001000078b7	jmp	0x1000078d9
00000001000078b9	movq	%rdi, %r14
00000001000078bc	movl	$0xf4240, %edx                  ## imm = 0xF4240
00000001000078c1	leaq	0x2b78(%rip), %rbx
00000001000078c8	jmp	0x1000078d9
00000001000078ca	movq	%rdi, %r14
00000001000078cd	movl	$0x3e8, %edx                    ## imm = 0x3E8
00000001000078d2	leaq	0x2b77(%rip), %rbx
00000001000078d9	xorl	%ecx, %ecx
00000001000078db	movq	%rsi, %rdi
00000001000078de	movq	%r8, %rsi
00000001000078e1	callq	0x1000095c4                     ## symbol stub for: ___divti3
00000001000078e6	movq	%rax, %rcx
00000001000078e9	movq	%rdx, %rsi
00000001000078ec	testq	%rdx, %rdx
00000001000078ef	js	0x1000079a0
00000001000078f5	movq	%rcx, %rax
00000001000078f8	orq	%rsi, %rax
00000001000078fb	je	0x100007a79
0000000100007901	xorl	%r10d, %r10d
0000000100007904	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000790e	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100007918	movq	%rsi, %r12
000000010000791b	movq	%r14, %rdi
000000010000791e	nop
0000000100007920	movq	%rsi, %r8
0000000100007923	shldq	$0x3f, %rcx, %r8
0000000100007928	shrq	%r12
000000010000792b	movq	%r8, %r9
000000010000792e	addq	%r12, %r9
0000000100007931	adcq	$0x0, %r9
0000000100007935	movq	%r9, %rax
0000000100007938	mulq	%r11
000000010000793b	shrq	$0x2, %rdx
000000010000793f	leaq	(%rdx,%rdx,4), %rax
0000000100007943	subq	%rax, %r9
0000000100007946	subq	%r9, %r8
0000000100007949	sbbq	$0x0, %r12
000000010000794d	movq	%r8, %r9
0000000100007950	imulq	%r15, %r9
0000000100007954	movq	%r8, %rax
0000000100007957	mulq	%r11
000000010000795a	addq	%r9, %rdx
000000010000795d	imulq	%r11, %r12
0000000100007961	addq	%rdx, %r12
0000000100007964	movq	%rax, %rdx
0000000100007967	addq	%rax, %rdx
000000010000796a	leaq	(%rdx,%rdx,4), %rdx
000000010000796e	movl	%ecx, %r8d
0000000100007971	subl	%edx, %r8d
0000000100007974	orb	$0x30, %r8b
0000000100007978	movb	%r8b, -0x70(%rbp,%r10)
000000010000797d	incq	%r10
0000000100007980	cmpq	$0xa, %rcx
0000000100007984	sbbq	$0x0, %rsi
0000000100007988	movq	%rax, %rcx
000000010000798b	movq	%r12, %rsi
000000010000798e	jae	0x100007920
0000000100007990	testl	%r10d, %r10d
0000000100007993	jg	0x100007a86
0000000100007999	xorl	%eax, %eax
000000010000799b	jmp	0x100007b76
00000001000079a0	movb	$0x2d, -0xb0(%rbp)
00000001000079a7	xorl	%r9d, %r9d
00000001000079aa	negq	%rcx
00000001000079ad	movl	$0x0, %r11d
00000001000079b3	sbbq	%rsi, %r11
00000001000079b6	movl	$0x1, %r13d
00000001000079bc	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000079c6	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000079d0	movq	%r11, %r12
00000001000079d3	nopw	%cs:(%rax,%rax)
00000001000079e0	movq	%r11, %rsi
00000001000079e3	shldq	$0x3f, %rcx, %rsi
00000001000079e8	shrq	%r12
00000001000079eb	movq	%rsi, %rdi
00000001000079ee	addq	%r12, %rdi
00000001000079f1	adcq	$0x0, %rdi
00000001000079f5	movq	%rdi, %rax
00000001000079f8	mulq	%r10
00000001000079fb	movl	%r13d, %r8d
00000001000079fe	shrq	$0x2, %rdx
0000000100007a02	leaq	(%rdx,%rdx,4), %rax
0000000100007a06	subq	%rax, %rdi
0000000100007a09	subq	%rdi, %rsi
0000000100007a0c	sbbq	$0x0, %r12
0000000100007a10	movq	%rsi, %rdi
0000000100007a13	movq	%rsi, %rax
0000000100007a16	mulq	%r10
0000000100007a19	imulq	%r15, %rdi
0000000100007a1d	addq	%rdi, %rdx
0000000100007a20	imulq	%r10, %r12
0000000100007a24	addq	%rdx, %r12
0000000100007a27	movq	%rax, %rdx
0000000100007a2a	addq	%rax, %rdx
0000000100007a2d	leaq	(%rdx,%rdx,4), %rdx
0000000100007a31	movl	%ecx, %esi
0000000100007a33	subl	%edx, %esi
0000000100007a35	orb	$0x30, %sil
0000000100007a39	movb	%sil, -0x70(%rbp,%r9)
0000000100007a3e	incq	%r9
0000000100007a41	leal	0x1(%r8), %r13d
0000000100007a45	cmpq	$0xa, %rcx
0000000100007a49	sbbq	$0x0, %r11
0000000100007a4d	movq	%rax, %rcx
0000000100007a50	movq	%r12, %r11
0000000100007a53	jae	0x1000079e0
0000000100007a55	testl	%r9d, %r9d
0000000100007a58	movq	%r14, %rdi
0000000100007a5b	jle	0x100007aa2
0000000100007a5d	movl	%r9d, %eax
0000000100007a60	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100007a65	cmpq	$0x8, %rax
0000000100007a69	jae	0x100007b83
0000000100007a6f	xorl	%ecx, %ecx
0000000100007a71	movq	%rax, %rdx
0000000100007a74	jmp	0x100007c75
0000000100007a79	movb	$0x30, -0x70(%rbp)
0000000100007a7d	movl	$0x1, %r10d
0000000100007a83	movq	%r14, %rdi
0000000100007a86	movl	%r10d, %eax
0000000100007a89	cmpq	$0x8, %rax
0000000100007a8d	jae	0x100007a99
0000000100007a8f	xorl	%ecx, %ecx
0000000100007a91	movq	%rax, %rdx
0000000100007a94	jmp	0x100007b52
0000000100007a99	cmpl	$0x20, %eax
0000000100007a9c	jae	0x100007aa9
0000000100007a9e	xorl	%ecx, %ecx
0000000100007aa0	jmp	0x100007b0b
0000000100007aa2	xorl	%eax, %eax
0000000100007aa4	jmp	0x100007ca6
0000000100007aa9	movl	%r10d, %edx
0000000100007aac	andl	$0x1f, %edx
0000000100007aaf	movq	%rax, %rcx
0000000100007ab2	subq	%rdx, %rcx
0000000100007ab5	leaq	-0xa0(%rbp), %rsi
0000000100007abc	movdqa	0x1d0c(%rip), %xmm0
0000000100007ac4	movq	%rax, %r8
0000000100007ac7	nopw	(%rax,%rax)
0000000100007ad0	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100007ada	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100007ae1	pshufb	%xmm0, %xmm2
0000000100007ae6	pshufb	%xmm0, %xmm1
0000000100007aeb	movdqa	%xmm2, -0x10(%rsi)
0000000100007af0	movdqa	%xmm1, (%rsi)
0000000100007af4	addq	$-0x20, %r8
0000000100007af8	addq	$0x20, %rsi
0000000100007afc	cmpq	%r8, %rdx
0000000100007aff	jne	0x100007ad0
0000000100007b01	testq	%rdx, %rdx
0000000100007b04	je	0x100007b76
0000000100007b06	cmpl	$0x7, %edx
0000000100007b09	jbe	0x100007b52
0000000100007b0b	movl	%r10d, %edx
0000000100007b0e	andl	$0x7, %edx
0000000100007b11	movq	%rax, %rsi
0000000100007b14	subq	%rcx, %rsi
0000000100007b17	leaq	(%rcx,%rbp), %r8
0000000100007b1b	addq	$-0xb0, %r8
0000000100007b22	movq	%rax, %rcx
0000000100007b25	subq	%rdx, %rcx
0000000100007b28	movq	0x1cb0(%rip), %xmm0
0000000100007b30	movq	-0x78(%rbp,%rsi), %xmm1
0000000100007b36	pshufb	%xmm0, %xmm1
0000000100007b3b	movq	%xmm1, (%r8)
0000000100007b40	addq	$-0x8, %rsi
0000000100007b44	addq	$0x8, %r8
0000000100007b48	cmpq	%rsi, %rdx
0000000100007b4b	jne	0x100007b30
0000000100007b4d	testq	%rdx, %rdx
0000000100007b50	je	0x100007b76
0000000100007b52	leaq	-0x70(%rbp), %rsi
0000000100007b56	addq	%rsi, %rdx
0000000100007b59	decq	%rdx
0000000100007b5c	nopl	(%rax)
0000000100007b60	movzbl	(%rdx), %esi
0000000100007b63	movb	%sil, -0xb0(%rbp,%rcx)
0000000100007b6b	incq	%rcx
0000000100007b6e	decq	%rdx
0000000100007b71	cmpq	%rcx, %rax
0000000100007b74	jne	0x100007b60
0000000100007b76	movb	$0x0, -0xb0(%rbp,%rax)
0000000100007b7e	jmp	0x100007cae
0000000100007b83	cmpl	$0x20, %eax
0000000100007b86	jae	0x100007b8c
0000000100007b88	xorl	%ecx, %ecx
0000000100007b8a	jmp	0x100007c04
0000000100007b8c	movl	%r9d, %edx
0000000100007b8f	andl	$0x1f, %edx
0000000100007b92	movq	%rax, %rcx
0000000100007b95	subq	%rdx, %rcx
0000000100007b98	movl	%r8d, %esi
0000000100007b9b	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100007ba1	leaq	(%rsi,%rbp), %r10
0000000100007ba5	addq	$-0x80, %r10
0000000100007ba9	movl	%r8d, %r11d
0000000100007bac	andl	$0x1f, %r11d
0000000100007bb0	subq	%r11, %rsi
0000000100007bb3	xorl	%r11d, %r11d
0000000100007bb6	movdqa	0x1c12(%rip), %xmm0
0000000100007bbe	nop
0000000100007bc0	movdqu	-0x10(%r10), %xmm1
0000000100007bc6	movdqu	(%r10), %xmm2
0000000100007bcb	pshufb	%xmm0, %xmm2
0000000100007bd0	pshufb	%xmm0, %xmm1
0000000100007bd5	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100007bdf	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100007be9	addq	$0x20, %r11
0000000100007bed	addq	$-0x20, %r10
0000000100007bf1	cmpq	%r11, %rsi
0000000100007bf4	jne	0x100007bc0
0000000100007bf6	testq	%rdx, %rdx
0000000100007bf9	je	0x100007ca6
0000000100007bff	cmpl	$0x7, %edx
0000000100007c02	jbe	0x100007c75
0000000100007c04	movq	%rcx, %rsi
0000000100007c07	movl	%r9d, %edx
0000000100007c0a	andl	$0x7, %edx
0000000100007c0d	movq	%rax, %rcx
0000000100007c10	subq	%rdx, %rcx
0000000100007c13	movq	%rsi, %r9
0000000100007c16	negq	%r9
0000000100007c19	leaq	(%r9,%rbp), %r10
0000000100007c1d	addq	$-0x70, %r10
0000000100007c21	movl	%r8d, %r9d
0000000100007c24	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100007c2b	addq	%r9, %r10
0000000100007c2e	addq	$-0x8, %r10
0000000100007c32	movl	%r8d, %r11d
0000000100007c35	andl	$0x7, %r11d
0000000100007c39	subq	%r11, %r9
0000000100007c3c	movq	0x1b9c(%rip), %xmm0
0000000100007c44	nopw	%cs:(%rax,%rax)
0000000100007c50	movq	(%r10), %xmm1
0000000100007c55	pshufb	%xmm0, %xmm1
0000000100007c5a	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100007c63	addq	$0x8, %rsi
0000000100007c67	addq	$-0x8, %r10
0000000100007c6b	cmpq	%rsi, %r9
0000000100007c6e	jne	0x100007c50
0000000100007c70	testq	%rdx, %rdx
0000000100007c73	je	0x100007ca6
0000000100007c75	leaq	-0x70(%rbp), %rsi
0000000100007c79	addq	%rsi, %rdx
0000000100007c7c	decq	%rdx
0000000100007c7f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100007c86	nopw	%cs:(%rax,%rax)
0000000100007c90	movzbl	(%rdx), %esi
0000000100007c93	movb	%sil, -0xaf(%rbp,%rcx)
0000000100007c9b	incq	%rcx
0000000100007c9e	decq	%rdx
0000000100007ca1	cmpq	%rcx, %r8
0000000100007ca4	jne	0x100007c90
0000000100007ca6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100007cae	movq	(%rbx), %rcx
0000000100007cb1	leaq	0x1f26(%rip), %rsi              ## literal pool for: "%s%s"
0000000100007cb8	leaq	-0xb0(%rbp), %rdx
0000000100007cbf	xorl	%eax, %eax
0000000100007cc1	callq	0x1000096d8                     ## symbol stub for: _sprintf
0000000100007cc6	movq	0x2363(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007ccd	movq	(%rax), %rax
0000000100007cd0	cmpq	-0x30(%rbp), %rax
0000000100007cd4	jne	0x100007ed3
0000000100007cda	addq	$0x88, %rsp
0000000100007ce1	popq	%rbx
0000000100007ce2	popq	%r12
0000000100007ce4	popq	%r13
0000000100007ce6	popq	%r14
0000000100007ce8	popq	%r15
0000000100007cea	popq	%rbp
0000000100007ceb	retq
0000000100007cec	movb	$0x2d, -0xb0(%rbp)
0000000100007cf3	xorl	%r10d, %r10d
0000000100007cf6	negq	%rsi
0000000100007cf9	movl	$0x0, %ebx
0000000100007cfe	sbbq	%r8, %rbx
0000000100007d01	movl	$0x1, %r12d
0000000100007d07	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100007d11	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100007d1b	movq	%rbx, %r15
0000000100007d1e	nop
0000000100007d20	movq	%rbx, %rcx
0000000100007d23	shldq	$0x3f, %rsi, %rcx
0000000100007d28	shrq	%r15
0000000100007d2b	movq	%rcx, %r8
0000000100007d2e	addq	%r15, %r8
0000000100007d31	adcq	$0x0, %r8
0000000100007d35	movq	%r8, %rax
0000000100007d38	mulq	%r11
0000000100007d3b	movl	%r12d, %r9d
0000000100007d3e	shrq	$0x2, %rdx
0000000100007d42	leaq	(%rdx,%rdx,4), %rax
0000000100007d46	subq	%rax, %r8
0000000100007d49	subq	%r8, %rcx
0000000100007d4c	sbbq	$0x0, %r15
0000000100007d50	movq	%rcx, %r8
0000000100007d53	movq	%rcx, %rax
0000000100007d56	mulq	%r11
0000000100007d59	imulq	%r14, %r8
0000000100007d5d	addq	%r8, %rdx
0000000100007d60	imulq	%r11, %r15
0000000100007d64	addq	%rdx, %r15
0000000100007d67	movq	%rax, %rcx
0000000100007d6a	addq	%rax, %rcx
0000000100007d6d	leaq	(%rcx,%rcx,4), %rcx
0000000100007d71	movl	%esi, %edx
0000000100007d73	subl	%ecx, %edx
0000000100007d75	orb	$0x30, %dl
0000000100007d78	movb	%dl, -0x70(%rbp,%r10)
0000000100007d7d	incq	%r10
0000000100007d80	leal	0x1(%r9), %r12d
0000000100007d84	cmpq	$0xa, %rsi
0000000100007d88	sbbq	$0x0, %rbx
0000000100007d8c	movq	%rax, %rsi
0000000100007d8f	movq	%r15, %rbx
0000000100007d92	jae	0x100007d20
0000000100007d94	testl	%r10d, %r10d
0000000100007d97	jle	0x100007db1
0000000100007d99	movl	%r10d, %eax
0000000100007d9c	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100007da1	cmpq	$0x8, %rax
0000000100007da5	jae	0x100007db8
0000000100007da7	xorl	%ecx, %ecx
0000000100007da9	movq	%rax, %rdx
0000000100007dac	jmp	0x100007e9c
0000000100007db1	xorl	%eax, %eax
0000000100007db3	jmp	0x100007ec6
0000000100007db8	cmpl	$0x20, %eax
0000000100007dbb	jae	0x100007dc1
0000000100007dbd	xorl	%ecx, %ecx
0000000100007dbf	jmp	0x100007e37
0000000100007dc1	movl	%r10d, %edx
0000000100007dc4	andl	$0x1f, %edx
0000000100007dc7	movq	%rax, %rcx
0000000100007dca	subq	%rdx, %rcx
0000000100007dcd	movl	%r9d, %esi
0000000100007dd0	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100007dd6	leaq	(%rsi,%rbp), %r8
0000000100007dda	addq	$-0x80, %r8
0000000100007dde	movl	%r9d, %r11d
0000000100007de1	andl	$0x1f, %r11d
0000000100007de5	subq	%r11, %rsi
0000000100007de8	xorl	%r11d, %r11d
0000000100007deb	movdqa	0x19dd(%rip), %xmm0
0000000100007df3	movdqu	-0x10(%r8), %xmm1
0000000100007df9	movdqu	(%r8), %xmm2
0000000100007dfe	pshufb	%xmm0, %xmm2
0000000100007e03	pshufb	%xmm0, %xmm1
0000000100007e08	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100007e12	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100007e1c	addq	$0x20, %r11
0000000100007e20	addq	$-0x20, %r8
0000000100007e24	cmpq	%r11, %rsi
0000000100007e27	jne	0x100007df3
0000000100007e29	testq	%rdx, %rdx
0000000100007e2c	je	0x100007ec6
0000000100007e32	cmpl	$0x7, %edx
0000000100007e35	jbe	0x100007e9c
0000000100007e37	movq	%rcx, %rsi
0000000100007e3a	movl	%r10d, %edx
0000000100007e3d	andl	$0x7, %edx
0000000100007e40	movq	%rax, %rcx
0000000100007e43	subq	%rdx, %rcx
0000000100007e46	movq	%rsi, %r8
0000000100007e49	negq	%r8
0000000100007e4c	leaq	(%r8,%rbp), %r10
0000000100007e50	addq	$-0x70, %r10
0000000100007e54	movl	%r9d, %r8d
0000000100007e57	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100007e5e	addq	%r8, %r10
0000000100007e61	addq	$-0x8, %r10
0000000100007e65	movl	%r9d, %r11d
0000000100007e68	andl	$0x7, %r11d
0000000100007e6c	subq	%r11, %r8
0000000100007e6f	movq	0x1969(%rip), %xmm0
0000000100007e77	movq	(%r10), %xmm1
0000000100007e7c	pshufb	%xmm0, %xmm1
0000000100007e81	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100007e8a	addq	$0x8, %rsi
0000000100007e8e	addq	$-0x8, %r10
0000000100007e92	cmpq	%rsi, %r8
0000000100007e95	jne	0x100007e77
0000000100007e97	testq	%rdx, %rdx
0000000100007e9a	je	0x100007ec6
0000000100007e9c	leaq	-0x70(%rbp), %rsi
0000000100007ea0	addq	%rsi, %rdx
0000000100007ea3	decq	%rdx
0000000100007ea6	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100007ead	nopl	(%rax)
0000000100007eb0	movzbl	(%rdx), %esi
0000000100007eb3	movb	%sil, -0xaf(%rbp,%rcx)
0000000100007ebb	incq	%rcx
0000000100007ebe	decq	%rdx
0000000100007ec1	cmpq	%rcx, %r9
0000000100007ec4	jne	0x100007eb0
0000000100007ec6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100007ece	jmp	0x10000788e
0000000100007ed3	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100007ed8	nopl	(%rax,%rax)
_fwp_format_g:
0000000100007ee0	pushq	%rbp
0000000100007ee1	movq	%rsp, %rbp
0000000100007ee4	pushq	%r15
0000000100007ee6	pushq	%r14
0000000100007ee8	pushq	%r13
0000000100007eea	pushq	%r12
0000000100007eec	pushq	%rbx
0000000100007eed	subq	$0x98, %rsp
0000000100007ef4	movl	%esi, %r12d
0000000100007ef7	movq	%rdi, %rbx
0000000100007efa	movq	0x212f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007f01	movq	(%rax), %rax
0000000100007f04	movq	%rax, -0x30(%rbp)
0000000100007f08	decl	%r12d
0000000100007f0b	leaq	0x1c91(%rip), %rdx              ## literal pool for: "%.*e"
0000000100007f12	leaq	-0x70(%rbp), %r13
0000000100007f16	movl	$0x40, %esi
0000000100007f1b	movq	%r13, %rdi
0000000100007f1e	movl	%r12d, %ecx
0000000100007f21	movsd	%xmm0, -0xb8(%rbp)
0000000100007f29	movb	$0x1, %al
0000000100007f2b	callq	0x1000096d2                     ## symbol stub for: _snprintf
0000000100007f30	movq	%r13, %rdi
0000000100007f33	movl	$0x65, %esi
0000000100007f38	callq	0x1000096de                     ## symbol stub for: _strchr
0000000100007f3d	movq	%rax, %r15
0000000100007f40	leaq	0x1(%rax), %rdi
0000000100007f44	callq	0x10000960c                     ## symbol stub for: _atoi
0000000100007f49	movl	%eax, %r14d
0000000100007f4c	leal	-0x11(%r14), %eax
0000000100007f50	cmpl	$-0x17, %eax
0000000100007f53	ja	0x100007fbe
0000000100007f55	subq	%r13, %r15
0000000100007f58	leaq	-0xb0(%rbp), %r12
0000000100007f5f	movl	$0x40, %ecx
0000000100007f64	movq	%r12, %rdi
0000000100007f67	movq	%r13, %rsi
0000000100007f6a	movq	%r15, %rdx
0000000100007f6d	callq	0x1000095d0                     ## symbol stub for: ___memcpy_chk
0000000100007f72	movb	$0x0, -0xb0(%rbp,%r15)
0000000100007f7b	movq	%r12, %rdi
0000000100007f7e	movl	$0x2e, %esi
0000000100007f83	callq	0x1000096de                     ## symbol stub for: _strchr
0000000100007f88	testq	%rax, %rax
0000000100007f8b	sete	%al
0000000100007f8e	testq	%r15, %r15
0000000100007f91	sete	%cl
0000000100007f94	orb	%al, %cl
0000000100007f96	jne	0x100008036
0000000100007f9c	nopl	(%rax)
0000000100007fa0	movzbl	-0xb1(%rbp,%r15), %eax
0000000100007fa9	cmpl	$0x30, %eax
0000000100007fac	jne	0x100008028
0000000100007fae	movb	$0x0, -0xb1(%rbp,%r15)
0000000100007fb7	decq	%r15
0000000100007fba	jne	0x100007fa0
0000000100007fbc	jmp	0x100008036
0000000100007fbe	subl	%r14d, %r12d
0000000100007fc1	xorl	%ecx, %ecx
0000000100007fc3	testl	%r12d, %r12d
0000000100007fc6	cmovgl	%r12d, %ecx
0000000100007fca	leaq	0x1be1(%rip), %rdx              ## literal pool for: "%.*f"
0000000100007fd1	movl	$0x190, %esi                    ## imm = 0x190
0000000100007fd6	movq	%rbx, %rdi
0000000100007fd9	movsd	-0xb8(%rbp), %xmm0
0000000100007fe1	movb	$0x1, %al
0000000100007fe3	callq	0x1000096d2                     ## symbol stub for: _snprintf
0000000100007fe8	movq	%rbx, %rdi
0000000100007feb	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100007ff0	movq	%rax, %r14
0000000100007ff3	movq	%rbx, %rdi
0000000100007ff6	movl	$0x2e, %esi
0000000100007ffb	callq	0x1000096de                     ## symbol stub for: _strchr
0000000100008000	testq	%rax, %rax
0000000100008003	sete	%al
0000000100008006	testq	%r14, %r14
0000000100008009	sete	%cl
000000010000800c	orb	%al, %cl
000000010000800e	jne	0x10000806b
0000000100008010	movzbl	-0x1(%rbx,%r14), %eax
0000000100008016	cmpl	$0x30, %eax
0000000100008019	jne	0x10000808d
000000010000801b	movb	$0x0, -0x1(%rbx,%r14)
0000000100008021	decq	%r14
0000000100008024	jne	0x100008010
0000000100008026	jmp	0x10000806b
0000000100008028	cmpl	$0x2e, %eax
000000010000802b	jne	0x100008036
000000010000802d	movb	$0x0, -0xb1(%rbp,%r15)
0000000100008036	movl	%r14d, %eax
0000000100008039	shrl	$0x1f, %eax
000000010000803c	leal	0x2b(,%rax,2), %r8d
0000000100008044	movl	%r14d, %r9d
0000000100008047	negl	%r9d
000000010000804a	cmovsl	%r14d, %r9d
000000010000804e	leaq	0x1b53(%rip), %rdx              ## literal pool for: "%se%c%02d"
0000000100008055	leaq	-0xb0(%rbp), %rcx
000000010000805c	movl	$0x190, %esi                    ## imm = 0x190
0000000100008061	movq	%rbx, %rdi
0000000100008064	xorl	%eax, %eax
0000000100008066	callq	0x1000096d2                     ## symbol stub for: _snprintf
000000010000806b	movq	0x1fbe(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008072	movq	(%rax), %rax
0000000100008075	cmpq	-0x30(%rbp), %rax
0000000100008079	jne	0x10000809a
000000010000807b	addq	$0x98, %rsp
0000000100008082	popq	%rbx
0000000100008083	popq	%r12
0000000100008085	popq	%r13
0000000100008087	popq	%r14
0000000100008089	popq	%r15
000000010000808b	popq	%rbp
000000010000808c	retq
000000010000808d	cmpl	$0x2e, %eax
0000000100008090	jne	0x10000806b
0000000100008092	movb	$0x0, -0x1(%rbx,%r14)
0000000100008098	jmp	0x10000806b
000000010000809a	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
000000010000809f	nop
_fwp_owned_entry3:
00000001000080a0	pushq	%rbp
00000001000080a1	movq	%rsp, %rbp
00000001000080a4	pushq	%r15
00000001000080a6	pushq	%r14
00000001000080a8	pushq	%rbx
00000001000080a9	subq	$0x18, %rsp
00000001000080ad	movq	%rdi, %rbx
00000001000080b0	movq	_fwp_cleanups(%rip), %rax
00000001000080b7	movq	%rax, -0x30(%rbp)
00000001000080bb	leaq	_fwp_entry_release3(%rip), %rax
00000001000080c2	movq	%rax, -0x28(%rbp)
00000001000080c6	movq	%rdi, -0x20(%rbp)
00000001000080ca	leaq	-0x30(%rbp), %r15
00000001000080ce	movq	%r15, _fwp_cleanups(%rip)
00000001000080d5	movq	(%rdi), %rdi
00000001000080d8	movq	0x8(%rbx), %rsi
00000001000080dc	callq	_fwp_p_file_with_owned
00000001000080e1	cmpq	%r15, _fwp_cleanups(%rip)
00000001000080e8	jne	0x1000081b5
00000001000080ee	movq	%rax, %r14
00000001000080f1	movq	-0x30(%rbp), %rax
00000001000080f5	movq	%rax, _fwp_cleanups(%rip)
00000001000080fc	movq	(%rbx), %rax
00000001000080ff	movq	(%rbx), %rdi
0000000100008102	movq	%rdi, %rcx
0000000100008105	subq	0x3f2c(%rip), %rcx
000000010000810c	movq	0x3f4d(%rip), %rax
0000000100008113	shlq	$0x10, %rax
0000000100008117	cmpq	%rax, %rcx
000000010000811a	jae	0x100008190
000000010000811c	movq	0x3f5d(%rip), %rdx
0000000100008123	movq	%rcx, %rax
0000000100008126	shrq	$0x10, %rax
000000010000812a	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008131	leaq	(%rdx,%rsi), %rax
0000000100008135	movzbl	(%rdx,%rsi), %edx
0000000100008139	cmpb	$0x2, %dl
000000010000813c	setne	%sil
0000000100008140	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008147	setne	%r8b
000000010000814b	orb	%sil, %r8b
000000010000814e	jne	0x100008158
0000000100008150	addq	$0x228, %rax                    ## imm = 0x228
0000000100008156	jmp	0x100008171
0000000100008158	cmpb	$0x1, %dl
000000010000815b	jne	0x100008190
000000010000815d	movl	0x20(%rax), %edx
0000000100008160	imulq	%rdx, %rcx
0000000100008164	shrq	$0x20, %rcx
0000000100008168	addq	%rcx, %rax
000000010000816b	addq	$0x228, %rax                    ## imm = 0x228
0000000100008171	movzbl	(%rax), %ecx
0000000100008174	testl	%ecx, %ecx
0000000100008176	je	0x100008190
0000000100008178	cmpl	$0x1, %ecx
000000010000817b	jne	0x100008184
000000010000817d	callq	_fwp_rc_free_obj
0000000100008182	jmp	0x100008190
0000000100008184	cmpl	$0xff, %ecx
000000010000818a	je	0x1000081ab
000000010000818c	decb	%cl
000000010000818e	movb	%cl, (%rax)
0000000100008190	movq	0x8(%rbx), %rax
0000000100008194	movq	0x8(%rbx), %rdi
0000000100008198	callq	_fwp_closure_drop
000000010000819d	movq	%r14, %rax
00000001000081a0	addq	$0x18, %rsp
00000001000081a4	popq	%rbx
00000001000081a5	popq	%r14
00000001000081a7	popq	%r15
00000001000081a9	popq	%rbp
00000001000081aa	retq
00000001000081ab	movq	%rax, %rdi
00000001000081ae	callq	_fwp_rc_wide_drop
00000001000081b3	jmp	0x100008190
00000001000081b5	callq	0x100009600                     ## symbol stub for: _abort
00000001000081ba	nopw	(%rax,%rax)
_fwp_caps3:
00000001000081c0	testl	%esi, %esi
00000001000081c2	je	0x1000081d2
00000001000081c4	movl	0x4(%rdi), %edx
00000001000081c7	addq	$0x8, %rdi
00000001000081cb	xorl	%esi, %esi
00000001000081cd	jmp	_fwp_args3
00000001000081d2	pushq	%rbp
00000001000081d3	movq	%rsp, %rbp
00000001000081d6	pushq	%rbx
00000001000081d7	pushq	%rax
00000001000081d8	cmpl	$0x0, 0x4(%rdi)
00000001000081dc	je	0x10000829e
00000001000081e2	movq	0x8(%rdi), %rax
00000001000081e6	movq	%rax, %rdx
00000001000081e9	subq	0x3e48(%rip), %rdx
00000001000081f0	movq	0x3e69(%rip), %rcx
00000001000081f7	shlq	$0x10, %rcx
00000001000081fb	cmpq	%rcx, %rdx
00000001000081fe	jae	0x100008286
0000000100008204	movq	0x3e75(%rip), %rsi
000000010000820b	movq	%rdx, %rcx
000000010000820e	shrq	$0x10, %rcx
0000000100008212	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
0000000100008219	leaq	(%rsi,%r8), %rcx
000000010000821d	movzbl	(%rsi,%r8), %esi
0000000100008222	cmpb	$0x2, %sil
0000000100008226	setne	%r8b
000000010000822a	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100008231	setne	%r9b
0000000100008235	orb	%r8b, %r9b
0000000100008238	jne	0x100008243
000000010000823a	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008241	jmp	0x10000825e
0000000100008243	cmpb	$0x1, %sil
0000000100008247	jne	0x100008286
0000000100008249	movl	0x20(%rcx), %esi
000000010000824c	imulq	%rsi, %rdx
0000000100008250	shrq	$0x20, %rdx
0000000100008254	addq	%rdx, %rcx
0000000100008257	addq	$0x228, %rcx                    ## imm = 0x228
000000010000825e	movzbl	(%rcx), %edx
0000000100008261	testl	%edx, %edx
0000000100008263	je	0x100008286
0000000100008265	cmpl	$0x1, %edx
0000000100008268	jne	0x10000827a
000000010000826a	movq	%rdi, %rbx
000000010000826d	movq	%rax, %rdi
0000000100008270	callq	_fwp_rc_free_obj
0000000100008275	movq	%rbx, %rdi
0000000100008278	jmp	0x100008286
000000010000827a	cmpl	$0xff, %edx
0000000100008280	je	0x1000082a9
0000000100008282	decb	%dl
0000000100008284	movb	%dl, (%rcx)
0000000100008286	cmpl	$0x2, 0x4(%rdi)
000000010000828a	jb	0x10000829e
000000010000828c	movq	0x10(%rdi), %rax
0000000100008290	movq	%rdi, %rbx
0000000100008293	movq	%rax, %rdi
0000000100008296	callq	_fwp_closure_drop
000000010000829b	movq	%rbx, %rdi
000000010000829e	addq	$0x8, %rsp
00000001000082a2	popq	%rbx
00000001000082a3	popq	%rbp
00000001000082a4	jmp	_fwp_rc_free_obj
00000001000082a9	movq	%rdi, %rbx
00000001000082ac	movq	%rcx, %rdi
00000001000082af	callq	_fwp_rc_wide_drop
00000001000082b4	jmp	0x100008275
00000001000082b6	nopw	%cs:(%rax,%rax)
_fwp_args3:
00000001000082c0	pushq	%rbp
00000001000082c1	movq	%rsp, %rbp
00000001000082c4	pushq	%r15
00000001000082c6	pushq	%r14
00000001000082c8	pushq	%r12
00000001000082ca	pushq	%rbx
00000001000082cb	subq	$0x30, %rsp
00000001000082cf	movq	%rdi, -0x38(%rbp)
00000001000082d3	leaq	_fwp_arg_drop3(%rip), %rax
00000001000082da	movq	%rax, -0x30(%rbp)
00000001000082de	movl	%esi, -0x28(%rbp)
00000001000082e1	movl	$0x0, -0x24(%rbp)
00000001000082e8	movq	_fwp_cleanups(%rip), %rax
00000001000082ef	movq	%rax, -0x50(%rbp)
00000001000082f3	leaq	_fwp_args_release(%rip), %rax
00000001000082fa	movq	%rax, -0x48(%rbp)
00000001000082fe	leaq	-0x38(%rbp), %rax
0000000100008302	movq	%rax, -0x40(%rbp)
0000000100008306	leaq	-0x50(%rbp), %rbx
000000010000830a	movq	%rbx, _fwp_cleanups(%rip)
0000000100008311	testl	%esi, %esi
0000000100008313	setne	%al
0000000100008316	testl	%edx, %edx
0000000100008318	sete	%cl
000000010000831b	orb	%al, %cl
000000010000831d	je	0x10000832d
000000010000831f	cmpl	$0x1, %esi
0000000100008322	jbe	0x1000083bb
0000000100008328	jmp	0x100008455
000000010000832d	movq	(%rdi), %rcx
0000000100008330	subq	0x3d01(%rip), %rcx
0000000100008337	movq	0x3d22(%rip), %rax
000000010000833e	shlq	$0x10, %rax
0000000100008342	cmpq	%rax, %rcx
0000000100008345	jae	0x1000083b4
0000000100008347	movq	0x3d32(%rip), %r8
000000010000834e	movq	%rcx, %rax
0000000100008351	shrq	$0x10, %rax
0000000100008355	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
000000010000835c	leaq	(%r8,%r9), %rax
0000000100008360	movzbl	(%r8,%r9), %r8d
0000000100008365	cmpb	$0x2, %r8b
0000000100008369	setne	%r9b
000000010000836d	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008374	setne	%r10b
0000000100008378	orb	%r9b, %r10b
000000010000837b	jne	0x100008385
000000010000837d	addq	$0x228, %rax                    ## imm = 0x228
0000000100008383	jmp	0x1000083a0
0000000100008385	cmpb	$0x1, %r8b
0000000100008389	jne	0x1000083b4
000000010000838b	movl	0x20(%rax), %r8d
000000010000838f	imulq	%r8, %rcx
0000000100008393	shrq	$0x20, %rcx
0000000100008397	addq	%rcx, %rax
000000010000839a	addq	$0x228, %rax                    ## imm = 0x228
00000001000083a0	movzbl	(%rax), %ecx
00000001000083a3	testb	%cl, %cl
00000001000083a5	je	0x1000083b4
00000001000083a7	cmpb	$-0x2, %cl
00000001000083aa	jae	0x100008476
00000001000083b0	incb	%cl
00000001000083b2	movb	%cl, (%rax)
00000001000083b4	movl	$0x1, -0x24(%rbp)
00000001000083bb	movl	$0x1, %eax
00000001000083c0	subl	%esi, %eax
00000001000083c2	cmpl	%edx, %eax
00000001000083c4	jae	0x100008455
00000001000083ca	movl	%eax, %eax
00000001000083cc	movq	(%rdi,%rax,8), %rax
00000001000083d0	subq	0x3c61(%rip), %rax
00000001000083d7	movq	0x3c82(%rip), %rcx
00000001000083de	shlq	$0x10, %rcx
00000001000083e2	cmpq	%rcx, %rax
00000001000083e5	jae	0x10000844b
00000001000083e7	movq	0x3c92(%rip), %rcx
00000001000083ee	movq	%rax, %rdx
00000001000083f1	shrq	$0x10, %rdx
00000001000083f5	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000083fc	leaq	(%rcx,%rdx), %rdi
0000000100008400	movzbl	(%rcx,%rdx), %ecx
0000000100008404	cmpb	$0x2, %cl
0000000100008407	setne	%dl
000000010000840a	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008410	setne	%r8b
0000000100008414	orb	%dl, %r8b
0000000100008417	jne	0x100008422
0000000100008419	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008420	jmp	0x10000843c
0000000100008422	cmpb	$0x1, %cl
0000000100008425	jne	0x10000844b
0000000100008427	movl	0x20(%rdi), %ecx
000000010000842a	imulq	%rcx, %rax
000000010000842e	shrq	$0x20, %rax
0000000100008432	addq	%rax, %rdi
0000000100008435	addq	$0x228, %rdi                    ## imm = 0x228
000000010000843c	movzbl	(%rdi), %eax
000000010000843f	testb	%al, %al
0000000100008441	je	0x10000844b
0000000100008443	cmpb	$-0x2, %al
0000000100008445	jae	0x100008495
0000000100008447	incb	%al
0000000100008449	movb	%al, (%rdi)
000000010000844b	movl	$0x2, %eax
0000000100008450	subl	%esi, %eax
0000000100008452	movl	%eax, -0x24(%rbp)
0000000100008455	cmpq	%rbx, _fwp_cleanups(%rip)
000000010000845c	jne	0x1000084a2
000000010000845e	movq	-0x50(%rbp), %rax
0000000100008462	movq	%rax, _fwp_cleanups(%rip)
0000000100008469	addq	$0x30, %rsp
000000010000846d	popq	%rbx
000000010000846e	popq	%r12
0000000100008470	popq	%r14
0000000100008472	popq	%r15
0000000100008474	popq	%rbp
0000000100008475	retq
0000000100008476	movq	%rdi, %r14
0000000100008479	movq	%rax, %rdi
000000010000847c	movl	%esi, %r15d
000000010000847f	movl	%edx, %r12d
0000000100008482	callq	_fwp_rc_wide_dup
0000000100008487	movl	%r12d, %edx
000000010000848a	movq	%r14, %rdi
000000010000848d	movl	%r15d, %esi
0000000100008490	jmp	0x1000083b4
0000000100008495	movl	%esi, %r14d
0000000100008498	callq	_fwp_rc_wide_dup
000000010000849d	movl	%r14d, %esi
00000001000084a0	jmp	0x10000844b
00000001000084a2	callq	0x100009600                     ## symbol stub for: _abort
00000001000084a7	nopw	(%rax,%rax)
_fwp_arg_drop3:
00000001000084b0	pushq	%rbp
00000001000084b1	movq	%rsp, %rbp
00000001000084b4	pushq	%r15
00000001000084b6	pushq	%r14
00000001000084b8	pushq	%rbx
00000001000084b9	pushq	%rax
00000001000084ba	testl	%esi, %esi
00000001000084bc	setne	%al
00000001000084bf	testl	%edx, %edx
00000001000084c1	sete	%cl
00000001000084c4	orb	%al, %cl
00000001000084c6	je	0x1000084d6
00000001000084c8	cmpl	$0x1, %esi
00000001000084cb	jbe	0x10000858c
00000001000084d1	jmp	0x1000085ac
00000001000084d6	movq	(%rdi), %rax
00000001000084d9	movq	%rax, %r8
00000001000084dc	subq	0x3b55(%rip), %r8
00000001000084e3	movq	0x3b76(%rip), %rcx
00000001000084ea	shlq	$0x10, %rcx
00000001000084ee	cmpq	%rcx, %r8
00000001000084f1	jae	0x10000858c
00000001000084f7	movq	0x3b82(%rip), %r9
00000001000084fe	movq	%r8, %rcx
0000000100008501	shrq	$0x10, %rcx
0000000100008505	imulq	$0x1228, %rcx, %r10             ## imm = 0x1228
000000010000850c	leaq	(%r9,%r10), %rcx
0000000100008510	movzbl	(%r9,%r10), %r9d
0000000100008515	cmpb	$0x2, %r9b
0000000100008519	setne	%r10b
000000010000851d	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100008524	setne	%r11b
0000000100008528	orb	%r10b, %r11b
000000010000852b	jne	0x100008536
000000010000852d	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008534	jmp	0x100008552
0000000100008536	cmpb	$0x1, %r9b
000000010000853a	jne	0x10000858c
000000010000853c	movl	0x20(%rcx), %r9d
0000000100008540	imulq	%r9, %r8
0000000100008544	shrq	$0x20, %r8
0000000100008548	addq	%r8, %rcx
000000010000854b	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008552	movzbl	(%rcx), %r8d
0000000100008556	testl	%r8d, %r8d
0000000100008559	je	0x10000858c
000000010000855b	cmpl	$0x1, %r8d
000000010000855f	jne	0x10000857d
0000000100008561	movq	%rdi, %rbx
0000000100008564	movq	%rax, %rdi
0000000100008567	movl	%edx, %r14d
000000010000856a	movl	%esi, %r15d
000000010000856d	callq	_fwp_rc_free_obj
0000000100008572	movl	%r15d, %esi
0000000100008575	movl	%r14d, %edx
0000000100008578	movq	%rbx, %rdi
000000010000857b	jmp	0x10000858c
000000010000857d	cmpl	$0xff, %r8d
0000000100008584	je	0x1000085b7
0000000100008586	decb	%r8b
0000000100008589	movb	%r8b, (%rcx)
000000010000858c	movl	$0x1, %eax
0000000100008591	subl	%esi, %eax
0000000100008593	cmpl	%edx, %eax
0000000100008595	jae	0x1000085ac
0000000100008597	movl	%eax, %eax
0000000100008599	movq	(%rdi,%rax,8), %rdi
000000010000859d	addq	$0x8, %rsp
00000001000085a1	popq	%rbx
00000001000085a2	popq	%r14
00000001000085a4	popq	%r15
00000001000085a6	popq	%rbp
00000001000085a7	jmp	_fwp_closure_drop
00000001000085ac	addq	$0x8, %rsp
00000001000085b0	popq	%rbx
00000001000085b1	popq	%r14
00000001000085b3	popq	%r15
00000001000085b5	popq	%rbp
00000001000085b6	retq
00000001000085b7	movq	%rdi, %rbx
00000001000085ba	movq	%rcx, %rdi
00000001000085bd	movl	%edx, %r14d
00000001000085c0	movl	%esi, %r15d
00000001000085c3	callq	_fwp_rc_wide_drop
00000001000085c8	jmp	0x100008572
00000001000085ca	nopw	(%rax,%rax)
_fwp_entry_release3:
00000001000085d0	pushq	%rbp
00000001000085d1	movq	%rsp, %rbp
00000001000085d4	pushq	%rbx
00000001000085d5	pushq	%rax
00000001000085d6	movq	(%rdi), %rax
00000001000085d9	movq	(%rdi), %rax
00000001000085dc	movq	%rax, %rdx
00000001000085df	subq	0x3a52(%rip), %rdx
00000001000085e6	movq	0x3a73(%rip), %rcx
00000001000085ed	shlq	$0x10, %rcx
00000001000085f1	cmpq	%rcx, %rdx
00000001000085f4	jae	0x10000867c
00000001000085fa	movq	0x3a7f(%rip), %rsi
0000000100008601	movq	%rdx, %rcx
0000000100008604	shrq	$0x10, %rcx
0000000100008608	imulq	$0x1228, %rcx, %r8              ## imm = 0x1228
000000010000860f	leaq	(%rsi,%r8), %rcx
0000000100008613	movzbl	(%rsi,%r8), %esi
0000000100008618	cmpb	$0x2, %sil
000000010000861c	setne	%r8b
0000000100008620	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100008627	setne	%r9b
000000010000862b	orb	%r8b, %r9b
000000010000862e	jne	0x100008639
0000000100008630	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008637	jmp	0x100008654
0000000100008639	cmpb	$0x1, %sil
000000010000863d	jne	0x10000867c
000000010000863f	movl	0x20(%rcx), %esi
0000000100008642	imulq	%rsi, %rdx
0000000100008646	shrq	$0x20, %rdx
000000010000864a	addq	%rdx, %rcx
000000010000864d	addq	$0x228, %rcx                    ## imm = 0x228
0000000100008654	movzbl	(%rcx), %edx
0000000100008657	testl	%edx, %edx
0000000100008659	je	0x10000867c
000000010000865b	cmpl	$0x1, %edx
000000010000865e	jne	0x100008670
0000000100008660	movq	%rdi, %rbx
0000000100008663	movq	%rax, %rdi
0000000100008666	callq	_fwp_rc_free_obj
000000010000866b	movq	%rbx, %rdi
000000010000866e	jmp	0x10000867c
0000000100008670	cmpl	$0xff, %edx
0000000100008676	je	0x10000868f
0000000100008678	decb	%dl
000000010000867a	movb	%dl, (%rcx)
000000010000867c	movq	0x8(%rdi), %rax
0000000100008680	movq	0x8(%rdi), %rdi
0000000100008684	addq	$0x8, %rsp
0000000100008688	popq	%rbx
0000000100008689	popq	%rbp
000000010000868a	jmp	_fwp_closure_drop
000000010000868f	movq	%rdi, %rbx
0000000100008692	movq	%rcx, %rdi
0000000100008695	callq	_fwp_rc_wide_drop
000000010000869a	jmp	0x10000866b
000000010000869c	nopl	(%rax)
_f4:
00000001000086a0	pushq	%rbp
00000001000086a1	movq	%rsp, %rbp
00000001000086a4	pushq	%r15
00000001000086a6	pushq	%r14
00000001000086a8	pushq	%r13
00000001000086aa	pushq	%r12
00000001000086ac	pushq	%rbx
00000001000086ad	pushq	%rax
00000001000086ae	movl	$0x10088, %eax                  ## imm = 0x10088
00000001000086b3	callq	0x1000095b8                     ## symbol stub for: ____chkstk_darwin
00000001000086b8	subq	%rax, %rsp
00000001000086bb	popq	%rax
00000001000086bc	movq	%rdi, %rbx
00000001000086bf	movq	0x196a(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000086c6	movq	(%rax), %rax
00000001000086c9	movq	%rax, -0x30(%rbp)
00000001000086cd	callq	_fwp_file_dup
00000001000086d2	movq	%rbx, -0x100b0(%rbp)
00000001000086d9	leaq	_fwp_file_drop(%rip), %rax
00000001000086e0	movq	%rax, -0x100a8(%rbp)
00000001000086e7	movq	_fwp_cleanups(%rip), %rax
00000001000086ee	movq	%rax, -0x100a0(%rbp)
00000001000086f5	leaq	_fwp_value_release(%rip), %r12
00000001000086fc	movq	%r12, -0x10098(%rbp)
0000000100008703	leaq	-0x100b0(%rbp), %rax
000000010000870a	movq	%rax, -0x10090(%rbp)
0000000100008711	xorps	%xmm0, %xmm0
0000000100008714	movaps	%xmm0, -0x10060(%rbp)
000000010000871b	movq	$0x0, -0x10050(%rbp)
0000000100008726	leaq	-0x100a0(%rbp), %rax
000000010000872d	movq	%rax, -0x10088(%rbp)
0000000100008734	leaq	_fwp_file_buffer_cleanup(%rip), %rax
000000010000873b	movq	%rax, -0x10080(%rbp)
0000000100008742	leaq	-0x10060(%rbp), %rax
0000000100008749	movq	%rax, -0x10078(%rbp)
0000000100008750	leaq	-0x10088(%rbp), %r13
0000000100008757	movq	%r13, _fwp_cleanups(%rip)
000000010000875e	movq	(%rbx), %rcx
0000000100008761	testq	%rcx, %rcx
0000000100008764	je	0x10000895b
000000010000876a	leaq	-0x10040(%rbp), %rdi
0000000100008771	movl	$0x1, %esi
0000000100008776	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000877b	callq	0x100009648                     ## symbol stub for: _fread
0000000100008780	testq	%rax, %rax
0000000100008783	je	0x1000087c8
0000000100008785	leaq	-0x10060(%rbp), %r14
000000010000878c	leaq	-0x10040(%rbp), %r15
0000000100008793	nopw	%cs:(%rax,%rax)
00000001000087a0	movq	%r14, %rdi
00000001000087a3	movq	%r15, %rsi
00000001000087a6	movq	%rax, %rdx
00000001000087a9	callq	_buf_put
00000001000087ae	movq	(%rbx), %rcx
00000001000087b1	movl	$0x1, %esi
00000001000087b6	movl	$0x10000, %edx                  ## imm = 0x10000
00000001000087bb	movq	%r15, %rdi
00000001000087be	callq	0x100009648                     ## symbol stub for: _fread
00000001000087c3	testq	%rax, %rax
00000001000087c6	jne	0x1000087a0
00000001000087c8	movq	(%rbx), %rdi
00000001000087cb	callq	0x10000962a                     ## symbol stub for: _ferror
00000001000087d0	testl	%eax, %eax
00000001000087d2	jne	0x100008c46
00000001000087d8	movq	-0x10060(%rbp), %rax
00000001000087df	movq	-0x10058(%rbp), %rsi
00000001000087e6	testq	%rax, %rax
00000001000087e9	leaq	0x143c(%rip), %rdi              ## literal pool for: ""
00000001000087f0	cmovneq	%rax, %rdi
00000001000087f4	testq	%rsi, %rsi
00000001000087f7	je	0x100008962
00000001000087fd	xorl	%ecx, %ecx
00000001000087ff	jmp	0x10000881c
0000000100008801	nopw	%cs:(%rax,%rax)
0000000100008810	incq	%rcx
0000000100008813	cmpq	%rsi, %rcx
0000000100008816	jae	0x100008964
000000010000881c	movzbl	(%rdi,%rcx), %r10d
0000000100008821	testb	%r10b, %r10b
0000000100008824	jns	0x100008810
0000000100008826	leal	0x3e(%r10), %edx
000000010000882a	cmpb	$0x1e, %dl
000000010000882d	jae	0x100008842
000000010000882f	movl	$0x80, %edx
0000000100008834	movl	$0x1, %r9d
000000010000883a	movl	$0x1f, %r8d
0000000100008840	jmp	0x10000887e
0000000100008842	movl	%r10d, %edx
0000000100008845	andb	$-0x10, %dl
0000000100008848	cmpb	$-0x20, %dl
000000010000884b	jne	0x100008860
000000010000884d	movl	$0x800, %edx                    ## imm = 0x800
0000000100008852	movl	$0x2, %r9d
0000000100008858	movl	$0xf, %r8d
000000010000885e	jmp	0x10000887e
0000000100008860	leal	0x10(%r10), %edx
0000000100008864	cmpb	$0x4, %dl
0000000100008867	ja	0x100008ba8
000000010000886d	movl	$0x10000, %edx                  ## imm = 0x10000
0000000100008872	movl	$0x3, %r9d
0000000100008878	movl	$0x7, %r8d
000000010000887e	movl	%r9d, %r9d
0000000100008881	leaq	(%rcx,%r9), %r11
0000000100008885	cmpq	%rsi, %r11
0000000100008888	jae	0x100008ba8
000000010000888e	movzbl	0x1(%rdi,%rcx), %r11d
0000000100008894	movl	%r11d, %r14d
0000000100008897	andl	$-0x40, %r14d
000000010000889b	cmpl	$0x80, %r14d
00000001000088a2	jne	0x100008ba8
00000001000088a8	andl	%r10d, %r8d
00000001000088ab	leal	0x1(%r9), %r14d
00000001000088af	movl	%r8d, %r10d
00000001000088b2	shll	$0x6, %r10d
00000001000088b6	andl	$0x3f, %r11d
00000001000088ba	orl	%r10d, %r11d
00000001000088bd	cmpl	$0x2, %r14d
00000001000088c1	jne	0x1000088c8
00000001000088c3	movl	%r11d, %r14d
00000001000088c6	jmp	0x100008926
00000001000088c8	movzbl	0x2(%rdi,%rcx), %r8d
00000001000088ce	movl	%r8d, %r10d
00000001000088d1	andl	$-0x40, %r10d
00000001000088d5	cmpl	$0x80, %r10d
00000001000088dc	jne	0x100008ba8
00000001000088e2	movl	%r11d, %r10d
00000001000088e5	shll	$0x6, %r10d
00000001000088e9	andl	$0x3f, %r8d
00000001000088ed	orl	%r10d, %r8d
00000001000088f0	cmpl	$0x3, %r14d
00000001000088f4	jne	0x1000088fe
00000001000088f6	movl	%r8d, %r14d
00000001000088f9	movl	%r11d, %r8d
00000001000088fc	jmp	0x100008926
00000001000088fe	movzbl	0x3(%rdi,%rcx), %r14d
0000000100008904	movl	%r14d, %r10d
0000000100008907	andl	$-0x40, %r10d
000000010000890b	cmpl	$0x80, %r10d
0000000100008912	jne	0x100008ba8
0000000100008918	movl	%r8d, %r10d
000000010000891b	shll	$0x6, %r10d
000000010000891f	andl	$0x3f, %r14d
0000000100008923	orl	%r10d, %r14d
0000000100008926	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000892d	cmpl	$0x360, %r8d                    ## imm = 0x360
0000000100008934	je	0x100008ba8
000000010000893a	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
0000000100008941	ja	0x100008ba8
0000000100008947	cmpl	%edx, %r14d
000000010000894a	jb	0x100008ba8
0000000100008950	addq	%r9, %rcx
0000000100008953	incq	%rcx
0000000100008956	jmp	0x100008813
000000010000895b	leaq	0x12ca(%rip), %rdi              ## literal pool for: ""
0000000100008962	xorl	%esi, %esi
0000000100008964	callq	_fwp_str_new
0000000100008969	movq	%rax, %r14
000000010000896c	movq	-0x10060(%rbp), %rdi
0000000100008973	callq	0x10000964e                     ## symbol stub for: _free
0000000100008978	movq	%r14, %rax
000000010000897b	subq	0x36b6(%rip), %rax
0000000100008982	movq	0x36d7(%rip), %rcx
0000000100008989	shlq	$0x10, %rcx
000000010000898d	cmpq	%rcx, %rax
0000000100008990	jae	0x100008a02
0000000100008992	movq	0x36e7(%rip), %rcx
0000000100008999	movq	%rax, %rdx
000000010000899c	shrq	$0x10, %rdx
00000001000089a0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000089a7	leaq	(%rcx,%rdx), %r15
00000001000089ab	movzbl	(%rcx,%rdx), %ecx
00000001000089af	cmpb	$0x2, %cl
00000001000089b2	setne	%dl
00000001000089b5	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000089bb	setne	%sil
00000001000089bf	orb	%dl, %sil
00000001000089c2	jne	0x1000089d7
00000001000089c4	addq	$0x228, %r15                    ## imm = 0x228
00000001000089cb	cmpb	$-0x1, (%r15)
00000001000089cf	je	0x1000089f8
00000001000089d1	movb	$0x1, (%r15)
00000001000089d5	jmp	0x100008a02
00000001000089d7	cmpb	$0x1, %cl
00000001000089da	jne	0x100008a02
00000001000089dc	movl	0x20(%r15), %ecx
00000001000089e0	imulq	%rcx, %rax
00000001000089e4	shrq	$0x20, %rax
00000001000089e8	addq	%rax, %r15
00000001000089eb	addq	$0x228, %r15                    ## imm = 0x228
00000001000089f2	cmpb	$-0x1, (%r15)
00000001000089f6	jne	0x1000089d1
00000001000089f8	movq	%r15, %rdi
00000001000089fb	callq	_fwp_rc_forget_slot
0000000100008a00	jmp	0x1000089d1
0000000100008a02	movq	$0x0, -0x10060(%rbp)
0000000100008a0d	movq	%r14, -0x10070(%rbp)
0000000100008a14	leaq	_fwp_file_text_drop(%rip), %rax
0000000100008a1b	movq	%rax, -0x10068(%rbp)
0000000100008a22	movq	_fwp_cleanups(%rip), %rax
0000000100008a29	movq	%rax, -0x10040(%rbp)
0000000100008a30	movq	%r12, -0x10038(%rbp)
0000000100008a37	leaq	-0x10070(%rbp), %rax
0000000100008a3e	movq	%rax, -0x10030(%rbp)
0000000100008a45	leaq	-0x10040(%rbp), %r15
0000000100008a4c	movq	%r15, _fwp_cleanups(%rip)
0000000100008a53	movq	%r14, -0x40(%rbp)
0000000100008a57	movq	%rbx, -0x38(%rbp)
0000000100008a5b	movl	$0x18, %edi
0000000100008a60	callq	_fwp_alloc_init
0000000100008a65	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100008a6f	movq	%rcx, (%rax)
0000000100008a72	movq	%r14, 0x8(%rax)
0000000100008a76	movq	%rbx, 0x10(%rax)
0000000100008a7a	leaq	-0x40(%rbp), %rcx
0000000100008a7e	movq	%rax, %rcx
0000000100008a81	subq	0x35b0(%rip), %rcx
0000000100008a88	movq	0x35d1(%rip), %rdx
0000000100008a8f	shlq	$0x10, %rdx
0000000100008a93	cmpq	%rdx, %rcx
0000000100008a96	jae	0x100008b10
0000000100008a98	movq	0x35e1(%rip), %rdx
0000000100008a9f	movq	%rcx, %rsi
0000000100008aa2	shrq	$0x10, %rsi
0000000100008aa6	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100008aad	leaq	(%rdx,%rsi), %r14
0000000100008ab1	movzbl	(%rdx,%rsi), %edx
0000000100008ab5	cmpb	$0x2, %dl
0000000100008ab8	setne	%sil
0000000100008abc	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008ac3	setne	%dil
0000000100008ac7	orb	%sil, %dil
0000000100008aca	jne	0x100008adf
0000000100008acc	addq	$0x228, %r14                    ## imm = 0x228
0000000100008ad3	cmpb	$-0x1, (%r14)
0000000100008ad7	je	0x100008b00
0000000100008ad9	movb	$0x1, (%r14)
0000000100008add	jmp	0x100008b10
0000000100008adf	cmpb	$0x1, %dl
0000000100008ae2	jne	0x100008b10
0000000100008ae4	movl	0x20(%r14), %edx
0000000100008ae8	imulq	%rdx, %rcx
0000000100008aec	shrq	$0x20, %rcx
0000000100008af0	addq	%rcx, %r14
0000000100008af3	addq	$0x228, %r14                    ## imm = 0x228
0000000100008afa	cmpb	$-0x1, (%r14)
0000000100008afe	jne	0x100008ad9
0000000100008b00	movq	%r14, %rdi
0000000100008b03	movq	%rax, %r12
0000000100008b06	callq	_fwp_rc_forget_slot
0000000100008b0b	movq	%r12, %rax
0000000100008b0e	jmp	0x100008ad9
0000000100008b10	cmpq	$0x0, -0x10068(%rbp)
0000000100008b18	movq	_fwp_cleanups(%rip), %rcx
0000000100008b1f	je	0x100008b38
0000000100008b21	cmpq	%r15, %rcx
0000000100008b24	jne	0x100008ce3
0000000100008b2a	movq	-0x10040(%rbp), %rcx
0000000100008b31	movq	%rcx, _fwp_cleanups(%rip)
0000000100008b38	movq	$0x0, -0x10070(%rbp)
0000000100008b43	cmpq	%r13, %rcx
0000000100008b46	jne	0x100008ce3
0000000100008b4c	movq	-0x10088(%rbp), %rcx
0000000100008b53	movq	%rcx, _fwp_cleanups(%rip)
0000000100008b5a	cmpq	$0x0, -0x100a8(%rbp)
0000000100008b62	je	0x100008b82
0000000100008b64	leaq	-0x100a0(%rbp), %rdx
0000000100008b6b	cmpq	%rdx, %rcx
0000000100008b6e	jne	0x100008ce3
0000000100008b74	movq	-0x100a0(%rbp), %rcx
0000000100008b7b	movq	%rcx, _fwp_cleanups(%rip)
0000000100008b82	movq	0x14a7(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100008b89	movq	(%rcx), %rcx
0000000100008b8c	cmpq	-0x30(%rbp), %rcx
0000000100008b90	jne	0x100008c41
0000000100008b96	addq	$0x10088, %rsp                  ## imm = 0x10088
0000000100008b9d	popq	%rbx
0000000100008b9e	popq	%r12
0000000100008ba0	popq	%r13
0000000100008ba2	popq	%r14
0000000100008ba4	popq	%r15
0000000100008ba6	popq	%rbp
0000000100008ba7	retq
0000000100008ba8	cmpq	%r13, _fwp_cleanups(%rip)
0000000100008baf	jne	0x100008ce3
0000000100008bb5	movq	-0x10088(%rbp), %rcx
0000000100008bbc	movq	%rcx, _fwp_cleanups(%rip)
0000000100008bc3	movq	%rax, %rdi
0000000100008bc6	callq	0x10000964e                     ## symbol stub for: _free
0000000100008bcb	movq	$0x0, -0x10060(%rbp)
0000000100008bd6	leaq	0x104a(%rip), %rdi              ## literal pool for: "read"
0000000100008bdd	movl	$0x4, %esi
0000000100008be2	callq	_fwp_str_new
0000000100008be7	movq	%rax, %rbx
0000000100008bea	movq	%rax, -0x10040(%rbp)
0000000100008bf1	leaq	0x1035(%rip), %rdi              ## literal pool for: "stream did not contain valid UTF-8"
0000000100008bf8	movl	$0x22, %esi
0000000100008bfd	callq	_fwp_str_new
0000000100008c02	movq	%rax, %r14
0000000100008c05	movq	%rax, -0x10038(%rbp)
0000000100008c0c	movl	$0x18, %edi
0000000100008c11	callq	_fwp_alloc_init
0000000100008c16	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100008c20	movq	%rcx, (%rax)
0000000100008c23	movq	%rbx, 0x8(%rax)
0000000100008c27	movq	%r14, 0x10(%rax)
0000000100008c2b	leaq	-0x10040(%rbp), %rcx
0000000100008c32	leaq	_d0(%rip), %rsi
0000000100008c39	movq	%rax, %rdi
0000000100008c3c	callq	_fwp_fail
0000000100008c41	callq	0x1000095d6                     ## symbol stub for: ___stack_chk_fail
0000000100008c46	callq	0x1000095ca                     ## symbol stub for: ___error
0000000100008c4b	cmpq	%r13, _fwp_cleanups(%rip)
0000000100008c52	jne	0x100008ce3
0000000100008c58	movl	(%rax), %ebx
0000000100008c5a	movq	-0x10088(%rbp), %rax
0000000100008c61	movq	%rax, _fwp_cleanups(%rip)
0000000100008c68	movq	-0x10060(%rbp), %rdi
0000000100008c6f	callq	0x10000964e                     ## symbol stub for: _free
0000000100008c74	movq	$0x0, -0x10060(%rbp)
0000000100008c7f	movl	%ebx, %edi
0000000100008c81	callq	0x1000096ea                     ## symbol stub for: _strerror
0000000100008c86	movq	%rax, %rbx
0000000100008c89	leaq	0xf97(%rip), %rdi               ## literal pool for: "read"
0000000100008c90	movl	$0x4, %esi
0000000100008c95	callq	_fwp_str_new
0000000100008c9a	movq	%rax, %r14
0000000100008c9d	movq	%rax, -0x40(%rbp)
0000000100008ca1	movq	%rbx, %rdi
0000000100008ca4	callq	0x1000096f0                     ## symbol stub for: _strlen
0000000100008ca9	movq	%rbx, %rdi
0000000100008cac	movq	%rax, %rsi
0000000100008caf	callq	_fwp_str_new
0000000100008cb4	movq	%rax, %rbx
0000000100008cb7	movq	%rax, -0x38(%rbp)
0000000100008cbb	movl	$0x18, %edi
0000000100008cc0	callq	_fwp_alloc_init
0000000100008cc5	movabsq	$0x200000000, %rcx              ## imm = 0x200000000
0000000100008ccf	movq	%rcx, (%rax)
0000000100008cd2	movq	%r14, 0x8(%rax)
0000000100008cd6	movq	%rbx, 0x10(%rax)
0000000100008cda	leaq	-0x40(%rbp), %rcx
0000000100008cde	jmp	0x100008c32
0000000100008ce3	callq	0x100009600                     ## symbol stub for: _abort
0000000100008ce8	nopl	(%rax,%rax)
_fwp_file_dup:
0000000100008cf0	pushq	%rbp
0000000100008cf1	movq	%rsp, %rbp
0000000100008cf4	testq	%rdi, %rdi
0000000100008cf7	je	0x100008d0f
0000000100008cf9	movq	0x8(%rdi), %rax
0000000100008cfd	cmpq	$-0x1, %rax
0000000100008d01	je	0x100008d11
0000000100008d03	testq	%rax, %rax
0000000100008d06	je	0x100008d30
0000000100008d08	incq	%rax
0000000100008d0b	movq	%rax, 0x8(%rdi)
0000000100008d0f	popq	%rbp
0000000100008d10	retq
0000000100008d11	callq	_fwp_flush
0000000100008d16	movq	0x131b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008d1d	movq	(%rax), %rdi
0000000100008d20	leaq	0xc0d(%rip), %rsi               ## literal pool for: "fwp: trap: %s\n"
0000000100008d27	leaq	0xdc4(%rip), %rdx               ## literal pool for: "reference count overflow"
0000000100008d2e	jmp	0x100008d4d
0000000100008d30	callq	_fwp_flush
0000000100008d35	movq	0x12fc(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008d3c	movq	(%rax), %rdi
0000000100008d3f	leaq	0xbee(%rip), %rsi               ## literal pool for: "fwp: trap: %s\n"
0000000100008d46	leaq	0xeb7(%rip), %rdx               ## literal pool for: "internal: duplicate discarded file"
0000000100008d4d	xorl	%eax, %eax
0000000100008d4f	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100008d54	movl	$0x65, %edi
0000000100008d59	callq	0x10000961e                     ## symbol stub for: _exit
0000000100008d5e	nop
_fwp_file_buffer_cleanup:
0000000100008d60	pushq	%rbp
0000000100008d61	movq	%rsp, %rbp
0000000100008d64	pushq	%rbx
0000000100008d65	pushq	%rax
0000000100008d66	movq	%rdi, %rbx
0000000100008d69	movq	(%rdi), %rdi
0000000100008d6c	callq	0x10000964e                     ## symbol stub for: _free
0000000100008d71	movq	$0x0, (%rbx)
0000000100008d78	addq	$0x8, %rsp
0000000100008d7c	popq	%rbx
0000000100008d7d	popq	%rbp
0000000100008d7e	retq
0000000100008d7f	nop
_fwp_file_text_drop:
0000000100008d80	pushq	%rbp
0000000100008d81	movq	%rsp, %rbp
0000000100008d84	popq	%rbp
0000000100008d85	jmp	_fwp_rc_free_obj
0000000100008d8a	nopw	(%rax,%rax)
_fwp_owned_entry4:
0000000100008d90	pushq	%rbp
0000000100008d91	movq	%rsp, %rbp
0000000100008d94	pushq	%r15
0000000100008d96	pushq	%r14
0000000100008d98	pushq	%rbx
0000000100008d99	subq	$0x18, %rsp
0000000100008d9d	movq	%rdi, %rbx
0000000100008da0	movq	_fwp_cleanups(%rip), %rax
0000000100008da7	movq	%rax, -0x30(%rbp)
0000000100008dab	leaq	_fwp_entry_release4(%rip), %rax
0000000100008db2	movq	%rax, -0x28(%rbp)
0000000100008db6	movq	%rdi, -0x20(%rbp)
0000000100008dba	leaq	-0x30(%rbp), %r15
0000000100008dbe	movq	%r15, _fwp_cleanups(%rip)
0000000100008dc5	movq	(%rdi), %rdi
0000000100008dc8	callq	_f4
0000000100008dcd	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008dd4	jne	0x100008dfd
0000000100008dd6	movq	%rax, %r14
0000000100008dd9	movq	-0x30(%rbp), %rax
0000000100008ddd	movq	%rax, _fwp_cleanups(%rip)
0000000100008de4	movq	(%rbx), %rax
0000000100008de7	movq	(%rbx), %rdi
0000000100008dea	callq	_fwp_file_drop
0000000100008def	movq	%r14, %rax
0000000100008df2	addq	$0x18, %rsp
0000000100008df6	popq	%rbx
0000000100008df7	popq	%r14
0000000100008df9	popq	%r15
0000000100008dfb	popq	%rbp
0000000100008dfc	retq
0000000100008dfd	callq	0x100009600                     ## symbol stub for: _abort
0000000100008e02	nopw	%cs:(%rax,%rax)
_fwp_caps4:
0000000100008e10	movl	0x4(%rdi), %eax
0000000100008e13	testl	%esi, %esi
0000000100008e15	je	0x100008e24
0000000100008e17	testl	%eax, %eax
0000000100008e19	je	0x100008e4f
0000000100008e1b	movq	0x8(%rdi), %rdi
0000000100008e1f	jmp	_fwp_file_dup
0000000100008e24	testl	%eax, %eax
0000000100008e26	je	_fwp_rc_free_obj
0000000100008e2c	pushq	%rbp
0000000100008e2d	movq	%rsp, %rbp
0000000100008e30	pushq	%rbx
0000000100008e31	pushq	%rax
0000000100008e32	movq	0x8(%rdi), %rax
0000000100008e36	movq	%rdi, %rbx
0000000100008e39	movq	%rax, %rdi
0000000100008e3c	callq	_fwp_file_drop
0000000100008e41	movq	%rbx, %rdi
0000000100008e44	addq	$0x8, %rsp
0000000100008e48	popq	%rbx
0000000100008e49	popq	%rbp
0000000100008e4a	jmp	_fwp_rc_free_obj
0000000100008e4f	retq
_fwp_args4:
0000000100008e50	pushq	%rbp
0000000100008e51	movq	%rsp, %rbp
0000000100008e54	testl	%esi, %esi
0000000100008e56	setne	%al
0000000100008e59	testl	%edx, %edx
0000000100008e5b	sete	%cl
0000000100008e5e	orb	%al, %cl
0000000100008e60	je	0x100008e64
0000000100008e62	popq	%rbp
0000000100008e63	retq
0000000100008e64	movq	(%rdi), %rdi
0000000100008e67	popq	%rbp
0000000100008e68	jmp	_fwp_file_dup
0000000100008e6d	nopl	(%rax)
_fwp_arg_drop4:
0000000100008e70	pushq	%rbp
0000000100008e71	movq	%rsp, %rbp
0000000100008e74	testl	%esi, %esi
0000000100008e76	setne	%al
0000000100008e79	testl	%edx, %edx
0000000100008e7b	sete	%cl
0000000100008e7e	orb	%al, %cl
0000000100008e80	je	0x100008e84
0000000100008e82	popq	%rbp
0000000100008e83	retq
0000000100008e84	movq	(%rdi), %rdi
0000000100008e87	popq	%rbp
0000000100008e88	jmp	_fwp_file_drop
0000000100008e8d	nopl	(%rax)
_fwp_entry_release4:
0000000100008e90	pushq	%rbp
0000000100008e91	movq	%rsp, %rbp
0000000100008e94	movq	(%rdi), %rax
0000000100008e97	movq	(%rdi), %rdi
0000000100008e9a	popq	%rbp
0000000100008e9b	jmp	_fwp_file_drop
_f8:
0000000100008ea0	pushq	%rbp
0000000100008ea1	movq	%rsp, %rbp
0000000100008ea4	pushq	%r14
0000000100008ea6	pushq	%rbx
0000000100008ea7	subq	$0x20, %rsp
0000000100008eab	movq	%rdi, %rsi
0000000100008eae	xorps	%xmm0, %xmm0
0000000100008eb1	movaps	%xmm0, -0x30(%rbp)
0000000100008eb5	movq	$0x0, -0x20(%rbp)
0000000100008ebd	leaq	_d2(%rip), %rdx
0000000100008ec4	leaq	-0x30(%rbp), %rdi
0000000100008ec8	movl	$0x1, %ecx
0000000100008ecd	callq	_fwp_write
0000000100008ed2	movq	-0x30(%rbp), %rax
0000000100008ed6	movq	-0x28(%rbp), %rsi
0000000100008eda	testq	%rax, %rax
0000000100008edd	leaq	0xd48(%rip), %rdi               ## literal pool for: ""
0000000100008ee4	cmovneq	%rax, %rdi
0000000100008ee8	callq	_fwp_str_new
0000000100008eed	movq	%rax, %rbx
0000000100008ef0	movq	-0x30(%rbp), %rdi
0000000100008ef4	callq	0x10000964e                     ## symbol stub for: _free
0000000100008ef9	movq	%rbx, %rax
0000000100008efc	movq	%rbx, %rcx
0000000100008eff	subq	0x3132(%rip), %rcx
0000000100008f06	movq	0x3153(%rip), %rdx
0000000100008f0d	shlq	$0x10, %rdx
0000000100008f11	cmpq	%rdx, %rcx
0000000100008f14	jae	0x100008f8a
0000000100008f16	movq	0x3163(%rip), %rdx
0000000100008f1d	movq	%rcx, %rsi
0000000100008f20	shrq	$0x10, %rsi
0000000100008f24	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100008f2b	leaq	(%rdx,%rsi), %rbx
0000000100008f2f	movzbl	(%rdx,%rsi), %edx
0000000100008f33	cmpb	$0x2, %dl
0000000100008f36	setne	%sil
0000000100008f3a	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008f41	setne	%dil
0000000100008f45	orb	%sil, %dil
0000000100008f48	jne	0x100008f5b
0000000100008f4a	addq	$0x228, %rbx                    ## imm = 0x228
0000000100008f51	cmpb	$-0x1, (%rbx)
0000000100008f54	je	0x100008f7a
0000000100008f56	movb	$0x1, (%rbx)
0000000100008f59	jmp	0x100008f8a
0000000100008f5b	cmpb	$0x1, %dl
0000000100008f5e	jne	0x100008f8a
0000000100008f60	movl	0x20(%rbx), %edx
0000000100008f63	imulq	%rdx, %rcx
0000000100008f67	shrq	$0x20, %rcx
0000000100008f6b	addq	%rcx, %rbx
0000000100008f6e	addq	$0x228, %rbx                    ## imm = 0x228
0000000100008f75	cmpb	$-0x1, (%rbx)
0000000100008f78	jne	0x100008f56
0000000100008f7a	movq	%rbx, %rdi
0000000100008f7d	movq	%rax, %r14
0000000100008f80	callq	_fwp_rc_forget_slot
0000000100008f85	movq	%r14, %rax
0000000100008f88	jmp	0x100008f56
0000000100008f8a	addq	$0x20, %rsp
0000000100008f8e	popq	%rbx
0000000100008f8f	popq	%r14
0000000100008f91	popq	%rbp
0000000100008f92	retq
0000000100008f93	nopw	%cs:(%rax,%rax)
_fwp_gc_report:
0000000100008fa0	pushq	%rbp
0000000100008fa1	movq	%rsp, %rbp
0000000100008fa4	pushq	%r15
0000000100008fa6	pushq	%r14
0000000100008fa8	pushq	%r13
0000000100008faa	pushq	%r12
0000000100008fac	pushq	%rbx
0000000100008fad	subq	$0xb8, %rsp
0000000100008fb4	movq	0x325d(%rip), %rax
0000000100008fbb	movq	_fwp_gc(%rip), %rcx
0000000100008fc2	subq	%rcx, %rax
0000000100008fc5	cvtsi2sd	%rax, %xmm0
0000000100008fca	addsd	0x321e(%rip), %xmm0
0000000100008fd2	movsd	%xmm0, -0x50(%rbp)
0000000100008fd7	movsd	%xmm0, 0x3211(%rip)
0000000100008fdf	movq	%rcx, 0x3232(%rip)
0000000100008fe6	movq	0x104b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008fed	movq	(%rax), %r15
0000000100008ff0	movq	0x31e9(%rip), %rax
0000000100008ff7	movq	%rax, -0x30(%rbp)
0000000100008ffb	movq	0x301e(%rip), %r14
0000000100009002	movsd	0x3206(%rip), %xmm0
000000010000900a	movsd	%xmm0, -0x38(%rbp)
000000010000900f	movq	0x303a(%rip), %r12
0000000100009016	movq	0x31b3(%rip), %r13
000000010000901d	movq	0x31b4(%rip), %rbx
0000000100009024	movsd	0x31cc(%rip), %xmm0
000000010000902c	movsd	%xmm0, -0x48(%rbp)
0000000100009031	movsd	0x31c7(%rip), %xmm0
0000000100009039	movsd	%xmm0, -0x40(%rbp)
000000010000903e	leaq	-0xe0(%rbp), %rsi
0000000100009045	xorl	%edi, %edi
0000000100009047	callq	0x100009666                     ## symbol stub for: _getrusage
000000010000904c	movq	$-0x1, %r8
0000000100009053	testl	%eax, %eax
0000000100009055	jne	0x100009070
0000000100009057	movq	-0xc0(%rbp), %rax
000000010000905e	leaq	0x3ff(%rax), %r8
0000000100009065	testq	%rax, %rax
0000000100009068	cmovnsq	%rax, %r8
000000010000906c	sarq	$0xa, %r8
0000000100009070	movq	%rbx, %xmm0
0000000100009075	movq	0x773(%rip), %xmm1
000000010000907d	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100009081	movapd	0x777(%rip), %xmm2
0000000100009089	subpd	%xmm2, %xmm0
000000010000908d	movapd	%xmm0, %xmm4
0000000100009091	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100009095	addsd	%xmm0, %xmm4
0000000100009099	movsd	0x77f(%rip), %xmm6
00000001000090a1	mulsd	%xmm6, %xmm4
00000001000090a5	movq	%r13, %xmm5
00000001000090aa	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
00000001000090ae	subpd	%xmm2, %xmm5
00000001000090b2	movapd	%xmm5, %xmm3
00000001000090b6	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
00000001000090ba	addsd	%xmm5, %xmm3
00000001000090be	mulsd	%xmm6, %xmm3
00000001000090c2	movq	%r12, %xmm5
00000001000090c7	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
00000001000090cb	subpd	%xmm2, %xmm5
00000001000090cf	movapd	%xmm5, %xmm2
00000001000090d3	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
00000001000090d7	addsd	%xmm5, %xmm2
00000001000090db	mulsd	%xmm6, %xmm2
00000001000090df	movsd	-0x50(%rbp), %xmm0
00000001000090e4	movsd	-0x38(%rbp), %xmm1
00000001000090e9	addsd	%xmm1, %xmm0
00000001000090ed	mulsd	%xmm6, %xmm1
00000001000090f1	mulsd	%xmm6, %xmm0
00000001000090f5	cmpl	$0x0, 0x2f00(%rip)
00000001000090fc	leaq	0xc60(%rip), %rax               ## literal pool for: " (collection off)"
0000000100009103	leaq	0xb22(%rip), %r9                ## literal pool for: ""
000000010000910a	cmoveq	%rax, %r9
000000010000910e	leaq	0xb9f(%rip), %rsi               ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100009115	movq	%r15, %rdi
0000000100009118	movq	-0x30(%rbp), %rdx
000000010000911c	movq	%r14, %rcx
000000010000911f	movsd	-0x48(%rbp), %xmm5
0000000100009124	movsd	-0x40(%rbp), %xmm6
0000000100009129	movb	$0x7, %al
000000010000912b	callq	0x10000963c                     ## symbol stub for: _fprintf
0000000100009130	addq	$0xb8, %rsp
0000000100009137	popq	%rbx
0000000100009138	popq	%r12
000000010000913a	popq	%r13
000000010000913c	popq	%r14
000000010000913e	popq	%r15
0000000100009140	popq	%rbp
0000000100009141	retq
0000000100009142	nopw	%cs:(%rax,%rax)
_fwp_segv:
0000000100009150	movq	_fwp_main_stack_top(%rip), %rax
0000000100009157	testq	%rax, %rax
000000010000915a	je	0x100009184
000000010000915c	movq	0x18(%rsi), %rcx
0000000100009160	subq	_fwp_main_stack_size(%rip), %rax
0000000100009167	leaq	-0x100000(%rax), %rdx
000000010000916e	addq	$0x100000, %rax                 ## imm = 0x100000
0000000100009174	cmpq	%rcx, %rdx
0000000100009177	setbe	%dl
000000010000917a	cmpq	%rcx, %rax
000000010000917d	seta	%al
0000000100009180	testb	%al, %dl
0000000100009182	jne	0x10000918b
0000000100009184	xorl	%esi, %esi
0000000100009186	jmp	0x1000096cc                     ## symbol stub for: _signal
000000010000918b	pushq	%rbp
000000010000918c	movq	%rsp, %rbp
000000010000918f	callq	_fwp_flush
0000000100009194	leaq	_fwp_segv.msg(%rip), %rsi
000000010000919b	movl	$0x1a, %edx
00000001000091a0	movl	$0x2, %edi
00000001000091a5	callq	0x100009714                     ## symbol stub for: _write
00000001000091aa	movl	$0x65, %edi
00000001000091af	callq	0x1000095fa                     ## symbol stub for: __exit
00000001000091b4	nopw	%cs:(%rax,%rax)
_fwp_owner_release0:
00000001000091c0	pushq	%rbp
00000001000091c1	movq	%rsp, %rbp
00000001000091c4	pushq	%rbx
00000001000091c5	pushq	%rax
00000001000091c6	movq	%rdi, %rbx
00000001000091c9	movq	(%rdi), %rdi
00000001000091cc	callq	_fwp_closure_drop
00000001000091d1	movq	0x8(%rbx), %rdi
00000001000091d5	addq	$0x8, %rsp
00000001000091d9	popq	%rbx
00000001000091da	popq	%rbp
00000001000091db	jmp	_fwp_closure_drop
_fwp_owner_release1:
00000001000091e0	pushq	%rbp
00000001000091e1	movq	%rsp, %rbp
00000001000091e4	movq	(%rdi), %rdi
00000001000091e7	popq	%rbp
00000001000091e8	jmp	_fwp_drop2
00000001000091ed	nopl	(%rax)
_fwp_drop2:
00000001000091f0	pushq	%rbp
00000001000091f1	movq	%rsp, %rbp
00000001000091f4	pushq	%rbx
00000001000091f5	pushq	%rax
00000001000091f6	movq	0x2e3b(%rip), %rcx
00000001000091fd	movq	%rdi, %r8
0000000100009200	subq	%rcx, %r8
0000000100009203	movq	0x2e56(%rip), %rsi
000000010000920a	shlq	$0x10, %rsi
000000010000920e	cmpq	%rsi, %r8
0000000100009211	jae	0x1000092e2
0000000100009217	movq	0x2e62(%rip), %rdx
000000010000921e	movq	%r8, %rax
0000000100009221	shrq	$0x10, %rax
0000000100009225	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
000000010000922c	leaq	(%rdx,%r9), %rax
0000000100009230	movzbl	(%rdx,%r9), %r9d
0000000100009235	cmpb	$0x2, %r9b
0000000100009239	setne	%r10b
000000010000923d	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100009244	setne	%r11b
0000000100009248	orb	%r10b, %r11b
000000010000924b	jne	0x100009255
000000010000924d	addq	$0x228, %rax                    ## imm = 0x228
0000000100009253	jmp	0x100009274
0000000100009255	cmpb	$0x1, %r9b
0000000100009259	jne	0x1000092e2
000000010000925f	movl	0x20(%rax), %r9d
0000000100009263	imulq	%r9, %r8
0000000100009267	shrq	$0x20, %r8
000000010000926b	addq	%r8, %rax
000000010000926e	addq	$0x228, %rax                    ## imm = 0x228
0000000100009274	movzbl	(%rax), %r8d
0000000100009278	testl	%r8d, %r8d
000000010000927b	je	0x1000092e2
000000010000927d	cmpl	$0x1, %r8d
0000000100009281	jne	0x1000092d3
0000000100009283	movl	(%rdi), %eax
0000000100009285	cmpl	$0x1, %eax
0000000100009288	je	0x1000092e9
000000010000928a	testl	%eax, %eax
000000010000928c	jne	0x1000092e2
000000010000928e	movq	0x8(%rdi), %rax
0000000100009292	movq	%rax, %r8
0000000100009295	subq	%rcx, %r8
0000000100009298	cmpq	%rsi, %r8
000000010000929b	jae	0x1000092fb
000000010000929d	movq	%r8, %rcx
00000001000092a0	shrq	$0x10, %rcx
00000001000092a4	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
00000001000092ab	leaq	(%rdx,%rsi), %rcx
00000001000092af	movzbl	(%rdx,%rsi), %edx
00000001000092b3	cmpb	$0x2, %dl
00000001000092b6	setne	%sil
00000001000092ba	andq	$0xffff, %r8                    ## imm = 0xFFFF
00000001000092c1	setne	%r9b
00000001000092c5	orb	%sil, %r9b
00000001000092c8	jne	0x100009306
00000001000092ca	addq	$0x228, %rcx                    ## imm = 0x228
00000001000092d1	jmp	0x100009320
00000001000092d3	cmpl	$0xff, %r8d
00000001000092da	je	0x100009347
00000001000092dc	decb	%r8b
00000001000092df	movb	%r8b, (%rax)
00000001000092e2	addq	$0x8, %rsp
00000001000092e6	popq	%rbx
00000001000092e7	popq	%rbp
00000001000092e8	retq
00000001000092e9	movq	0x8(%rdi), %rax
00000001000092ed	movq	%rdi, %rbx
00000001000092f0	movq	%rax, %rdi
00000001000092f3	callq	_fwp_drop4
00000001000092f8	movq	%rbx, %rdi
00000001000092fb	addq	$0x8, %rsp
00000001000092ff	popq	%rbx
0000000100009300	popq	%rbp
0000000100009301	jmp	_fwp_rc_free_obj
0000000100009306	cmpb	$0x1, %dl
0000000100009309	jne	0x1000092fb
000000010000930b	movl	0x20(%rcx), %edx
000000010000930e	imulq	%rdx, %r8
0000000100009312	shrq	$0x20, %r8
0000000100009316	addq	%r8, %rcx
0000000100009319	addq	$0x228, %rcx                    ## imm = 0x228
0000000100009320	movzbl	(%rcx), %edx
0000000100009323	testl	%edx, %edx
0000000100009325	je	0x1000092fb
0000000100009327	cmpl	$0x1, %edx
000000010000932a	jne	0x100009339
000000010000932c	movq	%rdi, %rbx
000000010000932f	movq	%rax, %rdi
0000000100009332	callq	_fwp_rc_free_obj
0000000100009337	jmp	0x1000092f8
0000000100009339	cmpl	$0xff, %edx
000000010000933f	je	0x100009355
0000000100009341	decb	%dl
0000000100009343	movb	%dl, (%rcx)
0000000100009345	jmp	0x1000092fb
0000000100009347	movq	%rax, %rdi
000000010000934a	addq	$0x8, %rsp
000000010000934e	popq	%rbx
000000010000934f	popq	%rbp
0000000100009350	jmp	_fwp_rc_wide_drop
0000000100009355	movq	%rdi, %rbx
0000000100009358	movq	%rcx, %rdi
000000010000935b	callq	_fwp_rc_wide_drop
0000000100009360	jmp	0x1000092f8
0000000100009362	nopw	%cs:(%rax,%rax)
_fwp_owner_release2:
0000000100009370	pushq	%rbp
0000000100009371	movq	%rsp, %rbp
0000000100009374	movq	(%rdi), %rdi
0000000100009377	movq	%rdi, %rcx
000000010000937a	subq	0x2cb7(%rip), %rcx
0000000100009381	movq	0x2cd8(%rip), %rax
0000000100009388	shlq	$0x10, %rax
000000010000938c	cmpq	%rax, %rcx
000000010000938f	jae	0x100009404
0000000100009391	movq	0x2ce8(%rip), %rdx
0000000100009398	movq	%rcx, %rax
000000010000939b	shrq	$0x10, %rax
000000010000939f	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000093a6	leaq	(%rdx,%rsi), %rax
00000001000093aa	movzbl	(%rdx,%rsi), %edx
00000001000093ae	cmpb	$0x2, %dl
00000001000093b1	setne	%sil
00000001000093b5	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000093bc	setne	%r8b
00000001000093c0	orb	%sil, %r8b
00000001000093c3	jne	0x1000093cd
00000001000093c5	addq	$0x228, %rax                    ## imm = 0x228
00000001000093cb	jmp	0x1000093e6
00000001000093cd	cmpb	$0x1, %dl
00000001000093d0	jne	0x100009404
00000001000093d2	movl	0x20(%rax), %edx
00000001000093d5	imulq	%rdx, %rcx
00000001000093d9	shrq	$0x20, %rcx
00000001000093dd	addq	%rcx, %rax
00000001000093e0	addq	$0x228, %rax                    ## imm = 0x228
00000001000093e6	movzbl	(%rax), %ecx
00000001000093e9	testl	%ecx, %ecx
00000001000093eb	je	0x100009404
00000001000093ed	cmpl	$0x1, %ecx
00000001000093f0	jne	0x1000093f8
00000001000093f2	popq	%rbp
00000001000093f3	jmp	_fwp_rc_free_obj
00000001000093f8	cmpl	$0xff, %ecx
00000001000093fe	je	0x100009406
0000000100009400	decb	%cl
0000000100009402	movb	%cl, (%rax)
0000000100009404	popq	%rbp
0000000100009405	retq
0000000100009406	movq	%rax, %rdi
0000000100009409	popq	%rbp
000000010000940a	jmp	_fwp_rc_wide_drop
000000010000940f	nop
_fwp_owner_release3:
0000000100009410	pushq	%rbp
0000000100009411	movq	%rsp, %rbp
0000000100009414	pushq	%rbx
0000000100009415	pushq	%rax
0000000100009416	movq	%rdi, %rbx
0000000100009419	movq	(%rdi), %rdi
000000010000941c	callq	_fwp_closure_drop
0000000100009421	movq	0x8(%rbx), %rdi
0000000100009425	addq	$0x8, %rsp
0000000100009429	popq	%rbx
000000010000942a	popq	%rbp
000000010000942b	jmp	_fwp_closure_drop
_fwp_owner_release4:
0000000100009430	pushq	%rbp
0000000100009431	movq	%rsp, %rbp
0000000100009434	movq	(%rdi), %rdi
0000000100009437	popq	%rbp
0000000100009438	jmp	_fwp_drop2
000000010000943d	nopl	(%rax)
_fwp_owner_release5:
0000000100009440	pushq	%rbp
0000000100009441	movq	%rsp, %rbp
0000000100009444	movq	(%rdi), %rdi
0000000100009447	movq	%rdi, %rcx
000000010000944a	subq	0x2be7(%rip), %rcx
0000000100009451	movq	0x2c08(%rip), %rax
0000000100009458	shlq	$0x10, %rax
000000010000945c	cmpq	%rax, %rcx
000000010000945f	jae	0x1000094d4
0000000100009461	movq	0x2c18(%rip), %rdx
0000000100009468	movq	%rcx, %rax
000000010000946b	shrq	$0x10, %rax
000000010000946f	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009476	leaq	(%rdx,%rsi), %rax
000000010000947a	movzbl	(%rdx,%rsi), %edx
000000010000947e	cmpb	$0x2, %dl
0000000100009481	setne	%sil
0000000100009485	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000948c	setne	%r8b
0000000100009490	orb	%sil, %r8b
0000000100009493	jne	0x10000949d
0000000100009495	addq	$0x228, %rax                    ## imm = 0x228
000000010000949b	jmp	0x1000094b6
000000010000949d	cmpb	$0x1, %dl
00000001000094a0	jne	0x1000094d4
00000001000094a2	movl	0x20(%rax), %edx
00000001000094a5	imulq	%rdx, %rcx
00000001000094a9	shrq	$0x20, %rcx
00000001000094ad	addq	%rcx, %rax
00000001000094b0	addq	$0x228, %rax                    ## imm = 0x228
00000001000094b6	movzbl	(%rax), %ecx
00000001000094b9	testl	%ecx, %ecx
00000001000094bb	je	0x1000094d4
00000001000094bd	cmpl	$0x1, %ecx
00000001000094c0	jne	0x1000094c8
00000001000094c2	popq	%rbp
00000001000094c3	jmp	_fwp_rc_free_obj
00000001000094c8	cmpl	$0xff, %ecx
00000001000094ce	je	0x1000094d6
00000001000094d0	decb	%cl
00000001000094d2	movb	%cl, (%rax)
00000001000094d4	popq	%rbp
00000001000094d5	retq
00000001000094d6	movq	%rax, %rdi
00000001000094d9	popq	%rbp
00000001000094da	jmp	_fwp_rc_wide_drop
00000001000094df	nop
_fwp_owner_release6:
00000001000094e0	pushq	%rbp
00000001000094e1	movq	%rsp, %rbp
00000001000094e4	movq	(%rdi), %rax
00000001000094e7	subq	0x2b4a(%rip), %rax
00000001000094ee	movq	0x2b6b(%rip), %rcx
00000001000094f5	shlq	$0x10, %rcx
00000001000094f9	cmpq	%rcx, %rax
00000001000094fc	jae	0x100009562
00000001000094fe	movq	0x2b7b(%rip), %rcx
0000000100009505	movq	%rax, %rdx
0000000100009508	shrq	$0x10, %rdx
000000010000950c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009513	leaq	(%rcx,%rdx), %rdi
0000000100009517	movzbl	(%rcx,%rdx), %ecx
000000010000951b	cmpb	$0x2, %cl
000000010000951e	setne	%dl
0000000100009521	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009527	setne	%sil
000000010000952b	orb	%dl, %sil
000000010000952e	jne	0x100009539
0000000100009530	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009537	jmp	0x100009553
0000000100009539	cmpb	$0x1, %cl
000000010000953c	jne	0x100009562
000000010000953e	movl	0x20(%rdi), %ecx
0000000100009541	imulq	%rcx, %rax
0000000100009545	shrq	$0x20, %rax
0000000100009549	addq	%rax, %rdi
000000010000954c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009553	movzbl	(%rdi), %eax
0000000100009556	cmpb	$0x2, %al
0000000100009558	jb	0x100009562
000000010000955a	cmpb	$-0x1, %al
000000010000955c	je	0x100009564
000000010000955e	decb	%al
0000000100009560	movb	%al, (%rdi)
0000000100009562	popq	%rbp
0000000100009563	retq
0000000100009564	popq	%rbp
0000000100009565	jmp	_fwp_rc_wide_drop
000000010000956a	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
0000000100009570	pushq	%rbp
0000000100009571	movq	%rsp, %rbp
0000000100009574	pushq	%rbx
0000000100009575	pushq	%rax
0000000100009576	movq	%rdi, %rbx
0000000100009579	leaq	0x462(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100009580	callq	0x10000965a                     ## symbol stub for: _getenv
0000000100009585	testq	%rax, %rax
0000000100009588	je	0x1000095a1
000000010000958a	movzbl	(%rax), %ecx
000000010000958d	testl	%ecx, %ecx
000000010000958f	je	0x1000095a8
0000000100009591	cmpl	$0x30, %ecx
0000000100009594	jne	0x1000095a5
0000000100009596	xorl	%ecx, %ecx
0000000100009598	cmpb	$0x0, 0x1(%rax)
000000010000959c	setne	%cl
000000010000959f	jmp	0x1000095a8
00000001000095a1	xorl	%ecx, %ecx
00000001000095a3	jmp	0x1000095a8
00000001000095a5	pushq	$0x1
00000001000095a7	popq	%rcx
00000001000095a8	movl	%ecx, (%rbx)
00000001000095aa	movl	%ecx, _fwp_reuse_verify(%rip)
00000001000095b0	addq	$0x8, %rsp
00000001000095b4	popq	%rbx
00000001000095b5	popq	%rbp
00000001000095b6	retq
