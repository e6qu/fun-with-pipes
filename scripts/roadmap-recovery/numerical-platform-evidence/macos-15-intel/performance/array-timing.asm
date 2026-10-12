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
00000001000006eb	movq	0x1493e(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000006f2	movq	(%rax), %rax
00000001000006f5	movq	%rax, -0x18(%rbp)
00000001000006f9	leaq	_fwp_fn_table(%rip), %rax
0000000100000700	movq	%rax, _fwp_fns(%rip)
0000000100000707	movq	0x1493a(%rip), %r14             ## literal pool symbol address: ___stdoutp
000000010000070e	movq	(%r14), %rax
0000000100000711	movq	%rax, _fwp_prog_out(%rip)
0000000100000718	movl	%edi, _fwp_argc(%rip)
000000010000071e	movq	%rsi, _fwp_argv(%rip)
0000000100000725	leaq	_fwp_start_time(%rip), %rsi
000000010000072c	movl	$0x6, %edi
0000000100000731	callq	0x100012c42                     ## symbol stub for: _clock_gettime
0000000100000736	leaq	0x12ebc(%rip), %rdi             ## literal pool for: "FWP_SEED"
000000010000073d	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100000742	testq	%rax, %rax
0000000100000745	je	0x10000076d
0000000100000747	movq	%rax, %rbx
000000010000074a	cmpb	$0x0, (%rax)
000000010000074d	je	0x10000076d
000000010000074f	leaq	-0x68(%rbp), %rsi
0000000100000753	movq	%rbx, %rdi
0000000100000756	movl	$0xa, %edx
000000010000075b	callq	0x100012d4a                     ## symbol stub for: _strtoull
0000000100000760	movq	-0x68(%rbp), %rax
0000000100000764	cmpb	$0x0, (%rax)
0000000100000767	je	0x10000083a
000000010000076d	leaq	-0x58(%rbp), %rsi
0000000100000771	xorl	%edi, %edi
0000000100000773	callq	0x100012c42                     ## symbol stub for: _clock_gettime
0000000100000778	movq	(%r14), %rdi
000000010000077b	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100000780	xorl	%esi, %esi
0000000100000782	xorl	%edx, %edx
0000000100000784	callq	0x100012cf6                     ## symbol stub for: _setvbuf
0000000100000789	movl	$0x1, %esi
000000010000078e	movl	$0xd, %edi
0000000100000793	callq	0x100012d08                     ## symbol stub for: _signal
0000000100000798	leaq	-0x58(%rbp), %rbx
000000010000079c	movq	%rbx, %rdi
000000010000079f	callq	0x100012ccc                     ## symbol stub for: _pthread_attr_init
00000001000007a4	movq	_fwp_main_stack(%rip), %rsi
00000001000007ab	movq	%rbx, %rdi
00000001000007ae	callq	0x100012cd2                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007b3	leaq	_fwp_main_thread(%rip), %rdx
00000001000007ba	leaq	-0x70(%rbp), %rdi
00000001000007be	movq	%rbx, %rsi
00000001000007c1	xorl	%ecx, %ecx
00000001000007c3	callq	0x100012cd8                     ## symbol stub for: _pthread_create
00000001000007c8	testl	%eax, %eax
00000001000007ca	je	0x100000808
00000001000007cc	leaq	-0x68(%rbp), %rsi
00000001000007d0	movl	$0x3, %edi
00000001000007d5	callq	0x100012c84                     ## symbol stub for: _getrlimit
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
000000010000080e	callq	0x100012cde                     ## symbol stub for: _pthread_join
0000000100000813	movq	(%r14), %rdi
0000000100000816	callq	0x100012c4e                     ## symbol stub for: _fflush
000000010000081b	movl	_fwp_exit_code(%rip), %eax
0000000100000821	movq	0x14808(%rip), %rcx             ## literal pool symbol address: ___stack_chk_guard
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
0000000100000854	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
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
0000000100000874	movq	0x147b5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
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
00000001000008d2	callq	0x100012d02                     ## symbol stub for: _sigaltstack
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
0000000100000902	callq	0x100012cfc                     ## symbol stub for: _sigaction
0000000100000907	movl	$0xa, %edi
000000010000090c	movq	%rbx, %rsi
000000010000090f	xorl	%edx, %edx
0000000100000911	callq	0x100012cfc                     ## symbol stub for: _sigaction
0000000100000916	movdqa	_exec_scripts(%rip), %xmm0
000000010000091e	movdqa	%xmm0, _fwp_cli_scripts(%rip)
0000000100000926	movq	0x14e63(%rip), %rax
000000010000092d	movq	%rax, 0x1730c(%rip)
0000000100000934	movslq	_fwp_argc(%rip), %r15
000000010000093b	leal	-0x1(%r15), %r14d
000000010000093f	movq	_fwp_argv(%rip), %r13
0000000100000946	cmpq	$0x2, %r15
000000010000094a	jl	0x100000983
000000010000094c	movq	0x8(%r13), %rbx
0000000100000950	leaq	0x13604(%rip), %rsi             ## literal pool for: "--man"
0000000100000957	movq	%rbx, %rdi
000000010000095a	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000095f	testl	%eax, %eax
0000000100000961	je	0x100000a06
0000000100000967	leaq	0x135f3(%rip), %rsi             ## literal pool for: "--completions"
000000010000096e	movl	$0xd, %edx
0000000100000973	movq	%rbx, %rdi
0000000100000976	callq	0x100012d2c                     ## symbol stub for: _strncmp
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
0000000100000a06	movq	0x1463b(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100000a0d	movq	(%rax), %rsi
0000000100000a10	leaq	_exec_man(%rip), %rdi
0000000100000a17	callq	0x100012c66                     ## symbol stub for: _fputs
0000000100000a1c	xorl	%r15d, %r15d
0000000100000a1f	jmp	0x1000019a8
0000000100000a24	leaq	(%rdx,%rsi), %rcx
0000000100000a28	movq	%rcx, 0x8(%rax)
0000000100000a2c	movq	%rdx, -0x178(%rbp)
0000000100000a33	movq	%rdx, %rdi
0000000100000a36	callq	0x100012bee                     ## symbol stub for: ___bzero
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
0000000100000a6c	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100000a71	movq	%r14, %rdi
0000000100000a74	movq	%rax, %rsi
0000000100000a77	callq	_fwp_str_lossy
0000000100000a7c	movq	%rax, (%r15,%rbx,8)
0000000100000a80	movq	%r12, %rbx
0000000100000a83	cmpq	%r12, -0x168(%rbp)
0000000100000a8a	jne	0x100000a60
0000000100000a8c	movzbl	0x1615e(%rip), %eax
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
0000000100000af2	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100000af7	movq	-0x170(%rbp), %r15
0000000100000afe	movzbl	0x160ec(%rip), %ecx
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
0000000100000bd0	callq	0x100012bee                     ## symbol stub for: ___bzero
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
0000000100000cc0	callq	0x100012c9c                     ## symbol stub for: _memchr
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
0000000100000d36	movq	0x1430b(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100000d3d	movq	(%rbx), %rsi
0000000100000d40	leaq	0x13443(%rip), %rdi             ## literal pool for: "usage: reduce64 <Array[F64]>\n\narguments:\n  <Array[F64]>  or one per line of standard input\n\noptions:\n  -h, --help  show this help\n"
0000000100000d47	callq	0x100012c66                     ## symbol stub for: _fputs
0000000100000d4c	movq	(%rbx), %rdi
0000000100000d4f	callq	0x100012c4e                     ## symbol stub for: _fflush
0000000100000d54	xorl	%r15d, %r15d
0000000100000d57	jmp	0x1000019a8
0000000100000d5c	movl	%esi, -0x188(%rbp)
0000000100000d62	movzbl	0x15e88(%rip), %eax
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
0000000100000df1	movl	0x16d69(%rip), %ebx
0000000100000df7	testl	%ebx, %ebx
0000000100000df9	sete	%cl
0000000100000dfc	orb	%al, %cl
0000000100000dfe	jne	0x100000e36
0000000100000e00	movq	0x16d51(%rip), %rdi
0000000100000e07	testq	%rdi, %rdi
0000000100000e0a	je	0x100000e1c
0000000100000e0c	leaq	0x13214(%rip), %rsi             ## literal pool for: "Bool"
0000000100000e13	callq	0x100012d20                     ## symbol stub for: _strcmp
0000000100000e18	testl	%eax, %eax
0000000100000e1a	je	0x100000e36
0000000100000e1c	movl	%ebx, %eax
0000000100000e1e	testl	%eax, %eax
0000000100000e20	jle	0x10000108c
0000000100000e26	movq	0x16d4b(%rip), %rcx
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
0000000100000ef4	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100000ef9	cmpl	$0x1, -0x188(%rbp)
0000000100000f00	jbe	0x100000dd6
0000000100000f06	movq	0x1412b(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000f0d	movq	(%rax), %rdi
0000000100000f10	leaq	0x13118(%rip), %rsi             ## literal pool for: "%s\n"
0000000100000f17	leaq	0x13210(%rip), %rdx             ## literal pool for: "usage: reduce64 <Array[F64]>\n  (the last argument may instead be given as records on stdin)"
0000000100000f1e	xorl	%eax, %eax
0000000100000f20	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100000f25	movl	$0x2, %r15d
0000000100000f2b	jmp	0x1000019a8
0000000100000f30	cmpq	%rax, %rcx
0000000100000f33	je	0x1000012b1
0000000100000f39	leaq	0x130cd(%rip), %rdi             ## literal pool for: "cannot parse `%.*s` as %s"
0000000100000f40	leaq	0x132c6(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100000f47	movl	%r13d, %esi
0000000100000f4a	movq	%r12, %rdx
0000000100000f4d	xorl	%eax, %eax
0000000100000f4f	callq	_fwp_strf
0000000100000f54	movq	0x140dd(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100000f5b	movq	(%rcx), %rdi
0000000100000f5e	addq	$0x8, %rax
0000000100000f62	leaq	0x13122(%rip), %rsi             ## literal pool for: "%s: argument %d: %s\n"
0000000100000f69	leaq	0x123c6(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000f70	movl	$0x1, %ecx
0000000100000f75	movq	%rax, %r8
0000000100000f78	xorl	%eax, %eax
0000000100000f7a	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100000f7f	movl	$0x2, %r15d
0000000100000f85	jmp	0x1000019a8
0000000100000f8a	cmpl	$0x1, %r14d
0000000100000f8e	jne	0x100000fad
0000000100000f90	movq	0x140a1(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000f97	movq	(%rax), %rdi
0000000100000f9a	leaq	0x12fce(%rip), %rsi             ## literal pool for: "%s: option `--completions` needs a value (bash, zsh or fish)\n"
0000000100000fa1	leaq	0x1238e(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000fa8	jmp	0x100000f1e
0000000100000fad	movq	0x10(%r13), %rbx
0000000100000fb1	leaq	0x12ff5(%rip), %rsi             ## literal pool for: "bash"
0000000100000fb8	movq	%rbx, %rdi
0000000100000fbb	callq	0x100012d20                     ## symbol stub for: _strcmp
0000000100000fc0	xorl	%r15d, %r15d
0000000100000fc3	testl	%eax, %eax
0000000100000fc5	je	0x100001036
0000000100000fc7	leaq	0x12fe4(%rip), %rsi             ## literal pool for: "zsh"
0000000100000fce	movq	%rbx, %rdi
0000000100000fd1	callq	0x100012d20                     ## symbol stub for: _strcmp
0000000100000fd6	testl	%eax, %eax
0000000100000fd8	je	0x10000105e
0000000100000fde	leaq	0x12fd1(%rip), %rsi             ## literal pool for: "fish"
0000000100000fe5	movq	%rbx, %rdi
0000000100000fe8	callq	0x100012d20                     ## symbol stub for: _strcmp
0000000100000fed	testl	%eax, %eax
0000000100000fef	je	0x100001e33
0000000100000ff5	movq	%rbx, %rdi
0000000100000ff8	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100000ffd	movq	%rbx, %rdi
0000000100001000	movq	%rax, %rsi
0000000100001003	callq	_fwp_str_lossy
0000000100001008	movq	0x14029(%rip), %rcx             ## literal pool symbol address: ___stderrp
000000010000100f	movq	(%rcx), %rdi
0000000100001012	leaq	0x8(%rax), %rcx
0000000100001016	leaq	0x12f9e(%rip), %rsi             ## literal pool for: "%s: unknown shell `%s` (bash, zsh or fish)\n"
000000010000101d	leaq	0x12312(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001024	xorl	%eax, %eax
0000000100001026	callq	0x100012c5a                     ## symbol stub for: _fprintf
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
000000010000113a	cmpl	$0x0, 0x16a1f(%rip)
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
0000000100001180	movq	0x169e1(%rip), %rax
0000000100001187	movq	(%rax,%r13,8), %rbx
000000010000118b	movq	%rbx, %rdi
000000010000118e	callq	0x100012d26                     ## symbol stub for: _strlen
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
0000000100001233	callq	0x100012ca2                     ## symbol stub for: _memcmp
0000000100001238	testl	%eax, %eax
000000010000123a	cmovel	%r13d, %r12d
000000010000123e	incq	%r13
0000000100001241	movslq	0x16918(%rip), %rax
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
0000000100001291	callq	0x100012c72                     ## symbol stub for: _free
0000000100001296	movq	%rbx, %rdi
0000000100001299	callq	0x100012c72                     ## symbol stub for: _free
000000010000129e	movl	-0x168(%rbp), %eax
00000001000012a4	testl	%eax, %eax
00000001000012a6	js	0x100001d1b
00000001000012ac	movl	%eax, %eax
00000001000012ae	movq	%rax, (%r15)
00000001000012b1	leaq	0x12bb0(%rip), %rdi             ## literal pool for: "FWP_OUT"
00000001000012b8	callq	0x100012c7e                     ## symbol stub for: _getenv
00000001000012bd	testq	%rax, %rax
00000001000012c0	je	0x100001327
00000001000012c2	leaq	0x12ba7(%rip), %rsi             ## literal pool for: "bin"
00000001000012c9	movq	%rax, %rdi
00000001000012cc	callq	0x100012d20                     ## symbol stub for: _strcmp
00000001000012d1	xorl	%esi, %esi
00000001000012d3	movq	0x13d6e(%rip), %rbx             ## literal pool symbol address: ___stdoutp
00000001000012da	movq	(%rbx), %rcx
00000001000012dd	movq	%rcx, %rdx
00000001000012e0	testl	%eax, %eax
00000001000012e2	sete	%sil
00000001000012e6	movl	%esi, _fwp_exec_binary_out(%rip)
00000001000012ec	jne	0x1000012f8
00000001000012ee	movq	0x13d43(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000012f5	movq	(%rax), %rdx
00000001000012f8	movq	%rdx, _fwp_prog_out(%rip)
00000001000012ff	movl	-0x188(%rbp), %eax
0000000100001305	jne	0x100001348
0000000100001307	leaq	_exec_out_header0(%rip), %rdi
000000010000130e	movl	$0x1, %esi
0000000100001313	movl	$0x30, %edx
0000000100001318	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000131d	movq	(%rbx), %rdi
0000000100001320	callq	0x100012c4e                     ## symbol stub for: _fflush
0000000100001325	jmp	0x100001342
0000000100001327	movl	$0x0, _fwp_exec_binary_out(%rip)
0000000100001331	movq	0x13d10(%rip), %rax             ## literal pool symbol address: ___stdoutp
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
000000010000136f	callq	0x100012c4e                     ## symbol stub for: _fflush
0000000100001374	movl	$0x1, %r15d
000000010000137a	cmpl	$0x0, -0x17c(%rbp)
0000000100001381	jne	0x100001968
0000000100001387	movq	%rbx, %rdi
000000010000138a	callq	_fwp_emit_result
000000010000138f	xorl	%r15d, %r15d
0000000100001392	jmp	0x100001968
0000000100001397	movq	0x13ca2(%rip), %r13             ## literal pool symbol address: ___stdinp
000000010000139e	movq	(%r13), %rdi
00000001000013a2	movl	$0x100000, %ecx                 ## imm = 0x100000
00000001000013a7	xorl	%esi, %esi
00000001000013a9	xorl	%edx, %edx
00000001000013ab	callq	0x100012cf6                     ## symbol stub for: _setvbuf
00000001000013b0	movq	(%r13), %rcx
00000001000013b4	leaq	_fwp_in_pend(%rip), %r12
00000001000013bb	movl	$0x1, %esi
00000001000013c0	movl	$0x4, %edx
00000001000013c5	movq	%r12, %rdi
00000001000013c8	callq	0x100012c6c                     ## symbol stub for: _fread
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
0000000100001464	callq	0x100012c6c                     ## symbol stub for: _fread
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
00000001000014af	callq	0x100012ca8                     ## symbol stub for: _memcpy
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
00000001000014eb	callq	0x100012c6c                     ## symbol stub for: _fread
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
00000001000015b5	callq	0x100012bee                     ## symbol stub for: ___bzero
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
00000001000016b5	callq	0x100012c6c                     ## symbol stub for: _fread
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
00000001000017b4	callq	0x100012c54                     ## symbol stub for: _fgetc
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
00000001000017e4	callq	0x100012c54                     ## symbol stub for: _fgetc
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
000000010000181d	leaq	0x11b0e(%rip), %rax             ## literal pool for: ""
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
00000001000018f4	callq	0x100012c4e                     ## symbol stub for: _fflush
00000001000018f9	cmpl	$0x0, -0x17c(%rbp)
0000000100001900	jne	0x100001ee1
0000000100001906	movq	%rbx, %rdi
0000000100001909	callq	_fwp_emit_result
000000010000190e	movq	0x13733(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001915	movq	(%rax), %rdi
0000000100001918	callq	0x100012c4e                     ## symbol stub for: _fflush
000000010000191d	leaq	-0x150(%rbp), %rbx
0000000100001924	leaq	-0x50(%rbp), %r14
0000000100001928	cmpb	$0x0, -0x168(%rbp)
000000010000192f	je	0x10000142a
0000000100001935	jmp	0x100001729
000000010000193a	leaq	0x1258f(%rip), %rsi             ## literal pool for: "%s: truncated frame\n"
0000000100001941	movq	0x136f0(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001948	movq	(%rax), %rdi
000000010000194b	leaq	0x119e4(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001952	xorl	%eax, %eax
0000000100001954	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100001959	movl	$0x3, %r15d
000000010000195f	movq	-0x50(%rbp), %rdi
0000000100001963	callq	0x100012c72                     ## symbol stub for: _free
0000000100001968	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000196f	je	0x100001999
0000000100001971	movq	0x136d0(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100001978	movq	(%rbx), %rcx
000000010000197b	leaq	_fwp_exec.end(%rip), %rdi
0000000100001982	movl	$0x1, %esi
0000000100001987	movl	$0x5, %edx
000000010000198c	callq	0x100012c78                     ## symbol stub for: _fwrite
0000000100001991	movq	(%rbx), %rdi
0000000100001994	callq	0x100012c4e                     ## symbol stub for: _fflush
0000000100001999	movq	0x136a8(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000019a0	movq	(%rax), %rdi
00000001000019a3	callq	0x100012c4e                     ## symbol stub for: _fflush
00000001000019a8	movl	%r15d, _fwp_exit_code(%rip)
00000001000019af	movq	0x13692(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000019b6	movq	(%rax), %rdi
00000001000019b9	callq	0x100012c4e                     ## symbol stub for: _fflush
00000001000019be	movq	0x1366b(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
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
0000000100001a05	callq	0x100012c6c                     ## symbol stub for: _fread
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
0000000100001a99	callq	0x100012c6c                     ## symbol stub for: _fread
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
0000000100001b52	callq	0x100012ca8                     ## symbol stub for: _memcpy
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
0000000100001bc2	callq	0x100012ca8                     ## symbol stub for: _memcpy
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
0000000100001bf6	callq	0x100012c6c                     ## symbol stub for: _fread
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
0000000100001c2c	callq	0x100012c6c                     ## symbol stub for: _fread
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
0000000100001cda	pxor	0x1108e(%rip), %xmm0
0000000100001ce2	ptest	%xmm0, %xmm0
0000000100001ce7	je	0x100001f81
0000000100001ced	movq	0x13344(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001cf4	movq	(%rax), %rdi
0000000100001cf7	leaq	0x121a0(%rip), %rsi             ## literal pool for: "%s: input type mismatch: expected `%s`, got `%s`\n"
0000000100001cfe	leaq	0x11631(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001d05	leaq	0x12501(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100001d0c	movq	%rbx, %r8
0000000100001d0f	xorl	%eax, %eax
0000000100001d11	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100001d16	jmp	0x100001f42
0000000100001d1b	pxor	%xmm0, %xmm0
0000000100001d1f	movdqa	%xmm0, -0x150(%rbp)
0000000100001d27	movq	$0x0, -0x140(%rbp)
0000000100001d32	cmpl	$0x0, 0x15e27(%rip)
0000000100001d39	jle	0x100001e75
0000000100001d3f	movq	%r13, -0x1b8(%rbp)
0000000100001d46	movq	%r12, -0x190(%rbp)
0000000100001d4d	xorl	%r14d, %r14d
0000000100001d50	leaq	-0x150(%rbp), %rbx
0000000100001d57	leaq	-0x160(%rbp), %r12
0000000100001d5e	jmp	0x100001d73
0000000100001d60	incq	%r14
0000000100001d63	movslq	0x15df6(%rip), %rax
0000000100001d6a	cmpq	%rax, %r14
0000000100001d6d	jge	0x100001e57
0000000100001d73	testq	%r14, %r14
0000000100001d76	je	0x100001d8c
0000000100001d78	movl	$0x2, %edx
0000000100001d7d	movq	%rbx, %rdi
0000000100001d80	leaq	0x122a5(%rip), %rsi             ## literal pool for: ", "
0000000100001d87	callq	_buf_put
0000000100001d8c	movq	0x15dd5(%rip), %rax
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
0000000100001e43	movq	0x131fe(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001e4a	movq	(%rax), %rsi
0000000100001e4d	callq	0x100012c66                     ## symbol stub for: _fputs
0000000100001e52	jmp	0x1000019a8
0000000100001e57	movq	-0x150(%rbp), %rbx
0000000100001e5e	movq	-0x148(%rbp), %rsi
0000000100001e65	movq	-0x190(%rbp), %r12
0000000100001e6c	movq	-0x1b8(%rbp), %r13
0000000100001e73	jmp	0x100001e79
0000000100001e75	xorl	%esi, %esi
0000000100001e77	xorl	%ebx, %ebx
0000000100001e79	testq	%rbx, %rbx
0000000100001e7c	leaq	0x114af(%rip), %rdi             ## literal pool for: ""
0000000100001e83	cmovneq	%rbx, %rdi
0000000100001e87	callq	_fwp_str_new
0000000100001e8c	movq	%rax, %r14
0000000100001e8f	movq	%rbx, %rdi
0000000100001e92	callq	0x100012c72                     ## symbol stub for: _free
0000000100001e97	addq	$0x8, %r14
0000000100001e9b	leaq	0x12153(%rip), %rdi             ## literal pool for: "`%.*s` is not one of %s"
0000000100001ea2	movl	%r13d, %esi
0000000100001ea5	movq	%r12, %rdx
0000000100001ea8	movq	%r14, %rcx
0000000100001eab	jmp	0x100000f4d
0000000100001eb0	movq	0x13181(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001eb7	movq	(%rax), %rdi
0000000100001eba	movl	(%r15), %ecx
0000000100001ebd	leaq	0x1204c(%rip), %rsi             ## literal pool for: "%s: cannot parse input `%.*s` as %s\n"
0000000100001ec4	leaq	0x1146b(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001ecb	leaq	0x1233b(%rip), %r9              ## literal pool for: "Array[F64]"
0000000100001ed2	movq	%r14, %r8
0000000100001ed5	xorl	%eax, %eax
0000000100001ed7	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100001edc	jmp	0x100001959
0000000100001ee1	movl	$0x1, %r15d
0000000100001ee7	jmp	0x10000195f
0000000100001eec	xorl	%r15d, %r15d
0000000100001eef	jmp	0x10000195f
0000000100001ef4	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100001ef9	jmp	0x100001f1f
0000000100001efb	leaq	0x11fe3(%rip), %rsi             ## literal pool for: "%s: bad switch frame\n"
0000000100001f02	jmp	0x100001941
0000000100001f07	movq	0x1312a(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f0e	movq	(%rax), %rdi
0000000100001f11	leaq	0x11fe3(%rip), %rsi             ## literal pool for: "%s: malformed value\n"
0000000100001f18	jmp	0x10000194b
0000000100001f1d	xorl	%eax, %eax
0000000100001f1f	testl	%eax, %eax
0000000100001f21	js	0x100001f4d
0000000100001f23	movq	0x1310e(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f2a	movq	(%rax), %rdi
0000000100001f2d	leaq	0x12011(%rip), %rsi             ## literal pool for: "%s: truncated header\n"
0000000100001f34	leaq	0x113fb(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001f3b	xorl	%eax, %eax
0000000100001f3d	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100001f42	movl	$0x3, %r15d
0000000100001f48	jmp	0x1000019a8
0000000100001f4d	movq	0x130e4(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f54	movq	(%rax), %rdi
0000000100001f57	leaq	0x11fd7(%rip), %rsi             ## literal pool for: "%s: bad header\n"
0000000100001f5e	jmp	0x100001f34
0000000100001f60	movq	0x130d1(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001f67	movq	(%rax), %rdi
0000000100001f6a	leaq	0x11f08(%rip), %rsi             ## literal pool for: "%s: unsupported protocol version %d\n"
0000000100001f71	leaq	0x113be(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001f78	xorl	%eax, %eax
0000000100001f7a	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100001f7f	jmp	0x100001f42
0000000100001f81	movl	$0x0, -0x168(%rbp)
0000000100001f8b	jmp	0x1000013fa
0000000100001f90	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100001f95	nopw	%cs:(%rax,%rax)
_main:
0000000100001fa0	pushq	%rbp
0000000100001fa1	movq	%rsp, %rbp
0000000100001fa4	pushq	%r15
0000000100001fa6	pushq	%r14
0000000100001fa8	pushq	%r13
0000000100001faa	pushq	%r12
0000000100001fac	pushq	%rbx
0000000100001fad	subq	$0x108, %rsp                    ## imm = 0x108
0000000100001fb4	movq	%rbp, %rdi
0000000100001fb7	callq	_fwp_gc_start
0000000100001fbc	leaq	_fwp_fn_table(%rip), %rax
0000000100001fc3	movq	%rax, _fwp_fns(%rip)
0000000100001fca	pxor	%xmm0, %xmm0
0000000100001fce	movdqa	%xmm0, -0xe0(%rbp)
0000000100001fd6	movdqa	%xmm0, -0x90(%rbp)
0000000100001fde	movdqa	%xmm0, -0xa0(%rbp)
0000000100001fe6	movdqa	%xmm0, -0xb0(%rbp)
0000000100001fee	movdqa	%xmm0, -0xc0(%rbp)
0000000100001ff6	movdqa	%xmm0, -0xd0(%rbp)
0000000100001ffe	movl	$0xb, -0xe0(%rbp)
0000000100002008	leaq	0x111a1(%rip), %rdi             ## literal pool for: "{\"samples\":["
000000010000200f	callq	0x100012ce4                     ## symbol stub for: _puts
0000000100002014	xorl	%ebx, %ebx
0000000100002016	leaq	-0xe0(%rbp), %r14
000000010000201d	nopl	(%rax)
0000000100002020	movq	%rbx, -0x50(%rbp)
0000000100002024	movq	$0x0, _bench_kernel_ns(%rip)
000000010000202f	movq	0x151e2(%rip), %rax
0000000100002036	subq	_fwp_gc(%rip), %rax
000000010000203d	movq	%rax, _bench_initial_charge(%rip)
0000000100002044	movq	0x15195(%rip), %rax
000000010000204b	movq	%rax, -0x48(%rbp)
000000010000204f	movl	$0x6, %edi
0000000100002054	leaq	-0x40(%rbp), %rsi
0000000100002058	callq	0x100012c42                     ## symbol stub for: _clock_gettime
000000010000205d	movaps	-0x40(%rbp), %xmm0
0000000100002061	movaps	%xmm0, -0x70(%rbp)
0000000100002065	movl	$0xfffffff7, %r13d              ## imm = 0xFFFFFFF7
000000010000206b	movabsq	$0x14650fb0739d0383, %r15       ## imm = 0x14650FB0739D0383
0000000100002075	movq	$0x0, -0x30(%rbp)
000000010000207d	movq	%r14, %rsi
0000000100002080	movq	%r15, -0x58(%rbp)
0000000100002084	movl	$0x10001, %edi                  ## imm = 0x10001
0000000100002089	callq	_fwp_array_new_packed
000000010000208e	movq	%rax, %r12
0000000100002091	subq	0x14fa0(%rip), %rax
0000000100002098	movq	0x14fc1(%rip), %rcx
000000010000209f	shlq	$0x10, %rcx
00000001000020a3	cmpq	%rcx, %rax
00000001000020a6	jae	0x100002120
00000001000020a8	movq	0x14fd1(%rip), %rcx
00000001000020af	movq	%rax, %rdx
00000001000020b2	shrq	$0x10, %rdx
00000001000020b6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000020bd	leaq	(%rcx,%rdx), %rbx
00000001000020c1	movzbl	(%rcx,%rdx), %ecx
00000001000020c5	cmpb	$0x2, %cl
00000001000020c8	setne	%dl
00000001000020cb	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000020d1	setne	%sil
00000001000020d5	orb	%dl, %sil
00000001000020d8	jne	0x1000020f0
00000001000020da	addq	$0x228, %rbx                    ## imm = 0x228
00000001000020e1	cmpb	$-0x1, (%rbx)
00000001000020e4	je	0x10000210f
00000001000020e6	movb	$0x1, (%rbx)
00000001000020e9	jmp	0x100002120
00000001000020eb	nopl	(%rax,%rax)
00000001000020f0	cmpb	$0x1, %cl
00000001000020f3	jne	0x100002120
00000001000020f5	movl	0x20(%rbx), %ecx
00000001000020f8	imulq	%rcx, %rax
00000001000020fc	shrq	$0x20, %rax
0000000100002100	addq	%rax, %rbx
0000000100002103	addq	$0x228, %rbx                    ## imm = 0x228
000000010000210a	cmpb	$-0x1, (%rbx)
000000010000210d	jne	0x1000020e6
000000010000210f	movq	%rbx, %rdi
0000000100002112	callq	_fwp_rc_forget_slot
0000000100002117	jmp	0x1000020e6
0000000100002119	nopl	(%rax)
0000000100002120	movabsq	$-0x286bca1af286bca1, %r14      ## imm = 0xD79435E50D79435F
000000010000212a	movq	-0x30(%rbp), %r15
000000010000212e	xorl	%ebx, %ebx
0000000100002130	movq	%r15, %rax
0000000100002133	mulq	%r14
0000000100002136	shrq	$0x4, %rdx
000000010000213a	leal	(%rdx,%rdx,8), %eax
000000010000213d	leal	(%rdx,%rax,2), %eax
0000000100002140	movl	%r13d, %ecx
0000000100002143	subl	%eax, %ecx
0000000100002145	addl	%ebx, %ecx
0000000100002147	xorps	%xmm0, %xmm0
000000010000214a	cvtsi2sd	%ecx, %xmm0
000000010000214e	mulsd	0x10d7a(%rip), %xmm0
0000000100002156	movq	%xmm0, %rdx
000000010000215b	movq	%r12, %rdi
000000010000215e	movq	%rbx, %rsi
0000000100002161	leaq	-0xe0(%rbp), %rcx
0000000100002168	callq	_fwp_array_store
000000010000216d	incq	%rbx
0000000100002170	incq	%r15
0000000100002173	cmpq	$0x10001, %rbx                  ## imm = 0x10001
000000010000217a	jne	0x100002130
000000010000217c	movl	$0x6, %edi
0000000100002181	leaq	-0x40(%rbp), %r15
0000000100002185	movq	%r15, %rsi
0000000100002188	callq	0x100012c42                     ## symbol stub for: _clock_gettime
000000010000218d	movaps	-0x40(%rbp), %xmm0
0000000100002191	movaps	%xmm0, -0x80(%rbp)
0000000100002195	movq	%r12, %rdi
0000000100002198	callq	_f0
000000010000219d	movq	%rax, %rbx
00000001000021a0	movl	$0x6, %edi
00000001000021a5	movq	%r15, %rsi
00000001000021a8	callq	0x100012c42                     ## symbol stub for: _clock_gettime
00000001000021ad	movdqa	-0x40(%rbp), %xmm0
00000001000021b2	psubq	-0x80(%rbp), %xmm0
00000001000021b7	movq	%xmm0, %rax
00000001000021bc	imulq	$0x3b9aca00, %rax, %rax         ## imm = 0x3B9ACA00
00000001000021c3	pextrq	$0x1, %xmm0, %rcx
00000001000021ca	addq	%rax, %rcx
00000001000021cd	addq	%rcx, _bench_kernel_ns(%rip)
00000001000021d4	movq	-0x58(%rbp), %r15
00000001000021d8	xorq	%rbx, %r15
00000001000021db	movabsq	$0x100000001b3, %rax            ## imm = 0x100000001B3
00000001000021e5	imulq	%rax, %r15
00000001000021e9	movq	-0x30(%rbp), %rcx
00000001000021ed	incq	%rcx
00000001000021f0	incl	%r13d
00000001000021f3	movq	%rcx, -0x30(%rbp)
00000001000021f7	cmpq	$0x8, %rcx
00000001000021fb	leaq	-0xe0(%rbp), %rsi
0000000100002202	jne	0x100002080
0000000100002208	movq	%rsi, %r14
000000010000220b	movl	$0x6, %edi
0000000100002210	leaq	-0x40(%rbp), %rsi
0000000100002214	callq	0x100012c42                     ## symbol stub for: _clock_gettime
0000000100002219	movq	0x14ff8(%rip), %rcx
0000000100002220	movq	_bench_initial_charge(%rip), %rax
0000000100002227	addq	_fwp_gc(%rip), %rax
000000010000222e	movq	0x14fab(%rip), %rdx
0000000100002235	subq	-0x48(%rbp), %rdx
0000000100002239	movq	-0x50(%rbp), %rbx
000000010000223d	jne	0x1000022fa
0000000100002243	cmpq	%rax, %rcx
0000000100002246	jne	0x1000022fa
000000010000224c	movdqa	-0x40(%rbp), %xmm0
0000000100002251	psubq	-0x70(%rbp), %xmm0
0000000100002256	movq	%xmm0, %rax
000000010000225b	pextrq	$0x1, %xmm0, %rdx
0000000100002262	imulq	$0x3b9aca00, %rax, %rax         ## imm = 0x3B9ACA00
0000000100002269	addq	%rax, %rdx
000000010000226c	testq	%rbx, %rbx
000000010000226f	leaq	0x110b9(%rip), %rsi             ## literal pool for: ",\n"
0000000100002276	leaq	0x110b5(%rip), %rax             ## literal pool for: ""
000000010000227d	cmoveq	%rax, %rsi
0000000100002281	movq	_bench_kernel_ns(%rip), %rcx
0000000100002288	movq	0x14f68(%rip), %xmm0
0000000100002290	movq	0x14db9(%rip), %rax
0000000100002297	movq	0x14dea(%rip), %rdi
000000010000229e	addq	0x14da3(%rip), %rdi
00000001000022a5	movq	%rdi, 0x40(%rsp)
00000001000022aa	movq	%rax, 0x38(%rsp)
00000001000022af	xorps	%xmm1, %xmm1
00000001000022b2	movups	%xmm1, 0x20(%rsp)
00000001000022b7	movups	%xmm1, 0x10(%rsp)
00000001000022bc	movups	%xmm1, (%rsp)
00000001000022c0	movq	$0x0, 0x30(%rsp)
00000001000022c9	leaq	0x10f29(%rip), %rdi             ## literal pool for: "%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%ld,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"collections\":%zu,\"collectionPauseSeconds\":%.9f,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}"
00000001000022d0	movq	%r15, %r8
00000001000022d3	xorl	%r9d, %r9d
00000001000022d6	movb	$0x1, %al
00000001000022d8	callq	0x100012cc6                     ## symbol stub for: _printf
00000001000022dd	incq	%rbx
00000001000022e0	cmpq	$0x5, %rbx
00000001000022e4	jne	0x100002020
00000001000022ea	leaq	0x11042(%rip), %rdi             ## literal pool for: "]}"
00000001000022f1	callq	0x100012ce4                     ## symbol stub for: _puts
00000001000022f6	xorl	%eax, %eax
00000001000022f8	jmp	0x10000231a
00000001000022fa	subq	%rax, %rcx
00000001000022fd	movq	0x12d34(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002304	movq	(%rax), %rdi
0000000100002307	leaq	0x10eaf(%rip), %rsi             ## literal pool for: "unexpected collection or retained charged storage: %zu %ld\n"
000000010000230e	xorl	%eax, %eax
0000000100002310	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100002315	movl	$0xe0, %eax
000000010000231a	addq	$0x108, %rsp                    ## imm = 0x108
0000000100002321	popq	%rbx
0000000100002322	popq	%r12
0000000100002324	popq	%r13
0000000100002326	popq	%r14
0000000100002328	popq	%r15
000000010000232a	popq	%rbp
000000010000232b	retq
000000010000232c	nopl	(%rax)
_fwp_gc_start:
0000000100002330	pushq	%rbp
0000000100002331	movq	%rsp, %rbp
0000000100002334	pushq	%r15
0000000100002336	pushq	%r14
0000000100002338	pushq	%r12
000000010000233a	pushq	%rbx
000000010000233b	cmpl	$0x0, 0x14cb2(%rip)
0000000100002342	jne	0x10000234f
0000000100002344	movq	%rdi, %rbx
0000000100002347	callq	_fwp_gc_init
000000010000234c	movq	%rbx, %rdi
000000010000234f	movq	%rdi, 0x14d3a(%rip)
0000000100002356	callq	0x100012c1e                     ## symbol stub for: __dyld_image_count
000000010000235b	testl	%eax, %eax
000000010000235d	je	0x100002464
0000000100002363	xorl	%ebx, %ebx
0000000100002365	leaq	_fwp_gc(%rip), %r14
000000010000236c	movl	$0x1, %r15d
0000000100002372	jmp	0x10000238f
0000000100002374	testl	%esi, %esi
0000000100002376	jne	0x1000023fd
000000010000237c	nopl	(%rax)
0000000100002380	incl	%ebx
0000000100002382	callq	0x100012c1e                     ## symbol stub for: __dyld_image_count
0000000100002387	cmpl	%eax, %ebx
0000000100002389	jae	0x100002464
000000010000238f	movl	%ebx, %edi
0000000100002391	callq	0x100012c12                     ## symbol stub for: __dyld_get_image_header
0000000100002396	testq	%rax, %rax
0000000100002399	je	0x100002380
000000010000239b	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
00000001000023a1	jne	0x100002380
00000001000023a3	movl	%ebx, %edi
00000001000023a5	movq	%rax, %r12
00000001000023a8	callq	0x100012c18                     ## symbol stub for: __dyld_get_image_vmaddr_slide
00000001000023ad	movl	0x10(%r12), %edx
00000001000023b2	testl	%edx, %edx
00000001000023b4	je	0x100002380
00000001000023b6	movq	%r12, %rcx
00000001000023b9	addq	$0x20, %rcx
00000001000023bd	xorl	%esi, %esi
00000001000023bf	movl	%edx, %edi
00000001000023c1	movq	%rcx, %r8
00000001000023c4	jmp	0x1000023db
00000001000023c6	nopw	%cs:(%rax,%rax)
00000001000023d0	movl	0x4(%r8), %r9d
00000001000023d4	addq	%r9, %r8
00000001000023d7	decl	%edi
00000001000023d9	je	0x100002374
00000001000023db	cmpl	$0x19, (%r8)
00000001000023df	jne	0x1000023d0
00000001000023e1	movq	0x18(%r8), %r9
00000001000023e5	addq	%rax, %r9
00000001000023e8	cmpq	%r14, %r9
00000001000023eb	ja	0x1000023d0
00000001000023ed	movq	%r14, %r10
00000001000023f0	subq	%r9, %r10
00000001000023f3	cmpq	0x20(%r8), %r10
00000001000023f7	cmovbl	%r15d, %esi
00000001000023fb	jmp	0x1000023d0
00000001000023fd	movl	0x14d95(%rip), %esi
0000000100002403	jmp	0x10000241a
0000000100002405	nopw	%cs:(%rax,%rax)
0000000100002410	movl	0x4(%rcx), %edi
0000000100002413	addq	%rdi, %rcx
0000000100002416	decl	%edx
0000000100002418	je	0x100002464
000000010000241a	cmpl	$0x19, (%rcx)
000000010000241d	jne	0x100002410
000000010000241f	movl	0x3c(%rcx), %edi
0000000100002422	notl	%edi
0000000100002424	testb	$0x3, %dil
0000000100002428	jne	0x100002410
000000010000242a	movq	0x20(%rcx), %rdi
000000010000242e	testq	%rdi, %rdi
0000000100002431	je	0x100002410
0000000100002433	cmpl	$0x10, %esi
0000000100002436	je	0x1000024f2
000000010000243c	movq	0x18(%rcx), %r8
0000000100002440	addq	%rax, %r8
0000000100002443	movslq	%esi, %r9
0000000100002446	shlq	$0x4, %r9
000000010000244a	movq	%r8, 0x1090(%r9,%r14)
0000000100002452	incl	%esi
0000000100002454	movl	%esi, 0x14d3e(%rip)
000000010000245a	movq	%rdi, 0x1098(%r9,%r14)
0000000100002462	jmp	0x100002410
0000000100002464	cmpl	$0x0, 0x14b8d(%rip)
000000010000246b	setne	%cl
000000010000246e	cmpl	$0x0, 0x14d23(%rip)
0000000100002475	setg	%al
0000000100002478	andb	%cl, %al
000000010000247a	movzbl	%al, %ecx
000000010000247d	movl	%ecx, 0x14b79(%rip)
0000000100002483	cmpl	$0x0, 0x14b7a(%rip)
000000010000248a	je	0x1000024a2
000000010000248c	leaq	_fwp_gc_report(%rip), %rdi
0000000100002493	callq	0x100012c30                     ## symbol stub for: _atexit
0000000100002498	cmpl	$0x0, 0x14b5d(%rip)
000000010000249f	setne	%al
00000001000024a2	testb	%al, %al
00000001000024a4	je	0x1000024e9
00000001000024a6	cmpq	$0x0, 0x14b7a(%rip)
00000001000024ae	je	0x1000024e9
00000001000024b0	movq	0x14d61(%rip), %rax
00000001000024b7	subq	_fwp_gc(%rip), %rax
00000001000024be	cvtsi2sd	%rax, %xmm0
00000001000024c3	addsd	0x14d25(%rip), %xmm0
00000001000024cb	movsd	%xmm0, 0x14d1d(%rip)
00000001000024d3	movq	$0x0, 0x14d3a(%rip)
00000001000024de	movq	$0x0, _fwp_gc(%rip)
00000001000024e9	popq	%rbx
00000001000024ea	popq	%r12
00000001000024ec	popq	%r14
00000001000024ee	popq	%r15
00000001000024f0	popq	%rbp
00000001000024f1	retq
00000001000024f2	callq	_fwp_flush
00000001000024f7	movq	0x12b3a(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000024fe	movq	(%rax), %rdi
0000000100002501	leaq	0x10f07(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100002508	leaq	0x11d09(%rip), %rdx             ## literal pool for: "too many program data segments for the collector"
000000010000250f	xorl	%eax, %eax
0000000100002511	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100002516	movl	$0x65, %edi
000000010000251b	callq	0x100012c48                     ## symbol stub for: _exit
_fwp_array_new_packed:
0000000100002520	pushq	%rbp
0000000100002521	movq	%rsp, %rbp
0000000100002524	pushq	%r14
0000000100002526	pushq	%rbx
0000000100002527	movabsq	$0x1fffffffffffffff, %rax       ## imm = 0x1FFFFFFFFFFFFFFF
0000000100002531	cmpq	%rax, %rdi
0000000100002534	jae	0x1000026a1
000000010000253a	movq	%rdi, %rbx
000000010000253d	testq	%rsi, %rsi
0000000100002540	je	0x1000025e1
0000000100002546	movl	(%rsi), %eax
0000000100002548	cmpq	$0xa, %rax
000000010000254c	ja	0x100002569
000000010000254e	movl	$0x4e7, %ecx                    ## imm = 0x4E7
0000000100002553	btl	%eax, %ecx
0000000100002556	jae	0x100002569
0000000100002558	leaq	0x10ba1(%rip), %rcx
000000010000255f	movq	(%rcx,%rax,8), %rcx
0000000100002563	imulq	%rbx, %rcx
0000000100002567	jmp	0x100002571
0000000100002569	leaq	(,%rbx,8), %rcx
0000000100002571	leaq	0x8(%rcx), %rsi
0000000100002575	cmpl	$0xb, %eax
0000000100002578	ja	0x1000025e9
000000010000257a	movl	$0xdef, %edx                    ## imm = 0xDEF
000000010000257f	btl	%eax, %edx
0000000100002582	jae	0x1000025e9
0000000100002584	cmpq	$0x3ff8, %rcx                   ## imm = 0x3FF8
000000010000258b	ja	0x10000264b
0000000100002591	addq	$0x17, %rcx
0000000100002595	shrq	$0x4, %rcx
0000000100002599	leaq	_fwp_gc(%rip), %rdx
00000001000025a0	movzbl	0xbe8(%rcx,%rdx), %ecx
00000001000025a8	movl	0xb48(%rdx,%rcx,4), %eax
00000001000025af	subq	%rax, _fwp_gc(%rip)
00000001000025b6	js	0x10000264b
00000001000025bc	leaq	(%rcx,%rcx,2), %rcx
00000001000025c0	leaq	(%rdx,%rcx,8), %rcx
00000001000025c4	addq	$0x3c8, %rcx                    ## imm = 0x3C8
00000001000025cb	movq	(%rcx), %r14
00000001000025ce	testq	%r14, %r14
00000001000025d1	je	0x10000263b
00000001000025d3	movq	(%r14), %rax
00000001000025d6	notq	%rax
00000001000025d9	movq	%rax, (%rcx)
00000001000025dc	jmp	0x10000267e
00000001000025e1	leaq	0x8(,%rbx,8), %rsi
00000001000025e9	cmpq	$0x4000, %rsi                   ## imm = 0x4000
00000001000025f0	ja	0x100002665
00000001000025f2	leaq	0xf(%rsi), %rax
00000001000025f6	shrq	$0x4, %rax
00000001000025fa	leaq	_fwp_gc(%rip), %rcx
0000000100002601	movzbl	0xbe8(%rax,%rcx), %edx
0000000100002609	movl	0xb48(%rcx,%rdx,4), %eax
0000000100002610	subq	%rax, _fwp_gc(%rip)
0000000100002617	js	0x100002665
0000000100002619	leaq	(%rdx,%rdx,2), %rdx
000000010000261d	leaq	(%rcx,%rdx,8), %rcx
0000000100002621	addq	$0x788, %rcx                    ## imm = 0x788
0000000100002628	movq	(%rcx), %r14
000000010000262b	testq	%r14, %r14
000000010000262e	je	0x100002655
0000000100002630	movq	(%r14), %rdx
0000000100002633	notq	%rdx
0000000100002636	movq	%rdx, (%rcx)
0000000100002639	jmp	0x10000268b
000000010000263b	movq	0x8(%rcx), %r14
000000010000263f	movq	0x10(%rcx), %rdx
0000000100002643	subq	%r14, %rdx
0000000100002646	cmpq	%rax, %rdx
0000000100002649	jae	0x100002677
000000010000264b	movq	%rsi, %rdi
000000010000264e	movl	$0x1, %esi
0000000100002653	jmp	0x10000266d
0000000100002655	movq	0x8(%rcx), %r14
0000000100002659	movq	0x10(%rcx), %rdx
000000010000265d	subq	%r14, %rdx
0000000100002660	cmpq	%rax, %rdx
0000000100002663	jae	0x100002683
0000000100002665	movq	%rsi, %rdi
0000000100002668	movl	$0x2, %esi
000000010000266d	callq	_fwp_gc_alloc_slow
0000000100002672	movq	%rax, %r14
0000000100002675	jmp	0x100002696
0000000100002677	addq	%r14, %rax
000000010000267a	movq	%rax, 0x8(%rcx)
000000010000267e	movq	%r14, %rdi
0000000100002681	jmp	0x100002691
0000000100002683	leaq	(%r14,%rax), %rdx
0000000100002687	movq	%rdx, 0x8(%rcx)
000000010000268b	movq	%r14, %rdi
000000010000268e	movq	%rax, %rsi
0000000100002691	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100002696	movq	%rbx, (%r14)
0000000100002699	movq	%r14, %rax
000000010000269c	popq	%rbx
000000010000269d	popq	%r14
000000010000269f	popq	%rbp
00000001000026a0	retq
00000001000026a1	callq	_fwp_flush
00000001000026a6	movq	0x1298b(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000026ad	movq	(%rax), %rdi
00000001000026b0	leaq	0x10d58(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
00000001000026b7	leaq	0x11c4c(%rip), %rdx             ## literal pool for: "array too large"
00000001000026be	xorl	%eax, %eax
00000001000026c0	callq	0x100012c5a                     ## symbol stub for: _fprintf
00000001000026c5	movl	$0x65, %edi
00000001000026ca	callq	0x100012c48                     ## symbol stub for: _exit
00000001000026cf	nop
_fwp_array_store:
00000001000026d0	cmpq	$0x0, (%rdi)
00000001000026d4	js	0x100002716
00000001000026d6	testq	%rcx, %rcx
00000001000026d9	je	0x100002706
00000001000026db	movl	(%rcx), %eax
00000001000026dd	cmpl	$0xa, %eax
00000001000026e0	ja	0x100002706
00000001000026e2	movl	$0x484, %ecx                    ## imm = 0x484
00000001000026e7	btl	%eax, %ecx
00000001000026ea	jb	0x10000270c
00000001000026ec	movl	$0x21, %ecx
00000001000026f1	btl	%eax, %ecx
00000001000026f4	jb	0x100002711
00000001000026f6	movl	$0x42, %ecx
00000001000026fb	btl	%eax, %ecx
00000001000026fe	jae	0x100002706
0000000100002700	movw	%dx, 0x8(%rdi,%rsi,2)
0000000100002705	retq
0000000100002706	movq	%rdx, 0x8(%rdi,%rsi,8)
000000010000270b	retq
000000010000270c	movl	%edx, 0x8(%rdi,%rsi,4)
0000000100002710	retq
0000000100002711	movb	%dl, 0x8(%rdi,%rsi)
0000000100002715	retq
0000000100002716	pushq	%rbp
0000000100002717	movq	%rsp, %rbp
000000010000271a	callq	_fwp_flush
000000010000271f	movq	0x12912(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002726	movq	(%rax), %rdi
0000000100002729	leaq	0x10cdf(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100002730	leaq	0x11be3(%rip), %rdx             ## literal pool for: "internal: mutating an array view"
0000000100002737	xorl	%eax, %eax
0000000100002739	callq	0x100012c5a                     ## symbol stub for: _fprintf
000000010000273e	movl	$0x65, %edi
0000000100002743	callq	0x100012c48                     ## symbol stub for: _exit
0000000100002748	nopl	(%rax,%rax)
_f0:
0000000100002750	pushq	%rbp
0000000100002751	movq	%rsp, %rbp
0000000100002754	pushq	%r15
0000000100002756	pushq	%r14
0000000100002758	pushq	%r13
000000010000275a	pushq	%r12
000000010000275c	pushq	%rbx
000000010000275d	subq	$0xc8, %rsp
0000000100002764	movq	%rdi, %rbx
0000000100002767	movq	0x128c2(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000276e	movq	(%rax), %rax
0000000100002771	movq	%rax, -0x30(%rbp)
0000000100002775	xorpd	%xmm2, %xmm2
0000000100002779	movsd	0x10757(%rip), %xmm0
0000000100002781	xorl	%r14d, %r14d
0000000100002784	leaq	-0xd0(%rbp), %rdi
000000010000278b	xorps	%xmm1, %xmm1
000000010000278e	movsd	%xmm1, -0xa0(%rbp)
0000000100002796	xorl	%r15d, %r15d
0000000100002799	xorl	%r12d, %r12d
000000010000279c	jmp	0x1000027df
000000010000279e	nop
00000001000027a0	movq	%rbx, %rdi
00000001000027a3	movsd	%xmm2, -0x98(%rbp)
00000001000027ab	callq	_fwp_drop2
00000001000027b0	movsd	-0x98(%rbp), %xmm2
00000001000027b8	movsd	-0xa8(%rbp), %xmm0
00000001000027c0	movsd	%xmm0, -0xa0(%rbp)
00000001000027c8	movapd	%xmm2, %xmm0
00000001000027cc	movq	%r15, %rbx
00000001000027cf	testb	%r13b, %r13b
00000001000027d2	leaq	-0xd0(%rbp), %rdi
00000001000027d9	je	0x100002a40
00000001000027df	movq	%rbx, -0xd8(%rbp)
00000001000027e6	movq	_fwp_cleanups(%rip), %rax
00000001000027ed	movq	%rax, -0xd0(%rbp)
00000001000027f4	leaq	_fwp_owner_release38(%rip), %rax
00000001000027fb	movq	%rax, -0xc8(%rbp)
0000000100002802	leaq	-0xd8(%rbp), %rax
0000000100002809	movq	%rax, -0xc0(%rbp)
0000000100002810	movq	%rdi, _fwp_cleanups(%rip)
0000000100002817	testq	%r14, %r14
000000010000281a	js	0x100002860
000000010000281c	movq	(%rbx), %rdx
000000010000281f	movq	%rdx, %rax
0000000100002822	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000282c	andq	%rcx, %rax
000000010000282f	cmpq	%rax, %r14
0000000100002832	jae	0x100002860
0000000100002834	movl	_d0(%rip), %eax
000000010000283a	movl	$0x8, %ecx
000000010000283f	cmpq	$0xa, %rax
0000000100002843	ja	0x100002850
0000000100002845	leaq	0x1090c(%rip), %rcx
000000010000284c	movq	(%rcx,%rax,8), %rcx
0000000100002850	testq	%rdx, %rdx
0000000100002853	js	0x100002867
0000000100002855	leaq	0x8(%rbx), %rdx
0000000100002859	jmp	0x10000286b
000000010000285b	nopl	(%rax,%rax)
0000000100002860	xorl	%r13d, %r13d
0000000100002863	xorl	%eax, %eax
0000000100002865	jmp	0x1000028b4
0000000100002867	movq	0x10(%rbx), %rdx
000000010000286b	movq	%rcx, %rsi
000000010000286e	imulq	%r14, %rsi
0000000100002872	cmpq	$0x1, %rcx
0000000100002876	je	0x100002897
0000000100002878	cmpq	$0x2, %rcx
000000010000287c	je	0x10000288a
000000010000287e	cmpq	$0x8, %rcx
0000000100002882	jne	0x1000028a4
0000000100002884	movq	(%rdx,%rsi), %rax
0000000100002888	jmp	0x1000028b1
000000010000288a	movzwl	(%rdx,%rsi), %ecx
000000010000288e	cmpl	$0x1, %eax
0000000100002891	movswq	%cx, %rax
0000000100002895	jmp	0x1000028ad
0000000100002897	movzbl	(%rdx,%rsi), %ecx
000000010000289b	testq	%rax, %rax
000000010000289e	movsbq	%cl, %rax
00000001000028a2	jmp	0x1000028ad
00000001000028a4	movl	(%rdx,%rsi), %ecx
00000001000028a7	cmpl	$0x2, %eax
00000001000028aa	movslq	%ecx, %rax
00000001000028ad	cmovneq	%rcx, %rax
00000001000028b1	movb	$0x1, %r13b
00000001000028b4	cmpq	%rdi, _fwp_cleanups(%rip)
00000001000028bb	jne	0x100002a3b
00000001000028c1	movq	-0xd0(%rbp), %rcx
00000001000028c8	movq	%rcx, _fwp_cleanups(%rip)
00000001000028cf	testb	%r13b, %r13b
00000001000028d2	movsd	%xmm0, -0xa8(%rbp)
00000001000028da	je	0x1000027a0
00000001000028e0	movq	%rbx, -0xb8(%rbp)
00000001000028e7	movq	%rcx, -0xf0(%rbp)
00000001000028ee	leaq	_fwp_owner_release39(%rip), %rdx
00000001000028f5	movq	%rdx, -0xe8(%rbp)
00000001000028fc	leaq	-0xb8(%rbp), %rdx
0000000100002903	movq	%rdx, -0xe0(%rbp)
000000010000290a	leaq	-0xf0(%rbp), %rdx
0000000100002911	movq	%rdx, _fwp_cleanups(%rip)
0000000100002918	incq	%r14
000000010000291b	jo	0x100002a6f
0000000100002921	movq	%rax, %xmm0
0000000100002926	mulsd	0x105b2(%rip), %xmm0
000000010000292e	addsd	0x105b2(%rip), %xmm0
0000000100002936	movsd	%xmm0, -0x98(%rbp)
000000010000293e	movq	%rbx, -0xb0(%rbp)
0000000100002945	movq	%rcx, -0x90(%rbp)
000000010000294c	leaq	_fwp_owner_release42(%rip), %rax
0000000100002953	movq	%rax, -0x88(%rbp)
000000010000295a	leaq	-0xb0(%rbp), %rax
0000000100002961	movq	%rax, -0x80(%rbp)
0000000100002965	movq	%rbx, %rax
0000000100002968	subq	0x146c9(%rip), %rax
000000010000296f	leaq	-0x90(%rbp), %rcx
0000000100002976	movq	%rcx, _fwp_cleanups(%rip)
000000010000297d	movq	0x146dc(%rip), %rcx
0000000100002984	shlq	$0x10, %rcx
0000000100002988	cmpq	%rcx, %rax
000000010000298b	jae	0x1000029f1
000000010000298d	movq	0x146ec(%rip), %rcx
0000000100002994	movq	%rax, %rdx
0000000100002997	shrq	$0x10, %rdx
000000010000299b	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000029a2	leaq	(%rcx,%rdx), %rdi
00000001000029a6	movzbl	(%rcx,%rdx), %ecx
00000001000029aa	cmpb	$0x2, %cl
00000001000029ad	setne	%dl
00000001000029b0	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000029b6	setne	%sil
00000001000029ba	orb	%dl, %sil
00000001000029bd	jne	0x1000029c8
00000001000029bf	addq	$0x228, %rdi                    ## imm = 0x228
00000001000029c6	jmp	0x1000029e2
00000001000029c8	cmpb	$0x1, %cl
00000001000029cb	jne	0x1000029f1
00000001000029cd	movl	0x20(%rdi), %ecx
00000001000029d0	imulq	%rcx, %rax
00000001000029d4	shrq	$0x20, %rax
00000001000029d8	addq	%rax, %rdi
00000001000029db	addq	$0x228, %rdi                    ## imm = 0x228
00000001000029e2	movzbl	(%rdi), %eax
00000001000029e5	testb	%al, %al
00000001000029e7	je	0x1000029f1
00000001000029e9	cmpb	$-0x3, %al
00000001000029eb	ja	0x100002a26
00000001000029ed	incb	%al
00000001000029ef	movb	%al, (%rdi)
00000001000029f1	movq	-0x90(%rbp), %rax
00000001000029f8	movq	%rax, _fwp_cleanups(%rip)
00000001000029ff	movq	%rbx, %rdi
0000000100002a02	callq	_fwp_drop2
0000000100002a07	movsd	-0xa8(%rbp), %xmm0
0000000100002a0f	addsd	-0x98(%rbp), %xmm0
0000000100002a17	movq	%rbx, %r15
0000000100002a1a	movapd	%xmm0, %xmm2
0000000100002a1e	movq	%rbx, %r12
0000000100002a21	jmp	0x1000027cc
0000000100002a26	callq	_fwp_rc_wide_dup
0000000100002a2b	leaq	-0x90(%rbp), %rax
0000000100002a32	cmpq	%rax, _fwp_cleanups(%rip)
0000000100002a39	je	0x1000029f1
0000000100002a3b	callq	0x100012c2a                     ## symbol stub for: _abort
0000000100002a40	movq	0x125e9(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002a47	movq	(%rax), %rax
0000000100002a4a	cmpq	-0x30(%rbp), %rax
0000000100002a4e	jne	0x100002abd
0000000100002a50	movq	-0xa0(%rbp), %xmm0
0000000100002a58	movq	%xmm0, %rax
0000000100002a5d	addq	$0xc8, %rsp
0000000100002a64	popq	%rbx
0000000100002a65	popq	%r12
0000000100002a67	popq	%r13
0000000100002a69	popq	%r14
0000000100002a6b	popq	%r15
0000000100002a6d	popq	%rbp
0000000100002a6e	retq
0000000100002a6f	leaq	0x109b0(%rip), %rdx             ## literal pool for: "arithmetic overflow in %s"
0000000100002a76	leaq	0x109a5(%rip), %rcx             ## literal pool for: "I64"
0000000100002a7d	leaq	-0x90(%rbp), %rbx
0000000100002a84	movl	$0x60, %esi
0000000100002a89	movq	%rbx, %rdi
0000000100002a8c	xorl	%eax, %eax
0000000100002a8e	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100002a93	callq	_fwp_flush
0000000100002a98	movq	0x12599(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002a9f	movq	(%rax), %rdi
0000000100002aa2	leaq	0x10966(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100002aa9	movq	%rbx, %rdx
0000000100002aac	xorl	%eax, %eax
0000000100002aae	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100002ab3	movl	$0x65, %edi
0000000100002ab8	callq	0x100012c48                     ## symbol stub for: _exit
0000000100002abd	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100002ac2	nopw	%cs:(%rax,%rax)
_e0:
0000000100002ad0	pushq	%rbp
0000000100002ad1	movq	%rsp, %rbp
0000000100002ad4	pushq	%rbx
0000000100002ad5	pushq	%rax
0000000100002ad6	movq	%rdi, %rbx
0000000100002ad9	movq	(%rdi), %rdi
0000000100002adc	callq	_fwp_rc_share
0000000100002ae1	movq	(%rbx), %rdi
0000000100002ae4	callq	_f0
0000000100002ae9	movq	%rax, %rbx
0000000100002aec	movq	%rax, %rdi
0000000100002aef	callq	_fwp_rc_share
0000000100002af4	movq	%rbx, %rax
0000000100002af7	addq	$0x8, %rsp
0000000100002afb	popq	%rbx
0000000100002afc	popq	%rbp
0000000100002afd	retq
0000000100002afe	nop
_e1:
0000000100002b00	pushq	%rbp
0000000100002b01	movq	%rsp, %rbp
0000000100002b04	pushq	%r15
0000000100002b06	pushq	%r14
0000000100002b08	pushq	%r13
0000000100002b0a	pushq	%r12
0000000100002b0c	pushq	%rbx
0000000100002b0d	subq	$0xc8, %rsp
0000000100002b14	movq	%rdi, %rbx
0000000100002b17	movq	0x12512(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002b1e	movq	(%rax), %rax
0000000100002b21	movq	%rax, -0x30(%rbp)
0000000100002b25	movq	(%rdi), %rdi
0000000100002b28	callq	_fwp_rc_share
0000000100002b2d	movq	(%rbx), %rbx
0000000100002b30	movq	$0x0, -0x98(%rbp)
0000000100002b3b	leaq	-0xd0(%rbp), %rdi
0000000100002b42	xorl	%r14d, %r14d
0000000100002b45	xorl	%r13d, %r13d
0000000100002b48	xorl	%r15d, %r15d
0000000100002b4b	movq	$0x0, -0xa8(%rbp)
0000000100002b56	jmp	0x100002b89
0000000100002b58	nopl	(%rax,%rax)
0000000100002b60	movq	%rbx, %rdi
0000000100002b63	callq	_fwp_drop2
0000000100002b68	movq	-0x98(%rbp), %rax
0000000100002b6f	movq	%rax, -0xa8(%rbp)
0000000100002b76	movq	%r13, %rbx
0000000100002b79	testb	%r12b, %r12b
0000000100002b7c	leaq	-0xd0(%rbp), %rdi
0000000100002b83	je	0x100002df0
0000000100002b89	movq	%rbx, -0xd8(%rbp)
0000000100002b90	movq	_fwp_cleanups(%rip), %rax
0000000100002b97	movq	%rax, -0xd0(%rbp)
0000000100002b9e	leaq	_fwp_owner_release46(%rip), %rax
0000000100002ba5	movq	%rax, -0xc8(%rbp)
0000000100002bac	leaq	-0xd8(%rbp), %rax
0000000100002bb3	movq	%rax, -0xc0(%rbp)
0000000100002bba	movq	%rdi, _fwp_cleanups(%rip)
0000000100002bc1	testq	%r14, %r14
0000000100002bc4	js	0x100002c10
0000000100002bc6	movq	(%rbx), %rdx
0000000100002bc9	movq	%rdx, %rax
0000000100002bcc	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100002bd6	andq	%rcx, %rax
0000000100002bd9	cmpq	%rax, %r14
0000000100002bdc	jae	0x100002c10
0000000100002bde	movl	_d1(%rip), %eax
0000000100002be4	movl	$0x8, %ecx
0000000100002be9	cmpq	$0xa, %rax
0000000100002bed	ja	0x100002bfa
0000000100002bef	leaq	0x10562(%rip), %rcx
0000000100002bf6	movq	(%rcx,%rax,8), %rcx
0000000100002bfa	testq	%rdx, %rdx
0000000100002bfd	js	0x100002c17
0000000100002bff	leaq	0x8(%rbx), %rdx
0000000100002c03	jmp	0x100002c1b
0000000100002c05	nopw	%cs:(%rax,%rax)
0000000100002c10	xorl	%r12d, %r12d
0000000100002c13	xorl	%eax, %eax
0000000100002c15	jmp	0x100002c62
0000000100002c17	movq	0x10(%rbx), %rdx
0000000100002c1b	movq	%rcx, %rsi
0000000100002c1e	imulq	%r14, %rsi
0000000100002c22	cmpq	$0x1, %rcx
0000000100002c26	je	0x100002c4b
0000000100002c28	cmpq	$0x2, %rcx
0000000100002c2c	je	0x100002c3a
0000000100002c2e	cmpq	$0x8, %rcx
0000000100002c32	jne	0x100002c5c
0000000100002c34	movq	(%rdx,%rsi), %rax
0000000100002c38	jmp	0x100002c5f
0000000100002c3a	movzwl	(%rdx,%rsi), %ecx
0000000100002c3e	cmpl	$0x1, %eax
0000000100002c41	movswq	%cx, %rax
0000000100002c45	cmovneq	%rcx, %rax
0000000100002c49	jmp	0x100002c5f
0000000100002c4b	movzbl	(%rdx,%rsi), %ecx
0000000100002c4f	testq	%rax, %rax
0000000100002c52	movsbq	%cl, %rax
0000000100002c56	cmovneq	%rcx, %rax
0000000100002c5a	jmp	0x100002c5f
0000000100002c5c	movl	(%rdx,%rsi), %eax
0000000100002c5f	movb	$0x1, %r12b
0000000100002c62	cmpq	%rdi, _fwp_cleanups(%rip)
0000000100002c69	jne	0x100002deb
0000000100002c6f	movq	-0xd0(%rbp), %rcx
0000000100002c76	movq	%rcx, _fwp_cleanups(%rip)
0000000100002c7d	testb	%r12b, %r12b
0000000100002c80	je	0x100002b60
0000000100002c86	movq	%rbx, -0xb8(%rbp)
0000000100002c8d	movq	%rcx, -0xf0(%rbp)
0000000100002c94	leaq	_fwp_owner_release47(%rip), %rdx
0000000100002c9b	movq	%rdx, -0xe8(%rbp)
0000000100002ca2	leaq	-0xb8(%rbp), %rdx
0000000100002ca9	movq	%rdx, -0xe0(%rbp)
0000000100002cb0	leaq	-0xf0(%rbp), %rdx
0000000100002cb7	movq	%rdx, _fwp_cleanups(%rip)
0000000100002cbe	incq	%r14
0000000100002cc1	jo	0x100002e23
0000000100002cc7	movd	%eax, %xmm0
0000000100002ccb	mulss	0x1024d(%rip), %xmm0
0000000100002cd3	addss	0x10249(%rip), %xmm0
0000000100002cdb	movss	%xmm0, -0x9c(%rbp)
0000000100002ce3	movq	%rbx, -0xb0(%rbp)
0000000100002cea	movq	%rcx, -0x90(%rbp)
0000000100002cf1	leaq	_fwp_owner_release50(%rip), %rax
0000000100002cf8	movq	%rax, -0x88(%rbp)
0000000100002cff	leaq	-0xb0(%rbp), %rax
0000000100002d06	movq	%rax, -0x80(%rbp)
0000000100002d0a	movq	%rbx, %rax
0000000100002d0d	subq	0x14324(%rip), %rax
0000000100002d14	leaq	-0x90(%rbp), %rcx
0000000100002d1b	movq	%rcx, _fwp_cleanups(%rip)
0000000100002d22	movq	0x14337(%rip), %rcx
0000000100002d29	shlq	$0x10, %rcx
0000000100002d2d	cmpq	%rcx, %rax
0000000100002d30	jae	0x100002d96
0000000100002d32	movq	0x14347(%rip), %rcx
0000000100002d39	movq	%rax, %rdx
0000000100002d3c	shrq	$0x10, %rdx
0000000100002d40	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100002d47	leaq	(%rcx,%rdx), %rdi
0000000100002d4b	movzbl	(%rcx,%rdx), %ecx
0000000100002d4f	cmpb	$0x2, %cl
0000000100002d52	setne	%dl
0000000100002d55	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100002d5b	setne	%sil
0000000100002d5f	orb	%dl, %sil
0000000100002d62	jne	0x100002d6d
0000000100002d64	addq	$0x228, %rdi                    ## imm = 0x228
0000000100002d6b	jmp	0x100002d87
0000000100002d6d	cmpb	$0x1, %cl
0000000100002d70	jne	0x100002d96
0000000100002d72	movl	0x20(%rdi), %ecx
0000000100002d75	imulq	%rcx, %rax
0000000100002d79	shrq	$0x20, %rax
0000000100002d7d	addq	%rax, %rdi
0000000100002d80	addq	$0x228, %rdi                    ## imm = 0x228
0000000100002d87	movzbl	(%rdi), %eax
0000000100002d8a	testb	%al, %al
0000000100002d8c	je	0x100002d96
0000000100002d8e	cmpb	$-0x3, %al
0000000100002d90	ja	0x100002dd6
0000000100002d92	incb	%al
0000000100002d94	movb	%al, (%rdi)
0000000100002d96	movq	-0x90(%rbp), %rax
0000000100002d9d	movq	%rax, _fwp_cleanups(%rip)
0000000100002da4	movq	%rbx, %rdi
0000000100002da7	callq	_fwp_drop2
0000000100002dac	movss	-0x98(%rbp), %xmm0
0000000100002db4	movss	-0x9c(%rbp), %xmm1
0000000100002dbc	addss	%xmm0, %xmm1
0000000100002dc0	movd	%xmm1, %eax
0000000100002dc4	movq	%rax, -0x98(%rbp)
0000000100002dcb	movq	%rbx, %r13
0000000100002dce	movq	%rbx, %r15
0000000100002dd1	jmp	0x100002b76
0000000100002dd6	callq	_fwp_rc_wide_dup
0000000100002ddb	leaq	-0x90(%rbp), %rax
0000000100002de2	cmpq	%rax, _fwp_cleanups(%rip)
0000000100002de9	je	0x100002d96
0000000100002deb	callq	0x100012c2a                     ## symbol stub for: _abort
0000000100002df0	movl	-0xa8(%rbp), %ebx
0000000100002df6	movq	%rbx, %rdi
0000000100002df9	callq	_fwp_rc_share
0000000100002dfe	movq	0x1222b(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002e05	movq	(%rax), %rax
0000000100002e08	cmpq	-0x30(%rbp), %rax
0000000100002e0c	jne	0x100002e71
0000000100002e0e	movq	%rbx, %rax
0000000100002e11	addq	$0xc8, %rsp
0000000100002e18	popq	%rbx
0000000100002e19	popq	%r12
0000000100002e1b	popq	%r13
0000000100002e1d	popq	%r14
0000000100002e1f	popq	%r15
0000000100002e21	popq	%rbp
0000000100002e22	retq
0000000100002e23	leaq	0x105fc(%rip), %rdx             ## literal pool for: "arithmetic overflow in %s"
0000000100002e2a	leaq	0x105f1(%rip), %rcx             ## literal pool for: "I64"
0000000100002e31	leaq	-0x90(%rbp), %rbx
0000000100002e38	movl	$0x60, %esi
0000000100002e3d	movq	%rbx, %rdi
0000000100002e40	xorl	%eax, %eax
0000000100002e42	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100002e47	callq	_fwp_flush
0000000100002e4c	movq	0x121e5(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002e53	movq	(%rax), %rdi
0000000100002e56	leaq	0x105b2(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100002e5d	movq	%rbx, %rdx
0000000100002e60	xorl	%eax, %eax
0000000100002e62	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100002e67	movl	$0x65, %edi
0000000100002e6c	callq	0x100012c48                     ## symbol stub for: _exit
0000000100002e71	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100002e76	nopw	%cs:(%rax,%rax)
_e2:
0000000100002e80	pushq	%rbp
0000000100002e81	movq	%rsp, %rbp
0000000100002e84	pushq	%r15
0000000100002e86	pushq	%r14
0000000100002e88	pushq	%r13
0000000100002e8a	pushq	%r12
0000000100002e8c	pushq	%rbx
0000000100002e8d	subq	$0x128, %rsp                    ## imm = 0x128
0000000100002e94	movq	%rdi, %rbx
0000000100002e97	movq	0x12192(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002e9e	movq	(%rax), %rax
0000000100002ea1	movq	%rax, -0x30(%rbp)
0000000100002ea5	movq	(%rdi), %rdi
0000000100002ea8	callq	_fwp_rc_share
0000000100002ead	movq	(%rbx), %rbx
0000000100002eb0	xorl	%r15d, %r15d
0000000100002eb3	leaq	-0xe8(%rbp), %rdi
0000000100002eba	xorl	%r12d, %r12d
0000000100002ebd	xorl	%r8d, %r8d
0000000100002ec0	xorl	%r9d, %r9d
0000000100002ec3	movq	$0x0, -0x98(%rbp)
0000000100002ece	jmp	0x100002f12
0000000100002ed0	movq	%rbx, %rdi
0000000100002ed3	movq	%r12, -0xa0(%rbp)
0000000100002eda	movq	%r8, %r12
0000000100002edd	movq	%r15, %r14
0000000100002ee0	movq	%r9, %r15
0000000100002ee3	callq	_fwp_drop2
0000000100002ee8	movq	%r15, %r9
0000000100002eeb	movq	%r14, %r15
0000000100002eee	movq	%r12, %r8
0000000100002ef1	movq	-0xa0(%rbp), %r12
0000000100002ef8	movq	%r14, -0x98(%rbp)
0000000100002eff	movq	%r8, %rbx
0000000100002f02	testb	%r13b, %r13b
0000000100002f05	leaq	-0xe8(%rbp), %rdi
0000000100002f0c	je	0x1000031c6
0000000100002f12	movq	%rbx, -0xf0(%rbp)
0000000100002f19	movq	_fwp_cleanups(%rip), %rax
0000000100002f20	movq	%rax, -0xe8(%rbp)
0000000100002f27	leaq	_fwp_owner_release54(%rip), %rax
0000000100002f2e	movq	%rax, -0xe0(%rbp)
0000000100002f35	leaq	-0xf0(%rbp), %rax
0000000100002f3c	movq	%rax, -0xd8(%rbp)
0000000100002f43	movq	%rdi, _fwp_cleanups(%rip)
0000000100002f4a	testq	%r12, %r12
0000000100002f4d	js	0x100002f90
0000000100002f4f	movq	(%rbx), %rdx
0000000100002f52	movq	%rdx, %rax
0000000100002f55	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100002f5f	andq	%rcx, %rax
0000000100002f62	cmpq	%rax, %r12
0000000100002f65	jae	0x100002f90
0000000100002f67	movl	_d2(%rip), %eax
0000000100002f6d	movl	$0x8, %ecx
0000000100002f72	cmpq	$0xa, %rax
0000000100002f76	ja	0x100002f83
0000000100002f78	leaq	0x101d9(%rip), %rcx
0000000100002f7f	movq	(%rcx,%rax,8), %rcx
0000000100002f83	testq	%rdx, %rdx
0000000100002f86	js	0x100002f97
0000000100002f88	leaq	0x8(%rbx), %rdx
0000000100002f8c	jmp	0x100002f9b
0000000100002f8e	nop
0000000100002f90	xorl	%r13d, %r13d
0000000100002f93	xorl	%eax, %eax
0000000100002f95	jmp	0x100002fe4
0000000100002f97	movq	0x10(%rbx), %rdx
0000000100002f9b	movq	%rcx, %rsi
0000000100002f9e	imulq	%r12, %rsi
0000000100002fa2	cmpq	$0x1, %rcx
0000000100002fa6	je	0x100002fc7
0000000100002fa8	cmpq	$0x2, %rcx
0000000100002fac	je	0x100002fba
0000000100002fae	cmpq	$0x8, %rcx
0000000100002fb2	jne	0x100002fd4
0000000100002fb4	movq	(%rdx,%rsi), %rax
0000000100002fb8	jmp	0x100002fe1
0000000100002fba	movzwl	(%rdx,%rsi), %ecx
0000000100002fbe	cmpl	$0x1, %eax
0000000100002fc1	movswq	%cx, %rax
0000000100002fc5	jmp	0x100002fdd
0000000100002fc7	movzbl	(%rdx,%rsi), %ecx
0000000100002fcb	testq	%rax, %rax
0000000100002fce	movsbq	%cl, %rax
0000000100002fd2	jmp	0x100002fdd
0000000100002fd4	movl	(%rdx,%rsi), %ecx
0000000100002fd7	cmpl	$0x2, %eax
0000000100002fda	movslq	%ecx, %rax
0000000100002fdd	cmovneq	%rcx, %rax
0000000100002fe1	movb	$0x1, %r13b
0000000100002fe4	cmpq	%rdi, _fwp_cleanups(%rip)
0000000100002feb	jne	0x1000031c1
0000000100002ff1	movq	-0xe8(%rbp), %rcx
0000000100002ff8	movq	%rcx, _fwp_cleanups(%rip)
0000000100002fff	testb	%r13b, %r13b
0000000100003002	je	0x100002ed0
0000000100003008	movq	%rbx, -0xd0(%rbp)
000000010000300f	movq	%rcx, -0x148(%rbp)
0000000100003016	leaq	_fwp_owner_release55(%rip), %rdx
000000010000301d	movq	%rdx, -0x140(%rbp)
0000000100003024	leaq	-0xd0(%rbp), %rdx
000000010000302b	movq	%rdx, -0x138(%rbp)
0000000100003032	leaq	-0x148(%rbp), %rdx
0000000100003039	movq	%rdx, _fwp_cleanups(%rip)
0000000100003040	incq	%r12
0000000100003043	jo	0x1000031fa
0000000100003049	movq	%rbx, -0xc8(%rbp)
0000000100003050	movq	%rcx, -0x130(%rbp)
0000000100003057	leaq	_fwp_owner_release56(%rip), %rdx
000000010000305e	movq	%rdx, -0x128(%rbp)
0000000100003065	leaq	-0xc8(%rbp), %rdx
000000010000306c	movq	%rdx, -0x120(%rbp)
0000000100003073	leaq	-0x130(%rbp), %rdx
000000010000307a	movq	%rdx, _fwp_cleanups(%rip)
0000000100003081	addq	$-0x7f, %rax
0000000100003085	cmpq	$-0x101, %rax                   ## imm = 0xFEFF
000000010000308b	jbe	0x10000320a
0000000100003091	movq	%rbx, -0xc0(%rbp)
0000000100003098	movq	%rcx, -0xb8(%rbp)
000000010000309f	leaq	_fwp_owner_release57(%rip), %rax
00000001000030a6	movq	%rax, -0xb0(%rbp)
00000001000030ad	leaq	-0xc0(%rbp), %rax
00000001000030b4	movq	%rax, -0xa8(%rbp)
00000001000030bb	movq	%rbx, %rax
00000001000030be	subq	0x13f73(%rip), %rax
00000001000030c5	leaq	-0xb8(%rbp), %rcx
00000001000030cc	movq	%rcx, _fwp_cleanups(%rip)
00000001000030d3	movq	0x13f86(%rip), %rcx
00000001000030da	shlq	$0x10, %rcx
00000001000030de	cmpq	%rcx, %rax
00000001000030e1	jae	0x100003147
00000001000030e3	movq	0x13f96(%rip), %rcx
00000001000030ea	movq	%rax, %rdx
00000001000030ed	shrq	$0x10, %rdx
00000001000030f1	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000030f8	leaq	(%rcx,%rdx), %rdi
00000001000030fc	movzbl	(%rcx,%rdx), %ecx
0000000100003100	cmpb	$0x2, %cl
0000000100003103	setne	%dl
0000000100003106	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000310c	setne	%sil
0000000100003110	orb	%dl, %sil
0000000100003113	jne	0x10000311e
0000000100003115	addq	$0x228, %rdi                    ## imm = 0x228
000000010000311c	jmp	0x100003138
000000010000311e	cmpb	$0x1, %cl
0000000100003121	jne	0x100003147
0000000100003123	movl	0x20(%rdi), %ecx
0000000100003126	imulq	%rcx, %rax
000000010000312a	shrq	$0x20, %rax
000000010000312e	addq	%rax, %rdi
0000000100003131	addq	$0x228, %rdi                    ## imm = 0x228
0000000100003138	movzbl	(%rdi), %eax
000000010000313b	testb	%al, %al
000000010000313d	je	0x100003147
000000010000313f	cmpb	$-0x3, %al
0000000100003141	ja	0x1000031ac
0000000100003143	incb	%al
0000000100003145	movb	%al, (%rdi)
0000000100003147	movq	-0xb8(%rbp), %rax
000000010000314e	movq	%rbx, -0x100(%rbp)
0000000100003155	movq	%rbx, -0xf8(%rbp)
000000010000315c	movq	%rax, -0x118(%rbp)
0000000100003163	leaq	_fwp_owner_release58(%rip), %rcx
000000010000316a	movq	%rcx, -0x110(%rbp)
0000000100003171	leaq	-0x100(%rbp), %rcx
0000000100003178	movq	%rcx, -0x108(%rbp)
000000010000317f	leaq	-0x118(%rbp), %rcx
0000000100003186	movq	%rcx, _fwp_cleanups(%rip)
000000010000318d	incq	%r15
0000000100003190	jo	0x1000031fa
0000000100003192	movq	%rax, _fwp_cleanups(%rip)
0000000100003199	movq	%rbx, %rdi
000000010000319c	callq	_fwp_drop2
00000001000031a1	movq	%rbx, %r8
00000001000031a4	movq	%rbx, %r9
00000001000031a7	jmp	0x100002eff
00000001000031ac	callq	_fwp_rc_wide_dup
00000001000031b1	leaq	-0xb8(%rbp), %rax
00000001000031b8	cmpq	%rax, _fwp_cleanups(%rip)
00000001000031bf	je	0x100003147
00000001000031c1	callq	0x100012c2a                     ## symbol stub for: _abort
00000001000031c6	movq	-0x98(%rbp), %rbx
00000001000031cd	movq	%rbx, %rdi
00000001000031d0	callq	_fwp_rc_share
00000001000031d5	movq	0x11e54(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000031dc	movq	(%rax), %rax
00000001000031df	cmpq	-0x30(%rbp), %rax
00000001000031e3	jne	0x100003258
00000001000031e5	movq	%rbx, %rax
00000001000031e8	addq	$0x128, %rsp                    ## imm = 0x128
00000001000031ef	popq	%rbx
00000001000031f0	popq	%r12
00000001000031f2	popq	%r13
00000001000031f4	popq	%r14
00000001000031f6	popq	%r15
00000001000031f8	popq	%rbp
00000001000031f9	retq
00000001000031fa	leaq	0x10225(%rip), %rdx             ## literal pool for: "arithmetic overflow in %s"
0000000100003201	leaq	0x1021a(%rip), %rcx             ## literal pool for: "I64"
0000000100003208	jmp	0x100003218
000000010000320a	leaq	0x10215(%rip), %rdx             ## literal pool for: "arithmetic overflow in %s"
0000000100003211	leaq	0x1028d(%rip), %rcx             ## literal pool for: "I8"
0000000100003218	leaq	-0x90(%rbp), %rbx
000000010000321f	movl	$0x60, %esi
0000000100003224	movq	%rbx, %rdi
0000000100003227	xorl	%eax, %eax
0000000100003229	callq	0x100012d0e                     ## symbol stub for: _snprintf
000000010000322e	callq	_fwp_flush
0000000100003233	movq	0x11dfe(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000323a	movq	(%rax), %rdi
000000010000323d	leaq	0x101cb(%rip), %rsi             ## literal pool for: "fwp: trap: %s\n"
0000000100003244	movq	%rbx, %rdx
0000000100003247	xorl	%eax, %eax
0000000100003249	callq	0x100012c5a                     ## symbol stub for: _fprintf
000000010000324e	movl	$0x65, %edi
0000000100003253	callq	0x100012c48                     ## symbol stub for: _exit
0000000100003258	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000325d	nopl	(%rax)
_e3:
0000000100003260	pushq	%rbp
0000000100003261	movq	%rsp, %rbp
0000000100003264	pushq	%r15
0000000100003266	pushq	%r14
0000000100003268	pushq	%r13
000000010000326a	pushq	%r12
000000010000326c	pushq	%rbx
000000010000326d	subq	$0x118, %rsp                    ## imm = 0x118
0000000100003274	movq	%rdi, %rbx
0000000100003277	movq	0x11db2(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000327e	movq	(%rax), %rax
0000000100003281	movq	%rax, -0x30(%rbp)
0000000100003285	movq	(%rdi), %rdi
0000000100003288	callq	_fwp_rc_share
000000010000328d	movq	(%rbx), %rbx
0000000100003290	xorl	%r14d, %r14d
0000000100003293	leaq	-0xb0(%rbp), %rdi
000000010000329a	xorl	%r15d, %r15d
000000010000329d	xorl	%r8d, %r8d
00000001000032a0	xorl	%r9d, %r9d
00000001000032a3	movq	$0x0, -0x98(%rbp)
00000001000032ae	jmp	0x1000032f8
00000001000032b0	movq	%rbx, %rdi
00000001000032b3	movq	%r8, %r13
00000001000032b6	movq	%r15, -0xb8(%rbp)
00000001000032bd	movq	%r12, %r15
00000001000032c0	movq	%r14, %r12
00000001000032c3	movq	%r9, %r14
00000001000032c6	callq	_fwp_drop2
00000001000032cb	movq	%r14, %r9
00000001000032ce	movq	%r12, %r14
00000001000032d1	movq	%r15, %r12
00000001000032d4	movq	-0xb8(%rbp), %r15
00000001000032db	movq	%r13, %r8
00000001000032de	leaq	-0xb0(%rbp), %rdi
00000001000032e5	movq	%r14, -0x98(%rbp)
00000001000032ec	movq	%r8, %rbx
00000001000032ef	testb	%r12b, %r12b
00000001000032f2	je	0x1000035d8
00000001000032f8	movq	%rbx, -0xf8(%rbp)
00000001000032ff	movq	_fwp_cleanups(%rip), %rax
0000000100003306	movq	%rax, -0xb0(%rbp)
000000010000330d	leaq	_fwp_owner_release61(%rip), %rax
0000000100003314	movq	%rax, -0xa8(%rbp)
000000010000331b	leaq	-0xf8(%rbp), %rax
0000000100003322	movq	%rax, -0xa0(%rbp)
0000000100003329	movq	%rdi, _fwp_cleanups(%rip)
0000000100003330	testq	%r15, %r15
0000000100003333	js	0x100003380
0000000100003335	movq	(%rbx), %rdx
0000000100003338	movq	%rdx, %rax
000000010000333b	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100003345	andq	%rcx, %rax
0000000100003348	cmpq	%rax, %r15
000000010000334b	jae	0x100003380
000000010000334d	movl	_d2(%rip), %eax
0000000100003353	movl	$0x8, %ecx
0000000100003358	cmpq	$0xa, %rax
000000010000335c	ja	0x100003369
000000010000335e	leaq	0xfdf3(%rip), %rcx
0000000100003365	movq	(%rcx,%rax,8), %rcx
0000000100003369	testq	%rdx, %rdx
000000010000336c	js	0x100003388
000000010000336e	leaq	0x8(%rbx), %rdx
0000000100003372	jmp	0x10000338c
0000000100003374	nopw	%cs:(%rax,%rax)
0000000100003380	xorl	%r12d, %r12d
0000000100003383	xorl	%r13d, %r13d
0000000100003386	jmp	0x1000033d5
0000000100003388	movq	0x10(%rbx), %rdx
000000010000338c	movq	%rcx, %rsi
000000010000338f	imulq	%r15, %rsi
0000000100003393	cmpq	$0x1, %rcx
0000000100003397	je	0x1000033b8
0000000100003399	cmpq	$0x2, %rcx
000000010000339d	je	0x1000033ab
000000010000339f	cmpq	$0x8, %rcx
00000001000033a3	jne	0x1000033c5
00000001000033a5	movq	(%rdx,%rsi), %r13
00000001000033a9	jmp	0x1000033d2
00000001000033ab	movzwl	(%rdx,%rsi), %ecx
00000001000033af	cmpl	$0x1, %eax
00000001000033b2	movswq	%cx, %r13
00000001000033b6	jmp	0x1000033ce
00000001000033b8	movzbl	(%rdx,%rsi), %ecx
00000001000033bc	testq	%rax, %rax
00000001000033bf	movsbq	%cl, %r13
00000001000033c3	jmp	0x1000033ce
00000001000033c5	movl	(%rdx,%rsi), %ecx
00000001000033c8	cmpl	$0x2, %eax
00000001000033cb	movslq	%ecx, %r13
00000001000033ce	cmovneq	%rcx, %r13
00000001000033d2	movb	$0x1, %r12b
00000001000033d5	cmpq	%rdi, _fwp_cleanups(%rip)
00000001000033dc	jne	0x1000035d3
00000001000033e2	movq	-0xb0(%rbp), %rax
00000001000033e9	movq	%rax, _fwp_cleanups(%rip)
00000001000033f0	testb	%r12b, %r12b
00000001000033f3	je	0x1000032b0
00000001000033f9	movq	%rbx, -0xf0(%rbp)
0000000100003400	movq	%rax, -0x140(%rbp)
0000000100003407	leaq	_fwp_owner_release62(%rip), %rcx
000000010000340e	movq	%rcx, -0x138(%rbp)
0000000100003415	leaq	-0xf0(%rbp), %rcx
000000010000341c	movq	%rcx, -0x130(%rbp)
0000000100003423	leaq	-0x140(%rbp), %rcx
000000010000342a	movq	%rcx, _fwp_cleanups(%rip)
0000000100003431	incq	%r15
0000000100003434	jo	0x10000361d
000000010000343a	movq	%rbx, -0xe8(%rbp)
0000000100003441	movq	%rax, -0x128(%rbp)
0000000100003448	leaq	_fwp_owner_release63(%rip), %rcx
000000010000344f	movq	%rcx, -0x120(%rbp)
0000000100003456	leaq	-0xe8(%rbp), %rcx
000000010000345d	movq	%rcx, -0x118(%rbp)
0000000100003464	leaq	-0x128(%rbp), %rcx
000000010000346b	movq	%rcx, _fwp_cleanups(%rip)
0000000100003472	leaq	-0x7f(%r13), %rcx
0000000100003476	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
000000010000347d	jbe	0x10000360d
0000000100003483	movq	%rbx, -0xe0(%rbp)
000000010000348a	movq	%rax, -0xd8(%rbp)
0000000100003491	leaq	_fwp_owner_release64(%rip), %rax
0000000100003498	movq	%rax, -0xd0(%rbp)
000000010000349f	leaq	-0xe0(%rbp), %rax
00000001000034a6	movq	%rax, -0xc8(%rbp)
00000001000034ad	movq	%rbx, %rax
00000001000034b0	subq	0x13b81(%rip), %rax
00000001000034b7	leaq	-0xd8(%rbp), %rcx
00000001000034be	movq	%rcx, _fwp_cleanups(%rip)
00000001000034c5	movq	0x13b94(%rip), %rcx
00000001000034cc	shlq	$0x10, %rcx
00000001000034d0	cmpq	%rcx, %rax
00000001000034d3	jae	0x10000353d
00000001000034d5	movq	0x13ba4(%rip), %rcx
00000001000034dc	movq	%rax, %rdx
00000001000034df	shrq	$0x10, %rdx
00000001000034e3	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000034ea	leaq	(%rcx,%rdx), %rdi
00000001000034ee	movzbl	(%rcx,%rdx), %ecx
00000001000034f2	cmpb	$0x2, %cl
00000001000034f5	setne	%dl
00000001000034f8	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000034fe	setne	%sil
0000000100003502	orb	%dl, %sil
0000000100003505	jne	0x100003510
0000000100003507	addq	$0x228, %rdi                    ## imm = 0x228
000000010000350e	jmp	0x10000352a
0000000100003510	cmpb	$0x1, %cl
0000000100003513	jne	0x10000353d
0000000100003515	movl	0x20(%rdi), %ecx
0000000100003518	imulq	%rcx, %rax
000000010000351c	shrq	$0x20, %rax
0000000100003520	addq	%rax, %rdi
0000000100003523	addq	$0x228, %rdi                    ## imm = 0x228
000000010000352a	movzbl	(%rdi), %eax
000000010000352d	testb	%al, %al
000000010000352f	je	0x10000353d
0000000100003531	cmpb	$-0x3, %al
0000000100003533	ja	0x1000035ba
0000000100003539	incb	%al
000000010000353b	movb	%al, (%rdi)
000000010000353d	movq	-0xd8(%rbp), %rax
0000000100003544	movq	%rax, _fwp_cleanups(%rip)
000000010000354b	movq	%rbx, %rdi
000000010000354e	callq	_fwp_drop2
0000000100003553	movq	%rbx, -0xc0(%rbp)
000000010000355a	movq	_fwp_cleanups(%rip), %rax
0000000100003561	movq	%rax, -0x110(%rbp)
0000000100003568	leaq	_fwp_owner_release65(%rip), %rcx
000000010000356f	movq	%rcx, -0x108(%rbp)
0000000100003576	leaq	-0xc0(%rbp), %rcx
000000010000357d	movq	%rcx, -0x100(%rbp)
0000000100003584	leaq	-0x110(%rbp), %rcx
000000010000358b	movq	%rcx, _fwp_cleanups(%rip)
0000000100003592	addq	%r13, %r14
0000000100003595	incq	%r14
0000000100003598	movsbq	%r14b, %rcx
000000010000359c	cmpq	%r14, %rcx
000000010000359f	jne	0x10000360d
00000001000035a1	movq	%rax, _fwp_cleanups(%rip)
00000001000035a8	movq	%rbx, %r8
00000001000035ab	movq	%rbx, %r9
00000001000035ae	leaq	-0xb0(%rbp), %rdi
00000001000035b5	jmp	0x1000032ec
00000001000035ba	callq	_fwp_rc_wide_dup
00000001000035bf	leaq	-0xd8(%rbp), %rax
00000001000035c6	cmpq	%rax, _fwp_cleanups(%rip)
00000001000035cd	je	0x10000353d
00000001000035d3	callq	0x100012c2a                     ## symbol stub for: _abort
00000001000035d8	movsbq	-0x98(%rbp), %rbx
00000001000035e0	movq	%rbx, %rdi
00000001000035e3	callq	_fwp_rc_share
00000001000035e8	movq	0x11a41(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000035ef	movq	(%rax), %rax
00000001000035f2	cmpq	-0x30(%rbp), %rax
00000001000035f6	jne	0x10000366b
00000001000035f8	movq	%rbx, %rax
00000001000035fb	addq	$0x118, %rsp                    ## imm = 0x118
0000000100003602	popq	%rbx
0000000100003603	popq	%r12
0000000100003605	popq	%r13
0000000100003607	popq	%r14
0000000100003609	popq	%r15
000000010000360b	popq	%rbp
000000010000360c	retq
000000010000360d	leaq	0xfe12(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100003614	leaq	0xfe8a(%rip), %rcx              ## literal pool for: "I8"
000000010000361b	jmp	0x10000362b
000000010000361d	leaq	0xfe02(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100003624	leaq	0xfdf7(%rip), %rcx              ## literal pool for: "I64"
000000010000362b	leaq	-0x90(%rbp), %rbx
0000000100003632	movl	$0x60, %esi
0000000100003637	movq	%rbx, %rdi
000000010000363a	xorl	%eax, %eax
000000010000363c	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100003641	callq	_fwp_flush
0000000100003646	movq	0x119eb(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000364d	movq	(%rax), %rdi
0000000100003650	leaq	0xfdb8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003657	movq	%rbx, %rdx
000000010000365a	xorl	%eax, %eax
000000010000365c	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100003661	movl	$0x65, %edi
0000000100003666	callq	0x100012c48                     ## symbol stub for: _exit
000000010000366b	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
_e8:
0000000100003670	pushq	%rbp
0000000100003671	movq	%rsp, %rbp
0000000100003674	pushq	%rbx
0000000100003675	subq	$0x68, %rsp
0000000100003679	movq	0x119b0(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100003680	movq	(%rax), %rax
0000000100003683	movq	%rax, -0x10(%rbp)
0000000100003687	movq	0x8(%rdi), %rbx
000000010000368b	addq	(%rdi), %rbx
000000010000368e	movsbq	%bl, %rax
0000000100003692	cmpq	%rbx, %rax
0000000100003695	jne	0x1000036b9
0000000100003697	movq	%rbx, %rdi
000000010000369a	callq	_fwp_rc_share
000000010000369f	movq	0x1198a(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000036a6	movq	(%rax), %rax
00000001000036a9	cmpq	-0x10(%rbp), %rax
00000001000036ad	jne	0x100003704
00000001000036af	movq	%rbx, %rax
00000001000036b2	addq	$0x68, %rsp
00000001000036b6	popq	%rbx
00000001000036b7	popq	%rbp
00000001000036b8	retq
00000001000036b9	leaq	0xfd66(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000036c0	leaq	0xfdde(%rip), %rcx              ## literal pool for: "I8"
00000001000036c7	leaq	-0x70(%rbp), %rbx
00000001000036cb	movl	$0x60, %esi
00000001000036d0	movq	%rbx, %rdi
00000001000036d3	xorl	%eax, %eax
00000001000036d5	callq	0x100012d0e                     ## symbol stub for: _snprintf
00000001000036da	callq	_fwp_flush
00000001000036df	movq	0x11952(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000036e6	movq	(%rax), %rdi
00000001000036e9	leaq	0xfd1f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000036f0	movq	%rbx, %rdx
00000001000036f3	xorl	%eax, %eax
00000001000036f5	callq	0x100012c5a                     ## symbol stub for: _fprintf
00000001000036fa	movl	$0x65, %edi
00000001000036ff	callq	0x100012c48                     ## symbol stub for: _exit
0000000100003704	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100003709	nopl	(%rax)
_e17:
0000000100003710	pushq	%rbp
0000000100003711	movq	%rsp, %rbp
0000000100003714	pushq	%rbx
0000000100003715	pushq	%rax
0000000100003716	movdqu	(%rdi), %xmm0
000000010000371a	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000371f	addps	%xmm0, %xmm1
0000000100003722	extractps	$0x0, %xmm1, %ebx
0000000100003728	movq	%rbx, %rdi
000000010000372b	callq	_fwp_rc_share
0000000100003730	movq	%rbx, %rax
0000000100003733	addq	$0x8, %rsp
0000000100003737	popq	%rbx
0000000100003738	popq	%rbp
0000000100003739	retq
000000010000373a	nopw	(%rax,%rax)
_e18:
0000000100003740	pushq	%rbp
0000000100003741	movq	%rsp, %rbp
0000000100003744	pushq	%rbx
0000000100003745	pushq	%rax
0000000100003746	movdqu	(%rdi), %xmm0
000000010000374a	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000374f	mulps	%xmm0, %xmm1
0000000100003752	extractps	$0x0, %xmm1, %ebx
0000000100003758	movq	%rbx, %rdi
000000010000375b	callq	_fwp_rc_share
0000000100003760	movq	%rbx, %rax
0000000100003763	addq	$0x8, %rsp
0000000100003767	popq	%rbx
0000000100003768	popq	%rbp
0000000100003769	retq
000000010000376a	nopw	(%rax,%rax)
_e25:
0000000100003770	pushq	%rbp
0000000100003771	movq	%rsp, %rbp
0000000100003774	pushq	%rbx
0000000100003775	pushq	%rax
0000000100003776	movsd	(%rdi), %xmm0
000000010000377a	addsd	0x8(%rdi), %xmm0
000000010000377f	movq	%xmm0, %rbx
0000000100003784	movq	%rbx, %rdi
0000000100003787	callq	_fwp_rc_share
000000010000378c	movq	%rbx, %rax
000000010000378f	addq	$0x8, %rsp
0000000100003793	popq	%rbx
0000000100003794	popq	%rbp
0000000100003795	retq
0000000100003796	nopw	%cs:(%rax,%rax)
_e26:
00000001000037a0	pushq	%rbp
00000001000037a1	movq	%rsp, %rbp
00000001000037a4	pushq	%rbx
00000001000037a5	pushq	%rax
00000001000037a6	movsd	(%rdi), %xmm0
00000001000037aa	mulsd	0x8(%rdi), %xmm0
00000001000037af	movq	%xmm0, %rbx
00000001000037b4	movq	%rbx, %rdi
00000001000037b7	callq	_fwp_rc_share
00000001000037bc	movq	%rbx, %rax
00000001000037bf	addq	$0x8, %rsp
00000001000037c3	popq	%rbx
00000001000037c4	popq	%rbp
00000001000037c5	retq
00000001000037c6	nopw	%cs:(%rax,%rax)
_e27:
00000001000037d0	pushq	%rbp
00000001000037d1	movq	%rsp, %rbp
00000001000037d4	pushq	%rbx
00000001000037d5	pushq	%rax
00000001000037d6	movq	%rdi, %rbx
00000001000037d9	movq	0x8(%rdi), %rdi
00000001000037dd	callq	_fwp_rc_share
00000001000037e2	movq	(%rbx), %rdi
00000001000037e5	movq	0x8(%rbx), %rsi
00000001000037e9	leaq	_d0(%rip), %rdx
00000001000037f0	callq	_fwp_p_array_get_typed
00000001000037f5	movq	%rax, %rbx
00000001000037f8	movq	%rax, %rdi
00000001000037fb	callq	_fwp_rc_share
0000000100003800	movq	%rbx, %rax
0000000100003803	addq	$0x8, %rsp
0000000100003807	popq	%rbx
0000000100003808	popq	%rbp
0000000100003809	retq
000000010000380a	nopw	(%rax,%rax)
_e28:
0000000100003810	pushq	%rbp
0000000100003811	movq	%rsp, %rbp
0000000100003814	pushq	%rbx
0000000100003815	subq	$0x68, %rsp
0000000100003819	movq	0x11810(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100003820	movq	(%rax), %rax
0000000100003823	movq	%rax, -0x10(%rbp)
0000000100003827	movq	0x8(%rdi), %rbx
000000010000382b	addq	(%rdi), %rbx
000000010000382e	jo	0x100003852
0000000100003830	movq	%rbx, %rdi
0000000100003833	callq	_fwp_rc_share
0000000100003838	movq	0x117f1(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000383f	movq	(%rax), %rax
0000000100003842	cmpq	-0x10(%rbp), %rax
0000000100003846	jne	0x10000389d
0000000100003848	movq	%rbx, %rax
000000010000384b	addq	$0x68, %rsp
000000010000384f	popq	%rbx
0000000100003850	popq	%rbp
0000000100003851	retq
0000000100003852	leaq	0xfbcd(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100003859	leaq	0xfbc2(%rip), %rcx              ## literal pool for: "I64"
0000000100003860	leaq	-0x70(%rbp), %rbx
0000000100003864	movl	$0x60, %esi
0000000100003869	movq	%rbx, %rdi
000000010000386c	xorl	%eax, %eax
000000010000386e	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100003873	callq	_fwp_flush
0000000100003878	movq	0x117b9(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000387f	movq	(%rax), %rdi
0000000100003882	leaq	0xfb86(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003889	movq	%rbx, %rdx
000000010000388c	xorl	%eax, %eax
000000010000388e	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100003893	movl	$0x65, %edi
0000000100003898	callq	0x100012c48                     ## symbol stub for: _exit
000000010000389d	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
00000001000038a2	nopw	%cs:(%rax,%rax)
_e29:
00000001000038b0	pushq	%rbp
00000001000038b1	movq	%rsp, %rbp
00000001000038b4	pushq	%rbx
00000001000038b5	pushq	%rax
00000001000038b6	movq	%rdi, %rbx
00000001000038b9	movq	(%rdi), %rdi
00000001000038bc	callq	_fwp_rc_share
00000001000038c1	movq	(%rbx), %rdi
00000001000038c4	callq	_f29
00000001000038c9	movq	%rax, %rbx
00000001000038cc	movq	%rax, %rdi
00000001000038cf	callq	_fwp_rc_share
00000001000038d4	movq	%rbx, %rax
00000001000038d7	addq	$0x8, %rsp
00000001000038db	popq	%rbx
00000001000038dc	popq	%rbp
00000001000038dd	retq
00000001000038de	nop
_e30:
00000001000038e0	pushq	%rbp
00000001000038e1	movq	%rsp, %rbp
00000001000038e4	pushq	%rbx
00000001000038e5	pushq	%rax
00000001000038e6	movq	%rdi, %rbx
00000001000038e9	movq	(%rdi), %rdi
00000001000038ec	callq	_fwp_rc_share
00000001000038f1	movq	0x8(%rbx), %rdi
00000001000038f5	callq	_fwp_rc_share
00000001000038fa	movq	(%rbx), %rdi
00000001000038fd	movq	0x8(%rbx), %rsi
0000000100003901	leaq	_fwp_drop1(%rip), %rdx
0000000100003908	callq	_fwp_p_loop_own
000000010000390d	movq	%rax, %rbx
0000000100003910	movq	%rax, %rdi
0000000100003913	callq	_fwp_rc_share
0000000100003918	movq	%rbx, %rax
000000010000391b	addq	$0x8, %rsp
000000010000391f	popq	%rbx
0000000100003920	popq	%rbp
0000000100003921	retq
0000000100003922	nopw	%cs:(%rax,%rax)
_e31:
0000000100003930	pushq	%rbp
0000000100003931	movq	%rsp, %rbp
0000000100003934	pushq	%rbx
0000000100003935	pushq	%rax
0000000100003936	movq	%rdi, %rbx
0000000100003939	movq	0x8(%rdi), %rdi
000000010000393d	callq	_fwp_rc_share
0000000100003942	movq	(%rbx), %rdi
0000000100003945	movq	0x8(%rbx), %rsi
0000000100003949	leaq	_d1(%rip), %rdx
0000000100003950	callq	_fwp_p_array_get_typed
0000000100003955	movq	%rax, %rbx
0000000100003958	movq	%rax, %rdi
000000010000395b	callq	_fwp_rc_share
0000000100003960	movq	%rbx, %rax
0000000100003963	addq	$0x8, %rsp
0000000100003967	popq	%rbx
0000000100003968	popq	%rbp
0000000100003969	retq
000000010000396a	nopw	(%rax,%rax)
_e32:
0000000100003970	pushq	%rbp
0000000100003971	movq	%rsp, %rbp
0000000100003974	pushq	%rbx
0000000100003975	pushq	%rax
0000000100003976	movq	%rdi, %rbx
0000000100003979	movq	(%rdi), %rdi
000000010000397c	callq	_fwp_rc_share
0000000100003981	movq	(%rbx), %rdi
0000000100003984	callq	_f32
0000000100003989	movq	%rax, %rbx
000000010000398c	movq	%rax, %rdi
000000010000398f	callq	_fwp_rc_share
0000000100003994	movq	%rbx, %rax
0000000100003997	addq	$0x8, %rsp
000000010000399b	popq	%rbx
000000010000399c	popq	%rbp
000000010000399d	retq
000000010000399e	nop
_e33:
00000001000039a0	pushq	%rbp
00000001000039a1	movq	%rsp, %rbp
00000001000039a4	pushq	%rbx
00000001000039a5	pushq	%rax
00000001000039a6	movq	%rdi, %rbx
00000001000039a9	movq	(%rdi), %rdi
00000001000039ac	callq	_fwp_rc_share
00000001000039b1	movq	0x8(%rbx), %rdi
00000001000039b5	callq	_fwp_rc_share
00000001000039ba	movq	(%rbx), %rdi
00000001000039bd	movq	0x8(%rbx), %rsi
00000001000039c1	leaq	_fwp_drop3(%rip), %rdx
00000001000039c8	callq	_fwp_p_loop_own
00000001000039cd	movq	%rax, %rbx
00000001000039d0	movq	%rax, %rdi
00000001000039d3	callq	_fwp_rc_share
00000001000039d8	movq	%rbx, %rax
00000001000039db	addq	$0x8, %rsp
00000001000039df	popq	%rbx
00000001000039e0	popq	%rbp
00000001000039e1	retq
00000001000039e2	nopw	%cs:(%rax,%rax)
_e34:
00000001000039f0	pushq	%rbp
00000001000039f1	movq	%rsp, %rbp
00000001000039f4	pushq	%rbx
00000001000039f5	pushq	%rax
00000001000039f6	movq	%rdi, %rbx
00000001000039f9	movq	0x8(%rdi), %rdi
00000001000039fd	callq	_fwp_rc_share
0000000100003a02	movq	(%rbx), %rdi
0000000100003a05	movq	0x8(%rbx), %rsi
0000000100003a09	leaq	_d2(%rip), %rdx
0000000100003a10	callq	_fwp_p_array_get_typed
0000000100003a15	movq	%rax, %rbx
0000000100003a18	movq	%rax, %rdi
0000000100003a1b	callq	_fwp_rc_share
0000000100003a20	movq	%rbx, %rax
0000000100003a23	addq	$0x8, %rsp
0000000100003a27	popq	%rbx
0000000100003a28	popq	%rbp
0000000100003a29	retq
0000000100003a2a	nopw	(%rax,%rax)
_e35:
0000000100003a30	pushq	%rbp
0000000100003a31	movq	%rsp, %rbp
0000000100003a34	pushq	%rbx
0000000100003a35	pushq	%rax
0000000100003a36	movq	%rdi, %rbx
0000000100003a39	movq	(%rdi), %rdi
0000000100003a3c	callq	_fwp_rc_share
0000000100003a41	movq	(%rbx), %rdi
0000000100003a44	callq	_f35
0000000100003a49	movq	%rax, %rbx
0000000100003a4c	movq	%rax, %rdi
0000000100003a4f	callq	_fwp_rc_share
0000000100003a54	movq	%rbx, %rax
0000000100003a57	addq	$0x8, %rsp
0000000100003a5b	popq	%rbx
0000000100003a5c	popq	%rbp
0000000100003a5d	retq
0000000100003a5e	nop
_e36:
0000000100003a60	pushq	%rbp
0000000100003a61	movq	%rsp, %rbp
0000000100003a64	pushq	%rbx
0000000100003a65	pushq	%rax
0000000100003a66	movq	%rdi, %rbx
0000000100003a69	movq	(%rdi), %rdi
0000000100003a6c	callq	_fwp_rc_share
0000000100003a71	movq	0x8(%rbx), %rdi
0000000100003a75	callq	_fwp_rc_share
0000000100003a7a	movq	(%rbx), %rdi
0000000100003a7d	movq	0x8(%rbx), %rsi
0000000100003a81	leaq	_fwp_drop5(%rip), %rdx
0000000100003a88	callq	_fwp_p_loop_own
0000000100003a8d	movq	%rax, %rbx
0000000100003a90	movq	%rax, %rdi
0000000100003a93	callq	_fwp_rc_share
0000000100003a98	movq	%rbx, %rax
0000000100003a9b	addq	$0x8, %rsp
0000000100003a9f	popq	%rbx
0000000100003aa0	popq	%rbp
0000000100003aa1	retq
0000000100003aa2	nopw	%cs:(%rax,%rax)
_e37:
0000000100003ab0	pushq	%rbp
0000000100003ab1	movq	%rsp, %rbp
0000000100003ab4	pushq	%rbx
0000000100003ab5	pushq	%rax
0000000100003ab6	movq	%rdi, %rbx
0000000100003ab9	movq	(%rdi), %rdi
0000000100003abc	callq	_fwp_rc_share
0000000100003ac1	movq	(%rbx), %rdi
0000000100003ac4	callq	_f37
0000000100003ac9	movq	%rax, %rbx
0000000100003acc	movq	%rax, %rdi
0000000100003acf	callq	_fwp_rc_share
0000000100003ad4	movq	%rbx, %rax
0000000100003ad7	addq	$0x8, %rsp
0000000100003adb	popq	%rbx
0000000100003adc	popq	%rbp
0000000100003add	retq
0000000100003ade	nop
_e38:
0000000100003ae0	pushq	%rbp
0000000100003ae1	movq	%rsp, %rbp
0000000100003ae4	pushq	%rbx
0000000100003ae5	pushq	%rax
0000000100003ae6	movq	%rdi, %rbx
0000000100003ae9	movq	(%rdi), %rdi
0000000100003aec	callq	_fwp_rc_share
0000000100003af1	movq	0x8(%rbx), %rdi
0000000100003af5	callq	_fwp_rc_share
0000000100003afa	movq	(%rbx), %rdi
0000000100003afd	movq	0x8(%rbx), %rsi
0000000100003b01	leaq	_fwp_drop6(%rip), %rdx
0000000100003b08	callq	_fwp_p_loop_own
0000000100003b0d	movq	%rax, %rbx
0000000100003b10	movq	%rax, %rdi
0000000100003b13	callq	_fwp_rc_share
0000000100003b18	movq	%rbx, %rax
0000000100003b1b	addq	$0x8, %rsp
0000000100003b1f	popq	%rbx
0000000100003b20	popq	%rbp
0000000100003b21	retq
0000000100003b22	nopw	%cs:(%rax,%rax)
_fwp_rc_share:
0000000100003b30	pushq	%rbp
0000000100003b31	movq	%rsp, %rbp
0000000100003b34	pushq	%r15
0000000100003b36	pushq	%r14
0000000100003b38	pushq	%r13
0000000100003b3a	pushq	%r12
0000000100003b3c	pushq	%rbx
0000000100003b3d	subq	$0x208, %rsp                    ## imm = 0x208
0000000100003b44	movq	0x114e5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100003b4b	movq	(%rax), %rax
0000000100003b4e	movq	%rax, -0x30(%rbp)
0000000100003b52	movq	%rdi, %rax
0000000100003b55	subq	0x134dc(%rip), %rax
0000000100003b5c	movq	0x134fd(%rip), %rcx
0000000100003b63	shlq	$0x10, %rcx
0000000100003b67	cmpq	%rcx, %rax
0000000100003b6a	jae	0x100003d54
0000000100003b70	movq	0x13509(%rip), %rcx
0000000100003b77	movq	%rax, %rdx
0000000100003b7a	shrq	$0x10, %rdx
0000000100003b7e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003b85	leaq	(%rcx,%rdx), %rbx
0000000100003b89	movzbl	(%rcx,%rdx), %ecx
0000000100003b8d	cmpb	$0x2, %cl
0000000100003b90	setne	%dl
0000000100003b93	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100003b99	setne	%sil
0000000100003b9d	orb	%dl, %sil
0000000100003ba0	jne	0x100003bab
0000000100003ba2	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003ba9	jmp	0x100003bc9
0000000100003bab	cmpb	$0x1, %cl
0000000100003bae	jne	0x100003d54
0000000100003bb4	movl	0x20(%rbx), %ecx
0000000100003bb7	imulq	%rcx, %rax
0000000100003bbb	shrq	$0x20, %rax
0000000100003bbf	addq	%rax, %rbx
0000000100003bc2	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003bc9	movzbl	(%rbx), %eax
0000000100003bcc	testb	%al, %al
0000000100003bce	je	0x100003d54
0000000100003bd4	cmpb	$-0x1, %al
0000000100003bd6	je	0x100003d76
0000000100003bdc	movb	$0x0, (%rbx)
0000000100003bdf	movq	%rdi, -0x230(%rbp)
0000000100003be6	movl	$0x1, %r14d
0000000100003bec	jmp	0x100003bf9
0000000100003bee	nop
0000000100003bf0	testq	%r14, %r14
0000000100003bf3	je	0x100003d54
0000000100003bf9	movq	-0x238(%rbp,%r14,8), %r15
0000000100003c01	decq	%r14
0000000100003c04	movq	0x1342d(%rip), %rax
0000000100003c0b	movq	%r15, %rcx
0000000100003c0e	subq	%rax, %rcx
0000000100003c11	movq	%rcx, %rsi
0000000100003c14	shrq	$0x10, %rsi
0000000100003c18	movq	0x13461(%rip), %rdx
0000000100003c1f	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100003c26	cmpb	$0x1, 0x1(%rdx,%rsi)
0000000100003c2b	je	0x100003bf0
0000000100003c2d	addq	%rsi, %rdx
0000000100003c30	movzbl	(%rdx), %esi
0000000100003c33	cmpb	$0x2, %sil
0000000100003c37	jne	0x100003c40
0000000100003c39	movq	0x18(%rdx), %r12
0000000100003c3d	jmp	0x100003c6b
0000000100003c3f	nop
0000000100003c40	movl	0x8(%rdx), %r12d
0000000100003c44	cmpb	$0x1, %sil
0000000100003c48	jne	0x100003c6b
0000000100003c4a	movzwl	%r15w, %esi
0000000100003c4e	movl	0x20(%rdx), %r15d
0000000100003c52	imulq	%rsi, %r15
0000000100003c56	shrq	$0x20, %r15
0000000100003c5a	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100003c61	addq	%rcx, %rax
0000000100003c64	imulq	%r12, %r15
0000000100003c68	addq	%rax, %r15
0000000100003c6b	cmpq	$0x8, %r12
0000000100003c6f	jb	0x100003bf0
0000000100003c75	shrq	$0x3, %r12
0000000100003c79	xorl	%r13d, %r13d
0000000100003c7c	jmp	0x100003c9c
0000000100003c7e	callq	_fwp_rc_share
0000000100003c83	nopw	%cs:(%rax,%rax)
0000000100003c90	incq	%r13
0000000100003c93	cmpq	%r13, %r12
0000000100003c96	je	0x100003bf0
0000000100003c9c	movq	(%r15,%r13,8), %rdi
0000000100003ca0	movq	%rdi, %rax
0000000100003ca3	subq	0x1338e(%rip), %rax
0000000100003caa	movq	0x133af(%rip), %rcx
0000000100003cb1	shlq	$0x10, %rcx
0000000100003cb5	cmpq	%rcx, %rax
0000000100003cb8	jae	0x100003c90
0000000100003cba	movq	0x133bf(%rip), %rcx
0000000100003cc1	movq	%rax, %rdx
0000000100003cc4	shrq	$0x10, %rdx
0000000100003cc8	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100003ccf	leaq	(%rcx,%rdx), %rbx
0000000100003cd3	movzbl	(%rcx,%rdx), %ecx
0000000100003cd7	cmpb	$0x2, %cl
0000000100003cda	setne	%dl
0000000100003cdd	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100003ce3	setne	%sil
0000000100003ce7	orb	%dl, %sil
0000000100003cea	jne	0x100003d00
0000000100003cec	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003cf3	jmp	0x100003d1a
0000000100003cf5	nopw	%cs:(%rax,%rax)
0000000100003d00	cmpb	$0x1, %cl
0000000100003d03	jne	0x100003c90
0000000100003d05	movl	0x20(%rbx), %ecx
0000000100003d08	imulq	%rcx, %rax
0000000100003d0c	shrq	$0x20, %rax
0000000100003d10	addq	%rax, %rbx
0000000100003d13	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003d1a	movzbl	(%rbx), %eax
0000000100003d1d	testb	%al, %al
0000000100003d1f	je	0x100003c90
0000000100003d25	cmpq	$0x3f, %r14
0000000100003d29	ja	0x100003c7e
0000000100003d2f	cmpb	$-0x1, %al
0000000100003d31	je	0x100003d4a
0000000100003d33	movb	$0x0, (%rbx)
0000000100003d36	movq	(%r15,%r13,8), %rax
0000000100003d3a	movq	%rax, -0x230(%rbp,%r14,8)
0000000100003d42	incq	%r14
0000000100003d45	jmp	0x100003c90
0000000100003d4a	movq	%rbx, %rdi
0000000100003d4d	callq	_fwp_rc_forget_slot
0000000100003d52	jmp	0x100003d33
0000000100003d54	movq	0x112d5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100003d5b	movq	(%rax), %rax
0000000100003d5e	cmpq	-0x30(%rbp), %rax
0000000100003d62	jne	0x100003d89
0000000100003d64	addq	$0x208, %rsp                    ## imm = 0x208
0000000100003d6b	popq	%rbx
0000000100003d6c	popq	%r12
0000000100003d6e	popq	%r13
0000000100003d70	popq	%r14
0000000100003d72	popq	%r15
0000000100003d74	popq	%rbp
0000000100003d75	retq
0000000100003d76	movq	%rdi, %r14
0000000100003d79	movq	%rbx, %rdi
0000000100003d7c	callq	_fwp_rc_forget_slot
0000000100003d81	movq	%r14, %rdi
0000000100003d84	jmp	0x100003bdc
0000000100003d89	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100003d8e	nop
_fwp_rc_forget_slot:
0000000100003d90	pushq	%rbp
0000000100003d91	movq	%rsp, %rbp
0000000100003d94	cmpb	$-0x1, (%rdi)
0000000100003d97	je	0x100003d9b
0000000100003d99	popq	%rbp
0000000100003d9a	retq
0000000100003d9b	movq	%rdi, %rax
0000000100003d9e	shrq	$0x11, %rax
0000000100003da2	xorl	%edi, %eax
0000000100003da4	movl	%eax, %ecx
0000000100003da6	shrl	$0x9, %ecx
0000000100003da9	xorl	%eax, %ecx
0000000100003dab	movzbl	%cl, %ecx
0000000100003dae	leaq	_fwp_gc(%rip), %rdx
0000000100003db5	movq	0x1218(%rdx,%rcx,8), %rax
0000000100003dbd	testq	%rax, %rax
0000000100003dc0	je	0x100003e0a
0000000100003dc2	cmpq	%rdi, (%rax)
0000000100003dc5	je	0x100003de7
0000000100003dc7	nopw	(%rax,%rax)
0000000100003dd0	movq	%rax, %rcx
0000000100003dd3	movq	0x10(%rax), %rax
0000000100003dd7	testq	%rax, %rax
0000000100003dda	je	0x100003e0a
0000000100003ddc	cmpq	%rdi, (%rax)
0000000100003ddf	jne	0x100003dd0
0000000100003de1	addq	$0x10, %rcx
0000000100003de5	jmp	0x100003df2
0000000100003de7	leaq	(%rdx,%rcx,8), %rcx
0000000100003deb	addq	$0x1218, %rcx                   ## imm = 0x1218
0000000100003df2	movq	0x10(%rax), %rdx
0000000100003df6	movq	%rdx, (%rcx)
0000000100003df9	movq	%rax, %rdi
0000000100003dfc	callq	0x100012c72                     ## symbol stub for: _free
0000000100003e01	decq	0x13c18(%rip)
0000000100003e08	popq	%rbp
0000000100003e09	retq
0000000100003e0a	callq	_fwp_flush
0000000100003e0f	movq	0x11222(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100003e16	movq	(%rax), %rdi
0000000100003e19	leaq	0xf5ef(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003e20	leaq	0xf5c1(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100003e27	xorl	%eax, %eax
0000000100003e29	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100003e2e	movl	$0x65, %edi
0000000100003e33	callq	0x100012c48                     ## symbol stub for: _exit
0000000100003e38	nopl	(%rax,%rax)
_fwp_flush:
0000000100003e40	pushq	%rbp
0000000100003e41	movq	%rsp, %rbp
0000000100003e44	movq	_fwp_prog_out(%rip), %rdi
0000000100003e4b	testq	%rdi, %rdi
0000000100003e4e	je	0x100003e55
0000000100003e50	callq	0x100012c4e                     ## symbol stub for: _fflush
0000000100003e55	movq	0x111ec(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100003e5c	movq	(%rax), %rdi
0000000100003e5f	popq	%rbp
0000000100003e60	jmp	0x100012c4e                     ## symbol stub for: _fflush
0000000100003e65	nopw	%cs:(%rax,%rax)
_fwp_owner_release46:
0000000100003e70	pushq	%rbp
0000000100003e71	movq	%rsp, %rbp
0000000100003e74	movq	(%rdi), %rdi
0000000100003e77	popq	%rbp
0000000100003e78	jmp	_fwp_drop2
0000000100003e7d	nopl	(%rax)
_fwp_owner_release47:
0000000100003e80	pushq	%rbp
0000000100003e81	movq	%rsp, %rbp
0000000100003e84	movq	(%rdi), %rdi
0000000100003e87	popq	%rbp
0000000100003e88	jmp	_fwp_drop2
0000000100003e8d	nopl	(%rax)
_fwp_owner_release50:
0000000100003e90	pushq	%rbp
0000000100003e91	movq	%rsp, %rbp
0000000100003e94	movq	(%rdi), %rdi
0000000100003e97	popq	%rbp
0000000100003e98	jmp	_fwp_drop2
0000000100003e9d	nopl	(%rax)
_fwp_drop2:
0000000100003ea0	pushq	%rbp
0000000100003ea1	movq	%rsp, %rbp
0000000100003ea4	pushq	%rbx
0000000100003ea5	pushq	%rax
0000000100003ea6	movq	%rdi, %rcx
0000000100003ea9	subq	0x13188(%rip), %rcx
0000000100003eb0	movq	0x131a9(%rip), %rax
0000000100003eb7	shlq	$0x10, %rax
0000000100003ebb	cmpq	%rax, %rcx
0000000100003ebe	jae	0x100003f63
0000000100003ec4	movq	0x131b5(%rip), %rdx
0000000100003ecb	movq	%rcx, %rax
0000000100003ece	shrq	$0x10, %rax
0000000100003ed2	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100003ed9	leaq	(%rdx,%rsi), %rax
0000000100003edd	movzbl	(%rdx,%rsi), %edx
0000000100003ee1	cmpb	$0x2, %dl
0000000100003ee4	setne	%sil
0000000100003ee8	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100003eef	setne	%r8b
0000000100003ef3	orb	%sil, %r8b
0000000100003ef6	jne	0x100003f00
0000000100003ef8	addq	$0x228, %rax                    ## imm = 0x228
0000000100003efe	jmp	0x100003f19
0000000100003f00	cmpb	$0x1, %dl
0000000100003f03	jne	0x100003f63
0000000100003f05	movl	0x20(%rax), %edx
0000000100003f08	imulq	%rdx, %rcx
0000000100003f0c	shrq	$0x20, %rcx
0000000100003f10	addq	%rcx, %rax
0000000100003f13	addq	$0x228, %rax                    ## imm = 0x228
0000000100003f19	movzbl	(%rax), %ecx
0000000100003f1c	testl	%ecx, %ecx
0000000100003f1e	je	0x100003f63
0000000100003f20	cmpl	$0x1, %ecx
0000000100003f23	jne	0x100003f57
0000000100003f25	cmpq	$0x0, (%rdi)
0000000100003f29	jns	0x100003f6a
0000000100003f2b	movq	0x8(%rdi), %rbx
0000000100003f2f	callq	_fwp_rc_free_arr
0000000100003f34	movq	%rbx, %rcx
0000000100003f37	subq	0x130fa(%rip), %rcx
0000000100003f3e	movq	0x1311b(%rip), %rax
0000000100003f45	shlq	$0x10, %rax
0000000100003f49	movq	%rbx, %rdi
0000000100003f4c	cmpq	%rax, %rcx
0000000100003f4f	jb	0x100003ec4
0000000100003f55	jmp	0x100003f63
0000000100003f57	cmpl	$0xff, %ecx
0000000100003f5d	je	0x100003f75
0000000100003f5f	decb	%cl
0000000100003f61	movb	%cl, (%rax)
0000000100003f63	addq	$0x8, %rsp
0000000100003f67	popq	%rbx
0000000100003f68	popq	%rbp
0000000100003f69	retq
0000000100003f6a	addq	$0x8, %rsp
0000000100003f6e	popq	%rbx
0000000100003f6f	popq	%rbp
0000000100003f70	jmp	_fwp_rc_free_arr
0000000100003f75	movq	%rax, %rdi
0000000100003f78	addq	$0x8, %rsp
0000000100003f7c	popq	%rbx
0000000100003f7d	popq	%rbp
0000000100003f7e	jmp	_fwp_rc_wide_drop
0000000100003f83	nopw	%cs:(%rax,%rax)
_fwp_rc_wide_dup:
0000000100003f90	pushq	%rbp
0000000100003f91	movq	%rsp, %rbp
0000000100003f94	pushq	%r14
0000000100003f96	pushq	%rbx
0000000100003f97	movq	%rdi, %rbx
0000000100003f9a	movq	%rdi, %rax
0000000100003f9d	shrq	$0x11, %rax
0000000100003fa1	xorl	%ebx, %eax
0000000100003fa3	movl	%eax, %ecx
0000000100003fa5	shrl	$0x9, %ecx
0000000100003fa8	xorl	%eax, %ecx
0000000100003faa	movzbl	%cl, %eax
0000000100003fad	leaq	_fwp_gc(%rip), %rcx
0000000100003fb4	leaq	(%rcx,%rax,8), %r14
0000000100003fb8	addq	$0x1218, %r14                   ## imm = 0x1218
0000000100003fbf	movq	0x1218(%rcx,%rax,8), %rax
0000000100003fc7	testq	%rax, %rax
0000000100003fca	je	0x100003ff3
0000000100003fcc	cmpq	%rbx, (%rax)
0000000100003fcf	je	0x100004000
0000000100003fd1	nopw	%cs:(%rax,%rax)
0000000100003fe0	movq	%rax, %r14
0000000100003fe3	movq	0x10(%rax), %rax
0000000100003fe7	testq	%rax, %rax
0000000100003fea	je	0x100003ffa
0000000100003fec	cmpq	%rbx, (%rax)
0000000100003fef	jne	0x100003fe0
0000000100003ff1	jmp	0x100003ffc
0000000100003ff3	cmpb	$-0x2, (%rbx)
0000000100003ff6	je	0x10000400e
0000000100003ff8	jmp	0x100004064
0000000100003ffa	xorl	%eax, %eax
0000000100003ffc	addq	$0x10, %r14
0000000100004000	cmpb	$-0x2, (%rbx)
0000000100004003	jne	0x100004046
0000000100004005	testq	%rax, %rax
0000000100004008	jne	0x1000040ad
000000010000400e	movl	$0x18, %edi
0000000100004013	callq	0x100012c96                     ## symbol stub for: _malloc
0000000100004018	testq	%rax, %rax
000000010000401b	je	0x100004083
000000010000401d	movq	%rbx, (%rax)
0000000100004020	movq	$0xff, 0x8(%rax)
0000000100004028	movq	$0x0, 0x10(%rax)
0000000100004030	movq	%rax, (%r14)
0000000100004033	movb	$-0x1, (%rbx)
0000000100004036	leaq	0x139e3(%rip), %rax
000000010000403d	movq	0x139dc(%rip), %rcx
0000000100004044	jmp	0x100004059
0000000100004046	testq	%rax, %rax
0000000100004049	je	0x100004064
000000010000404b	movq	0x8(%rax), %rcx
000000010000404f	cmpq	$-0x1, %rcx
0000000100004053	je	0x1000040cc
0000000100004055	addq	$0x8, %rax
0000000100004059	incq	%rcx
000000010000405c	movq	%rcx, (%rax)
000000010000405f	popq	%rbx
0000000100004060	popq	%r14
0000000100004062	popq	%rbp
0000000100004063	retq
0000000100004064	callq	_fwp_flush
0000000100004069	movq	0x10fc8(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100004070	movq	(%rax), %rdi
0000000100004073	leaq	0xf395(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000407a	leaq	0xf367(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100004081	jmp	0x1000040e9
0000000100004083	movq	0x10fae(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000408a	movq	(%rax), %rcx
000000010000408d	leaq	0xf3ea(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004094	movl	$0x13, %esi
0000000100004099	movl	$0x1, %edx
000000010000409e	callq	0x100012c78                     ## symbol stub for: _fwrite
00000001000040a3	movl	$0x66, %edi
00000001000040a8	callq	0x100012c48                     ## symbol stub for: _exit
00000001000040ad	callq	_fwp_flush
00000001000040b2	movq	0x10f7f(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000040b9	movq	(%rax), %rdi
00000001000040bc	leaq	0xf34c(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000040c3	leaq	0xf376(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
00000001000040ca	jmp	0x1000040e9
00000001000040cc	callq	_fwp_flush
00000001000040d1	movq	0x10f60(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000040d8	movq	(%rax), %rdi
00000001000040db	leaq	0xf32d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000040e2	leaq	0xf37c(%rip), %rdx              ## literal pool for: "reference count overflow"
00000001000040e9	xorl	%eax, %eax
00000001000040eb	callq	0x100012c5a                     ## symbol stub for: _fprintf
00000001000040f0	movl	$0x65, %edi
00000001000040f5	callq	0x100012c48                     ## symbol stub for: _exit
00000001000040fa	nopw	(%rax,%rax)
_fwp_rc_free_arr:
0000000100004100	movq	%rdi, %rax
0000000100004103	subq	0x12f2e(%rip), %rax
000000010000410a	movq	0x12f4f(%rip), %rcx
0000000100004111	shlq	$0x10, %rcx
0000000100004115	cmpq	%rcx, %rax
0000000100004118	jae	0x1000041e5
000000010000411e	pushq	%rbp
000000010000411f	movq	%rsp, %rbp
0000000100004122	pushq	%rbx
0000000100004123	pushq	%rax
0000000100004124	movq	0x12f55(%rip), %rdx
000000010000412b	movq	%rax, %rcx
000000010000412e	shrq	$0x10, %rcx
0000000100004132	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100004139	leaq	(%rdx,%rsi), %rcx
000000010000413d	movzbl	(%rdx,%rsi), %edx
0000000100004141	cmpb	$0x2, %dl
0000000100004144	setne	%sil
0000000100004148	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000414e	setne	%r8b
0000000100004152	orb	%sil, %r8b
0000000100004155	jne	0x100004165
0000000100004157	addq	$0x228, %rcx                    ## imm = 0x228
000000010000415e	cmpb	$0x1, (%rcx)
0000000100004161	je	0x100004184
0000000100004163	jmp	0x1000041df
0000000100004165	cmpb	$0x1, %dl
0000000100004168	jne	0x1000041df
000000010000416a	movl	0x20(%rcx), %edx
000000010000416d	imulq	%rdx, %rax
0000000100004171	shrq	$0x20, %rax
0000000100004175	addq	%rax, %rcx
0000000100004178	addq	$0x228, %rcx                    ## imm = 0x228
000000010000417f	cmpb	$0x1, (%rcx)
0000000100004182	jne	0x1000041df
0000000100004184	movl	_fwp_reuse_verify(%rip), %eax
000000010000418a	testl	%eax, %eax
000000010000418c	js	0x10000419b
000000010000418e	testl	%eax, %eax
0000000100004190	je	0x1000041b4
0000000100004192	movq	$0x0, (%rdi)
0000000100004199	jmp	0x1000041df
000000010000419b	leaq	-0xc(%rbp), %rax
000000010000419f	movq	%rdi, %rbx
00000001000041a2	movq	%rax, %rdi
00000001000041a5	callq	_fwp_rc_free_arr.cold.1
00000001000041aa	movq	%rbx, %rdi
00000001000041ad	movl	-0xc(%rbp), %eax
00000001000041b0	testl	%eax, %eax
00000001000041b2	jne	0x100004192
00000001000041b4	movq	_fwp_gc(%rip), %rbx
00000001000041bb	callq	_fwp_mem_free
00000001000041c0	movq	_fwp_gc(%rip), %rax
00000001000041c7	subq	%rbx, %rax
00000001000041ca	cvtsi2sd	%rax, %xmm0
00000001000041cf	addsd	0x13039(%rip), %xmm0
00000001000041d7	movsd	%xmm0, 0x13031(%rip)
00000001000041df	addq	$0x8, %rsp
00000001000041e3	popq	%rbx
00000001000041e4	popq	%rbp
00000001000041e5	retq
00000001000041e6	nopw	%cs:(%rax,%rax)
_fwp_rc_wide_drop:
00000001000041f0	pushq	%rbp
00000001000041f1	movq	%rsp, %rbp
00000001000041f4	pushq	%rbx
00000001000041f5	pushq	%rax
00000001000041f6	movq	%rdi, %rax
00000001000041f9	shrq	$0x11, %rax
00000001000041fd	xorl	%edi, %eax
00000001000041ff	movl	%eax, %ecx
0000000100004201	shrl	$0x9, %ecx
0000000100004204	xorl	%eax, %ecx
0000000100004206	movzbl	%cl, %eax
0000000100004209	leaq	_fwp_gc(%rip), %rcx
0000000100004210	movq	0x1218(%rcx,%rax,8), %rax
0000000100004218	testq	%rax, %rax
000000010000421b	je	0x10000422e
000000010000421d	nopl	(%rax)
0000000100004220	cmpq	%rdi, (%rax)
0000000100004223	je	0x10000425c
0000000100004225	movq	0x10(%rax), %rax
0000000100004229	testq	%rax, %rax
000000010000422c	jne	0x100004220
000000010000422e	callq	_fwp_flush
0000000100004233	movq	0x10dfe(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000423a	movq	(%rax), %rdi
000000010000423d	leaq	0xf1cb(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100004244	leaq	0xf19d(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
000000010000424b	xorl	%eax, %eax
000000010000424d	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100004252	movl	$0x65, %edi
0000000100004257	callq	0x100012c48                     ## symbol stub for: _exit
000000010000425c	movq	0x8(%rax), %rcx
0000000100004260	decq	%rcx
0000000100004263	movq	%rcx, 0x8(%rax)
0000000100004267	cmpq	$0xfe, %rcx
000000010000426e	jne	0x10000427b
0000000100004270	movq	%rdi, %rbx
0000000100004273	callq	_fwp_rc_forget_slot
0000000100004278	movb	$-0x2, (%rbx)
000000010000427b	addq	$0x8, %rsp
000000010000427f	popq	%rbx
0000000100004280	popq	%rbp
0000000100004281	retq
0000000100004282	nopw	%cs:(%rax,%rax)
_fwp_mem_free:
0000000100004290	testq	%rdi, %rdi
0000000100004293	je	0x1000044a5
0000000100004299	movq	0x12d98(%rip), %rax
00000001000042a0	movq	%rdi, %rcx
00000001000042a3	subq	%rax, %rcx
00000001000042a6	movq	0x12db3(%rip), %rdx
00000001000042ad	shlq	$0x10, %rdx
00000001000042b1	cmpq	%rdx, %rcx
00000001000042b4	jae	0x1000044a5
00000001000042ba	pushq	%rbp
00000001000042bb	movq	%rsp, %rbp
00000001000042be	pushq	%r15
00000001000042c0	pushq	%r14
00000001000042c2	pushq	%r13
00000001000042c4	pushq	%r12
00000001000042c6	pushq	%rbx
00000001000042c7	pushq	%rax
00000001000042c8	movq	0x12db1(%rip), %r14
00000001000042cf	testq	%r14, %r14
00000001000042d2	je	0x100004497
00000001000042d8	movq	%rcx, %rbx
00000001000042db	shrq	$0x10, %rbx
00000001000042df	imulq	$0x1228, %rbx, %r15             ## imm = 0x1228
00000001000042e6	addq	%r15, %r14
00000001000042e9	movzbl	(%r14), %edx
00000001000042ed	cmpl	$0x2, %edx
00000001000042f0	je	0x10000439e
00000001000042f6	cmpl	$0x1, %edx
00000001000042f9	jne	0x100004497
00000001000042ff	movzbl	0x1(%r14), %eax
0000000100004304	movzbl	0x2(%r14), %r8d
0000000100004309	imulq	$0x3c0, %rax, %r9               ## imm = 0x3C0
0000000100004310	movl	0x8(%r14), %esi
0000000100004314	movzwl	%di, %eax
0000000100004317	xorl	%edx, %edx
0000000100004319	divl	%esi
000000010000431b	movq	$-0x2, %rdx
0000000100004322	movl	%eax, %ecx
0000000100004324	rolq	%cl, %rdx
0000000100004327	leaq	_fwp_gc(%rip), %r15
000000010000432e	addq	%r9, %r15
0000000100004331	movl	%eax, %ecx
0000000100004333	shrl	$0x3, %ecx
0000000100004336	andl	$0x1ff8, %ecx                   ## imm = 0x1FF8
000000010000433c	andq	%rdx, 0x28(%r14,%rcx)
0000000100004341	leaq	(%r8,%r8,2), %r12
0000000100004345	leaq	(%r14,%rax), %rbx
0000000100004349	addq	$0x228, %rbx                    ## imm = 0x228
0000000100004350	cmpb	$-0x1, 0x228(%r14,%rax)
0000000100004359	je	0x1000044a6
000000010000435f	leaq	(%r15,%r12,8), %r15
0000000100004363	addq	$0x8, %r15
0000000100004367	movb	$0x0, (%rbx)
000000010000436a	cmpl	$0x0, 0x12c9b(%rip)
0000000100004371	je	0x100004384
0000000100004373	movl	%esi, %esi
0000000100004375	movq	%rdi, %rbx
0000000100004378	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000437d	movq	%rbx, %rdi
0000000100004380	movl	0x8(%r14), %esi
0000000100004384	movq	(%r15), %rax
0000000100004387	notq	%rax
000000010000438a	movq	%rax, (%rdi)
000000010000438d	movq	%rdi, (%r15)
0000000100004390	movl	%esi, %eax
0000000100004392	addq	%rax, _fwp_gc(%rip)
0000000100004399	jmp	0x100004497
000000010000439e	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
00000001000043a5	addq	%rcx, %rax
00000001000043a8	cmpq	%rdi, %rax
00000001000043ab	jne	0x100004497
00000001000043b1	movq	0x18(%r14), %rax
00000001000043b5	addq	%rax, _fwp_gc(%rip)
00000001000043bc	movb	$0x0, 0x3(%r14)
00000001000043c1	cmpb	$-0x1, 0x228(%r14)
00000001000043c9	je	0x1000044bd
00000001000043cf	movb	$0x0, 0x228(%r14)
00000001000043d7	movl	0x10(%r14), %eax
00000001000043db	testq	%rax, %rax
00000001000043de	je	0x100004470
00000001000043e4	movq	0x12c95(%rip), %rcx
00000001000043eb	movl	%eax, %edx
00000001000043ed	andl	$0x3, %edx
00000001000043f0	cmpl	$0x4, %eax
00000001000043f3	jae	0x1000043f9
00000001000043f5	xorl	%esi, %esi
00000001000043f7	jmp	0x100004438
00000001000043f9	leaq	(%rcx,%r15), %rdi
00000001000043fd	movl	%eax, %r8d
0000000100004400	andl	$-0x4, %r8d
0000000100004404	xorl	%esi, %esi
0000000100004406	nopw	%cs:(%rax,%rax)
0000000100004410	movb	$0x0, (%rdi)
0000000100004413	movb	$0x0, 0x1228(%rdi)
000000010000441a	movb	$0x0, 0x2450(%rdi)
0000000100004421	movb	$0x0, 0x3678(%rdi)
0000000100004428	addq	$0x4, %rsi
000000010000442c	addq	$0x48a0, %rdi                   ## imm = 0x48A0
0000000100004433	cmpq	%rsi, %r8
0000000100004436	jne	0x100004410
0000000100004438	testq	%rdx, %rdx
000000010000443b	je	0x100004470
000000010000443d	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100004444	addq	%r15, %rsi
0000000100004447	addq	%rsi, %rcx
000000010000444a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004451	xorl	%esi, %esi
0000000100004453	nopw	%cs:(%rax,%rax)
0000000100004460	movb	$0x0, (%rcx,%rsi)
0000000100004464	addq	$0x1228, %rsi                   ## imm = 0x1228
000000010000446b	cmpq	%rsi, %rdx
000000010000446e	jne	0x100004460
0000000100004470	addq	%rax, 0x12d71(%rip)
0000000100004477	cmpq	0x12bfa(%rip), %rbx
000000010000447e	jae	0x100004487
0000000100004480	movq	%rbx, 0x12bf1(%rip)
0000000100004487	cmpq	0x12be2(%rip), %rbx
000000010000448e	jae	0x100004497
0000000100004490	movq	%rbx, 0x12bd9(%rip)
0000000100004497	addq	$0x8, %rsp
000000010000449b	popq	%rbx
000000010000449c	popq	%r12
000000010000449e	popq	%r13
00000001000044a0	popq	%r14
00000001000044a2	popq	%r15
00000001000044a4	popq	%rbp
00000001000044a5	retq
00000001000044a6	movq	%rdi, %r13
00000001000044a9	movq	%rbx, %rdi
00000001000044ac	callq	_fwp_rc_forget_slot
00000001000044b1	movq	%r13, %rdi
00000001000044b4	movl	0x8(%r14), %esi
00000001000044b8	jmp	0x10000435f
00000001000044bd	leaq	0x228(%r14), %rdi
00000001000044c4	callq	_fwp_rc_forget_slot
00000001000044c9	jmp	0x1000043cf
00000001000044ce	nop
_fwp_owner_release54:
00000001000044d0	pushq	%rbp
00000001000044d1	movq	%rsp, %rbp
00000001000044d4	movq	(%rdi), %rdi
00000001000044d7	popq	%rbp
00000001000044d8	jmp	_fwp_drop2
00000001000044dd	nopl	(%rax)
_fwp_owner_release55:
00000001000044e0	pushq	%rbp
00000001000044e1	movq	%rsp, %rbp
00000001000044e4	movq	(%rdi), %rdi
00000001000044e7	popq	%rbp
00000001000044e8	jmp	_fwp_drop2
00000001000044ed	nopl	(%rax)
_fwp_owner_release56:
00000001000044f0	pushq	%rbp
00000001000044f1	movq	%rsp, %rbp
00000001000044f4	movq	(%rdi), %rdi
00000001000044f7	popq	%rbp
00000001000044f8	jmp	_fwp_drop2
00000001000044fd	nopl	(%rax)
_fwp_owner_release57:
0000000100004500	pushq	%rbp
0000000100004501	movq	%rsp, %rbp
0000000100004504	movq	(%rdi), %rdi
0000000100004507	popq	%rbp
0000000100004508	jmp	_fwp_drop2
000000010000450d	nopl	(%rax)
_fwp_owner_release58:
0000000100004510	pushq	%rbp
0000000100004511	movq	%rsp, %rbp
0000000100004514	pushq	%rbx
0000000100004515	pushq	%rax
0000000100004516	movq	%rdi, %rbx
0000000100004519	movq	(%rdi), %rdi
000000010000451c	callq	_fwp_drop2
0000000100004521	movq	0x8(%rbx), %rdi
0000000100004525	addq	$0x8, %rsp
0000000100004529	popq	%rbx
000000010000452a	popq	%rbp
000000010000452b	jmp	_fwp_drop2
_fwp_owner_release61:
0000000100004530	pushq	%rbp
0000000100004531	movq	%rsp, %rbp
0000000100004534	movq	(%rdi), %rdi
0000000100004537	popq	%rbp
0000000100004538	jmp	_fwp_drop2
000000010000453d	nopl	(%rax)
_fwp_owner_release62:
0000000100004540	pushq	%rbp
0000000100004541	movq	%rsp, %rbp
0000000100004544	movq	(%rdi), %rdi
0000000100004547	popq	%rbp
0000000100004548	jmp	_fwp_drop2
000000010000454d	nopl	(%rax)
_fwp_owner_release63:
0000000100004550	pushq	%rbp
0000000100004551	movq	%rsp, %rbp
0000000100004554	movq	(%rdi), %rdi
0000000100004557	popq	%rbp
0000000100004558	jmp	_fwp_drop2
000000010000455d	nopl	(%rax)
_fwp_owner_release64:
0000000100004560	pushq	%rbp
0000000100004561	movq	%rsp, %rbp
0000000100004564	movq	(%rdi), %rdi
0000000100004567	popq	%rbp
0000000100004568	jmp	_fwp_drop2
000000010000456d	nopl	(%rax)
_fwp_owner_release65:
0000000100004570	pushq	%rbp
0000000100004571	movq	%rsp, %rbp
0000000100004574	movq	(%rdi), %rdi
0000000100004577	popq	%rbp
0000000100004578	jmp	_fwp_drop2
000000010000457d	nopl	(%rax)
_fwp_p_array_get_typed:
0000000100004580	testq	%rdi, %rdi
0000000100004583	js	0x1000045c3
0000000100004585	movq	(%rsi), %rcx
0000000100004588	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100004592	andq	%rcx, %rax
0000000100004595	cmpq	%rdi, %rax
0000000100004598	jbe	0x1000045c3
000000010000459a	movl	$0x8, %eax
000000010000459f	testq	%rdx, %rdx
00000001000045a2	je	0x1000045b8
00000001000045a4	movl	(%rdx), %r8d
00000001000045a7	cmpq	$0xa, %r8
00000001000045ab	ja	0x1000045b8
00000001000045ad	leaq	0xeba4(%rip), %rax
00000001000045b4	movq	(%rax,%r8,8), %rax
00000001000045b8	testq	%rcx, %rcx
00000001000045bb	js	0x1000045c6
00000001000045bd	leaq	0x8(%rsi), %rcx
00000001000045c1	jmp	0x1000045ca
00000001000045c3	xorl	%eax, %eax
00000001000045c5	retq
00000001000045c6	movq	0x10(%rsi), %rcx
00000001000045ca	pushq	%rbp
00000001000045cb	movq	%rsp, %rbp
00000001000045ce	pushq	%r15
00000001000045d0	pushq	%r14
00000001000045d2	pushq	%rbx
00000001000045d3	pushq	%rax
00000001000045d4	imulq	%rax, %rdi
00000001000045d8	cmpq	$0x1, %rax
00000001000045dc	movq	%rsi, %r14
00000001000045df	je	0x100004600
00000001000045e1	cmpq	$0x2, %rax
00000001000045e5	je	0x1000045f3
00000001000045e7	cmpq	$0x8, %rax
00000001000045eb	jne	0x10000460d
00000001000045ed	movq	(%rcx,%rdi), %rbx
00000001000045f1	jmp	0x10000461a
00000001000045f3	cmpl	$0x1, (%rdx)
00000001000045f6	movzwl	(%rcx,%rdi), %eax
00000001000045fa	movswq	%ax, %rbx
00000001000045fe	jmp	0x100004616
0000000100004600	cmpl	$0x0, (%rdx)
0000000100004603	movzbl	(%rcx,%rdi), %eax
0000000100004607	movsbq	%al, %rbx
000000010000460b	jmp	0x100004616
000000010000460d	cmpl	$0x2, (%rdx)
0000000100004610	movl	(%rcx,%rdi), %eax
0000000100004613	movslq	%eax, %rbx
0000000100004616	cmovneq	%rax, %rbx
000000010000461a	movq	%rbx, -0x20(%rbp)
000000010000461e	movl	$0x10, %edi
0000000100004623	callq	_fwp_alloc_init
0000000100004628	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100004632	movq	%rcx, (%rax)
0000000100004635	movq	%rbx, 0x8(%rax)
0000000100004639	leaq	-0x20(%rbp), %rcx
000000010000463d	movq	%rax, %rdx
0000000100004640	subq	0x129f1(%rip), %rdx
0000000100004647	movq	0x12a12(%rip), %rcx
000000010000464e	shlq	$0x10, %rcx
0000000100004652	cmpq	%rcx, %rdx
0000000100004655	movq	%r14, %rcx
0000000100004658	jae	0x1000046d3
000000010000465a	movq	0x12a1f(%rip), %rsi
0000000100004661	movq	%rdx, %rdi
0000000100004664	shrq	$0x10, %rdi
0000000100004668	imulq	$0x1228, %rdi, %rdi             ## imm = 0x1228
000000010000466f	leaq	(%rsi,%rdi), %rbx
0000000100004673	movzbl	(%rsi,%rdi), %esi
0000000100004677	cmpb	$0x2, %sil
000000010000467b	setne	%dil
000000010000467f	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100004686	setne	%r8b
000000010000468a	orb	%dil, %r8b
000000010000468d	jne	0x1000046a0
000000010000468f	addq	$0x228, %rbx                    ## imm = 0x228
0000000100004696	cmpb	$-0x1, (%rbx)
0000000100004699	je	0x1000046c0
000000010000469b	movb	$0x1, (%rbx)
000000010000469e	jmp	0x1000046d3
00000001000046a0	cmpb	$0x1, %sil
00000001000046a4	jne	0x1000046d3
00000001000046a6	movl	0x20(%rbx), %esi
00000001000046a9	imulq	%rsi, %rdx
00000001000046ad	shrq	$0x20, %rdx
00000001000046b1	addq	%rdx, %rbx
00000001000046b4	addq	$0x228, %rbx                    ## imm = 0x228
00000001000046bb	cmpb	$-0x1, (%rbx)
00000001000046be	jne	0x10000469b
00000001000046c0	movq	%rbx, %rdi
00000001000046c3	movq	%rax, %r15
00000001000046c6	callq	_fwp_rc_forget_slot
00000001000046cb	movq	%r15, %rax
00000001000046ce	movq	%r14, %rcx
00000001000046d1	jmp	0x10000469b
00000001000046d3	addq	$0x8, %rsp
00000001000046d7	popq	%rbx
00000001000046d8	popq	%r14
00000001000046da	popq	%r15
00000001000046dc	popq	%rbp
00000001000046dd	retq
00000001000046de	nop
_fwp_data:
00000001000046e0	pushq	%rbp
00000001000046e1	movq	%rsp, %rbp
00000001000046e4	pushq	%r15
00000001000046e6	pushq	%r14
00000001000046e8	pushq	%r12
00000001000046ea	pushq	%rbx
00000001000046eb	movl	%edi, %r14d
00000001000046ee	testl	%esi, %esi
00000001000046f0	je	0x100004792
00000001000046f6	movq	%rdx, %rbx
00000001000046f9	movl	%esi, %r15d
00000001000046fc	leaq	0x8(,%r15,8), %rdi
0000000100004704	movl	%esi, %r12d
0000000100004707	callq	_fwp_alloc_init
000000010000470c	movl	%r14d, (%rax)
000000010000470f	movl	%r12d, 0x4(%rax)
0000000100004713	cmpl	$0x7, %r12d
0000000100004717	jbe	0x100004729
0000000100004719	movq	%rax, %rcx
000000010000471c	subq	%rbx, %rcx
000000010000471f	addq	$0x8, %rcx
0000000100004723	cmpq	$0x20, %rcx
0000000100004727	jae	0x100004797
0000000100004729	xorl	%ecx, %ecx
000000010000472b	movq	%r15, %rsi
000000010000472e	movq	%rcx, %rdx
0000000100004731	andq	$0x3, %rsi
0000000100004735	je	0x100004751
0000000100004737	movq	%rcx, %rdx
000000010000473a	nopw	(%rax,%rax)
0000000100004740	movq	(%rbx,%rdx,8), %rdi
0000000100004744	movq	%rdi, 0x8(%rax,%rdx,8)
0000000100004749	incq	%rdx
000000010000474c	decq	%rsi
000000010000474f	jne	0x100004740
0000000100004751	subq	%r15, %rcx
0000000100004754	cmpq	$-0x4, %rcx
0000000100004758	ja	0x1000047d5
000000010000475a	nopw	(%rax,%rax)
0000000100004760	movq	(%rbx,%rdx,8), %rcx
0000000100004764	movq	%rcx, 0x8(%rax,%rdx,8)
0000000100004769	movq	0x8(%rbx,%rdx,8), %rcx
000000010000476e	movq	%rcx, 0x10(%rax,%rdx,8)
0000000100004773	movq	0x10(%rbx,%rdx,8), %rcx
0000000100004778	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000477d	movq	0x18(%rbx,%rdx,8), %rcx
0000000100004782	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100004787	addq	$0x4, %rdx
000000010000478b	cmpq	%rdx, %r15
000000010000478e	jne	0x100004760
0000000100004790	jmp	0x1000047d5
0000000100004792	movl	%r14d, %eax
0000000100004795	jmp	0x1000047d5
0000000100004797	movl	%r15d, %ecx
000000010000479a	andl	$-0x4, %ecx
000000010000479d	leaq	(,%r15,8), %rdx
00000001000047a5	andq	$-0x20, %rdx
00000001000047a9	xorl	%esi, %esi
00000001000047ab	nopl	(%rax,%rax)
00000001000047b0	movups	(%rbx,%rsi), %xmm0
00000001000047b4	movups	0x10(%rbx,%rsi), %xmm1
00000001000047b9	movups	%xmm0, 0x8(%rax,%rsi)
00000001000047be	movups	%xmm1, 0x18(%rax,%rsi)
00000001000047c3	addq	$0x20, %rsi
00000001000047c7	cmpq	%rsi, %rdx
00000001000047ca	jne	0x1000047b0
00000001000047cc	cmpl	%r15d, %ecx
00000001000047cf	jne	0x10000472b
00000001000047d5	popq	%rbx
00000001000047d6	popq	%r12
00000001000047d8	popq	%r14
00000001000047da	popq	%r15
00000001000047dc	popq	%rbp
00000001000047dd	retq
00000001000047de	nop
_fwp_alloc_init:
00000001000047e0	pushq	%rbp
00000001000047e1	movq	%rsp, %rbp
00000001000047e4	pushq	%rbx
00000001000047e5	pushq	%rax
00000001000047e6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
00000001000047ed	ja	0x1000048dd
00000001000047f3	leaq	0xf(%rdi), %rdx
00000001000047f7	shrq	$0x4, %rdx
00000001000047fb	leaq	_fwp_gc(%rip), %rax
0000000100004802	movzbl	0xbe8(%rdx,%rax), %ecx
000000010000480a	movl	0xb48(%rax,%rcx,4), %esi
0000000100004811	movq	_fwp_gc(%rip), %r8
0000000100004818	movq	%r8, %r9
000000010000481b	subq	%rsi, %r9
000000010000481e	movq	%r9, _fwp_gc(%rip)
0000000100004825	js	0x1000048dd
000000010000482b	leaq	(%rcx,%rcx,2), %r9
000000010000482f	leaq	(%rax,%r9,8), %r9
0000000100004833	addq	$0x8, %r9
0000000100004837	movq	(%r9), %rbx
000000010000483a	testq	%rbx, %rbx
000000010000483d	je	0x100004874
000000010000483f	movq	(%rbx), %rax
0000000100004842	notq	%rax
0000000100004845	movq	%rax, (%r9)
0000000100004848	andl	$0x7ff8, %edi                   ## imm = 0x7FF8
000000010000484e	cmpq	%rsi, %rdi
0000000100004851	jae	0x1000048fa
0000000100004857	leaq	(%rbx,%rdi), %rax
000000010000485b	notq	%rdi
000000010000485e	addq	%rsi, %rdi
0000000100004861	andq	$-0x8, %rdi
0000000100004865	addq	$0x8, %rdi
0000000100004869	movq	%rdi, %rsi
000000010000486c	movq	%rax, %rdi
000000010000486f	jmp	0x1000048f5
0000000100004874	movq	0x8(%r9), %rbx
0000000100004878	movq	0x10(%r9), %r10
000000010000487c	subq	%rbx, %r10
000000010000487f	cmpq	%rsi, %r10
0000000100004882	jb	0x1000048ac
0000000100004884	leaq	(%rbx,%rsi), %rcx
0000000100004888	movq	%rcx, 0x8(%r9)
000000010000488c	testq	%rbx, %rbx
000000010000488f	jne	0x100004848
0000000100004891	movzbl	0xbe8(%rdx,%rax), %ecx
0000000100004899	movl	0xb48(%rax,%rcx,4), %esi
00000001000048a0	subq	%rsi, %r8
00000001000048a3	movq	%r8, _fwp_gc(%rip)
00000001000048aa	js	0x1000048dd
00000001000048ac	leaq	(%rcx,%rcx,2), %rdx
00000001000048b0	leaq	(%rax,%rdx,8), %rcx
00000001000048b4	addq	$0x8, %rcx
00000001000048b8	movq	0x8(%rax,%rdx,8), %rbx
00000001000048bd	testq	%rbx, %rbx
00000001000048c0	je	0x1000048cd
00000001000048c2	movq	(%rbx), %rax
00000001000048c5	notq	%rax
00000001000048c8	movq	%rax, (%rcx)
00000001000048cb	jmp	0x1000048f2
00000001000048cd	movq	0x8(%rcx), %rbx
00000001000048d1	movq	0x10(%rcx), %rax
00000001000048d5	subq	%rbx, %rax
00000001000048d8	cmpq	%rsi, %rax
00000001000048db	jae	0x1000048ea
00000001000048dd	xorl	%esi, %esi
00000001000048df	addq	$0x8, %rsp
00000001000048e3	popq	%rbx
00000001000048e4	popq	%rbp
00000001000048e5	jmp	_fwp_gc_alloc_slow
00000001000048ea	leaq	(%rbx,%rsi), %rax
00000001000048ee	movq	%rax, 0x8(%rcx)
00000001000048f2	movq	%rbx, %rdi
00000001000048f5	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000048fa	movq	%rbx, %rax
00000001000048fd	addq	$0x8, %rsp
0000000100004901	popq	%rbx
0000000100004902	popq	%rbp
0000000100004903	retq
0000000100004904	nopw	%cs:(%rax,%rax)
_fwp_gc_alloc_slow:
0000000100004910	pushq	%rbp
0000000100004911	movq	%rsp, %rbp
0000000100004914	pushq	%r15
0000000100004916	pushq	%r14
0000000100004918	pushq	%r13
000000010000491a	pushq	%r12
000000010000491c	pushq	%rbx
000000010000491d	pushq	%rax
000000010000491e	movl	%esi, %r14d
0000000100004921	movq	%rdi, %rbx
0000000100004924	cmpl	$0x0, 0x126c9(%rip)
000000010000492b	je	0x10000494f
000000010000492d	cmpq	$0x4001, %rbx                   ## imm = 0x4001
0000000100004934	jb	0x10000495d
0000000100004936	movq	%rbx, %rdi
0000000100004939	movl	%r14d, %esi
000000010000493c	addq	$0x8, %rsp
0000000100004940	popq	%rbx
0000000100004941	popq	%r12
0000000100004943	popq	%r13
0000000100004945	popq	%r14
0000000100004947	popq	%r15
0000000100004949	popq	%rbp
000000010000494a	jmp	_fwp_gc_alloc_big
000000010000494f	callq	_fwp_gc_init
0000000100004954	cmpq	$0x4001, %rbx                   ## imm = 0x4001
000000010000495b	jae	0x100004936
000000010000495d	leaq	0xf(%rbx), %rax
0000000100004961	shrq	$0x4, %rax
0000000100004965	leaq	_fwp_gc(%rip), %r12
000000010000496c	movzbl	0xbe8(%rax,%r12), %r13d
0000000100004975	movl	0xb48(%r12,%r13,4), %r15d
000000010000497d	cmpq	$0x0, _fwp_gc(%rip)
0000000100004985	jns	0x10000498c
0000000100004987	callq	_fwp_gc_spent
000000010000498c	movl	%r14d, %eax
000000010000498f	imulq	$0x3c0, %rax, %rax              ## imm = 0x3C0
0000000100004996	addq	%rax, %r12
0000000100004999	leaq	(,%r13,2), %rax
00000001000049a1	addq	%r13, %rax
00000001000049a4	leaq	(%r12,%rax,8), %rdi
00000001000049a8	addq	$0x8, %rdi
00000001000049ac	movq	0x8(%r12,%rax,8), %r12
00000001000049b1	testq	%r12, %r12
00000001000049b4	je	0x1000049c2
00000001000049b6	movq	(%r12), %rax
00000001000049ba	notq	%rax
00000001000049bd	movq	%rax, (%rdi)
00000001000049c0	jmp	0x1000049ea
00000001000049c2	movq	0x8(%rdi), %r12
00000001000049c6	movq	0x10(%rdi), %rax
00000001000049ca	subq	%r12, %rax
00000001000049cd	cmpq	%r15, %rax
00000001000049d0	jae	0x1000049e2
00000001000049d2	movl	%r13d, %esi
00000001000049d5	movl	%r14d, %edx
00000001000049d8	callq	_fwp_gc_refill
00000001000049dd	movq	%rax, %r12
00000001000049e0	jmp	0x1000049ea
00000001000049e2	leaq	(%r12,%r15), %rax
00000001000049e6	movq	%rax, 0x8(%rdi)
00000001000049ea	cmpl	$0x1, %r14d
00000001000049ee	cmoveq	%rbx, %r15
00000001000049f2	movq	%r12, %rdi
00000001000049f5	movq	%r15, %rsi
00000001000049f8	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000049fd	movq	%r12, %rax
0000000100004a00	addq	$0x8, %rsp
0000000100004a04	popq	%rbx
0000000100004a05	popq	%r12
0000000100004a07	popq	%r13
0000000100004a09	popq	%r14
0000000100004a0b	popq	%r15
0000000100004a0d	popq	%rbp
0000000100004a0e	retq
0000000100004a0f	nop
_fwp_gc_init:
0000000100004a10	pushq	%rbp
0000000100004a11	movq	%rsp, %rbp
0000000100004a14	pushq	%r14
0000000100004a16	pushq	%rbx
0000000100004a17	movl	$0x1, 0x125d3(%rip)
0000000100004a21	movaps	0xe358(%rip), %xmm0
0000000100004a28	movups	%xmm0, 0x12121(%rip)
0000000100004a2f	movaps	0xe35a(%rip), %xmm0
0000000100004a36	movups	%xmm0, 0x12123(%rip)
0000000100004a3d	movaps	0xe35c(%rip), %xmm0
0000000100004a44	movups	%xmm0, 0x12125(%rip)
0000000100004a4b	movaps	0xe35e(%rip), %xmm0
0000000100004a52	movups	%xmm0, 0x12127(%rip)
0000000100004a59	movaps	0xe360(%rip), %xmm0
0000000100004a60	movups	%xmm0, 0x12129(%rip)
0000000100004a67	movaps	0xe362(%rip), %xmm0
0000000100004a6e	movups	%xmm0, 0x1212b(%rip)
0000000100004a75	movaps	0xe364(%rip), %xmm0
0000000100004a7c	movups	%xmm0, 0x1212d(%rip)
0000000100004a83	movaps	0xe366(%rip), %xmm0
0000000100004a8a	movups	%xmm0, 0x1212f(%rip)
0000000100004a91	movaps	0xe368(%rip), %xmm0
0000000100004a98	movups	%xmm0, 0x12131(%rip)
0000000100004a9f	movaps	0xe36a(%rip), %xmm0
0000000100004aa6	movups	%xmm0, 0x12133(%rip)
0000000100004aad	xorl	%ecx, %ecx
0000000100004aaf	leaq	_fwp_gc(%rip), %rax
0000000100004ab6	xorl	%edx, %edx
0000000100004ab8	nopl	(%rax,%rax)
0000000100004ac0	movl	%edx, %esi
0000000100004ac2	shll	$0x4, %esi
0000000100004ac5	decq	%rcx
0000000100004ac8	movq	%rcx, %rdi
0000000100004acb	nopl	(%rax,%rax)
0000000100004ad0	movq	%rdi, %rcx
0000000100004ad3	incq	%rdi
0000000100004ad6	cmpl	0xb4c(%rax,%rcx,4), %esi
0000000100004add	ja	0x100004ad0
0000000100004adf	movb	%dil, 0xbe8(%rdx,%rax)
0000000100004ae7	cmpq	$0x400, %rdx                    ## imm = 0x400
0000000100004aee	je	0x100004b1d
0000000100004af0	movq	%rdx, %rsi
0000000100004af3	orq	$0x1, %rsi
0000000100004af7	movl	%esi, %edi
0000000100004af9	shll	$0x4, %edi
0000000100004afc	nopl	(%rax)
0000000100004b00	movq	%rcx, %r8
0000000100004b03	incq	%rcx
0000000100004b06	cmpl	0xb4c(%rax,%r8,4), %edi
0000000100004b0e	ja	0x100004b00
0000000100004b10	movb	%cl, 0xbe8(%rsi,%rax)
0000000100004b17	addq	$0x2, %rdx
0000000100004b1b	jmp	0x100004ac0
0000000100004b1d	movabsq	$0x1000000000, %rbx             ## imm = 0x1000000000
0000000100004b27	leaq	0x10000(%rbx), %rsi
0000000100004b2e	xorl	%edi, %edi
0000000100004b30	xorl	%edx, %edx
0000000100004b32	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004b37	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004b3d	xorl	%r9d, %r9d
0000000100004b40	callq	0x100012cba                     ## symbol stub for: _mmap
0000000100004b45	cmpq	$-0x1, %rax
0000000100004b49	jne	0x100004bab
0000000100004b4b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100004b55	leaq	0x10000(%rbx), %rsi
0000000100004b5c	xorl	%edi, %edi
0000000100004b5e	xorl	%edx, %edx
0000000100004b60	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004b65	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004b6b	xorl	%r9d, %r9d
0000000100004b6e	callq	0x100012cba                     ## symbol stub for: _mmap
0000000100004b73	cmpq	$-0x1, %rax
0000000100004b77	jne	0x100004bab
0000000100004b79	movabsq	$__mh_execute_header, %rbx
0000000100004b83	leaq	0x10000(%rbx), %rsi
0000000100004b8a	xorl	%edi, %edi
0000000100004b8c	xorl	%edx, %edx
0000000100004b8e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004b93	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004b99	xorl	%r9d, %r9d
0000000100004b9c	callq	0x100012cba                     ## symbol stub for: _mmap
0000000100004ba1	cmpq	$-0x1, %rax
0000000100004ba5	je	0x100004d5d
0000000100004bab	testq	%rax, %rax
0000000100004bae	je	0x100004dbe
0000000100004bb4	movq	%rax, 0x12485(%rip)
0000000100004bbb	movq	%rbx, %rcx
0000000100004bbe	orq	$0x10000, %rcx                  ## imm = 0x10000
0000000100004bc5	movq	%rcx, 0x1247c(%rip)
0000000100004bcc	addq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100004bd2	andq	$-0x10000, %rax                 ## imm = 0xFFFF0000
0000000100004bd8	movq	%rax, 0x12459(%rip)
0000000100004bdf	shrq	$0x10, %rbx
0000000100004be3	movq	%rbx, 0x1246e(%rip)
0000000100004bea	imulq	$0x1228, %rbx, %rsi             ## imm = 0x1228
0000000100004bf1	movq	%rsi, 0x12490(%rip)
0000000100004bf8	xorl	%edi, %edi
0000000100004bfa	xorl	%edx, %edx
0000000100004bfc	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004c01	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004c07	xorl	%r9d, %r9d
0000000100004c0a	callq	0x100012cba                     ## symbol stub for: _mmap
0000000100004c0f	cmpq	$-0x1, %rax
0000000100004c13	je	0x100004dbe
0000000100004c19	movq	%rax, 0x12460(%rip)
0000000100004c20	leaq	0xe881(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100004c27	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100004c2c	movl	$0x1, %r14d
0000000100004c32	testq	%rax, %rax
0000000100004c35	je	0x100004c62
0000000100004c37	movq	%rax, %rbx
0000000100004c3a	leaq	0xe86e(%rip), %rsi              ## literal pool for: "off"
0000000100004c41	movq	%rax, %rdi
0000000100004c44	callq	0x100012d20                     ## symbol stub for: _strcmp
0000000100004c49	testl	%eax, %eax
0000000100004c4b	je	0x100004c5f
0000000100004c4d	cmpb	$0x30, (%rbx)
0000000100004c50	jne	0x100004c62
0000000100004c52	xorl	%r14d, %r14d
0000000100004c55	cmpb	$0x0, 0x1(%rbx)
0000000100004c59	setne	%r14b
0000000100004c5d	jmp	0x100004c62
0000000100004c5f	xorl	%r14d, %r14d
0000000100004c62	movl	%r14d, 0x1238f(%rip)
0000000100004c69	leaq	0xe843(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100004c70	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100004c75	testq	%rax, %rax
0000000100004c78	je	0x100004c91
0000000100004c7a	movzbl	(%rax), %ecx
0000000100004c7d	testl	%ecx, %ecx
0000000100004c7f	je	0x100004c9a
0000000100004c81	cmpl	$0x30, %ecx
0000000100004c84	jne	0x100004c95
0000000100004c86	xorl	%ecx, %ecx
0000000100004c88	cmpb	$0x0, 0x1(%rax)
0000000100004c8c	setne	%cl
0000000100004c8f	jmp	0x100004c9a
0000000100004c91	xorl	%ecx, %ecx
0000000100004c93	jmp	0x100004c9a
0000000100004c95	movl	$0x1, %ecx
0000000100004c9a	movl	%ecx, 0x12364(%rip)
0000000100004ca0	leaq	0xe801(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100004ca7	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100004cac	testq	%rax, %rax
0000000100004caf	je	0x100004cc9
0000000100004cb1	leaq	0xe808(%rip), %rsi              ## literal pool for: "full"
0000000100004cb8	movq	%rax, %rdi
0000000100004cbb	callq	0x100012d20                     ## symbol stub for: _strcmp
0000000100004cc0	xorl	%ecx, %ecx
0000000100004cc2	testl	%eax, %eax
0000000100004cc4	setne	%cl
0000000100004cc7	jmp	0x100004cce
0000000100004cc9	movl	$0x1, %ecx
0000000100004cce	movl	%ecx, 0x12334(%rip)
0000000100004cd4	movl	$0x1, 0x12332(%rip)
0000000100004cde	leaq	0xe7e0(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
0000000100004ce5	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100004cea	testq	%rax, %rax
0000000100004ced	je	0x100004d06
0000000100004cef	movzbl	(%rax), %ecx
0000000100004cf2	testl	%ecx, %ecx
0000000100004cf4	je	0x100004d0f
0000000100004cf6	cmpl	$0x30, %ecx
0000000100004cf9	jne	0x100004d0a
0000000100004cfb	xorl	%ecx, %ecx
0000000100004cfd	cmpb	$0x0, 0x1(%rax)
0000000100004d01	setne	%cl
0000000100004d04	jmp	0x100004d0f
0000000100004d06	xorl	%ecx, %ecx
0000000100004d08	jmp	0x100004d0f
0000000100004d0a	movl	$0x1, %ecx
0000000100004d0f	movl	%ecx, 0x122f7(%rip)
0000000100004d15	leaq	0xe7b7(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
0000000100004d1c	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100004d21	testq	%rax, %rax
0000000100004d24	je	0x100004d30
0000000100004d26	movq	%rax, %rdi
0000000100004d29	callq	0x100012c3c                     ## symbol stub for: _atol
0000000100004d2e	jmp	0x100004d32
0000000100004d30	xorl	%eax, %eax
0000000100004d32	xorl	%ecx, %ecx
0000000100004d34	testq	%rax, %rax
0000000100004d37	cmovgq	%rax, %rcx
0000000100004d3b	movq	%rcx, 0x122e6(%rip)
0000000100004d42	movq	$0x800000, 0x124cb(%rip)        ## imm = 0x800000
0000000100004d4d	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
0000000100004d58	popq	%rbx
0000000100004d59	popq	%r14
0000000100004d5b	popq	%rbp
0000000100004d5c	retq
0000000100004d5d	movl	$0x40010000, %esi               ## imm = 0x40010000
0000000100004d62	xorl	%edi, %edi
0000000100004d64	xorl	%edx, %edx
0000000100004d66	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004d6b	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004d71	xorl	%r9d, %r9d
0000000100004d74	callq	0x100012cba                     ## symbol stub for: _mmap
0000000100004d79	cmpq	$-0x1, %rax
0000000100004d7d	je	0x100004d8e
0000000100004d7f	testq	%rax, %rax
0000000100004d82	je	0x100004dbe
0000000100004d84	movl	$0x40000000, %ebx               ## imm = 0x40000000
0000000100004d89	jmp	0x100004bb4
0000000100004d8e	movl	$0x10010000, %esi               ## imm = 0x10010000
0000000100004d93	xorl	%edi, %edi
0000000100004d95	xorl	%edx, %edx
0000000100004d97	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100004d9c	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100004da2	xorl	%r9d, %r9d
0000000100004da5	callq	0x100012cba                     ## symbol stub for: _mmap
0000000100004daa	leaq	0x1(%rax), %rcx
0000000100004dae	cmpq	$0x2, %rcx
0000000100004db2	jb	0x100004dbe
0000000100004db4	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100004db9	jmp	0x100004bb4
0000000100004dbe	movq	0x10273(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100004dc5	movq	(%rax), %rcx
0000000100004dc8	leaq	0xe6af(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004dcf	movl	$0x13, %esi
0000000100004dd4	movl	$0x1, %edx
0000000100004dd9	callq	0x100012c78                     ## symbol stub for: _fwrite
0000000100004dde	movl	$0x66, %edi
0000000100004de3	callq	0x100012c48                     ## symbol stub for: _exit
0000000100004de8	nopl	(%rax,%rax)
_fwp_gc_alloc_big:
0000000100004df0	pushq	%rbp
0000000100004df1	movq	%rsp, %rbp
0000000100004df4	pushq	%r15
0000000100004df6	pushq	%r14
0000000100004df8	pushq	%r13
0000000100004dfa	pushq	%r12
0000000100004dfc	pushq	%rbx
0000000100004dfd	pushq	%rax
0000000100004dfe	movabsq	$0x4000000000000001, %rax       ## imm = 0x4000000000000001
0000000100004e08	cmpq	%rax, %rdi
0000000100004e0b	jae	0x100004fb7
0000000100004e11	movl	%esi, %r15d
0000000100004e14	movq	%rdi, %rbx
0000000100004e17	subq	%rdi, _fwp_gc(%rip)
0000000100004e1e	jns	0x100004e25
0000000100004e20	callq	_fwp_gc_spent
0000000100004e25	leaq	0xffff(%rbx), %r14
0000000100004e2c	shrq	$0x10, %r14
0000000100004e30	movq	%r14, %rdi
0000000100004e33	callq	_fwp_gc_chunks
0000000100004e38	movq	0x12241(%rip), %rcx
0000000100004e3f	imulq	$0x1228, %rax, %r12             ## imm = 0x1228
0000000100004e46	movb	$0x2, (%rcx,%r12)
0000000100004e4b	movb	%r15b, 0x1(%rcx,%r12)
0000000100004e50	movw	$0x100, 0x3(%rcx,%r12)          ## imm = 0x100
0000000100004e58	movl	%r14d, 0x10(%rcx,%r12)
0000000100004e5d	movq	%rbx, 0x18(%rcx,%r12)
0000000100004e62	leaq	(%rcx,%r12), %r15
0000000100004e66	addq	$0x228, %r15                    ## imm = 0x228
0000000100004e6d	cmpb	$-0x1, 0x228(%rcx,%r12)
0000000100004e76	je	0x100004fa4
0000000100004e7c	movb	$0x0, (%r15)
0000000100004e80	cmpq	$0x10001, %rbx                  ## imm = 0x10001
0000000100004e87	jb	0x100004f79
0000000100004e8d	movq	0x121ec(%rip), %rcx
0000000100004e94	cmpq	$0x3, %r14
0000000100004e98	movl	$0x2, %r8d
0000000100004e9e	cmovaeq	%r14, %r8
0000000100004ea2	leaq	-0x1(%r8), %rsi
0000000100004ea6	addq	$-0x2, %r8
0000000100004eaa	movl	%esi, %edx
0000000100004eac	andl	$0x3, %edx
0000000100004eaf	movl	$0x1, %edi
0000000100004eb4	cmpq	$0x3, %r8
0000000100004eb8	jb	0x100004f3b
0000000100004ebe	leaq	(%r12,%rcx), %r8
0000000100004ec2	addq	$0x48b0, %r8                    ## imm = 0x48B0
0000000100004ec9	andq	$-0x4, %rsi
0000000100004ecd	negq	%rsi
0000000100004ed0	movb	$0x3, -0x3688(%r8)
0000000100004ed8	movb	$0x1, -0x3684(%r8)
0000000100004ee0	movl	%eax, -0x3678(%r8)
0000000100004ee7	movb	$0x3, -0x2460(%r8)
0000000100004eef	movb	$0x1, -0x245c(%r8)
0000000100004ef7	movl	%eax, -0x2450(%r8)
0000000100004efe	movb	$0x3, -0x1238(%r8)
0000000100004f06	movb	$0x1, -0x1234(%r8)
0000000100004f0e	movl	%eax, -0x1228(%r8)
0000000100004f15	movb	$0x3, -0x10(%r8)
0000000100004f1a	movb	$0x1, -0xc(%r8)
0000000100004f1f	movl	%eax, (%r8)
0000000100004f22	addq	$0x48a0, %r8                    ## imm = 0x48A0
0000000100004f29	leaq	(%rsi,%rdi), %r9
0000000100004f2d	addq	$0x4, %r9
0000000100004f31	addq	$0x4, %rdi
0000000100004f35	cmpq	$0x1, %r9
0000000100004f39	jne	0x100004ed0
0000000100004f3b	testq	%rdx, %rdx
0000000100004f3e	je	0x100004f79
0000000100004f40	imulq	$0x1228, %rdi, %rsi             ## imm = 0x1228
0000000100004f47	addq	%rsi, %r12
0000000100004f4a	addq	%r12, %rcx
0000000100004f4d	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004f54	xorl	%esi, %esi
0000000100004f56	nopw	%cs:(%rax,%rax)
0000000100004f60	movb	$0x3, (%rcx,%rsi)
0000000100004f64	movb	$0x1, 0x4(%rcx,%rsi)
0000000100004f69	movl	%eax, 0x10(%rcx,%rsi)
0000000100004f6d	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100004f74	cmpq	%rsi, %rdx
0000000100004f77	jne	0x100004f60
0000000100004f79	shlq	$0x10, %rax
0000000100004f7d	addq	0x120b4(%rip), %rax
0000000100004f84	movq	%rax, %rdi
0000000100004f87	movq	%rbx, %rsi
0000000100004f8a	movq	%rax, %rbx
0000000100004f8d	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100004f92	movq	%rbx, %rax
0000000100004f95	addq	$0x8, %rsp
0000000100004f99	popq	%rbx
0000000100004f9a	popq	%r12
0000000100004f9c	popq	%r13
0000000100004f9e	popq	%r14
0000000100004fa0	popq	%r15
0000000100004fa2	popq	%rbp
0000000100004fa3	retq
0000000100004fa4	movq	%r15, %rdi
0000000100004fa7	movq	%rax, %r13
0000000100004faa	callq	_fwp_rc_forget_slot
0000000100004faf	movq	%r13, %rax
0000000100004fb2	jmp	0x100004e7c
0000000100004fb7	movq	0x1007a(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100004fbe	movq	(%rax), %rcx
0000000100004fc1	leaq	0xe4b6(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004fc8	movl	$0x13, %esi
0000000100004fcd	movl	$0x1, %edx
0000000100004fd2	callq	0x100012c78                     ## symbol stub for: _fwrite
0000000100004fd7	movl	$0x66, %edi
0000000100004fdc	callq	0x100012c48                     ## symbol stub for: _exit
0000000100004fe1	nopw	%cs:(%rax,%rax)
_fwp_gc_spent:
0000000100004ff0	pushq	%rbp
0000000100004ff1	movq	%rsp, %rbp
0000000100004ff4	cmpl	$0x0, 0x11ff9(%rip)
0000000100004ffb	jne	0x100005002
0000000100004ffd	callq	_fwp_gc_init
0000000100005002	movl	0x11ff4(%rip), %ecx
0000000100005008	testl	%ecx, %ecx
000000010000500a	setne	%dl
000000010000500d	movq	0x12014(%rip), %rax
0000000100005014	testq	%rax, %rax
0000000100005017	setne	%sil
000000010000501b	andb	%dl, %sil
000000010000501e	cmpb	$0x1, %sil
0000000100005022	jne	0x100005085
0000000100005024	movq	0x12005(%rip), %rcx
000000010000502b	incq	%rcx
000000010000502e	movq	%rcx, 0x11ffb(%rip)
0000000100005035	cmpq	%rax, %rcx
0000000100005038	jl	0x10000504a
000000010000503a	movq	$0x0, 0x11feb(%rip)
0000000100005045	callq	_fwp_gc_collect
000000010000504a	movq	0x121c7(%rip), %rax
0000000100005051	subq	_fwp_gc(%rip), %rax
0000000100005058	cvtsi2sd	%rax, %xmm0
000000010000505d	addsd	0x1218b(%rip), %xmm0
0000000100005065	movsd	%xmm0, 0x12183(%rip)
000000010000506d	movq	$0x0, 0x121a0(%rip)
0000000100005078	movq	$0x0, _fwp_gc(%rip)
0000000100005083	popq	%rbp
0000000100005084	retq
0000000100005085	testl	%ecx, %ecx
0000000100005087	je	0x10000508f
0000000100005089	popq	%rbp
000000010000508a	jmp	_fwp_gc_collect
000000010000508f	movq	0x12182(%rip), %rax
0000000100005096	subq	_fwp_gc(%rip), %rax
000000010000509d	cvtsi2sd	%rax, %xmm0
00000001000050a2	addsd	0x12146(%rip), %xmm0
00000001000050aa	movsd	%xmm0, 0x1213e(%rip)
00000001000050b2	movq	$0x800000, 0x1215b(%rip)        ## imm = 0x800000
00000001000050bd	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
00000001000050c8	popq	%rbp
00000001000050c9	retq
00000001000050ca	nopw	(%rax,%rax)
_fwp_gc_refill:
00000001000050d0	pushq	%rbp
00000001000050d1	movq	%rsp, %rbp
00000001000050d4	pushq	%r15
00000001000050d6	pushq	%r14
00000001000050d8	pushq	%r13
00000001000050da	pushq	%r12
00000001000050dc	pushq	%rbx
00000001000050dd	pushq	%rax
00000001000050de	movl	%edx, %r15d
00000001000050e1	movl	%esi, %r12d
00000001000050e4	movq	%rdi, %rbx
00000001000050e7	movl	$0x1, %edi
00000001000050ec	callq	_fwp_gc_chunks
00000001000050f1	movq	%rax, %r14
00000001000050f4	leaq	_fwp_gc(%rip), %rax
00000001000050fb	movq	0x11f7e(%rip), %rsi
0000000100005102	imulq	$0x1228, %r14, %rdi             ## imm = 0x1228
0000000100005109	leaq	(%rsi,%rdi), %r13
000000010000510d	movb	$0x1, (%rsi,%rdi)
0000000100005111	movb	%r15b, 0x1(%rsi,%rdi)
0000000100005116	movb	%r12b, 0x2(%rsi,%rdi)
000000010000511b	movb	$0x1, 0x4(%rsi,%rdi)
0000000100005120	movl	%r12d, %ecx
0000000100005123	movl	0xb48(%rax,%rcx,4), %ecx
000000010000512a	movl	%ecx, 0x8(%rsi,%rdi)
000000010000512e	movl	$0x10000, %eax                  ## imm = 0x10000
0000000100005133	xorl	%edx, %edx
0000000100005135	divl	%ecx
0000000100005137	movl	%eax, 0xc(%rsi,%rdi)
000000010000513b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100005140	addq	%rcx, %rax
0000000100005143	btq	$0x20, %rax
0000000100005148	jae	0x100005151
000000010000514a	xorl	%edx, %edx
000000010000514c	divq	%rcx
000000010000514f	jmp	0x100005155
0000000100005151	xorl	%edx, %edx
0000000100005153	divl	%ecx
0000000100005155	movl	%eax, 0x20(%r13)
0000000100005159	cmpq	$0x0, 0x128bf(%rip)
0000000100005161	je	0x10000518e
0000000100005163	leaq	0x228(%r13), %r15
000000010000516a	xorl	%r12d, %r12d
000000010000516d	jmp	0x10000517c
000000010000516f	nop
0000000100005170	incq	%r12
0000000100005173	cmpq	$0x1000, %r12                   ## imm = 0x1000
000000010000517a	je	0x10000518e
000000010000517c	cmpb	$-0x1, (%r15,%r12)
0000000100005181	jne	0x100005170
0000000100005183	leaq	(%r15,%r12), %rdi
0000000100005187	callq	_fwp_rc_forget_slot
000000010000518c	jmp	0x100005170
000000010000518e	leaq	0x228(%r13), %rdi
0000000100005195	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000519a	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000519f	shlq	$0x10, %r14
00000001000051a3	addq	0x11e8e(%rip), %r14
00000001000051aa	cmpl	$0x0, 0x11e5b(%rip)
00000001000051b1	je	0x1000051c0
00000001000051b3	movl	$0x10000, %esi                  ## imm = 0x10000
00000001000051b8	movq	%r14, %rdi
00000001000051bb	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000051c0	movl	0x8(%r13), %eax
00000001000051c4	leaq	(%r14,%rax), %rcx
00000001000051c8	movq	%rcx, 0x8(%rbx)
00000001000051cc	movl	0xc(%r13), %ecx
00000001000051d0	imulq	%rax, %rcx
00000001000051d4	addq	%r14, %rcx
00000001000051d7	movq	%rcx, 0x10(%rbx)
00000001000051db	movq	%r14, %rax
00000001000051de	addq	$0x8, %rsp
00000001000051e2	popq	%rbx
00000001000051e3	popq	%r12
00000001000051e5	popq	%r13
00000001000051e7	popq	%r14
00000001000051e9	popq	%r15
00000001000051eb	popq	%rbp
00000001000051ec	retq
00000001000051ed	nopl	(%rax)
_fwp_gc_chunks:
00000001000051f0	pushq	%rbp
00000001000051f1	movq	%rsp, %rbp
00000001000051f4	pushq	%r15
00000001000051f6	pushq	%r14
00000001000051f8	pushq	%rbx
00000001000051f9	pushq	%rax
00000001000051fa	movq	%rdi, %rbx
00000001000051fd	xorl	%edx, %edx
00000001000051ff	cmpq	$0x1, %rdi
0000000100005203	setne	%dl
0000000100005206	leaq	_fwp_gc(%rip), %rcx
000000010000520d	movq	0x1068(%rcx,%rdx,8), %rax
0000000100005215	movq	0x11e44(%rip), %r14
000000010000521c	movq	%rax, %rdi
000000010000521f	subq	%r14, %rdi
0000000100005222	jae	0x100005292
0000000100005224	leaq	0x1068(,%rdx,8), %rsi
000000010000522c	imulq	$0x1228, %rax, %r8              ## imm = 0x1228
0000000100005233	addq	0x11e46(%rip), %r8
000000010000523a	xorl	%edx, %edx
000000010000523c	xorl	%r9d, %r9d
000000010000523f	jmp	0x100005262
0000000100005241	nopw	%cs:(%rax,%rax)
0000000100005250	xorl	%r9d, %r9d
0000000100005253	decq	%rdx
0000000100005256	addq	$0x1228, %r8                    ## imm = 0x1228
000000010000525d	cmpq	%rdx, %rdi
0000000100005260	je	0x100005295
0000000100005262	cmpb	$0x0, (%r8)
0000000100005266	jne	0x100005250
0000000100005268	incq	%r9
000000010000526b	cmpq	%rbx, %r9
000000010000526e	jne	0x100005253
0000000100005270	incq	%rax
0000000100005273	movq	%rax, %rdi
0000000100005276	subq	%rdx, %rdi
0000000100005279	movq	%rdi, (%rsi,%rcx)
000000010000527d	subq	%rbx, 0x11f64(%rip)
0000000100005284	subq	%rbx, %rax
0000000100005287	subq	%rdx, %rax
000000010000528a	movq	%rax, %r14
000000010000528d	jmp	0x10000535c
0000000100005292	xorl	%r9d, %r9d
0000000100005295	subq	%r9, 0x11f4c(%rip)
000000010000529c	subq	%r9, %r14
000000010000529f	addq	%r14, %rbx
00000001000052a2	movq	0x11dbf(%rip), %rdi
00000001000052a9	cmpq	%rbx, %rdi
00000001000052ac	jae	0x100005341
00000001000052b2	movq	0x11d9f(%rip), %r15
00000001000052b9	cmpq	%rbx, %r15
00000001000052bc	jb	0x10000536a
00000001000052c2	leaq	0x40(%rbx), %rax
00000001000052c6	cmpq	%r15, %rax
00000001000052c9	cmovbq	%rax, %r15
00000001000052cd	movq	%r15, %rsi
00000001000052d0	subq	%rdi, %rsi
00000001000052d3	shlq	$0x10, %rdi
00000001000052d7	addq	0x11d5a(%rip), %rdi
00000001000052de	shlq	$0x10, %rsi
00000001000052e2	movl	$0x3, %edx
00000001000052e7	callq	0x100012cc0                     ## symbol stub for: _mprotect
00000001000052ec	testl	%eax, %eax
00000001000052ee	jne	0x10000536a
00000001000052f0	movl	$0x1d, %edi
00000001000052f5	callq	0x100012d50                     ## symbol stub for: _sysconf
00000001000052fa	movq	0x11d7f(%rip), %rcx
0000000100005301	imulq	$0x1228, 0x11d5c(%rip), %rdi    ## imm = 0x1228
000000010000530c	addq	%rcx, %rdi
000000010000530f	imulq	$0x1228, %r15, %rdx             ## imm = 0x1228
0000000100005316	addq	%rcx, %rdx
0000000100005319	leaq	(%rax,%rdx), %rsi
000000010000531d	decq	%rsi
0000000100005320	negq	%rax
0000000100005323	andq	%rax, %rdi
0000000100005326	andq	%rax, %rsi
0000000100005329	subq	%rdi, %rsi
000000010000532c	movl	$0x3, %edx
0000000100005331	callq	0x100012cc0                     ## symbol stub for: _mprotect
0000000100005336	testl	%eax, %eax
0000000100005338	jne	0x10000536a
000000010000533a	movq	%r15, 0x11d27(%rip)
0000000100005341	movq	%rbx, 0x11d18(%rip)
0000000100005348	shlq	$0x10, %rbx
000000010000534c	cmpq	0x11cfd(%rip), %rbx
0000000100005353	jbe	0x10000535c
0000000100005355	movq	%rbx, 0x11cf4(%rip)
000000010000535c	movq	%r14, %rax
000000010000535f	addq	$0x8, %rsp
0000000100005363	popq	%rbx
0000000100005364	popq	%r14
0000000100005366	popq	%r15
0000000100005368	popq	%rbp
0000000100005369	retq
000000010000536a	movq	0xfcc7(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100005371	movq	(%rax), %rcx
0000000100005374	leaq	0xe103(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000537b	movl	$0x13, %esi
0000000100005380	movl	$0x1, %edx
0000000100005385	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000538a	movl	$0x66, %edi
000000010000538f	callq	0x100012c48                     ## symbol stub for: _exit
0000000100005394	nopw	%cs:(%rax,%rax)
_fwp_gc_collect:
00000001000053a0	pushq	%rbp
00000001000053a1	movq	%rsp, %rbp
00000001000053a4	pushq	%r15
00000001000053a6	pushq	%r14
00000001000053a8	pushq	%r13
00000001000053aa	pushq	%r12
00000001000053ac	pushq	%rbx
00000001000053ad	subq	$0x168, %rsp                    ## imm = 0x168
00000001000053b4	movq	0xfc75(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000053bb	movq	(%rax), %rax
00000001000053be	movq	%rax, -0x30(%rbp)
00000001000053c2	cmpl	$0x0, 0x11c37(%rip)
00000001000053c9	jne	0x100005887
00000001000053cf	movl	$0x1, 0x11c27(%rip)
00000001000053d9	leaq	-0x170(%rbp), %rsi
00000001000053e0	movl	$0x6, %edi
00000001000053e5	callq	0x100012c42                     ## symbol stub for: _clock_gettime
00000001000053ea	movq	0x11e27(%rip), %rax
00000001000053f1	subq	_fwp_gc(%rip), %rax
00000001000053f8	cvtsi2sd	%rax, %xmm0
00000001000053fd	addsd	0x11deb(%rip), %xmm0
0000000100005405	movsd	%xmm0, 0x11de3(%rip)
000000010000540d	cmpl	$0x0, 0x11bf4(%rip)
0000000100005414	sete	%al
0000000100005417	cmpl	$0x0, 0x11bf2(%rip)
000000010000541e	setne	%r15b
0000000100005422	orb	%al, %r15b
0000000100005425	cmpb	$0x1, %r15b
0000000100005429	jne	0x1000054bb
000000010000542f	movq	0x11c2a(%rip), %rax
0000000100005436	testq	%rax, %rax
0000000100005439	je	0x100005606
000000010000543f	movq	0x11c3a(%rip), %rdx
0000000100005446	xorl	%ecx, %ecx
0000000100005448	movl	%ecx, %r14d
000000010000544b	movq	%r14, %rbx
000000010000544e	movq	%rax, %rcx
0000000100005451	movq	%rdx, %rax
0000000100005454	jmp	0x10000547f
0000000100005456	nopw	%cs:(%rax,%rax)
0000000100005460	movb	$0x0, 0x3(%rax,%r14)
0000000100005466	movq	%rbx, %rsi
0000000100005469	incq	%rsi
000000010000546c	addq	$0x1228, %r14                   ## imm = 0x1228
0000000100005473	movq	%rsi, %rbx
0000000100005476	cmpq	%rcx, %rsi
0000000100005479	jae	0x100005606
000000010000547f	movzbl	(%rax,%r14), %edx
0000000100005484	cmpl	$0x2, %edx
0000000100005487	je	0x100005460
0000000100005489	cmpl	$0x1, %edx
000000010000548c	jne	0x100005466
000000010000548e	leaq	(%rax,%r14), %rdi
0000000100005492	addq	$0x28, %rdi
0000000100005496	movl	0xc(%rax,%r14), %eax
000000010000549b	addl	$0x3f, %eax
000000010000549e	shrl	$0x3, %eax
00000001000054a1	andl	$-0x8, %eax
00000001000054a4	movl	%eax, %esi
00000001000054a6	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000054ab	movq	0x11bce(%rip), %rax
00000001000054b2	movq	0x11ba7(%rip), %rcx
00000001000054b9	jmp	0x100005466
00000001000054bb	movb	%r15b, -0xd1(%rbp)
00000001000054c2	leaq	-0xd0(%rbp), %rdi
00000001000054c9	callq	0x100012cf0                     ## symbol stub for: _setjmp
00000001000054ce	movq	$0x0, 0x11d2f(%rip)
00000001000054d9	callq	_fwp_gc_mark_all
00000001000054de	cmpq	$0x0, 0x11b7a(%rip)
00000001000054e6	je	0x100005642
00000001000054ec	xorl	%eax, %eax
00000001000054ee	jmp	0x10000550a
00000001000054f0	movq	-0xe8(%rbp), %rcx
00000001000054f7	incq	%rcx
00000001000054fa	movq	%rcx, %rax
00000001000054fd	cmpq	0x11b5c(%rip), %rcx
0000000100005504	jae	0x100005642
000000010000550a	movq	0x11b6f(%rip), %r15
0000000100005511	movq	%rax, -0xe8(%rbp)
0000000100005518	imulq	$0x1228, %rax, %rax             ## imm = 0x1228
000000010000551f	cmpb	$0x2, 0x1(%r15,%rax)
0000000100005525	jne	0x1000054f0
0000000100005527	addq	%rax, %r15
000000010000552a	movzbl	(%r15), %eax
000000010000552e	cmpl	$0x2, %eax
0000000100005531	je	0x1000055db
0000000100005537	cmpl	$0x1, %eax
000000010000553a	jne	0x1000054f0
000000010000553c	movl	0xc(%r15), %eax
0000000100005540	addl	$0x3f, %eax
0000000100005543	cmpl	$0x40, %eax
0000000100005546	jb	0x1000054f0
0000000100005548	movq	-0xe8(%rbp), %r12
000000010000554f	shlq	$0x10, %r12
0000000100005553	addq	0x11ade(%rip), %r12
000000010000555a	shrl	$0x6, %eax
000000010000555d	movq	%rax, -0x108(%rbp)
0000000100005564	xorl	%eax, %eax
0000000100005566	movl	%eax, %r14d
0000000100005569	jmp	0x10000558a
000000010000556b	nopl	(%rax,%rax)
0000000100005570	movq	-0xf0(%rbp), %rax
0000000100005577	incq	%rax
000000010000557a	movq	%rax, %r14
000000010000557d	cmpq	-0x108(%rbp), %rax
0000000100005584	je	0x1000054f0
000000010000558a	movq	%r14, -0xf0(%rbp)
0000000100005591	movq	0x28(%r15,%r14,8), %r13
0000000100005596	testq	%r13, %r13
0000000100005599	je	0x100005570
000000010000559b	movq	-0xf0(%rbp), %rbx
00000001000055a2	shlq	$0x6, %rbx
00000001000055a6	nopw	%cs:(%rax,%rax)
00000001000055b0	tzcntq	%r13, %rax
00000001000055b5	orq	%rbx, %rax
00000001000055b8	leaq	-0x1(%r13), %r14
00000001000055bc	movl	0x8(%r15), %ecx
00000001000055c0	movl	%ecx, %esi
00000001000055c2	imulq	%rsi, %rax
00000001000055c6	movq	%rax, %rdi
00000001000055c9	addq	%r12, %rdi
00000001000055cc	callq	_fwp_gc_push
00000001000055d1	andq	%r13, %r14
00000001000055d4	movq	%r14, %r13
00000001000055d7	jne	0x1000055b0
00000001000055d9	jmp	0x100005570
00000001000055db	cmpb	$0x0, 0x3(%r15)
00000001000055e0	je	0x1000054f0
00000001000055e6	movq	-0xe8(%rbp), %rdi
00000001000055ed	shlq	$0x10, %rdi
00000001000055f1	addq	0x11a40(%rip), %rdi
00000001000055f8	movq	0x18(%r15), %rsi
00000001000055fc	callq	_fwp_gc_push
0000000100005601	jmp	0x1000054f0
0000000100005606	leaq	-0xd0(%rbp), %rdi
000000010000560d	callq	0x100012cf0                     ## symbol stub for: _setjmp
0000000100005612	movq	$0x0, 0x11beb(%rip)
000000010000561d	callq	_fwp_gc_mark_all
0000000100005622	callq	_fwp_gc_finalize
0000000100005627	callq	_fwp_gc_sweep
000000010000562c	movq	0x11bad(%rip), %rax
0000000100005633	incq	%rax
0000000100005636	movq	%rax, 0x11ba3(%rip)
000000010000563d	jmp	0x10000575f
0000000100005642	movq	0x11b5f(%rip), %rax
0000000100005649	testq	%rax, %rax
000000010000564c	je	0x100005687
000000010000564e	xorl	%ebx, %ebx
0000000100005650	movq	0x11b49(%rip), %rcx
0000000100005657	decq	%rax
000000010000565a	movq	%rax, 0x11b47(%rip)
0000000100005661	shlq	$0x4, %rax
0000000100005665	movq	(%rcx,%rax), %rdi
0000000100005669	movq	0x8(%rcx,%rax), %rsi
000000010000566e	addq	%rdi, %rsi
0000000100005671	movl	%ebx, %edx
0000000100005673	callq	_fwp_gc_scan
0000000100005678	movq	0x11b29(%rip), %rcx
000000010000567f	movq	%rcx, %rax
0000000100005682	testq	%rcx, %rcx
0000000100005685	jne	0x100005650
0000000100005687	cmpl	$0x0, 0x1197e(%rip)
000000010000568e	movzbl	-0xd1(%rbp), %r15d
0000000100005696	je	0x10000573d
000000010000569c	movq	0x119bd(%rip), %r14
00000001000056a3	movq	%r14, %rdi
00000001000056a6	shlq	$0x9, %rdi
00000001000056aa	callq	0x100012c96                     ## symbol stub for: _malloc
00000001000056af	movq	%rax, %rbx
00000001000056b2	cmpq	$0x1, %r14
00000001000056b6	movq	%r14, %rdi
00000001000056b9	adcq	$0x0, %rdi
00000001000056bd	movq	%rdi, -0x150(%rbp)
00000001000056c4	callq	0x100012c96                     ## symbol stub for: _malloc
00000001000056c9	movq	%rbx, -0xe0(%rbp)
00000001000056d0	testq	%rbx, %rbx
00000001000056d3	je	0x100005cc3
00000001000056d9	testq	%rax, %rax
00000001000056dc	je	0x100005cc3
00000001000056e2	movq	-0xe0(%rbp), %rcx
00000001000056e9	movq	%rcx, -0x100(%rbp)
00000001000056f0	movq	%rax, %r12
00000001000056f3	testq	%r14, %r14
00000001000056f6	je	0x100005724
00000001000056f8	movq	%r12, %rdx
00000001000056fb	movq	0x1197e(%rip), %rcx
0000000100005702	cmpq	$0x1, %r14
0000000100005706	movq	%r14, -0x148(%rbp)
000000010000570d	movq	%rcx, -0x120(%rbp)
0000000100005714	jne	0x1000058ad
000000010000571a	xorl	%eax, %eax
000000010000571c	movq	%rdx, %r12
000000010000571f	jmp	0x10000593e
0000000100005724	callq	_fwp_gc_mark_all
0000000100005729	movq	-0x100(%rbp), %rdi
0000000100005730	callq	0x100012c72                     ## symbol stub for: _free
0000000100005735	movq	%r12, %rdi
0000000100005738	callq	0x100012c72                     ## symbol stub for: _free
000000010000573d	callq	_fwp_gc_finalize
0000000100005742	callq	_fwp_gc_sweep
0000000100005747	movq	0x11a92(%rip), %rax
000000010000574e	incq	%rax
0000000100005751	movq	%rax, 0x11a88(%rip)
0000000100005758	incq	0x118c1(%rip)
000000010000575f	movq	%rax, %rcx
0000000100005762	movq	0x11a67(%rip), %rax
0000000100005769	cmpq	0x11a68(%rip), %rax
0000000100005770	jbe	0x100005779
0000000100005772	movq	%rax, 0x11a5f(%rip)
0000000100005779	testb	%r15b, %r15b
000000010000577c	je	0x100005789
000000010000577e	movq	%rax, 0x11893(%rip)
0000000100005785	xorl	%edx, %edx
0000000100005787	jmp	0x1000057b6
0000000100005789	movq	0x11888(%rip), %rdx
0000000100005790	movq	%rdx, %rsi
0000000100005793	shrq	%rsi
0000000100005796	addq	%rdx, %rsi
0000000100005799	cmpq	$0x1000001, %rsi                ## imm = 0x1000001
00000001000057a0	movl	$0x1000000, %edx                ## imm = 0x1000000
00000001000057a5	cmovaeq	%rsi, %rdx
00000001000057a9	xorl	%esi, %esi
00000001000057ab	cmpq	%rdx, %rax
00000001000057ae	seta	%dl
00000001000057b1	movb	%dl, %sil
00000001000057b4	movl	%esi, %edx
00000001000057b6	testb	$0x7, %cl
00000001000057b9	movl	$0x1, %ecx
00000001000057be	cmovnel	%edx, %ecx
00000001000057c1	cmpq	$0x0, 0x1185f(%rip)
00000001000057c9	cmovel	%edx, %ecx
00000001000057cc	movl	%ecx, 0x1183e(%rip)
00000001000057d2	cmpl	$0x0, 0x1182f(%rip)
00000001000057d9	sete	%cl
00000001000057dc	shlq	%cl, %rax
00000001000057df	cvttsd2si	0x11a20(%rip), %rcx
00000001000057e8	addq	%rax, %rcx
00000001000057eb	cmpq	$0x800001, %rcx                 ## imm = 0x800001
00000001000057f2	movl	$0x800000, %eax                 ## imm = 0x800000
00000001000057f7	cmovgeq	%rcx, %rax
00000001000057fb	movq	%rax, 0x11a16(%rip)
0000000100005802	movq	%rax, _fwp_gc(%rip)
0000000100005809	leaq	-0x160(%rbp), %rsi
0000000100005810	movl	$0x6, %edi
0000000100005815	callq	0x100012c42                     ## symbol stub for: _clock_gettime
000000010000581a	movq	-0x160(%rbp), %rax
0000000100005821	movq	-0x158(%rbp), %rcx
0000000100005828	subq	-0x170(%rbp), %rax
000000010000582f	cvtsi2sd	%rax, %xmm1
0000000100005834	mulsd	0xd6b4(%rip), %xmm1
000000010000583c	subq	-0x168(%rbp), %rcx
0000000100005843	xorps	%xmm0, %xmm0
0000000100005846	cvtsi2sd	%rcx, %xmm0
000000010000584b	divsd	0xd6a5(%rip), %xmm0
0000000100005853	addsd	%xmm1, %xmm0
0000000100005857	movsd	0x11999(%rip), %xmm1
000000010000585f	addsd	%xmm0, %xmm1
0000000100005863	movsd	%xmm1, 0x1198d(%rip)
000000010000586b	ucomisd	0x1198d(%rip), %xmm0
0000000100005873	jbe	0x10000587d
0000000100005875	movsd	%xmm0, 0x11983(%rip)
000000010000587d	movl	$0x0, 0x11779(%rip)
0000000100005887	movq	0xf7a2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000588e	movq	(%rax), %rax
0000000100005891	cmpq	-0x30(%rbp), %rax
0000000100005895	jne	0x100005ad9
000000010000589b	addq	$0x168, %rsp                    ## imm = 0x168
00000001000058a2	popq	%rbx
00000001000058a3	popq	%r12
00000001000058a5	popq	%r13
00000001000058a7	popq	%r14
00000001000058a9	popq	%r15
00000001000058ab	popq	%rbp
00000001000058ac	retq
00000001000058ad	movq	%r14, %r12
00000001000058b0	andq	$-0x2, %r12
00000001000058b4	movq	%r12, -0x110(%rbp)
00000001000058bb	movq	-0xe0(%rbp), %rax
00000001000058c2	leaq	0x200(%rax), %r14
00000001000058c9	leaq	0x1250(%rcx), %r13
00000001000058d0	xorl	%eax, %eax
00000001000058d2	movl	%eax, %ecx
00000001000058d4	movl	$0x200, %ebx                    ## imm = 0x200
00000001000058d9	movq	%rdx, %r12
00000001000058dc	nopl	(%rax)
00000001000058e0	movq	%rcx, %r15
00000001000058e3	leaq	-0x200(%r14), %rdi
00000001000058ea	leaq	-0x1228(%r13), %rsi
00000001000058f1	movq	%rbx, %rdx
00000001000058f4	callq	0x100012ca8                     ## symbol stub for: _memcpy
00000001000058f9	movzbl	-0x124d(%r13), %eax
0000000100005901	movb	%al, (%r12,%r15)
0000000100005905	movq	%r14, %rdi
0000000100005908	movq	%r13, %rsi
000000010000590b	movq	%rbx, %rdx
000000010000590e	callq	0x100012ca8                     ## symbol stub for: _memcpy
0000000100005913	movzbl	-0x25(%r13), %eax
0000000100005918	movb	%al, 0x1(%r12,%r15)
000000010000591d	addq	$0x2, %r15
0000000100005921	addq	$0x400, %r14                    ## imm = 0x400
0000000100005928	addq	$0x2450, %r13                   ## imm = 0x2450
000000010000592f	movq	%r15, %rax
0000000100005932	movq	%r15, %rcx
0000000100005935	cmpq	%r15, -0x110(%rbp)
000000010000593c	jne	0x1000058e0
000000010000593e	movq	-0x148(%rbp), %r13
0000000100005945	testb	$0x1, %r13b
0000000100005949	movq	-0x120(%rbp), %r15
0000000100005950	je	0x100005986
0000000100005952	movq	%rax, %rbx
0000000100005955	movq	%rax, %rdi
0000000100005958	shlq	$0x9, %rdi
000000010000595c	addq	-0xe0(%rbp), %rdi
0000000100005963	imulq	$0x1228, %rax, %r14             ## imm = 0x1228
000000010000596a	leaq	(%r15,%r14), %rsi
000000010000596e	addq	$0x28, %rsi
0000000100005972	movl	$0x200, %edx                    ## imm = 0x200
0000000100005977	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000597c	movzbl	0x3(%r15,%r14), %eax
0000000100005982	movb	%al, (%r12,%rbx)
0000000100005986	xorl	%eax, %eax
0000000100005988	movl	%eax, %r14d
000000010000598b	movq	%r14, %rbx
000000010000598e	movq	%r13, %rcx
0000000100005991	movq	%r15, %rax
0000000100005994	movzbl	-0xd1(%rbp), %r15d
000000010000599c	jmp	0x1000059bb
000000010000599e	nop
00000001000059a0	movb	$0x0, 0x3(%rax,%r14)
00000001000059a6	movq	%rbx, %rsi
00000001000059a9	incq	%rsi
00000001000059ac	addq	$0x1228, %r14                   ## imm = 0x1228
00000001000059b3	movq	%rsi, %rbx
00000001000059b6	cmpq	%rcx, %rsi
00000001000059b9	jae	0x1000059f7
00000001000059bb	movzbl	(%rax,%r14), %edx
00000001000059c0	cmpl	$0x2, %edx
00000001000059c3	je	0x1000059a0
00000001000059c5	cmpl	$0x1, %edx
00000001000059c8	jne	0x1000059a6
00000001000059ca	leaq	(%rax,%r14), %rdi
00000001000059ce	addq	$0x28, %rdi
00000001000059d2	movl	0xc(%rax,%r14), %eax
00000001000059d7	addl	$0x3f, %eax
00000001000059da	shrl	$0x3, %eax
00000001000059dd	andl	$-0x8, %eax
00000001000059e0	movl	%eax, %esi
00000001000059e2	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000059e7	movq	0x11692(%rip), %rax
00000001000059ee	movq	0x1166b(%rip), %rcx
00000001000059f5	jmp	0x1000059a6
00000001000059f7	callq	_fwp_gc_mark_all
00000001000059fc	movq	0x1167d(%rip), %rcx
0000000100005a03	leaq	0x28(%rcx), %rdi
0000000100005a07	xorl	%edx, %edx
0000000100005a09	movl	%edx, %esi
0000000100005a0b	movq	-0x100(%rbp), %r8
0000000100005a12	jmp	0x100005a40
0000000100005a14	testq	%r11, %r11
0000000100005a17	jne	0x100005ade
0000000100005a1d	nopl	(%rax)
0000000100005a20	movq	%rsi, %rax
0000000100005a23	incq	%rax
0000000100005a26	addq	$0x200, %r8                     ## imm = 0x200
0000000100005a2d	addq	$0x1228, %rdi                   ## imm = 0x1228
0000000100005a34	movq	%rax, %rsi
0000000100005a37	cmpq	%r13, %rax
0000000100005a3a	je	0x100005729
0000000100005a40	imulq	$0x1228, %rsi, %r9              ## imm = 0x1228
0000000100005a47	leaq	(%rcx,%r9), %rax
0000000100005a4b	movzbl	(%rcx,%r9), %r9d
0000000100005a50	cmpl	$0x2, %r9d
0000000100005a54	je	0x100005ab0
0000000100005a56	cmpl	$0x1, %r9d
0000000100005a5a	jne	0x100005a20
0000000100005a5c	movl	0xc(%rax), %r9d
0000000100005a60	addl	$0x3f, %r9d
0000000100005a64	cmpl	$0x40, %r9d
0000000100005a68	jb	0x100005a20
0000000100005a6a	shrl	$0x6, %r9d
0000000100005a6e	movq	$-0x40, %r14
0000000100005a75	movl	%edx, %ebx
0000000100005a77	nopw	(%rax,%rax)
0000000100005a80	movq	%r14, %r10
0000000100005a83	movq	(%r8,%rbx,8), %r11
0000000100005a87	notq	%r11
0000000100005a8a	andq	(%rdi,%rbx,8), %r11
0000000100005a8e	incq	%rbx
0000000100005a91	addq	$0x40, %r10
0000000100005a95	cmpq	%r9, %rbx
0000000100005a98	jae	0x100005a14
0000000100005a9e	movq	%r10, %r14
0000000100005aa1	testq	%r11, %r11
0000000100005aa4	je	0x100005a80
0000000100005aa6	jmp	0x100005a14
0000000100005aab	nopl	(%rax,%rax)
0000000100005ab0	cmpb	$0x0, 0x3(%rax)
0000000100005ab4	je	0x100005a20
0000000100005aba	cmpb	$0x0, (%r12,%rsi)
0000000100005abf	jne	0x100005a20
0000000100005ac5	movq	%rsi, %r15
0000000100005ac8	shlq	$0x10, %r15
0000000100005acc	addq	0x11565(%rip), %r15
0000000100005ad3	movq	0x18(%rax), %rbx
0000000100005ad7	jmp	0x100005afd
0000000100005ad9	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100005ade	tzcntq	%r11, %r15
0000000100005ae3	shlq	$0x10, %rsi
0000000100005ae7	addq	0x1154a(%rip), %rsi
0000000100005aee	addq	%r10, %r15
0000000100005af1	movl	0x8(%rax), %edx
0000000100005af4	movl	%edx, %ebx
0000000100005af6	imulq	%rbx, %r15
0000000100005afa	addq	%rsi, %r15
0000000100005afd	movq	0xf534(%rip), %rcx              ## literal pool symbol address: ___stderrp
0000000100005b04	movq	(%rcx), %rdi
0000000100005b07	movzbl	0x1(%rax), %ecx
0000000100005b0b	leaq	0xd9cf(%rip), %rsi              ## literal pool for: "fwp gc verify: a minor collection missed the reachable object at %p (kind %d, %zu bytes)\n"
0000000100005b12	xorl	%r14d, %r14d
0000000100005b15	movl	%r14d, %eax
0000000100005b18	movq	%r15, %rdx
0000000100005b1b	movq	%rbx, %r8
0000000100005b1e	movb	%r14b, -0xd2(%rbp)
0000000100005b25	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100005b2a	addq	%r15, %rbx
0000000100005b2d	movq	%rbx, -0x140(%rbp)
0000000100005b34	movl	%r14d, %eax
0000000100005b37	movq	%rax, %rcx
0000000100005b3a	jmp	0x100005b63
0000000100005b3c	nopl	(%rax)
0000000100005b40	movq	-0xf8(%rbp), %rdx
0000000100005b47	incq	%rdx
0000000100005b4a	movq	%rdi, %rax
0000000100005b4d	addq	$0x10000, %rax                  ## imm = 0x10000
0000000100005b53	movq	%rdx, %rcx
0000000100005b56	cmpq	-0x150(%rbp), %rdx
0000000100005b5d	je	0x100005cbe
0000000100005b63	movq	%rax, %rdi
0000000100005b66	movq	0x11513(%rip), %r12
0000000100005b6d	movq	%rcx, -0xf8(%rbp)
0000000100005b74	imulq	$0x1228, %rcx, %rax             ## imm = 0x1228
0000000100005b7b	cmpb	$0x1, (%r12,%rax)
0000000100005b80	jne	0x100005b40
0000000100005b82	addq	%rax, %r12
0000000100005b85	cmpb	$0x1, 0x1(%r12)
0000000100005b8b	je	0x100005b40
0000000100005b8d	movl	0xc(%r12), %eax
0000000100005b92	testl	%eax, %eax
0000000100005b94	je	0x100005b40
0000000100005b96	movq	-0xf8(%rbp), %rdx
0000000100005b9d	movq	%rdx, %rcx
0000000100005ba0	shlq	$0x10, %rcx
0000000100005ba4	movq	%rcx, -0x130(%rbp)
0000000100005bab	xorl	%ecx, %ecx
0000000100005bad	shlq	$0x9, %rdx
0000000100005bb1	movq	%rdx, %r8
0000000100005bb4	addq	-0xe0(%rbp), %r8
0000000100005bbb	movq	%rdi, -0x138(%rbp)
0000000100005bc2	movq	%r8, -0x128(%rbp)
0000000100005bc9	jmp	0x100005c00
0000000100005bcb	nopl	(%rax,%rax)
0000000100005bd0	movl	0xc(%r12), %eax
0000000100005bd5	movq	-0x138(%rbp), %rdi
0000000100005bdc	movq	-0x128(%rbp), %r8
0000000100005be3	movq	-0x118(%rbp), %rsi
0000000100005bea	movq	%rsi, %rdx
0000000100005bed	incq	%rdx
0000000100005bf0	movl	%eax, %ecx
0000000100005bf2	movl	%ecx, %esi
0000000100005bf4	movq	%rdx, %rcx
0000000100005bf7	cmpq	%rsi, %rdx
0000000100005bfa	jae	0x100005b40
0000000100005c00	movq	%rcx, %rsi
0000000100005c03	shrq	$0x6, %rcx
0000000100005c07	movq	(%r8,%rcx,8), %rcx
0000000100005c0b	btq	%rsi, %rcx
0000000100005c0f	jae	0x100005bea
0000000100005c11	movl	0x8(%r12), %ecx
0000000100005c16	cmpq	$0x8, %rcx
0000000100005c1a	jb	0x100005bea
0000000100005c1c	movq	0x11415(%rip), %r13
0000000100005c23	movq	-0x130(%rbp), %rdx
0000000100005c2a	leaq	(%rdx,%r13), %rbx
0000000100005c2e	movl	%ecx, %r8d
0000000100005c31	movq	%rsi, -0x118(%rbp)
0000000100005c38	imulq	%rsi, %rcx
0000000100005c3c	addq	%rcx, %rbx
0000000100005c3f	addq	%rdi, %r13
0000000100005c42	addq	%rcx, %r13
0000000100005c45	xorl	%eax, %eax
0000000100005c47	movl	%eax, %r14d
0000000100005c4a	jmp	0x100005c68
0000000100005c4c	nopl	(%rax)
0000000100005c50	movl	%r8d, %eax
0000000100005c53	movq	%r14, %rcx
0000000100005c56	incq	%rcx
0000000100005c59	shrl	$0x3, %eax
0000000100005c5c	movq	%rcx, %r14
0000000100005c5f	cmpq	%rax, %rcx
0000000100005c62	jae	0x100005bd0
0000000100005c68	movq	(%r13,%r14,8), %rax
0000000100005c6d	cmpq	%r15, %rax
0000000100005c70	jb	0x100005c50
0000000100005c72	cmpq	-0x140(%rbp), %rax
0000000100005c79	jae	0x100005c50
0000000100005c7b	movq	0xf3b6(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100005c82	movq	(%rax), %rdi
0000000100005c85	movzbl	0x1(%r12), %ecx
0000000100005c8b	movupd	(%rbx), %xmm0
0000000100005c8f	movq	0x10(%rbx), %rax
0000000100005c93	movq	%rsp, %rdx
0000000100005c96	movq	%rax, 0x10(%rdx)
0000000100005c9a	movupd	%xmm0, (%rdx)
0000000100005c9e	leaq	0xd896(%rip), %rsi              ## literal pool for: "  from the old object at %p (kind %d, %u bytes), word %zu; its first words %lx %lx %lx\n"
0000000100005ca5	movq	%rbx, %rdx
0000000100005ca8	movq	%r14, %r9
0000000100005cab	movzbl	-0xd2(%rbp), %eax
0000000100005cb2	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100005cb7	movl	0x8(%r12), %r8d
0000000100005cbc	jmp	0x100005c50
0000000100005cbe	callq	0x100012c2a                     ## symbol stub for: _abort
0000000100005cc3	movq	0xf36e(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100005cca	movq	(%rax), %rcx
0000000100005ccd	leaq	0xd7aa(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100005cd4	movl	$0x13, %esi
0000000100005cd9	movl	$0x1, %edx
0000000100005cde	callq	0x100012c78                     ## symbol stub for: _fwrite
0000000100005ce3	movl	$0x66, %edi
0000000100005ce8	callq	0x100012c48                     ## symbol stub for: _exit
0000000100005ced	nopl	(%rax)
_fwp_gc_mark_all:
0000000100005cf0	pushq	%rbp
0000000100005cf1	movq	%rsp, %rbp
0000000100005cf4	pushq	%r15
0000000100005cf6	pushq	%r14
0000000100005cf8	pushq	%r13
0000000100005cfa	pushq	%r12
0000000100005cfc	pushq	%rbx
0000000100005cfd	pushq	%rax
0000000100005cfe	callq	_fwp_gc_sp
0000000100005d03	movq	0x11386(%rip), %rsi
0000000100005d0a	testq	%rax, %rax
0000000100005d0d	sete	%dl
0000000100005d10	movq	%rsi, %rcx
0000000100005d13	subq	%rax, %rcx
0000000100005d16	setbe	%dil
0000000100005d1a	orb	%dl, %dil
0000000100005d1d	jne	0x100005d66
0000000100005d1f	cvtsi2sd	%rcx, %xmm0
0000000100005d24	addsd	0x114dc(%rip), %xmm0
0000000100005d2c	movsd	%xmm0, 0x114d4(%rip)
0000000100005d34	movq	%rax, %rdi
0000000100005d37	movl	$0x1, %edx
0000000100005d3c	jmp	0x100005d61
0000000100005d3e	movq	0x1145b(%rip), %rcx
0000000100005d45	decq	%rax
0000000100005d48	movq	%rax, 0x11459(%rip)
0000000100005d4f	shlq	$0x4, %rax
0000000100005d53	movq	(%rcx,%rax), %rdi
0000000100005d57	movq	0x8(%rcx,%rax), %rsi
0000000100005d5c	addq	%rdi, %rsi
0000000100005d5f	xorl	%edx, %edx
0000000100005d61	callq	_fwp_gc_scan
0000000100005d66	movq	0x1143b(%rip), %rax
0000000100005d6d	testq	%rax, %rax
0000000100005d70	jne	0x100005d3e
0000000100005d72	cmpl	$0x0, 0x1141f(%rip)
0000000100005d79	jle	0x100005e44
0000000100005d7f	leaq	0x1131a(%rip), %r12
0000000100005d86	xorl	%r13d, %r13d
0000000100005d89	leaq	_fwp_gc(%rip), %rbx
0000000100005d90	leaq	0x1a20(%rbx), %r14
0000000100005d97	jmp	0x100005dbd
0000000100005d99	nopl	(%rax)
0000000100005da0	movq	%r15, %rsi
0000000100005da3	xorl	%edx, %edx
0000000100005da5	callq	_fwp_gc_scan
0000000100005daa	incq	%r13
0000000100005dad	movslq	0x113e4(%rip), %rax
0000000100005db4	addq	$0x10, %r12
0000000100005db8	cmpq	%rax, %r13
0000000100005dbb	jge	0x100005e38
0000000100005dbd	movq	-0x8(%r12), %rdi
0000000100005dc2	movq	(%r12), %rax
0000000100005dc6	xorps	%xmm0, %xmm0
0000000100005dc9	cvtsi2sd	%rax, %xmm0
0000000100005dce	addsd	0x1200(%rbx), %xmm0
0000000100005dd6	leaq	(%rdi,%rax), %r15
0000000100005dda	cmpq	%rbx, %rdi
0000000100005ddd	seta	%al
0000000100005de0	movsd	%xmm0, 0x1200(%rbx)
0000000100005de8	cmpq	%r14, %r15
0000000100005deb	setb	%cl
0000000100005dee	orb	%al, %cl
0000000100005df0	jne	0x100005da0
0000000100005df2	movq	%rbx, %rsi
0000000100005df5	xorl	%edx, %edx
0000000100005df7	callq	_fwp_gc_scan
0000000100005dfc	leaq	_d1(%rip), %rdi
0000000100005e03	jmp	0x100005da0
0000000100005e05	nopw	%cs:(%rax,%rax)
0000000100005e10	movq	0x11389(%rip), %rcx
0000000100005e17	decq	%rax
0000000100005e1a	movq	%rax, 0x11387(%rip)
0000000100005e21	shlq	$0x4, %rax
0000000100005e25	movq	(%rcx,%rax), %rdi
0000000100005e29	movq	0x8(%rcx,%rax), %rsi
0000000100005e2e	addq	%rdi, %rsi
0000000100005e31	xorl	%edx, %edx
0000000100005e33	callq	_fwp_gc_scan
0000000100005e38	movq	0x11369(%rip), %rax
0000000100005e3f	testq	%rax, %rax
0000000100005e42	jne	0x100005e10
0000000100005e44	addq	$0x8, %rsp
0000000100005e48	popq	%rbx
0000000100005e49	popq	%r12
0000000100005e4b	popq	%r13
0000000100005e4d	popq	%r14
0000000100005e4f	popq	%r15
0000000100005e51	popq	%rbp
0000000100005e52	retq
0000000100005e53	nopw	%cs:(%rax,%rax)
_fwp_gc_finalize:
0000000100005e60	movq	0x11359(%rip), %rcx
0000000100005e67	testq	%rcx, %rcx
0000000100005e6a	je	0x100005f7b
0000000100005e70	pushq	%rbp
0000000100005e71	movq	%rsp, %rbp
0000000100005e74	pushq	%r14
0000000100005e76	pushq	%rbx
0000000100005e77	movq	0x1133a(%rip), %rsi
0000000100005e7e	movq	0x111b3(%rip), %r8
0000000100005e85	movq	0x111d4(%rip), %r9
0000000100005e8c	xorl	%ebx, %ebx
0000000100005e8e	jmp	0x100005e9c
0000000100005e90	incq	%rbx
0000000100005e93	cmpq	%rcx, %rbx
0000000100005e96	jae	0x100005f77
0000000100005e9c	movq	%rbx, %r10
0000000100005e9f	shlq	$0x4, %r10
0000000100005ea3	movq	(%rsi,%r10), %rdi
0000000100005ea7	movq	%rdi, %rdx
0000000100005eaa	subq	%r8, %rdx
0000000100005ead	movq	%r9, %rax
0000000100005eb0	shlq	$0x10, %rax
0000000100005eb4	cmpq	%rax, %rdx
0000000100005eb7	jae	0x100005e90
0000000100005eb9	movq	0x111c0(%rip), %rax
0000000100005ec0	testq	%rax, %rax
0000000100005ec3	je	0x100005e90
0000000100005ec5	shrq	$0x10, %rdx
0000000100005ec9	imulq	$0x1228, %rdx, %r14             ## imm = 0x1228
0000000100005ed0	addq	%rax, %r14
0000000100005ed3	movzbl	(%r14), %edx
0000000100005ed7	cmpb	$0x3, %dl
0000000100005eda	jne	0x100005eef
0000000100005edc	movl	0x10(%r14), %edx
0000000100005ee0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005ee7	leaq	(%rax,%rdx), %r14
0000000100005eeb	movzbl	(%rax,%rdx), %edx
0000000100005eef	movq	0x8(%rsi,%r10), %r11
0000000100005ef4	cmpb	$0x1, %dl
0000000100005ef7	je	0x100005f0c
0000000100005ef9	movzbl	%dl, %eax
0000000100005efc	cmpl	$0x2, %eax
0000000100005eff	jne	0x100005f36
0000000100005f01	movzbl	0x3(%r14), %edx
0000000100005f06	testl	%edx, %edx
0000000100005f08	jne	0x100005e90
0000000100005f0a	jmp	0x100005f36
0000000100005f0c	movzwl	%di, %eax
0000000100005f0f	xorl	%edx, %edx
0000000100005f11	divl	0x8(%r14)
0000000100005f15	movl	%eax, %edx
0000000100005f17	shrl	$0x3, %edx
0000000100005f1a	andl	$0x1ff8, %edx                   ## imm = 0x1FF8
0000000100005f20	movq	0x28(%r14,%rdx), %r14
0000000100005f25	xorl	%edx, %edx
0000000100005f27	btq	%rax, %r14
0000000100005f2b	setb	%dl
0000000100005f2e	testl	%edx, %edx
0000000100005f30	jne	0x100005e90
0000000100005f36	addq	%rsi, %r10
0000000100005f39	decq	%rcx
0000000100005f3c	movq	%rcx, 0x1127d(%rip)
0000000100005f43	shlq	$0x4, %rcx
0000000100005f47	movups	(%rsi,%rcx), %xmm0
0000000100005f4b	movups	%xmm0, (%r10)
0000000100005f4f	callq	*%r11
0000000100005f52	movq	0x1125f(%rip), %rsi
0000000100005f59	movq	0x110d8(%rip), %r8
0000000100005f60	movq	0x110f9(%rip), %r9
0000000100005f67	movq	0x11252(%rip), %rcx
0000000100005f6e	cmpq	%rcx, %rbx
0000000100005f71	jb	0x100005e9c
0000000100005f77	popq	%rbx
0000000100005f78	popq	%r14
0000000100005f7a	popq	%rbp
0000000100005f7b	retq
0000000100005f7c	nopl	(%rax)
_fwp_gc_sweep:
0000000100005f80	pushq	%rbp
0000000100005f81	movq	%rsp, %rbp
0000000100005f84	pushq	%r15
0000000100005f86	pushq	%r14
0000000100005f88	pushq	%r13
0000000100005f8a	pushq	%r12
0000000100005f8c	pushq	%rbx
0000000100005f8d	subq	$0x28, %rsp
0000000100005f91	leaq	0x10078(%rip), %rdi
0000000100005f98	movl	$0xb40, %esi                    ## imm = 0xB40
0000000100005f9d	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100005fa2	cmpq	$0x0, 0x110b6(%rip)
0000000100005faa	je	0x100006464
0000000100005fb0	movq	$0x0, -0x30(%rbp)
0000000100005fb8	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005fc2	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
0000000100005fcc	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100005fd6	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
0000000100005fe0	movdqa	0xce38(%rip), %xmm6
0000000100005fe8	movdqa	0xce40(%rip), %xmm7
0000000100005ff0	pxor	%xmm8, %xmm8
0000000100005ff5	xorl	%r15d, %r15d
0000000100005ff8	xorl	%edx, %edx
0000000100005ffa	jmp	0x100006016
0000000100005ffc	nopl	(%rax)
0000000100006000	incq	%r15
0000000100006003	incq	%rdx
0000000100006006	movq	0x11053(%rip), %rax
000000010000600d	cmpq	%rax, %rdx
0000000100006010	jae	0x100006471
0000000100006016	movq	0x11063(%rip), %rax
000000010000601d	imulq	$0x1228, %rdx, %r14             ## imm = 0x1228
0000000100006024	movzbl	(%rax,%r14), %ecx
0000000100006029	testl	%ecx, %ecx
000000010000602b	je	0x100006000
000000010000602d	leaq	(%rax,%r14), %r13
0000000100006031	cmpl	$0x1, %ecx
0000000100006034	je	0x100006060
0000000100006036	cmpl	$0x2, %ecx
0000000100006039	jne	0x100006003
000000010000603b	movl	0x10(%r13), %r12d
000000010000603f	cmpb	$0x0, 0x3(%r13)
0000000100006044	je	0x10000608f
0000000100006046	movq	-0x30(%rbp), %rax
000000010000604a	addq	0x18(%r13), %rax
000000010000604e	movq	%rax, -0x30(%rbp)
0000000100006052	addq	%r12, %rdx
0000000100006055	decq	%rdx
0000000100006058	jmp	0x100006003
000000010000605a	nopw	(%rax,%rax)
0000000100006060	movq	%rdx, -0x38(%rbp)
0000000100006064	movl	0xc(%r13), %r12d
0000000100006068	testq	%r12, %r12
000000010000606b	je	0x1000062ec
0000000100006071	leaq	0x3f(%r12), %rsi
0000000100006076	movq	%rsi, %rcx
0000000100006079	shrq	$0x6, %rcx
000000010000607d	cmpl	$0xc0, %r12d
0000000100006084	ja	0x1000060f4
0000000100006086	xorl	%esi, %esi
0000000100006088	xorl	%edx, %edx
000000010000608a	jmp	0x1000061b0
000000010000608f	movq	%rdx, -0x38(%rbp)
0000000100006093	leaq	0x228(%r13), %rbx
000000010000609a	cmpb	$-0x1, 0x228(%r13)
00000001000060a2	je	0x100006442
00000001000060a8	movb	$0x0, (%rbx)
00000001000060ab	testq	%r12, %r12
00000001000060ae	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
00000001000060b8	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000060c2	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000060cc	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000060d6	je	0x100006430
00000001000060dc	movq	0x10f9d(%rip), %rax
00000001000060e3	cmpl	$0x4, %r12d
00000001000060e7	jae	0x1000063c2
00000001000060ed	xorl	%ecx, %ecx
00000001000060ef	jmp	0x1000063f8
00000001000060f4	movl	%ecx, %edx
00000001000060f6	andl	$-0x4, %edx
00000001000060f9	leaq	(%rax,%r14), %rdi
00000001000060fd	addq	$0x38, %rdi
0000000100006101	shrq	$0x3, %rsi
0000000100006105	andl	$-0x20, %esi
0000000100006108	pxor	%xmm0, %xmm0
000000010000610c	xorl	%r8d, %r8d
000000010000610f	pxor	%xmm1, %xmm1
0000000100006113	nopw	%cs:(%rax,%rax)
0000000100006120	movdqu	-0x10(%rdi,%r8), %xmm2
0000000100006127	movdqu	(%rdi,%r8), %xmm3
000000010000612d	movdqa	%xmm2, %xmm4
0000000100006131	pand	%xmm6, %xmm4
0000000100006135	movdqa	%xmm7, %xmm5
0000000100006139	pshufb	%xmm4, %xmm5
000000010000613e	psrlw	$0x4, %xmm2
0000000100006143	pand	%xmm6, %xmm2
0000000100006147	movdqa	%xmm7, %xmm4
000000010000614b	pshufb	%xmm2, %xmm4
0000000100006150	paddb	%xmm5, %xmm4
0000000100006154	psadbw	%xmm8, %xmm4
0000000100006159	paddq	%xmm4, %xmm0
000000010000615d	movdqa	%xmm3, %xmm2
0000000100006161	pand	%xmm6, %xmm2
0000000100006165	movdqa	%xmm7, %xmm4
0000000100006169	pshufb	%xmm2, %xmm4
000000010000616e	psrlw	$0x4, %xmm3
0000000100006173	pand	%xmm6, %xmm3
0000000100006177	movdqa	%xmm7, %xmm2
000000010000617b	pshufb	%xmm3, %xmm2
0000000100006180	paddb	%xmm4, %xmm2
0000000100006184	psadbw	%xmm8, %xmm2
0000000100006189	paddq	%xmm2, %xmm1
000000010000618d	addq	$0x20, %r8
0000000100006191	cmpq	%r8, %rsi
0000000100006194	jne	0x100006120
0000000100006196	paddq	%xmm0, %xmm1
000000010000619a	pshufd	$0xee, %xmm1, %xmm0             ## xmm0 = xmm1[2,3,2,3]
000000010000619f	paddq	%xmm1, %xmm0
00000001000061a3	movq	%xmm0, %rsi
00000001000061a8	cmpl	%edx, %ecx
00000001000061aa	je	0x1000061f1
00000001000061ac	nopl	(%rax)
00000001000061b0	movq	0x28(%r13,%rdx,8), %rdi
00000001000061b5	movq	%rdi, %r8
00000001000061b8	shrq	%r8
00000001000061bb	andq	%r9, %r8
00000001000061be	subq	%r8, %rdi
00000001000061c1	movq	%rdi, %r8
00000001000061c4	andq	%r10, %r8
00000001000061c7	shrq	$0x2, %rdi
00000001000061cb	andq	%r10, %rdi
00000001000061ce	addq	%r8, %rdi
00000001000061d1	movq	%rdi, %r8
00000001000061d4	shrq	$0x4, %r8
00000001000061d8	addq	%rdi, %r8
00000001000061db	andq	%r11, %r8
00000001000061de	imulq	%rbx, %r8
00000001000061e2	shrq	$0x38, %r8
00000001000061e6	addq	%r8, %rsi
00000001000061e9	incq	%rdx
00000001000061ec	cmpq	%rdx, %rcx
00000001000061ef	jne	0x1000061b0
00000001000061f1	testq	%rsi, %rsi
00000001000061f4	je	0x1000062ec
00000001000061fa	movq	%r15, -0x40(%rbp)
00000001000061fe	movl	0x8(%r13), %ecx
0000000100006202	imulq	%rcx, %rsi
0000000100006206	addq	%rsi, -0x30(%rbp)
000000010000620a	movzbl	0x1(%r13), %ecx
000000010000620f	movzbl	0x2(%r13), %edx
0000000100006214	imulq	$0x3c0, %rcx, %rcx              ## imm = 0x3C0
000000010000621b	leaq	_fwp_gc(%rip), %rsi
0000000100006222	addq	%rsi, %rcx
0000000100006225	leaq	(%rdx,%rdx,2), %rdx
0000000100006229	movq	-0x38(%rbp), %rsi
000000010000622d	shlq	$0x10, %rsi
0000000100006231	addq	0x10e00(%rip), %rsi
0000000100006238	movq	%rsi, -0x48(%rbp)
000000010000623c	leaq	(%rcx,%rdx,8), %r15
0000000100006240	addq	$0x8, %r15
0000000100006244	addq	%r12, %r14
0000000100006247	leaq	(%rax,%r14), %rbx
000000010000624b	addq	$0x227, %rbx                    ## imm = 0x227
0000000100006252	decq	%r12
0000000100006255	jmp	0x100006281
0000000100006257	nopw	(%rax,%rax)
0000000100006260	cmpb	$-0x1, (%rbx)
0000000100006263	je	0x1000062ca
0000000100006265	movb	$0x0, (%rbx)
0000000100006268	movq	(%r15), %rax
000000010000626b	notq	%rax
000000010000626e	movq	%rax, (%r14)
0000000100006271	movq	%r14, (%r15)
0000000100006274	decq	%rbx
0000000100006277	addq	$-0x1, %r12
000000010000627b	jae	0x10000638d
0000000100006281	movq	%r12, %rax
0000000100006284	shrq	$0x6, %rax
0000000100006288	movq	0x28(%r13,%rax,8), %rax
000000010000628d	btq	%r12, %rax
0000000100006291	jb	0x100006274
0000000100006293	movl	0x8(%r13), %esi
0000000100006297	movq	%r12, %r14
000000010000629a	imulq	%rsi, %r14
000000010000629e	addq	-0x48(%rbp), %r14
00000001000062a2	cmpl	$0x0, 0x10d63(%rip)
00000001000062a9	je	0x100006260
00000001000062ab	movq	%r14, %rdi
00000001000062ae	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000062b3	pxor	%xmm8, %xmm8
00000001000062b8	movdqa	0xcb70(%rip), %xmm7
00000001000062c0	movdqa	0xcb58(%rip), %xmm6
00000001000062c8	jmp	0x100006260
00000001000062ca	movq	%rbx, %rdi
00000001000062cd	callq	_fwp_rc_forget_slot
00000001000062d2	pxor	%xmm8, %xmm8
00000001000062d7	movdqa	0xcb51(%rip), %xmm7
00000001000062df	movdqa	0xcb39(%rip), %xmm6
00000001000062e7	jmp	0x100006265
00000001000062ec	cmpq	$0x0, 0x1172c(%rip)
00000001000062f4	je	0x10000632e
00000001000062f6	leaq	0x228(%r13), %rbx
00000001000062fd	xorl	%r14d, %r14d
0000000100006300	jmp	0x10000631c
0000000100006302	nopw	%cs:(%rax,%rax)
0000000100006310	incq	%r14
0000000100006313	cmpq	$0x1000, %r14                   ## imm = 0x1000
000000010000631a	je	0x10000632e
000000010000631c	cmpb	$-0x1, (%rbx,%r14)
0000000100006321	jne	0x100006310
0000000100006323	leaq	(%rbx,%r14), %rdi
0000000100006327	callq	_fwp_rc_forget_slot
000000010000632c	jmp	0x100006310
000000010000632e	leaq	0x228(%r13), %rdi
0000000100006335	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000633a	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000633f	movb	$0x0, (%r13)
0000000100006344	incq	%r15
0000000100006347	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100006351	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
000000010000635b	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100006365	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
000000010000636f	movdqa	0xcaa9(%rip), %xmm6
0000000100006377	movdqa	0xcab1(%rip), %xmm7
000000010000637f	pxor	%xmm8, %xmm8
0000000100006384	movq	-0x38(%rbp), %rdx
0000000100006388	jmp	0x100006003
000000010000638d	movq	-0x40(%rbp), %r15
0000000100006391	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
000000010000639b	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000063a5	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000063af	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000063b9	movq	-0x38(%rbp), %rdx
00000001000063bd	jmp	0x100006003
00000001000063c2	leaq	(%rax,%r14), %rdx
00000001000063c6	movl	%r12d, %esi
00000001000063c9	andl	$-0x4, %esi
00000001000063cc	xorl	%ecx, %ecx
00000001000063ce	nop
00000001000063d0	movb	$0x0, (%rdx)
00000001000063d3	movb	$0x0, 0x1228(%rdx)
00000001000063da	movb	$0x0, 0x2450(%rdx)
00000001000063e1	movb	$0x0, 0x3678(%rdx)
00000001000063e8	addq	$0x4, %rcx
00000001000063ec	addq	$0x48a0, %rdx                   ## imm = 0x48A0
00000001000063f3	cmpq	%rcx, %rsi
00000001000063f6	jne	0x1000063d0
00000001000063f8	movl	%r12d, %edx
00000001000063fb	andl	$0x3, %edx
00000001000063fe	je	0x100006430
0000000100006400	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
0000000100006407	addq	%r14, %rcx
000000010000640a	addq	%rcx, %rax
000000010000640d	imulq	$0x1228, %rdx, %rcx             ## imm = 0x1228
0000000100006414	xorl	%edx, %edx
0000000100006416	nopw	%cs:(%rax,%rax)
0000000100006420	movb	$0x0, (%rax,%rdx)
0000000100006424	addq	$0x1228, %rdx                   ## imm = 0x1228
000000010000642b	cmpq	%rdx, %rcx
000000010000642e	jne	0x100006420
0000000100006430	addq	%r12, %r15
0000000100006433	movq	-0x38(%rbp), %rdx
0000000100006437	addq	%r12, %rdx
000000010000643a	decq	%rdx
000000010000643d	jmp	0x100006003
0000000100006442	movq	%rbx, %rdi
0000000100006445	callq	_fwp_rc_forget_slot
000000010000644a	pxor	%xmm8, %xmm8
000000010000644f	movdqa	0xc9d9(%rip), %xmm7
0000000100006457	movdqa	0xc9c1(%rip), %xmm6
000000010000645f	jmp	0x1000060a8
0000000100006464	xorl	%r15d, %r15d
0000000100006467	movq	$0x0, -0x30(%rbp)
000000010000646f	xorl	%eax, %eax
0000000100006471	movq	-0x30(%rbp), %rdx
0000000100006475	movq	%rdx, 0x10d54(%rip)
000000010000647c	movq	%r15, 0x10d65(%rip)
0000000100006483	cmpq	$0x1000001, %rdx                ## imm = 0x1000001
000000010000648a	movl	$0x1000000, %ecx                ## imm = 0x1000000
000000010000648f	cmovaeq	%rdx, %rcx
0000000100006493	shrq	$0x10, %rcx
0000000100006497	pxor	%xmm0, %xmm0
000000010000649b	movdqu	%xmm0, 0x10bcd(%rip)
00000001000064a3	subq	%rcx, %r15
00000001000064a6	jbe	0x1000065a1
00000001000064ac	testq	%rax, %rax
00000001000064af	je	0x1000065a1
00000001000064b5	testq	%r15, %r15
00000001000064b8	je	0x1000065a1
00000001000064be	movq	0x10bbb(%rip), %rcx
00000001000064c5	nopw	%cs:(%rax,%rax)
00000001000064d0	leaq	-0x1(%rax), %rbx
00000001000064d4	imulq	$0x1228, %rbx, %rdx             ## imm = 0x1228
00000001000064db	cmpb	$0x0, (%rcx,%rdx)
00000001000064df	jne	0x100006590
00000001000064e5	addq	%rcx, %rdx
00000001000064e8	leaq	-0x1(%r15), %r14
00000001000064ec	cmpb	$0x0, 0x4(%rdx)
00000001000064f0	je	0x10000658d
00000001000064f6	movb	$0x0, 0x4(%rdx)
00000001000064fa	movl	$0x1, %esi
00000001000064ff	testq	%rbx, %rbx
0000000100006502	je	0x10000656a
0000000100006504	testq	%r14, %r14
0000000100006507	je	0x10000656a
0000000100006509	movl	$0x2, %edx
000000010000650e	subq	%rax, %rdx
0000000100006511	imulq	$0x1228, %rax, %rax             ## imm = 0x1228
0000000100006518	addq	%rax, %rcx
000000010000651b	addq	$-0x244c, %rcx                  ## imm = 0xDBB4
0000000100006522	movl	$0x2, %edi
0000000100006527	subq	%r15, %rdi
000000010000652a	movl	$0x1, %eax
000000010000652f	nop
0000000100006530	cmpb	$0x0, -0x4(%rcx)
0000000100006534	jne	0x100006567
0000000100006536	cmpb	$0x0, (%rcx)
0000000100006539	je	0x100006567
000000010000653b	decq	%rbx
000000010000653e	leaq	(%rdx,%rax), %r8
0000000100006542	decq	%r14
0000000100006545	movb	$0x0, (%rcx)
0000000100006548	leaq	0x1(%rax), %rsi
000000010000654c	cmpq	$0x1, %r8
0000000100006550	je	0x10000656a
0000000100006552	addq	%rdi, %rax
0000000100006555	addq	$-0x1228, %rcx                  ## imm = 0xEDD8
000000010000655c	cmpq	$0x1, %rax
0000000100006560	movq	%rsi, %rax
0000000100006563	jne	0x100006530
0000000100006565	jmp	0x10000656a
0000000100006567	movq	%rax, %rsi
000000010000656a	movq	%rbx, %rdi
000000010000656d	shlq	$0x10, %rdi
0000000100006571	addq	0x10ac0(%rip), %rdi
0000000100006578	shlq	$0x10, %rsi
000000010000657c	movl	$0x4, %edx
0000000100006581	callq	0x100012c90                     ## symbol stub for: _madvise
0000000100006586	movq	0x10af3(%rip), %rcx
000000010000658d	movq	%r14, %r15
0000000100006590	movq	%rbx, %rax
0000000100006593	testq	%rbx, %rbx
0000000100006596	je	0x1000065a1
0000000100006598	testq	%r15, %r15
000000010000659b	jne	0x1000064d0
00000001000065a1	addq	$0x28, %rsp
00000001000065a5	popq	%rbx
00000001000065a6	popq	%r12
00000001000065a8	popq	%r13
00000001000065aa	popq	%r14
00000001000065ac	popq	%r15
00000001000065ae	popq	%rbp
00000001000065af	retq
_fwp_gc_sp:
00000001000065b0	pushq	%rbp
00000001000065b1	movq	%rsp, %rbp
00000001000065b4	movq	%rbp, %rax
00000001000065b7	popq	%rbp
00000001000065b8	retq
00000001000065b9	nopl	(%rax)
_fwp_gc_scan:
00000001000065c0	pushq	%rbp
00000001000065c1	movq	%rsp, %rbp
00000001000065c4	pushq	%r15
00000001000065c6	pushq	%r14
00000001000065c8	pushq	%r13
00000001000065ca	pushq	%r12
00000001000065cc	pushq	%rbx
00000001000065cd	pushq	%rax
00000001000065ce	movq	%rdi, %r15
00000001000065d1	addq	$0x7, %r15
00000001000065d5	andq	$-0x8, %r15
00000001000065d9	leaq	0x8(%r15), %rax
00000001000065dd	cmpq	%rsi, %rax
00000001000065e0	jbe	0x1000065f1
00000001000065e2	addq	$0x8, %rsp
00000001000065e6	popq	%rbx
00000001000065e7	popq	%r12
00000001000065e9	popq	%r13
00000001000065eb	popq	%r14
00000001000065ed	popq	%r15
00000001000065ef	popq	%rbp
00000001000065f0	retq
00000001000065f1	movl	%edx, %ebx
00000001000065f3	movq	%rsi, %r14
00000001000065f6	movq	0x10a3b(%rip), %r11
00000001000065fd	movq	0x10a5c(%rip), %r13
0000000100006604	shlq	$0x10, %r13
0000000100006608	movq	%r11, -0x30(%rbp)
000000010000660c	jmp	0x100006640
000000010000660e	movl	0x10(%r9), %eax
0000000100006612	imulq	$0x1228, %rax, %rdx             ## imm = 0x1228
0000000100006619	addq	%rdx, %rcx
000000010000661c	movq	%rcx, %r9
000000010000661f	cmpb	$0x0, 0x3(%r9)
0000000100006624	je	0x100006829
000000010000662a	nopw	(%rax,%rax)
0000000100006630	leaq	0x8(%r15), %rax
0000000100006634	addq	$0x10, %r15
0000000100006638	cmpq	%r14, %r15
000000010000663b	movq	%rax, %r15
000000010000663e	ja	0x1000065e2
0000000100006640	movq	(%r15), %r12
0000000100006643	movq	%r12, %rax
0000000100006646	subq	%r11, %rax
0000000100006649	cmpq	%r13, %rax
000000010000664c	jae	0x100006710
0000000100006652	movq	0x109df(%rip), %rdi
0000000100006659	movq	%r12, %r8
000000010000665c	subq	%rdi, %r8
000000010000665f	movq	0x109fa(%rip), %rax
0000000100006666	shlq	$0x10, %rax
000000010000666a	cmpq	%rax, %r8
000000010000666d	jae	0x100006760
0000000100006673	movq	0x10a06(%rip), %rcx
000000010000667a	testq	%rcx, %rcx
000000010000667d	je	0x100006760
0000000100006683	movq	%r8, %rax
0000000100006686	shrq	$0x10, %rax
000000010000668a	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100006691	addq	%rcx, %r9
0000000100006694	movzbl	(%r9), %edx
0000000100006698	cmpl	$0x3, %edx
000000010000669b	je	0x100006722
00000001000066a1	cmpl	$0x2, %edx
00000001000066a4	je	0x100006733
00000001000066aa	cmpl	$0x1, %edx
00000001000066ad	jne	0x100006760
00000001000066b3	movl	0x8(%r9), %esi
00000001000066b7	movzwl	%r12w, %eax
00000001000066bb	xorl	%edx, %edx
00000001000066bd	divl	%esi
00000001000066bf	cmpl	0xc(%r9), %eax
00000001000066c3	jae	0x100006760
00000001000066c9	movl	$0x1, %edx
00000001000066ce	movl	%eax, %ecx
00000001000066d0	shlq	%cl, %rdx
00000001000066d3	movl	%eax, %ecx
00000001000066d5	shrl	$0x6, %ecx
00000001000066d8	movq	0x28(%r9,%rcx,8), %r10
00000001000066dd	btq	%rax, %r10
00000001000066e1	jb	0x100006760
00000001000066e7	orq	%rdx, %r10
00000001000066ea	movq	%r10, 0x28(%r9,%rcx,8)
00000001000066ef	cmpb	$0x1, 0x1(%r9)
00000001000066f4	je	0x100006760
00000001000066f6	andq	$-0x10000, %r8                  ## imm = 0xFFFF0000
00000001000066fd	addq	%r8, %rdi
0000000100006700	imulq	%rsi, %rax
0000000100006704	addq	%rdi, %rax
0000000100006707	movq	%rax, %rdi
000000010000670a	jmp	0x100006751
000000010000670c	nopl	(%rax)
0000000100006710	testl	%ebx, %ebx
0000000100006712	je	0x100006630
0000000100006718	cmpq	%r13, %rax
000000010000671b	je	0x100006768
000000010000671d	jmp	0x100006630
0000000100006722	movl	0x10(%r9), %eax
0000000100006726	imulq	$0x1228, %rax, %rdx             ## imm = 0x1228
000000010000672d	addq	%rdx, %rcx
0000000100006730	movq	%rcx, %r9
0000000100006733	cmpb	$0x0, 0x3(%r9)
0000000100006738	jne	0x100006760
000000010000673a	movb	$0x1, 0x3(%r9)
000000010000673f	cmpb	$0x1, 0x1(%r9)
0000000100006744	je	0x100006760
0000000100006746	shlq	$0x10, %rax
000000010000674a	addq	%rax, %rdi
000000010000674d	movq	0x18(%r9), %rsi
0000000100006751	callq	_fwp_gc_push
0000000100006756	movq	-0x30(%rbp), %r11
000000010000675a	nopw	(%rax,%rax)
0000000100006760	testl	%ebx, %ebx
0000000100006762	je	0x100006630
0000000100006768	decq	%r12
000000010000676b	movq	0x108c6(%rip), %rdi
0000000100006772	movq	%r12, %r8
0000000100006775	subq	%rdi, %r8
0000000100006778	movq	0x108e1(%rip), %rax
000000010000677f	shlq	$0x10, %rax
0000000100006783	cmpq	%rax, %r8
0000000100006786	jae	0x100006630
000000010000678c	movq	0x108ed(%rip), %rcx
0000000100006793	testq	%rcx, %rcx
0000000100006796	je	0x100006630
000000010000679c	movq	%r8, %rax
000000010000679f	shrq	$0x10, %rax
00000001000067a3	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
00000001000067aa	addq	%rcx, %r9
00000001000067ad	movzbl	(%r9), %edx
00000001000067b1	cmpl	$0x3, %edx
00000001000067b4	je	0x10000660e
00000001000067ba	cmpl	$0x2, %edx
00000001000067bd	je	0x10000661f
00000001000067c3	cmpl	$0x1, %edx
00000001000067c6	jne	0x100006630
00000001000067cc	movl	0x8(%r9), %esi
00000001000067d0	movzwl	%r12w, %eax
00000001000067d4	xorl	%edx, %edx
00000001000067d6	divl	%esi
00000001000067d8	cmpl	0xc(%r9), %eax
00000001000067dc	jae	0x100006630
00000001000067e2	movl	$0x1, %edx
00000001000067e7	movl	%eax, %ecx
00000001000067e9	shlq	%cl, %rdx
00000001000067ec	movl	%eax, %ecx
00000001000067ee	shrl	$0x6, %ecx
00000001000067f1	movq	0x28(%r9,%rcx,8), %r10
00000001000067f6	btq	%rax, %r10
00000001000067fa	jb	0x100006630
0000000100006800	orq	%rdx, %r10
0000000100006803	movq	%r10, 0x28(%r9,%rcx,8)
0000000100006808	cmpb	$0x1, 0x1(%r9)
000000010000680d	je	0x100006630
0000000100006813	andq	$-0x10000, %r8                  ## imm = 0xFFFF0000
000000010000681a	addq	%r8, %rdi
000000010000681d	imulq	%rsi, %rax
0000000100006821	addq	%rdi, %rax
0000000100006824	movq	%rax, %rdi
0000000100006827	jmp	0x100006844
0000000100006829	movb	$0x1, 0x3(%r9)
000000010000682e	cmpb	$0x1, 0x1(%r9)
0000000100006833	je	0x100006630
0000000100006839	shlq	$0x10, %rax
000000010000683d	addq	%rax, %rdi
0000000100006840	movq	0x18(%r9), %rsi
0000000100006844	callq	_fwp_gc_push
0000000100006849	movq	-0x30(%rbp), %r11
000000010000684d	jmp	0x100006630
0000000100006852	nopw	%cs:(%rax,%rax)
_fwp_gc_push:
0000000100006860	pushq	%rbp
0000000100006861	movq	%rsp, %rbp
0000000100006864	pushq	%r14
0000000100006866	pushq	%rbx
0000000100006867	movq	%rsi, %rbx
000000010000686a	movq	%rdi, %r14
000000010000686d	movq	0x10934(%rip), %rcx
0000000100006874	movq	0x10925(%rip), %rax
000000010000687b	cmpq	0x1092e(%rip), %rcx
0000000100006882	jne	0x1000068ba
0000000100006884	leaq	(%rcx,%rcx), %rdx
0000000100006888	testq	%rcx, %rcx
000000010000688b	movl	$0x1000, %esi                   ## imm = 0x1000
0000000100006890	cmovneq	%rdx, %rsi
0000000100006894	movq	%rsi, 0x10915(%rip)
000000010000689b	shlq	$0x4, %rsi
000000010000689f	movq	%rax, %rdi
00000001000068a2	callq	0x100012cea                     ## symbol stub for: _realloc
00000001000068a7	movq	%rax, 0x108f2(%rip)
00000001000068ae	testq	%rax, %rax
00000001000068b1	je	0x1000068d9
00000001000068b3	movq	0x108ee(%rip), %rcx
00000001000068ba	movq	%rcx, %rdx
00000001000068bd	shlq	$0x4, %rdx
00000001000068c1	movq	%r14, (%rax,%rdx)
00000001000068c5	movq	%rbx, 0x8(%rax,%rdx)
00000001000068ca	incq	%rcx
00000001000068cd	movq	%rcx, 0x108d4(%rip)
00000001000068d4	popq	%rbx
00000001000068d5	popq	%r14
00000001000068d7	popq	%rbp
00000001000068d8	retq
00000001000068d9	movq	0xe758(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000068e0	movq	(%rax), %rcx
00000001000068e3	leaq	0xcb94(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000068ea	movl	$0x13, %esi
00000001000068ef	movl	$0x1, %edx
00000001000068f4	callq	0x100012c78                     ## symbol stub for: _fwrite
00000001000068f9	movl	$0x66, %edi
00000001000068fe	callq	0x100012c48                     ## symbol stub for: _exit
0000000100006903	nopw	%cs:(%rax,%rax)
_f29:
0000000100006910	pushq	%rbp
0000000100006911	movq	%rsp, %rbp
0000000100006914	pushq	%r15
0000000100006916	pushq	%r14
0000000100006918	pushq	%r13
000000010000691a	pushq	%r12
000000010000691c	pushq	%rbx
000000010000691d	subq	$0x168, %rsp                    ## imm = 0x168
0000000100006924	movq	%rdi, %rbx
0000000100006927	movq	0xe702(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000692e	movq	(%rax), %rax
0000000100006931	movq	%rax, -0x30(%rbp)
0000000100006935	movq	%rdi, -0xe8(%rbp)
000000010000693c	movq	_fwp_cleanups(%rip), %rax
0000000100006943	movq	%rax, -0xe0(%rbp)
000000010000694a	leaq	_fwp_owner_release8(%rip), %rax
0000000100006951	movq	%rax, -0xd8(%rbp)
0000000100006958	leaq	-0xe8(%rbp), %rax
000000010000695f	movq	%rax, -0xd0(%rbp)
0000000100006966	movq	$0x0, -0xc0(%rbp)
0000000100006971	leaq	-0xe0(%rbp), %r12
0000000100006978	movq	%r12, -0x128(%rbp)
000000010000697f	leaq	_fwp_owner_release9(%rip), %rax
0000000100006986	movq	%rax, -0x120(%rbp)
000000010000698d	leaq	-0xc0(%rbp), %rax
0000000100006994	movq	%rax, -0x118(%rbp)
000000010000699b	leaq	-0x128(%rbp), %r15
00000001000069a2	movq	%r15, _fwp_cleanups(%rip)
00000001000069a9	movq	0x10(%rdi), %rax
00000001000069ad	subq	0x10684(%rip), %rax
00000001000069b4	movq	0x106a5(%rip), %rcx
00000001000069bb	shlq	$0x10, %rcx
00000001000069bf	cmpq	%rcx, %rax
00000001000069c2	jae	0x100006a2c
00000001000069c4	movq	0x106b5(%rip), %rcx
00000001000069cb	movq	%rax, %rdx
00000001000069ce	shrq	$0x10, %rdx
00000001000069d2	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000069d9	leaq	(%rcx,%rdx), %rdi
00000001000069dd	movzbl	(%rcx,%rdx), %ecx
00000001000069e1	cmpb	$0x2, %cl
00000001000069e4	setne	%dl
00000001000069e7	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000069ed	setne	%sil
00000001000069f1	orb	%dl, %sil
00000001000069f4	jne	0x1000069ff
00000001000069f6	addq	$0x228, %rdi                    ## imm = 0x228
00000001000069fd	jmp	0x100006a19
00000001000069ff	cmpb	$0x1, %cl
0000000100006a02	jne	0x100006a2c
0000000100006a04	movl	0x20(%rdi), %ecx
0000000100006a07	imulq	%rcx, %rax
0000000100006a0b	shrq	$0x20, %rax
0000000100006a0f	addq	%rax, %rdi
0000000100006a12	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006a19	movzbl	(%rdi), %eax
0000000100006a1c	testb	%al, %al
0000000100006a1e	je	0x100006a2c
0000000100006a20	cmpb	$-0x3, %al
0000000100006a22	ja	0x100006fe6
0000000100006a28	incb	%al
0000000100006a2a	movb	%al, (%rdi)
0000000100006a2c	movq	0x10(%rbx), %r14
0000000100006a30	movq	%r14, -0xc0(%rbp)
0000000100006a37	movq	-0x128(%rbp), %rax
0000000100006a3e	movq	0x8(%rbx), %r13
0000000100006a42	movsd	0x18(%rbx), %xmm0
0000000100006a47	movq	%r14, -0x110(%rbp)
0000000100006a4e	movq	%rax, -0x170(%rbp)
0000000100006a55	leaq	_fwp_owner_release0(%rip), %rax
0000000100006a5c	movq	%rax, -0x168(%rbp)
0000000100006a63	leaq	-0x110(%rbp), %rax
0000000100006a6a	movq	%rax, -0x160(%rbp)
0000000100006a71	leaq	-0x170(%rbp), %rax
0000000100006a78	movq	%rax, _fwp_cleanups(%rip)
0000000100006a7f	testq	%r13, %r13
0000000100006a82	js	0x100006ac0
0000000100006a84	movq	(%r14), %rsi
0000000100006a87	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100006a91	andq	%rsi, %rcx
0000000100006a94	cmpq	%r13, %rcx
0000000100006a97	jbe	0x100006ac0
0000000100006a99	movl	_d0(%rip), %ecx
0000000100006a9f	movl	$0x8, %edx
0000000100006aa4	cmpq	$0xa, %rcx
0000000100006aa8	ja	0x100006ab5
0000000100006aaa	leaq	0xc6a7(%rip), %rdx
0000000100006ab1	movq	(%rdx,%rcx,8), %rdx
0000000100006ab5	testq	%rsi, %rsi
0000000100006ab8	js	0x100006ac7
0000000100006aba	leaq	0x8(%r14), %rsi
0000000100006abe	jmp	0x100006acb
0000000100006ac0	xorl	%ecx, %ecx
0000000100006ac2	xorl	%r15d, %r15d
0000000100006ac5	jmp	0x100006b13
0000000100006ac7	movq	0x10(%r14), %rsi
0000000100006acb	movq	%rdx, %rdi
0000000100006ace	imulq	%r13, %rdi
0000000100006ad2	cmpq	$0x1, %rdx
0000000100006ad6	je	0x100006af7
0000000100006ad8	cmpq	$0x2, %rdx
0000000100006adc	je	0x100006aea
0000000100006ade	cmpq	$0x8, %rdx
0000000100006ae2	jne	0x100006b04
0000000100006ae4	movq	(%rsi,%rdi), %r15
0000000100006ae8	jmp	0x100006b11
0000000100006aea	movzwl	(%rsi,%rdi), %edx
0000000100006aee	cmpl	$0x1, %ecx
0000000100006af1	movswq	%dx, %r15
0000000100006af5	jmp	0x100006b0d
0000000100006af7	movzbl	(%rsi,%rdi), %edx
0000000100006afb	testq	%rcx, %rcx
0000000100006afe	movsbq	%dl, %r15
0000000100006b02	jmp	0x100006b0d
0000000100006b04	movl	(%rsi,%rdi), %edx
0000000100006b07	cmpl	$0x2, %ecx
0000000100006b0a	movslq	%edx, %r15
0000000100006b0d	cmovneq	%rdx, %r15
0000000100006b11	movb	$0x1, %cl
0000000100006b13	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006b1a	jne	0x10000701a
0000000100006b20	movq	-0x170(%rbp), %rax
0000000100006b27	movq	%rax, _fwp_cleanups(%rip)
0000000100006b2e	testb	%cl, %cl
0000000100006b30	movsd	%xmm0, -0xb8(%rbp)
0000000100006b38	je	0x100006c14
0000000100006b3e	movq	%r14, -0x108(%rbp)
0000000100006b45	movq	%rax, -0x188(%rbp)
0000000100006b4c	leaq	_fwp_owner_release1(%rip), %rcx
0000000100006b53	movq	%rcx, -0x180(%rbp)
0000000100006b5a	leaq	-0x108(%rbp), %rcx
0000000100006b61	movq	%rcx, -0x178(%rbp)
0000000100006b68	leaq	-0x188(%rbp), %rcx
0000000100006b6f	movq	%rcx, _fwp_cleanups(%rip)
0000000100006b76	incq	%r13
0000000100006b79	jo	0x100007024
0000000100006b7f	movq	%r14, -0x100(%rbp)
0000000100006b86	movq	%rax, -0x90(%rbp)
0000000100006b8d	leaq	_fwp_owner_release4(%rip), %rax
0000000100006b94	movq	%rax, -0x88(%rbp)
0000000100006b9b	leaq	-0x100(%rbp), %rax
0000000100006ba2	movq	%rax, -0x80(%rbp)
0000000100006ba6	leaq	-0x90(%rbp), %r12
0000000100006bad	movq	%r14, %rax
0000000100006bb0	subq	0x10481(%rip), %rax
0000000100006bb7	movq	%r12, _fwp_cleanups(%rip)
0000000100006bbe	movq	0x1049b(%rip), %rcx
0000000100006bc5	shlq	$0x10, %rcx
0000000100006bc9	cmpq	%rcx, %rax
0000000100006bcc	jae	0x100006d1d
0000000100006bd2	movq	0x104a7(%rip), %rcx
0000000100006bd9	movq	%rax, %rdx
0000000100006bdc	shrq	$0x10, %rdx
0000000100006be0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006be7	leaq	(%rcx,%rdx), %rdi
0000000100006beb	movzbl	(%rcx,%rdx), %ecx
0000000100006bef	cmpb	$0x2, %cl
0000000100006bf2	setne	%dl
0000000100006bf5	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006bfb	setne	%sil
0000000100006bff	orb	%dl, %sil
0000000100006c02	jne	0x100006cf0
0000000100006c08	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006c0f	jmp	0x100006d0a
0000000100006c14	movq	%r14, %rdi
0000000100006c17	callq	_fwp_drop2
0000000100006c1c	movsd	-0xb8(%rbp), %xmm0
0000000100006c24	movsd	%xmm0, -0x90(%rbp)
0000000100006c2c	movl	$0x10, %edi
0000000100006c31	callq	_fwp_alloc_init
0000000100006c36	movq	%rax, %r14
0000000100006c39	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100006c43	movq	%rax, (%r14)
0000000100006c46	movsd	-0xb8(%rbp), %xmm0
0000000100006c4e	movsd	%xmm0, 0x8(%r14)
0000000100006c54	leaq	-0x90(%rbp), %rax
0000000100006c5b	movq	%r14, %rax
0000000100006c5e	subq	0x103d3(%rip), %rax
0000000100006c65	movq	0x103f4(%rip), %rcx
0000000100006c6c	shlq	$0x10, %rcx
0000000100006c70	cmpq	%rcx, %rax
0000000100006c73	jae	0x100006fa2
0000000100006c79	movq	0x10400(%rip), %rcx
0000000100006c80	movq	%rax, %rdx
0000000100006c83	shrq	$0x10, %rdx
0000000100006c87	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006c8e	leaq	(%rcx,%rdx), %r15
0000000100006c92	movzbl	(%rcx,%rdx), %ecx
0000000100006c96	cmpb	$0x2, %cl
0000000100006c99	setne	%dl
0000000100006c9c	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006ca2	setne	%sil
0000000100006ca6	orb	%dl, %sil
0000000100006ca9	jne	0x100006cc1
0000000100006cab	addq	$0x228, %r15                    ## imm = 0x228
0000000100006cb2	cmpb	$-0x1, (%r15)
0000000100006cb6	je	0x100006ce6
0000000100006cb8	movb	$0x1, (%r15)
0000000100006cbc	jmp	0x100006fa2
0000000100006cc1	cmpb	$0x1, %cl
0000000100006cc4	jne	0x100006fa2
0000000100006cca	movl	0x20(%r15), %ecx
0000000100006cce	imulq	%rcx, %rax
0000000100006cd2	shrq	$0x20, %rax
0000000100006cd6	addq	%rax, %r15
0000000100006cd9	addq	$0x228, %r15                    ## imm = 0x228
0000000100006ce0	cmpb	$-0x1, (%r15)
0000000100006ce4	jne	0x100006cb8
0000000100006ce6	movq	%r15, %rdi
0000000100006ce9	callq	_fwp_rc_forget_slot
0000000100006cee	jmp	0x100006cb8
0000000100006cf0	cmpb	$0x1, %cl
0000000100006cf3	jne	0x100006d1d
0000000100006cf5	movl	0x20(%rdi), %ecx
0000000100006cf8	imulq	%rcx, %rax
0000000100006cfc	shrq	$0x20, %rax
0000000100006d00	addq	%rax, %rdi
0000000100006d03	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006d0a	movzbl	(%rdi), %eax
0000000100006d0d	testb	%al, %al
0000000100006d0f	je	0x100006d1d
0000000100006d11	cmpb	$-0x3, %al
0000000100006d13	ja	0x100007008
0000000100006d19	incb	%al
0000000100006d1b	movb	%al, (%rdi)
0000000100006d1d	movq	%r15, %xmm0
0000000100006d22	mulsd	0xc1b6(%rip), %xmm0
0000000100006d2a	addsd	0xc1b6(%rip), %xmm0
0000000100006d32	movsd	%xmm0, -0xc8(%rbp)
0000000100006d3a	movq	-0x90(%rbp), %rax
0000000100006d41	movq	%rax, _fwp_cleanups(%rip)
0000000100006d48	movq	%r14, %rdi
0000000100006d4b	callq	_fwp_drop2
0000000100006d50	movq	_fwp_cleanups(%rip), %rax
0000000100006d57	movsd	-0xb8(%rbp), %xmm0
0000000100006d5f	addsd	-0xc8(%rbp), %xmm0
0000000100006d67	movsd	%xmm0, -0xb8(%rbp)
0000000100006d6f	movq	%r14, -0xf8(%rbp)
0000000100006d76	movq	%rax, -0x158(%rbp)
0000000100006d7d	leaq	_fwp_owner_release6(%rip), %rax
0000000100006d84	movq	%rax, -0x150(%rbp)
0000000100006d8b	leaq	-0xf8(%rbp), %rax
0000000100006d92	movq	%rax, -0x148(%rbp)
0000000100006d99	leaq	-0x158(%rbp), %r12
0000000100006da0	movq	%r12, _fwp_cleanups(%rip)
0000000100006da7	movq	%r13, -0xa8(%rbp)
0000000100006dae	movq	%r14, -0xa0(%rbp)
0000000100006db5	movsd	%xmm0, -0x98(%rbp)
0000000100006dbd	movl	$0x20, %edi
0000000100006dc2	callq	_fwp_alloc_init
0000000100006dc7	movq	%rax, %r15
0000000100006dca	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100006dd4	movq	%rax, (%r15)
0000000100006dd7	movq	%r13, 0x8(%r15)
0000000100006ddb	movq	%r14, 0x10(%r15)
0000000100006ddf	movsd	-0xb8(%rbp), %xmm0
0000000100006de7	movsd	%xmm0, 0x18(%r15)
0000000100006ded	leaq	-0xa8(%rbp), %rax
0000000100006df4	movq	%r15, %rax
0000000100006df7	subq	0x1023a(%rip), %rax
0000000100006dfe	movq	0x1025b(%rip), %rcx
0000000100006e05	shlq	$0x10, %rcx
0000000100006e09	cmpq	%rcx, %rax
0000000100006e0c	jae	0x100006e7e
0000000100006e0e	movq	0x1026b(%rip), %rcx
0000000100006e15	movq	%rax, %rdx
0000000100006e18	shrq	$0x10, %rdx
0000000100006e1c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006e23	leaq	(%rcx,%rdx), %r14
0000000100006e27	movzbl	(%rcx,%rdx), %ecx
0000000100006e2b	cmpb	$0x2, %cl
0000000100006e2e	setne	%dl
0000000100006e31	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006e37	setne	%sil
0000000100006e3b	orb	%dl, %sil
0000000100006e3e	jne	0x100006e53
0000000100006e40	addq	$0x228, %r14                    ## imm = 0x228
0000000100006e47	cmpb	$-0x1, (%r14)
0000000100006e4b	je	0x100006e74
0000000100006e4d	movb	$0x1, (%r14)
0000000100006e51	jmp	0x100006e7e
0000000100006e53	cmpb	$0x1, %cl
0000000100006e56	jne	0x100006e7e
0000000100006e58	movl	0x20(%r14), %ecx
0000000100006e5c	imulq	%rcx, %rax
0000000100006e60	shrq	$0x20, %rax
0000000100006e64	addq	%rax, %r14
0000000100006e67	addq	$0x228, %r14                    ## imm = 0x228
0000000100006e6e	cmpb	$-0x1, (%r14)
0000000100006e72	jne	0x100006e4d
0000000100006e74	movq	%r14, %rdi
0000000100006e77	callq	_fwp_rc_forget_slot
0000000100006e7c	jmp	0x100006e4d
0000000100006e7e	cmpq	%r12, _fwp_cleanups(%rip)
0000000100006e85	jne	0x10000701a
0000000100006e8b	movq	-0x158(%rbp), %rax
0000000100006e92	movq	%r15, -0xf0(%rbp)
0000000100006e99	movq	%rax, -0x140(%rbp)
0000000100006ea0	leaq	_fwp_owner_release7(%rip), %rax
0000000100006ea7	movq	%rax, -0x138(%rbp)
0000000100006eae	leaq	-0xf0(%rbp), %rax
0000000100006eb5	movq	%rax, -0x130(%rbp)
0000000100006ebc	leaq	-0x140(%rbp), %r12
0000000100006ec3	movq	%r12, _fwp_cleanups(%rip)
0000000100006eca	movq	%r15, -0xb0(%rbp)
0000000100006ed1	movl	$0x10, %edi
0000000100006ed6	callq	_fwp_alloc_init
0000000100006edb	movq	%rax, %r14
0000000100006ede	movabsq	$__mh_execute_header, %rax
0000000100006ee8	movq	%rax, (%r14)
0000000100006eeb	movq	%r15, 0x8(%r14)
0000000100006eef	leaq	-0xb0(%rbp), %rax
0000000100006ef6	movq	%r14, %rax
0000000100006ef9	subq	0x10138(%rip), %rax
0000000100006f00	movq	0x10159(%rip), %rcx
0000000100006f07	shlq	$0x10, %rcx
0000000100006f0b	cmpq	%rcx, %rax
0000000100006f0e	jae	0x100006f80
0000000100006f10	movq	0x10169(%rip), %rcx
0000000100006f17	movq	%rax, %rdx
0000000100006f1a	shrq	$0x10, %rdx
0000000100006f1e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006f25	leaq	(%rcx,%rdx), %r15
0000000100006f29	movzbl	(%rcx,%rdx), %ecx
0000000100006f2d	cmpb	$0x2, %cl
0000000100006f30	setne	%dl
0000000100006f33	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006f39	setne	%sil
0000000100006f3d	orb	%dl, %sil
0000000100006f40	jne	0x100006f55
0000000100006f42	addq	$0x228, %r15                    ## imm = 0x228
0000000100006f49	cmpb	$-0x1, (%r15)
0000000100006f4d	je	0x100006f76
0000000100006f4f	movb	$0x1, (%r15)
0000000100006f53	jmp	0x100006f80
0000000100006f55	cmpb	$0x1, %cl
0000000100006f58	jne	0x100006f80
0000000100006f5a	movl	0x20(%r15), %ecx
0000000100006f5e	imulq	%rcx, %rax
0000000100006f62	shrq	$0x20, %rax
0000000100006f66	addq	%rax, %r15
0000000100006f69	addq	$0x228, %r15                    ## imm = 0x228
0000000100006f70	cmpb	$-0x1, (%r15)
0000000100006f74	jne	0x100006f4f
0000000100006f76	movq	%r15, %rdi
0000000100006f79	callq	_fwp_rc_forget_slot
0000000100006f7e	jmp	0x100006f4f
0000000100006f80	cmpq	%r12, _fwp_cleanups(%rip)
0000000100006f87	jne	0x10000701a
0000000100006f8d	movq	-0x140(%rbp), %rax
0000000100006f94	movq	%rax, _fwp_cleanups(%rip)
0000000100006f9b	leaq	-0xe0(%rbp), %r12
0000000100006fa2	cmpq	%r12, _fwp_cleanups(%rip)
0000000100006fa9	jne	0x10000701a
0000000100006fab	movq	-0xe0(%rbp), %rax
0000000100006fb2	movq	%rax, _fwp_cleanups(%rip)
0000000100006fb9	movq	%rbx, %rdi
0000000100006fbc	callq	_fwp_drop1
0000000100006fc1	movq	0xe068(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006fc8	movq	(%rax), %rax
0000000100006fcb	cmpq	-0x30(%rbp), %rax
0000000100006fcf	jne	0x10000701f
0000000100006fd1	movq	%r14, %rax
0000000100006fd4	addq	$0x168, %rsp                    ## imm = 0x168
0000000100006fdb	popq	%rbx
0000000100006fdc	popq	%r12
0000000100006fde	popq	%r13
0000000100006fe0	popq	%r14
0000000100006fe2	popq	%r15
0000000100006fe4	popq	%rbp
0000000100006fe5	retq
0000000100006fe6	callq	_fwp_rc_wide_dup
0000000100006feb	movq	_fwp_cleanups(%rip), %rax
0000000100006ff2	movq	0x10(%rbx), %r14
0000000100006ff6	movq	%r14, -0xc0(%rbp)
0000000100006ffd	cmpq	%r15, %rax
0000000100007000	je	0x100006a37
0000000100007006	jmp	0x10000701a
0000000100007008	callq	_fwp_rc_wide_dup
000000010000700d	cmpq	%r12, _fwp_cleanups(%rip)
0000000100007014	je	0x100006d1d
000000010000701a	callq	0x100012c2a                     ## symbol stub for: _abort
000000010000701f	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100007024	leaq	0xc3fb(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000702b	leaq	0xc3f0(%rip), %rcx              ## literal pool for: "I64"
0000000100007032	leaq	-0x90(%rbp), %rbx
0000000100007039	movl	$0x60, %esi
000000010000703e	movq	%rbx, %rdi
0000000100007041	xorl	%eax, %eax
0000000100007043	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100007048	callq	_fwp_flush
000000010000704d	movq	0xdfe4(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100007054	movq	(%rax), %rdi
0000000100007057	leaq	0xc3b1(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000705e	movq	%rbx, %rdx
0000000100007061	xorl	%eax, %eax
0000000100007063	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100007068	movl	$0x65, %edi
000000010000706d	callq	0x100012c48                     ## symbol stub for: _exit
0000000100007072	nopw	%cs:(%rax,%rax)
_fwp_owner_release8:
0000000100007080	pushq	%rbp
0000000100007081	movq	%rsp, %rbp
0000000100007084	movq	(%rdi), %rdi
0000000100007087	popq	%rbp
0000000100007088	jmp	_fwp_drop1
000000010000708d	nopl	(%rax)
_fwp_owner_release9:
0000000100007090	pushq	%rbp
0000000100007091	movq	%rsp, %rbp
0000000100007094	movq	(%rdi), %rdi
0000000100007097	popq	%rbp
0000000100007098	jmp	_fwp_drop2
000000010000709d	nopl	(%rax)
_fwp_drop1:
00000001000070a0	movq	%rdi, %rcx
00000001000070a3	subq	0xff8e(%rip), %rcx
00000001000070aa	movq	0xffaf(%rip), %rax
00000001000070b1	shlq	$0x10, %rax
00000001000070b5	cmpq	%rax, %rcx
00000001000070b8	jae	0x10000714e
00000001000070be	movq	0xffbb(%rip), %rdx
00000001000070c5	movq	%rcx, %rax
00000001000070c8	shrq	$0x10, %rax
00000001000070cc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000070d3	leaq	(%rdx,%rsi), %rax
00000001000070d7	movzbl	(%rdx,%rsi), %edx
00000001000070db	cmpb	$0x2, %dl
00000001000070de	setne	%sil
00000001000070e2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000070e9	setne	%r8b
00000001000070ed	orb	%sil, %r8b
00000001000070f0	jne	0x1000070fa
00000001000070f2	addq	$0x228, %rax                    ## imm = 0x228
00000001000070f8	jmp	0x100007113
00000001000070fa	cmpb	$0x1, %dl
00000001000070fd	jne	0x10000714e
00000001000070ff	movl	0x20(%rax), %edx
0000000100007102	imulq	%rdx, %rcx
0000000100007106	shrq	$0x20, %rcx
000000010000710a	addq	%rcx, %rax
000000010000710d	addq	$0x228, %rax                    ## imm = 0x228
0000000100007113	movzbl	(%rax), %ecx
0000000100007116	testl	%ecx, %ecx
0000000100007118	je	0x10000714e
000000010000711a	cmpl	$0x1, %ecx
000000010000711d	jne	0x100007142
000000010000711f	pushq	%rbp
0000000100007120	movq	%rsp, %rbp
0000000100007123	pushq	%rbx
0000000100007124	pushq	%rax
0000000100007125	movq	0x10(%rdi), %rax
0000000100007129	movq	%rdi, %rbx
000000010000712c	movq	%rax, %rdi
000000010000712f	callq	_fwp_drop2
0000000100007134	movq	%rbx, %rdi
0000000100007137	addq	$0x8, %rsp
000000010000713b	popq	%rbx
000000010000713c	popq	%rbp
000000010000713d	jmp	_fwp_rc_free_obj
0000000100007142	cmpl	$0xff, %ecx
0000000100007148	je	0x10000714f
000000010000714a	decb	%cl
000000010000714c	movb	%cl, (%rax)
000000010000714e	retq
000000010000714f	movq	%rax, %rdi
0000000100007152	jmp	_fwp_rc_wide_drop
0000000100007157	nopw	(%rax,%rax)
_fwp_owner_release0:
0000000100007160	pushq	%rbp
0000000100007161	movq	%rsp, %rbp
0000000100007164	movq	(%rdi), %rdi
0000000100007167	popq	%rbp
0000000100007168	jmp	_fwp_drop2
000000010000716d	nopl	(%rax)
_fwp_owner_release1:
0000000100007170	pushq	%rbp
0000000100007171	movq	%rsp, %rbp
0000000100007174	movq	(%rdi), %rdi
0000000100007177	popq	%rbp
0000000100007178	jmp	_fwp_drop2
000000010000717d	nopl	(%rax)
_fwp_owner_release4:
0000000100007180	pushq	%rbp
0000000100007181	movq	%rsp, %rbp
0000000100007184	movq	(%rdi), %rdi
0000000100007187	popq	%rbp
0000000100007188	jmp	_fwp_drop2
000000010000718d	nopl	(%rax)
_fwp_owner_release6:
0000000100007190	pushq	%rbp
0000000100007191	movq	%rsp, %rbp
0000000100007194	movq	(%rdi), %rdi
0000000100007197	popq	%rbp
0000000100007198	jmp	_fwp_drop2
000000010000719d	nopl	(%rax)
_fwp_record:
00000001000071a0	testl	%edi, %edi
00000001000071a2	je	0x100007252
00000001000071a8	pushq	%rbp
00000001000071a9	movq	%rsp, %rbp
00000001000071ac	pushq	%r15
00000001000071ae	pushq	%r14
00000001000071b0	pushq	%rbx
00000001000071b1	pushq	%rax
00000001000071b2	movq	%rsi, %rbx
00000001000071b5	movl	%edi, %r14d
00000001000071b8	leaq	0x8(,%r14,8), %rax
00000001000071c0	movl	%edi, %r15d
00000001000071c3	movq	%rax, %rdi
00000001000071c6	callq	_fwp_alloc_init
00000001000071cb	movl	$0x0, (%rax)
00000001000071d1	movl	%r15d, 0x4(%rax)
00000001000071d5	cmpl	$0x8, %r15d
00000001000071d9	jb	0x1000071eb
00000001000071db	movq	%rax, %rcx
00000001000071de	subq	%rbx, %rcx
00000001000071e1	addq	$0x8, %rcx
00000001000071e5	cmpq	$0x20, %rcx
00000001000071e9	jae	0x100007255
00000001000071eb	xorl	%ecx, %ecx
00000001000071ed	movq	%r14, %rsi
00000001000071f0	movq	%rcx, %rdx
00000001000071f3	andq	$0x3, %rsi
00000001000071f7	je	0x100007211
00000001000071f9	movq	%rcx, %rdx
00000001000071fc	nopl	(%rax)
0000000100007200	movq	(%rbx,%rdx,8), %rdi
0000000100007204	movq	%rdi, 0x8(%rax,%rdx,8)
0000000100007209	incq	%rdx
000000010000720c	decq	%rsi
000000010000720f	jne	0x100007200
0000000100007211	subq	%r14, %rcx
0000000100007214	cmpq	$-0x4, %rcx
0000000100007218	ja	0x100007295
000000010000721a	nopw	(%rax,%rax)
0000000100007220	movq	(%rbx,%rdx,8), %rcx
0000000100007224	movq	%rcx, 0x8(%rax,%rdx,8)
0000000100007229	movq	0x8(%rbx,%rdx,8), %rcx
000000010000722e	movq	%rcx, 0x10(%rax,%rdx,8)
0000000100007233	movq	0x10(%rbx,%rdx,8), %rcx
0000000100007238	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000723d	movq	0x18(%rbx,%rdx,8), %rcx
0000000100007242	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100007247	addq	$0x4, %rdx
000000010000724b	cmpq	%rdx, %r14
000000010000724e	jne	0x100007220
0000000100007250	jmp	0x100007295
0000000100007252	xorl	%eax, %eax
0000000100007254	retq
0000000100007255	movl	%r14d, %ecx
0000000100007258	andl	$-0x4, %ecx
000000010000725b	leaq	(,%r14,8), %rdx
0000000100007263	andq	$-0x20, %rdx
0000000100007267	xorl	%esi, %esi
0000000100007269	nopl	(%rax)
0000000100007270	movups	(%rbx,%rsi), %xmm0
0000000100007274	movups	0x10(%rbx,%rsi), %xmm1
0000000100007279	movups	%xmm0, 0x8(%rax,%rsi)
000000010000727e	movups	%xmm1, 0x18(%rax,%rsi)
0000000100007283	addq	$0x20, %rsi
0000000100007287	cmpq	%rsi, %rdx
000000010000728a	jne	0x100007270
000000010000728c	cmpl	%r14d, %ecx
000000010000728f	jne	0x1000071ed
0000000100007295	addq	$0x8, %rsp
0000000100007299	popq	%rbx
000000010000729a	popq	%r14
000000010000729c	popq	%r15
000000010000729e	popq	%rbp
000000010000729f	retq
_fwp_owner_release7:
00000001000072a0	pushq	%rbp
00000001000072a1	movq	%rsp, %rbp
00000001000072a4	movq	(%rdi), %rax
00000001000072a7	subq	0xfd8a(%rip), %rax
00000001000072ae	movq	0xfdab(%rip), %rcx
00000001000072b5	shlq	$0x10, %rcx
00000001000072b9	cmpq	%rcx, %rax
00000001000072bc	jae	0x100007322
00000001000072be	movq	0xfdbb(%rip), %rcx
00000001000072c5	movq	%rax, %rdx
00000001000072c8	shrq	$0x10, %rdx
00000001000072cc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000072d3	leaq	(%rcx,%rdx), %rdi
00000001000072d7	movzbl	(%rcx,%rdx), %ecx
00000001000072db	cmpb	$0x2, %cl
00000001000072de	setne	%dl
00000001000072e1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000072e7	setne	%sil
00000001000072eb	orb	%dl, %sil
00000001000072ee	jne	0x1000072f9
00000001000072f0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000072f7	jmp	0x100007313
00000001000072f9	cmpb	$0x1, %cl
00000001000072fc	jne	0x100007322
00000001000072fe	movl	0x20(%rdi), %ecx
0000000100007301	imulq	%rcx, %rax
0000000100007305	shrq	$0x20, %rax
0000000100007309	addq	%rax, %rdi
000000010000730c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007313	movzbl	(%rdi), %eax
0000000100007316	cmpb	$0x2, %al
0000000100007318	jb	0x100007322
000000010000731a	cmpb	$-0x1, %al
000000010000731c	je	0x100007324
000000010000731e	decb	%al
0000000100007320	movb	%al, (%rdi)
0000000100007322	popq	%rbp
0000000100007323	retq
0000000100007324	popq	%rbp
0000000100007325	jmp	_fwp_rc_wide_drop
000000010000732a	nopw	(%rax,%rax)
_fwp_rc_free_obj:
0000000100007330	pushq	%rbp
0000000100007331	movq	%rsp, %rbp
0000000100007334	pushq	%r15
0000000100007336	pushq	%r14
0000000100007338	pushq	%rbx
0000000100007339	pushq	%rax
000000010000733a	movq	%rdi, %rax
000000010000733d	subq	0xfcf4(%rip), %rax
0000000100007344	movq	0xfd15(%rip), %rcx
000000010000734b	shlq	$0x10, %rcx
000000010000734f	cmpq	%rcx, %rax
0000000100007352	jae	0x10000746f
0000000100007358	movq	0xfd21(%rip), %rcx
000000010000735f	movq	%rax, %rdx
0000000100007362	shrq	$0x10, %rdx
0000000100007366	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000736d	leaq	(%rcx,%rdx), %rbx
0000000100007371	movzbl	(%rcx,%rdx), %r14d
0000000100007376	cmpb	$0x2, %r14b
000000010000737a	setne	%cl
000000010000737d	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007383	setne	%dl
0000000100007386	orb	%cl, %dl
0000000100007388	jne	0x10000739b
000000010000738a	leaq	0x228(%rbx), %rax
0000000100007391	cmpb	$0x1, (%rax)
0000000100007394	je	0x1000073c2
0000000100007396	jmp	0x10000746f
000000010000739b	cmpb	$0x1, %r14b
000000010000739f	jne	0x10000746f
00000001000073a5	movl	0x20(%rbx), %ecx
00000001000073a8	imulq	%rcx, %rax
00000001000073ac	shrq	$0x20, %rax
00000001000073b0	addq	%rbx, %rax
00000001000073b3	addq	$0x228, %rax                    ## imm = 0x228
00000001000073b9	cmpb	$0x1, (%rax)
00000001000073bc	jne	0x10000746f
00000001000073c2	movl	_fwp_reuse_verify(%rip), %eax
00000001000073c8	testl	%eax, %eax
00000001000073ca	js	0x10000742b
00000001000073cc	testl	%eax, %eax
00000001000073ce	je	0x100007444
00000001000073d0	cmpb	$0x1, 0x1(%rbx)
00000001000073d4	jne	0x1000073e2
00000001000073d6	cmpb	$0x2, %r14b
00000001000073da	jne	0x10000740e
00000001000073dc	movq	0x18(%rbx), %rdx
00000001000073e0	jmp	0x100007411
00000001000073e2	movl	$0xdead, (%rdi)                 ## imm = 0xDEAD
00000001000073e8	movl	0x4(%rdi), %edx
00000001000073eb	testq	%rdx, %rdx
00000001000073ee	je	0x10000746f
00000001000073f0	addq	$0x8, %rdi
00000001000073f4	shlq	$0x3, %rdx
00000001000073f8	leaq	0xbac1(%rip), %rsi
00000001000073ff	addq	$0x8, %rsp
0000000100007403	popq	%rbx
0000000100007404	popq	%r14
0000000100007406	popq	%r15
0000000100007408	popq	%rbp
0000000100007409	jmp	0x100012cb4                     ## symbol stub for: _memset_pattern16
000000010000740e	movl	0x8(%rbx), %edx
0000000100007411	movq	%rdi, %rbx
0000000100007414	movl	$0xdd, %esi
0000000100007419	callq	0x100012cae                     ## symbol stub for: _memset
000000010000741e	movq	$0x0, (%rbx)
0000000100007425	movb	$0x0, 0x8(%rbx)
0000000100007429	jmp	0x10000746f
000000010000742b	leaq	-0x1c(%rbp), %rax
000000010000742f	movq	%rdi, %r15
0000000100007432	movq	%rax, %rdi
0000000100007435	callq	_fwp_rc_free_obj.cold.1
000000010000743a	movq	%r15, %rdi
000000010000743d	movl	-0x1c(%rbp), %eax
0000000100007440	testl	%eax, %eax
0000000100007442	jne	0x1000073d0
0000000100007444	movq	_fwp_gc(%rip), %rbx
000000010000744b	callq	_fwp_mem_free
0000000100007450	movq	_fwp_gc(%rip), %rax
0000000100007457	subq	%rbx, %rax
000000010000745a	cvtsi2sd	%rax, %xmm0
000000010000745f	addsd	0xfda9(%rip), %xmm0
0000000100007467	movsd	%xmm0, 0xfda1(%rip)
000000010000746f	addq	$0x8, %rsp
0000000100007473	popq	%rbx
0000000100007474	popq	%r14
0000000100007476	popq	%r15
0000000100007478	popq	%rbp
0000000100007479	retq
000000010000747a	nopw	(%rax,%rax)
_fwp_owned_entry29:
0000000100007480	pushq	%rbp
0000000100007481	movq	%rsp, %rbp
0000000100007484	movq	(%rdi), %rdi
0000000100007487	popq	%rbp
0000000100007488	jmp	_f29
000000010000748d	nopl	(%rax)
_fwp_caps29:
0000000100007490	movl	0x4(%rdi), %eax
0000000100007493	testl	%esi, %esi
0000000100007495	je	0x1000074f9
0000000100007497	testl	%eax, %eax
0000000100007499	je	0x100007551
000000010000749f	movq	0x8(%rdi), %rax
00000001000074a3	subq	0xfb8e(%rip), %rax
00000001000074aa	movq	0xfbaf(%rip), %rcx
00000001000074b1	shlq	$0x10, %rcx
00000001000074b5	cmpq	%rcx, %rax
00000001000074b8	jae	0x100007551
00000001000074be	movq	0xfbbb(%rip), %rcx
00000001000074c5	movq	%rax, %rdx
00000001000074c8	shrq	$0x10, %rdx
00000001000074cc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000074d3	leaq	(%rcx,%rdx), %rdi
00000001000074d7	movzbl	(%rcx,%rdx), %ecx
00000001000074db	cmpb	$0x2, %cl
00000001000074de	setne	%dl
00000001000074e1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000074e7	setne	%sil
00000001000074eb	orb	%dl, %sil
00000001000074ee	jne	0x100007524
00000001000074f0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000074f7	jmp	0x10000753e
00000001000074f9	testl	%eax, %eax
00000001000074fb	je	_fwp_rc_free_obj
0000000100007501	pushq	%rbp
0000000100007502	movq	%rsp, %rbp
0000000100007505	pushq	%rbx
0000000100007506	pushq	%rax
0000000100007507	movq	0x8(%rdi), %rax
000000010000750b	movq	%rdi, %rbx
000000010000750e	movq	%rax, %rdi
0000000100007511	callq	_fwp_drop1
0000000100007516	movq	%rbx, %rdi
0000000100007519	addq	$0x8, %rsp
000000010000751d	popq	%rbx
000000010000751e	popq	%rbp
000000010000751f	jmp	_fwp_rc_free_obj
0000000100007524	cmpb	$0x1, %cl
0000000100007527	jne	0x100007551
0000000100007529	movl	0x20(%rdi), %ecx
000000010000752c	imulq	%rcx, %rax
0000000100007530	shrq	$0x20, %rax
0000000100007534	addq	%rax, %rdi
0000000100007537	addq	$0x228, %rdi                    ## imm = 0x228
000000010000753e	movzbl	(%rdi), %eax
0000000100007541	testb	%al, %al
0000000100007543	je	0x100007551
0000000100007545	cmpb	$-0x2, %al
0000000100007547	jae	_fwp_rc_wide_dup
000000010000754d	incb	%al
000000010000754f	movb	%al, (%rdi)
0000000100007551	retq
0000000100007552	nopw	%cs:(%rax,%rax)
_fwp_args29:
0000000100007560	pushq	%rbp
0000000100007561	movq	%rsp, %rbp
0000000100007564	testl	%esi, %esi
0000000100007566	setne	%al
0000000100007569	testl	%edx, %edx
000000010000756b	sete	%cl
000000010000756e	orb	%al, %cl
0000000100007570	jne	0x1000075f0
0000000100007572	movq	(%rdi), %rax
0000000100007575	subq	0xfabc(%rip), %rax
000000010000757c	movq	0xfadd(%rip), %rcx
0000000100007583	shlq	$0x10, %rcx
0000000100007587	cmpq	%rcx, %rax
000000010000758a	jae	0x1000075f0
000000010000758c	movq	0xfaed(%rip), %rcx
0000000100007593	movq	%rax, %rdx
0000000100007596	shrq	$0x10, %rdx
000000010000759a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000075a1	leaq	(%rcx,%rdx), %rdi
00000001000075a5	movzbl	(%rcx,%rdx), %ecx
00000001000075a9	cmpb	$0x2, %cl
00000001000075ac	setne	%dl
00000001000075af	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000075b5	setne	%sil
00000001000075b9	orb	%dl, %sil
00000001000075bc	jne	0x1000075c7
00000001000075be	addq	$0x228, %rdi                    ## imm = 0x228
00000001000075c5	jmp	0x1000075e1
00000001000075c7	cmpb	$0x1, %cl
00000001000075ca	jne	0x1000075f0
00000001000075cc	movl	0x20(%rdi), %ecx
00000001000075cf	imulq	%rcx, %rax
00000001000075d3	shrq	$0x20, %rax
00000001000075d7	addq	%rax, %rdi
00000001000075da	addq	$0x228, %rdi                    ## imm = 0x228
00000001000075e1	movzbl	(%rdi), %eax
00000001000075e4	testb	%al, %al
00000001000075e6	je	0x1000075f0
00000001000075e8	cmpb	$-0x2, %al
00000001000075ea	jae	0x1000075f2
00000001000075ec	incb	%al
00000001000075ee	movb	%al, (%rdi)
00000001000075f0	popq	%rbp
00000001000075f1	retq
00000001000075f2	popq	%rbp
00000001000075f3	jmp	_fwp_rc_wide_dup
00000001000075f8	nopl	(%rax,%rax)
_fwp_arg_drop29:
0000000100007600	pushq	%rbp
0000000100007601	movq	%rsp, %rbp
0000000100007604	testl	%esi, %esi
0000000100007606	setne	%al
0000000100007609	testl	%edx, %edx
000000010000760b	sete	%cl
000000010000760e	orb	%al, %cl
0000000100007610	je	0x100007614
0000000100007612	popq	%rbp
0000000100007613	retq
0000000100007614	movq	(%rdi), %rdi
0000000100007617	popq	%rbp
0000000100007618	jmp	_fwp_drop1
000000010000761d	nopl	(%rax)
_fwp_p_loop_own:
0000000100007620	pushq	%rbp
0000000100007621	movq	%rsp, %rbp
0000000100007624	pushq	%r15
0000000100007626	pushq	%r14
0000000100007628	pushq	%r13
000000010000762a	pushq	%r12
000000010000762c	pushq	%rbx
000000010000762d	subq	$0xe8, %rsp
0000000100007634	movq	%rdi, -0x78(%rbp)
0000000100007638	movq	%rsi, -0x38(%rbp)
000000010000763c	movq	%rsi, -0x70(%rbp)
0000000100007640	movq	%rdx, -0x68(%rbp)
0000000100007644	testq	%rdx, %rdx
0000000100007647	je	0x10000768c
0000000100007649	movq	_fwp_cleanups(%rip), %rax
0000000100007650	movq	%rax, -0x90(%rbp)
0000000100007657	leaq	_fwp_value_release(%rip), %rax
000000010000765e	movq	%rax, -0x88(%rbp)
0000000100007665	leaq	-0x70(%rbp), %rax
0000000100007669	movq	%rax, -0x80(%rbp)
000000010000766d	leaq	-0x90(%rbp), %rax
0000000100007674	movq	%rax, _fwp_cleanups(%rip)
000000010000767b	jmp	0x10000768c
000000010000767d	nopl	(%rax)
0000000100007680	incb	%al
0000000100007682	movb	%al, (%rdi)
0000000100007684	movq	%rsi, -0x38(%rbp)
0000000100007688	movq	%rsi, -0x70(%rbp)
000000010000768c	movl	_fwp_budget(%rip), %eax
0000000100007692	leal	-0x1(%rax), %ecx
0000000100007695	movl	%ecx, _fwp_budget(%rip)
000000010000769b	cmpl	$0x1, %eax
000000010000769e	jle	0x100007c1c
00000001000076a4	movq	%rsi, -0x38(%rbp)
00000001000076a8	movq	$0x0, -0x70(%rbp)
00000001000076b0	movq	_fwp_fns(%rip), %rcx
00000001000076b7	movq	-0x78(%rbp), %r9
00000001000076bb	movl	(%r9), %edx
00000001000076be	shlq	$0x5, %rdx
00000001000076c2	movq	0x18(%rcx,%rdx), %rax
00000001000076c7	testq	%rax, %rax
00000001000076ca	je	0x100007ae0
00000001000076d0	leaq	(%rcx,%rdx), %r11
00000001000076d4	leaq	(%rcx,%rdx), %r12
00000001000076d8	addq	$0x18, %r12
00000001000076dc	movl	$0x1, %r13d
00000001000076e2	xorl	%ecx, %ecx
00000001000076e4	leaq	-0x38(%rbp), %rdx
00000001000076e8	movl	$0x1, %r10d
00000001000076ee	nop
00000001000076f0	testb	$0x1, %cl
00000001000076f3	movl	$0x0, %esi
00000001000076f8	cmovneq	%r9, %rsi
00000001000076fc	movq	%rsi, -0x110(%rbp)
0000000100007703	movq	%rdx, -0x108(%rbp)
000000010000770a	movq	%rax, -0x100(%rbp)
0000000100007711	movl	$0x0, -0xf8(%rbp)
000000010000771b	movl	0x4(%r9), %esi
000000010000771f	movl	%esi, -0xf4(%rbp)
0000000100007725	movq	%r9, %r15
0000000100007728	subq	0xf909(%rip), %r15
000000010000772f	movl	%r10d, -0xf0(%rbp)
0000000100007736	movq	0xf923(%rip), %rsi
000000010000773d	shlq	$0x10, %rsi
0000000100007741	cmpq	%rsi, %r15
0000000100007744	movq	%rdx, -0x48(%rbp)
0000000100007748	jae	0x1000077f0
000000010000774e	movq	%r9, %r14
0000000100007751	movq	%r11, -0x40(%rbp)
0000000100007755	movl	%r10d, %ebx
0000000100007758	movq	0xf921(%rip), %r8
000000010000775f	movq	%r15, %rdi
0000000100007762	shrq	$0x10, %rdi
0000000100007766	imulq	$0x1228, %rdi, %r9              ## imm = 0x1228
000000010000776d	leaq	(%r8,%r9), %rdi
0000000100007771	movzbl	(%r8,%r9), %r9d
0000000100007776	cmpb	$0x2, %r9b
000000010000777a	setne	%r10b
000000010000777e	movq	%r15, %r8
0000000100007781	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100007788	setne	%r11b
000000010000778c	orb	%r10b, %r11b
000000010000778f	jne	0x1000077b0
0000000100007791	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007798	movq	-0x48(%rbp), %rdx
000000010000779c	movl	%ebx, %r10d
000000010000779f	movq	-0x40(%rbp), %r11
00000001000077a3	jmp	0x1000077da
00000001000077a5	nopw	%cs:(%rax,%rax)
00000001000077b0	cmpb	$0x1, %r9b
00000001000077b4	movq	-0x48(%rbp), %rdx
00000001000077b8	movl	%ebx, %r10d
00000001000077bb	movq	-0x40(%rbp), %r11
00000001000077bf	movq	%r14, %r9
00000001000077c2	jne	0x1000077f0
00000001000077c4	movl	0x20(%rdi), %r9d
00000001000077c8	imulq	%r9, %r8
00000001000077cc	shrq	$0x20, %r8
00000001000077d0	addq	%r8, %rdi
00000001000077d3	addq	$0x228, %rdi                    ## imm = 0x228
00000001000077da	cmpb	$0x0, (%rdi)
00000001000077dd	movq	%r14, %r9
00000001000077e0	jne	0x1000077fc
00000001000077e2	nopw	%cs:(%rax,%rax)
00000001000077f0	testl	%r10d, %r10d
00000001000077f3	je	0x100007850
00000001000077f5	cmpq	$0x0, 0x18(%rax)
00000001000077fa	je	0x100007850
00000001000077fc	movq	_fwp_cleanups(%rip), %rdi
0000000100007803	movq	%rdi, -0xe8(%rbp)
000000010000780a	leaq	_fwp_apply_release(%rip), %rdi
0000000100007811	movq	%rdi, -0xe0(%rbp)
0000000100007818	leaq	-0x110(%rbp), %rdi
000000010000781f	movq	%rdi, -0xd8(%rbp)
0000000100007826	leaq	-0xe8(%rbp), %rdi
000000010000782d	movq	%rdi, _fwp_cleanups(%rip)
0000000100007834	movb	$0x1, %dil
0000000100007837	movl	%edi, -0x2c(%rbp)
000000010000783a	testb	$0x1, %cl
000000010000783d	je	0x10000785c
000000010000783f	jmp	0x1000078d3
0000000100007844	nopw	%cs:(%rax,%rax)
0000000100007850	movl	$0x0, -0x2c(%rbp)
0000000100007857	testb	$0x1, %cl
000000010000785a	jne	0x1000078d3
000000010000785c	cmpq	%rsi, %r15
000000010000785f	jae	0x1000078c8
0000000100007861	movq	0xf818(%rip), %rax
0000000100007868	movq	%r15, %rcx
000000010000786b	shrq	$0x10, %rcx
000000010000786f	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
0000000100007876	leaq	(%rax,%rcx), %rdi
000000010000787a	movzbl	(%rax,%rcx), %eax
000000010000787e	cmpb	$0x2, %al
0000000100007880	setne	%cl
0000000100007883	andq	$0xffff, %r15                   ## imm = 0xFFFF
000000010000788a	setne	%sil
000000010000788e	orb	%cl, %sil
0000000100007891	jne	0x10000789c
0000000100007893	addq	$0x228, %rdi                    ## imm = 0x228
000000010000789a	jmp	0x1000078b5
000000010000789c	cmpb	$0x1, %al
000000010000789e	jne	0x1000078c8
00000001000078a0	movl	0x20(%rdi), %eax
00000001000078a3	imulq	%rax, %r15
00000001000078a7	shrq	$0x20, %r15
00000001000078ab	addq	%r15, %rdi
00000001000078ae	addq	$0x228, %rdi                    ## imm = 0x228
00000001000078b5	movzbl	(%rdi), %eax
00000001000078b8	testb	%al, %al
00000001000078ba	je	0x1000078c8
00000001000078bc	cmpb	$-0x2, %al
00000001000078be	jae	0x100007abe
00000001000078c4	incb	%al
00000001000078c6	movb	%al, (%rdi)
00000001000078c8	movq	%r9, -0x110(%rbp)
00000001000078cf	movq	(%r12), %rax
00000001000078d3	movl	(%r11), %r15d
00000001000078d6	subl	0x4(%r9), %r15d
00000001000078da	cmpl	%r15d, %r13d
00000001000078dd	movl	%r15d, -0x58(%rbp)
00000001000078e1	movl	%r13d, %r14d
00000001000078e4	cmovbl	%r13d, %r15d
00000001000078e8	cmpl	%r15d, %r10d
00000001000078eb	movl	%r15d, %esi
00000001000078ee	cmovbl	%r10d, %esi
00000001000078f2	movq	$0x0, -0xd0(%rbp)
00000001000078fd	leaq	(%rdx,%rsi,8), %rbx
0000000100007901	movq	%rbx, -0xc8(%rbp)
0000000100007908	movq	%rax, -0xc0(%rbp)
000000010000790f	movl	$0x0, -0xb8(%rbp)
0000000100007919	movl	0x4(%r9), %ecx
000000010000791d	addl	%esi, %ecx
000000010000791f	movl	%ecx, -0xb4(%rbp)
0000000100007925	movl	$0x0, -0xb0(%rbp)
000000010000792f	xorl	%r13d, %r13d
0000000100007932	movl	$0x0, %ecx
0000000100007937	movl	%r10d, -0x5c(%rbp)
000000010000793b	cmpl	%r10d, %r15d
000000010000793e	movq	%rsi, -0x40(%rbp)
0000000100007942	jbe	0x1000079f8
0000000100007948	movl	%r14d, -0x54(%rbp)
000000010000794c	cmpq	$0x0, 0x18(%rax)
0000000100007951	setne	%al
0000000100007954	movl	%eax, -0x4c(%rbp)
0000000100007957	je	0x100007991
0000000100007959	movq	_fwp_cleanups(%rip), %rax
0000000100007960	movq	%rax, -0xa8(%rbp)
0000000100007967	leaq	_fwp_apply_release(%rip), %rax
000000010000796e	movq	%rax, -0xa0(%rbp)
0000000100007975	leaq	-0xd0(%rbp), %rax
000000010000797c	movq	%rax, -0x98(%rbp)
0000000100007983	leaq	-0xa8(%rbp), %rax
000000010000798a	movq	%rax, _fwp_cleanups(%rip)
0000000100007991	movl	%r15d, -0x50(%rbp)
0000000100007995	subl	%esi, %r15d
0000000100007998	cmpl	$0x1, %r15d
000000010000799c	adcl	$0x0, %r15d
00000001000079a0	shlq	$0x3, %r15
00000001000079a4	movl	%esi, %r14d
00000001000079a7	movq	%r9, %r13
00000001000079aa	nopw	(%rax,%rax)
00000001000079b0	movq	(%r12), %rax
00000001000079b4	movl	0x4(%r13), %esi
00000001000079b8	addl	%r14d, %esi
00000001000079bb	movq	%rbx, %rdi
00000001000079be	movl	$0x1, %edx
00000001000079c3	callq	*0x10(%rax)
00000001000079c6	movl	-0xb0(%rbp), %ecx
00000001000079cc	incl	%ecx
00000001000079ce	movl	%ecx, -0xb0(%rbp)
00000001000079d4	incl	%r14d
00000001000079d7	addq	$0x8, %rbx
00000001000079db	addq	$-0x8, %r15
00000001000079df	jne	0x1000079b0
00000001000079e1	movq	%r13, %r9
00000001000079e4	movl	-0x54(%rbp), %r14d
00000001000079e8	movq	-0x48(%rbp), %rdx
00000001000079ec	movl	-0x50(%rbp), %r15d
00000001000079f0	movq	-0x40(%rbp), %rsi
00000001000079f4	movl	-0x4c(%rbp), %r13d
00000001000079f8	movl	%ecx, -0xb8(%rbp)
00000001000079fe	movq	$0x0, -0x110(%rbp)
0000000100007a09	movl	%esi, -0xf8(%rbp)
0000000100007a0f	movq	%r9, %rdi
0000000100007a12	movl	%r15d, %esi
0000000100007a15	callq	_fwp_apply_owned
0000000100007a1a	movq	%rax, %r9
0000000100007a1d	testb	%r13b, %r13b
0000000100007a20	movl	%r14d, %r13d
0000000100007a23	je	0x100007a47
0000000100007a25	leaq	-0xa8(%rbp), %rax
0000000100007a2c	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007a33	jne	0x100007c6d
0000000100007a39	movq	-0xa8(%rbp), %rax
0000000100007a40	movq	%rax, _fwp_cleanups(%rip)
0000000100007a47	cmpb	$0x0, -0x2c(%rbp)
0000000100007a4b	movq	-0x48(%rbp), %rdx
0000000100007a4f	movl	-0x5c(%rbp), %r10d
0000000100007a53	movq	-0x40(%rbp), %rcx
0000000100007a57	je	0x100007a7b
0000000100007a59	leaq	-0xe8(%rbp), %rax
0000000100007a60	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007a67	jne	0x100007c6d
0000000100007a6d	movq	-0xe8(%rbp), %rax
0000000100007a74	movq	%rax, _fwp_cleanups(%rip)
0000000100007a7b	cmpl	-0x58(%rbp), %r13d
0000000100007a7f	jbe	0x100007b45
0000000100007a85	movl	%r15d, %eax
0000000100007a88	leaq	(%rdx,%rax,8), %rdx
0000000100007a8c	subl	%r15d, %r13d
0000000100007a8f	subl	%ecx, %r10d
0000000100007a92	movq	_fwp_fns(%rip), %rax
0000000100007a99	movl	(%r9), %ecx
0000000100007a9c	shlq	$0x5, %rcx
0000000100007aa0	leaq	(%rax,%rcx), %r11
0000000100007aa4	leaq	(%rax,%rcx), %r12
0000000100007aa8	addq	$0x18, %r12
0000000100007aac	movq	0x18(%rax,%rcx), %rax
0000000100007ab1	movb	$0x1, %cl
0000000100007ab3	testq	%rax, %rax
0000000100007ab6	jne	0x1000076f0
0000000100007abc	jmp	0x100007b00
0000000100007abe	movl	%r10d, %ebx
0000000100007ac1	movq	%r11, %r15
0000000100007ac4	movq	%r9, %r14
0000000100007ac7	callq	_fwp_rc_wide_dup
0000000100007acc	movq	%r14, %r9
0000000100007acf	movq	%r15, %r11
0000000100007ad2	movl	%ebx, %r10d
0000000100007ad5	movq	-0x48(%rbp), %rdx
0000000100007ad9	jmp	0x1000078c8
0000000100007ade	nop
0000000100007ae0	movq	%r9, %rdi
0000000100007ae3	movq	%r9, %rbx
0000000100007ae6	callq	_fwp_rc_share
0000000100007aeb	movl	$0x1, %r13d
0000000100007af1	movq	%rbx, %r12
0000000100007af4	leaq	-0x38(%rbp), %rdx
0000000100007af8	jmp	0x100007b1a
0000000100007afa	nopw	(%rax,%rax)
0000000100007b00	movq	%rdx, %rbx
0000000100007b03	movq	%r9, %rdi
0000000100007b06	movq	%r9, %r12
0000000100007b09	callq	_fwp_rc_share
0000000100007b0e	testl	%r13d, %r13d
0000000100007b11	je	0x100007c11
0000000100007b17	movq	%rbx, %rdx
0000000100007b1a	movl	%r13d, %ebx
0000000100007b1d	xorl	%r14d, %r14d
0000000100007b20	movq	(%rdx,%r14,8), %rdi
0000000100007b24	movq	%rdx, %r15
0000000100007b27	callq	_fwp_rc_share
0000000100007b2c	movq	%r15, %rdx
0000000100007b2f	incq	%r14
0000000100007b32	cmpq	%r14, %rbx
0000000100007b35	jne	0x100007b20
0000000100007b37	movq	%r12, %rdi
0000000100007b3a	movl	%r13d, %esi
0000000100007b3d	callq	_fwp_apply
0000000100007b42	movq	%rax, %r9
0000000100007b45	cmpq	$0xfff, %r9                     ## imm = 0xFFF
0000000100007b4c	ja	0x100007b60
0000000100007b4e	movl	%r9d, %eax
0000000100007b51	jmp	0x100007b63
0000000100007b53	nopw	%cs:(%rax,%rax)
0000000100007b60	movl	(%r9), %eax
0000000100007b63	movq	0x8(%r9), %rsi
0000000100007b67	testl	%eax, %eax
0000000100007b69	jne	0x100007c2a
0000000100007b6f	movq	%rsi, %rax
0000000100007b72	subq	0xf4bf(%rip), %rax
0000000100007b79	movq	0xf4e0(%rip), %rcx
0000000100007b80	shlq	$0x10, %rcx
0000000100007b84	cmpq	%rcx, %rax
0000000100007b87	jae	0x100007684
0000000100007b8d	movq	0xf4ec(%rip), %rcx
0000000100007b94	movq	%rax, %rdx
0000000100007b97	shrq	$0x10, %rdx
0000000100007b9b	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100007ba2	leaq	(%rcx,%rdx), %rdi
0000000100007ba6	movzbl	(%rcx,%rdx), %ecx
0000000100007baa	cmpb	$0x2, %cl
0000000100007bad	setne	%dl
0000000100007bb0	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007bb6	setne	%r8b
0000000100007bba	orb	%dl, %r8b
0000000100007bbd	jne	0x100007bd0
0000000100007bbf	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007bc6	jmp	0x100007bee
0000000100007bc8	nopl	(%rax,%rax)
0000000100007bd0	cmpb	$0x1, %cl
0000000100007bd3	jne	0x100007684
0000000100007bd9	movl	0x20(%rdi), %ecx
0000000100007bdc	imulq	%rcx, %rax
0000000100007be0	shrq	$0x20, %rax
0000000100007be4	addq	%rax, %rdi
0000000100007be7	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007bee	movzbl	(%rdi), %eax
0000000100007bf1	testb	%al, %al
0000000100007bf3	je	0x100007684
0000000100007bf9	cmpb	$-0x2, %al
0000000100007bfb	jb	0x100007680
0000000100007c01	movq	%rsi, %rbx
0000000100007c04	callq	_fwp_rc_wide_dup
0000000100007c09	movq	%rbx, %rsi
0000000100007c0c	jmp	0x100007684
0000000100007c11	xorl	%r13d, %r13d
0000000100007c14	movq	%rbx, %rdx
0000000100007c17	jmp	0x100007b37
0000000100007c1c	callq	_fwp_preempt
0000000100007c21	movq	-0x70(%rbp), %rsi
0000000100007c25	jmp	0x1000076a4
0000000100007c2a	movq	%rsi, -0x38(%rbp)
0000000100007c2e	movq	-0x78(%rbp), %rax
0000000100007c32	cmpq	$0x0, -0x68(%rbp)
0000000100007c37	je	0x100007c57
0000000100007c39	leaq	-0x90(%rbp), %rax
0000000100007c40	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007c47	jne	0x100007c6d
0000000100007c49	movq	-0x90(%rbp), %rax
0000000100007c50	movq	%rax, _fwp_cleanups(%rip)
0000000100007c57	movq	-0x38(%rbp), %rax
0000000100007c5b	addq	$0xe8, %rsp
0000000100007c62	popq	%rbx
0000000100007c63	popq	%r12
0000000100007c65	popq	%r13
0000000100007c67	popq	%r14
0000000100007c69	popq	%r15
0000000100007c6b	popq	%rbp
0000000100007c6c	retq
0000000100007c6d	callq	0x100012c2a                     ## symbol stub for: _abort
0000000100007c72	nopw	%cs:(%rax,%rax)
_fwp_preempt:
0000000100007c80	movl	_fwp_slice(%rip), %ecx
0000000100007c86	testl	%ecx, %ecx
0000000100007c88	je	0x100007c91
0000000100007c8a	movl	%ecx, _fwp_budget(%rip)
0000000100007c90	retq
0000000100007c91	pushq	%rbp
0000000100007c92	movq	%rsp, %rbp
0000000100007c95	leaq	0xb8fb(%rip), %rdi              ## literal pool for: "FWP_PREEMPT"
0000000100007c9c	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100007ca1	movq	%rax, %rdi
0000000100007ca4	movl	$0x2710, %eax                   ## imm = 0x2710
0000000100007ca9	testq	%rdi, %rdi
0000000100007cac	je	0x100007cbf
0000000100007cae	cmpb	$0x0, (%rdi)
0000000100007cb1	je	0x100007cbf
0000000100007cb3	xorl	%esi, %esi
0000000100007cb5	movl	$0xa, %edx
0000000100007cba	callq	0x100012d44                     ## symbol stub for: _strtoll
0000000100007cbf	leaq	-0x80000000(%rax), %rcx
0000000100007cc6	cmpq	$-0x7fffffff, %rcx              ## imm = 0x80000001
0000000100007ccd	movl	$0x7fffffff, %ecx               ## imm = 0x7FFFFFFF
0000000100007cd2	cmovael	%eax, %ecx
0000000100007cd5	movl	%ecx, _fwp_slice(%rip)
0000000100007cdb	popq	%rbp
0000000100007cdc	movl	%ecx, _fwp_budget(%rip)
0000000100007ce2	retq
0000000100007ce3	nopw	%cs:(%rax,%rax)
_fwp_value_release:
0000000100007cf0	pushq	%rbp
0000000100007cf1	movq	%rsp, %rbp
0000000100007cf4	movq	%rdi, %rax
0000000100007cf7	movq	(%rdi), %rdi
0000000100007cfa	movq	0x8(%rax), %rcx
0000000100007cfe	movq	$0x0, (%rax)
0000000100007d05	testq	%rcx, %rcx
0000000100007d08	setne	%al
0000000100007d0b	testq	%rdi, %rdi
0000000100007d0e	setne	%dl
0000000100007d11	andb	%al, %dl
0000000100007d13	cmpb	$0x1, %dl
0000000100007d16	jne	0x100007d1b
0000000100007d18	popq	%rbp
0000000100007d19	jmpq	*%rcx
0000000100007d1b	popq	%rbp
0000000100007d1c	retq
0000000100007d1d	nopl	(%rax)
_fwp_apply:
0000000100007d20	pushq	%rbp
0000000100007d21	movq	%rsp, %rbp
0000000100007d24	pushq	%r15
0000000100007d26	pushq	%r14
0000000100007d28	pushq	%r13
0000000100007d2a	pushq	%r12
0000000100007d2c	pushq	%rbx
0000000100007d2d	subq	$0x38, %rsp
0000000100007d31	movq	%rdx, %rbx
0000000100007d34	movl	%esi, %r8d
0000000100007d37	movq	%rdi, %r15
0000000100007d3a	movq	0xd2ef(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007d41	movq	(%rax), %rax
0000000100007d44	movq	%rax, -0x30(%rbp)
0000000100007d48	jmp	0x100007d6d
0000000100007d4a	nopw	(%rax,%rax)
0000000100007d50	leaq	(%rbx,%r14,8), %rbx
0000000100007d54	xorl	%ecx, %ecx
0000000100007d56	movq	%rax, %r15
0000000100007d59	movq	-0x48(%rbp), %r14
0000000100007d5d	movq	-0x50(%rbp), %rsp
0000000100007d61	movl	%edx, %r8d
0000000100007d64	cmpl	$0x1, %ecx
0000000100007d67	je	0x100008216
0000000100007d6d	movq	_fwp_fns(%rip), %rax
0000000100007d74	movl	(%r15), %ecx
0000000100007d77	movl	0x4(%r15), %r13d
0000000100007d7b	shlq	$0x5, %rcx
0000000100007d7f	leaq	(%rax,%rcx), %rdx
0000000100007d83	movl	(%rax,%rcx), %r12d
0000000100007d87	testq	%r13, %r13
0000000100007d8a	jne	0x100007dd0
0000000100007d8c	leal	-0x1(%r12), %eax
0000000100007d91	cmpl	%r8d, %eax
0000000100007d94	jae	0x100007dd0
0000000100007d96	movq	%rbx, %rdi
0000000100007d99	movq	%r8, %r15
0000000100007d9c	callq	*0x8(%rdx)
0000000100007d9f	movq	%r15, %r8
0000000100007da2	movq	%rax, %r15
0000000100007da5	cmpl	%r12d, %r8d
0000000100007da8	je	0x10000806b
0000000100007dae	leaq	(%rbx,%r12,8), %rbx
0000000100007db2	subl	%r12d, %r8d
0000000100007db5	movl	$0x3, %ecx
0000000100007dba	cmpl	$0x1, %ecx
0000000100007dbd	jne	0x100007d6d
0000000100007dbf	jmp	0x100008216
0000000100007dc4	nopw	%cs:(%rax,%rax)
0000000100007dd0	movq	%r14, -0x48(%rbp)
0000000100007dd4	leal	(%r8,%r13), %r14d
0000000100007dd8	cmpl	%r12d, %r14d
0000000100007ddb	movq	%r8, -0x40(%rbp)
0000000100007ddf	jb	0x10000800d
0000000100007de5	movq	%rdx, -0x58(%rbp)
0000000100007de9	movq	%rsp, -0x50(%rbp)
0000000100007ded	movl	%r12d, %r14d
0000000100007df0	cmpl	$0x2, %r12d
0000000100007df4	movl	$0x1, %eax
0000000100007df9	cmovael	%r12d, %eax
0000000100007dfd	shlq	$0x3, %rax
0000000100007e01	callq	0x100012be8                     ## symbol stub for: ____chkstk_darwin
0000000100007e06	addq	$0xf, %rax
0000000100007e0a	andq	$-0x10, %rax
0000000100007e0e	subq	%rax, %rsp
0000000100007e11	movq	%rsp, %rdi
0000000100007e14	testq	%r13, %r13
0000000100007e17	je	0x100007ef0
0000000100007e1d	cmpl	$0x3, %r13d
0000000100007e21	jbe	0x100007e33
0000000100007e23	movq	%rdi, %rax
0000000100007e26	subq	%r15, %rax
0000000100007e29	addq	$-0x8, %rax
0000000100007e2d	cmpq	$0x20, %rax
0000000100007e31	jae	0x100007ea2
0000000100007e33	xorl	%eax, %eax
0000000100007e35	movq	%r13, %rdx
0000000100007e38	movq	%rax, %rcx
0000000100007e3b	andq	$0x3, %rdx
0000000100007e3f	je	0x100007e61
0000000100007e41	movq	%rax, %rcx
0000000100007e44	nopw	%cs:(%rax,%rax)
0000000100007e50	movq	0x8(%r15,%rcx,8), %rsi
0000000100007e55	movq	%rsi, (%rdi,%rcx,8)
0000000100007e59	incq	%rcx
0000000100007e5c	decq	%rdx
0000000100007e5f	jne	0x100007e50
0000000100007e61	subq	%r13, %rax
0000000100007e64	cmpq	$-0x4, %rax
0000000100007e68	ja	0x100007ef0
0000000100007e6e	nop
0000000100007e70	movq	0x8(%r15,%rcx,8), %rax
0000000100007e75	movq	%rax, (%rdi,%rcx,8)
0000000100007e79	movq	0x10(%r15,%rcx,8), %rax
0000000100007e7e	movq	%rax, 0x8(%rdi,%rcx,8)
0000000100007e83	movq	0x18(%r15,%rcx,8), %rax
0000000100007e88	movq	%rax, 0x10(%rdi,%rcx,8)
0000000100007e8d	movq	0x20(%r15,%rcx,8), %rax
0000000100007e92	movq	%rax, 0x18(%rdi,%rcx,8)
0000000100007e97	addq	$0x4, %rcx
0000000100007e9b	cmpq	%rcx, %r13
0000000100007e9e	jne	0x100007e70
0000000100007ea0	jmp	0x100007ef0
0000000100007ea2	movl	%r13d, %eax
0000000100007ea5	andl	$-0x4, %eax
0000000100007ea8	leaq	(,%r13,8), %rcx
0000000100007eb0	andq	$-0x20, %rcx
0000000100007eb4	xorl	%edx, %edx
0000000100007eb6	nopw	%cs:(%rax,%rax)
0000000100007ec0	movups	0x8(%r15,%rdx), %xmm0
0000000100007ec6	movups	0x18(%r15,%rdx), %xmm1
0000000100007ecc	movaps	%xmm0, (%rdi,%rdx)
0000000100007ed0	movaps	%xmm1, 0x10(%rdi,%rdx)
0000000100007ed5	addq	$0x20, %rdx
0000000100007ed9	cmpq	%rdx, %rcx
0000000100007edc	jne	0x100007ec0
0000000100007ede	cmpl	%r13d, %eax
0000000100007ee1	jne	0x100007e35
0000000100007ee7	nopw	(%rax,%rax)
0000000100007ef0	subl	%r13d, %r14d
0000000100007ef3	movl	%r14d, -0x34(%rbp)
0000000100007ef7	movl	%r14d, %r14d
0000000100007efa	cmpl	%r13d, %r12d
0000000100007efd	je	0x100007f82
0000000100007f03	cmpl	$0xd, -0x34(%rbp)
0000000100007f07	ja	0x100007fa7
0000000100007f0d	xorl	%eax, %eax
0000000100007f0f	movq	%r14, %rdx
0000000100007f12	movq	%rax, %rcx
0000000100007f15	andq	$0x3, %rdx
0000000100007f19	je	0x100007f34
0000000100007f1b	movq	%rax, %rcx
0000000100007f1e	nop
0000000100007f20	movq	(%rbx,%rcx,8), %rsi
0000000100007f24	leal	(%rcx,%r13), %r8d
0000000100007f28	movq	%rsi, (%rdi,%r8,8)
0000000100007f2c	incq	%rcx
0000000100007f2f	decq	%rdx
0000000100007f32	jne	0x100007f20
0000000100007f34	subq	%r14, %rax
0000000100007f37	cmpq	$-0x4, %rax
0000000100007f3b	ja	0x100007f82
0000000100007f3d	nopl	(%rax)
0000000100007f40	movq	(%rbx,%rcx,8), %rax
0000000100007f44	leal	(%rcx,%r13), %edx
0000000100007f48	movq	%rax, (%rdi,%rdx,8)
0000000100007f4c	movq	0x8(%rbx,%rcx,8), %rax
0000000100007f51	leal	(%rcx,%r13), %edx
0000000100007f55	incl	%edx
0000000100007f57	movq	%rax, (%rdi,%rdx,8)
0000000100007f5b	movq	0x10(%rbx,%rcx,8), %rax
0000000100007f60	leal	0x2(%r13,%rcx), %edx
0000000100007f65	movq	%rax, (%rdi,%rdx,8)
0000000100007f69	movq	0x18(%rbx,%rcx,8), %rax
0000000100007f6e	leal	(%rcx,%r13), %edx
0000000100007f72	addl	$0x3, %edx
0000000100007f75	movq	%rax, (%rdi,%rdx,8)
0000000100007f79	addq	$0x4, %rcx
0000000100007f7d	cmpq	%rcx, %r14
0000000100007f80	jne	0x100007f40
0000000100007f82	movq	-0x58(%rbp), %rax
0000000100007f86	callq	*0x8(%rax)
0000000100007f89	movl	$0x1, %ecx
0000000100007f8e	movq	-0x40(%rbp), %rsi
0000000100007f92	movl	%esi, %edx
0000000100007f94	subl	-0x34(%rbp), %edx
0000000100007f97	jne	0x100007d50
0000000100007f9d	movl	%esi, %edx
0000000100007f9f	movq	%rax, %r14
0000000100007fa2	jmp	0x100007d5d
0000000100007fa7	leaq	-0x1(%r14), %rax
0000000100007fab	movl	%eax, %ecx
0000000100007fad	addl	%r13d, %ecx
0000000100007fb0	jb	0x100007f0d
0000000100007fb6	shrq	$0x20, %rax
0000000100007fba	movl	$0x0, %eax
0000000100007fbf	jne	0x100007f0f
0000000100007fc5	leaq	(%rdi,%r13,8), %rax
0000000100007fc9	subq	%rbx, %rax
0000000100007fcc	cmpq	$0x20, %rax
0000000100007fd0	jb	0x100007f0d
0000000100007fd6	movl	%r14d, %eax
0000000100007fd9	andl	$-0x4, %eax
0000000100007fdc	xorl	%ecx, %ecx
0000000100007fde	nop
0000000100007fe0	movups	(%rbx,%rcx,8), %xmm0
0000000100007fe4	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100007fe9	leal	(%rcx,%r13), %edx
0000000100007fed	movups	%xmm0, (%rdi,%rdx,8)
0000000100007ff1	movups	%xmm1, 0x10(%rdi,%rdx,8)
0000000100007ff6	addq	$0x4, %rcx
0000000100007ffa	cmpq	%rcx, %rax
0000000100007ffd	jne	0x100007fe0
0000000100007fff	cmpl	%r14d, %eax
0000000100008002	jne	0x100007f0f
0000000100008008	jmp	0x100007f82
000000010000800d	movl	%r14d, %eax
0000000100008010	cmpl	$0x7ff, %r14d                   ## imm = 0x7FF
0000000100008017	ja	0x100008083
0000000100008019	leaq	(,%rax,8), %rdx
0000000100008021	addq	$0x17, %rdx
0000000100008025	shrq	$0x4, %rdx
0000000100008029	leaq	_fwp_gc(%rip), %rcx
0000000100008030	movzbl	0xbe8(%rdx,%rcx), %edx
0000000100008038	movl	0xb48(%rcx,%rdx,4), %esi
000000010000803f	subq	%rsi, _fwp_gc(%rip)
0000000100008046	js	0x100008083
0000000100008048	leaq	(%rdx,%rdx,2), %rdx
000000010000804c	leaq	(%rcx,%rdx,8), %rcx
0000000100008050	addq	$0x788, %rcx                    ## imm = 0x788
0000000100008057	movq	(%rcx), %r12
000000010000805a	testq	%r12, %r12
000000010000805d	je	0x100008073
000000010000805f	movq	(%r12), %rax
0000000100008063	notq	%rax
0000000100008066	movq	%rax, (%rcx)
0000000100008069	jmp	0x1000080a2
000000010000806b	movq	%r15, %r14
000000010000806e	jmp	0x100008216
0000000100008073	movq	0x8(%rcx), %r12
0000000100008077	movq	0x10(%rcx), %rdx
000000010000807b	subq	%r12, %rdx
000000010000807e	cmpq	%rsi, %rdx
0000000100008081	jae	0x10000809a
0000000100008083	leaq	0x8(,%rax,8), %rdi
000000010000808b	movl	$0x2, %esi
0000000100008090	callq	_fwp_gc_alloc_slow
0000000100008095	movq	%rax, %r12
0000000100008098	jmp	0x1000080aa
000000010000809a	leaq	(%r12,%rsi), %rax
000000010000809e	movq	%rax, 0x8(%rcx)
00000001000080a2	movq	%r12, %rdi
00000001000080a5	callq	0x100012bee                     ## symbol stub for: ___bzero
00000001000080aa	movl	(%r15), %eax
00000001000080ad	movl	%eax, (%r12)
00000001000080b1	movl	%r14d, 0x4(%r12)
00000001000080b6	testq	%r13, %r13
00000001000080b9	movq	%r12, %r14
00000001000080bc	movq	-0x40(%rbp), %rdi
00000001000080c0	je	0x100008181
00000001000080c6	xorl	%eax, %eax
00000001000080c8	cmpl	$0x6, %r13d
00000001000080cc	jb	0x100008116
00000001000080ce	movq	%r14, %rcx
00000001000080d1	subq	%r15, %rcx
00000001000080d4	cmpq	$0x1f, %rcx
00000001000080d8	jbe	0x100008116
00000001000080da	movl	%r13d, %eax
00000001000080dd	andl	$-0x4, %eax
00000001000080e0	leaq	(,%r13,8), %rcx
00000001000080e8	andq	$-0x20, %rcx
00000001000080ec	xorl	%edx, %edx
00000001000080ee	nop
00000001000080f0	movups	0x8(%r15,%rdx), %xmm0
00000001000080f6	movups	0x18(%r15,%rdx), %xmm1
00000001000080fc	movups	%xmm0, 0x8(%r14,%rdx)
0000000100008102	movups	%xmm1, 0x18(%r14,%rdx)
0000000100008108	addq	$0x20, %rdx
000000010000810c	cmpq	%rdx, %rcx
000000010000810f	jne	0x1000080f0
0000000100008111	cmpl	%r13d, %eax
0000000100008114	je	0x100008181
0000000100008116	movq	%r13, %rdx
0000000100008119	movq	%rax, %rcx
000000010000811c	andq	$0x3, %rdx
0000000100008120	je	0x100008142
0000000100008122	movq	%rax, %rcx
0000000100008125	nopw	%cs:(%rax,%rax)
0000000100008130	movq	0x8(%r15,%rcx,8), %rsi
0000000100008135	movq	%rsi, 0x8(%r14,%rcx,8)
000000010000813a	incq	%rcx
000000010000813d	decq	%rdx
0000000100008140	jne	0x100008130
0000000100008142	subq	%r13, %rax
0000000100008145	cmpq	$-0x4, %rax
0000000100008149	ja	0x100008181
000000010000814b	nopl	(%rax,%rax)
0000000100008150	movq	0x8(%r15,%rcx,8), %rax
0000000100008155	movq	%rax, 0x8(%r14,%rcx,8)
000000010000815a	movq	0x10(%r15,%rcx,8), %rax
000000010000815f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100008164	movq	0x18(%r15,%rcx,8), %rax
0000000100008169	movq	%rax, 0x18(%r14,%rcx,8)
000000010000816e	movq	0x20(%r15,%rcx,8), %rax
0000000100008173	movq	%rax, 0x20(%r14,%rcx,8)
0000000100008178	addq	$0x4, %rcx
000000010000817c	cmpq	%rcx, %r13
000000010000817f	jne	0x100008150
0000000100008181	testl	%edi, %edi
0000000100008183	je	0x100008216
0000000100008189	movl	%edi, %eax
000000010000818b	cmpl	$0x13, %edi
000000010000818e	ja	0x100008238
0000000100008194	xorl	%ecx, %ecx
0000000100008196	movq	%rax, %rsi
0000000100008199	movq	%rcx, %rdx
000000010000819c	andq	$0x3, %rsi
00000001000081a0	je	0x1000081c5
00000001000081a2	movq	%rcx, %rdx
00000001000081a5	nopw	%cs:(%rax,%rax)
00000001000081b0	movq	(%rbx,%rdx,8), %rdi
00000001000081b4	leal	(%rdx,%r13), %r8d
00000001000081b8	movq	%rdi, 0x8(%r14,%r8,8)
00000001000081bd	incq	%rdx
00000001000081c0	decq	%rsi
00000001000081c3	jne	0x1000081b0
00000001000081c5	subq	%rax, %rcx
00000001000081c8	cmpq	$-0x4, %rcx
00000001000081cc	ja	0x100008216
00000001000081ce	nop
00000001000081d0	movq	(%rbx,%rdx,8), %rcx
00000001000081d4	leal	(%rdx,%r13), %esi
00000001000081d8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000081dd	movq	0x8(%rbx,%rdx,8), %rcx
00000001000081e2	leal	(%rdx,%r13), %esi
00000001000081e6	incl	%esi
00000001000081e8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000081ed	movq	0x10(%rbx,%rdx,8), %rcx
00000001000081f2	leal	0x2(%r13,%rdx), %esi
00000001000081f7	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000081fc	movq	0x18(%rbx,%rdx,8), %rcx
0000000100008201	leal	(%rdx,%r13), %esi
0000000100008205	addl	$0x3, %esi
0000000100008208	movq	%rcx, 0x8(%r14,%rsi,8)
000000010000820d	addq	$0x4, %rdx
0000000100008211	cmpq	%rdx, %rax
0000000100008214	jne	0x1000081d0
0000000100008216	movq	0xce13(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000821d	movq	(%rax), %rax
0000000100008220	cmpq	-0x30(%rbp), %rax
0000000100008224	jne	0x10000829f
0000000100008226	movq	%r14, %rax
0000000100008229	leaq	-0x28(%rbp), %rsp
000000010000822d	popq	%rbx
000000010000822e	popq	%r12
0000000100008230	popq	%r13
0000000100008232	popq	%r14
0000000100008234	popq	%r15
0000000100008236	popq	%rbp
0000000100008237	retq
0000000100008238	leaq	-0x1(%rax), %rdx
000000010000823c	xorl	%ecx, %ecx
000000010000823e	movl	%edx, %esi
0000000100008240	addl	%r13d, %esi
0000000100008243	jb	0x100008196
0000000100008249	shrq	$0x20, %rdx
000000010000824d	jne	0x100008196
0000000100008253	leaq	(%r14,%r13,8), %rcx
0000000100008257	subq	%rbx, %rcx
000000010000825a	addq	$0x8, %rcx
000000010000825e	cmpq	$0x20, %rcx
0000000100008262	jb	0x100008194
0000000100008268	movl	%eax, %ecx
000000010000826a	andl	$-0x4, %ecx
000000010000826d	xorl	%edx, %edx
000000010000826f	nop
0000000100008270	movups	(%rbx,%rdx,8), %xmm0
0000000100008274	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100008279	leal	(%rdx,%r13), %esi
000000010000827d	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100008283	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100008289	addq	$0x4, %rdx
000000010000828d	cmpq	%rdx, %rcx
0000000100008290	jne	0x100008270
0000000100008292	cmpl	%eax, %ecx
0000000100008294	jne	0x100008196
000000010000829a	jmp	0x100008216
000000010000829f	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
00000001000082a4	nopw	%cs:(%rax,%rax)
_fwp_apply_release:
00000001000082b0	pushq	%rbp
00000001000082b1	movq	%rsp, %rbp
00000001000082b4	pushq	%r14
00000001000082b6	pushq	%rbx
00000001000082b7	movq	(%rdi), %rbx
00000001000082ba	movq	$0x0, (%rdi)
00000001000082c1	movl	0x20(%rdi), %eax
00000001000082c4	movl	0x18(%rdi), %ecx
00000001000082c7	movl	%eax, %edx
00000001000082c9	subl	%ecx, %edx
00000001000082cb	je	0x1000082fa
00000001000082cd	movq	0x10(%rdi), %rsi
00000001000082d1	movq	0x18(%rsi), %r8
00000001000082d5	testq	%r8, %r8
00000001000082d8	je	0x1000082fa
00000001000082da	movq	%rcx, %rax
00000001000082dd	shlq	$0x3, %rax
00000001000082e1	addq	0x8(%rdi), %rax
00000001000082e5	movl	0x1c(%rdi), %esi
00000001000082e8	addl	%ecx, %esi
00000001000082ea	movq	%rdi, %r14
00000001000082ed	movq	%rax, %rdi
00000001000082f0	callq	*%r8
00000001000082f3	movq	%r14, %rdi
00000001000082f6	movl	0x20(%r14), %eax
00000001000082fa	movl	%eax, 0x18(%rdi)
00000001000082fd	testq	%rbx, %rbx
0000000100008300	je	0x10000830e
0000000100008302	movq	%rbx, %rdi
0000000100008305	popq	%rbx
0000000100008306	popq	%r14
0000000100008308	popq	%rbp
0000000100008309	jmp	_fwp_closure_drop
000000010000830e	popq	%rbx
000000010000830f	popq	%r14
0000000100008311	popq	%rbp
0000000100008312	retq
0000000100008313	nopw	%cs:(%rax,%rax)
_fwp_apply_owned:
0000000100008320	pushq	%rbp
0000000100008321	movq	%rsp, %rbp
0000000100008324	pushq	%r15
0000000100008326	pushq	%r14
0000000100008328	pushq	%r13
000000010000832a	pushq	%r12
000000010000832c	pushq	%rbx
000000010000832d	subq	$0xa8, %rsp
0000000100008334	movq	%rdx, %rbx
0000000100008337	movl	%esi, %r13d
000000010000833a	movq	0xccef(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008341	movq	(%rax), %rax
0000000100008344	movq	%rax, -0x30(%rbp)
0000000100008348	movq	_fwp_fns(%rip), %rdx
000000010000834f	movl	(%rdi), %esi
0000000100008351	shlq	$0x5, %rsi
0000000100008355	movq	0x18(%rdx,%rsi), %rax
000000010000835a	testq	%rax, %rax
000000010000835d	je	0x100008776
0000000100008363	leaq	(%rdx,%rsi), %rcx
0000000100008367	addq	%rdx, %rsi
000000010000836a	addq	$0x18, %rsi
000000010000836e	movq	%rdi, %r12
0000000100008371	nopw	%cs:(%rax,%rax)
0000000100008380	movq	%rsi, -0x58(%rbp)
0000000100008384	movl	(%rcx), %r14d
0000000100008387	movl	0x4(%r12), %r15d
000000010000838c	movq	%rdi, -0xb0(%rbp)
0000000100008393	movq	%rbx, -0xa8(%rbp)
000000010000839a	movq	%rax, -0xa0(%rbp)
00000001000083a1	movl	$0x0, -0x98(%rbp)
00000001000083ab	movl	%r15d, -0x94(%rbp)
00000001000083b2	movq	%rdi, %rcx
00000001000083b5	subq	0xec7c(%rip), %rcx
00000001000083bc	movl	%r13d, -0x90(%rbp)
00000001000083c3	movq	0xec96(%rip), %rdx
00000001000083ca	shlq	$0x10, %rdx
00000001000083ce	cmpq	%rdx, %rcx
00000001000083d1	jae	0x100008440
00000001000083d3	movq	0xeca6(%rip), %rsi
00000001000083da	movq	%rcx, %rdx
00000001000083dd	shrq	$0x10, %rdx
00000001000083e1	imulq	$0x1228, %rdx, %r8              ## imm = 0x1228
00000001000083e8	leaq	(%rsi,%r8), %rdx
00000001000083ec	movzbl	(%rsi,%r8), %esi
00000001000083f1	cmpb	$0x2, %sil
00000001000083f5	setne	%r9b
00000001000083f9	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008400	setne	%r8b
0000000100008404	orb	%r9b, %r8b
0000000100008407	jne	0x100008420
0000000100008409	addq	$0x228, %rdx                    ## imm = 0x228
0000000100008410	cmpb	$0x0, (%rdx)
0000000100008413	jne	0x100008460
0000000100008415	jmp	0x100008440
0000000100008417	nopw	(%rax,%rax)
0000000100008420	cmpb	$0x1, %sil
0000000100008424	jne	0x100008440
0000000100008426	movl	0x20(%rdx), %esi
0000000100008429	imulq	%rsi, %rcx
000000010000842d	shrq	$0x20, %rcx
0000000100008431	addq	%rcx, %rdx
0000000100008434	addq	$0x228, %rdx                    ## imm = 0x228
000000010000843b	cmpb	$0x0, (%rdx)
000000010000843e	jne	0x100008460
0000000100008440	cmpq	$0x0, 0x18(%rax)
0000000100008445	je	0x100008451
0000000100008447	testq	%r15, %r15
000000010000844a	jne	0x100008460
000000010000844c	cmpl	%r14d, %r13d
000000010000844f	jne	0x100008460
0000000100008451	xorl	%ecx, %ecx
0000000100008453	jmp	0x10000848e
0000000100008455	nopw	%cs:(%rax,%rax)
0000000100008460	movq	_fwp_cleanups(%rip), %rcx
0000000100008467	movq	%rcx, -0x80(%rbp)
000000010000846b	leaq	_fwp_apply_release(%rip), %rcx
0000000100008472	movq	%rcx, -0x78(%rbp)
0000000100008476	leaq	-0xb0(%rbp), %rcx
000000010000847d	movq	%rcx, -0x70(%rbp)
0000000100008481	leaq	-0x80(%rbp), %rcx
0000000100008485	movq	%rcx, _fwp_cleanups(%rip)
000000010000848c	movb	$0x1, %cl
000000010000848e	movq	%r13, -0x50(%rbp)
0000000100008492	addl	%r15d, %r13d
0000000100008495	cmpl	%r14d, %r13d
0000000100008498	movq	%rdi, -0x40(%rbp)
000000010000849c	movl	%ecx, -0x44(%rbp)
000000010000849f	jb	0x1000087b7
00000001000084a5	movl	%r14d, %ecx
00000001000084a8	subl	%r15d, %ecx
00000001000084ab	movl	%ecx, -0x34(%rbp)
00000001000084ae	movl	%ecx, %ecx
00000001000084b0	movq	%rcx, -0x60(%rbp)
00000001000084b4	testq	%r15, %r15
00000001000084b7	jne	0x1000084e0
00000001000084b9	testl	%r14d, %r14d
00000001000084bc	je	0x1000084e0
00000001000084be	movl	-0x34(%rbp), %r15d
00000001000084c2	movl	%r15d, -0x98(%rbp)
00000001000084c9	movq	%rbx, %rdi
00000001000084cc	callq	*(%rax)
00000001000084ce	movq	%rax, %r12
00000001000084d1	jmp	0x100008708
00000001000084d6	nopw	%cs:(%rax,%rax)
00000001000084e0	movq	%rsp, -0x88(%rbp)
00000001000084e7	testl	%r14d, %r14d
00000001000084ea	movl	$0x1, %eax
00000001000084ef	cmovnel	%r14d, %eax
00000001000084f3	shlq	$0x3, %rax
00000001000084f7	callq	0x100012be8                     ## symbol stub for: ____chkstk_darwin
00000001000084fc	addq	$0xf, %rax
0000000100008500	andq	$-0x10, %rax
0000000100008504	subq	%rax, %rsp
0000000100008507	movq	%rsp, %r13
000000010000850a	testq	%r15, %r15
000000010000850d	movq	-0x40(%rbp), %rdi
0000000100008511	je	0x1000085e0
0000000100008517	cmpl	$0x3, %r15d
000000010000851b	jbe	0x10000852d
000000010000851d	movq	%r13, %rax
0000000100008520	subq	%r12, %rax
0000000100008523	addq	$-0x8, %rax
0000000100008527	cmpq	$0x20, %rax
000000010000852b	jae	0x100008593
000000010000852d	xorl	%eax, %eax
000000010000852f	movq	%r15, %rdx
0000000100008532	movq	%rax, %rcx
0000000100008535	andq	$0x3, %rdx
0000000100008539	je	0x100008552
000000010000853b	movq	%rax, %rcx
000000010000853e	nop
0000000100008540	movq	0x8(%r12,%rcx,8), %rsi
0000000100008545	movq	%rsi, (%r13,%rcx,8)
000000010000854a	incq	%rcx
000000010000854d	decq	%rdx
0000000100008550	jne	0x100008540
0000000100008552	subq	%r15, %rax
0000000100008555	cmpq	$-0x4, %rax
0000000100008559	ja	0x1000085e0
000000010000855f	nop
0000000100008560	movq	0x8(%r12,%rcx,8), %rax
0000000100008565	movq	%rax, (%r13,%rcx,8)
000000010000856a	movq	0x10(%r12,%rcx,8), %rax
000000010000856f	movq	%rax, 0x8(%r13,%rcx,8)
0000000100008574	movq	0x18(%r12,%rcx,8), %rax
0000000100008579	movq	%rax, 0x10(%r13,%rcx,8)
000000010000857e	movq	0x20(%r12,%rcx,8), %rax
0000000100008583	movq	%rax, 0x18(%r13,%rcx,8)
0000000100008588	addq	$0x4, %rcx
000000010000858c	cmpq	%rcx, %r15
000000010000858f	jne	0x100008560
0000000100008591	jmp	0x1000085e0
0000000100008593	movl	%r15d, %eax
0000000100008596	andl	$-0x4, %eax
0000000100008599	leaq	(,%r15,8), %rcx
00000001000085a1	andq	$-0x20, %rcx
00000001000085a5	xorl	%edx, %edx
00000001000085a7	nopw	(%rax,%rax)
00000001000085b0	movups	0x8(%r12,%rdx), %xmm0
00000001000085b6	movups	0x18(%r12,%rdx), %xmm1
00000001000085bc	movaps	%xmm0, (%r13,%rdx)
00000001000085c2	movaps	%xmm1, 0x10(%r13,%rdx)
00000001000085c8	addq	$0x20, %rdx
00000001000085cc	cmpq	%rdx, %rcx
00000001000085cf	jne	0x1000085b0
00000001000085d1	cmpl	%r15d, %eax
00000001000085d4	jne	0x10000852f
00000001000085da	nopw	(%rax,%rax)
00000001000085e0	cmpl	%r15d, %r14d
00000001000085e3	movq	-0x58(%rbp), %r14
00000001000085e7	movq	-0x60(%rbp), %r9
00000001000085eb	je	0x1000086e0
00000001000085f1	cmpl	$0x9, -0x34(%rbp)
00000001000085f5	ja	0x100008688
00000001000085fb	xorl	%eax, %eax
00000001000085fd	movq	%r9, %rdx
0000000100008600	movq	%rax, %rcx
0000000100008603	andq	$0x3, %rdx
0000000100008607	je	0x100008625
0000000100008609	movq	%rax, %rcx
000000010000860c	nopl	(%rax)
0000000100008610	movq	(%rbx,%rcx,8), %rsi
0000000100008614	leal	(%r15,%rcx), %r8d
0000000100008618	movq	%rsi, (%r13,%r8,8)
000000010000861d	incq	%rcx
0000000100008620	decq	%rdx
0000000100008623	jne	0x100008610
0000000100008625	subq	%r9, %rax
0000000100008628	cmpq	$-0x4, %rax
000000010000862c	ja	0x1000086e0
0000000100008632	nopw	%cs:(%rax,%rax)
0000000100008640	movq	(%rbx,%rcx,8), %rax
0000000100008644	leal	(%r15,%rcx), %edx
0000000100008648	movq	%rax, (%r13,%rdx,8)
000000010000864d	movq	0x8(%rbx,%rcx,8), %rax
0000000100008652	leal	(%r15,%rcx), %edx
0000000100008656	incl	%edx
0000000100008658	movq	%rax, (%r13,%rdx,8)
000000010000865d	movq	0x10(%rbx,%rcx,8), %rax
0000000100008662	leal	0x2(%r15,%rcx), %edx
0000000100008667	movq	%rax, (%r13,%rdx,8)
000000010000866c	movq	0x18(%rbx,%rcx,8), %rax
0000000100008671	leal	(%r15,%rcx), %edx
0000000100008675	addl	$0x3, %edx
0000000100008678	movq	%rax, (%r13,%rdx,8)
000000010000867d	addq	$0x4, %rcx
0000000100008681	cmpq	%rcx, %r9
0000000100008684	jne	0x100008640
0000000100008686	jmp	0x1000086e0
0000000100008688	leaq	-0x1(%r9), %rax
000000010000868c	movl	%eax, %ecx
000000010000868e	addl	%r15d, %ecx
0000000100008691	jb	0x1000085fb
0000000100008697	shrq	$0x20, %rax
000000010000869b	movl	$0x0, %eax
00000001000086a0	jne	0x1000085fd
00000001000086a6	movl	%r9d, %eax
00000001000086a9	andl	$-0x4, %eax
00000001000086ac	xorl	%ecx, %ecx
00000001000086ae	nop
00000001000086b0	movups	(%rbx,%rcx,8), %xmm0
00000001000086b4	movups	0x10(%rbx,%rcx,8), %xmm1
00000001000086b9	leal	(%r15,%rcx), %edx
00000001000086bd	movups	%xmm0, (%r13,%rdx,8)
00000001000086c3	movups	%xmm1, 0x10(%r13,%rdx,8)
00000001000086c9	addq	$0x4, %rcx
00000001000086cd	cmpq	%rcx, %rax
00000001000086d0	jne	0x1000086b0
00000001000086d2	cmpl	%r9d, %eax
00000001000086d5	jne	0x1000085fd
00000001000086db	nopl	(%rax,%rax)
00000001000086e0	movq	(%r14), %rax
00000001000086e3	movl	$0x1, %esi
00000001000086e8	callq	*0x8(%rax)
00000001000086eb	movl	-0x34(%rbp), %r15d
00000001000086ef	movl	%r15d, -0x98(%rbp)
00000001000086f6	movq	(%r14), %rax
00000001000086f9	movq	%r13, %rdi
00000001000086fc	callq	*(%rax)
00000001000086fe	movq	%rax, %r12
0000000100008701	movq	-0x88(%rbp), %rsp
0000000100008708	cmpb	$0x0, -0x44(%rbp)
000000010000870c	movq	-0x50(%rbp), %r13
0000000100008710	movq	-0x40(%rbp), %rdi
0000000100008714	je	0x100008732
0000000100008716	leaq	-0x80(%rbp), %rax
000000010000871a	cmpq	%rax, _fwp_cleanups(%rip)
0000000100008721	jne	0x100008b94
0000000100008727	movq	-0x80(%rbp), %rax
000000010000872b	movq	%rax, _fwp_cleanups(%rip)
0000000100008732	callq	_fwp_closure_drop
0000000100008737	subl	%r15d, %r13d
000000010000873a	je	0x100008b72
0000000100008740	movq	-0x60(%rbp), %rax
0000000100008744	leaq	(%rbx,%rax,8), %rbx
0000000100008748	movq	_fwp_fns(%rip), %rax
000000010000874f	movl	(%r12), %edx
0000000100008753	shlq	$0x5, %rdx
0000000100008757	leaq	(%rax,%rdx), %rcx
000000010000875b	leaq	(%rax,%rdx), %rsi
000000010000875f	addq	$0x18, %rsi
0000000100008763	movq	0x18(%rax,%rdx), %rax
0000000100008768	movq	%r12, %rdi
000000010000876b	testq	%rax, %rax
000000010000876e	jne	0x100008380
0000000100008774	jmp	0x100008779
0000000100008776	movq	%rdi, %r12
0000000100008779	movq	%r12, %rdi
000000010000877c	callq	_fwp_rc_share
0000000100008781	testl	%r13d, %r13d
0000000100008784	je	0x1000087a1
0000000100008786	movl	%r13d, %r14d
0000000100008789	xorl	%r15d, %r15d
000000010000878c	nopl	(%rax)
0000000100008790	movq	(%rbx,%r15,8), %rdi
0000000100008794	callq	_fwp_rc_share
0000000100008799	incq	%r15
000000010000879c	cmpq	%r15, %r14
000000010000879f	jne	0x100008790
00000001000087a1	movq	%r12, %rdi
00000001000087a4	movl	%r13d, %esi
00000001000087a7	movq	%rbx, %rdx
00000001000087aa	callq	_fwp_apply
00000001000087af	movq	%rax, %r12
00000001000087b2	jmp	0x100008b72
00000001000087b7	movl	%r13d, %eax
00000001000087ba	leaq	0x8(,%rax,8), %rdi
00000001000087c2	callq	_fwp_alloc_init
00000001000087c7	movq	-0x40(%rbp), %rdi
00000001000087cb	movq	%rax, %r14
00000001000087ce	movl	(%r12), %eax
00000001000087d2	movl	%eax, (%r14)
00000001000087d5	movl	%r13d, 0x4(%r14)
00000001000087d9	movq	%r14, %rax
00000001000087dc	subq	0xe855(%rip), %rax
00000001000087e3	movq	0xe876(%rip), %rcx
00000001000087ea	shlq	$0x10, %rcx
00000001000087ee	cmpq	%rcx, %rax
00000001000087f1	jae	0x10000886a
00000001000087f3	movq	0xe886(%rip), %rcx
00000001000087fa	movq	%rax, %rdx
00000001000087fd	shrq	$0x10, %rdx
0000000100008801	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008808	leaq	(%rcx,%rdx), %r13
000000010000880c	movzbl	(%rcx,%rdx), %ecx
0000000100008810	cmpb	$0x2, %cl
0000000100008813	setne	%dl
0000000100008816	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000881c	setne	%sil
0000000100008820	orb	%dl, %sil
0000000100008823	jne	0x10000883a
0000000100008825	addq	$0x228, %r13                    ## imm = 0x228
000000010000882c	cmpb	$-0x1, (%r13)
0000000100008831	je	0x10000885c
0000000100008833	movb	$0x1, (%r13)
0000000100008838	jmp	0x10000886a
000000010000883a	cmpb	$0x1, %cl
000000010000883d	jne	0x10000886a
000000010000883f	movl	0x20(%r13), %ecx
0000000100008843	imulq	%rcx, %rax
0000000100008847	shrq	$0x20, %rax
000000010000884b	addq	%rax, %r13
000000010000884e	addq	$0x228, %r13                    ## imm = 0x228
0000000100008855	cmpb	$-0x1, (%r13)
000000010000885a	jne	0x100008833
000000010000885c	movq	%r13, %rdi
000000010000885f	callq	_fwp_rc_forget_slot
0000000100008864	movq	-0x40(%rbp), %rdi
0000000100008868	jmp	0x100008833
000000010000886a	movq	%r14, -0x68(%rbp)
000000010000886e	movq	_fwp_cleanups(%rip), %rax
0000000100008875	movq	%rax, -0xc8(%rbp)
000000010000887c	leaq	_fwp_rc_cleanup_cell(%rip), %rax
0000000100008883	movq	%rax, -0xc0(%rbp)
000000010000888a	leaq	-0x68(%rbp), %rax
000000010000888e	movq	%rax, -0xb8(%rbp)
0000000100008895	leaq	-0xc8(%rbp), %r13
000000010000889c	movq	%r13, _fwp_cleanups(%rip)
00000001000088a3	testq	%r15, %r15
00000001000088a6	je	0x100008971
00000001000088ac	xorl	%eax, %eax
00000001000088ae	cmpl	$0x6, %r15d
00000001000088b2	jb	0x100008906
00000001000088b4	movq	%r14, %rcx
00000001000088b7	subq	%r12, %rcx
00000001000088ba	cmpq	$0x1f, %rcx
00000001000088be	jbe	0x100008906
00000001000088c0	movl	%r15d, %eax
00000001000088c3	andl	$-0x4, %eax
00000001000088c6	leaq	(,%r15,8), %rcx
00000001000088ce	andq	$-0x20, %rcx
00000001000088d2	xorl	%edx, %edx
00000001000088d4	nopw	%cs:(%rax,%rax)
00000001000088e0	movups	0x8(%r12,%rdx), %xmm0
00000001000088e6	movups	0x18(%r12,%rdx), %xmm1
00000001000088ec	movups	%xmm0, 0x8(%r14,%rdx)
00000001000088f2	movups	%xmm1, 0x18(%r14,%rdx)
00000001000088f8	addq	$0x20, %rdx
00000001000088fc	cmpq	%rdx, %rcx
00000001000088ff	jne	0x1000088e0
0000000100008901	cmpl	%r15d, %eax
0000000100008904	je	0x100008971
0000000100008906	movq	%r15, %rdx
0000000100008909	movq	%rax, %rcx
000000010000890c	andq	$0x3, %rdx
0000000100008910	je	0x100008932
0000000100008912	movq	%rax, %rcx
0000000100008915	nopw	%cs:(%rax,%rax)
0000000100008920	movq	0x8(%r12,%rcx,8), %rsi
0000000100008925	movq	%rsi, 0x8(%r14,%rcx,8)
000000010000892a	incq	%rcx
000000010000892d	decq	%rdx
0000000100008930	jne	0x100008920
0000000100008932	subq	%r15, %rax
0000000100008935	cmpq	$-0x4, %rax
0000000100008939	ja	0x100008971
000000010000893b	nopl	(%rax,%rax)
0000000100008940	movq	0x8(%r12,%rcx,8), %rax
0000000100008945	movq	%rax, 0x8(%r14,%rcx,8)
000000010000894a	movq	0x10(%r12,%rcx,8), %rax
000000010000894f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100008954	movq	0x18(%r12,%rcx,8), %rax
0000000100008959	movq	%rax, 0x18(%r14,%rcx,8)
000000010000895e	movq	0x20(%r12,%rcx,8), %rax
0000000100008963	movq	%rax, 0x20(%r14,%rcx,8)
0000000100008968	addq	$0x4, %rcx
000000010000896c	cmpq	%rcx, %r15
000000010000896f	jne	0x100008940
0000000100008971	cmpl	$0x0, -0x50(%rbp)
0000000100008975	je	0x100008a06
000000010000897b	movq	-0x50(%rbp), %rcx
000000010000897f	movl	%ecx, %eax
0000000100008981	cmpl	$0x13, %ecx
0000000100008984	ja	0x100008a85
000000010000898a	xorl	%ecx, %ecx
000000010000898c	movq	%rax, %rsi
000000010000898f	movq	%rcx, %rdx
0000000100008992	andq	$0x3, %rsi
0000000100008996	je	0x1000089b5
0000000100008998	movq	%rcx, %rdx
000000010000899b	nopl	(%rax,%rax)
00000001000089a0	movq	(%rbx,%rdx,8), %r9
00000001000089a4	leal	(%r15,%rdx), %r8d
00000001000089a8	movq	%r9, 0x8(%r14,%r8,8)
00000001000089ad	incq	%rdx
00000001000089b0	decq	%rsi
00000001000089b3	jne	0x1000089a0
00000001000089b5	subq	%rax, %rcx
00000001000089b8	cmpq	$-0x4, %rcx
00000001000089bc	ja	0x100008a06
00000001000089be	nop
00000001000089c0	movq	(%rbx,%rdx,8), %rcx
00000001000089c4	leal	(%r15,%rdx), %esi
00000001000089c8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000089cd	movq	0x8(%rbx,%rdx,8), %rcx
00000001000089d2	leal	(%r15,%rdx), %esi
00000001000089d6	incl	%esi
00000001000089d8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000089dd	movq	0x10(%rbx,%rdx,8), %rcx
00000001000089e2	leal	0x2(%r15,%rdx), %esi
00000001000089e7	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000089ec	movq	0x18(%rbx,%rdx,8), %rcx
00000001000089f1	leal	(%r15,%rdx), %esi
00000001000089f5	addl	$0x3, %esi
00000001000089f8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000089fd	addq	$0x4, %rdx
0000000100008a01	cmpq	%rdx, %rax
0000000100008a04	jne	0x1000089c0
0000000100008a06	movq	-0x58(%rbp), %rax
0000000100008a0a	movq	(%rax), %rax
0000000100008a0d	movl	$0x1, %esi
0000000100008a12	callq	*0x8(%rax)
0000000100008a15	movq	%r14, %rax
0000000100008a18	subq	0xe619(%rip), %rax
0000000100008a1f	movq	0xe63a(%rip), %rcx
0000000100008a26	shlq	$0x10, %rcx
0000000100008a2a	cmpq	%rcx, %rax
0000000100008a2d	jae	0x100008b23
0000000100008a33	movq	0xe646(%rip), %rcx
0000000100008a3a	movq	%rax, %rdx
0000000100008a3d	shrq	$0x10, %rdx
0000000100008a41	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008a48	leaq	(%rcx,%rdx), %r12
0000000100008a4c	movzbl	(%rcx,%rdx), %ecx
0000000100008a50	cmpb	$0x2, %cl
0000000100008a53	setne	%dl
0000000100008a56	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008a5c	setne	%sil
0000000100008a60	orb	%dl, %sil
0000000100008a63	jne	0x100008aef
0000000100008a69	addq	$0x228, %r12                    ## imm = 0x228
0000000100008a70	cmpb	$-0x1, (%r12)
0000000100008a75	je	0x100008b16
0000000100008a7b	movb	$0x1, (%r12)
0000000100008a80	jmp	0x100008b23
0000000100008a85	leaq	-0x1(%rax), %rdx
0000000100008a89	xorl	%ecx, %ecx
0000000100008a8b	movl	%edx, %esi
0000000100008a8d	addl	%r15d, %esi
0000000100008a90	jb	0x10000898c
0000000100008a96	shrq	$0x20, %rdx
0000000100008a9a	jne	0x10000898c
0000000100008aa0	leaq	(%r14,%r15,8), %rcx
0000000100008aa4	subq	%rbx, %rcx
0000000100008aa7	addq	$0x8, %rcx
0000000100008aab	cmpq	$0x20, %rcx
0000000100008aaf	jb	0x10000898a
0000000100008ab5	movl	%eax, %ecx
0000000100008ab7	andl	$-0x4, %ecx
0000000100008aba	xorl	%edx, %edx
0000000100008abc	nopl	(%rax)
0000000100008ac0	movups	(%rbx,%rdx,8), %xmm0
0000000100008ac4	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100008ac9	leal	(%r15,%rdx), %esi
0000000100008acd	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100008ad3	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100008ad9	addq	$0x4, %rdx
0000000100008add	cmpq	%rdx, %rcx
0000000100008ae0	jne	0x100008ac0
0000000100008ae2	cmpl	%eax, %ecx
0000000100008ae4	jne	0x10000898c
0000000100008aea	jmp	0x100008a06
0000000100008aef	cmpb	$0x1, %cl
0000000100008af2	jne	0x100008b23
0000000100008af4	movl	0x20(%r12), %ecx
0000000100008af9	imulq	%rcx, %rax
0000000100008afd	shrq	$0x20, %rax
0000000100008b01	addq	%rax, %r12
0000000100008b04	addq	$0x228, %r12                    ## imm = 0x228
0000000100008b0b	cmpb	$-0x1, (%r12)
0000000100008b10	jne	0x100008a7b
0000000100008b16	movq	%r12, %rdi
0000000100008b19	callq	_fwp_rc_forget_slot
0000000100008b1e	jmp	0x100008a7b
0000000100008b23	movq	-0x50(%rbp), %rax
0000000100008b27	movl	%eax, -0x98(%rbp)
0000000100008b2d	movq	$0x0, -0x68(%rbp)
0000000100008b35	cmpq	%r13, _fwp_cleanups(%rip)
0000000100008b3c	jne	0x100008b94
0000000100008b3e	movq	-0xc8(%rbp), %rax
0000000100008b45	movq	%rax, _fwp_cleanups(%rip)
0000000100008b4c	cmpb	$0x0, -0x44(%rbp)
0000000100008b50	movq	-0x40(%rbp), %rdi
0000000100008b54	je	0x100008b6a
0000000100008b56	leaq	-0x80(%rbp), %rcx
0000000100008b5a	cmpq	%rcx, %rax
0000000100008b5d	jne	0x100008b94
0000000100008b5f	movq	-0x80(%rbp), %rax
0000000100008b63	movq	%rax, _fwp_cleanups(%rip)
0000000100008b6a	callq	_fwp_closure_drop
0000000100008b6f	movq	%r14, %r12
0000000100008b72	movq	0xc4b7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008b79	movq	(%rax), %rax
0000000100008b7c	cmpq	-0x30(%rbp), %rax
0000000100008b80	jne	0x100008b99
0000000100008b82	movq	%r12, %rax
0000000100008b85	leaq	-0x28(%rbp), %rsp
0000000100008b89	popq	%rbx
0000000100008b8a	popq	%r12
0000000100008b8c	popq	%r13
0000000100008b8e	popq	%r14
0000000100008b90	popq	%r15
0000000100008b92	popq	%rbp
0000000100008b93	retq
0000000100008b94	callq	0x100012c2a                     ## symbol stub for: _abort
0000000100008b99	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100008b9e	nop
_fwp_alloc:
0000000100008ba0	pushq	%rbp
0000000100008ba1	movq	%rsp, %rbp
0000000100008ba4	pushq	%rbx
0000000100008ba5	pushq	%rax
0000000100008ba6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
0000000100008bad	ja	0x100008c07
0000000100008baf	leaq	0xf(%rdi), %rcx
0000000100008bb3	shrq	$0x4, %rcx
0000000100008bb7	leaq	_fwp_gc(%rip), %rax
0000000100008bbe	movzbl	0xbe8(%rcx,%rax), %ecx
0000000100008bc6	movl	0xb48(%rax,%rcx,4), %esi
0000000100008bcd	subq	%rsi, _fwp_gc(%rip)
0000000100008bd4	js	0x100008c07
0000000100008bd6	leaq	(%rcx,%rcx,2), %rcx
0000000100008bda	leaq	(%rax,%rcx,8), %rax
0000000100008bde	addq	$0x788, %rax                    ## imm = 0x788
0000000100008be4	movq	(%rax), %rbx
0000000100008be7	testq	%rbx, %rbx
0000000100008bea	je	0x100008bf7
0000000100008bec	movq	(%rbx), %rcx
0000000100008bef	notq	%rcx
0000000100008bf2	movq	%rcx, (%rax)
0000000100008bf5	jmp	0x100008c1f
0000000100008bf7	movq	0x8(%rax), %rbx
0000000100008bfb	movq	0x10(%rax), %rcx
0000000100008bff	subq	%rbx, %rcx
0000000100008c02	cmpq	%rsi, %rcx
0000000100008c05	jae	0x100008c17
0000000100008c07	movl	$0x2, %esi
0000000100008c0c	addq	$0x8, %rsp
0000000100008c10	popq	%rbx
0000000100008c11	popq	%rbp
0000000100008c12	jmp	_fwp_gc_alloc_slow
0000000100008c17	leaq	(%rbx,%rsi), %rcx
0000000100008c1b	movq	%rcx, 0x8(%rax)
0000000100008c1f	movq	%rbx, %rdi
0000000100008c22	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100008c27	movq	%rbx, %rax
0000000100008c2a	addq	$0x8, %rsp
0000000100008c2e	popq	%rbx
0000000100008c2f	popq	%rbp
0000000100008c30	retq
0000000100008c31	nopw	%cs:(%rax,%rax)
_fwp_closure_drop:
0000000100008c40	pushq	%rbp
0000000100008c41	movq	%rsp, %rbp
0000000100008c44	pushq	%r15
0000000100008c46	pushq	%r14
0000000100008c48	pushq	%rbx
0000000100008c49	subq	$0x238, %rsp                    ## imm = 0x238
0000000100008c50	movq	%rdi, %rax
0000000100008c53	subq	0xe3de(%rip), %rax
0000000100008c5a	movq	0xe3ff(%rip), %rcx
0000000100008c61	shlq	$0x10, %rcx
0000000100008c65	cmpq	%rcx, %rax
0000000100008c68	jae	0x100008d04
0000000100008c6e	movq	%rdi, %rsi
0000000100008c71	movq	0xe408(%rip), %rcx
0000000100008c78	movq	%rax, %rdx
0000000100008c7b	shrq	$0x10, %rdx
0000000100008c7f	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008c86	leaq	(%rcx,%rdx), %rdi
0000000100008c8a	movzbl	(%rcx,%rdx), %ecx
0000000100008c8e	cmpb	$0x2, %cl
0000000100008c91	setne	%dl
0000000100008c94	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008c9a	setne	%r8b
0000000100008c9e	orb	%dl, %r8b
0000000100008ca1	jne	0x100008cac
0000000100008ca3	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008caa	jmp	0x100008cc6
0000000100008cac	cmpb	$0x1, %cl
0000000100008caf	jne	0x100008d04
0000000100008cb1	movl	0x20(%rdi), %ecx
0000000100008cb4	imulq	%rcx, %rax
0000000100008cb8	shrq	$0x20, %rax
0000000100008cbc	addq	%rax, %rdi
0000000100008cbf	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008cc6	movzbl	(%rdi), %eax
0000000100008cc9	testl	%eax, %eax
0000000100008ccb	je	0x100008d04
0000000100008ccd	cmpl	$0x1, %eax
0000000100008cd0	jne	0x100008cf5
0000000100008cd2	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100008cd9	callq	*(%rdi)
0000000100008cdb	movq	(%rax), %rdi
0000000100008cde	testq	%rdi, %rdi
0000000100008ce1	je	0x100008d12
0000000100008ce3	addq	$0x238, %rsp                    ## imm = 0x238
0000000100008cea	popq	%rbx
0000000100008ceb	popq	%r14
0000000100008ced	popq	%r15
0000000100008cef	popq	%rbp
0000000100008cf0	jmp	_fwp_closure_drop_push
0000000100008cf5	cmpl	$0xff, %eax
0000000100008cfa	je	0x100008de6
0000000100008d00	decb	%al
0000000100008d02	movb	%al, (%rdi)
0000000100008d04	addq	$0x238, %rsp                    ## imm = 0x238
0000000100008d0b	popq	%rbx
0000000100008d0c	popq	%r14
0000000100008d0e	popq	%r15
0000000100008d10	popq	%rbp
0000000100008d11	retq
0000000100008d12	leaq	-0x230(%rbp), %rbx
0000000100008d19	movq	%rbx, -0x248(%rbp)
0000000100008d20	movq	$0x0, -0x240(%rbp)
0000000100008d2b	movq	$0x40, -0x238(%rbp)
0000000100008d36	movq	_fwp_cleanups(%rip), %rcx
0000000100008d3d	movq	%rcx, -0x30(%rbp)
0000000100008d41	leaq	_fwp_closure_drop_release(%rip), %rcx
0000000100008d48	movq	%rcx, -0x28(%rbp)
0000000100008d4c	leaq	-0x248(%rbp), %rdi
0000000100008d53	movq	%rdi, -0x20(%rbp)
0000000100008d57	leaq	-0x30(%rbp), %r15
0000000100008d5b	movq	%r15, _fwp_cleanups(%rip)
0000000100008d62	movq	%rax, %r14
0000000100008d65	movq	%rdi, (%rax)
0000000100008d68	callq	_fwp_closure_drop_push
0000000100008d6d	nopl	(%rax)
0000000100008d70	movq	-0x240(%rbp), %rax
0000000100008d77	testq	%rax, %rax
0000000100008d7a	je	0x100008db1
0000000100008d7c	movq	-0x248(%rbp), %rcx
0000000100008d83	leaq	-0x1(%rax), %rdx
0000000100008d87	movq	%rdx, -0x240(%rbp)
0000000100008d8e	movq	-0x8(%rcx,%rax,8), %rdi
0000000100008d93	movq	_fwp_fns(%rip), %rax
0000000100008d9a	movl	(%rdi), %ecx
0000000100008d9c	shlq	$0x5, %rcx
0000000100008da0	movq	0x18(%rax,%rcx), %rax
0000000100008da5	testq	%rax, %rax
0000000100008da8	je	0x100008df8
0000000100008daa	xorl	%esi, %esi
0000000100008dac	callq	*0x8(%rax)
0000000100008daf	jmp	0x100008d70
0000000100008db1	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008db8	jne	0x100008e26
0000000100008dba	movq	-0x30(%rbp), %rax
0000000100008dbe	movq	%rax, _fwp_cleanups(%rip)
0000000100008dc5	movq	$0x0, (%r14)
0000000100008dcc	movq	-0x248(%rbp), %rdi
0000000100008dd3	cmpq	%rbx, %rdi
0000000100008dd6	je	0x100008d04
0000000100008ddc	callq	0x100012c72                     ## symbol stub for: _free
0000000100008de1	jmp	0x100008d04
0000000100008de6	addq	$0x238, %rsp                    ## imm = 0x238
0000000100008ded	popq	%rbx
0000000100008dee	popq	%r14
0000000100008df0	popq	%r15
0000000100008df2	popq	%rbp
0000000100008df3	jmp	_fwp_rc_wide_drop
0000000100008df8	callq	_fwp_flush
0000000100008dfd	movq	0xc234(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008e04	movq	(%rax), %rdi
0000000100008e07	leaq	0xa601(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100008e0e	leaq	0xa78e(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100008e15	xorl	%eax, %eax
0000000100008e17	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100008e1c	movl	$0x65, %edi
0000000100008e21	callq	0x100012c48                     ## symbol stub for: _exit
0000000100008e26	callq	0x100012c2a                     ## symbol stub for: _abort
0000000100008e2b	nopl	(%rax,%rax)
_fwp_closure_drop_push:
0000000100008e30	pushq	%rbp
0000000100008e31	movq	%rsp, %rbp
0000000100008e34	pushq	%r15
0000000100008e36	pushq	%r14
0000000100008e38	pushq	%r13
0000000100008e3a	pushq	%r12
0000000100008e3c	pushq	%rbx
0000000100008e3d	pushq	%rax
0000000100008e3e	movq	%rsi, %rbx
0000000100008e41	movq	%rdi, %r14
0000000100008e44	movq	0x8(%rdi), %r13
0000000100008e48	cmpq	0x10(%rdi), %r13
0000000100008e4c	jne	0x100008eb3
0000000100008e4e	movq	%r13, %rax
0000000100008e51	shrq	$0x3c, %rax
0000000100008e55	jne	0x100008ed1
0000000100008e57	movq	%r13, %rdi
0000000100008e5a	shlq	$0x4, %rdi
0000000100008e5e	callq	0x100012c96                     ## symbol stub for: _malloc
0000000100008e63	testq	%rax, %rax
0000000100008e66	je	0x100008ef0
0000000100008e6c	movq	%rax, %r15
0000000100008e6f	leaq	(,%r13,2), %rax
0000000100008e77	movq	%rax, -0x30(%rbp)
0000000100008e7b	movq	(%r14), %r12
0000000100008e7e	leaq	(,%r13,8), %rdx
0000000100008e86	movq	%r15, %rdi
0000000100008e89	movq	%r12, %rsi
0000000100008e8c	callq	0x100012ca8                     ## symbol stub for: _memcpy
0000000100008e91	leaq	0x18(%r14), %rax
0000000100008e95	cmpq	%rax, %r12
0000000100008e98	je	0x100008ea6
0000000100008e9a	movq	%r12, %rdi
0000000100008e9d	callq	0x100012c72                     ## symbol stub for: _free
0000000100008ea2	movq	0x8(%r14), %r13
0000000100008ea6	movq	%r15, (%r14)
0000000100008ea9	movq	-0x30(%rbp), %rax
0000000100008ead	movq	%rax, 0x10(%r14)
0000000100008eb1	jmp	0x100008eb6
0000000100008eb3	movq	(%r14), %r15
0000000100008eb6	leaq	0x1(%r13), %rax
0000000100008eba	movq	%rax, 0x8(%r14)
0000000100008ebe	movq	%rbx, (%r15,%r13,8)
0000000100008ec2	addq	$0x8, %rsp
0000000100008ec6	popq	%rbx
0000000100008ec7	popq	%r12
0000000100008ec9	popq	%r13
0000000100008ecb	popq	%r14
0000000100008ecd	popq	%r15
0000000100008ecf	popq	%rbp
0000000100008ed0	retq
0000000100008ed1	callq	_fwp_flush
0000000100008ed6	movq	0xc15b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008edd	movq	(%rax), %rdi
0000000100008ee0	leaq	0xa528(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100008ee7	leaq	0xa6e3(%rip), %rdx              ## literal pool for: "closure cleanup too large"
0000000100008eee	jmp	0x100008f0d
0000000100008ef0	callq	_fwp_flush
0000000100008ef5	movq	0xc13c(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008efc	movq	(%rax), %rdi
0000000100008eff	leaq	0xa509(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100008f06	leaq	0xa6de(%rip), %rdx              ## literal pool for: "out of memory"
0000000100008f0d	xorl	%eax, %eax
0000000100008f0f	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100008f14	movl	$0x65, %edi
0000000100008f19	callq	0x100012c48                     ## symbol stub for: _exit
0000000100008f1e	nop
_fwp_closure_drop_release:
0000000100008f20	pushq	%rbp
0000000100008f21	movq	%rsp, %rbp
0000000100008f24	pushq	%r14
0000000100008f26	pushq	%rbx
0000000100008f27	movq	%rdi, %rbx
0000000100008f2a	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100008f31	callq	*(%rdi)
0000000100008f33	movq	$0x0, (%rax)
0000000100008f3a	movq	(%rbx), %rdi
0000000100008f3d	leaq	0x18(%rbx), %r14
0000000100008f41	cmpq	%r14, %rdi
0000000100008f44	je	0x100008f4b
0000000100008f46	callq	0x100012c72                     ## symbol stub for: _free
0000000100008f4b	movq	%r14, (%rbx)
0000000100008f4e	movq	$0x0, 0x8(%rbx)
0000000100008f56	popq	%rbx
0000000100008f57	popq	%r14
0000000100008f59	popq	%rbp
0000000100008f5a	retq
0000000100008f5b	nopl	(%rax,%rax)
_fwp_rc_cleanup_cell:
0000000100008f60	pushq	%rbp
0000000100008f61	movq	%rsp, %rbp
0000000100008f64	movq	%rdi, %rax
0000000100008f67	movq	(%rdi), %rdi
0000000100008f6a	movq	$0x0, (%rax)
0000000100008f71	testq	%rdi, %rdi
0000000100008f74	je	0x100008f7c
0000000100008f76	popq	%rbp
0000000100008f77	jmp	_fwp_rc_free_obj
0000000100008f7c	popq	%rbp
0000000100008f7d	retq
0000000100008f7e	nop
_f32:
0000000100008f80	pushq	%rbp
0000000100008f81	movq	%rsp, %rbp
0000000100008f84	pushq	%r15
0000000100008f86	pushq	%r14
0000000100008f88	pushq	%r13
0000000100008f8a	pushq	%r12
0000000100008f8c	pushq	%rbx
0000000100008f8d	subq	$0x158, %rsp                    ## imm = 0x158
0000000100008f94	movq	%rdi, %rbx
0000000100008f97	movq	0xc092(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008f9e	movq	(%rax), %rax
0000000100008fa1	movq	%rax, -0x30(%rbp)
0000000100008fa5	movq	%rdi, -0xe0(%rbp)
0000000100008fac	movq	_fwp_cleanups(%rip), %rax
0000000100008fb3	movq	%rax, -0xd8(%rbp)
0000000100008fba	leaq	_fwp_owner_release18(%rip), %rax
0000000100008fc1	movq	%rax, -0xd0(%rbp)
0000000100008fc8	leaq	-0xe0(%rbp), %rax
0000000100008fcf	movq	%rax, -0xc8(%rbp)
0000000100008fd6	movq	$0x0, -0xb8(%rbp)
0000000100008fe1	leaq	-0xd8(%rbp), %rax
0000000100008fe8	movq	%rax, -0x138(%rbp)
0000000100008fef	leaq	_fwp_owner_release19(%rip), %rax
0000000100008ff6	movq	%rax, -0x130(%rbp)
0000000100008ffd	leaq	-0xb8(%rbp), %rax
0000000100009004	movq	%rax, -0x128(%rbp)
000000010000900b	leaq	-0x138(%rbp), %r15
0000000100009012	movq	%r15, _fwp_cleanups(%rip)
0000000100009019	movq	0x10(%rdi), %rax
000000010000901d	subq	0xe014(%rip), %rax
0000000100009024	movq	0xe035(%rip), %rcx
000000010000902b	shlq	$0x10, %rcx
000000010000902f	cmpq	%rcx, %rax
0000000100009032	jae	0x10000909c
0000000100009034	movq	0xe045(%rip), %rcx
000000010000903b	movq	%rax, %rdx
000000010000903e	shrq	$0x10, %rdx
0000000100009042	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009049	leaq	(%rcx,%rdx), %rdi
000000010000904d	movzbl	(%rcx,%rdx), %ecx
0000000100009051	cmpb	$0x2, %cl
0000000100009054	setne	%dl
0000000100009057	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000905d	setne	%sil
0000000100009061	orb	%dl, %sil
0000000100009064	jne	0x10000906f
0000000100009066	addq	$0x228, %rdi                    ## imm = 0x228
000000010000906d	jmp	0x100009089
000000010000906f	cmpb	$0x1, %cl
0000000100009072	jne	0x10000909c
0000000100009074	movl	0x20(%rdi), %ecx
0000000100009077	imulq	%rcx, %rax
000000010000907b	shrq	$0x20, %rax
000000010000907f	addq	%rax, %rdi
0000000100009082	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009089	movzbl	(%rdi), %eax
000000010000908c	testb	%al, %al
000000010000908e	je	0x10000909c
0000000100009090	cmpb	$-0x3, %al
0000000100009092	ja	0x10000963d
0000000100009098	incb	%al
000000010000909a	movb	%al, (%rdi)
000000010000909c	movq	0x10(%rbx), %r14
00000001000090a0	movq	%r14, -0xb8(%rbp)
00000001000090a7	movq	-0x138(%rbp), %rax
00000001000090ae	movq	0x8(%rbx), %r13
00000001000090b2	movq	0x18(%rbx), %r15
00000001000090b6	movq	%r14, -0x120(%rbp)
00000001000090bd	movq	%rax, -0x168(%rbp)
00000001000090c4	leaq	_fwp_owner_release10(%rip), %rax
00000001000090cb	movq	%rax, -0x160(%rbp)
00000001000090d2	leaq	-0x120(%rbp), %rax
00000001000090d9	movq	%rax, -0x158(%rbp)
00000001000090e0	leaq	-0x168(%rbp), %rax
00000001000090e7	movq	%rax, _fwp_cleanups(%rip)
00000001000090ee	testq	%r13, %r13
00000001000090f1	js	0x10000912f
00000001000090f3	movq	(%r14), %rsi
00000001000090f6	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100009100	andq	%rsi, %rcx
0000000100009103	cmpq	%r13, %rcx
0000000100009106	jbe	0x10000912f
0000000100009108	movl	_d1(%rip), %ecx
000000010000910e	movl	$0x8, %edx
0000000100009113	cmpq	$0xa, %rcx
0000000100009117	ja	0x100009124
0000000100009119	leaq	0xa038(%rip), %rdx
0000000100009120	movq	(%rdx,%rcx,8), %rdx
0000000100009124	testq	%rsi, %rsi
0000000100009127	js	0x100009136
0000000100009129	leaq	0x8(%r14), %rsi
000000010000912d	jmp	0x10000913a
000000010000912f	xorl	%ecx, %ecx
0000000100009131	xorl	%r12d, %r12d
0000000100009134	jmp	0x100009181
0000000100009136	movq	0x10(%r14), %rsi
000000010000913a	movq	%rdx, %rdi
000000010000913d	imulq	%r13, %rdi
0000000100009141	cmpq	$0x1, %rdx
0000000100009145	je	0x10000916a
0000000100009147	cmpq	$0x2, %rdx
000000010000914b	je	0x100009159
000000010000914d	cmpq	$0x8, %rdx
0000000100009151	jne	0x10000917b
0000000100009153	movq	(%rsi,%rdi), %r12
0000000100009157	jmp	0x10000917f
0000000100009159	movzwl	(%rsi,%rdi), %edx
000000010000915d	cmpl	$0x1, %ecx
0000000100009160	movswq	%dx, %r12
0000000100009164	cmovneq	%rdx, %r12
0000000100009168	jmp	0x10000917f
000000010000916a	movzbl	(%rsi,%rdi), %edx
000000010000916e	testq	%rcx, %rcx
0000000100009171	movsbq	%dl, %r12
0000000100009175	cmovneq	%rdx, %r12
0000000100009179	jmp	0x10000917f
000000010000917b	movl	(%rsi,%rdi), %r12d
000000010000917f	movb	$0x1, %cl
0000000100009181	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009188	jne	0x100009678
000000010000918e	movq	-0x168(%rbp), %rax
0000000100009195	movq	%rax, _fwp_cleanups(%rip)
000000010000919c	testb	%cl, %cl
000000010000919e	je	0x10000927a
00000001000091a4	movq	%r14, -0x118(%rbp)
00000001000091ab	movq	%rax, -0x180(%rbp)
00000001000091b2	leaq	_fwp_owner_release11(%rip), %rcx
00000001000091b9	movq	%rcx, -0x178(%rbp)
00000001000091c0	leaq	-0x118(%rbp), %rcx
00000001000091c7	movq	%rcx, -0x170(%rbp)
00000001000091ce	leaq	-0x180(%rbp), %rcx
00000001000091d5	movq	%rcx, _fwp_cleanups(%rip)
00000001000091dc	incq	%r13
00000001000091df	jo	0x100009682
00000001000091e5	movq	%r14, -0x110(%rbp)
00000001000091ec	movq	%rax, -0x90(%rbp)
00000001000091f3	leaq	_fwp_owner_release14(%rip), %rax
00000001000091fa	movq	%rax, -0x88(%rbp)
0000000100009201	leaq	-0x110(%rbp), %rax
0000000100009208	movq	%rax, -0x80(%rbp)
000000010000920c	leaq	-0x90(%rbp), %rcx
0000000100009213	movq	%r14, %rax
0000000100009216	subq	0xde1b(%rip), %rax
000000010000921d	movq	%rcx, _fwp_cleanups(%rip)
0000000100009224	movq	0xde35(%rip), %rcx
000000010000922b	shlq	$0x10, %rcx
000000010000922f	cmpq	%rcx, %rax
0000000100009232	jae	0x10000937a
0000000100009238	movq	0xde41(%rip), %rcx
000000010000923f	movq	%rax, %rdx
0000000100009242	shrq	$0x10, %rdx
0000000100009246	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000924d	leaq	(%rcx,%rdx), %rdi
0000000100009251	movzbl	(%rcx,%rdx), %ecx
0000000100009255	cmpb	$0x2, %cl
0000000100009258	setne	%dl
000000010000925b	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009261	setne	%sil
0000000100009265	orb	%dl, %sil
0000000100009268	jne	0x10000934d
000000010000926e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009275	jmp	0x100009367
000000010000927a	movl	%r15d, %r15d
000000010000927d	movq	%r14, %rdi
0000000100009280	callq	_fwp_drop2
0000000100009285	movq	%r15, -0x90(%rbp)
000000010000928c	movl	$0x10, %edi
0000000100009291	callq	_fwp_alloc_init
0000000100009296	movq	%rax, %r14
0000000100009299	movabsq	$0x100000001, %rax              ## imm = 0x100000001
00000001000092a3	movq	%rax, (%r14)
00000001000092a6	movq	%r15, 0x8(%r14)
00000001000092aa	leaq	-0x90(%rbp), %rax
00000001000092b1	movq	%r14, %rax
00000001000092b4	subq	0xdd7d(%rip), %rax
00000001000092bb	movq	0xdd9e(%rip), %rcx
00000001000092c2	shlq	$0x10, %rcx
00000001000092c6	cmpq	%rcx, %rax
00000001000092c9	jae	0x1000095f2
00000001000092cf	movq	0xddaa(%rip), %rcx
00000001000092d6	movq	%rax, %rdx
00000001000092d9	shrq	$0x10, %rdx
00000001000092dd	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000092e4	leaq	(%rcx,%rdx), %r15
00000001000092e8	movzbl	(%rcx,%rdx), %ecx
00000001000092ec	cmpb	$0x2, %cl
00000001000092ef	setne	%dl
00000001000092f2	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000092f8	setne	%sil
00000001000092fc	orb	%dl, %sil
00000001000092ff	leaq	-0xd8(%rbp), %r12
0000000100009306	jne	0x10000931e
0000000100009308	addq	$0x228, %r15                    ## imm = 0x228
000000010000930f	cmpb	$-0x1, (%r15)
0000000100009313	je	0x100009343
0000000100009315	movb	$0x1, (%r15)
0000000100009319	jmp	0x1000095f9
000000010000931e	cmpb	$0x1, %cl
0000000100009321	jne	0x1000095f9
0000000100009327	movl	0x20(%r15), %ecx
000000010000932b	imulq	%rcx, %rax
000000010000932f	shrq	$0x20, %rax
0000000100009333	addq	%rax, %r15
0000000100009336	addq	$0x228, %r15                    ## imm = 0x228
000000010000933d	cmpb	$-0x1, (%r15)
0000000100009341	jne	0x100009315
0000000100009343	movq	%r15, %rdi
0000000100009346	callq	_fwp_rc_forget_slot
000000010000934b	jmp	0x100009315
000000010000934d	cmpb	$0x1, %cl
0000000100009350	jne	0x10000937a
0000000100009352	movl	0x20(%rdi), %ecx
0000000100009355	imulq	%rcx, %rax
0000000100009359	shrq	$0x20, %rax
000000010000935d	addq	%rax, %rdi
0000000100009360	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009367	movzbl	(%rdi), %eax
000000010000936a	testb	%al, %al
000000010000936c	je	0x10000937a
000000010000936e	cmpb	$-0x3, %al
0000000100009370	ja	0x10000965f
0000000100009376	incb	%al
0000000100009378	movb	%al, (%rdi)
000000010000937a	movd	%r12d, %xmm1
000000010000937f	mulss	0x9b99(%rip), %xmm1
0000000100009387	addss	0x9b95(%rip), %xmm1
000000010000938f	movd	%r15d, %xmm0
0000000100009394	addss	%xmm0, %xmm1
0000000100009398	movss	%xmm1, -0xbc(%rbp)
00000001000093a0	movq	-0x90(%rbp), %rax
00000001000093a7	movq	%rax, _fwp_cleanups(%rip)
00000001000093ae	movq	%r14, %rdi
00000001000093b1	callq	_fwp_drop2
00000001000093b6	movq	_fwp_cleanups(%rip), %rax
00000001000093bd	movd	-0xbc(%rbp), %xmm0
00000001000093c5	movd	%xmm0, %r12d
00000001000093ca	movq	%r14, -0x108(%rbp)
00000001000093d1	movq	%rax, -0x100(%rbp)
00000001000093d8	leaq	_fwp_owner_release16(%rip), %rax
00000001000093df	movq	%rax, -0xf8(%rbp)
00000001000093e6	leaq	-0x108(%rbp), %rax
00000001000093ed	movq	%rax, -0xf0(%rbp)
00000001000093f4	leaq	-0x100(%rbp), %rax
00000001000093fb	movq	%rax, _fwp_cleanups(%rip)
0000000100009402	movq	%r13, -0xa8(%rbp)
0000000100009409	movq	%r14, -0xa0(%rbp)
0000000100009410	movq	%r12, -0x98(%rbp)
0000000100009417	movl	$0x20, %edi
000000010000941c	callq	_fwp_alloc_init
0000000100009421	movq	%rax, %r15
0000000100009424	movabsq	$0x300000000, %rax              ## imm = 0x300000000
000000010000942e	movq	%rax, (%r15)
0000000100009431	movq	%r13, 0x8(%r15)
0000000100009435	movq	%r14, 0x10(%r15)
0000000100009439	movq	%r12, 0x18(%r15)
000000010000943d	leaq	-0xa8(%rbp), %rax
0000000100009444	movq	%r15, %rax
0000000100009447	subq	0xdbea(%rip), %rax
000000010000944e	movq	0xdc0b(%rip), %rcx
0000000100009455	shlq	$0x10, %rcx
0000000100009459	cmpq	%rcx, %rax
000000010000945c	jae	0x1000094ce
000000010000945e	movq	0xdc1b(%rip), %rcx
0000000100009465	movq	%rax, %rdx
0000000100009468	shrq	$0x10, %rdx
000000010000946c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009473	leaq	(%rcx,%rdx), %r14
0000000100009477	movzbl	(%rcx,%rdx), %ecx
000000010000947b	cmpb	$0x2, %cl
000000010000947e	setne	%dl
0000000100009481	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009487	setne	%sil
000000010000948b	orb	%dl, %sil
000000010000948e	jne	0x1000094a3
0000000100009490	addq	$0x228, %r14                    ## imm = 0x228
0000000100009497	cmpb	$-0x1, (%r14)
000000010000949b	je	0x1000094c4
000000010000949d	movb	$0x1, (%r14)
00000001000094a1	jmp	0x1000094ce
00000001000094a3	cmpb	$0x1, %cl
00000001000094a6	jne	0x1000094ce
00000001000094a8	movl	0x20(%r14), %ecx
00000001000094ac	imulq	%rcx, %rax
00000001000094b0	shrq	$0x20, %rax
00000001000094b4	addq	%rax, %r14
00000001000094b7	addq	$0x228, %r14                    ## imm = 0x228
00000001000094be	cmpb	$-0x1, (%r14)
00000001000094c2	jne	0x10000949d
00000001000094c4	movq	%r14, %rdi
00000001000094c7	callq	_fwp_rc_forget_slot
00000001000094cc	jmp	0x10000949d
00000001000094ce	leaq	-0x100(%rbp), %rax
00000001000094d5	cmpq	%rax, _fwp_cleanups(%rip)
00000001000094dc	jne	0x100009678
00000001000094e2	movq	-0x100(%rbp), %rax
00000001000094e9	movq	%r15, -0xe8(%rbp)
00000001000094f0	movq	%rax, -0x150(%rbp)
00000001000094f7	leaq	_fwp_owner_release17(%rip), %rax
00000001000094fe	movq	%rax, -0x148(%rbp)
0000000100009505	leaq	-0xe8(%rbp), %rax
000000010000950c	movq	%rax, -0x140(%rbp)
0000000100009513	leaq	-0x150(%rbp), %r12
000000010000951a	movq	%r12, _fwp_cleanups(%rip)
0000000100009521	movq	%r15, -0xb0(%rbp)
0000000100009528	movl	$0x10, %edi
000000010000952d	callq	_fwp_alloc_init
0000000100009532	movq	%rax, %r14
0000000100009535	movabsq	$__mh_execute_header, %rax
000000010000953f	movq	%rax, (%r14)
0000000100009542	movq	%r15, 0x8(%r14)
0000000100009546	leaq	-0xb0(%rbp), %rax
000000010000954d	movq	%r14, %rax
0000000100009550	subq	0xdae1(%rip), %rax
0000000100009557	movq	0xdb02(%rip), %rcx
000000010000955e	shlq	$0x10, %rcx
0000000100009562	cmpq	%rcx, %rax
0000000100009565	jae	0x1000095d7
0000000100009567	movq	0xdb12(%rip), %rcx
000000010000956e	movq	%rax, %rdx
0000000100009571	shrq	$0x10, %rdx
0000000100009575	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000957c	leaq	(%rcx,%rdx), %r15
0000000100009580	movzbl	(%rcx,%rdx), %ecx
0000000100009584	cmpb	$0x2, %cl
0000000100009587	setne	%dl
000000010000958a	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009590	setne	%sil
0000000100009594	orb	%dl, %sil
0000000100009597	jne	0x1000095ac
0000000100009599	addq	$0x228, %r15                    ## imm = 0x228
00000001000095a0	cmpb	$-0x1, (%r15)
00000001000095a4	je	0x1000095cd
00000001000095a6	movb	$0x1, (%r15)
00000001000095aa	jmp	0x1000095d7
00000001000095ac	cmpb	$0x1, %cl
00000001000095af	jne	0x1000095d7
00000001000095b1	movl	0x20(%r15), %ecx
00000001000095b5	imulq	%rcx, %rax
00000001000095b9	shrq	$0x20, %rax
00000001000095bd	addq	%rax, %r15
00000001000095c0	addq	$0x228, %r15                    ## imm = 0x228
00000001000095c7	cmpb	$-0x1, (%r15)
00000001000095cb	jne	0x1000095a6
00000001000095cd	movq	%r15, %rdi
00000001000095d0	callq	_fwp_rc_forget_slot
00000001000095d5	jmp	0x1000095a6
00000001000095d7	cmpq	%r12, _fwp_cleanups(%rip)
00000001000095de	jne	0x100009678
00000001000095e4	movq	-0x150(%rbp), %rax
00000001000095eb	movq	%rax, _fwp_cleanups(%rip)
00000001000095f2	leaq	-0xd8(%rbp), %r12
00000001000095f9	cmpq	%r12, _fwp_cleanups(%rip)
0000000100009600	jne	0x100009678
0000000100009602	movq	-0xd8(%rbp), %rax
0000000100009609	movq	%rax, _fwp_cleanups(%rip)
0000000100009610	movq	%rbx, %rdi
0000000100009613	callq	_fwp_drop3
0000000100009618	movq	0xba11(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000961f	movq	(%rax), %rax
0000000100009622	cmpq	-0x30(%rbp), %rax
0000000100009626	jne	0x10000967d
0000000100009628	movq	%r14, %rax
000000010000962b	addq	$0x158, %rsp                    ## imm = 0x158
0000000100009632	popq	%rbx
0000000100009633	popq	%r12
0000000100009635	popq	%r13
0000000100009637	popq	%r14
0000000100009639	popq	%r15
000000010000963b	popq	%rbp
000000010000963c	retq
000000010000963d	callq	_fwp_rc_wide_dup
0000000100009642	movq	_fwp_cleanups(%rip), %rax
0000000100009649	movq	0x10(%rbx), %r14
000000010000964d	movq	%r14, -0xb8(%rbp)
0000000100009654	cmpq	%r15, %rax
0000000100009657	je	0x1000090a7
000000010000965d	jmp	0x100009678
000000010000965f	callq	_fwp_rc_wide_dup
0000000100009664	leaq	-0x90(%rbp), %rax
000000010000966b	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009672	je	0x10000937a
0000000100009678	callq	0x100012c2a                     ## symbol stub for: _abort
000000010000967d	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100009682	leaq	0x9d9d(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100009689	leaq	0x9d92(%rip), %rcx              ## literal pool for: "I64"
0000000100009690	leaq	-0x90(%rbp), %rbx
0000000100009697	movl	$0x60, %esi
000000010000969c	movq	%rbx, %rdi
000000010000969f	xorl	%eax, %eax
00000001000096a1	callq	0x100012d0e                     ## symbol stub for: _snprintf
00000001000096a6	callq	_fwp_flush
00000001000096ab	movq	0xb986(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000096b2	movq	(%rax), %rdi
00000001000096b5	leaq	0x9d53(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000096bc	movq	%rbx, %rdx
00000001000096bf	xorl	%eax, %eax
00000001000096c1	callq	0x100012c5a                     ## symbol stub for: _fprintf
00000001000096c6	movl	$0x65, %edi
00000001000096cb	callq	0x100012c48                     ## symbol stub for: _exit
_fwp_owner_release18:
00000001000096d0	pushq	%rbp
00000001000096d1	movq	%rsp, %rbp
00000001000096d4	movq	(%rdi), %rdi
00000001000096d7	popq	%rbp
00000001000096d8	jmp	_fwp_drop3
00000001000096dd	nopl	(%rax)
_fwp_owner_release19:
00000001000096e0	pushq	%rbp
00000001000096e1	movq	%rsp, %rbp
00000001000096e4	movq	(%rdi), %rdi
00000001000096e7	popq	%rbp
00000001000096e8	jmp	_fwp_drop2
00000001000096ed	nopl	(%rax)
_fwp_drop3:
00000001000096f0	movq	%rdi, %rcx
00000001000096f3	subq	0xd93e(%rip), %rcx
00000001000096fa	movq	0xd95f(%rip), %rax
0000000100009701	shlq	$0x10, %rax
0000000100009705	cmpq	%rax, %rcx
0000000100009708	jae	0x10000979e
000000010000970e	movq	0xd96b(%rip), %rdx
0000000100009715	movq	%rcx, %rax
0000000100009718	shrq	$0x10, %rax
000000010000971c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009723	leaq	(%rdx,%rsi), %rax
0000000100009727	movzbl	(%rdx,%rsi), %edx
000000010000972b	cmpb	$0x2, %dl
000000010000972e	setne	%sil
0000000100009732	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009739	setne	%r8b
000000010000973d	orb	%sil, %r8b
0000000100009740	jne	0x10000974a
0000000100009742	addq	$0x228, %rax                    ## imm = 0x228
0000000100009748	jmp	0x100009763
000000010000974a	cmpb	$0x1, %dl
000000010000974d	jne	0x10000979e
000000010000974f	movl	0x20(%rax), %edx
0000000100009752	imulq	%rdx, %rcx
0000000100009756	shrq	$0x20, %rcx
000000010000975a	addq	%rcx, %rax
000000010000975d	addq	$0x228, %rax                    ## imm = 0x228
0000000100009763	movzbl	(%rax), %ecx
0000000100009766	testl	%ecx, %ecx
0000000100009768	je	0x10000979e
000000010000976a	cmpl	$0x1, %ecx
000000010000976d	jne	0x100009792
000000010000976f	pushq	%rbp
0000000100009770	movq	%rsp, %rbp
0000000100009773	pushq	%rbx
0000000100009774	pushq	%rax
0000000100009775	movq	0x10(%rdi), %rax
0000000100009779	movq	%rdi, %rbx
000000010000977c	movq	%rax, %rdi
000000010000977f	callq	_fwp_drop2
0000000100009784	movq	%rbx, %rdi
0000000100009787	addq	$0x8, %rsp
000000010000978b	popq	%rbx
000000010000978c	popq	%rbp
000000010000978d	jmp	_fwp_rc_free_obj
0000000100009792	cmpl	$0xff, %ecx
0000000100009798	je	0x10000979f
000000010000979a	decb	%cl
000000010000979c	movb	%cl, (%rax)
000000010000979e	retq
000000010000979f	movq	%rax, %rdi
00000001000097a2	jmp	_fwp_rc_wide_drop
00000001000097a7	nopw	(%rax,%rax)
_fwp_owner_release10:
00000001000097b0	pushq	%rbp
00000001000097b1	movq	%rsp, %rbp
00000001000097b4	movq	(%rdi), %rdi
00000001000097b7	popq	%rbp
00000001000097b8	jmp	_fwp_drop2
00000001000097bd	nopl	(%rax)
_fwp_owner_release11:
00000001000097c0	pushq	%rbp
00000001000097c1	movq	%rsp, %rbp
00000001000097c4	movq	(%rdi), %rdi
00000001000097c7	popq	%rbp
00000001000097c8	jmp	_fwp_drop2
00000001000097cd	nopl	(%rax)
_fwp_owner_release14:
00000001000097d0	pushq	%rbp
00000001000097d1	movq	%rsp, %rbp
00000001000097d4	movq	(%rdi), %rdi
00000001000097d7	popq	%rbp
00000001000097d8	jmp	_fwp_drop2
00000001000097dd	nopl	(%rax)
_fwp_owner_release16:
00000001000097e0	pushq	%rbp
00000001000097e1	movq	%rsp, %rbp
00000001000097e4	movq	(%rdi), %rdi
00000001000097e7	popq	%rbp
00000001000097e8	jmp	_fwp_drop2
00000001000097ed	nopl	(%rax)
_fwp_owner_release17:
00000001000097f0	pushq	%rbp
00000001000097f1	movq	%rsp, %rbp
00000001000097f4	movq	(%rdi), %rax
00000001000097f7	subq	0xd83a(%rip), %rax
00000001000097fe	movq	0xd85b(%rip), %rcx
0000000100009805	shlq	$0x10, %rcx
0000000100009809	cmpq	%rcx, %rax
000000010000980c	jae	0x100009872
000000010000980e	movq	0xd86b(%rip), %rcx
0000000100009815	movq	%rax, %rdx
0000000100009818	shrq	$0x10, %rdx
000000010000981c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009823	leaq	(%rcx,%rdx), %rdi
0000000100009827	movzbl	(%rcx,%rdx), %ecx
000000010000982b	cmpb	$0x2, %cl
000000010000982e	setne	%dl
0000000100009831	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009837	setne	%sil
000000010000983b	orb	%dl, %sil
000000010000983e	jne	0x100009849
0000000100009840	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009847	jmp	0x100009863
0000000100009849	cmpb	$0x1, %cl
000000010000984c	jne	0x100009872
000000010000984e	movl	0x20(%rdi), %ecx
0000000100009851	imulq	%rcx, %rax
0000000100009855	shrq	$0x20, %rax
0000000100009859	addq	%rax, %rdi
000000010000985c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009863	movzbl	(%rdi), %eax
0000000100009866	cmpb	$0x2, %al
0000000100009868	jb	0x100009872
000000010000986a	cmpb	$-0x1, %al
000000010000986c	je	0x100009874
000000010000986e	decb	%al
0000000100009870	movb	%al, (%rdi)
0000000100009872	popq	%rbp
0000000100009873	retq
0000000100009874	popq	%rbp
0000000100009875	jmp	_fwp_rc_wide_drop
000000010000987a	nopw	(%rax,%rax)
_fwp_owned_entry32:
0000000100009880	pushq	%rbp
0000000100009881	movq	%rsp, %rbp
0000000100009884	movq	(%rdi), %rdi
0000000100009887	popq	%rbp
0000000100009888	jmp	_f32
000000010000988d	nopl	(%rax)
_fwp_caps32:
0000000100009890	movl	0x4(%rdi), %eax
0000000100009893	testl	%esi, %esi
0000000100009895	je	0x1000098f9
0000000100009897	testl	%eax, %eax
0000000100009899	je	0x100009951
000000010000989f	movq	0x8(%rdi), %rax
00000001000098a3	subq	0xd78e(%rip), %rax
00000001000098aa	movq	0xd7af(%rip), %rcx
00000001000098b1	shlq	$0x10, %rcx
00000001000098b5	cmpq	%rcx, %rax
00000001000098b8	jae	0x100009951
00000001000098be	movq	0xd7bb(%rip), %rcx
00000001000098c5	movq	%rax, %rdx
00000001000098c8	shrq	$0x10, %rdx
00000001000098cc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000098d3	leaq	(%rcx,%rdx), %rdi
00000001000098d7	movzbl	(%rcx,%rdx), %ecx
00000001000098db	cmpb	$0x2, %cl
00000001000098de	setne	%dl
00000001000098e1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000098e7	setne	%sil
00000001000098eb	orb	%dl, %sil
00000001000098ee	jne	0x100009924
00000001000098f0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000098f7	jmp	0x10000993e
00000001000098f9	testl	%eax, %eax
00000001000098fb	je	_fwp_rc_free_obj
0000000100009901	pushq	%rbp
0000000100009902	movq	%rsp, %rbp
0000000100009905	pushq	%rbx
0000000100009906	pushq	%rax
0000000100009907	movq	0x8(%rdi), %rax
000000010000990b	movq	%rdi, %rbx
000000010000990e	movq	%rax, %rdi
0000000100009911	callq	_fwp_drop3
0000000100009916	movq	%rbx, %rdi
0000000100009919	addq	$0x8, %rsp
000000010000991d	popq	%rbx
000000010000991e	popq	%rbp
000000010000991f	jmp	_fwp_rc_free_obj
0000000100009924	cmpb	$0x1, %cl
0000000100009927	jne	0x100009951
0000000100009929	movl	0x20(%rdi), %ecx
000000010000992c	imulq	%rcx, %rax
0000000100009930	shrq	$0x20, %rax
0000000100009934	addq	%rax, %rdi
0000000100009937	addq	$0x228, %rdi                    ## imm = 0x228
000000010000993e	movzbl	(%rdi), %eax
0000000100009941	testb	%al, %al
0000000100009943	je	0x100009951
0000000100009945	cmpb	$-0x2, %al
0000000100009947	jae	_fwp_rc_wide_dup
000000010000994d	incb	%al
000000010000994f	movb	%al, (%rdi)
0000000100009951	retq
0000000100009952	nopw	%cs:(%rax,%rax)
_fwp_args32:
0000000100009960	pushq	%rbp
0000000100009961	movq	%rsp, %rbp
0000000100009964	testl	%esi, %esi
0000000100009966	setne	%al
0000000100009969	testl	%edx, %edx
000000010000996b	sete	%cl
000000010000996e	orb	%al, %cl
0000000100009970	jne	0x1000099f0
0000000100009972	movq	(%rdi), %rax
0000000100009975	subq	0xd6bc(%rip), %rax
000000010000997c	movq	0xd6dd(%rip), %rcx
0000000100009983	shlq	$0x10, %rcx
0000000100009987	cmpq	%rcx, %rax
000000010000998a	jae	0x1000099f0
000000010000998c	movq	0xd6ed(%rip), %rcx
0000000100009993	movq	%rax, %rdx
0000000100009996	shrq	$0x10, %rdx
000000010000999a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000099a1	leaq	(%rcx,%rdx), %rdi
00000001000099a5	movzbl	(%rcx,%rdx), %ecx
00000001000099a9	cmpb	$0x2, %cl
00000001000099ac	setne	%dl
00000001000099af	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000099b5	setne	%sil
00000001000099b9	orb	%dl, %sil
00000001000099bc	jne	0x1000099c7
00000001000099be	addq	$0x228, %rdi                    ## imm = 0x228
00000001000099c5	jmp	0x1000099e1
00000001000099c7	cmpb	$0x1, %cl
00000001000099ca	jne	0x1000099f0
00000001000099cc	movl	0x20(%rdi), %ecx
00000001000099cf	imulq	%rcx, %rax
00000001000099d3	shrq	$0x20, %rax
00000001000099d7	addq	%rax, %rdi
00000001000099da	addq	$0x228, %rdi                    ## imm = 0x228
00000001000099e1	movzbl	(%rdi), %eax
00000001000099e4	testb	%al, %al
00000001000099e6	je	0x1000099f0
00000001000099e8	cmpb	$-0x2, %al
00000001000099ea	jae	0x1000099f2
00000001000099ec	incb	%al
00000001000099ee	movb	%al, (%rdi)
00000001000099f0	popq	%rbp
00000001000099f1	retq
00000001000099f2	popq	%rbp
00000001000099f3	jmp	_fwp_rc_wide_dup
00000001000099f8	nopl	(%rax,%rax)
_fwp_arg_drop32:
0000000100009a00	pushq	%rbp
0000000100009a01	movq	%rsp, %rbp
0000000100009a04	testl	%esi, %esi
0000000100009a06	setne	%al
0000000100009a09	testl	%edx, %edx
0000000100009a0b	sete	%cl
0000000100009a0e	orb	%al, %cl
0000000100009a10	je	0x100009a14
0000000100009a12	popq	%rbp
0000000100009a13	retq
0000000100009a14	movq	(%rdi), %rdi
0000000100009a17	popq	%rbp
0000000100009a18	jmp	_fwp_drop3
0000000100009a1d	nopl	(%rax)
_f35:
0000000100009a20	pushq	%rbp
0000000100009a21	movq	%rsp, %rbp
0000000100009a24	pushq	%r15
0000000100009a26	pushq	%r14
0000000100009a28	pushq	%r13
0000000100009a2a	pushq	%r12
0000000100009a2c	pushq	%rbx
0000000100009a2d	subq	$0x198, %rsp                    ## imm = 0x198
0000000100009a34	movq	%rdi, %rbx
0000000100009a37	movq	0xb5f2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100009a3e	movq	(%rax), %rax
0000000100009a41	movq	%rax, -0x30(%rbp)
0000000100009a45	movq	%rdi, -0xd8(%rbp)
0000000100009a4c	movq	_fwp_cleanups(%rip), %rax
0000000100009a53	movq	%rax, -0xd0(%rbp)
0000000100009a5a	leaq	_fwp_owner_release27(%rip), %rax
0000000100009a61	movq	%rax, -0xc8(%rbp)
0000000100009a68	leaq	-0xd8(%rbp), %rax
0000000100009a6f	movq	%rax, -0xc0(%rbp)
0000000100009a76	movq	$0x0, -0xb8(%rbp)
0000000100009a81	leaq	-0xd0(%rbp), %rax
0000000100009a88	movq	%rax, -0x120(%rbp)
0000000100009a8f	leaq	_fwp_owner_release28(%rip), %rax
0000000100009a96	movq	%rax, -0x118(%rbp)
0000000100009a9d	leaq	-0xb8(%rbp), %rax
0000000100009aa4	movq	%rax, -0x110(%rbp)
0000000100009aab	leaq	-0x120(%rbp), %r15
0000000100009ab2	movq	%r15, _fwp_cleanups(%rip)
0000000100009ab9	movq	0x10(%rdi), %rax
0000000100009abd	subq	0xd574(%rip), %rax
0000000100009ac4	movq	0xd595(%rip), %rcx
0000000100009acb	shlq	$0x10, %rcx
0000000100009acf	cmpq	%rcx, %rax
0000000100009ad2	jae	0x100009b3c
0000000100009ad4	movq	0xd5a5(%rip), %rcx
0000000100009adb	movq	%rax, %rdx
0000000100009ade	shrq	$0x10, %rdx
0000000100009ae2	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009ae9	leaq	(%rcx,%rdx), %rdi
0000000100009aed	movzbl	(%rcx,%rdx), %ecx
0000000100009af1	cmpb	$0x2, %cl
0000000100009af4	setne	%dl
0000000100009af7	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009afd	setne	%sil
0000000100009b01	orb	%dl, %sil
0000000100009b04	jne	0x100009b0f
0000000100009b06	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009b0d	jmp	0x100009b29
0000000100009b0f	cmpb	$0x1, %cl
0000000100009b12	jne	0x100009b3c
0000000100009b14	movl	0x20(%rdi), %ecx
0000000100009b17	imulq	%rcx, %rax
0000000100009b1b	shrq	$0x20, %rax
0000000100009b1f	addq	%rax, %rdi
0000000100009b22	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009b29	movzbl	(%rdi), %eax
0000000100009b2c	testb	%al, %al
0000000100009b2e	je	0x100009b3c
0000000100009b30	cmpb	$-0x3, %al
0000000100009b32	ja	0x10000a138
0000000100009b38	incb	%al
0000000100009b3a	movb	%al, (%rdi)
0000000100009b3c	movq	0x10(%rbx), %r14
0000000100009b40	movq	%r14, -0xb8(%rbp)
0000000100009b47	movq	-0x120(%rbp), %rax
0000000100009b4e	movq	0x8(%rbx), %r12
0000000100009b52	movq	0x18(%rbx), %r13
0000000100009b56	movq	%r14, -0x108(%rbp)
0000000100009b5d	movq	%rax, -0x168(%rbp)
0000000100009b64	leaq	_fwp_owner_release20(%rip), %rax
0000000100009b6b	movq	%rax, -0x160(%rbp)
0000000100009b72	leaq	-0x108(%rbp), %rax
0000000100009b79	movq	%rax, -0x158(%rbp)
0000000100009b80	leaq	-0x168(%rbp), %rax
0000000100009b87	movq	%rax, _fwp_cleanups(%rip)
0000000100009b8e	testq	%r12, %r12
0000000100009b91	js	0x100009bcf
0000000100009b93	movq	(%r14), %rsi
0000000100009b96	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100009ba0	andq	%rsi, %rcx
0000000100009ba3	cmpq	%r12, %rcx
0000000100009ba6	jbe	0x100009bcf
0000000100009ba8	movl	_d2(%rip), %ecx
0000000100009bae	movl	$0x8, %edx
0000000100009bb3	cmpq	$0xa, %rcx
0000000100009bb7	ja	0x100009bc4
0000000100009bb9	leaq	0x9598(%rip), %rdx
0000000100009bc0	movq	(%rdx,%rcx,8), %rdx
0000000100009bc4	testq	%rsi, %rsi
0000000100009bc7	js	0x100009bd5
0000000100009bc9	leaq	0x8(%r14), %rsi
0000000100009bcd	jmp	0x100009bd9
0000000100009bcf	xorl	%edx, %edx
0000000100009bd1	xorl	%ecx, %ecx
0000000100009bd3	jmp	0x100009c21
0000000100009bd5	movq	0x10(%r14), %rsi
0000000100009bd9	movq	%rdx, %rdi
0000000100009bdc	imulq	%r12, %rdi
0000000100009be0	cmpq	$0x1, %rdx
0000000100009be4	je	0x100009c05
0000000100009be6	cmpq	$0x2, %rdx
0000000100009bea	je	0x100009bf8
0000000100009bec	cmpq	$0x8, %rdx
0000000100009bf0	jne	0x100009c12
0000000100009bf2	movq	(%rsi,%rdi), %rcx
0000000100009bf6	jmp	0x100009c1f
0000000100009bf8	movzwl	(%rsi,%rdi), %edx
0000000100009bfc	cmpl	$0x1, %ecx
0000000100009bff	movswq	%dx, %rcx
0000000100009c03	jmp	0x100009c1b
0000000100009c05	movzbl	(%rsi,%rdi), %edx
0000000100009c09	testq	%rcx, %rcx
0000000100009c0c	movsbq	%dl, %rcx
0000000100009c10	jmp	0x100009c1b
0000000100009c12	movl	(%rsi,%rdi), %edx
0000000100009c15	cmpl	$0x2, %ecx
0000000100009c18	movslq	%edx, %rcx
0000000100009c1b	cmovneq	%rdx, %rcx
0000000100009c1f	movb	$0x1, %dl
0000000100009c21	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009c28	jne	0x10000a16c
0000000100009c2e	movq	-0x168(%rbp), %rax
0000000100009c35	movq	%rax, _fwp_cleanups(%rip)
0000000100009c3c	testb	%dl, %dl
0000000100009c3e	je	0x100009d66
0000000100009c44	movq	%r14, -0x100(%rbp)
0000000100009c4b	movq	%rax, -0x1c0(%rbp)
0000000100009c52	leaq	_fwp_owner_release21(%rip), %rdx
0000000100009c59	movq	%rdx, -0x1b8(%rbp)
0000000100009c60	leaq	-0x100(%rbp), %rdx
0000000100009c67	movq	%rdx, -0x1b0(%rbp)
0000000100009c6e	leaq	-0x1c0(%rbp), %rdx
0000000100009c75	movq	%rdx, _fwp_cleanups(%rip)
0000000100009c7c	incq	%r12
0000000100009c7f	jo	0x10000a171
0000000100009c85	movq	%r14, -0xf8(%rbp)
0000000100009c8c	movq	%rax, -0x1a8(%rbp)
0000000100009c93	leaq	_fwp_owner_release22(%rip), %rdx
0000000100009c9a	movq	%rdx, -0x1a0(%rbp)
0000000100009ca1	leaq	-0xf8(%rbp), %rdx
0000000100009ca8	movq	%rdx, -0x198(%rbp)
0000000100009caf	leaq	-0x1a8(%rbp), %rdx
0000000100009cb6	movq	%rdx, _fwp_cleanups(%rip)
0000000100009cbd	addq	$-0x7f, %rcx
0000000100009cc1	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100009cc8	jbe	0x10000a186
0000000100009cce	movq	%r14, -0xf0(%rbp)
0000000100009cd5	movq	%rax, -0x150(%rbp)
0000000100009cdc	leaq	_fwp_owner_release23(%rip), %rax
0000000100009ce3	movq	%rax, -0x148(%rbp)
0000000100009cea	leaq	-0xf0(%rbp), %rax
0000000100009cf1	movq	%rax, -0x140(%rbp)
0000000100009cf8	leaq	-0x150(%rbp), %r15
0000000100009cff	movq	%r14, %rax
0000000100009d02	subq	0xd32f(%rip), %rax
0000000100009d09	movq	%r15, _fwp_cleanups(%rip)
0000000100009d10	movq	0xd349(%rip), %rcx
0000000100009d17	shlq	$0x10, %rcx
0000000100009d1b	cmpq	%rcx, %rax
0000000100009d1e	jae	0x100009e63
0000000100009d24	movq	0xd355(%rip), %rcx
0000000100009d2b	movq	%rax, %rdx
0000000100009d2e	shrq	$0x10, %rdx
0000000100009d32	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009d39	leaq	(%rcx,%rdx), %rdi
0000000100009d3d	movzbl	(%rcx,%rdx), %ecx
0000000100009d41	cmpb	$0x2, %cl
0000000100009d44	setne	%dl
0000000100009d47	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009d4d	setne	%sil
0000000100009d51	orb	%dl, %sil
0000000100009d54	jne	0x100009e36
0000000100009d5a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009d61	jmp	0x100009e50
0000000100009d66	movq	%r14, %rdi
0000000100009d69	callq	_fwp_drop2
0000000100009d6e	movq	%r13, -0x90(%rbp)
0000000100009d75	movl	$0x10, %edi
0000000100009d7a	callq	_fwp_alloc_init
0000000100009d7f	movq	%rax, %r14
0000000100009d82	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100009d8c	movq	%rax, (%r14)
0000000100009d8f	movq	%r13, 0x8(%r14)
0000000100009d93	leaq	-0x90(%rbp), %rax
0000000100009d9a	movq	%r14, %rax
0000000100009d9d	subq	0xd294(%rip), %rax
0000000100009da4	movq	0xd2b5(%rip), %rcx
0000000100009dab	shlq	$0x10, %rcx
0000000100009daf	cmpq	%rcx, %rax
0000000100009db2	jae	0x10000a0ed
0000000100009db8	movq	0xd2c1(%rip), %rcx
0000000100009dbf	movq	%rax, %rdx
0000000100009dc2	shrq	$0x10, %rdx
0000000100009dc6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009dcd	leaq	(%rcx,%rdx), %r15
0000000100009dd1	movzbl	(%rcx,%rdx), %ecx
0000000100009dd5	cmpb	$0x2, %cl
0000000100009dd8	setne	%dl
0000000100009ddb	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009de1	setne	%sil
0000000100009de5	orb	%dl, %sil
0000000100009de8	leaq	-0xd0(%rbp), %r12
0000000100009def	jne	0x100009e07
0000000100009df1	addq	$0x228, %r15                    ## imm = 0x228
0000000100009df8	cmpb	$-0x1, (%r15)
0000000100009dfc	je	0x100009e2c
0000000100009dfe	movb	$0x1, (%r15)
0000000100009e02	jmp	0x10000a0f4
0000000100009e07	cmpb	$0x1, %cl
0000000100009e0a	jne	0x10000a0f4
0000000100009e10	movl	0x20(%r15), %ecx
0000000100009e14	imulq	%rcx, %rax
0000000100009e18	shrq	$0x20, %rax
0000000100009e1c	addq	%rax, %r15
0000000100009e1f	addq	$0x228, %r15                    ## imm = 0x228
0000000100009e26	cmpb	$-0x1, (%r15)
0000000100009e2a	jne	0x100009dfe
0000000100009e2c	movq	%r15, %rdi
0000000100009e2f	callq	_fwp_rc_forget_slot
0000000100009e34	jmp	0x100009dfe
0000000100009e36	cmpb	$0x1, %cl
0000000100009e39	jne	0x100009e63
0000000100009e3b	movl	0x20(%rdi), %ecx
0000000100009e3e	imulq	%rcx, %rax
0000000100009e42	shrq	$0x20, %rax
0000000100009e46	addq	%rax, %rdi
0000000100009e49	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009e50	movzbl	(%rdi), %eax
0000000100009e53	testb	%al, %al
0000000100009e55	je	0x100009e63
0000000100009e57	cmpb	$-0x3, %al
0000000100009e59	ja	0x10000a15a
0000000100009e5f	incb	%al
0000000100009e61	movb	%al, (%rdi)
0000000100009e63	movq	-0x150(%rbp), %rax
0000000100009e6a	movq	%r14, -0x178(%rbp)
0000000100009e71	movq	%r14, -0x170(%rbp)
0000000100009e78	movq	%rax, -0x190(%rbp)
0000000100009e7f	leaq	_fwp_owner_release24(%rip), %rcx
0000000100009e86	movq	%rcx, -0x188(%rbp)
0000000100009e8d	leaq	-0x178(%rbp), %rcx
0000000100009e94	movq	%rcx, -0x180(%rbp)
0000000100009e9b	leaq	-0x190(%rbp), %rcx
0000000100009ea2	movq	%rcx, _fwp_cleanups(%rip)
0000000100009ea9	incq	%r13
0000000100009eac	jo	0x10000a171
0000000100009eb2	movq	%rax, _fwp_cleanups(%rip)
0000000100009eb9	movq	%r14, %rdi
0000000100009ebc	callq	_fwp_drop2
0000000100009ec1	movq	%r14, -0xe8(%rbp)
0000000100009ec8	movq	_fwp_cleanups(%rip), %rax
0000000100009ecf	movq	%rax, -0x90(%rbp)
0000000100009ed6	leaq	_fwp_owner_release25(%rip), %rax
0000000100009edd	movq	%rax, -0x88(%rbp)
0000000100009ee4	leaq	-0xe8(%rbp), %rax
0000000100009eeb	movq	%rax, -0x80(%rbp)
0000000100009eef	leaq	-0x90(%rbp), %rax
0000000100009ef6	movq	%rax, _fwp_cleanups(%rip)
0000000100009efd	movq	%r12, -0xa8(%rbp)
0000000100009f04	movq	%r14, -0xa0(%rbp)
0000000100009f0b	movq	%r13, -0x98(%rbp)
0000000100009f12	movl	$0x20, %edi
0000000100009f17	callq	_fwp_alloc_init
0000000100009f1c	movq	%rax, %r15
0000000100009f1f	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100009f29	movq	%rax, (%r15)
0000000100009f2c	movq	%r12, 0x8(%r15)
0000000100009f30	movq	%r14, 0x10(%r15)
0000000100009f34	movq	%r13, 0x18(%r15)
0000000100009f38	leaq	-0xa8(%rbp), %rax
0000000100009f3f	movq	%r15, %rax
0000000100009f42	subq	0xd0ef(%rip), %rax
0000000100009f49	movq	0xd110(%rip), %rcx
0000000100009f50	shlq	$0x10, %rcx
0000000100009f54	cmpq	%rcx, %rax
0000000100009f57	jae	0x100009fc9
0000000100009f59	movq	0xd120(%rip), %rcx
0000000100009f60	movq	%rax, %rdx
0000000100009f63	shrq	$0x10, %rdx
0000000100009f67	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009f6e	leaq	(%rcx,%rdx), %r14
0000000100009f72	movzbl	(%rcx,%rdx), %ecx
0000000100009f76	cmpb	$0x2, %cl
0000000100009f79	setne	%dl
0000000100009f7c	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009f82	setne	%sil
0000000100009f86	orb	%dl, %sil
0000000100009f89	jne	0x100009f9e
0000000100009f8b	addq	$0x228, %r14                    ## imm = 0x228
0000000100009f92	cmpb	$-0x1, (%r14)
0000000100009f96	je	0x100009fbf
0000000100009f98	movb	$0x1, (%r14)
0000000100009f9c	jmp	0x100009fc9
0000000100009f9e	cmpb	$0x1, %cl
0000000100009fa1	jne	0x100009fc9
0000000100009fa3	movl	0x20(%r14), %ecx
0000000100009fa7	imulq	%rcx, %rax
0000000100009fab	shrq	$0x20, %rax
0000000100009faf	addq	%rax, %r14
0000000100009fb2	addq	$0x228, %r14                    ## imm = 0x228
0000000100009fb9	cmpb	$-0x1, (%r14)
0000000100009fbd	jne	0x100009f98
0000000100009fbf	movq	%r14, %rdi
0000000100009fc2	callq	_fwp_rc_forget_slot
0000000100009fc7	jmp	0x100009f98
0000000100009fc9	leaq	-0x90(%rbp), %rax
0000000100009fd0	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009fd7	jne	0x10000a16c
0000000100009fdd	movq	-0x90(%rbp), %rax
0000000100009fe4	movq	%r15, -0xe0(%rbp)
0000000100009feb	movq	%rax, -0x138(%rbp)
0000000100009ff2	leaq	_fwp_owner_release26(%rip), %rax
0000000100009ff9	movq	%rax, -0x130(%rbp)
000000010000a000	leaq	-0xe0(%rbp), %rax
000000010000a007	movq	%rax, -0x128(%rbp)
000000010000a00e	leaq	-0x138(%rbp), %r12
000000010000a015	movq	%r12, _fwp_cleanups(%rip)
000000010000a01c	movq	%r15, -0xb0(%rbp)
000000010000a023	movl	$0x10, %edi
000000010000a028	callq	_fwp_alloc_init
000000010000a02d	movq	%rax, %r14
000000010000a030	movabsq	$__mh_execute_header, %rax
000000010000a03a	movq	%rax, (%r14)
000000010000a03d	movq	%r15, 0x8(%r14)
000000010000a041	leaq	-0xb0(%rbp), %rax
000000010000a048	movq	%r14, %rax
000000010000a04b	subq	0xcfe6(%rip), %rax
000000010000a052	movq	0xd007(%rip), %rcx
000000010000a059	shlq	$0x10, %rcx
000000010000a05d	cmpq	%rcx, %rax
000000010000a060	jae	0x10000a0d2
000000010000a062	movq	0xd017(%rip), %rcx
000000010000a069	movq	%rax, %rdx
000000010000a06c	shrq	$0x10, %rdx
000000010000a070	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a077	leaq	(%rcx,%rdx), %r15
000000010000a07b	movzbl	(%rcx,%rdx), %ecx
000000010000a07f	cmpb	$0x2, %cl
000000010000a082	setne	%dl
000000010000a085	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a08b	setne	%sil
000000010000a08f	orb	%dl, %sil
000000010000a092	jne	0x10000a0a7
000000010000a094	addq	$0x228, %r15                    ## imm = 0x228
000000010000a09b	cmpb	$-0x1, (%r15)
000000010000a09f	je	0x10000a0c8
000000010000a0a1	movb	$0x1, (%r15)
000000010000a0a5	jmp	0x10000a0d2
000000010000a0a7	cmpb	$0x1, %cl
000000010000a0aa	jne	0x10000a0d2
000000010000a0ac	movl	0x20(%r15), %ecx
000000010000a0b0	imulq	%rcx, %rax
000000010000a0b4	shrq	$0x20, %rax
000000010000a0b8	addq	%rax, %r15
000000010000a0bb	addq	$0x228, %r15                    ## imm = 0x228
000000010000a0c2	cmpb	$-0x1, (%r15)
000000010000a0c6	jne	0x10000a0a1
000000010000a0c8	movq	%r15, %rdi
000000010000a0cb	callq	_fwp_rc_forget_slot
000000010000a0d0	jmp	0x10000a0a1
000000010000a0d2	cmpq	%r12, _fwp_cleanups(%rip)
000000010000a0d9	jne	0x10000a16c
000000010000a0df	movq	-0x138(%rbp), %rax
000000010000a0e6	movq	%rax, _fwp_cleanups(%rip)
000000010000a0ed	leaq	-0xd0(%rbp), %r12
000000010000a0f4	cmpq	%r12, _fwp_cleanups(%rip)
000000010000a0fb	jne	0x10000a16c
000000010000a0fd	movq	-0xd0(%rbp), %rax
000000010000a104	movq	%rax, _fwp_cleanups(%rip)
000000010000a10b	movq	%rbx, %rdi
000000010000a10e	callq	_fwp_drop5
000000010000a113	movq	0xaf16(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000a11a	movq	(%rax), %rax
000000010000a11d	cmpq	-0x30(%rbp), %rax
000000010000a121	jne	0x10000a181
000000010000a123	movq	%r14, %rax
000000010000a126	addq	$0x198, %rsp                    ## imm = 0x198
000000010000a12d	popq	%rbx
000000010000a12e	popq	%r12
000000010000a130	popq	%r13
000000010000a132	popq	%r14
000000010000a134	popq	%r15
000000010000a136	popq	%rbp
000000010000a137	retq
000000010000a138	callq	_fwp_rc_wide_dup
000000010000a13d	movq	_fwp_cleanups(%rip), %rax
000000010000a144	movq	0x10(%rbx), %r14
000000010000a148	movq	%r14, -0xb8(%rbp)
000000010000a14f	cmpq	%r15, %rax
000000010000a152	je	0x100009b47
000000010000a158	jmp	0x10000a16c
000000010000a15a	callq	_fwp_rc_wide_dup
000000010000a15f	cmpq	%r15, _fwp_cleanups(%rip)
000000010000a166	je	0x100009e63
000000010000a16c	callq	0x100012c2a                     ## symbol stub for: _abort
000000010000a171	leaq	0x92ae(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000a178	leaq	0x92a3(%rip), %rcx              ## literal pool for: "I64"
000000010000a17f	jmp	0x10000a194
000000010000a181	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000a186	leaq	0x9299(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000a18d	leaq	0x9311(%rip), %rcx              ## literal pool for: "I8"
000000010000a194	leaq	-0x90(%rbp), %rbx
000000010000a19b	movl	$0x60, %esi
000000010000a1a0	movq	%rbx, %rdi
000000010000a1a3	xorl	%eax, %eax
000000010000a1a5	callq	0x100012d0e                     ## symbol stub for: _snprintf
000000010000a1aa	callq	_fwp_flush
000000010000a1af	movq	0xae82(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000a1b6	movq	(%rax), %rdi
000000010000a1b9	leaq	0x924f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000a1c0	movq	%rbx, %rdx
000000010000a1c3	xorl	%eax, %eax
000000010000a1c5	callq	0x100012c5a                     ## symbol stub for: _fprintf
000000010000a1ca	movl	$0x65, %edi
000000010000a1cf	callq	0x100012c48                     ## symbol stub for: _exit
000000010000a1d4	nopw	%cs:(%rax,%rax)
_fwp_owner_release27:
000000010000a1e0	pushq	%rbp
000000010000a1e1	movq	%rsp, %rbp
000000010000a1e4	movq	(%rdi), %rdi
000000010000a1e7	popq	%rbp
000000010000a1e8	jmp	_fwp_drop5
000000010000a1ed	nopl	(%rax)
_fwp_owner_release28:
000000010000a1f0	pushq	%rbp
000000010000a1f1	movq	%rsp, %rbp
000000010000a1f4	movq	(%rdi), %rdi
000000010000a1f7	popq	%rbp
000000010000a1f8	jmp	_fwp_drop2
000000010000a1fd	nopl	(%rax)
_fwp_drop5:
000000010000a200	movq	%rdi, %rcx
000000010000a203	subq	0xce2e(%rip), %rcx
000000010000a20a	movq	0xce4f(%rip), %rax
000000010000a211	shlq	$0x10, %rax
000000010000a215	cmpq	%rax, %rcx
000000010000a218	jae	0x10000a2ae
000000010000a21e	movq	0xce5b(%rip), %rdx
000000010000a225	movq	%rcx, %rax
000000010000a228	shrq	$0x10, %rax
000000010000a22c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
000000010000a233	leaq	(%rdx,%rsi), %rax
000000010000a237	movzbl	(%rdx,%rsi), %edx
000000010000a23b	cmpb	$0x2, %dl
000000010000a23e	setne	%sil
000000010000a242	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000a249	setne	%r8b
000000010000a24d	orb	%sil, %r8b
000000010000a250	jne	0x10000a25a
000000010000a252	addq	$0x228, %rax                    ## imm = 0x228
000000010000a258	jmp	0x10000a273
000000010000a25a	cmpb	$0x1, %dl
000000010000a25d	jne	0x10000a2ae
000000010000a25f	movl	0x20(%rax), %edx
000000010000a262	imulq	%rdx, %rcx
000000010000a266	shrq	$0x20, %rcx
000000010000a26a	addq	%rcx, %rax
000000010000a26d	addq	$0x228, %rax                    ## imm = 0x228
000000010000a273	movzbl	(%rax), %ecx
000000010000a276	testl	%ecx, %ecx
000000010000a278	je	0x10000a2ae
000000010000a27a	cmpl	$0x1, %ecx
000000010000a27d	jne	0x10000a2a2
000000010000a27f	pushq	%rbp
000000010000a280	movq	%rsp, %rbp
000000010000a283	pushq	%rbx
000000010000a284	pushq	%rax
000000010000a285	movq	0x10(%rdi), %rax
000000010000a289	movq	%rdi, %rbx
000000010000a28c	movq	%rax, %rdi
000000010000a28f	callq	_fwp_drop2
000000010000a294	movq	%rbx, %rdi
000000010000a297	addq	$0x8, %rsp
000000010000a29b	popq	%rbx
000000010000a29c	popq	%rbp
000000010000a29d	jmp	_fwp_rc_free_obj
000000010000a2a2	cmpl	$0xff, %ecx
000000010000a2a8	je	0x10000a2af
000000010000a2aa	decb	%cl
000000010000a2ac	movb	%cl, (%rax)
000000010000a2ae	retq
000000010000a2af	movq	%rax, %rdi
000000010000a2b2	jmp	_fwp_rc_wide_drop
000000010000a2b7	nopw	(%rax,%rax)
_fwp_owner_release20:
000000010000a2c0	pushq	%rbp
000000010000a2c1	movq	%rsp, %rbp
000000010000a2c4	movq	(%rdi), %rdi
000000010000a2c7	popq	%rbp
000000010000a2c8	jmp	_fwp_drop2
000000010000a2cd	nopl	(%rax)
_fwp_owner_release21:
000000010000a2d0	pushq	%rbp
000000010000a2d1	movq	%rsp, %rbp
000000010000a2d4	movq	(%rdi), %rdi
000000010000a2d7	popq	%rbp
000000010000a2d8	jmp	_fwp_drop2
000000010000a2dd	nopl	(%rax)
_fwp_owner_release22:
000000010000a2e0	pushq	%rbp
000000010000a2e1	movq	%rsp, %rbp
000000010000a2e4	movq	(%rdi), %rdi
000000010000a2e7	popq	%rbp
000000010000a2e8	jmp	_fwp_drop2
000000010000a2ed	nopl	(%rax)
_fwp_owner_release23:
000000010000a2f0	pushq	%rbp
000000010000a2f1	movq	%rsp, %rbp
000000010000a2f4	movq	(%rdi), %rdi
000000010000a2f7	popq	%rbp
000000010000a2f8	jmp	_fwp_drop2
000000010000a2fd	nopl	(%rax)
_fwp_owner_release24:
000000010000a300	pushq	%rbp
000000010000a301	movq	%rsp, %rbp
000000010000a304	pushq	%rbx
000000010000a305	pushq	%rax
000000010000a306	movq	%rdi, %rbx
000000010000a309	movq	(%rdi), %rdi
000000010000a30c	callq	_fwp_drop2
000000010000a311	movq	0x8(%rbx), %rdi
000000010000a315	addq	$0x8, %rsp
000000010000a319	popq	%rbx
000000010000a31a	popq	%rbp
000000010000a31b	jmp	_fwp_drop2
_fwp_owner_release25:
000000010000a320	pushq	%rbp
000000010000a321	movq	%rsp, %rbp
000000010000a324	movq	(%rdi), %rdi
000000010000a327	popq	%rbp
000000010000a328	jmp	_fwp_drop2
000000010000a32d	nopl	(%rax)
_fwp_owner_release26:
000000010000a330	pushq	%rbp
000000010000a331	movq	%rsp, %rbp
000000010000a334	movq	(%rdi), %rax
000000010000a337	subq	0xccfa(%rip), %rax
000000010000a33e	movq	0xcd1b(%rip), %rcx
000000010000a345	shlq	$0x10, %rcx
000000010000a349	cmpq	%rcx, %rax
000000010000a34c	jae	0x10000a3b2
000000010000a34e	movq	0xcd2b(%rip), %rcx
000000010000a355	movq	%rax, %rdx
000000010000a358	shrq	$0x10, %rdx
000000010000a35c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a363	leaq	(%rcx,%rdx), %rdi
000000010000a367	movzbl	(%rcx,%rdx), %ecx
000000010000a36b	cmpb	$0x2, %cl
000000010000a36e	setne	%dl
000000010000a371	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a377	setne	%sil
000000010000a37b	orb	%dl, %sil
000000010000a37e	jne	0x10000a389
000000010000a380	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a387	jmp	0x10000a3a3
000000010000a389	cmpb	$0x1, %cl
000000010000a38c	jne	0x10000a3b2
000000010000a38e	movl	0x20(%rdi), %ecx
000000010000a391	imulq	%rcx, %rax
000000010000a395	shrq	$0x20, %rax
000000010000a399	addq	%rax, %rdi
000000010000a39c	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a3a3	movzbl	(%rdi), %eax
000000010000a3a6	cmpb	$0x2, %al
000000010000a3a8	jb	0x10000a3b2
000000010000a3aa	cmpb	$-0x1, %al
000000010000a3ac	je	0x10000a3b4
000000010000a3ae	decb	%al
000000010000a3b0	movb	%al, (%rdi)
000000010000a3b2	popq	%rbp
000000010000a3b3	retq
000000010000a3b4	popq	%rbp
000000010000a3b5	jmp	_fwp_rc_wide_drop
000000010000a3ba	nopw	(%rax,%rax)
_fwp_owned_entry35:
000000010000a3c0	pushq	%rbp
000000010000a3c1	movq	%rsp, %rbp
000000010000a3c4	movq	(%rdi), %rdi
000000010000a3c7	popq	%rbp
000000010000a3c8	jmp	_f35
000000010000a3cd	nopl	(%rax)
_fwp_caps35:
000000010000a3d0	movl	0x4(%rdi), %eax
000000010000a3d3	testl	%esi, %esi
000000010000a3d5	je	0x10000a439
000000010000a3d7	testl	%eax, %eax
000000010000a3d9	je	0x10000a491
000000010000a3df	movq	0x8(%rdi), %rax
000000010000a3e3	subq	0xcc4e(%rip), %rax
000000010000a3ea	movq	0xcc6f(%rip), %rcx
000000010000a3f1	shlq	$0x10, %rcx
000000010000a3f5	cmpq	%rcx, %rax
000000010000a3f8	jae	0x10000a491
000000010000a3fe	movq	0xcc7b(%rip), %rcx
000000010000a405	movq	%rax, %rdx
000000010000a408	shrq	$0x10, %rdx
000000010000a40c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a413	leaq	(%rcx,%rdx), %rdi
000000010000a417	movzbl	(%rcx,%rdx), %ecx
000000010000a41b	cmpb	$0x2, %cl
000000010000a41e	setne	%dl
000000010000a421	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a427	setne	%sil
000000010000a42b	orb	%dl, %sil
000000010000a42e	jne	0x10000a464
000000010000a430	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a437	jmp	0x10000a47e
000000010000a439	testl	%eax, %eax
000000010000a43b	je	_fwp_rc_free_obj
000000010000a441	pushq	%rbp
000000010000a442	movq	%rsp, %rbp
000000010000a445	pushq	%rbx
000000010000a446	pushq	%rax
000000010000a447	movq	0x8(%rdi), %rax
000000010000a44b	movq	%rdi, %rbx
000000010000a44e	movq	%rax, %rdi
000000010000a451	callq	_fwp_drop5
000000010000a456	movq	%rbx, %rdi
000000010000a459	addq	$0x8, %rsp
000000010000a45d	popq	%rbx
000000010000a45e	popq	%rbp
000000010000a45f	jmp	_fwp_rc_free_obj
000000010000a464	cmpb	$0x1, %cl
000000010000a467	jne	0x10000a491
000000010000a469	movl	0x20(%rdi), %ecx
000000010000a46c	imulq	%rcx, %rax
000000010000a470	shrq	$0x20, %rax
000000010000a474	addq	%rax, %rdi
000000010000a477	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a47e	movzbl	(%rdi), %eax
000000010000a481	testb	%al, %al
000000010000a483	je	0x10000a491
000000010000a485	cmpb	$-0x2, %al
000000010000a487	jae	_fwp_rc_wide_dup
000000010000a48d	incb	%al
000000010000a48f	movb	%al, (%rdi)
000000010000a491	retq
000000010000a492	nopw	%cs:(%rax,%rax)
_fwp_args35:
000000010000a4a0	pushq	%rbp
000000010000a4a1	movq	%rsp, %rbp
000000010000a4a4	testl	%esi, %esi
000000010000a4a6	setne	%al
000000010000a4a9	testl	%edx, %edx
000000010000a4ab	sete	%cl
000000010000a4ae	orb	%al, %cl
000000010000a4b0	jne	0x10000a530
000000010000a4b2	movq	(%rdi), %rax
000000010000a4b5	subq	0xcb7c(%rip), %rax
000000010000a4bc	movq	0xcb9d(%rip), %rcx
000000010000a4c3	shlq	$0x10, %rcx
000000010000a4c7	cmpq	%rcx, %rax
000000010000a4ca	jae	0x10000a530
000000010000a4cc	movq	0xcbad(%rip), %rcx
000000010000a4d3	movq	%rax, %rdx
000000010000a4d6	shrq	$0x10, %rdx
000000010000a4da	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a4e1	leaq	(%rcx,%rdx), %rdi
000000010000a4e5	movzbl	(%rcx,%rdx), %ecx
000000010000a4e9	cmpb	$0x2, %cl
000000010000a4ec	setne	%dl
000000010000a4ef	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a4f5	setne	%sil
000000010000a4f9	orb	%dl, %sil
000000010000a4fc	jne	0x10000a507
000000010000a4fe	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a505	jmp	0x10000a521
000000010000a507	cmpb	$0x1, %cl
000000010000a50a	jne	0x10000a530
000000010000a50c	movl	0x20(%rdi), %ecx
000000010000a50f	imulq	%rcx, %rax
000000010000a513	shrq	$0x20, %rax
000000010000a517	addq	%rax, %rdi
000000010000a51a	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a521	movzbl	(%rdi), %eax
000000010000a524	testb	%al, %al
000000010000a526	je	0x10000a530
000000010000a528	cmpb	$-0x2, %al
000000010000a52a	jae	0x10000a532
000000010000a52c	incb	%al
000000010000a52e	movb	%al, (%rdi)
000000010000a530	popq	%rbp
000000010000a531	retq
000000010000a532	popq	%rbp
000000010000a533	jmp	_fwp_rc_wide_dup
000000010000a538	nopl	(%rax,%rax)
_fwp_arg_drop35:
000000010000a540	pushq	%rbp
000000010000a541	movq	%rsp, %rbp
000000010000a544	testl	%esi, %esi
000000010000a546	setne	%al
000000010000a549	testl	%edx, %edx
000000010000a54b	sete	%cl
000000010000a54e	orb	%al, %cl
000000010000a550	je	0x10000a554
000000010000a552	popq	%rbp
000000010000a553	retq
000000010000a554	movq	(%rdi), %rdi
000000010000a557	popq	%rbp
000000010000a558	jmp	_fwp_drop5
000000010000a55d	nopl	(%rax)
_f37:
000000010000a560	pushq	%rbp
000000010000a561	movq	%rsp, %rbp
000000010000a564	pushq	%r15
000000010000a566	pushq	%r14
000000010000a568	pushq	%r13
000000010000a56a	pushq	%r12
000000010000a56c	pushq	%rbx
000000010000a56d	subq	$0x198, %rsp                    ## imm = 0x198
000000010000a574	movq	%rdi, %rbx
000000010000a577	movq	0xaab2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000a57e	movq	(%rax), %rax
000000010000a581	movq	%rax, -0x30(%rbp)
000000010000a585	movq	%rdi, -0xd8(%rbp)
000000010000a58c	movq	_fwp_cleanups(%rip), %rax
000000010000a593	movq	%rax, -0xd0(%rbp)
000000010000a59a	leaq	_fwp_owner_release36(%rip), %rax
000000010000a5a1	movq	%rax, -0xc8(%rbp)
000000010000a5a8	leaq	-0xd8(%rbp), %rax
000000010000a5af	movq	%rax, -0xc0(%rbp)
000000010000a5b6	movq	$0x0, -0xb8(%rbp)
000000010000a5c1	leaq	-0xd0(%rbp), %rax
000000010000a5c8	movq	%rax, -0x140(%rbp)
000000010000a5cf	leaq	_fwp_owner_release37(%rip), %rax
000000010000a5d6	movq	%rax, -0x138(%rbp)
000000010000a5dd	leaq	-0xb8(%rbp), %rax
000000010000a5e4	movq	%rax, -0x130(%rbp)
000000010000a5eb	leaq	-0x140(%rbp), %r15
000000010000a5f2	movq	%r15, _fwp_cleanups(%rip)
000000010000a5f9	movq	0x10(%rdi), %rax
000000010000a5fd	subq	0xca34(%rip), %rax
000000010000a604	movq	0xca55(%rip), %rcx
000000010000a60b	shlq	$0x10, %rcx
000000010000a60f	cmpq	%rcx, %rax
000000010000a612	jae	0x10000a67c
000000010000a614	movq	0xca65(%rip), %rcx
000000010000a61b	movq	%rax, %rdx
000000010000a61e	shrq	$0x10, %rdx
000000010000a622	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a629	leaq	(%rcx,%rdx), %rdi
000000010000a62d	movzbl	(%rcx,%rdx), %ecx
000000010000a631	cmpb	$0x2, %cl
000000010000a634	setne	%dl
000000010000a637	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a63d	setne	%sil
000000010000a641	orb	%dl, %sil
000000010000a644	jne	0x10000a64f
000000010000a646	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a64d	jmp	0x10000a669
000000010000a64f	cmpb	$0x1, %cl
000000010000a652	jne	0x10000a67c
000000010000a654	movl	0x20(%rdi), %ecx
000000010000a657	imulq	%rcx, %rax
000000010000a65b	shrq	$0x20, %rax
000000010000a65f	addq	%rax, %rdi
000000010000a662	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a669	movzbl	(%rdi), %eax
000000010000a66c	testb	%al, %al
000000010000a66e	je	0x10000a67c
000000010000a670	cmpb	$-0x3, %al
000000010000a672	ja	0x10000ac7e
000000010000a678	incb	%al
000000010000a67a	movb	%al, (%rdi)
000000010000a67c	movq	0x10(%rbx), %r14
000000010000a680	movq	%r14, -0xb8(%rbp)
000000010000a687	movq	-0x140(%rbp), %rax
000000010000a68e	movq	0x8(%rbx), %r13
000000010000a692	movsbq	0x18(%rbx), %r15
000000010000a697	movq	%r14, -0x128(%rbp)
000000010000a69e	movq	%rax, -0x170(%rbp)
000000010000a6a5	leaq	_fwp_owner_release29(%rip), %rax
000000010000a6ac	movq	%rax, -0x168(%rbp)
000000010000a6b3	leaq	-0x128(%rbp), %rax
000000010000a6ba	movq	%rax, -0x160(%rbp)
000000010000a6c1	leaq	-0x170(%rbp), %rax
000000010000a6c8	movq	%rax, _fwp_cleanups(%rip)
000000010000a6cf	testq	%r13, %r13
000000010000a6d2	js	0x10000a710
000000010000a6d4	movq	(%r14), %rsi
000000010000a6d7	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000a6e1	andq	%rsi, %rcx
000000010000a6e4	cmpq	%r13, %rcx
000000010000a6e7	jbe	0x10000a710
000000010000a6e9	movl	_d2(%rip), %ecx
000000010000a6ef	movl	$0x8, %edx
000000010000a6f4	cmpq	$0xa, %rcx
000000010000a6f8	ja	0x10000a705
000000010000a6fa	leaq	0x8a57(%rip), %rdx
000000010000a701	movq	(%rdx,%rcx,8), %rdx
000000010000a705	testq	%rsi, %rsi
000000010000a708	js	0x10000a717
000000010000a70a	leaq	0x8(%r14), %rsi
000000010000a70e	jmp	0x10000a71b
000000010000a710	xorl	%ecx, %ecx
000000010000a712	xorl	%r12d, %r12d
000000010000a715	jmp	0x10000a763
000000010000a717	movq	0x10(%r14), %rsi
000000010000a71b	movq	%rdx, %rdi
000000010000a71e	imulq	%r13, %rdi
000000010000a722	cmpq	$0x1, %rdx
000000010000a726	je	0x10000a747
000000010000a728	cmpq	$0x2, %rdx
000000010000a72c	je	0x10000a73a
000000010000a72e	cmpq	$0x8, %rdx
000000010000a732	jne	0x10000a754
000000010000a734	movq	(%rsi,%rdi), %r12
000000010000a738	jmp	0x10000a761
000000010000a73a	movzwl	(%rsi,%rdi), %edx
000000010000a73e	cmpl	$0x1, %ecx
000000010000a741	movswq	%dx, %r12
000000010000a745	jmp	0x10000a75d
000000010000a747	movzbl	(%rsi,%rdi), %edx
000000010000a74b	testq	%rcx, %rcx
000000010000a74e	movsbq	%dl, %r12
000000010000a752	jmp	0x10000a75d
000000010000a754	movl	(%rsi,%rdi), %edx
000000010000a757	cmpl	$0x2, %ecx
000000010000a75a	movslq	%edx, %r12
000000010000a75d	cmovneq	%rdx, %r12
000000010000a761	movb	$0x1, %cl
000000010000a763	cmpq	%rax, _fwp_cleanups(%rip)
000000010000a76a	jne	0x10000acb9
000000010000a770	movq	-0x170(%rbp), %rax
000000010000a777	movq	%rax, _fwp_cleanups(%rip)
000000010000a77e	testb	%cl, %cl
000000010000a780	je	0x10000a8a9
000000010000a786	movq	%r14, -0x120(%rbp)
000000010000a78d	movq	%rax, -0x1b8(%rbp)
000000010000a794	leaq	_fwp_owner_release30(%rip), %rcx
000000010000a79b	movq	%rcx, -0x1b0(%rbp)
000000010000a7a2	leaq	-0x120(%rbp), %rcx
000000010000a7a9	movq	%rcx, -0x1a8(%rbp)
000000010000a7b0	leaq	-0x1b8(%rbp), %rcx
000000010000a7b7	movq	%rcx, _fwp_cleanups(%rip)
000000010000a7be	incq	%r13
000000010000a7c1	jo	0x10000acd3
000000010000a7c7	movq	%r14, -0x118(%rbp)
000000010000a7ce	movq	%rax, -0x1a0(%rbp)
000000010000a7d5	leaq	_fwp_owner_release31(%rip), %rcx
000000010000a7dc	movq	%rcx, -0x198(%rbp)
000000010000a7e3	leaq	-0x118(%rbp), %rcx
000000010000a7ea	movq	%rcx, -0x190(%rbp)
000000010000a7f1	leaq	-0x1a0(%rbp), %rcx
000000010000a7f8	movq	%rcx, _fwp_cleanups(%rip)
000000010000a7ff	leaq	-0x7f(%r12), %rcx
000000010000a804	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
000000010000a80b	jbe	0x10000acbe
000000010000a811	movq	%r14, -0x110(%rbp)
000000010000a818	movq	%rax, -0x108(%rbp)
000000010000a81f	leaq	_fwp_owner_release32(%rip), %rax
000000010000a826	movq	%rax, -0x100(%rbp)
000000010000a82d	leaq	-0x110(%rbp), %rax
000000010000a834	movq	%rax, -0xf8(%rbp)
000000010000a83b	leaq	-0x108(%rbp), %rcx
000000010000a842	movq	%r14, %rax
000000010000a845	subq	0xc7ec(%rip), %rax
000000010000a84c	movq	%rcx, _fwp_cleanups(%rip)
000000010000a853	movq	0xc806(%rip), %rcx
000000010000a85a	shlq	$0x10, %rcx
000000010000a85e	cmpq	%rcx, %rax
000000010000a861	jae	0x10000a9a6
000000010000a867	movq	0xc812(%rip), %rcx
000000010000a86e	movq	%rax, %rdx
000000010000a871	shrq	$0x10, %rdx
000000010000a875	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a87c	leaq	(%rcx,%rdx), %rdi
000000010000a880	movzbl	(%rcx,%rdx), %ecx
000000010000a884	cmpb	$0x2, %cl
000000010000a887	setne	%dl
000000010000a88a	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a890	setne	%sil
000000010000a894	orb	%dl, %sil
000000010000a897	jne	0x10000a979
000000010000a89d	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a8a4	jmp	0x10000a993
000000010000a8a9	movq	%r14, %rdi
000000010000a8ac	callq	_fwp_drop2
000000010000a8b1	movq	%r15, -0x90(%rbp)
000000010000a8b8	movl	$0x10, %edi
000000010000a8bd	callq	_fwp_alloc_init
000000010000a8c2	movq	%rax, %r14
000000010000a8c5	movabsq	$0x100000001, %rax              ## imm = 0x100000001
000000010000a8cf	movq	%rax, (%r14)
000000010000a8d2	movq	%r15, 0x8(%r14)
000000010000a8d6	leaq	-0x90(%rbp), %rax
000000010000a8dd	movq	%r14, %rax
000000010000a8e0	subq	0xc751(%rip), %rax
000000010000a8e7	movq	0xc772(%rip), %rcx
000000010000a8ee	shlq	$0x10, %rcx
000000010000a8f2	cmpq	%rcx, %rax
000000010000a8f5	jae	0x10000ac33
000000010000a8fb	movq	0xc77e(%rip), %rcx
000000010000a902	movq	%rax, %rdx
000000010000a905	shrq	$0x10, %rdx
000000010000a909	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000a910	leaq	(%rcx,%rdx), %r15
000000010000a914	movzbl	(%rcx,%rdx), %ecx
000000010000a918	cmpb	$0x2, %cl
000000010000a91b	setne	%dl
000000010000a91e	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000a924	setne	%sil
000000010000a928	orb	%dl, %sil
000000010000a92b	leaq	-0xd0(%rbp), %r12
000000010000a932	jne	0x10000a94a
000000010000a934	addq	$0x228, %r15                    ## imm = 0x228
000000010000a93b	cmpb	$-0x1, (%r15)
000000010000a93f	je	0x10000a96f
000000010000a941	movb	$0x1, (%r15)
000000010000a945	jmp	0x10000ac3a
000000010000a94a	cmpb	$0x1, %cl
000000010000a94d	jne	0x10000ac3a
000000010000a953	movl	0x20(%r15), %ecx
000000010000a957	imulq	%rcx, %rax
000000010000a95b	shrq	$0x20, %rax
000000010000a95f	addq	%rax, %r15
000000010000a962	addq	$0x228, %r15                    ## imm = 0x228
000000010000a969	cmpb	$-0x1, (%r15)
000000010000a96d	jne	0x10000a941
000000010000a96f	movq	%r15, %rdi
000000010000a972	callq	_fwp_rc_forget_slot
000000010000a977	jmp	0x10000a941
000000010000a979	cmpb	$0x1, %cl
000000010000a97c	jne	0x10000a9a6
000000010000a97e	movl	0x20(%rdi), %ecx
000000010000a981	imulq	%rcx, %rax
000000010000a985	shrq	$0x20, %rax
000000010000a989	addq	%rax, %rdi
000000010000a98c	addq	$0x228, %rdi                    ## imm = 0x228
000000010000a993	movzbl	(%rdi), %eax
000000010000a996	testb	%al, %al
000000010000a998	je	0x10000a9a6
000000010000a99a	cmpb	$-0x3, %al
000000010000a99c	ja	0x10000aca0
000000010000a9a2	incb	%al
000000010000a9a4	movb	%al, (%rdi)
000000010000a9a6	movq	-0x108(%rbp), %rax
000000010000a9ad	movq	%rax, _fwp_cleanups(%rip)
000000010000a9b4	movq	%r14, %rdi
000000010000a9b7	callq	_fwp_drop2
000000010000a9bc	movq	%r14, -0xf0(%rbp)
000000010000a9c3	movq	_fwp_cleanups(%rip), %rax
000000010000a9ca	movq	%rax, -0x188(%rbp)
000000010000a9d1	leaq	_fwp_owner_release33(%rip), %rcx
000000010000a9d8	movq	%rcx, -0x180(%rbp)
000000010000a9df	leaq	-0xf0(%rbp), %rcx
000000010000a9e6	movq	%rcx, -0x178(%rbp)
000000010000a9ed	leaq	-0x188(%rbp), %rcx
000000010000a9f4	movq	%rcx, _fwp_cleanups(%rip)
000000010000a9fb	addq	%r15, %r12
000000010000a9fe	incq	%r12
000000010000aa01	movsbq	%r12b, %rcx
000000010000aa05	cmpq	%r12, %rcx
000000010000aa08	jne	0x10000acbe
000000010000aa0e	movq	%r14, -0xe8(%rbp)
000000010000aa15	movq	%rax, -0x90(%rbp)
000000010000aa1c	leaq	_fwp_owner_release34(%rip), %rax
000000010000aa23	movq	%rax, -0x88(%rbp)
000000010000aa2a	leaq	-0xe8(%rbp), %rax
000000010000aa31	movq	%rax, -0x80(%rbp)
000000010000aa35	leaq	-0x90(%rbp), %rax
000000010000aa3c	movq	%rax, _fwp_cleanups(%rip)
000000010000aa43	movq	%r13, -0xa8(%rbp)
000000010000aa4a	movq	%r14, -0xa0(%rbp)
000000010000aa51	movq	%r12, -0x98(%rbp)
000000010000aa58	movl	$0x20, %edi
000000010000aa5d	callq	_fwp_alloc_init
000000010000aa62	movq	%rax, %r15
000000010000aa65	movabsq	$0x300000000, %rax              ## imm = 0x300000000
000000010000aa6f	movq	%rax, (%r15)
000000010000aa72	movq	%r13, 0x8(%r15)
000000010000aa76	movq	%r14, 0x10(%r15)
000000010000aa7a	movq	%r12, 0x18(%r15)
000000010000aa7e	leaq	-0xa8(%rbp), %rax
000000010000aa85	movq	%r15, %rax
000000010000aa88	subq	0xc5a9(%rip), %rax
000000010000aa8f	movq	0xc5ca(%rip), %rcx
000000010000aa96	shlq	$0x10, %rcx
000000010000aa9a	cmpq	%rcx, %rax
000000010000aa9d	jae	0x10000ab0f
000000010000aa9f	movq	0xc5da(%rip), %rcx
000000010000aaa6	movq	%rax, %rdx
000000010000aaa9	shrq	$0x10, %rdx
000000010000aaad	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000aab4	leaq	(%rcx,%rdx), %r14
000000010000aab8	movzbl	(%rcx,%rdx), %ecx
000000010000aabc	cmpb	$0x2, %cl
000000010000aabf	setne	%dl
000000010000aac2	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000aac8	setne	%sil
000000010000aacc	orb	%dl, %sil
000000010000aacf	jne	0x10000aae4
000000010000aad1	addq	$0x228, %r14                    ## imm = 0x228
000000010000aad8	cmpb	$-0x1, (%r14)
000000010000aadc	je	0x10000ab05
000000010000aade	movb	$0x1, (%r14)
000000010000aae2	jmp	0x10000ab0f
000000010000aae4	cmpb	$0x1, %cl
000000010000aae7	jne	0x10000ab0f
000000010000aae9	movl	0x20(%r14), %ecx
000000010000aaed	imulq	%rcx, %rax
000000010000aaf1	shrq	$0x20, %rax
000000010000aaf5	addq	%rax, %r14
000000010000aaf8	addq	$0x228, %r14                    ## imm = 0x228
000000010000aaff	cmpb	$-0x1, (%r14)
000000010000ab03	jne	0x10000aade
000000010000ab05	movq	%r14, %rdi
000000010000ab08	callq	_fwp_rc_forget_slot
000000010000ab0d	jmp	0x10000aade
000000010000ab0f	leaq	-0x90(%rbp), %rax
000000010000ab16	cmpq	%rax, _fwp_cleanups(%rip)
000000010000ab1d	jne	0x10000acb9
000000010000ab23	movq	-0x90(%rbp), %rax
000000010000ab2a	movq	%r15, -0xe0(%rbp)
000000010000ab31	movq	%rax, -0x158(%rbp)
000000010000ab38	leaq	_fwp_owner_release35(%rip), %rax
000000010000ab3f	movq	%rax, -0x150(%rbp)
000000010000ab46	leaq	-0xe0(%rbp), %rax
000000010000ab4d	movq	%rax, -0x148(%rbp)
000000010000ab54	leaq	-0x158(%rbp), %r12
000000010000ab5b	movq	%r12, _fwp_cleanups(%rip)
000000010000ab62	movq	%r15, -0xb0(%rbp)
000000010000ab69	movl	$0x10, %edi
000000010000ab6e	callq	_fwp_alloc_init
000000010000ab73	movq	%rax, %r14
000000010000ab76	movabsq	$__mh_execute_header, %rax
000000010000ab80	movq	%rax, (%r14)
000000010000ab83	movq	%r15, 0x8(%r14)
000000010000ab87	leaq	-0xb0(%rbp), %rax
000000010000ab8e	movq	%r14, %rax
000000010000ab91	subq	0xc4a0(%rip), %rax
000000010000ab98	movq	0xc4c1(%rip), %rcx
000000010000ab9f	shlq	$0x10, %rcx
000000010000aba3	cmpq	%rcx, %rax
000000010000aba6	jae	0x10000ac18
000000010000aba8	movq	0xc4d1(%rip), %rcx
000000010000abaf	movq	%rax, %rdx
000000010000abb2	shrq	$0x10, %rdx
000000010000abb6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000abbd	leaq	(%rcx,%rdx), %r15
000000010000abc1	movzbl	(%rcx,%rdx), %ecx
000000010000abc5	cmpb	$0x2, %cl
000000010000abc8	setne	%dl
000000010000abcb	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000abd1	setne	%sil
000000010000abd5	orb	%dl, %sil
000000010000abd8	jne	0x10000abed
000000010000abda	addq	$0x228, %r15                    ## imm = 0x228
000000010000abe1	cmpb	$-0x1, (%r15)
000000010000abe5	je	0x10000ac0e
000000010000abe7	movb	$0x1, (%r15)
000000010000abeb	jmp	0x10000ac18
000000010000abed	cmpb	$0x1, %cl
000000010000abf0	jne	0x10000ac18
000000010000abf2	movl	0x20(%r15), %ecx
000000010000abf6	imulq	%rcx, %rax
000000010000abfa	shrq	$0x20, %rax
000000010000abfe	addq	%rax, %r15
000000010000ac01	addq	$0x228, %r15                    ## imm = 0x228
000000010000ac08	cmpb	$-0x1, (%r15)
000000010000ac0c	jne	0x10000abe7
000000010000ac0e	movq	%r15, %rdi
000000010000ac11	callq	_fwp_rc_forget_slot
000000010000ac16	jmp	0x10000abe7
000000010000ac18	cmpq	%r12, _fwp_cleanups(%rip)
000000010000ac1f	jne	0x10000acb9
000000010000ac25	movq	-0x158(%rbp), %rax
000000010000ac2c	movq	%rax, _fwp_cleanups(%rip)
000000010000ac33	leaq	-0xd0(%rbp), %r12
000000010000ac3a	cmpq	%r12, _fwp_cleanups(%rip)
000000010000ac41	jne	0x10000acb9
000000010000ac43	movq	-0xd0(%rbp), %rax
000000010000ac4a	movq	%rax, _fwp_cleanups(%rip)
000000010000ac51	movq	%rbx, %rdi
000000010000ac54	callq	_fwp_drop6
000000010000ac59	movq	0xa3d0(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ac60	movq	(%rax), %rax
000000010000ac63	cmpq	-0x30(%rbp), %rax
000000010000ac67	jne	0x10000acce
000000010000ac69	movq	%r14, %rax
000000010000ac6c	addq	$0x198, %rsp                    ## imm = 0x198
000000010000ac73	popq	%rbx
000000010000ac74	popq	%r12
000000010000ac76	popq	%r13
000000010000ac78	popq	%r14
000000010000ac7a	popq	%r15
000000010000ac7c	popq	%rbp
000000010000ac7d	retq
000000010000ac7e	callq	_fwp_rc_wide_dup
000000010000ac83	movq	_fwp_cleanups(%rip), %rax
000000010000ac8a	movq	0x10(%rbx), %r14
000000010000ac8e	movq	%r14, -0xb8(%rbp)
000000010000ac95	cmpq	%r15, %rax
000000010000ac98	je	0x10000a687
000000010000ac9e	jmp	0x10000acb9
000000010000aca0	callq	_fwp_rc_wide_dup
000000010000aca5	leaq	-0x108(%rbp), %rax
000000010000acac	cmpq	%rax, _fwp_cleanups(%rip)
000000010000acb3	je	0x10000a9a6
000000010000acb9	callq	0x100012c2a                     ## symbol stub for: _abort
000000010000acbe	leaq	0x8761(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000acc5	leaq	0x87d9(%rip), %rcx              ## literal pool for: "I8"
000000010000accc	jmp	0x10000ace1
000000010000acce	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000acd3	leaq	0x874c(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000acda	leaq	0x8741(%rip), %rcx              ## literal pool for: "I64"
000000010000ace1	leaq	-0x90(%rbp), %rbx
000000010000ace8	movl	$0x60, %esi
000000010000aced	movq	%rbx, %rdi
000000010000acf0	xorl	%eax, %eax
000000010000acf2	callq	0x100012d0e                     ## symbol stub for: _snprintf
000000010000acf7	callq	_fwp_flush
000000010000acfc	movq	0xa335(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000ad03	movq	(%rax), %rdi
000000010000ad06	leaq	0x8702(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
000000010000ad0d	movq	%rbx, %rdx
000000010000ad10	xorl	%eax, %eax
000000010000ad12	callq	0x100012c5a                     ## symbol stub for: _fprintf
000000010000ad17	movl	$0x65, %edi
000000010000ad1c	callq	0x100012c48                     ## symbol stub for: _exit
000000010000ad21	nopw	%cs:(%rax,%rax)
_fwp_owner_release36:
000000010000ad30	pushq	%rbp
000000010000ad31	movq	%rsp, %rbp
000000010000ad34	movq	(%rdi), %rdi
000000010000ad37	popq	%rbp
000000010000ad38	jmp	_fwp_drop6
000000010000ad3d	nopl	(%rax)
_fwp_owner_release37:
000000010000ad40	pushq	%rbp
000000010000ad41	movq	%rsp, %rbp
000000010000ad44	movq	(%rdi), %rdi
000000010000ad47	popq	%rbp
000000010000ad48	jmp	_fwp_drop2
000000010000ad4d	nopl	(%rax)
_fwp_drop6:
000000010000ad50	movq	%rdi, %rcx
000000010000ad53	subq	0xc2de(%rip), %rcx
000000010000ad5a	movq	0xc2ff(%rip), %rax
000000010000ad61	shlq	$0x10, %rax
000000010000ad65	cmpq	%rax, %rcx
000000010000ad68	jae	0x10000adfe
000000010000ad6e	movq	0xc30b(%rip), %rdx
000000010000ad75	movq	%rcx, %rax
000000010000ad78	shrq	$0x10, %rax
000000010000ad7c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
000000010000ad83	leaq	(%rdx,%rsi), %rax
000000010000ad87	movzbl	(%rdx,%rsi), %edx
000000010000ad8b	cmpb	$0x2, %dl
000000010000ad8e	setne	%sil
000000010000ad92	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000ad99	setne	%r8b
000000010000ad9d	orb	%sil, %r8b
000000010000ada0	jne	0x10000adaa
000000010000ada2	addq	$0x228, %rax                    ## imm = 0x228
000000010000ada8	jmp	0x10000adc3
000000010000adaa	cmpb	$0x1, %dl
000000010000adad	jne	0x10000adfe
000000010000adaf	movl	0x20(%rax), %edx
000000010000adb2	imulq	%rdx, %rcx
000000010000adb6	shrq	$0x20, %rcx
000000010000adba	addq	%rcx, %rax
000000010000adbd	addq	$0x228, %rax                    ## imm = 0x228
000000010000adc3	movzbl	(%rax), %ecx
000000010000adc6	testl	%ecx, %ecx
000000010000adc8	je	0x10000adfe
000000010000adca	cmpl	$0x1, %ecx
000000010000adcd	jne	0x10000adf2
000000010000adcf	pushq	%rbp
000000010000add0	movq	%rsp, %rbp
000000010000add3	pushq	%rbx
000000010000add4	pushq	%rax
000000010000add5	movq	0x10(%rdi), %rax
000000010000add9	movq	%rdi, %rbx
000000010000addc	movq	%rax, %rdi
000000010000addf	callq	_fwp_drop2
000000010000ade4	movq	%rbx, %rdi
000000010000ade7	addq	$0x8, %rsp
000000010000adeb	popq	%rbx
000000010000adec	popq	%rbp
000000010000aded	jmp	_fwp_rc_free_obj
000000010000adf2	cmpl	$0xff, %ecx
000000010000adf8	je	0x10000adff
000000010000adfa	decb	%cl
000000010000adfc	movb	%cl, (%rax)
000000010000adfe	retq
000000010000adff	movq	%rax, %rdi
000000010000ae02	jmp	_fwp_rc_wide_drop
000000010000ae07	nopw	(%rax,%rax)
_fwp_owner_release29:
000000010000ae10	pushq	%rbp
000000010000ae11	movq	%rsp, %rbp
000000010000ae14	movq	(%rdi), %rdi
000000010000ae17	popq	%rbp
000000010000ae18	jmp	_fwp_drop2
000000010000ae1d	nopl	(%rax)
_fwp_owner_release30:
000000010000ae20	pushq	%rbp
000000010000ae21	movq	%rsp, %rbp
000000010000ae24	movq	(%rdi), %rdi
000000010000ae27	popq	%rbp
000000010000ae28	jmp	_fwp_drop2
000000010000ae2d	nopl	(%rax)
_fwp_owner_release31:
000000010000ae30	pushq	%rbp
000000010000ae31	movq	%rsp, %rbp
000000010000ae34	movq	(%rdi), %rdi
000000010000ae37	popq	%rbp
000000010000ae38	jmp	_fwp_drop2
000000010000ae3d	nopl	(%rax)
_fwp_owner_release32:
000000010000ae40	pushq	%rbp
000000010000ae41	movq	%rsp, %rbp
000000010000ae44	movq	(%rdi), %rdi
000000010000ae47	popq	%rbp
000000010000ae48	jmp	_fwp_drop2
000000010000ae4d	nopl	(%rax)
_fwp_owner_release33:
000000010000ae50	pushq	%rbp
000000010000ae51	movq	%rsp, %rbp
000000010000ae54	movq	(%rdi), %rdi
000000010000ae57	popq	%rbp
000000010000ae58	jmp	_fwp_drop2
000000010000ae5d	nopl	(%rax)
_fwp_owner_release34:
000000010000ae60	pushq	%rbp
000000010000ae61	movq	%rsp, %rbp
000000010000ae64	movq	(%rdi), %rdi
000000010000ae67	popq	%rbp
000000010000ae68	jmp	_fwp_drop2
000000010000ae6d	nopl	(%rax)
_fwp_owner_release35:
000000010000ae70	pushq	%rbp
000000010000ae71	movq	%rsp, %rbp
000000010000ae74	movq	(%rdi), %rax
000000010000ae77	subq	0xc1ba(%rip), %rax
000000010000ae7e	movq	0xc1db(%rip), %rcx
000000010000ae85	shlq	$0x10, %rcx
000000010000ae89	cmpq	%rcx, %rax
000000010000ae8c	jae	0x10000aef2
000000010000ae8e	movq	0xc1eb(%rip), %rcx
000000010000ae95	movq	%rax, %rdx
000000010000ae98	shrq	$0x10, %rdx
000000010000ae9c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000aea3	leaq	(%rcx,%rdx), %rdi
000000010000aea7	movzbl	(%rcx,%rdx), %ecx
000000010000aeab	cmpb	$0x2, %cl
000000010000aeae	setne	%dl
000000010000aeb1	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000aeb7	setne	%sil
000000010000aebb	orb	%dl, %sil
000000010000aebe	jne	0x10000aec9
000000010000aec0	addq	$0x228, %rdi                    ## imm = 0x228
000000010000aec7	jmp	0x10000aee3
000000010000aec9	cmpb	$0x1, %cl
000000010000aecc	jne	0x10000aef2
000000010000aece	movl	0x20(%rdi), %ecx
000000010000aed1	imulq	%rcx, %rax
000000010000aed5	shrq	$0x20, %rax
000000010000aed9	addq	%rax, %rdi
000000010000aedc	addq	$0x228, %rdi                    ## imm = 0x228
000000010000aee3	movzbl	(%rdi), %eax
000000010000aee6	cmpb	$0x2, %al
000000010000aee8	jb	0x10000aef2
000000010000aeea	cmpb	$-0x1, %al
000000010000aeec	je	0x10000aef4
000000010000aeee	decb	%al
000000010000aef0	movb	%al, (%rdi)
000000010000aef2	popq	%rbp
000000010000aef3	retq
000000010000aef4	popq	%rbp
000000010000aef5	jmp	_fwp_rc_wide_drop
000000010000aefa	nopw	(%rax,%rax)
_fwp_owned_entry37:
000000010000af00	pushq	%rbp
000000010000af01	movq	%rsp, %rbp
000000010000af04	movq	(%rdi), %rdi
000000010000af07	popq	%rbp
000000010000af08	jmp	_f37
000000010000af0d	nopl	(%rax)
_fwp_caps37:
000000010000af10	movl	0x4(%rdi), %eax
000000010000af13	testl	%esi, %esi
000000010000af15	je	0x10000af79
000000010000af17	testl	%eax, %eax
000000010000af19	je	0x10000afd1
000000010000af1f	movq	0x8(%rdi), %rax
000000010000af23	subq	0xc10e(%rip), %rax
000000010000af2a	movq	0xc12f(%rip), %rcx
000000010000af31	shlq	$0x10, %rcx
000000010000af35	cmpq	%rcx, %rax
000000010000af38	jae	0x10000afd1
000000010000af3e	movq	0xc13b(%rip), %rcx
000000010000af45	movq	%rax, %rdx
000000010000af48	shrq	$0x10, %rdx
000000010000af4c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000af53	leaq	(%rcx,%rdx), %rdi
000000010000af57	movzbl	(%rcx,%rdx), %ecx
000000010000af5b	cmpb	$0x2, %cl
000000010000af5e	setne	%dl
000000010000af61	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000af67	setne	%sil
000000010000af6b	orb	%dl, %sil
000000010000af6e	jne	0x10000afa4
000000010000af70	addq	$0x228, %rdi                    ## imm = 0x228
000000010000af77	jmp	0x10000afbe
000000010000af79	testl	%eax, %eax
000000010000af7b	je	_fwp_rc_free_obj
000000010000af81	pushq	%rbp
000000010000af82	movq	%rsp, %rbp
000000010000af85	pushq	%rbx
000000010000af86	pushq	%rax
000000010000af87	movq	0x8(%rdi), %rax
000000010000af8b	movq	%rdi, %rbx
000000010000af8e	movq	%rax, %rdi
000000010000af91	callq	_fwp_drop6
000000010000af96	movq	%rbx, %rdi
000000010000af99	addq	$0x8, %rsp
000000010000af9d	popq	%rbx
000000010000af9e	popq	%rbp
000000010000af9f	jmp	_fwp_rc_free_obj
000000010000afa4	cmpb	$0x1, %cl
000000010000afa7	jne	0x10000afd1
000000010000afa9	movl	0x20(%rdi), %ecx
000000010000afac	imulq	%rcx, %rax
000000010000afb0	shrq	$0x20, %rax
000000010000afb4	addq	%rax, %rdi
000000010000afb7	addq	$0x228, %rdi                    ## imm = 0x228
000000010000afbe	movzbl	(%rdi), %eax
000000010000afc1	testb	%al, %al
000000010000afc3	je	0x10000afd1
000000010000afc5	cmpb	$-0x2, %al
000000010000afc7	jae	_fwp_rc_wide_dup
000000010000afcd	incb	%al
000000010000afcf	movb	%al, (%rdi)
000000010000afd1	retq
000000010000afd2	nopw	%cs:(%rax,%rax)
_fwp_args37:
000000010000afe0	pushq	%rbp
000000010000afe1	movq	%rsp, %rbp
000000010000afe4	testl	%esi, %esi
000000010000afe6	setne	%al
000000010000afe9	testl	%edx, %edx
000000010000afeb	sete	%cl
000000010000afee	orb	%al, %cl
000000010000aff0	jne	0x10000b070
000000010000aff2	movq	(%rdi), %rax
000000010000aff5	subq	0xc03c(%rip), %rax
000000010000affc	movq	0xc05d(%rip), %rcx
000000010000b003	shlq	$0x10, %rcx
000000010000b007	cmpq	%rcx, %rax
000000010000b00a	jae	0x10000b070
000000010000b00c	movq	0xc06d(%rip), %rcx
000000010000b013	movq	%rax, %rdx
000000010000b016	shrq	$0x10, %rdx
000000010000b01a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000b021	leaq	(%rcx,%rdx), %rdi
000000010000b025	movzbl	(%rcx,%rdx), %ecx
000000010000b029	cmpb	$0x2, %cl
000000010000b02c	setne	%dl
000000010000b02f	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000b035	setne	%sil
000000010000b039	orb	%dl, %sil
000000010000b03c	jne	0x10000b047
000000010000b03e	addq	$0x228, %rdi                    ## imm = 0x228
000000010000b045	jmp	0x10000b061
000000010000b047	cmpb	$0x1, %cl
000000010000b04a	jne	0x10000b070
000000010000b04c	movl	0x20(%rdi), %ecx
000000010000b04f	imulq	%rcx, %rax
000000010000b053	shrq	$0x20, %rax
000000010000b057	addq	%rax, %rdi
000000010000b05a	addq	$0x228, %rdi                    ## imm = 0x228
000000010000b061	movzbl	(%rdi), %eax
000000010000b064	testb	%al, %al
000000010000b066	je	0x10000b070
000000010000b068	cmpb	$-0x2, %al
000000010000b06a	jae	0x10000b072
000000010000b06c	incb	%al
000000010000b06e	movb	%al, (%rdi)
000000010000b070	popq	%rbp
000000010000b071	retq
000000010000b072	popq	%rbp
000000010000b073	jmp	_fwp_rc_wide_dup
000000010000b078	nopl	(%rax,%rax)
_fwp_arg_drop37:
000000010000b080	pushq	%rbp
000000010000b081	movq	%rsp, %rbp
000000010000b084	testl	%esi, %esi
000000010000b086	setne	%al
000000010000b089	testl	%edx, %edx
000000010000b08b	sete	%cl
000000010000b08e	orb	%al, %cl
000000010000b090	je	0x10000b094
000000010000b092	popq	%rbp
000000010000b093	retq
000000010000b094	movq	(%rdi), %rdi
000000010000b097	popq	%rbp
000000010000b098	jmp	_fwp_drop6
000000010000b09d	nopl	(%rax)
_fwp_segv:
000000010000b0a0	movq	_fwp_main_stack_top(%rip), %rax
000000010000b0a7	testq	%rax, %rax
000000010000b0aa	je	0x10000b0d4
000000010000b0ac	movq	0x18(%rsi), %rcx
000000010000b0b0	subq	_fwp_main_stack_size(%rip), %rax
000000010000b0b7	leaq	-0x100000(%rax), %rdx
000000010000b0be	addq	$0x100000, %rax                 ## imm = 0x100000
000000010000b0c4	cmpq	%rcx, %rdx
000000010000b0c7	setbe	%dl
000000010000b0ca	cmpq	%rcx, %rax
000000010000b0cd	seta	%al
000000010000b0d0	testb	%al, %dl
000000010000b0d2	jne	0x10000b0db
000000010000b0d4	xorl	%esi, %esi
000000010000b0d6	jmp	0x100012d08                     ## symbol stub for: _signal
000000010000b0db	pushq	%rbp
000000010000b0dc	movq	%rsp, %rbp
000000010000b0df	callq	_fwp_flush
000000010000b0e4	leaq	_fwp_segv.msg(%rip), %rsi
000000010000b0eb	movl	$0x1a, %edx
000000010000b0f0	movl	$0x2, %edi
000000010000b0f5	callq	0x100012d5c                     ## symbol stub for: _write
000000010000b0fa	movl	$0x65, %edi
000000010000b0ff	callq	0x100012c24                     ## symbol stub for: __exit
000000010000b104	nopw	%cs:(%rax,%rax)
_fwp_str_lossy:
000000010000b110	pushq	%rbp
000000010000b111	movq	%rsp, %rbp
000000010000b114	pushq	%r15
000000010000b116	pushq	%r14
000000010000b118	pushq	%r13
000000010000b11a	pushq	%r12
000000010000b11c	pushq	%rbx
000000010000b11d	subq	$0x28, %rsp
000000010000b121	movq	%rsi, %rbx
000000010000b124	movq	%rdi, %r14
000000010000b127	testq	%rsi, %rsi
000000010000b12a	je	0x10000b261
000000010000b130	xorl	%eax, %eax
000000010000b132	jmp	0x10000b14c
000000010000b134	nopw	%cs:(%rax,%rax)
000000010000b140	incq	%rax
000000010000b143	cmpq	%rbx, %rax
000000010000b146	jae	0x10000b261
000000010000b14c	movzbl	(%r14,%rax), %edi
000000010000b151	testb	%dil, %dil
000000010000b154	jns	0x10000b140
000000010000b156	leal	0x3e(%rdi), %ecx
000000010000b159	cmpb	$0x1e, %cl
000000010000b15c	jae	0x10000b16f
000000010000b15e	movl	$0x80, %ecx
000000010000b163	movl	$0x1, %esi
000000010000b168	movl	$0x1f, %edx
000000010000b16d	jmp	0x10000b1a5
000000010000b16f	movl	%edi, %ecx
000000010000b171	andb	$-0x10, %cl
000000010000b174	cmpb	$-0x20, %cl
000000010000b177	jne	0x10000b18a
000000010000b179	movl	$0x800, %ecx                    ## imm = 0x800
000000010000b17e	movl	$0x2, %esi
000000010000b183	movl	$0xf, %edx
000000010000b188	jmp	0x10000b1a5
000000010000b18a	leal	0x10(%rdi), %ecx
000000010000b18d	cmpb	$0x4, %cl
000000010000b190	ja	0x10000b27a
000000010000b196	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000b19b	movl	$0x3, %esi
000000010000b1a0	movl	$0x7, %edx
000000010000b1a5	movl	%esi, %esi
000000010000b1a7	leaq	(%rax,%rsi), %r8
000000010000b1ab	cmpq	%rbx, %r8
000000010000b1ae	jae	0x10000b27a
000000010000b1b4	movzbl	0x1(%r14,%rax), %r8d
000000010000b1ba	movl	%r8d, %r9d
000000010000b1bd	andl	$-0x40, %r9d
000000010000b1c1	cmpl	$0x80, %r9d
000000010000b1c8	jne	0x10000b27a
000000010000b1ce	andl	%edi, %edx
000000010000b1d0	leal	0x1(%rsi), %r9d
000000010000b1d4	movl	%edx, %edi
000000010000b1d6	shll	$0x6, %edi
000000010000b1d9	andl	$0x3f, %r8d
000000010000b1dd	orl	%edi, %r8d
000000010000b1e0	cmpl	$0x2, %r9d
000000010000b1e4	jne	0x10000b1eb
000000010000b1e6	movl	%r8d, %r9d
000000010000b1e9	jmp	0x10000b237
000000010000b1eb	movzbl	0x2(%r14,%rax), %edx
000000010000b1f1	movl	%edx, %edi
000000010000b1f3	andl	$-0x40, %edi
000000010000b1f6	cmpl	$0x80, %edi
000000010000b1fc	jne	0x10000b27a
000000010000b1fe	movl	%r8d, %edi
000000010000b201	shll	$0x6, %edi
000000010000b204	andl	$0x3f, %edx
000000010000b207	orl	%edi, %edx
000000010000b209	cmpl	$0x3, %r9d
000000010000b20d	jne	0x10000b217
000000010000b20f	movl	%edx, %r9d
000000010000b212	movl	%r8d, %edx
000000010000b215	jmp	0x10000b237
000000010000b217	movzbl	0x3(%r14,%rax), %r9d
000000010000b21d	movl	%r9d, %edi
000000010000b220	andl	$-0x40, %edi
000000010000b223	cmpl	$0x80, %edi
000000010000b229	jne	0x10000b27a
000000010000b22b	movl	%edx, %edi
000000010000b22d	shll	$0x6, %edi
000000010000b230	andl	$0x3f, %r9d
000000010000b234	orl	%edi, %r9d
000000010000b237	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000b23d	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000b243	je	0x10000b27a
000000010000b245	cmpl	$0x10ffff, %edi                 ## imm = 0x10FFFF
000000010000b24b	ja	0x10000b27a
000000010000b24d	cmpl	%ecx, %r9d
000000010000b250	jb	0x10000b27a
000000010000b252	addq	%rsi, %rax
000000010000b255	incq	%rax
000000010000b258	cmpq	%rbx, %rax
000000010000b25b	jb	0x10000b14c
000000010000b261	movq	%r14, %rdi
000000010000b264	movq	%rbx, %rsi
000000010000b267	addq	$0x28, %rsp
000000010000b26b	popq	%rbx
000000010000b26c	popq	%r12
000000010000b26e	popq	%r13
000000010000b270	popq	%r14
000000010000b272	popq	%r15
000000010000b274	popq	%rbp
000000010000b275	jmp	_fwp_str_new
000000010000b27a	xorps	%xmm0, %xmm0
000000010000b27d	movaps	%xmm0, -0x50(%rbp)
000000010000b281	movq	$0x0, -0x40(%rbp)
000000010000b289	xorl	%r13d, %r13d
000000010000b28c	leaq	-0x50(%rbp), %r15
000000010000b290	jmp	0x10000b2c6
000000010000b292	nopw	%cs:(%rax,%rax)
000000010000b2a0	movb	%al, -0x29(%rbp)
000000010000b2a3	movl	$0x1, %edx
000000010000b2a8	movq	%r15, %rdi
000000010000b2ab	leaq	-0x29(%rbp), %rsi
000000010000b2af	callq	_buf_put
000000010000b2b4	incq	%r13
000000010000b2b7	movq	%r13, %r12
000000010000b2ba	movq	%r12, %r13
000000010000b2bd	cmpq	%rbx, %r12
000000010000b2c0	jae	0x10000b40d
000000010000b2c6	movzbl	(%r14,%r13), %eax
000000010000b2cb	testb	%al, %al
000000010000b2cd	jns	0x10000b2a0
000000010000b2cf	leal	0x20(%rax), %ecx
000000010000b2d2	cmpb	$-0x1f, %cl
000000010000b2d5	ja	0x10000b30b
000000010000b2d7	movl	%eax, %edx
000000010000b2d9	andb	$-0x10, %dl
000000010000b2dc	cmpb	$-0x20, %dl
000000010000b2df	jne	0x10000b3c9
000000010000b2e5	cmpb	$-0x20, %al
000000010000b2e7	sete	%sil
000000010000b2eb	shlb	$0x5, %sil
000000010000b2ef	orb	$-0x80, %sil
000000010000b2f3	xorl	%edi, %edi
000000010000b2f5	cmpb	$-0x13, %al
000000010000b2f7	setne	%dil
000000010000b2fb	shll	$0x5, %edi
000000010000b2fe	orl	$0x9f, %edi
000000010000b304	movl	$0x2, %eax
000000010000b309	jmp	0x10000b318
000000010000b30b	movl	$0xbf, %edi
000000010000b310	movb	$-0x80, %sil
000000010000b313	movl	$0x1, %eax
000000010000b318	xorl	%edx, %edx
000000010000b31a	leaq	0x1(%r13), %r12
000000010000b31e	cmpq	%rbx, %r12
000000010000b321	jae	0x10000b3b0
000000010000b327	movzbl	(%r14,%r12), %r8d
000000010000b32c	cmpb	%sil, %r8b
000000010000b32f	jb	0x10000b3b0
000000010000b331	cmpl	%r8d, %edi
000000010000b334	jb	0x10000b3b0
000000010000b336	cmpb	$-0x1e, %cl
000000010000b339	setae	%sil
000000010000b33d	leaq	0x2(%r13), %r12
000000010000b341	cmpq	%rbx, %r12
000000010000b344	setae	%dil
000000010000b348	movl	$0x1, %ecx
000000010000b34d	orb	%sil, %dil
000000010000b350	jne	0x10000b399
000000010000b352	movzbl	(%r14,%r12), %esi
000000010000b357	andb	$-0x40, %sil
000000010000b35b	negb	%sil
000000010000b35e	jno	0x10000b399
000000010000b360	leaq	0x3(%r13), %r12
000000010000b364	cmpq	%rbx, %r12
000000010000b367	setae	%sil
000000010000b36b	xorb	$0x1, %dl
000000010000b36e	movl	$0x2, %ecx
000000010000b373	orb	%sil, %dl
000000010000b376	jne	0x10000b399
000000010000b378	movzbl	0x3(%r14,%r13), %esi
000000010000b37e	andb	$-0x40, %sil
000000010000b382	xorl	%ecx, %ecx
000000010000b384	cmpb	$-0x80, %sil
000000010000b388	sete	%dl
000000010000b38b	negb	%sil
000000010000b38e	jno	0x10000b394
000000010000b390	leaq	0x4(%r13), %r12
000000010000b394	movb	%dl, %cl
000000010000b396	orl	$0x2, %ecx
000000010000b399	cmpl	%eax, %ecx
000000010000b39b	jne	0x10000b3b0
000000010000b39d	leaq	(%r14,%r13), %rsi
000000010000b3a1	movq	%r12, %rdx
000000010000b3a4	subq	%r13, %rdx
000000010000b3a7	movq	%r15, %rdi
000000010000b3aa	jmp	0x10000b3bf
000000010000b3ac	nopl	(%rax)
000000010000b3b0	movl	$0x3, %edx
000000010000b3b5	movq	%r15, %rdi
000000010000b3b8	leaq	0x8c28(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000b3bf	callq	_buf_put
000000010000b3c4	jmp	0x10000b2ba
000000010000b3c9	leal	0x10(%rax), %edx
000000010000b3cc	cmpb	$0x4, %dl
000000010000b3cf	ja	0x10000b3f9
000000010000b3d1	cmpb	$-0x10, %al
000000010000b3d3	sete	%sil
000000010000b3d7	movl	$0x8f, %edi
000000010000b3dc	cmpb	$-0xc, %al
000000010000b3de	je	0x10000b3e5
000000010000b3e0	movl	$0xbf, %edi
000000010000b3e5	shlb	$0x4, %sil
000000010000b3e9	orb	$-0x80, %sil
000000010000b3ed	movl	$0x3, %eax
000000010000b3f2	movb	$0x1, %dl
000000010000b3f4	jmp	0x10000b31a
000000010000b3f9	movl	$0x3, %edx
000000010000b3fe	movq	%r15, %rdi
000000010000b401	leaq	0x8bdf(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000b408	jmp	0x10000b2af
000000010000b40d	movq	-0x50(%rbp), %rbx
000000010000b411	movq	-0x48(%rbp), %rsi
000000010000b415	testq	%rbx, %rbx
000000010000b418	leaq	0x7f13(%rip), %rdi              ## literal pool for: ""
000000010000b41f	cmovneq	%rbx, %rdi
000000010000b423	callq	_fwp_str_new
000000010000b428	movq	%rax, %r14
000000010000b42b	movq	%rbx, %rdi
000000010000b42e	callq	0x100012c72                     ## symbol stub for: _free
000000010000b433	movq	%r14, %rax
000000010000b436	addq	$0x28, %rsp
000000010000b43a	popq	%rbx
000000010000b43b	popq	%r12
000000010000b43d	popq	%r13
000000010000b43f	popq	%r14
000000010000b441	popq	%r15
000000010000b443	popq	%rbp
000000010000b444	retq
000000010000b445	nopw	%cs:(%rax,%rax)
_fwp_alloc_leaf:
000000010000b450	pushq	%rbp
000000010000b451	movq	%rsp, %rbp
000000010000b454	pushq	%rbx
000000010000b455	pushq	%rax
000000010000b456	movq	%rdi, %rsi
000000010000b459	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000b460	ja	0x10000b4bb
000000010000b462	leaq	0xf(%rsi), %rax
000000010000b466	shrq	$0x4, %rax
000000010000b46a	leaq	_fwp_gc(%rip), %rcx
000000010000b471	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b479	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b480	subq	%rax, _fwp_gc(%rip)
000000010000b487	js	0x10000b4bb
000000010000b489	leaq	(%rdx,%rdx,2), %rdx
000000010000b48d	leaq	(%rcx,%rdx,8), %rcx
000000010000b491	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b498	movq	(%rcx), %rbx
000000010000b49b	testq	%rbx, %rbx
000000010000b49e	je	0x10000b4ab
000000010000b4a0	movq	(%rbx), %rax
000000010000b4a3	notq	%rax
000000010000b4a6	movq	%rax, (%rcx)
000000010000b4a9	jmp	0x10000b4d5
000000010000b4ab	movq	0x8(%rcx), %rbx
000000010000b4af	movq	0x10(%rcx), %rdx
000000010000b4b3	subq	%rbx, %rdx
000000010000b4b6	cmpq	%rax, %rdx
000000010000b4b9	jae	0x10000b4ce
000000010000b4bb	movq	%rsi, %rdi
000000010000b4be	movl	$0x1, %esi
000000010000b4c3	addq	$0x8, %rsp
000000010000b4c7	popq	%rbx
000000010000b4c8	popq	%rbp
000000010000b4c9	jmp	_fwp_gc_alloc_slow
000000010000b4ce	addq	%rbx, %rax
000000010000b4d1	movq	%rax, 0x8(%rcx)
000000010000b4d5	movq	%rbx, %rdi
000000010000b4d8	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000b4dd	movq	%rbx, %rax
000000010000b4e0	addq	$0x8, %rsp
000000010000b4e4	popq	%rbx
000000010000b4e5	popq	%rbp
000000010000b4e6	retq
000000010000b4e7	nopw	(%rax,%rax)
_fwp_exec_call:
000000010000b4f0	pushq	%rbp
000000010000b4f1	movq	%rsp, %rbp
000000010000b4f4	pushq	%r15
000000010000b4f6	pushq	%r14
000000010000b4f8	pushq	%r13
000000010000b4fa	pushq	%r12
000000010000b4fc	pushq	%rbx
000000010000b4fd	subq	$0xd8, %rsp
000000010000b504	movq	%rsi, %rbx
000000010000b507	movq	%rdi, %r14
000000010000b50a	movq	_fwp_handlers(%rip), %rax
000000010000b511	movq	%rax, -0x68(%rbp)
000000010000b515	movq	$0x0, -0x50(%rbp)
000000010000b51d	movq	_fwp_cleanups(%rip), %rax
000000010000b524	movq	%rax, -0x48(%rbp)
000000010000b528	leaq	-0x100(%rbp), %rdi
000000010000b52f	movq	%rdi, _fwp_handlers(%rip)
000000010000b536	callq	0x100012cf0                     ## symbol stub for: _setjmp
000000010000b53b	testl	%eax, %eax
000000010000b53d	je	0x10000b62b
000000010000b543	movq	-0x68(%rbp), %rax
000000010000b547	movq	%rax, _fwp_handlers(%rip)
000000010000b54e	movq	_fwp_prog_out(%rip), %rdi
000000010000b555	testq	%rdi, %rdi
000000010000b558	je	0x10000b55f
000000010000b55a	callq	0x100012c4e                     ## symbol stub for: _fflush
000000010000b55f	movq	0x9ae2(%rip), %r12              ## literal pool symbol address: ___stdoutp
000000010000b566	movq	(%r12), %rdi
000000010000b56a	callq	0x100012c4e                     ## symbol stub for: _fflush
000000010000b56f	movq	-0x60(%rbp), %r14
000000010000b573	movq	-0x58(%rbp), %r15
000000010000b577	movq	(%r12), %rdi
000000010000b57b	callq	0x100012c4e                     ## symbol stub for: _fflush
000000010000b580	movq	0x9ab1(%rip), %r13              ## literal pool symbol address: ___stderrp
000000010000b587	movq	(%r13), %rdi
000000010000b58b	leaq	0x8b0e(%rip), %rsi              ## literal pool for: "%s: "
000000010000b592	leaq	0x7d9d(%rip), %rdx              ## literal pool for: "reduce64"
000000010000b599	xorl	%eax, %eax
000000010000b59b	callq	0x100012c5a                     ## symbol stub for: _fprintf
000000010000b5a0	cmpl	$0x10, (%r15)
000000010000b5a4	jne	0x10000b5e4
000000010000b5a6	movq	0x8(%r15), %rdi
000000010000b5aa	testq	%rdi, %rdi
000000010000b5ad	je	0x10000b5e4
000000010000b5af	leaq	0x8aef(%rip), %rsi              ## literal pool for: "IoError"
000000010000b5b6	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000b5bb	testl	%eax, %eax
000000010000b5bd	jne	0x10000b5e4
000000010000b5bf	cmpl	$0x2, 0x10(%r15)
000000010000b5c4	jne	0x10000b5e4
000000010000b5c6	movq	0x10(%r14), %rdi
000000010000b5ca	movq	(%rdi), %rdx
000000010000b5cd	addq	$0x8, %rdi
000000010000b5d1	movq	(%r13), %rcx
000000010000b5d5	movl	$0x1, %esi
000000010000b5da	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000b5df	jmp	0x10000b675
000000010000b5e4	movq	(%r13), %r12
000000010000b5e8	xorps	%xmm0, %xmm0
000000010000b5eb	movaps	%xmm0, -0x40(%rbp)
000000010000b5ef	movq	$0x0, -0x30(%rbp)
000000010000b5f7	leaq	-0x40(%rbp), %rdi
000000010000b5fb	movq	%r14, %rsi
000000010000b5fe	movq	%r15, %rdx
000000010000b601	movl	$0x1, %ecx
000000010000b606	callq	_fwp_write
000000010000b60b	movq	-0x40(%rbp), %rdi
000000010000b60f	testq	%rdi, %rdi
000000010000b612	je	0x10000b66c
000000010000b614	movq	-0x38(%rbp), %rdx
000000010000b618	movl	$0x1, %esi
000000010000b61d	movq	%r12, %rcx
000000010000b620	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000b625	movq	-0x40(%rbp), %rdi
000000010000b629	jmp	0x10000b670
000000010000b62b	leaq	_fwp_gc(%rip), %rax
000000010000b632	movzbl	0xb5b8(%rip), %ecx
000000010000b639	movl	0xb48(%rax,%rcx,4), %edx
000000010000b640	movl	%edx, %esi
000000010000b642	subq	%rsi, _fwp_gc(%rip)
000000010000b649	js	0x10000b69c
000000010000b64b	leaq	(%rcx,%rcx,2), %rcx
000000010000b64f	leaq	(%rax,%rcx,8), %rax
000000010000b653	addq	$0x788, %rax                    ## imm = 0x788
000000010000b659	movq	(%rax), %r15
000000010000b65c	testq	%r15, %r15
000000010000b65f	je	0x10000b68c
000000010000b661	movq	(%r15), %rcx
000000010000b664	notq	%rcx
000000010000b667	movq	%rcx, (%rax)
000000010000b66a	jmp	0x10000b6b8
000000010000b66c	xorl	%eax, %eax
000000010000b66e	movl	%eax, %edi
000000010000b670	callq	0x100012c72                     ## symbol stub for: _free
000000010000b675	movq	(%r13), %rsi
000000010000b679	movl	$0xa, %edi
000000010000b67e	callq	0x100012c60                     ## symbol stub for: _fputc
000000010000b683	movl	$0x1, %ecx
000000010000b688	xorl	%eax, %eax
000000010000b68a	jmp	0x10000b6e4
000000010000b68c	movq	0x8(%rax), %r15
000000010000b690	movq	0x10(%rax), %rcx
000000010000b694	subq	%r15, %rcx
000000010000b697	cmpq	%rsi, %rcx
000000010000b69a	jae	0x10000b6b0
000000010000b69c	movl	$0x8, %edi
000000010000b6a1	movl	$0x2, %esi
000000010000b6a6	callq	_fwp_gc_alloc_slow
000000010000b6ab	movq	%rax, %rdi
000000010000b6ae	jmp	0x10000b6c3
000000010000b6b0	leaq	(%r15,%rsi), %rcx
000000010000b6b4	movq	%rcx, 0x8(%rax)
000000010000b6b8	movq	%r15, %rdi
000000010000b6bb	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000b6c0	movq	%r15, %rdi
000000010000b6c3	movq	$0x0, (%rdi)
000000010000b6ca	movl	$0x1, %esi
000000010000b6cf	movq	%r14, %rdx
000000010000b6d2	callq	_fwp_apply
000000010000b6d7	movq	-0x68(%rbp), %rcx
000000010000b6db	movq	%rcx, _fwp_handlers(%rip)
000000010000b6e2	xorl	%ecx, %ecx
000000010000b6e4	movl	%ecx, (%rbx)
000000010000b6e6	addq	$0xd8, %rsp
000000010000b6ed	popq	%rbx
000000010000b6ee	popq	%r12
000000010000b6f0	popq	%r13
000000010000b6f2	popq	%r14
000000010000b6f4	popq	%r15
000000010000b6f6	popq	%rbp
000000010000b6f7	retq
000000010000b6f8	nopl	(%rax,%rax)
_fwp_emit_result:
000000010000b700	pushq	%rbp
000000010000b701	movq	%rsp, %rbp
000000010000b704	pushq	%r14
000000010000b706	pushq	%rbx
000000010000b707	subq	$0x20, %rsp
000000010000b70b	movq	%rdi, %rsi
000000010000b70e	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000b715	je	0x10000b782
000000010000b717	xorps	%xmm0, %xmm0
000000010000b71a	movaps	%xmm0, -0x30(%rbp)
000000010000b71e	movq	$0x0, -0x20(%rbp)
000000010000b726	leaq	_d0(%rip), %rdx
000000010000b72d	leaq	-0x30(%rbp), %rdi
000000010000b731	callq	_fwp_encode
000000010000b736	movb	$0x1, -0x15(%rbp)
000000010000b73a	movl	-0x28(%rbp), %eax
000000010000b73d	movl	%eax, -0x14(%rbp)
000000010000b740	movq	0x9901(%rip), %rbx              ## literal pool symbol address: ___stdoutp
000000010000b747	movq	(%rbx), %rcx
000000010000b74a	leaq	-0x15(%rbp), %rdi
000000010000b74e	movl	$0x1, %esi
000000010000b753	movl	$0x5, %edx
000000010000b758	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000b75d	movq	-0x28(%rbp), %rdx
000000010000b761	testq	%rdx, %rdx
000000010000b764	je	0x10000b777
000000010000b766	movq	-0x30(%rbp), %rdi
000000010000b76a	movq	(%rbx), %rcx
000000010000b76d	movl	$0x1, %esi
000000010000b772	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000b777	movq	-0x30(%rbp), %rdi
000000010000b77b	callq	0x100012c72                     ## symbol stub for: _free
000000010000b780	jmp	0x10000b800
000000010000b782	cmpl	$0x10, _d0(%rip)
000000010000b789	jne	0x10000b79e
000000010000b78b	cmpl	$0x0, 0xc36e(%rip)
000000010000b792	jne	0x10000b79e
000000010000b794	cmpq	$0x0, 0xc35c(%rip)
000000010000b79c	je	0x10000b800
000000010000b79e	movq	0x98a3(%rip), %r14              ## literal pool symbol address: ___stdoutp
000000010000b7a5	movq	(%r14), %rbx
000000010000b7a8	xorps	%xmm0, %xmm0
000000010000b7ab	movaps	%xmm0, -0x30(%rbp)
000000010000b7af	movq	$0x0, -0x20(%rbp)
000000010000b7b7	leaq	_d0(%rip), %rdx
000000010000b7be	leaq	-0x30(%rbp), %rdi
000000010000b7c2	movl	$0x1, %ecx
000000010000b7c7	callq	_fwp_write
000000010000b7cc	movq	-0x30(%rbp), %rdi
000000010000b7d0	testq	%rdi, %rdi
000000010000b7d3	je	0x10000b7ec
000000010000b7d5	movq	-0x28(%rbp), %rdx
000000010000b7d9	movl	$0x1, %esi
000000010000b7de	movq	%rbx, %rcx
000000010000b7e1	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000b7e6	movq	-0x30(%rbp), %rdi
000000010000b7ea	jmp	0x10000b7ee
000000010000b7ec	xorl	%edi, %edi
000000010000b7ee	callq	0x100012c72                     ## symbol stub for: _free
000000010000b7f3	movq	(%r14), %rsi
000000010000b7f6	movl	$0xa, %edi
000000010000b7fb	callq	0x100012c60                     ## symbol stub for: _fputc
000000010000b800	addq	$0x20, %rsp
000000010000b804	popq	%rbx
000000010000b805	popq	%r14
000000010000b807	popq	%rbp
000000010000b808	retq
000000010000b809	nopl	(%rax)
_fwp_read_exact:
000000010000b810	pushq	%rbp
000000010000b811	movq	%rsp, %rbp
000000010000b814	pushq	%r15
000000010000b816	pushq	%r14
000000010000b818	pushq	%r12
000000010000b81a	pushq	%rbx
000000010000b81b	movq	%rsi, %rbx
000000010000b81e	movq	%rdi, %r14
000000010000b821	movl	_fwp_in_npend(%rip), %eax
000000010000b827	movl	_fwp_in_ppos(%rip), %ecx
000000010000b82d	testq	%rsi, %rsi
000000010000b830	setne	%dl
000000010000b833	cmpl	%eax, %ecx
000000010000b835	setl	%sil
000000010000b839	testb	%sil, %dl
000000010000b83c	je	0x10000b8aa
000000010000b83e	cltq
000000010000b840	movslq	%ecx, %rsi
000000010000b843	movq	%rsi, %rdx
000000010000b846	notq	%rdx
000000010000b849	addq	%rax, %rdx
000000010000b84c	leaq	-0x1(%rbx), %rcx
000000010000b850	cmpq	%rcx, %rdx
000000010000b853	cmovaeq	%rcx, %rdx
000000010000b857	incq	%rdx
000000010000b85a	cmpq	$0x1f, %rdx
000000010000b85e	jbe	0x10000b876
000000010000b860	leaq	_fwp_in_pend(%rip), %rdi
000000010000b867	movq	%r14, %r8
000000010000b86a	subq	%rsi, %r8
000000010000b86d	subq	%rdi, %r8
000000010000b870	cmpq	$0x20, %r8
000000010000b874	jae	0x10000b8af
000000010000b876	xorl	%r15d, %r15d
000000010000b879	movq	%rsi, %rcx
000000010000b87c	leaq	_fwp_in_pend(%rip), %rdx
000000010000b883	nopw	%cs:(%rax,%rax)
000000010000b890	movzbl	(%rcx,%rdx), %esi
000000010000b894	incq	%rcx
000000010000b897	movb	%sil, (%r14,%r15)
000000010000b89b	incq	%r15
000000010000b89e	cmpq	%rbx, %r15
000000010000b8a1	jae	0x10000b8f2
000000010000b8a3	cmpq	%rax, %rcx
000000010000b8a6	jl	0x10000b890
000000010000b8a8	jmp	0x10000b8f2
000000010000b8aa	xorl	%r15d, %r15d
000000010000b8ad	jmp	0x10000b8f8
000000010000b8af	movq	%rdx, %r15
000000010000b8b2	andq	$-0x20, %r15
000000010000b8b6	leaq	(%r15,%rsi), %rcx
000000010000b8ba	addq	%rdi, %rsi
000000010000b8bd	addq	$0x10, %rsi
000000010000b8c1	xorl	%edi, %edi
000000010000b8c3	nopw	%cs:(%rax,%rax)
000000010000b8d0	movups	-0x10(%rsi,%rdi), %xmm0
000000010000b8d5	movups	(%rsi,%rdi), %xmm1
000000010000b8d9	movups	%xmm0, (%r14,%rdi)
000000010000b8de	movups	%xmm1, 0x10(%r14,%rdi)
000000010000b8e4	addq	$0x20, %rdi
000000010000b8e8	cmpq	%rdi, %r15
000000010000b8eb	jne	0x10000b8d0
000000010000b8ed	cmpq	%r15, %rdx
000000010000b8f0	jne	0x10000b87c
000000010000b8f2	movl	%ecx, _fwp_in_ppos(%rip)
000000010000b8f8	movq	0x9741(%rip), %r12              ## literal pool symbol address: ___stdinp
000000010000b8ff	nop
000000010000b900	movq	%rbx, %rdx
000000010000b903	subq	%r15, %rdx
000000010000b906	jbe	0x10000b926
000000010000b908	leaq	(%r14,%r15), %rdi
000000010000b90c	movq	(%r12), %rcx
000000010000b910	movl	$0x1, %esi
000000010000b915	callq	0x100012c6c                     ## symbol stub for: _fread
000000010000b91a	addq	%rax, %r15
000000010000b91d	testq	%rax, %rax
000000010000b920	jne	0x10000b900
000000010000b922	xorl	%eax, %eax
000000010000b924	jmp	0x10000b92b
000000010000b926	movl	$0x1, %eax
000000010000b92b	popq	%rbx
000000010000b92c	popq	%r12
000000010000b92e	popq	%r14
000000010000b930	popq	%r15
000000010000b932	popq	%rbp
000000010000b933	retq
000000010000b934	nopw	%cs:(%rax,%rax)
_fwp_stdin_leb:
000000010000b940	pushq	%rbp
000000010000b941	movq	%rsp, %rbp
000000010000b944	pushq	%r15
000000010000b946	pushq	%r14
000000010000b948	pushq	%r13
000000010000b94a	pushq	%r12
000000010000b94c	pushq	%rbx
000000010000b94d	pushq	%rax
000000010000b94e	movq	%rdi, %rbx
000000010000b951	movq	$0x0, (%rdi)
000000010000b958	movq	$-0x7, %r14
000000010000b95f	leaq	_fwp_in_pend(%rip), %r12
000000010000b966	movq	0x96d3(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000b96d	leaq	-0x29(%rbp), %r15
000000010000b971	nopw	%cs:(%rax,%rax)
000000010000b980	movslq	_fwp_in_ppos(%rip), %rax
000000010000b987	cmpl	_fwp_in_npend(%rip), %eax
000000010000b98d	jge	0x10000b9b0
000000010000b98f	leal	0x1(%rax), %ecx
000000010000b992	movzbl	(%rax,%r12), %eax
000000010000b997	movb	%al, -0x29(%rbp)
000000010000b99a	movl	%ecx, _fwp_in_ppos(%rip)
000000010000b9a0	jmp	0x10000b9cb
000000010000b9a2	nopw	%cs:(%rax,%rax)
000000010000b9b0	movq	(%r13), %rcx
000000010000b9b4	movl	$0x1, %esi
000000010000b9b9	movl	$0x1, %edx
000000010000b9be	movq	%r15, %rdi
000000010000b9c1	callq	0x100012c6c                     ## symbol stub for: _fread
000000010000b9c6	testq	%rax, %rax
000000010000b9c9	je	0x10000ba0c
000000010000b9cb	cmpq	$0x38, %r14
000000010000b9cf	setne	%cl
000000010000b9d2	movzbl	-0x29(%rbp), %eax
000000010000b9d6	testb	$0x7e, %al
000000010000b9d8	sete	%dl
000000010000b9db	orb	%cl, %dl
000000010000b9dd	je	0x10000b9fe
000000010000b9df	addq	$0x7, %r14
000000010000b9e3	movzbl	%al, %eax
000000010000b9e6	movl	%eax, %edx
000000010000b9e8	andl	$0x7f, %edx
000000010000b9eb	movl	%r14d, %ecx
000000010000b9ee	shlq	%cl, %rdx
000000010000b9f1	orq	%rdx, (%rbx)
000000010000b9f4	testb	%al, %al
000000010000b9f6	jns	0x10000ba05
000000010000b9f8	cmpq	$0x38, %r14
000000010000b9fc	jbe	0x10000b980
000000010000b9fe	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ba03	jmp	0x10000ba0e
000000010000ba05	movl	$0x1, %eax
000000010000ba0a	jmp	0x10000ba0e
000000010000ba0c	xorl	%eax, %eax
000000010000ba0e	addq	$0x8, %rsp
000000010000ba12	popq	%rbx
000000010000ba13	popq	%r12
000000010000ba15	popq	%r13
000000010000ba17	popq	%r14
000000010000ba19	popq	%r15
000000010000ba1b	popq	%rbp
000000010000ba1c	retq
000000010000ba1d	nopl	(%rax)
_fwp_stdin_name_len:
000000010000ba20	pushq	%rbp
000000010000ba21	movq	%rsp, %rbp
000000010000ba24	pushq	%r15
000000010000ba26	pushq	%r14
000000010000ba28	pushq	%r13
000000010000ba2a	pushq	%r12
000000010000ba2c	pushq	%rbx
000000010000ba2d	pushq	%rax
000000010000ba2e	movq	%rdi, %rbx
000000010000ba31	movq	$0x0, (%rdi)
000000010000ba38	movq	$-0x7, %r14
000000010000ba3f	leaq	_fwp_in_pend(%rip), %r12
000000010000ba46	movq	0x95f3(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000ba4d	leaq	-0x29(%rbp), %r15
000000010000ba51	nopw	%cs:(%rax,%rax)
000000010000ba60	movslq	_fwp_in_ppos(%rip), %rax
000000010000ba67	cmpl	_fwp_in_npend(%rip), %eax
000000010000ba6d	jge	0x10000ba90
000000010000ba6f	leal	0x1(%rax), %ecx
000000010000ba72	movzbl	(%rax,%r12), %eax
000000010000ba77	movb	%al, -0x29(%rbp)
000000010000ba7a	movl	%ecx, _fwp_in_ppos(%rip)
000000010000ba80	jmp	0x10000baab
000000010000ba82	nopw	%cs:(%rax,%rax)
000000010000ba90	movq	(%r13), %rcx
000000010000ba94	movl	$0x1, %esi
000000010000ba99	movl	$0x1, %edx
000000010000ba9e	movq	%r15, %rdi
000000010000baa1	callq	0x100012c6c                     ## symbol stub for: _fread
000000010000baa6	testq	%rax, %rax
000000010000baa9	je	0x10000bb01
000000010000baab	cmpq	$0x38, %r14
000000010000baaf	setne	%cl
000000010000bab2	movzbl	-0x29(%rbp), %eax
000000010000bab6	testb	$0x7e, %al
000000010000bab8	sete	%dl
000000010000babb	orb	%cl, %dl
000000010000babd	je	0x10000bae5
000000010000babf	addq	$0x7, %r14
000000010000bac3	movzbl	%al, %eax
000000010000bac6	movl	%eax, %edx
000000010000bac8	andl	$0x7f, %edx
000000010000bacb	movl	%r14d, %ecx
000000010000bace	shlq	%cl, %rdx
000000010000bad1	orq	(%rbx), %rdx
000000010000bad4	movq	%rdx, (%rbx)
000000010000bad7	testb	%al, %al
000000010000bad9	jns	0x10000baec
000000010000badb	cmpq	$0x38, %r14
000000010000badf	jbe	0x10000ba60
000000010000bae5	movl	$0xffffffff, %ecx               ## imm = 0xFFFFFFFF
000000010000baea	jmp	0x10000bb03
000000010000baec	movl	$0x1, %ecx
000000010000baf1	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000baf6	cmpq	$0x100000, %rdx                 ## imm = 0x100000
000000010000bafd	jbe	0x10000bb03
000000010000baff	jmp	0x10000bb05
000000010000bb01	xorl	%ecx, %ecx
000000010000bb03	movl	%ecx, %eax
000000010000bb05	addq	$0x8, %rsp
000000010000bb09	popq	%rbx
000000010000bb0a	popq	%r12
000000010000bb0c	popq	%r13
000000010000bb0e	popq	%r14
000000010000bb10	popq	%r15
000000010000bb12	popq	%rbp
000000010000bb13	retq
000000010000bb14	nopw	%cs:(%rax,%rax)
_fwp_decode:
000000010000bb20	pushq	%rbp
000000010000bb21	movq	%rsp, %rbp
000000010000bb24	pushq	%r15
000000010000bb26	pushq	%r14
000000010000bb28	pushq	%r13
000000010000bb2a	pushq	%r12
000000010000bb2c	pushq	%rbx
000000010000bb2d	subq	$0x48, %rsp
000000010000bb31	movq	0x94f8(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000bb38	movq	(%rax), %rax
000000010000bb3b	movq	%rax, -0x30(%rbp)
000000010000bb3f	movl	(%rsi), %eax
000000010000bb41	xorl	%r8d, %r8d
000000010000bb44	cmpq	$0x15, %rax
000000010000bb48	ja	0x10000c0c7
000000010000bb4e	movq	%rdx, %r9
000000010000bb51	movq	%rsi, %r15
000000010000bb54	movq	%rdi, %r14
000000010000bb57	leaq	0x84e(%rip), %rcx
000000010000bb5e	movslq	(%rcx,%rax,4), %rdx
000000010000bb62	addq	%rcx, %rdx
000000010000bb65	jmpq	*%rdx
000000010000bb67	xorl	%ecx, %ecx
000000010000bb69	cmpl	$0xa, %eax
000000010000bb6c	setne	%cl
000000010000bb6f	leaq	0x4(,%rcx,4), %rax
000000010000bb77	movq	0x8(%r14), %rdx
000000010000bb7b	movq	0x10(%r14), %rcx
000000010000bb7f	subq	%rcx, %rdx
000000010000bb82	cmpq	%rax, %rdx
000000010000bb85	jb	0x10000c0c7
000000010000bb8b	movq	(%r14), %rdx
000000010000bb8e	addq	%rcx, %rdx
000000010000bb91	addq	%rax, %rcx
000000010000bb94	movq	%rcx, 0x10(%r14)
000000010000bb98	cmpq	$0x8, %rax
000000010000bb9c	jae	0x10000bba4
000000010000bb9e	xorl	%esi, %esi
000000010000bba0	xorl	%edi, %edi
000000010000bba2	jmp	0x10000bc09
000000010000bba4	movl	%eax, %esi
000000010000bba6	andl	$-0x8, %esi
000000010000bba9	pmovzxbq	0x2(%rdx), %xmm0
000000010000bbaf	pmovzxbq	0x6(%rdx), %xmm1
000000010000bbb5	pmovzxbq	0x4(%rdx), %xmm2
000000010000bbbb	pmovzxbq	(%rdx), %xmm3
000000010000bbc0	movdqa	%xmm3, %xmm4
000000010000bbc4	psllq	$0x8, %xmm4
000000010000bbc9	pshufb	0x726e(%rip), %xmm2
000000010000bbd2	pblendw	$0xf, %xmm3, %xmm4              ## xmm4 = xmm3[0,1,2,3],xmm4[4,5,6,7]
000000010000bbd8	por	%xmm4, %xmm2
000000010000bbdc	pshufb	0x726b(%rip), %xmm1
000000010000bbe5	pshufb	0x7272(%rip), %xmm0
000000010000bbee	por	%xmm1, %xmm0
000000010000bbf2	por	%xmm2, %xmm0
000000010000bbf6	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000bbfb	por	%xmm0, %xmm1
000000010000bbff	movq	%xmm1, %rdi
000000010000bc04	cmpq	%rsi, %rax
000000010000bc07	je	0x10000bc27
000000010000bc09	leal	(,%rsi,8), %ecx
000000010000bc10	movzbl	(%rdx,%rsi), %r8d
000000010000bc15	shlq	%cl, %r8
000000010000bc18	orq	%r8, %rdi
000000010000bc1b	incq	%rsi
000000010000bc1e	addq	$0x8, %rcx
000000010000bc22	cmpq	%rsi, %rax
000000010000bc25	jne	0x10000bc10
000000010000bc27	movq	%rdi, (%r9)
000000010000bc2a	movl	$0x1, %r8d
000000010000bc30	jmp	0x10000c0c7
000000010000bc35	movq	%r9, %r12
000000010000bc38	leaq	-0x58(%rbp), %rsi
000000010000bc3c	movq	%r14, %rdi
000000010000bc3f	callq	_rd_leb
000000010000bc44	testl	%eax, %eax
000000010000bc46	je	0x10000c0c4
000000010000bc4c	movq	-0x58(%rbp), %rbx
000000010000bc50	movq	0x8(%r14), %rcx
000000010000bc54	cmpq	%rcx, %rbx
000000010000bc57	movl	$0x0, %r8d
000000010000bc5d	ja	0x10000c0c7
000000010000bc63	movq	0x10(%r14), %rax
000000010000bc67	subq	%rax, %rcx
000000010000bc6a	cmpq	%rbx, %rcx
000000010000bc6d	jb	0x10000c0c7
000000010000bc73	movq	(%r14), %r13
000000010000bc76	addq	%rax, %r13
000000010000bc79	addq	%rbx, %rax
000000010000bc7c	movq	%rax, 0x10(%r14)
000000010000bc80	cmpl	$0xc, (%r15)
000000010000bc84	movq	%r12, %rcx
000000010000bc87	jne	0x10000bca2
000000010000bc89	movq	%r13, %rdi
000000010000bc8c	movq	%rbx, %rsi
000000010000bc8f	callq	_fwp_valid_utf8
000000010000bc94	xorl	%r8d, %r8d
000000010000bc97	movq	%r12, %rcx
000000010000bc9a	testl	%eax, %eax
000000010000bc9c	je	0x10000c0c7
000000010000bca2	movq	%r13, %rdi
000000010000bca5	movq	%rbx, %rsi
000000010000bca8	movq	%rcx, %rbx
000000010000bcab	callq	_fwp_str_new
000000010000bcb0	movq	%rax, (%rbx)
000000010000bcb3	jmp	0x10000bc2a
000000010000bcb8	movq	0x10(%r14), %rax
000000010000bcbc	cmpq	%rax, 0x8(%r14)
000000010000bcc0	je	0x10000c0c7
000000010000bcc6	movq	(%r14), %rcx
000000010000bcc9	leaq	0x1(%rax), %rdx
000000010000bccd	movq	%rdx, 0x10(%r14)
000000010000bcd1	movsbq	(%rcx,%rax), %rax
000000010000bcd6	movq	%rax, (%r9)
000000010000bcd9	jmp	0x10000bc2a
000000010000bcde	movq	0x8(%r14), %rsi
000000010000bce2	movq	0x10(%r14), %rcx
000000010000bce6	movq	%rsi, %rdx
000000010000bce9	subq	%rcx, %rdx
000000010000bcec	cmpq	$0x8, %rdx
000000010000bcf0	jb	0x10000c0c7
000000010000bcf6	movq	(%r14), %rdx
000000010000bcf9	leaq	0x8(%rcx), %rdi
000000010000bcfd	movq	%rdi, 0x10(%r14)
000000010000bd01	subq	%rdi, %rsi
000000010000bd04	cmpq	$0x8, %rsi
000000010000bd08	jb	0x10000c0c7
000000010000bd0e	movq	%r9, %rbx
000000010000bd11	movq	(%rdx,%rcx), %rdi
000000010000bd15	leaq	0x10(%rcx), %rsi
000000010000bd19	movq	%rsi, 0x10(%r14)
000000010000bd1d	movq	0x8(%rdx,%rcx), %rsi
000000010000bd22	cmpl	$0x4, %eax
000000010000bd25	jne	0x10000c0ad
000000010000bd2b	callq	_fwp_box_i128
000000010000bd30	movq	%rax, (%rbx)
000000010000bd33	jmp	0x10000bc2a
000000010000bd38	movq	%r9, -0x50(%rbp)
000000010000bd3c	movq	0x38(%r15), %rbx
000000010000bd40	leaq	-0x58(%rbp), %rsi
000000010000bd44	movq	%r14, %rdi
000000010000bd47	callq	_rd_leb
000000010000bd4c	testl	%eax, %eax
000000010000bd4e	je	0x10000c0c4
000000010000bd54	movq	-0x58(%rbp), %r12
000000010000bd58	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000bd62	cmpq	%rax, %r12
000000010000bd65	movl	$0x0, %r8d
000000010000bd6b	ja	0x10000c0c7
000000010000bd71	movq	%rbx, %rdi
000000010000bd74	xorl	%esi, %esi
000000010000bd76	callq	_fwp_wire_empty_inner
000000010000bd7b	xorl	%r8d, %r8d
000000010000bd7e	testl	%eax, %eax
000000010000bd80	jne	0x10000bd8c
000000010000bd82	cmpq	0x8(%r14), %r12
000000010000bd86	ja	0x10000c0c7
000000010000bd8c	cmpl	$0x11, (%r15)
000000010000bd90	jne	0x10000c044
000000010000bd96	movq	0x38(%r15), %rsi
000000010000bd9a	movq	%r12, %rdi
000000010000bd9d	callq	_fwp_array_new_packed
000000010000bda2	movq	%rax, %r13
000000010000bda5	testq	%r12, %r12
000000010000bda8	je	0x10000bddf
000000010000bdaa	xorl	%ebx, %ebx
000000010000bdac	movq	0x38(%r15), %rsi
000000010000bdb0	movq	%r14, %rdi
000000010000bdb3	leaq	-0x40(%rbp), %rdx
000000010000bdb7	callq	_fwp_decode
000000010000bdbc	testl	%eax, %eax
000000010000bdbe	je	0x10000c0c4
000000010000bdc4	movq	-0x40(%rbp), %rdx
000000010000bdc8	movq	0x38(%r15), %rcx
000000010000bdcc	movq	%r13, %rdi
000000010000bdcf	movq	%rbx, %rsi
000000010000bdd2	callq	_fwp_array_store
000000010000bdd7	incq	%rbx
000000010000bdda	cmpq	%rbx, %r12
000000010000bddd	jne	0x10000bdac
000000010000bddf	movq	-0x50(%rbp), %rax
000000010000bde3	movq	%r13, (%rax)
000000010000bde6	jmp	0x10000bc2a
000000010000bdeb	movq	%r9, -0x50(%rbp)
000000010000bdef	leaq	-0x58(%rbp), %rsi
000000010000bdf3	movq	%r14, %rdi
000000010000bdf6	callq	_rd_leb
000000010000bdfb	testl	%eax, %eax
000000010000bdfd	je	0x10000c0c4
000000010000be03	movq	-0x58(%rbp), %r13
000000010000be07	movslq	0x10(%r15), %rax
000000010000be0b	cmpq	%rax, %r13
000000010000be0e	movl	$0x0, %r8d
000000010000be14	jae	0x10000c0c7
000000010000be1a	movq	0x28(%r15), %rax
000000010000be1e	movslq	(%rax,%r13,4), %rbx
000000010000be22	leaq	0x8(,%rbx,8), %rdi
000000010000be2a	callq	_fwp_alloc
000000010000be2f	movq	%rax, -0x48(%rbp)
000000010000be33	movq	%rbx, -0x60(%rbp)
000000010000be37	testq	%rbx, %rbx
000000010000be3a	jle	0x10000be78
000000010000be3c	movq	-0x60(%rbp), %rax
000000010000be40	leaq	(,%rax,8), %rbx
000000010000be48	xorl	%r12d, %r12d
000000010000be4b	movq	0x30(%r15), %rax
000000010000be4f	movq	(%rax,%r13,8), %rax
000000010000be53	movq	(%rax,%r12), %rsi
000000010000be57	movq	-0x48(%rbp), %rax
000000010000be5b	leaq	(%rax,%r12), %rdx
000000010000be5f	movq	%r14, %rdi
000000010000be62	callq	_fwp_decode
000000010000be67	testl	%eax, %eax
000000010000be69	je	0x10000c0c4
000000010000be6f	addq	$0x8, %r12
000000010000be73	cmpq	%r12, %rbx
000000010000be76	jne	0x10000be4b
000000010000be78	movl	%r13d, %edi
000000010000be7b	movq	-0x60(%rbp), %rsi
000000010000be7f	movq	-0x48(%rbp), %rdx
000000010000be83	callq	_fwp_data
000000010000be88	jmp	0x10000c398
000000010000be8d	movl	$0x1, %eax
000000010000be92	jmp	0x10000bb77
000000010000be97	movl	$0x2, %eax
000000010000be9c	jmp	0x10000bb77
000000010000bea1	movq	0x8(%r14), %rcx
000000010000bea5	movq	0x10(%r14), %rax
000000010000bea9	subq	%rax, %rcx
000000010000beac	cmpq	$0x2, %rcx
000000010000beb0	jb	0x10000c0c7
000000010000beb6	movq	(%r14), %rcx
000000010000beb9	leaq	0x2(%rax), %rdx
000000010000bebd	movq	%rdx, 0x10(%r14)
000000010000bec1	movzbl	(%rcx,%rax), %edx
000000010000bec5	movzbl	0x1(%rcx,%rax), %eax
000000010000beca	shlq	$0x38, %rax
000000010000bece	shlq	$0x30, %rdx
000000010000bed2	orq	%rax, %rdx
000000010000bed5	sarq	$0x30, %rdx
000000010000bed9	movq	%rdx, (%r9)
000000010000bedc	jmp	0x10000bc2a
000000010000bee1	movq	0x8(%r14), %rcx
000000010000bee5	movq	0x10(%r14), %rax
000000010000bee9	subq	%rax, %rcx
000000010000beec	cmpq	$0x4, %rcx
000000010000bef0	jb	0x10000c0c7
000000010000bef6	movq	(%r14), %rcx
000000010000bef9	leaq	0x4(%rax), %rdx
000000010000befd	movq	%rdx, 0x10(%r14)
000000010000bf01	movzbl	(%rcx,%rax), %edx
000000010000bf05	movzbl	0x1(%rcx,%rax), %esi
000000010000bf0a	movzbl	0x2(%rcx,%rax), %edi
000000010000bf0f	movzbl	0x3(%rcx,%rax), %eax
000000010000bf14	shlq	$0x38, %rax
000000010000bf18	shlq	$0x30, %rdi
000000010000bf1c	shlq	$0x28, %rsi
000000010000bf20	shlq	$0x20, %rdx
000000010000bf24	orq	%rsi, %rdx
000000010000bf27	orq	%rdi, %rdx
000000010000bf2a	orq	%rax, %rdx
000000010000bf2d	sarq	$0x20, %rdx
000000010000bf31	movq	%rdx, (%r9)
000000010000bf34	jmp	0x10000bc2a
000000010000bf39	movl	$0x4, %eax
000000010000bf3e	jmp	0x10000bb77
000000010000bf43	movq	%r9, %r12
000000010000bf46	movq	0x40(%r15), %rdi
000000010000bf4a	xorl	%esi, %esi
000000010000bf4c	callq	_fwp_wire_empty_inner
000000010000bf51	testl	%eax, %eax
000000010000bf53	setne	%r13b
000000010000bf57	jmp	0x10000bf5f
000000010000bf59	movq	%r9, %r12
000000010000bf5c	movb	$0x1, %r13b
000000010000bf5f	movq	0x38(%r15), %rbx
000000010000bf63	leaq	-0x58(%rbp), %rsi
000000010000bf67	movq	%r14, %rdi
000000010000bf6a	callq	_rd_leb
000000010000bf6f	testl	%eax, %eax
000000010000bf71	je	0x10000c0c4
000000010000bf77	movb	%r13b, -0x48(%rbp)
000000010000bf7b	movq	-0x58(%rbp), %r13
000000010000bf7f	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000bf89	cmpq	%rax, %r13
000000010000bf8c	movl	$0x0, %r8d
000000010000bf92	ja	0x10000c0c7
000000010000bf98	movq	%r12, -0x50(%rbp)
000000010000bf9c	movq	%rbx, %rdi
000000010000bf9f	xorl	%esi, %esi
000000010000bfa1	callq	_fwp_wire_empty_inner
000000010000bfa6	testl	%eax, %eax
000000010000bfa8	je	0x10000c0ba
000000010000bfae	cmpq	$0x2, %r13
000000010000bfb2	setae	%al
000000010000bfb5	movzbl	-0x48(%rbp), %ecx
000000010000bfb9	testb	%cl, %al
000000010000bfbb	je	0x10000c0ed
000000010000bfc1	jmp	0x10000c0c4
000000010000bfc6	movslq	0x10(%r15), %rdi
000000010000bfca	testq	%rdi, %rdi
000000010000bfcd	je	0x10000c038
000000010000bfcf	shlq	$0x3, %rdi
000000010000bfd3	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000bfda	movq	%r9, -0x50(%rbp)
000000010000bfde	ja	0x10000c178
000000010000bfe4	leaq	0xf(%rdi), %rcx
000000010000bfe8	shrq	$0x4, %rcx
000000010000bfec	leaq	_fwp_gc(%rip), %rax
000000010000bff3	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000bffb	movl	0xb48(%rax,%rcx,4), %esi
000000010000c002	subq	%rsi, _fwp_gc(%rip)
000000010000c009	js	0x10000c178
000000010000c00f	leaq	(%rcx,%rcx,2), %rcx
000000010000c013	leaq	(%rax,%rcx,8), %rax
000000010000c017	addq	$0x788, %rax                    ## imm = 0x788
000000010000c01d	movq	(%rax), %r12
000000010000c020	testq	%r12, %r12
000000010000c023	je	0x10000c168
000000010000c029	movq	(%r12), %rcx
000000010000c02d	notq	%rcx
000000010000c030	movq	%rcx, (%rax)
000000010000c033	jmp	0x10000c19b
000000010000c038	movq	$0x0, (%r9)
000000010000c03f	jmp	0x10000bc2a
000000010000c044	cmpq	$0x7ff, %r12                    ## imm = 0x7FF
000000010000c04b	ja	0x10000c259
000000010000c051	leaq	(,%r12,8), %rcx
000000010000c059	addq	$0x17, %rcx
000000010000c05d	shrq	$0x4, %rcx
000000010000c061	leaq	_fwp_gc(%rip), %rax
000000010000c068	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000c070	movl	0xb48(%rax,%rcx,4), %esi
000000010000c077	subq	%rsi, _fwp_gc(%rip)
000000010000c07e	js	0x10000c259
000000010000c084	leaq	(%rcx,%rcx,2), %rcx
000000010000c088	leaq	(%rax,%rcx,8), %rax
000000010000c08c	addq	$0x788, %rax                    ## imm = 0x788
000000010000c092	movq	(%rax), %r13
000000010000c095	testq	%r13, %r13
000000010000c098	je	0x10000c245
000000010000c09e	movq	(%r13), %rcx
000000010000c0a2	notq	%rcx
000000010000c0a5	movq	%rcx, (%rax)
000000010000c0a8	jmp	0x10000c31a
000000010000c0ad	callq	_fwp_box_i128
000000010000c0b2	movq	%rax, (%rbx)
000000010000c0b5	jmp	0x10000bc2a
000000010000c0ba	cmpq	0x8(%r14), %r13
000000010000c0be	movzbl	-0x48(%rbp), %ecx
000000010000c0c2	jbe	0x10000c0ed
000000010000c0c4	xorl	%r8d, %r8d
000000010000c0c7	movq	0x8f62(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000c0ce	movq	(%rax), %rax
000000010000c0d1	cmpq	-0x30(%rbp), %rax
000000010000c0d5	jne	0x10000c3a4
000000010000c0db	movl	%r8d, %eax
000000010000c0de	addq	$0x48, %rsp
000000010000c0e2	popq	%rbx
000000010000c0e3	popq	%r12
000000010000c0e5	popq	%r13
000000010000c0e7	popq	%r14
000000010000c0e9	popq	%r15
000000010000c0eb	popq	%rbp
000000010000c0ec	retq
000000010000c0ed	testb	%cl, %cl
000000010000c0ef	movl	$0x0, %r8d
000000010000c0f5	jne	0x10000c0fd
000000010000c0f7	cmpq	0x8(%r14), %r13
000000010000c0fb	ja	0x10000c0c7
000000010000c0fd	leaq	_fwp_empty_map(%rip), %r12
000000010000c104	testq	%r13, %r13
000000010000c107	je	0x10000c187
000000010000c109	leaq	-0x40(%rbp), %rbx
000000010000c10d	jmp	0x10000c129
000000010000c10f	xorl	%esi, %esi
000000010000c111	movq	-0x40(%rbp), %rdi
000000010000c115	movq	0x38(%r15), %rcx
000000010000c119	movq	%r12, %rdx
000000010000c11c	callq	_fwp_p_map_insert
000000010000c121	movq	%rax, %r12
000000010000c124	decq	%r13
000000010000c127	je	0x10000c187
000000010000c129	movq	$0x0, -0x68(%rbp)
000000010000c131	movq	0x38(%r15), %rsi
000000010000c135	movq	%r14, %rdi
000000010000c138	movq	%rbx, %rdx
000000010000c13b	callq	_fwp_decode
000000010000c140	testl	%eax, %eax
000000010000c142	je	0x10000c0c4
000000010000c144	cmpl	$0x12, (%r15)
000000010000c148	jne	0x10000c10f
000000010000c14a	movq	0x40(%r15), %rsi
000000010000c14e	movq	%r14, %rdi
000000010000c151	leaq	-0x68(%rbp), %rdx
000000010000c155	callq	_fwp_decode
000000010000c15a	testl	%eax, %eax
000000010000c15c	je	0x10000c0c4
000000010000c162	movq	-0x68(%rbp), %rsi
000000010000c166	jmp	0x10000c111
000000010000c168	movq	0x8(%rax), %r12
000000010000c16c	movq	0x10(%rax), %rcx
000000010000c170	subq	%r12, %rcx
000000010000c173	cmpq	%rsi, %rcx
000000010000c176	jae	0x10000c193
000000010000c178	movl	$0x2, %esi
000000010000c17d	callq	_fwp_gc_alloc_slow
000000010000c182	movq	%rax, %r12
000000010000c185	jmp	0x10000c1a3
000000010000c187	movq	-0x50(%rbp), %rax
000000010000c18b	movq	%r12, (%rax)
000000010000c18e	jmp	0x10000bc2a
000000010000c193	leaq	(%r12,%rsi), %rcx
000000010000c197	movq	%rcx, 0x8(%rax)
000000010000c19b	movq	%r12, %rdi
000000010000c19e	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000c1a3	movl	0x10(%r15), %r13d
000000010000c1a7	testl	%r13d, %r13d
000000010000c1aa	jle	0x10000c1ef
000000010000c1ac	movq	%r12, -0x48(%rbp)
000000010000c1b0	movq	%r12, %rbx
000000010000c1b3	xorl	%r12d, %r12d
000000010000c1b6	nopw	%cs:(%rax,%rax)
000000010000c1c0	movq	0x20(%r15), %rax
000000010000c1c4	movq	(%rax,%r12,8), %rsi
000000010000c1c8	movq	%r14, %rdi
000000010000c1cb	movq	%rbx, %rdx
000000010000c1ce	callq	_fwp_decode
000000010000c1d3	testl	%eax, %eax
000000010000c1d5	je	0x10000c0c4
000000010000c1db	incq	%r12
000000010000c1de	movslq	0x10(%r15), %r13
000000010000c1e2	addq	$0x8, %rbx
000000010000c1e6	cmpq	%r13, %r12
000000010000c1e9	jl	0x10000c1c0
000000010000c1eb	movq	-0x48(%rbp), %r12
000000010000c1ef	testl	%r13d, %r13d
000000010000c1f2	je	0x10000c21f
000000010000c1f4	movl	%r13d, %ebx
000000010000c1f7	leaq	0x8(,%rbx,8), %rdi
000000010000c1ff	callq	_fwp_alloc_init
000000010000c204	movl	$0x0, (%rax)
000000010000c20a	movl	%r13d, 0x4(%rax)
000000010000c20e	cmpl	$0x8, %r13d
000000010000c212	jae	0x10000c22d
000000010000c214	xorl	%ecx, %ecx
000000010000c216	movq	-0x50(%rbp), %r8
000000010000c21a	jmp	0x10000c2ac
000000010000c21f	xorl	%eax, %eax
000000010000c221	movq	-0x50(%rbp), %r8
000000010000c225	movq	%rax, (%r8)
000000010000c228	jmp	0x10000bc2a
000000010000c22d	movq	%rax, %rcx
000000010000c230	subq	%r12, %rcx
000000010000c233	addq	$0x8, %rcx
000000010000c237	cmpq	$0x20, %rcx
000000010000c23b	movq	-0x50(%rbp), %r8
000000010000c23f	jae	0x10000c273
000000010000c241	xorl	%ecx, %ecx
000000010000c243	jmp	0x10000c2ac
000000010000c245	movq	0x8(%rax), %r13
000000010000c249	movq	0x10(%rax), %rcx
000000010000c24d	subq	%r13, %rcx
000000010000c250	cmpq	%rsi, %rcx
000000010000c253	jae	0x10000c312
000000010000c259	leaq	0x8(,%r12,8), %rdi
000000010000c261	movl	$0x2, %esi
000000010000c266	callq	_fwp_gc_alloc_slow
000000010000c26b	movq	%rax, %r13
000000010000c26e	jmp	0x10000c322
000000010000c273	movl	%ebx, %ecx
000000010000c275	andl	$-0x4, %ecx
000000010000c278	leaq	(,%rbx,8), %rdx
000000010000c280	andq	$-0x20, %rdx
000000010000c284	xorl	%esi, %esi
000000010000c286	movdqu	(%r12,%rsi), %xmm0
000000010000c28c	movdqu	0x10(%r12,%rsi), %xmm1
000000010000c293	movdqu	%xmm0, 0x8(%rax,%rsi)
000000010000c299	movdqu	%xmm1, 0x18(%rax,%rsi)
000000010000c29f	addq	$0x20, %rsi
000000010000c2a3	cmpq	%rsi, %rdx
000000010000c2a6	jne	0x10000c286
000000010000c2a8	cmpl	%ebx, %ecx
000000010000c2aa	je	0x10000c30a
000000010000c2ac	movq	%rbx, %rsi
000000010000c2af	movq	%rcx, %rdx
000000010000c2b2	andq	$0x3, %rsi
000000010000c2b6	je	0x10000c2d1
000000010000c2b8	movq	%rcx, %rdx
000000010000c2bb	nopl	(%rax,%rax)
000000010000c2c0	movq	(%r12,%rdx,8), %rdi
000000010000c2c4	movq	%rdi, 0x8(%rax,%rdx,8)
000000010000c2c9	incq	%rdx
000000010000c2cc	decq	%rsi
000000010000c2cf	jne	0x10000c2c0
000000010000c2d1	subq	%rbx, %rcx
000000010000c2d4	cmpq	$-0x4, %rcx
000000010000c2d8	ja	0x10000c30a
000000010000c2da	movq	(%r12,%rdx,8), %rcx
000000010000c2de	movq	%rcx, 0x8(%rax,%rdx,8)
000000010000c2e3	movq	0x8(%r12,%rdx,8), %rcx
000000010000c2e8	movq	%rcx, 0x10(%rax,%rdx,8)
000000010000c2ed	movq	0x10(%r12,%rdx,8), %rcx
000000010000c2f2	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000c2f7	movq	0x18(%r12,%rdx,8), %rcx
000000010000c2fc	movq	%rcx, 0x20(%rax,%rdx,8)
000000010000c301	addq	$0x4, %rdx
000000010000c305	cmpq	%rdx, %rbx
000000010000c308	jne	0x10000c2da
000000010000c30a	movq	%rax, (%r8)
000000010000c30d	jmp	0x10000bc2a
000000010000c312	leaq	(%rsi,%r13), %rcx
000000010000c316	movq	%rcx, 0x8(%rax)
000000010000c31a	movq	%r13, %rdi
000000010000c31d	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000c322	testq	%r12, %r12
000000010000c325	je	0x10000c396
000000010000c327	movq	%r13, -0x48(%rbp)
000000010000c32b	movq	%r13, %rbx
000000010000c32e	movq	%r12, %r13
000000010000c331	movq	0x38(%r15), %rsi
000000010000c335	movq	%r14, %rdi
000000010000c338	movq	%rbx, %rdx
000000010000c33b	callq	_fwp_decode
000000010000c340	testl	%eax, %eax
000000010000c342	je	0x10000c0c4
000000010000c348	addq	$0x8, %rbx
000000010000c34c	decq	%r13
000000010000c34f	jne	0x10000c331
000000010000c351	xorl	%r15d, %r15d
000000010000c354	movabsq	$0x200000001, %rbx              ## imm = 0x200000001
000000010000c35e	leaq	-0x40(%rbp), %r14
000000010000c362	movq	-0x48(%rbp), %rax
000000010000c366	movq	-0x8(%rax,%r12,8), %r13
000000010000c36b	movq	%r13, -0x40(%rbp)
000000010000c36f	movq	%r15, -0x38(%rbp)
000000010000c373	movl	$0x18, %edi
000000010000c378	callq	_fwp_alloc_init
000000010000c37d	movq	%rbx, (%rax)
000000010000c380	movq	%r13, 0x8(%rax)
000000010000c384	movq	-0x48(%rbp), %r13
000000010000c388	movq	%r15, 0x10(%rax)
000000010000c38c	movq	%rax, %r15
000000010000c38f	decq	%r12
000000010000c392	jne	0x10000c362
000000010000c394	jmp	0x10000c398
000000010000c396	xorl	%eax, %eax
000000010000c398	movq	-0x50(%rbp), %rcx
000000010000c39c	movq	%rax, (%rcx)
000000010000c39f	jmp	0x10000bc2a
000000010000c3a4	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000c3a9	nopl	(%rax)
000000010000c3ac	orb	$-0x7, %al
000000010000c3ae	.byte 0xff #bad opcode
000000010000c3af	pushq	%rbp
000000010000c3b1	cli
000000010000c3b2	.byte 0xff #bad opcode
000000010000c3b3	pushq	-0x44000005(%rip)
000000010000c3b9	idivl	%edi
000000010000c3bb	pushq	(%rdx)
000000010000c3bd	stc
000000010000c3be	.byte 0xff #bad opcode
000000010000c3bf	jmpq	*%rcx
000000010000c3c1	cli
000000010000c3c2	.byte 0xff #bad opcode
000000010000c3c3	.byte 0xff #bad opcode
000000010000c3c4	jmp	0x10000c3c0
000000010000c3c6	.byte 0xff #bad opcode
000000010000c3c7	decl	-0x44000005(%rbp)
000000010000c3cd	idivl	%edi
000000010000c3cf	pushq	(%rdx)
000000010000c3d1	stc
000000010000c3d2	.byte 0xff #bad opcode
000000010000c3d3	.byte 0xff #bad opcode
000000010000c3d4	movl	$0xbbfffff7, %ebx               ## imm = 0xBBFFFFF7
000000010000c3d9	idivl	%edi
000000010000c3db	decl	-0x76000008(%rcx)
000000010000c3e1	clc
000000010000c3e2	.byte 0xff #bad opcode
000000010000c3e3	.byte 0xff #bad opcode
000000010000c3e4	.byte 0x3f #bad opcode
000000010000c3e5	cli
000000010000c3e6	.byte 0xff #bad opcode
000000010000c3e7	decl	-0x3e50001(%rcx,%rdi,8)
000000010000c3ee	.byte 0xff #bad opcode
000000010000c3ef	decl	-0x4680001(%rcx,%rdi,8)
000000010000c3f6	.byte 0xff #bad opcode
000000010000c3f7	ljmpl	*-0x44000005(%rbp)
000000010000c3fd	idivl	%edi
000000010000c3ff	decl	(%rcx,%rdi,8)
000000010000c402	.byte 0xff #bad opcode
000000010000c403	jmpq	*0x66(%rsi)
000000010000c406	nopw	%cs:(%rax,%rax)
_fwp_valid_utf8:
000000010000c410	testq	%rsi, %rsi
000000010000c413	je	0x10000c572
000000010000c419	pushq	%rbp
000000010000c41a	movq	%rsp, %rbp
000000010000c41d	pushq	%rbx
000000010000c41e	xorl	%ecx, %ecx
000000010000c420	jmp	0x10000c43c
000000010000c422	nopw	%cs:(%rax,%rax)
000000010000c430	incq	%rcx
000000010000c433	cmpq	%rsi, %rcx
000000010000c436	jae	0x10000c56a
000000010000c43c	movzbl	(%rdi,%rcx), %r10d
000000010000c441	testb	%r10b, %r10b
000000010000c444	jns	0x10000c430
000000010000c446	leal	0x3e(%r10), %eax
000000010000c44a	cmpb	$0x1e, %al
000000010000c44c	jae	0x10000c460
000000010000c44e	movl	$0x80, %edx
000000010000c453	movl	$0x1, %eax
000000010000c458	movl	$0x1f, %r8d
000000010000c45e	jmp	0x10000c497
000000010000c460	movl	%r10d, %eax
000000010000c463	andb	$-0x10, %al
000000010000c465	cmpb	$-0x20, %al
000000010000c467	jne	0x10000c47b
000000010000c469	movl	$0x800, %edx                    ## imm = 0x800
000000010000c46e	movl	$0x2, %eax
000000010000c473	movl	$0xf, %r8d
000000010000c479	jmp	0x10000c497
000000010000c47b	leal	0x10(%r10), %eax
000000010000c47f	cmpb	$0x4, %al
000000010000c481	ja	0x10000c578
000000010000c487	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000c48c	movl	$0x3, %eax
000000010000c491	movl	$0x7, %r8d
000000010000c497	movl	%eax, %r9d
000000010000c49a	leaq	(%rcx,%r9), %r11
000000010000c49e	xorl	%eax, %eax
000000010000c4a0	cmpq	%rsi, %r11
000000010000c4a3	jae	0x10000c56f
000000010000c4a9	movzbl	0x1(%rdi,%rcx), %r11d
000000010000c4af	movl	%r11d, %ebx
000000010000c4b2	andl	$-0x40, %ebx
000000010000c4b5	cmpl	$0x80, %ebx
000000010000c4bb	jne	0x10000c56f
000000010000c4c1	andl	%r10d, %r8d
000000010000c4c4	leal	0x1(%r9), %ebx
000000010000c4c8	movl	%r8d, %r10d
000000010000c4cb	shll	$0x6, %r10d
000000010000c4cf	andl	$0x3f, %r11d
000000010000c4d3	orl	%r10d, %r11d
000000010000c4d6	cmpl	$0x2, %ebx
000000010000c4d9	jne	0x10000c4e7
000000010000c4db	movl	%r11d, %ebx
000000010000c4de	cmpl	%edx, %ebx
000000010000c4e0	jae	0x10000c542
000000010000c4e2	jmp	0x10000c56f
000000010000c4e7	movzbl	0x2(%rdi,%rcx), %r8d
000000010000c4ed	movl	%r8d, %r10d
000000010000c4f0	andl	$-0x40, %r10d
000000010000c4f4	cmpl	$0x80, %r10d
000000010000c4fb	jne	0x10000c56f
000000010000c4fd	movl	%r11d, %r10d
000000010000c500	shll	$0x6, %r10d
000000010000c504	andl	$0x3f, %r8d
000000010000c508	orl	%r10d, %r8d
000000010000c50b	cmpl	$0x3, %ebx
000000010000c50e	jne	0x10000c51c
000000010000c510	movl	%r8d, %ebx
000000010000c513	movl	%r11d, %r8d
000000010000c516	cmpl	%edx, %ebx
000000010000c518	jae	0x10000c542
000000010000c51a	jmp	0x10000c56f
000000010000c51c	movzbl	0x3(%rdi,%rcx), %ebx
000000010000c521	movl	%ebx, %r10d
000000010000c524	andl	$-0x40, %r10d
000000010000c528	cmpl	$0x80, %r10d
000000010000c52f	jne	0x10000c56f
000000010000c531	movl	%r8d, %r10d
000000010000c534	shll	$0x6, %r10d
000000010000c538	andl	$0x3f, %ebx
000000010000c53b	orl	%r10d, %ebx
000000010000c53e	cmpl	%edx, %ebx
000000010000c540	jb	0x10000c56f
000000010000c542	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000c549	ja	0x10000c56f
000000010000c54b	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000c552	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000c559	je	0x10000c56f
000000010000c55b	addq	%r9, %rcx
000000010000c55e	incq	%rcx
000000010000c561	cmpq	%rsi, %rcx
000000010000c564	jb	0x10000c43c
000000010000c56a	movl	$0x1, %eax
000000010000c56f	popq	%rbx
000000010000c570	popq	%rbp
000000010000c571	retq
000000010000c572	movl	$0x1, %eax
000000010000c577	retq
000000010000c578	xorl	%eax, %eax
000000010000c57a	jmp	0x10000c56f
000000010000c57c	nopl	(%rax)
_fwp_str_new:
000000010000c580	pushq	%rbp
000000010000c581	movq	%rsp, %rbp
000000010000c584	pushq	%r15
000000010000c586	pushq	%r14
000000010000c588	pushq	%rbx
000000010000c589	pushq	%rax
000000010000c58a	movq	%rsi, %r14
000000010000c58d	movq	%rdi, %rbx
000000010000c590	addq	$0x9, %rsi
000000010000c594	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000c59b	ja	0x10000c5f6
000000010000c59d	leaq	0x18(%r14), %rax
000000010000c5a1	shrq	$0x4, %rax
000000010000c5a5	leaq	_fwp_gc(%rip), %rcx
000000010000c5ac	movzbl	0xbe8(%rax,%rcx), %edx
000000010000c5b4	movl	0xb48(%rcx,%rdx,4), %eax
000000010000c5bb	subq	%rax, _fwp_gc(%rip)
000000010000c5c2	js	0x10000c5f6
000000010000c5c4	leaq	(%rdx,%rdx,2), %rdx
000000010000c5c8	leaq	(%rcx,%rdx,8), %rcx
000000010000c5cc	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000c5d3	movq	(%rcx), %r15
000000010000c5d6	testq	%r15, %r15
000000010000c5d9	je	0x10000c5e6
000000010000c5db	movq	(%r15), %rax
000000010000c5de	notq	%rax
000000010000c5e1	movq	%rax, (%rcx)
000000010000c5e4	jmp	0x10000c60f
000000010000c5e6	movq	0x8(%rcx), %r15
000000010000c5ea	movq	0x10(%rcx), %rdx
000000010000c5ee	subq	%r15, %rdx
000000010000c5f1	cmpq	%rax, %rdx
000000010000c5f4	jae	0x10000c608
000000010000c5f6	movq	%rsi, %rdi
000000010000c5f9	movl	$0x1, %esi
000000010000c5fe	callq	_fwp_gc_alloc_slow
000000010000c603	movq	%rax, %r15
000000010000c606	jmp	0x10000c617
000000010000c608	addq	%r15, %rax
000000010000c60b	movq	%rax, 0x8(%rcx)
000000010000c60f	movq	%r15, %rdi
000000010000c612	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000c617	movq	%r14, (%r15)
000000010000c61a	leaq	0x8(%r15), %rdi
000000010000c61e	movq	%rbx, %rsi
000000010000c621	movq	%r14, %rdx
000000010000c624	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000c629	movb	$0x0, 0x8(%r15,%r14)
000000010000c62f	movq	%r15, %rax
000000010000c632	addq	$0x8, %rsp
000000010000c636	popq	%rbx
000000010000c637	popq	%r14
000000010000c639	popq	%r15
000000010000c63b	popq	%rbp
000000010000c63c	retq
000000010000c63d	nopl	(%rax)
_buf_put:
000000010000c640	pushq	%rbp
000000010000c641	movq	%rsp, %rbp
000000010000c644	pushq	%r15
000000010000c646	pushq	%r14
000000010000c648	pushq	%r12
000000010000c64a	pushq	%rbx
000000010000c64b	movq	%rdi, %r14
000000010000c64e	movq	0x8(%rdi), %rdi
000000010000c652	cmpq	$-0x1, %rdi
000000010000c656	je	0x10000c6f8
000000010000c65c	movq	%rdx, %rbx
000000010000c65f	movq	$-0x2, %rax
000000010000c666	subq	%rdi, %rax
000000010000c669	cmpq	%rdx, %rax
000000010000c66c	jb	0x10000c6f8
000000010000c672	leaq	(%rbx,%rdi), %rax
000000010000c676	incq	%rax
000000010000c679	movq	0x10(%r14), %rcx
000000010000c67d	cmpq	%rcx, %rax
000000010000c680	jbe	0x10000c6af
000000010000c682	testq	%rcx, %rcx
000000010000c685	movl	$0x40, %r15d
000000010000c68b	cmovneq	%rcx, %r15
000000010000c68f	movq	%rsi, %r12
000000010000c692	cmpq	%rax, %r15
000000010000c695	jae	0x10000c6b7
000000010000c697	nopw	(%rax,%rax)
000000010000c6a0	testq	%r15, %r15
000000010000c6a3	js	0x10000c6b4
000000010000c6a5	addq	%r15, %r15
000000010000c6a8	cmpq	%rax, %r15
000000010000c6ab	jb	0x10000c6a0
000000010000c6ad	jmp	0x10000c6b7
000000010000c6af	movq	(%r14), %rax
000000010000c6b2	jmp	0x10000c6d5
000000010000c6b4	movq	%rax, %r15
000000010000c6b7	movq	(%r14), %rdi
000000010000c6ba	movq	%r15, %rsi
000000010000c6bd	callq	0x100012cea                     ## symbol stub for: _realloc
000000010000c6c2	testq	%rax, %rax
000000010000c6c5	je	0x10000c6f8
000000010000c6c7	movq	%rax, (%r14)
000000010000c6ca	movq	%r15, 0x10(%r14)
000000010000c6ce	movq	0x8(%r14), %rdi
000000010000c6d2	movq	%r12, %rsi
000000010000c6d5	addq	%rax, %rdi
000000010000c6d8	movq	%rbx, %rdx
000000010000c6db	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000c6e0	addq	0x8(%r14), %rbx
000000010000c6e4	movq	%rbx, 0x8(%r14)
000000010000c6e8	movq	(%r14), %rax
000000010000c6eb	movb	$0x0, (%rax,%rbx)
000000010000c6ef	popq	%rbx
000000010000c6f0	popq	%r12
000000010000c6f2	popq	%r14
000000010000c6f4	popq	%r15
000000010000c6f6	popq	%rbp
000000010000c6f7	retq
000000010000c6f8	movq	0x8939(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000c6ff	movq	(%rax), %rcx
000000010000c702	leaq	0x6d75(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000c709	movl	$0x13, %esi
000000010000c70e	movl	$0x1, %edx
000000010000c713	callq	0x100012c78                     ## symbol stub for: _fwrite
000000010000c718	movl	$0x66, %edi
000000010000c71d	callq	0x100012c48                     ## symbol stub for: _exit
000000010000c722	nopw	%cs:(%rax,%rax)
_buf_to_str:
000000010000c730	pushq	%rbp
000000010000c731	movq	%rsp, %rbp
000000010000c734	pushq	%r14
000000010000c736	pushq	%rbx
000000010000c737	movq	%rdi, %rbx
000000010000c73a	movq	(%rdi), %rax
000000010000c73d	movq	0x8(%rdi), %rsi
000000010000c741	testq	%rax, %rax
000000010000c744	leaq	0x6be7(%rip), %rdi              ## literal pool for: ""
000000010000c74b	cmovneq	%rax, %rdi
000000010000c74f	callq	_fwp_str_new
000000010000c754	movq	%rax, %r14
000000010000c757	movq	(%rbx), %rdi
000000010000c75a	callq	0x100012c72                     ## symbol stub for: _free
000000010000c75f	movq	%r14, %rax
000000010000c762	popq	%rbx
000000010000c763	popq	%r14
000000010000c765	popq	%rbp
000000010000c766	retq
000000010000c767	nopw	(%rax,%rax)
_fwp_strf:
000000010000c770	pushq	%rbp
000000010000c771	movq	%rsp, %rbp
000000010000c774	pushq	%r15
000000010000c776	pushq	%r14
000000010000c778	pushq	%r13
000000010000c77a	pushq	%r12
000000010000c77c	pushq	%rbx
000000010000c77d	subq	$0xd8, %rsp
000000010000c784	movq	%rdi, %rbx
000000010000c787	movq	%rsi, -0xf8(%rbp)
000000010000c78e	movq	%rdx, -0xf0(%rbp)
000000010000c795	movq	%rcx, -0xe8(%rbp)
000000010000c79c	movq	%r8, -0xe0(%rbp)
000000010000c7a3	movq	%r9, -0xd8(%rbp)
000000010000c7aa	testb	%al, %al
000000010000c7ac	je	0x10000c7dd
000000010000c7ae	movaps	%xmm0, -0xd0(%rbp)
000000010000c7b5	movaps	%xmm1, -0xc0(%rbp)
000000010000c7bc	movaps	%xmm2, -0xb0(%rbp)
000000010000c7c3	movaps	%xmm3, -0xa0(%rbp)
000000010000c7ca	movaps	%xmm4, -0x90(%rbp)
000000010000c7d1	movaps	%xmm5, -0x80(%rbp)
000000010000c7d5	movaps	%xmm6, -0x70(%rbp)
000000010000c7d9	movaps	%xmm7, -0x60(%rbp)
000000010000c7dd	movq	0x884c(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000c7e4	movq	(%rax), %rax
000000010000c7e7	movq	%rax, -0x30(%rbp)
000000010000c7eb	leaq	-0x100(%rbp), %rax
000000010000c7f2	movq	%rax, -0x40(%rbp)
000000010000c7f6	leaq	0x10(%rbp), %rax
000000010000c7fa	movq	%rax, -0x48(%rbp)
000000010000c7fe	movabsq	$0x3000000008, %r13             ## imm = 0x3000000008
000000010000c808	movq	%r13, -0x50(%rbp)
000000010000c80c	leaq	-0x50(%rbp), %rcx
000000010000c810	xorl	%edi, %edi
000000010000c812	xorl	%esi, %esi
000000010000c814	movq	%rbx, %rdx
000000010000c817	callq	0x100012d56                     ## symbol stub for: _vsnprintf
000000010000c81c	movslq	%eax, %r14
000000010000c81f	leaq	0x1(%r14), %r15
000000010000c823	cmpq	$0x4000, %r15                   ## imm = 0x4000
000000010000c82a	ja	0x10000c886
000000010000c82c	leaq	0x10(%r14), %rax
000000010000c830	shrq	$0x4, %rax
000000010000c834	leaq	_fwp_gc(%rip), %rcx
000000010000c83b	movzbl	0xbe8(%rax,%rcx), %edx
000000010000c843	movl	0xb48(%rcx,%rdx,4), %eax
000000010000c84a	subq	%rax, _fwp_gc(%rip)
000000010000c851	js	0x10000c886
000000010000c853	leaq	(%rdx,%rdx,2), %rdx
000000010000c857	leaq	(%rcx,%rdx,8), %rcx
000000010000c85b	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000c862	movq	(%rcx), %r12
000000010000c865	testq	%r12, %r12
000000010000c868	je	0x10000c876
000000010000c86a	movq	(%r12), %rax
000000010000c86e	notq	%rax
000000010000c871	movq	%rax, (%rcx)
000000010000c874	jmp	0x10000c89f
000000010000c876	movq	0x8(%rcx), %r12
000000010000c87a	movq	0x10(%rcx), %rdx
000000010000c87e	subq	%r12, %rdx
000000010000c881	cmpq	%rax, %rdx
000000010000c884	jae	0x10000c898
000000010000c886	movq	%r15, %rdi
000000010000c889	movl	$0x1, %esi
000000010000c88e	callq	_fwp_gc_alloc_slow
000000010000c893	movq	%rax, %r12
000000010000c896	jmp	0x10000c8aa
000000010000c898	addq	%r12, %rax
000000010000c89b	movq	%rax, 0x8(%rcx)
000000010000c89f	movq	%r12, %rdi
000000010000c8a2	movq	%r15, %rsi
000000010000c8a5	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000c8aa	leaq	-0x100(%rbp), %rax
000000010000c8b1	movq	%rax, -0x40(%rbp)
000000010000c8b5	leaq	0x10(%rbp), %rax
000000010000c8b9	movq	%rax, -0x48(%rbp)
000000010000c8bd	movq	%r13, -0x50(%rbp)
000000010000c8c1	leaq	-0x50(%rbp), %rcx
000000010000c8c5	movq	%r12, %rdi
000000010000c8c8	movq	%r15, %rsi
000000010000c8cb	movq	%rbx, %rdx
000000010000c8ce	callq	0x100012d56                     ## symbol stub for: _vsnprintf
000000010000c8d3	movq	%r12, %rdi
000000010000c8d6	movq	%r14, %rsi
000000010000c8d9	callq	_fwp_str_new
000000010000c8de	movq	0x874b(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000c8e5	movq	(%rcx), %rcx
000000010000c8e8	cmpq	-0x30(%rbp), %rcx
000000010000c8ec	jne	0x10000c900
000000010000c8ee	addq	$0xd8, %rsp
000000010000c8f5	popq	%rbx
000000010000c8f6	popq	%r12
000000010000c8f8	popq	%r13
000000010000c8fa	popq	%r14
000000010000c8fc	popq	%r15
000000010000c8fe	popq	%rbp
000000010000c8ff	retq
000000010000c900	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000c905	nopw	%cs:(%rax,%rax)
_tp_value:
000000010000c910	pushq	%rbp
000000010000c911	movq	%rsp, %rbp
000000010000c914	pushq	%r15
000000010000c916	pushq	%r14
000000010000c918	pushq	%r13
000000010000c91a	pushq	%r12
000000010000c91c	pushq	%rbx
000000010000c91d	subq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000c924	movq	%rcx, %rbx
000000010000c927	movq	%rsi, %rax
000000010000c92a	movq	0x86ff(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000c931	movq	(%rcx), %rcx
000000010000c934	movq	%rcx, -0x30(%rbp)
000000010000c938	testl	%edx, %edx
000000010000c93a	je	0x10000c9a1
000000010000c93c	cmpl	$0xc, (%rax)
000000010000c93f	jne	0x10000c9a1
000000010000c941	movq	0x8(%rdi), %rsi
000000010000c945	movq	0x10(%rdi), %r15
000000010000c949	movq	%rbx, %r12
000000010000c94c	movq	(%rdi), %rax
000000010000c94f	addq	%r15, %rax
000000010000c952	subq	%r15, %rsi
000000010000c955	jne	0x10000ca2c
000000010000c95b	movq	%rdi, %rbx
000000010000c95e	movq	%rax, %rdi
000000010000c961	callq	_fwp_str_new
000000010000c966	movq	%rax, (%r12)
000000010000c96a	movq	0x8(%rbx), %rax
000000010000c96e	movq	%rax, 0x10(%rbx)
000000010000c972	movl	$0x1, %r14d
000000010000c978	movq	0x86b1(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000c97f	movq	(%rax), %rax
000000010000c982	cmpq	-0x30(%rbp), %rax
000000010000c986	jne	0x10000e19c
000000010000c98c	movl	%r14d, %eax
000000010000c98f	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000c996	popq	%rbx
000000010000c997	popq	%r12
000000010000c999	popq	%r13
000000010000c99b	popq	%r14
000000010000c99d	popq	%r15
000000010000c99f	popq	%rbp
000000010000c9a0	retq
000000010000c9a1	movq	0x8(%rdi), %rsi
000000010000c9a5	movq	0x10(%rdi), %r15
000000010000c9a9	cmpq	%rsi, %r15
000000010000c9ac	jae	0x10000c9e0
000000010000c9ae	movq	(%rdi), %rcx
000000010000c9b1	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000c9bb	nopl	(%rax,%rax)
000000010000c9c0	movzbl	(%rcx,%r15), %r9d
000000010000c9c5	cmpq	$0x20, %r9
000000010000c9c9	ja	0x10000c9e0
000000010000c9cb	btq	%r9, %r8
000000010000c9cf	jae	0x10000c9e0
000000010000c9d1	incq	%r15
000000010000c9d4	movq	%r15, 0x10(%rdi)
000000010000c9d8	cmpq	%r15, %rsi
000000010000c9db	jne	0x10000c9c0
000000010000c9dd	movq	%rsi, %r15
000000010000c9e0	movl	(%rax), %ecx
000000010000c9e2	xorl	%r14d, %r14d
000000010000c9e5	cmpq	$0x15, %rcx
000000010000c9e9	ja	0x10000c978
000000010000c9eb	leaq	0x17b2(%rip), %r8
000000010000c9f2	movslq	(%r8,%rcx,4), %r9
000000010000c9f6	addq	%r8, %r9
000000010000c9f9	jmpq	*%r9
000000010000c9fc	movq	0x862d(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000ca03	movq	(%rcx), %rcx
000000010000ca06	cmpq	-0x30(%rbp), %rcx
000000010000ca0a	jne	0x10000e19c
000000010000ca10	movq	%rax, %rsi
000000010000ca13	movq	%rbx, %rdx
000000010000ca16	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000ca1d	popq	%rbx
000000010000ca1e	popq	%r12
000000010000ca20	popq	%r13
000000010000ca22	popq	%r14
000000010000ca24	popq	%r15
000000010000ca26	popq	%rbp
000000010000ca27	jmp	_tp_int
000000010000ca2c	xorl	%ecx, %ecx
000000010000ca2e	jmp	0x10000ca3c
000000010000ca30	incq	%rcx
000000010000ca33	cmpq	%rsi, %rcx
000000010000ca36	jae	0x10000c95b
000000010000ca3c	movzbl	(%rax,%rcx), %r10d
000000010000ca41	testb	%r10b, %r10b
000000010000ca44	jns	0x10000ca30
000000010000ca46	leal	0x3e(%r10), %edx
000000010000ca4a	cmpb	$0x1e, %dl
000000010000ca4d	jae	0x10000ca62
000000010000ca4f	movl	$0x80, %edx
000000010000ca54	movl	$0x1, %r9d
000000010000ca5a	movl	$0x1f, %r8d
000000010000ca60	jmp	0x10000ca9e
000000010000ca62	movl	%r10d, %edx
000000010000ca65	andb	$-0x10, %dl
000000010000ca68	cmpb	$-0x20, %dl
000000010000ca6b	jne	0x10000ca80
000000010000ca6d	movl	$0x800, %edx                    ## imm = 0x800
000000010000ca72	movl	$0x2, %r9d
000000010000ca78	movl	$0xf, %r8d
000000010000ca7e	jmp	0x10000ca9e
000000010000ca80	leal	0x10(%r10), %edx
000000010000ca84	cmpb	$0x4, %dl
000000010000ca87	ja	0x10000e0cc
000000010000ca8d	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000ca92	movl	$0x3, %r9d
000000010000ca98	movl	$0x7, %r8d
000000010000ca9e	movl	%r9d, %r9d
000000010000caa1	leaq	(%rcx,%r9), %r11
000000010000caa5	xorl	%r14d, %r14d
000000010000caa8	cmpq	%rsi, %r11
000000010000caab	jae	0x10000c978
000000010000cab1	movzbl	0x1(%rax,%rcx), %r11d
000000010000cab7	movl	%r11d, %ebx
000000010000caba	andl	$-0x40, %ebx
000000010000cabd	cmpl	$0x80, %ebx
000000010000cac3	jne	0x10000c978
000000010000cac9	andl	%r10d, %r8d
000000010000cacc	leal	0x1(%r9), %ebx
000000010000cad0	movl	%r8d, %r10d
000000010000cad3	shll	$0x6, %r10d
000000010000cad7	andl	$0x3f, %r11d
000000010000cadb	orl	%r10d, %r11d
000000010000cade	cmpl	$0x2, %ebx
000000010000cae1	jne	0x10000cae8
000000010000cae3	movl	%r11d, %ebx
000000010000cae6	jmp	0x10000cb43
000000010000cae8	movzbl	0x2(%rax,%rcx), %r8d
000000010000caee	movl	%r8d, %r10d
000000010000caf1	andl	$-0x40, %r10d
000000010000caf5	cmpl	$0x80, %r10d
000000010000cafc	jne	0x10000c978
000000010000cb02	movl	%r11d, %r10d
000000010000cb05	shll	$0x6, %r10d
000000010000cb09	andl	$0x3f, %r8d
000000010000cb0d	orl	%r10d, %r8d
000000010000cb10	cmpl	$0x3, %ebx
000000010000cb13	jne	0x10000cb1d
000000010000cb15	movl	%r8d, %ebx
000000010000cb18	movl	%r11d, %r8d
000000010000cb1b	jmp	0x10000cb43
000000010000cb1d	movzbl	0x3(%rax,%rcx), %ebx
000000010000cb22	movl	%ebx, %r10d
000000010000cb25	andl	$-0x40, %r10d
000000010000cb29	cmpl	$0x80, %r10d
000000010000cb30	jne	0x10000c978
000000010000cb36	movl	%r8d, %r10d
000000010000cb39	shll	$0x6, %r10d
000000010000cb3d	andl	$0x3f, %ebx
000000010000cb40	orl	%r10d, %ebx
000000010000cb43	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000cb4a	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000cb51	je	0x10000c978
000000010000cb57	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000cb5e	ja	0x10000c978
000000010000cb64	cmpl	%edx, %ebx
000000010000cb66	jb	0x10000c978
000000010000cb6c	addq	%r9, %rcx
000000010000cb6f	incq	%rcx
000000010000cb72	cmpq	%rsi, %rcx
000000010000cb75	jb	0x10000ca3c
000000010000cb7b	jmp	0x10000c95b
000000010000cb80	movdqu	0x38(%rax), %xmm0
000000010000cb85	movdqa	%xmm0, -0x130(%rbp)
000000010000cb8d	xorl	%edx, %edx
000000010000cb8f	cmpl	$0x13, %ecx
000000010000cb92	sete	%dl
000000010000cb95	pxor	%xmm0, %xmm0
000000010000cb99	movdqa	%xmm0, -0x120(%rbp)
000000010000cba1	movq	$0x0, -0x110(%rbp)
000000010000cbac	movl	%edx, -0x108(%rbp)
000000010000cbb2	leaq	0x7490(%rip), %rdx              ## literal pool for: "set"
000000010000cbb9	leaq	0x748d(%rip), %rcx              ## literal pool for: "map"
000000010000cbc0	cmoveq	%rdx, %rcx
000000010000cbc4	cmpq	%rsi, %r15
000000010000cbc7	jae	0x10000cc00
000000010000cbc9	movq	(%rdi), %rdx
000000010000cbcc	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000cbd6	nopw	%cs:(%rax,%rax)
000000010000cbe0	movzbl	(%rdx,%r15), %r9d
000000010000cbe5	cmpq	$0x20, %r9
000000010000cbe9	ja	0x10000cc00
000000010000cbeb	btq	%r9, %r8
000000010000cbef	jae	0x10000cc00
000000010000cbf1	incq	%r15
000000010000cbf4	movq	%r15, 0x10(%rdi)
000000010000cbf8	cmpq	%r15, %rsi
000000010000cbfb	jne	0x10000cbe0
000000010000cbfd	movq	%rsi, %r15
000000010000cc00	subq	%r15, %rsi
000000010000cc03	xorl	%r14d, %r14d
000000010000cc06	cmpq	$0x3, %rsi
000000010000cc0a	jb	0x10000c978
000000010000cc10	movq	(%rdi), %rdx
000000010000cc13	movzwl	(%rdx,%r15), %esi
000000010000cc18	xorw	(%rcx), %si
000000010000cc1b	movzbl	0x2(%rdx,%r15), %edx
000000010000cc21	xorb	0x2(%rcx), %dl
000000010000cc24	movzbl	%dl, %ecx
000000010000cc27	orw	%si, %cx
000000010000cc2a	jne	0x10000c978
000000010000cc30	movq	%rbx, %r12
000000010000cc33	movq	%rax, %rbx
000000010000cc36	addq	$0x3, %r15
000000010000cc3a	movq	%r15, 0x10(%rdi)
000000010000cc3e	leaq	0x740c(%rip), %rsi              ## literal pool for: "{"
000000010000cc45	leaq	0x7407(%rip), %rdx              ## literal pool for: "}"
000000010000cc4c	leaq	_tp_kv_item(%rip), %rcx
000000010000cc53	leaq	-0x130(%rbp), %r8
000000010000cc5a	callq	_tp_list_of
000000010000cc5f	testl	%eax, %eax
000000010000cc61	je	0x10000d7ed
000000010000cc67	cmpq	$0x0, -0x118(%rbp)
000000010000cc6f	je	0x10000daaa
000000010000cc75	leaq	_fwp_empty_map(%rip), %rax
000000010000cc7c	xorl	%r14d, %r14d
000000010000cc7f	movq	-0x120(%rbp), %rcx
000000010000cc86	movq	(%rcx,%r14,8), %rdi
000000010000cc8a	movq	0x8(%rcx,%r14,8), %rsi
000000010000cc8f	movq	0x38(%rbx), %rcx
000000010000cc93	movq	%rax, %rdx
000000010000cc96	callq	_fwp_p_map_insert
000000010000cc9b	addq	$0x2, %r14
000000010000cc9f	cmpq	-0x118(%rbp), %r14
000000010000cca6	jb	0x10000cc7f
000000010000cca8	jmp	0x10000dab1
000000010000ccad	pxor	%xmm0, %xmm0
000000010000ccb1	movdqu	%xmm0, -0x118(%rbp)
000000010000ccb9	movdqu	%xmm0, -0x128(%rbp)
000000010000ccc1	movq	$0x0, -0x108(%rbp)
000000010000cccc	movq	0x38(%rax), %rdx
000000010000ccd0	movq	%rdx, -0x130(%rbp)
000000010000ccd7	cmpl	$0x11, %ecx
000000010000ccda	jne	0x10000cd45
000000010000ccdc	cmpq	%rsi, %r15
000000010000ccdf	jae	0x10000cd10
000000010000cce1	movq	(%rdi), %rcx
000000010000cce4	movabsq	$0x100002600, %rdx              ## imm = 0x100002600
000000010000ccee	nop
000000010000ccf0	movzbl	(%rcx,%r15), %r8d
000000010000ccf5	cmpq	$0x20, %r8
000000010000ccf9	ja	0x10000cd10
000000010000ccfb	btq	%r8, %rdx
000000010000ccff	jae	0x10000cd10
000000010000cd01	incq	%r15
000000010000cd04	movq	%r15, 0x10(%rdi)
000000010000cd08	cmpq	%r15, %rsi
000000010000cd0b	jne	0x10000ccf0
000000010000cd0d	movq	%rsi, %r15
000000010000cd10	subq	%r15, %rsi
000000010000cd13	xorl	%r14d, %r14d
000000010000cd16	cmpq	$0x5, %rsi
000000010000cd1a	jb	0x10000c978
000000010000cd20	movq	(%rdi), %rcx
000000010000cd23	movl	$0x61727261, %edx               ## imm = 0x61727261
000000010000cd28	xorl	(%rcx,%r15), %edx
000000010000cd2c	movzbl	0x4(%rcx,%r15), %ecx
000000010000cd32	xorl	$0x79, %ecx
000000010000cd35	orl	%edx, %ecx
000000010000cd37	jne	0x10000c978
000000010000cd3d	addq	$0x5, %r15
000000010000cd41	movq	%r15, 0x10(%rdi)
000000010000cd45	movq	%rax, -0x1d0(%rbp)
000000010000cd4c	leaq	0x72e6(%rip), %rsi              ## literal pool for: "["
000000010000cd53	leaq	0x72e1(%rip), %rdx              ## literal pool for: "]"
000000010000cd5a	leaq	_tp_elem_item(%rip), %rcx
000000010000cd61	leaq	-0x130(%rbp), %r8
000000010000cd68	callq	_tp_list_of
000000010000cd6d	movq	-0x120(%rbp), %r14
000000010000cd74	testl	%eax, %eax
000000010000cd76	je	0x10000d252
000000010000cd7c	movq	%rbx, -0x1e8(%rbp)
000000010000cd83	movq	-0x118(%rbp), %rbx
000000010000cd8a	testq	%rbx, %rbx
000000010000cd8d	je	0x10000d3b0
000000010000cd93	xorl	%r15d, %r15d
000000010000cd96	leaq	-0x1b0(%rbp), %r13
000000010000cd9d	nopl	(%rax)
000000010000cda0	movq	-0x8(%r14,%rbx,8), %r12
000000010000cda5	movq	%r12, -0x1b0(%rbp)
000000010000cdac	movq	%r15, -0x1a8(%rbp)
000000010000cdb3	movl	$0x18, %edi
000000010000cdb8	callq	_fwp_alloc_init
000000010000cdbd	movabsq	$0x200000001, %rcx              ## imm = 0x200000001
000000010000cdc7	movq	%rcx, (%rax)
000000010000cdca	movq	%r12, 0x8(%rax)
000000010000cdce	movq	%r15, 0x10(%rax)
000000010000cdd2	movq	%rax, %r15
000000010000cdd5	decq	%rbx
000000010000cdd8	jne	0x10000cda0
000000010000cdda	jmp	0x10000d3b2
000000010000cddf	movq	%rbx, %r15
000000010000cde2	movq	%rax, %rbx
000000010000cde5	leaq	-0x130(%rbp), %rsi
000000010000cdec	movl	$0x80, %edx
000000010000cdf1	callq	_tp_token
000000010000cdf6	xorl	%r14d, %r14d
000000010000cdf9	cmpq	$0x7f, %rax
000000010000cdfd	ja	0x10000c978
000000010000ce03	movl	-0x130(%rbp), %edx
000000010000ce09	cmpl	$0x666e69, %edx                 ## imm = 0x666E69
000000010000ce0f	jne	0x10000d21c
000000010000ce15	movsd	0x60e3(%rip), %xmm0
000000010000ce1d	movq	%rbx, %rcx
000000010000ce20	jmp	0x10000d806
000000010000ce25	testl	%edx, %edx
000000010000ce27	jne	0x10000c949
000000010000ce2d	movq	0x81fc(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ce34	movq	(%rax), %rax
000000010000ce37	cmpq	-0x30(%rbp), %rax
000000010000ce3b	jne	0x10000e19c
000000010000ce41	movq	%rbx, %rsi
000000010000ce44	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000ce4b	popq	%rbx
000000010000ce4c	popq	%r12
000000010000ce4e	popq	%r13
000000010000ce50	popq	%r14
000000010000ce52	popq	%r15
000000010000ce54	popq	%rbp
000000010000ce55	jmp	_tp_quoted
000000010000ce5a	pxor	%xmm0, %xmm0
000000010000ce5e	movdqa	%xmm0, -0x110(%rbp)
000000010000ce66	movdqa	%xmm0, -0x120(%rbp)
000000010000ce6e	movdqa	%xmm0, -0x130(%rbp)
000000010000ce76	cmpq	%rsi, %r15
000000010000ce79	jae	0x10000ceb0
000000010000ce7b	movq	(%rdi), %rax
000000010000ce7e	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000ce88	nopl	(%rax,%rax)
000000010000ce90	movzbl	(%rax,%r15), %edx
000000010000ce95	cmpq	$0x20, %rdx
000000010000ce99	ja	0x10000ceb0
000000010000ce9b	btq	%rdx, %rcx
000000010000ce9f	jae	0x10000ceb0
000000010000cea1	incq	%r15
000000010000cea4	movq	%r15, 0x10(%rdi)
000000010000cea8	cmpq	%r15, %rsi
000000010000ceab	jne	0x10000ce90
000000010000cead	movq	%rsi, %r15
000000010000ceb0	subq	%r15, %rsi
000000010000ceb3	xorl	%r14d, %r14d
000000010000ceb6	cmpq	$0x5, %rsi
000000010000ceba	jb	0x10000ced9
000000010000cebc	movq	(%rdi), %rax
000000010000cebf	movl	$0x65747962, %ecx               ## imm = 0x65747962
000000010000cec4	xorl	(%rax,%r15), %ecx
000000010000cec8	movzbl	0x4(%rax,%r15), %eax
000000010000cece	xorl	$0x73, %eax
000000010000ced1	orl	%ecx, %eax
000000010000ced3	je	0x10000d73a
000000010000ced9	xorl	%edi, %edi
000000010000cedb	callq	_fwp_mem_free
000000010000cee0	jmp	0x10000c978
000000010000cee5	movq	%rbx, %r15
000000010000cee8	movq	%rax, %rbx
000000010000ceeb	leaq	-0x130(%rbp), %rsi
000000010000cef2	movl	$0x100, %edx                    ## imm = 0x100
000000010000cef7	callq	_tp_token
000000010000cefc	xorl	%r14d, %r14d
000000010000ceff	cmpq	$0x2, %rax
000000010000cf03	jb	0x10000c978
000000010000cf09	cmpb	$0x30, -0x130(%rbp)
000000010000cf10	jne	0x10000c978
000000010000cf16	cmpb	$0x74, -0x12f(%rbp)
000000010000cf1d	jne	0x10000c978
000000010000cf23	leaq	-0x2(%rax), %rcx
000000010000cf27	movslq	0x48(%rbx), %rdx
000000010000cf2b	cmpq	%rdx, %rcx
000000010000cf2e	ja	0x10000c978
000000010000cf34	cmpq	$0x3, %rax
000000010000cf38	jb	0x10000d926
000000010000cf3e	movl	$0x2, %edx
000000010000cf43	xorl	%ecx, %ecx
000000010000cf45	movq	%r15, %rdi
000000010000cf48	jmp	0x10000d18b
000000010000cf4d	leaq	-0x130(%rbp), %rsi
000000010000cf54	movl	$0x10, %edx
000000010000cf59	callq	_tp_token
000000010000cf5e	movzwl	-0x130(%rbp), %eax
000000010000cf65	movl	%eax, %ecx
000000010000cf67	xorl	$0x312b, %ecx                   ## imm = 0x312B
000000010000cf6d	movzbl	-0x12e(%rbp), %edx
000000010000cf74	orw	%cx, %dx
000000010000cf77	sete	%cl
000000010000cf7a	cmpw	$0x31, %ax
000000010000cf7e	sete	%dl
000000010000cf81	orb	%cl, %dl
000000010000cf83	movl	$0x1, %r14d
000000010000cf89	jne	0x10000cfb6
000000010000cf8b	xorl	%r14d, %r14d
000000010000cf8e	cmpw	$0x30, %ax
000000010000cf92	je	0x10000cfb6
000000010000cf94	movl	$0x312d, %eax                   ## imm = 0x312D
000000010000cf99	xorl	-0x130(%rbp), %eax
000000010000cf9f	movzbl	-0x12e(%rbp), %ecx
000000010000cfa6	orw	%ax, %cx
000000010000cfa9	jne	0x10000c978
000000010000cfaf	movq	$-0x1, %r14
000000010000cfb6	movq	%r14, (%rbx)
000000010000cfb9	jmp	0x10000c972
000000010000cfbe	movq	0x8(%rax), %r13
000000010000cfc2	testq	%r13, %r13
000000010000cfc5	movq	%rbx, -0x1e8(%rbp)
000000010000cfcc	je	0x10000d262
000000010000cfd2	movq	%rsi, %rbx
000000010000cfd5	movq	%rdi, -0x1c8(%rbp)
000000010000cfdc	movq	%rax, -0x1d0(%rbp)
000000010000cfe3	leaq	0x706b(%rip), %rsi              ## literal pool for: "Duration"
000000010000cfea	movq	%r13, %rdi
000000010000cfed	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000cff2	testl	%eax, %eax
000000010000cff4	je	0x10000d5de
000000010000cffa	movq	-0x1d0(%rbp), %rax
000000010000d001	movl	0x10(%rax), %r9d
000000010000d005	cmpq	%rbx, %r15
000000010000d008	movq	-0x1c8(%rbp), %rdx
000000010000d00f	movq	%r9, -0x1d8(%rbp)
000000010000d016	jae	0x10000d048
000000010000d018	movq	%rbx, %rcx
000000010000d01b	movq	(%rdx), %rsi
000000010000d01e	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
000000010000d028	movzbl	(%rsi,%r15), %r8d
000000010000d02d	cmpq	$0x20, %r8
000000010000d031	ja	0x10000d048
000000010000d033	btq	%r8, %rdi
000000010000d037	jae	0x10000d048
000000010000d039	incq	%r15
000000010000d03c	movq	%r15, 0x10(%rdx)
000000010000d040	cmpq	%r15, %rcx
000000010000d043	jne	0x10000d028
000000010000d045	movq	%rcx, %r15
000000010000d048	addq	$0x10, %rax
000000010000d04c	movq	%rax, -0x1c0(%rbp)
000000010000d053	movq	%r13, %rdi
000000010000d056	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000d05b	subq	%r15, %rbx
000000010000d05e	cmpq	%rax, %rbx
000000010000d061	jb	0x10000d086
000000010000d063	movq	%rax, %r12
000000010000d066	movq	-0x1c8(%rbp), %rax
000000010000d06d	movq	(%rax), %rdi
000000010000d070	addq	%r15, %rdi
000000010000d073	movq	%r13, %rsi
000000010000d076	movq	%r12, %rdx
000000010000d079	callq	0x100012ca2                     ## symbol stub for: _memcmp
000000010000d07e	testl	%eax, %eax
000000010000d080	je	0x10000dc98
000000010000d086	movq	-0x1d0(%rbp), %rax
000000010000d08d	movq	-0x1c8(%rbp), %rdi
000000010000d094	movq	-0x1c0(%rbp), %r13
000000010000d09b	movq	-0x1d8(%rbp), %rcx
000000010000d0a2	movslq	%ecx, %rcx
000000010000d0a5	leaq	0x8(,%rcx,8), %rcx
000000010000d0ad	leaq	_fwp_gc(%rip), %r12
000000010000d0b4	cmpq	$0x4000, %rcx                   ## imm = 0x4000
000000010000d0bb	ja	0x10000d836
000000010000d0c1	leaq	0xf(%rcx), %rdx
000000010000d0c5	shrq	$0x4, %rdx
000000010000d0c9	movzbl	0xbe8(%rdx,%r12), %edx
000000010000d0d2	movl	0xb48(%r12,%rdx,4), %esi
000000010000d0da	subq	%rsi, _fwp_gc(%rip)
000000010000d0e1	js	0x10000d836
000000010000d0e7	leaq	(%rdx,%rdx,2), %rdx
000000010000d0eb	leaq	(%r12,%rdx,8), %rdx
000000010000d0ef	addq	$0x788, %rdx                    ## imm = 0x788
000000010000d0f6	movq	(%rdx), %r8
000000010000d0f9	testq	%r8, %r8
000000010000d0fc	je	0x10000d822
000000010000d102	movq	%rdi, %r15
000000010000d105	movq	%rax, %rbx
000000010000d108	movq	(%r8), %rax
000000010000d10b	notq	%rax
000000010000d10e	movq	%rax, (%rdx)
000000010000d111	movq	%r8, -0x1e0(%rbp)
000000010000d118	movq	%r8, %rdi
000000010000d11b	jmp	0x10000d950
000000010000d120	movq	(%rdi), %r8
000000010000d123	cmpq	%rsi, %r15
000000010000d126	movq	%rdi, -0x1c8(%rbp)
000000010000d12d	movl	%edx, -0x1d8(%rbp)
000000010000d133	movq	%rbx, -0x1e8(%rbp)
000000010000d13a	jae	0x10000d1b5
000000010000d13c	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000d146	nopw	%cs:(%rax,%rax)
000000010000d150	movzbl	(%r8,%r15), %r9d
000000010000d155	cmpq	$0x20, %r9
000000010000d159	ja	0x10000d1b5
000000010000d15b	btq	%r9, %rcx
000000010000d15f	jae	0x10000d1b5
000000010000d161	incq	%r15
000000010000d164	movq	%r15, 0x10(%rdi)
000000010000d168	cmpq	%r15, %rsi
000000010000d16b	jne	0x10000d150
000000010000d16d	movq	%rax, %rbx
000000010000d170	movq	%rsi, %r15
000000010000d173	jmp	0x10000d42e
000000010000d178	leaq	(%rcx,%rcx,2), %rcx
000000010000d17c	decq	%rcx
000000010000d17f	incq	%rdx
000000010000d182	cmpq	%rdx, %rax
000000010000d185	je	0x10000d930
000000010000d18b	movzbl	-0x130(%rbp,%rdx), %esi
000000010000d193	cmpl	$0x30, %esi
000000010000d196	je	0x10000d1af
000000010000d198	cmpl	$0x2d, %esi
000000010000d19b	je	0x10000d178
000000010000d19d	cmpl	$0x2b, %esi
000000010000d1a0	jne	0x10000e0cc
000000010000d1a6	leaq	(%rcx,%rcx,2), %rcx
000000010000d1aa	incq	%rcx
000000010000d1ad	jmp	0x10000d17f
000000010000d1af	leaq	(%rcx,%rcx,2), %rcx
000000010000d1b3	jmp	0x10000d17f
000000010000d1b5	cmpq	%rsi, %r15
000000010000d1b8	jae	0x10000d3a5
000000010000d1be	movabsq	$0x4000000000003, %r9           ## imm = 0x4000000000003
000000010000d1c8	movq	%r15, %rcx
000000010000d1cb	jmp	0x10000d1e0
000000010000d1cd	nopl	(%rax)
000000010000d1d0	incq	%rcx
000000010000d1d3	movq	%rcx, 0x10(%rdi)
000000010000d1d7	cmpq	%rcx, %rsi
000000010000d1da	je	0x10000d42b
000000010000d1e0	movzbl	(%r8,%rcx), %r10d
000000010000d1e5	leal	-0x30(%r10), %r11d
000000010000d1e9	cmpb	$0xa, %r11b
000000010000d1ed	jb	0x10000d1d0
000000010000d1ef	movl	%r10d, %r11d
000000010000d1f2	andb	$-0x21, %r11b
000000010000d1f6	addb	$-0x41, %r11b
000000010000d1fa	cmpb	$0x1a, %r11b
000000010000d1fe	jb	0x10000d1d0
000000010000d200	movzbl	%r10b, %r10d
000000010000d204	addl	$-0x2d, %r10d
000000010000d208	cmpl	$0x32, %r10d
000000010000d20c	ja	0x10000d214
000000010000d20e	btq	%r10, %r9
000000010000d212	jb	0x10000d1d0
000000010000d214	movq	%rax, %rbx
000000010000d217	jmp	0x10000d431
000000010000d21c	movl	$0x666e692d, %ecx               ## imm = 0x666E692D
000000010000d221	xorl	-0x130(%rbp), %ecx
000000010000d227	movzbl	-0x12c(%rbp), %esi
000000010000d22e	orl	%ecx, %esi
000000010000d230	movq	%rbx, %rcx
000000010000d233	je	0x10000d7fe
000000010000d239	cmpl	$0x4e614e, %edx                 ## imm = 0x4E614E
000000010000d23f	jne	0x10000d855
000000010000d245	movsd	0x5cc3(%rip), %xmm0
000000010000d24d	jmp	0x10000d806
000000010000d252	movq	%r14, %rdi
000000010000d255	callq	_fwp_mem_free
000000010000d25a	xorl	%r14d, %r14d
000000010000d25d	jmp	0x10000c978
000000010000d262	movslq	0x10(%rax), %rcx
000000010000d266	testq	%rcx, %rcx
000000010000d269	je	0x10000d8d0
000000010000d26f	leaq	0x10(%rax), %r13
000000010000d273	cmpl	$0x0, 0x48(%rax)
000000010000d277	je	0x10000d0a2
000000010000d27d	movq	%r13, -0x1c0(%rbp)
000000010000d284	movq	%rax, %rbx
000000010000d287	shlq	$0x3, %rcx
000000010000d28b	movq	%rdi, %r13
000000010000d28e	movq	%rcx, %rdi
000000010000d291	callq	_fwp_alloc
000000010000d296	movq	%rax, -0x1d8(%rbp)
000000010000d29d	leaq	0x6dcb(%rip), %rsi              ## literal pool for: "("
000000010000d2a4	movq	%r13, %r12
000000010000d2a7	movq	%r13, %rdi
000000010000d2aa	callq	_tp_eat
000000010000d2af	testl	%eax, %eax
000000010000d2b1	je	0x10000c978
000000010000d2b7	movq	-0x1c0(%rbp), %rax
000000010000d2be	cmpl	$0x0, (%rax)
000000010000d2c1	movq	%r12, %rdi
000000010000d2c4	jle	0x10000d371
000000010000d2ca	xorl	%r13d, %r13d
000000010000d2cd	movabsq	$0x100002600, %r15              ## imm = 0x100002600
000000010000d2d7	testq	%r13, %r13
000000010000d2da	je	0x10000d330
000000010000d2dc	movq	0x8(%rdi), %rcx
000000010000d2e0	movq	0x10(%rdi), %rax
000000010000d2e4	cmpq	%rcx, %rax
000000010000d2e7	jae	0x10000d310
000000010000d2e9	movq	(%rdi), %rdx
000000010000d2ec	movzbl	(%rdx,%rax), %esi
000000010000d2f0	cmpq	$0x20, %rsi
000000010000d2f4	ja	0x10000d310
000000010000d2f6	btq	%rsi, %r15
000000010000d2fa	jae	0x10000d310
000000010000d2fc	incq	%rax
000000010000d2ff	movq	%rax, 0x10(%rdi)
000000010000d303	xorl	%r14d, %r14d
000000010000d306	cmpq	%rax, %rcx
000000010000d309	jne	0x10000d2ec
000000010000d30b	jmp	0x10000c978
000000010000d310	xorl	%r14d, %r14d
000000010000d313	cmpq	%rax, %rcx
000000010000d316	je	0x10000c978
000000010000d31c	movq	(%rdi), %rcx
000000010000d31f	cmpb	$0x2c, (%rcx,%rax)
000000010000d323	jne	0x10000c978
000000010000d329	incq	%rax
000000010000d32c	movq	%rax, 0x10(%rdi)
000000010000d330	movq	0x20(%rbx), %rax
000000010000d334	movq	(%rax,%r13,8), %rsi
000000010000d338	movq	-0x1d8(%rbp), %rax
000000010000d33f	leaq	(%rax,%r13,8), %rcx
000000010000d343	xorl	%r14d, %r14d
000000010000d346	movq	%r12, %rdi
000000010000d349	xorl	%edx, %edx
000000010000d34b	callq	_tp_value
000000010000d350	testl	%eax, %eax
000000010000d352	je	0x10000c978
000000010000d358	movq	%r12, %rdi
000000010000d35b	incq	%r13
000000010000d35e	movq	-0x1c0(%rbp), %rax
000000010000d365	movslq	(%rax), %rax
000000010000d368	cmpq	%rax, %r13
000000010000d36b	jl	0x10000d2d7
000000010000d371	leaq	0x6cf9(%rip), %rsi              ## literal pool for: ")"
000000010000d378	callq	_tp_eat
000000010000d37d	movl	$0x0, %r14d
000000010000d383	testl	%eax, %eax
000000010000d385	je	0x10000c978
000000010000d38b	movq	-0x1c0(%rbp), %rax
000000010000d392	movl	(%rax), %edi
000000010000d394	movq	-0x1d8(%rbp), %rsi
000000010000d39b	callq	_fwp_record
000000010000d3a0	jmp	0x10000dd72
000000010000d3a5	movq	%rax, %rbx
000000010000d3a8	movq	%r15, %rcx
000000010000d3ab	jmp	0x10000d431
000000010000d3b0	xorl	%eax, %eax
000000010000d3b2	movq	%rax, %rbx
000000010000d3b5	movq	-0x120(%rbp), %rdi
000000010000d3bc	callq	_fwp_mem_free
000000010000d3c1	movq	-0x1d0(%rbp), %rax
000000010000d3c8	cmpl	$0x11, (%rax)
000000010000d3cb	jne	0x10000d423
000000010000d3cd	movq	0x38(%rax), %r14
000000010000d3d1	testq	%rbx, %rbx
000000010000d3d4	je	0x10000d90a
000000010000d3da	movq	%rbx, %rax
000000010000d3dd	xorl	%edi, %edi
000000010000d3df	nop
000000010000d3e0	incq	%rdi
000000010000d3e3	movq	0x10(%rax), %rax
000000010000d3e7	testq	%rax, %rax
000000010000d3ea	jne	0x10000d3e0
000000010000d3ec	movq	%r14, %rsi
000000010000d3ef	callq	_fwp_array_new_packed
000000010000d3f4	movq	%rax, %r15
000000010000d3f7	xorl	%r12d, %r12d
000000010000d3fa	movq	%rbx, %r13
000000010000d3fd	nopl	(%rax)
000000010000d400	movq	0x8(%r13), %rdx
000000010000d404	movq	%r15, %rdi
000000010000d407	movq	%r12, %rsi
000000010000d40a	movq	%r14, %rcx
000000010000d40d	callq	_fwp_array_store
000000010000d412	incq	%r12
000000010000d415	movq	0x10(%r13), %r13
000000010000d419	testq	%r13, %r13
000000010000d41c	jne	0x10000d400
000000010000d41e	jmp	0x10000d917
000000010000d423	movq	%rbx, %r15
000000010000d426	jmp	0x10000d917
000000010000d42b	movq	%rax, %rbx
000000010000d42e	movq	%rsi, %rcx
000000010000d431	subq	%r15, %rcx
000000010000d434	cmpq	$0xff, %rcx
000000010000d43b	movl	$0xff, %r14d
000000010000d441	cmovbq	%rcx, %r14
000000010000d445	addq	%r15, %r8
000000010000d448	leaq	-0x130(%rbp), %rdi
000000010000d44f	movl	$0x100, %ecx                    ## imm = 0x100
000000010000d454	movq	%r8, %rsi
000000010000d457	movq	%r14, %rdx
000000010000d45a	callq	0x100012bfa                     ## symbol stub for: ___memcpy_chk
000000010000d45f	movb	$0x0, -0x130(%rbp,%r14)
000000010000d468	movslq	0x10(%rbx), %r12
000000010000d46c	testq	%r12, %r12
000000010000d46f	movq	%rbx, -0x1d0(%rbp)
000000010000d476	jle	0x10000d4ad
000000010000d478	movq	0x18(%rbx), %r13
000000010000d47c	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000d481	xorl	%r15d, %r15d
000000010000d484	leaq	-0x130(%rbp), %r14
000000010000d48b	nopl	(%rax,%rax)
000000010000d490	movq	(%r13,%r15,8), %rdi
000000010000d495	movq	%r14, %rsi
000000010000d498	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000d49d	testl	%eax, %eax
000000010000d49f	cmovel	%r15d, %ebx
000000010000d4a3	incq	%r15
000000010000d4a6	cmpq	%r15, %r12
000000010000d4a9	jne	0x10000d490
000000010000d4ab	jmp	0x10000d4b2
000000010000d4ad	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000d4b2	cmpl	$0x0, -0x1d8(%rbp)
000000010000d4b9	je	0x10000d536
000000010000d4bb	testl	%ebx, %ebx
000000010000d4bd	movq	-0x1c8(%rbp), %r13
000000010000d4c4	jns	0x10000d52d
000000010000d4c6	movq	-0x1d0(%rbp), %rax
000000010000d4cd	movq	0x8(%rax), %rdi
000000010000d4d1	xorl	%r14d, %r14d
000000010000d4d4	testq	%rdi, %rdi
000000010000d4d7	je	0x10000c978
000000010000d4dd	leaq	0x6b43(%rip), %rsi              ## literal pool for: "Bool"
000000010000d4e4	movq	%rax, %r12
000000010000d4e7	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000d4ec	testl	%eax, %eax
000000010000d4ee	jne	0x10000c978
000000010000d4f4	movq	%r12, %rdx
000000010000d4f7	movl	-0x130(%rbp), %eax
000000010000d4fd	movl	%eax, %esi
000000010000d4ff	xorl	$0x65757274, %esi               ## imm = 0x65757274
000000010000d505	movzbl	-0x12c(%rbp), %edi
000000010000d50c	orl	%esi, %edi
000000010000d50e	movl	$0x1, %esi
000000010000d513	cmovel	%esi, %ebx
000000010000d516	xorl	$0x736c6166, %eax               ## imm = 0x736C6166
000000010000d51b	movzwl	-0x12c(%rbp), %esi
000000010000d522	xorl	$0x65, %esi
000000010000d525	orl	%eax, %esi
000000010000d527	jne	0x10000d544
000000010000d529	xorl	%ebx, %ebx
000000010000d52b	jmp	0x10000d54c
000000010000d52d	movq	-0x1d0(%rbp), %rdx
000000010000d534	jmp	0x10000d544
000000010000d536	movq	-0x1d0(%rbp), %rdx
000000010000d53d	movq	-0x1c8(%rbp), %r13
000000010000d544	testl	%ebx, %ebx
000000010000d546	js	0x10000e0cc
000000010000d54c	movq	0x28(%rdx), %rax
000000010000d550	movl	%ebx, %esi
000000010000d552	movq	%rsi, -0x1d8(%rbp)
000000010000d559	movslq	(%rax,%rsi,4), %r15
000000010000d55d	movl	%r15d, %r9d
000000010000d560	leaq	0x8(,%r15,8), %rdi
000000010000d568	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000d56f	movq	%r9, -0x1e0(%rbp)
000000010000d576	ja	0x10000d8b7
000000010000d57c	leaq	0xf(%rdi), %rsi
000000010000d580	shrq	$0x4, %rsi
000000010000d584	leaq	_fwp_gc(%rip), %rax
000000010000d58b	movzbl	0xbe8(%rsi,%rax), %r8d
000000010000d594	movl	0xb48(%rax,%r8,4), %esi
000000010000d59c	subq	%rsi, _fwp_gc(%rip)
000000010000d5a3	js	0x10000d8b7
000000010000d5a9	leaq	(%r8,%r8,2), %r8
000000010000d5ad	leaq	(%rax,%r8,8), %rax
000000010000d5b1	addq	$0x788, %rax                    ## imm = 0x788
000000010000d5b7	movq	(%rax), %r8
000000010000d5ba	testq	%r8, %r8
000000010000d5bd	je	0x10000d8a3
000000010000d5c3	movq	%rdx, %r14
000000010000d5c6	movq	(%r8), %rcx
000000010000d5c9	notq	%rcx
000000010000d5cc	movq	%rcx, (%rax)
000000010000d5cf	movq	%r8, -0x1c0(%rbp)
000000010000d5d6	movq	%r8, %rdi
000000010000d5d9	jmp	0x10000dae6
000000010000d5de	leaq	-0x130(%rbp), %rsi
000000010000d5e5	movl	$0x80, %edx
000000010000d5ea	movq	-0x1c8(%rbp), %rdi
000000010000d5f1	callq	_tp_token
000000010000d5f6	movq	%rax, %r14
000000010000d5f9	addq	%rbp, %rax
000000010000d5fc	addq	$-0x130, %rax                   ## imm = 0xFED0
000000010000d602	movq	%rax, -0x1d0(%rbp)
000000010000d609	xorl	%ebx, %ebx
000000010000d60b	jmp	0x10000d61a
000000010000d60d	incq	%rbx
000000010000d610	cmpq	$0x6, %rbx
000000010000d614	je	0x10000e0cc
000000010000d61a	movq	%rbx, %r12
000000010000d61d	shlq	$0x4, %r12
000000010000d621	leaq	_tp_value.units(%rip), %rax
000000010000d628	movq	(%r12,%rax), %r15
000000010000d62c	movq	%r15, %rdi
000000010000d62f	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000d634	movq	%r14, %r13
000000010000d637	subq	%rax, %r13
000000010000d63a	jbe	0x10000d60d
000000010000d63c	movq	-0x1d0(%rbp), %rdi
000000010000d643	subq	%rax, %rdi
000000010000d646	movq	%r15, %rsi
000000010000d649	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000d64e	testl	%eax, %eax
000000010000d650	jne	0x10000d60d
000000010000d652	leaq	_tp_value.units(%rip), %rax
000000010000d659	addq	%rax, %r12
000000010000d65c	movl	$0x80, %ecx
000000010000d661	leaq	-0x1b0(%rbp), %rdi
000000010000d668	leaq	-0x130(%rbp), %rsi
000000010000d66f	movq	%r13, %rdx
000000010000d672	callq	0x100012bfa                     ## symbol stub for: ___memcpy_chk
000000010000d677	movb	$0x0, -0x1b0(%rbp,%r13)
000000010000d680	movzbl	-0x1b0(%rbp), %esi
000000010000d687	leal	-0x2b(%rsi), %eax
000000010000d68a	xorl	%ecx, %ecx
000000010000d68c	testb	$-0x3, %al
000000010000d68e	sete	%cl
000000010000d691	cmpq	%rcx, %r13
000000010000d694	je	0x10000d60d
000000010000d69a	jbe	0x10000d6b8
000000010000d69c	movzbl	-0x1b0(%rbp,%rcx), %edx
000000010000d6a4	addb	$-0x3a, %dl
000000010000d6a7	cmpb	$-0xa, %dl
000000010000d6aa	jb	0x10000d60d
000000010000d6b0	incq	%rcx
000000010000d6b3	cmpq	%rcx, %r13
000000010000d6b6	jne	0x10000d69c
000000010000d6b8	xorl	%ecx, %ecx
000000010000d6ba	testb	$-0x3, %al
000000010000d6bc	sete	%cl
000000010000d6bf	movzbl	-0x1b0(%rbp,%rcx), %r10d
000000010000d6c8	xorl	%r14d, %r14d
000000010000d6cb	testb	%r10b, %r10b
000000010000d6ce	je	0x10000dcd4
000000010000d6d4	leaq	-0x1b0(%rbp), %rax
000000010000d6db	addq	%rax, %rcx
000000010000d6de	incq	%rcx
000000010000d6e1	xorl	%eax, %eax
000000010000d6e3	movl	$0xa, %edi
000000010000d6e8	movabsq	$-0x8000000000000000, %r9       ## imm = 0x8000000000000000
000000010000d6f2	xorl	%r8d, %r8d
000000010000d6f5	mulq	%rdi
000000010000d6f8	leaq	(%r8,%r8,4), %r8
000000010000d6fc	leaq	(%rdx,%r8,2), %rdx
000000010000d700	movsbl	%r10b, %r8d
000000010000d704	addl	$-0x30, %r8d
000000010000d708	movslq	%r8d, %r10
000000010000d70b	movq	%r10, %r8
000000010000d70e	sarq	$0x3f, %r8
000000010000d712	addq	%r10, %rax
000000010000d715	adcq	%rdx, %r8
000000010000d718	cmpq	%rax, %r9
000000010000d71b	movl	$0x0, %edx
000000010000d720	sbbq	%r8, %rdx
000000010000d723	jl	0x10000e0cc
000000010000d729	movzbl	(%rcx), %r10d
000000010000d72d	incq	%rcx
000000010000d730	testb	%r10b, %r10b
000000010000d733	jne	0x10000d6f5
000000010000d735	jmp	0x10000dcd9
000000010000d73a	addq	$0x5, %r15
000000010000d73e	movq	%r15, 0x10(%rdi)
000000010000d742	leaq	0x68f0(%rip), %rsi              ## literal pool for: "["
000000010000d749	leaq	0x68eb(%rip), %rdx              ## literal pool for: "]"
000000010000d750	leaq	_tp_byte_item(%rip), %rcx
000000010000d757	leaq	-0x130(%rbp), %r8
000000010000d75e	callq	_tp_list_of
000000010000d763	testl	%eax, %eax
000000010000d765	je	0x10000d7ed
000000010000d76b	movq	%rbx, %r12
000000010000d76e	pxor	%xmm0, %xmm0
000000010000d772	movdqa	%xmm0, -0x1b0(%rbp)
000000010000d77a	movq	$0x0, -0x1a0(%rbp)
000000010000d785	cmpq	$0x0, -0x118(%rbp)
000000010000d78d	je	0x10000d7cc
000000010000d78f	xorl	%ebx, %ebx
000000010000d791	leaq	-0x1b0(%rbp), %r14
000000010000d798	leaq	-0x1b8(%rbp), %r15
000000010000d79f	movq	-0x120(%rbp), %rax
000000010000d7a6	movzbl	(%rax,%rbx,8), %eax
000000010000d7aa	movb	%al, -0x1b8(%rbp)
000000010000d7b0	movl	$0x1, %edx
000000010000d7b5	movq	%r14, %rdi
000000010000d7b8	movq	%r15, %rsi
000000010000d7bb	callq	_buf_put
000000010000d7c0	incq	%rbx
000000010000d7c3	cmpq	-0x118(%rbp), %rbx
000000010000d7ca	jb	0x10000d79f
000000010000d7cc	movq	-0x120(%rbp), %rdi
000000010000d7d3	callq	_fwp_mem_free
000000010000d7d8	leaq	-0x1b0(%rbp), %rdi
000000010000d7df	callq	_buf_to_str
000000010000d7e4	movq	%rax, (%r12)
000000010000d7e8	jmp	0x10000c972
000000010000d7ed	movq	-0x120(%rbp), %rdi
000000010000d7f4	callq	_fwp_mem_free
000000010000d7f9	jmp	0x10000c978
000000010000d7fe	movsd	0x5702(%rip), %xmm0
000000010000d806	cmpl	$0xa, (%rcx)
000000010000d809	cvtsd2ss	%xmm0, %xmm1
000000010000d80d	movd	%xmm1, %ecx
000000010000d811	movq	%xmm0, %rax
000000010000d816	cmoveq	%rcx, %rax
000000010000d81a	movq	%rax, (%r15)
000000010000d81d	jmp	0x10000c972
000000010000d822	movq	0x8(%rdx), %r9
000000010000d826	movq	0x10(%rdx), %r8
000000010000d82a	subq	%r9, %r8
000000010000d82d	cmpq	%rsi, %r8
000000010000d830	jae	0x10000d938
000000010000d836	movq	%rdi, %r15
000000010000d839	movq	%rax, %rbx
000000010000d83c	movq	%rcx, %rdi
000000010000d83f	movl	$0x2, %esi
000000010000d844	callq	_fwp_gc_alloc_slow
000000010000d849	movq	%rax, -0x1e0(%rbp)
000000010000d850	jmp	0x10000d955
000000010000d855	testq	%rax, %rax
000000010000d858	setne	%sil
000000010000d85c	addb	$-0x2b, %dl
000000010000d85f	testb	$-0x3, %dl
000000010000d862	sete	%dl
000000010000d865	andb	%sil, %dl
000000010000d868	movzbl	%dl, %esi
000000010000d86b	movb	$0x1, %r8b
000000010000d86e	movq	%rsi, %rdi
000000010000d871	cmpq	%rsi, %rax
000000010000d874	jbe	0x10000dac9
000000010000d87a	movzbl	-0x130(%rbp,%rdi), %edx
000000010000d882	leal	-0x30(%rdx), %r9d
000000010000d886	cmpb	$0x9, %r9b
000000010000d88a	ja	0x10000dd81
000000010000d890	incq	%rdi
000000010000d893	cmpq	%rdi, %rax
000000010000d896	jne	0x10000d87a
000000010000d898	movq	%rax, %rdi
000000010000d89b	movq	%rax, %rdx
000000010000d89e	jmp	0x10000e0d7
000000010000d8a3	movq	0x8(%rax), %r10
000000010000d8a7	movq	0x10(%rax), %r8
000000010000d8ab	subq	%r10, %r8
000000010000d8ae	cmpq	%rsi, %r8
000000010000d8b1	jae	0x10000dad1
000000010000d8b7	movq	%rdx, %r14
000000010000d8ba	movl	$0x2, %esi
000000010000d8bf	callq	_fwp_gc_alloc_slow
000000010000d8c4	movq	%rax, -0x1c0(%rbp)
000000010000d8cb	jmp	0x10000daeb
000000010000d8d0	leaq	0x6798(%rip), %rsi              ## literal pool for: "("
000000010000d8d7	movq	%rdi, %r15
000000010000d8da	callq	_tp_eat
000000010000d8df	testl	%eax, %eax
000000010000d8e1	je	0x10000c978
000000010000d8e7	leaq	0x6783(%rip), %rsi              ## literal pool for: ")"
000000010000d8ee	movq	%r15, %rdi
000000010000d8f1	callq	_tp_eat
000000010000d8f6	testl	%eax, %eax
000000010000d8f8	je	0x10000c978
000000010000d8fe	movq	$0x0, (%rbx)
000000010000d905	jmp	0x10000c972
000000010000d90a	xorl	%edi, %edi
000000010000d90c	movq	%r14, %rsi
000000010000d90f	callq	_fwp_array_new_packed
000000010000d914	movq	%rax, %r15
000000010000d917	movq	-0x1e8(%rbp), %rax
000000010000d91e	movq	%r15, (%rax)
000000010000d921	jmp	0x10000c972
000000010000d926	xorl	%ecx, %ecx
000000010000d928	movq	%rcx, (%r15)
000000010000d92b	jmp	0x10000c972
000000010000d930	movq	%rcx, (%rdi)
000000010000d933	jmp	0x10000c972
000000010000d938	movq	%rdi, %r15
000000010000d93b	movq	%rax, %rbx
000000010000d93e	leaq	(%r9,%rsi), %rax
000000010000d942	movq	%rax, 0x8(%rdx)
000000010000d946	movq	%r9, -0x1e0(%rbp)
000000010000d94d	movq	%r9, %rdi
000000010000d950	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000d955	movslq	(%r13), %rax
000000010000d959	leaq	0x1(%rax), %rsi
000000010000d95d	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000d964	ja	0x10000d9bb
000000010000d966	addq	$0x10, %rax
000000010000d96a	shrq	$0x4, %rax
000000010000d96e	movzbl	0xbe8(%rax,%r12), %ecx
000000010000d977	movl	0xb48(%r12,%rcx,4), %eax
000000010000d97f	subq	%rax, _fwp_gc(%rip)
000000010000d986	js	0x10000d9bb
000000010000d988	leaq	(%rcx,%rcx,2), %rcx
000000010000d98c	leaq	(%r12,%rcx,8), %rcx
000000010000d990	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000d997	movq	(%rcx), %r12
000000010000d99a	testq	%r12, %r12
000000010000d99d	je	0x10000d9ab
000000010000d99f	movq	(%r12), %rax
000000010000d9a3	notq	%rax
000000010000d9a6	movq	%rax, (%rcx)
000000010000d9a9	jmp	0x10000d9d4
000000010000d9ab	movq	0x8(%rcx), %r12
000000010000d9af	movq	0x10(%rcx), %rdx
000000010000d9b3	subq	%r12, %rdx
000000010000d9b6	cmpq	%rax, %rdx
000000010000d9b9	jae	0x10000d9cd
000000010000d9bb	movq	%rsi, %rdi
000000010000d9be	movl	$0x1, %esi
000000010000d9c3	callq	_fwp_gc_alloc_slow
000000010000d9c8	movq	%rax, %r12
000000010000d9cb	jmp	0x10000d9dc
000000010000d9cd	addq	%r12, %rax
000000010000d9d0	movq	%rax, 0x8(%rcx)
000000010000d9d4	movq	%r12, %rdi
000000010000d9d7	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000d9dc	movslq	(%r13), %rsi
000000010000d9e0	incq	%rsi
000000010000d9e3	movq	%r12, %rdi
000000010000d9e6	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000d9eb	movq	0x8(%r15), %rcx
000000010000d9ef	movq	0x10(%r15), %rax
000000010000d9f3	cmpq	%rcx, %rax
000000010000d9f6	jae	0x10000da26
000000010000d9f8	movq	(%r15), %rdx
000000010000d9fb	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000da05	movzbl	(%rdx,%rax), %edi
000000010000da09	cmpq	$0x20, %rdi
000000010000da0d	ja	0x10000da26
000000010000da0f	btq	%rdi, %rsi
000000010000da13	jae	0x10000da26
000000010000da15	incq	%rax
000000010000da18	movq	%rax, 0x10(%r15)
000000010000da1c	cmpq	%rax, %rcx
000000010000da1f	jne	0x10000da05
000000010000da21	jmp	0x10000c978
000000010000da26	cmpq	%rax, %rcx
000000010000da29	je	0x10000c978
000000010000da2f	movq	%r13, -0x1c0(%rbp)
000000010000da36	movq	(%r15), %rcx
000000010000da39	cmpb	$0x7b, (%rcx,%rax)
000000010000da3d	jne	0x10000c978
000000010000da43	incq	%rax
000000010000da46	movq	%rax, 0x10(%r15)
000000010000da4a	leaq	0x6602(%rip), %rsi              ## literal pool for: "}"
000000010000da51	movq	%r15, -0x1c8(%rbp)
000000010000da58	movq	%r15, %rdi
000000010000da5b	callq	_tp_eat
000000010000da60	testl	%eax, %eax
000000010000da62	je	0x10000de62
000000010000da68	movq	-0x1c0(%rbp), %rax
000000010000da6f	movslq	(%rax), %rdi
000000010000da72	testq	%rdi, %rdi
000000010000da75	movq	-0x1e8(%rbp), %rbx
000000010000da7c	movq	-0x1e0(%rbp), %rsi
000000010000da83	jle	0x10000da9d
000000010000da85	xorl	%r14d, %r14d
000000010000da88	xorl	%eax, %eax
000000010000da8a	cmpb	$0x0, (%r12,%rax)
000000010000da8f	je	0x10000c978
000000010000da95	incq	%rax
000000010000da98	cmpq	%rax, %rdi
000000010000da9b	jne	0x10000da8a
000000010000da9d	callq	_fwp_record
000000010000daa2	movq	%rax, (%rbx)
000000010000daa5	jmp	0x10000c972
000000010000daaa	leaq	_fwp_empty_map(%rip), %rax
000000010000dab1	movq	-0x120(%rbp), %rdi
000000010000dab8	movq	%rax, %rbx
000000010000dabb	callq	_fwp_mem_free
000000010000dac0	movq	%rbx, (%r12)
000000010000dac4	jmp	0x10000c972
000000010000dac9	movq	%rsi, %rdx
000000010000dacc	jmp	0x10000e0d7
000000010000dad1	movq	%rdx, %r14
000000010000dad4	leaq	(%r10,%rsi), %rcx
000000010000dad8	movq	%rcx, 0x8(%rax)
000000010000dadc	movq	%r10, -0x1c0(%rbp)
000000010000dae3	movq	%r10, %rdi
000000010000dae6	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000daeb	movq	%r15, -0x1f0(%rbp)
000000010000daf2	testl	%r15d, %r15d
000000010000daf5	jle	0x10000dc50
000000010000dafb	movq	%r14, %rax
000000010000dafe	xorl	%r15d, %r15d
000000010000db01	movabsq	$0x100002600, %r12              ## imm = 0x100002600
000000010000db0b	movq	0x30(%rax), %rcx
000000010000db0f	movq	-0x1d8(%rbp), %rdx
000000010000db16	movq	(%rcx,%rdx,8), %rcx
000000010000db1a	movq	(%rcx,%r15,8), %rsi
000000010000db1e	movq	0x8(%r13), %rdi
000000010000db22	movq	0x10(%r13), %rdx
000000010000db26	cmpq	%rdi, %rdx
000000010000db29	jae	0x10000db50
000000010000db2b	movq	(%r13), %rcx
000000010000db2f	nop
000000010000db30	movzbl	(%rcx,%rdx), %r8d
000000010000db35	cmpq	$0x20, %r8
000000010000db39	ja	0x10000db50
000000010000db3b	btq	%r8, %r12
000000010000db3f	jae	0x10000db50
000000010000db41	incq	%rdx
000000010000db44	movq	%rdx, 0x10(%r13)
000000010000db48	cmpq	%rdx, %rdi
000000010000db4b	jne	0x10000db30
000000010000db4d	movq	%rdi, %rdx
000000010000db50	cmpl	$0x10, (%rsi)
000000010000db53	jne	0x10000db60
000000010000db55	cmpq	$0x0, 0x8(%rsi)
000000010000db5a	je	0x10000dc12
000000010000db60	xorl	%r8d, %r8d
000000010000db63	movq	-0x1c0(%rbp), %rax
000000010000db6a	leaq	(%rax,%r15,8), %rcx
000000010000db6e	cmpq	%rdi, %rdx
000000010000db71	jae	0x10000db85
000000010000db73	movq	(%r13), %rax
000000010000db77	cmpb	$0x28, (%rax,%rdx)
000000010000db7b	setne	%al
000000010000db7e	orb	%r8b, %al
000000010000db81	testb	$0x1, %al
000000010000db83	je	0x10000dbb6
000000010000db85	xorl	%r14d, %r14d
000000010000db88	movq	%r13, %rdi
000000010000db8b	xorl	%edx, %edx
000000010000db8d	callq	_tp_value
000000010000db92	testl	%eax, %eax
000000010000db94	movq	-0x1d0(%rbp), %rax
000000010000db9b	je	0x10000c978
000000010000dba1	incq	%r15
000000010000dba4	cmpq	-0x1e0(%rbp), %r15
000000010000dbab	jne	0x10000db0b
000000010000dbb1	jmp	0x10000dc50
000000010000dbb6	incq	%rdx
000000010000dbb9	movq	%rdx, 0x10(%r13)
000000010000dbbd	xorl	%r14d, %r14d
000000010000dbc0	movq	%r13, %rdi
000000010000dbc3	xorl	%edx, %edx
000000010000dbc5	callq	_tp_value
000000010000dbca	testl	%eax, %eax
000000010000dbcc	je	0x10000c978
000000010000dbd2	movq	-0x1c8(%rbp), %r13
000000010000dbd9	movq	0x8(%r13), %rdx
000000010000dbdd	movq	0x10(%r13), %rcx
000000010000dbe1	cmpq	%rdx, %rcx
000000010000dbe4	movq	-0x1d0(%rbp), %rax
000000010000dbeb	jae	0x10000dc25
000000010000dbed	movq	(%r13), %rsi
000000010000dbf1	movzbl	(%rsi,%rcx), %edi
000000010000dbf5	cmpq	$0x20, %rdi
000000010000dbf9	ja	0x10000dc25
000000010000dbfb	btq	%rdi, %r12
000000010000dbff	jae	0x10000dc25
000000010000dc01	incq	%rcx
000000010000dc04	movq	%rcx, 0x10(%r13)
000000010000dc08	cmpq	%rcx, %rdx
000000010000dc0b	jne	0x10000dbf1
000000010000dc0d	jmp	0x10000c978
000000010000dc12	cmpl	$0x0, 0x10(%rsi)
000000010000dc16	je	0x10000dc48
000000010000dc18	cmpl	$0x0, 0x48(%rsi)
000000010000dc1c	setne	%r8b
000000010000dc20	jmp	0x10000db63
000000010000dc25	cmpq	%rcx, %rdx
000000010000dc28	je	0x10000c978
000000010000dc2e	movq	(%r13), %rdx
000000010000dc32	cmpb	$0x29, (%rdx,%rcx)
000000010000dc36	jne	0x10000c978
000000010000dc3c	incq	%rcx
000000010000dc3f	movq	%rcx, 0x10(%r13)
000000010000dc43	jmp	0x10000dba1
000000010000dc48	movb	$0x1, %r8b
000000010000dc4b	jmp	0x10000db63
000000010000dc50	movq	-0x1f0(%rbp), %r15
000000010000dc57	testl	%r15d, %r15d
000000010000dc5a	movq	-0x1d8(%rbp), %rdi
000000010000dc61	je	0x10000de53
000000010000dc67	movq	-0x1e0(%rbp), %r14
000000010000dc6e	leaq	0x8(,%r14,8), %rdi
000000010000dc76	callq	_fwp_alloc_init
000000010000dc7b	movq	%rax, %rdi
000000010000dc7e	movl	%ebx, (%rax)
000000010000dc80	movl	%r15d, 0x4(%rax)
000000010000dc84	cmpl	$0x7, %r15d
000000010000dc88	ja	0x10000dcb2
000000010000dc8a	xorl	%eax, %eax
000000010000dc8c	movq	-0x1c0(%rbp), %r8
000000010000dc93	jmp	0x10000ddfa
000000010000dc98	addq	%r12, %r15
000000010000dc9b	movq	-0x1c8(%rbp), %rdi
000000010000dca2	movq	%r15, 0x10(%rdi)
000000010000dca6	movq	-0x1d0(%rbp), %rax
000000010000dcad	jmp	0x10000d094
000000010000dcb2	movq	%rdi, %rax
000000010000dcb5	movq	-0x1c0(%rbp), %r8
000000010000dcbc	subq	%r8, %rax
000000010000dcbf	addq	$0x8, %rax
000000010000dcc3	cmpq	$0x20, %rax
000000010000dcc7	jae	0x10000ddc1
000000010000dccd	xorl	%eax, %eax
000000010000dccf	jmp	0x10000ddfa
000000010000dcd4	xorl	%eax, %eax
000000010000dcd6	xorl	%r8d, %r8d
000000010000dcd9	movq	%rax, %rcx
000000010000dcdc	negq	%rcx
000000010000dcdf	movl	$0x0, %edi
000000010000dce4	sbbq	%r8, %rdi
000000010000dce7	cmpb	$0x2d, %sil
000000010000dceb	cmovneq	%r8, %rdi
000000010000dcef	cmovneq	%rax, %rcx
000000010000dcf3	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000dcfd	cmpq	%rcx, %rax
000000010000dd00	movl	$0x0, %eax
000000010000dd05	sbbq	%rdi, %rax
000000010000dd08	jl	0x10000c978
000000010000dd0e	movq	0x8(%r12), %rsi
000000010000dd13	movq	%rcx, %rax
000000010000dd16	mulq	%rsi
000000010000dd19	imulq	%rsi, %rdi
000000010000dd1d	sarq	$0x3f, %rsi
000000010000dd21	imulq	%rcx, %rsi
000000010000dd25	addq	%rdx, %rsi
000000010000dd28	addq	%rsi, %rdi
000000010000dd2b	movabsq	$-0x8000000000000000, %rcx      ## imm = 0x8000000000000000
000000010000dd35	addq	%rax, %rcx
000000010000dd38	adcq	$-0x1, %rdi
000000010000dd3c	cmpq	$-0x1, %rdi
000000010000dd40	jne	0x10000c978
000000010000dd46	movq	%rax, -0x1b8(%rbp)
000000010000dd4d	movl	$0x10, %edi
000000010000dd52	movq	%rax, %rbx
000000010000dd55	callq	_fwp_alloc_init
000000010000dd5a	movabsq	$__mh_execute_header, %rcx
000000010000dd64	movq	%rcx, (%rax)
000000010000dd67	movq	%rbx, 0x8(%rax)
000000010000dd6b	leaq	-0x1b8(%rbp), %rcx
000000010000dd72	movq	-0x1e8(%rbp), %rcx
000000010000dd79	movq	%rax, (%rcx)
000000010000dd7c	jmp	0x10000c972
000000010000dd81	cmpb	$0x2e, %dl
000000010000dd84	jne	0x10000e0d4
000000010000dd8a	leaq	0x1(%rdi), %rdx
000000010000dd8e	cmpq	%rax, %rdx
000000010000dd91	jae	0x10000ddb1
000000010000dd93	movzbl	-0x130(%rbp,%rdx), %r8d
000000010000dd9c	addb	$-0x30, %r8b
000000010000dda0	cmpb	$0x9, %r8b
000000010000dda4	ja	0x10000ddb1
000000010000dda6	incq	%rdx
000000010000dda9	cmpq	%rax, %rdx
000000010000ddac	jb	0x10000dd93
000000010000ddae	movq	%rax, %rdx
000000010000ddb1	leaq	-0x1(%rdx), %r8
000000010000ddb5	cmpq	%rdi, %r8
000000010000ddb8	sete	%r8b
000000010000ddbc	jmp	0x10000e0d7
000000010000ddc1	movl	%r14d, %eax
000000010000ddc4	andl	$-0x4, %eax
000000010000ddc7	leaq	(,%r14,8), %rcx
000000010000ddcf	andq	$-0x20, %rcx
000000010000ddd3	xorl	%edx, %edx
000000010000ddd5	movdqu	(%r8,%rdx), %xmm0
000000010000dddb	movups	0x10(%r8,%rdx), %xmm1
000000010000dde1	movdqu	%xmm0, 0x8(%rdi,%rdx)
000000010000dde7	movups	%xmm1, 0x18(%rdi,%rdx)
000000010000ddec	addq	$0x20, %rdx
000000010000ddf0	cmpq	%rdx, %rcx
000000010000ddf3	jne	0x10000ddd5
000000010000ddf5	cmpl	%r14d, %eax
000000010000ddf8	je	0x10000de53
000000010000ddfa	movq	%r14, %rdx
000000010000ddfd	movq	%rax, %rcx
000000010000de00	andq	$0x3, %rdx
000000010000de04	je	0x10000de1a
000000010000de06	movq	%rax, %rcx
000000010000de09	movq	(%r8,%rcx,8), %rsi
000000010000de0d	movq	%rsi, 0x8(%rdi,%rcx,8)
000000010000de12	incq	%rcx
000000010000de15	decq	%rdx
000000010000de18	jne	0x10000de09
000000010000de1a	subq	%r14, %rax
000000010000de1d	cmpq	$-0x4, %rax
000000010000de21	ja	0x10000de53
000000010000de23	movq	(%r8,%rcx,8), %rax
000000010000de27	movq	%rax, 0x8(%rdi,%rcx,8)
000000010000de2c	movq	0x8(%r8,%rcx,8), %rax
000000010000de31	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000de36	movq	0x10(%r8,%rcx,8), %rax
000000010000de3b	movq	%rax, 0x18(%rdi,%rcx,8)
000000010000de40	movq	0x18(%r8,%rcx,8), %rax
000000010000de45	movq	%rax, 0x20(%rdi,%rcx,8)
000000010000de4a	addq	$0x4, %rcx
000000010000de4e	cmpq	%rcx, %r14
000000010000de51	jne	0x10000de23
000000010000de53	movq	-0x1e8(%rbp), %rax
000000010000de5a	movq	%rdi, (%rax)
000000010000de5d	jmp	0x10000c972
000000010000de62	movq	%r12, -0x1f8(%rbp)
000000010000de69	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000de73	movl	$0xff, %r8d
000000010000de79	leaq	-0x130(%rbp), %r9
000000010000de80	movq	-0x1c8(%rbp), %rcx
000000010000de87	movq	-0x1c0(%rbp), %r12
000000010000de8e	movq	%rbx, -0x1d0(%rbp)
000000010000de95	movq	(%rcx), %rbx
000000010000de98	movq	0x8(%rcx), %r10
000000010000de9c	movq	0x10(%rcx), %rsi
000000010000dea0	cmpq	%r10, %rsi
000000010000dea3	movq	%r10, -0x1f0(%rbp)
000000010000deaa	jae	0x10000ded0
000000010000deac	movzbl	(%rbx,%rsi), %eax
000000010000deb0	cmpq	$0x20, %rax
000000010000deb4	ja	0x10000ded0
000000010000deb6	btq	%rax, %r13
000000010000deba	jae	0x10000ded0
000000010000debc	incq	%rsi
000000010000debf	movq	%rsi, 0x10(%rcx)
000000010000dec3	cmpq	%rsi, %r10
000000010000dec6	jne	0x10000deac
000000010000dec8	movq	%r10, %r14
000000010000decb	movq	%r10, %rsi
000000010000dece	jmp	0x10000df20
000000010000ded0	movabsq	$0x4000000000003, %rdi          ## imm = 0x4000000000003
000000010000deda	movq	%rsi, %r14
000000010000dedd	cmpq	%r10, %rsi
000000010000dee0	jb	0x10000def0
000000010000dee2	jmp	0x10000df20
000000010000dee4	incq	%r14
000000010000dee7	movq	%r14, 0x10(%rcx)
000000010000deeb	cmpq	%r14, %r10
000000010000deee	je	0x10000df1d
000000010000def0	movzbl	(%rbx,%r14), %eax
000000010000def5	leal	-0x30(%rax), %edx
000000010000def8	cmpb	$0xa, %dl
000000010000defb	jb	0x10000dee4
000000010000defd	movl	%eax, %edx
000000010000deff	andb	$-0x21, %dl
000000010000df02	addb	$-0x41, %dl
000000010000df05	cmpb	$0x1a, %dl
000000010000df08	jb	0x10000dee4
000000010000df0a	movzbl	%al, %eax
000000010000df0d	addl	$-0x2d, %eax
000000010000df10	cmpl	$0x32, %eax
000000010000df13	ja	0x10000df20
000000010000df15	btq	%rax, %rdi
000000010000df19	jb	0x10000dee4
000000010000df1b	jmp	0x10000df20
000000010000df1d	movq	%r10, %r14
000000010000df20	movq	%r14, %r15
000000010000df23	subq	%rsi, %r15
000000010000df26	cmpq	$0xff, %r15
000000010000df2d	cmovaeq	%r8, %r15
000000010000df31	addq	%rbx, %rsi
000000010000df34	movl	$0x100, %ecx                    ## imm = 0x100
000000010000df39	movq	%r9, %rdi
000000010000df3c	movq	%r15, %rdx
000000010000df3f	callq	0x100012bfa                     ## symbol stub for: ___memcpy_chk
000000010000df44	movb	$0x0, -0x130(%rbp,%r15)
000000010000df4d	movslq	(%r12), %rcx
000000010000df51	testq	%rcx, %rcx
000000010000df54	movq	-0x1d0(%rbp), %rax
000000010000df5b	jle	0x10000e0cc
000000010000df61	movq	%rbx, -0x200(%rbp)
000000010000df68	movq	0x18(%rax), %rax
000000010000df6c	movq	%rax, -0x1d8(%rbp)
000000010000df73	movl	$0xffffffff, %r15d              ## imm = 0xFFFFFFFF
000000010000df79	xorl	%r13d, %r13d
000000010000df7c	leaq	-0x130(%rbp), %r12
000000010000df83	movq	-0x1d8(%rbp), %rax
000000010000df8a	movq	(%rax,%r13,8), %rdi
000000010000df8e	movq	%r12, %rsi
000000010000df91	movq	%rcx, %rbx
000000010000df94	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000df99	movq	%rbx, %rcx
000000010000df9c	testl	%eax, %eax
000000010000df9e	cmovel	%r13d, %r15d
000000010000dfa2	incq	%r13
000000010000dfa5	cmpq	%r13, %rbx
000000010000dfa8	jne	0x10000df83
000000010000dfaa	testl	%r15d, %r15d
000000010000dfad	movq	-0x1d0(%rbp), %rax
000000010000dfb4	movq	-0x1c8(%rbp), %rcx
000000010000dfbb	movq	-0x1c0(%rbp), %r12
000000010000dfc2	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000dfcc	movq	-0x200(%rbp), %rsi
000000010000dfd3	movq	-0x1f0(%rbp), %rdi
000000010000dfda	js	0x10000e0cc
000000010000dfe0	cmpq	%rdi, %r14
000000010000dfe3	jae	0x10000e007
000000010000dfe5	movzbl	(%rsi,%r14), %edx
000000010000dfea	cmpq	$0x20, %rdx
000000010000dfee	ja	0x10000e007
000000010000dff0	btq	%rdx, %r13
000000010000dff4	jae	0x10000e007
000000010000dff6	incq	%r14
000000010000dff9	movq	%r14, 0x10(%rcx)
000000010000dffd	cmpq	%r14, %rdi
000000010000e000	jne	0x10000dfe5
000000010000e002	jmp	0x10000e0cc
000000010000e007	cmpq	%r14, %rdi
000000010000e00a	je	0x10000e0cc
000000010000e010	cmpb	$0x3d, (%rsi,%r14)
000000010000e015	jne	0x10000e0cc
000000010000e01b	incq	%r14
000000010000e01e	movq	%r14, 0x10(%rcx)
000000010000e022	movq	0x20(%rax), %rax
000000010000e026	movl	%r15d, %ebx
000000010000e029	movq	(%rax,%rbx,8), %rsi
000000010000e02d	movq	-0x1e0(%rbp), %rax
000000010000e034	leaq	(%rax,%rbx,8), %rcx
000000010000e038	movq	-0x1c8(%rbp), %rdi
000000010000e03f	xorl	%edx, %edx
000000010000e041	callq	_tp_value
000000010000e046	movq	-0x1c8(%rbp), %rcx
000000010000e04d	testl	%eax, %eax
000000010000e04f	je	0x10000e0cc
000000010000e051	movq	-0x1f8(%rbp), %rax
000000010000e058	movb	$0x1, (%rax,%rbx)
000000010000e05c	movq	0x8(%rcx), %rdx
000000010000e060	movq	0x10(%rcx), %rax
000000010000e064	cmpq	%rdx, %rax
000000010000e067	jae	0x10000e08a
000000010000e069	movq	(%rcx), %rsi
000000010000e06c	movzbl	(%rsi,%rax), %edi
000000010000e070	cmpq	$0x20, %rdi
000000010000e074	ja	0x10000e08a
000000010000e076	btq	%rdi, %r13
000000010000e07a	jae	0x10000e08a
000000010000e07c	incq	%rax
000000010000e07f	movq	%rax, 0x10(%rcx)
000000010000e083	cmpq	%rax, %rdx
000000010000e086	jne	0x10000e06c
000000010000e088	jmp	0x10000e09c
000000010000e08a	cmpq	%rax, %rdx
000000010000e08d	je	0x10000e09c
000000010000e08f	movq	(%rcx), %rdx
000000010000e092	cmpb	$0x7d, (%rdx,%rax)
000000010000e096	je	0x10000e189
000000010000e09c	movq	-0x1c8(%rbp), %rdi
000000010000e0a3	leaq	0x5fc9(%rip), %rsi              ## literal pool for: ","
000000010000e0aa	callq	_tp_eat
000000010000e0af	movq	-0x1c8(%rbp), %rcx
000000010000e0b6	testl	%eax, %eax
000000010000e0b8	je	0x10000e0cc
000000010000e0ba	movl	$0xff, %r8d
000000010000e0c0	leaq	-0x130(%rbp), %r9
000000010000e0c7	jmp	0x10000de95
000000010000e0cc	xorl	%r14d, %r14d
000000010000e0cf	jmp	0x10000c978
000000010000e0d4	movq	%rdi, %rdx
000000010000e0d7	cmpq	%rsi, %rdi
000000010000e0da	jne	0x10000e0e5
000000010000e0dc	testb	%r8b, %r8b
000000010000e0df	jne	0x10000c978
000000010000e0e5	cmpq	%rax, %rdx
000000010000e0e8	jae	0x10000e14e
000000010000e0ea	movzbl	-0x130(%rbp,%rdx), %esi
000000010000e0f2	orl	$0x20, %esi
000000010000e0f5	cmpl	$0x65, %esi
000000010000e0f8	jne	0x10000e14e
000000010000e0fa	leaq	0x1(%rdx), %rsi
000000010000e0fe	cmpq	%rax, %rsi
000000010000e101	jae	0x10000e11c
000000010000e103	movzbl	-0x130(%rbp,%rsi), %edi
000000010000e10b	cmpl	$0x2d, %edi
000000010000e10e	je	0x10000e115
000000010000e110	cmpl	$0x2b, %edi
000000010000e113	jne	0x10000e11c
000000010000e115	addq	$0x2, %rdx
000000010000e119	movq	%rdx, %rsi
000000010000e11c	cmpq	%rax, %rsi
000000010000e11f	jae	0x10000c978
000000010000e125	movq	%rsi, %rdx
000000010000e128	movzbl	-0x130(%rbp,%rdx), %edi
000000010000e130	addb	$-0x30, %dil
000000010000e134	cmpb	$0x9, %dil
000000010000e138	ja	0x10000e145
000000010000e13a	incq	%rdx
000000010000e13d	cmpq	%rdx, %rax
000000010000e140	jne	0x10000e128
000000010000e142	movq	%rax, %rdx
000000010000e145	cmpq	%rsi, %rdx
000000010000e148	je	0x10000c978
000000010000e14e	cmpq	%rax, %rdx
000000010000e151	jne	0x10000c978
000000010000e157	cmpl	$0xa, (%rcx)
000000010000e15a	jne	0x10000e176
000000010000e15c	leaq	-0x130(%rbp), %rdi
000000010000e163	xorl	%esi, %esi
000000010000e165	callq	0x100012d3e                     ## symbol stub for: _strtof
000000010000e16a	movd	%xmm0, %eax
000000010000e16e	movq	%rax, (%r15)
000000010000e171	jmp	0x10000c972
000000010000e176	leaq	-0x130(%rbp), %rdi
000000010000e17d	xorl	%esi, %esi
000000010000e17f	callq	0x100012d38                     ## symbol stub for: _strtod
000000010000e184	jmp	0x10000ce1d
000000010000e189	incq	%rax
000000010000e18c	movq	%rax, 0x10(%rcx)
000000010000e190	movq	-0x1f8(%rbp), %r12
000000010000e197	jmp	0x10000da68
000000010000e19c	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000e1a1	nopl	(%rax)
000000010000e1a4	popq	%rax
000000010000e1a5	callq	0xe859e1a9
000000010000e1aa	.byte 0xff #bad opcode
000000010000e1ab	lcalll	*-0x18(%rax)
000000010000e1ae	.byte 0xff #bad opcode
000000010000e1af	lcalll	*-0x18(%rax)
000000010000e1b2	.byte 0xff #bad opcode
000000010000e1b3	lcalll	*-0x18(%rax)
000000010000e1b6	.byte 0xff #bad opcode
000000010000e1b7	lcalll	*-0x18(%rax)
000000010000e1ba	.byte 0xff #bad opcode
000000010000e1bb	lcalll	*-0x18(%rax)
000000010000e1be	.byte 0xff #bad opcode
000000010000e1bf	lcalll	*-0x18(%rax)
000000010000e1c2	.byte 0xff #bad opcode
000000010000e1c3	lcalll	*-0x18(%rax)
000000010000e1c6	.byte 0xff #bad opcode
000000010000e1c7	lcalll	*-0x18(%rax)
000000010000e1ca	.byte 0xff #bad opcode
000000010000e1cb	.byte 0xff #bad opcode
000000010000e1cc	cmpl	%esp, %ebp
000000010000e1ce	.byte 0xff #bad opcode
000000010000e1cf	.byte 0xff #bad opcode
000000010000e1d0	cmpl	%esp, %ebp
000000010000e1d2	.byte 0xff #bad opcode
000000010000e1d3	incl	-0x49000014(%rcx)
000000010000e1d9	inb	%dx, %al
000000010000e1da	.byte 0xff #bad opcode
000000010000e1db	.byte 0xff #bad opcode
000000010000e1dc	jl	0x10000e1cd
000000010000e1de	.byte 0xff #bad opcode
000000010000e1df	decl	(%rcx)
000000010000e1e1	jmp	0x10000e1e2
000000010000e1e3	lcalll	*(%rdx)
000000010000e1e5	outb	%al, %dx
000000010000e1e6	.byte 0xff #bad opcode
000000010000e1e7	decl	(%rcx)
000000010000e1e9	jmp	0x10000e1ea
000000010000e1eb	.byte 0xff #bad opcode
000000010000e1ec	fsubr	%st, %st(1)
000000010000e1ee	.byte 0xff #bad opcode
000000010000e1ef	.byte 0xff #bad opcode
000000010000e1f0	fsubr	%st, %st(1)
000000010000e1f2	.byte 0xff #bad opcode
000000010000e1f3	incl	-0x13(%rcx)
000000010000e1f6	.byte 0xff #bad opcode
000000010000e1f7	ljmpl	*0xfffffed(%rcx)
000000010000e1fd	.byte 0x1f #bad opcode
000000010000e1fe	addb	%dl, 0x48(%rbp)
000000010000e202	movl	%esp, %ebp
000000010000e204	pushq	%r15
000000010000e206	pushq	%r14
000000010000e208	pushq	%r13
000000010000e20a	pushq	%r12
000000010000e20c	pushq	%rbx
000000010000e20d	subq	$0xb8, %rsp
000000010000e214	movq	%rdx, %rbx
000000010000e217	movq	%rsi, %r15
000000010000e21a	movq	0x6e0f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000e221	movq	(%rax), %rax
000000010000e224	movq	%rax, -0x30(%rbp)
000000010000e228	leaq	-0xb0(%rbp), %rsi
000000010000e22f	movl	$0x80, %edx
000000010000e234	callq	_tp_token
000000010000e239	xorl	%r14d, %r14d
000000010000e23c	cmpq	$0x7f, %rax
000000010000e240	ja	0x10000e27c
000000010000e242	leaq	-0xb0(%rbp), %r12
000000010000e249	movq	%r12, %rdi
000000010000e24c	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000e251	movq	%r12, %rdi
000000010000e254	movq	%rax, %rsi
000000010000e257	callq	_fwp_str_new
000000010000e25c	movq	(%rax), %r11
000000010000e25f	testq	%r11, %r11
000000010000e262	je	0x10000e27c
000000010000e264	movq	%rax, %rcx
000000010000e267	movzbl	0x8(%rax), %r8d
000000010000e26c	leal	-0x2b(%r8), %eax
000000010000e270	xorl	%edx, %edx
000000010000e272	testb	$-0x3, %al
000000010000e274	sete	%dl
000000010000e277	cmpq	%rdx, %r11
000000010000e27a	jne	0x10000e2a5
000000010000e27c	movq	0x6dad(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000e283	movq	(%rax), %rax
000000010000e286	cmpq	-0x30(%rbp), %rax
000000010000e28a	jne	0x10000e629
000000010000e290	movl	%r14d, %eax
000000010000e293	addq	$0xb8, %rsp
000000010000e29a	popq	%rbx
000000010000e29b	popq	%r12
000000010000e29d	popq	%r13
000000010000e29f	popq	%r14
000000010000e2a1	popq	%r15
000000010000e2a3	popq	%rbp
000000010000e2a4	retq
000000010000e2a5	movl	(%r15), %r9d
000000010000e2a8	movl	0x48(%r15), %edi
000000010000e2ac	jbe	0x10000e2c7
000000010000e2ae	nop
000000010000e2b0	movzbl	0x8(%rcx,%rdx), %esi
000000010000e2b5	addb	$-0x3a, %sil
000000010000e2b9	cmpb	$-0xa, %sil
000000010000e2bd	jb	0x10000e27c
000000010000e2bf	incq	%rdx
000000010000e2c2	cmpq	%rdx, %r11
000000010000e2c5	jne	0x10000e2b0
000000010000e2c7	movl	%r9d, -0xb4(%rbp)
000000010000e2ce	movq	%r8, -0xc0(%rbp)
000000010000e2d5	movq	%rdi, -0xd0(%rbp)
000000010000e2dc	movq	%rbx, -0xc8(%rbp)
000000010000e2e3	xorl	%r15d, %r15d
000000010000e2e6	testb	$-0x3, %al
000000010000e2e8	sete	%r15b
000000010000e2ec	xorl	%edi, %edi
000000010000e2ee	movl	$0x0, %esi
000000010000e2f3	cmpq	%r15, %r11
000000010000e2f6	jbe	0x10000e3b1
000000010000e2fc	xorl	%r14d, %r14d
000000010000e2ff	movabsq	$-0x3333333333333333, %rbx      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000e309	xorl	%edi, %edi
000000010000e30b	xorl	%esi, %esi
000000010000e30d	nopl	(%rax)
000000010000e310	movq	%rsi, %r13
000000010000e313	movq	%rdi, %r12
000000010000e316	movq	%rdi, %rax
000000010000e319	movl	$0xa, %edx
000000010000e31e	mulq	%rdx
000000010000e321	leaq	(%rsi,%rsi,4), %rsi
000000010000e325	leaq	(%rdx,%rsi,2), %rdx
000000010000e329	movsbl	0x8(%rcx,%r15), %esi
000000010000e32f	addl	$-0x30, %esi
000000010000e332	movslq	%esi, %r8
000000010000e335	movq	%r8, %rsi
000000010000e338	sarq	$0x3f, %rsi
000000010000e33c	movq	%rax, %rdi
000000010000e33f	addq	%r8, %rdi
000000010000e342	adcq	%rdx, %rsi
000000010000e345	movq	%rsi, %r9
000000010000e348	shldq	$0x3f, %rdi, %r9
000000010000e34d	movq	%rsi, %r8
000000010000e350	shrq	%r8
000000010000e353	movq	%r9, %r10
000000010000e356	addq	%r8, %r10
000000010000e359	adcq	$0x0, %r10
000000010000e35d	movq	%r10, %rax
000000010000e360	mulq	%rbx
000000010000e363	shrq	$0x2, %rdx
000000010000e367	leaq	(%rdx,%rdx,4), %rax
000000010000e36b	subq	%rax, %r10
000000010000e36e	subq	%r10, %r9
000000010000e371	sbbq	$0x0, %r8
000000010000e375	movq	%r9, %r10
000000010000e378	movabsq	$-0x3333333333333334, %rax      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000e382	imulq	%rax, %r10
000000010000e386	movq	%r9, %rax
000000010000e389	mulq	%rbx
000000010000e38c	addq	%r10, %rdx
000000010000e38f	imulq	%rbx, %r8
000000010000e393	addq	%rdx, %r8
000000010000e396	xorq	%r13, %r8
000000010000e399	xorq	%r12, %rax
000000010000e39c	orq	%r8, %rax
000000010000e39f	jne	0x10000e27c
000000010000e3a5	incq	%r15
000000010000e3a8	cmpq	%r15, %r11
000000010000e3ab	jne	0x10000e310
000000010000e3b1	movl	-0xb4(%rbp), %r11d
000000010000e3b8	cmpl	$0x9, %r11d
000000010000e3bc	jne	0x10000e420
000000010000e3be	cmpb	$0x2d, -0xc0(%rbp)
000000010000e3c5	movq	-0xc8(%rbp), %rbx
000000010000e3cc	jne	0x10000e3dd
000000010000e3ce	xorl	%r14d, %r14d
000000010000e3d1	movq	%rdi, %rax
000000010000e3d4	orq	%rsi, %rax
000000010000e3d7	jne	0x10000e27c
000000010000e3dd	callq	_fwp_box_i128
000000010000e3e2	movq	%rax, %r15
000000010000e3e5	movq	%r15, -0xd8(%rbp)
000000010000e3ec	movl	$0x10, %edi
000000010000e3f1	callq	_fwp_alloc_init
000000010000e3f6	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
000000010000e400	movq	%rcx, (%rax)
000000010000e403	movq	%r15, 0x8(%rax)
000000010000e407	leaq	-0xd8(%rbp), %rcx
000000010000e40e	movq	0x8(%rax), %rax
000000010000e412	movq	%rax, (%rbx)
000000010000e415	movl	$0x1, %r14d
000000010000e41b	jmp	0x10000e27c
000000010000e420	movq	-0xc0(%rbp), %r10
000000010000e427	cmpb	$0x2d, %r10b
000000010000e42b	sete	%cl
000000010000e42e	movabsq	$-0x8000000000000000, %rax      ## imm = 0x8000000000000000
000000010000e438	movq	%rsi, %rdx
000000010000e43b	xorq	%rax, %rdx
000000010000e43e	orq	%rdi, %rdx
000000010000e441	setne	%dl
000000010000e444	xorl	%r14d, %r14d
000000010000e447	movq	%rdi, %r8
000000010000e44a	negq	%r8
000000010000e44d	movq	%rax, %r8
000000010000e450	sbbq	%rsi, %r8
000000010000e453	movq	-0xc8(%rbp), %rbx
000000010000e45a	jb	0x10000e27c
000000010000e460	orb	%dl, %cl
000000010000e462	je	0x10000e27c
000000010000e468	xorl	%r14d, %r14d
000000010000e46b	movq	%rdi, %r15
000000010000e46e	negq	%r15
000000010000e471	movl	$0x0, %r9d
000000010000e477	sbbq	%rsi, %r9
000000010000e47a	cmpb	$0x2d, %r10b
000000010000e47e	cmovneq	%rdi, %r15
000000010000e482	cmovneq	%rsi, %r9
000000010000e486	cmpl	$0x14, %r11d
000000010000e48a	ja	0x10000e27c
000000010000e490	movl	%r11d, %ecx
000000010000e493	leaq	0x196(%rip), %rdx
000000010000e49a	movslq	(%rdx,%rcx,4), %rcx
000000010000e49e	addq	%rdx, %rcx
000000010000e4a1	jmpq	*%rcx
000000010000e4a3	movq	%r15, %rax
000000010000e4a6	addq	$-0x80, %rax
000000010000e4aa	adcq	$-0x1, %r9
000000010000e4ae	cmpq	$-0x100, %rax
000000010000e4b4	jmp	0x10000e4ef
000000010000e4b6	movq	%r15, %rax
000000010000e4b9	addq	$-0x80000000, %rax              ## imm = 0x80000000
000000010000e4bf	adcq	$-0x1, %r9
000000010000e4c3	movabsq	$-0x100000000, %rcx             ## imm = 0xFFFFFFFF00000000
000000010000e4cd	cmpq	%rcx, %rax
000000010000e4d0	jmp	0x10000e4ef
000000010000e4d2	xorl	%r14d, %r14d
000000010000e4d5	movl	$0xff, %eax
000000010000e4da	jmp	0x10000e506
000000010000e4dc	movq	%r15, %rax
000000010000e4df	addq	$-0x8000, %rax                  ## imm = 0x8000
000000010000e4e5	adcq	$-0x1, %r9
000000010000e4e9	cmpq	$-0x10000, %rax                 ## imm = 0xFFFF0000
000000010000e4ef	sbbq	$-0x1, %r9
000000010000e4f3	jb	0x10000e27c
000000010000e4f9	jmp	0x10000e3e5
000000010000e4fe	xorl	%r14d, %r14d
000000010000e501	movl	$0xffff, %eax                   ## imm = 0xFFFF
000000010000e506	cmpq	%r15, %rax
000000010000e509	movl	$0x0, %eax
000000010000e50e	sbbq	%r9, %rax
000000010000e511	jb	0x10000e27c
000000010000e517	jmp	0x10000e3e5
000000010000e51c	movq	%r15, %rax
000000010000e51f	shrq	$0x20, %rax
000000010000e523	orq	%r9, %rax
000000010000e526	jne	0x10000e27c
000000010000e52c	jmp	0x10000e3e5
000000010000e531	movq	%r15, %rcx
000000010000e534	addq	%rax, %rcx
000000010000e537	adcq	$-0x1, %r9
000000010000e53b	cmpq	$-0x1, %r9
000000010000e53f	jne	0x10000e27c
000000010000e545	jmp	0x10000e3e5
000000010000e54a	movq	%r15, %rdi
000000010000e54d	movq	%r9, %rsi
000000010000e550	callq	_fwp_box_i128
000000010000e555	jmp	0x10000e3e2
000000010000e55a	xorl	%r14d, %r14d
000000010000e55d	movq	-0xd0(%rbp), %rcx
000000010000e564	testl	%ecx, %ecx
000000010000e566	jle	0x10000e59d
000000010000e568	leal	-0x1(%rcx), %eax
000000010000e56b	cmpl	$0x4f, %eax
000000010000e56e	movl	$0x4f, %r8d
000000010000e574	cmovbl	%eax, %r8d
000000010000e578	incl	%r8d
000000010000e57b	movl	%r8d, %edi
000000010000e57e	andl	$0x7, %edi
000000010000e581	cmpl	$0x8, %ecx
000000010000e584	jae	0x10000e5a3
000000010000e586	movl	$0x1, %eax
000000010000e58b	xorl	%ecx, %ecx
000000010000e58d	jmp	0x10000e5c9
000000010000e58f	testq	%r9, %r9
000000010000e592	jne	0x10000e27c
000000010000e598	jmp	0x10000e3e5
000000010000e59d	xorl	%edx, %edx
000000010000e59f	xorl	%ecx, %ecx
000000010000e5a1	jmp	0x10000e5fe
000000010000e5a3	andl	$0xf8, %r8d
000000010000e5aa	movl	$0x1, %eax
000000010000e5af	xorl	%ecx, %ecx
000000010000e5b1	movl	$0x19a1, %esi                   ## imm = 0x19A1
000000010000e5b6	mulq	%rsi
000000010000e5b9	imulq	$0x19a1, %rcx, %rcx             ## imm = 0x19A1
000000010000e5c0	addq	%rdx, %rcx
000000010000e5c3	addl	$-0x8, %r8d
000000010000e5c7	jne	0x10000e5b6
000000010000e5c9	testl	%edi, %edi
000000010000e5cb	je	0x10000e5e0
000000010000e5cd	movl	$0x3, %esi
000000010000e5d2	mulq	%rsi
000000010000e5d5	leaq	(%rcx,%rcx,2), %rcx
000000010000e5d9	addq	%rdx, %rcx
000000010000e5dc	decl	%edi
000000010000e5de	jne	0x10000e5d2
000000010000e5e0	addq	$-0x1, %rax
000000010000e5e4	adcq	$-0x1, %rcx
000000010000e5e8	movq	%rcx, %rdx
000000010000e5eb	shrq	$0x3f, %rdx
000000010000e5ef	addq	%rax, %rdx
000000010000e5f2	adcq	$0x0, %rcx
000000010000e5f6	shrdq	$0x1, %rcx, %rdx
000000010000e5fb	sarq	%rcx
000000010000e5fe	movq	%rdx, %rax
000000010000e601	negq	%rax
000000010000e604	movl	$0x0, %esi
000000010000e609	sbbq	%rcx, %rsi
000000010000e60c	cmpq	%r15, %rdx
000000010000e60f	sbbq	%r9, %rcx
000000010000e612	jl	0x10000e27c
000000010000e618	cmpq	%rax, %r15
000000010000e61b	sbbq	%rsi, %r9
000000010000e61e	jge	0x10000e3e5
000000010000e624	jmp	0x10000e27c
000000010000e629	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
000000010000e62e	nop
000000010000e630	jae	0x10000e630
000000010000e632	.byte 0xff #bad opcode
000000010000e633	ljmpl	*-0x1790001(%rsi,%rdi,8)
000000010000e63a	.byte 0xff #bad opcode
000000010000e63b	incl	(%rcx)
000000010000e63d	.byte 0xff #bad opcode
000000010000e63e	.byte 0xff #bad opcode
000000010000e63f	lcalll	*(%rdx)
000000010000e641	.byte 0xff #bad opcode
000000010000e642	.byte 0xff #bad opcode
000000010000e643	jmpq	*-0x31000002(%rdx)
000000010000e649	.byte 0xfe #bad opcode
000000010000e64a	.byte 0xff #bad opcode
000000010000e64b	.byte 0xff #bad opcode
000000010000e64c	inb	%dx, %al
000000010000e64d	.byte 0xfe #bad opcode
000000010000e64e	.byte 0xff #bad opcode
000000010000e64f	lcalll	*-0x1(%rdi)
000000010000e652	.byte 0xff #bad opcode
000000010000e653	decl	-0x1(%rsp,%rdi,8)
000000010000e657	decl	-0x1(%rsp,%rdi,8)
000000010000e65b	decl	-0x1(%rsp,%rdi,8)
000000010000e65f	decl	-0x1(%rsp,%rdi,8)
000000010000e663	decl	-0x1(%rsp,%rdi,8)
000000010000e667	decl	-0x1(%rsp,%rdi,8)
000000010000e66b	decl	-0x1(%rsp,%rdi,8)
000000010000e66f	decl	-0x1(%rsp,%rdi,8)
000000010000e673	decl	-0x1(%rsp,%rdi,8)
000000010000e677	decl	-0x1(%rsp,%rdi,8)
000000010000e67b	decl	-0x1(%rsp,%rdi,8)
000000010000e67f	ljmpl	*(%rdx)
000000010000e681	.byte 0xff #bad opcode
000000010000e682	.byte 0xff #bad opcode
000000010000e683	jmpq	*0x66(%rsi)
000000010000e686	nopw	%cs:(%rax,%rax)
_tp_quoted:
000000010000e690	pushq	%rbp
000000010000e691	movq	%rsp, %rbp
000000010000e694	pushq	%r15
000000010000e696	pushq	%r14
000000010000e698	pushq	%r13
000000010000e69a	pushq	%r12
000000010000e69c	pushq	%rbx
000000010000e69d	subq	$0x28, %rsp
000000010000e6a1	movq	%rsi, %rbx
000000010000e6a4	movq	%rdi, %r15
000000010000e6a7	movq	0x8(%rdi), %rcx
000000010000e6ab	movq	0x10(%rdi), %rax
000000010000e6af	cmpq	%rcx, %rax
000000010000e6b2	jae	0x10000e6f4
000000010000e6b4	movq	(%r15), %rdx
000000010000e6b7	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000e6c1	nopw	%cs:(%rax,%rax)
000000010000e6d0	movzbl	(%rdx,%rax), %edi
000000010000e6d4	cmpq	$0x20, %rdi
000000010000e6d8	ja	0x10000e6f4
000000010000e6da	btq	%rdi, %rsi
000000010000e6de	jae	0x10000e6f4
000000010000e6e0	incq	%rax
000000010000e6e3	movq	%rax, 0x10(%r15)
000000010000e6e7	cmpq	%rax, %rcx
000000010000e6ea	jne	0x10000e6d0
000000010000e6ec	xorl	%r14d, %r14d
000000010000e6ef	jmp	0x10000e8d6
000000010000e6f4	xorl	%r14d, %r14d
000000010000e6f7	cmpq	%rcx, %rax
000000010000e6fa	jae	0x10000e8d6
000000010000e700	movq	(%r15), %rdx
000000010000e703	cmpb	$0x22, (%rdx,%rax)
000000010000e707	jne	0x10000e8d6
000000010000e70d	incq	%rax
000000010000e710	movq	%rax, 0x10(%r15)
000000010000e714	xorps	%xmm0, %xmm0
000000010000e717	movaps	%xmm0, -0x50(%rbp)
000000010000e71b	movq	$0x0, -0x40(%rbp)
000000010000e723	xorl	%r14d, %r14d
000000010000e726	cmpq	%rcx, %rax
000000010000e729	jae	0x10000e8c4
000000010000e72f	leaq	-0x50(%rbp), %r12
000000010000e733	movq	0x68c6(%rip), %r13              ## literal pool symbol address: __DefaultRuneLocale
000000010000e73a	nopw	(%rax,%rax)
000000010000e740	movq	(%r15), %rdx
000000010000e743	leaq	0x1(%rax), %rdi
000000010000e747	movq	%rdi, 0x10(%r15)
000000010000e74b	movzbl	(%rdx,%rax), %esi
000000010000e74f	cmpl	$0x5c, %esi
000000010000e752	je	0x10000e790
000000010000e754	cmpl	$0x22, %esi
000000010000e757	je	0x10000e8e8
000000010000e75d	movb	%sil, -0x29(%rbp)
000000010000e761	movl	$0x1, %edx
000000010000e766	movq	%r12, %rdi
000000010000e769	leaq	-0x29(%rbp), %rsi
000000010000e76d	callq	_buf_put
000000010000e772	movq	0x8(%r15), %rcx
000000010000e776	movq	0x10(%r15), %rax
000000010000e77a	cmpq	%rcx, %rax
000000010000e77d	jb	0x10000e740
000000010000e77f	jmp	0x10000e8cd
000000010000e784	nopw	%cs:(%rax,%rax)
000000010000e790	cmpq	%rcx, %rdi
000000010000e793	jae	0x10000e8cd
000000010000e799	leaq	0x2(%rax), %rsi
000000010000e79d	movq	%rsi, 0x10(%r15)
000000010000e7a1	movzbl	0x1(%rdx,%rax), %edi
000000010000e7a6	leal	-0x5c(%rdi), %r8d
000000010000e7aa	cmpl	$0x19, %r8d
000000010000e7ae	ja	0x10000e7c6
000000010000e7b0	leaq	0x2b9(%rip), %r9
000000010000e7b7	movslq	(%r9,%r8,4), %rdi
000000010000e7bb	addq	%r9, %rdi
000000010000e7be	jmpq	*%rdi
000000010000e7c0	movb	$0x5c, -0x29(%rbp)
000000010000e7c4	jmp	0x10000e761
000000010000e7c6	cmpl	$0x22, %edi
000000010000e7c9	je	0x10000e881
000000010000e7cf	cmpl	$0x30, %edi
000000010000e7d2	jne	0x10000e8cd
000000010000e7d8	movb	$0x0, -0x29(%rbp)
000000010000e7dc	jmp	0x10000e761
000000010000e7de	movb	$0x9, -0x29(%rbp)
000000010000e7e2	jmp	0x10000e761
000000010000e7e7	movb	$0xd, -0x29(%rbp)
000000010000e7eb	jmp	0x10000e761
000000010000e7f0	movb	$0xa, -0x29(%rbp)
000000010000e7f4	jmp	0x10000e761
000000010000e7f9	cmpq	%rcx, %rsi
000000010000e7fc	jae	0x10000e8cd
000000010000e802	cmpb	$0x7b, (%rdx,%rsi)
000000010000e806	jne	0x10000e8cd
000000010000e80c	leaq	0x3(%rax), %rsi
000000010000e810	movq	%rsi, 0x10(%r15)
000000010000e814	cmpq	%rcx, %rsi
000000010000e817	jae	0x10000e8cd
000000010000e81d	leaq	0x4(%rax), %rdi
000000010000e821	leaq	(%rdx,%rax), %r8
000000010000e825	addq	$0x3, %r8
000000010000e829	subq	%rax, %rcx
000000010000e82c	addq	$-0x3, %rcx
000000010000e830	xorl	%edx, %edx
000000010000e832	xorl	%esi, %esi
000000010000e834	nopw	%cs:(%rax,%rax)
000000010000e840	movzbl	(%r8,%rdx), %r9d
000000010000e845	testb	$0x1, 0x3e(%r13,%r9,4)
000000010000e84b	je	0x10000e88a
000000010000e84d	leaq	(%rdi,%rdx), %r9
000000010000e851	movq	%r9, 0x10(%r15)
000000010000e855	movsbl	(%r8,%rdx), %r9d
000000010000e85a	shll	$0x4, %esi
000000010000e85d	leal	-0x30(%r9), %r10d
000000010000e861	movl	%r9d, %r11d
000000010000e864	orl	$0x20, %r11d
000000010000e868	addl	$-0x57, %r11d
000000010000e86c	cmpl	$0x3a, %r9d
000000010000e870	cmovll	%r10d, %r11d
000000010000e874	addl	%r11d, %esi
000000010000e877	incq	%rdx
000000010000e87a	cmpq	%rdx, %rcx
000000010000e87d	jne	0x10000e840
000000010000e87f	jmp	0x10000e8cd
000000010000e881	movb	$0x22, -0x29(%rbp)
000000010000e885	jmp	0x10000e761
000000010000e88a	testl	%edx, %edx
000000010000e88c	je	0x10000e8cd
000000010000e88e	cmpb	$0x7d, %r9b
000000010000e892	jne	0x10000e8cd
000000010000e894	cmpl	$0x10ffff, %esi                 ## imm = 0x10FFFF
000000010000e89a	ja	0x10000e8cd
000000010000e89c	movl	%esi, %ecx
000000010000e89e	andl	$0x1ff800, %ecx                 ## imm = 0x1FF800
000000010000e8a4	cmpl	$0xd800, %ecx                   ## imm = 0xD800
000000010000e8aa	je	0x10000e8cd
000000010000e8ac	addq	%rdx, %rax
000000010000e8af	addq	$0x4, %rax
000000010000e8b3	movq	%rax, 0x10(%r15)
000000010000e8b7	movq	%r12, %rdi
000000010000e8ba	callq	_fwp_utf8_put
000000010000e8bf	jmp	0x10000e772
000000010000e8c4	xorl	%edi, %edi
000000010000e8c6	callq	0x100012c72                     ## symbol stub for: _free
000000010000e8cb	jmp	0x10000e8d6
000000010000e8cd	movq	-0x50(%rbp), %rdi
000000010000e8d1	callq	0x100012c72                     ## symbol stub for: _free
000000010000e8d6	movl	%r14d, %eax
000000010000e8d9	addq	$0x28, %rsp
000000010000e8dd	popq	%rbx
000000010000e8de	popq	%r12
000000010000e8e0	popq	%r13
000000010000e8e2	popq	%r14
000000010000e8e4	popq	%r15
000000010000e8e6	popq	%rbp
000000010000e8e7	retq
000000010000e8e8	movq	-0x50(%rbp), %r14
000000010000e8ec	movq	-0x48(%rbp), %rsi
000000010000e8f0	testq	%r14, %r14
000000010000e8f3	leaq	0x4a38(%rip), %rdi              ## literal pool for: ""
000000010000e8fa	cmovneq	%r14, %rdi
000000010000e8fe	testq	%rsi, %rsi
000000010000e901	je	0x10000ea43
000000010000e907	xorl	%eax, %eax
000000010000e909	jmp	0x10000e917
000000010000e90b	incq	%rax
000000010000e90e	cmpq	%rsi, %rax
000000010000e911	jae	0x10000ea43
000000010000e917	movzbl	(%rdi,%rax), %r9d
000000010000e91c	testb	%r9b, %r9b
000000010000e91f	jns	0x10000e90b
000000010000e921	leal	0x3e(%r9), %ecx
000000010000e925	cmpb	$0x1e, %cl
000000010000e928	jae	0x10000e93c
000000010000e92a	movl	$0x80, %ecx
000000010000e92f	movl	$0x1, %r8d
000000010000e935	movl	$0x1f, %edx
000000010000e93a	jmp	0x10000e976
000000010000e93c	movl	%r9d, %ecx
000000010000e93f	andb	$-0x10, %cl
000000010000e942	cmpb	$-0x20, %cl
000000010000e945	jne	0x10000e959
000000010000e947	movl	$0x800, %ecx                    ## imm = 0x800
000000010000e94c	movl	$0x2, %r8d
000000010000e952	movl	$0xf, %edx
000000010000e957	jmp	0x10000e976
000000010000e959	leal	0x10(%r9), %ecx
000000010000e95d	cmpb	$0x4, %cl
000000010000e960	ja	0x10000ea61
000000010000e966	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000e96b	movl	$0x3, %r8d
000000010000e971	movl	$0x7, %edx
000000010000e976	movl	%r8d, %r8d
000000010000e979	leaq	(%rax,%r8), %r10
000000010000e97d	cmpq	%rsi, %r10
000000010000e980	jae	0x10000ea61
000000010000e986	movzbl	0x1(%rdi,%rax), %r10d
000000010000e98c	movl	%r10d, %r11d
000000010000e98f	andl	$-0x40, %r11d
000000010000e993	cmpl	$0x80, %r11d
000000010000e99a	jne	0x10000ea61
000000010000e9a0	andl	%r9d, %edx
000000010000e9a3	leal	0x1(%r8), %r11d
000000010000e9a7	movl	%edx, %r9d
000000010000e9aa	shll	$0x6, %r9d
000000010000e9ae	andl	$0x3f, %r10d
000000010000e9b2	orl	%r9d, %r10d
000000010000e9b5	cmpl	$0x2, %r11d
000000010000e9b9	jne	0x10000e9c0
000000010000e9bb	movl	%r10d, %r11d
000000010000e9be	jmp	0x10000ea18
000000010000e9c0	movzbl	0x2(%rdi,%rax), %edx
000000010000e9c5	movl	%edx, %r9d
000000010000e9c8	andl	$-0x40, %r9d
000000010000e9cc	cmpl	$0x80, %r9d
000000010000e9d3	jne	0x10000ea61
000000010000e9d9	movl	%r10d, %r9d
000000010000e9dc	shll	$0x6, %r9d
000000010000e9e0	andl	$0x3f, %edx
000000010000e9e3	orl	%r9d, %edx
000000010000e9e6	cmpl	$0x3, %r11d
000000010000e9ea	jne	0x10000e9f4
000000010000e9ec	movl	%edx, %r11d
000000010000e9ef	movl	%r10d, %edx
000000010000e9f2	jmp	0x10000ea18
000000010000e9f4	movzbl	0x3(%rdi,%rax), %r11d
000000010000e9fa	movl	%r11d, %r9d
000000010000e9fd	andl	$-0x40, %r9d
000000010000ea01	cmpl	$0x80, %r9d
000000010000ea08	jne	0x10000ea61
000000010000ea0a	movl	%edx, %r9d
000000010000ea0d	shll	$0x6, %r9d
000000010000ea11	andl	$0x3f, %r11d
000000010000ea15	orl	%r9d, %r11d
000000010000ea18	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000ea1e	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000ea24	je	0x10000ea61
000000010000ea26	cmpl	$0x10ffff, %r9d                 ## imm = 0x10FFFF
000000010000ea2d	ja	0x10000ea61
000000010000ea2f	cmpl	%ecx, %r11d
000000010000ea32	jb	0x10000ea61
000000010000ea34	addq	%r8, %rax
000000010000ea37	incq	%rax
000000010000ea3a	cmpq	%rsi, %rax
000000010000ea3d	jb	0x10000e917
000000010000ea43	callq	_fwp_str_new
000000010000ea48	movq	%rax, %r15
000000010000ea4b	movq	%r14, %rdi
000000010000ea4e	callq	0x100012c72                     ## symbol stub for: _free
000000010000ea53	movq	%r15, (%rbx)
000000010000ea56	movl	$0x1, %r14d
000000010000ea5c	jmp	0x10000e8d6
000000010000ea61	movq	%r14, %rdi
000000010000ea64	callq	0x100012c72                     ## symbol stub for: _free
000000010000ea69	jmp	0x10000e6ec
000000010000ea6e	nop
000000010000ea70	pushq	%rax
000000010000ea71	std
000000010000ea72	.byte 0xff #bad opcode
000000010000ea73	lcalll	*-0x2(%rbp)
000000010000ea76	.byte 0xff #bad opcode
000000010000ea77	lcalll	*-0x2(%rbp)
000000010000ea7a	.byte 0xff #bad opcode
000000010000ea7b	lcalll	*-0x2(%rbp)
000000010000ea7e	.byte 0xff #bad opcode
000000010000ea7f	lcalll	*-0x2(%rbp)
000000010000ea82	.byte 0xff #bad opcode
000000010000ea83	lcalll	*-0x2(%rbp)
000000010000ea86	.byte 0xff #bad opcode
000000010000ea87	lcalll	*-0x2(%rbp)
000000010000ea8a	.byte 0xff #bad opcode
000000010000ea8b	lcalll	*-0x2(%rbp)
000000010000ea8e	.byte 0xff #bad opcode
000000010000ea8f	lcalll	*-0x2(%rbp)
000000010000ea92	.byte 0xff #bad opcode
000000010000ea93	lcalll	*-0x2(%rbp)
000000010000ea96	.byte 0xff #bad opcode
000000010000ea97	lcalll	*-0x2(%rbp)
000000010000ea9a	.byte 0xff #bad opcode
000000010000ea9b	lcalll	*-0x2(%rbp)
000000010000ea9e	.byte 0xff #bad opcode
000000010000ea9f	lcalll	*-0x2(%rbp)
000000010000eaa2	.byte 0xff #bad opcode
000000010000eaa3	lcalll	*-0x2(%rbp)
000000010000eaa6	.byte 0xff #bad opcode
000000010000eaa7	lcalll	*-0x2(%rbp)
000000010000eaaa	.byte 0xff #bad opcode
000000010000eaab	lcalll	*-0x2(%rbp)
000000010000eaae	.byte 0xff #bad opcode
000000010000eaaf	lcalll	*-0x2(%rbp)
000000010000eab2	.byte 0xff #bad opcode
000000010000eab3	lcalll	*-0x2(%rbp)
000000010000eab6	.byte 0xff #bad opcode
000000010000eab7	incl	0x5dfffffd(%rax)
000000010000eabd	.byte 0xfe #bad opcode
000000010000eabe	.byte 0xff #bad opcode
000000010000eabf	lcalll	*-0x2(%rbp)
000000010000eac2	.byte 0xff #bad opcode
000000010000eac3	lcalll	*-0x2(%rbp)
000000010000eac6	.byte 0xff #bad opcode
000000010000eac7	pushq	-0x3(%rdi)
000000010000eaca	.byte 0xff #bad opcode
000000010000eacb	lcalll	*-0x2(%rbp)
000000010000eace	.byte 0xff #bad opcode
000000010000eacf	ljmpl	*-0x3(%rsi)
000000010000ead2	.byte 0xff #bad opcode
000000010000ead3	decl	0xffffffd(%rcx)
000000010000ead9	.byte 0x1f #bad opcode
000000010000eada	testb	%al, (%rax)
000000010000eadc	addb	%al, (%rax)
000000010000eade	addb	%al, (%rax)
_tp_eat:
000000010000eae0	pushq	%rbp
000000010000eae1	movq	%rsp, %rbp
000000010000eae4	pushq	%r15
000000010000eae6	pushq	%r14
000000010000eae8	pushq	%r13
000000010000eaea	pushq	%r12
000000010000eaec	pushq	%rbx
000000010000eaed	pushq	%rax
000000010000eaee	movq	%rsi, %r14
000000010000eaf1	movq	%rdi, %rbx
000000010000eaf4	movq	0x8(%rdi), %r13
000000010000eaf8	movq	0x10(%rdi), %r12
000000010000eafc	cmpq	%r13, %r12
000000010000eaff	jae	0x10000eb30
000000010000eb01	movq	(%rbx), %rax
000000010000eb04	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000eb0e	nop
000000010000eb10	movzbl	(%rax,%r12), %edx
000000010000eb15	cmpq	$0x20, %rdx
000000010000eb19	ja	0x10000eb30
000000010000eb1b	btq	%rdx, %rcx
000000010000eb1f	jae	0x10000eb30
000000010000eb21	incq	%r12
000000010000eb24	movq	%r12, 0x10(%rbx)
000000010000eb28	cmpq	%r12, %r13
000000010000eb2b	jne	0x10000eb10
000000010000eb2d	movq	%r13, %r12
000000010000eb30	movq	%r14, %rdi
000000010000eb33	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000eb38	subq	%r12, %r13
000000010000eb3b	xorl	%r15d, %r15d
000000010000eb3e	cmpq	%rax, %r13
000000010000eb41	jb	0x10000eb68
000000010000eb43	movq	(%rbx), %rdi
000000010000eb46	addq	%r12, %rdi
000000010000eb49	movq	%r14, %rsi
000000010000eb4c	movq	%rax, %r14
000000010000eb4f	movq	%rax, %rdx
000000010000eb52	callq	0x100012ca2                     ## symbol stub for: _memcmp
000000010000eb57	testl	%eax, %eax
000000010000eb59	jne	0x10000eb68
000000010000eb5b	addq	%r14, %r12
000000010000eb5e	movq	%r12, 0x10(%rbx)
000000010000eb62	movl	$0x1, %r15d
000000010000eb68	movl	%r15d, %eax
000000010000eb6b	addq	$0x8, %rsp
000000010000eb6f	popq	%rbx
000000010000eb70	popq	%r12
000000010000eb72	popq	%r13
000000010000eb74	popq	%r14
000000010000eb76	popq	%r15
000000010000eb78	popq	%rbp
000000010000eb79	retq
000000010000eb7a	nopw	(%rax,%rax)
_tp_list_of:
000000010000eb80	pushq	%rbp
000000010000eb81	movq	%rsp, %rbp
000000010000eb84	pushq	%r15
000000010000eb86	pushq	%r14
000000010000eb88	pushq	%r13
000000010000eb8a	pushq	%r12
000000010000eb8c	pushq	%rbx
000000010000eb8d	subq	$0x28, %rsp
000000010000eb91	movq	%r8, %r15
000000010000eb94	movq	%rcx, -0x40(%rbp)
000000010000eb98	movq	%rsi, %r8
000000010000eb9b	movq	%rdi, %rbx
000000010000eb9e	movq	0x8(%rdi), %r12
000000010000eba2	movq	0x10(%rdi), %r13
000000010000eba6	cmpq	%r12, %r13
000000010000eba9	movq	%rdx, -0x30(%rbp)
000000010000ebad	jae	0x10000ebe0
000000010000ebaf	movq	(%rbx), %rax
000000010000ebb2	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000ebbc	nopl	(%rax)
000000010000ebc0	movzbl	(%rax,%r13), %esi
000000010000ebc5	cmpq	$0x20, %rsi
000000010000ebc9	ja	0x10000ebe0
000000010000ebcb	btq	%rsi, %rcx
000000010000ebcf	jae	0x10000ebe0
000000010000ebd1	incq	%r13
000000010000ebd4	movq	%r13, 0x10(%rbx)
000000010000ebd8	cmpq	%r13, %r12
000000010000ebdb	jne	0x10000ebc0
000000010000ebdd	movq	%r12, %r13
000000010000ebe0	movq	%r8, %rdi
000000010000ebe3	movq	%r8, -0x48(%rbp)
000000010000ebe7	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000ebec	movq	%rax, %r14
000000010000ebef	movq	%r12, %rcx
000000010000ebf2	subq	%r13, %rcx
000000010000ebf5	xorl	%eax, %eax
000000010000ebf7	cmpq	%r14, %rcx
000000010000ebfa	jb	0x10000ec19
000000010000ebfc	movq	%r15, -0x38(%rbp)
000000010000ec00	movq	(%rbx), %r15
000000010000ec03	leaq	(%r15,%r13), %rdi
000000010000ec07	movq	-0x48(%rbp), %rsi
000000010000ec0b	movq	%r14, %rdx
000000010000ec0e	callq	0x100012ca2                     ## symbol stub for: _memcmp
000000010000ec13	testl	%eax, %eax
000000010000ec15	je	0x10000ec28
000000010000ec17	xorl	%eax, %eax
000000010000ec19	addq	$0x28, %rsp
000000010000ec1d	popq	%rbx
000000010000ec1e	popq	%r12
000000010000ec20	popq	%r13
000000010000ec22	popq	%r14
000000010000ec24	popq	%r15
000000010000ec26	popq	%rbp
000000010000ec27	retq
000000010000ec28	addq	%r13, %r14
000000010000ec2b	movq	%r14, 0x10(%rbx)
000000010000ec2f	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000ec39	cmpq	%r12, %r14
000000010000ec3c	jae	0x10000ec72
000000010000ec3e	movq	-0x30(%rbp), %rdi
000000010000ec42	nopw	%cs:(%rax,%rax)
000000010000ec50	movzbl	(%r15,%r14), %eax
000000010000ec55	cmpq	$0x20, %rax
000000010000ec59	ja	0x10000ec76
000000010000ec5b	btq	%rax, %r13
000000010000ec5f	jae	0x10000ec76
000000010000ec61	incq	%r14
000000010000ec64	movq	%r14, 0x10(%rbx)
000000010000ec68	cmpq	%r14, %r12
000000010000ec6b	jne	0x10000ec50
000000010000ec6d	movq	%r12, %r14
000000010000ec70	jmp	0x10000ec76
000000010000ec72	movq	-0x30(%rbp), %rdi
000000010000ec76	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000ec7b	subq	%r14, %r12
000000010000ec7e	cmpq	%rax, %r12
000000010000ec81	jb	0x10000eca0
000000010000ec83	addq	%r14, %r15
000000010000ec86	movq	%r15, %rdi
000000010000ec89	movq	-0x30(%rbp), %rsi
000000010000ec8d	movq	%rax, %r12
000000010000ec90	movq	%rax, %rdx
000000010000ec93	callq	0x100012ca2                     ## symbol stub for: _memcmp
000000010000ec98	testl	%eax, %eax
000000010000ec9a	je	0x10000ed7a
000000010000eca0	movq	%rbx, %rdi
000000010000eca3	movq	-0x38(%rbp), %rsi
000000010000eca7	callq	*-0x40(%rbp)
000000010000ecaa	testl	%eax, %eax
000000010000ecac	je	0x10000ec17
000000010000ecb2	movq	0x8(%rbx), %r15
000000010000ecb6	movq	0x10(%rbx), %r14
000000010000ecba	cmpq	%r15, %r14
000000010000ecbd	jae	0x10000ecf2
000000010000ecbf	movq	(%rbx), %rax
000000010000ecc2	movq	-0x30(%rbp), %r12
000000010000ecc6	nopw	%cs:(%rax,%rax)
000000010000ecd0	movzbl	(%rax,%r14), %ecx
000000010000ecd5	cmpq	$0x20, %rcx
000000010000ecd9	ja	0x10000ecf6
000000010000ecdb	btq	%rcx, %r13
000000010000ecdf	jae	0x10000ecf6
000000010000ece1	incq	%r14
000000010000ece4	movq	%r14, 0x10(%rbx)
000000010000ece8	cmpq	%r14, %r15
000000010000eceb	jne	0x10000ecd0
000000010000eced	movq	%r15, %r14
000000010000ecf0	jmp	0x10000ecf6
000000010000ecf2	movq	-0x30(%rbp), %r12
000000010000ecf6	movq	%r12, %rdi
000000010000ecf9	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000ecfe	movq	%r15, %rcx
000000010000ed01	subq	%r14, %rcx
000000010000ed04	cmpq	%rax, %rcx
000000010000ed07	jb	0x10000ed21
000000010000ed09	movq	(%rbx), %rdi
000000010000ed0c	addq	%r14, %rdi
000000010000ed0f	movq	%r12, %rsi
000000010000ed12	movq	%rax, %r12
000000010000ed15	movq	%rax, %rdx
000000010000ed18	callq	0x100012ca2                     ## symbol stub for: _memcmp
000000010000ed1d	testl	%eax, %eax
000000010000ed1f	je	0x10000ed7a
000000010000ed21	cmpq	%r14, %r15
000000010000ed24	jbe	0x10000ed52
000000010000ed26	movq	(%rbx), %rax
000000010000ed29	nopl	(%rax)
000000010000ed30	movzbl	(%rax,%r14), %ecx
000000010000ed35	cmpq	$0x20, %rcx
000000010000ed39	ja	0x10000ed52
000000010000ed3b	btq	%rcx, %r13
000000010000ed3f	jae	0x10000ed52
000000010000ed41	incq	%r14
000000010000ed44	movq	%r14, 0x10(%rbx)
000000010000ed48	cmpq	%r14, %r15
000000010000ed4b	jne	0x10000ed30
000000010000ed4d	jmp	0x10000ec17
000000010000ed52	cmpq	%r14, %r15
000000010000ed55	movl	$0x0, %eax
000000010000ed5a	je	0x10000ec19
000000010000ed60	movq	(%rbx), %rcx
000000010000ed63	cmpb	$0x2c, (%rcx,%r14)
000000010000ed68	jne	0x10000ec19
000000010000ed6e	incq	%r14
000000010000ed71	movq	%r14, 0x10(%rbx)
000000010000ed75	jmp	0x10000eca0
000000010000ed7a	addq	%r14, %r12
000000010000ed7d	movq	%r12, 0x10(%rbx)
000000010000ed81	movl	$0x1, %eax
000000010000ed86	jmp	0x10000ec19
000000010000ed8b	nopl	(%rax,%rax)
_tp_byte_item:
000000010000ed90	pushq	%rbp
000000010000ed91	movq	%rsp, %rbp
000000010000ed94	pushq	%rbx
000000010000ed95	pushq	%rax
000000010000ed96	movq	%rsi, %rbx
000000010000ed99	leaq	_tp_byte_item.u8d(%rip), %rsi
000000010000eda0	leaq	-0x10(%rbp), %rdx
000000010000eda4	callq	_tp_int
000000010000eda9	testl	%eax, %eax
000000010000edab	je	0x10000edc0
000000010000edad	movq	-0x10(%rbp), %rsi
000000010000edb1	movq	%rbx, %rdi
000000010000edb4	callq	_tp_push
000000010000edb9	movl	$0x1, %eax
000000010000edbe	jmp	0x10000edc2
000000010000edc0	xorl	%eax, %eax
000000010000edc2	addq	$0x8, %rsp
000000010000edc6	popq	%rbx
000000010000edc7	popq	%rbp
000000010000edc8	retq
000000010000edc9	nopl	(%rax)
_tp_token:
000000010000edd0	pushq	%rbp
000000010000edd1	movq	%rsp, %rbp
000000010000edd4	pushq	%r15
000000010000edd6	pushq	%r14
000000010000edd8	pushq	%r12
000000010000edda	pushq	%rbx
000000010000eddb	movq	%rsi, %r14
000000010000edde	movq	%rdi, %rbx
000000010000ede1	movq	(%rdi), %rsi
000000010000ede4	movq	0x8(%rdi), %rax
000000010000ede8	movq	0x10(%rdi), %r12
000000010000edec	cmpq	%rax, %r12
000000010000edef	jae	0x10000ee25
000000010000edf1	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000edfb	nopl	(%rax,%rax)
000000010000ee00	movzbl	(%rsi,%r12), %edi
000000010000ee05	cmpq	$0x20, %rdi
000000010000ee09	ja	0x10000ee25
000000010000ee0b	btq	%rdi, %rcx
000000010000ee0f	jae	0x10000ee25
000000010000ee11	incq	%r12
000000010000ee14	movq	%r12, 0x10(%rbx)
000000010000ee18	cmpq	%r12, %rax
000000010000ee1b	jne	0x10000ee00
000000010000ee1d	movq	%rax, %r12
000000010000ee20	movq	%rax, %rcx
000000010000ee23	jmp	0x10000ee6e
000000010000ee25	cmpq	%rax, %r12
000000010000ee28	jae	0x10000ee6b
000000010000ee2a	leaq	0x6f(%rip), %rdi
000000010000ee31	movq	%r12, %rcx
000000010000ee34	jmp	0x10000ee52
000000010000ee36	nopw	%cs:(%rax,%rax)
000000010000ee40	cmpl	$0x7d, %r8d
000000010000ee44	je	0x10000ee6e
000000010000ee46	incq	%rcx
000000010000ee49	movq	%rcx, 0x10(%rbx)
000000010000ee4d	cmpq	%rcx, %rax
000000010000ee50	je	0x10000ee20
000000010000ee52	movzbl	(%rsi,%rcx), %r8d
000000010000ee57	leal	-0x9(%r8), %r9d
000000010000ee5b	cmpl	$0x54, %r9d
000000010000ee5f	ja	0x10000ee40
000000010000ee61	movslq	(%rdi,%r9,4), %r8
000000010000ee65	addq	%rdi, %r8
000000010000ee68	jmpq	*%r8
000000010000ee6b	movq	%r12, %rcx
000000010000ee6e	subq	%r12, %rcx
000000010000ee71	leaq	-0x1(%rdx), %r15
000000010000ee75	cmpq	%rdx, %rcx
000000010000ee78	cmovbq	%rcx, %r15
000000010000ee7c	addq	%r12, %rsi
000000010000ee7f	movq	%r14, %rdi
000000010000ee82	movq	%r15, %rdx
000000010000ee85	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000ee8a	movb	$0x0, (%r14,%r15)
000000010000ee8f	movq	0x10(%rbx), %rax
000000010000ee93	subq	%r12, %rax
000000010000ee96	popq	%rbx
000000010000ee97	popq	%r12
000000010000ee99	popq	%r14
000000010000ee9b	popq	%r15
000000010000ee9d	popq	%rbp
000000010000ee9e	retq
000000010000ee9f	nop
000000010000eea0	.byte 0xce #bad opcode
000000010000eea1	.byte 0xff #bad opcode
000000010000eea2	.byte 0xff #bad opcode
000000010000eea3	decl	%esi
000000010000eea5	.byte 0xff #bad opcode
000000010000eea6	.byte 0xff #bad opcode
000000010000eea7	jmpq	*-0x59000001(%rsi)
000000010000eead	.byte 0xff #bad opcode
000000010000eeae	.byte 0xff #bad opcode
000000010000eeaf	decl	%esi
000000010000eeb1	.byte 0xff #bad opcode
000000010000eeb2	.byte 0xff #bad opcode
000000010000eeb3	jmpq	*-0x59000001(%rsi)
000000010000eeb9	.byte 0xff #bad opcode
000000010000eeba	.byte 0xff #bad opcode
000000010000eebb	jmpq	*-0x59000001(%rsi)
000000010000eec1	.byte 0xff #bad opcode
000000010000eec2	.byte 0xff #bad opcode
000000010000eec3	jmpq	*-0x59000001(%rsi)
000000010000eec9	.byte 0xff #bad opcode
000000010000eeca	.byte 0xff #bad opcode
000000010000eecb	jmpq	*-0x59000001(%rsi)
000000010000eed1	.byte 0xff #bad opcode
000000010000eed2	.byte 0xff #bad opcode
000000010000eed3	jmpq	*-0x59000001(%rsi)
000000010000eed9	.byte 0xff #bad opcode
000000010000eeda	.byte 0xff #bad opcode
000000010000eedb	jmpq	*-0x59000001(%rsi)
000000010000eee1	.byte 0xff #bad opcode
000000010000eee2	.byte 0xff #bad opcode
000000010000eee3	jmpq	*-0x59000001(%rsi)
000000010000eee9	.byte 0xff #bad opcode
000000010000eeea	.byte 0xff #bad opcode
000000010000eeeb	jmpq	*-0x59000001(%rsi)
000000010000eef1	.byte 0xff #bad opcode
000000010000eef2	.byte 0xff #bad opcode
000000010000eef3	jmpq	*-0x59000001(%rsi)
000000010000eef9	.byte 0xff #bad opcode
000000010000eefa	.byte 0xff #bad opcode
000000010000eefb	decl	%esi
000000010000eefd	.byte 0xff #bad opcode
000000010000eefe	.byte 0xff #bad opcode
000000010000eeff	jmpq	*-0x59000001(%rsi)
000000010000ef05	.byte 0xff #bad opcode
000000010000ef06	.byte 0xff #bad opcode
000000010000ef07	jmpq	*-0x59000001(%rsi)
000000010000ef0d	.byte 0xff #bad opcode
000000010000ef0e	.byte 0xff #bad opcode
000000010000ef0f	jmpq	*-0x59000001(%rsi)
000000010000ef15	.byte 0xff #bad opcode
000000010000ef16	.byte 0xff #bad opcode
000000010000ef17	jmpq	*-0x31000001(%rsi)
000000010000ef1d	.byte 0xff #bad opcode
000000010000ef1e	.byte 0xff #bad opcode
000000010000ef1f	decl	%esi
000000010000ef21	.byte 0xff #bad opcode
000000010000ef22	.byte 0xff #bad opcode
000000010000ef23	jmpq	*-0x59000001(%rsi)
000000010000ef29	.byte 0xff #bad opcode
000000010000ef2a	.byte 0xff #bad opcode
000000010000ef2b	decl	%esi
000000010000ef2d	.byte 0xff #bad opcode
000000010000ef2e	.byte 0xff #bad opcode
000000010000ef2f	jmpq	*-0x59000001(%rsi)
000000010000ef35	.byte 0xff #bad opcode
000000010000ef36	.byte 0xff #bad opcode
000000010000ef37	jmpq	*-0x59000001(%rsi)
000000010000ef3d	.byte 0xff #bad opcode
000000010000ef3e	.byte 0xff #bad opcode
000000010000ef3f	jmpq	*-0x59000001(%rsi)
000000010000ef45	.byte 0xff #bad opcode
000000010000ef46	.byte 0xff #bad opcode
000000010000ef47	jmpq	*-0x59000001(%rsi)
000000010000ef4d	.byte 0xff #bad opcode
000000010000ef4e	.byte 0xff #bad opcode
000000010000ef4f	jmpq	*-0x59000001(%rsi)
000000010000ef55	.byte 0xff #bad opcode
000000010000ef56	.byte 0xff #bad opcode
000000010000ef57	jmpq	*-0x59000001(%rsi)
000000010000ef5d	.byte 0xff #bad opcode
000000010000ef5e	.byte 0xff #bad opcode
000000010000ef5f	jmpq	*-0x31000001(%rsi)
000000010000ef65	.byte 0xff #bad opcode
000000010000ef66	.byte 0xff #bad opcode
000000010000ef67	jmpq	*-0x59000001(%rsi)
000000010000ef6d	.byte 0xff #bad opcode
000000010000ef6e	.byte 0xff #bad opcode
000000010000ef6f	jmpq	*-0x59000001(%rsi)
000000010000ef75	.byte 0xff #bad opcode
000000010000ef76	.byte 0xff #bad opcode
000000010000ef77	jmpq	*-0x59000001(%rsi)
000000010000ef7d	.byte 0xff #bad opcode
000000010000ef7e	.byte 0xff #bad opcode
000000010000ef7f	jmpq	*-0x59000001(%rsi)
000000010000ef85	.byte 0xff #bad opcode
000000010000ef86	.byte 0xff #bad opcode
000000010000ef87	jmpq	*-0x59000001(%rsi)
000000010000ef8d	.byte 0xff #bad opcode
000000010000ef8e	.byte 0xff #bad opcode
000000010000ef8f	jmpq	*-0x59000001(%rsi)
000000010000ef95	.byte 0xff #bad opcode
000000010000ef96	.byte 0xff #bad opcode
000000010000ef97	jmpq	*-0x59000001(%rsi)
000000010000ef9d	.byte 0xff #bad opcode
000000010000ef9e	.byte 0xff #bad opcode
000000010000ef9f	jmpq	*-0x59000001(%rsi)
000000010000efa5	.byte 0xff #bad opcode
000000010000efa6	.byte 0xff #bad opcode
000000010000efa7	jmpq	*-0x59000001(%rsi)
000000010000efad	.byte 0xff #bad opcode
000000010000efae	.byte 0xff #bad opcode
000000010000efaf	jmpq	*-0x59000001(%rsi)
000000010000efb5	.byte 0xff #bad opcode
000000010000efb6	.byte 0xff #bad opcode
000000010000efb7	jmpq	*-0x59000001(%rsi)
000000010000efbd	.byte 0xff #bad opcode
000000010000efbe	.byte 0xff #bad opcode
000000010000efbf	jmpq	*-0x59000001(%rsi)
000000010000efc5	.byte 0xff #bad opcode
000000010000efc6	.byte 0xff #bad opcode
000000010000efc7	jmpq	*-0x59000001(%rsi)
000000010000efcd	.byte 0xff #bad opcode
000000010000efce	.byte 0xff #bad opcode
000000010000efcf	jmpq	*-0x59000001(%rsi)
000000010000efd5	.byte 0xff #bad opcode
000000010000efd6	.byte 0xff #bad opcode
000000010000efd7	jmpq	*-0x59000001(%rsi)
000000010000efdd	.byte 0xff #bad opcode
000000010000efde	.byte 0xff #bad opcode
000000010000efdf	jmpq	*-0x59000001(%rsi)
000000010000efe5	.byte 0xff #bad opcode
000000010000efe6	.byte 0xff #bad opcode
000000010000efe7	jmpq	*-0x59000001(%rsi)
000000010000efed	.byte 0xff #bad opcode
000000010000efee	.byte 0xff #bad opcode
000000010000efef	decl	%esi
000000010000eff1	.byte 0xff #bad opcode
000000010000eff2	.byte 0xff #bad opcode
000000010000eff3	jmpq	*0x66(%rsi)
000000010000eff6	nopw	%cs:(%rax,%rax)
_tp_elem_item:
000000010000f000	pushq	%rbp
000000010000f001	movq	%rsp, %rbp
000000010000f004	pushq	%r14
000000010000f006	pushq	%rbx
000000010000f007	subq	$0x10, %rsp
000000010000f00b	movq	%rsi, %rbx
000000010000f00e	movq	(%rsi), %rsi
000000010000f011	xorl	%r14d, %r14d
000000010000f014	leaq	-0x18(%rbp), %rcx
000000010000f018	xorl	%edx, %edx
000000010000f01a	callq	_tp_value
000000010000f01f	testl	%eax, %eax
000000010000f021	je	0x10000f035
000000010000f023	movq	-0x18(%rbp), %rsi
000000010000f027	movq	%rbx, %rdi
000000010000f02a	callq	_tp_push
000000010000f02f	movl	$0x1, %r14d
000000010000f035	movl	%r14d, %eax
000000010000f038	addq	$0x10, %rsp
000000010000f03c	popq	%rbx
000000010000f03d	popq	%r14
000000010000f03f	popq	%rbp
000000010000f040	retq
000000010000f041	nopw	%cs:(%rax,%rax)
_tp_kv_item:
000000010000f050	pushq	%rbp
000000010000f051	movq	%rsp, %rbp
000000010000f054	pushq	%r15
000000010000f056	pushq	%r14
000000010000f058	pushq	%rbx
000000010000f059	subq	$0x18, %rsp
000000010000f05d	movq	%rsi, %rbx
000000010000f060	movq	%rdi, %r14
000000010000f063	movq	$0x0, -0x20(%rbp)
000000010000f06b	movq	(%rsi), %rsi
000000010000f06e	xorl	%r15d, %r15d
000000010000f071	leaq	-0x28(%rbp), %rcx
000000010000f075	xorl	%edx, %edx
000000010000f077	callq	_tp_value
000000010000f07c	testl	%eax, %eax
000000010000f07e	je	0x10000f0a6
000000010000f080	cmpl	$0x0, 0x28(%rbx)
000000010000f084	je	0x10000f0b4
000000010000f086	xorl	%r14d, %r14d
000000010000f089	movq	-0x28(%rbp), %rsi
000000010000f08d	movq	%rbx, %rdi
000000010000f090	callq	_tp_push
000000010000f095	movq	%rbx, %rdi
000000010000f098	movq	%r14, %rsi
000000010000f09b	callq	_tp_push
000000010000f0a0	movl	$0x1, %r15d
000000010000f0a6	movl	%r15d, %eax
000000010000f0a9	addq	$0x18, %rsp
000000010000f0ad	popq	%rbx
000000010000f0ae	popq	%r14
000000010000f0b0	popq	%r15
000000010000f0b2	popq	%rbp
000000010000f0b3	retq
000000010000f0b4	movq	0x8(%r14), %rcx
000000010000f0b8	movq	0x10(%r14), %rax
000000010000f0bc	cmpq	%rcx, %rax
000000010000f0bf	jae	0x10000f0f1
000000010000f0c1	movq	(%r14), %rdx
000000010000f0c4	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000f0ce	nop
000000010000f0d0	movzbl	(%rdx,%rax), %edi
000000010000f0d4	cmpq	$0x20, %rdi
000000010000f0d8	ja	0x10000f0f1
000000010000f0da	btq	%rdi, %rsi
000000010000f0de	jae	0x10000f0f1
000000010000f0e0	incq	%rax
000000010000f0e3	movq	%rax, 0x10(%r14)
000000010000f0e7	cmpq	%rax, %rcx
000000010000f0ea	jne	0x10000f0d0
000000010000f0ec	xorl	%r15d, %r15d
000000010000f0ef	jmp	0x10000f0a6
000000010000f0f1	xorl	%r15d, %r15d
000000010000f0f4	cmpq	%rax, %rcx
000000010000f0f7	je	0x10000f0a6
000000010000f0f9	movq	(%r14), %rcx
000000010000f0fc	cmpb	$0x3a, (%rcx,%rax)
000000010000f100	jne	0x10000f0a6
000000010000f102	incq	%rax
000000010000f105	movq	%rax, 0x10(%r14)
000000010000f109	movq	0x8(%rbx), %rsi
000000010000f10d	xorl	%r15d, %r15d
000000010000f110	leaq	-0x20(%rbp), %rcx
000000010000f114	movq	%r14, %rdi
000000010000f117	xorl	%edx, %edx
000000010000f119	callq	_tp_value
000000010000f11e	testl	%eax, %eax
000000010000f120	je	0x10000f0a6
000000010000f122	movq	-0x20(%rbp), %r14
000000010000f126	jmp	0x10000f089
000000010000f12b	nopl	(%rax,%rax)
_fwp_p_map_insert:
000000010000f130	pushq	%rbp
000000010000f131	movq	%rsp, %rbp
000000010000f134	pushq	%r15
000000010000f136	pushq	%r14
000000010000f138	pushq	%r13
000000010000f13a	pushq	%r12
000000010000f13c	pushq	%rbx
000000010000f13d	subq	$0x38, %rsp
000000010000f141	movq	%rdi, %r8
000000010000f144	movq	(%rdx), %r12
000000010000f147	movq	%rcx, -0x58(%rbp)
000000010000f14b	movl	(%rcx), %eax
000000010000f14d	cmpl	$0x4, %eax
000000010000f150	movq	%rsi, -0x40(%rbp)
000000010000f154	jb	0x10000f1b8
000000010000f156	addl	$-0x5, %eax
000000010000f159	cmpl	$0x4, %eax
000000010000f15c	jae	0x10000f21d
000000010000f162	testq	%r12, %r12
000000010000f165	je	0x10000f292
000000010000f16b	xorl	%r15d, %r15d
000000010000f16e	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000f178	movq	%r12, %rcx
000000010000f17b	jmp	0x10000f18c
000000010000f17d	nopl	(%rax)
000000010000f180	movq	%rdi, %rcx
000000010000f183	cmpq	%rcx, %r15
000000010000f186	jae	0x10000f297
000000010000f18c	leaq	(%rcx,%r15), %rsi
000000010000f190	movq	%rsi, %rdi
000000010000f193	shrq	%rdi
000000010000f196	andq	%rax, %rsi
000000010000f199	movq	0x8(%rdx,%rsi,8), %rsi
000000010000f19e	cmpq	%r8, %rsi
000000010000f1a1	setne	%bl
000000010000f1a4	je	0x10000f218
000000010000f1a6	jae	0x10000f180
000000010000f1a8	incq	%rdi
000000010000f1ab	movq	%rdi, %r15
000000010000f1ae	cmpq	%rcx, %r15
000000010000f1b1	jb	0x10000f18c
000000010000f1b3	jmp	0x10000f297
000000010000f1b8	testq	%r12, %r12
000000010000f1bb	je	0x10000f292
000000010000f1c1	xorl	%r15d, %r15d
000000010000f1c4	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000f1ce	movq	%r12, %rcx
000000010000f1d1	jmp	0x10000f1ec
000000010000f1d3	nopw	%cs:(%rax,%rax)
000000010000f1e0	movq	%rdi, %rcx
000000010000f1e3	cmpq	%rcx, %r15
000000010000f1e6	jae	0x10000f297
000000010000f1ec	leaq	(%rcx,%r15), %rsi
000000010000f1f0	movq	%rsi, %rdi
000000010000f1f3	shrq	%rdi
000000010000f1f6	andq	%rax, %rsi
000000010000f1f9	movq	0x8(%rdx,%rsi,8), %rsi
000000010000f1fe	cmpq	%r8, %rsi
000000010000f201	setne	%bl
000000010000f204	je	0x10000f218
000000010000f206	jge	0x10000f1e0
000000010000f208	incq	%rdi
000000010000f20b	movq	%rdi, %r15
000000010000f20e	cmpq	%rcx, %r15
000000010000f211	jb	0x10000f1ec
000000010000f213	jmp	0x10000f297
000000010000f218	movq	%rdi, %r15
000000010000f21b	jmp	0x10000f297
000000010000f21d	testq	%r12, %r12
000000010000f220	je	0x10000f292
000000010000f222	xorl	%r15d, %r15d
000000010000f225	movq	%r12, %rax
000000010000f228	movq	%r12, -0x38(%rbp)
000000010000f22c	jmp	0x10000f242
000000010000f22e	nop
000000010000f230	movq	%r12, %rax
000000010000f233	movq	%r14, %rdx
000000010000f236	movq	%r13, %r8
000000010000f239	cmpq	%rax, %r15
000000010000f23c	movq	-0x38(%rbp), %r12
000000010000f240	jae	0x10000f297
000000010000f242	movq	%rax, -0x50(%rbp)
000000010000f246	addq	%r15, %rax
000000010000f249	movq	%rax, %r12
000000010000f24c	shrq	%r12
000000010000f24f	movabsq	$0x1ffffffffffffffe, %rcx       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000f259	andq	%rcx, %rax
000000010000f25c	movq	%rdx, %r14
000000010000f25f	movq	0x8(%rdx,%rax,8), %rdi
000000010000f264	movq	%r8, %r13
000000010000f267	movq	%r8, %rsi
000000010000f26a	movq	-0x58(%rbp), %rdx
000000010000f26e	callq	_fwp_cmp
000000010000f273	testl	%eax, %eax
000000010000f275	setne	%bl
000000010000f278	je	0x10000f3bb
000000010000f27e	jns	0x10000f230
000000010000f280	incq	%r12
000000010000f283	movq	%r12, %r15
000000010000f286	movq	%r14, %rdx
000000010000f289	movq	%r13, %r8
000000010000f28c	movq	-0x50(%rbp), %rax
000000010000f290	jmp	0x10000f239
000000010000f292	movb	$0x1, %bl
000000010000f294	xorl	%r15d, %r15d
000000010000f297	movzbl	%bl, %r14d
000000010000f29b	addq	%r12, %r14
000000010000f29e	movq	%r14, %rax
000000010000f2a1	shlq	$0x4, %rax
000000010000f2a5	leaq	0x8(%rax), %rdi
000000010000f2a9	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000f2b0	movq	%rdx, -0x30(%rbp)
000000010000f2b4	movq	%r8, -0x48(%rbp)
000000010000f2b8	ja	0x10000f313
000000010000f2ba	addq	$0x17, %rax
000000010000f2be	shrq	$0x4, %rax
000000010000f2c2	leaq	_fwp_gc(%rip), %rcx
000000010000f2c9	movzbl	0xbe8(%rax,%rcx), %eax
000000010000f2d1	movl	0xb48(%rcx,%rax,4), %esi
000000010000f2d8	subq	%rsi, _fwp_gc(%rip)
000000010000f2df	js	0x10000f313
000000010000f2e1	leaq	(%rax,%rax,2), %rax
000000010000f2e5	leaq	(%rcx,%rax,8), %rax
000000010000f2e9	addq	$0x788, %rax                    ## imm = 0x788
000000010000f2ef	movq	(%rax), %r13
000000010000f2f2	testq	%r13, %r13
000000010000f2f5	je	0x10000f303
000000010000f2f7	movq	(%r13), %rcx
000000010000f2fb	notq	%rcx
000000010000f2fe	movq	%rcx, (%rax)
000000010000f301	jmp	0x10000f32a
000000010000f303	movq	0x8(%rax), %r13
000000010000f307	movq	0x10(%rax), %rcx
000000010000f30b	subq	%r13, %rcx
000000010000f30e	cmpq	%rsi, %rcx
000000010000f311	jae	0x10000f322
000000010000f313	movl	$0x2, %esi
000000010000f318	callq	_fwp_gc_alloc_slow
000000010000f31d	movq	%rax, %r13
000000010000f320	jmp	0x10000f332
000000010000f322	leaq	(%rsi,%r13), %rcx
000000010000f326	movq	%rcx, 0x8(%rax)
000000010000f32a	movq	%r13, %rdi
000000010000f32d	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000f332	movq	%r14, (%r13)
000000010000f336	leaq	0x8(%r13), %r14
000000010000f33a	movq	-0x30(%rbp), %rsi
000000010000f33e	addq	$0x8, %rsi
000000010000f342	testb	%bl, %bl
000000010000f344	je	0x10000f38d
000000010000f346	movq	%r15, %rbx
000000010000f349	shlq	$0x4, %rbx
000000010000f34d	movq	%r14, %rdi
000000010000f350	movq	%rbx, %rdx
000000010000f353	movq	%rsi, -0x30(%rbp)
000000010000f357	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000f35c	movq	-0x48(%rbp), %rax
000000010000f360	movq	%rax, (%r14,%rbx)
000000010000f364	movq	-0x40(%rbp), %rax
000000010000f368	movq	%rax, 0x8(%r14,%rbx)
000000010000f36d	leaq	(%r14,%rbx), %rdi
000000010000f371	addq	$0x10, %rdi
000000010000f375	addq	-0x30(%rbp), %rbx
000000010000f379	subq	%r15, %r12
000000010000f37c	shlq	$0x4, %r12
000000010000f380	movq	%rbx, %rsi
000000010000f383	movq	%r12, %rdx
000000010000f386	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000f38b	jmp	0x10000f3a9
000000010000f38d	shlq	$0x4, %r12
000000010000f391	movq	%r14, %rdi
000000010000f394	movq	%r12, %rdx
000000010000f397	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000f39c	shlq	$0x4, %r15
000000010000f3a0	movq	-0x40(%rbp), %rax
000000010000f3a4	movq	%rax, 0x8(%r14,%r15)
000000010000f3a9	movq	%r13, %rax
000000010000f3ac	addq	$0x38, %rsp
000000010000f3b0	popq	%rbx
000000010000f3b1	popq	%r12
000000010000f3b3	popq	%r13
000000010000f3b5	popq	%r14
000000010000f3b7	popq	%r15
000000010000f3b9	popq	%rbp
000000010000f3ba	retq
000000010000f3bb	movq	%r12, %r15
000000010000f3be	movq	-0x38(%rbp), %r12
000000010000f3c2	movq	%r14, %rdx
000000010000f3c5	movq	%r13, %r8
000000010000f3c8	jmp	0x10000f297
000000010000f3cd	nopl	(%rax)
_fwp_box_i128:
000000010000f3d0	pushq	%rbp
000000010000f3d1	movq	%rsp, %rbp
000000010000f3d4	pushq	%r14
000000010000f3d6	pushq	%rbx
000000010000f3d7	leaq	_fwp_gc(%rip), %rax
000000010000f3de	movzbl	0x780c(%rip), %edx
000000010000f3e5	movl	0xb48(%rax,%rdx,4), %ecx
000000010000f3ec	subq	%rcx, _fwp_gc(%rip)
000000010000f3f3	js	0x10000f427
000000010000f3f5	leaq	(%rdx,%rdx,2), %rdx
000000010000f3f9	leaq	(%rax,%rdx,8), %rdx
000000010000f3fd	addq	$0x3c8, %rdx                    ## imm = 0x3C8
000000010000f404	movq	(%rdx), %rax
000000010000f407	testq	%rax, %rax
000000010000f40a	je	0x10000f417
000000010000f40c	movq	(%rax), %rcx
000000010000f40f	notq	%rcx
000000010000f412	movq	%rcx, (%rdx)
000000010000f415	jmp	0x10000f44b
000000010000f417	movq	0x8(%rdx), %rax
000000010000f41b	movq	0x10(%rdx), %r8
000000010000f41f	subq	%rax, %r8
000000010000f422	cmpq	%rcx, %r8
000000010000f425	jae	0x10000f444
000000010000f427	movq	%rdi, %rbx
000000010000f42a	movl	$0x10, %edi
000000010000f42f	movq	%rsi, %r14
000000010000f432	movl	$0x1, %esi
000000010000f437	callq	_fwp_gc_alloc_slow
000000010000f43c	movq	%r14, %rsi
000000010000f43f	movq	%rbx, %rdi
000000010000f442	jmp	0x10000f451
000000010000f444	addq	%rax, %rcx
000000010000f447	movq	%rcx, 0x8(%rdx)
000000010000f44b	xorps	%xmm0, %xmm0
000000010000f44e	movups	%xmm0, (%rax)
000000010000f451	movq	%rsi, 0x8(%rax)
000000010000f455	movq	%rdi, (%rax)
000000010000f458	popq	%rbx
000000010000f459	popq	%r14
000000010000f45b	popq	%rbp
000000010000f45c	retq
000000010000f45d	nopl	(%rax)
_fwp_utf8_put:
000000010000f460	pushq	%rbp
000000010000f461	movq	%rsp, %rbp
000000010000f464	subq	$0x10, %rsp
000000010000f468	cmpl	$0x7f, %esi
000000010000f46b	ja	0x10000f47b
000000010000f46d	movb	%sil, -0x4(%rbp)
000000010000f471	movl	$0x1, %edx
000000010000f476	jmp	0x10000f518
000000010000f47b	movl	%esi, %eax
000000010000f47d	cmpl	$0x7ff, %esi                    ## imm = 0x7FF
000000010000f483	ja	0x10000f4a0
000000010000f485	shrl	$0x6, %eax
000000010000f488	orb	$-0x40, %al
000000010000f48a	movb	%al, -0x4(%rbp)
000000010000f48d	andb	$0x3f, %sil
000000010000f491	orb	$-0x80, %sil
000000010000f495	movb	%sil, -0x3(%rbp)
000000010000f499	movl	$0x2, %edx
000000010000f49e	jmp	0x10000f518
000000010000f4a0	cmpl	$0xffff, %esi                   ## imm = 0xFFFF
000000010000f4a6	ja	0x10000f4cf
000000010000f4a8	shrl	$0xc, %eax
000000010000f4ab	orb	$-0x20, %al
000000010000f4ad	movb	%al, -0x4(%rbp)
000000010000f4b0	movl	%esi, %eax
000000010000f4b2	shrl	$0x6, %eax
000000010000f4b5	andb	$0x3f, %al
000000010000f4b7	orb	$-0x80, %al
000000010000f4b9	movb	%al, -0x3(%rbp)
000000010000f4bc	andb	$0x3f, %sil
000000010000f4c0	orb	$-0x80, %sil
000000010000f4c4	movb	%sil, -0x2(%rbp)
000000010000f4c8	movl	$0x3, %edx
000000010000f4cd	jmp	0x10000f518
000000010000f4cf	shrl	$0x12, %eax
000000010000f4d2	movl	%esi, %ecx
000000010000f4d4	shrl	$0xc, %ecx
000000010000f4d7	andb	$0x3f, %cl
000000010000f4da	movl	%esi, %edx
000000010000f4dc	shrl	$0x6, %edx
000000010000f4df	movd	%eax, %xmm0
000000010000f4e3	movzbl	%cl, %eax
000000010000f4e6	pinsrb	$0x1, %eax, %xmm0
000000010000f4ec	andb	$0x3f, %dl
000000010000f4ef	movzbl	%dl, %eax
000000010000f4f2	pinsrb	$0x2, %eax, %xmm0
000000010000f4f8	andb	$0x3f, %sil
000000010000f4fc	movzbl	%sil, %eax
000000010000f500	pinsrb	$0x3, %eax, %xmm0
000000010000f506	por	0x3962(%rip), %xmm0
000000010000f50e	movd	%xmm0, -0x4(%rbp)
000000010000f513	movl	$0x4, %edx
000000010000f518	leaq	-0x4(%rbp), %rsi
000000010000f51c	callq	_buf_put
000000010000f521	addq	$0x10, %rsp
000000010000f525	popq	%rbp
000000010000f526	retq
000000010000f527	nopw	(%rax,%rax)
_tp_push:
000000010000f530	pushq	%rbp
000000010000f531	movq	%rsp, %rbp
000000010000f534	pushq	%r15
000000010000f536	pushq	%r14
000000010000f538	pushq	%r13
000000010000f53a	pushq	%r12
000000010000f53c	pushq	%rbx
000000010000f53d	pushq	%rax
000000010000f53e	movq	%rsi, %rdx
000000010000f541	movq	%rdi, %r14
000000010000f544	movq	0x18(%rdi), %r15
000000010000f548	cmpq	0x20(%rdi), %r15
000000010000f54c	jne	0x10000f5bf
000000010000f54e	leaq	(%r15,%r15), %rax
000000010000f552	testq	%r15, %r15
000000010000f555	movl	$0x8, %r13d
000000010000f55b	cmovneq	%rax, %r13
000000010000f55f	movq	%r13, 0x20(%r14)
000000010000f563	movq	0x10(%r14), %r12
000000010000f567	shlq	$0x3, %r13
000000010000f56b	cmpq	$0x4000, %r13                   ## imm = 0x4000
000000010000f572	movq	%rdx, -0x30(%rbp)
000000010000f576	ja	0x10000f5d5
000000010000f578	movq	%r13, %rcx
000000010000f57b	shrq	$0x4, %rcx
000000010000f57f	leaq	_fwp_gc(%rip), %rax
000000010000f586	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000f58e	movl	0xb48(%rax,%rcx,4), %esi
000000010000f595	subq	%rsi, _fwp_gc(%rip)
000000010000f59c	js	0x10000f5d5
000000010000f59e	leaq	(%rcx,%rcx,2), %rcx
000000010000f5a2	leaq	(%rax,%rcx,8), %rax
000000010000f5a6	addq	$0x788, %rax                    ## imm = 0x788
000000010000f5ac	movq	(%rax), %rbx
000000010000f5af	testq	%rbx, %rbx
000000010000f5b2	je	0x10000f5c5
000000010000f5b4	movq	(%rbx), %rcx
000000010000f5b7	notq	%rcx
000000010000f5ba	movq	%rcx, (%rax)
000000010000f5bd	jmp	0x10000f5f4
000000010000f5bf	movq	0x10(%r14), %rbx
000000010000f5c3	jmp	0x10000f62e
000000010000f5c5	movq	0x8(%rax), %rbx
000000010000f5c9	movq	0x10(%rax), %rcx
000000010000f5cd	subq	%rbx, %rcx
000000010000f5d0	cmpq	%rsi, %rcx
000000010000f5d3	jae	0x10000f5ec
000000010000f5d5	movq	%r13, %rdi
000000010000f5d8	movl	$0x2, %esi
000000010000f5dd	callq	_fwp_gc_alloc_slow
000000010000f5e2	movq	%rax, %rbx
000000010000f5e5	testq	%r12, %r12
000000010000f5e8	jne	0x10000f601
000000010000f5ea	jmp	0x10000f622
000000010000f5ec	leaq	(%rbx,%rsi), %rcx
000000010000f5f0	movq	%rcx, 0x8(%rax)
000000010000f5f4	movq	%rbx, %rdi
000000010000f5f7	callq	0x100012bee                     ## symbol stub for: ___bzero
000000010000f5fc	testq	%r12, %r12
000000010000f5ff	je	0x10000f622
000000010000f601	shlq	$0x3, %r15
000000010000f605	cmpq	%r13, %r15
000000010000f608	cmovaeq	%r13, %r15
000000010000f60c	movq	%rbx, %rdi
000000010000f60f	movq	%r12, %rsi
000000010000f612	movq	%r15, %rdx
000000010000f615	callq	0x100012ca8                     ## symbol stub for: _memcpy
000000010000f61a	movq	%r12, %rdi
000000010000f61d	callq	_fwp_mem_free
000000010000f622	movq	%rbx, 0x10(%r14)
000000010000f626	movq	0x18(%r14), %r15
000000010000f62a	movq	-0x30(%rbp), %rdx
000000010000f62e	leaq	0x1(%r15), %rax
000000010000f632	movq	%rax, 0x18(%r14)
000000010000f636	movq	%rdx, (%rbx,%r15,8)
000000010000f63a	addq	$0x8, %rsp
000000010000f63e	popq	%rbx
000000010000f63f	popq	%r12
000000010000f641	popq	%r13
000000010000f643	popq	%r14
000000010000f645	popq	%r15
000000010000f647	popq	%rbp
000000010000f648	retq
000000010000f649	nopl	(%rax)
_fwp_cmp:
000000010000f650	pushq	%rbp
000000010000f651	movq	%rsp, %rbp
000000010000f654	pushq	%r15
000000010000f656	pushq	%r14
000000010000f658	pushq	%r13
000000010000f65a	pushq	%r12
000000010000f65c	pushq	%rbx
000000010000f65d	subq	$0x38, %rsp
000000010000f661	movq	%rsi, %rbx
000000010000f664	movq	%rdi, %r14
000000010000f667	movl	(%rdx), %r13d
000000010000f66a	cmpq	$0x15, %r13
000000010000f66e	ja	0x10000f695
000000010000f670	movq	%rdx, %r15
000000010000f673	leaq	0x4ba(%rip), %rax
000000010000f67a	movslq	(%rax,%r13,4), %rcx
000000010000f67e	addq	%rax, %rcx
000000010000f681	jmpq	*%rcx
000000010000f683	xorl	%ecx, %ecx
000000010000f685	cmpq	%rbx, %r14
000000010000f688	setg	%cl
000000010000f68b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f690	cmovgel	%ecx, %eax
000000010000f693	jmp	0x10000f6a5
000000010000f695	xorl	%ecx, %ecx
000000010000f697	cmpq	%rbx, %r14
000000010000f69a	seta	%cl
000000010000f69d	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f6a2	cmovael	%ecx, %eax
000000010000f6a5	addq	$0x38, %rsp
000000010000f6a9	popq	%rbx
000000010000f6aa	popq	%r12
000000010000f6ac	popq	%r13
000000010000f6ae	popq	%r14
000000010000f6b0	popq	%r15
000000010000f6b2	popq	%rbp
000000010000f6b3	retq
000000010000f6b4	movq	%rbx, %rsi
000000010000f6b7	movq	(%r14), %rbx
000000010000f6ba	movq	(%rsi), %r15
000000010000f6bd	addq	$0x8, %r14
000000010000f6c1	addq	$0x8, %rsi
000000010000f6c5	cmpq	%r15, %rbx
000000010000f6c8	movq	%r15, %rdx
000000010000f6cb	cmovbq	%rbx, %rdx
000000010000f6cf	movq	%r14, %rdi
000000010000f6d2	callq	0x100012ca2                     ## symbol stub for: _memcmp
000000010000f6d7	testl	%eax, %eax
000000010000f6d9	je	0x10000fa75
000000010000f6df	sarl	$0x1f, %eax
000000010000f6e2	orl	$0x1, %eax
000000010000f6e5	jmp	0x10000f6a5
000000010000f6e7	movq	%r14, -0x30(%rbp)
000000010000f6eb	movq	(%r14), %rax
000000010000f6ee	movq	(%rbx), %r12
000000010000f6f1	cmpq	%r12, %rax
000000010000f6f4	movq	%r12, -0x38(%rbp)
000000010000f6f8	movq	%rax, -0x40(%rbp)
000000010000f6fc	cmovbq	%rax, %r12
000000010000f700	testq	%r12, %r12
000000010000f703	je	0x10000f76c
000000010000f705	movq	%rbx, %r14
000000010000f708	movq	0x38(%r15), %rax
000000010000f70c	movq	%rax, -0x48(%rbp)
000000010000f710	movl	$0x10, %ebx
000000010000f715	jmp	0x10000f729
000000010000f717	nopw	(%rax,%rax)
000000010000f720	addq	$0x10, %rbx
000000010000f724	decq	%r12
000000010000f727	je	0x10000f76c
000000010000f729	movq	-0x30(%rbp), %rax
000000010000f72d	movq	-0x8(%rax,%rbx), %rdi
000000010000f732	movq	-0x8(%r14,%rbx), %rsi
000000010000f737	movq	-0x48(%rbp), %rdx
000000010000f73b	callq	_fwp_cmp
000000010000f740	testl	%eax, %eax
000000010000f742	jne	0x10000f6a5
000000010000f748	cmpl	$0x12, %r13d
000000010000f74c	jne	0x10000f720
000000010000f74e	movq	-0x30(%rbp), %rax
000000010000f752	movq	(%rax,%rbx), %rdi
000000010000f756	movq	(%r14,%rbx), %rsi
000000010000f75a	movq	0x40(%r15), %rdx
000000010000f75e	callq	_fwp_cmp
000000010000f763	testl	%eax, %eax
000000010000f765	je	0x10000f720
000000010000f767	jmp	0x10000f6a5
000000010000f76c	xorl	%ecx, %ecx
000000010000f76e	movq	-0x38(%rbp), %rax
000000010000f772	cmpq	%rax, -0x40(%rbp)
000000010000f776	jmp	0x10000f69a
000000010000f77b	movq	(%r14), %rdx
000000010000f77e	movq	0x8(%r14), %rcx
000000010000f782	movq	(%rbx), %rdi
000000010000f785	movq	0x8(%rbx), %rsi
000000010000f789	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f78e	cmpq	%rdi, %rdx
000000010000f791	movq	%rcx, %r8
000000010000f794	sbbq	%rsi, %r8
000000010000f797	jb	0x10000f6a5
000000010000f79d	cmpq	%rdx, %rdi
000000010000f7a0	sbbq	%rcx, %rsi
000000010000f7a3	setb	%al
000000010000f7a6	movzbl	%al, %eax
000000010000f7a9	jmp	0x10000f6a5
000000010000f7ae	movl	%r14d, %ecx
000000010000f7b1	sarl	$0x1f, %ecx
000000010000f7b4	shrl	%ecx
000000010000f7b6	xorl	%r14d, %ecx
000000010000f7b9	movl	%ebx, %edx
000000010000f7bb	sarl	$0x1f, %edx
000000010000f7be	shrl	%edx
000000010000f7c0	xorl	%ebx, %edx
000000010000f7c2	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f7c7	cmpl	%edx, %ecx
000000010000f7c9	jl	0x10000f6a5
000000010000f7cf	jmp	0x10000f7f9
000000010000f7d1	movq	%r14, %rcx
000000010000f7d4	sarq	$0x3f, %rcx
000000010000f7d8	shrq	%rcx
000000010000f7db	xorq	%r14, %rcx
000000010000f7de	movq	%rbx, %rdx
000000010000f7e1	sarq	$0x3f, %rdx
000000010000f7e5	shrq	%rdx
000000010000f7e8	xorq	%rbx, %rdx
000000010000f7eb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f7f0	cmpq	%rdx, %rcx
000000010000f7f3	jl	0x10000f6a5
000000010000f7f9	setg	%al
000000010000f7fc	movzbl	%al, %eax
000000010000f7ff	jmp	0x10000f6a5
000000010000f804	movq	(%r14), %rdx
000000010000f807	movq	0x8(%r14), %rcx
000000010000f80b	movq	(%rbx), %rdi
000000010000f80e	movq	0x8(%rbx), %rsi
000000010000f812	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f817	cmpq	%rdi, %rdx
000000010000f81a	movq	%rcx, %r8
000000010000f81d	sbbq	%rsi, %r8
000000010000f820	jl	0x10000f6a5
000000010000f826	cmpq	%rdx, %rdi
000000010000f829	sbbq	%rcx, %rsi
000000010000f82c	setl	%al
000000010000f82f	movzbl	%al, %eax
000000010000f832	jmp	0x10000f6a5
000000010000f837	testq	%r14, %r14
000000010000f83a	sete	%al
000000010000f83d	testq	%rbx, %rbx
000000010000f840	sete	%cl
000000010000f843	orb	%al, %cl
000000010000f845	je	0x10000fa7f
000000010000f84b	testq	%rbx, %rbx
000000010000f84e	setne	%cl
000000010000f851	orb	%al, %cl
000000010000f853	xorb	$0x1, %cl
000000010000f856	movzbl	%cl, %ecx
000000010000f859	testb	%al, %al
000000010000f85b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000f860	cmovel	%ecx, %eax
000000010000f863	testq	%rbx, %rbx
000000010000f866	cmovel	%ecx, %eax
000000010000f869	jmp	0x10000f6a5
000000010000f86e	movq	%r14, %r13
000000010000f871	movq	%rbx, %r14
000000010000f874	movslq	0x10(%r15), %rbx
000000010000f878	testq	%rbx, %rbx
000000010000f87b	jle	0x10000fb2a
000000010000f881	movq	0x20(%r15), %r15
000000010000f885	xorl	%r12d, %r12d
000000010000f888	nopl	(%rax,%rax)
000000010000f890	movq	0x8(%r13,%r12,8), %rdi
000000010000f895	movq	0x8(%r14,%r12,8), %rsi
000000010000f89a	movq	(%r15,%r12,8), %rdx
000000010000f89e	callq	_fwp_cmp
000000010000f8a3	testl	%eax, %eax
000000010000f8a5	jne	0x10000f6a5
000000010000f8ab	incq	%r12
000000010000f8ae	xorl	%eax, %eax
000000010000f8b0	cmpq	%r12, %rbx
000000010000f8b3	jne	0x10000f890
000000010000f8b5	jmp	0x10000f6a5
000000010000f8ba	movq	(%r14), %rax
000000010000f8bd	movabsq	$0x7fffffffffffffff, %r13       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000f8c7	movq	%rax, -0x30(%rbp)
000000010000f8cb	andq	%r13, %rax
000000010000f8ce	movq	(%rbx), %rcx
000000010000f8d1	movq	%rcx, -0x48(%rbp)
000000010000f8d5	andq	%rcx, %r13
000000010000f8d8	cmpq	%r13, %rax
000000010000f8db	movq	%r13, -0x58(%rbp)
000000010000f8df	movq	%rax, -0x50(%rbp)
000000010000f8e3	cmovbq	%rax, %r13
000000010000f8e7	testq	%r13, %r13
000000010000f8ea	je	0x10000fa40
000000010000f8f0	movq	0x38(%r15), %r15
000000010000f8f4	leaq	0x8(%r14), %rax
000000010000f8f8	movq	%rax, -0x40(%rbp)
000000010000f8fc	leaq	0x8(%rbx), %rax
000000010000f900	movq	%rax, -0x38(%rbp)
000000010000f904	xorl	%r12d, %r12d
000000010000f907	nopw	(%rax,%rax)
000000010000f910	movl	$0x8, %eax
000000010000f915	testq	%r15, %r15
000000010000f918	je	0x10000f92e
000000010000f91a	movl	(%r15), %ecx
000000010000f91d	cmpq	$0xa, %rcx
000000010000f921	ja	0x10000f92e
000000010000f923	leaq	0x382e(%rip), %rax
000000010000f92a	movq	(%rax,%rcx,8), %rax
000000010000f92e	movq	-0x40(%rbp), %rcx
000000010000f932	cmpq	$0x0, -0x30(%rbp)
000000010000f937	jns	0x10000f93d
000000010000f939	movq	0x10(%r14), %rcx
000000010000f93d	movq	%rax, %rdx
000000010000f940	imulq	%r12, %rdx
000000010000f944	cmpq	$0x8, %rax
000000010000f948	je	0x10000f975
000000010000f94a	cmpq	$0x2, %rax
000000010000f94e	je	0x10000f965
000000010000f950	cmpq	$0x1, %rax
000000010000f954	jne	0x10000f983
000000010000f956	movzbl	(%rcx,%rdx), %ecx
000000010000f95a	movl	(%r15), %eax
000000010000f95d	testl	%eax, %eax
000000010000f95f	movsbq	%cl, %rdi
000000010000f963	jmp	0x10000f98f
000000010000f965	movzwl	(%rcx,%rdx), %ecx
000000010000f969	movl	(%r15), %eax
000000010000f96c	cmpl	$0x1, %eax
000000010000f96f	movswq	%cx, %rdi
000000010000f973	jmp	0x10000f98f
000000010000f975	movq	(%rcx,%rdx), %rdi
000000010000f979	testq	%r15, %r15
000000010000f97c	je	0x10000f9c9
000000010000f97e	movl	(%r15), %eax
000000010000f981	jmp	0x10000f993
000000010000f983	movl	(%rcx,%rdx), %ecx
000000010000f986	movl	(%r15), %eax
000000010000f989	cmpl	$0x2, %eax
000000010000f98c	movslq	%ecx, %rdi
000000010000f98f	cmovneq	%rcx, %rdi
000000010000f993	cmpl	$0xa, %eax
000000010000f996	ja	0x10000f9c9
000000010000f998	movl	$0x484, %ecx                    ## imm = 0x484
000000010000f99d	btl	%eax, %ecx
000000010000f9a0	jb	0x10000f9c2
000000010000f9a2	movl	$0x1, %ecx
000000010000f9a7	movl	$0x21, %edx
000000010000f9ac	btl	%eax, %edx
000000010000f9af	jb	0x10000f9ce
000000010000f9b1	movl	$0x42, %ecx
000000010000f9b6	btl	%eax, %ecx
000000010000f9b9	jae	0x10000f9c9
000000010000f9bb	movl	$0x2, %ecx
000000010000f9c0	jmp	0x10000f9ce
000000010000f9c2	movl	$0x4, %ecx
000000010000f9c7	jmp	0x10000f9ce
000000010000f9c9	movl	$0x8, %ecx
000000010000f9ce	movq	-0x38(%rbp), %rax
000000010000f9d2	cmpq	$0x0, -0x48(%rbp)
000000010000f9d7	jns	0x10000f9dd
000000010000f9d9	movq	0x10(%rbx), %rax
000000010000f9dd	movq	%rcx, %rdx
000000010000f9e0	imulq	%r12, %rdx
000000010000f9e4	cmpq	$0x1, %rcx
000000010000f9e8	je	0x10000fa08
000000010000f9ea	cmpl	$0x2, %ecx
000000010000f9ed	je	0x10000f9fa
000000010000f9ef	cmpl	$0x8, %ecx
000000010000f9f2	jne	0x10000fa16
000000010000f9f4	movq	(%rax,%rdx), %rsi
000000010000f9f8	jmp	0x10000fa24
000000010000f9fa	cmpl	$0x1, (%r15)
000000010000f9fe	movzwl	(%rax,%rdx), %eax
000000010000fa02	movswq	%ax, %rsi
000000010000fa06	jmp	0x10000fa20
000000010000fa08	cmpl	$0x0, (%r15)
000000010000fa0c	movzbl	(%rax,%rdx), %eax
000000010000fa10	movsbq	%al, %rsi
000000010000fa14	jmp	0x10000fa20
000000010000fa16	cmpl	$0x2, (%r15)
000000010000fa1a	movl	(%rax,%rdx), %eax
000000010000fa1d	movslq	%eax, %rsi
000000010000fa20	cmovneq	%rax, %rsi
000000010000fa24	movq	%r15, %rdx
000000010000fa27	callq	_fwp_cmp
000000010000fa2c	testl	%eax, %eax
000000010000fa2e	jne	0x10000f6a5
000000010000fa34	incq	%r12
000000010000fa37	cmpq	%r12, %r13
000000010000fa3a	jne	0x10000f910
000000010000fa40	xorl	%ecx, %ecx
000000010000fa42	movq	-0x50(%rbp), %rax
000000010000fa46	cmpq	-0x58(%rbp), %rax
000000010000fa4a	jmp	0x10000f69a
000000010000fa4f	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000fa56	ja	0x10000fac6
000000010000fa58	movl	%r14d, %eax
000000010000fa5b	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000fa62	jbe	0x10000fad2
000000010000fa64	movl	(%rbx), %ecx
000000010000fa66	cmpl	%ecx, %eax
000000010000fa68	je	0x10000fad8
000000010000fa6a	seta	%al
000000010000fa6d	movzbl	%al, %ecx
000000010000fa70	jmp	0x10000f69d
000000010000fa75	xorl	%ecx, %ecx
000000010000fa77	cmpq	%r15, %rbx
000000010000fa7a	jmp	0x10000f69a
000000010000fa7f	movq	0x38(%r15), %r15
000000010000fa83	nopw	%cs:(%rax,%rax)
000000010000fa90	movq	0x8(%r14), %rdi
000000010000fa94	movq	0x8(%rbx), %rsi
000000010000fa98	movq	%r15, %rdx
000000010000fa9b	callq	_fwp_cmp
000000010000faa0	testl	%eax, %eax
000000010000faa2	jne	0x10000f6a5
000000010000faa8	movq	0x10(%r14), %r14
000000010000faac	movq	0x10(%rbx), %rbx
000000010000fab0	testq	%r14, %r14
000000010000fab3	sete	%al
000000010000fab6	je	0x10000f84b
000000010000fabc	testq	%rbx, %rbx
000000010000fabf	jne	0x10000fa90
000000010000fac1	jmp	0x10000f84b
000000010000fac6	movl	(%r14), %eax
000000010000fac9	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000fad0	ja	0x10000fa64
000000010000fad2	movl	%ebx, %ecx
000000010000fad4	cmpl	%ecx, %eax
000000010000fad6	jne	0x10000fa6a
000000010000fad8	movq	%r14, %r13
000000010000fadb	movq	%rbx, %r14
000000010000fade	movq	0x28(%r15), %rcx
000000010000fae2	movl	%eax, %eax
000000010000fae4	movslq	(%rcx,%rax,4), %rbx
000000010000fae8	testq	%rbx, %rbx
000000010000faeb	jle	0x10000fb2a
000000010000faed	movq	0x30(%r15), %rcx
000000010000faf1	movq	(%rcx,%rax,8), %r15
000000010000faf5	xorl	%r12d, %r12d
000000010000faf8	nopl	(%rax,%rax)
000000010000fb00	movq	0x8(%r13,%r12,8), %rdi
000000010000fb05	movq	0x8(%r14,%r12,8), %rsi
000000010000fb0a	movq	(%r15,%r12,8), %rdx
000000010000fb0e	callq	_fwp_cmp
000000010000fb13	testl	%eax, %eax
000000010000fb15	jne	0x10000f6a5
000000010000fb1b	incq	%r12
000000010000fb1e	xorl	%eax, %eax
000000010000fb20	cmpq	%r12, %rbx
000000010000fb23	jne	0x10000fb00
000000010000fb25	jmp	0x10000f6a5
000000010000fb2a	xorl	%eax, %eax
000000010000fb2c	jmp	0x10000f6a5
000000010000fb31	nopl	(%rax)
000000010000fb34	sti
000000010000fb36	.byte 0xff #bad opcode
000000010000fb37	decl	-0x5(%rdi)
000000010000fb3a	.byte 0xff #bad opcode
000000010000fb3b	decl	-0x5(%rdi)
000000010000fb3e	.byte 0xff #bad opcode
000000010000fb3f	decl	-0x5(%rdi)
000000010000fb42	.byte 0xff #bad opcode
000000010000fb43	callq	*%rax
000000010000fb45	cld
000000010000fb46	.byte 0xff #bad opcode
000000010000fb47	jmpq	*-0x5(%rcx)
000000010000fb4a	.byte 0xff #bad opcode
000000010000fb4b	jmpq	*-0x5(%rcx)
000000010000fb4e	.byte 0xff #bad opcode
000000010000fb4f	jmpq	*-0x5(%rcx)
000000010000fb52	.byte 0xff #bad opcode
000000010000fb53	jmpq	*-0x5(%rcx)
000000010000fb56	.byte 0xff #bad opcode
000000010000fb57	incl	-0x4(%rdi)
000000010000fb5a	.byte 0xff #bad opcode
000000010000fb5b	.byte 0xff #bad opcode
000000010000fb5c	jp	0x10000fb5a
000000010000fb5e	.byte 0xff #bad opcode
000000010000fb5f	lcalll	*-0x7f000004(%rbp)
000000010000fb65	sti
000000010000fb66	.byte 0xff #bad opcode
000000010000fb67	incl	0x1bfffffb(%rax)
000000010000fb6d	.byte 0xff #bad opcode
000000010000fb6e	.byte 0xff #bad opcode
000000010000fb6f	incl	(%rbx)
000000010000fb71	std
000000010000fb72	.byte 0xff #bad opcode
000000010000fb73	.byte 0xff #bad opcode
000000010000fb74	cmpb	%ch, %bh
000000010000fb76	.byte 0xff #bad opcode
000000010000fb77	incl	-0x4c000003(%rsi)
000000010000fb7d	sti
000000010000fb7e	.byte 0xff #bad opcode
000000010000fb7f	pushq	0x4ffffffb(%rbx)
000000010000fb85	sti
000000010000fb86	.byte 0xff #bad opcode
000000010000fb87	decl	-0x5(%rdi)
000000010000fb8a	.byte 0xff #bad opcode
000000010000fb8b	decl	(%rdi)
000000010000fb8d	.byte 0x1f #bad opcode
000000010000fb8e	addb	%dl, 0x48(%rbp)
000000010000fb92	movl	%esp, %ebp
000000010000fb94	pushq	%r15
000000010000fb96	pushq	%r14
000000010000fb98	pushq	%r13
000000010000fb9a	pushq	%r12
000000010000fb9c	pushq	%rbx
000000010000fb9d	subq	$0x268, %rsp                    ## imm = 0x268
000000010000fba4	movq	0x5485(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fbab	movq	(%rax), %rax
000000010000fbae	movq	%rax, -0x30(%rbp)
000000010000fbb2	movl	(%rdx), %eax
000000010000fbb4	cmpq	$0x19, %rax
000000010000fbb8	ja	0x100010e7b
000000010000fbbe	movq	%rdx, %r15
000000010000fbc1	movq	%rsi, %r14
000000010000fbc4	movq	%rdi, %r13
000000010000fbc7	leaq	0x141e(%rip), %rdx
000000010000fbce	movslq	(%rdx,%rax,4), %rsi
000000010000fbd2	addq	%rdx, %rsi
000000010000fbd5	movq	%rdi, -0x278(%rbp)
000000010000fbdc	jmpq	*%rsi
000000010000fbde	leaq	0x44c8(%rip), %rdx              ## literal pool for: "%lld"
000000010000fbe5	jmp	0x10000fbee
000000010000fbe7	leaq	0x44c4(%rip), %rdx              ## literal pool for: "%llu"
000000010000fbee	leaq	-0x270(%rbp), %rbx
000000010000fbf5	movl	$0x200, %esi                    ## imm = 0x200
000000010000fbfa	movq	%rbx, %rdi
000000010000fbfd	movq	%r14, %rcx
000000010000fc00	xorl	%eax, %eax
000000010000fc02	callq	0x100012d0e                     ## symbol stub for: _snprintf
000000010000fc07	jmp	0x100010e65
000000010000fc0c	cmpl	$0x13, %eax
000000010000fc0f	leaq	0x44cd(%rip), %rax              ## literal pool for: "set{"
000000010000fc16	leaq	0x44cb(%rip), %rsi              ## literal pool for: "map{"
000000010000fc1d	cmoveq	%rax, %rsi
000000010000fc21	movl	$0x4, %edx
000000010000fc26	movq	%r13, %rdi
000000010000fc29	callq	_buf_put
000000010000fc2e	cmpq	$0x0, (%r14)
000000010000fc32	je	0x10000fd0e
000000010000fc38	movq	0x38(%r15), %rdx
000000010000fc3c	movq	0x8(%r14), %rsi
000000010000fc40	movq	-0x278(%rbp), %rbx
000000010000fc47	movq	%rbx, %rdi
000000010000fc4a	xorl	%ecx, %ecx
000000010000fc4c	callq	_fwp_write
000000010000fc51	cmpl	$0x12, (%r15)
000000010000fc55	jne	0x10000fc7d
000000010000fc57	leaq	0x448f(%rip), %rsi              ## literal pool for: ": "
000000010000fc5e	movl	$0x2, %edx
000000010000fc63	movq	%rbx, %rdi
000000010000fc66	callq	_buf_put
000000010000fc6b	movq	0x10(%r14), %rsi
000000010000fc6f	movq	0x40(%r15), %rdx
000000010000fc73	movq	%rbx, %rdi
000000010000fc76	xorl	%ecx, %ecx
000000010000fc78	callq	_fwp_write
000000010000fc7d	cmpq	$0x2, (%r14)
000000010000fc81	jb	0x10000fd0e
000000010000fc87	leaq	0x20(%r14), %r13
000000010000fc8b	movl	$0x1, %r12d
000000010000fc91	jmp	0x10000fcac
000000010000fc93	nopw	%cs:(%rax,%rax)
000000010000fca0	incq	%r12
000000010000fca3	addq	$0x10, %r13
000000010000fca7	cmpq	(%r14), %r12
000000010000fcaa	jae	0x10000fd0e
000000010000fcac	movl	$0x2, %edx
000000010000fcb1	movq	-0x278(%rbp), %rbx
000000010000fcb8	movq	%rbx, %rdi
000000010000fcbb	leaq	0x436a(%rip), %rsi              ## literal pool for: ", "
000000010000fcc2	callq	_buf_put
000000010000fcc7	movq	-0x8(%r13), %rsi
000000010000fccb	movq	0x38(%r15), %rdx
000000010000fccf	movq	%rbx, %rdi
000000010000fcd2	xorl	%ecx, %ecx
000000010000fcd4	callq	_fwp_write
000000010000fcd9	cmpl	$0x12, (%r15)
000000010000fcdd	jne	0x10000fca0
000000010000fcdf	movl	$0x2, %edx
000000010000fce4	movq	-0x278(%rbp), %rbx
000000010000fceb	movq	%rbx, %rdi
000000010000fcee	leaq	0x43f8(%rip), %rsi              ## literal pool for: ": "
000000010000fcf5	callq	_buf_put
000000010000fcfa	movq	(%r13), %rsi
000000010000fcfe	movq	0x40(%r15), %rdx
000000010000fd02	movq	%rbx, %rdi
000000010000fd05	xorl	%ecx, %ecx
000000010000fd07	callq	_fwp_write
000000010000fd0c	jmp	0x10000fca0
000000010000fd0e	movb	$0x7d, -0x270(%rbp)
000000010000fd15	leaq	-0x270(%rbp), %rsi
000000010000fd1c	movl	$0x1, %edx
000000010000fd21	movq	-0x278(%rbp), %rdi
000000010000fd28	jmp	0x100010e76
000000010000fd2d	movq	0x8(%r15), %rbx
000000010000fd31	testq	%rbx, %rbx
000000010000fd34	je	0x100010728
000000010000fd3a	leaq	0x4314(%rip), %rsi              ## literal pool for: "Duration"
000000010000fd41	movq	%rbx, %rdi
000000010000fd44	callq	0x100012d20                     ## symbol stub for: _strcmp
000000010000fd49	testl	%eax, %eax
000000010000fd4b	je	0x1000109d3
000000010000fd51	movq	%r15, -0x280(%rbp)
000000010000fd58	addq	$0x10, %r15
000000010000fd5c	movq	%rbx, %rdi
000000010000fd5f	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000fd64	movq	%r13, %rdi
000000010000fd67	movq	%rbx, %rsi
000000010000fd6a	movq	%rax, %rdx
000000010000fd6d	callq	_buf_put
000000010000fd72	movb	$0x20, -0x270(%rbp)
000000010000fd79	leaq	-0x270(%rbp), %rsi
000000010000fd80	movl	$0x1, %edx
000000010000fd85	movq	%r13, %rdi
000000010000fd88	callq	_buf_put
000000010000fd8d	xorl	%r12d, %r12d
000000010000fd90	jmp	0x100010749
000000010000fd95	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000fd9c	ja	0x100010564
000000010000fda2	movl	%r14d, %eax
000000010000fda5	jmp	0x100010567
000000010000fdaa	movq	%r14, %xmm0
000000010000fdaf	movq	%xmm0, -0x278(%rbp)
000000010000fdb7	ucomisd	%xmm0, %xmm0
000000010000fdbb	jp	0x100010fdd
000000010000fdc1	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000fdcb	andq	%r14, %rax
000000010000fdce	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
000000010000fdd8	cmpq	%rcx, %rax
000000010000fddb	je	0x1000106e8
000000010000fde1	movl	$0x1, %ebx
000000010000fde6	leaq	-0x270(%rbp), %r14
000000010000fded	nopl	(%rax)
000000010000fdf0	movq	%r14, %rdi
000000010000fdf3	movsd	-0x278(%rbp), %xmm0
000000010000fdfb	movl	%ebx, %esi
000000010000fdfd	callq	_fwp_format_g
000000010000fe02	movq	%r14, %rdi
000000010000fe05	xorl	%esi, %esi
000000010000fe07	callq	0x100012d38                     ## symbol stub for: _strtod
000000010000fe0c	ucomisd	-0x278(%rbp), %xmm0
000000010000fe14	jne	0x10000fe1c
000000010000fe16	jnp	0x100010479
000000010000fe1c	incl	%ebx
000000010000fe1e	cmpl	$0x12, %ebx
000000010000fe21	jne	0x10000fdf0
000000010000fe23	leaq	-0x270(%rbp), %rbx
000000010000fe2a	movq	%rbx, %rdi
000000010000fe2d	movsd	-0x278(%rbp), %xmm0
000000010000fe35	movl	$0x11, %esi
000000010000fe3a	callq	_fwp_format_g
000000010000fe3f	movq	%rbx, %rdi
000000010000fe42	jmp	0x100010480
000000010000fe47	movb	$0x3c, -0x270(%rbp)
000000010000fe4e	leaq	-0x270(%rbp), %rsi
000000010000fe55	movl	$0x1, %edx
000000010000fe5a	movq	%r13, %rdi
000000010000fe5d	callq	_buf_put
000000010000fe62	movq	0x8(%r15), %rbx
000000010000fe66	movq	%rbx, %rdi
000000010000fe69	callq	0x100012d26                     ## symbol stub for: _strlen
000000010000fe6e	movq	%r13, %rdi
000000010000fe71	movq	%rbx, %rsi
000000010000fe74	jmp	0x100010550
000000010000fe79	movq	0x51b0(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fe80	movq	(%rax), %rax
000000010000fe83	cmpq	-0x30(%rbp), %rax
000000010000fe87	jne	0x100010fd8
000000010000fe8d	leaq	0x422e(%rip), %rsi              ## literal pool for: "<opaque>"
000000010000fe94	movl	$0x8, %edx
000000010000fe99	movq	%r13, %rdi
000000010000fe9c	jmp	0x100010c26
000000010000fea1	leaq	0x8(%r14), %rsi
000000010000fea5	movq	(%r14), %rdx
000000010000fea8	movq	0x5181(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000feaf	movq	(%rax), %rax
000000010000feb2	testl	%ecx, %ecx
000000010000feb4	je	0x100010886
000000010000feba	cmpq	-0x30(%rbp), %rax
000000010000febe	jne	0x100010fd8
000000010000fec4	movq	%r13, %rdi
000000010000fec7	jmp	0x100010c26
000000010000fecc	movq	(%r14), %r9
000000010000fecf	movq	0x8(%r14), %r8
000000010000fed3	movq	%r9, %rax
000000010000fed6	orq	%r8, %rax
000000010000fed9	je	0x1000108a9
000000010000fedf	xorl	%edi, %edi
000000010000fee1	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000feeb	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000fef5	movq	%r8, %rbx
000000010000fef8	nopl	(%rax,%rax)
000000010000ff00	movq	%r8, %rcx
000000010000ff03	shldq	$0x3f, %r9, %rcx
000000010000ff08	shrq	%rbx
000000010000ff0b	movq	%rcx, %rsi
000000010000ff0e	addq	%rbx, %rsi
000000010000ff11	adcq	$0x0, %rsi
000000010000ff15	movq	%rsi, %rax
000000010000ff18	mulq	%r10
000000010000ff1b	shrq	$0x2, %rdx
000000010000ff1f	leaq	(%rdx,%rdx,4), %rax
000000010000ff23	subq	%rax, %rsi
000000010000ff26	subq	%rsi, %rcx
000000010000ff29	sbbq	$0x0, %rbx
000000010000ff2d	movq	%rcx, %rsi
000000010000ff30	imulq	%r11, %rsi
000000010000ff34	movq	%rcx, %rax
000000010000ff37	mulq	%r10
000000010000ff3a	addq	%rsi, %rdx
000000010000ff3d	imulq	%r10, %rbx
000000010000ff41	addq	%rdx, %rbx
000000010000ff44	movq	%rax, %rcx
000000010000ff47	addq	%rax, %rcx
000000010000ff4a	leaq	(%rcx,%rcx,4), %rcx
000000010000ff4e	movl	%r9d, %edx
000000010000ff51	subl	%ecx, %edx
000000010000ff53	orb	$0x30, %dl
000000010000ff56	movb	%dl, -0x70(%rbp,%rdi)
000000010000ff5a	incq	%rdi
000000010000ff5d	cmpq	$0xa, %r9
000000010000ff61	sbbq	$0x0, %r8
000000010000ff65	movq	%rax, %r9
000000010000ff68	movq	%rbx, %r8
000000010000ff6b	jae	0x10000ff00
000000010000ff6d	testl	%edi, %edi
000000010000ff6f	jg	0x1000108b2
000000010000ff75	jmp	0x100010025
000000010000ff7a	movq	(%r14), %r9
000000010000ff7d	movq	0x8(%r14), %r10
000000010000ff81	testq	%r10, %r10
000000010000ff84	js	0x1000108d4
000000010000ff8a	movq	%r9, %rax
000000010000ff8d	orq	%r10, %rax
000000010000ff90	je	0x1000109f2
000000010000ff96	xorl	%edi, %edi
000000010000ff98	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
000000010000ffa2	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000ffac	movq	%r10, %rbx
000000010000ffaf	nop
000000010000ffb0	movq	%r10, %rcx
000000010000ffb3	shldq	$0x3f, %r9, %rcx
000000010000ffb8	shrq	%rbx
000000010000ffbb	movq	%rcx, %rsi
000000010000ffbe	addq	%rbx, %rsi
000000010000ffc1	adcq	$0x0, %rsi
000000010000ffc5	movq	%rsi, %rax
000000010000ffc8	mulq	%r8
000000010000ffcb	shrq	$0x2, %rdx
000000010000ffcf	leaq	(%rdx,%rdx,4), %rax
000000010000ffd3	subq	%rax, %rsi
000000010000ffd6	subq	%rsi, %rcx
000000010000ffd9	sbbq	$0x0, %rbx
000000010000ffdd	movq	%rcx, %rsi
000000010000ffe0	imulq	%r11, %rsi
000000010000ffe4	movq	%rcx, %rax
000000010000ffe7	mulq	%r8
000000010000ffea	addq	%rsi, %rdx
000000010000ffed	imulq	%r8, %rbx
000000010000fff1	addq	%rdx, %rbx
000000010000fff4	movq	%rax, %rcx
000000010000fff7	addq	%rax, %rcx
000000010000fffa	leaq	(%rcx,%rcx,4), %rcx
000000010000fffe	movl	%r9d, %edx
0000000100010001	subl	%ecx, %edx
0000000100010003	orb	$0x30, %dl
0000000100010006	movb	%dl, -0x70(%rbp,%rdi)
000000010001000a	incq	%rdi
000000010001000d	cmpq	$0xa, %r9
0000000100010011	sbbq	$0x0, %r10
0000000100010015	movq	%rax, %r9
0000000100010018	movq	%rbx, %r10
000000010001001b	jae	0x10000ffb0
000000010001001d	testl	%edi, %edi
000000010001001f	jg	0x1000109fb
0000000100010025	xorl	%eax, %eax
0000000100010027	jmp	0x100010e56
000000010001002c	movb	$0x5b, -0x270(%rbp)
0000000100010033	leaq	-0x270(%rbp), %rsi
000000010001003a	movl	$0x1, %edx
000000010001003f	movq	%r13, %rdi
0000000100010042	callq	_buf_put
0000000100010047	testq	%r14, %r14
000000010001004a	je	0x100010d44
0000000100010050	movq	0x38(%r15), %rdx
0000000100010054	movq	0x8(%r14), %rsi
0000000100010058	movq	%r13, %rdi
000000010001005b	xorl	%ecx, %ecx
000000010001005d	callq	_fwp_write
0000000100010062	movq	0x10(%r14), %r14
0000000100010066	testq	%r14, %r14
0000000100010069	je	0x100010d44
000000010001006f	leaq	0x3fb6(%rip), %rbx              ## literal pool for: ", "
0000000100010076	nopw	%cs:(%rax,%rax)
0000000100010080	movl	$0x2, %edx
0000000100010085	movq	%r13, %rdi
0000000100010088	movq	%rbx, %rsi
000000010001008b	callq	_buf_put
0000000100010090	movq	0x8(%r14), %rsi
0000000100010094	movq	0x38(%r15), %rdx
0000000100010098	movq	%r13, %rdi
000000010001009b	xorl	%ecx, %ecx
000000010001009d	callq	_fwp_write
00000001000100a2	movq	0x10(%r14), %r14
00000001000100a6	testq	%r14, %r14
00000001000100a9	jne	0x100010080
00000001000100ab	jmp	0x100010d44
00000001000100b0	movslq	0x48(%r15), %rbx
00000001000100b4	movl	%ebx, %r12d
00000001000100b7	leaq	0x3(%rbx), %rsi
00000001000100bb	cmpq	$0x4000, %rsi                   ## imm = 0x4000
00000001000100c2	ja	0x1000109be
00000001000100c8	leaq	0x12(%rbx), %rax
00000001000100cc	shrq	$0x4, %rax
00000001000100d0	leaq	_fwp_gc(%rip), %rcx
00000001000100d7	movzbl	0xbe8(%rax,%rcx), %edx
00000001000100df	movl	0xb48(%rcx,%rdx,4), %eax
00000001000100e6	subq	%rax, _fwp_gc(%rip)
00000001000100ed	js	0x1000109be
00000001000100f3	leaq	(%rdx,%rdx,2), %rdx
00000001000100f7	leaq	(%rcx,%rdx,8), %rcx
00000001000100fb	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100010102	movq	(%rcx), %r15
0000000100010105	testq	%r15, %r15
0000000100010108	je	0x1000109aa
000000010001010e	movq	(%r15), %rax
0000000100010111	notq	%rax
0000000100010114	movq	%rax, (%rcx)
0000000100010117	jmp	0x100010b42
000000010001011c	cmpq	$-0x1, %r14
0000000100010120	leaq	0x3f19(%rip), %rax              ## literal pool for: "-1"
0000000100010127	leaq	0x3375(%rip), %rcx              ## literal pool for: "0"
000000010001012e	cmoveq	%rax, %rcx
0000000100010132	cmpq	$0x1, %r14
0000000100010136	leaq	0x3f00(%rip), %rbx              ## literal pool for: "+1"
000000010001013d	cmovneq	%rcx, %rbx
0000000100010141	movq	%rbx, %rdi
0000000100010144	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100010149	movq	0x4ee0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100010150	movq	(%rcx), %rcx
0000000100010153	cmpq	-0x30(%rbp), %rcx
0000000100010157	jne	0x100010fd8
000000010001015d	movq	%r13, %rdi
0000000100010160	movq	%rbx, %rsi
0000000100010163	jmp	0x100010c23
0000000100010168	movq	%r15, %r12
000000010001016b	leaq	0x3f6a(%rip), %rsi              ## literal pool for: "array["
0000000100010172	movl	$0x6, %edx
0000000100010177	movq	%r13, %rdi
000000010001017a	callq	_buf_put
000000010001017f	movq	(%r14), %rsi
0000000100010182	leaq	(,%rsi,2), %rax
000000010001018a	testq	%rax, %rax
000000010001018d	je	0x100010d44
0000000100010193	movq	0x38(%r12), %rdx
0000000100010198	movl	$0x8, %eax
000000010001019d	testq	%rdx, %rdx
00000001000101a0	je	0x100010a1d
00000001000101a6	movl	(%rdx), %ecx
00000001000101a8	cmpq	$0xa, %rcx
00000001000101ac	movq	-0x278(%rbp), %r13
00000001000101b3	ja	0x100010a24
00000001000101b9	leaq	0x2f98(%rip), %rax
00000001000101c0	movq	(%rax,%rcx,8), %rax
00000001000101c4	jmp	0x100010a24
00000001000101c9	leaq	0x3f02(%rip), %rsi              ## literal pool for: "bytes["
00000001000101d0	movl	$0x6, %edx
00000001000101d5	movq	%r13, %rdi
00000001000101d8	callq	_buf_put
00000001000101dd	cmpq	$0x0, (%r14)
00000001000101e1	movq	%r13, %rbx
00000001000101e4	je	0x100010291
00000001000101ea	movzbl	0x8(%r14), %ecx
00000001000101ef	leaq	0x3ee3(%rip), %rdx              ## literal pool for: "%u"
00000001000101f6	leaq	-0x270(%rbp), %r15
00000001000101fd	movl	$0x200, %esi                    ## imm = 0x200
0000000100010202	movq	%r15, %rdi
0000000100010205	xorl	%eax, %eax
0000000100010207	callq	0x100012d0e                     ## symbol stub for: _snprintf
000000010001020c	movq	%r15, %rdi
000000010001020f	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100010214	movq	%rbx, %rdi
0000000100010217	movq	%r15, %rsi
000000010001021a	movq	%rax, %rdx
000000010001021d	callq	_buf_put
0000000100010222	cmpq	$0x2, (%r14)
0000000100010226	jb	0x100010291
0000000100010228	movl	$0x9, %r13d
000000010001022e	leaq	0x3ea4(%rip), %r15              ## literal pool for: "%u"
0000000100010235	leaq	-0x270(%rbp), %r12
000000010001023c	nopl	(%rax)
0000000100010240	movl	$0x2, %edx
0000000100010245	movq	%rbx, %rdi
0000000100010248	leaq	0x3ddd(%rip), %rsi              ## literal pool for: ", "
000000010001024f	callq	_buf_put
0000000100010254	movzbl	(%r14,%r13), %ecx
0000000100010259	movl	$0x200, %esi                    ## imm = 0x200
000000010001025e	movq	%r12, %rdi
0000000100010261	movq	%r15, %rdx
0000000100010264	xorl	%eax, %eax
0000000100010266	callq	0x100012d0e                     ## symbol stub for: _snprintf
000000010001026b	movq	%r12, %rdi
000000010001026e	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100010273	movq	%rbx, %rdi
0000000100010276	movq	%r12, %rsi
0000000100010279	movq	%rax, %rdx
000000010001027c	callq	_buf_put
0000000100010281	leaq	0x1(%r13), %rax
0000000100010285	addq	$-0x7, %r13
0000000100010289	cmpq	(%r14), %r13
000000010001028c	movq	%rax, %r13
000000010001028f	jb	0x100010240
0000000100010291	movb	$0x5d, -0x70(%rbp)
0000000100010295	leaq	-0x70(%rbp), %rsi
0000000100010299	movl	$0x1, %edx
000000010001029e	movq	%rbx, %rdi
00000001000102a1	jmp	0x100010e76
00000001000102a6	movd	%r14d, %xmm1
00000001000102ab	ucomiss	%xmm1, %xmm1
00000001000102ae	jp	0x100010fdd
00000001000102b4	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
00000001000102bb	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
00000001000102c2	je	0x1000106fa
00000001000102c8	cvtss2sd	%xmm1, %xmm0
00000001000102cc	leaq	-0x270(%rbp), %rbx
00000001000102d3	movq	%rbx, %rdi
00000001000102d6	movsd	%xmm0, -0x280(%rbp)
00000001000102de	movl	$0x1, %esi
00000001000102e3	movss	%xmm1, -0x278(%rbp)
00000001000102eb	callq	_fwp_format_g
00000001000102f0	movq	%rbx, %rdi
00000001000102f3	xorl	%esi, %esi
00000001000102f5	callq	0x100012d3e                     ## symbol stub for: _strtof
00000001000102fa	ucomiss	-0x278(%rbp), %xmm0
0000000100010301	jne	0x100010309
0000000100010303	jnp	0x100010479
0000000100010309	movq	%rbx, %rdi
000000010001030c	movsd	-0x280(%rbp), %xmm0
0000000100010314	movl	$0x2, %esi
0000000100010319	callq	_fwp_format_g
000000010001031e	movq	%rbx, %rdi
0000000100010321	xorl	%esi, %esi
0000000100010323	callq	0x100012d3e                     ## symbol stub for: _strtof
0000000100010328	ucomiss	-0x278(%rbp), %xmm0
000000010001032f	jne	0x100010337
0000000100010331	jnp	0x100010479
0000000100010337	movq	%rbx, %rdi
000000010001033a	movsd	-0x280(%rbp), %xmm0
0000000100010342	movl	$0x3, %esi
0000000100010347	callq	_fwp_format_g
000000010001034c	movq	%rbx, %rdi
000000010001034f	xorl	%esi, %esi
0000000100010351	callq	0x100012d3e                     ## symbol stub for: _strtof
0000000100010356	ucomiss	-0x278(%rbp), %xmm0
000000010001035d	jne	0x100010365
000000010001035f	jnp	0x100010479
0000000100010365	movq	%rbx, %rdi
0000000100010368	movsd	-0x280(%rbp), %xmm0
0000000100010370	movl	$0x4, %esi
0000000100010375	callq	_fwp_format_g
000000010001037a	movq	%rbx, %rdi
000000010001037d	xorl	%esi, %esi
000000010001037f	callq	0x100012d3e                     ## symbol stub for: _strtof
0000000100010384	ucomiss	-0x278(%rbp), %xmm0
000000010001038b	jne	0x100010393
000000010001038d	jnp	0x100010479
0000000100010393	movq	%rbx, %rdi
0000000100010396	movsd	-0x280(%rbp), %xmm0
000000010001039e	movl	$0x5, %esi
00000001000103a3	callq	_fwp_format_g
00000001000103a8	movq	%rbx, %rdi
00000001000103ab	xorl	%esi, %esi
00000001000103ad	callq	0x100012d3e                     ## symbol stub for: _strtof
00000001000103b2	ucomiss	-0x278(%rbp), %xmm0
00000001000103b9	jne	0x1000103c1
00000001000103bb	jnp	0x100010479
00000001000103c1	movq	%rbx, %rdi
00000001000103c4	movsd	-0x280(%rbp), %xmm0
00000001000103cc	movl	$0x6, %esi
00000001000103d1	callq	_fwp_format_g
00000001000103d6	movq	%rbx, %rdi
00000001000103d9	xorl	%esi, %esi
00000001000103db	callq	0x100012d3e                     ## symbol stub for: _strtof
00000001000103e0	ucomiss	-0x278(%rbp), %xmm0
00000001000103e7	jne	0x1000103ef
00000001000103e9	jnp	0x100010479
00000001000103ef	movq	%rbx, %rdi
00000001000103f2	movsd	-0x280(%rbp), %xmm0
00000001000103fa	movl	$0x7, %esi
00000001000103ff	callq	_fwp_format_g
0000000100010404	movq	%rbx, %rdi
0000000100010407	xorl	%esi, %esi
0000000100010409	callq	0x100012d3e                     ## symbol stub for: _strtof
000000010001040e	ucomiss	-0x278(%rbp), %xmm0
0000000100010415	jne	0x100010419
0000000100010417	jnp	0x100010479
0000000100010419	movq	%rbx, %rdi
000000010001041c	movsd	-0x280(%rbp), %xmm0
0000000100010424	movl	$0x8, %esi
0000000100010429	callq	_fwp_format_g
000000010001042e	movq	%rbx, %rdi
0000000100010431	xorl	%esi, %esi
0000000100010433	callq	0x100012d3e                     ## symbol stub for: _strtof
0000000100010438	movss	-0x278(%rbp), %xmm1
0000000100010440	ucomiss	%xmm1, %xmm0
0000000100010443	jne	0x100010447
0000000100010445	jnp	0x100010479
0000000100010447	movq	%rbx, %rdi
000000010001044a	movsd	-0x280(%rbp), %xmm0
0000000100010452	movl	$0x9, %esi
0000000100010457	callq	_fwp_format_g
000000010001045c	movq	%rbx, %rdi
000000010001045f	xorl	%esi, %esi
0000000100010461	callq	0x100012d3e                     ## symbol stub for: _strtof
0000000100010466	ucomiss	-0x278(%rbp), %xmm0
000000010001046d	jne	0x100010fc3
0000000100010473	jp	0x100010fc3
0000000100010479	leaq	-0x270(%rbp), %rdi
0000000100010480	movl	$0x2e, %esi
0000000100010485	callq	0x100012d1a                     ## symbol stub for: _strchr
000000010001048a	testq	%rax, %rax
000000010001048d	jne	0x100010e5e
0000000100010493	leaq	-0x270(%rbp), %rdi
000000010001049a	movl	$0x65, %esi
000000010001049f	callq	0x100012d1a                     ## symbol stub for: _strchr
00000001000104a4	testq	%rax, %rax
00000001000104a7	jne	0x100010e5e
00000001000104ad	leaq	0x3bc7(%rip), %rsi              ## literal pool for: "inf"
00000001000104b4	leaq	-0x270(%rbp), %rdi
00000001000104bb	callq	0x100012d32                     ## symbol stub for: _strstr
00000001000104c0	testq	%rax, %rax
00000001000104c3	jne	0x100010e5e
00000001000104c9	leaq	0x3bb4(%rip), %rsi              ## literal pool for: "NaN"
00000001000104d0	leaq	-0x270(%rbp), %rdi
00000001000104d7	callq	0x100012d32                     ## symbol stub for: _strstr
00000001000104dc	testq	%rax, %rax
00000001000104df	jne	0x100010e5e
00000001000104e5	leaq	0x3c1f(%rip), %rsi              ## literal pool for: ".0"
00000001000104ec	leaq	-0x270(%rbp), %rdi
00000001000104f3	movl	$0x200, %edx                    ## imm = 0x200
00000001000104f8	callq	0x100012c06                     ## symbol stub for: ___strcat_chk
00000001000104fd	jmp	0x100010e5e
0000000100010502	movq	0x4b27(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010509	movq	(%rax), %rax
000000010001050c	cmpq	-0x30(%rbp), %rax
0000000100010510	jne	0x100010fd8
0000000100010516	leaq	0x3b9a(%rip), %rsi              ## literal pool for: "<function>"
000000010001051d	movl	$0xa, %edx
0000000100010522	movq	%r13, %rdi
0000000100010525	jmp	0x100010c26
000000010001052a	leaq	0x3b9a(%rip), %rsi              ## literal pool for: "<file "
0000000100010531	movl	$0x6, %edx
0000000100010536	movq	%r13, %rdi
0000000100010539	callq	_buf_put
000000010001053e	addq	$0x10, %r14
0000000100010542	movq	%r14, %rdi
0000000100010545	callq	0x100012d26                     ## symbol stub for: _strlen
000000010001054a	movq	%r13, %rdi
000000010001054d	movq	%r14, %rsi
0000000100010550	movq	%rax, %rdx
0000000100010553	callq	_buf_put
0000000100010558	movb	$0x3e, -0x270(%rbp)
000000010001055f	jmp	0x100010d4b
0000000100010564	movl	(%r14), %eax
0000000100010567	movq	0x18(%r15), %rcx
000000010001056b	movl	%eax, %r12d
000000010001056e	movq	(%rcx,%r12,8), %rbx
0000000100010572	movq	%rbx, %rdi
0000000100010575	callq	0x100012d26                     ## symbol stub for: _strlen
000000010001057a	movq	%r13, %rdi
000000010001057d	movq	%rbx, %rsi
0000000100010580	movq	%rax, %rdx
0000000100010583	callq	_buf_put
0000000100010588	movq	0x28(%r15), %rax
000000010001058c	cmpl	$0x0, (%rax,%r12,4)
0000000100010591	jle	0x100010e7b
0000000100010597	movq	%r12, %rcx
000000010001059a	xorl	%r12d, %r12d
000000010001059d	movq	%r15, -0x280(%rbp)
00000001000105a4	movq	%rcx, -0x290(%rbp)
00000001000105ab	movq	%r14, -0x288(%rbp)
00000001000105b2	jmp	0x1000105f9
00000001000105b4	nopw	%cs:(%rax,%rax)
00000001000105c0	movq	-0x278(%rbp), %r13
00000001000105c7	movq	%r13, %rdi
00000001000105ca	movq	%r15, %rsi
00000001000105cd	movq	%rbx, %rdx
00000001000105d0	xorl	%ecx, %ecx
00000001000105d2	callq	_fwp_write
00000001000105d7	incq	%r12
00000001000105da	movq	-0x280(%rbp), %r15
00000001000105e1	movq	0x28(%r15), %rax
00000001000105e5	movq	-0x290(%rbp), %rcx
00000001000105ec	movslq	(%rax,%rcx,4), %rax
00000001000105f0	cmpq	%rax, %r12
00000001000105f3	jge	0x100010e7b
00000001000105f9	movq	%r15, %rax
00000001000105fc	movq	0x8(%r14,%r12,8), %r15
0000000100010601	movq	0x30(%rax), %rax
0000000100010605	movq	(%rax,%rcx,8), %rax
0000000100010609	movq	(%rax,%r12,8), %rbx
000000010001060d	movb	$0x20, -0x270(%rbp)
0000000100010614	movl	$0x1, %edx
0000000100010619	movq	%r13, %rdi
000000010001061c	leaq	-0x270(%rbp), %rsi
0000000100010623	callq	_buf_put
0000000100010628	movl	(%rbx), %eax
000000010001062a	cmpq	$0x10, %rax
000000010001062e	ja	0x1000105c0
0000000100010630	leaq	0xa1d(%rip), %rcx
0000000100010637	movslq	(%rcx,%rax,4), %rax
000000010001063b	addq	%rcx, %rax
000000010001063e	jmpq	*%rax
0000000100010640	movq	%r15, %rcx
0000000100010643	shrq	$0x3f, %rcx
0000000100010647	testl	%ecx, %ecx
0000000100010649	je	0x1000105c0
000000010001064f	movb	$0x28, -0x270(%rbp)
0000000100010656	movl	$0x1, %edx
000000010001065b	movq	-0x278(%rbp), %r13
0000000100010662	movq	%r13, %rdi
0000000100010665	leaq	-0x270(%rbp), %r14
000000010001066c	movq	%r14, %rsi
000000010001066f	callq	_buf_put
0000000100010674	movq	%r13, %rdi
0000000100010677	movq	%r15, %rsi
000000010001067a	movq	%rbx, %rdx
000000010001067d	xorl	%ecx, %ecx
000000010001067f	callq	_fwp_write
0000000100010684	movb	$0x29, -0x270(%rbp)
000000010001068b	movl	$0x1, %edx
0000000100010690	movq	%r13, %rdi
0000000100010693	movq	%r14, %rsi
0000000100010696	movq	-0x288(%rbp), %r14
000000010001069d	callq	_buf_put
00000001000106a2	jmp	0x1000105d7
00000001000106a7	xorl	%ecx, %ecx
00000001000106a9	cmpq	$0x1000, %r15                   ## imm = 0x1000
00000001000106b0	setae	%cl
00000001000106b3	jmp	0x100010647
00000001000106b5	movq	0x8(%r15), %rcx
00000001000106b9	jmp	0x100010643
00000001000106bb	movl	%r15d, %ecx
00000001000106be	shrl	$0x1f, %ecx
00000001000106c1	jmp	0x100010647
00000001000106c3	movq	0x8(%rbx), %rdi
00000001000106c7	testq	%rdi, %rdi
00000001000106ca	je	0x1000105c0
00000001000106d0	leaq	0x397e(%rip), %rsi              ## literal pool for: "Duration"
00000001000106d7	callq	0x100012d20                     ## symbol stub for: _strcmp
00000001000106dc	xorl	%ecx, %ecx
00000001000106de	testl	%eax, %eax
00000001000106e0	setne	%cl
00000001000106e3	jmp	0x100010647
00000001000106e8	xorpd	%xmm0, %xmm0
00000001000106ec	movsd	-0x278(%rbp), %xmm1
00000001000106f4	ucomisd	%xmm0, %xmm1
00000001000106f8	jmp	0x100010700
00000001000106fa	xorps	%xmm0, %xmm0
00000001000106fd	ucomiss	%xmm0, %xmm1
0000000100010700	leaq	0x3974(%rip), %rax              ## literal pool for: "inf"
0000000100010707	leaq	0x3971(%rip), %rsi              ## literal pool for: "-inf"
000000010001070e	cmovaq	%rax, %rsi
0000000100010712	leaq	-0x270(%rbp), %rdi
0000000100010719	movl	$0x200, %edx                    ## imm = 0x200
000000010001071e	callq	0x100012c0c                     ## symbol stub for: ___strcpy_chk
0000000100010723	jmp	0x100010e5e
0000000100010728	cmpl	$0x0, 0x10(%r15)
000000010001072d	je	0x100010d5f
0000000100010733	movq	%r15, %rax
0000000100010736	addq	$0x10, %r15
000000010001073a	movq	%rax, -0x280(%rbp)
0000000100010741	cmpl	$0x0, 0x48(%rax)
0000000100010745	setne	%r12b
0000000100010749	testb	%r12b, %r12b
000000010001074c	movl	$0x28, %eax
0000000100010751	movl	$0x7b, %ecx
0000000100010756	cmovnel	%eax, %ecx
0000000100010759	movb	%cl, -0x270(%rbp)
000000010001075f	leaq	-0x270(%rbp), %rsi
0000000100010766	movl	$0x1, %edx
000000010001076b	movq	%r13, %rdi
000000010001076e	callq	_buf_put
0000000100010773	cmpl	$0x0, (%r15)
0000000100010777	movq	-0x280(%rbp), %r15
000000010001077e	jle	0x10001086b
0000000100010784	testb	%r12b, %r12b
0000000100010787	jne	0x1000107ba
0000000100010789	movq	0x18(%r15), %rax
000000010001078d	movq	(%rax), %rbx
0000000100010790	movq	%rbx, %rdi
0000000100010793	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100010798	movq	%r13, %rdi
000000010001079b	movq	%rbx, %rsi
000000010001079e	movq	%rax, %rdx
00000001000107a1	callq	_buf_put
00000001000107a6	leaq	0x3946(%rip), %rsi              ## literal pool for: " = "
00000001000107ad	movl	$0x3, %edx
00000001000107b2	movq	%r13, %rdi
00000001000107b5	callq	_buf_put
00000001000107ba	movq	0x8(%r14), %rsi
00000001000107be	movq	0x20(%r15), %rax
00000001000107c2	movq	(%rax), %rdx
00000001000107c5	movq	%r13, %rdi
00000001000107c8	xorl	%ecx, %ecx
00000001000107ca	callq	_fwp_write
00000001000107cf	cmpl	$0x2, 0x10(%r15)
00000001000107d4	jl	0x10001086b
00000001000107da	movl	$0x1, %ebx
00000001000107df	jmp	0x100010813
00000001000107e1	nopw	%cs:(%rax,%rax)
00000001000107f0	movq	0x8(%r14,%rbx,8), %rsi
00000001000107f5	movq	0x20(%r15), %rax
00000001000107f9	movq	(%rax,%rbx,8), %rdx
00000001000107fd	movq	%r13, %rdi
0000000100010800	xorl	%ecx, %ecx
0000000100010802	callq	_fwp_write
0000000100010807	incq	%rbx
000000010001080a	movslq	0x10(%r15), %rax
000000010001080e	cmpq	%rax, %rbx
0000000100010811	jge	0x10001086b
0000000100010813	movl	$0x2, %edx
0000000100010818	movq	%r13, %rdi
000000010001081b	leaq	0x380a(%rip), %rsi              ## literal pool for: ", "
0000000100010822	callq	_buf_put
0000000100010827	testb	%r12b, %r12b
000000010001082a	jne	0x1000107f0
000000010001082c	movq	0x18(%r15), %rax
0000000100010830	movq	(%rax,%rbx,8), %r13
0000000100010834	movq	%r13, %rdi
0000000100010837	callq	0x100012d26                     ## symbol stub for: _strlen
000000010001083c	movq	-0x278(%rbp), %rdi
0000000100010843	movq	%r13, %rsi
0000000100010846	movq	-0x278(%rbp), %r13
000000010001084d	movq	%rax, %rdx
0000000100010850	callq	_buf_put
0000000100010855	movl	$0x3, %edx
000000010001085a	movq	%r13, %rdi
000000010001085d	leaq	0x388f(%rip), %rsi              ## literal pool for: " = "
0000000100010864	callq	_buf_put
0000000100010869	jmp	0x1000107f0
000000010001086b	testb	%r12b, %r12b
000000010001086e	movl	$0x29, %eax
0000000100010873	movl	$0x7d, %ecx
0000000100010878	cmovnel	%eax, %ecx
000000010001087b	movb	%cl, -0x270(%rbp)
0000000100010881	jmp	0x100010d4b
0000000100010886	cmpq	-0x30(%rbp), %rax
000000010001088a	jne	0x100010fd8
0000000100010890	movq	%r13, %rdi
0000000100010893	addq	$0x268, %rsp                    ## imm = 0x268
000000010001089a	popq	%rbx
000000010001089b	popq	%r12
000000010001089d	popq	%r13
000000010001089f	popq	%r14
00000001000108a1	popq	%r15
00000001000108a3	popq	%rbp
00000001000108a4	jmp	_fwp_escape
00000001000108a9	movb	$0x30, -0x70(%rbp)
00000001000108ad	movl	$0x1, %edi
00000001000108b2	movl	%edi, %eax
00000001000108b4	cmpq	$0x8, %rax
00000001000108b8	jae	0x1000108c4
00000001000108ba	xorl	%ecx, %ecx
00000001000108bc	movq	%rax, %rdx
00000001000108bf	jmp	0x100010b15
00000001000108c4	cmpl	$0x20, %eax
00000001000108c7	jae	0x100010a61
00000001000108cd	xorl	%ecx, %ecx
00000001000108cf	jmp	0x100010abf
00000001000108d4	movb	$0x2d, -0x270(%rbp)
00000001000108db	xorl	%r8d, %r8d
00000001000108de	negq	%r9
00000001000108e1	movl	$0x0, %r11d
00000001000108e7	sbbq	%r10, %r11
00000001000108ea	movl	$0x1, %r15d
00000001000108f0	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000108fa	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010904	movq	%r11, %r14
0000000100010907	nopw	(%rax,%rax)
0000000100010910	movq	%r11, %rcx
0000000100010913	shldq	$0x3f, %r9, %rcx
0000000100010918	shrq	%r14
000000010001091b	movq	%rcx, %rsi
000000010001091e	addq	%r14, %rsi
0000000100010921	adcq	$0x0, %rsi
0000000100010925	movq	%rsi, %rax
0000000100010928	mulq	%r10
000000010001092b	movl	%r15d, %edi
000000010001092e	shrq	$0x2, %rdx
0000000100010932	leaq	(%rdx,%rdx,4), %rax
0000000100010936	subq	%rax, %rsi
0000000100010939	subq	%rsi, %rcx
000000010001093c	sbbq	$0x0, %r14
0000000100010940	movq	%rcx, %rsi
0000000100010943	movq	%rcx, %rax
0000000100010946	mulq	%r10
0000000100010949	imulq	%rbx, %rsi
000000010001094d	addq	%rsi, %rdx
0000000100010950	imulq	%r10, %r14
0000000100010954	addq	%rdx, %r14
0000000100010957	movq	%rax, %rcx
000000010001095a	addq	%rax, %rcx
000000010001095d	leaq	(%rcx,%rcx,4), %rcx
0000000100010961	movl	%r9d, %edx
0000000100010964	subl	%ecx, %edx
0000000100010966	orb	$0x30, %dl
0000000100010969	movb	%dl, -0x70(%rbp,%r8)
000000010001096e	incq	%r8
0000000100010971	leal	0x1(%rdi), %r15d
0000000100010975	cmpq	$0xa, %r9
0000000100010979	sbbq	$0x0, %r11
000000010001097d	movq	%rax, %r9
0000000100010980	movq	%r14, %r11
0000000100010983	jae	0x100010910
0000000100010985	testl	%r8d, %r8d
0000000100010988	jle	0x100010d87
000000010001098e	movl	%r8d, %eax
0000000100010991	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010996	cmpq	$0x8, %rax
000000010001099a	jae	0x100010ea1
00000001000109a0	xorl	%ecx, %ecx
00000001000109a2	movq	%rax, %rdx
00000001000109a5	jmp	0x100010f84
00000001000109aa	movq	0x8(%rcx), %r15
00000001000109ae	movq	0x10(%rcx), %rdx
00000001000109b2	subq	%r15, %rdx
00000001000109b5	cmpq	%rax, %rdx
00000001000109b8	jae	0x100010b3b
00000001000109be	movq	%rsi, %rdi
00000001000109c1	movl	$0x1, %esi
00000001000109c6	callq	_fwp_gc_alloc_slow
00000001000109cb	movq	%rax, %r15
00000001000109ce	jmp	0x100010b4a
00000001000109d3	movq	0x8(%r14), %rsi
00000001000109d7	movq	%rsi, %rdx
00000001000109da	sarq	$0x3f, %rdx
00000001000109de	leaq	-0x270(%rbp), %rbx
00000001000109e5	movq	%rbx, %rdi
00000001000109e8	callq	_fwp_fmt_duration
00000001000109ed	jmp	0x100010e65
00000001000109f2	movb	$0x30, -0x70(%rbp)
00000001000109f6	movl	$0x1, %edi
00000001000109fb	movl	%edi, %eax
00000001000109fd	cmpq	$0x8, %rax
0000000100010a01	jae	0x100010a0d
0000000100010a03	xorl	%ecx, %ecx
0000000100010a05	movq	%rax, %rdx
0000000100010a08	jmp	0x100010e33
0000000100010a0d	cmpl	$0x20, %eax
0000000100010a10	jae	0x100010d96
0000000100010a16	xorl	%ecx, %ecx
0000000100010a18	jmp	0x100010dee
0000000100010a1d	movq	-0x278(%rbp), %r13
0000000100010a24	leaq	0x8(%r14), %rbx
0000000100010a28	movq	%rbx, %rcx
0000000100010a2b	testq	%rsi, %rsi
0000000100010a2e	jns	0x100010a34
0000000100010a30	movq	0x10(%r14), %rcx
0000000100010a34	cmpq	$0x1, %rax
0000000100010a38	je	0x100010c41
0000000100010a3e	cmpq	$0x8, %rax
0000000100010a42	je	0x100010c3c
0000000100010a48	cmpq	$0x2, %rax
0000000100010a4c	jne	0x100010c4d
0000000100010a52	cmpl	$0x1, (%rdx)
0000000100010a55	movzwl	(%rcx), %eax
0000000100010a58	movswq	%ax, %rsi
0000000100010a5c	jmp	0x100010c55
0000000100010a61	movl	%edi, %edx
0000000100010a63	andl	$0x1f, %edx
0000000100010a66	movq	%rax, %rcx
0000000100010a69	subq	%rdx, %rcx
0000000100010a6c	leaq	-0x260(%rbp), %rsi
0000000100010a73	movdqa	0x2405(%rip), %xmm0
0000000100010a7b	movq	%rax, %r8
0000000100010a7e	nop
0000000100010a80	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100010a8a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010a91	pshufb	%xmm0, %xmm2
0000000100010a96	pshufb	%xmm0, %xmm1
0000000100010a9b	movdqa	%xmm2, -0x10(%rsi)
0000000100010aa0	movdqa	%xmm1, (%rsi)
0000000100010aa4	addq	$-0x20, %r8
0000000100010aa8	addq	$0x20, %rsi
0000000100010aac	cmpq	%r8, %rdx
0000000100010aaf	jne	0x100010a80
0000000100010ab1	testq	%rdx, %rdx
0000000100010ab4	je	0x100010e56
0000000100010aba	cmpl	$0x7, %edx
0000000100010abd	jbe	0x100010b15
0000000100010abf	movl	%edi, %edx
0000000100010ac1	andl	$0x7, %edx
0000000100010ac4	movq	%rax, %rsi
0000000100010ac7	subq	%rcx, %rsi
0000000100010aca	leaq	(%rcx,%rbp), %rdi
0000000100010ace	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100010ad5	movq	%rax, %rcx
0000000100010ad8	subq	%rdx, %rcx
0000000100010adb	movq	0x23ad(%rip), %xmm0
0000000100010ae3	nopw	%cs:(%rax,%rax)
0000000100010af0	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010af6	pshufb	%xmm0, %xmm1
0000000100010afb	movq	%xmm1, (%rdi)
0000000100010aff	addq	$-0x8, %rsi
0000000100010b03	addq	$0x8, %rdi
0000000100010b07	cmpq	%rsi, %rdx
0000000100010b0a	jne	0x100010af0
0000000100010b0c	testq	%rdx, %rdx
0000000100010b0f	je	0x100010e56
0000000100010b15	leaq	-0x70(%rbp), %rsi
0000000100010b19	addq	%rsi, %rdx
0000000100010b1c	decq	%rdx
0000000100010b1f	nop
0000000100010b20	movzbl	(%rdx), %esi
0000000100010b23	movb	%sil, -0x270(%rbp,%rcx)
0000000100010b2b	incq	%rcx
0000000100010b2e	decq	%rdx
0000000100010b31	cmpq	%rcx, %rax
0000000100010b34	jne	0x100010b20
0000000100010b36	jmp	0x100010e56
0000000100010b3b	addq	%r15, %rax
0000000100010b3e	movq	%rax, 0x8(%rcx)
0000000100010b42	movq	%r15, %rdi
0000000100010b45	callq	0x100012bee                     ## symbol stub for: ___bzero
0000000100010b4a	movw	$0x7430, (%r15)                 ## imm = 0x7430
0000000100010b50	testl	%r12d, %r12d
0000000100010b53	jle	0x100010bfb
0000000100010b59	movq	%rbx, %rcx
0000000100010b5c	negq	%rcx
0000000100010b5f	leaq	(%r12,%r15), %rsi
0000000100010b63	incq	%rsi
0000000100010b66	xorl	%edi, %edi
0000000100010b68	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
0000000100010b72	jmp	0x100010bac
0000000100010b74	nopw	%cs:(%rax,%rax)
0000000100010b80	movb	$0x30, %r10b
0000000100010b83	movb	%r10b, (%rsi,%rdi)
0000000100010b87	testq	%rdx, %rdx
0000000100010b8a	setne	%dl
0000000100010b8d	testq	%r14, %r14
0000000100010b90	sets	%r10b
0000000100010b94	andb	%dl, %r10b
0000000100010b97	movzbl	%r10b, %edx
0000000100010b9b	subq	%rdx, %rax
0000000100010b9e	addq	%r9, %rax
0000000100010ba1	decq	%rdi
0000000100010ba4	movq	%rax, %r14
0000000100010ba7	cmpq	%rdi, %rcx
0000000100010baa	je	0x100010bfb
0000000100010bac	movq	%r14, %rax
0000000100010baf	imulq	%r8
0000000100010bb2	movq	%rdx, %rax
0000000100010bb5	shrq	$0x3f, %rax
0000000100010bb9	addq	%rdx, %rax
0000000100010bbc	leaq	(%rax,%rax,2), %r9
0000000100010bc0	movq	%r14, %rdx
0000000100010bc3	subq	%r9, %rdx
0000000100010bc6	negq	%r9
0000000100010bc9	addq	%r14, %r9
0000000100010bcc	addq	$0x3, %r9
0000000100010bd0	cmpq	$-0x3, %rdx
0000000100010bd4	cmovbq	%rdx, %r9
0000000100010bd8	testq	%r9, %r9
0000000100010bdb	je	0x100010b80
0000000100010bdd	cmpq	$0x1, %r9
0000000100010be1	jne	0x100010bf0
0000000100010be3	movb	$0x2b, %r10b
0000000100010be6	xorl	%r9d, %r9d
0000000100010be9	jmp	0x100010b83
0000000100010beb	nopl	(%rax,%rax)
0000000100010bf0	movb	$0x2d, %r10b
0000000100010bf3	movl	$0x1, %r9d
0000000100010bf9	jmp	0x100010b83
0000000100010bfb	movb	$0x0, 0x2(%r15,%rbx)
0000000100010c01	movq	%r15, %rdi
0000000100010c04	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100010c09	movq	0x4420(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100010c10	movq	(%rcx), %rcx
0000000100010c13	cmpq	-0x30(%rbp), %rcx
0000000100010c17	jne	0x100010fd8
0000000100010c1d	movq	%r13, %rdi
0000000100010c20	movq	%r15, %rsi
0000000100010c23	movq	%rax, %rdx
0000000100010c26	addq	$0x268, %rsp                    ## imm = 0x268
0000000100010c2d	popq	%rbx
0000000100010c2e	popq	%r12
0000000100010c30	popq	%r13
0000000100010c32	popq	%r14
0000000100010c34	popq	%r15
0000000100010c36	popq	%rbp
0000000100010c37	jmp	_buf_put
0000000100010c3c	movq	(%rcx), %rsi
0000000100010c3f	jmp	0x100010c59
0000000100010c41	cmpl	$0x0, (%rdx)
0000000100010c44	movzbl	(%rcx), %eax
0000000100010c47	movsbq	%al, %rsi
0000000100010c4b	jmp	0x100010c55
0000000100010c4d	cmpl	$0x2, (%rdx)
0000000100010c50	movl	(%rcx), %eax
0000000100010c52	movslq	%eax, %rsi
0000000100010c55	cmovneq	%rax, %rsi
0000000100010c59	movq	%r13, %rdi
0000000100010c5c	xorl	%ecx, %ecx
0000000100010c5e	callq	_fwp_write
0000000100010c63	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100010c6d	decq	%rax
0000000100010c70	testq	%rax, (%r14)
0000000100010c73	je	0x100010d44
0000000100010c79	movl	$0x1, %r15d
0000000100010c7f	jmp	0x100010cbd
0000000100010c81	cmpl	$0x1, (%rdx)
0000000100010c84	movzwl	(%rcx,%rsi), %eax
0000000100010c88	movswq	%ax, %rsi
0000000100010c8c	cmovneq	%rax, %rsi
0000000100010c90	movq	-0x278(%rbp), %r13
0000000100010c97	movq	%r13, %rdi
0000000100010c9a	xorl	%ecx, %ecx
0000000100010c9c	callq	_fwp_write
0000000100010ca1	incq	%r15
0000000100010ca4	movq	(%r14), %rax
0000000100010ca7	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100010cb1	andq	%rcx, %rax
0000000100010cb4	cmpq	%rax, %r15
0000000100010cb7	jae	0x100010d44
0000000100010cbd	movl	$0x2, %edx
0000000100010cc2	movq	%r13, %rdi
0000000100010cc5	leaq	0x3360(%rip), %rsi              ## literal pool for: ", "
0000000100010ccc	callq	_buf_put
0000000100010cd1	movq	0x38(%r12), %rdx
0000000100010cd6	movl	$0x8, %eax
0000000100010cdb	testq	%rdx, %rdx
0000000100010cde	je	0x100010cf3
0000000100010ce0	movl	(%rdx), %ecx
0000000100010ce2	cmpq	$0xa, %rcx
0000000100010ce6	ja	0x100010cf3
0000000100010ce8	leaq	0x2469(%rip), %rax
0000000100010cef	movq	(%rax,%rcx,8), %rax
0000000100010cf3	cmpq	$0x0, (%r14)
0000000100010cf7	movq	%rbx, %rcx
0000000100010cfa	jns	0x100010d00
0000000100010cfc	movq	0x10(%r14), %rcx
0000000100010d00	movq	%rax, %rsi
0000000100010d03	imulq	%r15, %rsi
0000000100010d07	cmpq	$0x1, %rax
0000000100010d0b	je	0x100010d26
0000000100010d0d	cmpq	$0x2, %rax
0000000100010d11	je	0x100010c81
0000000100010d17	cmpq	$0x8, %rax
0000000100010d1b	jne	0x100010d36
0000000100010d1d	movq	(%rcx,%rsi), %rsi
0000000100010d21	jmp	0x100010c90
0000000100010d26	cmpl	$0x0, (%rdx)
0000000100010d29	movzbl	(%rcx,%rsi), %eax
0000000100010d2d	movsbq	%al, %rsi
0000000100010d31	jmp	0x100010c8c
0000000100010d36	cmpl	$0x2, (%rdx)
0000000100010d39	movl	(%rcx,%rsi), %eax
0000000100010d3c	movslq	%eax, %rsi
0000000100010d3f	jmp	0x100010c8c
0000000100010d44	movb	$0x5d, -0x270(%rbp)
0000000100010d4b	leaq	-0x270(%rbp), %rsi
0000000100010d52	movl	$0x1, %edx
0000000100010d57	movq	%r13, %rdi
0000000100010d5a	jmp	0x100010e76
0000000100010d5f	movq	0x42ca(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010d66	movq	(%rax), %rax
0000000100010d69	cmpq	-0x30(%rbp), %rax
0000000100010d6d	jne	0x100010fd8
0000000100010d73	leaq	0x3376(%rip), %rsi              ## literal pool for: "()"
0000000100010d7a	movl	$0x2, %edx
0000000100010d7f	movq	%r13, %rdi
0000000100010d82	jmp	0x100010c26
0000000100010d87	xorl	%eax, %eax
0000000100010d89	movb	$0x0, -0x26f(%rbp,%rax)
0000000100010d91	jmp	0x100010e5e
0000000100010d96	movl	%edi, %edx
0000000100010d98	andl	$0x1f, %edx
0000000100010d9b	movq	%rax, %rcx
0000000100010d9e	subq	%rdx, %rcx
0000000100010da1	leaq	-0x260(%rbp), %rsi
0000000100010da8	movdqa	0x20d0(%rip), %xmm0
0000000100010db0	movq	%rax, %r8
0000000100010db3	movdqu	-0x90(%rbp,%r8), %xmm1
0000000100010dbd	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010dc4	pshufb	%xmm0, %xmm2
0000000100010dc9	pshufb	%xmm0, %xmm1
0000000100010dce	movdqa	%xmm2, -0x10(%rsi)
0000000100010dd3	movdqa	%xmm1, (%rsi)
0000000100010dd7	addq	$-0x20, %r8
0000000100010ddb	addq	$0x20, %rsi
0000000100010ddf	cmpq	%r8, %rdx
0000000100010de2	jne	0x100010db3
0000000100010de4	testq	%rdx, %rdx
0000000100010de7	je	0x100010e56
0000000100010de9	cmpl	$0x7, %edx
0000000100010dec	jbe	0x100010e33
0000000100010dee	movl	%edi, %edx
0000000100010df0	andl	$0x7, %edx
0000000100010df3	movq	%rax, %rsi
0000000100010df6	subq	%rcx, %rsi
0000000100010df9	leaq	(%rcx,%rbp), %rdi
0000000100010dfd	addq	$-0x270, %rdi                   ## imm = 0xFD90
0000000100010e04	movq	%rax, %rcx
0000000100010e07	subq	%rdx, %rcx
0000000100010e0a	movq	0x207e(%rip), %xmm0
0000000100010e12	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010e18	pshufb	%xmm0, %xmm1
0000000100010e1d	movq	%xmm1, (%rdi)
0000000100010e21	addq	$-0x8, %rsi
0000000100010e25	addq	$0x8, %rdi
0000000100010e29	cmpq	%rsi, %rdx
0000000100010e2c	jne	0x100010e12
0000000100010e2e	testq	%rdx, %rdx
0000000100010e31	je	0x100010e56
0000000100010e33	leaq	-0x70(%rbp), %rsi
0000000100010e37	addq	%rsi, %rdx
0000000100010e3a	decq	%rdx
0000000100010e3d	nopl	(%rax)
0000000100010e40	movzbl	(%rdx), %esi
0000000100010e43	movb	%sil, -0x270(%rbp,%rcx)
0000000100010e4b	incq	%rcx
0000000100010e4e	decq	%rdx
0000000100010e51	cmpq	%rcx, %rax
0000000100010e54	jne	0x100010e40
0000000100010e56	movb	$0x0, -0x270(%rbp,%rax)
0000000100010e5e	leaq	-0x270(%rbp), %rbx
0000000100010e65	movq	%rbx, %rdi
0000000100010e68	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100010e6d	movq	%r13, %rdi
0000000100010e70	movq	%rbx, %rsi
0000000100010e73	movq	%rax, %rdx
0000000100010e76	callq	_buf_put
0000000100010e7b	movq	0x41ae(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010e82	movq	(%rax), %rax
0000000100010e85	cmpq	-0x30(%rbp), %rax
0000000100010e89	jne	0x100010fd8
0000000100010e8f	addq	$0x268, %rsp                    ## imm = 0x268
0000000100010e96	popq	%rbx
0000000100010e97	popq	%r12
0000000100010e99	popq	%r13
0000000100010e9b	popq	%r14
0000000100010e9d	popq	%r15
0000000100010e9f	popq	%rbp
0000000100010ea0	retq
0000000100010ea1	cmpl	$0x20, %eax
0000000100010ea4	jae	0x100010eaa
0000000100010ea6	xorl	%ecx, %ecx
0000000100010ea8	jmp	0x100010f1f
0000000100010eaa	movl	%r8d, %edx
0000000100010ead	andl	$0x1f, %edx
0000000100010eb0	movq	%rax, %rcx
0000000100010eb3	subq	%rdx, %rcx
0000000100010eb6	movl	%edi, %esi
0000000100010eb8	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010ebe	leaq	(%rsi,%rbp), %r9
0000000100010ec2	addq	$-0x80, %r9
0000000100010ec6	movl	%edi, %r10d
0000000100010ec9	andl	$0x1f, %r10d
0000000100010ecd	subq	%r10, %rsi
0000000100010ed0	xorl	%r10d, %r10d
0000000100010ed3	movdqa	0x1fa5(%rip), %xmm0
0000000100010edb	movdqu	-0x10(%r9), %xmm1
0000000100010ee1	movdqu	(%r9), %xmm2
0000000100010ee6	pshufb	%xmm0, %xmm2
0000000100010eeb	pshufb	%xmm0, %xmm1
0000000100010ef0	movdqu	%xmm2, -0x26f(%rbp,%r10)
0000000100010efa	movdqu	%xmm1, -0x25f(%rbp,%r10)
0000000100010f04	addq	$0x20, %r10
0000000100010f08	addq	$-0x20, %r9
0000000100010f0c	cmpq	%r10, %rsi
0000000100010f0f	jne	0x100010edb
0000000100010f11	testq	%rdx, %rdx
0000000100010f14	je	0x100010fb6
0000000100010f1a	cmpl	$0x7, %edx
0000000100010f1d	jbe	0x100010f84
0000000100010f1f	movq	%rcx, %rsi
0000000100010f22	movl	%r8d, %edx
0000000100010f25	andl	$0x7, %edx
0000000100010f28	movq	%rax, %rcx
0000000100010f2b	subq	%rdx, %rcx
0000000100010f2e	movq	%rsi, %r8
0000000100010f31	negq	%r8
0000000100010f34	leaq	(%r8,%rbp), %r9
0000000100010f38	addq	$-0x70, %r9
0000000100010f3c	movl	%edi, %r8d
0000000100010f3f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010f46	addq	%r8, %r9
0000000100010f49	addq	$-0x8, %r9
0000000100010f4d	movl	%edi, %r10d
0000000100010f50	andl	$0x7, %r10d
0000000100010f54	subq	%r10, %r8
0000000100010f57	movq	0x1f31(%rip), %xmm0
0000000100010f5f	movq	(%r9), %xmm1
0000000100010f64	pshufb	%xmm0, %xmm1
0000000100010f69	movq	%xmm1, -0x26f(%rbp,%rsi)
0000000100010f72	addq	$0x8, %rsi
0000000100010f76	addq	$-0x8, %r9
0000000100010f7a	cmpq	%rsi, %r8
0000000100010f7d	jne	0x100010f5f
0000000100010f7f	testq	%rdx, %rdx
0000000100010f82	je	0x100010fb6
0000000100010f84	leaq	-0x70(%rbp), %rsi
0000000100010f88	addq	%rsi, %rdx
0000000100010f8b	decq	%rdx
0000000100010f8e	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
0000000100010f94	nopw	%cs:(%rax,%rax)
0000000100010fa0	movzbl	(%rdx), %esi
0000000100010fa3	movb	%sil, -0x26f(%rbp,%rcx)
0000000100010fab	incq	%rcx
0000000100010fae	decq	%rdx
0000000100010fb1	cmpq	%rcx, %rdi
0000000100010fb4	jne	0x100010fa0
0000000100010fb6	movb	$0x0, -0x26f(%rbp,%rax)
0000000100010fbe	jmp	0x100010e5e
0000000100010fc3	movq	%rbx, %rdi
0000000100010fc6	movsd	-0x280(%rbp), %xmm0
0000000100010fce	movl	$0x9, %esi
0000000100010fd3	jmp	0x10000fe3a
0000000100010fd8	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100010fdd	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
0000000100010fe7	jmp	0x100010e5e
0000000100010fec	repne		jmp	0x100010fee
0000000100010fef	pushq	%rdx
0000000100010ff1	jmp	0x100010ff2
0000000100010ff3	pushq	%rdx
0000000100010ff5	jmp	0x100010ff6
0000000100010ff7	pushq	%rdx
0000000100010ff9	jmp	0x100010ffa
0000000100010ffb	decl	-0x4000011(%rsi)
0000000100011001	jmp	0x100011002
0000000100011003	.byte 0xff #bad opcode
0000000100011004	sti
0000000100011005	jmp	0x100011006
0000000100011007	.byte 0xff #bad opcode
0000000100011008	sti
0000000100011009	jmp	0x10001100a
000000010001100b	.byte 0xff #bad opcode
000000010001100c	sti
000000010001100d	jmp	0x10001100e
000000010001100f	jmpq	*%rax
0000000100011011	outb	%al, %dx
0000000100011012	.byte 0xff #bad opcode
0000000100011013	.byte 0xff #bad opcode
0000000100011014	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
0000000100011019	inl	%dx, %eax
000000010001101a	.byte 0xff #bad opcode
000000010001101b	pushq	-0x22000012(%rbp)
0000000100011021	.byte 0xf1 #bad opcode
0000000100011022	.byte 0xff #bad opcode
0000000100011023	ljmpl	*0x40ffffed(%rcx)
0000000100011029	lock
000000010001102a	.byte 0xff #bad opcode
000000010001102b	incl	-0x13(%rcx)
000000010001102e	.byte 0xff #bad opcode
000000010001102f	.byte 0xff #bad opcode
0000000100011030	jl	0x100011023
0000000100011032	.byte 0xff #bad opcode
0000000100011033	jmpq	*(%rax)
0000000100011035	inb	%dx, %al
0000000100011036	.byte 0xff #bad opcode
0000000100011037	jmpq	*(%rax)
0000000100011039	inb	%dx, %al
000000010001103a	.byte 0xff #bad opcode
000000010001103b	incl	%esp
000000010001103d	lock
000000010001103e	.byte 0xff #bad opcode
000000010001103f	pushq	(%rax)
0000000100011041	.byte 0xf1 #bad opcode
0000000100011042	.byte 0xff #bad opcode
0000000100011043	callq	*(%rsi)
0000000100011045	cmc
0000000100011046	.byte 0xff #bad opcode
0000000100011047	.byte 0xff #bad opcode
0000000100011048	cmc
000000010001104a	.byte 0xff #bad opcode
000000010001104b	decl	0x5bffffee(%rbp)
0000000100011051	outb	%al, %dx
0000000100011052	.byte 0xff #bad opcode
0000000100011053	.byte 0xff #bad opcode
0000000100011054	inb	%dx, %al
0000000100011055	cmc
0000000100011056	.byte 0xff #bad opcode
0000000100011057	.byte 0xff #bad opcode
0000000100011058	inb	%dx, %al
0000000100011059	cmc
000000010001105a	.byte 0xff #bad opcode
000000010001105b	.byte 0xff #bad opcode
000000010001105c	inb	%dx, %al
000000010001105d	cmc
000000010001105e	.byte 0xff #bad opcode
000000010001105f	.byte 0xff #bad opcode
0000000100011060	inb	%dx, %al
0000000100011061	cmc
0000000100011062	.byte 0xff #bad opcode
0000000100011063	jmpq	*-0xa(%rcx)
0000000100011066	.byte 0xff #bad opcode
0000000100011067	ljmpl	*-0x1(%rbp,%rsi,8)
000000010001106b	ljmpl	*-0x1(%rbp,%rsi,8)
000000010001106f	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100011073	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100011077	ljmpl	*-0x1(%rbp,%rsi,8)
000000010001107b	jmpq	*-0xa(%rdi)
000000010001107e	.byte 0xff #bad opcode
000000010001107f	.byte 0xff #bad opcode
0000000100011080	inb	%dx, %al
0000000100011081	cmc
0000000100011082	.byte 0xff #bad opcode
0000000100011083	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100011087	ljmpl	*-0x1(%rbp,%rsi,8)
000000010001108b	callq	*-0xa(%rbx)
000000010001108e	.byte 0xff #bad opcode
000000010001108f	ljmpl	*-0x1(%rbp,%rsi,8)
0000000100011093	ljmpl	*-0xa(%rdi)
0000000100011096	.byte 0xff #bad opcode
0000000100011097	decl	(%rdi)
0000000100011099	.byte 0x1f #bad opcode
000000010001109a	testb	%al, (%rax)
000000010001109c	addb	%al, (%rax)
000000010001109e	addb	%al, (%rax)
_fwp_escape:
00000001000110a0	pushq	%rbp
00000001000110a1	movq	%rsp, %rbp
00000001000110a4	pushq	%r15
00000001000110a6	pushq	%r14
00000001000110a8	pushq	%r13
00000001000110aa	pushq	%r12
00000001000110ac	pushq	%rbx
00000001000110ad	subq	$0x18, %rsp
00000001000110b1	movq	%rdx, %r14
00000001000110b4	movq	%rsi, %r15
00000001000110b7	movq	%rdi, %rbx
00000001000110ba	movq	0x3f6f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000110c1	movq	(%rax), %rax
00000001000110c4	movq	%rax, -0x30(%rbp)
00000001000110c8	movb	$0x22, -0x40(%rbp)
00000001000110cc	leaq	-0x40(%rbp), %rsi
00000001000110d0	movl	$0x1, %edx
00000001000110d5	callq	_buf_put
00000001000110da	testq	%r14, %r14
00000001000110dd	je	0x1000111d9
00000001000110e3	leaq	0x12a(%rip), %r12
00000001000110ea	xorl	%r13d, %r13d
00000001000110ed	jmp	0x100011111
00000001000110ef	movl	$0x2, %edx
00000001000110f4	movq	%rbx, %rdi
00000001000110f7	leaq	0x301c(%rip), %rsi              ## literal pool for: "\\r"
00000001000110fe	nop
0000000100011100	callq	_buf_put
0000000100011105	incq	%r13
0000000100011108	cmpq	%r13, %r14
000000010001110b	je	0x1000111d9
0000000100011111	movzbl	(%r15,%r13), %eax
0000000100011116	movzbl	%al, %ecx
0000000100011119	leal	-0x9(%rcx), %edx
000000010001111c	cmpl	$0x19, %edx
000000010001111f	ja	0x100011140
0000000100011121	movslq	(%r12,%rdx,4), %rdx
0000000100011125	addq	%r12, %rdx
0000000100011128	jmpq	*%rdx
000000010001112a	movl	$0x2, %edx
000000010001112f	movq	%rbx, %rdi
0000000100011132	leaq	0x2fde(%rip), %rsi              ## literal pool for: "\\t"
0000000100011139	jmp	0x100011100
000000010001113b	nopl	(%rax,%rax)
0000000100011140	cmpl	$0x5c, %ecx
0000000100011143	jne	0x100011156
0000000100011145	movl	$0x2, %edx
000000010001114a	movq	%rbx, %rdi
000000010001114d	leaq	0x2fbd(%rip), %rsi              ## literal pool for: "\\\\"
0000000100011154	jmp	0x100011100
0000000100011156	cmpb	$0x20, %al
0000000100011158	setae	%dl
000000010001115b	cmpb	$0x7f, %al
000000010001115d	setne	%sil
0000000100011161	testb	%sil, %dl
0000000100011164	jne	0x1000111c5
0000000100011166	movl	$0x10, %esi
000000010001116b	leaq	-0x40(%rbp), %r12
000000010001116f	movq	%r12, %rdi
0000000100011172	leaq	0x2fa4(%rip), %rdx              ## literal pool for: "\\u{%x}"
0000000100011179	xorl	%eax, %eax
000000010001117b	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100011180	movq	%r12, %rdi
0000000100011183	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100011188	movq	%rbx, %rdi
000000010001118b	movq	%r12, %rsi
000000010001118e	leaq	0x7f(%rip), %r12
0000000100011195	movq	%rax, %rdx
0000000100011198	jmp	0x100011100
000000010001119d	movl	$0x2, %edx
00000001000111a2	movq	%rbx, %rdi
00000001000111a5	leaq	0x2f62(%rip), %rsi              ## literal pool for: "\\\""
00000001000111ac	jmp	0x100011100
00000001000111b1	movl	$0x2, %edx
00000001000111b6	movq	%rbx, %rdi
00000001000111b9	leaq	0x2f54(%rip), %rsi              ## literal pool for: "\\n"
00000001000111c0	jmp	0x100011100
00000001000111c5	movb	%al, -0x40(%rbp)
00000001000111c8	movl	$0x1, %edx
00000001000111cd	movq	%rbx, %rdi
00000001000111d0	leaq	-0x40(%rbp), %rsi
00000001000111d4	jmp	0x100011100
00000001000111d9	movb	$0x22, -0x40(%rbp)
00000001000111dd	leaq	-0x40(%rbp), %rsi
00000001000111e1	movl	$0x1, %edx
00000001000111e6	movq	%rbx, %rdi
00000001000111e9	callq	_buf_put
00000001000111ee	movq	0x3e3b(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000111f5	movq	(%rax), %rax
00000001000111f8	cmpq	-0x30(%rbp), %rax
00000001000111fc	jne	0x10001120d
00000001000111fe	addq	$0x18, %rsp
0000000100011202	popq	%rbx
0000000100011203	popq	%r12
0000000100011205	popq	%r13
0000000100011207	popq	%r14
0000000100011209	popq	%r15
000000010001120b	popq	%rbp
000000010001120c	retq
000000010001120d	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100011212	nop
0000000100011214	.byte 0x16 #bad opcode
0000000100011215	.byte 0xff #bad opcode
0000000100011216	.byte 0xff #bad opcode
0000000100011217	lcalll	*0x42ffffff(%rbp)
000000010001121d	.byte 0xff #bad opcode
000000010001121e	.byte 0xff #bad opcode
000000010001121f	incl	-0x1(%rdx)
0000000100011222	.byte 0xff #bad opcode
0000000100011223	.byte 0xff #bad opcode
0000000100011224	.byte 0xdb #bad opcode
0000000100011225	.byte 0xfe #bad opcode
0000000100011226	.byte 0xff #bad opcode
0000000100011227	incl	-0x1(%rdx)
000000010001122a	.byte 0xff #bad opcode
000000010001122b	incl	-0x1(%rdx)
000000010001122e	.byte 0xff #bad opcode
000000010001122f	incl	-0x1(%rdx)
0000000100011232	.byte 0xff #bad opcode
0000000100011233	incl	-0x1(%rdx)
0000000100011236	.byte 0xff #bad opcode
0000000100011237	incl	-0x1(%rdx)
000000010001123a	.byte 0xff #bad opcode
000000010001123b	incl	-0x1(%rdx)
000000010001123e	.byte 0xff #bad opcode
000000010001123f	incl	-0x1(%rdx)
0000000100011242	.byte 0xff #bad opcode
0000000100011243	incl	-0x1(%rdx)
0000000100011246	.byte 0xff #bad opcode
0000000100011247	incl	-0x1(%rdx)
000000010001124a	.byte 0xff #bad opcode
000000010001124b	incl	-0x1(%rdx)
000000010001124e	.byte 0xff #bad opcode
000000010001124f	incl	-0x1(%rdx)
0000000100011252	.byte 0xff #bad opcode
0000000100011253	incl	-0x1(%rdx)
0000000100011256	.byte 0xff #bad opcode
0000000100011257	incl	-0x1(%rdx)
000000010001125a	.byte 0xff #bad opcode
000000010001125b	incl	-0x1(%rdx)
000000010001125e	.byte 0xff #bad opcode
000000010001125f	incl	-0x1(%rdx)
0000000100011262	.byte 0xff #bad opcode
0000000100011263	incl	-0x1(%rdx)
0000000100011266	.byte 0xff #bad opcode
0000000100011267	incl	-0x1(%rdx)
000000010001126a	.byte 0xff #bad opcode
000000010001126b	incl	-0x1(%rdx)
000000010001126e	.byte 0xff #bad opcode
000000010001126f	incl	-0x1(%rdx)
0000000100011272	.byte 0xff #bad opcode
0000000100011273	incl	-0x1(%rdx)
0000000100011276	.byte 0xff #bad opcode
0000000100011277	decl	0xfffffff(%rcx)
000000010001127d	.byte 0x1f #bad opcode
000000010001127e	addb	%dl, 0x48(%rbp)
0000000100011282	movl	%esp, %ebp
0000000100011284	pushq	%r15
0000000100011286	pushq	%r14
0000000100011288	pushq	%r13
000000010001128a	pushq	%r12
000000010001128c	pushq	%rbx
000000010001128d	subq	$0x88, %rsp
0000000100011294	movq	0x3d95(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010001129b	movq	(%rax), %rax
000000010001129e	movq	%rax, -0x30(%rbp)
00000001000112a2	movq	%rsi, %rax
00000001000112a5	orq	%rdx, %rax
00000001000112a8	je	0x100011579
00000001000112ae	movq	%rdx, %r8
00000001000112b1	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
00000001000112bb	imulq	%rsi, %rcx
00000001000112bf	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
00000001000112c9	movq	%rsi, %rax
00000001000112cc	mulq	%r9
00000001000112cf	addq	%rcx, %rdx
00000001000112d2	imulq	%r8, %r9
00000001000112d6	addq	%rdx, %r9
00000001000112d9	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
00000001000112e3	addq	%rax, %rcx
00000001000112e6	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
00000001000112f0	adcq	%r9, %rax
00000001000112f3	movq	%rax, %rdx
00000001000112f6	shrdq	$0xd, %rcx, %rdx
00000001000112fb	shldq	$0x33, %rcx, %rax
0000000100011300	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
000000010001130a	cmpq	%rax, %rcx
000000010001130d	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
0000000100011312	sbbq	%rdx, %rax
0000000100011315	jae	0x100011596
000000010001131b	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
0000000100011325	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
000000010001132f	movq	%rsi, %rax
0000000100011332	mulq	%r9
0000000100011335	imulq	%rsi, %rcx
0000000100011339	addq	%rcx, %rdx
000000010001133c	imulq	%r8, %r9
0000000100011340	addq	%rdx, %r9
0000000100011343	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
000000010001134d	addq	%rax, %rcx
0000000100011350	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
000000010001135a	adcq	%r9, %rax
000000010001135d	movq	%rax, %rdx
0000000100011360	shrdq	$0xb, %rcx, %rdx
0000000100011365	shldq	$0x35, %rcx, %rax
000000010001136a	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
0000000100011374	cmpq	%rcx, %rax
0000000100011377	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
000000010001137e	jb	0x1000115b8
0000000100011384	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
000000010001138e	imulq	%rsi, %rcx
0000000100011392	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
000000010001139c	movq	%rsi, %rax
000000010001139f	mulq	%r9
00000001000113a2	addq	%rcx, %rdx
00000001000113a5	imulq	%r8, %r9
00000001000113a9	addq	%rdx, %r9
00000001000113ac	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
00000001000113b6	addq	%rax, %rcx
00000001000113b9	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
00000001000113c3	adcq	%r9, %rax
00000001000113c6	movq	%rax, %rdx
00000001000113c9	shrdq	$0x9, %rcx, %rdx
00000001000113ce	shldq	$0x37, %rcx, %rax
00000001000113d3	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
00000001000113dd	cmpq	%rcx, %rax
00000001000113e0	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
00000001000113ea	sbbq	%rax, %rdx
00000001000113ed	jb	0x1000116b8
00000001000113f3	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
00000001000113fd	imulq	%rsi, %rcx
0000000100011401	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
000000010001140b	movq	%rsi, %rax
000000010001140e	mulq	%r9
0000000100011411	addq	%rcx, %rdx
0000000100011414	imulq	%r8, %r9
0000000100011418	addq	%rdx, %r9
000000010001141b	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
0000000100011425	addq	%rax, %rcx
0000000100011428	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
0000000100011432	adcq	%r9, %rax
0000000100011435	movq	%rax, %rdx
0000000100011438	shrdq	$0x6, %rcx, %rdx
000000010001143d	shldq	$0x3a, %rcx, %rax
0000000100011442	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
000000010001144c	cmpq	%rcx, %rax
000000010001144f	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
0000000100011459	sbbq	%rax, %rdx
000000010001145c	jb	0x1000116c9
0000000100011462	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
000000010001146c	imulq	%rsi, %rcx
0000000100011470	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
000000010001147a	movq	%rsi, %rax
000000010001147d	mulq	%r9
0000000100011480	addq	%rcx, %rdx
0000000100011483	imulq	%r8, %r9
0000000100011487	addq	%rdx, %r9
000000010001148a	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
0000000100011494	addq	%rax, %rcx
0000000100011497	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
00000001000114a1	adcq	%r9, %rax
00000001000114a4	movq	%rax, %rdx
00000001000114a7	shrdq	$0x3, %rcx, %rdx
00000001000114ac	shldq	$0x3d, %rcx, %rax
00000001000114b1	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
00000001000114bb	cmpq	%rcx, %rax
00000001000114be	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
00000001000114c8	sbbq	%rax, %rdx
00000001000114cb	jb	0x1000116da
00000001000114d1	testq	%r8, %r8
00000001000114d4	js	0x100011afc
00000001000114da	xorl	%r10d, %r10d
00000001000114dd	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000114e7	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000114f1	movq	%r8, %r14
00000001000114f4	nopw	%cs:(%rax,%rax)
0000000100011500	movq	%r8, %rcx
0000000100011503	shldq	$0x3f, %rsi, %rcx
0000000100011508	shrq	%r14
000000010001150b	movq	%rcx, %r9
000000010001150e	addq	%r14, %r9
0000000100011511	adcq	$0x0, %r9
0000000100011515	movq	%r9, %rax
0000000100011518	mulq	%r11
000000010001151b	shrq	$0x2, %rdx
000000010001151f	leaq	(%rdx,%rdx,4), %rax
0000000100011523	subq	%rax, %r9
0000000100011526	subq	%r9, %rcx
0000000100011529	sbbq	$0x0, %r14
000000010001152d	movq	%rcx, %r9
0000000100011530	imulq	%rbx, %r9
0000000100011534	movq	%rcx, %rax
0000000100011537	mulq	%r11
000000010001153a	addq	%r9, %rdx
000000010001153d	imulq	%r11, %r14
0000000100011541	addq	%rdx, %r14
0000000100011544	movq	%rax, %rcx
0000000100011547	addq	%rax, %rcx
000000010001154a	leaq	(%rcx,%rcx,4), %rcx
000000010001154e	movl	%esi, %edx
0000000100011550	subl	%ecx, %edx
0000000100011552	orb	$0x30, %dl
0000000100011555	movb	%dl, -0x70(%rbp,%r10)
000000010001155a	incq	%r10
000000010001155d	cmpq	$0xa, %rsi
0000000100011561	sbbq	$0x0, %r8
0000000100011565	movq	%rax, %rsi
0000000100011568	movq	%r14, %r8
000000010001156b	jae	0x100011500
000000010001156d	testl	%r10d, %r10d
0000000100011570	jg	0x100011583
0000000100011572	xorl	%eax, %eax
0000000100011574	jmp	0x100011696
0000000100011579	movb	$0x30, -0x70(%rbp)
000000010001157d	movl	$0x1, %r10d
0000000100011583	movl	%r10d, %eax
0000000100011586	cmpq	$0x8, %rax
000000010001158a	jae	0x1000115af
000000010001158c	xorl	%ecx, %ecx
000000010001158e	movq	%rax, %rdx
0000000100011591	jmp	0x100011672
0000000100011596	movq	%rdi, %r14
0000000100011599	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
00000001000115a3	leaq	_fwp_fmt_duration.units(%rip), %rbx
00000001000115aa	jmp	0x1000116e9
00000001000115af	cmpl	$0x20, %eax
00000001000115b2	jae	0x1000115d1
00000001000115b4	xorl	%ecx, %ecx
00000001000115b6	jmp	0x10001162b
00000001000115b8	movq	%rdi, %r14
00000001000115bb	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
00000001000115c5	leaq	0x42a4(%rip), %rbx
00000001000115cc	jmp	0x1000116e9
00000001000115d1	movl	%r10d, %edx
00000001000115d4	andl	$0x1f, %edx
00000001000115d7	movq	%rax, %rcx
00000001000115da	subq	%rdx, %rcx
00000001000115dd	leaq	-0xa0(%rbp), %rsi
00000001000115e4	movdqa	0x1894(%rip), %xmm0
00000001000115ec	movq	%rax, %r8
00000001000115ef	nop
00000001000115f0	movdqu	-0x90(%rbp,%r8), %xmm1
00000001000115fa	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100011601	pshufb	%xmm0, %xmm2
0000000100011606	pshufb	%xmm0, %xmm1
000000010001160b	movdqa	%xmm2, -0x10(%rsi)
0000000100011610	movdqa	%xmm1, (%rsi)
0000000100011614	addq	$-0x20, %r8
0000000100011618	addq	$0x20, %rsi
000000010001161c	cmpq	%r8, %rdx
000000010001161f	jne	0x1000115f0
0000000100011621	testq	%rdx, %rdx
0000000100011624	je	0x100011696
0000000100011626	cmpl	$0x7, %edx
0000000100011629	jbe	0x100011672
000000010001162b	movl	%r10d, %edx
000000010001162e	andl	$0x7, %edx
0000000100011631	movq	%rax, %rsi
0000000100011634	subq	%rcx, %rsi
0000000100011637	leaq	(%rcx,%rbp), %r8
000000010001163b	addq	$-0xb0, %r8
0000000100011642	movq	%rax, %rcx
0000000100011645	subq	%rdx, %rcx
0000000100011648	movq	0x1840(%rip), %xmm0
0000000100011650	movq	-0x78(%rbp,%rsi), %xmm1
0000000100011656	pshufb	%xmm0, %xmm1
000000010001165b	movq	%xmm1, (%r8)
0000000100011660	addq	$-0x8, %rsi
0000000100011664	addq	$0x8, %r8
0000000100011668	cmpq	%rsi, %rdx
000000010001166b	jne	0x100011650
000000010001166d	testq	%rdx, %rdx
0000000100011670	je	0x100011696
0000000100011672	leaq	-0x70(%rbp), %rsi
0000000100011676	addq	%rsi, %rdx
0000000100011679	decq	%rdx
000000010001167c	nopl	(%rax)
0000000100011680	movzbl	(%rdx), %esi
0000000100011683	movb	%sil, -0xb0(%rbp,%rcx)
000000010001168b	incq	%rcx
000000010001168e	decq	%rdx
0000000100011691	cmpq	%rcx, %rax
0000000100011694	jne	0x100011680
0000000100011696	movb	$0x0, -0xb0(%rbp,%rax)
000000010001169e	leaq	0x2a84(%rip), %rsi              ## literal pool for: "%sns"
00000001000116a5	leaq	-0xb0(%rbp), %rdx
00000001000116ac	xorl	%eax, %eax
00000001000116ae	callq	0x100012d14                     ## symbol stub for: _sprintf
00000001000116b3	jmp	0x100011ad6
00000001000116b8	movq	%rdi, %r14
00000001000116bb	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
00000001000116c0	leaq	0x41b9(%rip), %rbx
00000001000116c7	jmp	0x1000116e9
00000001000116c9	movq	%rdi, %r14
00000001000116cc	movl	$0xf4240, %edx                  ## imm = 0xF4240
00000001000116d1	leaq	0x41b8(%rip), %rbx
00000001000116d8	jmp	0x1000116e9
00000001000116da	movq	%rdi, %r14
00000001000116dd	movl	$0x3e8, %edx                    ## imm = 0x3E8
00000001000116e2	leaq	0x41b7(%rip), %rbx
00000001000116e9	xorl	%ecx, %ecx
00000001000116eb	movq	%rsi, %rdi
00000001000116ee	movq	%r8, %rsi
00000001000116f1	callq	0x100012bf4                     ## symbol stub for: ___divti3
00000001000116f6	movq	%rax, %rcx
00000001000116f9	movq	%rdx, %rsi
00000001000116fc	testq	%rdx, %rdx
00000001000116ff	js	0x1000117b0
0000000100011705	movq	%rcx, %rax
0000000100011708	orq	%rsi, %rax
000000010001170b	je	0x100011889
0000000100011711	xorl	%r10d, %r10d
0000000100011714	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
000000010001171e	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100011728	movq	%rsi, %r12
000000010001172b	movq	%r14, %rdi
000000010001172e	nop
0000000100011730	movq	%rsi, %r8
0000000100011733	shldq	$0x3f, %rcx, %r8
0000000100011738	shrq	%r12
000000010001173b	movq	%r8, %r9
000000010001173e	addq	%r12, %r9
0000000100011741	adcq	$0x0, %r9
0000000100011745	movq	%r9, %rax
0000000100011748	mulq	%r11
000000010001174b	shrq	$0x2, %rdx
000000010001174f	leaq	(%rdx,%rdx,4), %rax
0000000100011753	subq	%rax, %r9
0000000100011756	subq	%r9, %r8
0000000100011759	sbbq	$0x0, %r12
000000010001175d	movq	%r8, %r9
0000000100011760	imulq	%r15, %r9
0000000100011764	movq	%r8, %rax
0000000100011767	mulq	%r11
000000010001176a	addq	%r9, %rdx
000000010001176d	imulq	%r11, %r12
0000000100011771	addq	%rdx, %r12
0000000100011774	movq	%rax, %rdx
0000000100011777	addq	%rax, %rdx
000000010001177a	leaq	(%rdx,%rdx,4), %rdx
000000010001177e	movl	%ecx, %r8d
0000000100011781	subl	%edx, %r8d
0000000100011784	orb	$0x30, %r8b
0000000100011788	movb	%r8b, -0x70(%rbp,%r10)
000000010001178d	incq	%r10
0000000100011790	cmpq	$0xa, %rcx
0000000100011794	sbbq	$0x0, %rsi
0000000100011798	movq	%rax, %rcx
000000010001179b	movq	%r12, %rsi
000000010001179e	jae	0x100011730
00000001000117a0	testl	%r10d, %r10d
00000001000117a3	jg	0x100011896
00000001000117a9	xorl	%eax, %eax
00000001000117ab	jmp	0x100011986
00000001000117b0	movb	$0x2d, -0xb0(%rbp)
00000001000117b7	xorl	%r9d, %r9d
00000001000117ba	negq	%rcx
00000001000117bd	movl	$0x0, %r11d
00000001000117c3	sbbq	%rsi, %r11
00000001000117c6	movl	$0x1, %r13d
00000001000117cc	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000117d6	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000117e0	movq	%r11, %r12
00000001000117e3	nopw	%cs:(%rax,%rax)
00000001000117f0	movq	%r11, %rsi
00000001000117f3	shldq	$0x3f, %rcx, %rsi
00000001000117f8	shrq	%r12
00000001000117fb	movq	%rsi, %rdi
00000001000117fe	addq	%r12, %rdi
0000000100011801	adcq	$0x0, %rdi
0000000100011805	movq	%rdi, %rax
0000000100011808	mulq	%r10
000000010001180b	movl	%r13d, %r8d
000000010001180e	shrq	$0x2, %rdx
0000000100011812	leaq	(%rdx,%rdx,4), %rax
0000000100011816	subq	%rax, %rdi
0000000100011819	subq	%rdi, %rsi
000000010001181c	sbbq	$0x0, %r12
0000000100011820	movq	%rsi, %rdi
0000000100011823	movq	%rsi, %rax
0000000100011826	mulq	%r10
0000000100011829	imulq	%r15, %rdi
000000010001182d	addq	%rdi, %rdx
0000000100011830	imulq	%r10, %r12
0000000100011834	addq	%rdx, %r12
0000000100011837	movq	%rax, %rdx
000000010001183a	addq	%rax, %rdx
000000010001183d	leaq	(%rdx,%rdx,4), %rdx
0000000100011841	movl	%ecx, %esi
0000000100011843	subl	%edx, %esi
0000000100011845	orb	$0x30, %sil
0000000100011849	movb	%sil, -0x70(%rbp,%r9)
000000010001184e	incq	%r9
0000000100011851	leal	0x1(%r8), %r13d
0000000100011855	cmpq	$0xa, %rcx
0000000100011859	sbbq	$0x0, %r11
000000010001185d	movq	%rax, %rcx
0000000100011860	movq	%r12, %r11
0000000100011863	jae	0x1000117f0
0000000100011865	testl	%r9d, %r9d
0000000100011868	movq	%r14, %rdi
000000010001186b	jle	0x1000118b2
000000010001186d	movl	%r9d, %eax
0000000100011870	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100011875	cmpq	$0x8, %rax
0000000100011879	jae	0x100011993
000000010001187f	xorl	%ecx, %ecx
0000000100011881	movq	%rax, %rdx
0000000100011884	jmp	0x100011a85
0000000100011889	movb	$0x30, -0x70(%rbp)
000000010001188d	movl	$0x1, %r10d
0000000100011893	movq	%r14, %rdi
0000000100011896	movl	%r10d, %eax
0000000100011899	cmpq	$0x8, %rax
000000010001189d	jae	0x1000118a9
000000010001189f	xorl	%ecx, %ecx
00000001000118a1	movq	%rax, %rdx
00000001000118a4	jmp	0x100011962
00000001000118a9	cmpl	$0x20, %eax
00000001000118ac	jae	0x1000118b9
00000001000118ae	xorl	%ecx, %ecx
00000001000118b0	jmp	0x10001191b
00000001000118b2	xorl	%eax, %eax
00000001000118b4	jmp	0x100011ab6
00000001000118b9	movl	%r10d, %edx
00000001000118bc	andl	$0x1f, %edx
00000001000118bf	movq	%rax, %rcx
00000001000118c2	subq	%rdx, %rcx
00000001000118c5	leaq	-0xa0(%rbp), %rsi
00000001000118cc	movdqa	0x15ac(%rip), %xmm0
00000001000118d4	movq	%rax, %r8
00000001000118d7	nopw	(%rax,%rax)
00000001000118e0	movdqu	-0x90(%rbp,%r8), %xmm1
00000001000118ea	movdqu	-0x80(%rbp,%r8), %xmm2
00000001000118f1	pshufb	%xmm0, %xmm2
00000001000118f6	pshufb	%xmm0, %xmm1
00000001000118fb	movdqa	%xmm2, -0x10(%rsi)
0000000100011900	movdqa	%xmm1, (%rsi)
0000000100011904	addq	$-0x20, %r8
0000000100011908	addq	$0x20, %rsi
000000010001190c	cmpq	%r8, %rdx
000000010001190f	jne	0x1000118e0
0000000100011911	testq	%rdx, %rdx
0000000100011914	je	0x100011986
0000000100011916	cmpl	$0x7, %edx
0000000100011919	jbe	0x100011962
000000010001191b	movl	%r10d, %edx
000000010001191e	andl	$0x7, %edx
0000000100011921	movq	%rax, %rsi
0000000100011924	subq	%rcx, %rsi
0000000100011927	leaq	(%rcx,%rbp), %r8
000000010001192b	addq	$-0xb0, %r8
0000000100011932	movq	%rax, %rcx
0000000100011935	subq	%rdx, %rcx
0000000100011938	movq	0x1550(%rip), %xmm0
0000000100011940	movq	-0x78(%rbp,%rsi), %xmm1
0000000100011946	pshufb	%xmm0, %xmm1
000000010001194b	movq	%xmm1, (%r8)
0000000100011950	addq	$-0x8, %rsi
0000000100011954	addq	$0x8, %r8
0000000100011958	cmpq	%rsi, %rdx
000000010001195b	jne	0x100011940
000000010001195d	testq	%rdx, %rdx
0000000100011960	je	0x100011986
0000000100011962	leaq	-0x70(%rbp), %rsi
0000000100011966	addq	%rsi, %rdx
0000000100011969	decq	%rdx
000000010001196c	nopl	(%rax)
0000000100011970	movzbl	(%rdx), %esi
0000000100011973	movb	%sil, -0xb0(%rbp,%rcx)
000000010001197b	incq	%rcx
000000010001197e	decq	%rdx
0000000100011981	cmpq	%rcx, %rax
0000000100011984	jne	0x100011970
0000000100011986	movb	$0x0, -0xb0(%rbp,%rax)
000000010001198e	jmp	0x100011abe
0000000100011993	cmpl	$0x20, %eax
0000000100011996	jae	0x10001199c
0000000100011998	xorl	%ecx, %ecx
000000010001199a	jmp	0x100011a14
000000010001199c	movl	%r9d, %edx
000000010001199f	andl	$0x1f, %edx
00000001000119a2	movq	%rax, %rcx
00000001000119a5	subq	%rdx, %rcx
00000001000119a8	movl	%r8d, %esi
00000001000119ab	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
00000001000119b1	leaq	(%rsi,%rbp), %r10
00000001000119b5	addq	$-0x80, %r10
00000001000119b9	movl	%r8d, %r11d
00000001000119bc	andl	$0x1f, %r11d
00000001000119c0	subq	%r11, %rsi
00000001000119c3	xorl	%r11d, %r11d
00000001000119c6	movdqa	0x14b2(%rip), %xmm0
00000001000119ce	nop
00000001000119d0	movdqu	-0x10(%r10), %xmm1
00000001000119d6	movdqu	(%r10), %xmm2
00000001000119db	pshufb	%xmm0, %xmm2
00000001000119e0	pshufb	%xmm0, %xmm1
00000001000119e5	movdqu	%xmm2, -0xaf(%rbp,%r11)
00000001000119ef	movdqu	%xmm1, -0x9f(%rbp,%r11)
00000001000119f9	addq	$0x20, %r11
00000001000119fd	addq	$-0x20, %r10
0000000100011a01	cmpq	%r11, %rsi
0000000100011a04	jne	0x1000119d0
0000000100011a06	testq	%rdx, %rdx
0000000100011a09	je	0x100011ab6
0000000100011a0f	cmpl	$0x7, %edx
0000000100011a12	jbe	0x100011a85
0000000100011a14	movq	%rcx, %rsi
0000000100011a17	movl	%r9d, %edx
0000000100011a1a	andl	$0x7, %edx
0000000100011a1d	movq	%rax, %rcx
0000000100011a20	subq	%rdx, %rcx
0000000100011a23	movq	%rsi, %r9
0000000100011a26	negq	%r9
0000000100011a29	leaq	(%r9,%rbp), %r10
0000000100011a2d	addq	$-0x70, %r10
0000000100011a31	movl	%r8d, %r9d
0000000100011a34	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100011a3b	addq	%r9, %r10
0000000100011a3e	addq	$-0x8, %r10
0000000100011a42	movl	%r8d, %r11d
0000000100011a45	andl	$0x7, %r11d
0000000100011a49	subq	%r11, %r9
0000000100011a4c	movq	0x143c(%rip), %xmm0
0000000100011a54	nopw	%cs:(%rax,%rax)
0000000100011a60	movq	(%r10), %xmm1
0000000100011a65	pshufb	%xmm0, %xmm1
0000000100011a6a	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100011a73	addq	$0x8, %rsi
0000000100011a77	addq	$-0x8, %r10
0000000100011a7b	cmpq	%rsi, %r9
0000000100011a7e	jne	0x100011a60
0000000100011a80	testq	%rdx, %rdx
0000000100011a83	je	0x100011ab6
0000000100011a85	leaq	-0x70(%rbp), %rsi
0000000100011a89	addq	%rsi, %rdx
0000000100011a8c	decq	%rdx
0000000100011a8f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100011a96	nopw	%cs:(%rax,%rax)
0000000100011aa0	movzbl	(%rdx), %esi
0000000100011aa3	movb	%sil, -0xaf(%rbp,%rcx)
0000000100011aab	incq	%rcx
0000000100011aae	decq	%rdx
0000000100011ab1	cmpq	%rcx, %r8
0000000100011ab4	jne	0x100011aa0
0000000100011ab6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100011abe	movq	(%rbx), %rcx
0000000100011ac1	leaq	0x265c(%rip), %rsi              ## literal pool for: "%s%s"
0000000100011ac8	leaq	-0xb0(%rbp), %rdx
0000000100011acf	xorl	%eax, %eax
0000000100011ad1	callq	0x100012d14                     ## symbol stub for: _sprintf
0000000100011ad6	movq	0x3553(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100011add	movq	(%rax), %rax
0000000100011ae0	cmpq	-0x30(%rbp), %rax
0000000100011ae4	jne	0x100011ce3
0000000100011aea	addq	$0x88, %rsp
0000000100011af1	popq	%rbx
0000000100011af2	popq	%r12
0000000100011af4	popq	%r13
0000000100011af6	popq	%r14
0000000100011af8	popq	%r15
0000000100011afa	popq	%rbp
0000000100011afb	retq
0000000100011afc	movb	$0x2d, -0xb0(%rbp)
0000000100011b03	xorl	%r10d, %r10d
0000000100011b06	negq	%rsi
0000000100011b09	movl	$0x0, %ebx
0000000100011b0e	sbbq	%r8, %rbx
0000000100011b11	movl	$0x1, %r12d
0000000100011b17	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100011b21	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100011b2b	movq	%rbx, %r15
0000000100011b2e	nop
0000000100011b30	movq	%rbx, %rcx
0000000100011b33	shldq	$0x3f, %rsi, %rcx
0000000100011b38	shrq	%r15
0000000100011b3b	movq	%rcx, %r8
0000000100011b3e	addq	%r15, %r8
0000000100011b41	adcq	$0x0, %r8
0000000100011b45	movq	%r8, %rax
0000000100011b48	mulq	%r11
0000000100011b4b	movl	%r12d, %r9d
0000000100011b4e	shrq	$0x2, %rdx
0000000100011b52	leaq	(%rdx,%rdx,4), %rax
0000000100011b56	subq	%rax, %r8
0000000100011b59	subq	%r8, %rcx
0000000100011b5c	sbbq	$0x0, %r15
0000000100011b60	movq	%rcx, %r8
0000000100011b63	movq	%rcx, %rax
0000000100011b66	mulq	%r11
0000000100011b69	imulq	%r14, %r8
0000000100011b6d	addq	%r8, %rdx
0000000100011b70	imulq	%r11, %r15
0000000100011b74	addq	%rdx, %r15
0000000100011b77	movq	%rax, %rcx
0000000100011b7a	addq	%rax, %rcx
0000000100011b7d	leaq	(%rcx,%rcx,4), %rcx
0000000100011b81	movl	%esi, %edx
0000000100011b83	subl	%ecx, %edx
0000000100011b85	orb	$0x30, %dl
0000000100011b88	movb	%dl, -0x70(%rbp,%r10)
0000000100011b8d	incq	%r10
0000000100011b90	leal	0x1(%r9), %r12d
0000000100011b94	cmpq	$0xa, %rsi
0000000100011b98	sbbq	$0x0, %rbx
0000000100011b9c	movq	%rax, %rsi
0000000100011b9f	movq	%r15, %rbx
0000000100011ba2	jae	0x100011b30
0000000100011ba4	testl	%r10d, %r10d
0000000100011ba7	jle	0x100011bc1
0000000100011ba9	movl	%r10d, %eax
0000000100011bac	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100011bb1	cmpq	$0x8, %rax
0000000100011bb5	jae	0x100011bc8
0000000100011bb7	xorl	%ecx, %ecx
0000000100011bb9	movq	%rax, %rdx
0000000100011bbc	jmp	0x100011cac
0000000100011bc1	xorl	%eax, %eax
0000000100011bc3	jmp	0x100011cd6
0000000100011bc8	cmpl	$0x20, %eax
0000000100011bcb	jae	0x100011bd1
0000000100011bcd	xorl	%ecx, %ecx
0000000100011bcf	jmp	0x100011c47
0000000100011bd1	movl	%r10d, %edx
0000000100011bd4	andl	$0x1f, %edx
0000000100011bd7	movq	%rax, %rcx
0000000100011bda	subq	%rdx, %rcx
0000000100011bdd	movl	%r9d, %esi
0000000100011be0	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100011be6	leaq	(%rsi,%rbp), %r8
0000000100011bea	addq	$-0x80, %r8
0000000100011bee	movl	%r9d, %r11d
0000000100011bf1	andl	$0x1f, %r11d
0000000100011bf5	subq	%r11, %rsi
0000000100011bf8	xorl	%r11d, %r11d
0000000100011bfb	movdqa	0x127d(%rip), %xmm0
0000000100011c03	movdqu	-0x10(%r8), %xmm1
0000000100011c09	movdqu	(%r8), %xmm2
0000000100011c0e	pshufb	%xmm0, %xmm2
0000000100011c13	pshufb	%xmm0, %xmm1
0000000100011c18	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100011c22	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100011c2c	addq	$0x20, %r11
0000000100011c30	addq	$-0x20, %r8
0000000100011c34	cmpq	%r11, %rsi
0000000100011c37	jne	0x100011c03
0000000100011c39	testq	%rdx, %rdx
0000000100011c3c	je	0x100011cd6
0000000100011c42	cmpl	$0x7, %edx
0000000100011c45	jbe	0x100011cac
0000000100011c47	movq	%rcx, %rsi
0000000100011c4a	movl	%r10d, %edx
0000000100011c4d	andl	$0x7, %edx
0000000100011c50	movq	%rax, %rcx
0000000100011c53	subq	%rdx, %rcx
0000000100011c56	movq	%rsi, %r8
0000000100011c59	negq	%r8
0000000100011c5c	leaq	(%r8,%rbp), %r10
0000000100011c60	addq	$-0x70, %r10
0000000100011c64	movl	%r9d, %r8d
0000000100011c67	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100011c6e	addq	%r8, %r10
0000000100011c71	addq	$-0x8, %r10
0000000100011c75	movl	%r9d, %r11d
0000000100011c78	andl	$0x7, %r11d
0000000100011c7c	subq	%r11, %r8
0000000100011c7f	movq	0x1209(%rip), %xmm0
0000000100011c87	movq	(%r10), %xmm1
0000000100011c8c	pshufb	%xmm0, %xmm1
0000000100011c91	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100011c9a	addq	$0x8, %rsi
0000000100011c9e	addq	$-0x8, %r10
0000000100011ca2	cmpq	%rsi, %r8
0000000100011ca5	jne	0x100011c87
0000000100011ca7	testq	%rdx, %rdx
0000000100011caa	je	0x100011cd6
0000000100011cac	leaq	-0x70(%rbp), %rsi
0000000100011cb0	addq	%rsi, %rdx
0000000100011cb3	decq	%rdx
0000000100011cb6	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100011cbd	nopl	(%rax)
0000000100011cc0	movzbl	(%rdx), %esi
0000000100011cc3	movb	%sil, -0xaf(%rbp,%rcx)
0000000100011ccb	incq	%rcx
0000000100011cce	decq	%rdx
0000000100011cd1	cmpq	%rcx, %r9
0000000100011cd4	jne	0x100011cc0
0000000100011cd6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100011cde	jmp	0x10001169e
0000000100011ce3	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100011ce8	nopl	(%rax,%rax)
_fwp_format_g:
0000000100011cf0	pushq	%rbp
0000000100011cf1	movq	%rsp, %rbp
0000000100011cf4	pushq	%r15
0000000100011cf6	pushq	%r14
0000000100011cf8	pushq	%r13
0000000100011cfa	pushq	%r12
0000000100011cfc	pushq	%rbx
0000000100011cfd	subq	$0x98, %rsp
0000000100011d04	movl	%esi, %r12d
0000000100011d07	movq	%rdi, %rbx
0000000100011d0a	movq	0x331f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100011d11	movq	(%rax), %rax
0000000100011d14	movq	%rax, -0x30(%rbp)
0000000100011d18	decl	%r12d
0000000100011d1b	leaq	0x23d5(%rip), %rdx              ## literal pool for: "%.*e"
0000000100011d22	leaq	-0x70(%rbp), %r13
0000000100011d26	movl	$0x40, %esi
0000000100011d2b	movq	%r13, %rdi
0000000100011d2e	movl	%r12d, %ecx
0000000100011d31	movsd	%xmm0, -0xb8(%rbp)
0000000100011d39	movb	$0x1, %al
0000000100011d3b	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100011d40	movq	%r13, %rdi
0000000100011d43	movl	$0x65, %esi
0000000100011d48	callq	0x100012d1a                     ## symbol stub for: _strchr
0000000100011d4d	movq	%rax, %r15
0000000100011d50	leaq	0x1(%rax), %rdi
0000000100011d54	callq	0x100012c36                     ## symbol stub for: _atoi
0000000100011d59	movl	%eax, %r14d
0000000100011d5c	leal	-0x11(%r14), %eax
0000000100011d60	cmpl	$-0x17, %eax
0000000100011d63	ja	0x100011dce
0000000100011d65	subq	%r13, %r15
0000000100011d68	leaq	-0xb0(%rbp), %r12
0000000100011d6f	movl	$0x40, %ecx
0000000100011d74	movq	%r12, %rdi
0000000100011d77	movq	%r13, %rsi
0000000100011d7a	movq	%r15, %rdx
0000000100011d7d	callq	0x100012bfa                     ## symbol stub for: ___memcpy_chk
0000000100011d82	movb	$0x0, -0xb0(%rbp,%r15)
0000000100011d8b	movq	%r12, %rdi
0000000100011d8e	movl	$0x2e, %esi
0000000100011d93	callq	0x100012d1a                     ## symbol stub for: _strchr
0000000100011d98	testq	%rax, %rax
0000000100011d9b	sete	%al
0000000100011d9e	testq	%r15, %r15
0000000100011da1	sete	%cl
0000000100011da4	orb	%al, %cl
0000000100011da6	jne	0x100011e46
0000000100011dac	nopl	(%rax)
0000000100011db0	movzbl	-0xb1(%rbp,%r15), %eax
0000000100011db9	cmpl	$0x30, %eax
0000000100011dbc	jne	0x100011e38
0000000100011dbe	movb	$0x0, -0xb1(%rbp,%r15)
0000000100011dc7	decq	%r15
0000000100011dca	jne	0x100011db0
0000000100011dcc	jmp	0x100011e46
0000000100011dce	subl	%r14d, %r12d
0000000100011dd1	xorl	%ecx, %ecx
0000000100011dd3	testl	%r12d, %r12d
0000000100011dd6	cmovgl	%r12d, %ecx
0000000100011dda	leaq	0x2325(%rip), %rdx              ## literal pool for: "%.*f"
0000000100011de1	movl	$0x190, %esi                    ## imm = 0x190
0000000100011de6	movq	%rbx, %rdi
0000000100011de9	movsd	-0xb8(%rbp), %xmm0
0000000100011df1	movb	$0x1, %al
0000000100011df3	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100011df8	movq	%rbx, %rdi
0000000100011dfb	callq	0x100012d26                     ## symbol stub for: _strlen
0000000100011e00	movq	%rax, %r14
0000000100011e03	movq	%rbx, %rdi
0000000100011e06	movl	$0x2e, %esi
0000000100011e0b	callq	0x100012d1a                     ## symbol stub for: _strchr
0000000100011e10	testq	%rax, %rax
0000000100011e13	sete	%al
0000000100011e16	testq	%r14, %r14
0000000100011e19	sete	%cl
0000000100011e1c	orb	%al, %cl
0000000100011e1e	jne	0x100011e7b
0000000100011e20	movzbl	-0x1(%rbx,%r14), %eax
0000000100011e26	cmpl	$0x30, %eax
0000000100011e29	jne	0x100011e9d
0000000100011e2b	movb	$0x0, -0x1(%rbx,%r14)
0000000100011e31	decq	%r14
0000000100011e34	jne	0x100011e20
0000000100011e36	jmp	0x100011e7b
0000000100011e38	cmpl	$0x2e, %eax
0000000100011e3b	jne	0x100011e46
0000000100011e3d	movb	$0x0, -0xb1(%rbp,%r15)
0000000100011e46	movl	%r14d, %eax
0000000100011e49	shrl	$0x1f, %eax
0000000100011e4c	leal	0x2b(,%rax,2), %r8d
0000000100011e54	movl	%r14d, %r9d
0000000100011e57	negl	%r9d
0000000100011e5a	cmovsl	%r14d, %r9d
0000000100011e5e	leaq	0x2297(%rip), %rdx              ## literal pool for: "%se%c%02d"
0000000100011e65	leaq	-0xb0(%rbp), %rcx
0000000100011e6c	movl	$0x190, %esi                    ## imm = 0x190
0000000100011e71	movq	%rbx, %rdi
0000000100011e74	xorl	%eax, %eax
0000000100011e76	callq	0x100012d0e                     ## symbol stub for: _snprintf
0000000100011e7b	movq	0x31ae(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100011e82	movq	(%rax), %rax
0000000100011e85	cmpq	-0x30(%rbp), %rax
0000000100011e89	jne	0x100011eaa
0000000100011e8b	addq	$0x98, %rsp
0000000100011e92	popq	%rbx
0000000100011e93	popq	%r12
0000000100011e95	popq	%r13
0000000100011e97	popq	%r14
0000000100011e99	popq	%r15
0000000100011e9b	popq	%rbp
0000000100011e9c	retq
0000000100011e9d	cmpl	$0x2e, %eax
0000000100011ea0	jne	0x100011e7b
0000000100011ea2	movb	$0x0, -0x1(%rbx,%r14)
0000000100011ea8	jmp	0x100011e7b
0000000100011eaa	callq	0x100012c00                     ## symbol stub for: ___stack_chk_fail
0000000100011eaf	nop
_fwp_encode:
0000000100011eb0	pushq	%rbp
0000000100011eb1	movq	%rsp, %rbp
0000000100011eb4	pushq	%r15
0000000100011eb6	pushq	%r14
0000000100011eb8	pushq	%r13
0000000100011eba	pushq	%r12
0000000100011ebc	pushq	%rbx
0000000100011ebd	subq	$0x38, %rsp
0000000100011ec1	movl	(%rdx), %eax
0000000100011ec3	cmpq	$0x15, %rax
0000000100011ec7	ja	0x100012046
0000000100011ecd	movq	%rdx, %r14
0000000100011ed0	movq	%rsi, %rbx
0000000100011ed3	movq	%rdi, -0x38(%rbp)
0000000100011ed7	leaq	0x752(%rip), %rcx
0000000100011ede	movslq	(%rcx,%rax,4), %rax
0000000100011ee2	addq	%rcx, %rax
0000000100011ee5	jmpq	*%rax
0000000100011ee7	movb	%bl, -0x29(%rbp)
0000000100011eea	leaq	-0x29(%rbp), %r14
0000000100011eee	movl	$0x1, %edx
0000000100011ef3	movq	-0x38(%rbp), %r15
0000000100011ef7	movq	%r15, %rdi
0000000100011efa	movq	%r14, %rsi
0000000100011efd	callq	_buf_put
0000000100011f02	movb	%bh, -0x29(%rbp)
0000000100011f05	movl	$0x1, %edx
0000000100011f0a	movq	%r15, %rdi
0000000100011f0d	movq	%r14, %rsi
0000000100011f10	callq	_buf_put
0000000100011f15	movl	%ebx, %eax
0000000100011f17	shrl	$0x10, %eax
0000000100011f1a	movb	%al, -0x29(%rbp)
0000000100011f1d	movl	$0x1, %edx
0000000100011f22	movq	%r15, %rdi
0000000100011f25	movq	%r14, %rsi
0000000100011f28	callq	_buf_put
0000000100011f2d	movl	%ebx, %eax
0000000100011f2f	shrl	$0x18, %eax
0000000100011f32	movb	%al, -0x29(%rbp)
0000000100011f35	movl	$0x1, %edx
0000000100011f3a	movq	%r15, %rdi
0000000100011f3d	movq	%r14, %rsi
0000000100011f40	callq	_buf_put
0000000100011f45	movq	%rbx, %rax
0000000100011f48	shrq	$0x20, %rax
0000000100011f4c	movb	%al, -0x29(%rbp)
0000000100011f4f	movl	$0x1, %edx
0000000100011f54	movq	%r15, %rdi
0000000100011f57	movq	%r14, %rsi
0000000100011f5a	callq	_buf_put
0000000100011f5f	movq	%rbx, %rax
0000000100011f62	shrq	$0x28, %rax
0000000100011f66	movb	%al, -0x29(%rbp)
0000000100011f69	movl	$0x1, %edx
0000000100011f6e	movq	%r15, %rdi
0000000100011f71	movq	%r14, %rsi
0000000100011f74	callq	_buf_put
0000000100011f79	movq	%rbx, %rax
0000000100011f7c	shrq	$0x30, %rax
0000000100011f80	movb	%al, -0x29(%rbp)
0000000100011f83	movl	$0x1, %edx
0000000100011f88	movq	%r15, %rdi
0000000100011f8b	movq	%r14, %rsi
0000000100011f8e	callq	_buf_put
0000000100011f93	shrq	$0x38, %rbx
0000000100011f97	jmp	0x100011ff7
0000000100011f99	movb	%bl, -0x29(%rbp)
0000000100011f9c	leaq	-0x29(%rbp), %rsi
0000000100011fa0	movl	$0x1, %edx
0000000100011fa5	movq	-0x38(%rbp), %rdi
0000000100011fa9	jmp	0x100012041
0000000100011fae	movb	%bl, -0x29(%rbp)
0000000100011fb1	leaq	-0x29(%rbp), %r14
0000000100011fb5	movl	$0x1, %edx
0000000100011fba	movq	-0x38(%rbp), %r15
0000000100011fbe	movq	%r15, %rdi
0000000100011fc1	movq	%r14, %rsi
0000000100011fc4	callq	_buf_put
0000000100011fc9	movb	%bh, -0x29(%rbp)
0000000100011fcc	movl	$0x1, %edx
0000000100011fd1	movq	%r15, %rdi
0000000100011fd4	movq	%r14, %rsi
0000000100011fd7	callq	_buf_put
0000000100011fdc	movl	%ebx, %eax
0000000100011fde	shrl	$0x10, %eax
0000000100011fe1	movb	%al, -0x29(%rbp)
0000000100011fe4	movl	$0x1, %edx
0000000100011fe9	movq	%r15, %rdi
0000000100011fec	movq	%r14, %rsi
0000000100011fef	callq	_buf_put
0000000100011ff4	shrl	$0x18, %ebx
0000000100011ff7	movb	%bl, -0x29(%rbp)
0000000100011ffa	jmp	0x100012036
0000000100011ffc	movq	(%rbx), %r15
0000000100011fff	cmpq	$0x80, %r15
0000000100012006	jae	0x100012238
000000010001200c	movq	%r15, %r13
000000010001200f	movq	-0x38(%rbp), %r12
0000000100012013	jmp	0x100012278
0000000100012018	movb	%bl, -0x29(%rbp)
000000010001201b	leaq	-0x29(%rbp), %r14
000000010001201f	movl	$0x1, %edx
0000000100012024	movq	-0x38(%rbp), %r15
0000000100012028	movq	%r15, %rdi
000000010001202b	movq	%r14, %rsi
000000010001202e	callq	_buf_put
0000000100012033	movb	%bh, -0x29(%rbp)
0000000100012036	movl	$0x1, %edx
000000010001203b	movq	%r15, %rdi
000000010001203e	movq	%r14, %rsi
0000000100012041	callq	_buf_put
0000000100012046	addq	$0x38, %rsp
000000010001204a	popq	%rbx
000000010001204b	popq	%r12
000000010001204d	popq	%r13
000000010001204f	popq	%r14
0000000100012051	popq	%r15
0000000100012053	popq	%rbp
0000000100012054	retq
0000000100012055	movq	(%rbx), %rax
0000000100012058	movq	0x8(%rbx), %r13
000000010001205c	movb	%al, -0x29(%rbp)
000000010001205f	movq	%rax, %rbx
0000000100012062	leaq	-0x29(%rbp), %r14
0000000100012066	movl	$0x1, %edx
000000010001206b	movq	-0x38(%rbp), %r12
000000010001206f	movq	%r12, %rdi
0000000100012072	movq	%r14, %rsi
0000000100012075	callq	_buf_put
000000010001207a	movb	%bh, -0x29(%rbp)
000000010001207d	movl	$0x1, %edx
0000000100012082	movq	%r12, %rdi
0000000100012085	movq	%r14, %rsi
0000000100012088	callq	_buf_put
000000010001208d	movl	%r13d, %eax
0000000100012090	shrl	$0x10, %eax
0000000100012093	movl	%eax, -0x40(%rbp)
0000000100012096	movl	%ebx, %eax
0000000100012098	shrl	$0x10, %eax
000000010001209b	movb	%al, -0x29(%rbp)
000000010001209e	movl	$0x1, %edx
00000001000120a3	movq	%r12, %rdi
00000001000120a6	movq	%r14, %rsi
00000001000120a9	callq	_buf_put
00000001000120ae	movl	%r13d, %eax
00000001000120b1	shrl	$0x18, %eax
00000001000120b4	movl	%eax, -0x44(%rbp)
00000001000120b7	movl	%ebx, %eax
00000001000120b9	shrl	$0x18, %eax
00000001000120bc	movb	%al, -0x29(%rbp)
00000001000120bf	movl	$0x1, %edx
00000001000120c4	movq	%r12, %rdi
00000001000120c7	movq	%r14, %rsi
00000001000120ca	callq	_buf_put
00000001000120cf	movq	%r13, %rax
00000001000120d2	shrq	$0x20, %rax
00000001000120d6	movq	%rax, -0x60(%rbp)
00000001000120da	movq	%rbx, %rax
00000001000120dd	shrq	$0x20, %rax
00000001000120e1	movb	%al, -0x29(%rbp)
00000001000120e4	movl	$0x1, %edx
00000001000120e9	movq	%r12, %rdi
00000001000120ec	movq	%r14, %rsi
00000001000120ef	callq	_buf_put
00000001000120f4	movq	%r13, %rax
00000001000120f7	shrq	$0x28, %rax
00000001000120fb	movq	%rax, -0x58(%rbp)
00000001000120ff	movq	%rbx, %rax
0000000100012102	shrq	$0x28, %rax
0000000100012106	movb	%al, -0x29(%rbp)
0000000100012109	movl	$0x1, %edx
000000010001210e	movq	%r12, %rdi
0000000100012111	movq	%r14, %rsi
0000000100012114	callq	_buf_put
0000000100012119	movq	%r13, %rax
000000010001211c	shrq	$0x30, %rax
0000000100012120	movq	%rax, -0x50(%rbp)
0000000100012124	movq	%rbx, %rax
0000000100012127	shrq	$0x30, %rax
000000010001212b	movb	%al, -0x29(%rbp)
000000010001212e	movl	$0x1, %edx
0000000100012133	movq	%r12, %rdi
0000000100012136	movq	%r14, %rsi
0000000100012139	callq	_buf_put
000000010001213e	movq	%r13, %r15
0000000100012141	shrq	$0x38, %r15
0000000100012145	shrq	$0x38, %rbx
0000000100012149	movb	%bl, -0x29(%rbp)
000000010001214c	movl	$0x1, %edx
0000000100012151	movq	%r12, %rdi
0000000100012154	movq	%r14, %rsi
0000000100012157	callq	_buf_put
000000010001215c	movb	%r13b, -0x29(%rbp)
0000000100012160	movq	%r13, %rbx
0000000100012163	movl	$0x1, %edx
0000000100012168	movq	%r12, %rdi
000000010001216b	movq	%r14, %rsi
000000010001216e	callq	_buf_put
0000000100012173	movb	%bh, -0x29(%rbp)
0000000100012176	movl	$0x1, %edx
000000010001217b	movq	%r12, %rdi
000000010001217e	movq	%r14, %rsi
0000000100012181	callq	_buf_put
0000000100012186	movl	-0x40(%rbp), %eax
0000000100012189	movb	%al, -0x29(%rbp)
000000010001218c	movl	$0x1, %edx
0000000100012191	movq	%r12, %rdi
0000000100012194	movq	%r14, %rsi
0000000100012197	callq	_buf_put
000000010001219c	movl	-0x44(%rbp), %eax
000000010001219f	movb	%al, -0x29(%rbp)
00000001000121a2	movl	$0x1, %edx
00000001000121a7	movq	%r12, %rdi
00000001000121aa	movq	%r14, %rsi
00000001000121ad	callq	_buf_put
00000001000121b2	movq	-0x60(%rbp), %rax
00000001000121b6	movb	%al, -0x29(%rbp)
00000001000121b9	movl	$0x1, %edx
00000001000121be	movq	%r12, %rdi
00000001000121c1	movq	%r14, %rsi
00000001000121c4	callq	_buf_put
00000001000121c9	movq	-0x58(%rbp), %rax
00000001000121cd	movb	%al, -0x29(%rbp)
00000001000121d0	movl	$0x1, %edx
00000001000121d5	movq	%r12, %rdi
00000001000121d8	movq	%r14, %rsi
00000001000121db	callq	_buf_put
00000001000121e0	movq	-0x50(%rbp), %rax
00000001000121e4	movb	%al, -0x29(%rbp)
00000001000121e7	movl	$0x1, %edx
00000001000121ec	movq	%r12, %rdi
00000001000121ef	movq	%r14, %rsi
00000001000121f2	callq	_buf_put
00000001000121f7	movb	%r15b, -0x29(%rbp)
00000001000121fb	movl	$0x1, %edx
0000000100012200	movq	%r12, %rdi
0000000100012203	jmp	0x10001203e
0000000100012208	movq	(%rbx), %r15
000000010001220b	cmpq	$0x80, %r15
0000000100012212	jae	0x1000122e1
0000000100012218	movq	%r15, %r13
000000010001221b	movq	-0x38(%rbp), %r12
000000010001221f	jmp	0x100012319
0000000100012224	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010001222b	ja	0x1000123ef
0000000100012231	movl	%ebx, %eax
0000000100012233	jmp	0x1000123f1
0000000100012238	leaq	-0x29(%rbp), %r14
000000010001223c	movq	%r15, %r13
000000010001223f	movq	-0x38(%rbp), %r12
0000000100012243	nopw	%cs:(%rax,%rax)
0000000100012250	shrq	$0x7, %r13
0000000100012254	movl	%r15d, %eax
0000000100012257	orb	$-0x80, %al
0000000100012259	movb	%al, -0x29(%rbp)
000000010001225c	movl	$0x1, %edx
0000000100012261	movq	%r12, %rdi
0000000100012264	movq	%r14, %rsi
0000000100012267	callq	_buf_put
000000010001226c	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
0000000100012273	movq	%r13, %r15
0000000100012276	ja	0x100012250
0000000100012278	movb	%r13b, -0x29(%rbp)
000000010001227c	leaq	-0x29(%rbp), %rsi
0000000100012280	movl	$0x1, %edx
0000000100012285	movq	%r12, %rdi
0000000100012288	callq	_buf_put
000000010001228d	movq	(%rbx), %rdx
0000000100012290	addq	$0x8, %rbx
0000000100012294	movq	%r12, %rdi
0000000100012297	movq	%rbx, %rsi
000000010001229a	addq	$0x38, %rsp
000000010001229e	popq	%rbx
000000010001229f	popq	%r12
00000001000122a1	popq	%r13
00000001000122a3	popq	%r14
00000001000122a5	popq	%r15
00000001000122a7	popq	%rbp
00000001000122a8	jmp	_buf_put
00000001000122ad	testq	%rbx, %rbx
00000001000122b0	je	0x1000125ae
00000001000122b6	xorl	%r13d, %r13d
00000001000122b9	movq	%rbx, %rax
00000001000122bc	movq	-0x38(%rbp), %r12
00000001000122c0	incq	%r13
00000001000122c3	movq	0x10(%rax), %rax
00000001000122c7	testq	%rax, %rax
00000001000122ca	jne	0x1000122c0
00000001000122cc	cmpq	$0x80, %r13
00000001000122d3	jae	0x1000125b7
00000001000122d9	movq	%r13, %r15
00000001000122dc	jmp	0x1000125e9
00000001000122e1	movq	%r15, %r13
00000001000122e4	movq	-0x38(%rbp), %r12
00000001000122e8	nopl	(%rax,%rax)
00000001000122f0	shrq	$0x7, %r13
00000001000122f4	movl	%r15d, %eax
00000001000122f7	orb	$-0x80, %al
00000001000122f9	movb	%al, -0x29(%rbp)
00000001000122fc	movl	$0x1, %edx
0000000100012301	movq	%r12, %rdi
0000000100012304	leaq	-0x29(%rbp), %rsi
0000000100012308	callq	_buf_put
000000010001230d	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
0000000100012314	movq	%r13, %r15
0000000100012317	ja	0x1000122f0
0000000100012319	movb	%r13b, -0x29(%rbp)
000000010001231d	leaq	-0x29(%rbp), %rsi
0000000100012321	movl	$0x1, %edx
0000000100012326	movq	%r12, %rdi
0000000100012329	callq	_buf_put
000000010001232e	cmpq	$0x0, (%rbx)
0000000100012332	je	0x100012046
0000000100012338	leaq	0x10(%rbx), %r15
000000010001233c	xorl	%r13d, %r13d
000000010001233f	jmp	0x100012360
0000000100012341	nopw	%cs:(%rax,%rax)
0000000100012350	incq	%r13
0000000100012353	addq	$0x10, %r15
0000000100012357	cmpq	(%rbx), %r13
000000010001235a	jae	0x100012046
0000000100012360	movq	-0x8(%r15), %rsi
0000000100012364	movq	0x38(%r14), %rdx
0000000100012368	movq	%r12, %rdi
000000010001236b	callq	_fwp_encode
0000000100012370	cmpl	$0x12, (%r14)
0000000100012374	jne	0x100012350
0000000100012376	movq	(%r15), %rsi
0000000100012379	movq	0x40(%r14), %rdx
000000010001237d	movq	%r12, %rdi
0000000100012380	callq	_fwp_encode
0000000100012385	jmp	0x100012350
0000000100012387	cmpl	$0x0, 0x10(%r14)
000000010001238c	movq	-0x38(%rbp), %r12
0000000100012390	jle	0x100012046
0000000100012396	xorl	%r15d, %r15d
0000000100012399	nopl	(%rax)
00000001000123a0	movq	0x8(%rbx,%r15,8), %rsi
00000001000123a5	movq	0x20(%r14), %rax
00000001000123a9	movq	(%rax,%r15,8), %rdx
00000001000123ad	movq	%r12, %rdi
00000001000123b0	callq	_fwp_encode
00000001000123b5	incq	%r15
00000001000123b8	movslq	0x10(%r14), %rax
00000001000123bc	cmpq	%rax, %r15
00000001000123bf	jl	0x1000123a0
00000001000123c1	jmp	0x100012046
00000001000123c6	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000123d0	movq	(%rbx), %r15
00000001000123d3	andq	%rax, %r15
00000001000123d6	cmpq	$0x80, %r15
00000001000123dd	jae	0x10001249e
00000001000123e3	movq	%r15, %r13
00000001000123e6	movq	-0x38(%rbp), %r12
00000001000123ea	jmp	0x1000124d9
00000001000123ef	movl	(%rbx), %eax
00000001000123f1	movl	%eax, %r13d
00000001000123f4	movq	%r13, -0x40(%rbp)
00000001000123f8	cmpl	$0x80, %eax
00000001000123fd	movq	-0x38(%rbp), %r12
0000000100012401	jb	0x100012439
0000000100012403	movq	-0x40(%rbp), %r15
0000000100012407	movq	%r15, %r13
000000010001240a	nopw	(%rax,%rax)
0000000100012410	shrq	$0x7, %r13
0000000100012414	movl	%r15d, %eax
0000000100012417	orb	$-0x80, %al
0000000100012419	movb	%al, -0x29(%rbp)
000000010001241c	movl	$0x1, %edx
0000000100012421	movq	%r12, %rdi
0000000100012424	leaq	-0x29(%rbp), %rsi
0000000100012428	callq	_buf_put
000000010001242d	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
0000000100012434	movq	%r13, %r15
0000000100012437	ja	0x100012410
0000000100012439	movb	%r13b, -0x29(%rbp)
000000010001243d	leaq	-0x29(%rbp), %rsi
0000000100012441	movl	$0x1, %edx
0000000100012446	movq	%r12, %r15
0000000100012449	movq	%r12, %rdi
000000010001244c	callq	_buf_put
0000000100012451	movq	0x28(%r14), %rax
0000000100012455	movq	-0x40(%rbp), %r12
0000000100012459	cmpl	$0x0, (%rax,%r12,4)
000000010001245e	jle	0x100012046
0000000100012464	xorl	%r13d, %r13d
0000000100012467	nopw	(%rax,%rax)
0000000100012470	movq	0x8(%rbx,%r13,8), %rsi
0000000100012475	movq	0x30(%r14), %rax
0000000100012479	movq	(%rax,%r12,8), %rax
000000010001247d	movq	(%rax,%r13,8), %rdx
0000000100012481	movq	%r15, %rdi
0000000100012484	callq	_fwp_encode
0000000100012489	incq	%r13
000000010001248c	movq	0x28(%r14), %rax
0000000100012490	movslq	(%rax,%r12,4), %rax
0000000100012494	cmpq	%rax, %r13
0000000100012497	jl	0x100012470
0000000100012499	jmp	0x100012046
000000010001249e	movq	%r15, %r13
00000001000124a1	movq	-0x38(%rbp), %r12
00000001000124a5	nopw	%cs:(%rax,%rax)
00000001000124b0	shrq	$0x7, %r13
00000001000124b4	movl	%r15d, %eax
00000001000124b7	orb	$-0x80, %al
00000001000124b9	movb	%al, -0x29(%rbp)
00000001000124bc	movl	$0x1, %edx
00000001000124c1	movq	%r12, %rdi
00000001000124c4	leaq	-0x29(%rbp), %rsi
00000001000124c8	callq	_buf_put
00000001000124cd	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
00000001000124d4	movq	%r13, %r15
00000001000124d7	ja	0x1000124b0
00000001000124d9	movb	%r13b, -0x29(%rbp)
00000001000124dd	leaq	-0x29(%rbp), %rsi
00000001000124e1	movl	$0x1, %edx
00000001000124e6	movq	%r12, %rdi
00000001000124e9	callq	_buf_put
00000001000124ee	movq	(%rbx), %rax
00000001000124f1	movabsq	$0x7fffffffffffffff, %r12       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000124fb	testq	%r12, %rax
00000001000124fe	je	0x100012046
0000000100012504	leaq	0x8(%rbx), %r15
0000000100012508	xorl	%r13d, %r13d
000000010001250b	jmp	0x100012539
000000010001250d	nopl	(%rax)
0000000100012510	cmpl	$0x1, (%rdx)
0000000100012513	movzwl	(%rsi,%rax), %eax
0000000100012517	movswq	%ax, %rsi
000000010001251b	cmovneq	%rax, %rsi
000000010001251f	callq	_fwp_encode
0000000100012524	incq	%r13
0000000100012527	movq	(%rbx), %rax
000000010001252a	movq	%rax, %rcx
000000010001252d	andq	%r12, %rcx
0000000100012530	cmpq	%rcx, %r13
0000000100012533	jae	0x100012046
0000000100012539	movq	0x38(%r14), %rdx
000000010001253d	movl	$0x8, %ecx
0000000100012542	testq	%rdx, %rdx
0000000100012545	je	0x100012560
0000000100012547	movl	(%rdx), %esi
0000000100012549	cmpq	$0xa, %rsi
000000010001254d	movq	-0x38(%rbp), %rdi
0000000100012551	ja	0x100012564
0000000100012553	leaq	0xbfe(%rip), %rcx
000000010001255a	movq	(%rcx,%rsi,8), %rcx
000000010001255e	jmp	0x100012564
0000000100012560	movq	-0x38(%rbp), %rdi
0000000100012564	movq	%r15, %rsi
0000000100012567	testq	%rax, %rax
000000010001256a	jns	0x100012570
000000010001256c	movq	0x10(%rbx), %rsi
0000000100012570	movq	%rcx, %rax
0000000100012573	imulq	%r13, %rax
0000000100012577	cmpq	$0x1, %rcx
000000010001257b	je	0x100012590
000000010001257d	cmpq	$0x2, %rcx
0000000100012581	je	0x100012510
0000000100012583	cmpq	$0x8, %rcx
0000000100012587	jne	0x1000125a0
0000000100012589	movq	(%rsi,%rax), %rsi
000000010001258d	jmp	0x10001251f
000000010001258f	nop
0000000100012590	cmpl	$0x0, (%rdx)
0000000100012593	movzbl	(%rsi,%rax), %eax
0000000100012597	movsbq	%al, %rsi
000000010001259b	jmp	0x10001251b
00000001000125a0	cmpl	$0x2, (%rdx)
00000001000125a3	movl	(%rsi,%rax), %eax
00000001000125a6	movslq	%eax, %rsi
00000001000125a9	jmp	0x10001251b
00000001000125ae	movb	$0x0, -0x29(%rbp)
00000001000125b2	jmp	0x100011f9c
00000001000125b7	movq	%r13, %r15
00000001000125ba	nopw	(%rax,%rax)
00000001000125c0	shrq	$0x7, %r15
00000001000125c4	movl	%r13d, %eax
00000001000125c7	orb	$-0x80, %al
00000001000125c9	movb	%al, -0x29(%rbp)
00000001000125cc	movl	$0x1, %edx
00000001000125d1	movq	%r12, %rdi
00000001000125d4	leaq	-0x29(%rbp), %rsi
00000001000125d8	callq	_buf_put
00000001000125dd	cmpq	$0x3fff, %r13                   ## imm = 0x3FFF
00000001000125e4	movq	%r15, %r13
00000001000125e7	ja	0x1000125c0
00000001000125e9	movb	%r15b, -0x29(%rbp)
00000001000125ed	leaq	-0x29(%rbp), %rsi
00000001000125f1	movl	$0x1, %edx
00000001000125f6	movq	%r12, %rdi
00000001000125f9	callq	_buf_put
00000001000125fe	testq	%rbx, %rbx
0000000100012601	je	0x100012046
0000000100012607	nopw	(%rax,%rax)
0000000100012610	movq	0x8(%rbx), %rsi
0000000100012614	movq	0x38(%r14), %rdx
0000000100012618	movq	%r12, %rdi
000000010001261b	callq	_fwp_encode
0000000100012620	movq	0x10(%rbx), %rbx
0000000100012624	testq	%rbx, %rbx
0000000100012627	jne	0x100012610
0000000100012629	jmp	0x100012046
000000010001262e	nop
0000000100012630	imull	$0xf9e8ffff, %ecx, %edi         ## imm = 0xF9E8FFFF
0000000100012636	.byte 0xff #bad opcode
0000000100012637	.byte 0xff #bad opcode
0000000100012638	jle	0x100012633
000000010001263a	.byte 0xff #bad opcode
000000010001263b	pushq	0x25fffff8(%rdi)
0000000100012641	cli
0000000100012642	.byte 0xff #bad opcode
0000000100012643	ljmpl	*-0x7(%rcx)
0000000100012646	.byte 0xff #bad opcode
0000000100012647	.byte 0xff #bad opcode
0000000100012648	callq	0x17f012646
000000010001264d	stc
000000010001264e	.byte 0xff #bad opcode
000000010001264f	pushq	0x25fffff8(%rdi)
0000000100012655	cli
0000000100012656	.byte 0xff #bad opcode
0000000100012657	.byte 0xff #bad opcode
0000000100012658	jle	0x100012653
000000010001265a	.byte 0xff #bad opcode
000000010001265b	pushq	-0x33000008(%rdi)
0000000100012661	stc
0000000100012662	.byte 0xff #bad opcode
0000000100012663	decl	%esp
0000000100012665	stc
0000000100012666	.byte 0xff #bad opcode
0000000100012667	pushq	%rsp
0000000100012669	sti
000000010001266a	.byte 0xff #bad opcode
000000010001266b	.byte 0xff #bad opcode
000000010001266c	jge	0x10001266a
000000010001266e	.byte 0xff #bad opcode
000000010001266f	callq	*-0x3(%rdi)
0000000100012672	.byte 0xff #bad opcode
0000000100012673	callq	*-0x27000003(%rsi)
0000000100012679	sti
000000010001267a	.byte 0xff #bad opcode
000000010001267b	.byte 0xff #bad opcode
000000010001267c	fdivr	%st(3), %st
000000010001267e	.byte 0xff #bad opcode
000000010001267f	pushq	0x69fffff8(%rdi)
0000000100012685	stc
0000000100012686	.byte 0xff #bad opcode
0000000100012687	decl	(%rdi)
0000000100012689	.byte 0x1f #bad opcode
000000010001268a	testb	%al, (%rax)
000000010001268c	addb	%al, (%rax)
000000010001268e	addb	%al, (%rax)
_rd_leb:
0000000100012690	movq	$0x0, (%rsi)
0000000100012697	movq	0x8(%rdi), %r8
000000010001269b	movq	0x10(%rdi), %rdx
000000010001269f	cmpq	%rdx, %r8
00000001000126a2	jne	0x1000126a7
00000001000126a4	xorl	%eax, %eax
00000001000126a6	retq
00000001000126a7	pushq	%rbp
00000001000126a8	movq	%rsp, %rbp
00000001000126ab	movq	(%rdi), %rcx
00000001000126ae	leaq	0x1(%rdx), %r9
00000001000126b2	movq	%r9, 0x10(%rdi)
00000001000126b6	movzbl	(%rcx,%rdx), %r10d
00000001000126bb	andl	$0x7f, %r10d
00000001000126bf	movq	%r10, (%rsi)
00000001000126c2	movl	$0x1, %eax
00000001000126c7	cmpb	$0x0, (%rcx,%rdx)
00000001000126cb	js	0x1000126cf
00000001000126cd	popq	%rbp
00000001000126ce	retq
00000001000126cf	cmpq	%r9, %r8
00000001000126d2	jne	0x1000126d8
00000001000126d4	xorl	%eax, %eax
00000001000126d6	popq	%rbp
00000001000126d7	retq
00000001000126d8	leaq	0x2(%rdx), %r11
00000001000126dc	movq	%r11, 0x10(%rdi)
00000001000126e0	movzbl	0x1(%rcx,%rdx), %r9d
00000001000126e6	andl	$0x7f, %r9d
00000001000126ea	shll	$0x7, %r9d
00000001000126ee	orq	%r10, %r9
00000001000126f1	movq	%r9, (%rsi)
00000001000126f4	cmpb	$0x0, 0x1(%rcx,%rdx)
00000001000126f9	jns	0x1000126cd
00000001000126fb	cmpq	%r11, %r8
00000001000126fe	je	0x1000126d4
0000000100012700	leaq	0x3(%rdx), %r11
0000000100012704	movq	%r11, 0x10(%rdi)
0000000100012708	movzbl	0x2(%rcx,%rdx), %r10d
000000010001270e	andl	$0x7f, %r10d
0000000100012712	shll	$0xe, %r10d
0000000100012716	orq	%r9, %r10
0000000100012719	movq	%r10, (%rsi)
000000010001271c	cmpb	$0x0, 0x2(%rcx,%rdx)
0000000100012721	jns	0x1000126cd
0000000100012723	cmpq	%r11, %r8
0000000100012726	je	0x1000126d4
0000000100012728	leaq	0x4(%rdx), %r11
000000010001272c	movq	%r11, 0x10(%rdi)
0000000100012730	movzbl	0x3(%rcx,%rdx), %r9d
0000000100012736	andl	$0x7f, %r9d
000000010001273a	shll	$0x15, %r9d
000000010001273e	orq	%r10, %r9
0000000100012741	movq	%r9, (%rsi)
0000000100012744	cmpb	$0x0, 0x3(%rcx,%rdx)
0000000100012749	jns	0x1000126cd
000000010001274b	cmpq	%r11, %r8
000000010001274e	je	0x1000126d4
0000000100012750	leaq	0x5(%rdx), %r11
0000000100012754	movq	%r11, 0x10(%rdi)
0000000100012758	movzbl	0x4(%rcx,%rdx), %r10d
000000010001275e	andl	$0x7f, %r10d
0000000100012762	shlq	$0x1c, %r10
0000000100012766	orq	%r9, %r10
0000000100012769	movq	%r10, (%rsi)
000000010001276c	cmpb	$0x0, 0x4(%rcx,%rdx)
0000000100012771	jns	0x1000126cd
0000000100012777	cmpq	%r11, %r8
000000010001277a	je	0x1000126d4
0000000100012780	leaq	0x6(%rdx), %r11
0000000100012784	movq	%r11, 0x10(%rdi)
0000000100012788	movzbl	0x5(%rcx,%rdx), %r9d
000000010001278e	andl	$0x7f, %r9d
0000000100012792	shlq	$0x23, %r9
0000000100012796	orq	%r10, %r9
0000000100012799	movq	%r9, (%rsi)
000000010001279c	cmpb	$0x0, 0x5(%rcx,%rdx)
00000001000127a1	jns	0x1000126cd
00000001000127a7	cmpq	%r11, %r8
00000001000127aa	je	0x1000126d4
00000001000127b0	leaq	0x7(%rdx), %r11
00000001000127b4	movq	%r11, 0x10(%rdi)
00000001000127b8	movzbl	0x6(%rcx,%rdx), %r10d
00000001000127be	andl	$0x7f, %r10d
00000001000127c2	shlq	$0x2a, %r10
00000001000127c6	orq	%r9, %r10
00000001000127c9	movq	%r10, (%rsi)
00000001000127cc	cmpb	$0x0, 0x6(%rcx,%rdx)
00000001000127d1	jns	0x1000126cd
00000001000127d7	cmpq	%r11, %r8
00000001000127da	je	0x1000126d4
00000001000127e0	leaq	0x8(%rdx), %r9
00000001000127e4	movq	%r9, 0x10(%rdi)
00000001000127e8	movzbl	0x7(%rcx,%rdx), %r11d
00000001000127ee	andl	$0x7f, %r11d
00000001000127f2	shlq	$0x31, %r11
00000001000127f6	orq	%r10, %r11
00000001000127f9	movq	%r11, (%rsi)
00000001000127fc	cmpb	$0x0, 0x7(%rcx,%rdx)
0000000100012801	jns	0x1000126cd
0000000100012807	cmpq	%r9, %r8
000000010001280a	je	0x1000126d4
0000000100012810	leaq	0x9(%rdx), %r9
0000000100012814	movq	%r9, 0x10(%rdi)
0000000100012818	movzbl	0x8(%rcx,%rdx), %r10d
000000010001281e	andl	$0x7f, %r10d
0000000100012822	shlq	$0x38, %r10
0000000100012826	orq	%r11, %r10
0000000100012829	movq	%r10, (%rsi)
000000010001282c	cmpb	$0x0, 0x8(%rcx,%rdx)
0000000100012831	jns	0x1000126cd
0000000100012837	cmpq	%r9, %r8
000000010001283a	je	0x1000126d4
0000000100012840	leaq	0xa(%rdx), %rax
0000000100012844	movq	%rax, 0x10(%rdi)
0000000100012848	movzbl	0x9(%rcx,%rdx), %edx
000000010001284d	movl	$0x0, %eax
0000000100012852	testb	$0x7e, %dl
0000000100012855	jne	0x1000126cd
000000010001285b	shlq	$0x3f, %rdx
000000010001285f	orq	%r10, %rdx
0000000100012862	movq	%rdx, (%rsi)
0000000100012865	xorl	%eax, %eax
0000000100012867	cmpb	$0x0, (%rcx,%r9)
000000010001286c	setns	%al
000000010001286f	popq	%rbp
0000000100012870	retq
0000000100012871	nopw	%cs:(%rax,%rax)
_fwp_wire_empty_inner:
0000000100012880	xorl	%eax, %eax
0000000100012882	testq	%rdi, %rdi
0000000100012885	je	0x10001292c
000000010001288b	cmpl	$0x10, (%rdi)
000000010001288e	jne	0x10001292c
0000000100012894	pushq	%rbp
0000000100012895	movq	%rsp, %rbp
0000000100012898	pushq	%r15
000000010001289a	pushq	%r14
000000010001289c	pushq	%r12
000000010001289e	pushq	%rbx
000000010001289f	subq	$0x10, %rsp
00000001000128a3	testq	%rsi, %rsi
00000001000128a6	je	0x1000128be
00000001000128a8	movq	%rsi, %rcx
00000001000128ab	nopl	(%rax,%rax)
00000001000128b0	cmpq	%rdi, (%rcx)
00000001000128b3	je	0x100012920
00000001000128b5	movq	0x8(%rcx), %rcx
00000001000128b9	testq	%rcx, %rcx
00000001000128bc	jne	0x1000128b0
00000001000128be	movq	%rdi, -0x30(%rbp)
00000001000128c2	movq	%rsi, -0x28(%rbp)
00000001000128c6	movslq	0x10(%rdi), %r14
00000001000128ca	testq	%r14, %r14
00000001000128cd	jle	0x100012917
00000001000128cf	movq	0x20(%rdi), %r15
00000001000128d3	movq	(%r15), %rdi
00000001000128d6	leaq	-0x30(%rbp), %rsi
00000001000128da	callq	_fwp_wire_empty_inner
00000001000128df	testl	%eax, %eax
00000001000128e1	je	0x10001291e
00000001000128e3	movl	$0x1, %ecx
00000001000128e8	leaq	-0x30(%rbp), %rbx
00000001000128ec	nopl	(%rax)
00000001000128f0	movq	%rcx, %r12
00000001000128f3	cmpq	%rcx, %r14
00000001000128f6	je	0x10001290d
00000001000128f8	movq	(%r15,%r12,8), %rdi
00000001000128fc	movq	%rbx, %rsi
00000001000128ff	callq	_fwp_wire_empty_inner
0000000100012904	leaq	0x1(%r12), %rcx
0000000100012909	testl	%eax, %eax
000000010001290b	jne	0x1000128f0
000000010001290d	xorl	%eax, %eax
000000010001290f	cmpq	%r14, %r12
0000000100012912	setae	%al
0000000100012915	jmp	0x100012920
0000000100012917	movl	$0x1, %eax
000000010001291c	jmp	0x100012920
000000010001291e	xorl	%eax, %eax
0000000100012920	addq	$0x10, %rsp
0000000100012924	popq	%rbx
0000000100012925	popq	%r12
0000000100012927	popq	%r14
0000000100012929	popq	%r15
000000010001292b	popq	%rbp
000000010001292c	retq
000000010001292d	nopl	(%rax)
_fwp_gc_report:
0000000100012930	pushq	%rbp
0000000100012931	movq	%rsp, %rbp
0000000100012934	pushq	%r15
0000000100012936	pushq	%r14
0000000100012938	pushq	%r13
000000010001293a	pushq	%r12
000000010001293c	pushq	%rbx
000000010001293d	subq	$0xb8, %rsp
0000000100012944	movq	0x48cd(%rip), %rax
000000010001294b	movq	_fwp_gc(%rip), %rcx
0000000100012952	subq	%rcx, %rax
0000000100012955	cvtsi2sd	%rax, %xmm0
000000010001295a	addsd	0x488e(%rip), %xmm0
0000000100012962	movsd	%xmm0, -0x50(%rbp)
0000000100012967	movsd	%xmm0, 0x4881(%rip)
000000010001296f	movq	%rcx, 0x48a2(%rip)
0000000100012976	movq	0x26bb(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010001297d	movq	(%rax), %r15
0000000100012980	movq	0x4859(%rip), %rax
0000000100012987	movq	%rax, -0x30(%rbp)
000000010001298b	movq	0x468e(%rip), %r14
0000000100012992	movsd	0x4876(%rip), %xmm0
000000010001299a	movsd	%xmm0, -0x38(%rbp)
000000010001299f	movq	0x46aa(%rip), %r12
00000001000129a6	movq	0x4823(%rip), %r13
00000001000129ad	movq	0x4824(%rip), %rbx
00000001000129b4	movsd	0x483c(%rip), %xmm0
00000001000129bc	movsd	%xmm0, -0x48(%rbp)
00000001000129c1	movsd	0x4837(%rip), %xmm0
00000001000129c9	movsd	%xmm0, -0x40(%rbp)
00000001000129ce	leaq	-0xe0(%rbp), %rsi
00000001000129d5	xorl	%edi, %edi
00000001000129d7	callq	0x100012c8a                     ## symbol stub for: _getrusage
00000001000129dc	movq	$-0x1, %r8
00000001000129e3	testl	%eax, %eax
00000001000129e5	jne	0x100012a00
00000001000129e7	movq	-0xc0(%rbp), %rax
00000001000129ee	leaq	0x3ff(%rax), %r8
00000001000129f5	testq	%rax, %rax
00000001000129f8	cmovnsq	%rax, %r8
00000001000129fc	sarq	$0xa, %r8
0000000100012a00	movq	%rbx, %xmm0
0000000100012a05	movq	0x493(%rip), %xmm1
0000000100012a0d	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100012a11	movapd	0x497(%rip), %xmm2
0000000100012a19	subpd	%xmm2, %xmm0
0000000100012a1d	movapd	%xmm0, %xmm4
0000000100012a21	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100012a25	addsd	%xmm0, %xmm4
0000000100012a29	movsd	0x4e7(%rip), %xmm6
0000000100012a31	mulsd	%xmm6, %xmm4
0000000100012a35	movq	%r13, %xmm5
0000000100012a3a	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100012a3e	subpd	%xmm2, %xmm5
0000000100012a42	movapd	%xmm5, %xmm3
0000000100012a46	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
0000000100012a4a	addsd	%xmm5, %xmm3
0000000100012a4e	mulsd	%xmm6, %xmm3
0000000100012a52	movq	%r12, %xmm5
0000000100012a57	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100012a5b	subpd	%xmm2, %xmm5
0000000100012a5f	movapd	%xmm5, %xmm2
0000000100012a63	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
0000000100012a67	addsd	%xmm5, %xmm2
0000000100012a6b	mulsd	%xmm6, %xmm2
0000000100012a6f	movsd	-0x50(%rbp), %xmm0
0000000100012a74	movsd	-0x38(%rbp), %xmm1
0000000100012a79	addsd	%xmm1, %xmm0
0000000100012a7d	mulsd	%xmm6, %xmm1
0000000100012a81	mulsd	%xmm6, %xmm0
0000000100012a85	cmpl	$0x0, 0x4570(%rip)
0000000100012a8c	leaq	0x1865(%rip), %rax              ## literal pool for: " (collection off)"
0000000100012a93	leaq	0x898(%rip), %r9                ## literal pool for: ""
0000000100012a9a	cmoveq	%rax, %r9
0000000100012a9e	leaq	0x17a4(%rip), %rsi              ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100012aa5	movq	%r15, %rdi
0000000100012aa8	movq	-0x30(%rbp), %rdx
0000000100012aac	movq	%r14, %rcx
0000000100012aaf	movsd	-0x48(%rbp), %xmm5
0000000100012ab4	movsd	-0x40(%rbp), %xmm6
0000000100012ab9	movb	$0x7, %al
0000000100012abb	callq	0x100012c5a                     ## symbol stub for: _fprintf
0000000100012ac0	addq	$0xb8, %rsp
0000000100012ac7	popq	%rbx
0000000100012ac8	popq	%r12
0000000100012aca	popq	%r13
0000000100012acc	popq	%r14
0000000100012ace	popq	%r15
0000000100012ad0	popq	%rbp
0000000100012ad1	retq
0000000100012ad2	nopw	%cs:(%rax,%rax)
_fwp_owner_release38:
0000000100012ae0	pushq	%rbp
0000000100012ae1	movq	%rsp, %rbp
0000000100012ae4	movq	(%rdi), %rdi
0000000100012ae7	popq	%rbp
0000000100012ae8	jmp	_fwp_drop2
0000000100012aed	nopl	(%rax)
_fwp_owner_release39:
0000000100012af0	pushq	%rbp
0000000100012af1	movq	%rsp, %rbp
0000000100012af4	movq	(%rdi), %rdi
0000000100012af7	popq	%rbp
0000000100012af8	jmp	_fwp_drop2
0000000100012afd	nopl	(%rax)
_fwp_owner_release42:
0000000100012b00	pushq	%rbp
0000000100012b01	movq	%rsp, %rbp
0000000100012b04	movq	(%rdi), %rdi
0000000100012b07	popq	%rbp
0000000100012b08	jmp	_fwp_drop2
0000000100012b0d	nopl	(%rax)
_fwp_main_thread.cold.1:
0000000100012b10	pushq	%rbp
0000000100012b11	movq	%rsp, %rbp
0000000100012b14	pushq	$0x8
0000000100012b16	popq	%rdi
0000000100012b17	pushq	$0x2
0000000100012b19	popq	%rsi
0000000100012b1a	callq	_fwp_gc_alloc_slow
0000000100012b1f	popq	%rbp
0000000100012b20	retq
0000000100012b21	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.2:
0000000100012b30	pushq	%rbp
0000000100012b31	movq	%rsp, %rbp
0000000100012b34	pushq	$0x1
0000000100012b36	popq	%rdi
0000000100012b37	pushq	$0x1
0000000100012b39	popq	%rsi
0000000100012b3a	callq	_fwp_gc_alloc_slow
0000000100012b3f	popq	%rbp
0000000100012b40	retq
0000000100012b41	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr.cold.1:
0000000100012b50	pushq	%rbp
0000000100012b51	movq	%rsp, %rbp
0000000100012b54	pushq	%rbx
0000000100012b55	pushq	%rax
0000000100012b56	movq	%rdi, %rbx
0000000100012b59	leaq	0x932(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100012b60	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100012b65	testq	%rax, %rax
0000000100012b68	je	0x100012b81
0000000100012b6a	movzbl	(%rax), %ecx
0000000100012b6d	testl	%ecx, %ecx
0000000100012b6f	je	0x100012b88
0000000100012b71	cmpl	$0x30, %ecx
0000000100012b74	jne	0x100012b85
0000000100012b76	xorl	%ecx, %ecx
0000000100012b78	cmpb	$0x0, 0x1(%rax)
0000000100012b7c	setne	%cl
0000000100012b7f	jmp	0x100012b88
0000000100012b81	xorl	%ecx, %ecx
0000000100012b83	jmp	0x100012b88
0000000100012b85	pushq	$0x1
0000000100012b87	popq	%rcx
0000000100012b88	movl	%ecx, (%rbx)
0000000100012b8a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100012b90	addq	$0x8, %rsp
0000000100012b94	popq	%rbx
0000000100012b95	popq	%rbp
0000000100012b96	retq
0000000100012b97	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
0000000100012ba0	pushq	%rbp
0000000100012ba1	movq	%rsp, %rbp
0000000100012ba4	pushq	%rbx
0000000100012ba5	pushq	%rax
0000000100012ba6	movq	%rdi, %rbx
0000000100012ba9	leaq	0x8e2(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100012bb0	callq	0x100012c7e                     ## symbol stub for: _getenv
0000000100012bb5	testq	%rax, %rax
0000000100012bb8	je	0x100012bd1
0000000100012bba	movzbl	(%rax), %ecx
0000000100012bbd	testl	%ecx, %ecx
0000000100012bbf	je	0x100012bd8
0000000100012bc1	cmpl	$0x30, %ecx
0000000100012bc4	jne	0x100012bd5
0000000100012bc6	xorl	%ecx, %ecx
0000000100012bc8	cmpb	$0x0, 0x1(%rax)
0000000100012bcc	setne	%cl
0000000100012bcf	jmp	0x100012bd8
0000000100012bd1	xorl	%ecx, %ecx
0000000100012bd3	jmp	0x100012bd8
0000000100012bd5	pushq	$0x1
0000000100012bd7	popq	%rcx
0000000100012bd8	movl	%ecx, (%rbx)
0000000100012bda	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100012be0	addq	$0x8, %rsp
0000000100012be4	popq	%rbx
0000000100012be5	popq	%rbp
0000000100012be6	retq
