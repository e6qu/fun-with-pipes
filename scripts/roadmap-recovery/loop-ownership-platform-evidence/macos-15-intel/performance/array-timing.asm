array-fusion-evidence/performance/fwp-array-timing:
(__TEXT,__text) section
_fwp_ctx_swap:
00000001000006a0	pushq	%rbp
00000001000006a1	pushq	%rbx
00000001000006a2	pushq	%r12
00000001000006a4	pushq	%r13
00000001000006a6	pushq	%r14
00000001000006a8	pushq	%r15
00000001000006aa	subq	$0x8, %rsp
00000001000006ae	stmxcsr	(%rsp)
00000001000006b2	fnstcw	0x4(%rsp)
00000001000006b6	movq	%rsp, (%rdi)
00000001000006b9	movq	%rsi, %rsp
00000001000006bc	ldmxcsr	(%rsp)
00000001000006c0	fldcw	0x4(%rsp)
00000001000006c4	addq	$0x8, %rsp
00000001000006c8	popq	%r15
00000001000006ca	popq	%r14
00000001000006cc	popq	%r13
00000001000006ce	popq	%r12
00000001000006d0	popq	%rbx
00000001000006d1	popq	%rbp
00000001000006d2	retq
00000001000006d3	nopw	%cs:(%rax,%rax)
_original_main:
00000001000006e0	pushq	%rbp
00000001000006e1	movq	%rsp, %rbp
00000001000006e4	pushq	%r14
00000001000006e6	pushq	%rbx
00000001000006e7	subq	$0x60, %rsp
00000001000006eb	movq	0x1393e(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000006f2	movq	(%rax), %rax
00000001000006f5	movq	%rax, -0x18(%rbp)
00000001000006f9	leaq	_fwp_fn_table(%rip), %rax
0000000100000700	movq	%rax, _fwp_fns(%rip)
0000000100000707	movq	0x1393a(%rip), %r14             ## literal pool symbol address: ___stdoutp
000000010000070e	movq	(%r14), %rax
0000000100000711	movq	%rax, _fwp_prog_out(%rip)
0000000100000718	movl	%edi, _fwp_argc(%rip)
000000010000071e	movq	%rsi, _fwp_argv(%rip)
0000000100000725	leaq	_fwp_start_time(%rip), %rsi
000000010000072c	movl	$0x6, %edi
0000000100000731	callq	0x100012052                     ## symbol stub for: _clock_gettime
0000000100000736	leaq	0x122cc(%rip), %rdi             ## literal pool for: "FWP_SEED"
000000010000073d	callq	0x10001208e                     ## symbol stub for: _getenv
0000000100000742	testq	%rax, %rax
0000000100000745	je	0x10000076d
0000000100000747	movq	%rax, %rbx
000000010000074a	cmpb	$0x0, (%rax)
000000010000074d	je	0x10000076d
000000010000074f	leaq	-0x68(%rbp), %rsi
0000000100000753	movq	%rbx, %rdi
0000000100000756	movl	$0xa, %edx
000000010000075b	callq	0x10001215a                     ## symbol stub for: _strtoull
0000000100000760	movq	-0x68(%rbp), %rax
0000000100000764	cmpb	$0x0, (%rax)
0000000100000767	je	0x10000083a
000000010000076d	leaq	-0x58(%rbp), %rsi
0000000100000771	xorl	%edi, %edi
0000000100000773	callq	0x100012052                     ## symbol stub for: _clock_gettime
0000000100000778	movq	(%r14), %rdi
000000010000077b	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100000780	xorl	%esi, %esi
0000000100000782	xorl	%edx, %edx
0000000100000784	callq	0x100012106                     ## symbol stub for: _setvbuf
0000000100000789	movl	$0x1, %esi
000000010000078e	movl	$0xd, %edi
0000000100000793	callq	0x100012118                     ## symbol stub for: _signal
0000000100000798	leaq	-0x58(%rbp), %rbx
000000010000079c	movq	%rbx, %rdi
000000010000079f	callq	0x1000120dc                     ## symbol stub for: _pthread_attr_init
00000001000007a4	movq	_fwp_main_stack(%rip), %rsi
00000001000007ab	movq	%rbx, %rdi
00000001000007ae	callq	0x1000120e2                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007b3	leaq	_fwp_main_thread(%rip), %rdx
00000001000007ba	leaq	-0x70(%rbp), %rdi
00000001000007be	movq	%rbx, %rsi
00000001000007c1	xorl	%ecx, %ecx
00000001000007c3	callq	0x1000120e8                     ## symbol stub for: _pthread_create
00000001000007c8	testl	%eax, %eax
00000001000007ca	je	0x100000808
00000001000007cc	leaq	-0x68(%rbp), %rsi
00000001000007d0	movl	$0x3, %edi
00000001000007d5	callq	0x100012094                     ## symbol stub for: _getrlimit
00000001000007da	movq	-0x68(%rbp), %rcx
00000001000007de	movabsq	$0x7fffffffffffffff, %rdx       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000007e8	cmpq	%rdx, %rcx
00000001000007eb	movl	$0x800000, %edx                 ## imm = 0x800000
00000001000007f0	cmoveq	%rdx, %rcx
00000001000007f4	testl	%eax, %eax
00000001000007f6	cmovneq	%rdx, %rcx
00000001000007fa	movq	%rcx, _fwp_main_stack(%rip)
0000000100000801	callq	_fwp_main_thread
0000000100000806	jmp	0x100000813
0000000100000808	movq	-0x70(%rbp), %rdi
000000010000080c	xorl	%esi, %esi
000000010000080e	callq	0x1000120ee                     ## symbol stub for: _pthread_join
0000000100000813	movq	(%r14), %rdi
0000000100000816	callq	0x10001205e                     ## symbol stub for: _fflush
000000010000081b	movl	_fwp_exit_code(%rip), %eax
0000000100000821	movq	0x13808(%rip), %rcx             ## literal pool symbol address: ___stack_chk_guard
0000000100000828	movq	(%rcx), %rcx
000000010000082b	cmpq	-0x18(%rbp), %rcx
000000010000082f	jne	0x100000854
0000000100000831	addq	$0x60, %rsp
0000000100000835	popq	%rbx
0000000100000836	popq	%r14
0000000100000838	popq	%rbp
0000000100000839	retq
000000010000083a	movzbl	(%rbx), %eax
000000010000083d	cmpl	$0x2d, %eax
0000000100000840	je	0x10000076d
0000000100000846	cmpl	$0x2b, %eax
0000000100000849	je	0x10000076d
000000010000084f	jmp	0x100000778
0000000100000854	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100000859	nopl	(%rax)
_fwp_main_thread:
0000000100000860	pushq	%rbp
0000000100000861	movq	%rsp, %rbp
0000000100000864	pushq	%r15
0000000100000866	pushq	%r14
0000000100000868	pushq	%r13
000000010000086a	pushq	%r12
000000010000086c	pushq	%rbx
000000010000086d	subq	$0x198, %rsp                    ## imm = 0x198
0000000100000874	movq	0x137b5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000087b	movq	(%rax), %rax
000000010000087e	movq	%rax, -0x30(%rbp)
0000000100000882	movq	%rbp, %rdi
0000000100000885	callq	_fwp_gc_start
000000010000088a	movq	_fwp_main_stack(%rip), %rax
0000000100000891	leaq	-0x1b0(%rbp), %rcx
0000000100000898	movq	%rcx, _fwp_main_stack_top(%rip)
000000010000089f	movq	%rax, _fwp_main_stack_size(%rip)
00000001000008a6	leaq	_fwp_stack_guard_init.alt(%rip), %rax
00000001000008ad	movq	%rax, -0x150(%rbp)
00000001000008b4	movq	$0x10000, -0x148(%rbp)          ## imm = 0x10000
00000001000008bf	movl	$0x0, -0x140(%rbp)
00000001000008c9	leaq	-0x150(%rbp), %rdi
00000001000008d0	xorl	%esi, %esi
00000001000008d2	callq	0x100012112                     ## symbol stub for: _sigaltstack
00000001000008d7	testl	%eax, %eax
00000001000008d9	jne	0x100000916
00000001000008db	leaq	_fwp_segv(%rip), %rax
00000001000008e2	movq	%rax, -0x50(%rbp)
00000001000008e6	movabsq	$0x4100000000, %rax             ## imm = 0x4100000000
00000001000008f0	movq	%rax, -0x48(%rbp)
00000001000008f4	leaq	-0x50(%rbp), %rbx
00000001000008f8	movl	$0xb, %edi
00000001000008fd	movq	%rbx, %rsi
0000000100000900	xorl	%edx, %edx
0000000100000902	callq	0x10001210c                     ## symbol stub for: _sigaction
0000000100000907	movl	$0xa, %edi
000000010000090c	movq	%rbx, %rsi
000000010000090f	xorl	%edx, %edx
0000000100000911	callq	0x10001210c                     ## symbol stub for: _sigaction
0000000100000916	movdqa	_exec_scripts(%rip), %xmm0
000000010000091e	movdqa	%xmm0, _fwp_cli_scripts(%rip)
0000000100000926	movq	0x13e63(%rip), %rax
000000010000092d	movq	%rax, 0x1630c(%rip)
0000000100000934	movslq	_fwp_argc(%rip), %r15
000000010000093b	leal	-0x1(%r15), %r14d
000000010000093f	movq	_fwp_argv(%rip), %r13
0000000100000946	cmpq	$0x2, %r15
000000010000094a	jl	0x100000983
000000010000094c	movq	0x8(%r13), %rbx
0000000100000950	leaq	0x12a14(%rip), %rsi             ## literal pool for: "--man"
0000000100000957	movq	%rbx, %rdi
000000010000095a	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000095f	testl	%eax, %eax
0000000100000961	je	0x100000a06
0000000100000967	leaq	0x12a03(%rip), %rsi             ## literal pool for: "--completions"
000000010000096e	movl	$0xd, %edx
0000000100000973	movq	%rbx, %rdi
0000000100000976	callq	0x10001213c                     ## symbol stub for: _strncmp
000000010000097b	testl	%eax, %eax
000000010000097d	je	0x100000ec8
0000000100000983	leaq	(,%r15,8), %rdi
000000010000098b	leaq	_fwp_gc(%rip), %rcx
0000000100000992	cmpq	$0x4000, %rdi                   ## imm = 0x4000
0000000100000999	movq	%rdi, -0x170(%rbp)
00000001000009a0	ja	0x1000009f3
00000001000009a2	leaq	0xf(%rdi), %rax
00000001000009a6	shrq	$0x4, %rax
00000001000009aa	movzbl	0xbe8(%rax,%rcx), %eax
00000001000009b2	movl	0xb48(%rcx,%rax,4), %esi
00000001000009b9	subq	%rsi, _fwp_gc(%rip)
00000001000009c0	js	0x1000009f3
00000001000009c2	leaq	(%rax,%rax,2), %rax
00000001000009c6	leaq	(%rcx,%rax,8), %rax
00000001000009ca	addq	$0x788, %rax                    ## imm = 0x788
00000001000009d0	movq	(%rax), %rdx
00000001000009d3	testq	%rdx, %rdx
00000001000009d6	je	0x1000009e3
00000001000009d8	movq	(%rdx), %rcx
00000001000009db	notq	%rcx
00000001000009de	movq	%rcx, (%rax)
00000001000009e1	jmp	0x100000a2c
00000001000009e3	movq	0x8(%rax), %rdx
00000001000009e7	movq	0x10(%rax), %rcx
00000001000009eb	subq	%rdx, %rcx
00000001000009ee	cmpq	%rsi, %rcx
00000001000009f1	jae	0x100000a24
00000001000009f3	movl	$0x2, %esi
00000001000009f8	callq	_fwp_gc_alloc_slow
00000001000009fd	movq	%rax, -0x178(%rbp)
0000000100000a04	jmp	0x100000a3b
0000000100000a06	movq	0x1363b(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100000a0d	movq	(%rax), %rsi
0000000100000a10	leaq	_exec_man(%rip), %rdi
0000000100000a17	callq	0x100012076                     ## symbol stub for: _fputs
0000000100000a1c	xorl	%r15d, %r15d
0000000100000a1f	jmp	0x1000019a8
0000000100000a24	leaq	(%rdx,%rsi), %rcx
0000000100000a28	movq	%rcx, 0x8(%rax)
0000000100000a2c	movq	%rdx, -0x178(%rbp)
0000000100000a33	movq	%rdx, %rdi
0000000100000a36	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100000a3b	movl	%r14d, %eax
0000000100000a3e	movq	%rax, -0x168(%rbp)
0000000100000a45	movq	%r15, -0x188(%rbp)
0000000100000a4c	cmpl	$0x2, %r15d
0000000100000a50	movq	-0x178(%rbp), %r15
0000000100000a57	jl	0x100000a8c
0000000100000a59	xorl	%ebx, %ebx
0000000100000a5b	nopl	(%rax,%rax)
0000000100000a60	leaq	0x1(%rbx), %r12
0000000100000a64	movq	0x8(%r13,%rbx,8), %r14
0000000100000a69	movq	%r14, %rdi
0000000100000a6c	callq	0x100012136                     ## symbol stub for: _strlen
0000000100000a71	movq	%r14, %rdi
0000000100000a74	movq	%rax, %rsi
0000000100000a77	callq	_fwp_str_lossy
0000000100000a7c	movq	%rax, (%r15,%rbx,8)
0000000100000a80	movq	%r12, %rbx
0000000100000a83	cmpq	%r12, -0x168(%rbp)
0000000100000a8a	jne	0x100000a60
0000000100000a8c	movzbl	0x1515e(%rip), %eax
0000000100000a93	leaq	_fwp_gc(%rip), %rbx
0000000100000a9a	movl	0xb48(%rbx,%rax,4), %esi
0000000100000aa1	subq	%rsi, _fwp_gc(%rip)
0000000100000aa8	movq	-0x188(%rbp), %r14
0000000100000aaf	js	0x10000103d
0000000100000ab5	leaq	(%rax,%rax,2), %rax
0000000100000ab9	leaq	(%rbx,%rax,8), %rax
0000000100000abd	addq	$0x788, %rax                    ## imm = 0x788
0000000100000ac3	movq	(%rax), %rdi
0000000100000ac6	testq	%rdi, %rdi
0000000100000ac9	je	0x100000ad6
0000000100000acb	movq	(%rdi), %rcx
0000000100000ace	notq	%rcx
0000000100000ad1	movq	%rcx, (%rax)
0000000100000ad4	jmp	0x100000af2
0000000100000ad6	movq	0x8(%rax), %rdi
0000000100000ada	movq	0x10(%rax), %rcx
0000000100000ade	subq	%rdi, %rcx
0000000100000ae1	cmpq	%rsi, %rcx
0000000100000ae4	jb	0x10000103d
0000000100000aea	leaq	(%rdi,%rsi), %rcx
0000000100000aee	movq	%rcx, 0x8(%rax)
0000000100000af2	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100000af7	movq	-0x170(%rbp), %r15
0000000100000afe	movzbl	0x150ec(%rip), %ecx
0000000100000b05	movl	0xb48(%rbx,%rcx,4), %eax
0000000100000b0c	subq	%rax, _fwp_gc(%rip)
0000000100000b13	js	0x100001047
0000000100000b19	leaq	(%rcx,%rcx,2), %rcx
0000000100000b1d	leaq	(%rbx,%rcx,8), %rcx
0000000100000b21	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100000b28	movq	(%rcx), %rdx
0000000100000b2b	testq	%rdx, %rdx
0000000100000b2e	je	0x100000b3b
0000000100000b30	movq	(%rdx), %rax
0000000100000b33	notq	%rax
0000000100000b36	movq	%rax, (%rcx)
0000000100000b39	jmp	0x100000b56
0000000100000b3b	movq	0x8(%rcx), %rdx
0000000100000b3f	movq	0x10(%rcx), %rsi
0000000100000b43	subq	%rdx, %rsi
0000000100000b46	cmpq	%rax, %rsi
0000000100000b49	jb	0x100001047
0000000100000b4f	addq	%rdx, %rax
0000000100000b52	movq	%rax, 0x8(%rcx)
0000000100000b56	movb	$0x0, (%rdx)
0000000100000b59	cmpq	$0x4000, %r15                   ## imm = 0x4000
0000000100000b60	ja	0x100000bb3
0000000100000b62	leaq	0xf(%r15), %rax
0000000100000b66	shrq	$0x4, %rax
0000000100000b6a	movzbl	0xbe8(%rax,%rbx), %eax
0000000100000b72	movl	0xb48(%rbx,%rax,4), %esi
0000000100000b79	subq	%rsi, _fwp_gc(%rip)
0000000100000b80	js	0x100000bb3
0000000100000b82	leaq	(%rax,%rax,2), %rax
0000000100000b86	leaq	(%rbx,%rax,8), %rax
0000000100000b8a	addq	$0x788, %rax                    ## imm = 0x788
0000000100000b90	movq	(%rax), %rdi
0000000100000b93	testq	%rdi, %rdi
0000000100000b96	je	0x100000ba3
0000000100000b98	movq	(%rdi), %rcx
0000000100000b9b	notq	%rcx
0000000100000b9e	movq	%rcx, (%rax)
0000000100000ba1	jmp	0x100000bcd
0000000100000ba3	movq	0x8(%rax), %rdi
0000000100000ba7	movq	0x10(%rax), %rcx
0000000100000bab	subq	%rdi, %rcx
0000000100000bae	cmpq	%rsi, %rcx
0000000100000bb1	jae	0x100000bc5
0000000100000bb3	movq	%r15, %rdi
0000000100000bb6	movl	$0x2, %esi
0000000100000bbb	callq	_fwp_gc_alloc_slow
0000000100000bc0	movq	%rax, %r9
0000000100000bc3	jmp	0x100000bd8
0000000100000bc5	leaq	(%rdi,%rsi), %rcx
0000000100000bc9	movq	%rcx, 0x8(%rax)
0000000100000bcd	movq	%rdi, %r15
0000000100000bd0	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100000bd5	movq	%r15, %r9
0000000100000bd8	xorl	%esi, %esi
0000000100000bda	cmpl	$0x2, %r14d
0000000100000bde	movq	-0x178(%rbp), %rdi
0000000100000be5	movq	-0x168(%rbp), %r8
0000000100000bec	jl	0x100000d5c
0000000100000bf2	movq	%r8, %r10
0000000100000bf5	negq	%r10
0000000100000bf8	movb	$0x1, %bl
0000000100000bfa	xorl	%esi, %esi
0000000100000bfc	movl	$0x1, %r14d
0000000100000c02	xorl	%r13d, %r13d
0000000100000c05	nopw	%cs:(%rax,%rax)
0000000100000c10	movq	-0x8(%rdi,%r14,8), %r12
0000000100000c15	testl	%r13d, %r13d
0000000100000c18	jne	0x100000c50
0000000100000c1a	movq	(%r12), %r15
0000000100000c1e	cmpq	$0x2, %r15
0000000100000c22	jb	0x100000c50
0000000100000c24	cmpb	$0x2d, 0x8(%r12)
0000000100000c2a	jne	0x100000c50
0000000100000c2c	movzbl	0x9(%r12), %eax
0000000100000c32	leal	-0x30(%rax), %ecx
0000000100000c35	cmpb	$0xa, %cl
0000000100000c38	setb	%cl
0000000100000c3b	cmpb	$0x2e, %al
0000000100000c3d	sete	%dl
0000000100000c40	orb	%cl, %dl
0000000100000c42	je	0x100000c74
0000000100000c44	nopw	%cs:(%rax,%rax)
0000000100000c50	movslq	%esi, %rax
0000000100000c53	incl	%esi
0000000100000c55	movq	%r12, (%r9,%rax,8)
0000000100000c59	cmpq	%r8, %r14
0000000100000c5c	setb	%bl
0000000100000c5f	leaq	(%r10,%r14), %rax
0000000100000c63	incq	%rax
0000000100000c66	incq	%r14
0000000100000c69	cmpq	$0x1, %rax
0000000100000c6d	jne	0x100000c10
0000000100000c6f	jmp	0x100000d2a
0000000100000c74	cmpq	$0x2, %r15
0000000100000c78	sete	%cl
0000000100000c7b	cmpb	$0x2d, %al
0000000100000c7d	sete	%dl
0000000100000c80	testb	%dl, %cl
0000000100000c82	je	0x100000c8c
0000000100000c84	movl	$0x1, %r13d
0000000100000c8a	jmp	0x100000c59
0000000100000c8c	cmpb	$0x2d, %al
0000000100000c8e	jne	0x100000d16
0000000100000c94	leaq	0xa(%r12), %rdi
0000000100000c99	movq	%rdi, -0x190(%rbp)
0000000100000ca0	addq	$-0x2, %r15
0000000100000ca4	movl	%esi, -0x188(%rbp)
0000000100000caa	movl	$0x3d, %esi
0000000100000caf	movq	%r15, %rdx
0000000100000cb2	movq	%r9, -0x170(%rbp)
0000000100000cb9	movq	%r10, -0x198(%rbp)
0000000100000cc0	callq	0x1000120ac                     ## symbol stub for: _memchr
0000000100000cc5	movq	-0x190(%rbp), %rdx
0000000100000ccc	movq	-0x198(%rbp), %r10
0000000100000cd3	movq	-0x170(%rbp), %r9
0000000100000cda	movq	-0x168(%rbp), %r8
0000000100000ce1	movq	-0x178(%rbp), %rdi
0000000100000ce8	movl	-0x188(%rbp), %esi
0000000100000cee	movq	%rax, %rcx
0000000100000cf1	subq	%rdx, %rcx
0000000100000cf4	testq	%rax, %rax
0000000100000cf7	cmoveq	%r15, %rcx
0000000100000cfb	xorq	$0x4, %rcx
0000000100000cff	orq	%rax, %rcx
0000000100000d02	jne	0x100000c50
0000000100000d08	cmpl	$0x706c6568, (%rdx)             ## imm = 0x706C6568
0000000100000d0e	jne	0x100000c50
0000000100000d14	jmp	0x100000d2a
0000000100000d16	cmpq	$0x2, %r15
0000000100000d1a	sete	%cl
0000000100000d1d	cmpb	$0x68, %al
0000000100000d1f	sete	%al
0000000100000d22	testb	%al, %cl
0000000100000d24	je	0x100000c50
0000000100000d2a	testb	$0x1, %bl
0000000100000d2d	leaq	_fwp_gc(%rip), %rbx
0000000100000d34	je	0x100000d5c
0000000100000d36	movq	0x1330b(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100000d3d	movq	(%rbx), %rsi
0000000100000d40	leaq	0x12853(%rip), %rdi             ## literal pool for: "usage: reduce64 <Array[F64]>\n\narguments:\n  <Array[F64]>  or one per line of standard input\n\noptions:\n  -h, --help  show this help\n"
0000000100000d47	callq	0x100012076                     ## symbol stub for: _fputs
0000000100000d4c	movq	(%rbx), %rdi
0000000100000d4f	callq	0x10001205e                     ## symbol stub for: _fflush
0000000100000d54	xorl	%r15d, %r15d
0000000100000d57	jmp	0x1000019a8
0000000100000d5c	movl	%esi, -0x188(%rbp)
0000000100000d62	movzbl	0x14e88(%rip), %eax
0000000100000d69	movl	0xb48(%rbx,%rax,4), %esi
0000000100000d70	subq	%rsi, _fwp_gc(%rip)
0000000100000d77	js	0x100000db4
0000000100000d79	leaq	(%rax,%rax,2), %rax
0000000100000d7d	leaq	(%rbx,%rax,8), %rax
0000000100000d81	addq	$0x788, %rax                    ## imm = 0x788
0000000100000d87	movq	(%rax), %r15
0000000100000d8a	testq	%r15, %r15
0000000100000d8d	je	0x100000da0
0000000100000d8f	movq	%r9, %rbx
0000000100000d92	movq	(%r15), %rcx
0000000100000d95	notq	%rcx
0000000100000d98	movq	%rcx, (%rax)
0000000100000d9b	jmp	0x100000ef1
0000000100000da0	movq	0x8(%rax), %r15
0000000100000da4	movq	0x10(%rax), %rcx
0000000100000da8	subq	%r15, %rcx
0000000100000dab	cmpq	%rsi, %rcx
0000000100000dae	jae	0x100000ee6
0000000100000db4	movq	%r9, %rbx
0000000100000db7	movl	$0x10, %edi
0000000100000dbc	movl	$0x2, %esi
0000000100000dc1	callq	_fwp_gc_alloc_slow
0000000100000dc6	movq	%rax, %r15
0000000100000dc9	cmpl	$0x1, -0x188(%rbp)
0000000100000dd0	ja	0x100000f06
0000000100000dd6	jne	0x1000012b1
0000000100000ddc	movq	(%rbx), %r12
0000000100000ddf	movq	(%r12), %r13
0000000100000de3	addq	$0x8, %r12
0000000100000de7	cmpl	$0xe, _d3(%rip)
0000000100000dee	setne	%al
0000000100000df1	movl	0x15d69(%rip), %ebx
0000000100000df7	testl	%ebx, %ebx
0000000100000df9	sete	%cl
0000000100000dfc	orb	%al, %cl
0000000100000dfe	jne	0x100000e36
0000000100000e00	movq	0x15d51(%rip), %rdi
0000000100000e07	testq	%rdi, %rdi
0000000100000e0a	je	0x100000e1c
0000000100000e0c	leaq	0x12624(%rip), %rsi             ## literal pool for: "Bool"
0000000100000e13	callq	0x100012130                     ## symbol stub for: _strcmp
0000000100000e18	testl	%eax, %eax
0000000100000e1a	je	0x100000e36
0000000100000e1c	movl	%ebx, %eax
0000000100000e1e	testl	%eax, %eax
0000000100000e20	jle	0x10000108c
0000000100000e26	movq	0x15d4b(%rip), %rcx
0000000100000e2d	cmpl	$0x0, (%rcx)
0000000100000e30	je	0x100001068
0000000100000e36	movq	%r12, -0x150(%rbp)
0000000100000e3d	movq	%r13, -0x148(%rbp)
0000000100000e44	movq	$0x0, -0x140(%rbp)
0000000100000e4f	leaq	_d3(%rip), %rsi
0000000100000e56	leaq	-0x150(%rbp), %rdi
0000000100000e5d	movl	$0x1, %edx
0000000100000e62	movq	%r15, %rcx
0000000100000e65	callq	_tp_value
0000000100000e6a	testl	%eax, %eax
0000000100000e6c	je	0x100000f39
0000000100000e72	movq	-0x148(%rbp), %rax
0000000100000e79	movq	-0x140(%rbp), %rcx
0000000100000e80	cmpq	%rax, %rcx
0000000100000e83	jae	0x100000f30
0000000100000e89	movq	-0x150(%rbp), %rdx
0000000100000e90	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
0000000100000e9a	nopw	(%rax,%rax)
0000000100000ea0	movzbl	(%rdx,%rcx), %edi
0000000100000ea4	cmpq	$0x20, %rdi
0000000100000ea8	ja	0x100000f30
0000000100000eae	btq	%rdi, %rsi
0000000100000eb2	jae	0x100000f30
0000000100000eb4	incq	%rcx
0000000100000eb7	movq	%rcx, -0x140(%rbp)
0000000100000ebe	cmpq	%rcx, %rax
0000000100000ec1	jne	0x100000ea0
0000000100000ec3	jmp	0x1000012b1
0000000100000ec8	movzbl	0xd(%rbx), %eax
0000000100000ecc	testl	%eax, %eax
0000000100000ece	je	0x100000f8a
0000000100000ed4	cmpl	$0x3d, %eax
0000000100000ed7	jne	0x100000983
0000000100000edd	addq	$0xe, %rbx
0000000100000ee1	jmp	0x100000fb1
0000000100000ee6	movq	%r9, %rbx
0000000100000ee9	leaq	(%r15,%rsi), %rcx
0000000100000eed	movq	%rcx, 0x8(%rax)
0000000100000ef1	movq	%r15, %rdi
0000000100000ef4	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100000ef9	cmpl	$0x1, -0x188(%rbp)
0000000100000f00	jbe	0x100000dd6
0000000100000f06	movq	0x1312b(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000f0d	movq	(%rax), %rdi
0000000100000f10	leaq	0x12528(%rip), %rsi             ## literal pool for: "%s\n"
0000000100000f17	leaq	0x12620(%rip), %rdx             ## literal pool for: "usage: reduce64 <Array[F64]>\n  (the last argument may instead be given as records on stdin)"
0000000100000f1e	xorl	%eax, %eax
0000000100000f20	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100000f25	movl	$0x2, %r15d
0000000100000f2b	jmp	0x1000019a8
0000000100000f30	cmpq	%rax, %rcx
0000000100000f33	je	0x1000012b1
0000000100000f39	leaq	0x124dd(%rip), %rdi             ## literal pool for: "cannot parse `%.*s` as %s"
0000000100000f40	leaq	0x126d6(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100000f47	movl	%r13d, %esi
0000000100000f4a	movq	%r12, %rdx
0000000100000f4d	xorl	%eax, %eax
0000000100000f4f	callq	_fwp_strf
0000000100000f54	movq	0x130dd(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100000f5b	movq	(%rcx), %rdi
0000000100000f5e	addq	$0x8, %rax
0000000100000f62	leaq	0x12532(%rip), %rsi             ## literal pool for: "%s: argument %d: %s\n"
0000000100000f69	leaq	0x117d6(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000f70	movl	$0x1, %ecx
0000000100000f75	movq	%rax, %r8
0000000100000f78	xorl	%eax, %eax
0000000100000f7a	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100000f7f	movl	$0x2, %r15d
0000000100000f85	jmp	0x1000019a8
0000000100000f8a	cmpl	$0x1, %r14d
0000000100000f8e	jne	0x100000fad
0000000100000f90	movq	0x130a1(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000f97	movq	(%rax), %rdi
0000000100000f9a	leaq	0x123de(%rip), %rsi             ## literal pool for: "%s: option `--completions` needs a value (bash, zsh or fish)\n"
0000000100000fa1	leaq	0x1179e(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000fa8	jmp	0x100000f1e
0000000100000fad	movq	0x10(%r13), %rbx
0000000100000fb1	leaq	0x12405(%rip), %rsi             ## literal pool for: "bash"
0000000100000fb8	movq	%rbx, %rdi
0000000100000fbb	callq	0x100012130                     ## symbol stub for: _strcmp
0000000100000fc0	xorl	%r15d, %r15d
0000000100000fc3	testl	%eax, %eax
0000000100000fc5	je	0x100001036
0000000100000fc7	leaq	0x123f4(%rip), %rsi             ## literal pool for: "zsh"
0000000100000fce	movq	%rbx, %rdi
0000000100000fd1	callq	0x100012130                     ## symbol stub for: _strcmp
0000000100000fd6	testl	%eax, %eax
0000000100000fd8	je	0x10000105e
0000000100000fde	leaq	0x123e1(%rip), %rsi             ## literal pool for: "fish"
0000000100000fe5	movq	%rbx, %rdi
0000000100000fe8	callq	0x100012130                     ## symbol stub for: _strcmp
0000000100000fed	testl	%eax, %eax
0000000100000fef	je	0x100001e33
0000000100000ff5	movq	%rbx, %rdi
0000000100000ff8	callq	0x100012136                     ## symbol stub for: _strlen
0000000100000ffd	movq	%rbx, %rdi
0000000100001000	movq	%rax, %rsi
0000000100001003	callq	_fwp_str_lossy
0000000100001008	movq	0x13029(%rip), %rcx             ## literal pool symbol address: ___stderrp
000000010000100f	movq	(%rcx), %rdi
0000000100001012	leaq	0x8(%rax), %rcx
0000000100001016	leaq	0x123ae(%rip), %rsi             ## literal pool for: "%s: unknown shell `%s` (bash, zsh or fish)\n"
000000010000101d	leaq	0x11722(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001024	xorl	%eax, %eax
0000000100001026	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000102b	movl	$0x2, %r15d
0000000100001031	jmp	0x1000019a8
0000000100001036	xorl	%eax, %eax
0000000100001038	jmp	0x100001e38
000000010000103d	callq	_fwp_main_thread.cold.1
0000000100001042	jmp	0x100000af7
0000000100001047	callq	_fwp_main_thread.cold.2
000000010000104c	cmpq	$0x4000, %r15                   ## imm = 0x4000
0000000100001053	jbe	0x100000b62
0000000100001059	jmp	0x100000bb3
000000010000105e	movl	$0x1, %eax
0000000100001063	jmp	0x100001e38
0000000100001068	leaq	-0x1(%rax), %rdx
000000010000106c	xorl	%esi, %esi
000000010000106e	nop
0000000100001070	cmpq	%rsi, %rdx
0000000100001073	je	0x10000108c
0000000100001075	leaq	0x1(%rsi), %rdi
0000000100001079	cmpl	$0x0, 0x4(%rcx,%rsi,4)
000000010000107e	movq	%rdi, %rsi
0000000100001081	je	0x100001070
0000000100001083	cmpq	%rax, %rdi
0000000100001086	jb	0x100000e36
000000010000108c	pxor	%xmm0, %xmm0
0000000100001090	movdqa	%xmm0, -0x50(%rbp)
0000000100001095	movq	$0x0, -0x40(%rbp)
000000010000109d	movdqa	%xmm0, -0x1b0(%rbp)
00000001000010a5	movq	$0x0, -0x1a0(%rbp)
00000001000010b0	movq	$0x0, -0x48(%rbp)
00000001000010b8	movl	$0xffffffff, -0x168(%rbp)       ## imm = 0xFFFFFFFF
00000001000010c2	testq	%r13, %r13
00000001000010c5	je	0x100001282
00000001000010cb	movq	%r15, -0x170(%rbp)
00000001000010d2	xorl	%r15d, %r15d
00000001000010d5	leaq	-0x50(%rbp), %rbx
00000001000010d9	leaq	-0x150(%rbp), %r14
00000001000010e0	jmp	0x1000010f8
00000001000010e2	nopw	%cs:(%rax,%rax)
00000001000010f0	incq	%r15
00000001000010f3	cmpq	%r15, %r13
00000001000010f6	je	0x100001130
00000001000010f8	movzbl	(%r12,%r15), %eax
00000001000010fd	cmpl	$0x2d, %eax
0000000100001100	je	0x1000010f0
0000000100001102	cmpl	$0x5f, %eax
0000000100001105	je	0x1000010f0
0000000100001107	leal	-0x41(%rax), %ecx
000000010000110a	movzbl	%al, %edx
000000010000110d	orb	$0x20, %al
000000010000110f	cmpb	$0x1a, %cl
0000000100001112	movzbl	%al, %eax
0000000100001115	cmovael	%edx, %eax
0000000100001118	movb	%al, -0x150(%rbp)
000000010000111e	movl	$0x1, %edx
0000000100001123	movq	%rbx, %rdi
0000000100001126	movq	%r14, %rsi
0000000100001129	callq	_buf_put
000000010000112e	jmp	0x1000010f0
0000000100001130	movq	-0x48(%rbp), %rbx
0000000100001134	testq	%rbx, %rbx
0000000100001137	setne	%al
000000010000113a	cmpl	$0x0, 0x15a1f(%rip)
0000000100001141	movq	-0x50(%rbp), %rdi
0000000100001145	setg	%cl
0000000100001148	andb	%al, %cl
000000010000114a	cmpb	$0x1, %cl
000000010000114d	jne	0x100001288
0000000100001153	movq	%rdi, -0x198(%rbp)
000000010000115a	movq	%r13, -0x1b8(%rbp)
0000000100001161	movq	%r12, -0x190(%rbp)
0000000100001168	movl	$0xffffffff, %r12d              ## imm = 0xFFFFFFFF
000000010000116e	xorl	%r13d, %r13d
0000000100001171	leaq	-0x150(%rbp), %r15
0000000100001178	movq	%rbx, -0x178(%rbp)
000000010000117f	nop
0000000100001180	movq	0x159e1(%rip), %rax
0000000100001187	movq	(%rax,%r13,8), %rbx
000000010000118b	movq	%rbx, %rdi
000000010000118e	callq	0x100012136                     ## symbol stub for: _strlen
0000000100001193	movq	$0x0, -0x1a8(%rbp)
000000010000119e	testq	%rax, %rax
00000001000011a1	je	0x100001214
00000001000011a3	movq	%rax, %r14
00000001000011a6	movl	%r12d, -0x168(%rbp)
00000001000011ad	xorl	%r12d, %r12d
00000001000011b0	jmp	0x1000011c8
00000001000011b2	nopw	%cs:(%rax,%rax)
00000001000011c0	incq	%r12
00000001000011c3	cmpq	%r12, %r14
00000001000011c6	je	0x100001204
00000001000011c8	movzbl	(%rbx,%r12), %eax
00000001000011cd	cmpl	$0x2d, %eax
00000001000011d0	je	0x1000011c0
00000001000011d2	cmpl	$0x5f, %eax
00000001000011d5	je	0x1000011c0
00000001000011d7	leal	-0x41(%rax), %ecx
00000001000011da	movzbl	%al, %edx
00000001000011dd	orb	$0x20, %al
00000001000011df	cmpb	$0x1a, %cl
00000001000011e2	movzbl	%al, %eax
00000001000011e5	cmovael	%edx, %eax
00000001000011e8	movb	%al, -0x150(%rbp)
00000001000011ee	movl	$0x1, %edx
00000001000011f3	leaq	-0x1b0(%rbp), %rdi
00000001000011fa	movq	%r15, %rsi
00000001000011fd	callq	_buf_put
0000000100001202	jmp	0x1000011c0
0000000100001204	movq	-0x1a8(%rbp), %rax
000000010000120b	movl	-0x168(%rbp), %r12d
0000000100001212	jmp	0x100001216
0000000100001214	xorl	%eax, %eax
0000000100001216	movq	-0x178(%rbp), %rbx
000000010000121d	cmpq	%rbx, %rax
0000000100001220	jne	0x10000123e
0000000100001222	movq	-0x1b0(%rbp), %rdi
0000000100001229	movq	-0x198(%rbp), %rsi
0000000100001230	movq	%rbx, %rdx
0000000100001233	callq	0x1000120b2                     ## symbol stub for: _memcmp
0000000100001238	testl	%eax, %eax
000000010000123a	cmovel	%r13d, %r12d
000000010000123e	incq	%r13
0000000100001241	movslq	0x15918(%rip), %rax
0000000100001248	cmpq	%rax, %r13
000000010000124b	jge	0x100001256
000000010000124d	testl	%r12d, %r12d
0000000100001250	js	0x100001180
0000000100001256	movl	%r12d, -0x168(%rbp)
000000010000125d	movq	-0x1b0(%rbp), %rbx
0000000100001264	movq	-0x170(%rbp), %r15
000000010000126b	movq	-0x190(%rbp), %r12
0000000100001272	movq	-0x1b8(%rbp), %r13
0000000100001279	movq	-0x198(%rbp), %rdi
0000000100001280	jmp	0x100001291
0000000100001282	xorl	%edi, %edi
0000000100001284	xorl	%ebx, %ebx
0000000100001286	jmp	0x100001291
0000000100001288	xorl	%ebx, %ebx
000000010000128a	movq	-0x170(%rbp), %r15
0000000100001291	callq	0x100012082                     ## symbol stub for: _free
0000000100001296	movq	%rbx, %rdi
0000000100001299	callq	0x100012082                     ## symbol stub for: _free
000000010000129e	movl	-0x168(%rbp), %eax
00000001000012a4	testl	%eax, %eax
00000001000012a6	js	0x100001d1b
00000001000012ac	movl	%eax, %eax
00000001000012ae	movq	%rax, (%r15)
00000001000012b1	leaq	0x11fc0(%rip), %rdi             ## literal pool for: "FWP_OUT"
00000001000012b8	callq	0x10001208e                     ## symbol stub for: _getenv
00000001000012bd	testq	%rax, %rax
00000001000012c0	je	0x100001327
00000001000012c2	leaq	0x11fb7(%rip), %rsi             ## literal pool for: "bin"
00000001000012c9	movq	%rax, %rdi
00000001000012cc	callq	0x100012130                     ## symbol stub for: _strcmp
00000001000012d1	xorl	%esi, %esi
00000001000012d3	movq	0x12d6e(%rip), %rbx             ## literal pool symbol address: ___stdoutp
00000001000012da	movq	(%rbx), %rcx
00000001000012dd	movq	%rcx, %rdx
00000001000012e0	testl	%eax, %eax
00000001000012e2	sete	%sil
00000001000012e6	movl	%esi, _fwp_exec_binary_out(%rip)
00000001000012ec	jne	0x1000012f8
00000001000012ee	movq	0x12d43(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000012f5	movq	(%rax), %rdx
00000001000012f8	movq	%rdx, _fwp_prog_out(%rip)
00000001000012ff	movl	-0x188(%rbp), %eax
0000000100001305	jne	0x100001348
0000000100001307	leaq	_exec_out_header0(%rip), %rdi
000000010000130e	movl	$0x1, %esi
0000000100001313	movl	$0x30, %edx
0000000100001318	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000131d	movq	(%rbx), %rdi
0000000100001320	callq	0x10001205e                     ## symbol stub for: _fflush
0000000100001325	jmp	0x100001342
0000000100001327	movl	$0x0, _fwp_exec_binary_out(%rip)
0000000100001331	movq	0x12d10(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001338	movq	(%rax), %rax
000000010000133b	movq	%rax, _fwp_prog_out(%rip)
0000000100001342	movl	-0x188(%rbp), %eax
0000000100001348	movl	$0x0, -0x17c(%rbp)
0000000100001352	testl	%eax, %eax
0000000100001354	jle	0x100001397
0000000100001356	leaq	-0x17c(%rbp), %rsi
000000010000135d	movq	%r15, %rdi
0000000100001360	callq	_fwp_exec_call
0000000100001365	movq	%rax, %rbx
0000000100001368	movq	_fwp_prog_out(%rip), %rdi
000000010000136f	callq	0x10001205e                     ## symbol stub for: _fflush
0000000100001374	movl	$0x1, %r15d
000000010000137a	cmpl	$0x0, -0x17c(%rbp)
0000000100001381	jne	0x100001968
0000000100001387	movq	%rbx, %rdi
000000010000138a	callq	_fwp_emit_result
000000010000138f	xorl	%r15d, %r15d
0000000100001392	jmp	0x100001968
0000000100001397	movq	0x12ca2(%rip), %r13             ## literal pool symbol address: ___stdinp
000000010000139e	movq	(%r13), %rdi
00000001000013a2	movl	$0x100000, %ecx                 ## imm = 0x100000
00000001000013a7	xorl	%esi, %esi
00000001000013a9	xorl	%edx, %edx
00000001000013ab	callq	0x100012106                     ## symbol stub for: _setvbuf
00000001000013b0	movq	(%r13), %rcx
00000001000013b4	leaq	_fwp_in_pend(%rip), %r12
00000001000013bb	movl	$0x1, %esi
00000001000013c0	movl	$0x4, %edx
00000001000013c5	movq	%r12, %rdi
00000001000013c8	callq	0x10001207c                     ## symbol stub for: _fread
00000001000013cd	movl	%eax, _fwp_in_npend(%rip)
00000001000013d3	movl	$0x0, _fwp_in_ppos(%rip)
00000001000013dd	movb	$0x1, %cl
00000001000013df	movl	%ecx, -0x168(%rbp)
00000001000013e5	cmpl	$0x4, %eax
00000001000013e8	jne	0x1000013fa
00000001000013ea	cmpl	$0x31505746, _fwp_in_pend(%rip) ## imm = 0x31505746
00000001000013f4	je	0x1000019e6
00000001000013fa	pxor	%xmm0, %xmm0
00000001000013fe	movdqa	%xmm0, -0x50(%rbp)
0000000100001403	movq	$0x0, -0x40(%rbp)
000000010000140b	leaq	-0x150(%rbp), %rbx
0000000100001412	leaq	-0x50(%rbp), %r14
0000000100001416	movq	%r15, -0x170(%rbp)
000000010000141d	cmpb	$0x0, -0x168(%rbp)
0000000100001424	jne	0x100001729
000000010000142a	movslq	_fwp_in_ppos(%rip), %rax
0000000100001431	cmpl	_fwp_in_npend(%rip), %eax
0000000100001437	jge	0x10000144f
0000000100001439	leal	0x1(%rax), %ecx
000000010000143c	movzbl	(%rax,%r12), %eax
0000000100001441	movb	%al, -0x160(%rbp)
0000000100001447	movl	%ecx, _fwp_in_ppos(%rip)
000000010000144d	jmp	0x100001472
000000010000144f	movq	(%r13), %rcx
0000000100001453	movl	$0x1, %esi
0000000100001458	movl	$0x1, %edx
000000010000145d	leaq	-0x160(%rbp), %rdi
0000000100001464	callq	0x10001207c                     ## symbol stub for: _fread
0000000100001469	testq	%rax, %rax
000000010000146c	je	0x100001eec
0000000100001472	movslq	_fwp_in_npend(%rip), %rax
0000000100001479	movslq	_fwp_in_ppos(%rip), %r14
0000000100001480	cmpl	%eax, %r14d
0000000100001483	jge	0x1000014c0
0000000100001485	leaq	(%r12,%r14), %rsi
0000000100001489	movq	%r14, %rbx
000000010000148c	notq	%rbx
000000010000148f	addq	%rax, %rbx
0000000100001492	cmpq	$0x3, %rbx
0000000100001496	movl	$0x3, %eax
000000010000149b	cmovaeq	%rax, %rbx
000000010000149f	incq	%rbx
00000001000014a2	leaq	-0x15f(%rbp), %r12
00000001000014a9	movq	%r12, %rdi
00000001000014ac	movq	%rbx, %rdx
00000001000014af	callq	0x1000120b8                     ## symbol stub for: _memcpy
00000001000014b4	leal	(%rbx,%r14), %eax
00000001000014b8	movl	%eax, _fwp_in_ppos(%rip)
00000001000014be	jmp	0x1000014d0
00000001000014c0	xorl	%ebx, %ebx
00000001000014c2	leaq	-0x15f(%rbp), %r12
00000001000014c9	nopl	(%rax)
00000001000014d0	cmpq	$0x3, %rbx
00000001000014d4	ja	0x1000014fd
00000001000014d6	leaq	(%r12,%rbx), %rdi
00000001000014da	movl	$0x4, %edx
00000001000014df	subq	%rbx, %rdx
00000001000014e2	movq	(%r13), %rcx
00000001000014e6	movl	$0x1, %esi
00000001000014eb	callq	0x10001207c                     ## symbol stub for: _fread
00000001000014f0	addq	%rax, %rbx
00000001000014f3	testq	%rax, %rax
00000001000014f6	jne	0x1000014d0
00000001000014f8	jmp	0x10000193a
00000001000014fd	movzwl	-0x15f(%rbp), %edi
0000000100001504	movzbl	-0x15d(%rbp), %r15d
000000010000150c	shll	$0x10, %r15d
0000000100001510	leaq	(%r15,%rdi), %rax
0000000100001514	movzbl	-0x15c(%rbp), %r12d
000000010000151c	shll	$0x18, %r12d
0000000100001520	leaq	(%rax,%r12), %rbx
0000000100001524	leaq	(%r12,%rax), %rsi
0000000100001528	incq	%rsi
000000010000152b	cmpq	$0x3fff, %rbx                   ## imm = 0x3FFF
0000000100001532	movq	%rdi, -0x178(%rbp)
0000000100001539	ja	0x100001599
000000010000153b	addl	$0x10, %eax
000000010000153e	shrl	$0x4, %eax
0000000100001541	leaq	_fwp_gc(%rip), %rdx
0000000100001548	movzbl	0xbe8(%rax,%rdx), %ecx
0000000100001550	movl	0xb48(%rdx,%rcx,4), %eax
0000000100001557	subq	%rax, _fwp_gc(%rip)
000000010000155e	js	0x100001599
0000000100001560	leaq	(%rcx,%rcx,2), %rcx
0000000100001564	leaq	_fwp_gc(%rip), %rdx
000000010000156b	leaq	(%rdx,%rcx,8), %rcx
000000010000156f	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100001576	movq	(%rcx), %r14
0000000100001579	testq	%r14, %r14
000000010000157c	je	0x100001589
000000010000157e	movq	(%r14), %rax
0000000100001581	notq	%rax
0000000100001584	movq	%rax, (%rcx)
0000000100001587	jmp	0x1000015b2
0000000100001589	movq	0x8(%rcx), %r14
000000010000158d	movq	0x10(%rcx), %rdx
0000000100001591	subq	%r14, %rdx
0000000100001594	cmpq	%rax, %rdx
0000000100001597	jae	0x1000015ab
0000000100001599	movq	%rsi, %rdi
000000010000159c	movl	$0x1, %esi
00000001000015a1	callq	_fwp_gc_alloc_slow
00000001000015a6	movq	%rax, %r14
00000001000015a9	jmp	0x1000015ba
00000001000015ab	addq	%r14, %rax
00000001000015ae	movq	%rax, 0x8(%rcx)
00000001000015b2	movq	%r14, %rdi
00000001000015b5	callq	0x100011ffe                     ## symbol stub for: ___bzero
00000001000015ba	testq	%rbx, %rbx
00000001000015bd	je	0x1000016c7
00000001000015c3	movslq	_fwp_in_npend(%rip), %rax
00000001000015ca	movslq	_fwp_in_ppos(%rip), %rdx
00000001000015d1	cmpl	%eax, %edx
00000001000015d3	jge	0x10000160d
00000001000015d5	addq	%r15, %r12
00000001000015d8	movq	-0x178(%rbp), %rcx
00000001000015df	addq	%r12, %rcx
00000001000015e2	decq	%rcx
00000001000015e5	movq	%rdx, %rsi
00000001000015e8	notq	%rsi
00000001000015eb	addq	%rax, %rsi
00000001000015ee	cmpq	%rsi, %rcx
00000001000015f1	cmovbq	%rcx, %rsi
00000001000015f5	incq	%rsi
00000001000015f8	cmpq	$0x1f, %rsi
00000001000015fc	ja	0x100001615
00000001000015fe	movq	%rdx, %rcx
0000000100001601	xorl	%r15d, %r15d
0000000100001604	leaq	_fwp_in_pend(%rip), %r10
000000010000160b	jmp	0x100001680
000000010000160d	xorl	%r15d, %r15d
0000000100001610	jmp	0x1000016a0
0000000100001615	leaq	_fwp_in_pend(%rip), %r10
000000010000161c	movq	%r14, %rdi
000000010000161f	subq	%rdx, %rdi
0000000100001622	subq	%r10, %rdi
0000000100001625	cmpq	$0x20, %rdi
0000000100001629	jae	0x100001633
000000010000162b	movq	%rdx, %rcx
000000010000162e	xorl	%r15d, %r15d
0000000100001631	jmp	0x100001680
0000000100001633	movq	%rsi, %r15
0000000100001636	andq	$-0x20, %r15
000000010000163a	leaq	(%r15,%rdx), %rcx
000000010000163e	leaq	(%rdx,%r10), %rdi
0000000100001642	addq	$0x10, %rdi
0000000100001646	xorl	%r8d, %r8d
0000000100001649	leaq	(%rdx,%r8), %r9
000000010000164d	movdqu	(%r10,%r9), %xmm0
0000000100001653	movups	(%rdi,%r8), %xmm1
0000000100001658	movdqu	%xmm0, (%r14,%r8)
000000010000165e	movups	%xmm1, 0x10(%r14,%r8)
0000000100001664	addq	$0x20, %r8
0000000100001668	cmpq	%r8, %r15
000000010000166b	jne	0x100001649
000000010000166d	cmpq	%r15, %rsi
0000000100001670	je	0x100001699
0000000100001672	nopw	%cs:(%rax,%rax)
0000000100001680	movzbl	(%rcx,%r10), %edx
0000000100001685	incq	%rcx
0000000100001688	movb	%dl, (%r14,%r15)
000000010000168c	incq	%r15
000000010000168f	cmpq	%rbx, %r15
0000000100001692	jae	0x100001699
0000000100001694	cmpq	%rax, %rcx
0000000100001697	jl	0x100001680
0000000100001699	movl	%ecx, _fwp_in_ppos(%rip)
000000010000169f	nop
00000001000016a0	movq	%rbx, %rdx
00000001000016a3	subq	%r15, %rdx
00000001000016a6	jbe	0x1000016c7
00000001000016a8	leaq	(%r14,%r15), %rdi
00000001000016ac	movq	(%r13), %rcx
00000001000016b0	movl	$0x1, %esi
00000001000016b5	callq	0x10001207c                     ## symbol stub for: _fread
00000001000016ba	addq	%rax, %r15
00000001000016bd	testq	%rax, %rax
00000001000016c0	jne	0x1000016a0
00000001000016c2	jmp	0x10000193a
00000001000016c7	movzbl	-0x160(%rbp), %r15d
00000001000016cf	testl	%r15d, %r15d
00000001000016d2	je	0x10000195f
00000001000016d8	cmpl	$0x2, %r15d
00000001000016dc	je	0x100001efb
00000001000016e2	movq	%r14, -0x150(%rbp)
00000001000016e9	movq	%rbx, -0x148(%rbp)
00000001000016f0	movq	$0x0, -0x140(%rbp)
00000001000016fb	leaq	-0x150(%rbp), %rdi
0000000100001702	leaq	_d3(%rip), %rsi
0000000100001709	leaq	-0x1b0(%rbp), %rdx
0000000100001710	callq	_fwp_decode
0000000100001715	testl	%eax, %eax
0000000100001717	je	0x100001f07
000000010000171d	leaq	_fwp_in_pend(%rip), %r12
0000000100001724	jmp	0x1000018ca
0000000100001729	movq	$0x0, -0x48(%rbp)
0000000100001731	movslq	_fwp_in_ppos(%rip), %rax
0000000100001738	cmpl	_fwp_in_npend(%rip), %eax
000000010000173e	jge	0x1000017e0
0000000100001744	leal	0x1(%rax), %ecx
0000000100001747	movl	%ecx, _fwp_in_ppos(%rip)
000000010000174d	movzbl	(%rax,%r12), %eax
0000000100001752	cmpl	$0xa, %eax
0000000100001755	je	0x1000017f2
000000010000175b	cmpl	$-0x1, %eax
000000010000175e	je	0x100001eec
0000000100001764	nopw	%cs:(%rax,%rax)
0000000100001770	movb	%al, -0x150(%rbp)
0000000100001776	movl	$0x1, %edx
000000010000177b	movq	%r14, %rdi
000000010000177e	movq	%rbx, %rsi
0000000100001781	callq	_buf_put
0000000100001786	movslq	_fwp_in_ppos(%rip), %rax
000000010000178d	cmpl	_fwp_in_npend(%rip), %eax
0000000100001793	jge	0x1000017b0
0000000100001795	leal	0x1(%rax), %ecx
0000000100001798	movl	%ecx, _fwp_in_ppos(%rip)
000000010000179e	movzbl	(%rax,%r12), %eax
00000001000017a3	jmp	0x1000017b9
00000001000017a5	nopw	%cs:(%rax,%rax)
00000001000017b0	movq	(%r13), %rdi
00000001000017b4	callq	0x100012064                     ## symbol stub for: _fgetc
00000001000017b9	cmpl	$-0x1, %eax
00000001000017bc	je	0x10000180b
00000001000017be	cmpl	$0xa, %eax
00000001000017c1	jne	0x100001770
00000001000017c3	movq	-0x50(%rbp), %rax
00000001000017c7	movq	-0x48(%rbp), %rsi
00000001000017cb	testq	%rsi, %rsi
00000001000017ce	je	0x1000017f6
00000001000017d0	cmpb	$0xd, -0x1(%rax,%rsi)
00000001000017d5	jne	0x1000017fd
00000001000017d7	decq	%rsi
00000001000017da	movq	%rsi, -0x48(%rbp)
00000001000017de	jmp	0x1000017fd
00000001000017e0	movq	(%r13), %rdi
00000001000017e4	callq	0x100012064                     ## symbol stub for: _fgetc
00000001000017e9	cmpl	$0xa, %eax
00000001000017ec	jne	0x10000175b
00000001000017f2	movq	-0x50(%rbp), %rax
00000001000017f6	xorl	%esi, %esi
00000001000017f8	testq	%rax, %rax
00000001000017fb	je	0x100001818
00000001000017fd	movb	$0x0, (%rax,%rsi)
0000000100001801	movq	-0x50(%rbp), %rdi
0000000100001805	movq	-0x48(%rbp), %rsi
0000000100001809	jmp	0x10000181a
000000010000180b	movq	-0x50(%rbp), %rax
000000010000180f	movq	-0x48(%rbp), %rsi
0000000100001813	testq	%rax, %rax
0000000100001816	jne	0x1000017fd
0000000100001818	xorl	%edi, %edi
000000010000181a	testq	%rdi, %rdi
000000010000181d	leaq	0x10f1e(%rip), %rax             ## literal pool for: ""
0000000100001824	cmoveq	%rax, %rdi
0000000100001828	callq	_fwp_str_lossy
000000010000182d	movq	%rax, %r15
0000000100001830	leaq	0x8(%rax), %r14
0000000100001834	movq	(%rax), %rax
0000000100001837	movq	%r14, -0x150(%rbp)
000000010000183e	movq	%rax, -0x148(%rbp)
0000000100001845	movq	$0x0, -0x140(%rbp)
0000000100001850	movq	%rbx, %rdi
0000000100001853	leaq	_d3(%rip), %rsi
000000010000185a	movl	$0x1, %edx
000000010000185f	leaq	-0x1b0(%rbp), %rcx
0000000100001866	callq	_tp_value
000000010000186b	testl	%eax, %eax
000000010000186d	je	0x100001eb0
0000000100001873	movq	-0x148(%rbp), %rax
000000010000187a	movq	-0x140(%rbp), %rcx
0000000100001881	cmpq	%rax, %rcx
0000000100001884	jae	0x1000018c1
0000000100001886	movq	-0x150(%rbp), %rdx
000000010000188d	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
0000000100001897	nopw	(%rax,%rax)
00000001000018a0	movzbl	(%rdx,%rcx), %esi
00000001000018a4	cmpq	$0x20, %rsi
00000001000018a8	ja	0x1000018c1
00000001000018aa	btq	%rsi, %rdi
00000001000018ae	jae	0x1000018c1
00000001000018b0	incq	%rcx
00000001000018b3	movq	%rcx, -0x140(%rbp)
00000001000018ba	cmpq	%rcx, %rax
00000001000018bd	jne	0x1000018a0
00000001000018bf	jmp	0x1000018ca
00000001000018c1	cmpq	%rax, %rcx
00000001000018c4	jne	0x100001eb0
00000001000018ca	movq	-0x1b0(%rbp), %rax
00000001000018d1	movq	-0x170(%rbp), %r15
00000001000018d8	movq	%rax, (%r15)
00000001000018db	movq	%r15, %rdi
00000001000018de	leaq	-0x17c(%rbp), %rsi
00000001000018e5	callq	_fwp_exec_call
00000001000018ea	movq	%rax, %rbx
00000001000018ed	movq	_fwp_prog_out(%rip), %rdi
00000001000018f4	callq	0x10001205e                     ## symbol stub for: _fflush
00000001000018f9	cmpl	$0x0, -0x17c(%rbp)
0000000100001900	jne	0x100001ee1
0000000100001906	movq	%rbx, %rdi
0000000100001909	callq	_fwp_emit_result
000000010000190e	movq	0x12733(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001915	movq	(%rax), %rdi
0000000100001918	callq	0x10001205e                     ## symbol stub for: _fflush
000000010000191d	leaq	-0x150(%rbp), %rbx
0000000100001924	leaq	-0x50(%rbp), %r14
0000000100001928	cmpb	$0x0, -0x168(%rbp)
000000010000192f	je	0x10000142a
0000000100001935	jmp	0x100001729
000000010000193a	leaq	0x1199f(%rip), %rsi             ## literal pool for: "%s: truncated frame\n"
0000000100001941	movq	0x126f0(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001948	movq	(%rax), %rdi
000000010000194b	leaq	0x10df4(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001952	xorl	%eax, %eax
0000000100001954	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100001959	movl	$0x3, %r15d
000000010000195f	movq	-0x50(%rbp), %rdi
0000000100001963	callq	0x100012082                     ## symbol stub for: _free
0000000100001968	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000196f	je	0x100001999
0000000100001971	movq	0x126d0(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100001978	movq	(%rbx), %rcx
000000010000197b	leaq	_fwp_exec.end(%rip), %rdi
0000000100001982	movl	$0x1, %esi
0000000100001987	movl	$0x5, %edx
000000010000198c	callq	0x100012088                     ## symbol stub for: _fwrite
0000000100001991	movq	(%rbx), %rdi
0000000100001994	callq	0x10001205e                     ## symbol stub for: _fflush
0000000100001999	movq	0x126a8(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000019a0	movq	(%rax), %rdi
00000001000019a3	callq	0x10001205e                     ## symbol stub for: _fflush
00000001000019a8	movl	%r15d, _fwp_exit_code(%rip)
00000001000019af	movq	0x12692(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000019b6	movq	(%rax), %rdi
00000001000019b9	callq	0x10001205e                     ## symbol stub for: _fflush
00000001000019be	movq	0x1266b(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000019c5	movq	(%rax), %rax
00000001000019c8	cmpq	-0x30(%rbp), %rax
00000001000019cc	jne	0x100001f90
00000001000019d2	xorl	%eax, %eax
00000001000019d4	addq	$0x198, %rsp                    ## imm = 0x198
00000001000019db	popq	%rbx
00000001000019dc	popq	%r12
00000001000019de	popq	%r13
00000001000019e0	popq	%r14
00000001000019e2	popq	%r15
00000001000019e4	popq	%rbp
00000001000019e5	retq
00000001000019e6	movl	$0x4, _fwp_in_ppos(%rip)
00000001000019f0	movq	(%r13), %rcx
00000001000019f4	leaq	-0x151(%rbp), %rdi
00000001000019fb	movl	$0x1, %esi
0000000100001a00	movl	$0x1, %edx
0000000100001a05	callq	0x10001207c                     ## symbol stub for: _fread
0000000100001a0a	testq	%rax, %rax
0000000100001a0d	je	0x100001f23
0000000100001a13	leaq	-0x1b0(%rbp), %rdi
0000000100001a1a	callq	_fwp_stdin_leb
0000000100001a1f	cmpl	$0x1, %eax
0000000100001a22	jne	0x100001f1f
0000000100001a28	movq	-0x1b0(%rbp), %rax
0000000100001a2f	cmpq	$0x40, %rax
0000000100001a33	movl	$0x40, %r12d
0000000100001a39	cmovbq	%rax, %r12
0000000100001a3d	testq	%rax, %rax
0000000100001a40	je	0x100001c58
0000000100001a46	xorl	%ebx, %ebx
0000000100001a48	movq	%r15, -0x170(%rbp)
0000000100001a4f	movq	$-0x7, %r14
0000000100001a56	xorl	%r15d, %r15d
0000000100001a59	movslq	_fwp_in_ppos(%rip), %rax
0000000100001a60	cmpl	_fwp_in_npend(%rip), %eax
0000000100001a66	jge	0x100001a84
0000000100001a68	leal	0x1(%rax), %ecx
0000000100001a6b	leaq	_fwp_in_pend(%rip), %rdx
0000000100001a72	movzbl	(%rax,%rdx), %eax
0000000100001a76	movb	%al, -0x150(%rbp)
0000000100001a7c	movl	%ecx, _fwp_in_ppos(%rip)
0000000100001a82	jmp	0x100001aa7
0000000100001a84	movq	(%r13), %rcx
0000000100001a88	movl	$0x1, %esi
0000000100001a8d	movl	$0x1, %edx
0000000100001a92	leaq	-0x150(%rbp), %rdi
0000000100001a99	callq	0x10001207c                     ## symbol stub for: _fread
0000000100001a9e	testq	%rax, %rax
0000000100001aa1	je	0x100001f1d
0000000100001aa7	cmpq	$0x38, %r14
0000000100001aab	setne	%cl
0000000100001aae	movzbl	-0x150(%rbp), %eax
0000000100001ab5	testb	$0x7e, %al
0000000100001ab7	sete	%dl
0000000100001aba	orb	%cl, %dl
0000000100001abc	je	0x100001ef4
0000000100001ac2	addq	$0x7, %r14
0000000100001ac6	movzbl	%al, %eax
0000000100001ac9	movl	%eax, %edx
0000000100001acb	andl	$0x7f, %edx
0000000100001ace	movl	%r14d, %ecx
0000000100001ad1	shlq	%cl, %rdx
0000000100001ad4	orq	%rdx, %r15
0000000100001ad7	testb	%al, %al
0000000100001ad9	jns	0x100001aea
0000000100001adb	cmpq	$0x38, %r14
0000000100001adf	jbe	0x100001a59
0000000100001ae5	jmp	0x100001ef4
0000000100001aea	movq	%rbx, -0x168(%rbp)
0000000100001af1	cmpq	$0x100000, %r15                 ## imm = 0x100000
0000000100001af8	ja	0x100001ef4
0000000100001afe	testq	%r15, %r15
0000000100001b01	je	0x100001c3e
0000000100001b07	cmpq	$0x6, %r15
0000000100001b0b	jne	0x100001b6f
0000000100001b0d	movslq	_fwp_in_npend(%rip), %rax
0000000100001b14	movslq	_fwp_in_ppos(%rip), %r14
0000000100001b1b	cmpl	%eax, %r14d
0000000100001b1e	jge	0x100001c08
0000000100001b24	leaq	_fwp_in_pend(%rip), %rcx
0000000100001b2b	leaq	(%rcx,%r14), %rsi
0000000100001b2f	movq	%r14, %rbx
0000000100001b32	notq	%rbx
0000000100001b35	addq	%rax, %rbx
0000000100001b38	cmpq	$0x5, %rbx
0000000100001b3c	movl	$0x5, %eax
0000000100001b41	cmovaeq	%rax, %rbx
0000000100001b45	incq	%rbx
0000000100001b48	leaq	-0x150(%rbp), %rdi
0000000100001b4f	movq	%rbx, %rdx
0000000100001b52	callq	0x1000120b8                     ## symbol stub for: _memcpy
0000000100001b57	leal	(%rbx,%r14), %eax
0000000100001b5b	movl	%eax, _fwp_in_ppos(%rip)
0000000100001b61	jmp	0x100001c0a
0000000100001b66	subq	%r14, %r15
0000000100001b69	je	0x100001c3e
0000000100001b6f	cmpq	$0x100, %r15                    ## imm = 0x100
0000000100001b76	movl	$0x100, %r14d                   ## imm = 0x100
0000000100001b7c	cmovbq	%r15, %r14
0000000100001b80	movslq	_fwp_in_npend(%rip), %rax
0000000100001b87	movslq	_fwp_in_ppos(%rip), %rbx
0000000100001b8e	cmpl	%eax, %ebx
0000000100001b90	jge	0x100001bd8
0000000100001b92	leaq	_fwp_in_pend(%rip), %rcx
0000000100001b99	leaq	(%rcx,%rbx), %rsi
0000000100001b9d	movq	%rbx, -0x178(%rbp)
0000000100001ba4	notq	%rbx
0000000100001ba7	addq	%rax, %rbx
0000000100001baa	leaq	-0x1(%r14), %rax
0000000100001bae	cmpq	%rax, %rbx
0000000100001bb1	cmovaeq	%rax, %rbx
0000000100001bb5	incq	%rbx
0000000100001bb8	leaq	-0x150(%rbp), %rdi
0000000100001bbf	movq	%rbx, %rdx
0000000100001bc2	callq	0x1000120b8                     ## symbol stub for: _memcpy
0000000100001bc7	movq	-0x178(%rbp), %rax
0000000100001bce	addl	%ebx, %eax
0000000100001bd0	movl	%eax, _fwp_in_ppos(%rip)
0000000100001bd6	jmp	0x100001bda
0000000100001bd8	xorl	%ebx, %ebx
0000000100001bda	movq	%r14, %rdx
0000000100001bdd	subq	%rbx, %rdx
0000000100001be0	jbe	0x100001b66
0000000100001be2	leaq	(%rbx,%rbp), %rdi
0000000100001be6	addq	$-0x150, %rdi                   ## imm = 0xFEB0
0000000100001bed	movq	(%r13), %rcx
0000000100001bf1	movl	$0x1, %esi
0000000100001bf6	callq	0x10001207c                     ## symbol stub for: _fread
0000000100001bfb	addq	%rax, %rbx
0000000100001bfe	testq	%rax, %rax
0000000100001c01	jne	0x100001bda
0000000100001c03	jmp	0x100001f23
0000000100001c08	xorl	%ebx, %ebx
0000000100001c0a	cmpq	$0x5, %rbx
0000000100001c0e	ja	0x100001c3e
0000000100001c10	leaq	(%rbx,%rbp), %rdi
0000000100001c14	addq	$-0x150, %rdi                   ## imm = 0xFEB0
0000000100001c1b	movl	$0x6, %edx
0000000100001c20	subq	%rbx, %rdx
0000000100001c23	movq	(%r13), %rcx
0000000100001c27	movl	$0x1, %esi
0000000100001c2c	callq	0x10001207c                     ## symbol stub for: _fread
0000000100001c31	addq	%rax, %rbx
0000000100001c34	testq	%rax, %rax
0000000100001c37	jne	0x100001c0a
0000000100001c39	jmp	0x100001f23
0000000100001c3e	movq	-0x168(%rbp), %rbx
0000000100001c45	incq	%rbx
0000000100001c48	cmpq	%r12, %rbx
0000000100001c4b	movq	-0x170(%rbp), %r15
0000000100001c52	jne	0x100001a4f
0000000100001c58	movq	$0x0, -0x160(%rbp)
0000000100001c63	leaq	-0x50(%rbp), %rdi
0000000100001c67	movl	$0x10, %esi
0000000100001c6c	callq	_fwp_read_exact
0000000100001c71	testl	%eax, %eax
0000000100001c73	leaq	_fwp_in_pend(%rip), %r12
0000000100001c7a	je	0x100001f23
0000000100001c80	leaq	-0x160(%rbp), %rdi
0000000100001c87	callq	_fwp_stdin_name_len
0000000100001c8c	cmpl	$0x1, %eax
0000000100001c8f	jne	0x100001f1f
0000000100001c95	movq	-0x160(%rbp), %r14
0000000100001c9c	leaq	0x1(%r14), %rdi
0000000100001ca0	callq	_fwp_alloc_leaf
0000000100001ca5	movq	%rax, %rbx
0000000100001ca8	testq	%r14, %r14
0000000100001cab	je	0x100001cc0
0000000100001cad	movq	%rbx, %rdi
0000000100001cb0	movq	%r14, %rsi
0000000100001cb3	callq	_fwp_read_exact
0000000100001cb8	testl	%eax, %eax
0000000100001cba	je	0x100001f23
0000000100001cc0	movb	$0x0, (%rbx,%r14)
0000000100001cc5	movzbl	-0x151(%rbp), %ecx
0000000100001ccc	cmpl	$0x1, %ecx
0000000100001ccf	jne	0x100001f60
0000000100001cd5	movdqa	-0x50(%rbp), %xmm0
0000000100001cda	pxor	0x1049e(%rip), %xmm0
0000000100001ce2	ptest	%xmm0, %xmm0
0000000100001ce7	je	0x100001f81
0000000100001ced	movq	0x12344(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001cf4	movq	(%rax), %rdi
0000000100001cf7	leaq	0x115b0(%rip), %rsi             ## literal pool for: "%s: input type mismatch: expected `%s`, got `%s`\n"
0000000100001cfe	leaq	0x10a41(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001d05	leaq	0x11911(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100001d0c	movq	%rbx, %r8
0000000100001d0f	xorl	%eax, %eax
0000000100001d11	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100001d16	jmp	0x100001f42
0000000100001d1b	pxor	%xmm0, %xmm0
0000000100001d1f	movdqa	%xmm0, -0x150(%rbp)
0000000100001d27	movq	$0x0, -0x140(%rbp)
0000000100001d32	cmpl	$0x0, 0x14e27(%rip)
0000000100001d39	jle	0x100001e75
0000000100001d3f	movq	%r13, -0x1b8(%rbp)
0000000100001d46	movq	%r12, -0x190(%rbp)
0000000100001d4d	xorl	%r14d, %r14d
0000000100001d50	leaq	-0x150(%rbp), %rbx
0000000100001d57	leaq	-0x160(%rbp), %r12
0000000100001d5e	jmp	0x100001d73
0000000100001d60	incq	%r14
0000000100001d63	movslq	0x14df6(%rip), %rax
0000000100001d6a	cmpq	%rax, %r14
0000000100001d6d	jge	0x100001e57
0000000100001d73	testq	%r14, %r14
0000000100001d76	je	0x100001d8c
0000000100001d78	movl	$0x2, %edx
0000000100001d7d	movq	%rbx, %rdi
0000000100001d80	leaq	0x116b5(%rip), %rsi             ## literal pool for: ", "
0000000100001d87	callq	_buf_put
0000000100001d8c	movq	0x14dd5(%rip), %rax
0000000100001d93	movq	(%rax,%r14,8), %r15
0000000100001d97	movzbl	(%r15), %r13d
0000000100001d9b	testb	%r13b, %r13b
0000000100001d9e	je	0x100001d60
0000000100001da0	incq	%r15
0000000100001da3	xorl	%eax, %eax
0000000100001da5	jmp	0x100001df0
0000000100001da7	nopw	(%rax,%rax)
0000000100001db0	movb	%r13b, -0x160(%rbp)
0000000100001db7	movl	$0x1, %edx
0000000100001dbc	movq	%rbx, %rdi
0000000100001dbf	movq	%r12, %rsi
0000000100001dc2	callq	_buf_put
0000000100001dc7	leal	-0x61(%r13), %eax
0000000100001dcb	cmpb	$0x1a, %al
0000000100001dcd	setb	%al
0000000100001dd0	addb	$-0x30, %r13b
0000000100001dd4	cmpb	$0xa, %r13b
0000000100001dd8	setb	%cl
0000000100001ddb	orb	%al, %cl
0000000100001ddd	movzbl	%cl, %eax
0000000100001de0	movzbl	(%r15), %r13d
0000000100001de4	incq	%r15
0000000100001de7	testb	%r13b, %r13b
0000000100001dea	je	0x100001d60
0000000100001df0	leal	-0x41(%r13), %ecx
0000000100001df4	cmpb	$0x19, %cl
0000000100001df7	ja	0x100001db0
0000000100001df9	testl	%eax, %eax
0000000100001dfb	je	0x100001e14
0000000100001dfd	movb	$0x2d, -0x160(%rbp)
0000000100001e04	movl	$0x1, %edx
0000000100001e09	movq	%rbx, %rdi
0000000100001e0c	movq	%r12, %rsi
0000000100001e0f	callq	_buf_put
0000000100001e14	orb	$0x20, %r13b
0000000100001e18	movb	%r13b, -0x160(%rbp)
0000000100001e1f	movl	$0x1, %edx
0000000100001e24	movq	%rbx, %rdi
0000000100001e27	movq	%r12, %rsi
0000000100001e2a	callq	_buf_put
0000000100001e2f	xorl	%eax, %eax
0000000100001e31	jmp	0x100001de0
0000000100001e33	movl	$0x2, %eax
0000000100001e38	leaq	_fwp_cli_scripts(%rip), %rcx
0000000100001e3f	movq	(%rcx,%rax,8), %rdi
0000000100001e43	movq	0x121fe(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001e4a	movq	(%rax), %rsi
0000000100001e4d	callq	0x100012076                     ## symbol stub for: _fputs
0000000100001e52	jmp	0x1000019a8
0000000100001e57	movq	-0x150(%rbp), %rbx
0000000100001e5e	movq	-0x148(%rbp), %rsi
0000000100001e65	movq	-0x190(%rbp), %r12
0000000100001e6c	movq	-0x1b8(%rbp), %r13
0000000100001e73	jmp	0x100001e79
0000000100001e75	xorl	%esi, %esi
0000000100001e77	xorl	%ebx, %ebx
0000000100001e79	testq	%rbx, %rbx
0000000100001e7c	leaq	0x108bf(%rip), %rdi             ## literal pool for: ""
0000000100001e83	cmovneq	%rbx, %rdi
0000000100001e87	callq	_fwp_str_new
0000000100001e8c	movq	%rax, %r14
0000000100001e8f	movq	%rbx, %rdi
0000000100001e92	callq	0x100012082                     ## symbol stub for: _free
0000000100001e97	addq	$0x8, %r14
0000000100001e9b	leaq	0x11563(%rip), %rdi             ## literal pool for: "`%.*s` is not one of %s"
0000000100001ea2	movl	%r13d, %esi
0000000100001ea5	movq	%r12, %rdx
0000000100001ea8	movq	%r14, %rcx
0000000100001eab	jmp	0x100000f4d
0000000100001eb0	movq	0x12181(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001eb7	movq	(%rax), %rdi
0000000100001eba	movl	(%r15), %ecx
0000000100001ebd	leaq	0x1145c(%rip), %rsi             ## literal pool for: "%s: cannot parse input `%.*s` as %s\n"
0000000100001ec4	leaq	0x1087b(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001ecb	leaq	0x1174b(%rip), %r9              ## literal pool for: "Array[F64]"
0000000100001ed2	movq	%r14, %r8
0000000100001ed5	xorl	%eax, %eax
0000000100001ed7	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100001edc	jmp	0x100001959
0000000100001ee1	movl	$0x1, %r15d
0000000100001ee7	jmp	0x10000195f
0000000100001eec	xorl	%r15d, %r15d
0000000100001eef	jmp	0x10000195f
0000000100001ef4	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100001ef9	jmp	0x100001f1f
0000000100001efb	leaq	0x113f3(%rip), %rsi             ## literal pool for: "%s: bad switch frame\n"
0000000100001f02	jmp	0x100001941
0000000100001f07	movq	0x1212a(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f0e	movq	(%rax), %rdi
0000000100001f11	leaq	0x113f3(%rip), %rsi             ## literal pool for: "%s: malformed value\n"
0000000100001f18	jmp	0x10000194b
0000000100001f1d	xorl	%eax, %eax
0000000100001f1f	testl	%eax, %eax
0000000100001f21	js	0x100001f4d
0000000100001f23	movq	0x1210e(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f2a	movq	(%rax), %rdi
0000000100001f2d	leaq	0x11421(%rip), %rsi             ## literal pool for: "%s: truncated header\n"
0000000100001f34	leaq	0x1080b(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001f3b	xorl	%eax, %eax
0000000100001f3d	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100001f42	movl	$0x3, %r15d
0000000100001f48	jmp	0x1000019a8
0000000100001f4d	movq	0x120e4(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f54	movq	(%rax), %rdi
0000000100001f57	leaq	0x113e7(%rip), %rsi             ## literal pool for: "%s: bad header\n"
0000000100001f5e	jmp	0x100001f34
0000000100001f60	movq	0x120d1(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f67	movq	(%rax), %rdi
0000000100001f6a	leaq	0x11318(%rip), %rsi             ## literal pool for: "%s: unsupported protocol version %d\n"
0000000100001f71	leaq	0x107ce(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001f78	xorl	%eax, %eax
0000000100001f7a	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100001f7f	jmp	0x100001f42
0000000100001f81	movl	$0x0, -0x168(%rbp)
0000000100001f8b	jmp	0x1000013fa
0000000100001f90	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100001f95	nopw	%cs:(%rax,%rax)
_main:
0000000100001fa0	pushq	%rbp
0000000100001fa1	movq	%rsp, %rbp
0000000100001fa4	pushq	%r15
0000000100001fa6	pushq	%r14
0000000100001fa8	pushq	%r13
0000000100001faa	pushq	%r12
0000000100001fac	pushq	%rbx
0000000100001fad	subq	$0x128, %rsp                    ## imm = 0x128
0000000100001fb4	movq	%rbp, %rdi
0000000100001fb7	callq	_fwp_gc_start
0000000100001fbc	leaq	_fwp_fn_table(%rip), %rax
0000000100001fc3	movq	%rax, _fwp_fns(%rip)
0000000100001fca	pxor	%xmm0, %xmm0
0000000100001fce	movdqa	%xmm0, -0x100(%rbp)
0000000100001fd6	movdqa	%xmm0, -0xb0(%rbp)
0000000100001fde	movdqa	%xmm0, -0xc0(%rbp)
0000000100001fe6	movdqa	%xmm0, -0xd0(%rbp)
0000000100001fee	movdqa	%xmm0, -0xe0(%rbp)
0000000100001ff6	movdqa	%xmm0, -0xf0(%rbp)
0000000100001ffe	movl	$0xb, -0x100(%rbp)
0000000100002008	leaq	0x105b1(%rip), %rdi             ## literal pool for: "{\"samples\":["
000000010000200f	callq	0x1000120f4                     ## symbol stub for: _puts
0000000100002014	xorl	%ebx, %ebx
0000000100002016	leaq	-0x50(%rbp), %r13
000000010000201a	leaq	-0x100(%rbp), %r15
0000000100002021	movabsq	$-0x286bca1af286bca1, %r14      ## imm = 0xD79435E50D79435F
000000010000202b	nopl	(%rax,%rax)
0000000100002030	movq	%rbx, -0x68(%rbp)
0000000100002034	movq	$0x0, _bench_kernel_ns(%rip)
000000010000203f	movq	0x141d2(%rip), %rax
0000000100002046	subq	_fwp_gc(%rip), %rax
000000010000204d	movq	%rax, _bench_initial_charge(%rip)
0000000100002054	movq	0x14185(%rip), %rax
000000010000205b	movq	%rax, -0x60(%rbp)
000000010000205f	movl	$0x6, %edi
0000000100002064	movq	%r13, %rsi
0000000100002067	callq	0x100012052                     ## symbol stub for: _clock_gettime
000000010000206c	movaps	-0x50(%rbp), %xmm0
0000000100002070	movaps	%xmm0, -0x90(%rbp)
0000000100002077	movl	$0xfffffff7, %ecx               ## imm = 0xFFFFFFF7
000000010000207c	movabsq	$0x14650fb0739d0383, %r12       ## imm = 0x14650FB0739D0383
0000000100002086	movq	$0x0, -0x38(%rbp)
000000010000208e	movq	%r15, %rsi
0000000100002091	jmp	0x100002120
0000000100002096	nopw	%cs:(%rax,%rax)
00000001000020a0	movq	%xmm0, %rax
00000001000020a5	movq	-0x70(%rbp), %r12
00000001000020a9	xorq	%rax, %r12
00000001000020ac	movabsq	$0x100000001b3, %rax            ## imm = 0x100000001B3
00000001000020b6	imulq	%rax, %r12
00000001000020ba	movl	$0x6, %edi
00000001000020bf	leaq	-0x50(%rbp), %r13
00000001000020c3	movq	%r13, %rsi
00000001000020c6	callq	0x100012052                     ## symbol stub for: _clock_gettime
00000001000020cb	movdqa	-0x50(%rbp), %xmm0
00000001000020d0	psubq	-0xa0(%rbp), %xmm0
00000001000020d8	movq	%xmm0, %rax
00000001000020dd	imulq	$0x3b9aca00, %rax, %rax         ## imm = 0x3B9ACA00
00000001000020e4	pextrq	$0x1, %xmm0, %rcx
00000001000020eb	addq	%rax, %rcx
00000001000020ee	addq	%rcx, _bench_kernel_ns(%rip)
00000001000020f5	movq	-0x38(%rbp), %rdx
00000001000020f9	incq	%rdx
00000001000020fc	movl	-0x2c(%rbp), %ecx
00000001000020ff	incl	%ecx
0000000100002101	movq	%rdx, -0x38(%rbp)
0000000100002105	cmpq	$0x8, %rdx
0000000100002109	leaq	-0x100(%rbp), %rsi
0000000100002110	movabsq	$-0x286bca1af286bca1, %r14      ## imm = 0xD79435E50D79435F
000000010000211a	je	0x100002350
0000000100002120	movl	%ecx, -0x2c(%rbp)
0000000100002123	movl	$0x10001, %edi                  ## imm = 0x10001
0000000100002128	callq	_fwp_array_new_packed
000000010000212d	movq	%rax, %r13
0000000100002130	subq	0x13f01(%rip), %rax
0000000100002137	movq	0x13f22(%rip), %rcx
000000010000213e	shlq	$0x10, %rcx
0000000100002142	cmpq	%rcx, %rax
0000000100002145	jae	0x1000021c0
0000000100002147	movq	0x13f32(%rip), %rcx
000000010000214e	movq	%rax, %rdx
0000000100002151	shrq	$0x10, %rdx
0000000100002155	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000215c	leaq	(%rcx,%rdx), %rbx
0000000100002160	movzbl	(%rcx,%rdx), %ecx
0000000100002164	cmpb	$0x2, %cl
0000000100002167	setne	%dl
000000010000216a	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100002170	setne	%sil
0000000100002174	orb	%dl, %sil
0000000100002177	jne	0x100002190
0000000100002179	addq	$0x228, %rbx                    ## imm = 0x228
0000000100002180	cmpb	$-0x1, (%rbx)
0000000100002183	je	0x1000021af
0000000100002185	movb	$0x1, (%rbx)
0000000100002188	jmp	0x1000021c0
000000010000218a	nopw	(%rax,%rax)
0000000100002190	cmpb	$0x1, %cl
0000000100002193	jne	0x1000021c0
0000000100002195	movl	0x20(%rbx), %ecx
0000000100002198	imulq	%rcx, %rax
000000010000219c	shrq	$0x20, %rax
00000001000021a0	addq	%rax, %rbx
00000001000021a3	addq	$0x228, %rbx                    ## imm = 0x228
00000001000021aa	cmpb	$-0x1, (%rbx)
00000001000021ad	jne	0x100002185
00000001000021af	movq	%rbx, %rdi
00000001000021b2	callq	_fwp_rc_forget_slot
00000001000021b7	jmp	0x100002185
00000001000021b9	nopl	(%rax)
00000001000021c0	movq	%r12, -0x70(%rbp)
00000001000021c4	movq	%r14, %r12
00000001000021c7	movq	-0x38(%rbp), %r15
00000001000021cb	xorl	%ebx, %ebx
00000001000021cd	movl	-0x2c(%rbp), %r14d
00000001000021d1	nopw	%cs:(%rax,%rax)
00000001000021e0	movq	%r15, %rax
00000001000021e3	mulq	%r12
00000001000021e6	shrq	$0x4, %rdx
00000001000021ea	leal	(%rdx,%rdx,8), %eax
00000001000021ed	leal	(%rdx,%rax,2), %eax
00000001000021f0	movl	%r14d, %ecx
00000001000021f3	subl	%eax, %ecx
00000001000021f5	addl	%ebx, %ecx
00000001000021f7	xorps	%xmm0, %xmm0
00000001000021fa	cvtsi2sd	%ecx, %xmm0
00000001000021fe	mulsd	0x100da(%rip), %xmm0
0000000100002206	movq	%xmm0, %rdx
000000010000220b	movq	%r13, %rdi
000000010000220e	movq	%rbx, %rsi
0000000100002211	leaq	-0x100(%rbp), %rcx
0000000100002218	callq	_fwp_array_store
000000010000221d	incq	%rbx
0000000100002220	incq	%r15
0000000100002223	cmpq	$0x10001, %rbx                  ## imm = 0x10001
000000010000222a	jne	0x1000021e0
000000010000222c	movl	$0x6, %edi
0000000100002231	leaq	-0x50(%rbp), %rsi
0000000100002235	callq	0x100012052                     ## symbol stub for: _clock_gettime
000000010000223a	movdqa	-0x50(%rbp), %xmm0
000000010000223f	movdqa	%xmm0, -0xa0(%rbp)
0000000100002247	pxor	%xmm0, %xmm0
000000010000224b	movq	%xmm0, -0x58(%rbp)
0000000100002250	movsd	0x10090(%rip), %xmm2
0000000100002258	xorl	%ebx, %ebx
000000010000225a	xorl	%r15d, %r15d
000000010000225d	xorl	%r14d, %r14d
0000000100002260	movabsq	$0x7fffffffffffffff, %r12       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000226a	jmp	0x100002294
000000010000226c	nopl	(%rax)
0000000100002270	movq	%r13, %rdi
0000000100002273	movsd	%xmm2, -0x78(%rbp)
0000000100002278	callq	_fwp_drop0
000000010000227d	xorl	%eax, %eax
000000010000227f	movq	-0x78(%rbp), %xmm0
0000000100002284	movsd	-0x58(%rbp), %xmm2
0000000100002289	movq	%r15, %r13
000000010000228c	testb	%al, %al
000000010000228e	je	0x1000020a0
0000000100002294	testq	%rbx, %rbx
0000000100002297	js	0x100002270
0000000100002299	movq	(%r13), %rdx
000000010000229d	movq	%rdx, %rax
00000001000022a0	andq	%r12, %rax
00000001000022a3	cmpq	%rax, %rbx
00000001000022a6	jae	0x100002270
00000001000022a8	movl	_d0(%rip), %eax
00000001000022ae	movl	$0x8, %ecx
00000001000022b3	cmpq	$0xa, %rax
00000001000022b7	ja	0x1000022c4
00000001000022b9	leaq	0x102a8(%rip), %rcx
00000001000022c0	movq	(%rcx,%rax,8), %rcx
00000001000022c4	testq	%rdx, %rdx
00000001000022c7	js	0x1000022cf
00000001000022c9	leaq	0x8(%r13), %rdx
00000001000022cd	jmp	0x1000022d3
00000001000022cf	movq	0x10(%r13), %rdx
00000001000022d3	movq	%rcx, %rsi
00000001000022d6	imulq	%rbx, %rsi
00000001000022da	cmpq	$0x1, %rcx
00000001000022de	je	0x1000022ff
00000001000022e0	cmpq	$0x2, %rcx
00000001000022e4	je	0x1000022f2
00000001000022e6	cmpq	$0x8, %rcx
00000001000022ea	jne	0x10000230c
00000001000022ec	movq	(%rdx,%rsi), %rax
00000001000022f0	jmp	0x100002319
00000001000022f2	movzwl	(%rdx,%rsi), %ecx
00000001000022f6	cmpl	$0x1, %eax
00000001000022f9	movswq	%cx, %rax
00000001000022fd	jmp	0x100002315
00000001000022ff	movzbl	(%rdx,%rsi), %ecx
0000000100002303	testq	%rax, %rax
0000000100002306	movsbq	%cl, %rax
000000010000230a	jmp	0x100002315
000000010000230c	movl	(%rdx,%rsi), %ecx
000000010000230f	cmpl	$0x2, %eax
0000000100002312	movslq	%ecx, %rax
0000000100002315	cmovneq	%rcx, %rax
0000000100002319	incq	%rbx
000000010000231c	movq	%rax, %xmm1
0000000100002321	mulsd	0xffc7(%rip), %xmm1
0000000100002329	addsd	0xffc7(%rip), %xmm1
0000000100002331	addsd	%xmm1, %xmm2
0000000100002335	movb	$0x1, %al
0000000100002337	movq	%r13, %r15
000000010000233a	movsd	%xmm2, -0x58(%rbp)
000000010000233f	movq	%r13, %r14
0000000100002342	jmp	0x100002289
0000000100002347	nopw	(%rax,%rax)
0000000100002350	movq	%rsi, %r15
0000000100002353	movl	$0x6, %edi
0000000100002358	movq	%r13, %rsi
000000010000235b	callq	0x100012052                     ## symbol stub for: _clock_gettime
0000000100002360	movq	0x13eb1(%rip), %rcx
0000000100002367	movq	_bench_initial_charge(%rip), %rax
000000010000236e	addq	_fwp_gc(%rip), %rax
0000000100002375	movq	0x13e64(%rip), %rdx
000000010000237c	subq	-0x60(%rbp), %rdx
0000000100002380	movq	-0x68(%rbp), %rbx
0000000100002384	jne	0x100002448
000000010000238a	cmpq	%rax, %rcx
000000010000238d	jne	0x100002448
0000000100002393	movdqa	-0x50(%rbp), %xmm0
0000000100002398	psubq	-0x90(%rbp), %xmm0
00000001000023a0	movq	%xmm0, %rax
00000001000023a5	pextrq	$0x1, %xmm0, %rdx
00000001000023ac	imulq	$0x3b9aca00, %rax, %rax         ## imm = 0x3B9ACA00
00000001000023b3	addq	%rax, %rdx
00000001000023b6	testq	%rbx, %rbx
00000001000023b9	leaq	0x1037f(%rip), %rsi             ## literal pool for: ",\n"
00000001000023c0	leaq	0x1037b(%rip), %rax             ## literal pool for: ""
00000001000023c7	cmoveq	%rax, %rsi
00000001000023cb	movq	_bench_kernel_ns(%rip), %rcx
00000001000023d2	movq	0x13e1e(%rip), %xmm0
00000001000023da	movq	0x13c6f(%rip), %rax
00000001000023e1	movq	0x13ca0(%rip), %rdi
00000001000023e8	addq	0x13c59(%rip), %rdi
00000001000023ef	movq	%rdi, 0x40(%rsp)
00000001000023f4	movq	%rax, 0x38(%rsp)
00000001000023f9	xorpd	%xmm1, %xmm1
00000001000023fd	movupd	%xmm1, 0x20(%rsp)
0000000100002403	movupd	%xmm1, 0x10(%rsp)
0000000100002409	movupd	%xmm1, (%rsp)
000000010000240e	movq	$0x0, 0x30(%rsp)
0000000100002417	leaq	0x101eb(%rip), %rdi             ## literal pool for: "%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%ld,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"collections\":%zu,\"collectionPauseSeconds\":%.9f,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}"
000000010000241e	movq	%r12, %r8
0000000100002421	xorl	%r9d, %r9d
0000000100002424	movb	$0x1, %al
0000000100002426	callq	0x1000120d6                     ## symbol stub for: _printf
000000010000242b	incq	%rbx
000000010000242e	cmpq	$0x5, %rbx
0000000100002432	jne	0x100002030
0000000100002438	leaq	0x10304(%rip), %rdi             ## literal pool for: "]}"
000000010000243f	callq	0x1000120f4                     ## symbol stub for: _puts
0000000100002444	xorl	%eax, %eax
0000000100002446	jmp	0x100002468
0000000100002448	subq	%rax, %rcx
000000010000244b	movq	0x11be6(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002452	movq	(%rax), %rdi
0000000100002455	leaq	0x10171(%rip), %rsi             ## literal pool for: "unexpected collection or retained charged storage: %zu %ld\n"
000000010000245c	xorl	%eax, %eax
000000010000245e	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100002463	movl	$0xe0, %eax
0000000100002468	addq	$0x128, %rsp                    ## imm = 0x128
000000010000246f	popq	%rbx
0000000100002470	popq	%r12
0000000100002472	popq	%r13
0000000100002474	popq	%r14
0000000100002476	popq	%r15
0000000100002478	popq	%rbp
0000000100002479	retq
000000010000247a	nopw	(%rax,%rax)
_fwp_gc_start:
0000000100002480	pushq	%rbp
0000000100002481	movq	%rsp, %rbp
0000000100002484	pushq	%r15
0000000100002486	pushq	%r14
0000000100002488	pushq	%r12
000000010000248a	pushq	%rbx
000000010000248b	cmpl	$0x0, 0x13b62(%rip)
0000000100002492	jne	0x10000249f
0000000100002494	movq	%rdi, %rbx
0000000100002497	callq	_fwp_gc_init
000000010000249c	movq	%rbx, %rdi
000000010000249f	movq	%rdi, 0x13bea(%rip)
00000001000024a6	callq	0x10001202e                     ## symbol stub for: __dyld_image_count
00000001000024ab	testl	%eax, %eax
00000001000024ad	je	0x1000025b4
00000001000024b3	xorl	%ebx, %ebx
00000001000024b5	leaq	_fwp_gc(%rip), %r14
00000001000024bc	movl	$0x1, %r15d
00000001000024c2	jmp	0x1000024df
00000001000024c4	testl	%esi, %esi
00000001000024c6	jne	0x10000254d
00000001000024cc	nopl	(%rax)
00000001000024d0	incl	%ebx
00000001000024d2	callq	0x10001202e                     ## symbol stub for: __dyld_image_count
00000001000024d7	cmpl	%eax, %ebx
00000001000024d9	jae	0x1000025b4
00000001000024df	movl	%ebx, %edi
00000001000024e1	callq	0x100012022                     ## symbol stub for: __dyld_get_image_header
00000001000024e6	testq	%rax, %rax
00000001000024e9	je	0x1000024d0
00000001000024eb	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
00000001000024f1	jne	0x1000024d0
00000001000024f3	movl	%ebx, %edi
00000001000024f5	movq	%rax, %r12
00000001000024f8	callq	0x100012028                     ## symbol stub for: __dyld_get_image_vmaddr_slide
00000001000024fd	movl	0x10(%r12), %edx
0000000100002502	testl	%edx, %edx
0000000100002504	je	0x1000024d0
0000000100002506	movq	%r12, %rcx
0000000100002509	addq	$0x20, %rcx
000000010000250d	xorl	%esi, %esi
000000010000250f	movl	%edx, %edi
0000000100002511	movq	%rcx, %r8
0000000100002514	jmp	0x10000252b
0000000100002516	nopw	%cs:(%rax,%rax)
0000000100002520	movl	0x4(%r8), %r9d
0000000100002524	addq	%r9, %r8
0000000100002527	decl	%edi
0000000100002529	je	0x1000024c4
000000010000252b	cmpl	$0x19, (%r8)
000000010000252f	jne	0x100002520
0000000100002531	movq	0x18(%r8), %r9
0000000100002535	addq	%rax, %r9
0000000100002538	cmpq	%r14, %r9
000000010000253b	ja	0x100002520
000000010000253d	movq	%r14, %r10
0000000100002540	subq	%r9, %r10
0000000100002543	cmpq	0x20(%r8), %r10
0000000100002547	cmovbl	%r15d, %esi
000000010000254b	jmp	0x100002520
000000010000254d	movl	0x13c45(%rip), %esi
0000000100002553	jmp	0x10000256a
0000000100002555	nopw	%cs:(%rax,%rax)
0000000100002560	movl	0x4(%rcx), %edi
0000000100002563	addq	%rdi, %rcx
0000000100002566	decl	%edx
0000000100002568	je	0x1000025b4
000000010000256a	cmpl	$0x19, (%rcx)
000000010000256d	jne	0x100002560
000000010000256f	movl	0x3c(%rcx), %edi
0000000100002572	notl	%edi
0000000100002574	testb	$0x3, %dil
0000000100002578	jne	0x100002560
000000010000257a	movq	0x20(%rcx), %rdi
000000010000257e	testq	%rdi, %rdi
0000000100002581	je	0x100002560
0000000100002583	cmpl	$0x10, %esi
0000000100002586	je	0x100002642
000000010000258c	movq	0x18(%rcx), %r8
0000000100002590	addq	%rax, %r8
0000000100002593	movslq	%esi, %r9
0000000100002596	shlq	$0x4, %r9
000000010000259a	movq	%r8, 0x1090(%r9,%r14)
00000001000025a2	incl	%esi
00000001000025a4	movl	%esi, 0x13bee(%rip)
00000001000025aa	movq	%rdi, 0x1098(%r9,%r14)
00000001000025b2	jmp	0x100002560
00000001000025b4	cmpl	$0x0, 0x13a3d(%rip)
00000001000025bb	setne	%cl
00000001000025be	cmpl	$0x0, 0x13bd3(%rip)
00000001000025c5	setg	%al
00000001000025c8	andb	%cl, %al
00000001000025ca	movzbl	%al, %ecx
00000001000025cd	movl	%ecx, 0x13a29(%rip)
00000001000025d3	cmpl	$0x0, 0x13a2a(%rip)
00000001000025da	je	0x1000025f2
00000001000025dc	leaq	_fwp_gc_report(%rip), %rdi
00000001000025e3	callq	0x100012040                     ## symbol stub for: _atexit
00000001000025e8	cmpl	$0x0, 0x13a0d(%rip)
00000001000025ef	setne	%al
00000001000025f2	testb	%al, %al
00000001000025f4	je	0x100002639
00000001000025f6	cmpq	$0x0, 0x13a2a(%rip)
00000001000025fe	je	0x100002639
0000000100002600	movq	0x13c11(%rip), %rax
0000000100002607	subq	_fwp_gc(%rip), %rax
000000010000260e	cvtsi2sd	%rax, %xmm0
0000000100002613	addsd	0x13bd5(%rip), %xmm0
000000010000261b	movsd	%xmm0, 0x13bcd(%rip)
0000000100002623	movq	$0x0, 0x13bea(%rip)
000000010000262e	movq	$0x0, _fwp_gc(%rip)
0000000100002639	popq	%rbx
000000010000263a	popq	%r12
000000010000263c	popq	%r14
000000010000263e	popq	%r15
0000000100002640	popq	%rbp
0000000100002641	retq
0000000100002642	callq	_fwp_flush
0000000100002647	movq	0x119ea(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000264e	movq	(%rax), %rdi
0000000100002651	leaq	0x101c7(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100002658	leaq	0x10fc9(%rip), %rdx             ## literal pool for: "too many program data segments for the collector"
000000010000265f	xorl	%eax, %eax
0000000100002661	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100002666	movl	$0x65, %edi
000000010000266b	callq	0x100012058                     ## symbol stub for: _exit
_fwp_array_new_packed:
0000000100002670	pushq	%rbp
0000000100002671	movq	%rsp, %rbp
0000000100002674	pushq	%r14
0000000100002676	pushq	%rbx
0000000100002677	movabsq	$0x1fffffffffffffff, %rax       ## imm = 0x1FFFFFFFFFFFFFFF
0000000100002681	cmpq	%rax, %rdi
0000000100002684	jae	0x1000027f1
000000010000268a	movq	%rdi, %rbx
000000010000268d	testq	%rsi, %rsi
0000000100002690	je	0x100002731
0000000100002696	movl	(%rsi), %eax
0000000100002698	cmpq	$0xa, %rax
000000010000269c	ja	0x1000026b9
000000010000269e	movl	$0x4e7, %ecx                    ## imm = 0x4E7
00000001000026a3	btl	%eax, %ecx
00000001000026a6	jae	0x1000026b9
00000001000026a8	leaq	0xfe61(%rip), %rcx
00000001000026af	movq	(%rcx,%rax,8), %rcx
00000001000026b3	imulq	%rbx, %rcx
00000001000026b7	jmp	0x1000026c1
00000001000026b9	leaq	(,%rbx,8), %rcx
00000001000026c1	leaq	0x8(%rcx), %rsi
00000001000026c5	cmpl	$0xb, %eax
00000001000026c8	ja	0x100002739
00000001000026ca	movl	$0xdef, %edx                    ## imm = 0xDEF
00000001000026cf	btl	%eax, %edx
00000001000026d2	jae	0x100002739
00000001000026d4	cmpq	$0x3ff8, %rcx                   ## imm = 0x3FF8
00000001000026db	ja	0x10000279b
00000001000026e1	addq	$0x17, %rcx
00000001000026e5	shrq	$0x4, %rcx
00000001000026e9	leaq	_fwp_gc(%rip), %rdx
00000001000026f0	movzbl	0xbe8(%rcx,%rdx), %ecx
00000001000026f8	movl	0xb48(%rdx,%rcx,4), %eax
00000001000026ff	subq	%rax, _fwp_gc(%rip)
0000000100002706	js	0x10000279b
000000010000270c	leaq	(%rcx,%rcx,2), %rcx
0000000100002710	leaq	(%rdx,%rcx,8), %rcx
0000000100002714	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000271b	movq	(%rcx), %r14
000000010000271e	testq	%r14, %r14
0000000100002721	je	0x10000278b
0000000100002723	movq	(%r14), %rax
0000000100002726	notq	%rax
0000000100002729	movq	%rax, (%rcx)
000000010000272c	jmp	0x1000027ce
0000000100002731	leaq	0x8(,%rbx,8), %rsi
0000000100002739	cmpq	$0x4000, %rsi                   ## imm = 0x4000
0000000100002740	ja	0x1000027b5
0000000100002742	leaq	0xf(%rsi), %rax
0000000100002746	shrq	$0x4, %rax
000000010000274a	leaq	_fwp_gc(%rip), %rcx
0000000100002751	movzbl	0xbe8(%rax,%rcx), %edx
0000000100002759	movl	0xb48(%rcx,%rdx,4), %eax
0000000100002760	subq	%rax, _fwp_gc(%rip)
0000000100002767	js	0x1000027b5
0000000100002769	leaq	(%rdx,%rdx,2), %rdx
000000010000276d	leaq	(%rcx,%rdx,8), %rcx
0000000100002771	addq	$0x788, %rcx                    ## imm = 0x788
0000000100002778	movq	(%rcx), %r14
000000010000277b	testq	%r14, %r14
000000010000277e	je	0x1000027a5
0000000100002780	movq	(%r14), %rdx
0000000100002783	notq	%rdx
0000000100002786	movq	%rdx, (%rcx)
0000000100002789	jmp	0x1000027db
000000010000278b	movq	0x8(%rcx), %r14
000000010000278f	movq	0x10(%rcx), %rdx
0000000100002793	subq	%r14, %rdx
0000000100002796	cmpq	%rax, %rdx
0000000100002799	jae	0x1000027c7
000000010000279b	movq	%rsi, %rdi
000000010000279e	movl	$0x1, %esi
00000001000027a3	jmp	0x1000027bd
00000001000027a5	movq	0x8(%rcx), %r14
00000001000027a9	movq	0x10(%rcx), %rdx
00000001000027ad	subq	%r14, %rdx
00000001000027b0	cmpq	%rax, %rdx
00000001000027b3	jae	0x1000027d3
00000001000027b5	movq	%rsi, %rdi
00000001000027b8	movl	$0x2, %esi
00000001000027bd	callq	_fwp_gc_alloc_slow
00000001000027c2	movq	%rax, %r14
00000001000027c5	jmp	0x1000027e6
00000001000027c7	addq	%r14, %rax
00000001000027ca	movq	%rax, 0x8(%rcx)
00000001000027ce	movq	%r14, %rdi
00000001000027d1	jmp	0x1000027e1
00000001000027d3	leaq	(%r14,%rax), %rdx
00000001000027d7	movq	%rdx, 0x8(%rcx)
00000001000027db	movq	%r14, %rdi
00000001000027de	movq	%rax, %rsi
00000001000027e1	callq	0x100011ffe                     ## symbol stub for: ___bzero
00000001000027e6	movq	%rbx, (%r14)
00000001000027e9	movq	%r14, %rax
00000001000027ec	popq	%rbx
00000001000027ed	popq	%r14
00000001000027ef	popq	%rbp
00000001000027f0	retq
00000001000027f1	callq	_fwp_flush
00000001000027f6	movq	0x1183b(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000027fd	movq	(%rax), %rdi
0000000100002800	leaq	0x10018(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100002807	leaq	0x10f0c(%rip), %rdx             ## literal pool for: "array too large"
000000010000280e	xorl	%eax, %eax
0000000100002810	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100002815	movl	$0x65, %edi
000000010000281a	callq	0x100012058                     ## symbol stub for: _exit
000000010000281f	nop
_fwp_array_store:
0000000100002820	cmpq	$0x0, (%rdi)
0000000100002824	js	0x100002866
0000000100002826	testq	%rcx, %rcx
0000000100002829	je	0x100002856
000000010000282b	movl	(%rcx), %eax
000000010000282d	cmpl	$0xa, %eax
0000000100002830	ja	0x100002856
0000000100002832	movl	$0x484, %ecx                    ## imm = 0x484
0000000100002837	btl	%eax, %ecx
000000010000283a	jb	0x10000285c
000000010000283c	movl	$0x21, %ecx
0000000100002841	btl	%eax, %ecx
0000000100002844	jb	0x100002861
0000000100002846	movl	$0x42, %ecx
000000010000284b	btl	%eax, %ecx
000000010000284e	jae	0x100002856
0000000100002850	movw	%dx, 0x8(%rdi,%rsi,2)
0000000100002855	retq
0000000100002856	movq	%rdx, 0x8(%rdi,%rsi,8)
000000010000285b	retq
000000010000285c	movl	%edx, 0x8(%rdi,%rsi,4)
0000000100002860	retq
0000000100002861	movb	%dl, 0x8(%rdi,%rsi)
0000000100002865	retq
0000000100002866	pushq	%rbp
0000000100002867	movq	%rsp, %rbp
000000010000286a	callq	_fwp_flush
000000010000286f	movq	0x117c2(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002876	movq	(%rax), %rdi
0000000100002879	leaq	0xff9f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002880	leaq	0x10ea3(%rip), %rdx             ## literal pool for: "internal: mutating an array view"
0000000100002887	xorl	%eax, %eax
0000000100002889	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000288e	movl	$0x65, %edi
0000000100002893	callq	0x100012058                     ## symbol stub for: _exit
0000000100002898	nopl	(%rax,%rax)
_e0:
00000001000028a0	pushq	%rbp
00000001000028a1	movq	%rsp, %rbp
00000001000028a4	pushq	%r15
00000001000028a6	pushq	%r14
00000001000028a8	pushq	%r13
00000001000028aa	pushq	%r12
00000001000028ac	pushq	%rbx
00000001000028ad	subq	$0x18, %rsp
00000001000028b1	movq	%rdi, %rbx
00000001000028b4	movq	(%rdi), %rdi
00000001000028b7	callq	_fwp_rc_share
00000001000028bc	movq	(%rbx), %rbx
00000001000028bf	pxor	%xmm0, %xmm0
00000001000028c3	movq	%xmm0, -0x30(%rbp)
00000001000028c8	movsd	0xfa18(%rip), %xmm2
00000001000028d0	xorl	%r14d, %r14d
00000001000028d3	movabsq	$0x7fffffffffffffff, %r15       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000028dd	xorl	%r13d, %r13d
00000001000028e0	xorl	%r12d, %r12d
00000001000028e3	jmp	0x100002914
00000001000028e5	nopw	%cs:(%rax,%rax)
00000001000028f0	movq	%rbx, %rdi
00000001000028f3	movsd	%xmm2, -0x38(%rbp)
00000001000028f8	callq	_fwp_drop0
00000001000028fd	xorl	%eax, %eax
00000001000028ff	movq	-0x38(%rbp), %xmm0
0000000100002904	movsd	-0x30(%rbp), %xmm2
0000000100002909	movq	%r13, %rbx
000000010000290c	testb	%al, %al
000000010000290e	je	0x1000029c6
0000000100002914	testq	%r14, %r14
0000000100002917	js	0x1000028f0
0000000100002919	movq	(%rbx), %rdx
000000010000291c	movq	%rdx, %rax
000000010000291f	andq	%r15, %rax
0000000100002922	cmpq	%rax, %r14
0000000100002925	jae	0x1000028f0
0000000100002927	movl	_d0(%rip), %eax
000000010000292d	movl	$0x8, %ecx
0000000100002932	cmpq	$0xa, %rax
0000000100002936	ja	0x100002943
0000000100002938	leaq	0xfc29(%rip), %rcx
000000010000293f	movq	(%rcx,%rax,8), %rcx
0000000100002943	testq	%rdx, %rdx
0000000100002946	js	0x10000294e
0000000100002948	leaq	0x8(%rbx), %rdx
000000010000294c	jmp	0x100002952
000000010000294e	movq	0x10(%rbx), %rdx
0000000100002952	movq	%rcx, %rsi
0000000100002955	imulq	%r14, %rsi
0000000100002959	cmpq	$0x1, %rcx
000000010000295d	je	0x10000297e
000000010000295f	cmpq	$0x2, %rcx
0000000100002963	je	0x100002971
0000000100002965	cmpq	$0x8, %rcx
0000000100002969	jne	0x10000298b
000000010000296b	movq	(%rdx,%rsi), %rax
000000010000296f	jmp	0x100002998
0000000100002971	movzwl	(%rdx,%rsi), %ecx
0000000100002975	cmpl	$0x1, %eax
0000000100002978	movswq	%cx, %rax
000000010000297c	jmp	0x100002994
000000010000297e	movzbl	(%rdx,%rsi), %ecx
0000000100002982	testq	%rax, %rax
0000000100002985	movsbq	%cl, %rax
0000000100002989	jmp	0x100002994
000000010000298b	movl	(%rdx,%rsi), %ecx
000000010000298e	cmpl	$0x2, %eax
0000000100002991	movslq	%ecx, %rax
0000000100002994	cmovneq	%rcx, %rax
0000000100002998	incq	%r14
000000010000299b	movq	%rax, %xmm1
00000001000029a0	mulsd	0xf948(%rip), %xmm1
00000001000029a8	addsd	0xf948(%rip), %xmm1
00000001000029b0	addsd	%xmm1, %xmm2
00000001000029b4	movb	$0x1, %al
00000001000029b6	movq	%rbx, %r13
00000001000029b9	movsd	%xmm2, -0x30(%rbp)
00000001000029be	movq	%rbx, %r12
00000001000029c1	jmp	0x100002909
00000001000029c6	movq	%xmm0, %rbx
00000001000029cb	movq	%rbx, %rdi
00000001000029ce	callq	_fwp_rc_share
00000001000029d3	movq	%rbx, %rax
00000001000029d6	addq	$0x18, %rsp
00000001000029da	popq	%rbx
00000001000029db	popq	%r12
00000001000029dd	popq	%r13
00000001000029df	popq	%r14
00000001000029e1	popq	%r15
00000001000029e3	popq	%rbp
00000001000029e4	retq
00000001000029e5	nopw	%cs:(%rax,%rax)
_e1:
00000001000029f0	pushq	%rbp
00000001000029f1	movq	%rsp, %rbp
00000001000029f4	pushq	%r15
00000001000029f6	pushq	%r14
00000001000029f8	pushq	%r13
00000001000029fa	pushq	%r12
00000001000029fc	pushq	%rbx
00000001000029fd	pushq	%rax
00000001000029fe	movq	%rdi, %rbx
0000000100002a01	movq	(%rdi), %rdi
0000000100002a04	callq	_fwp_rc_share
0000000100002a09	movq	(%rbx), %rbx
0000000100002a0c	xorl	%r12d, %r12d
0000000100002a0f	xorl	%r13d, %r13d
0000000100002a12	xorl	%r15d, %r15d
0000000100002a15	xorl	%r14d, %r14d
0000000100002a18	xorl	%eax, %eax
0000000100002a1a	jmp	0x100002a38
0000000100002a1c	nopl	(%rax)
0000000100002a20	movq	%rbx, %rdi
0000000100002a23	callq	_fwp_drop0
0000000100002a28	xorl	%ecx, %ecx
0000000100002a2a	movq	%r12, %rax
0000000100002a2d	movq	%r15, %rbx
0000000100002a30	testb	%cl, %cl
0000000100002a32	je	0x100002af6
0000000100002a38	testq	%r13, %r13
0000000100002a3b	js	0x100002a20
0000000100002a3d	movq	(%rbx), %rsi
0000000100002a40	movq	%rsi, %rcx
0000000100002a43	movabsq	$0x7fffffffffffffff, %rdx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100002a4d	andq	%rdx, %rcx
0000000100002a50	cmpq	%rcx, %r13
0000000100002a53	jae	0x100002a20
0000000100002a55	movl	_d1(%rip), %ecx
0000000100002a5b	movl	$0x8, %edx
0000000100002a60	cmpq	$0xa, %rcx
0000000100002a64	ja	0x100002a71
0000000100002a66	leaq	0xfafb(%rip), %rdx
0000000100002a6d	movq	(%rdx,%rcx,8), %rdx
0000000100002a71	testq	%rsi, %rsi
0000000100002a74	js	0x100002a7c
0000000100002a76	leaq	0x8(%rbx), %rsi
0000000100002a7a	jmp	0x100002a80
0000000100002a7c	movq	0x10(%rbx), %rsi
0000000100002a80	movq	%rdx, %rdi
0000000100002a83	imulq	%r13, %rdi
0000000100002a87	cmpq	$0x1, %rdx
0000000100002a8b	je	0x100002ab0
0000000100002a8d	cmpq	$0x2, %rdx
0000000100002a91	je	0x100002a9f
0000000100002a93	cmpq	$0x8, %rdx
0000000100002a97	jne	0x100002ac1
0000000100002a99	movq	(%rsi,%rdi), %rcx
0000000100002a9d	jmp	0x100002ac4
0000000100002a9f	movzwl	(%rsi,%rdi), %edx
0000000100002aa3	cmpl	$0x1, %ecx
0000000100002aa6	movswq	%dx, %rcx
0000000100002aaa	cmovneq	%rdx, %rcx
0000000100002aae	jmp	0x100002ac4
0000000100002ab0	movzbl	(%rsi,%rdi), %edx
0000000100002ab4	testq	%rcx, %rcx
0000000100002ab7	movsbq	%dl, %rcx
0000000100002abb	cmovneq	%rdx, %rcx
0000000100002abf	jmp	0x100002ac4
0000000100002ac1	movl	(%rsi,%rdi), %ecx
0000000100002ac4	incq	%r13
0000000100002ac7	movd	%ecx, %xmm0
0000000100002acb	mulss	0xf85d(%rip), %xmm0
0000000100002ad3	addss	0xf859(%rip), %xmm0
0000000100002adb	movd	%r12d, %xmm1
0000000100002ae0	addss	%xmm0, %xmm1
0000000100002ae4	movd	%xmm1, %r12d
0000000100002ae9	movb	$0x1, %cl
0000000100002aeb	movq	%rbx, %r15
0000000100002aee	movq	%rbx, %r14
0000000100002af1	jmp	0x100002a2d
0000000100002af6	movl	%eax, %ebx
0000000100002af8	movq	%rbx, %rdi
0000000100002afb	callq	_fwp_rc_share
0000000100002b00	movq	%rbx, %rax
0000000100002b03	addq	$0x8, %rsp
0000000100002b07	popq	%rbx
0000000100002b08	popq	%r12
0000000100002b0a	popq	%r13
0000000100002b0c	popq	%r14
0000000100002b0e	popq	%r15
0000000100002b10	popq	%rbp
0000000100002b11	retq
0000000100002b12	nopw	%cs:(%rax,%rax)
_e2:
0000000100002b20	pushq	%rbp
0000000100002b21	movq	%rsp, %rbp
0000000100002b24	pushq	%r15
0000000100002b26	pushq	%r14
0000000100002b28	pushq	%r13
0000000100002b2a	pushq	%r12
0000000100002b2c	pushq	%rbx
0000000100002b2d	subq	$0xa8, %rsp
0000000100002b34	movq	%rdi, %rbx
0000000100002b37	movq	0x114f2(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002b3e	movq	(%rax), %rax
0000000100002b41	movq	%rax, -0x30(%rbp)
0000000100002b45	movq	(%rdi), %rdi
0000000100002b48	callq	_fwp_rc_share
0000000100002b4d	movq	(%rbx), %rbx
0000000100002b50	xorl	%r15d, %r15d
0000000100002b53	xorl	%r13d, %r13d
0000000100002b56	xorl	%r12d, %r12d
0000000100002b59	xorl	%r14d, %r14d
0000000100002b5c	xorl	%edi, %edi
0000000100002b5e	jmp	0x100002b78
0000000100002b60	movq	%rbx, %rdi
0000000100002b63	callq	_fwp_drop0
0000000100002b68	xorl	%eax, %eax
0000000100002b6a	movq	%r15, %rdi
0000000100002b6d	movq	%r12, %rbx
0000000100002b70	testb	%al, %al
0000000100002b72	je	0x100002ca9
0000000100002b78	testq	%r13, %r13
0000000100002b7b	js	0x100002b60
0000000100002b7d	movq	(%rbx), %rdx
0000000100002b80	movq	%rdx, %rax
0000000100002b83	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100002b8d	andq	%rcx, %rax
0000000100002b90	cmpq	%rax, %r13
0000000100002b93	jae	0x100002b60
0000000100002b95	movl	_d2(%rip), %eax
0000000100002b9b	movl	$0x8, %ecx
0000000100002ba0	cmpq	$0xa, %rax
0000000100002ba4	ja	0x100002bb1
0000000100002ba6	leaq	0xf9bb(%rip), %rcx
0000000100002bad	movq	(%rcx,%rax,8), %rcx
0000000100002bb1	testq	%rdx, %rdx
0000000100002bb4	js	0x100002bbc
0000000100002bb6	leaq	0x8(%rbx), %rdx
0000000100002bba	jmp	0x100002bc0
0000000100002bbc	movq	0x10(%rbx), %rdx
0000000100002bc0	movq	%rcx, %rsi
0000000100002bc3	imulq	%r13, %rsi
0000000100002bc7	cmpq	$0x1, %rcx
0000000100002bcb	je	0x100002bec
0000000100002bcd	cmpq	$0x2, %rcx
0000000100002bd1	je	0x100002bdf
0000000100002bd3	cmpq	$0x8, %rcx
0000000100002bd7	jne	0x100002bf9
0000000100002bd9	movq	(%rdx,%rsi), %rax
0000000100002bdd	jmp	0x100002c06
0000000100002bdf	movzwl	(%rdx,%rsi), %ecx
0000000100002be3	cmpl	$0x1, %eax
0000000100002be6	movswq	%cx, %rax
0000000100002bea	jmp	0x100002c02
0000000100002bec	movzbl	(%rdx,%rsi), %ecx
0000000100002bf0	testq	%rax, %rax
0000000100002bf3	movsbq	%cl, %rax
0000000100002bf7	jmp	0x100002c02
0000000100002bf9	movl	(%rdx,%rsi), %ecx
0000000100002bfc	cmpl	$0x2, %eax
0000000100002bff	movslq	%ecx, %rax
0000000100002c02	cmovneq	%rcx, %rax
0000000100002c06	movq	_fwp_cleanups(%rip), %rcx
0000000100002c0d	movq	%rbx, -0xa0(%rbp)
0000000100002c14	movq	%rcx, -0xd0(%rbp)
0000000100002c1b	leaq	_fwp_owner_release35(%rip), %rdx
0000000100002c22	movq	%rdx, -0xc8(%rbp)
0000000100002c29	leaq	-0xa0(%rbp), %rdx
0000000100002c30	movq	%rdx, -0xc0(%rbp)
0000000100002c37	leaq	-0xd0(%rbp), %rdx
0000000100002c3e	movq	%rdx, _fwp_cleanups(%rip)
0000000100002c45	addq	$-0x7f, %rax
0000000100002c49	cmpq	$-0x101, %rax                   ## imm = 0xFEFF
0000000100002c4f	jbe	0x100002cd6
0000000100002c55	movq	%rbx, -0x98(%rbp)
0000000100002c5c	movq	%rcx, -0xb8(%rbp)
0000000100002c63	leaq	_fwp_owner_release36(%rip), %rax
0000000100002c6a	movq	%rax, -0xb0(%rbp)
0000000100002c71	leaq	-0x98(%rbp), %rax
0000000100002c78	movq	%rax, -0xa8(%rbp)
0000000100002c7f	leaq	-0xb8(%rbp), %rax
0000000100002c86	movq	%rax, _fwp_cleanups(%rip)
0000000100002c8d	incq	%r15
0000000100002c90	jo	0x100002ce6
0000000100002c92	incq	%r13
0000000100002c95	movq	%rcx, _fwp_cleanups(%rip)
0000000100002c9c	movb	$0x1, %al
0000000100002c9e	movq	%rbx, %r12
0000000100002ca1	movq	%rbx, %r14
0000000100002ca4	jmp	0x100002b6d
0000000100002ca9	movq	%rdi, %rbx
0000000100002cac	callq	_fwp_rc_share
0000000100002cb1	movq	0x11378(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002cb8	movq	(%rax), %rax
0000000100002cbb	cmpq	-0x30(%rbp), %rax
0000000100002cbf	jne	0x100002d34
0000000100002cc1	movq	%rbx, %rax
0000000100002cc4	addq	$0xa8, %rsp
0000000100002ccb	popq	%rbx
0000000100002ccc	popq	%r12
0000000100002cce	popq	%r13
0000000100002cd0	popq	%r14
0000000100002cd2	popq	%r15
0000000100002cd4	popq	%rbp
0000000100002cd5	retq
0000000100002cd6	leaq	0xfb59(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002cdd	leaq	0xfb7f(%rip), %rcx              ## literal pool for: "I8"
0000000100002ce4	jmp	0x100002cf4
0000000100002ce6	leaq	0xfb49(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002ced	leaq	0xfb3e(%rip), %rcx              ## literal pool for: "I64"
0000000100002cf4	leaq	-0x90(%rbp), %rbx
0000000100002cfb	movl	$0x60, %esi
0000000100002d00	movq	%rbx, %rdi
0000000100002d03	xorl	%eax, %eax
0000000100002d05	callq	0x10001211e                     ## symbol stub for: _snprintf
0000000100002d0a	callq	_fwp_flush
0000000100002d0f	movq	0x11322(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002d16	movq	(%rax), %rdi
0000000100002d19	leaq	0xfaff(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002d20	movq	%rbx, %rdx
0000000100002d23	xorl	%eax, %eax
0000000100002d25	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100002d2a	movl	$0x65, %edi
0000000100002d2f	callq	0x100012058                     ## symbol stub for: _exit
0000000100002d34	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100002d39	nopl	(%rax)
_e3:
0000000100002d40	pushq	%rbp
0000000100002d41	movq	%rsp, %rbp
0000000100002d44	pushq	%r15
0000000100002d46	pushq	%r14
0000000100002d48	pushq	%r13
0000000100002d4a	pushq	%r12
0000000100002d4c	pushq	%rbx
0000000100002d4d	subq	$0xa8, %rsp
0000000100002d54	movq	%rdi, %rbx
0000000100002d57	movq	0x112d2(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002d5e	movq	(%rax), %rax
0000000100002d61	movq	%rax, -0x30(%rbp)
0000000100002d65	movq	(%rdi), %rdi
0000000100002d68	callq	_fwp_rc_share
0000000100002d6d	movq	(%rbx), %rbx
0000000100002d70	xorl	%r14d, %r14d
0000000100002d73	xorl	%r13d, %r13d
0000000100002d76	xorl	%r12d, %r12d
0000000100002d79	xorl	%r15d, %r15d
0000000100002d7c	xorl	%eax, %eax
0000000100002d7e	jmp	0x100002d98
0000000100002d80	movq	%rbx, %rdi
0000000100002d83	callq	_fwp_drop0
0000000100002d88	xorl	%ecx, %ecx
0000000100002d8a	movq	%r14, %rax
0000000100002d8d	movq	%r12, %rbx
0000000100002d90	testb	%cl, %cl
0000000100002d92	je	0x100002ed4
0000000100002d98	testq	%r13, %r13
0000000100002d9b	js	0x100002d80
0000000100002d9d	movq	(%rbx), %rsi
0000000100002da0	movq	%rsi, %rcx
0000000100002da3	movabsq	$0x7fffffffffffffff, %rdx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100002dad	andq	%rdx, %rcx
0000000100002db0	cmpq	%rcx, %r13
0000000100002db3	jae	0x100002d80
0000000100002db5	movl	_d2(%rip), %ecx
0000000100002dbb	movl	$0x8, %edx
0000000100002dc0	cmpq	$0xa, %rcx
0000000100002dc4	ja	0x100002dd1
0000000100002dc6	leaq	0xf79b(%rip), %rdx
0000000100002dcd	movq	(%rdx,%rcx,8), %rdx
0000000100002dd1	testq	%rsi, %rsi
0000000100002dd4	js	0x100002ddc
0000000100002dd6	leaq	0x8(%rbx), %rsi
0000000100002dda	jmp	0x100002de0
0000000100002ddc	movq	0x10(%rbx), %rsi
0000000100002de0	movq	%rdx, %rdi
0000000100002de3	imulq	%r13, %rdi
0000000100002de7	cmpq	$0x1, %rdx
0000000100002deb	je	0x100002e0c
0000000100002ded	cmpq	$0x2, %rdx
0000000100002df1	je	0x100002dff
0000000100002df3	cmpq	$0x8, %rdx
0000000100002df7	jne	0x100002e19
0000000100002df9	movq	(%rsi,%rdi), %rcx
0000000100002dfd	jmp	0x100002e26
0000000100002dff	movzwl	(%rsi,%rdi), %edx
0000000100002e03	cmpl	$0x1, %ecx
0000000100002e06	movswq	%dx, %rcx
0000000100002e0a	jmp	0x100002e22
0000000100002e0c	movzbl	(%rsi,%rdi), %edx
0000000100002e10	testq	%rcx, %rcx
0000000100002e13	movsbq	%dl, %rcx
0000000100002e17	jmp	0x100002e22
0000000100002e19	movl	(%rsi,%rdi), %edx
0000000100002e1c	cmpl	$0x2, %ecx
0000000100002e1f	movslq	%edx, %rcx
0000000100002e22	cmovneq	%rdx, %rcx
0000000100002e26	movq	_fwp_cleanups(%rip), %rdx
0000000100002e2d	movq	%rbx, -0xa0(%rbp)
0000000100002e34	movq	%rdx, -0xd0(%rbp)
0000000100002e3b	leaq	_fwp_owner_release40(%rip), %rsi
0000000100002e42	movq	%rsi, -0xc8(%rbp)
0000000100002e49	leaq	-0xa0(%rbp), %rsi
0000000100002e50	movq	%rsi, -0xc0(%rbp)
0000000100002e57	leaq	-0xd0(%rbp), %rsi
0000000100002e5e	movq	%rsi, _fwp_cleanups(%rip)
0000000100002e65	leaq	-0x7f(%rcx), %rsi
0000000100002e69	cmpq	$-0x101, %rsi                   ## imm = 0xFEFF
0000000100002e70	jbe	0x100002f05
0000000100002e76	movq	%rbx, -0x98(%rbp)
0000000100002e7d	movq	%rdx, -0xb8(%rbp)
0000000100002e84	leaq	_fwp_owner_release41(%rip), %rsi
0000000100002e8b	movq	%rsi, -0xb0(%rbp)
0000000100002e92	leaq	-0x98(%rbp), %rsi
0000000100002e99	movq	%rsi, -0xa8(%rbp)
0000000100002ea0	leaq	-0xb8(%rbp), %rsi
0000000100002ea7	movq	%rsi, _fwp_cleanups(%rip)
0000000100002eae	addq	%rcx, %r14
0000000100002eb1	incq	%r14
0000000100002eb4	movsbq	%r14b, %rcx
0000000100002eb8	cmpq	%r14, %rcx
0000000100002ebb	jne	0x100002f05
0000000100002ebd	incq	%r13
0000000100002ec0	movq	%rdx, _fwp_cleanups(%rip)
0000000100002ec7	movb	$0x1, %cl
0000000100002ec9	movq	%rbx, %r12
0000000100002ecc	movq	%rbx, %r15
0000000100002ecf	jmp	0x100002d8d
0000000100002ed4	movsbq	%al, %rbx
0000000100002ed8	movq	%rbx, %rdi
0000000100002edb	callq	_fwp_rc_share
0000000100002ee0	movq	0x11149(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002ee7	movq	(%rax), %rax
0000000100002eea	cmpq	-0x30(%rbp), %rax
0000000100002eee	jne	0x100002f53
0000000100002ef0	movq	%rbx, %rax
0000000100002ef3	addq	$0xa8, %rsp
0000000100002efa	popq	%rbx
0000000100002efb	popq	%r12
0000000100002efd	popq	%r13
0000000100002eff	popq	%r14
0000000100002f01	popq	%r15
0000000100002f03	popq	%rbp
0000000100002f04	retq
0000000100002f05	leaq	0xf92a(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002f0c	leaq	0xf950(%rip), %rcx              ## literal pool for: "I8"
0000000100002f13	leaq	-0x90(%rbp), %rbx
0000000100002f1a	movl	$0x60, %esi
0000000100002f1f	movq	%rbx, %rdi
0000000100002f22	xorl	%eax, %eax
0000000100002f24	callq	0x10001211e                     ## symbol stub for: _snprintf
0000000100002f29	callq	_fwp_flush
0000000100002f2e	movq	0x11103(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002f35	movq	(%rax), %rdi
0000000100002f38	leaq	0xf8e0(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002f3f	movq	%rbx, %rdx
0000000100002f42	xorl	%eax, %eax
0000000100002f44	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100002f49	movl	$0x65, %edi
0000000100002f4e	callq	0x100012058                     ## symbol stub for: _exit
0000000100002f53	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100002f58	nopl	(%rax,%rax)
_e8:
0000000100002f60	pushq	%rbp
0000000100002f61	movq	%rsp, %rbp
0000000100002f64	pushq	%rbx
0000000100002f65	subq	$0x68, %rsp
0000000100002f69	movq	0x110c0(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002f70	movq	(%rax), %rax
0000000100002f73	movq	%rax, -0x10(%rbp)
0000000100002f77	movq	0x8(%rdi), %rbx
0000000100002f7b	addq	(%rdi), %rbx
0000000100002f7e	movsbq	%bl, %rax
0000000100002f82	cmpq	%rbx, %rax
0000000100002f85	jne	0x100002fa9
0000000100002f87	movq	%rbx, %rdi
0000000100002f8a	callq	_fwp_rc_share
0000000100002f8f	movq	0x1109a(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002f96	movq	(%rax), %rax
0000000100002f99	cmpq	-0x10(%rbp), %rax
0000000100002f9d	jne	0x100002ff4
0000000100002f9f	movq	%rbx, %rax
0000000100002fa2	addq	$0x68, %rsp
0000000100002fa6	popq	%rbx
0000000100002fa7	popq	%rbp
0000000100002fa8	retq
0000000100002fa9	leaq	0xf886(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002fb0	leaq	0xf8ac(%rip), %rcx              ## literal pool for: "I8"
0000000100002fb7	leaq	-0x70(%rbp), %rbx
0000000100002fbb	movl	$0x60, %esi
0000000100002fc0	movq	%rbx, %rdi
0000000100002fc3	xorl	%eax, %eax
0000000100002fc5	callq	0x10001211e                     ## symbol stub for: _snprintf
0000000100002fca	callq	_fwp_flush
0000000100002fcf	movq	0x11062(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002fd6	movq	(%rax), %rdi
0000000100002fd9	leaq	0xf83f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002fe0	movq	%rbx, %rdx
0000000100002fe3	xorl	%eax, %eax
0000000100002fe5	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100002fea	movl	$0x65, %edi
0000000100002fef	callq	0x100012058                     ## symbol stub for: _exit
0000000100002ff4	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100002ff9	nopl	(%rax)
_e17:
0000000100003000	pushq	%rbp
0000000100003001	movq	%rsp, %rbp
0000000100003004	pushq	%rbx
0000000100003005	pushq	%rax
0000000100003006	movdqu	(%rdi), %xmm0
000000010000300a	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000300f	addps	%xmm0, %xmm1
0000000100003012	extractps	$0x0, %xmm1, %ebx
0000000100003018	movq	%rbx, %rdi
000000010000301b	callq	_fwp_rc_share
0000000100003020	movq	%rbx, %rax
0000000100003023	addq	$0x8, %rsp
0000000100003027	popq	%rbx
0000000100003028	popq	%rbp
0000000100003029	retq
000000010000302a	nopw	(%rax,%rax)
_e18:
0000000100003030	pushq	%rbp
0000000100003031	movq	%rsp, %rbp
0000000100003034	pushq	%rbx
0000000100003035	pushq	%rax
0000000100003036	movdqu	(%rdi), %xmm0
000000010000303a	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000303f	mulps	%xmm0, %xmm1
0000000100003042	extractps	$0x0, %xmm1, %ebx
0000000100003048	movq	%rbx, %rdi
000000010000304b	callq	_fwp_rc_share
0000000100003050	movq	%rbx, %rax
0000000100003053	addq	$0x8, %rsp
0000000100003057	popq	%rbx
0000000100003058	popq	%rbp
0000000100003059	retq
000000010000305a	nopw	(%rax,%rax)
_e25:
0000000100003060	pushq	%rbp
0000000100003061	movq	%rsp, %rbp
0000000100003064	pushq	%rbx
0000000100003065	pushq	%rax
0000000100003066	movsd	(%rdi), %xmm0
000000010000306a	addsd	0x8(%rdi), %xmm0
000000010000306f	movq	%xmm0, %rbx
0000000100003074	movq	%rbx, %rdi
0000000100003077	callq	_fwp_rc_share
000000010000307c	movq	%rbx, %rax
000000010000307f	addq	$0x8, %rsp
0000000100003083	popq	%rbx
0000000100003084	popq	%rbp
0000000100003085	retq
0000000100003086	nopw	%cs:(%rax,%rax)
_e26:
0000000100003090	pushq	%rbp
0000000100003091	movq	%rsp, %rbp
0000000100003094	pushq	%rbx
0000000100003095	pushq	%rax
0000000100003096	movsd	(%rdi), %xmm0
000000010000309a	mulsd	0x8(%rdi), %xmm0
000000010000309f	movq	%xmm0, %rbx
00000001000030a4	movq	%rbx, %rdi
00000001000030a7	callq	_fwp_rc_share
00000001000030ac	movq	%rbx, %rax
00000001000030af	addq	$0x8, %rsp
00000001000030b3	popq	%rbx
00000001000030b4	popq	%rbp
00000001000030b5	retq
00000001000030b6	nopw	%cs:(%rax,%rax)
_e27:
00000001000030c0	pushq	%rbp
00000001000030c1	movq	%rsp, %rbp
00000001000030c4	pushq	%rbx
00000001000030c5	pushq	%rax
00000001000030c6	movq	%rdi, %rbx
00000001000030c9	movq	0x8(%rdi), %rdi
00000001000030cd	callq	_fwp_rc_share
00000001000030d2	movq	(%rbx), %rdi
00000001000030d5	movq	0x8(%rbx), %rsi
00000001000030d9	leaq	_d0(%rip), %rdx
00000001000030e0	callq	_fwp_p_array_get_typed
00000001000030e5	movq	%rax, %rbx
00000001000030e8	movq	%rax, %rdi
00000001000030eb	callq	_fwp_rc_share
00000001000030f0	movq	%rbx, %rax
00000001000030f3	addq	$0x8, %rsp
00000001000030f7	popq	%rbx
00000001000030f8	popq	%rbp
00000001000030f9	retq
00000001000030fa	nopw	(%rax,%rax)
_e28:
0000000100003100	pushq	%rbp
0000000100003101	movq	%rsp, %rbp
0000000100003104	pushq	%rbx
0000000100003105	subq	$0x68, %rsp
0000000100003109	movq	0x10f20(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100003110	movq	(%rax), %rax
0000000100003113	movq	%rax, -0x10(%rbp)
0000000100003117	movq	0x8(%rdi), %rbx
000000010000311b	addq	(%rdi), %rbx
000000010000311e	jo	0x100003142
0000000100003120	movq	%rbx, %rdi
0000000100003123	callq	_fwp_rc_share
0000000100003128	movq	0x10f01(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000312f	movq	(%rax), %rax
0000000100003132	cmpq	-0x10(%rbp), %rax
0000000100003136	jne	0x10000318d
0000000100003138	movq	%rbx, %rax
000000010000313b	addq	$0x68, %rsp
000000010000313f	popq	%rbx
0000000100003140	popq	%rbp
0000000100003141	retq
0000000100003142	leaq	0xf6ed(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100003149	leaq	0xf6e2(%rip), %rcx              ## literal pool for: "I64"
0000000100003150	leaq	-0x70(%rbp), %rbx
0000000100003154	movl	$0x60, %esi
0000000100003159	movq	%rbx, %rdi
000000010000315c	xorl	%eax, %eax
000000010000315e	callq	0x10001211e                     ## symbol stub for: _snprintf
0000000100003163	callq	_fwp_flush
0000000100003168	movq	0x10ec9(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000316f	movq	(%rax), %rdi
0000000100003172	leaq	0xf6a6(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003179	movq	%rbx, %rdx
000000010000317c	xorl	%eax, %eax
000000010000317e	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100003183	movl	$0x65, %edi
0000000100003188	callq	0x100012058                     ## symbol stub for: _exit
000000010000318d	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100003192	nopw	%cs:(%rax,%rax)
_e29:
00000001000031a0	pushq	%rbp
00000001000031a1	movq	%rsp, %rbp
00000001000031a4	pushq	%rbx
00000001000031a5	pushq	%rax
00000001000031a6	movq	%rdi, %rbx
00000001000031a9	movq	(%rdi), %rdi
00000001000031ac	callq	_fwp_rc_share
00000001000031b1	movq	(%rbx), %rdi
00000001000031b4	callq	_f29
00000001000031b9	movq	%rax, %rbx
00000001000031bc	movq	%rax, %rdi
00000001000031bf	callq	_fwp_rc_share
00000001000031c4	movq	%rbx, %rax
00000001000031c7	addq	$0x8, %rsp
00000001000031cb	popq	%rbx
00000001000031cc	popq	%rbp
00000001000031cd	retq
00000001000031ce	nop
_e30:
00000001000031d0	pushq	%rbp
00000001000031d1	movq	%rsp, %rbp
00000001000031d4	pushq	%rbx
00000001000031d5	pushq	%rax
00000001000031d6	movq	%rdi, %rbx
00000001000031d9	movq	(%rdi), %rdi
00000001000031dc	callq	_fwp_rc_share
00000001000031e1	movq	0x8(%rbx), %rdi
00000001000031e5	callq	_fwp_rc_share
00000001000031ea	movq	(%rbx), %rdi
00000001000031ed	movq	0x8(%rbx), %rsi
00000001000031f1	leaq	_fwp_drop1(%rip), %rdx
00000001000031f8	callq	_fwp_p_loop_own
00000001000031fd	movq	%rax, %rbx
0000000100003200	movq	%rax, %rdi
0000000100003203	callq	_fwp_rc_share
0000000100003208	movq	%rbx, %rax
000000010000320b	addq	$0x8, %rsp
000000010000320f	popq	%rbx
0000000100003210	popq	%rbp
0000000100003211	retq
0000000100003212	nopw	%cs:(%rax,%rax)
_e31:
0000000100003220	pushq	%rbp
0000000100003221	movq	%rsp, %rbp
0000000100003224	pushq	%rbx
0000000100003225	pushq	%rax
0000000100003226	movq	%rdi, %rbx
0000000100003229	movq	0x8(%rdi), %rdi
000000010000322d	callq	_fwp_rc_share
0000000100003232	movq	(%rbx), %rdi
0000000100003235	movq	0x8(%rbx), %rsi
0000000100003239	leaq	_d1(%rip), %rdx
0000000100003240	callq	_fwp_p_array_get_typed
0000000100003245	movq	%rax, %rbx
0000000100003248	movq	%rax, %rdi
000000010000324b	callq	_fwp_rc_share
0000000100003250	movq	%rbx, %rax
0000000100003253	addq	$0x8, %rsp
0000000100003257	popq	%rbx
0000000100003258	popq	%rbp
0000000100003259	retq
000000010000325a	nopw	(%rax,%rax)
_e32:
0000000100003260	pushq	%rbp
0000000100003261	movq	%rsp, %rbp
0000000100003264	pushq	%rbx
0000000100003265	pushq	%rax
0000000100003266	movq	%rdi, %rbx
0000000100003269	movq	(%rdi), %rdi
000000010000326c	callq	_fwp_rc_share
0000000100003271	movq	(%rbx), %rdi
0000000100003274	callq	_f32
0000000100003279	movq	%rax, %rbx
000000010000327c	movq	%rax, %rdi
000000010000327f	callq	_fwp_rc_share
0000000100003284	movq	%rbx, %rax
0000000100003287	addq	$0x8, %rsp
000000010000328b	popq	%rbx
000000010000328c	popq	%rbp
000000010000328d	retq
000000010000328e	nop
_e33:
0000000100003290	pushq	%rbp
0000000100003291	movq	%rsp, %rbp
0000000100003294	pushq	%rbx
0000000100003295	pushq	%rax
0000000100003296	movq	%rdi, %rbx
0000000100003299	movq	(%rdi), %rdi
000000010000329c	callq	_fwp_rc_share
00000001000032a1	movq	0x8(%rbx), %rdi
00000001000032a5	callq	_fwp_rc_share
00000001000032aa	movq	(%rbx), %rdi
00000001000032ad	movq	0x8(%rbx), %rsi
00000001000032b1	leaq	_fwp_drop3(%rip), %rdx
00000001000032b8	callq	_fwp_p_loop_own
00000001000032bd	movq	%rax, %rbx
00000001000032c0	movq	%rax, %rdi
00000001000032c3	callq	_fwp_rc_share
00000001000032c8	movq	%rbx, %rax
00000001000032cb	addq	$0x8, %rsp
00000001000032cf	popq	%rbx
00000001000032d0	popq	%rbp
00000001000032d1	retq
00000001000032d2	nopw	%cs:(%rax,%rax)
_e34:
00000001000032e0	pushq	%rbp
00000001000032e1	movq	%rsp, %rbp
00000001000032e4	pushq	%rbx
00000001000032e5	pushq	%rax
00000001000032e6	movq	%rdi, %rbx
00000001000032e9	movq	0x8(%rdi), %rdi
00000001000032ed	callq	_fwp_rc_share
00000001000032f2	movq	(%rbx), %rdi
00000001000032f5	movq	0x8(%rbx), %rsi
00000001000032f9	leaq	_d2(%rip), %rdx
0000000100003300	callq	_fwp_p_array_get_typed
0000000100003305	movq	%rax, %rbx
0000000100003308	movq	%rax, %rdi
000000010000330b	callq	_fwp_rc_share
0000000100003310	movq	%rbx, %rax
0000000100003313	addq	$0x8, %rsp
0000000100003317	popq	%rbx
0000000100003318	popq	%rbp
0000000100003319	retq
000000010000331a	nopw	(%rax,%rax)
_e35:
0000000100003320	pushq	%rbp
0000000100003321	movq	%rsp, %rbp
0000000100003324	pushq	%rbx
0000000100003325	pushq	%rax
0000000100003326	movq	%rdi, %rbx
0000000100003329	movq	(%rdi), %rdi
000000010000332c	callq	_fwp_rc_share
0000000100003331	movq	(%rbx), %rdi
0000000100003334	callq	_f35
0000000100003339	movq	%rax, %rbx
000000010000333c	movq	%rax, %rdi
000000010000333f	callq	_fwp_rc_share
0000000100003344	movq	%rbx, %rax
0000000100003347	addq	$0x8, %rsp
000000010000334b	popq	%rbx
000000010000334c	popq	%rbp
000000010000334d	retq
000000010000334e	nop
_e36:
0000000100003350	pushq	%rbp
0000000100003351	movq	%rsp, %rbp
0000000100003354	pushq	%rbx
0000000100003355	pushq	%rax
0000000100003356	movq	%rdi, %rbx
0000000100003359	movq	(%rdi), %rdi
000000010000335c	callq	_fwp_rc_share
0000000100003361	movq	0x8(%rbx), %rdi
0000000100003365	callq	_fwp_rc_share
000000010000336a	movq	(%rbx), %rdi
000000010000336d	movq	0x8(%rbx), %rsi
0000000100003371	leaq	_fwp_drop5(%rip), %rdx
0000000100003378	callq	_fwp_p_loop_own
000000010000337d	movq	%rax, %rbx
0000000100003380	movq	%rax, %rdi
0000000100003383	callq	_fwp_rc_share
0000000100003388	movq	%rbx, %rax
000000010000338b	addq	$0x8, %rsp
000000010000338f	popq	%rbx
0000000100003390	popq	%rbp
0000000100003391	retq
0000000100003392	nopw	%cs:(%rax,%rax)
_e37:
00000001000033a0	pushq	%rbp
00000001000033a1	movq	%rsp, %rbp
00000001000033a4	pushq	%rbx
00000001000033a5	pushq	%rax
00000001000033a6	movq	%rdi, %rbx
00000001000033a9	movq	(%rdi), %rdi
00000001000033ac	callq	_fwp_rc_share
00000001000033b1	movq	(%rbx), %rdi
00000001000033b4	callq	_f37
00000001000033b9	movq	%rax, %rbx
00000001000033bc	movq	%rax, %rdi
00000001000033bf	callq	_fwp_rc_share
00000001000033c4	movq	%rbx, %rax
00000001000033c7	addq	$0x8, %rsp
00000001000033cb	popq	%rbx
00000001000033cc	popq	%rbp
00000001000033cd	retq
00000001000033ce	nop
_e38:
00000001000033d0	pushq	%rbp
00000001000033d1	movq	%rsp, %rbp
00000001000033d4	pushq	%rbx
00000001000033d5	pushq	%rax
00000001000033d6	movq	%rdi, %rbx
00000001000033d9	movq	(%rdi), %rdi
00000001000033dc	callq	_fwp_rc_share
00000001000033e1	movq	0x8(%rbx), %rdi
00000001000033e5	callq	_fwp_rc_share
00000001000033ea	movq	(%rbx), %rdi
00000001000033ed	movq	0x8(%rbx), %rsi
00000001000033f1	leaq	_fwp_drop6(%rip), %rdx
00000001000033f8	callq	_fwp_p_loop_own
00000001000033fd	movq	%rax, %rbx
0000000100003400	movq	%rax, %rdi
0000000100003403	callq	_fwp_rc_share
0000000100003408	movq	%rbx, %rax
000000010000340b	addq	$0x8, %rsp
000000010000340f	popq	%rbx
0000000100003410	popq	%rbp
0000000100003411	retq
0000000100003412	nopw	%cs:(%rax,%rax)
_fwp_rc_share:
0000000100003420	pushq	%rbp
0000000100003421	movq	%rsp, %rbp
0000000100003424	pushq	%r15
0000000100003426	pushq	%r14
0000000100003428	pushq	%r13
000000010000342a	pushq	%r12
000000010000342c	pushq	%rbx
000000010000342d	subq	$0x208, %rsp                    ## imm = 0x208
0000000100003434	movq	0x10bf5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000343b	movq	(%rax), %rax
000000010000343e	movq	%rax, -0x30(%rbp)
0000000100003442	movq	%rdi, %rax
0000000100003445	subq	0x12bec(%rip), %rax
000000010000344c	movq	0x12c0d(%rip), %rcx
0000000100003453	shlq	$0x10, %rcx
0000000100003457	cmpq	%rcx, %rax
000000010000345a	jae	0x100003644
0000000100003460	movq	0x12c19(%rip), %rcx
0000000100003467	movq	%rax, %rdx
000000010000346a	shrq	$0x10, %rdx
000000010000346e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003475	leaq	(%rcx,%rdx), %rbx
0000000100003479	movzbl	(%rcx,%rdx), %ecx
000000010000347d	cmpb	$0x2, %cl
0000000100003480	setne	%dl
0000000100003483	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100003489	setne	%sil
000000010000348d	orb	%dl, %sil
0000000100003490	jne	0x10000349b
0000000100003492	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003499	jmp	0x1000034b9
000000010000349b	cmpb	$0x1, %cl
000000010000349e	jne	0x100003644
00000001000034a4	movl	0x20(%rbx), %ecx
00000001000034a7	imulq	%rcx, %rax
00000001000034ab	shrq	$0x20, %rax
00000001000034af	addq	%rax, %rbx
00000001000034b2	addq	$0x228, %rbx                    ## imm = 0x228
00000001000034b9	movzbl	(%rbx), %eax
00000001000034bc	testb	%al, %al
00000001000034be	je	0x100003644
00000001000034c4	cmpb	$-0x1, %al
00000001000034c6	je	0x100003666
00000001000034cc	movb	$0x0, (%rbx)
00000001000034cf	movq	%rdi, -0x230(%rbp)
00000001000034d6	movl	$0x1, %r14d
00000001000034dc	jmp	0x1000034e9
00000001000034de	nop
00000001000034e0	testq	%r14, %r14
00000001000034e3	je	0x100003644
00000001000034e9	movq	-0x238(%rbp,%r14,8), %r15
00000001000034f1	decq	%r14
00000001000034f4	movq	0x12b3d(%rip), %rax
00000001000034fb	movq	%r15, %rcx
00000001000034fe	subq	%rax, %rcx
0000000100003501	movq	%rcx, %rsi
0000000100003504	shrq	$0x10, %rsi
0000000100003508	movq	0x12b71(%rip), %rdx
000000010000350f	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100003516	cmpb	$0x1, 0x1(%rdx,%rsi)
000000010000351b	je	0x1000034e0
000000010000351d	addq	%rsi, %rdx
0000000100003520	movzbl	(%rdx), %esi
0000000100003523	cmpb	$0x2, %sil
0000000100003527	jne	0x100003530
0000000100003529	movq	0x18(%rdx), %r12
000000010000352d	jmp	0x10000355b
000000010000352f	nop
0000000100003530	movl	0x8(%rdx), %r12d
0000000100003534	cmpb	$0x1, %sil
0000000100003538	jne	0x10000355b
000000010000353a	movzwl	%r15w, %esi
000000010000353e	movl	0x20(%rdx), %r15d
0000000100003542	imulq	%rsi, %r15
0000000100003546	shrq	$0x20, %r15
000000010000354a	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100003551	addq	%rcx, %rax
0000000100003554	imulq	%r12, %r15
0000000100003558	addq	%rax, %r15
000000010000355b	cmpq	$0x8, %r12
000000010000355f	jb	0x1000034e0
0000000100003565	shrq	$0x3, %r12
0000000100003569	xorl	%r13d, %r13d
000000010000356c	jmp	0x10000358c
000000010000356e	callq	_fwp_rc_share
0000000100003573	nopw	%cs:(%rax,%rax)
0000000100003580	incq	%r13
0000000100003583	cmpq	%r13, %r12
0000000100003586	je	0x1000034e0
000000010000358c	movq	(%r15,%r13,8), %rdi
0000000100003590	movq	%rdi, %rax
0000000100003593	subq	0x12a9e(%rip), %rax
000000010000359a	movq	0x12abf(%rip), %rcx
00000001000035a1	shlq	$0x10, %rcx
00000001000035a5	cmpq	%rcx, %rax
00000001000035a8	jae	0x100003580
00000001000035aa	movq	0x12acf(%rip), %rcx
00000001000035b1	movq	%rax, %rdx
00000001000035b4	shrq	$0x10, %rdx
00000001000035b8	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000035bf	leaq	(%rcx,%rdx), %rbx
00000001000035c3	movzbl	(%rcx,%rdx), %ecx
00000001000035c7	cmpb	$0x2, %cl
00000001000035ca	setne	%dl
00000001000035cd	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000035d3	setne	%sil
00000001000035d7	orb	%dl, %sil
00000001000035da	jne	0x1000035f0
00000001000035dc	addq	$0x228, %rbx                    ## imm = 0x228
00000001000035e3	jmp	0x10000360a
00000001000035e5	nopw	%cs:(%rax,%rax)
00000001000035f0	cmpb	$0x1, %cl
00000001000035f3	jne	0x100003580
00000001000035f5	movl	0x20(%rbx), %ecx
00000001000035f8	imulq	%rcx, %rax
00000001000035fc	shrq	$0x20, %rax
0000000100003600	addq	%rax, %rbx
0000000100003603	addq	$0x228, %rbx                    ## imm = 0x228
000000010000360a	movzbl	(%rbx), %eax
000000010000360d	testb	%al, %al
000000010000360f	je	0x100003580
0000000100003615	cmpq	$0x3f, %r14
0000000100003619	ja	0x10000356e
000000010000361f	cmpb	$-0x1, %al
0000000100003621	je	0x10000363a
0000000100003623	movb	$0x0, (%rbx)
0000000100003626	movq	(%r15,%r13,8), %rax
000000010000362a	movq	%rax, -0x230(%rbp,%r14,8)
0000000100003632	incq	%r14
0000000100003635	jmp	0x100003580
000000010000363a	movq	%rbx, %rdi
000000010000363d	callq	_fwp_rc_forget_slot
0000000100003642	jmp	0x100003623
0000000100003644	movq	0x109e5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000364b	movq	(%rax), %rax
000000010000364e	cmpq	-0x30(%rbp), %rax
0000000100003652	jne	0x100003679
0000000100003654	addq	$0x208, %rsp                    ## imm = 0x208
000000010000365b	popq	%rbx
000000010000365c	popq	%r12
000000010000365e	popq	%r13
0000000100003660	popq	%r14
0000000100003662	popq	%r15
0000000100003664	popq	%rbp
0000000100003665	retq
0000000100003666	movq	%rdi, %r14
0000000100003669	movq	%rbx, %rdi
000000010000366c	callq	_fwp_rc_forget_slot
0000000100003671	movq	%r14, %rdi
0000000100003674	jmp	0x1000034cc
0000000100003679	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000367e	nop
_fwp_rc_forget_slot:
0000000100003680	pushq	%rbp
0000000100003681	movq	%rsp, %rbp
0000000100003684	cmpb	$-0x1, (%rdi)
0000000100003687	je	0x10000368b
0000000100003689	popq	%rbp
000000010000368a	retq
000000010000368b	movq	%rdi, %rax
000000010000368e	shrq	$0x11, %rax
0000000100003692	xorl	%edi, %eax
0000000100003694	movl	%eax, %ecx
0000000100003696	shrl	$0x9, %ecx
0000000100003699	xorl	%eax, %ecx
000000010000369b	movzbl	%cl, %ecx
000000010000369e	leaq	_fwp_gc(%rip), %rdx
00000001000036a5	movq	0x1218(%rdx,%rcx,8), %rax
00000001000036ad	testq	%rax, %rax
00000001000036b0	je	0x1000036fa
00000001000036b2	cmpq	%rdi, (%rax)
00000001000036b5	je	0x1000036d7
00000001000036b7	nopw	(%rax,%rax)
00000001000036c0	movq	%rax, %rcx
00000001000036c3	movq	0x10(%rax), %rax
00000001000036c7	testq	%rax, %rax
00000001000036ca	je	0x1000036fa
00000001000036cc	cmpq	%rdi, (%rax)
00000001000036cf	jne	0x1000036c0
00000001000036d1	addq	$0x10, %rcx
00000001000036d5	jmp	0x1000036e2
00000001000036d7	leaq	(%rdx,%rcx,8), %rcx
00000001000036db	addq	$0x1218, %rcx                   ## imm = 0x1218
00000001000036e2	movq	0x10(%rax), %rdx
00000001000036e6	movq	%rdx, (%rcx)
00000001000036e9	movq	%rax, %rdi
00000001000036ec	callq	0x100012082                     ## symbol stub for: _free
00000001000036f1	decq	0x13328(%rip)
00000001000036f8	popq	%rbp
00000001000036f9	retq
00000001000036fa	callq	_fwp_flush
00000001000036ff	movq	0x10932(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100003706	movq	(%rax), %rdi
0000000100003709	leaq	0xf10f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003710	leaq	0xf0e1(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100003717	xorl	%eax, %eax
0000000100003719	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000371e	movl	$0x65, %edi
0000000100003723	callq	0x100012058                     ## symbol stub for: _exit
0000000100003728	nopl	(%rax,%rax)
_fwp_flush:
0000000100003730	pushq	%rbp
0000000100003731	movq	%rsp, %rbp
0000000100003734	movq	_fwp_prog_out(%rip), %rdi
000000010000373b	testq	%rdi, %rdi
000000010000373e	je	0x100003745
0000000100003740	callq	0x10001205e                     ## symbol stub for: _fflush
0000000100003745	movq	0x108fc(%rip), %rax             ## literal pool symbol address: ___stdoutp
000000010000374c	movq	(%rax), %rdi
000000010000374f	popq	%rbp
0000000100003750	jmp	0x10001205e                     ## symbol stub for: _fflush
0000000100003755	nopw	%cs:(%rax,%rax)
_fwp_drop0:
0000000100003760	pushq	%rbp
0000000100003761	movq	%rsp, %rbp
0000000100003764	pushq	%rbx
0000000100003765	pushq	%rax
0000000100003766	movq	%rdi, %rcx
0000000100003769	subq	0x128c8(%rip), %rcx
0000000100003770	movq	0x128e9(%rip), %rax
0000000100003777	shlq	$0x10, %rax
000000010000377b	cmpq	%rax, %rcx
000000010000377e	jae	0x100003823
0000000100003784	movq	0x128f5(%rip), %rdx
000000010000378b	movq	%rcx, %rax
000000010000378e	shrq	$0x10, %rax
0000000100003792	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100003799	leaq	(%rdx,%rsi), %rax
000000010000379d	movzbl	(%rdx,%rsi), %edx
00000001000037a1	cmpb	$0x2, %dl
00000001000037a4	setne	%sil
00000001000037a8	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000037af	setne	%r8b
00000001000037b3	orb	%sil, %r8b
00000001000037b6	jne	0x1000037c0
00000001000037b8	addq	$0x228, %rax                    ## imm = 0x228
00000001000037be	jmp	0x1000037d9
00000001000037c0	cmpb	$0x1, %dl
00000001000037c3	jne	0x100003823
00000001000037c5	movl	0x20(%rax), %edx
00000001000037c8	imulq	%rdx, %rcx
00000001000037cc	shrq	$0x20, %rcx
00000001000037d0	addq	%rcx, %rax
00000001000037d3	addq	$0x228, %rax                    ## imm = 0x228
00000001000037d9	movzbl	(%rax), %ecx
00000001000037dc	testl	%ecx, %ecx
00000001000037de	je	0x100003823
00000001000037e0	cmpl	$0x1, %ecx
00000001000037e3	jne	0x100003817
00000001000037e5	cmpq	$0x0, (%rdi)
00000001000037e9	jns	0x10000382a
00000001000037eb	movq	0x8(%rdi), %rbx
00000001000037ef	callq	_fwp_rc_free_arr
00000001000037f4	movq	%rbx, %rcx
00000001000037f7	subq	0x1283a(%rip), %rcx
00000001000037fe	movq	0x1285b(%rip), %rax
0000000100003805	shlq	$0x10, %rax
0000000100003809	movq	%rbx, %rdi
000000010000380c	cmpq	%rax, %rcx
000000010000380f	jb	0x100003784
0000000100003815	jmp	0x100003823
0000000100003817	cmpl	$0xff, %ecx
000000010000381d	je	0x100003835
000000010000381f	decb	%cl
0000000100003821	movb	%cl, (%rax)
0000000100003823	addq	$0x8, %rsp
0000000100003827	popq	%rbx
0000000100003828	popq	%rbp
0000000100003829	retq
000000010000382a	addq	$0x8, %rsp
000000010000382e	popq	%rbx
000000010000382f	popq	%rbp
0000000100003830	jmp	_fwp_rc_free_arr
0000000100003835	movq	%rax, %rdi
0000000100003838	addq	$0x8, %rsp
000000010000383c	popq	%rbx
000000010000383d	popq	%rbp
000000010000383e	jmp	_fwp_rc_wide_drop
0000000100003843	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr:
0000000100003850	movq	%rdi, %rax
0000000100003853	subq	0x127de(%rip), %rax
000000010000385a	movq	0x127ff(%rip), %rcx
0000000100003861	shlq	$0x10, %rcx
0000000100003865	cmpq	%rcx, %rax
0000000100003868	jae	0x100003935
000000010000386e	pushq	%rbp
000000010000386f	movq	%rsp, %rbp
0000000100003872	pushq	%rbx
0000000100003873	pushq	%rax
0000000100003874	movq	0x12805(%rip), %rdx
000000010000387b	movq	%rax, %rcx
000000010000387e	shrq	$0x10, %rcx
0000000100003882	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100003889	leaq	(%rdx,%rsi), %rcx
000000010000388d	movzbl	(%rdx,%rsi), %edx
0000000100003891	cmpb	$0x2, %dl
0000000100003894	setne	%sil
0000000100003898	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000389e	setne	%r8b
00000001000038a2	orb	%sil, %r8b
00000001000038a5	jne	0x1000038b5
00000001000038a7	addq	$0x228, %rcx                    ## imm = 0x228
00000001000038ae	cmpb	$0x1, (%rcx)
00000001000038b1	je	0x1000038d4
00000001000038b3	jmp	0x10000392f
00000001000038b5	cmpb	$0x1, %dl
00000001000038b8	jne	0x10000392f
00000001000038ba	movl	0x20(%rcx), %edx
00000001000038bd	imulq	%rdx, %rax
00000001000038c1	shrq	$0x20, %rax
00000001000038c5	addq	%rax, %rcx
00000001000038c8	addq	$0x228, %rcx                    ## imm = 0x228
00000001000038cf	cmpb	$0x1, (%rcx)
00000001000038d2	jne	0x10000392f
00000001000038d4	movl	_fwp_reuse_verify(%rip), %eax
00000001000038da	testl	%eax, %eax
00000001000038dc	js	0x1000038eb
00000001000038de	testl	%eax, %eax
00000001000038e0	je	0x100003904
00000001000038e2	movq	$0x0, (%rdi)
00000001000038e9	jmp	0x10000392f
00000001000038eb	leaq	-0xc(%rbp), %rax
00000001000038ef	movq	%rdi, %rbx
00000001000038f2	movq	%rax, %rdi
00000001000038f5	callq	_fwp_rc_free_arr.cold.1
00000001000038fa	movq	%rbx, %rdi
00000001000038fd	movl	-0xc(%rbp), %eax
0000000100003900	testl	%eax, %eax
0000000100003902	jne	0x1000038e2
0000000100003904	movq	_fwp_gc(%rip), %rbx
000000010000390b	callq	_fwp_mem_free
0000000100003910	movq	_fwp_gc(%rip), %rax
0000000100003917	subq	%rbx, %rax
000000010000391a	cvtsi2sd	%rax, %xmm0
000000010000391f	addsd	0x128e9(%rip), %xmm0
0000000100003927	movsd	%xmm0, 0x128e1(%rip)
000000010000392f	addq	$0x8, %rsp
0000000100003933	popq	%rbx
0000000100003934	popq	%rbp
0000000100003935	retq
0000000100003936	nopw	%cs:(%rax,%rax)
_fwp_rc_wide_drop:
0000000100003940	pushq	%rbp
0000000100003941	movq	%rsp, %rbp
0000000100003944	pushq	%rbx
0000000100003945	pushq	%rax
0000000100003946	movq	%rdi, %rax
0000000100003949	shrq	$0x11, %rax
000000010000394d	xorl	%edi, %eax
000000010000394f	movl	%eax, %ecx
0000000100003951	shrl	$0x9, %ecx
0000000100003954	xorl	%eax, %ecx
0000000100003956	movzbl	%cl, %eax
0000000100003959	leaq	_fwp_gc(%rip), %rcx
0000000100003960	movq	0x1218(%rcx,%rax,8), %rax
0000000100003968	testq	%rax, %rax
000000010000396b	je	0x10000397e
000000010000396d	nopl	(%rax)
0000000100003970	cmpq	%rdi, (%rax)
0000000100003973	je	0x1000039ac
0000000100003975	movq	0x10(%rax), %rax
0000000100003979	testq	%rax, %rax
000000010000397c	jne	0x100003970
000000010000397e	callq	_fwp_flush
0000000100003983	movq	0x106ae(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000398a	movq	(%rax), %rdi
000000010000398d	leaq	0xee8b(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003994	leaq	0xee5d(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
000000010000399b	xorl	%eax, %eax
000000010000399d	callq	0x10001206a                     ## symbol stub for: _fprintf
00000001000039a2	movl	$0x65, %edi
00000001000039a7	callq	0x100012058                     ## symbol stub for: _exit
00000001000039ac	movq	0x8(%rax), %rcx
00000001000039b0	decq	%rcx
00000001000039b3	movq	%rcx, 0x8(%rax)
00000001000039b7	cmpq	$0xfe, %rcx
00000001000039be	jne	0x1000039cb
00000001000039c0	movq	%rdi, %rbx
00000001000039c3	callq	_fwp_rc_forget_slot
00000001000039c8	movb	$-0x2, (%rbx)
00000001000039cb	addq	$0x8, %rsp
00000001000039cf	popq	%rbx
00000001000039d0	popq	%rbp
00000001000039d1	retq
00000001000039d2	nopw	%cs:(%rax,%rax)
_fwp_mem_free:
00000001000039e0	testq	%rdi, %rdi
00000001000039e3	je	0x100003bf5
00000001000039e9	movq	0x12648(%rip), %rax
00000001000039f0	movq	%rdi, %rcx
00000001000039f3	subq	%rax, %rcx
00000001000039f6	movq	0x12663(%rip), %rdx
00000001000039fd	shlq	$0x10, %rdx
0000000100003a01	cmpq	%rdx, %rcx
0000000100003a04	jae	0x100003bf5
0000000100003a0a	pushq	%rbp
0000000100003a0b	movq	%rsp, %rbp
0000000100003a0e	pushq	%r15
0000000100003a10	pushq	%r14
0000000100003a12	pushq	%r13
0000000100003a14	pushq	%r12
0000000100003a16	pushq	%rbx
0000000100003a17	pushq	%rax
0000000100003a18	movq	0x12661(%rip), %r14
0000000100003a1f	testq	%r14, %r14
0000000100003a22	je	0x100003be7
0000000100003a28	movq	%rcx, %rbx
0000000100003a2b	shrq	$0x10, %rbx
0000000100003a2f	imulq	$0x1228, %rbx, %r15             ## imm = 0x1228
0000000100003a36	addq	%r15, %r14
0000000100003a39	movzbl	(%r14), %edx
0000000100003a3d	cmpl	$0x2, %edx
0000000100003a40	je	0x100003aee
0000000100003a46	cmpl	$0x1, %edx
0000000100003a49	jne	0x100003be7
0000000100003a4f	movzbl	0x1(%r14), %eax
0000000100003a54	movzbl	0x2(%r14), %r8d
0000000100003a59	imulq	$0x3c0, %rax, %r9               ## imm = 0x3C0
0000000100003a60	movl	0x8(%r14), %esi
0000000100003a64	movzwl	%di, %eax
0000000100003a67	xorl	%edx, %edx
0000000100003a69	divl	%esi
0000000100003a6b	movq	$-0x2, %rdx
0000000100003a72	movl	%eax, %ecx
0000000100003a74	rolq	%cl, %rdx
0000000100003a77	leaq	_fwp_gc(%rip), %r15
0000000100003a7e	addq	%r9, %r15
0000000100003a81	movl	%eax, %ecx
0000000100003a83	shrl	$0x3, %ecx
0000000100003a86	andl	$0x1ff8, %ecx                   ## imm = 0x1FF8
0000000100003a8c	andq	%rdx, 0x28(%r14,%rcx)
0000000100003a91	leaq	(%r8,%r8,2), %r12
0000000100003a95	leaq	(%r14,%rax), %rbx
0000000100003a99	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003aa0	cmpb	$-0x1, 0x228(%r14,%rax)
0000000100003aa9	je	0x100003bf6
0000000100003aaf	leaq	(%r15,%r12,8), %r15
0000000100003ab3	addq	$0x8, %r15
0000000100003ab7	movb	$0x0, (%rbx)
0000000100003aba	cmpl	$0x0, 0x1254b(%rip)
0000000100003ac1	je	0x100003ad4
0000000100003ac3	movl	%esi, %esi
0000000100003ac5	movq	%rdi, %rbx
0000000100003ac8	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100003acd	movq	%rbx, %rdi
0000000100003ad0	movl	0x8(%r14), %esi
0000000100003ad4	movq	(%r15), %rax
0000000100003ad7	notq	%rax
0000000100003ada	movq	%rax, (%rdi)
0000000100003add	movq	%rdi, (%r15)
0000000100003ae0	movl	%esi, %eax
0000000100003ae2	addq	%rax, _fwp_gc(%rip)
0000000100003ae9	jmp	0x100003be7
0000000100003aee	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100003af5	addq	%rcx, %rax
0000000100003af8	cmpq	%rdi, %rax
0000000100003afb	jne	0x100003be7
0000000100003b01	movq	0x18(%r14), %rax
0000000100003b05	addq	%rax, _fwp_gc(%rip)
0000000100003b0c	movb	$0x0, 0x3(%r14)
0000000100003b11	cmpb	$-0x1, 0x228(%r14)
0000000100003b19	je	0x100003c0d
0000000100003b1f	movb	$0x0, 0x228(%r14)
0000000100003b27	movl	0x10(%r14), %eax
0000000100003b2b	testq	%rax, %rax
0000000100003b2e	je	0x100003bc0
0000000100003b34	movq	0x12545(%rip), %rcx
0000000100003b3b	movl	%eax, %edx
0000000100003b3d	andl	$0x3, %edx
0000000100003b40	cmpl	$0x4, %eax
0000000100003b43	jae	0x100003b49
0000000100003b45	xorl	%esi, %esi
0000000100003b47	jmp	0x100003b88
0000000100003b49	leaq	(%rcx,%r15), %rdi
0000000100003b4d	movl	%eax, %r8d
0000000100003b50	andl	$-0x4, %r8d
0000000100003b54	xorl	%esi, %esi
0000000100003b56	nopw	%cs:(%rax,%rax)
0000000100003b60	movb	$0x0, (%rdi)
0000000100003b63	movb	$0x0, 0x1228(%rdi)
0000000100003b6a	movb	$0x0, 0x2450(%rdi)
0000000100003b71	movb	$0x0, 0x3678(%rdi)
0000000100003b78	addq	$0x4, %rsi
0000000100003b7c	addq	$0x48a0, %rdi                   ## imm = 0x48A0
0000000100003b83	cmpq	%rsi, %r8
0000000100003b86	jne	0x100003b60
0000000100003b88	testq	%rdx, %rdx
0000000100003b8b	je	0x100003bc0
0000000100003b8d	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100003b94	addq	%r15, %rsi
0000000100003b97	addq	%rsi, %rcx
0000000100003b9a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003ba1	xorl	%esi, %esi
0000000100003ba3	nopw	%cs:(%rax,%rax)
0000000100003bb0	movb	$0x0, (%rcx,%rsi)
0000000100003bb4	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100003bbb	cmpq	%rsi, %rdx
0000000100003bbe	jne	0x100003bb0
0000000100003bc0	addq	%rax, 0x12621(%rip)
0000000100003bc7	cmpq	0x124aa(%rip), %rbx
0000000100003bce	jae	0x100003bd7
0000000100003bd0	movq	%rbx, 0x124a1(%rip)
0000000100003bd7	cmpq	0x12492(%rip), %rbx
0000000100003bde	jae	0x100003be7
0000000100003be0	movq	%rbx, 0x12489(%rip)
0000000100003be7	addq	$0x8, %rsp
0000000100003beb	popq	%rbx
0000000100003bec	popq	%r12
0000000100003bee	popq	%r13
0000000100003bf0	popq	%r14
0000000100003bf2	popq	%r15
0000000100003bf4	popq	%rbp
0000000100003bf5	retq
0000000100003bf6	movq	%rdi, %r13
0000000100003bf9	movq	%rbx, %rdi
0000000100003bfc	callq	_fwp_rc_forget_slot
0000000100003c01	movq	%r13, %rdi
0000000100003c04	movl	0x8(%r14), %esi
0000000100003c08	jmp	0x100003aaf
0000000100003c0d	leaq	0x228(%r14), %rdi
0000000100003c14	callq	_fwp_rc_forget_slot
0000000100003c19	jmp	0x100003b1f
0000000100003c1e	nop
_fwp_owner_release35:
0000000100003c20	pushq	%rbp
0000000100003c21	movq	%rsp, %rbp
0000000100003c24	movq	(%rdi), %rdi
0000000100003c27	popq	%rbp
0000000100003c28	jmp	_fwp_drop0
0000000100003c2d	nopl	(%rax)
_fwp_owner_release36:
0000000100003c30	pushq	%rbp
0000000100003c31	movq	%rsp, %rbp
0000000100003c34	movq	(%rdi), %rdi
0000000100003c37	popq	%rbp
0000000100003c38	jmp	_fwp_drop0
0000000100003c3d	nopl	(%rax)
_fwp_owner_release40:
0000000100003c40	pushq	%rbp
0000000100003c41	movq	%rsp, %rbp
0000000100003c44	movq	(%rdi), %rdi
0000000100003c47	popq	%rbp
0000000100003c48	jmp	_fwp_drop0
0000000100003c4d	nopl	(%rax)
_fwp_owner_release41:
0000000100003c50	pushq	%rbp
0000000100003c51	movq	%rsp, %rbp
0000000100003c54	movq	(%rdi), %rdi
0000000100003c57	popq	%rbp
0000000100003c58	jmp	_fwp_drop0
0000000100003c5d	nopl	(%rax)
_fwp_p_array_get_typed:
0000000100003c60	testq	%rdi, %rdi
0000000100003c63	js	0x100003ca3
0000000100003c65	movq	(%rsi), %rcx
0000000100003c68	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100003c72	andq	%rcx, %rax
0000000100003c75	cmpq	%rdi, %rax
0000000100003c78	jbe	0x100003ca3
0000000100003c7a	movl	$0x8, %eax
0000000100003c7f	testq	%rdx, %rdx
0000000100003c82	je	0x100003c98
0000000100003c84	movl	(%rdx), %r8d
0000000100003c87	cmpq	$0xa, %r8
0000000100003c8b	ja	0x100003c98
0000000100003c8d	leaq	0xe8d4(%rip), %rax
0000000100003c94	movq	(%rax,%r8,8), %rax
0000000100003c98	testq	%rcx, %rcx
0000000100003c9b	js	0x100003ca6
0000000100003c9d	leaq	0x8(%rsi), %rcx
0000000100003ca1	jmp	0x100003caa
0000000100003ca3	xorl	%eax, %eax
0000000100003ca5	retq
0000000100003ca6	movq	0x10(%rsi), %rcx
0000000100003caa	pushq	%rbp
0000000100003cab	movq	%rsp, %rbp
0000000100003cae	pushq	%r15
0000000100003cb0	pushq	%r14
0000000100003cb2	pushq	%rbx
0000000100003cb3	pushq	%rax
0000000100003cb4	imulq	%rax, %rdi
0000000100003cb8	cmpq	$0x1, %rax
0000000100003cbc	movq	%rsi, %r14
0000000100003cbf	je	0x100003ce0
0000000100003cc1	cmpq	$0x2, %rax
0000000100003cc5	je	0x100003cd3
0000000100003cc7	cmpq	$0x8, %rax
0000000100003ccb	jne	0x100003ced
0000000100003ccd	movq	(%rcx,%rdi), %rbx
0000000100003cd1	jmp	0x100003cfa
0000000100003cd3	cmpl	$0x1, (%rdx)
0000000100003cd6	movzwl	(%rcx,%rdi), %eax
0000000100003cda	movswq	%ax, %rbx
0000000100003cde	jmp	0x100003cf6
0000000100003ce0	cmpl	$0x0, (%rdx)
0000000100003ce3	movzbl	(%rcx,%rdi), %eax
0000000100003ce7	movsbq	%al, %rbx
0000000100003ceb	jmp	0x100003cf6
0000000100003ced	cmpl	$0x2, (%rdx)
0000000100003cf0	movl	(%rcx,%rdi), %eax
0000000100003cf3	movslq	%eax, %rbx
0000000100003cf6	cmovneq	%rax, %rbx
0000000100003cfa	movq	%rbx, -0x20(%rbp)
0000000100003cfe	movl	$0x10, %edi
0000000100003d03	callq	_fwp_alloc_init
0000000100003d08	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100003d12	movq	%rcx, (%rax)
0000000100003d15	movq	%rbx, 0x8(%rax)
0000000100003d19	leaq	-0x20(%rbp), %rcx
0000000100003d1d	movq	%rax, %rdx
0000000100003d20	subq	0x12311(%rip), %rdx
0000000100003d27	movq	0x12332(%rip), %rcx
0000000100003d2e	shlq	$0x10, %rcx
0000000100003d32	cmpq	%rcx, %rdx
0000000100003d35	movq	%r14, %rcx
0000000100003d38	jae	0x100003db3
0000000100003d3a	movq	0x1233f(%rip), %rsi
0000000100003d41	movq	%rdx, %rdi
0000000100003d44	shrq	$0x10, %rdi
0000000100003d48	imulq	$0x1228, %rdi, %rdi             ## imm = 0x1228
0000000100003d4f	leaq	(%rsi,%rdi), %rbx
0000000100003d53	movzbl	(%rsi,%rdi), %esi
0000000100003d57	cmpb	$0x2, %sil
0000000100003d5b	setne	%dil
0000000100003d5f	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100003d66	setne	%r8b
0000000100003d6a	orb	%dil, %r8b
0000000100003d6d	jne	0x100003d80
0000000100003d6f	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003d76	cmpb	$-0x1, (%rbx)
0000000100003d79	je	0x100003da0
0000000100003d7b	movb	$0x1, (%rbx)
0000000100003d7e	jmp	0x100003db3
0000000100003d80	cmpb	$0x1, %sil
0000000100003d84	jne	0x100003db3
0000000100003d86	movl	0x20(%rbx), %esi
0000000100003d89	imulq	%rsi, %rdx
0000000100003d8d	shrq	$0x20, %rdx
0000000100003d91	addq	%rdx, %rbx
0000000100003d94	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003d9b	cmpb	$-0x1, (%rbx)
0000000100003d9e	jne	0x100003d7b
0000000100003da0	movq	%rbx, %rdi
0000000100003da3	movq	%rax, %r15
0000000100003da6	callq	_fwp_rc_forget_slot
0000000100003dab	movq	%r15, %rax
0000000100003dae	movq	%r14, %rcx
0000000100003db1	jmp	0x100003d7b
0000000100003db3	addq	$0x8, %rsp
0000000100003db7	popq	%rbx
0000000100003db8	popq	%r14
0000000100003dba	popq	%r15
0000000100003dbc	popq	%rbp
0000000100003dbd	retq
0000000100003dbe	nop
_fwp_data:
0000000100003dc0	pushq	%rbp
0000000100003dc1	movq	%rsp, %rbp
0000000100003dc4	pushq	%r15
0000000100003dc6	pushq	%r14
0000000100003dc8	pushq	%r12
0000000100003dca	pushq	%rbx
0000000100003dcb	movl	%edi, %r14d
0000000100003dce	testl	%esi, %esi
0000000100003dd0	je	0x100003e72
0000000100003dd6	movq	%rdx, %rbx
0000000100003dd9	movl	%esi, %r15d
0000000100003ddc	leaq	0x8(,%r15,8), %rdi
0000000100003de4	movl	%esi, %r12d
0000000100003de7	callq	_fwp_alloc_init
0000000100003dec	movl	%r14d, (%rax)
0000000100003def	movl	%r12d, 0x4(%rax)
0000000100003df3	cmpl	$0x7, %r12d
0000000100003df7	jbe	0x100003e09
0000000100003df9	movq	%rax, %rcx
0000000100003dfc	subq	%rbx, %rcx
0000000100003dff	addq	$0x8, %rcx
0000000100003e03	cmpq	$0x20, %rcx
0000000100003e07	jae	0x100003e77
0000000100003e09	xorl	%ecx, %ecx
0000000100003e0b	movq	%r15, %rsi
0000000100003e0e	movq	%rcx, %rdx
0000000100003e11	andq	$0x3, %rsi
0000000100003e15	je	0x100003e31
0000000100003e17	movq	%rcx, %rdx
0000000100003e1a	nopw	(%rax,%rax)
0000000100003e20	movq	(%rbx,%rdx,8), %rdi
0000000100003e24	movq	%rdi, 0x8(%rax,%rdx,8)
0000000100003e29	incq	%rdx
0000000100003e2c	decq	%rsi
0000000100003e2f	jne	0x100003e20
0000000100003e31	subq	%r15, %rcx
0000000100003e34	cmpq	$-0x4, %rcx
0000000100003e38	ja	0x100003eb5
0000000100003e3a	nopw	(%rax,%rax)
0000000100003e40	movq	(%rbx,%rdx,8), %rcx
0000000100003e44	movq	%rcx, 0x8(%rax,%rdx,8)
0000000100003e49	movq	0x8(%rbx,%rdx,8), %rcx
0000000100003e4e	movq	%rcx, 0x10(%rax,%rdx,8)
0000000100003e53	movq	0x10(%rbx,%rdx,8), %rcx
0000000100003e58	movq	%rcx, 0x18(%rax,%rdx,8)
0000000100003e5d	movq	0x18(%rbx,%rdx,8), %rcx
0000000100003e62	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100003e67	addq	$0x4, %rdx
0000000100003e6b	cmpq	%rdx, %r15
0000000100003e6e	jne	0x100003e40
0000000100003e70	jmp	0x100003eb5
0000000100003e72	movl	%r14d, %eax
0000000100003e75	jmp	0x100003eb5
0000000100003e77	movl	%r15d, %ecx
0000000100003e7a	andl	$-0x4, %ecx
0000000100003e7d	leaq	(,%r15,8), %rdx
0000000100003e85	andq	$-0x20, %rdx
0000000100003e89	xorl	%esi, %esi
0000000100003e8b	nopl	(%rax,%rax)
0000000100003e90	movups	(%rbx,%rsi), %xmm0
0000000100003e94	movups	0x10(%rbx,%rsi), %xmm1
0000000100003e99	movups	%xmm0, 0x8(%rax,%rsi)
0000000100003e9e	movups	%xmm1, 0x18(%rax,%rsi)
0000000100003ea3	addq	$0x20, %rsi
0000000100003ea7	cmpq	%rsi, %rdx
0000000100003eaa	jne	0x100003e90
0000000100003eac	cmpl	%r15d, %ecx
0000000100003eaf	jne	0x100003e0b
0000000100003eb5	popq	%rbx
0000000100003eb6	popq	%r12
0000000100003eb8	popq	%r14
0000000100003eba	popq	%r15
0000000100003ebc	popq	%rbp
0000000100003ebd	retq
0000000100003ebe	nop
_fwp_alloc_init:
0000000100003ec0	pushq	%rbp
0000000100003ec1	movq	%rsp, %rbp
0000000100003ec4	pushq	%rbx
0000000100003ec5	pushq	%rax
0000000100003ec6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
0000000100003ecd	ja	0x100003fbd
0000000100003ed3	leaq	0xf(%rdi), %rdx
0000000100003ed7	shrq	$0x4, %rdx
0000000100003edb	leaq	_fwp_gc(%rip), %rax
0000000100003ee2	movzbl	0xbe8(%rdx,%rax), %ecx
0000000100003eea	movl	0xb48(%rax,%rcx,4), %esi
0000000100003ef1	movq	_fwp_gc(%rip), %r8
0000000100003ef8	movq	%r8, %r9
0000000100003efb	subq	%rsi, %r9
0000000100003efe	movq	%r9, _fwp_gc(%rip)
0000000100003f05	js	0x100003fbd
0000000100003f0b	leaq	(%rcx,%rcx,2), %r9
0000000100003f0f	leaq	(%rax,%r9,8), %r9
0000000100003f13	addq	$0x8, %r9
0000000100003f17	movq	(%r9), %rbx
0000000100003f1a	testq	%rbx, %rbx
0000000100003f1d	je	0x100003f54
0000000100003f1f	movq	(%rbx), %rax
0000000100003f22	notq	%rax
0000000100003f25	movq	%rax, (%r9)
0000000100003f28	andl	$0x7ff8, %edi                   ## imm = 0x7FF8
0000000100003f2e	cmpq	%rsi, %rdi
0000000100003f31	jae	0x100003fda
0000000100003f37	leaq	(%rbx,%rdi), %rax
0000000100003f3b	notq	%rdi
0000000100003f3e	addq	%rsi, %rdi
0000000100003f41	andq	$-0x8, %rdi
0000000100003f45	addq	$0x8, %rdi
0000000100003f49	movq	%rdi, %rsi
0000000100003f4c	movq	%rax, %rdi
0000000100003f4f	jmp	0x100003fd5
0000000100003f54	movq	0x8(%r9), %rbx
0000000100003f58	movq	0x10(%r9), %r10
0000000100003f5c	subq	%rbx, %r10
0000000100003f5f	cmpq	%rsi, %r10
0000000100003f62	jb	0x100003f8c
0000000100003f64	leaq	(%rbx,%rsi), %rcx
0000000100003f68	movq	%rcx, 0x8(%r9)
0000000100003f6c	testq	%rbx, %rbx
0000000100003f6f	jne	0x100003f28
0000000100003f71	movzbl	0xbe8(%rdx,%rax), %ecx
0000000100003f79	movl	0xb48(%rax,%rcx,4), %esi
0000000100003f80	subq	%rsi, %r8
0000000100003f83	movq	%r8, _fwp_gc(%rip)
0000000100003f8a	js	0x100003fbd
0000000100003f8c	leaq	(%rcx,%rcx,2), %rdx
0000000100003f90	leaq	(%rax,%rdx,8), %rcx
0000000100003f94	addq	$0x8, %rcx
0000000100003f98	movq	0x8(%rax,%rdx,8), %rbx
0000000100003f9d	testq	%rbx, %rbx
0000000100003fa0	je	0x100003fad
0000000100003fa2	movq	(%rbx), %rax
0000000100003fa5	notq	%rax
0000000100003fa8	movq	%rax, (%rcx)
0000000100003fab	jmp	0x100003fd2
0000000100003fad	movq	0x8(%rcx), %rbx
0000000100003fb1	movq	0x10(%rcx), %rax
0000000100003fb5	subq	%rbx, %rax
0000000100003fb8	cmpq	%rsi, %rax
0000000100003fbb	jae	0x100003fca
0000000100003fbd	xorl	%esi, %esi
0000000100003fbf	addq	$0x8, %rsp
0000000100003fc3	popq	%rbx
0000000100003fc4	popq	%rbp
0000000100003fc5	jmp	_fwp_gc_alloc_slow
0000000100003fca	leaq	(%rbx,%rsi), %rax
0000000100003fce	movq	%rax, 0x8(%rcx)
0000000100003fd2	movq	%rbx, %rdi
0000000100003fd5	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100003fda	movq	%rbx, %rax
0000000100003fdd	addq	$0x8, %rsp
0000000100003fe1	popq	%rbx
0000000100003fe2	popq	%rbp
0000000100003fe3	retq
0000000100003fe4	nopw	%cs:(%rax,%rax)
_fwp_gc_alloc_slow:
0000000100003ff0	pushq	%rbp
0000000100003ff1	movq	%rsp, %rbp
0000000100003ff4	pushq	%r15
0000000100003ff6	pushq	%r14
0000000100003ff8	pushq	%r13
0000000100003ffa	pushq	%r12
0000000100003ffc	pushq	%rbx
0000000100003ffd	pushq	%rax
0000000100003ffe	movl	%esi, %r14d
0000000100004001	movq	%rdi, %rbx
0000000100004004	cmpl	$0x0, 0x11fe9(%rip)
000000010000400b	je	0x10000402f
000000010000400d	cmpq	$0x4001, %rbx                   ## imm = 0x4001
0000000100004014	jb	0x10000403d
0000000100004016	movq	%rbx, %rdi
0000000100004019	movl	%r14d, %esi
000000010000401c	addq	$0x8, %rsp
0000000100004020	popq	%rbx
0000000100004021	popq	%r12
0000000100004023	popq	%r13
0000000100004025	popq	%r14
0000000100004027	popq	%r15
0000000100004029	popq	%rbp
000000010000402a	jmp	_fwp_gc_alloc_big
000000010000402f	callq	_fwp_gc_init
0000000100004034	cmpq	$0x4001, %rbx                   ## imm = 0x4001
000000010000403b	jae	0x100004016
000000010000403d	leaq	0xf(%rbx), %rax
0000000100004041	shrq	$0x4, %rax
0000000100004045	leaq	_fwp_gc(%rip), %r12
000000010000404c	movzbl	0xbe8(%rax,%r12), %r13d
0000000100004055	movl	0xb48(%r12,%r13,4), %r15d
000000010000405d	cmpq	$0x0, _fwp_gc(%rip)
0000000100004065	jns	0x10000406c
0000000100004067	callq	_fwp_gc_spent
000000010000406c	movl	%r14d, %eax
000000010000406f	imulq	$0x3c0, %rax, %rax              ## imm = 0x3C0
0000000100004076	addq	%rax, %r12
0000000100004079	leaq	(,%r13,2), %rax
0000000100004081	addq	%r13, %rax
0000000100004084	leaq	(%r12,%rax,8), %rdi
0000000100004088	addq	$0x8, %rdi
000000010000408c	movq	0x8(%r12,%rax,8), %r12
0000000100004091	testq	%r12, %r12
0000000100004094	je	0x1000040a2
0000000100004096	movq	(%r12), %rax
000000010000409a	notq	%rax
000000010000409d	movq	%rax, (%rdi)
00000001000040a0	jmp	0x1000040ca
00000001000040a2	movq	0x8(%rdi), %r12
00000001000040a6	movq	0x10(%rdi), %rax
00000001000040aa	subq	%r12, %rax
00000001000040ad	cmpq	%r15, %rax
00000001000040b0	jae	0x1000040c2
00000001000040b2	movl	%r13d, %esi
00000001000040b5	movl	%r14d, %edx
00000001000040b8	callq	_fwp_gc_refill
00000001000040bd	movq	%rax, %r12
00000001000040c0	jmp	0x1000040ca
00000001000040c2	leaq	(%r12,%r15), %rax
00000001000040c6	movq	%rax, 0x8(%rdi)
00000001000040ca	cmpl	$0x1, %r14d
00000001000040ce	cmoveq	%rbx, %r15
00000001000040d2	movq	%r12, %rdi
00000001000040d5	movq	%r15, %rsi
00000001000040d8	callq	0x100011ffe                     ## symbol stub for: ___bzero
00000001000040dd	movq	%r12, %rax
00000001000040e0	addq	$0x8, %rsp
00000001000040e4	popq	%rbx
00000001000040e5	popq	%r12
00000001000040e7	popq	%r13
00000001000040e9	popq	%r14
00000001000040eb	popq	%r15
00000001000040ed	popq	%rbp
00000001000040ee	retq
00000001000040ef	nop
_fwp_gc_init:
00000001000040f0	pushq	%rbp
00000001000040f1	movq	%rsp, %rbp
00000001000040f4	pushq	%r14
00000001000040f6	pushq	%rbx
00000001000040f7	movl	$0x1, 0x11ef3(%rip)
0000000100004101	movaps	0xe088(%rip), %xmm0
0000000100004108	movups	%xmm0, 0x11a41(%rip)
000000010000410f	movaps	0xe08a(%rip), %xmm0
0000000100004116	movups	%xmm0, 0x11a43(%rip)
000000010000411d	movaps	0xe08c(%rip), %xmm0
0000000100004124	movups	%xmm0, 0x11a45(%rip)
000000010000412b	movaps	0xe08e(%rip), %xmm0
0000000100004132	movups	%xmm0, 0x11a47(%rip)
0000000100004139	movaps	0xe090(%rip), %xmm0
0000000100004140	movups	%xmm0, 0x11a49(%rip)
0000000100004147	movaps	0xe092(%rip), %xmm0
000000010000414e	movups	%xmm0, 0x11a4b(%rip)
0000000100004155	movaps	0xe094(%rip), %xmm0
000000010000415c	movups	%xmm0, 0x11a4d(%rip)
0000000100004163	movaps	0xe096(%rip), %xmm0
000000010000416a	movups	%xmm0, 0x11a4f(%rip)
0000000100004171	movaps	0xe098(%rip), %xmm0
0000000100004178	movups	%xmm0, 0x11a51(%rip)
000000010000417f	movaps	0xe09a(%rip), %xmm0
0000000100004186	movups	%xmm0, 0x11a53(%rip)
000000010000418d	xorl	%ecx, %ecx
000000010000418f	leaq	_fwp_gc(%rip), %rax
0000000100004196	xorl	%edx, %edx
0000000100004198	nopl	(%rax,%rax)
00000001000041a0	movl	%edx, %esi
00000001000041a2	shll	$0x4, %esi
00000001000041a5	decq	%rcx
00000001000041a8	movq	%rcx, %rdi
00000001000041ab	nopl	(%rax,%rax)
00000001000041b0	movq	%rdi, %rcx
00000001000041b3	incq	%rdi
00000001000041b6	cmpl	0xb4c(%rax,%rcx,4), %esi
00000001000041bd	ja	0x1000041b0
00000001000041bf	movb	%dil, 0xbe8(%rdx,%rax)
00000001000041c7	cmpq	$0x400, %rdx                    ## imm = 0x400
00000001000041ce	je	0x1000041fd
00000001000041d0	movq	%rdx, %rsi
00000001000041d3	orq	$0x1, %rsi
00000001000041d7	movl	%esi, %edi
00000001000041d9	shll	$0x4, %edi
00000001000041dc	nopl	(%rax)
00000001000041e0	movq	%rcx, %r8
00000001000041e3	incq	%rcx
00000001000041e6	cmpl	0xb4c(%rax,%r8,4), %edi
00000001000041ee	ja	0x1000041e0
00000001000041f0	movb	%cl, 0xbe8(%rsi,%rax)
00000001000041f7	addq	$0x2, %rdx
00000001000041fb	jmp	0x1000041a0
00000001000041fd	movabsq	$0x1000000000, %rbx             ## imm = 0x1000000000
0000000100004207	leaq	0x10000(%rbx), %rsi
000000010000420e	xorl	%edi, %edi
0000000100004210	xorl	%edx, %edx
0000000100004212	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004217	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
000000010000421d	xorl	%r9d, %r9d
0000000100004220	callq	0x1000120ca                     ## symbol stub for: _mmap
0000000100004225	cmpq	$-0x1, %rax
0000000100004229	jne	0x10000428b
000000010000422b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100004235	leaq	0x10000(%rbx), %rsi
000000010000423c	xorl	%edi, %edi
000000010000423e	xorl	%edx, %edx
0000000100004240	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004245	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
000000010000424b	xorl	%r9d, %r9d
000000010000424e	callq	0x1000120ca                     ## symbol stub for: _mmap
0000000100004253	cmpq	$-0x1, %rax
0000000100004257	jne	0x10000428b
0000000100004259	movabsq	$__mh_execute_header, %rbx
0000000100004263	leaq	0x10000(%rbx), %rsi
000000010000426a	xorl	%edi, %edi
000000010000426c	xorl	%edx, %edx
000000010000426e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004273	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004279	xorl	%r9d, %r9d
000000010000427c	callq	0x1000120ca                     ## symbol stub for: _mmap
0000000100004281	cmpq	$-0x1, %rax
0000000100004285	je	0x10000443d
000000010000428b	testq	%rax, %rax
000000010000428e	je	0x10000449e
0000000100004294	movq	%rax, 0x11da5(%rip)
000000010000429b	movq	%rbx, %rcx
000000010000429e	orq	$0x10000, %rcx                  ## imm = 0x10000
00000001000042a5	movq	%rcx, 0x11d9c(%rip)
00000001000042ac	addq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000042b2	andq	$-0x10000, %rax                 ## imm = 0xFFFF0000
00000001000042b8	movq	%rax, 0x11d79(%rip)
00000001000042bf	shrq	$0x10, %rbx
00000001000042c3	movq	%rbx, 0x11d8e(%rip)
00000001000042ca	imulq	$0x1228, %rbx, %rsi             ## imm = 0x1228
00000001000042d1	movq	%rsi, 0x11db0(%rip)
00000001000042d8	xorl	%edi, %edi
00000001000042da	xorl	%edx, %edx
00000001000042dc	movl	$0x1042, %ecx                   ## imm = 0x1042
00000001000042e1	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
00000001000042e7	xorl	%r9d, %r9d
00000001000042ea	callq	0x1000120ca                     ## symbol stub for: _mmap
00000001000042ef	cmpq	$-0x1, %rax
00000001000042f3	je	0x10000449e
00000001000042f9	movq	%rax, 0x11d80(%rip)
0000000100004300	leaq	0xe55f(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100004307	callq	0x10001208e                     ## symbol stub for: _getenv
000000010000430c	movl	$0x1, %r14d
0000000100004312	testq	%rax, %rax
0000000100004315	je	0x100004342
0000000100004317	movq	%rax, %rbx
000000010000431a	leaq	0xe54c(%rip), %rsi              ## literal pool for: "off"
0000000100004321	movq	%rax, %rdi
0000000100004324	callq	0x100012130                     ## symbol stub for: _strcmp
0000000100004329	testl	%eax, %eax
000000010000432b	je	0x10000433f
000000010000432d	cmpb	$0x30, (%rbx)
0000000100004330	jne	0x100004342
0000000100004332	xorl	%r14d, %r14d
0000000100004335	cmpb	$0x0, 0x1(%rbx)
0000000100004339	setne	%r14b
000000010000433d	jmp	0x100004342
000000010000433f	xorl	%r14d, %r14d
0000000100004342	movl	%r14d, 0x11caf(%rip)
0000000100004349	leaq	0xe521(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100004350	callq	0x10001208e                     ## symbol stub for: _getenv
0000000100004355	testq	%rax, %rax
0000000100004358	je	0x100004371
000000010000435a	movzbl	(%rax), %ecx
000000010000435d	testl	%ecx, %ecx
000000010000435f	je	0x10000437a
0000000100004361	cmpl	$0x30, %ecx
0000000100004364	jne	0x100004375
0000000100004366	xorl	%ecx, %ecx
0000000100004368	cmpb	$0x0, 0x1(%rax)
000000010000436c	setne	%cl
000000010000436f	jmp	0x10000437a
0000000100004371	xorl	%ecx, %ecx
0000000100004373	jmp	0x10000437a
0000000100004375	movl	$0x1, %ecx
000000010000437a	movl	%ecx, 0x11c84(%rip)
0000000100004380	leaq	0xe4df(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100004387	callq	0x10001208e                     ## symbol stub for: _getenv
000000010000438c	testq	%rax, %rax
000000010000438f	je	0x1000043a9
0000000100004391	leaq	0xe4e6(%rip), %rsi              ## literal pool for: "full"
0000000100004398	movq	%rax, %rdi
000000010000439b	callq	0x100012130                     ## symbol stub for: _strcmp
00000001000043a0	xorl	%ecx, %ecx
00000001000043a2	testl	%eax, %eax
00000001000043a4	setne	%cl
00000001000043a7	jmp	0x1000043ae
00000001000043a9	movl	$0x1, %ecx
00000001000043ae	movl	%ecx, 0x11c54(%rip)
00000001000043b4	movl	$0x1, 0x11c52(%rip)
00000001000043be	leaq	0xe4be(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
00000001000043c5	callq	0x10001208e                     ## symbol stub for: _getenv
00000001000043ca	testq	%rax, %rax
00000001000043cd	je	0x1000043e6
00000001000043cf	movzbl	(%rax), %ecx
00000001000043d2	testl	%ecx, %ecx
00000001000043d4	je	0x1000043ef
00000001000043d6	cmpl	$0x30, %ecx
00000001000043d9	jne	0x1000043ea
00000001000043db	xorl	%ecx, %ecx
00000001000043dd	cmpb	$0x0, 0x1(%rax)
00000001000043e1	setne	%cl
00000001000043e4	jmp	0x1000043ef
00000001000043e6	xorl	%ecx, %ecx
00000001000043e8	jmp	0x1000043ef
00000001000043ea	movl	$0x1, %ecx
00000001000043ef	movl	%ecx, 0x11c17(%rip)
00000001000043f5	leaq	0xe495(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
00000001000043fc	callq	0x10001208e                     ## symbol stub for: _getenv
0000000100004401	testq	%rax, %rax
0000000100004404	je	0x100004410
0000000100004406	movq	%rax, %rdi
0000000100004409	callq	0x10001204c                     ## symbol stub for: _atol
000000010000440e	jmp	0x100004412
0000000100004410	xorl	%eax, %eax
0000000100004412	xorl	%ecx, %ecx
0000000100004414	testq	%rax, %rax
0000000100004417	cmovgq	%rax, %rcx
000000010000441b	movq	%rcx, 0x11c06(%rip)
0000000100004422	movq	$0x800000, 0x11deb(%rip)        ## imm = 0x800000
000000010000442d	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
0000000100004438	popq	%rbx
0000000100004439	popq	%r14
000000010000443b	popq	%rbp
000000010000443c	retq
000000010000443d	movl	$0x40010000, %esi               ## imm = 0x40010000
0000000100004442	xorl	%edi, %edi
0000000100004444	xorl	%edx, %edx
0000000100004446	movl	$0x1042, %ecx                   ## imm = 0x1042
000000010000444b	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004451	xorl	%r9d, %r9d
0000000100004454	callq	0x1000120ca                     ## symbol stub for: _mmap
0000000100004459	cmpq	$-0x1, %rax
000000010000445d	je	0x10000446e
000000010000445f	testq	%rax, %rax
0000000100004462	je	0x10000449e
0000000100004464	movl	$0x40000000, %ebx               ## imm = 0x40000000
0000000100004469	jmp	0x100004294
000000010000446e	movl	$0x10010000, %esi               ## imm = 0x10010000
0000000100004473	xorl	%edi, %edi
0000000100004475	xorl	%edx, %edx
0000000100004477	movl	$0x1042, %ecx                   ## imm = 0x1042
000000010000447c	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004482	xorl	%r9d, %r9d
0000000100004485	callq	0x1000120ca                     ## symbol stub for: _mmap
000000010000448a	leaq	0x1(%rax), %rcx
000000010000448e	cmpq	$0x2, %rcx
0000000100004492	jb	0x10000449e
0000000100004494	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100004499	jmp	0x100004294
000000010000449e	movq	0xfb93(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000044a5	movq	(%rax), %rcx
00000001000044a8	leaq	0xe3f0(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000044af	movl	$0x13, %esi
00000001000044b4	movl	$0x1, %edx
00000001000044b9	callq	0x100012088                     ## symbol stub for: _fwrite
00000001000044be	movl	$0x66, %edi
00000001000044c3	callq	0x100012058                     ## symbol stub for: _exit
00000001000044c8	nopl	(%rax,%rax)
_fwp_gc_alloc_big:
00000001000044d0	pushq	%rbp
00000001000044d1	movq	%rsp, %rbp
00000001000044d4	pushq	%r15
00000001000044d6	pushq	%r14
00000001000044d8	pushq	%r13
00000001000044da	pushq	%r12
00000001000044dc	pushq	%rbx
00000001000044dd	pushq	%rax
00000001000044de	movabsq	$0x4000000000000001, %rax       ## imm = 0x4000000000000001
00000001000044e8	cmpq	%rax, %rdi
00000001000044eb	jae	0x100004697
00000001000044f1	movl	%esi, %r15d
00000001000044f4	movq	%rdi, %rbx
00000001000044f7	subq	%rdi, _fwp_gc(%rip)
00000001000044fe	jns	0x100004505
0000000100004500	callq	_fwp_gc_spent
0000000100004505	leaq	0xffff(%rbx), %r14
000000010000450c	shrq	$0x10, %r14
0000000100004510	movq	%r14, %rdi
0000000100004513	callq	_fwp_gc_chunks
0000000100004518	movq	0x11b61(%rip), %rcx
000000010000451f	imulq	$0x1228, %rax, %r12             ## imm = 0x1228
0000000100004526	movb	$0x2, (%rcx,%r12)
000000010000452b	movb	%r15b, 0x1(%rcx,%r12)
0000000100004530	movw	$0x100, 0x3(%rcx,%r12)          ## imm = 0x100
0000000100004538	movl	%r14d, 0x10(%rcx,%r12)
000000010000453d	movq	%rbx, 0x18(%rcx,%r12)
0000000100004542	leaq	(%rcx,%r12), %r15
0000000100004546	addq	$0x228, %r15                    ## imm = 0x228
000000010000454d	cmpb	$-0x1, 0x228(%rcx,%r12)
0000000100004556	je	0x100004684
000000010000455c	movb	$0x0, (%r15)
0000000100004560	cmpq	$0x10001, %rbx                  ## imm = 0x10001
0000000100004567	jb	0x100004659
000000010000456d	movq	0x11b0c(%rip), %rcx
0000000100004574	cmpq	$0x3, %r14
0000000100004578	movl	$0x2, %r8d
000000010000457e	cmovaeq	%r14, %r8
0000000100004582	leaq	-0x1(%r8), %rsi
0000000100004586	addq	$-0x2, %r8
000000010000458a	movl	%esi, %edx
000000010000458c	andl	$0x3, %edx
000000010000458f	movl	$0x1, %edi
0000000100004594	cmpq	$0x3, %r8
0000000100004598	jb	0x10000461b
000000010000459e	leaq	(%r12,%rcx), %r8
00000001000045a2	addq	$0x48b0, %r8                    ## imm = 0x48B0
00000001000045a9	andq	$-0x4, %rsi
00000001000045ad	negq	%rsi
00000001000045b0	movb	$0x3, -0x3688(%r8)
00000001000045b8	movb	$0x1, -0x3684(%r8)
00000001000045c0	movl	%eax, -0x3678(%r8)
00000001000045c7	movb	$0x3, -0x2460(%r8)
00000001000045cf	movb	$0x1, -0x245c(%r8)
00000001000045d7	movl	%eax, -0x2450(%r8)
00000001000045de	movb	$0x3, -0x1238(%r8)
00000001000045e6	movb	$0x1, -0x1234(%r8)
00000001000045ee	movl	%eax, -0x1228(%r8)
00000001000045f5	movb	$0x3, -0x10(%r8)
00000001000045fa	movb	$0x1, -0xc(%r8)
00000001000045ff	movl	%eax, (%r8)
0000000100004602	addq	$0x48a0, %r8                    ## imm = 0x48A0
0000000100004609	leaq	(%rsi,%rdi), %r9
000000010000460d	addq	$0x4, %r9
0000000100004611	addq	$0x4, %rdi
0000000100004615	cmpq	$0x1, %r9
0000000100004619	jne	0x1000045b0
000000010000461b	testq	%rdx, %rdx
000000010000461e	je	0x100004659
0000000100004620	imulq	$0x1228, %rdi, %rsi             ## imm = 0x1228
0000000100004627	addq	%rsi, %r12
000000010000462a	addq	%r12, %rcx
000000010000462d	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004634	xorl	%esi, %esi
0000000100004636	nopw	%cs:(%rax,%rax)
0000000100004640	movb	$0x3, (%rcx,%rsi)
0000000100004644	movb	$0x1, 0x4(%rcx,%rsi)
0000000100004649	movl	%eax, 0x10(%rcx,%rsi)
000000010000464d	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100004654	cmpq	%rsi, %rdx
0000000100004657	jne	0x100004640
0000000100004659	shlq	$0x10, %rax
000000010000465d	addq	0x119d4(%rip), %rax
0000000100004664	movq	%rax, %rdi
0000000100004667	movq	%rbx, %rsi
000000010000466a	movq	%rax, %rbx
000000010000466d	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100004672	movq	%rbx, %rax
0000000100004675	addq	$0x8, %rsp
0000000100004679	popq	%rbx
000000010000467a	popq	%r12
000000010000467c	popq	%r13
000000010000467e	popq	%r14
0000000100004680	popq	%r15
0000000100004682	popq	%rbp
0000000100004683	retq
0000000100004684	movq	%r15, %rdi
0000000100004687	movq	%rax, %r13
000000010000468a	callq	_fwp_rc_forget_slot
000000010000468f	movq	%r13, %rax
0000000100004692	jmp	0x10000455c
0000000100004697	movq	0xf99a(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000469e	movq	(%rax), %rcx
00000001000046a1	leaq	0xe1f7(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000046a8	movl	$0x13, %esi
00000001000046ad	movl	$0x1, %edx
00000001000046b2	callq	0x100012088                     ## symbol stub for: _fwrite
00000001000046b7	movl	$0x66, %edi
00000001000046bc	callq	0x100012058                     ## symbol stub for: _exit
00000001000046c1	nopw	%cs:(%rax,%rax)
_fwp_gc_spent:
00000001000046d0	pushq	%rbp
00000001000046d1	movq	%rsp, %rbp
00000001000046d4	cmpl	$0x0, 0x11919(%rip)
00000001000046db	jne	0x1000046e2
00000001000046dd	callq	_fwp_gc_init
00000001000046e2	movl	0x11914(%rip), %ecx
00000001000046e8	testl	%ecx, %ecx
00000001000046ea	setne	%dl
00000001000046ed	movq	0x11934(%rip), %rax
00000001000046f4	testq	%rax, %rax
00000001000046f7	setne	%sil
00000001000046fb	andb	%dl, %sil
00000001000046fe	cmpb	$0x1, %sil
0000000100004702	jne	0x100004765
0000000100004704	movq	0x11925(%rip), %rcx
000000010000470b	incq	%rcx
000000010000470e	movq	%rcx, 0x1191b(%rip)
0000000100004715	cmpq	%rax, %rcx
0000000100004718	jl	0x10000472a
000000010000471a	movq	$0x0, 0x1190b(%rip)
0000000100004725	callq	_fwp_gc_collect
000000010000472a	movq	0x11ae7(%rip), %rax
0000000100004731	subq	_fwp_gc(%rip), %rax
0000000100004738	cvtsi2sd	%rax, %xmm0
000000010000473d	addsd	0x11aab(%rip), %xmm0
0000000100004745	movsd	%xmm0, 0x11aa3(%rip)
000000010000474d	movq	$0x0, 0x11ac0(%rip)
0000000100004758	movq	$0x0, _fwp_gc(%rip)
0000000100004763	popq	%rbp
0000000100004764	retq
0000000100004765	testl	%ecx, %ecx
0000000100004767	je	0x10000476f
0000000100004769	popq	%rbp
000000010000476a	jmp	_fwp_gc_collect
000000010000476f	movq	0x11aa2(%rip), %rax
0000000100004776	subq	_fwp_gc(%rip), %rax
000000010000477d	cvtsi2sd	%rax, %xmm0
0000000100004782	addsd	0x11a66(%rip), %xmm0
000000010000478a	movsd	%xmm0, 0x11a5e(%rip)
0000000100004792	movq	$0x800000, 0x11a7b(%rip)        ## imm = 0x800000
000000010000479d	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
00000001000047a8	popq	%rbp
00000001000047a9	retq
00000001000047aa	nopw	(%rax,%rax)
_fwp_gc_refill:
00000001000047b0	pushq	%rbp
00000001000047b1	movq	%rsp, %rbp
00000001000047b4	pushq	%r15
00000001000047b6	pushq	%r14
00000001000047b8	pushq	%r13
00000001000047ba	pushq	%r12
00000001000047bc	pushq	%rbx
00000001000047bd	pushq	%rax
00000001000047be	movl	%edx, %r15d
00000001000047c1	movl	%esi, %r12d
00000001000047c4	movq	%rdi, %rbx
00000001000047c7	movl	$0x1, %edi
00000001000047cc	callq	_fwp_gc_chunks
00000001000047d1	movq	%rax, %r14
00000001000047d4	leaq	_fwp_gc(%rip), %rax
00000001000047db	movq	0x1189e(%rip), %rsi
00000001000047e2	imulq	$0x1228, %r14, %rdi             ## imm = 0x1228
00000001000047e9	leaq	(%rsi,%rdi), %r13
00000001000047ed	movb	$0x1, (%rsi,%rdi)
00000001000047f1	movb	%r15b, 0x1(%rsi,%rdi)
00000001000047f6	movb	%r12b, 0x2(%rsi,%rdi)
00000001000047fb	movb	$0x1, 0x4(%rsi,%rdi)
0000000100004800	movl	%r12d, %ecx
0000000100004803	movl	0xb48(%rax,%rcx,4), %ecx
000000010000480a	movl	%ecx, 0x8(%rsi,%rdi)
000000010000480e	movl	$0x10000, %eax                  ## imm = 0x10000
0000000100004813	xorl	%edx, %edx
0000000100004815	divl	%ecx
0000000100004817	movl	%eax, 0xc(%rsi,%rdi)
000000010000481b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100004820	addq	%rcx, %rax
0000000100004823	btq	$0x20, %rax
0000000100004828	jae	0x100004831
000000010000482a	xorl	%edx, %edx
000000010000482c	divq	%rcx
000000010000482f	jmp	0x100004835
0000000100004831	xorl	%edx, %edx
0000000100004833	divl	%ecx
0000000100004835	movl	%eax, 0x20(%r13)
0000000100004839	cmpq	$0x0, 0x121df(%rip)
0000000100004841	je	0x10000486e
0000000100004843	leaq	0x228(%r13), %r15
000000010000484a	xorl	%r12d, %r12d
000000010000484d	jmp	0x10000485c
000000010000484f	nop
0000000100004850	incq	%r12
0000000100004853	cmpq	$0x1000, %r12                   ## imm = 0x1000
000000010000485a	je	0x10000486e
000000010000485c	cmpb	$-0x1, (%r15,%r12)
0000000100004861	jne	0x100004850
0000000100004863	leaq	(%r15,%r12), %rdi
0000000100004867	callq	_fwp_rc_forget_slot
000000010000486c	jmp	0x100004850
000000010000486e	leaq	0x228(%r13), %rdi
0000000100004875	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000487a	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000487f	shlq	$0x10, %r14
0000000100004883	addq	0x117ae(%rip), %r14
000000010000488a	cmpl	$0x0, 0x1177b(%rip)
0000000100004891	je	0x1000048a0
0000000100004893	movl	$0x10000, %esi                  ## imm = 0x10000
0000000100004898	movq	%r14, %rdi
000000010000489b	callq	0x100011ffe                     ## symbol stub for: ___bzero
00000001000048a0	movl	0x8(%r13), %eax
00000001000048a4	leaq	(%r14,%rax), %rcx
00000001000048a8	movq	%rcx, 0x8(%rbx)
00000001000048ac	movl	0xc(%r13), %ecx
00000001000048b0	imulq	%rax, %rcx
00000001000048b4	addq	%r14, %rcx
00000001000048b7	movq	%rcx, 0x10(%rbx)
00000001000048bb	movq	%r14, %rax
00000001000048be	addq	$0x8, %rsp
00000001000048c2	popq	%rbx
00000001000048c3	popq	%r12
00000001000048c5	popq	%r13
00000001000048c7	popq	%r14
00000001000048c9	popq	%r15
00000001000048cb	popq	%rbp
00000001000048cc	retq
00000001000048cd	nopl	(%rax)
_fwp_gc_chunks:
00000001000048d0	pushq	%rbp
00000001000048d1	movq	%rsp, %rbp
00000001000048d4	pushq	%r15
00000001000048d6	pushq	%r14
00000001000048d8	pushq	%rbx
00000001000048d9	pushq	%rax
00000001000048da	movq	%rdi, %rbx
00000001000048dd	xorl	%edx, %edx
00000001000048df	cmpq	$0x1, %rdi
00000001000048e3	setne	%dl
00000001000048e6	leaq	_fwp_gc(%rip), %rcx
00000001000048ed	movq	0x1068(%rcx,%rdx,8), %rax
00000001000048f5	movq	0x11764(%rip), %r14
00000001000048fc	movq	%rax, %rdi
00000001000048ff	subq	%r14, %rdi
0000000100004902	jae	0x100004972
0000000100004904	leaq	0x1068(,%rdx,8), %rsi
000000010000490c	imulq	$0x1228, %rax, %r8              ## imm = 0x1228
0000000100004913	addq	0x11766(%rip), %r8
000000010000491a	xorl	%edx, %edx
000000010000491c	xorl	%r9d, %r9d
000000010000491f	jmp	0x100004942
0000000100004921	nopw	%cs:(%rax,%rax)
0000000100004930	xorl	%r9d, %r9d
0000000100004933	decq	%rdx
0000000100004936	addq	$0x1228, %r8                    ## imm = 0x1228
000000010000493d	cmpq	%rdx, %rdi
0000000100004940	je	0x100004975
0000000100004942	cmpb	$0x0, (%r8)
0000000100004946	jne	0x100004930
0000000100004948	incq	%r9
000000010000494b	cmpq	%rbx, %r9
000000010000494e	jne	0x100004933
0000000100004950	incq	%rax
0000000100004953	movq	%rax, %rdi
0000000100004956	subq	%rdx, %rdi
0000000100004959	movq	%rdi, (%rsi,%rcx)
000000010000495d	subq	%rbx, 0x11884(%rip)
0000000100004964	subq	%rbx, %rax
0000000100004967	subq	%rdx, %rax
000000010000496a	movq	%rax, %r14
000000010000496d	jmp	0x100004a3c
0000000100004972	xorl	%r9d, %r9d
0000000100004975	subq	%r9, 0x1186c(%rip)
000000010000497c	subq	%r9, %r14
000000010000497f	addq	%r14, %rbx
0000000100004982	movq	0x116df(%rip), %rdi
0000000100004989	cmpq	%rbx, %rdi
000000010000498c	jae	0x100004a21
0000000100004992	movq	0x116bf(%rip), %r15
0000000100004999	cmpq	%rbx, %r15
000000010000499c	jb	0x100004a4a
00000001000049a2	leaq	0x40(%rbx), %rax
00000001000049a6	cmpq	%r15, %rax
00000001000049a9	cmovbq	%rax, %r15
00000001000049ad	movq	%r15, %rsi
00000001000049b0	subq	%rdi, %rsi
00000001000049b3	shlq	$0x10, %rdi
00000001000049b7	addq	0x1167a(%rip), %rdi
00000001000049be	shlq	$0x10, %rsi
00000001000049c2	movl	$0x3, %edx
00000001000049c7	callq	0x1000120d0                     ## symbol stub for: _mprotect
00000001000049cc	testl	%eax, %eax
00000001000049ce	jne	0x100004a4a
00000001000049d0	movl	$0x1d, %edi
00000001000049d5	callq	0x100012160                     ## symbol stub for: _sysconf
00000001000049da	movq	0x1169f(%rip), %rcx
00000001000049e1	imulq	$0x1228, 0x1167c(%rip), %rdi    ## imm = 0x1228
00000001000049ec	addq	%rcx, %rdi
00000001000049ef	imulq	$0x1228, %r15, %rdx             ## imm = 0x1228
00000001000049f6	addq	%rcx, %rdx
00000001000049f9	leaq	(%rax,%rdx), %rsi
00000001000049fd	decq	%rsi
0000000100004a00	negq	%rax
0000000100004a03	andq	%rax, %rdi
0000000100004a06	andq	%rax, %rsi
0000000100004a09	subq	%rdi, %rsi
0000000100004a0c	movl	$0x3, %edx
0000000100004a11	callq	0x1000120d0                     ## symbol stub for: _mprotect
0000000100004a16	testl	%eax, %eax
0000000100004a18	jne	0x100004a4a
0000000100004a1a	movq	%r15, 0x11647(%rip)
0000000100004a21	movq	%rbx, 0x11638(%rip)
0000000100004a28	shlq	$0x10, %rbx
0000000100004a2c	cmpq	0x1161d(%rip), %rbx
0000000100004a33	jbe	0x100004a3c
0000000100004a35	movq	%rbx, 0x11614(%rip)
0000000100004a3c	movq	%r14, %rax
0000000100004a3f	addq	$0x8, %rsp
0000000100004a43	popq	%rbx
0000000100004a44	popq	%r14
0000000100004a46	popq	%r15
0000000100004a48	popq	%rbp
0000000100004a49	retq
0000000100004a4a	movq	0xf5e7(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004a51	movq	(%rax), %rcx
0000000100004a54	leaq	0xde44(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004a5b	movl	$0x13, %esi
0000000100004a60	movl	$0x1, %edx
0000000100004a65	callq	0x100012088                     ## symbol stub for: _fwrite
0000000100004a6a	movl	$0x66, %edi
0000000100004a6f	callq	0x100012058                     ## symbol stub for: _exit
0000000100004a74	nopw	%cs:(%rax,%rax)
_fwp_gc_collect:
0000000100004a80	pushq	%rbp
0000000100004a81	movq	%rsp, %rbp
0000000100004a84	pushq	%r15
0000000100004a86	pushq	%r14
0000000100004a88	pushq	%r13
0000000100004a8a	pushq	%r12
0000000100004a8c	pushq	%rbx
0000000100004a8d	subq	$0x168, %rsp                    ## imm = 0x168
0000000100004a94	movq	0xf595(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100004a9b	movq	(%rax), %rax
0000000100004a9e	movq	%rax, -0x30(%rbp)
0000000100004aa2	cmpl	$0x0, 0x11557(%rip)
0000000100004aa9	jne	0x100004f67
0000000100004aaf	movl	$0x1, 0x11547(%rip)
0000000100004ab9	leaq	-0x170(%rbp), %rsi
0000000100004ac0	movl	$0x6, %edi
0000000100004ac5	callq	0x100012052                     ## symbol stub for: _clock_gettime
0000000100004aca	movq	0x11747(%rip), %rax
0000000100004ad1	subq	_fwp_gc(%rip), %rax
0000000100004ad8	cvtsi2sd	%rax, %xmm0
0000000100004add	addsd	0x1170b(%rip), %xmm0
0000000100004ae5	movsd	%xmm0, 0x11703(%rip)
0000000100004aed	cmpl	$0x0, 0x11514(%rip)
0000000100004af4	sete	%al
0000000100004af7	cmpl	$0x0, 0x11512(%rip)
0000000100004afe	setne	%r15b
0000000100004b02	orb	%al, %r15b
0000000100004b05	cmpb	$0x1, %r15b
0000000100004b09	jne	0x100004b9b
0000000100004b0f	movq	0x1154a(%rip), %rax
0000000100004b16	testq	%rax, %rax
0000000100004b19	je	0x100004ce6
0000000100004b1f	movq	0x1155a(%rip), %rdx
0000000100004b26	xorl	%ecx, %ecx
0000000100004b28	movl	%ecx, %r14d
0000000100004b2b	movq	%r14, %rbx
0000000100004b2e	movq	%rax, %rcx
0000000100004b31	movq	%rdx, %rax
0000000100004b34	jmp	0x100004b5f
0000000100004b36	nopw	%cs:(%rax,%rax)
0000000100004b40	movb	$0x0, 0x3(%rax,%r14)
0000000100004b46	movq	%rbx, %rsi
0000000100004b49	incq	%rsi
0000000100004b4c	addq	$0x1228, %r14                   ## imm = 0x1228
0000000100004b53	movq	%rsi, %rbx
0000000100004b56	cmpq	%rcx, %rsi
0000000100004b59	jae	0x100004ce6
0000000100004b5f	movzbl	(%rax,%r14), %edx
0000000100004b64	cmpl	$0x2, %edx
0000000100004b67	je	0x100004b40
0000000100004b69	cmpl	$0x1, %edx
0000000100004b6c	jne	0x100004b46
0000000100004b6e	leaq	(%rax,%r14), %rdi
0000000100004b72	addq	$0x28, %rdi
0000000100004b76	movl	0xc(%rax,%r14), %eax
0000000100004b7b	addl	$0x3f, %eax
0000000100004b7e	shrl	$0x3, %eax
0000000100004b81	andl	$-0x8, %eax
0000000100004b84	movl	%eax, %esi
0000000100004b86	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100004b8b	movq	0x114ee(%rip), %rax
0000000100004b92	movq	0x114c7(%rip), %rcx
0000000100004b99	jmp	0x100004b46
0000000100004b9b	movb	%r15b, -0xd1(%rbp)
0000000100004ba2	leaq	-0xd0(%rbp), %rdi
0000000100004ba9	callq	0x100012100                     ## symbol stub for: _setjmp
0000000100004bae	movq	$0x0, 0x1164f(%rip)
0000000100004bb9	callq	_fwp_gc_mark_all
0000000100004bbe	cmpq	$0x0, 0x1149a(%rip)
0000000100004bc6	je	0x100004d22
0000000100004bcc	xorl	%eax, %eax
0000000100004bce	jmp	0x100004bea
0000000100004bd0	movq	-0xe8(%rbp), %rcx
0000000100004bd7	incq	%rcx
0000000100004bda	movq	%rcx, %rax
0000000100004bdd	cmpq	0x1147c(%rip), %rcx
0000000100004be4	jae	0x100004d22
0000000100004bea	movq	0x1148f(%rip), %r15
0000000100004bf1	movq	%rax, -0xe8(%rbp)
0000000100004bf8	imulq	$0x1228, %rax, %rax             ## imm = 0x1228
0000000100004bff	cmpb	$0x2, 0x1(%r15,%rax)
0000000100004c05	jne	0x100004bd0
0000000100004c07	addq	%rax, %r15
0000000100004c0a	movzbl	(%r15), %eax
0000000100004c0e	cmpl	$0x2, %eax
0000000100004c11	je	0x100004cbb
0000000100004c17	cmpl	$0x1, %eax
0000000100004c1a	jne	0x100004bd0
0000000100004c1c	movl	0xc(%r15), %eax
0000000100004c20	addl	$0x3f, %eax
0000000100004c23	cmpl	$0x40, %eax
0000000100004c26	jb	0x100004bd0
0000000100004c28	movq	-0xe8(%rbp), %r12
0000000100004c2f	shlq	$0x10, %r12
0000000100004c33	addq	0x113fe(%rip), %r12
0000000100004c3a	shrl	$0x6, %eax
0000000100004c3d	movq	%rax, -0x108(%rbp)
0000000100004c44	xorl	%eax, %eax
0000000100004c46	movl	%eax, %r14d
0000000100004c49	jmp	0x100004c6a
0000000100004c4b	nopl	(%rax,%rax)
0000000100004c50	movq	-0xf0(%rbp), %rax
0000000100004c57	incq	%rax
0000000100004c5a	movq	%rax, %r14
0000000100004c5d	cmpq	-0x108(%rbp), %rax
0000000100004c64	je	0x100004bd0
0000000100004c6a	movq	%r14, -0xf0(%rbp)
0000000100004c71	movq	0x28(%r15,%r14,8), %r13
0000000100004c76	testq	%r13, %r13
0000000100004c79	je	0x100004c50
0000000100004c7b	movq	-0xf0(%rbp), %rbx
0000000100004c82	shlq	$0x6, %rbx
0000000100004c86	nopw	%cs:(%rax,%rax)
0000000100004c90	tzcntq	%r13, %rax
0000000100004c95	orq	%rbx, %rax
0000000100004c98	leaq	-0x1(%r13), %r14
0000000100004c9c	movl	0x8(%r15), %ecx
0000000100004ca0	movl	%ecx, %esi
0000000100004ca2	imulq	%rsi, %rax
0000000100004ca6	movq	%rax, %rdi
0000000100004ca9	addq	%r12, %rdi
0000000100004cac	callq	_fwp_gc_push
0000000100004cb1	andq	%r13, %r14
0000000100004cb4	movq	%r14, %r13
0000000100004cb7	jne	0x100004c90
0000000100004cb9	jmp	0x100004c50
0000000100004cbb	cmpb	$0x0, 0x3(%r15)
0000000100004cc0	je	0x100004bd0
0000000100004cc6	movq	-0xe8(%rbp), %rdi
0000000100004ccd	shlq	$0x10, %rdi
0000000100004cd1	addq	0x11360(%rip), %rdi
0000000100004cd8	movq	0x18(%r15), %rsi
0000000100004cdc	callq	_fwp_gc_push
0000000100004ce1	jmp	0x100004bd0
0000000100004ce6	leaq	-0xd0(%rbp), %rdi
0000000100004ced	callq	0x100012100                     ## symbol stub for: _setjmp
0000000100004cf2	movq	$0x0, 0x1150b(%rip)
0000000100004cfd	callq	_fwp_gc_mark_all
0000000100004d02	callq	_fwp_gc_finalize
0000000100004d07	callq	_fwp_gc_sweep
0000000100004d0c	movq	0x114cd(%rip), %rax
0000000100004d13	incq	%rax
0000000100004d16	movq	%rax, 0x114c3(%rip)
0000000100004d1d	jmp	0x100004e3f
0000000100004d22	movq	0x1147f(%rip), %rax
0000000100004d29	testq	%rax, %rax
0000000100004d2c	je	0x100004d67
0000000100004d2e	xorl	%ebx, %ebx
0000000100004d30	movq	0x11469(%rip), %rcx
0000000100004d37	decq	%rax
0000000100004d3a	movq	%rax, 0x11467(%rip)
0000000100004d41	shlq	$0x4, %rax
0000000100004d45	movq	(%rcx,%rax), %rdi
0000000100004d49	movq	0x8(%rcx,%rax), %rsi
0000000100004d4e	addq	%rdi, %rsi
0000000100004d51	movl	%ebx, %edx
0000000100004d53	callq	_fwp_gc_scan
0000000100004d58	movq	0x11449(%rip), %rcx
0000000100004d5f	movq	%rcx, %rax
0000000100004d62	testq	%rcx, %rcx
0000000100004d65	jne	0x100004d30
0000000100004d67	cmpl	$0x0, 0x1129e(%rip)
0000000100004d6e	movzbl	-0xd1(%rbp), %r15d
0000000100004d76	je	0x100004e1d
0000000100004d7c	movq	0x112dd(%rip), %r14
0000000100004d83	movq	%r14, %rdi
0000000100004d86	shlq	$0x9, %rdi
0000000100004d8a	callq	0x1000120a6                     ## symbol stub for: _malloc
0000000100004d8f	movq	%rax, %rbx
0000000100004d92	cmpq	$0x1, %r14
0000000100004d96	movq	%r14, %rdi
0000000100004d99	adcq	$0x0, %rdi
0000000100004d9d	movq	%rdi, -0x150(%rbp)
0000000100004da4	callq	0x1000120a6                     ## symbol stub for: _malloc
0000000100004da9	movq	%rbx, -0xe0(%rbp)
0000000100004db0	testq	%rbx, %rbx
0000000100004db3	je	0x1000053a3
0000000100004db9	testq	%rax, %rax
0000000100004dbc	je	0x1000053a3
0000000100004dc2	movq	-0xe0(%rbp), %rcx
0000000100004dc9	movq	%rcx, -0x100(%rbp)
0000000100004dd0	movq	%rax, %r12
0000000100004dd3	testq	%r14, %r14
0000000100004dd6	je	0x100004e04
0000000100004dd8	movq	%r12, %rdx
0000000100004ddb	movq	0x1129e(%rip), %rcx
0000000100004de2	cmpq	$0x1, %r14
0000000100004de6	movq	%r14, -0x148(%rbp)
0000000100004ded	movq	%rcx, -0x120(%rbp)
0000000100004df4	jne	0x100004f8d
0000000100004dfa	xorl	%eax, %eax
0000000100004dfc	movq	%rdx, %r12
0000000100004dff	jmp	0x10000501e
0000000100004e04	callq	_fwp_gc_mark_all
0000000100004e09	movq	-0x100(%rbp), %rdi
0000000100004e10	callq	0x100012082                     ## symbol stub for: _free
0000000100004e15	movq	%r12, %rdi
0000000100004e18	callq	0x100012082                     ## symbol stub for: _free
0000000100004e1d	callq	_fwp_gc_finalize
0000000100004e22	callq	_fwp_gc_sweep
0000000100004e27	movq	0x113b2(%rip), %rax
0000000100004e2e	incq	%rax
0000000100004e31	movq	%rax, 0x113a8(%rip)
0000000100004e38	incq	0x111e1(%rip)
0000000100004e3f	movq	%rax, %rcx
0000000100004e42	movq	0x11387(%rip), %rax
0000000100004e49	cmpq	0x11388(%rip), %rax
0000000100004e50	jbe	0x100004e59
0000000100004e52	movq	%rax, 0x1137f(%rip)
0000000100004e59	testb	%r15b, %r15b
0000000100004e5c	je	0x100004e69
0000000100004e5e	movq	%rax, 0x111b3(%rip)
0000000100004e65	xorl	%edx, %edx
0000000100004e67	jmp	0x100004e96
0000000100004e69	movq	0x111a8(%rip), %rdx
0000000100004e70	movq	%rdx, %rsi
0000000100004e73	shrq	%rsi
0000000100004e76	addq	%rdx, %rsi
0000000100004e79	cmpq	$0x1000001, %rsi                ## imm = 0x1000001
0000000100004e80	movl	$0x1000000, %edx                ## imm = 0x1000000
0000000100004e85	cmovaeq	%rsi, %rdx
0000000100004e89	xorl	%esi, %esi
0000000100004e8b	cmpq	%rdx, %rax
0000000100004e8e	seta	%dl
0000000100004e91	movb	%dl, %sil
0000000100004e94	movl	%esi, %edx
0000000100004e96	testb	$0x7, %cl
0000000100004e99	movl	$0x1, %ecx
0000000100004e9e	cmovnel	%edx, %ecx
0000000100004ea1	cmpq	$0x0, 0x1117f(%rip)
0000000100004ea9	cmovel	%edx, %ecx
0000000100004eac	movl	%ecx, 0x1115e(%rip)
0000000100004eb2	cmpl	$0x0, 0x1114f(%rip)
0000000100004eb9	sete	%cl
0000000100004ebc	shlq	%cl, %rax
0000000100004ebf	cvttsd2si	0x11340(%rip), %rcx
0000000100004ec8	addq	%rax, %rcx
0000000100004ecb	cmpq	$0x800001, %rcx                 ## imm = 0x800001
0000000100004ed2	movl	$0x800000, %eax                 ## imm = 0x800000
0000000100004ed7	cmovgeq	%rcx, %rax
0000000100004edb	movq	%rax, 0x11336(%rip)
0000000100004ee2	movq	%rax, _fwp_gc(%rip)
0000000100004ee9	leaq	-0x160(%rbp), %rsi
0000000100004ef0	movl	$0x6, %edi
0000000100004ef5	callq	0x100012052                     ## symbol stub for: _clock_gettime
0000000100004efa	movq	-0x160(%rbp), %rax
0000000100004f01	movq	-0x158(%rbp), %rcx
0000000100004f08	subq	-0x170(%rbp), %rax
0000000100004f0f	cvtsi2sd	%rax, %xmm1
0000000100004f14	mulsd	0xd3e4(%rip), %xmm1
0000000100004f1c	subq	-0x168(%rbp), %rcx
0000000100004f23	xorps	%xmm0, %xmm0
0000000100004f26	cvtsi2sd	%rcx, %xmm0
0000000100004f2b	divsd	0xd3d5(%rip), %xmm0
0000000100004f33	addsd	%xmm1, %xmm0
0000000100004f37	movsd	0x112b9(%rip), %xmm1
0000000100004f3f	addsd	%xmm0, %xmm1
0000000100004f43	movsd	%xmm1, 0x112ad(%rip)
0000000100004f4b	ucomisd	0x112ad(%rip), %xmm0
0000000100004f53	jbe	0x100004f5d
0000000100004f55	movsd	%xmm0, 0x112a3(%rip)
0000000100004f5d	movl	$0x0, 0x11099(%rip)
0000000100004f67	movq	0xf0c2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100004f6e	movq	(%rax), %rax
0000000100004f71	cmpq	-0x30(%rbp), %rax
0000000100004f75	jne	0x1000051b9
0000000100004f7b	addq	$0x168, %rsp                    ## imm = 0x168
0000000100004f82	popq	%rbx
0000000100004f83	popq	%r12
0000000100004f85	popq	%r13
0000000100004f87	popq	%r14
0000000100004f89	popq	%r15
0000000100004f8b	popq	%rbp
0000000100004f8c	retq
0000000100004f8d	movq	%r14, %r12
0000000100004f90	andq	$-0x2, %r12
0000000100004f94	movq	%r12, -0x110(%rbp)
0000000100004f9b	movq	-0xe0(%rbp), %rax
0000000100004fa2	leaq	0x200(%rax), %r14
0000000100004fa9	leaq	0x1250(%rcx), %r13
0000000100004fb0	xorl	%eax, %eax
0000000100004fb2	movl	%eax, %ecx
0000000100004fb4	movl	$0x200, %ebx                    ## imm = 0x200
0000000100004fb9	movq	%rdx, %r12
0000000100004fbc	nopl	(%rax)
0000000100004fc0	movq	%rcx, %r15
0000000100004fc3	leaq	-0x200(%r14), %rdi
0000000100004fca	leaq	-0x1228(%r13), %rsi
0000000100004fd1	movq	%rbx, %rdx
0000000100004fd4	callq	0x1000120b8                     ## symbol stub for: _memcpy
0000000100004fd9	movzbl	-0x124d(%r13), %eax
0000000100004fe1	movb	%al, (%r12,%r15)
0000000100004fe5	movq	%r14, %rdi
0000000100004fe8	movq	%r13, %rsi
0000000100004feb	movq	%rbx, %rdx
0000000100004fee	callq	0x1000120b8                     ## symbol stub for: _memcpy
0000000100004ff3	movzbl	-0x25(%r13), %eax
0000000100004ff8	movb	%al, 0x1(%r12,%r15)
0000000100004ffd	addq	$0x2, %r15
0000000100005001	addq	$0x400, %r14                    ## imm = 0x400
0000000100005008	addq	$0x2450, %r13                   ## imm = 0x2450
000000010000500f	movq	%r15, %rax
0000000100005012	movq	%r15, %rcx
0000000100005015	cmpq	%r15, -0x110(%rbp)
000000010000501c	jne	0x100004fc0
000000010000501e	movq	-0x148(%rbp), %r13
0000000100005025	testb	$0x1, %r13b
0000000100005029	movq	-0x120(%rbp), %r15
0000000100005030	je	0x100005066
0000000100005032	movq	%rax, %rbx
0000000100005035	movq	%rax, %rdi
0000000100005038	shlq	$0x9, %rdi
000000010000503c	addq	-0xe0(%rbp), %rdi
0000000100005043	imulq	$0x1228, %rax, %r14             ## imm = 0x1228
000000010000504a	leaq	(%r15,%r14), %rsi
000000010000504e	addq	$0x28, %rsi
0000000100005052	movl	$0x200, %edx                    ## imm = 0x200
0000000100005057	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000505c	movzbl	0x3(%r15,%r14), %eax
0000000100005062	movb	%al, (%r12,%rbx)
0000000100005066	xorl	%eax, %eax
0000000100005068	movl	%eax, %r14d
000000010000506b	movq	%r14, %rbx
000000010000506e	movq	%r13, %rcx
0000000100005071	movq	%r15, %rax
0000000100005074	movzbl	-0xd1(%rbp), %r15d
000000010000507c	jmp	0x10000509b
000000010000507e	nop
0000000100005080	movb	$0x0, 0x3(%rax,%r14)
0000000100005086	movq	%rbx, %rsi
0000000100005089	incq	%rsi
000000010000508c	addq	$0x1228, %r14                   ## imm = 0x1228
0000000100005093	movq	%rsi, %rbx
0000000100005096	cmpq	%rcx, %rsi
0000000100005099	jae	0x1000050d7
000000010000509b	movzbl	(%rax,%r14), %edx
00000001000050a0	cmpl	$0x2, %edx
00000001000050a3	je	0x100005080
00000001000050a5	cmpl	$0x1, %edx
00000001000050a8	jne	0x100005086
00000001000050aa	leaq	(%rax,%r14), %rdi
00000001000050ae	addq	$0x28, %rdi
00000001000050b2	movl	0xc(%rax,%r14), %eax
00000001000050b7	addl	$0x3f, %eax
00000001000050ba	shrl	$0x3, %eax
00000001000050bd	andl	$-0x8, %eax
00000001000050c0	movl	%eax, %esi
00000001000050c2	callq	0x100011ffe                     ## symbol stub for: ___bzero
00000001000050c7	movq	0x10fb2(%rip), %rax
00000001000050ce	movq	0x10f8b(%rip), %rcx
00000001000050d5	jmp	0x100005086
00000001000050d7	callq	_fwp_gc_mark_all
00000001000050dc	movq	0x10f9d(%rip), %rcx
00000001000050e3	leaq	0x28(%rcx), %rdi
00000001000050e7	xorl	%edx, %edx
00000001000050e9	movl	%edx, %esi
00000001000050eb	movq	-0x100(%rbp), %r8
00000001000050f2	jmp	0x100005120
00000001000050f4	testq	%r11, %r11
00000001000050f7	jne	0x1000051be
00000001000050fd	nopl	(%rax)
0000000100005100	movq	%rsi, %rax
0000000100005103	incq	%rax
0000000100005106	addq	$0x200, %r8                     ## imm = 0x200
000000010000510d	addq	$0x1228, %rdi                   ## imm = 0x1228
0000000100005114	movq	%rax, %rsi
0000000100005117	cmpq	%r13, %rax
000000010000511a	je	0x100004e09
0000000100005120	imulq	$0x1228, %rsi, %r9              ## imm = 0x1228
0000000100005127	leaq	(%rcx,%r9), %rax
000000010000512b	movzbl	(%rcx,%r9), %r9d
0000000100005130	cmpl	$0x2, %r9d
0000000100005134	je	0x100005190
0000000100005136	cmpl	$0x1, %r9d
000000010000513a	jne	0x100005100
000000010000513c	movl	0xc(%rax), %r9d
0000000100005140	addl	$0x3f, %r9d
0000000100005144	cmpl	$0x40, %r9d
0000000100005148	jb	0x100005100
000000010000514a	shrl	$0x6, %r9d
000000010000514e	movq	$-0x40, %r14
0000000100005155	movl	%edx, %ebx
0000000100005157	nopw	(%rax,%rax)
0000000100005160	movq	%r14, %r10
0000000100005163	movq	(%r8,%rbx,8), %r11
0000000100005167	notq	%r11
000000010000516a	andq	(%rdi,%rbx,8), %r11
000000010000516e	incq	%rbx
0000000100005171	addq	$0x40, %r10
0000000100005175	cmpq	%r9, %rbx
0000000100005178	jae	0x1000050f4
000000010000517e	movq	%r10, %r14
0000000100005181	testq	%r11, %r11
0000000100005184	je	0x100005160
0000000100005186	jmp	0x1000050f4
000000010000518b	nopl	(%rax,%rax)
0000000100005190	cmpb	$0x0, 0x3(%rax)
0000000100005194	je	0x100005100
000000010000519a	cmpb	$0x0, (%r12,%rsi)
000000010000519f	jne	0x100005100
00000001000051a5	movq	%rsi, %r15
00000001000051a8	shlq	$0x10, %r15
00000001000051ac	addq	0x10e85(%rip), %r15
00000001000051b3	movq	0x18(%rax), %rbx
00000001000051b7	jmp	0x1000051dd
00000001000051b9	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
00000001000051be	tzcntq	%r11, %r15
00000001000051c3	shlq	$0x10, %rsi
00000001000051c7	addq	0x10e6a(%rip), %rsi
00000001000051ce	addq	%r10, %r15
00000001000051d1	movl	0x8(%rax), %edx
00000001000051d4	movl	%edx, %ebx
00000001000051d6	imulq	%rbx, %r15
00000001000051da	addq	%rsi, %r15
00000001000051dd	movq	0xee54(%rip), %rcx              ## literal pool symbol address: ___stderrp
00000001000051e4	movq	(%rcx), %rdi
00000001000051e7	movzbl	0x1(%rax), %ecx
00000001000051eb	leaq	0xd6c1(%rip), %rsi              ## literal pool for: "fwp gc verify: a minor collection missed the reachable object at %p (kind %d, %zu bytes)\n"
00000001000051f2	xorl	%r14d, %r14d
00000001000051f5	movl	%r14d, %eax
00000001000051f8	movq	%r15, %rdx
00000001000051fb	movq	%rbx, %r8
00000001000051fe	movb	%r14b, -0xd2(%rbp)
0000000100005205	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000520a	addq	%r15, %rbx
000000010000520d	movq	%rbx, -0x140(%rbp)
0000000100005214	movl	%r14d, %eax
0000000100005217	movq	%rax, %rcx
000000010000521a	jmp	0x100005243
000000010000521c	nopl	(%rax)
0000000100005220	movq	-0xf8(%rbp), %rdx
0000000100005227	incq	%rdx
000000010000522a	movq	%rdi, %rax
000000010000522d	addq	$0x10000, %rax                  ## imm = 0x10000
0000000100005233	movq	%rdx, %rcx
0000000100005236	cmpq	-0x150(%rbp), %rdx
000000010000523d	je	0x10000539e
0000000100005243	movq	%rax, %rdi
0000000100005246	movq	0x10e33(%rip), %r12
000000010000524d	movq	%rcx, -0xf8(%rbp)
0000000100005254	imulq	$0x1228, %rcx, %rax             ## imm = 0x1228
000000010000525b	cmpb	$0x1, (%r12,%rax)
0000000100005260	jne	0x100005220
0000000100005262	addq	%rax, %r12
0000000100005265	cmpb	$0x1, 0x1(%r12)
000000010000526b	je	0x100005220
000000010000526d	movl	0xc(%r12), %eax
0000000100005272	testl	%eax, %eax
0000000100005274	je	0x100005220
0000000100005276	movq	-0xf8(%rbp), %rdx
000000010000527d	movq	%rdx, %rcx
0000000100005280	shlq	$0x10, %rcx
0000000100005284	movq	%rcx, -0x130(%rbp)
000000010000528b	xorl	%ecx, %ecx
000000010000528d	shlq	$0x9, %rdx
0000000100005291	movq	%rdx, %r8
0000000100005294	addq	-0xe0(%rbp), %r8
000000010000529b	movq	%rdi, -0x138(%rbp)
00000001000052a2	movq	%r8, -0x128(%rbp)
00000001000052a9	jmp	0x1000052e0
00000001000052ab	nopl	(%rax,%rax)
00000001000052b0	movl	0xc(%r12), %eax
00000001000052b5	movq	-0x138(%rbp), %rdi
00000001000052bc	movq	-0x128(%rbp), %r8
00000001000052c3	movq	-0x118(%rbp), %rsi
00000001000052ca	movq	%rsi, %rdx
00000001000052cd	incq	%rdx
00000001000052d0	movl	%eax, %ecx
00000001000052d2	movl	%ecx, %esi
00000001000052d4	movq	%rdx, %rcx
00000001000052d7	cmpq	%rsi, %rdx
00000001000052da	jae	0x100005220
00000001000052e0	movq	%rcx, %rsi
00000001000052e3	shrq	$0x6, %rcx
00000001000052e7	movq	(%r8,%rcx,8), %rcx
00000001000052eb	btq	%rsi, %rcx
00000001000052ef	jae	0x1000052ca
00000001000052f1	movl	0x8(%r12), %ecx
00000001000052f6	cmpq	$0x8, %rcx
00000001000052fa	jb	0x1000052ca
00000001000052fc	movq	0x10d35(%rip), %r13
0000000100005303	movq	-0x130(%rbp), %rdx
000000010000530a	leaq	(%rdx,%r13), %rbx
000000010000530e	movl	%ecx, %r8d
0000000100005311	movq	%rsi, -0x118(%rbp)
0000000100005318	imulq	%rsi, %rcx
000000010000531c	addq	%rcx, %rbx
000000010000531f	addq	%rdi, %r13
0000000100005322	addq	%rcx, %r13
0000000100005325	xorl	%eax, %eax
0000000100005327	movl	%eax, %r14d
000000010000532a	jmp	0x100005348
000000010000532c	nopl	(%rax)
0000000100005330	movl	%r8d, %eax
0000000100005333	movq	%r14, %rcx
0000000100005336	incq	%rcx
0000000100005339	shrl	$0x3, %eax
000000010000533c	movq	%rcx, %r14
000000010000533f	cmpq	%rax, %rcx
0000000100005342	jae	0x1000052b0
0000000100005348	movq	(%r13,%r14,8), %rax
000000010000534d	cmpq	%r15, %rax
0000000100005350	jb	0x100005330
0000000100005352	cmpq	-0x140(%rbp), %rax
0000000100005359	jae	0x100005330
000000010000535b	movq	0xecd6(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100005362	movq	(%rax), %rdi
0000000100005365	movzbl	0x1(%r12), %ecx
000000010000536b	movupd	(%rbx), %xmm0
000000010000536f	movq	0x10(%rbx), %rax
0000000100005373	movq	%rsp, %rdx
0000000100005376	movq	%rax, 0x10(%rdx)
000000010000537a	movupd	%xmm0, (%rdx)
000000010000537e	leaq	0xd588(%rip), %rsi              ## literal pool for: "  from the old object at %p (kind %d, %u bytes), word %zu; its first words %lx %lx %lx\n"
0000000100005385	movq	%rbx, %rdx
0000000100005388	movq	%r14, %r9
000000010000538b	movzbl	-0xd2(%rbp), %eax
0000000100005392	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100005397	movl	0x8(%r12), %r8d
000000010000539c	jmp	0x100005330
000000010000539e	callq	0x10001203a                     ## symbol stub for: _abort
00000001000053a3	movq	0xec8e(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000053aa	movq	(%rax), %rcx
00000001000053ad	leaq	0xd4eb(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000053b4	movl	$0x13, %esi
00000001000053b9	movl	$0x1, %edx
00000001000053be	callq	0x100012088                     ## symbol stub for: _fwrite
00000001000053c3	movl	$0x66, %edi
00000001000053c8	callq	0x100012058                     ## symbol stub for: _exit
00000001000053cd	nopl	(%rax)
_fwp_gc_mark_all:
00000001000053d0	pushq	%rbp
00000001000053d1	movq	%rsp, %rbp
00000001000053d4	pushq	%r15
00000001000053d6	pushq	%r14
00000001000053d8	pushq	%r13
00000001000053da	pushq	%r12
00000001000053dc	pushq	%rbx
00000001000053dd	pushq	%rax
00000001000053de	callq	_fwp_gc_sp
00000001000053e3	movq	0x10ca6(%rip), %rsi
00000001000053ea	testq	%rax, %rax
00000001000053ed	sete	%dl
00000001000053f0	movq	%rsi, %rcx
00000001000053f3	subq	%rax, %rcx
00000001000053f6	setbe	%dil
00000001000053fa	orb	%dl, %dil
00000001000053fd	jne	0x100005446
00000001000053ff	cvtsi2sd	%rcx, %xmm0
0000000100005404	addsd	0x10dfc(%rip), %xmm0
000000010000540c	movsd	%xmm0, 0x10df4(%rip)
0000000100005414	movq	%rax, %rdi
0000000100005417	movl	$0x1, %edx
000000010000541c	jmp	0x100005441
000000010000541e	movq	0x10d7b(%rip), %rcx
0000000100005425	decq	%rax
0000000100005428	movq	%rax, 0x10d79(%rip)
000000010000542f	shlq	$0x4, %rax
0000000100005433	movq	(%rcx,%rax), %rdi
0000000100005437	movq	0x8(%rcx,%rax), %rsi
000000010000543c	addq	%rdi, %rsi
000000010000543f	xorl	%edx, %edx
0000000100005441	callq	_fwp_gc_scan
0000000100005446	movq	0x10d5b(%rip), %rax
000000010000544d	testq	%rax, %rax
0000000100005450	jne	0x10000541e
0000000100005452	cmpl	$0x0, 0x10d3f(%rip)
0000000100005459	jle	0x100005524
000000010000545f	leaq	0x10c3a(%rip), %r12
0000000100005466	xorl	%r13d, %r13d
0000000100005469	leaq	_fwp_gc(%rip), %rbx
0000000100005470	leaq	0x1a20(%rbx), %r14
0000000100005477	jmp	0x10000549d
0000000100005479	nopl	(%rax)
0000000100005480	movq	%r15, %rsi
0000000100005483	xorl	%edx, %edx
0000000100005485	callq	_fwp_gc_scan
000000010000548a	incq	%r13
000000010000548d	movslq	0x10d04(%rip), %rax
0000000100005494	addq	$0x10, %r12
0000000100005498	cmpq	%rax, %r13
000000010000549b	jge	0x100005518
000000010000549d	movq	-0x8(%r12), %rdi
00000001000054a2	movq	(%r12), %rax
00000001000054a6	xorps	%xmm0, %xmm0
00000001000054a9	cvtsi2sd	%rax, %xmm0
00000001000054ae	addsd	0x1200(%rbx), %xmm0
00000001000054b6	leaq	(%rdi,%rax), %r15
00000001000054ba	cmpq	%rbx, %rdi
00000001000054bd	seta	%al
00000001000054c0	movsd	%xmm0, 0x1200(%rbx)
00000001000054c8	cmpq	%r14, %r15
00000001000054cb	setb	%cl
00000001000054ce	orb	%al, %cl
00000001000054d0	jne	0x100005480
00000001000054d2	movq	%rbx, %rsi
00000001000054d5	xorl	%edx, %edx
00000001000054d7	callq	_fwp_gc_scan
00000001000054dc	leaq	_d1(%rip), %rdi
00000001000054e3	jmp	0x100005480
00000001000054e5	nopw	%cs:(%rax,%rax)
00000001000054f0	movq	0x10ca9(%rip), %rcx
00000001000054f7	decq	%rax
00000001000054fa	movq	%rax, 0x10ca7(%rip)
0000000100005501	shlq	$0x4, %rax
0000000100005505	movq	(%rcx,%rax), %rdi
0000000100005509	movq	0x8(%rcx,%rax), %rsi
000000010000550e	addq	%rdi, %rsi
0000000100005511	xorl	%edx, %edx
0000000100005513	callq	_fwp_gc_scan
0000000100005518	movq	0x10c89(%rip), %rax
000000010000551f	testq	%rax, %rax
0000000100005522	jne	0x1000054f0
0000000100005524	addq	$0x8, %rsp
0000000100005528	popq	%rbx
0000000100005529	popq	%r12
000000010000552b	popq	%r13
000000010000552d	popq	%r14
000000010000552f	popq	%r15
0000000100005531	popq	%rbp
0000000100005532	retq
0000000100005533	nopw	%cs:(%rax,%rax)
_fwp_gc_finalize:
0000000100005540	movq	0x10c79(%rip), %rcx
0000000100005547	testq	%rcx, %rcx
000000010000554a	je	0x10000565b
0000000100005550	pushq	%rbp
0000000100005551	movq	%rsp, %rbp
0000000100005554	pushq	%r14
0000000100005556	pushq	%rbx
0000000100005557	movq	0x10c5a(%rip), %rsi
000000010000555e	movq	0x10ad3(%rip), %r8
0000000100005565	movq	0x10af4(%rip), %r9
000000010000556c	xorl	%ebx, %ebx
000000010000556e	jmp	0x10000557c
0000000100005570	incq	%rbx
0000000100005573	cmpq	%rcx, %rbx
0000000100005576	jae	0x100005657
000000010000557c	movq	%rbx, %r10
000000010000557f	shlq	$0x4, %r10
0000000100005583	movq	(%rsi,%r10), %rdi
0000000100005587	movq	%rdi, %rdx
000000010000558a	subq	%r8, %rdx
000000010000558d	movq	%r9, %rax
0000000100005590	shlq	$0x10, %rax
0000000100005594	cmpq	%rax, %rdx
0000000100005597	jae	0x100005570
0000000100005599	movq	0x10ae0(%rip), %rax
00000001000055a0	testq	%rax, %rax
00000001000055a3	je	0x100005570
00000001000055a5	shrq	$0x10, %rdx
00000001000055a9	imulq	$0x1228, %rdx, %r14             ## imm = 0x1228
00000001000055b0	addq	%rax, %r14
00000001000055b3	movzbl	(%r14), %edx
00000001000055b7	cmpb	$0x3, %dl
00000001000055ba	jne	0x1000055cf
00000001000055bc	movl	0x10(%r14), %edx
00000001000055c0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000055c7	leaq	(%rax,%rdx), %r14
00000001000055cb	movzbl	(%rax,%rdx), %edx
00000001000055cf	movq	0x8(%rsi,%r10), %r11
00000001000055d4	cmpb	$0x1, %dl
00000001000055d7	je	0x1000055ec
00000001000055d9	movzbl	%dl, %eax
00000001000055dc	cmpl	$0x2, %eax
00000001000055df	jne	0x100005616
00000001000055e1	movzbl	0x3(%r14), %edx
00000001000055e6	testl	%edx, %edx
00000001000055e8	jne	0x100005570
00000001000055ea	jmp	0x100005616
00000001000055ec	movzwl	%di, %eax
00000001000055ef	xorl	%edx, %edx
00000001000055f1	divl	0x8(%r14)
00000001000055f5	movl	%eax, %edx
00000001000055f7	shrl	$0x3, %edx
00000001000055fa	andl	$0x1ff8, %edx                   ## imm = 0x1FF8
0000000100005600	movq	0x28(%r14,%rdx), %r14
0000000100005605	xorl	%edx, %edx
0000000100005607	btq	%rax, %r14
000000010000560b	setb	%dl
000000010000560e	testl	%edx, %edx
0000000100005610	jne	0x100005570
0000000100005616	addq	%rsi, %r10
0000000100005619	decq	%rcx
000000010000561c	movq	%rcx, 0x10b9d(%rip)
0000000100005623	shlq	$0x4, %rcx
0000000100005627	movups	(%rsi,%rcx), %xmm0
000000010000562b	movups	%xmm0, (%r10)
000000010000562f	callq	*%r11
0000000100005632	movq	0x10b7f(%rip), %rsi
0000000100005639	movq	0x109f8(%rip), %r8
0000000100005640	movq	0x10a19(%rip), %r9
0000000100005647	movq	0x10b72(%rip), %rcx
000000010000564e	cmpq	%rcx, %rbx
0000000100005651	jb	0x10000557c
0000000100005657	popq	%rbx
0000000100005658	popq	%r14
000000010000565a	popq	%rbp
000000010000565b	retq
000000010000565c	nopl	(%rax)
_fwp_gc_sweep:
0000000100005660	pushq	%rbp
0000000100005661	movq	%rsp, %rbp
0000000100005664	pushq	%r15
0000000100005666	pushq	%r14
0000000100005668	pushq	%r13
000000010000566a	pushq	%r12
000000010000566c	pushq	%rbx
000000010000566d	subq	$0x28, %rsp
0000000100005671	leaq	0xf998(%rip), %rdi
0000000100005678	movl	$0xb40, %esi                    ## imm = 0xB40
000000010000567d	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100005682	cmpq	$0x0, 0x109d6(%rip)
000000010000568a	je	0x100005b44
0000000100005690	movq	$0x0, -0x30(%rbp)
0000000100005698	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
00000001000056a2	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000056ac	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000056b6	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000056c0	movdqa	0xcb68(%rip), %xmm6
00000001000056c8	movdqa	0xcb70(%rip), %xmm7
00000001000056d0	pxor	%xmm8, %xmm8
00000001000056d5	xorl	%r15d, %r15d
00000001000056d8	xorl	%edx, %edx
00000001000056da	jmp	0x1000056f6
00000001000056dc	nopl	(%rax)
00000001000056e0	incq	%r15
00000001000056e3	incq	%rdx
00000001000056e6	movq	0x10973(%rip), %rax
00000001000056ed	cmpq	%rax, %rdx
00000001000056f0	jae	0x100005b51
00000001000056f6	movq	0x10983(%rip), %rax
00000001000056fd	imulq	$0x1228, %rdx, %r14             ## imm = 0x1228
0000000100005704	movzbl	(%rax,%r14), %ecx
0000000100005709	testl	%ecx, %ecx
000000010000570b	je	0x1000056e0
000000010000570d	leaq	(%rax,%r14), %r13
0000000100005711	cmpl	$0x1, %ecx
0000000100005714	je	0x100005740
0000000100005716	cmpl	$0x2, %ecx
0000000100005719	jne	0x1000056e3
000000010000571b	movl	0x10(%r13), %r12d
000000010000571f	cmpb	$0x0, 0x3(%r13)
0000000100005724	je	0x10000576f
0000000100005726	movq	-0x30(%rbp), %rax
000000010000572a	addq	0x18(%r13), %rax
000000010000572e	movq	%rax, -0x30(%rbp)
0000000100005732	addq	%r12, %rdx
0000000100005735	decq	%rdx
0000000100005738	jmp	0x1000056e3
000000010000573a	nopw	(%rax,%rax)
0000000100005740	movq	%rdx, -0x38(%rbp)
0000000100005744	movl	0xc(%r13), %r12d
0000000100005748	testq	%r12, %r12
000000010000574b	je	0x1000059cc
0000000100005751	leaq	0x3f(%r12), %rsi
0000000100005756	movq	%rsi, %rcx
0000000100005759	shrq	$0x6, %rcx
000000010000575d	cmpl	$0xc0, %r12d
0000000100005764	ja	0x1000057d4
0000000100005766	xorl	%esi, %esi
0000000100005768	xorl	%edx, %edx
000000010000576a	jmp	0x100005890
000000010000576f	movq	%rdx, -0x38(%rbp)
0000000100005773	leaq	0x228(%r13), %rbx
000000010000577a	cmpb	$-0x1, 0x228(%r13)
0000000100005782	je	0x100005b22
0000000100005788	movb	$0x0, (%rbx)
000000010000578b	testq	%r12, %r12
000000010000578e	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005798	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000057a2	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000057ac	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000057b6	je	0x100005b10
00000001000057bc	movq	0x108bd(%rip), %rax
00000001000057c3	cmpl	$0x4, %r12d
00000001000057c7	jae	0x100005aa2
00000001000057cd	xorl	%ecx, %ecx
00000001000057cf	jmp	0x100005ad8
00000001000057d4	movl	%ecx, %edx
00000001000057d6	andl	$-0x4, %edx
00000001000057d9	leaq	(%rax,%r14), %rdi
00000001000057dd	addq	$0x38, %rdi
00000001000057e1	shrq	$0x3, %rsi
00000001000057e5	andl	$-0x20, %esi
00000001000057e8	pxor	%xmm0, %xmm0
00000001000057ec	xorl	%r8d, %r8d
00000001000057ef	pxor	%xmm1, %xmm1
00000001000057f3	nopw	%cs:(%rax,%rax)
0000000100005800	movdqu	-0x10(%rdi,%r8), %xmm2
0000000100005807	movdqu	(%rdi,%r8), %xmm3
000000010000580d	movdqa	%xmm2, %xmm4
0000000100005811	pand	%xmm6, %xmm4
0000000100005815	movdqa	%xmm7, %xmm5
0000000100005819	pshufb	%xmm4, %xmm5
000000010000581e	psrlw	$0x4, %xmm2
0000000100005823	pand	%xmm6, %xmm2
0000000100005827	movdqa	%xmm7, %xmm4
000000010000582b	pshufb	%xmm2, %xmm4
0000000100005830	paddb	%xmm5, %xmm4
0000000100005834	psadbw	%xmm8, %xmm4
0000000100005839	paddq	%xmm4, %xmm0
000000010000583d	movdqa	%xmm3, %xmm2
0000000100005841	pand	%xmm6, %xmm2
0000000100005845	movdqa	%xmm7, %xmm4
0000000100005849	pshufb	%xmm2, %xmm4
000000010000584e	psrlw	$0x4, %xmm3
0000000100005853	pand	%xmm6, %xmm3
0000000100005857	movdqa	%xmm7, %xmm2
000000010000585b	pshufb	%xmm3, %xmm2
0000000100005860	paddb	%xmm4, %xmm2
0000000100005864	psadbw	%xmm8, %xmm2
0000000100005869	paddq	%xmm2, %xmm1
000000010000586d	addq	$0x20, %r8
0000000100005871	cmpq	%r8, %rsi
0000000100005874	jne	0x100005800
0000000100005876	paddq	%xmm0, %xmm1
000000010000587a	pshufd	$0xee, %xmm1, %xmm0             ## xmm0 = xmm1[2,3,2,3]
000000010000587f	paddq	%xmm1, %xmm0
0000000100005883	movq	%xmm0, %rsi
0000000100005888	cmpl	%edx, %ecx
000000010000588a	je	0x1000058d1
000000010000588c	nopl	(%rax)
0000000100005890	movq	0x28(%r13,%rdx,8), %rdi
0000000100005895	movq	%rdi, %r8
0000000100005898	shrq	%r8
000000010000589b	andq	%r9, %r8
000000010000589e	subq	%r8, %rdi
00000001000058a1	movq	%rdi, %r8
00000001000058a4	andq	%r10, %r8
00000001000058a7	shrq	$0x2, %rdi
00000001000058ab	andq	%r10, %rdi
00000001000058ae	addq	%r8, %rdi
00000001000058b1	movq	%rdi, %r8
00000001000058b4	shrq	$0x4, %r8
00000001000058b8	addq	%rdi, %r8
00000001000058bb	andq	%r11, %r8
00000001000058be	imulq	%rbx, %r8
00000001000058c2	shrq	$0x38, %r8
00000001000058c6	addq	%r8, %rsi
00000001000058c9	incq	%rdx
00000001000058cc	cmpq	%rdx, %rcx
00000001000058cf	jne	0x100005890
00000001000058d1	testq	%rsi, %rsi
00000001000058d4	je	0x1000059cc
00000001000058da	movq	%r15, -0x40(%rbp)
00000001000058de	movl	0x8(%r13), %ecx
00000001000058e2	imulq	%rcx, %rsi
00000001000058e6	addq	%rsi, -0x30(%rbp)
00000001000058ea	movzbl	0x1(%r13), %ecx
00000001000058ef	movzbl	0x2(%r13), %edx
00000001000058f4	imulq	$0x3c0, %rcx, %rcx              ## imm = 0x3C0
00000001000058fb	leaq	_fwp_gc(%rip), %rsi
0000000100005902	addq	%rsi, %rcx
0000000100005905	leaq	(%rdx,%rdx,2), %rdx
0000000100005909	movq	-0x38(%rbp), %rsi
000000010000590d	shlq	$0x10, %rsi
0000000100005911	addq	0x10720(%rip), %rsi
0000000100005918	movq	%rsi, -0x48(%rbp)
000000010000591c	leaq	(%rcx,%rdx,8), %r15
0000000100005920	addq	$0x8, %r15
0000000100005924	addq	%r12, %r14
0000000100005927	leaq	(%rax,%r14), %rbx
000000010000592b	addq	$0x227, %rbx                    ## imm = 0x227
0000000100005932	decq	%r12
0000000100005935	jmp	0x100005961
0000000100005937	nopw	(%rax,%rax)
0000000100005940	cmpb	$-0x1, (%rbx)
0000000100005943	je	0x1000059aa
0000000100005945	movb	$0x0, (%rbx)
0000000100005948	movq	(%r15), %rax
000000010000594b	notq	%rax
000000010000594e	movq	%rax, (%r14)
0000000100005951	movq	%r14, (%r15)
0000000100005954	decq	%rbx
0000000100005957	addq	$-0x1, %r12
000000010000595b	jae	0x100005a6d
0000000100005961	movq	%r12, %rax
0000000100005964	shrq	$0x6, %rax
0000000100005968	movq	0x28(%r13,%rax,8), %rax
000000010000596d	btq	%r12, %rax
0000000100005971	jb	0x100005954
0000000100005973	movl	0x8(%r13), %esi
0000000100005977	movq	%r12, %r14
000000010000597a	imulq	%rsi, %r14
000000010000597e	addq	-0x48(%rbp), %r14
0000000100005982	cmpl	$0x0, 0x10683(%rip)
0000000100005989	je	0x100005940
000000010000598b	movq	%r14, %rdi
000000010000598e	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100005993	pxor	%xmm8, %xmm8
0000000100005998	movdqa	0xc8a0(%rip), %xmm7
00000001000059a0	movdqa	0xc888(%rip), %xmm6
00000001000059a8	jmp	0x100005940
00000001000059aa	movq	%rbx, %rdi
00000001000059ad	callq	_fwp_rc_forget_slot
00000001000059b2	pxor	%xmm8, %xmm8
00000001000059b7	movdqa	0xc881(%rip), %xmm7
00000001000059bf	movdqa	0xc869(%rip), %xmm6
00000001000059c7	jmp	0x100005945
00000001000059cc	cmpq	$0x0, 0x1104c(%rip)
00000001000059d4	je	0x100005a0e
00000001000059d6	leaq	0x228(%r13), %rbx
00000001000059dd	xorl	%r14d, %r14d
00000001000059e0	jmp	0x1000059fc
00000001000059e2	nopw	%cs:(%rax,%rax)
00000001000059f0	incq	%r14
00000001000059f3	cmpq	$0x1000, %r14                   ## imm = 0x1000
00000001000059fa	je	0x100005a0e
00000001000059fc	cmpb	$-0x1, (%rbx,%r14)
0000000100005a01	jne	0x1000059f0
0000000100005a03	leaq	(%rbx,%r14), %rdi
0000000100005a07	callq	_fwp_rc_forget_slot
0000000100005a0c	jmp	0x1000059f0
0000000100005a0e	leaq	0x228(%r13), %rdi
0000000100005a15	movl	$0x1000, %esi                   ## imm = 0x1000
0000000100005a1a	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100005a1f	movb	$0x0, (%r13)
0000000100005a24	incq	%r15
0000000100005a27	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005a31	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
0000000100005a3b	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100005a45	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
0000000100005a4f	movdqa	0xc7d9(%rip), %xmm6
0000000100005a57	movdqa	0xc7e1(%rip), %xmm7
0000000100005a5f	pxor	%xmm8, %xmm8
0000000100005a64	movq	-0x38(%rbp), %rdx
0000000100005a68	jmp	0x1000056e3
0000000100005a6d	movq	-0x40(%rbp), %r15
0000000100005a71	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005a7b	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
0000000100005a85	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100005a8f	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
0000000100005a99	movq	-0x38(%rbp), %rdx
0000000100005a9d	jmp	0x1000056e3
0000000100005aa2	leaq	(%rax,%r14), %rdx
0000000100005aa6	movl	%r12d, %esi
0000000100005aa9	andl	$-0x4, %esi
0000000100005aac	xorl	%ecx, %ecx
0000000100005aae	nop
0000000100005ab0	movb	$0x0, (%rdx)
0000000100005ab3	movb	$0x0, 0x1228(%rdx)
0000000100005aba	movb	$0x0, 0x2450(%rdx)
0000000100005ac1	movb	$0x0, 0x3678(%rdx)
0000000100005ac8	addq	$0x4, %rcx
0000000100005acc	addq	$0x48a0, %rdx                   ## imm = 0x48A0
0000000100005ad3	cmpq	%rcx, %rsi
0000000100005ad6	jne	0x100005ab0
0000000100005ad8	movl	%r12d, %edx
0000000100005adb	andl	$0x3, %edx
0000000100005ade	je	0x100005b10
0000000100005ae0	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
0000000100005ae7	addq	%r14, %rcx
0000000100005aea	addq	%rcx, %rax
0000000100005aed	imulq	$0x1228, %rdx, %rcx             ## imm = 0x1228
0000000100005af4	xorl	%edx, %edx
0000000100005af6	nopw	%cs:(%rax,%rax)
0000000100005b00	movb	$0x0, (%rax,%rdx)
0000000100005b04	addq	$0x1228, %rdx                   ## imm = 0x1228
0000000100005b0b	cmpq	%rdx, %rcx
0000000100005b0e	jne	0x100005b00
0000000100005b10	addq	%r12, %r15
0000000100005b13	movq	-0x38(%rbp), %rdx
0000000100005b17	addq	%r12, %rdx
0000000100005b1a	decq	%rdx
0000000100005b1d	jmp	0x1000056e3
0000000100005b22	movq	%rbx, %rdi
0000000100005b25	callq	_fwp_rc_forget_slot
0000000100005b2a	pxor	%xmm8, %xmm8
0000000100005b2f	movdqa	0xc709(%rip), %xmm7
0000000100005b37	movdqa	0xc6f1(%rip), %xmm6
0000000100005b3f	jmp	0x100005788
0000000100005b44	xorl	%r15d, %r15d
0000000100005b47	movq	$0x0, -0x30(%rbp)
0000000100005b4f	xorl	%eax, %eax
0000000100005b51	movq	-0x30(%rbp), %rdx
0000000100005b55	movq	%rdx, 0x10674(%rip)
0000000100005b5c	movq	%r15, 0x10685(%rip)
0000000100005b63	cmpq	$0x1000001, %rdx                ## imm = 0x1000001
0000000100005b6a	movl	$0x1000000, %ecx                ## imm = 0x1000000
0000000100005b6f	cmovaeq	%rdx, %rcx
0000000100005b73	shrq	$0x10, %rcx
0000000100005b77	pxor	%xmm0, %xmm0
0000000100005b7b	movdqu	%xmm0, 0x104ed(%rip)
0000000100005b83	subq	%rcx, %r15
0000000100005b86	jbe	0x100005c81
0000000100005b8c	testq	%rax, %rax
0000000100005b8f	je	0x100005c81
0000000100005b95	testq	%r15, %r15
0000000100005b98	je	0x100005c81
0000000100005b9e	movq	0x104db(%rip), %rcx
0000000100005ba5	nopw	%cs:(%rax,%rax)
0000000100005bb0	leaq	-0x1(%rax), %rbx
0000000100005bb4	imulq	$0x1228, %rbx, %rdx             ## imm = 0x1228
0000000100005bbb	cmpb	$0x0, (%rcx,%rdx)
0000000100005bbf	jne	0x100005c70
0000000100005bc5	addq	%rcx, %rdx
0000000100005bc8	leaq	-0x1(%r15), %r14
0000000100005bcc	cmpb	$0x0, 0x4(%rdx)
0000000100005bd0	je	0x100005c6d
0000000100005bd6	movb	$0x0, 0x4(%rdx)
0000000100005bda	movl	$0x1, %esi
0000000100005bdf	testq	%rbx, %rbx
0000000100005be2	je	0x100005c4a
0000000100005be4	testq	%r14, %r14
0000000100005be7	je	0x100005c4a
0000000100005be9	movl	$0x2, %edx
0000000100005bee	subq	%rax, %rdx
0000000100005bf1	imulq	$0x1228, %rax, %rax             ## imm = 0x1228
0000000100005bf8	addq	%rax, %rcx
0000000100005bfb	addq	$-0x244c, %rcx                  ## imm = 0xDBB4
0000000100005c02	movl	$0x2, %edi
0000000100005c07	subq	%r15, %rdi
0000000100005c0a	movl	$0x1, %eax
0000000100005c0f	nop
0000000100005c10	cmpb	$0x0, -0x4(%rcx)
0000000100005c14	jne	0x100005c47
0000000100005c16	cmpb	$0x0, (%rcx)
0000000100005c19	je	0x100005c47
0000000100005c1b	decq	%rbx
0000000100005c1e	leaq	(%rdx,%rax), %r8
0000000100005c22	decq	%r14
0000000100005c25	movb	$0x0, (%rcx)
0000000100005c28	leaq	0x1(%rax), %rsi
0000000100005c2c	cmpq	$0x1, %r8
0000000100005c30	je	0x100005c4a
0000000100005c32	addq	%rdi, %rax
0000000100005c35	addq	$-0x1228, %rcx                  ## imm = 0xEDD8
0000000100005c3c	cmpq	$0x1, %rax
0000000100005c40	movq	%rsi, %rax
0000000100005c43	jne	0x100005c10
0000000100005c45	jmp	0x100005c4a
0000000100005c47	movq	%rax, %rsi
0000000100005c4a	movq	%rbx, %rdi
0000000100005c4d	shlq	$0x10, %rdi
0000000100005c51	addq	0x103e0(%rip), %rdi
0000000100005c58	shlq	$0x10, %rsi
0000000100005c5c	movl	$0x4, %edx
0000000100005c61	callq	0x1000120a0                     ## symbol stub for: _madvise
0000000100005c66	movq	0x10413(%rip), %rcx
0000000100005c6d	movq	%r14, %r15
0000000100005c70	movq	%rbx, %rax
0000000100005c73	testq	%rbx, %rbx
0000000100005c76	je	0x100005c81
0000000100005c78	testq	%r15, %r15
0000000100005c7b	jne	0x100005bb0
0000000100005c81	addq	$0x28, %rsp
0000000100005c85	popq	%rbx
0000000100005c86	popq	%r12
0000000100005c88	popq	%r13
0000000100005c8a	popq	%r14
0000000100005c8c	popq	%r15
0000000100005c8e	popq	%rbp
0000000100005c8f	retq
_fwp_gc_sp:
0000000100005c90	pushq	%rbp
0000000100005c91	movq	%rsp, %rbp
0000000100005c94	movq	%rbp, %rax
0000000100005c97	popq	%rbp
0000000100005c98	retq
0000000100005c99	nopl	(%rax)
_fwp_gc_scan:
0000000100005ca0	pushq	%rbp
0000000100005ca1	movq	%rsp, %rbp
0000000100005ca4	pushq	%r15
0000000100005ca6	pushq	%r14
0000000100005ca8	pushq	%r13
0000000100005caa	pushq	%r12
0000000100005cac	pushq	%rbx
0000000100005cad	pushq	%rax
0000000100005cae	movq	%rdi, %r15
0000000100005cb1	addq	$0x7, %r15
0000000100005cb5	andq	$-0x8, %r15
0000000100005cb9	leaq	0x8(%r15), %rax
0000000100005cbd	cmpq	%rsi, %rax
0000000100005cc0	jbe	0x100005cd1
0000000100005cc2	addq	$0x8, %rsp
0000000100005cc6	popq	%rbx
0000000100005cc7	popq	%r12
0000000100005cc9	popq	%r13
0000000100005ccb	popq	%r14
0000000100005ccd	popq	%r15
0000000100005ccf	popq	%rbp
0000000100005cd0	retq
0000000100005cd1	movl	%edx, %ebx
0000000100005cd3	movq	%rsi, %r14
0000000100005cd6	movq	0x1035b(%rip), %r11
0000000100005cdd	movq	0x1037c(%rip), %r13
0000000100005ce4	shlq	$0x10, %r13
0000000100005ce8	movq	%r11, -0x30(%rbp)
0000000100005cec	jmp	0x100005d20
0000000100005cee	movl	0x10(%r9), %eax
0000000100005cf2	imulq	$0x1228, %rax, %rdx             ## imm = 0x1228
0000000100005cf9	addq	%rdx, %rcx
0000000100005cfc	movq	%rcx, %r9
0000000100005cff	cmpb	$0x0, 0x3(%r9)
0000000100005d04	je	0x100005f09
0000000100005d0a	nopw	(%rax,%rax)
0000000100005d10	leaq	0x8(%r15), %rax
0000000100005d14	addq	$0x10, %r15
0000000100005d18	cmpq	%r14, %r15
0000000100005d1b	movq	%rax, %r15
0000000100005d1e	ja	0x100005cc2
0000000100005d20	movq	(%r15), %r12
0000000100005d23	movq	%r12, %rax
0000000100005d26	subq	%r11, %rax
0000000100005d29	cmpq	%r13, %rax
0000000100005d2c	jae	0x100005df0
0000000100005d32	movq	0x102ff(%rip), %rdi
0000000100005d39	movq	%r12, %r8
0000000100005d3c	subq	%rdi, %r8
0000000100005d3f	movq	0x1031a(%rip), %rax
0000000100005d46	shlq	$0x10, %rax
0000000100005d4a	cmpq	%rax, %r8
0000000100005d4d	jae	0x100005e40
0000000100005d53	movq	0x10326(%rip), %rcx
0000000100005d5a	testq	%rcx, %rcx
0000000100005d5d	je	0x100005e40
0000000100005d63	movq	%r8, %rax
0000000100005d66	shrq	$0x10, %rax
0000000100005d6a	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100005d71	addq	%rcx, %r9
0000000100005d74	movzbl	(%r9), %edx
0000000100005d78	cmpl	$0x3, %edx
0000000100005d7b	je	0x100005e02
0000000100005d81	cmpl	$0x2, %edx
0000000100005d84	je	0x100005e13
0000000100005d8a	cmpl	$0x1, %edx
0000000100005d8d	jne	0x100005e40
0000000100005d93	movl	0x8(%r9), %esi
0000000100005d97	movzwl	%r12w, %eax
0000000100005d9b	xorl	%edx, %edx
0000000100005d9d	divl	%esi
0000000100005d9f	cmpl	0xc(%r9), %eax
0000000100005da3	jae	0x100005e40
0000000100005da9	movl	$0x1, %edx
0000000100005dae	movl	%eax, %ecx
0000000100005db0	shlq	%cl, %rdx
0000000100005db3	movl	%eax, %ecx
0000000100005db5	shrl	$0x6, %ecx
0000000100005db8	movq	0x28(%r9,%rcx,8), %r10
0000000100005dbd	btq	%rax, %r10
0000000100005dc1	jb	0x100005e40
0000000100005dc7	orq	%rdx, %r10
0000000100005dca	movq	%r10, 0x28(%r9,%rcx,8)
0000000100005dcf	cmpb	$0x1, 0x1(%r9)
0000000100005dd4	je	0x100005e40
0000000100005dd6	andq	$-0x10000, %r8                  ## imm = 0xFFFF0000
0000000100005ddd	addq	%r8, %rdi
0000000100005de0	imulq	%rsi, %rax
0000000100005de4	addq	%rdi, %rax
0000000100005de7	movq	%rax, %rdi
0000000100005dea	jmp	0x100005e31
0000000100005dec	nopl	(%rax)
0000000100005df0	testl	%ebx, %ebx
0000000100005df2	je	0x100005d10
0000000100005df8	cmpq	%r13, %rax
0000000100005dfb	je	0x100005e48
0000000100005dfd	jmp	0x100005d10
0000000100005e02	movl	0x10(%r9), %eax
0000000100005e06	imulq	$0x1228, %rax, %rdx             ## imm = 0x1228
0000000100005e0d	addq	%rdx, %rcx
0000000100005e10	movq	%rcx, %r9
0000000100005e13	cmpb	$0x0, 0x3(%r9)
0000000100005e18	jne	0x100005e40
0000000100005e1a	movb	$0x1, 0x3(%r9)
0000000100005e1f	cmpb	$0x1, 0x1(%r9)
0000000100005e24	je	0x100005e40
0000000100005e26	shlq	$0x10, %rax
0000000100005e2a	addq	%rax, %rdi
0000000100005e2d	movq	0x18(%r9), %rsi
0000000100005e31	callq	_fwp_gc_push
0000000100005e36	movq	-0x30(%rbp), %r11
0000000100005e3a	nopw	(%rax,%rax)
0000000100005e40	testl	%ebx, %ebx
0000000100005e42	je	0x100005d10
0000000100005e48	decq	%r12
0000000100005e4b	movq	0x101e6(%rip), %rdi
0000000100005e52	movq	%r12, %r8
0000000100005e55	subq	%rdi, %r8
0000000100005e58	movq	0x10201(%rip), %rax
0000000100005e5f	shlq	$0x10, %rax
0000000100005e63	cmpq	%rax, %r8
0000000100005e66	jae	0x100005d10
0000000100005e6c	movq	0x1020d(%rip), %rcx
0000000100005e73	testq	%rcx, %rcx
0000000100005e76	je	0x100005d10
0000000100005e7c	movq	%r8, %rax
0000000100005e7f	shrq	$0x10, %rax
0000000100005e83	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100005e8a	addq	%rcx, %r9
0000000100005e8d	movzbl	(%r9), %edx
0000000100005e91	cmpl	$0x3, %edx
0000000100005e94	je	0x100005cee
0000000100005e9a	cmpl	$0x2, %edx
0000000100005e9d	je	0x100005cff
0000000100005ea3	cmpl	$0x1, %edx
0000000100005ea6	jne	0x100005d10
0000000100005eac	movl	0x8(%r9), %esi
0000000100005eb0	movzwl	%r12w, %eax
0000000100005eb4	xorl	%edx, %edx
0000000100005eb6	divl	%esi
0000000100005eb8	cmpl	0xc(%r9), %eax
0000000100005ebc	jae	0x100005d10
0000000100005ec2	movl	$0x1, %edx
0000000100005ec7	movl	%eax, %ecx
0000000100005ec9	shlq	%cl, %rdx
0000000100005ecc	movl	%eax, %ecx
0000000100005ece	shrl	$0x6, %ecx
0000000100005ed1	movq	0x28(%r9,%rcx,8), %r10
0000000100005ed6	btq	%rax, %r10
0000000100005eda	jb	0x100005d10
0000000100005ee0	orq	%rdx, %r10
0000000100005ee3	movq	%r10, 0x28(%r9,%rcx,8)
0000000100005ee8	cmpb	$0x1, 0x1(%r9)
0000000100005eed	je	0x100005d10
0000000100005ef3	andq	$-0x10000, %r8                  ## imm = 0xFFFF0000
0000000100005efa	addq	%r8, %rdi
0000000100005efd	imulq	%rsi, %rax
0000000100005f01	addq	%rdi, %rax
0000000100005f04	movq	%rax, %rdi
0000000100005f07	jmp	0x100005f24
0000000100005f09	movb	$0x1, 0x3(%r9)
0000000100005f0e	cmpb	$0x1, 0x1(%r9)
0000000100005f13	je	0x100005d10
0000000100005f19	shlq	$0x10, %rax
0000000100005f1d	addq	%rax, %rdi
0000000100005f20	movq	0x18(%r9), %rsi
0000000100005f24	callq	_fwp_gc_push
0000000100005f29	movq	-0x30(%rbp), %r11
0000000100005f2d	jmp	0x100005d10
0000000100005f32	nopw	%cs:(%rax,%rax)
_fwp_gc_push:
0000000100005f40	pushq	%rbp
0000000100005f41	movq	%rsp, %rbp
0000000100005f44	pushq	%r14
0000000100005f46	pushq	%rbx
0000000100005f47	movq	%rsi, %rbx
0000000100005f4a	movq	%rdi, %r14
0000000100005f4d	movq	0x10254(%rip), %rcx
0000000100005f54	movq	0x10245(%rip), %rax
0000000100005f5b	cmpq	0x1024e(%rip), %rcx
0000000100005f62	jne	0x100005f9a
0000000100005f64	leaq	(%rcx,%rcx), %rdx
0000000100005f68	testq	%rcx, %rcx
0000000100005f6b	movl	$0x1000, %esi                   ## imm = 0x1000
0000000100005f70	cmovneq	%rdx, %rsi
0000000100005f74	movq	%rsi, 0x10235(%rip)
0000000100005f7b	shlq	$0x4, %rsi
0000000100005f7f	movq	%rax, %rdi
0000000100005f82	callq	0x1000120fa                     ## symbol stub for: _realloc
0000000100005f87	movq	%rax, 0x10212(%rip)
0000000100005f8e	testq	%rax, %rax
0000000100005f91	je	0x100005fb9
0000000100005f93	movq	0x1020e(%rip), %rcx
0000000100005f9a	movq	%rcx, %rdx
0000000100005f9d	shlq	$0x4, %rdx
0000000100005fa1	movq	%r14, (%rax,%rdx)
0000000100005fa5	movq	%rbx, 0x8(%rax,%rdx)
0000000100005faa	incq	%rcx
0000000100005fad	movq	%rcx, 0x101f4(%rip)
0000000100005fb4	popq	%rbx
0000000100005fb5	popq	%r14
0000000100005fb7	popq	%rbp
0000000100005fb8	retq
0000000100005fb9	movq	0xe078(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100005fc0	movq	(%rax), %rcx
0000000100005fc3	leaq	0xc8d5(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100005fca	movl	$0x13, %esi
0000000100005fcf	movl	$0x1, %edx
0000000100005fd4	callq	0x100012088                     ## symbol stub for: _fwrite
0000000100005fd9	movl	$0x66, %edi
0000000100005fde	callq	0x100012058                     ## symbol stub for: _exit
0000000100005fe3	nopw	%cs:(%rax,%rax)
_f29:
0000000100005ff0	pushq	%rbp
0000000100005ff1	movq	%rsp, %rbp
0000000100005ff4	pushq	%r15
0000000100005ff6	pushq	%r14
0000000100005ff8	pushq	%r13
0000000100005ffa	pushq	%r12
0000000100005ffc	pushq	%rbx
0000000100005ffd	subq	$0xd8, %rsp
0000000100006004	movq	%rdi, %rbx
0000000100006007	movq	0xe022(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000600e	movq	(%rax), %rax
0000000100006011	movq	%rax, -0x30(%rbp)
0000000100006015	movq	%rdi, -0xa0(%rbp)
000000010000601c	movq	_fwp_cleanups(%rip), %rax
0000000100006023	movq	%rax, -0x98(%rbp)
000000010000602a	leaq	_fwp_owner_release4(%rip), %rax
0000000100006031	movq	%rax, -0x90(%rbp)
0000000100006038	leaq	-0xa0(%rbp), %rax
000000010000603f	movq	%rax, -0x88(%rbp)
0000000100006046	movq	$0x0, -0x78(%rbp)
000000010000604e	leaq	-0x98(%rbp), %r12
0000000100006055	movq	%r12, -0xd0(%rbp)
000000010000605c	leaq	_fwp_owner_release5(%rip), %rax
0000000100006063	movq	%rax, -0xc8(%rbp)
000000010000606a	leaq	-0x78(%rbp), %rax
000000010000606e	movq	%rax, -0xc0(%rbp)
0000000100006075	leaq	-0xd0(%rbp), %r14
000000010000607c	movq	%r14, _fwp_cleanups(%rip)
0000000100006083	movq	0x10(%rdi), %rax
0000000100006087	subq	0xffaa(%rip), %rax
000000010000608e	movq	0xffcb(%rip), %rcx
0000000100006095	shlq	$0x10, %rcx
0000000100006099	cmpq	%rcx, %rax
000000010000609c	jae	0x100006106
000000010000609e	movq	0xffdb(%rip), %rcx
00000001000060a5	movq	%rax, %rdx
00000001000060a8	shrq	$0x10, %rdx
00000001000060ac	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000060b3	leaq	(%rcx,%rdx), %rdi
00000001000060b7	movzbl	(%rcx,%rdx), %ecx
00000001000060bb	cmpb	$0x2, %cl
00000001000060be	setne	%dl
00000001000060c1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000060c7	setne	%sil
00000001000060cb	orb	%dl, %sil
00000001000060ce	jne	0x1000060d9
00000001000060d0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000060d7	jmp	0x1000060f3
00000001000060d9	cmpb	$0x1, %cl
00000001000060dc	jne	0x100006106
00000001000060de	movl	0x20(%rdi), %ecx
00000001000060e1	imulq	%rcx, %rax
00000001000060e5	shrq	$0x20, %rax
00000001000060e9	addq	%rax, %rdi
00000001000060ec	addq	$0x228, %rdi                    ## imm = 0x228
00000001000060f3	movzbl	(%rdi), %eax
00000001000060f6	testb	%al, %al
00000001000060f8	je	0x100006106
00000001000060fa	cmpb	$-0x3, %al
00000001000060fc	ja	0x1000065e7
0000000100006102	incb	%al
0000000100006104	movb	%al, (%rdi)
0000000100006106	movq	0x10(%rbx), %rdi
000000010000610a	movq	%rdi, -0x78(%rbp)
000000010000610e	movq	-0xd0(%rbp), %rax
0000000100006115	movq	%rax, _fwp_cleanups(%rip)
000000010000611c	movq	0x8(%rbx), %r13
0000000100006120	movsd	0x18(%rbx), %xmm0
0000000100006125	testq	%r13, %r13
0000000100006128	movsd	%xmm0, -0x70(%rbp)
000000010000612d	js	0x100006172
000000010000612f	movq	(%rdi), %rdx
0000000100006132	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000613c	andq	%rdx, %rax
000000010000613f	cmpq	%r13, %rax
0000000100006142	jbe	0x100006172
0000000100006144	movl	_d0(%rip), %eax
000000010000614a	movl	$0x8, %ecx
000000010000614f	cmpq	$0xa, %rax
0000000100006153	ja	0x100006160
0000000100006155	leaq	0xc40c(%rip), %rcx
000000010000615c	movq	(%rcx,%rax,8), %rcx
0000000100006160	testq	%rdx, %rdx
0000000100006163	js	0x10000623f
0000000100006169	leaq	0x8(%rdi), %rdx
000000010000616d	jmp	0x100006243
0000000100006172	callq	_fwp_drop0
0000000100006177	movsd	-0x70(%rbp), %xmm0
000000010000617c	movsd	%xmm0, -0x48(%rbp)
0000000100006181	movl	$0x10, %edi
0000000100006186	callq	_fwp_alloc_init
000000010000618b	movq	%rax, %r14
000000010000618e	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100006198	movq	%rax, (%r14)
000000010000619b	movsd	-0x70(%rbp), %xmm0
00000001000061a0	movsd	%xmm0, 0x8(%r14)
00000001000061a6	leaq	-0x48(%rbp), %rax
00000001000061aa	movq	%r14, %rax
00000001000061ad	subq	0xfe84(%rip), %rax
00000001000061b4	movq	0xfea5(%rip), %rcx
00000001000061bb	shlq	$0x10, %rcx
00000001000061bf	cmpq	%rcx, %rax
00000001000061c2	jae	0x1000065a3
00000001000061c8	movq	0xfeb1(%rip), %rcx
00000001000061cf	movq	%rax, %rdx
00000001000061d2	shrq	$0x10, %rdx
00000001000061d6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000061dd	leaq	(%rcx,%rdx), %r15
00000001000061e1	movzbl	(%rcx,%rdx), %ecx
00000001000061e5	cmpb	$0x2, %cl
00000001000061e8	setne	%dl
00000001000061eb	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000061f1	setne	%sil
00000001000061f5	orb	%dl, %sil
00000001000061f8	jne	0x100006210
00000001000061fa	addq	$0x228, %r15                    ## imm = 0x228
0000000100006201	cmpb	$-0x1, (%r15)
0000000100006205	je	0x100006235
0000000100006207	movb	$0x1, (%r15)
000000010000620b	jmp	0x1000065a3
0000000100006210	cmpb	$0x1, %cl
0000000100006213	jne	0x1000065a3
0000000100006219	movl	0x20(%r15), %ecx
000000010000621d	imulq	%rcx, %rax
0000000100006221	shrq	$0x20, %rax
0000000100006225	addq	%rax, %r15
0000000100006228	addq	$0x228, %r15                    ## imm = 0x228
000000010000622f	cmpb	$-0x1, (%r15)
0000000100006233	jne	0x100006207
0000000100006235	movq	%r15, %rdi
0000000100006238	callq	_fwp_rc_forget_slot
000000010000623d	jmp	0x100006207
000000010000623f	movq	0x10(%rdi), %rdx
0000000100006243	movq	%rcx, %rsi
0000000100006246	imulq	%r13, %rsi
000000010000624a	cmpq	$0x1, %rcx
000000010000624e	je	0x10000626f
0000000100006250	cmpq	$0x2, %rcx
0000000100006254	je	0x100006262
0000000100006256	cmpq	$0x8, %rcx
000000010000625a	jne	0x10000627c
000000010000625c	movq	(%rdx,%rsi), %r14
0000000100006260	jmp	0x100006289
0000000100006262	movzwl	(%rdx,%rsi), %ecx
0000000100006266	cmpl	$0x1, %eax
0000000100006269	movswq	%cx, %r14
000000010000626d	jmp	0x100006285
000000010000626f	movzbl	(%rdx,%rsi), %ecx
0000000100006273	testq	%rax, %rax
0000000100006276	movsbq	%cl, %r14
000000010000627a	jmp	0x100006285
000000010000627c	movl	(%rdx,%rsi), %ecx
000000010000627f	cmpl	$0x2, %eax
0000000100006282	movslq	%ecx, %r14
0000000100006285	cmovneq	%rcx, %r14
0000000100006289	movq	_fwp_cleanups(%rip), %rax
0000000100006290	movq	%rdi, -0xb8(%rbp)
0000000100006297	movq	%rax, -0x48(%rbp)
000000010000629b	leaq	_fwp_owner_release1(%rip), %rax
00000001000062a2	movq	%rax, -0x40(%rbp)
00000001000062a6	leaq	-0xb8(%rbp), %rax
00000001000062ad	movq	%rax, -0x38(%rbp)
00000001000062b1	leaq	-0x48(%rbp), %r15
00000001000062b5	movq	%rdi, %rcx
00000001000062b8	subq	0xfd79(%rip), %rcx
00000001000062bf	movq	%r15, _fwp_cleanups(%rip)
00000001000062c6	movq	0xfd93(%rip), %rax
00000001000062cd	shlq	$0x10, %rax
00000001000062d1	cmpq	%rax, %rcx
00000001000062d4	jae	0x10000633f
00000001000062d6	movq	0xfda3(%rip), %rdx
00000001000062dd	movq	%rcx, %rax
00000001000062e0	shrq	$0x10, %rax
00000001000062e4	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000062eb	leaq	(%rdx,%rsi), %rax
00000001000062ef	movzbl	(%rdx,%rsi), %edx
00000001000062f3	cmpb	$0x2, %dl
00000001000062f6	setne	%sil
00000001000062fa	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100006301	setne	%r8b
0000000100006305	orb	%sil, %r8b
0000000100006308	jne	0x100006312
000000010000630a	addq	$0x228, %rax                    ## imm = 0x228
0000000100006310	jmp	0x10000632b
0000000100006312	cmpb	$0x1, %dl
0000000100006315	jne	0x10000633f
0000000100006317	movl	0x20(%rax), %edx
000000010000631a	imulq	%rdx, %rcx
000000010000631e	shrq	$0x20, %rcx
0000000100006322	addq	%rcx, %rax
0000000100006325	addq	$0x228, %rax                    ## imm = 0x228
000000010000632b	movzbl	(%rax), %ecx
000000010000632e	testb	%cl, %cl
0000000100006330	je	0x10000633f
0000000100006332	cmpb	$-0x3, %cl
0000000100006335	ja	0x100006606
000000010000633b	incb	%cl
000000010000633d	movb	%cl, (%rax)
000000010000633f	incq	%r13
0000000100006342	movq	%r14, %xmm0
0000000100006347	mulsd	0xbfa1(%rip), %xmm0
000000010000634f	addsd	0xbfa1(%rip), %xmm0
0000000100006357	movsd	%xmm0, -0x80(%rbp)
000000010000635c	movq	-0x48(%rbp), %rax
0000000100006360	movq	%rax, _fwp_cleanups(%rip)
0000000100006367	movq	%rdi, %r14
000000010000636a	callq	_fwp_drop0
000000010000636f	movsd	-0x70(%rbp), %xmm0
0000000100006374	addsd	-0x80(%rbp), %xmm0
0000000100006379	movsd	%xmm0, -0x70(%rbp)
000000010000637e	movq	%r14, -0xb0(%rbp)
0000000100006385	movq	_fwp_cleanups(%rip), %rax
000000010000638c	movq	%rax, -0x100(%rbp)
0000000100006393	leaq	_fwp_owner_release2(%rip), %rax
000000010000639a	movq	%rax, -0xf8(%rbp)
00000001000063a1	leaq	-0xb0(%rbp), %rax
00000001000063a8	movq	%rax, -0xf0(%rbp)
00000001000063af	leaq	-0x100(%rbp), %r12
00000001000063b6	movq	%r12, _fwp_cleanups(%rip)
00000001000063bd	movq	%r13, -0x60(%rbp)
00000001000063c1	movq	%r14, -0x58(%rbp)
00000001000063c5	movsd	%xmm0, -0x50(%rbp)
00000001000063ca	movl	$0x20, %edi
00000001000063cf	callq	_fwp_alloc_init
00000001000063d4	movq	%rax, %r15
00000001000063d7	movabsq	$0x300000000, %rax              ## imm = 0x300000000
00000001000063e1	movq	%rax, (%r15)
00000001000063e4	movq	%r13, 0x8(%r15)
00000001000063e8	movq	%r14, 0x10(%r15)
00000001000063ec	movsd	-0x70(%rbp), %xmm0
00000001000063f1	movsd	%xmm0, 0x18(%r15)
00000001000063f7	leaq	-0x60(%rbp), %rax
00000001000063fb	movq	%r15, %rax
00000001000063fe	subq	0xfc33(%rip), %rax
0000000100006405	movq	0xfc54(%rip), %rcx
000000010000640c	shlq	$0x10, %rcx
0000000100006410	cmpq	%rcx, %rax
0000000100006413	jae	0x100006485
0000000100006415	movq	0xfc64(%rip), %rcx
000000010000641c	movq	%rax, %rdx
000000010000641f	shrq	$0x10, %rdx
0000000100006423	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000642a	leaq	(%rcx,%rdx), %r14
000000010000642e	movzbl	(%rcx,%rdx), %ecx
0000000100006432	cmpb	$0x2, %cl
0000000100006435	setne	%dl
0000000100006438	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000643e	setne	%sil
0000000100006442	orb	%dl, %sil
0000000100006445	jne	0x10000645a
0000000100006447	addq	$0x228, %r14                    ## imm = 0x228
000000010000644e	cmpb	$-0x1, (%r14)
0000000100006452	je	0x10000647b
0000000100006454	movb	$0x1, (%r14)
0000000100006458	jmp	0x100006485
000000010000645a	cmpb	$0x1, %cl
000000010000645d	jne	0x100006485
000000010000645f	movl	0x20(%r14), %ecx
0000000100006463	imulq	%rcx, %rax
0000000100006467	shrq	$0x20, %rax
000000010000646b	addq	%rax, %r14
000000010000646e	addq	$0x228, %r14                    ## imm = 0x228
0000000100006475	cmpb	$-0x1, (%r14)
0000000100006479	jne	0x100006454
000000010000647b	movq	%r14, %rdi
000000010000647e	callq	_fwp_rc_forget_slot
0000000100006483	jmp	0x100006454
0000000100006485	cmpq	%r12, _fwp_cleanups(%rip)
000000010000648c	jne	0x100006621
0000000100006492	movq	-0x100(%rbp), %rax
0000000100006499	movq	%r15, -0xa8(%rbp)
00000001000064a0	movq	%rax, -0xe8(%rbp)
00000001000064a7	leaq	_fwp_owner_release3(%rip), %rax
00000001000064ae	movq	%rax, -0xe0(%rbp)
00000001000064b5	leaq	-0xa8(%rbp), %rax
00000001000064bc	movq	%rax, -0xd8(%rbp)
00000001000064c3	leaq	-0xe8(%rbp), %r12
00000001000064ca	movq	%r12, _fwp_cleanups(%rip)
00000001000064d1	movq	%r15, -0x68(%rbp)
00000001000064d5	movl	$0x10, %edi
00000001000064da	callq	_fwp_alloc_init
00000001000064df	movq	%rax, %r14
00000001000064e2	movabsq	$__mh_execute_header, %rax
00000001000064ec	movq	%rax, (%r14)
00000001000064ef	movq	%r15, 0x8(%r14)
00000001000064f3	leaq	-0x68(%rbp), %rax
00000001000064f7	movq	%r14, %rax
00000001000064fa	subq	0xfb37(%rip), %rax
0000000100006501	movq	0xfb58(%rip), %rcx
0000000100006508	shlq	$0x10, %rcx
000000010000650c	cmpq	%rcx, %rax
000000010000650f	jae	0x100006581
0000000100006511	movq	0xfb68(%rip), %rcx
0000000100006518	movq	%rax, %rdx
000000010000651b	shrq	$0x10, %rdx
000000010000651f	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006526	leaq	(%rcx,%rdx), %r15
000000010000652a	movzbl	(%rcx,%rdx), %ecx
000000010000652e	cmpb	$0x2, %cl
0000000100006531	setne	%dl
0000000100006534	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000653a	setne	%sil
000000010000653e	orb	%dl, %sil
0000000100006541	jne	0x100006556
0000000100006543	addq	$0x228, %r15                    ## imm = 0x228
000000010000654a	cmpb	$-0x1, (%r15)
000000010000654e	je	0x100006577
0000000100006550	movb	$0x1, (%r15)
0000000100006554	jmp	0x100006581
0000000100006556	cmpb	$0x1, %cl
0000000100006559	jne	0x100006581
000000010000655b	movl	0x20(%r15), %ecx
000000010000655f	imulq	%rcx, %rax
0000000100006563	shrq	$0x20, %rax
0000000100006567	addq	%rax, %r15
000000010000656a	addq	$0x228, %r15                    ## imm = 0x228
0000000100006571	cmpb	$-0x1, (%r15)
0000000100006575	jne	0x100006550
0000000100006577	movq	%r15, %rdi
000000010000657a	callq	_fwp_rc_forget_slot
000000010000657f	jmp	0x100006550
0000000100006581	cmpq	%r12, _fwp_cleanups(%rip)
0000000100006588	jne	0x100006621
000000010000658e	movq	-0xe8(%rbp), %rax
0000000100006595	movq	%rax, _fwp_cleanups(%rip)
000000010000659c	leaq	-0x98(%rbp), %r12
00000001000065a3	cmpq	%r12, _fwp_cleanups(%rip)
00000001000065aa	jne	0x100006621
00000001000065ac	movq	-0x98(%rbp), %rax
00000001000065b3	movq	%rax, _fwp_cleanups(%rip)
00000001000065ba	movq	%rbx, %rdi
00000001000065bd	callq	_fwp_drop1
00000001000065c2	movq	0xda67(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000065c9	movq	(%rax), %rax
00000001000065cc	cmpq	-0x30(%rbp), %rax
00000001000065d0	jne	0x100006626
00000001000065d2	movq	%r14, %rax
00000001000065d5	addq	$0xd8, %rsp
00000001000065dc	popq	%rbx
00000001000065dd	popq	%r12
00000001000065df	popq	%r13
00000001000065e1	popq	%r14
00000001000065e3	popq	%r15
00000001000065e5	popq	%rbp
00000001000065e6	retq
00000001000065e7	callq	_fwp_rc_wide_dup
00000001000065ec	movq	_fwp_cleanups(%rip), %rax
00000001000065f3	movq	0x10(%rbx), %rdi
00000001000065f7	movq	%rdi, -0x78(%rbp)
00000001000065fb	cmpq	%r14, %rax
00000001000065fe	je	0x10000610e
0000000100006604	jmp	0x100006621
0000000100006606	movq	%rdi, %r12
0000000100006609	movq	%rax, %rdi
000000010000660c	callq	_fwp_rc_wide_dup
0000000100006611	movq	%r12, %rdi
0000000100006614	cmpq	%r15, _fwp_cleanups(%rip)
000000010000661b	je	0x10000633f
0000000100006621	callq	0x10001203a                     ## symbol stub for: _abort
0000000100006626	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000662b	nopl	(%rax,%rax)
_fwp_owner_release4:
0000000100006630	pushq	%rbp
0000000100006631	movq	%rsp, %rbp
0000000100006634	movq	(%rdi), %rdi
0000000100006637	popq	%rbp
0000000100006638	jmp	_fwp_drop1
000000010000663d	nopl	(%rax)
_fwp_owner_release5:
0000000100006640	pushq	%rbp
0000000100006641	movq	%rsp, %rbp
0000000100006644	movq	(%rdi), %rdi
0000000100006647	popq	%rbp
0000000100006648	jmp	_fwp_drop0
000000010000664d	nopl	(%rax)
_fwp_drop1:
0000000100006650	movq	%rdi, %rcx
0000000100006653	subq	0xf9de(%rip), %rcx
000000010000665a	movq	0xf9ff(%rip), %rax
0000000100006661	shlq	$0x10, %rax
0000000100006665	cmpq	%rax, %rcx
0000000100006668	jae	0x1000066fe
000000010000666e	movq	0xfa0b(%rip), %rdx
0000000100006675	movq	%rcx, %rax
0000000100006678	shrq	$0x10, %rax
000000010000667c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100006683	leaq	(%rdx,%rsi), %rax
0000000100006687	movzbl	(%rdx,%rsi), %edx
000000010000668b	cmpb	$0x2, %dl
000000010000668e	setne	%sil
0000000100006692	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100006699	setne	%r8b
000000010000669d	orb	%sil, %r8b
00000001000066a0	jne	0x1000066aa
00000001000066a2	addq	$0x228, %rax                    ## imm = 0x228
00000001000066a8	jmp	0x1000066c3
00000001000066aa	cmpb	$0x1, %dl
00000001000066ad	jne	0x1000066fe
00000001000066af	movl	0x20(%rax), %edx
00000001000066b2	imulq	%rdx, %rcx
00000001000066b6	shrq	$0x20, %rcx
00000001000066ba	addq	%rcx, %rax
00000001000066bd	addq	$0x228, %rax                    ## imm = 0x228
00000001000066c3	movzbl	(%rax), %ecx
00000001000066c6	testl	%ecx, %ecx
00000001000066c8	je	0x1000066fe
00000001000066ca	cmpl	$0x1, %ecx
00000001000066cd	jne	0x1000066f2
00000001000066cf	pushq	%rbp
00000001000066d0	movq	%rsp, %rbp
00000001000066d3	pushq	%rbx
00000001000066d4	pushq	%rax
00000001000066d5	movq	0x10(%rdi), %rax
00000001000066d9	movq	%rdi, %rbx
00000001000066dc	movq	%rax, %rdi
00000001000066df	callq	_fwp_drop0
00000001000066e4	movq	%rbx, %rdi
00000001000066e7	addq	$0x8, %rsp
00000001000066eb	popq	%rbx
00000001000066ec	popq	%rbp
00000001000066ed	jmp	_fwp_rc_free_obj
00000001000066f2	cmpl	$0xff, %ecx
00000001000066f8	je	0x1000066ff
00000001000066fa	decb	%cl
00000001000066fc	movb	%cl, (%rax)
00000001000066fe	retq
00000001000066ff	movq	%rax, %rdi
0000000100006702	jmp	_fwp_rc_wide_drop
0000000100006707	nopw	(%rax,%rax)
_fwp_rc_wide_dup:
0000000100006710	pushq	%rbp
0000000100006711	movq	%rsp, %rbp
0000000100006714	pushq	%r14
0000000100006716	pushq	%rbx
0000000100006717	movq	%rdi, %rbx
000000010000671a	movq	%rdi, %rax
000000010000671d	shrq	$0x11, %rax
0000000100006721	xorl	%ebx, %eax
0000000100006723	movl	%eax, %ecx
0000000100006725	shrl	$0x9, %ecx
0000000100006728	xorl	%eax, %ecx
000000010000672a	movzbl	%cl, %eax
000000010000672d	leaq	_fwp_gc(%rip), %rcx
0000000100006734	leaq	(%rcx,%rax,8), %r14
0000000100006738	addq	$0x1218, %r14                   ## imm = 0x1218
000000010000673f	movq	0x1218(%rcx,%rax,8), %rax
0000000100006747	testq	%rax, %rax
000000010000674a	je	0x100006773
000000010000674c	cmpq	%rbx, (%rax)
000000010000674f	je	0x100006780
0000000100006751	nopw	%cs:(%rax,%rax)
0000000100006760	movq	%rax, %r14
0000000100006763	movq	0x10(%rax), %rax
0000000100006767	testq	%rax, %rax
000000010000676a	je	0x10000677a
000000010000676c	cmpq	%rbx, (%rax)
000000010000676f	jne	0x100006760
0000000100006771	jmp	0x10000677c
0000000100006773	cmpb	$-0x2, (%rbx)
0000000100006776	je	0x10000678e
0000000100006778	jmp	0x1000067e4
000000010000677a	xorl	%eax, %eax
000000010000677c	addq	$0x10, %r14
0000000100006780	cmpb	$-0x2, (%rbx)
0000000100006783	jne	0x1000067c6
0000000100006785	testq	%rax, %rax
0000000100006788	jne	0x10000682d
000000010000678e	movl	$0x18, %edi
0000000100006793	callq	0x1000120a6                     ## symbol stub for: _malloc
0000000100006798	testq	%rax, %rax
000000010000679b	je	0x100006803
000000010000679d	movq	%rbx, (%rax)
00000001000067a0	movq	$0xff, 0x8(%rax)
00000001000067a8	movq	$0x0, 0x10(%rax)
00000001000067b0	movq	%rax, (%r14)
00000001000067b3	movb	$-0x1, (%rbx)
00000001000067b6	leaq	0x10263(%rip), %rax
00000001000067bd	movq	0x1025c(%rip), %rcx
00000001000067c4	jmp	0x1000067d9
00000001000067c6	testq	%rax, %rax
00000001000067c9	je	0x1000067e4
00000001000067cb	movq	0x8(%rax), %rcx
00000001000067cf	cmpq	$-0x1, %rcx
00000001000067d3	je	0x10000684c
00000001000067d5	addq	$0x8, %rax
00000001000067d9	incq	%rcx
00000001000067dc	movq	%rcx, (%rax)
00000001000067df	popq	%rbx
00000001000067e0	popq	%r14
00000001000067e2	popq	%rbp
00000001000067e3	retq
00000001000067e4	callq	_fwp_flush
00000001000067e9	movq	0xd848(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000067f0	movq	(%rax), %rdi
00000001000067f3	leaq	0xc025(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000067fa	leaq	0xbff7(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100006801	jmp	0x100006869
0000000100006803	movq	0xd82e(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000680a	movq	(%rax), %rcx
000000010000680d	leaq	0xc08b(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100006814	movl	$0x13, %esi
0000000100006819	movl	$0x1, %edx
000000010000681e	callq	0x100012088                     ## symbol stub for: _fwrite
0000000100006823	movl	$0x66, %edi
0000000100006828	callq	0x100012058                     ## symbol stub for: _exit
000000010000682d	callq	_fwp_flush
0000000100006832	movq	0xd7ff(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100006839	movq	(%rax), %rdi
000000010000683c	leaq	0xbfdc(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006843	leaq	0xc11f(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
000000010000684a	jmp	0x100006869
000000010000684c	callq	_fwp_flush
0000000100006851	movq	0xd7e0(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100006858	movq	(%rax), %rdi
000000010000685b	leaq	0xbfbd(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006862	leaq	0xc125(%rip), %rdx              ## literal pool for: "reference count overflow"
0000000100006869	xorl	%eax, %eax
000000010000686b	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100006870	movl	$0x65, %edi
0000000100006875	callq	0x100012058                     ## symbol stub for: _exit
000000010000687a	nopw	(%rax,%rax)
_fwp_owner_release1:
0000000100006880	pushq	%rbp
0000000100006881	movq	%rsp, %rbp
0000000100006884	movq	(%rdi), %rdi
0000000100006887	popq	%rbp
0000000100006888	jmp	_fwp_drop0
000000010000688d	nopl	(%rax)
_fwp_owner_release2:
0000000100006890	pushq	%rbp
0000000100006891	movq	%rsp, %rbp
0000000100006894	movq	(%rdi), %rdi
0000000100006897	popq	%rbp
0000000100006898	jmp	_fwp_drop0
000000010000689d	nopl	(%rax)
_fwp_record:
00000001000068a0	testl	%edi, %edi
00000001000068a2	je	0x100006952
00000001000068a8	pushq	%rbp
00000001000068a9	movq	%rsp, %rbp
00000001000068ac	pushq	%r15
00000001000068ae	pushq	%r14
00000001000068b0	pushq	%rbx
00000001000068b1	pushq	%rax
00000001000068b2	movq	%rsi, %rbx
00000001000068b5	movl	%edi, %r14d
00000001000068b8	leaq	0x8(,%r14,8), %rax
00000001000068c0	movl	%edi, %r15d
00000001000068c3	movq	%rax, %rdi
00000001000068c6	callq	_fwp_alloc_init
00000001000068cb	movl	$0x0, (%rax)
00000001000068d1	movl	%r15d, 0x4(%rax)
00000001000068d5	cmpl	$0x8, %r15d
00000001000068d9	jb	0x1000068eb
00000001000068db	movq	%rax, %rcx
00000001000068de	subq	%rbx, %rcx
00000001000068e1	addq	$0x8, %rcx
00000001000068e5	cmpq	$0x20, %rcx
00000001000068e9	jae	0x100006955
00000001000068eb	xorl	%ecx, %ecx
00000001000068ed	movq	%r14, %rsi
00000001000068f0	movq	%rcx, %rdx
00000001000068f3	andq	$0x3, %rsi
00000001000068f7	je	0x100006911
00000001000068f9	movq	%rcx, %rdx
00000001000068fc	nopl	(%rax)
0000000100006900	movq	(%rbx,%rdx,8), %rdi
0000000100006904	movq	%rdi, 0x8(%rax,%rdx,8)
0000000100006909	incq	%rdx
000000010000690c	decq	%rsi
000000010000690f	jne	0x100006900
0000000100006911	subq	%r14, %rcx
0000000100006914	cmpq	$-0x4, %rcx
0000000100006918	ja	0x100006995
000000010000691a	nopw	(%rax,%rax)
0000000100006920	movq	(%rbx,%rdx,8), %rcx
0000000100006924	movq	%rcx, 0x8(%rax,%rdx,8)
0000000100006929	movq	0x8(%rbx,%rdx,8), %rcx
000000010000692e	movq	%rcx, 0x10(%rax,%rdx,8)
0000000100006933	movq	0x10(%rbx,%rdx,8), %rcx
0000000100006938	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000693d	movq	0x18(%rbx,%rdx,8), %rcx
0000000100006942	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100006947	addq	$0x4, %rdx
000000010000694b	cmpq	%rdx, %r14
000000010000694e	jne	0x100006920
0000000100006950	jmp	0x100006995
0000000100006952	xorl	%eax, %eax
0000000100006954	retq
0000000100006955	movl	%r14d, %ecx
0000000100006958	andl	$-0x4, %ecx
000000010000695b	leaq	(,%r14,8), %rdx
0000000100006963	andq	$-0x20, %rdx
0000000100006967	xorl	%esi, %esi
0000000100006969	nopl	(%rax)
0000000100006970	movups	(%rbx,%rsi), %xmm0
0000000100006974	movups	0x10(%rbx,%rsi), %xmm1
0000000100006979	movups	%xmm0, 0x8(%rax,%rsi)
000000010000697e	movups	%xmm1, 0x18(%rax,%rsi)
0000000100006983	addq	$0x20, %rsi
0000000100006987	cmpq	%rsi, %rdx
000000010000698a	jne	0x100006970
000000010000698c	cmpl	%r14d, %ecx
000000010000698f	jne	0x1000068ed
0000000100006995	addq	$0x8, %rsp
0000000100006999	popq	%rbx
000000010000699a	popq	%r14
000000010000699c	popq	%r15
000000010000699e	popq	%rbp
000000010000699f	retq
_fwp_owner_release3:
00000001000069a0	pushq	%rbp
00000001000069a1	movq	%rsp, %rbp
00000001000069a4	movq	(%rdi), %rax
00000001000069a7	subq	0xf68a(%rip), %rax
00000001000069ae	movq	0xf6ab(%rip), %rcx
00000001000069b5	shlq	$0x10, %rcx
00000001000069b9	cmpq	%rcx, %rax
00000001000069bc	jae	0x100006a22
00000001000069be	movq	0xf6bb(%rip), %rcx
00000001000069c5	movq	%rax, %rdx
00000001000069c8	shrq	$0x10, %rdx
00000001000069cc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000069d3	leaq	(%rcx,%rdx), %rdi
00000001000069d7	movzbl	(%rcx,%rdx), %ecx
00000001000069db	cmpb	$0x2, %cl
00000001000069de	setne	%dl
00000001000069e1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000069e7	setne	%sil
00000001000069eb	orb	%dl, %sil
00000001000069ee	jne	0x1000069f9
00000001000069f0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000069f7	jmp	0x100006a13
00000001000069f9	cmpb	$0x1, %cl
00000001000069fc	jne	0x100006a22
00000001000069fe	movl	0x20(%rdi), %ecx
0000000100006a01	imulq	%rcx, %rax
0000000100006a05	shrq	$0x20, %rax
0000000100006a09	addq	%rax, %rdi
0000000100006a0c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006a13	movzbl	(%rdi), %eax
0000000100006a16	cmpb	$0x2, %al
0000000100006a18	jb	0x100006a22
0000000100006a1a	cmpb	$-0x1, %al
0000000100006a1c	je	0x100006a24
0000000100006a1e	decb	%al
0000000100006a20	movb	%al, (%rdi)
0000000100006a22	popq	%rbp
0000000100006a23	retq
0000000100006a24	popq	%rbp
0000000100006a25	jmp	_fwp_rc_wide_drop
0000000100006a2a	nopw	(%rax,%rax)
_fwp_rc_free_obj:
0000000100006a30	pushq	%rbp
0000000100006a31	movq	%rsp, %rbp
0000000100006a34	pushq	%r15
0000000100006a36	pushq	%r14
0000000100006a38	pushq	%rbx
0000000100006a39	pushq	%rax
0000000100006a3a	movq	%rdi, %rax
0000000100006a3d	subq	0xf5f4(%rip), %rax
0000000100006a44	movq	0xf615(%rip), %rcx
0000000100006a4b	shlq	$0x10, %rcx
0000000100006a4f	cmpq	%rcx, %rax
0000000100006a52	jae	0x100006b6f
0000000100006a58	movq	0xf621(%rip), %rcx
0000000100006a5f	movq	%rax, %rdx
0000000100006a62	shrq	$0x10, %rdx
0000000100006a66	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006a6d	leaq	(%rcx,%rdx), %rbx
0000000100006a71	movzbl	(%rcx,%rdx), %r14d
0000000100006a76	cmpb	$0x2, %r14b
0000000100006a7a	setne	%cl
0000000100006a7d	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006a83	setne	%dl
0000000100006a86	orb	%cl, %dl
0000000100006a88	jne	0x100006a9b
0000000100006a8a	leaq	0x228(%rbx), %rax
0000000100006a91	cmpb	$0x1, (%rax)
0000000100006a94	je	0x100006ac2
0000000100006a96	jmp	0x100006b6f
0000000100006a9b	cmpb	$0x1, %r14b
0000000100006a9f	jne	0x100006b6f
0000000100006aa5	movl	0x20(%rbx), %ecx
0000000100006aa8	imulq	%rcx, %rax
0000000100006aac	shrq	$0x20, %rax
0000000100006ab0	addq	%rbx, %rax
0000000100006ab3	addq	$0x228, %rax                    ## imm = 0x228
0000000100006ab9	cmpb	$0x1, (%rax)
0000000100006abc	jne	0x100006b6f
0000000100006ac2	movl	_fwp_reuse_verify(%rip), %eax
0000000100006ac8	testl	%eax, %eax
0000000100006aca	js	0x100006b2b
0000000100006acc	testl	%eax, %eax
0000000100006ace	je	0x100006b44
0000000100006ad0	cmpb	$0x1, 0x1(%rbx)
0000000100006ad4	jne	0x100006ae2
0000000100006ad6	cmpb	$0x2, %r14b
0000000100006ada	jne	0x100006b0e
0000000100006adc	movq	0x18(%rbx), %rdx
0000000100006ae0	jmp	0x100006b11
0000000100006ae2	movl	$0xdead, (%rdi)                 ## imm = 0xDEAD
0000000100006ae8	movl	0x4(%rdi), %edx
0000000100006aeb	testq	%rdx, %rdx
0000000100006aee	je	0x100006b6f
0000000100006af0	addq	$0x8, %rdi
0000000100006af4	shlq	$0x3, %rdx
0000000100006af8	leaq	0xb7d1(%rip), %rsi
0000000100006aff	addq	$0x8, %rsp
0000000100006b03	popq	%rbx
0000000100006b04	popq	%r14
0000000100006b06	popq	%r15
0000000100006b08	popq	%rbp
0000000100006b09	jmp	0x1000120c4                     ## symbol stub for: _memset_pattern16
0000000100006b0e	movl	0x8(%rbx), %edx
0000000100006b11	movq	%rdi, %rbx
0000000100006b14	movl	$0xdd, %esi
0000000100006b19	callq	0x1000120be                     ## symbol stub for: _memset
0000000100006b1e	movq	$0x0, (%rbx)
0000000100006b25	movb	$0x0, 0x8(%rbx)
0000000100006b29	jmp	0x100006b6f
0000000100006b2b	leaq	-0x1c(%rbp), %rax
0000000100006b2f	movq	%rdi, %r15
0000000100006b32	movq	%rax, %rdi
0000000100006b35	callq	_fwp_rc_free_obj.cold.1
0000000100006b3a	movq	%r15, %rdi
0000000100006b3d	movl	-0x1c(%rbp), %eax
0000000100006b40	testl	%eax, %eax
0000000100006b42	jne	0x100006ad0
0000000100006b44	movq	_fwp_gc(%rip), %rbx
0000000100006b4b	callq	_fwp_mem_free
0000000100006b50	movq	_fwp_gc(%rip), %rax
0000000100006b57	subq	%rbx, %rax
0000000100006b5a	cvtsi2sd	%rax, %xmm0
0000000100006b5f	addsd	0xf6a9(%rip), %xmm0
0000000100006b67	movsd	%xmm0, 0xf6a1(%rip)
0000000100006b6f	addq	$0x8, %rsp
0000000100006b73	popq	%rbx
0000000100006b74	popq	%r14
0000000100006b76	popq	%r15
0000000100006b78	popq	%rbp
0000000100006b79	retq
0000000100006b7a	nopw	(%rax,%rax)
_fwp_owned_entry29:
0000000100006b80	pushq	%rbp
0000000100006b81	movq	%rsp, %rbp
0000000100006b84	movq	(%rdi), %rdi
0000000100006b87	popq	%rbp
0000000100006b88	jmp	_f29
0000000100006b8d	nopl	(%rax)
_fwp_caps29:
0000000100006b90	movl	0x4(%rdi), %eax
0000000100006b93	testl	%esi, %esi
0000000100006b95	je	0x100006bf9
0000000100006b97	testl	%eax, %eax
0000000100006b99	je	0x100006c51
0000000100006b9f	movq	0x8(%rdi), %rax
0000000100006ba3	subq	0xf48e(%rip), %rax
0000000100006baa	movq	0xf4af(%rip), %rcx
0000000100006bb1	shlq	$0x10, %rcx
0000000100006bb5	cmpq	%rcx, %rax
0000000100006bb8	jae	0x100006c51
0000000100006bbe	movq	0xf4bb(%rip), %rcx
0000000100006bc5	movq	%rax, %rdx
0000000100006bc8	shrq	$0x10, %rdx
0000000100006bcc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006bd3	leaq	(%rcx,%rdx), %rdi
0000000100006bd7	movzbl	(%rcx,%rdx), %ecx
0000000100006bdb	cmpb	$0x2, %cl
0000000100006bde	setne	%dl
0000000100006be1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006be7	setne	%sil
0000000100006beb	orb	%dl, %sil
0000000100006bee	jne	0x100006c24
0000000100006bf0	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006bf7	jmp	0x100006c3e
0000000100006bf9	testl	%eax, %eax
0000000100006bfb	je	_fwp_rc_free_obj
0000000100006c01	pushq	%rbp
0000000100006c02	movq	%rsp, %rbp
0000000100006c05	pushq	%rbx
0000000100006c06	pushq	%rax
0000000100006c07	movq	0x8(%rdi), %rax
0000000100006c0b	movq	%rdi, %rbx
0000000100006c0e	movq	%rax, %rdi
0000000100006c11	callq	_fwp_drop1
0000000100006c16	movq	%rbx, %rdi
0000000100006c19	addq	$0x8, %rsp
0000000100006c1d	popq	%rbx
0000000100006c1e	popq	%rbp
0000000100006c1f	jmp	_fwp_rc_free_obj
0000000100006c24	cmpb	$0x1, %cl
0000000100006c27	jne	0x100006c51
0000000100006c29	movl	0x20(%rdi), %ecx
0000000100006c2c	imulq	%rcx, %rax
0000000100006c30	shrq	$0x20, %rax
0000000100006c34	addq	%rax, %rdi
0000000100006c37	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006c3e	movzbl	(%rdi), %eax
0000000100006c41	testb	%al, %al
0000000100006c43	je	0x100006c51
0000000100006c45	cmpb	$-0x2, %al
0000000100006c47	jae	_fwp_rc_wide_dup
0000000100006c4d	incb	%al
0000000100006c4f	movb	%al, (%rdi)
0000000100006c51	retq
0000000100006c52	nopw	%cs:(%rax,%rax)
_fwp_args29:
0000000100006c60	pushq	%rbp
0000000100006c61	movq	%rsp, %rbp
0000000100006c64	testl	%esi, %esi
0000000100006c66	setne	%al
0000000100006c69	testl	%edx, %edx
0000000100006c6b	sete	%cl
0000000100006c6e	orb	%al, %cl
0000000100006c70	jne	0x100006cf0
0000000100006c72	movq	(%rdi), %rax
0000000100006c75	subq	0xf3bc(%rip), %rax
0000000100006c7c	movq	0xf3dd(%rip), %rcx
0000000100006c83	shlq	$0x10, %rcx
0000000100006c87	cmpq	%rcx, %rax
0000000100006c8a	jae	0x100006cf0
0000000100006c8c	movq	0xf3ed(%rip), %rcx
0000000100006c93	movq	%rax, %rdx
0000000100006c96	shrq	$0x10, %rdx
0000000100006c9a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006ca1	leaq	(%rcx,%rdx), %rdi
0000000100006ca5	movzbl	(%rcx,%rdx), %ecx
0000000100006ca9	cmpb	$0x2, %cl
0000000100006cac	setne	%dl
0000000100006caf	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006cb5	setne	%sil
0000000100006cb9	orb	%dl, %sil
0000000100006cbc	jne	0x100006cc7
0000000100006cbe	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006cc5	jmp	0x100006ce1
0000000100006cc7	cmpb	$0x1, %cl
0000000100006cca	jne	0x100006cf0
0000000100006ccc	movl	0x20(%rdi), %ecx
0000000100006ccf	imulq	%rcx, %rax
0000000100006cd3	shrq	$0x20, %rax
0000000100006cd7	addq	%rax, %rdi
0000000100006cda	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006ce1	movzbl	(%rdi), %eax
0000000100006ce4	testb	%al, %al
0000000100006ce6	je	0x100006cf0
0000000100006ce8	cmpb	$-0x2, %al
0000000100006cea	jae	0x100006cf2
0000000100006cec	incb	%al
0000000100006cee	movb	%al, (%rdi)
0000000100006cf0	popq	%rbp
0000000100006cf1	retq
0000000100006cf2	popq	%rbp
0000000100006cf3	jmp	_fwp_rc_wide_dup
0000000100006cf8	nopl	(%rax,%rax)
_fwp_arg_drop29:
0000000100006d00	pushq	%rbp
0000000100006d01	movq	%rsp, %rbp
0000000100006d04	testl	%esi, %esi
0000000100006d06	setne	%al
0000000100006d09	testl	%edx, %edx
0000000100006d0b	sete	%cl
0000000100006d0e	orb	%al, %cl
0000000100006d10	je	0x100006d14
0000000100006d12	popq	%rbp
0000000100006d13	retq
0000000100006d14	movq	(%rdi), %rdi
0000000100006d17	popq	%rbp
0000000100006d18	jmp	_fwp_drop1
0000000100006d1d	nopl	(%rax)
_fwp_p_loop_own:
0000000100006d20	pushq	%rbp
0000000100006d21	movq	%rsp, %rbp
0000000100006d24	pushq	%r15
0000000100006d26	pushq	%r14
0000000100006d28	pushq	%r13
0000000100006d2a	pushq	%r12
0000000100006d2c	pushq	%rbx
0000000100006d2d	subq	$0xe8, %rsp
0000000100006d34	movq	%rdi, -0x78(%rbp)
0000000100006d38	movq	%rsi, -0x38(%rbp)
0000000100006d3c	movq	%rsi, -0x70(%rbp)
0000000100006d40	movq	%rdx, -0x68(%rbp)
0000000100006d44	testq	%rdx, %rdx
0000000100006d47	je	0x100006d8c
0000000100006d49	movq	_fwp_cleanups(%rip), %rax
0000000100006d50	movq	%rax, -0x90(%rbp)
0000000100006d57	leaq	_fwp_value_release(%rip), %rax
0000000100006d5e	movq	%rax, -0x88(%rbp)
0000000100006d65	leaq	-0x70(%rbp), %rax
0000000100006d69	movq	%rax, -0x80(%rbp)
0000000100006d6d	leaq	-0x90(%rbp), %rax
0000000100006d74	movq	%rax, _fwp_cleanups(%rip)
0000000100006d7b	jmp	0x100006d8c
0000000100006d7d	nopl	(%rax)
0000000100006d80	incb	%al
0000000100006d82	movb	%al, (%rdi)
0000000100006d84	movq	%rsi, -0x38(%rbp)
0000000100006d88	movq	%rsi, -0x70(%rbp)
0000000100006d8c	movl	_fwp_budget(%rip), %eax
0000000100006d92	leal	-0x1(%rax), %ecx
0000000100006d95	movl	%ecx, _fwp_budget(%rip)
0000000100006d9b	cmpl	$0x1, %eax
0000000100006d9e	jle	0x10000731c
0000000100006da4	movq	%rsi, -0x38(%rbp)
0000000100006da8	movq	$0x0, -0x70(%rbp)
0000000100006db0	movq	_fwp_fns(%rip), %rcx
0000000100006db7	movq	-0x78(%rbp), %r9
0000000100006dbb	movl	(%r9), %edx
0000000100006dbe	shlq	$0x5, %rdx
0000000100006dc2	movq	0x18(%rcx,%rdx), %rax
0000000100006dc7	testq	%rax, %rax
0000000100006dca	je	0x1000071e0
0000000100006dd0	leaq	(%rcx,%rdx), %r11
0000000100006dd4	leaq	(%rcx,%rdx), %r12
0000000100006dd8	addq	$0x18, %r12
0000000100006ddc	movl	$0x1, %r13d
0000000100006de2	xorl	%ecx, %ecx
0000000100006de4	leaq	-0x38(%rbp), %rdx
0000000100006de8	movl	$0x1, %r10d
0000000100006dee	nop
0000000100006df0	testb	$0x1, %cl
0000000100006df3	movl	$0x0, %esi
0000000100006df8	cmovneq	%r9, %rsi
0000000100006dfc	movq	%rsi, -0x110(%rbp)
0000000100006e03	movq	%rdx, -0x108(%rbp)
0000000100006e0a	movq	%rax, -0x100(%rbp)
0000000100006e11	movl	$0x0, -0xf8(%rbp)
0000000100006e1b	movl	0x4(%r9), %esi
0000000100006e1f	movl	%esi, -0xf4(%rbp)
0000000100006e25	movq	%r9, %r15
0000000100006e28	subq	0xf209(%rip), %r15
0000000100006e2f	movl	%r10d, -0xf0(%rbp)
0000000100006e36	movq	0xf223(%rip), %rsi
0000000100006e3d	shlq	$0x10, %rsi
0000000100006e41	cmpq	%rsi, %r15
0000000100006e44	movq	%rdx, -0x48(%rbp)
0000000100006e48	jae	0x100006ef0
0000000100006e4e	movq	%r9, %r14
0000000100006e51	movq	%r11, -0x40(%rbp)
0000000100006e55	movl	%r10d, %ebx
0000000100006e58	movq	0xf221(%rip), %r8
0000000100006e5f	movq	%r15, %rdi
0000000100006e62	shrq	$0x10, %rdi
0000000100006e66	imulq	$0x1228, %rdi, %r9              ## imm = 0x1228
0000000100006e6d	leaq	(%r8,%r9), %rdi
0000000100006e71	movzbl	(%r8,%r9), %r9d
0000000100006e76	cmpb	$0x2, %r9b
0000000100006e7a	setne	%r10b
0000000100006e7e	movq	%r15, %r8
0000000100006e81	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100006e88	setne	%r11b
0000000100006e8c	orb	%r10b, %r11b
0000000100006e8f	jne	0x100006eb0
0000000100006e91	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006e98	movq	-0x48(%rbp), %rdx
0000000100006e9c	movl	%ebx, %r10d
0000000100006e9f	movq	-0x40(%rbp), %r11
0000000100006ea3	jmp	0x100006eda
0000000100006ea5	nopw	%cs:(%rax,%rax)
0000000100006eb0	cmpb	$0x1, %r9b
0000000100006eb4	movq	-0x48(%rbp), %rdx
0000000100006eb8	movl	%ebx, %r10d
0000000100006ebb	movq	-0x40(%rbp), %r11
0000000100006ebf	movq	%r14, %r9
0000000100006ec2	jne	0x100006ef0
0000000100006ec4	movl	0x20(%rdi), %r9d
0000000100006ec8	imulq	%r9, %r8
0000000100006ecc	shrq	$0x20, %r8
0000000100006ed0	addq	%r8, %rdi
0000000100006ed3	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006eda	cmpb	$0x0, (%rdi)
0000000100006edd	movq	%r14, %r9
0000000100006ee0	jne	0x100006efc
0000000100006ee2	nopw	%cs:(%rax,%rax)
0000000100006ef0	testl	%r10d, %r10d
0000000100006ef3	je	0x100006f50
0000000100006ef5	cmpq	$0x0, 0x18(%rax)
0000000100006efa	je	0x100006f50
0000000100006efc	movq	_fwp_cleanups(%rip), %rdi
0000000100006f03	movq	%rdi, -0xe8(%rbp)
0000000100006f0a	leaq	_fwp_apply_release(%rip), %rdi
0000000100006f11	movq	%rdi, -0xe0(%rbp)
0000000100006f18	leaq	-0x110(%rbp), %rdi
0000000100006f1f	movq	%rdi, -0xd8(%rbp)
0000000100006f26	leaq	-0xe8(%rbp), %rdi
0000000100006f2d	movq	%rdi, _fwp_cleanups(%rip)
0000000100006f34	movb	$0x1, %dil
0000000100006f37	movl	%edi, -0x2c(%rbp)
0000000100006f3a	testb	$0x1, %cl
0000000100006f3d	je	0x100006f5c
0000000100006f3f	jmp	0x100006fd3
0000000100006f44	nopw	%cs:(%rax,%rax)
0000000100006f50	movl	$0x0, -0x2c(%rbp)
0000000100006f57	testb	$0x1, %cl
0000000100006f5a	jne	0x100006fd3
0000000100006f5c	cmpq	%rsi, %r15
0000000100006f5f	jae	0x100006fc8
0000000100006f61	movq	0xf118(%rip), %rax
0000000100006f68	movq	%r15, %rcx
0000000100006f6b	shrq	$0x10, %rcx
0000000100006f6f	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
0000000100006f76	leaq	(%rax,%rcx), %rdi
0000000100006f7a	movzbl	(%rax,%rcx), %eax
0000000100006f7e	cmpb	$0x2, %al
0000000100006f80	setne	%cl
0000000100006f83	andq	$0xffff, %r15                   ## imm = 0xFFFF
0000000100006f8a	setne	%sil
0000000100006f8e	orb	%cl, %sil
0000000100006f91	jne	0x100006f9c
0000000100006f93	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006f9a	jmp	0x100006fb5
0000000100006f9c	cmpb	$0x1, %al
0000000100006f9e	jne	0x100006fc8
0000000100006fa0	movl	0x20(%rdi), %eax
0000000100006fa3	imulq	%rax, %r15
0000000100006fa7	shrq	$0x20, %r15
0000000100006fab	addq	%r15, %rdi
0000000100006fae	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006fb5	movzbl	(%rdi), %eax
0000000100006fb8	testb	%al, %al
0000000100006fba	je	0x100006fc8
0000000100006fbc	cmpb	$-0x2, %al
0000000100006fbe	jae	0x1000071be
0000000100006fc4	incb	%al
0000000100006fc6	movb	%al, (%rdi)
0000000100006fc8	movq	%r9, -0x110(%rbp)
0000000100006fcf	movq	(%r12), %rax
0000000100006fd3	movl	(%r11), %r15d
0000000100006fd6	subl	0x4(%r9), %r15d
0000000100006fda	cmpl	%r15d, %r13d
0000000100006fdd	movl	%r15d, -0x58(%rbp)
0000000100006fe1	movl	%r13d, %r14d
0000000100006fe4	cmovbl	%r13d, %r15d
0000000100006fe8	cmpl	%r15d, %r10d
0000000100006feb	movl	%r15d, %esi
0000000100006fee	cmovbl	%r10d, %esi
0000000100006ff2	movq	$0x0, -0xd0(%rbp)
0000000100006ffd	leaq	(%rdx,%rsi,8), %rbx
0000000100007001	movq	%rbx, -0xc8(%rbp)
0000000100007008	movq	%rax, -0xc0(%rbp)
000000010000700f	movl	$0x0, -0xb8(%rbp)
0000000100007019	movl	0x4(%r9), %ecx
000000010000701d	addl	%esi, %ecx
000000010000701f	movl	%ecx, -0xb4(%rbp)
0000000100007025	movl	$0x0, -0xb0(%rbp)
000000010000702f	xorl	%r13d, %r13d
0000000100007032	movl	$0x0, %ecx
0000000100007037	movl	%r10d, -0x5c(%rbp)
000000010000703b	cmpl	%r10d, %r15d
000000010000703e	movq	%rsi, -0x40(%rbp)
0000000100007042	jbe	0x1000070f8
0000000100007048	movl	%r14d, -0x54(%rbp)
000000010000704c	cmpq	$0x0, 0x18(%rax)
0000000100007051	setne	%al
0000000100007054	movl	%eax, -0x4c(%rbp)
0000000100007057	je	0x100007091
0000000100007059	movq	_fwp_cleanups(%rip), %rax
0000000100007060	movq	%rax, -0xa8(%rbp)
0000000100007067	leaq	_fwp_apply_release(%rip), %rax
000000010000706e	movq	%rax, -0xa0(%rbp)
0000000100007075	leaq	-0xd0(%rbp), %rax
000000010000707c	movq	%rax, -0x98(%rbp)
0000000100007083	leaq	-0xa8(%rbp), %rax
000000010000708a	movq	%rax, _fwp_cleanups(%rip)
0000000100007091	movl	%r15d, -0x50(%rbp)
0000000100007095	subl	%esi, %r15d
0000000100007098	cmpl	$0x1, %r15d
000000010000709c	adcl	$0x0, %r15d
00000001000070a0	shlq	$0x3, %r15
00000001000070a4	movl	%esi, %r14d
00000001000070a7	movq	%r9, %r13
00000001000070aa	nopw	(%rax,%rax)
00000001000070b0	movq	(%r12), %rax
00000001000070b4	movl	0x4(%r13), %esi
00000001000070b8	addl	%r14d, %esi
00000001000070bb	movq	%rbx, %rdi
00000001000070be	movl	$0x1, %edx
00000001000070c3	callq	*0x10(%rax)
00000001000070c6	movl	-0xb0(%rbp), %ecx
00000001000070cc	incl	%ecx
00000001000070ce	movl	%ecx, -0xb0(%rbp)
00000001000070d4	incl	%r14d
00000001000070d7	addq	$0x8, %rbx
00000001000070db	addq	$-0x8, %r15
00000001000070df	jne	0x1000070b0
00000001000070e1	movq	%r13, %r9
00000001000070e4	movl	-0x54(%rbp), %r14d
00000001000070e8	movq	-0x48(%rbp), %rdx
00000001000070ec	movl	-0x50(%rbp), %r15d
00000001000070f0	movq	-0x40(%rbp), %rsi
00000001000070f4	movl	-0x4c(%rbp), %r13d
00000001000070f8	movl	%ecx, -0xb8(%rbp)
00000001000070fe	movq	$0x0, -0x110(%rbp)
0000000100007109	movl	%esi, -0xf8(%rbp)
000000010000710f	movq	%r9, %rdi
0000000100007112	movl	%r15d, %esi
0000000100007115	callq	_fwp_apply_owned
000000010000711a	movq	%rax, %r9
000000010000711d	testb	%r13b, %r13b
0000000100007120	movl	%r14d, %r13d
0000000100007123	je	0x100007147
0000000100007125	leaq	-0xa8(%rbp), %rax
000000010000712c	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007133	jne	0x10000736d
0000000100007139	movq	-0xa8(%rbp), %rax
0000000100007140	movq	%rax, _fwp_cleanups(%rip)
0000000100007147	cmpb	$0x0, -0x2c(%rbp)
000000010000714b	movq	-0x48(%rbp), %rdx
000000010000714f	movl	-0x5c(%rbp), %r10d
0000000100007153	movq	-0x40(%rbp), %rcx
0000000100007157	je	0x10000717b
0000000100007159	leaq	-0xe8(%rbp), %rax
0000000100007160	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007167	jne	0x10000736d
000000010000716d	movq	-0xe8(%rbp), %rax
0000000100007174	movq	%rax, _fwp_cleanups(%rip)
000000010000717b	cmpl	-0x58(%rbp), %r13d
000000010000717f	jbe	0x100007245
0000000100007185	movl	%r15d, %eax
0000000100007188	leaq	(%rdx,%rax,8), %rdx
000000010000718c	subl	%r15d, %r13d
000000010000718f	subl	%ecx, %r10d
0000000100007192	movq	_fwp_fns(%rip), %rax
0000000100007199	movl	(%r9), %ecx
000000010000719c	shlq	$0x5, %rcx
00000001000071a0	leaq	(%rax,%rcx), %r11
00000001000071a4	leaq	(%rax,%rcx), %r12
00000001000071a8	addq	$0x18, %r12
00000001000071ac	movq	0x18(%rax,%rcx), %rax
00000001000071b1	movb	$0x1, %cl
00000001000071b3	testq	%rax, %rax
00000001000071b6	jne	0x100006df0
00000001000071bc	jmp	0x100007200
00000001000071be	movl	%r10d, %ebx
00000001000071c1	movq	%r11, %r15
00000001000071c4	movq	%r9, %r14
00000001000071c7	callq	_fwp_rc_wide_dup
00000001000071cc	movq	%r14, %r9
00000001000071cf	movq	%r15, %r11
00000001000071d2	movl	%ebx, %r10d
00000001000071d5	movq	-0x48(%rbp), %rdx
00000001000071d9	jmp	0x100006fc8
00000001000071de	nop
00000001000071e0	movq	%r9, %rdi
00000001000071e3	movq	%r9, %rbx
00000001000071e6	callq	_fwp_rc_share
00000001000071eb	movl	$0x1, %r13d
00000001000071f1	movq	%rbx, %r12
00000001000071f4	leaq	-0x38(%rbp), %rdx
00000001000071f8	jmp	0x10000721a
00000001000071fa	nopw	(%rax,%rax)
0000000100007200	movq	%rdx, %rbx
0000000100007203	movq	%r9, %rdi
0000000100007206	movq	%r9, %r12
0000000100007209	callq	_fwp_rc_share
000000010000720e	testl	%r13d, %r13d
0000000100007211	je	0x100007311
0000000100007217	movq	%rbx, %rdx
000000010000721a	movl	%r13d, %ebx
000000010000721d	xorl	%r14d, %r14d
0000000100007220	movq	(%rdx,%r14,8), %rdi
0000000100007224	movq	%rdx, %r15
0000000100007227	callq	_fwp_rc_share
000000010000722c	movq	%r15, %rdx
000000010000722f	incq	%r14
0000000100007232	cmpq	%r14, %rbx
0000000100007235	jne	0x100007220
0000000100007237	movq	%r12, %rdi
000000010000723a	movl	%r13d, %esi
000000010000723d	callq	_fwp_apply
0000000100007242	movq	%rax, %r9
0000000100007245	cmpq	$0xfff, %r9                     ## imm = 0xFFF
000000010000724c	ja	0x100007260
000000010000724e	movl	%r9d, %eax
0000000100007251	jmp	0x100007263
0000000100007253	nopw	%cs:(%rax,%rax)
0000000100007260	movl	(%r9), %eax
0000000100007263	movq	0x8(%r9), %rsi
0000000100007267	testl	%eax, %eax
0000000100007269	jne	0x10000732a
000000010000726f	movq	%rsi, %rax
0000000100007272	subq	0xedbf(%rip), %rax
0000000100007279	movq	0xede0(%rip), %rcx
0000000100007280	shlq	$0x10, %rcx
0000000100007284	cmpq	%rcx, %rax
0000000100007287	jae	0x100006d84
000000010000728d	movq	0xedec(%rip), %rcx
0000000100007294	movq	%rax, %rdx
0000000100007297	shrq	$0x10, %rdx
000000010000729b	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000072a2	leaq	(%rcx,%rdx), %rdi
00000001000072a6	movzbl	(%rcx,%rdx), %ecx
00000001000072aa	cmpb	$0x2, %cl
00000001000072ad	setne	%dl
00000001000072b0	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000072b6	setne	%r8b
00000001000072ba	orb	%dl, %r8b
00000001000072bd	jne	0x1000072d0
00000001000072bf	addq	$0x228, %rdi                    ## imm = 0x228
00000001000072c6	jmp	0x1000072ee
00000001000072c8	nopl	(%rax,%rax)
00000001000072d0	cmpb	$0x1, %cl
00000001000072d3	jne	0x100006d84
00000001000072d9	movl	0x20(%rdi), %ecx
00000001000072dc	imulq	%rcx, %rax
00000001000072e0	shrq	$0x20, %rax
00000001000072e4	addq	%rax, %rdi
00000001000072e7	addq	$0x228, %rdi                    ## imm = 0x228
00000001000072ee	movzbl	(%rdi), %eax
00000001000072f1	testb	%al, %al
00000001000072f3	je	0x100006d84
00000001000072f9	cmpb	$-0x2, %al
00000001000072fb	jb	0x100006d80
0000000100007301	movq	%rsi, %rbx
0000000100007304	callq	_fwp_rc_wide_dup
0000000100007309	movq	%rbx, %rsi
000000010000730c	jmp	0x100006d84
0000000100007311	xorl	%r13d, %r13d
0000000100007314	movq	%rbx, %rdx
0000000100007317	jmp	0x100007237
000000010000731c	callq	_fwp_preempt
0000000100007321	movq	-0x70(%rbp), %rsi
0000000100007325	jmp	0x100006da4
000000010000732a	movq	%rsi, -0x38(%rbp)
000000010000732e	movq	-0x78(%rbp), %rax
0000000100007332	cmpq	$0x0, -0x68(%rbp)
0000000100007337	je	0x100007357
0000000100007339	leaq	-0x90(%rbp), %rax
0000000100007340	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007347	jne	0x10000736d
0000000100007349	movq	-0x90(%rbp), %rax
0000000100007350	movq	%rax, _fwp_cleanups(%rip)
0000000100007357	movq	-0x38(%rbp), %rax
000000010000735b	addq	$0xe8, %rsp
0000000100007362	popq	%rbx
0000000100007363	popq	%r12
0000000100007365	popq	%r13
0000000100007367	popq	%r14
0000000100007369	popq	%r15
000000010000736b	popq	%rbp
000000010000736c	retq
000000010000736d	callq	0x10001203a                     ## symbol stub for: _abort
0000000100007372	nopw	%cs:(%rax,%rax)
_fwp_preempt:
0000000100007380	movl	_fwp_slice(%rip), %ecx
0000000100007386	testl	%ecx, %ecx
0000000100007388	je	0x100007391
000000010000738a	movl	%ecx, _fwp_budget(%rip)
0000000100007390	retq
0000000100007391	pushq	%rbp
0000000100007392	movq	%rsp, %rbp
0000000100007395	leaq	0xb60b(%rip), %rdi              ## literal pool for: "FWP_PREEMPT"
000000010000739c	callq	0x10001208e                     ## symbol stub for: _getenv
00000001000073a1	movq	%rax, %rdi
00000001000073a4	movl	$0x2710, %eax                   ## imm = 0x2710
00000001000073a9	testq	%rdi, %rdi
00000001000073ac	je	0x1000073bf
00000001000073ae	cmpb	$0x0, (%rdi)
00000001000073b1	je	0x1000073bf
00000001000073b3	xorl	%esi, %esi
00000001000073b5	movl	$0xa, %edx
00000001000073ba	callq	0x100012154                     ## symbol stub for: _strtoll
00000001000073bf	leaq	-0x80000000(%rax), %rcx
00000001000073c6	cmpq	$-0x7fffffff, %rcx              ## imm = 0x80000001
00000001000073cd	movl	$0x7fffffff, %ecx               ## imm = 0x7FFFFFFF
00000001000073d2	cmovael	%eax, %ecx
00000001000073d5	movl	%ecx, _fwp_slice(%rip)
00000001000073db	popq	%rbp
00000001000073dc	movl	%ecx, _fwp_budget(%rip)
00000001000073e2	retq
00000001000073e3	nopw	%cs:(%rax,%rax)
_fwp_value_release:
00000001000073f0	pushq	%rbp
00000001000073f1	movq	%rsp, %rbp
00000001000073f4	movq	%rdi, %rax
00000001000073f7	movq	(%rdi), %rdi
00000001000073fa	movq	0x8(%rax), %rcx
00000001000073fe	movq	$0x0, (%rax)
0000000100007405	testq	%rcx, %rcx
0000000100007408	setne	%al
000000010000740b	testq	%rdi, %rdi
000000010000740e	setne	%dl
0000000100007411	andb	%al, %dl
0000000100007413	cmpb	$0x1, %dl
0000000100007416	jne	0x10000741b
0000000100007418	popq	%rbp
0000000100007419	jmpq	*%rcx
000000010000741b	popq	%rbp
000000010000741c	retq
000000010000741d	nopl	(%rax)
_fwp_apply:
0000000100007420	pushq	%rbp
0000000100007421	movq	%rsp, %rbp
0000000100007424	pushq	%r15
0000000100007426	pushq	%r14
0000000100007428	pushq	%r13
000000010000742a	pushq	%r12
000000010000742c	pushq	%rbx
000000010000742d	subq	$0x38, %rsp
0000000100007431	movq	%rdx, %rbx
0000000100007434	movl	%esi, %r8d
0000000100007437	movq	%rdi, %r15
000000010000743a	movq	0xcbef(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007441	movq	(%rax), %rax
0000000100007444	movq	%rax, -0x30(%rbp)
0000000100007448	jmp	0x10000746d
000000010000744a	nopw	(%rax,%rax)
0000000100007450	leaq	(%rbx,%r14,8), %rbx
0000000100007454	xorl	%ecx, %ecx
0000000100007456	movq	%rax, %r15
0000000100007459	movq	-0x48(%rbp), %r14
000000010000745d	movq	-0x50(%rbp), %rsp
0000000100007461	movl	%edx, %r8d
0000000100007464	cmpl	$0x1, %ecx
0000000100007467	je	0x100007916
000000010000746d	movq	_fwp_fns(%rip), %rax
0000000100007474	movl	(%r15), %ecx
0000000100007477	movl	0x4(%r15), %r13d
000000010000747b	shlq	$0x5, %rcx
000000010000747f	leaq	(%rax,%rcx), %rdx
0000000100007483	movl	(%rax,%rcx), %r12d
0000000100007487	testq	%r13, %r13
000000010000748a	jne	0x1000074d0
000000010000748c	leal	-0x1(%r12), %eax
0000000100007491	cmpl	%r8d, %eax
0000000100007494	jae	0x1000074d0
0000000100007496	movq	%rbx, %rdi
0000000100007499	movq	%r8, %r15
000000010000749c	callq	*0x8(%rdx)
000000010000749f	movq	%r15, %r8
00000001000074a2	movq	%rax, %r15
00000001000074a5	cmpl	%r12d, %r8d
00000001000074a8	je	0x10000776b
00000001000074ae	leaq	(%rbx,%r12,8), %rbx
00000001000074b2	subl	%r12d, %r8d
00000001000074b5	movl	$0x3, %ecx
00000001000074ba	cmpl	$0x1, %ecx
00000001000074bd	jne	0x10000746d
00000001000074bf	jmp	0x100007916
00000001000074c4	nopw	%cs:(%rax,%rax)
00000001000074d0	movq	%r14, -0x48(%rbp)
00000001000074d4	leal	(%r8,%r13), %r14d
00000001000074d8	cmpl	%r12d, %r14d
00000001000074db	movq	%r8, -0x40(%rbp)
00000001000074df	jb	0x10000770d
00000001000074e5	movq	%rdx, -0x58(%rbp)
00000001000074e9	movq	%rsp, -0x50(%rbp)
00000001000074ed	movl	%r12d, %r14d
00000001000074f0	cmpl	$0x2, %r12d
00000001000074f4	movl	$0x1, %eax
00000001000074f9	cmovael	%r12d, %eax
00000001000074fd	shlq	$0x3, %rax
0000000100007501	callq	0x100011ff8                     ## symbol stub for: ____chkstk_darwin
0000000100007506	addq	$0xf, %rax
000000010000750a	andq	$-0x10, %rax
000000010000750e	subq	%rax, %rsp
0000000100007511	movq	%rsp, %rdi
0000000100007514	testq	%r13, %r13
0000000100007517	je	0x1000075f0
000000010000751d	cmpl	$0x3, %r13d
0000000100007521	jbe	0x100007533
0000000100007523	movq	%rdi, %rax
0000000100007526	subq	%r15, %rax
0000000100007529	addq	$-0x8, %rax
000000010000752d	cmpq	$0x20, %rax
0000000100007531	jae	0x1000075a2
0000000100007533	xorl	%eax, %eax
0000000100007535	movq	%r13, %rdx
0000000100007538	movq	%rax, %rcx
000000010000753b	andq	$0x3, %rdx
000000010000753f	je	0x100007561
0000000100007541	movq	%rax, %rcx
0000000100007544	nopw	%cs:(%rax,%rax)
0000000100007550	movq	0x8(%r15,%rcx,8), %rsi
0000000100007555	movq	%rsi, (%rdi,%rcx,8)
0000000100007559	incq	%rcx
000000010000755c	decq	%rdx
000000010000755f	jne	0x100007550
0000000100007561	subq	%r13, %rax
0000000100007564	cmpq	$-0x4, %rax
0000000100007568	ja	0x1000075f0
000000010000756e	nop
0000000100007570	movq	0x8(%r15,%rcx,8), %rax
0000000100007575	movq	%rax, (%rdi,%rcx,8)
0000000100007579	movq	0x10(%r15,%rcx,8), %rax
000000010000757e	movq	%rax, 0x8(%rdi,%rcx,8)
0000000100007583	movq	0x18(%r15,%rcx,8), %rax
0000000100007588	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000758d	movq	0x20(%r15,%rcx,8), %rax
0000000100007592	movq	%rax, 0x18(%rdi,%rcx,8)
0000000100007597	addq	$0x4, %rcx
000000010000759b	cmpq	%rcx, %r13
000000010000759e	jne	0x100007570
00000001000075a0	jmp	0x1000075f0
00000001000075a2	movl	%r13d, %eax
00000001000075a5	andl	$-0x4, %eax
00000001000075a8	leaq	(,%r13,8), %rcx
00000001000075b0	andq	$-0x20, %rcx
00000001000075b4	xorl	%edx, %edx
00000001000075b6	nopw	%cs:(%rax,%rax)
00000001000075c0	movups	0x8(%r15,%rdx), %xmm0
00000001000075c6	movups	0x18(%r15,%rdx), %xmm1
00000001000075cc	movaps	%xmm0, (%rdi,%rdx)
00000001000075d0	movaps	%xmm1, 0x10(%rdi,%rdx)
00000001000075d5	addq	$0x20, %rdx
00000001000075d9	cmpq	%rdx, %rcx
00000001000075dc	jne	0x1000075c0
00000001000075de	cmpl	%r13d, %eax
00000001000075e1	jne	0x100007535
00000001000075e7	nopw	(%rax,%rax)
00000001000075f0	subl	%r13d, %r14d
00000001000075f3	movl	%r14d, -0x34(%rbp)
00000001000075f7	movl	%r14d, %r14d
00000001000075fa	cmpl	%r13d, %r12d
00000001000075fd	je	0x100007682
0000000100007603	cmpl	$0xd, -0x34(%rbp)
0000000100007607	ja	0x1000076a7
000000010000760d	xorl	%eax, %eax
000000010000760f	movq	%r14, %rdx
0000000100007612	movq	%rax, %rcx
0000000100007615	andq	$0x3, %rdx
0000000100007619	je	0x100007634
000000010000761b	movq	%rax, %rcx
000000010000761e	nop
0000000100007620	movq	(%rbx,%rcx,8), %rsi
0000000100007624	leal	(%rcx,%r13), %r8d
0000000100007628	movq	%rsi, (%rdi,%r8,8)
000000010000762c	incq	%rcx
000000010000762f	decq	%rdx
0000000100007632	jne	0x100007620
0000000100007634	subq	%r14, %rax
0000000100007637	cmpq	$-0x4, %rax
000000010000763b	ja	0x100007682
000000010000763d	nopl	(%rax)
0000000100007640	movq	(%rbx,%rcx,8), %rax
0000000100007644	leal	(%rcx,%r13), %edx
0000000100007648	movq	%rax, (%rdi,%rdx,8)
000000010000764c	movq	0x8(%rbx,%rcx,8), %rax
0000000100007651	leal	(%rcx,%r13), %edx
0000000100007655	incl	%edx
0000000100007657	movq	%rax, (%rdi,%rdx,8)
000000010000765b	movq	0x10(%rbx,%rcx,8), %rax
0000000100007660	leal	0x2(%r13,%rcx), %edx
0000000100007665	movq	%rax, (%rdi,%rdx,8)
0000000100007669	movq	0x18(%rbx,%rcx,8), %rax
000000010000766e	leal	(%rcx,%r13), %edx
0000000100007672	addl	$0x3, %edx
0000000100007675	movq	%rax, (%rdi,%rdx,8)
0000000100007679	addq	$0x4, %rcx
000000010000767d	cmpq	%rcx, %r14
0000000100007680	jne	0x100007640
0000000100007682	movq	-0x58(%rbp), %rax
0000000100007686	callq	*0x8(%rax)
0000000100007689	movl	$0x1, %ecx
000000010000768e	movq	-0x40(%rbp), %rsi
0000000100007692	movl	%esi, %edx
0000000100007694	subl	-0x34(%rbp), %edx
0000000100007697	jne	0x100007450
000000010000769d	movl	%esi, %edx
000000010000769f	movq	%rax, %r14
00000001000076a2	jmp	0x10000745d
00000001000076a7	leaq	-0x1(%r14), %rax
00000001000076ab	movl	%eax, %ecx
00000001000076ad	addl	%r13d, %ecx
00000001000076b0	jb	0x10000760d
00000001000076b6	shrq	$0x20, %rax
00000001000076ba	movl	$0x0, %eax
00000001000076bf	jne	0x10000760f
00000001000076c5	leaq	(%rdi,%r13,8), %rax
00000001000076c9	subq	%rbx, %rax
00000001000076cc	cmpq	$0x20, %rax
00000001000076d0	jb	0x10000760d
00000001000076d6	movl	%r14d, %eax
00000001000076d9	andl	$-0x4, %eax
00000001000076dc	xorl	%ecx, %ecx
00000001000076de	nop
00000001000076e0	movups	(%rbx,%rcx,8), %xmm0
00000001000076e4	movups	0x10(%rbx,%rcx,8), %xmm1
00000001000076e9	leal	(%rcx,%r13), %edx
00000001000076ed	movups	%xmm0, (%rdi,%rdx,8)
00000001000076f1	movups	%xmm1, 0x10(%rdi,%rdx,8)
00000001000076f6	addq	$0x4, %rcx
00000001000076fa	cmpq	%rcx, %rax
00000001000076fd	jne	0x1000076e0
00000001000076ff	cmpl	%r14d, %eax
0000000100007702	jne	0x10000760f
0000000100007708	jmp	0x100007682
000000010000770d	movl	%r14d, %eax
0000000100007710	cmpl	$0x7ff, %r14d                   ## imm = 0x7FF
0000000100007717	ja	0x100007783
0000000100007719	leaq	(,%rax,8), %rdx
0000000100007721	addq	$0x17, %rdx
0000000100007725	shrq	$0x4, %rdx
0000000100007729	leaq	_fwp_gc(%rip), %rcx
0000000100007730	movzbl	0xbe8(%rdx,%rcx), %edx
0000000100007738	movl	0xb48(%rcx,%rdx,4), %esi
000000010000773f	subq	%rsi, _fwp_gc(%rip)
0000000100007746	js	0x100007783
0000000100007748	leaq	(%rdx,%rdx,2), %rdx
000000010000774c	leaq	(%rcx,%rdx,8), %rcx
0000000100007750	addq	$0x788, %rcx                    ## imm = 0x788
0000000100007757	movq	(%rcx), %r12
000000010000775a	testq	%r12, %r12
000000010000775d	je	0x100007773
000000010000775f	movq	(%r12), %rax
0000000100007763	notq	%rax
0000000100007766	movq	%rax, (%rcx)
0000000100007769	jmp	0x1000077a2
000000010000776b	movq	%r15, %r14
000000010000776e	jmp	0x100007916
0000000100007773	movq	0x8(%rcx), %r12
0000000100007777	movq	0x10(%rcx), %rdx
000000010000777b	subq	%r12, %rdx
000000010000777e	cmpq	%rsi, %rdx
0000000100007781	jae	0x10000779a
0000000100007783	leaq	0x8(,%rax,8), %rdi
000000010000778b	movl	$0x2, %esi
0000000100007790	callq	_fwp_gc_alloc_slow
0000000100007795	movq	%rax, %r12
0000000100007798	jmp	0x1000077aa
000000010000779a	leaq	(%r12,%rsi), %rax
000000010000779e	movq	%rax, 0x8(%rcx)
00000001000077a2	movq	%r12, %rdi
00000001000077a5	callq	0x100011ffe                     ## symbol stub for: ___bzero
00000001000077aa	movl	(%r15), %eax
00000001000077ad	movl	%eax, (%r12)
00000001000077b1	movl	%r14d, 0x4(%r12)
00000001000077b6	testq	%r13, %r13
00000001000077b9	movq	%r12, %r14
00000001000077bc	movq	-0x40(%rbp), %rdi
00000001000077c0	je	0x100007881
00000001000077c6	xorl	%eax, %eax
00000001000077c8	cmpl	$0x6, %r13d
00000001000077cc	jb	0x100007816
00000001000077ce	movq	%r14, %rcx
00000001000077d1	subq	%r15, %rcx
00000001000077d4	cmpq	$0x1f, %rcx
00000001000077d8	jbe	0x100007816
00000001000077da	movl	%r13d, %eax
00000001000077dd	andl	$-0x4, %eax
00000001000077e0	leaq	(,%r13,8), %rcx
00000001000077e8	andq	$-0x20, %rcx
00000001000077ec	xorl	%edx, %edx
00000001000077ee	nop
00000001000077f0	movups	0x8(%r15,%rdx), %xmm0
00000001000077f6	movups	0x18(%r15,%rdx), %xmm1
00000001000077fc	movups	%xmm0, 0x8(%r14,%rdx)
0000000100007802	movups	%xmm1, 0x18(%r14,%rdx)
0000000100007808	addq	$0x20, %rdx
000000010000780c	cmpq	%rdx, %rcx
000000010000780f	jne	0x1000077f0
0000000100007811	cmpl	%r13d, %eax
0000000100007814	je	0x100007881
0000000100007816	movq	%r13, %rdx
0000000100007819	movq	%rax, %rcx
000000010000781c	andq	$0x3, %rdx
0000000100007820	je	0x100007842
0000000100007822	movq	%rax, %rcx
0000000100007825	nopw	%cs:(%rax,%rax)
0000000100007830	movq	0x8(%r15,%rcx,8), %rsi
0000000100007835	movq	%rsi, 0x8(%r14,%rcx,8)
000000010000783a	incq	%rcx
000000010000783d	decq	%rdx
0000000100007840	jne	0x100007830
0000000100007842	subq	%r13, %rax
0000000100007845	cmpq	$-0x4, %rax
0000000100007849	ja	0x100007881
000000010000784b	nopl	(%rax,%rax)
0000000100007850	movq	0x8(%r15,%rcx,8), %rax
0000000100007855	movq	%rax, 0x8(%r14,%rcx,8)
000000010000785a	movq	0x10(%r15,%rcx,8), %rax
000000010000785f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100007864	movq	0x18(%r15,%rcx,8), %rax
0000000100007869	movq	%rax, 0x18(%r14,%rcx,8)
000000010000786e	movq	0x20(%r15,%rcx,8), %rax
0000000100007873	movq	%rax, 0x20(%r14,%rcx,8)
0000000100007878	addq	$0x4, %rcx
000000010000787c	cmpq	%rcx, %r13
000000010000787f	jne	0x100007850
0000000100007881	testl	%edi, %edi
0000000100007883	je	0x100007916
0000000100007889	movl	%edi, %eax
000000010000788b	cmpl	$0x13, %edi
000000010000788e	ja	0x100007938
0000000100007894	xorl	%ecx, %ecx
0000000100007896	movq	%rax, %rsi
0000000100007899	movq	%rcx, %rdx
000000010000789c	andq	$0x3, %rsi
00000001000078a0	je	0x1000078c5
00000001000078a2	movq	%rcx, %rdx
00000001000078a5	nopw	%cs:(%rax,%rax)
00000001000078b0	movq	(%rbx,%rdx,8), %rdi
00000001000078b4	leal	(%rdx,%r13), %r8d
00000001000078b8	movq	%rdi, 0x8(%r14,%r8,8)
00000001000078bd	incq	%rdx
00000001000078c0	decq	%rsi
00000001000078c3	jne	0x1000078b0
00000001000078c5	subq	%rax, %rcx
00000001000078c8	cmpq	$-0x4, %rcx
00000001000078cc	ja	0x100007916
00000001000078ce	nop
00000001000078d0	movq	(%rbx,%rdx,8), %rcx
00000001000078d4	leal	(%rdx,%r13), %esi
00000001000078d8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000078dd	movq	0x8(%rbx,%rdx,8), %rcx
00000001000078e2	leal	(%rdx,%r13), %esi
00000001000078e6	incl	%esi
00000001000078e8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000078ed	movq	0x10(%rbx,%rdx,8), %rcx
00000001000078f2	leal	0x2(%r13,%rdx), %esi
00000001000078f7	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000078fc	movq	0x18(%rbx,%rdx,8), %rcx
0000000100007901	leal	(%rdx,%r13), %esi
0000000100007905	addl	$0x3, %esi
0000000100007908	movq	%rcx, 0x8(%r14,%rsi,8)
000000010000790d	addq	$0x4, %rdx
0000000100007911	cmpq	%rdx, %rax
0000000100007914	jne	0x1000078d0
0000000100007916	movq	0xc713(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000791d	movq	(%rax), %rax
0000000100007920	cmpq	-0x30(%rbp), %rax
0000000100007924	jne	0x10000799f
0000000100007926	movq	%r14, %rax
0000000100007929	leaq	-0x28(%rbp), %rsp
000000010000792d	popq	%rbx
000000010000792e	popq	%r12
0000000100007930	popq	%r13
0000000100007932	popq	%r14
0000000100007934	popq	%r15
0000000100007936	popq	%rbp
0000000100007937	retq
0000000100007938	leaq	-0x1(%rax), %rdx
000000010000793c	xorl	%ecx, %ecx
000000010000793e	movl	%edx, %esi
0000000100007940	addl	%r13d, %esi
0000000100007943	jb	0x100007896
0000000100007949	shrq	$0x20, %rdx
000000010000794d	jne	0x100007896
0000000100007953	leaq	(%r14,%r13,8), %rcx
0000000100007957	subq	%rbx, %rcx
000000010000795a	addq	$0x8, %rcx
000000010000795e	cmpq	$0x20, %rcx
0000000100007962	jb	0x100007894
0000000100007968	movl	%eax, %ecx
000000010000796a	andl	$-0x4, %ecx
000000010000796d	xorl	%edx, %edx
000000010000796f	nop
0000000100007970	movups	(%rbx,%rdx,8), %xmm0
0000000100007974	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100007979	leal	(%rdx,%r13), %esi
000000010000797d	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100007983	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100007989	addq	$0x4, %rdx
000000010000798d	cmpq	%rdx, %rcx
0000000100007990	jne	0x100007970
0000000100007992	cmpl	%eax, %ecx
0000000100007994	jne	0x100007896
000000010000799a	jmp	0x100007916
000000010000799f	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
00000001000079a4	nopw	%cs:(%rax,%rax)
_fwp_apply_release:
00000001000079b0	pushq	%rbp
00000001000079b1	movq	%rsp, %rbp
00000001000079b4	pushq	%r14
00000001000079b6	pushq	%rbx
00000001000079b7	movq	(%rdi), %rbx
00000001000079ba	movq	$0x0, (%rdi)
00000001000079c1	movl	0x20(%rdi), %eax
00000001000079c4	movl	0x18(%rdi), %ecx
00000001000079c7	movl	%eax, %edx
00000001000079c9	subl	%ecx, %edx
00000001000079cb	je	0x1000079fa
00000001000079cd	movq	0x10(%rdi), %rsi
00000001000079d1	movq	0x18(%rsi), %r8
00000001000079d5	testq	%r8, %r8
00000001000079d8	je	0x1000079fa
00000001000079da	movq	%rcx, %rax
00000001000079dd	shlq	$0x3, %rax
00000001000079e1	addq	0x8(%rdi), %rax
00000001000079e5	movl	0x1c(%rdi), %esi
00000001000079e8	addl	%ecx, %esi
00000001000079ea	movq	%rdi, %r14
00000001000079ed	movq	%rax, %rdi
00000001000079f0	callq	*%r8
00000001000079f3	movq	%r14, %rdi
00000001000079f6	movl	0x20(%r14), %eax
00000001000079fa	movl	%eax, 0x18(%rdi)
00000001000079fd	testq	%rbx, %rbx
0000000100007a00	je	0x100007a0e
0000000100007a02	movq	%rbx, %rdi
0000000100007a05	popq	%rbx
0000000100007a06	popq	%r14
0000000100007a08	popq	%rbp
0000000100007a09	jmp	_fwp_closure_drop
0000000100007a0e	popq	%rbx
0000000100007a0f	popq	%r14
0000000100007a11	popq	%rbp
0000000100007a12	retq
0000000100007a13	nopw	%cs:(%rax,%rax)
_fwp_apply_owned:
0000000100007a20	pushq	%rbp
0000000100007a21	movq	%rsp, %rbp
0000000100007a24	pushq	%r15
0000000100007a26	pushq	%r14
0000000100007a28	pushq	%r13
0000000100007a2a	pushq	%r12
0000000100007a2c	pushq	%rbx
0000000100007a2d	subq	$0xa8, %rsp
0000000100007a34	movq	%rdx, %rbx
0000000100007a37	movl	%esi, %r13d
0000000100007a3a	movq	0xc5ef(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007a41	movq	(%rax), %rax
0000000100007a44	movq	%rax, -0x30(%rbp)
0000000100007a48	movq	_fwp_fns(%rip), %rdx
0000000100007a4f	movl	(%rdi), %esi
0000000100007a51	shlq	$0x5, %rsi
0000000100007a55	movq	0x18(%rdx,%rsi), %rax
0000000100007a5a	testq	%rax, %rax
0000000100007a5d	je	0x100007e76
0000000100007a63	leaq	(%rdx,%rsi), %rcx
0000000100007a67	addq	%rdx, %rsi
0000000100007a6a	addq	$0x18, %rsi
0000000100007a6e	movq	%rdi, %r12
0000000100007a71	nopw	%cs:(%rax,%rax)
0000000100007a80	movq	%rsi, -0x58(%rbp)
0000000100007a84	movl	(%rcx), %r14d
0000000100007a87	movl	0x4(%r12), %r15d
0000000100007a8c	movq	%rdi, -0xb0(%rbp)
0000000100007a93	movq	%rbx, -0xa8(%rbp)
0000000100007a9a	movq	%rax, -0xa0(%rbp)
0000000100007aa1	movl	$0x0, -0x98(%rbp)
0000000100007aab	movl	%r15d, -0x94(%rbp)
0000000100007ab2	movq	%rdi, %rcx
0000000100007ab5	subq	0xe57c(%rip), %rcx
0000000100007abc	movl	%r13d, -0x90(%rbp)
0000000100007ac3	movq	0xe596(%rip), %rdx
0000000100007aca	shlq	$0x10, %rdx
0000000100007ace	cmpq	%rdx, %rcx
0000000100007ad1	jae	0x100007b40
0000000100007ad3	movq	0xe5a6(%rip), %rsi
0000000100007ada	movq	%rcx, %rdx
0000000100007add	shrq	$0x10, %rdx
0000000100007ae1	imulq	$0x1228, %rdx, %r8              ## imm = 0x1228
0000000100007ae8	leaq	(%rsi,%r8), %rdx
0000000100007aec	movzbl	(%rsi,%r8), %esi
0000000100007af1	cmpb	$0x2, %sil
0000000100007af5	setne	%r9b
0000000100007af9	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100007b00	setne	%r8b
0000000100007b04	orb	%r9b, %r8b
0000000100007b07	jne	0x100007b20
0000000100007b09	addq	$0x228, %rdx                    ## imm = 0x228
0000000100007b10	cmpb	$0x0, (%rdx)
0000000100007b13	jne	0x100007b60
0000000100007b15	jmp	0x100007b40
0000000100007b17	nopw	(%rax,%rax)
0000000100007b20	cmpb	$0x1, %sil
0000000100007b24	jne	0x100007b40
0000000100007b26	movl	0x20(%rdx), %esi
0000000100007b29	imulq	%rsi, %rcx
0000000100007b2d	shrq	$0x20, %rcx
0000000100007b31	addq	%rcx, %rdx
0000000100007b34	addq	$0x228, %rdx                    ## imm = 0x228
0000000100007b3b	cmpb	$0x0, (%rdx)
0000000100007b3e	jne	0x100007b60
0000000100007b40	cmpq	$0x0, 0x18(%rax)
0000000100007b45	je	0x100007b51
0000000100007b47	testq	%r15, %r15
0000000100007b4a	jne	0x100007b60
0000000100007b4c	cmpl	%r14d, %r13d
0000000100007b4f	jne	0x100007b60
0000000100007b51	xorl	%ecx, %ecx
0000000100007b53	jmp	0x100007b8e
0000000100007b55	nopw	%cs:(%rax,%rax)
0000000100007b60	movq	_fwp_cleanups(%rip), %rcx
0000000100007b67	movq	%rcx, -0x80(%rbp)
0000000100007b6b	leaq	_fwp_apply_release(%rip), %rcx
0000000100007b72	movq	%rcx, -0x78(%rbp)
0000000100007b76	leaq	-0xb0(%rbp), %rcx
0000000100007b7d	movq	%rcx, -0x70(%rbp)
0000000100007b81	leaq	-0x80(%rbp), %rcx
0000000100007b85	movq	%rcx, _fwp_cleanups(%rip)
0000000100007b8c	movb	$0x1, %cl
0000000100007b8e	movq	%r13, -0x50(%rbp)
0000000100007b92	addl	%r15d, %r13d
0000000100007b95	cmpl	%r14d, %r13d
0000000100007b98	movq	%rdi, -0x40(%rbp)
0000000100007b9c	movl	%ecx, -0x44(%rbp)
0000000100007b9f	jb	0x100007eb7
0000000100007ba5	movl	%r14d, %ecx
0000000100007ba8	subl	%r15d, %ecx
0000000100007bab	movl	%ecx, -0x34(%rbp)
0000000100007bae	movl	%ecx, %ecx
0000000100007bb0	movq	%rcx, -0x60(%rbp)
0000000100007bb4	testq	%r15, %r15
0000000100007bb7	jne	0x100007be0
0000000100007bb9	testl	%r14d, %r14d
0000000100007bbc	je	0x100007be0
0000000100007bbe	movl	-0x34(%rbp), %r15d
0000000100007bc2	movl	%r15d, -0x98(%rbp)
0000000100007bc9	movq	%rbx, %rdi
0000000100007bcc	callq	*(%rax)
0000000100007bce	movq	%rax, %r12
0000000100007bd1	jmp	0x100007e08
0000000100007bd6	nopw	%cs:(%rax,%rax)
0000000100007be0	movq	%rsp, -0x88(%rbp)
0000000100007be7	testl	%r14d, %r14d
0000000100007bea	movl	$0x1, %eax
0000000100007bef	cmovnel	%r14d, %eax
0000000100007bf3	shlq	$0x3, %rax
0000000100007bf7	callq	0x100011ff8                     ## symbol stub for: ____chkstk_darwin
0000000100007bfc	addq	$0xf, %rax
0000000100007c00	andq	$-0x10, %rax
0000000100007c04	subq	%rax, %rsp
0000000100007c07	movq	%rsp, %r13
0000000100007c0a	testq	%r15, %r15
0000000100007c0d	movq	-0x40(%rbp), %rdi
0000000100007c11	je	0x100007ce0
0000000100007c17	cmpl	$0x3, %r15d
0000000100007c1b	jbe	0x100007c2d
0000000100007c1d	movq	%r13, %rax
0000000100007c20	subq	%r12, %rax
0000000100007c23	addq	$-0x8, %rax
0000000100007c27	cmpq	$0x20, %rax
0000000100007c2b	jae	0x100007c93
0000000100007c2d	xorl	%eax, %eax
0000000100007c2f	movq	%r15, %rdx
0000000100007c32	movq	%rax, %rcx
0000000100007c35	andq	$0x3, %rdx
0000000100007c39	je	0x100007c52
0000000100007c3b	movq	%rax, %rcx
0000000100007c3e	nop
0000000100007c40	movq	0x8(%r12,%rcx,8), %rsi
0000000100007c45	movq	%rsi, (%r13,%rcx,8)
0000000100007c4a	incq	%rcx
0000000100007c4d	decq	%rdx
0000000100007c50	jne	0x100007c40
0000000100007c52	subq	%r15, %rax
0000000100007c55	cmpq	$-0x4, %rax
0000000100007c59	ja	0x100007ce0
0000000100007c5f	nop
0000000100007c60	movq	0x8(%r12,%rcx,8), %rax
0000000100007c65	movq	%rax, (%r13,%rcx,8)
0000000100007c6a	movq	0x10(%r12,%rcx,8), %rax
0000000100007c6f	movq	%rax, 0x8(%r13,%rcx,8)
0000000100007c74	movq	0x18(%r12,%rcx,8), %rax
0000000100007c79	movq	%rax, 0x10(%r13,%rcx,8)
0000000100007c7e	movq	0x20(%r12,%rcx,8), %rax
0000000100007c83	movq	%rax, 0x18(%r13,%rcx,8)
0000000100007c88	addq	$0x4, %rcx
0000000100007c8c	cmpq	%rcx, %r15
0000000100007c8f	jne	0x100007c60
0000000100007c91	jmp	0x100007ce0
0000000100007c93	movl	%r15d, %eax
0000000100007c96	andl	$-0x4, %eax
0000000100007c99	leaq	(,%r15,8), %rcx
0000000100007ca1	andq	$-0x20, %rcx
0000000100007ca5	xorl	%edx, %edx
0000000100007ca7	nopw	(%rax,%rax)
0000000100007cb0	movups	0x8(%r12,%rdx), %xmm0
0000000100007cb6	movups	0x18(%r12,%rdx), %xmm1
0000000100007cbc	movaps	%xmm0, (%r13,%rdx)
0000000100007cc2	movaps	%xmm1, 0x10(%r13,%rdx)
0000000100007cc8	addq	$0x20, %rdx
0000000100007ccc	cmpq	%rdx, %rcx
0000000100007ccf	jne	0x100007cb0
0000000100007cd1	cmpl	%r15d, %eax
0000000100007cd4	jne	0x100007c2f
0000000100007cda	nopw	(%rax,%rax)
0000000100007ce0	cmpl	%r15d, %r14d
0000000100007ce3	movq	-0x58(%rbp), %r14
0000000100007ce7	movq	-0x60(%rbp), %r9
0000000100007ceb	je	0x100007de0
0000000100007cf1	cmpl	$0x9, -0x34(%rbp)
0000000100007cf5	ja	0x100007d88
0000000100007cfb	xorl	%eax, %eax
0000000100007cfd	movq	%r9, %rdx
0000000100007d00	movq	%rax, %rcx
0000000100007d03	andq	$0x3, %rdx
0000000100007d07	je	0x100007d25
0000000100007d09	movq	%rax, %rcx
0000000100007d0c	nopl	(%rax)
0000000100007d10	movq	(%rbx,%rcx,8), %rsi
0000000100007d14	leal	(%r15,%rcx), %r8d
0000000100007d18	movq	%rsi, (%r13,%r8,8)
0000000100007d1d	incq	%rcx
0000000100007d20	decq	%rdx
0000000100007d23	jne	0x100007d10
0000000100007d25	subq	%r9, %rax
0000000100007d28	cmpq	$-0x4, %rax
0000000100007d2c	ja	0x100007de0
0000000100007d32	nopw	%cs:(%rax,%rax)
0000000100007d40	movq	(%rbx,%rcx,8), %rax
0000000100007d44	leal	(%r15,%rcx), %edx
0000000100007d48	movq	%rax, (%r13,%rdx,8)
0000000100007d4d	movq	0x8(%rbx,%rcx,8), %rax
0000000100007d52	leal	(%r15,%rcx), %edx
0000000100007d56	incl	%edx
0000000100007d58	movq	%rax, (%r13,%rdx,8)
0000000100007d5d	movq	0x10(%rbx,%rcx,8), %rax
0000000100007d62	leal	0x2(%r15,%rcx), %edx
0000000100007d67	movq	%rax, (%r13,%rdx,8)
0000000100007d6c	movq	0x18(%rbx,%rcx,8), %rax
0000000100007d71	leal	(%r15,%rcx), %edx
0000000100007d75	addl	$0x3, %edx
0000000100007d78	movq	%rax, (%r13,%rdx,8)
0000000100007d7d	addq	$0x4, %rcx
0000000100007d81	cmpq	%rcx, %r9
0000000100007d84	jne	0x100007d40
0000000100007d86	jmp	0x100007de0
0000000100007d88	leaq	-0x1(%r9), %rax
0000000100007d8c	movl	%eax, %ecx
0000000100007d8e	addl	%r15d, %ecx
0000000100007d91	jb	0x100007cfb
0000000100007d97	shrq	$0x20, %rax
0000000100007d9b	movl	$0x0, %eax
0000000100007da0	jne	0x100007cfd
0000000100007da6	movl	%r9d, %eax
0000000100007da9	andl	$-0x4, %eax
0000000100007dac	xorl	%ecx, %ecx
0000000100007dae	nop
0000000100007db0	movups	(%rbx,%rcx,8), %xmm0
0000000100007db4	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100007db9	leal	(%r15,%rcx), %edx
0000000100007dbd	movups	%xmm0, (%r13,%rdx,8)
0000000100007dc3	movups	%xmm1, 0x10(%r13,%rdx,8)
0000000100007dc9	addq	$0x4, %rcx
0000000100007dcd	cmpq	%rcx, %rax
0000000100007dd0	jne	0x100007db0
0000000100007dd2	cmpl	%r9d, %eax
0000000100007dd5	jne	0x100007cfd
0000000100007ddb	nopl	(%rax,%rax)
0000000100007de0	movq	(%r14), %rax
0000000100007de3	movl	$0x1, %esi
0000000100007de8	callq	*0x8(%rax)
0000000100007deb	movl	-0x34(%rbp), %r15d
0000000100007def	movl	%r15d, -0x98(%rbp)
0000000100007df6	movq	(%r14), %rax
0000000100007df9	movq	%r13, %rdi
0000000100007dfc	callq	*(%rax)
0000000100007dfe	movq	%rax, %r12
0000000100007e01	movq	-0x88(%rbp), %rsp
0000000100007e08	cmpb	$0x0, -0x44(%rbp)
0000000100007e0c	movq	-0x50(%rbp), %r13
0000000100007e10	movq	-0x40(%rbp), %rdi
0000000100007e14	je	0x100007e32
0000000100007e16	leaq	-0x80(%rbp), %rax
0000000100007e1a	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007e21	jne	0x100008294
0000000100007e27	movq	-0x80(%rbp), %rax
0000000100007e2b	movq	%rax, _fwp_cleanups(%rip)
0000000100007e32	callq	_fwp_closure_drop
0000000100007e37	subl	%r15d, %r13d
0000000100007e3a	je	0x100008272
0000000100007e40	movq	-0x60(%rbp), %rax
0000000100007e44	leaq	(%rbx,%rax,8), %rbx
0000000100007e48	movq	_fwp_fns(%rip), %rax
0000000100007e4f	movl	(%r12), %edx
0000000100007e53	shlq	$0x5, %rdx
0000000100007e57	leaq	(%rax,%rdx), %rcx
0000000100007e5b	leaq	(%rax,%rdx), %rsi
0000000100007e5f	addq	$0x18, %rsi
0000000100007e63	movq	0x18(%rax,%rdx), %rax
0000000100007e68	movq	%r12, %rdi
0000000100007e6b	testq	%rax, %rax
0000000100007e6e	jne	0x100007a80
0000000100007e74	jmp	0x100007e79
0000000100007e76	movq	%rdi, %r12
0000000100007e79	movq	%r12, %rdi
0000000100007e7c	callq	_fwp_rc_share
0000000100007e81	testl	%r13d, %r13d
0000000100007e84	je	0x100007ea1
0000000100007e86	movl	%r13d, %r14d
0000000100007e89	xorl	%r15d, %r15d
0000000100007e8c	nopl	(%rax)
0000000100007e90	movq	(%rbx,%r15,8), %rdi
0000000100007e94	callq	_fwp_rc_share
0000000100007e99	incq	%r15
0000000100007e9c	cmpq	%r15, %r14
0000000100007e9f	jne	0x100007e90
0000000100007ea1	movq	%r12, %rdi
0000000100007ea4	movl	%r13d, %esi
0000000100007ea7	movq	%rbx, %rdx
0000000100007eaa	callq	_fwp_apply
0000000100007eaf	movq	%rax, %r12
0000000100007eb2	jmp	0x100008272
0000000100007eb7	movl	%r13d, %eax
0000000100007eba	leaq	0x8(,%rax,8), %rdi
0000000100007ec2	callq	_fwp_alloc_init
0000000100007ec7	movq	-0x40(%rbp), %rdi
0000000100007ecb	movq	%rax, %r14
0000000100007ece	movl	(%r12), %eax
0000000100007ed2	movl	%eax, (%r14)
0000000100007ed5	movl	%r13d, 0x4(%r14)
0000000100007ed9	movq	%r14, %rax
0000000100007edc	subq	0xe155(%rip), %rax
0000000100007ee3	movq	0xe176(%rip), %rcx
0000000100007eea	shlq	$0x10, %rcx
0000000100007eee	cmpq	%rcx, %rax
0000000100007ef1	jae	0x100007f6a
0000000100007ef3	movq	0xe186(%rip), %rcx
0000000100007efa	movq	%rax, %rdx
0000000100007efd	shrq	$0x10, %rdx
0000000100007f01	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100007f08	leaq	(%rcx,%rdx), %r13
0000000100007f0c	movzbl	(%rcx,%rdx), %ecx
0000000100007f10	cmpb	$0x2, %cl
0000000100007f13	setne	%dl
0000000100007f16	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007f1c	setne	%sil
0000000100007f20	orb	%dl, %sil
0000000100007f23	jne	0x100007f3a
0000000100007f25	addq	$0x228, %r13                    ## imm = 0x228
0000000100007f2c	cmpb	$-0x1, (%r13)
0000000100007f31	je	0x100007f5c
0000000100007f33	movb	$0x1, (%r13)
0000000100007f38	jmp	0x100007f6a
0000000100007f3a	cmpb	$0x1, %cl
0000000100007f3d	jne	0x100007f6a
0000000100007f3f	movl	0x20(%r13), %ecx
0000000100007f43	imulq	%rcx, %rax
0000000100007f47	shrq	$0x20, %rax
0000000100007f4b	addq	%rax, %r13
0000000100007f4e	addq	$0x228, %r13                    ## imm = 0x228
0000000100007f55	cmpb	$-0x1, (%r13)
0000000100007f5a	jne	0x100007f33
0000000100007f5c	movq	%r13, %rdi
0000000100007f5f	callq	_fwp_rc_forget_slot
0000000100007f64	movq	-0x40(%rbp), %rdi
0000000100007f68	jmp	0x100007f33
0000000100007f6a	movq	%r14, -0x68(%rbp)
0000000100007f6e	movq	_fwp_cleanups(%rip), %rax
0000000100007f75	movq	%rax, -0xc8(%rbp)
0000000100007f7c	leaq	_fwp_rc_cleanup_cell(%rip), %rax
0000000100007f83	movq	%rax, -0xc0(%rbp)
0000000100007f8a	leaq	-0x68(%rbp), %rax
0000000100007f8e	movq	%rax, -0xb8(%rbp)
0000000100007f95	leaq	-0xc8(%rbp), %r13
0000000100007f9c	movq	%r13, _fwp_cleanups(%rip)
0000000100007fa3	testq	%r15, %r15
0000000100007fa6	je	0x100008071
0000000100007fac	xorl	%eax, %eax
0000000100007fae	cmpl	$0x6, %r15d
0000000100007fb2	jb	0x100008006
0000000100007fb4	movq	%r14, %rcx
0000000100007fb7	subq	%r12, %rcx
0000000100007fba	cmpq	$0x1f, %rcx
0000000100007fbe	jbe	0x100008006
0000000100007fc0	movl	%r15d, %eax
0000000100007fc3	andl	$-0x4, %eax
0000000100007fc6	leaq	(,%r15,8), %rcx
0000000100007fce	andq	$-0x20, %rcx
0000000100007fd2	xorl	%edx, %edx
0000000100007fd4	nopw	%cs:(%rax,%rax)
0000000100007fe0	movups	0x8(%r12,%rdx), %xmm0
0000000100007fe6	movups	0x18(%r12,%rdx), %xmm1
0000000100007fec	movups	%xmm0, 0x8(%r14,%rdx)
0000000100007ff2	movups	%xmm1, 0x18(%r14,%rdx)
0000000100007ff8	addq	$0x20, %rdx
0000000100007ffc	cmpq	%rdx, %rcx
0000000100007fff	jne	0x100007fe0
0000000100008001	cmpl	%r15d, %eax
0000000100008004	je	0x100008071
0000000100008006	movq	%r15, %rdx
0000000100008009	movq	%rax, %rcx
000000010000800c	andq	$0x3, %rdx
0000000100008010	je	0x100008032
0000000100008012	movq	%rax, %rcx
0000000100008015	nopw	%cs:(%rax,%rax)
0000000100008020	movq	0x8(%r12,%rcx,8), %rsi
0000000100008025	movq	%rsi, 0x8(%r14,%rcx,8)
000000010000802a	incq	%rcx
000000010000802d	decq	%rdx
0000000100008030	jne	0x100008020
0000000100008032	subq	%r15, %rax
0000000100008035	cmpq	$-0x4, %rax
0000000100008039	ja	0x100008071
000000010000803b	nopl	(%rax,%rax)
0000000100008040	movq	0x8(%r12,%rcx,8), %rax
0000000100008045	movq	%rax, 0x8(%r14,%rcx,8)
000000010000804a	movq	0x10(%r12,%rcx,8), %rax
000000010000804f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100008054	movq	0x18(%r12,%rcx,8), %rax
0000000100008059	movq	%rax, 0x18(%r14,%rcx,8)
000000010000805e	movq	0x20(%r12,%rcx,8), %rax
0000000100008063	movq	%rax, 0x20(%r14,%rcx,8)
0000000100008068	addq	$0x4, %rcx
000000010000806c	cmpq	%rcx, %r15
000000010000806f	jne	0x100008040
0000000100008071	cmpl	$0x0, -0x50(%rbp)
0000000100008075	je	0x100008106
000000010000807b	movq	-0x50(%rbp), %rcx
000000010000807f	movl	%ecx, %eax
0000000100008081	cmpl	$0x13, %ecx
0000000100008084	ja	0x100008185
000000010000808a	xorl	%ecx, %ecx
000000010000808c	movq	%rax, %rsi
000000010000808f	movq	%rcx, %rdx
0000000100008092	andq	$0x3, %rsi
0000000100008096	je	0x1000080b5
0000000100008098	movq	%rcx, %rdx
000000010000809b	nopl	(%rax,%rax)
00000001000080a0	movq	(%rbx,%rdx,8), %r9
00000001000080a4	leal	(%r15,%rdx), %r8d
00000001000080a8	movq	%r9, 0x8(%r14,%r8,8)
00000001000080ad	incq	%rdx
00000001000080b0	decq	%rsi
00000001000080b3	jne	0x1000080a0
00000001000080b5	subq	%rax, %rcx
00000001000080b8	cmpq	$-0x4, %rcx
00000001000080bc	ja	0x100008106
00000001000080be	nop
00000001000080c0	movq	(%rbx,%rdx,8), %rcx
00000001000080c4	leal	(%r15,%rdx), %esi
00000001000080c8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000080cd	movq	0x8(%rbx,%rdx,8), %rcx
00000001000080d2	leal	(%r15,%rdx), %esi
00000001000080d6	incl	%esi
00000001000080d8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000080dd	movq	0x10(%rbx,%rdx,8), %rcx
00000001000080e2	leal	0x2(%r15,%rdx), %esi
00000001000080e7	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000080ec	movq	0x18(%rbx,%rdx,8), %rcx
00000001000080f1	leal	(%r15,%rdx), %esi
00000001000080f5	addl	$0x3, %esi
00000001000080f8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000080fd	addq	$0x4, %rdx
0000000100008101	cmpq	%rdx, %rax
0000000100008104	jne	0x1000080c0
0000000100008106	movq	-0x58(%rbp), %rax
000000010000810a	movq	(%rax), %rax
000000010000810d	movl	$0x1, %esi
0000000100008112	callq	*0x8(%rax)
0000000100008115	movq	%r14, %rax
0000000100008118	subq	0xdf19(%rip), %rax
000000010000811f	movq	0xdf3a(%rip), %rcx
0000000100008126	shlq	$0x10, %rcx
000000010000812a	cmpq	%rcx, %rax
000000010000812d	jae	0x100008223
0000000100008133	movq	0xdf46(%rip), %rcx
000000010000813a	movq	%rax, %rdx
000000010000813d	shrq	$0x10, %rdx
0000000100008141	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008148	leaq	(%rcx,%rdx), %r12
000000010000814c	movzbl	(%rcx,%rdx), %ecx
0000000100008150	cmpb	$0x2, %cl
0000000100008153	setne	%dl
0000000100008156	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000815c	setne	%sil
0000000100008160	orb	%dl, %sil
0000000100008163	jne	0x1000081ef
0000000100008169	addq	$0x228, %r12                    ## imm = 0x228
0000000100008170	cmpb	$-0x1, (%r12)
0000000100008175	je	0x100008216
000000010000817b	movb	$0x1, (%r12)
0000000100008180	jmp	0x100008223
0000000100008185	leaq	-0x1(%rax), %rdx
0000000100008189	xorl	%ecx, %ecx
000000010000818b	movl	%edx, %esi
000000010000818d	addl	%r15d, %esi
0000000100008190	jb	0x10000808c
0000000100008196	shrq	$0x20, %rdx
000000010000819a	jne	0x10000808c
00000001000081a0	leaq	(%r14,%r15,8), %rcx
00000001000081a4	subq	%rbx, %rcx
00000001000081a7	addq	$0x8, %rcx
00000001000081ab	cmpq	$0x20, %rcx
00000001000081af	jb	0x10000808a
00000001000081b5	movl	%eax, %ecx
00000001000081b7	andl	$-0x4, %ecx
00000001000081ba	xorl	%edx, %edx
00000001000081bc	nopl	(%rax)
00000001000081c0	movups	(%rbx,%rdx,8), %xmm0
00000001000081c4	movups	0x10(%rbx,%rdx,8), %xmm1
00000001000081c9	leal	(%r15,%rdx), %esi
00000001000081cd	movups	%xmm0, 0x8(%r14,%rsi,8)
00000001000081d3	movups	%xmm1, 0x18(%r14,%rsi,8)
00000001000081d9	addq	$0x4, %rdx
00000001000081dd	cmpq	%rdx, %rcx
00000001000081e0	jne	0x1000081c0
00000001000081e2	cmpl	%eax, %ecx
00000001000081e4	jne	0x10000808c
00000001000081ea	jmp	0x100008106
00000001000081ef	cmpb	$0x1, %cl
00000001000081f2	jne	0x100008223
00000001000081f4	movl	0x20(%r12), %ecx
00000001000081f9	imulq	%rcx, %rax
00000001000081fd	shrq	$0x20, %rax
0000000100008201	addq	%rax, %r12
0000000100008204	addq	$0x228, %r12                    ## imm = 0x228
000000010000820b	cmpb	$-0x1, (%r12)
0000000100008210	jne	0x10000817b
0000000100008216	movq	%r12, %rdi
0000000100008219	callq	_fwp_rc_forget_slot
000000010000821e	jmp	0x10000817b
0000000100008223	movq	-0x50(%rbp), %rax
0000000100008227	movl	%eax, -0x98(%rbp)
000000010000822d	movq	$0x0, -0x68(%rbp)
0000000100008235	cmpq	%r13, _fwp_cleanups(%rip)
000000010000823c	jne	0x100008294
000000010000823e	movq	-0xc8(%rbp), %rax
0000000100008245	movq	%rax, _fwp_cleanups(%rip)
000000010000824c	cmpb	$0x0, -0x44(%rbp)
0000000100008250	movq	-0x40(%rbp), %rdi
0000000100008254	je	0x10000826a
0000000100008256	leaq	-0x80(%rbp), %rcx
000000010000825a	cmpq	%rcx, %rax
000000010000825d	jne	0x100008294
000000010000825f	movq	-0x80(%rbp), %rax
0000000100008263	movq	%rax, _fwp_cleanups(%rip)
000000010000826a	callq	_fwp_closure_drop
000000010000826f	movq	%r14, %r12
0000000100008272	movq	0xbdb7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008279	movq	(%rax), %rax
000000010000827c	cmpq	-0x30(%rbp), %rax
0000000100008280	jne	0x100008299
0000000100008282	movq	%r12, %rax
0000000100008285	leaq	-0x28(%rbp), %rsp
0000000100008289	popq	%rbx
000000010000828a	popq	%r12
000000010000828c	popq	%r13
000000010000828e	popq	%r14
0000000100008290	popq	%r15
0000000100008292	popq	%rbp
0000000100008293	retq
0000000100008294	callq	0x10001203a                     ## symbol stub for: _abort
0000000100008299	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000829e	nop
_fwp_alloc:
00000001000082a0	pushq	%rbp
00000001000082a1	movq	%rsp, %rbp
00000001000082a4	pushq	%rbx
00000001000082a5	pushq	%rax
00000001000082a6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
00000001000082ad	ja	0x100008307
00000001000082af	leaq	0xf(%rdi), %rcx
00000001000082b3	shrq	$0x4, %rcx
00000001000082b7	leaq	_fwp_gc(%rip), %rax
00000001000082be	movzbl	0xbe8(%rcx,%rax), %ecx
00000001000082c6	movl	0xb48(%rax,%rcx,4), %esi
00000001000082cd	subq	%rsi, _fwp_gc(%rip)
00000001000082d4	js	0x100008307
00000001000082d6	leaq	(%rcx,%rcx,2), %rcx
00000001000082da	leaq	(%rax,%rcx,8), %rax
00000001000082de	addq	$0x788, %rax                    ## imm = 0x788
00000001000082e4	movq	(%rax), %rbx
00000001000082e7	testq	%rbx, %rbx
00000001000082ea	je	0x1000082f7
00000001000082ec	movq	(%rbx), %rcx
00000001000082ef	notq	%rcx
00000001000082f2	movq	%rcx, (%rax)
00000001000082f5	jmp	0x10000831f
00000001000082f7	movq	0x8(%rax), %rbx
00000001000082fb	movq	0x10(%rax), %rcx
00000001000082ff	subq	%rbx, %rcx
0000000100008302	cmpq	%rsi, %rcx
0000000100008305	jae	0x100008317
0000000100008307	movl	$0x2, %esi
000000010000830c	addq	$0x8, %rsp
0000000100008310	popq	%rbx
0000000100008311	popq	%rbp
0000000100008312	jmp	_fwp_gc_alloc_slow
0000000100008317	leaq	(%rbx,%rsi), %rcx
000000010000831b	movq	%rcx, 0x8(%rax)
000000010000831f	movq	%rbx, %rdi
0000000100008322	callq	0x100011ffe                     ## symbol stub for: ___bzero
0000000100008327	movq	%rbx, %rax
000000010000832a	addq	$0x8, %rsp
000000010000832e	popq	%rbx
000000010000832f	popq	%rbp
0000000100008330	retq
0000000100008331	nopw	%cs:(%rax,%rax)
_fwp_closure_drop:
0000000100008340	pushq	%rbp
0000000100008341	movq	%rsp, %rbp
0000000100008344	pushq	%r15
0000000100008346	pushq	%r14
0000000100008348	pushq	%rbx
0000000100008349	subq	$0x238, %rsp                    ## imm = 0x238
0000000100008350	movq	%rdi, %rax
0000000100008353	subq	0xdcde(%rip), %rax
000000010000835a	movq	0xdcff(%rip), %rcx
0000000100008361	shlq	$0x10, %rcx
0000000100008365	cmpq	%rcx, %rax
0000000100008368	jae	0x100008404
000000010000836e	movq	%rdi, %rsi
0000000100008371	movq	0xdd08(%rip), %rcx
0000000100008378	movq	%rax, %rdx
000000010000837b	shrq	$0x10, %rdx
000000010000837f	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008386	leaq	(%rcx,%rdx), %rdi
000000010000838a	movzbl	(%rcx,%rdx), %ecx
000000010000838e	cmpb	$0x2, %cl
0000000100008391	setne	%dl
0000000100008394	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000839a	setne	%r8b
000000010000839e	orb	%dl, %r8b
00000001000083a1	jne	0x1000083ac
00000001000083a3	addq	$0x228, %rdi                    ## imm = 0x228
00000001000083aa	jmp	0x1000083c6
00000001000083ac	cmpb	$0x1, %cl
00000001000083af	jne	0x100008404
00000001000083b1	movl	0x20(%rdi), %ecx
00000001000083b4	imulq	%rcx, %rax
00000001000083b8	shrq	$0x20, %rax
00000001000083bc	addq	%rax, %rdi
00000001000083bf	addq	$0x228, %rdi                    ## imm = 0x228
00000001000083c6	movzbl	(%rdi), %eax
00000001000083c9	testl	%eax, %eax
00000001000083cb	je	0x100008404
00000001000083cd	cmpl	$0x1, %eax
00000001000083d0	jne	0x1000083f5
00000001000083d2	leaq	_fwp_closure_drop_active(%rip), %rdi
00000001000083d9	callq	*(%rdi)
00000001000083db	movq	(%rax), %rdi
00000001000083de	testq	%rdi, %rdi
00000001000083e1	je	0x100008412
00000001000083e3	addq	$0x238, %rsp                    ## imm = 0x238
00000001000083ea	popq	%rbx
00000001000083eb	popq	%r14
00000001000083ed	popq	%r15
00000001000083ef	popq	%rbp
00000001000083f0	jmp	_fwp_closure_drop_push
00000001000083f5	cmpl	$0xff, %eax
00000001000083fa	je	0x1000084e6
0000000100008400	decb	%al
0000000100008402	movb	%al, (%rdi)
0000000100008404	addq	$0x238, %rsp                    ## imm = 0x238
000000010000840b	popq	%rbx
000000010000840c	popq	%r14
000000010000840e	popq	%r15
0000000100008410	popq	%rbp
0000000100008411	retq
0000000100008412	leaq	-0x230(%rbp), %rbx
0000000100008419	movq	%rbx, -0x248(%rbp)
0000000100008420	movq	$0x0, -0x240(%rbp)
000000010000842b	movq	$0x40, -0x238(%rbp)
0000000100008436	movq	_fwp_cleanups(%rip), %rcx
000000010000843d	movq	%rcx, -0x30(%rbp)
0000000100008441	leaq	_fwp_closure_drop_release(%rip), %rcx
0000000100008448	movq	%rcx, -0x28(%rbp)
000000010000844c	leaq	-0x248(%rbp), %rdi
0000000100008453	movq	%rdi, -0x20(%rbp)
0000000100008457	leaq	-0x30(%rbp), %r15
000000010000845b	movq	%r15, _fwp_cleanups(%rip)
0000000100008462	movq	%rax, %r14
0000000100008465	movq	%rdi, (%rax)
0000000100008468	callq	_fwp_closure_drop_push
000000010000846d	nopl	(%rax)
0000000100008470	movq	-0x240(%rbp), %rax
0000000100008477	testq	%rax, %rax
000000010000847a	je	0x1000084b1
000000010000847c	movq	-0x248(%rbp), %rcx
0000000100008483	leaq	-0x1(%rax), %rdx
0000000100008487	movq	%rdx, -0x240(%rbp)
000000010000848e	movq	-0x8(%rcx,%rax,8), %rdi
0000000100008493	movq	_fwp_fns(%rip), %rax
000000010000849a	movl	(%rdi), %ecx
000000010000849c	shlq	$0x5, %rcx
00000001000084a0	movq	0x18(%rax,%rcx), %rax
00000001000084a5	testq	%rax, %rax
00000001000084a8	je	0x1000084f8
00000001000084aa	xorl	%esi, %esi
00000001000084ac	callq	*0x8(%rax)
00000001000084af	jmp	0x100008470
00000001000084b1	cmpq	%r15, _fwp_cleanups(%rip)
00000001000084b8	jne	0x100008526
00000001000084ba	movq	-0x30(%rbp), %rax
00000001000084be	movq	%rax, _fwp_cleanups(%rip)
00000001000084c5	movq	$0x0, (%r14)
00000001000084cc	movq	-0x248(%rbp), %rdi
00000001000084d3	cmpq	%rbx, %rdi
00000001000084d6	je	0x100008404
00000001000084dc	callq	0x100012082                     ## symbol stub for: _free
00000001000084e1	jmp	0x100008404
00000001000084e6	addq	$0x238, %rsp                    ## imm = 0x238
00000001000084ed	popq	%rbx
00000001000084ee	popq	%r14
00000001000084f0	popq	%r15
00000001000084f2	popq	%rbp
00000001000084f3	jmp	_fwp_rc_wide_drop
00000001000084f8	callq	_fwp_flush
00000001000084fd	movq	0xbb34(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008504	movq	(%rax), %rdi
0000000100008507	leaq	0xa311(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000850e	leaq	0xa49e(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100008515	xorl	%eax, %eax
0000000100008517	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000851c	movl	$0x65, %edi
0000000100008521	callq	0x100012058                     ## symbol stub for: _exit
0000000100008526	callq	0x10001203a                     ## symbol stub for: _abort
000000010000852b	nopl	(%rax,%rax)
_fwp_closure_drop_push:
0000000100008530	pushq	%rbp
0000000100008531	movq	%rsp, %rbp
0000000100008534	pushq	%r15
0000000100008536	pushq	%r14
0000000100008538	pushq	%r13
000000010000853a	pushq	%r12
000000010000853c	pushq	%rbx
000000010000853d	pushq	%rax
000000010000853e	movq	%rsi, %rbx
0000000100008541	movq	%rdi, %r14
0000000100008544	movq	0x8(%rdi), %r13
0000000100008548	cmpq	0x10(%rdi), %r13
000000010000854c	jne	0x1000085b3
000000010000854e	movq	%r13, %rax
0000000100008551	shrq	$0x3c, %rax
0000000100008555	jne	0x1000085d1
0000000100008557	movq	%r13, %rdi
000000010000855a	shlq	$0x4, %rdi
000000010000855e	callq	0x1000120a6                     ## symbol stub for: _malloc
0000000100008563	testq	%rax, %rax
0000000100008566	je	0x1000085f0
000000010000856c	movq	%rax, %r15
000000010000856f	leaq	(,%r13,2), %rax
0000000100008577	movq	%rax, -0x30(%rbp)
000000010000857b	movq	(%r14), %r12
000000010000857e	leaq	(,%r13,8), %rdx
0000000100008586	movq	%r15, %rdi
0000000100008589	movq	%r12, %rsi
000000010000858c	callq	0x1000120b8                     ## symbol stub for: _memcpy
0000000100008591	leaq	0x18(%r14), %rax
0000000100008595	cmpq	%rax, %r12
0000000100008598	je	0x1000085a6
000000010000859a	movq	%r12, %rdi
000000010000859d	callq	0x100012082                     ## symbol stub for: _free
00000001000085a2	movq	0x8(%r14), %r13
00000001000085a6	movq	%r15, (%r14)
00000001000085a9	movq	-0x30(%rbp), %rax
00000001000085ad	movq	%rax, 0x10(%r14)
00000001000085b1	jmp	0x1000085b6
00000001000085b3	movq	(%r14), %r15
00000001000085b6	leaq	0x1(%r13), %rax
00000001000085ba	movq	%rax, 0x8(%r14)
00000001000085be	movq	%rbx, (%r15,%r13,8)
00000001000085c2	addq	$0x8, %rsp
00000001000085c6	popq	%rbx
00000001000085c7	popq	%r12
00000001000085c9	popq	%r13
00000001000085cb	popq	%r14
00000001000085cd	popq	%r15
00000001000085cf	popq	%rbp
00000001000085d0	retq
00000001000085d1	callq	_fwp_flush
00000001000085d6	movq	0xba5b(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000085dd	movq	(%rax), %rdi
00000001000085e0	leaq	0xa238(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000085e7	leaq	0xa3f3(%rip), %rdx              ## literal pool for: "closure cleanup too large"
00000001000085ee	jmp	0x10000860d
00000001000085f0	callq	_fwp_flush
00000001000085f5	movq	0xba3c(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000085fc	movq	(%rax), %rdi
00000001000085ff	leaq	0xa219(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100008606	leaq	0xa3ee(%rip), %rdx              ## literal pool for: "out of memory"
000000010000860d	xorl	%eax, %eax
000000010000860f	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100008614	movl	$0x65, %edi
0000000100008619	callq	0x100012058                     ## symbol stub for: _exit
000000010000861e	nop
_fwp_closure_drop_release:
0000000100008620	pushq	%rbp
0000000100008621	movq	%rsp, %rbp
0000000100008624	pushq	%r14
0000000100008626	pushq	%rbx
0000000100008627	movq	%rdi, %rbx
000000010000862a	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100008631	callq	*(%rdi)
0000000100008633	movq	$0x0, (%rax)
000000010000863a	movq	(%rbx), %rdi
000000010000863d	leaq	0x18(%rbx), %r14
0000000100008641	cmpq	%r14, %rdi
0000000100008644	je	0x10000864b
0000000100008646	callq	0x100012082                     ## symbol stub for: _free
000000010000864b	movq	%r14, (%rbx)
000000010000864e	movq	$0x0, 0x8(%rbx)
0000000100008656	popq	%rbx
0000000100008657	popq	%r14
0000000100008659	popq	%rbp
000000010000865a	retq
000000010000865b	nopl	(%rax,%rax)
_fwp_rc_cleanup_cell:
0000000100008660	pushq	%rbp
0000000100008661	movq	%rsp, %rbp
0000000100008664	movq	%rdi, %rax
0000000100008667	movq	(%rdi), %rdi
000000010000866a	movq	$0x0, (%rax)
0000000100008671	testq	%rdi, %rdi
0000000100008674	je	0x10000867c
0000000100008676	popq	%rbp
0000000100008677	jmp	_fwp_rc_free_obj
000000010000867c	popq	%rbp
000000010000867d	retq
000000010000867e	nop
_f32:
0000000100008680	pushq	%rbp
0000000100008681	movq	%rsp, %rbp
0000000100008684	pushq	%r15
0000000100008686	pushq	%r14
0000000100008688	pushq	%r13
000000010000868a	pushq	%r12
000000010000868c	pushq	%rbx
000000010000868d	subq	$0xd8, %rsp
0000000100008694	movq	%rdi, %rbx
0000000100008697	movq	0xb992(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000869e	movq	(%rax), %rax
00000001000086a1	movq	%rax, -0x30(%rbp)
00000001000086a5	movq	%rdi, -0x98(%rbp)
00000001000086ac	movq	_fwp_cleanups(%rip), %rax
00000001000086b3	movq	%rax, -0x90(%rbp)
00000001000086ba	leaq	_fwp_owner_release10(%rip), %rax
00000001000086c1	movq	%rax, -0x88(%rbp)
00000001000086c8	leaq	-0x98(%rbp), %rax
00000001000086cf	movq	%rax, -0x80(%rbp)
00000001000086d3	movq	$0x0, -0x78(%rbp)
00000001000086db	leaq	-0x90(%rbp), %r12
00000001000086e2	movq	%r12, -0xe0(%rbp)
00000001000086e9	leaq	_fwp_owner_release11(%rip), %rax
00000001000086f0	movq	%rax, -0xd8(%rbp)
00000001000086f7	leaq	-0x78(%rbp), %rax
00000001000086fb	movq	%rax, -0xd0(%rbp)
0000000100008702	leaq	-0xe0(%rbp), %r14
0000000100008709	movq	%r14, _fwp_cleanups(%rip)
0000000100008710	movq	0x10(%rdi), %rax
0000000100008714	subq	0xd91d(%rip), %rax
000000010000871b	movq	0xd93e(%rip), %rcx
0000000100008722	shlq	$0x10, %rcx
0000000100008726	cmpq	%rcx, %rax
0000000100008729	jae	0x100008793
000000010000872b	movq	0xd94e(%rip), %rcx
0000000100008732	movq	%rax, %rdx
0000000100008735	shrq	$0x10, %rdx
0000000100008739	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008740	leaq	(%rcx,%rdx), %rdi
0000000100008744	movzbl	(%rcx,%rdx), %ecx
0000000100008748	cmpb	$0x2, %cl
000000010000874b	setne	%dl
000000010000874e	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008754	setne	%sil
0000000100008758	orb	%dl, %sil
000000010000875b	jne	0x100008766
000000010000875d	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008764	jmp	0x100008780
0000000100008766	cmpb	$0x1, %cl
0000000100008769	jne	0x100008793
000000010000876b	movl	0x20(%rdi), %ecx
000000010000876e	imulq	%rcx, %rax
0000000100008772	shrq	$0x20, %rax
0000000100008776	addq	%rax, %rdi
0000000100008779	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008780	movzbl	(%rdi), %eax
0000000100008783	testb	%al, %al
0000000100008785	je	0x100008793
0000000100008787	cmpb	$-0x3, %al
0000000100008789	ja	0x100008c66
000000010000878f	incb	%al
0000000100008791	movb	%al, (%rdi)
0000000100008793	movq	0x10(%rbx), %rdi
0000000100008797	movq	%rdi, -0x78(%rbp)
000000010000879b	movq	-0xe0(%rbp), %rax
00000001000087a2	movq	%rax, _fwp_cleanups(%rip)
00000001000087a9	movq	0x8(%rbx), %r13
00000001000087ad	movq	0x18(%rbx), %r14
00000001000087b1	testq	%r13, %r13
00000001000087b4	js	0x1000087f9
00000001000087b6	movq	(%rdi), %rdx
00000001000087b9	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000087c3	andq	%rdx, %rax
00000001000087c6	cmpq	%r13, %rax
00000001000087c9	jbe	0x1000087f9
00000001000087cb	movl	_d1(%rip), %eax
00000001000087d1	movl	$0x8, %ecx
00000001000087d6	cmpq	$0xa, %rax
00000001000087da	ja	0x1000087e7
00000001000087dc	leaq	0x9d85(%rip), %rcx
00000001000087e3	movq	(%rcx,%rax,8), %rcx
00000001000087e7	testq	%rdx, %rdx
00000001000087ea	js	0x1000088bc
00000001000087f0	leaq	0x8(%rdi), %rdx
00000001000087f4	jmp	0x1000088c0
00000001000087f9	movl	%r14d, %r15d
00000001000087fc	callq	_fwp_drop0
0000000100008801	movq	%r15, -0x48(%rbp)
0000000100008805	movl	$0x10, %edi
000000010000880a	callq	_fwp_alloc_init
000000010000880f	movq	%rax, %r14
0000000100008812	movabsq	$0x100000001, %rax              ## imm = 0x100000001
000000010000881c	movq	%rax, (%r14)
000000010000881f	movq	%r15, 0x8(%r14)
0000000100008823	leaq	-0x48(%rbp), %rax
0000000100008827	movq	%r14, %rax
000000010000882a	subq	0xd807(%rip), %rax
0000000100008831	movq	0xd828(%rip), %rcx
0000000100008838	shlq	$0x10, %rcx
000000010000883c	cmpq	%rcx, %rax
000000010000883f	jae	0x100008c22
0000000100008845	movq	0xd834(%rip), %rcx
000000010000884c	movq	%rax, %rdx
000000010000884f	shrq	$0x10, %rdx
0000000100008853	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000885a	leaq	(%rcx,%rdx), %r15
000000010000885e	movzbl	(%rcx,%rdx), %ecx
0000000100008862	cmpb	$0x2, %cl
0000000100008865	setne	%dl
0000000100008868	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000886e	setne	%sil
0000000100008872	orb	%dl, %sil
0000000100008875	jne	0x10000888d
0000000100008877	addq	$0x228, %r15                    ## imm = 0x228
000000010000887e	cmpb	$-0x1, (%r15)
0000000100008882	je	0x1000088b2
0000000100008884	movb	$0x1, (%r15)
0000000100008888	jmp	0x100008c22
000000010000888d	cmpb	$0x1, %cl
0000000100008890	jne	0x100008c22
0000000100008896	movl	0x20(%r15), %ecx
000000010000889a	imulq	%rcx, %rax
000000010000889e	shrq	$0x20, %rax
00000001000088a2	addq	%rax, %r15
00000001000088a5	addq	$0x228, %r15                    ## imm = 0x228
00000001000088ac	cmpb	$-0x1, (%r15)
00000001000088b0	jne	0x100008884
00000001000088b2	movq	%r15, %rdi
00000001000088b5	callq	_fwp_rc_forget_slot
00000001000088ba	jmp	0x100008884
00000001000088bc	movq	0x10(%rdi), %rdx
00000001000088c0	movq	%rcx, %rsi
00000001000088c3	imulq	%r13, %rsi
00000001000088c7	cmpq	$0x1, %rcx
00000001000088cb	je	0x1000088f0
00000001000088cd	cmpq	$0x2, %rcx
00000001000088d1	je	0x1000088df
00000001000088d3	cmpq	$0x8, %rcx
00000001000088d7	jne	0x100008901
00000001000088d9	movq	(%rdx,%rsi), %r15
00000001000088dd	jmp	0x100008905
00000001000088df	movzwl	(%rdx,%rsi), %ecx
00000001000088e3	cmpl	$0x1, %eax
00000001000088e6	movswq	%cx, %r15
00000001000088ea	cmovneq	%rcx, %r15
00000001000088ee	jmp	0x100008905
00000001000088f0	movzbl	(%rdx,%rsi), %ecx
00000001000088f4	testq	%rax, %rax
00000001000088f7	movsbq	%cl, %r15
00000001000088fb	cmovneq	%rcx, %r15
00000001000088ff	jmp	0x100008905
0000000100008901	movl	(%rdx,%rsi), %r15d
0000000100008905	movq	_fwp_cleanups(%rip), %rax
000000010000890c	movq	%rdi, -0xc8(%rbp)
0000000100008913	movq	%rax, -0x48(%rbp)
0000000100008917	leaq	_fwp_owner_release7(%rip), %rax
000000010000891e	movq	%rax, -0x40(%rbp)
0000000100008922	leaq	-0xc8(%rbp), %rax
0000000100008929	movq	%rax, -0x38(%rbp)
000000010000892d	leaq	-0x48(%rbp), %r12
0000000100008931	movq	%rdi, %rcx
0000000100008934	subq	0xd6fd(%rip), %rcx
000000010000893b	movq	%r12, _fwp_cleanups(%rip)
0000000100008942	movq	0xd717(%rip), %rax
0000000100008949	shlq	$0x10, %rax
000000010000894d	cmpq	%rax, %rcx
0000000100008950	jae	0x1000089bb
0000000100008952	movq	0xd727(%rip), %rdx
0000000100008959	movq	%rcx, %rax
000000010000895c	shrq	$0x10, %rax
0000000100008960	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008967	leaq	(%rdx,%rsi), %rax
000000010000896b	movzbl	(%rdx,%rsi), %edx
000000010000896f	cmpb	$0x2, %dl
0000000100008972	setne	%sil
0000000100008976	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000897d	setne	%r8b
0000000100008981	orb	%sil, %r8b
0000000100008984	jne	0x10000898e
0000000100008986	addq	$0x228, %rax                    ## imm = 0x228
000000010000898c	jmp	0x1000089a7
000000010000898e	cmpb	$0x1, %dl
0000000100008991	jne	0x1000089bb
0000000100008993	movl	0x20(%rax), %edx
0000000100008996	imulq	%rdx, %rcx
000000010000899a	shrq	$0x20, %rcx
000000010000899e	addq	%rcx, %rax
00000001000089a1	addq	$0x228, %rax                    ## imm = 0x228
00000001000089a7	movzbl	(%rax), %ecx
00000001000089aa	testb	%cl, %cl
00000001000089ac	je	0x1000089bb
00000001000089ae	cmpb	$-0x3, %cl
00000001000089b1	ja	0x100008c85
00000001000089b7	incb	%cl
00000001000089b9	movb	%cl, (%rax)
00000001000089bb	movd	%r14d, %xmm0
00000001000089c0	movd	%r15d, %xmm1
00000001000089c5	mulss	0x9963(%rip), %xmm1
00000001000089cd	addss	0x995f(%rip), %xmm1
00000001000089d5	incq	%r13
00000001000089d8	addss	%xmm0, %xmm1
00000001000089dc	movss	%xmm1, -0x70(%rbp)
00000001000089e1	movq	-0x48(%rbp), %rax
00000001000089e5	movq	%rax, _fwp_cleanups(%rip)
00000001000089ec	movq	%rdi, %r14
00000001000089ef	callq	_fwp_drop0
00000001000089f4	movd	-0x70(%rbp), %xmm0
00000001000089f9	movd	%xmm0, %r12d
00000001000089fe	movq	%r14, -0xc0(%rbp)
0000000100008a05	movq	_fwp_cleanups(%rip), %rax
0000000100008a0c	movq	%rax, -0xb8(%rbp)
0000000100008a13	leaq	_fwp_owner_release8(%rip), %rax
0000000100008a1a	movq	%rax, -0xb0(%rbp)
0000000100008a21	leaq	-0xc0(%rbp), %rax
0000000100008a28	movq	%rax, -0xa8(%rbp)
0000000100008a2f	leaq	-0xb8(%rbp), %rax
0000000100008a36	movq	%rax, _fwp_cleanups(%rip)
0000000100008a3d	movq	%r13, -0x60(%rbp)
0000000100008a41	movq	%r14, -0x58(%rbp)
0000000100008a45	movq	%r12, -0x50(%rbp)
0000000100008a49	movl	$0x20, %edi
0000000100008a4e	callq	_fwp_alloc_init
0000000100008a53	movq	%rax, %r15
0000000100008a56	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100008a60	movq	%rax, (%r15)
0000000100008a63	movq	%r13, 0x8(%r15)
0000000100008a67	movq	%r14, 0x10(%r15)
0000000100008a6b	movq	%r12, 0x18(%r15)
0000000100008a6f	leaq	-0x60(%rbp), %rax
0000000100008a73	movq	%r15, %rax
0000000100008a76	subq	0xd5bb(%rip), %rax
0000000100008a7d	movq	0xd5dc(%rip), %rcx
0000000100008a84	shlq	$0x10, %rcx
0000000100008a88	cmpq	%rcx, %rax
0000000100008a8b	jae	0x100008afd
0000000100008a8d	movq	0xd5ec(%rip), %rcx
0000000100008a94	movq	%rax, %rdx
0000000100008a97	shrq	$0x10, %rdx
0000000100008a9b	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008aa2	leaq	(%rcx,%rdx), %r14
0000000100008aa6	movzbl	(%rcx,%rdx), %ecx
0000000100008aaa	cmpb	$0x2, %cl
0000000100008aad	setne	%dl
0000000100008ab0	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008ab6	setne	%sil
0000000100008aba	orb	%dl, %sil
0000000100008abd	jne	0x100008ad2
0000000100008abf	addq	$0x228, %r14                    ## imm = 0x228
0000000100008ac6	cmpb	$-0x1, (%r14)
0000000100008aca	je	0x100008af3
0000000100008acc	movb	$0x1, (%r14)
0000000100008ad0	jmp	0x100008afd
0000000100008ad2	cmpb	$0x1, %cl
0000000100008ad5	jne	0x100008afd
0000000100008ad7	movl	0x20(%r14), %ecx
0000000100008adb	imulq	%rcx, %rax
0000000100008adf	shrq	$0x20, %rax
0000000100008ae3	addq	%rax, %r14
0000000100008ae6	addq	$0x228, %r14                    ## imm = 0x228
0000000100008aed	cmpb	$-0x1, (%r14)
0000000100008af1	jne	0x100008acc
0000000100008af3	movq	%r14, %rdi
0000000100008af6	callq	_fwp_rc_forget_slot
0000000100008afb	jmp	0x100008acc
0000000100008afd	leaq	-0xb8(%rbp), %rax
0000000100008b04	cmpq	%rax, _fwp_cleanups(%rip)
0000000100008b0b	jne	0x100008ca2
0000000100008b11	movq	-0xb8(%rbp), %rax
0000000100008b18	movq	%r15, -0xa0(%rbp)
0000000100008b1f	movq	%rax, -0xf8(%rbp)
0000000100008b26	leaq	_fwp_owner_release9(%rip), %rax
0000000100008b2d	movq	%rax, -0xf0(%rbp)
0000000100008b34	leaq	-0xa0(%rbp), %rax
0000000100008b3b	movq	%rax, -0xe8(%rbp)
0000000100008b42	leaq	-0xf8(%rbp), %r12
0000000100008b49	movq	%r12, _fwp_cleanups(%rip)
0000000100008b50	movq	%r15, -0x68(%rbp)
0000000100008b54	movl	$0x10, %edi
0000000100008b59	callq	_fwp_alloc_init
0000000100008b5e	movq	%rax, %r14
0000000100008b61	movabsq	$__mh_execute_header, %rax
0000000100008b6b	movq	%rax, (%r14)
0000000100008b6e	movq	%r15, 0x8(%r14)
0000000100008b72	leaq	-0x68(%rbp), %rax
0000000100008b76	movq	%r14, %rax
0000000100008b79	subq	0xd4b8(%rip), %rax
0000000100008b80	movq	0xd4d9(%rip), %rcx
0000000100008b87	shlq	$0x10, %rcx
0000000100008b8b	cmpq	%rcx, %rax
0000000100008b8e	jae	0x100008c00
0000000100008b90	movq	0xd4e9(%rip), %rcx
0000000100008b97	movq	%rax, %rdx
0000000100008b9a	shrq	$0x10, %rdx
0000000100008b9e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008ba5	leaq	(%rcx,%rdx), %r15
0000000100008ba9	movzbl	(%rcx,%rdx), %ecx
0000000100008bad	cmpb	$0x2, %cl
0000000100008bb0	setne	%dl
0000000100008bb3	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008bb9	setne	%sil
0000000100008bbd	orb	%dl, %sil
0000000100008bc0	jne	0x100008bd5
0000000100008bc2	addq	$0x228, %r15                    ## imm = 0x228
0000000100008bc9	cmpb	$-0x1, (%r15)
0000000100008bcd	je	0x100008bf6
0000000100008bcf	movb	$0x1, (%r15)
0000000100008bd3	jmp	0x100008c00
0000000100008bd5	cmpb	$0x1, %cl
0000000100008bd8	jne	0x100008c00
0000000100008bda	movl	0x20(%r15), %ecx
0000000100008bde	imulq	%rcx, %rax
0000000100008be2	shrq	$0x20, %rax
0000000100008be6	addq	%rax, %r15
0000000100008be9	addq	$0x228, %r15                    ## imm = 0x228
0000000100008bf0	cmpb	$-0x1, (%r15)
0000000100008bf4	jne	0x100008bcf
0000000100008bf6	movq	%r15, %rdi
0000000100008bf9	callq	_fwp_rc_forget_slot
0000000100008bfe	jmp	0x100008bcf
0000000100008c00	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008c07	jne	0x100008ca2
0000000100008c0d	movq	-0xf8(%rbp), %rax
0000000100008c14	movq	%rax, _fwp_cleanups(%rip)
0000000100008c1b	leaq	-0x90(%rbp), %r12
0000000100008c22	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008c29	jne	0x100008ca2
0000000100008c2b	movq	-0x90(%rbp), %rax
0000000100008c32	movq	%rax, _fwp_cleanups(%rip)
0000000100008c39	movq	%rbx, %rdi
0000000100008c3c	callq	_fwp_drop3
0000000100008c41	movq	0xb3e8(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008c48	movq	(%rax), %rax
0000000100008c4b	cmpq	-0x30(%rbp), %rax
0000000100008c4f	jne	0x100008ca7
0000000100008c51	movq	%r14, %rax
0000000100008c54	addq	$0xd8, %rsp
0000000100008c5b	popq	%rbx
0000000100008c5c	popq	%r12
0000000100008c5e	popq	%r13
0000000100008c60	popq	%r14
0000000100008c62	popq	%r15
0000000100008c64	popq	%rbp
0000000100008c65	retq
0000000100008c66	callq	_fwp_rc_wide_dup
0000000100008c6b	movq	_fwp_cleanups(%rip), %rax
0000000100008c72	movq	0x10(%rbx), %rdi
0000000100008c76	movq	%rdi, -0x78(%rbp)
0000000100008c7a	cmpq	%r14, %rax
0000000100008c7d	je	0x10000879b
0000000100008c83	jmp	0x100008ca2
0000000100008c85	movq	%rdi, -0x70(%rbp)
0000000100008c89	movq	%rax, %rdi
0000000100008c8c	callq	_fwp_rc_wide_dup
0000000100008c91	movq	-0x70(%rbp), %rdi
0000000100008c95	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008c9c	je	0x1000089bb
0000000100008ca2	callq	0x10001203a                     ## symbol stub for: _abort
0000000100008ca7	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100008cac	nopl	(%rax)
_fwp_owner_release10:
0000000100008cb0	pushq	%rbp
0000000100008cb1	movq	%rsp, %rbp
0000000100008cb4	movq	(%rdi), %rdi
0000000100008cb7	popq	%rbp
0000000100008cb8	jmp	_fwp_drop3
0000000100008cbd	nopl	(%rax)
_fwp_owner_release11:
0000000100008cc0	pushq	%rbp
0000000100008cc1	movq	%rsp, %rbp
0000000100008cc4	movq	(%rdi), %rdi
0000000100008cc7	popq	%rbp
0000000100008cc8	jmp	_fwp_drop0
0000000100008ccd	nopl	(%rax)
_fwp_drop3:
0000000100008cd0	movq	%rdi, %rcx
0000000100008cd3	subq	0xd35e(%rip), %rcx
0000000100008cda	movq	0xd37f(%rip), %rax
0000000100008ce1	shlq	$0x10, %rax
0000000100008ce5	cmpq	%rax, %rcx
0000000100008ce8	jae	0x100008d7e
0000000100008cee	movq	0xd38b(%rip), %rdx
0000000100008cf5	movq	%rcx, %rax
0000000100008cf8	shrq	$0x10, %rax
0000000100008cfc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008d03	leaq	(%rdx,%rsi), %rax
0000000100008d07	movzbl	(%rdx,%rsi), %edx
0000000100008d0b	cmpb	$0x2, %dl
0000000100008d0e	setne	%sil
0000000100008d12	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008d19	setne	%r8b
0000000100008d1d	orb	%sil, %r8b
0000000100008d20	jne	0x100008d2a
0000000100008d22	addq	$0x228, %rax                    ## imm = 0x228
0000000100008d28	jmp	0x100008d43
0000000100008d2a	cmpb	$0x1, %dl
0000000100008d2d	jne	0x100008d7e
0000000100008d2f	movl	0x20(%rax), %edx
0000000100008d32	imulq	%rdx, %rcx
0000000100008d36	shrq	$0x20, %rcx
0000000100008d3a	addq	%rcx, %rax
0000000100008d3d	addq	$0x228, %rax                    ## imm = 0x228
0000000100008d43	movzbl	(%rax), %ecx
0000000100008d46	testl	%ecx, %ecx
0000000100008d48	je	0x100008d7e
0000000100008d4a	cmpl	$0x1, %ecx
0000000100008d4d	jne	0x100008d72
0000000100008d4f	pushq	%rbp
0000000100008d50	movq	%rsp, %rbp
0000000100008d53	pushq	%rbx
0000000100008d54	pushq	%rax
0000000100008d55	movq	0x10(%rdi), %rax
0000000100008d59	movq	%rdi, %rbx
0000000100008d5c	movq	%rax, %rdi
0000000100008d5f	callq	_fwp_drop0
0000000100008d64	movq	%rbx, %rdi
0000000100008d67	addq	$0x8, %rsp
0000000100008d6b	popq	%rbx
0000000100008d6c	popq	%rbp
0000000100008d6d	jmp	_fwp_rc_free_obj
0000000100008d72	cmpl	$0xff, %ecx
0000000100008d78	je	0x100008d7f
0000000100008d7a	decb	%cl
0000000100008d7c	movb	%cl, (%rax)
0000000100008d7e	retq
0000000100008d7f	movq	%rax, %rdi
0000000100008d82	jmp	_fwp_rc_wide_drop
0000000100008d87	nopw	(%rax,%rax)
_fwp_owner_release7:
0000000100008d90	pushq	%rbp
0000000100008d91	movq	%rsp, %rbp
0000000100008d94	movq	(%rdi), %rdi
0000000100008d97	popq	%rbp
0000000100008d98	jmp	_fwp_drop0
0000000100008d9d	nopl	(%rax)
_fwp_owner_release8:
0000000100008da0	pushq	%rbp
0000000100008da1	movq	%rsp, %rbp
0000000100008da4	movq	(%rdi), %rdi
0000000100008da7	popq	%rbp
0000000100008da8	jmp	_fwp_drop0
0000000100008dad	nopl	(%rax)
_fwp_owner_release9:
0000000100008db0	pushq	%rbp
0000000100008db1	movq	%rsp, %rbp
0000000100008db4	movq	(%rdi), %rax
0000000100008db7	subq	0xd27a(%rip), %rax
0000000100008dbe	movq	0xd29b(%rip), %rcx
0000000100008dc5	shlq	$0x10, %rcx
0000000100008dc9	cmpq	%rcx, %rax
0000000100008dcc	jae	0x100008e32
0000000100008dce	movq	0xd2ab(%rip), %rcx
0000000100008dd5	movq	%rax, %rdx
0000000100008dd8	shrq	$0x10, %rdx
0000000100008ddc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008de3	leaq	(%rcx,%rdx), %rdi
0000000100008de7	movzbl	(%rcx,%rdx), %ecx
0000000100008deb	cmpb	$0x2, %cl
0000000100008dee	setne	%dl
0000000100008df1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008df7	setne	%sil
0000000100008dfb	orb	%dl, %sil
0000000100008dfe	jne	0x100008e09
0000000100008e00	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008e07	jmp	0x100008e23
0000000100008e09	cmpb	$0x1, %cl
0000000100008e0c	jne	0x100008e32
0000000100008e0e	movl	0x20(%rdi), %ecx
0000000100008e11	imulq	%rcx, %rax
0000000100008e15	shrq	$0x20, %rax
0000000100008e19	addq	%rax, %rdi
0000000100008e1c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008e23	movzbl	(%rdi), %eax
0000000100008e26	cmpb	$0x2, %al
0000000100008e28	jb	0x100008e32
0000000100008e2a	cmpb	$-0x1, %al
0000000100008e2c	je	0x100008e34
0000000100008e2e	decb	%al
0000000100008e30	movb	%al, (%rdi)
0000000100008e32	popq	%rbp
0000000100008e33	retq
0000000100008e34	popq	%rbp
0000000100008e35	jmp	_fwp_rc_wide_drop
0000000100008e3a	nopw	(%rax,%rax)
_fwp_owned_entry32:
0000000100008e40	pushq	%rbp
0000000100008e41	movq	%rsp, %rbp
0000000100008e44	movq	(%rdi), %rdi
0000000100008e47	popq	%rbp
0000000100008e48	jmp	_f32
0000000100008e4d	nopl	(%rax)
_fwp_caps32:
0000000100008e50	movl	0x4(%rdi), %eax
0000000100008e53	testl	%esi, %esi
0000000100008e55	je	0x100008eb9
0000000100008e57	testl	%eax, %eax
0000000100008e59	je	0x100008f11
0000000100008e5f	movq	0x8(%rdi), %rax
0000000100008e63	subq	0xd1ce(%rip), %rax
0000000100008e6a	movq	0xd1ef(%rip), %rcx
0000000100008e71	shlq	$0x10, %rcx
0000000100008e75	cmpq	%rcx, %rax
0000000100008e78	jae	0x100008f11
0000000100008e7e	movq	0xd1fb(%rip), %rcx
0000000100008e85	movq	%rax, %rdx
0000000100008e88	shrq	$0x10, %rdx
0000000100008e8c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008e93	leaq	(%rcx,%rdx), %rdi
0000000100008e97	movzbl	(%rcx,%rdx), %ecx
0000000100008e9b	cmpb	$0x2, %cl
0000000100008e9e	setne	%dl
0000000100008ea1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008ea7	setne	%sil
0000000100008eab	orb	%dl, %sil
0000000100008eae	jne	0x100008ee4
0000000100008eb0	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008eb7	jmp	0x100008efe
0000000100008eb9	testl	%eax, %eax
0000000100008ebb	je	_fwp_rc_free_obj
0000000100008ec1	pushq	%rbp
0000000100008ec2	movq	%rsp, %rbp
0000000100008ec5	pushq	%rbx
0000000100008ec6	pushq	%rax
0000000100008ec7	movq	0x8(%rdi), %rax
0000000100008ecb	movq	%rdi, %rbx
0000000100008ece	movq	%rax, %rdi
0000000100008ed1	callq	_fwp_drop3
0000000100008ed6	movq	%rbx, %rdi
0000000100008ed9	addq	$0x8, %rsp
0000000100008edd	popq	%rbx
0000000100008ede	popq	%rbp
0000000100008edf	jmp	_fwp_rc_free_obj
0000000100008ee4	cmpb	$0x1, %cl
0000000100008ee7	jne	0x100008f11
0000000100008ee9	movl	0x20(%rdi), %ecx
0000000100008eec	imulq	%rcx, %rax
0000000100008ef0	shrq	$0x20, %rax
0000000100008ef4	addq	%rax, %rdi
0000000100008ef7	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008efe	movzbl	(%rdi), %eax
0000000100008f01	testb	%al, %al
0000000100008f03	je	0x100008f11
0000000100008f05	cmpb	$-0x2, %al
0000000100008f07	jae	_fwp_rc_wide_dup
0000000100008f0d	incb	%al
0000000100008f0f	movb	%al, (%rdi)
0000000100008f11	retq
0000000100008f12	nopw	%cs:(%rax,%rax)
_fwp_args32:
0000000100008f20	pushq	%rbp
0000000100008f21	movq	%rsp, %rbp
0000000100008f24	testl	%esi, %esi
0000000100008f26	setne	%al
0000000100008f29	testl	%edx, %edx
0000000100008f2b	sete	%cl
0000000100008f2e	orb	%al, %cl
0000000100008f30	jne	0x100008fb0
0000000100008f32	movq	(%rdi), %rax
0000000100008f35	subq	0xd0fc(%rip), %rax
0000000100008f3c	movq	0xd11d(%rip), %rcx
0000000100008f43	shlq	$0x10, %rcx
0000000100008f47	cmpq	%rcx, %rax
0000000100008f4a	jae	0x100008fb0
0000000100008f4c	movq	0xd12d(%rip), %rcx
0000000100008f53	movq	%rax, %rdx
0000000100008f56	shrq	$0x10, %rdx
0000000100008f5a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008f61	leaq	(%rcx,%rdx), %rdi
0000000100008f65	movzbl	(%rcx,%rdx), %ecx
0000000100008f69	cmpb	$0x2, %cl
0000000100008f6c	setne	%dl
0000000100008f6f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008f75	setne	%sil
0000000100008f79	orb	%dl, %sil
0000000100008f7c	jne	0x100008f87
0000000100008f7e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008f85	jmp	0x100008fa1
0000000100008f87	cmpb	$0x1, %cl
0000000100008f8a	jne	0x100008fb0
0000000100008f8c	movl	0x20(%rdi), %ecx
0000000100008f8f	imulq	%rcx, %rax
0000000100008f93	shrq	$0x20, %rax
0000000100008f97	addq	%rax, %rdi
0000000100008f9a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008fa1	movzbl	(%rdi), %eax
0000000100008fa4	testb	%al, %al
0000000100008fa6	je	0x100008fb0
0000000100008fa8	cmpb	$-0x2, %al
0000000100008faa	jae	0x100008fb2
0000000100008fac	incb	%al
0000000100008fae	movb	%al, (%rdi)
0000000100008fb0	popq	%rbp
0000000100008fb1	retq
0000000100008fb2	popq	%rbp
0000000100008fb3	jmp	_fwp_rc_wide_dup
0000000100008fb8	nopl	(%rax,%rax)
_fwp_arg_drop32:
0000000100008fc0	pushq	%rbp
0000000100008fc1	movq	%rsp, %rbp
0000000100008fc4	testl	%esi, %esi
0000000100008fc6	setne	%al
0000000100008fc9	testl	%edx, %edx
0000000100008fcb	sete	%cl
0000000100008fce	orb	%al, %cl
0000000100008fd0	je	0x100008fd4
0000000100008fd2	popq	%rbp
0000000100008fd3	retq
0000000100008fd4	movq	(%rdi), %rdi
0000000100008fd7	popq	%rbp
0000000100008fd8	jmp	_fwp_drop3
0000000100008fdd	nopl	(%rax)
_f35:
0000000100008fe0	pushq	%rbp
0000000100008fe1	movq	%rsp, %rbp
0000000100008fe4	pushq	%r15
0000000100008fe6	pushq	%r14
0000000100008fe8	pushq	%r13
0000000100008fea	pushq	%r12
0000000100008fec	pushq	%rbx
0000000100008fed	subq	$0x158, %rsp                    ## imm = 0x158
0000000100008ff4	movq	%rdi, %rbx
0000000100008ff7	movq	0xb032(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008ffe	movq	(%rax), %rax
0000000100009001	movq	%rax, -0x30(%rbp)
0000000100009005	movq	%rdi, -0xd8(%rbp)
000000010000900c	movq	_fwp_cleanups(%rip), %rax
0000000100009013	movq	%rax, -0xd0(%rbp)
000000010000901a	leaq	_fwp_owner_release18(%rip), %rax
0000000100009021	movq	%rax, -0xc8(%rbp)
0000000100009028	leaq	-0xd8(%rbp), %rax
000000010000902f	movq	%rax, -0xc0(%rbp)
0000000100009036	movq	$0x0, -0xb8(%rbp)
0000000100009041	leaq	-0xd0(%rbp), %r15
0000000100009048	movq	%r15, -0x110(%rbp)
000000010000904f	leaq	_fwp_owner_release19(%rip), %rax
0000000100009056	movq	%rax, -0x108(%rbp)
000000010000905d	leaq	-0xb8(%rbp), %rax
0000000100009064	movq	%rax, -0x100(%rbp)
000000010000906b	leaq	-0x110(%rbp), %r14
0000000100009072	movq	%r14, _fwp_cleanups(%rip)
0000000100009079	movq	0x10(%rdi), %rax
000000010000907d	subq	0xcfb4(%rip), %rax
0000000100009084	movq	0xcfd5(%rip), %rcx
000000010000908b	shlq	$0x10, %rcx
000000010000908f	cmpq	%rcx, %rax
0000000100009092	jae	0x1000090fc
0000000100009094	movq	0xcfe5(%rip), %rcx
000000010000909b	movq	%rax, %rdx
000000010000909e	shrq	$0x10, %rdx
00000001000090a2	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000090a9	leaq	(%rcx,%rdx), %rdi
00000001000090ad	movzbl	(%rcx,%rdx), %ecx
00000001000090b1	cmpb	$0x2, %cl
00000001000090b4	setne	%dl
00000001000090b7	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000090bd	setne	%sil
00000001000090c1	orb	%dl, %sil
00000001000090c4	jne	0x1000090cf
00000001000090c6	addq	$0x228, %rdi                    ## imm = 0x228
00000001000090cd	jmp	0x1000090e9
00000001000090cf	cmpb	$0x1, %cl
00000001000090d2	jne	0x1000090fc
00000001000090d4	movl	0x20(%rdi), %ecx
00000001000090d7	imulq	%rcx, %rax
00000001000090db	shrq	$0x20, %rax
00000001000090df	addq	%rax, %rdi
00000001000090e2	addq	$0x228, %rdi                    ## imm = 0x228
00000001000090e9	movzbl	(%rdi), %eax
00000001000090ec	testb	%al, %al
00000001000090ee	je	0x1000090fc
00000001000090f0	cmpb	$-0x3, %al
00000001000090f2	ja	0x100009664
00000001000090f8	incb	%al
00000001000090fa	movb	%al, (%rdi)
00000001000090fc	movq	0x10(%rbx), %rdi
0000000100009100	movq	%rdi, -0xb8(%rbp)
0000000100009107	movq	-0x110(%rbp), %rax
000000010000910e	movq	%rax, _fwp_cleanups(%rip)
0000000100009115	movq	0x8(%rbx), %r12
0000000100009119	movq	0x18(%rbx), %r13
000000010000911d	testq	%r12, %r12
0000000100009120	js	0x100009165
0000000100009122	movq	(%rdi), %rdx
0000000100009125	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000912f	andq	%rdx, %rax
0000000100009132	cmpq	%r12, %rax
0000000100009135	jbe	0x100009165
0000000100009137	movl	_d2(%rip), %eax
000000010000913d	movl	$0x8, %ecx
0000000100009142	cmpq	$0xa, %rax
0000000100009146	ja	0x100009153
0000000100009148	leaq	0x9419(%rip), %rcx
000000010000914f	movq	(%rcx,%rax,8), %rcx
0000000100009153	testq	%rdx, %rdx
0000000100009156	js	0x100009238
000000010000915c	leaq	0x8(%rdi), %rdx
0000000100009160	jmp	0x10000923c
0000000100009165	callq	_fwp_drop0
000000010000916a	movq	%r13, -0x90(%rbp)
0000000100009171	movl	$0x10, %edi
0000000100009176	callq	_fwp_alloc_init
000000010000917b	movq	%rax, %r14
000000010000917e	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100009188	movq	%rax, (%r14)
000000010000918b	movq	%r13, 0x8(%r14)
000000010000918f	leaq	-0x90(%rbp), %rax
0000000100009196	movq	%r14, %rax
0000000100009199	subq	0xce98(%rip), %rax
00000001000091a0	movq	0xceb9(%rip), %rcx
00000001000091a7	shlq	$0x10, %rcx
00000001000091ab	cmpq	%rcx, %rax
00000001000091ae	jae	0x100009226
00000001000091b0	movq	%r15, %r12
00000001000091b3	movq	0xcec6(%rip), %rcx
00000001000091ba	movq	%rax, %rdx
00000001000091bd	shrq	$0x10, %rdx
00000001000091c1	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000091c8	leaq	(%rcx,%rdx), %r15
00000001000091cc	movzbl	(%rcx,%rdx), %ecx
00000001000091d0	cmpb	$0x2, %cl
00000001000091d3	setne	%dl
00000001000091d6	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000091dc	setne	%sil
00000001000091e0	orb	%dl, %sil
00000001000091e3	jne	0x1000091f8
00000001000091e5	addq	$0x228, %r15                    ## imm = 0x228
00000001000091ec	cmpb	$-0x1, (%r15)
00000001000091f0	je	0x100009219
00000001000091f2	movb	$0x1, (%r15)
00000001000091f6	jmp	0x100009223
00000001000091f8	cmpb	$0x1, %cl
00000001000091fb	jne	0x100009223
00000001000091fd	movl	0x20(%r15), %ecx
0000000100009201	imulq	%rcx, %rax
0000000100009205	shrq	$0x20, %rax
0000000100009209	addq	%rax, %r15
000000010000920c	addq	$0x228, %r15                    ## imm = 0x228
0000000100009213	cmpb	$-0x1, (%r15)
0000000100009217	jne	0x1000091f2
0000000100009219	movq	%r15, %rdi
000000010000921c	callq	_fwp_rc_forget_slot
0000000100009221	jmp	0x1000091f2
0000000100009223	movq	%r12, %r15
0000000100009226	cmpq	%r15, _fwp_cleanups(%rip)
000000010000922d	je	0x100009629
0000000100009233	jmp	0x1000096a1
0000000100009238	movq	0x10(%rdi), %rdx
000000010000923c	movq	%rcx, %rsi
000000010000923f	imulq	%r12, %rsi
0000000100009243	cmpq	$0x1, %rcx
0000000100009247	je	0x100009268
0000000100009249	cmpq	$0x2, %rcx
000000010000924d	je	0x10000925b
000000010000924f	cmpq	$0x8, %rcx
0000000100009253	jne	0x100009275
0000000100009255	movq	(%rdx,%rsi), %rax
0000000100009259	jmp	0x100009282
000000010000925b	movzwl	(%rdx,%rsi), %ecx
000000010000925f	cmpl	$0x1, %eax
0000000100009262	movswq	%cx, %rax
0000000100009266	jmp	0x10000927e
0000000100009268	movzbl	(%rdx,%rsi), %ecx
000000010000926c	testq	%rax, %rax
000000010000926f	movsbq	%cl, %rax
0000000100009273	jmp	0x10000927e
0000000100009275	movl	(%rdx,%rsi), %ecx
0000000100009278	cmpl	$0x2, %eax
000000010000927b	movslq	%ecx, %rax
000000010000927e	cmovneq	%rcx, %rax
0000000100009282	movq	_fwp_cleanups(%rip), %rcx
0000000100009289	movq	%rdi, -0xf8(%rbp)
0000000100009290	movq	%rcx, -0x180(%rbp)
0000000100009297	leaq	_fwp_owner_release13(%rip), %rdx
000000010000929e	movq	%rdx, -0x178(%rbp)
00000001000092a5	leaq	-0xf8(%rbp), %rdx
00000001000092ac	movq	%rdx, -0x170(%rbp)
00000001000092b3	leaq	-0x180(%rbp), %rdx
00000001000092ba	movq	%rdx, _fwp_cleanups(%rip)
00000001000092c1	addq	$-0x7f, %rax
00000001000092c5	cmpq	$-0x101, %rax                   ## imm = 0xFEFF
00000001000092cb	jbe	0x1000096ab
00000001000092d1	movq	%rdi, -0xf0(%rbp)
00000001000092d8	movq	%rcx, -0x140(%rbp)
00000001000092df	leaq	_fwp_owner_release14(%rip), %rax
00000001000092e6	movq	%rax, -0x138(%rbp)
00000001000092ed	leaq	-0xf0(%rbp), %rax
00000001000092f4	movq	%rax, -0x130(%rbp)
00000001000092fb	leaq	-0x140(%rbp), %r14
0000000100009302	movq	%rdi, %rcx
0000000100009305	subq	0xcd2c(%rip), %rcx
000000010000930c	movq	%r14, _fwp_cleanups(%rip)
0000000100009313	movq	0xcd46(%rip), %rax
000000010000931a	shlq	$0x10, %rax
000000010000931e	cmpq	%rax, %rcx
0000000100009321	jae	0x10000938c
0000000100009323	movq	0xcd56(%rip), %rdx
000000010000932a	movq	%rcx, %rax
000000010000932d	shrq	$0x10, %rax
0000000100009331	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009338	leaq	(%rdx,%rsi), %rax
000000010000933c	movzbl	(%rdx,%rsi), %edx
0000000100009340	cmpb	$0x2, %dl
0000000100009343	setne	%sil
0000000100009347	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000934e	setne	%r8b
0000000100009352	orb	%sil, %r8b
0000000100009355	jne	0x10000935f
0000000100009357	addq	$0x228, %rax                    ## imm = 0x228
000000010000935d	jmp	0x100009378
000000010000935f	cmpb	$0x1, %dl
0000000100009362	jne	0x10000938c
0000000100009364	movl	0x20(%rax), %edx
0000000100009367	imulq	%rdx, %rcx
000000010000936b	shrq	$0x20, %rcx
000000010000936f	addq	%rcx, %rax
0000000100009372	addq	$0x228, %rax                    ## imm = 0x228
0000000100009378	movzbl	(%rax), %ecx
000000010000937b	testb	%cl, %cl
000000010000937d	je	0x10000938c
000000010000937f	cmpb	$-0x3, %cl
0000000100009382	ja	0x100009686
0000000100009388	incb	%cl
000000010000938a	movb	%cl, (%rax)
000000010000938c	movq	-0x140(%rbp), %rax
0000000100009393	movq	%rdi, -0x150(%rbp)
000000010000939a	movq	%rdi, -0x148(%rbp)
00000001000093a1	movq	%rax, -0x168(%rbp)
00000001000093a8	leaq	_fwp_owner_release15(%rip), %rcx
00000001000093af	movq	%rcx, -0x160(%rbp)
00000001000093b6	leaq	-0x150(%rbp), %rcx
00000001000093bd	movq	%rcx, -0x158(%rbp)
00000001000093c4	leaq	-0x168(%rbp), %rcx
00000001000093cb	movq	%rcx, _fwp_cleanups(%rip)
00000001000093d2	incq	%r13
00000001000093d5	jo	0x1000096bb
00000001000093db	incq	%r12
00000001000093de	movq	%rax, _fwp_cleanups(%rip)
00000001000093e5	movq	%rdi, %r14
00000001000093e8	callq	_fwp_drop0
00000001000093ed	movq	%r14, -0xe8(%rbp)
00000001000093f4	movq	_fwp_cleanups(%rip), %rax
00000001000093fb	movq	%rax, -0x90(%rbp)
0000000100009402	leaq	_fwp_owner_release16(%rip), %rax
0000000100009409	movq	%rax, -0x88(%rbp)
0000000100009410	leaq	-0xe8(%rbp), %rax
0000000100009417	movq	%rax, -0x80(%rbp)
000000010000941b	leaq	-0x90(%rbp), %rax
0000000100009422	movq	%rax, _fwp_cleanups(%rip)
0000000100009429	movq	%r12, -0xa8(%rbp)
0000000100009430	movq	%r14, -0xa0(%rbp)
0000000100009437	movq	%r13, -0x98(%rbp)
000000010000943e	movl	$0x20, %edi
0000000100009443	callq	_fwp_alloc_init
0000000100009448	movq	%rax, %r15
000000010000944b	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100009455	movq	%rax, (%r15)
0000000100009458	movq	%r12, 0x8(%r15)
000000010000945c	movq	%r14, 0x10(%r15)
0000000100009460	movq	%r13, 0x18(%r15)
0000000100009464	leaq	-0xa8(%rbp), %rax
000000010000946b	movq	%r15, %rax
000000010000946e	subq	0xcbc3(%rip), %rax
0000000100009475	movq	0xcbe4(%rip), %rcx
000000010000947c	shlq	$0x10, %rcx
0000000100009480	cmpq	%rcx, %rax
0000000100009483	jae	0x1000094f5
0000000100009485	movq	0xcbf4(%rip), %rcx
000000010000948c	movq	%rax, %rdx
000000010000948f	shrq	$0x10, %rdx
0000000100009493	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000949a	leaq	(%rcx,%rdx), %r14
000000010000949e	movzbl	(%rcx,%rdx), %ecx
00000001000094a2	cmpb	$0x2, %cl
00000001000094a5	setne	%dl
00000001000094a8	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000094ae	setne	%sil
00000001000094b2	orb	%dl, %sil
00000001000094b5	jne	0x1000094ca
00000001000094b7	addq	$0x228, %r14                    ## imm = 0x228
00000001000094be	cmpb	$-0x1, (%r14)
00000001000094c2	je	0x1000094eb
00000001000094c4	movb	$0x1, (%r14)
00000001000094c8	jmp	0x1000094f5
00000001000094ca	cmpb	$0x1, %cl
00000001000094cd	jne	0x1000094f5
00000001000094cf	movl	0x20(%r14), %ecx
00000001000094d3	imulq	%rcx, %rax
00000001000094d7	shrq	$0x20, %rax
00000001000094db	addq	%rax, %r14
00000001000094de	addq	$0x228, %r14                    ## imm = 0x228
00000001000094e5	cmpb	$-0x1, (%r14)
00000001000094e9	jne	0x1000094c4
00000001000094eb	movq	%r14, %rdi
00000001000094ee	callq	_fwp_rc_forget_slot
00000001000094f3	jmp	0x1000094c4
00000001000094f5	leaq	-0x90(%rbp), %rax
00000001000094fc	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009503	jne	0x1000096a1
0000000100009509	movq	-0x90(%rbp), %rax
0000000100009510	movq	%r15, -0xe0(%rbp)
0000000100009517	movq	%rax, -0x128(%rbp)
000000010000951e	leaq	_fwp_owner_release17(%rip), %rax
0000000100009525	movq	%rax, -0x120(%rbp)
000000010000952c	leaq	-0xe0(%rbp), %rax
0000000100009533	movq	%rax, -0x118(%rbp)
000000010000953a	leaq	-0x128(%rbp), %r12
0000000100009541	movq	%r12, _fwp_cleanups(%rip)
0000000100009548	movq	%r15, -0xb0(%rbp)
000000010000954f	movl	$0x10, %edi
0000000100009554	callq	_fwp_alloc_init
0000000100009559	movq	%rax, %r14
000000010000955c	movabsq	$__mh_execute_header, %rax
0000000100009566	movq	%rax, (%r14)
0000000100009569	movq	%r15, 0x8(%r14)
000000010000956d	leaq	-0xb0(%rbp), %rax
0000000100009574	movq	%r14, %rax
0000000100009577	subq	0xcaba(%rip), %rax
000000010000957e	movq	0xcadb(%rip), %rcx
0000000100009585	shlq	$0x10, %rcx
0000000100009589	cmpq	%rcx, %rax
000000010000958c	jae	0x1000095fe
000000010000958e	movq	0xcaeb(%rip), %rcx
0000000100009595	movq	%rax, %rdx
0000000100009598	shrq	$0x10, %rdx
000000010000959c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000095a3	leaq	(%rcx,%rdx), %r15
00000001000095a7	movzbl	(%rcx,%rdx), %ecx
00000001000095ab	cmpb	$0x2, %cl
00000001000095ae	setne	%dl
00000001000095b1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000095b7	setne	%sil
00000001000095bb	orb	%dl, %sil
00000001000095be	jne	0x1000095d3
00000001000095c0	addq	$0x228, %r15                    ## imm = 0x228
00000001000095c7	cmpb	$-0x1, (%r15)
00000001000095cb	je	0x1000095f4
00000001000095cd	movb	$0x1, (%r15)
00000001000095d1	jmp	0x1000095fe
00000001000095d3	cmpb	$0x1, %cl
00000001000095d6	jne	0x1000095fe
00000001000095d8	movl	0x20(%r15), %ecx
00000001000095dc	imulq	%rcx, %rax
00000001000095e0	shrq	$0x20, %rax
00000001000095e4	addq	%rax, %r15
00000001000095e7	addq	$0x228, %r15                    ## imm = 0x228
00000001000095ee	cmpb	$-0x1, (%r15)
00000001000095f2	jne	0x1000095cd
00000001000095f4	movq	%r15, %rdi
00000001000095f7	callq	_fwp_rc_forget_slot
00000001000095fc	jmp	0x1000095cd
00000001000095fe	cmpq	%r12, _fwp_cleanups(%rip)
0000000100009605	jne	0x1000096a1
000000010000960b	movq	-0x128(%rbp), %rax
0000000100009612	movq	%rax, _fwp_cleanups(%rip)
0000000100009619	leaq	-0xd0(%rbp), %r15
0000000100009620	cmpq	%r15, _fwp_cleanups(%rip)
0000000100009627	jne	0x1000096a1
0000000100009629	movq	-0xd0(%rbp), %rax
0000000100009630	movq	%rax, _fwp_cleanups(%rip)
0000000100009637	movq	%rbx, %rdi
000000010000963a	callq	_fwp_drop5
000000010000963f	movq	0xa9ea(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100009646	movq	(%rax), %rax
0000000100009649	cmpq	-0x30(%rbp), %rax
000000010000964d	jne	0x1000096a6
000000010000964f	movq	%r14, %rax
0000000100009652	addq	$0x158, %rsp                    ## imm = 0x158
0000000100009659	popq	%rbx
000000010000965a	popq	%r12
000000010000965c	popq	%r13
000000010000965e	popq	%r14
0000000100009660	popq	%r15
0000000100009662	popq	%rbp
0000000100009663	retq
0000000100009664	callq	_fwp_rc_wide_dup
0000000100009669	movq	_fwp_cleanups(%rip), %rax
0000000100009670	movq	0x10(%rbx), %rdi
0000000100009674	movq	%rdi, -0xb8(%rbp)
000000010000967b	cmpq	%r14, %rax
000000010000967e	je	0x100009107
0000000100009684	jmp	0x1000096a1
0000000100009686	movq	%rdi, %r15
0000000100009689	movq	%rax, %rdi
000000010000968c	callq	_fwp_rc_wide_dup
0000000100009691	movq	%r15, %rdi
0000000100009694	cmpq	%r14, _fwp_cleanups(%rip)
000000010000969b	je	0x10000938c
00000001000096a1	callq	0x10001203a                     ## symbol stub for: _abort
00000001000096a6	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
00000001000096ab	leaq	0x9184(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000096b2	leaq	0x91aa(%rip), %rcx              ## literal pool for: "I8"
00000001000096b9	jmp	0x1000096c9
00000001000096bb	leaq	0x9174(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000096c2	leaq	0x9169(%rip), %rcx              ## literal pool for: "I64"
00000001000096c9	leaq	-0x90(%rbp), %rbx
00000001000096d0	movl	$0x60, %esi
00000001000096d5	movq	%rbx, %rdi
00000001000096d8	xorl	%eax, %eax
00000001000096da	callq	0x10001211e                     ## symbol stub for: _snprintf
00000001000096df	callq	_fwp_flush
00000001000096e4	movq	0xa94d(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000096eb	movq	(%rax), %rdi
00000001000096ee	leaq	0x912a(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000096f5	movq	%rbx, %rdx
00000001000096f8	xorl	%eax, %eax
00000001000096fa	callq	0x10001206a                     ## symbol stub for: _fprintf
00000001000096ff	movl	$0x65, %edi
0000000100009704	callq	0x100012058                     ## symbol stub for: _exit
0000000100009709	nopl	(%rax)
_fwp_owner_release18:
0000000100009710	pushq	%rbp
0000000100009711	movq	%rsp, %rbp
0000000100009714	movq	(%rdi), %rdi
0000000100009717	popq	%rbp
0000000100009718	jmp	_fwp_drop5
000000010000971d	nopl	(%rax)
_fwp_owner_release19:
0000000100009720	pushq	%rbp
0000000100009721	movq	%rsp, %rbp
0000000100009724	movq	(%rdi), %rdi
0000000100009727	popq	%rbp
0000000100009728	jmp	_fwp_drop0
000000010000972d	nopl	(%rax)
_fwp_drop5:
0000000100009730	movq	%rdi, %rcx
0000000100009733	subq	0xc8fe(%rip), %rcx
000000010000973a	movq	0xc91f(%rip), %rax
0000000100009741	shlq	$0x10, %rax
0000000100009745	cmpq	%rax, %rcx
0000000100009748	jae	0x1000097de
000000010000974e	movq	0xc92b(%rip), %rdx
0000000100009755	movq	%rcx, %rax
0000000100009758	shrq	$0x10, %rax
000000010000975c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009763	leaq	(%rdx,%rsi), %rax
0000000100009767	movzbl	(%rdx,%rsi), %edx
000000010000976b	cmpb	$0x2, %dl
000000010000976e	setne	%sil
0000000100009772	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009779	setne	%r8b
000000010000977d	orb	%sil, %r8b
0000000100009780	jne	0x10000978a
0000000100009782	addq	$0x228, %rax                    ## imm = 0x228
0000000100009788	jmp	0x1000097a3
000000010000978a	cmpb	$0x1, %dl
000000010000978d	jne	0x1000097de
000000010000978f	movl	0x20(%rax), %edx
0000000100009792	imulq	%rdx, %rcx
0000000100009796	shrq	$0x20, %rcx
000000010000979a	addq	%rcx, %rax
000000010000979d	addq	$0x228, %rax                    ## imm = 0x228
00000001000097a3	movzbl	(%rax), %ecx
00000001000097a6	testl	%ecx, %ecx
00000001000097a8	je	0x1000097de
00000001000097aa	cmpl	$0x1, %ecx
00000001000097ad	jne	0x1000097d2
00000001000097af	pushq	%rbp
00000001000097b0	movq	%rsp, %rbp
00000001000097b3	pushq	%rbx
00000001000097b4	pushq	%rax
00000001000097b5	movq	0x10(%rdi), %rax
00000001000097b9	movq	%rdi, %rbx
00000001000097bc	movq	%rax, %rdi
00000001000097bf	callq	_fwp_drop0
00000001000097c4	movq	%rbx, %rdi
00000001000097c7	addq	$0x8, %rsp
00000001000097cb	popq	%rbx
00000001000097cc	popq	%rbp
00000001000097cd	jmp	_fwp_rc_free_obj
00000001000097d2	cmpl	$0xff, %ecx
00000001000097d8	je	0x1000097df
00000001000097da	decb	%cl
00000001000097dc	movb	%cl, (%rax)
00000001000097de	retq
00000001000097df	movq	%rax, %rdi
00000001000097e2	jmp	_fwp_rc_wide_drop
00000001000097e7	nopw	(%rax,%rax)
_fwp_owner_release13:
00000001000097f0	pushq	%rbp
00000001000097f1	movq	%rsp, %rbp
00000001000097f4	movq	(%rdi), %rdi
00000001000097f7	popq	%rbp
00000001000097f8	jmp	_fwp_drop0
00000001000097fd	nopl	(%rax)
_fwp_owner_release14:
0000000100009800	pushq	%rbp
0000000100009801	movq	%rsp, %rbp
0000000100009804	movq	(%rdi), %rdi
0000000100009807	popq	%rbp
0000000100009808	jmp	_fwp_drop0
000000010000980d	nopl	(%rax)
_fwp_owner_release15:
0000000100009810	pushq	%rbp
0000000100009811	movq	%rsp, %rbp
0000000100009814	pushq	%rbx
0000000100009815	pushq	%rax
0000000100009816	movq	%rdi, %rbx
0000000100009819	movq	(%rdi), %rdi
000000010000981c	callq	_fwp_drop0
0000000100009821	movq	0x8(%rbx), %rdi
0000000100009825	addq	$0x8, %rsp
0000000100009829	popq	%rbx
000000010000982a	popq	%rbp
000000010000982b	jmp	_fwp_drop0
_fwp_owner_release16:
0000000100009830	pushq	%rbp
0000000100009831	movq	%rsp, %rbp
0000000100009834	movq	(%rdi), %rdi
0000000100009837	popq	%rbp
0000000100009838	jmp	_fwp_drop0
000000010000983d	nopl	(%rax)
_fwp_owner_release17:
0000000100009840	pushq	%rbp
0000000100009841	movq	%rsp, %rbp
0000000100009844	movq	(%rdi), %rax
0000000100009847	subq	0xc7ea(%rip), %rax
000000010000984e	movq	0xc80b(%rip), %rcx
0000000100009855	shlq	$0x10, %rcx
0000000100009859	cmpq	%rcx, %rax
000000010000985c	jae	0x1000098c2
000000010000985e	movq	0xc81b(%rip), %rcx
0000000100009865	movq	%rax, %rdx
0000000100009868	shrq	$0x10, %rdx
000000010000986c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009873	leaq	(%rcx,%rdx), %rdi
0000000100009877	movzbl	(%rcx,%rdx), %ecx
000000010000987b	cmpb	$0x2, %cl
000000010000987e	setne	%dl
0000000100009881	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009887	setne	%sil
000000010000988b	orb	%dl, %sil
000000010000988e	jne	0x100009899
0000000100009890	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009897	jmp	0x1000098b3
0000000100009899	cmpb	$0x1, %cl
000000010000989c	jne	0x1000098c2
000000010000989e	movl	0x20(%rdi), %ecx
00000001000098a1	imulq	%rcx, %rax
00000001000098a5	shrq	$0x20, %rax
00000001000098a9	addq	%rax, %rdi
00000001000098ac	addq	$0x228, %rdi                    ## imm = 0x228
00000001000098b3	movzbl	(%rdi), %eax
00000001000098b6	cmpb	$0x2, %al
00000001000098b8	jb	0x1000098c2
00000001000098ba	cmpb	$-0x1, %al
00000001000098bc	je	0x1000098c4
00000001000098be	decb	%al
00000001000098c0	movb	%al, (%rdi)
00000001000098c2	popq	%rbp
00000001000098c3	retq
00000001000098c4	popq	%rbp
00000001000098c5	jmp	_fwp_rc_wide_drop
00000001000098ca	nopw	(%rax,%rax)
_fwp_owned_entry35:
00000001000098d0	pushq	%rbp
00000001000098d1	movq	%rsp, %rbp
00000001000098d4	movq	(%rdi), %rdi
00000001000098d7	popq	%rbp
00000001000098d8	jmp	_f35
00000001000098dd	nopl	(%rax)
_fwp_caps35:
00000001000098e0	movl	0x4(%rdi), %eax
00000001000098e3	testl	%esi, %esi
00000001000098e5	je	0x100009949
00000001000098e7	testl	%eax, %eax
00000001000098e9	je	0x1000099a1
00000001000098ef	movq	0x8(%rdi), %rax
00000001000098f3	subq	0xc73e(%rip), %rax
00000001000098fa	movq	0xc75f(%rip), %rcx
0000000100009901	shlq	$0x10, %rcx
0000000100009905	cmpq	%rcx, %rax
0000000100009908	jae	0x1000099a1
000000010000990e	movq	0xc76b(%rip), %rcx
0000000100009915	movq	%rax, %rdx
0000000100009918	shrq	$0x10, %rdx
000000010000991c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009923	leaq	(%rcx,%rdx), %rdi
0000000100009927	movzbl	(%rcx,%rdx), %ecx
000000010000992b	cmpb	$0x2, %cl
000000010000992e	setne	%dl
0000000100009931	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009937	setne	%sil
000000010000993b	orb	%dl, %sil
000000010000993e	jne	0x100009974
0000000100009940	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009947	jmp	0x10000998e
0000000100009949	testl	%eax, %eax
000000010000994b	je	_fwp_rc_free_obj
0000000100009951	pushq	%rbp
0000000100009952	movq	%rsp, %rbp
0000000100009955	pushq	%rbx
0000000100009956	pushq	%rax
0000000100009957	movq	0x8(%rdi), %rax
000000010000995b	movq	%rdi, %rbx
000000010000995e	movq	%rax, %rdi
0000000100009961	callq	_fwp_drop5
0000000100009966	movq	%rbx, %rdi
0000000100009969	addq	$0x8, %rsp
000000010000996d	popq	%rbx
000000010000996e	popq	%rbp
000000010000996f	jmp	_fwp_rc_free_obj
0000000100009974	cmpb	$0x1, %cl
0000000100009977	jne	0x1000099a1
0000000100009979	movl	0x20(%rdi), %ecx
000000010000997c	imulq	%rcx, %rax
0000000100009980	shrq	$0x20, %rax
0000000100009984	addq	%rax, %rdi
0000000100009987	addq	$0x228, %rdi                    ## imm = 0x228
000000010000998e	movzbl	(%rdi), %eax
0000000100009991	testb	%al, %al
0000000100009993	je	0x1000099a1
0000000100009995	cmpb	$-0x2, %al
0000000100009997	jae	_fwp_rc_wide_dup
000000010000999d	incb	%al
000000010000999f	movb	%al, (%rdi)
00000001000099a1	retq
00000001000099a2	nopw	%cs:(%rax,%rax)
_fwp_args35:
00000001000099b0	pushq	%rbp
00000001000099b1	movq	%rsp, %rbp
00000001000099b4	testl	%esi, %esi
00000001000099b6	setne	%al
00000001000099b9	testl	%edx, %edx
00000001000099bb	sete	%cl
00000001000099be	orb	%al, %cl
00000001000099c0	jne	0x100009a40
00000001000099c2	movq	(%rdi), %rax
00000001000099c5	subq	0xc66c(%rip), %rax
00000001000099cc	movq	0xc68d(%rip), %rcx
00000001000099d3	shlq	$0x10, %rcx
00000001000099d7	cmpq	%rcx, %rax
00000001000099da	jae	0x100009a40
00000001000099dc	movq	0xc69d(%rip), %rcx
00000001000099e3	movq	%rax, %rdx
00000001000099e6	shrq	$0x10, %rdx
00000001000099ea	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000099f1	leaq	(%rcx,%rdx), %rdi
00000001000099f5	movzbl	(%rcx,%rdx), %ecx
00000001000099f9	cmpb	$0x2, %cl
00000001000099fc	setne	%dl
00000001000099ff	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009a05	setne	%sil
0000000100009a09	orb	%dl, %sil
0000000100009a0c	jne	0x100009a17
0000000100009a0e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009a15	jmp	0x100009a31
0000000100009a17	cmpb	$0x1, %cl
0000000100009a1a	jne	0x100009a40
0000000100009a1c	movl	0x20(%rdi), %ecx
0000000100009a1f	imulq	%rcx, %rax
0000000100009a23	shrq	$0x20, %rax
0000000100009a27	addq	%rax, %rdi
0000000100009a2a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009a31	movzbl	(%rdi), %eax
0000000100009a34	testb	%al, %al
0000000100009a36	je	0x100009a40
0000000100009a38	cmpb	$-0x2, %al
0000000100009a3a	jae	0x100009a42
0000000100009a3c	incb	%al
0000000100009a3e	movb	%al, (%rdi)
0000000100009a40	popq	%rbp
0000000100009a41	retq
0000000100009a42	popq	%rbp
0000000100009a43	jmp	_fwp_rc_wide_dup
0000000100009a48	nopl	(%rax,%rax)
_fwp_arg_drop35:
0000000100009a50	pushq	%rbp
0000000100009a51	movq	%rsp, %rbp
0000000100009a54	testl	%esi, %esi
0000000100009a56	setne	%al
0000000100009a59	testl	%edx, %edx
0000000100009a5b	sete	%cl
0000000100009a5e	orb	%al, %cl
0000000100009a60	je	0x100009a64
0000000100009a62	popq	%rbp
0000000100009a63	retq
0000000100009a64	movq	(%rdi), %rdi
0000000100009a67	popq	%rbp
0000000100009a68	jmp	_fwp_drop5
0000000100009a6d	nopl	(%rax)
_f37:
0000000100009a70	pushq	%rbp
0000000100009a71	movq	%rsp, %rbp
0000000100009a74	pushq	%r15
0000000100009a76	pushq	%r14
0000000100009a78	pushq	%r13
0000000100009a7a	pushq	%r12
0000000100009a7c	pushq	%rbx
0000000100009a7d	subq	$0x158, %rsp                    ## imm = 0x158
0000000100009a84	movq	%rdi, %rbx
0000000100009a87	movq	0xa5a2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100009a8e	movq	(%rax), %rax
0000000100009a91	movq	%rax, -0x30(%rbp)
0000000100009a95	movq	%rdi, -0xd8(%rbp)
0000000100009a9c	movq	_fwp_cleanups(%rip), %rax
0000000100009aa3	movq	%rax, -0xd0(%rbp)
0000000100009aaa	leaq	_fwp_owner_release26(%rip), %rax
0000000100009ab1	movq	%rax, -0xc8(%rbp)
0000000100009ab8	leaq	-0xd8(%rbp), %rax
0000000100009abf	movq	%rax, -0xc0(%rbp)
0000000100009ac6	movq	$0x0, -0xb8(%rbp)
0000000100009ad1	leaq	-0xd0(%rbp), %r12
0000000100009ad8	movq	%r12, -0x130(%rbp)
0000000100009adf	leaq	_fwp_owner_release27(%rip), %rax
0000000100009ae6	movq	%rax, -0x128(%rbp)
0000000100009aed	leaq	-0xb8(%rbp), %rax
0000000100009af4	movq	%rax, -0x120(%rbp)
0000000100009afb	leaq	-0x130(%rbp), %r15
0000000100009b02	movq	%r15, _fwp_cleanups(%rip)
0000000100009b09	movq	0x10(%rdi), %rax
0000000100009b0d	subq	0xc524(%rip), %rax
0000000100009b14	movq	0xc545(%rip), %rcx
0000000100009b1b	shlq	$0x10, %rcx
0000000100009b1f	cmpq	%rcx, %rax
0000000100009b22	jae	0x100009b8c
0000000100009b24	movq	0xc555(%rip), %rcx
0000000100009b2b	movq	%rax, %rdx
0000000100009b2e	shrq	$0x10, %rdx
0000000100009b32	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009b39	leaq	(%rcx,%rdx), %rdi
0000000100009b3d	movzbl	(%rcx,%rdx), %ecx
0000000100009b41	cmpb	$0x2, %cl
0000000100009b44	setne	%dl
0000000100009b47	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009b4d	setne	%sil
0000000100009b51	orb	%dl, %sil
0000000100009b54	jne	0x100009b5f
0000000100009b56	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009b5d	jmp	0x100009b79
0000000100009b5f	cmpb	$0x1, %cl
0000000100009b62	jne	0x100009b8c
0000000100009b64	movl	0x20(%rdi), %ecx
0000000100009b67	imulq	%rcx, %rax
0000000100009b6b	shrq	$0x20, %rax
0000000100009b6f	addq	%rax, %rdi
0000000100009b72	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009b79	movzbl	(%rdi), %eax
0000000100009b7c	testb	%al, %al
0000000100009b7e	je	0x100009b8c
0000000100009b80	cmpb	$-0x3, %al
0000000100009b82	ja	0x10000a0ef
0000000100009b88	incb	%al
0000000100009b8a	movb	%al, (%rdi)
0000000100009b8c	movq	0x10(%rbx), %r14
0000000100009b90	movq	%r14, -0xb8(%rbp)
0000000100009b97	movq	-0x130(%rbp), %rax
0000000100009b9e	movq	%rax, _fwp_cleanups(%rip)
0000000100009ba5	movq	0x8(%rbx), %r13
0000000100009ba9	movsbq	0x18(%rbx), %r15
0000000100009bae	testq	%r13, %r13
0000000100009bb1	js	0x100009bf6
0000000100009bb3	movq	(%r14), %rdx
0000000100009bb6	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100009bc0	andq	%rdx, %rax
0000000100009bc3	cmpq	%r13, %rax
0000000100009bc6	jbe	0x100009bf6
0000000100009bc8	movl	_d2(%rip), %eax
0000000100009bce	movl	$0x8, %ecx
0000000100009bd3	cmpq	$0xa, %rax
0000000100009bd7	ja	0x100009be4
0000000100009bd9	leaq	0x8988(%rip), %rcx
0000000100009be0	movq	(%rcx,%rax,8), %rcx
0000000100009be4	testq	%rdx, %rdx
0000000100009be7	js	0x100009cbf
0000000100009bed	leaq	0x8(%r14), %rdx
0000000100009bf1	jmp	0x100009cc3
0000000100009bf6	movq	%r14, %rdi
0000000100009bf9	callq	_fwp_drop0
0000000100009bfe	movq	%r15, -0x90(%rbp)
0000000100009c05	movl	$0x10, %edi
0000000100009c0a	callq	_fwp_alloc_init
0000000100009c0f	movq	%rax, %r14
0000000100009c12	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100009c1c	movq	%rax, (%r14)
0000000100009c1f	movq	%r15, 0x8(%r14)
0000000100009c23	leaq	-0x90(%rbp), %rax
0000000100009c2a	movq	%r14, %rax
0000000100009c2d	subq	0xc404(%rip), %rax
0000000100009c34	movq	0xc425(%rip), %rcx
0000000100009c3b	shlq	$0x10, %rcx
0000000100009c3f	cmpq	%rcx, %rax
0000000100009c42	jae	0x10000a0ab
0000000100009c48	movq	0xc431(%rip), %rcx
0000000100009c4f	movq	%rax, %rdx
0000000100009c52	shrq	$0x10, %rdx
0000000100009c56	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009c5d	leaq	(%rcx,%rdx), %r15
0000000100009c61	movzbl	(%rcx,%rdx), %ecx
0000000100009c65	cmpb	$0x2, %cl
0000000100009c68	setne	%dl
0000000100009c6b	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009c71	setne	%sil
0000000100009c75	orb	%dl, %sil
0000000100009c78	jne	0x100009c90
0000000100009c7a	addq	$0x228, %r15                    ## imm = 0x228
0000000100009c81	cmpb	$-0x1, (%r15)
0000000100009c85	je	0x100009cb5
0000000100009c87	movb	$0x1, (%r15)
0000000100009c8b	jmp	0x10000a0ab
0000000100009c90	cmpb	$0x1, %cl
0000000100009c93	jne	0x10000a0ab
0000000100009c99	movl	0x20(%r15), %ecx
0000000100009c9d	imulq	%rcx, %rax
0000000100009ca1	shrq	$0x20, %rax
0000000100009ca5	addq	%rax, %r15
0000000100009ca8	addq	$0x228, %r15                    ## imm = 0x228
0000000100009caf	cmpb	$-0x1, (%r15)
0000000100009cb3	jne	0x100009c87
0000000100009cb5	movq	%r15, %rdi
0000000100009cb8	callq	_fwp_rc_forget_slot
0000000100009cbd	jmp	0x100009c87
0000000100009cbf	movq	0x10(%r14), %rdx
0000000100009cc3	movq	%rcx, %rsi
0000000100009cc6	imulq	%r13, %rsi
0000000100009cca	cmpq	$0x1, %rcx
0000000100009cce	je	0x100009cef
0000000100009cd0	cmpq	$0x2, %rcx
0000000100009cd4	je	0x100009ce2
0000000100009cd6	cmpq	$0x8, %rcx
0000000100009cda	jne	0x100009cfc
0000000100009cdc	movq	(%rdx,%rsi), %r12
0000000100009ce0	jmp	0x100009d09
0000000100009ce2	movzwl	(%rdx,%rsi), %ecx
0000000100009ce6	cmpl	$0x1, %eax
0000000100009ce9	movswq	%cx, %r12
0000000100009ced	jmp	0x100009d05
0000000100009cef	movzbl	(%rdx,%rsi), %ecx
0000000100009cf3	testq	%rax, %rax
0000000100009cf6	movsbq	%cl, %r12
0000000100009cfa	jmp	0x100009d05
0000000100009cfc	movl	(%rdx,%rsi), %ecx
0000000100009cff	cmpl	$0x2, %eax
0000000100009d02	movslq	%ecx, %r12
0000000100009d05	cmovneq	%rcx, %r12
0000000100009d09	movq	_fwp_cleanups(%rip), %rax
0000000100009d10	movq	%r14, -0x118(%rbp)
0000000100009d17	movq	%rax, -0x178(%rbp)
0000000100009d1e	leaq	_fwp_owner_release21(%rip), %rcx
0000000100009d25	movq	%rcx, -0x170(%rbp)
0000000100009d2c	leaq	-0x118(%rbp), %rcx
0000000100009d33	movq	%rcx, -0x168(%rbp)
0000000100009d3a	leaq	-0x178(%rbp), %rcx
0000000100009d41	movq	%rcx, _fwp_cleanups(%rip)
0000000100009d48	leaq	-0x7f(%r12), %rcx
0000000100009d4d	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100009d54	jbe	0x10000a134
0000000100009d5a	movq	%r14, -0x110(%rbp)
0000000100009d61	movq	%rax, -0x108(%rbp)
0000000100009d68	leaq	_fwp_owner_release22(%rip), %rax
0000000100009d6f	movq	%rax, -0x100(%rbp)
0000000100009d76	leaq	-0x110(%rbp), %rax
0000000100009d7d	movq	%rax, -0xf8(%rbp)
0000000100009d84	leaq	-0x108(%rbp), %rcx
0000000100009d8b	movq	%r14, %rax
0000000100009d8e	subq	0xc2a3(%rip), %rax
0000000100009d95	movq	%rcx, _fwp_cleanups(%rip)
0000000100009d9c	movq	0xc2bd(%rip), %rcx
0000000100009da3	shlq	$0x10, %rcx
0000000100009da7	cmpq	%rcx, %rax
0000000100009daa	jae	0x100009e14
0000000100009dac	movq	0xc2cd(%rip), %rcx
0000000100009db3	movq	%rax, %rdx
0000000100009db6	shrq	$0x10, %rdx
0000000100009dba	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009dc1	leaq	(%rcx,%rdx), %rdi
0000000100009dc5	movzbl	(%rcx,%rdx), %ecx
0000000100009dc9	cmpb	$0x2, %cl
0000000100009dcc	setne	%dl
0000000100009dcf	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009dd5	setne	%sil
0000000100009dd9	orb	%dl, %sil
0000000100009ddc	jne	0x100009de7
0000000100009dde	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009de5	jmp	0x100009e01
0000000100009de7	cmpb	$0x1, %cl
0000000100009dea	jne	0x100009e14
0000000100009dec	movl	0x20(%rdi), %ecx
0000000100009def	imulq	%rcx, %rax
0000000100009df3	shrq	$0x20, %rax
0000000100009df7	addq	%rax, %rdi
0000000100009dfa	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009e01	movzbl	(%rdi), %eax
0000000100009e04	testb	%al, %al
0000000100009e06	je	0x100009e14
0000000100009e08	cmpb	$-0x3, %al
0000000100009e0a	ja	0x10000a111
0000000100009e10	incb	%al
0000000100009e12	movb	%al, (%rdi)
0000000100009e14	movq	-0x108(%rbp), %rax
0000000100009e1b	movq	%rax, _fwp_cleanups(%rip)
0000000100009e22	movq	%r14, %rdi
0000000100009e25	callq	_fwp_drop0
0000000100009e2a	movq	%r14, -0xf0(%rbp)
0000000100009e31	movq	_fwp_cleanups(%rip), %rax
0000000100009e38	movq	%rax, -0x160(%rbp)
0000000100009e3f	leaq	_fwp_owner_release23(%rip), %rcx
0000000100009e46	movq	%rcx, -0x158(%rbp)
0000000100009e4d	leaq	-0xf0(%rbp), %rcx
0000000100009e54	movq	%rcx, -0x150(%rbp)
0000000100009e5b	leaq	-0x160(%rbp), %rcx
0000000100009e62	movq	%rcx, _fwp_cleanups(%rip)
0000000100009e69	addq	%r15, %r12
0000000100009e6c	incq	%r12
0000000100009e6f	movsbq	%r12b, %rcx
0000000100009e73	cmpq	%r12, %rcx
0000000100009e76	jne	0x10000a134
0000000100009e7c	incq	%r13
0000000100009e7f	movq	%r14, -0xe8(%rbp)
0000000100009e86	movq	%rax, -0x90(%rbp)
0000000100009e8d	leaq	_fwp_owner_release24(%rip), %rax
0000000100009e94	movq	%rax, -0x88(%rbp)
0000000100009e9b	leaq	-0xe8(%rbp), %rax
0000000100009ea2	movq	%rax, -0x80(%rbp)
0000000100009ea6	leaq	-0x90(%rbp), %rax
0000000100009ead	movq	%rax, _fwp_cleanups(%rip)
0000000100009eb4	movq	%r13, -0xa8(%rbp)
0000000100009ebb	movq	%r14, -0xa0(%rbp)
0000000100009ec2	movq	%r12, -0x98(%rbp)
0000000100009ec9	movl	$0x20, %edi
0000000100009ece	callq	_fwp_alloc_init
0000000100009ed3	movq	%rax, %r15
0000000100009ed6	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100009ee0	movq	%rax, (%r15)
0000000100009ee3	movq	%r13, 0x8(%r15)
0000000100009ee7	movq	%r14, 0x10(%r15)
0000000100009eeb	movq	%r12, 0x18(%r15)
0000000100009eef	leaq	-0xa8(%rbp), %rax
0000000100009ef6	movq	%r15, %rax
0000000100009ef9	subq	0xc138(%rip), %rax
0000000100009f00	movq	0xc159(%rip), %rcx
0000000100009f07	shlq	$0x10, %rcx
0000000100009f0b	cmpq	%rcx, %rax
0000000100009f0e	jae	0x100009f80
0000000100009f10	movq	0xc169(%rip), %rcx
0000000100009f17	movq	%rax, %rdx
0000000100009f1a	shrq	$0x10, %rdx
0000000100009f1e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009f25	leaq	(%rcx,%rdx), %r14
0000000100009f29	movzbl	(%rcx,%rdx), %ecx
0000000100009f2d	cmpb	$0x2, %cl
0000000100009f30	setne	%dl
0000000100009f33	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009f39	setne	%sil
0000000100009f3d	orb	%dl, %sil
0000000100009f40	jne	0x100009f55
0000000100009f42	addq	$0x228, %r14                    ## imm = 0x228
0000000100009f49	cmpb	$-0x1, (%r14)
0000000100009f4d	je	0x100009f76
0000000100009f4f	movb	$0x1, (%r14)
0000000100009f53	jmp	0x100009f80
0000000100009f55	cmpb	$0x1, %cl
0000000100009f58	jne	0x100009f80
0000000100009f5a	movl	0x20(%r14), %ecx
0000000100009f5e	imulq	%rcx, %rax
0000000100009f62	shrq	$0x20, %rax
0000000100009f66	addq	%rax, %r14
0000000100009f69	addq	$0x228, %r14                    ## imm = 0x228
0000000100009f70	cmpb	$-0x1, (%r14)
0000000100009f74	jne	0x100009f4f
0000000100009f76	movq	%r14, %rdi
0000000100009f79	callq	_fwp_rc_forget_slot
0000000100009f7e	jmp	0x100009f4f
0000000100009f80	leaq	-0x90(%rbp), %rax
0000000100009f87	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009f8e	jne	0x10000a12a
0000000100009f94	movq	-0x90(%rbp), %rax
0000000100009f9b	movq	%r15, -0xe0(%rbp)
0000000100009fa2	movq	%rax, -0x148(%rbp)
0000000100009fa9	leaq	_fwp_owner_release25(%rip), %rax
0000000100009fb0	movq	%rax, -0x140(%rbp)
0000000100009fb7	leaq	-0xe0(%rbp), %rax
0000000100009fbe	movq	%rax, -0x138(%rbp)
0000000100009fc5	leaq	-0x148(%rbp), %r12
0000000100009fcc	movq	%r12, _fwp_cleanups(%rip)
0000000100009fd3	movq	%r15, -0xb0(%rbp)
0000000100009fda	movl	$0x10, %edi
0000000100009fdf	callq	_fwp_alloc_init
0000000100009fe4	movq	%rax, %r14
0000000100009fe7	movabsq	$__mh_execute_header, %rax
0000000100009ff1	movq	%rax, (%r14)
0000000100009ff4	movq	%r15, 0x8(%r14)
0000000100009ff8	leaq	-0xb0(%rbp), %rax
0000000100009fff	movq	%r14, %rax
000000010000a002	subq	0xc02f(%rip), %rax
000000010000a009	movq	0xc050(%rip), %rcx
000000010000a010	shlq	$0x10, %rcx
000000010000a014	cmpq	%rcx, %rax
000000010000a017	jae	0x10000a089
000000010000a019	movq	0xc060(%rip), %rcx
000000010000a020	movq	%rax, %rdx
000000010000a023	shrq	$0x10, %rdx
000000010000a027	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a02e	leaq	(%rcx,%rdx), %r15
000000010000a032	movzbl	(%rcx,%rdx), %ecx
000000010000a036	cmpb	$0x2, %cl
000000010000a039	setne	%dl
000000010000a03c	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a042	setne	%sil
000000010000a046	orb	%dl, %sil
000000010000a049	jne	0x10000a05e
000000010000a04b	addq	$0x228, %r15                    ## imm = 0x228
000000010000a052	cmpb	$-0x1, (%r15)
000000010000a056	je	0x10000a07f
000000010000a058	movb	$0x1, (%r15)
000000010000a05c	jmp	0x10000a089
000000010000a05e	cmpb	$0x1, %cl
000000010000a061	jne	0x10000a089
000000010000a063	movl	0x20(%r15), %ecx
000000010000a067	imulq	%rcx, %rax
000000010000a06b	shrq	$0x20, %rax
000000010000a06f	addq	%rax, %r15
000000010000a072	addq	$0x228, %r15                    ## imm = 0x228
000000010000a079	cmpb	$-0x1, (%r15)
000000010000a07d	jne	0x10000a058
000000010000a07f	movq	%r15, %rdi
000000010000a082	callq	_fwp_rc_forget_slot
000000010000a087	jmp	0x10000a058
000000010000a089	cmpq	%r12, _fwp_cleanups(%rip)
000000010000a090	jne	0x10000a12a
000000010000a096	movq	-0x148(%rbp), %rax
000000010000a09d	movq	%rax, _fwp_cleanups(%rip)
000000010000a0a4	leaq	-0xd0(%rbp), %r12
000000010000a0ab	cmpq	%r12, _fwp_cleanups(%rip)
000000010000a0b2	jne	0x10000a12a
000000010000a0b4	movq	-0xd0(%rbp), %rax
000000010000a0bb	movq	%rax, _fwp_cleanups(%rip)
000000010000a0c2	movq	%rbx, %rdi
000000010000a0c5	callq	_fwp_drop6
000000010000a0ca	movq	0x9f5f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000a0d1	movq	(%rax), %rax
000000010000a0d4	cmpq	-0x30(%rbp), %rax
000000010000a0d8	jne	0x10000a12f
000000010000a0da	movq	%r14, %rax
000000010000a0dd	addq	$0x158, %rsp                    ## imm = 0x158
000000010000a0e4	popq	%rbx
000000010000a0e5	popq	%r12
000000010000a0e7	popq	%r13
000000010000a0e9	popq	%r14
000000010000a0eb	popq	%r15
000000010000a0ed	popq	%rbp
000000010000a0ee	retq
000000010000a0ef	callq	_fwp_rc_wide_dup
000000010000a0f4	movq	_fwp_cleanups(%rip), %rax
000000010000a0fb	movq	0x10(%rbx), %r14
000000010000a0ff	movq	%r14, -0xb8(%rbp)
000000010000a106	cmpq	%r15, %rax
000000010000a109	je	0x100009b97
000000010000a10f	jmp	0x10000a12a
000000010000a111	callq	_fwp_rc_wide_dup
000000010000a116	leaq	-0x108(%rbp), %rax
000000010000a11d	cmpq	%rax, _fwp_cleanups(%rip)
000000010000a124	je	0x100009e14
000000010000a12a	callq	0x10001203a                     ## symbol stub for: _abort
000000010000a12f	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000a134	leaq	0x86fb(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000a13b	leaq	0x8721(%rip), %rcx              ## literal pool for: "I8"
000000010000a142	leaq	-0x90(%rbp), %rbx
000000010000a149	movl	$0x60, %esi
000000010000a14e	movq	%rbx, %rdi
000000010000a151	xorl	%eax, %eax
000000010000a153	callq	0x10001211e                     ## symbol stub for: _snprintf
000000010000a158	callq	_fwp_flush
000000010000a15d	movq	0x9ed4(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000a164	movq	(%rax), %rdi
000000010000a167	leaq	0x86b1(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000a16e	movq	%rbx, %rdx
000000010000a171	xorl	%eax, %eax
000000010000a173	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000a178	movl	$0x65, %edi
000000010000a17d	callq	0x100012058                     ## symbol stub for: _exit
000000010000a182	nopw	%cs:(%rax,%rax)
_fwp_owner_release26:
000000010000a190	pushq	%rbp
000000010000a191	movq	%rsp, %rbp
000000010000a194	movq	(%rdi), %rdi
000000010000a197	popq	%rbp
000000010000a198	jmp	_fwp_drop6
000000010000a19d	nopl	(%rax)
_fwp_owner_release27:
000000010000a1a0	pushq	%rbp
000000010000a1a1	movq	%rsp, %rbp
000000010000a1a4	movq	(%rdi), %rdi
000000010000a1a7	popq	%rbp
000000010000a1a8	jmp	_fwp_drop0
000000010000a1ad	nopl	(%rax)
_fwp_drop6:
000000010000a1b0	movq	%rdi, %rcx
000000010000a1b3	subq	0xbe7e(%rip), %rcx
000000010000a1ba	movq	0xbe9f(%rip), %rax
000000010000a1c1	shlq	$0x10, %rax
000000010000a1c5	cmpq	%rax, %rcx
000000010000a1c8	jae	0x10000a25e
000000010000a1ce	movq	0xbeab(%rip), %rdx
000000010000a1d5	movq	%rcx, %rax
000000010000a1d8	shrq	$0x10, %rax
000000010000a1dc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
000000010000a1e3	leaq	(%rdx,%rsi), %rax
000000010000a1e7	movzbl	(%rdx,%rsi), %edx
000000010000a1eb	cmpb	$0x2, %dl
000000010000a1ee	setne	%sil
000000010000a1f2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000a1f9	setne	%r8b
000000010000a1fd	orb	%sil, %r8b
000000010000a200	jne	0x10000a20a
000000010000a202	addq	$0x228, %rax                    ## imm = 0x228
000000010000a208	jmp	0x10000a223
000000010000a20a	cmpb	$0x1, %dl
000000010000a20d	jne	0x10000a25e
000000010000a20f	movl	0x20(%rax), %edx
000000010000a212	imulq	%rdx, %rcx
000000010000a216	shrq	$0x20, %rcx
000000010000a21a	addq	%rcx, %rax
000000010000a21d	addq	$0x228, %rax                    ## imm = 0x228
000000010000a223	movzbl	(%rax), %ecx
000000010000a226	testl	%ecx, %ecx
000000010000a228	je	0x10000a25e
000000010000a22a	cmpl	$0x1, %ecx
000000010000a22d	jne	0x10000a252
000000010000a22f	pushq	%rbp
000000010000a230	movq	%rsp, %rbp
000000010000a233	pushq	%rbx
000000010000a234	pushq	%rax
000000010000a235	movq	0x10(%rdi), %rax
000000010000a239	movq	%rdi, %rbx
000000010000a23c	movq	%rax, %rdi
000000010000a23f	callq	_fwp_drop0
000000010000a244	movq	%rbx, %rdi
000000010000a247	addq	$0x8, %rsp
000000010000a24b	popq	%rbx
000000010000a24c	popq	%rbp
000000010000a24d	jmp	_fwp_rc_free_obj
000000010000a252	cmpl	$0xff, %ecx
000000010000a258	je	0x10000a25f
000000010000a25a	decb	%cl
000000010000a25c	movb	%cl, (%rax)
000000010000a25e	retq
000000010000a25f	movq	%rax, %rdi
000000010000a262	jmp	_fwp_rc_wide_drop
000000010000a267	nopw	(%rax,%rax)
_fwp_owner_release21:
000000010000a270	pushq	%rbp
000000010000a271	movq	%rsp, %rbp
000000010000a274	movq	(%rdi), %rdi
000000010000a277	popq	%rbp
000000010000a278	jmp	_fwp_drop0
000000010000a27d	nopl	(%rax)
_fwp_owner_release22:
000000010000a280	pushq	%rbp
000000010000a281	movq	%rsp, %rbp
000000010000a284	movq	(%rdi), %rdi
000000010000a287	popq	%rbp
000000010000a288	jmp	_fwp_drop0
000000010000a28d	nopl	(%rax)
_fwp_owner_release23:
000000010000a290	pushq	%rbp
000000010000a291	movq	%rsp, %rbp
000000010000a294	movq	(%rdi), %rdi
000000010000a297	popq	%rbp
000000010000a298	jmp	_fwp_drop0
000000010000a29d	nopl	(%rax)
_fwp_owner_release24:
000000010000a2a0	pushq	%rbp
000000010000a2a1	movq	%rsp, %rbp
000000010000a2a4	movq	(%rdi), %rdi
000000010000a2a7	popq	%rbp
000000010000a2a8	jmp	_fwp_drop0
000000010000a2ad	nopl	(%rax)
_fwp_owner_release25:
000000010000a2b0	pushq	%rbp
000000010000a2b1	movq	%rsp, %rbp
000000010000a2b4	movq	(%rdi), %rax
000000010000a2b7	subq	0xbd7a(%rip), %rax
000000010000a2be	movq	0xbd9b(%rip), %rcx
000000010000a2c5	shlq	$0x10, %rcx
000000010000a2c9	cmpq	%rcx, %rax
000000010000a2cc	jae	0x10000a332
000000010000a2ce	movq	0xbdab(%rip), %rcx
000000010000a2d5	movq	%rax, %rdx
000000010000a2d8	shrq	$0x10, %rdx
000000010000a2dc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a2e3	leaq	(%rcx,%rdx), %rdi
000000010000a2e7	movzbl	(%rcx,%rdx), %ecx
000000010000a2eb	cmpb	$0x2, %cl
000000010000a2ee	setne	%dl
000000010000a2f1	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a2f7	setne	%sil
000000010000a2fb	orb	%dl, %sil
000000010000a2fe	jne	0x10000a309
000000010000a300	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a307	jmp	0x10000a323
000000010000a309	cmpb	$0x1, %cl
000000010000a30c	jne	0x10000a332
000000010000a30e	movl	0x20(%rdi), %ecx
000000010000a311	imulq	%rcx, %rax
000000010000a315	shrq	$0x20, %rax
000000010000a319	addq	%rax, %rdi
000000010000a31c	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a323	movzbl	(%rdi), %eax
000000010000a326	cmpb	$0x2, %al
000000010000a328	jb	0x10000a332
000000010000a32a	cmpb	$-0x1, %al
000000010000a32c	je	0x10000a334
000000010000a32e	decb	%al
000000010000a330	movb	%al, (%rdi)
000000010000a332	popq	%rbp
000000010000a333	retq
000000010000a334	popq	%rbp
000000010000a335	jmp	_fwp_rc_wide_drop
000000010000a33a	nopw	(%rax,%rax)
_fwp_owned_entry37:
000000010000a340	pushq	%rbp
000000010000a341	movq	%rsp, %rbp
000000010000a344	movq	(%rdi), %rdi
000000010000a347	popq	%rbp
000000010000a348	jmp	_f37
000000010000a34d	nopl	(%rax)
_fwp_caps37:
000000010000a350	movl	0x4(%rdi), %eax
000000010000a353	testl	%esi, %esi
000000010000a355	je	0x10000a3b9
000000010000a357	testl	%eax, %eax
000000010000a359	je	0x10000a411
000000010000a35f	movq	0x8(%rdi), %rax
000000010000a363	subq	0xbcce(%rip), %rax
000000010000a36a	movq	0xbcef(%rip), %rcx
000000010000a371	shlq	$0x10, %rcx
000000010000a375	cmpq	%rcx, %rax
000000010000a378	jae	0x10000a411
000000010000a37e	movq	0xbcfb(%rip), %rcx
000000010000a385	movq	%rax, %rdx
000000010000a388	shrq	$0x10, %rdx
000000010000a38c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a393	leaq	(%rcx,%rdx), %rdi
000000010000a397	movzbl	(%rcx,%rdx), %ecx
000000010000a39b	cmpb	$0x2, %cl
000000010000a39e	setne	%dl
000000010000a3a1	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a3a7	setne	%sil
000000010000a3ab	orb	%dl, %sil
000000010000a3ae	jne	0x10000a3e4
000000010000a3b0	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a3b7	jmp	0x10000a3fe
000000010000a3b9	testl	%eax, %eax
000000010000a3bb	je	_fwp_rc_free_obj
000000010000a3c1	pushq	%rbp
000000010000a3c2	movq	%rsp, %rbp
000000010000a3c5	pushq	%rbx
000000010000a3c6	pushq	%rax
000000010000a3c7	movq	0x8(%rdi), %rax
000000010000a3cb	movq	%rdi, %rbx
000000010000a3ce	movq	%rax, %rdi
000000010000a3d1	callq	_fwp_drop6
000000010000a3d6	movq	%rbx, %rdi
000000010000a3d9	addq	$0x8, %rsp
000000010000a3dd	popq	%rbx
000000010000a3de	popq	%rbp
000000010000a3df	jmp	_fwp_rc_free_obj
000000010000a3e4	cmpb	$0x1, %cl
000000010000a3e7	jne	0x10000a411
000000010000a3e9	movl	0x20(%rdi), %ecx
000000010000a3ec	imulq	%rcx, %rax
000000010000a3f0	shrq	$0x20, %rax
000000010000a3f4	addq	%rax, %rdi
000000010000a3f7	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a3fe	movzbl	(%rdi), %eax
000000010000a401	testb	%al, %al
000000010000a403	je	0x10000a411
000000010000a405	cmpb	$-0x2, %al
000000010000a407	jae	_fwp_rc_wide_dup
000000010000a40d	incb	%al
000000010000a40f	movb	%al, (%rdi)
000000010000a411	retq
000000010000a412	nopw	%cs:(%rax,%rax)
_fwp_args37:
000000010000a420	pushq	%rbp
000000010000a421	movq	%rsp, %rbp
000000010000a424	testl	%esi, %esi
000000010000a426	setne	%al
000000010000a429	testl	%edx, %edx
000000010000a42b	sete	%cl
000000010000a42e	orb	%al, %cl
000000010000a430	jne	0x10000a4b0
000000010000a432	movq	(%rdi), %rax
000000010000a435	subq	0xbbfc(%rip), %rax
000000010000a43c	movq	0xbc1d(%rip), %rcx
000000010000a443	shlq	$0x10, %rcx
000000010000a447	cmpq	%rcx, %rax
000000010000a44a	jae	0x10000a4b0
000000010000a44c	movq	0xbc2d(%rip), %rcx
000000010000a453	movq	%rax, %rdx
000000010000a456	shrq	$0x10, %rdx
000000010000a45a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a461	leaq	(%rcx,%rdx), %rdi
000000010000a465	movzbl	(%rcx,%rdx), %ecx
000000010000a469	cmpb	$0x2, %cl
000000010000a46c	setne	%dl
000000010000a46f	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a475	setne	%sil
000000010000a479	orb	%dl, %sil
000000010000a47c	jne	0x10000a487
000000010000a47e	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a485	jmp	0x10000a4a1
000000010000a487	cmpb	$0x1, %cl
000000010000a48a	jne	0x10000a4b0
000000010000a48c	movl	0x20(%rdi), %ecx
000000010000a48f	imulq	%rcx, %rax
000000010000a493	shrq	$0x20, %rax
000000010000a497	addq	%rax, %rdi
000000010000a49a	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a4a1	movzbl	(%rdi), %eax
000000010000a4a4	testb	%al, %al
000000010000a4a6	je	0x10000a4b0
000000010000a4a8	cmpb	$-0x2, %al
000000010000a4aa	jae	0x10000a4b2
000000010000a4ac	incb	%al
000000010000a4ae	movb	%al, (%rdi)
000000010000a4b0	popq	%rbp
000000010000a4b1	retq
000000010000a4b2	popq	%rbp
000000010000a4b3	jmp	_fwp_rc_wide_dup
000000010000a4b8	nopl	(%rax,%rax)
_fwp_arg_drop37:
000000010000a4c0	pushq	%rbp
000000010000a4c1	movq	%rsp, %rbp
000000010000a4c4	testl	%esi, %esi
000000010000a4c6	setne	%al
000000010000a4c9	testl	%edx, %edx
000000010000a4cb	sete	%cl
000000010000a4ce	orb	%al, %cl
000000010000a4d0	je	0x10000a4d4
000000010000a4d2	popq	%rbp
000000010000a4d3	retq
000000010000a4d4	movq	(%rdi), %rdi
000000010000a4d7	popq	%rbp
000000010000a4d8	jmp	_fwp_drop6
000000010000a4dd	nopl	(%rax)
_fwp_segv:
000000010000a4e0	movq	_fwp_main_stack_top(%rip), %rax
000000010000a4e7	testq	%rax, %rax
000000010000a4ea	je	0x10000a514
000000010000a4ec	movq	0x18(%rsi), %rcx
000000010000a4f0	subq	_fwp_main_stack_size(%rip), %rax
000000010000a4f7	leaq	-0x100000(%rax), %rdx
000000010000a4fe	addq	$0x100000, %rax                 ## imm = 0x100000
000000010000a504	cmpq	%rcx, %rdx
000000010000a507	setbe	%dl
000000010000a50a	cmpq	%rcx, %rax
000000010000a50d	seta	%al
000000010000a510	testb	%al, %dl
000000010000a512	jne	0x10000a51b
000000010000a514	xorl	%esi, %esi
000000010000a516	jmp	0x100012118                     ## symbol stub for: _signal
000000010000a51b	pushq	%rbp
000000010000a51c	movq	%rsp, %rbp
000000010000a51f	callq	_fwp_flush
000000010000a524	leaq	_fwp_segv.msg(%rip), %rsi
000000010000a52b	movl	$0x1a, %edx
000000010000a530	movl	$0x2, %edi
000000010000a535	callq	0x10001216c                     ## symbol stub for: _write
000000010000a53a	movl	$0x65, %edi
000000010000a53f	callq	0x100012034                     ## symbol stub for: __exit
000000010000a544	nopw	%cs:(%rax,%rax)
_fwp_str_lossy:
000000010000a550	pushq	%rbp
000000010000a551	movq	%rsp, %rbp
000000010000a554	pushq	%r15
000000010000a556	pushq	%r14
000000010000a558	pushq	%r13
000000010000a55a	pushq	%r12
000000010000a55c	pushq	%rbx
000000010000a55d	subq	$0x28, %rsp
000000010000a561	movq	%rsi, %rbx
000000010000a564	movq	%rdi, %r14
000000010000a567	testq	%rsi, %rsi
000000010000a56a	je	0x10000a6a1
000000010000a570	xorl	%eax, %eax
000000010000a572	jmp	0x10000a58c
000000010000a574	nopw	%cs:(%rax,%rax)
000000010000a580	incq	%rax
000000010000a583	cmpq	%rbx, %rax
000000010000a586	jae	0x10000a6a1
000000010000a58c	movzbl	(%r14,%rax), %edi
000000010000a591	testb	%dil, %dil
000000010000a594	jns	0x10000a580
000000010000a596	leal	0x3e(%rdi), %ecx
000000010000a599	cmpb	$0x1e, %cl
000000010000a59c	jae	0x10000a5af
000000010000a59e	movl	$0x80, %ecx
000000010000a5a3	movl	$0x1, %esi
000000010000a5a8	movl	$0x1f, %edx
000000010000a5ad	jmp	0x10000a5e5
000000010000a5af	movl	%edi, %ecx
000000010000a5b1	andb	$-0x10, %cl
000000010000a5b4	cmpb	$-0x20, %cl
000000010000a5b7	jne	0x10000a5ca
000000010000a5b9	movl	$0x800, %ecx                    ## imm = 0x800
000000010000a5be	movl	$0x2, %esi
000000010000a5c3	movl	$0xf, %edx
000000010000a5c8	jmp	0x10000a5e5
000000010000a5ca	leal	0x10(%rdi), %ecx
000000010000a5cd	cmpb	$0x4, %cl
000000010000a5d0	ja	0x10000a6ba
000000010000a5d6	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000a5db	movl	$0x3, %esi
000000010000a5e0	movl	$0x7, %edx
000000010000a5e5	movl	%esi, %esi
000000010000a5e7	leaq	(%rax,%rsi), %r8
000000010000a5eb	cmpq	%rbx, %r8
000000010000a5ee	jae	0x10000a6ba
000000010000a5f4	movzbl	0x1(%r14,%rax), %r8d
000000010000a5fa	movl	%r8d, %r9d
000000010000a5fd	andl	$-0x40, %r9d
000000010000a601	cmpl	$0x80, %r9d
000000010000a608	jne	0x10000a6ba
000000010000a60e	andl	%edi, %edx
000000010000a610	leal	0x1(%rsi), %r9d
000000010000a614	movl	%edx, %edi
000000010000a616	shll	$0x6, %edi
000000010000a619	andl	$0x3f, %r8d
000000010000a61d	orl	%edi, %r8d
000000010000a620	cmpl	$0x2, %r9d
000000010000a624	jne	0x10000a62b
000000010000a626	movl	%r8d, %r9d
000000010000a629	jmp	0x10000a677
000000010000a62b	movzbl	0x2(%r14,%rax), %edx
000000010000a631	movl	%edx, %edi
000000010000a633	andl	$-0x40, %edi
000000010000a636	cmpl	$0x80, %edi
000000010000a63c	jne	0x10000a6ba
000000010000a63e	movl	%r8d, %edi
000000010000a641	shll	$0x6, %edi
000000010000a644	andl	$0x3f, %edx
000000010000a647	orl	%edi, %edx
000000010000a649	cmpl	$0x3, %r9d
000000010000a64d	jne	0x10000a657
000000010000a64f	movl	%edx, %r9d
000000010000a652	movl	%r8d, %edx
000000010000a655	jmp	0x10000a677
000000010000a657	movzbl	0x3(%r14,%rax), %r9d
000000010000a65d	movl	%r9d, %edi
000000010000a660	andl	$-0x40, %edi
000000010000a663	cmpl	$0x80, %edi
000000010000a669	jne	0x10000a6ba
000000010000a66b	movl	%edx, %edi
000000010000a66d	shll	$0x6, %edi
000000010000a670	andl	$0x3f, %r9d
000000010000a674	orl	%edi, %r9d
000000010000a677	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000a67d	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000a683	je	0x10000a6ba
000000010000a685	cmpl	$0x10ffff, %edi                 ## imm = 0x10FFFF
000000010000a68b	ja	0x10000a6ba
000000010000a68d	cmpl	%ecx, %r9d
000000010000a690	jb	0x10000a6ba
000000010000a692	addq	%rsi, %rax
000000010000a695	incq	%rax
000000010000a698	cmpq	%rbx, %rax
000000010000a69b	jb	0x10000a58c
000000010000a6a1	movq	%r14, %rdi
000000010000a6a4	movq	%rbx, %rsi
000000010000a6a7	addq	$0x28, %rsp
000000010000a6ab	popq	%rbx
000000010000a6ac	popq	%r12
000000010000a6ae	popq	%r13
000000010000a6b0	popq	%r14
000000010000a6b2	popq	%r15
000000010000a6b4	popq	%rbp
000000010000a6b5	jmp	_fwp_str_new
000000010000a6ba	xorps	%xmm0, %xmm0
000000010000a6bd	movaps	%xmm0, -0x50(%rbp)
000000010000a6c1	movq	$0x0, -0x40(%rbp)
000000010000a6c9	xorl	%r13d, %r13d
000000010000a6cc	leaq	-0x50(%rbp), %r15
000000010000a6d0	jmp	0x10000a706
000000010000a6d2	nopw	%cs:(%rax,%rax)
000000010000a6e0	movb	%al, -0x29(%rbp)
000000010000a6e3	movl	$0x1, %edx
000000010000a6e8	movq	%r15, %rdi
000000010000a6eb	leaq	-0x29(%rbp), %rsi
000000010000a6ef	callq	_buf_put
000000010000a6f4	incq	%r13
000000010000a6f7	movq	%r13, %r12
000000010000a6fa	movq	%r12, %r13
000000010000a6fd	cmpq	%rbx, %r12
000000010000a700	jae	0x10000a84d
000000010000a706	movzbl	(%r14,%r13), %eax
000000010000a70b	testb	%al, %al
000000010000a70d	jns	0x10000a6e0
000000010000a70f	leal	0x20(%rax), %ecx
000000010000a712	cmpb	$-0x1f, %cl
000000010000a715	ja	0x10000a74b
000000010000a717	movl	%eax, %edx
000000010000a719	andb	$-0x10, %dl
000000010000a71c	cmpb	$-0x20, %dl
000000010000a71f	jne	0x10000a809
000000010000a725	cmpb	$-0x20, %al
000000010000a727	sete	%sil
000000010000a72b	shlb	$0x5, %sil
000000010000a72f	orb	$-0x80, %sil
000000010000a733	xorl	%edi, %edi
000000010000a735	cmpb	$-0x13, %al
000000010000a737	setne	%dil
000000010000a73b	shll	$0x5, %edi
000000010000a73e	orl	$0x9f, %edi
000000010000a744	movl	$0x2, %eax
000000010000a749	jmp	0x10000a758
000000010000a74b	movl	$0xbf, %edi
000000010000a750	movb	$-0x80, %sil
000000010000a753	movl	$0x1, %eax
000000010000a758	xorl	%edx, %edx
000000010000a75a	leaq	0x1(%r13), %r12
000000010000a75e	cmpq	%rbx, %r12
000000010000a761	jae	0x10000a7f0
000000010000a767	movzbl	(%r14,%r12), %r8d
000000010000a76c	cmpb	%sil, %r8b
000000010000a76f	jb	0x10000a7f0
000000010000a771	cmpl	%r8d, %edi
000000010000a774	jb	0x10000a7f0
000000010000a776	cmpb	$-0x1e, %cl
000000010000a779	setae	%sil
000000010000a77d	leaq	0x2(%r13), %r12
000000010000a781	cmpq	%rbx, %r12
000000010000a784	setae	%dil
000000010000a788	movl	$0x1, %ecx
000000010000a78d	orb	%sil, %dil
000000010000a790	jne	0x10000a7d9
000000010000a792	movzbl	(%r14,%r12), %esi
000000010000a797	andb	$-0x40, %sil
000000010000a79b	negb	%sil
000000010000a79e	jno	0x10000a7d9
000000010000a7a0	leaq	0x3(%r13), %r12
000000010000a7a4	cmpq	%rbx, %r12
000000010000a7a7	setae	%sil
000000010000a7ab	xorb	$0x1, %dl
000000010000a7ae	movl	$0x2, %ecx
000000010000a7b3	orb	%sil, %dl
000000010000a7b6	jne	0x10000a7d9
000000010000a7b8	movzbl	0x3(%r14,%r13), %esi
000000010000a7be	andb	$-0x40, %sil
000000010000a7c2	xorl	%ecx, %ecx
000000010000a7c4	cmpb	$-0x80, %sil
000000010000a7c8	sete	%dl
000000010000a7cb	negb	%sil
000000010000a7ce	jno	0x10000a7d4
000000010000a7d0	leaq	0x4(%r13), %r12
000000010000a7d4	movb	%dl, %cl
000000010000a7d6	orl	$0x2, %ecx
000000010000a7d9	cmpl	%eax, %ecx
000000010000a7db	jne	0x10000a7f0
000000010000a7dd	leaq	(%r14,%r13), %rsi
000000010000a7e1	movq	%r12, %rdx
000000010000a7e4	subq	%r13, %rdx
000000010000a7e7	movq	%r15, %rdi
000000010000a7ea	jmp	0x10000a7ff
000000010000a7ec	nopl	(%rax)
000000010000a7f0	movl	$0x3, %edx
000000010000a7f5	movq	%r15, %rdi
000000010000a7f8	leaq	0x8bf8(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a7ff	callq	_buf_put
000000010000a804	jmp	0x10000a6fa
000000010000a809	leal	0x10(%rax), %edx
000000010000a80c	cmpb	$0x4, %dl
000000010000a80f	ja	0x10000a839
000000010000a811	cmpb	$-0x10, %al
000000010000a813	sete	%sil
000000010000a817	movl	$0x8f, %edi
000000010000a81c	cmpb	$-0xc, %al
000000010000a81e	je	0x10000a825
000000010000a820	movl	$0xbf, %edi
000000010000a825	shlb	$0x4, %sil
000000010000a829	orb	$-0x80, %sil
000000010000a82d	movl	$0x3, %eax
000000010000a832	movb	$0x1, %dl
000000010000a834	jmp	0x10000a75a
000000010000a839	movl	$0x3, %edx
000000010000a83e	movq	%r15, %rdi
000000010000a841	leaq	0x8baf(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a848	jmp	0x10000a6ef
000000010000a84d	movq	-0x50(%rbp), %rbx
000000010000a851	movq	-0x48(%rbp), %rsi
000000010000a855	testq	%rbx, %rbx
000000010000a858	leaq	0x7ee3(%rip), %rdi              ## literal pool for: ""
000000010000a85f	cmovneq	%rbx, %rdi
000000010000a863	callq	_fwp_str_new
000000010000a868	movq	%rax, %r14
000000010000a86b	movq	%rbx, %rdi
000000010000a86e	callq	0x100012082                     ## symbol stub for: _free
000000010000a873	movq	%r14, %rax
000000010000a876	addq	$0x28, %rsp
000000010000a87a	popq	%rbx
000000010000a87b	popq	%r12
000000010000a87d	popq	%r13
000000010000a87f	popq	%r14
000000010000a881	popq	%r15
000000010000a883	popq	%rbp
000000010000a884	retq
000000010000a885	nopw	%cs:(%rax,%rax)
_fwp_alloc_leaf:
000000010000a890	pushq	%rbp
000000010000a891	movq	%rsp, %rbp
000000010000a894	pushq	%rbx
000000010000a895	pushq	%rax
000000010000a896	movq	%rdi, %rsi
000000010000a899	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000a8a0	ja	0x10000a8fb
000000010000a8a2	leaq	0xf(%rsi), %rax
000000010000a8a6	shrq	$0x4, %rax
000000010000a8aa	leaq	_fwp_gc(%rip), %rcx
000000010000a8b1	movzbl	0xbe8(%rax,%rcx), %edx
000000010000a8b9	movl	0xb48(%rcx,%rdx,4), %eax
000000010000a8c0	subq	%rax, _fwp_gc(%rip)
000000010000a8c7	js	0x10000a8fb
000000010000a8c9	leaq	(%rdx,%rdx,2), %rdx
000000010000a8cd	leaq	(%rcx,%rdx,8), %rcx
000000010000a8d1	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000a8d8	movq	(%rcx), %rbx
000000010000a8db	testq	%rbx, %rbx
000000010000a8de	je	0x10000a8eb
000000010000a8e0	movq	(%rbx), %rax
000000010000a8e3	notq	%rax
000000010000a8e6	movq	%rax, (%rcx)
000000010000a8e9	jmp	0x10000a915
000000010000a8eb	movq	0x8(%rcx), %rbx
000000010000a8ef	movq	0x10(%rcx), %rdx
000000010000a8f3	subq	%rbx, %rdx
000000010000a8f6	cmpq	%rax, %rdx
000000010000a8f9	jae	0x10000a90e
000000010000a8fb	movq	%rsi, %rdi
000000010000a8fe	movl	$0x1, %esi
000000010000a903	addq	$0x8, %rsp
000000010000a907	popq	%rbx
000000010000a908	popq	%rbp
000000010000a909	jmp	_fwp_gc_alloc_slow
000000010000a90e	addq	%rbx, %rax
000000010000a911	movq	%rax, 0x8(%rcx)
000000010000a915	movq	%rbx, %rdi
000000010000a918	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000a91d	movq	%rbx, %rax
000000010000a920	addq	$0x8, %rsp
000000010000a924	popq	%rbx
000000010000a925	popq	%rbp
000000010000a926	retq
000000010000a927	nopw	(%rax,%rax)
_fwp_exec_call:
000000010000a930	pushq	%rbp
000000010000a931	movq	%rsp, %rbp
000000010000a934	pushq	%r15
000000010000a936	pushq	%r14
000000010000a938	pushq	%r13
000000010000a93a	pushq	%r12
000000010000a93c	pushq	%rbx
000000010000a93d	subq	$0xd8, %rsp
000000010000a944	movq	%rsi, %rbx
000000010000a947	movq	%rdi, %r14
000000010000a94a	movq	_fwp_handlers(%rip), %rax
000000010000a951	movq	%rax, -0x68(%rbp)
000000010000a955	movq	$0x0, -0x50(%rbp)
000000010000a95d	movq	_fwp_cleanups(%rip), %rax
000000010000a964	movq	%rax, -0x48(%rbp)
000000010000a968	leaq	-0x100(%rbp), %rdi
000000010000a96f	movq	%rdi, _fwp_handlers(%rip)
000000010000a976	callq	0x100012100                     ## symbol stub for: _setjmp
000000010000a97b	testl	%eax, %eax
000000010000a97d	je	0x10000aa6b
000000010000a983	movq	-0x68(%rbp), %rax
000000010000a987	movq	%rax, _fwp_handlers(%rip)
000000010000a98e	movq	_fwp_prog_out(%rip), %rdi
000000010000a995	testq	%rdi, %rdi
000000010000a998	je	0x10000a99f
000000010000a99a	callq	0x10001205e                     ## symbol stub for: _fflush
000000010000a99f	movq	0x96a2(%rip), %r12              ## literal pool symbol address: ___stdoutp
000000010000a9a6	movq	(%r12), %rdi
000000010000a9aa	callq	0x10001205e                     ## symbol stub for: _fflush
000000010000a9af	movq	-0x60(%rbp), %r14
000000010000a9b3	movq	-0x58(%rbp), %r15
000000010000a9b7	movq	(%r12), %rdi
000000010000a9bb	callq	0x10001205e                     ## symbol stub for: _fflush
000000010000a9c0	movq	0x9671(%rip), %r13              ## literal pool symbol address: ___stderrp
000000010000a9c7	movq	(%r13), %rdi
000000010000a9cb	leaq	0x8ade(%rip), %rsi              ## literal pool for: "%s: "
000000010000a9d2	leaq	0x7d6d(%rip), %rdx              ## literal pool for: "reduce64"
000000010000a9d9	xorl	%eax, %eax
000000010000a9db	callq	0x10001206a                     ## symbol stub for: _fprintf
000000010000a9e0	cmpl	$0x10, (%r15)
000000010000a9e4	jne	0x10000aa24
000000010000a9e6	movq	0x8(%r15), %rdi
000000010000a9ea	testq	%rdi, %rdi
000000010000a9ed	je	0x10000aa24
000000010000a9ef	leaq	0x8abf(%rip), %rsi              ## literal pool for: "IoError"
000000010000a9f6	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000a9fb	testl	%eax, %eax
000000010000a9fd	jne	0x10000aa24
000000010000a9ff	cmpl	$0x2, 0x10(%r15)
000000010000aa04	jne	0x10000aa24
000000010000aa06	movq	0x10(%r14), %rdi
000000010000aa0a	movq	(%rdi), %rdx
000000010000aa0d	addq	$0x8, %rdi
000000010000aa11	movq	(%r13), %rcx
000000010000aa15	movl	$0x1, %esi
000000010000aa1a	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000aa1f	jmp	0x10000aab5
000000010000aa24	movq	(%r13), %r12
000000010000aa28	xorps	%xmm0, %xmm0
000000010000aa2b	movaps	%xmm0, -0x40(%rbp)
000000010000aa2f	movq	$0x0, -0x30(%rbp)
000000010000aa37	leaq	-0x40(%rbp), %rdi
000000010000aa3b	movq	%r14, %rsi
000000010000aa3e	movq	%r15, %rdx
000000010000aa41	movl	$0x1, %ecx
000000010000aa46	callq	_fwp_write
000000010000aa4b	movq	-0x40(%rbp), %rdi
000000010000aa4f	testq	%rdi, %rdi
000000010000aa52	je	0x10000aaac
000000010000aa54	movq	-0x38(%rbp), %rdx
000000010000aa58	movl	$0x1, %esi
000000010000aa5d	movq	%r12, %rcx
000000010000aa60	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000aa65	movq	-0x40(%rbp), %rdi
000000010000aa69	jmp	0x10000aab0
000000010000aa6b	leaq	_fwp_gc(%rip), %rax
000000010000aa72	movzbl	0xb178(%rip), %ecx
000000010000aa79	movl	0xb48(%rax,%rcx,4), %edx
000000010000aa80	movl	%edx, %esi
000000010000aa82	subq	%rsi, _fwp_gc(%rip)
000000010000aa89	js	0x10000aadc
000000010000aa8b	leaq	(%rcx,%rcx,2), %rcx
000000010000aa8f	leaq	(%rax,%rcx,8), %rax
000000010000aa93	addq	$0x788, %rax                    ## imm = 0x788
000000010000aa99	movq	(%rax), %r15
000000010000aa9c	testq	%r15, %r15
000000010000aa9f	je	0x10000aacc
000000010000aaa1	movq	(%r15), %rcx
000000010000aaa4	notq	%rcx
000000010000aaa7	movq	%rcx, (%rax)
000000010000aaaa	jmp	0x10000aaf8
000000010000aaac	xorl	%eax, %eax
000000010000aaae	movl	%eax, %edi
000000010000aab0	callq	0x100012082                     ## symbol stub for: _free
000000010000aab5	movq	(%r13), %rsi
000000010000aab9	movl	$0xa, %edi
000000010000aabe	callq	0x100012070                     ## symbol stub for: _fputc
000000010000aac3	movl	$0x1, %ecx
000000010000aac8	xorl	%eax, %eax
000000010000aaca	jmp	0x10000ab24
000000010000aacc	movq	0x8(%rax), %r15
000000010000aad0	movq	0x10(%rax), %rcx
000000010000aad4	subq	%r15, %rcx
000000010000aad7	cmpq	%rsi, %rcx
000000010000aada	jae	0x10000aaf0
000000010000aadc	movl	$0x8, %edi
000000010000aae1	movl	$0x2, %esi
000000010000aae6	callq	_fwp_gc_alloc_slow
000000010000aaeb	movq	%rax, %rdi
000000010000aaee	jmp	0x10000ab03
000000010000aaf0	leaq	(%r15,%rsi), %rcx
000000010000aaf4	movq	%rcx, 0x8(%rax)
000000010000aaf8	movq	%r15, %rdi
000000010000aafb	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000ab00	movq	%r15, %rdi
000000010000ab03	movq	$0x0, (%rdi)
000000010000ab0a	movl	$0x1, %esi
000000010000ab0f	movq	%r14, %rdx
000000010000ab12	callq	_fwp_apply
000000010000ab17	movq	-0x68(%rbp), %rcx
000000010000ab1b	movq	%rcx, _fwp_handlers(%rip)
000000010000ab22	xorl	%ecx, %ecx
000000010000ab24	movl	%ecx, (%rbx)
000000010000ab26	addq	$0xd8, %rsp
000000010000ab2d	popq	%rbx
000000010000ab2e	popq	%r12
000000010000ab30	popq	%r13
000000010000ab32	popq	%r14
000000010000ab34	popq	%r15
000000010000ab36	popq	%rbp
000000010000ab37	retq
000000010000ab38	nopl	(%rax,%rax)
_fwp_emit_result:
000000010000ab40	pushq	%rbp
000000010000ab41	movq	%rsp, %rbp
000000010000ab44	pushq	%r14
000000010000ab46	pushq	%rbx
000000010000ab47	subq	$0x20, %rsp
000000010000ab4b	movq	%rdi, %rsi
000000010000ab4e	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000ab55	je	0x10000abc2
000000010000ab57	xorps	%xmm0, %xmm0
000000010000ab5a	movaps	%xmm0, -0x30(%rbp)
000000010000ab5e	movq	$0x0, -0x20(%rbp)
000000010000ab66	leaq	_d0(%rip), %rdx
000000010000ab6d	leaq	-0x30(%rbp), %rdi
000000010000ab71	callq	_fwp_encode
000000010000ab76	movb	$0x1, -0x15(%rbp)
000000010000ab7a	movl	-0x28(%rbp), %eax
000000010000ab7d	movl	%eax, -0x14(%rbp)
000000010000ab80	movq	0x94c1(%rip), %rbx              ## literal pool symbol address: ___stdoutp
000000010000ab87	movq	(%rbx), %rcx
000000010000ab8a	leaq	-0x15(%rbp), %rdi
000000010000ab8e	movl	$0x1, %esi
000000010000ab93	movl	$0x5, %edx
000000010000ab98	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000ab9d	movq	-0x28(%rbp), %rdx
000000010000aba1	testq	%rdx, %rdx
000000010000aba4	je	0x10000abb7
000000010000aba6	movq	-0x30(%rbp), %rdi
000000010000abaa	movq	(%rbx), %rcx
000000010000abad	movl	$0x1, %esi
000000010000abb2	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000abb7	movq	-0x30(%rbp), %rdi
000000010000abbb	callq	0x100012082                     ## symbol stub for: _free
000000010000abc0	jmp	0x10000ac40
000000010000abc2	cmpl	$0x10, _d0(%rip)
000000010000abc9	jne	0x10000abde
000000010000abcb	cmpl	$0x0, 0xbf2e(%rip)
000000010000abd2	jne	0x10000abde
000000010000abd4	cmpq	$0x0, 0xbf1c(%rip)
000000010000abdc	je	0x10000ac40
000000010000abde	movq	0x9463(%rip), %r14              ## literal pool symbol address: ___stdoutp
000000010000abe5	movq	(%r14), %rbx
000000010000abe8	xorps	%xmm0, %xmm0
000000010000abeb	movaps	%xmm0, -0x30(%rbp)
000000010000abef	movq	$0x0, -0x20(%rbp)
000000010000abf7	leaq	_d0(%rip), %rdx
000000010000abfe	leaq	-0x30(%rbp), %rdi
000000010000ac02	movl	$0x1, %ecx
000000010000ac07	callq	_fwp_write
000000010000ac0c	movq	-0x30(%rbp), %rdi
000000010000ac10	testq	%rdi, %rdi
000000010000ac13	je	0x10000ac2c
000000010000ac15	movq	-0x28(%rbp), %rdx
000000010000ac19	movl	$0x1, %esi
000000010000ac1e	movq	%rbx, %rcx
000000010000ac21	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000ac26	movq	-0x30(%rbp), %rdi
000000010000ac2a	jmp	0x10000ac2e
000000010000ac2c	xorl	%edi, %edi
000000010000ac2e	callq	0x100012082                     ## symbol stub for: _free
000000010000ac33	movq	(%r14), %rsi
000000010000ac36	movl	$0xa, %edi
000000010000ac3b	callq	0x100012070                     ## symbol stub for: _fputc
000000010000ac40	addq	$0x20, %rsp
000000010000ac44	popq	%rbx
000000010000ac45	popq	%r14
000000010000ac47	popq	%rbp
000000010000ac48	retq
000000010000ac49	nopl	(%rax)
_fwp_read_exact:
000000010000ac50	pushq	%rbp
000000010000ac51	movq	%rsp, %rbp
000000010000ac54	pushq	%r15
000000010000ac56	pushq	%r14
000000010000ac58	pushq	%r12
000000010000ac5a	pushq	%rbx
000000010000ac5b	movq	%rsi, %rbx
000000010000ac5e	movq	%rdi, %r14
000000010000ac61	movl	_fwp_in_npend(%rip), %eax
000000010000ac67	movl	_fwp_in_ppos(%rip), %ecx
000000010000ac6d	testq	%rsi, %rsi
000000010000ac70	setne	%dl
000000010000ac73	cmpl	%eax, %ecx
000000010000ac75	setl	%sil
000000010000ac79	testb	%sil, %dl
000000010000ac7c	je	0x10000acea
000000010000ac7e	cltq
000000010000ac80	movslq	%ecx, %rsi
000000010000ac83	movq	%rsi, %rdx
000000010000ac86	notq	%rdx
000000010000ac89	addq	%rax, %rdx
000000010000ac8c	leaq	-0x1(%rbx), %rcx
000000010000ac90	cmpq	%rcx, %rdx
000000010000ac93	cmovaeq	%rcx, %rdx
000000010000ac97	incq	%rdx
000000010000ac9a	cmpq	$0x1f, %rdx
000000010000ac9e	jbe	0x10000acb6
000000010000aca0	leaq	_fwp_in_pend(%rip), %rdi
000000010000aca7	movq	%r14, %r8
000000010000acaa	subq	%rsi, %r8
000000010000acad	subq	%rdi, %r8
000000010000acb0	cmpq	$0x20, %r8
000000010000acb4	jae	0x10000acef
000000010000acb6	xorl	%r15d, %r15d
000000010000acb9	movq	%rsi, %rcx
000000010000acbc	leaq	_fwp_in_pend(%rip), %rdx
000000010000acc3	nopw	%cs:(%rax,%rax)
000000010000acd0	movzbl	(%rcx,%rdx), %esi
000000010000acd4	incq	%rcx
000000010000acd7	movb	%sil, (%r14,%r15)
000000010000acdb	incq	%r15
000000010000acde	cmpq	%rbx, %r15
000000010000ace1	jae	0x10000ad32
000000010000ace3	cmpq	%rax, %rcx
000000010000ace6	jl	0x10000acd0
000000010000ace8	jmp	0x10000ad32
000000010000acea	xorl	%r15d, %r15d
000000010000aced	jmp	0x10000ad38
000000010000acef	movq	%rdx, %r15
000000010000acf2	andq	$-0x20, %r15
000000010000acf6	leaq	(%r15,%rsi), %rcx
000000010000acfa	addq	%rdi, %rsi
000000010000acfd	addq	$0x10, %rsi
000000010000ad01	xorl	%edi, %edi
000000010000ad03	nopw	%cs:(%rax,%rax)
000000010000ad10	movups	-0x10(%rsi,%rdi), %xmm0
000000010000ad15	movups	(%rsi,%rdi), %xmm1
000000010000ad19	movups	%xmm0, (%r14,%rdi)
000000010000ad1e	movups	%xmm1, 0x10(%r14,%rdi)
000000010000ad24	addq	$0x20, %rdi
000000010000ad28	cmpq	%rdi, %r15
000000010000ad2b	jne	0x10000ad10
000000010000ad2d	cmpq	%r15, %rdx
000000010000ad30	jne	0x10000acbc
000000010000ad32	movl	%ecx, _fwp_in_ppos(%rip)
000000010000ad38	movq	0x9301(%rip), %r12              ## literal pool symbol address: ___stdinp
000000010000ad3f	nop
000000010000ad40	movq	%rbx, %rdx
000000010000ad43	subq	%r15, %rdx
000000010000ad46	jbe	0x10000ad66
000000010000ad48	leaq	(%r14,%r15), %rdi
000000010000ad4c	movq	(%r12), %rcx
000000010000ad50	movl	$0x1, %esi
000000010000ad55	callq	0x10001207c                     ## symbol stub for: _fread
000000010000ad5a	addq	%rax, %r15
000000010000ad5d	testq	%rax, %rax
000000010000ad60	jne	0x10000ad40
000000010000ad62	xorl	%eax, %eax
000000010000ad64	jmp	0x10000ad6b
000000010000ad66	movl	$0x1, %eax
000000010000ad6b	popq	%rbx
000000010000ad6c	popq	%r12
000000010000ad6e	popq	%r14
000000010000ad70	popq	%r15
000000010000ad72	popq	%rbp
000000010000ad73	retq
000000010000ad74	nopw	%cs:(%rax,%rax)
_fwp_stdin_leb:
000000010000ad80	pushq	%rbp
000000010000ad81	movq	%rsp, %rbp
000000010000ad84	pushq	%r15
000000010000ad86	pushq	%r14
000000010000ad88	pushq	%r13
000000010000ad8a	pushq	%r12
000000010000ad8c	pushq	%rbx
000000010000ad8d	pushq	%rax
000000010000ad8e	movq	%rdi, %rbx
000000010000ad91	movq	$0x0, (%rdi)
000000010000ad98	movq	$-0x7, %r14
000000010000ad9f	leaq	_fwp_in_pend(%rip), %r12
000000010000ada6	movq	0x9293(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000adad	leaq	-0x29(%rbp), %r15
000000010000adb1	nopw	%cs:(%rax,%rax)
000000010000adc0	movslq	_fwp_in_ppos(%rip), %rax
000000010000adc7	cmpl	_fwp_in_npend(%rip), %eax
000000010000adcd	jge	0x10000adf0
000000010000adcf	leal	0x1(%rax), %ecx
000000010000add2	movzbl	(%rax,%r12), %eax
000000010000add7	movb	%al, -0x29(%rbp)
000000010000adda	movl	%ecx, _fwp_in_ppos(%rip)
000000010000ade0	jmp	0x10000ae0b
000000010000ade2	nopw	%cs:(%rax,%rax)
000000010000adf0	movq	(%r13), %rcx
000000010000adf4	movl	$0x1, %esi
000000010000adf9	movl	$0x1, %edx
000000010000adfe	movq	%r15, %rdi
000000010000ae01	callq	0x10001207c                     ## symbol stub for: _fread
000000010000ae06	testq	%rax, %rax
000000010000ae09	je	0x10000ae4c
000000010000ae0b	cmpq	$0x38, %r14
000000010000ae0f	setne	%cl
000000010000ae12	movzbl	-0x29(%rbp), %eax
000000010000ae16	testb	$0x7e, %al
000000010000ae18	sete	%dl
000000010000ae1b	orb	%cl, %dl
000000010000ae1d	je	0x10000ae3e
000000010000ae1f	addq	$0x7, %r14
000000010000ae23	movzbl	%al, %eax
000000010000ae26	movl	%eax, %edx
000000010000ae28	andl	$0x7f, %edx
000000010000ae2b	movl	%r14d, %ecx
000000010000ae2e	shlq	%cl, %rdx
000000010000ae31	orq	%rdx, (%rbx)
000000010000ae34	testb	%al, %al
000000010000ae36	jns	0x10000ae45
000000010000ae38	cmpq	$0x38, %r14
000000010000ae3c	jbe	0x10000adc0
000000010000ae3e	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ae43	jmp	0x10000ae4e
000000010000ae45	movl	$0x1, %eax
000000010000ae4a	jmp	0x10000ae4e
000000010000ae4c	xorl	%eax, %eax
000000010000ae4e	addq	$0x8, %rsp
000000010000ae52	popq	%rbx
000000010000ae53	popq	%r12
000000010000ae55	popq	%r13
000000010000ae57	popq	%r14
000000010000ae59	popq	%r15
000000010000ae5b	popq	%rbp
000000010000ae5c	retq
000000010000ae5d	nopl	(%rax)
_fwp_stdin_name_len:
000000010000ae60	pushq	%rbp
000000010000ae61	movq	%rsp, %rbp
000000010000ae64	pushq	%r15
000000010000ae66	pushq	%r14
000000010000ae68	pushq	%r13
000000010000ae6a	pushq	%r12
000000010000ae6c	pushq	%rbx
000000010000ae6d	pushq	%rax
000000010000ae6e	movq	%rdi, %rbx
000000010000ae71	movq	$0x0, (%rdi)
000000010000ae78	movq	$-0x7, %r14
000000010000ae7f	leaq	_fwp_in_pend(%rip), %r12
000000010000ae86	movq	0x91b3(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000ae8d	leaq	-0x29(%rbp), %r15
000000010000ae91	nopw	%cs:(%rax,%rax)
000000010000aea0	movslq	_fwp_in_ppos(%rip), %rax
000000010000aea7	cmpl	_fwp_in_npend(%rip), %eax
000000010000aead	jge	0x10000aed0
000000010000aeaf	leal	0x1(%rax), %ecx
000000010000aeb2	movzbl	(%rax,%r12), %eax
000000010000aeb7	movb	%al, -0x29(%rbp)
000000010000aeba	movl	%ecx, _fwp_in_ppos(%rip)
000000010000aec0	jmp	0x10000aeeb
000000010000aec2	nopw	%cs:(%rax,%rax)
000000010000aed0	movq	(%r13), %rcx
000000010000aed4	movl	$0x1, %esi
000000010000aed9	movl	$0x1, %edx
000000010000aede	movq	%r15, %rdi
000000010000aee1	callq	0x10001207c                     ## symbol stub for: _fread
000000010000aee6	testq	%rax, %rax
000000010000aee9	je	0x10000af41
000000010000aeeb	cmpq	$0x38, %r14
000000010000aeef	setne	%cl
000000010000aef2	movzbl	-0x29(%rbp), %eax
000000010000aef6	testb	$0x7e, %al
000000010000aef8	sete	%dl
000000010000aefb	orb	%cl, %dl
000000010000aefd	je	0x10000af25
000000010000aeff	addq	$0x7, %r14
000000010000af03	movzbl	%al, %eax
000000010000af06	movl	%eax, %edx
000000010000af08	andl	$0x7f, %edx
000000010000af0b	movl	%r14d, %ecx
000000010000af0e	shlq	%cl, %rdx
000000010000af11	orq	(%rbx), %rdx
000000010000af14	movq	%rdx, (%rbx)
000000010000af17	testb	%al, %al
000000010000af19	jns	0x10000af2c
000000010000af1b	cmpq	$0x38, %r14
000000010000af1f	jbe	0x10000aea0
000000010000af25	movl	$0xffffffff, %ecx               ## imm = 0xFFFFFFFF
000000010000af2a	jmp	0x10000af43
000000010000af2c	movl	$0x1, %ecx
000000010000af31	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000af36	cmpq	$0x100000, %rdx                 ## imm = 0x100000
000000010000af3d	jbe	0x10000af43
000000010000af3f	jmp	0x10000af45
000000010000af41	xorl	%ecx, %ecx
000000010000af43	movl	%ecx, %eax
000000010000af45	addq	$0x8, %rsp
000000010000af49	popq	%rbx
000000010000af4a	popq	%r12
000000010000af4c	popq	%r13
000000010000af4e	popq	%r14
000000010000af50	popq	%r15
000000010000af52	popq	%rbp
000000010000af53	retq
000000010000af54	nopw	%cs:(%rax,%rax)
_fwp_decode:
000000010000af60	pushq	%rbp
000000010000af61	movq	%rsp, %rbp
000000010000af64	pushq	%r15
000000010000af66	pushq	%r14
000000010000af68	pushq	%r13
000000010000af6a	pushq	%r12
000000010000af6c	pushq	%rbx
000000010000af6d	subq	$0x48, %rsp
000000010000af71	movq	0x90b8(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000af78	movq	(%rax), %rax
000000010000af7b	movq	%rax, -0x30(%rbp)
000000010000af7f	movl	(%rsi), %eax
000000010000af81	xorl	%r8d, %r8d
000000010000af84	cmpq	$0x15, %rax
000000010000af88	ja	0x10000b507
000000010000af8e	movq	%rdx, %r9
000000010000af91	movq	%rsi, %r15
000000010000af94	movq	%rdi, %r14
000000010000af97	leaq	0x84e(%rip), %rcx
000000010000af9e	movslq	(%rcx,%rax,4), %rdx
000000010000afa2	addq	%rcx, %rdx
000000010000afa5	jmpq	*%rdx
000000010000afa7	xorl	%ecx, %ecx
000000010000afa9	cmpl	$0xa, %eax
000000010000afac	setne	%cl
000000010000afaf	leaq	0x4(,%rcx,4), %rax
000000010000afb7	movq	0x8(%r14), %rdx
000000010000afbb	movq	0x10(%r14), %rcx
000000010000afbf	subq	%rcx, %rdx
000000010000afc2	cmpq	%rax, %rdx
000000010000afc5	jb	0x10000b507
000000010000afcb	movq	(%r14), %rdx
000000010000afce	addq	%rcx, %rdx
000000010000afd1	addq	%rax, %rcx
000000010000afd4	movq	%rcx, 0x10(%r14)
000000010000afd8	cmpq	$0x8, %rax
000000010000afdc	jae	0x10000afe4
000000010000afde	xorl	%esi, %esi
000000010000afe0	xorl	%edi, %edi
000000010000afe2	jmp	0x10000b049
000000010000afe4	movl	%eax, %esi
000000010000afe6	andl	$-0x8, %esi
000000010000afe9	pmovzxbq	0x2(%rdx), %xmm0
000000010000afef	pmovzxbq	0x6(%rdx), %xmm1
000000010000aff5	pmovzxbq	0x4(%rdx), %xmm2
000000010000affb	pmovzxbq	(%rdx), %xmm3
000000010000b000	movdqa	%xmm3, %xmm4
000000010000b004	psllq	$0x8, %xmm4
000000010000b009	pshufb	0x723e(%rip), %xmm2
000000010000b012	pblendw	$0xf, %xmm3, %xmm4              ## xmm4 = xmm3[0,1,2,3],xmm4[4,5,6,7]
000000010000b018	por	%xmm4, %xmm2
000000010000b01c	pshufb	0x723b(%rip), %xmm1
000000010000b025	pshufb	0x7242(%rip), %xmm0
000000010000b02e	por	%xmm1, %xmm0
000000010000b032	por	%xmm2, %xmm0
000000010000b036	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000b03b	por	%xmm0, %xmm1
000000010000b03f	movq	%xmm1, %rdi
000000010000b044	cmpq	%rsi, %rax
000000010000b047	je	0x10000b067
000000010000b049	leal	(,%rsi,8), %ecx
000000010000b050	movzbl	(%rdx,%rsi), %r8d
000000010000b055	shlq	%cl, %r8
000000010000b058	orq	%r8, %rdi
000000010000b05b	incq	%rsi
000000010000b05e	addq	$0x8, %rcx
000000010000b062	cmpq	%rsi, %rax
000000010000b065	jne	0x10000b050
000000010000b067	movq	%rdi, (%r9)
000000010000b06a	movl	$0x1, %r8d
000000010000b070	jmp	0x10000b507
000000010000b075	movq	%r9, %r12
000000010000b078	leaq	-0x58(%rbp), %rsi
000000010000b07c	movq	%r14, %rdi
000000010000b07f	callq	_rd_leb
000000010000b084	testl	%eax, %eax
000000010000b086	je	0x10000b504
000000010000b08c	movq	-0x58(%rbp), %rbx
000000010000b090	movq	0x8(%r14), %rcx
000000010000b094	cmpq	%rcx, %rbx
000000010000b097	movl	$0x0, %r8d
000000010000b09d	ja	0x10000b507
000000010000b0a3	movq	0x10(%r14), %rax
000000010000b0a7	subq	%rax, %rcx
000000010000b0aa	cmpq	%rbx, %rcx
000000010000b0ad	jb	0x10000b507
000000010000b0b3	movq	(%r14), %r13
000000010000b0b6	addq	%rax, %r13
000000010000b0b9	addq	%rbx, %rax
000000010000b0bc	movq	%rax, 0x10(%r14)
000000010000b0c0	cmpl	$0xc, (%r15)
000000010000b0c4	movq	%r12, %rcx
000000010000b0c7	jne	0x10000b0e2
000000010000b0c9	movq	%r13, %rdi
000000010000b0cc	movq	%rbx, %rsi
000000010000b0cf	callq	_fwp_valid_utf8
000000010000b0d4	xorl	%r8d, %r8d
000000010000b0d7	movq	%r12, %rcx
000000010000b0da	testl	%eax, %eax
000000010000b0dc	je	0x10000b507
000000010000b0e2	movq	%r13, %rdi
000000010000b0e5	movq	%rbx, %rsi
000000010000b0e8	movq	%rcx, %rbx
000000010000b0eb	callq	_fwp_str_new
000000010000b0f0	movq	%rax, (%rbx)
000000010000b0f3	jmp	0x10000b06a
000000010000b0f8	movq	0x10(%r14), %rax
000000010000b0fc	cmpq	%rax, 0x8(%r14)
000000010000b100	je	0x10000b507
000000010000b106	movq	(%r14), %rcx
000000010000b109	leaq	0x1(%rax), %rdx
000000010000b10d	movq	%rdx, 0x10(%r14)
000000010000b111	movsbq	(%rcx,%rax), %rax
000000010000b116	movq	%rax, (%r9)
000000010000b119	jmp	0x10000b06a
000000010000b11e	movq	0x8(%r14), %rsi
000000010000b122	movq	0x10(%r14), %rcx
000000010000b126	movq	%rsi, %rdx
000000010000b129	subq	%rcx, %rdx
000000010000b12c	cmpq	$0x8, %rdx
000000010000b130	jb	0x10000b507
000000010000b136	movq	(%r14), %rdx
000000010000b139	leaq	0x8(%rcx), %rdi
000000010000b13d	movq	%rdi, 0x10(%r14)
000000010000b141	subq	%rdi, %rsi
000000010000b144	cmpq	$0x8, %rsi
000000010000b148	jb	0x10000b507
000000010000b14e	movq	%r9, %rbx
000000010000b151	movq	(%rdx,%rcx), %rdi
000000010000b155	leaq	0x10(%rcx), %rsi
000000010000b159	movq	%rsi, 0x10(%r14)
000000010000b15d	movq	0x8(%rdx,%rcx), %rsi
000000010000b162	cmpl	$0x4, %eax
000000010000b165	jne	0x10000b4ed
000000010000b16b	callq	_fwp_box_i128
000000010000b170	movq	%rax, (%rbx)
000000010000b173	jmp	0x10000b06a
000000010000b178	movq	%r9, -0x50(%rbp)
000000010000b17c	movq	0x38(%r15), %rbx
000000010000b180	leaq	-0x58(%rbp), %rsi
000000010000b184	movq	%r14, %rdi
000000010000b187	callq	_rd_leb
000000010000b18c	testl	%eax, %eax
000000010000b18e	je	0x10000b504
000000010000b194	movq	-0x58(%rbp), %r12
000000010000b198	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000b1a2	cmpq	%rax, %r12
000000010000b1a5	movl	$0x0, %r8d
000000010000b1ab	ja	0x10000b507
000000010000b1b1	movq	%rbx, %rdi
000000010000b1b4	xorl	%esi, %esi
000000010000b1b6	callq	_fwp_wire_empty_inner
000000010000b1bb	xorl	%r8d, %r8d
000000010000b1be	testl	%eax, %eax
000000010000b1c0	jne	0x10000b1cc
000000010000b1c2	cmpq	0x8(%r14), %r12
000000010000b1c6	ja	0x10000b507
000000010000b1cc	cmpl	$0x11, (%r15)
000000010000b1d0	jne	0x10000b484
000000010000b1d6	movq	0x38(%r15), %rsi
000000010000b1da	movq	%r12, %rdi
000000010000b1dd	callq	_fwp_array_new_packed
000000010000b1e2	movq	%rax, %r13
000000010000b1e5	testq	%r12, %r12
000000010000b1e8	je	0x10000b21f
000000010000b1ea	xorl	%ebx, %ebx
000000010000b1ec	movq	0x38(%r15), %rsi
000000010000b1f0	movq	%r14, %rdi
000000010000b1f3	leaq	-0x40(%rbp), %rdx
000000010000b1f7	callq	_fwp_decode
000000010000b1fc	testl	%eax, %eax
000000010000b1fe	je	0x10000b504
000000010000b204	movq	-0x40(%rbp), %rdx
000000010000b208	movq	0x38(%r15), %rcx
000000010000b20c	movq	%r13, %rdi
000000010000b20f	movq	%rbx, %rsi
000000010000b212	callq	_fwp_array_store
000000010000b217	incq	%rbx
000000010000b21a	cmpq	%rbx, %r12
000000010000b21d	jne	0x10000b1ec
000000010000b21f	movq	-0x50(%rbp), %rax
000000010000b223	movq	%r13, (%rax)
000000010000b226	jmp	0x10000b06a
000000010000b22b	movq	%r9, -0x50(%rbp)
000000010000b22f	leaq	-0x58(%rbp), %rsi
000000010000b233	movq	%r14, %rdi
000000010000b236	callq	_rd_leb
000000010000b23b	testl	%eax, %eax
000000010000b23d	je	0x10000b504
000000010000b243	movq	-0x58(%rbp), %r13
000000010000b247	movslq	0x10(%r15), %rax
000000010000b24b	cmpq	%rax, %r13
000000010000b24e	movl	$0x0, %r8d
000000010000b254	jae	0x10000b507
000000010000b25a	movq	0x28(%r15), %rax
000000010000b25e	movslq	(%rax,%r13,4), %rbx
000000010000b262	leaq	0x8(,%rbx,8), %rdi
000000010000b26a	callq	_fwp_alloc
000000010000b26f	movq	%rax, -0x48(%rbp)
000000010000b273	movq	%rbx, -0x60(%rbp)
000000010000b277	testq	%rbx, %rbx
000000010000b27a	jle	0x10000b2b8
000000010000b27c	movq	-0x60(%rbp), %rax
000000010000b280	leaq	(,%rax,8), %rbx
000000010000b288	xorl	%r12d, %r12d
000000010000b28b	movq	0x30(%r15), %rax
000000010000b28f	movq	(%rax,%r13,8), %rax
000000010000b293	movq	(%rax,%r12), %rsi
000000010000b297	movq	-0x48(%rbp), %rax
000000010000b29b	leaq	(%rax,%r12), %rdx
000000010000b29f	movq	%r14, %rdi
000000010000b2a2	callq	_fwp_decode
000000010000b2a7	testl	%eax, %eax
000000010000b2a9	je	0x10000b504
000000010000b2af	addq	$0x8, %r12
000000010000b2b3	cmpq	%r12, %rbx
000000010000b2b6	jne	0x10000b28b
000000010000b2b8	movl	%r13d, %edi
000000010000b2bb	movq	-0x60(%rbp), %rsi
000000010000b2bf	movq	-0x48(%rbp), %rdx
000000010000b2c3	callq	_fwp_data
000000010000b2c8	jmp	0x10000b7d8
000000010000b2cd	movl	$0x1, %eax
000000010000b2d2	jmp	0x10000afb7
000000010000b2d7	movl	$0x2, %eax
000000010000b2dc	jmp	0x10000afb7
000000010000b2e1	movq	0x8(%r14), %rcx
000000010000b2e5	movq	0x10(%r14), %rax
000000010000b2e9	subq	%rax, %rcx
000000010000b2ec	cmpq	$0x2, %rcx
000000010000b2f0	jb	0x10000b507
000000010000b2f6	movq	(%r14), %rcx
000000010000b2f9	leaq	0x2(%rax), %rdx
000000010000b2fd	movq	%rdx, 0x10(%r14)
000000010000b301	movzbl	(%rcx,%rax), %edx
000000010000b305	movzbl	0x1(%rcx,%rax), %eax
000000010000b30a	shlq	$0x38, %rax
000000010000b30e	shlq	$0x30, %rdx
000000010000b312	orq	%rax, %rdx
000000010000b315	sarq	$0x30, %rdx
000000010000b319	movq	%rdx, (%r9)
000000010000b31c	jmp	0x10000b06a
000000010000b321	movq	0x8(%r14), %rcx
000000010000b325	movq	0x10(%r14), %rax
000000010000b329	subq	%rax, %rcx
000000010000b32c	cmpq	$0x4, %rcx
000000010000b330	jb	0x10000b507
000000010000b336	movq	(%r14), %rcx
000000010000b339	leaq	0x4(%rax), %rdx
000000010000b33d	movq	%rdx, 0x10(%r14)
000000010000b341	movzbl	(%rcx,%rax), %edx
000000010000b345	movzbl	0x1(%rcx,%rax), %esi
000000010000b34a	movzbl	0x2(%rcx,%rax), %edi
000000010000b34f	movzbl	0x3(%rcx,%rax), %eax
000000010000b354	shlq	$0x38, %rax
000000010000b358	shlq	$0x30, %rdi
000000010000b35c	shlq	$0x28, %rsi
000000010000b360	shlq	$0x20, %rdx
000000010000b364	orq	%rsi, %rdx
000000010000b367	orq	%rdi, %rdx
000000010000b36a	orq	%rax, %rdx
000000010000b36d	sarq	$0x20, %rdx
000000010000b371	movq	%rdx, (%r9)
000000010000b374	jmp	0x10000b06a
000000010000b379	movl	$0x4, %eax
000000010000b37e	jmp	0x10000afb7
000000010000b383	movq	%r9, %r12
000000010000b386	movq	0x40(%r15), %rdi
000000010000b38a	xorl	%esi, %esi
000000010000b38c	callq	_fwp_wire_empty_inner
000000010000b391	testl	%eax, %eax
000000010000b393	setne	%r13b
000000010000b397	jmp	0x10000b39f
000000010000b399	movq	%r9, %r12
000000010000b39c	movb	$0x1, %r13b
000000010000b39f	movq	0x38(%r15), %rbx
000000010000b3a3	leaq	-0x58(%rbp), %rsi
000000010000b3a7	movq	%r14, %rdi
000000010000b3aa	callq	_rd_leb
000000010000b3af	testl	%eax, %eax
000000010000b3b1	je	0x10000b504
000000010000b3b7	movb	%r13b, -0x48(%rbp)
000000010000b3bb	movq	-0x58(%rbp), %r13
000000010000b3bf	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000b3c9	cmpq	%rax, %r13
000000010000b3cc	movl	$0x0, %r8d
000000010000b3d2	ja	0x10000b507
000000010000b3d8	movq	%r12, -0x50(%rbp)
000000010000b3dc	movq	%rbx, %rdi
000000010000b3df	xorl	%esi, %esi
000000010000b3e1	callq	_fwp_wire_empty_inner
000000010000b3e6	testl	%eax, %eax
000000010000b3e8	je	0x10000b4fa
000000010000b3ee	cmpq	$0x2, %r13
000000010000b3f2	setae	%al
000000010000b3f5	movzbl	-0x48(%rbp), %ecx
000000010000b3f9	testb	%cl, %al
000000010000b3fb	je	0x10000b52d
000000010000b401	jmp	0x10000b504
000000010000b406	movslq	0x10(%r15), %rdi
000000010000b40a	testq	%rdi, %rdi
000000010000b40d	je	0x10000b478
000000010000b40f	shlq	$0x3, %rdi
000000010000b413	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000b41a	movq	%r9, -0x50(%rbp)
000000010000b41e	ja	0x10000b5b8
000000010000b424	leaq	0xf(%rdi), %rcx
000000010000b428	shrq	$0x4, %rcx
000000010000b42c	leaq	_fwp_gc(%rip), %rax
000000010000b433	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000b43b	movl	0xb48(%rax,%rcx,4), %esi
000000010000b442	subq	%rsi, _fwp_gc(%rip)
000000010000b449	js	0x10000b5b8
000000010000b44f	leaq	(%rcx,%rcx,2), %rcx
000000010000b453	leaq	(%rax,%rcx,8), %rax
000000010000b457	addq	$0x788, %rax                    ## imm = 0x788
000000010000b45d	movq	(%rax), %r12
000000010000b460	testq	%r12, %r12
000000010000b463	je	0x10000b5a8
000000010000b469	movq	(%r12), %rcx
000000010000b46d	notq	%rcx
000000010000b470	movq	%rcx, (%rax)
000000010000b473	jmp	0x10000b5db
000000010000b478	movq	$0x0, (%r9)
000000010000b47f	jmp	0x10000b06a
000000010000b484	cmpq	$0x7ff, %r12                    ## imm = 0x7FF
000000010000b48b	ja	0x10000b699
000000010000b491	leaq	(,%r12,8), %rcx
000000010000b499	addq	$0x17, %rcx
000000010000b49d	shrq	$0x4, %rcx
000000010000b4a1	leaq	_fwp_gc(%rip), %rax
000000010000b4a8	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000b4b0	movl	0xb48(%rax,%rcx,4), %esi
000000010000b4b7	subq	%rsi, _fwp_gc(%rip)
000000010000b4be	js	0x10000b699
000000010000b4c4	leaq	(%rcx,%rcx,2), %rcx
000000010000b4c8	leaq	(%rax,%rcx,8), %rax
000000010000b4cc	addq	$0x788, %rax                    ## imm = 0x788
000000010000b4d2	movq	(%rax), %r13
000000010000b4d5	testq	%r13, %r13
000000010000b4d8	je	0x10000b685
000000010000b4de	movq	(%r13), %rcx
000000010000b4e2	notq	%rcx
000000010000b4e5	movq	%rcx, (%rax)
000000010000b4e8	jmp	0x10000b75a
000000010000b4ed	callq	_fwp_box_i128
000000010000b4f2	movq	%rax, (%rbx)
000000010000b4f5	jmp	0x10000b06a
000000010000b4fa	cmpq	0x8(%r14), %r13
000000010000b4fe	movzbl	-0x48(%rbp), %ecx
000000010000b502	jbe	0x10000b52d
000000010000b504	xorl	%r8d, %r8d
000000010000b507	movq	0x8b22(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b50e	movq	(%rax), %rax
000000010000b511	cmpq	-0x30(%rbp), %rax
000000010000b515	jne	0x10000b7e4
000000010000b51b	movl	%r8d, %eax
000000010000b51e	addq	$0x48, %rsp
000000010000b522	popq	%rbx
000000010000b523	popq	%r12
000000010000b525	popq	%r13
000000010000b527	popq	%r14
000000010000b529	popq	%r15
000000010000b52b	popq	%rbp
000000010000b52c	retq
000000010000b52d	testb	%cl, %cl
000000010000b52f	movl	$0x0, %r8d
000000010000b535	jne	0x10000b53d
000000010000b537	cmpq	0x8(%r14), %r13
000000010000b53b	ja	0x10000b507
000000010000b53d	leaq	_fwp_empty_map(%rip), %r12
000000010000b544	testq	%r13, %r13
000000010000b547	je	0x10000b5c7
000000010000b549	leaq	-0x40(%rbp), %rbx
000000010000b54d	jmp	0x10000b569
000000010000b54f	xorl	%esi, %esi
000000010000b551	movq	-0x40(%rbp), %rdi
000000010000b555	movq	0x38(%r15), %rcx
000000010000b559	movq	%r12, %rdx
000000010000b55c	callq	_fwp_p_map_insert
000000010000b561	movq	%rax, %r12
000000010000b564	decq	%r13
000000010000b567	je	0x10000b5c7
000000010000b569	movq	$0x0, -0x68(%rbp)
000000010000b571	movq	0x38(%r15), %rsi
000000010000b575	movq	%r14, %rdi
000000010000b578	movq	%rbx, %rdx
000000010000b57b	callq	_fwp_decode
000000010000b580	testl	%eax, %eax
000000010000b582	je	0x10000b504
000000010000b584	cmpl	$0x12, (%r15)
000000010000b588	jne	0x10000b54f
000000010000b58a	movq	0x40(%r15), %rsi
000000010000b58e	movq	%r14, %rdi
000000010000b591	leaq	-0x68(%rbp), %rdx
000000010000b595	callq	_fwp_decode
000000010000b59a	testl	%eax, %eax
000000010000b59c	je	0x10000b504
000000010000b5a2	movq	-0x68(%rbp), %rsi
000000010000b5a6	jmp	0x10000b551
000000010000b5a8	movq	0x8(%rax), %r12
000000010000b5ac	movq	0x10(%rax), %rcx
000000010000b5b0	subq	%r12, %rcx
000000010000b5b3	cmpq	%rsi, %rcx
000000010000b5b6	jae	0x10000b5d3
000000010000b5b8	movl	$0x2, %esi
000000010000b5bd	callq	_fwp_gc_alloc_slow
000000010000b5c2	movq	%rax, %r12
000000010000b5c5	jmp	0x10000b5e3
000000010000b5c7	movq	-0x50(%rbp), %rax
000000010000b5cb	movq	%r12, (%rax)
000000010000b5ce	jmp	0x10000b06a
000000010000b5d3	leaq	(%r12,%rsi), %rcx
000000010000b5d7	movq	%rcx, 0x8(%rax)
000000010000b5db	movq	%r12, %rdi
000000010000b5de	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000b5e3	movl	0x10(%r15), %r13d
000000010000b5e7	testl	%r13d, %r13d
000000010000b5ea	jle	0x10000b62f
000000010000b5ec	movq	%r12, -0x48(%rbp)
000000010000b5f0	movq	%r12, %rbx
000000010000b5f3	xorl	%r12d, %r12d
000000010000b5f6	nopw	%cs:(%rax,%rax)
000000010000b600	movq	0x20(%r15), %rax
000000010000b604	movq	(%rax,%r12,8), %rsi
000000010000b608	movq	%r14, %rdi
000000010000b60b	movq	%rbx, %rdx
000000010000b60e	callq	_fwp_decode
000000010000b613	testl	%eax, %eax
000000010000b615	je	0x10000b504
000000010000b61b	incq	%r12
000000010000b61e	movslq	0x10(%r15), %r13
000000010000b622	addq	$0x8, %rbx
000000010000b626	cmpq	%r13, %r12
000000010000b629	jl	0x10000b600
000000010000b62b	movq	-0x48(%rbp), %r12
000000010000b62f	testl	%r13d, %r13d
000000010000b632	je	0x10000b65f
000000010000b634	movl	%r13d, %ebx
000000010000b637	leaq	0x8(,%rbx,8), %rdi
000000010000b63f	callq	_fwp_alloc_init
000000010000b644	movl	$0x0, (%rax)
000000010000b64a	movl	%r13d, 0x4(%rax)
000000010000b64e	cmpl	$0x8, %r13d
000000010000b652	jae	0x10000b66d
000000010000b654	xorl	%ecx, %ecx
000000010000b656	movq	-0x50(%rbp), %r8
000000010000b65a	jmp	0x10000b6ec
000000010000b65f	xorl	%eax, %eax
000000010000b661	movq	-0x50(%rbp), %r8
000000010000b665	movq	%rax, (%r8)
000000010000b668	jmp	0x10000b06a
000000010000b66d	movq	%rax, %rcx
000000010000b670	subq	%r12, %rcx
000000010000b673	addq	$0x8, %rcx
000000010000b677	cmpq	$0x20, %rcx
000000010000b67b	movq	-0x50(%rbp), %r8
000000010000b67f	jae	0x10000b6b3
000000010000b681	xorl	%ecx, %ecx
000000010000b683	jmp	0x10000b6ec
000000010000b685	movq	0x8(%rax), %r13
000000010000b689	movq	0x10(%rax), %rcx
000000010000b68d	subq	%r13, %rcx
000000010000b690	cmpq	%rsi, %rcx
000000010000b693	jae	0x10000b752
000000010000b699	leaq	0x8(,%r12,8), %rdi
000000010000b6a1	movl	$0x2, %esi
000000010000b6a6	callq	_fwp_gc_alloc_slow
000000010000b6ab	movq	%rax, %r13
000000010000b6ae	jmp	0x10000b762
000000010000b6b3	movl	%ebx, %ecx
000000010000b6b5	andl	$-0x4, %ecx
000000010000b6b8	leaq	(,%rbx,8), %rdx
000000010000b6c0	andq	$-0x20, %rdx
000000010000b6c4	xorl	%esi, %esi
000000010000b6c6	movdqu	(%r12,%rsi), %xmm0
000000010000b6cc	movdqu	0x10(%r12,%rsi), %xmm1
000000010000b6d3	movdqu	%xmm0, 0x8(%rax,%rsi)
000000010000b6d9	movdqu	%xmm1, 0x18(%rax,%rsi)
000000010000b6df	addq	$0x20, %rsi
000000010000b6e3	cmpq	%rsi, %rdx
000000010000b6e6	jne	0x10000b6c6
000000010000b6e8	cmpl	%ebx, %ecx
000000010000b6ea	je	0x10000b74a
000000010000b6ec	movq	%rbx, %rsi
000000010000b6ef	movq	%rcx, %rdx
000000010000b6f2	andq	$0x3, %rsi
000000010000b6f6	je	0x10000b711
000000010000b6f8	movq	%rcx, %rdx
000000010000b6fb	nopl	(%rax,%rax)
000000010000b700	movq	(%r12,%rdx,8), %rdi
000000010000b704	movq	%rdi, 0x8(%rax,%rdx,8)
000000010000b709	incq	%rdx
000000010000b70c	decq	%rsi
000000010000b70f	jne	0x10000b700
000000010000b711	subq	%rbx, %rcx
000000010000b714	cmpq	$-0x4, %rcx
000000010000b718	ja	0x10000b74a
000000010000b71a	movq	(%r12,%rdx,8), %rcx
000000010000b71e	movq	%rcx, 0x8(%rax,%rdx,8)
000000010000b723	movq	0x8(%r12,%rdx,8), %rcx
000000010000b728	movq	%rcx, 0x10(%rax,%rdx,8)
000000010000b72d	movq	0x10(%r12,%rdx,8), %rcx
000000010000b732	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000b737	movq	0x18(%r12,%rdx,8), %rcx
000000010000b73c	movq	%rcx, 0x20(%rax,%rdx,8)
000000010000b741	addq	$0x4, %rdx
000000010000b745	cmpq	%rdx, %rbx
000000010000b748	jne	0x10000b71a
000000010000b74a	movq	%rax, (%r8)
000000010000b74d	jmp	0x10000b06a
000000010000b752	leaq	(%rsi,%r13), %rcx
000000010000b756	movq	%rcx, 0x8(%rax)
000000010000b75a	movq	%r13, %rdi
000000010000b75d	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000b762	testq	%r12, %r12
000000010000b765	je	0x10000b7d6
000000010000b767	movq	%r13, -0x48(%rbp)
000000010000b76b	movq	%r13, %rbx
000000010000b76e	movq	%r12, %r13
000000010000b771	movq	0x38(%r15), %rsi
000000010000b775	movq	%r14, %rdi
000000010000b778	movq	%rbx, %rdx
000000010000b77b	callq	_fwp_decode
000000010000b780	testl	%eax, %eax
000000010000b782	je	0x10000b504
000000010000b788	addq	$0x8, %rbx
000000010000b78c	decq	%r13
000000010000b78f	jne	0x10000b771
000000010000b791	xorl	%r15d, %r15d
000000010000b794	movabsq	$0x200000001, %rbx              ## imm = 0x200000001
000000010000b79e	leaq	-0x40(%rbp), %r14
000000010000b7a2	movq	-0x48(%rbp), %rax
000000010000b7a6	movq	-0x8(%rax,%r12,8), %r13
000000010000b7ab	movq	%r13, -0x40(%rbp)
000000010000b7af	movq	%r15, -0x38(%rbp)
000000010000b7b3	movl	$0x18, %edi
000000010000b7b8	callq	_fwp_alloc_init
000000010000b7bd	movq	%rbx, (%rax)
000000010000b7c0	movq	%r13, 0x8(%rax)
000000010000b7c4	movq	-0x48(%rbp), %r13
000000010000b7c8	movq	%r15, 0x10(%rax)
000000010000b7cc	movq	%rax, %r15
000000010000b7cf	decq	%r12
000000010000b7d2	jne	0x10000b7a2
000000010000b7d4	jmp	0x10000b7d8
000000010000b7d6	xorl	%eax, %eax
000000010000b7d8	movq	-0x50(%rbp), %rcx
000000010000b7dc	movq	%rax, (%rcx)
000000010000b7df	jmp	0x10000b06a
000000010000b7e4	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000b7e9	nopl	(%rax)
000000010000b7ec	orb	$-0x7, %al
000000010000b7ee	.byte 0xff #bad opcode
000000010000b7ef	pushq	%rbp
000000010000b7f1	cli
000000010000b7f2	.byte 0xff #bad opcode
000000010000b7f3	pushq	-0x44000005(%rip)
000000010000b7f9	idivl	%edi
000000010000b7fb	pushq	(%rdx)
000000010000b7fd	stc
000000010000b7fe	.byte 0xff #bad opcode
000000010000b7ff	jmpq	*%rcx
000000010000b801	cli
000000010000b802	.byte 0xff #bad opcode
000000010000b803	.byte 0xff #bad opcode
000000010000b804	jmp	0x10000b800
000000010000b806	.byte 0xff #bad opcode
000000010000b807	decl	-0x44000005(%rbp)
000000010000b80d	idivl	%edi
000000010000b80f	pushq	(%rdx)
000000010000b811	stc
000000010000b812	.byte 0xff #bad opcode
000000010000b813	.byte 0xff #bad opcode
000000010000b814	movl	$0xbbfffff7, %ebx               ## imm = 0xBBFFFFF7
000000010000b819	idivl	%edi
000000010000b81b	decl	-0x76000008(%rcx)
000000010000b821	clc
000000010000b822	.byte 0xff #bad opcode
000000010000b823	.byte 0xff #bad opcode
000000010000b824	.byte 0x3f #bad opcode
000000010000b825	cli
000000010000b826	.byte 0xff #bad opcode
000000010000b827	decl	-0x3e50001(%rcx,%rdi,8)
000000010000b82e	.byte 0xff #bad opcode
000000010000b82f	decl	-0x4680001(%rcx,%rdi,8)
000000010000b836	.byte 0xff #bad opcode
000000010000b837	ljmpl	*-0x44000005(%rbp)
000000010000b83d	idivl	%edi
000000010000b83f	decl	(%rcx,%rdi,8)
000000010000b842	.byte 0xff #bad opcode
000000010000b843	jmpq	*0x66(%rsi)
000000010000b846	nopw	%cs:(%rax,%rax)
_fwp_valid_utf8:
000000010000b850	testq	%rsi, %rsi
000000010000b853	je	0x10000b9b2
000000010000b859	pushq	%rbp
000000010000b85a	movq	%rsp, %rbp
000000010000b85d	pushq	%rbx
000000010000b85e	xorl	%ecx, %ecx
000000010000b860	jmp	0x10000b87c
000000010000b862	nopw	%cs:(%rax,%rax)
000000010000b870	incq	%rcx
000000010000b873	cmpq	%rsi, %rcx
000000010000b876	jae	0x10000b9aa
000000010000b87c	movzbl	(%rdi,%rcx), %r10d
000000010000b881	testb	%r10b, %r10b
000000010000b884	jns	0x10000b870
000000010000b886	leal	0x3e(%r10), %eax
000000010000b88a	cmpb	$0x1e, %al
000000010000b88c	jae	0x10000b8a0
000000010000b88e	movl	$0x80, %edx
000000010000b893	movl	$0x1, %eax
000000010000b898	movl	$0x1f, %r8d
000000010000b89e	jmp	0x10000b8d7
000000010000b8a0	movl	%r10d, %eax
000000010000b8a3	andb	$-0x10, %al
000000010000b8a5	cmpb	$-0x20, %al
000000010000b8a7	jne	0x10000b8bb
000000010000b8a9	movl	$0x800, %edx                    ## imm = 0x800
000000010000b8ae	movl	$0x2, %eax
000000010000b8b3	movl	$0xf, %r8d
000000010000b8b9	jmp	0x10000b8d7
000000010000b8bb	leal	0x10(%r10), %eax
000000010000b8bf	cmpb	$0x4, %al
000000010000b8c1	ja	0x10000b9b8
000000010000b8c7	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000b8cc	movl	$0x3, %eax
000000010000b8d1	movl	$0x7, %r8d
000000010000b8d7	movl	%eax, %r9d
000000010000b8da	leaq	(%rcx,%r9), %r11
000000010000b8de	xorl	%eax, %eax
000000010000b8e0	cmpq	%rsi, %r11
000000010000b8e3	jae	0x10000b9af
000000010000b8e9	movzbl	0x1(%rdi,%rcx), %r11d
000000010000b8ef	movl	%r11d, %ebx
000000010000b8f2	andl	$-0x40, %ebx
000000010000b8f5	cmpl	$0x80, %ebx
000000010000b8fb	jne	0x10000b9af
000000010000b901	andl	%r10d, %r8d
000000010000b904	leal	0x1(%r9), %ebx
000000010000b908	movl	%r8d, %r10d
000000010000b90b	shll	$0x6, %r10d
000000010000b90f	andl	$0x3f, %r11d
000000010000b913	orl	%r10d, %r11d
000000010000b916	cmpl	$0x2, %ebx
000000010000b919	jne	0x10000b927
000000010000b91b	movl	%r11d, %ebx
000000010000b91e	cmpl	%edx, %ebx
000000010000b920	jae	0x10000b982
000000010000b922	jmp	0x10000b9af
000000010000b927	movzbl	0x2(%rdi,%rcx), %r8d
000000010000b92d	movl	%r8d, %r10d
000000010000b930	andl	$-0x40, %r10d
000000010000b934	cmpl	$0x80, %r10d
000000010000b93b	jne	0x10000b9af
000000010000b93d	movl	%r11d, %r10d
000000010000b940	shll	$0x6, %r10d
000000010000b944	andl	$0x3f, %r8d
000000010000b948	orl	%r10d, %r8d
000000010000b94b	cmpl	$0x3, %ebx
000000010000b94e	jne	0x10000b95c
000000010000b950	movl	%r8d, %ebx
000000010000b953	movl	%r11d, %r8d
000000010000b956	cmpl	%edx, %ebx
000000010000b958	jae	0x10000b982
000000010000b95a	jmp	0x10000b9af
000000010000b95c	movzbl	0x3(%rdi,%rcx), %ebx
000000010000b961	movl	%ebx, %r10d
000000010000b964	andl	$-0x40, %r10d
000000010000b968	cmpl	$0x80, %r10d
000000010000b96f	jne	0x10000b9af
000000010000b971	movl	%r8d, %r10d
000000010000b974	shll	$0x6, %r10d
000000010000b978	andl	$0x3f, %ebx
000000010000b97b	orl	%r10d, %ebx
000000010000b97e	cmpl	%edx, %ebx
000000010000b980	jb	0x10000b9af
000000010000b982	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000b989	ja	0x10000b9af
000000010000b98b	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000b992	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000b999	je	0x10000b9af
000000010000b99b	addq	%r9, %rcx
000000010000b99e	incq	%rcx
000000010000b9a1	cmpq	%rsi, %rcx
000000010000b9a4	jb	0x10000b87c
000000010000b9aa	movl	$0x1, %eax
000000010000b9af	popq	%rbx
000000010000b9b0	popq	%rbp
000000010000b9b1	retq
000000010000b9b2	movl	$0x1, %eax
000000010000b9b7	retq
000000010000b9b8	xorl	%eax, %eax
000000010000b9ba	jmp	0x10000b9af
000000010000b9bc	nopl	(%rax)
_fwp_str_new:
000000010000b9c0	pushq	%rbp
000000010000b9c1	movq	%rsp, %rbp
000000010000b9c4	pushq	%r15
000000010000b9c6	pushq	%r14
000000010000b9c8	pushq	%rbx
000000010000b9c9	pushq	%rax
000000010000b9ca	movq	%rsi, %r14
000000010000b9cd	movq	%rdi, %rbx
000000010000b9d0	addq	$0x9, %rsi
000000010000b9d4	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000b9db	ja	0x10000ba36
000000010000b9dd	leaq	0x18(%r14), %rax
000000010000b9e1	shrq	$0x4, %rax
000000010000b9e5	leaq	_fwp_gc(%rip), %rcx
000000010000b9ec	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b9f4	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b9fb	subq	%rax, _fwp_gc(%rip)
000000010000ba02	js	0x10000ba36
000000010000ba04	leaq	(%rdx,%rdx,2), %rdx
000000010000ba08	leaq	(%rcx,%rdx,8), %rcx
000000010000ba0c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000ba13	movq	(%rcx), %r15
000000010000ba16	testq	%r15, %r15
000000010000ba19	je	0x10000ba26
000000010000ba1b	movq	(%r15), %rax
000000010000ba1e	notq	%rax
000000010000ba21	movq	%rax, (%rcx)
000000010000ba24	jmp	0x10000ba4f
000000010000ba26	movq	0x8(%rcx), %r15
000000010000ba2a	movq	0x10(%rcx), %rdx
000000010000ba2e	subq	%r15, %rdx
000000010000ba31	cmpq	%rax, %rdx
000000010000ba34	jae	0x10000ba48
000000010000ba36	movq	%rsi, %rdi
000000010000ba39	movl	$0x1, %esi
000000010000ba3e	callq	_fwp_gc_alloc_slow
000000010000ba43	movq	%rax, %r15
000000010000ba46	jmp	0x10000ba57
000000010000ba48	addq	%r15, %rax
000000010000ba4b	movq	%rax, 0x8(%rcx)
000000010000ba4f	movq	%r15, %rdi
000000010000ba52	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000ba57	movq	%r14, (%r15)
000000010000ba5a	leaq	0x8(%r15), %rdi
000000010000ba5e	movq	%rbx, %rsi
000000010000ba61	movq	%r14, %rdx
000000010000ba64	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000ba69	movb	$0x0, 0x8(%r15,%r14)
000000010000ba6f	movq	%r15, %rax
000000010000ba72	addq	$0x8, %rsp
000000010000ba76	popq	%rbx
000000010000ba77	popq	%r14
000000010000ba79	popq	%r15
000000010000ba7b	popq	%rbp
000000010000ba7c	retq
000000010000ba7d	nopl	(%rax)
_buf_put:
000000010000ba80	pushq	%rbp
000000010000ba81	movq	%rsp, %rbp
000000010000ba84	pushq	%r15
000000010000ba86	pushq	%r14
000000010000ba88	pushq	%r12
000000010000ba8a	pushq	%rbx
000000010000ba8b	movq	%rdi, %r14
000000010000ba8e	movq	0x8(%rdi), %rdi
000000010000ba92	cmpq	$-0x1, %rdi
000000010000ba96	je	0x10000bb38
000000010000ba9c	movq	%rdx, %rbx
000000010000ba9f	movq	$-0x2, %rax
000000010000baa6	subq	%rdi, %rax
000000010000baa9	cmpq	%rdx, %rax
000000010000baac	jb	0x10000bb38
000000010000bab2	leaq	(%rbx,%rdi), %rax
000000010000bab6	incq	%rax
000000010000bab9	movq	0x10(%r14), %rcx
000000010000babd	cmpq	%rcx, %rax
000000010000bac0	jbe	0x10000baef
000000010000bac2	testq	%rcx, %rcx
000000010000bac5	movl	$0x40, %r15d
000000010000bacb	cmovneq	%rcx, %r15
000000010000bacf	movq	%rsi, %r12
000000010000bad2	cmpq	%rax, %r15
000000010000bad5	jae	0x10000baf7
000000010000bad7	nopw	(%rax,%rax)
000000010000bae0	testq	%r15, %r15
000000010000bae3	js	0x10000baf4
000000010000bae5	addq	%r15, %r15
000000010000bae8	cmpq	%rax, %r15
000000010000baeb	jb	0x10000bae0
000000010000baed	jmp	0x10000baf7
000000010000baef	movq	(%r14), %rax
000000010000baf2	jmp	0x10000bb15
000000010000baf4	movq	%rax, %r15
000000010000baf7	movq	(%r14), %rdi
000000010000bafa	movq	%r15, %rsi
000000010000bafd	callq	0x1000120fa                     ## symbol stub for: _realloc
000000010000bb02	testq	%rax, %rax
000000010000bb05	je	0x10000bb38
000000010000bb07	movq	%rax, (%r14)
000000010000bb0a	movq	%r15, 0x10(%r14)
000000010000bb0e	movq	0x8(%r14), %rdi
000000010000bb12	movq	%r12, %rsi
000000010000bb15	addq	%rax, %rdi
000000010000bb18	movq	%rbx, %rdx
000000010000bb1b	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000bb20	addq	0x8(%r14), %rbx
000000010000bb24	movq	%rbx, 0x8(%r14)
000000010000bb28	movq	(%r14), %rax
000000010000bb2b	movb	$0x0, (%rax,%rbx)
000000010000bb2f	popq	%rbx
000000010000bb30	popq	%r12
000000010000bb32	popq	%r14
000000010000bb34	popq	%r15
000000010000bb36	popq	%rbp
000000010000bb37	retq
000000010000bb38	movq	0x84f9(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000bb3f	movq	(%rax), %rcx
000000010000bb42	leaq	0x6d56(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000bb49	movl	$0x13, %esi
000000010000bb4e	movl	$0x1, %edx
000000010000bb53	callq	0x100012088                     ## symbol stub for: _fwrite
000000010000bb58	movl	$0x66, %edi
000000010000bb5d	callq	0x100012058                     ## symbol stub for: _exit
000000010000bb62	nopw	%cs:(%rax,%rax)
_buf_to_str:
000000010000bb70	pushq	%rbp
000000010000bb71	movq	%rsp, %rbp
000000010000bb74	pushq	%r14
000000010000bb76	pushq	%rbx
000000010000bb77	movq	%rdi, %rbx
000000010000bb7a	movq	(%rdi), %rax
000000010000bb7d	movq	0x8(%rdi), %rsi
000000010000bb81	testq	%rax, %rax
000000010000bb84	leaq	0x6bb7(%rip), %rdi              ## literal pool for: ""
000000010000bb8b	cmovneq	%rax, %rdi
000000010000bb8f	callq	_fwp_str_new
000000010000bb94	movq	%rax, %r14
000000010000bb97	movq	(%rbx), %rdi
000000010000bb9a	callq	0x100012082                     ## symbol stub for: _free
000000010000bb9f	movq	%r14, %rax
000000010000bba2	popq	%rbx
000000010000bba3	popq	%r14
000000010000bba5	popq	%rbp
000000010000bba6	retq
000000010000bba7	nopw	(%rax,%rax)
_fwp_strf:
000000010000bbb0	pushq	%rbp
000000010000bbb1	movq	%rsp, %rbp
000000010000bbb4	pushq	%r15
000000010000bbb6	pushq	%r14
000000010000bbb8	pushq	%r13
000000010000bbba	pushq	%r12
000000010000bbbc	pushq	%rbx
000000010000bbbd	subq	$0xd8, %rsp
000000010000bbc4	movq	%rdi, %rbx
000000010000bbc7	movq	%rsi, -0xf8(%rbp)
000000010000bbce	movq	%rdx, -0xf0(%rbp)
000000010000bbd5	movq	%rcx, -0xe8(%rbp)
000000010000bbdc	movq	%r8, -0xe0(%rbp)
000000010000bbe3	movq	%r9, -0xd8(%rbp)
000000010000bbea	testb	%al, %al
000000010000bbec	je	0x10000bc1d
000000010000bbee	movaps	%xmm0, -0xd0(%rbp)
000000010000bbf5	movaps	%xmm1, -0xc0(%rbp)
000000010000bbfc	movaps	%xmm2, -0xb0(%rbp)
000000010000bc03	movaps	%xmm3, -0xa0(%rbp)
000000010000bc0a	movaps	%xmm4, -0x90(%rbp)
000000010000bc11	movaps	%xmm5, -0x80(%rbp)
000000010000bc15	movaps	%xmm6, -0x70(%rbp)
000000010000bc19	movaps	%xmm7, -0x60(%rbp)
000000010000bc1d	movq	0x840c(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000bc24	movq	(%rax), %rax
000000010000bc27	movq	%rax, -0x30(%rbp)
000000010000bc2b	leaq	-0x100(%rbp), %rax
000000010000bc32	movq	%rax, -0x40(%rbp)
000000010000bc36	leaq	0x10(%rbp), %rax
000000010000bc3a	movq	%rax, -0x48(%rbp)
000000010000bc3e	movabsq	$0x3000000008, %r13             ## imm = 0x3000000008
000000010000bc48	movq	%r13, -0x50(%rbp)
000000010000bc4c	leaq	-0x50(%rbp), %rcx
000000010000bc50	xorl	%edi, %edi
000000010000bc52	xorl	%esi, %esi
000000010000bc54	movq	%rbx, %rdx
000000010000bc57	callq	0x100012166                     ## symbol stub for: _vsnprintf
000000010000bc5c	movslq	%eax, %r14
000000010000bc5f	leaq	0x1(%r14), %r15
000000010000bc63	cmpq	$0x4000, %r15                   ## imm = 0x4000
000000010000bc6a	ja	0x10000bcc6
000000010000bc6c	leaq	0x10(%r14), %rax
000000010000bc70	shrq	$0x4, %rax
000000010000bc74	leaq	_fwp_gc(%rip), %rcx
000000010000bc7b	movzbl	0xbe8(%rax,%rcx), %edx
000000010000bc83	movl	0xb48(%rcx,%rdx,4), %eax
000000010000bc8a	subq	%rax, _fwp_gc(%rip)
000000010000bc91	js	0x10000bcc6
000000010000bc93	leaq	(%rdx,%rdx,2), %rdx
000000010000bc97	leaq	(%rcx,%rdx,8), %rcx
000000010000bc9b	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000bca2	movq	(%rcx), %r12
000000010000bca5	testq	%r12, %r12
000000010000bca8	je	0x10000bcb6
000000010000bcaa	movq	(%r12), %rax
000000010000bcae	notq	%rax
000000010000bcb1	movq	%rax, (%rcx)
000000010000bcb4	jmp	0x10000bcdf
000000010000bcb6	movq	0x8(%rcx), %r12
000000010000bcba	movq	0x10(%rcx), %rdx
000000010000bcbe	subq	%r12, %rdx
000000010000bcc1	cmpq	%rax, %rdx
000000010000bcc4	jae	0x10000bcd8
000000010000bcc6	movq	%r15, %rdi
000000010000bcc9	movl	$0x1, %esi
000000010000bcce	callq	_fwp_gc_alloc_slow
000000010000bcd3	movq	%rax, %r12
000000010000bcd6	jmp	0x10000bcea
000000010000bcd8	addq	%r12, %rax
000000010000bcdb	movq	%rax, 0x8(%rcx)
000000010000bcdf	movq	%r12, %rdi
000000010000bce2	movq	%r15, %rsi
000000010000bce5	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000bcea	leaq	-0x100(%rbp), %rax
000000010000bcf1	movq	%rax, -0x40(%rbp)
000000010000bcf5	leaq	0x10(%rbp), %rax
000000010000bcf9	movq	%rax, -0x48(%rbp)
000000010000bcfd	movq	%r13, -0x50(%rbp)
000000010000bd01	leaq	-0x50(%rbp), %rcx
000000010000bd05	movq	%r12, %rdi
000000010000bd08	movq	%r15, %rsi
000000010000bd0b	movq	%rbx, %rdx
000000010000bd0e	callq	0x100012166                     ## symbol stub for: _vsnprintf
000000010000bd13	movq	%r12, %rdi
000000010000bd16	movq	%r14, %rsi
000000010000bd19	callq	_fwp_str_new
000000010000bd1e	movq	0x830b(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000bd25	movq	(%rcx), %rcx
000000010000bd28	cmpq	-0x30(%rbp), %rcx
000000010000bd2c	jne	0x10000bd40
000000010000bd2e	addq	$0xd8, %rsp
000000010000bd35	popq	%rbx
000000010000bd36	popq	%r12
000000010000bd38	popq	%r13
000000010000bd3a	popq	%r14
000000010000bd3c	popq	%r15
000000010000bd3e	popq	%rbp
000000010000bd3f	retq
000000010000bd40	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000bd45	nopw	%cs:(%rax,%rax)
_tp_value:
000000010000bd50	pushq	%rbp
000000010000bd51	movq	%rsp, %rbp
000000010000bd54	pushq	%r15
000000010000bd56	pushq	%r14
000000010000bd58	pushq	%r13
000000010000bd5a	pushq	%r12
000000010000bd5c	pushq	%rbx
000000010000bd5d	subq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000bd64	movq	%rcx, %rbx
000000010000bd67	movq	%rsi, %rax
000000010000bd6a	movq	0x82bf(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000bd71	movq	(%rcx), %rcx
000000010000bd74	movq	%rcx, -0x30(%rbp)
000000010000bd78	testl	%edx, %edx
000000010000bd7a	je	0x10000bde1
000000010000bd7c	cmpl	$0xc, (%rax)
000000010000bd7f	jne	0x10000bde1
000000010000bd81	movq	0x8(%rdi), %rsi
000000010000bd85	movq	0x10(%rdi), %r15
000000010000bd89	movq	%rbx, %r12
000000010000bd8c	movq	(%rdi), %rax
000000010000bd8f	addq	%r15, %rax
000000010000bd92	subq	%r15, %rsi
000000010000bd95	jne	0x10000be6c
000000010000bd9b	movq	%rdi, %rbx
000000010000bd9e	movq	%rax, %rdi
000000010000bda1	callq	_fwp_str_new
000000010000bda6	movq	%rax, (%r12)
000000010000bdaa	movq	0x8(%rbx), %rax
000000010000bdae	movq	%rax, 0x10(%rbx)
000000010000bdb2	movl	$0x1, %r14d
000000010000bdb8	movq	0x8271(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000bdbf	movq	(%rax), %rax
000000010000bdc2	cmpq	-0x30(%rbp), %rax
000000010000bdc6	jne	0x10000d5dc
000000010000bdcc	movl	%r14d, %eax
000000010000bdcf	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000bdd6	popq	%rbx
000000010000bdd7	popq	%r12
000000010000bdd9	popq	%r13
000000010000bddb	popq	%r14
000000010000bddd	popq	%r15
000000010000bddf	popq	%rbp
000000010000bde0	retq
000000010000bde1	movq	0x8(%rdi), %rsi
000000010000bde5	movq	0x10(%rdi), %r15
000000010000bde9	cmpq	%rsi, %r15
000000010000bdec	jae	0x10000be20
000000010000bdee	movq	(%rdi), %rcx
000000010000bdf1	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000bdfb	nopl	(%rax,%rax)
000000010000be00	movzbl	(%rcx,%r15), %r9d
000000010000be05	cmpq	$0x20, %r9
000000010000be09	ja	0x10000be20
000000010000be0b	btq	%r9, %r8
000000010000be0f	jae	0x10000be20
000000010000be11	incq	%r15
000000010000be14	movq	%r15, 0x10(%rdi)
000000010000be18	cmpq	%r15, %rsi
000000010000be1b	jne	0x10000be00
000000010000be1d	movq	%rsi, %r15
000000010000be20	movl	(%rax), %ecx
000000010000be22	xorl	%r14d, %r14d
000000010000be25	cmpq	$0x15, %rcx
000000010000be29	ja	0x10000bdb8
000000010000be2b	leaq	0x17b2(%rip), %r8
000000010000be32	movslq	(%r8,%rcx,4), %r9
000000010000be36	addq	%r8, %r9
000000010000be39	jmpq	*%r9
000000010000be3c	movq	0x81ed(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000be43	movq	(%rcx), %rcx
000000010000be46	cmpq	-0x30(%rbp), %rcx
000000010000be4a	jne	0x10000d5dc
000000010000be50	movq	%rax, %rsi
000000010000be53	movq	%rbx, %rdx
000000010000be56	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000be5d	popq	%rbx
000000010000be5e	popq	%r12
000000010000be60	popq	%r13
000000010000be62	popq	%r14
000000010000be64	popq	%r15
000000010000be66	popq	%rbp
000000010000be67	jmp	_tp_int
000000010000be6c	xorl	%ecx, %ecx
000000010000be6e	jmp	0x10000be7c
000000010000be70	incq	%rcx
000000010000be73	cmpq	%rsi, %rcx
000000010000be76	jae	0x10000bd9b
000000010000be7c	movzbl	(%rax,%rcx), %r10d
000000010000be81	testb	%r10b, %r10b
000000010000be84	jns	0x10000be70
000000010000be86	leal	0x3e(%r10), %edx
000000010000be8a	cmpb	$0x1e, %dl
000000010000be8d	jae	0x10000bea2
000000010000be8f	movl	$0x80, %edx
000000010000be94	movl	$0x1, %r9d
000000010000be9a	movl	$0x1f, %r8d
000000010000bea0	jmp	0x10000bede
000000010000bea2	movl	%r10d, %edx
000000010000bea5	andb	$-0x10, %dl
000000010000bea8	cmpb	$-0x20, %dl
000000010000beab	jne	0x10000bec0
000000010000bead	movl	$0x800, %edx                    ## imm = 0x800
000000010000beb2	movl	$0x2, %r9d
000000010000beb8	movl	$0xf, %r8d
000000010000bebe	jmp	0x10000bede
000000010000bec0	leal	0x10(%r10), %edx
000000010000bec4	cmpb	$0x4, %dl
000000010000bec7	ja	0x10000d50c
000000010000becd	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000bed2	movl	$0x3, %r9d
000000010000bed8	movl	$0x7, %r8d
000000010000bede	movl	%r9d, %r9d
000000010000bee1	leaq	(%rcx,%r9), %r11
000000010000bee5	xorl	%r14d, %r14d
000000010000bee8	cmpq	%rsi, %r11
000000010000beeb	jae	0x10000bdb8
000000010000bef1	movzbl	0x1(%rax,%rcx), %r11d
000000010000bef7	movl	%r11d, %ebx
000000010000befa	andl	$-0x40, %ebx
000000010000befd	cmpl	$0x80, %ebx
000000010000bf03	jne	0x10000bdb8
000000010000bf09	andl	%r10d, %r8d
000000010000bf0c	leal	0x1(%r9), %ebx
000000010000bf10	movl	%r8d, %r10d
000000010000bf13	shll	$0x6, %r10d
000000010000bf17	andl	$0x3f, %r11d
000000010000bf1b	orl	%r10d, %r11d
000000010000bf1e	cmpl	$0x2, %ebx
000000010000bf21	jne	0x10000bf28
000000010000bf23	movl	%r11d, %ebx
000000010000bf26	jmp	0x10000bf83
000000010000bf28	movzbl	0x2(%rax,%rcx), %r8d
000000010000bf2e	movl	%r8d, %r10d
000000010000bf31	andl	$-0x40, %r10d
000000010000bf35	cmpl	$0x80, %r10d
000000010000bf3c	jne	0x10000bdb8
000000010000bf42	movl	%r11d, %r10d
000000010000bf45	shll	$0x6, %r10d
000000010000bf49	andl	$0x3f, %r8d
000000010000bf4d	orl	%r10d, %r8d
000000010000bf50	cmpl	$0x3, %ebx
000000010000bf53	jne	0x10000bf5d
000000010000bf55	movl	%r8d, %ebx
000000010000bf58	movl	%r11d, %r8d
000000010000bf5b	jmp	0x10000bf83
000000010000bf5d	movzbl	0x3(%rax,%rcx), %ebx
000000010000bf62	movl	%ebx, %r10d
000000010000bf65	andl	$-0x40, %r10d
000000010000bf69	cmpl	$0x80, %r10d
000000010000bf70	jne	0x10000bdb8
000000010000bf76	movl	%r8d, %r10d
000000010000bf79	shll	$0x6, %r10d
000000010000bf7d	andl	$0x3f, %ebx
000000010000bf80	orl	%r10d, %ebx
000000010000bf83	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000bf8a	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000bf91	je	0x10000bdb8
000000010000bf97	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000bf9e	ja	0x10000bdb8
000000010000bfa4	cmpl	%edx, %ebx
000000010000bfa6	jb	0x10000bdb8
000000010000bfac	addq	%r9, %rcx
000000010000bfaf	incq	%rcx
000000010000bfb2	cmpq	%rsi, %rcx
000000010000bfb5	jb	0x10000be7c
000000010000bfbb	jmp	0x10000bd9b
000000010000bfc0	movdqu	0x38(%rax), %xmm0
000000010000bfc5	movdqa	%xmm0, -0x130(%rbp)
000000010000bfcd	xorl	%edx, %edx
000000010000bfcf	cmpl	$0x13, %ecx
000000010000bfd2	sete	%dl
000000010000bfd5	pxor	%xmm0, %xmm0
000000010000bfd9	movdqa	%xmm0, -0x120(%rbp)
000000010000bfe1	movq	$0x0, -0x110(%rbp)
000000010000bfec	movl	%edx, -0x108(%rbp)
000000010000bff2	leaq	0x7460(%rip), %rdx              ## literal pool for: "set"
000000010000bff9	leaq	0x745d(%rip), %rcx              ## literal pool for: "map"
000000010000c000	cmoveq	%rdx, %rcx
000000010000c004	cmpq	%rsi, %r15
000000010000c007	jae	0x10000c040
000000010000c009	movq	(%rdi), %rdx
000000010000c00c	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000c016	nopw	%cs:(%rax,%rax)
000000010000c020	movzbl	(%rdx,%r15), %r9d
000000010000c025	cmpq	$0x20, %r9
000000010000c029	ja	0x10000c040
000000010000c02b	btq	%r9, %r8
000000010000c02f	jae	0x10000c040
000000010000c031	incq	%r15
000000010000c034	movq	%r15, 0x10(%rdi)
000000010000c038	cmpq	%r15, %rsi
000000010000c03b	jne	0x10000c020
000000010000c03d	movq	%rsi, %r15
000000010000c040	subq	%r15, %rsi
000000010000c043	xorl	%r14d, %r14d
000000010000c046	cmpq	$0x3, %rsi
000000010000c04a	jb	0x10000bdb8
000000010000c050	movq	(%rdi), %rdx
000000010000c053	movzwl	(%rdx,%r15), %esi
000000010000c058	xorw	(%rcx), %si
000000010000c05b	movzbl	0x2(%rdx,%r15), %edx
000000010000c061	xorb	0x2(%rcx), %dl
000000010000c064	movzbl	%dl, %ecx
000000010000c067	orw	%si, %cx
000000010000c06a	jne	0x10000bdb8
000000010000c070	movq	%rbx, %r12
000000010000c073	movq	%rax, %rbx
000000010000c076	addq	$0x3, %r15
000000010000c07a	movq	%r15, 0x10(%rdi)
000000010000c07e	leaq	0x73dc(%rip), %rsi              ## literal pool for: "{"
000000010000c085	leaq	0x73d7(%rip), %rdx              ## literal pool for: "}"
000000010000c08c	leaq	_tp_kv_item(%rip), %rcx
000000010000c093	leaq	-0x130(%rbp), %r8
000000010000c09a	callq	_tp_list_of
000000010000c09f	testl	%eax, %eax
000000010000c0a1	je	0x10000cc2d
000000010000c0a7	cmpq	$0x0, -0x118(%rbp)
000000010000c0af	je	0x10000ceea
000000010000c0b5	leaq	_fwp_empty_map(%rip), %rax
000000010000c0bc	xorl	%r14d, %r14d
000000010000c0bf	movq	-0x120(%rbp), %rcx
000000010000c0c6	movq	(%rcx,%r14,8), %rdi
000000010000c0ca	movq	0x8(%rcx,%r14,8), %rsi
000000010000c0cf	movq	0x38(%rbx), %rcx
000000010000c0d3	movq	%rax, %rdx
000000010000c0d6	callq	_fwp_p_map_insert
000000010000c0db	addq	$0x2, %r14
000000010000c0df	cmpq	-0x118(%rbp), %r14
000000010000c0e6	jb	0x10000c0bf
000000010000c0e8	jmp	0x10000cef1
000000010000c0ed	pxor	%xmm0, %xmm0
000000010000c0f1	movdqu	%xmm0, -0x118(%rbp)
000000010000c0f9	movdqu	%xmm0, -0x128(%rbp)
000000010000c101	movq	$0x0, -0x108(%rbp)
000000010000c10c	movq	0x38(%rax), %rdx
000000010000c110	movq	%rdx, -0x130(%rbp)
000000010000c117	cmpl	$0x11, %ecx
000000010000c11a	jne	0x10000c185
000000010000c11c	cmpq	%rsi, %r15
000000010000c11f	jae	0x10000c150
000000010000c121	movq	(%rdi), %rcx
000000010000c124	movabsq	$0x100002600, %rdx              ## imm = 0x100002600
000000010000c12e	nop
000000010000c130	movzbl	(%rcx,%r15), %r8d
000000010000c135	cmpq	$0x20, %r8
000000010000c139	ja	0x10000c150
000000010000c13b	btq	%r8, %rdx
000000010000c13f	jae	0x10000c150
000000010000c141	incq	%r15
000000010000c144	movq	%r15, 0x10(%rdi)
000000010000c148	cmpq	%r15, %rsi
000000010000c14b	jne	0x10000c130
000000010000c14d	movq	%rsi, %r15
000000010000c150	subq	%r15, %rsi
000000010000c153	xorl	%r14d, %r14d
000000010000c156	cmpq	$0x5, %rsi
000000010000c15a	jb	0x10000bdb8
000000010000c160	movq	(%rdi), %rcx
000000010000c163	movl	$0x61727261, %edx               ## imm = 0x61727261
000000010000c168	xorl	(%rcx,%r15), %edx
000000010000c16c	movzbl	0x4(%rcx,%r15), %ecx
000000010000c172	xorl	$0x79, %ecx
000000010000c175	orl	%edx, %ecx
000000010000c177	jne	0x10000bdb8
000000010000c17d	addq	$0x5, %r15
000000010000c181	movq	%r15, 0x10(%rdi)
000000010000c185	movq	%rax, -0x1d0(%rbp)
000000010000c18c	leaq	0x72b6(%rip), %rsi              ## literal pool for: "["
000000010000c193	leaq	0x72b1(%rip), %rdx              ## literal pool for: "]"
000000010000c19a	leaq	_tp_elem_item(%rip), %rcx
000000010000c1a1	leaq	-0x130(%rbp), %r8
000000010000c1a8	callq	_tp_list_of
000000010000c1ad	movq	-0x120(%rbp), %r14
000000010000c1b4	testl	%eax, %eax
000000010000c1b6	je	0x10000c692
000000010000c1bc	movq	%rbx, -0x1e8(%rbp)
000000010000c1c3	movq	-0x118(%rbp), %rbx
000000010000c1ca	testq	%rbx, %rbx
000000010000c1cd	je	0x10000c7f0
000000010000c1d3	xorl	%r15d, %r15d
000000010000c1d6	leaq	-0x1b0(%rbp), %r13
000000010000c1dd	nopl	(%rax)
000000010000c1e0	movq	-0x8(%r14,%rbx,8), %r12
000000010000c1e5	movq	%r12, -0x1b0(%rbp)
000000010000c1ec	movq	%r15, -0x1a8(%rbp)
000000010000c1f3	movl	$0x18, %edi
000000010000c1f8	callq	_fwp_alloc_init
000000010000c1fd	movabsq	$0x200000001, %rcx              ## imm = 0x200000001
000000010000c207	movq	%rcx, (%rax)
000000010000c20a	movq	%r12, 0x8(%rax)
000000010000c20e	movq	%r15, 0x10(%rax)
000000010000c212	movq	%rax, %r15
000000010000c215	decq	%rbx
000000010000c218	jne	0x10000c1e0
000000010000c21a	jmp	0x10000c7f2
000000010000c21f	movq	%rbx, %r15
000000010000c222	movq	%rax, %rbx
000000010000c225	leaq	-0x130(%rbp), %rsi
000000010000c22c	movl	$0x80, %edx
000000010000c231	callq	_tp_token
000000010000c236	xorl	%r14d, %r14d
000000010000c239	cmpq	$0x7f, %rax
000000010000c23d	ja	0x10000bdb8
000000010000c243	movl	-0x130(%rbp), %edx
000000010000c249	cmpl	$0x666e69, %edx                 ## imm = 0x666E69
000000010000c24f	jne	0x10000c65c
000000010000c255	movsd	0x60b3(%rip), %xmm0
000000010000c25d	movq	%rbx, %rcx
000000010000c260	jmp	0x10000cc46
000000010000c265	testl	%edx, %edx
000000010000c267	jne	0x10000bd89
000000010000c26d	movq	0x7dbc(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000c274	movq	(%rax), %rax
000000010000c277	cmpq	-0x30(%rbp), %rax
000000010000c27b	jne	0x10000d5dc
000000010000c281	movq	%rbx, %rsi
000000010000c284	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000c28b	popq	%rbx
000000010000c28c	popq	%r12
000000010000c28e	popq	%r13
000000010000c290	popq	%r14
000000010000c292	popq	%r15
000000010000c294	popq	%rbp
000000010000c295	jmp	_tp_quoted
000000010000c29a	pxor	%xmm0, %xmm0
000000010000c29e	movdqa	%xmm0, -0x110(%rbp)
000000010000c2a6	movdqa	%xmm0, -0x120(%rbp)
000000010000c2ae	movdqa	%xmm0, -0x130(%rbp)
000000010000c2b6	cmpq	%rsi, %r15
000000010000c2b9	jae	0x10000c2f0
000000010000c2bb	movq	(%rdi), %rax
000000010000c2be	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000c2c8	nopl	(%rax,%rax)
000000010000c2d0	movzbl	(%rax,%r15), %edx
000000010000c2d5	cmpq	$0x20, %rdx
000000010000c2d9	ja	0x10000c2f0
000000010000c2db	btq	%rdx, %rcx
000000010000c2df	jae	0x10000c2f0
000000010000c2e1	incq	%r15
000000010000c2e4	movq	%r15, 0x10(%rdi)
000000010000c2e8	cmpq	%r15, %rsi
000000010000c2eb	jne	0x10000c2d0
000000010000c2ed	movq	%rsi, %r15
000000010000c2f0	subq	%r15, %rsi
000000010000c2f3	xorl	%r14d, %r14d
000000010000c2f6	cmpq	$0x5, %rsi
000000010000c2fa	jb	0x10000c319
000000010000c2fc	movq	(%rdi), %rax
000000010000c2ff	movl	$0x65747962, %ecx               ## imm = 0x65747962
000000010000c304	xorl	(%rax,%r15), %ecx
000000010000c308	movzbl	0x4(%rax,%r15), %eax
000000010000c30e	xorl	$0x73, %eax
000000010000c311	orl	%ecx, %eax
000000010000c313	je	0x10000cb7a
000000010000c319	xorl	%edi, %edi
000000010000c31b	callq	_fwp_mem_free
000000010000c320	jmp	0x10000bdb8
000000010000c325	movq	%rbx, %r15
000000010000c328	movq	%rax, %rbx
000000010000c32b	leaq	-0x130(%rbp), %rsi
000000010000c332	movl	$0x100, %edx                    ## imm = 0x100
000000010000c337	callq	_tp_token
000000010000c33c	xorl	%r14d, %r14d
000000010000c33f	cmpq	$0x2, %rax
000000010000c343	jb	0x10000bdb8
000000010000c349	cmpb	$0x30, -0x130(%rbp)
000000010000c350	jne	0x10000bdb8
000000010000c356	cmpb	$0x74, -0x12f(%rbp)
000000010000c35d	jne	0x10000bdb8
000000010000c363	leaq	-0x2(%rax), %rcx
000000010000c367	movslq	0x48(%rbx), %rdx
000000010000c36b	cmpq	%rdx, %rcx
000000010000c36e	ja	0x10000bdb8
000000010000c374	cmpq	$0x3, %rax
000000010000c378	jb	0x10000cd66
000000010000c37e	movl	$0x2, %edx
000000010000c383	xorl	%ecx, %ecx
000000010000c385	movq	%r15, %rdi
000000010000c388	jmp	0x10000c5cb
000000010000c38d	leaq	-0x130(%rbp), %rsi
000000010000c394	movl	$0x10, %edx
000000010000c399	callq	_tp_token
000000010000c39e	movzwl	-0x130(%rbp), %eax
000000010000c3a5	movl	%eax, %ecx
000000010000c3a7	xorl	$0x312b, %ecx                   ## imm = 0x312B
000000010000c3ad	movzbl	-0x12e(%rbp), %edx
000000010000c3b4	orw	%cx, %dx
000000010000c3b7	sete	%cl
000000010000c3ba	cmpw	$0x31, %ax
000000010000c3be	sete	%dl
000000010000c3c1	orb	%cl, %dl
000000010000c3c3	movl	$0x1, %r14d
000000010000c3c9	jne	0x10000c3f6
000000010000c3cb	xorl	%r14d, %r14d
000000010000c3ce	cmpw	$0x30, %ax
000000010000c3d2	je	0x10000c3f6
000000010000c3d4	movl	$0x312d, %eax                   ## imm = 0x312D
000000010000c3d9	xorl	-0x130(%rbp), %eax
000000010000c3df	movzbl	-0x12e(%rbp), %ecx
000000010000c3e6	orw	%ax, %cx
000000010000c3e9	jne	0x10000bdb8
000000010000c3ef	movq	$-0x1, %r14
000000010000c3f6	movq	%r14, (%rbx)
000000010000c3f9	jmp	0x10000bdb2
000000010000c3fe	movq	0x8(%rax), %r13
000000010000c402	testq	%r13, %r13
000000010000c405	movq	%rbx, -0x1e8(%rbp)
000000010000c40c	je	0x10000c6a2
000000010000c412	movq	%rsi, %rbx
000000010000c415	movq	%rdi, -0x1c8(%rbp)
000000010000c41c	movq	%rax, -0x1d0(%rbp)
000000010000c423	leaq	0x703b(%rip), %rsi              ## literal pool for: "Duration"
000000010000c42a	movq	%r13, %rdi
000000010000c42d	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000c432	testl	%eax, %eax
000000010000c434	je	0x10000ca1e
000000010000c43a	movq	-0x1d0(%rbp), %rax
000000010000c441	movl	0x10(%rax), %r9d
000000010000c445	cmpq	%rbx, %r15
000000010000c448	movq	-0x1c8(%rbp), %rdx
000000010000c44f	movq	%r9, -0x1d8(%rbp)
000000010000c456	jae	0x10000c488
000000010000c458	movq	%rbx, %rcx
000000010000c45b	movq	(%rdx), %rsi
000000010000c45e	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
000000010000c468	movzbl	(%rsi,%r15), %r8d
000000010000c46d	cmpq	$0x20, %r8
000000010000c471	ja	0x10000c488
000000010000c473	btq	%r8, %rdi
000000010000c477	jae	0x10000c488
000000010000c479	incq	%r15
000000010000c47c	movq	%r15, 0x10(%rdx)
000000010000c480	cmpq	%r15, %rcx
000000010000c483	jne	0x10000c468
000000010000c485	movq	%rcx, %r15
000000010000c488	addq	$0x10, %rax
000000010000c48c	movq	%rax, -0x1c0(%rbp)
000000010000c493	movq	%r13, %rdi
000000010000c496	callq	0x100012136                     ## symbol stub for: _strlen
000000010000c49b	subq	%r15, %rbx
000000010000c49e	cmpq	%rax, %rbx
000000010000c4a1	jb	0x10000c4c6
000000010000c4a3	movq	%rax, %r12
000000010000c4a6	movq	-0x1c8(%rbp), %rax
000000010000c4ad	movq	(%rax), %rdi
000000010000c4b0	addq	%r15, %rdi
000000010000c4b3	movq	%r13, %rsi
000000010000c4b6	movq	%r12, %rdx
000000010000c4b9	callq	0x1000120b2                     ## symbol stub for: _memcmp
000000010000c4be	testl	%eax, %eax
000000010000c4c0	je	0x10000d0d8
000000010000c4c6	movq	-0x1d0(%rbp), %rax
000000010000c4cd	movq	-0x1c8(%rbp), %rdi
000000010000c4d4	movq	-0x1c0(%rbp), %r13
000000010000c4db	movq	-0x1d8(%rbp), %rcx
000000010000c4e2	movslq	%ecx, %rcx
000000010000c4e5	leaq	0x8(,%rcx,8), %rcx
000000010000c4ed	leaq	_fwp_gc(%rip), %r12
000000010000c4f4	cmpq	$0x4000, %rcx                   ## imm = 0x4000
000000010000c4fb	ja	0x10000cc76
000000010000c501	leaq	0xf(%rcx), %rdx
000000010000c505	shrq	$0x4, %rdx
000000010000c509	movzbl	0xbe8(%rdx,%r12), %edx
000000010000c512	movl	0xb48(%r12,%rdx,4), %esi
000000010000c51a	subq	%rsi, _fwp_gc(%rip)
000000010000c521	js	0x10000cc76
000000010000c527	leaq	(%rdx,%rdx,2), %rdx
000000010000c52b	leaq	(%r12,%rdx,8), %rdx
000000010000c52f	addq	$0x788, %rdx                    ## imm = 0x788
000000010000c536	movq	(%rdx), %r8
000000010000c539	testq	%r8, %r8
000000010000c53c	je	0x10000cc62
000000010000c542	movq	%rdi, %r15
000000010000c545	movq	%rax, %rbx
000000010000c548	movq	(%r8), %rax
000000010000c54b	notq	%rax
000000010000c54e	movq	%rax, (%rdx)
000000010000c551	movq	%r8, -0x1e0(%rbp)
000000010000c558	movq	%r8, %rdi
000000010000c55b	jmp	0x10000cd90
000000010000c560	movq	(%rdi), %r8
000000010000c563	cmpq	%rsi, %r15
000000010000c566	movq	%rdi, -0x1c8(%rbp)
000000010000c56d	movl	%edx, -0x1d8(%rbp)
000000010000c573	movq	%rbx, -0x1e8(%rbp)
000000010000c57a	jae	0x10000c5f5
000000010000c57c	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000c586	nopw	%cs:(%rax,%rax)
000000010000c590	movzbl	(%r8,%r15), %r9d
000000010000c595	cmpq	$0x20, %r9
000000010000c599	ja	0x10000c5f5
000000010000c59b	btq	%r9, %rcx
000000010000c59f	jae	0x10000c5f5
000000010000c5a1	incq	%r15
000000010000c5a4	movq	%r15, 0x10(%rdi)
000000010000c5a8	cmpq	%r15, %rsi
000000010000c5ab	jne	0x10000c590
000000010000c5ad	movq	%rax, %rbx
000000010000c5b0	movq	%rsi, %r15
000000010000c5b3	jmp	0x10000c86e
000000010000c5b8	leaq	(%rcx,%rcx,2), %rcx
000000010000c5bc	decq	%rcx
000000010000c5bf	incq	%rdx
000000010000c5c2	cmpq	%rdx, %rax
000000010000c5c5	je	0x10000cd70
000000010000c5cb	movzbl	-0x130(%rbp,%rdx), %esi
000000010000c5d3	cmpl	$0x30, %esi
000000010000c5d6	je	0x10000c5ef
000000010000c5d8	cmpl	$0x2d, %esi
000000010000c5db	je	0x10000c5b8
000000010000c5dd	cmpl	$0x2b, %esi
000000010000c5e0	jne	0x10000d50c
000000010000c5e6	leaq	(%rcx,%rcx,2), %rcx
000000010000c5ea	incq	%rcx
000000010000c5ed	jmp	0x10000c5bf
000000010000c5ef	leaq	(%rcx,%rcx,2), %rcx
000000010000c5f3	jmp	0x10000c5bf
000000010000c5f5	cmpq	%rsi, %r15
000000010000c5f8	jae	0x10000c7e5
000000010000c5fe	movabsq	$0x4000000000003, %r9           ## imm = 0x4000000000003
000000010000c608	movq	%r15, %rcx
000000010000c60b	jmp	0x10000c620
000000010000c60d	nopl	(%rax)
000000010000c610	incq	%rcx
000000010000c613	movq	%rcx, 0x10(%rdi)
000000010000c617	cmpq	%rcx, %rsi
000000010000c61a	je	0x10000c86b
000000010000c620	movzbl	(%r8,%rcx), %r10d
000000010000c625	leal	-0x30(%r10), %r11d
000000010000c629	cmpb	$0xa, %r11b
000000010000c62d	jb	0x10000c610
000000010000c62f	movl	%r10d, %r11d
000000010000c632	andb	$-0x21, %r11b
000000010000c636	addb	$-0x41, %r11b
000000010000c63a	cmpb	$0x1a, %r11b
000000010000c63e	jb	0x10000c610
000000010000c640	movzbl	%r10b, %r10d
000000010000c644	addl	$-0x2d, %r10d
000000010000c648	cmpl	$0x32, %r10d
000000010000c64c	ja	0x10000c654
000000010000c64e	btq	%r10, %r9
000000010000c652	jb	0x10000c610
000000010000c654	movq	%rax, %rbx
000000010000c657	jmp	0x10000c871
000000010000c65c	movl	$0x666e692d, %ecx               ## imm = 0x666E692D
000000010000c661	xorl	-0x130(%rbp), %ecx
000000010000c667	movzbl	-0x12c(%rbp), %esi
000000010000c66e	orl	%ecx, %esi
000000010000c670	movq	%rbx, %rcx
000000010000c673	je	0x10000cc3e
000000010000c679	cmpl	$0x4e614e, %edx                 ## imm = 0x4E614E
000000010000c67f	jne	0x10000cc95
000000010000c685	movsd	0x5c93(%rip), %xmm0
000000010000c68d	jmp	0x10000cc46
000000010000c692	movq	%r14, %rdi
000000010000c695	callq	_fwp_mem_free
000000010000c69a	xorl	%r14d, %r14d
000000010000c69d	jmp	0x10000bdb8
000000010000c6a2	movslq	0x10(%rax), %rcx
000000010000c6a6	testq	%rcx, %rcx
000000010000c6a9	je	0x10000cd10
000000010000c6af	leaq	0x10(%rax), %r13
000000010000c6b3	cmpl	$0x0, 0x48(%rax)
000000010000c6b7	je	0x10000c4e2
000000010000c6bd	movq	%r13, -0x1c0(%rbp)
000000010000c6c4	movq	%rax, %rbx
000000010000c6c7	shlq	$0x3, %rcx
000000010000c6cb	movq	%rdi, %r13
000000010000c6ce	movq	%rcx, %rdi
000000010000c6d1	callq	_fwp_alloc
000000010000c6d6	movq	%rax, -0x1d8(%rbp)
000000010000c6dd	leaq	0x6d9b(%rip), %rsi              ## literal pool for: "("
000000010000c6e4	movq	%r13, %r12
000000010000c6e7	movq	%r13, %rdi
000000010000c6ea	callq	_tp_eat
000000010000c6ef	testl	%eax, %eax
000000010000c6f1	je	0x10000bdb8
000000010000c6f7	movq	-0x1c0(%rbp), %rax
000000010000c6fe	cmpl	$0x0, (%rax)
000000010000c701	movq	%r12, %rdi
000000010000c704	jle	0x10000c7b1
000000010000c70a	xorl	%r13d, %r13d
000000010000c70d	movabsq	$0x100002600, %r15              ## imm = 0x100002600
000000010000c717	testq	%r13, %r13
000000010000c71a	je	0x10000c770
000000010000c71c	movq	0x8(%rdi), %rcx
000000010000c720	movq	0x10(%rdi), %rax
000000010000c724	cmpq	%rcx, %rax
000000010000c727	jae	0x10000c750
000000010000c729	movq	(%rdi), %rdx
000000010000c72c	movzbl	(%rdx,%rax), %esi
000000010000c730	cmpq	$0x20, %rsi
000000010000c734	ja	0x10000c750
000000010000c736	btq	%rsi, %r15
000000010000c73a	jae	0x10000c750
000000010000c73c	incq	%rax
000000010000c73f	movq	%rax, 0x10(%rdi)
000000010000c743	xorl	%r14d, %r14d
000000010000c746	cmpq	%rax, %rcx
000000010000c749	jne	0x10000c72c
000000010000c74b	jmp	0x10000bdb8
000000010000c750	xorl	%r14d, %r14d
000000010000c753	cmpq	%rax, %rcx
000000010000c756	je	0x10000bdb8
000000010000c75c	movq	(%rdi), %rcx
000000010000c75f	cmpb	$0x2c, (%rcx,%rax)
000000010000c763	jne	0x10000bdb8
000000010000c769	incq	%rax
000000010000c76c	movq	%rax, 0x10(%rdi)
000000010000c770	movq	0x20(%rbx), %rax
000000010000c774	movq	(%rax,%r13,8), %rsi
000000010000c778	movq	-0x1d8(%rbp), %rax
000000010000c77f	leaq	(%rax,%r13,8), %rcx
000000010000c783	xorl	%r14d, %r14d
000000010000c786	movq	%r12, %rdi
000000010000c789	xorl	%edx, %edx
000000010000c78b	callq	_tp_value
000000010000c790	testl	%eax, %eax
000000010000c792	je	0x10000bdb8
000000010000c798	movq	%r12, %rdi
000000010000c79b	incq	%r13
000000010000c79e	movq	-0x1c0(%rbp), %rax
000000010000c7a5	movslq	(%rax), %rax
000000010000c7a8	cmpq	%rax, %r13
000000010000c7ab	jl	0x10000c717
000000010000c7b1	leaq	0x6cc9(%rip), %rsi              ## literal pool for: ")"
000000010000c7b8	callq	_tp_eat
000000010000c7bd	movl	$0x0, %r14d
000000010000c7c3	testl	%eax, %eax
000000010000c7c5	je	0x10000bdb8
000000010000c7cb	movq	-0x1c0(%rbp), %rax
000000010000c7d2	movl	(%rax), %edi
000000010000c7d4	movq	-0x1d8(%rbp), %rsi
000000010000c7db	callq	_fwp_record
000000010000c7e0	jmp	0x10000d1b2
000000010000c7e5	movq	%rax, %rbx
000000010000c7e8	movq	%r15, %rcx
000000010000c7eb	jmp	0x10000c871
000000010000c7f0	xorl	%eax, %eax
000000010000c7f2	movq	%rax, %rbx
000000010000c7f5	movq	-0x120(%rbp), %rdi
000000010000c7fc	callq	_fwp_mem_free
000000010000c801	movq	-0x1d0(%rbp), %rax
000000010000c808	cmpl	$0x11, (%rax)
000000010000c80b	jne	0x10000c863
000000010000c80d	movq	0x38(%rax), %r14
000000010000c811	testq	%rbx, %rbx
000000010000c814	je	0x10000cd4a
000000010000c81a	movq	%rbx, %rax
000000010000c81d	xorl	%edi, %edi
000000010000c81f	nop
000000010000c820	incq	%rdi
000000010000c823	movq	0x10(%rax), %rax
000000010000c827	testq	%rax, %rax
000000010000c82a	jne	0x10000c820
000000010000c82c	movq	%r14, %rsi
000000010000c82f	callq	_fwp_array_new_packed
000000010000c834	movq	%rax, %r15
000000010000c837	xorl	%r12d, %r12d
000000010000c83a	movq	%rbx, %r13
000000010000c83d	nopl	(%rax)
000000010000c840	movq	0x8(%r13), %rdx
000000010000c844	movq	%r15, %rdi
000000010000c847	movq	%r12, %rsi
000000010000c84a	movq	%r14, %rcx
000000010000c84d	callq	_fwp_array_store
000000010000c852	incq	%r12
000000010000c855	movq	0x10(%r13), %r13
000000010000c859	testq	%r13, %r13
000000010000c85c	jne	0x10000c840
000000010000c85e	jmp	0x10000cd57
000000010000c863	movq	%rbx, %r15
000000010000c866	jmp	0x10000cd57
000000010000c86b	movq	%rax, %rbx
000000010000c86e	movq	%rsi, %rcx
000000010000c871	subq	%r15, %rcx
000000010000c874	cmpq	$0xff, %rcx
000000010000c87b	movl	$0xff, %r14d
000000010000c881	cmovbq	%rcx, %r14
000000010000c885	addq	%r15, %r8
000000010000c888	leaq	-0x130(%rbp), %rdi
000000010000c88f	movl	$0x100, %ecx                    ## imm = 0x100
000000010000c894	movq	%r8, %rsi
000000010000c897	movq	%r14, %rdx
000000010000c89a	callq	0x10001200a                     ## symbol stub for: ___memcpy_chk
000000010000c89f	movb	$0x0, -0x130(%rbp,%r14)
000000010000c8a8	movslq	0x10(%rbx), %r12
000000010000c8ac	testq	%r12, %r12
000000010000c8af	movq	%rbx, -0x1d0(%rbp)
000000010000c8b6	jle	0x10000c8ed
000000010000c8b8	movq	0x18(%rbx), %r13
000000010000c8bc	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c8c1	xorl	%r15d, %r15d
000000010000c8c4	leaq	-0x130(%rbp), %r14
000000010000c8cb	nopl	(%rax,%rax)
000000010000c8d0	movq	(%r13,%r15,8), %rdi
000000010000c8d5	movq	%r14, %rsi
000000010000c8d8	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000c8dd	testl	%eax, %eax
000000010000c8df	cmovel	%r15d, %ebx
000000010000c8e3	incq	%r15
000000010000c8e6	cmpq	%r15, %r12
000000010000c8e9	jne	0x10000c8d0
000000010000c8eb	jmp	0x10000c8f2
000000010000c8ed	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c8f2	cmpl	$0x0, -0x1d8(%rbp)
000000010000c8f9	je	0x10000c976
000000010000c8fb	testl	%ebx, %ebx
000000010000c8fd	movq	-0x1c8(%rbp), %r13
000000010000c904	jns	0x10000c96d
000000010000c906	movq	-0x1d0(%rbp), %rax
000000010000c90d	movq	0x8(%rax), %rdi
000000010000c911	xorl	%r14d, %r14d
000000010000c914	testq	%rdi, %rdi
000000010000c917	je	0x10000bdb8
000000010000c91d	leaq	0x6b13(%rip), %rsi              ## literal pool for: "Bool"
000000010000c924	movq	%rax, %r12
000000010000c927	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000c92c	testl	%eax, %eax
000000010000c92e	jne	0x10000bdb8
000000010000c934	movq	%r12, %rdx
000000010000c937	movl	-0x130(%rbp), %eax
000000010000c93d	movl	%eax, %esi
000000010000c93f	xorl	$0x65757274, %esi               ## imm = 0x65757274
000000010000c945	movzbl	-0x12c(%rbp), %edi
000000010000c94c	orl	%esi, %edi
000000010000c94e	movl	$0x1, %esi
000000010000c953	cmovel	%esi, %ebx
000000010000c956	xorl	$0x736c6166, %eax               ## imm = 0x736C6166
000000010000c95b	movzwl	-0x12c(%rbp), %esi
000000010000c962	xorl	$0x65, %esi
000000010000c965	orl	%eax, %esi
000000010000c967	jne	0x10000c984
000000010000c969	xorl	%ebx, %ebx
000000010000c96b	jmp	0x10000c98c
000000010000c96d	movq	-0x1d0(%rbp), %rdx
000000010000c974	jmp	0x10000c984
000000010000c976	movq	-0x1d0(%rbp), %rdx
000000010000c97d	movq	-0x1c8(%rbp), %r13
000000010000c984	testl	%ebx, %ebx
000000010000c986	js	0x10000d50c
000000010000c98c	movq	0x28(%rdx), %rax
000000010000c990	movl	%ebx, %esi
000000010000c992	movq	%rsi, -0x1d8(%rbp)
000000010000c999	movslq	(%rax,%rsi,4), %r15
000000010000c99d	movl	%r15d, %r9d
000000010000c9a0	leaq	0x8(,%r15,8), %rdi
000000010000c9a8	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000c9af	movq	%r9, -0x1e0(%rbp)
000000010000c9b6	ja	0x10000ccf7
000000010000c9bc	leaq	0xf(%rdi), %rsi
000000010000c9c0	shrq	$0x4, %rsi
000000010000c9c4	leaq	_fwp_gc(%rip), %rax
000000010000c9cb	movzbl	0xbe8(%rsi,%rax), %r8d
000000010000c9d4	movl	0xb48(%rax,%r8,4), %esi
000000010000c9dc	subq	%rsi, _fwp_gc(%rip)
000000010000c9e3	js	0x10000ccf7
000000010000c9e9	leaq	(%r8,%r8,2), %r8
000000010000c9ed	leaq	(%rax,%r8,8), %rax
000000010000c9f1	addq	$0x788, %rax                    ## imm = 0x788
000000010000c9f7	movq	(%rax), %r8
000000010000c9fa	testq	%r8, %r8
000000010000c9fd	je	0x10000cce3
000000010000ca03	movq	%rdx, %r14
000000010000ca06	movq	(%r8), %rcx
000000010000ca09	notq	%rcx
000000010000ca0c	movq	%rcx, (%rax)
000000010000ca0f	movq	%r8, -0x1c0(%rbp)
000000010000ca16	movq	%r8, %rdi
000000010000ca19	jmp	0x10000cf26
000000010000ca1e	leaq	-0x130(%rbp), %rsi
000000010000ca25	movl	$0x80, %edx
000000010000ca2a	movq	-0x1c8(%rbp), %rdi
000000010000ca31	callq	_tp_token
000000010000ca36	movq	%rax, %r14
000000010000ca39	addq	%rbp, %rax
000000010000ca3c	addq	$-0x130, %rax                   ## imm = 0xFED0
000000010000ca42	movq	%rax, -0x1d0(%rbp)
000000010000ca49	xorl	%ebx, %ebx
000000010000ca4b	jmp	0x10000ca5a
000000010000ca4d	incq	%rbx
000000010000ca50	cmpq	$0x6, %rbx
000000010000ca54	je	0x10000d50c
000000010000ca5a	movq	%rbx, %r12
000000010000ca5d	shlq	$0x4, %r12
000000010000ca61	leaq	_tp_value.units(%rip), %rax
000000010000ca68	movq	(%r12,%rax), %r15
000000010000ca6c	movq	%r15, %rdi
000000010000ca6f	callq	0x100012136                     ## symbol stub for: _strlen
000000010000ca74	movq	%r14, %r13
000000010000ca77	subq	%rax, %r13
000000010000ca7a	jbe	0x10000ca4d
000000010000ca7c	movq	-0x1d0(%rbp), %rdi
000000010000ca83	subq	%rax, %rdi
000000010000ca86	movq	%r15, %rsi
000000010000ca89	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000ca8e	testl	%eax, %eax
000000010000ca90	jne	0x10000ca4d
000000010000ca92	leaq	_tp_value.units(%rip), %rax
000000010000ca99	addq	%rax, %r12
000000010000ca9c	movl	$0x80, %ecx
000000010000caa1	leaq	-0x1b0(%rbp), %rdi
000000010000caa8	leaq	-0x130(%rbp), %rsi
000000010000caaf	movq	%r13, %rdx
000000010000cab2	callq	0x10001200a                     ## symbol stub for: ___memcpy_chk
000000010000cab7	movb	$0x0, -0x1b0(%rbp,%r13)
000000010000cac0	movzbl	-0x1b0(%rbp), %esi
000000010000cac7	leal	-0x2b(%rsi), %eax
000000010000caca	xorl	%ecx, %ecx
000000010000cacc	testb	$-0x3, %al
000000010000cace	sete	%cl
000000010000cad1	cmpq	%rcx, %r13
000000010000cad4	je	0x10000ca4d
000000010000cada	jbe	0x10000caf8
000000010000cadc	movzbl	-0x1b0(%rbp,%rcx), %edx
000000010000cae4	addb	$-0x3a, %dl
000000010000cae7	cmpb	$-0xa, %dl
000000010000caea	jb	0x10000ca4d
000000010000caf0	incq	%rcx
000000010000caf3	cmpq	%rcx, %r13
000000010000caf6	jne	0x10000cadc
000000010000caf8	xorl	%ecx, %ecx
000000010000cafa	testb	$-0x3, %al
000000010000cafc	sete	%cl
000000010000caff	movzbl	-0x1b0(%rbp,%rcx), %r10d
000000010000cb08	xorl	%r14d, %r14d
000000010000cb0b	testb	%r10b, %r10b
000000010000cb0e	je	0x10000d114
000000010000cb14	leaq	-0x1b0(%rbp), %rax
000000010000cb1b	addq	%rax, %rcx
000000010000cb1e	incq	%rcx
000000010000cb21	xorl	%eax, %eax
000000010000cb23	movl	$0xa, %edi
000000010000cb28	movabsq	$-0x8000000000000000, %r9       ## imm = 0x8000000000000000
000000010000cb32	xorl	%r8d, %r8d
000000010000cb35	mulq	%rdi
000000010000cb38	leaq	(%r8,%r8,4), %r8
000000010000cb3c	leaq	(%rdx,%r8,2), %rdx
000000010000cb40	movsbl	%r10b, %r8d
000000010000cb44	addl	$-0x30, %r8d
000000010000cb48	movslq	%r8d, %r10
000000010000cb4b	movq	%r10, %r8
000000010000cb4e	sarq	$0x3f, %r8
000000010000cb52	addq	%r10, %rax
000000010000cb55	adcq	%rdx, %r8
000000010000cb58	cmpq	%rax, %r9
000000010000cb5b	movl	$0x0, %edx
000000010000cb60	sbbq	%r8, %rdx
000000010000cb63	jl	0x10000d50c
000000010000cb69	movzbl	(%rcx), %r10d
000000010000cb6d	incq	%rcx
000000010000cb70	testb	%r10b, %r10b
000000010000cb73	jne	0x10000cb35
000000010000cb75	jmp	0x10000d119
000000010000cb7a	addq	$0x5, %r15
000000010000cb7e	movq	%r15, 0x10(%rdi)
000000010000cb82	leaq	0x68c0(%rip), %rsi              ## literal pool for: "["
000000010000cb89	leaq	0x68bb(%rip), %rdx              ## literal pool for: "]"
000000010000cb90	leaq	_tp_byte_item(%rip), %rcx
000000010000cb97	leaq	-0x130(%rbp), %r8
000000010000cb9e	callq	_tp_list_of
000000010000cba3	testl	%eax, %eax
000000010000cba5	je	0x10000cc2d
000000010000cbab	movq	%rbx, %r12
000000010000cbae	pxor	%xmm0, %xmm0
000000010000cbb2	movdqa	%xmm0, -0x1b0(%rbp)
000000010000cbba	movq	$0x0, -0x1a0(%rbp)
000000010000cbc5	cmpq	$0x0, -0x118(%rbp)
000000010000cbcd	je	0x10000cc0c
000000010000cbcf	xorl	%ebx, %ebx
000000010000cbd1	leaq	-0x1b0(%rbp), %r14
000000010000cbd8	leaq	-0x1b8(%rbp), %r15
000000010000cbdf	movq	-0x120(%rbp), %rax
000000010000cbe6	movzbl	(%rax,%rbx,8), %eax
000000010000cbea	movb	%al, -0x1b8(%rbp)
000000010000cbf0	movl	$0x1, %edx
000000010000cbf5	movq	%r14, %rdi
000000010000cbf8	movq	%r15, %rsi
000000010000cbfb	callq	_buf_put
000000010000cc00	incq	%rbx
000000010000cc03	cmpq	-0x118(%rbp), %rbx
000000010000cc0a	jb	0x10000cbdf
000000010000cc0c	movq	-0x120(%rbp), %rdi
000000010000cc13	callq	_fwp_mem_free
000000010000cc18	leaq	-0x1b0(%rbp), %rdi
000000010000cc1f	callq	_buf_to_str
000000010000cc24	movq	%rax, (%r12)
000000010000cc28	jmp	0x10000bdb2
000000010000cc2d	movq	-0x120(%rbp), %rdi
000000010000cc34	callq	_fwp_mem_free
000000010000cc39	jmp	0x10000bdb8
000000010000cc3e	movsd	0x56d2(%rip), %xmm0
000000010000cc46	cmpl	$0xa, (%rcx)
000000010000cc49	cvtsd2ss	%xmm0, %xmm1
000000010000cc4d	movd	%xmm1, %ecx
000000010000cc51	movq	%xmm0, %rax
000000010000cc56	cmoveq	%rcx, %rax
000000010000cc5a	movq	%rax, (%r15)
000000010000cc5d	jmp	0x10000bdb2
000000010000cc62	movq	0x8(%rdx), %r9
000000010000cc66	movq	0x10(%rdx), %r8
000000010000cc6a	subq	%r9, %r8
000000010000cc6d	cmpq	%rsi, %r8
000000010000cc70	jae	0x10000cd78
000000010000cc76	movq	%rdi, %r15
000000010000cc79	movq	%rax, %rbx
000000010000cc7c	movq	%rcx, %rdi
000000010000cc7f	movl	$0x2, %esi
000000010000cc84	callq	_fwp_gc_alloc_slow
000000010000cc89	movq	%rax, -0x1e0(%rbp)
000000010000cc90	jmp	0x10000cd95
000000010000cc95	testq	%rax, %rax
000000010000cc98	setne	%sil
000000010000cc9c	addb	$-0x2b, %dl
000000010000cc9f	testb	$-0x3, %dl
000000010000cca2	sete	%dl
000000010000cca5	andb	%sil, %dl
000000010000cca8	movzbl	%dl, %esi
000000010000ccab	movb	$0x1, %r8b
000000010000ccae	movq	%rsi, %rdi
000000010000ccb1	cmpq	%rsi, %rax
000000010000ccb4	jbe	0x10000cf09
000000010000ccba	movzbl	-0x130(%rbp,%rdi), %edx
000000010000ccc2	leal	-0x30(%rdx), %r9d
000000010000ccc6	cmpb	$0x9, %r9b
000000010000ccca	ja	0x10000d1c1
000000010000ccd0	incq	%rdi
000000010000ccd3	cmpq	%rdi, %rax
000000010000ccd6	jne	0x10000ccba
000000010000ccd8	movq	%rax, %rdi
000000010000ccdb	movq	%rax, %rdx
000000010000ccde	jmp	0x10000d517
000000010000cce3	movq	0x8(%rax), %r10
000000010000cce7	movq	0x10(%rax), %r8
000000010000cceb	subq	%r10, %r8
000000010000ccee	cmpq	%rsi, %r8
000000010000ccf1	jae	0x10000cf11
000000010000ccf7	movq	%rdx, %r14
000000010000ccfa	movl	$0x2, %esi
000000010000ccff	callq	_fwp_gc_alloc_slow
000000010000cd04	movq	%rax, -0x1c0(%rbp)
000000010000cd0b	jmp	0x10000cf2b
000000010000cd10	leaq	0x6768(%rip), %rsi              ## literal pool for: "("
000000010000cd17	movq	%rdi, %r15
000000010000cd1a	callq	_tp_eat
000000010000cd1f	testl	%eax, %eax
000000010000cd21	je	0x10000bdb8
000000010000cd27	leaq	0x6753(%rip), %rsi              ## literal pool for: ")"
000000010000cd2e	movq	%r15, %rdi
000000010000cd31	callq	_tp_eat
000000010000cd36	testl	%eax, %eax
000000010000cd38	je	0x10000bdb8
000000010000cd3e	movq	$0x0, (%rbx)
000000010000cd45	jmp	0x10000bdb2
000000010000cd4a	xorl	%edi, %edi
000000010000cd4c	movq	%r14, %rsi
000000010000cd4f	callq	_fwp_array_new_packed
000000010000cd54	movq	%rax, %r15
000000010000cd57	movq	-0x1e8(%rbp), %rax
000000010000cd5e	movq	%r15, (%rax)
000000010000cd61	jmp	0x10000bdb2
000000010000cd66	xorl	%ecx, %ecx
000000010000cd68	movq	%rcx, (%r15)
000000010000cd6b	jmp	0x10000bdb2
000000010000cd70	movq	%rcx, (%rdi)
000000010000cd73	jmp	0x10000bdb2
000000010000cd78	movq	%rdi, %r15
000000010000cd7b	movq	%rax, %rbx
000000010000cd7e	leaq	(%r9,%rsi), %rax
000000010000cd82	movq	%rax, 0x8(%rdx)
000000010000cd86	movq	%r9, -0x1e0(%rbp)
000000010000cd8d	movq	%r9, %rdi
000000010000cd90	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000cd95	movslq	(%r13), %rax
000000010000cd99	leaq	0x1(%rax), %rsi
000000010000cd9d	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000cda4	ja	0x10000cdfb
000000010000cda6	addq	$0x10, %rax
000000010000cdaa	shrq	$0x4, %rax
000000010000cdae	movzbl	0xbe8(%rax,%r12), %ecx
000000010000cdb7	movl	0xb48(%r12,%rcx,4), %eax
000000010000cdbf	subq	%rax, _fwp_gc(%rip)
000000010000cdc6	js	0x10000cdfb
000000010000cdc8	leaq	(%rcx,%rcx,2), %rcx
000000010000cdcc	leaq	(%r12,%rcx,8), %rcx
000000010000cdd0	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000cdd7	movq	(%rcx), %r12
000000010000cdda	testq	%r12, %r12
000000010000cddd	je	0x10000cdeb
000000010000cddf	movq	(%r12), %rax
000000010000cde3	notq	%rax
000000010000cde6	movq	%rax, (%rcx)
000000010000cde9	jmp	0x10000ce14
000000010000cdeb	movq	0x8(%rcx), %r12
000000010000cdef	movq	0x10(%rcx), %rdx
000000010000cdf3	subq	%r12, %rdx
000000010000cdf6	cmpq	%rax, %rdx
000000010000cdf9	jae	0x10000ce0d
000000010000cdfb	movq	%rsi, %rdi
000000010000cdfe	movl	$0x1, %esi
000000010000ce03	callq	_fwp_gc_alloc_slow
000000010000ce08	movq	%rax, %r12
000000010000ce0b	jmp	0x10000ce1c
000000010000ce0d	addq	%r12, %rax
000000010000ce10	movq	%rax, 0x8(%rcx)
000000010000ce14	movq	%r12, %rdi
000000010000ce17	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000ce1c	movslq	(%r13), %rsi
000000010000ce20	incq	%rsi
000000010000ce23	movq	%r12, %rdi
000000010000ce26	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000ce2b	movq	0x8(%r15), %rcx
000000010000ce2f	movq	0x10(%r15), %rax
000000010000ce33	cmpq	%rcx, %rax
000000010000ce36	jae	0x10000ce66
000000010000ce38	movq	(%r15), %rdx
000000010000ce3b	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000ce45	movzbl	(%rdx,%rax), %edi
000000010000ce49	cmpq	$0x20, %rdi
000000010000ce4d	ja	0x10000ce66
000000010000ce4f	btq	%rdi, %rsi
000000010000ce53	jae	0x10000ce66
000000010000ce55	incq	%rax
000000010000ce58	movq	%rax, 0x10(%r15)
000000010000ce5c	cmpq	%rax, %rcx
000000010000ce5f	jne	0x10000ce45
000000010000ce61	jmp	0x10000bdb8
000000010000ce66	cmpq	%rax, %rcx
000000010000ce69	je	0x10000bdb8
000000010000ce6f	movq	%r13, -0x1c0(%rbp)
000000010000ce76	movq	(%r15), %rcx
000000010000ce79	cmpb	$0x7b, (%rcx,%rax)
000000010000ce7d	jne	0x10000bdb8
000000010000ce83	incq	%rax
000000010000ce86	movq	%rax, 0x10(%r15)
000000010000ce8a	leaq	0x65d2(%rip), %rsi              ## literal pool for: "}"
000000010000ce91	movq	%r15, -0x1c8(%rbp)
000000010000ce98	movq	%r15, %rdi
000000010000ce9b	callq	_tp_eat
000000010000cea0	testl	%eax, %eax
000000010000cea2	je	0x10000d2a2
000000010000cea8	movq	-0x1c0(%rbp), %rax
000000010000ceaf	movslq	(%rax), %rdi
000000010000ceb2	testq	%rdi, %rdi
000000010000ceb5	movq	-0x1e8(%rbp), %rbx
000000010000cebc	movq	-0x1e0(%rbp), %rsi
000000010000cec3	jle	0x10000cedd
000000010000cec5	xorl	%r14d, %r14d
000000010000cec8	xorl	%eax, %eax
000000010000ceca	cmpb	$0x0, (%r12,%rax)
000000010000cecf	je	0x10000bdb8
000000010000ced5	incq	%rax
000000010000ced8	cmpq	%rax, %rdi
000000010000cedb	jne	0x10000ceca
000000010000cedd	callq	_fwp_record
000000010000cee2	movq	%rax, (%rbx)
000000010000cee5	jmp	0x10000bdb2
000000010000ceea	leaq	_fwp_empty_map(%rip), %rax
000000010000cef1	movq	-0x120(%rbp), %rdi
000000010000cef8	movq	%rax, %rbx
000000010000cefb	callq	_fwp_mem_free
000000010000cf00	movq	%rbx, (%r12)
000000010000cf04	jmp	0x10000bdb2
000000010000cf09	movq	%rsi, %rdx
000000010000cf0c	jmp	0x10000d517
000000010000cf11	movq	%rdx, %r14
000000010000cf14	leaq	(%r10,%rsi), %rcx
000000010000cf18	movq	%rcx, 0x8(%rax)
000000010000cf1c	movq	%r10, -0x1c0(%rbp)
000000010000cf23	movq	%r10, %rdi
000000010000cf26	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000cf2b	movq	%r15, -0x1f0(%rbp)
000000010000cf32	testl	%r15d, %r15d
000000010000cf35	jle	0x10000d090
000000010000cf3b	movq	%r14, %rax
000000010000cf3e	xorl	%r15d, %r15d
000000010000cf41	movabsq	$0x100002600, %r12              ## imm = 0x100002600
000000010000cf4b	movq	0x30(%rax), %rcx
000000010000cf4f	movq	-0x1d8(%rbp), %rdx
000000010000cf56	movq	(%rcx,%rdx,8), %rcx
000000010000cf5a	movq	(%rcx,%r15,8), %rsi
000000010000cf5e	movq	0x8(%r13), %rdi
000000010000cf62	movq	0x10(%r13), %rdx
000000010000cf66	cmpq	%rdi, %rdx
000000010000cf69	jae	0x10000cf90
000000010000cf6b	movq	(%r13), %rcx
000000010000cf6f	nop
000000010000cf70	movzbl	(%rcx,%rdx), %r8d
000000010000cf75	cmpq	$0x20, %r8
000000010000cf79	ja	0x10000cf90
000000010000cf7b	btq	%r8, %r12
000000010000cf7f	jae	0x10000cf90
000000010000cf81	incq	%rdx
000000010000cf84	movq	%rdx, 0x10(%r13)
000000010000cf88	cmpq	%rdx, %rdi
000000010000cf8b	jne	0x10000cf70
000000010000cf8d	movq	%rdi, %rdx
000000010000cf90	cmpl	$0x10, (%rsi)
000000010000cf93	jne	0x10000cfa0
000000010000cf95	cmpq	$0x0, 0x8(%rsi)
000000010000cf9a	je	0x10000d052
000000010000cfa0	xorl	%r8d, %r8d
000000010000cfa3	movq	-0x1c0(%rbp), %rax
000000010000cfaa	leaq	(%rax,%r15,8), %rcx
000000010000cfae	cmpq	%rdi, %rdx
000000010000cfb1	jae	0x10000cfc5
000000010000cfb3	movq	(%r13), %rax
000000010000cfb7	cmpb	$0x28, (%rax,%rdx)
000000010000cfbb	setne	%al
000000010000cfbe	orb	%r8b, %al
000000010000cfc1	testb	$0x1, %al
000000010000cfc3	je	0x10000cff6
000000010000cfc5	xorl	%r14d, %r14d
000000010000cfc8	movq	%r13, %rdi
000000010000cfcb	xorl	%edx, %edx
000000010000cfcd	callq	_tp_value
000000010000cfd2	testl	%eax, %eax
000000010000cfd4	movq	-0x1d0(%rbp), %rax
000000010000cfdb	je	0x10000bdb8
000000010000cfe1	incq	%r15
000000010000cfe4	cmpq	-0x1e0(%rbp), %r15
000000010000cfeb	jne	0x10000cf4b
000000010000cff1	jmp	0x10000d090
000000010000cff6	incq	%rdx
000000010000cff9	movq	%rdx, 0x10(%r13)
000000010000cffd	xorl	%r14d, %r14d
000000010000d000	movq	%r13, %rdi
000000010000d003	xorl	%edx, %edx
000000010000d005	callq	_tp_value
000000010000d00a	testl	%eax, %eax
000000010000d00c	je	0x10000bdb8
000000010000d012	movq	-0x1c8(%rbp), %r13
000000010000d019	movq	0x8(%r13), %rdx
000000010000d01d	movq	0x10(%r13), %rcx
000000010000d021	cmpq	%rdx, %rcx
000000010000d024	movq	-0x1d0(%rbp), %rax
000000010000d02b	jae	0x10000d065
000000010000d02d	movq	(%r13), %rsi
000000010000d031	movzbl	(%rsi,%rcx), %edi
000000010000d035	cmpq	$0x20, %rdi
000000010000d039	ja	0x10000d065
000000010000d03b	btq	%rdi, %r12
000000010000d03f	jae	0x10000d065
000000010000d041	incq	%rcx
000000010000d044	movq	%rcx, 0x10(%r13)
000000010000d048	cmpq	%rcx, %rdx
000000010000d04b	jne	0x10000d031
000000010000d04d	jmp	0x10000bdb8
000000010000d052	cmpl	$0x0, 0x10(%rsi)
000000010000d056	je	0x10000d088
000000010000d058	cmpl	$0x0, 0x48(%rsi)
000000010000d05c	setne	%r8b
000000010000d060	jmp	0x10000cfa3
000000010000d065	cmpq	%rcx, %rdx
000000010000d068	je	0x10000bdb8
000000010000d06e	movq	(%r13), %rdx
000000010000d072	cmpb	$0x29, (%rdx,%rcx)
000000010000d076	jne	0x10000bdb8
000000010000d07c	incq	%rcx
000000010000d07f	movq	%rcx, 0x10(%r13)
000000010000d083	jmp	0x10000cfe1
000000010000d088	movb	$0x1, %r8b
000000010000d08b	jmp	0x10000cfa3
000000010000d090	movq	-0x1f0(%rbp), %r15
000000010000d097	testl	%r15d, %r15d
000000010000d09a	movq	-0x1d8(%rbp), %rdi
000000010000d0a1	je	0x10000d293
000000010000d0a7	movq	-0x1e0(%rbp), %r14
000000010000d0ae	leaq	0x8(,%r14,8), %rdi
000000010000d0b6	callq	_fwp_alloc_init
000000010000d0bb	movq	%rax, %rdi
000000010000d0be	movl	%ebx, (%rax)
000000010000d0c0	movl	%r15d, 0x4(%rax)
000000010000d0c4	cmpl	$0x7, %r15d
000000010000d0c8	ja	0x10000d0f2
000000010000d0ca	xorl	%eax, %eax
000000010000d0cc	movq	-0x1c0(%rbp), %r8
000000010000d0d3	jmp	0x10000d23a
000000010000d0d8	addq	%r12, %r15
000000010000d0db	movq	-0x1c8(%rbp), %rdi
000000010000d0e2	movq	%r15, 0x10(%rdi)
000000010000d0e6	movq	-0x1d0(%rbp), %rax
000000010000d0ed	jmp	0x10000c4d4
000000010000d0f2	movq	%rdi, %rax
000000010000d0f5	movq	-0x1c0(%rbp), %r8
000000010000d0fc	subq	%r8, %rax
000000010000d0ff	addq	$0x8, %rax
000000010000d103	cmpq	$0x20, %rax
000000010000d107	jae	0x10000d201
000000010000d10d	xorl	%eax, %eax
000000010000d10f	jmp	0x10000d23a
000000010000d114	xorl	%eax, %eax
000000010000d116	xorl	%r8d, %r8d
000000010000d119	movq	%rax, %rcx
000000010000d11c	negq	%rcx
000000010000d11f	movl	$0x0, %edi
000000010000d124	sbbq	%r8, %rdi
000000010000d127	cmpb	$0x2d, %sil
000000010000d12b	cmovneq	%r8, %rdi
000000010000d12f	cmovneq	%rax, %rcx
000000010000d133	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000d13d	cmpq	%rcx, %rax
000000010000d140	movl	$0x0, %eax
000000010000d145	sbbq	%rdi, %rax
000000010000d148	jl	0x10000bdb8
000000010000d14e	movq	0x8(%r12), %rsi
000000010000d153	movq	%rcx, %rax
000000010000d156	mulq	%rsi
000000010000d159	imulq	%rsi, %rdi
000000010000d15d	sarq	$0x3f, %rsi
000000010000d161	imulq	%rcx, %rsi
000000010000d165	addq	%rdx, %rsi
000000010000d168	addq	%rsi, %rdi
000000010000d16b	movabsq	$-0x8000000000000000, %rcx      ## imm = 0x8000000000000000
000000010000d175	addq	%rax, %rcx
000000010000d178	adcq	$-0x1, %rdi
000000010000d17c	cmpq	$-0x1, %rdi
000000010000d180	jne	0x10000bdb8
000000010000d186	movq	%rax, -0x1b8(%rbp)
000000010000d18d	movl	$0x10, %edi
000000010000d192	movq	%rax, %rbx
000000010000d195	callq	_fwp_alloc_init
000000010000d19a	movabsq	$__mh_execute_header, %rcx
000000010000d1a4	movq	%rcx, (%rax)
000000010000d1a7	movq	%rbx, 0x8(%rax)
000000010000d1ab	leaq	-0x1b8(%rbp), %rcx
000000010000d1b2	movq	-0x1e8(%rbp), %rcx
000000010000d1b9	movq	%rax, (%rcx)
000000010000d1bc	jmp	0x10000bdb2
000000010000d1c1	cmpb	$0x2e, %dl
000000010000d1c4	jne	0x10000d514
000000010000d1ca	leaq	0x1(%rdi), %rdx
000000010000d1ce	cmpq	%rax, %rdx
000000010000d1d1	jae	0x10000d1f1
000000010000d1d3	movzbl	-0x130(%rbp,%rdx), %r8d
000000010000d1dc	addb	$-0x30, %r8b
000000010000d1e0	cmpb	$0x9, %r8b
000000010000d1e4	ja	0x10000d1f1
000000010000d1e6	incq	%rdx
000000010000d1e9	cmpq	%rax, %rdx
000000010000d1ec	jb	0x10000d1d3
000000010000d1ee	movq	%rax, %rdx
000000010000d1f1	leaq	-0x1(%rdx), %r8
000000010000d1f5	cmpq	%rdi, %r8
000000010000d1f8	sete	%r8b
000000010000d1fc	jmp	0x10000d517
000000010000d201	movl	%r14d, %eax
000000010000d204	andl	$-0x4, %eax
000000010000d207	leaq	(,%r14,8), %rcx
000000010000d20f	andq	$-0x20, %rcx
000000010000d213	xorl	%edx, %edx
000000010000d215	movdqu	(%r8,%rdx), %xmm0
000000010000d21b	movups	0x10(%r8,%rdx), %xmm1
000000010000d221	movdqu	%xmm0, 0x8(%rdi,%rdx)
000000010000d227	movups	%xmm1, 0x18(%rdi,%rdx)
000000010000d22c	addq	$0x20, %rdx
000000010000d230	cmpq	%rdx, %rcx
000000010000d233	jne	0x10000d215
000000010000d235	cmpl	%r14d, %eax
000000010000d238	je	0x10000d293
000000010000d23a	movq	%r14, %rdx
000000010000d23d	movq	%rax, %rcx
000000010000d240	andq	$0x3, %rdx
000000010000d244	je	0x10000d25a
000000010000d246	movq	%rax, %rcx
000000010000d249	movq	(%r8,%rcx,8), %rsi
000000010000d24d	movq	%rsi, 0x8(%rdi,%rcx,8)
000000010000d252	incq	%rcx
000000010000d255	decq	%rdx
000000010000d258	jne	0x10000d249
000000010000d25a	subq	%r14, %rax
000000010000d25d	cmpq	$-0x4, %rax
000000010000d261	ja	0x10000d293
000000010000d263	movq	(%r8,%rcx,8), %rax
000000010000d267	movq	%rax, 0x8(%rdi,%rcx,8)
000000010000d26c	movq	0x8(%r8,%rcx,8), %rax
000000010000d271	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000d276	movq	0x10(%r8,%rcx,8), %rax
000000010000d27b	movq	%rax, 0x18(%rdi,%rcx,8)
000000010000d280	movq	0x18(%r8,%rcx,8), %rax
000000010000d285	movq	%rax, 0x20(%rdi,%rcx,8)
000000010000d28a	addq	$0x4, %rcx
000000010000d28e	cmpq	%rcx, %r14
000000010000d291	jne	0x10000d263
000000010000d293	movq	-0x1e8(%rbp), %rax
000000010000d29a	movq	%rdi, (%rax)
000000010000d29d	jmp	0x10000bdb2
000000010000d2a2	movq	%r12, -0x1f8(%rbp)
000000010000d2a9	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000d2b3	movl	$0xff, %r8d
000000010000d2b9	leaq	-0x130(%rbp), %r9
000000010000d2c0	movq	-0x1c8(%rbp), %rcx
000000010000d2c7	movq	-0x1c0(%rbp), %r12
000000010000d2ce	movq	%rbx, -0x1d0(%rbp)
000000010000d2d5	movq	(%rcx), %rbx
000000010000d2d8	movq	0x8(%rcx), %r10
000000010000d2dc	movq	0x10(%rcx), %rsi
000000010000d2e0	cmpq	%r10, %rsi
000000010000d2e3	movq	%r10, -0x1f0(%rbp)
000000010000d2ea	jae	0x10000d310
000000010000d2ec	movzbl	(%rbx,%rsi), %eax
000000010000d2f0	cmpq	$0x20, %rax
000000010000d2f4	ja	0x10000d310
000000010000d2f6	btq	%rax, %r13
000000010000d2fa	jae	0x10000d310
000000010000d2fc	incq	%rsi
000000010000d2ff	movq	%rsi, 0x10(%rcx)
000000010000d303	cmpq	%rsi, %r10
000000010000d306	jne	0x10000d2ec
000000010000d308	movq	%r10, %r14
000000010000d30b	movq	%r10, %rsi
000000010000d30e	jmp	0x10000d360
000000010000d310	movabsq	$0x4000000000003, %rdi          ## imm = 0x4000000000003
000000010000d31a	movq	%rsi, %r14
000000010000d31d	cmpq	%r10, %rsi
000000010000d320	jb	0x10000d330
000000010000d322	jmp	0x10000d360
000000010000d324	incq	%r14
000000010000d327	movq	%r14, 0x10(%rcx)
000000010000d32b	cmpq	%r14, %r10
000000010000d32e	je	0x10000d35d
000000010000d330	movzbl	(%rbx,%r14), %eax
000000010000d335	leal	-0x30(%rax), %edx
000000010000d338	cmpb	$0xa, %dl
000000010000d33b	jb	0x10000d324
000000010000d33d	movl	%eax, %edx
000000010000d33f	andb	$-0x21, %dl
000000010000d342	addb	$-0x41, %dl
000000010000d345	cmpb	$0x1a, %dl
000000010000d348	jb	0x10000d324
000000010000d34a	movzbl	%al, %eax
000000010000d34d	addl	$-0x2d, %eax
000000010000d350	cmpl	$0x32, %eax
000000010000d353	ja	0x10000d360
000000010000d355	btq	%rax, %rdi
000000010000d359	jb	0x10000d324
000000010000d35b	jmp	0x10000d360
000000010000d35d	movq	%r10, %r14
000000010000d360	movq	%r14, %r15
000000010000d363	subq	%rsi, %r15
000000010000d366	cmpq	$0xff, %r15
000000010000d36d	cmovaeq	%r8, %r15
000000010000d371	addq	%rbx, %rsi
000000010000d374	movl	$0x100, %ecx                    ## imm = 0x100
000000010000d379	movq	%r9, %rdi
000000010000d37c	movq	%r15, %rdx
000000010000d37f	callq	0x10001200a                     ## symbol stub for: ___memcpy_chk
000000010000d384	movb	$0x0, -0x130(%rbp,%r15)
000000010000d38d	movslq	(%r12), %rcx
000000010000d391	testq	%rcx, %rcx
000000010000d394	movq	-0x1d0(%rbp), %rax
000000010000d39b	jle	0x10000d50c
000000010000d3a1	movq	%rbx, -0x200(%rbp)
000000010000d3a8	movq	0x18(%rax), %rax
000000010000d3ac	movq	%rax, -0x1d8(%rbp)
000000010000d3b3	movl	$0xffffffff, %r15d              ## imm = 0xFFFFFFFF
000000010000d3b9	xorl	%r13d, %r13d
000000010000d3bc	leaq	-0x130(%rbp), %r12
000000010000d3c3	movq	-0x1d8(%rbp), %rax
000000010000d3ca	movq	(%rax,%r13,8), %rdi
000000010000d3ce	movq	%r12, %rsi
000000010000d3d1	movq	%rcx, %rbx
000000010000d3d4	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000d3d9	movq	%rbx, %rcx
000000010000d3dc	testl	%eax, %eax
000000010000d3de	cmovel	%r13d, %r15d
000000010000d3e2	incq	%r13
000000010000d3e5	cmpq	%r13, %rbx
000000010000d3e8	jne	0x10000d3c3
000000010000d3ea	testl	%r15d, %r15d
000000010000d3ed	movq	-0x1d0(%rbp), %rax
000000010000d3f4	movq	-0x1c8(%rbp), %rcx
000000010000d3fb	movq	-0x1c0(%rbp), %r12
000000010000d402	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000d40c	movq	-0x200(%rbp), %rsi
000000010000d413	movq	-0x1f0(%rbp), %rdi
000000010000d41a	js	0x10000d50c
000000010000d420	cmpq	%rdi, %r14
000000010000d423	jae	0x10000d447
000000010000d425	movzbl	(%rsi,%r14), %edx
000000010000d42a	cmpq	$0x20, %rdx
000000010000d42e	ja	0x10000d447
000000010000d430	btq	%rdx, %r13
000000010000d434	jae	0x10000d447
000000010000d436	incq	%r14
000000010000d439	movq	%r14, 0x10(%rcx)
000000010000d43d	cmpq	%r14, %rdi
000000010000d440	jne	0x10000d425
000000010000d442	jmp	0x10000d50c
000000010000d447	cmpq	%r14, %rdi
000000010000d44a	je	0x10000d50c
000000010000d450	cmpb	$0x3d, (%rsi,%r14)
000000010000d455	jne	0x10000d50c
000000010000d45b	incq	%r14
000000010000d45e	movq	%r14, 0x10(%rcx)
000000010000d462	movq	0x20(%rax), %rax
000000010000d466	movl	%r15d, %ebx
000000010000d469	movq	(%rax,%rbx,8), %rsi
000000010000d46d	movq	-0x1e0(%rbp), %rax
000000010000d474	leaq	(%rax,%rbx,8), %rcx
000000010000d478	movq	-0x1c8(%rbp), %rdi
000000010000d47f	xorl	%edx, %edx
000000010000d481	callq	_tp_value
000000010000d486	movq	-0x1c8(%rbp), %rcx
000000010000d48d	testl	%eax, %eax
000000010000d48f	je	0x10000d50c
000000010000d491	movq	-0x1f8(%rbp), %rax
000000010000d498	movb	$0x1, (%rax,%rbx)
000000010000d49c	movq	0x8(%rcx), %rdx
000000010000d4a0	movq	0x10(%rcx), %rax
000000010000d4a4	cmpq	%rdx, %rax
000000010000d4a7	jae	0x10000d4ca
000000010000d4a9	movq	(%rcx), %rsi
000000010000d4ac	movzbl	(%rsi,%rax), %edi
000000010000d4b0	cmpq	$0x20, %rdi
000000010000d4b4	ja	0x10000d4ca
000000010000d4b6	btq	%rdi, %r13
000000010000d4ba	jae	0x10000d4ca
000000010000d4bc	incq	%rax
000000010000d4bf	movq	%rax, 0x10(%rcx)
000000010000d4c3	cmpq	%rax, %rdx
000000010000d4c6	jne	0x10000d4ac
000000010000d4c8	jmp	0x10000d4dc
000000010000d4ca	cmpq	%rax, %rdx
000000010000d4cd	je	0x10000d4dc
000000010000d4cf	movq	(%rcx), %rdx
000000010000d4d2	cmpb	$0x7d, (%rdx,%rax)
000000010000d4d6	je	0x10000d5c9
000000010000d4dc	movq	-0x1c8(%rbp), %rdi
000000010000d4e3	leaq	0x5f99(%rip), %rsi              ## literal pool for: ","
000000010000d4ea	callq	_tp_eat
000000010000d4ef	movq	-0x1c8(%rbp), %rcx
000000010000d4f6	testl	%eax, %eax
000000010000d4f8	je	0x10000d50c
000000010000d4fa	movl	$0xff, %r8d
000000010000d500	leaq	-0x130(%rbp), %r9
000000010000d507	jmp	0x10000d2d5
000000010000d50c	xorl	%r14d, %r14d
000000010000d50f	jmp	0x10000bdb8
000000010000d514	movq	%rdi, %rdx
000000010000d517	cmpq	%rsi, %rdi
000000010000d51a	jne	0x10000d525
000000010000d51c	testb	%r8b, %r8b
000000010000d51f	jne	0x10000bdb8
000000010000d525	cmpq	%rax, %rdx
000000010000d528	jae	0x10000d58e
000000010000d52a	movzbl	-0x130(%rbp,%rdx), %esi
000000010000d532	orl	$0x20, %esi
000000010000d535	cmpl	$0x65, %esi
000000010000d538	jne	0x10000d58e
000000010000d53a	leaq	0x1(%rdx), %rsi
000000010000d53e	cmpq	%rax, %rsi
000000010000d541	jae	0x10000d55c
000000010000d543	movzbl	-0x130(%rbp,%rsi), %edi
000000010000d54b	cmpl	$0x2d, %edi
000000010000d54e	je	0x10000d555
000000010000d550	cmpl	$0x2b, %edi
000000010000d553	jne	0x10000d55c
000000010000d555	addq	$0x2, %rdx
000000010000d559	movq	%rdx, %rsi
000000010000d55c	cmpq	%rax, %rsi
000000010000d55f	jae	0x10000bdb8
000000010000d565	movq	%rsi, %rdx
000000010000d568	movzbl	-0x130(%rbp,%rdx), %edi
000000010000d570	addb	$-0x30, %dil
000000010000d574	cmpb	$0x9, %dil
000000010000d578	ja	0x10000d585
000000010000d57a	incq	%rdx
000000010000d57d	cmpq	%rdx, %rax
000000010000d580	jne	0x10000d568
000000010000d582	movq	%rax, %rdx
000000010000d585	cmpq	%rsi, %rdx
000000010000d588	je	0x10000bdb8
000000010000d58e	cmpq	%rax, %rdx
000000010000d591	jne	0x10000bdb8
000000010000d597	cmpl	$0xa, (%rcx)
000000010000d59a	jne	0x10000d5b6
000000010000d59c	leaq	-0x130(%rbp), %rdi
000000010000d5a3	xorl	%esi, %esi
000000010000d5a5	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000d5aa	movd	%xmm0, %eax
000000010000d5ae	movq	%rax, (%r15)
000000010000d5b1	jmp	0x10000bdb2
000000010000d5b6	leaq	-0x130(%rbp), %rdi
000000010000d5bd	xorl	%esi, %esi
000000010000d5bf	callq	0x100012148                     ## symbol stub for: _strtod
000000010000d5c4	jmp	0x10000c25d
000000010000d5c9	incq	%rax
000000010000d5cc	movq	%rax, 0x10(%rcx)
000000010000d5d0	movq	-0x1f8(%rbp), %r12
000000010000d5d7	jmp	0x10000cea8
000000010000d5dc	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000d5e1	nopl	(%rax)
000000010000d5e4	popq	%rax
000000010000d5e5	callq	0xe859d5e9
000000010000d5ea	.byte 0xff #bad opcode
000000010000d5eb	lcalll	*-0x18(%rax)
000000010000d5ee	.byte 0xff #bad opcode
000000010000d5ef	lcalll	*-0x18(%rax)
000000010000d5f2	.byte 0xff #bad opcode
000000010000d5f3	lcalll	*-0x18(%rax)
000000010000d5f6	.byte 0xff #bad opcode
000000010000d5f7	lcalll	*-0x18(%rax)
000000010000d5fa	.byte 0xff #bad opcode
000000010000d5fb	lcalll	*-0x18(%rax)
000000010000d5fe	.byte 0xff #bad opcode
000000010000d5ff	lcalll	*-0x18(%rax)
000000010000d602	.byte 0xff #bad opcode
000000010000d603	lcalll	*-0x18(%rax)
000000010000d606	.byte 0xff #bad opcode
000000010000d607	lcalll	*-0x18(%rax)
000000010000d60a	.byte 0xff #bad opcode
000000010000d60b	.byte 0xff #bad opcode
000000010000d60c	cmpl	%esp, %ebp
000000010000d60e	.byte 0xff #bad opcode
000000010000d60f	.byte 0xff #bad opcode
000000010000d610	cmpl	%esp, %ebp
000000010000d612	.byte 0xff #bad opcode
000000010000d613	incl	-0x49000014(%rcx)
000000010000d619	inb	%dx, %al
000000010000d61a	.byte 0xff #bad opcode
000000010000d61b	.byte 0xff #bad opcode
000000010000d61c	jl	0x10000d60d
000000010000d61e	.byte 0xff #bad opcode
000000010000d61f	decl	(%rcx)
000000010000d621	jmp	0x10000d622
000000010000d623	lcalll	*(%rdx)
000000010000d625	outb	%al, %dx
000000010000d626	.byte 0xff #bad opcode
000000010000d627	decl	(%rcx)
000000010000d629	jmp	0x10000d62a
000000010000d62b	.byte 0xff #bad opcode
000000010000d62c	fsubr	%st, %st(1)
000000010000d62e	.byte 0xff #bad opcode
000000010000d62f	.byte 0xff #bad opcode
000000010000d630	fsubr	%st, %st(1)
000000010000d632	.byte 0xff #bad opcode
000000010000d633	incl	-0x13(%rcx)
000000010000d636	.byte 0xff #bad opcode
000000010000d637	ljmpl	*0xfffffed(%rcx)
000000010000d63d	.byte 0x1f #bad opcode
000000010000d63e	addb	%dl, 0x48(%rbp)
000000010000d642	movl	%esp, %ebp
000000010000d644	pushq	%r15
000000010000d646	pushq	%r14
000000010000d648	pushq	%r13
000000010000d64a	pushq	%r12
000000010000d64c	pushq	%rbx
000000010000d64d	subq	$0xb8, %rsp
000000010000d654	movq	%rdx, %rbx
000000010000d657	movq	%rsi, %r15
000000010000d65a	movq	0x69cf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000d661	movq	(%rax), %rax
000000010000d664	movq	%rax, -0x30(%rbp)
000000010000d668	leaq	-0xb0(%rbp), %rsi
000000010000d66f	movl	$0x80, %edx
000000010000d674	callq	_tp_token
000000010000d679	xorl	%r14d, %r14d
000000010000d67c	cmpq	$0x7f, %rax
000000010000d680	ja	0x10000d6bc
000000010000d682	leaq	-0xb0(%rbp), %r12
000000010000d689	movq	%r12, %rdi
000000010000d68c	callq	0x100012136                     ## symbol stub for: _strlen
000000010000d691	movq	%r12, %rdi
000000010000d694	movq	%rax, %rsi
000000010000d697	callq	_fwp_str_new
000000010000d69c	movq	(%rax), %r11
000000010000d69f	testq	%r11, %r11
000000010000d6a2	je	0x10000d6bc
000000010000d6a4	movq	%rax, %rcx
000000010000d6a7	movzbl	0x8(%rax), %r8d
000000010000d6ac	leal	-0x2b(%r8), %eax
000000010000d6b0	xorl	%edx, %edx
000000010000d6b2	testb	$-0x3, %al
000000010000d6b4	sete	%dl
000000010000d6b7	cmpq	%rdx, %r11
000000010000d6ba	jne	0x10000d6e5
000000010000d6bc	movq	0x696d(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000d6c3	movq	(%rax), %rax
000000010000d6c6	cmpq	-0x30(%rbp), %rax
000000010000d6ca	jne	0x10000da69
000000010000d6d0	movl	%r14d, %eax
000000010000d6d3	addq	$0xb8, %rsp
000000010000d6da	popq	%rbx
000000010000d6db	popq	%r12
000000010000d6dd	popq	%r13
000000010000d6df	popq	%r14
000000010000d6e1	popq	%r15
000000010000d6e3	popq	%rbp
000000010000d6e4	retq
000000010000d6e5	movl	(%r15), %r9d
000000010000d6e8	movl	0x48(%r15), %edi
000000010000d6ec	jbe	0x10000d707
000000010000d6ee	nop
000000010000d6f0	movzbl	0x8(%rcx,%rdx), %esi
000000010000d6f5	addb	$-0x3a, %sil
000000010000d6f9	cmpb	$-0xa, %sil
000000010000d6fd	jb	0x10000d6bc
000000010000d6ff	incq	%rdx
000000010000d702	cmpq	%rdx, %r11
000000010000d705	jne	0x10000d6f0
000000010000d707	movl	%r9d, -0xb4(%rbp)
000000010000d70e	movq	%r8, -0xc0(%rbp)
000000010000d715	movq	%rdi, -0xd0(%rbp)
000000010000d71c	movq	%rbx, -0xc8(%rbp)
000000010000d723	xorl	%r15d, %r15d
000000010000d726	testb	$-0x3, %al
000000010000d728	sete	%r15b
000000010000d72c	xorl	%edi, %edi
000000010000d72e	movl	$0x0, %esi
000000010000d733	cmpq	%r15, %r11
000000010000d736	jbe	0x10000d7f1
000000010000d73c	xorl	%r14d, %r14d
000000010000d73f	movabsq	$-0x3333333333333333, %rbx      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000d749	xorl	%edi, %edi
000000010000d74b	xorl	%esi, %esi
000000010000d74d	nopl	(%rax)
000000010000d750	movq	%rsi, %r13
000000010000d753	movq	%rdi, %r12
000000010000d756	movq	%rdi, %rax
000000010000d759	movl	$0xa, %edx
000000010000d75e	mulq	%rdx
000000010000d761	leaq	(%rsi,%rsi,4), %rsi
000000010000d765	leaq	(%rdx,%rsi,2), %rdx
000000010000d769	movsbl	0x8(%rcx,%r15), %esi
000000010000d76f	addl	$-0x30, %esi
000000010000d772	movslq	%esi, %r8
000000010000d775	movq	%r8, %rsi
000000010000d778	sarq	$0x3f, %rsi
000000010000d77c	movq	%rax, %rdi
000000010000d77f	addq	%r8, %rdi
000000010000d782	adcq	%rdx, %rsi
000000010000d785	movq	%rsi, %r9
000000010000d788	shldq	$0x3f, %rdi, %r9
000000010000d78d	movq	%rsi, %r8
000000010000d790	shrq	%r8
000000010000d793	movq	%r9, %r10
000000010000d796	addq	%r8, %r10
000000010000d799	adcq	$0x0, %r10
000000010000d79d	movq	%r10, %rax
000000010000d7a0	mulq	%rbx
000000010000d7a3	shrq	$0x2, %rdx
000000010000d7a7	leaq	(%rdx,%rdx,4), %rax
000000010000d7ab	subq	%rax, %r10
000000010000d7ae	subq	%r10, %r9
000000010000d7b1	sbbq	$0x0, %r8
000000010000d7b5	movq	%r9, %r10
000000010000d7b8	movabsq	$-0x3333333333333334, %rax      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000d7c2	imulq	%rax, %r10
000000010000d7c6	movq	%r9, %rax
000000010000d7c9	mulq	%rbx
000000010000d7cc	addq	%r10, %rdx
000000010000d7cf	imulq	%rbx, %r8
000000010000d7d3	addq	%rdx, %r8
000000010000d7d6	xorq	%r13, %r8
000000010000d7d9	xorq	%r12, %rax
000000010000d7dc	orq	%r8, %rax
000000010000d7df	jne	0x10000d6bc
000000010000d7e5	incq	%r15
000000010000d7e8	cmpq	%r15, %r11
000000010000d7eb	jne	0x10000d750
000000010000d7f1	movl	-0xb4(%rbp), %r11d
000000010000d7f8	cmpl	$0x9, %r11d
000000010000d7fc	jne	0x10000d860
000000010000d7fe	cmpb	$0x2d, -0xc0(%rbp)
000000010000d805	movq	-0xc8(%rbp), %rbx
000000010000d80c	jne	0x10000d81d
000000010000d80e	xorl	%r14d, %r14d
000000010000d811	movq	%rdi, %rax
000000010000d814	orq	%rsi, %rax
000000010000d817	jne	0x10000d6bc
000000010000d81d	callq	_fwp_box_i128
000000010000d822	movq	%rax, %r15
000000010000d825	movq	%r15, -0xd8(%rbp)
000000010000d82c	movl	$0x10, %edi
000000010000d831	callq	_fwp_alloc_init
000000010000d836	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
000000010000d840	movq	%rcx, (%rax)
000000010000d843	movq	%r15, 0x8(%rax)
000000010000d847	leaq	-0xd8(%rbp), %rcx
000000010000d84e	movq	0x8(%rax), %rax
000000010000d852	movq	%rax, (%rbx)
000000010000d855	movl	$0x1, %r14d
000000010000d85b	jmp	0x10000d6bc
000000010000d860	movq	-0xc0(%rbp), %r10
000000010000d867	cmpb	$0x2d, %r10b
000000010000d86b	sete	%cl
000000010000d86e	movabsq	$-0x8000000000000000, %rax      ## imm = 0x8000000000000000
000000010000d878	movq	%rsi, %rdx
000000010000d87b	xorq	%rax, %rdx
000000010000d87e	orq	%rdi, %rdx
000000010000d881	setne	%dl
000000010000d884	xorl	%r14d, %r14d
000000010000d887	movq	%rdi, %r8
000000010000d88a	negq	%r8
000000010000d88d	movq	%rax, %r8
000000010000d890	sbbq	%rsi, %r8
000000010000d893	movq	-0xc8(%rbp), %rbx
000000010000d89a	jb	0x10000d6bc
000000010000d8a0	orb	%dl, %cl
000000010000d8a2	je	0x10000d6bc
000000010000d8a8	xorl	%r14d, %r14d
000000010000d8ab	movq	%rdi, %r15
000000010000d8ae	negq	%r15
000000010000d8b1	movl	$0x0, %r9d
000000010000d8b7	sbbq	%rsi, %r9
000000010000d8ba	cmpb	$0x2d, %r10b
000000010000d8be	cmovneq	%rdi, %r15
000000010000d8c2	cmovneq	%rsi, %r9
000000010000d8c6	cmpl	$0x14, %r11d
000000010000d8ca	ja	0x10000d6bc
000000010000d8d0	movl	%r11d, %ecx
000000010000d8d3	leaq	0x196(%rip), %rdx
000000010000d8da	movslq	(%rdx,%rcx,4), %rcx
000000010000d8de	addq	%rdx, %rcx
000000010000d8e1	jmpq	*%rcx
000000010000d8e3	movq	%r15, %rax
000000010000d8e6	addq	$-0x80, %rax
000000010000d8ea	adcq	$-0x1, %r9
000000010000d8ee	cmpq	$-0x100, %rax
000000010000d8f4	jmp	0x10000d92f
000000010000d8f6	movq	%r15, %rax
000000010000d8f9	addq	$-0x80000000, %rax              ## imm = 0x80000000
000000010000d8ff	adcq	$-0x1, %r9
000000010000d903	movabsq	$-0x100000000, %rcx             ## imm = 0xFFFFFFFF00000000
000000010000d90d	cmpq	%rcx, %rax
000000010000d910	jmp	0x10000d92f
000000010000d912	xorl	%r14d, %r14d
000000010000d915	movl	$0xff, %eax
000000010000d91a	jmp	0x10000d946
000000010000d91c	movq	%r15, %rax
000000010000d91f	addq	$-0x8000, %rax                  ## imm = 0x8000
000000010000d925	adcq	$-0x1, %r9
000000010000d929	cmpq	$-0x10000, %rax                 ## imm = 0xFFFF0000
000000010000d92f	sbbq	$-0x1, %r9
000000010000d933	jb	0x10000d6bc
000000010000d939	jmp	0x10000d825
000000010000d93e	xorl	%r14d, %r14d
000000010000d941	movl	$0xffff, %eax                   ## imm = 0xFFFF
000000010000d946	cmpq	%r15, %rax
000000010000d949	movl	$0x0, %eax
000000010000d94e	sbbq	%r9, %rax
000000010000d951	jb	0x10000d6bc
000000010000d957	jmp	0x10000d825
000000010000d95c	movq	%r15, %rax
000000010000d95f	shrq	$0x20, %rax
000000010000d963	orq	%r9, %rax
000000010000d966	jne	0x10000d6bc
000000010000d96c	jmp	0x10000d825
000000010000d971	movq	%r15, %rcx
000000010000d974	addq	%rax, %rcx
000000010000d977	adcq	$-0x1, %r9
000000010000d97b	cmpq	$-0x1, %r9
000000010000d97f	jne	0x10000d6bc
000000010000d985	jmp	0x10000d825
000000010000d98a	movq	%r15, %rdi
000000010000d98d	movq	%r9, %rsi
000000010000d990	callq	_fwp_box_i128
000000010000d995	jmp	0x10000d822
000000010000d99a	xorl	%r14d, %r14d
000000010000d99d	movq	-0xd0(%rbp), %rcx
000000010000d9a4	testl	%ecx, %ecx
000000010000d9a6	jle	0x10000d9dd
000000010000d9a8	leal	-0x1(%rcx), %eax
000000010000d9ab	cmpl	$0x4f, %eax
000000010000d9ae	movl	$0x4f, %r8d
000000010000d9b4	cmovbl	%eax, %r8d
000000010000d9b8	incl	%r8d
000000010000d9bb	movl	%r8d, %edi
000000010000d9be	andl	$0x7, %edi
000000010000d9c1	cmpl	$0x8, %ecx
000000010000d9c4	jae	0x10000d9e3
000000010000d9c6	movl	$0x1, %eax
000000010000d9cb	xorl	%ecx, %ecx
000000010000d9cd	jmp	0x10000da09
000000010000d9cf	testq	%r9, %r9
000000010000d9d2	jne	0x10000d6bc
000000010000d9d8	jmp	0x10000d825
000000010000d9dd	xorl	%edx, %edx
000000010000d9df	xorl	%ecx, %ecx
000000010000d9e1	jmp	0x10000da3e
000000010000d9e3	andl	$0xf8, %r8d
000000010000d9ea	movl	$0x1, %eax
000000010000d9ef	xorl	%ecx, %ecx
000000010000d9f1	movl	$0x19a1, %esi                   ## imm = 0x19A1
000000010000d9f6	mulq	%rsi
000000010000d9f9	imulq	$0x19a1, %rcx, %rcx             ## imm = 0x19A1
000000010000da00	addq	%rdx, %rcx
000000010000da03	addl	$-0x8, %r8d
000000010000da07	jne	0x10000d9f6
000000010000da09	testl	%edi, %edi
000000010000da0b	je	0x10000da20
000000010000da0d	movl	$0x3, %esi
000000010000da12	mulq	%rsi
000000010000da15	leaq	(%rcx,%rcx,2), %rcx
000000010000da19	addq	%rdx, %rcx
000000010000da1c	decl	%edi
000000010000da1e	jne	0x10000da12
000000010000da20	addq	$-0x1, %rax
000000010000da24	adcq	$-0x1, %rcx
000000010000da28	movq	%rcx, %rdx
000000010000da2b	shrq	$0x3f, %rdx
000000010000da2f	addq	%rax, %rdx
000000010000da32	adcq	$0x0, %rcx
000000010000da36	shrdq	$0x1, %rcx, %rdx
000000010000da3b	sarq	%rcx
000000010000da3e	movq	%rdx, %rax
000000010000da41	negq	%rax
000000010000da44	movl	$0x0, %esi
000000010000da49	sbbq	%rcx, %rsi
000000010000da4c	cmpq	%r15, %rdx
000000010000da4f	sbbq	%r9, %rcx
000000010000da52	jl	0x10000d6bc
000000010000da58	cmpq	%rax, %r15
000000010000da5b	sbbq	%rsi, %r9
000000010000da5e	jge	0x10000d825
000000010000da64	jmp	0x10000d6bc
000000010000da69	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010000da6e	nop
000000010000da70	jae	0x10000da70
000000010000da72	.byte 0xff #bad opcode
000000010000da73	ljmpl	*-0x1790001(%rsi,%rdi,8)
000000010000da7a	.byte 0xff #bad opcode
000000010000da7b	incl	(%rcx)
000000010000da7d	.byte 0xff #bad opcode
000000010000da7e	.byte 0xff #bad opcode
000000010000da7f	lcalll	*(%rdx)
000000010000da81	.byte 0xff #bad opcode
000000010000da82	.byte 0xff #bad opcode
000000010000da83	jmpq	*-0x31000002(%rdx)
000000010000da89	.byte 0xfe #bad opcode
000000010000da8a	.byte 0xff #bad opcode
000000010000da8b	.byte 0xff #bad opcode
000000010000da8c	inb	%dx, %al
000000010000da8d	.byte 0xfe #bad opcode
000000010000da8e	.byte 0xff #bad opcode
000000010000da8f	lcalll	*-0x1(%rdi)
000000010000da92	.byte 0xff #bad opcode
000000010000da93	decl	-0x1(%rsp,%rdi,8)
000000010000da97	decl	-0x1(%rsp,%rdi,8)
000000010000da9b	decl	-0x1(%rsp,%rdi,8)
000000010000da9f	decl	-0x1(%rsp,%rdi,8)
000000010000daa3	decl	-0x1(%rsp,%rdi,8)
000000010000daa7	decl	-0x1(%rsp,%rdi,8)
000000010000daab	decl	-0x1(%rsp,%rdi,8)
000000010000daaf	decl	-0x1(%rsp,%rdi,8)
000000010000dab3	decl	-0x1(%rsp,%rdi,8)
000000010000dab7	decl	-0x1(%rsp,%rdi,8)
000000010000dabb	decl	-0x1(%rsp,%rdi,8)
000000010000dabf	ljmpl	*(%rdx)
000000010000dac1	.byte 0xff #bad opcode
000000010000dac2	.byte 0xff #bad opcode
000000010000dac3	jmpq	*0x66(%rsi)
000000010000dac6	nopw	%cs:(%rax,%rax)
_tp_quoted:
000000010000dad0	pushq	%rbp
000000010000dad1	movq	%rsp, %rbp
000000010000dad4	pushq	%r15
000000010000dad6	pushq	%r14
000000010000dad8	pushq	%r13
000000010000dada	pushq	%r12
000000010000dadc	pushq	%rbx
000000010000dadd	subq	$0x28, %rsp
000000010000dae1	movq	%rsi, %rbx
000000010000dae4	movq	%rdi, %r15
000000010000dae7	movq	0x8(%rdi), %rcx
000000010000daeb	movq	0x10(%rdi), %rax
000000010000daef	cmpq	%rcx, %rax
000000010000daf2	jae	0x10000db34
000000010000daf4	movq	(%r15), %rdx
000000010000daf7	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000db01	nopw	%cs:(%rax,%rax)
000000010000db10	movzbl	(%rdx,%rax), %edi
000000010000db14	cmpq	$0x20, %rdi
000000010000db18	ja	0x10000db34
000000010000db1a	btq	%rdi, %rsi
000000010000db1e	jae	0x10000db34
000000010000db20	incq	%rax
000000010000db23	movq	%rax, 0x10(%r15)
000000010000db27	cmpq	%rax, %rcx
000000010000db2a	jne	0x10000db10
000000010000db2c	xorl	%r14d, %r14d
000000010000db2f	jmp	0x10000dd16
000000010000db34	xorl	%r14d, %r14d
000000010000db37	cmpq	%rcx, %rax
000000010000db3a	jae	0x10000dd16
000000010000db40	movq	(%r15), %rdx
000000010000db43	cmpb	$0x22, (%rdx,%rax)
000000010000db47	jne	0x10000dd16
000000010000db4d	incq	%rax
000000010000db50	movq	%rax, 0x10(%r15)
000000010000db54	xorps	%xmm0, %xmm0
000000010000db57	movaps	%xmm0, -0x50(%rbp)
000000010000db5b	movq	$0x0, -0x40(%rbp)
000000010000db63	xorl	%r14d, %r14d
000000010000db66	cmpq	%rcx, %rax
000000010000db69	jae	0x10000dd04
000000010000db6f	leaq	-0x50(%rbp), %r12
000000010000db73	movq	0x6486(%rip), %r13              ## literal pool symbol address: __DefaultRuneLocale
000000010000db7a	nopw	(%rax,%rax)
000000010000db80	movq	(%r15), %rdx
000000010000db83	leaq	0x1(%rax), %rdi
000000010000db87	movq	%rdi, 0x10(%r15)
000000010000db8b	movzbl	(%rdx,%rax), %esi
000000010000db8f	cmpl	$0x5c, %esi
000000010000db92	je	0x10000dbd0
000000010000db94	cmpl	$0x22, %esi
000000010000db97	je	0x10000dd28
000000010000db9d	movb	%sil, -0x29(%rbp)
000000010000dba1	movl	$0x1, %edx
000000010000dba6	movq	%r12, %rdi
000000010000dba9	leaq	-0x29(%rbp), %rsi
000000010000dbad	callq	_buf_put
000000010000dbb2	movq	0x8(%r15), %rcx
000000010000dbb6	movq	0x10(%r15), %rax
000000010000dbba	cmpq	%rcx, %rax
000000010000dbbd	jb	0x10000db80
000000010000dbbf	jmp	0x10000dd0d
000000010000dbc4	nopw	%cs:(%rax,%rax)
000000010000dbd0	cmpq	%rcx, %rdi
000000010000dbd3	jae	0x10000dd0d
000000010000dbd9	leaq	0x2(%rax), %rsi
000000010000dbdd	movq	%rsi, 0x10(%r15)
000000010000dbe1	movzbl	0x1(%rdx,%rax), %edi
000000010000dbe6	leal	-0x5c(%rdi), %r8d
000000010000dbea	cmpl	$0x19, %r8d
000000010000dbee	ja	0x10000dc06
000000010000dbf0	leaq	0x2b9(%rip), %r9
000000010000dbf7	movslq	(%r9,%r8,4), %rdi
000000010000dbfb	addq	%r9, %rdi
000000010000dbfe	jmpq	*%rdi
000000010000dc00	movb	$0x5c, -0x29(%rbp)
000000010000dc04	jmp	0x10000dba1
000000010000dc06	cmpl	$0x22, %edi
000000010000dc09	je	0x10000dcc1
000000010000dc0f	cmpl	$0x30, %edi
000000010000dc12	jne	0x10000dd0d
000000010000dc18	movb	$0x0, -0x29(%rbp)
000000010000dc1c	jmp	0x10000dba1
000000010000dc1e	movb	$0x9, -0x29(%rbp)
000000010000dc22	jmp	0x10000dba1
000000010000dc27	movb	$0xd, -0x29(%rbp)
000000010000dc2b	jmp	0x10000dba1
000000010000dc30	movb	$0xa, -0x29(%rbp)
000000010000dc34	jmp	0x10000dba1
000000010000dc39	cmpq	%rcx, %rsi
000000010000dc3c	jae	0x10000dd0d
000000010000dc42	cmpb	$0x7b, (%rdx,%rsi)
000000010000dc46	jne	0x10000dd0d
000000010000dc4c	leaq	0x3(%rax), %rsi
000000010000dc50	movq	%rsi, 0x10(%r15)
000000010000dc54	cmpq	%rcx, %rsi
000000010000dc57	jae	0x10000dd0d
000000010000dc5d	leaq	0x4(%rax), %rdi
000000010000dc61	leaq	(%rdx,%rax), %r8
000000010000dc65	addq	$0x3, %r8
000000010000dc69	subq	%rax, %rcx
000000010000dc6c	addq	$-0x3, %rcx
000000010000dc70	xorl	%edx, %edx
000000010000dc72	xorl	%esi, %esi
000000010000dc74	nopw	%cs:(%rax,%rax)
000000010000dc80	movzbl	(%r8,%rdx), %r9d
000000010000dc85	testb	$0x1, 0x3e(%r13,%r9,4)
000000010000dc8b	je	0x10000dcca
000000010000dc8d	leaq	(%rdi,%rdx), %r9
000000010000dc91	movq	%r9, 0x10(%r15)
000000010000dc95	movsbl	(%r8,%rdx), %r9d
000000010000dc9a	shll	$0x4, %esi
000000010000dc9d	leal	-0x30(%r9), %r10d
000000010000dca1	movl	%r9d, %r11d
000000010000dca4	orl	$0x20, %r11d
000000010000dca8	addl	$-0x57, %r11d
000000010000dcac	cmpl	$0x3a, %r9d
000000010000dcb0	cmovll	%r10d, %r11d
000000010000dcb4	addl	%r11d, %esi
000000010000dcb7	incq	%rdx
000000010000dcba	cmpq	%rdx, %rcx
000000010000dcbd	jne	0x10000dc80
000000010000dcbf	jmp	0x10000dd0d
000000010000dcc1	movb	$0x22, -0x29(%rbp)
000000010000dcc5	jmp	0x10000dba1
000000010000dcca	testl	%edx, %edx
000000010000dccc	je	0x10000dd0d
000000010000dcce	cmpb	$0x7d, %r9b
000000010000dcd2	jne	0x10000dd0d
000000010000dcd4	cmpl	$0x10ffff, %esi                 ## imm = 0x10FFFF
000000010000dcda	ja	0x10000dd0d
000000010000dcdc	movl	%esi, %ecx
000000010000dcde	andl	$0x1ff800, %ecx                 ## imm = 0x1FF800
000000010000dce4	cmpl	$0xd800, %ecx                   ## imm = 0xD800
000000010000dcea	je	0x10000dd0d
000000010000dcec	addq	%rdx, %rax
000000010000dcef	addq	$0x4, %rax
000000010000dcf3	movq	%rax, 0x10(%r15)
000000010000dcf7	movq	%r12, %rdi
000000010000dcfa	callq	_fwp_utf8_put
000000010000dcff	jmp	0x10000dbb2
000000010000dd04	xorl	%edi, %edi
000000010000dd06	callq	0x100012082                     ## symbol stub for: _free
000000010000dd0b	jmp	0x10000dd16
000000010000dd0d	movq	-0x50(%rbp), %rdi
000000010000dd11	callq	0x100012082                     ## symbol stub for: _free
000000010000dd16	movl	%r14d, %eax
000000010000dd19	addq	$0x28, %rsp
000000010000dd1d	popq	%rbx
000000010000dd1e	popq	%r12
000000010000dd20	popq	%r13
000000010000dd22	popq	%r14
000000010000dd24	popq	%r15
000000010000dd26	popq	%rbp
000000010000dd27	retq
000000010000dd28	movq	-0x50(%rbp), %r14
000000010000dd2c	movq	-0x48(%rbp), %rsi
000000010000dd30	testq	%r14, %r14
000000010000dd33	leaq	0x4a08(%rip), %rdi              ## literal pool for: ""
000000010000dd3a	cmovneq	%r14, %rdi
000000010000dd3e	testq	%rsi, %rsi
000000010000dd41	je	0x10000de83
000000010000dd47	xorl	%eax, %eax
000000010000dd49	jmp	0x10000dd57
000000010000dd4b	incq	%rax
000000010000dd4e	cmpq	%rsi, %rax
000000010000dd51	jae	0x10000de83
000000010000dd57	movzbl	(%rdi,%rax), %r9d
000000010000dd5c	testb	%r9b, %r9b
000000010000dd5f	jns	0x10000dd4b
000000010000dd61	leal	0x3e(%r9), %ecx
000000010000dd65	cmpb	$0x1e, %cl
000000010000dd68	jae	0x10000dd7c
000000010000dd6a	movl	$0x80, %ecx
000000010000dd6f	movl	$0x1, %r8d
000000010000dd75	movl	$0x1f, %edx
000000010000dd7a	jmp	0x10000ddb6
000000010000dd7c	movl	%r9d, %ecx
000000010000dd7f	andb	$-0x10, %cl
000000010000dd82	cmpb	$-0x20, %cl
000000010000dd85	jne	0x10000dd99
000000010000dd87	movl	$0x800, %ecx                    ## imm = 0x800
000000010000dd8c	movl	$0x2, %r8d
000000010000dd92	movl	$0xf, %edx
000000010000dd97	jmp	0x10000ddb6
000000010000dd99	leal	0x10(%r9), %ecx
000000010000dd9d	cmpb	$0x4, %cl
000000010000dda0	ja	0x10000dea1
000000010000dda6	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000ddab	movl	$0x3, %r8d
000000010000ddb1	movl	$0x7, %edx
000000010000ddb6	movl	%r8d, %r8d
000000010000ddb9	leaq	(%rax,%r8), %r10
000000010000ddbd	cmpq	%rsi, %r10
000000010000ddc0	jae	0x10000dea1
000000010000ddc6	movzbl	0x1(%rdi,%rax), %r10d
000000010000ddcc	movl	%r10d, %r11d
000000010000ddcf	andl	$-0x40, %r11d
000000010000ddd3	cmpl	$0x80, %r11d
000000010000ddda	jne	0x10000dea1
000000010000dde0	andl	%r9d, %edx
000000010000dde3	leal	0x1(%r8), %r11d
000000010000dde7	movl	%edx, %r9d
000000010000ddea	shll	$0x6, %r9d
000000010000ddee	andl	$0x3f, %r10d
000000010000ddf2	orl	%r9d, %r10d
000000010000ddf5	cmpl	$0x2, %r11d
000000010000ddf9	jne	0x10000de00
000000010000ddfb	movl	%r10d, %r11d
000000010000ddfe	jmp	0x10000de58
000000010000de00	movzbl	0x2(%rdi,%rax), %edx
000000010000de05	movl	%edx, %r9d
000000010000de08	andl	$-0x40, %r9d
000000010000de0c	cmpl	$0x80, %r9d
000000010000de13	jne	0x10000dea1
000000010000de19	movl	%r10d, %r9d
000000010000de1c	shll	$0x6, %r9d
000000010000de20	andl	$0x3f, %edx
000000010000de23	orl	%r9d, %edx
000000010000de26	cmpl	$0x3, %r11d
000000010000de2a	jne	0x10000de34
000000010000de2c	movl	%edx, %r11d
000000010000de2f	movl	%r10d, %edx
000000010000de32	jmp	0x10000de58
000000010000de34	movzbl	0x3(%rdi,%rax), %r11d
000000010000de3a	movl	%r11d, %r9d
000000010000de3d	andl	$-0x40, %r9d
000000010000de41	cmpl	$0x80, %r9d
000000010000de48	jne	0x10000dea1
000000010000de4a	movl	%edx, %r9d
000000010000de4d	shll	$0x6, %r9d
000000010000de51	andl	$0x3f, %r11d
000000010000de55	orl	%r9d, %r11d
000000010000de58	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000de5e	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000de64	je	0x10000dea1
000000010000de66	cmpl	$0x10ffff, %r9d                 ## imm = 0x10FFFF
000000010000de6d	ja	0x10000dea1
000000010000de6f	cmpl	%ecx, %r11d
000000010000de72	jb	0x10000dea1
000000010000de74	addq	%r8, %rax
000000010000de77	incq	%rax
000000010000de7a	cmpq	%rsi, %rax
000000010000de7d	jb	0x10000dd57
000000010000de83	callq	_fwp_str_new
000000010000de88	movq	%rax, %r15
000000010000de8b	movq	%r14, %rdi
000000010000de8e	callq	0x100012082                     ## symbol stub for: _free
000000010000de93	movq	%r15, (%rbx)
000000010000de96	movl	$0x1, %r14d
000000010000de9c	jmp	0x10000dd16
000000010000dea1	movq	%r14, %rdi
000000010000dea4	callq	0x100012082                     ## symbol stub for: _free
000000010000dea9	jmp	0x10000db2c
000000010000deae	nop
000000010000deb0	pushq	%rax
000000010000deb1	std
000000010000deb2	.byte 0xff #bad opcode
000000010000deb3	lcalll	*-0x2(%rbp)
000000010000deb6	.byte 0xff #bad opcode
000000010000deb7	lcalll	*-0x2(%rbp)
000000010000deba	.byte 0xff #bad opcode
000000010000debb	lcalll	*-0x2(%rbp)
000000010000debe	.byte 0xff #bad opcode
000000010000debf	lcalll	*-0x2(%rbp)
000000010000dec2	.byte 0xff #bad opcode
000000010000dec3	lcalll	*-0x2(%rbp)
000000010000dec6	.byte 0xff #bad opcode
000000010000dec7	lcalll	*-0x2(%rbp)
000000010000deca	.byte 0xff #bad opcode
000000010000decb	lcalll	*-0x2(%rbp)
000000010000dece	.byte 0xff #bad opcode
000000010000decf	lcalll	*-0x2(%rbp)
000000010000ded2	.byte 0xff #bad opcode
000000010000ded3	lcalll	*-0x2(%rbp)
000000010000ded6	.byte 0xff #bad opcode
000000010000ded7	lcalll	*-0x2(%rbp)
000000010000deda	.byte 0xff #bad opcode
000000010000dedb	lcalll	*-0x2(%rbp)
000000010000dede	.byte 0xff #bad opcode
000000010000dedf	lcalll	*-0x2(%rbp)
000000010000dee2	.byte 0xff #bad opcode
000000010000dee3	lcalll	*-0x2(%rbp)
000000010000dee6	.byte 0xff #bad opcode
000000010000dee7	lcalll	*-0x2(%rbp)
000000010000deea	.byte 0xff #bad opcode
000000010000deeb	lcalll	*-0x2(%rbp)
000000010000deee	.byte 0xff #bad opcode
000000010000deef	lcalll	*-0x2(%rbp)
000000010000def2	.byte 0xff #bad opcode
000000010000def3	lcalll	*-0x2(%rbp)
000000010000def6	.byte 0xff #bad opcode
000000010000def7	incl	0x5dfffffd(%rax)
000000010000defd	.byte 0xfe #bad opcode
000000010000defe	.byte 0xff #bad opcode
000000010000deff	lcalll	*-0x2(%rbp)
000000010000df02	.byte 0xff #bad opcode
000000010000df03	lcalll	*-0x2(%rbp)
000000010000df06	.byte 0xff #bad opcode
000000010000df07	pushq	-0x3(%rdi)
000000010000df0a	.byte 0xff #bad opcode
000000010000df0b	lcalll	*-0x2(%rbp)
000000010000df0e	.byte 0xff #bad opcode
000000010000df0f	ljmpl	*-0x3(%rsi)
000000010000df12	.byte 0xff #bad opcode
000000010000df13	decl	0xffffffd(%rcx)
000000010000df19	.byte 0x1f #bad opcode
000000010000df1a	testb	%al, (%rax)
000000010000df1c	addb	%al, (%rax)
000000010000df1e	addb	%al, (%rax)
_tp_eat:
000000010000df20	pushq	%rbp
000000010000df21	movq	%rsp, %rbp
000000010000df24	pushq	%r15
000000010000df26	pushq	%r14
000000010000df28	pushq	%r13
000000010000df2a	pushq	%r12
000000010000df2c	pushq	%rbx
000000010000df2d	pushq	%rax
000000010000df2e	movq	%rsi, %r14
000000010000df31	movq	%rdi, %rbx
000000010000df34	movq	0x8(%rdi), %r13
000000010000df38	movq	0x10(%rdi), %r12
000000010000df3c	cmpq	%r13, %r12
000000010000df3f	jae	0x10000df70
000000010000df41	movq	(%rbx), %rax
000000010000df44	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000df4e	nop
000000010000df50	movzbl	(%rax,%r12), %edx
000000010000df55	cmpq	$0x20, %rdx
000000010000df59	ja	0x10000df70
000000010000df5b	btq	%rdx, %rcx
000000010000df5f	jae	0x10000df70
000000010000df61	incq	%r12
000000010000df64	movq	%r12, 0x10(%rbx)
000000010000df68	cmpq	%r12, %r13
000000010000df6b	jne	0x10000df50
000000010000df6d	movq	%r13, %r12
000000010000df70	movq	%r14, %rdi
000000010000df73	callq	0x100012136                     ## symbol stub for: _strlen
000000010000df78	subq	%r12, %r13
000000010000df7b	xorl	%r15d, %r15d
000000010000df7e	cmpq	%rax, %r13
000000010000df81	jb	0x10000dfa8
000000010000df83	movq	(%rbx), %rdi
000000010000df86	addq	%r12, %rdi
000000010000df89	movq	%r14, %rsi
000000010000df8c	movq	%rax, %r14
000000010000df8f	movq	%rax, %rdx
000000010000df92	callq	0x1000120b2                     ## symbol stub for: _memcmp
000000010000df97	testl	%eax, %eax
000000010000df99	jne	0x10000dfa8
000000010000df9b	addq	%r14, %r12
000000010000df9e	movq	%r12, 0x10(%rbx)
000000010000dfa2	movl	$0x1, %r15d
000000010000dfa8	movl	%r15d, %eax
000000010000dfab	addq	$0x8, %rsp
000000010000dfaf	popq	%rbx
000000010000dfb0	popq	%r12
000000010000dfb2	popq	%r13
000000010000dfb4	popq	%r14
000000010000dfb6	popq	%r15
000000010000dfb8	popq	%rbp
000000010000dfb9	retq
000000010000dfba	nopw	(%rax,%rax)
_tp_list_of:
000000010000dfc0	pushq	%rbp
000000010000dfc1	movq	%rsp, %rbp
000000010000dfc4	pushq	%r15
000000010000dfc6	pushq	%r14
000000010000dfc8	pushq	%r13
000000010000dfca	pushq	%r12
000000010000dfcc	pushq	%rbx
000000010000dfcd	subq	$0x28, %rsp
000000010000dfd1	movq	%r8, %r15
000000010000dfd4	movq	%rcx, -0x40(%rbp)
000000010000dfd8	movq	%rsi, %r8
000000010000dfdb	movq	%rdi, %rbx
000000010000dfde	movq	0x8(%rdi), %r12
000000010000dfe2	movq	0x10(%rdi), %r13
000000010000dfe6	cmpq	%r12, %r13
000000010000dfe9	movq	%rdx, -0x30(%rbp)
000000010000dfed	jae	0x10000e020
000000010000dfef	movq	(%rbx), %rax
000000010000dff2	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000dffc	nopl	(%rax)
000000010000e000	movzbl	(%rax,%r13), %esi
000000010000e005	cmpq	$0x20, %rsi
000000010000e009	ja	0x10000e020
000000010000e00b	btq	%rsi, %rcx
000000010000e00f	jae	0x10000e020
000000010000e011	incq	%r13
000000010000e014	movq	%r13, 0x10(%rbx)
000000010000e018	cmpq	%r13, %r12
000000010000e01b	jne	0x10000e000
000000010000e01d	movq	%r12, %r13
000000010000e020	movq	%r8, %rdi
000000010000e023	movq	%r8, -0x48(%rbp)
000000010000e027	callq	0x100012136                     ## symbol stub for: _strlen
000000010000e02c	movq	%rax, %r14
000000010000e02f	movq	%r12, %rcx
000000010000e032	subq	%r13, %rcx
000000010000e035	xorl	%eax, %eax
000000010000e037	cmpq	%r14, %rcx
000000010000e03a	jb	0x10000e059
000000010000e03c	movq	%r15, -0x38(%rbp)
000000010000e040	movq	(%rbx), %r15
000000010000e043	leaq	(%r15,%r13), %rdi
000000010000e047	movq	-0x48(%rbp), %rsi
000000010000e04b	movq	%r14, %rdx
000000010000e04e	callq	0x1000120b2                     ## symbol stub for: _memcmp
000000010000e053	testl	%eax, %eax
000000010000e055	je	0x10000e068
000000010000e057	xorl	%eax, %eax
000000010000e059	addq	$0x28, %rsp
000000010000e05d	popq	%rbx
000000010000e05e	popq	%r12
000000010000e060	popq	%r13
000000010000e062	popq	%r14
000000010000e064	popq	%r15
000000010000e066	popq	%rbp
000000010000e067	retq
000000010000e068	addq	%r13, %r14
000000010000e06b	movq	%r14, 0x10(%rbx)
000000010000e06f	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000e079	cmpq	%r12, %r14
000000010000e07c	jae	0x10000e0b2
000000010000e07e	movq	-0x30(%rbp), %rdi
000000010000e082	nopw	%cs:(%rax,%rax)
000000010000e090	movzbl	(%r15,%r14), %eax
000000010000e095	cmpq	$0x20, %rax
000000010000e099	ja	0x10000e0b6
000000010000e09b	btq	%rax, %r13
000000010000e09f	jae	0x10000e0b6
000000010000e0a1	incq	%r14
000000010000e0a4	movq	%r14, 0x10(%rbx)
000000010000e0a8	cmpq	%r14, %r12
000000010000e0ab	jne	0x10000e090
000000010000e0ad	movq	%r12, %r14
000000010000e0b0	jmp	0x10000e0b6
000000010000e0b2	movq	-0x30(%rbp), %rdi
000000010000e0b6	callq	0x100012136                     ## symbol stub for: _strlen
000000010000e0bb	subq	%r14, %r12
000000010000e0be	cmpq	%rax, %r12
000000010000e0c1	jb	0x10000e0e0
000000010000e0c3	addq	%r14, %r15
000000010000e0c6	movq	%r15, %rdi
000000010000e0c9	movq	-0x30(%rbp), %rsi
000000010000e0cd	movq	%rax, %r12
000000010000e0d0	movq	%rax, %rdx
000000010000e0d3	callq	0x1000120b2                     ## symbol stub for: _memcmp
000000010000e0d8	testl	%eax, %eax
000000010000e0da	je	0x10000e1ba
000000010000e0e0	movq	%rbx, %rdi
000000010000e0e3	movq	-0x38(%rbp), %rsi
000000010000e0e7	callq	*-0x40(%rbp)
000000010000e0ea	testl	%eax, %eax
000000010000e0ec	je	0x10000e057
000000010000e0f2	movq	0x8(%rbx), %r15
000000010000e0f6	movq	0x10(%rbx), %r14
000000010000e0fa	cmpq	%r15, %r14
000000010000e0fd	jae	0x10000e132
000000010000e0ff	movq	(%rbx), %rax
000000010000e102	movq	-0x30(%rbp), %r12
000000010000e106	nopw	%cs:(%rax,%rax)
000000010000e110	movzbl	(%rax,%r14), %ecx
000000010000e115	cmpq	$0x20, %rcx
000000010000e119	ja	0x10000e136
000000010000e11b	btq	%rcx, %r13
000000010000e11f	jae	0x10000e136
000000010000e121	incq	%r14
000000010000e124	movq	%r14, 0x10(%rbx)
000000010000e128	cmpq	%r14, %r15
000000010000e12b	jne	0x10000e110
000000010000e12d	movq	%r15, %r14
000000010000e130	jmp	0x10000e136
000000010000e132	movq	-0x30(%rbp), %r12
000000010000e136	movq	%r12, %rdi
000000010000e139	callq	0x100012136                     ## symbol stub for: _strlen
000000010000e13e	movq	%r15, %rcx
000000010000e141	subq	%r14, %rcx
000000010000e144	cmpq	%rax, %rcx
000000010000e147	jb	0x10000e161
000000010000e149	movq	(%rbx), %rdi
000000010000e14c	addq	%r14, %rdi
000000010000e14f	movq	%r12, %rsi
000000010000e152	movq	%rax, %r12
000000010000e155	movq	%rax, %rdx
000000010000e158	callq	0x1000120b2                     ## symbol stub for: _memcmp
000000010000e15d	testl	%eax, %eax
000000010000e15f	je	0x10000e1ba
000000010000e161	cmpq	%r14, %r15
000000010000e164	jbe	0x10000e192
000000010000e166	movq	(%rbx), %rax
000000010000e169	nopl	(%rax)
000000010000e170	movzbl	(%rax,%r14), %ecx
000000010000e175	cmpq	$0x20, %rcx
000000010000e179	ja	0x10000e192
000000010000e17b	btq	%rcx, %r13
000000010000e17f	jae	0x10000e192
000000010000e181	incq	%r14
000000010000e184	movq	%r14, 0x10(%rbx)
000000010000e188	cmpq	%r14, %r15
000000010000e18b	jne	0x10000e170
000000010000e18d	jmp	0x10000e057
000000010000e192	cmpq	%r14, %r15
000000010000e195	movl	$0x0, %eax
000000010000e19a	je	0x10000e059
000000010000e1a0	movq	(%rbx), %rcx
000000010000e1a3	cmpb	$0x2c, (%rcx,%r14)
000000010000e1a8	jne	0x10000e059
000000010000e1ae	incq	%r14
000000010000e1b1	movq	%r14, 0x10(%rbx)
000000010000e1b5	jmp	0x10000e0e0
000000010000e1ba	addq	%r14, %r12
000000010000e1bd	movq	%r12, 0x10(%rbx)
000000010000e1c1	movl	$0x1, %eax
000000010000e1c6	jmp	0x10000e059
000000010000e1cb	nopl	(%rax,%rax)
_tp_byte_item:
000000010000e1d0	pushq	%rbp
000000010000e1d1	movq	%rsp, %rbp
000000010000e1d4	pushq	%rbx
000000010000e1d5	pushq	%rax
000000010000e1d6	movq	%rsi, %rbx
000000010000e1d9	leaq	_tp_byte_item.u8d(%rip), %rsi
000000010000e1e0	leaq	-0x10(%rbp), %rdx
000000010000e1e4	callq	_tp_int
000000010000e1e9	testl	%eax, %eax
000000010000e1eb	je	0x10000e200
000000010000e1ed	movq	-0x10(%rbp), %rsi
000000010000e1f1	movq	%rbx, %rdi
000000010000e1f4	callq	_tp_push
000000010000e1f9	movl	$0x1, %eax
000000010000e1fe	jmp	0x10000e202
000000010000e200	xorl	%eax, %eax
000000010000e202	addq	$0x8, %rsp
000000010000e206	popq	%rbx
000000010000e207	popq	%rbp
000000010000e208	retq
000000010000e209	nopl	(%rax)
_tp_token:
000000010000e210	pushq	%rbp
000000010000e211	movq	%rsp, %rbp
000000010000e214	pushq	%r15
000000010000e216	pushq	%r14
000000010000e218	pushq	%r12
000000010000e21a	pushq	%rbx
000000010000e21b	movq	%rsi, %r14
000000010000e21e	movq	%rdi, %rbx
000000010000e221	movq	(%rdi), %rsi
000000010000e224	movq	0x8(%rdi), %rax
000000010000e228	movq	0x10(%rdi), %r12
000000010000e22c	cmpq	%rax, %r12
000000010000e22f	jae	0x10000e265
000000010000e231	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000e23b	nopl	(%rax,%rax)
000000010000e240	movzbl	(%rsi,%r12), %edi
000000010000e245	cmpq	$0x20, %rdi
000000010000e249	ja	0x10000e265
000000010000e24b	btq	%rdi, %rcx
000000010000e24f	jae	0x10000e265
000000010000e251	incq	%r12
000000010000e254	movq	%r12, 0x10(%rbx)
000000010000e258	cmpq	%r12, %rax
000000010000e25b	jne	0x10000e240
000000010000e25d	movq	%rax, %r12
000000010000e260	movq	%rax, %rcx
000000010000e263	jmp	0x10000e2ae
000000010000e265	cmpq	%rax, %r12
000000010000e268	jae	0x10000e2ab
000000010000e26a	leaq	0x6f(%rip), %rdi
000000010000e271	movq	%r12, %rcx
000000010000e274	jmp	0x10000e292
000000010000e276	nopw	%cs:(%rax,%rax)
000000010000e280	cmpl	$0x7d, %r8d
000000010000e284	je	0x10000e2ae
000000010000e286	incq	%rcx
000000010000e289	movq	%rcx, 0x10(%rbx)
000000010000e28d	cmpq	%rcx, %rax
000000010000e290	je	0x10000e260
000000010000e292	movzbl	(%rsi,%rcx), %r8d
000000010000e297	leal	-0x9(%r8), %r9d
000000010000e29b	cmpl	$0x54, %r9d
000000010000e29f	ja	0x10000e280
000000010000e2a1	movslq	(%rdi,%r9,4), %r8
000000010000e2a5	addq	%rdi, %r8
000000010000e2a8	jmpq	*%r8
000000010000e2ab	movq	%r12, %rcx
000000010000e2ae	subq	%r12, %rcx
000000010000e2b1	leaq	-0x1(%rdx), %r15
000000010000e2b5	cmpq	%rdx, %rcx
000000010000e2b8	cmovbq	%rcx, %r15
000000010000e2bc	addq	%r12, %rsi
000000010000e2bf	movq	%r14, %rdi
000000010000e2c2	movq	%r15, %rdx
000000010000e2c5	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000e2ca	movb	$0x0, (%r14,%r15)
000000010000e2cf	movq	0x10(%rbx), %rax
000000010000e2d3	subq	%r12, %rax
000000010000e2d6	popq	%rbx
000000010000e2d7	popq	%r12
000000010000e2d9	popq	%r14
000000010000e2db	popq	%r15
000000010000e2dd	popq	%rbp
000000010000e2de	retq
000000010000e2df	nop
000000010000e2e0	.byte 0xce #bad opcode
000000010000e2e1	.byte 0xff #bad opcode
000000010000e2e2	.byte 0xff #bad opcode
000000010000e2e3	decl	%esi
000000010000e2e5	.byte 0xff #bad opcode
000000010000e2e6	.byte 0xff #bad opcode
000000010000e2e7	jmpq	*-0x59000001(%rsi)
000000010000e2ed	.byte 0xff #bad opcode
000000010000e2ee	.byte 0xff #bad opcode
000000010000e2ef	decl	%esi
000000010000e2f1	.byte 0xff #bad opcode
000000010000e2f2	.byte 0xff #bad opcode
000000010000e2f3	jmpq	*-0x59000001(%rsi)
000000010000e2f9	.byte 0xff #bad opcode
000000010000e2fa	.byte 0xff #bad opcode
000000010000e2fb	jmpq	*-0x59000001(%rsi)
000000010000e301	.byte 0xff #bad opcode
000000010000e302	.byte 0xff #bad opcode
000000010000e303	jmpq	*-0x59000001(%rsi)
000000010000e309	.byte 0xff #bad opcode
000000010000e30a	.byte 0xff #bad opcode
000000010000e30b	jmpq	*-0x59000001(%rsi)
000000010000e311	.byte 0xff #bad opcode
000000010000e312	.byte 0xff #bad opcode
000000010000e313	jmpq	*-0x59000001(%rsi)
000000010000e319	.byte 0xff #bad opcode
000000010000e31a	.byte 0xff #bad opcode
000000010000e31b	jmpq	*-0x59000001(%rsi)
000000010000e321	.byte 0xff #bad opcode
000000010000e322	.byte 0xff #bad opcode
000000010000e323	jmpq	*-0x59000001(%rsi)
000000010000e329	.byte 0xff #bad opcode
000000010000e32a	.byte 0xff #bad opcode
000000010000e32b	jmpq	*-0x59000001(%rsi)
000000010000e331	.byte 0xff #bad opcode
000000010000e332	.byte 0xff #bad opcode
000000010000e333	jmpq	*-0x59000001(%rsi)
000000010000e339	.byte 0xff #bad opcode
000000010000e33a	.byte 0xff #bad opcode
000000010000e33b	decl	%esi
000000010000e33d	.byte 0xff #bad opcode
000000010000e33e	.byte 0xff #bad opcode
000000010000e33f	jmpq	*-0x59000001(%rsi)
000000010000e345	.byte 0xff #bad opcode
000000010000e346	.byte 0xff #bad opcode
000000010000e347	jmpq	*-0x59000001(%rsi)
000000010000e34d	.byte 0xff #bad opcode
000000010000e34e	.byte 0xff #bad opcode
000000010000e34f	jmpq	*-0x59000001(%rsi)
000000010000e355	.byte 0xff #bad opcode
000000010000e356	.byte 0xff #bad opcode
000000010000e357	jmpq	*-0x31000001(%rsi)
000000010000e35d	.byte 0xff #bad opcode
000000010000e35e	.byte 0xff #bad opcode
000000010000e35f	decl	%esi
000000010000e361	.byte 0xff #bad opcode
000000010000e362	.byte 0xff #bad opcode
000000010000e363	jmpq	*-0x59000001(%rsi)
000000010000e369	.byte 0xff #bad opcode
000000010000e36a	.byte 0xff #bad opcode
000000010000e36b	decl	%esi
000000010000e36d	.byte 0xff #bad opcode
000000010000e36e	.byte 0xff #bad opcode
000000010000e36f	jmpq	*-0x59000001(%rsi)
000000010000e375	.byte 0xff #bad opcode
000000010000e376	.byte 0xff #bad opcode
000000010000e377	jmpq	*-0x59000001(%rsi)
000000010000e37d	.byte 0xff #bad opcode
000000010000e37e	.byte 0xff #bad opcode
000000010000e37f	jmpq	*-0x59000001(%rsi)
000000010000e385	.byte 0xff #bad opcode
000000010000e386	.byte 0xff #bad opcode
000000010000e387	jmpq	*-0x59000001(%rsi)
000000010000e38d	.byte 0xff #bad opcode
000000010000e38e	.byte 0xff #bad opcode
000000010000e38f	jmpq	*-0x59000001(%rsi)
000000010000e395	.byte 0xff #bad opcode
000000010000e396	.byte 0xff #bad opcode
000000010000e397	jmpq	*-0x59000001(%rsi)
000000010000e39d	.byte 0xff #bad opcode
000000010000e39e	.byte 0xff #bad opcode
000000010000e39f	jmpq	*-0x31000001(%rsi)
000000010000e3a5	.byte 0xff #bad opcode
000000010000e3a6	.byte 0xff #bad opcode
000000010000e3a7	jmpq	*-0x59000001(%rsi)
000000010000e3ad	.byte 0xff #bad opcode
000000010000e3ae	.byte 0xff #bad opcode
000000010000e3af	jmpq	*-0x59000001(%rsi)
000000010000e3b5	.byte 0xff #bad opcode
000000010000e3b6	.byte 0xff #bad opcode
000000010000e3b7	jmpq	*-0x59000001(%rsi)
000000010000e3bd	.byte 0xff #bad opcode
000000010000e3be	.byte 0xff #bad opcode
000000010000e3bf	jmpq	*-0x59000001(%rsi)
000000010000e3c5	.byte 0xff #bad opcode
000000010000e3c6	.byte 0xff #bad opcode
000000010000e3c7	jmpq	*-0x59000001(%rsi)
000000010000e3cd	.byte 0xff #bad opcode
000000010000e3ce	.byte 0xff #bad opcode
000000010000e3cf	jmpq	*-0x59000001(%rsi)
000000010000e3d5	.byte 0xff #bad opcode
000000010000e3d6	.byte 0xff #bad opcode
000000010000e3d7	jmpq	*-0x59000001(%rsi)
000000010000e3dd	.byte 0xff #bad opcode
000000010000e3de	.byte 0xff #bad opcode
000000010000e3df	jmpq	*-0x59000001(%rsi)
000000010000e3e5	.byte 0xff #bad opcode
000000010000e3e6	.byte 0xff #bad opcode
000000010000e3e7	jmpq	*-0x59000001(%rsi)
000000010000e3ed	.byte 0xff #bad opcode
000000010000e3ee	.byte 0xff #bad opcode
000000010000e3ef	jmpq	*-0x59000001(%rsi)
000000010000e3f5	.byte 0xff #bad opcode
000000010000e3f6	.byte 0xff #bad opcode
000000010000e3f7	jmpq	*-0x59000001(%rsi)
000000010000e3fd	.byte 0xff #bad opcode
000000010000e3fe	.byte 0xff #bad opcode
000000010000e3ff	jmpq	*-0x59000001(%rsi)
000000010000e405	.byte 0xff #bad opcode
000000010000e406	.byte 0xff #bad opcode
000000010000e407	jmpq	*-0x59000001(%rsi)
000000010000e40d	.byte 0xff #bad opcode
000000010000e40e	.byte 0xff #bad opcode
000000010000e40f	jmpq	*-0x59000001(%rsi)
000000010000e415	.byte 0xff #bad opcode
000000010000e416	.byte 0xff #bad opcode
000000010000e417	jmpq	*-0x59000001(%rsi)
000000010000e41d	.byte 0xff #bad opcode
000000010000e41e	.byte 0xff #bad opcode
000000010000e41f	jmpq	*-0x59000001(%rsi)
000000010000e425	.byte 0xff #bad opcode
000000010000e426	.byte 0xff #bad opcode
000000010000e427	jmpq	*-0x59000001(%rsi)
000000010000e42d	.byte 0xff #bad opcode
000000010000e42e	.byte 0xff #bad opcode
000000010000e42f	decl	%esi
000000010000e431	.byte 0xff #bad opcode
000000010000e432	.byte 0xff #bad opcode
000000010000e433	jmpq	*0x66(%rsi)
000000010000e436	nopw	%cs:(%rax,%rax)
_tp_elem_item:
000000010000e440	pushq	%rbp
000000010000e441	movq	%rsp, %rbp
000000010000e444	pushq	%r14
000000010000e446	pushq	%rbx
000000010000e447	subq	$0x10, %rsp
000000010000e44b	movq	%rsi, %rbx
000000010000e44e	movq	(%rsi), %rsi
000000010000e451	xorl	%r14d, %r14d
000000010000e454	leaq	-0x18(%rbp), %rcx
000000010000e458	xorl	%edx, %edx
000000010000e45a	callq	_tp_value
000000010000e45f	testl	%eax, %eax
000000010000e461	je	0x10000e475
000000010000e463	movq	-0x18(%rbp), %rsi
000000010000e467	movq	%rbx, %rdi
000000010000e46a	callq	_tp_push
000000010000e46f	movl	$0x1, %r14d
000000010000e475	movl	%r14d, %eax
000000010000e478	addq	$0x10, %rsp
000000010000e47c	popq	%rbx
000000010000e47d	popq	%r14
000000010000e47f	popq	%rbp
000000010000e480	retq
000000010000e481	nopw	%cs:(%rax,%rax)
_tp_kv_item:
000000010000e490	pushq	%rbp
000000010000e491	movq	%rsp, %rbp
000000010000e494	pushq	%r15
000000010000e496	pushq	%r14
000000010000e498	pushq	%rbx
000000010000e499	subq	$0x18, %rsp
000000010000e49d	movq	%rsi, %rbx
000000010000e4a0	movq	%rdi, %r14
000000010000e4a3	movq	$0x0, -0x20(%rbp)
000000010000e4ab	movq	(%rsi), %rsi
000000010000e4ae	xorl	%r15d, %r15d
000000010000e4b1	leaq	-0x28(%rbp), %rcx
000000010000e4b5	xorl	%edx, %edx
000000010000e4b7	callq	_tp_value
000000010000e4bc	testl	%eax, %eax
000000010000e4be	je	0x10000e4e6
000000010000e4c0	cmpl	$0x0, 0x28(%rbx)
000000010000e4c4	je	0x10000e4f4
000000010000e4c6	xorl	%r14d, %r14d
000000010000e4c9	movq	-0x28(%rbp), %rsi
000000010000e4cd	movq	%rbx, %rdi
000000010000e4d0	callq	_tp_push
000000010000e4d5	movq	%rbx, %rdi
000000010000e4d8	movq	%r14, %rsi
000000010000e4db	callq	_tp_push
000000010000e4e0	movl	$0x1, %r15d
000000010000e4e6	movl	%r15d, %eax
000000010000e4e9	addq	$0x18, %rsp
000000010000e4ed	popq	%rbx
000000010000e4ee	popq	%r14
000000010000e4f0	popq	%r15
000000010000e4f2	popq	%rbp
000000010000e4f3	retq
000000010000e4f4	movq	0x8(%r14), %rcx
000000010000e4f8	movq	0x10(%r14), %rax
000000010000e4fc	cmpq	%rcx, %rax
000000010000e4ff	jae	0x10000e531
000000010000e501	movq	(%r14), %rdx
000000010000e504	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000e50e	nop
000000010000e510	movzbl	(%rdx,%rax), %edi
000000010000e514	cmpq	$0x20, %rdi
000000010000e518	ja	0x10000e531
000000010000e51a	btq	%rdi, %rsi
000000010000e51e	jae	0x10000e531
000000010000e520	incq	%rax
000000010000e523	movq	%rax, 0x10(%r14)
000000010000e527	cmpq	%rax, %rcx
000000010000e52a	jne	0x10000e510
000000010000e52c	xorl	%r15d, %r15d
000000010000e52f	jmp	0x10000e4e6
000000010000e531	xorl	%r15d, %r15d
000000010000e534	cmpq	%rax, %rcx
000000010000e537	je	0x10000e4e6
000000010000e539	movq	(%r14), %rcx
000000010000e53c	cmpb	$0x3a, (%rcx,%rax)
000000010000e540	jne	0x10000e4e6
000000010000e542	incq	%rax
000000010000e545	movq	%rax, 0x10(%r14)
000000010000e549	movq	0x8(%rbx), %rsi
000000010000e54d	xorl	%r15d, %r15d
000000010000e550	leaq	-0x20(%rbp), %rcx
000000010000e554	movq	%r14, %rdi
000000010000e557	xorl	%edx, %edx
000000010000e559	callq	_tp_value
000000010000e55e	testl	%eax, %eax
000000010000e560	je	0x10000e4e6
000000010000e562	movq	-0x20(%rbp), %r14
000000010000e566	jmp	0x10000e4c9
000000010000e56b	nopl	(%rax,%rax)
_fwp_p_map_insert:
000000010000e570	pushq	%rbp
000000010000e571	movq	%rsp, %rbp
000000010000e574	pushq	%r15
000000010000e576	pushq	%r14
000000010000e578	pushq	%r13
000000010000e57a	pushq	%r12
000000010000e57c	pushq	%rbx
000000010000e57d	subq	$0x38, %rsp
000000010000e581	movq	%rdi, %r8
000000010000e584	movq	(%rdx), %r12
000000010000e587	movq	%rcx, -0x58(%rbp)
000000010000e58b	movl	(%rcx), %eax
000000010000e58d	cmpl	$0x4, %eax
000000010000e590	movq	%rsi, -0x40(%rbp)
000000010000e594	jb	0x10000e5f8
000000010000e596	addl	$-0x5, %eax
000000010000e599	cmpl	$0x4, %eax
000000010000e59c	jae	0x10000e65d
000000010000e5a2	testq	%r12, %r12
000000010000e5a5	je	0x10000e6d2
000000010000e5ab	xorl	%r15d, %r15d
000000010000e5ae	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000e5b8	movq	%r12, %rcx
000000010000e5bb	jmp	0x10000e5cc
000000010000e5bd	nopl	(%rax)
000000010000e5c0	movq	%rdi, %rcx
000000010000e5c3	cmpq	%rcx, %r15
000000010000e5c6	jae	0x10000e6d7
000000010000e5cc	leaq	(%rcx,%r15), %rsi
000000010000e5d0	movq	%rsi, %rdi
000000010000e5d3	shrq	%rdi
000000010000e5d6	andq	%rax, %rsi
000000010000e5d9	movq	0x8(%rdx,%rsi,8), %rsi
000000010000e5de	cmpq	%r8, %rsi
000000010000e5e1	setne	%bl
000000010000e5e4	je	0x10000e658
000000010000e5e6	jae	0x10000e5c0
000000010000e5e8	incq	%rdi
000000010000e5eb	movq	%rdi, %r15
000000010000e5ee	cmpq	%rcx, %r15
000000010000e5f1	jb	0x10000e5cc
000000010000e5f3	jmp	0x10000e6d7
000000010000e5f8	testq	%r12, %r12
000000010000e5fb	je	0x10000e6d2
000000010000e601	xorl	%r15d, %r15d
000000010000e604	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000e60e	movq	%r12, %rcx
000000010000e611	jmp	0x10000e62c
000000010000e613	nopw	%cs:(%rax,%rax)
000000010000e620	movq	%rdi, %rcx
000000010000e623	cmpq	%rcx, %r15
000000010000e626	jae	0x10000e6d7
000000010000e62c	leaq	(%rcx,%r15), %rsi
000000010000e630	movq	%rsi, %rdi
000000010000e633	shrq	%rdi
000000010000e636	andq	%rax, %rsi
000000010000e639	movq	0x8(%rdx,%rsi,8), %rsi
000000010000e63e	cmpq	%r8, %rsi
000000010000e641	setne	%bl
000000010000e644	je	0x10000e658
000000010000e646	jge	0x10000e620
000000010000e648	incq	%rdi
000000010000e64b	movq	%rdi, %r15
000000010000e64e	cmpq	%rcx, %r15
000000010000e651	jb	0x10000e62c
000000010000e653	jmp	0x10000e6d7
000000010000e658	movq	%rdi, %r15
000000010000e65b	jmp	0x10000e6d7
000000010000e65d	testq	%r12, %r12
000000010000e660	je	0x10000e6d2
000000010000e662	xorl	%r15d, %r15d
000000010000e665	movq	%r12, %rax
000000010000e668	movq	%r12, -0x38(%rbp)
000000010000e66c	jmp	0x10000e682
000000010000e66e	nop
000000010000e670	movq	%r12, %rax
000000010000e673	movq	%r14, %rdx
000000010000e676	movq	%r13, %r8
000000010000e679	cmpq	%rax, %r15
000000010000e67c	movq	-0x38(%rbp), %r12
000000010000e680	jae	0x10000e6d7
000000010000e682	movq	%rax, -0x50(%rbp)
000000010000e686	addq	%r15, %rax
000000010000e689	movq	%rax, %r12
000000010000e68c	shrq	%r12
000000010000e68f	movabsq	$0x1ffffffffffffffe, %rcx       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000e699	andq	%rcx, %rax
000000010000e69c	movq	%rdx, %r14
000000010000e69f	movq	0x8(%rdx,%rax,8), %rdi
000000010000e6a4	movq	%r8, %r13
000000010000e6a7	movq	%r8, %rsi
000000010000e6aa	movq	-0x58(%rbp), %rdx
000000010000e6ae	callq	_fwp_cmp
000000010000e6b3	testl	%eax, %eax
000000010000e6b5	setne	%bl
000000010000e6b8	je	0x10000e7fb
000000010000e6be	jns	0x10000e670
000000010000e6c0	incq	%r12
000000010000e6c3	movq	%r12, %r15
000000010000e6c6	movq	%r14, %rdx
000000010000e6c9	movq	%r13, %r8
000000010000e6cc	movq	-0x50(%rbp), %rax
000000010000e6d0	jmp	0x10000e679
000000010000e6d2	movb	$0x1, %bl
000000010000e6d4	xorl	%r15d, %r15d
000000010000e6d7	movzbl	%bl, %r14d
000000010000e6db	addq	%r12, %r14
000000010000e6de	movq	%r14, %rax
000000010000e6e1	shlq	$0x4, %rax
000000010000e6e5	leaq	0x8(%rax), %rdi
000000010000e6e9	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000e6f0	movq	%rdx, -0x30(%rbp)
000000010000e6f4	movq	%r8, -0x48(%rbp)
000000010000e6f8	ja	0x10000e753
000000010000e6fa	addq	$0x17, %rax
000000010000e6fe	shrq	$0x4, %rax
000000010000e702	leaq	_fwp_gc(%rip), %rcx
000000010000e709	movzbl	0xbe8(%rax,%rcx), %eax
000000010000e711	movl	0xb48(%rcx,%rax,4), %esi
000000010000e718	subq	%rsi, _fwp_gc(%rip)
000000010000e71f	js	0x10000e753
000000010000e721	leaq	(%rax,%rax,2), %rax
000000010000e725	leaq	(%rcx,%rax,8), %rax
000000010000e729	addq	$0x788, %rax                    ## imm = 0x788
000000010000e72f	movq	(%rax), %r13
000000010000e732	testq	%r13, %r13
000000010000e735	je	0x10000e743
000000010000e737	movq	(%r13), %rcx
000000010000e73b	notq	%rcx
000000010000e73e	movq	%rcx, (%rax)
000000010000e741	jmp	0x10000e76a
000000010000e743	movq	0x8(%rax), %r13
000000010000e747	movq	0x10(%rax), %rcx
000000010000e74b	subq	%r13, %rcx
000000010000e74e	cmpq	%rsi, %rcx
000000010000e751	jae	0x10000e762
000000010000e753	movl	$0x2, %esi
000000010000e758	callq	_fwp_gc_alloc_slow
000000010000e75d	movq	%rax, %r13
000000010000e760	jmp	0x10000e772
000000010000e762	leaq	(%rsi,%r13), %rcx
000000010000e766	movq	%rcx, 0x8(%rax)
000000010000e76a	movq	%r13, %rdi
000000010000e76d	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000e772	movq	%r14, (%r13)
000000010000e776	leaq	0x8(%r13), %r14
000000010000e77a	movq	-0x30(%rbp), %rsi
000000010000e77e	addq	$0x8, %rsi
000000010000e782	testb	%bl, %bl
000000010000e784	je	0x10000e7cd
000000010000e786	movq	%r15, %rbx
000000010000e789	shlq	$0x4, %rbx
000000010000e78d	movq	%r14, %rdi
000000010000e790	movq	%rbx, %rdx
000000010000e793	movq	%rsi, -0x30(%rbp)
000000010000e797	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000e79c	movq	-0x48(%rbp), %rax
000000010000e7a0	movq	%rax, (%r14,%rbx)
000000010000e7a4	movq	-0x40(%rbp), %rax
000000010000e7a8	movq	%rax, 0x8(%r14,%rbx)
000000010000e7ad	leaq	(%r14,%rbx), %rdi
000000010000e7b1	addq	$0x10, %rdi
000000010000e7b5	addq	-0x30(%rbp), %rbx
000000010000e7b9	subq	%r15, %r12
000000010000e7bc	shlq	$0x4, %r12
000000010000e7c0	movq	%rbx, %rsi
000000010000e7c3	movq	%r12, %rdx
000000010000e7c6	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000e7cb	jmp	0x10000e7e9
000000010000e7cd	shlq	$0x4, %r12
000000010000e7d1	movq	%r14, %rdi
000000010000e7d4	movq	%r12, %rdx
000000010000e7d7	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000e7dc	shlq	$0x4, %r15
000000010000e7e0	movq	-0x40(%rbp), %rax
000000010000e7e4	movq	%rax, 0x8(%r14,%r15)
000000010000e7e9	movq	%r13, %rax
000000010000e7ec	addq	$0x38, %rsp
000000010000e7f0	popq	%rbx
000000010000e7f1	popq	%r12
000000010000e7f3	popq	%r13
000000010000e7f5	popq	%r14
000000010000e7f7	popq	%r15
000000010000e7f9	popq	%rbp
000000010000e7fa	retq
000000010000e7fb	movq	%r12, %r15
000000010000e7fe	movq	-0x38(%rbp), %r12
000000010000e802	movq	%r14, %rdx
000000010000e805	movq	%r13, %r8
000000010000e808	jmp	0x10000e6d7
000000010000e80d	nopl	(%rax)
_fwp_box_i128:
000000010000e810	pushq	%rbp
000000010000e811	movq	%rsp, %rbp
000000010000e814	pushq	%r14
000000010000e816	pushq	%rbx
000000010000e817	leaq	_fwp_gc(%rip), %rax
000000010000e81e	movzbl	0x73cc(%rip), %edx
000000010000e825	movl	0xb48(%rax,%rdx,4), %ecx
000000010000e82c	subq	%rcx, _fwp_gc(%rip)
000000010000e833	js	0x10000e867
000000010000e835	leaq	(%rdx,%rdx,2), %rdx
000000010000e839	leaq	(%rax,%rdx,8), %rdx
000000010000e83d	addq	$0x3c8, %rdx                    ## imm = 0x3C8
000000010000e844	movq	(%rdx), %rax
000000010000e847	testq	%rax, %rax
000000010000e84a	je	0x10000e857
000000010000e84c	movq	(%rax), %rcx
000000010000e84f	notq	%rcx
000000010000e852	movq	%rcx, (%rdx)
000000010000e855	jmp	0x10000e88b
000000010000e857	movq	0x8(%rdx), %rax
000000010000e85b	movq	0x10(%rdx), %r8
000000010000e85f	subq	%rax, %r8
000000010000e862	cmpq	%rcx, %r8
000000010000e865	jae	0x10000e884
000000010000e867	movq	%rdi, %rbx
000000010000e86a	movl	$0x10, %edi
000000010000e86f	movq	%rsi, %r14
000000010000e872	movl	$0x1, %esi
000000010000e877	callq	_fwp_gc_alloc_slow
000000010000e87c	movq	%r14, %rsi
000000010000e87f	movq	%rbx, %rdi
000000010000e882	jmp	0x10000e891
000000010000e884	addq	%rax, %rcx
000000010000e887	movq	%rcx, 0x8(%rdx)
000000010000e88b	xorps	%xmm0, %xmm0
000000010000e88e	movups	%xmm0, (%rax)
000000010000e891	movq	%rsi, 0x8(%rax)
000000010000e895	movq	%rdi, (%rax)
000000010000e898	popq	%rbx
000000010000e899	popq	%r14
000000010000e89b	popq	%rbp
000000010000e89c	retq
000000010000e89d	nopl	(%rax)
_fwp_utf8_put:
000000010000e8a0	pushq	%rbp
000000010000e8a1	movq	%rsp, %rbp
000000010000e8a4	subq	$0x10, %rsp
000000010000e8a8	cmpl	$0x7f, %esi
000000010000e8ab	ja	0x10000e8bb
000000010000e8ad	movb	%sil, -0x4(%rbp)
000000010000e8b1	movl	$0x1, %edx
000000010000e8b6	jmp	0x10000e958
000000010000e8bb	movl	%esi, %eax
000000010000e8bd	cmpl	$0x7ff, %esi                    ## imm = 0x7FF
000000010000e8c3	ja	0x10000e8e0
000000010000e8c5	shrl	$0x6, %eax
000000010000e8c8	orb	$-0x40, %al
000000010000e8ca	movb	%al, -0x4(%rbp)
000000010000e8cd	andb	$0x3f, %sil
000000010000e8d1	orb	$-0x80, %sil
000000010000e8d5	movb	%sil, -0x3(%rbp)
000000010000e8d9	movl	$0x2, %edx
000000010000e8de	jmp	0x10000e958
000000010000e8e0	cmpl	$0xffff, %esi                   ## imm = 0xFFFF
000000010000e8e6	ja	0x10000e90f
000000010000e8e8	shrl	$0xc, %eax
000000010000e8eb	orb	$-0x20, %al
000000010000e8ed	movb	%al, -0x4(%rbp)
000000010000e8f0	movl	%esi, %eax
000000010000e8f2	shrl	$0x6, %eax
000000010000e8f5	andb	$0x3f, %al
000000010000e8f7	orb	$-0x80, %al
000000010000e8f9	movb	%al, -0x3(%rbp)
000000010000e8fc	andb	$0x3f, %sil
000000010000e900	orb	$-0x80, %sil
000000010000e904	movb	%sil, -0x2(%rbp)
000000010000e908	movl	$0x3, %edx
000000010000e90d	jmp	0x10000e958
000000010000e90f	shrl	$0x12, %eax
000000010000e912	movl	%esi, %ecx
000000010000e914	shrl	$0xc, %ecx
000000010000e917	andb	$0x3f, %cl
000000010000e91a	movl	%esi, %edx
000000010000e91c	shrl	$0x6, %edx
000000010000e91f	movd	%eax, %xmm0
000000010000e923	movzbl	%cl, %eax
000000010000e926	pinsrb	$0x1, %eax, %xmm0
000000010000e92c	andb	$0x3f, %dl
000000010000e92f	movzbl	%dl, %eax
000000010000e932	pinsrb	$0x2, %eax, %xmm0
000000010000e938	andb	$0x3f, %sil
000000010000e93c	movzbl	%sil, %eax
000000010000e940	pinsrb	$0x3, %eax, %xmm0
000000010000e946	por	0x3932(%rip), %xmm0
000000010000e94e	movd	%xmm0, -0x4(%rbp)
000000010000e953	movl	$0x4, %edx
000000010000e958	leaq	-0x4(%rbp), %rsi
000000010000e95c	callq	_buf_put
000000010000e961	addq	$0x10, %rsp
000000010000e965	popq	%rbp
000000010000e966	retq
000000010000e967	nopw	(%rax,%rax)
_tp_push:
000000010000e970	pushq	%rbp
000000010000e971	movq	%rsp, %rbp
000000010000e974	pushq	%r15
000000010000e976	pushq	%r14
000000010000e978	pushq	%r13
000000010000e97a	pushq	%r12
000000010000e97c	pushq	%rbx
000000010000e97d	pushq	%rax
000000010000e97e	movq	%rsi, %rdx
000000010000e981	movq	%rdi, %r14
000000010000e984	movq	0x18(%rdi), %r15
000000010000e988	cmpq	0x20(%rdi), %r15
000000010000e98c	jne	0x10000e9ff
000000010000e98e	leaq	(%r15,%r15), %rax
000000010000e992	testq	%r15, %r15
000000010000e995	movl	$0x8, %r13d
000000010000e99b	cmovneq	%rax, %r13
000000010000e99f	movq	%r13, 0x20(%r14)
000000010000e9a3	movq	0x10(%r14), %r12
000000010000e9a7	shlq	$0x3, %r13
000000010000e9ab	cmpq	$0x4000, %r13                   ## imm = 0x4000
000000010000e9b2	movq	%rdx, -0x30(%rbp)
000000010000e9b6	ja	0x10000ea15
000000010000e9b8	movq	%r13, %rcx
000000010000e9bb	shrq	$0x4, %rcx
000000010000e9bf	leaq	_fwp_gc(%rip), %rax
000000010000e9c6	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000e9ce	movl	0xb48(%rax,%rcx,4), %esi
000000010000e9d5	subq	%rsi, _fwp_gc(%rip)
000000010000e9dc	js	0x10000ea15
000000010000e9de	leaq	(%rcx,%rcx,2), %rcx
000000010000e9e2	leaq	(%rax,%rcx,8), %rax
000000010000e9e6	addq	$0x788, %rax                    ## imm = 0x788
000000010000e9ec	movq	(%rax), %rbx
000000010000e9ef	testq	%rbx, %rbx
000000010000e9f2	je	0x10000ea05
000000010000e9f4	movq	(%rbx), %rcx
000000010000e9f7	notq	%rcx
000000010000e9fa	movq	%rcx, (%rax)
000000010000e9fd	jmp	0x10000ea34
000000010000e9ff	movq	0x10(%r14), %rbx
000000010000ea03	jmp	0x10000ea6e
000000010000ea05	movq	0x8(%rax), %rbx
000000010000ea09	movq	0x10(%rax), %rcx
000000010000ea0d	subq	%rbx, %rcx
000000010000ea10	cmpq	%rsi, %rcx
000000010000ea13	jae	0x10000ea2c
000000010000ea15	movq	%r13, %rdi
000000010000ea18	movl	$0x2, %esi
000000010000ea1d	callq	_fwp_gc_alloc_slow
000000010000ea22	movq	%rax, %rbx
000000010000ea25	testq	%r12, %r12
000000010000ea28	jne	0x10000ea41
000000010000ea2a	jmp	0x10000ea62
000000010000ea2c	leaq	(%rbx,%rsi), %rcx
000000010000ea30	movq	%rcx, 0x8(%rax)
000000010000ea34	movq	%rbx, %rdi
000000010000ea37	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000ea3c	testq	%r12, %r12
000000010000ea3f	je	0x10000ea62
000000010000ea41	shlq	$0x3, %r15
000000010000ea45	cmpq	%r13, %r15
000000010000ea48	cmovaeq	%r13, %r15
000000010000ea4c	movq	%rbx, %rdi
000000010000ea4f	movq	%r12, %rsi
000000010000ea52	movq	%r15, %rdx
000000010000ea55	callq	0x1000120b8                     ## symbol stub for: _memcpy
000000010000ea5a	movq	%r12, %rdi
000000010000ea5d	callq	_fwp_mem_free
000000010000ea62	movq	%rbx, 0x10(%r14)
000000010000ea66	movq	0x18(%r14), %r15
000000010000ea6a	movq	-0x30(%rbp), %rdx
000000010000ea6e	leaq	0x1(%r15), %rax
000000010000ea72	movq	%rax, 0x18(%r14)
000000010000ea76	movq	%rdx, (%rbx,%r15,8)
000000010000ea7a	addq	$0x8, %rsp
000000010000ea7e	popq	%rbx
000000010000ea7f	popq	%r12
000000010000ea81	popq	%r13
000000010000ea83	popq	%r14
000000010000ea85	popq	%r15
000000010000ea87	popq	%rbp
000000010000ea88	retq
000000010000ea89	nopl	(%rax)
_fwp_cmp:
000000010000ea90	pushq	%rbp
000000010000ea91	movq	%rsp, %rbp
000000010000ea94	pushq	%r15
000000010000ea96	pushq	%r14
000000010000ea98	pushq	%r13
000000010000ea9a	pushq	%r12
000000010000ea9c	pushq	%rbx
000000010000ea9d	subq	$0x38, %rsp
000000010000eaa1	movq	%rsi, %rbx
000000010000eaa4	movq	%rdi, %r14
000000010000eaa7	movl	(%rdx), %r13d
000000010000eaaa	cmpq	$0x15, %r13
000000010000eaae	ja	0x10000ead5
000000010000eab0	movq	%rdx, %r15
000000010000eab3	leaq	0x4ba(%rip), %rax
000000010000eaba	movslq	(%rax,%r13,4), %rcx
000000010000eabe	addq	%rax, %rcx
000000010000eac1	jmpq	*%rcx
000000010000eac3	xorl	%ecx, %ecx
000000010000eac5	cmpq	%rbx, %r14
000000010000eac8	setg	%cl
000000010000eacb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ead0	cmovgel	%ecx, %eax
000000010000ead3	jmp	0x10000eae5
000000010000ead5	xorl	%ecx, %ecx
000000010000ead7	cmpq	%rbx, %r14
000000010000eada	seta	%cl
000000010000eadd	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000eae2	cmovael	%ecx, %eax
000000010000eae5	addq	$0x38, %rsp
000000010000eae9	popq	%rbx
000000010000eaea	popq	%r12
000000010000eaec	popq	%r13
000000010000eaee	popq	%r14
000000010000eaf0	popq	%r15
000000010000eaf2	popq	%rbp
000000010000eaf3	retq
000000010000eaf4	movq	%rbx, %rsi
000000010000eaf7	movq	(%r14), %rbx
000000010000eafa	movq	(%rsi), %r15
000000010000eafd	addq	$0x8, %r14
000000010000eb01	addq	$0x8, %rsi
000000010000eb05	cmpq	%r15, %rbx
000000010000eb08	movq	%r15, %rdx
000000010000eb0b	cmovbq	%rbx, %rdx
000000010000eb0f	movq	%r14, %rdi
000000010000eb12	callq	0x1000120b2                     ## symbol stub for: _memcmp
000000010000eb17	testl	%eax, %eax
000000010000eb19	je	0x10000eeb5
000000010000eb1f	sarl	$0x1f, %eax
000000010000eb22	orl	$0x1, %eax
000000010000eb25	jmp	0x10000eae5
000000010000eb27	movq	%r14, -0x30(%rbp)
000000010000eb2b	movq	(%r14), %rax
000000010000eb2e	movq	(%rbx), %r12
000000010000eb31	cmpq	%r12, %rax
000000010000eb34	movq	%r12, -0x38(%rbp)
000000010000eb38	movq	%rax, -0x40(%rbp)
000000010000eb3c	cmovbq	%rax, %r12
000000010000eb40	testq	%r12, %r12
000000010000eb43	je	0x10000ebac
000000010000eb45	movq	%rbx, %r14
000000010000eb48	movq	0x38(%r15), %rax
000000010000eb4c	movq	%rax, -0x48(%rbp)
000000010000eb50	movl	$0x10, %ebx
000000010000eb55	jmp	0x10000eb69
000000010000eb57	nopw	(%rax,%rax)
000000010000eb60	addq	$0x10, %rbx
000000010000eb64	decq	%r12
000000010000eb67	je	0x10000ebac
000000010000eb69	movq	-0x30(%rbp), %rax
000000010000eb6d	movq	-0x8(%rax,%rbx), %rdi
000000010000eb72	movq	-0x8(%r14,%rbx), %rsi
000000010000eb77	movq	-0x48(%rbp), %rdx
000000010000eb7b	callq	_fwp_cmp
000000010000eb80	testl	%eax, %eax
000000010000eb82	jne	0x10000eae5
000000010000eb88	cmpl	$0x12, %r13d
000000010000eb8c	jne	0x10000eb60
000000010000eb8e	movq	-0x30(%rbp), %rax
000000010000eb92	movq	(%rax,%rbx), %rdi
000000010000eb96	movq	(%r14,%rbx), %rsi
000000010000eb9a	movq	0x40(%r15), %rdx
000000010000eb9e	callq	_fwp_cmp
000000010000eba3	testl	%eax, %eax
000000010000eba5	je	0x10000eb60
000000010000eba7	jmp	0x10000eae5
000000010000ebac	xorl	%ecx, %ecx
000000010000ebae	movq	-0x38(%rbp), %rax
000000010000ebb2	cmpq	%rax, -0x40(%rbp)
000000010000ebb6	jmp	0x10000eada
000000010000ebbb	movq	(%r14), %rdx
000000010000ebbe	movq	0x8(%r14), %rcx
000000010000ebc2	movq	(%rbx), %rdi
000000010000ebc5	movq	0x8(%rbx), %rsi
000000010000ebc9	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ebce	cmpq	%rdi, %rdx
000000010000ebd1	movq	%rcx, %r8
000000010000ebd4	sbbq	%rsi, %r8
000000010000ebd7	jb	0x10000eae5
000000010000ebdd	cmpq	%rdx, %rdi
000000010000ebe0	sbbq	%rcx, %rsi
000000010000ebe3	setb	%al
000000010000ebe6	movzbl	%al, %eax
000000010000ebe9	jmp	0x10000eae5
000000010000ebee	movl	%r14d, %ecx
000000010000ebf1	sarl	$0x1f, %ecx
000000010000ebf4	shrl	%ecx
000000010000ebf6	xorl	%r14d, %ecx
000000010000ebf9	movl	%ebx, %edx
000000010000ebfb	sarl	$0x1f, %edx
000000010000ebfe	shrl	%edx
000000010000ec00	xorl	%ebx, %edx
000000010000ec02	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ec07	cmpl	%edx, %ecx
000000010000ec09	jl	0x10000eae5
000000010000ec0f	jmp	0x10000ec39
000000010000ec11	movq	%r14, %rcx
000000010000ec14	sarq	$0x3f, %rcx
000000010000ec18	shrq	%rcx
000000010000ec1b	xorq	%r14, %rcx
000000010000ec1e	movq	%rbx, %rdx
000000010000ec21	sarq	$0x3f, %rdx
000000010000ec25	shrq	%rdx
000000010000ec28	xorq	%rbx, %rdx
000000010000ec2b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ec30	cmpq	%rdx, %rcx
000000010000ec33	jl	0x10000eae5
000000010000ec39	setg	%al
000000010000ec3c	movzbl	%al, %eax
000000010000ec3f	jmp	0x10000eae5
000000010000ec44	movq	(%r14), %rdx
000000010000ec47	movq	0x8(%r14), %rcx
000000010000ec4b	movq	(%rbx), %rdi
000000010000ec4e	movq	0x8(%rbx), %rsi
000000010000ec52	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ec57	cmpq	%rdi, %rdx
000000010000ec5a	movq	%rcx, %r8
000000010000ec5d	sbbq	%rsi, %r8
000000010000ec60	jl	0x10000eae5
000000010000ec66	cmpq	%rdx, %rdi
000000010000ec69	sbbq	%rcx, %rsi
000000010000ec6c	setl	%al
000000010000ec6f	movzbl	%al, %eax
000000010000ec72	jmp	0x10000eae5
000000010000ec77	testq	%r14, %r14
000000010000ec7a	sete	%al
000000010000ec7d	testq	%rbx, %rbx
000000010000ec80	sete	%cl
000000010000ec83	orb	%al, %cl
000000010000ec85	je	0x10000eebf
000000010000ec8b	testq	%rbx, %rbx
000000010000ec8e	setne	%cl
000000010000ec91	orb	%al, %cl
000000010000ec93	xorb	$0x1, %cl
000000010000ec96	movzbl	%cl, %ecx
000000010000ec99	testb	%al, %al
000000010000ec9b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000eca0	cmovel	%ecx, %eax
000000010000eca3	testq	%rbx, %rbx
000000010000eca6	cmovel	%ecx, %eax
000000010000eca9	jmp	0x10000eae5
000000010000ecae	movq	%r14, %r13
000000010000ecb1	movq	%rbx, %r14
000000010000ecb4	movslq	0x10(%r15), %rbx
000000010000ecb8	testq	%rbx, %rbx
000000010000ecbb	jle	0x10000ef6a
000000010000ecc1	movq	0x20(%r15), %r15
000000010000ecc5	xorl	%r12d, %r12d
000000010000ecc8	nopl	(%rax,%rax)
000000010000ecd0	movq	0x8(%r13,%r12,8), %rdi
000000010000ecd5	movq	0x8(%r14,%r12,8), %rsi
000000010000ecda	movq	(%r15,%r12,8), %rdx
000000010000ecde	callq	_fwp_cmp
000000010000ece3	testl	%eax, %eax
000000010000ece5	jne	0x10000eae5
000000010000eceb	incq	%r12
000000010000ecee	xorl	%eax, %eax
000000010000ecf0	cmpq	%r12, %rbx
000000010000ecf3	jne	0x10000ecd0
000000010000ecf5	jmp	0x10000eae5
000000010000ecfa	movq	(%r14), %rax
000000010000ecfd	movabsq	$0x7fffffffffffffff, %r13       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000ed07	movq	%rax, -0x30(%rbp)
000000010000ed0b	andq	%r13, %rax
000000010000ed0e	movq	(%rbx), %rcx
000000010000ed11	movq	%rcx, -0x48(%rbp)
000000010000ed15	andq	%rcx, %r13
000000010000ed18	cmpq	%r13, %rax
000000010000ed1b	movq	%r13, -0x58(%rbp)
000000010000ed1f	movq	%rax, -0x50(%rbp)
000000010000ed23	cmovbq	%rax, %r13
000000010000ed27	testq	%r13, %r13
000000010000ed2a	je	0x10000ee80
000000010000ed30	movq	0x38(%r15), %r15
000000010000ed34	leaq	0x8(%r14), %rax
000000010000ed38	movq	%rax, -0x40(%rbp)
000000010000ed3c	leaq	0x8(%rbx), %rax
000000010000ed40	movq	%rax, -0x38(%rbp)
000000010000ed44	xorl	%r12d, %r12d
000000010000ed47	nopw	(%rax,%rax)
000000010000ed50	movl	$0x8, %eax
000000010000ed55	testq	%r15, %r15
000000010000ed58	je	0x10000ed6e
000000010000ed5a	movl	(%r15), %ecx
000000010000ed5d	cmpq	$0xa, %rcx
000000010000ed61	ja	0x10000ed6e
000000010000ed63	leaq	0x37fe(%rip), %rax
000000010000ed6a	movq	(%rax,%rcx,8), %rax
000000010000ed6e	movq	-0x40(%rbp), %rcx
000000010000ed72	cmpq	$0x0, -0x30(%rbp)
000000010000ed77	jns	0x10000ed7d
000000010000ed79	movq	0x10(%r14), %rcx
000000010000ed7d	movq	%rax, %rdx
000000010000ed80	imulq	%r12, %rdx
000000010000ed84	cmpq	$0x8, %rax
000000010000ed88	je	0x10000edb5
000000010000ed8a	cmpq	$0x2, %rax
000000010000ed8e	je	0x10000eda5
000000010000ed90	cmpq	$0x1, %rax
000000010000ed94	jne	0x10000edc3
000000010000ed96	movzbl	(%rcx,%rdx), %ecx
000000010000ed9a	movl	(%r15), %eax
000000010000ed9d	testl	%eax, %eax
000000010000ed9f	movsbq	%cl, %rdi
000000010000eda3	jmp	0x10000edcf
000000010000eda5	movzwl	(%rcx,%rdx), %ecx
000000010000eda9	movl	(%r15), %eax
000000010000edac	cmpl	$0x1, %eax
000000010000edaf	movswq	%cx, %rdi
000000010000edb3	jmp	0x10000edcf
000000010000edb5	movq	(%rcx,%rdx), %rdi
000000010000edb9	testq	%r15, %r15
000000010000edbc	je	0x10000ee09
000000010000edbe	movl	(%r15), %eax
000000010000edc1	jmp	0x10000edd3
000000010000edc3	movl	(%rcx,%rdx), %ecx
000000010000edc6	movl	(%r15), %eax
000000010000edc9	cmpl	$0x2, %eax
000000010000edcc	movslq	%ecx, %rdi
000000010000edcf	cmovneq	%rcx, %rdi
000000010000edd3	cmpl	$0xa, %eax
000000010000edd6	ja	0x10000ee09
000000010000edd8	movl	$0x484, %ecx                    ## imm = 0x484
000000010000eddd	btl	%eax, %ecx
000000010000ede0	jb	0x10000ee02
000000010000ede2	movl	$0x1, %ecx
000000010000ede7	movl	$0x21, %edx
000000010000edec	btl	%eax, %edx
000000010000edef	jb	0x10000ee0e
000000010000edf1	movl	$0x42, %ecx
000000010000edf6	btl	%eax, %ecx
000000010000edf9	jae	0x10000ee09
000000010000edfb	movl	$0x2, %ecx
000000010000ee00	jmp	0x10000ee0e
000000010000ee02	movl	$0x4, %ecx
000000010000ee07	jmp	0x10000ee0e
000000010000ee09	movl	$0x8, %ecx
000000010000ee0e	movq	-0x38(%rbp), %rax
000000010000ee12	cmpq	$0x0, -0x48(%rbp)
000000010000ee17	jns	0x10000ee1d
000000010000ee19	movq	0x10(%rbx), %rax
000000010000ee1d	movq	%rcx, %rdx
000000010000ee20	imulq	%r12, %rdx
000000010000ee24	cmpq	$0x1, %rcx
000000010000ee28	je	0x10000ee48
000000010000ee2a	cmpl	$0x2, %ecx
000000010000ee2d	je	0x10000ee3a
000000010000ee2f	cmpl	$0x8, %ecx
000000010000ee32	jne	0x10000ee56
000000010000ee34	movq	(%rax,%rdx), %rsi
000000010000ee38	jmp	0x10000ee64
000000010000ee3a	cmpl	$0x1, (%r15)
000000010000ee3e	movzwl	(%rax,%rdx), %eax
000000010000ee42	movswq	%ax, %rsi
000000010000ee46	jmp	0x10000ee60
000000010000ee48	cmpl	$0x0, (%r15)
000000010000ee4c	movzbl	(%rax,%rdx), %eax
000000010000ee50	movsbq	%al, %rsi
000000010000ee54	jmp	0x10000ee60
000000010000ee56	cmpl	$0x2, (%r15)
000000010000ee5a	movl	(%rax,%rdx), %eax
000000010000ee5d	movslq	%eax, %rsi
000000010000ee60	cmovneq	%rax, %rsi
000000010000ee64	movq	%r15, %rdx
000000010000ee67	callq	_fwp_cmp
000000010000ee6c	testl	%eax, %eax
000000010000ee6e	jne	0x10000eae5
000000010000ee74	incq	%r12
000000010000ee77	cmpq	%r12, %r13
000000010000ee7a	jne	0x10000ed50
000000010000ee80	xorl	%ecx, %ecx
000000010000ee82	movq	-0x50(%rbp), %rax
000000010000ee86	cmpq	-0x58(%rbp), %rax
000000010000ee8a	jmp	0x10000eada
000000010000ee8f	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000ee96	ja	0x10000ef06
000000010000ee98	movl	%r14d, %eax
000000010000ee9b	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000eea2	jbe	0x10000ef12
000000010000eea4	movl	(%rbx), %ecx
000000010000eea6	cmpl	%ecx, %eax
000000010000eea8	je	0x10000ef18
000000010000eeaa	seta	%al
000000010000eead	movzbl	%al, %ecx
000000010000eeb0	jmp	0x10000eadd
000000010000eeb5	xorl	%ecx, %ecx
000000010000eeb7	cmpq	%r15, %rbx
000000010000eeba	jmp	0x10000eada
000000010000eebf	movq	0x38(%r15), %r15
000000010000eec3	nopw	%cs:(%rax,%rax)
000000010000eed0	movq	0x8(%r14), %rdi
000000010000eed4	movq	0x8(%rbx), %rsi
000000010000eed8	movq	%r15, %rdx
000000010000eedb	callq	_fwp_cmp
000000010000eee0	testl	%eax, %eax
000000010000eee2	jne	0x10000eae5
000000010000eee8	movq	0x10(%r14), %r14
000000010000eeec	movq	0x10(%rbx), %rbx
000000010000eef0	testq	%r14, %r14
000000010000eef3	sete	%al
000000010000eef6	je	0x10000ec8b
000000010000eefc	testq	%rbx, %rbx
000000010000eeff	jne	0x10000eed0
000000010000ef01	jmp	0x10000ec8b
000000010000ef06	movl	(%r14), %eax
000000010000ef09	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000ef10	ja	0x10000eea4
000000010000ef12	movl	%ebx, %ecx
000000010000ef14	cmpl	%ecx, %eax
000000010000ef16	jne	0x10000eeaa
000000010000ef18	movq	%r14, %r13
000000010000ef1b	movq	%rbx, %r14
000000010000ef1e	movq	0x28(%r15), %rcx
000000010000ef22	movl	%eax, %eax
000000010000ef24	movslq	(%rcx,%rax,4), %rbx
000000010000ef28	testq	%rbx, %rbx
000000010000ef2b	jle	0x10000ef6a
000000010000ef2d	movq	0x30(%r15), %rcx
000000010000ef31	movq	(%rcx,%rax,8), %r15
000000010000ef35	xorl	%r12d, %r12d
000000010000ef38	nopl	(%rax,%rax)
000000010000ef40	movq	0x8(%r13,%r12,8), %rdi
000000010000ef45	movq	0x8(%r14,%r12,8), %rsi
000000010000ef4a	movq	(%r15,%r12,8), %rdx
000000010000ef4e	callq	_fwp_cmp
000000010000ef53	testl	%eax, %eax
000000010000ef55	jne	0x10000eae5
000000010000ef5b	incq	%r12
000000010000ef5e	xorl	%eax, %eax
000000010000ef60	cmpq	%r12, %rbx
000000010000ef63	jne	0x10000ef40
000000010000ef65	jmp	0x10000eae5
000000010000ef6a	xorl	%eax, %eax
000000010000ef6c	jmp	0x10000eae5
000000010000ef71	nopl	(%rax)
000000010000ef74	sti
000000010000ef76	.byte 0xff #bad opcode
000000010000ef77	decl	-0x5(%rdi)
000000010000ef7a	.byte 0xff #bad opcode
000000010000ef7b	decl	-0x5(%rdi)
000000010000ef7e	.byte 0xff #bad opcode
000000010000ef7f	decl	-0x5(%rdi)
000000010000ef82	.byte 0xff #bad opcode
000000010000ef83	callq	*%rax
000000010000ef85	cld
000000010000ef86	.byte 0xff #bad opcode
000000010000ef87	jmpq	*-0x5(%rcx)
000000010000ef8a	.byte 0xff #bad opcode
000000010000ef8b	jmpq	*-0x5(%rcx)
000000010000ef8e	.byte 0xff #bad opcode
000000010000ef8f	jmpq	*-0x5(%rcx)
000000010000ef92	.byte 0xff #bad opcode
000000010000ef93	jmpq	*-0x5(%rcx)
000000010000ef96	.byte 0xff #bad opcode
000000010000ef97	incl	-0x4(%rdi)
000000010000ef9a	.byte 0xff #bad opcode
000000010000ef9b	.byte 0xff #bad opcode
000000010000ef9c	jp	0x10000ef9a
000000010000ef9e	.byte 0xff #bad opcode
000000010000ef9f	lcalll	*-0x7f000004(%rbp)
000000010000efa5	sti
000000010000efa6	.byte 0xff #bad opcode
000000010000efa7	incl	0x1bfffffb(%rax)
000000010000efad	.byte 0xff #bad opcode
000000010000efae	.byte 0xff #bad opcode
000000010000efaf	incl	(%rbx)
000000010000efb1	std
000000010000efb2	.byte 0xff #bad opcode
000000010000efb3	.byte 0xff #bad opcode
000000010000efb4	cmpb	%ch, %bh
000000010000efb6	.byte 0xff #bad opcode
000000010000efb7	incl	-0x4c000003(%rsi)
000000010000efbd	sti
000000010000efbe	.byte 0xff #bad opcode
000000010000efbf	pushq	0x4ffffffb(%rbx)
000000010000efc5	sti
000000010000efc6	.byte 0xff #bad opcode
000000010000efc7	decl	-0x5(%rdi)
000000010000efca	.byte 0xff #bad opcode
000000010000efcb	decl	(%rdi)
000000010000efcd	.byte 0x1f #bad opcode
000000010000efce	addb	%dl, 0x48(%rbp)
000000010000efd2	movl	%esp, %ebp
000000010000efd4	pushq	%r15
000000010000efd6	pushq	%r14
000000010000efd8	pushq	%r13
000000010000efda	pushq	%r12
000000010000efdc	pushq	%rbx
000000010000efdd	subq	$0x268, %rsp                    ## imm = 0x268
000000010000efe4	movq	0x5045(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000efeb	movq	(%rax), %rax
000000010000efee	movq	%rax, -0x30(%rbp)
000000010000eff2	movl	(%rdx), %eax
000000010000eff4	cmpq	$0x19, %rax
000000010000eff8	ja	0x1000102bb
000000010000effe	movq	%rdx, %r15
000000010000f001	movq	%rsi, %r14
000000010000f004	movq	%rdi, %r13
000000010000f007	leaq	0x141e(%rip), %rdx
000000010000f00e	movslq	(%rdx,%rax,4), %rsi
000000010000f012	addq	%rdx, %rsi
000000010000f015	movq	%rdi, -0x278(%rbp)
000000010000f01c	jmpq	*%rsi
000000010000f01e	leaq	0x4498(%rip), %rdx              ## literal pool for: "%lld"
000000010000f025	jmp	0x10000f02e
000000010000f027	leaq	0x4494(%rip), %rdx              ## literal pool for: "%llu"
000000010000f02e	leaq	-0x270(%rbp), %rbx
000000010000f035	movl	$0x200, %esi                    ## imm = 0x200
000000010000f03a	movq	%rbx, %rdi
000000010000f03d	movq	%r14, %rcx
000000010000f040	xorl	%eax, %eax
000000010000f042	callq	0x10001211e                     ## symbol stub for: _snprintf
000000010000f047	jmp	0x1000102a5
000000010000f04c	cmpl	$0x13, %eax
000000010000f04f	leaq	0x449d(%rip), %rax              ## literal pool for: "set{"
000000010000f056	leaq	0x449b(%rip), %rsi              ## literal pool for: "map{"
000000010000f05d	cmoveq	%rax, %rsi
000000010000f061	movl	$0x4, %edx
000000010000f066	movq	%r13, %rdi
000000010000f069	callq	_buf_put
000000010000f06e	cmpq	$0x0, (%r14)
000000010000f072	je	0x10000f14e
000000010000f078	movq	0x38(%r15), %rdx
000000010000f07c	movq	0x8(%r14), %rsi
000000010000f080	movq	-0x278(%rbp), %rbx
000000010000f087	movq	%rbx, %rdi
000000010000f08a	xorl	%ecx, %ecx
000000010000f08c	callq	_fwp_write
000000010000f091	cmpl	$0x12, (%r15)
000000010000f095	jne	0x10000f0bd
000000010000f097	leaq	0x445f(%rip), %rsi              ## literal pool for: ": "
000000010000f09e	movl	$0x2, %edx
000000010000f0a3	movq	%rbx, %rdi
000000010000f0a6	callq	_buf_put
000000010000f0ab	movq	0x10(%r14), %rsi
000000010000f0af	movq	0x40(%r15), %rdx
000000010000f0b3	movq	%rbx, %rdi
000000010000f0b6	xorl	%ecx, %ecx
000000010000f0b8	callq	_fwp_write
000000010000f0bd	cmpq	$0x2, (%r14)
000000010000f0c1	jb	0x10000f14e
000000010000f0c7	leaq	0x20(%r14), %r13
000000010000f0cb	movl	$0x1, %r12d
000000010000f0d1	jmp	0x10000f0ec
000000010000f0d3	nopw	%cs:(%rax,%rax)
000000010000f0e0	incq	%r12
000000010000f0e3	addq	$0x10, %r13
000000010000f0e7	cmpq	(%r14), %r12
000000010000f0ea	jae	0x10000f14e
000000010000f0ec	movl	$0x2, %edx
000000010000f0f1	movq	-0x278(%rbp), %rbx
000000010000f0f8	movq	%rbx, %rdi
000000010000f0fb	leaq	0x433a(%rip), %rsi              ## literal pool for: ", "
000000010000f102	callq	_buf_put
000000010000f107	movq	-0x8(%r13), %rsi
000000010000f10b	movq	0x38(%r15), %rdx
000000010000f10f	movq	%rbx, %rdi
000000010000f112	xorl	%ecx, %ecx
000000010000f114	callq	_fwp_write
000000010000f119	cmpl	$0x12, (%r15)
000000010000f11d	jne	0x10000f0e0
000000010000f11f	movl	$0x2, %edx
000000010000f124	movq	-0x278(%rbp), %rbx
000000010000f12b	movq	%rbx, %rdi
000000010000f12e	leaq	0x43c8(%rip), %rsi              ## literal pool for: ": "
000000010000f135	callq	_buf_put
000000010000f13a	movq	(%r13), %rsi
000000010000f13e	movq	0x40(%r15), %rdx
000000010000f142	movq	%rbx, %rdi
000000010000f145	xorl	%ecx, %ecx
000000010000f147	callq	_fwp_write
000000010000f14c	jmp	0x10000f0e0
000000010000f14e	movb	$0x7d, -0x270(%rbp)
000000010000f155	leaq	-0x270(%rbp), %rsi
000000010000f15c	movl	$0x1, %edx
000000010000f161	movq	-0x278(%rbp), %rdi
000000010000f168	jmp	0x1000102b6
000000010000f16d	movq	0x8(%r15), %rbx
000000010000f171	testq	%rbx, %rbx
000000010000f174	je	0x10000fb68
000000010000f17a	leaq	0x42e4(%rip), %rsi              ## literal pool for: "Duration"
000000010000f181	movq	%rbx, %rdi
000000010000f184	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000f189	testl	%eax, %eax
000000010000f18b	je	0x10000fe13
000000010000f191	movq	%r15, -0x280(%rbp)
000000010000f198	addq	$0x10, %r15
000000010000f19c	movq	%rbx, %rdi
000000010000f19f	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f1a4	movq	%r13, %rdi
000000010000f1a7	movq	%rbx, %rsi
000000010000f1aa	movq	%rax, %rdx
000000010000f1ad	callq	_buf_put
000000010000f1b2	movb	$0x20, -0x270(%rbp)
000000010000f1b9	leaq	-0x270(%rbp), %rsi
000000010000f1c0	movl	$0x1, %edx
000000010000f1c5	movq	%r13, %rdi
000000010000f1c8	callq	_buf_put
000000010000f1cd	xorl	%r12d, %r12d
000000010000f1d0	jmp	0x10000fb89
000000010000f1d5	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000f1dc	ja	0x10000f9a4
000000010000f1e2	movl	%r14d, %eax
000000010000f1e5	jmp	0x10000f9a7
000000010000f1ea	movq	%r14, %xmm0
000000010000f1ef	movq	%xmm0, -0x278(%rbp)
000000010000f1f7	ucomisd	%xmm0, %xmm0
000000010000f1fb	jp	0x10001041d
000000010000f201	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000f20b	andq	%r14, %rax
000000010000f20e	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
000000010000f218	cmpq	%rcx, %rax
000000010000f21b	je	0x10000fb28
000000010000f221	movl	$0x1, %ebx
000000010000f226	leaq	-0x270(%rbp), %r14
000000010000f22d	nopl	(%rax)
000000010000f230	movq	%r14, %rdi
000000010000f233	movsd	-0x278(%rbp), %xmm0
000000010000f23b	movl	%ebx, %esi
000000010000f23d	callq	_fwp_format_g
000000010000f242	movq	%r14, %rdi
000000010000f245	xorl	%esi, %esi
000000010000f247	callq	0x100012148                     ## symbol stub for: _strtod
000000010000f24c	ucomisd	-0x278(%rbp), %xmm0
000000010000f254	jne	0x10000f25c
000000010000f256	jnp	0x10000f8b9
000000010000f25c	incl	%ebx
000000010000f25e	cmpl	$0x12, %ebx
000000010000f261	jne	0x10000f230
000000010000f263	leaq	-0x270(%rbp), %rbx
000000010000f26a	movq	%rbx, %rdi
000000010000f26d	movsd	-0x278(%rbp), %xmm0
000000010000f275	movl	$0x11, %esi
000000010000f27a	callq	_fwp_format_g
000000010000f27f	movq	%rbx, %rdi
000000010000f282	jmp	0x10000f8c0
000000010000f287	movb	$0x3c, -0x270(%rbp)
000000010000f28e	leaq	-0x270(%rbp), %rsi
000000010000f295	movl	$0x1, %edx
000000010000f29a	movq	%r13, %rdi
000000010000f29d	callq	_buf_put
000000010000f2a2	movq	0x8(%r15), %rbx
000000010000f2a6	movq	%rbx, %rdi
000000010000f2a9	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f2ae	movq	%r13, %rdi
000000010000f2b1	movq	%rbx, %rsi
000000010000f2b4	jmp	0x10000f990
000000010000f2b9	movq	0x4d70(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000f2c0	movq	(%rax), %rax
000000010000f2c3	cmpq	-0x30(%rbp), %rax
000000010000f2c7	jne	0x100010418
000000010000f2cd	leaq	0x41fe(%rip), %rsi              ## literal pool for: "<opaque>"
000000010000f2d4	movl	$0x8, %edx
000000010000f2d9	movq	%r13, %rdi
000000010000f2dc	jmp	0x100010066
000000010000f2e1	leaq	0x8(%r14), %rsi
000000010000f2e5	movq	(%r14), %rdx
000000010000f2e8	movq	0x4d41(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000f2ef	movq	(%rax), %rax
000000010000f2f2	testl	%ecx, %ecx
000000010000f2f4	je	0x10000fcc6
000000010000f2fa	cmpq	-0x30(%rbp), %rax
000000010000f2fe	jne	0x100010418
000000010000f304	movq	%r13, %rdi
000000010000f307	jmp	0x100010066
000000010000f30c	movq	(%r14), %r9
000000010000f30f	movq	0x8(%r14), %r8
000000010000f313	movq	%r9, %rax
000000010000f316	orq	%r8, %rax
000000010000f319	je	0x10000fce9
000000010000f31f	xorl	%edi, %edi
000000010000f321	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000f32b	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000f335	movq	%r8, %rbx
000000010000f338	nopl	(%rax,%rax)
000000010000f340	movq	%r8, %rcx
000000010000f343	shldq	$0x3f, %r9, %rcx
000000010000f348	shrq	%rbx
000000010000f34b	movq	%rcx, %rsi
000000010000f34e	addq	%rbx, %rsi
000000010000f351	adcq	$0x0, %rsi
000000010000f355	movq	%rsi, %rax
000000010000f358	mulq	%r10
000000010000f35b	shrq	$0x2, %rdx
000000010000f35f	leaq	(%rdx,%rdx,4), %rax
000000010000f363	subq	%rax, %rsi
000000010000f366	subq	%rsi, %rcx
000000010000f369	sbbq	$0x0, %rbx
000000010000f36d	movq	%rcx, %rsi
000000010000f370	imulq	%r11, %rsi
000000010000f374	movq	%rcx, %rax
000000010000f377	mulq	%r10
000000010000f37a	addq	%rsi, %rdx
000000010000f37d	imulq	%r10, %rbx
000000010000f381	addq	%rdx, %rbx
000000010000f384	movq	%rax, %rcx
000000010000f387	addq	%rax, %rcx
000000010000f38a	leaq	(%rcx,%rcx,4), %rcx
000000010000f38e	movl	%r9d, %edx
000000010000f391	subl	%ecx, %edx
000000010000f393	orb	$0x30, %dl
000000010000f396	movb	%dl, -0x70(%rbp,%rdi)
000000010000f39a	incq	%rdi
000000010000f39d	cmpq	$0xa, %r9
000000010000f3a1	sbbq	$0x0, %r8
000000010000f3a5	movq	%rax, %r9
000000010000f3a8	movq	%rbx, %r8
000000010000f3ab	jae	0x10000f340
000000010000f3ad	testl	%edi, %edi
000000010000f3af	jg	0x10000fcf2
000000010000f3b5	jmp	0x10000f465
000000010000f3ba	movq	(%r14), %r9
000000010000f3bd	movq	0x8(%r14), %r10
000000010000f3c1	testq	%r10, %r10
000000010000f3c4	js	0x10000fd14
000000010000f3ca	movq	%r9, %rax
000000010000f3cd	orq	%r10, %rax
000000010000f3d0	je	0x10000fe32
000000010000f3d6	xorl	%edi, %edi
000000010000f3d8	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
000000010000f3e2	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000f3ec	movq	%r10, %rbx
000000010000f3ef	nop
000000010000f3f0	movq	%r10, %rcx
000000010000f3f3	shldq	$0x3f, %r9, %rcx
000000010000f3f8	shrq	%rbx
000000010000f3fb	movq	%rcx, %rsi
000000010000f3fe	addq	%rbx, %rsi
000000010000f401	adcq	$0x0, %rsi
000000010000f405	movq	%rsi, %rax
000000010000f408	mulq	%r8
000000010000f40b	shrq	$0x2, %rdx
000000010000f40f	leaq	(%rdx,%rdx,4), %rax
000000010000f413	subq	%rax, %rsi
000000010000f416	subq	%rsi, %rcx
000000010000f419	sbbq	$0x0, %rbx
000000010000f41d	movq	%rcx, %rsi
000000010000f420	imulq	%r11, %rsi
000000010000f424	movq	%rcx, %rax
000000010000f427	mulq	%r8
000000010000f42a	addq	%rsi, %rdx
000000010000f42d	imulq	%r8, %rbx
000000010000f431	addq	%rdx, %rbx
000000010000f434	movq	%rax, %rcx
000000010000f437	addq	%rax, %rcx
000000010000f43a	leaq	(%rcx,%rcx,4), %rcx
000000010000f43e	movl	%r9d, %edx
000000010000f441	subl	%ecx, %edx
000000010000f443	orb	$0x30, %dl
000000010000f446	movb	%dl, -0x70(%rbp,%rdi)
000000010000f44a	incq	%rdi
000000010000f44d	cmpq	$0xa, %r9
000000010000f451	sbbq	$0x0, %r10
000000010000f455	movq	%rax, %r9
000000010000f458	movq	%rbx, %r10
000000010000f45b	jae	0x10000f3f0
000000010000f45d	testl	%edi, %edi
000000010000f45f	jg	0x10000fe3b
000000010000f465	xorl	%eax, %eax
000000010000f467	jmp	0x100010296
000000010000f46c	movb	$0x5b, -0x270(%rbp)
000000010000f473	leaq	-0x270(%rbp), %rsi
000000010000f47a	movl	$0x1, %edx
000000010000f47f	movq	%r13, %rdi
000000010000f482	callq	_buf_put
000000010000f487	testq	%r14, %r14
000000010000f48a	je	0x100010184
000000010000f490	movq	0x38(%r15), %rdx
000000010000f494	movq	0x8(%r14), %rsi
000000010000f498	movq	%r13, %rdi
000000010000f49b	xorl	%ecx, %ecx
000000010000f49d	callq	_fwp_write
000000010000f4a2	movq	0x10(%r14), %r14
000000010000f4a6	testq	%r14, %r14
000000010000f4a9	je	0x100010184
000000010000f4af	leaq	0x3f86(%rip), %rbx              ## literal pool for: ", "
000000010000f4b6	nopw	%cs:(%rax,%rax)
000000010000f4c0	movl	$0x2, %edx
000000010000f4c5	movq	%r13, %rdi
000000010000f4c8	movq	%rbx, %rsi
000000010000f4cb	callq	_buf_put
000000010000f4d0	movq	0x8(%r14), %rsi
000000010000f4d4	movq	0x38(%r15), %rdx
000000010000f4d8	movq	%r13, %rdi
000000010000f4db	xorl	%ecx, %ecx
000000010000f4dd	callq	_fwp_write
000000010000f4e2	movq	0x10(%r14), %r14
000000010000f4e6	testq	%r14, %r14
000000010000f4e9	jne	0x10000f4c0
000000010000f4eb	jmp	0x100010184
000000010000f4f0	movslq	0x48(%r15), %rbx
000000010000f4f4	movl	%ebx, %r12d
000000010000f4f7	leaq	0x3(%rbx), %rsi
000000010000f4fb	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000f502	ja	0x10000fdfe
000000010000f508	leaq	0x12(%rbx), %rax
000000010000f50c	shrq	$0x4, %rax
000000010000f510	leaq	_fwp_gc(%rip), %rcx
000000010000f517	movzbl	0xbe8(%rax,%rcx), %edx
000000010000f51f	movl	0xb48(%rcx,%rdx,4), %eax
000000010000f526	subq	%rax, _fwp_gc(%rip)
000000010000f52d	js	0x10000fdfe
000000010000f533	leaq	(%rdx,%rdx,2), %rdx
000000010000f537	leaq	(%rcx,%rdx,8), %rcx
000000010000f53b	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000f542	movq	(%rcx), %r15
000000010000f545	testq	%r15, %r15
000000010000f548	je	0x10000fdea
000000010000f54e	movq	(%r15), %rax
000000010000f551	notq	%rax
000000010000f554	movq	%rax, (%rcx)
000000010000f557	jmp	0x10000ff82
000000010000f55c	cmpq	$-0x1, %r14
000000010000f560	leaq	0x3ee9(%rip), %rax              ## literal pool for: "-1"
000000010000f567	leaq	0x32f3(%rip), %rcx              ## literal pool for: "0"
000000010000f56e	cmoveq	%rax, %rcx
000000010000f572	cmpq	$0x1, %r14
000000010000f576	leaq	0x3ed0(%rip), %rbx              ## literal pool for: "+1"
000000010000f57d	cmovneq	%rcx, %rbx
000000010000f581	movq	%rbx, %rdi
000000010000f584	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f589	movq	0x4aa0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000f590	movq	(%rcx), %rcx
000000010000f593	cmpq	-0x30(%rbp), %rcx
000000010000f597	jne	0x100010418
000000010000f59d	movq	%r13, %rdi
000000010000f5a0	movq	%rbx, %rsi
000000010000f5a3	jmp	0x100010063
000000010000f5a8	movq	%r15, %r12
000000010000f5ab	leaq	0x3f3a(%rip), %rsi              ## literal pool for: "array["
000000010000f5b2	movl	$0x6, %edx
000000010000f5b7	movq	%r13, %rdi
000000010000f5ba	callq	_buf_put
000000010000f5bf	movq	(%r14), %rsi
000000010000f5c2	leaq	(,%rsi,2), %rax
000000010000f5ca	testq	%rax, %rax
000000010000f5cd	je	0x100010184
000000010000f5d3	movq	0x38(%r12), %rdx
000000010000f5d8	movl	$0x8, %eax
000000010000f5dd	testq	%rdx, %rdx
000000010000f5e0	je	0x10000fe5d
000000010000f5e6	movl	(%rdx), %ecx
000000010000f5e8	cmpq	$0xa, %rcx
000000010000f5ec	movq	-0x278(%rbp), %r13
000000010000f5f3	ja	0x10000fe64
000000010000f5f9	leaq	0x2f68(%rip), %rax
000000010000f600	movq	(%rax,%rcx,8), %rax
000000010000f604	jmp	0x10000fe64
000000010000f609	leaq	0x3ed2(%rip), %rsi              ## literal pool for: "bytes["
000000010000f610	movl	$0x6, %edx
000000010000f615	movq	%r13, %rdi
000000010000f618	callq	_buf_put
000000010000f61d	cmpq	$0x0, (%r14)
000000010000f621	movq	%r13, %rbx
000000010000f624	je	0x10000f6d1
000000010000f62a	movzbl	0x8(%r14), %ecx
000000010000f62f	leaq	0x3eb3(%rip), %rdx              ## literal pool for: "%u"
000000010000f636	leaq	-0x270(%rbp), %r15
000000010000f63d	movl	$0x200, %esi                    ## imm = 0x200
000000010000f642	movq	%r15, %rdi
000000010000f645	xorl	%eax, %eax
000000010000f647	callq	0x10001211e                     ## symbol stub for: _snprintf
000000010000f64c	movq	%r15, %rdi
000000010000f64f	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f654	movq	%rbx, %rdi
000000010000f657	movq	%r15, %rsi
000000010000f65a	movq	%rax, %rdx
000000010000f65d	callq	_buf_put
000000010000f662	cmpq	$0x2, (%r14)
000000010000f666	jb	0x10000f6d1
000000010000f668	movl	$0x9, %r13d
000000010000f66e	leaq	0x3e74(%rip), %r15              ## literal pool for: "%u"
000000010000f675	leaq	-0x270(%rbp), %r12
000000010000f67c	nopl	(%rax)
000000010000f680	movl	$0x2, %edx
000000010000f685	movq	%rbx, %rdi
000000010000f688	leaq	0x3dad(%rip), %rsi              ## literal pool for: ", "
000000010000f68f	callq	_buf_put
000000010000f694	movzbl	(%r14,%r13), %ecx
000000010000f699	movl	$0x200, %esi                    ## imm = 0x200
000000010000f69e	movq	%r12, %rdi
000000010000f6a1	movq	%r15, %rdx
000000010000f6a4	xorl	%eax, %eax
000000010000f6a6	callq	0x10001211e                     ## symbol stub for: _snprintf
000000010000f6ab	movq	%r12, %rdi
000000010000f6ae	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f6b3	movq	%rbx, %rdi
000000010000f6b6	movq	%r12, %rsi
000000010000f6b9	movq	%rax, %rdx
000000010000f6bc	callq	_buf_put
000000010000f6c1	leaq	0x1(%r13), %rax
000000010000f6c5	addq	$-0x7, %r13
000000010000f6c9	cmpq	(%r14), %r13
000000010000f6cc	movq	%rax, %r13
000000010000f6cf	jb	0x10000f680
000000010000f6d1	movb	$0x5d, -0x70(%rbp)
000000010000f6d5	leaq	-0x70(%rbp), %rsi
000000010000f6d9	movl	$0x1, %edx
000000010000f6de	movq	%rbx, %rdi
000000010000f6e1	jmp	0x1000102b6
000000010000f6e6	movd	%r14d, %xmm1
000000010000f6eb	ucomiss	%xmm1, %xmm1
000000010000f6ee	jp	0x10001041d
000000010000f6f4	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
000000010000f6fb	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
000000010000f702	je	0x10000fb3a
000000010000f708	cvtss2sd	%xmm1, %xmm0
000000010000f70c	leaq	-0x270(%rbp), %rbx
000000010000f713	movq	%rbx, %rdi
000000010000f716	movsd	%xmm0, -0x280(%rbp)
000000010000f71e	movl	$0x1, %esi
000000010000f723	movss	%xmm1, -0x278(%rbp)
000000010000f72b	callq	_fwp_format_g
000000010000f730	movq	%rbx, %rdi
000000010000f733	xorl	%esi, %esi
000000010000f735	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f73a	ucomiss	-0x278(%rbp), %xmm0
000000010000f741	jne	0x10000f749
000000010000f743	jnp	0x10000f8b9
000000010000f749	movq	%rbx, %rdi
000000010000f74c	movsd	-0x280(%rbp), %xmm0
000000010000f754	movl	$0x2, %esi
000000010000f759	callq	_fwp_format_g
000000010000f75e	movq	%rbx, %rdi
000000010000f761	xorl	%esi, %esi
000000010000f763	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f768	ucomiss	-0x278(%rbp), %xmm0
000000010000f76f	jne	0x10000f777
000000010000f771	jnp	0x10000f8b9
000000010000f777	movq	%rbx, %rdi
000000010000f77a	movsd	-0x280(%rbp), %xmm0
000000010000f782	movl	$0x3, %esi
000000010000f787	callq	_fwp_format_g
000000010000f78c	movq	%rbx, %rdi
000000010000f78f	xorl	%esi, %esi
000000010000f791	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f796	ucomiss	-0x278(%rbp), %xmm0
000000010000f79d	jne	0x10000f7a5
000000010000f79f	jnp	0x10000f8b9
000000010000f7a5	movq	%rbx, %rdi
000000010000f7a8	movsd	-0x280(%rbp), %xmm0
000000010000f7b0	movl	$0x4, %esi
000000010000f7b5	callq	_fwp_format_g
000000010000f7ba	movq	%rbx, %rdi
000000010000f7bd	xorl	%esi, %esi
000000010000f7bf	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f7c4	ucomiss	-0x278(%rbp), %xmm0
000000010000f7cb	jne	0x10000f7d3
000000010000f7cd	jnp	0x10000f8b9
000000010000f7d3	movq	%rbx, %rdi
000000010000f7d6	movsd	-0x280(%rbp), %xmm0
000000010000f7de	movl	$0x5, %esi
000000010000f7e3	callq	_fwp_format_g
000000010000f7e8	movq	%rbx, %rdi
000000010000f7eb	xorl	%esi, %esi
000000010000f7ed	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f7f2	ucomiss	-0x278(%rbp), %xmm0
000000010000f7f9	jne	0x10000f801
000000010000f7fb	jnp	0x10000f8b9
000000010000f801	movq	%rbx, %rdi
000000010000f804	movsd	-0x280(%rbp), %xmm0
000000010000f80c	movl	$0x6, %esi
000000010000f811	callq	_fwp_format_g
000000010000f816	movq	%rbx, %rdi
000000010000f819	xorl	%esi, %esi
000000010000f81b	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f820	ucomiss	-0x278(%rbp), %xmm0
000000010000f827	jne	0x10000f82f
000000010000f829	jnp	0x10000f8b9
000000010000f82f	movq	%rbx, %rdi
000000010000f832	movsd	-0x280(%rbp), %xmm0
000000010000f83a	movl	$0x7, %esi
000000010000f83f	callq	_fwp_format_g
000000010000f844	movq	%rbx, %rdi
000000010000f847	xorl	%esi, %esi
000000010000f849	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f84e	ucomiss	-0x278(%rbp), %xmm0
000000010000f855	jne	0x10000f859
000000010000f857	jnp	0x10000f8b9
000000010000f859	movq	%rbx, %rdi
000000010000f85c	movsd	-0x280(%rbp), %xmm0
000000010000f864	movl	$0x8, %esi
000000010000f869	callq	_fwp_format_g
000000010000f86e	movq	%rbx, %rdi
000000010000f871	xorl	%esi, %esi
000000010000f873	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f878	movss	-0x278(%rbp), %xmm1
000000010000f880	ucomiss	%xmm1, %xmm0
000000010000f883	jne	0x10000f887
000000010000f885	jnp	0x10000f8b9
000000010000f887	movq	%rbx, %rdi
000000010000f88a	movsd	-0x280(%rbp), %xmm0
000000010000f892	movl	$0x9, %esi
000000010000f897	callq	_fwp_format_g
000000010000f89c	movq	%rbx, %rdi
000000010000f89f	xorl	%esi, %esi
000000010000f8a1	callq	0x10001214e                     ## symbol stub for: _strtof
000000010000f8a6	ucomiss	-0x278(%rbp), %xmm0
000000010000f8ad	jne	0x100010403
000000010000f8b3	jp	0x100010403
000000010000f8b9	leaq	-0x270(%rbp), %rdi
000000010000f8c0	movl	$0x2e, %esi
000000010000f8c5	callq	0x10001212a                     ## symbol stub for: _strchr
000000010000f8ca	testq	%rax, %rax
000000010000f8cd	jne	0x10001029e
000000010000f8d3	leaq	-0x270(%rbp), %rdi
000000010000f8da	movl	$0x65, %esi
000000010000f8df	callq	0x10001212a                     ## symbol stub for: _strchr
000000010000f8e4	testq	%rax, %rax
000000010000f8e7	jne	0x10001029e
000000010000f8ed	leaq	0x3b97(%rip), %rsi              ## literal pool for: "inf"
000000010000f8f4	leaq	-0x270(%rbp), %rdi
000000010000f8fb	callq	0x100012142                     ## symbol stub for: _strstr
000000010000f900	testq	%rax, %rax
000000010000f903	jne	0x10001029e
000000010000f909	leaq	0x3b84(%rip), %rsi              ## literal pool for: "NaN"
000000010000f910	leaq	-0x270(%rbp), %rdi
000000010000f917	callq	0x100012142                     ## symbol stub for: _strstr
000000010000f91c	testq	%rax, %rax
000000010000f91f	jne	0x10001029e
000000010000f925	leaq	0x3bef(%rip), %rsi              ## literal pool for: ".0"
000000010000f92c	leaq	-0x270(%rbp), %rdi
000000010000f933	movl	$0x200, %edx                    ## imm = 0x200
000000010000f938	callq	0x100012016                     ## symbol stub for: ___strcat_chk
000000010000f93d	jmp	0x10001029e
000000010000f942	movq	0x46e7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000f949	movq	(%rax), %rax
000000010000f94c	cmpq	-0x30(%rbp), %rax
000000010000f950	jne	0x100010418
000000010000f956	leaq	0x3b6a(%rip), %rsi              ## literal pool for: "<function>"
000000010000f95d	movl	$0xa, %edx
000000010000f962	movq	%r13, %rdi
000000010000f965	jmp	0x100010066
000000010000f96a	leaq	0x3b6a(%rip), %rsi              ## literal pool for: "<file "
000000010000f971	movl	$0x6, %edx
000000010000f976	movq	%r13, %rdi
000000010000f979	callq	_buf_put
000000010000f97e	addq	$0x10, %r14
000000010000f982	movq	%r14, %rdi
000000010000f985	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f98a	movq	%r13, %rdi
000000010000f98d	movq	%r14, %rsi
000000010000f990	movq	%rax, %rdx
000000010000f993	callq	_buf_put
000000010000f998	movb	$0x3e, -0x270(%rbp)
000000010000f99f	jmp	0x10001018b
000000010000f9a4	movl	(%r14), %eax
000000010000f9a7	movq	0x18(%r15), %rcx
000000010000f9ab	movl	%eax, %r12d
000000010000f9ae	movq	(%rcx,%r12,8), %rbx
000000010000f9b2	movq	%rbx, %rdi
000000010000f9b5	callq	0x100012136                     ## symbol stub for: _strlen
000000010000f9ba	movq	%r13, %rdi
000000010000f9bd	movq	%rbx, %rsi
000000010000f9c0	movq	%rax, %rdx
000000010000f9c3	callq	_buf_put
000000010000f9c8	movq	0x28(%r15), %rax
000000010000f9cc	cmpl	$0x0, (%rax,%r12,4)
000000010000f9d1	jle	0x1000102bb
000000010000f9d7	movq	%r12, %rcx
000000010000f9da	xorl	%r12d, %r12d
000000010000f9dd	movq	%r15, -0x280(%rbp)
000000010000f9e4	movq	%rcx, -0x290(%rbp)
000000010000f9eb	movq	%r14, -0x288(%rbp)
000000010000f9f2	jmp	0x10000fa39
000000010000f9f4	nopw	%cs:(%rax,%rax)
000000010000fa00	movq	-0x278(%rbp), %r13
000000010000fa07	movq	%r13, %rdi
000000010000fa0a	movq	%r15, %rsi
000000010000fa0d	movq	%rbx, %rdx
000000010000fa10	xorl	%ecx, %ecx
000000010000fa12	callq	_fwp_write
000000010000fa17	incq	%r12
000000010000fa1a	movq	-0x280(%rbp), %r15
000000010000fa21	movq	0x28(%r15), %rax
000000010000fa25	movq	-0x290(%rbp), %rcx
000000010000fa2c	movslq	(%rax,%rcx,4), %rax
000000010000fa30	cmpq	%rax, %r12
000000010000fa33	jge	0x1000102bb
000000010000fa39	movq	%r15, %rax
000000010000fa3c	movq	0x8(%r14,%r12,8), %r15
000000010000fa41	movq	0x30(%rax), %rax
000000010000fa45	movq	(%rax,%rcx,8), %rax
000000010000fa49	movq	(%rax,%r12,8), %rbx
000000010000fa4d	movb	$0x20, -0x270(%rbp)
000000010000fa54	movl	$0x1, %edx
000000010000fa59	movq	%r13, %rdi
000000010000fa5c	leaq	-0x270(%rbp), %rsi
000000010000fa63	callq	_buf_put
000000010000fa68	movl	(%rbx), %eax
000000010000fa6a	cmpq	$0x10, %rax
000000010000fa6e	ja	0x10000fa00
000000010000fa70	leaq	0xa1d(%rip), %rcx
000000010000fa77	movslq	(%rcx,%rax,4), %rax
000000010000fa7b	addq	%rcx, %rax
000000010000fa7e	jmpq	*%rax
000000010000fa80	movq	%r15, %rcx
000000010000fa83	shrq	$0x3f, %rcx
000000010000fa87	testl	%ecx, %ecx
000000010000fa89	je	0x10000fa00
000000010000fa8f	movb	$0x28, -0x270(%rbp)
000000010000fa96	movl	$0x1, %edx
000000010000fa9b	movq	-0x278(%rbp), %r13
000000010000faa2	movq	%r13, %rdi
000000010000faa5	leaq	-0x270(%rbp), %r14
000000010000faac	movq	%r14, %rsi
000000010000faaf	callq	_buf_put
000000010000fab4	movq	%r13, %rdi
000000010000fab7	movq	%r15, %rsi
000000010000faba	movq	%rbx, %rdx
000000010000fabd	xorl	%ecx, %ecx
000000010000fabf	callq	_fwp_write
000000010000fac4	movb	$0x29, -0x270(%rbp)
000000010000facb	movl	$0x1, %edx
000000010000fad0	movq	%r13, %rdi
000000010000fad3	movq	%r14, %rsi
000000010000fad6	movq	-0x288(%rbp), %r14
000000010000fadd	callq	_buf_put
000000010000fae2	jmp	0x10000fa17
000000010000fae7	xorl	%ecx, %ecx
000000010000fae9	cmpq	$0x1000, %r15                   ## imm = 0x1000
000000010000faf0	setae	%cl
000000010000faf3	jmp	0x10000fa87
000000010000faf5	movq	0x8(%r15), %rcx
000000010000faf9	jmp	0x10000fa83
000000010000fafb	movl	%r15d, %ecx
000000010000fafe	shrl	$0x1f, %ecx
000000010000fb01	jmp	0x10000fa87
000000010000fb03	movq	0x8(%rbx), %rdi
000000010000fb07	testq	%rdi, %rdi
000000010000fb0a	je	0x10000fa00
000000010000fb10	leaq	0x394e(%rip), %rsi              ## literal pool for: "Duration"
000000010000fb17	callq	0x100012130                     ## symbol stub for: _strcmp
000000010000fb1c	xorl	%ecx, %ecx
000000010000fb1e	testl	%eax, %eax
000000010000fb20	setne	%cl
000000010000fb23	jmp	0x10000fa87
000000010000fb28	xorpd	%xmm0, %xmm0
000000010000fb2c	movsd	-0x278(%rbp), %xmm1
000000010000fb34	ucomisd	%xmm0, %xmm1
000000010000fb38	jmp	0x10000fb40
000000010000fb3a	xorps	%xmm0, %xmm0
000000010000fb3d	ucomiss	%xmm0, %xmm1
000000010000fb40	leaq	0x3944(%rip), %rax              ## literal pool for: "inf"
000000010000fb47	leaq	0x3941(%rip), %rsi              ## literal pool for: "-inf"
000000010000fb4e	cmovaq	%rax, %rsi
000000010000fb52	leaq	-0x270(%rbp), %rdi
000000010000fb59	movl	$0x200, %edx                    ## imm = 0x200
000000010000fb5e	callq	0x10001201c                     ## symbol stub for: ___strcpy_chk
000000010000fb63	jmp	0x10001029e
000000010000fb68	cmpl	$0x0, 0x10(%r15)
000000010000fb6d	je	0x10001019f
000000010000fb73	movq	%r15, %rax
000000010000fb76	addq	$0x10, %r15
000000010000fb7a	movq	%rax, -0x280(%rbp)
000000010000fb81	cmpl	$0x0, 0x48(%rax)
000000010000fb85	setne	%r12b
000000010000fb89	testb	%r12b, %r12b
000000010000fb8c	movl	$0x28, %eax
000000010000fb91	movl	$0x7b, %ecx
000000010000fb96	cmovnel	%eax, %ecx
000000010000fb99	movb	%cl, -0x270(%rbp)
000000010000fb9f	leaq	-0x270(%rbp), %rsi
000000010000fba6	movl	$0x1, %edx
000000010000fbab	movq	%r13, %rdi
000000010000fbae	callq	_buf_put
000000010000fbb3	cmpl	$0x0, (%r15)
000000010000fbb7	movq	-0x280(%rbp), %r15
000000010000fbbe	jle	0x10000fcab
000000010000fbc4	testb	%r12b, %r12b
000000010000fbc7	jne	0x10000fbfa
000000010000fbc9	movq	0x18(%r15), %rax
000000010000fbcd	movq	(%rax), %rbx
000000010000fbd0	movq	%rbx, %rdi
000000010000fbd3	callq	0x100012136                     ## symbol stub for: _strlen
000000010000fbd8	movq	%r13, %rdi
000000010000fbdb	movq	%rbx, %rsi
000000010000fbde	movq	%rax, %rdx
000000010000fbe1	callq	_buf_put
000000010000fbe6	leaq	0x3916(%rip), %rsi              ## literal pool for: " = "
000000010000fbed	movl	$0x3, %edx
000000010000fbf2	movq	%r13, %rdi
000000010000fbf5	callq	_buf_put
000000010000fbfa	movq	0x8(%r14), %rsi
000000010000fbfe	movq	0x20(%r15), %rax
000000010000fc02	movq	(%rax), %rdx
000000010000fc05	movq	%r13, %rdi
000000010000fc08	xorl	%ecx, %ecx
000000010000fc0a	callq	_fwp_write
000000010000fc0f	cmpl	$0x2, 0x10(%r15)
000000010000fc14	jl	0x10000fcab
000000010000fc1a	movl	$0x1, %ebx
000000010000fc1f	jmp	0x10000fc53
000000010000fc21	nopw	%cs:(%rax,%rax)
000000010000fc30	movq	0x8(%r14,%rbx,8), %rsi
000000010000fc35	movq	0x20(%r15), %rax
000000010000fc39	movq	(%rax,%rbx,8), %rdx
000000010000fc3d	movq	%r13, %rdi
000000010000fc40	xorl	%ecx, %ecx
000000010000fc42	callq	_fwp_write
000000010000fc47	incq	%rbx
000000010000fc4a	movslq	0x10(%r15), %rax
000000010000fc4e	cmpq	%rax, %rbx
000000010000fc51	jge	0x10000fcab
000000010000fc53	movl	$0x2, %edx
000000010000fc58	movq	%r13, %rdi
000000010000fc5b	leaq	0x37da(%rip), %rsi              ## literal pool for: ", "
000000010000fc62	callq	_buf_put
000000010000fc67	testb	%r12b, %r12b
000000010000fc6a	jne	0x10000fc30
000000010000fc6c	movq	0x18(%r15), %rax
000000010000fc70	movq	(%rax,%rbx,8), %r13
000000010000fc74	movq	%r13, %rdi
000000010000fc77	callq	0x100012136                     ## symbol stub for: _strlen
000000010000fc7c	movq	-0x278(%rbp), %rdi
000000010000fc83	movq	%r13, %rsi
000000010000fc86	movq	-0x278(%rbp), %r13
000000010000fc8d	movq	%rax, %rdx
000000010000fc90	callq	_buf_put
000000010000fc95	movl	$0x3, %edx
000000010000fc9a	movq	%r13, %rdi
000000010000fc9d	leaq	0x385f(%rip), %rsi              ## literal pool for: " = "
000000010000fca4	callq	_buf_put
000000010000fca9	jmp	0x10000fc30
000000010000fcab	testb	%r12b, %r12b
000000010000fcae	movl	$0x29, %eax
000000010000fcb3	movl	$0x7d, %ecx
000000010000fcb8	cmovnel	%eax, %ecx
000000010000fcbb	movb	%cl, -0x270(%rbp)
000000010000fcc1	jmp	0x10001018b
000000010000fcc6	cmpq	-0x30(%rbp), %rax
000000010000fcca	jne	0x100010418
000000010000fcd0	movq	%r13, %rdi
000000010000fcd3	addq	$0x268, %rsp                    ## imm = 0x268
000000010000fcda	popq	%rbx
000000010000fcdb	popq	%r12
000000010000fcdd	popq	%r13
000000010000fcdf	popq	%r14
000000010000fce1	popq	%r15
000000010000fce3	popq	%rbp
000000010000fce4	jmp	_fwp_escape
000000010000fce9	movb	$0x30, -0x70(%rbp)
000000010000fced	movl	$0x1, %edi
000000010000fcf2	movl	%edi, %eax
000000010000fcf4	cmpq	$0x8, %rax
000000010000fcf8	jae	0x10000fd04
000000010000fcfa	xorl	%ecx, %ecx
000000010000fcfc	movq	%rax, %rdx
000000010000fcff	jmp	0x10000ff55
000000010000fd04	cmpl	$0x20, %eax
000000010000fd07	jae	0x10000fea1
000000010000fd0d	xorl	%ecx, %ecx
000000010000fd0f	jmp	0x10000feff
000000010000fd14	movb	$0x2d, -0x270(%rbp)
000000010000fd1b	xorl	%r8d, %r8d
000000010000fd1e	negq	%r9
000000010000fd21	movl	$0x0, %r11d
000000010000fd27	sbbq	%r10, %r11
000000010000fd2a	movl	$0x1, %r15d
000000010000fd30	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000fd3a	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000fd44	movq	%r11, %r14
000000010000fd47	nopw	(%rax,%rax)
000000010000fd50	movq	%r11, %rcx
000000010000fd53	shldq	$0x3f, %r9, %rcx
000000010000fd58	shrq	%r14
000000010000fd5b	movq	%rcx, %rsi
000000010000fd5e	addq	%r14, %rsi
000000010000fd61	adcq	$0x0, %rsi
000000010000fd65	movq	%rsi, %rax
000000010000fd68	mulq	%r10
000000010000fd6b	movl	%r15d, %edi
000000010000fd6e	shrq	$0x2, %rdx
000000010000fd72	leaq	(%rdx,%rdx,4), %rax
000000010000fd76	subq	%rax, %rsi
000000010000fd79	subq	%rsi, %rcx
000000010000fd7c	sbbq	$0x0, %r14
000000010000fd80	movq	%rcx, %rsi
000000010000fd83	movq	%rcx, %rax
000000010000fd86	mulq	%r10
000000010000fd89	imulq	%rbx, %rsi
000000010000fd8d	addq	%rsi, %rdx
000000010000fd90	imulq	%r10, %r14
000000010000fd94	addq	%rdx, %r14
000000010000fd97	movq	%rax, %rcx
000000010000fd9a	addq	%rax, %rcx
000000010000fd9d	leaq	(%rcx,%rcx,4), %rcx
000000010000fda1	movl	%r9d, %edx
000000010000fda4	subl	%ecx, %edx
000000010000fda6	orb	$0x30, %dl
000000010000fda9	movb	%dl, -0x70(%rbp,%r8)
000000010000fdae	incq	%r8
000000010000fdb1	leal	0x1(%rdi), %r15d
000000010000fdb5	cmpq	$0xa, %r9
000000010000fdb9	sbbq	$0x0, %r11
000000010000fdbd	movq	%rax, %r9
000000010000fdc0	movq	%r14, %r11
000000010000fdc3	jae	0x10000fd50
000000010000fdc5	testl	%r8d, %r8d
000000010000fdc8	jle	0x1000101c7
000000010000fdce	movl	%r8d, %eax
000000010000fdd1	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
000000010000fdd6	cmpq	$0x8, %rax
000000010000fdda	jae	0x1000102e1
000000010000fde0	xorl	%ecx, %ecx
000000010000fde2	movq	%rax, %rdx
000000010000fde5	jmp	0x1000103c4
000000010000fdea	movq	0x8(%rcx), %r15
000000010000fdee	movq	0x10(%rcx), %rdx
000000010000fdf2	subq	%r15, %rdx
000000010000fdf5	cmpq	%rax, %rdx
000000010000fdf8	jae	0x10000ff7b
000000010000fdfe	movq	%rsi, %rdi
000000010000fe01	movl	$0x1, %esi
000000010000fe06	callq	_fwp_gc_alloc_slow
000000010000fe0b	movq	%rax, %r15
000000010000fe0e	jmp	0x10000ff8a
000000010000fe13	movq	0x8(%r14), %rsi
000000010000fe17	movq	%rsi, %rdx
000000010000fe1a	sarq	$0x3f, %rdx
000000010000fe1e	leaq	-0x270(%rbp), %rbx
000000010000fe25	movq	%rbx, %rdi
000000010000fe28	callq	_fwp_fmt_duration
000000010000fe2d	jmp	0x1000102a5
000000010000fe32	movb	$0x30, -0x70(%rbp)
000000010000fe36	movl	$0x1, %edi
000000010000fe3b	movl	%edi, %eax
000000010000fe3d	cmpq	$0x8, %rax
000000010000fe41	jae	0x10000fe4d
000000010000fe43	xorl	%ecx, %ecx
000000010000fe45	movq	%rax, %rdx
000000010000fe48	jmp	0x100010273
000000010000fe4d	cmpl	$0x20, %eax
000000010000fe50	jae	0x1000101d6
000000010000fe56	xorl	%ecx, %ecx
000000010000fe58	jmp	0x10001022e
000000010000fe5d	movq	-0x278(%rbp), %r13
000000010000fe64	leaq	0x8(%r14), %rbx
000000010000fe68	movq	%rbx, %rcx
000000010000fe6b	testq	%rsi, %rsi
000000010000fe6e	jns	0x10000fe74
000000010000fe70	movq	0x10(%r14), %rcx
000000010000fe74	cmpq	$0x1, %rax
000000010000fe78	je	0x100010081
000000010000fe7e	cmpq	$0x8, %rax
000000010000fe82	je	0x10001007c
000000010000fe88	cmpq	$0x2, %rax
000000010000fe8c	jne	0x10001008d
000000010000fe92	cmpl	$0x1, (%rdx)
000000010000fe95	movzwl	(%rcx), %eax
000000010000fe98	movswq	%ax, %rsi
000000010000fe9c	jmp	0x100010095
000000010000fea1	movl	%edi, %edx
000000010000fea3	andl	$0x1f, %edx
000000010000fea6	movq	%rax, %rcx
000000010000fea9	subq	%rdx, %rcx
000000010000feac	leaq	-0x260(%rbp), %rsi
000000010000feb3	movdqa	0x23d5(%rip), %xmm0
000000010000febb	movq	%rax, %r8
000000010000febe	nop
000000010000fec0	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000feca	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000fed1	pshufb	%xmm0, %xmm2
000000010000fed6	pshufb	%xmm0, %xmm1
000000010000fedb	movdqa	%xmm2, -0x10(%rsi)
000000010000fee0	movdqa	%xmm1, (%rsi)
000000010000fee4	addq	$-0x20, %r8
000000010000fee8	addq	$0x20, %rsi
000000010000feec	cmpq	%r8, %rdx
000000010000feef	jne	0x10000fec0
000000010000fef1	testq	%rdx, %rdx
000000010000fef4	je	0x100010296
000000010000fefa	cmpl	$0x7, %edx
000000010000fefd	jbe	0x10000ff55
000000010000feff	movl	%edi, %edx
000000010000ff01	andl	$0x7, %edx
000000010000ff04	movq	%rax, %rsi
000000010000ff07	subq	%rcx, %rsi
000000010000ff0a	leaq	(%rcx,%rbp), %rdi
000000010000ff0e	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000ff15	movq	%rax, %rcx
000000010000ff18	subq	%rdx, %rcx
000000010000ff1b	movq	0x237d(%rip), %xmm0
000000010000ff23	nopw	%cs:(%rax,%rax)
000000010000ff30	movq	-0x78(%rbp,%rsi), %xmm1
000000010000ff36	pshufb	%xmm0, %xmm1
000000010000ff3b	movq	%xmm1, (%rdi)
000000010000ff3f	addq	$-0x8, %rsi
000000010000ff43	addq	$0x8, %rdi
000000010000ff47	cmpq	%rsi, %rdx
000000010000ff4a	jne	0x10000ff30
000000010000ff4c	testq	%rdx, %rdx
000000010000ff4f	je	0x100010296
000000010000ff55	leaq	-0x70(%rbp), %rsi
000000010000ff59	addq	%rsi, %rdx
000000010000ff5c	decq	%rdx
000000010000ff5f	nop
000000010000ff60	movzbl	(%rdx), %esi
000000010000ff63	movb	%sil, -0x270(%rbp,%rcx)
000000010000ff6b	incq	%rcx
000000010000ff6e	decq	%rdx
000000010000ff71	cmpq	%rcx, %rax
000000010000ff74	jne	0x10000ff60
000000010000ff76	jmp	0x100010296
000000010000ff7b	addq	%r15, %rax
000000010000ff7e	movq	%rax, 0x8(%rcx)
000000010000ff82	movq	%r15, %rdi
000000010000ff85	callq	0x100011ffe                     ## symbol stub for: ___bzero
000000010000ff8a	movw	$0x7430, (%r15)                 ## imm = 0x7430
000000010000ff90	testl	%r12d, %r12d
000000010000ff93	jle	0x10001003b
000000010000ff99	movq	%rbx, %rcx
000000010000ff9c	negq	%rcx
000000010000ff9f	leaq	(%r12,%r15), %rsi
000000010000ffa3	incq	%rsi
000000010000ffa6	xorl	%edi, %edi
000000010000ffa8	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
000000010000ffb2	jmp	0x10000ffec
000000010000ffb4	nopw	%cs:(%rax,%rax)
000000010000ffc0	movb	$0x30, %r10b
000000010000ffc3	movb	%r10b, (%rsi,%rdi)
000000010000ffc7	testq	%rdx, %rdx
000000010000ffca	setne	%dl
000000010000ffcd	testq	%r14, %r14
000000010000ffd0	sets	%r10b
000000010000ffd4	andb	%dl, %r10b
000000010000ffd7	movzbl	%r10b, %edx
000000010000ffdb	subq	%rdx, %rax
000000010000ffde	addq	%r9, %rax
000000010000ffe1	decq	%rdi
000000010000ffe4	movq	%rax, %r14
000000010000ffe7	cmpq	%rdi, %rcx
000000010000ffea	je	0x10001003b
000000010000ffec	movq	%r14, %rax
000000010000ffef	imulq	%r8
000000010000fff2	movq	%rdx, %rax
000000010000fff5	shrq	$0x3f, %rax
000000010000fff9	addq	%rdx, %rax
000000010000fffc	leaq	(%rax,%rax,2), %r9
0000000100010000	movq	%r14, %rdx
0000000100010003	subq	%r9, %rdx
0000000100010006	negq	%r9
0000000100010009	addq	%r14, %r9
000000010001000c	addq	$0x3, %r9
0000000100010010	cmpq	$-0x3, %rdx
0000000100010014	cmovbq	%rdx, %r9
0000000100010018	testq	%r9, %r9
000000010001001b	je	0x10000ffc0
000000010001001d	cmpq	$0x1, %r9
0000000100010021	jne	0x100010030
0000000100010023	movb	$0x2b, %r10b
0000000100010026	xorl	%r9d, %r9d
0000000100010029	jmp	0x10000ffc3
000000010001002b	nopl	(%rax,%rax)
0000000100010030	movb	$0x2d, %r10b
0000000100010033	movl	$0x1, %r9d
0000000100010039	jmp	0x10000ffc3
000000010001003b	movb	$0x0, 0x2(%r15,%rbx)
0000000100010041	movq	%r15, %rdi
0000000100010044	callq	0x100012136                     ## symbol stub for: _strlen
0000000100010049	movq	0x3fe0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100010050	movq	(%rcx), %rcx
0000000100010053	cmpq	-0x30(%rbp), %rcx
0000000100010057	jne	0x100010418
000000010001005d	movq	%r13, %rdi
0000000100010060	movq	%r15, %rsi
0000000100010063	movq	%rax, %rdx
0000000100010066	addq	$0x268, %rsp                    ## imm = 0x268
000000010001006d	popq	%rbx
000000010001006e	popq	%r12
0000000100010070	popq	%r13
0000000100010072	popq	%r14
0000000100010074	popq	%r15
0000000100010076	popq	%rbp
0000000100010077	jmp	_buf_put
000000010001007c	movq	(%rcx), %rsi
000000010001007f	jmp	0x100010099
0000000100010081	cmpl	$0x0, (%rdx)
0000000100010084	movzbl	(%rcx), %eax
0000000100010087	movsbq	%al, %rsi
000000010001008b	jmp	0x100010095
000000010001008d	cmpl	$0x2, (%rdx)
0000000100010090	movl	(%rcx), %eax
0000000100010092	movslq	%eax, %rsi
0000000100010095	cmovneq	%rax, %rsi
0000000100010099	movq	%r13, %rdi
000000010001009c	xorl	%ecx, %ecx
000000010001009e	callq	_fwp_write
00000001000100a3	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000100ad	decq	%rax
00000001000100b0	testq	%rax, (%r14)
00000001000100b3	je	0x100010184
00000001000100b9	movl	$0x1, %r15d
00000001000100bf	jmp	0x1000100fd
00000001000100c1	cmpl	$0x1, (%rdx)
00000001000100c4	movzwl	(%rcx,%rsi), %eax
00000001000100c8	movswq	%ax, %rsi
00000001000100cc	cmovneq	%rax, %rsi
00000001000100d0	movq	-0x278(%rbp), %r13
00000001000100d7	movq	%r13, %rdi
00000001000100da	xorl	%ecx, %ecx
00000001000100dc	callq	_fwp_write
00000001000100e1	incq	%r15
00000001000100e4	movq	(%r14), %rax
00000001000100e7	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000100f1	andq	%rcx, %rax
00000001000100f4	cmpq	%rax, %r15
00000001000100f7	jae	0x100010184
00000001000100fd	movl	$0x2, %edx
0000000100010102	movq	%r13, %rdi
0000000100010105	leaq	0x3330(%rip), %rsi              ## literal pool for: ", "
000000010001010c	callq	_buf_put
0000000100010111	movq	0x38(%r12), %rdx
0000000100010116	movl	$0x8, %eax
000000010001011b	testq	%rdx, %rdx
000000010001011e	je	0x100010133
0000000100010120	movl	(%rdx), %ecx
0000000100010122	cmpq	$0xa, %rcx
0000000100010126	ja	0x100010133
0000000100010128	leaq	0x2439(%rip), %rax
000000010001012f	movq	(%rax,%rcx,8), %rax
0000000100010133	cmpq	$0x0, (%r14)
0000000100010137	movq	%rbx, %rcx
000000010001013a	jns	0x100010140
000000010001013c	movq	0x10(%r14), %rcx
0000000100010140	movq	%rax, %rsi
0000000100010143	imulq	%r15, %rsi
0000000100010147	cmpq	$0x1, %rax
000000010001014b	je	0x100010166
000000010001014d	cmpq	$0x2, %rax
0000000100010151	je	0x1000100c1
0000000100010157	cmpq	$0x8, %rax
000000010001015b	jne	0x100010176
000000010001015d	movq	(%rcx,%rsi), %rsi
0000000100010161	jmp	0x1000100d0
0000000100010166	cmpl	$0x0, (%rdx)
0000000100010169	movzbl	(%rcx,%rsi), %eax
000000010001016d	movsbq	%al, %rsi
0000000100010171	jmp	0x1000100cc
0000000100010176	cmpl	$0x2, (%rdx)
0000000100010179	movl	(%rcx,%rsi), %eax
000000010001017c	movslq	%eax, %rsi
000000010001017f	jmp	0x1000100cc
0000000100010184	movb	$0x5d, -0x270(%rbp)
000000010001018b	leaq	-0x270(%rbp), %rsi
0000000100010192	movl	$0x1, %edx
0000000100010197	movq	%r13, %rdi
000000010001019a	jmp	0x1000102b6
000000010001019f	movq	0x3e8a(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000101a6	movq	(%rax), %rax
00000001000101a9	cmpq	-0x30(%rbp), %rax
00000001000101ad	jne	0x100010418
00000001000101b3	leaq	0x3346(%rip), %rsi              ## literal pool for: "()"
00000001000101ba	movl	$0x2, %edx
00000001000101bf	movq	%r13, %rdi
00000001000101c2	jmp	0x100010066
00000001000101c7	xorl	%eax, %eax
00000001000101c9	movb	$0x0, -0x26f(%rbp,%rax)
00000001000101d1	jmp	0x10001029e
00000001000101d6	movl	%edi, %edx
00000001000101d8	andl	$0x1f, %edx
00000001000101db	movq	%rax, %rcx
00000001000101de	subq	%rdx, %rcx
00000001000101e1	leaq	-0x260(%rbp), %rsi
00000001000101e8	movdqa	0x20a0(%rip), %xmm0
00000001000101f0	movq	%rax, %r8
00000001000101f3	movdqu	-0x90(%rbp,%r8), %xmm1
00000001000101fd	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010204	pshufb	%xmm0, %xmm2
0000000100010209	pshufb	%xmm0, %xmm1
000000010001020e	movdqa	%xmm2, -0x10(%rsi)
0000000100010213	movdqa	%xmm1, (%rsi)
0000000100010217	addq	$-0x20, %r8
000000010001021b	addq	$0x20, %rsi
000000010001021f	cmpq	%r8, %rdx
0000000100010222	jne	0x1000101f3
0000000100010224	testq	%rdx, %rdx
0000000100010227	je	0x100010296
0000000100010229	cmpl	$0x7, %edx
000000010001022c	jbe	0x100010273
000000010001022e	movl	%edi, %edx
0000000100010230	andl	$0x7, %edx
0000000100010233	movq	%rax, %rsi
0000000100010236	subq	%rcx, %rsi
0000000100010239	leaq	(%rcx,%rbp), %rdi
000000010001023d	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100010244	movq	%rax, %rcx
0000000100010247	subq	%rdx, %rcx
000000010001024a	movq	0x204e(%rip), %xmm0
0000000100010252	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010258	pshufb	%xmm0, %xmm1
000000010001025d	movq	%xmm1, (%rdi)
0000000100010261	addq	$-0x8, %rsi
0000000100010265	addq	$0x8, %rdi
0000000100010269	cmpq	%rsi, %rdx
000000010001026c	jne	0x100010252
000000010001026e	testq	%rdx, %rdx
0000000100010271	je	0x100010296
0000000100010273	leaq	-0x70(%rbp), %rsi
0000000100010277	addq	%rsi, %rdx
000000010001027a	decq	%rdx
000000010001027d	nopl	(%rax)
0000000100010280	movzbl	(%rdx), %esi
0000000100010283	movb	%sil, -0x270(%rbp,%rcx)
000000010001028b	incq	%rcx
000000010001028e	decq	%rdx
0000000100010291	cmpq	%rcx, %rax
0000000100010294	jne	0x100010280
0000000100010296	movb	$0x0, -0x270(%rbp,%rax)
000000010001029e	leaq	-0x270(%rbp), %rbx
00000001000102a5	movq	%rbx, %rdi
00000001000102a8	callq	0x100012136                     ## symbol stub for: _strlen
00000001000102ad	movq	%r13, %rdi
00000001000102b0	movq	%rbx, %rsi
00000001000102b3	movq	%rax, %rdx
00000001000102b6	callq	_buf_put
00000001000102bb	movq	0x3d6e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000102c2	movq	(%rax), %rax
00000001000102c5	cmpq	-0x30(%rbp), %rax
00000001000102c9	jne	0x100010418
00000001000102cf	addq	$0x268, %rsp                    ## imm = 0x268
00000001000102d6	popq	%rbx
00000001000102d7	popq	%r12
00000001000102d9	popq	%r13
00000001000102db	popq	%r14
00000001000102dd	popq	%r15
00000001000102df	popq	%rbp
00000001000102e0	retq
00000001000102e1	cmpl	$0x20, %eax
00000001000102e4	jae	0x1000102ea
00000001000102e6	xorl	%ecx, %ecx
00000001000102e8	jmp	0x10001035f
00000001000102ea	movl	%r8d, %edx
00000001000102ed	andl	$0x1f, %edx
00000001000102f0	movq	%rax, %rcx
00000001000102f3	subq	%rdx, %rcx
00000001000102f6	movl	%edi, %esi
00000001000102f8	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
00000001000102fe	leaq	(%rsi,%rbp), %r9
0000000100010302	addq	$-0x80, %r9
0000000100010306	movl	%edi, %r10d
0000000100010309	andl	$0x1f, %r10d
000000010001030d	subq	%r10, %rsi
0000000100010310	xorl	%r10d, %r10d
0000000100010313	movdqa	0x1f75(%rip), %xmm0
000000010001031b	movdqu	-0x10(%r9), %xmm1
0000000100010321	movdqu	(%r9), %xmm2
0000000100010326	pshufb	%xmm0, %xmm2
000000010001032b	pshufb	%xmm0, %xmm1
0000000100010330	movdqu	%xmm2, -0x26f(%rbp,%r10)
000000010001033a	movdqu	%xmm1, -0x25f(%rbp,%r10)
0000000100010344	addq	$0x20, %r10
0000000100010348	addq	$-0x20, %r9
000000010001034c	cmpq	%r10, %rsi
000000010001034f	jne	0x10001031b
0000000100010351	testq	%rdx, %rdx
0000000100010354	je	0x1000103f6
000000010001035a	cmpl	$0x7, %edx
000000010001035d	jbe	0x1000103c4
000000010001035f	movq	%rcx, %rsi
0000000100010362	movl	%r8d, %edx
0000000100010365	andl	$0x7, %edx
0000000100010368	movq	%rax, %rcx
000000010001036b	subq	%rdx, %rcx
000000010001036e	movq	%rsi, %r8
0000000100010371	negq	%r8
0000000100010374	leaq	(%r8,%rbp), %r9
0000000100010378	addq	$-0x70, %r9
000000010001037c	movl	%edi, %r8d
000000010001037f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010386	addq	%r8, %r9
0000000100010389	addq	$-0x8, %r9
000000010001038d	movl	%edi, %r10d
0000000100010390	andl	$0x7, %r10d
0000000100010394	subq	%r10, %r8
0000000100010397	movq	0x1f01(%rip), %xmm0
000000010001039f	movq	(%r9), %xmm1
00000001000103a4	pshufb	%xmm0, %xmm1
00000001000103a9	movq	%xmm1, -0x26f(%rbp,%rsi)
00000001000103b2	addq	$0x8, %rsi
00000001000103b6	addq	$-0x8, %r9
00000001000103ba	cmpq	%rsi, %r8
00000001000103bd	jne	0x10001039f
00000001000103bf	testq	%rdx, %rdx
00000001000103c2	je	0x1000103f6
00000001000103c4	leaq	-0x70(%rbp), %rsi
00000001000103c8	addq	%rsi, %rdx
00000001000103cb	decq	%rdx
00000001000103ce	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
00000001000103d4	nopw	%cs:(%rax,%rax)
00000001000103e0	movzbl	(%rdx), %esi
00000001000103e3	movb	%sil, -0x26f(%rbp,%rcx)
00000001000103eb	incq	%rcx
00000001000103ee	decq	%rdx
00000001000103f1	cmpq	%rcx, %rdi
00000001000103f4	jne	0x1000103e0
00000001000103f6	movb	$0x0, -0x26f(%rbp,%rax)
00000001000103fe	jmp	0x10001029e
0000000100010403	movq	%rbx, %rdi
0000000100010406	movsd	-0x280(%rbp), %xmm0
000000010001040e	movl	$0x9, %esi
0000000100010413	jmp	0x10000f27a
0000000100010418	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
000000010001041d	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
0000000100010427	jmp	0x10001029e
000000010001042c	repne		jmp	0x10001042e
000000010001042f	pushq	%rdx
0000000100010431	jmp	0x100010432
0000000100010433	pushq	%rdx
0000000100010435	jmp	0x100010436
0000000100010437	pushq	%rdx
0000000100010439	jmp	0x10001043a
000000010001043b	decl	-0x4000011(%rsi)
0000000100010441	jmp	0x100010442
0000000100010443	.byte 0xff #bad opcode
0000000100010444	sti
0000000100010445	jmp	0x100010446
0000000100010447	.byte 0xff #bad opcode
0000000100010448	sti
0000000100010449	jmp	0x10001044a
000000010001044b	.byte 0xff #bad opcode
000000010001044c	sti
000000010001044d	jmp	0x10001044e
000000010001044f	jmpq	*%rax
0000000100010451	outb	%al, %dx
0000000100010452	.byte 0xff #bad opcode
0000000100010453	.byte 0xff #bad opcode
0000000100010454	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
0000000100010459	inl	%dx, %eax
000000010001045a	.byte 0xff #bad opcode
000000010001045b	pushq	-0x22000012(%rbp)
0000000100010461	.byte 0xf1 #bad opcode
0000000100010462	.byte 0xff #bad opcode
0000000100010463	ljmpl	*0x40ffffed(%rcx)
0000000100010469	lock
000000010001046a	.byte 0xff #bad opcode
000000010001046b	incl	-0x13(%rcx)
000000010001046e	.byte 0xff #bad opcode
000000010001046f	.byte 0xff #bad opcode
0000000100010470	jl	0x100010463
0000000100010472	.byte 0xff #bad opcode
0000000100010473	jmpq	*(%rax)
0000000100010475	inb	%dx, %al
0000000100010476	.byte 0xff #bad opcode
0000000100010477	jmpq	*(%rax)
0000000100010479	inb	%dx, %al
000000010001047a	.byte 0xff #bad opcode
000000010001047b	incl	%esp
000000010001047d	lock
000000010001047e	.byte 0xff #bad opcode
000000010001047f	pushq	(%rax)
0000000100010481	.byte 0xf1 #bad opcode
0000000100010482	.byte 0xff #bad opcode
0000000100010483	callq	*(%rsi)
0000000100010485	cmc
0000000100010486	.byte 0xff #bad opcode
0000000100010487	.byte 0xff #bad opcode
0000000100010488	cmc
000000010001048a	.byte 0xff #bad opcode
000000010001048b	decl	0x5bffffee(%rbp)
0000000100010491	outb	%al, %dx
0000000100010492	.byte 0xff #bad opcode
0000000100010493	.byte 0xff #bad opcode
0000000100010494	inb	%dx, %al
0000000100010495	cmc
0000000100010496	.byte 0xff #bad opcode
0000000100010497	.byte 0xff #bad opcode
0000000100010498	inb	%dx, %al
0000000100010499	cmc
000000010001049a	.byte 0xff #bad opcode
000000010001049b	.byte 0xff #bad opcode
000000010001049c	inb	%dx, %al
000000010001049d	cmc
000000010001049e	.byte 0xff #bad opcode
000000010001049f	.byte 0xff #bad opcode
00000001000104a0	inb	%dx, %al
00000001000104a1	cmc
00000001000104a2	.byte 0xff #bad opcode
00000001000104a3	jmpq	*-0xa(%rcx)
00000001000104a6	.byte 0xff #bad opcode
00000001000104a7	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104ab	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104af	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104b3	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104b7	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104bb	jmpq	*-0xa(%rdi)
00000001000104be	.byte 0xff #bad opcode
00000001000104bf	.byte 0xff #bad opcode
00000001000104c0	inb	%dx, %al
00000001000104c1	cmc
00000001000104c2	.byte 0xff #bad opcode
00000001000104c3	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104c7	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104cb	callq	*-0xa(%rbx)
00000001000104ce	.byte 0xff #bad opcode
00000001000104cf	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000104d3	ljmpl	*-0xa(%rdi)
00000001000104d6	.byte 0xff #bad opcode
00000001000104d7	decl	(%rdi)
00000001000104d9	.byte 0x1f #bad opcode
00000001000104da	testb	%al, (%rax)
00000001000104dc	addb	%al, (%rax)
00000001000104de	addb	%al, (%rax)
_fwp_escape:
00000001000104e0	pushq	%rbp
00000001000104e1	movq	%rsp, %rbp
00000001000104e4	pushq	%r15
00000001000104e6	pushq	%r14
00000001000104e8	pushq	%r13
00000001000104ea	pushq	%r12
00000001000104ec	pushq	%rbx
00000001000104ed	subq	$0x18, %rsp
00000001000104f1	movq	%rdx, %r14
00000001000104f4	movq	%rsi, %r15
00000001000104f7	movq	%rdi, %rbx
00000001000104fa	movq	0x3b2f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010501	movq	(%rax), %rax
0000000100010504	movq	%rax, -0x30(%rbp)
0000000100010508	movb	$0x22, -0x40(%rbp)
000000010001050c	leaq	-0x40(%rbp), %rsi
0000000100010510	movl	$0x1, %edx
0000000100010515	callq	_buf_put
000000010001051a	testq	%r14, %r14
000000010001051d	je	0x100010619
0000000100010523	leaq	0x12a(%rip), %r12
000000010001052a	xorl	%r13d, %r13d
000000010001052d	jmp	0x100010551
000000010001052f	movl	$0x2, %edx
0000000100010534	movq	%rbx, %rdi
0000000100010537	leaq	0x2fec(%rip), %rsi              ## literal pool for: "\\r"
000000010001053e	nop
0000000100010540	callq	_buf_put
0000000100010545	incq	%r13
0000000100010548	cmpq	%r13, %r14
000000010001054b	je	0x100010619
0000000100010551	movzbl	(%r15,%r13), %eax
0000000100010556	movzbl	%al, %ecx
0000000100010559	leal	-0x9(%rcx), %edx
000000010001055c	cmpl	$0x19, %edx
000000010001055f	ja	0x100010580
0000000100010561	movslq	(%r12,%rdx,4), %rdx
0000000100010565	addq	%r12, %rdx
0000000100010568	jmpq	*%rdx
000000010001056a	movl	$0x2, %edx
000000010001056f	movq	%rbx, %rdi
0000000100010572	leaq	0x2fae(%rip), %rsi              ## literal pool for: "\\t"
0000000100010579	jmp	0x100010540
000000010001057b	nopl	(%rax,%rax)
0000000100010580	cmpl	$0x5c, %ecx
0000000100010583	jne	0x100010596
0000000100010585	movl	$0x2, %edx
000000010001058a	movq	%rbx, %rdi
000000010001058d	leaq	0x2f8d(%rip), %rsi              ## literal pool for: "\\\\"
0000000100010594	jmp	0x100010540
0000000100010596	cmpb	$0x20, %al
0000000100010598	setae	%dl
000000010001059b	cmpb	$0x7f, %al
000000010001059d	setne	%sil
00000001000105a1	testb	%sil, %dl
00000001000105a4	jne	0x100010605
00000001000105a6	movl	$0x10, %esi
00000001000105ab	leaq	-0x40(%rbp), %r12
00000001000105af	movq	%r12, %rdi
00000001000105b2	leaq	0x2f74(%rip), %rdx              ## literal pool for: "\\u{%x}"
00000001000105b9	xorl	%eax, %eax
00000001000105bb	callq	0x10001211e                     ## symbol stub for: _snprintf
00000001000105c0	movq	%r12, %rdi
00000001000105c3	callq	0x100012136                     ## symbol stub for: _strlen
00000001000105c8	movq	%rbx, %rdi
00000001000105cb	movq	%r12, %rsi
00000001000105ce	leaq	0x7f(%rip), %r12
00000001000105d5	movq	%rax, %rdx
00000001000105d8	jmp	0x100010540
00000001000105dd	movl	$0x2, %edx
00000001000105e2	movq	%rbx, %rdi
00000001000105e5	leaq	0x2f32(%rip), %rsi              ## literal pool for: "\\\""
00000001000105ec	jmp	0x100010540
00000001000105f1	movl	$0x2, %edx
00000001000105f6	movq	%rbx, %rdi
00000001000105f9	leaq	0x2f24(%rip), %rsi              ## literal pool for: "\\n"
0000000100010600	jmp	0x100010540
0000000100010605	movb	%al, -0x40(%rbp)
0000000100010608	movl	$0x1, %edx
000000010001060d	movq	%rbx, %rdi
0000000100010610	leaq	-0x40(%rbp), %rsi
0000000100010614	jmp	0x100010540
0000000100010619	movb	$0x22, -0x40(%rbp)
000000010001061d	leaq	-0x40(%rbp), %rsi
0000000100010621	movl	$0x1, %edx
0000000100010626	movq	%rbx, %rdi
0000000100010629	callq	_buf_put
000000010001062e	movq	0x39fb(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010635	movq	(%rax), %rax
0000000100010638	cmpq	-0x30(%rbp), %rax
000000010001063c	jne	0x10001064d
000000010001063e	addq	$0x18, %rsp
0000000100010642	popq	%rbx
0000000100010643	popq	%r12
0000000100010645	popq	%r13
0000000100010647	popq	%r14
0000000100010649	popq	%r15
000000010001064b	popq	%rbp
000000010001064c	retq
000000010001064d	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100010652	nop
0000000100010654	.byte 0x16 #bad opcode
0000000100010655	.byte 0xff #bad opcode
0000000100010656	.byte 0xff #bad opcode
0000000100010657	lcalll	*0x42ffffff(%rbp)
000000010001065d	.byte 0xff #bad opcode
000000010001065e	.byte 0xff #bad opcode
000000010001065f	incl	-0x1(%rdx)
0000000100010662	.byte 0xff #bad opcode
0000000100010663	.byte 0xff #bad opcode
0000000100010664	.byte 0xdb #bad opcode
0000000100010665	.byte 0xfe #bad opcode
0000000100010666	.byte 0xff #bad opcode
0000000100010667	incl	-0x1(%rdx)
000000010001066a	.byte 0xff #bad opcode
000000010001066b	incl	-0x1(%rdx)
000000010001066e	.byte 0xff #bad opcode
000000010001066f	incl	-0x1(%rdx)
0000000100010672	.byte 0xff #bad opcode
0000000100010673	incl	-0x1(%rdx)
0000000100010676	.byte 0xff #bad opcode
0000000100010677	incl	-0x1(%rdx)
000000010001067a	.byte 0xff #bad opcode
000000010001067b	incl	-0x1(%rdx)
000000010001067e	.byte 0xff #bad opcode
000000010001067f	incl	-0x1(%rdx)
0000000100010682	.byte 0xff #bad opcode
0000000100010683	incl	-0x1(%rdx)
0000000100010686	.byte 0xff #bad opcode
0000000100010687	incl	-0x1(%rdx)
000000010001068a	.byte 0xff #bad opcode
000000010001068b	incl	-0x1(%rdx)
000000010001068e	.byte 0xff #bad opcode
000000010001068f	incl	-0x1(%rdx)
0000000100010692	.byte 0xff #bad opcode
0000000100010693	incl	-0x1(%rdx)
0000000100010696	.byte 0xff #bad opcode
0000000100010697	incl	-0x1(%rdx)
000000010001069a	.byte 0xff #bad opcode
000000010001069b	incl	-0x1(%rdx)
000000010001069e	.byte 0xff #bad opcode
000000010001069f	incl	-0x1(%rdx)
00000001000106a2	.byte 0xff #bad opcode
00000001000106a3	incl	-0x1(%rdx)
00000001000106a6	.byte 0xff #bad opcode
00000001000106a7	incl	-0x1(%rdx)
00000001000106aa	.byte 0xff #bad opcode
00000001000106ab	incl	-0x1(%rdx)
00000001000106ae	.byte 0xff #bad opcode
00000001000106af	incl	-0x1(%rdx)
00000001000106b2	.byte 0xff #bad opcode
00000001000106b3	incl	-0x1(%rdx)
00000001000106b6	.byte 0xff #bad opcode
00000001000106b7	decl	0xfffffff(%rcx)
00000001000106bd	.byte 0x1f #bad opcode
00000001000106be	addb	%dl, 0x48(%rbp)
00000001000106c2	movl	%esp, %ebp
00000001000106c4	pushq	%r15
00000001000106c6	pushq	%r14
00000001000106c8	pushq	%r13
00000001000106ca	pushq	%r12
00000001000106cc	pushq	%rbx
00000001000106cd	subq	$0x88, %rsp
00000001000106d4	movq	0x3955(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000106db	movq	(%rax), %rax
00000001000106de	movq	%rax, -0x30(%rbp)
00000001000106e2	movq	%rsi, %rax
00000001000106e5	orq	%rdx, %rax
00000001000106e8	je	0x1000109b9
00000001000106ee	movq	%rdx, %r8
00000001000106f1	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
00000001000106fb	imulq	%rsi, %rcx
00000001000106ff	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
0000000100010709	movq	%rsi, %rax
000000010001070c	mulq	%r9
000000010001070f	addq	%rcx, %rdx
0000000100010712	imulq	%r8, %r9
0000000100010716	addq	%rdx, %r9
0000000100010719	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
0000000100010723	addq	%rax, %rcx
0000000100010726	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
0000000100010730	adcq	%r9, %rax
0000000100010733	movq	%rax, %rdx
0000000100010736	shrdq	$0xd, %rcx, %rdx
000000010001073b	shldq	$0x33, %rcx, %rax
0000000100010740	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
000000010001074a	cmpq	%rax, %rcx
000000010001074d	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
0000000100010752	sbbq	%rdx, %rax
0000000100010755	jae	0x1000109d6
000000010001075b	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
0000000100010765	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
000000010001076f	movq	%rsi, %rax
0000000100010772	mulq	%r9
0000000100010775	imulq	%rsi, %rcx
0000000100010779	addq	%rcx, %rdx
000000010001077c	imulq	%r8, %r9
0000000100010780	addq	%rdx, %r9
0000000100010783	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
000000010001078d	addq	%rax, %rcx
0000000100010790	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
000000010001079a	adcq	%r9, %rax
000000010001079d	movq	%rax, %rdx
00000001000107a0	shrdq	$0xb, %rcx, %rdx
00000001000107a5	shldq	$0x35, %rcx, %rax
00000001000107aa	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
00000001000107b4	cmpq	%rcx, %rax
00000001000107b7	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
00000001000107be	jb	0x1000109f8
00000001000107c4	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
00000001000107ce	imulq	%rsi, %rcx
00000001000107d2	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
00000001000107dc	movq	%rsi, %rax
00000001000107df	mulq	%r9
00000001000107e2	addq	%rcx, %rdx
00000001000107e5	imulq	%r8, %r9
00000001000107e9	addq	%rdx, %r9
00000001000107ec	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
00000001000107f6	addq	%rax, %rcx
00000001000107f9	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
0000000100010803	adcq	%r9, %rax
0000000100010806	movq	%rax, %rdx
0000000100010809	shrdq	$0x9, %rcx, %rdx
000000010001080e	shldq	$0x37, %rcx, %rax
0000000100010813	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
000000010001081d	cmpq	%rcx, %rax
0000000100010820	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
000000010001082a	sbbq	%rax, %rdx
000000010001082d	jb	0x100010af8
0000000100010833	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
000000010001083d	imulq	%rsi, %rcx
0000000100010841	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
000000010001084b	movq	%rsi, %rax
000000010001084e	mulq	%r9
0000000100010851	addq	%rcx, %rdx
0000000100010854	imulq	%r8, %r9
0000000100010858	addq	%rdx, %r9
000000010001085b	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
0000000100010865	addq	%rax, %rcx
0000000100010868	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
0000000100010872	adcq	%r9, %rax
0000000100010875	movq	%rax, %rdx
0000000100010878	shrdq	$0x6, %rcx, %rdx
000000010001087d	shldq	$0x3a, %rcx, %rax
0000000100010882	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
000000010001088c	cmpq	%rcx, %rax
000000010001088f	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
0000000100010899	sbbq	%rax, %rdx
000000010001089c	jb	0x100010b09
00000001000108a2	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
00000001000108ac	imulq	%rsi, %rcx
00000001000108b0	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
00000001000108ba	movq	%rsi, %rax
00000001000108bd	mulq	%r9
00000001000108c0	addq	%rcx, %rdx
00000001000108c3	imulq	%r8, %r9
00000001000108c7	addq	%rdx, %r9
00000001000108ca	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
00000001000108d4	addq	%rax, %rcx
00000001000108d7	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
00000001000108e1	adcq	%r9, %rax
00000001000108e4	movq	%rax, %rdx
00000001000108e7	shrdq	$0x3, %rcx, %rdx
00000001000108ec	shldq	$0x3d, %rcx, %rax
00000001000108f1	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
00000001000108fb	cmpq	%rcx, %rax
00000001000108fe	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
0000000100010908	sbbq	%rax, %rdx
000000010001090b	jb	0x100010b1a
0000000100010911	testq	%r8, %r8
0000000100010914	js	0x100010f3c
000000010001091a	xorl	%r10d, %r10d
000000010001091d	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010927	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010931	movq	%r8, %r14
0000000100010934	nopw	%cs:(%rax,%rax)
0000000100010940	movq	%r8, %rcx
0000000100010943	shldq	$0x3f, %rsi, %rcx
0000000100010948	shrq	%r14
000000010001094b	movq	%rcx, %r9
000000010001094e	addq	%r14, %r9
0000000100010951	adcq	$0x0, %r9
0000000100010955	movq	%r9, %rax
0000000100010958	mulq	%r11
000000010001095b	shrq	$0x2, %rdx
000000010001095f	leaq	(%rdx,%rdx,4), %rax
0000000100010963	subq	%rax, %r9
0000000100010966	subq	%r9, %rcx
0000000100010969	sbbq	$0x0, %r14
000000010001096d	movq	%rcx, %r9
0000000100010970	imulq	%rbx, %r9
0000000100010974	movq	%rcx, %rax
0000000100010977	mulq	%r11
000000010001097a	addq	%r9, %rdx
000000010001097d	imulq	%r11, %r14
0000000100010981	addq	%rdx, %r14
0000000100010984	movq	%rax, %rcx
0000000100010987	addq	%rax, %rcx
000000010001098a	leaq	(%rcx,%rcx,4), %rcx
000000010001098e	movl	%esi, %edx
0000000100010990	subl	%ecx, %edx
0000000100010992	orb	$0x30, %dl
0000000100010995	movb	%dl, -0x70(%rbp,%r10)
000000010001099a	incq	%r10
000000010001099d	cmpq	$0xa, %rsi
00000001000109a1	sbbq	$0x0, %r8
00000001000109a5	movq	%rax, %rsi
00000001000109a8	movq	%r14, %r8
00000001000109ab	jae	0x100010940
00000001000109ad	testl	%r10d, %r10d
00000001000109b0	jg	0x1000109c3
00000001000109b2	xorl	%eax, %eax
00000001000109b4	jmp	0x100010ad6
00000001000109b9	movb	$0x30, -0x70(%rbp)
00000001000109bd	movl	$0x1, %r10d
00000001000109c3	movl	%r10d, %eax
00000001000109c6	cmpq	$0x8, %rax
00000001000109ca	jae	0x1000109ef
00000001000109cc	xorl	%ecx, %ecx
00000001000109ce	movq	%rax, %rdx
00000001000109d1	jmp	0x100010ab2
00000001000109d6	movq	%rdi, %r14
00000001000109d9	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
00000001000109e3	leaq	_fwp_fmt_duration.units(%rip), %rbx
00000001000109ea	jmp	0x100010b29
00000001000109ef	cmpl	$0x20, %eax
00000001000109f2	jae	0x100010a11
00000001000109f4	xorl	%ecx, %ecx
00000001000109f6	jmp	0x100010a6b
00000001000109f8	movq	%rdi, %r14
00000001000109fb	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
0000000100010a05	leaq	0x3e64(%rip), %rbx
0000000100010a0c	jmp	0x100010b29
0000000100010a11	movl	%r10d, %edx
0000000100010a14	andl	$0x1f, %edx
0000000100010a17	movq	%rax, %rcx
0000000100010a1a	subq	%rdx, %rcx
0000000100010a1d	leaq	-0xa0(%rbp), %rsi
0000000100010a24	movdqa	0x1864(%rip), %xmm0
0000000100010a2c	movq	%rax, %r8
0000000100010a2f	nop
0000000100010a30	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100010a3a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010a41	pshufb	%xmm0, %xmm2
0000000100010a46	pshufb	%xmm0, %xmm1
0000000100010a4b	movdqa	%xmm2, -0x10(%rsi)
0000000100010a50	movdqa	%xmm1, (%rsi)
0000000100010a54	addq	$-0x20, %r8
0000000100010a58	addq	$0x20, %rsi
0000000100010a5c	cmpq	%r8, %rdx
0000000100010a5f	jne	0x100010a30
0000000100010a61	testq	%rdx, %rdx
0000000100010a64	je	0x100010ad6
0000000100010a66	cmpl	$0x7, %edx
0000000100010a69	jbe	0x100010ab2
0000000100010a6b	movl	%r10d, %edx
0000000100010a6e	andl	$0x7, %edx
0000000100010a71	movq	%rax, %rsi
0000000100010a74	subq	%rcx, %rsi
0000000100010a77	leaq	(%rcx,%rbp), %r8
0000000100010a7b	addq	$-0xb0, %r8
0000000100010a82	movq	%rax, %rcx
0000000100010a85	subq	%rdx, %rcx
0000000100010a88	movq	0x1810(%rip), %xmm0
0000000100010a90	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010a96	pshufb	%xmm0, %xmm1
0000000100010a9b	movq	%xmm1, (%r8)
0000000100010aa0	addq	$-0x8, %rsi
0000000100010aa4	addq	$0x8, %r8
0000000100010aa8	cmpq	%rsi, %rdx
0000000100010aab	jne	0x100010a90
0000000100010aad	testq	%rdx, %rdx
0000000100010ab0	je	0x100010ad6
0000000100010ab2	leaq	-0x70(%rbp), %rsi
0000000100010ab6	addq	%rsi, %rdx
0000000100010ab9	decq	%rdx
0000000100010abc	nopl	(%rax)
0000000100010ac0	movzbl	(%rdx), %esi
0000000100010ac3	movb	%sil, -0xb0(%rbp,%rcx)
0000000100010acb	incq	%rcx
0000000100010ace	decq	%rdx
0000000100010ad1	cmpq	%rcx, %rax
0000000100010ad4	jne	0x100010ac0
0000000100010ad6	movb	$0x0, -0xb0(%rbp,%rax)
0000000100010ade	leaq	0x2a54(%rip), %rsi              ## literal pool for: "%sns"
0000000100010ae5	leaq	-0xb0(%rbp), %rdx
0000000100010aec	xorl	%eax, %eax
0000000100010aee	callq	0x100012124                     ## symbol stub for: _sprintf
0000000100010af3	jmp	0x100010f16
0000000100010af8	movq	%rdi, %r14
0000000100010afb	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
0000000100010b00	leaq	0x3d79(%rip), %rbx
0000000100010b07	jmp	0x100010b29
0000000100010b09	movq	%rdi, %r14
0000000100010b0c	movl	$0xf4240, %edx                  ## imm = 0xF4240
0000000100010b11	leaq	0x3d78(%rip), %rbx
0000000100010b18	jmp	0x100010b29
0000000100010b1a	movq	%rdi, %r14
0000000100010b1d	movl	$0x3e8, %edx                    ## imm = 0x3E8
0000000100010b22	leaq	0x3d77(%rip), %rbx
0000000100010b29	xorl	%ecx, %ecx
0000000100010b2b	movq	%rsi, %rdi
0000000100010b2e	movq	%r8, %rsi
0000000100010b31	callq	0x100012004                     ## symbol stub for: ___divti3
0000000100010b36	movq	%rax, %rcx
0000000100010b39	movq	%rdx, %rsi
0000000100010b3c	testq	%rdx, %rdx
0000000100010b3f	js	0x100010bf0
0000000100010b45	movq	%rcx, %rax
0000000100010b48	orq	%rsi, %rax
0000000100010b4b	je	0x100010cc9
0000000100010b51	xorl	%r10d, %r10d
0000000100010b54	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010b5e	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010b68	movq	%rsi, %r12
0000000100010b6b	movq	%r14, %rdi
0000000100010b6e	nop
0000000100010b70	movq	%rsi, %r8
0000000100010b73	shldq	$0x3f, %rcx, %r8
0000000100010b78	shrq	%r12
0000000100010b7b	movq	%r8, %r9
0000000100010b7e	addq	%r12, %r9
0000000100010b81	adcq	$0x0, %r9
0000000100010b85	movq	%r9, %rax
0000000100010b88	mulq	%r11
0000000100010b8b	shrq	$0x2, %rdx
0000000100010b8f	leaq	(%rdx,%rdx,4), %rax
0000000100010b93	subq	%rax, %r9
0000000100010b96	subq	%r9, %r8
0000000100010b99	sbbq	$0x0, %r12
0000000100010b9d	movq	%r8, %r9
0000000100010ba0	imulq	%r15, %r9
0000000100010ba4	movq	%r8, %rax
0000000100010ba7	mulq	%r11
0000000100010baa	addq	%r9, %rdx
0000000100010bad	imulq	%r11, %r12
0000000100010bb1	addq	%rdx, %r12
0000000100010bb4	movq	%rax, %rdx
0000000100010bb7	addq	%rax, %rdx
0000000100010bba	leaq	(%rdx,%rdx,4), %rdx
0000000100010bbe	movl	%ecx, %r8d
0000000100010bc1	subl	%edx, %r8d
0000000100010bc4	orb	$0x30, %r8b
0000000100010bc8	movb	%r8b, -0x70(%rbp,%r10)
0000000100010bcd	incq	%r10
0000000100010bd0	cmpq	$0xa, %rcx
0000000100010bd4	sbbq	$0x0, %rsi
0000000100010bd8	movq	%rax, %rcx
0000000100010bdb	movq	%r12, %rsi
0000000100010bde	jae	0x100010b70
0000000100010be0	testl	%r10d, %r10d
0000000100010be3	jg	0x100010cd6
0000000100010be9	xorl	%eax, %eax
0000000100010beb	jmp	0x100010dc6
0000000100010bf0	movb	$0x2d, -0xb0(%rbp)
0000000100010bf7	xorl	%r9d, %r9d
0000000100010bfa	negq	%rcx
0000000100010bfd	movl	$0x0, %r11d
0000000100010c03	sbbq	%rsi, %r11
0000000100010c06	movl	$0x1, %r13d
0000000100010c0c	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010c16	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010c20	movq	%r11, %r12
0000000100010c23	nopw	%cs:(%rax,%rax)
0000000100010c30	movq	%r11, %rsi
0000000100010c33	shldq	$0x3f, %rcx, %rsi
0000000100010c38	shrq	%r12
0000000100010c3b	movq	%rsi, %rdi
0000000100010c3e	addq	%r12, %rdi
0000000100010c41	adcq	$0x0, %rdi
0000000100010c45	movq	%rdi, %rax
0000000100010c48	mulq	%r10
0000000100010c4b	movl	%r13d, %r8d
0000000100010c4e	shrq	$0x2, %rdx
0000000100010c52	leaq	(%rdx,%rdx,4), %rax
0000000100010c56	subq	%rax, %rdi
0000000100010c59	subq	%rdi, %rsi
0000000100010c5c	sbbq	$0x0, %r12
0000000100010c60	movq	%rsi, %rdi
0000000100010c63	movq	%rsi, %rax
0000000100010c66	mulq	%r10
0000000100010c69	imulq	%r15, %rdi
0000000100010c6d	addq	%rdi, %rdx
0000000100010c70	imulq	%r10, %r12
0000000100010c74	addq	%rdx, %r12
0000000100010c77	movq	%rax, %rdx
0000000100010c7a	addq	%rax, %rdx
0000000100010c7d	leaq	(%rdx,%rdx,4), %rdx
0000000100010c81	movl	%ecx, %esi
0000000100010c83	subl	%edx, %esi
0000000100010c85	orb	$0x30, %sil
0000000100010c89	movb	%sil, -0x70(%rbp,%r9)
0000000100010c8e	incq	%r9
0000000100010c91	leal	0x1(%r8), %r13d
0000000100010c95	cmpq	$0xa, %rcx
0000000100010c99	sbbq	$0x0, %r11
0000000100010c9d	movq	%rax, %rcx
0000000100010ca0	movq	%r12, %r11
0000000100010ca3	jae	0x100010c30
0000000100010ca5	testl	%r9d, %r9d
0000000100010ca8	movq	%r14, %rdi
0000000100010cab	jle	0x100010cf2
0000000100010cad	movl	%r9d, %eax
0000000100010cb0	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010cb5	cmpq	$0x8, %rax
0000000100010cb9	jae	0x100010dd3
0000000100010cbf	xorl	%ecx, %ecx
0000000100010cc1	movq	%rax, %rdx
0000000100010cc4	jmp	0x100010ec5
0000000100010cc9	movb	$0x30, -0x70(%rbp)
0000000100010ccd	movl	$0x1, %r10d
0000000100010cd3	movq	%r14, %rdi
0000000100010cd6	movl	%r10d, %eax
0000000100010cd9	cmpq	$0x8, %rax
0000000100010cdd	jae	0x100010ce9
0000000100010cdf	xorl	%ecx, %ecx
0000000100010ce1	movq	%rax, %rdx
0000000100010ce4	jmp	0x100010da2
0000000100010ce9	cmpl	$0x20, %eax
0000000100010cec	jae	0x100010cf9
0000000100010cee	xorl	%ecx, %ecx
0000000100010cf0	jmp	0x100010d5b
0000000100010cf2	xorl	%eax, %eax
0000000100010cf4	jmp	0x100010ef6
0000000100010cf9	movl	%r10d, %edx
0000000100010cfc	andl	$0x1f, %edx
0000000100010cff	movq	%rax, %rcx
0000000100010d02	subq	%rdx, %rcx
0000000100010d05	leaq	-0xa0(%rbp), %rsi
0000000100010d0c	movdqa	0x157c(%rip), %xmm0
0000000100010d14	movq	%rax, %r8
0000000100010d17	nopw	(%rax,%rax)
0000000100010d20	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100010d2a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010d31	pshufb	%xmm0, %xmm2
0000000100010d36	pshufb	%xmm0, %xmm1
0000000100010d3b	movdqa	%xmm2, -0x10(%rsi)
0000000100010d40	movdqa	%xmm1, (%rsi)
0000000100010d44	addq	$-0x20, %r8
0000000100010d48	addq	$0x20, %rsi
0000000100010d4c	cmpq	%r8, %rdx
0000000100010d4f	jne	0x100010d20
0000000100010d51	testq	%rdx, %rdx
0000000100010d54	je	0x100010dc6
0000000100010d56	cmpl	$0x7, %edx
0000000100010d59	jbe	0x100010da2
0000000100010d5b	movl	%r10d, %edx
0000000100010d5e	andl	$0x7, %edx
0000000100010d61	movq	%rax, %rsi
0000000100010d64	subq	%rcx, %rsi
0000000100010d67	leaq	(%rcx,%rbp), %r8
0000000100010d6b	addq	$-0xb0, %r8
0000000100010d72	movq	%rax, %rcx
0000000100010d75	subq	%rdx, %rcx
0000000100010d78	movq	0x1520(%rip), %xmm0
0000000100010d80	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010d86	pshufb	%xmm0, %xmm1
0000000100010d8b	movq	%xmm1, (%r8)
0000000100010d90	addq	$-0x8, %rsi
0000000100010d94	addq	$0x8, %r8
0000000100010d98	cmpq	%rsi, %rdx
0000000100010d9b	jne	0x100010d80
0000000100010d9d	testq	%rdx, %rdx
0000000100010da0	je	0x100010dc6
0000000100010da2	leaq	-0x70(%rbp), %rsi
0000000100010da6	addq	%rsi, %rdx
0000000100010da9	decq	%rdx
0000000100010dac	nopl	(%rax)
0000000100010db0	movzbl	(%rdx), %esi
0000000100010db3	movb	%sil, -0xb0(%rbp,%rcx)
0000000100010dbb	incq	%rcx
0000000100010dbe	decq	%rdx
0000000100010dc1	cmpq	%rcx, %rax
0000000100010dc4	jne	0x100010db0
0000000100010dc6	movb	$0x0, -0xb0(%rbp,%rax)
0000000100010dce	jmp	0x100010efe
0000000100010dd3	cmpl	$0x20, %eax
0000000100010dd6	jae	0x100010ddc
0000000100010dd8	xorl	%ecx, %ecx
0000000100010dda	jmp	0x100010e54
0000000100010ddc	movl	%r9d, %edx
0000000100010ddf	andl	$0x1f, %edx
0000000100010de2	movq	%rax, %rcx
0000000100010de5	subq	%rdx, %rcx
0000000100010de8	movl	%r8d, %esi
0000000100010deb	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010df1	leaq	(%rsi,%rbp), %r10
0000000100010df5	addq	$-0x80, %r10
0000000100010df9	movl	%r8d, %r11d
0000000100010dfc	andl	$0x1f, %r11d
0000000100010e00	subq	%r11, %rsi
0000000100010e03	xorl	%r11d, %r11d
0000000100010e06	movdqa	0x1482(%rip), %xmm0
0000000100010e0e	nop
0000000100010e10	movdqu	-0x10(%r10), %xmm1
0000000100010e16	movdqu	(%r10), %xmm2
0000000100010e1b	pshufb	%xmm0, %xmm2
0000000100010e20	pshufb	%xmm0, %xmm1
0000000100010e25	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100010e2f	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100010e39	addq	$0x20, %r11
0000000100010e3d	addq	$-0x20, %r10
0000000100010e41	cmpq	%r11, %rsi
0000000100010e44	jne	0x100010e10
0000000100010e46	testq	%rdx, %rdx
0000000100010e49	je	0x100010ef6
0000000100010e4f	cmpl	$0x7, %edx
0000000100010e52	jbe	0x100010ec5
0000000100010e54	movq	%rcx, %rsi
0000000100010e57	movl	%r9d, %edx
0000000100010e5a	andl	$0x7, %edx
0000000100010e5d	movq	%rax, %rcx
0000000100010e60	subq	%rdx, %rcx
0000000100010e63	movq	%rsi, %r9
0000000100010e66	negq	%r9
0000000100010e69	leaq	(%r9,%rbp), %r10
0000000100010e6d	addq	$-0x70, %r10
0000000100010e71	movl	%r8d, %r9d
0000000100010e74	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100010e7b	addq	%r9, %r10
0000000100010e7e	addq	$-0x8, %r10
0000000100010e82	movl	%r8d, %r11d
0000000100010e85	andl	$0x7, %r11d
0000000100010e89	subq	%r11, %r9
0000000100010e8c	movq	0x140c(%rip), %xmm0
0000000100010e94	nopw	%cs:(%rax,%rax)
0000000100010ea0	movq	(%r10), %xmm1
0000000100010ea5	pshufb	%xmm0, %xmm1
0000000100010eaa	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100010eb3	addq	$0x8, %rsi
0000000100010eb7	addq	$-0x8, %r10
0000000100010ebb	cmpq	%rsi, %r9
0000000100010ebe	jne	0x100010ea0
0000000100010ec0	testq	%rdx, %rdx
0000000100010ec3	je	0x100010ef6
0000000100010ec5	leaq	-0x70(%rbp), %rsi
0000000100010ec9	addq	%rsi, %rdx
0000000100010ecc	decq	%rdx
0000000100010ecf	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010ed6	nopw	%cs:(%rax,%rax)
0000000100010ee0	movzbl	(%rdx), %esi
0000000100010ee3	movb	%sil, -0xaf(%rbp,%rcx)
0000000100010eeb	incq	%rcx
0000000100010eee	decq	%rdx
0000000100010ef1	cmpq	%rcx, %r8
0000000100010ef4	jne	0x100010ee0
0000000100010ef6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100010efe	movq	(%rbx), %rcx
0000000100010f01	leaq	0x262c(%rip), %rsi              ## literal pool for: "%s%s"
0000000100010f08	leaq	-0xb0(%rbp), %rdx
0000000100010f0f	xorl	%eax, %eax
0000000100010f11	callq	0x100012124                     ## symbol stub for: _sprintf
0000000100010f16	movq	0x3113(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010f1d	movq	(%rax), %rax
0000000100010f20	cmpq	-0x30(%rbp), %rax
0000000100010f24	jne	0x100011123
0000000100010f2a	addq	$0x88, %rsp
0000000100010f31	popq	%rbx
0000000100010f32	popq	%r12
0000000100010f34	popq	%r13
0000000100010f36	popq	%r14
0000000100010f38	popq	%r15
0000000100010f3a	popq	%rbp
0000000100010f3b	retq
0000000100010f3c	movb	$0x2d, -0xb0(%rbp)
0000000100010f43	xorl	%r10d, %r10d
0000000100010f46	negq	%rsi
0000000100010f49	movl	$0x0, %ebx
0000000100010f4e	sbbq	%r8, %rbx
0000000100010f51	movl	$0x1, %r12d
0000000100010f57	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010f61	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010f6b	movq	%rbx, %r15
0000000100010f6e	nop
0000000100010f70	movq	%rbx, %rcx
0000000100010f73	shldq	$0x3f, %rsi, %rcx
0000000100010f78	shrq	%r15
0000000100010f7b	movq	%rcx, %r8
0000000100010f7e	addq	%r15, %r8
0000000100010f81	adcq	$0x0, %r8
0000000100010f85	movq	%r8, %rax
0000000100010f88	mulq	%r11
0000000100010f8b	movl	%r12d, %r9d
0000000100010f8e	shrq	$0x2, %rdx
0000000100010f92	leaq	(%rdx,%rdx,4), %rax
0000000100010f96	subq	%rax, %r8
0000000100010f99	subq	%r8, %rcx
0000000100010f9c	sbbq	$0x0, %r15
0000000100010fa0	movq	%rcx, %r8
0000000100010fa3	movq	%rcx, %rax
0000000100010fa6	mulq	%r11
0000000100010fa9	imulq	%r14, %r8
0000000100010fad	addq	%r8, %rdx
0000000100010fb0	imulq	%r11, %r15
0000000100010fb4	addq	%rdx, %r15
0000000100010fb7	movq	%rax, %rcx
0000000100010fba	addq	%rax, %rcx
0000000100010fbd	leaq	(%rcx,%rcx,4), %rcx
0000000100010fc1	movl	%esi, %edx
0000000100010fc3	subl	%ecx, %edx
0000000100010fc5	orb	$0x30, %dl
0000000100010fc8	movb	%dl, -0x70(%rbp,%r10)
0000000100010fcd	incq	%r10
0000000100010fd0	leal	0x1(%r9), %r12d
0000000100010fd4	cmpq	$0xa, %rsi
0000000100010fd8	sbbq	$0x0, %rbx
0000000100010fdc	movq	%rax, %rsi
0000000100010fdf	movq	%r15, %rbx
0000000100010fe2	jae	0x100010f70
0000000100010fe4	testl	%r10d, %r10d
0000000100010fe7	jle	0x100011001
0000000100010fe9	movl	%r10d, %eax
0000000100010fec	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010ff1	cmpq	$0x8, %rax
0000000100010ff5	jae	0x100011008
0000000100010ff7	xorl	%ecx, %ecx
0000000100010ff9	movq	%rax, %rdx
0000000100010ffc	jmp	0x1000110ec
0000000100011001	xorl	%eax, %eax
0000000100011003	jmp	0x100011116
0000000100011008	cmpl	$0x20, %eax
000000010001100b	jae	0x100011011
000000010001100d	xorl	%ecx, %ecx
000000010001100f	jmp	0x100011087
0000000100011011	movl	%r10d, %edx
0000000100011014	andl	$0x1f, %edx
0000000100011017	movq	%rax, %rcx
000000010001101a	subq	%rdx, %rcx
000000010001101d	movl	%r9d, %esi
0000000100011020	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100011026	leaq	(%rsi,%rbp), %r8
000000010001102a	addq	$-0x80, %r8
000000010001102e	movl	%r9d, %r11d
0000000100011031	andl	$0x1f, %r11d
0000000100011035	subq	%r11, %rsi
0000000100011038	xorl	%r11d, %r11d
000000010001103b	movdqa	0x124d(%rip), %xmm0
0000000100011043	movdqu	-0x10(%r8), %xmm1
0000000100011049	movdqu	(%r8), %xmm2
000000010001104e	pshufb	%xmm0, %xmm2
0000000100011053	pshufb	%xmm0, %xmm1
0000000100011058	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100011062	movdqu	%xmm1, -0x9f(%rbp,%r11)
000000010001106c	addq	$0x20, %r11
0000000100011070	addq	$-0x20, %r8
0000000100011074	cmpq	%r11, %rsi
0000000100011077	jne	0x100011043
0000000100011079	testq	%rdx, %rdx
000000010001107c	je	0x100011116
0000000100011082	cmpl	$0x7, %edx
0000000100011085	jbe	0x1000110ec
0000000100011087	movq	%rcx, %rsi
000000010001108a	movl	%r10d, %edx
000000010001108d	andl	$0x7, %edx
0000000100011090	movq	%rax, %rcx
0000000100011093	subq	%rdx, %rcx
0000000100011096	movq	%rsi, %r8
0000000100011099	negq	%r8
000000010001109c	leaq	(%r8,%rbp), %r10
00000001000110a0	addq	$-0x70, %r10
00000001000110a4	movl	%r9d, %r8d
00000001000110a7	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
00000001000110ae	addq	%r8, %r10
00000001000110b1	addq	$-0x8, %r10
00000001000110b5	movl	%r9d, %r11d
00000001000110b8	andl	$0x7, %r11d
00000001000110bc	subq	%r11, %r8
00000001000110bf	movq	0x11d9(%rip), %xmm0
00000001000110c7	movq	(%r10), %xmm1
00000001000110cc	pshufb	%xmm0, %xmm1
00000001000110d1	movq	%xmm1, -0xaf(%rbp,%rsi)
00000001000110da	addq	$0x8, %rsi
00000001000110de	addq	$-0x8, %r10
00000001000110e2	cmpq	%rsi, %r8
00000001000110e5	jne	0x1000110c7
00000001000110e7	testq	%rdx, %rdx
00000001000110ea	je	0x100011116
00000001000110ec	leaq	-0x70(%rbp), %rsi
00000001000110f0	addq	%rsi, %rdx
00000001000110f3	decq	%rdx
00000001000110f6	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
00000001000110fd	nopl	(%rax)
0000000100011100	movzbl	(%rdx), %esi
0000000100011103	movb	%sil, -0xaf(%rbp,%rcx)
000000010001110b	incq	%rcx
000000010001110e	decq	%rdx
0000000100011111	cmpq	%rcx, %r9
0000000100011114	jne	0x100011100
0000000100011116	movb	$0x0, -0xaf(%rbp,%rax)
000000010001111e	jmp	0x100010ade
0000000100011123	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
0000000100011128	nopl	(%rax,%rax)
_fwp_format_g:
0000000100011130	pushq	%rbp
0000000100011131	movq	%rsp, %rbp
0000000100011134	pushq	%r15
0000000100011136	pushq	%r14
0000000100011138	pushq	%r13
000000010001113a	pushq	%r12
000000010001113c	pushq	%rbx
000000010001113d	subq	$0x98, %rsp
0000000100011144	movl	%esi, %r12d
0000000100011147	movq	%rdi, %rbx
000000010001114a	movq	0x2edf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100011151	movq	(%rax), %rax
0000000100011154	movq	%rax, -0x30(%rbp)
0000000100011158	decl	%r12d
000000010001115b	leaq	0x23a5(%rip), %rdx              ## literal pool for: "%.*e"
0000000100011162	leaq	-0x70(%rbp), %r13
0000000100011166	movl	$0x40, %esi
000000010001116b	movq	%r13, %rdi
000000010001116e	movl	%r12d, %ecx
0000000100011171	movsd	%xmm0, -0xb8(%rbp)
0000000100011179	movb	$0x1, %al
000000010001117b	callq	0x10001211e                     ## symbol stub for: _snprintf
0000000100011180	movq	%r13, %rdi
0000000100011183	movl	$0x65, %esi
0000000100011188	callq	0x10001212a                     ## symbol stub for: _strchr
000000010001118d	movq	%rax, %r15
0000000100011190	leaq	0x1(%rax), %rdi
0000000100011194	callq	0x100012046                     ## symbol stub for: _atoi
0000000100011199	movl	%eax, %r14d
000000010001119c	leal	-0x11(%r14), %eax
00000001000111a0	cmpl	$-0x17, %eax
00000001000111a3	ja	0x10001120e
00000001000111a5	subq	%r13, %r15
00000001000111a8	leaq	-0xb0(%rbp), %r12
00000001000111af	movl	$0x40, %ecx
00000001000111b4	movq	%r12, %rdi
00000001000111b7	movq	%r13, %rsi
00000001000111ba	movq	%r15, %rdx
00000001000111bd	callq	0x10001200a                     ## symbol stub for: ___memcpy_chk
00000001000111c2	movb	$0x0, -0xb0(%rbp,%r15)
00000001000111cb	movq	%r12, %rdi
00000001000111ce	movl	$0x2e, %esi
00000001000111d3	callq	0x10001212a                     ## symbol stub for: _strchr
00000001000111d8	testq	%rax, %rax
00000001000111db	sete	%al
00000001000111de	testq	%r15, %r15
00000001000111e1	sete	%cl
00000001000111e4	orb	%al, %cl
00000001000111e6	jne	0x100011286
00000001000111ec	nopl	(%rax)
00000001000111f0	movzbl	-0xb1(%rbp,%r15), %eax
00000001000111f9	cmpl	$0x30, %eax
00000001000111fc	jne	0x100011278
00000001000111fe	movb	$0x0, -0xb1(%rbp,%r15)
0000000100011207	decq	%r15
000000010001120a	jne	0x1000111f0
000000010001120c	jmp	0x100011286
000000010001120e	subl	%r14d, %r12d
0000000100011211	xorl	%ecx, %ecx
0000000100011213	testl	%r12d, %r12d
0000000100011216	cmovgl	%r12d, %ecx
000000010001121a	leaq	0x22f5(%rip), %rdx              ## literal pool for: "%.*f"
0000000100011221	movl	$0x190, %esi                    ## imm = 0x190
0000000100011226	movq	%rbx, %rdi
0000000100011229	movsd	-0xb8(%rbp), %xmm0
0000000100011231	movb	$0x1, %al
0000000100011233	callq	0x10001211e                     ## symbol stub for: _snprintf
0000000100011238	movq	%rbx, %rdi
000000010001123b	callq	0x100012136                     ## symbol stub for: _strlen
0000000100011240	movq	%rax, %r14
0000000100011243	movq	%rbx, %rdi
0000000100011246	movl	$0x2e, %esi
000000010001124b	callq	0x10001212a                     ## symbol stub for: _strchr
0000000100011250	testq	%rax, %rax
0000000100011253	sete	%al
0000000100011256	testq	%r14, %r14
0000000100011259	sete	%cl
000000010001125c	orb	%al, %cl
000000010001125e	jne	0x1000112bb
0000000100011260	movzbl	-0x1(%rbx,%r14), %eax
0000000100011266	cmpl	$0x30, %eax
0000000100011269	jne	0x1000112dd
000000010001126b	movb	$0x0, -0x1(%rbx,%r14)
0000000100011271	decq	%r14
0000000100011274	jne	0x100011260
0000000100011276	jmp	0x1000112bb
0000000100011278	cmpl	$0x2e, %eax
000000010001127b	jne	0x100011286
000000010001127d	movb	$0x0, -0xb1(%rbp,%r15)
0000000100011286	movl	%r14d, %eax
0000000100011289	shrl	$0x1f, %eax
000000010001128c	leal	0x2b(,%rax,2), %r8d
0000000100011294	movl	%r14d, %r9d
0000000100011297	negl	%r9d
000000010001129a	cmovsl	%r14d, %r9d
000000010001129e	leaq	0x2267(%rip), %rdx              ## literal pool for: "%se%c%02d"
00000001000112a5	leaq	-0xb0(%rbp), %rcx
00000001000112ac	movl	$0x190, %esi                    ## imm = 0x190
00000001000112b1	movq	%rbx, %rdi
00000001000112b4	xorl	%eax, %eax
00000001000112b6	callq	0x10001211e                     ## symbol stub for: _snprintf
00000001000112bb	movq	0x2d6e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000112c2	movq	(%rax), %rax
00000001000112c5	cmpq	-0x30(%rbp), %rax
00000001000112c9	jne	0x1000112ea
00000001000112cb	addq	$0x98, %rsp
00000001000112d2	popq	%rbx
00000001000112d3	popq	%r12
00000001000112d5	popq	%r13
00000001000112d7	popq	%r14
00000001000112d9	popq	%r15
00000001000112db	popq	%rbp
00000001000112dc	retq
00000001000112dd	cmpl	$0x2e, %eax
00000001000112e0	jne	0x1000112bb
00000001000112e2	movb	$0x0, -0x1(%rbx,%r14)
00000001000112e8	jmp	0x1000112bb
00000001000112ea	callq	0x100012010                     ## symbol stub for: ___stack_chk_fail
00000001000112ef	nop
_fwp_encode:
00000001000112f0	pushq	%rbp
00000001000112f1	movq	%rsp, %rbp
00000001000112f4	pushq	%r15
00000001000112f6	pushq	%r14
00000001000112f8	pushq	%r13
00000001000112fa	pushq	%r12
00000001000112fc	pushq	%rbx
00000001000112fd	subq	$0x38, %rsp
0000000100011301	movl	(%rdx), %eax
0000000100011303	cmpq	$0x15, %rax
0000000100011307	ja	0x100011486
000000010001130d	movq	%rdx, %r14
0000000100011310	movq	%rsi, %rbx
0000000100011313	movq	%rdi, -0x38(%rbp)
0000000100011317	leaq	0x752(%rip), %rcx
000000010001131e	movslq	(%rcx,%rax,4), %rax
0000000100011322	addq	%rcx, %rax
0000000100011325	jmpq	*%rax
0000000100011327	movb	%bl, -0x29(%rbp)
000000010001132a	leaq	-0x29(%rbp), %r14
000000010001132e	movl	$0x1, %edx
0000000100011333	movq	-0x38(%rbp), %r15
0000000100011337	movq	%r15, %rdi
000000010001133a	movq	%r14, %rsi
000000010001133d	callq	_buf_put
0000000100011342	movb	%bh, -0x29(%rbp)
0000000100011345	movl	$0x1, %edx
000000010001134a	movq	%r15, %rdi
000000010001134d	movq	%r14, %rsi
0000000100011350	callq	_buf_put
0000000100011355	movl	%ebx, %eax
0000000100011357	shrl	$0x10, %eax
000000010001135a	movb	%al, -0x29(%rbp)
000000010001135d	movl	$0x1, %edx
0000000100011362	movq	%r15, %rdi
0000000100011365	movq	%r14, %rsi
0000000100011368	callq	_buf_put
000000010001136d	movl	%ebx, %eax
000000010001136f	shrl	$0x18, %eax
0000000100011372	movb	%al, -0x29(%rbp)
0000000100011375	movl	$0x1, %edx
000000010001137a	movq	%r15, %rdi
000000010001137d	movq	%r14, %rsi
0000000100011380	callq	_buf_put
0000000100011385	movq	%rbx, %rax
0000000100011388	shrq	$0x20, %rax
000000010001138c	movb	%al, -0x29(%rbp)
000000010001138f	movl	$0x1, %edx
0000000100011394	movq	%r15, %rdi
0000000100011397	movq	%r14, %rsi
000000010001139a	callq	_buf_put
000000010001139f	movq	%rbx, %rax
00000001000113a2	shrq	$0x28, %rax
00000001000113a6	movb	%al, -0x29(%rbp)
00000001000113a9	movl	$0x1, %edx
00000001000113ae	movq	%r15, %rdi
00000001000113b1	movq	%r14, %rsi
00000001000113b4	callq	_buf_put
00000001000113b9	movq	%rbx, %rax
00000001000113bc	shrq	$0x30, %rax
00000001000113c0	movb	%al, -0x29(%rbp)
00000001000113c3	movl	$0x1, %edx
00000001000113c8	movq	%r15, %rdi
00000001000113cb	movq	%r14, %rsi
00000001000113ce	callq	_buf_put
00000001000113d3	shrq	$0x38, %rbx
00000001000113d7	jmp	0x100011437
00000001000113d9	movb	%bl, -0x29(%rbp)
00000001000113dc	leaq	-0x29(%rbp), %rsi
00000001000113e0	movl	$0x1, %edx
00000001000113e5	movq	-0x38(%rbp), %rdi
00000001000113e9	jmp	0x100011481
00000001000113ee	movb	%bl, -0x29(%rbp)
00000001000113f1	leaq	-0x29(%rbp), %r14
00000001000113f5	movl	$0x1, %edx
00000001000113fa	movq	-0x38(%rbp), %r15
00000001000113fe	movq	%r15, %rdi
0000000100011401	movq	%r14, %rsi
0000000100011404	callq	_buf_put
0000000100011409	movb	%bh, -0x29(%rbp)
000000010001140c	movl	$0x1, %edx
0000000100011411	movq	%r15, %rdi
0000000100011414	movq	%r14, %rsi
0000000100011417	callq	_buf_put
000000010001141c	movl	%ebx, %eax
000000010001141e	shrl	$0x10, %eax
0000000100011421	movb	%al, -0x29(%rbp)
0000000100011424	movl	$0x1, %edx
0000000100011429	movq	%r15, %rdi
000000010001142c	movq	%r14, %rsi
000000010001142f	callq	_buf_put
0000000100011434	shrl	$0x18, %ebx
0000000100011437	movb	%bl, -0x29(%rbp)
000000010001143a	jmp	0x100011476
000000010001143c	movq	(%rbx), %r15
000000010001143f	cmpq	$0x80, %r15
0000000100011446	jae	0x100011678
000000010001144c	movq	%r15, %r13
000000010001144f	movq	-0x38(%rbp), %r12
0000000100011453	jmp	0x1000116b8
0000000100011458	movb	%bl, -0x29(%rbp)
000000010001145b	leaq	-0x29(%rbp), %r14
000000010001145f	movl	$0x1, %edx
0000000100011464	movq	-0x38(%rbp), %r15
0000000100011468	movq	%r15, %rdi
000000010001146b	movq	%r14, %rsi
000000010001146e	callq	_buf_put
0000000100011473	movb	%bh, -0x29(%rbp)
0000000100011476	movl	$0x1, %edx
000000010001147b	movq	%r15, %rdi
000000010001147e	movq	%r14, %rsi
0000000100011481	callq	_buf_put
0000000100011486	addq	$0x38, %rsp
000000010001148a	popq	%rbx
000000010001148b	popq	%r12
000000010001148d	popq	%r13
000000010001148f	popq	%r14
0000000100011491	popq	%r15
0000000100011493	popq	%rbp
0000000100011494	retq
0000000100011495	movq	(%rbx), %rax
0000000100011498	movq	0x8(%rbx), %r13
000000010001149c	movb	%al, -0x29(%rbp)
000000010001149f	movq	%rax, %rbx
00000001000114a2	leaq	-0x29(%rbp), %r14
00000001000114a6	movl	$0x1, %edx
00000001000114ab	movq	-0x38(%rbp), %r12
00000001000114af	movq	%r12, %rdi
00000001000114b2	movq	%r14, %rsi
00000001000114b5	callq	_buf_put
00000001000114ba	movb	%bh, -0x29(%rbp)
00000001000114bd	movl	$0x1, %edx
00000001000114c2	movq	%r12, %rdi
00000001000114c5	movq	%r14, %rsi
00000001000114c8	callq	_buf_put
00000001000114cd	movl	%r13d, %eax
00000001000114d0	shrl	$0x10, %eax
00000001000114d3	movl	%eax, -0x40(%rbp)
00000001000114d6	movl	%ebx, %eax
00000001000114d8	shrl	$0x10, %eax
00000001000114db	movb	%al, -0x29(%rbp)
00000001000114de	movl	$0x1, %edx
00000001000114e3	movq	%r12, %rdi
00000001000114e6	movq	%r14, %rsi
00000001000114e9	callq	_buf_put
00000001000114ee	movl	%r13d, %eax
00000001000114f1	shrl	$0x18, %eax
00000001000114f4	movl	%eax, -0x44(%rbp)
00000001000114f7	movl	%ebx, %eax
00000001000114f9	shrl	$0x18, %eax
00000001000114fc	movb	%al, -0x29(%rbp)
00000001000114ff	movl	$0x1, %edx
0000000100011504	movq	%r12, %rdi
0000000100011507	movq	%r14, %rsi
000000010001150a	callq	_buf_put
000000010001150f	movq	%r13, %rax
0000000100011512	shrq	$0x20, %rax
0000000100011516	movq	%rax, -0x60(%rbp)
000000010001151a	movq	%rbx, %rax
000000010001151d	shrq	$0x20, %rax
0000000100011521	movb	%al, -0x29(%rbp)
0000000100011524	movl	$0x1, %edx
0000000100011529	movq	%r12, %rdi
000000010001152c	movq	%r14, %rsi
000000010001152f	callq	_buf_put
0000000100011534	movq	%r13, %rax
0000000100011537	shrq	$0x28, %rax
000000010001153b	movq	%rax, -0x58(%rbp)
000000010001153f	movq	%rbx, %rax
0000000100011542	shrq	$0x28, %rax
0000000100011546	movb	%al, -0x29(%rbp)
0000000100011549	movl	$0x1, %edx
000000010001154e	movq	%r12, %rdi
0000000100011551	movq	%r14, %rsi
0000000100011554	callq	_buf_put
0000000100011559	movq	%r13, %rax
000000010001155c	shrq	$0x30, %rax
0000000100011560	movq	%rax, -0x50(%rbp)
0000000100011564	movq	%rbx, %rax
0000000100011567	shrq	$0x30, %rax
000000010001156b	movb	%al, -0x29(%rbp)
000000010001156e	movl	$0x1, %edx
0000000100011573	movq	%r12, %rdi
0000000100011576	movq	%r14, %rsi
0000000100011579	callq	_buf_put
000000010001157e	movq	%r13, %r15
0000000100011581	shrq	$0x38, %r15
0000000100011585	shrq	$0x38, %rbx
0000000100011589	movb	%bl, -0x29(%rbp)
000000010001158c	movl	$0x1, %edx
0000000100011591	movq	%r12, %rdi
0000000100011594	movq	%r14, %rsi
0000000100011597	callq	_buf_put
000000010001159c	movb	%r13b, -0x29(%rbp)
00000001000115a0	movq	%r13, %rbx
00000001000115a3	movl	$0x1, %edx
00000001000115a8	movq	%r12, %rdi
00000001000115ab	movq	%r14, %rsi
00000001000115ae	callq	_buf_put
00000001000115b3	movb	%bh, -0x29(%rbp)
00000001000115b6	movl	$0x1, %edx
00000001000115bb	movq	%r12, %rdi
00000001000115be	movq	%r14, %rsi
00000001000115c1	callq	_buf_put
00000001000115c6	movl	-0x40(%rbp), %eax
00000001000115c9	movb	%al, -0x29(%rbp)
00000001000115cc	movl	$0x1, %edx
00000001000115d1	movq	%r12, %rdi
00000001000115d4	movq	%r14, %rsi
00000001000115d7	callq	_buf_put
00000001000115dc	movl	-0x44(%rbp), %eax
00000001000115df	movb	%al, -0x29(%rbp)
00000001000115e2	movl	$0x1, %edx
00000001000115e7	movq	%r12, %rdi
00000001000115ea	movq	%r14, %rsi
00000001000115ed	callq	_buf_put
00000001000115f2	movq	-0x60(%rbp), %rax
00000001000115f6	movb	%al, -0x29(%rbp)
00000001000115f9	movl	$0x1, %edx
00000001000115fe	movq	%r12, %rdi
0000000100011601	movq	%r14, %rsi
0000000100011604	callq	_buf_put
0000000100011609	movq	-0x58(%rbp), %rax
000000010001160d	movb	%al, -0x29(%rbp)
0000000100011610	movl	$0x1, %edx
0000000100011615	movq	%r12, %rdi
0000000100011618	movq	%r14, %rsi
000000010001161b	callq	_buf_put
0000000100011620	movq	-0x50(%rbp), %rax
0000000100011624	movb	%al, -0x29(%rbp)
0000000100011627	movl	$0x1, %edx
000000010001162c	movq	%r12, %rdi
000000010001162f	movq	%r14, %rsi
0000000100011632	callq	_buf_put
0000000100011637	movb	%r15b, -0x29(%rbp)
000000010001163b	movl	$0x1, %edx
0000000100011640	movq	%r12, %rdi
0000000100011643	jmp	0x10001147e
0000000100011648	movq	(%rbx), %r15
000000010001164b	cmpq	$0x80, %r15
0000000100011652	jae	0x100011721
0000000100011658	movq	%r15, %r13
000000010001165b	movq	-0x38(%rbp), %r12
000000010001165f	jmp	0x100011759
0000000100011664	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010001166b	ja	0x10001182f
0000000100011671	movl	%ebx, %eax
0000000100011673	jmp	0x100011831
0000000100011678	leaq	-0x29(%rbp), %r14
000000010001167c	movq	%r15, %r13
000000010001167f	movq	-0x38(%rbp), %r12
0000000100011683	nopw	%cs:(%rax,%rax)
0000000100011690	shrq	$0x7, %r13
0000000100011694	movl	%r15d, %eax
0000000100011697	orb	$-0x80, %al
0000000100011699	movb	%al, -0x29(%rbp)
000000010001169c	movl	$0x1, %edx
00000001000116a1	movq	%r12, %rdi
00000001000116a4	movq	%r14, %rsi
00000001000116a7	callq	_buf_put
00000001000116ac	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
00000001000116b3	movq	%r13, %r15
00000001000116b6	ja	0x100011690
00000001000116b8	movb	%r13b, -0x29(%rbp)
00000001000116bc	leaq	-0x29(%rbp), %rsi
00000001000116c0	movl	$0x1, %edx
00000001000116c5	movq	%r12, %rdi
00000001000116c8	callq	_buf_put
00000001000116cd	movq	(%rbx), %rdx
00000001000116d0	addq	$0x8, %rbx
00000001000116d4	movq	%r12, %rdi
00000001000116d7	movq	%rbx, %rsi
00000001000116da	addq	$0x38, %rsp
00000001000116de	popq	%rbx
00000001000116df	popq	%r12
00000001000116e1	popq	%r13
00000001000116e3	popq	%r14
00000001000116e5	popq	%r15
00000001000116e7	popq	%rbp
00000001000116e8	jmp	_buf_put
00000001000116ed	testq	%rbx, %rbx
00000001000116f0	je	0x1000119ee
00000001000116f6	xorl	%r13d, %r13d
00000001000116f9	movq	%rbx, %rax
00000001000116fc	movq	-0x38(%rbp), %r12
0000000100011700	incq	%r13
0000000100011703	movq	0x10(%rax), %rax
0000000100011707	testq	%rax, %rax
000000010001170a	jne	0x100011700
000000010001170c	cmpq	$0x80, %r13
0000000100011713	jae	0x1000119f7
0000000100011719	movq	%r13, %r15
000000010001171c	jmp	0x100011a29
0000000100011721	movq	%r15, %r13
0000000100011724	movq	-0x38(%rbp), %r12
0000000100011728	nopl	(%rax,%rax)
0000000100011730	shrq	$0x7, %r13
0000000100011734	movl	%r15d, %eax
0000000100011737	orb	$-0x80, %al
0000000100011739	movb	%al, -0x29(%rbp)
000000010001173c	movl	$0x1, %edx
0000000100011741	movq	%r12, %rdi
0000000100011744	leaq	-0x29(%rbp), %rsi
0000000100011748	callq	_buf_put
000000010001174d	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
0000000100011754	movq	%r13, %r15
0000000100011757	ja	0x100011730
0000000100011759	movb	%r13b, -0x29(%rbp)
000000010001175d	leaq	-0x29(%rbp), %rsi
0000000100011761	movl	$0x1, %edx
0000000100011766	movq	%r12, %rdi
0000000100011769	callq	_buf_put
000000010001176e	cmpq	$0x0, (%rbx)
0000000100011772	je	0x100011486
0000000100011778	leaq	0x10(%rbx), %r15
000000010001177c	xorl	%r13d, %r13d
000000010001177f	jmp	0x1000117a0
0000000100011781	nopw	%cs:(%rax,%rax)
0000000100011790	incq	%r13
0000000100011793	addq	$0x10, %r15
0000000100011797	cmpq	(%rbx), %r13
000000010001179a	jae	0x100011486
00000001000117a0	movq	-0x8(%r15), %rsi
00000001000117a4	movq	0x38(%r14), %rdx
00000001000117a8	movq	%r12, %rdi
00000001000117ab	callq	_fwp_encode
00000001000117b0	cmpl	$0x12, (%r14)
00000001000117b4	jne	0x100011790
00000001000117b6	movq	(%r15), %rsi
00000001000117b9	movq	0x40(%r14), %rdx
00000001000117bd	movq	%r12, %rdi
00000001000117c0	callq	_fwp_encode
00000001000117c5	jmp	0x100011790
00000001000117c7	cmpl	$0x0, 0x10(%r14)
00000001000117cc	movq	-0x38(%rbp), %r12
00000001000117d0	jle	0x100011486
00000001000117d6	xorl	%r15d, %r15d
00000001000117d9	nopl	(%rax)
00000001000117e0	movq	0x8(%rbx,%r15,8), %rsi
00000001000117e5	movq	0x20(%r14), %rax
00000001000117e9	movq	(%rax,%r15,8), %rdx
00000001000117ed	movq	%r12, %rdi
00000001000117f0	callq	_fwp_encode
00000001000117f5	incq	%r15
00000001000117f8	movslq	0x10(%r14), %rax
00000001000117fc	cmpq	%rax, %r15
00000001000117ff	jl	0x1000117e0
0000000100011801	jmp	0x100011486
0000000100011806	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100011810	movq	(%rbx), %r15
0000000100011813	andq	%rax, %r15
0000000100011816	cmpq	$0x80, %r15
000000010001181d	jae	0x1000118de
0000000100011823	movq	%r15, %r13
0000000100011826	movq	-0x38(%rbp), %r12
000000010001182a	jmp	0x100011919
000000010001182f	movl	(%rbx), %eax
0000000100011831	movl	%eax, %r13d
0000000100011834	movq	%r13, -0x40(%rbp)
0000000100011838	cmpl	$0x80, %eax
000000010001183d	movq	-0x38(%rbp), %r12
0000000100011841	jb	0x100011879
0000000100011843	movq	-0x40(%rbp), %r15
0000000100011847	movq	%r15, %r13
000000010001184a	nopw	(%rax,%rax)
0000000100011850	shrq	$0x7, %r13
0000000100011854	movl	%r15d, %eax
0000000100011857	orb	$-0x80, %al
0000000100011859	movb	%al, -0x29(%rbp)
000000010001185c	movl	$0x1, %edx
0000000100011861	movq	%r12, %rdi
0000000100011864	leaq	-0x29(%rbp), %rsi
0000000100011868	callq	_buf_put
000000010001186d	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
0000000100011874	movq	%r13, %r15
0000000100011877	ja	0x100011850
0000000100011879	movb	%r13b, -0x29(%rbp)
000000010001187d	leaq	-0x29(%rbp), %rsi
0000000100011881	movl	$0x1, %edx
0000000100011886	movq	%r12, %r15
0000000100011889	movq	%r12, %rdi
000000010001188c	callq	_buf_put
0000000100011891	movq	0x28(%r14), %rax
0000000100011895	movq	-0x40(%rbp), %r12
0000000100011899	cmpl	$0x0, (%rax,%r12,4)
000000010001189e	jle	0x100011486
00000001000118a4	xorl	%r13d, %r13d
00000001000118a7	nopw	(%rax,%rax)
00000001000118b0	movq	0x8(%rbx,%r13,8), %rsi
00000001000118b5	movq	0x30(%r14), %rax
00000001000118b9	movq	(%rax,%r12,8), %rax
00000001000118bd	movq	(%rax,%r13,8), %rdx
00000001000118c1	movq	%r15, %rdi
00000001000118c4	callq	_fwp_encode
00000001000118c9	incq	%r13
00000001000118cc	movq	0x28(%r14), %rax
00000001000118d0	movslq	(%rax,%r12,4), %rax
00000001000118d4	cmpq	%rax, %r13
00000001000118d7	jl	0x1000118b0
00000001000118d9	jmp	0x100011486
00000001000118de	movq	%r15, %r13
00000001000118e1	movq	-0x38(%rbp), %r12
00000001000118e5	nopw	%cs:(%rax,%rax)
00000001000118f0	shrq	$0x7, %r13
00000001000118f4	movl	%r15d, %eax
00000001000118f7	orb	$-0x80, %al
00000001000118f9	movb	%al, -0x29(%rbp)
00000001000118fc	movl	$0x1, %edx
0000000100011901	movq	%r12, %rdi
0000000100011904	leaq	-0x29(%rbp), %rsi
0000000100011908	callq	_buf_put
000000010001190d	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
0000000100011914	movq	%r13, %r15
0000000100011917	ja	0x1000118f0
0000000100011919	movb	%r13b, -0x29(%rbp)
000000010001191d	leaq	-0x29(%rbp), %rsi
0000000100011921	movl	$0x1, %edx
0000000100011926	movq	%r12, %rdi
0000000100011929	callq	_buf_put
000000010001192e	movq	(%rbx), %rax
0000000100011931	movabsq	$0x7fffffffffffffff, %r12       ## imm = 0x7FFFFFFFFFFFFFFF
000000010001193b	testq	%r12, %rax
000000010001193e	je	0x100011486
0000000100011944	leaq	0x8(%rbx), %r15
0000000100011948	xorl	%r13d, %r13d
000000010001194b	jmp	0x100011979
000000010001194d	nopl	(%rax)
0000000100011950	cmpl	$0x1, (%rdx)
0000000100011953	movzwl	(%rsi,%rax), %eax
0000000100011957	movswq	%ax, %rsi
000000010001195b	cmovneq	%rax, %rsi
000000010001195f	callq	_fwp_encode
0000000100011964	incq	%r13
0000000100011967	movq	(%rbx), %rax
000000010001196a	movq	%rax, %rcx
000000010001196d	andq	%r12, %rcx
0000000100011970	cmpq	%rcx, %r13
0000000100011973	jae	0x100011486
0000000100011979	movq	0x38(%r14), %rdx
000000010001197d	movl	$0x8, %ecx
0000000100011982	testq	%rdx, %rdx
0000000100011985	je	0x1000119a0
0000000100011987	movl	(%rdx), %esi
0000000100011989	cmpq	$0xa, %rsi
000000010001198d	movq	-0x38(%rbp), %rdi
0000000100011991	ja	0x1000119a4
0000000100011993	leaq	0xbce(%rip), %rcx
000000010001199a	movq	(%rcx,%rsi,8), %rcx
000000010001199e	jmp	0x1000119a4
00000001000119a0	movq	-0x38(%rbp), %rdi
00000001000119a4	movq	%r15, %rsi
00000001000119a7	testq	%rax, %rax
00000001000119aa	jns	0x1000119b0
00000001000119ac	movq	0x10(%rbx), %rsi
00000001000119b0	movq	%rcx, %rax
00000001000119b3	imulq	%r13, %rax
00000001000119b7	cmpq	$0x1, %rcx
00000001000119bb	je	0x1000119d0
00000001000119bd	cmpq	$0x2, %rcx
00000001000119c1	je	0x100011950
00000001000119c3	cmpq	$0x8, %rcx
00000001000119c7	jne	0x1000119e0
00000001000119c9	movq	(%rsi,%rax), %rsi
00000001000119cd	jmp	0x10001195f
00000001000119cf	nop
00000001000119d0	cmpl	$0x0, (%rdx)
00000001000119d3	movzbl	(%rsi,%rax), %eax
00000001000119d7	movsbq	%al, %rsi
00000001000119db	jmp	0x10001195b
00000001000119e0	cmpl	$0x2, (%rdx)
00000001000119e3	movl	(%rsi,%rax), %eax
00000001000119e6	movslq	%eax, %rsi
00000001000119e9	jmp	0x10001195b
00000001000119ee	movb	$0x0, -0x29(%rbp)
00000001000119f2	jmp	0x1000113dc
00000001000119f7	movq	%r13, %r15
00000001000119fa	nopw	(%rax,%rax)
0000000100011a00	shrq	$0x7, %r15
0000000100011a04	movl	%r13d, %eax
0000000100011a07	orb	$-0x80, %al
0000000100011a09	movb	%al, -0x29(%rbp)
0000000100011a0c	movl	$0x1, %edx
0000000100011a11	movq	%r12, %rdi
0000000100011a14	leaq	-0x29(%rbp), %rsi
0000000100011a18	callq	_buf_put
0000000100011a1d	cmpq	$0x3fff, %r13                   ## imm = 0x3FFF
0000000100011a24	movq	%r15, %r13
0000000100011a27	ja	0x100011a00
0000000100011a29	movb	%r15b, -0x29(%rbp)
0000000100011a2d	leaq	-0x29(%rbp), %rsi
0000000100011a31	movl	$0x1, %edx
0000000100011a36	movq	%r12, %rdi
0000000100011a39	callq	_buf_put
0000000100011a3e	testq	%rbx, %rbx
0000000100011a41	je	0x100011486
0000000100011a47	nopw	(%rax,%rax)
0000000100011a50	movq	0x8(%rbx), %rsi
0000000100011a54	movq	0x38(%r14), %rdx
0000000100011a58	movq	%r12, %rdi
0000000100011a5b	callq	_fwp_encode
0000000100011a60	movq	0x10(%rbx), %rbx
0000000100011a64	testq	%rbx, %rbx
0000000100011a67	jne	0x100011a50
0000000100011a69	jmp	0x100011486
0000000100011a6e	nop
0000000100011a70	imull	$0xf9e8ffff, %ecx, %edi         ## imm = 0xF9E8FFFF
0000000100011a76	.byte 0xff #bad opcode
0000000100011a77	.byte 0xff #bad opcode
0000000100011a78	jle	0x100011a73
0000000100011a7a	.byte 0xff #bad opcode
0000000100011a7b	pushq	0x25fffff8(%rdi)
0000000100011a81	cli
0000000100011a82	.byte 0xff #bad opcode
0000000100011a83	ljmpl	*-0x7(%rcx)
0000000100011a86	.byte 0xff #bad opcode
0000000100011a87	.byte 0xff #bad opcode
0000000100011a88	callq	0x17f011a86
0000000100011a8d	stc
0000000100011a8e	.byte 0xff #bad opcode
0000000100011a8f	pushq	0x25fffff8(%rdi)
0000000100011a95	cli
0000000100011a96	.byte 0xff #bad opcode
0000000100011a97	.byte 0xff #bad opcode
0000000100011a98	jle	0x100011a93
0000000100011a9a	.byte 0xff #bad opcode
0000000100011a9b	pushq	-0x33000008(%rdi)
0000000100011aa1	stc
0000000100011aa2	.byte 0xff #bad opcode
0000000100011aa3	decl	%esp
0000000100011aa5	stc
0000000100011aa6	.byte 0xff #bad opcode
0000000100011aa7	pushq	%rsp
0000000100011aa9	sti
0000000100011aaa	.byte 0xff #bad opcode
0000000100011aab	.byte 0xff #bad opcode
0000000100011aac	jge	0x100011aaa
0000000100011aae	.byte 0xff #bad opcode
0000000100011aaf	callq	*-0x3(%rdi)
0000000100011ab2	.byte 0xff #bad opcode
0000000100011ab3	callq	*-0x27000003(%rsi)
0000000100011ab9	sti
0000000100011aba	.byte 0xff #bad opcode
0000000100011abb	.byte 0xff #bad opcode
0000000100011abc	fdivr	%st(3), %st
0000000100011abe	.byte 0xff #bad opcode
0000000100011abf	pushq	0x69fffff8(%rdi)
0000000100011ac5	stc
0000000100011ac6	.byte 0xff #bad opcode
0000000100011ac7	decl	(%rdi)
0000000100011ac9	.byte 0x1f #bad opcode
0000000100011aca	testb	%al, (%rax)
0000000100011acc	addb	%al, (%rax)
0000000100011ace	addb	%al, (%rax)
_rd_leb:
0000000100011ad0	movq	$0x0, (%rsi)
0000000100011ad7	movq	0x8(%rdi), %r8
0000000100011adb	movq	0x10(%rdi), %rdx
0000000100011adf	cmpq	%rdx, %r8
0000000100011ae2	jne	0x100011ae7
0000000100011ae4	xorl	%eax, %eax
0000000100011ae6	retq
0000000100011ae7	pushq	%rbp
0000000100011ae8	movq	%rsp, %rbp
0000000100011aeb	movq	(%rdi), %rcx
0000000100011aee	leaq	0x1(%rdx), %r9
0000000100011af2	movq	%r9, 0x10(%rdi)
0000000100011af6	movzbl	(%rcx,%rdx), %r10d
0000000100011afb	andl	$0x7f, %r10d
0000000100011aff	movq	%r10, (%rsi)
0000000100011b02	movl	$0x1, %eax
0000000100011b07	cmpb	$0x0, (%rcx,%rdx)
0000000100011b0b	js	0x100011b0f
0000000100011b0d	popq	%rbp
0000000100011b0e	retq
0000000100011b0f	cmpq	%r9, %r8
0000000100011b12	jne	0x100011b18
0000000100011b14	xorl	%eax, %eax
0000000100011b16	popq	%rbp
0000000100011b17	retq
0000000100011b18	leaq	0x2(%rdx), %r11
0000000100011b1c	movq	%r11, 0x10(%rdi)
0000000100011b20	movzbl	0x1(%rcx,%rdx), %r9d
0000000100011b26	andl	$0x7f, %r9d
0000000100011b2a	shll	$0x7, %r9d
0000000100011b2e	orq	%r10, %r9
0000000100011b31	movq	%r9, (%rsi)
0000000100011b34	cmpb	$0x0, 0x1(%rcx,%rdx)
0000000100011b39	jns	0x100011b0d
0000000100011b3b	cmpq	%r11, %r8
0000000100011b3e	je	0x100011b14
0000000100011b40	leaq	0x3(%rdx), %r11
0000000100011b44	movq	%r11, 0x10(%rdi)
0000000100011b48	movzbl	0x2(%rcx,%rdx), %r10d
0000000100011b4e	andl	$0x7f, %r10d
0000000100011b52	shll	$0xe, %r10d
0000000100011b56	orq	%r9, %r10
0000000100011b59	movq	%r10, (%rsi)
0000000100011b5c	cmpb	$0x0, 0x2(%rcx,%rdx)
0000000100011b61	jns	0x100011b0d
0000000100011b63	cmpq	%r11, %r8
0000000100011b66	je	0x100011b14
0000000100011b68	leaq	0x4(%rdx), %r11
0000000100011b6c	movq	%r11, 0x10(%rdi)
0000000100011b70	movzbl	0x3(%rcx,%rdx), %r9d
0000000100011b76	andl	$0x7f, %r9d
0000000100011b7a	shll	$0x15, %r9d
0000000100011b7e	orq	%r10, %r9
0000000100011b81	movq	%r9, (%rsi)
0000000100011b84	cmpb	$0x0, 0x3(%rcx,%rdx)
0000000100011b89	jns	0x100011b0d
0000000100011b8b	cmpq	%r11, %r8
0000000100011b8e	je	0x100011b14
0000000100011b90	leaq	0x5(%rdx), %r11
0000000100011b94	movq	%r11, 0x10(%rdi)
0000000100011b98	movzbl	0x4(%rcx,%rdx), %r10d
0000000100011b9e	andl	$0x7f, %r10d
0000000100011ba2	shlq	$0x1c, %r10
0000000100011ba6	orq	%r9, %r10
0000000100011ba9	movq	%r10, (%rsi)
0000000100011bac	cmpb	$0x0, 0x4(%rcx,%rdx)
0000000100011bb1	jns	0x100011b0d
0000000100011bb7	cmpq	%r11, %r8
0000000100011bba	je	0x100011b14
0000000100011bc0	leaq	0x6(%rdx), %r11
0000000100011bc4	movq	%r11, 0x10(%rdi)
0000000100011bc8	movzbl	0x5(%rcx,%rdx), %r9d
0000000100011bce	andl	$0x7f, %r9d
0000000100011bd2	shlq	$0x23, %r9
0000000100011bd6	orq	%r10, %r9
0000000100011bd9	movq	%r9, (%rsi)
0000000100011bdc	cmpb	$0x0, 0x5(%rcx,%rdx)
0000000100011be1	jns	0x100011b0d
0000000100011be7	cmpq	%r11, %r8
0000000100011bea	je	0x100011b14
0000000100011bf0	leaq	0x7(%rdx), %r11
0000000100011bf4	movq	%r11, 0x10(%rdi)
0000000100011bf8	movzbl	0x6(%rcx,%rdx), %r10d
0000000100011bfe	andl	$0x7f, %r10d
0000000100011c02	shlq	$0x2a, %r10
0000000100011c06	orq	%r9, %r10
0000000100011c09	movq	%r10, (%rsi)
0000000100011c0c	cmpb	$0x0, 0x6(%rcx,%rdx)
0000000100011c11	jns	0x100011b0d
0000000100011c17	cmpq	%r11, %r8
0000000100011c1a	je	0x100011b14
0000000100011c20	leaq	0x8(%rdx), %r9
0000000100011c24	movq	%r9, 0x10(%rdi)
0000000100011c28	movzbl	0x7(%rcx,%rdx), %r11d
0000000100011c2e	andl	$0x7f, %r11d
0000000100011c32	shlq	$0x31, %r11
0000000100011c36	orq	%r10, %r11
0000000100011c39	movq	%r11, (%rsi)
0000000100011c3c	cmpb	$0x0, 0x7(%rcx,%rdx)
0000000100011c41	jns	0x100011b0d
0000000100011c47	cmpq	%r9, %r8
0000000100011c4a	je	0x100011b14
0000000100011c50	leaq	0x9(%rdx), %r9
0000000100011c54	movq	%r9, 0x10(%rdi)
0000000100011c58	movzbl	0x8(%rcx,%rdx), %r10d
0000000100011c5e	andl	$0x7f, %r10d
0000000100011c62	shlq	$0x38, %r10
0000000100011c66	orq	%r11, %r10
0000000100011c69	movq	%r10, (%rsi)
0000000100011c6c	cmpb	$0x0, 0x8(%rcx,%rdx)
0000000100011c71	jns	0x100011b0d
0000000100011c77	cmpq	%r9, %r8
0000000100011c7a	je	0x100011b14
0000000100011c80	leaq	0xa(%rdx), %rax
0000000100011c84	movq	%rax, 0x10(%rdi)
0000000100011c88	movzbl	0x9(%rcx,%rdx), %edx
0000000100011c8d	movl	$0x0, %eax
0000000100011c92	testb	$0x7e, %dl
0000000100011c95	jne	0x100011b0d
0000000100011c9b	shlq	$0x3f, %rdx
0000000100011c9f	orq	%r10, %rdx
0000000100011ca2	movq	%rdx, (%rsi)
0000000100011ca5	xorl	%eax, %eax
0000000100011ca7	cmpb	$0x0, (%rcx,%r9)
0000000100011cac	setns	%al
0000000100011caf	popq	%rbp
0000000100011cb0	retq
0000000100011cb1	nopw	%cs:(%rax,%rax)
_fwp_wire_empty_inner:
0000000100011cc0	xorl	%eax, %eax
0000000100011cc2	testq	%rdi, %rdi
0000000100011cc5	je	0x100011d6c
0000000100011ccb	cmpl	$0x10, (%rdi)
0000000100011cce	jne	0x100011d6c
0000000100011cd4	pushq	%rbp
0000000100011cd5	movq	%rsp, %rbp
0000000100011cd8	pushq	%r15
0000000100011cda	pushq	%r14
0000000100011cdc	pushq	%r12
0000000100011cde	pushq	%rbx
0000000100011cdf	subq	$0x10, %rsp
0000000100011ce3	testq	%rsi, %rsi
0000000100011ce6	je	0x100011cfe
0000000100011ce8	movq	%rsi, %rcx
0000000100011ceb	nopl	(%rax,%rax)
0000000100011cf0	cmpq	%rdi, (%rcx)
0000000100011cf3	je	0x100011d60
0000000100011cf5	movq	0x8(%rcx), %rcx
0000000100011cf9	testq	%rcx, %rcx
0000000100011cfc	jne	0x100011cf0
0000000100011cfe	movq	%rdi, -0x30(%rbp)
0000000100011d02	movq	%rsi, -0x28(%rbp)
0000000100011d06	movslq	0x10(%rdi), %r14
0000000100011d0a	testq	%r14, %r14
0000000100011d0d	jle	0x100011d57
0000000100011d0f	movq	0x20(%rdi), %r15
0000000100011d13	movq	(%r15), %rdi
0000000100011d16	leaq	-0x30(%rbp), %rsi
0000000100011d1a	callq	_fwp_wire_empty_inner
0000000100011d1f	testl	%eax, %eax
0000000100011d21	je	0x100011d5e
0000000100011d23	movl	$0x1, %ecx
0000000100011d28	leaq	-0x30(%rbp), %rbx
0000000100011d2c	nopl	(%rax)
0000000100011d30	movq	%rcx, %r12
0000000100011d33	cmpq	%rcx, %r14
0000000100011d36	je	0x100011d4d
0000000100011d38	movq	(%r15,%r12,8), %rdi
0000000100011d3c	movq	%rbx, %rsi
0000000100011d3f	callq	_fwp_wire_empty_inner
0000000100011d44	leaq	0x1(%r12), %rcx
0000000100011d49	testl	%eax, %eax
0000000100011d4b	jne	0x100011d30
0000000100011d4d	xorl	%eax, %eax
0000000100011d4f	cmpq	%r14, %r12
0000000100011d52	setae	%al
0000000100011d55	jmp	0x100011d60
0000000100011d57	movl	$0x1, %eax
0000000100011d5c	jmp	0x100011d60
0000000100011d5e	xorl	%eax, %eax
0000000100011d60	addq	$0x10, %rsp
0000000100011d64	popq	%rbx
0000000100011d65	popq	%r12
0000000100011d67	popq	%r14
0000000100011d69	popq	%r15
0000000100011d6b	popq	%rbp
0000000100011d6c	retq
0000000100011d6d	nopl	(%rax)
_fwp_gc_report:
0000000100011d70	pushq	%rbp
0000000100011d71	movq	%rsp, %rbp
0000000100011d74	pushq	%r15
0000000100011d76	pushq	%r14
0000000100011d78	pushq	%r13
0000000100011d7a	pushq	%r12
0000000100011d7c	pushq	%rbx
0000000100011d7d	subq	$0xb8, %rsp
0000000100011d84	movq	0x448d(%rip), %rax
0000000100011d8b	movq	_fwp_gc(%rip), %rcx
0000000100011d92	subq	%rcx, %rax
0000000100011d95	cvtsi2sd	%rax, %xmm0
0000000100011d9a	addsd	0x444e(%rip), %xmm0
0000000100011da2	movsd	%xmm0, -0x50(%rbp)
0000000100011da7	movsd	%xmm0, 0x4441(%rip)
0000000100011daf	movq	%rcx, 0x4462(%rip)
0000000100011db6	movq	0x227b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100011dbd	movq	(%rax), %r15
0000000100011dc0	movq	0x4419(%rip), %rax
0000000100011dc7	movq	%rax, -0x30(%rbp)
0000000100011dcb	movq	0x424e(%rip), %r14
0000000100011dd2	movsd	0x4436(%rip), %xmm0
0000000100011dda	movsd	%xmm0, -0x38(%rbp)
0000000100011ddf	movq	0x426a(%rip), %r12
0000000100011de6	movq	0x43e3(%rip), %r13
0000000100011ded	movq	0x43e4(%rip), %rbx
0000000100011df4	movsd	0x43fc(%rip), %xmm0
0000000100011dfc	movsd	%xmm0, -0x48(%rbp)
0000000100011e01	movsd	0x43f7(%rip), %xmm0
0000000100011e09	movsd	%xmm0, -0x40(%rbp)
0000000100011e0e	leaq	-0xe0(%rbp), %rsi
0000000100011e15	xorl	%edi, %edi
0000000100011e17	callq	0x10001209a                     ## symbol stub for: _getrusage
0000000100011e1c	movq	$-0x1, %r8
0000000100011e23	testl	%eax, %eax
0000000100011e25	jne	0x100011e40
0000000100011e27	movq	-0xc0(%rbp), %rax
0000000100011e2e	leaq	0x3ff(%rax), %r8
0000000100011e35	testq	%rax, %rax
0000000100011e38	cmovnsq	%rax, %r8
0000000100011e3c	sarq	$0xa, %r8
0000000100011e40	movq	%rbx, %xmm0
0000000100011e45	movq	0x463(%rip), %xmm1
0000000100011e4d	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100011e51	movapd	0x467(%rip), %xmm2
0000000100011e59	subpd	%xmm2, %xmm0
0000000100011e5d	movapd	%xmm0, %xmm4
0000000100011e61	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100011e65	addsd	%xmm0, %xmm4
0000000100011e69	movsd	0x4b7(%rip), %xmm6
0000000100011e71	mulsd	%xmm6, %xmm4
0000000100011e75	movq	%r13, %xmm5
0000000100011e7a	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100011e7e	subpd	%xmm2, %xmm5
0000000100011e82	movapd	%xmm5, %xmm3
0000000100011e86	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
0000000100011e8a	addsd	%xmm5, %xmm3
0000000100011e8e	mulsd	%xmm6, %xmm3
0000000100011e92	movq	%r12, %xmm5
0000000100011e97	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100011e9b	subpd	%xmm2, %xmm5
0000000100011e9f	movapd	%xmm5, %xmm2
0000000100011ea3	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
0000000100011ea7	addsd	%xmm5, %xmm2
0000000100011eab	mulsd	%xmm6, %xmm2
0000000100011eaf	movsd	-0x50(%rbp), %xmm0
0000000100011eb4	movsd	-0x38(%rbp), %xmm1
0000000100011eb9	addsd	%xmm1, %xmm0
0000000100011ebd	mulsd	%xmm6, %xmm1
0000000100011ec1	mulsd	%xmm6, %xmm0
0000000100011ec5	cmpl	$0x0, 0x4130(%rip)
0000000100011ecc	leaq	0x1835(%rip), %rax              ## literal pool for: " (collection off)"
0000000100011ed3	leaq	0x868(%rip), %r9                ## literal pool for: ""
0000000100011eda	cmoveq	%rax, %r9
0000000100011ede	leaq	0x1774(%rip), %rsi              ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100011ee5	movq	%r15, %rdi
0000000100011ee8	movq	-0x30(%rbp), %rdx
0000000100011eec	movq	%r14, %rcx
0000000100011eef	movsd	-0x48(%rbp), %xmm5
0000000100011ef4	movsd	-0x40(%rbp), %xmm6
0000000100011ef9	movb	$0x7, %al
0000000100011efb	callq	0x10001206a                     ## symbol stub for: _fprintf
0000000100011f00	addq	$0xb8, %rsp
0000000100011f07	popq	%rbx
0000000100011f08	popq	%r12
0000000100011f0a	popq	%r13
0000000100011f0c	popq	%r14
0000000100011f0e	popq	%r15
0000000100011f10	popq	%rbp
0000000100011f11	retq
0000000100011f12	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.1:
0000000100011f20	pushq	%rbp
0000000100011f21	movq	%rsp, %rbp
0000000100011f24	pushq	$0x8
0000000100011f26	popq	%rdi
0000000100011f27	pushq	$0x2
0000000100011f29	popq	%rsi
0000000100011f2a	callq	_fwp_gc_alloc_slow
0000000100011f2f	popq	%rbp
0000000100011f30	retq
0000000100011f31	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.2:
0000000100011f40	pushq	%rbp
0000000100011f41	movq	%rsp, %rbp
0000000100011f44	pushq	$0x1
0000000100011f46	popq	%rdi
0000000100011f47	pushq	$0x1
0000000100011f49	popq	%rsi
0000000100011f4a	callq	_fwp_gc_alloc_slow
0000000100011f4f	popq	%rbp
0000000100011f50	retq
0000000100011f51	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr.cold.1:
0000000100011f60	pushq	%rbp
0000000100011f61	movq	%rsp, %rbp
0000000100011f64	pushq	%rbx
0000000100011f65	pushq	%rax
0000000100011f66	movq	%rdi, %rbx
0000000100011f69	leaq	0x8e0(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100011f70	callq	0x10001208e                     ## symbol stub for: _getenv
0000000100011f75	testq	%rax, %rax
0000000100011f78	je	0x100011f91
0000000100011f7a	movzbl	(%rax), %ecx
0000000100011f7d	testl	%ecx, %ecx
0000000100011f7f	je	0x100011f98
0000000100011f81	cmpl	$0x30, %ecx
0000000100011f84	jne	0x100011f95
0000000100011f86	xorl	%ecx, %ecx
0000000100011f88	cmpb	$0x0, 0x1(%rax)
0000000100011f8c	setne	%cl
0000000100011f8f	jmp	0x100011f98
0000000100011f91	xorl	%ecx, %ecx
0000000100011f93	jmp	0x100011f98
0000000100011f95	pushq	$0x1
0000000100011f97	popq	%rcx
0000000100011f98	movl	%ecx, (%rbx)
0000000100011f9a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100011fa0	addq	$0x8, %rsp
0000000100011fa4	popq	%rbx
0000000100011fa5	popq	%rbp
0000000100011fa6	retq
0000000100011fa7	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
0000000100011fb0	pushq	%rbp
0000000100011fb1	movq	%rsp, %rbp
0000000100011fb4	pushq	%rbx
0000000100011fb5	pushq	%rax
0000000100011fb6	movq	%rdi, %rbx
0000000100011fb9	leaq	0x890(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100011fc0	callq	0x10001208e                     ## symbol stub for: _getenv
0000000100011fc5	testq	%rax, %rax
0000000100011fc8	je	0x100011fe1
0000000100011fca	movzbl	(%rax), %ecx
0000000100011fcd	testl	%ecx, %ecx
0000000100011fcf	je	0x100011fe8
0000000100011fd1	cmpl	$0x30, %ecx
0000000100011fd4	jne	0x100011fe5
0000000100011fd6	xorl	%ecx, %ecx
0000000100011fd8	cmpb	$0x0, 0x1(%rax)
0000000100011fdc	setne	%cl
0000000100011fdf	jmp	0x100011fe8
0000000100011fe1	xorl	%ecx, %ecx
0000000100011fe3	jmp	0x100011fe8
0000000100011fe5	pushq	$0x1
0000000100011fe7	popq	%rcx
0000000100011fe8	movl	%ecx, (%rbx)
0000000100011fea	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100011ff0	addq	$0x8, %rsp
0000000100011ff4	popq	%rbx
0000000100011ff5	popq	%rbp
0000000100011ff6	retq
