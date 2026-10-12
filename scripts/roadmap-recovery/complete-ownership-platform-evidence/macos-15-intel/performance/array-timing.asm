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
00000001000006eb	movq	0x1293e(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000006f2	movq	(%rax), %rax
00000001000006f5	movq	%rax, -0x18(%rbp)
00000001000006f9	leaq	_fwp_fn_table(%rip), %rax
0000000100000700	movq	%rax, _fwp_fns(%rip)
0000000100000707	movq	0x1293a(%rip), %r14             ## literal pool symbol address: ___stdoutp
000000010000070e	movq	(%r14), %rax
0000000100000711	movq	%rax, _fwp_prog_out(%rip)
0000000100000718	movl	%edi, _fwp_argc(%rip)
000000010000071e	movq	%rsi, _fwp_argv(%rip)
0000000100000725	leaq	_fwp_start_time(%rip), %rsi
000000010000072c	movl	$0x6, %edi
0000000100000731	callq	0x100011472                     ## symbol stub for: _clock_gettime
0000000100000736	leaq	0x116ec(%rip), %rdi             ## literal pool for: "FWP_SEED"
000000010000073d	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100000742	testq	%rax, %rax
0000000100000745	je	0x10000076d
0000000100000747	movq	%rax, %rbx
000000010000074a	cmpb	$0x0, (%rax)
000000010000074d	je	0x10000076d
000000010000074f	leaq	-0x68(%rbp), %rsi
0000000100000753	movq	%rbx, %rdi
0000000100000756	movl	$0xa, %edx
000000010000075b	callq	0x10001157a                     ## symbol stub for: _strtoull
0000000100000760	movq	-0x68(%rbp), %rax
0000000100000764	cmpb	$0x0, (%rax)
0000000100000767	je	0x10000083a
000000010000076d	leaq	-0x58(%rbp), %rsi
0000000100000771	xorl	%edi, %edi
0000000100000773	callq	0x100011472                     ## symbol stub for: _clock_gettime
0000000100000778	movq	(%r14), %rdi
000000010000077b	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100000780	xorl	%esi, %esi
0000000100000782	xorl	%edx, %edx
0000000100000784	callq	0x100011526                     ## symbol stub for: _setvbuf
0000000100000789	movl	$0x1, %esi
000000010000078e	movl	$0xd, %edi
0000000100000793	callq	0x100011538                     ## symbol stub for: _signal
0000000100000798	leaq	-0x58(%rbp), %rbx
000000010000079c	movq	%rbx, %rdi
000000010000079f	callq	0x1000114fc                     ## symbol stub for: _pthread_attr_init
00000001000007a4	movq	_fwp_main_stack(%rip), %rsi
00000001000007ab	movq	%rbx, %rdi
00000001000007ae	callq	0x100011502                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007b3	leaq	_fwp_main_thread(%rip), %rdx
00000001000007ba	leaq	-0x70(%rbp), %rdi
00000001000007be	movq	%rbx, %rsi
00000001000007c1	xorl	%ecx, %ecx
00000001000007c3	callq	0x100011508                     ## symbol stub for: _pthread_create
00000001000007c8	testl	%eax, %eax
00000001000007ca	je	0x100000808
00000001000007cc	leaq	-0x68(%rbp), %rsi
00000001000007d0	movl	$0x3, %edi
00000001000007d5	callq	0x1000114b4                     ## symbol stub for: _getrlimit
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
000000010000080e	callq	0x10001150e                     ## symbol stub for: _pthread_join
0000000100000813	movq	(%r14), %rdi
0000000100000816	callq	0x10001147e                     ## symbol stub for: _fflush
000000010000081b	movl	_fwp_exit_code(%rip), %eax
0000000100000821	movq	0x12808(%rip), %rcx             ## literal pool symbol address: ___stack_chk_guard
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
0000000100000854	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100000859	nopl	(%rax)
_fwp_main_thread:
0000000100000860	pushq	%rbp
0000000100000861	movq	%rsp, %rbp
0000000100000864	pushq	%r15
0000000100000866	pushq	%r14
0000000100000868	pushq	%r13
000000010000086a	pushq	%r12
000000010000086c	pushq	%rbx
000000010000086d	subq	$0x178, %rsp                    ## imm = 0x178
0000000100000874	movq	0x127b5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000087b	movq	(%rax), %rax
000000010000087e	movq	%rax, -0x30(%rbp)
0000000100000882	movq	%rbp, %rdi
0000000100000885	callq	_fwp_gc_start
000000010000088a	movq	_fwp_main_stack(%rip), %rax
0000000100000891	leaq	-0x190(%rbp), %rcx
0000000100000898	movq	%rcx, _fwp_main_stack_top(%rip)
000000010000089f	movq	%rax, _fwp_main_stack_size(%rip)
00000001000008a6	leaq	_fwp_stack_guard_init.alt(%rip), %rax
00000001000008ad	movq	%rax, -0x130(%rbp)
00000001000008b4	movq	$0x10000, -0x128(%rbp)          ## imm = 0x10000
00000001000008bf	movl	$0x0, -0x120(%rbp)
00000001000008c9	leaq	-0x130(%rbp), %rdi
00000001000008d0	xorl	%esi, %esi
00000001000008d2	callq	0x100011532                     ## symbol stub for: _sigaltstack
00000001000008d7	testl	%eax, %eax
00000001000008d9	jne	0x10000091f
00000001000008db	leaq	_fwp_segv(%rip), %rax
00000001000008e2	movq	%rax, -0x150(%rbp)
00000001000008e9	movabsq	$0x4100000000, %rax             ## imm = 0x4100000000
00000001000008f3	movq	%rax, -0x148(%rbp)
00000001000008fa	leaq	-0x150(%rbp), %rbx
0000000100000901	movl	$0xb, %edi
0000000100000906	movq	%rbx, %rsi
0000000100000909	xorl	%edx, %edx
000000010000090b	callq	0x10001152c                     ## symbol stub for: _sigaction
0000000100000910	movl	$0xa, %edi
0000000100000915	movq	%rbx, %rsi
0000000100000918	xorl	%edx, %edx
000000010000091a	callq	0x10001152c                     ## symbol stub for: _sigaction
000000010000091f	movdqa	_exec_scripts(%rip), %xmm0
0000000100000927	movdqa	%xmm0, _fwp_cli_scripts(%rip)
000000010000092f	movq	0x12f7a(%rip), %rax
0000000100000936	movq	%rax, 0x15183(%rip)
000000010000093d	movslq	_fwp_argc(%rip), %r15
0000000100000944	leal	-0x1(%r15), %r14d
0000000100000948	movq	_fwp_argv(%rip), %r13
000000010000094f	cmpq	$0x2, %r15
0000000100000953	jl	0x10000098c
0000000100000955	movq	0x8(%r13), %rbx
0000000100000959	leaq	0x11e2b(%rip), %rsi             ## literal pool for: "--man"
0000000100000960	movq	%rbx, %rdi
0000000100000963	callq	0x100011550                     ## symbol stub for: _strcmp
0000000100000968	testl	%eax, %eax
000000010000096a	je	0x100000a0f
0000000100000970	leaq	0x11e1a(%rip), %rsi             ## literal pool for: "--completions"
0000000100000977	movl	$0xd, %edx
000000010000097c	movq	%rbx, %rdi
000000010000097f	callq	0x10001155c                     ## symbol stub for: _strncmp
0000000100000984	testl	%eax, %eax
0000000100000986	je	0x100000e71
000000010000098c	leaq	(,%r15,8), %rdi
0000000100000994	leaq	_fwp_gc(%rip), %rcx
000000010000099b	cmpq	$0x4000, %rdi                   ## imm = 0x4000
00000001000009a2	movq	%rdi, -0x180(%rbp)
00000001000009a9	ja	0x1000009fc
00000001000009ab	leaq	0xf(%rdi), %rax
00000001000009af	shrq	$0x4, %rax
00000001000009b3	movzbl	0xbe8(%rax,%rcx), %eax
00000001000009bb	movl	0xb48(%rcx,%rax,4), %esi
00000001000009c2	subq	%rsi, _fwp_gc(%rip)
00000001000009c9	js	0x1000009fc
00000001000009cb	leaq	(%rax,%rax,2), %rax
00000001000009cf	leaq	(%rcx,%rax,8), %rax
00000001000009d3	addq	$0x788, %rax                    ## imm = 0x788
00000001000009d9	movq	(%rax), %rdx
00000001000009dc	testq	%rdx, %rdx
00000001000009df	je	0x1000009ec
00000001000009e1	movq	(%rdx), %rcx
00000001000009e4	notq	%rcx
00000001000009e7	movq	%rcx, (%rax)
00000001000009ea	jmp	0x100000a35
00000001000009ec	movq	0x8(%rax), %rdx
00000001000009f0	movq	0x10(%rax), %rcx
00000001000009f4	subq	%rdx, %rcx
00000001000009f7	cmpq	%rsi, %rcx
00000001000009fa	jae	0x100000a2d
00000001000009fc	movl	$0x2, %esi
0000000100000a01	callq	_fwp_gc_alloc_slow
0000000100000a06	movq	%rax, -0x168(%rbp)
0000000100000a0d	jmp	0x100000a44
0000000100000a0f	movq	0x12632(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100000a16	movq	(%rax), %rsi
0000000100000a19	leaq	_exec_man(%rip), %rdi
0000000100000a20	callq	0x100011496                     ## symbol stub for: _fputs
0000000100000a25	xorl	%r13d, %r13d
0000000100000a28	jmp	0x100001643
0000000100000a2d	leaq	(%rdx,%rsi), %rcx
0000000100000a31	movq	%rcx, 0x8(%rax)
0000000100000a35	movq	%rdx, -0x168(%rbp)
0000000100000a3c	movq	%rdx, %rdi
0000000100000a3f	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100000a44	movl	%r14d, %eax
0000000100000a47	movq	%rax, -0x170(%rbp)
0000000100000a4e	movq	%r15, -0x188(%rbp)
0000000100000a55	cmpl	$0x2, %r15d
0000000100000a59	movq	-0x168(%rbp), %r15
0000000100000a60	jl	0x100000a9c
0000000100000a62	xorl	%ebx, %ebx
0000000100000a64	nopw	%cs:(%rax,%rax)
0000000100000a70	leaq	0x1(%rbx), %r12
0000000100000a74	movq	0x8(%r13,%rbx,8), %r14
0000000100000a79	movq	%r14, %rdi
0000000100000a7c	callq	0x100011556                     ## symbol stub for: _strlen
0000000100000a81	movq	%r14, %rdi
0000000100000a84	movq	%rax, %rsi
0000000100000a87	callq	_fwp_str_lossy
0000000100000a8c	movq	%rax, (%r15,%rbx,8)
0000000100000a90	movq	%r12, %rbx
0000000100000a93	cmpq	%r12, -0x170(%rbp)
0000000100000a9a	jne	0x100000a70
0000000100000a9c	movzbl	0x1414e(%rip), %eax
0000000100000aa3	leaq	_fwp_gc(%rip), %rbx
0000000100000aaa	movl	0xb48(%rbx,%rax,4), %esi
0000000100000ab1	subq	%rsi, _fwp_gc(%rip)
0000000100000ab8	movq	-0x188(%rbp), %r14
0000000100000abf	js	0x10000172e
0000000100000ac5	leaq	(%rax,%rax,2), %rax
0000000100000ac9	leaq	(%rbx,%rax,8), %rax
0000000100000acd	addq	$0x788, %rax                    ## imm = 0x788
0000000100000ad3	movq	(%rax), %rdi
0000000100000ad6	testq	%rdi, %rdi
0000000100000ad9	je	0x100000ae6
0000000100000adb	movq	(%rdi), %rcx
0000000100000ade	notq	%rcx
0000000100000ae1	movq	%rcx, (%rax)
0000000100000ae4	jmp	0x100000b02
0000000100000ae6	movq	0x8(%rax), %rdi
0000000100000aea	movq	0x10(%rax), %rcx
0000000100000aee	subq	%rdi, %rcx
0000000100000af1	cmpq	%rsi, %rcx
0000000100000af4	jb	0x10000172e
0000000100000afa	leaq	(%rdi,%rsi), %rcx
0000000100000afe	movq	%rcx, 0x8(%rax)
0000000100000b02	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100000b07	movq	-0x180(%rbp), %r15
0000000100000b0e	movzbl	0x140dc(%rip), %ecx
0000000100000b15	movl	0xb48(%rbx,%rcx,4), %eax
0000000100000b1c	subq	%rax, _fwp_gc(%rip)
0000000100000b23	js	0x100001738
0000000100000b29	leaq	(%rcx,%rcx,2), %rcx
0000000100000b2d	leaq	(%rbx,%rcx,8), %rcx
0000000100000b31	addq	$0x3c8, %rcx                    ## imm = 0x3C8
0000000100000b38	movq	(%rcx), %rdx
0000000100000b3b	testq	%rdx, %rdx
0000000100000b3e	je	0x100000b4b
0000000100000b40	movq	(%rdx), %rax
0000000100000b43	notq	%rax
0000000100000b46	movq	%rax, (%rcx)
0000000100000b49	jmp	0x100000b66
0000000100000b4b	movq	0x8(%rcx), %rdx
0000000100000b4f	movq	0x10(%rcx), %rsi
0000000100000b53	subq	%rdx, %rsi
0000000100000b56	cmpq	%rax, %rsi
0000000100000b59	jb	0x100001738
0000000100000b5f	addq	%rdx, %rax
0000000100000b62	movq	%rax, 0x8(%rcx)
0000000100000b66	movb	$0x0, (%rdx)
0000000100000b69	cmpq	$0x4000, %r15                   ## imm = 0x4000
0000000100000b70	ja	0x100000bc3
0000000100000b72	leaq	0xf(%r15), %rax
0000000100000b76	shrq	$0x4, %rax
0000000100000b7a	movzbl	0xbe8(%rax,%rbx), %eax
0000000100000b82	movl	0xb48(%rbx,%rax,4), %esi
0000000100000b89	subq	%rsi, _fwp_gc(%rip)
0000000100000b90	js	0x100000bc3
0000000100000b92	leaq	(%rax,%rax,2), %rax
0000000100000b96	leaq	(%rbx,%rax,8), %rax
0000000100000b9a	addq	$0x788, %rax                    ## imm = 0x788
0000000100000ba0	movq	(%rax), %rdi
0000000100000ba3	testq	%rdi, %rdi
0000000100000ba6	je	0x100000bb3
0000000100000ba8	movq	(%rdi), %rcx
0000000100000bab	notq	%rcx
0000000100000bae	movq	%rcx, (%rax)
0000000100000bb1	jmp	0x100000bdd
0000000100000bb3	movq	0x8(%rax), %rdi
0000000100000bb7	movq	0x10(%rax), %rcx
0000000100000bbb	subq	%rdi, %rcx
0000000100000bbe	cmpq	%rsi, %rcx
0000000100000bc1	jae	0x100000bd5
0000000100000bc3	movq	%r15, %rdi
0000000100000bc6	movl	$0x2, %esi
0000000100000bcb	callq	_fwp_gc_alloc_slow
0000000100000bd0	movq	%rax, %r8
0000000100000bd3	jmp	0x100000be8
0000000100000bd5	leaq	(%rdi,%rsi), %rcx
0000000100000bd9	movq	%rcx, 0x8(%rax)
0000000100000bdd	movq	%rdi, %r15
0000000100000be0	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100000be5	movq	%r15, %r8
0000000100000be8	xorl	%r13d, %r13d
0000000100000beb	cmpl	$0x2, %r14d
0000000100000bef	movq	-0x168(%rbp), %rsi
0000000100000bf6	movq	-0x170(%rbp), %rdi
0000000100000bfd	jl	0x100000d60
0000000100000c03	movq	%rdi, %r9
0000000100000c06	negq	%r9
0000000100000c09	movb	$0x1, %r12b
0000000100000c0c	xorl	%r13d, %r13d
0000000100000c0f	movl	$0x1, %r14d
0000000100000c15	xorl	%r10d, %r10d
0000000100000c18	nopl	(%rax,%rax)
0000000100000c20	movq	-0x8(%rsi,%r14,8), %rbx
0000000100000c25	testl	%r10d, %r10d
0000000100000c28	jne	0x100000c50
0000000100000c2a	movq	(%rbx), %r15
0000000100000c2d	cmpq	$0x2, %r15
0000000100000c31	jb	0x100000c50
0000000100000c33	cmpb	$0x2d, 0x8(%rbx)
0000000100000c37	jne	0x100000c50
0000000100000c39	movzbl	0x9(%rbx), %eax
0000000100000c3d	leal	-0x30(%rax), %ecx
0000000100000c40	cmpb	$0xa, %cl
0000000100000c43	setb	%cl
0000000100000c46	cmpb	$0x2e, %al
0000000100000c48	sete	%dl
0000000100000c4b	orb	%cl, %dl
0000000100000c4d	je	0x100000c76
0000000100000c4f	nop
0000000100000c50	movslq	%r13d, %rax
0000000100000c53	incl	%r13d
0000000100000c56	movq	%rbx, (%r8,%rax,8)
0000000100000c5a	cmpq	%rdi, %r14
0000000100000c5d	setb	%r12b
0000000100000c61	leaq	(%r9,%r14), %rax
0000000100000c65	incq	%rax
0000000100000c68	incq	%r14
0000000100000c6b	cmpq	$0x1, %rax
0000000100000c6f	jne	0x100000c20
0000000100000c71	jmp	0x100000d2d
0000000100000c76	cmpq	$0x2, %r15
0000000100000c7a	sete	%cl
0000000100000c7d	cmpb	$0x2d, %al
0000000100000c7f	sete	%dl
0000000100000c82	testb	%dl, %cl
0000000100000c84	je	0x100000c8e
0000000100000c86	movl	$0x1, %r10d
0000000100000c8c	jmp	0x100000c5a
0000000100000c8e	cmpb	$0x2d, %al
0000000100000c90	jne	0x100000d19
0000000100000c96	leaq	0xa(%rbx), %rdi
0000000100000c9a	movq	%rdi, -0x1a0(%rbp)
0000000100000ca1	addq	$-0x2, %r15
0000000100000ca5	movl	$0x3d, %esi
0000000100000caa	movq	%r15, %rdx
0000000100000cad	movq	%r8, -0x188(%rbp)
0000000100000cb4	movq	%r9, -0x180(%rbp)
0000000100000cbb	movl	%r10d, -0x194(%rbp)
0000000100000cc2	callq	0x1000114cc                     ## symbol stub for: _memchr
0000000100000cc7	movq	-0x1a0(%rbp), %rdx
0000000100000cce	movl	-0x194(%rbp), %r10d
0000000100000cd5	movq	-0x180(%rbp), %r9
0000000100000cdc	movq	-0x188(%rbp), %r8
0000000100000ce3	movq	-0x170(%rbp), %rdi
0000000100000cea	movq	-0x168(%rbp), %rsi
0000000100000cf1	movq	%rax, %rcx
0000000100000cf4	subq	%rdx, %rcx
0000000100000cf7	testq	%rax, %rax
0000000100000cfa	cmoveq	%r15, %rcx
0000000100000cfe	xorq	$0x4, %rcx
0000000100000d02	orq	%rax, %rcx
0000000100000d05	jne	0x100000c50
0000000100000d0b	cmpl	$0x706c6568, (%rdx)             ## imm = 0x706C6568
0000000100000d11	jne	0x100000c50
0000000100000d17	jmp	0x100000d2d
0000000100000d19	cmpq	$0x2, %r15
0000000100000d1d	sete	%cl
0000000100000d20	cmpb	$0x68, %al
0000000100000d22	sete	%al
0000000100000d25	testb	%al, %cl
0000000100000d27	je	0x100000c50
0000000100000d2d	testb	$0x1, %r12b
0000000100000d31	leaq	_fwp_gc(%rip), %rbx
0000000100000d38	je	0x100000d60
0000000100000d3a	movq	0x12307(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100000d41	movq	(%rbx), %rsi
0000000100000d44	leaq	0x11c57(%rip), %rdi             ## literal pool for: "usage: reduce64 <Array[F64]>\n\narguments:\n  <Array[F64]>  or one per line of standard input\n\noptions:\n  -h, --help  show this help\n"
0000000100000d4b	callq	0x100011496                     ## symbol stub for: _fputs
0000000100000d50	movq	(%rbx), %rdi
0000000100000d53	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100000d58	xorl	%r13d, %r13d
0000000100000d5b	jmp	0x100001643
0000000100000d60	movzbl	0x13e8a(%rip), %eax
0000000100000d67	movl	0xb48(%rbx,%rax,4), %esi
0000000100000d6e	subq	%rsi, _fwp_gc(%rip)
0000000100000d75	js	0x100000db2
0000000100000d77	leaq	(%rax,%rax,2), %rax
0000000100000d7b	leaq	(%rbx,%rax,8), %rax
0000000100000d7f	addq	$0x788, %rax                    ## imm = 0x788
0000000100000d85	movq	(%rax), %rbx
0000000100000d88	testq	%rbx, %rbx
0000000100000d8b	je	0x100000d9e
0000000100000d8d	movq	%r8, %r14
0000000100000d90	movq	(%rbx), %rcx
0000000100000d93	notq	%rcx
0000000100000d96	movq	%rcx, (%rax)
0000000100000d99	jmp	0x100000e9a
0000000100000d9e	movq	0x8(%rax), %rbx
0000000100000da2	movq	0x10(%rax), %rcx
0000000100000da6	subq	%rbx, %rcx
0000000100000da9	cmpq	%rsi, %rcx
0000000100000dac	jae	0x100000e8f
0000000100000db2	movq	%r8, %r14
0000000100000db5	movl	$0x10, %edi
0000000100000dba	movl	$0x2, %esi
0000000100000dbf	callq	_fwp_gc_alloc_slow
0000000100000dc4	movq	%rax, %rbx
0000000100000dc7	cmpl	$0x1, %r13d
0000000100000dcb	ja	0x100000eac
0000000100000dd1	jne	0x100000ed5
0000000100000dd7	movq	(%r14), %r14
0000000100000dda	movq	(%r14), %r15
0000000100000ddd	addq	$0x8, %r14
0000000100000de1	movq	%r14, -0x130(%rbp)
0000000100000de8	movq	%r15, -0x128(%rbp)
0000000100000def	movq	$0x0, -0x120(%rbp)
0000000100000dfa	leaq	_d3(%rip), %rsi
0000000100000e01	leaq	-0x130(%rbp), %rdi
0000000100000e08	movl	$0x1, %edx
0000000100000e0d	movq	%rbx, %rcx
0000000100000e10	callq	_tp_value
0000000100000e15	testl	%eax, %eax
0000000100000e17	je	0x100000f4d
0000000100000e1d	movq	-0x128(%rbp), %rax
0000000100000e24	movq	-0x120(%rbp), %rcx
0000000100000e2b	cmpq	%rax, %rcx
0000000100000e2e	jae	0x100000ed0
0000000100000e34	movq	-0x130(%rbp), %rdx
0000000100000e3b	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
0000000100000e45	nopw	%cs:(%rax,%rax)
0000000100000e50	movzbl	(%rdx,%rcx), %edi
0000000100000e54	cmpq	$0x20, %rdi
0000000100000e58	ja	0x100000ed0
0000000100000e5a	btq	%rdi, %rsi
0000000100000e5e	jae	0x100000ed0
0000000100000e60	incq	%rcx
0000000100000e63	movq	%rcx, -0x120(%rbp)
0000000100000e6a	cmpq	%rcx, %rax
0000000100000e6d	jne	0x100000e50
0000000100000e6f	jmp	0x100000ed5
0000000100000e71	movzbl	0xd(%rbx), %eax
0000000100000e75	testl	%eax, %eax
0000000100000e77	je	0x100001681
0000000100000e7d	cmpl	$0x3d, %eax
0000000100000e80	jne	0x10000098c
0000000100000e86	addq	$0xe, %rbx
0000000100000e8a	jmp	0x1000016a8
0000000100000e8f	movq	%r8, %r14
0000000100000e92	leaq	(%rbx,%rsi), %rcx
0000000100000e96	movq	%rcx, 0x8(%rax)
0000000100000e9a	movq	%rbx, %rdi
0000000100000e9d	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100000ea2	cmpl	$0x1, %r13d
0000000100000ea6	jbe	0x100000dd1
0000000100000eac	movq	0x12185(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000eb3	movq	(%rax), %rdi
0000000100000eb6	leaq	0x1198a(%rip), %rsi             ## literal pool for: "%s\n"
0000000100000ebd	leaq	0x11a82(%rip), %rdx             ## literal pool for: "usage: reduce64 <Array[F64]>\n  (the last argument may instead be given as records on stdin)"
0000000100000ec4	xorl	%eax, %eax
0000000100000ec6	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100000ecb	jmp	0x100000f89
0000000100000ed0	cmpq	%rax, %rcx
0000000100000ed3	jne	0x100000f4d
0000000100000ed5	leaq	0x117bc(%rip), %rdi             ## literal pool for: "FWP_OUT"
0000000100000edc	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100000ee1	testq	%rax, %rax
0000000100000ee4	je	0x100000f94
0000000100000eea	leaq	0x117af(%rip), %rsi             ## literal pool for: "bin"
0000000100000ef1	movq	%rax, %rdi
0000000100000ef4	callq	0x100011550                     ## symbol stub for: _strcmp
0000000100000ef9	xorl	%esi, %esi
0000000100000efb	movq	0x12146(%rip), %r14             ## literal pool symbol address: ___stdoutp
0000000100000f02	movq	(%r14), %rcx
0000000100000f05	movq	%rcx, %rdx
0000000100000f08	testl	%eax, %eax
0000000100000f0a	sete	%sil
0000000100000f0e	movl	%esi, _fwp_exec_binary_out(%rip)
0000000100000f14	jne	0x100000f20
0000000100000f16	movq	0x1211b(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000f1d	movq	(%rax), %rdx
0000000100000f20	movq	%rdx, _fwp_prog_out(%rip)
0000000100000f27	jne	0x100000faf
0000000100000f2d	leaq	_exec_out_header0(%rip), %rdi
0000000100000f34	movl	$0x1, %esi
0000000100000f39	movl	$0x30, %edx
0000000100000f3e	callq	0x1000114a8                     ## symbol stub for: _fwrite
0000000100000f43	movq	(%r14), %rdi
0000000100000f46	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100000f4b	jmp	0x100000faf
0000000100000f4d	leaq	0x11ad1(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100000f54	movl	%r15d, %esi
0000000100000f57	movq	%r14, %rdx
0000000100000f5a	xorl	%eax, %eax
0000000100000f5c	callq	_fwp_strf
0000000100000f61	movq	0x120d0(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100000f68	movq	(%rcx), %rdi
0000000100000f6b	leaq	0x8(%rax), %r8
0000000100000f6f	leaq	0x1192d(%rip), %rsi             ## literal pool for: "%s: argument %d: %s\n"
0000000100000f76	leaq	0x10be9(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000f7d	movl	$0x1, %ecx
0000000100000f82	xorl	%eax, %eax
0000000100000f84	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100000f89	movl	$0x2, %r13d
0000000100000f8f	jmp	0x100001643
0000000100000f94	movl	$0x0, _fwp_exec_binary_out(%rip)
0000000100000f9e	movq	0x120a3(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100000fa5	movq	(%rax), %rax
0000000100000fa8	movq	%rax, _fwp_prog_out(%rip)
0000000100000faf	movl	$0x0, -0x174(%rbp)
0000000100000fb9	testl	%r13d, %r13d
0000000100000fbc	jle	0x100000fff
0000000100000fbe	leaq	-0x174(%rbp), %rsi
0000000100000fc5	movq	%rbx, %rdi
0000000100000fc8	callq	_fwp_exec_call
0000000100000fcd	movq	%rax, %rbx
0000000100000fd0	movq	_fwp_prog_out(%rip), %rdi
0000000100000fd7	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100000fdc	movl	$0x1, %r13d
0000000100000fe2	cmpl	$0x0, -0x174(%rbp)
0000000100000fe9	jne	0x100001603
0000000100000fef	movq	%rbx, %rdi
0000000100000ff2	callq	_fwp_emit_result
0000000100000ff7	xorl	%r13d, %r13d
0000000100000ffa	jmp	0x100001603
0000000100000fff	movq	0x1203a(%rip), %r13             ## literal pool symbol address: ___stdinp
0000000100001006	movq	(%r13), %rdi
000000010000100a	movl	$0x100000, %ecx                 ## imm = 0x100000
000000010000100f	xorl	%esi, %esi
0000000100001011	xorl	%edx, %edx
0000000100001013	callq	0x100011526                     ## symbol stub for: _setvbuf
0000000100001018	movq	(%r13), %rcx
000000010000101c	leaq	_fwp_in_pend(%rip), %r12
0000000100001023	movl	$0x1, %esi
0000000100001028	movl	$0x4, %edx
000000010000102d	movq	%r12, %rdi
0000000100001030	callq	0x10001149c                     ## symbol stub for: _fread
0000000100001035	movl	%eax, _fwp_in_npend(%rip)
000000010000103b	movl	$0x0, _fwp_in_ppos(%rip)
0000000100001045	movb	$0x1, %cl
0000000100001047	movl	%ecx, -0x170(%rbp)
000000010000104d	cmpl	$0x4, %eax
0000000100001050	jne	0x100001062
0000000100001052	cmpl	$0x31505746, _fwp_in_pend(%rip) ## imm = 0x31505746
000000010000105c	je	0x10000174f
0000000100001062	pxor	%xmm0, %xmm0
0000000100001066	movdqa	%xmm0, -0x150(%rbp)
000000010000106e	movq	$0x0, -0x140(%rbp)
0000000100001079	leaq	-0x130(%rbp), %r14
0000000100001080	leaq	-0x150(%rbp), %r15
0000000100001087	cmpb	$0x0, -0x170(%rbp)
000000010000108e	je	0x10000115d
0000000100001094	movq	$0x0, -0x148(%rbp)
000000010000109f	movslq	_fwp_in_ppos(%rip), %rax
00000001000010a6	cmpl	_fwp_in_npend(%rip), %eax
00000001000010ac	jge	0x100001182
00000001000010b2	leal	0x1(%rax), %ecx
00000001000010b5	movl	%ecx, _fwp_in_ppos(%rip)
00000001000010bb	movzbl	(%rax,%r12), %eax
00000001000010c0	cmpl	$0xa, %eax
00000001000010c3	je	0x100001194
00000001000010c9	cmpl	$-0x1, %eax
00000001000010cc	je	0x100001afe
00000001000010d2	nopw	%cs:(%rax,%rax)
00000001000010e0	movb	%al, -0x130(%rbp)
00000001000010e6	movl	$0x1, %edx
00000001000010eb	movq	%r15, %rdi
00000001000010ee	movq	%r14, %rsi
00000001000010f1	callq	_buf_put
00000001000010f6	movslq	_fwp_in_ppos(%rip), %rax
00000001000010fd	cmpl	_fwp_in_npend(%rip), %eax
0000000100001103	jge	0x100001120
0000000100001105	leal	0x1(%rax), %ecx
0000000100001108	movl	%ecx, _fwp_in_ppos(%rip)
000000010000110e	movzbl	(%rax,%r12), %eax
0000000100001113	jmp	0x100001129
0000000100001115	nopw	%cs:(%rax,%rax)
0000000100001120	movq	(%r13), %rdi
0000000100001124	callq	0x100011484                     ## symbol stub for: _fgetc
0000000100001129	cmpl	$-0x1, %eax
000000010000112c	je	0x100001307
0000000100001132	cmpl	$0xa, %eax
0000000100001135	jne	0x1000010e0
0000000100001137	movq	-0x150(%rbp), %rax
000000010000113e	movq	-0x148(%rbp), %rsi
0000000100001145	testq	%rsi, %rsi
0000000100001148	je	0x10000119b
000000010000114a	cmpb	$0xd, -0x1(%rax,%rsi)
000000010000114f	jne	0x1000011a6
0000000100001151	decq	%rsi
0000000100001154	movq	%rsi, -0x148(%rbp)
000000010000115b	jmp	0x1000011a6
000000010000115d	movslq	_fwp_in_ppos(%rip), %rax
0000000100001164	cmpl	_fwp_in_npend(%rip), %eax
000000010000116a	jge	0x1000011bd
000000010000116c	leal	0x1(%rax), %ecx
000000010000116f	movzbl	(%rax,%r12), %eax
0000000100001174	movb	%al, -0x160(%rbp)
000000010000117a	movl	%ecx, _fwp_in_ppos(%rip)
0000000100001180	jmp	0x1000011e0
0000000100001182	movq	(%r13), %rdi
0000000100001186	callq	0x100011484                     ## symbol stub for: _fgetc
000000010000118b	cmpl	$0xa, %eax
000000010000118e	jne	0x1000010c9
0000000100001194	movq	-0x150(%rbp), %rax
000000010000119b	xorl	%esi, %esi
000000010000119d	testq	%rax, %rax
00000001000011a0	je	0x10000131e
00000001000011a6	movb	$0x0, (%rax,%rsi)
00000001000011aa	movq	-0x150(%rbp), %rdi
00000001000011b1	movq	-0x148(%rbp), %rsi
00000001000011b8	jmp	0x100001320
00000001000011bd	movq	(%r13), %rcx
00000001000011c1	movl	$0x1, %esi
00000001000011c6	movl	$0x1, %edx
00000001000011cb	leaq	-0x160(%rbp), %rdi
00000001000011d2	callq	0x10001149c                     ## symbol stub for: _fread
00000001000011d7	testq	%rax, %rax
00000001000011da	je	0x100001afe
00000001000011e0	movslq	_fwp_in_npend(%rip), %rax
00000001000011e7	movslq	_fwp_in_ppos(%rip), %r15
00000001000011ee	cmpl	%eax, %r15d
00000001000011f1	jge	0x10000122e
00000001000011f3	leaq	(%r12,%r15), %rsi
00000001000011f7	movq	%r15, %r14
00000001000011fa	notq	%r14
00000001000011fd	addq	%rax, %r14
0000000100001200	cmpq	$0x3, %r14
0000000100001204	movl	$0x3, %eax
0000000100001209	cmovaeq	%rax, %r14
000000010000120d	incq	%r14
0000000100001210	leaq	-0x15f(%rbp), %r12
0000000100001217	movq	%r12, %rdi
000000010000121a	movq	%r14, %rdx
000000010000121d	callq	0x1000114d8                     ## symbol stub for: _memcpy
0000000100001222	leal	(%r14,%r15), %eax
0000000100001226	movl	%eax, _fwp_in_ppos(%rip)
000000010000122c	jmp	0x100001240
000000010000122e	xorl	%r14d, %r14d
0000000100001231	leaq	-0x15f(%rbp), %r12
0000000100001238	nopl	(%rax,%rax)
0000000100001240	cmpq	$0x3, %r14
0000000100001244	ja	0x10000126d
0000000100001246	leaq	(%r12,%r14), %rdi
000000010000124a	movl	$0x4, %edx
000000010000124f	subq	%r14, %rdx
0000000100001252	movq	(%r13), %rcx
0000000100001256	movl	$0x1, %esi
000000010000125b	callq	0x10001149c                     ## symbol stub for: _fread
0000000100001260	addq	%rax, %r14
0000000100001263	testq	%rax, %rax
0000000100001266	jne	0x100001240
0000000100001268	jmp	0x1000015d2
000000010000126d	movzwl	-0x15f(%rbp), %eax
0000000100001274	movzbl	-0x15d(%rbp), %r13d
000000010000127c	shll	$0x10, %r13d
0000000100001280	movq	%rax, -0x168(%rbp)
0000000100001287	addq	%r13, %rax
000000010000128a	movzbl	-0x15c(%rbp), %r12d
0000000100001292	shll	$0x18, %r12d
0000000100001296	leaq	(%rax,%r12), %r15
000000010000129a	leaq	(%r12,%rax), %rsi
000000010000129e	incq	%rsi
00000001000012a1	cmpq	$0x3fff, %r15                   ## imm = 0x3FFF
00000001000012a8	ja	0x1000013f2
00000001000012ae	addl	$0x10, %eax
00000001000012b1	shrl	$0x4, %eax
00000001000012b4	leaq	_fwp_gc(%rip), %rdx
00000001000012bb	movzbl	0xbe8(%rax,%rdx), %ecx
00000001000012c3	movl	0xb48(%rdx,%rcx,4), %eax
00000001000012ca	subq	%rax, _fwp_gc(%rip)
00000001000012d1	js	0x1000013f2
00000001000012d7	leaq	(%rcx,%rcx,2), %rcx
00000001000012db	leaq	_fwp_gc(%rip), %rdx
00000001000012e2	leaq	(%rdx,%rcx,8), %rcx
00000001000012e6	addq	$0x3c8, %rcx                    ## imm = 0x3C8
00000001000012ed	movq	(%rcx), %r14
00000001000012f0	testq	%r14, %r14
00000001000012f3	je	0x1000013e2
00000001000012f9	movq	(%r14), %rax
00000001000012fc	notq	%rax
00000001000012ff	movq	%rax, (%rcx)
0000000100001302	jmp	0x10000140b
0000000100001307	movq	-0x150(%rbp), %rax
000000010000130e	movq	-0x148(%rbp), %rsi
0000000100001315	testq	%rax, %rax
0000000100001318	jne	0x1000011a6
000000010000131e	xorl	%edi, %edi
0000000100001320	testq	%rdi, %rdi
0000000100001323	leaq	0x10838(%rip), %rax             ## literal pool for: ""
000000010000132a	cmoveq	%rax, %rdi
000000010000132e	callq	_fwp_str_lossy
0000000100001333	movq	%rax, %r15
0000000100001336	leaq	0x8(%rax), %r14
000000010000133a	movq	(%rax), %rax
000000010000133d	movq	%r14, -0x130(%rbp)
0000000100001344	movq	%rax, -0x128(%rbp)
000000010000134b	movq	$0x0, -0x120(%rbp)
0000000100001356	leaq	-0x130(%rbp), %rdi
000000010000135d	leaq	_d3(%rip), %rsi
0000000100001364	movl	$0x1, %edx
0000000100001369	leaq	-0x190(%rbp), %rcx
0000000100001370	callq	_tp_value
0000000100001375	testl	%eax, %eax
0000000100001377	je	0x100001ac2
000000010000137d	movq	-0x128(%rbp), %rax
0000000100001384	movq	-0x120(%rbp), %rcx
000000010000138b	cmpq	%rax, %rcx
000000010000138e	jae	0x1000013d4
0000000100001390	movq	-0x130(%rbp), %rdx
0000000100001397	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
00000001000013a1	nopw	%cs:(%rax,%rax)
00000001000013b0	movzbl	(%rdx,%rcx), %esi
00000001000013b4	cmpq	$0x20, %rsi
00000001000013b8	ja	0x1000013d4
00000001000013ba	btq	%rsi, %rdi
00000001000013be	jae	0x1000013d4
00000001000013c0	incq	%rcx
00000001000013c3	movq	%rcx, -0x120(%rbp)
00000001000013ca	cmpq	%rcx, %rax
00000001000013cd	jne	0x1000013b0
00000001000013cf	jmp	0x100001581
00000001000013d4	cmpq	%rax, %rcx
00000001000013d7	je	0x100001581
00000001000013dd	jmp	0x100001ac2
00000001000013e2	movq	0x8(%rcx), %r14
00000001000013e6	movq	0x10(%rcx), %rdx
00000001000013ea	subq	%r14, %rdx
00000001000013ed	cmpq	%rax, %rdx
00000001000013f0	jae	0x100001404
00000001000013f2	movq	%rsi, %rdi
00000001000013f5	movl	$0x1, %esi
00000001000013fa	callq	_fwp_gc_alloc_slow
00000001000013ff	movq	%rax, %r14
0000000100001402	jmp	0x100001413
0000000100001404	addq	%r14, %rax
0000000100001407	movq	%rax, 0x8(%rcx)
000000010000140b	movq	%r14, %rdi
000000010000140e	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100001413	testq	%r15, %r15
0000000100001416	je	0x10000151d
000000010000141c	movslq	_fwp_in_npend(%rip), %rax
0000000100001423	movslq	_fwp_in_ppos(%rip), %rdx
000000010000142a	cmpl	%eax, %edx
000000010000142c	jge	0x100001466
000000010000142e	addq	%r13, %r12
0000000100001431	movq	-0x168(%rbp), %rcx
0000000100001438	addq	%r12, %rcx
000000010000143b	decq	%rcx
000000010000143e	movq	%rdx, %rsi
0000000100001441	notq	%rsi
0000000100001444	addq	%rax, %rsi
0000000100001447	cmpq	%rsi, %rcx
000000010000144a	cmovbq	%rcx, %rsi
000000010000144e	incq	%rsi
0000000100001451	cmpq	$0x1f, %rsi
0000000100001455	ja	0x10000146e
0000000100001457	movq	%rdx, %rcx
000000010000145a	xorl	%r13d, %r13d
000000010000145d	leaq	_fwp_in_pend(%rip), %r10
0000000100001464	jmp	0x1000014d0
0000000100001466	xorl	%r13d, %r13d
0000000100001469	jmp	0x1000014f0
000000010000146e	leaq	_fwp_in_pend(%rip), %r10
0000000100001475	movq	%r14, %rdi
0000000100001478	subq	%rdx, %rdi
000000010000147b	subq	%r10, %rdi
000000010000147e	cmpq	$0x20, %rdi
0000000100001482	jae	0x10000148c
0000000100001484	movq	%rdx, %rcx
0000000100001487	xorl	%r13d, %r13d
000000010000148a	jmp	0x1000014d0
000000010000148c	movq	%rsi, %r13
000000010000148f	andq	$-0x20, %r13
0000000100001493	leaq	(%rdx,%r13), %rcx
0000000100001497	leaq	(%rdx,%r10), %rdi
000000010000149b	addq	$0x10, %rdi
000000010000149f	xorl	%r8d, %r8d
00000001000014a2	leaq	(%rdx,%r8), %r9
00000001000014a6	movdqu	(%r10,%r9), %xmm0
00000001000014ac	movups	(%rdi,%r8), %xmm1
00000001000014b1	movdqu	%xmm0, (%r14,%r8)
00000001000014b7	movups	%xmm1, 0x10(%r14,%r8)
00000001000014bd	addq	$0x20, %r8
00000001000014c1	cmpq	%r8, %r13
00000001000014c4	jne	0x1000014a2
00000001000014c6	cmpq	%r13, %rsi
00000001000014c9	je	0x1000014e9
00000001000014cb	nopl	(%rax,%rax)
00000001000014d0	movzbl	(%rcx,%r10), %edx
00000001000014d5	incq	%rcx
00000001000014d8	movb	%dl, (%r14,%r13)
00000001000014dc	incq	%r13
00000001000014df	cmpq	%r15, %r13
00000001000014e2	jae	0x1000014e9
00000001000014e4	cmpq	%rax, %rcx
00000001000014e7	jl	0x1000014d0
00000001000014e9	movl	%ecx, _fwp_in_ppos(%rip)
00000001000014ef	nop
00000001000014f0	movq	%r15, %rdx
00000001000014f3	subq	%r13, %rdx
00000001000014f6	jbe	0x10000151d
00000001000014f8	leaq	(%r14,%r13), %rdi
00000001000014fc	movq	0x11b3d(%rip), %rax             ## literal pool symbol address: ___stdinp
0000000100001503	movq	(%rax), %rcx
0000000100001506	movl	$0x1, %esi
000000010000150b	callq	0x10001149c                     ## symbol stub for: _fread
0000000100001510	addq	%rax, %r13
0000000100001513	testq	%rax, %rax
0000000100001516	jne	0x1000014f0
0000000100001518	jmp	0x1000015d2
000000010000151d	movzbl	-0x160(%rbp), %r13d
0000000100001525	testl	%r13d, %r13d
0000000100001528	je	0x1000015f7
000000010000152e	cmpl	$0x2, %r13d
0000000100001532	je	0x100001b0d
0000000100001538	movq	%r14, -0x130(%rbp)
000000010000153f	movq	%r15, -0x128(%rbp)
0000000100001546	movq	$0x0, -0x120(%rbp)
0000000100001551	leaq	-0x130(%rbp), %rdi
0000000100001558	leaq	_d3(%rip), %rsi
000000010000155f	leaq	-0x190(%rbp), %rdx
0000000100001566	callq	_fwp_decode
000000010000156b	testl	%eax, %eax
000000010000156d	je	0x100001b19
0000000100001573	movq	0x11ac6(%rip), %r13             ## literal pool symbol address: ___stdinp
000000010000157a	leaq	_fwp_in_pend(%rip), %r12
0000000100001581	movq	-0x190(%rbp), %rax
0000000100001588	movq	%rax, (%rbx)
000000010000158b	movq	%rbx, %rdi
000000010000158e	leaq	-0x174(%rbp), %rsi
0000000100001595	callq	_fwp_exec_call
000000010000159a	movq	%rax, %r14
000000010000159d	movq	_fwp_prog_out(%rip), %rdi
00000001000015a4	callq	0x10001147e                     ## symbol stub for: _fflush
00000001000015a9	cmpl	$0x0, -0x174(%rbp)
00000001000015b0	jne	0x100001af3
00000001000015b6	movq	%r14, %rdi
00000001000015b9	callq	_fwp_emit_result
00000001000015be	movq	0x11a83(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000015c5	movq	(%rax), %rdi
00000001000015c8	callq	0x10001147e                     ## symbol stub for: _fflush
00000001000015cd	jmp	0x100001079
00000001000015d2	leaq	0x11127(%rip), %rsi             ## literal pool for: "%s: truncated frame\n"
00000001000015d9	movq	0x11a58(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000015e0	movq	(%rax), %rdi
00000001000015e3	leaq	0x1057c(%rip), %rdx             ## literal pool for: "reduce64"
00000001000015ea	xorl	%eax, %eax
00000001000015ec	callq	0x10001148a                     ## symbol stub for: _fprintf
00000001000015f1	movl	$0x3, %r13d
00000001000015f7	movq	-0x150(%rbp), %rdi
00000001000015fe	callq	0x1000114a2                     ## symbol stub for: _free
0000000100001603	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000160a	je	0x100001634
000000010000160c	movq	0x11a35(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100001613	movq	(%rbx), %rcx
0000000100001616	leaq	_fwp_exec.end(%rip), %rdi
000000010000161d	movl	$0x1, %esi
0000000100001622	movl	$0x5, %edx
0000000100001627	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000162c	movq	(%rbx), %rdi
000000010000162f	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100001634	movq	0x11a0d(%rip), %rax             ## literal pool symbol address: ___stdoutp
000000010000163b	movq	(%rax), %rdi
000000010000163e	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100001643	movl	%r13d, _fwp_exit_code(%rip)
000000010000164a	movq	0x119f7(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001651	movq	(%rax), %rdi
0000000100001654	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100001659	movq	0x119d0(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100001660	movq	(%rax), %rax
0000000100001663	cmpq	-0x30(%rbp), %rax
0000000100001667	jne	0x100001bab
000000010000166d	xorl	%eax, %eax
000000010000166f	addq	$0x178, %rsp                    ## imm = 0x178
0000000100001676	popq	%rbx
0000000100001677	popq	%r12
0000000100001679	popq	%r13
000000010000167b	popq	%r14
000000010000167d	popq	%r15
000000010000167f	popq	%rbp
0000000100001680	retq
0000000100001681	cmpl	$0x1, %r14d
0000000100001685	jne	0x1000016a4
0000000100001687	movq	0x119aa(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000168e	movq	(%rax), %rdi
0000000100001691	leaq	0x11107(%rip), %rsi             ## literal pool for: "%s: option `--completions` needs a value (bash, zsh or fish)\n"
0000000100001698	leaq	0x104c7(%rip), %rdx             ## literal pool for: "reduce64"
000000010000169f	jmp	0x100000ec4
00000001000016a4	movq	0x10(%r13), %rbx
00000001000016a8	leaq	0x1112e(%rip), %rsi             ## literal pool for: "bash"
00000001000016af	movq	%rbx, %rdi
00000001000016b2	callq	0x100011550                     ## symbol stub for: _strcmp
00000001000016b7	xorl	%r13d, %r13d
00000001000016ba	testl	%eax, %eax
00000001000016bc	je	0x100001727
00000001000016be	leaq	0x1111d(%rip), %rsi             ## literal pool for: "zsh"
00000001000016c5	movq	%rbx, %rdi
00000001000016c8	callq	0x100011550                     ## symbol stub for: _strcmp
00000001000016cd	testl	%eax, %eax
00000001000016cf	je	0x100001a97
00000001000016d5	leaq	0x1110a(%rip), %rsi             ## literal pool for: "fish"
00000001000016dc	movq	%rbx, %rdi
00000001000016df	callq	0x100011550                     ## symbol stub for: _strcmp
00000001000016e4	testl	%eax, %eax
00000001000016e6	je	0x100001a9e
00000001000016ec	movq	%rbx, %rdi
00000001000016ef	callq	0x100011556                     ## symbol stub for: _strlen
00000001000016f4	movq	%rbx, %rdi
00000001000016f7	movq	%rax, %rsi
00000001000016fa	callq	_fwp_str_lossy
00000001000016ff	movq	0x11932(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100001706	movq	(%rcx), %rdi
0000000100001709	leaq	0x8(%rax), %rcx
000000010000170d	leaq	0x110d7(%rip), %rsi             ## literal pool for: "%s: unknown shell `%s` (bash, zsh or fish)\n"
0000000100001714	leaq	0x1044b(%rip), %rdx             ## literal pool for: "reduce64"
000000010000171b	xorl	%eax, %eax
000000010000171d	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100001722	jmp	0x100000f89
0000000100001727	xorl	%eax, %eax
0000000100001729	jmp	0x100001aa3
000000010000172e	callq	_fwp_main_thread.cold.1
0000000100001733	jmp	0x100000b07
0000000100001738	callq	_fwp_main_thread.cold.2
000000010000173d	cmpq	$0x4000, %r15                   ## imm = 0x4000
0000000100001744	jbe	0x100000b72
000000010000174a	jmp	0x100000bc3
000000010000174f	movl	$0x4, _fwp_in_ppos(%rip)
0000000100001759	movq	(%r13), %rcx
000000010000175d	leaq	-0x151(%rbp), %rdi
0000000100001764	movl	$0x1, %esi
0000000100001769	movl	$0x1, %edx
000000010000176e	callq	0x10001149c                     ## symbol stub for: _fread
0000000100001773	testq	%rax, %rax
0000000100001776	je	0x100001b35
000000010000177c	leaq	-0x190(%rbp), %rdi
0000000100001783	callq	_fwp_stdin_leb
0000000100001788	cmpl	$0x1, %eax
000000010000178b	jne	0x100001b31
0000000100001791	movq	-0x190(%rbp), %rax
0000000100001798	cmpq	$0x40, %rax
000000010000179c	movl	$0x40, %ecx
00000001000017a1	cmovbq	%rax, %rcx
00000001000017a5	testq	%rax, %rax
00000001000017a8	je	0x1000019cf
00000001000017ae	movq	$0x0, -0x170(%rbp)
00000001000017b9	movq	%rcx, -0x168(%rbp)
00000001000017c0	movq	$-0x7, %r14
00000001000017c7	xorl	%r15d, %r15d
00000001000017ca	movslq	_fwp_in_ppos(%rip), %rax
00000001000017d1	cmpl	_fwp_in_npend(%rip), %eax
00000001000017d7	jge	0x1000017ef
00000001000017d9	leal	0x1(%rax), %ecx
00000001000017dc	movzbl	(%rax,%r12), %eax
00000001000017e1	movb	%al, -0x130(%rbp)
00000001000017e7	movl	%ecx, _fwp_in_ppos(%rip)
00000001000017ed	jmp	0x100001812
00000001000017ef	movq	(%r13), %rcx
00000001000017f3	movl	$0x1, %esi
00000001000017f8	movl	$0x1, %edx
00000001000017fd	leaq	-0x130(%rbp), %rdi
0000000100001804	callq	0x10001149c                     ## symbol stub for: _fread
0000000100001809	testq	%rax, %rax
000000010000180c	je	0x100001b2f
0000000100001812	cmpq	$0x38, %r14
0000000100001816	setne	%cl
0000000100001819	movzbl	-0x130(%rbp), %eax
0000000100001820	testb	$0x7e, %al
0000000100001822	sete	%dl
0000000100001825	orb	%cl, %dl
0000000100001827	je	0x100001b06
000000010000182d	addq	$0x7, %r14
0000000100001831	movzbl	%al, %eax
0000000100001834	movl	%eax, %edx
0000000100001836	andl	$0x7f, %edx
0000000100001839	movl	%r14d, %ecx
000000010000183c	shlq	%cl, %rdx
000000010000183f	orq	%rdx, %r15
0000000100001842	testb	%al, %al
0000000100001844	jns	0x100001855
0000000100001846	cmpq	$0x38, %r14
000000010000184a	jbe	0x1000017ca
0000000100001850	jmp	0x100001b06
0000000100001855	cmpq	$0x100000, %r15                 ## imm = 0x100000
000000010000185c	ja	0x100001b06
0000000100001862	testq	%r15, %r15
0000000100001865	je	0x1000019a7
000000010000186b	cmpq	$0x6, %r15
000000010000186f	jne	0x1000018d3
0000000100001871	movslq	_fwp_in_npend(%rip), %rax
0000000100001878	movslq	_fwp_in_ppos(%rip), %r15
000000010000187f	cmpl	%eax, %r15d
0000000100001882	jge	0x100001970
0000000100001888	leaq	_fwp_in_pend(%rip), %rcx
000000010000188f	leaq	(%rcx,%r15), %rsi
0000000100001893	movq	%r15, %r14
0000000100001896	notq	%r14
0000000100001899	addq	%rax, %r14
000000010000189c	cmpq	$0x5, %r14
00000001000018a0	movl	$0x5, %eax
00000001000018a5	cmovaeq	%rax, %r14
00000001000018a9	incq	%r14
00000001000018ac	leaq	-0x130(%rbp), %rdi
00000001000018b3	movq	%r14, %rdx
00000001000018b6	callq	0x1000114d8                     ## symbol stub for: _memcpy
00000001000018bb	leal	(%r14,%r15), %eax
00000001000018bf	movl	%eax, _fwp_in_ppos(%rip)
00000001000018c5	jmp	0x100001973
00000001000018ca	subq	%r12, %r15
00000001000018cd	je	0x1000019a7
00000001000018d3	cmpq	$0x100, %r15                    ## imm = 0x100
00000001000018da	movl	$0x100, %r12d                   ## imm = 0x100
00000001000018e0	cmovbq	%r15, %r12
00000001000018e4	movslq	_fwp_in_npend(%rip), %rax
00000001000018eb	movslq	_fwp_in_ppos(%rip), %r14
00000001000018f2	cmpl	%eax, %r14d
00000001000018f5	jge	0x10000193f
00000001000018f7	leaq	_fwp_in_pend(%rip), %rcx
00000001000018fe	leaq	(%rcx,%r14), %rsi
0000000100001902	movq	%r14, -0x188(%rbp)
0000000100001909	notq	%r14
000000010000190c	addq	%rax, %r14
000000010000190f	leaq	-0x1(%r12), %rax
0000000100001914	cmpq	%rax, %r14
0000000100001917	cmovaeq	%rax, %r14
000000010000191b	incq	%r14
000000010000191e	leaq	-0x130(%rbp), %rdi
0000000100001925	movq	%r14, %rdx
0000000100001928	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000192d	movq	-0x188(%rbp), %rax
0000000100001934	addl	%r14d, %eax
0000000100001937	movl	%eax, _fwp_in_ppos(%rip)
000000010000193d	jmp	0x100001942
000000010000193f	xorl	%r14d, %r14d
0000000100001942	movq	%r12, %rdx
0000000100001945	subq	%r14, %rdx
0000000100001948	jbe	0x1000018ca
000000010000194a	leaq	(%r14,%rbp), %rdi
000000010000194e	addq	$-0x130, %rdi                   ## imm = 0xFED0
0000000100001955	movq	(%r13), %rcx
0000000100001959	movl	$0x1, %esi
000000010000195e	callq	0x10001149c                     ## symbol stub for: _fread
0000000100001963	addq	%rax, %r14
0000000100001966	testq	%rax, %rax
0000000100001969	jne	0x100001942
000000010000196b	jmp	0x100001b35
0000000100001970	xorl	%r14d, %r14d
0000000100001973	cmpq	$0x5, %r14
0000000100001977	ja	0x1000019a7
0000000100001979	leaq	(%r14,%rbp), %rdi
000000010000197d	addq	$-0x130, %rdi                   ## imm = 0xFED0
0000000100001984	movl	$0x6, %edx
0000000100001989	subq	%r14, %rdx
000000010000198c	movq	(%r13), %rcx
0000000100001990	movl	$0x1, %esi
0000000100001995	callq	0x10001149c                     ## symbol stub for: _fread
000000010000199a	addq	%rax, %r14
000000010000199d	testq	%rax, %rax
00000001000019a0	jne	0x100001973
00000001000019a2	jmp	0x100001b35
00000001000019a7	movq	-0x170(%rbp), %rdx
00000001000019ae	incq	%rdx
00000001000019b1	movq	-0x168(%rbp), %rcx
00000001000019b8	movq	%rdx, -0x170(%rbp)
00000001000019bf	cmpq	%rcx, %rdx
00000001000019c2	leaq	_fwp_in_pend(%rip), %r12
00000001000019c9	jne	0x1000017c0
00000001000019cf	movq	$0x0, -0x160(%rbp)
00000001000019da	leaq	-0x150(%rbp), %rdi
00000001000019e1	movl	$0x10, %esi
00000001000019e6	callq	_fwp_read_exact
00000001000019eb	testl	%eax, %eax
00000001000019ed	je	0x100001b35
00000001000019f3	leaq	-0x160(%rbp), %rdi
00000001000019fa	callq	_fwp_stdin_name_len
00000001000019ff	cmpl	$0x1, %eax
0000000100001a02	jne	0x100001b31
0000000100001a08	movq	-0x160(%rbp), %r15
0000000100001a0f	leaq	0x1(%r15), %rdi
0000000100001a13	callq	_fwp_alloc_leaf
0000000100001a18	movq	%rax, %r14
0000000100001a1b	testq	%r15, %r15
0000000100001a1e	je	0x100001a33
0000000100001a20	movq	%r14, %rdi
0000000100001a23	movq	%r15, %rsi
0000000100001a26	callq	_fwp_read_exact
0000000100001a2b	testl	%eax, %eax
0000000100001a2d	je	0x100001b35
0000000100001a33	movb	$0x0, (%r14,%r15)
0000000100001a38	movzbl	-0x151(%rbp), %ecx
0000000100001a3f	cmpl	$0x1, %ecx
0000000100001a42	jne	0x100001b72
0000000100001a48	movdqa	-0x150(%rbp), %xmm0
0000000100001a50	pxor	0xfb48(%rip), %xmm0
0000000100001a58	ptest	%xmm0, %xmm0
0000000100001a5d	je	0x100001b9c
0000000100001a63	movq	0x115ce(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001a6a	movq	(%rax), %rdi
0000000100001a6d	leaq	0x10c5a(%rip), %rsi             ## literal pool for: "%s: input type mismatch: expected `%s`, got `%s`\n"
0000000100001a74	leaq	0x100eb(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001a7b	leaq	0x10fa3(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100001a82	movq	%r14, %r8
0000000100001a85	xorl	%eax, %eax
0000000100001a87	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100001a8c	movl	$0x3, %r13d
0000000100001a92	jmp	0x100001643
0000000100001a97	movl	$0x1, %eax
0000000100001a9c	jmp	0x100001aa3
0000000100001a9e	movl	$0x2, %eax
0000000100001aa3	leaq	_fwp_cli_scripts(%rip), %rcx
0000000100001aaa	movq	(%rcx,%rax,8), %rdi
0000000100001aae	movq	0x11593(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001ab5	movq	(%rax), %rsi
0000000100001ab8	callq	0x100011496                     ## symbol stub for: _fputs
0000000100001abd	jmp	0x100001643
0000000100001ac2	movq	0x1156f(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001ac9	movq	(%rax), %rdi
0000000100001acc	movl	(%r15), %ecx
0000000100001acf	leaq	0x10c6a(%rip), %rsi             ## literal pool for: "%s: cannot parse input `%.*s` as %s\n"
0000000100001ad6	leaq	0x10089(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001add	leaq	0x10f41(%rip), %r9              ## literal pool for: "Array[F64]"
0000000100001ae4	movq	%r14, %r8
0000000100001ae7	xorl	%eax, %eax
0000000100001ae9	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100001aee	jmp	0x1000015f1
0000000100001af3	movl	$0x1, %r13d
0000000100001af9	jmp	0x1000015f7
0000000100001afe	xorl	%r13d, %r13d
0000000100001b01	jmp	0x1000015f7
0000000100001b06	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100001b0b	jmp	0x100001b31
0000000100001b0d	leaq	0x10c01(%rip), %rsi             ## literal pool for: "%s: bad switch frame\n"
0000000100001b14	jmp	0x1000015d9
0000000100001b19	movq	0x11518(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b20	movq	(%rax), %rdi
0000000100001b23	leaq	0x10c01(%rip), %rsi             ## literal pool for: "%s: malformed value\n"
0000000100001b2a	jmp	0x1000015e3
0000000100001b2f	xorl	%eax, %eax
0000000100001b31	testl	%eax, %eax
0000000100001b33	js	0x100001b5f
0000000100001b35	movq	0x114fc(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b3c	movq	(%rax), %rdi
0000000100001b3f	leaq	0x10c2f(%rip), %rsi             ## literal pool for: "%s: truncated header\n"
0000000100001b46	leaq	0x10019(%rip), %rdx             ## literal pool for: "reduce64"
0000000100001b4d	xorl	%eax, %eax
0000000100001b4f	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100001b54	movl	$0x3, %r13d
0000000100001b5a	jmp	0x100001643
0000000100001b5f	movq	0x114d2(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b66	movq	(%rax), %rdi
0000000100001b69	leaq	0x10bf5(%rip), %rsi             ## literal pool for: "%s: bad header\n"
0000000100001b70	jmp	0x100001b46
0000000100001b72	movq	0x114bf(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b79	movq	(%rax), %rdi
0000000100001b7c	leaq	0x10b26(%rip), %rsi             ## literal pool for: "%s: unsupported protocol version %d\n"
0000000100001b83	leaq	0xffdc(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001b8a	xorl	%eax, %eax
0000000100001b8c	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100001b91	movl	$0x3, %r13d
0000000100001b97	jmp	0x100001643
0000000100001b9c	movl	$0x0, -0x170(%rbp)
0000000100001ba6	jmp	0x100001062
0000000100001bab	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
_main:
0000000100001bb0	pushq	%rbp
0000000100001bb1	movq	%rsp, %rbp
0000000100001bb4	pushq	%r15
0000000100001bb6	pushq	%r14
0000000100001bb8	pushq	%r13
0000000100001bba	pushq	%r12
0000000100001bbc	pushq	%rbx
0000000100001bbd	subq	$0x128, %rsp                    ## imm = 0x128
0000000100001bc4	movq	%rbp, %rdi
0000000100001bc7	callq	_fwp_gc_start
0000000100001bcc	leaq	_fwp_fn_table(%rip), %rax
0000000100001bd3	movq	%rax, _fwp_fns(%rip)
0000000100001bda	pxor	%xmm0, %xmm0
0000000100001bde	movdqa	%xmm0, -0x100(%rbp)
0000000100001be6	movdqa	%xmm0, -0xb0(%rbp)
0000000100001bee	movdqa	%xmm0, -0xc0(%rbp)
0000000100001bf6	movdqa	%xmm0, -0xd0(%rbp)
0000000100001bfe	movdqa	%xmm0, -0xe0(%rbp)
0000000100001c06	movdqa	%xmm0, -0xf0(%rbp)
0000000100001c0e	movl	$0xb, -0x100(%rbp)
0000000100001c18	leaq	0xfdc1(%rip), %rdi              ## literal pool for: "{\"samples\":["
0000000100001c1f	callq	0x100011514                     ## symbol stub for: _puts
0000000100001c24	xorl	%ebx, %ebx
0000000100001c26	leaq	-0x50(%rbp), %r13
0000000100001c2a	leaq	-0x100(%rbp), %r15
0000000100001c31	movabsq	$-0x286bca1af286bca1, %r14      ## imm = 0xD79435E50D79435F
0000000100001c3b	nopl	(%rax,%rax)
0000000100001c40	movq	%rbx, -0x68(%rbp)
0000000100001c44	movq	$0x0, _bench_kernel_ns(%rip)
0000000100001c4f	movq	0x135c2(%rip), %rax
0000000100001c56	subq	_fwp_gc(%rip), %rax
0000000100001c5d	movq	%rax, _bench_initial_charge(%rip)
0000000100001c64	movq	0x13575(%rip), %rax
0000000100001c6b	movq	%rax, -0x60(%rbp)
0000000100001c6f	movl	$0x6, %edi
0000000100001c74	movq	%r13, %rsi
0000000100001c77	callq	0x100011472                     ## symbol stub for: _clock_gettime
0000000100001c7c	movaps	-0x50(%rbp), %xmm0
0000000100001c80	movaps	%xmm0, -0x90(%rbp)
0000000100001c87	movl	$0xfffffff7, %ecx               ## imm = 0xFFFFFFF7
0000000100001c8c	movabsq	$0x14650fb0739d0383, %r12       ## imm = 0x14650FB0739D0383
0000000100001c96	movq	$0x0, -0x38(%rbp)
0000000100001c9e	movq	%r15, %rsi
0000000100001ca1	jmp	0x100001d30
0000000100001ca6	nopw	%cs:(%rax,%rax)
0000000100001cb0	movq	%xmm0, %rax
0000000100001cb5	movq	-0x70(%rbp), %r12
0000000100001cb9	xorq	%rax, %r12
0000000100001cbc	movabsq	$0x100000001b3, %rax            ## imm = 0x100000001B3
0000000100001cc6	imulq	%rax, %r12
0000000100001cca	movl	$0x6, %edi
0000000100001ccf	leaq	-0x50(%rbp), %r13
0000000100001cd3	movq	%r13, %rsi
0000000100001cd6	callq	0x100011472                     ## symbol stub for: _clock_gettime
0000000100001cdb	movdqa	-0x50(%rbp), %xmm0
0000000100001ce0	psubq	-0xa0(%rbp), %xmm0
0000000100001ce8	movq	%xmm0, %rax
0000000100001ced	imulq	$0x3b9aca00, %rax, %rax         ## imm = 0x3B9ACA00
0000000100001cf4	pextrq	$0x1, %xmm0, %rcx
0000000100001cfb	addq	%rax, %rcx
0000000100001cfe	addq	%rcx, _bench_kernel_ns(%rip)
0000000100001d05	movq	-0x38(%rbp), %rdx
0000000100001d09	incq	%rdx
0000000100001d0c	movl	-0x2c(%rbp), %ecx
0000000100001d0f	incl	%ecx
0000000100001d11	movq	%rdx, -0x38(%rbp)
0000000100001d15	cmpq	$0x8, %rdx
0000000100001d19	leaq	-0x100(%rbp), %rsi
0000000100001d20	movabsq	$-0x286bca1af286bca1, %r14      ## imm = 0xD79435E50D79435F
0000000100001d2a	je	0x100001f00
0000000100001d30	movl	%ecx, -0x2c(%rbp)
0000000100001d33	movl	$0x10001, %edi                  ## imm = 0x10001
0000000100001d38	callq	_fwp_array_new_packed
0000000100001d3d	movq	%rax, %r13
0000000100001d40	subq	0x132f1(%rip), %rax
0000000100001d47	movq	0x13312(%rip), %rcx
0000000100001d4e	shlq	$0x10, %rcx
0000000100001d52	cmpq	%rcx, %rax
0000000100001d55	jae	0x100001dd0
0000000100001d57	movq	0x13322(%rip), %rcx
0000000100001d5e	movq	%rax, %rdx
0000000100001d61	shrq	$0x10, %rdx
0000000100001d65	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100001d6c	leaq	(%rcx,%rdx), %rbx
0000000100001d70	movzbl	(%rcx,%rdx), %ecx
0000000100001d74	cmpb	$0x2, %cl
0000000100001d77	setne	%dl
0000000100001d7a	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100001d80	setne	%sil
0000000100001d84	orb	%dl, %sil
0000000100001d87	jne	0x100001da0
0000000100001d89	addq	$0x228, %rbx                    ## imm = 0x228
0000000100001d90	cmpb	$-0x1, (%rbx)
0000000100001d93	je	0x100001dbf
0000000100001d95	movb	$0x1, (%rbx)
0000000100001d98	jmp	0x100001dd0
0000000100001d9a	nopw	(%rax,%rax)
0000000100001da0	cmpb	$0x1, %cl
0000000100001da3	jne	0x100001dd0
0000000100001da5	movl	0x20(%rbx), %ecx
0000000100001da8	imulq	%rcx, %rax
0000000100001dac	shrq	$0x20, %rax
0000000100001db0	addq	%rax, %rbx
0000000100001db3	addq	$0x228, %rbx                    ## imm = 0x228
0000000100001dba	cmpb	$-0x1, (%rbx)
0000000100001dbd	jne	0x100001d95
0000000100001dbf	movq	%rbx, %rdi
0000000100001dc2	callq	_fwp_rc_forget_slot
0000000100001dc7	jmp	0x100001d95
0000000100001dc9	nopl	(%rax)
0000000100001dd0	movq	%r12, -0x70(%rbp)
0000000100001dd4	movq	%r14, %r12
0000000100001dd7	movq	-0x38(%rbp), %r15
0000000100001ddb	xorl	%ebx, %ebx
0000000100001ddd	movl	-0x2c(%rbp), %r14d
0000000100001de1	nopw	%cs:(%rax,%rax)
0000000100001df0	movq	%r15, %rax
0000000100001df3	mulq	%r12
0000000100001df6	shrq	$0x4, %rdx
0000000100001dfa	leal	(%rdx,%rdx,8), %eax
0000000100001dfd	leal	(%rdx,%rax,2), %eax
0000000100001e00	movl	%r14d, %ecx
0000000100001e03	subl	%eax, %ecx
0000000100001e05	addl	%ebx, %ecx
0000000100001e07	xorps	%xmm0, %xmm0
0000000100001e0a	cvtsi2sd	%ecx, %xmm0
0000000100001e0e	mulsd	0xf8ea(%rip), %xmm0
0000000100001e16	movq	%xmm0, %rdx
0000000100001e1b	movq	%r13, %rdi
0000000100001e1e	movq	%rbx, %rsi
0000000100001e21	leaq	-0x100(%rbp), %rcx
0000000100001e28	callq	_fwp_array_store
0000000100001e2d	incq	%rbx
0000000100001e30	incq	%r15
0000000100001e33	cmpq	$0x10001, %rbx                  ## imm = 0x10001
0000000100001e3a	jne	0x100001df0
0000000100001e3c	movl	$0x6, %edi
0000000100001e41	leaq	-0x50(%rbp), %rsi
0000000100001e45	callq	0x100011472                     ## symbol stub for: _clock_gettime
0000000100001e4a	movdqa	-0x50(%rbp), %xmm0
0000000100001e4f	movdqa	%xmm0, -0xa0(%rbp)
0000000100001e57	pxor	%xmm0, %xmm0
0000000100001e5b	movq	%xmm0, -0x58(%rbp)
0000000100001e60	movsd	0xf8a0(%rip), %xmm2
0000000100001e68	xorl	%ebx, %ebx
0000000100001e6a	xorl	%r15d, %r15d
0000000100001e6d	xorl	%r14d, %r14d
0000000100001e70	movabsq	$0x7fffffffffffffff, %r12       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100001e7a	jmp	0x100001ea4
0000000100001e7c	nopl	(%rax)
0000000100001e80	movq	%r13, %rdi
0000000100001e83	movsd	%xmm2, -0x78(%rbp)
0000000100001e88	callq	_fwp_drop0
0000000100001e8d	xorl	%eax, %eax
0000000100001e8f	movq	-0x78(%rbp), %xmm0
0000000100001e94	movsd	-0x58(%rbp), %xmm2
0000000100001e99	movq	%r15, %r13
0000000100001e9c	testb	%al, %al
0000000100001e9e	je	0x100001cb0
0000000100001ea4	testq	%rbx, %rbx
0000000100001ea7	js	0x100001e80
0000000100001ea9	movq	(%r13), %rax
0000000100001ead	movq	%rax, %rcx
0000000100001eb0	andq	%r12, %rcx
0000000100001eb3	cmpq	%rcx, %rbx
0000000100001eb6	jae	0x100001e80
0000000100001eb8	testq	%rax, %rax
0000000100001ebb	js	0x100001ec3
0000000100001ebd	leaq	0x8(%r13), %rax
0000000100001ec1	jmp	0x100001ec7
0000000100001ec3	movq	0x10(%r13), %rax
0000000100001ec7	movsd	(%rax,%rbx,8), %xmm1
0000000100001ecc	incq	%rbx
0000000100001ecf	mulsd	0xf839(%rip), %xmm1
0000000100001ed7	addsd	0xf839(%rip), %xmm1
0000000100001edf	addsd	%xmm1, %xmm2
0000000100001ee3	movb	$0x1, %al
0000000100001ee5	movq	%r13, %r15
0000000100001ee8	movsd	%xmm2, -0x58(%rbp)
0000000100001eed	movq	%r13, %r14
0000000100001ef0	jmp	0x100001e99
0000000100001ef2	nopw	%cs:(%rax,%rax)
0000000100001f00	movq	%rsi, %r15
0000000100001f03	movl	$0x6, %edi
0000000100001f08	movq	%r13, %rsi
0000000100001f0b	callq	0x100011472                     ## symbol stub for: _clock_gettime
0000000100001f10	movq	0x13301(%rip), %rcx
0000000100001f17	movq	_bench_initial_charge(%rip), %rax
0000000100001f1e	addq	_fwp_gc(%rip), %rax
0000000100001f25	movq	0x132b4(%rip), %rdx
0000000100001f2c	subq	-0x60(%rbp), %rdx
0000000100001f30	movq	-0x68(%rbp), %rbx
0000000100001f34	jne	0x100001ff8
0000000100001f3a	cmpq	%rax, %rcx
0000000100001f3d	jne	0x100001ff8
0000000100001f43	movdqa	-0x50(%rbp), %xmm0
0000000100001f48	psubq	-0x90(%rbp), %xmm0
0000000100001f50	movq	%xmm0, %rax
0000000100001f55	pextrq	$0x1, %xmm0, %rdx
0000000100001f5c	imulq	$0x3b9aca00, %rax, %rax         ## imm = 0x3B9ACA00
0000000100001f63	addq	%rax, %rdx
0000000100001f66	testq	%rbx, %rbx
0000000100001f69	leaq	0xfbef(%rip), %rsi              ## literal pool for: ",\n"
0000000100001f70	leaq	0xfbeb(%rip), %rax              ## literal pool for: ""
0000000100001f77	cmoveq	%rax, %rsi
0000000100001f7b	movq	_bench_kernel_ns(%rip), %rcx
0000000100001f82	movq	0x1326e(%rip), %xmm0
0000000100001f8a	movq	0x130bf(%rip), %rax
0000000100001f91	movq	0x130f0(%rip), %rdi
0000000100001f98	addq	0x130a9(%rip), %rdi
0000000100001f9f	movq	%rdi, 0x40(%rsp)
0000000100001fa4	movq	%rax, 0x38(%rsp)
0000000100001fa9	xorpd	%xmm1, %xmm1
0000000100001fad	movupd	%xmm1, 0x20(%rsp)
0000000100001fb3	movupd	%xmm1, 0x10(%rsp)
0000000100001fb9	movupd	%xmm1, (%rsp)
0000000100001fbe	movq	$0x0, 0x30(%rsp)
0000000100001fc7	leaq	0xfa5b(%rip), %rdi              ## literal pool for: "%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%ld,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"collections\":%zu,\"collectionPauseSeconds\":%.9f,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}"
0000000100001fce	movq	%r12, %r8
0000000100001fd1	xorl	%r9d, %r9d
0000000100001fd4	movb	$0x1, %al
0000000100001fd6	callq	0x1000114f6                     ## symbol stub for: _printf
0000000100001fdb	incq	%rbx
0000000100001fde	cmpq	$0x5, %rbx
0000000100001fe2	jne	0x100001c40
0000000100001fe8	leaq	0xfb74(%rip), %rdi              ## literal pool for: "]}"
0000000100001fef	callq	0x100011514                     ## symbol stub for: _puts
0000000100001ff4	xorl	%eax, %eax
0000000100001ff6	jmp	0x100002018
0000000100001ff8	subq	%rax, %rcx
0000000100001ffb	movq	0x11036(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002002	movq	(%rax), %rdi
0000000100002005	leaq	0xf9e1(%rip), %rsi              ## literal pool for: "unexpected collection or retained charged storage: %zu %ld\n"
000000010000200c	xorl	%eax, %eax
000000010000200e	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100002013	movl	$0xe0, %eax
0000000100002018	addq	$0x128, %rsp                    ## imm = 0x128
000000010000201f	popq	%rbx
0000000100002020	popq	%r12
0000000100002022	popq	%r13
0000000100002024	popq	%r14
0000000100002026	popq	%r15
0000000100002028	popq	%rbp
0000000100002029	retq
000000010000202a	nopw	(%rax,%rax)
_fwp_gc_start:
0000000100002030	pushq	%rbp
0000000100002031	movq	%rsp, %rbp
0000000100002034	pushq	%r15
0000000100002036	pushq	%r14
0000000100002038	pushq	%r12
000000010000203a	pushq	%rbx
000000010000203b	cmpl	$0x0, 0x12fb2(%rip)
0000000100002042	jne	0x10000204f
0000000100002044	movq	%rdi, %rbx
0000000100002047	callq	_fwp_gc_init
000000010000204c	movq	%rbx, %rdi
000000010000204f	movq	%rdi, 0x1303a(%rip)
0000000100002056	callq	0x10001144e                     ## symbol stub for: __dyld_image_count
000000010000205b	testl	%eax, %eax
000000010000205d	je	0x100002164
0000000100002063	xorl	%ebx, %ebx
0000000100002065	leaq	_fwp_gc(%rip), %r14
000000010000206c	movl	$0x1, %r15d
0000000100002072	jmp	0x10000208f
0000000100002074	testl	%esi, %esi
0000000100002076	jne	0x1000020fd
000000010000207c	nopl	(%rax)
0000000100002080	incl	%ebx
0000000100002082	callq	0x10001144e                     ## symbol stub for: __dyld_image_count
0000000100002087	cmpl	%eax, %ebx
0000000100002089	jae	0x100002164
000000010000208f	movl	%ebx, %edi
0000000100002091	callq	0x100011442                     ## symbol stub for: __dyld_get_image_header
0000000100002096	testq	%rax, %rax
0000000100002099	je	0x100002080
000000010000209b	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
00000001000020a1	jne	0x100002080
00000001000020a3	movl	%ebx, %edi
00000001000020a5	movq	%rax, %r12
00000001000020a8	callq	0x100011448                     ## symbol stub for: __dyld_get_image_vmaddr_slide
00000001000020ad	movl	0x10(%r12), %edx
00000001000020b2	testl	%edx, %edx
00000001000020b4	je	0x100002080
00000001000020b6	movq	%r12, %rcx
00000001000020b9	addq	$0x20, %rcx
00000001000020bd	xorl	%esi, %esi
00000001000020bf	movl	%edx, %edi
00000001000020c1	movq	%rcx, %r8
00000001000020c4	jmp	0x1000020db
00000001000020c6	nopw	%cs:(%rax,%rax)
00000001000020d0	movl	0x4(%r8), %r9d
00000001000020d4	addq	%r9, %r8
00000001000020d7	decl	%edi
00000001000020d9	je	0x100002074
00000001000020db	cmpl	$0x19, (%r8)
00000001000020df	jne	0x1000020d0
00000001000020e1	movq	0x18(%r8), %r9
00000001000020e5	addq	%rax, %r9
00000001000020e8	cmpq	%r14, %r9
00000001000020eb	ja	0x1000020d0
00000001000020ed	movq	%r14, %r10
00000001000020f0	subq	%r9, %r10
00000001000020f3	cmpq	0x20(%r8), %r10
00000001000020f7	cmovbl	%r15d, %esi
00000001000020fb	jmp	0x1000020d0
00000001000020fd	movl	0x13095(%rip), %esi
0000000100002103	jmp	0x10000211a
0000000100002105	nopw	%cs:(%rax,%rax)
0000000100002110	movl	0x4(%rcx), %edi
0000000100002113	addq	%rdi, %rcx
0000000100002116	decl	%edx
0000000100002118	je	0x100002164
000000010000211a	cmpl	$0x19, (%rcx)
000000010000211d	jne	0x100002110
000000010000211f	movl	0x3c(%rcx), %edi
0000000100002122	notl	%edi
0000000100002124	testb	$0x3, %dil
0000000100002128	jne	0x100002110
000000010000212a	movq	0x20(%rcx), %rdi
000000010000212e	testq	%rdi, %rdi
0000000100002131	je	0x100002110
0000000100002133	cmpl	$0x10, %esi
0000000100002136	je	0x1000021f2
000000010000213c	movq	0x18(%rcx), %r8
0000000100002140	addq	%rax, %r8
0000000100002143	movslq	%esi, %r9
0000000100002146	shlq	$0x4, %r9
000000010000214a	movq	%r8, 0x1090(%r9,%r14)
0000000100002152	incl	%esi
0000000100002154	movl	%esi, 0x1303e(%rip)
000000010000215a	movq	%rdi, 0x1098(%r9,%r14)
0000000100002162	jmp	0x100002110
0000000100002164	cmpl	$0x0, 0x12e8d(%rip)
000000010000216b	setne	%cl
000000010000216e	cmpl	$0x0, 0x13023(%rip)
0000000100002175	setg	%al
0000000100002178	andb	%cl, %al
000000010000217a	movzbl	%al, %ecx
000000010000217d	movl	%ecx, 0x12e79(%rip)
0000000100002183	cmpl	$0x0, 0x12e7a(%rip)
000000010000218a	je	0x1000021a2
000000010000218c	leaq	_fwp_gc_report(%rip), %rdi
0000000100002193	callq	0x100011460                     ## symbol stub for: _atexit
0000000100002198	cmpl	$0x0, 0x12e5d(%rip)
000000010000219f	setne	%al
00000001000021a2	testb	%al, %al
00000001000021a4	je	0x1000021e9
00000001000021a6	cmpq	$0x0, 0x12e7a(%rip)
00000001000021ae	je	0x1000021e9
00000001000021b0	movq	0x13061(%rip), %rax
00000001000021b7	subq	_fwp_gc(%rip), %rax
00000001000021be	cvtsi2sd	%rax, %xmm0
00000001000021c3	addsd	0x13025(%rip), %xmm0
00000001000021cb	movsd	%xmm0, 0x1301d(%rip)
00000001000021d3	movq	$0x0, 0x1303a(%rip)
00000001000021de	movq	$0x0, _fwp_gc(%rip)
00000001000021e9	popq	%rbx
00000001000021ea	popq	%r12
00000001000021ec	popq	%r14
00000001000021ee	popq	%r15
00000001000021f0	popq	%rbp
00000001000021f1	retq
00000001000021f2	callq	_fwp_flush
00000001000021f7	movq	0x10e3a(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000021fe	movq	(%rax), %rdi
0000000100002201	leaq	0xfa37(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002208	leaq	0x10821(%rip), %rdx             ## literal pool for: "too many program data segments for the collector"
000000010000220f	xorl	%eax, %eax
0000000100002211	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100002216	movl	$0x65, %edi
000000010000221b	callq	0x100011478                     ## symbol stub for: _exit
_fwp_array_new_packed:
0000000100002220	pushq	%rbp
0000000100002221	movq	%rsp, %rbp
0000000100002224	pushq	%r14
0000000100002226	pushq	%rbx
0000000100002227	movabsq	$0x1fffffffffffffff, %rax       ## imm = 0x1FFFFFFFFFFFFFFF
0000000100002231	cmpq	%rax, %rdi
0000000100002234	jae	0x1000023a1
000000010000223a	movq	%rdi, %rbx
000000010000223d	testq	%rsi, %rsi
0000000100002240	je	0x1000022e1
0000000100002246	movl	(%rsi), %eax
0000000100002248	cmpq	$0xa, %rax
000000010000224c	ja	0x100002269
000000010000224e	movl	$0x4e7, %ecx                    ## imm = 0x4E7
0000000100002253	btl	%eax, %ecx
0000000100002256	jae	0x100002269
0000000100002258	leaq	0xf6d1(%rip), %rcx
000000010000225f	movq	(%rcx,%rax,8), %rcx
0000000100002263	imulq	%rbx, %rcx
0000000100002267	jmp	0x100002271
0000000100002269	leaq	(,%rbx,8), %rcx
0000000100002271	leaq	0x8(%rcx), %rsi
0000000100002275	cmpl	$0xb, %eax
0000000100002278	ja	0x1000022e9
000000010000227a	movl	$0xdef, %edx                    ## imm = 0xDEF
000000010000227f	btl	%eax, %edx
0000000100002282	jae	0x1000022e9
0000000100002284	cmpq	$0x3ff8, %rcx                   ## imm = 0x3FF8
000000010000228b	ja	0x10000234b
0000000100002291	addq	$0x17, %rcx
0000000100002295	shrq	$0x4, %rcx
0000000100002299	leaq	_fwp_gc(%rip), %rdx
00000001000022a0	movzbl	0xbe8(%rcx,%rdx), %ecx
00000001000022a8	movl	0xb48(%rdx,%rcx,4), %eax
00000001000022af	subq	%rax, _fwp_gc(%rip)
00000001000022b6	js	0x10000234b
00000001000022bc	leaq	(%rcx,%rcx,2), %rcx
00000001000022c0	leaq	(%rdx,%rcx,8), %rcx
00000001000022c4	addq	$0x3c8, %rcx                    ## imm = 0x3C8
00000001000022cb	movq	(%rcx), %r14
00000001000022ce	testq	%r14, %r14
00000001000022d1	je	0x10000233b
00000001000022d3	movq	(%r14), %rax
00000001000022d6	notq	%rax
00000001000022d9	movq	%rax, (%rcx)
00000001000022dc	jmp	0x10000237e
00000001000022e1	leaq	0x8(,%rbx,8), %rsi
00000001000022e9	cmpq	$0x4000, %rsi                   ## imm = 0x4000
00000001000022f0	ja	0x100002365
00000001000022f2	leaq	0xf(%rsi), %rax
00000001000022f6	shrq	$0x4, %rax
00000001000022fa	leaq	_fwp_gc(%rip), %rcx
0000000100002301	movzbl	0xbe8(%rax,%rcx), %edx
0000000100002309	movl	0xb48(%rcx,%rdx,4), %eax
0000000100002310	subq	%rax, _fwp_gc(%rip)
0000000100002317	js	0x100002365
0000000100002319	leaq	(%rdx,%rdx,2), %rdx
000000010000231d	leaq	(%rcx,%rdx,8), %rcx
0000000100002321	addq	$0x788, %rcx                    ## imm = 0x788
0000000100002328	movq	(%rcx), %r14
000000010000232b	testq	%r14, %r14
000000010000232e	je	0x100002355
0000000100002330	movq	(%r14), %rdx
0000000100002333	notq	%rdx
0000000100002336	movq	%rdx, (%rcx)
0000000100002339	jmp	0x10000238b
000000010000233b	movq	0x8(%rcx), %r14
000000010000233f	movq	0x10(%rcx), %rdx
0000000100002343	subq	%r14, %rdx
0000000100002346	cmpq	%rax, %rdx
0000000100002349	jae	0x100002377
000000010000234b	movq	%rsi, %rdi
000000010000234e	movl	$0x1, %esi
0000000100002353	jmp	0x10000236d
0000000100002355	movq	0x8(%rcx), %r14
0000000100002359	movq	0x10(%rcx), %rdx
000000010000235d	subq	%r14, %rdx
0000000100002360	cmpq	%rax, %rdx
0000000100002363	jae	0x100002383
0000000100002365	movq	%rsi, %rdi
0000000100002368	movl	$0x2, %esi
000000010000236d	callq	_fwp_gc_alloc_slow
0000000100002372	movq	%rax, %r14
0000000100002375	jmp	0x100002396
0000000100002377	addq	%r14, %rax
000000010000237a	movq	%rax, 0x8(%rcx)
000000010000237e	movq	%r14, %rdi
0000000100002381	jmp	0x100002391
0000000100002383	leaq	(%r14,%rax), %rdx
0000000100002387	movq	%rdx, 0x8(%rcx)
000000010000238b	movq	%r14, %rdi
000000010000238e	movq	%rax, %rsi
0000000100002391	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100002396	movq	%rbx, (%r14)
0000000100002399	movq	%r14, %rax
000000010000239c	popq	%rbx
000000010000239d	popq	%r14
000000010000239f	popq	%rbp
00000001000023a0	retq
00000001000023a1	callq	_fwp_flush
00000001000023a6	movq	0x10c8b(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000023ad	movq	(%rax), %rdi
00000001000023b0	leaq	0xf888(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000023b7	leaq	0x10764(%rip), %rdx             ## literal pool for: "array too large"
00000001000023be	xorl	%eax, %eax
00000001000023c0	callq	0x10001148a                     ## symbol stub for: _fprintf
00000001000023c5	movl	$0x65, %edi
00000001000023ca	callq	0x100011478                     ## symbol stub for: _exit
00000001000023cf	nop
_fwp_array_store:
00000001000023d0	cmpq	$0x0, (%rdi)
00000001000023d4	js	0x100002416
00000001000023d6	testq	%rcx, %rcx
00000001000023d9	je	0x100002406
00000001000023db	movl	(%rcx), %eax
00000001000023dd	cmpl	$0xa, %eax
00000001000023e0	ja	0x100002406
00000001000023e2	movl	$0x484, %ecx                    ## imm = 0x484
00000001000023e7	btl	%eax, %ecx
00000001000023ea	jb	0x10000240c
00000001000023ec	movl	$0x21, %ecx
00000001000023f1	btl	%eax, %ecx
00000001000023f4	jb	0x100002411
00000001000023f6	movl	$0x42, %ecx
00000001000023fb	btl	%eax, %ecx
00000001000023fe	jae	0x100002406
0000000100002400	movw	%dx, 0x8(%rdi,%rsi,2)
0000000100002405	retq
0000000100002406	movq	%rdx, 0x8(%rdi,%rsi,8)
000000010000240b	retq
000000010000240c	movl	%edx, 0x8(%rdi,%rsi,4)
0000000100002410	retq
0000000100002411	movb	%dl, 0x8(%rdi,%rsi)
0000000100002415	retq
0000000100002416	pushq	%rbp
0000000100002417	movq	%rsp, %rbp
000000010000241a	callq	_fwp_flush
000000010000241f	movq	0x10c12(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002426	movq	(%rax), %rdi
0000000100002429	leaq	0xf80f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002430	leaq	0x106fb(%rip), %rdx             ## literal pool for: "internal: mutating an array view"
0000000100002437	xorl	%eax, %eax
0000000100002439	callq	0x10001148a                     ## symbol stub for: _fprintf
000000010000243e	movl	$0x65, %edi
0000000100002443	callq	0x100011478                     ## symbol stub for: _exit
0000000100002448	nopl	(%rax,%rax)
_e0:
0000000100002450	pushq	%rbp
0000000100002451	movq	%rsp, %rbp
0000000100002454	pushq	%r15
0000000100002456	pushq	%r14
0000000100002458	pushq	%r13
000000010000245a	pushq	%r12
000000010000245c	pushq	%rbx
000000010000245d	subq	$0x18, %rsp
0000000100002461	movq	%rdi, %rbx
0000000100002464	movq	(%rdi), %rdi
0000000100002467	callq	_fwp_rc_share
000000010000246c	movq	(%rbx), %rbx
000000010000246f	pxor	%xmm0, %xmm0
0000000100002473	movq	%xmm0, -0x30(%rbp)
0000000100002478	movsd	0xf288(%rip), %xmm2
0000000100002480	xorl	%r14d, %r14d
0000000100002483	movabsq	$0x7fffffffffffffff, %r15       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000248d	xorl	%r12d, %r12d
0000000100002490	xorl	%r13d, %r13d
0000000100002493	jmp	0x1000024c0
0000000100002495	nopw	%cs:(%rax,%rax)
00000001000024a0	movq	%rbx, %rdi
00000001000024a3	movsd	%xmm2, -0x38(%rbp)
00000001000024a8	callq	_fwp_drop0
00000001000024ad	xorl	%eax, %eax
00000001000024af	movq	-0x38(%rbp), %xmm0
00000001000024b4	movsd	-0x30(%rbp), %xmm2
00000001000024b9	movq	%r12, %rbx
00000001000024bc	testb	%al, %al
00000001000024be	je	0x10000250e
00000001000024c0	testq	%r14, %r14
00000001000024c3	js	0x1000024a0
00000001000024c5	movq	(%rbx), %rax
00000001000024c8	movq	%rax, %rcx
00000001000024cb	andq	%r15, %rcx
00000001000024ce	cmpq	%rcx, %r14
00000001000024d1	jae	0x1000024a0
00000001000024d3	testq	%rax, %rax
00000001000024d6	js	0x1000024de
00000001000024d8	leaq	0x8(%rbx), %rax
00000001000024dc	jmp	0x1000024e2
00000001000024de	movq	0x10(%rbx), %rax
00000001000024e2	movsd	(%rax,%r14,8), %xmm1
00000001000024e8	incq	%r14
00000001000024eb	mulsd	0xf21d(%rip), %xmm1
00000001000024f3	addsd	0xf21d(%rip), %xmm1
00000001000024fb	addsd	%xmm1, %xmm2
00000001000024ff	movb	$0x1, %al
0000000100002501	movq	%rbx, %r12
0000000100002504	movsd	%xmm2, -0x30(%rbp)
0000000100002509	movq	%rbx, %r13
000000010000250c	jmp	0x1000024b9
000000010000250e	movq	%xmm0, %rbx
0000000100002513	movq	%rbx, %rdi
0000000100002516	callq	_fwp_rc_share
000000010000251b	movq	%rbx, %rax
000000010000251e	addq	$0x18, %rsp
0000000100002522	popq	%rbx
0000000100002523	popq	%r12
0000000100002525	popq	%r13
0000000100002527	popq	%r14
0000000100002529	popq	%r15
000000010000252b	popq	%rbp
000000010000252c	retq
000000010000252d	nopl	(%rax)
_e1:
0000000100002530	pushq	%rbp
0000000100002531	movq	%rsp, %rbp
0000000100002534	pushq	%r15
0000000100002536	pushq	%r14
0000000100002538	pushq	%r13
000000010000253a	pushq	%r12
000000010000253c	pushq	%rbx
000000010000253d	pushq	%rax
000000010000253e	movq	%rdi, %rbx
0000000100002541	movq	(%rdi), %rdi
0000000100002544	callq	_fwp_rc_share
0000000100002549	movq	(%rbx), %rbx
000000010000254c	xorl	%r15d, %r15d
000000010000254f	xorl	%r12d, %r12d
0000000100002552	xorl	%r13d, %r13d
0000000100002555	xorl	%r14d, %r14d
0000000100002558	xorl	%eax, %eax
000000010000255a	jmp	0x100002574
000000010000255c	nopl	(%rax)
0000000100002560	movq	%rbx, %rdi
0000000100002563	callq	_fwp_drop0
0000000100002568	xorl	%ecx, %ecx
000000010000256a	movq	%r15, %rax
000000010000256d	movq	%r13, %rbx
0000000100002570	testb	%cl, %cl
0000000100002572	je	0x1000025d1
0000000100002574	testq	%r12, %r12
0000000100002577	js	0x100002560
0000000100002579	movq	(%rbx), %rcx
000000010000257c	movq	%rcx, %rdx
000000010000257f	movabsq	$0x7fffffffffffffff, %rsi       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100002589	andq	%rsi, %rdx
000000010000258c	cmpq	%rdx, %r12
000000010000258f	jae	0x100002560
0000000100002591	testq	%rcx, %rcx
0000000100002594	js	0x10000259c
0000000100002596	leaq	0x8(%rbx), %rcx
000000010000259a	jmp	0x1000025a0
000000010000259c	movq	0x10(%rbx), %rcx
00000001000025a0	movss	(%rcx,%r12,4), %xmm0
00000001000025a6	incq	%r12
00000001000025a9	mulss	0xf19f(%rip), %xmm0
00000001000025b1	addss	0xf19b(%rip), %xmm0
00000001000025b9	movd	%r15d, %xmm1
00000001000025be	addss	%xmm0, %xmm1
00000001000025c2	movd	%xmm1, %r15d
00000001000025c7	movb	$0x1, %cl
00000001000025c9	movq	%rbx, %r13
00000001000025cc	movq	%rbx, %r14
00000001000025cf	jmp	0x10000256d
00000001000025d1	movl	%eax, %ebx
00000001000025d3	movq	%rbx, %rdi
00000001000025d6	callq	_fwp_rc_share
00000001000025db	movq	%rbx, %rax
00000001000025de	addq	$0x8, %rsp
00000001000025e2	popq	%rbx
00000001000025e3	popq	%r12
00000001000025e5	popq	%r13
00000001000025e7	popq	%r14
00000001000025e9	popq	%r15
00000001000025eb	popq	%rbp
00000001000025ec	retq
00000001000025ed	nopl	(%rax)
_e2:
00000001000025f0	pushq	%rbp
00000001000025f1	movq	%rsp, %rbp
00000001000025f4	pushq	%r15
00000001000025f6	pushq	%r14
00000001000025f8	pushq	%r13
00000001000025fa	pushq	%r12
00000001000025fc	pushq	%rbx
00000001000025fd	subq	$0xa8, %rsp
0000000100002604	movq	%rdi, %rbx
0000000100002607	movq	0x10a22(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000260e	movq	(%rax), %rax
0000000100002611	movq	%rax, -0x30(%rbp)
0000000100002615	movq	(%rdi), %rdi
0000000100002618	callq	_fwp_rc_share
000000010000261d	movq	(%rbx), %rbx
0000000100002620	xorl	%r15d, %r15d
0000000100002623	xorl	%r13d, %r13d
0000000100002626	xorl	%r12d, %r12d
0000000100002629	xorl	%r14d, %r14d
000000010000262c	xorl	%esi, %esi
000000010000262e	jmp	0x100002648
0000000100002630	movq	%rbx, %rdi
0000000100002633	callq	_fwp_drop0
0000000100002638	xorl	%eax, %eax
000000010000263a	movq	%r15, %rsi
000000010000263d	movq	%r12, %rbx
0000000100002640	testb	%al, %al
0000000100002642	je	0x10000271d
0000000100002648	testq	%r13, %r13
000000010000264b	js	0x100002630
000000010000264d	movq	(%rbx), %rax
0000000100002650	movq	%rax, %rcx
0000000100002653	movabsq	$0x7fffffffffffffff, %rdx       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000265d	andq	%rdx, %rcx
0000000100002660	cmpq	%rcx, %r13
0000000100002663	jae	0x100002630
0000000100002665	testq	%rax, %rax
0000000100002668	js	0x100002670
000000010000266a	leaq	0x8(%rbx), %rax
000000010000266e	jmp	0x100002674
0000000100002670	movq	0x10(%rbx), %rax
0000000100002674	movsbq	(%rax,%r13), %rcx
0000000100002679	movq	_fwp_cleanups(%rip), %rax
0000000100002680	movq	%rbx, -0xa0(%rbp)
0000000100002687	movq	%rax, -0xd0(%rbp)
000000010000268e	leaq	_fwp_owner_release35(%rip), %rdx
0000000100002695	movq	%rdx, -0xc8(%rbp)
000000010000269c	leaq	-0xa0(%rbp), %rdx
00000001000026a3	movq	%rdx, -0xc0(%rbp)
00000001000026aa	leaq	-0xd0(%rbp), %rdx
00000001000026b1	movq	%rdx, _fwp_cleanups(%rip)
00000001000026b8	addq	$-0x7f, %rcx
00000001000026bc	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
00000001000026c3	jbe	0x10000274d
00000001000026c9	movq	%rbx, -0x98(%rbp)
00000001000026d0	movq	%rax, -0xb8(%rbp)
00000001000026d7	leaq	_fwp_owner_release36(%rip), %rcx
00000001000026de	movq	%rcx, -0xb0(%rbp)
00000001000026e5	leaq	-0x98(%rbp), %rcx
00000001000026ec	movq	%rcx, -0xa8(%rbp)
00000001000026f3	leaq	-0xb8(%rbp), %rcx
00000001000026fa	movq	%rcx, _fwp_cleanups(%rip)
0000000100002701	incq	%r15
0000000100002704	jo	0x10000275d
0000000100002706	incq	%r13
0000000100002709	movq	%rax, _fwp_cleanups(%rip)
0000000100002710	movb	$0x1, %al
0000000100002712	movq	%rbx, %r12
0000000100002715	movq	%rbx, %r14
0000000100002718	jmp	0x10000263d
000000010000271d	movq	%rsi, %rbx
0000000100002720	movq	%rsi, %rdi
0000000100002723	callq	_fwp_rc_share
0000000100002728	movq	0x10901(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
000000010000272f	movq	(%rax), %rax
0000000100002732	cmpq	-0x30(%rbp), %rax
0000000100002736	jne	0x1000027ab
0000000100002738	movq	%rbx, %rax
000000010000273b	addq	$0xa8, %rsp
0000000100002742	popq	%rbx
0000000100002743	popq	%r12
0000000100002745	popq	%r13
0000000100002747	popq	%r14
0000000100002749	popq	%r15
000000010000274b	popq	%rbp
000000010000274c	retq
000000010000274d	leaq	0xf502(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002754	leaq	0xf528(%rip), %rcx              ## literal pool for: "I8"
000000010000275b	jmp	0x10000276b
000000010000275d	leaq	0xf4f2(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002764	leaq	0xf4e7(%rip), %rcx              ## literal pool for: "I64"
000000010000276b	leaq	-0x90(%rbp), %rbx
0000000100002772	movl	$0x60, %esi
0000000100002777	movq	%rbx, %rdi
000000010000277a	xorl	%eax, %eax
000000010000277c	callq	0x10001153e                     ## symbol stub for: _snprintf
0000000100002781	callq	_fwp_flush
0000000100002786	movq	0x108ab(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000278d	movq	(%rax), %rdi
0000000100002790	leaq	0xf4a8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002797	movq	%rbx, %rdx
000000010000279a	xorl	%eax, %eax
000000010000279c	callq	0x10001148a                     ## symbol stub for: _fprintf
00000001000027a1	movl	$0x65, %edi
00000001000027a6	callq	0x100011478                     ## symbol stub for: _exit
00000001000027ab	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
_e3:
00000001000027b0	pushq	%rbp
00000001000027b1	movq	%rsp, %rbp
00000001000027b4	pushq	%r15
00000001000027b6	pushq	%r14
00000001000027b8	pushq	%r13
00000001000027ba	pushq	%r12
00000001000027bc	pushq	%rbx
00000001000027bd	subq	$0xa8, %rsp
00000001000027c4	movq	%rdi, %rbx
00000001000027c7	movq	0x10862(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000027ce	movq	(%rax), %rax
00000001000027d1	movq	%rax, -0x30(%rbp)
00000001000027d5	movq	(%rdi), %rdi
00000001000027d8	callq	_fwp_rc_share
00000001000027dd	movq	(%rbx), %rbx
00000001000027e0	xorl	%r14d, %r14d
00000001000027e3	xorl	%r12d, %r12d
00000001000027e6	xorl	%r13d, %r13d
00000001000027e9	xorl	%r15d, %r15d
00000001000027ec	xorl	%eax, %eax
00000001000027ee	jmp	0x100002808
00000001000027f0	movq	%rbx, %rdi
00000001000027f3	callq	_fwp_drop0
00000001000027f8	xorl	%ecx, %ecx
00000001000027fa	movq	%r14, %rax
00000001000027fd	movq	%r13, %rbx
0000000100002800	testb	%cl, %cl
0000000100002802	je	0x1000028e7
0000000100002808	testq	%r12, %r12
000000010000280b	js	0x1000027f0
000000010000280d	movq	(%rbx), %rcx
0000000100002810	movq	%rcx, %rdx
0000000100002813	movabsq	$0x7fffffffffffffff, %rsi       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000281d	andq	%rsi, %rdx
0000000100002820	cmpq	%rdx, %r12
0000000100002823	jae	0x1000027f0
0000000100002825	testq	%rcx, %rcx
0000000100002828	js	0x100002830
000000010000282a	leaq	0x8(%rbx), %rcx
000000010000282e	jmp	0x100002834
0000000100002830	movq	0x10(%rbx), %rcx
0000000100002834	movsbq	(%rcx,%r12), %rdx
0000000100002839	movq	_fwp_cleanups(%rip), %rcx
0000000100002840	movq	%rbx, -0xa0(%rbp)
0000000100002847	movq	%rcx, -0xd0(%rbp)
000000010000284e	leaq	_fwp_owner_release40(%rip), %rsi
0000000100002855	movq	%rsi, -0xc8(%rbp)
000000010000285c	leaq	-0xa0(%rbp), %rsi
0000000100002863	movq	%rsi, -0xc0(%rbp)
000000010000286a	leaq	-0xd0(%rbp), %rsi
0000000100002871	movq	%rsi, _fwp_cleanups(%rip)
0000000100002878	leaq	-0x7f(%rdx), %rsi
000000010000287c	cmpq	$-0x101, %rsi                   ## imm = 0xFEFF
0000000100002883	jbe	0x100002918
0000000100002889	movq	%rbx, -0x98(%rbp)
0000000100002890	movq	%rcx, -0xb8(%rbp)
0000000100002897	leaq	_fwp_owner_release41(%rip), %rsi
000000010000289e	movq	%rsi, -0xb0(%rbp)
00000001000028a5	leaq	-0x98(%rbp), %rsi
00000001000028ac	movq	%rsi, -0xa8(%rbp)
00000001000028b3	leaq	-0xb8(%rbp), %rsi
00000001000028ba	movq	%rsi, _fwp_cleanups(%rip)
00000001000028c1	addq	%rdx, %r14
00000001000028c4	incq	%r14
00000001000028c7	movsbq	%r14b, %rdx
00000001000028cb	cmpq	%r14, %rdx
00000001000028ce	jne	0x100002918
00000001000028d0	incq	%r12
00000001000028d3	movq	%rcx, _fwp_cleanups(%rip)
00000001000028da	movb	$0x1, %cl
00000001000028dc	movq	%rbx, %r13
00000001000028df	movq	%rbx, %r15
00000001000028e2	jmp	0x1000027fd
00000001000028e7	movsbq	%al, %rbx
00000001000028eb	movq	%rbx, %rdi
00000001000028ee	callq	_fwp_rc_share
00000001000028f3	movq	0x10736(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000028fa	movq	(%rax), %rax
00000001000028fd	cmpq	-0x30(%rbp), %rax
0000000100002901	jne	0x100002966
0000000100002903	movq	%rbx, %rax
0000000100002906	addq	$0xa8, %rsp
000000010000290d	popq	%rbx
000000010000290e	popq	%r12
0000000100002910	popq	%r13
0000000100002912	popq	%r14
0000000100002914	popq	%r15
0000000100002916	popq	%rbp
0000000100002917	retq
0000000100002918	leaq	0xf337(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000291f	leaq	0xf35d(%rip), %rcx              ## literal pool for: "I8"
0000000100002926	leaq	-0x90(%rbp), %rbx
000000010000292d	movl	$0x60, %esi
0000000100002932	movq	%rbx, %rdi
0000000100002935	xorl	%eax, %eax
0000000100002937	callq	0x10001153e                     ## symbol stub for: _snprintf
000000010000293c	callq	_fwp_flush
0000000100002941	movq	0x106f0(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002948	movq	(%rax), %rdi
000000010000294b	leaq	0xf2ed(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002952	movq	%rbx, %rdx
0000000100002955	xorl	%eax, %eax
0000000100002957	callq	0x10001148a                     ## symbol stub for: _fprintf
000000010000295c	movl	$0x65, %edi
0000000100002961	callq	0x100011478                     ## symbol stub for: _exit
0000000100002966	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000296b	nopl	(%rax,%rax)
_e8:
0000000100002970	pushq	%rbp
0000000100002971	movq	%rsp, %rbp
0000000100002974	pushq	%rbx
0000000100002975	subq	$0x68, %rsp
0000000100002979	movq	0x106b0(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002980	movq	(%rax), %rax
0000000100002983	movq	%rax, -0x10(%rbp)
0000000100002987	movq	0x8(%rdi), %rbx
000000010000298b	addq	(%rdi), %rbx
000000010000298e	movsbq	%bl, %rax
0000000100002992	cmpq	%rbx, %rax
0000000100002995	jne	0x1000029b9
0000000100002997	movq	%rbx, %rdi
000000010000299a	callq	_fwp_rc_share
000000010000299f	movq	0x1068a(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
00000001000029a6	movq	(%rax), %rax
00000001000029a9	cmpq	-0x10(%rbp), %rax
00000001000029ad	jne	0x100002a04
00000001000029af	movq	%rbx, %rax
00000001000029b2	addq	$0x68, %rsp
00000001000029b6	popq	%rbx
00000001000029b7	popq	%rbp
00000001000029b8	retq
00000001000029b9	leaq	0xf296(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000029c0	leaq	0xf2bc(%rip), %rcx              ## literal pool for: "I8"
00000001000029c7	leaq	-0x70(%rbp), %rbx
00000001000029cb	movl	$0x60, %esi
00000001000029d0	movq	%rbx, %rdi
00000001000029d3	xorl	%eax, %eax
00000001000029d5	callq	0x10001153e                     ## symbol stub for: _snprintf
00000001000029da	callq	_fwp_flush
00000001000029df	movq	0x10652(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000029e6	movq	(%rax), %rdi
00000001000029e9	leaq	0xf24f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000029f0	movq	%rbx, %rdx
00000001000029f3	xorl	%eax, %eax
00000001000029f5	callq	0x10001148a                     ## symbol stub for: _fprintf
00000001000029fa	movl	$0x65, %edi
00000001000029ff	callq	0x100011478                     ## symbol stub for: _exit
0000000100002a04	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100002a09	nopl	(%rax)
_e17:
0000000100002a10	pushq	%rbp
0000000100002a11	movq	%rsp, %rbp
0000000100002a14	pushq	%rbx
0000000100002a15	pushq	%rax
0000000100002a16	movdqu	(%rdi), %xmm0
0000000100002a1a	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
0000000100002a1f	addps	%xmm0, %xmm1
0000000100002a22	extractps	$0x0, %xmm1, %ebx
0000000100002a28	movq	%rbx, %rdi
0000000100002a2b	callq	_fwp_rc_share
0000000100002a30	movq	%rbx, %rax
0000000100002a33	addq	$0x8, %rsp
0000000100002a37	popq	%rbx
0000000100002a38	popq	%rbp
0000000100002a39	retq
0000000100002a3a	nopw	(%rax,%rax)
_e18:
0000000100002a40	pushq	%rbp
0000000100002a41	movq	%rsp, %rbp
0000000100002a44	pushq	%rbx
0000000100002a45	pushq	%rax
0000000100002a46	movdqu	(%rdi), %xmm0
0000000100002a4a	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
0000000100002a4f	mulps	%xmm0, %xmm1
0000000100002a52	extractps	$0x0, %xmm1, %ebx
0000000100002a58	movq	%rbx, %rdi
0000000100002a5b	callq	_fwp_rc_share
0000000100002a60	movq	%rbx, %rax
0000000100002a63	addq	$0x8, %rsp
0000000100002a67	popq	%rbx
0000000100002a68	popq	%rbp
0000000100002a69	retq
0000000100002a6a	nopw	(%rax,%rax)
_e25:
0000000100002a70	pushq	%rbp
0000000100002a71	movq	%rsp, %rbp
0000000100002a74	pushq	%rbx
0000000100002a75	pushq	%rax
0000000100002a76	movsd	(%rdi), %xmm0
0000000100002a7a	addsd	0x8(%rdi), %xmm0
0000000100002a7f	movq	%xmm0, %rbx
0000000100002a84	movq	%rbx, %rdi
0000000100002a87	callq	_fwp_rc_share
0000000100002a8c	movq	%rbx, %rax
0000000100002a8f	addq	$0x8, %rsp
0000000100002a93	popq	%rbx
0000000100002a94	popq	%rbp
0000000100002a95	retq
0000000100002a96	nopw	%cs:(%rax,%rax)
_e26:
0000000100002aa0	pushq	%rbp
0000000100002aa1	movq	%rsp, %rbp
0000000100002aa4	pushq	%rbx
0000000100002aa5	pushq	%rax
0000000100002aa6	movsd	(%rdi), %xmm0
0000000100002aaa	mulsd	0x8(%rdi), %xmm0
0000000100002aaf	movq	%xmm0, %rbx
0000000100002ab4	movq	%rbx, %rdi
0000000100002ab7	callq	_fwp_rc_share
0000000100002abc	movq	%rbx, %rax
0000000100002abf	addq	$0x8, %rsp
0000000100002ac3	popq	%rbx
0000000100002ac4	popq	%rbp
0000000100002ac5	retq
0000000100002ac6	nopw	%cs:(%rax,%rax)
_e27:
0000000100002ad0	pushq	%rbp
0000000100002ad1	movq	%rsp, %rbp
0000000100002ad4	pushq	%rbx
0000000100002ad5	pushq	%rax
0000000100002ad6	movq	%rdi, %rbx
0000000100002ad9	movq	0x8(%rdi), %rdi
0000000100002add	callq	_fwp_rc_share
0000000100002ae2	movq	(%rbx), %rdi
0000000100002ae5	movq	0x8(%rbx), %rsi
0000000100002ae9	leaq	_d0(%rip), %rdx
0000000100002af0	callq	_fwp_p_array_get_typed
0000000100002af5	movq	%rax, %rbx
0000000100002af8	movq	%rax, %rdi
0000000100002afb	callq	_fwp_rc_share
0000000100002b00	movq	%rbx, %rax
0000000100002b03	addq	$0x8, %rsp
0000000100002b07	popq	%rbx
0000000100002b08	popq	%rbp
0000000100002b09	retq
0000000100002b0a	nopw	(%rax,%rax)
_e28:
0000000100002b10	pushq	%rbp
0000000100002b11	movq	%rsp, %rbp
0000000100002b14	pushq	%rbx
0000000100002b15	subq	$0x68, %rsp
0000000100002b19	movq	0x10510(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002b20	movq	(%rax), %rax
0000000100002b23	movq	%rax, -0x10(%rbp)
0000000100002b27	movq	0x8(%rdi), %rbx
0000000100002b2b	addq	(%rdi), %rbx
0000000100002b2e	jo	0x100002b52
0000000100002b30	movq	%rbx, %rdi
0000000100002b33	callq	_fwp_rc_share
0000000100002b38	movq	0x104f1(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002b3f	movq	(%rax), %rax
0000000100002b42	cmpq	-0x10(%rbp), %rax
0000000100002b46	jne	0x100002b9d
0000000100002b48	movq	%rbx, %rax
0000000100002b4b	addq	$0x68, %rsp
0000000100002b4f	popq	%rbx
0000000100002b50	popq	%rbp
0000000100002b51	retq
0000000100002b52	leaq	0xf0fd(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002b59	leaq	0xf0f2(%rip), %rcx              ## literal pool for: "I64"
0000000100002b60	leaq	-0x70(%rbp), %rbx
0000000100002b64	movl	$0x60, %esi
0000000100002b69	movq	%rbx, %rdi
0000000100002b6c	xorl	%eax, %eax
0000000100002b6e	callq	0x10001153e                     ## symbol stub for: _snprintf
0000000100002b73	callq	_fwp_flush
0000000100002b78	movq	0x104b9(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002b7f	movq	(%rax), %rdi
0000000100002b82	leaq	0xf0b6(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002b89	movq	%rbx, %rdx
0000000100002b8c	xorl	%eax, %eax
0000000100002b8e	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100002b93	movl	$0x65, %edi
0000000100002b98	callq	0x100011478                     ## symbol stub for: _exit
0000000100002b9d	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100002ba2	nopw	%cs:(%rax,%rax)
_e29:
0000000100002bb0	pushq	%rbp
0000000100002bb1	movq	%rsp, %rbp
0000000100002bb4	pushq	%rbx
0000000100002bb5	pushq	%rax
0000000100002bb6	movq	%rdi, %rbx
0000000100002bb9	movq	(%rdi), %rdi
0000000100002bbc	callq	_fwp_rc_share
0000000100002bc1	movq	(%rbx), %rdi
0000000100002bc4	callq	_f29
0000000100002bc9	movq	%rax, %rbx
0000000100002bcc	movq	%rax, %rdi
0000000100002bcf	callq	_fwp_rc_share
0000000100002bd4	movq	%rbx, %rax
0000000100002bd7	addq	$0x8, %rsp
0000000100002bdb	popq	%rbx
0000000100002bdc	popq	%rbp
0000000100002bdd	retq
0000000100002bde	nop
_e30:
0000000100002be0	pushq	%rbp
0000000100002be1	movq	%rsp, %rbp
0000000100002be4	pushq	%rbx
0000000100002be5	pushq	%rax
0000000100002be6	movq	%rdi, %rbx
0000000100002be9	movq	(%rdi), %rdi
0000000100002bec	callq	_fwp_rc_share
0000000100002bf1	movq	0x8(%rbx), %rdi
0000000100002bf5	callq	_fwp_rc_share
0000000100002bfa	movq	(%rbx), %rdi
0000000100002bfd	movq	0x8(%rbx), %rsi
0000000100002c01	leaq	_fwp_drop2(%rip), %rdx
0000000100002c08	leaq	_fwp_drop1(%rip), %rcx
0000000100002c0f	callq	_fwp_p_loop_own
0000000100002c14	movq	%rax, %rbx
0000000100002c17	movq	%rax, %rdi
0000000100002c1a	callq	_fwp_rc_share
0000000100002c1f	movq	%rbx, %rax
0000000100002c22	addq	$0x8, %rsp
0000000100002c26	popq	%rbx
0000000100002c27	popq	%rbp
0000000100002c28	retq
0000000100002c29	nopl	(%rax)
_e31:
0000000100002c30	pushq	%rbp
0000000100002c31	movq	%rsp, %rbp
0000000100002c34	pushq	%rbx
0000000100002c35	pushq	%rax
0000000100002c36	movq	%rdi, %rbx
0000000100002c39	movq	0x8(%rdi), %rdi
0000000100002c3d	callq	_fwp_rc_share
0000000100002c42	movq	(%rbx), %rdi
0000000100002c45	movq	0x8(%rbx), %rsi
0000000100002c49	leaq	_d1(%rip), %rdx
0000000100002c50	callq	_fwp_p_array_get_typed
0000000100002c55	movq	%rax, %rbx
0000000100002c58	movq	%rax, %rdi
0000000100002c5b	callq	_fwp_rc_share
0000000100002c60	movq	%rbx, %rax
0000000100002c63	addq	$0x8, %rsp
0000000100002c67	popq	%rbx
0000000100002c68	popq	%rbp
0000000100002c69	retq
0000000100002c6a	nopw	(%rax,%rax)
_e32:
0000000100002c70	pushq	%rbp
0000000100002c71	movq	%rsp, %rbp
0000000100002c74	pushq	%rbx
0000000100002c75	pushq	%rax
0000000100002c76	movq	%rdi, %rbx
0000000100002c79	movq	(%rdi), %rdi
0000000100002c7c	callq	_fwp_rc_share
0000000100002c81	movq	(%rbx), %rdi
0000000100002c84	callq	_f32
0000000100002c89	movq	%rax, %rbx
0000000100002c8c	movq	%rax, %rdi
0000000100002c8f	callq	_fwp_rc_share
0000000100002c94	movq	%rbx, %rax
0000000100002c97	addq	$0x8, %rsp
0000000100002c9b	popq	%rbx
0000000100002c9c	popq	%rbp
0000000100002c9d	retq
0000000100002c9e	nop
_e33:
0000000100002ca0	pushq	%rbp
0000000100002ca1	movq	%rsp, %rbp
0000000100002ca4	pushq	%rbx
0000000100002ca5	pushq	%rax
0000000100002ca6	movq	%rdi, %rbx
0000000100002ca9	movq	(%rdi), %rdi
0000000100002cac	callq	_fwp_rc_share
0000000100002cb1	movq	0x8(%rbx), %rdi
0000000100002cb5	callq	_fwp_rc_share
0000000100002cba	movq	(%rbx), %rdi
0000000100002cbd	movq	0x8(%rbx), %rsi
0000000100002cc1	leaq	_fwp_drop5(%rip), %rdx
0000000100002cc8	leaq	_fwp_drop4(%rip), %rcx
0000000100002ccf	callq	_fwp_p_loop_own
0000000100002cd4	movq	%rax, %rbx
0000000100002cd7	movq	%rax, %rdi
0000000100002cda	callq	_fwp_rc_share
0000000100002cdf	movq	%rbx, %rax
0000000100002ce2	addq	$0x8, %rsp
0000000100002ce6	popq	%rbx
0000000100002ce7	popq	%rbp
0000000100002ce8	retq
0000000100002ce9	nopl	(%rax)
_e34:
0000000100002cf0	pushq	%rbp
0000000100002cf1	movq	%rsp, %rbp
0000000100002cf4	pushq	%rbx
0000000100002cf5	pushq	%rax
0000000100002cf6	movq	%rdi, %rbx
0000000100002cf9	movq	0x8(%rdi), %rdi
0000000100002cfd	callq	_fwp_rc_share
0000000100002d02	movq	(%rbx), %rdi
0000000100002d05	movq	0x8(%rbx), %rsi
0000000100002d09	leaq	_d2(%rip), %rdx
0000000100002d10	callq	_fwp_p_array_get_typed
0000000100002d15	movq	%rax, %rbx
0000000100002d18	movq	%rax, %rdi
0000000100002d1b	callq	_fwp_rc_share
0000000100002d20	movq	%rbx, %rax
0000000100002d23	addq	$0x8, %rsp
0000000100002d27	popq	%rbx
0000000100002d28	popq	%rbp
0000000100002d29	retq
0000000100002d2a	nopw	(%rax,%rax)
_e35:
0000000100002d30	pushq	%rbp
0000000100002d31	movq	%rsp, %rbp
0000000100002d34	pushq	%rbx
0000000100002d35	pushq	%rax
0000000100002d36	movq	%rdi, %rbx
0000000100002d39	movq	(%rdi), %rdi
0000000100002d3c	callq	_fwp_rc_share
0000000100002d41	movq	(%rbx), %rdi
0000000100002d44	callq	_f35
0000000100002d49	movq	%rax, %rbx
0000000100002d4c	movq	%rax, %rdi
0000000100002d4f	callq	_fwp_rc_share
0000000100002d54	movq	%rbx, %rax
0000000100002d57	addq	$0x8, %rsp
0000000100002d5b	popq	%rbx
0000000100002d5c	popq	%rbp
0000000100002d5d	retq
0000000100002d5e	nop
_e36:
0000000100002d60	pushq	%rbp
0000000100002d61	movq	%rsp, %rbp
0000000100002d64	pushq	%rbx
0000000100002d65	pushq	%rax
0000000100002d66	movq	%rdi, %rbx
0000000100002d69	movq	(%rdi), %rdi
0000000100002d6c	callq	_fwp_rc_share
0000000100002d71	movq	0x8(%rbx), %rdi
0000000100002d75	callq	_fwp_rc_share
0000000100002d7a	movq	(%rbx), %rdi
0000000100002d7d	movq	0x8(%rbx), %rsi
0000000100002d81	leaq	_fwp_drop8(%rip), %rdx
0000000100002d88	leaq	_fwp_drop7(%rip), %rcx
0000000100002d8f	callq	_fwp_p_loop_own
0000000100002d94	movq	%rax, %rbx
0000000100002d97	movq	%rax, %rdi
0000000100002d9a	callq	_fwp_rc_share
0000000100002d9f	movq	%rbx, %rax
0000000100002da2	addq	$0x8, %rsp
0000000100002da6	popq	%rbx
0000000100002da7	popq	%rbp
0000000100002da8	retq
0000000100002da9	nopl	(%rax)
_e37:
0000000100002db0	pushq	%rbp
0000000100002db1	movq	%rsp, %rbp
0000000100002db4	pushq	%rbx
0000000100002db5	pushq	%rax
0000000100002db6	movq	%rdi, %rbx
0000000100002db9	movq	(%rdi), %rdi
0000000100002dbc	callq	_fwp_rc_share
0000000100002dc1	movq	(%rbx), %rdi
0000000100002dc4	callq	_f37
0000000100002dc9	movq	%rax, %rbx
0000000100002dcc	movq	%rax, %rdi
0000000100002dcf	callq	_fwp_rc_share
0000000100002dd4	movq	%rbx, %rax
0000000100002dd7	addq	$0x8, %rsp
0000000100002ddb	popq	%rbx
0000000100002ddc	popq	%rbp
0000000100002ddd	retq
0000000100002dde	nop
_e38:
0000000100002de0	pushq	%rbp
0000000100002de1	movq	%rsp, %rbp
0000000100002de4	pushq	%rbx
0000000100002de5	pushq	%rax
0000000100002de6	movq	%rdi, %rbx
0000000100002de9	movq	(%rdi), %rdi
0000000100002dec	callq	_fwp_rc_share
0000000100002df1	movq	0x8(%rbx), %rdi
0000000100002df5	callq	_fwp_rc_share
0000000100002dfa	movq	(%rbx), %rdi
0000000100002dfd	movq	0x8(%rbx), %rsi
0000000100002e01	leaq	_fwp_drop10(%rip), %rdx
0000000100002e08	leaq	_fwp_drop9(%rip), %rcx
0000000100002e0f	callq	_fwp_p_loop_own
0000000100002e14	movq	%rax, %rbx
0000000100002e17	movq	%rax, %rdi
0000000100002e1a	callq	_fwp_rc_share
0000000100002e1f	movq	%rbx, %rax
0000000100002e22	addq	$0x8, %rsp
0000000100002e26	popq	%rbx
0000000100002e27	popq	%rbp
0000000100002e28	retq
0000000100002e29	nopl	(%rax)
_fwp_rc_share:
0000000100002e30	pushq	%rbp
0000000100002e31	movq	%rsp, %rbp
0000000100002e34	pushq	%r15
0000000100002e36	pushq	%r14
0000000100002e38	pushq	%r13
0000000100002e3a	pushq	%r12
0000000100002e3c	pushq	%rbx
0000000100002e3d	subq	$0x208, %rsp                    ## imm = 0x208
0000000100002e44	movq	0x101e5(%rip), %rax             ## literal pool symbol address: ___stack_chk_guard
0000000100002e4b	movq	(%rax), %rax
0000000100002e4e	movq	%rax, -0x30(%rbp)
0000000100002e52	movq	%rdi, %rax
0000000100002e55	subq	0x121dc(%rip), %rax
0000000100002e5c	movq	0x121fd(%rip), %rcx
0000000100002e63	shlq	$0x10, %rcx
0000000100002e67	cmpq	%rcx, %rax
0000000100002e6a	jae	0x100003054
0000000100002e70	movq	0x12209(%rip), %rcx
0000000100002e77	movq	%rax, %rdx
0000000100002e7a	shrq	$0x10, %rdx
0000000100002e7e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100002e85	leaq	(%rcx,%rdx), %rbx
0000000100002e89	movzbl	(%rcx,%rdx), %ecx
0000000100002e8d	cmpb	$0x2, %cl
0000000100002e90	setne	%dl
0000000100002e93	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100002e99	setne	%sil
0000000100002e9d	orb	%dl, %sil
0000000100002ea0	jne	0x100002eab
0000000100002ea2	addq	$0x228, %rbx                    ## imm = 0x228
0000000100002ea9	jmp	0x100002ec9
0000000100002eab	cmpb	$0x1, %cl
0000000100002eae	jne	0x100003054
0000000100002eb4	movl	0x20(%rbx), %ecx
0000000100002eb7	imulq	%rcx, %rax
0000000100002ebb	shrq	$0x20, %rax
0000000100002ebf	addq	%rax, %rbx
0000000100002ec2	addq	$0x228, %rbx                    ## imm = 0x228
0000000100002ec9	movzbl	(%rbx), %eax
0000000100002ecc	testb	%al, %al
0000000100002ece	je	0x100003054
0000000100002ed4	cmpb	$-0x1, %al
0000000100002ed6	je	0x100003076
0000000100002edc	movb	$0x0, (%rbx)
0000000100002edf	movq	%rdi, -0x230(%rbp)
0000000100002ee6	movl	$0x1, %r14d
0000000100002eec	jmp	0x100002ef9
0000000100002eee	nop
0000000100002ef0	testq	%r14, %r14
0000000100002ef3	je	0x100003054
0000000100002ef9	movq	-0x238(%rbp,%r14,8), %r15
0000000100002f01	decq	%r14
0000000100002f04	movq	0x1212d(%rip), %rax
0000000100002f0b	movq	%r15, %rcx
0000000100002f0e	subq	%rax, %rcx
0000000100002f11	movq	%rcx, %rsi
0000000100002f14	shrq	$0x10, %rsi
0000000100002f18	movq	0x12161(%rip), %rdx
0000000100002f1f	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100002f26	cmpb	$0x1, 0x1(%rdx,%rsi)
0000000100002f2b	je	0x100002ef0
0000000100002f2d	addq	%rsi, %rdx
0000000100002f30	movzbl	(%rdx), %esi
0000000100002f33	cmpb	$0x2, %sil
0000000100002f37	jne	0x100002f40
0000000100002f39	movq	0x18(%rdx), %r12
0000000100002f3d	jmp	0x100002f6b
0000000100002f3f	nop
0000000100002f40	movl	0x8(%rdx), %r12d
0000000100002f44	cmpb	$0x1, %sil
0000000100002f48	jne	0x100002f6b
0000000100002f4a	movzwl	%r15w, %esi
0000000100002f4e	movl	0x20(%rdx), %r15d
0000000100002f52	imulq	%rsi, %r15
0000000100002f56	shrq	$0x20, %r15
0000000100002f5a	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100002f61	addq	%rcx, %rax
0000000100002f64	imulq	%r12, %r15
0000000100002f68	addq	%rax, %r15
0000000100002f6b	cmpq	$0x8, %r12
0000000100002f6f	jb	0x100002ef0
0000000100002f75	shrq	$0x3, %r12
0000000100002f79	xorl	%r13d, %r13d
0000000100002f7c	jmp	0x100002f9c
0000000100002f7e	callq	_fwp_rc_share
0000000100002f83	nopw	%cs:(%rax,%rax)
0000000100002f90	incq	%r13
0000000100002f93	cmpq	%r13, %r12
0000000100002f96	je	0x100002ef0
0000000100002f9c	movq	(%r15,%r13,8), %rdi
0000000100002fa0	movq	%rdi, %rax
0000000100002fa3	subq	0x1208e(%rip), %rax
0000000100002faa	movq	0x120af(%rip), %rcx
0000000100002fb1	shlq	$0x10, %rcx
0000000100002fb5	cmpq	%rcx, %rax
0000000100002fb8	jae	0x100002f90
0000000100002fba	movq	0x120bf(%rip), %rcx
0000000100002fc1	movq	%rax, %rdx
0000000100002fc4	shrq	$0x10, %rdx
0000000100002fc8	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100002fcf	leaq	(%rcx,%rdx), %rbx
0000000100002fd3	movzbl	(%rcx,%rdx), %ecx
0000000100002fd7	cmpb	$0x2, %cl
0000000100002fda	setne	%dl
0000000100002fdd	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100002fe3	setne	%sil
0000000100002fe7	orb	%dl, %sil
0000000100002fea	jne	0x100003000
0000000100002fec	addq	$0x228, %rbx                    ## imm = 0x228
0000000100002ff3	jmp	0x10000301a
0000000100002ff5	nopw	%cs:(%rax,%rax)
0000000100003000	cmpb	$0x1, %cl
0000000100003003	jne	0x100002f90
0000000100003005	movl	0x20(%rbx), %ecx
0000000100003008	imulq	%rcx, %rax
000000010000300c	shrq	$0x20, %rax
0000000100003010	addq	%rax, %rbx
0000000100003013	addq	$0x228, %rbx                    ## imm = 0x228
000000010000301a	movzbl	(%rbx), %eax
000000010000301d	testb	%al, %al
000000010000301f	je	0x100002f90
0000000100003025	cmpq	$0x3f, %r14
0000000100003029	ja	0x100002f7e
000000010000302f	cmpb	$-0x1, %al
0000000100003031	je	0x10000304a
0000000100003033	movb	$0x0, (%rbx)
0000000100003036	movq	(%r15,%r13,8), %rax
000000010000303a	movq	%rax, -0x230(%rbp,%r14,8)
0000000100003042	incq	%r14
0000000100003045	jmp	0x100002f90
000000010000304a	movq	%rbx, %rdi
000000010000304d	callq	_fwp_rc_forget_slot
0000000100003052	jmp	0x100003033
0000000100003054	movq	0xffd5(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000305b	movq	(%rax), %rax
000000010000305e	cmpq	-0x30(%rbp), %rax
0000000100003062	jne	0x100003089
0000000100003064	addq	$0x208, %rsp                    ## imm = 0x208
000000010000306b	popq	%rbx
000000010000306c	popq	%r12
000000010000306e	popq	%r13
0000000100003070	popq	%r14
0000000100003072	popq	%r15
0000000100003074	popq	%rbp
0000000100003075	retq
0000000100003076	movq	%rdi, %r14
0000000100003079	movq	%rbx, %rdi
000000010000307c	callq	_fwp_rc_forget_slot
0000000100003081	movq	%r14, %rdi
0000000100003084	jmp	0x100002edc
0000000100003089	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000308e	nop
_fwp_rc_forget_slot:
0000000100003090	pushq	%rbp
0000000100003091	movq	%rsp, %rbp
0000000100003094	cmpb	$-0x1, (%rdi)
0000000100003097	je	0x10000309b
0000000100003099	popq	%rbp
000000010000309a	retq
000000010000309b	movq	%rdi, %rax
000000010000309e	shrq	$0x11, %rax
00000001000030a2	xorl	%edi, %eax
00000001000030a4	movl	%eax, %ecx
00000001000030a6	shrl	$0x9, %ecx
00000001000030a9	xorl	%eax, %ecx
00000001000030ab	movzbl	%cl, %ecx
00000001000030ae	leaq	_fwp_gc(%rip), %rdx
00000001000030b5	movq	0x1218(%rdx,%rcx,8), %rax
00000001000030bd	testq	%rax, %rax
00000001000030c0	je	0x10000310a
00000001000030c2	cmpq	%rdi, (%rax)
00000001000030c5	je	0x1000030e7
00000001000030c7	nopw	(%rax,%rax)
00000001000030d0	movq	%rax, %rcx
00000001000030d3	movq	0x10(%rax), %rax
00000001000030d7	testq	%rax, %rax
00000001000030da	je	0x10000310a
00000001000030dc	cmpq	%rdi, (%rax)
00000001000030df	jne	0x1000030d0
00000001000030e1	addq	$0x10, %rcx
00000001000030e5	jmp	0x1000030f2
00000001000030e7	leaq	(%rdx,%rcx,8), %rcx
00000001000030eb	addq	$0x1218, %rcx                   ## imm = 0x1218
00000001000030f2	movq	0x10(%rax), %rdx
00000001000030f6	movq	%rdx, (%rcx)
00000001000030f9	movq	%rax, %rdi
00000001000030fc	callq	0x1000114a2                     ## symbol stub for: _free
0000000100003101	decq	0x12918(%rip)
0000000100003108	popq	%rbp
0000000100003109	retq
000000010000310a	callq	_fwp_flush
000000010000310f	movq	0xff22(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003116	movq	(%rax), %rdi
0000000100003119	leaq	0xeb1f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003120	leaq	0xeaf1(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100003127	xorl	%eax, %eax
0000000100003129	callq	0x10001148a                     ## symbol stub for: _fprintf
000000010000312e	movl	$0x65, %edi
0000000100003133	callq	0x100011478                     ## symbol stub for: _exit
0000000100003138	nopl	(%rax,%rax)
_fwp_flush:
0000000100003140	pushq	%rbp
0000000100003141	movq	%rsp, %rbp
0000000100003144	movq	_fwp_prog_out(%rip), %rdi
000000010000314b	testq	%rdi, %rdi
000000010000314e	je	0x100003155
0000000100003150	callq	0x10001147e                     ## symbol stub for: _fflush
0000000100003155	movq	0xfeec(%rip), %rax              ## literal pool symbol address: ___stdoutp
000000010000315c	movq	(%rax), %rdi
000000010000315f	popq	%rbp
0000000100003160	jmp	0x10001147e                     ## symbol stub for: _fflush
0000000100003165	nopw	%cs:(%rax,%rax)
_fwp_drop0:
0000000100003170	pushq	%rbp
0000000100003171	movq	%rsp, %rbp
0000000100003174	pushq	%rbx
0000000100003175	pushq	%rax
0000000100003176	movq	%rdi, %rcx
0000000100003179	subq	0x11eb8(%rip), %rcx
0000000100003180	movq	0x11ed9(%rip), %rax
0000000100003187	shlq	$0x10, %rax
000000010000318b	cmpq	%rax, %rcx
000000010000318e	jae	0x100003233
0000000100003194	movq	0x11ee5(%rip), %rdx
000000010000319b	movq	%rcx, %rax
000000010000319e	shrq	$0x10, %rax
00000001000031a2	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000031a9	leaq	(%rdx,%rsi), %rax
00000001000031ad	movzbl	(%rdx,%rsi), %edx
00000001000031b1	cmpb	$0x2, %dl
00000001000031b4	setne	%sil
00000001000031b8	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000031bf	setne	%r8b
00000001000031c3	orb	%sil, %r8b
00000001000031c6	jne	0x1000031d0
00000001000031c8	addq	$0x228, %rax                    ## imm = 0x228
00000001000031ce	jmp	0x1000031e9
00000001000031d0	cmpb	$0x1, %dl
00000001000031d3	jne	0x100003233
00000001000031d5	movl	0x20(%rax), %edx
00000001000031d8	imulq	%rdx, %rcx
00000001000031dc	shrq	$0x20, %rcx
00000001000031e0	addq	%rcx, %rax
00000001000031e3	addq	$0x228, %rax                    ## imm = 0x228
00000001000031e9	movzbl	(%rax), %ecx
00000001000031ec	testl	%ecx, %ecx
00000001000031ee	je	0x100003233
00000001000031f0	cmpl	$0x1, %ecx
00000001000031f3	jne	0x100003227
00000001000031f5	cmpq	$0x0, (%rdi)
00000001000031f9	jns	0x10000323a
00000001000031fb	movq	0x8(%rdi), %rbx
00000001000031ff	callq	_fwp_rc_free_arr
0000000100003204	movq	%rbx, %rcx
0000000100003207	subq	0x11e2a(%rip), %rcx
000000010000320e	movq	0x11e4b(%rip), %rax
0000000100003215	shlq	$0x10, %rax
0000000100003219	movq	%rbx, %rdi
000000010000321c	cmpq	%rax, %rcx
000000010000321f	jb	0x100003194
0000000100003225	jmp	0x100003233
0000000100003227	cmpl	$0xff, %ecx
000000010000322d	je	0x100003245
000000010000322f	decb	%cl
0000000100003231	movb	%cl, (%rax)
0000000100003233	addq	$0x8, %rsp
0000000100003237	popq	%rbx
0000000100003238	popq	%rbp
0000000100003239	retq
000000010000323a	addq	$0x8, %rsp
000000010000323e	popq	%rbx
000000010000323f	popq	%rbp
0000000100003240	jmp	_fwp_rc_free_arr
0000000100003245	movq	%rax, %rdi
0000000100003248	addq	$0x8, %rsp
000000010000324c	popq	%rbx
000000010000324d	popq	%rbp
000000010000324e	jmp	_fwp_rc_wide_drop
0000000100003253	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr:
0000000100003260	movq	%rdi, %rax
0000000100003263	subq	0x11dce(%rip), %rax
000000010000326a	movq	0x11def(%rip), %rcx
0000000100003271	shlq	$0x10, %rcx
0000000100003275	cmpq	%rcx, %rax
0000000100003278	jae	0x100003345
000000010000327e	pushq	%rbp
000000010000327f	movq	%rsp, %rbp
0000000100003282	pushq	%rbx
0000000100003283	pushq	%rax
0000000100003284	movq	0x11df5(%rip), %rdx
000000010000328b	movq	%rax, %rcx
000000010000328e	shrq	$0x10, %rcx
0000000100003292	imulq	$0x1228, %rcx, %rsi             ## imm = 0x1228
0000000100003299	leaq	(%rdx,%rsi), %rcx
000000010000329d	movzbl	(%rdx,%rsi), %edx
00000001000032a1	cmpb	$0x2, %dl
00000001000032a4	setne	%sil
00000001000032a8	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000032ae	setne	%r8b
00000001000032b2	orb	%sil, %r8b
00000001000032b5	jne	0x1000032c5
00000001000032b7	addq	$0x228, %rcx                    ## imm = 0x228
00000001000032be	cmpb	$0x1, (%rcx)
00000001000032c1	je	0x1000032e4
00000001000032c3	jmp	0x10000333f
00000001000032c5	cmpb	$0x1, %dl
00000001000032c8	jne	0x10000333f
00000001000032ca	movl	0x20(%rcx), %edx
00000001000032cd	imulq	%rdx, %rax
00000001000032d1	shrq	$0x20, %rax
00000001000032d5	addq	%rax, %rcx
00000001000032d8	addq	$0x228, %rcx                    ## imm = 0x228
00000001000032df	cmpb	$0x1, (%rcx)
00000001000032e2	jne	0x10000333f
00000001000032e4	movl	_fwp_reuse_verify(%rip), %eax
00000001000032ea	testl	%eax, %eax
00000001000032ec	js	0x1000032fb
00000001000032ee	testl	%eax, %eax
00000001000032f0	je	0x100003314
00000001000032f2	movq	$0x0, (%rdi)
00000001000032f9	jmp	0x10000333f
00000001000032fb	leaq	-0xc(%rbp), %rax
00000001000032ff	movq	%rdi, %rbx
0000000100003302	movq	%rax, %rdi
0000000100003305	callq	_fwp_rc_free_arr.cold.1
000000010000330a	movq	%rbx, %rdi
000000010000330d	movl	-0xc(%rbp), %eax
0000000100003310	testl	%eax, %eax
0000000100003312	jne	0x1000032f2
0000000100003314	movq	_fwp_gc(%rip), %rbx
000000010000331b	callq	_fwp_mem_free
0000000100003320	movq	_fwp_gc(%rip), %rax
0000000100003327	subq	%rbx, %rax
000000010000332a	cvtsi2sd	%rax, %xmm0
000000010000332f	addsd	0x11ed9(%rip), %xmm0
0000000100003337	movsd	%xmm0, 0x11ed1(%rip)
000000010000333f	addq	$0x8, %rsp
0000000100003343	popq	%rbx
0000000100003344	popq	%rbp
0000000100003345	retq
0000000100003346	nopw	%cs:(%rax,%rax)
_fwp_rc_wide_drop:
0000000100003350	pushq	%rbp
0000000100003351	movq	%rsp, %rbp
0000000100003354	pushq	%rbx
0000000100003355	pushq	%rax
0000000100003356	movq	%rdi, %rax
0000000100003359	shrq	$0x11, %rax
000000010000335d	xorl	%edi, %eax
000000010000335f	movl	%eax, %ecx
0000000100003361	shrl	$0x9, %ecx
0000000100003364	xorl	%eax, %ecx
0000000100003366	movzbl	%cl, %eax
0000000100003369	leaq	_fwp_gc(%rip), %rcx
0000000100003370	movq	0x1218(%rcx,%rax,8), %rax
0000000100003378	testq	%rax, %rax
000000010000337b	je	0x10000338e
000000010000337d	nopl	(%rax)
0000000100003380	cmpq	%rdi, (%rax)
0000000100003383	je	0x1000033bc
0000000100003385	movq	0x10(%rax), %rax
0000000100003389	testq	%rax, %rax
000000010000338c	jne	0x100003380
000000010000338e	callq	_fwp_flush
0000000100003393	movq	0xfc9e(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000339a	movq	(%rax), %rdi
000000010000339d	leaq	0xe89b(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000033a4	leaq	0xe86d(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000033ab	xorl	%eax, %eax
00000001000033ad	callq	0x10001148a                     ## symbol stub for: _fprintf
00000001000033b2	movl	$0x65, %edi
00000001000033b7	callq	0x100011478                     ## symbol stub for: _exit
00000001000033bc	movq	0x8(%rax), %rcx
00000001000033c0	decq	%rcx
00000001000033c3	movq	%rcx, 0x8(%rax)
00000001000033c7	cmpq	$0xfe, %rcx
00000001000033ce	jne	0x1000033db
00000001000033d0	movq	%rdi, %rbx
00000001000033d3	callq	_fwp_rc_forget_slot
00000001000033d8	movb	$-0x2, (%rbx)
00000001000033db	addq	$0x8, %rsp
00000001000033df	popq	%rbx
00000001000033e0	popq	%rbp
00000001000033e1	retq
00000001000033e2	nopw	%cs:(%rax,%rax)
_fwp_mem_free:
00000001000033f0	testq	%rdi, %rdi
00000001000033f3	je	0x100003605
00000001000033f9	movq	0x11c38(%rip), %rax
0000000100003400	movq	%rdi, %rcx
0000000100003403	subq	%rax, %rcx
0000000100003406	movq	0x11c53(%rip), %rdx
000000010000340d	shlq	$0x10, %rdx
0000000100003411	cmpq	%rdx, %rcx
0000000100003414	jae	0x100003605
000000010000341a	pushq	%rbp
000000010000341b	movq	%rsp, %rbp
000000010000341e	pushq	%r15
0000000100003420	pushq	%r14
0000000100003422	pushq	%r13
0000000100003424	pushq	%r12
0000000100003426	pushq	%rbx
0000000100003427	pushq	%rax
0000000100003428	movq	0x11c51(%rip), %r14
000000010000342f	testq	%r14, %r14
0000000100003432	je	0x1000035f7
0000000100003438	movq	%rcx, %rbx
000000010000343b	shrq	$0x10, %rbx
000000010000343f	imulq	$0x1228, %rbx, %r15             ## imm = 0x1228
0000000100003446	addq	%r15, %r14
0000000100003449	movzbl	(%r14), %edx
000000010000344d	cmpl	$0x2, %edx
0000000100003450	je	0x1000034fe
0000000100003456	cmpl	$0x1, %edx
0000000100003459	jne	0x1000035f7
000000010000345f	movzbl	0x1(%r14), %eax
0000000100003464	movzbl	0x2(%r14), %r8d
0000000100003469	imulq	$0x3c0, %rax, %r9               ## imm = 0x3C0
0000000100003470	movl	0x8(%r14), %esi
0000000100003474	movzwl	%di, %eax
0000000100003477	xorl	%edx, %edx
0000000100003479	divl	%esi
000000010000347b	movq	$-0x2, %rdx
0000000100003482	movl	%eax, %ecx
0000000100003484	rolq	%cl, %rdx
0000000100003487	leaq	_fwp_gc(%rip), %r15
000000010000348e	addq	%r9, %r15
0000000100003491	movl	%eax, %ecx
0000000100003493	shrl	$0x3, %ecx
0000000100003496	andl	$0x1ff8, %ecx                   ## imm = 0x1FF8
000000010000349c	andq	%rdx, 0x28(%r14,%rcx)
00000001000034a1	leaq	(%r8,%r8,2), %r12
00000001000034a5	leaq	(%r14,%rax), %rbx
00000001000034a9	addq	$0x228, %rbx                    ## imm = 0x228
00000001000034b0	cmpb	$-0x1, 0x228(%r14,%rax)
00000001000034b9	je	0x100003606
00000001000034bf	leaq	(%r15,%r12,8), %r15
00000001000034c3	addq	$0x8, %r15
00000001000034c7	movb	$0x0, (%rbx)
00000001000034ca	cmpl	$0x0, 0x11b3b(%rip)
00000001000034d1	je	0x1000034e4
00000001000034d3	movl	%esi, %esi
00000001000034d5	movq	%rdi, %rbx
00000001000034d8	callq	0x10001141e                     ## symbol stub for: ___bzero
00000001000034dd	movq	%rbx, %rdi
00000001000034e0	movl	0x8(%r14), %esi
00000001000034e4	movq	(%r15), %rax
00000001000034e7	notq	%rax
00000001000034ea	movq	%rax, (%rdi)
00000001000034ed	movq	%rdi, (%r15)
00000001000034f0	movl	%esi, %eax
00000001000034f2	addq	%rax, _fwp_gc(%rip)
00000001000034f9	jmp	0x1000035f7
00000001000034fe	andq	$-0x10000, %rcx                 ## imm = 0xFFFF0000
0000000100003505	addq	%rcx, %rax
0000000100003508	cmpq	%rdi, %rax
000000010000350b	jne	0x1000035f7
0000000100003511	movq	0x18(%r14), %rax
0000000100003515	addq	%rax, _fwp_gc(%rip)
000000010000351c	movb	$0x0, 0x3(%r14)
0000000100003521	cmpb	$-0x1, 0x228(%r14)
0000000100003529	je	0x10000361d
000000010000352f	movb	$0x0, 0x228(%r14)
0000000100003537	movl	0x10(%r14), %eax
000000010000353b	testq	%rax, %rax
000000010000353e	je	0x1000035d0
0000000100003544	movq	0x11b35(%rip), %rcx
000000010000354b	movl	%eax, %edx
000000010000354d	andl	$0x3, %edx
0000000100003550	cmpl	$0x4, %eax
0000000100003553	jae	0x100003559
0000000100003555	xorl	%esi, %esi
0000000100003557	jmp	0x100003598
0000000100003559	leaq	(%rcx,%r15), %rdi
000000010000355d	movl	%eax, %r8d
0000000100003560	andl	$-0x4, %r8d
0000000100003564	xorl	%esi, %esi
0000000100003566	nopw	%cs:(%rax,%rax)
0000000100003570	movb	$0x0, (%rdi)
0000000100003573	movb	$0x0, 0x1228(%rdi)
000000010000357a	movb	$0x0, 0x2450(%rdi)
0000000100003581	movb	$0x0, 0x3678(%rdi)
0000000100003588	addq	$0x4, %rsi
000000010000358c	addq	$0x48a0, %rdi                   ## imm = 0x48A0
0000000100003593	cmpq	%rsi, %r8
0000000100003596	jne	0x100003570
0000000100003598	testq	%rdx, %rdx
000000010000359b	je	0x1000035d0
000000010000359d	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
00000001000035a4	addq	%r15, %rsi
00000001000035a7	addq	%rsi, %rcx
00000001000035aa	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000035b1	xorl	%esi, %esi
00000001000035b3	nopw	%cs:(%rax,%rax)
00000001000035c0	movb	$0x0, (%rcx,%rsi)
00000001000035c4	addq	$0x1228, %rsi                   ## imm = 0x1228
00000001000035cb	cmpq	%rsi, %rdx
00000001000035ce	jne	0x1000035c0
00000001000035d0	addq	%rax, 0x11c11(%rip)
00000001000035d7	cmpq	0x11a9a(%rip), %rbx
00000001000035de	jae	0x1000035e7
00000001000035e0	movq	%rbx, 0x11a91(%rip)
00000001000035e7	cmpq	0x11a82(%rip), %rbx
00000001000035ee	jae	0x1000035f7
00000001000035f0	movq	%rbx, 0x11a79(%rip)
00000001000035f7	addq	$0x8, %rsp
00000001000035fb	popq	%rbx
00000001000035fc	popq	%r12
00000001000035fe	popq	%r13
0000000100003600	popq	%r14
0000000100003602	popq	%r15
0000000100003604	popq	%rbp
0000000100003605	retq
0000000100003606	movq	%rdi, %r13
0000000100003609	movq	%rbx, %rdi
000000010000360c	callq	_fwp_rc_forget_slot
0000000100003611	movq	%r13, %rdi
0000000100003614	movl	0x8(%r14), %esi
0000000100003618	jmp	0x1000034bf
000000010000361d	leaq	0x228(%r14), %rdi
0000000100003624	callq	_fwp_rc_forget_slot
0000000100003629	jmp	0x10000352f
000000010000362e	nop
_fwp_owner_release35:
0000000100003630	pushq	%rbp
0000000100003631	movq	%rsp, %rbp
0000000100003634	movq	(%rdi), %rdi
0000000100003637	popq	%rbp
0000000100003638	jmp	_fwp_drop0
000000010000363d	nopl	(%rax)
_fwp_owner_release36:
0000000100003640	pushq	%rbp
0000000100003641	movq	%rsp, %rbp
0000000100003644	movq	(%rdi), %rdi
0000000100003647	popq	%rbp
0000000100003648	jmp	_fwp_drop0
000000010000364d	nopl	(%rax)
_fwp_owner_release40:
0000000100003650	pushq	%rbp
0000000100003651	movq	%rsp, %rbp
0000000100003654	movq	(%rdi), %rdi
0000000100003657	popq	%rbp
0000000100003658	jmp	_fwp_drop0
000000010000365d	nopl	(%rax)
_fwp_owner_release41:
0000000100003660	pushq	%rbp
0000000100003661	movq	%rsp, %rbp
0000000100003664	movq	(%rdi), %rdi
0000000100003667	popq	%rbp
0000000100003668	jmp	_fwp_drop0
000000010000366d	nopl	(%rax)
_fwp_p_array_get_typed:
0000000100003670	testq	%rdi, %rdi
0000000100003673	js	0x1000036b3
0000000100003675	movq	(%rsi), %rcx
0000000100003678	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100003682	andq	%rcx, %rax
0000000100003685	cmpq	%rdi, %rax
0000000100003688	jbe	0x1000036b3
000000010000368a	movl	$0x8, %eax
000000010000368f	testq	%rdx, %rdx
0000000100003692	je	0x1000036a8
0000000100003694	movl	(%rdx), %r8d
0000000100003697	cmpq	$0xa, %r8
000000010000369b	ja	0x1000036a8
000000010000369d	leaq	0xe2e4(%rip), %rax
00000001000036a4	movq	(%rax,%r8,8), %rax
00000001000036a8	testq	%rcx, %rcx
00000001000036ab	js	0x1000036b6
00000001000036ad	leaq	0x8(%rsi), %rcx
00000001000036b1	jmp	0x1000036ba
00000001000036b3	xorl	%eax, %eax
00000001000036b5	retq
00000001000036b6	movq	0x10(%rsi), %rcx
00000001000036ba	pushq	%rbp
00000001000036bb	movq	%rsp, %rbp
00000001000036be	pushq	%r15
00000001000036c0	pushq	%r14
00000001000036c2	pushq	%rbx
00000001000036c3	pushq	%rax
00000001000036c4	imulq	%rax, %rdi
00000001000036c8	cmpq	$0x1, %rax
00000001000036cc	movq	%rsi, %r14
00000001000036cf	je	0x1000036f0
00000001000036d1	cmpq	$0x2, %rax
00000001000036d5	je	0x1000036e3
00000001000036d7	cmpq	$0x8, %rax
00000001000036db	jne	0x1000036fd
00000001000036dd	movq	(%rcx,%rdi), %rbx
00000001000036e1	jmp	0x10000370a
00000001000036e3	cmpl	$0x1, (%rdx)
00000001000036e6	movzwl	(%rcx,%rdi), %eax
00000001000036ea	movswq	%ax, %rbx
00000001000036ee	jmp	0x100003706
00000001000036f0	cmpl	$0x0, (%rdx)
00000001000036f3	movzbl	(%rcx,%rdi), %eax
00000001000036f7	movsbq	%al, %rbx
00000001000036fb	jmp	0x100003706
00000001000036fd	cmpl	$0x2, (%rdx)
0000000100003700	movl	(%rcx,%rdi), %eax
0000000100003703	movslq	%eax, %rbx
0000000100003706	cmovneq	%rax, %rbx
000000010000370a	movq	%rbx, -0x20(%rbp)
000000010000370e	movl	$0x10, %edi
0000000100003713	callq	_fwp_alloc_init
0000000100003718	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100003722	movq	%rcx, (%rax)
0000000100003725	movq	%rbx, 0x8(%rax)
0000000100003729	leaq	-0x20(%rbp), %rcx
000000010000372d	movq	%rax, %rdx
0000000100003730	subq	0x11901(%rip), %rdx
0000000100003737	movq	0x11922(%rip), %rcx
000000010000373e	shlq	$0x10, %rcx
0000000100003742	cmpq	%rcx, %rdx
0000000100003745	movq	%r14, %rcx
0000000100003748	jae	0x1000037c3
000000010000374a	movq	0x1192f(%rip), %rsi
0000000100003751	movq	%rdx, %rdi
0000000100003754	shrq	$0x10, %rdi
0000000100003758	imulq	$0x1228, %rdi, %rdi             ## imm = 0x1228
000000010000375f	leaq	(%rsi,%rdi), %rbx
0000000100003763	movzbl	(%rsi,%rdi), %esi
0000000100003767	cmpb	$0x2, %sil
000000010000376b	setne	%dil
000000010000376f	andq	$0xffff, %rdx                   ## imm = 0xFFFF
0000000100003776	setne	%r8b
000000010000377a	orb	%dil, %r8b
000000010000377d	jne	0x100003790
000000010000377f	addq	$0x228, %rbx                    ## imm = 0x228
0000000100003786	cmpb	$-0x1, (%rbx)
0000000100003789	je	0x1000037b0
000000010000378b	movb	$0x1, (%rbx)
000000010000378e	jmp	0x1000037c3
0000000100003790	cmpb	$0x1, %sil
0000000100003794	jne	0x1000037c3
0000000100003796	movl	0x20(%rbx), %esi
0000000100003799	imulq	%rsi, %rdx
000000010000379d	shrq	$0x20, %rdx
00000001000037a1	addq	%rdx, %rbx
00000001000037a4	addq	$0x228, %rbx                    ## imm = 0x228
00000001000037ab	cmpb	$-0x1, (%rbx)
00000001000037ae	jne	0x10000378b
00000001000037b0	movq	%rbx, %rdi
00000001000037b3	movq	%rax, %r15
00000001000037b6	callq	_fwp_rc_forget_slot
00000001000037bb	movq	%r15, %rax
00000001000037be	movq	%r14, %rcx
00000001000037c1	jmp	0x10000378b
00000001000037c3	addq	$0x8, %rsp
00000001000037c7	popq	%rbx
00000001000037c8	popq	%r14
00000001000037ca	popq	%r15
00000001000037cc	popq	%rbp
00000001000037cd	retq
00000001000037ce	nop
_fwp_data:
00000001000037d0	pushq	%rbp
00000001000037d1	movq	%rsp, %rbp
00000001000037d4	pushq	%r15
00000001000037d6	pushq	%r14
00000001000037d8	pushq	%r12
00000001000037da	pushq	%rbx
00000001000037db	movl	%edi, %r14d
00000001000037de	testl	%esi, %esi
00000001000037e0	je	0x100003882
00000001000037e6	movq	%rdx, %rbx
00000001000037e9	movl	%esi, %r15d
00000001000037ec	leaq	0x8(,%r15,8), %rdi
00000001000037f4	movl	%esi, %r12d
00000001000037f7	callq	_fwp_alloc_init
00000001000037fc	movl	%r14d, (%rax)
00000001000037ff	movl	%r12d, 0x4(%rax)
0000000100003803	cmpl	$0x7, %r12d
0000000100003807	jbe	0x100003819
0000000100003809	movq	%rax, %rcx
000000010000380c	subq	%rbx, %rcx
000000010000380f	addq	$0x8, %rcx
0000000100003813	cmpq	$0x20, %rcx
0000000100003817	jae	0x100003887
0000000100003819	xorl	%ecx, %ecx
000000010000381b	movq	%r15, %rsi
000000010000381e	movq	%rcx, %rdx
0000000100003821	andq	$0x3, %rsi
0000000100003825	je	0x100003841
0000000100003827	movq	%rcx, %rdx
000000010000382a	nopw	(%rax,%rax)
0000000100003830	movq	(%rbx,%rdx,8), %rdi
0000000100003834	movq	%rdi, 0x8(%rax,%rdx,8)
0000000100003839	incq	%rdx
000000010000383c	decq	%rsi
000000010000383f	jne	0x100003830
0000000100003841	subq	%r15, %rcx
0000000100003844	cmpq	$-0x4, %rcx
0000000100003848	ja	0x1000038c5
000000010000384a	nopw	(%rax,%rax)
0000000100003850	movq	(%rbx,%rdx,8), %rcx
0000000100003854	movq	%rcx, 0x8(%rax,%rdx,8)
0000000100003859	movq	0x8(%rbx,%rdx,8), %rcx
000000010000385e	movq	%rcx, 0x10(%rax,%rdx,8)
0000000100003863	movq	0x10(%rbx,%rdx,8), %rcx
0000000100003868	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000386d	movq	0x18(%rbx,%rdx,8), %rcx
0000000100003872	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100003877	addq	$0x4, %rdx
000000010000387b	cmpq	%rdx, %r15
000000010000387e	jne	0x100003850
0000000100003880	jmp	0x1000038c5
0000000100003882	movl	%r14d, %eax
0000000100003885	jmp	0x1000038c5
0000000100003887	movl	%r15d, %ecx
000000010000388a	andl	$-0x4, %ecx
000000010000388d	leaq	(,%r15,8), %rdx
0000000100003895	andq	$-0x20, %rdx
0000000100003899	xorl	%esi, %esi
000000010000389b	nopl	(%rax,%rax)
00000001000038a0	movups	(%rbx,%rsi), %xmm0
00000001000038a4	movups	0x10(%rbx,%rsi), %xmm1
00000001000038a9	movups	%xmm0, 0x8(%rax,%rsi)
00000001000038ae	movups	%xmm1, 0x18(%rax,%rsi)
00000001000038b3	addq	$0x20, %rsi
00000001000038b7	cmpq	%rsi, %rdx
00000001000038ba	jne	0x1000038a0
00000001000038bc	cmpl	%r15d, %ecx
00000001000038bf	jne	0x10000381b
00000001000038c5	popq	%rbx
00000001000038c6	popq	%r12
00000001000038c8	popq	%r14
00000001000038ca	popq	%r15
00000001000038cc	popq	%rbp
00000001000038cd	retq
00000001000038ce	nop
_fwp_alloc_init:
00000001000038d0	pushq	%rbp
00000001000038d1	movq	%rsp, %rbp
00000001000038d4	pushq	%rbx
00000001000038d5	pushq	%rax
00000001000038d6	cmpq	$0x4000, %rdi                   ## imm = 0x4000
00000001000038dd	ja	0x1000039cd
00000001000038e3	leaq	0xf(%rdi), %rdx
00000001000038e7	shrq	$0x4, %rdx
00000001000038eb	leaq	_fwp_gc(%rip), %rax
00000001000038f2	movzbl	0xbe8(%rdx,%rax), %ecx
00000001000038fa	movl	0xb48(%rax,%rcx,4), %esi
0000000100003901	movq	_fwp_gc(%rip), %r8
0000000100003908	movq	%r8, %r9
000000010000390b	subq	%rsi, %r9
000000010000390e	movq	%r9, _fwp_gc(%rip)
0000000100003915	js	0x1000039cd
000000010000391b	leaq	(%rcx,%rcx,2), %r9
000000010000391f	leaq	(%rax,%r9,8), %r9
0000000100003923	addq	$0x8, %r9
0000000100003927	movq	(%r9), %rbx
000000010000392a	testq	%rbx, %rbx
000000010000392d	je	0x100003964
000000010000392f	movq	(%rbx), %rax
0000000100003932	notq	%rax
0000000100003935	movq	%rax, (%r9)
0000000100003938	andl	$0x7ff8, %edi                   ## imm = 0x7FF8
000000010000393e	cmpq	%rsi, %rdi
0000000100003941	jae	0x1000039ea
0000000100003947	leaq	(%rbx,%rdi), %rax
000000010000394b	notq	%rdi
000000010000394e	addq	%rsi, %rdi
0000000100003951	andq	$-0x8, %rdi
0000000100003955	addq	$0x8, %rdi
0000000100003959	movq	%rdi, %rsi
000000010000395c	movq	%rax, %rdi
000000010000395f	jmp	0x1000039e5
0000000100003964	movq	0x8(%r9), %rbx
0000000100003968	movq	0x10(%r9), %r10
000000010000396c	subq	%rbx, %r10
000000010000396f	cmpq	%rsi, %r10
0000000100003972	jb	0x10000399c
0000000100003974	leaq	(%rbx,%rsi), %rcx
0000000100003978	movq	%rcx, 0x8(%r9)
000000010000397c	testq	%rbx, %rbx
000000010000397f	jne	0x100003938
0000000100003981	movzbl	0xbe8(%rdx,%rax), %ecx
0000000100003989	movl	0xb48(%rax,%rcx,4), %esi
0000000100003990	subq	%rsi, %r8
0000000100003993	movq	%r8, _fwp_gc(%rip)
000000010000399a	js	0x1000039cd
000000010000399c	leaq	(%rcx,%rcx,2), %rdx
00000001000039a0	leaq	(%rax,%rdx,8), %rcx
00000001000039a4	addq	$0x8, %rcx
00000001000039a8	movq	0x8(%rax,%rdx,8), %rbx
00000001000039ad	testq	%rbx, %rbx
00000001000039b0	je	0x1000039bd
00000001000039b2	movq	(%rbx), %rax
00000001000039b5	notq	%rax
00000001000039b8	movq	%rax, (%rcx)
00000001000039bb	jmp	0x1000039e2
00000001000039bd	movq	0x8(%rcx), %rbx
00000001000039c1	movq	0x10(%rcx), %rax
00000001000039c5	subq	%rbx, %rax
00000001000039c8	cmpq	%rsi, %rax
00000001000039cb	jae	0x1000039da
00000001000039cd	xorl	%esi, %esi
00000001000039cf	addq	$0x8, %rsp
00000001000039d3	popq	%rbx
00000001000039d4	popq	%rbp
00000001000039d5	jmp	_fwp_gc_alloc_slow
00000001000039da	leaq	(%rbx,%rsi), %rax
00000001000039de	movq	%rax, 0x8(%rcx)
00000001000039e2	movq	%rbx, %rdi
00000001000039e5	callq	0x10001141e                     ## symbol stub for: ___bzero
00000001000039ea	movq	%rbx, %rax
00000001000039ed	addq	$0x8, %rsp
00000001000039f1	popq	%rbx
00000001000039f2	popq	%rbp
00000001000039f3	retq
00000001000039f4	nopw	%cs:(%rax,%rax)
_fwp_gc_alloc_slow:
0000000100003a00	pushq	%rbp
0000000100003a01	movq	%rsp, %rbp
0000000100003a04	pushq	%r15
0000000100003a06	pushq	%r14
0000000100003a08	pushq	%r13
0000000100003a0a	pushq	%r12
0000000100003a0c	pushq	%rbx
0000000100003a0d	pushq	%rax
0000000100003a0e	movl	%esi, %r14d
0000000100003a11	movq	%rdi, %rbx
0000000100003a14	cmpl	$0x0, 0x115d9(%rip)
0000000100003a1b	je	0x100003a3f
0000000100003a1d	cmpq	$0x4001, %rbx                   ## imm = 0x4001
0000000100003a24	jb	0x100003a4d
0000000100003a26	movq	%rbx, %rdi
0000000100003a29	movl	%r14d, %esi
0000000100003a2c	addq	$0x8, %rsp
0000000100003a30	popq	%rbx
0000000100003a31	popq	%r12
0000000100003a33	popq	%r13
0000000100003a35	popq	%r14
0000000100003a37	popq	%r15
0000000100003a39	popq	%rbp
0000000100003a3a	jmp	_fwp_gc_alloc_big
0000000100003a3f	callq	_fwp_gc_init
0000000100003a44	cmpq	$0x4001, %rbx                   ## imm = 0x4001
0000000100003a4b	jae	0x100003a26
0000000100003a4d	leaq	0xf(%rbx), %rax
0000000100003a51	shrq	$0x4, %rax
0000000100003a55	leaq	_fwp_gc(%rip), %r12
0000000100003a5c	movzbl	0xbe8(%rax,%r12), %r13d
0000000100003a65	movl	0xb48(%r12,%r13,4), %r15d
0000000100003a6d	cmpq	$0x0, _fwp_gc(%rip)
0000000100003a75	jns	0x100003a7c
0000000100003a77	callq	_fwp_gc_spent
0000000100003a7c	movl	%r14d, %eax
0000000100003a7f	imulq	$0x3c0, %rax, %rax              ## imm = 0x3C0
0000000100003a86	addq	%rax, %r12
0000000100003a89	leaq	(,%r13,2), %rax
0000000100003a91	addq	%r13, %rax
0000000100003a94	leaq	(%r12,%rax,8), %rdi
0000000100003a98	addq	$0x8, %rdi
0000000100003a9c	movq	0x8(%r12,%rax,8), %r12
0000000100003aa1	testq	%r12, %r12
0000000100003aa4	je	0x100003ab2
0000000100003aa6	movq	(%r12), %rax
0000000100003aaa	notq	%rax
0000000100003aad	movq	%rax, (%rdi)
0000000100003ab0	jmp	0x100003ada
0000000100003ab2	movq	0x8(%rdi), %r12
0000000100003ab6	movq	0x10(%rdi), %rax
0000000100003aba	subq	%r12, %rax
0000000100003abd	cmpq	%r15, %rax
0000000100003ac0	jae	0x100003ad2
0000000100003ac2	movl	%r13d, %esi
0000000100003ac5	movl	%r14d, %edx
0000000100003ac8	callq	_fwp_gc_refill
0000000100003acd	movq	%rax, %r12
0000000100003ad0	jmp	0x100003ada
0000000100003ad2	leaq	(%r12,%r15), %rax
0000000100003ad6	movq	%rax, 0x8(%rdi)
0000000100003ada	cmpl	$0x1, %r14d
0000000100003ade	cmoveq	%rbx, %r15
0000000100003ae2	movq	%r12, %rdi
0000000100003ae5	movq	%r15, %rsi
0000000100003ae8	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100003aed	movq	%r12, %rax
0000000100003af0	addq	$0x8, %rsp
0000000100003af4	popq	%rbx
0000000100003af5	popq	%r12
0000000100003af7	popq	%r13
0000000100003af9	popq	%r14
0000000100003afb	popq	%r15
0000000100003afd	popq	%rbp
0000000100003afe	retq
0000000100003aff	nop
_fwp_gc_init:
0000000100003b00	pushq	%rbp
0000000100003b01	movq	%rsp, %rbp
0000000100003b04	pushq	%r14
0000000100003b06	pushq	%rbx
0000000100003b07	movl	$0x1, 0x114e3(%rip)
0000000100003b11	movaps	0xda98(%rip), %xmm0
0000000100003b18	movups	%xmm0, 0x11031(%rip)
0000000100003b1f	movaps	0xda9a(%rip), %xmm0
0000000100003b26	movups	%xmm0, 0x11033(%rip)
0000000100003b2d	movaps	0xda9c(%rip), %xmm0
0000000100003b34	movups	%xmm0, 0x11035(%rip)
0000000100003b3b	movaps	0xda9e(%rip), %xmm0
0000000100003b42	movups	%xmm0, 0x11037(%rip)
0000000100003b49	movaps	0xdaa0(%rip), %xmm0
0000000100003b50	movups	%xmm0, 0x11039(%rip)
0000000100003b57	movaps	0xdaa2(%rip), %xmm0
0000000100003b5e	movups	%xmm0, 0x1103b(%rip)
0000000100003b65	movaps	0xdaa4(%rip), %xmm0
0000000100003b6c	movups	%xmm0, 0x1103d(%rip)
0000000100003b73	movaps	0xdaa6(%rip), %xmm0
0000000100003b7a	movups	%xmm0, 0x1103f(%rip)
0000000100003b81	movaps	0xdaa8(%rip), %xmm0
0000000100003b88	movups	%xmm0, 0x11041(%rip)
0000000100003b8f	movaps	0xdaaa(%rip), %xmm0
0000000100003b96	movups	%xmm0, 0x11043(%rip)
0000000100003b9d	xorl	%ecx, %ecx
0000000100003b9f	leaq	_fwp_gc(%rip), %rax
0000000100003ba6	xorl	%edx, %edx
0000000100003ba8	nopl	(%rax,%rax)
0000000100003bb0	movl	%edx, %esi
0000000100003bb2	shll	$0x4, %esi
0000000100003bb5	decq	%rcx
0000000100003bb8	movq	%rcx, %rdi
0000000100003bbb	nopl	(%rax,%rax)
0000000100003bc0	movq	%rdi, %rcx
0000000100003bc3	incq	%rdi
0000000100003bc6	cmpl	0xb4c(%rax,%rcx,4), %esi
0000000100003bcd	ja	0x100003bc0
0000000100003bcf	movb	%dil, 0xbe8(%rdx,%rax)
0000000100003bd7	cmpq	$0x400, %rdx                    ## imm = 0x400
0000000100003bde	je	0x100003c0d
0000000100003be0	movq	%rdx, %rsi
0000000100003be3	orq	$0x1, %rsi
0000000100003be7	movl	%esi, %edi
0000000100003be9	shll	$0x4, %edi
0000000100003bec	nopl	(%rax)
0000000100003bf0	movq	%rcx, %r8
0000000100003bf3	incq	%rcx
0000000100003bf6	cmpl	0xb4c(%rax,%r8,4), %edi
0000000100003bfe	ja	0x100003bf0
0000000100003c00	movb	%cl, 0xbe8(%rsi,%rax)
0000000100003c07	addq	$0x2, %rdx
0000000100003c0b	jmp	0x100003bb0
0000000100003c0d	movabsq	$0x1000000000, %rbx             ## imm = 0x1000000000
0000000100003c17	leaq	0x10000(%rbx), %rsi
0000000100003c1e	xorl	%edi, %edi
0000000100003c20	xorl	%edx, %edx
0000000100003c22	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c27	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c2d	xorl	%r9d, %r9d
0000000100003c30	callq	0x1000114ea                     ## symbol stub for: _mmap
0000000100003c35	cmpq	$-0x1, %rax
0000000100003c39	jne	0x100003c9b
0000000100003c3b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100003c45	leaq	0x10000(%rbx), %rsi
0000000100003c4c	xorl	%edi, %edi
0000000100003c4e	xorl	%edx, %edx
0000000100003c50	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c55	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c5b	xorl	%r9d, %r9d
0000000100003c5e	callq	0x1000114ea                     ## symbol stub for: _mmap
0000000100003c63	cmpq	$-0x1, %rax
0000000100003c67	jne	0x100003c9b
0000000100003c69	movabsq	$__mh_execute_header, %rbx
0000000100003c73	leaq	0x10000(%rbx), %rsi
0000000100003c7a	xorl	%edi, %edi
0000000100003c7c	xorl	%edx, %edx
0000000100003c7e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c83	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c89	xorl	%r9d, %r9d
0000000100003c8c	callq	0x1000114ea                     ## symbol stub for: _mmap
0000000100003c91	cmpq	$-0x1, %rax
0000000100003c95	je	0x100003e4d
0000000100003c9b	testq	%rax, %rax
0000000100003c9e	je	0x100003eae
0000000100003ca4	movq	%rax, 0x11395(%rip)
0000000100003cab	movq	%rbx, %rcx
0000000100003cae	orq	$0x10000, %rcx                  ## imm = 0x10000
0000000100003cb5	movq	%rcx, 0x1138c(%rip)
0000000100003cbc	addq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100003cc2	andq	$-0x10000, %rax                 ## imm = 0xFFFF0000
0000000100003cc8	movq	%rax, 0x11369(%rip)
0000000100003ccf	shrq	$0x10, %rbx
0000000100003cd3	movq	%rbx, 0x1137e(%rip)
0000000100003cda	imulq	$0x1228, %rbx, %rsi             ## imm = 0x1228
0000000100003ce1	movq	%rsi, 0x113a0(%rip)
0000000100003ce8	xorl	%edi, %edi
0000000100003cea	xorl	%edx, %edx
0000000100003cec	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003cf1	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003cf7	xorl	%r9d, %r9d
0000000100003cfa	callq	0x1000114ea                     ## symbol stub for: _mmap
0000000100003cff	cmpq	$-0x1, %rax
0000000100003d03	je	0x100003eae
0000000100003d09	movq	%rax, 0x11370(%rip)
0000000100003d10	leaq	0xdf6f(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003d17	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100003d1c	movl	$0x1, %r14d
0000000100003d22	testq	%rax, %rax
0000000100003d25	je	0x100003d52
0000000100003d27	movq	%rax, %rbx
0000000100003d2a	leaq	0xdf5c(%rip), %rsi              ## literal pool for: "off"
0000000100003d31	movq	%rax, %rdi
0000000100003d34	callq	0x100011550                     ## symbol stub for: _strcmp
0000000100003d39	testl	%eax, %eax
0000000100003d3b	je	0x100003d4f
0000000100003d3d	cmpb	$0x30, (%rbx)
0000000100003d40	jne	0x100003d52
0000000100003d42	xorl	%r14d, %r14d
0000000100003d45	cmpb	$0x0, 0x1(%rbx)
0000000100003d49	setne	%r14b
0000000100003d4d	jmp	0x100003d52
0000000100003d4f	xorl	%r14d, %r14d
0000000100003d52	movl	%r14d, 0x1129f(%rip)
0000000100003d59	leaq	0xdf31(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100003d60	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100003d65	testq	%rax, %rax
0000000100003d68	je	0x100003d81
0000000100003d6a	movzbl	(%rax), %ecx
0000000100003d6d	testl	%ecx, %ecx
0000000100003d6f	je	0x100003d8a
0000000100003d71	cmpl	$0x30, %ecx
0000000100003d74	jne	0x100003d85
0000000100003d76	xorl	%ecx, %ecx
0000000100003d78	cmpb	$0x0, 0x1(%rax)
0000000100003d7c	setne	%cl
0000000100003d7f	jmp	0x100003d8a
0000000100003d81	xorl	%ecx, %ecx
0000000100003d83	jmp	0x100003d8a
0000000100003d85	movl	$0x1, %ecx
0000000100003d8a	movl	%ecx, 0x11274(%rip)
0000000100003d90	leaq	0xdeef(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003d97	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100003d9c	testq	%rax, %rax
0000000100003d9f	je	0x100003db9
0000000100003da1	leaq	0xdef6(%rip), %rsi              ## literal pool for: "full"
0000000100003da8	movq	%rax, %rdi
0000000100003dab	callq	0x100011550                     ## symbol stub for: _strcmp
0000000100003db0	xorl	%ecx, %ecx
0000000100003db2	testl	%eax, %eax
0000000100003db4	setne	%cl
0000000100003db7	jmp	0x100003dbe
0000000100003db9	movl	$0x1, %ecx
0000000100003dbe	movl	%ecx, 0x11244(%rip)
0000000100003dc4	movl	$0x1, 0x11242(%rip)
0000000100003dce	leaq	0xdece(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
0000000100003dd5	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100003dda	testq	%rax, %rax
0000000100003ddd	je	0x100003df6
0000000100003ddf	movzbl	(%rax), %ecx
0000000100003de2	testl	%ecx, %ecx
0000000100003de4	je	0x100003dff
0000000100003de6	cmpl	$0x30, %ecx
0000000100003de9	jne	0x100003dfa
0000000100003deb	xorl	%ecx, %ecx
0000000100003ded	cmpb	$0x0, 0x1(%rax)
0000000100003df1	setne	%cl
0000000100003df4	jmp	0x100003dff
0000000100003df6	xorl	%ecx, %ecx
0000000100003df8	jmp	0x100003dff
0000000100003dfa	movl	$0x1, %ecx
0000000100003dff	movl	%ecx, 0x11207(%rip)
0000000100003e05	leaq	0xdea5(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
0000000100003e0c	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100003e11	testq	%rax, %rax
0000000100003e14	je	0x100003e20
0000000100003e16	movq	%rax, %rdi
0000000100003e19	callq	0x10001146c                     ## symbol stub for: _atol
0000000100003e1e	jmp	0x100003e22
0000000100003e20	xorl	%eax, %eax
0000000100003e22	xorl	%ecx, %ecx
0000000100003e24	testq	%rax, %rax
0000000100003e27	cmovgq	%rax, %rcx
0000000100003e2b	movq	%rcx, 0x111f6(%rip)
0000000100003e32	movq	$0x800000, 0x113db(%rip)        ## imm = 0x800000
0000000100003e3d	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
0000000100003e48	popq	%rbx
0000000100003e49	popq	%r14
0000000100003e4b	popq	%rbp
0000000100003e4c	retq
0000000100003e4d	movl	$0x40010000, %esi               ## imm = 0x40010000
0000000100003e52	xorl	%edi, %edi
0000000100003e54	xorl	%edx, %edx
0000000100003e56	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003e5b	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003e61	xorl	%r9d, %r9d
0000000100003e64	callq	0x1000114ea                     ## symbol stub for: _mmap
0000000100003e69	cmpq	$-0x1, %rax
0000000100003e6d	je	0x100003e7e
0000000100003e6f	testq	%rax, %rax
0000000100003e72	je	0x100003eae
0000000100003e74	movl	$0x40000000, %ebx               ## imm = 0x40000000
0000000100003e79	jmp	0x100003ca4
0000000100003e7e	movl	$0x10010000, %esi               ## imm = 0x10010000
0000000100003e83	xorl	%edi, %edi
0000000100003e85	xorl	%edx, %edx
0000000100003e87	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003e8c	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003e92	xorl	%r9d, %r9d
0000000100003e95	callq	0x1000114ea                     ## symbol stub for: _mmap
0000000100003e9a	leaq	0x1(%rax), %rcx
0000000100003e9e	cmpq	$0x2, %rcx
0000000100003ea2	jb	0x100003eae
0000000100003ea4	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100003ea9	jmp	0x100003ca4
0000000100003eae	movq	0xf183(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003eb5	movq	(%rax), %rcx
0000000100003eb8	leaq	0xde00(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100003ebf	movl	$0x13, %esi
0000000100003ec4	movl	$0x1, %edx
0000000100003ec9	callq	0x1000114a8                     ## symbol stub for: _fwrite
0000000100003ece	movl	$0x66, %edi
0000000100003ed3	callq	0x100011478                     ## symbol stub for: _exit
0000000100003ed8	nopl	(%rax,%rax)
_fwp_gc_alloc_big:
0000000100003ee0	pushq	%rbp
0000000100003ee1	movq	%rsp, %rbp
0000000100003ee4	pushq	%r15
0000000100003ee6	pushq	%r14
0000000100003ee8	pushq	%r13
0000000100003eea	pushq	%r12
0000000100003eec	pushq	%rbx
0000000100003eed	pushq	%rax
0000000100003eee	movabsq	$0x4000000000000001, %rax       ## imm = 0x4000000000000001
0000000100003ef8	cmpq	%rax, %rdi
0000000100003efb	jae	0x1000040a7
0000000100003f01	movl	%esi, %r15d
0000000100003f04	movq	%rdi, %rbx
0000000100003f07	subq	%rdi, _fwp_gc(%rip)
0000000100003f0e	jns	0x100003f15
0000000100003f10	callq	_fwp_gc_spent
0000000100003f15	leaq	0xffff(%rbx), %r14
0000000100003f1c	shrq	$0x10, %r14
0000000100003f20	movq	%r14, %rdi
0000000100003f23	callq	_fwp_gc_chunks
0000000100003f28	movq	0x11151(%rip), %rcx
0000000100003f2f	imulq	$0x1228, %rax, %r12             ## imm = 0x1228
0000000100003f36	movb	$0x2, (%rcx,%r12)
0000000100003f3b	movb	%r15b, 0x1(%rcx,%r12)
0000000100003f40	movw	$0x100, 0x3(%rcx,%r12)          ## imm = 0x100
0000000100003f48	movl	%r14d, 0x10(%rcx,%r12)
0000000100003f4d	movq	%rbx, 0x18(%rcx,%r12)
0000000100003f52	leaq	(%rcx,%r12), %r15
0000000100003f56	addq	$0x228, %r15                    ## imm = 0x228
0000000100003f5d	cmpb	$-0x1, 0x228(%rcx,%r12)
0000000100003f66	je	0x100004094
0000000100003f6c	movb	$0x0, (%r15)
0000000100003f70	cmpq	$0x10001, %rbx                  ## imm = 0x10001
0000000100003f77	jb	0x100004069
0000000100003f7d	movq	0x110fc(%rip), %rcx
0000000100003f84	cmpq	$0x3, %r14
0000000100003f88	movl	$0x2, %r8d
0000000100003f8e	cmovaeq	%r14, %r8
0000000100003f92	leaq	-0x1(%r8), %rsi
0000000100003f96	addq	$-0x2, %r8
0000000100003f9a	movl	%esi, %edx
0000000100003f9c	andl	$0x3, %edx
0000000100003f9f	movl	$0x1, %edi
0000000100003fa4	cmpq	$0x3, %r8
0000000100003fa8	jb	0x10000402b
0000000100003fae	leaq	(%r12,%rcx), %r8
0000000100003fb2	addq	$0x48b0, %r8                    ## imm = 0x48B0
0000000100003fb9	andq	$-0x4, %rsi
0000000100003fbd	negq	%rsi
0000000100003fc0	movb	$0x3, -0x3688(%r8)
0000000100003fc8	movb	$0x1, -0x3684(%r8)
0000000100003fd0	movl	%eax, -0x3678(%r8)
0000000100003fd7	movb	$0x3, -0x2460(%r8)
0000000100003fdf	movb	$0x1, -0x245c(%r8)
0000000100003fe7	movl	%eax, -0x2450(%r8)
0000000100003fee	movb	$0x3, -0x1238(%r8)
0000000100003ff6	movb	$0x1, -0x1234(%r8)
0000000100003ffe	movl	%eax, -0x1228(%r8)
0000000100004005	movb	$0x3, -0x10(%r8)
000000010000400a	movb	$0x1, -0xc(%r8)
000000010000400f	movl	%eax, (%r8)
0000000100004012	addq	$0x48a0, %r8                    ## imm = 0x48A0
0000000100004019	leaq	(%rsi,%rdi), %r9
000000010000401d	addq	$0x4, %r9
0000000100004021	addq	$0x4, %rdi
0000000100004025	cmpq	$0x1, %r9
0000000100004029	jne	0x100003fc0
000000010000402b	testq	%rdx, %rdx
000000010000402e	je	0x100004069
0000000100004030	imulq	$0x1228, %rdi, %rsi             ## imm = 0x1228
0000000100004037	addq	%rsi, %r12
000000010000403a	addq	%r12, %rcx
000000010000403d	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004044	xorl	%esi, %esi
0000000100004046	nopw	%cs:(%rax,%rax)
0000000100004050	movb	$0x3, (%rcx,%rsi)
0000000100004054	movb	$0x1, 0x4(%rcx,%rsi)
0000000100004059	movl	%eax, 0x10(%rcx,%rsi)
000000010000405d	addq	$0x1228, %rsi                   ## imm = 0x1228
0000000100004064	cmpq	%rsi, %rdx
0000000100004067	jne	0x100004050
0000000100004069	shlq	$0x10, %rax
000000010000406d	addq	0x10fc4(%rip), %rax
0000000100004074	movq	%rax, %rdi
0000000100004077	movq	%rbx, %rsi
000000010000407a	movq	%rax, %rbx
000000010000407d	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100004082	movq	%rbx, %rax
0000000100004085	addq	$0x8, %rsp
0000000100004089	popq	%rbx
000000010000408a	popq	%r12
000000010000408c	popq	%r13
000000010000408e	popq	%r14
0000000100004090	popq	%r15
0000000100004092	popq	%rbp
0000000100004093	retq
0000000100004094	movq	%r15, %rdi
0000000100004097	movq	%rax, %r13
000000010000409a	callq	_fwp_rc_forget_slot
000000010000409f	movq	%r13, %rax
00000001000040a2	jmp	0x100003f6c
00000001000040a7	movq	0xef8a(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000040ae	movq	(%rax), %rcx
00000001000040b1	leaq	0xdc07(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000040b8	movl	$0x13, %esi
00000001000040bd	movl	$0x1, %edx
00000001000040c2	callq	0x1000114a8                     ## symbol stub for: _fwrite
00000001000040c7	movl	$0x66, %edi
00000001000040cc	callq	0x100011478                     ## symbol stub for: _exit
00000001000040d1	nopw	%cs:(%rax,%rax)
_fwp_gc_spent:
00000001000040e0	pushq	%rbp
00000001000040e1	movq	%rsp, %rbp
00000001000040e4	cmpl	$0x0, 0x10f09(%rip)
00000001000040eb	jne	0x1000040f2
00000001000040ed	callq	_fwp_gc_init
00000001000040f2	movl	0x10f04(%rip), %ecx
00000001000040f8	testl	%ecx, %ecx
00000001000040fa	setne	%dl
00000001000040fd	movq	0x10f24(%rip), %rax
0000000100004104	testq	%rax, %rax
0000000100004107	setne	%sil
000000010000410b	andb	%dl, %sil
000000010000410e	cmpb	$0x1, %sil
0000000100004112	jne	0x100004175
0000000100004114	movq	0x10f15(%rip), %rcx
000000010000411b	incq	%rcx
000000010000411e	movq	%rcx, 0x10f0b(%rip)
0000000100004125	cmpq	%rax, %rcx
0000000100004128	jl	0x10000413a
000000010000412a	movq	$0x0, 0x10efb(%rip)
0000000100004135	callq	_fwp_gc_collect
000000010000413a	movq	0x110d7(%rip), %rax
0000000100004141	subq	_fwp_gc(%rip), %rax
0000000100004148	cvtsi2sd	%rax, %xmm0
000000010000414d	addsd	0x1109b(%rip), %xmm0
0000000100004155	movsd	%xmm0, 0x11093(%rip)
000000010000415d	movq	$0x0, 0x110b0(%rip)
0000000100004168	movq	$0x0, _fwp_gc(%rip)
0000000100004173	popq	%rbp
0000000100004174	retq
0000000100004175	testl	%ecx, %ecx
0000000100004177	je	0x10000417f
0000000100004179	popq	%rbp
000000010000417a	jmp	_fwp_gc_collect
000000010000417f	movq	0x11092(%rip), %rax
0000000100004186	subq	_fwp_gc(%rip), %rax
000000010000418d	cvtsi2sd	%rax, %xmm0
0000000100004192	addsd	0x11056(%rip), %xmm0
000000010000419a	movsd	%xmm0, 0x1104e(%rip)
00000001000041a2	movq	$0x800000, 0x1106b(%rip)        ## imm = 0x800000
00000001000041ad	movq	$0x800000, _fwp_gc(%rip)        ## imm = 0x800000
00000001000041b8	popq	%rbp
00000001000041b9	retq
00000001000041ba	nopw	(%rax,%rax)
_fwp_gc_refill:
00000001000041c0	pushq	%rbp
00000001000041c1	movq	%rsp, %rbp
00000001000041c4	pushq	%r15
00000001000041c6	pushq	%r14
00000001000041c8	pushq	%r13
00000001000041ca	pushq	%r12
00000001000041cc	pushq	%rbx
00000001000041cd	pushq	%rax
00000001000041ce	movl	%edx, %r15d
00000001000041d1	movl	%esi, %r12d
00000001000041d4	movq	%rdi, %rbx
00000001000041d7	movl	$0x1, %edi
00000001000041dc	callq	_fwp_gc_chunks
00000001000041e1	movq	%rax, %r14
00000001000041e4	leaq	_fwp_gc(%rip), %rax
00000001000041eb	movq	0x10e8e(%rip), %rsi
00000001000041f2	imulq	$0x1228, %r14, %rdi             ## imm = 0x1228
00000001000041f9	leaq	(%rsi,%rdi), %r13
00000001000041fd	movb	$0x1, (%rsi,%rdi)
0000000100004201	movb	%r15b, 0x1(%rsi,%rdi)
0000000100004206	movb	%r12b, 0x2(%rsi,%rdi)
000000010000420b	movb	$0x1, 0x4(%rsi,%rdi)
0000000100004210	movl	%r12d, %ecx
0000000100004213	movl	0xb48(%rax,%rcx,4), %ecx
000000010000421a	movl	%ecx, 0x8(%rsi,%rdi)
000000010000421e	movl	$0x10000, %eax                  ## imm = 0x10000
0000000100004223	xorl	%edx, %edx
0000000100004225	divl	%ecx
0000000100004227	movl	%eax, 0xc(%rsi,%rdi)
000000010000422b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100004230	addq	%rcx, %rax
0000000100004233	btq	$0x20, %rax
0000000100004238	jae	0x100004241
000000010000423a	xorl	%edx, %edx
000000010000423c	divq	%rcx
000000010000423f	jmp	0x100004245
0000000100004241	xorl	%edx, %edx
0000000100004243	divl	%ecx
0000000100004245	movl	%eax, 0x20(%r13)
0000000100004249	cmpq	$0x0, 0x117cf(%rip)
0000000100004251	je	0x10000427e
0000000100004253	leaq	0x228(%r13), %r15
000000010000425a	xorl	%r12d, %r12d
000000010000425d	jmp	0x10000426c
000000010000425f	nop
0000000100004260	incq	%r12
0000000100004263	cmpq	$0x1000, %r12                   ## imm = 0x1000
000000010000426a	je	0x10000427e
000000010000426c	cmpb	$-0x1, (%r15,%r12)
0000000100004271	jne	0x100004260
0000000100004273	leaq	(%r15,%r12), %rdi
0000000100004277	callq	_fwp_rc_forget_slot
000000010000427c	jmp	0x100004260
000000010000427e	leaq	0x228(%r13), %rdi
0000000100004285	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000428a	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000428f	shlq	$0x10, %r14
0000000100004293	addq	0x10d9e(%rip), %r14
000000010000429a	cmpl	$0x0, 0x10d6b(%rip)
00000001000042a1	je	0x1000042b0
00000001000042a3	movl	$0x10000, %esi                  ## imm = 0x10000
00000001000042a8	movq	%r14, %rdi
00000001000042ab	callq	0x10001141e                     ## symbol stub for: ___bzero
00000001000042b0	movl	0x8(%r13), %eax
00000001000042b4	leaq	(%r14,%rax), %rcx
00000001000042b8	movq	%rcx, 0x8(%rbx)
00000001000042bc	movl	0xc(%r13), %ecx
00000001000042c0	imulq	%rax, %rcx
00000001000042c4	addq	%r14, %rcx
00000001000042c7	movq	%rcx, 0x10(%rbx)
00000001000042cb	movq	%r14, %rax
00000001000042ce	addq	$0x8, %rsp
00000001000042d2	popq	%rbx
00000001000042d3	popq	%r12
00000001000042d5	popq	%r13
00000001000042d7	popq	%r14
00000001000042d9	popq	%r15
00000001000042db	popq	%rbp
00000001000042dc	retq
00000001000042dd	nopl	(%rax)
_fwp_gc_chunks:
00000001000042e0	pushq	%rbp
00000001000042e1	movq	%rsp, %rbp
00000001000042e4	pushq	%r15
00000001000042e6	pushq	%r14
00000001000042e8	pushq	%rbx
00000001000042e9	pushq	%rax
00000001000042ea	movq	%rdi, %rbx
00000001000042ed	xorl	%edx, %edx
00000001000042ef	cmpq	$0x1, %rdi
00000001000042f3	setne	%dl
00000001000042f6	leaq	_fwp_gc(%rip), %rcx
00000001000042fd	movq	0x1068(%rcx,%rdx,8), %rax
0000000100004305	movq	0x10d54(%rip), %r14
000000010000430c	movq	%rax, %rdi
000000010000430f	subq	%r14, %rdi
0000000100004312	jae	0x100004382
0000000100004314	leaq	0x1068(,%rdx,8), %rsi
000000010000431c	imulq	$0x1228, %rax, %r8              ## imm = 0x1228
0000000100004323	addq	0x10d56(%rip), %r8
000000010000432a	xorl	%edx, %edx
000000010000432c	xorl	%r9d, %r9d
000000010000432f	jmp	0x100004352
0000000100004331	nopw	%cs:(%rax,%rax)
0000000100004340	xorl	%r9d, %r9d
0000000100004343	decq	%rdx
0000000100004346	addq	$0x1228, %r8                    ## imm = 0x1228
000000010000434d	cmpq	%rdx, %rdi
0000000100004350	je	0x100004385
0000000100004352	cmpb	$0x0, (%r8)
0000000100004356	jne	0x100004340
0000000100004358	incq	%r9
000000010000435b	cmpq	%rbx, %r9
000000010000435e	jne	0x100004343
0000000100004360	incq	%rax
0000000100004363	movq	%rax, %rdi
0000000100004366	subq	%rdx, %rdi
0000000100004369	movq	%rdi, (%rsi,%rcx)
000000010000436d	subq	%rbx, 0x10e74(%rip)
0000000100004374	subq	%rbx, %rax
0000000100004377	subq	%rdx, %rax
000000010000437a	movq	%rax, %r14
000000010000437d	jmp	0x10000444c
0000000100004382	xorl	%r9d, %r9d
0000000100004385	subq	%r9, 0x10e5c(%rip)
000000010000438c	subq	%r9, %r14
000000010000438f	addq	%r14, %rbx
0000000100004392	movq	0x10ccf(%rip), %rdi
0000000100004399	cmpq	%rbx, %rdi
000000010000439c	jae	0x100004431
00000001000043a2	movq	0x10caf(%rip), %r15
00000001000043a9	cmpq	%rbx, %r15
00000001000043ac	jb	0x10000445a
00000001000043b2	leaq	0x40(%rbx), %rax
00000001000043b6	cmpq	%r15, %rax
00000001000043b9	cmovbq	%rax, %r15
00000001000043bd	movq	%r15, %rsi
00000001000043c0	subq	%rdi, %rsi
00000001000043c3	shlq	$0x10, %rdi
00000001000043c7	addq	0x10c6a(%rip), %rdi
00000001000043ce	shlq	$0x10, %rsi
00000001000043d2	movl	$0x3, %edx
00000001000043d7	callq	0x1000114f0                     ## symbol stub for: _mprotect
00000001000043dc	testl	%eax, %eax
00000001000043de	jne	0x10000445a
00000001000043e0	movl	$0x1d, %edi
00000001000043e5	callq	0x100011580                     ## symbol stub for: _sysconf
00000001000043ea	movq	0x10c8f(%rip), %rcx
00000001000043f1	imulq	$0x1228, 0x10c6c(%rip), %rdi    ## imm = 0x1228
00000001000043fc	addq	%rcx, %rdi
00000001000043ff	imulq	$0x1228, %r15, %rdx             ## imm = 0x1228
0000000100004406	addq	%rcx, %rdx
0000000100004409	leaq	(%rax,%rdx), %rsi
000000010000440d	decq	%rsi
0000000100004410	negq	%rax
0000000100004413	andq	%rax, %rdi
0000000100004416	andq	%rax, %rsi
0000000100004419	subq	%rdi, %rsi
000000010000441c	movl	$0x3, %edx
0000000100004421	callq	0x1000114f0                     ## symbol stub for: _mprotect
0000000100004426	testl	%eax, %eax
0000000100004428	jne	0x10000445a
000000010000442a	movq	%r15, 0x10c37(%rip)
0000000100004431	movq	%rbx, 0x10c28(%rip)
0000000100004438	shlq	$0x10, %rbx
000000010000443c	cmpq	0x10c0d(%rip), %rbx
0000000100004443	jbe	0x10000444c
0000000100004445	movq	%rbx, 0x10c04(%rip)
000000010000444c	movq	%r14, %rax
000000010000444f	addq	$0x8, %rsp
0000000100004453	popq	%rbx
0000000100004454	popq	%r14
0000000100004456	popq	%r15
0000000100004458	popq	%rbp
0000000100004459	retq
000000010000445a	movq	0xebd7(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004461	movq	(%rax), %rcx
0000000100004464	leaq	0xd854(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000446b	movl	$0x13, %esi
0000000100004470	movl	$0x1, %edx
0000000100004475	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000447a	movl	$0x66, %edi
000000010000447f	callq	0x100011478                     ## symbol stub for: _exit
0000000100004484	nopw	%cs:(%rax,%rax)
_fwp_gc_collect:
0000000100004490	pushq	%rbp
0000000100004491	movq	%rsp, %rbp
0000000100004494	pushq	%r15
0000000100004496	pushq	%r14
0000000100004498	pushq	%r13
000000010000449a	pushq	%r12
000000010000449c	pushq	%rbx
000000010000449d	subq	$0x168, %rsp                    ## imm = 0x168
00000001000044a4	movq	0xeb85(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000044ab	movq	(%rax), %rax
00000001000044ae	movq	%rax, -0x30(%rbp)
00000001000044b2	cmpl	$0x0, 0x10b47(%rip)
00000001000044b9	jne	0x100004977
00000001000044bf	movl	$0x1, 0x10b37(%rip)
00000001000044c9	leaq	-0x170(%rbp), %rsi
00000001000044d0	movl	$0x6, %edi
00000001000044d5	callq	0x100011472                     ## symbol stub for: _clock_gettime
00000001000044da	movq	0x10d37(%rip), %rax
00000001000044e1	subq	_fwp_gc(%rip), %rax
00000001000044e8	cvtsi2sd	%rax, %xmm0
00000001000044ed	addsd	0x10cfb(%rip), %xmm0
00000001000044f5	movsd	%xmm0, 0x10cf3(%rip)
00000001000044fd	cmpl	$0x0, 0x10b04(%rip)
0000000100004504	sete	%al
0000000100004507	cmpl	$0x0, 0x10b02(%rip)
000000010000450e	setne	%r15b
0000000100004512	orb	%al, %r15b
0000000100004515	cmpb	$0x1, %r15b
0000000100004519	jne	0x1000045ab
000000010000451f	movq	0x10b3a(%rip), %rax
0000000100004526	testq	%rax, %rax
0000000100004529	je	0x1000046f6
000000010000452f	movq	0x10b4a(%rip), %rdx
0000000100004536	xorl	%ecx, %ecx
0000000100004538	movl	%ecx, %r14d
000000010000453b	movq	%r14, %rbx
000000010000453e	movq	%rax, %rcx
0000000100004541	movq	%rdx, %rax
0000000100004544	jmp	0x10000456f
0000000100004546	nopw	%cs:(%rax,%rax)
0000000100004550	movb	$0x0, 0x3(%rax,%r14)
0000000100004556	movq	%rbx, %rsi
0000000100004559	incq	%rsi
000000010000455c	addq	$0x1228, %r14                   ## imm = 0x1228
0000000100004563	movq	%rsi, %rbx
0000000100004566	cmpq	%rcx, %rsi
0000000100004569	jae	0x1000046f6
000000010000456f	movzbl	(%rax,%r14), %edx
0000000100004574	cmpl	$0x2, %edx
0000000100004577	je	0x100004550
0000000100004579	cmpl	$0x1, %edx
000000010000457c	jne	0x100004556
000000010000457e	leaq	(%rax,%r14), %rdi
0000000100004582	addq	$0x28, %rdi
0000000100004586	movl	0xc(%rax,%r14), %eax
000000010000458b	addl	$0x3f, %eax
000000010000458e	shrl	$0x3, %eax
0000000100004591	andl	$-0x8, %eax
0000000100004594	movl	%eax, %esi
0000000100004596	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000459b	movq	0x10ade(%rip), %rax
00000001000045a2	movq	0x10ab7(%rip), %rcx
00000001000045a9	jmp	0x100004556
00000001000045ab	movb	%r15b, -0xd1(%rbp)
00000001000045b2	leaq	-0xd0(%rbp), %rdi
00000001000045b9	callq	0x100011520                     ## symbol stub for: _setjmp
00000001000045be	movq	$0x0, 0x10c3f(%rip)
00000001000045c9	callq	_fwp_gc_mark_all
00000001000045ce	cmpq	$0x0, 0x10a8a(%rip)
00000001000045d6	je	0x100004732
00000001000045dc	xorl	%eax, %eax
00000001000045de	jmp	0x1000045fa
00000001000045e0	movq	-0xe8(%rbp), %rcx
00000001000045e7	incq	%rcx
00000001000045ea	movq	%rcx, %rax
00000001000045ed	cmpq	0x10a6c(%rip), %rcx
00000001000045f4	jae	0x100004732
00000001000045fa	movq	0x10a7f(%rip), %r15
0000000100004601	movq	%rax, -0xe8(%rbp)
0000000100004608	imulq	$0x1228, %rax, %rax             ## imm = 0x1228
000000010000460f	cmpb	$0x2, 0x1(%r15,%rax)
0000000100004615	jne	0x1000045e0
0000000100004617	addq	%rax, %r15
000000010000461a	movzbl	(%r15), %eax
000000010000461e	cmpl	$0x2, %eax
0000000100004621	je	0x1000046cb
0000000100004627	cmpl	$0x1, %eax
000000010000462a	jne	0x1000045e0
000000010000462c	movl	0xc(%r15), %eax
0000000100004630	addl	$0x3f, %eax
0000000100004633	cmpl	$0x40, %eax
0000000100004636	jb	0x1000045e0
0000000100004638	movq	-0xe8(%rbp), %r12
000000010000463f	shlq	$0x10, %r12
0000000100004643	addq	0x109ee(%rip), %r12
000000010000464a	shrl	$0x6, %eax
000000010000464d	movq	%rax, -0x108(%rbp)
0000000100004654	xorl	%eax, %eax
0000000100004656	movl	%eax, %r14d
0000000100004659	jmp	0x10000467a
000000010000465b	nopl	(%rax,%rax)
0000000100004660	movq	-0xf0(%rbp), %rax
0000000100004667	incq	%rax
000000010000466a	movq	%rax, %r14
000000010000466d	cmpq	-0x108(%rbp), %rax
0000000100004674	je	0x1000045e0
000000010000467a	movq	%r14, -0xf0(%rbp)
0000000100004681	movq	0x28(%r15,%r14,8), %r13
0000000100004686	testq	%r13, %r13
0000000100004689	je	0x100004660
000000010000468b	movq	-0xf0(%rbp), %rbx
0000000100004692	shlq	$0x6, %rbx
0000000100004696	nopw	%cs:(%rax,%rax)
00000001000046a0	tzcntq	%r13, %rax
00000001000046a5	orq	%rbx, %rax
00000001000046a8	leaq	-0x1(%r13), %r14
00000001000046ac	movl	0x8(%r15), %ecx
00000001000046b0	movl	%ecx, %esi
00000001000046b2	imulq	%rsi, %rax
00000001000046b6	movq	%rax, %rdi
00000001000046b9	addq	%r12, %rdi
00000001000046bc	callq	_fwp_gc_push
00000001000046c1	andq	%r13, %r14
00000001000046c4	movq	%r14, %r13
00000001000046c7	jne	0x1000046a0
00000001000046c9	jmp	0x100004660
00000001000046cb	cmpb	$0x0, 0x3(%r15)
00000001000046d0	je	0x1000045e0
00000001000046d6	movq	-0xe8(%rbp), %rdi
00000001000046dd	shlq	$0x10, %rdi
00000001000046e1	addq	0x10950(%rip), %rdi
00000001000046e8	movq	0x18(%r15), %rsi
00000001000046ec	callq	_fwp_gc_push
00000001000046f1	jmp	0x1000045e0
00000001000046f6	leaq	-0xd0(%rbp), %rdi
00000001000046fd	callq	0x100011520                     ## symbol stub for: _setjmp
0000000100004702	movq	$0x0, 0x10afb(%rip)
000000010000470d	callq	_fwp_gc_mark_all
0000000100004712	callq	_fwp_gc_finalize
0000000100004717	callq	_fwp_gc_sweep
000000010000471c	movq	0x10abd(%rip), %rax
0000000100004723	incq	%rax
0000000100004726	movq	%rax, 0x10ab3(%rip)
000000010000472d	jmp	0x10000484f
0000000100004732	movq	0x10a6f(%rip), %rax
0000000100004739	testq	%rax, %rax
000000010000473c	je	0x100004777
000000010000473e	xorl	%ebx, %ebx
0000000100004740	movq	0x10a59(%rip), %rcx
0000000100004747	decq	%rax
000000010000474a	movq	%rax, 0x10a57(%rip)
0000000100004751	shlq	$0x4, %rax
0000000100004755	movq	(%rcx,%rax), %rdi
0000000100004759	movq	0x8(%rcx,%rax), %rsi
000000010000475e	addq	%rdi, %rsi
0000000100004761	movl	%ebx, %edx
0000000100004763	callq	_fwp_gc_scan
0000000100004768	movq	0x10a39(%rip), %rcx
000000010000476f	movq	%rcx, %rax
0000000100004772	testq	%rcx, %rcx
0000000100004775	jne	0x100004740
0000000100004777	cmpl	$0x0, 0x1088e(%rip)
000000010000477e	movzbl	-0xd1(%rbp), %r15d
0000000100004786	je	0x10000482d
000000010000478c	movq	0x108cd(%rip), %r14
0000000100004793	movq	%r14, %rdi
0000000100004796	shlq	$0x9, %rdi
000000010000479a	callq	0x1000114c6                     ## symbol stub for: _malloc
000000010000479f	movq	%rax, %rbx
00000001000047a2	cmpq	$0x1, %r14
00000001000047a6	movq	%r14, %rdi
00000001000047a9	adcq	$0x0, %rdi
00000001000047ad	movq	%rdi, -0x150(%rbp)
00000001000047b4	callq	0x1000114c6                     ## symbol stub for: _malloc
00000001000047b9	movq	%rbx, -0xe0(%rbp)
00000001000047c0	testq	%rbx, %rbx
00000001000047c3	je	0x100004db3
00000001000047c9	testq	%rax, %rax
00000001000047cc	je	0x100004db3
00000001000047d2	movq	-0xe0(%rbp), %rcx
00000001000047d9	movq	%rcx, -0x100(%rbp)
00000001000047e0	movq	%rax, %r12
00000001000047e3	testq	%r14, %r14
00000001000047e6	je	0x100004814
00000001000047e8	movq	%r12, %rdx
00000001000047eb	movq	0x1088e(%rip), %rcx
00000001000047f2	cmpq	$0x1, %r14
00000001000047f6	movq	%r14, -0x148(%rbp)
00000001000047fd	movq	%rcx, -0x120(%rbp)
0000000100004804	jne	0x10000499d
000000010000480a	xorl	%eax, %eax
000000010000480c	movq	%rdx, %r12
000000010000480f	jmp	0x100004a2e
0000000100004814	callq	_fwp_gc_mark_all
0000000100004819	movq	-0x100(%rbp), %rdi
0000000100004820	callq	0x1000114a2                     ## symbol stub for: _free
0000000100004825	movq	%r12, %rdi
0000000100004828	callq	0x1000114a2                     ## symbol stub for: _free
000000010000482d	callq	_fwp_gc_finalize
0000000100004832	callq	_fwp_gc_sweep
0000000100004837	movq	0x109a2(%rip), %rax
000000010000483e	incq	%rax
0000000100004841	movq	%rax, 0x10998(%rip)
0000000100004848	incq	0x107d1(%rip)
000000010000484f	movq	%rax, %rcx
0000000100004852	movq	0x10977(%rip), %rax
0000000100004859	cmpq	0x10978(%rip), %rax
0000000100004860	jbe	0x100004869
0000000100004862	movq	%rax, 0x1096f(%rip)
0000000100004869	testb	%r15b, %r15b
000000010000486c	je	0x100004879
000000010000486e	movq	%rax, 0x107a3(%rip)
0000000100004875	xorl	%edx, %edx
0000000100004877	jmp	0x1000048a6
0000000100004879	movq	0x10798(%rip), %rdx
0000000100004880	movq	%rdx, %rsi
0000000100004883	shrq	%rsi
0000000100004886	addq	%rdx, %rsi
0000000100004889	cmpq	$0x1000001, %rsi                ## imm = 0x1000001
0000000100004890	movl	$0x1000000, %edx                ## imm = 0x1000000
0000000100004895	cmovaeq	%rsi, %rdx
0000000100004899	xorl	%esi, %esi
000000010000489b	cmpq	%rdx, %rax
000000010000489e	seta	%dl
00000001000048a1	movb	%dl, %sil
00000001000048a4	movl	%esi, %edx
00000001000048a6	testb	$0x7, %cl
00000001000048a9	movl	$0x1, %ecx
00000001000048ae	cmovnel	%edx, %ecx
00000001000048b1	cmpq	$0x0, 0x1076f(%rip)
00000001000048b9	cmovel	%edx, %ecx
00000001000048bc	movl	%ecx, 0x1074e(%rip)
00000001000048c2	cmpl	$0x0, 0x1073f(%rip)
00000001000048c9	sete	%cl
00000001000048cc	shlq	%cl, %rax
00000001000048cf	cvttsd2si	0x10930(%rip), %rcx
00000001000048d8	addq	%rax, %rcx
00000001000048db	cmpq	$0x800001, %rcx                 ## imm = 0x800001
00000001000048e2	movl	$0x800000, %eax                 ## imm = 0x800000
00000001000048e7	cmovgeq	%rcx, %rax
00000001000048eb	movq	%rax, 0x10926(%rip)
00000001000048f2	movq	%rax, _fwp_gc(%rip)
00000001000048f9	leaq	-0x160(%rbp), %rsi
0000000100004900	movl	$0x6, %edi
0000000100004905	callq	0x100011472                     ## symbol stub for: _clock_gettime
000000010000490a	movq	-0x160(%rbp), %rax
0000000100004911	movq	-0x158(%rbp), %rcx
0000000100004918	subq	-0x170(%rbp), %rax
000000010000491f	cvtsi2sd	%rax, %xmm1
0000000100004924	mulsd	0xcdf4(%rip), %xmm1
000000010000492c	subq	-0x168(%rbp), %rcx
0000000100004933	xorps	%xmm0, %xmm0
0000000100004936	cvtsi2sd	%rcx, %xmm0
000000010000493b	divsd	0xcde5(%rip), %xmm0
0000000100004943	addsd	%xmm1, %xmm0
0000000100004947	movsd	0x108a9(%rip), %xmm1
000000010000494f	addsd	%xmm0, %xmm1
0000000100004953	movsd	%xmm1, 0x1089d(%rip)
000000010000495b	ucomisd	0x1089d(%rip), %xmm0
0000000100004963	jbe	0x10000496d
0000000100004965	movsd	%xmm0, 0x10893(%rip)
000000010000496d	movl	$0x0, 0x10689(%rip)
0000000100004977	movq	0xe6b2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000497e	movq	(%rax), %rax
0000000100004981	cmpq	-0x30(%rbp), %rax
0000000100004985	jne	0x100004bc9
000000010000498b	addq	$0x168, %rsp                    ## imm = 0x168
0000000100004992	popq	%rbx
0000000100004993	popq	%r12
0000000100004995	popq	%r13
0000000100004997	popq	%r14
0000000100004999	popq	%r15
000000010000499b	popq	%rbp
000000010000499c	retq
000000010000499d	movq	%r14, %r12
00000001000049a0	andq	$-0x2, %r12
00000001000049a4	movq	%r12, -0x110(%rbp)
00000001000049ab	movq	-0xe0(%rbp), %rax
00000001000049b2	leaq	0x200(%rax), %r14
00000001000049b9	leaq	0x1250(%rcx), %r13
00000001000049c0	xorl	%eax, %eax
00000001000049c2	movl	%eax, %ecx
00000001000049c4	movl	$0x200, %ebx                    ## imm = 0x200
00000001000049c9	movq	%rdx, %r12
00000001000049cc	nopl	(%rax)
00000001000049d0	movq	%rcx, %r15
00000001000049d3	leaq	-0x200(%r14), %rdi
00000001000049da	leaq	-0x1228(%r13), %rsi
00000001000049e1	movq	%rbx, %rdx
00000001000049e4	callq	0x1000114d8                     ## symbol stub for: _memcpy
00000001000049e9	movzbl	-0x124d(%r13), %eax
00000001000049f1	movb	%al, (%r12,%r15)
00000001000049f5	movq	%r14, %rdi
00000001000049f8	movq	%r13, %rsi
00000001000049fb	movq	%rbx, %rdx
00000001000049fe	callq	0x1000114d8                     ## symbol stub for: _memcpy
0000000100004a03	movzbl	-0x25(%r13), %eax
0000000100004a08	movb	%al, 0x1(%r12,%r15)
0000000100004a0d	addq	$0x2, %r15
0000000100004a11	addq	$0x400, %r14                    ## imm = 0x400
0000000100004a18	addq	$0x2450, %r13                   ## imm = 0x2450
0000000100004a1f	movq	%r15, %rax
0000000100004a22	movq	%r15, %rcx
0000000100004a25	cmpq	%r15, -0x110(%rbp)
0000000100004a2c	jne	0x1000049d0
0000000100004a2e	movq	-0x148(%rbp), %r13
0000000100004a35	testb	$0x1, %r13b
0000000100004a39	movq	-0x120(%rbp), %r15
0000000100004a40	je	0x100004a76
0000000100004a42	movq	%rax, %rbx
0000000100004a45	movq	%rax, %rdi
0000000100004a48	shlq	$0x9, %rdi
0000000100004a4c	addq	-0xe0(%rbp), %rdi
0000000100004a53	imulq	$0x1228, %rax, %r14             ## imm = 0x1228
0000000100004a5a	leaq	(%r15,%r14), %rsi
0000000100004a5e	addq	$0x28, %rsi
0000000100004a62	movl	$0x200, %edx                    ## imm = 0x200
0000000100004a67	callq	0x1000114d8                     ## symbol stub for: _memcpy
0000000100004a6c	movzbl	0x3(%r15,%r14), %eax
0000000100004a72	movb	%al, (%r12,%rbx)
0000000100004a76	xorl	%eax, %eax
0000000100004a78	movl	%eax, %r14d
0000000100004a7b	movq	%r14, %rbx
0000000100004a7e	movq	%r13, %rcx
0000000100004a81	movq	%r15, %rax
0000000100004a84	movzbl	-0xd1(%rbp), %r15d
0000000100004a8c	jmp	0x100004aab
0000000100004a8e	nop
0000000100004a90	movb	$0x0, 0x3(%rax,%r14)
0000000100004a96	movq	%rbx, %rsi
0000000100004a99	incq	%rsi
0000000100004a9c	addq	$0x1228, %r14                   ## imm = 0x1228
0000000100004aa3	movq	%rsi, %rbx
0000000100004aa6	cmpq	%rcx, %rsi
0000000100004aa9	jae	0x100004ae7
0000000100004aab	movzbl	(%rax,%r14), %edx
0000000100004ab0	cmpl	$0x2, %edx
0000000100004ab3	je	0x100004a90
0000000100004ab5	cmpl	$0x1, %edx
0000000100004ab8	jne	0x100004a96
0000000100004aba	leaq	(%rax,%r14), %rdi
0000000100004abe	addq	$0x28, %rdi
0000000100004ac2	movl	0xc(%rax,%r14), %eax
0000000100004ac7	addl	$0x3f, %eax
0000000100004aca	shrl	$0x3, %eax
0000000100004acd	andl	$-0x8, %eax
0000000100004ad0	movl	%eax, %esi
0000000100004ad2	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100004ad7	movq	0x105a2(%rip), %rax
0000000100004ade	movq	0x1057b(%rip), %rcx
0000000100004ae5	jmp	0x100004a96
0000000100004ae7	callq	_fwp_gc_mark_all
0000000100004aec	movq	0x1058d(%rip), %rcx
0000000100004af3	leaq	0x28(%rcx), %rdi
0000000100004af7	xorl	%edx, %edx
0000000100004af9	movl	%edx, %esi
0000000100004afb	movq	-0x100(%rbp), %r8
0000000100004b02	jmp	0x100004b30
0000000100004b04	testq	%r11, %r11
0000000100004b07	jne	0x100004bce
0000000100004b0d	nopl	(%rax)
0000000100004b10	movq	%rsi, %rax
0000000100004b13	incq	%rax
0000000100004b16	addq	$0x200, %r8                     ## imm = 0x200
0000000100004b1d	addq	$0x1228, %rdi                   ## imm = 0x1228
0000000100004b24	movq	%rax, %rsi
0000000100004b27	cmpq	%r13, %rax
0000000100004b2a	je	0x100004819
0000000100004b30	imulq	$0x1228, %rsi, %r9              ## imm = 0x1228
0000000100004b37	leaq	(%rcx,%r9), %rax
0000000100004b3b	movzbl	(%rcx,%r9), %r9d
0000000100004b40	cmpl	$0x2, %r9d
0000000100004b44	je	0x100004ba0
0000000100004b46	cmpl	$0x1, %r9d
0000000100004b4a	jne	0x100004b10
0000000100004b4c	movl	0xc(%rax), %r9d
0000000100004b50	addl	$0x3f, %r9d
0000000100004b54	cmpl	$0x40, %r9d
0000000100004b58	jb	0x100004b10
0000000100004b5a	shrl	$0x6, %r9d
0000000100004b5e	movq	$-0x40, %r14
0000000100004b65	movl	%edx, %ebx
0000000100004b67	nopw	(%rax,%rax)
0000000100004b70	movq	%r14, %r10
0000000100004b73	movq	(%r8,%rbx,8), %r11
0000000100004b77	notq	%r11
0000000100004b7a	andq	(%rdi,%rbx,8), %r11
0000000100004b7e	incq	%rbx
0000000100004b81	addq	$0x40, %r10
0000000100004b85	cmpq	%r9, %rbx
0000000100004b88	jae	0x100004b04
0000000100004b8e	movq	%r10, %r14
0000000100004b91	testq	%r11, %r11
0000000100004b94	je	0x100004b70
0000000100004b96	jmp	0x100004b04
0000000100004b9b	nopl	(%rax,%rax)
0000000100004ba0	cmpb	$0x0, 0x3(%rax)
0000000100004ba4	je	0x100004b10
0000000100004baa	cmpb	$0x0, (%r12,%rsi)
0000000100004baf	jne	0x100004b10
0000000100004bb5	movq	%rsi, %r15
0000000100004bb8	shlq	$0x10, %r15
0000000100004bbc	addq	0x10475(%rip), %r15
0000000100004bc3	movq	0x18(%rax), %rbx
0000000100004bc7	jmp	0x100004bed
0000000100004bc9	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100004bce	tzcntq	%r11, %r15
0000000100004bd3	shlq	$0x10, %rsi
0000000100004bd7	addq	0x1045a(%rip), %rsi
0000000100004bde	addq	%r10, %r15
0000000100004be1	movl	0x8(%rax), %edx
0000000100004be4	movl	%edx, %ebx
0000000100004be6	imulq	%rbx, %r15
0000000100004bea	addq	%rsi, %r15
0000000100004bed	movq	0xe444(%rip), %rcx              ## literal pool symbol address: ___stderrp
0000000100004bf4	movq	(%rcx), %rdi
0000000100004bf7	movzbl	0x1(%rax), %ecx
0000000100004bfb	leaq	0xd0d1(%rip), %rsi              ## literal pool for: "fwp gc verify: a minor collection missed the reachable object at %p (kind %d, %zu bytes)\n"
0000000100004c02	xorl	%r14d, %r14d
0000000100004c05	movl	%r14d, %eax
0000000100004c08	movq	%r15, %rdx
0000000100004c0b	movq	%rbx, %r8
0000000100004c0e	movb	%r14b, -0xd2(%rbp)
0000000100004c15	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100004c1a	addq	%r15, %rbx
0000000100004c1d	movq	%rbx, -0x140(%rbp)
0000000100004c24	movl	%r14d, %eax
0000000100004c27	movq	%rax, %rcx
0000000100004c2a	jmp	0x100004c53
0000000100004c2c	nopl	(%rax)
0000000100004c30	movq	-0xf8(%rbp), %rdx
0000000100004c37	incq	%rdx
0000000100004c3a	movq	%rdi, %rax
0000000100004c3d	addq	$0x10000, %rax                  ## imm = 0x10000
0000000100004c43	movq	%rdx, %rcx
0000000100004c46	cmpq	-0x150(%rbp), %rdx
0000000100004c4d	je	0x100004dae
0000000100004c53	movq	%rax, %rdi
0000000100004c56	movq	0x10423(%rip), %r12
0000000100004c5d	movq	%rcx, -0xf8(%rbp)
0000000100004c64	imulq	$0x1228, %rcx, %rax             ## imm = 0x1228
0000000100004c6b	cmpb	$0x1, (%r12,%rax)
0000000100004c70	jne	0x100004c30
0000000100004c72	addq	%rax, %r12
0000000100004c75	cmpb	$0x1, 0x1(%r12)
0000000100004c7b	je	0x100004c30
0000000100004c7d	movl	0xc(%r12), %eax
0000000100004c82	testl	%eax, %eax
0000000100004c84	je	0x100004c30
0000000100004c86	movq	-0xf8(%rbp), %rdx
0000000100004c8d	movq	%rdx, %rcx
0000000100004c90	shlq	$0x10, %rcx
0000000100004c94	movq	%rcx, -0x130(%rbp)
0000000100004c9b	xorl	%ecx, %ecx
0000000100004c9d	shlq	$0x9, %rdx
0000000100004ca1	movq	%rdx, %r8
0000000100004ca4	addq	-0xe0(%rbp), %r8
0000000100004cab	movq	%rdi, -0x138(%rbp)
0000000100004cb2	movq	%r8, -0x128(%rbp)
0000000100004cb9	jmp	0x100004cf0
0000000100004cbb	nopl	(%rax,%rax)
0000000100004cc0	movl	0xc(%r12), %eax
0000000100004cc5	movq	-0x138(%rbp), %rdi
0000000100004ccc	movq	-0x128(%rbp), %r8
0000000100004cd3	movq	-0x118(%rbp), %rsi
0000000100004cda	movq	%rsi, %rdx
0000000100004cdd	incq	%rdx
0000000100004ce0	movl	%eax, %ecx
0000000100004ce2	movl	%ecx, %esi
0000000100004ce4	movq	%rdx, %rcx
0000000100004ce7	cmpq	%rsi, %rdx
0000000100004cea	jae	0x100004c30
0000000100004cf0	movq	%rcx, %rsi
0000000100004cf3	shrq	$0x6, %rcx
0000000100004cf7	movq	(%r8,%rcx,8), %rcx
0000000100004cfb	btq	%rsi, %rcx
0000000100004cff	jae	0x100004cda
0000000100004d01	movl	0x8(%r12), %ecx
0000000100004d06	cmpq	$0x8, %rcx
0000000100004d0a	jb	0x100004cda
0000000100004d0c	movq	0x10325(%rip), %r13
0000000100004d13	movq	-0x130(%rbp), %rdx
0000000100004d1a	leaq	(%rdx,%r13), %rbx
0000000100004d1e	movl	%ecx, %r8d
0000000100004d21	movq	%rsi, -0x118(%rbp)
0000000100004d28	imulq	%rsi, %rcx
0000000100004d2c	addq	%rcx, %rbx
0000000100004d2f	addq	%rdi, %r13
0000000100004d32	addq	%rcx, %r13
0000000100004d35	xorl	%eax, %eax
0000000100004d37	movl	%eax, %r14d
0000000100004d3a	jmp	0x100004d58
0000000100004d3c	nopl	(%rax)
0000000100004d40	movl	%r8d, %eax
0000000100004d43	movq	%r14, %rcx
0000000100004d46	incq	%rcx
0000000100004d49	shrl	$0x3, %eax
0000000100004d4c	movq	%rcx, %r14
0000000100004d4f	cmpq	%rax, %rcx
0000000100004d52	jae	0x100004cc0
0000000100004d58	movq	(%r13,%r14,8), %rax
0000000100004d5d	cmpq	%r15, %rax
0000000100004d60	jb	0x100004d40
0000000100004d62	cmpq	-0x140(%rbp), %rax
0000000100004d69	jae	0x100004d40
0000000100004d6b	movq	0xe2c6(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004d72	movq	(%rax), %rdi
0000000100004d75	movzbl	0x1(%r12), %ecx
0000000100004d7b	movupd	(%rbx), %xmm0
0000000100004d7f	movq	0x10(%rbx), %rax
0000000100004d83	movq	%rsp, %rdx
0000000100004d86	movq	%rax, 0x10(%rdx)
0000000100004d8a	movupd	%xmm0, (%rdx)
0000000100004d8e	leaq	0xcf98(%rip), %rsi              ## literal pool for: "  from the old object at %p (kind %d, %u bytes), word %zu; its first words %lx %lx %lx\n"
0000000100004d95	movq	%rbx, %rdx
0000000100004d98	movq	%r14, %r9
0000000100004d9b	movzbl	-0xd2(%rbp), %eax
0000000100004da2	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100004da7	movl	0x8(%r12), %r8d
0000000100004dac	jmp	0x100004d40
0000000100004dae	callq	0x10001145a                     ## symbol stub for: _abort
0000000100004db3	movq	0xe27e(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004dba	movq	(%rax), %rcx
0000000100004dbd	leaq	0xcefb(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004dc4	movl	$0x13, %esi
0000000100004dc9	movl	$0x1, %edx
0000000100004dce	callq	0x1000114a8                     ## symbol stub for: _fwrite
0000000100004dd3	movl	$0x66, %edi
0000000100004dd8	callq	0x100011478                     ## symbol stub for: _exit
0000000100004ddd	nopl	(%rax)
_fwp_gc_mark_all:
0000000100004de0	pushq	%rbp
0000000100004de1	movq	%rsp, %rbp
0000000100004de4	pushq	%r15
0000000100004de6	pushq	%r14
0000000100004de8	pushq	%r13
0000000100004dea	pushq	%r12
0000000100004dec	pushq	%rbx
0000000100004ded	pushq	%rax
0000000100004dee	callq	_fwp_gc_sp
0000000100004df3	movq	0x10296(%rip), %rsi
0000000100004dfa	testq	%rax, %rax
0000000100004dfd	sete	%dl
0000000100004e00	movq	%rsi, %rcx
0000000100004e03	subq	%rax, %rcx
0000000100004e06	setbe	%dil
0000000100004e0a	orb	%dl, %dil
0000000100004e0d	jne	0x100004e56
0000000100004e0f	cvtsi2sd	%rcx, %xmm0
0000000100004e14	addsd	0x103ec(%rip), %xmm0
0000000100004e1c	movsd	%xmm0, 0x103e4(%rip)
0000000100004e24	movq	%rax, %rdi
0000000100004e27	movl	$0x1, %edx
0000000100004e2c	jmp	0x100004e51
0000000100004e2e	movq	0x1036b(%rip), %rcx
0000000100004e35	decq	%rax
0000000100004e38	movq	%rax, 0x10369(%rip)
0000000100004e3f	shlq	$0x4, %rax
0000000100004e43	movq	(%rcx,%rax), %rdi
0000000100004e47	movq	0x8(%rcx,%rax), %rsi
0000000100004e4c	addq	%rdi, %rsi
0000000100004e4f	xorl	%edx, %edx
0000000100004e51	callq	_fwp_gc_scan
0000000100004e56	movq	0x1034b(%rip), %rax
0000000100004e5d	testq	%rax, %rax
0000000100004e60	jne	0x100004e2e
0000000100004e62	cmpl	$0x0, 0x1032f(%rip)
0000000100004e69	jle	0x100004f34
0000000100004e6f	leaq	0x1022a(%rip), %r12
0000000100004e76	xorl	%r13d, %r13d
0000000100004e79	leaq	_fwp_gc(%rip), %rbx
0000000100004e80	leaq	0x1a20(%rbx), %r14
0000000100004e87	jmp	0x100004ead
0000000100004e89	nopl	(%rax)
0000000100004e90	movq	%r15, %rsi
0000000100004e93	xorl	%edx, %edx
0000000100004e95	callq	_fwp_gc_scan
0000000100004e9a	incq	%r13
0000000100004e9d	movslq	0x102f4(%rip), %rax
0000000100004ea4	addq	$0x10, %r12
0000000100004ea8	cmpq	%rax, %r13
0000000100004eab	jge	0x100004f28
0000000100004ead	movq	-0x8(%r12), %rdi
0000000100004eb2	movq	(%r12), %rax
0000000100004eb6	xorps	%xmm0, %xmm0
0000000100004eb9	cvtsi2sd	%rax, %xmm0
0000000100004ebe	addsd	0x1200(%rbx), %xmm0
0000000100004ec6	leaq	(%rdi,%rax), %r15
0000000100004eca	cmpq	%rbx, %rdi
0000000100004ecd	seta	%al
0000000100004ed0	movsd	%xmm0, 0x1200(%rbx)
0000000100004ed8	cmpq	%r14, %r15
0000000100004edb	setb	%cl
0000000100004ede	orb	%al, %cl
0000000100004ee0	jne	0x100004e90
0000000100004ee2	movq	%rbx, %rsi
0000000100004ee5	xorl	%edx, %edx
0000000100004ee7	callq	_fwp_gc_scan
0000000100004eec	leaq	_fwp_reuse_verify(%rip), %rdi
0000000100004ef3	jmp	0x100004e90
0000000100004ef5	nopw	%cs:(%rax,%rax)
0000000100004f00	movq	0x10299(%rip), %rcx
0000000100004f07	decq	%rax
0000000100004f0a	movq	%rax, 0x10297(%rip)
0000000100004f11	shlq	$0x4, %rax
0000000100004f15	movq	(%rcx,%rax), %rdi
0000000100004f19	movq	0x8(%rcx,%rax), %rsi
0000000100004f1e	addq	%rdi, %rsi
0000000100004f21	xorl	%edx, %edx
0000000100004f23	callq	_fwp_gc_scan
0000000100004f28	movq	0x10279(%rip), %rax
0000000100004f2f	testq	%rax, %rax
0000000100004f32	jne	0x100004f00
0000000100004f34	addq	$0x8, %rsp
0000000100004f38	popq	%rbx
0000000100004f39	popq	%r12
0000000100004f3b	popq	%r13
0000000100004f3d	popq	%r14
0000000100004f3f	popq	%r15
0000000100004f41	popq	%rbp
0000000100004f42	retq
0000000100004f43	nopw	%cs:(%rax,%rax)
_fwp_gc_finalize:
0000000100004f50	movq	0x10269(%rip), %rcx
0000000100004f57	testq	%rcx, %rcx
0000000100004f5a	je	0x10000506b
0000000100004f60	pushq	%rbp
0000000100004f61	movq	%rsp, %rbp
0000000100004f64	pushq	%r14
0000000100004f66	pushq	%rbx
0000000100004f67	movq	0x1024a(%rip), %rsi
0000000100004f6e	movq	0x100c3(%rip), %r8
0000000100004f75	movq	0x100e4(%rip), %r9
0000000100004f7c	xorl	%ebx, %ebx
0000000100004f7e	jmp	0x100004f8c
0000000100004f80	incq	%rbx
0000000100004f83	cmpq	%rcx, %rbx
0000000100004f86	jae	0x100005067
0000000100004f8c	movq	%rbx, %r10
0000000100004f8f	shlq	$0x4, %r10
0000000100004f93	movq	(%rsi,%r10), %rdi
0000000100004f97	movq	%rdi, %rdx
0000000100004f9a	subq	%r8, %rdx
0000000100004f9d	movq	%r9, %rax
0000000100004fa0	shlq	$0x10, %rax
0000000100004fa4	cmpq	%rax, %rdx
0000000100004fa7	jae	0x100004f80
0000000100004fa9	movq	0x100d0(%rip), %rax
0000000100004fb0	testq	%rax, %rax
0000000100004fb3	je	0x100004f80
0000000100004fb5	shrq	$0x10, %rdx
0000000100004fb9	imulq	$0x1228, %rdx, %r14             ## imm = 0x1228
0000000100004fc0	addq	%rax, %r14
0000000100004fc3	movzbl	(%r14), %edx
0000000100004fc7	cmpb	$0x3, %dl
0000000100004fca	jne	0x100004fdf
0000000100004fcc	movl	0x10(%r14), %edx
0000000100004fd0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100004fd7	leaq	(%rax,%rdx), %r14
0000000100004fdb	movzbl	(%rax,%rdx), %edx
0000000100004fdf	movq	0x8(%rsi,%r10), %r11
0000000100004fe4	cmpb	$0x1, %dl
0000000100004fe7	je	0x100004ffc
0000000100004fe9	movzbl	%dl, %eax
0000000100004fec	cmpl	$0x2, %eax
0000000100004fef	jne	0x100005026
0000000100004ff1	movzbl	0x3(%r14), %edx
0000000100004ff6	testl	%edx, %edx
0000000100004ff8	jne	0x100004f80
0000000100004ffa	jmp	0x100005026
0000000100004ffc	movzwl	%di, %eax
0000000100004fff	xorl	%edx, %edx
0000000100005001	divl	0x8(%r14)
0000000100005005	movl	%eax, %edx
0000000100005007	shrl	$0x3, %edx
000000010000500a	andl	$0x1ff8, %edx                   ## imm = 0x1FF8
0000000100005010	movq	0x28(%r14,%rdx), %r14
0000000100005015	xorl	%edx, %edx
0000000100005017	btq	%rax, %r14
000000010000501b	setb	%dl
000000010000501e	testl	%edx, %edx
0000000100005020	jne	0x100004f80
0000000100005026	addq	%rsi, %r10
0000000100005029	decq	%rcx
000000010000502c	movq	%rcx, 0x1018d(%rip)
0000000100005033	shlq	$0x4, %rcx
0000000100005037	movups	(%rsi,%rcx), %xmm0
000000010000503b	movups	%xmm0, (%r10)
000000010000503f	callq	*%r11
0000000100005042	movq	0x1016f(%rip), %rsi
0000000100005049	movq	0xffe8(%rip), %r8
0000000100005050	movq	0x10009(%rip), %r9
0000000100005057	movq	0x10162(%rip), %rcx
000000010000505e	cmpq	%rcx, %rbx
0000000100005061	jb	0x100004f8c
0000000100005067	popq	%rbx
0000000100005068	popq	%r14
000000010000506a	popq	%rbp
000000010000506b	retq
000000010000506c	nopl	(%rax)
_fwp_gc_sweep:
0000000100005070	pushq	%rbp
0000000100005071	movq	%rsp, %rbp
0000000100005074	pushq	%r15
0000000100005076	pushq	%r14
0000000100005078	pushq	%r13
000000010000507a	pushq	%r12
000000010000507c	pushq	%rbx
000000010000507d	subq	$0x28, %rsp
0000000100005081	leaq	0xef88(%rip), %rdi
0000000100005088	movl	$0xb40, %esi                    ## imm = 0xB40
000000010000508d	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100005092	cmpq	$0x0, 0xffc6(%rip)
000000010000509a	je	0x100005554
00000001000050a0	movq	$0x0, -0x30(%rbp)
00000001000050a8	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
00000001000050b2	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000050bc	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000050c6	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000050d0	movdqa	0xc578(%rip), %xmm6
00000001000050d8	movdqa	0xc580(%rip), %xmm7
00000001000050e0	pxor	%xmm8, %xmm8
00000001000050e5	xorl	%r15d, %r15d
00000001000050e8	xorl	%edx, %edx
00000001000050ea	jmp	0x100005106
00000001000050ec	nopl	(%rax)
00000001000050f0	incq	%r15
00000001000050f3	incq	%rdx
00000001000050f6	movq	0xff63(%rip), %rax
00000001000050fd	cmpq	%rax, %rdx
0000000100005100	jae	0x100005561
0000000100005106	movq	0xff73(%rip), %rax
000000010000510d	imulq	$0x1228, %rdx, %r14             ## imm = 0x1228
0000000100005114	movzbl	(%rax,%r14), %ecx
0000000100005119	testl	%ecx, %ecx
000000010000511b	je	0x1000050f0
000000010000511d	leaq	(%rax,%r14), %r13
0000000100005121	cmpl	$0x1, %ecx
0000000100005124	je	0x100005150
0000000100005126	cmpl	$0x2, %ecx
0000000100005129	jne	0x1000050f3
000000010000512b	movl	0x10(%r13), %r12d
000000010000512f	cmpb	$0x0, 0x3(%r13)
0000000100005134	je	0x10000517f
0000000100005136	movq	-0x30(%rbp), %rax
000000010000513a	addq	0x18(%r13), %rax
000000010000513e	movq	%rax, -0x30(%rbp)
0000000100005142	addq	%r12, %rdx
0000000100005145	decq	%rdx
0000000100005148	jmp	0x1000050f3
000000010000514a	nopw	(%rax,%rax)
0000000100005150	movq	%rdx, -0x38(%rbp)
0000000100005154	movl	0xc(%r13), %r12d
0000000100005158	testq	%r12, %r12
000000010000515b	je	0x1000053dc
0000000100005161	leaq	0x3f(%r12), %rsi
0000000100005166	movq	%rsi, %rcx
0000000100005169	shrq	$0x6, %rcx
000000010000516d	cmpl	$0xc0, %r12d
0000000100005174	ja	0x1000051e4
0000000100005176	xorl	%esi, %esi
0000000100005178	xorl	%edx, %edx
000000010000517a	jmp	0x1000052a0
000000010000517f	movq	%rdx, -0x38(%rbp)
0000000100005183	leaq	0x228(%r13), %rbx
000000010000518a	cmpb	$-0x1, 0x228(%r13)
0000000100005192	je	0x100005532
0000000100005198	movb	$0x0, (%rbx)
000000010000519b	testq	%r12, %r12
000000010000519e	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
00000001000051a8	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000051b2	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000051bc	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000051c6	je	0x100005520
00000001000051cc	movq	0xfead(%rip), %rax
00000001000051d3	cmpl	$0x4, %r12d
00000001000051d7	jae	0x1000054b2
00000001000051dd	xorl	%ecx, %ecx
00000001000051df	jmp	0x1000054e8
00000001000051e4	movl	%ecx, %edx
00000001000051e6	andl	$-0x4, %edx
00000001000051e9	leaq	(%rax,%r14), %rdi
00000001000051ed	addq	$0x38, %rdi
00000001000051f1	shrq	$0x3, %rsi
00000001000051f5	andl	$-0x20, %esi
00000001000051f8	pxor	%xmm0, %xmm0
00000001000051fc	xorl	%r8d, %r8d
00000001000051ff	pxor	%xmm1, %xmm1
0000000100005203	nopw	%cs:(%rax,%rax)
0000000100005210	movdqu	-0x10(%rdi,%r8), %xmm2
0000000100005217	movdqu	(%rdi,%r8), %xmm3
000000010000521d	movdqa	%xmm2, %xmm4
0000000100005221	pand	%xmm6, %xmm4
0000000100005225	movdqa	%xmm7, %xmm5
0000000100005229	pshufb	%xmm4, %xmm5
000000010000522e	psrlw	$0x4, %xmm2
0000000100005233	pand	%xmm6, %xmm2
0000000100005237	movdqa	%xmm7, %xmm4
000000010000523b	pshufb	%xmm2, %xmm4
0000000100005240	paddb	%xmm5, %xmm4
0000000100005244	psadbw	%xmm8, %xmm4
0000000100005249	paddq	%xmm4, %xmm0
000000010000524d	movdqa	%xmm3, %xmm2
0000000100005251	pand	%xmm6, %xmm2
0000000100005255	movdqa	%xmm7, %xmm4
0000000100005259	pshufb	%xmm2, %xmm4
000000010000525e	psrlw	$0x4, %xmm3
0000000100005263	pand	%xmm6, %xmm3
0000000100005267	movdqa	%xmm7, %xmm2
000000010000526b	pshufb	%xmm3, %xmm2
0000000100005270	paddb	%xmm4, %xmm2
0000000100005274	psadbw	%xmm8, %xmm2
0000000100005279	paddq	%xmm2, %xmm1
000000010000527d	addq	$0x20, %r8
0000000100005281	cmpq	%r8, %rsi
0000000100005284	jne	0x100005210
0000000100005286	paddq	%xmm0, %xmm1
000000010000528a	pshufd	$0xee, %xmm1, %xmm0             ## xmm0 = xmm1[2,3,2,3]
000000010000528f	paddq	%xmm1, %xmm0
0000000100005293	movq	%xmm0, %rsi
0000000100005298	cmpl	%edx, %ecx
000000010000529a	je	0x1000052e1
000000010000529c	nopl	(%rax)
00000001000052a0	movq	0x28(%r13,%rdx,8), %rdi
00000001000052a5	movq	%rdi, %r8
00000001000052a8	shrq	%r8
00000001000052ab	andq	%r9, %r8
00000001000052ae	subq	%r8, %rdi
00000001000052b1	movq	%rdi, %r8
00000001000052b4	andq	%r10, %r8
00000001000052b7	shrq	$0x2, %rdi
00000001000052bb	andq	%r10, %rdi
00000001000052be	addq	%r8, %rdi
00000001000052c1	movq	%rdi, %r8
00000001000052c4	shrq	$0x4, %r8
00000001000052c8	addq	%rdi, %r8
00000001000052cb	andq	%r11, %r8
00000001000052ce	imulq	%rbx, %r8
00000001000052d2	shrq	$0x38, %r8
00000001000052d6	addq	%r8, %rsi
00000001000052d9	incq	%rdx
00000001000052dc	cmpq	%rdx, %rcx
00000001000052df	jne	0x1000052a0
00000001000052e1	testq	%rsi, %rsi
00000001000052e4	je	0x1000053dc
00000001000052ea	movq	%r15, -0x40(%rbp)
00000001000052ee	movl	0x8(%r13), %ecx
00000001000052f2	imulq	%rcx, %rsi
00000001000052f6	addq	%rsi, -0x30(%rbp)
00000001000052fa	movzbl	0x1(%r13), %ecx
00000001000052ff	movzbl	0x2(%r13), %edx
0000000100005304	imulq	$0x3c0, %rcx, %rcx              ## imm = 0x3C0
000000010000530b	leaq	_fwp_gc(%rip), %rsi
0000000100005312	addq	%rsi, %rcx
0000000100005315	leaq	(%rdx,%rdx,2), %rdx
0000000100005319	movq	-0x38(%rbp), %rsi
000000010000531d	shlq	$0x10, %rsi
0000000100005321	addq	0xfd10(%rip), %rsi
0000000100005328	movq	%rsi, -0x48(%rbp)
000000010000532c	leaq	(%rcx,%rdx,8), %r15
0000000100005330	addq	$0x8, %r15
0000000100005334	addq	%r12, %r14
0000000100005337	leaq	(%rax,%r14), %rbx
000000010000533b	addq	$0x227, %rbx                    ## imm = 0x227
0000000100005342	decq	%r12
0000000100005345	jmp	0x100005371
0000000100005347	nopw	(%rax,%rax)
0000000100005350	cmpb	$-0x1, (%rbx)
0000000100005353	je	0x1000053ba
0000000100005355	movb	$0x0, (%rbx)
0000000100005358	movq	(%r15), %rax
000000010000535b	notq	%rax
000000010000535e	movq	%rax, (%r14)
0000000100005361	movq	%r14, (%r15)
0000000100005364	decq	%rbx
0000000100005367	addq	$-0x1, %r12
000000010000536b	jae	0x10000547d
0000000100005371	movq	%r12, %rax
0000000100005374	shrq	$0x6, %rax
0000000100005378	movq	0x28(%r13,%rax,8), %rax
000000010000537d	btq	%r12, %rax
0000000100005381	jb	0x100005364
0000000100005383	movl	0x8(%r13), %esi
0000000100005387	movq	%r12, %r14
000000010000538a	imulq	%rsi, %r14
000000010000538e	addq	-0x48(%rbp), %r14
0000000100005392	cmpl	$0x0, 0xfc73(%rip)
0000000100005399	je	0x100005350
000000010000539b	movq	%r14, %rdi
000000010000539e	callq	0x10001141e                     ## symbol stub for: ___bzero
00000001000053a3	pxor	%xmm8, %xmm8
00000001000053a8	movdqa	0xc2b0(%rip), %xmm7
00000001000053b0	movdqa	0xc298(%rip), %xmm6
00000001000053b8	jmp	0x100005350
00000001000053ba	movq	%rbx, %rdi
00000001000053bd	callq	_fwp_rc_forget_slot
00000001000053c2	pxor	%xmm8, %xmm8
00000001000053c7	movdqa	0xc291(%rip), %xmm7
00000001000053cf	movdqa	0xc279(%rip), %xmm6
00000001000053d7	jmp	0x100005355
00000001000053dc	cmpq	$0x0, 0x1063c(%rip)
00000001000053e4	je	0x10000541e
00000001000053e6	leaq	0x228(%r13), %rbx
00000001000053ed	xorl	%r14d, %r14d
00000001000053f0	jmp	0x10000540c
00000001000053f2	nopw	%cs:(%rax,%rax)
0000000100005400	incq	%r14
0000000100005403	cmpq	$0x1000, %r14                   ## imm = 0x1000
000000010000540a	je	0x10000541e
000000010000540c	cmpb	$-0x1, (%rbx,%r14)
0000000100005411	jne	0x100005400
0000000100005413	leaq	(%rbx,%r14), %rdi
0000000100005417	callq	_fwp_rc_forget_slot
000000010000541c	jmp	0x100005400
000000010000541e	leaq	0x228(%r13), %rdi
0000000100005425	movl	$0x1000, %esi                   ## imm = 0x1000
000000010000542a	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000542f	movb	$0x0, (%r13)
0000000100005434	incq	%r15
0000000100005437	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005441	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
000000010000544b	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100005455	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
000000010000545f	movdqa	0xc1e9(%rip), %xmm6
0000000100005467	movdqa	0xc1f1(%rip), %xmm7
000000010000546f	pxor	%xmm8, %xmm8
0000000100005474	movq	-0x38(%rbp), %rdx
0000000100005478	jmp	0x1000050f3
000000010000547d	movq	-0x40(%rbp), %r15
0000000100005481	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
000000010000548b	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
0000000100005495	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
000000010000549f	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000054a9	movq	-0x38(%rbp), %rdx
00000001000054ad	jmp	0x1000050f3
00000001000054b2	leaq	(%rax,%r14), %rdx
00000001000054b6	movl	%r12d, %esi
00000001000054b9	andl	$-0x4, %esi
00000001000054bc	xorl	%ecx, %ecx
00000001000054be	nop
00000001000054c0	movb	$0x0, (%rdx)
00000001000054c3	movb	$0x0, 0x1228(%rdx)
00000001000054ca	movb	$0x0, 0x2450(%rdx)
00000001000054d1	movb	$0x0, 0x3678(%rdx)
00000001000054d8	addq	$0x4, %rcx
00000001000054dc	addq	$0x48a0, %rdx                   ## imm = 0x48A0
00000001000054e3	cmpq	%rcx, %rsi
00000001000054e6	jne	0x1000054c0
00000001000054e8	movl	%r12d, %edx
00000001000054eb	andl	$0x3, %edx
00000001000054ee	je	0x100005520
00000001000054f0	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
00000001000054f7	addq	%r14, %rcx
00000001000054fa	addq	%rcx, %rax
00000001000054fd	imulq	$0x1228, %rdx, %rcx             ## imm = 0x1228
0000000100005504	xorl	%edx, %edx
0000000100005506	nopw	%cs:(%rax,%rax)
0000000100005510	movb	$0x0, (%rax,%rdx)
0000000100005514	addq	$0x1228, %rdx                   ## imm = 0x1228
000000010000551b	cmpq	%rdx, %rcx
000000010000551e	jne	0x100005510
0000000100005520	addq	%r12, %r15
0000000100005523	movq	-0x38(%rbp), %rdx
0000000100005527	addq	%r12, %rdx
000000010000552a	decq	%rdx
000000010000552d	jmp	0x1000050f3
0000000100005532	movq	%rbx, %rdi
0000000100005535	callq	_fwp_rc_forget_slot
000000010000553a	pxor	%xmm8, %xmm8
000000010000553f	movdqa	0xc119(%rip), %xmm7
0000000100005547	movdqa	0xc101(%rip), %xmm6
000000010000554f	jmp	0x100005198
0000000100005554	xorl	%r15d, %r15d
0000000100005557	movq	$0x0, -0x30(%rbp)
000000010000555f	xorl	%eax, %eax
0000000100005561	movq	-0x30(%rbp), %rdx
0000000100005565	movq	%rdx, 0xfc64(%rip)
000000010000556c	movq	%r15, 0xfc75(%rip)
0000000100005573	cmpq	$0x1000001, %rdx                ## imm = 0x1000001
000000010000557a	movl	$0x1000000, %ecx                ## imm = 0x1000000
000000010000557f	cmovaeq	%rdx, %rcx
0000000100005583	shrq	$0x10, %rcx
0000000100005587	pxor	%xmm0, %xmm0
000000010000558b	movdqu	%xmm0, 0xfadd(%rip)
0000000100005593	subq	%rcx, %r15
0000000100005596	jbe	0x100005691
000000010000559c	testq	%rax, %rax
000000010000559f	je	0x100005691
00000001000055a5	testq	%r15, %r15
00000001000055a8	je	0x100005691
00000001000055ae	movq	0xfacb(%rip), %rcx
00000001000055b5	nopw	%cs:(%rax,%rax)
00000001000055c0	leaq	-0x1(%rax), %rbx
00000001000055c4	imulq	$0x1228, %rbx, %rdx             ## imm = 0x1228
00000001000055cb	cmpb	$0x0, (%rcx,%rdx)
00000001000055cf	jne	0x100005680
00000001000055d5	addq	%rcx, %rdx
00000001000055d8	leaq	-0x1(%r15), %r14
00000001000055dc	cmpb	$0x0, 0x4(%rdx)
00000001000055e0	je	0x10000567d
00000001000055e6	movb	$0x0, 0x4(%rdx)
00000001000055ea	movl	$0x1, %esi
00000001000055ef	testq	%rbx, %rbx
00000001000055f2	je	0x10000565a
00000001000055f4	testq	%r14, %r14
00000001000055f7	je	0x10000565a
00000001000055f9	movl	$0x2, %edx
00000001000055fe	subq	%rax, %rdx
0000000100005601	imulq	$0x1228, %rax, %rax             ## imm = 0x1228
0000000100005608	addq	%rax, %rcx
000000010000560b	addq	$-0x244c, %rcx                  ## imm = 0xDBB4
0000000100005612	movl	$0x2, %edi
0000000100005617	subq	%r15, %rdi
000000010000561a	movl	$0x1, %eax
000000010000561f	nop
0000000100005620	cmpb	$0x0, -0x4(%rcx)
0000000100005624	jne	0x100005657
0000000100005626	cmpb	$0x0, (%rcx)
0000000100005629	je	0x100005657
000000010000562b	decq	%rbx
000000010000562e	leaq	(%rdx,%rax), %r8
0000000100005632	decq	%r14
0000000100005635	movb	$0x0, (%rcx)
0000000100005638	leaq	0x1(%rax), %rsi
000000010000563c	cmpq	$0x1, %r8
0000000100005640	je	0x10000565a
0000000100005642	addq	%rdi, %rax
0000000100005645	addq	$-0x1228, %rcx                  ## imm = 0xEDD8
000000010000564c	cmpq	$0x1, %rax
0000000100005650	movq	%rsi, %rax
0000000100005653	jne	0x100005620
0000000100005655	jmp	0x10000565a
0000000100005657	movq	%rax, %rsi
000000010000565a	movq	%rbx, %rdi
000000010000565d	shlq	$0x10, %rdi
0000000100005661	addq	0xf9d0(%rip), %rdi
0000000100005668	shlq	$0x10, %rsi
000000010000566c	movl	$0x4, %edx
0000000100005671	callq	0x1000114c0                     ## symbol stub for: _madvise
0000000100005676	movq	0xfa03(%rip), %rcx
000000010000567d	movq	%r14, %r15
0000000100005680	movq	%rbx, %rax
0000000100005683	testq	%rbx, %rbx
0000000100005686	je	0x100005691
0000000100005688	testq	%r15, %r15
000000010000568b	jne	0x1000055c0
0000000100005691	addq	$0x28, %rsp
0000000100005695	popq	%rbx
0000000100005696	popq	%r12
0000000100005698	popq	%r13
000000010000569a	popq	%r14
000000010000569c	popq	%r15
000000010000569e	popq	%rbp
000000010000569f	retq
_fwp_gc_sp:
00000001000056a0	pushq	%rbp
00000001000056a1	movq	%rsp, %rbp
00000001000056a4	movq	%rbp, %rax
00000001000056a7	popq	%rbp
00000001000056a8	retq
00000001000056a9	nopl	(%rax)
_fwp_gc_scan:
00000001000056b0	pushq	%rbp
00000001000056b1	movq	%rsp, %rbp
00000001000056b4	pushq	%r15
00000001000056b6	pushq	%r14
00000001000056b8	pushq	%r13
00000001000056ba	pushq	%r12
00000001000056bc	pushq	%rbx
00000001000056bd	pushq	%rax
00000001000056be	movq	%rdi, %r15
00000001000056c1	addq	$0x7, %r15
00000001000056c5	andq	$-0x8, %r15
00000001000056c9	leaq	0x8(%r15), %rax
00000001000056cd	cmpq	%rsi, %rax
00000001000056d0	jbe	0x1000056e1
00000001000056d2	addq	$0x8, %rsp
00000001000056d6	popq	%rbx
00000001000056d7	popq	%r12
00000001000056d9	popq	%r13
00000001000056db	popq	%r14
00000001000056dd	popq	%r15
00000001000056df	popq	%rbp
00000001000056e0	retq
00000001000056e1	movl	%edx, %ebx
00000001000056e3	movq	%rsi, %r14
00000001000056e6	movq	0xf94b(%rip), %r11
00000001000056ed	movq	0xf96c(%rip), %r13
00000001000056f4	shlq	$0x10, %r13
00000001000056f8	movq	%r11, -0x30(%rbp)
00000001000056fc	jmp	0x100005730
00000001000056fe	movl	0x10(%r9), %eax
0000000100005702	imulq	$0x1228, %rax, %rdx             ## imm = 0x1228
0000000100005709	addq	%rdx, %rcx
000000010000570c	movq	%rcx, %r9
000000010000570f	cmpb	$0x0, 0x3(%r9)
0000000100005714	je	0x100005919
000000010000571a	nopw	(%rax,%rax)
0000000100005720	leaq	0x8(%r15), %rax
0000000100005724	addq	$0x10, %r15
0000000100005728	cmpq	%r14, %r15
000000010000572b	movq	%rax, %r15
000000010000572e	ja	0x1000056d2
0000000100005730	movq	(%r15), %r12
0000000100005733	movq	%r12, %rax
0000000100005736	subq	%r11, %rax
0000000100005739	cmpq	%r13, %rax
000000010000573c	jae	0x100005800
0000000100005742	movq	0xf8ef(%rip), %rdi
0000000100005749	movq	%r12, %r8
000000010000574c	subq	%rdi, %r8
000000010000574f	movq	0xf90a(%rip), %rax
0000000100005756	shlq	$0x10, %rax
000000010000575a	cmpq	%rax, %r8
000000010000575d	jae	0x100005850
0000000100005763	movq	0xf916(%rip), %rcx
000000010000576a	testq	%rcx, %rcx
000000010000576d	je	0x100005850
0000000100005773	movq	%r8, %rax
0000000100005776	shrq	$0x10, %rax
000000010000577a	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
0000000100005781	addq	%rcx, %r9
0000000100005784	movzbl	(%r9), %edx
0000000100005788	cmpl	$0x3, %edx
000000010000578b	je	0x100005812
0000000100005791	cmpl	$0x2, %edx
0000000100005794	je	0x100005823
000000010000579a	cmpl	$0x1, %edx
000000010000579d	jne	0x100005850
00000001000057a3	movl	0x8(%r9), %esi
00000001000057a7	movzwl	%r12w, %eax
00000001000057ab	xorl	%edx, %edx
00000001000057ad	divl	%esi
00000001000057af	cmpl	0xc(%r9), %eax
00000001000057b3	jae	0x100005850
00000001000057b9	movl	$0x1, %edx
00000001000057be	movl	%eax, %ecx
00000001000057c0	shlq	%cl, %rdx
00000001000057c3	movl	%eax, %ecx
00000001000057c5	shrl	$0x6, %ecx
00000001000057c8	movq	0x28(%r9,%rcx,8), %r10
00000001000057cd	btq	%rax, %r10
00000001000057d1	jb	0x100005850
00000001000057d7	orq	%rdx, %r10
00000001000057da	movq	%r10, 0x28(%r9,%rcx,8)
00000001000057df	cmpb	$0x1, 0x1(%r9)
00000001000057e4	je	0x100005850
00000001000057e6	andq	$-0x10000, %r8                  ## imm = 0xFFFF0000
00000001000057ed	addq	%r8, %rdi
00000001000057f0	imulq	%rsi, %rax
00000001000057f4	addq	%rdi, %rax
00000001000057f7	movq	%rax, %rdi
00000001000057fa	jmp	0x100005841
00000001000057fc	nopl	(%rax)
0000000100005800	testl	%ebx, %ebx
0000000100005802	je	0x100005720
0000000100005808	cmpq	%r13, %rax
000000010000580b	je	0x100005858
000000010000580d	jmp	0x100005720
0000000100005812	movl	0x10(%r9), %eax
0000000100005816	imulq	$0x1228, %rax, %rdx             ## imm = 0x1228
000000010000581d	addq	%rdx, %rcx
0000000100005820	movq	%rcx, %r9
0000000100005823	cmpb	$0x0, 0x3(%r9)
0000000100005828	jne	0x100005850
000000010000582a	movb	$0x1, 0x3(%r9)
000000010000582f	cmpb	$0x1, 0x1(%r9)
0000000100005834	je	0x100005850
0000000100005836	shlq	$0x10, %rax
000000010000583a	addq	%rax, %rdi
000000010000583d	movq	0x18(%r9), %rsi
0000000100005841	callq	_fwp_gc_push
0000000100005846	movq	-0x30(%rbp), %r11
000000010000584a	nopw	(%rax,%rax)
0000000100005850	testl	%ebx, %ebx
0000000100005852	je	0x100005720
0000000100005858	decq	%r12
000000010000585b	movq	0xf7d6(%rip), %rdi
0000000100005862	movq	%r12, %r8
0000000100005865	subq	%rdi, %r8
0000000100005868	movq	0xf7f1(%rip), %rax
000000010000586f	shlq	$0x10, %rax
0000000100005873	cmpq	%rax, %r8
0000000100005876	jae	0x100005720
000000010000587c	movq	0xf7fd(%rip), %rcx
0000000100005883	testq	%rcx, %rcx
0000000100005886	je	0x100005720
000000010000588c	movq	%r8, %rax
000000010000588f	shrq	$0x10, %rax
0000000100005893	imulq	$0x1228, %rax, %r9              ## imm = 0x1228
000000010000589a	addq	%rcx, %r9
000000010000589d	movzbl	(%r9), %edx
00000001000058a1	cmpl	$0x3, %edx
00000001000058a4	je	0x1000056fe
00000001000058aa	cmpl	$0x2, %edx
00000001000058ad	je	0x10000570f
00000001000058b3	cmpl	$0x1, %edx
00000001000058b6	jne	0x100005720
00000001000058bc	movl	0x8(%r9), %esi
00000001000058c0	movzwl	%r12w, %eax
00000001000058c4	xorl	%edx, %edx
00000001000058c6	divl	%esi
00000001000058c8	cmpl	0xc(%r9), %eax
00000001000058cc	jae	0x100005720
00000001000058d2	movl	$0x1, %edx
00000001000058d7	movl	%eax, %ecx
00000001000058d9	shlq	%cl, %rdx
00000001000058dc	movl	%eax, %ecx
00000001000058de	shrl	$0x6, %ecx
00000001000058e1	movq	0x28(%r9,%rcx,8), %r10
00000001000058e6	btq	%rax, %r10
00000001000058ea	jb	0x100005720
00000001000058f0	orq	%rdx, %r10
00000001000058f3	movq	%r10, 0x28(%r9,%rcx,8)
00000001000058f8	cmpb	$0x1, 0x1(%r9)
00000001000058fd	je	0x100005720
0000000100005903	andq	$-0x10000, %r8                  ## imm = 0xFFFF0000
000000010000590a	addq	%r8, %rdi
000000010000590d	imulq	%rsi, %rax
0000000100005911	addq	%rdi, %rax
0000000100005914	movq	%rax, %rdi
0000000100005917	jmp	0x100005934
0000000100005919	movb	$0x1, 0x3(%r9)
000000010000591e	cmpb	$0x1, 0x1(%r9)
0000000100005923	je	0x100005720
0000000100005929	shlq	$0x10, %rax
000000010000592d	addq	%rax, %rdi
0000000100005930	movq	0x18(%r9), %rsi
0000000100005934	callq	_fwp_gc_push
0000000100005939	movq	-0x30(%rbp), %r11
000000010000593d	jmp	0x100005720
0000000100005942	nopw	%cs:(%rax,%rax)
_fwp_gc_push:
0000000100005950	pushq	%rbp
0000000100005951	movq	%rsp, %rbp
0000000100005954	pushq	%r14
0000000100005956	pushq	%rbx
0000000100005957	movq	%rsi, %rbx
000000010000595a	movq	%rdi, %r14
000000010000595d	movq	0xf844(%rip), %rcx
0000000100005964	movq	0xf835(%rip), %rax
000000010000596b	cmpq	0xf83e(%rip), %rcx
0000000100005972	jne	0x1000059aa
0000000100005974	leaq	(%rcx,%rcx), %rdx
0000000100005978	testq	%rcx, %rcx
000000010000597b	movl	$0x1000, %esi                   ## imm = 0x1000
0000000100005980	cmovneq	%rdx, %rsi
0000000100005984	movq	%rsi, 0xf825(%rip)
000000010000598b	shlq	$0x4, %rsi
000000010000598f	movq	%rax, %rdi
0000000100005992	callq	0x10001151a                     ## symbol stub for: _realloc
0000000100005997	movq	%rax, 0xf802(%rip)
000000010000599e	testq	%rax, %rax
00000001000059a1	je	0x1000059c9
00000001000059a3	movq	0xf7fe(%rip), %rcx
00000001000059aa	movq	%rcx, %rdx
00000001000059ad	shlq	$0x4, %rdx
00000001000059b1	movq	%r14, (%rax,%rdx)
00000001000059b5	movq	%rbx, 0x8(%rax,%rdx)
00000001000059ba	incq	%rcx
00000001000059bd	movq	%rcx, 0xf7e4(%rip)
00000001000059c4	popq	%rbx
00000001000059c5	popq	%r14
00000001000059c7	popq	%rbp
00000001000059c8	retq
00000001000059c9	movq	0xd668(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000059d0	movq	(%rax), %rcx
00000001000059d3	leaq	0xc2e5(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000059da	movl	$0x13, %esi
00000001000059df	movl	$0x1, %edx
00000001000059e4	callq	0x1000114a8                     ## symbol stub for: _fwrite
00000001000059e9	movl	$0x66, %edi
00000001000059ee	callq	0x100011478                     ## symbol stub for: _exit
00000001000059f3	nopw	%cs:(%rax,%rax)
_f29:
0000000100005a00	pushq	%rbp
0000000100005a01	movq	%rsp, %rbp
0000000100005a04	pushq	%r15
0000000100005a06	pushq	%r14
0000000100005a08	pushq	%r13
0000000100005a0a	pushq	%r12
0000000100005a0c	pushq	%rbx
0000000100005a0d	subq	$0xa8, %rsp
0000000100005a14	movq	%rdi, %rbx
0000000100005a17	movq	0xd612(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005a1e	movq	(%rax), %rax
0000000100005a21	movq	%rax, -0x30(%rbp)
0000000100005a25	movq	%rdi, -0xa8(%rbp)
0000000100005a2c	movq	_fwp_cleanups(%rip), %rax
0000000100005a33	movq	%rax, -0xa0(%rbp)
0000000100005a3a	leaq	_fwp_owner_release3(%rip), %rax
0000000100005a41	movq	%rax, -0x98(%rbp)
0000000100005a48	leaq	-0xa8(%rbp), %rax
0000000100005a4f	movq	%rax, -0x90(%rbp)
0000000100005a56	movq	$0x0, -0x58(%rbp)
0000000100005a5e	leaq	-0xa0(%rbp), %rax
0000000100005a65	movq	%rax, -0xd0(%rbp)
0000000100005a6c	leaq	_fwp_owner_release4(%rip), %rax
0000000100005a73	movq	%rax, -0xc8(%rbp)
0000000100005a7a	leaq	-0x58(%rbp), %rax
0000000100005a7e	movq	%rax, -0xc0(%rbp)
0000000100005a85	leaq	-0xd0(%rbp), %r14
0000000100005a8c	movq	%r14, _fwp_cleanups(%rip)
0000000100005a93	movq	0x10(%rdi), %rax
0000000100005a97	subq	0xf59a(%rip), %rax
0000000100005a9e	movq	0xf5bb(%rip), %rcx
0000000100005aa5	shlq	$0x10, %rcx
0000000100005aa9	cmpq	%rcx, %rax
0000000100005aac	jae	0x100005b16
0000000100005aae	movq	0xf5cb(%rip), %rcx
0000000100005ab5	movq	%rax, %rdx
0000000100005ab8	shrq	$0x10, %rdx
0000000100005abc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005ac3	leaq	(%rcx,%rdx), %rdi
0000000100005ac7	movzbl	(%rcx,%rdx), %ecx
0000000100005acb	cmpb	$0x2, %cl
0000000100005ace	setne	%dl
0000000100005ad1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005ad7	setne	%sil
0000000100005adb	orb	%dl, %sil
0000000100005ade	jne	0x100005ae9
0000000100005ae0	addq	$0x228, %rdi                    ## imm = 0x228
0000000100005ae7	jmp	0x100005b03
0000000100005ae9	cmpb	$0x1, %cl
0000000100005aec	jne	0x100005b16
0000000100005aee	movl	0x20(%rdi), %ecx
0000000100005af1	imulq	%rcx, %rax
0000000100005af5	shrq	$0x20, %rax
0000000100005af9	addq	%rax, %rdi
0000000100005afc	addq	$0x228, %rdi                    ## imm = 0x228
0000000100005b03	movzbl	(%rdi), %eax
0000000100005b06	testb	%al, %al
0000000100005b08	je	0x100005b16
0000000100005b0a	cmpb	$-0x3, %al
0000000100005b0c	ja	0x100005fb6
0000000100005b12	incb	%al
0000000100005b14	movb	%al, (%rdi)
0000000100005b16	movq	0x10(%rbx), %rdi
0000000100005b1a	movq	%rdi, -0x58(%rbp)
0000000100005b1e	movq	-0xd0(%rbp), %rax
0000000100005b25	movq	%rax, _fwp_cleanups(%rip)
0000000100005b2c	movq	0x8(%rbx), %r13
0000000100005b30	movq	0x18(%rbx), %r14
0000000100005b34	testq	%r13, %r13
0000000100005b37	js	0x100005b59
0000000100005b39	movq	(%rdi), %rax
0000000100005b3c	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100005b46	andq	%rax, %rcx
0000000100005b49	cmpq	%r13, %rcx
0000000100005b4c	jbe	0x100005b59
0000000100005b4e	testq	%rax, %rax
0000000100005b51	js	0x100005b73
0000000100005b53	leaq	0x8(%rdi), %rax
0000000100005b57	jmp	0x100005b77
0000000100005b59	callq	_fwp_drop0
0000000100005b5e	movl	$0x1, %r12d
0000000100005b64	xorl	%r15d, %r15d
0000000100005b67	movq	_fwp_cleanups(%rip), %rax
0000000100005b6e	jmp	0x100005d8e
0000000100005b73	movq	0x10(%rdi), %rax
0000000100005b77	movsd	(%rax,%r13,8), %xmm1
0000000100005b7d	movq	_fwp_cleanups(%rip), %rax
0000000100005b84	movq	%rdi, -0xb8(%rbp)
0000000100005b8b	movq	%rax, -0x70(%rbp)
0000000100005b8f	leaq	_fwp_owner_release1(%rip), %rax
0000000100005b96	movq	%rax, -0x68(%rbp)
0000000100005b9a	leaq	-0xb8(%rbp), %rax
0000000100005ba1	movq	%rax, -0x60(%rbp)
0000000100005ba5	leaq	-0x70(%rbp), %r15
0000000100005ba9	movq	%rdi, %rcx
0000000100005bac	subq	0xf485(%rip), %rcx
0000000100005bb3	movq	%r15, _fwp_cleanups(%rip)
0000000100005bba	movq	0xf49f(%rip), %rax
0000000100005bc1	shlq	$0x10, %rax
0000000100005bc5	cmpq	%rax, %rcx
0000000100005bc8	jae	0x100005c33
0000000100005bca	movq	0xf4af(%rip), %rdx
0000000100005bd1	movq	%rcx, %rax
0000000100005bd4	shrq	$0x10, %rax
0000000100005bd8	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100005bdf	leaq	(%rdx,%rsi), %rax
0000000100005be3	movzbl	(%rdx,%rsi), %edx
0000000100005be7	cmpb	$0x2, %dl
0000000100005bea	setne	%sil
0000000100005bee	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100005bf5	setne	%r8b
0000000100005bf9	orb	%sil, %r8b
0000000100005bfc	jne	0x100005c06
0000000100005bfe	addq	$0x228, %rax                    ## imm = 0x228
0000000100005c04	jmp	0x100005c1f
0000000100005c06	cmpb	$0x1, %dl
0000000100005c09	jne	0x100005c33
0000000100005c0b	movl	0x20(%rax), %edx
0000000100005c0e	imulq	%rdx, %rcx
0000000100005c12	shrq	$0x20, %rcx
0000000100005c16	addq	%rcx, %rax
0000000100005c19	addq	$0x228, %rax                    ## imm = 0x228
0000000100005c1f	movzbl	(%rax), %ecx
0000000100005c22	testb	%cl, %cl
0000000100005c24	je	0x100005c33
0000000100005c26	cmpb	$-0x3, %cl
0000000100005c29	ja	0x100005fd5
0000000100005c2f	incb	%cl
0000000100005c31	movb	%cl, (%rax)
0000000100005c33	movq	%r14, %xmm0
0000000100005c38	mulsd	0xbad0(%rip), %xmm1
0000000100005c40	addsd	0xbad0(%rip), %xmm1
0000000100005c48	incq	%r13
0000000100005c4b	addsd	%xmm0, %xmm1
0000000100005c4f	movsd	%xmm1, -0x50(%rbp)
0000000100005c54	movq	-0x70(%rbp), %rax
0000000100005c58	movq	%rax, _fwp_cleanups(%rip)
0000000100005c5f	movq	%rdi, %r15
0000000100005c62	callq	_fwp_drop0
0000000100005c67	movq	%r15, -0xb0(%rbp)
0000000100005c6e	movq	_fwp_cleanups(%rip), %rax
0000000100005c75	movq	%rax, -0x88(%rbp)
0000000100005c7c	leaq	_fwp_owner_release2(%rip), %rax
0000000100005c83	movq	%rax, -0x80(%rbp)
0000000100005c87	leaq	-0xb0(%rbp), %rax
0000000100005c8e	movq	%rax, -0x78(%rbp)
0000000100005c92	leaq	-0x88(%rbp), %r12
0000000100005c99	movq	%r12, _fwp_cleanups(%rip)
0000000100005ca0	movq	%r13, -0x48(%rbp)
0000000100005ca4	movq	%r15, -0x40(%rbp)
0000000100005ca8	movsd	-0x50(%rbp), %xmm0
0000000100005cad	movsd	%xmm0, -0x38(%rbp)
0000000100005cb2	movl	$0x20, %edi
0000000100005cb7	callq	_fwp_alloc_init
0000000100005cbc	movq	%rax, %r14
0000000100005cbf	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100005cc9	movq	%rax, (%r14)
0000000100005ccc	movq	%r13, 0x8(%r14)
0000000100005cd0	movq	%r15, 0x10(%r14)
0000000100005cd4	movsd	-0x50(%rbp), %xmm0
0000000100005cd9	movsd	%xmm0, 0x18(%r14)
0000000100005cdf	leaq	-0x48(%rbp), %rax
0000000100005ce3	movq	%r14, %rax
0000000100005ce6	subq	0xf34b(%rip), %rax
0000000100005ced	movq	0xf36c(%rip), %rcx
0000000100005cf4	shlq	$0x10, %rcx
0000000100005cf8	cmpq	%rcx, %rax
0000000100005cfb	jae	0x100005d6d
0000000100005cfd	movq	0xf37c(%rip), %rcx
0000000100005d04	movq	%rax, %rdx
0000000100005d07	shrq	$0x10, %rdx
0000000100005d0b	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005d12	leaq	(%rcx,%rdx), %r15
0000000100005d16	movzbl	(%rcx,%rdx), %ecx
0000000100005d1a	cmpb	$0x2, %cl
0000000100005d1d	setne	%dl
0000000100005d20	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005d26	setne	%sil
0000000100005d2a	orb	%dl, %sil
0000000100005d2d	jne	0x100005d42
0000000100005d2f	addq	$0x228, %r15                    ## imm = 0x228
0000000100005d36	cmpb	$-0x1, (%r15)
0000000100005d3a	je	0x100005d63
0000000100005d3c	movb	$0x1, (%r15)
0000000100005d40	jmp	0x100005d6d
0000000100005d42	cmpb	$0x1, %cl
0000000100005d45	jne	0x100005d6d
0000000100005d47	movl	0x20(%r15), %ecx
0000000100005d4b	imulq	%rcx, %rax
0000000100005d4f	shrq	$0x20, %rax
0000000100005d53	addq	%rax, %r15
0000000100005d56	addq	$0x228, %r15                    ## imm = 0x228
0000000100005d5d	cmpb	$-0x1, (%r15)
0000000100005d61	jne	0x100005d3c
0000000100005d63	movq	%r15, %rdi
0000000100005d66	callq	_fwp_rc_forget_slot
0000000100005d6b	jmp	0x100005d3c
0000000100005d6d	cmpq	%r12, _fwp_cleanups(%rip)
0000000100005d74	jne	0x100005ffa
0000000100005d7a	movq	-0x88(%rbp), %rax
0000000100005d81	movq	%rax, _fwp_cleanups(%rip)
0000000100005d88	movb	$0x1, %r15b
0000000100005d8b	xorl	%r12d, %r12d
0000000100005d8e	leaq	-0xa0(%rbp), %rcx
0000000100005d95	cmpq	%rcx, %rax
0000000100005d98	jne	0x100005ffa
0000000100005d9e	movq	-0xa0(%rbp), %rax
0000000100005da5	movq	%rax, _fwp_cleanups(%rip)
0000000100005dac	movq	%rbx, %rdi
0000000100005daf	callq	_fwp_drop1
0000000100005db4	movq	%r12, -0x88(%rbp)
0000000100005dbb	leaq	-0x80(%rbp), %rbx
0000000100005dbf	movq	%r14, -0x80(%rbp)
0000000100005dc3	testb	%r15b, %r15b
0000000100005dc6	je	0x100005e86
0000000100005dcc	movq	%r14, -0x48(%rbp)
0000000100005dd0	movq	_fwp_cleanups(%rip), %rax
0000000100005dd7	movq	%rax, -0x70(%rbp)
0000000100005ddb	leaq	_fwp_owner_release5(%rip), %rax
0000000100005de2	movq	%rax, -0x68(%rbp)
0000000100005de6	leaq	-0x48(%rbp), %rax
0000000100005dea	movq	%rax, -0x60(%rbp)
0000000100005dee	leaq	-0x70(%rbp), %r14
0000000100005df2	movq	%r14, _fwp_cleanups(%rip)
0000000100005df9	movl	$0x10, %edi
0000000100005dfe	callq	_fwp_alloc_init
0000000100005e03	movabsq	$__mh_execute_header, %rcx
0000000100005e0d	movq	%rcx, (%rax)
0000000100005e10	movq	-0x80(%rbp), %rcx
0000000100005e14	movq	%rcx, 0x8(%rax)
0000000100005e18	movq	%rax, %rcx
0000000100005e1b	subq	0xf216(%rip), %rcx
0000000100005e22	movq	0xf237(%rip), %rdx
0000000100005e29	shlq	$0x10, %rdx
0000000100005e2d	cmpq	%rdx, %rcx
0000000100005e30	jae	0x100005f42
0000000100005e36	movq	0xf243(%rip), %rdx
0000000100005e3d	movq	%rcx, %rsi
0000000100005e40	shrq	$0x10, %rsi
0000000100005e44	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100005e4b	leaq	(%rdx,%rsi), %rbx
0000000100005e4f	movzbl	(%rdx,%rsi), %edx
0000000100005e53	cmpb	$0x2, %dl
0000000100005e56	setne	%sil
0000000100005e5a	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100005e61	setne	%dil
0000000100005e65	orb	%sil, %dil
0000000100005e68	jne	0x100005f0c
0000000100005e6e	addq	$0x228, %rbx                    ## imm = 0x228
0000000100005e75	cmpb	$-0x1, (%rbx)
0000000100005e78	je	0x100005f2f
0000000100005e7e	movb	$0x1, (%rbx)
0000000100005e81	jmp	0x100005f42
0000000100005e86	movl	$0x10, %edi
0000000100005e8b	callq	_fwp_alloc_init
0000000100005e90	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100005e9a	movq	%rcx, (%rax)
0000000100005e9d	movq	%r14, 0x8(%rax)
0000000100005ea1	movq	%rax, %rcx
0000000100005ea4	subq	0xf18d(%rip), %rcx
0000000100005eab	movq	0xf1ae(%rip), %rdx
0000000100005eb2	shlq	$0x10, %rdx
0000000100005eb6	cmpq	%rdx, %rcx
0000000100005eb9	jae	0x100005f5a
0000000100005ebf	movq	0xf1ba(%rip), %rdx
0000000100005ec6	movq	%rcx, %rsi
0000000100005ec9	shrq	$0x10, %rsi
0000000100005ecd	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100005ed4	leaq	(%rdx,%rsi), %rbx
0000000100005ed8	movzbl	(%rdx,%rsi), %edx
0000000100005edc	cmpb	$0x2, %dl
0000000100005edf	setne	%sil
0000000100005ee3	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100005eea	setne	%dil
0000000100005eee	orb	%sil, %dil
0000000100005ef1	jne	0x100005f80
0000000100005ef7	addq	$0x228, %rbx                    ## imm = 0x228
0000000100005efe	cmpb	$-0x1, (%rbx)
0000000100005f01	je	0x100005fa3
0000000100005f07	movb	$0x1, (%rbx)
0000000100005f0a	jmp	0x100005f5a
0000000100005f0c	cmpb	$0x1, %dl
0000000100005f0f	jne	0x100005f42
0000000100005f11	movl	0x20(%rbx), %edx
0000000100005f14	imulq	%rdx, %rcx
0000000100005f18	shrq	$0x20, %rcx
0000000100005f1c	addq	%rcx, %rbx
0000000100005f1f	addq	$0x228, %rbx                    ## imm = 0x228
0000000100005f26	cmpb	$-0x1, (%rbx)
0000000100005f29	jne	0x100005e7e
0000000100005f2f	movq	%rbx, %rdi
0000000100005f32	movq	%rax, %r15
0000000100005f35	callq	_fwp_rc_forget_slot
0000000100005f3a	movq	%r15, %rax
0000000100005f3d	jmp	0x100005e7e
0000000100005f42	cmpq	%r14, _fwp_cleanups(%rip)
0000000100005f49	jne	0x100005ffa
0000000100005f4f	movq	-0x70(%rbp), %rcx
0000000100005f53	movq	%rcx, _fwp_cleanups(%rip)
0000000100005f5a	movq	0xd0cf(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100005f61	movq	(%rcx), %rcx
0000000100005f64	cmpq	-0x30(%rbp), %rcx
0000000100005f68	jne	0x100005fff
0000000100005f6e	addq	$0xa8, %rsp
0000000100005f75	popq	%rbx
0000000100005f76	popq	%r12
0000000100005f78	popq	%r13
0000000100005f7a	popq	%r14
0000000100005f7c	popq	%r15
0000000100005f7e	popq	%rbp
0000000100005f7f	retq
0000000100005f80	cmpb	$0x1, %dl
0000000100005f83	jne	0x100005f5a
0000000100005f85	movl	0x20(%rbx), %edx
0000000100005f88	imulq	%rdx, %rcx
0000000100005f8c	shrq	$0x20, %rcx
0000000100005f90	addq	%rcx, %rbx
0000000100005f93	addq	$0x228, %rbx                    ## imm = 0x228
0000000100005f9a	cmpb	$-0x1, (%rbx)
0000000100005f9d	jne	0x100005f07
0000000100005fa3	movq	%rbx, %rdi
0000000100005fa6	movq	%rax, %r14
0000000100005fa9	callq	_fwp_rc_forget_slot
0000000100005fae	movq	%r14, %rax
0000000100005fb1	jmp	0x100005f07
0000000100005fb6	callq	_fwp_rc_wide_dup
0000000100005fbb	movq	_fwp_cleanups(%rip), %rax
0000000100005fc2	movq	0x10(%rbx), %rdi
0000000100005fc6	movq	%rdi, -0x58(%rbp)
0000000100005fca	cmpq	%r14, %rax
0000000100005fcd	je	0x100005b1e
0000000100005fd3	jmp	0x100005ffa
0000000100005fd5	movq	%rdi, %r12
0000000100005fd8	movq	%rax, %rdi
0000000100005fdb	movsd	%xmm1, -0x50(%rbp)
0000000100005fe0	callq	_fwp_rc_wide_dup
0000000100005fe5	movsd	-0x50(%rbp), %xmm1
0000000100005fea	movq	%r12, %rdi
0000000100005fed	cmpq	%r15, _fwp_cleanups(%rip)
0000000100005ff4	je	0x100005c33
0000000100005ffa	callq	0x10001145a                     ## symbol stub for: _abort
0000000100005fff	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100006004	nopw	%cs:(%rax,%rax)
_fwp_owner_release3:
0000000100006010	pushq	%rbp
0000000100006011	movq	%rsp, %rbp
0000000100006014	movq	(%rdi), %rdi
0000000100006017	popq	%rbp
0000000100006018	jmp	_fwp_drop1
000000010000601d	nopl	(%rax)
_fwp_owner_release4:
0000000100006020	pushq	%rbp
0000000100006021	movq	%rsp, %rbp
0000000100006024	movq	(%rdi), %rdi
0000000100006027	popq	%rbp
0000000100006028	jmp	_fwp_drop0
000000010000602d	nopl	(%rax)
_fwp_drop1:
0000000100006030	movq	%rdi, %rcx
0000000100006033	subq	0xeffe(%rip), %rcx
000000010000603a	movq	0xf01f(%rip), %rax
0000000100006041	shlq	$0x10, %rax
0000000100006045	cmpq	%rax, %rcx
0000000100006048	jae	0x1000060de
000000010000604e	movq	0xf02b(%rip), %rdx
0000000100006055	movq	%rcx, %rax
0000000100006058	shrq	$0x10, %rax
000000010000605c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100006063	leaq	(%rdx,%rsi), %rax
0000000100006067	movzbl	(%rdx,%rsi), %edx
000000010000606b	cmpb	$0x2, %dl
000000010000606e	setne	%sil
0000000100006072	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100006079	setne	%r8b
000000010000607d	orb	%sil, %r8b
0000000100006080	jne	0x10000608a
0000000100006082	addq	$0x228, %rax                    ## imm = 0x228
0000000100006088	jmp	0x1000060a3
000000010000608a	cmpb	$0x1, %dl
000000010000608d	jne	0x1000060de
000000010000608f	movl	0x20(%rax), %edx
0000000100006092	imulq	%rdx, %rcx
0000000100006096	shrq	$0x20, %rcx
000000010000609a	addq	%rcx, %rax
000000010000609d	addq	$0x228, %rax                    ## imm = 0x228
00000001000060a3	movzbl	(%rax), %ecx
00000001000060a6	testl	%ecx, %ecx
00000001000060a8	je	0x1000060de
00000001000060aa	cmpl	$0x1, %ecx
00000001000060ad	jne	0x1000060d2
00000001000060af	pushq	%rbp
00000001000060b0	movq	%rsp, %rbp
00000001000060b3	pushq	%rbx
00000001000060b4	pushq	%rax
00000001000060b5	movq	0x10(%rdi), %rax
00000001000060b9	movq	%rdi, %rbx
00000001000060bc	movq	%rax, %rdi
00000001000060bf	callq	_fwp_drop0
00000001000060c4	movq	%rbx, %rdi
00000001000060c7	addq	$0x8, %rsp
00000001000060cb	popq	%rbx
00000001000060cc	popq	%rbp
00000001000060cd	jmp	_fwp_rc_free_obj
00000001000060d2	cmpl	$0xff, %ecx
00000001000060d8	je	0x1000060df
00000001000060da	decb	%cl
00000001000060dc	movb	%cl, (%rax)
00000001000060de	retq
00000001000060df	movq	%rax, %rdi
00000001000060e2	jmp	_fwp_rc_wide_drop
00000001000060e7	nopw	(%rax,%rax)
_fwp_rc_wide_dup:
00000001000060f0	pushq	%rbp
00000001000060f1	movq	%rsp, %rbp
00000001000060f4	pushq	%r14
00000001000060f6	pushq	%rbx
00000001000060f7	movq	%rdi, %rbx
00000001000060fa	movq	%rdi, %rax
00000001000060fd	shrq	$0x11, %rax
0000000100006101	xorl	%ebx, %eax
0000000100006103	movl	%eax, %ecx
0000000100006105	shrl	$0x9, %ecx
0000000100006108	xorl	%eax, %ecx
000000010000610a	movzbl	%cl, %eax
000000010000610d	leaq	_fwp_gc(%rip), %rcx
0000000100006114	leaq	(%rcx,%rax,8), %r14
0000000100006118	addq	$0x1218, %r14                   ## imm = 0x1218
000000010000611f	movq	0x1218(%rcx,%rax,8), %rax
0000000100006127	testq	%rax, %rax
000000010000612a	je	0x100006153
000000010000612c	cmpq	%rbx, (%rax)
000000010000612f	je	0x100006160
0000000100006131	nopw	%cs:(%rax,%rax)
0000000100006140	movq	%rax, %r14
0000000100006143	movq	0x10(%rax), %rax
0000000100006147	testq	%rax, %rax
000000010000614a	je	0x10000615a
000000010000614c	cmpq	%rbx, (%rax)
000000010000614f	jne	0x100006140
0000000100006151	jmp	0x10000615c
0000000100006153	cmpb	$-0x2, (%rbx)
0000000100006156	je	0x10000616e
0000000100006158	jmp	0x1000061c4
000000010000615a	xorl	%eax, %eax
000000010000615c	addq	$0x10, %r14
0000000100006160	cmpb	$-0x2, (%rbx)
0000000100006163	jne	0x1000061a6
0000000100006165	testq	%rax, %rax
0000000100006168	jne	0x10000620d
000000010000616e	movl	$0x18, %edi
0000000100006173	callq	0x1000114c6                     ## symbol stub for: _malloc
0000000100006178	testq	%rax, %rax
000000010000617b	je	0x1000061e3
000000010000617d	movq	%rbx, (%rax)
0000000100006180	movq	$0xff, 0x8(%rax)
0000000100006188	movq	$0x0, 0x10(%rax)
0000000100006190	movq	%rax, (%r14)
0000000100006193	movb	$-0x1, (%rbx)
0000000100006196	leaq	0xf883(%rip), %rax
000000010000619d	movq	0xf87c(%rip), %rcx
00000001000061a4	jmp	0x1000061b9
00000001000061a6	testq	%rax, %rax
00000001000061a9	je	0x1000061c4
00000001000061ab	movq	0x8(%rax), %rcx
00000001000061af	cmpq	$-0x1, %rcx
00000001000061b3	je	0x10000622c
00000001000061b5	addq	$0x8, %rax
00000001000061b9	incq	%rcx
00000001000061bc	movq	%rcx, (%rax)
00000001000061bf	popq	%rbx
00000001000061c0	popq	%r14
00000001000061c2	popq	%rbp
00000001000061c3	retq
00000001000061c4	callq	_fwp_flush
00000001000061c9	movq	0xce68(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061d0	movq	(%rax), %rdi
00000001000061d3	leaq	0xba65(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000061da	leaq	0xba37(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000061e1	jmp	0x100006249
00000001000061e3	movq	0xce4e(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061ea	movq	(%rax), %rcx
00000001000061ed	leaq	0xbacb(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000061f4	movl	$0x13, %esi
00000001000061f9	movl	$0x1, %edx
00000001000061fe	callq	0x1000114a8                     ## symbol stub for: _fwrite
0000000100006203	movl	$0x66, %edi
0000000100006208	callq	0x100011478                     ## symbol stub for: _exit
000000010000620d	callq	_fwp_flush
0000000100006212	movq	0xce1f(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100006219	movq	(%rax), %rdi
000000010000621c	leaq	0xba1c(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006223	leaq	0xbb5f(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
000000010000622a	jmp	0x100006249
000000010000622c	callq	_fwp_flush
0000000100006231	movq	0xce00(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100006238	movq	(%rax), %rdi
000000010000623b	leaq	0xb9fd(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006242	leaq	0xbb65(%rip), %rdx              ## literal pool for: "reference count overflow"
0000000100006249	xorl	%eax, %eax
000000010000624b	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100006250	movl	$0x65, %edi
0000000100006255	callq	0x100011478                     ## symbol stub for: _exit
000000010000625a	nopw	(%rax,%rax)
_fwp_owner_release1:
0000000100006260	pushq	%rbp
0000000100006261	movq	%rsp, %rbp
0000000100006264	movq	(%rdi), %rdi
0000000100006267	popq	%rbp
0000000100006268	jmp	_fwp_drop0
000000010000626d	nopl	(%rax)
_fwp_owner_release2:
0000000100006270	pushq	%rbp
0000000100006271	movq	%rsp, %rbp
0000000100006274	movq	(%rdi), %rdi
0000000100006277	popq	%rbp
0000000100006278	jmp	_fwp_drop0
000000010000627d	nopl	(%rax)
_fwp_record:
0000000100006280	testl	%edi, %edi
0000000100006282	je	0x100006332
0000000100006288	pushq	%rbp
0000000100006289	movq	%rsp, %rbp
000000010000628c	pushq	%r15
000000010000628e	pushq	%r14
0000000100006290	pushq	%rbx
0000000100006291	pushq	%rax
0000000100006292	movq	%rsi, %rbx
0000000100006295	movl	%edi, %r14d
0000000100006298	leaq	0x8(,%r14,8), %rax
00000001000062a0	movl	%edi, %r15d
00000001000062a3	movq	%rax, %rdi
00000001000062a6	callq	_fwp_alloc_init
00000001000062ab	movl	$0x0, (%rax)
00000001000062b1	movl	%r15d, 0x4(%rax)
00000001000062b5	cmpl	$0x8, %r15d
00000001000062b9	jb	0x1000062cb
00000001000062bb	movq	%rax, %rcx
00000001000062be	subq	%rbx, %rcx
00000001000062c1	addq	$0x8, %rcx
00000001000062c5	cmpq	$0x20, %rcx
00000001000062c9	jae	0x100006335
00000001000062cb	xorl	%ecx, %ecx
00000001000062cd	movq	%r14, %rsi
00000001000062d0	movq	%rcx, %rdx
00000001000062d3	andq	$0x3, %rsi
00000001000062d7	je	0x1000062f1
00000001000062d9	movq	%rcx, %rdx
00000001000062dc	nopl	(%rax)
00000001000062e0	movq	(%rbx,%rdx,8), %rdi
00000001000062e4	movq	%rdi, 0x8(%rax,%rdx,8)
00000001000062e9	incq	%rdx
00000001000062ec	decq	%rsi
00000001000062ef	jne	0x1000062e0
00000001000062f1	subq	%r14, %rcx
00000001000062f4	cmpq	$-0x4, %rcx
00000001000062f8	ja	0x100006375
00000001000062fa	nopw	(%rax,%rax)
0000000100006300	movq	(%rbx,%rdx,8), %rcx
0000000100006304	movq	%rcx, 0x8(%rax,%rdx,8)
0000000100006309	movq	0x8(%rbx,%rdx,8), %rcx
000000010000630e	movq	%rcx, 0x10(%rax,%rdx,8)
0000000100006313	movq	0x10(%rbx,%rdx,8), %rcx
0000000100006318	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000631d	movq	0x18(%rbx,%rdx,8), %rcx
0000000100006322	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100006327	addq	$0x4, %rdx
000000010000632b	cmpq	%rdx, %r14
000000010000632e	jne	0x100006300
0000000100006330	jmp	0x100006375
0000000100006332	xorl	%eax, %eax
0000000100006334	retq
0000000100006335	movl	%r14d, %ecx
0000000100006338	andl	$-0x4, %ecx
000000010000633b	leaq	(,%r14,8), %rdx
0000000100006343	andq	$-0x20, %rdx
0000000100006347	xorl	%esi, %esi
0000000100006349	nopl	(%rax)
0000000100006350	movups	(%rbx,%rsi), %xmm0
0000000100006354	movups	0x10(%rbx,%rsi), %xmm1
0000000100006359	movups	%xmm0, 0x8(%rax,%rsi)
000000010000635e	movups	%xmm1, 0x18(%rax,%rsi)
0000000100006363	addq	$0x20, %rsi
0000000100006367	cmpq	%rsi, %rdx
000000010000636a	jne	0x100006350
000000010000636c	cmpl	%r14d, %ecx
000000010000636f	jne	0x1000062cd
0000000100006375	addq	$0x8, %rsp
0000000100006379	popq	%rbx
000000010000637a	popq	%r14
000000010000637c	popq	%r15
000000010000637e	popq	%rbp
000000010000637f	retq
_fwp_rc_free_obj:
0000000100006380	pushq	%rbp
0000000100006381	movq	%rsp, %rbp
0000000100006384	pushq	%r15
0000000100006386	pushq	%r14
0000000100006388	pushq	%rbx
0000000100006389	pushq	%rax
000000010000638a	movq	%rdi, %rax
000000010000638d	subq	0xeca4(%rip), %rax
0000000100006394	movq	0xecc5(%rip), %rcx
000000010000639b	shlq	$0x10, %rcx
000000010000639f	cmpq	%rcx, %rax
00000001000063a2	jae	0x1000064bf
00000001000063a8	movq	0xecd1(%rip), %rcx
00000001000063af	movq	%rax, %rdx
00000001000063b2	shrq	$0x10, %rdx
00000001000063b6	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000063bd	leaq	(%rcx,%rdx), %rbx
00000001000063c1	movzbl	(%rcx,%rdx), %r14d
00000001000063c6	cmpb	$0x2, %r14b
00000001000063ca	setne	%cl
00000001000063cd	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000063d3	setne	%dl
00000001000063d6	orb	%cl, %dl
00000001000063d8	jne	0x1000063eb
00000001000063da	leaq	0x228(%rbx), %rax
00000001000063e1	cmpb	$0x1, (%rax)
00000001000063e4	je	0x100006412
00000001000063e6	jmp	0x1000064bf
00000001000063eb	cmpb	$0x1, %r14b
00000001000063ef	jne	0x1000064bf
00000001000063f5	movl	0x20(%rbx), %ecx
00000001000063f8	imulq	%rcx, %rax
00000001000063fc	shrq	$0x20, %rax
0000000100006400	addq	%rbx, %rax
0000000100006403	addq	$0x228, %rax                    ## imm = 0x228
0000000100006409	cmpb	$0x1, (%rax)
000000010000640c	jne	0x1000064bf
0000000100006412	movl	_fwp_reuse_verify(%rip), %eax
0000000100006418	testl	%eax, %eax
000000010000641a	js	0x10000647b
000000010000641c	testl	%eax, %eax
000000010000641e	je	0x100006494
0000000100006420	cmpb	$0x1, 0x1(%rbx)
0000000100006424	jne	0x100006432
0000000100006426	cmpb	$0x2, %r14b
000000010000642a	jne	0x10000645e
000000010000642c	movq	0x18(%rbx), %rdx
0000000100006430	jmp	0x100006461
0000000100006432	movl	$0xdead, (%rdi)                 ## imm = 0xDEAD
0000000100006438	movl	0x4(%rdi), %edx
000000010000643b	testq	%rdx, %rdx
000000010000643e	je	0x1000064bf
0000000100006440	addq	$0x8, %rdi
0000000100006444	shlq	$0x3, %rdx
0000000100006448	leaq	0xb2a1(%rip), %rsi
000000010000644f	addq	$0x8, %rsp
0000000100006453	popq	%rbx
0000000100006454	popq	%r14
0000000100006456	popq	%r15
0000000100006458	popq	%rbp
0000000100006459	jmp	0x1000114e4                     ## symbol stub for: _memset_pattern16
000000010000645e	movl	0x8(%rbx), %edx
0000000100006461	movq	%rdi, %rbx
0000000100006464	movl	$0xdd, %esi
0000000100006469	callq	0x1000114de                     ## symbol stub for: _memset
000000010000646e	movq	$0x0, (%rbx)
0000000100006475	movb	$0x0, 0x8(%rbx)
0000000100006479	jmp	0x1000064bf
000000010000647b	leaq	-0x1c(%rbp), %rax
000000010000647f	movq	%rdi, %r15
0000000100006482	movq	%rax, %rdi
0000000100006485	callq	_fwp_rc_free_obj.cold.1
000000010000648a	movq	%r15, %rdi
000000010000648d	movl	-0x1c(%rbp), %eax
0000000100006490	testl	%eax, %eax
0000000100006492	jne	0x100006420
0000000100006494	movq	_fwp_gc(%rip), %rbx
000000010000649b	callq	_fwp_mem_free
00000001000064a0	movq	_fwp_gc(%rip), %rax
00000001000064a7	subq	%rbx, %rax
00000001000064aa	cvtsi2sd	%rax, %xmm0
00000001000064af	addsd	0xed59(%rip), %xmm0
00000001000064b7	movsd	%xmm0, 0xed51(%rip)
00000001000064bf	addq	$0x8, %rsp
00000001000064c3	popq	%rbx
00000001000064c4	popq	%r14
00000001000064c6	popq	%r15
00000001000064c8	popq	%rbp
00000001000064c9	retq
00000001000064ca	nopw	(%rax,%rax)
_fwp_owner_release5:
00000001000064d0	pushq	%rbp
00000001000064d1	movq	%rsp, %rbp
00000001000064d4	movq	(%rdi), %rdi
00000001000064d7	popq	%rbp
00000001000064d8	jmp	_fwp_drop1
00000001000064dd	nopl	(%rax)
_fwp_owned_entry29:
00000001000064e0	pushq	%rbp
00000001000064e1	movq	%rsp, %rbp
00000001000064e4	movq	(%rdi), %rdi
00000001000064e7	popq	%rbp
00000001000064e8	jmp	_f29
00000001000064ed	nopl	(%rax)
_fwp_caps29:
00000001000064f0	movl	0x4(%rdi), %eax
00000001000064f3	testl	%esi, %esi
00000001000064f5	je	0x100006559
00000001000064f7	testl	%eax, %eax
00000001000064f9	je	0x1000065b1
00000001000064ff	movq	0x8(%rdi), %rax
0000000100006503	subq	0xeb2e(%rip), %rax
000000010000650a	movq	0xeb4f(%rip), %rcx
0000000100006511	shlq	$0x10, %rcx
0000000100006515	cmpq	%rcx, %rax
0000000100006518	jae	0x1000065b1
000000010000651e	movq	0xeb5b(%rip), %rcx
0000000100006525	movq	%rax, %rdx
0000000100006528	shrq	$0x10, %rdx
000000010000652c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006533	leaq	(%rcx,%rdx), %rdi
0000000100006537	movzbl	(%rcx,%rdx), %ecx
000000010000653b	cmpb	$0x2, %cl
000000010000653e	setne	%dl
0000000100006541	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006547	setne	%sil
000000010000654b	orb	%dl, %sil
000000010000654e	jne	0x100006584
0000000100006550	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006557	jmp	0x10000659e
0000000100006559	testl	%eax, %eax
000000010000655b	je	_fwp_rc_free_obj
0000000100006561	pushq	%rbp
0000000100006562	movq	%rsp, %rbp
0000000100006565	pushq	%rbx
0000000100006566	pushq	%rax
0000000100006567	movq	0x8(%rdi), %rax
000000010000656b	movq	%rdi, %rbx
000000010000656e	movq	%rax, %rdi
0000000100006571	callq	_fwp_drop1
0000000100006576	movq	%rbx, %rdi
0000000100006579	addq	$0x8, %rsp
000000010000657d	popq	%rbx
000000010000657e	popq	%rbp
000000010000657f	jmp	_fwp_rc_free_obj
0000000100006584	cmpb	$0x1, %cl
0000000100006587	jne	0x1000065b1
0000000100006589	movl	0x20(%rdi), %ecx
000000010000658c	imulq	%rcx, %rax
0000000100006590	shrq	$0x20, %rax
0000000100006594	addq	%rax, %rdi
0000000100006597	addq	$0x228, %rdi                    ## imm = 0x228
000000010000659e	movzbl	(%rdi), %eax
00000001000065a1	testb	%al, %al
00000001000065a3	je	0x1000065b1
00000001000065a5	cmpb	$-0x2, %al
00000001000065a7	jae	_fwp_rc_wide_dup
00000001000065ad	incb	%al
00000001000065af	movb	%al, (%rdi)
00000001000065b1	retq
00000001000065b2	nopw	%cs:(%rax,%rax)
_fwp_args29:
00000001000065c0	pushq	%rbp
00000001000065c1	movq	%rsp, %rbp
00000001000065c4	testl	%esi, %esi
00000001000065c6	setne	%al
00000001000065c9	testl	%edx, %edx
00000001000065cb	sete	%cl
00000001000065ce	orb	%al, %cl
00000001000065d0	jne	0x100006650
00000001000065d2	movq	(%rdi), %rax
00000001000065d5	subq	0xea5c(%rip), %rax
00000001000065dc	movq	0xea7d(%rip), %rcx
00000001000065e3	shlq	$0x10, %rcx
00000001000065e7	cmpq	%rcx, %rax
00000001000065ea	jae	0x100006650
00000001000065ec	movq	0xea8d(%rip), %rcx
00000001000065f3	movq	%rax, %rdx
00000001000065f6	shrq	$0x10, %rdx
00000001000065fa	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006601	leaq	(%rcx,%rdx), %rdi
0000000100006605	movzbl	(%rcx,%rdx), %ecx
0000000100006609	cmpb	$0x2, %cl
000000010000660c	setne	%dl
000000010000660f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006615	setne	%sil
0000000100006619	orb	%dl, %sil
000000010000661c	jne	0x100006627
000000010000661e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006625	jmp	0x100006641
0000000100006627	cmpb	$0x1, %cl
000000010000662a	jne	0x100006650
000000010000662c	movl	0x20(%rdi), %ecx
000000010000662f	imulq	%rcx, %rax
0000000100006633	shrq	$0x20, %rax
0000000100006637	addq	%rax, %rdi
000000010000663a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006641	movzbl	(%rdi), %eax
0000000100006644	testb	%al, %al
0000000100006646	je	0x100006650
0000000100006648	cmpb	$-0x2, %al
000000010000664a	jae	0x100006652
000000010000664c	incb	%al
000000010000664e	movb	%al, (%rdi)
0000000100006650	popq	%rbp
0000000100006651	retq
0000000100006652	popq	%rbp
0000000100006653	jmp	_fwp_rc_wide_dup
0000000100006658	nopl	(%rax,%rax)
_fwp_arg_drop29:
0000000100006660	pushq	%rbp
0000000100006661	movq	%rsp, %rbp
0000000100006664	testl	%esi, %esi
0000000100006666	setne	%al
0000000100006669	testl	%edx, %edx
000000010000666b	sete	%cl
000000010000666e	orb	%al, %cl
0000000100006670	je	0x100006674
0000000100006672	popq	%rbp
0000000100006673	retq
0000000100006674	movq	(%rdi), %rdi
0000000100006677	popq	%rbp
0000000100006678	jmp	_fwp_drop1
000000010000667d	nopl	(%rax)
_fwp_p_loop_own:
0000000100006680	pushq	%rbp
0000000100006681	movq	%rsp, %rbp
0000000100006684	pushq	%r15
0000000100006686	pushq	%r14
0000000100006688	pushq	%r13
000000010000668a	pushq	%r12
000000010000668c	pushq	%rbx
000000010000668d	subq	$0xf8, %rsp
0000000100006694	movq	%rdx, -0x48(%rbp)
0000000100006698	movq	%rsi, %r12
000000010000669b	movq	%rdi, %rbx
000000010000669e	movq	%rsi, -0x40(%rbp)
00000001000066a2	movq	%rsi, -0x68(%rbp)
00000001000066a6	movq	%rcx, -0x60(%rbp)
00000001000066aa	testq	%rcx, %rcx
00000001000066ad	je	0x1000066e4
00000001000066af	movq	_fwp_cleanups(%rip), %rax
00000001000066b6	movq	%rax, -0x100(%rbp)
00000001000066bd	leaq	_fwp_value_release(%rip), %rax
00000001000066c4	movq	%rax, -0xf8(%rbp)
00000001000066cb	leaq	-0x68(%rbp), %rax
00000001000066cf	movq	%rax, -0xf0(%rbp)
00000001000066d6	leaq	-0x100(%rbp), %rax
00000001000066dd	movq	%rax, _fwp_cleanups(%rip)
00000001000066e4	leaq	-0xe0(%rbp), %r15
00000001000066eb	movq	%rbx, -0x98(%rbp)
00000001000066f2	nopw	%cs:(%rax,%rax)
0000000100006700	movl	_fwp_budget(%rip), %eax
0000000100006706	leal	-0x1(%rax), %ecx
0000000100006709	movl	%ecx, _fwp_budget(%rip)
000000010000670f	cmpl	$0x1, %eax
0000000100006712	jle	0x100006d2c
0000000100006718	movq	%r12, -0x40(%rbp)
000000010000671c	movq	$0x0, -0x68(%rbp)
0000000100006724	movq	_fwp_fns(%rip), %rcx
000000010000672b	movl	(%rbx), %edx
000000010000672d	shlq	$0x5, %rdx
0000000100006731	movq	0x18(%rcx,%rdx), %rax
0000000100006736	testq	%rax, %rax
0000000100006739	je	0x100006b60
000000010000673f	movq	%rbx, %r10
0000000100006742	leaq	(%rcx,%rdx), %r11
0000000100006746	leaq	(%rcx,%rdx), %r13
000000010000674a	addq	$0x18, %r13
000000010000674e	movl	$0x1, %r9d
0000000100006754	xorl	%ecx, %ecx
0000000100006756	leaq	-0x40(%rbp), %r14
000000010000675a	movl	$0x1, %ebx
000000010000675f	nop
0000000100006760	testb	$0x1, %cl
0000000100006763	movl	$0x0, %edx
0000000100006768	cmovneq	%r10, %rdx
000000010000676c	movq	%rdx, -0x90(%rbp)
0000000100006773	movq	%r14, -0x88(%rbp)
000000010000677a	movq	%rax, -0x80(%rbp)
000000010000677e	movl	$0x0, -0x78(%rbp)
0000000100006785	movl	0x4(%r10), %edx
0000000100006789	movl	%edx, -0x74(%rbp)
000000010000678c	movq	%r10, %rdx
000000010000678f	subq	0xe8a2(%rip), %rdx
0000000100006796	movl	%ebx, -0x70(%rbp)
0000000100006799	movq	0xe8c0(%rip), %rsi
00000001000067a0	shlq	$0x10, %rsi
00000001000067a4	cmpq	%rsi, %rdx
00000001000067a7	movl	%ebx, -0x2c(%rbp)
00000001000067aa	jae	0x100006860
00000001000067b0	movl	%r9d, %r12d
00000001000067b3	movq	%r11, -0x38(%rbp)
00000001000067b7	movq	%r15, %rbx
00000001000067ba	movq	%r14, %r15
00000001000067bd	movq	%r10, %r14
00000001000067c0	movq	0xe8b9(%rip), %r8
00000001000067c7	movq	%rdx, %rdi
00000001000067ca	shrq	$0x10, %rdi
00000001000067ce	imulq	$0x1228, %rdi, %r9              ## imm = 0x1228
00000001000067d5	leaq	(%r8,%r9), %rdi
00000001000067d9	movzbl	(%r8,%r9), %r9d
00000001000067de	cmpb	$0x2, %r9b
00000001000067e2	setne	%r10b
00000001000067e6	movq	%rdx, %r8
00000001000067e9	andq	$0xffff, %r8                    ## imm = 0xFFFF
00000001000067f0	setne	%r11b
00000001000067f4	orb	%r10b, %r11b
00000001000067f7	jne	0x100006820
00000001000067f9	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006800	movq	%r14, %r10
0000000100006803	movq	%r15, %r14
0000000100006806	movq	%rbx, %r15
0000000100006809	movl	-0x2c(%rbp), %ebx
000000010000680c	movq	-0x38(%rbp), %r11
0000000100006810	jmp	0x10000684f
0000000100006812	nopw	%cs:(%rax,%rax)
0000000100006820	cmpb	$0x1, %r9b
0000000100006824	movq	%r14, %r10
0000000100006827	movq	%r15, %r14
000000010000682a	movq	%rbx, %r15
000000010000682d	movl	-0x2c(%rbp), %ebx
0000000100006830	movq	-0x38(%rbp), %r11
0000000100006834	movl	%r12d, %r9d
0000000100006837	jne	0x100006860
0000000100006839	movl	0x20(%rdi), %r9d
000000010000683d	imulq	%r9, %r8
0000000100006841	shrq	$0x20, %r8
0000000100006845	addq	%r8, %rdi
0000000100006848	addq	$0x228, %rdi                    ## imm = 0x228
000000010000684f	cmpb	$0x0, (%rdi)
0000000100006852	movl	%r12d, %r9d
0000000100006855	jne	0x10000686b
0000000100006857	nopw	(%rax,%rax)
0000000100006860	testl	%ebx, %ebx
0000000100006862	je	0x1000068b0
0000000100006864	cmpq	$0x0, 0x18(%rax)
0000000100006869	je	0x1000068b0
000000010000686b	movq	_fwp_cleanups(%rip), %rdi
0000000100006872	movq	%rdi, -0xe0(%rbp)
0000000100006879	leaq	_fwp_apply_release(%rip), %rdi
0000000100006880	movq	%rdi, -0xd8(%rbp)
0000000100006887	leaq	-0x90(%rbp), %rdi
000000010000688e	movq	%rdi, -0xd0(%rbp)
0000000100006895	movq	%r15, _fwp_cleanups(%rip)
000000010000689c	movb	$0x1, %dil
000000010000689f	movl	%edi, -0x30(%rbp)
00000001000068a2	testb	$0x1, %cl
00000001000068a5	je	0x1000068bc
00000001000068a7	jmp	0x100006933
00000001000068ac	nopl	(%rax)
00000001000068b0	movl	$0x0, -0x30(%rbp)
00000001000068b7	testb	$0x1, %cl
00000001000068ba	jne	0x100006933
00000001000068bc	cmpq	%rsi, %rdx
00000001000068bf	jae	0x100006928
00000001000068c1	movq	0xe7b8(%rip), %rax
00000001000068c8	movq	%rdx, %rcx
00000001000068cb	shrq	$0x10, %rcx
00000001000068cf	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
00000001000068d6	leaq	(%rax,%rcx), %rdi
00000001000068da	movzbl	(%rax,%rcx), %eax
00000001000068de	cmpb	$0x2, %al
00000001000068e0	setne	%cl
00000001000068e3	andq	$0xffff, %rdx                   ## imm = 0xFFFF
00000001000068ea	setne	%sil
00000001000068ee	orb	%cl, %sil
00000001000068f1	jne	0x1000068fc
00000001000068f3	addq	$0x228, %rdi                    ## imm = 0x228
00000001000068fa	jmp	0x100006915
00000001000068fc	cmpb	$0x1, %al
00000001000068fe	jne	0x100006928
0000000100006900	movl	0x20(%rdi), %eax
0000000100006903	imulq	%rax, %rdx
0000000100006907	shrq	$0x20, %rdx
000000010000690b	addq	%rdx, %rdi
000000010000690e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006915	movzbl	(%rdi), %eax
0000000100006918	testb	%al, %al
000000010000691a	je	0x100006928
000000010000691c	cmpb	$-0x2, %al
000000010000691e	jae	0x100006b28
0000000100006924	incb	%al
0000000100006926	movb	%al, (%rdi)
0000000100006928	movq	%r10, -0x90(%rbp)
000000010000692f	movq	(%r13), %rax
0000000100006933	movq	%r15, %r12
0000000100006936	movl	(%r11), %esi
0000000100006939	subl	0x4(%r10), %esi
000000010000693d	cmpl	%esi, %r9d
0000000100006940	movl	%esi, -0x54(%rbp)
0000000100006943	cmovbl	%r9d, %esi
0000000100006947	cmpl	%esi, %ebx
0000000100006949	movl	%esi, %edx
000000010000694b	cmovbl	%ebx, %edx
000000010000694e	movq	$0x0, -0xc8(%rbp)
0000000100006959	movq	%r14, -0xe8(%rbp)
0000000100006960	leaq	(%r14,%rdx,8), %r14
0000000100006964	movq	%r14, -0xc0(%rbp)
000000010000696b	movq	%rax, -0xb8(%rbp)
0000000100006972	movl	$0x0, -0xb0(%rbp)
000000010000697c	movl	0x4(%r10), %ecx
0000000100006980	addl	%edx, %ecx
0000000100006982	movl	%ecx, -0xac(%rbp)
0000000100006988	movl	$0x0, -0xa8(%rbp)
0000000100006992	xorl	%r15d, %r15d
0000000100006995	movl	$0x0, %ecx
000000010000699a	cmpl	%ebx, %esi
000000010000699c	movl	%esi, -0x38(%rbp)
000000010000699f	movq	%rdx, -0xa0(%rbp)
00000001000069a6	jbe	0x100006a63
00000001000069ac	movl	%r9d, -0x50(%rbp)
00000001000069b0	cmpq	$0x0, 0x18(%rax)
00000001000069b5	setne	%al
00000001000069b8	movl	%eax, -0x4c(%rbp)
00000001000069bb	je	0x1000069f5
00000001000069bd	movq	_fwp_cleanups(%rip), %rax
00000001000069c4	movq	%rax, -0x118(%rbp)
00000001000069cb	leaq	_fwp_apply_release(%rip), %rax
00000001000069d2	movq	%rax, -0x110(%rbp)
00000001000069d9	leaq	-0xc8(%rbp), %rax
00000001000069e0	movq	%rax, -0x108(%rbp)
00000001000069e7	leaq	-0x118(%rbp), %rax
00000001000069ee	movq	%rax, _fwp_cleanups(%rip)
00000001000069f5	movl	%esi, %r15d
00000001000069f8	subl	%edx, %r15d
00000001000069fb	cmpl	$0x1, %r15d
00000001000069ff	adcl	$0x0, %r15d
0000000100006a03	shlq	$0x3, %r15
0000000100006a07	movl	%edx, %r12d
0000000100006a0a	nopw	(%rax,%rax)
0000000100006a10	movq	(%r13), %rax
0000000100006a14	movl	0x4(%r10), %esi
0000000100006a18	addl	%r12d, %esi
0000000100006a1b	movq	%r14, %rdi
0000000100006a1e	movl	$0x1, %edx
0000000100006a23	movq	%r10, %rbx
0000000100006a26	callq	*0x10(%rax)
0000000100006a29	movq	%rbx, %r10
0000000100006a2c	movl	-0xa8(%rbp), %ecx
0000000100006a32	incl	%ecx
0000000100006a34	movl	%ecx, -0xa8(%rbp)
0000000100006a3a	incl	%r12d
0000000100006a3d	addq	$0x8, %r14
0000000100006a41	addq	$-0x8, %r15
0000000100006a45	jne	0x100006a10
0000000100006a47	leaq	-0xe0(%rbp), %r12
0000000100006a4e	movl	-0x50(%rbp), %r9d
0000000100006a52	movl	-0x2c(%rbp), %ebx
0000000100006a55	movl	-0x38(%rbp), %esi
0000000100006a58	movq	-0xa0(%rbp), %rdx
0000000100006a5f	movl	-0x4c(%rbp), %r15d
0000000100006a63	movl	%r9d, %r13d
0000000100006a66	movl	%ecx, -0xb0(%rbp)
0000000100006a6c	movq	$0x0, -0x90(%rbp)
0000000100006a77	movl	%edx, -0x78(%rbp)
0000000100006a7a	movq	%r10, %rdi
0000000100006a7d	movq	-0xe8(%rbp), %r14
0000000100006a84	movq	%r14, %rdx
0000000100006a87	callq	_fwp_apply_owned
0000000100006a8c	movq	%rax, %r10
0000000100006a8f	testb	%r15b, %r15b
0000000100006a92	movq	%r12, %r15
0000000100006a95	je	0x100006ab9
0000000100006a97	leaq	-0x118(%rbp), %rax
0000000100006a9e	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006aa5	jne	0x100006d93
0000000100006aab	movq	-0x118(%rbp), %rax
0000000100006ab2	movq	%rax, _fwp_cleanups(%rip)
0000000100006ab9	cmpb	$0x0, -0x30(%rbp)
0000000100006abd	movl	-0x38(%rbp), %ecx
0000000100006ac0	movq	-0xa0(%rbp), %rdx
0000000100006ac7	movl	%r13d, %r9d
0000000100006aca	je	0x100006ae7
0000000100006acc	cmpq	%r15, _fwp_cleanups(%rip)
0000000100006ad3	jne	0x100006d93
0000000100006ad9	movq	-0xe0(%rbp), %rax
0000000100006ae0	movq	%rax, _fwp_cleanups(%rip)
0000000100006ae7	cmpl	-0x54(%rbp), %r9d
0000000100006aeb	jbe	0x100006bdc
0000000100006af1	movl	%ecx, %eax
0000000100006af3	leaq	(%r14,%rax,8), %r14
0000000100006af7	subl	%ecx, %r9d
0000000100006afa	subl	%edx, %ebx
0000000100006afc	movq	_fwp_fns(%rip), %rax
0000000100006b03	movl	(%r10), %ecx
0000000100006b06	shlq	$0x5, %rcx
0000000100006b0a	leaq	(%rax,%rcx), %r11
0000000100006b0e	leaq	(%rax,%rcx), %r13
0000000100006b12	addq	$0x18, %r13
0000000100006b16	movq	0x18(%rax,%rcx), %rax
0000000100006b1b	movb	$0x1, %cl
0000000100006b1d	testq	%rax, %rax
0000000100006b20	jne	0x100006760
0000000100006b26	jmp	0x100006b80
0000000100006b28	movq	%r14, %r15
0000000100006b2b	movq	%r10, %r14
0000000100006b2e	movq	%r11, %rbx
0000000100006b31	movl	%r9d, %r12d
0000000100006b34	callq	_fwp_rc_wide_dup
0000000100006b39	movl	%r12d, %r9d
0000000100006b3c	movq	%rbx, %r11
0000000100006b3f	movq	%r14, %r10
0000000100006b42	movq	%r15, %r14
0000000100006b45	leaq	-0xe0(%rbp), %r15
0000000100006b4c	movl	-0x2c(%rbp), %ebx
0000000100006b4f	jmp	0x100006928
0000000100006b54	nopw	%cs:(%rax,%rax)
0000000100006b60	movq	%rbx, %rdi
0000000100006b63	callq	_fwp_rc_share
0000000100006b68	movl	$0x1, %ecx
0000000100006b6d	movq	%rbx, %r12
0000000100006b70	leaq	-0x40(%rbp), %r15
0000000100006b74	jmp	0x100006b9b
0000000100006b76	nopw	%cs:(%rax,%rax)
0000000100006b80	movl	%r9d, %ebx
0000000100006b83	movq	%r10, %r12
0000000100006b86	movq	%r10, %rdi
0000000100006b89	callq	_fwp_rc_share
0000000100006b8e	testl	%ebx, %ebx
0000000100006b90	je	0x100006c9c
0000000100006b96	movl	%ebx, %ecx
0000000100006b98	movq	%r14, %r15
0000000100006b9b	movl	%ecx, %r13d
0000000100006b9e	movl	%ecx, %ebx
0000000100006ba0	xorl	%r14d, %r14d
0000000100006ba3	nopw	%cs:(%rax,%rax)
0000000100006bb0	movq	(%r15,%r14,8), %rdi
0000000100006bb4	callq	_fwp_rc_share
0000000100006bb9	incq	%r14
0000000100006bbc	cmpq	%r14, %rbx
0000000100006bbf	jne	0x100006bb0
0000000100006bc1	movq	%r12, %rdi
0000000100006bc4	movq	%r15, %r14
0000000100006bc7	leaq	-0xe0(%rbp), %r15
0000000100006bce	movl	%r13d, %esi
0000000100006bd1	movq	%r14, %rdx
0000000100006bd4	callq	_fwp_apply
0000000100006bd9	movq	%rax, %r10
0000000100006bdc	cmpq	$0xfff, %r10                    ## imm = 0xFFF
0000000100006be3	movq	-0x48(%rbp), %rax
0000000100006be7	ja	0x100006bf0
0000000100006be9	movl	%r10d, %ebx
0000000100006bec	jmp	0x100006bf3
0000000100006bee	nop
0000000100006bf0	movl	(%r10), %ebx
0000000100006bf3	movq	%r10, -0xc8(%rbp)
0000000100006bfa	movq	%rax, -0xc0(%rbp)
0000000100006c01	testq	%rax, %rax
0000000100006c04	je	0x100006c3b
0000000100006c06	movq	_fwp_cleanups(%rip), %rax
0000000100006c0d	movq	%rax, -0x90(%rbp)
0000000100006c14	leaq	_fwp_value_release(%rip), %rax
0000000100006c1b	movq	%rax, -0x88(%rbp)
0000000100006c22	leaq	-0xc8(%rbp), %rax
0000000100006c29	movq	%rax, -0x80(%rbp)
0000000100006c2d	leaq	-0x90(%rbp), %rax
0000000100006c34	movq	%rax, _fwp_cleanups(%rip)
0000000100006c3b	movq	0x8(%r10), %r12
0000000100006c3f	testl	%ebx, %ebx
0000000100006c41	jne	0x100006cd0
0000000100006c47	movq	%r12, %rax
0000000100006c4a	subq	0xe3e7(%rip), %rax
0000000100006c51	movq	0xe408(%rip), %rcx
0000000100006c58	shlq	$0x10, %rcx
0000000100006c5c	cmpq	%rcx, %rax
0000000100006c5f	jae	0x100006cd0
0000000100006c61	movq	0xe418(%rip), %rcx
0000000100006c68	movq	%rax, %rdx
0000000100006c6b	shrq	$0x10, %rdx
0000000100006c6f	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006c76	leaq	(%rcx,%rdx), %rdi
0000000100006c7a	movzbl	(%rcx,%rdx), %ecx
0000000100006c7e	cmpb	$0x2, %cl
0000000100006c81	setne	%dl
0000000100006c84	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006c8a	setne	%sil
0000000100006c8e	orb	%dl, %sil
0000000100006c91	jne	0x100006ca7
0000000100006c93	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006c9a	jmp	0x100006cc1
0000000100006c9c	xorl	%r13d, %r13d
0000000100006c9f	movq	%r12, %rdi
0000000100006ca2	jmp	0x100006bce
0000000100006ca7	cmpb	$0x1, %cl
0000000100006caa	jne	0x100006cd0
0000000100006cac	movl	0x20(%rdi), %ecx
0000000100006caf	imulq	%rcx, %rax
0000000100006cb3	shrq	$0x20, %rax
0000000100006cb7	addq	%rax, %rdi
0000000100006cba	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006cc1	movzbl	(%rdi), %eax
0000000100006cc4	testb	%al, %al
0000000100006cc6	je	0x100006cd0
0000000100006cc8	cmpb	$-0x2, %al
0000000100006cca	jae	0x100006d3a
0000000100006ccc	incb	%al
0000000100006cce	movb	%al, (%rdi)
0000000100006cd0	cmpq	$0x0, -0xc0(%rbp)
0000000100006cd8	je	0x100006cfc
0000000100006cda	leaq	-0x90(%rbp), %rax
0000000100006ce1	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006ce8	jne	0x100006d93
0000000100006cee	movq	-0x90(%rbp), %rax
0000000100006cf5	movq	%rax, _fwp_cleanups(%rip)
0000000100006cfc	movq	$0x0, -0xc8(%rbp)
0000000100006d07	cmpq	$0x0, -0x48(%rbp)
0000000100006d0c	je	0x100006d14
0000000100006d0e	movq	%r10, %rdi
0000000100006d11	callq	*-0x48(%rbp)
0000000100006d14	movq	%r12, -0x40(%rbp)
0000000100006d18	testl	%ebx, %ebx
0000000100006d1a	jne	0x100006d51
0000000100006d1c	movq	%r12, -0x68(%rbp)
0000000100006d20	movq	-0x98(%rbp), %rbx
0000000100006d27	jmp	0x100006700
0000000100006d2c	callq	_fwp_preempt
0000000100006d31	movq	-0x68(%rbp), %r12
0000000100006d35	jmp	0x100006718
0000000100006d3a	movq	%r10, %r14
0000000100006d3d	callq	_fwp_rc_wide_dup
0000000100006d42	movq	%r14, %r10
0000000100006d45	cmpq	$0x0, -0xc0(%rbp)
0000000100006d4d	jne	0x100006cda
0000000100006d4f	jmp	0x100006cfc
0000000100006d51	movq	-0x98(%rbp), %rax
0000000100006d58	cmpq	$0x0, -0x60(%rbp)
0000000100006d5d	je	0x100006d7d
0000000100006d5f	leaq	-0x100(%rbp), %rax
0000000100006d66	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006d6d	jne	0x100006d93
0000000100006d6f	movq	-0x100(%rbp), %rax
0000000100006d76	movq	%rax, _fwp_cleanups(%rip)
0000000100006d7d	movq	-0x40(%rbp), %rax
0000000100006d81	addq	$0xf8, %rsp
0000000100006d88	popq	%rbx
0000000100006d89	popq	%r12
0000000100006d8b	popq	%r13
0000000100006d8d	popq	%r14
0000000100006d8f	popq	%r15
0000000100006d91	popq	%rbp
0000000100006d92	retq
0000000100006d93	callq	0x10001145a                     ## symbol stub for: _abort
0000000100006d98	nopl	(%rax,%rax)
_fwp_drop2:
0000000100006da0	movq	%rdi, %rcx
0000000100006da3	subq	0xe28e(%rip), %rcx
0000000100006daa	movq	0xe2af(%rip), %rax
0000000100006db1	shlq	$0x10, %rax
0000000100006db5	cmpq	%rax, %rcx
0000000100006db8	jae	0x100006e5d
0000000100006dbe	movq	0xe2bb(%rip), %rdx
0000000100006dc5	movq	%rcx, %rax
0000000100006dc8	shrq	$0x10, %rax
0000000100006dcc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100006dd3	leaq	(%rdx,%rsi), %rax
0000000100006dd7	movzbl	(%rdx,%rsi), %edx
0000000100006ddb	cmpb	$0x2, %dl
0000000100006dde	setne	%sil
0000000100006de2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100006de9	setne	%r8b
0000000100006ded	orb	%sil, %r8b
0000000100006df0	jne	0x100006dfa
0000000100006df2	addq	$0x228, %rax                    ## imm = 0x228
0000000100006df8	jmp	0x100006e13
0000000100006dfa	cmpb	$0x1, %dl
0000000100006dfd	jne	0x100006e5d
0000000100006dff	movl	0x20(%rax), %edx
0000000100006e02	imulq	%rdx, %rcx
0000000100006e06	shrq	$0x20, %rcx
0000000100006e0a	addq	%rcx, %rax
0000000100006e0d	addq	$0x228, %rax                    ## imm = 0x228
0000000100006e13	movzbl	(%rax), %ecx
0000000100006e16	testl	%ecx, %ecx
0000000100006e18	je	0x100006e5d
0000000100006e1a	cmpl	$0x1, %ecx
0000000100006e1d	jne	0x100006e51
0000000100006e1f	movl	(%rdi), %eax
0000000100006e21	cmpl	$0x1, %eax
0000000100006e24	je	_fwp_rc_free_obj
0000000100006e2a	testl	%eax, %eax
0000000100006e2c	jne	0x100006e5d
0000000100006e2e	pushq	%rbp
0000000100006e2f	movq	%rsp, %rbp
0000000100006e32	pushq	%rbx
0000000100006e33	pushq	%rax
0000000100006e34	movq	0x8(%rdi), %rax
0000000100006e38	movq	%rdi, %rbx
0000000100006e3b	movq	%rax, %rdi
0000000100006e3e	callq	_fwp_drop1
0000000100006e43	movq	%rbx, %rdi
0000000100006e46	addq	$0x8, %rsp
0000000100006e4a	popq	%rbx
0000000100006e4b	popq	%rbp
0000000100006e4c	jmp	_fwp_rc_free_obj
0000000100006e51	cmpl	$0xff, %ecx
0000000100006e57	je	0x100006e5e
0000000100006e59	decb	%cl
0000000100006e5b	movb	%cl, (%rax)
0000000100006e5d	retq
0000000100006e5e	movq	%rax, %rdi
0000000100006e61	jmp	_fwp_rc_wide_drop
0000000100006e66	nopw	%cs:(%rax,%rax)
_fwp_preempt:
0000000100006e70	movl	_fwp_slice(%rip), %ecx
0000000100006e76	testl	%ecx, %ecx
0000000100006e78	je	0x100006e81
0000000100006e7a	movl	%ecx, _fwp_budget(%rip)
0000000100006e80	retq
0000000100006e81	pushq	%rbp
0000000100006e82	movq	%rsp, %rbp
0000000100006e85	leaq	0xaf3b(%rip), %rdi              ## literal pool for: "FWP_PREEMPT"
0000000100006e8c	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100006e91	movq	%rax, %rdi
0000000100006e94	movl	$0x2710, %eax                   ## imm = 0x2710
0000000100006e99	testq	%rdi, %rdi
0000000100006e9c	je	0x100006eaf
0000000100006e9e	cmpb	$0x0, (%rdi)
0000000100006ea1	je	0x100006eaf
0000000100006ea3	xorl	%esi, %esi
0000000100006ea5	movl	$0xa, %edx
0000000100006eaa	callq	0x100011574                     ## symbol stub for: _strtoll
0000000100006eaf	leaq	-0x80000000(%rax), %rcx
0000000100006eb6	cmpq	$-0x7fffffff, %rcx              ## imm = 0x80000001
0000000100006ebd	movl	$0x7fffffff, %ecx               ## imm = 0x7FFFFFFF
0000000100006ec2	cmovael	%eax, %ecx
0000000100006ec5	movl	%ecx, _fwp_slice(%rip)
0000000100006ecb	popq	%rbp
0000000100006ecc	movl	%ecx, _fwp_budget(%rip)
0000000100006ed2	retq
0000000100006ed3	nopw	%cs:(%rax,%rax)
_fwp_value_release:
0000000100006ee0	pushq	%rbp
0000000100006ee1	movq	%rsp, %rbp
0000000100006ee4	movq	%rdi, %rax
0000000100006ee7	movq	(%rdi), %rdi
0000000100006eea	movq	0x8(%rax), %rcx
0000000100006eee	movq	$0x0, (%rax)
0000000100006ef5	testq	%rcx, %rcx
0000000100006ef8	setne	%al
0000000100006efb	testq	%rdi, %rdi
0000000100006efe	setne	%dl
0000000100006f01	andb	%al, %dl
0000000100006f03	cmpb	$0x1, %dl
0000000100006f06	jne	0x100006f0b
0000000100006f08	popq	%rbp
0000000100006f09	jmpq	*%rcx
0000000100006f0b	popq	%rbp
0000000100006f0c	retq
0000000100006f0d	nopl	(%rax)
_fwp_apply:
0000000100006f10	pushq	%rbp
0000000100006f11	movq	%rsp, %rbp
0000000100006f14	pushq	%r15
0000000100006f16	pushq	%r14
0000000100006f18	pushq	%r13
0000000100006f1a	pushq	%r12
0000000100006f1c	pushq	%rbx
0000000100006f1d	subq	$0x38, %rsp
0000000100006f21	movq	%rdx, %rbx
0000000100006f24	movl	%esi, %r8d
0000000100006f27	movq	%rdi, %r15
0000000100006f2a	movq	0xc0ff(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006f31	movq	(%rax), %rax
0000000100006f34	movq	%rax, -0x30(%rbp)
0000000100006f38	jmp	0x100006f5d
0000000100006f3a	nopw	(%rax,%rax)
0000000100006f40	leaq	(%rbx,%r14,8), %rbx
0000000100006f44	xorl	%ecx, %ecx
0000000100006f46	movq	%rax, %r15
0000000100006f49	movq	-0x48(%rbp), %r14
0000000100006f4d	movq	-0x50(%rbp), %rsp
0000000100006f51	movl	%edx, %r8d
0000000100006f54	cmpl	$0x1, %ecx
0000000100006f57	je	0x100007406
0000000100006f5d	movq	_fwp_fns(%rip), %rax
0000000100006f64	movl	(%r15), %ecx
0000000100006f67	movl	0x4(%r15), %r13d
0000000100006f6b	shlq	$0x5, %rcx
0000000100006f6f	leaq	(%rax,%rcx), %rdx
0000000100006f73	movl	(%rax,%rcx), %r12d
0000000100006f77	testq	%r13, %r13
0000000100006f7a	jne	0x100006fc0
0000000100006f7c	leal	-0x1(%r12), %eax
0000000100006f81	cmpl	%r8d, %eax
0000000100006f84	jae	0x100006fc0
0000000100006f86	movq	%rbx, %rdi
0000000100006f89	movq	%r8, %r15
0000000100006f8c	callq	*0x8(%rdx)
0000000100006f8f	movq	%r15, %r8
0000000100006f92	movq	%rax, %r15
0000000100006f95	cmpl	%r12d, %r8d
0000000100006f98	je	0x10000725b
0000000100006f9e	leaq	(%rbx,%r12,8), %rbx
0000000100006fa2	subl	%r12d, %r8d
0000000100006fa5	movl	$0x3, %ecx
0000000100006faa	cmpl	$0x1, %ecx
0000000100006fad	jne	0x100006f5d
0000000100006faf	jmp	0x100007406
0000000100006fb4	nopw	%cs:(%rax,%rax)
0000000100006fc0	movq	%r14, -0x48(%rbp)
0000000100006fc4	leal	(%r8,%r13), %r14d
0000000100006fc8	cmpl	%r12d, %r14d
0000000100006fcb	movq	%r8, -0x40(%rbp)
0000000100006fcf	jb	0x1000071fd
0000000100006fd5	movq	%rdx, -0x58(%rbp)
0000000100006fd9	movq	%rsp, -0x50(%rbp)
0000000100006fdd	movl	%r12d, %r14d
0000000100006fe0	cmpl	$0x2, %r12d
0000000100006fe4	movl	$0x1, %eax
0000000100006fe9	cmovael	%r12d, %eax
0000000100006fed	shlq	$0x3, %rax
0000000100006ff1	callq	0x100011418                     ## symbol stub for: ____chkstk_darwin
0000000100006ff6	addq	$0xf, %rax
0000000100006ffa	andq	$-0x10, %rax
0000000100006ffe	subq	%rax, %rsp
0000000100007001	movq	%rsp, %rdi
0000000100007004	testq	%r13, %r13
0000000100007007	je	0x1000070e0
000000010000700d	cmpl	$0x3, %r13d
0000000100007011	jbe	0x100007023
0000000100007013	movq	%rdi, %rax
0000000100007016	subq	%r15, %rax
0000000100007019	addq	$-0x8, %rax
000000010000701d	cmpq	$0x20, %rax
0000000100007021	jae	0x100007092
0000000100007023	xorl	%eax, %eax
0000000100007025	movq	%r13, %rdx
0000000100007028	movq	%rax, %rcx
000000010000702b	andq	$0x3, %rdx
000000010000702f	je	0x100007051
0000000100007031	movq	%rax, %rcx
0000000100007034	nopw	%cs:(%rax,%rax)
0000000100007040	movq	0x8(%r15,%rcx,8), %rsi
0000000100007045	movq	%rsi, (%rdi,%rcx,8)
0000000100007049	incq	%rcx
000000010000704c	decq	%rdx
000000010000704f	jne	0x100007040
0000000100007051	subq	%r13, %rax
0000000100007054	cmpq	$-0x4, %rax
0000000100007058	ja	0x1000070e0
000000010000705e	nop
0000000100007060	movq	0x8(%r15,%rcx,8), %rax
0000000100007065	movq	%rax, (%rdi,%rcx,8)
0000000100007069	movq	0x10(%r15,%rcx,8), %rax
000000010000706e	movq	%rax, 0x8(%rdi,%rcx,8)
0000000100007073	movq	0x18(%r15,%rcx,8), %rax
0000000100007078	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000707d	movq	0x20(%r15,%rcx,8), %rax
0000000100007082	movq	%rax, 0x18(%rdi,%rcx,8)
0000000100007087	addq	$0x4, %rcx
000000010000708b	cmpq	%rcx, %r13
000000010000708e	jne	0x100007060
0000000100007090	jmp	0x1000070e0
0000000100007092	movl	%r13d, %eax
0000000100007095	andl	$-0x4, %eax
0000000100007098	leaq	(,%r13,8), %rcx
00000001000070a0	andq	$-0x20, %rcx
00000001000070a4	xorl	%edx, %edx
00000001000070a6	nopw	%cs:(%rax,%rax)
00000001000070b0	movups	0x8(%r15,%rdx), %xmm0
00000001000070b6	movups	0x18(%r15,%rdx), %xmm1
00000001000070bc	movaps	%xmm0, (%rdi,%rdx)
00000001000070c0	movaps	%xmm1, 0x10(%rdi,%rdx)
00000001000070c5	addq	$0x20, %rdx
00000001000070c9	cmpq	%rdx, %rcx
00000001000070cc	jne	0x1000070b0
00000001000070ce	cmpl	%r13d, %eax
00000001000070d1	jne	0x100007025
00000001000070d7	nopw	(%rax,%rax)
00000001000070e0	subl	%r13d, %r14d
00000001000070e3	movl	%r14d, -0x34(%rbp)
00000001000070e7	movl	%r14d, %r14d
00000001000070ea	cmpl	%r13d, %r12d
00000001000070ed	je	0x100007172
00000001000070f3	cmpl	$0xd, -0x34(%rbp)
00000001000070f7	ja	0x100007197
00000001000070fd	xorl	%eax, %eax
00000001000070ff	movq	%r14, %rdx
0000000100007102	movq	%rax, %rcx
0000000100007105	andq	$0x3, %rdx
0000000100007109	je	0x100007124
000000010000710b	movq	%rax, %rcx
000000010000710e	nop
0000000100007110	movq	(%rbx,%rcx,8), %rsi
0000000100007114	leal	(%rcx,%r13), %r8d
0000000100007118	movq	%rsi, (%rdi,%r8,8)
000000010000711c	incq	%rcx
000000010000711f	decq	%rdx
0000000100007122	jne	0x100007110
0000000100007124	subq	%r14, %rax
0000000100007127	cmpq	$-0x4, %rax
000000010000712b	ja	0x100007172
000000010000712d	nopl	(%rax)
0000000100007130	movq	(%rbx,%rcx,8), %rax
0000000100007134	leal	(%rcx,%r13), %edx
0000000100007138	movq	%rax, (%rdi,%rdx,8)
000000010000713c	movq	0x8(%rbx,%rcx,8), %rax
0000000100007141	leal	(%rcx,%r13), %edx
0000000100007145	incl	%edx
0000000100007147	movq	%rax, (%rdi,%rdx,8)
000000010000714b	movq	0x10(%rbx,%rcx,8), %rax
0000000100007150	leal	0x2(%r13,%rcx), %edx
0000000100007155	movq	%rax, (%rdi,%rdx,8)
0000000100007159	movq	0x18(%rbx,%rcx,8), %rax
000000010000715e	leal	(%rcx,%r13), %edx
0000000100007162	addl	$0x3, %edx
0000000100007165	movq	%rax, (%rdi,%rdx,8)
0000000100007169	addq	$0x4, %rcx
000000010000716d	cmpq	%rcx, %r14
0000000100007170	jne	0x100007130
0000000100007172	movq	-0x58(%rbp), %rax
0000000100007176	callq	*0x8(%rax)
0000000100007179	movl	$0x1, %ecx
000000010000717e	movq	-0x40(%rbp), %rsi
0000000100007182	movl	%esi, %edx
0000000100007184	subl	-0x34(%rbp), %edx
0000000100007187	jne	0x100006f40
000000010000718d	movl	%esi, %edx
000000010000718f	movq	%rax, %r14
0000000100007192	jmp	0x100006f4d
0000000100007197	leaq	-0x1(%r14), %rax
000000010000719b	movl	%eax, %ecx
000000010000719d	addl	%r13d, %ecx
00000001000071a0	jb	0x1000070fd
00000001000071a6	shrq	$0x20, %rax
00000001000071aa	movl	$0x0, %eax
00000001000071af	jne	0x1000070ff
00000001000071b5	leaq	(%rdi,%r13,8), %rax
00000001000071b9	subq	%rbx, %rax
00000001000071bc	cmpq	$0x20, %rax
00000001000071c0	jb	0x1000070fd
00000001000071c6	movl	%r14d, %eax
00000001000071c9	andl	$-0x4, %eax
00000001000071cc	xorl	%ecx, %ecx
00000001000071ce	nop
00000001000071d0	movups	(%rbx,%rcx,8), %xmm0
00000001000071d4	movups	0x10(%rbx,%rcx,8), %xmm1
00000001000071d9	leal	(%rcx,%r13), %edx
00000001000071dd	movups	%xmm0, (%rdi,%rdx,8)
00000001000071e1	movups	%xmm1, 0x10(%rdi,%rdx,8)
00000001000071e6	addq	$0x4, %rcx
00000001000071ea	cmpq	%rcx, %rax
00000001000071ed	jne	0x1000071d0
00000001000071ef	cmpl	%r14d, %eax
00000001000071f2	jne	0x1000070ff
00000001000071f8	jmp	0x100007172
00000001000071fd	movl	%r14d, %eax
0000000100007200	cmpl	$0x7ff, %r14d                   ## imm = 0x7FF
0000000100007207	ja	0x100007273
0000000100007209	leaq	(,%rax,8), %rdx
0000000100007211	addq	$0x17, %rdx
0000000100007215	shrq	$0x4, %rdx
0000000100007219	leaq	_fwp_gc(%rip), %rcx
0000000100007220	movzbl	0xbe8(%rdx,%rcx), %edx
0000000100007228	movl	0xb48(%rcx,%rdx,4), %esi
000000010000722f	subq	%rsi, _fwp_gc(%rip)
0000000100007236	js	0x100007273
0000000100007238	leaq	(%rdx,%rdx,2), %rdx
000000010000723c	leaq	(%rcx,%rdx,8), %rcx
0000000100007240	addq	$0x788, %rcx                    ## imm = 0x788
0000000100007247	movq	(%rcx), %r12
000000010000724a	testq	%r12, %r12
000000010000724d	je	0x100007263
000000010000724f	movq	(%r12), %rax
0000000100007253	notq	%rax
0000000100007256	movq	%rax, (%rcx)
0000000100007259	jmp	0x100007292
000000010000725b	movq	%r15, %r14
000000010000725e	jmp	0x100007406
0000000100007263	movq	0x8(%rcx), %r12
0000000100007267	movq	0x10(%rcx), %rdx
000000010000726b	subq	%r12, %rdx
000000010000726e	cmpq	%rsi, %rdx
0000000100007271	jae	0x10000728a
0000000100007273	leaq	0x8(,%rax,8), %rdi
000000010000727b	movl	$0x2, %esi
0000000100007280	callq	_fwp_gc_alloc_slow
0000000100007285	movq	%rax, %r12
0000000100007288	jmp	0x10000729a
000000010000728a	leaq	(%r12,%rsi), %rax
000000010000728e	movq	%rax, 0x8(%rcx)
0000000100007292	movq	%r12, %rdi
0000000100007295	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000729a	movl	(%r15), %eax
000000010000729d	movl	%eax, (%r12)
00000001000072a1	movl	%r14d, 0x4(%r12)
00000001000072a6	testq	%r13, %r13
00000001000072a9	movq	%r12, %r14
00000001000072ac	movq	-0x40(%rbp), %rdi
00000001000072b0	je	0x100007371
00000001000072b6	xorl	%eax, %eax
00000001000072b8	cmpl	$0x6, %r13d
00000001000072bc	jb	0x100007306
00000001000072be	movq	%r14, %rcx
00000001000072c1	subq	%r15, %rcx
00000001000072c4	cmpq	$0x1f, %rcx
00000001000072c8	jbe	0x100007306
00000001000072ca	movl	%r13d, %eax
00000001000072cd	andl	$-0x4, %eax
00000001000072d0	leaq	(,%r13,8), %rcx
00000001000072d8	andq	$-0x20, %rcx
00000001000072dc	xorl	%edx, %edx
00000001000072de	nop
00000001000072e0	movups	0x8(%r15,%rdx), %xmm0
00000001000072e6	movups	0x18(%r15,%rdx), %xmm1
00000001000072ec	movups	%xmm0, 0x8(%r14,%rdx)
00000001000072f2	movups	%xmm1, 0x18(%r14,%rdx)
00000001000072f8	addq	$0x20, %rdx
00000001000072fc	cmpq	%rdx, %rcx
00000001000072ff	jne	0x1000072e0
0000000100007301	cmpl	%r13d, %eax
0000000100007304	je	0x100007371
0000000100007306	movq	%r13, %rdx
0000000100007309	movq	%rax, %rcx
000000010000730c	andq	$0x3, %rdx
0000000100007310	je	0x100007332
0000000100007312	movq	%rax, %rcx
0000000100007315	nopw	%cs:(%rax,%rax)
0000000100007320	movq	0x8(%r15,%rcx,8), %rsi
0000000100007325	movq	%rsi, 0x8(%r14,%rcx,8)
000000010000732a	incq	%rcx
000000010000732d	decq	%rdx
0000000100007330	jne	0x100007320
0000000100007332	subq	%r13, %rax
0000000100007335	cmpq	$-0x4, %rax
0000000100007339	ja	0x100007371
000000010000733b	nopl	(%rax,%rax)
0000000100007340	movq	0x8(%r15,%rcx,8), %rax
0000000100007345	movq	%rax, 0x8(%r14,%rcx,8)
000000010000734a	movq	0x10(%r15,%rcx,8), %rax
000000010000734f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100007354	movq	0x18(%r15,%rcx,8), %rax
0000000100007359	movq	%rax, 0x18(%r14,%rcx,8)
000000010000735e	movq	0x20(%r15,%rcx,8), %rax
0000000100007363	movq	%rax, 0x20(%r14,%rcx,8)
0000000100007368	addq	$0x4, %rcx
000000010000736c	cmpq	%rcx, %r13
000000010000736f	jne	0x100007340
0000000100007371	testl	%edi, %edi
0000000100007373	je	0x100007406
0000000100007379	movl	%edi, %eax
000000010000737b	cmpl	$0x13, %edi
000000010000737e	ja	0x100007428
0000000100007384	xorl	%ecx, %ecx
0000000100007386	movq	%rax, %rsi
0000000100007389	movq	%rcx, %rdx
000000010000738c	andq	$0x3, %rsi
0000000100007390	je	0x1000073b5
0000000100007392	movq	%rcx, %rdx
0000000100007395	nopw	%cs:(%rax,%rax)
00000001000073a0	movq	(%rbx,%rdx,8), %rdi
00000001000073a4	leal	(%rdx,%r13), %r8d
00000001000073a8	movq	%rdi, 0x8(%r14,%r8,8)
00000001000073ad	incq	%rdx
00000001000073b0	decq	%rsi
00000001000073b3	jne	0x1000073a0
00000001000073b5	subq	%rax, %rcx
00000001000073b8	cmpq	$-0x4, %rcx
00000001000073bc	ja	0x100007406
00000001000073be	nop
00000001000073c0	movq	(%rbx,%rdx,8), %rcx
00000001000073c4	leal	(%rdx,%r13), %esi
00000001000073c8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000073cd	movq	0x8(%rbx,%rdx,8), %rcx
00000001000073d2	leal	(%rdx,%r13), %esi
00000001000073d6	incl	%esi
00000001000073d8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000073dd	movq	0x10(%rbx,%rdx,8), %rcx
00000001000073e2	leal	0x2(%r13,%rdx), %esi
00000001000073e7	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000073ec	movq	0x18(%rbx,%rdx,8), %rcx
00000001000073f1	leal	(%rdx,%r13), %esi
00000001000073f5	addl	$0x3, %esi
00000001000073f8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000073fd	addq	$0x4, %rdx
0000000100007401	cmpq	%rdx, %rax
0000000100007404	jne	0x1000073c0
0000000100007406	movq	0xbc23(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000740d	movq	(%rax), %rax
0000000100007410	cmpq	-0x30(%rbp), %rax
0000000100007414	jne	0x10000748f
0000000100007416	movq	%r14, %rax
0000000100007419	leaq	-0x28(%rbp), %rsp
000000010000741d	popq	%rbx
000000010000741e	popq	%r12
0000000100007420	popq	%r13
0000000100007422	popq	%r14
0000000100007424	popq	%r15
0000000100007426	popq	%rbp
0000000100007427	retq
0000000100007428	leaq	-0x1(%rax), %rdx
000000010000742c	xorl	%ecx, %ecx
000000010000742e	movl	%edx, %esi
0000000100007430	addl	%r13d, %esi
0000000100007433	jb	0x100007386
0000000100007439	shrq	$0x20, %rdx
000000010000743d	jne	0x100007386
0000000100007443	leaq	(%r14,%r13,8), %rcx
0000000100007447	subq	%rbx, %rcx
000000010000744a	addq	$0x8, %rcx
000000010000744e	cmpq	$0x20, %rcx
0000000100007452	jb	0x100007384
0000000100007458	movl	%eax, %ecx
000000010000745a	andl	$-0x4, %ecx
000000010000745d	xorl	%edx, %edx
000000010000745f	nop
0000000100007460	movups	(%rbx,%rdx,8), %xmm0
0000000100007464	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100007469	leal	(%rdx,%r13), %esi
000000010000746d	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100007473	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100007479	addq	$0x4, %rdx
000000010000747d	cmpq	%rdx, %rcx
0000000100007480	jne	0x100007460
0000000100007482	cmpl	%eax, %ecx
0000000100007484	jne	0x100007386
000000010000748a	jmp	0x100007406
000000010000748f	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100007494	nopw	%cs:(%rax,%rax)
_fwp_apply_release:
00000001000074a0	pushq	%rbp
00000001000074a1	movq	%rsp, %rbp
00000001000074a4	pushq	%r14
00000001000074a6	pushq	%rbx
00000001000074a7	movq	(%rdi), %rbx
00000001000074aa	movq	$0x0, (%rdi)
00000001000074b1	movl	0x20(%rdi), %eax
00000001000074b4	movl	0x18(%rdi), %ecx
00000001000074b7	movl	%eax, %edx
00000001000074b9	subl	%ecx, %edx
00000001000074bb	je	0x1000074ea
00000001000074bd	movq	0x10(%rdi), %rsi
00000001000074c1	movq	0x18(%rsi), %r8
00000001000074c5	testq	%r8, %r8
00000001000074c8	je	0x1000074ea
00000001000074ca	movq	%rcx, %rax
00000001000074cd	shlq	$0x3, %rax
00000001000074d1	addq	0x8(%rdi), %rax
00000001000074d5	movl	0x1c(%rdi), %esi
00000001000074d8	addl	%ecx, %esi
00000001000074da	movq	%rdi, %r14
00000001000074dd	movq	%rax, %rdi
00000001000074e0	callq	*%r8
00000001000074e3	movq	%r14, %rdi
00000001000074e6	movl	0x20(%r14), %eax
00000001000074ea	movl	%eax, 0x18(%rdi)
00000001000074ed	testq	%rbx, %rbx
00000001000074f0	je	0x1000074fe
00000001000074f2	movq	%rbx, %rdi
00000001000074f5	popq	%rbx
00000001000074f6	popq	%r14
00000001000074f8	popq	%rbp
00000001000074f9	jmp	_fwp_closure_drop
00000001000074fe	popq	%rbx
00000001000074ff	popq	%r14
0000000100007501	popq	%rbp
0000000100007502	retq
0000000100007503	nopw	%cs:(%rax,%rax)
_fwp_apply_owned:
0000000100007510	pushq	%rbp
0000000100007511	movq	%rsp, %rbp
0000000100007514	pushq	%r15
0000000100007516	pushq	%r14
0000000100007518	pushq	%r13
000000010000751a	pushq	%r12
000000010000751c	pushq	%rbx
000000010000751d	subq	$0xa8, %rsp
0000000100007524	movq	%rdx, %rbx
0000000100007527	movl	%esi, %r13d
000000010000752a	movq	0xbaff(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007531	movq	(%rax), %rax
0000000100007534	movq	%rax, -0x30(%rbp)
0000000100007538	movq	_fwp_fns(%rip), %rdx
000000010000753f	movl	(%rdi), %esi
0000000100007541	shlq	$0x5, %rsi
0000000100007545	movq	0x18(%rdx,%rsi), %rax
000000010000754a	testq	%rax, %rax
000000010000754d	je	0x100007966
0000000100007553	leaq	(%rdx,%rsi), %rcx
0000000100007557	addq	%rdx, %rsi
000000010000755a	addq	$0x18, %rsi
000000010000755e	movq	%rdi, %r12
0000000100007561	nopw	%cs:(%rax,%rax)
0000000100007570	movq	%rsi, -0x58(%rbp)
0000000100007574	movl	(%rcx), %r14d
0000000100007577	movl	0x4(%r12), %r15d
000000010000757c	movq	%rdi, -0xb0(%rbp)
0000000100007583	movq	%rbx, -0xa8(%rbp)
000000010000758a	movq	%rax, -0xa0(%rbp)
0000000100007591	movl	$0x0, -0x98(%rbp)
000000010000759b	movl	%r15d, -0x94(%rbp)
00000001000075a2	movq	%rdi, %rcx
00000001000075a5	subq	0xda8c(%rip), %rcx
00000001000075ac	movl	%r13d, -0x90(%rbp)
00000001000075b3	movq	0xdaa6(%rip), %rdx
00000001000075ba	shlq	$0x10, %rdx
00000001000075be	cmpq	%rdx, %rcx
00000001000075c1	jae	0x100007630
00000001000075c3	movq	0xdab6(%rip), %rsi
00000001000075ca	movq	%rcx, %rdx
00000001000075cd	shrq	$0x10, %rdx
00000001000075d1	imulq	$0x1228, %rdx, %r8              ## imm = 0x1228
00000001000075d8	leaq	(%rsi,%r8), %rdx
00000001000075dc	movzbl	(%rsi,%r8), %esi
00000001000075e1	cmpb	$0x2, %sil
00000001000075e5	setne	%r9b
00000001000075e9	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000075f0	setne	%r8b
00000001000075f4	orb	%r9b, %r8b
00000001000075f7	jne	0x100007610
00000001000075f9	addq	$0x228, %rdx                    ## imm = 0x228
0000000100007600	cmpb	$0x0, (%rdx)
0000000100007603	jne	0x100007650
0000000100007605	jmp	0x100007630
0000000100007607	nopw	(%rax,%rax)
0000000100007610	cmpb	$0x1, %sil
0000000100007614	jne	0x100007630
0000000100007616	movl	0x20(%rdx), %esi
0000000100007619	imulq	%rsi, %rcx
000000010000761d	shrq	$0x20, %rcx
0000000100007621	addq	%rcx, %rdx
0000000100007624	addq	$0x228, %rdx                    ## imm = 0x228
000000010000762b	cmpb	$0x0, (%rdx)
000000010000762e	jne	0x100007650
0000000100007630	cmpq	$0x0, 0x18(%rax)
0000000100007635	je	0x100007641
0000000100007637	testq	%r15, %r15
000000010000763a	jne	0x100007650
000000010000763c	cmpl	%r14d, %r13d
000000010000763f	jne	0x100007650
0000000100007641	xorl	%ecx, %ecx
0000000100007643	jmp	0x10000767e
0000000100007645	nopw	%cs:(%rax,%rax)
0000000100007650	movq	_fwp_cleanups(%rip), %rcx
0000000100007657	movq	%rcx, -0x80(%rbp)
000000010000765b	leaq	_fwp_apply_release(%rip), %rcx
0000000100007662	movq	%rcx, -0x78(%rbp)
0000000100007666	leaq	-0xb0(%rbp), %rcx
000000010000766d	movq	%rcx, -0x70(%rbp)
0000000100007671	leaq	-0x80(%rbp), %rcx
0000000100007675	movq	%rcx, _fwp_cleanups(%rip)
000000010000767c	movb	$0x1, %cl
000000010000767e	movq	%r13, -0x50(%rbp)
0000000100007682	addl	%r15d, %r13d
0000000100007685	cmpl	%r14d, %r13d
0000000100007688	movq	%rdi, -0x40(%rbp)
000000010000768c	movl	%ecx, -0x44(%rbp)
000000010000768f	jb	0x1000079a7
0000000100007695	movl	%r14d, %ecx
0000000100007698	subl	%r15d, %ecx
000000010000769b	movl	%ecx, -0x34(%rbp)
000000010000769e	movl	%ecx, %ecx
00000001000076a0	movq	%rcx, -0x60(%rbp)
00000001000076a4	testq	%r15, %r15
00000001000076a7	jne	0x1000076d0
00000001000076a9	testl	%r14d, %r14d
00000001000076ac	je	0x1000076d0
00000001000076ae	movl	-0x34(%rbp), %r15d
00000001000076b2	movl	%r15d, -0x98(%rbp)
00000001000076b9	movq	%rbx, %rdi
00000001000076bc	callq	*(%rax)
00000001000076be	movq	%rax, %r12
00000001000076c1	jmp	0x1000078f8
00000001000076c6	nopw	%cs:(%rax,%rax)
00000001000076d0	movq	%rsp, -0x88(%rbp)
00000001000076d7	testl	%r14d, %r14d
00000001000076da	movl	$0x1, %eax
00000001000076df	cmovnel	%r14d, %eax
00000001000076e3	shlq	$0x3, %rax
00000001000076e7	callq	0x100011418                     ## symbol stub for: ____chkstk_darwin
00000001000076ec	addq	$0xf, %rax
00000001000076f0	andq	$-0x10, %rax
00000001000076f4	subq	%rax, %rsp
00000001000076f7	movq	%rsp, %r13
00000001000076fa	testq	%r15, %r15
00000001000076fd	movq	-0x40(%rbp), %rdi
0000000100007701	je	0x1000077d0
0000000100007707	cmpl	$0x3, %r15d
000000010000770b	jbe	0x10000771d
000000010000770d	movq	%r13, %rax
0000000100007710	subq	%r12, %rax
0000000100007713	addq	$-0x8, %rax
0000000100007717	cmpq	$0x20, %rax
000000010000771b	jae	0x100007783
000000010000771d	xorl	%eax, %eax
000000010000771f	movq	%r15, %rdx
0000000100007722	movq	%rax, %rcx
0000000100007725	andq	$0x3, %rdx
0000000100007729	je	0x100007742
000000010000772b	movq	%rax, %rcx
000000010000772e	nop
0000000100007730	movq	0x8(%r12,%rcx,8), %rsi
0000000100007735	movq	%rsi, (%r13,%rcx,8)
000000010000773a	incq	%rcx
000000010000773d	decq	%rdx
0000000100007740	jne	0x100007730
0000000100007742	subq	%r15, %rax
0000000100007745	cmpq	$-0x4, %rax
0000000100007749	ja	0x1000077d0
000000010000774f	nop
0000000100007750	movq	0x8(%r12,%rcx,8), %rax
0000000100007755	movq	%rax, (%r13,%rcx,8)
000000010000775a	movq	0x10(%r12,%rcx,8), %rax
000000010000775f	movq	%rax, 0x8(%r13,%rcx,8)
0000000100007764	movq	0x18(%r12,%rcx,8), %rax
0000000100007769	movq	%rax, 0x10(%r13,%rcx,8)
000000010000776e	movq	0x20(%r12,%rcx,8), %rax
0000000100007773	movq	%rax, 0x18(%r13,%rcx,8)
0000000100007778	addq	$0x4, %rcx
000000010000777c	cmpq	%rcx, %r15
000000010000777f	jne	0x100007750
0000000100007781	jmp	0x1000077d0
0000000100007783	movl	%r15d, %eax
0000000100007786	andl	$-0x4, %eax
0000000100007789	leaq	(,%r15,8), %rcx
0000000100007791	andq	$-0x20, %rcx
0000000100007795	xorl	%edx, %edx
0000000100007797	nopw	(%rax,%rax)
00000001000077a0	movups	0x8(%r12,%rdx), %xmm0
00000001000077a6	movups	0x18(%r12,%rdx), %xmm1
00000001000077ac	movaps	%xmm0, (%r13,%rdx)
00000001000077b2	movaps	%xmm1, 0x10(%r13,%rdx)
00000001000077b8	addq	$0x20, %rdx
00000001000077bc	cmpq	%rdx, %rcx
00000001000077bf	jne	0x1000077a0
00000001000077c1	cmpl	%r15d, %eax
00000001000077c4	jne	0x10000771f
00000001000077ca	nopw	(%rax,%rax)
00000001000077d0	cmpl	%r15d, %r14d
00000001000077d3	movq	-0x58(%rbp), %r14
00000001000077d7	movq	-0x60(%rbp), %r9
00000001000077db	je	0x1000078d0
00000001000077e1	cmpl	$0x9, -0x34(%rbp)
00000001000077e5	ja	0x100007878
00000001000077eb	xorl	%eax, %eax
00000001000077ed	movq	%r9, %rdx
00000001000077f0	movq	%rax, %rcx
00000001000077f3	andq	$0x3, %rdx
00000001000077f7	je	0x100007815
00000001000077f9	movq	%rax, %rcx
00000001000077fc	nopl	(%rax)
0000000100007800	movq	(%rbx,%rcx,8), %rsi
0000000100007804	leal	(%r15,%rcx), %r8d
0000000100007808	movq	%rsi, (%r13,%r8,8)
000000010000780d	incq	%rcx
0000000100007810	decq	%rdx
0000000100007813	jne	0x100007800
0000000100007815	subq	%r9, %rax
0000000100007818	cmpq	$-0x4, %rax
000000010000781c	ja	0x1000078d0
0000000100007822	nopw	%cs:(%rax,%rax)
0000000100007830	movq	(%rbx,%rcx,8), %rax
0000000100007834	leal	(%r15,%rcx), %edx
0000000100007838	movq	%rax, (%r13,%rdx,8)
000000010000783d	movq	0x8(%rbx,%rcx,8), %rax
0000000100007842	leal	(%r15,%rcx), %edx
0000000100007846	incl	%edx
0000000100007848	movq	%rax, (%r13,%rdx,8)
000000010000784d	movq	0x10(%rbx,%rcx,8), %rax
0000000100007852	leal	0x2(%r15,%rcx), %edx
0000000100007857	movq	%rax, (%r13,%rdx,8)
000000010000785c	movq	0x18(%rbx,%rcx,8), %rax
0000000100007861	leal	(%r15,%rcx), %edx
0000000100007865	addl	$0x3, %edx
0000000100007868	movq	%rax, (%r13,%rdx,8)
000000010000786d	addq	$0x4, %rcx
0000000100007871	cmpq	%rcx, %r9
0000000100007874	jne	0x100007830
0000000100007876	jmp	0x1000078d0
0000000100007878	leaq	-0x1(%r9), %rax
000000010000787c	movl	%eax, %ecx
000000010000787e	addl	%r15d, %ecx
0000000100007881	jb	0x1000077eb
0000000100007887	shrq	$0x20, %rax
000000010000788b	movl	$0x0, %eax
0000000100007890	jne	0x1000077ed
0000000100007896	movl	%r9d, %eax
0000000100007899	andl	$-0x4, %eax
000000010000789c	xorl	%ecx, %ecx
000000010000789e	nop
00000001000078a0	movups	(%rbx,%rcx,8), %xmm0
00000001000078a4	movups	0x10(%rbx,%rcx,8), %xmm1
00000001000078a9	leal	(%r15,%rcx), %edx
00000001000078ad	movups	%xmm0, (%r13,%rdx,8)
00000001000078b3	movups	%xmm1, 0x10(%r13,%rdx,8)
00000001000078b9	addq	$0x4, %rcx
00000001000078bd	cmpq	%rcx, %rax
00000001000078c0	jne	0x1000078a0
00000001000078c2	cmpl	%r9d, %eax
00000001000078c5	jne	0x1000077ed
00000001000078cb	nopl	(%rax,%rax)
00000001000078d0	movq	(%r14), %rax
00000001000078d3	movl	$0x1, %esi
00000001000078d8	callq	*0x8(%rax)
00000001000078db	movl	-0x34(%rbp), %r15d
00000001000078df	movl	%r15d, -0x98(%rbp)
00000001000078e6	movq	(%r14), %rax
00000001000078e9	movq	%r13, %rdi
00000001000078ec	callq	*(%rax)
00000001000078ee	movq	%rax, %r12
00000001000078f1	movq	-0x88(%rbp), %rsp
00000001000078f8	cmpb	$0x0, -0x44(%rbp)
00000001000078fc	movq	-0x50(%rbp), %r13
0000000100007900	movq	-0x40(%rbp), %rdi
0000000100007904	je	0x100007922
0000000100007906	leaq	-0x80(%rbp), %rax
000000010000790a	cmpq	%rax, _fwp_cleanups(%rip)
0000000100007911	jne	0x100007d84
0000000100007917	movq	-0x80(%rbp), %rax
000000010000791b	movq	%rax, _fwp_cleanups(%rip)
0000000100007922	callq	_fwp_closure_drop
0000000100007927	subl	%r15d, %r13d
000000010000792a	je	0x100007d62
0000000100007930	movq	-0x60(%rbp), %rax
0000000100007934	leaq	(%rbx,%rax,8), %rbx
0000000100007938	movq	_fwp_fns(%rip), %rax
000000010000793f	movl	(%r12), %edx
0000000100007943	shlq	$0x5, %rdx
0000000100007947	leaq	(%rax,%rdx), %rcx
000000010000794b	leaq	(%rax,%rdx), %rsi
000000010000794f	addq	$0x18, %rsi
0000000100007953	movq	0x18(%rax,%rdx), %rax
0000000100007958	movq	%r12, %rdi
000000010000795b	testq	%rax, %rax
000000010000795e	jne	0x100007570
0000000100007964	jmp	0x100007969
0000000100007966	movq	%rdi, %r12
0000000100007969	movq	%r12, %rdi
000000010000796c	callq	_fwp_rc_share
0000000100007971	testl	%r13d, %r13d
0000000100007974	je	0x100007991
0000000100007976	movl	%r13d, %r14d
0000000100007979	xorl	%r15d, %r15d
000000010000797c	nopl	(%rax)
0000000100007980	movq	(%rbx,%r15,8), %rdi
0000000100007984	callq	_fwp_rc_share
0000000100007989	incq	%r15
000000010000798c	cmpq	%r15, %r14
000000010000798f	jne	0x100007980
0000000100007991	movq	%r12, %rdi
0000000100007994	movl	%r13d, %esi
0000000100007997	movq	%rbx, %rdx
000000010000799a	callq	_fwp_apply
000000010000799f	movq	%rax, %r12
00000001000079a2	jmp	0x100007d62
00000001000079a7	movl	%r13d, %eax
00000001000079aa	leaq	0x8(,%rax,8), %rdi
00000001000079b2	callq	_fwp_alloc_init
00000001000079b7	movq	-0x40(%rbp), %rdi
00000001000079bb	movq	%rax, %r14
00000001000079be	movl	(%r12), %eax
00000001000079c2	movl	%eax, (%r14)
00000001000079c5	movl	%r13d, 0x4(%r14)
00000001000079c9	movq	%r14, %rax
00000001000079cc	subq	0xd665(%rip), %rax
00000001000079d3	movq	0xd686(%rip), %rcx
00000001000079da	shlq	$0x10, %rcx
00000001000079de	cmpq	%rcx, %rax
00000001000079e1	jae	0x100007a5a
00000001000079e3	movq	0xd696(%rip), %rcx
00000001000079ea	movq	%rax, %rdx
00000001000079ed	shrq	$0x10, %rdx
00000001000079f1	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000079f8	leaq	(%rcx,%rdx), %r13
00000001000079fc	movzbl	(%rcx,%rdx), %ecx
0000000100007a00	cmpb	$0x2, %cl
0000000100007a03	setne	%dl
0000000100007a06	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007a0c	setne	%sil
0000000100007a10	orb	%dl, %sil
0000000100007a13	jne	0x100007a2a
0000000100007a15	addq	$0x228, %r13                    ## imm = 0x228
0000000100007a1c	cmpb	$-0x1, (%r13)
0000000100007a21	je	0x100007a4c
0000000100007a23	movb	$0x1, (%r13)
0000000100007a28	jmp	0x100007a5a
0000000100007a2a	cmpb	$0x1, %cl
0000000100007a2d	jne	0x100007a5a
0000000100007a2f	movl	0x20(%r13), %ecx
0000000100007a33	imulq	%rcx, %rax
0000000100007a37	shrq	$0x20, %rax
0000000100007a3b	addq	%rax, %r13
0000000100007a3e	addq	$0x228, %r13                    ## imm = 0x228
0000000100007a45	cmpb	$-0x1, (%r13)
0000000100007a4a	jne	0x100007a23
0000000100007a4c	movq	%r13, %rdi
0000000100007a4f	callq	_fwp_rc_forget_slot
0000000100007a54	movq	-0x40(%rbp), %rdi
0000000100007a58	jmp	0x100007a23
0000000100007a5a	movq	%r14, -0x68(%rbp)
0000000100007a5e	movq	_fwp_cleanups(%rip), %rax
0000000100007a65	movq	%rax, -0xc8(%rbp)
0000000100007a6c	leaq	_fwp_rc_cleanup_cell(%rip), %rax
0000000100007a73	movq	%rax, -0xc0(%rbp)
0000000100007a7a	leaq	-0x68(%rbp), %rax
0000000100007a7e	movq	%rax, -0xb8(%rbp)
0000000100007a85	leaq	-0xc8(%rbp), %r13
0000000100007a8c	movq	%r13, _fwp_cleanups(%rip)
0000000100007a93	testq	%r15, %r15
0000000100007a96	je	0x100007b61
0000000100007a9c	xorl	%eax, %eax
0000000100007a9e	cmpl	$0x6, %r15d
0000000100007aa2	jb	0x100007af6
0000000100007aa4	movq	%r14, %rcx
0000000100007aa7	subq	%r12, %rcx
0000000100007aaa	cmpq	$0x1f, %rcx
0000000100007aae	jbe	0x100007af6
0000000100007ab0	movl	%r15d, %eax
0000000100007ab3	andl	$-0x4, %eax
0000000100007ab6	leaq	(,%r15,8), %rcx
0000000100007abe	andq	$-0x20, %rcx
0000000100007ac2	xorl	%edx, %edx
0000000100007ac4	nopw	%cs:(%rax,%rax)
0000000100007ad0	movups	0x8(%r12,%rdx), %xmm0
0000000100007ad6	movups	0x18(%r12,%rdx), %xmm1
0000000100007adc	movups	%xmm0, 0x8(%r14,%rdx)
0000000100007ae2	movups	%xmm1, 0x18(%r14,%rdx)
0000000100007ae8	addq	$0x20, %rdx
0000000100007aec	cmpq	%rdx, %rcx
0000000100007aef	jne	0x100007ad0
0000000100007af1	cmpl	%r15d, %eax
0000000100007af4	je	0x100007b61
0000000100007af6	movq	%r15, %rdx
0000000100007af9	movq	%rax, %rcx
0000000100007afc	andq	$0x3, %rdx
0000000100007b00	je	0x100007b22
0000000100007b02	movq	%rax, %rcx
0000000100007b05	nopw	%cs:(%rax,%rax)
0000000100007b10	movq	0x8(%r12,%rcx,8), %rsi
0000000100007b15	movq	%rsi, 0x8(%r14,%rcx,8)
0000000100007b1a	incq	%rcx
0000000100007b1d	decq	%rdx
0000000100007b20	jne	0x100007b10
0000000100007b22	subq	%r15, %rax
0000000100007b25	cmpq	$-0x4, %rax
0000000100007b29	ja	0x100007b61
0000000100007b2b	nopl	(%rax,%rax)
0000000100007b30	movq	0x8(%r12,%rcx,8), %rax
0000000100007b35	movq	%rax, 0x8(%r14,%rcx,8)
0000000100007b3a	movq	0x10(%r12,%rcx,8), %rax
0000000100007b3f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100007b44	movq	0x18(%r12,%rcx,8), %rax
0000000100007b49	movq	%rax, 0x18(%r14,%rcx,8)
0000000100007b4e	movq	0x20(%r12,%rcx,8), %rax
0000000100007b53	movq	%rax, 0x20(%r14,%rcx,8)
0000000100007b58	addq	$0x4, %rcx
0000000100007b5c	cmpq	%rcx, %r15
0000000100007b5f	jne	0x100007b30
0000000100007b61	cmpl	$0x0, -0x50(%rbp)
0000000100007b65	je	0x100007bf6
0000000100007b6b	movq	-0x50(%rbp), %rcx
0000000100007b6f	movl	%ecx, %eax
0000000100007b71	cmpl	$0x13, %ecx
0000000100007b74	ja	0x100007c75
0000000100007b7a	xorl	%ecx, %ecx
0000000100007b7c	movq	%rax, %rsi
0000000100007b7f	movq	%rcx, %rdx
0000000100007b82	andq	$0x3, %rsi
0000000100007b86	je	0x100007ba5
0000000100007b88	movq	%rcx, %rdx
0000000100007b8b	nopl	(%rax,%rax)
0000000100007b90	movq	(%rbx,%rdx,8), %r9
0000000100007b94	leal	(%r15,%rdx), %r8d
0000000100007b98	movq	%r9, 0x8(%r14,%r8,8)
0000000100007b9d	incq	%rdx
0000000100007ba0	decq	%rsi
0000000100007ba3	jne	0x100007b90
0000000100007ba5	subq	%rax, %rcx
0000000100007ba8	cmpq	$-0x4, %rcx
0000000100007bac	ja	0x100007bf6
0000000100007bae	nop
0000000100007bb0	movq	(%rbx,%rdx,8), %rcx
0000000100007bb4	leal	(%r15,%rdx), %esi
0000000100007bb8	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007bbd	movq	0x8(%rbx,%rdx,8), %rcx
0000000100007bc2	leal	(%r15,%rdx), %esi
0000000100007bc6	incl	%esi
0000000100007bc8	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007bcd	movq	0x10(%rbx,%rdx,8), %rcx
0000000100007bd2	leal	0x2(%r15,%rdx), %esi
0000000100007bd7	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007bdc	movq	0x18(%rbx,%rdx,8), %rcx
0000000100007be1	leal	(%r15,%rdx), %esi
0000000100007be5	addl	$0x3, %esi
0000000100007be8	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007bed	addq	$0x4, %rdx
0000000100007bf1	cmpq	%rdx, %rax
0000000100007bf4	jne	0x100007bb0
0000000100007bf6	movq	-0x58(%rbp), %rax
0000000100007bfa	movq	(%rax), %rax
0000000100007bfd	movl	$0x1, %esi
0000000100007c02	callq	*0x8(%rax)
0000000100007c05	movq	%r14, %rax
0000000100007c08	subq	0xd429(%rip), %rax
0000000100007c0f	movq	0xd44a(%rip), %rcx
0000000100007c16	shlq	$0x10, %rcx
0000000100007c1a	cmpq	%rcx, %rax
0000000100007c1d	jae	0x100007d13
0000000100007c23	movq	0xd456(%rip), %rcx
0000000100007c2a	movq	%rax, %rdx
0000000100007c2d	shrq	$0x10, %rdx
0000000100007c31	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100007c38	leaq	(%rcx,%rdx), %r12
0000000100007c3c	movzbl	(%rcx,%rdx), %ecx
0000000100007c40	cmpb	$0x2, %cl
0000000100007c43	setne	%dl
0000000100007c46	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007c4c	setne	%sil
0000000100007c50	orb	%dl, %sil
0000000100007c53	jne	0x100007cdf
0000000100007c59	addq	$0x228, %r12                    ## imm = 0x228
0000000100007c60	cmpb	$-0x1, (%r12)
0000000100007c65	je	0x100007d06
0000000100007c6b	movb	$0x1, (%r12)
0000000100007c70	jmp	0x100007d13
0000000100007c75	leaq	-0x1(%rax), %rdx
0000000100007c79	xorl	%ecx, %ecx
0000000100007c7b	movl	%edx, %esi
0000000100007c7d	addl	%r15d, %esi
0000000100007c80	jb	0x100007b7c
0000000100007c86	shrq	$0x20, %rdx
0000000100007c8a	jne	0x100007b7c
0000000100007c90	leaq	(%r14,%r15,8), %rcx
0000000100007c94	subq	%rbx, %rcx
0000000100007c97	addq	$0x8, %rcx
0000000100007c9b	cmpq	$0x20, %rcx
0000000100007c9f	jb	0x100007b7a
0000000100007ca5	movl	%eax, %ecx
0000000100007ca7	andl	$-0x4, %ecx
0000000100007caa	xorl	%edx, %edx
0000000100007cac	nopl	(%rax)
0000000100007cb0	movups	(%rbx,%rdx,8), %xmm0
0000000100007cb4	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100007cb9	leal	(%r15,%rdx), %esi
0000000100007cbd	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100007cc3	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100007cc9	addq	$0x4, %rdx
0000000100007ccd	cmpq	%rdx, %rcx
0000000100007cd0	jne	0x100007cb0
0000000100007cd2	cmpl	%eax, %ecx
0000000100007cd4	jne	0x100007b7c
0000000100007cda	jmp	0x100007bf6
0000000100007cdf	cmpb	$0x1, %cl
0000000100007ce2	jne	0x100007d13
0000000100007ce4	movl	0x20(%r12), %ecx
0000000100007ce9	imulq	%rcx, %rax
0000000100007ced	shrq	$0x20, %rax
0000000100007cf1	addq	%rax, %r12
0000000100007cf4	addq	$0x228, %r12                    ## imm = 0x228
0000000100007cfb	cmpb	$-0x1, (%r12)
0000000100007d00	jne	0x100007c6b
0000000100007d06	movq	%r12, %rdi
0000000100007d09	callq	_fwp_rc_forget_slot
0000000100007d0e	jmp	0x100007c6b
0000000100007d13	movq	-0x50(%rbp), %rax
0000000100007d17	movl	%eax, -0x98(%rbp)
0000000100007d1d	movq	$0x0, -0x68(%rbp)
0000000100007d25	cmpq	%r13, _fwp_cleanups(%rip)
0000000100007d2c	jne	0x100007d84
0000000100007d2e	movq	-0xc8(%rbp), %rax
0000000100007d35	movq	%rax, _fwp_cleanups(%rip)
0000000100007d3c	cmpb	$0x0, -0x44(%rbp)
0000000100007d40	movq	-0x40(%rbp), %rdi
0000000100007d44	je	0x100007d5a
0000000100007d46	leaq	-0x80(%rbp), %rcx
0000000100007d4a	cmpq	%rcx, %rax
0000000100007d4d	jne	0x100007d84
0000000100007d4f	movq	-0x80(%rbp), %rax
0000000100007d53	movq	%rax, _fwp_cleanups(%rip)
0000000100007d5a	callq	_fwp_closure_drop
0000000100007d5f	movq	%r14, %r12
0000000100007d62	movq	0xb2c7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007d69	movq	(%rax), %rax
0000000100007d6c	cmpq	-0x30(%rbp), %rax
0000000100007d70	jne	0x100007d89
0000000100007d72	movq	%r12, %rax
0000000100007d75	leaq	-0x28(%rbp), %rsp
0000000100007d79	popq	%rbx
0000000100007d7a	popq	%r12
0000000100007d7c	popq	%r13
0000000100007d7e	popq	%r14
0000000100007d80	popq	%r15
0000000100007d82	popq	%rbp
0000000100007d83	retq
0000000100007d84	callq	0x10001145a                     ## symbol stub for: _abort
0000000100007d89	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100007d8e	nop
_fwp_alloc:
0000000100007d90	pushq	%rbp
0000000100007d91	movq	%rsp, %rbp
0000000100007d94	pushq	%rbx
0000000100007d95	pushq	%rax
0000000100007d96	cmpq	$0x4000, %rdi                   ## imm = 0x4000
0000000100007d9d	ja	0x100007df7
0000000100007d9f	leaq	0xf(%rdi), %rcx
0000000100007da3	shrq	$0x4, %rcx
0000000100007da7	leaq	_fwp_gc(%rip), %rax
0000000100007dae	movzbl	0xbe8(%rcx,%rax), %ecx
0000000100007db6	movl	0xb48(%rax,%rcx,4), %esi
0000000100007dbd	subq	%rsi, _fwp_gc(%rip)
0000000100007dc4	js	0x100007df7
0000000100007dc6	leaq	(%rcx,%rcx,2), %rcx
0000000100007dca	leaq	(%rax,%rcx,8), %rax
0000000100007dce	addq	$0x788, %rax                    ## imm = 0x788
0000000100007dd4	movq	(%rax), %rbx
0000000100007dd7	testq	%rbx, %rbx
0000000100007dda	je	0x100007de7
0000000100007ddc	movq	(%rbx), %rcx
0000000100007ddf	notq	%rcx
0000000100007de2	movq	%rcx, (%rax)
0000000100007de5	jmp	0x100007e0f
0000000100007de7	movq	0x8(%rax), %rbx
0000000100007deb	movq	0x10(%rax), %rcx
0000000100007def	subq	%rbx, %rcx
0000000100007df2	cmpq	%rsi, %rcx
0000000100007df5	jae	0x100007e07
0000000100007df7	movl	$0x2, %esi
0000000100007dfc	addq	$0x8, %rsp
0000000100007e00	popq	%rbx
0000000100007e01	popq	%rbp
0000000100007e02	jmp	_fwp_gc_alloc_slow
0000000100007e07	leaq	(%rbx,%rsi), %rcx
0000000100007e0b	movq	%rcx, 0x8(%rax)
0000000100007e0f	movq	%rbx, %rdi
0000000100007e12	callq	0x10001141e                     ## symbol stub for: ___bzero
0000000100007e17	movq	%rbx, %rax
0000000100007e1a	addq	$0x8, %rsp
0000000100007e1e	popq	%rbx
0000000100007e1f	popq	%rbp
0000000100007e20	retq
0000000100007e21	nopw	%cs:(%rax,%rax)
_fwp_closure_drop:
0000000100007e30	pushq	%rbp
0000000100007e31	movq	%rsp, %rbp
0000000100007e34	pushq	%r15
0000000100007e36	pushq	%r14
0000000100007e38	pushq	%rbx
0000000100007e39	subq	$0x238, %rsp                    ## imm = 0x238
0000000100007e40	movq	%rdi, %rax
0000000100007e43	subq	0xd1ee(%rip), %rax
0000000100007e4a	movq	0xd20f(%rip), %rcx
0000000100007e51	shlq	$0x10, %rcx
0000000100007e55	cmpq	%rcx, %rax
0000000100007e58	jae	0x100007ef4
0000000100007e5e	movq	%rdi, %rsi
0000000100007e61	movq	0xd218(%rip), %rcx
0000000100007e68	movq	%rax, %rdx
0000000100007e6b	shrq	$0x10, %rdx
0000000100007e6f	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100007e76	leaq	(%rcx,%rdx), %rdi
0000000100007e7a	movzbl	(%rcx,%rdx), %ecx
0000000100007e7e	cmpb	$0x2, %cl
0000000100007e81	setne	%dl
0000000100007e84	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007e8a	setne	%r8b
0000000100007e8e	orb	%dl, %r8b
0000000100007e91	jne	0x100007e9c
0000000100007e93	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007e9a	jmp	0x100007eb6
0000000100007e9c	cmpb	$0x1, %cl
0000000100007e9f	jne	0x100007ef4
0000000100007ea1	movl	0x20(%rdi), %ecx
0000000100007ea4	imulq	%rcx, %rax
0000000100007ea8	shrq	$0x20, %rax
0000000100007eac	addq	%rax, %rdi
0000000100007eaf	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007eb6	movzbl	(%rdi), %eax
0000000100007eb9	testl	%eax, %eax
0000000100007ebb	je	0x100007ef4
0000000100007ebd	cmpl	$0x1, %eax
0000000100007ec0	jne	0x100007ee5
0000000100007ec2	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100007ec9	callq	*(%rdi)
0000000100007ecb	movq	(%rax), %rdi
0000000100007ece	testq	%rdi, %rdi
0000000100007ed1	je	0x100007f02
0000000100007ed3	addq	$0x238, %rsp                    ## imm = 0x238
0000000100007eda	popq	%rbx
0000000100007edb	popq	%r14
0000000100007edd	popq	%r15
0000000100007edf	popq	%rbp
0000000100007ee0	jmp	_fwp_closure_drop_push
0000000100007ee5	cmpl	$0xff, %eax
0000000100007eea	je	0x100007fd6
0000000100007ef0	decb	%al
0000000100007ef2	movb	%al, (%rdi)
0000000100007ef4	addq	$0x238, %rsp                    ## imm = 0x238
0000000100007efb	popq	%rbx
0000000100007efc	popq	%r14
0000000100007efe	popq	%r15
0000000100007f00	popq	%rbp
0000000100007f01	retq
0000000100007f02	leaq	-0x230(%rbp), %rbx
0000000100007f09	movq	%rbx, -0x248(%rbp)
0000000100007f10	movq	$0x0, -0x240(%rbp)
0000000100007f1b	movq	$0x40, -0x238(%rbp)
0000000100007f26	movq	_fwp_cleanups(%rip), %rcx
0000000100007f2d	movq	%rcx, -0x30(%rbp)
0000000100007f31	leaq	_fwp_closure_drop_release(%rip), %rcx
0000000100007f38	movq	%rcx, -0x28(%rbp)
0000000100007f3c	leaq	-0x248(%rbp), %rdi
0000000100007f43	movq	%rdi, -0x20(%rbp)
0000000100007f47	leaq	-0x30(%rbp), %r15
0000000100007f4b	movq	%r15, _fwp_cleanups(%rip)
0000000100007f52	movq	%rax, %r14
0000000100007f55	movq	%rdi, (%rax)
0000000100007f58	callq	_fwp_closure_drop_push
0000000100007f5d	nopl	(%rax)
0000000100007f60	movq	-0x240(%rbp), %rax
0000000100007f67	testq	%rax, %rax
0000000100007f6a	je	0x100007fa1
0000000100007f6c	movq	-0x248(%rbp), %rcx
0000000100007f73	leaq	-0x1(%rax), %rdx
0000000100007f77	movq	%rdx, -0x240(%rbp)
0000000100007f7e	movq	-0x8(%rcx,%rax,8), %rdi
0000000100007f83	movq	_fwp_fns(%rip), %rax
0000000100007f8a	movl	(%rdi), %ecx
0000000100007f8c	shlq	$0x5, %rcx
0000000100007f90	movq	0x18(%rax,%rcx), %rax
0000000100007f95	testq	%rax, %rax
0000000100007f98	je	0x100007fe8
0000000100007f9a	xorl	%esi, %esi
0000000100007f9c	callq	*0x8(%rax)
0000000100007f9f	jmp	0x100007f60
0000000100007fa1	cmpq	%r15, _fwp_cleanups(%rip)
0000000100007fa8	jne	0x100008016
0000000100007faa	movq	-0x30(%rbp), %rax
0000000100007fae	movq	%rax, _fwp_cleanups(%rip)
0000000100007fb5	movq	$0x0, (%r14)
0000000100007fbc	movq	-0x248(%rbp), %rdi
0000000100007fc3	cmpq	%rbx, %rdi
0000000100007fc6	je	0x100007ef4
0000000100007fcc	callq	0x1000114a2                     ## symbol stub for: _free
0000000100007fd1	jmp	0x100007ef4
0000000100007fd6	addq	$0x238, %rsp                    ## imm = 0x238
0000000100007fdd	popq	%rbx
0000000100007fde	popq	%r14
0000000100007fe0	popq	%r15
0000000100007fe2	popq	%rbp
0000000100007fe3	jmp	_fwp_rc_wide_drop
0000000100007fe8	callq	_fwp_flush
0000000100007fed	movq	0xb044(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100007ff4	movq	(%rax), %rdi
0000000100007ff7	leaq	0x9c41(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007ffe	leaq	0x9dce(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100008005	xorl	%eax, %eax
0000000100008007	callq	0x10001148a                     ## symbol stub for: _fprintf
000000010000800c	movl	$0x65, %edi
0000000100008011	callq	0x100011478                     ## symbol stub for: _exit
0000000100008016	callq	0x10001145a                     ## symbol stub for: _abort
000000010000801b	nopl	(%rax,%rax)
_fwp_closure_drop_push:
0000000100008020	pushq	%rbp
0000000100008021	movq	%rsp, %rbp
0000000100008024	pushq	%r15
0000000100008026	pushq	%r14
0000000100008028	pushq	%r13
000000010000802a	pushq	%r12
000000010000802c	pushq	%rbx
000000010000802d	pushq	%rax
000000010000802e	movq	%rsi, %rbx
0000000100008031	movq	%rdi, %r14
0000000100008034	movq	0x8(%rdi), %r13
0000000100008038	cmpq	0x10(%rdi), %r13
000000010000803c	jne	0x1000080a3
000000010000803e	movq	%r13, %rax
0000000100008041	shrq	$0x3c, %rax
0000000100008045	jne	0x1000080c1
0000000100008047	movq	%r13, %rdi
000000010000804a	shlq	$0x4, %rdi
000000010000804e	callq	0x1000114c6                     ## symbol stub for: _malloc
0000000100008053	testq	%rax, %rax
0000000100008056	je	0x1000080e0
000000010000805c	movq	%rax, %r15
000000010000805f	leaq	(,%r13,2), %rax
0000000100008067	movq	%rax, -0x30(%rbp)
000000010000806b	movq	(%r14), %r12
000000010000806e	leaq	(,%r13,8), %rdx
0000000100008076	movq	%r15, %rdi
0000000100008079	movq	%r12, %rsi
000000010000807c	callq	0x1000114d8                     ## symbol stub for: _memcpy
0000000100008081	leaq	0x18(%r14), %rax
0000000100008085	cmpq	%rax, %r12
0000000100008088	je	0x100008096
000000010000808a	movq	%r12, %rdi
000000010000808d	callq	0x1000114a2                     ## symbol stub for: _free
0000000100008092	movq	0x8(%r14), %r13
0000000100008096	movq	%r15, (%r14)
0000000100008099	movq	-0x30(%rbp), %rax
000000010000809d	movq	%rax, 0x10(%r14)
00000001000080a1	jmp	0x1000080a6
00000001000080a3	movq	(%r14), %r15
00000001000080a6	leaq	0x1(%r13), %rax
00000001000080aa	movq	%rax, 0x8(%r14)
00000001000080ae	movq	%rbx, (%r15,%r13,8)
00000001000080b2	addq	$0x8, %rsp
00000001000080b6	popq	%rbx
00000001000080b7	popq	%r12
00000001000080b9	popq	%r13
00000001000080bb	popq	%r14
00000001000080bd	popq	%r15
00000001000080bf	popq	%rbp
00000001000080c0	retq
00000001000080c1	callq	_fwp_flush
00000001000080c6	movq	0xaf6b(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000080cd	movq	(%rax), %rdi
00000001000080d0	leaq	0x9b68(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000080d7	leaq	0x9d23(%rip), %rdx              ## literal pool for: "closure cleanup too large"
00000001000080de	jmp	0x1000080fd
00000001000080e0	callq	_fwp_flush
00000001000080e5	movq	0xaf4c(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000080ec	movq	(%rax), %rdi
00000001000080ef	leaq	0x9b49(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000080f6	leaq	0x9d1e(%rip), %rdx              ## literal pool for: "out of memory"
00000001000080fd	xorl	%eax, %eax
00000001000080ff	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100008104	movl	$0x65, %edi
0000000100008109	callq	0x100011478                     ## symbol stub for: _exit
000000010000810e	nop
_fwp_closure_drop_release:
0000000100008110	pushq	%rbp
0000000100008111	movq	%rsp, %rbp
0000000100008114	pushq	%r14
0000000100008116	pushq	%rbx
0000000100008117	movq	%rdi, %rbx
000000010000811a	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100008121	callq	*(%rdi)
0000000100008123	movq	$0x0, (%rax)
000000010000812a	movq	(%rbx), %rdi
000000010000812d	leaq	0x18(%rbx), %r14
0000000100008131	cmpq	%r14, %rdi
0000000100008134	je	0x10000813b
0000000100008136	callq	0x1000114a2                     ## symbol stub for: _free
000000010000813b	movq	%r14, (%rbx)
000000010000813e	movq	$0x0, 0x8(%rbx)
0000000100008146	popq	%rbx
0000000100008147	popq	%r14
0000000100008149	popq	%rbp
000000010000814a	retq
000000010000814b	nopl	(%rax,%rax)
_fwp_rc_cleanup_cell:
0000000100008150	pushq	%rbp
0000000100008151	movq	%rsp, %rbp
0000000100008154	movq	%rdi, %rax
0000000100008157	movq	(%rdi), %rdi
000000010000815a	movq	$0x0, (%rax)
0000000100008161	testq	%rdi, %rdi
0000000100008164	je	0x10000816c
0000000100008166	popq	%rbp
0000000100008167	jmp	_fwp_rc_free_obj
000000010000816c	popq	%rbp
000000010000816d	retq
000000010000816e	nop
_f32:
0000000100008170	pushq	%rbp
0000000100008171	movq	%rsp, %rbp
0000000100008174	pushq	%r15
0000000100008176	pushq	%r14
0000000100008178	pushq	%r13
000000010000817a	pushq	%r12
000000010000817c	pushq	%rbx
000000010000817d	subq	$0xa8, %rsp
0000000100008184	movq	%rdi, %rbx
0000000100008187	movq	0xaea2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000818e	movq	(%rax), %rax
0000000100008191	movq	%rax, -0x30(%rbp)
0000000100008195	movq	%rdi, -0xa8(%rbp)
000000010000819c	movq	_fwp_cleanups(%rip), %rax
00000001000081a3	movq	%rax, -0xa0(%rbp)
00000001000081aa	leaq	_fwp_owner_release9(%rip), %rax
00000001000081b1	movq	%rax, -0x98(%rbp)
00000001000081b8	leaq	-0xa8(%rbp), %rax
00000001000081bf	movq	%rax, -0x90(%rbp)
00000001000081c6	movq	$0x0, -0x58(%rbp)
00000001000081ce	leaq	-0xa0(%rbp), %rax
00000001000081d5	movq	%rax, -0xd0(%rbp)
00000001000081dc	leaq	_fwp_owner_release10(%rip), %rax
00000001000081e3	movq	%rax, -0xc8(%rbp)
00000001000081ea	leaq	-0x58(%rbp), %rax
00000001000081ee	movq	%rax, -0xc0(%rbp)
00000001000081f5	leaq	-0xd0(%rbp), %r14
00000001000081fc	movq	%r14, _fwp_cleanups(%rip)
0000000100008203	movq	0x10(%rdi), %rax
0000000100008207	subq	0xce2a(%rip), %rax
000000010000820e	movq	0xce4b(%rip), %rcx
0000000100008215	shlq	$0x10, %rcx
0000000100008219	cmpq	%rcx, %rax
000000010000821c	jae	0x100008286
000000010000821e	movq	0xce5b(%rip), %rcx
0000000100008225	movq	%rax, %rdx
0000000100008228	shrq	$0x10, %rdx
000000010000822c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008233	leaq	(%rcx,%rdx), %rdi
0000000100008237	movzbl	(%rcx,%rdx), %ecx
000000010000823b	cmpb	$0x2, %cl
000000010000823e	setne	%dl
0000000100008241	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008247	setne	%sil
000000010000824b	orb	%dl, %sil
000000010000824e	jne	0x100008259
0000000100008250	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008257	jmp	0x100008273
0000000100008259	cmpb	$0x1, %cl
000000010000825c	jne	0x100008286
000000010000825e	movl	0x20(%rdi), %ecx
0000000100008261	imulq	%rcx, %rax
0000000100008265	shrq	$0x20, %rax
0000000100008269	addq	%rax, %rdi
000000010000826c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008273	movzbl	(%rdi), %eax
0000000100008276	testb	%al, %al
0000000100008278	je	0x100008286
000000010000827a	cmpb	$-0x3, %al
000000010000827c	ja	0x100008730
0000000100008282	incb	%al
0000000100008284	movb	%al, (%rdi)
0000000100008286	movq	0x10(%rbx), %rdi
000000010000828a	movq	%rdi, -0x58(%rbp)
000000010000828e	movq	-0xd0(%rbp), %rax
0000000100008295	movq	%rax, _fwp_cleanups(%rip)
000000010000829c	movq	0x8(%rbx), %r13
00000001000082a0	movq	0x18(%rbx), %r14
00000001000082a4	testq	%r13, %r13
00000001000082a7	js	0x1000082c9
00000001000082a9	movq	(%rdi), %rax
00000001000082ac	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000082b6	andq	%rax, %rcx
00000001000082b9	cmpq	%r13, %rcx
00000001000082bc	jbe	0x1000082c9
00000001000082be	testq	%rax, %rax
00000001000082c1	js	0x1000082e6
00000001000082c3	leaq	0x8(%rdi), %rax
00000001000082c7	jmp	0x1000082ea
00000001000082c9	movl	%r14d, %r14d
00000001000082cc	callq	_fwp_drop0
00000001000082d1	movl	$0x1, %r12d
00000001000082d7	xorl	%r15d, %r15d
00000001000082da	movq	_fwp_cleanups(%rip), %rax
00000001000082e1	jmp	0x100008502
00000001000082e6	movq	0x10(%rdi), %rax
00000001000082ea	movss	(%rax,%r13,4), %xmm1
00000001000082f0	movq	_fwp_cleanups(%rip), %rax
00000001000082f7	movq	%rdi, -0xb8(%rbp)
00000001000082fe	movq	%rax, -0x88(%rbp)
0000000100008305	leaq	_fwp_owner_release7(%rip), %rax
000000010000830c	movq	%rax, -0x80(%rbp)
0000000100008310	leaq	-0xb8(%rbp), %rax
0000000100008317	movq	%rax, -0x78(%rbp)
000000010000831b	leaq	-0x88(%rbp), %r15
0000000100008322	movq	%rdi, %rcx
0000000100008325	subq	0xcd0c(%rip), %rcx
000000010000832c	movq	%r15, _fwp_cleanups(%rip)
0000000100008333	movq	0xcd26(%rip), %rax
000000010000833a	shlq	$0x10, %rax
000000010000833e	cmpq	%rax, %rcx
0000000100008341	jae	0x1000083ac
0000000100008343	movq	0xcd36(%rip), %rdx
000000010000834a	movq	%rcx, %rax
000000010000834d	shrq	$0x10, %rax
0000000100008351	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008358	leaq	(%rdx,%rsi), %rax
000000010000835c	movzbl	(%rdx,%rsi), %edx
0000000100008360	cmpb	$0x2, %dl
0000000100008363	setne	%sil
0000000100008367	andq	$0xffff, %rcx                   ## imm = 0xFFFF
000000010000836e	setne	%r8b
0000000100008372	orb	%sil, %r8b
0000000100008375	jne	0x10000837f
0000000100008377	addq	$0x228, %rax                    ## imm = 0x228
000000010000837d	jmp	0x100008398
000000010000837f	cmpb	$0x1, %dl
0000000100008382	jne	0x1000083ac
0000000100008384	movl	0x20(%rax), %edx
0000000100008387	imulq	%rdx, %rcx
000000010000838b	shrq	$0x20, %rcx
000000010000838f	addq	%rcx, %rax
0000000100008392	addq	$0x228, %rax                    ## imm = 0x228
0000000100008398	movzbl	(%rax), %ecx
000000010000839b	testb	%cl, %cl
000000010000839d	je	0x1000083ac
000000010000839f	cmpb	$-0x3, %cl
00000001000083a2	ja	0x10000874f
00000001000083a8	incb	%cl
00000001000083aa	movb	%cl, (%rax)
00000001000083ac	movd	%r14d, %xmm0
00000001000083b1	mulss	0x9397(%rip), %xmm1
00000001000083b9	addss	0x9393(%rip), %xmm1
00000001000083c1	incq	%r13
00000001000083c4	addss	%xmm0, %xmm1
00000001000083c8	movss	%xmm1, -0x4c(%rbp)
00000001000083cd	movq	-0x88(%rbp), %rax
00000001000083d4	movq	%rax, _fwp_cleanups(%rip)
00000001000083db	movq	%rdi, %r15
00000001000083de	callq	_fwp_drop0
00000001000083e3	movd	-0x4c(%rbp), %xmm0
00000001000083e8	movd	%xmm0, %r12d
00000001000083ed	movq	%r15, -0xb0(%rbp)
00000001000083f4	movq	_fwp_cleanups(%rip), %rax
00000001000083fb	movq	%rax, -0x70(%rbp)
00000001000083ff	leaq	_fwp_owner_release8(%rip), %rax
0000000100008406	movq	%rax, -0x68(%rbp)
000000010000840a	leaq	-0xb0(%rbp), %rax
0000000100008411	movq	%rax, -0x60(%rbp)
0000000100008415	leaq	-0x70(%rbp), %rax
0000000100008419	movq	%rax, _fwp_cleanups(%rip)
0000000100008420	movq	%r13, -0x48(%rbp)
0000000100008424	movq	%r15, -0x40(%rbp)
0000000100008428	movq	%r12, -0x38(%rbp)
000000010000842c	movl	$0x20, %edi
0000000100008431	callq	_fwp_alloc_init
0000000100008436	movq	%rax, %r14
0000000100008439	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100008443	movq	%rax, (%r14)
0000000100008446	movq	%r13, 0x8(%r14)
000000010000844a	movq	%r15, 0x10(%r14)
000000010000844e	movq	%r12, 0x18(%r14)
0000000100008452	leaq	-0x48(%rbp), %rax
0000000100008456	movq	%r14, %rax
0000000100008459	subq	0xcbd8(%rip), %rax
0000000100008460	movq	0xcbf9(%rip), %rcx
0000000100008467	shlq	$0x10, %rcx
000000010000846b	cmpq	%rcx, %rax
000000010000846e	jae	0x1000084e0
0000000100008470	movq	0xcc09(%rip), %rcx
0000000100008477	movq	%rax, %rdx
000000010000847a	shrq	$0x10, %rdx
000000010000847e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008485	leaq	(%rcx,%rdx), %r15
0000000100008489	movzbl	(%rcx,%rdx), %ecx
000000010000848d	cmpb	$0x2, %cl
0000000100008490	setne	%dl
0000000100008493	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008499	setne	%sil
000000010000849d	orb	%dl, %sil
00000001000084a0	jne	0x1000084b5
00000001000084a2	addq	$0x228, %r15                    ## imm = 0x228
00000001000084a9	cmpb	$-0x1, (%r15)
00000001000084ad	je	0x1000084d6
00000001000084af	movb	$0x1, (%r15)
00000001000084b3	jmp	0x1000084e0
00000001000084b5	cmpb	$0x1, %cl
00000001000084b8	jne	0x1000084e0
00000001000084ba	movl	0x20(%r15), %ecx
00000001000084be	imulq	%rcx, %rax
00000001000084c2	shrq	$0x20, %rax
00000001000084c6	addq	%rax, %r15
00000001000084c9	addq	$0x228, %r15                    ## imm = 0x228
00000001000084d0	cmpb	$-0x1, (%r15)
00000001000084d4	jne	0x1000084af
00000001000084d6	movq	%r15, %rdi
00000001000084d9	callq	_fwp_rc_forget_slot
00000001000084de	jmp	0x1000084af
00000001000084e0	leaq	-0x70(%rbp), %rax
00000001000084e4	cmpq	%rax, _fwp_cleanups(%rip)
00000001000084eb	jne	0x100008774
00000001000084f1	movq	-0x70(%rbp), %rax
00000001000084f5	movq	%rax, _fwp_cleanups(%rip)
00000001000084fc	movb	$0x1, %r15b
00000001000084ff	xorl	%r12d, %r12d
0000000100008502	leaq	-0xa0(%rbp), %rcx
0000000100008509	cmpq	%rcx, %rax
000000010000850c	jne	0x100008774
0000000100008512	movq	-0xa0(%rbp), %rax
0000000100008519	movq	%rax, _fwp_cleanups(%rip)
0000000100008520	movq	%rbx, %rdi
0000000100008523	callq	_fwp_drop4
0000000100008528	movq	%r12, -0x70(%rbp)
000000010000852c	leaq	-0x68(%rbp), %rbx
0000000100008530	movq	%r14, -0x68(%rbp)
0000000100008534	testb	%r15b, %r15b
0000000100008537	je	0x1000085fd
000000010000853d	movq	%r14, -0x48(%rbp)
0000000100008541	movq	_fwp_cleanups(%rip), %rax
0000000100008548	movq	%rax, -0x88(%rbp)
000000010000854f	leaq	_fwp_owner_release11(%rip), %rax
0000000100008556	movq	%rax, -0x80(%rbp)
000000010000855a	leaq	-0x48(%rbp), %rax
000000010000855e	movq	%rax, -0x78(%rbp)
0000000100008562	leaq	-0x88(%rbp), %r14
0000000100008569	movq	%r14, _fwp_cleanups(%rip)
0000000100008570	movl	$0x10, %edi
0000000100008575	callq	_fwp_alloc_init
000000010000857a	movabsq	$__mh_execute_header, %rcx
0000000100008584	movq	%rcx, (%rax)
0000000100008587	movq	-0x68(%rbp), %rcx
000000010000858b	movq	%rcx, 0x8(%rax)
000000010000858f	movq	%rax, %rcx
0000000100008592	subq	0xca9f(%rip), %rcx
0000000100008599	movq	0xcac0(%rip), %rdx
00000001000085a0	shlq	$0x10, %rdx
00000001000085a4	cmpq	%rdx, %rcx
00000001000085a7	jae	0x1000086b9
00000001000085ad	movq	0xcacc(%rip), %rdx
00000001000085b4	movq	%rcx, %rsi
00000001000085b7	shrq	$0x10, %rsi
00000001000085bb	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
00000001000085c2	leaq	(%rdx,%rsi), %rbx
00000001000085c6	movzbl	(%rdx,%rsi), %edx
00000001000085ca	cmpb	$0x2, %dl
00000001000085cd	setne	%sil
00000001000085d1	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000085d8	setne	%dil
00000001000085dc	orb	%sil, %dil
00000001000085df	jne	0x100008683
00000001000085e5	addq	$0x228, %rbx                    ## imm = 0x228
00000001000085ec	cmpb	$-0x1, (%rbx)
00000001000085ef	je	0x1000086a6
00000001000085f5	movb	$0x1, (%rbx)
00000001000085f8	jmp	0x1000086b9
00000001000085fd	movl	$0x10, %edi
0000000100008602	callq	_fwp_alloc_init
0000000100008607	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100008611	movq	%rcx, (%rax)
0000000100008614	movq	%r14, 0x8(%rax)
0000000100008618	movq	%rax, %rcx
000000010000861b	subq	0xca16(%rip), %rcx
0000000100008622	movq	0xca37(%rip), %rdx
0000000100008629	shlq	$0x10, %rdx
000000010000862d	cmpq	%rdx, %rcx
0000000100008630	jae	0x1000086d4
0000000100008636	movq	0xca43(%rip), %rdx
000000010000863d	movq	%rcx, %rsi
0000000100008640	shrq	$0x10, %rsi
0000000100008644	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
000000010000864b	leaq	(%rdx,%rsi), %rbx
000000010000864f	movzbl	(%rdx,%rsi), %edx
0000000100008653	cmpb	$0x2, %dl
0000000100008656	setne	%sil
000000010000865a	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008661	setne	%dil
0000000100008665	orb	%sil, %dil
0000000100008668	jne	0x1000086fa
000000010000866e	addq	$0x228, %rbx                    ## imm = 0x228
0000000100008675	cmpb	$-0x1, (%rbx)
0000000100008678	je	0x10000871d
000000010000867e	movb	$0x1, (%rbx)
0000000100008681	jmp	0x1000086d4
0000000100008683	cmpb	$0x1, %dl
0000000100008686	jne	0x1000086b9
0000000100008688	movl	0x20(%rbx), %edx
000000010000868b	imulq	%rdx, %rcx
000000010000868f	shrq	$0x20, %rcx
0000000100008693	addq	%rcx, %rbx
0000000100008696	addq	$0x228, %rbx                    ## imm = 0x228
000000010000869d	cmpb	$-0x1, (%rbx)
00000001000086a0	jne	0x1000085f5
00000001000086a6	movq	%rbx, %rdi
00000001000086a9	movq	%rax, %r15
00000001000086ac	callq	_fwp_rc_forget_slot
00000001000086b1	movq	%r15, %rax
00000001000086b4	jmp	0x1000085f5
00000001000086b9	cmpq	%r14, _fwp_cleanups(%rip)
00000001000086c0	jne	0x100008774
00000001000086c6	movq	-0x88(%rbp), %rcx
00000001000086cd	movq	%rcx, _fwp_cleanups(%rip)
00000001000086d4	movq	0xa955(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
00000001000086db	movq	(%rcx), %rcx
00000001000086de	cmpq	-0x30(%rbp), %rcx
00000001000086e2	jne	0x100008779
00000001000086e8	addq	$0xa8, %rsp
00000001000086ef	popq	%rbx
00000001000086f0	popq	%r12
00000001000086f2	popq	%r13
00000001000086f4	popq	%r14
00000001000086f6	popq	%r15
00000001000086f8	popq	%rbp
00000001000086f9	retq
00000001000086fa	cmpb	$0x1, %dl
00000001000086fd	jne	0x1000086d4
00000001000086ff	movl	0x20(%rbx), %edx
0000000100008702	imulq	%rdx, %rcx
0000000100008706	shrq	$0x20, %rcx
000000010000870a	addq	%rcx, %rbx
000000010000870d	addq	$0x228, %rbx                    ## imm = 0x228
0000000100008714	cmpb	$-0x1, (%rbx)
0000000100008717	jne	0x10000867e
000000010000871d	movq	%rbx, %rdi
0000000100008720	movq	%rax, %r14
0000000100008723	callq	_fwp_rc_forget_slot
0000000100008728	movq	%r14, %rax
000000010000872b	jmp	0x10000867e
0000000100008730	callq	_fwp_rc_wide_dup
0000000100008735	movq	_fwp_cleanups(%rip), %rax
000000010000873c	movq	0x10(%rbx), %rdi
0000000100008740	movq	%rdi, -0x58(%rbp)
0000000100008744	cmpq	%r14, %rax
0000000100008747	je	0x10000828e
000000010000874d	jmp	0x100008774
000000010000874f	movq	%rdi, %r12
0000000100008752	movq	%rax, %rdi
0000000100008755	movss	%xmm1, -0x4c(%rbp)
000000010000875a	callq	_fwp_rc_wide_dup
000000010000875f	movss	-0x4c(%rbp), %xmm1
0000000100008764	movq	%r12, %rdi
0000000100008767	cmpq	%r15, _fwp_cleanups(%rip)
000000010000876e	je	0x1000083ac
0000000100008774	callq	0x10001145a                     ## symbol stub for: _abort
0000000100008779	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000877e	nop
_fwp_owner_release9:
0000000100008780	pushq	%rbp
0000000100008781	movq	%rsp, %rbp
0000000100008784	movq	(%rdi), %rdi
0000000100008787	popq	%rbp
0000000100008788	jmp	_fwp_drop4
000000010000878d	nopl	(%rax)
_fwp_owner_release10:
0000000100008790	pushq	%rbp
0000000100008791	movq	%rsp, %rbp
0000000100008794	movq	(%rdi), %rdi
0000000100008797	popq	%rbp
0000000100008798	jmp	_fwp_drop0
000000010000879d	nopl	(%rax)
_fwp_drop4:
00000001000087a0	movq	%rdi, %rcx
00000001000087a3	subq	0xc88e(%rip), %rcx
00000001000087aa	movq	0xc8af(%rip), %rax
00000001000087b1	shlq	$0x10, %rax
00000001000087b5	cmpq	%rax, %rcx
00000001000087b8	jae	0x10000884e
00000001000087be	movq	0xc8bb(%rip), %rdx
00000001000087c5	movq	%rcx, %rax
00000001000087c8	shrq	$0x10, %rax
00000001000087cc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000087d3	leaq	(%rdx,%rsi), %rax
00000001000087d7	movzbl	(%rdx,%rsi), %edx
00000001000087db	cmpb	$0x2, %dl
00000001000087de	setne	%sil
00000001000087e2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000087e9	setne	%r8b
00000001000087ed	orb	%sil, %r8b
00000001000087f0	jne	0x1000087fa
00000001000087f2	addq	$0x228, %rax                    ## imm = 0x228
00000001000087f8	jmp	0x100008813
00000001000087fa	cmpb	$0x1, %dl
00000001000087fd	jne	0x10000884e
00000001000087ff	movl	0x20(%rax), %edx
0000000100008802	imulq	%rdx, %rcx
0000000100008806	shrq	$0x20, %rcx
000000010000880a	addq	%rcx, %rax
000000010000880d	addq	$0x228, %rax                    ## imm = 0x228
0000000100008813	movzbl	(%rax), %ecx
0000000100008816	testl	%ecx, %ecx
0000000100008818	je	0x10000884e
000000010000881a	cmpl	$0x1, %ecx
000000010000881d	jne	0x100008842
000000010000881f	pushq	%rbp
0000000100008820	movq	%rsp, %rbp
0000000100008823	pushq	%rbx
0000000100008824	pushq	%rax
0000000100008825	movq	0x10(%rdi), %rax
0000000100008829	movq	%rdi, %rbx
000000010000882c	movq	%rax, %rdi
000000010000882f	callq	_fwp_drop0
0000000100008834	movq	%rbx, %rdi
0000000100008837	addq	$0x8, %rsp
000000010000883b	popq	%rbx
000000010000883c	popq	%rbp
000000010000883d	jmp	_fwp_rc_free_obj
0000000100008842	cmpl	$0xff, %ecx
0000000100008848	je	0x10000884f
000000010000884a	decb	%cl
000000010000884c	movb	%cl, (%rax)
000000010000884e	retq
000000010000884f	movq	%rax, %rdi
0000000100008852	jmp	_fwp_rc_wide_drop
0000000100008857	nopw	(%rax,%rax)
_fwp_owner_release7:
0000000100008860	pushq	%rbp
0000000100008861	movq	%rsp, %rbp
0000000100008864	movq	(%rdi), %rdi
0000000100008867	popq	%rbp
0000000100008868	jmp	_fwp_drop0
000000010000886d	nopl	(%rax)
_fwp_owner_release8:
0000000100008870	pushq	%rbp
0000000100008871	movq	%rsp, %rbp
0000000100008874	movq	(%rdi), %rdi
0000000100008877	popq	%rbp
0000000100008878	jmp	_fwp_drop0
000000010000887d	nopl	(%rax)
_fwp_owner_release11:
0000000100008880	pushq	%rbp
0000000100008881	movq	%rsp, %rbp
0000000100008884	movq	(%rdi), %rdi
0000000100008887	popq	%rbp
0000000100008888	jmp	_fwp_drop4
000000010000888d	nopl	(%rax)
_fwp_owned_entry32:
0000000100008890	pushq	%rbp
0000000100008891	movq	%rsp, %rbp
0000000100008894	movq	(%rdi), %rdi
0000000100008897	popq	%rbp
0000000100008898	jmp	_f32
000000010000889d	nopl	(%rax)
_fwp_caps32:
00000001000088a0	movl	0x4(%rdi), %eax
00000001000088a3	testl	%esi, %esi
00000001000088a5	je	0x100008909
00000001000088a7	testl	%eax, %eax
00000001000088a9	je	0x100008961
00000001000088af	movq	0x8(%rdi), %rax
00000001000088b3	subq	0xc77e(%rip), %rax
00000001000088ba	movq	0xc79f(%rip), %rcx
00000001000088c1	shlq	$0x10, %rcx
00000001000088c5	cmpq	%rcx, %rax
00000001000088c8	jae	0x100008961
00000001000088ce	movq	0xc7ab(%rip), %rcx
00000001000088d5	movq	%rax, %rdx
00000001000088d8	shrq	$0x10, %rdx
00000001000088dc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000088e3	leaq	(%rcx,%rdx), %rdi
00000001000088e7	movzbl	(%rcx,%rdx), %ecx
00000001000088eb	cmpb	$0x2, %cl
00000001000088ee	setne	%dl
00000001000088f1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000088f7	setne	%sil
00000001000088fb	orb	%dl, %sil
00000001000088fe	jne	0x100008934
0000000100008900	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008907	jmp	0x10000894e
0000000100008909	testl	%eax, %eax
000000010000890b	je	_fwp_rc_free_obj
0000000100008911	pushq	%rbp
0000000100008912	movq	%rsp, %rbp
0000000100008915	pushq	%rbx
0000000100008916	pushq	%rax
0000000100008917	movq	0x8(%rdi), %rax
000000010000891b	movq	%rdi, %rbx
000000010000891e	movq	%rax, %rdi
0000000100008921	callq	_fwp_drop4
0000000100008926	movq	%rbx, %rdi
0000000100008929	addq	$0x8, %rsp
000000010000892d	popq	%rbx
000000010000892e	popq	%rbp
000000010000892f	jmp	_fwp_rc_free_obj
0000000100008934	cmpb	$0x1, %cl
0000000100008937	jne	0x100008961
0000000100008939	movl	0x20(%rdi), %ecx
000000010000893c	imulq	%rcx, %rax
0000000100008940	shrq	$0x20, %rax
0000000100008944	addq	%rax, %rdi
0000000100008947	addq	$0x228, %rdi                    ## imm = 0x228
000000010000894e	movzbl	(%rdi), %eax
0000000100008951	testb	%al, %al
0000000100008953	je	0x100008961
0000000100008955	cmpb	$-0x2, %al
0000000100008957	jae	_fwp_rc_wide_dup
000000010000895d	incb	%al
000000010000895f	movb	%al, (%rdi)
0000000100008961	retq
0000000100008962	nopw	%cs:(%rax,%rax)
_fwp_args32:
0000000100008970	pushq	%rbp
0000000100008971	movq	%rsp, %rbp
0000000100008974	testl	%esi, %esi
0000000100008976	setne	%al
0000000100008979	testl	%edx, %edx
000000010000897b	sete	%cl
000000010000897e	orb	%al, %cl
0000000100008980	jne	0x100008a00
0000000100008982	movq	(%rdi), %rax
0000000100008985	subq	0xc6ac(%rip), %rax
000000010000898c	movq	0xc6cd(%rip), %rcx
0000000100008993	shlq	$0x10, %rcx
0000000100008997	cmpq	%rcx, %rax
000000010000899a	jae	0x100008a00
000000010000899c	movq	0xc6dd(%rip), %rcx
00000001000089a3	movq	%rax, %rdx
00000001000089a6	shrq	$0x10, %rdx
00000001000089aa	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000089b1	leaq	(%rcx,%rdx), %rdi
00000001000089b5	movzbl	(%rcx,%rdx), %ecx
00000001000089b9	cmpb	$0x2, %cl
00000001000089bc	setne	%dl
00000001000089bf	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000089c5	setne	%sil
00000001000089c9	orb	%dl, %sil
00000001000089cc	jne	0x1000089d7
00000001000089ce	addq	$0x228, %rdi                    ## imm = 0x228
00000001000089d5	jmp	0x1000089f1
00000001000089d7	cmpb	$0x1, %cl
00000001000089da	jne	0x100008a00
00000001000089dc	movl	0x20(%rdi), %ecx
00000001000089df	imulq	%rcx, %rax
00000001000089e3	shrq	$0x20, %rax
00000001000089e7	addq	%rax, %rdi
00000001000089ea	addq	$0x228, %rdi                    ## imm = 0x228
00000001000089f1	movzbl	(%rdi), %eax
00000001000089f4	testb	%al, %al
00000001000089f6	je	0x100008a00
00000001000089f8	cmpb	$-0x2, %al
00000001000089fa	jae	0x100008a02
00000001000089fc	incb	%al
00000001000089fe	movb	%al, (%rdi)
0000000100008a00	popq	%rbp
0000000100008a01	retq
0000000100008a02	popq	%rbp
0000000100008a03	jmp	_fwp_rc_wide_dup
0000000100008a08	nopl	(%rax,%rax)
_fwp_arg_drop32:
0000000100008a10	pushq	%rbp
0000000100008a11	movq	%rsp, %rbp
0000000100008a14	testl	%esi, %esi
0000000100008a16	setne	%al
0000000100008a19	testl	%edx, %edx
0000000100008a1b	sete	%cl
0000000100008a1e	orb	%al, %cl
0000000100008a20	je	0x100008a24
0000000100008a22	popq	%rbp
0000000100008a23	retq
0000000100008a24	movq	(%rdi), %rdi
0000000100008a27	popq	%rbp
0000000100008a28	jmp	_fwp_drop4
0000000100008a2d	nopl	(%rax)
_fwp_drop5:
0000000100008a30	movq	%rdi, %rcx
0000000100008a33	subq	0xc5fe(%rip), %rcx
0000000100008a3a	movq	0xc61f(%rip), %rax
0000000100008a41	shlq	$0x10, %rax
0000000100008a45	cmpq	%rax, %rcx
0000000100008a48	jae	0x100008aed
0000000100008a4e	movq	0xc62b(%rip), %rdx
0000000100008a55	movq	%rcx, %rax
0000000100008a58	shrq	$0x10, %rax
0000000100008a5c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008a63	leaq	(%rdx,%rsi), %rax
0000000100008a67	movzbl	(%rdx,%rsi), %edx
0000000100008a6b	cmpb	$0x2, %dl
0000000100008a6e	setne	%sil
0000000100008a72	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008a79	setne	%r8b
0000000100008a7d	orb	%sil, %r8b
0000000100008a80	jne	0x100008a8a
0000000100008a82	addq	$0x228, %rax                    ## imm = 0x228
0000000100008a88	jmp	0x100008aa3
0000000100008a8a	cmpb	$0x1, %dl
0000000100008a8d	jne	0x100008aed
0000000100008a8f	movl	0x20(%rax), %edx
0000000100008a92	imulq	%rdx, %rcx
0000000100008a96	shrq	$0x20, %rcx
0000000100008a9a	addq	%rcx, %rax
0000000100008a9d	addq	$0x228, %rax                    ## imm = 0x228
0000000100008aa3	movzbl	(%rax), %ecx
0000000100008aa6	testl	%ecx, %ecx
0000000100008aa8	je	0x100008aed
0000000100008aaa	cmpl	$0x1, %ecx
0000000100008aad	jne	0x100008ae1
0000000100008aaf	movl	(%rdi), %eax
0000000100008ab1	cmpl	$0x1, %eax
0000000100008ab4	je	_fwp_rc_free_obj
0000000100008aba	testl	%eax, %eax
0000000100008abc	jne	0x100008aed
0000000100008abe	pushq	%rbp
0000000100008abf	movq	%rsp, %rbp
0000000100008ac2	pushq	%rbx
0000000100008ac3	pushq	%rax
0000000100008ac4	movq	0x8(%rdi), %rax
0000000100008ac8	movq	%rdi, %rbx
0000000100008acb	movq	%rax, %rdi
0000000100008ace	callq	_fwp_drop4
0000000100008ad3	movq	%rbx, %rdi
0000000100008ad6	addq	$0x8, %rsp
0000000100008ada	popq	%rbx
0000000100008adb	popq	%rbp
0000000100008adc	jmp	_fwp_rc_free_obj
0000000100008ae1	cmpl	$0xff, %ecx
0000000100008ae7	je	0x100008aee
0000000100008ae9	decb	%cl
0000000100008aeb	movb	%cl, (%rax)
0000000100008aed	retq
0000000100008aee	movq	%rax, %rdi
0000000100008af1	jmp	_fwp_rc_wide_drop
0000000100008af6	nopw	%cs:(%rax,%rax)
_f35:
0000000100008b00	pushq	%rbp
0000000100008b01	movq	%rsp, %rbp
0000000100008b04	pushq	%r15
0000000100008b06	pushq	%r14
0000000100008b08	pushq	%r13
0000000100008b0a	pushq	%r12
0000000100008b0c	pushq	%rbx
0000000100008b0d	subq	$0x128, %rsp                    ## imm = 0x128
0000000100008b14	movq	%rdi, %rbx
0000000100008b17	movq	0xa512(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008b1e	movq	(%rax), %rax
0000000100008b21	movq	%rax, -0x30(%rbp)
0000000100008b25	movq	%rdi, -0x100(%rbp)
0000000100008b2c	movq	_fwp_cleanups(%rip), %rax
0000000100008b33	movq	%rax, -0xe0(%rbp)
0000000100008b3a	leaq	_fwp_owner_release17(%rip), %rax
0000000100008b41	movq	%rax, -0xd8(%rbp)
0000000100008b48	leaq	-0x100(%rbp), %rax
0000000100008b4f	movq	%rax, -0xd0(%rbp)
0000000100008b56	movq	$0x0, -0xb0(%rbp)
0000000100008b61	leaq	-0xe0(%rbp), %rax
0000000100008b68	movq	%rax, -0x138(%rbp)
0000000100008b6f	leaq	_fwp_owner_release18(%rip), %rax
0000000100008b76	movq	%rax, -0x130(%rbp)
0000000100008b7d	leaq	-0xb0(%rbp), %rax
0000000100008b84	movq	%rax, -0x128(%rbp)
0000000100008b8b	leaq	-0x138(%rbp), %r15
0000000100008b92	movq	%r15, _fwp_cleanups(%rip)
0000000100008b99	movq	0x10(%rdi), %rax
0000000100008b9d	subq	0xc494(%rip), %rax
0000000100008ba4	movq	0xc4b5(%rip), %rcx
0000000100008bab	shlq	$0x10, %rcx
0000000100008baf	cmpq	%rcx, %rax
0000000100008bb2	jae	0x100008c1c
0000000100008bb4	movq	0xc4c5(%rip), %rcx
0000000100008bbb	movq	%rax, %rdx
0000000100008bbe	shrq	$0x10, %rdx
0000000100008bc2	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008bc9	leaq	(%rcx,%rdx), %rdi
0000000100008bcd	movzbl	(%rcx,%rdx), %ecx
0000000100008bd1	cmpb	$0x2, %cl
0000000100008bd4	setne	%dl
0000000100008bd7	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008bdd	setne	%sil
0000000100008be1	orb	%dl, %sil
0000000100008be4	jne	0x100008bef
0000000100008be6	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008bed	jmp	0x100008c09
0000000100008bef	cmpb	$0x1, %cl
0000000100008bf2	jne	0x100008c1c
0000000100008bf4	movl	0x20(%rdi), %ecx
0000000100008bf7	imulq	%rcx, %rax
0000000100008bfb	shrq	$0x20, %rax
0000000100008bff	addq	%rax, %rdi
0000000100008c02	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008c09	movzbl	(%rdi), %eax
0000000100008c0c	testb	%al, %al
0000000100008c0e	je	0x100008c1c
0000000100008c10	cmpb	$-0x3, %al
0000000100008c12	ja	0x100009160
0000000100008c18	incb	%al
0000000100008c1a	movb	%al, (%rdi)
0000000100008c1c	movq	0x10(%rbx), %r14
0000000100008c20	movq	%r14, -0xb0(%rbp)
0000000100008c27	movq	-0x138(%rbp), %rax
0000000100008c2e	movq	%rax, _fwp_cleanups(%rip)
0000000100008c35	movq	0x8(%rbx), %r13
0000000100008c39	movq	0x18(%rbx), %r12
0000000100008c3d	testq	%r13, %r13
0000000100008c40	js	0x100008c62
0000000100008c42	movq	(%r14), %rax
0000000100008c45	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100008c4f	andq	%rax, %rcx
0000000100008c52	cmpq	%r13, %rcx
0000000100008c55	jbe	0x100008c62
0000000100008c57	testq	%rax, %rax
0000000100008c5a	js	0x100008c7f
0000000100008c5c	leaq	0x8(%r14), %rax
0000000100008c60	jmp	0x100008c83
0000000100008c62	movq	%r14, %rdi
0000000100008c65	callq	_fwp_drop0
0000000100008c6a	movl	$0x1, %r15d
0000000100008c70	xorl	%r14d, %r14d
0000000100008c73	movq	_fwp_cleanups(%rip), %rcx
0000000100008c7a	jmp	0x100008f1d
0000000100008c7f	movq	0x10(%r14), %rax
0000000100008c83	movsbq	(%rax,%r13), %rcx
0000000100008c88	movq	_fwp_cleanups(%rip), %rax
0000000100008c8f	movq	%r14, -0x120(%rbp)
0000000100008c96	movq	%rax, -0xc8(%rbp)
0000000100008c9d	leaq	_fwp_owner_release13(%rip), %rdx
0000000100008ca4	movq	%rdx, -0xc0(%rbp)
0000000100008cab	leaq	-0x120(%rbp), %rdx
0000000100008cb2	movq	%rdx, -0xb8(%rbp)
0000000100008cb9	leaq	-0xc8(%rbp), %rdx
0000000100008cc0	movq	%rdx, _fwp_cleanups(%rip)
0000000100008cc7	addq	$-0x7f, %rcx
0000000100008ccb	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100008cd2	jbe	0x10000919e
0000000100008cd8	movq	%r14, -0x118(%rbp)
0000000100008cdf	movq	%rax, -0xf8(%rbp)
0000000100008ce6	leaq	_fwp_owner_release14(%rip), %rax
0000000100008ced	movq	%rax, -0xf0(%rbp)
0000000100008cf4	leaq	-0x118(%rbp), %rax
0000000100008cfb	movq	%rax, -0xe8(%rbp)
0000000100008d02	leaq	-0xf8(%rbp), %r15
0000000100008d09	movq	%r14, %rax
0000000100008d0c	subq	0xc325(%rip), %rax
0000000100008d13	movq	%r15, _fwp_cleanups(%rip)
0000000100008d1a	movq	0xc33f(%rip), %rcx
0000000100008d21	shlq	$0x10, %rcx
0000000100008d25	cmpq	%rcx, %rax
0000000100008d28	jae	0x100008d92
0000000100008d2a	movq	0xc34f(%rip), %rcx
0000000100008d31	movq	%rax, %rdx
0000000100008d34	shrq	$0x10, %rdx
0000000100008d38	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008d3f	leaq	(%rcx,%rdx), %rdi
0000000100008d43	movzbl	(%rcx,%rdx), %ecx
0000000100008d47	cmpb	$0x2, %cl
0000000100008d4a	setne	%dl
0000000100008d4d	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008d53	setne	%sil
0000000100008d57	orb	%dl, %sil
0000000100008d5a	jne	0x100008d65
0000000100008d5c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008d63	jmp	0x100008d7f
0000000100008d65	cmpb	$0x1, %cl
0000000100008d68	jne	0x100008d92
0000000100008d6a	movl	0x20(%rdi), %ecx
0000000100008d6d	imulq	%rcx, %rax
0000000100008d71	shrq	$0x20, %rax
0000000100008d75	addq	%rax, %rdi
0000000100008d78	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008d7f	movzbl	(%rdi), %eax
0000000100008d82	testb	%al, %al
0000000100008d84	je	0x100008d92
0000000100008d86	cmpb	$-0x3, %al
0000000100008d88	ja	0x100009182
0000000100008d8e	incb	%al
0000000100008d90	movb	%al, (%rdi)
0000000100008d92	movq	-0xf8(%rbp), %rax
0000000100008d99	movq	%rax, _fwp_cleanups(%rip)
0000000100008da0	movq	%r14, %rdi
0000000100008da3	callq	_fwp_drop0
0000000100008da8	movq	%r14, -0x110(%rbp)
0000000100008daf	movq	_fwp_cleanups(%rip), %rax
0000000100008db6	movq	%rax, -0x150(%rbp)
0000000100008dbd	leaq	_fwp_owner_release15(%rip), %rcx
0000000100008dc4	movq	%rcx, -0x148(%rbp)
0000000100008dcb	leaq	-0x110(%rbp), %rcx
0000000100008dd2	movq	%rcx, -0x140(%rbp)
0000000100008dd9	leaq	-0x150(%rbp), %rcx
0000000100008de0	movq	%rcx, _fwp_cleanups(%rip)
0000000100008de7	incq	%r12
0000000100008dea	jo	0x1000091ae
0000000100008df0	incq	%r13
0000000100008df3	movq	%r14, -0x108(%rbp)
0000000100008dfa	movq	%rax, -0x90(%rbp)
0000000100008e01	leaq	_fwp_owner_release16(%rip), %rax
0000000100008e08	movq	%rax, -0x88(%rbp)
0000000100008e0f	leaq	-0x108(%rbp), %rax
0000000100008e16	movq	%rax, -0x80(%rbp)
0000000100008e1a	leaq	-0x90(%rbp), %r15
0000000100008e21	movq	%r15, _fwp_cleanups(%rip)
0000000100008e28	movq	%r13, -0xa8(%rbp)
0000000100008e2f	movq	%r14, -0xa0(%rbp)
0000000100008e36	movq	%r12, -0x98(%rbp)
0000000100008e3d	movl	$0x20, %edi
0000000100008e42	callq	_fwp_alloc_init
0000000100008e47	movabsq	$0x300000000, %rcx              ## imm = 0x300000000
0000000100008e51	movq	%rcx, (%rax)
0000000100008e54	movq	%r13, 0x8(%rax)
0000000100008e58	movq	%r14, 0x10(%rax)
0000000100008e5c	movq	%r12, 0x18(%rax)
0000000100008e60	leaq	-0xa8(%rbp), %rcx
0000000100008e67	movq	%rax, %rcx
0000000100008e6a	subq	0xc1c7(%rip), %rcx
0000000100008e71	movq	0xc1e8(%rip), %rdx
0000000100008e78	shlq	$0x10, %rdx
0000000100008e7c	cmpq	%rdx, %rcx
0000000100008e7f	jae	0x100008ef9
0000000100008e81	movq	0xc1f8(%rip), %rdx
0000000100008e88	movq	%rcx, %rsi
0000000100008e8b	shrq	$0x10, %rsi
0000000100008e8f	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100008e96	leaq	(%rdx,%rsi), %r14
0000000100008e9a	movzbl	(%rdx,%rsi), %edx
0000000100008e9e	cmpb	$0x2, %dl
0000000100008ea1	setne	%sil
0000000100008ea5	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008eac	setne	%dil
0000000100008eb0	orb	%sil, %dil
0000000100008eb3	jne	0x100008ec8
0000000100008eb5	addq	$0x228, %r14                    ## imm = 0x228
0000000100008ebc	cmpb	$-0x1, (%r14)
0000000100008ec0	je	0x100008ee9
0000000100008ec2	movb	$0x1, (%r14)
0000000100008ec6	jmp	0x100008ef9
0000000100008ec8	cmpb	$0x1, %dl
0000000100008ecb	jne	0x100008ef9
0000000100008ecd	movl	0x20(%r14), %edx
0000000100008ed1	imulq	%rdx, %rcx
0000000100008ed5	shrq	$0x20, %rcx
0000000100008ed9	addq	%rcx, %r14
0000000100008edc	addq	$0x228, %r14                    ## imm = 0x228
0000000100008ee3	cmpb	$-0x1, (%r14)
0000000100008ee7	jne	0x100008ec2
0000000100008ee9	movq	%r14, %rdi
0000000100008eec	movq	%rax, %r12
0000000100008eef	callq	_fwp_rc_forget_slot
0000000100008ef4	movq	%r12, %rax
0000000100008ef7	jmp	0x100008ec2
0000000100008ef9	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008f00	jne	0x100009194
0000000100008f06	movq	-0x90(%rbp), %rcx
0000000100008f0d	movq	%rcx, _fwp_cleanups(%rip)
0000000100008f14	movb	$0x1, %r14b
0000000100008f17	xorl	%r15d, %r15d
0000000100008f1a	movq	%rax, %r12
0000000100008f1d	leaq	-0xe0(%rbp), %rax
0000000100008f24	cmpq	%rax, %rcx
0000000100008f27	jne	0x100009194
0000000100008f2d	movq	-0xe0(%rbp), %rax
0000000100008f34	movq	%rax, _fwp_cleanups(%rip)
0000000100008f3b	movq	%rbx, %rdi
0000000100008f3e	callq	_fwp_drop7
0000000100008f43	movq	%r15, -0xc8(%rbp)
0000000100008f4a	leaq	-0xc0(%rbp), %rbx
0000000100008f51	movq	%r12, -0xc0(%rbp)
0000000100008f58	testb	%r14b, %r14b
0000000100008f5b	je	0x10000902d
0000000100008f61	movq	%r12, -0xf8(%rbp)
0000000100008f68	movq	_fwp_cleanups(%rip), %rax
0000000100008f6f	movq	%rax, -0x90(%rbp)
0000000100008f76	leaq	_fwp_owner_release19(%rip), %rax
0000000100008f7d	movq	%rax, -0x88(%rbp)
0000000100008f84	leaq	-0xf8(%rbp), %rax
0000000100008f8b	movq	%rax, -0x80(%rbp)
0000000100008f8f	leaq	-0x90(%rbp), %r14
0000000100008f96	movq	%r14, _fwp_cleanups(%rip)
0000000100008f9d	movl	$0x10, %edi
0000000100008fa2	callq	_fwp_alloc_init
0000000100008fa7	movabsq	$__mh_execute_header, %rcx
0000000100008fb1	movq	%rcx, (%rax)
0000000100008fb4	movq	-0xc0(%rbp), %rcx
0000000100008fbb	movq	%rcx, 0x8(%rax)
0000000100008fbf	movq	%rax, %rcx
0000000100008fc2	subq	0xc06f(%rip), %rcx
0000000100008fc9	movq	0xc090(%rip), %rdx
0000000100008fd0	shlq	$0x10, %rdx
0000000100008fd4	cmpq	%rdx, %rcx
0000000100008fd7	jae	0x1000090e9
0000000100008fdd	movq	0xc09c(%rip), %rdx
0000000100008fe4	movq	%rcx, %rsi
0000000100008fe7	shrq	$0x10, %rsi
0000000100008feb	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100008ff2	leaq	(%rdx,%rsi), %rbx
0000000100008ff6	movzbl	(%rdx,%rsi), %edx
0000000100008ffa	cmpb	$0x2, %dl
0000000100008ffd	setne	%sil
0000000100009001	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009008	setne	%dil
000000010000900c	orb	%sil, %dil
000000010000900f	jne	0x1000090b3
0000000100009015	addq	$0x228, %rbx                    ## imm = 0x228
000000010000901c	cmpb	$-0x1, (%rbx)
000000010000901f	je	0x1000090d6
0000000100009025	movb	$0x1, (%rbx)
0000000100009028	jmp	0x1000090e9
000000010000902d	movl	$0x10, %edi
0000000100009032	callq	_fwp_alloc_init
0000000100009037	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100009041	movq	%rcx, (%rax)
0000000100009044	movq	%r12, 0x8(%rax)
0000000100009048	movq	%rax, %rcx
000000010000904b	subq	0xbfe6(%rip), %rcx
0000000100009052	movq	0xc007(%rip), %rdx
0000000100009059	shlq	$0x10, %rdx
000000010000905d	cmpq	%rdx, %rcx
0000000100009060	jae	0x100009104
0000000100009066	movq	0xc013(%rip), %rdx
000000010000906d	movq	%rcx, %rsi
0000000100009070	shrq	$0x10, %rsi
0000000100009074	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
000000010000907b	leaq	(%rdx,%rsi), %rbx
000000010000907f	movzbl	(%rdx,%rsi), %edx
0000000100009083	cmpb	$0x2, %dl
0000000100009086	setne	%sil
000000010000908a	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009091	setne	%dil
0000000100009095	orb	%sil, %dil
0000000100009098	jne	0x10000912a
000000010000909e	addq	$0x228, %rbx                    ## imm = 0x228
00000001000090a5	cmpb	$-0x1, (%rbx)
00000001000090a8	je	0x10000914d
00000001000090ae	movb	$0x1, (%rbx)
00000001000090b1	jmp	0x100009104
00000001000090b3	cmpb	$0x1, %dl
00000001000090b6	jne	0x1000090e9
00000001000090b8	movl	0x20(%rbx), %edx
00000001000090bb	imulq	%rdx, %rcx
00000001000090bf	shrq	$0x20, %rcx
00000001000090c3	addq	%rcx, %rbx
00000001000090c6	addq	$0x228, %rbx                    ## imm = 0x228
00000001000090cd	cmpb	$-0x1, (%rbx)
00000001000090d0	jne	0x100009025
00000001000090d6	movq	%rbx, %rdi
00000001000090d9	movq	%rax, %r15
00000001000090dc	callq	_fwp_rc_forget_slot
00000001000090e1	movq	%r15, %rax
00000001000090e4	jmp	0x100009025
00000001000090e9	cmpq	%r14, _fwp_cleanups(%rip)
00000001000090f0	jne	0x100009194
00000001000090f6	movq	-0x90(%rbp), %rcx
00000001000090fd	movq	%rcx, _fwp_cleanups(%rip)
0000000100009104	movq	0x9f25(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000910b	movq	(%rcx), %rcx
000000010000910e	cmpq	-0x30(%rbp), %rcx
0000000100009112	jne	0x100009199
0000000100009118	addq	$0x128, %rsp                    ## imm = 0x128
000000010000911f	popq	%rbx
0000000100009120	popq	%r12
0000000100009122	popq	%r13
0000000100009124	popq	%r14
0000000100009126	popq	%r15
0000000100009128	popq	%rbp
0000000100009129	retq
000000010000912a	cmpb	$0x1, %dl
000000010000912d	jne	0x100009104
000000010000912f	movl	0x20(%rbx), %edx
0000000100009132	imulq	%rdx, %rcx
0000000100009136	shrq	$0x20, %rcx
000000010000913a	addq	%rcx, %rbx
000000010000913d	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009144	cmpb	$-0x1, (%rbx)
0000000100009147	jne	0x1000090ae
000000010000914d	movq	%rbx, %rdi
0000000100009150	movq	%rax, %r14
0000000100009153	callq	_fwp_rc_forget_slot
0000000100009158	movq	%r14, %rax
000000010000915b	jmp	0x1000090ae
0000000100009160	callq	_fwp_rc_wide_dup
0000000100009165	movq	_fwp_cleanups(%rip), %rax
000000010000916c	movq	0x10(%rbx), %r14
0000000100009170	movq	%r14, -0xb0(%rbp)
0000000100009177	cmpq	%r15, %rax
000000010000917a	je	0x100008c27
0000000100009180	jmp	0x100009194
0000000100009182	callq	_fwp_rc_wide_dup
0000000100009187	cmpq	%r15, _fwp_cleanups(%rip)
000000010000918e	je	0x100008d92
0000000100009194	callq	0x10001145a                     ## symbol stub for: _abort
0000000100009199	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000919e	leaq	0x8ab1(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000091a5	leaq	0x8ad7(%rip), %rcx              ## literal pool for: "I8"
00000001000091ac	jmp	0x1000091bc
00000001000091ae	leaq	0x8aa1(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000091b5	leaq	0x8a96(%rip), %rcx              ## literal pool for: "I64"
00000001000091bc	leaq	-0x90(%rbp), %rbx
00000001000091c3	movl	$0x60, %esi
00000001000091c8	movq	%rbx, %rdi
00000001000091cb	xorl	%eax, %eax
00000001000091cd	callq	0x10001153e                     ## symbol stub for: _snprintf
00000001000091d2	callq	_fwp_flush
00000001000091d7	movq	0x9e5a(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000091de	movq	(%rax), %rdi
00000001000091e1	leaq	0x8a57(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000091e8	movq	%rbx, %rdx
00000001000091eb	xorl	%eax, %eax
00000001000091ed	callq	0x10001148a                     ## symbol stub for: _fprintf
00000001000091f2	movl	$0x65, %edi
00000001000091f7	callq	0x100011478                     ## symbol stub for: _exit
00000001000091fc	nopl	(%rax)
_fwp_owner_release17:
0000000100009200	pushq	%rbp
0000000100009201	movq	%rsp, %rbp
0000000100009204	movq	(%rdi), %rdi
0000000100009207	popq	%rbp
0000000100009208	jmp	_fwp_drop7
000000010000920d	nopl	(%rax)
_fwp_owner_release18:
0000000100009210	pushq	%rbp
0000000100009211	movq	%rsp, %rbp
0000000100009214	movq	(%rdi), %rdi
0000000100009217	popq	%rbp
0000000100009218	jmp	_fwp_drop0
000000010000921d	nopl	(%rax)
_fwp_drop7:
0000000100009220	movq	%rdi, %rcx
0000000100009223	subq	0xbe0e(%rip), %rcx
000000010000922a	movq	0xbe2f(%rip), %rax
0000000100009231	shlq	$0x10, %rax
0000000100009235	cmpq	%rax, %rcx
0000000100009238	jae	0x1000092ce
000000010000923e	movq	0xbe3b(%rip), %rdx
0000000100009245	movq	%rcx, %rax
0000000100009248	shrq	$0x10, %rax
000000010000924c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009253	leaq	(%rdx,%rsi), %rax
0000000100009257	movzbl	(%rdx,%rsi), %edx
000000010000925b	cmpb	$0x2, %dl
000000010000925e	setne	%sil
0000000100009262	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009269	setne	%r8b
000000010000926d	orb	%sil, %r8b
0000000100009270	jne	0x10000927a
0000000100009272	addq	$0x228, %rax                    ## imm = 0x228
0000000100009278	jmp	0x100009293
000000010000927a	cmpb	$0x1, %dl
000000010000927d	jne	0x1000092ce
000000010000927f	movl	0x20(%rax), %edx
0000000100009282	imulq	%rdx, %rcx
0000000100009286	shrq	$0x20, %rcx
000000010000928a	addq	%rcx, %rax
000000010000928d	addq	$0x228, %rax                    ## imm = 0x228
0000000100009293	movzbl	(%rax), %ecx
0000000100009296	testl	%ecx, %ecx
0000000100009298	je	0x1000092ce
000000010000929a	cmpl	$0x1, %ecx
000000010000929d	jne	0x1000092c2
000000010000929f	pushq	%rbp
00000001000092a0	movq	%rsp, %rbp
00000001000092a3	pushq	%rbx
00000001000092a4	pushq	%rax
00000001000092a5	movq	0x10(%rdi), %rax
00000001000092a9	movq	%rdi, %rbx
00000001000092ac	movq	%rax, %rdi
00000001000092af	callq	_fwp_drop0
00000001000092b4	movq	%rbx, %rdi
00000001000092b7	addq	$0x8, %rsp
00000001000092bb	popq	%rbx
00000001000092bc	popq	%rbp
00000001000092bd	jmp	_fwp_rc_free_obj
00000001000092c2	cmpl	$0xff, %ecx
00000001000092c8	je	0x1000092cf
00000001000092ca	decb	%cl
00000001000092cc	movb	%cl, (%rax)
00000001000092ce	retq
00000001000092cf	movq	%rax, %rdi
00000001000092d2	jmp	_fwp_rc_wide_drop
00000001000092d7	nopw	(%rax,%rax)
_fwp_owner_release13:
00000001000092e0	pushq	%rbp
00000001000092e1	movq	%rsp, %rbp
00000001000092e4	movq	(%rdi), %rdi
00000001000092e7	popq	%rbp
00000001000092e8	jmp	_fwp_drop0
00000001000092ed	nopl	(%rax)
_fwp_owner_release14:
00000001000092f0	pushq	%rbp
00000001000092f1	movq	%rsp, %rbp
00000001000092f4	movq	(%rdi), %rdi
00000001000092f7	popq	%rbp
00000001000092f8	jmp	_fwp_drop0
00000001000092fd	nopl	(%rax)
_fwp_owner_release15:
0000000100009300	pushq	%rbp
0000000100009301	movq	%rsp, %rbp
0000000100009304	movq	(%rdi), %rdi
0000000100009307	popq	%rbp
0000000100009308	jmp	_fwp_drop0
000000010000930d	nopl	(%rax)
_fwp_owner_release16:
0000000100009310	pushq	%rbp
0000000100009311	movq	%rsp, %rbp
0000000100009314	movq	(%rdi), %rdi
0000000100009317	popq	%rbp
0000000100009318	jmp	_fwp_drop0
000000010000931d	nopl	(%rax)
_fwp_owner_release19:
0000000100009320	pushq	%rbp
0000000100009321	movq	%rsp, %rbp
0000000100009324	movq	(%rdi), %rdi
0000000100009327	popq	%rbp
0000000100009328	jmp	_fwp_drop7
000000010000932d	nopl	(%rax)
_fwp_owned_entry35:
0000000100009330	pushq	%rbp
0000000100009331	movq	%rsp, %rbp
0000000100009334	movq	(%rdi), %rdi
0000000100009337	popq	%rbp
0000000100009338	jmp	_f35
000000010000933d	nopl	(%rax)
_fwp_caps35:
0000000100009340	movl	0x4(%rdi), %eax
0000000100009343	testl	%esi, %esi
0000000100009345	je	0x1000093a9
0000000100009347	testl	%eax, %eax
0000000100009349	je	0x100009401
000000010000934f	movq	0x8(%rdi), %rax
0000000100009353	subq	0xbcde(%rip), %rax
000000010000935a	movq	0xbcff(%rip), %rcx
0000000100009361	shlq	$0x10, %rcx
0000000100009365	cmpq	%rcx, %rax
0000000100009368	jae	0x100009401
000000010000936e	movq	0xbd0b(%rip), %rcx
0000000100009375	movq	%rax, %rdx
0000000100009378	shrq	$0x10, %rdx
000000010000937c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009383	leaq	(%rcx,%rdx), %rdi
0000000100009387	movzbl	(%rcx,%rdx), %ecx
000000010000938b	cmpb	$0x2, %cl
000000010000938e	setne	%dl
0000000100009391	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009397	setne	%sil
000000010000939b	orb	%dl, %sil
000000010000939e	jne	0x1000093d4
00000001000093a0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000093a7	jmp	0x1000093ee
00000001000093a9	testl	%eax, %eax
00000001000093ab	je	_fwp_rc_free_obj
00000001000093b1	pushq	%rbp
00000001000093b2	movq	%rsp, %rbp
00000001000093b5	pushq	%rbx
00000001000093b6	pushq	%rax
00000001000093b7	movq	0x8(%rdi), %rax
00000001000093bb	movq	%rdi, %rbx
00000001000093be	movq	%rax, %rdi
00000001000093c1	callq	_fwp_drop7
00000001000093c6	movq	%rbx, %rdi
00000001000093c9	addq	$0x8, %rsp
00000001000093cd	popq	%rbx
00000001000093ce	popq	%rbp
00000001000093cf	jmp	_fwp_rc_free_obj
00000001000093d4	cmpb	$0x1, %cl
00000001000093d7	jne	0x100009401
00000001000093d9	movl	0x20(%rdi), %ecx
00000001000093dc	imulq	%rcx, %rax
00000001000093e0	shrq	$0x20, %rax
00000001000093e4	addq	%rax, %rdi
00000001000093e7	addq	$0x228, %rdi                    ## imm = 0x228
00000001000093ee	movzbl	(%rdi), %eax
00000001000093f1	testb	%al, %al
00000001000093f3	je	0x100009401
00000001000093f5	cmpb	$-0x2, %al
00000001000093f7	jae	_fwp_rc_wide_dup
00000001000093fd	incb	%al
00000001000093ff	movb	%al, (%rdi)
0000000100009401	retq
0000000100009402	nopw	%cs:(%rax,%rax)
_fwp_args35:
0000000100009410	pushq	%rbp
0000000100009411	movq	%rsp, %rbp
0000000100009414	testl	%esi, %esi
0000000100009416	setne	%al
0000000100009419	testl	%edx, %edx
000000010000941b	sete	%cl
000000010000941e	orb	%al, %cl
0000000100009420	jne	0x1000094a0
0000000100009422	movq	(%rdi), %rax
0000000100009425	subq	0xbc0c(%rip), %rax
000000010000942c	movq	0xbc2d(%rip), %rcx
0000000100009433	shlq	$0x10, %rcx
0000000100009437	cmpq	%rcx, %rax
000000010000943a	jae	0x1000094a0
000000010000943c	movq	0xbc3d(%rip), %rcx
0000000100009443	movq	%rax, %rdx
0000000100009446	shrq	$0x10, %rdx
000000010000944a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009451	leaq	(%rcx,%rdx), %rdi
0000000100009455	movzbl	(%rcx,%rdx), %ecx
0000000100009459	cmpb	$0x2, %cl
000000010000945c	setne	%dl
000000010000945f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009465	setne	%sil
0000000100009469	orb	%dl, %sil
000000010000946c	jne	0x100009477
000000010000946e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009475	jmp	0x100009491
0000000100009477	cmpb	$0x1, %cl
000000010000947a	jne	0x1000094a0
000000010000947c	movl	0x20(%rdi), %ecx
000000010000947f	imulq	%rcx, %rax
0000000100009483	shrq	$0x20, %rax
0000000100009487	addq	%rax, %rdi
000000010000948a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009491	movzbl	(%rdi), %eax
0000000100009494	testb	%al, %al
0000000100009496	je	0x1000094a0
0000000100009498	cmpb	$-0x2, %al
000000010000949a	jae	0x1000094a2
000000010000949c	incb	%al
000000010000949e	movb	%al, (%rdi)
00000001000094a0	popq	%rbp
00000001000094a1	retq
00000001000094a2	popq	%rbp
00000001000094a3	jmp	_fwp_rc_wide_dup
00000001000094a8	nopl	(%rax,%rax)
_fwp_arg_drop35:
00000001000094b0	pushq	%rbp
00000001000094b1	movq	%rsp, %rbp
00000001000094b4	testl	%esi, %esi
00000001000094b6	setne	%al
00000001000094b9	testl	%edx, %edx
00000001000094bb	sete	%cl
00000001000094be	orb	%al, %cl
00000001000094c0	je	0x1000094c4
00000001000094c2	popq	%rbp
00000001000094c3	retq
00000001000094c4	movq	(%rdi), %rdi
00000001000094c7	popq	%rbp
00000001000094c8	jmp	_fwp_drop7
00000001000094cd	nopl	(%rax)
_fwp_drop8:
00000001000094d0	movq	%rdi, %rcx
00000001000094d3	subq	0xbb5e(%rip), %rcx
00000001000094da	movq	0xbb7f(%rip), %rax
00000001000094e1	shlq	$0x10, %rax
00000001000094e5	cmpq	%rax, %rcx
00000001000094e8	jae	0x10000958d
00000001000094ee	movq	0xbb8b(%rip), %rdx
00000001000094f5	movq	%rcx, %rax
00000001000094f8	shrq	$0x10, %rax
00000001000094fc	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009503	leaq	(%rdx,%rsi), %rax
0000000100009507	movzbl	(%rdx,%rsi), %edx
000000010000950b	cmpb	$0x2, %dl
000000010000950e	setne	%sil
0000000100009512	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009519	setne	%r8b
000000010000951d	orb	%sil, %r8b
0000000100009520	jne	0x10000952a
0000000100009522	addq	$0x228, %rax                    ## imm = 0x228
0000000100009528	jmp	0x100009543
000000010000952a	cmpb	$0x1, %dl
000000010000952d	jne	0x10000958d
000000010000952f	movl	0x20(%rax), %edx
0000000100009532	imulq	%rdx, %rcx
0000000100009536	shrq	$0x20, %rcx
000000010000953a	addq	%rcx, %rax
000000010000953d	addq	$0x228, %rax                    ## imm = 0x228
0000000100009543	movzbl	(%rax), %ecx
0000000100009546	testl	%ecx, %ecx
0000000100009548	je	0x10000958d
000000010000954a	cmpl	$0x1, %ecx
000000010000954d	jne	0x100009581
000000010000954f	movl	(%rdi), %eax
0000000100009551	cmpl	$0x1, %eax
0000000100009554	je	_fwp_rc_free_obj
000000010000955a	testl	%eax, %eax
000000010000955c	jne	0x10000958d
000000010000955e	pushq	%rbp
000000010000955f	movq	%rsp, %rbp
0000000100009562	pushq	%rbx
0000000100009563	pushq	%rax
0000000100009564	movq	0x8(%rdi), %rax
0000000100009568	movq	%rdi, %rbx
000000010000956b	movq	%rax, %rdi
000000010000956e	callq	_fwp_drop7
0000000100009573	movq	%rbx, %rdi
0000000100009576	addq	$0x8, %rsp
000000010000957a	popq	%rbx
000000010000957b	popq	%rbp
000000010000957c	jmp	_fwp_rc_free_obj
0000000100009581	cmpl	$0xff, %ecx
0000000100009587	je	0x10000958e
0000000100009589	decb	%cl
000000010000958b	movb	%cl, (%rax)
000000010000958d	retq
000000010000958e	movq	%rax, %rdi
0000000100009591	jmp	_fwp_rc_wide_drop
0000000100009596	nopw	%cs:(%rax,%rax)
_f37:
00000001000095a0	pushq	%rbp
00000001000095a1	movq	%rsp, %rbp
00000001000095a4	pushq	%r15
00000001000095a6	pushq	%r14
00000001000095a8	pushq	%r13
00000001000095aa	pushq	%r12
00000001000095ac	pushq	%rbx
00000001000095ad	subq	$0x128, %rsp                    ## imm = 0x128
00000001000095b4	movq	%rdi, %rbx
00000001000095b7	movq	0x9a72(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000095be	movq	(%rax), %rax
00000001000095c1	movq	%rax, -0x30(%rbp)
00000001000095c5	movq	%rdi, -0x100(%rbp)
00000001000095cc	movq	_fwp_cleanups(%rip), %rax
00000001000095d3	movq	%rax, -0xf8(%rbp)
00000001000095da	leaq	_fwp_owner_release25(%rip), %rax
00000001000095e1	movq	%rax, -0xf0(%rbp)
00000001000095e8	leaq	-0x100(%rbp), %rax
00000001000095ef	movq	%rax, -0xe8(%rbp)
00000001000095f6	movq	$0x0, -0xb0(%rbp)
0000000100009601	leaq	-0xf8(%rbp), %rax
0000000100009608	movq	%rax, -0x138(%rbp)
000000010000960f	leaq	_fwp_owner_release26(%rip), %rax
0000000100009616	movq	%rax, -0x130(%rbp)
000000010000961d	leaq	-0xb0(%rbp), %rax
0000000100009624	movq	%rax, -0x128(%rbp)
000000010000962b	leaq	-0x138(%rbp), %r14
0000000100009632	movq	%r14, _fwp_cleanups(%rip)
0000000100009639	movq	0x10(%rdi), %rax
000000010000963d	subq	0xb9f4(%rip), %rax
0000000100009644	movq	0xba15(%rip), %rcx
000000010000964b	shlq	$0x10, %rcx
000000010000964f	cmpq	%rcx, %rax
0000000100009652	jae	0x1000096bc
0000000100009654	movq	0xba25(%rip), %rcx
000000010000965b	movq	%rax, %rdx
000000010000965e	shrq	$0x10, %rdx
0000000100009662	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009669	leaq	(%rcx,%rdx), %rdi
000000010000966d	movzbl	(%rcx,%rdx), %ecx
0000000100009671	cmpb	$0x2, %cl
0000000100009674	setne	%dl
0000000100009677	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000967d	setne	%sil
0000000100009681	orb	%dl, %sil
0000000100009684	jne	0x10000968f
0000000100009686	addq	$0x228, %rdi                    ## imm = 0x228
000000010000968d	jmp	0x1000096a9
000000010000968f	cmpb	$0x1, %cl
0000000100009692	jne	0x1000096bc
0000000100009694	movl	0x20(%rdi), %ecx
0000000100009697	imulq	%rcx, %rax
000000010000969b	shrq	$0x20, %rax
000000010000969f	addq	%rax, %rdi
00000001000096a2	addq	$0x228, %rdi                    ## imm = 0x228
00000001000096a9	movzbl	(%rdi), %eax
00000001000096ac	testb	%al, %al
00000001000096ae	je	0x1000096bc
00000001000096b0	cmpb	$-0x3, %al
00000001000096b2	ja	0x100009c0b
00000001000096b8	incb	%al
00000001000096ba	movb	%al, (%rdi)
00000001000096bc	movq	0x10(%rbx), %r15
00000001000096c0	movq	%r15, -0xb0(%rbp)
00000001000096c7	movq	-0x138(%rbp), %rax
00000001000096ce	movq	%rax, _fwp_cleanups(%rip)
00000001000096d5	movq	0x8(%rbx), %r13
00000001000096d9	movsbq	0x18(%rbx), %r14
00000001000096de	testq	%r13, %r13
00000001000096e1	js	0x100009703
00000001000096e3	movq	(%r15), %rax
00000001000096e6	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000096f0	andq	%rax, %rcx
00000001000096f3	cmpq	%r13, %rcx
00000001000096f6	jbe	0x100009703
00000001000096f8	testq	%rax, %rax
00000001000096fb	js	0x100009720
00000001000096fd	leaq	0x8(%r15), %rax
0000000100009701	jmp	0x100009724
0000000100009703	movq	%r15, %rdi
0000000100009706	callq	_fwp_drop0
000000010000970b	movl	$0x1, %r12d
0000000100009711	xorl	%r15d, %r15d
0000000100009714	movq	_fwp_cleanups(%rip), %rax
000000010000971b	jmp	0x1000099c8
0000000100009720	movq	0x10(%r15), %rax
0000000100009724	movsbq	(%rax,%r13), %r12
0000000100009729	movq	_fwp_cleanups(%rip), %rax
0000000100009730	movq	%r15, -0x120(%rbp)
0000000100009737	movq	%rax, -0xe0(%rbp)
000000010000973e	leaq	_fwp_owner_release21(%rip), %rcx
0000000100009745	movq	%rcx, -0xd8(%rbp)
000000010000974c	leaq	-0x120(%rbp), %rcx
0000000100009753	movq	%rcx, -0xd0(%rbp)
000000010000975a	leaq	-0xe0(%rbp), %rcx
0000000100009761	movq	%rcx, _fwp_cleanups(%rip)
0000000100009768	leaq	-0x7f(%r12), %rcx
000000010000976d	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100009774	jbe	0x100009c50
000000010000977a	movq	%r15, -0x118(%rbp)
0000000100009781	movq	%rax, -0xc8(%rbp)
0000000100009788	leaq	_fwp_owner_release22(%rip), %rax
000000010000978f	movq	%rax, -0xc0(%rbp)
0000000100009796	leaq	-0x118(%rbp), %rax
000000010000979d	movq	%rax, -0xb8(%rbp)
00000001000097a4	leaq	-0xc8(%rbp), %rcx
00000001000097ab	movq	%r15, %rax
00000001000097ae	subq	0xb883(%rip), %rax
00000001000097b5	movq	%rcx, _fwp_cleanups(%rip)
00000001000097bc	movq	0xb89d(%rip), %rcx
00000001000097c3	shlq	$0x10, %rcx
00000001000097c7	cmpq	%rcx, %rax
00000001000097ca	jae	0x100009834
00000001000097cc	movq	0xb8ad(%rip), %rcx
00000001000097d3	movq	%rax, %rdx
00000001000097d6	shrq	$0x10, %rdx
00000001000097da	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000097e1	leaq	(%rcx,%rdx), %rdi
00000001000097e5	movzbl	(%rcx,%rdx), %ecx
00000001000097e9	cmpb	$0x2, %cl
00000001000097ec	setne	%dl
00000001000097ef	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000097f5	setne	%sil
00000001000097f9	orb	%dl, %sil
00000001000097fc	jne	0x100009807
00000001000097fe	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009805	jmp	0x100009821
0000000100009807	cmpb	$0x1, %cl
000000010000980a	jne	0x100009834
000000010000980c	movl	0x20(%rdi), %ecx
000000010000980f	imulq	%rcx, %rax
0000000100009813	shrq	$0x20, %rax
0000000100009817	addq	%rax, %rdi
000000010000981a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009821	movzbl	(%rdi), %eax
0000000100009824	testb	%al, %al
0000000100009826	je	0x100009834
0000000100009828	cmpb	$-0x3, %al
000000010000982a	ja	0x100009c2d
0000000100009830	incb	%al
0000000100009832	movb	%al, (%rdi)
0000000100009834	movq	-0xc8(%rbp), %rax
000000010000983b	movq	%rax, _fwp_cleanups(%rip)
0000000100009842	movq	%r15, %rdi
0000000100009845	callq	_fwp_drop0
000000010000984a	movq	%r15, -0x110(%rbp)
0000000100009851	movq	_fwp_cleanups(%rip), %rax
0000000100009858	movq	%rax, -0x150(%rbp)
000000010000985f	leaq	_fwp_owner_release23(%rip), %rcx
0000000100009866	movq	%rcx, -0x148(%rbp)
000000010000986d	leaq	-0x110(%rbp), %rcx
0000000100009874	movq	%rcx, -0x140(%rbp)
000000010000987b	leaq	-0x150(%rbp), %rcx
0000000100009882	movq	%rcx, _fwp_cleanups(%rip)
0000000100009889	addq	%r14, %r12
000000010000988c	incq	%r12
000000010000988f	movsbq	%r12b, %rcx
0000000100009893	cmpq	%r12, %rcx
0000000100009896	jne	0x100009c50
000000010000989c	incq	%r13
000000010000989f	movq	%r15, -0x108(%rbp)
00000001000098a6	movq	%rax, -0x90(%rbp)
00000001000098ad	leaq	_fwp_owner_release24(%rip), %rax
00000001000098b4	movq	%rax, -0x88(%rbp)
00000001000098bb	leaq	-0x108(%rbp), %rax
00000001000098c2	movq	%rax, -0x80(%rbp)
00000001000098c6	leaq	-0x90(%rbp), %rax
00000001000098cd	movq	%rax, _fwp_cleanups(%rip)
00000001000098d4	movq	%r13, -0xa8(%rbp)
00000001000098db	movq	%r15, -0xa0(%rbp)
00000001000098e2	movq	%r12, -0x98(%rbp)
00000001000098e9	movl	$0x20, %edi
00000001000098ee	callq	_fwp_alloc_init
00000001000098f3	movq	%rax, %r14
00000001000098f6	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100009900	movq	%rax, (%r14)
0000000100009903	movq	%r13, 0x8(%r14)
0000000100009907	movq	%r15, 0x10(%r14)
000000010000990b	movq	%r12, 0x18(%r14)
000000010000990f	leaq	-0xa8(%rbp), %rax
0000000100009916	movq	%r14, %rax
0000000100009919	subq	0xb718(%rip), %rax
0000000100009920	movq	0xb739(%rip), %rcx
0000000100009927	shlq	$0x10, %rcx
000000010000992b	cmpq	%rcx, %rax
000000010000992e	jae	0x1000099a0
0000000100009930	movq	0xb749(%rip), %rcx
0000000100009937	movq	%rax, %rdx
000000010000993a	shrq	$0x10, %rdx
000000010000993e	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009945	leaq	(%rcx,%rdx), %r15
0000000100009949	movzbl	(%rcx,%rdx), %ecx
000000010000994d	cmpb	$0x2, %cl
0000000100009950	setne	%dl
0000000100009953	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009959	setne	%sil
000000010000995d	orb	%dl, %sil
0000000100009960	jne	0x100009975
0000000100009962	addq	$0x228, %r15                    ## imm = 0x228
0000000100009969	cmpb	$-0x1, (%r15)
000000010000996d	je	0x100009996
000000010000996f	movb	$0x1, (%r15)
0000000100009973	jmp	0x1000099a0
0000000100009975	cmpb	$0x1, %cl
0000000100009978	jne	0x1000099a0
000000010000997a	movl	0x20(%r15), %ecx
000000010000997e	imulq	%rcx, %rax
0000000100009982	shrq	$0x20, %rax
0000000100009986	addq	%rax, %r15
0000000100009989	addq	$0x228, %r15                    ## imm = 0x228
0000000100009990	cmpb	$-0x1, (%r15)
0000000100009994	jne	0x10000996f
0000000100009996	movq	%r15, %rdi
0000000100009999	callq	_fwp_rc_forget_slot
000000010000999e	jmp	0x10000996f
00000001000099a0	leaq	-0x90(%rbp), %rax
00000001000099a7	cmpq	%rax, _fwp_cleanups(%rip)
00000001000099ae	jne	0x100009c46
00000001000099b4	movq	-0x90(%rbp), %rax
00000001000099bb	movq	%rax, _fwp_cleanups(%rip)
00000001000099c2	movb	$0x1, %r15b
00000001000099c5	xorl	%r12d, %r12d
00000001000099c8	leaq	-0xf8(%rbp), %rcx
00000001000099cf	cmpq	%rcx, %rax
00000001000099d2	jne	0x100009c46
00000001000099d8	movq	-0xf8(%rbp), %rax
00000001000099df	movq	%rax, _fwp_cleanups(%rip)
00000001000099e6	movq	%rbx, %rdi
00000001000099e9	callq	_fwp_drop9
00000001000099ee	movq	%r12, -0xe0(%rbp)
00000001000099f5	leaq	-0xd8(%rbp), %rbx
00000001000099fc	movq	%r14, -0xd8(%rbp)
0000000100009a03	testb	%r15b, %r15b
0000000100009a06	je	0x100009ad8
0000000100009a0c	movq	%r14, -0xc8(%rbp)
0000000100009a13	movq	_fwp_cleanups(%rip), %rax
0000000100009a1a	movq	%rax, -0x90(%rbp)
0000000100009a21	leaq	_fwp_owner_release27(%rip), %rax
0000000100009a28	movq	%rax, -0x88(%rbp)
0000000100009a2f	leaq	-0xc8(%rbp), %rax
0000000100009a36	movq	%rax, -0x80(%rbp)
0000000100009a3a	leaq	-0x90(%rbp), %r14
0000000100009a41	movq	%r14, _fwp_cleanups(%rip)
0000000100009a48	movl	$0x10, %edi
0000000100009a4d	callq	_fwp_alloc_init
0000000100009a52	movabsq	$__mh_execute_header, %rcx
0000000100009a5c	movq	%rcx, (%rax)
0000000100009a5f	movq	-0xd8(%rbp), %rcx
0000000100009a66	movq	%rcx, 0x8(%rax)
0000000100009a6a	movq	%rax, %rcx
0000000100009a6d	subq	0xb5c4(%rip), %rcx
0000000100009a74	movq	0xb5e5(%rip), %rdx
0000000100009a7b	shlq	$0x10, %rdx
0000000100009a7f	cmpq	%rdx, %rcx
0000000100009a82	jae	0x100009b94
0000000100009a88	movq	0xb5f1(%rip), %rdx
0000000100009a8f	movq	%rcx, %rsi
0000000100009a92	shrq	$0x10, %rsi
0000000100009a96	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100009a9d	leaq	(%rdx,%rsi), %rbx
0000000100009aa1	movzbl	(%rdx,%rsi), %edx
0000000100009aa5	cmpb	$0x2, %dl
0000000100009aa8	setne	%sil
0000000100009aac	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009ab3	setne	%dil
0000000100009ab7	orb	%sil, %dil
0000000100009aba	jne	0x100009b5e
0000000100009ac0	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009ac7	cmpb	$-0x1, (%rbx)
0000000100009aca	je	0x100009b81
0000000100009ad0	movb	$0x1, (%rbx)
0000000100009ad3	jmp	0x100009b94
0000000100009ad8	movl	$0x10, %edi
0000000100009add	callq	_fwp_alloc_init
0000000100009ae2	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
0000000100009aec	movq	%rcx, (%rax)
0000000100009aef	movq	%r14, 0x8(%rax)
0000000100009af3	movq	%rax, %rcx
0000000100009af6	subq	0xb53b(%rip), %rcx
0000000100009afd	movq	0xb55c(%rip), %rdx
0000000100009b04	shlq	$0x10, %rdx
0000000100009b08	cmpq	%rdx, %rcx
0000000100009b0b	jae	0x100009baf
0000000100009b11	movq	0xb568(%rip), %rdx
0000000100009b18	movq	%rcx, %rsi
0000000100009b1b	shrq	$0x10, %rsi
0000000100009b1f	imulq	$0x1228, %rsi, %rsi             ## imm = 0x1228
0000000100009b26	leaq	(%rdx,%rsi), %rbx
0000000100009b2a	movzbl	(%rdx,%rsi), %edx
0000000100009b2e	cmpb	$0x2, %dl
0000000100009b31	setne	%sil
0000000100009b35	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009b3c	setne	%dil
0000000100009b40	orb	%sil, %dil
0000000100009b43	jne	0x100009bd5
0000000100009b49	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009b50	cmpb	$-0x1, (%rbx)
0000000100009b53	je	0x100009bf8
0000000100009b59	movb	$0x1, (%rbx)
0000000100009b5c	jmp	0x100009baf
0000000100009b5e	cmpb	$0x1, %dl
0000000100009b61	jne	0x100009b94
0000000100009b63	movl	0x20(%rbx), %edx
0000000100009b66	imulq	%rdx, %rcx
0000000100009b6a	shrq	$0x20, %rcx
0000000100009b6e	addq	%rcx, %rbx
0000000100009b71	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009b78	cmpb	$-0x1, (%rbx)
0000000100009b7b	jne	0x100009ad0
0000000100009b81	movq	%rbx, %rdi
0000000100009b84	movq	%rax, %r15
0000000100009b87	callq	_fwp_rc_forget_slot
0000000100009b8c	movq	%r15, %rax
0000000100009b8f	jmp	0x100009ad0
0000000100009b94	cmpq	%r14, _fwp_cleanups(%rip)
0000000100009b9b	jne	0x100009c46
0000000100009ba1	movq	-0x90(%rbp), %rcx
0000000100009ba8	movq	%rcx, _fwp_cleanups(%rip)
0000000100009baf	movq	0x947a(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
0000000100009bb6	movq	(%rcx), %rcx
0000000100009bb9	cmpq	-0x30(%rbp), %rcx
0000000100009bbd	jne	0x100009c4b
0000000100009bc3	addq	$0x128, %rsp                    ## imm = 0x128
0000000100009bca	popq	%rbx
0000000100009bcb	popq	%r12
0000000100009bcd	popq	%r13
0000000100009bcf	popq	%r14
0000000100009bd1	popq	%r15
0000000100009bd3	popq	%rbp
0000000100009bd4	retq
0000000100009bd5	cmpb	$0x1, %dl
0000000100009bd8	jne	0x100009baf
0000000100009bda	movl	0x20(%rbx), %edx
0000000100009bdd	imulq	%rdx, %rcx
0000000100009be1	shrq	$0x20, %rcx
0000000100009be5	addq	%rcx, %rbx
0000000100009be8	addq	$0x228, %rbx                    ## imm = 0x228
0000000100009bef	cmpb	$-0x1, (%rbx)
0000000100009bf2	jne	0x100009b59
0000000100009bf8	movq	%rbx, %rdi
0000000100009bfb	movq	%rax, %r14
0000000100009bfe	callq	_fwp_rc_forget_slot
0000000100009c03	movq	%r14, %rax
0000000100009c06	jmp	0x100009b59
0000000100009c0b	callq	_fwp_rc_wide_dup
0000000100009c10	movq	_fwp_cleanups(%rip), %rax
0000000100009c17	movq	0x10(%rbx), %r15
0000000100009c1b	movq	%r15, -0xb0(%rbp)
0000000100009c22	cmpq	%r14, %rax
0000000100009c25	je	0x1000096c7
0000000100009c2b	jmp	0x100009c46
0000000100009c2d	callq	_fwp_rc_wide_dup
0000000100009c32	leaq	-0xc8(%rbp), %rax
0000000100009c39	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009c40	je	0x100009834
0000000100009c46	callq	0x10001145a                     ## symbol stub for: _abort
0000000100009c4b	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100009c50	leaq	0x7fff(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100009c57	leaq	0x8025(%rip), %rcx              ## literal pool for: "I8"
0000000100009c5e	leaq	-0x90(%rbp), %rbx
0000000100009c65	movl	$0x60, %esi
0000000100009c6a	movq	%rbx, %rdi
0000000100009c6d	xorl	%eax, %eax
0000000100009c6f	callq	0x10001153e                     ## symbol stub for: _snprintf
0000000100009c74	callq	_fwp_flush
0000000100009c79	movq	0x93b8(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100009c80	movq	(%rax), %rdi
0000000100009c83	leaq	0x7fb5(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100009c8a	movq	%rbx, %rdx
0000000100009c8d	xorl	%eax, %eax
0000000100009c8f	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100009c94	movl	$0x65, %edi
0000000100009c99	callq	0x100011478                     ## symbol stub for: _exit
0000000100009c9e	nop
_fwp_owner_release25:
0000000100009ca0	pushq	%rbp
0000000100009ca1	movq	%rsp, %rbp
0000000100009ca4	movq	(%rdi), %rdi
0000000100009ca7	popq	%rbp
0000000100009ca8	jmp	_fwp_drop9
0000000100009cad	nopl	(%rax)
_fwp_owner_release26:
0000000100009cb0	pushq	%rbp
0000000100009cb1	movq	%rsp, %rbp
0000000100009cb4	movq	(%rdi), %rdi
0000000100009cb7	popq	%rbp
0000000100009cb8	jmp	_fwp_drop0
0000000100009cbd	nopl	(%rax)
_fwp_drop9:
0000000100009cc0	movq	%rdi, %rcx
0000000100009cc3	subq	0xb36e(%rip), %rcx
0000000100009cca	movq	0xb38f(%rip), %rax
0000000100009cd1	shlq	$0x10, %rax
0000000100009cd5	cmpq	%rax, %rcx
0000000100009cd8	jae	0x100009d6e
0000000100009cde	movq	0xb39b(%rip), %rdx
0000000100009ce5	movq	%rcx, %rax
0000000100009ce8	shrq	$0x10, %rax
0000000100009cec	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009cf3	leaq	(%rdx,%rsi), %rax
0000000100009cf7	movzbl	(%rdx,%rsi), %edx
0000000100009cfb	cmpb	$0x2, %dl
0000000100009cfe	setne	%sil
0000000100009d02	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009d09	setne	%r8b
0000000100009d0d	orb	%sil, %r8b
0000000100009d10	jne	0x100009d1a
0000000100009d12	addq	$0x228, %rax                    ## imm = 0x228
0000000100009d18	jmp	0x100009d33
0000000100009d1a	cmpb	$0x1, %dl
0000000100009d1d	jne	0x100009d6e
0000000100009d1f	movl	0x20(%rax), %edx
0000000100009d22	imulq	%rdx, %rcx
0000000100009d26	shrq	$0x20, %rcx
0000000100009d2a	addq	%rcx, %rax
0000000100009d2d	addq	$0x228, %rax                    ## imm = 0x228
0000000100009d33	movzbl	(%rax), %ecx
0000000100009d36	testl	%ecx, %ecx
0000000100009d38	je	0x100009d6e
0000000100009d3a	cmpl	$0x1, %ecx
0000000100009d3d	jne	0x100009d62
0000000100009d3f	pushq	%rbp
0000000100009d40	movq	%rsp, %rbp
0000000100009d43	pushq	%rbx
0000000100009d44	pushq	%rax
0000000100009d45	movq	0x10(%rdi), %rax
0000000100009d49	movq	%rdi, %rbx
0000000100009d4c	movq	%rax, %rdi
0000000100009d4f	callq	_fwp_drop0
0000000100009d54	movq	%rbx, %rdi
0000000100009d57	addq	$0x8, %rsp
0000000100009d5b	popq	%rbx
0000000100009d5c	popq	%rbp
0000000100009d5d	jmp	_fwp_rc_free_obj
0000000100009d62	cmpl	$0xff, %ecx
0000000100009d68	je	0x100009d6f
0000000100009d6a	decb	%cl
0000000100009d6c	movb	%cl, (%rax)
0000000100009d6e	retq
0000000100009d6f	movq	%rax, %rdi
0000000100009d72	jmp	_fwp_rc_wide_drop
0000000100009d77	nopw	(%rax,%rax)
_fwp_owner_release21:
0000000100009d80	pushq	%rbp
0000000100009d81	movq	%rsp, %rbp
0000000100009d84	movq	(%rdi), %rdi
0000000100009d87	popq	%rbp
0000000100009d88	jmp	_fwp_drop0
0000000100009d8d	nopl	(%rax)
_fwp_owner_release22:
0000000100009d90	pushq	%rbp
0000000100009d91	movq	%rsp, %rbp
0000000100009d94	movq	(%rdi), %rdi
0000000100009d97	popq	%rbp
0000000100009d98	jmp	_fwp_drop0
0000000100009d9d	nopl	(%rax)
_fwp_owner_release23:
0000000100009da0	pushq	%rbp
0000000100009da1	movq	%rsp, %rbp
0000000100009da4	movq	(%rdi), %rdi
0000000100009da7	popq	%rbp
0000000100009da8	jmp	_fwp_drop0
0000000100009dad	nopl	(%rax)
_fwp_owner_release24:
0000000100009db0	pushq	%rbp
0000000100009db1	movq	%rsp, %rbp
0000000100009db4	movq	(%rdi), %rdi
0000000100009db7	popq	%rbp
0000000100009db8	jmp	_fwp_drop0
0000000100009dbd	nopl	(%rax)
_fwp_owner_release27:
0000000100009dc0	pushq	%rbp
0000000100009dc1	movq	%rsp, %rbp
0000000100009dc4	movq	(%rdi), %rdi
0000000100009dc7	popq	%rbp
0000000100009dc8	jmp	_fwp_drop9
0000000100009dcd	nopl	(%rax)
_fwp_owned_entry37:
0000000100009dd0	pushq	%rbp
0000000100009dd1	movq	%rsp, %rbp
0000000100009dd4	movq	(%rdi), %rdi
0000000100009dd7	popq	%rbp
0000000100009dd8	jmp	_f37
0000000100009ddd	nopl	(%rax)
_fwp_caps37:
0000000100009de0	movl	0x4(%rdi), %eax
0000000100009de3	testl	%esi, %esi
0000000100009de5	je	0x100009e49
0000000100009de7	testl	%eax, %eax
0000000100009de9	je	0x100009ea1
0000000100009def	movq	0x8(%rdi), %rax
0000000100009df3	subq	0xb23e(%rip), %rax
0000000100009dfa	movq	0xb25f(%rip), %rcx
0000000100009e01	shlq	$0x10, %rcx
0000000100009e05	cmpq	%rcx, %rax
0000000100009e08	jae	0x100009ea1
0000000100009e0e	movq	0xb26b(%rip), %rcx
0000000100009e15	movq	%rax, %rdx
0000000100009e18	shrq	$0x10, %rdx
0000000100009e1c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009e23	leaq	(%rcx,%rdx), %rdi
0000000100009e27	movzbl	(%rcx,%rdx), %ecx
0000000100009e2b	cmpb	$0x2, %cl
0000000100009e2e	setne	%dl
0000000100009e31	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009e37	setne	%sil
0000000100009e3b	orb	%dl, %sil
0000000100009e3e	jne	0x100009e74
0000000100009e40	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009e47	jmp	0x100009e8e
0000000100009e49	testl	%eax, %eax
0000000100009e4b	je	_fwp_rc_free_obj
0000000100009e51	pushq	%rbp
0000000100009e52	movq	%rsp, %rbp
0000000100009e55	pushq	%rbx
0000000100009e56	pushq	%rax
0000000100009e57	movq	0x8(%rdi), %rax
0000000100009e5b	movq	%rdi, %rbx
0000000100009e5e	movq	%rax, %rdi
0000000100009e61	callq	_fwp_drop9
0000000100009e66	movq	%rbx, %rdi
0000000100009e69	addq	$0x8, %rsp
0000000100009e6d	popq	%rbx
0000000100009e6e	popq	%rbp
0000000100009e6f	jmp	_fwp_rc_free_obj
0000000100009e74	cmpb	$0x1, %cl
0000000100009e77	jne	0x100009ea1
0000000100009e79	movl	0x20(%rdi), %ecx
0000000100009e7c	imulq	%rcx, %rax
0000000100009e80	shrq	$0x20, %rax
0000000100009e84	addq	%rax, %rdi
0000000100009e87	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009e8e	movzbl	(%rdi), %eax
0000000100009e91	testb	%al, %al
0000000100009e93	je	0x100009ea1
0000000100009e95	cmpb	$-0x2, %al
0000000100009e97	jae	_fwp_rc_wide_dup
0000000100009e9d	incb	%al
0000000100009e9f	movb	%al, (%rdi)
0000000100009ea1	retq
0000000100009ea2	nopw	%cs:(%rax,%rax)
_fwp_args37:
0000000100009eb0	pushq	%rbp
0000000100009eb1	movq	%rsp, %rbp
0000000100009eb4	testl	%esi, %esi
0000000100009eb6	setne	%al
0000000100009eb9	testl	%edx, %edx
0000000100009ebb	sete	%cl
0000000100009ebe	orb	%al, %cl
0000000100009ec0	jne	0x100009f40
0000000100009ec2	movq	(%rdi), %rax
0000000100009ec5	subq	0xb16c(%rip), %rax
0000000100009ecc	movq	0xb18d(%rip), %rcx
0000000100009ed3	shlq	$0x10, %rcx
0000000100009ed7	cmpq	%rcx, %rax
0000000100009eda	jae	0x100009f40
0000000100009edc	movq	0xb19d(%rip), %rcx
0000000100009ee3	movq	%rax, %rdx
0000000100009ee6	shrq	$0x10, %rdx
0000000100009eea	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009ef1	leaq	(%rcx,%rdx), %rdi
0000000100009ef5	movzbl	(%rcx,%rdx), %ecx
0000000100009ef9	cmpb	$0x2, %cl
0000000100009efc	setne	%dl
0000000100009eff	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009f05	setne	%sil
0000000100009f09	orb	%dl, %sil
0000000100009f0c	jne	0x100009f17
0000000100009f0e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009f15	jmp	0x100009f31
0000000100009f17	cmpb	$0x1, %cl
0000000100009f1a	jne	0x100009f40
0000000100009f1c	movl	0x20(%rdi), %ecx
0000000100009f1f	imulq	%rcx, %rax
0000000100009f23	shrq	$0x20, %rax
0000000100009f27	addq	%rax, %rdi
0000000100009f2a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009f31	movzbl	(%rdi), %eax
0000000100009f34	testb	%al, %al
0000000100009f36	je	0x100009f40
0000000100009f38	cmpb	$-0x2, %al
0000000100009f3a	jae	0x100009f42
0000000100009f3c	incb	%al
0000000100009f3e	movb	%al, (%rdi)
0000000100009f40	popq	%rbp
0000000100009f41	retq
0000000100009f42	popq	%rbp
0000000100009f43	jmp	_fwp_rc_wide_dup
0000000100009f48	nopl	(%rax,%rax)
_fwp_arg_drop37:
0000000100009f50	pushq	%rbp
0000000100009f51	movq	%rsp, %rbp
0000000100009f54	testl	%esi, %esi
0000000100009f56	setne	%al
0000000100009f59	testl	%edx, %edx
0000000100009f5b	sete	%cl
0000000100009f5e	orb	%al, %cl
0000000100009f60	je	0x100009f64
0000000100009f62	popq	%rbp
0000000100009f63	retq
0000000100009f64	movq	(%rdi), %rdi
0000000100009f67	popq	%rbp
0000000100009f68	jmp	_fwp_drop9
0000000100009f6d	nopl	(%rax)
_fwp_drop10:
0000000100009f70	movq	%rdi, %rcx
0000000100009f73	subq	0xb0be(%rip), %rcx
0000000100009f7a	movq	0xb0df(%rip), %rax
0000000100009f81	shlq	$0x10, %rax
0000000100009f85	cmpq	%rax, %rcx
0000000100009f88	jae	0x10000a02d
0000000100009f8e	movq	0xb0eb(%rip), %rdx
0000000100009f95	movq	%rcx, %rax
0000000100009f98	shrq	$0x10, %rax
0000000100009f9c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009fa3	leaq	(%rdx,%rsi), %rax
0000000100009fa7	movzbl	(%rdx,%rsi), %edx
0000000100009fab	cmpb	$0x2, %dl
0000000100009fae	setne	%sil
0000000100009fb2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009fb9	setne	%r8b
0000000100009fbd	orb	%sil, %r8b
0000000100009fc0	jne	0x100009fca
0000000100009fc2	addq	$0x228, %rax                    ## imm = 0x228
0000000100009fc8	jmp	0x100009fe3
0000000100009fca	cmpb	$0x1, %dl
0000000100009fcd	jne	0x10000a02d
0000000100009fcf	movl	0x20(%rax), %edx
0000000100009fd2	imulq	%rdx, %rcx
0000000100009fd6	shrq	$0x20, %rcx
0000000100009fda	addq	%rcx, %rax
0000000100009fdd	addq	$0x228, %rax                    ## imm = 0x228
0000000100009fe3	movzbl	(%rax), %ecx
0000000100009fe6	testl	%ecx, %ecx
0000000100009fe8	je	0x10000a02d
0000000100009fea	cmpl	$0x1, %ecx
0000000100009fed	jne	0x10000a021
0000000100009fef	movl	(%rdi), %eax
0000000100009ff1	cmpl	$0x1, %eax
0000000100009ff4	je	_fwp_rc_free_obj
0000000100009ffa	testl	%eax, %eax
0000000100009ffc	jne	0x10000a02d
0000000100009ffe	pushq	%rbp
0000000100009fff	movq	%rsp, %rbp
000000010000a002	pushq	%rbx
000000010000a003	pushq	%rax
000000010000a004	movq	0x8(%rdi), %rax
000000010000a008	movq	%rdi, %rbx
000000010000a00b	movq	%rax, %rdi
000000010000a00e	callq	_fwp_drop9
000000010000a013	movq	%rbx, %rdi
000000010000a016	addq	$0x8, %rsp
000000010000a01a	popq	%rbx
000000010000a01b	popq	%rbp
000000010000a01c	jmp	_fwp_rc_free_obj
000000010000a021	cmpl	$0xff, %ecx
000000010000a027	je	0x10000a02e
000000010000a029	decb	%cl
000000010000a02b	movb	%cl, (%rax)
000000010000a02d	retq
000000010000a02e	movq	%rax, %rdi
000000010000a031	jmp	_fwp_rc_wide_drop
000000010000a036	nopw	%cs:(%rax,%rax)
_fwp_segv:
000000010000a040	movq	_fwp_main_stack_top(%rip), %rax
000000010000a047	testq	%rax, %rax
000000010000a04a	je	0x10000a074
000000010000a04c	movq	0x18(%rsi), %rcx
000000010000a050	subq	_fwp_main_stack_size(%rip), %rax
000000010000a057	leaq	-0x100000(%rax), %rdx
000000010000a05e	addq	$0x100000, %rax                 ## imm = 0x100000
000000010000a064	cmpq	%rcx, %rdx
000000010000a067	setbe	%dl
000000010000a06a	cmpq	%rcx, %rax
000000010000a06d	seta	%al
000000010000a070	testb	%al, %dl
000000010000a072	jne	0x10000a07b
000000010000a074	xorl	%esi, %esi
000000010000a076	jmp	0x100011538                     ## symbol stub for: _signal
000000010000a07b	pushq	%rbp
000000010000a07c	movq	%rsp, %rbp
000000010000a07f	callq	_fwp_flush
000000010000a084	leaq	_fwp_segv.msg(%rip), %rsi
000000010000a08b	movl	$0x1a, %edx
000000010000a090	movl	$0x2, %edi
000000010000a095	callq	0x10001158c                     ## symbol stub for: _write
000000010000a09a	movl	$0x65, %edi
000000010000a09f	callq	0x100011454                     ## symbol stub for: __exit
000000010000a0a4	nopw	%cs:(%rax,%rax)
_fwp_str_lossy:
000000010000a0b0	pushq	%rbp
000000010000a0b1	movq	%rsp, %rbp
000000010000a0b4	pushq	%r15
000000010000a0b6	pushq	%r14
000000010000a0b8	pushq	%r13
000000010000a0ba	pushq	%r12
000000010000a0bc	pushq	%rbx
000000010000a0bd	subq	$0x28, %rsp
000000010000a0c1	movq	%rsi, %rbx
000000010000a0c4	movq	%rdi, %r14
000000010000a0c7	testq	%rsi, %rsi
000000010000a0ca	je	0x10000a201
000000010000a0d0	xorl	%eax, %eax
000000010000a0d2	jmp	0x10000a0ec
000000010000a0d4	nopw	%cs:(%rax,%rax)
000000010000a0e0	incq	%rax
000000010000a0e3	cmpq	%rbx, %rax
000000010000a0e6	jae	0x10000a201
000000010000a0ec	movzbl	(%r14,%rax), %edi
000000010000a0f1	testb	%dil, %dil
000000010000a0f4	jns	0x10000a0e0
000000010000a0f6	leal	0x3e(%rdi), %ecx
000000010000a0f9	cmpb	$0x1e, %cl
000000010000a0fc	jae	0x10000a10f
000000010000a0fe	movl	$0x80, %ecx
000000010000a103	movl	$0x1, %esi
000000010000a108	movl	$0x1f, %edx
000000010000a10d	jmp	0x10000a145
000000010000a10f	movl	%edi, %ecx
000000010000a111	andb	$-0x10, %cl
000000010000a114	cmpb	$-0x20, %cl
000000010000a117	jne	0x10000a12a
000000010000a119	movl	$0x800, %ecx                    ## imm = 0x800
000000010000a11e	movl	$0x2, %esi
000000010000a123	movl	$0xf, %edx
000000010000a128	jmp	0x10000a145
000000010000a12a	leal	0x10(%rdi), %ecx
000000010000a12d	cmpb	$0x4, %cl
000000010000a130	ja	0x10000a21a
000000010000a136	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000a13b	movl	$0x3, %esi
000000010000a140	movl	$0x7, %edx
000000010000a145	movl	%esi, %esi
000000010000a147	leaq	(%rax,%rsi), %r8
000000010000a14b	cmpq	%rbx, %r8
000000010000a14e	jae	0x10000a21a
000000010000a154	movzbl	0x1(%r14,%rax), %r8d
000000010000a15a	movl	%r8d, %r9d
000000010000a15d	andl	$-0x40, %r9d
000000010000a161	cmpl	$0x80, %r9d
000000010000a168	jne	0x10000a21a
000000010000a16e	andl	%edi, %edx
000000010000a170	leal	0x1(%rsi), %r9d
000000010000a174	movl	%edx, %edi
000000010000a176	shll	$0x6, %edi
000000010000a179	andl	$0x3f, %r8d
000000010000a17d	orl	%edi, %r8d
000000010000a180	cmpl	$0x2, %r9d
000000010000a184	jne	0x10000a18b
000000010000a186	movl	%r8d, %r9d
000000010000a189	jmp	0x10000a1d7
000000010000a18b	movzbl	0x2(%r14,%rax), %edx
000000010000a191	movl	%edx, %edi
000000010000a193	andl	$-0x40, %edi
000000010000a196	cmpl	$0x80, %edi
000000010000a19c	jne	0x10000a21a
000000010000a19e	movl	%r8d, %edi
000000010000a1a1	shll	$0x6, %edi
000000010000a1a4	andl	$0x3f, %edx
000000010000a1a7	orl	%edi, %edx
000000010000a1a9	cmpl	$0x3, %r9d
000000010000a1ad	jne	0x10000a1b7
000000010000a1af	movl	%edx, %r9d
000000010000a1b2	movl	%r8d, %edx
000000010000a1b5	jmp	0x10000a1d7
000000010000a1b7	movzbl	0x3(%r14,%rax), %r9d
000000010000a1bd	movl	%r9d, %edi
000000010000a1c0	andl	$-0x40, %edi
000000010000a1c3	cmpl	$0x80, %edi
000000010000a1c9	jne	0x10000a21a
000000010000a1cb	movl	%edx, %edi
000000010000a1cd	shll	$0x6, %edi
000000010000a1d0	andl	$0x3f, %r9d
000000010000a1d4	orl	%edi, %r9d
000000010000a1d7	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000a1dd	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000a1e3	je	0x10000a21a
000000010000a1e5	cmpl	$0x10ffff, %edi                 ## imm = 0x10FFFF
000000010000a1eb	ja	0x10000a21a
000000010000a1ed	cmpl	%ecx, %r9d
000000010000a1f0	jb	0x10000a21a
000000010000a1f2	addq	%rsi, %rax
000000010000a1f5	incq	%rax
000000010000a1f8	cmpq	%rbx, %rax
000000010000a1fb	jb	0x10000a0ec
000000010000a201	movq	%r14, %rdi
000000010000a204	movq	%rbx, %rsi
000000010000a207	addq	$0x28, %rsp
000000010000a20b	popq	%rbx
000000010000a20c	popq	%r12
000000010000a20e	popq	%r13
000000010000a210	popq	%r14
000000010000a212	popq	%r15
000000010000a214	popq	%rbp
000000010000a215	jmp	_fwp_str_new
000000010000a21a	xorps	%xmm0, %xmm0
000000010000a21d	movaps	%xmm0, -0x50(%rbp)
000000010000a221	movq	$0x0, -0x40(%rbp)
000000010000a229	xorl	%r13d, %r13d
000000010000a22c	leaq	-0x50(%rbp), %r15
000000010000a230	jmp	0x10000a266
000000010000a232	nopw	%cs:(%rax,%rax)
000000010000a240	movb	%al, -0x29(%rbp)
000000010000a243	movl	$0x1, %edx
000000010000a248	movq	%r15, %rdi
000000010000a24b	leaq	-0x29(%rbp), %rsi
000000010000a24f	callq	_buf_put
000000010000a254	incq	%r13
000000010000a257	movq	%r13, %r12
000000010000a25a	movq	%r12, %r13
000000010000a25d	cmpq	%rbx, %r12
000000010000a260	jae	0x10000a3ad
000000010000a266	movzbl	(%r14,%r13), %eax
000000010000a26b	testb	%al, %al
000000010000a26d	jns	0x10000a240
000000010000a26f	leal	0x20(%rax), %ecx
000000010000a272	cmpb	$-0x1f, %cl
000000010000a275	ja	0x10000a2ab
000000010000a277	movl	%eax, %edx
000000010000a279	andb	$-0x10, %dl
000000010000a27c	cmpb	$-0x20, %dl
000000010000a27f	jne	0x10000a369
000000010000a285	cmpb	$-0x20, %al
000000010000a287	sete	%sil
000000010000a28b	shlb	$0x5, %sil
000000010000a28f	orb	$-0x80, %sil
000000010000a293	xorl	%edi, %edi
000000010000a295	cmpb	$-0x13, %al
000000010000a297	setne	%dil
000000010000a29b	shll	$0x5, %edi
000000010000a29e	orl	$0x9f, %edi
000000010000a2a4	movl	$0x2, %eax
000000010000a2a9	jmp	0x10000a2b8
000000010000a2ab	movl	$0xbf, %edi
000000010000a2b0	movb	$-0x80, %sil
000000010000a2b3	movl	$0x1, %eax
000000010000a2b8	xorl	%edx, %edx
000000010000a2ba	leaq	0x1(%r13), %r12
000000010000a2be	cmpq	%rbx, %r12
000000010000a2c1	jae	0x10000a350
000000010000a2c7	movzbl	(%r14,%r12), %r8d
000000010000a2cc	cmpb	%sil, %r8b
000000010000a2cf	jb	0x10000a350
000000010000a2d1	cmpl	%r8d, %edi
000000010000a2d4	jb	0x10000a350
000000010000a2d6	cmpb	$-0x1e, %cl
000000010000a2d9	setae	%sil
000000010000a2dd	leaq	0x2(%r13), %r12
000000010000a2e1	cmpq	%rbx, %r12
000000010000a2e4	setae	%dil
000000010000a2e8	movl	$0x1, %ecx
000000010000a2ed	orb	%sil, %dil
000000010000a2f0	jne	0x10000a339
000000010000a2f2	movzbl	(%r14,%r12), %esi
000000010000a2f7	andb	$-0x40, %sil
000000010000a2fb	negb	%sil
000000010000a2fe	jno	0x10000a339
000000010000a300	leaq	0x3(%r13), %r12
000000010000a304	cmpq	%rbx, %r12
000000010000a307	setae	%sil
000000010000a30b	xorb	$0x1, %dl
000000010000a30e	movl	$0x2, %ecx
000000010000a313	orb	%sil, %dl
000000010000a316	jne	0x10000a339
000000010000a318	movzbl	0x3(%r14,%r13), %esi
000000010000a31e	andb	$-0x40, %sil
000000010000a322	xorl	%ecx, %ecx
000000010000a324	cmpb	$-0x80, %sil
000000010000a328	sete	%dl
000000010000a32b	negb	%sil
000000010000a32e	jno	0x10000a334
000000010000a330	leaq	0x4(%r13), %r12
000000010000a334	movb	%dl, %cl
000000010000a336	orl	$0x2, %ecx
000000010000a339	cmpl	%eax, %ecx
000000010000a33b	jne	0x10000a350
000000010000a33d	leaq	(%r14,%r13), %rsi
000000010000a341	movq	%r12, %rdx
000000010000a344	subq	%r13, %rdx
000000010000a347	movq	%r15, %rdi
000000010000a34a	jmp	0x10000a35f
000000010000a34c	nopl	(%rax)
000000010000a350	movl	$0x3, %edx
000000010000a355	movq	%r15, %rdi
000000010000a358	leaq	0x84b8(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a35f	callq	_buf_put
000000010000a364	jmp	0x10000a25a
000000010000a369	leal	0x10(%rax), %edx
000000010000a36c	cmpb	$0x4, %dl
000000010000a36f	ja	0x10000a399
000000010000a371	cmpb	$-0x10, %al
000000010000a373	sete	%sil
000000010000a377	movl	$0x8f, %edi
000000010000a37c	cmpb	$-0xc, %al
000000010000a37e	je	0x10000a385
000000010000a380	movl	$0xbf, %edi
000000010000a385	shlb	$0x4, %sil
000000010000a389	orb	$-0x80, %sil
000000010000a38d	movl	$0x3, %eax
000000010000a392	movb	$0x1, %dl
000000010000a394	jmp	0x10000a2ba
000000010000a399	movl	$0x3, %edx
000000010000a39e	movq	%r15, %rdi
000000010000a3a1	leaq	0x846f(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a3a8	jmp	0x10000a24f
000000010000a3ad	movq	-0x50(%rbp), %rbx
000000010000a3b1	movq	-0x48(%rbp), %rsi
000000010000a3b5	testq	%rbx, %rbx
000000010000a3b8	leaq	0x77a3(%rip), %rdi              ## literal pool for: ""
000000010000a3bf	cmovneq	%rbx, %rdi
000000010000a3c3	callq	_fwp_str_new
000000010000a3c8	movq	%rax, %r14
000000010000a3cb	movq	%rbx, %rdi
000000010000a3ce	callq	0x1000114a2                     ## symbol stub for: _free
000000010000a3d3	movq	%r14, %rax
000000010000a3d6	addq	$0x28, %rsp
000000010000a3da	popq	%rbx
000000010000a3db	popq	%r12
000000010000a3dd	popq	%r13
000000010000a3df	popq	%r14
000000010000a3e1	popq	%r15
000000010000a3e3	popq	%rbp
000000010000a3e4	retq
000000010000a3e5	nopw	%cs:(%rax,%rax)
_fwp_alloc_leaf:
000000010000a3f0	pushq	%rbp
000000010000a3f1	movq	%rsp, %rbp
000000010000a3f4	pushq	%rbx
000000010000a3f5	pushq	%rax
000000010000a3f6	movq	%rdi, %rsi
000000010000a3f9	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000a400	ja	0x10000a45b
000000010000a402	leaq	0xf(%rsi), %rax
000000010000a406	shrq	$0x4, %rax
000000010000a40a	leaq	_fwp_gc(%rip), %rcx
000000010000a411	movzbl	0xbe8(%rax,%rcx), %edx
000000010000a419	movl	0xb48(%rcx,%rdx,4), %eax
000000010000a420	subq	%rax, _fwp_gc(%rip)
000000010000a427	js	0x10000a45b
000000010000a429	leaq	(%rdx,%rdx,2), %rdx
000000010000a42d	leaq	(%rcx,%rdx,8), %rcx
000000010000a431	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000a438	movq	(%rcx), %rbx
000000010000a43b	testq	%rbx, %rbx
000000010000a43e	je	0x10000a44b
000000010000a440	movq	(%rbx), %rax
000000010000a443	notq	%rax
000000010000a446	movq	%rax, (%rcx)
000000010000a449	jmp	0x10000a475
000000010000a44b	movq	0x8(%rcx), %rbx
000000010000a44f	movq	0x10(%rcx), %rdx
000000010000a453	subq	%rbx, %rdx
000000010000a456	cmpq	%rax, %rdx
000000010000a459	jae	0x10000a46e
000000010000a45b	movq	%rsi, %rdi
000000010000a45e	movl	$0x1, %esi
000000010000a463	addq	$0x8, %rsp
000000010000a467	popq	%rbx
000000010000a468	popq	%rbp
000000010000a469	jmp	_fwp_gc_alloc_slow
000000010000a46e	addq	%rbx, %rax
000000010000a471	movq	%rax, 0x8(%rcx)
000000010000a475	movq	%rbx, %rdi
000000010000a478	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000a47d	movq	%rbx, %rax
000000010000a480	addq	$0x8, %rsp
000000010000a484	popq	%rbx
000000010000a485	popq	%rbp
000000010000a486	retq
000000010000a487	nopw	(%rax,%rax)
_fwp_exec_call:
000000010000a490	pushq	%rbp
000000010000a491	movq	%rsp, %rbp
000000010000a494	pushq	%r15
000000010000a496	pushq	%r14
000000010000a498	pushq	%r13
000000010000a49a	pushq	%r12
000000010000a49c	pushq	%rbx
000000010000a49d	subq	$0xd8, %rsp
000000010000a4a4	movq	%rsi, %rbx
000000010000a4a7	movq	%rdi, %r14
000000010000a4aa	movq	_fwp_handlers(%rip), %rax
000000010000a4b1	movq	%rax, -0x68(%rbp)
000000010000a4b5	movq	$0x0, -0x50(%rbp)
000000010000a4bd	movq	_fwp_cleanups(%rip), %rax
000000010000a4c4	movq	%rax, -0x48(%rbp)
000000010000a4c8	leaq	-0x100(%rbp), %rdi
000000010000a4cf	movq	%rdi, _fwp_handlers(%rip)
000000010000a4d6	callq	0x100011520                     ## symbol stub for: _setjmp
000000010000a4db	testl	%eax, %eax
000000010000a4dd	je	0x10000a5cb
000000010000a4e3	movq	-0x68(%rbp), %rax
000000010000a4e7	movq	%rax, _fwp_handlers(%rip)
000000010000a4ee	movq	_fwp_prog_out(%rip), %rdi
000000010000a4f5	testq	%rdi, %rdi
000000010000a4f8	je	0x10000a4ff
000000010000a4fa	callq	0x10001147e                     ## symbol stub for: _fflush
000000010000a4ff	movq	0x8b42(%rip), %r12              ## literal pool symbol address: ___stdoutp
000000010000a506	movq	(%r12), %rdi
000000010000a50a	callq	0x10001147e                     ## symbol stub for: _fflush
000000010000a50f	movq	-0x60(%rbp), %r14
000000010000a513	movq	-0x58(%rbp), %r15
000000010000a517	movq	(%r12), %rdi
000000010000a51b	callq	0x10001147e                     ## symbol stub for: _fflush
000000010000a520	movq	0x8b11(%rip), %r13              ## literal pool symbol address: ___stderrp
000000010000a527	movq	(%r13), %rdi
000000010000a52b	leaq	0x8386(%rip), %rsi              ## literal pool for: "%s: "
000000010000a532	leaq	0x762d(%rip), %rdx              ## literal pool for: "reduce64"
000000010000a539	xorl	%eax, %eax
000000010000a53b	callq	0x10001148a                     ## symbol stub for: _fprintf
000000010000a540	cmpl	$0x10, (%r15)
000000010000a544	jne	0x10000a584
000000010000a546	movq	0x8(%r15), %rdi
000000010000a54a	testq	%rdi, %rdi
000000010000a54d	je	0x10000a584
000000010000a54f	leaq	0x8367(%rip), %rsi              ## literal pool for: "IoError"
000000010000a556	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000a55b	testl	%eax, %eax
000000010000a55d	jne	0x10000a584
000000010000a55f	cmpl	$0x2, 0x10(%r15)
000000010000a564	jne	0x10000a584
000000010000a566	movq	0x10(%r14), %rdi
000000010000a56a	movq	(%rdi), %rdx
000000010000a56d	addq	$0x8, %rdi
000000010000a571	movq	(%r13), %rcx
000000010000a575	movl	$0x1, %esi
000000010000a57a	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000a57f	jmp	0x10000a615
000000010000a584	movq	(%r13), %r12
000000010000a588	xorps	%xmm0, %xmm0
000000010000a58b	movaps	%xmm0, -0x40(%rbp)
000000010000a58f	movq	$0x0, -0x30(%rbp)
000000010000a597	leaq	-0x40(%rbp), %rdi
000000010000a59b	movq	%r14, %rsi
000000010000a59e	movq	%r15, %rdx
000000010000a5a1	movl	$0x1, %ecx
000000010000a5a6	callq	_fwp_write
000000010000a5ab	movq	-0x40(%rbp), %rdi
000000010000a5af	testq	%rdi, %rdi
000000010000a5b2	je	0x10000a60c
000000010000a5b4	movq	-0x38(%rbp), %rdx
000000010000a5b8	movl	$0x1, %esi
000000010000a5bd	movq	%r12, %rcx
000000010000a5c0	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000a5c5	movq	-0x40(%rbp), %rdi
000000010000a5c9	jmp	0x10000a610
000000010000a5cb	leaq	_fwp_gc(%rip), %rax
000000010000a5d2	movzbl	0xa618(%rip), %ecx
000000010000a5d9	movl	0xb48(%rax,%rcx,4), %edx
000000010000a5e0	movl	%edx, %esi
000000010000a5e2	subq	%rsi, _fwp_gc(%rip)
000000010000a5e9	js	0x10000a63c
000000010000a5eb	leaq	(%rcx,%rcx,2), %rcx
000000010000a5ef	leaq	(%rax,%rcx,8), %rax
000000010000a5f3	addq	$0x788, %rax                    ## imm = 0x788
000000010000a5f9	movq	(%rax), %r15
000000010000a5fc	testq	%r15, %r15
000000010000a5ff	je	0x10000a62c
000000010000a601	movq	(%r15), %rcx
000000010000a604	notq	%rcx
000000010000a607	movq	%rcx, (%rax)
000000010000a60a	jmp	0x10000a658
000000010000a60c	xorl	%eax, %eax
000000010000a60e	movl	%eax, %edi
000000010000a610	callq	0x1000114a2                     ## symbol stub for: _free
000000010000a615	movq	(%r13), %rsi
000000010000a619	movl	$0xa, %edi
000000010000a61e	callq	0x100011490                     ## symbol stub for: _fputc
000000010000a623	movl	$0x1, %ecx
000000010000a628	xorl	%eax, %eax
000000010000a62a	jmp	0x10000a684
000000010000a62c	movq	0x8(%rax), %r15
000000010000a630	movq	0x10(%rax), %rcx
000000010000a634	subq	%r15, %rcx
000000010000a637	cmpq	%rsi, %rcx
000000010000a63a	jae	0x10000a650
000000010000a63c	movl	$0x8, %edi
000000010000a641	movl	$0x2, %esi
000000010000a646	callq	_fwp_gc_alloc_slow
000000010000a64b	movq	%rax, %rdi
000000010000a64e	jmp	0x10000a663
000000010000a650	leaq	(%r15,%rsi), %rcx
000000010000a654	movq	%rcx, 0x8(%rax)
000000010000a658	movq	%r15, %rdi
000000010000a65b	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000a660	movq	%r15, %rdi
000000010000a663	movq	$0x0, (%rdi)
000000010000a66a	movl	$0x1, %esi
000000010000a66f	movq	%r14, %rdx
000000010000a672	callq	_fwp_apply
000000010000a677	movq	-0x68(%rbp), %rcx
000000010000a67b	movq	%rcx, _fwp_handlers(%rip)
000000010000a682	xorl	%ecx, %ecx
000000010000a684	movl	%ecx, (%rbx)
000000010000a686	addq	$0xd8, %rsp
000000010000a68d	popq	%rbx
000000010000a68e	popq	%r12
000000010000a690	popq	%r13
000000010000a692	popq	%r14
000000010000a694	popq	%r15
000000010000a696	popq	%rbp
000000010000a697	retq
000000010000a698	nopl	(%rax,%rax)
_fwp_emit_result:
000000010000a6a0	pushq	%rbp
000000010000a6a1	movq	%rsp, %rbp
000000010000a6a4	pushq	%r15
000000010000a6a6	pushq	%r14
000000010000a6a8	pushq	%rbx
000000010000a6a9	subq	$0x28, %rsp
000000010000a6ad	movq	%rdi, %rbx
000000010000a6b0	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000a6b7	je	0x10000a7dd
000000010000a6bd	xorps	%xmm0, %xmm0
000000010000a6c0	movaps	%xmm0, -0x40(%rbp)
000000010000a6c4	movq	$0x0, -0x30(%rbp)
000000010000a6cc	movb	%bl, -0x1d(%rbp)
000000010000a6cf	leaq	-0x40(%rbp), %r15
000000010000a6d3	leaq	-0x1d(%rbp), %r14
000000010000a6d7	movl	$0x1, %edx
000000010000a6dc	movq	%r15, %rdi
000000010000a6df	movq	%r14, %rsi
000000010000a6e2	callq	_buf_put
000000010000a6e7	movb	%bh, -0x1d(%rbp)
000000010000a6ea	movl	$0x1, %edx
000000010000a6ef	movq	%r15, %rdi
000000010000a6f2	movq	%r14, %rsi
000000010000a6f5	callq	_buf_put
000000010000a6fa	movl	%ebx, %eax
000000010000a6fc	shrl	$0x10, %eax
000000010000a6ff	movb	%al, -0x1d(%rbp)
000000010000a702	movl	$0x1, %edx
000000010000a707	movq	%r15, %rdi
000000010000a70a	movq	%r14, %rsi
000000010000a70d	callq	_buf_put
000000010000a712	movl	%ebx, %eax
000000010000a714	shrl	$0x18, %eax
000000010000a717	movb	%al, -0x1d(%rbp)
000000010000a71a	movl	$0x1, %edx
000000010000a71f	movq	%r15, %rdi
000000010000a722	movq	%r14, %rsi
000000010000a725	callq	_buf_put
000000010000a72a	movq	%rbx, %rax
000000010000a72d	shrq	$0x20, %rax
000000010000a731	movb	%al, -0x1d(%rbp)
000000010000a734	movl	$0x1, %edx
000000010000a739	movq	%r15, %rdi
000000010000a73c	movq	%r14, %rsi
000000010000a73f	callq	_buf_put
000000010000a744	movq	%rbx, %rax
000000010000a747	shrq	$0x28, %rax
000000010000a74b	movb	%al, -0x1d(%rbp)
000000010000a74e	movl	$0x1, %edx
000000010000a753	movq	%r15, %rdi
000000010000a756	movq	%r14, %rsi
000000010000a759	callq	_buf_put
000000010000a75e	movq	%rbx, %rax
000000010000a761	shrq	$0x30, %rax
000000010000a765	movb	%al, -0x1d(%rbp)
000000010000a768	movl	$0x1, %edx
000000010000a76d	movq	%r15, %rdi
000000010000a770	movq	%r14, %rsi
000000010000a773	callq	_buf_put
000000010000a778	shrq	$0x38, %rbx
000000010000a77c	movb	%bl, -0x1d(%rbp)
000000010000a77f	movl	$0x1, %edx
000000010000a784	movq	%r15, %rdi
000000010000a787	movq	%r14, %rsi
000000010000a78a	callq	_buf_put
000000010000a78f	movb	$0x1, -0x1d(%rbp)
000000010000a793	movq	-0x38(%rbp), %rbx
000000010000a797	movl	%ebx, -0x1c(%rbp)
000000010000a79a	movq	0x88a7(%rip), %r15              ## literal pool symbol address: ___stdoutp
000000010000a7a1	movq	(%r15), %rcx
000000010000a7a4	leaq	-0x1d(%rbp), %rdi
000000010000a7a8	movl	$0x1, %esi
000000010000a7ad	movl	$0x5, %edx
000000010000a7b2	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000a7b7	movq	-0x40(%rbp), %r14
000000010000a7bb	testq	%rbx, %rbx
000000010000a7be	je	0x10000a7d3
000000010000a7c0	movq	(%r15), %rcx
000000010000a7c3	movl	$0x1, %esi
000000010000a7c8	movq	%r14, %rdi
000000010000a7cb	movq	%rbx, %rdx
000000010000a7ce	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000a7d3	movq	%r14, %rdi
000000010000a7d6	callq	0x1000114a2                     ## symbol stub for: _free
000000010000a7db	jmp	0x10000a842
000000010000a7dd	movq	0x8864(%rip), %r15              ## literal pool symbol address: ___stdoutp
000000010000a7e4	movq	(%r15), %r14
000000010000a7e7	xorps	%xmm0, %xmm0
000000010000a7ea	movaps	%xmm0, -0x40(%rbp)
000000010000a7ee	movq	$0x0, -0x30(%rbp)
000000010000a7f6	leaq	_d0(%rip), %rdx
000000010000a7fd	leaq	-0x40(%rbp), %rdi
000000010000a801	movq	%rbx, %rsi
000000010000a804	movl	$0x1, %ecx
000000010000a809	callq	_fwp_write
000000010000a80e	movq	-0x40(%rbp), %rdi
000000010000a812	testq	%rdi, %rdi
000000010000a815	je	0x10000a82e
000000010000a817	movq	-0x38(%rbp), %rdx
000000010000a81b	movl	$0x1, %esi
000000010000a820	movq	%r14, %rcx
000000010000a823	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000a828	movq	-0x40(%rbp), %rdi
000000010000a82c	jmp	0x10000a830
000000010000a82e	xorl	%edi, %edi
000000010000a830	callq	0x1000114a2                     ## symbol stub for: _free
000000010000a835	movq	(%r15), %rsi
000000010000a838	movl	$0xa, %edi
000000010000a83d	callq	0x100011490                     ## symbol stub for: _fputc
000000010000a842	addq	$0x28, %rsp
000000010000a846	popq	%rbx
000000010000a847	popq	%r14
000000010000a849	popq	%r15
000000010000a84b	popq	%rbp
000000010000a84c	retq
000000010000a84d	nopl	(%rax)
_fwp_read_exact:
000000010000a850	pushq	%rbp
000000010000a851	movq	%rsp, %rbp
000000010000a854	pushq	%r15
000000010000a856	pushq	%r14
000000010000a858	pushq	%r12
000000010000a85a	pushq	%rbx
000000010000a85b	movq	%rsi, %rbx
000000010000a85e	movq	%rdi, %r14
000000010000a861	movl	_fwp_in_npend(%rip), %eax
000000010000a867	movl	_fwp_in_ppos(%rip), %ecx
000000010000a86d	testq	%rsi, %rsi
000000010000a870	setne	%dl
000000010000a873	cmpl	%eax, %ecx
000000010000a875	setl	%sil
000000010000a879	testb	%sil, %dl
000000010000a87c	je	0x10000a8ea
000000010000a87e	cltq
000000010000a880	movslq	%ecx, %rsi
000000010000a883	movq	%rsi, %rdx
000000010000a886	notq	%rdx
000000010000a889	addq	%rax, %rdx
000000010000a88c	leaq	-0x1(%rbx), %rcx
000000010000a890	cmpq	%rcx, %rdx
000000010000a893	cmovaeq	%rcx, %rdx
000000010000a897	incq	%rdx
000000010000a89a	cmpq	$0x1f, %rdx
000000010000a89e	jbe	0x10000a8b6
000000010000a8a0	leaq	_fwp_in_pend(%rip), %rdi
000000010000a8a7	movq	%r14, %r8
000000010000a8aa	subq	%rsi, %r8
000000010000a8ad	subq	%rdi, %r8
000000010000a8b0	cmpq	$0x20, %r8
000000010000a8b4	jae	0x10000a8ef
000000010000a8b6	xorl	%r15d, %r15d
000000010000a8b9	movq	%rsi, %rcx
000000010000a8bc	leaq	_fwp_in_pend(%rip), %rdx
000000010000a8c3	nopw	%cs:(%rax,%rax)
000000010000a8d0	movzbl	(%rcx,%rdx), %esi
000000010000a8d4	incq	%rcx
000000010000a8d7	movb	%sil, (%r14,%r15)
000000010000a8db	incq	%r15
000000010000a8de	cmpq	%rbx, %r15
000000010000a8e1	jae	0x10000a932
000000010000a8e3	cmpq	%rax, %rcx
000000010000a8e6	jl	0x10000a8d0
000000010000a8e8	jmp	0x10000a932
000000010000a8ea	xorl	%r15d, %r15d
000000010000a8ed	jmp	0x10000a938
000000010000a8ef	movq	%rdx, %r15
000000010000a8f2	andq	$-0x20, %r15
000000010000a8f6	leaq	(%r15,%rsi), %rcx
000000010000a8fa	addq	%rdi, %rsi
000000010000a8fd	addq	$0x10, %rsi
000000010000a901	xorl	%edi, %edi
000000010000a903	nopw	%cs:(%rax,%rax)
000000010000a910	movups	-0x10(%rsi,%rdi), %xmm0
000000010000a915	movups	(%rsi,%rdi), %xmm1
000000010000a919	movups	%xmm0, (%r14,%rdi)
000000010000a91e	movups	%xmm1, 0x10(%r14,%rdi)
000000010000a924	addq	$0x20, %rdi
000000010000a928	cmpq	%rdi, %r15
000000010000a92b	jne	0x10000a910
000000010000a92d	cmpq	%r15, %rdx
000000010000a930	jne	0x10000a8bc
000000010000a932	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a938	movq	0x8701(%rip), %r12              ## literal pool symbol address: ___stdinp
000000010000a93f	nop
000000010000a940	movq	%rbx, %rdx
000000010000a943	subq	%r15, %rdx
000000010000a946	jbe	0x10000a966
000000010000a948	leaq	(%r14,%r15), %rdi
000000010000a94c	movq	(%r12), %rcx
000000010000a950	movl	$0x1, %esi
000000010000a955	callq	0x10001149c                     ## symbol stub for: _fread
000000010000a95a	addq	%rax, %r15
000000010000a95d	testq	%rax, %rax
000000010000a960	jne	0x10000a940
000000010000a962	xorl	%eax, %eax
000000010000a964	jmp	0x10000a96b
000000010000a966	movl	$0x1, %eax
000000010000a96b	popq	%rbx
000000010000a96c	popq	%r12
000000010000a96e	popq	%r14
000000010000a970	popq	%r15
000000010000a972	popq	%rbp
000000010000a973	retq
000000010000a974	nopw	%cs:(%rax,%rax)
_fwp_stdin_leb:
000000010000a980	pushq	%rbp
000000010000a981	movq	%rsp, %rbp
000000010000a984	pushq	%r15
000000010000a986	pushq	%r14
000000010000a988	pushq	%r13
000000010000a98a	pushq	%r12
000000010000a98c	pushq	%rbx
000000010000a98d	pushq	%rax
000000010000a98e	movq	%rdi, %rbx
000000010000a991	movq	$0x0, (%rdi)
000000010000a998	movq	$-0x7, %r14
000000010000a99f	leaq	_fwp_in_pend(%rip), %r12
000000010000a9a6	movq	0x8693(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000a9ad	leaq	-0x29(%rbp), %r15
000000010000a9b1	nopw	%cs:(%rax,%rax)
000000010000a9c0	movslq	_fwp_in_ppos(%rip), %rax
000000010000a9c7	cmpl	_fwp_in_npend(%rip), %eax
000000010000a9cd	jge	0x10000a9f0
000000010000a9cf	leal	0x1(%rax), %ecx
000000010000a9d2	movzbl	(%rax,%r12), %eax
000000010000a9d7	movb	%al, -0x29(%rbp)
000000010000a9da	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a9e0	jmp	0x10000aa0b
000000010000a9e2	nopw	%cs:(%rax,%rax)
000000010000a9f0	movq	(%r13), %rcx
000000010000a9f4	movl	$0x1, %esi
000000010000a9f9	movl	$0x1, %edx
000000010000a9fe	movq	%r15, %rdi
000000010000aa01	callq	0x10001149c                     ## symbol stub for: _fread
000000010000aa06	testq	%rax, %rax
000000010000aa09	je	0x10000aa4c
000000010000aa0b	cmpq	$0x38, %r14
000000010000aa0f	setne	%cl
000000010000aa12	movzbl	-0x29(%rbp), %eax
000000010000aa16	testb	$0x7e, %al
000000010000aa18	sete	%dl
000000010000aa1b	orb	%cl, %dl
000000010000aa1d	je	0x10000aa3e
000000010000aa1f	addq	$0x7, %r14
000000010000aa23	movzbl	%al, %eax
000000010000aa26	movl	%eax, %edx
000000010000aa28	andl	$0x7f, %edx
000000010000aa2b	movl	%r14d, %ecx
000000010000aa2e	shlq	%cl, %rdx
000000010000aa31	orq	%rdx, (%rbx)
000000010000aa34	testb	%al, %al
000000010000aa36	jns	0x10000aa45
000000010000aa38	cmpq	$0x38, %r14
000000010000aa3c	jbe	0x10000a9c0
000000010000aa3e	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000aa43	jmp	0x10000aa4e
000000010000aa45	movl	$0x1, %eax
000000010000aa4a	jmp	0x10000aa4e
000000010000aa4c	xorl	%eax, %eax
000000010000aa4e	addq	$0x8, %rsp
000000010000aa52	popq	%rbx
000000010000aa53	popq	%r12
000000010000aa55	popq	%r13
000000010000aa57	popq	%r14
000000010000aa59	popq	%r15
000000010000aa5b	popq	%rbp
000000010000aa5c	retq
000000010000aa5d	nopl	(%rax)
_fwp_stdin_name_len:
000000010000aa60	pushq	%rbp
000000010000aa61	movq	%rsp, %rbp
000000010000aa64	pushq	%r15
000000010000aa66	pushq	%r14
000000010000aa68	pushq	%r13
000000010000aa6a	pushq	%r12
000000010000aa6c	pushq	%rbx
000000010000aa6d	pushq	%rax
000000010000aa6e	movq	%rdi, %rbx
000000010000aa71	movq	$0x0, (%rdi)
000000010000aa78	movq	$-0x7, %r14
000000010000aa7f	leaq	_fwp_in_pend(%rip), %r12
000000010000aa86	movq	0x85b3(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000aa8d	leaq	-0x29(%rbp), %r15
000000010000aa91	nopw	%cs:(%rax,%rax)
000000010000aaa0	movslq	_fwp_in_ppos(%rip), %rax
000000010000aaa7	cmpl	_fwp_in_npend(%rip), %eax
000000010000aaad	jge	0x10000aad0
000000010000aaaf	leal	0x1(%rax), %ecx
000000010000aab2	movzbl	(%rax,%r12), %eax
000000010000aab7	movb	%al, -0x29(%rbp)
000000010000aaba	movl	%ecx, _fwp_in_ppos(%rip)
000000010000aac0	jmp	0x10000aaeb
000000010000aac2	nopw	%cs:(%rax,%rax)
000000010000aad0	movq	(%r13), %rcx
000000010000aad4	movl	$0x1, %esi
000000010000aad9	movl	$0x1, %edx
000000010000aade	movq	%r15, %rdi
000000010000aae1	callq	0x10001149c                     ## symbol stub for: _fread
000000010000aae6	testq	%rax, %rax
000000010000aae9	je	0x10000ab41
000000010000aaeb	cmpq	$0x38, %r14
000000010000aaef	setne	%cl
000000010000aaf2	movzbl	-0x29(%rbp), %eax
000000010000aaf6	testb	$0x7e, %al
000000010000aaf8	sete	%dl
000000010000aafb	orb	%cl, %dl
000000010000aafd	je	0x10000ab25
000000010000aaff	addq	$0x7, %r14
000000010000ab03	movzbl	%al, %eax
000000010000ab06	movl	%eax, %edx
000000010000ab08	andl	$0x7f, %edx
000000010000ab0b	movl	%r14d, %ecx
000000010000ab0e	shlq	%cl, %rdx
000000010000ab11	orq	(%rbx), %rdx
000000010000ab14	movq	%rdx, (%rbx)
000000010000ab17	testb	%al, %al
000000010000ab19	jns	0x10000ab2c
000000010000ab1b	cmpq	$0x38, %r14
000000010000ab1f	jbe	0x10000aaa0
000000010000ab25	movl	$0xffffffff, %ecx               ## imm = 0xFFFFFFFF
000000010000ab2a	jmp	0x10000ab43
000000010000ab2c	movl	$0x1, %ecx
000000010000ab31	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000ab36	cmpq	$0x100000, %rdx                 ## imm = 0x100000
000000010000ab3d	jbe	0x10000ab43
000000010000ab3f	jmp	0x10000ab45
000000010000ab41	xorl	%ecx, %ecx
000000010000ab43	movl	%ecx, %eax
000000010000ab45	addq	$0x8, %rsp
000000010000ab49	popq	%rbx
000000010000ab4a	popq	%r12
000000010000ab4c	popq	%r13
000000010000ab4e	popq	%r14
000000010000ab50	popq	%r15
000000010000ab52	popq	%rbp
000000010000ab53	retq
000000010000ab54	nopw	%cs:(%rax,%rax)
_fwp_decode:
000000010000ab60	pushq	%rbp
000000010000ab61	movq	%rsp, %rbp
000000010000ab64	pushq	%r15
000000010000ab66	pushq	%r14
000000010000ab68	pushq	%r13
000000010000ab6a	pushq	%r12
000000010000ab6c	pushq	%rbx
000000010000ab6d	subq	$0x48, %rsp
000000010000ab71	movq	0x84b8(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ab78	movq	(%rax), %rax
000000010000ab7b	movq	%rax, -0x30(%rbp)
000000010000ab7f	movl	(%rsi), %eax
000000010000ab81	xorl	%r8d, %r8d
000000010000ab84	cmpq	$0x15, %rax
000000010000ab88	ja	0x10000b107
000000010000ab8e	movq	%rdx, %r9
000000010000ab91	movq	%rsi, %r15
000000010000ab94	movq	%rdi, %r14
000000010000ab97	leaq	0x84e(%rip), %rcx
000000010000ab9e	movslq	(%rcx,%rax,4), %rdx
000000010000aba2	addq	%rcx, %rdx
000000010000aba5	jmpq	*%rdx
000000010000aba7	xorl	%ecx, %ecx
000000010000aba9	cmpl	$0xa, %eax
000000010000abac	setne	%cl
000000010000abaf	leaq	0x4(,%rcx,4), %rax
000000010000abb7	movq	0x8(%r14), %rdx
000000010000abbb	movq	0x10(%r14), %rcx
000000010000abbf	subq	%rcx, %rdx
000000010000abc2	cmpq	%rax, %rdx
000000010000abc5	jb	0x10000b107
000000010000abcb	movq	(%r14), %rdx
000000010000abce	addq	%rcx, %rdx
000000010000abd1	addq	%rax, %rcx
000000010000abd4	movq	%rcx, 0x10(%r14)
000000010000abd8	cmpq	$0x8, %rax
000000010000abdc	jae	0x10000abe4
000000010000abde	xorl	%esi, %esi
000000010000abe0	xorl	%edi, %edi
000000010000abe2	jmp	0x10000ac49
000000010000abe4	movl	%eax, %esi
000000010000abe6	andl	$-0x8, %esi
000000010000abe9	pmovzxbq	0x2(%rdx), %xmm0
000000010000abef	pmovzxbq	0x6(%rdx), %xmm1
000000010000abf5	pmovzxbq	0x4(%rdx), %xmm2
000000010000abfb	pmovzxbq	(%rdx), %xmm3
000000010000ac00	movdqa	%xmm3, %xmm4
000000010000ac04	psllq	$0x8, %xmm4
000000010000ac09	pshufb	0x6a5e(%rip), %xmm2
000000010000ac12	pblendw	$0xf, %xmm3, %xmm4              ## xmm4 = xmm3[0,1,2,3],xmm4[4,5,6,7]
000000010000ac18	por	%xmm4, %xmm2
000000010000ac1c	pshufb	0x6a5b(%rip), %xmm1
000000010000ac25	pshufb	0x6a62(%rip), %xmm0
000000010000ac2e	por	%xmm1, %xmm0
000000010000ac32	por	%xmm2, %xmm0
000000010000ac36	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000ac3b	por	%xmm0, %xmm1
000000010000ac3f	movq	%xmm1, %rdi
000000010000ac44	cmpq	%rsi, %rax
000000010000ac47	je	0x10000ac67
000000010000ac49	leal	(,%rsi,8), %ecx
000000010000ac50	movzbl	(%rdx,%rsi), %r8d
000000010000ac55	shlq	%cl, %r8
000000010000ac58	orq	%r8, %rdi
000000010000ac5b	incq	%rsi
000000010000ac5e	addq	$0x8, %rcx
000000010000ac62	cmpq	%rsi, %rax
000000010000ac65	jne	0x10000ac50
000000010000ac67	movq	%rdi, (%r9)
000000010000ac6a	movl	$0x1, %r8d
000000010000ac70	jmp	0x10000b107
000000010000ac75	movq	%r9, %r12
000000010000ac78	leaq	-0x58(%rbp), %rsi
000000010000ac7c	movq	%r14, %rdi
000000010000ac7f	callq	_rd_leb
000000010000ac84	testl	%eax, %eax
000000010000ac86	je	0x10000b104
000000010000ac8c	movq	-0x58(%rbp), %rbx
000000010000ac90	movq	0x8(%r14), %rcx
000000010000ac94	cmpq	%rcx, %rbx
000000010000ac97	movl	$0x0, %r8d
000000010000ac9d	ja	0x10000b107
000000010000aca3	movq	0x10(%r14), %rax
000000010000aca7	subq	%rax, %rcx
000000010000acaa	cmpq	%rbx, %rcx
000000010000acad	jb	0x10000b107
000000010000acb3	movq	(%r14), %r13
000000010000acb6	addq	%rax, %r13
000000010000acb9	addq	%rbx, %rax
000000010000acbc	movq	%rax, 0x10(%r14)
000000010000acc0	cmpl	$0xc, (%r15)
000000010000acc4	movq	%r12, %rcx
000000010000acc7	jne	0x10000ace2
000000010000acc9	movq	%r13, %rdi
000000010000accc	movq	%rbx, %rsi
000000010000accf	callq	_fwp_valid_utf8
000000010000acd4	xorl	%r8d, %r8d
000000010000acd7	movq	%r12, %rcx
000000010000acda	testl	%eax, %eax
000000010000acdc	je	0x10000b107
000000010000ace2	movq	%r13, %rdi
000000010000ace5	movq	%rbx, %rsi
000000010000ace8	movq	%rcx, %rbx
000000010000aceb	callq	_fwp_str_new
000000010000acf0	movq	%rax, (%rbx)
000000010000acf3	jmp	0x10000ac6a
000000010000acf8	movq	0x10(%r14), %rax
000000010000acfc	cmpq	%rax, 0x8(%r14)
000000010000ad00	je	0x10000b107
000000010000ad06	movq	(%r14), %rcx
000000010000ad09	leaq	0x1(%rax), %rdx
000000010000ad0d	movq	%rdx, 0x10(%r14)
000000010000ad11	movsbq	(%rcx,%rax), %rax
000000010000ad16	movq	%rax, (%r9)
000000010000ad19	jmp	0x10000ac6a
000000010000ad1e	movq	0x8(%r14), %rsi
000000010000ad22	movq	0x10(%r14), %rcx
000000010000ad26	movq	%rsi, %rdx
000000010000ad29	subq	%rcx, %rdx
000000010000ad2c	cmpq	$0x8, %rdx
000000010000ad30	jb	0x10000b107
000000010000ad36	movq	(%r14), %rdx
000000010000ad39	leaq	0x8(%rcx), %rdi
000000010000ad3d	movq	%rdi, 0x10(%r14)
000000010000ad41	subq	%rdi, %rsi
000000010000ad44	cmpq	$0x8, %rsi
000000010000ad48	jb	0x10000b107
000000010000ad4e	movq	%r9, %rbx
000000010000ad51	movq	(%rdx,%rcx), %rdi
000000010000ad55	leaq	0x10(%rcx), %rsi
000000010000ad59	movq	%rsi, 0x10(%r14)
000000010000ad5d	movq	0x8(%rdx,%rcx), %rsi
000000010000ad62	cmpl	$0x4, %eax
000000010000ad65	jne	0x10000b0ed
000000010000ad6b	callq	_fwp_box_u128
000000010000ad70	movq	%rax, (%rbx)
000000010000ad73	jmp	0x10000ac6a
000000010000ad78	movq	%r9, -0x50(%rbp)
000000010000ad7c	movq	0x38(%r15), %rbx
000000010000ad80	leaq	-0x58(%rbp), %rsi
000000010000ad84	movq	%r14, %rdi
000000010000ad87	callq	_rd_leb
000000010000ad8c	testl	%eax, %eax
000000010000ad8e	je	0x10000b104
000000010000ad94	movq	-0x58(%rbp), %r12
000000010000ad98	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000ada2	cmpq	%rax, %r12
000000010000ada5	movl	$0x0, %r8d
000000010000adab	ja	0x10000b107
000000010000adb1	movq	%rbx, %rdi
000000010000adb4	xorl	%esi, %esi
000000010000adb6	callq	_fwp_wire_empty_inner
000000010000adbb	xorl	%r8d, %r8d
000000010000adbe	testl	%eax, %eax
000000010000adc0	jne	0x10000adcc
000000010000adc2	cmpq	0x8(%r14), %r12
000000010000adc6	ja	0x10000b107
000000010000adcc	cmpl	$0x11, (%r15)
000000010000add0	jne	0x10000b084
000000010000add6	movq	0x38(%r15), %rsi
000000010000adda	movq	%r12, %rdi
000000010000addd	callq	_fwp_array_new_packed
000000010000ade2	movq	%rax, %r13
000000010000ade5	testq	%r12, %r12
000000010000ade8	je	0x10000ae1f
000000010000adea	xorl	%ebx, %ebx
000000010000adec	movq	0x38(%r15), %rsi
000000010000adf0	movq	%r14, %rdi
000000010000adf3	leaq	-0x40(%rbp), %rdx
000000010000adf7	callq	_fwp_decode
000000010000adfc	testl	%eax, %eax
000000010000adfe	je	0x10000b104
000000010000ae04	movq	-0x40(%rbp), %rdx
000000010000ae08	movq	0x38(%r15), %rcx
000000010000ae0c	movq	%r13, %rdi
000000010000ae0f	movq	%rbx, %rsi
000000010000ae12	callq	_fwp_array_store
000000010000ae17	incq	%rbx
000000010000ae1a	cmpq	%rbx, %r12
000000010000ae1d	jne	0x10000adec
000000010000ae1f	movq	-0x50(%rbp), %rax
000000010000ae23	movq	%r13, (%rax)
000000010000ae26	jmp	0x10000ac6a
000000010000ae2b	movq	%r9, -0x50(%rbp)
000000010000ae2f	leaq	-0x58(%rbp), %rsi
000000010000ae33	movq	%r14, %rdi
000000010000ae36	callq	_rd_leb
000000010000ae3b	testl	%eax, %eax
000000010000ae3d	je	0x10000b104
000000010000ae43	movq	-0x58(%rbp), %r13
000000010000ae47	movslq	0x10(%r15), %rax
000000010000ae4b	cmpq	%rax, %r13
000000010000ae4e	movl	$0x0, %r8d
000000010000ae54	jae	0x10000b107
000000010000ae5a	movq	0x28(%r15), %rax
000000010000ae5e	movslq	(%rax,%r13,4), %rbx
000000010000ae62	leaq	0x8(,%rbx,8), %rdi
000000010000ae6a	callq	_fwp_alloc
000000010000ae6f	movq	%rax, -0x48(%rbp)
000000010000ae73	movq	%rbx, -0x60(%rbp)
000000010000ae77	testq	%rbx, %rbx
000000010000ae7a	jle	0x10000aeb8
000000010000ae7c	movq	-0x60(%rbp), %rax
000000010000ae80	leaq	(,%rax,8), %rbx
000000010000ae88	xorl	%r12d, %r12d
000000010000ae8b	movq	0x30(%r15), %rax
000000010000ae8f	movq	(%rax,%r13,8), %rax
000000010000ae93	movq	(%rax,%r12), %rsi
000000010000ae97	movq	-0x48(%rbp), %rax
000000010000ae9b	leaq	(%rax,%r12), %rdx
000000010000ae9f	movq	%r14, %rdi
000000010000aea2	callq	_fwp_decode
000000010000aea7	testl	%eax, %eax
000000010000aea9	je	0x10000b104
000000010000aeaf	addq	$0x8, %r12
000000010000aeb3	cmpq	%r12, %rbx
000000010000aeb6	jne	0x10000ae8b
000000010000aeb8	movl	%r13d, %edi
000000010000aebb	movq	-0x60(%rbp), %rsi
000000010000aebf	movq	-0x48(%rbp), %rdx
000000010000aec3	callq	_fwp_data
000000010000aec8	jmp	0x10000b3d8
000000010000aecd	movl	$0x1, %eax
000000010000aed2	jmp	0x10000abb7
000000010000aed7	movl	$0x2, %eax
000000010000aedc	jmp	0x10000abb7
000000010000aee1	movq	0x8(%r14), %rcx
000000010000aee5	movq	0x10(%r14), %rax
000000010000aee9	subq	%rax, %rcx
000000010000aeec	cmpq	$0x2, %rcx
000000010000aef0	jb	0x10000b107
000000010000aef6	movq	(%r14), %rcx
000000010000aef9	leaq	0x2(%rax), %rdx
000000010000aefd	movq	%rdx, 0x10(%r14)
000000010000af01	movzbl	(%rcx,%rax), %edx
000000010000af05	movzbl	0x1(%rcx,%rax), %eax
000000010000af0a	shlq	$0x38, %rax
000000010000af0e	shlq	$0x30, %rdx
000000010000af12	orq	%rax, %rdx
000000010000af15	sarq	$0x30, %rdx
000000010000af19	movq	%rdx, (%r9)
000000010000af1c	jmp	0x10000ac6a
000000010000af21	movq	0x8(%r14), %rcx
000000010000af25	movq	0x10(%r14), %rax
000000010000af29	subq	%rax, %rcx
000000010000af2c	cmpq	$0x4, %rcx
000000010000af30	jb	0x10000b107
000000010000af36	movq	(%r14), %rcx
000000010000af39	leaq	0x4(%rax), %rdx
000000010000af3d	movq	%rdx, 0x10(%r14)
000000010000af41	movzbl	(%rcx,%rax), %edx
000000010000af45	movzbl	0x1(%rcx,%rax), %esi
000000010000af4a	movzbl	0x2(%rcx,%rax), %edi
000000010000af4f	movzbl	0x3(%rcx,%rax), %eax
000000010000af54	shlq	$0x38, %rax
000000010000af58	shlq	$0x30, %rdi
000000010000af5c	shlq	$0x28, %rsi
000000010000af60	shlq	$0x20, %rdx
000000010000af64	orq	%rsi, %rdx
000000010000af67	orq	%rdi, %rdx
000000010000af6a	orq	%rax, %rdx
000000010000af6d	sarq	$0x20, %rdx
000000010000af71	movq	%rdx, (%r9)
000000010000af74	jmp	0x10000ac6a
000000010000af79	movl	$0x4, %eax
000000010000af7e	jmp	0x10000abb7
000000010000af83	movq	%r9, %r12
000000010000af86	movq	0x40(%r15), %rdi
000000010000af8a	xorl	%esi, %esi
000000010000af8c	callq	_fwp_wire_empty_inner
000000010000af91	testl	%eax, %eax
000000010000af93	setne	%r13b
000000010000af97	jmp	0x10000af9f
000000010000af99	movq	%r9, %r12
000000010000af9c	movb	$0x1, %r13b
000000010000af9f	movq	0x38(%r15), %rbx
000000010000afa3	leaq	-0x58(%rbp), %rsi
000000010000afa7	movq	%r14, %rdi
000000010000afaa	callq	_rd_leb
000000010000afaf	testl	%eax, %eax
000000010000afb1	je	0x10000b104
000000010000afb7	movb	%r13b, -0x48(%rbp)
000000010000afbb	movq	-0x58(%rbp), %r13
000000010000afbf	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000afc9	cmpq	%rax, %r13
000000010000afcc	movl	$0x0, %r8d
000000010000afd2	ja	0x10000b107
000000010000afd8	movq	%r12, -0x50(%rbp)
000000010000afdc	movq	%rbx, %rdi
000000010000afdf	xorl	%esi, %esi
000000010000afe1	callq	_fwp_wire_empty_inner
000000010000afe6	testl	%eax, %eax
000000010000afe8	je	0x10000b0fa
000000010000afee	cmpq	$0x2, %r13
000000010000aff2	setae	%al
000000010000aff5	movzbl	-0x48(%rbp), %ecx
000000010000aff9	testb	%cl, %al
000000010000affb	je	0x10000b12d
000000010000b001	jmp	0x10000b104
000000010000b006	movslq	0x10(%r15), %rdi
000000010000b00a	testq	%rdi, %rdi
000000010000b00d	je	0x10000b078
000000010000b00f	shlq	$0x3, %rdi
000000010000b013	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000b01a	movq	%r9, -0x50(%rbp)
000000010000b01e	ja	0x10000b1b8
000000010000b024	leaq	0xf(%rdi), %rcx
000000010000b028	shrq	$0x4, %rcx
000000010000b02c	leaq	_fwp_gc(%rip), %rax
000000010000b033	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000b03b	movl	0xb48(%rax,%rcx,4), %esi
000000010000b042	subq	%rsi, _fwp_gc(%rip)
000000010000b049	js	0x10000b1b8
000000010000b04f	leaq	(%rcx,%rcx,2), %rcx
000000010000b053	leaq	(%rax,%rcx,8), %rax
000000010000b057	addq	$0x788, %rax                    ## imm = 0x788
000000010000b05d	movq	(%rax), %r12
000000010000b060	testq	%r12, %r12
000000010000b063	je	0x10000b1a8
000000010000b069	movq	(%r12), %rcx
000000010000b06d	notq	%rcx
000000010000b070	movq	%rcx, (%rax)
000000010000b073	jmp	0x10000b1db
000000010000b078	movq	$0x0, (%r9)
000000010000b07f	jmp	0x10000ac6a
000000010000b084	cmpq	$0x7ff, %r12                    ## imm = 0x7FF
000000010000b08b	ja	0x10000b299
000000010000b091	leaq	(,%r12,8), %rcx
000000010000b099	addq	$0x17, %rcx
000000010000b09d	shrq	$0x4, %rcx
000000010000b0a1	leaq	_fwp_gc(%rip), %rax
000000010000b0a8	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000b0b0	movl	0xb48(%rax,%rcx,4), %esi
000000010000b0b7	subq	%rsi, _fwp_gc(%rip)
000000010000b0be	js	0x10000b299
000000010000b0c4	leaq	(%rcx,%rcx,2), %rcx
000000010000b0c8	leaq	(%rax,%rcx,8), %rax
000000010000b0cc	addq	$0x788, %rax                    ## imm = 0x788
000000010000b0d2	movq	(%rax), %r13
000000010000b0d5	testq	%r13, %r13
000000010000b0d8	je	0x10000b285
000000010000b0de	movq	(%r13), %rcx
000000010000b0e2	notq	%rcx
000000010000b0e5	movq	%rcx, (%rax)
000000010000b0e8	jmp	0x10000b35a
000000010000b0ed	callq	_fwp_box_u128
000000010000b0f2	movq	%rax, (%rbx)
000000010000b0f5	jmp	0x10000ac6a
000000010000b0fa	cmpq	0x8(%r14), %r13
000000010000b0fe	movzbl	-0x48(%rbp), %ecx
000000010000b102	jbe	0x10000b12d
000000010000b104	xorl	%r8d, %r8d
000000010000b107	movq	0x7f22(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b10e	movq	(%rax), %rax
000000010000b111	cmpq	-0x30(%rbp), %rax
000000010000b115	jne	0x10000b3e4
000000010000b11b	movl	%r8d, %eax
000000010000b11e	addq	$0x48, %rsp
000000010000b122	popq	%rbx
000000010000b123	popq	%r12
000000010000b125	popq	%r13
000000010000b127	popq	%r14
000000010000b129	popq	%r15
000000010000b12b	popq	%rbp
000000010000b12c	retq
000000010000b12d	testb	%cl, %cl
000000010000b12f	movl	$0x0, %r8d
000000010000b135	jne	0x10000b13d
000000010000b137	cmpq	0x8(%r14), %r13
000000010000b13b	ja	0x10000b107
000000010000b13d	leaq	_fwp_empty_map(%rip), %r12
000000010000b144	testq	%r13, %r13
000000010000b147	je	0x10000b1c7
000000010000b149	leaq	-0x40(%rbp), %rbx
000000010000b14d	jmp	0x10000b169
000000010000b14f	xorl	%esi, %esi
000000010000b151	movq	-0x40(%rbp), %rdi
000000010000b155	movq	0x38(%r15), %rcx
000000010000b159	movq	%r12, %rdx
000000010000b15c	callq	_fwp_p_map_insert
000000010000b161	movq	%rax, %r12
000000010000b164	decq	%r13
000000010000b167	je	0x10000b1c7
000000010000b169	movq	$0x0, -0x68(%rbp)
000000010000b171	movq	0x38(%r15), %rsi
000000010000b175	movq	%r14, %rdi
000000010000b178	movq	%rbx, %rdx
000000010000b17b	callq	_fwp_decode
000000010000b180	testl	%eax, %eax
000000010000b182	je	0x10000b104
000000010000b184	cmpl	$0x12, (%r15)
000000010000b188	jne	0x10000b14f
000000010000b18a	movq	0x40(%r15), %rsi
000000010000b18e	movq	%r14, %rdi
000000010000b191	leaq	-0x68(%rbp), %rdx
000000010000b195	callq	_fwp_decode
000000010000b19a	testl	%eax, %eax
000000010000b19c	je	0x10000b104
000000010000b1a2	movq	-0x68(%rbp), %rsi
000000010000b1a6	jmp	0x10000b151
000000010000b1a8	movq	0x8(%rax), %r12
000000010000b1ac	movq	0x10(%rax), %rcx
000000010000b1b0	subq	%r12, %rcx
000000010000b1b3	cmpq	%rsi, %rcx
000000010000b1b6	jae	0x10000b1d3
000000010000b1b8	movl	$0x2, %esi
000000010000b1bd	callq	_fwp_gc_alloc_slow
000000010000b1c2	movq	%rax, %r12
000000010000b1c5	jmp	0x10000b1e3
000000010000b1c7	movq	-0x50(%rbp), %rax
000000010000b1cb	movq	%r12, (%rax)
000000010000b1ce	jmp	0x10000ac6a
000000010000b1d3	leaq	(%r12,%rsi), %rcx
000000010000b1d7	movq	%rcx, 0x8(%rax)
000000010000b1db	movq	%r12, %rdi
000000010000b1de	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000b1e3	movl	0x10(%r15), %r13d
000000010000b1e7	testl	%r13d, %r13d
000000010000b1ea	jle	0x10000b22f
000000010000b1ec	movq	%r12, -0x48(%rbp)
000000010000b1f0	movq	%r12, %rbx
000000010000b1f3	xorl	%r12d, %r12d
000000010000b1f6	nopw	%cs:(%rax,%rax)
000000010000b200	movq	0x20(%r15), %rax
000000010000b204	movq	(%rax,%r12,8), %rsi
000000010000b208	movq	%r14, %rdi
000000010000b20b	movq	%rbx, %rdx
000000010000b20e	callq	_fwp_decode
000000010000b213	testl	%eax, %eax
000000010000b215	je	0x10000b104
000000010000b21b	incq	%r12
000000010000b21e	movslq	0x10(%r15), %r13
000000010000b222	addq	$0x8, %rbx
000000010000b226	cmpq	%r13, %r12
000000010000b229	jl	0x10000b200
000000010000b22b	movq	-0x48(%rbp), %r12
000000010000b22f	testl	%r13d, %r13d
000000010000b232	je	0x10000b25f
000000010000b234	movl	%r13d, %ebx
000000010000b237	leaq	0x8(,%rbx,8), %rdi
000000010000b23f	callq	_fwp_alloc_init
000000010000b244	movl	$0x0, (%rax)
000000010000b24a	movl	%r13d, 0x4(%rax)
000000010000b24e	cmpl	$0x8, %r13d
000000010000b252	jae	0x10000b26d
000000010000b254	xorl	%ecx, %ecx
000000010000b256	movq	-0x50(%rbp), %r8
000000010000b25a	jmp	0x10000b2ec
000000010000b25f	xorl	%eax, %eax
000000010000b261	movq	-0x50(%rbp), %r8
000000010000b265	movq	%rax, (%r8)
000000010000b268	jmp	0x10000ac6a
000000010000b26d	movq	%rax, %rcx
000000010000b270	subq	%r12, %rcx
000000010000b273	addq	$0x8, %rcx
000000010000b277	cmpq	$0x20, %rcx
000000010000b27b	movq	-0x50(%rbp), %r8
000000010000b27f	jae	0x10000b2b3
000000010000b281	xorl	%ecx, %ecx
000000010000b283	jmp	0x10000b2ec
000000010000b285	movq	0x8(%rax), %r13
000000010000b289	movq	0x10(%rax), %rcx
000000010000b28d	subq	%r13, %rcx
000000010000b290	cmpq	%rsi, %rcx
000000010000b293	jae	0x10000b352
000000010000b299	leaq	0x8(,%r12,8), %rdi
000000010000b2a1	movl	$0x2, %esi
000000010000b2a6	callq	_fwp_gc_alloc_slow
000000010000b2ab	movq	%rax, %r13
000000010000b2ae	jmp	0x10000b362
000000010000b2b3	movl	%ebx, %ecx
000000010000b2b5	andl	$-0x4, %ecx
000000010000b2b8	leaq	(,%rbx,8), %rdx
000000010000b2c0	andq	$-0x20, %rdx
000000010000b2c4	xorl	%esi, %esi
000000010000b2c6	movdqu	(%r12,%rsi), %xmm0
000000010000b2cc	movdqu	0x10(%r12,%rsi), %xmm1
000000010000b2d3	movdqu	%xmm0, 0x8(%rax,%rsi)
000000010000b2d9	movdqu	%xmm1, 0x18(%rax,%rsi)
000000010000b2df	addq	$0x20, %rsi
000000010000b2e3	cmpq	%rsi, %rdx
000000010000b2e6	jne	0x10000b2c6
000000010000b2e8	cmpl	%ebx, %ecx
000000010000b2ea	je	0x10000b34a
000000010000b2ec	movq	%rbx, %rsi
000000010000b2ef	movq	%rcx, %rdx
000000010000b2f2	andq	$0x3, %rsi
000000010000b2f6	je	0x10000b311
000000010000b2f8	movq	%rcx, %rdx
000000010000b2fb	nopl	(%rax,%rax)
000000010000b300	movq	(%r12,%rdx,8), %rdi
000000010000b304	movq	%rdi, 0x8(%rax,%rdx,8)
000000010000b309	incq	%rdx
000000010000b30c	decq	%rsi
000000010000b30f	jne	0x10000b300
000000010000b311	subq	%rbx, %rcx
000000010000b314	cmpq	$-0x4, %rcx
000000010000b318	ja	0x10000b34a
000000010000b31a	movq	(%r12,%rdx,8), %rcx
000000010000b31e	movq	%rcx, 0x8(%rax,%rdx,8)
000000010000b323	movq	0x8(%r12,%rdx,8), %rcx
000000010000b328	movq	%rcx, 0x10(%rax,%rdx,8)
000000010000b32d	movq	0x10(%r12,%rdx,8), %rcx
000000010000b332	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000b337	movq	0x18(%r12,%rdx,8), %rcx
000000010000b33c	movq	%rcx, 0x20(%rax,%rdx,8)
000000010000b341	addq	$0x4, %rdx
000000010000b345	cmpq	%rdx, %rbx
000000010000b348	jne	0x10000b31a
000000010000b34a	movq	%rax, (%r8)
000000010000b34d	jmp	0x10000ac6a
000000010000b352	leaq	(%rsi,%r13), %rcx
000000010000b356	movq	%rcx, 0x8(%rax)
000000010000b35a	movq	%r13, %rdi
000000010000b35d	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000b362	testq	%r12, %r12
000000010000b365	je	0x10000b3d6
000000010000b367	movq	%r13, -0x48(%rbp)
000000010000b36b	movq	%r13, %rbx
000000010000b36e	movq	%r12, %r13
000000010000b371	movq	0x38(%r15), %rsi
000000010000b375	movq	%r14, %rdi
000000010000b378	movq	%rbx, %rdx
000000010000b37b	callq	_fwp_decode
000000010000b380	testl	%eax, %eax
000000010000b382	je	0x10000b104
000000010000b388	addq	$0x8, %rbx
000000010000b38c	decq	%r13
000000010000b38f	jne	0x10000b371
000000010000b391	xorl	%r15d, %r15d
000000010000b394	movabsq	$0x200000001, %rbx              ## imm = 0x200000001
000000010000b39e	leaq	-0x40(%rbp), %r14
000000010000b3a2	movq	-0x48(%rbp), %rax
000000010000b3a6	movq	-0x8(%rax,%r12,8), %r13
000000010000b3ab	movq	%r13, -0x40(%rbp)
000000010000b3af	movq	%r15, -0x38(%rbp)
000000010000b3b3	movl	$0x18, %edi
000000010000b3b8	callq	_fwp_alloc_init
000000010000b3bd	movq	%rbx, (%rax)
000000010000b3c0	movq	%r13, 0x8(%rax)
000000010000b3c4	movq	-0x48(%rbp), %r13
000000010000b3c8	movq	%r15, 0x10(%rax)
000000010000b3cc	movq	%rax, %r15
000000010000b3cf	decq	%r12
000000010000b3d2	jne	0x10000b3a2
000000010000b3d4	jmp	0x10000b3d8
000000010000b3d6	xorl	%eax, %eax
000000010000b3d8	movq	-0x50(%rbp), %rcx
000000010000b3dc	movq	%rax, (%rcx)
000000010000b3df	jmp	0x10000ac6a
000000010000b3e4	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000b3e9	nopl	(%rax)
000000010000b3ec	orb	$-0x7, %al
000000010000b3ee	.byte 0xff #bad opcode
000000010000b3ef	pushq	%rbp
000000010000b3f1	cli
000000010000b3f2	.byte 0xff #bad opcode
000000010000b3f3	pushq	-0x44000005(%rip)
000000010000b3f9	idivl	%edi
000000010000b3fb	pushq	(%rdx)
000000010000b3fd	stc
000000010000b3fe	.byte 0xff #bad opcode
000000010000b3ff	jmpq	*%rcx
000000010000b401	cli
000000010000b402	.byte 0xff #bad opcode
000000010000b403	.byte 0xff #bad opcode
000000010000b404	jmp	0x10000b400
000000010000b406	.byte 0xff #bad opcode
000000010000b407	decl	-0x44000005(%rbp)
000000010000b40d	idivl	%edi
000000010000b40f	pushq	(%rdx)
000000010000b411	stc
000000010000b412	.byte 0xff #bad opcode
000000010000b413	.byte 0xff #bad opcode
000000010000b414	movl	$0xbbfffff7, %ebx               ## imm = 0xBBFFFFF7
000000010000b419	idivl	%edi
000000010000b41b	decl	-0x76000008(%rcx)
000000010000b421	clc
000000010000b422	.byte 0xff #bad opcode
000000010000b423	.byte 0xff #bad opcode
000000010000b424	.byte 0x3f #bad opcode
000000010000b425	cli
000000010000b426	.byte 0xff #bad opcode
000000010000b427	decl	-0x3e50001(%rcx,%rdi,8)
000000010000b42e	.byte 0xff #bad opcode
000000010000b42f	decl	-0x4680001(%rcx,%rdi,8)
000000010000b436	.byte 0xff #bad opcode
000000010000b437	ljmpl	*-0x44000005(%rbp)
000000010000b43d	idivl	%edi
000000010000b43f	decl	(%rcx,%rdi,8)
000000010000b442	.byte 0xff #bad opcode
000000010000b443	jmpq	*0x66(%rsi)
000000010000b446	nopw	%cs:(%rax,%rax)
_fwp_valid_utf8:
000000010000b450	testq	%rsi, %rsi
000000010000b453	je	0x10000b5b2
000000010000b459	pushq	%rbp
000000010000b45a	movq	%rsp, %rbp
000000010000b45d	pushq	%rbx
000000010000b45e	xorl	%ecx, %ecx
000000010000b460	jmp	0x10000b47c
000000010000b462	nopw	%cs:(%rax,%rax)
000000010000b470	incq	%rcx
000000010000b473	cmpq	%rsi, %rcx
000000010000b476	jae	0x10000b5aa
000000010000b47c	movzbl	(%rdi,%rcx), %r10d
000000010000b481	testb	%r10b, %r10b
000000010000b484	jns	0x10000b470
000000010000b486	leal	0x3e(%r10), %eax
000000010000b48a	cmpb	$0x1e, %al
000000010000b48c	jae	0x10000b4a0
000000010000b48e	movl	$0x80, %edx
000000010000b493	movl	$0x1, %eax
000000010000b498	movl	$0x1f, %r8d
000000010000b49e	jmp	0x10000b4d7
000000010000b4a0	movl	%r10d, %eax
000000010000b4a3	andb	$-0x10, %al
000000010000b4a5	cmpb	$-0x20, %al
000000010000b4a7	jne	0x10000b4bb
000000010000b4a9	movl	$0x800, %edx                    ## imm = 0x800
000000010000b4ae	movl	$0x2, %eax
000000010000b4b3	movl	$0xf, %r8d
000000010000b4b9	jmp	0x10000b4d7
000000010000b4bb	leal	0x10(%r10), %eax
000000010000b4bf	cmpb	$0x4, %al
000000010000b4c1	ja	0x10000b5b8
000000010000b4c7	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000b4cc	movl	$0x3, %eax
000000010000b4d1	movl	$0x7, %r8d
000000010000b4d7	movl	%eax, %r9d
000000010000b4da	leaq	(%rcx,%r9), %r11
000000010000b4de	xorl	%eax, %eax
000000010000b4e0	cmpq	%rsi, %r11
000000010000b4e3	jae	0x10000b5af
000000010000b4e9	movzbl	0x1(%rdi,%rcx), %r11d
000000010000b4ef	movl	%r11d, %ebx
000000010000b4f2	andl	$-0x40, %ebx
000000010000b4f5	cmpl	$0x80, %ebx
000000010000b4fb	jne	0x10000b5af
000000010000b501	andl	%r10d, %r8d
000000010000b504	leal	0x1(%r9), %ebx
000000010000b508	movl	%r8d, %r10d
000000010000b50b	shll	$0x6, %r10d
000000010000b50f	andl	$0x3f, %r11d
000000010000b513	orl	%r10d, %r11d
000000010000b516	cmpl	$0x2, %ebx
000000010000b519	jne	0x10000b527
000000010000b51b	movl	%r11d, %ebx
000000010000b51e	cmpl	%edx, %ebx
000000010000b520	jae	0x10000b582
000000010000b522	jmp	0x10000b5af
000000010000b527	movzbl	0x2(%rdi,%rcx), %r8d
000000010000b52d	movl	%r8d, %r10d
000000010000b530	andl	$-0x40, %r10d
000000010000b534	cmpl	$0x80, %r10d
000000010000b53b	jne	0x10000b5af
000000010000b53d	movl	%r11d, %r10d
000000010000b540	shll	$0x6, %r10d
000000010000b544	andl	$0x3f, %r8d
000000010000b548	orl	%r10d, %r8d
000000010000b54b	cmpl	$0x3, %ebx
000000010000b54e	jne	0x10000b55c
000000010000b550	movl	%r8d, %ebx
000000010000b553	movl	%r11d, %r8d
000000010000b556	cmpl	%edx, %ebx
000000010000b558	jae	0x10000b582
000000010000b55a	jmp	0x10000b5af
000000010000b55c	movzbl	0x3(%rdi,%rcx), %ebx
000000010000b561	movl	%ebx, %r10d
000000010000b564	andl	$-0x40, %r10d
000000010000b568	cmpl	$0x80, %r10d
000000010000b56f	jne	0x10000b5af
000000010000b571	movl	%r8d, %r10d
000000010000b574	shll	$0x6, %r10d
000000010000b578	andl	$0x3f, %ebx
000000010000b57b	orl	%r10d, %ebx
000000010000b57e	cmpl	%edx, %ebx
000000010000b580	jb	0x10000b5af
000000010000b582	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000b589	ja	0x10000b5af
000000010000b58b	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000b592	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000b599	je	0x10000b5af
000000010000b59b	addq	%r9, %rcx
000000010000b59e	incq	%rcx
000000010000b5a1	cmpq	%rsi, %rcx
000000010000b5a4	jb	0x10000b47c
000000010000b5aa	movl	$0x1, %eax
000000010000b5af	popq	%rbx
000000010000b5b0	popq	%rbp
000000010000b5b1	retq
000000010000b5b2	movl	$0x1, %eax
000000010000b5b7	retq
000000010000b5b8	xorl	%eax, %eax
000000010000b5ba	jmp	0x10000b5af
000000010000b5bc	nopl	(%rax)
_fwp_str_new:
000000010000b5c0	pushq	%rbp
000000010000b5c1	movq	%rsp, %rbp
000000010000b5c4	pushq	%r15
000000010000b5c6	pushq	%r14
000000010000b5c8	pushq	%rbx
000000010000b5c9	pushq	%rax
000000010000b5ca	movq	%rsi, %r14
000000010000b5cd	movq	%rdi, %rbx
000000010000b5d0	addq	$0x9, %rsi
000000010000b5d4	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000b5db	ja	0x10000b636
000000010000b5dd	leaq	0x18(%r14), %rax
000000010000b5e1	shrq	$0x4, %rax
000000010000b5e5	leaq	_fwp_gc(%rip), %rcx
000000010000b5ec	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b5f4	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b5fb	subq	%rax, _fwp_gc(%rip)
000000010000b602	js	0x10000b636
000000010000b604	leaq	(%rdx,%rdx,2), %rdx
000000010000b608	leaq	(%rcx,%rdx,8), %rcx
000000010000b60c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b613	movq	(%rcx), %r15
000000010000b616	testq	%r15, %r15
000000010000b619	je	0x10000b626
000000010000b61b	movq	(%r15), %rax
000000010000b61e	notq	%rax
000000010000b621	movq	%rax, (%rcx)
000000010000b624	jmp	0x10000b64f
000000010000b626	movq	0x8(%rcx), %r15
000000010000b62a	movq	0x10(%rcx), %rdx
000000010000b62e	subq	%r15, %rdx
000000010000b631	cmpq	%rax, %rdx
000000010000b634	jae	0x10000b648
000000010000b636	movq	%rsi, %rdi
000000010000b639	movl	$0x1, %esi
000000010000b63e	callq	_fwp_gc_alloc_slow
000000010000b643	movq	%rax, %r15
000000010000b646	jmp	0x10000b657
000000010000b648	addq	%r15, %rax
000000010000b64b	movq	%rax, 0x8(%rcx)
000000010000b64f	movq	%r15, %rdi
000000010000b652	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000b657	movq	%r14, (%r15)
000000010000b65a	leaq	0x8(%r15), %rdi
000000010000b65e	movq	%rbx, %rsi
000000010000b661	movq	%r14, %rdx
000000010000b664	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000b669	movb	$0x0, 0x8(%r15,%r14)
000000010000b66f	movq	%r15, %rax
000000010000b672	addq	$0x8, %rsp
000000010000b676	popq	%rbx
000000010000b677	popq	%r14
000000010000b679	popq	%r15
000000010000b67b	popq	%rbp
000000010000b67c	retq
000000010000b67d	nopl	(%rax)
_buf_put:
000000010000b680	pushq	%rbp
000000010000b681	movq	%rsp, %rbp
000000010000b684	pushq	%r15
000000010000b686	pushq	%r14
000000010000b688	pushq	%r12
000000010000b68a	pushq	%rbx
000000010000b68b	movq	%rdi, %r14
000000010000b68e	movq	0x8(%rdi), %rdi
000000010000b692	cmpq	$-0x1, %rdi
000000010000b696	je	0x10000b738
000000010000b69c	movq	%rdx, %rbx
000000010000b69f	movq	$-0x2, %rax
000000010000b6a6	subq	%rdi, %rax
000000010000b6a9	cmpq	%rdx, %rax
000000010000b6ac	jb	0x10000b738
000000010000b6b2	leaq	(%rbx,%rdi), %rax
000000010000b6b6	incq	%rax
000000010000b6b9	movq	0x10(%r14), %rcx
000000010000b6bd	cmpq	%rcx, %rax
000000010000b6c0	jbe	0x10000b6ef
000000010000b6c2	testq	%rcx, %rcx
000000010000b6c5	movl	$0x40, %r15d
000000010000b6cb	cmovneq	%rcx, %r15
000000010000b6cf	movq	%rsi, %r12
000000010000b6d2	cmpq	%rax, %r15
000000010000b6d5	jae	0x10000b6f7
000000010000b6d7	nopw	(%rax,%rax)
000000010000b6e0	testq	%r15, %r15
000000010000b6e3	js	0x10000b6f4
000000010000b6e5	addq	%r15, %r15
000000010000b6e8	cmpq	%rax, %r15
000000010000b6eb	jb	0x10000b6e0
000000010000b6ed	jmp	0x10000b6f7
000000010000b6ef	movq	(%r14), %rax
000000010000b6f2	jmp	0x10000b715
000000010000b6f4	movq	%rax, %r15
000000010000b6f7	movq	(%r14), %rdi
000000010000b6fa	movq	%r15, %rsi
000000010000b6fd	callq	0x10001151a                     ## symbol stub for: _realloc
000000010000b702	testq	%rax, %rax
000000010000b705	je	0x10000b738
000000010000b707	movq	%rax, (%r14)
000000010000b70a	movq	%r15, 0x10(%r14)
000000010000b70e	movq	0x8(%r14), %rdi
000000010000b712	movq	%r12, %rsi
000000010000b715	addq	%rax, %rdi
000000010000b718	movq	%rbx, %rdx
000000010000b71b	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000b720	addq	0x8(%r14), %rbx
000000010000b724	movq	%rbx, 0x8(%r14)
000000010000b728	movq	(%r14), %rax
000000010000b72b	movb	$0x0, (%rax,%rbx)
000000010000b72f	popq	%rbx
000000010000b730	popq	%r12
000000010000b732	popq	%r14
000000010000b734	popq	%r15
000000010000b736	popq	%rbp
000000010000b737	retq
000000010000b738	movq	0x78f9(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000b73f	movq	(%rax), %rcx
000000010000b742	leaq	0x6576(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000b749	movl	$0x13, %esi
000000010000b74e	movl	$0x1, %edx
000000010000b753	callq	0x1000114a8                     ## symbol stub for: _fwrite
000000010000b758	movl	$0x66, %edi
000000010000b75d	callq	0x100011478                     ## symbol stub for: _exit
000000010000b762	nopw	%cs:(%rax,%rax)
_buf_to_str:
000000010000b770	pushq	%rbp
000000010000b771	movq	%rsp, %rbp
000000010000b774	pushq	%r14
000000010000b776	pushq	%rbx
000000010000b777	movq	%rdi, %rbx
000000010000b77a	movq	(%rdi), %rax
000000010000b77d	movq	0x8(%rdi), %rsi
000000010000b781	testq	%rax, %rax
000000010000b784	leaq	0x63d7(%rip), %rdi              ## literal pool for: ""
000000010000b78b	cmovneq	%rax, %rdi
000000010000b78f	callq	_fwp_str_new
000000010000b794	movq	%rax, %r14
000000010000b797	movq	(%rbx), %rdi
000000010000b79a	callq	0x1000114a2                     ## symbol stub for: _free
000000010000b79f	movq	%r14, %rax
000000010000b7a2	popq	%rbx
000000010000b7a3	popq	%r14
000000010000b7a5	popq	%rbp
000000010000b7a6	retq
000000010000b7a7	nopw	(%rax,%rax)
_fwp_strf:
000000010000b7b0	pushq	%rbp
000000010000b7b1	movq	%rsp, %rbp
000000010000b7b4	pushq	%r15
000000010000b7b6	pushq	%r14
000000010000b7b8	pushq	%r13
000000010000b7ba	pushq	%r12
000000010000b7bc	pushq	%rbx
000000010000b7bd	subq	$0xd8, %rsp
000000010000b7c4	movq	%rsi, -0xf8(%rbp)
000000010000b7cb	movq	%rdx, -0xf0(%rbp)
000000010000b7d2	movq	%rcx, -0xe8(%rbp)
000000010000b7d9	movq	%r8, -0xe0(%rbp)
000000010000b7e0	movq	%r9, -0xd8(%rbp)
000000010000b7e7	testb	%al, %al
000000010000b7e9	je	0x10000b81a
000000010000b7eb	movaps	%xmm0, -0xd0(%rbp)
000000010000b7f2	movaps	%xmm1, -0xc0(%rbp)
000000010000b7f9	movaps	%xmm2, -0xb0(%rbp)
000000010000b800	movaps	%xmm3, -0xa0(%rbp)
000000010000b807	movaps	%xmm4, -0x90(%rbp)
000000010000b80e	movaps	%xmm5, -0x80(%rbp)
000000010000b812	movaps	%xmm6, -0x70(%rbp)
000000010000b816	movaps	%xmm7, -0x60(%rbp)
000000010000b81a	movq	0x780f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b821	movq	(%rax), %rax
000000010000b824	movq	%rax, -0x30(%rbp)
000000010000b828	leaq	-0x100(%rbp), %rax
000000010000b82f	movq	%rax, -0x40(%rbp)
000000010000b833	leaq	0x10(%rbp), %r13
000000010000b837	movq	%r13, -0x48(%rbp)
000000010000b83b	movabsq	$0x3000000008, %r12             ## imm = 0x3000000008
000000010000b845	movq	%r12, -0x50(%rbp)
000000010000b849	leaq	0x6fd5(%rip), %rdx              ## literal pool for: "cannot parse `%.*s` as %s"
000000010000b850	leaq	-0x50(%rbp), %rcx
000000010000b854	xorl	%edi, %edi
000000010000b856	xorl	%esi, %esi
000000010000b858	callq	0x100011586                     ## symbol stub for: _vsnprintf
000000010000b85d	movslq	%eax, %rbx
000000010000b860	leaq	0x1(%rbx), %r14
000000010000b864	cmpq	$0x4000, %r14                   ## imm = 0x4000
000000010000b86b	ja	0x10000b8c6
000000010000b86d	leaq	0x10(%rbx), %rax
000000010000b871	shrq	$0x4, %rax
000000010000b875	leaq	_fwp_gc(%rip), %rcx
000000010000b87c	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b884	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b88b	subq	%rax, _fwp_gc(%rip)
000000010000b892	js	0x10000b8c6
000000010000b894	leaq	(%rdx,%rdx,2), %rdx
000000010000b898	leaq	(%rcx,%rdx,8), %rcx
000000010000b89c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b8a3	movq	(%rcx), %r15
000000010000b8a6	testq	%r15, %r15
000000010000b8a9	je	0x10000b8b6
000000010000b8ab	movq	(%r15), %rax
000000010000b8ae	notq	%rax
000000010000b8b1	movq	%rax, (%rcx)
000000010000b8b4	jmp	0x10000b8df
000000010000b8b6	movq	0x8(%rcx), %r15
000000010000b8ba	movq	0x10(%rcx), %rdx
000000010000b8be	subq	%r15, %rdx
000000010000b8c1	cmpq	%rax, %rdx
000000010000b8c4	jae	0x10000b8d8
000000010000b8c6	movq	%r14, %rdi
000000010000b8c9	movl	$0x1, %esi
000000010000b8ce	callq	_fwp_gc_alloc_slow
000000010000b8d3	movq	%rax, %r15
000000010000b8d6	jmp	0x10000b8ea
000000010000b8d8	addq	%r15, %rax
000000010000b8db	movq	%rax, 0x8(%rcx)
000000010000b8df	movq	%r15, %rdi
000000010000b8e2	movq	%r14, %rsi
000000010000b8e5	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000b8ea	leaq	-0x100(%rbp), %rax
000000010000b8f1	movq	%rax, -0x40(%rbp)
000000010000b8f5	movq	%r13, -0x48(%rbp)
000000010000b8f9	movq	%r12, -0x50(%rbp)
000000010000b8fd	leaq	0x6f21(%rip), %rdx              ## literal pool for: "cannot parse `%.*s` as %s"
000000010000b904	leaq	-0x50(%rbp), %rcx
000000010000b908	movq	%r15, %rdi
000000010000b90b	movq	%r14, %rsi
000000010000b90e	callq	0x100011586                     ## symbol stub for: _vsnprintf
000000010000b913	movq	%r15, %rdi
000000010000b916	movq	%rbx, %rsi
000000010000b919	callq	_fwp_str_new
000000010000b91e	movq	0x770b(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b925	movq	(%rcx), %rcx
000000010000b928	cmpq	-0x30(%rbp), %rcx
000000010000b92c	jne	0x10000b940
000000010000b92e	addq	$0xd8, %rsp
000000010000b935	popq	%rbx
000000010000b936	popq	%r12
000000010000b938	popq	%r13
000000010000b93a	popq	%r14
000000010000b93c	popq	%r15
000000010000b93e	popq	%rbp
000000010000b93f	retq
000000010000b940	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000b945	nopw	%cs:(%rax,%rax)
_tp_value:
000000010000b950	pushq	%rbp
000000010000b951	movq	%rsp, %rbp
000000010000b954	pushq	%r15
000000010000b956	pushq	%r14
000000010000b958	pushq	%r13
000000010000b95a	pushq	%r12
000000010000b95c	pushq	%rbx
000000010000b95d	subq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b964	movq	%rcx, %rbx
000000010000b967	movq	%rsi, %rax
000000010000b96a	movq	0x76bf(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b971	movq	(%rcx), %rcx
000000010000b974	movq	%rcx, -0x30(%rbp)
000000010000b978	testl	%edx, %edx
000000010000b97a	je	0x10000b9e1
000000010000b97c	cmpl	$0xc, (%rax)
000000010000b97f	jne	0x10000b9e1
000000010000b981	movq	0x8(%rdi), %rsi
000000010000b985	movq	0x10(%rdi), %r15
000000010000b989	movq	%rbx, %r12
000000010000b98c	movq	(%rdi), %rax
000000010000b98f	addq	%r15, %rax
000000010000b992	subq	%r15, %rsi
000000010000b995	jne	0x10000ba6c
000000010000b99b	movq	%rdi, %rbx
000000010000b99e	movq	%rax, %rdi
000000010000b9a1	callq	_fwp_str_new
000000010000b9a6	movq	%rax, (%r12)
000000010000b9aa	movq	0x8(%rbx), %rax
000000010000b9ae	movq	%rax, 0x10(%rbx)
000000010000b9b2	movl	$0x1, %r14d
000000010000b9b8	movq	0x7671(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b9bf	movq	(%rax), %rax
000000010000b9c2	cmpq	-0x30(%rbp), %rax
000000010000b9c6	jne	0x10000d1dc
000000010000b9cc	movl	%r14d, %eax
000000010000b9cf	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b9d6	popq	%rbx
000000010000b9d7	popq	%r12
000000010000b9d9	popq	%r13
000000010000b9db	popq	%r14
000000010000b9dd	popq	%r15
000000010000b9df	popq	%rbp
000000010000b9e0	retq
000000010000b9e1	movq	0x8(%rdi), %rsi
000000010000b9e5	movq	0x10(%rdi), %r15
000000010000b9e9	cmpq	%rsi, %r15
000000010000b9ec	jae	0x10000ba20
000000010000b9ee	movq	(%rdi), %rcx
000000010000b9f1	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000b9fb	nopl	(%rax,%rax)
000000010000ba00	movzbl	(%rcx,%r15), %r9d
000000010000ba05	cmpq	$0x20, %r9
000000010000ba09	ja	0x10000ba20
000000010000ba0b	btq	%r9, %r8
000000010000ba0f	jae	0x10000ba20
000000010000ba11	incq	%r15
000000010000ba14	movq	%r15, 0x10(%rdi)
000000010000ba18	cmpq	%r15, %rsi
000000010000ba1b	jne	0x10000ba00
000000010000ba1d	movq	%rsi, %r15
000000010000ba20	movl	(%rax), %ecx
000000010000ba22	xorl	%r14d, %r14d
000000010000ba25	cmpq	$0x15, %rcx
000000010000ba29	ja	0x10000b9b8
000000010000ba2b	leaq	0x17b2(%rip), %r8
000000010000ba32	movslq	(%r8,%rcx,4), %r9
000000010000ba36	addq	%r8, %r9
000000010000ba39	jmpq	*%r9
000000010000ba3c	movq	0x75ed(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000ba43	movq	(%rcx), %rcx
000000010000ba46	cmpq	-0x30(%rbp), %rcx
000000010000ba4a	jne	0x10000d1dc
000000010000ba50	movq	%rax, %rsi
000000010000ba53	movq	%rbx, %rdx
000000010000ba56	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000ba5d	popq	%rbx
000000010000ba5e	popq	%r12
000000010000ba60	popq	%r13
000000010000ba62	popq	%r14
000000010000ba64	popq	%r15
000000010000ba66	popq	%rbp
000000010000ba67	jmp	_tp_int
000000010000ba6c	xorl	%ecx, %ecx
000000010000ba6e	jmp	0x10000ba7c
000000010000ba70	incq	%rcx
000000010000ba73	cmpq	%rsi, %rcx
000000010000ba76	jae	0x10000b99b
000000010000ba7c	movzbl	(%rax,%rcx), %r10d
000000010000ba81	testb	%r10b, %r10b
000000010000ba84	jns	0x10000ba70
000000010000ba86	leal	0x3e(%r10), %edx
000000010000ba8a	cmpb	$0x1e, %dl
000000010000ba8d	jae	0x10000baa2
000000010000ba8f	movl	$0x80, %edx
000000010000ba94	movl	$0x1, %r9d
000000010000ba9a	movl	$0x1f, %r8d
000000010000baa0	jmp	0x10000bade
000000010000baa2	movl	%r10d, %edx
000000010000baa5	andb	$-0x10, %dl
000000010000baa8	cmpb	$-0x20, %dl
000000010000baab	jne	0x10000bac0
000000010000baad	movl	$0x800, %edx                    ## imm = 0x800
000000010000bab2	movl	$0x2, %r9d
000000010000bab8	movl	$0xf, %r8d
000000010000babe	jmp	0x10000bade
000000010000bac0	leal	0x10(%r10), %edx
000000010000bac4	cmpb	$0x4, %dl
000000010000bac7	ja	0x10000d10c
000000010000bacd	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000bad2	movl	$0x3, %r9d
000000010000bad8	movl	$0x7, %r8d
000000010000bade	movl	%r9d, %r9d
000000010000bae1	leaq	(%rcx,%r9), %r11
000000010000bae5	xorl	%r14d, %r14d
000000010000bae8	cmpq	%rsi, %r11
000000010000baeb	jae	0x10000b9b8
000000010000baf1	movzbl	0x1(%rax,%rcx), %r11d
000000010000baf7	movl	%r11d, %ebx
000000010000bafa	andl	$-0x40, %ebx
000000010000bafd	cmpl	$0x80, %ebx
000000010000bb03	jne	0x10000b9b8
000000010000bb09	andl	%r10d, %r8d
000000010000bb0c	leal	0x1(%r9), %ebx
000000010000bb10	movl	%r8d, %r10d
000000010000bb13	shll	$0x6, %r10d
000000010000bb17	andl	$0x3f, %r11d
000000010000bb1b	orl	%r10d, %r11d
000000010000bb1e	cmpl	$0x2, %ebx
000000010000bb21	jne	0x10000bb28
000000010000bb23	movl	%r11d, %ebx
000000010000bb26	jmp	0x10000bb83
000000010000bb28	movzbl	0x2(%rax,%rcx), %r8d
000000010000bb2e	movl	%r8d, %r10d
000000010000bb31	andl	$-0x40, %r10d
000000010000bb35	cmpl	$0x80, %r10d
000000010000bb3c	jne	0x10000b9b8
000000010000bb42	movl	%r11d, %r10d
000000010000bb45	shll	$0x6, %r10d
000000010000bb49	andl	$0x3f, %r8d
000000010000bb4d	orl	%r10d, %r8d
000000010000bb50	cmpl	$0x3, %ebx
000000010000bb53	jne	0x10000bb5d
000000010000bb55	movl	%r8d, %ebx
000000010000bb58	movl	%r11d, %r8d
000000010000bb5b	jmp	0x10000bb83
000000010000bb5d	movzbl	0x3(%rax,%rcx), %ebx
000000010000bb62	movl	%ebx, %r10d
000000010000bb65	andl	$-0x40, %r10d
000000010000bb69	cmpl	$0x80, %r10d
000000010000bb70	jne	0x10000b9b8
000000010000bb76	movl	%r8d, %r10d
000000010000bb79	shll	$0x6, %r10d
000000010000bb7d	andl	$0x3f, %ebx
000000010000bb80	orl	%r10d, %ebx
000000010000bb83	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000bb8a	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000bb91	je	0x10000b9b8
000000010000bb97	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000bb9e	ja	0x10000b9b8
000000010000bba4	cmpl	%edx, %ebx
000000010000bba6	jb	0x10000b9b8
000000010000bbac	addq	%r9, %rcx
000000010000bbaf	incq	%rcx
000000010000bbb2	cmpq	%rsi, %rcx
000000010000bbb5	jb	0x10000ba7c
000000010000bbbb	jmp	0x10000b99b
000000010000bbc0	movdqu	0x38(%rax), %xmm0
000000010000bbc5	movdqa	%xmm0, -0x130(%rbp)
000000010000bbcd	xorl	%edx, %edx
000000010000bbcf	cmpl	$0x13, %ecx
000000010000bbd2	sete	%dl
000000010000bbd5	pxor	%xmm0, %xmm0
000000010000bbd9	movdqa	%xmm0, -0x120(%rbp)
000000010000bbe1	movq	$0x0, -0x110(%rbp)
000000010000bbec	movl	%edx, -0x108(%rbp)
000000010000bbf2	leaq	0x6c68(%rip), %rdx              ## literal pool for: "set"
000000010000bbf9	leaq	0x6c65(%rip), %rcx              ## literal pool for: "map"
000000010000bc00	cmoveq	%rdx, %rcx
000000010000bc04	cmpq	%rsi, %r15
000000010000bc07	jae	0x10000bc40
000000010000bc09	movq	(%rdi), %rdx
000000010000bc0c	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000bc16	nopw	%cs:(%rax,%rax)
000000010000bc20	movzbl	(%rdx,%r15), %r9d
000000010000bc25	cmpq	$0x20, %r9
000000010000bc29	ja	0x10000bc40
000000010000bc2b	btq	%r9, %r8
000000010000bc2f	jae	0x10000bc40
000000010000bc31	incq	%r15
000000010000bc34	movq	%r15, 0x10(%rdi)
000000010000bc38	cmpq	%r15, %rsi
000000010000bc3b	jne	0x10000bc20
000000010000bc3d	movq	%rsi, %r15
000000010000bc40	subq	%r15, %rsi
000000010000bc43	xorl	%r14d, %r14d
000000010000bc46	cmpq	$0x3, %rsi
000000010000bc4a	jb	0x10000b9b8
000000010000bc50	movq	(%rdi), %rdx
000000010000bc53	movzwl	(%rdx,%r15), %esi
000000010000bc58	xorw	(%rcx), %si
000000010000bc5b	movzbl	0x2(%rdx,%r15), %edx
000000010000bc61	xorb	0x2(%rcx), %dl
000000010000bc64	movzbl	%dl, %ecx
000000010000bc67	orw	%si, %cx
000000010000bc6a	jne	0x10000b9b8
000000010000bc70	movq	%rbx, %r12
000000010000bc73	movq	%rax, %rbx
000000010000bc76	addq	$0x3, %r15
000000010000bc7a	movq	%r15, 0x10(%rdi)
000000010000bc7e	leaq	0x6be4(%rip), %rsi              ## literal pool for: "{"
000000010000bc85	leaq	0x6bdf(%rip), %rdx              ## literal pool for: "}"
000000010000bc8c	leaq	_tp_kv_item(%rip), %rcx
000000010000bc93	leaq	-0x130(%rbp), %r8
000000010000bc9a	callq	_tp_list_of
000000010000bc9f	testl	%eax, %eax
000000010000bca1	je	0x10000c82d
000000010000bca7	cmpq	$0x0, -0x118(%rbp)
000000010000bcaf	je	0x10000caea
000000010000bcb5	leaq	_fwp_empty_map(%rip), %rax
000000010000bcbc	xorl	%r14d, %r14d
000000010000bcbf	movq	-0x120(%rbp), %rcx
000000010000bcc6	movq	(%rcx,%r14,8), %rdi
000000010000bcca	movq	0x8(%rcx,%r14,8), %rsi
000000010000bccf	movq	0x38(%rbx), %rcx
000000010000bcd3	movq	%rax, %rdx
000000010000bcd6	callq	_fwp_p_map_insert
000000010000bcdb	addq	$0x2, %r14
000000010000bcdf	cmpq	-0x118(%rbp), %r14
000000010000bce6	jb	0x10000bcbf
000000010000bce8	jmp	0x10000caf1
000000010000bced	pxor	%xmm0, %xmm0
000000010000bcf1	movdqu	%xmm0, -0x118(%rbp)
000000010000bcf9	movdqu	%xmm0, -0x128(%rbp)
000000010000bd01	movq	$0x0, -0x108(%rbp)
000000010000bd0c	movq	0x38(%rax), %rdx
000000010000bd10	movq	%rdx, -0x130(%rbp)
000000010000bd17	cmpl	$0x11, %ecx
000000010000bd1a	jne	0x10000bd85
000000010000bd1c	cmpq	%rsi, %r15
000000010000bd1f	jae	0x10000bd50
000000010000bd21	movq	(%rdi), %rcx
000000010000bd24	movabsq	$0x100002600, %rdx              ## imm = 0x100002600
000000010000bd2e	nop
000000010000bd30	movzbl	(%rcx,%r15), %r8d
000000010000bd35	cmpq	$0x20, %r8
000000010000bd39	ja	0x10000bd50
000000010000bd3b	btq	%r8, %rdx
000000010000bd3f	jae	0x10000bd50
000000010000bd41	incq	%r15
000000010000bd44	movq	%r15, 0x10(%rdi)
000000010000bd48	cmpq	%r15, %rsi
000000010000bd4b	jne	0x10000bd30
000000010000bd4d	movq	%rsi, %r15
000000010000bd50	subq	%r15, %rsi
000000010000bd53	xorl	%r14d, %r14d
000000010000bd56	cmpq	$0x5, %rsi
000000010000bd5a	jb	0x10000b9b8
000000010000bd60	movq	(%rdi), %rcx
000000010000bd63	movl	$0x61727261, %edx               ## imm = 0x61727261
000000010000bd68	xorl	(%rcx,%r15), %edx
000000010000bd6c	movzbl	0x4(%rcx,%r15), %ecx
000000010000bd72	xorl	$0x79, %ecx
000000010000bd75	orl	%edx, %ecx
000000010000bd77	jne	0x10000b9b8
000000010000bd7d	addq	$0x5, %r15
000000010000bd81	movq	%r15, 0x10(%rdi)
000000010000bd85	movq	%rax, -0x1d0(%rbp)
000000010000bd8c	leaq	0x6abe(%rip), %rsi              ## literal pool for: "["
000000010000bd93	leaq	0x6ab9(%rip), %rdx              ## literal pool for: "]"
000000010000bd9a	leaq	_tp_elem_item(%rip), %rcx
000000010000bda1	leaq	-0x130(%rbp), %r8
000000010000bda8	callq	_tp_list_of
000000010000bdad	movq	-0x120(%rbp), %r14
000000010000bdb4	testl	%eax, %eax
000000010000bdb6	je	0x10000c292
000000010000bdbc	movq	%rbx, -0x1e8(%rbp)
000000010000bdc3	movq	-0x118(%rbp), %rbx
000000010000bdca	testq	%rbx, %rbx
000000010000bdcd	je	0x10000c3f0
000000010000bdd3	xorl	%r15d, %r15d
000000010000bdd6	leaq	-0x1b0(%rbp), %r13
000000010000bddd	nopl	(%rax)
000000010000bde0	movq	-0x8(%r14,%rbx,8), %r12
000000010000bde5	movq	%r12, -0x1b0(%rbp)
000000010000bdec	movq	%r15, -0x1a8(%rbp)
000000010000bdf3	movl	$0x18, %edi
000000010000bdf8	callq	_fwp_alloc_init
000000010000bdfd	movabsq	$0x200000001, %rcx              ## imm = 0x200000001
000000010000be07	movq	%rcx, (%rax)
000000010000be0a	movq	%r12, 0x8(%rax)
000000010000be0e	movq	%r15, 0x10(%rax)
000000010000be12	movq	%rax, %r15
000000010000be15	decq	%rbx
000000010000be18	jne	0x10000bde0
000000010000be1a	jmp	0x10000c3f2
000000010000be1f	movq	%rbx, %r15
000000010000be22	movq	%rax, %rbx
000000010000be25	leaq	-0x130(%rbp), %rsi
000000010000be2c	movl	$0x80, %edx
000000010000be31	callq	_tp_token
000000010000be36	xorl	%r14d, %r14d
000000010000be39	cmpq	$0x7f, %rax
000000010000be3d	ja	0x10000b9b8
000000010000be43	movl	-0x130(%rbp), %edx
000000010000be49	cmpl	$0x666e69, %edx                 ## imm = 0x666E69
000000010000be4f	jne	0x10000c25c
000000010000be55	movsd	0x58d3(%rip), %xmm0
000000010000be5d	movq	%rbx, %rcx
000000010000be60	jmp	0x10000c846
000000010000be65	testl	%edx, %edx
000000010000be67	jne	0x10000b989
000000010000be6d	movq	0x71bc(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000be74	movq	(%rax), %rax
000000010000be77	cmpq	-0x30(%rbp), %rax
000000010000be7b	jne	0x10000d1dc
000000010000be81	movq	%rbx, %rsi
000000010000be84	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000be8b	popq	%rbx
000000010000be8c	popq	%r12
000000010000be8e	popq	%r13
000000010000be90	popq	%r14
000000010000be92	popq	%r15
000000010000be94	popq	%rbp
000000010000be95	jmp	_tp_quoted
000000010000be9a	pxor	%xmm0, %xmm0
000000010000be9e	movdqa	%xmm0, -0x110(%rbp)
000000010000bea6	movdqa	%xmm0, -0x120(%rbp)
000000010000beae	movdqa	%xmm0, -0x130(%rbp)
000000010000beb6	cmpq	%rsi, %r15
000000010000beb9	jae	0x10000bef0
000000010000bebb	movq	(%rdi), %rax
000000010000bebe	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000bec8	nopl	(%rax,%rax)
000000010000bed0	movzbl	(%rax,%r15), %edx
000000010000bed5	cmpq	$0x20, %rdx
000000010000bed9	ja	0x10000bef0
000000010000bedb	btq	%rdx, %rcx
000000010000bedf	jae	0x10000bef0
000000010000bee1	incq	%r15
000000010000bee4	movq	%r15, 0x10(%rdi)
000000010000bee8	cmpq	%r15, %rsi
000000010000beeb	jne	0x10000bed0
000000010000beed	movq	%rsi, %r15
000000010000bef0	subq	%r15, %rsi
000000010000bef3	xorl	%r14d, %r14d
000000010000bef6	cmpq	$0x5, %rsi
000000010000befa	jb	0x10000bf19
000000010000befc	movq	(%rdi), %rax
000000010000beff	movl	$0x65747962, %ecx               ## imm = 0x65747962
000000010000bf04	xorl	(%rax,%r15), %ecx
000000010000bf08	movzbl	0x4(%rax,%r15), %eax
000000010000bf0e	xorl	$0x73, %eax
000000010000bf11	orl	%ecx, %eax
000000010000bf13	je	0x10000c77a
000000010000bf19	xorl	%edi, %edi
000000010000bf1b	callq	_fwp_mem_free
000000010000bf20	jmp	0x10000b9b8
000000010000bf25	movq	%rbx, %r15
000000010000bf28	movq	%rax, %rbx
000000010000bf2b	leaq	-0x130(%rbp), %rsi
000000010000bf32	movl	$0x100, %edx                    ## imm = 0x100
000000010000bf37	callq	_tp_token
000000010000bf3c	xorl	%r14d, %r14d
000000010000bf3f	cmpq	$0x2, %rax
000000010000bf43	jb	0x10000b9b8
000000010000bf49	cmpb	$0x30, -0x130(%rbp)
000000010000bf50	jne	0x10000b9b8
000000010000bf56	cmpb	$0x74, -0x12f(%rbp)
000000010000bf5d	jne	0x10000b9b8
000000010000bf63	leaq	-0x2(%rax), %rcx
000000010000bf67	movslq	0x48(%rbx), %rdx
000000010000bf6b	cmpq	%rdx, %rcx
000000010000bf6e	ja	0x10000b9b8
000000010000bf74	cmpq	$0x3, %rax
000000010000bf78	jb	0x10000c966
000000010000bf7e	movl	$0x2, %edx
000000010000bf83	xorl	%ecx, %ecx
000000010000bf85	movq	%r15, %rdi
000000010000bf88	jmp	0x10000c1cb
000000010000bf8d	leaq	-0x130(%rbp), %rsi
000000010000bf94	movl	$0x10, %edx
000000010000bf99	callq	_tp_token
000000010000bf9e	movzwl	-0x130(%rbp), %eax
000000010000bfa5	movl	%eax, %ecx
000000010000bfa7	xorl	$0x312b, %ecx                   ## imm = 0x312B
000000010000bfad	movzbl	-0x12e(%rbp), %edx
000000010000bfb4	orw	%cx, %dx
000000010000bfb7	sete	%cl
000000010000bfba	cmpw	$0x31, %ax
000000010000bfbe	sete	%dl
000000010000bfc1	orb	%cl, %dl
000000010000bfc3	movl	$0x1, %r14d
000000010000bfc9	jne	0x10000bff6
000000010000bfcb	xorl	%r14d, %r14d
000000010000bfce	cmpw	$0x30, %ax
000000010000bfd2	je	0x10000bff6
000000010000bfd4	movl	$0x312d, %eax                   ## imm = 0x312D
000000010000bfd9	xorl	-0x130(%rbp), %eax
000000010000bfdf	movzbl	-0x12e(%rbp), %ecx
000000010000bfe6	orw	%ax, %cx
000000010000bfe9	jne	0x10000b9b8
000000010000bfef	movq	$-0x1, %r14
000000010000bff6	movq	%r14, (%rbx)
000000010000bff9	jmp	0x10000b9b2
000000010000bffe	movq	0x8(%rax), %r13
000000010000c002	testq	%r13, %r13
000000010000c005	movq	%rbx, -0x1e8(%rbp)
000000010000c00c	je	0x10000c2a2
000000010000c012	movq	%rsi, %rbx
000000010000c015	movq	%rdi, -0x1c8(%rbp)
000000010000c01c	movq	%rax, -0x1d0(%rbp)
000000010000c023	leaq	0x6843(%rip), %rsi              ## literal pool for: "Duration"
000000010000c02a	movq	%r13, %rdi
000000010000c02d	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000c032	testl	%eax, %eax
000000010000c034	je	0x10000c61e
000000010000c03a	movq	-0x1d0(%rbp), %rax
000000010000c041	movl	0x10(%rax), %r9d
000000010000c045	cmpq	%rbx, %r15
000000010000c048	movq	-0x1c8(%rbp), %rdx
000000010000c04f	movq	%r9, -0x1d8(%rbp)
000000010000c056	jae	0x10000c088
000000010000c058	movq	%rbx, %rcx
000000010000c05b	movq	(%rdx), %rsi
000000010000c05e	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
000000010000c068	movzbl	(%rsi,%r15), %r8d
000000010000c06d	cmpq	$0x20, %r8
000000010000c071	ja	0x10000c088
000000010000c073	btq	%r8, %rdi
000000010000c077	jae	0x10000c088
000000010000c079	incq	%r15
000000010000c07c	movq	%r15, 0x10(%rdx)
000000010000c080	cmpq	%r15, %rcx
000000010000c083	jne	0x10000c068
000000010000c085	movq	%rcx, %r15
000000010000c088	addq	$0x10, %rax
000000010000c08c	movq	%rax, -0x1c0(%rbp)
000000010000c093	movq	%r13, %rdi
000000010000c096	callq	0x100011556                     ## symbol stub for: _strlen
000000010000c09b	subq	%r15, %rbx
000000010000c09e	cmpq	%rax, %rbx
000000010000c0a1	jb	0x10000c0c6
000000010000c0a3	movq	%rax, %r12
000000010000c0a6	movq	-0x1c8(%rbp), %rax
000000010000c0ad	movq	(%rax), %rdi
000000010000c0b0	addq	%r15, %rdi
000000010000c0b3	movq	%r13, %rsi
000000010000c0b6	movq	%r12, %rdx
000000010000c0b9	callq	0x1000114d2                     ## symbol stub for: _memcmp
000000010000c0be	testl	%eax, %eax
000000010000c0c0	je	0x10000ccd8
000000010000c0c6	movq	-0x1d0(%rbp), %rax
000000010000c0cd	movq	-0x1c8(%rbp), %rdi
000000010000c0d4	movq	-0x1c0(%rbp), %r13
000000010000c0db	movq	-0x1d8(%rbp), %rcx
000000010000c0e2	movslq	%ecx, %rcx
000000010000c0e5	leaq	0x8(,%rcx,8), %rcx
000000010000c0ed	leaq	_fwp_gc(%rip), %r12
000000010000c0f4	cmpq	$0x4000, %rcx                   ## imm = 0x4000
000000010000c0fb	ja	0x10000c876
000000010000c101	leaq	0xf(%rcx), %rdx
000000010000c105	shrq	$0x4, %rdx
000000010000c109	movzbl	0xbe8(%rdx,%r12), %edx
000000010000c112	movl	0xb48(%r12,%rdx,4), %esi
000000010000c11a	subq	%rsi, _fwp_gc(%rip)
000000010000c121	js	0x10000c876
000000010000c127	leaq	(%rdx,%rdx,2), %rdx
000000010000c12b	leaq	(%r12,%rdx,8), %rdx
000000010000c12f	addq	$0x788, %rdx                    ## imm = 0x788
000000010000c136	movq	(%rdx), %r8
000000010000c139	testq	%r8, %r8
000000010000c13c	je	0x10000c862
000000010000c142	movq	%rdi, %r15
000000010000c145	movq	%rax, %rbx
000000010000c148	movq	(%r8), %rax
000000010000c14b	notq	%rax
000000010000c14e	movq	%rax, (%rdx)
000000010000c151	movq	%r8, -0x1e0(%rbp)
000000010000c158	movq	%r8, %rdi
000000010000c15b	jmp	0x10000c990
000000010000c160	movq	(%rdi), %r8
000000010000c163	cmpq	%rsi, %r15
000000010000c166	movq	%rdi, -0x1c8(%rbp)
000000010000c16d	movl	%edx, -0x1d8(%rbp)
000000010000c173	movq	%rbx, -0x1e8(%rbp)
000000010000c17a	jae	0x10000c1f5
000000010000c17c	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000c186	nopw	%cs:(%rax,%rax)
000000010000c190	movzbl	(%r8,%r15), %r9d
000000010000c195	cmpq	$0x20, %r9
000000010000c199	ja	0x10000c1f5
000000010000c19b	btq	%r9, %rcx
000000010000c19f	jae	0x10000c1f5
000000010000c1a1	incq	%r15
000000010000c1a4	movq	%r15, 0x10(%rdi)
000000010000c1a8	cmpq	%r15, %rsi
000000010000c1ab	jne	0x10000c190
000000010000c1ad	movq	%rax, %rbx
000000010000c1b0	movq	%rsi, %r15
000000010000c1b3	jmp	0x10000c46e
000000010000c1b8	leaq	(%rcx,%rcx,2), %rcx
000000010000c1bc	decq	%rcx
000000010000c1bf	incq	%rdx
000000010000c1c2	cmpq	%rdx, %rax
000000010000c1c5	je	0x10000c970
000000010000c1cb	movzbl	-0x130(%rbp,%rdx), %esi
000000010000c1d3	cmpl	$0x30, %esi
000000010000c1d6	je	0x10000c1ef
000000010000c1d8	cmpl	$0x2d, %esi
000000010000c1db	je	0x10000c1b8
000000010000c1dd	cmpl	$0x2b, %esi
000000010000c1e0	jne	0x10000d10c
000000010000c1e6	leaq	(%rcx,%rcx,2), %rcx
000000010000c1ea	incq	%rcx
000000010000c1ed	jmp	0x10000c1bf
000000010000c1ef	leaq	(%rcx,%rcx,2), %rcx
000000010000c1f3	jmp	0x10000c1bf
000000010000c1f5	cmpq	%rsi, %r15
000000010000c1f8	jae	0x10000c3e5
000000010000c1fe	movabsq	$0x4000000000003, %r9           ## imm = 0x4000000000003
000000010000c208	movq	%r15, %rcx
000000010000c20b	jmp	0x10000c220
000000010000c20d	nopl	(%rax)
000000010000c210	incq	%rcx
000000010000c213	movq	%rcx, 0x10(%rdi)
000000010000c217	cmpq	%rcx, %rsi
000000010000c21a	je	0x10000c46b
000000010000c220	movzbl	(%r8,%rcx), %r10d
000000010000c225	leal	-0x30(%r10), %r11d
000000010000c229	cmpb	$0xa, %r11b
000000010000c22d	jb	0x10000c210
000000010000c22f	movl	%r10d, %r11d
000000010000c232	andb	$-0x21, %r11b
000000010000c236	addb	$-0x41, %r11b
000000010000c23a	cmpb	$0x1a, %r11b
000000010000c23e	jb	0x10000c210
000000010000c240	movzbl	%r10b, %r10d
000000010000c244	addl	$-0x2d, %r10d
000000010000c248	cmpl	$0x32, %r10d
000000010000c24c	ja	0x10000c254
000000010000c24e	btq	%r10, %r9
000000010000c252	jb	0x10000c210
000000010000c254	movq	%rax, %rbx
000000010000c257	jmp	0x10000c471
000000010000c25c	movl	$0x666e692d, %ecx               ## imm = 0x666E692D
000000010000c261	xorl	-0x130(%rbp), %ecx
000000010000c267	movzbl	-0x12c(%rbp), %esi
000000010000c26e	orl	%ecx, %esi
000000010000c270	movq	%rbx, %rcx
000000010000c273	je	0x10000c83e
000000010000c279	cmpl	$0x4e614e, %edx                 ## imm = 0x4E614E
000000010000c27f	jne	0x10000c895
000000010000c285	movsd	0x54b3(%rip), %xmm0
000000010000c28d	jmp	0x10000c846
000000010000c292	movq	%r14, %rdi
000000010000c295	callq	_fwp_mem_free
000000010000c29a	xorl	%r14d, %r14d
000000010000c29d	jmp	0x10000b9b8
000000010000c2a2	movslq	0x10(%rax), %rcx
000000010000c2a6	testq	%rcx, %rcx
000000010000c2a9	je	0x10000c910
000000010000c2af	leaq	0x10(%rax), %r13
000000010000c2b3	cmpl	$0x0, 0x48(%rax)
000000010000c2b7	je	0x10000c0e2
000000010000c2bd	movq	%r13, -0x1c0(%rbp)
000000010000c2c4	movq	%rax, %rbx
000000010000c2c7	shlq	$0x3, %rcx
000000010000c2cb	movq	%rdi, %r13
000000010000c2ce	movq	%rcx, %rdi
000000010000c2d1	callq	_fwp_alloc
000000010000c2d6	movq	%rax, -0x1d8(%rbp)
000000010000c2dd	leaq	0x65a3(%rip), %rsi              ## literal pool for: "("
000000010000c2e4	movq	%r13, %r12
000000010000c2e7	movq	%r13, %rdi
000000010000c2ea	callq	_tp_eat
000000010000c2ef	testl	%eax, %eax
000000010000c2f1	je	0x10000b9b8
000000010000c2f7	movq	-0x1c0(%rbp), %rax
000000010000c2fe	cmpl	$0x0, (%rax)
000000010000c301	movq	%r12, %rdi
000000010000c304	jle	0x10000c3b1
000000010000c30a	xorl	%r13d, %r13d
000000010000c30d	movabsq	$0x100002600, %r15              ## imm = 0x100002600
000000010000c317	testq	%r13, %r13
000000010000c31a	je	0x10000c370
000000010000c31c	movq	0x8(%rdi), %rcx
000000010000c320	movq	0x10(%rdi), %rax
000000010000c324	cmpq	%rcx, %rax
000000010000c327	jae	0x10000c350
000000010000c329	movq	(%rdi), %rdx
000000010000c32c	movzbl	(%rdx,%rax), %esi
000000010000c330	cmpq	$0x20, %rsi
000000010000c334	ja	0x10000c350
000000010000c336	btq	%rsi, %r15
000000010000c33a	jae	0x10000c350
000000010000c33c	incq	%rax
000000010000c33f	movq	%rax, 0x10(%rdi)
000000010000c343	xorl	%r14d, %r14d
000000010000c346	cmpq	%rax, %rcx
000000010000c349	jne	0x10000c32c
000000010000c34b	jmp	0x10000b9b8
000000010000c350	xorl	%r14d, %r14d
000000010000c353	cmpq	%rax, %rcx
000000010000c356	je	0x10000b9b8
000000010000c35c	movq	(%rdi), %rcx
000000010000c35f	cmpb	$0x2c, (%rcx,%rax)
000000010000c363	jne	0x10000b9b8
000000010000c369	incq	%rax
000000010000c36c	movq	%rax, 0x10(%rdi)
000000010000c370	movq	0x20(%rbx), %rax
000000010000c374	movq	(%rax,%r13,8), %rsi
000000010000c378	movq	-0x1d8(%rbp), %rax
000000010000c37f	leaq	(%rax,%r13,8), %rcx
000000010000c383	xorl	%r14d, %r14d
000000010000c386	movq	%r12, %rdi
000000010000c389	xorl	%edx, %edx
000000010000c38b	callq	_tp_value
000000010000c390	testl	%eax, %eax
000000010000c392	je	0x10000b9b8
000000010000c398	movq	%r12, %rdi
000000010000c39b	incq	%r13
000000010000c39e	movq	-0x1c0(%rbp), %rax
000000010000c3a5	movslq	(%rax), %rax
000000010000c3a8	cmpq	%rax, %r13
000000010000c3ab	jl	0x10000c317
000000010000c3b1	leaq	0x64d1(%rip), %rsi              ## literal pool for: ")"
000000010000c3b8	callq	_tp_eat
000000010000c3bd	movl	$0x0, %r14d
000000010000c3c3	testl	%eax, %eax
000000010000c3c5	je	0x10000b9b8
000000010000c3cb	movq	-0x1c0(%rbp), %rax
000000010000c3d2	movl	(%rax), %edi
000000010000c3d4	movq	-0x1d8(%rbp), %rsi
000000010000c3db	callq	_fwp_record
000000010000c3e0	jmp	0x10000cdb2
000000010000c3e5	movq	%rax, %rbx
000000010000c3e8	movq	%r15, %rcx
000000010000c3eb	jmp	0x10000c471
000000010000c3f0	xorl	%eax, %eax
000000010000c3f2	movq	%rax, %rbx
000000010000c3f5	movq	-0x120(%rbp), %rdi
000000010000c3fc	callq	_fwp_mem_free
000000010000c401	movq	-0x1d0(%rbp), %rax
000000010000c408	cmpl	$0x11, (%rax)
000000010000c40b	jne	0x10000c463
000000010000c40d	movq	0x38(%rax), %r14
000000010000c411	testq	%rbx, %rbx
000000010000c414	je	0x10000c94a
000000010000c41a	movq	%rbx, %rax
000000010000c41d	xorl	%edi, %edi
000000010000c41f	nop
000000010000c420	incq	%rdi
000000010000c423	movq	0x10(%rax), %rax
000000010000c427	testq	%rax, %rax
000000010000c42a	jne	0x10000c420
000000010000c42c	movq	%r14, %rsi
000000010000c42f	callq	_fwp_array_new_packed
000000010000c434	movq	%rax, %r15
000000010000c437	xorl	%r12d, %r12d
000000010000c43a	movq	%rbx, %r13
000000010000c43d	nopl	(%rax)
000000010000c440	movq	0x8(%r13), %rdx
000000010000c444	movq	%r15, %rdi
000000010000c447	movq	%r12, %rsi
000000010000c44a	movq	%r14, %rcx
000000010000c44d	callq	_fwp_array_store
000000010000c452	incq	%r12
000000010000c455	movq	0x10(%r13), %r13
000000010000c459	testq	%r13, %r13
000000010000c45c	jne	0x10000c440
000000010000c45e	jmp	0x10000c957
000000010000c463	movq	%rbx, %r15
000000010000c466	jmp	0x10000c957
000000010000c46b	movq	%rax, %rbx
000000010000c46e	movq	%rsi, %rcx
000000010000c471	subq	%r15, %rcx
000000010000c474	cmpq	$0xff, %rcx
000000010000c47b	movl	$0xff, %r14d
000000010000c481	cmovbq	%rcx, %r14
000000010000c485	addq	%r15, %r8
000000010000c488	leaq	-0x130(%rbp), %rdi
000000010000c48f	movl	$0x100, %ecx                    ## imm = 0x100
000000010000c494	movq	%r8, %rsi
000000010000c497	movq	%r14, %rdx
000000010000c49a	callq	0x10001142a                     ## symbol stub for: ___memcpy_chk
000000010000c49f	movb	$0x0, -0x130(%rbp,%r14)
000000010000c4a8	movslq	0x10(%rbx), %r12
000000010000c4ac	testq	%r12, %r12
000000010000c4af	movq	%rbx, -0x1d0(%rbp)
000000010000c4b6	jle	0x10000c4ed
000000010000c4b8	movq	0x18(%rbx), %r13
000000010000c4bc	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c4c1	xorl	%r15d, %r15d
000000010000c4c4	leaq	-0x130(%rbp), %r14
000000010000c4cb	nopl	(%rax,%rax)
000000010000c4d0	movq	(%r13,%r15,8), %rdi
000000010000c4d5	movq	%r14, %rsi
000000010000c4d8	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000c4dd	testl	%eax, %eax
000000010000c4df	cmovel	%r15d, %ebx
000000010000c4e3	incq	%r15
000000010000c4e6	cmpq	%r15, %r12
000000010000c4e9	jne	0x10000c4d0
000000010000c4eb	jmp	0x10000c4f2
000000010000c4ed	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c4f2	cmpl	$0x0, -0x1d8(%rbp)
000000010000c4f9	je	0x10000c576
000000010000c4fb	testl	%ebx, %ebx
000000010000c4fd	movq	-0x1c8(%rbp), %r13
000000010000c504	jns	0x10000c56d
000000010000c506	movq	-0x1d0(%rbp), %rax
000000010000c50d	movq	0x8(%rax), %rdi
000000010000c511	xorl	%r14d, %r14d
000000010000c514	testq	%rdi, %rdi
000000010000c517	je	0x10000b9b8
000000010000c51d	leaq	0x631b(%rip), %rsi              ## literal pool for: "Bool"
000000010000c524	movq	%rax, %r12
000000010000c527	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000c52c	testl	%eax, %eax
000000010000c52e	jne	0x10000b9b8
000000010000c534	movq	%r12, %rdx
000000010000c537	movl	-0x130(%rbp), %eax
000000010000c53d	movl	%eax, %esi
000000010000c53f	xorl	$0x65757274, %esi               ## imm = 0x65757274
000000010000c545	movzbl	-0x12c(%rbp), %edi
000000010000c54c	orl	%esi, %edi
000000010000c54e	movl	$0x1, %esi
000000010000c553	cmovel	%esi, %ebx
000000010000c556	xorl	$0x736c6166, %eax               ## imm = 0x736C6166
000000010000c55b	movzwl	-0x12c(%rbp), %esi
000000010000c562	xorl	$0x65, %esi
000000010000c565	orl	%eax, %esi
000000010000c567	jne	0x10000c584
000000010000c569	xorl	%ebx, %ebx
000000010000c56b	jmp	0x10000c58c
000000010000c56d	movq	-0x1d0(%rbp), %rdx
000000010000c574	jmp	0x10000c584
000000010000c576	movq	-0x1d0(%rbp), %rdx
000000010000c57d	movq	-0x1c8(%rbp), %r13
000000010000c584	testl	%ebx, %ebx
000000010000c586	js	0x10000d10c
000000010000c58c	movq	0x28(%rdx), %rax
000000010000c590	movl	%ebx, %esi
000000010000c592	movq	%rsi, -0x1d8(%rbp)
000000010000c599	movslq	(%rax,%rsi,4), %r15
000000010000c59d	movl	%r15d, %r9d
000000010000c5a0	leaq	0x8(,%r15,8), %rdi
000000010000c5a8	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000c5af	movq	%r9, -0x1e0(%rbp)
000000010000c5b6	ja	0x10000c8f7
000000010000c5bc	leaq	0xf(%rdi), %rsi
000000010000c5c0	shrq	$0x4, %rsi
000000010000c5c4	leaq	_fwp_gc(%rip), %rax
000000010000c5cb	movzbl	0xbe8(%rsi,%rax), %r8d
000000010000c5d4	movl	0xb48(%rax,%r8,4), %esi
000000010000c5dc	subq	%rsi, _fwp_gc(%rip)
000000010000c5e3	js	0x10000c8f7
000000010000c5e9	leaq	(%r8,%r8,2), %r8
000000010000c5ed	leaq	(%rax,%r8,8), %rax
000000010000c5f1	addq	$0x788, %rax                    ## imm = 0x788
000000010000c5f7	movq	(%rax), %r8
000000010000c5fa	testq	%r8, %r8
000000010000c5fd	je	0x10000c8e3
000000010000c603	movq	%rdx, %r14
000000010000c606	movq	(%r8), %rcx
000000010000c609	notq	%rcx
000000010000c60c	movq	%rcx, (%rax)
000000010000c60f	movq	%r8, -0x1c0(%rbp)
000000010000c616	movq	%r8, %rdi
000000010000c619	jmp	0x10000cb26
000000010000c61e	leaq	-0x130(%rbp), %rsi
000000010000c625	movl	$0x80, %edx
000000010000c62a	movq	-0x1c8(%rbp), %rdi
000000010000c631	callq	_tp_token
000000010000c636	movq	%rax, %r14
000000010000c639	addq	%rbp, %rax
000000010000c63c	addq	$-0x130, %rax                   ## imm = 0xFED0
000000010000c642	movq	%rax, -0x1d0(%rbp)
000000010000c649	xorl	%ebx, %ebx
000000010000c64b	jmp	0x10000c65a
000000010000c64d	incq	%rbx
000000010000c650	cmpq	$0x6, %rbx
000000010000c654	je	0x10000d10c
000000010000c65a	movq	%rbx, %r12
000000010000c65d	shlq	$0x4, %r12
000000010000c661	leaq	_tp_value.units(%rip), %rax
000000010000c668	movq	(%r12,%rax), %r15
000000010000c66c	movq	%r15, %rdi
000000010000c66f	callq	0x100011556                     ## symbol stub for: _strlen
000000010000c674	movq	%r14, %r13
000000010000c677	subq	%rax, %r13
000000010000c67a	jbe	0x10000c64d
000000010000c67c	movq	-0x1d0(%rbp), %rdi
000000010000c683	subq	%rax, %rdi
000000010000c686	movq	%r15, %rsi
000000010000c689	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000c68e	testl	%eax, %eax
000000010000c690	jne	0x10000c64d
000000010000c692	leaq	_tp_value.units(%rip), %rax
000000010000c699	addq	%rax, %r12
000000010000c69c	movl	$0x80, %ecx
000000010000c6a1	leaq	-0x1b0(%rbp), %rdi
000000010000c6a8	leaq	-0x130(%rbp), %rsi
000000010000c6af	movq	%r13, %rdx
000000010000c6b2	callq	0x10001142a                     ## symbol stub for: ___memcpy_chk
000000010000c6b7	movb	$0x0, -0x1b0(%rbp,%r13)
000000010000c6c0	movzbl	-0x1b0(%rbp), %esi
000000010000c6c7	leal	-0x2b(%rsi), %eax
000000010000c6ca	xorl	%ecx, %ecx
000000010000c6cc	testb	$-0x3, %al
000000010000c6ce	sete	%cl
000000010000c6d1	cmpq	%rcx, %r13
000000010000c6d4	je	0x10000c64d
000000010000c6da	jbe	0x10000c6f8
000000010000c6dc	movzbl	-0x1b0(%rbp,%rcx), %edx
000000010000c6e4	addb	$-0x3a, %dl
000000010000c6e7	cmpb	$-0xa, %dl
000000010000c6ea	jb	0x10000c64d
000000010000c6f0	incq	%rcx
000000010000c6f3	cmpq	%rcx, %r13
000000010000c6f6	jne	0x10000c6dc
000000010000c6f8	xorl	%ecx, %ecx
000000010000c6fa	testb	$-0x3, %al
000000010000c6fc	sete	%cl
000000010000c6ff	movzbl	-0x1b0(%rbp,%rcx), %r10d
000000010000c708	xorl	%r14d, %r14d
000000010000c70b	testb	%r10b, %r10b
000000010000c70e	je	0x10000cd14
000000010000c714	leaq	-0x1b0(%rbp), %rax
000000010000c71b	addq	%rax, %rcx
000000010000c71e	incq	%rcx
000000010000c721	xorl	%eax, %eax
000000010000c723	movl	$0xa, %edi
000000010000c728	movabsq	$-0x8000000000000000, %r9       ## imm = 0x8000000000000000
000000010000c732	xorl	%r8d, %r8d
000000010000c735	mulq	%rdi
000000010000c738	leaq	(%r8,%r8,4), %r8
000000010000c73c	leaq	(%rdx,%r8,2), %rdx
000000010000c740	movsbl	%r10b, %r8d
000000010000c744	addl	$-0x30, %r8d
000000010000c748	movslq	%r8d, %r10
000000010000c74b	movq	%r10, %r8
000000010000c74e	sarq	$0x3f, %r8
000000010000c752	addq	%r10, %rax
000000010000c755	adcq	%rdx, %r8
000000010000c758	cmpq	%rax, %r9
000000010000c75b	movl	$0x0, %edx
000000010000c760	sbbq	%r8, %rdx
000000010000c763	jl	0x10000d10c
000000010000c769	movzbl	(%rcx), %r10d
000000010000c76d	incq	%rcx
000000010000c770	testb	%r10b, %r10b
000000010000c773	jne	0x10000c735
000000010000c775	jmp	0x10000cd19
000000010000c77a	addq	$0x5, %r15
000000010000c77e	movq	%r15, 0x10(%rdi)
000000010000c782	leaq	0x60c8(%rip), %rsi              ## literal pool for: "["
000000010000c789	leaq	0x60c3(%rip), %rdx              ## literal pool for: "]"
000000010000c790	leaq	_tp_byte_item(%rip), %rcx
000000010000c797	leaq	-0x130(%rbp), %r8
000000010000c79e	callq	_tp_list_of
000000010000c7a3	testl	%eax, %eax
000000010000c7a5	je	0x10000c82d
000000010000c7ab	movq	%rbx, %r12
000000010000c7ae	pxor	%xmm0, %xmm0
000000010000c7b2	movdqa	%xmm0, -0x1b0(%rbp)
000000010000c7ba	movq	$0x0, -0x1a0(%rbp)
000000010000c7c5	cmpq	$0x0, -0x118(%rbp)
000000010000c7cd	je	0x10000c80c
000000010000c7cf	xorl	%ebx, %ebx
000000010000c7d1	leaq	-0x1b0(%rbp), %r14
000000010000c7d8	leaq	-0x1b8(%rbp), %r15
000000010000c7df	movq	-0x120(%rbp), %rax
000000010000c7e6	movzbl	(%rax,%rbx,8), %eax
000000010000c7ea	movb	%al, -0x1b8(%rbp)
000000010000c7f0	movl	$0x1, %edx
000000010000c7f5	movq	%r14, %rdi
000000010000c7f8	movq	%r15, %rsi
000000010000c7fb	callq	_buf_put
000000010000c800	incq	%rbx
000000010000c803	cmpq	-0x118(%rbp), %rbx
000000010000c80a	jb	0x10000c7df
000000010000c80c	movq	-0x120(%rbp), %rdi
000000010000c813	callq	_fwp_mem_free
000000010000c818	leaq	-0x1b0(%rbp), %rdi
000000010000c81f	callq	_buf_to_str
000000010000c824	movq	%rax, (%r12)
000000010000c828	jmp	0x10000b9b2
000000010000c82d	movq	-0x120(%rbp), %rdi
000000010000c834	callq	_fwp_mem_free
000000010000c839	jmp	0x10000b9b8
000000010000c83e	movsd	0x4ef2(%rip), %xmm0
000000010000c846	cmpl	$0xa, (%rcx)
000000010000c849	cvtsd2ss	%xmm0, %xmm1
000000010000c84d	movd	%xmm1, %ecx
000000010000c851	movq	%xmm0, %rax
000000010000c856	cmoveq	%rcx, %rax
000000010000c85a	movq	%rax, (%r15)
000000010000c85d	jmp	0x10000b9b2
000000010000c862	movq	0x8(%rdx), %r9
000000010000c866	movq	0x10(%rdx), %r8
000000010000c86a	subq	%r9, %r8
000000010000c86d	cmpq	%rsi, %r8
000000010000c870	jae	0x10000c978
000000010000c876	movq	%rdi, %r15
000000010000c879	movq	%rax, %rbx
000000010000c87c	movq	%rcx, %rdi
000000010000c87f	movl	$0x2, %esi
000000010000c884	callq	_fwp_gc_alloc_slow
000000010000c889	movq	%rax, -0x1e0(%rbp)
000000010000c890	jmp	0x10000c995
000000010000c895	testq	%rax, %rax
000000010000c898	setne	%sil
000000010000c89c	addb	$-0x2b, %dl
000000010000c89f	testb	$-0x3, %dl
000000010000c8a2	sete	%dl
000000010000c8a5	andb	%sil, %dl
000000010000c8a8	movzbl	%dl, %esi
000000010000c8ab	movb	$0x1, %r8b
000000010000c8ae	movq	%rsi, %rdi
000000010000c8b1	cmpq	%rsi, %rax
000000010000c8b4	jbe	0x10000cb09
000000010000c8ba	movzbl	-0x130(%rbp,%rdi), %edx
000000010000c8c2	leal	-0x30(%rdx), %r9d
000000010000c8c6	cmpb	$0x9, %r9b
000000010000c8ca	ja	0x10000cdc1
000000010000c8d0	incq	%rdi
000000010000c8d3	cmpq	%rdi, %rax
000000010000c8d6	jne	0x10000c8ba
000000010000c8d8	movq	%rax, %rdi
000000010000c8db	movq	%rax, %rdx
000000010000c8de	jmp	0x10000d117
000000010000c8e3	movq	0x8(%rax), %r10
000000010000c8e7	movq	0x10(%rax), %r8
000000010000c8eb	subq	%r10, %r8
000000010000c8ee	cmpq	%rsi, %r8
000000010000c8f1	jae	0x10000cb11
000000010000c8f7	movq	%rdx, %r14
000000010000c8fa	movl	$0x2, %esi
000000010000c8ff	callq	_fwp_gc_alloc_slow
000000010000c904	movq	%rax, -0x1c0(%rbp)
000000010000c90b	jmp	0x10000cb2b
000000010000c910	leaq	0x5f70(%rip), %rsi              ## literal pool for: "("
000000010000c917	movq	%rdi, %r15
000000010000c91a	callq	_tp_eat
000000010000c91f	testl	%eax, %eax
000000010000c921	je	0x10000b9b8
000000010000c927	leaq	0x5f5b(%rip), %rsi              ## literal pool for: ")"
000000010000c92e	movq	%r15, %rdi
000000010000c931	callq	_tp_eat
000000010000c936	testl	%eax, %eax
000000010000c938	je	0x10000b9b8
000000010000c93e	movq	$0x0, (%rbx)
000000010000c945	jmp	0x10000b9b2
000000010000c94a	xorl	%edi, %edi
000000010000c94c	movq	%r14, %rsi
000000010000c94f	callq	_fwp_array_new_packed
000000010000c954	movq	%rax, %r15
000000010000c957	movq	-0x1e8(%rbp), %rax
000000010000c95e	movq	%r15, (%rax)
000000010000c961	jmp	0x10000b9b2
000000010000c966	xorl	%ecx, %ecx
000000010000c968	movq	%rcx, (%r15)
000000010000c96b	jmp	0x10000b9b2
000000010000c970	movq	%rcx, (%rdi)
000000010000c973	jmp	0x10000b9b2
000000010000c978	movq	%rdi, %r15
000000010000c97b	movq	%rax, %rbx
000000010000c97e	leaq	(%r9,%rsi), %rax
000000010000c982	movq	%rax, 0x8(%rdx)
000000010000c986	movq	%r9, -0x1e0(%rbp)
000000010000c98d	movq	%r9, %rdi
000000010000c990	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000c995	movslq	(%r13), %rax
000000010000c999	leaq	0x1(%rax), %rsi
000000010000c99d	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000c9a4	ja	0x10000c9fb
000000010000c9a6	addq	$0x10, %rax
000000010000c9aa	shrq	$0x4, %rax
000000010000c9ae	movzbl	0xbe8(%rax,%r12), %ecx
000000010000c9b7	movl	0xb48(%r12,%rcx,4), %eax
000000010000c9bf	subq	%rax, _fwp_gc(%rip)
000000010000c9c6	js	0x10000c9fb
000000010000c9c8	leaq	(%rcx,%rcx,2), %rcx
000000010000c9cc	leaq	(%r12,%rcx,8), %rcx
000000010000c9d0	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000c9d7	movq	(%rcx), %r12
000000010000c9da	testq	%r12, %r12
000000010000c9dd	je	0x10000c9eb
000000010000c9df	movq	(%r12), %rax
000000010000c9e3	notq	%rax
000000010000c9e6	movq	%rax, (%rcx)
000000010000c9e9	jmp	0x10000ca14
000000010000c9eb	movq	0x8(%rcx), %r12
000000010000c9ef	movq	0x10(%rcx), %rdx
000000010000c9f3	subq	%r12, %rdx
000000010000c9f6	cmpq	%rax, %rdx
000000010000c9f9	jae	0x10000ca0d
000000010000c9fb	movq	%rsi, %rdi
000000010000c9fe	movl	$0x1, %esi
000000010000ca03	callq	_fwp_gc_alloc_slow
000000010000ca08	movq	%rax, %r12
000000010000ca0b	jmp	0x10000ca1c
000000010000ca0d	addq	%r12, %rax
000000010000ca10	movq	%rax, 0x8(%rcx)
000000010000ca14	movq	%r12, %rdi
000000010000ca17	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000ca1c	movslq	(%r13), %rsi
000000010000ca20	incq	%rsi
000000010000ca23	movq	%r12, %rdi
000000010000ca26	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000ca2b	movq	0x8(%r15), %rcx
000000010000ca2f	movq	0x10(%r15), %rax
000000010000ca33	cmpq	%rcx, %rax
000000010000ca36	jae	0x10000ca66
000000010000ca38	movq	(%r15), %rdx
000000010000ca3b	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000ca45	movzbl	(%rdx,%rax), %edi
000000010000ca49	cmpq	$0x20, %rdi
000000010000ca4d	ja	0x10000ca66
000000010000ca4f	btq	%rdi, %rsi
000000010000ca53	jae	0x10000ca66
000000010000ca55	incq	%rax
000000010000ca58	movq	%rax, 0x10(%r15)
000000010000ca5c	cmpq	%rax, %rcx
000000010000ca5f	jne	0x10000ca45
000000010000ca61	jmp	0x10000b9b8
000000010000ca66	cmpq	%rax, %rcx
000000010000ca69	je	0x10000b9b8
000000010000ca6f	movq	%r13, -0x1c0(%rbp)
000000010000ca76	movq	(%r15), %rcx
000000010000ca79	cmpb	$0x7b, (%rcx,%rax)
000000010000ca7d	jne	0x10000b9b8
000000010000ca83	incq	%rax
000000010000ca86	movq	%rax, 0x10(%r15)
000000010000ca8a	leaq	0x5dda(%rip), %rsi              ## literal pool for: "}"
000000010000ca91	movq	%r15, -0x1c8(%rbp)
000000010000ca98	movq	%r15, %rdi
000000010000ca9b	callq	_tp_eat
000000010000caa0	testl	%eax, %eax
000000010000caa2	je	0x10000cea2
000000010000caa8	movq	-0x1c0(%rbp), %rax
000000010000caaf	movslq	(%rax), %rdi
000000010000cab2	testq	%rdi, %rdi
000000010000cab5	movq	-0x1e8(%rbp), %rbx
000000010000cabc	movq	-0x1e0(%rbp), %rsi
000000010000cac3	jle	0x10000cadd
000000010000cac5	xorl	%r14d, %r14d
000000010000cac8	xorl	%eax, %eax
000000010000caca	cmpb	$0x0, (%r12,%rax)
000000010000cacf	je	0x10000b9b8
000000010000cad5	incq	%rax
000000010000cad8	cmpq	%rax, %rdi
000000010000cadb	jne	0x10000caca
000000010000cadd	callq	_fwp_record
000000010000cae2	movq	%rax, (%rbx)
000000010000cae5	jmp	0x10000b9b2
000000010000caea	leaq	_fwp_empty_map(%rip), %rax
000000010000caf1	movq	-0x120(%rbp), %rdi
000000010000caf8	movq	%rax, %rbx
000000010000cafb	callq	_fwp_mem_free
000000010000cb00	movq	%rbx, (%r12)
000000010000cb04	jmp	0x10000b9b2
000000010000cb09	movq	%rsi, %rdx
000000010000cb0c	jmp	0x10000d117
000000010000cb11	movq	%rdx, %r14
000000010000cb14	leaq	(%r10,%rsi), %rcx
000000010000cb18	movq	%rcx, 0x8(%rax)
000000010000cb1c	movq	%r10, -0x1c0(%rbp)
000000010000cb23	movq	%r10, %rdi
000000010000cb26	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000cb2b	movq	%r15, -0x1f0(%rbp)
000000010000cb32	testl	%r15d, %r15d
000000010000cb35	jle	0x10000cc90
000000010000cb3b	movq	%r14, %rax
000000010000cb3e	xorl	%r15d, %r15d
000000010000cb41	movabsq	$0x100002600, %r12              ## imm = 0x100002600
000000010000cb4b	movq	0x30(%rax), %rcx
000000010000cb4f	movq	-0x1d8(%rbp), %rdx
000000010000cb56	movq	(%rcx,%rdx,8), %rcx
000000010000cb5a	movq	(%rcx,%r15,8), %rsi
000000010000cb5e	movq	0x8(%r13), %rdi
000000010000cb62	movq	0x10(%r13), %rdx
000000010000cb66	cmpq	%rdi, %rdx
000000010000cb69	jae	0x10000cb90
000000010000cb6b	movq	(%r13), %rcx
000000010000cb6f	nop
000000010000cb70	movzbl	(%rcx,%rdx), %r8d
000000010000cb75	cmpq	$0x20, %r8
000000010000cb79	ja	0x10000cb90
000000010000cb7b	btq	%r8, %r12
000000010000cb7f	jae	0x10000cb90
000000010000cb81	incq	%rdx
000000010000cb84	movq	%rdx, 0x10(%r13)
000000010000cb88	cmpq	%rdx, %rdi
000000010000cb8b	jne	0x10000cb70
000000010000cb8d	movq	%rdi, %rdx
000000010000cb90	cmpl	$0x10, (%rsi)
000000010000cb93	jne	0x10000cba0
000000010000cb95	cmpq	$0x0, 0x8(%rsi)
000000010000cb9a	je	0x10000cc52
000000010000cba0	xorl	%r8d, %r8d
000000010000cba3	movq	-0x1c0(%rbp), %rax
000000010000cbaa	leaq	(%rax,%r15,8), %rcx
000000010000cbae	cmpq	%rdi, %rdx
000000010000cbb1	jae	0x10000cbc5
000000010000cbb3	movq	(%r13), %rax
000000010000cbb7	cmpb	$0x28, (%rax,%rdx)
000000010000cbbb	setne	%al
000000010000cbbe	orb	%r8b, %al
000000010000cbc1	testb	$0x1, %al
000000010000cbc3	je	0x10000cbf6
000000010000cbc5	xorl	%r14d, %r14d
000000010000cbc8	movq	%r13, %rdi
000000010000cbcb	xorl	%edx, %edx
000000010000cbcd	callq	_tp_value
000000010000cbd2	testl	%eax, %eax
000000010000cbd4	movq	-0x1d0(%rbp), %rax
000000010000cbdb	je	0x10000b9b8
000000010000cbe1	incq	%r15
000000010000cbe4	cmpq	-0x1e0(%rbp), %r15
000000010000cbeb	jne	0x10000cb4b
000000010000cbf1	jmp	0x10000cc90
000000010000cbf6	incq	%rdx
000000010000cbf9	movq	%rdx, 0x10(%r13)
000000010000cbfd	xorl	%r14d, %r14d
000000010000cc00	movq	%r13, %rdi
000000010000cc03	xorl	%edx, %edx
000000010000cc05	callq	_tp_value
000000010000cc0a	testl	%eax, %eax
000000010000cc0c	je	0x10000b9b8
000000010000cc12	movq	-0x1c8(%rbp), %r13
000000010000cc19	movq	0x8(%r13), %rdx
000000010000cc1d	movq	0x10(%r13), %rcx
000000010000cc21	cmpq	%rdx, %rcx
000000010000cc24	movq	-0x1d0(%rbp), %rax
000000010000cc2b	jae	0x10000cc65
000000010000cc2d	movq	(%r13), %rsi
000000010000cc31	movzbl	(%rsi,%rcx), %edi
000000010000cc35	cmpq	$0x20, %rdi
000000010000cc39	ja	0x10000cc65
000000010000cc3b	btq	%rdi, %r12
000000010000cc3f	jae	0x10000cc65
000000010000cc41	incq	%rcx
000000010000cc44	movq	%rcx, 0x10(%r13)
000000010000cc48	cmpq	%rcx, %rdx
000000010000cc4b	jne	0x10000cc31
000000010000cc4d	jmp	0x10000b9b8
000000010000cc52	cmpl	$0x0, 0x10(%rsi)
000000010000cc56	je	0x10000cc88
000000010000cc58	cmpl	$0x0, 0x48(%rsi)
000000010000cc5c	setne	%r8b
000000010000cc60	jmp	0x10000cba3
000000010000cc65	cmpq	%rcx, %rdx
000000010000cc68	je	0x10000b9b8
000000010000cc6e	movq	(%r13), %rdx
000000010000cc72	cmpb	$0x29, (%rdx,%rcx)
000000010000cc76	jne	0x10000b9b8
000000010000cc7c	incq	%rcx
000000010000cc7f	movq	%rcx, 0x10(%r13)
000000010000cc83	jmp	0x10000cbe1
000000010000cc88	movb	$0x1, %r8b
000000010000cc8b	jmp	0x10000cba3
000000010000cc90	movq	-0x1f0(%rbp), %r15
000000010000cc97	testl	%r15d, %r15d
000000010000cc9a	movq	-0x1d8(%rbp), %rdi
000000010000cca1	je	0x10000ce93
000000010000cca7	movq	-0x1e0(%rbp), %r14
000000010000ccae	leaq	0x8(,%r14,8), %rdi
000000010000ccb6	callq	_fwp_alloc_init
000000010000ccbb	movq	%rax, %rdi
000000010000ccbe	movl	%ebx, (%rax)
000000010000ccc0	movl	%r15d, 0x4(%rax)
000000010000ccc4	cmpl	$0x7, %r15d
000000010000ccc8	ja	0x10000ccf2
000000010000ccca	xorl	%eax, %eax
000000010000cccc	movq	-0x1c0(%rbp), %r8
000000010000ccd3	jmp	0x10000ce3a
000000010000ccd8	addq	%r12, %r15
000000010000ccdb	movq	-0x1c8(%rbp), %rdi
000000010000cce2	movq	%r15, 0x10(%rdi)
000000010000cce6	movq	-0x1d0(%rbp), %rax
000000010000cced	jmp	0x10000c0d4
000000010000ccf2	movq	%rdi, %rax
000000010000ccf5	movq	-0x1c0(%rbp), %r8
000000010000ccfc	subq	%r8, %rax
000000010000ccff	addq	$0x8, %rax
000000010000cd03	cmpq	$0x20, %rax
000000010000cd07	jae	0x10000ce01
000000010000cd0d	xorl	%eax, %eax
000000010000cd0f	jmp	0x10000ce3a
000000010000cd14	xorl	%eax, %eax
000000010000cd16	xorl	%r8d, %r8d
000000010000cd19	movq	%rax, %rcx
000000010000cd1c	negq	%rcx
000000010000cd1f	movl	$0x0, %edi
000000010000cd24	sbbq	%r8, %rdi
000000010000cd27	cmpb	$0x2d, %sil
000000010000cd2b	cmovneq	%r8, %rdi
000000010000cd2f	cmovneq	%rax, %rcx
000000010000cd33	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000cd3d	cmpq	%rcx, %rax
000000010000cd40	movl	$0x0, %eax
000000010000cd45	sbbq	%rdi, %rax
000000010000cd48	jl	0x10000b9b8
000000010000cd4e	movq	0x8(%r12), %rsi
000000010000cd53	movq	%rcx, %rax
000000010000cd56	mulq	%rsi
000000010000cd59	imulq	%rsi, %rdi
000000010000cd5d	sarq	$0x3f, %rsi
000000010000cd61	imulq	%rcx, %rsi
000000010000cd65	addq	%rdx, %rsi
000000010000cd68	addq	%rsi, %rdi
000000010000cd6b	movabsq	$-0x8000000000000000, %rcx      ## imm = 0x8000000000000000
000000010000cd75	addq	%rax, %rcx
000000010000cd78	adcq	$-0x1, %rdi
000000010000cd7c	cmpq	$-0x1, %rdi
000000010000cd80	jne	0x10000b9b8
000000010000cd86	movq	%rax, -0x1b8(%rbp)
000000010000cd8d	movl	$0x10, %edi
000000010000cd92	movq	%rax, %rbx
000000010000cd95	callq	_fwp_alloc_init
000000010000cd9a	movabsq	$__mh_execute_header, %rcx
000000010000cda4	movq	%rcx, (%rax)
000000010000cda7	movq	%rbx, 0x8(%rax)
000000010000cdab	leaq	-0x1b8(%rbp), %rcx
000000010000cdb2	movq	-0x1e8(%rbp), %rcx
000000010000cdb9	movq	%rax, (%rcx)
000000010000cdbc	jmp	0x10000b9b2
000000010000cdc1	cmpb	$0x2e, %dl
000000010000cdc4	jne	0x10000d114
000000010000cdca	leaq	0x1(%rdi), %rdx
000000010000cdce	cmpq	%rax, %rdx
000000010000cdd1	jae	0x10000cdf1
000000010000cdd3	movzbl	-0x130(%rbp,%rdx), %r8d
000000010000cddc	addb	$-0x30, %r8b
000000010000cde0	cmpb	$0x9, %r8b
000000010000cde4	ja	0x10000cdf1
000000010000cde6	incq	%rdx
000000010000cde9	cmpq	%rax, %rdx
000000010000cdec	jb	0x10000cdd3
000000010000cdee	movq	%rax, %rdx
000000010000cdf1	leaq	-0x1(%rdx), %r8
000000010000cdf5	cmpq	%rdi, %r8
000000010000cdf8	sete	%r8b
000000010000cdfc	jmp	0x10000d117
000000010000ce01	movl	%r14d, %eax
000000010000ce04	andl	$-0x4, %eax
000000010000ce07	leaq	(,%r14,8), %rcx
000000010000ce0f	andq	$-0x20, %rcx
000000010000ce13	xorl	%edx, %edx
000000010000ce15	movdqu	(%r8,%rdx), %xmm0
000000010000ce1b	movups	0x10(%r8,%rdx), %xmm1
000000010000ce21	movdqu	%xmm0, 0x8(%rdi,%rdx)
000000010000ce27	movups	%xmm1, 0x18(%rdi,%rdx)
000000010000ce2c	addq	$0x20, %rdx
000000010000ce30	cmpq	%rdx, %rcx
000000010000ce33	jne	0x10000ce15
000000010000ce35	cmpl	%r14d, %eax
000000010000ce38	je	0x10000ce93
000000010000ce3a	movq	%r14, %rdx
000000010000ce3d	movq	%rax, %rcx
000000010000ce40	andq	$0x3, %rdx
000000010000ce44	je	0x10000ce5a
000000010000ce46	movq	%rax, %rcx
000000010000ce49	movq	(%r8,%rcx,8), %rsi
000000010000ce4d	movq	%rsi, 0x8(%rdi,%rcx,8)
000000010000ce52	incq	%rcx
000000010000ce55	decq	%rdx
000000010000ce58	jne	0x10000ce49
000000010000ce5a	subq	%r14, %rax
000000010000ce5d	cmpq	$-0x4, %rax
000000010000ce61	ja	0x10000ce93
000000010000ce63	movq	(%r8,%rcx,8), %rax
000000010000ce67	movq	%rax, 0x8(%rdi,%rcx,8)
000000010000ce6c	movq	0x8(%r8,%rcx,8), %rax
000000010000ce71	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000ce76	movq	0x10(%r8,%rcx,8), %rax
000000010000ce7b	movq	%rax, 0x18(%rdi,%rcx,8)
000000010000ce80	movq	0x18(%r8,%rcx,8), %rax
000000010000ce85	movq	%rax, 0x20(%rdi,%rcx,8)
000000010000ce8a	addq	$0x4, %rcx
000000010000ce8e	cmpq	%rcx, %r14
000000010000ce91	jne	0x10000ce63
000000010000ce93	movq	-0x1e8(%rbp), %rax
000000010000ce9a	movq	%rdi, (%rax)
000000010000ce9d	jmp	0x10000b9b2
000000010000cea2	movq	%r12, -0x1f8(%rbp)
000000010000cea9	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000ceb3	movl	$0xff, %r8d
000000010000ceb9	leaq	-0x130(%rbp), %r9
000000010000cec0	movq	-0x1c8(%rbp), %rcx
000000010000cec7	movq	-0x1c0(%rbp), %r12
000000010000cece	movq	%rbx, -0x1d0(%rbp)
000000010000ced5	movq	(%rcx), %rbx
000000010000ced8	movq	0x8(%rcx), %r10
000000010000cedc	movq	0x10(%rcx), %rsi
000000010000cee0	cmpq	%r10, %rsi
000000010000cee3	movq	%r10, -0x1f0(%rbp)
000000010000ceea	jae	0x10000cf10
000000010000ceec	movzbl	(%rbx,%rsi), %eax
000000010000cef0	cmpq	$0x20, %rax
000000010000cef4	ja	0x10000cf10
000000010000cef6	btq	%rax, %r13
000000010000cefa	jae	0x10000cf10
000000010000cefc	incq	%rsi
000000010000ceff	movq	%rsi, 0x10(%rcx)
000000010000cf03	cmpq	%rsi, %r10
000000010000cf06	jne	0x10000ceec
000000010000cf08	movq	%r10, %r14
000000010000cf0b	movq	%r10, %rsi
000000010000cf0e	jmp	0x10000cf60
000000010000cf10	movabsq	$0x4000000000003, %rdi          ## imm = 0x4000000000003
000000010000cf1a	movq	%rsi, %r14
000000010000cf1d	cmpq	%r10, %rsi
000000010000cf20	jb	0x10000cf30
000000010000cf22	jmp	0x10000cf60
000000010000cf24	incq	%r14
000000010000cf27	movq	%r14, 0x10(%rcx)
000000010000cf2b	cmpq	%r14, %r10
000000010000cf2e	je	0x10000cf5d
000000010000cf30	movzbl	(%rbx,%r14), %eax
000000010000cf35	leal	-0x30(%rax), %edx
000000010000cf38	cmpb	$0xa, %dl
000000010000cf3b	jb	0x10000cf24
000000010000cf3d	movl	%eax, %edx
000000010000cf3f	andb	$-0x21, %dl
000000010000cf42	addb	$-0x41, %dl
000000010000cf45	cmpb	$0x1a, %dl
000000010000cf48	jb	0x10000cf24
000000010000cf4a	movzbl	%al, %eax
000000010000cf4d	addl	$-0x2d, %eax
000000010000cf50	cmpl	$0x32, %eax
000000010000cf53	ja	0x10000cf60
000000010000cf55	btq	%rax, %rdi
000000010000cf59	jb	0x10000cf24
000000010000cf5b	jmp	0x10000cf60
000000010000cf5d	movq	%r10, %r14
000000010000cf60	movq	%r14, %r15
000000010000cf63	subq	%rsi, %r15
000000010000cf66	cmpq	$0xff, %r15
000000010000cf6d	cmovaeq	%r8, %r15
000000010000cf71	addq	%rbx, %rsi
000000010000cf74	movl	$0x100, %ecx                    ## imm = 0x100
000000010000cf79	movq	%r9, %rdi
000000010000cf7c	movq	%r15, %rdx
000000010000cf7f	callq	0x10001142a                     ## symbol stub for: ___memcpy_chk
000000010000cf84	movb	$0x0, -0x130(%rbp,%r15)
000000010000cf8d	movslq	(%r12), %rcx
000000010000cf91	testq	%rcx, %rcx
000000010000cf94	movq	-0x1d0(%rbp), %rax
000000010000cf9b	jle	0x10000d10c
000000010000cfa1	movq	%rbx, -0x200(%rbp)
000000010000cfa8	movq	0x18(%rax), %rax
000000010000cfac	movq	%rax, -0x1d8(%rbp)
000000010000cfb3	movl	$0xffffffff, %r15d              ## imm = 0xFFFFFFFF
000000010000cfb9	xorl	%r13d, %r13d
000000010000cfbc	leaq	-0x130(%rbp), %r12
000000010000cfc3	movq	-0x1d8(%rbp), %rax
000000010000cfca	movq	(%rax,%r13,8), %rdi
000000010000cfce	movq	%r12, %rsi
000000010000cfd1	movq	%rcx, %rbx
000000010000cfd4	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000cfd9	movq	%rbx, %rcx
000000010000cfdc	testl	%eax, %eax
000000010000cfde	cmovel	%r13d, %r15d
000000010000cfe2	incq	%r13
000000010000cfe5	cmpq	%r13, %rbx
000000010000cfe8	jne	0x10000cfc3
000000010000cfea	testl	%r15d, %r15d
000000010000cfed	movq	-0x1d0(%rbp), %rax
000000010000cff4	movq	-0x1c8(%rbp), %rcx
000000010000cffb	movq	-0x1c0(%rbp), %r12
000000010000d002	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000d00c	movq	-0x200(%rbp), %rsi
000000010000d013	movq	-0x1f0(%rbp), %rdi
000000010000d01a	js	0x10000d10c
000000010000d020	cmpq	%rdi, %r14
000000010000d023	jae	0x10000d047
000000010000d025	movzbl	(%rsi,%r14), %edx
000000010000d02a	cmpq	$0x20, %rdx
000000010000d02e	ja	0x10000d047
000000010000d030	btq	%rdx, %r13
000000010000d034	jae	0x10000d047
000000010000d036	incq	%r14
000000010000d039	movq	%r14, 0x10(%rcx)
000000010000d03d	cmpq	%r14, %rdi
000000010000d040	jne	0x10000d025
000000010000d042	jmp	0x10000d10c
000000010000d047	cmpq	%r14, %rdi
000000010000d04a	je	0x10000d10c
000000010000d050	cmpb	$0x3d, (%rsi,%r14)
000000010000d055	jne	0x10000d10c
000000010000d05b	incq	%r14
000000010000d05e	movq	%r14, 0x10(%rcx)
000000010000d062	movq	0x20(%rax), %rax
000000010000d066	movl	%r15d, %ebx
000000010000d069	movq	(%rax,%rbx,8), %rsi
000000010000d06d	movq	-0x1e0(%rbp), %rax
000000010000d074	leaq	(%rax,%rbx,8), %rcx
000000010000d078	movq	-0x1c8(%rbp), %rdi
000000010000d07f	xorl	%edx, %edx
000000010000d081	callq	_tp_value
000000010000d086	movq	-0x1c8(%rbp), %rcx
000000010000d08d	testl	%eax, %eax
000000010000d08f	je	0x10000d10c
000000010000d091	movq	-0x1f8(%rbp), %rax
000000010000d098	movb	$0x1, (%rax,%rbx)
000000010000d09c	movq	0x8(%rcx), %rdx
000000010000d0a0	movq	0x10(%rcx), %rax
000000010000d0a4	cmpq	%rdx, %rax
000000010000d0a7	jae	0x10000d0ca
000000010000d0a9	movq	(%rcx), %rsi
000000010000d0ac	movzbl	(%rsi,%rax), %edi
000000010000d0b0	cmpq	$0x20, %rdi
000000010000d0b4	ja	0x10000d0ca
000000010000d0b6	btq	%rdi, %r13
000000010000d0ba	jae	0x10000d0ca
000000010000d0bc	incq	%rax
000000010000d0bf	movq	%rax, 0x10(%rcx)
000000010000d0c3	cmpq	%rax, %rdx
000000010000d0c6	jne	0x10000d0ac
000000010000d0c8	jmp	0x10000d0dc
000000010000d0ca	cmpq	%rax, %rdx
000000010000d0cd	je	0x10000d0dc
000000010000d0cf	movq	(%rcx), %rdx
000000010000d0d2	cmpb	$0x7d, (%rdx,%rax)
000000010000d0d6	je	0x10000d1c9
000000010000d0dc	movq	-0x1c8(%rbp), %rdi
000000010000d0e3	leaq	0x57a1(%rip), %rsi              ## literal pool for: ","
000000010000d0ea	callq	_tp_eat
000000010000d0ef	movq	-0x1c8(%rbp), %rcx
000000010000d0f6	testl	%eax, %eax
000000010000d0f8	je	0x10000d10c
000000010000d0fa	movl	$0xff, %r8d
000000010000d100	leaq	-0x130(%rbp), %r9
000000010000d107	jmp	0x10000ced5
000000010000d10c	xorl	%r14d, %r14d
000000010000d10f	jmp	0x10000b9b8
000000010000d114	movq	%rdi, %rdx
000000010000d117	cmpq	%rsi, %rdi
000000010000d11a	jne	0x10000d125
000000010000d11c	testb	%r8b, %r8b
000000010000d11f	jne	0x10000b9b8
000000010000d125	cmpq	%rax, %rdx
000000010000d128	jae	0x10000d18e
000000010000d12a	movzbl	-0x130(%rbp,%rdx), %esi
000000010000d132	orl	$0x20, %esi
000000010000d135	cmpl	$0x65, %esi
000000010000d138	jne	0x10000d18e
000000010000d13a	leaq	0x1(%rdx), %rsi
000000010000d13e	cmpq	%rax, %rsi
000000010000d141	jae	0x10000d15c
000000010000d143	movzbl	-0x130(%rbp,%rsi), %edi
000000010000d14b	cmpl	$0x2d, %edi
000000010000d14e	je	0x10000d155
000000010000d150	cmpl	$0x2b, %edi
000000010000d153	jne	0x10000d15c
000000010000d155	addq	$0x2, %rdx
000000010000d159	movq	%rdx, %rsi
000000010000d15c	cmpq	%rax, %rsi
000000010000d15f	jae	0x10000b9b8
000000010000d165	movq	%rsi, %rdx
000000010000d168	movzbl	-0x130(%rbp,%rdx), %edi
000000010000d170	addb	$-0x30, %dil
000000010000d174	cmpb	$0x9, %dil
000000010000d178	ja	0x10000d185
000000010000d17a	incq	%rdx
000000010000d17d	cmpq	%rdx, %rax
000000010000d180	jne	0x10000d168
000000010000d182	movq	%rax, %rdx
000000010000d185	cmpq	%rsi, %rdx
000000010000d188	je	0x10000b9b8
000000010000d18e	cmpq	%rax, %rdx
000000010000d191	jne	0x10000b9b8
000000010000d197	cmpl	$0xa, (%rcx)
000000010000d19a	jne	0x10000d1b6
000000010000d19c	leaq	-0x130(%rbp), %rdi
000000010000d1a3	xorl	%esi, %esi
000000010000d1a5	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000d1aa	movd	%xmm0, %eax
000000010000d1ae	movq	%rax, (%r15)
000000010000d1b1	jmp	0x10000b9b2
000000010000d1b6	leaq	-0x130(%rbp), %rdi
000000010000d1bd	xorl	%esi, %esi
000000010000d1bf	callq	0x100011568                     ## symbol stub for: _strtod
000000010000d1c4	jmp	0x10000be5d
000000010000d1c9	incq	%rax
000000010000d1cc	movq	%rax, 0x10(%rcx)
000000010000d1d0	movq	-0x1f8(%rbp), %r12
000000010000d1d7	jmp	0x10000caa8
000000010000d1dc	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000d1e1	nopl	(%rax)
000000010000d1e4	popq	%rax
000000010000d1e5	callq	0xe859d1e9
000000010000d1ea	.byte 0xff #bad opcode
000000010000d1eb	lcalll	*-0x18(%rax)
000000010000d1ee	.byte 0xff #bad opcode
000000010000d1ef	lcalll	*-0x18(%rax)
000000010000d1f2	.byte 0xff #bad opcode
000000010000d1f3	lcalll	*-0x18(%rax)
000000010000d1f6	.byte 0xff #bad opcode
000000010000d1f7	lcalll	*-0x18(%rax)
000000010000d1fa	.byte 0xff #bad opcode
000000010000d1fb	lcalll	*-0x18(%rax)
000000010000d1fe	.byte 0xff #bad opcode
000000010000d1ff	lcalll	*-0x18(%rax)
000000010000d202	.byte 0xff #bad opcode
000000010000d203	lcalll	*-0x18(%rax)
000000010000d206	.byte 0xff #bad opcode
000000010000d207	lcalll	*-0x18(%rax)
000000010000d20a	.byte 0xff #bad opcode
000000010000d20b	.byte 0xff #bad opcode
000000010000d20c	cmpl	%esp, %ebp
000000010000d20e	.byte 0xff #bad opcode
000000010000d20f	.byte 0xff #bad opcode
000000010000d210	cmpl	%esp, %ebp
000000010000d212	.byte 0xff #bad opcode
000000010000d213	incl	-0x49000014(%rcx)
000000010000d219	inb	%dx, %al
000000010000d21a	.byte 0xff #bad opcode
000000010000d21b	.byte 0xff #bad opcode
000000010000d21c	jl	0x10000d20d
000000010000d21e	.byte 0xff #bad opcode
000000010000d21f	decl	(%rcx)
000000010000d221	jmp	0x10000d222
000000010000d223	lcalll	*(%rdx)
000000010000d225	outb	%al, %dx
000000010000d226	.byte 0xff #bad opcode
000000010000d227	decl	(%rcx)
000000010000d229	jmp	0x10000d22a
000000010000d22b	.byte 0xff #bad opcode
000000010000d22c	fsubr	%st, %st(1)
000000010000d22e	.byte 0xff #bad opcode
000000010000d22f	.byte 0xff #bad opcode
000000010000d230	fsubr	%st, %st(1)
000000010000d232	.byte 0xff #bad opcode
000000010000d233	incl	-0x13(%rcx)
000000010000d236	.byte 0xff #bad opcode
000000010000d237	ljmpl	*0xfffffed(%rcx)
000000010000d23d	.byte 0x1f #bad opcode
000000010000d23e	addb	%dl, 0x48(%rbp)
000000010000d242	movl	%esp, %ebp
000000010000d244	pushq	%r15
000000010000d246	pushq	%r14
000000010000d248	pushq	%r13
000000010000d24a	pushq	%r12
000000010000d24c	pushq	%rbx
000000010000d24d	subq	$0xb8, %rsp
000000010000d254	movq	%rdx, %rbx
000000010000d257	movq	%rsi, %r15
000000010000d25a	movq	0x5dcf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000d261	movq	(%rax), %rax
000000010000d264	movq	%rax, -0x30(%rbp)
000000010000d268	leaq	-0xb0(%rbp), %rsi
000000010000d26f	movl	$0x80, %edx
000000010000d274	callq	_tp_token
000000010000d279	xorl	%r14d, %r14d
000000010000d27c	cmpq	$0x7f, %rax
000000010000d280	ja	0x10000d2bc
000000010000d282	leaq	-0xb0(%rbp), %r12
000000010000d289	movq	%r12, %rdi
000000010000d28c	callq	0x100011556                     ## symbol stub for: _strlen
000000010000d291	movq	%r12, %rdi
000000010000d294	movq	%rax, %rsi
000000010000d297	callq	_fwp_str_new
000000010000d29c	movq	(%rax), %r11
000000010000d29f	testq	%r11, %r11
000000010000d2a2	je	0x10000d2bc
000000010000d2a4	movq	%rax, %rcx
000000010000d2a7	movzbl	0x8(%rax), %r8d
000000010000d2ac	leal	-0x2b(%r8), %eax
000000010000d2b0	xorl	%edx, %edx
000000010000d2b2	testb	$-0x3, %al
000000010000d2b4	sete	%dl
000000010000d2b7	cmpq	%rdx, %r11
000000010000d2ba	jne	0x10000d2e5
000000010000d2bc	movq	0x5d6d(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000d2c3	movq	(%rax), %rax
000000010000d2c6	cmpq	-0x30(%rbp), %rax
000000010000d2ca	jne	0x10000d669
000000010000d2d0	movl	%r14d, %eax
000000010000d2d3	addq	$0xb8, %rsp
000000010000d2da	popq	%rbx
000000010000d2db	popq	%r12
000000010000d2dd	popq	%r13
000000010000d2df	popq	%r14
000000010000d2e1	popq	%r15
000000010000d2e3	popq	%rbp
000000010000d2e4	retq
000000010000d2e5	movl	(%r15), %r9d
000000010000d2e8	movl	0x48(%r15), %edi
000000010000d2ec	jbe	0x10000d307
000000010000d2ee	nop
000000010000d2f0	movzbl	0x8(%rcx,%rdx), %esi
000000010000d2f5	addb	$-0x3a, %sil
000000010000d2f9	cmpb	$-0xa, %sil
000000010000d2fd	jb	0x10000d2bc
000000010000d2ff	incq	%rdx
000000010000d302	cmpq	%rdx, %r11
000000010000d305	jne	0x10000d2f0
000000010000d307	movl	%r9d, -0xb4(%rbp)
000000010000d30e	movq	%r8, -0xc0(%rbp)
000000010000d315	movq	%rdi, -0xd0(%rbp)
000000010000d31c	movq	%rbx, -0xc8(%rbp)
000000010000d323	xorl	%r15d, %r15d
000000010000d326	testb	$-0x3, %al
000000010000d328	sete	%r15b
000000010000d32c	xorl	%edi, %edi
000000010000d32e	movl	$0x0, %esi
000000010000d333	cmpq	%r15, %r11
000000010000d336	jbe	0x10000d3f1
000000010000d33c	xorl	%r14d, %r14d
000000010000d33f	movabsq	$-0x3333333333333333, %rbx      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000d349	xorl	%edi, %edi
000000010000d34b	xorl	%esi, %esi
000000010000d34d	nopl	(%rax)
000000010000d350	movq	%rsi, %r13
000000010000d353	movq	%rdi, %r12
000000010000d356	movq	%rdi, %rax
000000010000d359	movl	$0xa, %edx
000000010000d35e	mulq	%rdx
000000010000d361	leaq	(%rsi,%rsi,4), %rsi
000000010000d365	leaq	(%rdx,%rsi,2), %rdx
000000010000d369	movsbl	0x8(%rcx,%r15), %esi
000000010000d36f	addl	$-0x30, %esi
000000010000d372	movslq	%esi, %r8
000000010000d375	movq	%r8, %rsi
000000010000d378	sarq	$0x3f, %rsi
000000010000d37c	movq	%rax, %rdi
000000010000d37f	addq	%r8, %rdi
000000010000d382	adcq	%rdx, %rsi
000000010000d385	movq	%rsi, %r9
000000010000d388	shldq	$0x3f, %rdi, %r9
000000010000d38d	movq	%rsi, %r8
000000010000d390	shrq	%r8
000000010000d393	movq	%r9, %r10
000000010000d396	addq	%r8, %r10
000000010000d399	adcq	$0x0, %r10
000000010000d39d	movq	%r10, %rax
000000010000d3a0	mulq	%rbx
000000010000d3a3	shrq	$0x2, %rdx
000000010000d3a7	leaq	(%rdx,%rdx,4), %rax
000000010000d3ab	subq	%rax, %r10
000000010000d3ae	subq	%r10, %r9
000000010000d3b1	sbbq	$0x0, %r8
000000010000d3b5	movq	%r9, %r10
000000010000d3b8	movabsq	$-0x3333333333333334, %rax      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000d3c2	imulq	%rax, %r10
000000010000d3c6	movq	%r9, %rax
000000010000d3c9	mulq	%rbx
000000010000d3cc	addq	%r10, %rdx
000000010000d3cf	imulq	%rbx, %r8
000000010000d3d3	addq	%rdx, %r8
000000010000d3d6	xorq	%r13, %r8
000000010000d3d9	xorq	%r12, %rax
000000010000d3dc	orq	%r8, %rax
000000010000d3df	jne	0x10000d2bc
000000010000d3e5	incq	%r15
000000010000d3e8	cmpq	%r15, %r11
000000010000d3eb	jne	0x10000d350
000000010000d3f1	movl	-0xb4(%rbp), %r11d
000000010000d3f8	cmpl	$0x9, %r11d
000000010000d3fc	jne	0x10000d460
000000010000d3fe	cmpb	$0x2d, -0xc0(%rbp)
000000010000d405	movq	-0xc8(%rbp), %rbx
000000010000d40c	jne	0x10000d41d
000000010000d40e	xorl	%r14d, %r14d
000000010000d411	movq	%rdi, %rax
000000010000d414	orq	%rsi, %rax
000000010000d417	jne	0x10000d2bc
000000010000d41d	callq	_fwp_box_u128
000000010000d422	movq	%rax, %r15
000000010000d425	movq	%r15, -0xd8(%rbp)
000000010000d42c	movl	$0x10, %edi
000000010000d431	callq	_fwp_alloc_init
000000010000d436	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
000000010000d440	movq	%rcx, (%rax)
000000010000d443	movq	%r15, 0x8(%rax)
000000010000d447	leaq	-0xd8(%rbp), %rcx
000000010000d44e	movq	0x8(%rax), %rax
000000010000d452	movq	%rax, (%rbx)
000000010000d455	movl	$0x1, %r14d
000000010000d45b	jmp	0x10000d2bc
000000010000d460	movq	-0xc0(%rbp), %r10
000000010000d467	cmpb	$0x2d, %r10b
000000010000d46b	sete	%cl
000000010000d46e	movabsq	$-0x8000000000000000, %rax      ## imm = 0x8000000000000000
000000010000d478	movq	%rsi, %rdx
000000010000d47b	xorq	%rax, %rdx
000000010000d47e	orq	%rdi, %rdx
000000010000d481	setne	%dl
000000010000d484	xorl	%r14d, %r14d
000000010000d487	movq	%rdi, %r8
000000010000d48a	negq	%r8
000000010000d48d	movq	%rax, %r8
000000010000d490	sbbq	%rsi, %r8
000000010000d493	movq	-0xc8(%rbp), %rbx
000000010000d49a	jb	0x10000d2bc
000000010000d4a0	orb	%dl, %cl
000000010000d4a2	je	0x10000d2bc
000000010000d4a8	xorl	%r14d, %r14d
000000010000d4ab	movq	%rdi, %r15
000000010000d4ae	negq	%r15
000000010000d4b1	movl	$0x0, %r9d
000000010000d4b7	sbbq	%rsi, %r9
000000010000d4ba	cmpb	$0x2d, %r10b
000000010000d4be	cmovneq	%rdi, %r15
000000010000d4c2	cmovneq	%rsi, %r9
000000010000d4c6	cmpl	$0x14, %r11d
000000010000d4ca	ja	0x10000d2bc
000000010000d4d0	movl	%r11d, %ecx
000000010000d4d3	leaq	0x196(%rip), %rdx
000000010000d4da	movslq	(%rdx,%rcx,4), %rcx
000000010000d4de	addq	%rdx, %rcx
000000010000d4e1	jmpq	*%rcx
000000010000d4e3	movq	%r15, %rax
000000010000d4e6	addq	$-0x80, %rax
000000010000d4ea	adcq	$-0x1, %r9
000000010000d4ee	cmpq	$-0x100, %rax
000000010000d4f4	jmp	0x10000d52f
000000010000d4f6	movq	%r15, %rax
000000010000d4f9	addq	$-0x80000000, %rax              ## imm = 0x80000000
000000010000d4ff	adcq	$-0x1, %r9
000000010000d503	movabsq	$-0x100000000, %rcx             ## imm = 0xFFFFFFFF00000000
000000010000d50d	cmpq	%rcx, %rax
000000010000d510	jmp	0x10000d52f
000000010000d512	xorl	%r14d, %r14d
000000010000d515	movl	$0xff, %eax
000000010000d51a	jmp	0x10000d546
000000010000d51c	movq	%r15, %rax
000000010000d51f	addq	$-0x8000, %rax                  ## imm = 0x8000
000000010000d525	adcq	$-0x1, %r9
000000010000d529	cmpq	$-0x10000, %rax                 ## imm = 0xFFFF0000
000000010000d52f	sbbq	$-0x1, %r9
000000010000d533	jb	0x10000d2bc
000000010000d539	jmp	0x10000d425
000000010000d53e	xorl	%r14d, %r14d
000000010000d541	movl	$0xffff, %eax                   ## imm = 0xFFFF
000000010000d546	cmpq	%r15, %rax
000000010000d549	movl	$0x0, %eax
000000010000d54e	sbbq	%r9, %rax
000000010000d551	jb	0x10000d2bc
000000010000d557	jmp	0x10000d425
000000010000d55c	movq	%r15, %rax
000000010000d55f	shrq	$0x20, %rax
000000010000d563	orq	%r9, %rax
000000010000d566	jne	0x10000d2bc
000000010000d56c	jmp	0x10000d425
000000010000d571	movq	%r15, %rcx
000000010000d574	addq	%rax, %rcx
000000010000d577	adcq	$-0x1, %r9
000000010000d57b	cmpq	$-0x1, %r9
000000010000d57f	jne	0x10000d2bc
000000010000d585	jmp	0x10000d425
000000010000d58a	movq	%r15, %rdi
000000010000d58d	movq	%r9, %rsi
000000010000d590	callq	_fwp_box_u128
000000010000d595	jmp	0x10000d422
000000010000d59a	xorl	%r14d, %r14d
000000010000d59d	movq	-0xd0(%rbp), %rcx
000000010000d5a4	testl	%ecx, %ecx
000000010000d5a6	jle	0x10000d5dd
000000010000d5a8	leal	-0x1(%rcx), %eax
000000010000d5ab	cmpl	$0x4f, %eax
000000010000d5ae	movl	$0x4f, %r8d
000000010000d5b4	cmovbl	%eax, %r8d
000000010000d5b8	incl	%r8d
000000010000d5bb	movl	%r8d, %edi
000000010000d5be	andl	$0x7, %edi
000000010000d5c1	cmpl	$0x8, %ecx
000000010000d5c4	jae	0x10000d5e3
000000010000d5c6	movl	$0x1, %eax
000000010000d5cb	xorl	%ecx, %ecx
000000010000d5cd	jmp	0x10000d609
000000010000d5cf	testq	%r9, %r9
000000010000d5d2	jne	0x10000d2bc
000000010000d5d8	jmp	0x10000d425
000000010000d5dd	xorl	%edx, %edx
000000010000d5df	xorl	%ecx, %ecx
000000010000d5e1	jmp	0x10000d63e
000000010000d5e3	andl	$0xf8, %r8d
000000010000d5ea	movl	$0x1, %eax
000000010000d5ef	xorl	%ecx, %ecx
000000010000d5f1	movl	$0x19a1, %esi                   ## imm = 0x19A1
000000010000d5f6	mulq	%rsi
000000010000d5f9	imulq	$0x19a1, %rcx, %rcx             ## imm = 0x19A1
000000010000d600	addq	%rdx, %rcx
000000010000d603	addl	$-0x8, %r8d
000000010000d607	jne	0x10000d5f6
000000010000d609	testl	%edi, %edi
000000010000d60b	je	0x10000d620
000000010000d60d	movl	$0x3, %esi
000000010000d612	mulq	%rsi
000000010000d615	leaq	(%rcx,%rcx,2), %rcx
000000010000d619	addq	%rdx, %rcx
000000010000d61c	decl	%edi
000000010000d61e	jne	0x10000d612
000000010000d620	addq	$-0x1, %rax
000000010000d624	adcq	$-0x1, %rcx
000000010000d628	movq	%rcx, %rdx
000000010000d62b	shrq	$0x3f, %rdx
000000010000d62f	addq	%rax, %rdx
000000010000d632	adcq	$0x0, %rcx
000000010000d636	shrdq	$0x1, %rcx, %rdx
000000010000d63b	sarq	%rcx
000000010000d63e	movq	%rdx, %rax
000000010000d641	negq	%rax
000000010000d644	movl	$0x0, %esi
000000010000d649	sbbq	%rcx, %rsi
000000010000d64c	cmpq	%r15, %rdx
000000010000d64f	sbbq	%r9, %rcx
000000010000d652	jl	0x10000d2bc
000000010000d658	cmpq	%rax, %r15
000000010000d65b	sbbq	%rsi, %r9
000000010000d65e	jge	0x10000d425
000000010000d664	jmp	0x10000d2bc
000000010000d669	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010000d66e	nop
000000010000d670	jae	0x10000d670
000000010000d672	.byte 0xff #bad opcode
000000010000d673	ljmpl	*-0x1790001(%rsi,%rdi,8)
000000010000d67a	.byte 0xff #bad opcode
000000010000d67b	incl	(%rcx)
000000010000d67d	.byte 0xff #bad opcode
000000010000d67e	.byte 0xff #bad opcode
000000010000d67f	lcalll	*(%rdx)
000000010000d681	.byte 0xff #bad opcode
000000010000d682	.byte 0xff #bad opcode
000000010000d683	jmpq	*-0x31000002(%rdx)
000000010000d689	.byte 0xfe #bad opcode
000000010000d68a	.byte 0xff #bad opcode
000000010000d68b	.byte 0xff #bad opcode
000000010000d68c	inb	%dx, %al
000000010000d68d	.byte 0xfe #bad opcode
000000010000d68e	.byte 0xff #bad opcode
000000010000d68f	lcalll	*-0x1(%rdi)
000000010000d692	.byte 0xff #bad opcode
000000010000d693	decl	-0x1(%rsp,%rdi,8)
000000010000d697	decl	-0x1(%rsp,%rdi,8)
000000010000d69b	decl	-0x1(%rsp,%rdi,8)
000000010000d69f	decl	-0x1(%rsp,%rdi,8)
000000010000d6a3	decl	-0x1(%rsp,%rdi,8)
000000010000d6a7	decl	-0x1(%rsp,%rdi,8)
000000010000d6ab	decl	-0x1(%rsp,%rdi,8)
000000010000d6af	decl	-0x1(%rsp,%rdi,8)
000000010000d6b3	decl	-0x1(%rsp,%rdi,8)
000000010000d6b7	decl	-0x1(%rsp,%rdi,8)
000000010000d6bb	decl	-0x1(%rsp,%rdi,8)
000000010000d6bf	ljmpl	*(%rdx)
000000010000d6c1	.byte 0xff #bad opcode
000000010000d6c2	.byte 0xff #bad opcode
000000010000d6c3	jmpq	*0x66(%rsi)
000000010000d6c6	nopw	%cs:(%rax,%rax)
_tp_quoted:
000000010000d6d0	pushq	%rbp
000000010000d6d1	movq	%rsp, %rbp
000000010000d6d4	pushq	%r15
000000010000d6d6	pushq	%r14
000000010000d6d8	pushq	%r13
000000010000d6da	pushq	%r12
000000010000d6dc	pushq	%rbx
000000010000d6dd	subq	$0x28, %rsp
000000010000d6e1	movq	%rsi, %rbx
000000010000d6e4	movq	%rdi, %r15
000000010000d6e7	movq	0x8(%rdi), %rcx
000000010000d6eb	movq	0x10(%rdi), %rax
000000010000d6ef	cmpq	%rcx, %rax
000000010000d6f2	jae	0x10000d734
000000010000d6f4	movq	(%r15), %rdx
000000010000d6f7	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000d701	nopw	%cs:(%rax,%rax)
000000010000d710	movzbl	(%rdx,%rax), %edi
000000010000d714	cmpq	$0x20, %rdi
000000010000d718	ja	0x10000d734
000000010000d71a	btq	%rdi, %rsi
000000010000d71e	jae	0x10000d734
000000010000d720	incq	%rax
000000010000d723	movq	%rax, 0x10(%r15)
000000010000d727	cmpq	%rax, %rcx
000000010000d72a	jne	0x10000d710
000000010000d72c	xorl	%r14d, %r14d
000000010000d72f	jmp	0x10000d916
000000010000d734	xorl	%r14d, %r14d
000000010000d737	cmpq	%rcx, %rax
000000010000d73a	jae	0x10000d916
000000010000d740	movq	(%r15), %rdx
000000010000d743	cmpb	$0x22, (%rdx,%rax)
000000010000d747	jne	0x10000d916
000000010000d74d	incq	%rax
000000010000d750	movq	%rax, 0x10(%r15)
000000010000d754	xorps	%xmm0, %xmm0
000000010000d757	movaps	%xmm0, -0x50(%rbp)
000000010000d75b	movq	$0x0, -0x40(%rbp)
000000010000d763	xorl	%r14d, %r14d
000000010000d766	cmpq	%rcx, %rax
000000010000d769	jae	0x10000d904
000000010000d76f	leaq	-0x50(%rbp), %r12
000000010000d773	movq	0x5886(%rip), %r13              ## literal pool symbol address: __DefaultRuneLocale
000000010000d77a	nopw	(%rax,%rax)
000000010000d780	movq	(%r15), %rdx
000000010000d783	leaq	0x1(%rax), %rdi
000000010000d787	movq	%rdi, 0x10(%r15)
000000010000d78b	movzbl	(%rdx,%rax), %esi
000000010000d78f	cmpl	$0x5c, %esi
000000010000d792	je	0x10000d7d0
000000010000d794	cmpl	$0x22, %esi
000000010000d797	je	0x10000d928
000000010000d79d	movb	%sil, -0x29(%rbp)
000000010000d7a1	movl	$0x1, %edx
000000010000d7a6	movq	%r12, %rdi
000000010000d7a9	leaq	-0x29(%rbp), %rsi
000000010000d7ad	callq	_buf_put
000000010000d7b2	movq	0x8(%r15), %rcx
000000010000d7b6	movq	0x10(%r15), %rax
000000010000d7ba	cmpq	%rcx, %rax
000000010000d7bd	jb	0x10000d780
000000010000d7bf	jmp	0x10000d90d
000000010000d7c4	nopw	%cs:(%rax,%rax)
000000010000d7d0	cmpq	%rcx, %rdi
000000010000d7d3	jae	0x10000d90d
000000010000d7d9	leaq	0x2(%rax), %rsi
000000010000d7dd	movq	%rsi, 0x10(%r15)
000000010000d7e1	movzbl	0x1(%rdx,%rax), %edi
000000010000d7e6	leal	-0x5c(%rdi), %r8d
000000010000d7ea	cmpl	$0x19, %r8d
000000010000d7ee	ja	0x10000d806
000000010000d7f0	leaq	0x2b9(%rip), %r9
000000010000d7f7	movslq	(%r9,%r8,4), %rdi
000000010000d7fb	addq	%r9, %rdi
000000010000d7fe	jmpq	*%rdi
000000010000d800	movb	$0x5c, -0x29(%rbp)
000000010000d804	jmp	0x10000d7a1
000000010000d806	cmpl	$0x22, %edi
000000010000d809	je	0x10000d8c1
000000010000d80f	cmpl	$0x30, %edi
000000010000d812	jne	0x10000d90d
000000010000d818	movb	$0x0, -0x29(%rbp)
000000010000d81c	jmp	0x10000d7a1
000000010000d81e	movb	$0x9, -0x29(%rbp)
000000010000d822	jmp	0x10000d7a1
000000010000d827	movb	$0xd, -0x29(%rbp)
000000010000d82b	jmp	0x10000d7a1
000000010000d830	movb	$0xa, -0x29(%rbp)
000000010000d834	jmp	0x10000d7a1
000000010000d839	cmpq	%rcx, %rsi
000000010000d83c	jae	0x10000d90d
000000010000d842	cmpb	$0x7b, (%rdx,%rsi)
000000010000d846	jne	0x10000d90d
000000010000d84c	leaq	0x3(%rax), %rsi
000000010000d850	movq	%rsi, 0x10(%r15)
000000010000d854	cmpq	%rcx, %rsi
000000010000d857	jae	0x10000d90d
000000010000d85d	leaq	0x4(%rax), %rdi
000000010000d861	leaq	(%rdx,%rax), %r8
000000010000d865	addq	$0x3, %r8
000000010000d869	subq	%rax, %rcx
000000010000d86c	addq	$-0x3, %rcx
000000010000d870	xorl	%edx, %edx
000000010000d872	xorl	%esi, %esi
000000010000d874	nopw	%cs:(%rax,%rax)
000000010000d880	movzbl	(%r8,%rdx), %r9d
000000010000d885	testb	$0x1, 0x3e(%r13,%r9,4)
000000010000d88b	je	0x10000d8ca
000000010000d88d	leaq	(%rdi,%rdx), %r9
000000010000d891	movq	%r9, 0x10(%r15)
000000010000d895	movsbl	(%r8,%rdx), %r9d
000000010000d89a	shll	$0x4, %esi
000000010000d89d	leal	-0x30(%r9), %r10d
000000010000d8a1	movl	%r9d, %r11d
000000010000d8a4	orl	$0x20, %r11d
000000010000d8a8	addl	$-0x57, %r11d
000000010000d8ac	cmpl	$0x3a, %r9d
000000010000d8b0	cmovll	%r10d, %r11d
000000010000d8b4	addl	%r11d, %esi
000000010000d8b7	incq	%rdx
000000010000d8ba	cmpq	%rdx, %rcx
000000010000d8bd	jne	0x10000d880
000000010000d8bf	jmp	0x10000d90d
000000010000d8c1	movb	$0x22, -0x29(%rbp)
000000010000d8c5	jmp	0x10000d7a1
000000010000d8ca	testl	%edx, %edx
000000010000d8cc	je	0x10000d90d
000000010000d8ce	cmpb	$0x7d, %r9b
000000010000d8d2	jne	0x10000d90d
000000010000d8d4	cmpl	$0x10ffff, %esi                 ## imm = 0x10FFFF
000000010000d8da	ja	0x10000d90d
000000010000d8dc	movl	%esi, %ecx
000000010000d8de	andl	$0x1ff800, %ecx                 ## imm = 0x1FF800
000000010000d8e4	cmpl	$0xd800, %ecx                   ## imm = 0xD800
000000010000d8ea	je	0x10000d90d
000000010000d8ec	addq	%rdx, %rax
000000010000d8ef	addq	$0x4, %rax
000000010000d8f3	movq	%rax, 0x10(%r15)
000000010000d8f7	movq	%r12, %rdi
000000010000d8fa	callq	_fwp_utf8_put
000000010000d8ff	jmp	0x10000d7b2
000000010000d904	xorl	%edi, %edi
000000010000d906	callq	0x1000114a2                     ## symbol stub for: _free
000000010000d90b	jmp	0x10000d916
000000010000d90d	movq	-0x50(%rbp), %rdi
000000010000d911	callq	0x1000114a2                     ## symbol stub for: _free
000000010000d916	movl	%r14d, %eax
000000010000d919	addq	$0x28, %rsp
000000010000d91d	popq	%rbx
000000010000d91e	popq	%r12
000000010000d920	popq	%r13
000000010000d922	popq	%r14
000000010000d924	popq	%r15
000000010000d926	popq	%rbp
000000010000d927	retq
000000010000d928	movq	-0x50(%rbp), %r14
000000010000d92c	movq	-0x48(%rbp), %rsi
000000010000d930	testq	%r14, %r14
000000010000d933	leaq	0x4228(%rip), %rdi              ## literal pool for: ""
000000010000d93a	cmovneq	%r14, %rdi
000000010000d93e	testq	%rsi, %rsi
000000010000d941	je	0x10000da83
000000010000d947	xorl	%eax, %eax
000000010000d949	jmp	0x10000d957
000000010000d94b	incq	%rax
000000010000d94e	cmpq	%rsi, %rax
000000010000d951	jae	0x10000da83
000000010000d957	movzbl	(%rdi,%rax), %r9d
000000010000d95c	testb	%r9b, %r9b
000000010000d95f	jns	0x10000d94b
000000010000d961	leal	0x3e(%r9), %ecx
000000010000d965	cmpb	$0x1e, %cl
000000010000d968	jae	0x10000d97c
000000010000d96a	movl	$0x80, %ecx
000000010000d96f	movl	$0x1, %r8d
000000010000d975	movl	$0x1f, %edx
000000010000d97a	jmp	0x10000d9b6
000000010000d97c	movl	%r9d, %ecx
000000010000d97f	andb	$-0x10, %cl
000000010000d982	cmpb	$-0x20, %cl
000000010000d985	jne	0x10000d999
000000010000d987	movl	$0x800, %ecx                    ## imm = 0x800
000000010000d98c	movl	$0x2, %r8d
000000010000d992	movl	$0xf, %edx
000000010000d997	jmp	0x10000d9b6
000000010000d999	leal	0x10(%r9), %ecx
000000010000d99d	cmpb	$0x4, %cl
000000010000d9a0	ja	0x10000daa1
000000010000d9a6	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000d9ab	movl	$0x3, %r8d
000000010000d9b1	movl	$0x7, %edx
000000010000d9b6	movl	%r8d, %r8d
000000010000d9b9	leaq	(%rax,%r8), %r10
000000010000d9bd	cmpq	%rsi, %r10
000000010000d9c0	jae	0x10000daa1
000000010000d9c6	movzbl	0x1(%rdi,%rax), %r10d
000000010000d9cc	movl	%r10d, %r11d
000000010000d9cf	andl	$-0x40, %r11d
000000010000d9d3	cmpl	$0x80, %r11d
000000010000d9da	jne	0x10000daa1
000000010000d9e0	andl	%r9d, %edx
000000010000d9e3	leal	0x1(%r8), %r11d
000000010000d9e7	movl	%edx, %r9d
000000010000d9ea	shll	$0x6, %r9d
000000010000d9ee	andl	$0x3f, %r10d
000000010000d9f2	orl	%r9d, %r10d
000000010000d9f5	cmpl	$0x2, %r11d
000000010000d9f9	jne	0x10000da00
000000010000d9fb	movl	%r10d, %r11d
000000010000d9fe	jmp	0x10000da58
000000010000da00	movzbl	0x2(%rdi,%rax), %edx
000000010000da05	movl	%edx, %r9d
000000010000da08	andl	$-0x40, %r9d
000000010000da0c	cmpl	$0x80, %r9d
000000010000da13	jne	0x10000daa1
000000010000da19	movl	%r10d, %r9d
000000010000da1c	shll	$0x6, %r9d
000000010000da20	andl	$0x3f, %edx
000000010000da23	orl	%r9d, %edx
000000010000da26	cmpl	$0x3, %r11d
000000010000da2a	jne	0x10000da34
000000010000da2c	movl	%edx, %r11d
000000010000da2f	movl	%r10d, %edx
000000010000da32	jmp	0x10000da58
000000010000da34	movzbl	0x3(%rdi,%rax), %r11d
000000010000da3a	movl	%r11d, %r9d
000000010000da3d	andl	$-0x40, %r9d
000000010000da41	cmpl	$0x80, %r9d
000000010000da48	jne	0x10000daa1
000000010000da4a	movl	%edx, %r9d
000000010000da4d	shll	$0x6, %r9d
000000010000da51	andl	$0x3f, %r11d
000000010000da55	orl	%r9d, %r11d
000000010000da58	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000da5e	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000da64	je	0x10000daa1
000000010000da66	cmpl	$0x10ffff, %r9d                 ## imm = 0x10FFFF
000000010000da6d	ja	0x10000daa1
000000010000da6f	cmpl	%ecx, %r11d
000000010000da72	jb	0x10000daa1
000000010000da74	addq	%r8, %rax
000000010000da77	incq	%rax
000000010000da7a	cmpq	%rsi, %rax
000000010000da7d	jb	0x10000d957
000000010000da83	callq	_fwp_str_new
000000010000da88	movq	%rax, %r15
000000010000da8b	movq	%r14, %rdi
000000010000da8e	callq	0x1000114a2                     ## symbol stub for: _free
000000010000da93	movq	%r15, (%rbx)
000000010000da96	movl	$0x1, %r14d
000000010000da9c	jmp	0x10000d916
000000010000daa1	movq	%r14, %rdi
000000010000daa4	callq	0x1000114a2                     ## symbol stub for: _free
000000010000daa9	jmp	0x10000d72c
000000010000daae	nop
000000010000dab0	pushq	%rax
000000010000dab1	std
000000010000dab2	.byte 0xff #bad opcode
000000010000dab3	lcalll	*-0x2(%rbp)
000000010000dab6	.byte 0xff #bad opcode
000000010000dab7	lcalll	*-0x2(%rbp)
000000010000daba	.byte 0xff #bad opcode
000000010000dabb	lcalll	*-0x2(%rbp)
000000010000dabe	.byte 0xff #bad opcode
000000010000dabf	lcalll	*-0x2(%rbp)
000000010000dac2	.byte 0xff #bad opcode
000000010000dac3	lcalll	*-0x2(%rbp)
000000010000dac6	.byte 0xff #bad opcode
000000010000dac7	lcalll	*-0x2(%rbp)
000000010000daca	.byte 0xff #bad opcode
000000010000dacb	lcalll	*-0x2(%rbp)
000000010000dace	.byte 0xff #bad opcode
000000010000dacf	lcalll	*-0x2(%rbp)
000000010000dad2	.byte 0xff #bad opcode
000000010000dad3	lcalll	*-0x2(%rbp)
000000010000dad6	.byte 0xff #bad opcode
000000010000dad7	lcalll	*-0x2(%rbp)
000000010000dada	.byte 0xff #bad opcode
000000010000dadb	lcalll	*-0x2(%rbp)
000000010000dade	.byte 0xff #bad opcode
000000010000dadf	lcalll	*-0x2(%rbp)
000000010000dae2	.byte 0xff #bad opcode
000000010000dae3	lcalll	*-0x2(%rbp)
000000010000dae6	.byte 0xff #bad opcode
000000010000dae7	lcalll	*-0x2(%rbp)
000000010000daea	.byte 0xff #bad opcode
000000010000daeb	lcalll	*-0x2(%rbp)
000000010000daee	.byte 0xff #bad opcode
000000010000daef	lcalll	*-0x2(%rbp)
000000010000daf2	.byte 0xff #bad opcode
000000010000daf3	lcalll	*-0x2(%rbp)
000000010000daf6	.byte 0xff #bad opcode
000000010000daf7	incl	0x5dfffffd(%rax)
000000010000dafd	.byte 0xfe #bad opcode
000000010000dafe	.byte 0xff #bad opcode
000000010000daff	lcalll	*-0x2(%rbp)
000000010000db02	.byte 0xff #bad opcode
000000010000db03	lcalll	*-0x2(%rbp)
000000010000db06	.byte 0xff #bad opcode
000000010000db07	pushq	-0x3(%rdi)
000000010000db0a	.byte 0xff #bad opcode
000000010000db0b	lcalll	*-0x2(%rbp)
000000010000db0e	.byte 0xff #bad opcode
000000010000db0f	ljmpl	*-0x3(%rsi)
000000010000db12	.byte 0xff #bad opcode
000000010000db13	decl	0xffffffd(%rcx)
000000010000db19	.byte 0x1f #bad opcode
000000010000db1a	testb	%al, (%rax)
000000010000db1c	addb	%al, (%rax)
000000010000db1e	addb	%al, (%rax)
_tp_eat:
000000010000db20	pushq	%rbp
000000010000db21	movq	%rsp, %rbp
000000010000db24	pushq	%r15
000000010000db26	pushq	%r14
000000010000db28	pushq	%r13
000000010000db2a	pushq	%r12
000000010000db2c	pushq	%rbx
000000010000db2d	pushq	%rax
000000010000db2e	movq	%rsi, %r14
000000010000db31	movq	%rdi, %rbx
000000010000db34	movq	0x8(%rdi), %r13
000000010000db38	movq	0x10(%rdi), %r12
000000010000db3c	cmpq	%r13, %r12
000000010000db3f	jae	0x10000db70
000000010000db41	movq	(%rbx), %rax
000000010000db44	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000db4e	nop
000000010000db50	movzbl	(%rax,%r12), %edx
000000010000db55	cmpq	$0x20, %rdx
000000010000db59	ja	0x10000db70
000000010000db5b	btq	%rdx, %rcx
000000010000db5f	jae	0x10000db70
000000010000db61	incq	%r12
000000010000db64	movq	%r12, 0x10(%rbx)
000000010000db68	cmpq	%r12, %r13
000000010000db6b	jne	0x10000db50
000000010000db6d	movq	%r13, %r12
000000010000db70	movq	%r14, %rdi
000000010000db73	callq	0x100011556                     ## symbol stub for: _strlen
000000010000db78	subq	%r12, %r13
000000010000db7b	xorl	%r15d, %r15d
000000010000db7e	cmpq	%rax, %r13
000000010000db81	jb	0x10000dba8
000000010000db83	movq	(%rbx), %rdi
000000010000db86	addq	%r12, %rdi
000000010000db89	movq	%r14, %rsi
000000010000db8c	movq	%rax, %r14
000000010000db8f	movq	%rax, %rdx
000000010000db92	callq	0x1000114d2                     ## symbol stub for: _memcmp
000000010000db97	testl	%eax, %eax
000000010000db99	jne	0x10000dba8
000000010000db9b	addq	%r14, %r12
000000010000db9e	movq	%r12, 0x10(%rbx)
000000010000dba2	movl	$0x1, %r15d
000000010000dba8	movl	%r15d, %eax
000000010000dbab	addq	$0x8, %rsp
000000010000dbaf	popq	%rbx
000000010000dbb0	popq	%r12
000000010000dbb2	popq	%r13
000000010000dbb4	popq	%r14
000000010000dbb6	popq	%r15
000000010000dbb8	popq	%rbp
000000010000dbb9	retq
000000010000dbba	nopw	(%rax,%rax)
_tp_list_of:
000000010000dbc0	pushq	%rbp
000000010000dbc1	movq	%rsp, %rbp
000000010000dbc4	pushq	%r15
000000010000dbc6	pushq	%r14
000000010000dbc8	pushq	%r13
000000010000dbca	pushq	%r12
000000010000dbcc	pushq	%rbx
000000010000dbcd	subq	$0x28, %rsp
000000010000dbd1	movq	%r8, %r15
000000010000dbd4	movq	%rcx, -0x40(%rbp)
000000010000dbd8	movq	%rsi, %r8
000000010000dbdb	movq	%rdi, %rbx
000000010000dbde	movq	0x8(%rdi), %r12
000000010000dbe2	movq	0x10(%rdi), %r13
000000010000dbe6	cmpq	%r12, %r13
000000010000dbe9	movq	%rdx, -0x30(%rbp)
000000010000dbed	jae	0x10000dc20
000000010000dbef	movq	(%rbx), %rax
000000010000dbf2	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000dbfc	nopl	(%rax)
000000010000dc00	movzbl	(%rax,%r13), %esi
000000010000dc05	cmpq	$0x20, %rsi
000000010000dc09	ja	0x10000dc20
000000010000dc0b	btq	%rsi, %rcx
000000010000dc0f	jae	0x10000dc20
000000010000dc11	incq	%r13
000000010000dc14	movq	%r13, 0x10(%rbx)
000000010000dc18	cmpq	%r13, %r12
000000010000dc1b	jne	0x10000dc00
000000010000dc1d	movq	%r12, %r13
000000010000dc20	movq	%r8, %rdi
000000010000dc23	movq	%r8, -0x48(%rbp)
000000010000dc27	callq	0x100011556                     ## symbol stub for: _strlen
000000010000dc2c	movq	%rax, %r14
000000010000dc2f	movq	%r12, %rcx
000000010000dc32	subq	%r13, %rcx
000000010000dc35	xorl	%eax, %eax
000000010000dc37	cmpq	%r14, %rcx
000000010000dc3a	jb	0x10000dc59
000000010000dc3c	movq	%r15, -0x38(%rbp)
000000010000dc40	movq	(%rbx), %r15
000000010000dc43	leaq	(%r15,%r13), %rdi
000000010000dc47	movq	-0x48(%rbp), %rsi
000000010000dc4b	movq	%r14, %rdx
000000010000dc4e	callq	0x1000114d2                     ## symbol stub for: _memcmp
000000010000dc53	testl	%eax, %eax
000000010000dc55	je	0x10000dc68
000000010000dc57	xorl	%eax, %eax
000000010000dc59	addq	$0x28, %rsp
000000010000dc5d	popq	%rbx
000000010000dc5e	popq	%r12
000000010000dc60	popq	%r13
000000010000dc62	popq	%r14
000000010000dc64	popq	%r15
000000010000dc66	popq	%rbp
000000010000dc67	retq
000000010000dc68	addq	%r13, %r14
000000010000dc6b	movq	%r14, 0x10(%rbx)
000000010000dc6f	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000dc79	cmpq	%r12, %r14
000000010000dc7c	jae	0x10000dcb2
000000010000dc7e	movq	-0x30(%rbp), %rdi
000000010000dc82	nopw	%cs:(%rax,%rax)
000000010000dc90	movzbl	(%r15,%r14), %eax
000000010000dc95	cmpq	$0x20, %rax
000000010000dc99	ja	0x10000dcb6
000000010000dc9b	btq	%rax, %r13
000000010000dc9f	jae	0x10000dcb6
000000010000dca1	incq	%r14
000000010000dca4	movq	%r14, 0x10(%rbx)
000000010000dca8	cmpq	%r14, %r12
000000010000dcab	jne	0x10000dc90
000000010000dcad	movq	%r12, %r14
000000010000dcb0	jmp	0x10000dcb6
000000010000dcb2	movq	-0x30(%rbp), %rdi
000000010000dcb6	callq	0x100011556                     ## symbol stub for: _strlen
000000010000dcbb	subq	%r14, %r12
000000010000dcbe	cmpq	%rax, %r12
000000010000dcc1	jb	0x10000dce0
000000010000dcc3	addq	%r14, %r15
000000010000dcc6	movq	%r15, %rdi
000000010000dcc9	movq	-0x30(%rbp), %rsi
000000010000dccd	movq	%rax, %r12
000000010000dcd0	movq	%rax, %rdx
000000010000dcd3	callq	0x1000114d2                     ## symbol stub for: _memcmp
000000010000dcd8	testl	%eax, %eax
000000010000dcda	je	0x10000ddba
000000010000dce0	movq	%rbx, %rdi
000000010000dce3	movq	-0x38(%rbp), %rsi
000000010000dce7	callq	*-0x40(%rbp)
000000010000dcea	testl	%eax, %eax
000000010000dcec	je	0x10000dc57
000000010000dcf2	movq	0x8(%rbx), %r15
000000010000dcf6	movq	0x10(%rbx), %r14
000000010000dcfa	cmpq	%r15, %r14
000000010000dcfd	jae	0x10000dd32
000000010000dcff	movq	(%rbx), %rax
000000010000dd02	movq	-0x30(%rbp), %r12
000000010000dd06	nopw	%cs:(%rax,%rax)
000000010000dd10	movzbl	(%rax,%r14), %ecx
000000010000dd15	cmpq	$0x20, %rcx
000000010000dd19	ja	0x10000dd36
000000010000dd1b	btq	%rcx, %r13
000000010000dd1f	jae	0x10000dd36
000000010000dd21	incq	%r14
000000010000dd24	movq	%r14, 0x10(%rbx)
000000010000dd28	cmpq	%r14, %r15
000000010000dd2b	jne	0x10000dd10
000000010000dd2d	movq	%r15, %r14
000000010000dd30	jmp	0x10000dd36
000000010000dd32	movq	-0x30(%rbp), %r12
000000010000dd36	movq	%r12, %rdi
000000010000dd39	callq	0x100011556                     ## symbol stub for: _strlen
000000010000dd3e	movq	%r15, %rcx
000000010000dd41	subq	%r14, %rcx
000000010000dd44	cmpq	%rax, %rcx
000000010000dd47	jb	0x10000dd61
000000010000dd49	movq	(%rbx), %rdi
000000010000dd4c	addq	%r14, %rdi
000000010000dd4f	movq	%r12, %rsi
000000010000dd52	movq	%rax, %r12
000000010000dd55	movq	%rax, %rdx
000000010000dd58	callq	0x1000114d2                     ## symbol stub for: _memcmp
000000010000dd5d	testl	%eax, %eax
000000010000dd5f	je	0x10000ddba
000000010000dd61	cmpq	%r14, %r15
000000010000dd64	jbe	0x10000dd92
000000010000dd66	movq	(%rbx), %rax
000000010000dd69	nopl	(%rax)
000000010000dd70	movzbl	(%rax,%r14), %ecx
000000010000dd75	cmpq	$0x20, %rcx
000000010000dd79	ja	0x10000dd92
000000010000dd7b	btq	%rcx, %r13
000000010000dd7f	jae	0x10000dd92
000000010000dd81	incq	%r14
000000010000dd84	movq	%r14, 0x10(%rbx)
000000010000dd88	cmpq	%r14, %r15
000000010000dd8b	jne	0x10000dd70
000000010000dd8d	jmp	0x10000dc57
000000010000dd92	cmpq	%r14, %r15
000000010000dd95	movl	$0x0, %eax
000000010000dd9a	je	0x10000dc59
000000010000dda0	movq	(%rbx), %rcx
000000010000dda3	cmpb	$0x2c, (%rcx,%r14)
000000010000dda8	jne	0x10000dc59
000000010000ddae	incq	%r14
000000010000ddb1	movq	%r14, 0x10(%rbx)
000000010000ddb5	jmp	0x10000dce0
000000010000ddba	addq	%r14, %r12
000000010000ddbd	movq	%r12, 0x10(%rbx)
000000010000ddc1	movl	$0x1, %eax
000000010000ddc6	jmp	0x10000dc59
000000010000ddcb	nopl	(%rax,%rax)
_tp_byte_item:
000000010000ddd0	pushq	%rbp
000000010000ddd1	movq	%rsp, %rbp
000000010000ddd4	pushq	%rbx
000000010000ddd5	pushq	%rax
000000010000ddd6	movq	%rsi, %rbx
000000010000ddd9	leaq	_tp_byte_item.u8d(%rip), %rsi
000000010000dde0	leaq	-0x10(%rbp), %rdx
000000010000dde4	callq	_tp_int
000000010000dde9	testl	%eax, %eax
000000010000ddeb	je	0x10000de00
000000010000dded	movq	-0x10(%rbp), %rsi
000000010000ddf1	movq	%rbx, %rdi
000000010000ddf4	callq	_tp_push
000000010000ddf9	movl	$0x1, %eax
000000010000ddfe	jmp	0x10000de02
000000010000de00	xorl	%eax, %eax
000000010000de02	addq	$0x8, %rsp
000000010000de06	popq	%rbx
000000010000de07	popq	%rbp
000000010000de08	retq
000000010000de09	nopl	(%rax)
_tp_token:
000000010000de10	pushq	%rbp
000000010000de11	movq	%rsp, %rbp
000000010000de14	pushq	%r15
000000010000de16	pushq	%r14
000000010000de18	pushq	%r12
000000010000de1a	pushq	%rbx
000000010000de1b	movq	%rsi, %r14
000000010000de1e	movq	%rdi, %rbx
000000010000de21	movq	(%rdi), %rsi
000000010000de24	movq	0x8(%rdi), %rax
000000010000de28	movq	0x10(%rdi), %r12
000000010000de2c	cmpq	%rax, %r12
000000010000de2f	jae	0x10000de65
000000010000de31	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000de3b	nopl	(%rax,%rax)
000000010000de40	movzbl	(%rsi,%r12), %edi
000000010000de45	cmpq	$0x20, %rdi
000000010000de49	ja	0x10000de65
000000010000de4b	btq	%rdi, %rcx
000000010000de4f	jae	0x10000de65
000000010000de51	incq	%r12
000000010000de54	movq	%r12, 0x10(%rbx)
000000010000de58	cmpq	%r12, %rax
000000010000de5b	jne	0x10000de40
000000010000de5d	movq	%rax, %r12
000000010000de60	movq	%rax, %rcx
000000010000de63	jmp	0x10000deae
000000010000de65	cmpq	%rax, %r12
000000010000de68	jae	0x10000deab
000000010000de6a	leaq	0x6f(%rip), %rdi
000000010000de71	movq	%r12, %rcx
000000010000de74	jmp	0x10000de92
000000010000de76	nopw	%cs:(%rax,%rax)
000000010000de80	cmpl	$0x7d, %r8d
000000010000de84	je	0x10000deae
000000010000de86	incq	%rcx
000000010000de89	movq	%rcx, 0x10(%rbx)
000000010000de8d	cmpq	%rcx, %rax
000000010000de90	je	0x10000de60
000000010000de92	movzbl	(%rsi,%rcx), %r8d
000000010000de97	leal	-0x9(%r8), %r9d
000000010000de9b	cmpl	$0x54, %r9d
000000010000de9f	ja	0x10000de80
000000010000dea1	movslq	(%rdi,%r9,4), %r8
000000010000dea5	addq	%rdi, %r8
000000010000dea8	jmpq	*%r8
000000010000deab	movq	%r12, %rcx
000000010000deae	subq	%r12, %rcx
000000010000deb1	leaq	-0x1(%rdx), %r15
000000010000deb5	cmpq	%rdx, %rcx
000000010000deb8	cmovbq	%rcx, %r15
000000010000debc	addq	%r12, %rsi
000000010000debf	movq	%r14, %rdi
000000010000dec2	movq	%r15, %rdx
000000010000dec5	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000deca	movb	$0x0, (%r14,%r15)
000000010000decf	movq	0x10(%rbx), %rax
000000010000ded3	subq	%r12, %rax
000000010000ded6	popq	%rbx
000000010000ded7	popq	%r12
000000010000ded9	popq	%r14
000000010000dedb	popq	%r15
000000010000dedd	popq	%rbp
000000010000dede	retq
000000010000dedf	nop
000000010000dee0	.byte 0xce #bad opcode
000000010000dee1	.byte 0xff #bad opcode
000000010000dee2	.byte 0xff #bad opcode
000000010000dee3	decl	%esi
000000010000dee5	.byte 0xff #bad opcode
000000010000dee6	.byte 0xff #bad opcode
000000010000dee7	jmpq	*-0x59000001(%rsi)
000000010000deed	.byte 0xff #bad opcode
000000010000deee	.byte 0xff #bad opcode
000000010000deef	decl	%esi
000000010000def1	.byte 0xff #bad opcode
000000010000def2	.byte 0xff #bad opcode
000000010000def3	jmpq	*-0x59000001(%rsi)
000000010000def9	.byte 0xff #bad opcode
000000010000defa	.byte 0xff #bad opcode
000000010000defb	jmpq	*-0x59000001(%rsi)
000000010000df01	.byte 0xff #bad opcode
000000010000df02	.byte 0xff #bad opcode
000000010000df03	jmpq	*-0x59000001(%rsi)
000000010000df09	.byte 0xff #bad opcode
000000010000df0a	.byte 0xff #bad opcode
000000010000df0b	jmpq	*-0x59000001(%rsi)
000000010000df11	.byte 0xff #bad opcode
000000010000df12	.byte 0xff #bad opcode
000000010000df13	jmpq	*-0x59000001(%rsi)
000000010000df19	.byte 0xff #bad opcode
000000010000df1a	.byte 0xff #bad opcode
000000010000df1b	jmpq	*-0x59000001(%rsi)
000000010000df21	.byte 0xff #bad opcode
000000010000df22	.byte 0xff #bad opcode
000000010000df23	jmpq	*-0x59000001(%rsi)
000000010000df29	.byte 0xff #bad opcode
000000010000df2a	.byte 0xff #bad opcode
000000010000df2b	jmpq	*-0x59000001(%rsi)
000000010000df31	.byte 0xff #bad opcode
000000010000df32	.byte 0xff #bad opcode
000000010000df33	jmpq	*-0x59000001(%rsi)
000000010000df39	.byte 0xff #bad opcode
000000010000df3a	.byte 0xff #bad opcode
000000010000df3b	decl	%esi
000000010000df3d	.byte 0xff #bad opcode
000000010000df3e	.byte 0xff #bad opcode
000000010000df3f	jmpq	*-0x59000001(%rsi)
000000010000df45	.byte 0xff #bad opcode
000000010000df46	.byte 0xff #bad opcode
000000010000df47	jmpq	*-0x59000001(%rsi)
000000010000df4d	.byte 0xff #bad opcode
000000010000df4e	.byte 0xff #bad opcode
000000010000df4f	jmpq	*-0x59000001(%rsi)
000000010000df55	.byte 0xff #bad opcode
000000010000df56	.byte 0xff #bad opcode
000000010000df57	jmpq	*-0x31000001(%rsi)
000000010000df5d	.byte 0xff #bad opcode
000000010000df5e	.byte 0xff #bad opcode
000000010000df5f	decl	%esi
000000010000df61	.byte 0xff #bad opcode
000000010000df62	.byte 0xff #bad opcode
000000010000df63	jmpq	*-0x59000001(%rsi)
000000010000df69	.byte 0xff #bad opcode
000000010000df6a	.byte 0xff #bad opcode
000000010000df6b	decl	%esi
000000010000df6d	.byte 0xff #bad opcode
000000010000df6e	.byte 0xff #bad opcode
000000010000df6f	jmpq	*-0x59000001(%rsi)
000000010000df75	.byte 0xff #bad opcode
000000010000df76	.byte 0xff #bad opcode
000000010000df77	jmpq	*-0x59000001(%rsi)
000000010000df7d	.byte 0xff #bad opcode
000000010000df7e	.byte 0xff #bad opcode
000000010000df7f	jmpq	*-0x59000001(%rsi)
000000010000df85	.byte 0xff #bad opcode
000000010000df86	.byte 0xff #bad opcode
000000010000df87	jmpq	*-0x59000001(%rsi)
000000010000df8d	.byte 0xff #bad opcode
000000010000df8e	.byte 0xff #bad opcode
000000010000df8f	jmpq	*-0x59000001(%rsi)
000000010000df95	.byte 0xff #bad opcode
000000010000df96	.byte 0xff #bad opcode
000000010000df97	jmpq	*-0x59000001(%rsi)
000000010000df9d	.byte 0xff #bad opcode
000000010000df9e	.byte 0xff #bad opcode
000000010000df9f	jmpq	*-0x31000001(%rsi)
000000010000dfa5	.byte 0xff #bad opcode
000000010000dfa6	.byte 0xff #bad opcode
000000010000dfa7	jmpq	*-0x59000001(%rsi)
000000010000dfad	.byte 0xff #bad opcode
000000010000dfae	.byte 0xff #bad opcode
000000010000dfaf	jmpq	*-0x59000001(%rsi)
000000010000dfb5	.byte 0xff #bad opcode
000000010000dfb6	.byte 0xff #bad opcode
000000010000dfb7	jmpq	*-0x59000001(%rsi)
000000010000dfbd	.byte 0xff #bad opcode
000000010000dfbe	.byte 0xff #bad opcode
000000010000dfbf	jmpq	*-0x59000001(%rsi)
000000010000dfc5	.byte 0xff #bad opcode
000000010000dfc6	.byte 0xff #bad opcode
000000010000dfc7	jmpq	*-0x59000001(%rsi)
000000010000dfcd	.byte 0xff #bad opcode
000000010000dfce	.byte 0xff #bad opcode
000000010000dfcf	jmpq	*-0x59000001(%rsi)
000000010000dfd5	.byte 0xff #bad opcode
000000010000dfd6	.byte 0xff #bad opcode
000000010000dfd7	jmpq	*-0x59000001(%rsi)
000000010000dfdd	.byte 0xff #bad opcode
000000010000dfde	.byte 0xff #bad opcode
000000010000dfdf	jmpq	*-0x59000001(%rsi)
000000010000dfe5	.byte 0xff #bad opcode
000000010000dfe6	.byte 0xff #bad opcode
000000010000dfe7	jmpq	*-0x59000001(%rsi)
000000010000dfed	.byte 0xff #bad opcode
000000010000dfee	.byte 0xff #bad opcode
000000010000dfef	jmpq	*-0x59000001(%rsi)
000000010000dff5	.byte 0xff #bad opcode
000000010000dff6	.byte 0xff #bad opcode
000000010000dff7	jmpq	*-0x59000001(%rsi)
000000010000dffd	.byte 0xff #bad opcode
000000010000dffe	.byte 0xff #bad opcode
000000010000dfff	jmpq	*-0x59000001(%rsi)
000000010000e005	.byte 0xff #bad opcode
000000010000e006	.byte 0xff #bad opcode
000000010000e007	jmpq	*-0x59000001(%rsi)
000000010000e00d	.byte 0xff #bad opcode
000000010000e00e	.byte 0xff #bad opcode
000000010000e00f	jmpq	*-0x59000001(%rsi)
000000010000e015	.byte 0xff #bad opcode
000000010000e016	.byte 0xff #bad opcode
000000010000e017	jmpq	*-0x59000001(%rsi)
000000010000e01d	.byte 0xff #bad opcode
000000010000e01e	.byte 0xff #bad opcode
000000010000e01f	jmpq	*-0x59000001(%rsi)
000000010000e025	.byte 0xff #bad opcode
000000010000e026	.byte 0xff #bad opcode
000000010000e027	jmpq	*-0x59000001(%rsi)
000000010000e02d	.byte 0xff #bad opcode
000000010000e02e	.byte 0xff #bad opcode
000000010000e02f	decl	%esi
000000010000e031	.byte 0xff #bad opcode
000000010000e032	.byte 0xff #bad opcode
000000010000e033	jmpq	*0x66(%rsi)
000000010000e036	nopw	%cs:(%rax,%rax)
_tp_elem_item:
000000010000e040	pushq	%rbp
000000010000e041	movq	%rsp, %rbp
000000010000e044	pushq	%r14
000000010000e046	pushq	%rbx
000000010000e047	subq	$0x10, %rsp
000000010000e04b	movq	%rsi, %rbx
000000010000e04e	movq	(%rsi), %rsi
000000010000e051	xorl	%r14d, %r14d
000000010000e054	leaq	-0x18(%rbp), %rcx
000000010000e058	xorl	%edx, %edx
000000010000e05a	callq	_tp_value
000000010000e05f	testl	%eax, %eax
000000010000e061	je	0x10000e075
000000010000e063	movq	-0x18(%rbp), %rsi
000000010000e067	movq	%rbx, %rdi
000000010000e06a	callq	_tp_push
000000010000e06f	movl	$0x1, %r14d
000000010000e075	movl	%r14d, %eax
000000010000e078	addq	$0x10, %rsp
000000010000e07c	popq	%rbx
000000010000e07d	popq	%r14
000000010000e07f	popq	%rbp
000000010000e080	retq
000000010000e081	nopw	%cs:(%rax,%rax)
_tp_kv_item:
000000010000e090	pushq	%rbp
000000010000e091	movq	%rsp, %rbp
000000010000e094	pushq	%r15
000000010000e096	pushq	%r14
000000010000e098	pushq	%rbx
000000010000e099	subq	$0x18, %rsp
000000010000e09d	movq	%rsi, %rbx
000000010000e0a0	movq	%rdi, %r14
000000010000e0a3	movq	$0x0, -0x20(%rbp)
000000010000e0ab	movq	(%rsi), %rsi
000000010000e0ae	xorl	%r15d, %r15d
000000010000e0b1	leaq	-0x28(%rbp), %rcx
000000010000e0b5	xorl	%edx, %edx
000000010000e0b7	callq	_tp_value
000000010000e0bc	testl	%eax, %eax
000000010000e0be	je	0x10000e0e6
000000010000e0c0	cmpl	$0x0, 0x28(%rbx)
000000010000e0c4	je	0x10000e0f4
000000010000e0c6	xorl	%r14d, %r14d
000000010000e0c9	movq	-0x28(%rbp), %rsi
000000010000e0cd	movq	%rbx, %rdi
000000010000e0d0	callq	_tp_push
000000010000e0d5	movq	%rbx, %rdi
000000010000e0d8	movq	%r14, %rsi
000000010000e0db	callq	_tp_push
000000010000e0e0	movl	$0x1, %r15d
000000010000e0e6	movl	%r15d, %eax
000000010000e0e9	addq	$0x18, %rsp
000000010000e0ed	popq	%rbx
000000010000e0ee	popq	%r14
000000010000e0f0	popq	%r15
000000010000e0f2	popq	%rbp
000000010000e0f3	retq
000000010000e0f4	movq	0x8(%r14), %rcx
000000010000e0f8	movq	0x10(%r14), %rax
000000010000e0fc	cmpq	%rcx, %rax
000000010000e0ff	jae	0x10000e131
000000010000e101	movq	(%r14), %rdx
000000010000e104	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000e10e	nop
000000010000e110	movzbl	(%rdx,%rax), %edi
000000010000e114	cmpq	$0x20, %rdi
000000010000e118	ja	0x10000e131
000000010000e11a	btq	%rdi, %rsi
000000010000e11e	jae	0x10000e131
000000010000e120	incq	%rax
000000010000e123	movq	%rax, 0x10(%r14)
000000010000e127	cmpq	%rax, %rcx
000000010000e12a	jne	0x10000e110
000000010000e12c	xorl	%r15d, %r15d
000000010000e12f	jmp	0x10000e0e6
000000010000e131	xorl	%r15d, %r15d
000000010000e134	cmpq	%rax, %rcx
000000010000e137	je	0x10000e0e6
000000010000e139	movq	(%r14), %rcx
000000010000e13c	cmpb	$0x3a, (%rcx,%rax)
000000010000e140	jne	0x10000e0e6
000000010000e142	incq	%rax
000000010000e145	movq	%rax, 0x10(%r14)
000000010000e149	movq	0x8(%rbx), %rsi
000000010000e14d	xorl	%r15d, %r15d
000000010000e150	leaq	-0x20(%rbp), %rcx
000000010000e154	movq	%r14, %rdi
000000010000e157	xorl	%edx, %edx
000000010000e159	callq	_tp_value
000000010000e15e	testl	%eax, %eax
000000010000e160	je	0x10000e0e6
000000010000e162	movq	-0x20(%rbp), %r14
000000010000e166	jmp	0x10000e0c9
000000010000e16b	nopl	(%rax,%rax)
_fwp_p_map_insert:
000000010000e170	pushq	%rbp
000000010000e171	movq	%rsp, %rbp
000000010000e174	pushq	%r15
000000010000e176	pushq	%r14
000000010000e178	pushq	%r13
000000010000e17a	pushq	%r12
000000010000e17c	pushq	%rbx
000000010000e17d	subq	$0x38, %rsp
000000010000e181	movq	%rdi, %r8
000000010000e184	movq	(%rdx), %r12
000000010000e187	movq	%rcx, -0x58(%rbp)
000000010000e18b	movl	(%rcx), %eax
000000010000e18d	cmpl	$0x4, %eax
000000010000e190	movq	%rsi, -0x40(%rbp)
000000010000e194	jb	0x10000e1f8
000000010000e196	addl	$-0x5, %eax
000000010000e199	cmpl	$0x4, %eax
000000010000e19c	jae	0x10000e25d
000000010000e1a2	testq	%r12, %r12
000000010000e1a5	je	0x10000e2d2
000000010000e1ab	xorl	%r15d, %r15d
000000010000e1ae	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000e1b8	movq	%r12, %rcx
000000010000e1bb	jmp	0x10000e1cc
000000010000e1bd	nopl	(%rax)
000000010000e1c0	movq	%rdi, %rcx
000000010000e1c3	cmpq	%rcx, %r15
000000010000e1c6	jae	0x10000e2d7
000000010000e1cc	leaq	(%rcx,%r15), %rsi
000000010000e1d0	movq	%rsi, %rdi
000000010000e1d3	shrq	%rdi
000000010000e1d6	andq	%rax, %rsi
000000010000e1d9	movq	0x8(%rdx,%rsi,8), %rsi
000000010000e1de	cmpq	%r8, %rsi
000000010000e1e1	setne	%bl
000000010000e1e4	je	0x10000e258
000000010000e1e6	jae	0x10000e1c0
000000010000e1e8	incq	%rdi
000000010000e1eb	movq	%rdi, %r15
000000010000e1ee	cmpq	%rcx, %r15
000000010000e1f1	jb	0x10000e1cc
000000010000e1f3	jmp	0x10000e2d7
000000010000e1f8	testq	%r12, %r12
000000010000e1fb	je	0x10000e2d2
000000010000e201	xorl	%r15d, %r15d
000000010000e204	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000e20e	movq	%r12, %rcx
000000010000e211	jmp	0x10000e22c
000000010000e213	nopw	%cs:(%rax,%rax)
000000010000e220	movq	%rdi, %rcx
000000010000e223	cmpq	%rcx, %r15
000000010000e226	jae	0x10000e2d7
000000010000e22c	leaq	(%rcx,%r15), %rsi
000000010000e230	movq	%rsi, %rdi
000000010000e233	shrq	%rdi
000000010000e236	andq	%rax, %rsi
000000010000e239	movq	0x8(%rdx,%rsi,8), %rsi
000000010000e23e	cmpq	%r8, %rsi
000000010000e241	setne	%bl
000000010000e244	je	0x10000e258
000000010000e246	jge	0x10000e220
000000010000e248	incq	%rdi
000000010000e24b	movq	%rdi, %r15
000000010000e24e	cmpq	%rcx, %r15
000000010000e251	jb	0x10000e22c
000000010000e253	jmp	0x10000e2d7
000000010000e258	movq	%rdi, %r15
000000010000e25b	jmp	0x10000e2d7
000000010000e25d	testq	%r12, %r12
000000010000e260	je	0x10000e2d2
000000010000e262	xorl	%r15d, %r15d
000000010000e265	movq	%r12, %rax
000000010000e268	movq	%r12, -0x38(%rbp)
000000010000e26c	jmp	0x10000e282
000000010000e26e	nop
000000010000e270	movq	%r12, %rax
000000010000e273	movq	%r14, %rdx
000000010000e276	movq	%r13, %r8
000000010000e279	cmpq	%rax, %r15
000000010000e27c	movq	-0x38(%rbp), %r12
000000010000e280	jae	0x10000e2d7
000000010000e282	movq	%rax, -0x50(%rbp)
000000010000e286	addq	%r15, %rax
000000010000e289	movq	%rax, %r12
000000010000e28c	shrq	%r12
000000010000e28f	movabsq	$0x1ffffffffffffffe, %rcx       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000e299	andq	%rcx, %rax
000000010000e29c	movq	%rdx, %r14
000000010000e29f	movq	0x8(%rdx,%rax,8), %rdi
000000010000e2a4	movq	%r8, %r13
000000010000e2a7	movq	%r8, %rsi
000000010000e2aa	movq	-0x58(%rbp), %rdx
000000010000e2ae	callq	_fwp_cmp
000000010000e2b3	testl	%eax, %eax
000000010000e2b5	setne	%bl
000000010000e2b8	je	0x10000e3fb
000000010000e2be	jns	0x10000e270
000000010000e2c0	incq	%r12
000000010000e2c3	movq	%r12, %r15
000000010000e2c6	movq	%r14, %rdx
000000010000e2c9	movq	%r13, %r8
000000010000e2cc	movq	-0x50(%rbp), %rax
000000010000e2d0	jmp	0x10000e279
000000010000e2d2	movb	$0x1, %bl
000000010000e2d4	xorl	%r15d, %r15d
000000010000e2d7	movzbl	%bl, %r14d
000000010000e2db	addq	%r12, %r14
000000010000e2de	movq	%r14, %rax
000000010000e2e1	shlq	$0x4, %rax
000000010000e2e5	leaq	0x8(%rax), %rdi
000000010000e2e9	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000e2f0	movq	%rdx, -0x30(%rbp)
000000010000e2f4	movq	%r8, -0x48(%rbp)
000000010000e2f8	ja	0x10000e353
000000010000e2fa	addq	$0x17, %rax
000000010000e2fe	shrq	$0x4, %rax
000000010000e302	leaq	_fwp_gc(%rip), %rcx
000000010000e309	movzbl	0xbe8(%rax,%rcx), %eax
000000010000e311	movl	0xb48(%rcx,%rax,4), %esi
000000010000e318	subq	%rsi, _fwp_gc(%rip)
000000010000e31f	js	0x10000e353
000000010000e321	leaq	(%rax,%rax,2), %rax
000000010000e325	leaq	(%rcx,%rax,8), %rax
000000010000e329	addq	$0x788, %rax                    ## imm = 0x788
000000010000e32f	movq	(%rax), %r13
000000010000e332	testq	%r13, %r13
000000010000e335	je	0x10000e343
000000010000e337	movq	(%r13), %rcx
000000010000e33b	notq	%rcx
000000010000e33e	movq	%rcx, (%rax)
000000010000e341	jmp	0x10000e36a
000000010000e343	movq	0x8(%rax), %r13
000000010000e347	movq	0x10(%rax), %rcx
000000010000e34b	subq	%r13, %rcx
000000010000e34e	cmpq	%rsi, %rcx
000000010000e351	jae	0x10000e362
000000010000e353	movl	$0x2, %esi
000000010000e358	callq	_fwp_gc_alloc_slow
000000010000e35d	movq	%rax, %r13
000000010000e360	jmp	0x10000e372
000000010000e362	leaq	(%rsi,%r13), %rcx
000000010000e366	movq	%rcx, 0x8(%rax)
000000010000e36a	movq	%r13, %rdi
000000010000e36d	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000e372	movq	%r14, (%r13)
000000010000e376	leaq	0x8(%r13), %r14
000000010000e37a	movq	-0x30(%rbp), %rsi
000000010000e37e	addq	$0x8, %rsi
000000010000e382	testb	%bl, %bl
000000010000e384	je	0x10000e3cd
000000010000e386	movq	%r15, %rbx
000000010000e389	shlq	$0x4, %rbx
000000010000e38d	movq	%r14, %rdi
000000010000e390	movq	%rbx, %rdx
000000010000e393	movq	%rsi, -0x30(%rbp)
000000010000e397	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000e39c	movq	-0x48(%rbp), %rax
000000010000e3a0	movq	%rax, (%r14,%rbx)
000000010000e3a4	movq	-0x40(%rbp), %rax
000000010000e3a8	movq	%rax, 0x8(%r14,%rbx)
000000010000e3ad	leaq	(%r14,%rbx), %rdi
000000010000e3b1	addq	$0x10, %rdi
000000010000e3b5	addq	-0x30(%rbp), %rbx
000000010000e3b9	subq	%r15, %r12
000000010000e3bc	shlq	$0x4, %r12
000000010000e3c0	movq	%rbx, %rsi
000000010000e3c3	movq	%r12, %rdx
000000010000e3c6	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000e3cb	jmp	0x10000e3e9
000000010000e3cd	shlq	$0x4, %r12
000000010000e3d1	movq	%r14, %rdi
000000010000e3d4	movq	%r12, %rdx
000000010000e3d7	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000e3dc	shlq	$0x4, %r15
000000010000e3e0	movq	-0x40(%rbp), %rax
000000010000e3e4	movq	%rax, 0x8(%r14,%r15)
000000010000e3e9	movq	%r13, %rax
000000010000e3ec	addq	$0x38, %rsp
000000010000e3f0	popq	%rbx
000000010000e3f1	popq	%r12
000000010000e3f3	popq	%r13
000000010000e3f5	popq	%r14
000000010000e3f7	popq	%r15
000000010000e3f9	popq	%rbp
000000010000e3fa	retq
000000010000e3fb	movq	%r12, %r15
000000010000e3fe	movq	-0x38(%rbp), %r12
000000010000e402	movq	%r14, %rdx
000000010000e405	movq	%r13, %r8
000000010000e408	jmp	0x10000e2d7
000000010000e40d	nopl	(%rax)
_fwp_box_u128:
000000010000e410	pushq	%rbp
000000010000e411	movq	%rsp, %rbp
000000010000e414	pushq	%r14
000000010000e416	pushq	%rbx
000000010000e417	leaq	_fwp_gc(%rip), %rax
000000010000e41e	movzbl	0x67cc(%rip), %edx
000000010000e425	movl	0xb48(%rax,%rdx,4), %ecx
000000010000e42c	subq	%rcx, _fwp_gc(%rip)
000000010000e433	js	0x10000e467
000000010000e435	leaq	(%rdx,%rdx,2), %rdx
000000010000e439	leaq	(%rax,%rdx,8), %rdx
000000010000e43d	addq	$0x3c8, %rdx                    ## imm = 0x3C8
000000010000e444	movq	(%rdx), %rax
000000010000e447	testq	%rax, %rax
000000010000e44a	je	0x10000e457
000000010000e44c	movq	(%rax), %rcx
000000010000e44f	notq	%rcx
000000010000e452	movq	%rcx, (%rdx)
000000010000e455	jmp	0x10000e48b
000000010000e457	movq	0x8(%rdx), %rax
000000010000e45b	movq	0x10(%rdx), %r8
000000010000e45f	subq	%rax, %r8
000000010000e462	cmpq	%rcx, %r8
000000010000e465	jae	0x10000e484
000000010000e467	movq	%rdi, %rbx
000000010000e46a	movl	$0x10, %edi
000000010000e46f	movq	%rsi, %r14
000000010000e472	movl	$0x1, %esi
000000010000e477	callq	_fwp_gc_alloc_slow
000000010000e47c	movq	%r14, %rsi
000000010000e47f	movq	%rbx, %rdi
000000010000e482	jmp	0x10000e491
000000010000e484	addq	%rax, %rcx
000000010000e487	movq	%rcx, 0x8(%rdx)
000000010000e48b	xorps	%xmm0, %xmm0
000000010000e48e	movups	%xmm0, (%rax)
000000010000e491	movq	%rsi, 0x8(%rax)
000000010000e495	movq	%rdi, (%rax)
000000010000e498	popq	%rbx
000000010000e499	popq	%r14
000000010000e49b	popq	%rbp
000000010000e49c	retq
000000010000e49d	nopl	(%rax)
_fwp_utf8_put:
000000010000e4a0	pushq	%rbp
000000010000e4a1	movq	%rsp, %rbp
000000010000e4a4	subq	$0x10, %rsp
000000010000e4a8	cmpl	$0x7f, %esi
000000010000e4ab	ja	0x10000e4bb
000000010000e4ad	movb	%sil, -0x4(%rbp)
000000010000e4b1	movl	$0x1, %edx
000000010000e4b6	jmp	0x10000e558
000000010000e4bb	movl	%esi, %eax
000000010000e4bd	cmpl	$0x7ff, %esi                    ## imm = 0x7FF
000000010000e4c3	ja	0x10000e4e0
000000010000e4c5	shrl	$0x6, %eax
000000010000e4c8	orb	$-0x40, %al
000000010000e4ca	movb	%al, -0x4(%rbp)
000000010000e4cd	andb	$0x3f, %sil
000000010000e4d1	orb	$-0x80, %sil
000000010000e4d5	movb	%sil, -0x3(%rbp)
000000010000e4d9	movl	$0x2, %edx
000000010000e4de	jmp	0x10000e558
000000010000e4e0	cmpl	$0xffff, %esi                   ## imm = 0xFFFF
000000010000e4e6	ja	0x10000e50f
000000010000e4e8	shrl	$0xc, %eax
000000010000e4eb	orb	$-0x20, %al
000000010000e4ed	movb	%al, -0x4(%rbp)
000000010000e4f0	movl	%esi, %eax
000000010000e4f2	shrl	$0x6, %eax
000000010000e4f5	andb	$0x3f, %al
000000010000e4f7	orb	$-0x80, %al
000000010000e4f9	movb	%al, -0x3(%rbp)
000000010000e4fc	andb	$0x3f, %sil
000000010000e500	orb	$-0x80, %sil
000000010000e504	movb	%sil, -0x2(%rbp)
000000010000e508	movl	$0x3, %edx
000000010000e50d	jmp	0x10000e558
000000010000e50f	shrl	$0x12, %eax
000000010000e512	movl	%esi, %ecx
000000010000e514	shrl	$0xc, %ecx
000000010000e517	andb	$0x3f, %cl
000000010000e51a	movl	%esi, %edx
000000010000e51c	shrl	$0x6, %edx
000000010000e51f	movd	%eax, %xmm0
000000010000e523	movzbl	%cl, %eax
000000010000e526	pinsrb	$0x1, %eax, %xmm0
000000010000e52c	andb	$0x3f, %dl
000000010000e52f	movzbl	%dl, %eax
000000010000e532	pinsrb	$0x2, %eax, %xmm0
000000010000e538	andb	$0x3f, %sil
000000010000e53c	movzbl	%sil, %eax
000000010000e540	pinsrb	$0x3, %eax, %xmm0
000000010000e546	por	0x3152(%rip), %xmm0
000000010000e54e	movd	%xmm0, -0x4(%rbp)
000000010000e553	movl	$0x4, %edx
000000010000e558	leaq	-0x4(%rbp), %rsi
000000010000e55c	callq	_buf_put
000000010000e561	addq	$0x10, %rsp
000000010000e565	popq	%rbp
000000010000e566	retq
000000010000e567	nopw	(%rax,%rax)
_tp_push:
000000010000e570	pushq	%rbp
000000010000e571	movq	%rsp, %rbp
000000010000e574	pushq	%r15
000000010000e576	pushq	%r14
000000010000e578	pushq	%r13
000000010000e57a	pushq	%r12
000000010000e57c	pushq	%rbx
000000010000e57d	pushq	%rax
000000010000e57e	movq	%rsi, %rdx
000000010000e581	movq	%rdi, %r14
000000010000e584	movq	0x18(%rdi), %r15
000000010000e588	cmpq	0x20(%rdi), %r15
000000010000e58c	jne	0x10000e5ff
000000010000e58e	leaq	(%r15,%r15), %rax
000000010000e592	testq	%r15, %r15
000000010000e595	movl	$0x8, %r13d
000000010000e59b	cmovneq	%rax, %r13
000000010000e59f	movq	%r13, 0x20(%r14)
000000010000e5a3	movq	0x10(%r14), %r12
000000010000e5a7	shlq	$0x3, %r13
000000010000e5ab	cmpq	$0x4000, %r13                   ## imm = 0x4000
000000010000e5b2	movq	%rdx, -0x30(%rbp)
000000010000e5b6	ja	0x10000e615
000000010000e5b8	movq	%r13, %rcx
000000010000e5bb	shrq	$0x4, %rcx
000000010000e5bf	leaq	_fwp_gc(%rip), %rax
000000010000e5c6	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000e5ce	movl	0xb48(%rax,%rcx,4), %esi
000000010000e5d5	subq	%rsi, _fwp_gc(%rip)
000000010000e5dc	js	0x10000e615
000000010000e5de	leaq	(%rcx,%rcx,2), %rcx
000000010000e5e2	leaq	(%rax,%rcx,8), %rax
000000010000e5e6	addq	$0x788, %rax                    ## imm = 0x788
000000010000e5ec	movq	(%rax), %rbx
000000010000e5ef	testq	%rbx, %rbx
000000010000e5f2	je	0x10000e605
000000010000e5f4	movq	(%rbx), %rcx
000000010000e5f7	notq	%rcx
000000010000e5fa	movq	%rcx, (%rax)
000000010000e5fd	jmp	0x10000e634
000000010000e5ff	movq	0x10(%r14), %rbx
000000010000e603	jmp	0x10000e66e
000000010000e605	movq	0x8(%rax), %rbx
000000010000e609	movq	0x10(%rax), %rcx
000000010000e60d	subq	%rbx, %rcx
000000010000e610	cmpq	%rsi, %rcx
000000010000e613	jae	0x10000e62c
000000010000e615	movq	%r13, %rdi
000000010000e618	movl	$0x2, %esi
000000010000e61d	callq	_fwp_gc_alloc_slow
000000010000e622	movq	%rax, %rbx
000000010000e625	testq	%r12, %r12
000000010000e628	jne	0x10000e641
000000010000e62a	jmp	0x10000e662
000000010000e62c	leaq	(%rbx,%rsi), %rcx
000000010000e630	movq	%rcx, 0x8(%rax)
000000010000e634	movq	%rbx, %rdi
000000010000e637	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000e63c	testq	%r12, %r12
000000010000e63f	je	0x10000e662
000000010000e641	shlq	$0x3, %r15
000000010000e645	cmpq	%r13, %r15
000000010000e648	cmovaeq	%r13, %r15
000000010000e64c	movq	%rbx, %rdi
000000010000e64f	movq	%r12, %rsi
000000010000e652	movq	%r15, %rdx
000000010000e655	callq	0x1000114d8                     ## symbol stub for: _memcpy
000000010000e65a	movq	%r12, %rdi
000000010000e65d	callq	_fwp_mem_free
000000010000e662	movq	%rbx, 0x10(%r14)
000000010000e666	movq	0x18(%r14), %r15
000000010000e66a	movq	-0x30(%rbp), %rdx
000000010000e66e	leaq	0x1(%r15), %rax
000000010000e672	movq	%rax, 0x18(%r14)
000000010000e676	movq	%rdx, (%rbx,%r15,8)
000000010000e67a	addq	$0x8, %rsp
000000010000e67e	popq	%rbx
000000010000e67f	popq	%r12
000000010000e681	popq	%r13
000000010000e683	popq	%r14
000000010000e685	popq	%r15
000000010000e687	popq	%rbp
000000010000e688	retq
000000010000e689	nopl	(%rax)
_fwp_cmp:
000000010000e690	pushq	%rbp
000000010000e691	movq	%rsp, %rbp
000000010000e694	pushq	%r15
000000010000e696	pushq	%r14
000000010000e698	pushq	%r13
000000010000e69a	pushq	%r12
000000010000e69c	pushq	%rbx
000000010000e69d	subq	$0x38, %rsp
000000010000e6a1	movq	%rsi, %rbx
000000010000e6a4	movq	%rdi, %r14
000000010000e6a7	movl	(%rdx), %r13d
000000010000e6aa	cmpq	$0x15, %r13
000000010000e6ae	ja	0x10000e6d5
000000010000e6b0	movq	%rdx, %r15
000000010000e6b3	leaq	0x4ba(%rip), %rax
000000010000e6ba	movslq	(%rax,%r13,4), %rcx
000000010000e6be	addq	%rax, %rcx
000000010000e6c1	jmpq	*%rcx
000000010000e6c3	xorl	%ecx, %ecx
000000010000e6c5	cmpq	%rbx, %r14
000000010000e6c8	setg	%cl
000000010000e6cb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e6d0	cmovgel	%ecx, %eax
000000010000e6d3	jmp	0x10000e6e5
000000010000e6d5	xorl	%ecx, %ecx
000000010000e6d7	cmpq	%rbx, %r14
000000010000e6da	seta	%cl
000000010000e6dd	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e6e2	cmovael	%ecx, %eax
000000010000e6e5	addq	$0x38, %rsp
000000010000e6e9	popq	%rbx
000000010000e6ea	popq	%r12
000000010000e6ec	popq	%r13
000000010000e6ee	popq	%r14
000000010000e6f0	popq	%r15
000000010000e6f2	popq	%rbp
000000010000e6f3	retq
000000010000e6f4	movq	%rbx, %rsi
000000010000e6f7	movq	(%r14), %rbx
000000010000e6fa	movq	(%rsi), %r15
000000010000e6fd	addq	$0x8, %r14
000000010000e701	addq	$0x8, %rsi
000000010000e705	cmpq	%r15, %rbx
000000010000e708	movq	%r15, %rdx
000000010000e70b	cmovbq	%rbx, %rdx
000000010000e70f	movq	%r14, %rdi
000000010000e712	callq	0x1000114d2                     ## symbol stub for: _memcmp
000000010000e717	testl	%eax, %eax
000000010000e719	je	0x10000eab5
000000010000e71f	sarl	$0x1f, %eax
000000010000e722	orl	$0x1, %eax
000000010000e725	jmp	0x10000e6e5
000000010000e727	movq	%r14, -0x30(%rbp)
000000010000e72b	movq	(%r14), %rax
000000010000e72e	movq	(%rbx), %r12
000000010000e731	cmpq	%r12, %rax
000000010000e734	movq	%r12, -0x38(%rbp)
000000010000e738	movq	%rax, -0x40(%rbp)
000000010000e73c	cmovbq	%rax, %r12
000000010000e740	testq	%r12, %r12
000000010000e743	je	0x10000e7ac
000000010000e745	movq	%rbx, %r14
000000010000e748	movq	0x38(%r15), %rax
000000010000e74c	movq	%rax, -0x48(%rbp)
000000010000e750	movl	$0x10, %ebx
000000010000e755	jmp	0x10000e769
000000010000e757	nopw	(%rax,%rax)
000000010000e760	addq	$0x10, %rbx
000000010000e764	decq	%r12
000000010000e767	je	0x10000e7ac
000000010000e769	movq	-0x30(%rbp), %rax
000000010000e76d	movq	-0x8(%rax,%rbx), %rdi
000000010000e772	movq	-0x8(%r14,%rbx), %rsi
000000010000e777	movq	-0x48(%rbp), %rdx
000000010000e77b	callq	_fwp_cmp
000000010000e780	testl	%eax, %eax
000000010000e782	jne	0x10000e6e5
000000010000e788	cmpl	$0x12, %r13d
000000010000e78c	jne	0x10000e760
000000010000e78e	movq	-0x30(%rbp), %rax
000000010000e792	movq	(%rax,%rbx), %rdi
000000010000e796	movq	(%r14,%rbx), %rsi
000000010000e79a	movq	0x40(%r15), %rdx
000000010000e79e	callq	_fwp_cmp
000000010000e7a3	testl	%eax, %eax
000000010000e7a5	je	0x10000e760
000000010000e7a7	jmp	0x10000e6e5
000000010000e7ac	xorl	%ecx, %ecx
000000010000e7ae	movq	-0x38(%rbp), %rax
000000010000e7b2	cmpq	%rax, -0x40(%rbp)
000000010000e7b6	jmp	0x10000e6da
000000010000e7bb	movq	(%r14), %rdx
000000010000e7be	movq	0x8(%r14), %rcx
000000010000e7c2	movq	(%rbx), %rdi
000000010000e7c5	movq	0x8(%rbx), %rsi
000000010000e7c9	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e7ce	cmpq	%rdi, %rdx
000000010000e7d1	movq	%rcx, %r8
000000010000e7d4	sbbq	%rsi, %r8
000000010000e7d7	jb	0x10000e6e5
000000010000e7dd	cmpq	%rdx, %rdi
000000010000e7e0	sbbq	%rcx, %rsi
000000010000e7e3	setb	%al
000000010000e7e6	movzbl	%al, %eax
000000010000e7e9	jmp	0x10000e6e5
000000010000e7ee	movl	%r14d, %ecx
000000010000e7f1	sarl	$0x1f, %ecx
000000010000e7f4	shrl	%ecx
000000010000e7f6	xorl	%r14d, %ecx
000000010000e7f9	movl	%ebx, %edx
000000010000e7fb	sarl	$0x1f, %edx
000000010000e7fe	shrl	%edx
000000010000e800	xorl	%ebx, %edx
000000010000e802	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e807	cmpl	%edx, %ecx
000000010000e809	jl	0x10000e6e5
000000010000e80f	jmp	0x10000e839
000000010000e811	movq	%r14, %rcx
000000010000e814	sarq	$0x3f, %rcx
000000010000e818	shrq	%rcx
000000010000e81b	xorq	%r14, %rcx
000000010000e81e	movq	%rbx, %rdx
000000010000e821	sarq	$0x3f, %rdx
000000010000e825	shrq	%rdx
000000010000e828	xorq	%rbx, %rdx
000000010000e82b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e830	cmpq	%rdx, %rcx
000000010000e833	jl	0x10000e6e5
000000010000e839	setg	%al
000000010000e83c	movzbl	%al, %eax
000000010000e83f	jmp	0x10000e6e5
000000010000e844	movq	(%r14), %rdx
000000010000e847	movq	0x8(%r14), %rcx
000000010000e84b	movq	(%rbx), %rdi
000000010000e84e	movq	0x8(%rbx), %rsi
000000010000e852	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e857	cmpq	%rdi, %rdx
000000010000e85a	movq	%rcx, %r8
000000010000e85d	sbbq	%rsi, %r8
000000010000e860	jl	0x10000e6e5
000000010000e866	cmpq	%rdx, %rdi
000000010000e869	sbbq	%rcx, %rsi
000000010000e86c	setl	%al
000000010000e86f	movzbl	%al, %eax
000000010000e872	jmp	0x10000e6e5
000000010000e877	testq	%r14, %r14
000000010000e87a	sete	%al
000000010000e87d	testq	%rbx, %rbx
000000010000e880	sete	%cl
000000010000e883	orb	%al, %cl
000000010000e885	je	0x10000eabf
000000010000e88b	testq	%rbx, %rbx
000000010000e88e	setne	%cl
000000010000e891	orb	%al, %cl
000000010000e893	xorb	$0x1, %cl
000000010000e896	movzbl	%cl, %ecx
000000010000e899	testb	%al, %al
000000010000e89b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e8a0	cmovel	%ecx, %eax
000000010000e8a3	testq	%rbx, %rbx
000000010000e8a6	cmovel	%ecx, %eax
000000010000e8a9	jmp	0x10000e6e5
000000010000e8ae	movq	%r14, %r13
000000010000e8b1	movq	%rbx, %r14
000000010000e8b4	movslq	0x10(%r15), %rbx
000000010000e8b8	testq	%rbx, %rbx
000000010000e8bb	jle	0x10000eb6a
000000010000e8c1	movq	0x20(%r15), %r15
000000010000e8c5	xorl	%r12d, %r12d
000000010000e8c8	nopl	(%rax,%rax)
000000010000e8d0	movq	0x8(%r13,%r12,8), %rdi
000000010000e8d5	movq	0x8(%r14,%r12,8), %rsi
000000010000e8da	movq	(%r15,%r12,8), %rdx
000000010000e8de	callq	_fwp_cmp
000000010000e8e3	testl	%eax, %eax
000000010000e8e5	jne	0x10000e6e5
000000010000e8eb	incq	%r12
000000010000e8ee	xorl	%eax, %eax
000000010000e8f0	cmpq	%r12, %rbx
000000010000e8f3	jne	0x10000e8d0
000000010000e8f5	jmp	0x10000e6e5
000000010000e8fa	movq	(%r14), %rax
000000010000e8fd	movabsq	$0x7fffffffffffffff, %r13       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000e907	movq	%rax, -0x30(%rbp)
000000010000e90b	andq	%r13, %rax
000000010000e90e	movq	(%rbx), %rcx
000000010000e911	movq	%rcx, -0x48(%rbp)
000000010000e915	andq	%rcx, %r13
000000010000e918	cmpq	%r13, %rax
000000010000e91b	movq	%r13, -0x58(%rbp)
000000010000e91f	movq	%rax, -0x50(%rbp)
000000010000e923	cmovbq	%rax, %r13
000000010000e927	testq	%r13, %r13
000000010000e92a	je	0x10000ea80
000000010000e930	movq	0x38(%r15), %r15
000000010000e934	leaq	0x8(%r14), %rax
000000010000e938	movq	%rax, -0x40(%rbp)
000000010000e93c	leaq	0x8(%rbx), %rax
000000010000e940	movq	%rax, -0x38(%rbp)
000000010000e944	xorl	%r12d, %r12d
000000010000e947	nopw	(%rax,%rax)
000000010000e950	movl	$0x8, %eax
000000010000e955	testq	%r15, %r15
000000010000e958	je	0x10000e96e
000000010000e95a	movl	(%r15), %ecx
000000010000e95d	cmpq	$0xa, %rcx
000000010000e961	ja	0x10000e96e
000000010000e963	leaq	0x301e(%rip), %rax
000000010000e96a	movq	(%rax,%rcx,8), %rax
000000010000e96e	movq	-0x40(%rbp), %rcx
000000010000e972	cmpq	$0x0, -0x30(%rbp)
000000010000e977	jns	0x10000e97d
000000010000e979	movq	0x10(%r14), %rcx
000000010000e97d	movq	%rax, %rdx
000000010000e980	imulq	%r12, %rdx
000000010000e984	cmpq	$0x8, %rax
000000010000e988	je	0x10000e9b5
000000010000e98a	cmpq	$0x2, %rax
000000010000e98e	je	0x10000e9a5
000000010000e990	cmpq	$0x1, %rax
000000010000e994	jne	0x10000e9c3
000000010000e996	movzbl	(%rcx,%rdx), %ecx
000000010000e99a	movl	(%r15), %eax
000000010000e99d	testl	%eax, %eax
000000010000e99f	movsbq	%cl, %rdi
000000010000e9a3	jmp	0x10000e9cf
000000010000e9a5	movzwl	(%rcx,%rdx), %ecx
000000010000e9a9	movl	(%r15), %eax
000000010000e9ac	cmpl	$0x1, %eax
000000010000e9af	movswq	%cx, %rdi
000000010000e9b3	jmp	0x10000e9cf
000000010000e9b5	movq	(%rcx,%rdx), %rdi
000000010000e9b9	testq	%r15, %r15
000000010000e9bc	je	0x10000ea09
000000010000e9be	movl	(%r15), %eax
000000010000e9c1	jmp	0x10000e9d3
000000010000e9c3	movl	(%rcx,%rdx), %ecx
000000010000e9c6	movl	(%r15), %eax
000000010000e9c9	cmpl	$0x2, %eax
000000010000e9cc	movslq	%ecx, %rdi
000000010000e9cf	cmovneq	%rcx, %rdi
000000010000e9d3	cmpl	$0xa, %eax
000000010000e9d6	ja	0x10000ea09
000000010000e9d8	movl	$0x484, %ecx                    ## imm = 0x484
000000010000e9dd	btl	%eax, %ecx
000000010000e9e0	jb	0x10000ea02
000000010000e9e2	movl	$0x1, %ecx
000000010000e9e7	movl	$0x21, %edx
000000010000e9ec	btl	%eax, %edx
000000010000e9ef	jb	0x10000ea0e
000000010000e9f1	movl	$0x42, %ecx
000000010000e9f6	btl	%eax, %ecx
000000010000e9f9	jae	0x10000ea09
000000010000e9fb	movl	$0x2, %ecx
000000010000ea00	jmp	0x10000ea0e
000000010000ea02	movl	$0x4, %ecx
000000010000ea07	jmp	0x10000ea0e
000000010000ea09	movl	$0x8, %ecx
000000010000ea0e	movq	-0x38(%rbp), %rax
000000010000ea12	cmpq	$0x0, -0x48(%rbp)
000000010000ea17	jns	0x10000ea1d
000000010000ea19	movq	0x10(%rbx), %rax
000000010000ea1d	movq	%rcx, %rdx
000000010000ea20	imulq	%r12, %rdx
000000010000ea24	cmpq	$0x1, %rcx
000000010000ea28	je	0x10000ea48
000000010000ea2a	cmpl	$0x2, %ecx
000000010000ea2d	je	0x10000ea3a
000000010000ea2f	cmpl	$0x8, %ecx
000000010000ea32	jne	0x10000ea56
000000010000ea34	movq	(%rax,%rdx), %rsi
000000010000ea38	jmp	0x10000ea64
000000010000ea3a	cmpl	$0x1, (%r15)
000000010000ea3e	movzwl	(%rax,%rdx), %eax
000000010000ea42	movswq	%ax, %rsi
000000010000ea46	jmp	0x10000ea60
000000010000ea48	cmpl	$0x0, (%r15)
000000010000ea4c	movzbl	(%rax,%rdx), %eax
000000010000ea50	movsbq	%al, %rsi
000000010000ea54	jmp	0x10000ea60
000000010000ea56	cmpl	$0x2, (%r15)
000000010000ea5a	movl	(%rax,%rdx), %eax
000000010000ea5d	movslq	%eax, %rsi
000000010000ea60	cmovneq	%rax, %rsi
000000010000ea64	movq	%r15, %rdx
000000010000ea67	callq	_fwp_cmp
000000010000ea6c	testl	%eax, %eax
000000010000ea6e	jne	0x10000e6e5
000000010000ea74	incq	%r12
000000010000ea77	cmpq	%r12, %r13
000000010000ea7a	jne	0x10000e950
000000010000ea80	xorl	%ecx, %ecx
000000010000ea82	movq	-0x50(%rbp), %rax
000000010000ea86	cmpq	-0x58(%rbp), %rax
000000010000ea8a	jmp	0x10000e6da
000000010000ea8f	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000ea96	ja	0x10000eb06
000000010000ea98	movl	%r14d, %eax
000000010000ea9b	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000eaa2	jbe	0x10000eb12
000000010000eaa4	movl	(%rbx), %ecx
000000010000eaa6	cmpl	%ecx, %eax
000000010000eaa8	je	0x10000eb18
000000010000eaaa	seta	%al
000000010000eaad	movzbl	%al, %ecx
000000010000eab0	jmp	0x10000e6dd
000000010000eab5	xorl	%ecx, %ecx
000000010000eab7	cmpq	%r15, %rbx
000000010000eaba	jmp	0x10000e6da
000000010000eabf	movq	0x38(%r15), %r15
000000010000eac3	nopw	%cs:(%rax,%rax)
000000010000ead0	movq	0x8(%r14), %rdi
000000010000ead4	movq	0x8(%rbx), %rsi
000000010000ead8	movq	%r15, %rdx
000000010000eadb	callq	_fwp_cmp
000000010000eae0	testl	%eax, %eax
000000010000eae2	jne	0x10000e6e5
000000010000eae8	movq	0x10(%r14), %r14
000000010000eaec	movq	0x10(%rbx), %rbx
000000010000eaf0	testq	%r14, %r14
000000010000eaf3	sete	%al
000000010000eaf6	je	0x10000e88b
000000010000eafc	testq	%rbx, %rbx
000000010000eaff	jne	0x10000ead0
000000010000eb01	jmp	0x10000e88b
000000010000eb06	movl	(%r14), %eax
000000010000eb09	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000eb10	ja	0x10000eaa4
000000010000eb12	movl	%ebx, %ecx
000000010000eb14	cmpl	%ecx, %eax
000000010000eb16	jne	0x10000eaaa
000000010000eb18	movq	%r14, %r13
000000010000eb1b	movq	%rbx, %r14
000000010000eb1e	movq	0x28(%r15), %rcx
000000010000eb22	movl	%eax, %eax
000000010000eb24	movslq	(%rcx,%rax,4), %rbx
000000010000eb28	testq	%rbx, %rbx
000000010000eb2b	jle	0x10000eb6a
000000010000eb2d	movq	0x30(%r15), %rcx
000000010000eb31	movq	(%rcx,%rax,8), %r15
000000010000eb35	xorl	%r12d, %r12d
000000010000eb38	nopl	(%rax,%rax)
000000010000eb40	movq	0x8(%r13,%r12,8), %rdi
000000010000eb45	movq	0x8(%r14,%r12,8), %rsi
000000010000eb4a	movq	(%r15,%r12,8), %rdx
000000010000eb4e	callq	_fwp_cmp
000000010000eb53	testl	%eax, %eax
000000010000eb55	jne	0x10000e6e5
000000010000eb5b	incq	%r12
000000010000eb5e	xorl	%eax, %eax
000000010000eb60	cmpq	%r12, %rbx
000000010000eb63	jne	0x10000eb40
000000010000eb65	jmp	0x10000e6e5
000000010000eb6a	xorl	%eax, %eax
000000010000eb6c	jmp	0x10000e6e5
000000010000eb71	nopl	(%rax)
000000010000eb74	sti
000000010000eb76	.byte 0xff #bad opcode
000000010000eb77	decl	-0x5(%rdi)
000000010000eb7a	.byte 0xff #bad opcode
000000010000eb7b	decl	-0x5(%rdi)
000000010000eb7e	.byte 0xff #bad opcode
000000010000eb7f	decl	-0x5(%rdi)
000000010000eb82	.byte 0xff #bad opcode
000000010000eb83	callq	*%rax
000000010000eb85	cld
000000010000eb86	.byte 0xff #bad opcode
000000010000eb87	jmpq	*-0x5(%rcx)
000000010000eb8a	.byte 0xff #bad opcode
000000010000eb8b	jmpq	*-0x5(%rcx)
000000010000eb8e	.byte 0xff #bad opcode
000000010000eb8f	jmpq	*-0x5(%rcx)
000000010000eb92	.byte 0xff #bad opcode
000000010000eb93	jmpq	*-0x5(%rcx)
000000010000eb96	.byte 0xff #bad opcode
000000010000eb97	incl	-0x4(%rdi)
000000010000eb9a	.byte 0xff #bad opcode
000000010000eb9b	.byte 0xff #bad opcode
000000010000eb9c	jp	0x10000eb9a
000000010000eb9e	.byte 0xff #bad opcode
000000010000eb9f	lcalll	*-0x7f000004(%rbp)
000000010000eba5	sti
000000010000eba6	.byte 0xff #bad opcode
000000010000eba7	incl	0x1bfffffb(%rax)
000000010000ebad	.byte 0xff #bad opcode
000000010000ebae	.byte 0xff #bad opcode
000000010000ebaf	incl	(%rbx)
000000010000ebb1	std
000000010000ebb2	.byte 0xff #bad opcode
000000010000ebb3	.byte 0xff #bad opcode
000000010000ebb4	cmpb	%ch, %bh
000000010000ebb6	.byte 0xff #bad opcode
000000010000ebb7	incl	-0x4c000003(%rsi)
000000010000ebbd	sti
000000010000ebbe	.byte 0xff #bad opcode
000000010000ebbf	pushq	0x4ffffffb(%rbx)
000000010000ebc5	sti
000000010000ebc6	.byte 0xff #bad opcode
000000010000ebc7	decl	-0x5(%rdi)
000000010000ebca	.byte 0xff #bad opcode
000000010000ebcb	decl	(%rdi)
000000010000ebcd	.byte 0x1f #bad opcode
000000010000ebce	addb	%dl, 0x48(%rbp)
000000010000ebd2	movl	%esp, %ebp
000000010000ebd4	pushq	%r15
000000010000ebd6	pushq	%r14
000000010000ebd8	pushq	%r13
000000010000ebda	pushq	%r12
000000010000ebdc	pushq	%rbx
000000010000ebdd	subq	$0x268, %rsp                    ## imm = 0x268
000000010000ebe4	movq	0x4445(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ebeb	movq	(%rax), %rax
000000010000ebee	movq	%rax, -0x30(%rbp)
000000010000ebf2	movl	(%rdx), %eax
000000010000ebf4	cmpq	$0x19, %rax
000000010000ebf8	ja	0x10000febb
000000010000ebfe	movq	%rdx, %r15
000000010000ec01	movq	%rsi, %r14
000000010000ec04	movq	%rdi, %r13
000000010000ec07	leaq	0x141e(%rip), %rdx
000000010000ec0e	movslq	(%rdx,%rax,4), %rsi
000000010000ec12	addq	%rdx, %rsi
000000010000ec15	movq	%rdi, -0x278(%rbp)
000000010000ec1c	jmpq	*%rsi
000000010000ec1e	leaq	0x3ca0(%rip), %rdx              ## literal pool for: "%lld"
000000010000ec25	jmp	0x10000ec2e
000000010000ec27	leaq	0x3c9c(%rip), %rdx              ## literal pool for: "%llu"
000000010000ec2e	leaq	-0x270(%rbp), %rbx
000000010000ec35	movl	$0x200, %esi                    ## imm = 0x200
000000010000ec3a	movq	%rbx, %rdi
000000010000ec3d	movq	%r14, %rcx
000000010000ec40	xorl	%eax, %eax
000000010000ec42	callq	0x10001153e                     ## symbol stub for: _snprintf
000000010000ec47	jmp	0x10000fea5
000000010000ec4c	cmpl	$0x13, %eax
000000010000ec4f	leaq	0x3ca5(%rip), %rax              ## literal pool for: "set{"
000000010000ec56	leaq	0x3ca3(%rip), %rsi              ## literal pool for: "map{"
000000010000ec5d	cmoveq	%rax, %rsi
000000010000ec61	movl	$0x4, %edx
000000010000ec66	movq	%r13, %rdi
000000010000ec69	callq	_buf_put
000000010000ec6e	cmpq	$0x0, (%r14)
000000010000ec72	je	0x10000ed4e
000000010000ec78	movq	0x38(%r15), %rdx
000000010000ec7c	movq	0x8(%r14), %rsi
000000010000ec80	movq	-0x278(%rbp), %rbx
000000010000ec87	movq	%rbx, %rdi
000000010000ec8a	xorl	%ecx, %ecx
000000010000ec8c	callq	_fwp_write
000000010000ec91	cmpl	$0x12, (%r15)
000000010000ec95	jne	0x10000ecbd
000000010000ec97	leaq	0x3c67(%rip), %rsi              ## literal pool for: ": "
000000010000ec9e	movl	$0x2, %edx
000000010000eca3	movq	%rbx, %rdi
000000010000eca6	callq	_buf_put
000000010000ecab	movq	0x10(%r14), %rsi
000000010000ecaf	movq	0x40(%r15), %rdx
000000010000ecb3	movq	%rbx, %rdi
000000010000ecb6	xorl	%ecx, %ecx
000000010000ecb8	callq	_fwp_write
000000010000ecbd	cmpq	$0x2, (%r14)
000000010000ecc1	jb	0x10000ed4e
000000010000ecc7	leaq	0x20(%r14), %r13
000000010000eccb	movl	$0x1, %r12d
000000010000ecd1	jmp	0x10000ecec
000000010000ecd3	nopw	%cs:(%rax,%rax)
000000010000ece0	incq	%r12
000000010000ece3	addq	$0x10, %r13
000000010000ece7	cmpq	(%r14), %r12
000000010000ecea	jae	0x10000ed4e
000000010000ecec	movl	$0x2, %edx
000000010000ecf1	movq	-0x278(%rbp), %rbx
000000010000ecf8	movq	%rbx, %rdi
000000010000ecfb	leaq	0x3b42(%rip), %rsi              ## literal pool for: ", "
000000010000ed02	callq	_buf_put
000000010000ed07	movq	-0x8(%r13), %rsi
000000010000ed0b	movq	0x38(%r15), %rdx
000000010000ed0f	movq	%rbx, %rdi
000000010000ed12	xorl	%ecx, %ecx
000000010000ed14	callq	_fwp_write
000000010000ed19	cmpl	$0x12, (%r15)
000000010000ed1d	jne	0x10000ece0
000000010000ed1f	movl	$0x2, %edx
000000010000ed24	movq	-0x278(%rbp), %rbx
000000010000ed2b	movq	%rbx, %rdi
000000010000ed2e	leaq	0x3bd0(%rip), %rsi              ## literal pool for: ": "
000000010000ed35	callq	_buf_put
000000010000ed3a	movq	(%r13), %rsi
000000010000ed3e	movq	0x40(%r15), %rdx
000000010000ed42	movq	%rbx, %rdi
000000010000ed45	xorl	%ecx, %ecx
000000010000ed47	callq	_fwp_write
000000010000ed4c	jmp	0x10000ece0
000000010000ed4e	movb	$0x7d, -0x270(%rbp)
000000010000ed55	leaq	-0x270(%rbp), %rsi
000000010000ed5c	movl	$0x1, %edx
000000010000ed61	movq	-0x278(%rbp), %rdi
000000010000ed68	jmp	0x10000feb6
000000010000ed6d	movq	0x8(%r15), %rbx
000000010000ed71	testq	%rbx, %rbx
000000010000ed74	je	0x10000f768
000000010000ed7a	leaq	0x3aec(%rip), %rsi              ## literal pool for: "Duration"
000000010000ed81	movq	%rbx, %rdi
000000010000ed84	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000ed89	testl	%eax, %eax
000000010000ed8b	je	0x10000fa13
000000010000ed91	movq	%r15, -0x280(%rbp)
000000010000ed98	addq	$0x10, %r15
000000010000ed9c	movq	%rbx, %rdi
000000010000ed9f	callq	0x100011556                     ## symbol stub for: _strlen
000000010000eda4	movq	%r13, %rdi
000000010000eda7	movq	%rbx, %rsi
000000010000edaa	movq	%rax, %rdx
000000010000edad	callq	_buf_put
000000010000edb2	movb	$0x20, -0x270(%rbp)
000000010000edb9	leaq	-0x270(%rbp), %rsi
000000010000edc0	movl	$0x1, %edx
000000010000edc5	movq	%r13, %rdi
000000010000edc8	callq	_buf_put
000000010000edcd	xorl	%r12d, %r12d
000000010000edd0	jmp	0x10000f789
000000010000edd5	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000eddc	ja	0x10000f5a4
000000010000ede2	movl	%r14d, %eax
000000010000ede5	jmp	0x10000f5a7
000000010000edea	movq	%r14, %xmm0
000000010000edef	movq	%xmm0, -0x278(%rbp)
000000010000edf7	ucomisd	%xmm0, %xmm0
000000010000edfb	jp	0x10001001d
000000010000ee01	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000ee0b	andq	%r14, %rax
000000010000ee0e	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
000000010000ee18	cmpq	%rcx, %rax
000000010000ee1b	je	0x10000f728
000000010000ee21	movl	$0x1, %ebx
000000010000ee26	leaq	-0x270(%rbp), %r14
000000010000ee2d	nopl	(%rax)
000000010000ee30	movq	%r14, %rdi
000000010000ee33	movsd	-0x278(%rbp), %xmm0
000000010000ee3b	movl	%ebx, %esi
000000010000ee3d	callq	_fwp_format_g
000000010000ee42	movq	%r14, %rdi
000000010000ee45	xorl	%esi, %esi
000000010000ee47	callq	0x100011568                     ## symbol stub for: _strtod
000000010000ee4c	ucomisd	-0x278(%rbp), %xmm0
000000010000ee54	jne	0x10000ee5c
000000010000ee56	jnp	0x10000f4b9
000000010000ee5c	incl	%ebx
000000010000ee5e	cmpl	$0x12, %ebx
000000010000ee61	jne	0x10000ee30
000000010000ee63	leaq	-0x270(%rbp), %rbx
000000010000ee6a	movq	%rbx, %rdi
000000010000ee6d	movsd	-0x278(%rbp), %xmm0
000000010000ee75	movl	$0x11, %esi
000000010000ee7a	callq	_fwp_format_g
000000010000ee7f	movq	%rbx, %rdi
000000010000ee82	jmp	0x10000f4c0
000000010000ee87	movb	$0x3c, -0x270(%rbp)
000000010000ee8e	leaq	-0x270(%rbp), %rsi
000000010000ee95	movl	$0x1, %edx
000000010000ee9a	movq	%r13, %rdi
000000010000ee9d	callq	_buf_put
000000010000eea2	movq	0x8(%r15), %rbx
000000010000eea6	movq	%rbx, %rdi
000000010000eea9	callq	0x100011556                     ## symbol stub for: _strlen
000000010000eeae	movq	%r13, %rdi
000000010000eeb1	movq	%rbx, %rsi
000000010000eeb4	jmp	0x10000f590
000000010000eeb9	movq	0x4170(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000eec0	movq	(%rax), %rax
000000010000eec3	cmpq	-0x30(%rbp), %rax
000000010000eec7	jne	0x100010018
000000010000eecd	leaq	0x3a06(%rip), %rsi              ## literal pool for: "<opaque>"
000000010000eed4	movl	$0x8, %edx
000000010000eed9	movq	%r13, %rdi
000000010000eedc	jmp	0x10000fc66
000000010000eee1	leaq	0x8(%r14), %rsi
000000010000eee5	movq	(%r14), %rdx
000000010000eee8	movq	0x4141(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000eeef	movq	(%rax), %rax
000000010000eef2	testl	%ecx, %ecx
000000010000eef4	je	0x10000f8c6
000000010000eefa	cmpq	-0x30(%rbp), %rax
000000010000eefe	jne	0x100010018
000000010000ef04	movq	%r13, %rdi
000000010000ef07	jmp	0x10000fc66
000000010000ef0c	movq	(%r14), %r9
000000010000ef0f	movq	0x8(%r14), %r8
000000010000ef13	movq	%r9, %rax
000000010000ef16	orq	%r8, %rax
000000010000ef19	je	0x10000f8e9
000000010000ef1f	xorl	%edi, %edi
000000010000ef21	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000ef2b	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000ef35	movq	%r8, %rbx
000000010000ef38	nopl	(%rax,%rax)
000000010000ef40	movq	%r8, %rcx
000000010000ef43	shldq	$0x3f, %r9, %rcx
000000010000ef48	shrq	%rbx
000000010000ef4b	movq	%rcx, %rsi
000000010000ef4e	addq	%rbx, %rsi
000000010000ef51	adcq	$0x0, %rsi
000000010000ef55	movq	%rsi, %rax
000000010000ef58	mulq	%r10
000000010000ef5b	shrq	$0x2, %rdx
000000010000ef5f	leaq	(%rdx,%rdx,4), %rax
000000010000ef63	subq	%rax, %rsi
000000010000ef66	subq	%rsi, %rcx
000000010000ef69	sbbq	$0x0, %rbx
000000010000ef6d	movq	%rcx, %rsi
000000010000ef70	imulq	%r11, %rsi
000000010000ef74	movq	%rcx, %rax
000000010000ef77	mulq	%r10
000000010000ef7a	addq	%rsi, %rdx
000000010000ef7d	imulq	%r10, %rbx
000000010000ef81	addq	%rdx, %rbx
000000010000ef84	movq	%rax, %rcx
000000010000ef87	addq	%rax, %rcx
000000010000ef8a	leaq	(%rcx,%rcx,4), %rcx
000000010000ef8e	movl	%r9d, %edx
000000010000ef91	subl	%ecx, %edx
000000010000ef93	orb	$0x30, %dl
000000010000ef96	movb	%dl, -0x70(%rbp,%rdi)
000000010000ef9a	incq	%rdi
000000010000ef9d	cmpq	$0xa, %r9
000000010000efa1	sbbq	$0x0, %r8
000000010000efa5	movq	%rax, %r9
000000010000efa8	movq	%rbx, %r8
000000010000efab	jae	0x10000ef40
000000010000efad	testl	%edi, %edi
000000010000efaf	jg	0x10000f8f2
000000010000efb5	jmp	0x10000f065
000000010000efba	movq	(%r14), %r9
000000010000efbd	movq	0x8(%r14), %r10
000000010000efc1	testq	%r10, %r10
000000010000efc4	js	0x10000f914
000000010000efca	movq	%r9, %rax
000000010000efcd	orq	%r10, %rax
000000010000efd0	je	0x10000fa32
000000010000efd6	xorl	%edi, %edi
000000010000efd8	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
000000010000efe2	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000efec	movq	%r10, %rbx
000000010000efef	nop
000000010000eff0	movq	%r10, %rcx
000000010000eff3	shldq	$0x3f, %r9, %rcx
000000010000eff8	shrq	%rbx
000000010000effb	movq	%rcx, %rsi
000000010000effe	addq	%rbx, %rsi
000000010000f001	adcq	$0x0, %rsi
000000010000f005	movq	%rsi, %rax
000000010000f008	mulq	%r8
000000010000f00b	shrq	$0x2, %rdx
000000010000f00f	leaq	(%rdx,%rdx,4), %rax
000000010000f013	subq	%rax, %rsi
000000010000f016	subq	%rsi, %rcx
000000010000f019	sbbq	$0x0, %rbx
000000010000f01d	movq	%rcx, %rsi
000000010000f020	imulq	%r11, %rsi
000000010000f024	movq	%rcx, %rax
000000010000f027	mulq	%r8
000000010000f02a	addq	%rsi, %rdx
000000010000f02d	imulq	%r8, %rbx
000000010000f031	addq	%rdx, %rbx
000000010000f034	movq	%rax, %rcx
000000010000f037	addq	%rax, %rcx
000000010000f03a	leaq	(%rcx,%rcx,4), %rcx
000000010000f03e	movl	%r9d, %edx
000000010000f041	subl	%ecx, %edx
000000010000f043	orb	$0x30, %dl
000000010000f046	movb	%dl, -0x70(%rbp,%rdi)
000000010000f04a	incq	%rdi
000000010000f04d	cmpq	$0xa, %r9
000000010000f051	sbbq	$0x0, %r10
000000010000f055	movq	%rax, %r9
000000010000f058	movq	%rbx, %r10
000000010000f05b	jae	0x10000eff0
000000010000f05d	testl	%edi, %edi
000000010000f05f	jg	0x10000fa3b
000000010000f065	xorl	%eax, %eax
000000010000f067	jmp	0x10000fe96
000000010000f06c	movb	$0x5b, -0x270(%rbp)
000000010000f073	leaq	-0x270(%rbp), %rsi
000000010000f07a	movl	$0x1, %edx
000000010000f07f	movq	%r13, %rdi
000000010000f082	callq	_buf_put
000000010000f087	testq	%r14, %r14
000000010000f08a	je	0x10000fd84
000000010000f090	movq	0x38(%r15), %rdx
000000010000f094	movq	0x8(%r14), %rsi
000000010000f098	movq	%r13, %rdi
000000010000f09b	xorl	%ecx, %ecx
000000010000f09d	callq	_fwp_write
000000010000f0a2	movq	0x10(%r14), %r14
000000010000f0a6	testq	%r14, %r14
000000010000f0a9	je	0x10000fd84
000000010000f0af	leaq	0x378e(%rip), %rbx              ## literal pool for: ", "
000000010000f0b6	nopw	%cs:(%rax,%rax)
000000010000f0c0	movl	$0x2, %edx
000000010000f0c5	movq	%r13, %rdi
000000010000f0c8	movq	%rbx, %rsi
000000010000f0cb	callq	_buf_put
000000010000f0d0	movq	0x8(%r14), %rsi
000000010000f0d4	movq	0x38(%r15), %rdx
000000010000f0d8	movq	%r13, %rdi
000000010000f0db	xorl	%ecx, %ecx
000000010000f0dd	callq	_fwp_write
000000010000f0e2	movq	0x10(%r14), %r14
000000010000f0e6	testq	%r14, %r14
000000010000f0e9	jne	0x10000f0c0
000000010000f0eb	jmp	0x10000fd84
000000010000f0f0	movslq	0x48(%r15), %rbx
000000010000f0f4	movl	%ebx, %r12d
000000010000f0f7	leaq	0x3(%rbx), %rsi
000000010000f0fb	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000f102	ja	0x10000f9fe
000000010000f108	leaq	0x12(%rbx), %rax
000000010000f10c	shrq	$0x4, %rax
000000010000f110	leaq	_fwp_gc(%rip), %rcx
000000010000f117	movzbl	0xbe8(%rax,%rcx), %edx
000000010000f11f	movl	0xb48(%rcx,%rdx,4), %eax
000000010000f126	subq	%rax, _fwp_gc(%rip)
000000010000f12d	js	0x10000f9fe
000000010000f133	leaq	(%rdx,%rdx,2), %rdx
000000010000f137	leaq	(%rcx,%rdx,8), %rcx
000000010000f13b	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000f142	movq	(%rcx), %r15
000000010000f145	testq	%r15, %r15
000000010000f148	je	0x10000f9ea
000000010000f14e	movq	(%r15), %rax
000000010000f151	notq	%rax
000000010000f154	movq	%rax, (%rcx)
000000010000f157	jmp	0x10000fb82
000000010000f15c	cmpq	$-0x1, %r14
000000010000f160	leaq	0x36f1(%rip), %rax              ## literal pool for: "-1"
000000010000f167	leaq	0x2b13(%rip), %rcx              ## literal pool for: "0"
000000010000f16e	cmoveq	%rax, %rcx
000000010000f172	cmpq	$0x1, %r14
000000010000f176	leaq	0x36d8(%rip), %rbx              ## literal pool for: "+1"
000000010000f17d	cmovneq	%rcx, %rbx
000000010000f181	movq	%rbx, %rdi
000000010000f184	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f189	movq	0x3ea0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000f190	movq	(%rcx), %rcx
000000010000f193	cmpq	-0x30(%rbp), %rcx
000000010000f197	jne	0x100010018
000000010000f19d	movq	%r13, %rdi
000000010000f1a0	movq	%rbx, %rsi
000000010000f1a3	jmp	0x10000fc63
000000010000f1a8	movq	%r15, %r12
000000010000f1ab	leaq	0x3742(%rip), %rsi              ## literal pool for: "array["
000000010000f1b2	movl	$0x6, %edx
000000010000f1b7	movq	%r13, %rdi
000000010000f1ba	callq	_buf_put
000000010000f1bf	movq	(%r14), %rsi
000000010000f1c2	leaq	(,%rsi,2), %rax
000000010000f1ca	testq	%rax, %rax
000000010000f1cd	je	0x10000fd84
000000010000f1d3	movq	0x38(%r12), %rdx
000000010000f1d8	movl	$0x8, %eax
000000010000f1dd	testq	%rdx, %rdx
000000010000f1e0	je	0x10000fa5d
000000010000f1e6	movl	(%rdx), %ecx
000000010000f1e8	cmpq	$0xa, %rcx
000000010000f1ec	movq	-0x278(%rbp), %r13
000000010000f1f3	ja	0x10000fa64
000000010000f1f9	leaq	0x2788(%rip), %rax
000000010000f200	movq	(%rax,%rcx,8), %rax
000000010000f204	jmp	0x10000fa64
000000010000f209	leaq	0x36da(%rip), %rsi              ## literal pool for: "bytes["
000000010000f210	movl	$0x6, %edx
000000010000f215	movq	%r13, %rdi
000000010000f218	callq	_buf_put
000000010000f21d	cmpq	$0x0, (%r14)
000000010000f221	movq	%r13, %rbx
000000010000f224	je	0x10000f2d1
000000010000f22a	movzbl	0x8(%r14), %ecx
000000010000f22f	leaq	0x36bb(%rip), %rdx              ## literal pool for: "%u"
000000010000f236	leaq	-0x270(%rbp), %r15
000000010000f23d	movl	$0x200, %esi                    ## imm = 0x200
000000010000f242	movq	%r15, %rdi
000000010000f245	xorl	%eax, %eax
000000010000f247	callq	0x10001153e                     ## symbol stub for: _snprintf
000000010000f24c	movq	%r15, %rdi
000000010000f24f	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f254	movq	%rbx, %rdi
000000010000f257	movq	%r15, %rsi
000000010000f25a	movq	%rax, %rdx
000000010000f25d	callq	_buf_put
000000010000f262	cmpq	$0x2, (%r14)
000000010000f266	jb	0x10000f2d1
000000010000f268	movl	$0x9, %r13d
000000010000f26e	leaq	0x367c(%rip), %r15              ## literal pool for: "%u"
000000010000f275	leaq	-0x270(%rbp), %r12
000000010000f27c	nopl	(%rax)
000000010000f280	movl	$0x2, %edx
000000010000f285	movq	%rbx, %rdi
000000010000f288	leaq	0x35b5(%rip), %rsi              ## literal pool for: ", "
000000010000f28f	callq	_buf_put
000000010000f294	movzbl	(%r14,%r13), %ecx
000000010000f299	movl	$0x200, %esi                    ## imm = 0x200
000000010000f29e	movq	%r12, %rdi
000000010000f2a1	movq	%r15, %rdx
000000010000f2a4	xorl	%eax, %eax
000000010000f2a6	callq	0x10001153e                     ## symbol stub for: _snprintf
000000010000f2ab	movq	%r12, %rdi
000000010000f2ae	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f2b3	movq	%rbx, %rdi
000000010000f2b6	movq	%r12, %rsi
000000010000f2b9	movq	%rax, %rdx
000000010000f2bc	callq	_buf_put
000000010000f2c1	leaq	0x1(%r13), %rax
000000010000f2c5	addq	$-0x7, %r13
000000010000f2c9	cmpq	(%r14), %r13
000000010000f2cc	movq	%rax, %r13
000000010000f2cf	jb	0x10000f280
000000010000f2d1	movb	$0x5d, -0x70(%rbp)
000000010000f2d5	leaq	-0x70(%rbp), %rsi
000000010000f2d9	movl	$0x1, %edx
000000010000f2de	movq	%rbx, %rdi
000000010000f2e1	jmp	0x10000feb6
000000010000f2e6	movd	%r14d, %xmm1
000000010000f2eb	ucomiss	%xmm1, %xmm1
000000010000f2ee	jp	0x10001001d
000000010000f2f4	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
000000010000f2fb	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
000000010000f302	je	0x10000f73a
000000010000f308	cvtss2sd	%xmm1, %xmm0
000000010000f30c	leaq	-0x270(%rbp), %rbx
000000010000f313	movq	%rbx, %rdi
000000010000f316	movsd	%xmm0, -0x280(%rbp)
000000010000f31e	movl	$0x1, %esi
000000010000f323	movss	%xmm1, -0x278(%rbp)
000000010000f32b	callq	_fwp_format_g
000000010000f330	movq	%rbx, %rdi
000000010000f333	xorl	%esi, %esi
000000010000f335	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f33a	ucomiss	-0x278(%rbp), %xmm0
000000010000f341	jne	0x10000f349
000000010000f343	jnp	0x10000f4b9
000000010000f349	movq	%rbx, %rdi
000000010000f34c	movsd	-0x280(%rbp), %xmm0
000000010000f354	movl	$0x2, %esi
000000010000f359	callq	_fwp_format_g
000000010000f35e	movq	%rbx, %rdi
000000010000f361	xorl	%esi, %esi
000000010000f363	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f368	ucomiss	-0x278(%rbp), %xmm0
000000010000f36f	jne	0x10000f377
000000010000f371	jnp	0x10000f4b9
000000010000f377	movq	%rbx, %rdi
000000010000f37a	movsd	-0x280(%rbp), %xmm0
000000010000f382	movl	$0x3, %esi
000000010000f387	callq	_fwp_format_g
000000010000f38c	movq	%rbx, %rdi
000000010000f38f	xorl	%esi, %esi
000000010000f391	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f396	ucomiss	-0x278(%rbp), %xmm0
000000010000f39d	jne	0x10000f3a5
000000010000f39f	jnp	0x10000f4b9
000000010000f3a5	movq	%rbx, %rdi
000000010000f3a8	movsd	-0x280(%rbp), %xmm0
000000010000f3b0	movl	$0x4, %esi
000000010000f3b5	callq	_fwp_format_g
000000010000f3ba	movq	%rbx, %rdi
000000010000f3bd	xorl	%esi, %esi
000000010000f3bf	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f3c4	ucomiss	-0x278(%rbp), %xmm0
000000010000f3cb	jne	0x10000f3d3
000000010000f3cd	jnp	0x10000f4b9
000000010000f3d3	movq	%rbx, %rdi
000000010000f3d6	movsd	-0x280(%rbp), %xmm0
000000010000f3de	movl	$0x5, %esi
000000010000f3e3	callq	_fwp_format_g
000000010000f3e8	movq	%rbx, %rdi
000000010000f3eb	xorl	%esi, %esi
000000010000f3ed	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f3f2	ucomiss	-0x278(%rbp), %xmm0
000000010000f3f9	jne	0x10000f401
000000010000f3fb	jnp	0x10000f4b9
000000010000f401	movq	%rbx, %rdi
000000010000f404	movsd	-0x280(%rbp), %xmm0
000000010000f40c	movl	$0x6, %esi
000000010000f411	callq	_fwp_format_g
000000010000f416	movq	%rbx, %rdi
000000010000f419	xorl	%esi, %esi
000000010000f41b	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f420	ucomiss	-0x278(%rbp), %xmm0
000000010000f427	jne	0x10000f42f
000000010000f429	jnp	0x10000f4b9
000000010000f42f	movq	%rbx, %rdi
000000010000f432	movsd	-0x280(%rbp), %xmm0
000000010000f43a	movl	$0x7, %esi
000000010000f43f	callq	_fwp_format_g
000000010000f444	movq	%rbx, %rdi
000000010000f447	xorl	%esi, %esi
000000010000f449	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f44e	ucomiss	-0x278(%rbp), %xmm0
000000010000f455	jne	0x10000f459
000000010000f457	jnp	0x10000f4b9
000000010000f459	movq	%rbx, %rdi
000000010000f45c	movsd	-0x280(%rbp), %xmm0
000000010000f464	movl	$0x8, %esi
000000010000f469	callq	_fwp_format_g
000000010000f46e	movq	%rbx, %rdi
000000010000f471	xorl	%esi, %esi
000000010000f473	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f478	movss	-0x278(%rbp), %xmm1
000000010000f480	ucomiss	%xmm1, %xmm0
000000010000f483	jne	0x10000f487
000000010000f485	jnp	0x10000f4b9
000000010000f487	movq	%rbx, %rdi
000000010000f48a	movsd	-0x280(%rbp), %xmm0
000000010000f492	movl	$0x9, %esi
000000010000f497	callq	_fwp_format_g
000000010000f49c	movq	%rbx, %rdi
000000010000f49f	xorl	%esi, %esi
000000010000f4a1	callq	0x10001156e                     ## symbol stub for: _strtof
000000010000f4a6	ucomiss	-0x278(%rbp), %xmm0
000000010000f4ad	jne	0x100010003
000000010000f4b3	jp	0x100010003
000000010000f4b9	leaq	-0x270(%rbp), %rdi
000000010000f4c0	movl	$0x2e, %esi
000000010000f4c5	callq	0x10001154a                     ## symbol stub for: _strchr
000000010000f4ca	testq	%rax, %rax
000000010000f4cd	jne	0x10000fe9e
000000010000f4d3	leaq	-0x270(%rbp), %rdi
000000010000f4da	movl	$0x65, %esi
000000010000f4df	callq	0x10001154a                     ## symbol stub for: _strchr
000000010000f4e4	testq	%rax, %rax
000000010000f4e7	jne	0x10000fe9e
000000010000f4ed	leaq	0x339f(%rip), %rsi              ## literal pool for: "inf"
000000010000f4f4	leaq	-0x270(%rbp), %rdi
000000010000f4fb	callq	0x100011562                     ## symbol stub for: _strstr
000000010000f500	testq	%rax, %rax
000000010000f503	jne	0x10000fe9e
000000010000f509	leaq	0x338c(%rip), %rsi              ## literal pool for: "NaN"
000000010000f510	leaq	-0x270(%rbp), %rdi
000000010000f517	callq	0x100011562                     ## symbol stub for: _strstr
000000010000f51c	testq	%rax, %rax
000000010000f51f	jne	0x10000fe9e
000000010000f525	leaq	0x33f7(%rip), %rsi              ## literal pool for: ".0"
000000010000f52c	leaq	-0x270(%rbp), %rdi
000000010000f533	movl	$0x200, %edx                    ## imm = 0x200
000000010000f538	callq	0x100011436                     ## symbol stub for: ___strcat_chk
000000010000f53d	jmp	0x10000fe9e
000000010000f542	movq	0x3ae7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000f549	movq	(%rax), %rax
000000010000f54c	cmpq	-0x30(%rbp), %rax
000000010000f550	jne	0x100010018
000000010000f556	leaq	0x3372(%rip), %rsi              ## literal pool for: "<function>"
000000010000f55d	movl	$0xa, %edx
000000010000f562	movq	%r13, %rdi
000000010000f565	jmp	0x10000fc66
000000010000f56a	leaq	0x3372(%rip), %rsi              ## literal pool for: "<file "
000000010000f571	movl	$0x6, %edx
000000010000f576	movq	%r13, %rdi
000000010000f579	callq	_buf_put
000000010000f57e	addq	$0x10, %r14
000000010000f582	movq	%r14, %rdi
000000010000f585	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f58a	movq	%r13, %rdi
000000010000f58d	movq	%r14, %rsi
000000010000f590	movq	%rax, %rdx
000000010000f593	callq	_buf_put
000000010000f598	movb	$0x3e, -0x270(%rbp)
000000010000f59f	jmp	0x10000fd8b
000000010000f5a4	movl	(%r14), %eax
000000010000f5a7	movq	0x18(%r15), %rcx
000000010000f5ab	movl	%eax, %r12d
000000010000f5ae	movq	(%rcx,%r12,8), %rbx
000000010000f5b2	movq	%rbx, %rdi
000000010000f5b5	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f5ba	movq	%r13, %rdi
000000010000f5bd	movq	%rbx, %rsi
000000010000f5c0	movq	%rax, %rdx
000000010000f5c3	callq	_buf_put
000000010000f5c8	movq	0x28(%r15), %rax
000000010000f5cc	cmpl	$0x0, (%rax,%r12,4)
000000010000f5d1	jle	0x10000febb
000000010000f5d7	movq	%r12, %rcx
000000010000f5da	xorl	%r12d, %r12d
000000010000f5dd	movq	%r15, -0x280(%rbp)
000000010000f5e4	movq	%rcx, -0x290(%rbp)
000000010000f5eb	movq	%r14, -0x288(%rbp)
000000010000f5f2	jmp	0x10000f639
000000010000f5f4	nopw	%cs:(%rax,%rax)
000000010000f600	movq	-0x278(%rbp), %r13
000000010000f607	movq	%r13, %rdi
000000010000f60a	movq	%r15, %rsi
000000010000f60d	movq	%rbx, %rdx
000000010000f610	xorl	%ecx, %ecx
000000010000f612	callq	_fwp_write
000000010000f617	incq	%r12
000000010000f61a	movq	-0x280(%rbp), %r15
000000010000f621	movq	0x28(%r15), %rax
000000010000f625	movq	-0x290(%rbp), %rcx
000000010000f62c	movslq	(%rax,%rcx,4), %rax
000000010000f630	cmpq	%rax, %r12
000000010000f633	jge	0x10000febb
000000010000f639	movq	%r15, %rax
000000010000f63c	movq	0x8(%r14,%r12,8), %r15
000000010000f641	movq	0x30(%rax), %rax
000000010000f645	movq	(%rax,%rcx,8), %rax
000000010000f649	movq	(%rax,%r12,8), %rbx
000000010000f64d	movb	$0x20, -0x270(%rbp)
000000010000f654	movl	$0x1, %edx
000000010000f659	movq	%r13, %rdi
000000010000f65c	leaq	-0x270(%rbp), %rsi
000000010000f663	callq	_buf_put
000000010000f668	movl	(%rbx), %eax
000000010000f66a	cmpq	$0x10, %rax
000000010000f66e	ja	0x10000f600
000000010000f670	leaq	0xa1d(%rip), %rcx
000000010000f677	movslq	(%rcx,%rax,4), %rax
000000010000f67b	addq	%rcx, %rax
000000010000f67e	jmpq	*%rax
000000010000f680	movq	%r15, %rcx
000000010000f683	shrq	$0x3f, %rcx
000000010000f687	testl	%ecx, %ecx
000000010000f689	je	0x10000f600
000000010000f68f	movb	$0x28, -0x270(%rbp)
000000010000f696	movl	$0x1, %edx
000000010000f69b	movq	-0x278(%rbp), %r13
000000010000f6a2	movq	%r13, %rdi
000000010000f6a5	leaq	-0x270(%rbp), %r14
000000010000f6ac	movq	%r14, %rsi
000000010000f6af	callq	_buf_put
000000010000f6b4	movq	%r13, %rdi
000000010000f6b7	movq	%r15, %rsi
000000010000f6ba	movq	%rbx, %rdx
000000010000f6bd	xorl	%ecx, %ecx
000000010000f6bf	callq	_fwp_write
000000010000f6c4	movb	$0x29, -0x270(%rbp)
000000010000f6cb	movl	$0x1, %edx
000000010000f6d0	movq	%r13, %rdi
000000010000f6d3	movq	%r14, %rsi
000000010000f6d6	movq	-0x288(%rbp), %r14
000000010000f6dd	callq	_buf_put
000000010000f6e2	jmp	0x10000f617
000000010000f6e7	xorl	%ecx, %ecx
000000010000f6e9	cmpq	$0x1000, %r15                   ## imm = 0x1000
000000010000f6f0	setae	%cl
000000010000f6f3	jmp	0x10000f687
000000010000f6f5	movq	0x8(%r15), %rcx
000000010000f6f9	jmp	0x10000f683
000000010000f6fb	movl	%r15d, %ecx
000000010000f6fe	shrl	$0x1f, %ecx
000000010000f701	jmp	0x10000f687
000000010000f703	movq	0x8(%rbx), %rdi
000000010000f707	testq	%rdi, %rdi
000000010000f70a	je	0x10000f600
000000010000f710	leaq	0x3156(%rip), %rsi              ## literal pool for: "Duration"
000000010000f717	callq	0x100011550                     ## symbol stub for: _strcmp
000000010000f71c	xorl	%ecx, %ecx
000000010000f71e	testl	%eax, %eax
000000010000f720	setne	%cl
000000010000f723	jmp	0x10000f687
000000010000f728	xorpd	%xmm0, %xmm0
000000010000f72c	movsd	-0x278(%rbp), %xmm1
000000010000f734	ucomisd	%xmm0, %xmm1
000000010000f738	jmp	0x10000f740
000000010000f73a	xorps	%xmm0, %xmm0
000000010000f73d	ucomiss	%xmm0, %xmm1
000000010000f740	leaq	0x314c(%rip), %rax              ## literal pool for: "inf"
000000010000f747	leaq	0x3149(%rip), %rsi              ## literal pool for: "-inf"
000000010000f74e	cmovaq	%rax, %rsi
000000010000f752	leaq	-0x270(%rbp), %rdi
000000010000f759	movl	$0x200, %edx                    ## imm = 0x200
000000010000f75e	callq	0x10001143c                     ## symbol stub for: ___strcpy_chk
000000010000f763	jmp	0x10000fe9e
000000010000f768	cmpl	$0x0, 0x10(%r15)
000000010000f76d	je	0x10000fd9f
000000010000f773	movq	%r15, %rax
000000010000f776	addq	$0x10, %r15
000000010000f77a	movq	%rax, -0x280(%rbp)
000000010000f781	cmpl	$0x0, 0x48(%rax)
000000010000f785	setne	%r12b
000000010000f789	testb	%r12b, %r12b
000000010000f78c	movl	$0x28, %eax
000000010000f791	movl	$0x7b, %ecx
000000010000f796	cmovnel	%eax, %ecx
000000010000f799	movb	%cl, -0x270(%rbp)
000000010000f79f	leaq	-0x270(%rbp), %rsi
000000010000f7a6	movl	$0x1, %edx
000000010000f7ab	movq	%r13, %rdi
000000010000f7ae	callq	_buf_put
000000010000f7b3	cmpl	$0x0, (%r15)
000000010000f7b7	movq	-0x280(%rbp), %r15
000000010000f7be	jle	0x10000f8ab
000000010000f7c4	testb	%r12b, %r12b
000000010000f7c7	jne	0x10000f7fa
000000010000f7c9	movq	0x18(%r15), %rax
000000010000f7cd	movq	(%rax), %rbx
000000010000f7d0	movq	%rbx, %rdi
000000010000f7d3	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f7d8	movq	%r13, %rdi
000000010000f7db	movq	%rbx, %rsi
000000010000f7de	movq	%rax, %rdx
000000010000f7e1	callq	_buf_put
000000010000f7e6	leaq	0x311e(%rip), %rsi              ## literal pool for: " = "
000000010000f7ed	movl	$0x3, %edx
000000010000f7f2	movq	%r13, %rdi
000000010000f7f5	callq	_buf_put
000000010000f7fa	movq	0x8(%r14), %rsi
000000010000f7fe	movq	0x20(%r15), %rax
000000010000f802	movq	(%rax), %rdx
000000010000f805	movq	%r13, %rdi
000000010000f808	xorl	%ecx, %ecx
000000010000f80a	callq	_fwp_write
000000010000f80f	cmpl	$0x2, 0x10(%r15)
000000010000f814	jl	0x10000f8ab
000000010000f81a	movl	$0x1, %ebx
000000010000f81f	jmp	0x10000f853
000000010000f821	nopw	%cs:(%rax,%rax)
000000010000f830	movq	0x8(%r14,%rbx,8), %rsi
000000010000f835	movq	0x20(%r15), %rax
000000010000f839	movq	(%rax,%rbx,8), %rdx
000000010000f83d	movq	%r13, %rdi
000000010000f840	xorl	%ecx, %ecx
000000010000f842	callq	_fwp_write
000000010000f847	incq	%rbx
000000010000f84a	movslq	0x10(%r15), %rax
000000010000f84e	cmpq	%rax, %rbx
000000010000f851	jge	0x10000f8ab
000000010000f853	movl	$0x2, %edx
000000010000f858	movq	%r13, %rdi
000000010000f85b	leaq	0x2fe2(%rip), %rsi              ## literal pool for: ", "
000000010000f862	callq	_buf_put
000000010000f867	testb	%r12b, %r12b
000000010000f86a	jne	0x10000f830
000000010000f86c	movq	0x18(%r15), %rax
000000010000f870	movq	(%rax,%rbx,8), %r13
000000010000f874	movq	%r13, %rdi
000000010000f877	callq	0x100011556                     ## symbol stub for: _strlen
000000010000f87c	movq	-0x278(%rbp), %rdi
000000010000f883	movq	%r13, %rsi
000000010000f886	movq	-0x278(%rbp), %r13
000000010000f88d	movq	%rax, %rdx
000000010000f890	callq	_buf_put
000000010000f895	movl	$0x3, %edx
000000010000f89a	movq	%r13, %rdi
000000010000f89d	leaq	0x3067(%rip), %rsi              ## literal pool for: " = "
000000010000f8a4	callq	_buf_put
000000010000f8a9	jmp	0x10000f830
000000010000f8ab	testb	%r12b, %r12b
000000010000f8ae	movl	$0x29, %eax
000000010000f8b3	movl	$0x7d, %ecx
000000010000f8b8	cmovnel	%eax, %ecx
000000010000f8bb	movb	%cl, -0x270(%rbp)
000000010000f8c1	jmp	0x10000fd8b
000000010000f8c6	cmpq	-0x30(%rbp), %rax
000000010000f8ca	jne	0x100010018
000000010000f8d0	movq	%r13, %rdi
000000010000f8d3	addq	$0x268, %rsp                    ## imm = 0x268
000000010000f8da	popq	%rbx
000000010000f8db	popq	%r12
000000010000f8dd	popq	%r13
000000010000f8df	popq	%r14
000000010000f8e1	popq	%r15
000000010000f8e3	popq	%rbp
000000010000f8e4	jmp	_fwp_escape
000000010000f8e9	movb	$0x30, -0x70(%rbp)
000000010000f8ed	movl	$0x1, %edi
000000010000f8f2	movl	%edi, %eax
000000010000f8f4	cmpq	$0x8, %rax
000000010000f8f8	jae	0x10000f904
000000010000f8fa	xorl	%ecx, %ecx
000000010000f8fc	movq	%rax, %rdx
000000010000f8ff	jmp	0x10000fb55
000000010000f904	cmpl	$0x20, %eax
000000010000f907	jae	0x10000faa1
000000010000f90d	xorl	%ecx, %ecx
000000010000f90f	jmp	0x10000faff
000000010000f914	movb	$0x2d, -0x270(%rbp)
000000010000f91b	xorl	%r8d, %r8d
000000010000f91e	negq	%r9
000000010000f921	movl	$0x0, %r11d
000000010000f927	sbbq	%r10, %r11
000000010000f92a	movl	$0x1, %r15d
000000010000f930	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000f93a	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000f944	movq	%r11, %r14
000000010000f947	nopw	(%rax,%rax)
000000010000f950	movq	%r11, %rcx
000000010000f953	shldq	$0x3f, %r9, %rcx
000000010000f958	shrq	%r14
000000010000f95b	movq	%rcx, %rsi
000000010000f95e	addq	%r14, %rsi
000000010000f961	adcq	$0x0, %rsi
000000010000f965	movq	%rsi, %rax
000000010000f968	mulq	%r10
000000010000f96b	movl	%r15d, %edi
000000010000f96e	shrq	$0x2, %rdx
000000010000f972	leaq	(%rdx,%rdx,4), %rax
000000010000f976	subq	%rax, %rsi
000000010000f979	subq	%rsi, %rcx
000000010000f97c	sbbq	$0x0, %r14
000000010000f980	movq	%rcx, %rsi
000000010000f983	movq	%rcx, %rax
000000010000f986	mulq	%r10
000000010000f989	imulq	%rbx, %rsi
000000010000f98d	addq	%rsi, %rdx
000000010000f990	imulq	%r10, %r14
000000010000f994	addq	%rdx, %r14
000000010000f997	movq	%rax, %rcx
000000010000f99a	addq	%rax, %rcx
000000010000f99d	leaq	(%rcx,%rcx,4), %rcx
000000010000f9a1	movl	%r9d, %edx
000000010000f9a4	subl	%ecx, %edx
000000010000f9a6	orb	$0x30, %dl
000000010000f9a9	movb	%dl, -0x70(%rbp,%r8)
000000010000f9ae	incq	%r8
000000010000f9b1	leal	0x1(%rdi), %r15d
000000010000f9b5	cmpq	$0xa, %r9
000000010000f9b9	sbbq	$0x0, %r11
000000010000f9bd	movq	%rax, %r9
000000010000f9c0	movq	%r14, %r11
000000010000f9c3	jae	0x10000f950
000000010000f9c5	testl	%r8d, %r8d
000000010000f9c8	jle	0x10000fdc7
000000010000f9ce	movl	%r8d, %eax
000000010000f9d1	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
000000010000f9d6	cmpq	$0x8, %rax
000000010000f9da	jae	0x10000fee1
000000010000f9e0	xorl	%ecx, %ecx
000000010000f9e2	movq	%rax, %rdx
000000010000f9e5	jmp	0x10000ffc4
000000010000f9ea	movq	0x8(%rcx), %r15
000000010000f9ee	movq	0x10(%rcx), %rdx
000000010000f9f2	subq	%r15, %rdx
000000010000f9f5	cmpq	%rax, %rdx
000000010000f9f8	jae	0x10000fb7b
000000010000f9fe	movq	%rsi, %rdi
000000010000fa01	movl	$0x1, %esi
000000010000fa06	callq	_fwp_gc_alloc_slow
000000010000fa0b	movq	%rax, %r15
000000010000fa0e	jmp	0x10000fb8a
000000010000fa13	movq	0x8(%r14), %rsi
000000010000fa17	movq	%rsi, %rdx
000000010000fa1a	sarq	$0x3f, %rdx
000000010000fa1e	leaq	-0x270(%rbp), %rbx
000000010000fa25	movq	%rbx, %rdi
000000010000fa28	callq	_fwp_fmt_duration
000000010000fa2d	jmp	0x10000fea5
000000010000fa32	movb	$0x30, -0x70(%rbp)
000000010000fa36	movl	$0x1, %edi
000000010000fa3b	movl	%edi, %eax
000000010000fa3d	cmpq	$0x8, %rax
000000010000fa41	jae	0x10000fa4d
000000010000fa43	xorl	%ecx, %ecx
000000010000fa45	movq	%rax, %rdx
000000010000fa48	jmp	0x10000fe73
000000010000fa4d	cmpl	$0x20, %eax
000000010000fa50	jae	0x10000fdd6
000000010000fa56	xorl	%ecx, %ecx
000000010000fa58	jmp	0x10000fe2e
000000010000fa5d	movq	-0x278(%rbp), %r13
000000010000fa64	leaq	0x8(%r14), %rbx
000000010000fa68	movq	%rbx, %rcx
000000010000fa6b	testq	%rsi, %rsi
000000010000fa6e	jns	0x10000fa74
000000010000fa70	movq	0x10(%r14), %rcx
000000010000fa74	cmpq	$0x1, %rax
000000010000fa78	je	0x10000fc81
000000010000fa7e	cmpq	$0x8, %rax
000000010000fa82	je	0x10000fc7c
000000010000fa88	cmpq	$0x2, %rax
000000010000fa8c	jne	0x10000fc8d
000000010000fa92	cmpl	$0x1, (%rdx)
000000010000fa95	movzwl	(%rcx), %eax
000000010000fa98	movswq	%ax, %rsi
000000010000fa9c	jmp	0x10000fc95
000000010000faa1	movl	%edi, %edx
000000010000faa3	andl	$0x1f, %edx
000000010000faa6	movq	%rax, %rcx
000000010000faa9	subq	%rdx, %rcx
000000010000faac	leaq	-0x260(%rbp), %rsi
000000010000fab3	movdqa	0x1bf5(%rip), %xmm0
000000010000fabb	movq	%rax, %r8
000000010000fabe	nop
000000010000fac0	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000faca	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000fad1	pshufb	%xmm0, %xmm2
000000010000fad6	pshufb	%xmm0, %xmm1
000000010000fadb	movdqa	%xmm2, -0x10(%rsi)
000000010000fae0	movdqa	%xmm1, (%rsi)
000000010000fae4	addq	$-0x20, %r8
000000010000fae8	addq	$0x20, %rsi
000000010000faec	cmpq	%r8, %rdx
000000010000faef	jne	0x10000fac0
000000010000faf1	testq	%rdx, %rdx
000000010000faf4	je	0x10000fe96
000000010000fafa	cmpl	$0x7, %edx
000000010000fafd	jbe	0x10000fb55
000000010000faff	movl	%edi, %edx
000000010000fb01	andl	$0x7, %edx
000000010000fb04	movq	%rax, %rsi
000000010000fb07	subq	%rcx, %rsi
000000010000fb0a	leaq	(%rcx,%rbp), %rdi
000000010000fb0e	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000fb15	movq	%rax, %rcx
000000010000fb18	subq	%rdx, %rcx
000000010000fb1b	movq	0x1b9d(%rip), %xmm0
000000010000fb23	nopw	%cs:(%rax,%rax)
000000010000fb30	movq	-0x78(%rbp,%rsi), %xmm1
000000010000fb36	pshufb	%xmm0, %xmm1
000000010000fb3b	movq	%xmm1, (%rdi)
000000010000fb3f	addq	$-0x8, %rsi
000000010000fb43	addq	$0x8, %rdi
000000010000fb47	cmpq	%rsi, %rdx
000000010000fb4a	jne	0x10000fb30
000000010000fb4c	testq	%rdx, %rdx
000000010000fb4f	je	0x10000fe96
000000010000fb55	leaq	-0x70(%rbp), %rsi
000000010000fb59	addq	%rsi, %rdx
000000010000fb5c	decq	%rdx
000000010000fb5f	nop
000000010000fb60	movzbl	(%rdx), %esi
000000010000fb63	movb	%sil, -0x270(%rbp,%rcx)
000000010000fb6b	incq	%rcx
000000010000fb6e	decq	%rdx
000000010000fb71	cmpq	%rcx, %rax
000000010000fb74	jne	0x10000fb60
000000010000fb76	jmp	0x10000fe96
000000010000fb7b	addq	%r15, %rax
000000010000fb7e	movq	%rax, 0x8(%rcx)
000000010000fb82	movq	%r15, %rdi
000000010000fb85	callq	0x10001141e                     ## symbol stub for: ___bzero
000000010000fb8a	movw	$0x7430, (%r15)                 ## imm = 0x7430
000000010000fb90	testl	%r12d, %r12d
000000010000fb93	jle	0x10000fc3b
000000010000fb99	movq	%rbx, %rcx
000000010000fb9c	negq	%rcx
000000010000fb9f	leaq	(%r12,%r15), %rsi
000000010000fba3	incq	%rsi
000000010000fba6	xorl	%edi, %edi
000000010000fba8	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
000000010000fbb2	jmp	0x10000fbec
000000010000fbb4	nopw	%cs:(%rax,%rax)
000000010000fbc0	movb	$0x30, %r10b
000000010000fbc3	movb	%r10b, (%rsi,%rdi)
000000010000fbc7	testq	%rdx, %rdx
000000010000fbca	setne	%dl
000000010000fbcd	testq	%r14, %r14
000000010000fbd0	sets	%r10b
000000010000fbd4	andb	%dl, %r10b
000000010000fbd7	movzbl	%r10b, %edx
000000010000fbdb	subq	%rdx, %rax
000000010000fbde	addq	%r9, %rax
000000010000fbe1	decq	%rdi
000000010000fbe4	movq	%rax, %r14
000000010000fbe7	cmpq	%rdi, %rcx
000000010000fbea	je	0x10000fc3b
000000010000fbec	movq	%r14, %rax
000000010000fbef	imulq	%r8
000000010000fbf2	movq	%rdx, %rax
000000010000fbf5	shrq	$0x3f, %rax
000000010000fbf9	addq	%rdx, %rax
000000010000fbfc	leaq	(%rax,%rax,2), %r9
000000010000fc00	movq	%r14, %rdx
000000010000fc03	subq	%r9, %rdx
000000010000fc06	negq	%r9
000000010000fc09	addq	%r14, %r9
000000010000fc0c	addq	$0x3, %r9
000000010000fc10	cmpq	$-0x3, %rdx
000000010000fc14	cmovbq	%rdx, %r9
000000010000fc18	testq	%r9, %r9
000000010000fc1b	je	0x10000fbc0
000000010000fc1d	cmpq	$0x1, %r9
000000010000fc21	jne	0x10000fc30
000000010000fc23	movb	$0x2b, %r10b
000000010000fc26	xorl	%r9d, %r9d
000000010000fc29	jmp	0x10000fbc3
000000010000fc2b	nopl	(%rax,%rax)
000000010000fc30	movb	$0x2d, %r10b
000000010000fc33	movl	$0x1, %r9d
000000010000fc39	jmp	0x10000fbc3
000000010000fc3b	movb	$0x0, 0x2(%r15,%rbx)
000000010000fc41	movq	%r15, %rdi
000000010000fc44	callq	0x100011556                     ## symbol stub for: _strlen
000000010000fc49	movq	0x33e0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000fc50	movq	(%rcx), %rcx
000000010000fc53	cmpq	-0x30(%rbp), %rcx
000000010000fc57	jne	0x100010018
000000010000fc5d	movq	%r13, %rdi
000000010000fc60	movq	%r15, %rsi
000000010000fc63	movq	%rax, %rdx
000000010000fc66	addq	$0x268, %rsp                    ## imm = 0x268
000000010000fc6d	popq	%rbx
000000010000fc6e	popq	%r12
000000010000fc70	popq	%r13
000000010000fc72	popq	%r14
000000010000fc74	popq	%r15
000000010000fc76	popq	%rbp
000000010000fc77	jmp	_buf_put
000000010000fc7c	movq	(%rcx), %rsi
000000010000fc7f	jmp	0x10000fc99
000000010000fc81	cmpl	$0x0, (%rdx)
000000010000fc84	movzbl	(%rcx), %eax
000000010000fc87	movsbq	%al, %rsi
000000010000fc8b	jmp	0x10000fc95
000000010000fc8d	cmpl	$0x2, (%rdx)
000000010000fc90	movl	(%rcx), %eax
000000010000fc92	movslq	%eax, %rsi
000000010000fc95	cmovneq	%rax, %rsi
000000010000fc99	movq	%r13, %rdi
000000010000fc9c	xorl	%ecx, %ecx
000000010000fc9e	callq	_fwp_write
000000010000fca3	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000fcad	decq	%rax
000000010000fcb0	testq	%rax, (%r14)
000000010000fcb3	je	0x10000fd84
000000010000fcb9	movl	$0x1, %r15d
000000010000fcbf	jmp	0x10000fcfd
000000010000fcc1	cmpl	$0x1, (%rdx)
000000010000fcc4	movzwl	(%rcx,%rsi), %eax
000000010000fcc8	movswq	%ax, %rsi
000000010000fccc	cmovneq	%rax, %rsi
000000010000fcd0	movq	-0x278(%rbp), %r13
000000010000fcd7	movq	%r13, %rdi
000000010000fcda	xorl	%ecx, %ecx
000000010000fcdc	callq	_fwp_write
000000010000fce1	incq	%r15
000000010000fce4	movq	(%r14), %rax
000000010000fce7	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000fcf1	andq	%rcx, %rax
000000010000fcf4	cmpq	%rax, %r15
000000010000fcf7	jae	0x10000fd84
000000010000fcfd	movl	$0x2, %edx
000000010000fd02	movq	%r13, %rdi
000000010000fd05	leaq	0x2b38(%rip), %rsi              ## literal pool for: ", "
000000010000fd0c	callq	_buf_put
000000010000fd11	movq	0x38(%r12), %rdx
000000010000fd16	movl	$0x8, %eax
000000010000fd1b	testq	%rdx, %rdx
000000010000fd1e	je	0x10000fd33
000000010000fd20	movl	(%rdx), %ecx
000000010000fd22	cmpq	$0xa, %rcx
000000010000fd26	ja	0x10000fd33
000000010000fd28	leaq	0x1c59(%rip), %rax
000000010000fd2f	movq	(%rax,%rcx,8), %rax
000000010000fd33	cmpq	$0x0, (%r14)
000000010000fd37	movq	%rbx, %rcx
000000010000fd3a	jns	0x10000fd40
000000010000fd3c	movq	0x10(%r14), %rcx
000000010000fd40	movq	%rax, %rsi
000000010000fd43	imulq	%r15, %rsi
000000010000fd47	cmpq	$0x1, %rax
000000010000fd4b	je	0x10000fd66
000000010000fd4d	cmpq	$0x2, %rax
000000010000fd51	je	0x10000fcc1
000000010000fd57	cmpq	$0x8, %rax
000000010000fd5b	jne	0x10000fd76
000000010000fd5d	movq	(%rcx,%rsi), %rsi
000000010000fd61	jmp	0x10000fcd0
000000010000fd66	cmpl	$0x0, (%rdx)
000000010000fd69	movzbl	(%rcx,%rsi), %eax
000000010000fd6d	movsbq	%al, %rsi
000000010000fd71	jmp	0x10000fccc
000000010000fd76	cmpl	$0x2, (%rdx)
000000010000fd79	movl	(%rcx,%rsi), %eax
000000010000fd7c	movslq	%eax, %rsi
000000010000fd7f	jmp	0x10000fccc
000000010000fd84	movb	$0x5d, -0x270(%rbp)
000000010000fd8b	leaq	-0x270(%rbp), %rsi
000000010000fd92	movl	$0x1, %edx
000000010000fd97	movq	%r13, %rdi
000000010000fd9a	jmp	0x10000feb6
000000010000fd9f	movq	0x328a(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fda6	movq	(%rax), %rax
000000010000fda9	cmpq	-0x30(%rbp), %rax
000000010000fdad	jne	0x100010018
000000010000fdb3	leaq	0x2b4e(%rip), %rsi              ## literal pool for: "()"
000000010000fdba	movl	$0x2, %edx
000000010000fdbf	movq	%r13, %rdi
000000010000fdc2	jmp	0x10000fc66
000000010000fdc7	xorl	%eax, %eax
000000010000fdc9	movb	$0x0, -0x26f(%rbp,%rax)
000000010000fdd1	jmp	0x10000fe9e
000000010000fdd6	movl	%edi, %edx
000000010000fdd8	andl	$0x1f, %edx
000000010000fddb	movq	%rax, %rcx
000000010000fdde	subq	%rdx, %rcx
000000010000fde1	leaq	-0x260(%rbp), %rsi
000000010000fde8	movdqa	0x18c0(%rip), %xmm0
000000010000fdf0	movq	%rax, %r8
000000010000fdf3	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000fdfd	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000fe04	pshufb	%xmm0, %xmm2
000000010000fe09	pshufb	%xmm0, %xmm1
000000010000fe0e	movdqa	%xmm2, -0x10(%rsi)
000000010000fe13	movdqa	%xmm1, (%rsi)
000000010000fe17	addq	$-0x20, %r8
000000010000fe1b	addq	$0x20, %rsi
000000010000fe1f	cmpq	%r8, %rdx
000000010000fe22	jne	0x10000fdf3
000000010000fe24	testq	%rdx, %rdx
000000010000fe27	je	0x10000fe96
000000010000fe29	cmpl	$0x7, %edx
000000010000fe2c	jbe	0x10000fe73
000000010000fe2e	movl	%edi, %edx
000000010000fe30	andl	$0x7, %edx
000000010000fe33	movq	%rax, %rsi
000000010000fe36	subq	%rcx, %rsi
000000010000fe39	leaq	(%rcx,%rbp), %rdi
000000010000fe3d	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000fe44	movq	%rax, %rcx
000000010000fe47	subq	%rdx, %rcx
000000010000fe4a	movq	0x186e(%rip), %xmm0
000000010000fe52	movq	-0x78(%rbp,%rsi), %xmm1
000000010000fe58	pshufb	%xmm0, %xmm1
000000010000fe5d	movq	%xmm1, (%rdi)
000000010000fe61	addq	$-0x8, %rsi
000000010000fe65	addq	$0x8, %rdi
000000010000fe69	cmpq	%rsi, %rdx
000000010000fe6c	jne	0x10000fe52
000000010000fe6e	testq	%rdx, %rdx
000000010000fe71	je	0x10000fe96
000000010000fe73	leaq	-0x70(%rbp), %rsi
000000010000fe77	addq	%rsi, %rdx
000000010000fe7a	decq	%rdx
000000010000fe7d	nopl	(%rax)
000000010000fe80	movzbl	(%rdx), %esi
000000010000fe83	movb	%sil, -0x270(%rbp,%rcx)
000000010000fe8b	incq	%rcx
000000010000fe8e	decq	%rdx
000000010000fe91	cmpq	%rcx, %rax
000000010000fe94	jne	0x10000fe80
000000010000fe96	movb	$0x0, -0x270(%rbp,%rax)
000000010000fe9e	leaq	-0x270(%rbp), %rbx
000000010000fea5	movq	%rbx, %rdi
000000010000fea8	callq	0x100011556                     ## symbol stub for: _strlen
000000010000fead	movq	%r13, %rdi
000000010000feb0	movq	%rbx, %rsi
000000010000feb3	movq	%rax, %rdx
000000010000feb6	callq	_buf_put
000000010000febb	movq	0x316e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fec2	movq	(%rax), %rax
000000010000fec5	cmpq	-0x30(%rbp), %rax
000000010000fec9	jne	0x100010018
000000010000fecf	addq	$0x268, %rsp                    ## imm = 0x268
000000010000fed6	popq	%rbx
000000010000fed7	popq	%r12
000000010000fed9	popq	%r13
000000010000fedb	popq	%r14
000000010000fedd	popq	%r15
000000010000fedf	popq	%rbp
000000010000fee0	retq
000000010000fee1	cmpl	$0x20, %eax
000000010000fee4	jae	0x10000feea
000000010000fee6	xorl	%ecx, %ecx
000000010000fee8	jmp	0x10000ff5f
000000010000feea	movl	%r8d, %edx
000000010000feed	andl	$0x1f, %edx
000000010000fef0	movq	%rax, %rcx
000000010000fef3	subq	%rdx, %rcx
000000010000fef6	movl	%edi, %esi
000000010000fef8	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
000000010000fefe	leaq	(%rsi,%rbp), %r9
000000010000ff02	addq	$-0x80, %r9
000000010000ff06	movl	%edi, %r10d
000000010000ff09	andl	$0x1f, %r10d
000000010000ff0d	subq	%r10, %rsi
000000010000ff10	xorl	%r10d, %r10d
000000010000ff13	movdqa	0x1795(%rip), %xmm0
000000010000ff1b	movdqu	-0x10(%r9), %xmm1
000000010000ff21	movdqu	(%r9), %xmm2
000000010000ff26	pshufb	%xmm0, %xmm2
000000010000ff2b	pshufb	%xmm0, %xmm1
000000010000ff30	movdqu	%xmm2, -0x26f(%rbp,%r10)
000000010000ff3a	movdqu	%xmm1, -0x25f(%rbp,%r10)
000000010000ff44	addq	$0x20, %r10
000000010000ff48	addq	$-0x20, %r9
000000010000ff4c	cmpq	%r10, %rsi
000000010000ff4f	jne	0x10000ff1b
000000010000ff51	testq	%rdx, %rdx
000000010000ff54	je	0x10000fff6
000000010000ff5a	cmpl	$0x7, %edx
000000010000ff5d	jbe	0x10000ffc4
000000010000ff5f	movq	%rcx, %rsi
000000010000ff62	movl	%r8d, %edx
000000010000ff65	andl	$0x7, %edx
000000010000ff68	movq	%rax, %rcx
000000010000ff6b	subq	%rdx, %rcx
000000010000ff6e	movq	%rsi, %r8
000000010000ff71	negq	%r8
000000010000ff74	leaq	(%r8,%rbp), %r9
000000010000ff78	addq	$-0x70, %r9
000000010000ff7c	movl	%edi, %r8d
000000010000ff7f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
000000010000ff86	addq	%r8, %r9
000000010000ff89	addq	$-0x8, %r9
000000010000ff8d	movl	%edi, %r10d
000000010000ff90	andl	$0x7, %r10d
000000010000ff94	subq	%r10, %r8
000000010000ff97	movq	0x1721(%rip), %xmm0
000000010000ff9f	movq	(%r9), %xmm1
000000010000ffa4	pshufb	%xmm0, %xmm1
000000010000ffa9	movq	%xmm1, -0x26f(%rbp,%rsi)
000000010000ffb2	addq	$0x8, %rsi
000000010000ffb6	addq	$-0x8, %r9
000000010000ffba	cmpq	%rsi, %r8
000000010000ffbd	jne	0x10000ff9f
000000010000ffbf	testq	%rdx, %rdx
000000010000ffc2	je	0x10000fff6
000000010000ffc4	leaq	-0x70(%rbp), %rsi
000000010000ffc8	addq	%rsi, %rdx
000000010000ffcb	decq	%rdx
000000010000ffce	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
000000010000ffd4	nopw	%cs:(%rax,%rax)
000000010000ffe0	movzbl	(%rdx), %esi
000000010000ffe3	movb	%sil, -0x26f(%rbp,%rcx)
000000010000ffeb	incq	%rcx
000000010000ffee	decq	%rdx
000000010000fff1	cmpq	%rcx, %rdi
000000010000fff4	jne	0x10000ffe0
000000010000fff6	movb	$0x0, -0x26f(%rbp,%rax)
000000010000fffe	jmp	0x10000fe9e
0000000100010003	movq	%rbx, %rdi
0000000100010006	movsd	-0x280(%rbp), %xmm0
000000010001000e	movl	$0x9, %esi
0000000100010013	jmp	0x10000ee7a
0000000100010018	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
000000010001001d	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
0000000100010027	jmp	0x10000fe9e
000000010001002c	repne		jmp	0x10001002e
000000010001002f	pushq	%rdx
0000000100010031	jmp	0x100010032
0000000100010033	pushq	%rdx
0000000100010035	jmp	0x100010036
0000000100010037	pushq	%rdx
0000000100010039	jmp	0x10001003a
000000010001003b	decl	-0x4000011(%rsi)
0000000100010041	jmp	0x100010042
0000000100010043	.byte 0xff #bad opcode
0000000100010044	sti
0000000100010045	jmp	0x100010046
0000000100010047	.byte 0xff #bad opcode
0000000100010048	sti
0000000100010049	jmp	0x10001004a
000000010001004b	.byte 0xff #bad opcode
000000010001004c	sti
000000010001004d	jmp	0x10001004e
000000010001004f	jmpq	*%rax
0000000100010051	outb	%al, %dx
0000000100010052	.byte 0xff #bad opcode
0000000100010053	.byte 0xff #bad opcode
0000000100010054	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
0000000100010059	inl	%dx, %eax
000000010001005a	.byte 0xff #bad opcode
000000010001005b	pushq	-0x22000012(%rbp)
0000000100010061	.byte 0xf1 #bad opcode
0000000100010062	.byte 0xff #bad opcode
0000000100010063	ljmpl	*0x40ffffed(%rcx)
0000000100010069	lock
000000010001006a	.byte 0xff #bad opcode
000000010001006b	incl	-0x13(%rcx)
000000010001006e	.byte 0xff #bad opcode
000000010001006f	.byte 0xff #bad opcode
0000000100010070	jl	0x100010063
0000000100010072	.byte 0xff #bad opcode
0000000100010073	jmpq	*(%rax)
0000000100010075	inb	%dx, %al
0000000100010076	.byte 0xff #bad opcode
0000000100010077	jmpq	*(%rax)
0000000100010079	inb	%dx, %al
000000010001007a	.byte 0xff #bad opcode
000000010001007b	incl	%esp
000000010001007d	lock
000000010001007e	.byte 0xff #bad opcode
000000010001007f	pushq	(%rax)
0000000100010081	.byte 0xf1 #bad opcode
0000000100010082	.byte 0xff #bad opcode
0000000100010083	callq	*(%rsi)
0000000100010085	cmc
0000000100010086	.byte 0xff #bad opcode
0000000100010087	.byte 0xff #bad opcode
0000000100010088	cmc
000000010001008a	.byte 0xff #bad opcode
000000010001008b	decl	0x5bffffee(%rbp)
0000000100010091	outb	%al, %dx
0000000100010092	.byte 0xff #bad opcode
0000000100010093	.byte 0xff #bad opcode
0000000100010094	inb	%dx, %al
0000000100010095	cmc
0000000100010096	.byte 0xff #bad opcode
0000000100010097	.byte 0xff #bad opcode
0000000100010098	inb	%dx, %al
0000000100010099	cmc
000000010001009a	.byte 0xff #bad opcode
000000010001009b	.byte 0xff #bad opcode
000000010001009c	inb	%dx, %al
000000010001009d	cmc
000000010001009e	.byte 0xff #bad opcode
000000010001009f	.byte 0xff #bad opcode
00000001000100a0	inb	%dx, %al
00000001000100a1	cmc
00000001000100a2	.byte 0xff #bad opcode
00000001000100a3	jmpq	*-0xa(%rcx)
00000001000100a6	.byte 0xff #bad opcode
00000001000100a7	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100ab	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100af	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100b3	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100b7	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100bb	jmpq	*-0xa(%rdi)
00000001000100be	.byte 0xff #bad opcode
00000001000100bf	.byte 0xff #bad opcode
00000001000100c0	inb	%dx, %al
00000001000100c1	cmc
00000001000100c2	.byte 0xff #bad opcode
00000001000100c3	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100c7	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100cb	callq	*-0xa(%rbx)
00000001000100ce	.byte 0xff #bad opcode
00000001000100cf	ljmpl	*-0x1(%rbp,%rsi,8)
00000001000100d3	ljmpl	*-0xa(%rdi)
00000001000100d6	.byte 0xff #bad opcode
00000001000100d7	decl	(%rdi)
00000001000100d9	.byte 0x1f #bad opcode
00000001000100da	testb	%al, (%rax)
00000001000100dc	addb	%al, (%rax)
00000001000100de	addb	%al, (%rax)
_fwp_escape:
00000001000100e0	pushq	%rbp
00000001000100e1	movq	%rsp, %rbp
00000001000100e4	pushq	%r15
00000001000100e6	pushq	%r14
00000001000100e8	pushq	%r13
00000001000100ea	pushq	%r12
00000001000100ec	pushq	%rbx
00000001000100ed	subq	$0x18, %rsp
00000001000100f1	movq	%rdx, %r14
00000001000100f4	movq	%rsi, %r15
00000001000100f7	movq	%rdi, %rbx
00000001000100fa	movq	0x2f2f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010101	movq	(%rax), %rax
0000000100010104	movq	%rax, -0x30(%rbp)
0000000100010108	movb	$0x22, -0x40(%rbp)
000000010001010c	leaq	-0x40(%rbp), %rsi
0000000100010110	movl	$0x1, %edx
0000000100010115	callq	_buf_put
000000010001011a	testq	%r14, %r14
000000010001011d	je	0x100010219
0000000100010123	leaq	0x12a(%rip), %r12
000000010001012a	xorl	%r13d, %r13d
000000010001012d	jmp	0x100010151
000000010001012f	movl	$0x2, %edx
0000000100010134	movq	%rbx, %rdi
0000000100010137	leaq	0x27f4(%rip), %rsi              ## literal pool for: "\\r"
000000010001013e	nop
0000000100010140	callq	_buf_put
0000000100010145	incq	%r13
0000000100010148	cmpq	%r13, %r14
000000010001014b	je	0x100010219
0000000100010151	movzbl	(%r15,%r13), %eax
0000000100010156	movzbl	%al, %ecx
0000000100010159	leal	-0x9(%rcx), %edx
000000010001015c	cmpl	$0x19, %edx
000000010001015f	ja	0x100010180
0000000100010161	movslq	(%r12,%rdx,4), %rdx
0000000100010165	addq	%r12, %rdx
0000000100010168	jmpq	*%rdx
000000010001016a	movl	$0x2, %edx
000000010001016f	movq	%rbx, %rdi
0000000100010172	leaq	0x27b6(%rip), %rsi              ## literal pool for: "\\t"
0000000100010179	jmp	0x100010140
000000010001017b	nopl	(%rax,%rax)
0000000100010180	cmpl	$0x5c, %ecx
0000000100010183	jne	0x100010196
0000000100010185	movl	$0x2, %edx
000000010001018a	movq	%rbx, %rdi
000000010001018d	leaq	0x2795(%rip), %rsi              ## literal pool for: "\\\\"
0000000100010194	jmp	0x100010140
0000000100010196	cmpb	$0x20, %al
0000000100010198	setae	%dl
000000010001019b	cmpb	$0x7f, %al
000000010001019d	setne	%sil
00000001000101a1	testb	%sil, %dl
00000001000101a4	jne	0x100010205
00000001000101a6	movl	$0x10, %esi
00000001000101ab	leaq	-0x40(%rbp), %r12
00000001000101af	movq	%r12, %rdi
00000001000101b2	leaq	0x277c(%rip), %rdx              ## literal pool for: "\\u{%x}"
00000001000101b9	xorl	%eax, %eax
00000001000101bb	callq	0x10001153e                     ## symbol stub for: _snprintf
00000001000101c0	movq	%r12, %rdi
00000001000101c3	callq	0x100011556                     ## symbol stub for: _strlen
00000001000101c8	movq	%rbx, %rdi
00000001000101cb	movq	%r12, %rsi
00000001000101ce	leaq	0x7f(%rip), %r12
00000001000101d5	movq	%rax, %rdx
00000001000101d8	jmp	0x100010140
00000001000101dd	movl	$0x2, %edx
00000001000101e2	movq	%rbx, %rdi
00000001000101e5	leaq	0x273a(%rip), %rsi              ## literal pool for: "\\\""
00000001000101ec	jmp	0x100010140
00000001000101f1	movl	$0x2, %edx
00000001000101f6	movq	%rbx, %rdi
00000001000101f9	leaq	0x272c(%rip), %rsi              ## literal pool for: "\\n"
0000000100010200	jmp	0x100010140
0000000100010205	movb	%al, -0x40(%rbp)
0000000100010208	movl	$0x1, %edx
000000010001020d	movq	%rbx, %rdi
0000000100010210	leaq	-0x40(%rbp), %rsi
0000000100010214	jmp	0x100010140
0000000100010219	movb	$0x22, -0x40(%rbp)
000000010001021d	leaq	-0x40(%rbp), %rsi
0000000100010221	movl	$0x1, %edx
0000000100010226	movq	%rbx, %rdi
0000000100010229	callq	_buf_put
000000010001022e	movq	0x2dfb(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010235	movq	(%rax), %rax
0000000100010238	cmpq	-0x30(%rbp), %rax
000000010001023c	jne	0x10001024d
000000010001023e	addq	$0x18, %rsp
0000000100010242	popq	%rbx
0000000100010243	popq	%r12
0000000100010245	popq	%r13
0000000100010247	popq	%r14
0000000100010249	popq	%r15
000000010001024b	popq	%rbp
000000010001024c	retq
000000010001024d	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100010252	nop
0000000100010254	.byte 0x16 #bad opcode
0000000100010255	.byte 0xff #bad opcode
0000000100010256	.byte 0xff #bad opcode
0000000100010257	lcalll	*0x42ffffff(%rbp)
000000010001025d	.byte 0xff #bad opcode
000000010001025e	.byte 0xff #bad opcode
000000010001025f	incl	-0x1(%rdx)
0000000100010262	.byte 0xff #bad opcode
0000000100010263	.byte 0xff #bad opcode
0000000100010264	.byte 0xdb #bad opcode
0000000100010265	.byte 0xfe #bad opcode
0000000100010266	.byte 0xff #bad opcode
0000000100010267	incl	-0x1(%rdx)
000000010001026a	.byte 0xff #bad opcode
000000010001026b	incl	-0x1(%rdx)
000000010001026e	.byte 0xff #bad opcode
000000010001026f	incl	-0x1(%rdx)
0000000100010272	.byte 0xff #bad opcode
0000000100010273	incl	-0x1(%rdx)
0000000100010276	.byte 0xff #bad opcode
0000000100010277	incl	-0x1(%rdx)
000000010001027a	.byte 0xff #bad opcode
000000010001027b	incl	-0x1(%rdx)
000000010001027e	.byte 0xff #bad opcode
000000010001027f	incl	-0x1(%rdx)
0000000100010282	.byte 0xff #bad opcode
0000000100010283	incl	-0x1(%rdx)
0000000100010286	.byte 0xff #bad opcode
0000000100010287	incl	-0x1(%rdx)
000000010001028a	.byte 0xff #bad opcode
000000010001028b	incl	-0x1(%rdx)
000000010001028e	.byte 0xff #bad opcode
000000010001028f	incl	-0x1(%rdx)
0000000100010292	.byte 0xff #bad opcode
0000000100010293	incl	-0x1(%rdx)
0000000100010296	.byte 0xff #bad opcode
0000000100010297	incl	-0x1(%rdx)
000000010001029a	.byte 0xff #bad opcode
000000010001029b	incl	-0x1(%rdx)
000000010001029e	.byte 0xff #bad opcode
000000010001029f	incl	-0x1(%rdx)
00000001000102a2	.byte 0xff #bad opcode
00000001000102a3	incl	-0x1(%rdx)
00000001000102a6	.byte 0xff #bad opcode
00000001000102a7	incl	-0x1(%rdx)
00000001000102aa	.byte 0xff #bad opcode
00000001000102ab	incl	-0x1(%rdx)
00000001000102ae	.byte 0xff #bad opcode
00000001000102af	incl	-0x1(%rdx)
00000001000102b2	.byte 0xff #bad opcode
00000001000102b3	incl	-0x1(%rdx)
00000001000102b6	.byte 0xff #bad opcode
00000001000102b7	decl	0xfffffff(%rcx)
00000001000102bd	.byte 0x1f #bad opcode
00000001000102be	addb	%dl, 0x48(%rbp)
00000001000102c2	movl	%esp, %ebp
00000001000102c4	pushq	%r15
00000001000102c6	pushq	%r14
00000001000102c8	pushq	%r13
00000001000102ca	pushq	%r12
00000001000102cc	pushq	%rbx
00000001000102cd	subq	$0x88, %rsp
00000001000102d4	movq	0x2d55(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000102db	movq	(%rax), %rax
00000001000102de	movq	%rax, -0x30(%rbp)
00000001000102e2	movq	%rsi, %rax
00000001000102e5	orq	%rdx, %rax
00000001000102e8	je	0x1000105b9
00000001000102ee	movq	%rdx, %r8
00000001000102f1	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
00000001000102fb	imulq	%rsi, %rcx
00000001000102ff	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
0000000100010309	movq	%rsi, %rax
000000010001030c	mulq	%r9
000000010001030f	addq	%rcx, %rdx
0000000100010312	imulq	%r8, %r9
0000000100010316	addq	%rdx, %r9
0000000100010319	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
0000000100010323	addq	%rax, %rcx
0000000100010326	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
0000000100010330	adcq	%r9, %rax
0000000100010333	movq	%rax, %rdx
0000000100010336	shrdq	$0xd, %rcx, %rdx
000000010001033b	shldq	$0x33, %rcx, %rax
0000000100010340	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
000000010001034a	cmpq	%rax, %rcx
000000010001034d	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
0000000100010352	sbbq	%rdx, %rax
0000000100010355	jae	0x1000105d6
000000010001035b	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
0000000100010365	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
000000010001036f	movq	%rsi, %rax
0000000100010372	mulq	%r9
0000000100010375	imulq	%rsi, %rcx
0000000100010379	addq	%rcx, %rdx
000000010001037c	imulq	%r8, %r9
0000000100010380	addq	%rdx, %r9
0000000100010383	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
000000010001038d	addq	%rax, %rcx
0000000100010390	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
000000010001039a	adcq	%r9, %rax
000000010001039d	movq	%rax, %rdx
00000001000103a0	shrdq	$0xb, %rcx, %rdx
00000001000103a5	shldq	$0x35, %rcx, %rax
00000001000103aa	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
00000001000103b4	cmpq	%rcx, %rax
00000001000103b7	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
00000001000103be	jb	0x1000105f8
00000001000103c4	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
00000001000103ce	imulq	%rsi, %rcx
00000001000103d2	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
00000001000103dc	movq	%rsi, %rax
00000001000103df	mulq	%r9
00000001000103e2	addq	%rcx, %rdx
00000001000103e5	imulq	%r8, %r9
00000001000103e9	addq	%rdx, %r9
00000001000103ec	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
00000001000103f6	addq	%rax, %rcx
00000001000103f9	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
0000000100010403	adcq	%r9, %rax
0000000100010406	movq	%rax, %rdx
0000000100010409	shrdq	$0x9, %rcx, %rdx
000000010001040e	shldq	$0x37, %rcx, %rax
0000000100010413	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
000000010001041d	cmpq	%rcx, %rax
0000000100010420	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
000000010001042a	sbbq	%rax, %rdx
000000010001042d	jb	0x1000106f8
0000000100010433	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
000000010001043d	imulq	%rsi, %rcx
0000000100010441	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
000000010001044b	movq	%rsi, %rax
000000010001044e	mulq	%r9
0000000100010451	addq	%rcx, %rdx
0000000100010454	imulq	%r8, %r9
0000000100010458	addq	%rdx, %r9
000000010001045b	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
0000000100010465	addq	%rax, %rcx
0000000100010468	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
0000000100010472	adcq	%r9, %rax
0000000100010475	movq	%rax, %rdx
0000000100010478	shrdq	$0x6, %rcx, %rdx
000000010001047d	shldq	$0x3a, %rcx, %rax
0000000100010482	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
000000010001048c	cmpq	%rcx, %rax
000000010001048f	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
0000000100010499	sbbq	%rax, %rdx
000000010001049c	jb	0x100010709
00000001000104a2	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
00000001000104ac	imulq	%rsi, %rcx
00000001000104b0	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
00000001000104ba	movq	%rsi, %rax
00000001000104bd	mulq	%r9
00000001000104c0	addq	%rcx, %rdx
00000001000104c3	imulq	%r8, %r9
00000001000104c7	addq	%rdx, %r9
00000001000104ca	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
00000001000104d4	addq	%rax, %rcx
00000001000104d7	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
00000001000104e1	adcq	%r9, %rax
00000001000104e4	movq	%rax, %rdx
00000001000104e7	shrdq	$0x3, %rcx, %rdx
00000001000104ec	shldq	$0x3d, %rcx, %rax
00000001000104f1	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
00000001000104fb	cmpq	%rcx, %rax
00000001000104fe	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
0000000100010508	sbbq	%rax, %rdx
000000010001050b	jb	0x10001071a
0000000100010511	testq	%r8, %r8
0000000100010514	js	0x100010b3c
000000010001051a	xorl	%r10d, %r10d
000000010001051d	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010527	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010531	movq	%r8, %r14
0000000100010534	nopw	%cs:(%rax,%rax)
0000000100010540	movq	%r8, %rcx
0000000100010543	shldq	$0x3f, %rsi, %rcx
0000000100010548	shrq	%r14
000000010001054b	movq	%rcx, %r9
000000010001054e	addq	%r14, %r9
0000000100010551	adcq	$0x0, %r9
0000000100010555	movq	%r9, %rax
0000000100010558	mulq	%r11
000000010001055b	shrq	$0x2, %rdx
000000010001055f	leaq	(%rdx,%rdx,4), %rax
0000000100010563	subq	%rax, %r9
0000000100010566	subq	%r9, %rcx
0000000100010569	sbbq	$0x0, %r14
000000010001056d	movq	%rcx, %r9
0000000100010570	imulq	%rbx, %r9
0000000100010574	movq	%rcx, %rax
0000000100010577	mulq	%r11
000000010001057a	addq	%r9, %rdx
000000010001057d	imulq	%r11, %r14
0000000100010581	addq	%rdx, %r14
0000000100010584	movq	%rax, %rcx
0000000100010587	addq	%rax, %rcx
000000010001058a	leaq	(%rcx,%rcx,4), %rcx
000000010001058e	movl	%esi, %edx
0000000100010590	subl	%ecx, %edx
0000000100010592	orb	$0x30, %dl
0000000100010595	movb	%dl, -0x70(%rbp,%r10)
000000010001059a	incq	%r10
000000010001059d	cmpq	$0xa, %rsi
00000001000105a1	sbbq	$0x0, %r8
00000001000105a5	movq	%rax, %rsi
00000001000105a8	movq	%r14, %r8
00000001000105ab	jae	0x100010540
00000001000105ad	testl	%r10d, %r10d
00000001000105b0	jg	0x1000105c3
00000001000105b2	xorl	%eax, %eax
00000001000105b4	jmp	0x1000106d6
00000001000105b9	movb	$0x30, -0x70(%rbp)
00000001000105bd	movl	$0x1, %r10d
00000001000105c3	movl	%r10d, %eax
00000001000105c6	cmpq	$0x8, %rax
00000001000105ca	jae	0x1000105ef
00000001000105cc	xorl	%ecx, %ecx
00000001000105ce	movq	%rax, %rdx
00000001000105d1	jmp	0x1000106b2
00000001000105d6	movq	%rdi, %r14
00000001000105d9	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
00000001000105e3	leaq	_fwp_fmt_duration.units(%rip), %rbx
00000001000105ea	jmp	0x100010729
00000001000105ef	cmpl	$0x20, %eax
00000001000105f2	jae	0x100010611
00000001000105f4	xorl	%ecx, %ecx
00000001000105f6	jmp	0x10001066b
00000001000105f8	movq	%rdi, %r14
00000001000105fb	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
0000000100010605	leaq	0x3384(%rip), %rbx
000000010001060c	jmp	0x100010729
0000000100010611	movl	%r10d, %edx
0000000100010614	andl	$0x1f, %edx
0000000100010617	movq	%rax, %rcx
000000010001061a	subq	%rdx, %rcx
000000010001061d	leaq	-0xa0(%rbp), %rsi
0000000100010624	movdqa	0x1084(%rip), %xmm0
000000010001062c	movq	%rax, %r8
000000010001062f	nop
0000000100010630	movdqu	-0x90(%rbp,%r8), %xmm1
000000010001063a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010641	pshufb	%xmm0, %xmm2
0000000100010646	pshufb	%xmm0, %xmm1
000000010001064b	movdqa	%xmm2, -0x10(%rsi)
0000000100010650	movdqa	%xmm1, (%rsi)
0000000100010654	addq	$-0x20, %r8
0000000100010658	addq	$0x20, %rsi
000000010001065c	cmpq	%r8, %rdx
000000010001065f	jne	0x100010630
0000000100010661	testq	%rdx, %rdx
0000000100010664	je	0x1000106d6
0000000100010666	cmpl	$0x7, %edx
0000000100010669	jbe	0x1000106b2
000000010001066b	movl	%r10d, %edx
000000010001066e	andl	$0x7, %edx
0000000100010671	movq	%rax, %rsi
0000000100010674	subq	%rcx, %rsi
0000000100010677	leaq	(%rcx,%rbp), %r8
000000010001067b	addq	$-0xb0, %r8
0000000100010682	movq	%rax, %rcx
0000000100010685	subq	%rdx, %rcx
0000000100010688	movq	0x1030(%rip), %xmm0
0000000100010690	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010696	pshufb	%xmm0, %xmm1
000000010001069b	movq	%xmm1, (%r8)
00000001000106a0	addq	$-0x8, %rsi
00000001000106a4	addq	$0x8, %r8
00000001000106a8	cmpq	%rsi, %rdx
00000001000106ab	jne	0x100010690
00000001000106ad	testq	%rdx, %rdx
00000001000106b0	je	0x1000106d6
00000001000106b2	leaq	-0x70(%rbp), %rsi
00000001000106b6	addq	%rsi, %rdx
00000001000106b9	decq	%rdx
00000001000106bc	nopl	(%rax)
00000001000106c0	movzbl	(%rdx), %esi
00000001000106c3	movb	%sil, -0xb0(%rbp,%rcx)
00000001000106cb	incq	%rcx
00000001000106ce	decq	%rdx
00000001000106d1	cmpq	%rcx, %rax
00000001000106d4	jne	0x1000106c0
00000001000106d6	movb	$0x0, -0xb0(%rbp,%rax)
00000001000106de	leaq	0x225c(%rip), %rsi              ## literal pool for: "%sns"
00000001000106e5	leaq	-0xb0(%rbp), %rdx
00000001000106ec	xorl	%eax, %eax
00000001000106ee	callq	0x100011544                     ## symbol stub for: _sprintf
00000001000106f3	jmp	0x100010b16
00000001000106f8	movq	%rdi, %r14
00000001000106fb	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
0000000100010700	leaq	0x3299(%rip), %rbx
0000000100010707	jmp	0x100010729
0000000100010709	movq	%rdi, %r14
000000010001070c	movl	$0xf4240, %edx                  ## imm = 0xF4240
0000000100010711	leaq	0x3298(%rip), %rbx
0000000100010718	jmp	0x100010729
000000010001071a	movq	%rdi, %r14
000000010001071d	movl	$0x3e8, %edx                    ## imm = 0x3E8
0000000100010722	leaq	0x3297(%rip), %rbx
0000000100010729	xorl	%ecx, %ecx
000000010001072b	movq	%rsi, %rdi
000000010001072e	movq	%r8, %rsi
0000000100010731	callq	0x100011424                     ## symbol stub for: ___divti3
0000000100010736	movq	%rax, %rcx
0000000100010739	movq	%rdx, %rsi
000000010001073c	testq	%rdx, %rdx
000000010001073f	js	0x1000107f0
0000000100010745	movq	%rcx, %rax
0000000100010748	orq	%rsi, %rax
000000010001074b	je	0x1000108c9
0000000100010751	xorl	%r10d, %r10d
0000000100010754	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
000000010001075e	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010768	movq	%rsi, %r12
000000010001076b	movq	%r14, %rdi
000000010001076e	nop
0000000100010770	movq	%rsi, %r8
0000000100010773	shldq	$0x3f, %rcx, %r8
0000000100010778	shrq	%r12
000000010001077b	movq	%r8, %r9
000000010001077e	addq	%r12, %r9
0000000100010781	adcq	$0x0, %r9
0000000100010785	movq	%r9, %rax
0000000100010788	mulq	%r11
000000010001078b	shrq	$0x2, %rdx
000000010001078f	leaq	(%rdx,%rdx,4), %rax
0000000100010793	subq	%rax, %r9
0000000100010796	subq	%r9, %r8
0000000100010799	sbbq	$0x0, %r12
000000010001079d	movq	%r8, %r9
00000001000107a0	imulq	%r15, %r9
00000001000107a4	movq	%r8, %rax
00000001000107a7	mulq	%r11
00000001000107aa	addq	%r9, %rdx
00000001000107ad	imulq	%r11, %r12
00000001000107b1	addq	%rdx, %r12
00000001000107b4	movq	%rax, %rdx
00000001000107b7	addq	%rax, %rdx
00000001000107ba	leaq	(%rdx,%rdx,4), %rdx
00000001000107be	movl	%ecx, %r8d
00000001000107c1	subl	%edx, %r8d
00000001000107c4	orb	$0x30, %r8b
00000001000107c8	movb	%r8b, -0x70(%rbp,%r10)
00000001000107cd	incq	%r10
00000001000107d0	cmpq	$0xa, %rcx
00000001000107d4	sbbq	$0x0, %rsi
00000001000107d8	movq	%rax, %rcx
00000001000107db	movq	%r12, %rsi
00000001000107de	jae	0x100010770
00000001000107e0	testl	%r10d, %r10d
00000001000107e3	jg	0x1000108d6
00000001000107e9	xorl	%eax, %eax
00000001000107eb	jmp	0x1000109c6
00000001000107f0	movb	$0x2d, -0xb0(%rbp)
00000001000107f7	xorl	%r9d, %r9d
00000001000107fa	negq	%rcx
00000001000107fd	movl	$0x0, %r11d
0000000100010803	sbbq	%rsi, %r11
0000000100010806	movl	$0x1, %r13d
000000010001080c	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010816	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010820	movq	%r11, %r12
0000000100010823	nopw	%cs:(%rax,%rax)
0000000100010830	movq	%r11, %rsi
0000000100010833	shldq	$0x3f, %rcx, %rsi
0000000100010838	shrq	%r12
000000010001083b	movq	%rsi, %rdi
000000010001083e	addq	%r12, %rdi
0000000100010841	adcq	$0x0, %rdi
0000000100010845	movq	%rdi, %rax
0000000100010848	mulq	%r10
000000010001084b	movl	%r13d, %r8d
000000010001084e	shrq	$0x2, %rdx
0000000100010852	leaq	(%rdx,%rdx,4), %rax
0000000100010856	subq	%rax, %rdi
0000000100010859	subq	%rdi, %rsi
000000010001085c	sbbq	$0x0, %r12
0000000100010860	movq	%rsi, %rdi
0000000100010863	movq	%rsi, %rax
0000000100010866	mulq	%r10
0000000100010869	imulq	%r15, %rdi
000000010001086d	addq	%rdi, %rdx
0000000100010870	imulq	%r10, %r12
0000000100010874	addq	%rdx, %r12
0000000100010877	movq	%rax, %rdx
000000010001087a	addq	%rax, %rdx
000000010001087d	leaq	(%rdx,%rdx,4), %rdx
0000000100010881	movl	%ecx, %esi
0000000100010883	subl	%edx, %esi
0000000100010885	orb	$0x30, %sil
0000000100010889	movb	%sil, -0x70(%rbp,%r9)
000000010001088e	incq	%r9
0000000100010891	leal	0x1(%r8), %r13d
0000000100010895	cmpq	$0xa, %rcx
0000000100010899	sbbq	$0x0, %r11
000000010001089d	movq	%rax, %rcx
00000001000108a0	movq	%r12, %r11
00000001000108a3	jae	0x100010830
00000001000108a5	testl	%r9d, %r9d
00000001000108a8	movq	%r14, %rdi
00000001000108ab	jle	0x1000108f2
00000001000108ad	movl	%r9d, %eax
00000001000108b0	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
00000001000108b5	cmpq	$0x8, %rax
00000001000108b9	jae	0x1000109d3
00000001000108bf	xorl	%ecx, %ecx
00000001000108c1	movq	%rax, %rdx
00000001000108c4	jmp	0x100010ac5
00000001000108c9	movb	$0x30, -0x70(%rbp)
00000001000108cd	movl	$0x1, %r10d
00000001000108d3	movq	%r14, %rdi
00000001000108d6	movl	%r10d, %eax
00000001000108d9	cmpq	$0x8, %rax
00000001000108dd	jae	0x1000108e9
00000001000108df	xorl	%ecx, %ecx
00000001000108e1	movq	%rax, %rdx
00000001000108e4	jmp	0x1000109a2
00000001000108e9	cmpl	$0x20, %eax
00000001000108ec	jae	0x1000108f9
00000001000108ee	xorl	%ecx, %ecx
00000001000108f0	jmp	0x10001095b
00000001000108f2	xorl	%eax, %eax
00000001000108f4	jmp	0x100010af6
00000001000108f9	movl	%r10d, %edx
00000001000108fc	andl	$0x1f, %edx
00000001000108ff	movq	%rax, %rcx
0000000100010902	subq	%rdx, %rcx
0000000100010905	leaq	-0xa0(%rbp), %rsi
000000010001090c	movdqa	0xd9c(%rip), %xmm0
0000000100010914	movq	%rax, %r8
0000000100010917	nopw	(%rax,%rax)
0000000100010920	movdqu	-0x90(%rbp,%r8), %xmm1
000000010001092a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010931	pshufb	%xmm0, %xmm2
0000000100010936	pshufb	%xmm0, %xmm1
000000010001093b	movdqa	%xmm2, -0x10(%rsi)
0000000100010940	movdqa	%xmm1, (%rsi)
0000000100010944	addq	$-0x20, %r8
0000000100010948	addq	$0x20, %rsi
000000010001094c	cmpq	%r8, %rdx
000000010001094f	jne	0x100010920
0000000100010951	testq	%rdx, %rdx
0000000100010954	je	0x1000109c6
0000000100010956	cmpl	$0x7, %edx
0000000100010959	jbe	0x1000109a2
000000010001095b	movl	%r10d, %edx
000000010001095e	andl	$0x7, %edx
0000000100010961	movq	%rax, %rsi
0000000100010964	subq	%rcx, %rsi
0000000100010967	leaq	(%rcx,%rbp), %r8
000000010001096b	addq	$-0xb0, %r8
0000000100010972	movq	%rax, %rcx
0000000100010975	subq	%rdx, %rcx
0000000100010978	movq	0xd40(%rip), %xmm0
0000000100010980	movq	-0x78(%rbp,%rsi), %xmm1
0000000100010986	pshufb	%xmm0, %xmm1
000000010001098b	movq	%xmm1, (%r8)
0000000100010990	addq	$-0x8, %rsi
0000000100010994	addq	$0x8, %r8
0000000100010998	cmpq	%rsi, %rdx
000000010001099b	jne	0x100010980
000000010001099d	testq	%rdx, %rdx
00000001000109a0	je	0x1000109c6
00000001000109a2	leaq	-0x70(%rbp), %rsi
00000001000109a6	addq	%rsi, %rdx
00000001000109a9	decq	%rdx
00000001000109ac	nopl	(%rax)
00000001000109b0	movzbl	(%rdx), %esi
00000001000109b3	movb	%sil, -0xb0(%rbp,%rcx)
00000001000109bb	incq	%rcx
00000001000109be	decq	%rdx
00000001000109c1	cmpq	%rcx, %rax
00000001000109c4	jne	0x1000109b0
00000001000109c6	movb	$0x0, -0xb0(%rbp,%rax)
00000001000109ce	jmp	0x100010afe
00000001000109d3	cmpl	$0x20, %eax
00000001000109d6	jae	0x1000109dc
00000001000109d8	xorl	%ecx, %ecx
00000001000109da	jmp	0x100010a54
00000001000109dc	movl	%r9d, %edx
00000001000109df	andl	$0x1f, %edx
00000001000109e2	movq	%rax, %rcx
00000001000109e5	subq	%rdx, %rcx
00000001000109e8	movl	%r8d, %esi
00000001000109eb	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
00000001000109f1	leaq	(%rsi,%rbp), %r10
00000001000109f5	addq	$-0x80, %r10
00000001000109f9	movl	%r8d, %r11d
00000001000109fc	andl	$0x1f, %r11d
0000000100010a00	subq	%r11, %rsi
0000000100010a03	xorl	%r11d, %r11d
0000000100010a06	movdqa	0xca2(%rip), %xmm0
0000000100010a0e	nop
0000000100010a10	movdqu	-0x10(%r10), %xmm1
0000000100010a16	movdqu	(%r10), %xmm2
0000000100010a1b	pshufb	%xmm0, %xmm2
0000000100010a20	pshufb	%xmm0, %xmm1
0000000100010a25	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100010a2f	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100010a39	addq	$0x20, %r11
0000000100010a3d	addq	$-0x20, %r10
0000000100010a41	cmpq	%r11, %rsi
0000000100010a44	jne	0x100010a10
0000000100010a46	testq	%rdx, %rdx
0000000100010a49	je	0x100010af6
0000000100010a4f	cmpl	$0x7, %edx
0000000100010a52	jbe	0x100010ac5
0000000100010a54	movq	%rcx, %rsi
0000000100010a57	movl	%r9d, %edx
0000000100010a5a	andl	$0x7, %edx
0000000100010a5d	movq	%rax, %rcx
0000000100010a60	subq	%rdx, %rcx
0000000100010a63	movq	%rsi, %r9
0000000100010a66	negq	%r9
0000000100010a69	leaq	(%r9,%rbp), %r10
0000000100010a6d	addq	$-0x70, %r10
0000000100010a71	movl	%r8d, %r9d
0000000100010a74	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100010a7b	addq	%r9, %r10
0000000100010a7e	addq	$-0x8, %r10
0000000100010a82	movl	%r8d, %r11d
0000000100010a85	andl	$0x7, %r11d
0000000100010a89	subq	%r11, %r9
0000000100010a8c	movq	0xc2c(%rip), %xmm0
0000000100010a94	nopw	%cs:(%rax,%rax)
0000000100010aa0	movq	(%r10), %xmm1
0000000100010aa5	pshufb	%xmm0, %xmm1
0000000100010aaa	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100010ab3	addq	$0x8, %rsi
0000000100010ab7	addq	$-0x8, %r10
0000000100010abb	cmpq	%rsi, %r9
0000000100010abe	jne	0x100010aa0
0000000100010ac0	testq	%rdx, %rdx
0000000100010ac3	je	0x100010af6
0000000100010ac5	leaq	-0x70(%rbp), %rsi
0000000100010ac9	addq	%rsi, %rdx
0000000100010acc	decq	%rdx
0000000100010acf	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010ad6	nopw	%cs:(%rax,%rax)
0000000100010ae0	movzbl	(%rdx), %esi
0000000100010ae3	movb	%sil, -0xaf(%rbp,%rcx)
0000000100010aeb	incq	%rcx
0000000100010aee	decq	%rdx
0000000100010af1	cmpq	%rcx, %r8
0000000100010af4	jne	0x100010ae0
0000000100010af6	movb	$0x0, -0xaf(%rbp,%rax)
0000000100010afe	movq	(%rbx), %rcx
0000000100010b01	leaq	0x1e34(%rip), %rsi              ## literal pool for: "%s%s"
0000000100010b08	leaq	-0xb0(%rbp), %rdx
0000000100010b0f	xorl	%eax, %eax
0000000100010b11	callq	0x100011544                     ## symbol stub for: _sprintf
0000000100010b16	movq	0x2513(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010b1d	movq	(%rax), %rax
0000000100010b20	cmpq	-0x30(%rbp), %rax
0000000100010b24	jne	0x100010d23
0000000100010b2a	addq	$0x88, %rsp
0000000100010b31	popq	%rbx
0000000100010b32	popq	%r12
0000000100010b34	popq	%r13
0000000100010b36	popq	%r14
0000000100010b38	popq	%r15
0000000100010b3a	popq	%rbp
0000000100010b3b	retq
0000000100010b3c	movb	$0x2d, -0xb0(%rbp)
0000000100010b43	xorl	%r10d, %r10d
0000000100010b46	negq	%rsi
0000000100010b49	movl	$0x0, %ebx
0000000100010b4e	sbbq	%r8, %rbx
0000000100010b51	movl	$0x1, %r12d
0000000100010b57	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010b61	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010b6b	movq	%rbx, %r15
0000000100010b6e	nop
0000000100010b70	movq	%rbx, %rcx
0000000100010b73	shldq	$0x3f, %rsi, %rcx
0000000100010b78	shrq	%r15
0000000100010b7b	movq	%rcx, %r8
0000000100010b7e	addq	%r15, %r8
0000000100010b81	adcq	$0x0, %r8
0000000100010b85	movq	%r8, %rax
0000000100010b88	mulq	%r11
0000000100010b8b	movl	%r12d, %r9d
0000000100010b8e	shrq	$0x2, %rdx
0000000100010b92	leaq	(%rdx,%rdx,4), %rax
0000000100010b96	subq	%rax, %r8
0000000100010b99	subq	%r8, %rcx
0000000100010b9c	sbbq	$0x0, %r15
0000000100010ba0	movq	%rcx, %r8
0000000100010ba3	movq	%rcx, %rax
0000000100010ba6	mulq	%r11
0000000100010ba9	imulq	%r14, %r8
0000000100010bad	addq	%r8, %rdx
0000000100010bb0	imulq	%r11, %r15
0000000100010bb4	addq	%rdx, %r15
0000000100010bb7	movq	%rax, %rcx
0000000100010bba	addq	%rax, %rcx
0000000100010bbd	leaq	(%rcx,%rcx,4), %rcx
0000000100010bc1	movl	%esi, %edx
0000000100010bc3	subl	%ecx, %edx
0000000100010bc5	orb	$0x30, %dl
0000000100010bc8	movb	%dl, -0x70(%rbp,%r10)
0000000100010bcd	incq	%r10
0000000100010bd0	leal	0x1(%r9), %r12d
0000000100010bd4	cmpq	$0xa, %rsi
0000000100010bd8	sbbq	$0x0, %rbx
0000000100010bdc	movq	%rax, %rsi
0000000100010bdf	movq	%r15, %rbx
0000000100010be2	jae	0x100010b70
0000000100010be4	testl	%r10d, %r10d
0000000100010be7	jle	0x100010c01
0000000100010be9	movl	%r10d, %eax
0000000100010bec	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010bf1	cmpq	$0x8, %rax
0000000100010bf5	jae	0x100010c08
0000000100010bf7	xorl	%ecx, %ecx
0000000100010bf9	movq	%rax, %rdx
0000000100010bfc	jmp	0x100010cec
0000000100010c01	xorl	%eax, %eax
0000000100010c03	jmp	0x100010d16
0000000100010c08	cmpl	$0x20, %eax
0000000100010c0b	jae	0x100010c11
0000000100010c0d	xorl	%ecx, %ecx
0000000100010c0f	jmp	0x100010c87
0000000100010c11	movl	%r10d, %edx
0000000100010c14	andl	$0x1f, %edx
0000000100010c17	movq	%rax, %rcx
0000000100010c1a	subq	%rdx, %rcx
0000000100010c1d	movl	%r9d, %esi
0000000100010c20	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010c26	leaq	(%rsi,%rbp), %r8
0000000100010c2a	addq	$-0x80, %r8
0000000100010c2e	movl	%r9d, %r11d
0000000100010c31	andl	$0x1f, %r11d
0000000100010c35	subq	%r11, %rsi
0000000100010c38	xorl	%r11d, %r11d
0000000100010c3b	movdqa	0xa6d(%rip), %xmm0
0000000100010c43	movdqu	-0x10(%r8), %xmm1
0000000100010c49	movdqu	(%r8), %xmm2
0000000100010c4e	pshufb	%xmm0, %xmm2
0000000100010c53	pshufb	%xmm0, %xmm1
0000000100010c58	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100010c62	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100010c6c	addq	$0x20, %r11
0000000100010c70	addq	$-0x20, %r8
0000000100010c74	cmpq	%r11, %rsi
0000000100010c77	jne	0x100010c43
0000000100010c79	testq	%rdx, %rdx
0000000100010c7c	je	0x100010d16
0000000100010c82	cmpl	$0x7, %edx
0000000100010c85	jbe	0x100010cec
0000000100010c87	movq	%rcx, %rsi
0000000100010c8a	movl	%r10d, %edx
0000000100010c8d	andl	$0x7, %edx
0000000100010c90	movq	%rax, %rcx
0000000100010c93	subq	%rdx, %rcx
0000000100010c96	movq	%rsi, %r8
0000000100010c99	negq	%r8
0000000100010c9c	leaq	(%r8,%rbp), %r10
0000000100010ca0	addq	$-0x70, %r10
0000000100010ca4	movl	%r9d, %r8d
0000000100010ca7	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010cae	addq	%r8, %r10
0000000100010cb1	addq	$-0x8, %r10
0000000100010cb5	movl	%r9d, %r11d
0000000100010cb8	andl	$0x7, %r11d
0000000100010cbc	subq	%r11, %r8
0000000100010cbf	movq	0x9f9(%rip), %xmm0
0000000100010cc7	movq	(%r10), %xmm1
0000000100010ccc	pshufb	%xmm0, %xmm1
0000000100010cd1	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100010cda	addq	$0x8, %rsi
0000000100010cde	addq	$-0x8, %r10
0000000100010ce2	cmpq	%rsi, %r8
0000000100010ce5	jne	0x100010cc7
0000000100010ce7	testq	%rdx, %rdx
0000000100010cea	je	0x100010d16
0000000100010cec	leaq	-0x70(%rbp), %rsi
0000000100010cf0	addq	%rsi, %rdx
0000000100010cf3	decq	%rdx
0000000100010cf6	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100010cfd	nopl	(%rax)
0000000100010d00	movzbl	(%rdx), %esi
0000000100010d03	movb	%sil, -0xaf(%rbp,%rcx)
0000000100010d0b	incq	%rcx
0000000100010d0e	decq	%rdx
0000000100010d11	cmpq	%rcx, %r9
0000000100010d14	jne	0x100010d00
0000000100010d16	movb	$0x0, -0xaf(%rbp,%rax)
0000000100010d1e	jmp	0x1000106de
0000000100010d23	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100010d28	nopl	(%rax,%rax)
_fwp_format_g:
0000000100010d30	pushq	%rbp
0000000100010d31	movq	%rsp, %rbp
0000000100010d34	pushq	%r15
0000000100010d36	pushq	%r14
0000000100010d38	pushq	%r13
0000000100010d3a	pushq	%r12
0000000100010d3c	pushq	%rbx
0000000100010d3d	subq	$0x98, %rsp
0000000100010d44	movl	%esi, %r12d
0000000100010d47	movq	%rdi, %rbx
0000000100010d4a	movq	0x22df(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010d51	movq	(%rax), %rax
0000000100010d54	movq	%rax, -0x30(%rbp)
0000000100010d58	decl	%r12d
0000000100010d5b	leaq	0x1bad(%rip), %rdx              ## literal pool for: "%.*e"
0000000100010d62	leaq	-0x70(%rbp), %r13
0000000100010d66	movl	$0x40, %esi
0000000100010d6b	movq	%r13, %rdi
0000000100010d6e	movl	%r12d, %ecx
0000000100010d71	movsd	%xmm0, -0xb8(%rbp)
0000000100010d79	movb	$0x1, %al
0000000100010d7b	callq	0x10001153e                     ## symbol stub for: _snprintf
0000000100010d80	movq	%r13, %rdi
0000000100010d83	movl	$0x65, %esi
0000000100010d88	callq	0x10001154a                     ## symbol stub for: _strchr
0000000100010d8d	movq	%rax, %r15
0000000100010d90	leaq	0x1(%rax), %rdi
0000000100010d94	callq	0x100011466                     ## symbol stub for: _atoi
0000000100010d99	movl	%eax, %r14d
0000000100010d9c	leal	-0x11(%r14), %eax
0000000100010da0	cmpl	$-0x17, %eax
0000000100010da3	ja	0x100010e0e
0000000100010da5	subq	%r13, %r15
0000000100010da8	leaq	-0xb0(%rbp), %r12
0000000100010daf	movl	$0x40, %ecx
0000000100010db4	movq	%r12, %rdi
0000000100010db7	movq	%r13, %rsi
0000000100010dba	movq	%r15, %rdx
0000000100010dbd	callq	0x10001142a                     ## symbol stub for: ___memcpy_chk
0000000100010dc2	movb	$0x0, -0xb0(%rbp,%r15)
0000000100010dcb	movq	%r12, %rdi
0000000100010dce	movl	$0x2e, %esi
0000000100010dd3	callq	0x10001154a                     ## symbol stub for: _strchr
0000000100010dd8	testq	%rax, %rax
0000000100010ddb	sete	%al
0000000100010dde	testq	%r15, %r15
0000000100010de1	sete	%cl
0000000100010de4	orb	%al, %cl
0000000100010de6	jne	0x100010e86
0000000100010dec	nopl	(%rax)
0000000100010df0	movzbl	-0xb1(%rbp,%r15), %eax
0000000100010df9	cmpl	$0x30, %eax
0000000100010dfc	jne	0x100010e78
0000000100010dfe	movb	$0x0, -0xb1(%rbp,%r15)
0000000100010e07	decq	%r15
0000000100010e0a	jne	0x100010df0
0000000100010e0c	jmp	0x100010e86
0000000100010e0e	subl	%r14d, %r12d
0000000100010e11	xorl	%ecx, %ecx
0000000100010e13	testl	%r12d, %r12d
0000000100010e16	cmovgl	%r12d, %ecx
0000000100010e1a	leaq	0x1afd(%rip), %rdx              ## literal pool for: "%.*f"
0000000100010e21	movl	$0x190, %esi                    ## imm = 0x190
0000000100010e26	movq	%rbx, %rdi
0000000100010e29	movsd	-0xb8(%rbp), %xmm0
0000000100010e31	movb	$0x1, %al
0000000100010e33	callq	0x10001153e                     ## symbol stub for: _snprintf
0000000100010e38	movq	%rbx, %rdi
0000000100010e3b	callq	0x100011556                     ## symbol stub for: _strlen
0000000100010e40	movq	%rax, %r14
0000000100010e43	movq	%rbx, %rdi
0000000100010e46	movl	$0x2e, %esi
0000000100010e4b	callq	0x10001154a                     ## symbol stub for: _strchr
0000000100010e50	testq	%rax, %rax
0000000100010e53	sete	%al
0000000100010e56	testq	%r14, %r14
0000000100010e59	sete	%cl
0000000100010e5c	orb	%al, %cl
0000000100010e5e	jne	0x100010ebb
0000000100010e60	movzbl	-0x1(%rbx,%r14), %eax
0000000100010e66	cmpl	$0x30, %eax
0000000100010e69	jne	0x100010edd
0000000100010e6b	movb	$0x0, -0x1(%rbx,%r14)
0000000100010e71	decq	%r14
0000000100010e74	jne	0x100010e60
0000000100010e76	jmp	0x100010ebb
0000000100010e78	cmpl	$0x2e, %eax
0000000100010e7b	jne	0x100010e86
0000000100010e7d	movb	$0x0, -0xb1(%rbp,%r15)
0000000100010e86	movl	%r14d, %eax
0000000100010e89	shrl	$0x1f, %eax
0000000100010e8c	leal	0x2b(,%rax,2), %r8d
0000000100010e94	movl	%r14d, %r9d
0000000100010e97	negl	%r9d
0000000100010e9a	cmovsl	%r14d, %r9d
0000000100010e9e	leaq	0x1a6f(%rip), %rdx              ## literal pool for: "%se%c%02d"
0000000100010ea5	leaq	-0xb0(%rbp), %rcx
0000000100010eac	movl	$0x190, %esi                    ## imm = 0x190
0000000100010eb1	movq	%rbx, %rdi
0000000100010eb4	xorl	%eax, %eax
0000000100010eb6	callq	0x10001153e                     ## symbol stub for: _snprintf
0000000100010ebb	movq	0x216e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010ec2	movq	(%rax), %rax
0000000100010ec5	cmpq	-0x30(%rbp), %rax
0000000100010ec9	jne	0x100010eea
0000000100010ecb	addq	$0x98, %rsp
0000000100010ed2	popq	%rbx
0000000100010ed3	popq	%r12
0000000100010ed5	popq	%r13
0000000100010ed7	popq	%r14
0000000100010ed9	popq	%r15
0000000100010edb	popq	%rbp
0000000100010edc	retq
0000000100010edd	cmpl	$0x2e, %eax
0000000100010ee0	jne	0x100010ebb
0000000100010ee2	movb	$0x0, -0x1(%rbx,%r14)
0000000100010ee8	jmp	0x100010ebb
0000000100010eea	callq	0x100011430                     ## symbol stub for: ___stack_chk_fail
0000000100010eef	nop
_rd_leb:
0000000100010ef0	movq	$0x0, (%rsi)
0000000100010ef7	movq	0x8(%rdi), %r8
0000000100010efb	movq	0x10(%rdi), %rdx
0000000100010eff	cmpq	%rdx, %r8
0000000100010f02	jne	0x100010f07
0000000100010f04	xorl	%eax, %eax
0000000100010f06	retq
0000000100010f07	pushq	%rbp
0000000100010f08	movq	%rsp, %rbp
0000000100010f0b	movq	(%rdi), %rcx
0000000100010f0e	leaq	0x1(%rdx), %r9
0000000100010f12	movq	%r9, 0x10(%rdi)
0000000100010f16	movzbl	(%rcx,%rdx), %r10d
0000000100010f1b	andl	$0x7f, %r10d
0000000100010f1f	movq	%r10, (%rsi)
0000000100010f22	movl	$0x1, %eax
0000000100010f27	cmpb	$0x0, (%rcx,%rdx)
0000000100010f2b	js	0x100010f2f
0000000100010f2d	popq	%rbp
0000000100010f2e	retq
0000000100010f2f	cmpq	%r9, %r8
0000000100010f32	jne	0x100010f38
0000000100010f34	xorl	%eax, %eax
0000000100010f36	popq	%rbp
0000000100010f37	retq
0000000100010f38	leaq	0x2(%rdx), %r11
0000000100010f3c	movq	%r11, 0x10(%rdi)
0000000100010f40	movzbl	0x1(%rcx,%rdx), %r9d
0000000100010f46	andl	$0x7f, %r9d
0000000100010f4a	shll	$0x7, %r9d
0000000100010f4e	orq	%r10, %r9
0000000100010f51	movq	%r9, (%rsi)
0000000100010f54	cmpb	$0x0, 0x1(%rcx,%rdx)
0000000100010f59	jns	0x100010f2d
0000000100010f5b	cmpq	%r11, %r8
0000000100010f5e	je	0x100010f34
0000000100010f60	leaq	0x3(%rdx), %r11
0000000100010f64	movq	%r11, 0x10(%rdi)
0000000100010f68	movzbl	0x2(%rcx,%rdx), %r10d
0000000100010f6e	andl	$0x7f, %r10d
0000000100010f72	shll	$0xe, %r10d
0000000100010f76	orq	%r9, %r10
0000000100010f79	movq	%r10, (%rsi)
0000000100010f7c	cmpb	$0x0, 0x2(%rcx,%rdx)
0000000100010f81	jns	0x100010f2d
0000000100010f83	cmpq	%r11, %r8
0000000100010f86	je	0x100010f34
0000000100010f88	leaq	0x4(%rdx), %r11
0000000100010f8c	movq	%r11, 0x10(%rdi)
0000000100010f90	movzbl	0x3(%rcx,%rdx), %r9d
0000000100010f96	andl	$0x7f, %r9d
0000000100010f9a	shll	$0x15, %r9d
0000000100010f9e	orq	%r10, %r9
0000000100010fa1	movq	%r9, (%rsi)
0000000100010fa4	cmpb	$0x0, 0x3(%rcx,%rdx)
0000000100010fa9	jns	0x100010f2d
0000000100010fab	cmpq	%r11, %r8
0000000100010fae	je	0x100010f34
0000000100010fb0	leaq	0x5(%rdx), %r11
0000000100010fb4	movq	%r11, 0x10(%rdi)
0000000100010fb8	movzbl	0x4(%rcx,%rdx), %r10d
0000000100010fbe	andl	$0x7f, %r10d
0000000100010fc2	shlq	$0x1c, %r10
0000000100010fc6	orq	%r9, %r10
0000000100010fc9	movq	%r10, (%rsi)
0000000100010fcc	cmpb	$0x0, 0x4(%rcx,%rdx)
0000000100010fd1	jns	0x100010f2d
0000000100010fd7	cmpq	%r11, %r8
0000000100010fda	je	0x100010f34
0000000100010fe0	leaq	0x6(%rdx), %r11
0000000100010fe4	movq	%r11, 0x10(%rdi)
0000000100010fe8	movzbl	0x5(%rcx,%rdx), %r9d
0000000100010fee	andl	$0x7f, %r9d
0000000100010ff2	shlq	$0x23, %r9
0000000100010ff6	orq	%r10, %r9
0000000100010ff9	movq	%r9, (%rsi)
0000000100010ffc	cmpb	$0x0, 0x5(%rcx,%rdx)
0000000100011001	jns	0x100010f2d
0000000100011007	cmpq	%r11, %r8
000000010001100a	je	0x100010f34
0000000100011010	leaq	0x7(%rdx), %r11
0000000100011014	movq	%r11, 0x10(%rdi)
0000000100011018	movzbl	0x6(%rcx,%rdx), %r10d
000000010001101e	andl	$0x7f, %r10d
0000000100011022	shlq	$0x2a, %r10
0000000100011026	orq	%r9, %r10
0000000100011029	movq	%r10, (%rsi)
000000010001102c	cmpb	$0x0, 0x6(%rcx,%rdx)
0000000100011031	jns	0x100010f2d
0000000100011037	cmpq	%r11, %r8
000000010001103a	je	0x100010f34
0000000100011040	leaq	0x8(%rdx), %r9
0000000100011044	movq	%r9, 0x10(%rdi)
0000000100011048	movzbl	0x7(%rcx,%rdx), %r11d
000000010001104e	andl	$0x7f, %r11d
0000000100011052	shlq	$0x31, %r11
0000000100011056	orq	%r10, %r11
0000000100011059	movq	%r11, (%rsi)
000000010001105c	cmpb	$0x0, 0x7(%rcx,%rdx)
0000000100011061	jns	0x100010f2d
0000000100011067	cmpq	%r9, %r8
000000010001106a	je	0x100010f34
0000000100011070	leaq	0x9(%rdx), %r9
0000000100011074	movq	%r9, 0x10(%rdi)
0000000100011078	movzbl	0x8(%rcx,%rdx), %r10d
000000010001107e	andl	$0x7f, %r10d
0000000100011082	shlq	$0x38, %r10
0000000100011086	orq	%r11, %r10
0000000100011089	movq	%r10, (%rsi)
000000010001108c	cmpb	$0x0, 0x8(%rcx,%rdx)
0000000100011091	jns	0x100010f2d
0000000100011097	cmpq	%r9, %r8
000000010001109a	je	0x100010f34
00000001000110a0	leaq	0xa(%rdx), %rax
00000001000110a4	movq	%rax, 0x10(%rdi)
00000001000110a8	movzbl	0x9(%rcx,%rdx), %edx
00000001000110ad	movl	$0x0, %eax
00000001000110b2	testb	$0x7e, %dl
00000001000110b5	jne	0x100010f2d
00000001000110bb	shlq	$0x3f, %rdx
00000001000110bf	orq	%r10, %rdx
00000001000110c2	movq	%rdx, (%rsi)
00000001000110c5	xorl	%eax, %eax
00000001000110c7	cmpb	$0x0, (%rcx,%r9)
00000001000110cc	setns	%al
00000001000110cf	popq	%rbp
00000001000110d0	retq
00000001000110d1	nopw	%cs:(%rax,%rax)
_fwp_wire_empty_inner:
00000001000110e0	xorl	%eax, %eax
00000001000110e2	testq	%rdi, %rdi
00000001000110e5	je	0x10001118c
00000001000110eb	cmpl	$0x10, (%rdi)
00000001000110ee	jne	0x10001118c
00000001000110f4	pushq	%rbp
00000001000110f5	movq	%rsp, %rbp
00000001000110f8	pushq	%r15
00000001000110fa	pushq	%r14
00000001000110fc	pushq	%r12
00000001000110fe	pushq	%rbx
00000001000110ff	subq	$0x10, %rsp
0000000100011103	testq	%rsi, %rsi
0000000100011106	je	0x10001111e
0000000100011108	movq	%rsi, %rcx
000000010001110b	nopl	(%rax,%rax)
0000000100011110	cmpq	%rdi, (%rcx)
0000000100011113	je	0x100011180
0000000100011115	movq	0x8(%rcx), %rcx
0000000100011119	testq	%rcx, %rcx
000000010001111c	jne	0x100011110
000000010001111e	movq	%rdi, -0x30(%rbp)
0000000100011122	movq	%rsi, -0x28(%rbp)
0000000100011126	movslq	0x10(%rdi), %r14
000000010001112a	testq	%r14, %r14
000000010001112d	jle	0x100011177
000000010001112f	movq	0x20(%rdi), %r15
0000000100011133	movq	(%r15), %rdi
0000000100011136	leaq	-0x30(%rbp), %rsi
000000010001113a	callq	_fwp_wire_empty_inner
000000010001113f	testl	%eax, %eax
0000000100011141	je	0x10001117e
0000000100011143	movl	$0x1, %ecx
0000000100011148	leaq	-0x30(%rbp), %rbx
000000010001114c	nopl	(%rax)
0000000100011150	movq	%rcx, %r12
0000000100011153	cmpq	%rcx, %r14
0000000100011156	je	0x10001116d
0000000100011158	movq	(%r15,%r12,8), %rdi
000000010001115c	movq	%rbx, %rsi
000000010001115f	callq	_fwp_wire_empty_inner
0000000100011164	leaq	0x1(%r12), %rcx
0000000100011169	testl	%eax, %eax
000000010001116b	jne	0x100011150
000000010001116d	xorl	%eax, %eax
000000010001116f	cmpq	%r14, %r12
0000000100011172	setae	%al
0000000100011175	jmp	0x100011180
0000000100011177	movl	$0x1, %eax
000000010001117c	jmp	0x100011180
000000010001117e	xorl	%eax, %eax
0000000100011180	addq	$0x10, %rsp
0000000100011184	popq	%rbx
0000000100011185	popq	%r12
0000000100011187	popq	%r14
0000000100011189	popq	%r15
000000010001118b	popq	%rbp
000000010001118c	retq
000000010001118d	nopl	(%rax)
_fwp_gc_report:
0000000100011190	pushq	%rbp
0000000100011191	movq	%rsp, %rbp
0000000100011194	pushq	%r15
0000000100011196	pushq	%r14
0000000100011198	pushq	%r13
000000010001119a	pushq	%r12
000000010001119c	pushq	%rbx
000000010001119d	subq	$0xb8, %rsp
00000001000111a4	movq	0x406d(%rip), %rax
00000001000111ab	movq	_fwp_gc(%rip), %rcx
00000001000111b2	subq	%rcx, %rax
00000001000111b5	cvtsi2sd	%rax, %xmm0
00000001000111ba	addsd	0x402e(%rip), %xmm0
00000001000111c2	movsd	%xmm0, -0x50(%rbp)
00000001000111c7	movsd	%xmm0, 0x4021(%rip)
00000001000111cf	movq	%rcx, 0x4042(%rip)
00000001000111d6	movq	0x1e5b(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000111dd	movq	(%rax), %r15
00000001000111e0	movq	0x3ff9(%rip), %rax
00000001000111e7	movq	%rax, -0x30(%rbp)
00000001000111eb	movq	0x3e2e(%rip), %r14
00000001000111f2	movsd	0x4016(%rip), %xmm0
00000001000111fa	movsd	%xmm0, -0x38(%rbp)
00000001000111ff	movq	0x3e4a(%rip), %r12
0000000100011206	movq	0x3fc3(%rip), %r13
000000010001120d	movq	0x3fc4(%rip), %rbx
0000000100011214	movsd	0x3fdc(%rip), %xmm0
000000010001121c	movsd	%xmm0, -0x48(%rbp)
0000000100011221	movsd	0x3fd7(%rip), %xmm0
0000000100011229	movsd	%xmm0, -0x40(%rbp)
000000010001122e	leaq	-0xe0(%rbp), %rsi
0000000100011235	xorl	%edi, %edi
0000000100011237	callq	0x1000114ba                     ## symbol stub for: _getrusage
000000010001123c	movq	$-0x1, %r8
0000000100011243	testl	%eax, %eax
0000000100011245	jne	0x100011260
0000000100011247	movq	-0xc0(%rbp), %rax
000000010001124e	leaq	0x3ff(%rax), %r8
0000000100011255	testq	%rax, %rax
0000000100011258	cmovnsq	%rax, %r8
000000010001125c	sarq	$0xa, %r8
0000000100011260	movq	%rbx, %xmm0
0000000100011265	movq	0x463(%rip), %xmm1
000000010001126d	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100011271	movapd	0x467(%rip), %xmm2
0000000100011279	subpd	%xmm2, %xmm0
000000010001127d	movapd	%xmm0, %xmm4
0000000100011281	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100011285	addsd	%xmm0, %xmm4
0000000100011289	movsd	0x4b7(%rip), %xmm6
0000000100011291	mulsd	%xmm6, %xmm4
0000000100011295	movq	%r13, %xmm5
000000010001129a	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
000000010001129e	subpd	%xmm2, %xmm5
00000001000112a2	movapd	%xmm5, %xmm3
00000001000112a6	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
00000001000112aa	addsd	%xmm5, %xmm3
00000001000112ae	mulsd	%xmm6, %xmm3
00000001000112b2	movq	%r12, %xmm5
00000001000112b7	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
00000001000112bb	subpd	%xmm2, %xmm5
00000001000112bf	movapd	%xmm5, %xmm2
00000001000112c3	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
00000001000112c7	addsd	%xmm5, %xmm2
00000001000112cb	mulsd	%xmm6, %xmm2
00000001000112cf	movsd	-0x50(%rbp), %xmm0
00000001000112d4	movsd	-0x38(%rbp), %xmm1
00000001000112d9	addsd	%xmm1, %xmm0
00000001000112dd	mulsd	%xmm6, %xmm1
00000001000112e1	mulsd	%xmm6, %xmm0
00000001000112e5	cmpl	$0x0, 0x3d10(%rip)
00000001000112ec	leaq	0x181d(%rip), %rax              ## literal pool for: " (collection off)"
00000001000112f3	leaq	0x868(%rip), %r9                ## literal pool for: ""
00000001000112fa	cmoveq	%rax, %r9
00000001000112fe	leaq	0x175c(%rip), %rsi              ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100011305	movq	%r15, %rdi
0000000100011308	movq	-0x30(%rbp), %rdx
000000010001130c	movq	%r14, %rcx
000000010001130f	movsd	-0x48(%rbp), %xmm5
0000000100011314	movsd	-0x40(%rbp), %xmm6
0000000100011319	movb	$0x7, %al
000000010001131b	callq	0x10001148a                     ## symbol stub for: _fprintf
0000000100011320	addq	$0xb8, %rsp
0000000100011327	popq	%rbx
0000000100011328	popq	%r12
000000010001132a	popq	%r13
000000010001132c	popq	%r14
000000010001132e	popq	%r15
0000000100011330	popq	%rbp
0000000100011331	retq
0000000100011332	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.1:
0000000100011340	pushq	%rbp
0000000100011341	movq	%rsp, %rbp
0000000100011344	pushq	$0x8
0000000100011346	popq	%rdi
0000000100011347	pushq	$0x2
0000000100011349	popq	%rsi
000000010001134a	callq	_fwp_gc_alloc_slow
000000010001134f	popq	%rbp
0000000100011350	retq
0000000100011351	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.2:
0000000100011360	pushq	%rbp
0000000100011361	movq	%rsp, %rbp
0000000100011364	pushq	$0x1
0000000100011366	popq	%rdi
0000000100011367	pushq	$0x1
0000000100011369	popq	%rsi
000000010001136a	callq	_fwp_gc_alloc_slow
000000010001136f	popq	%rbp
0000000100011370	retq
0000000100011371	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr.cold.1:
0000000100011380	pushq	%rbp
0000000100011381	movq	%rsp, %rbp
0000000100011384	pushq	%rbx
0000000100011385	pushq	%rax
0000000100011386	movq	%rdi, %rbx
0000000100011389	leaq	0x8e0(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100011390	callq	0x1000114ae                     ## symbol stub for: _getenv
0000000100011395	testq	%rax, %rax
0000000100011398	je	0x1000113b1
000000010001139a	movzbl	(%rax), %ecx
000000010001139d	testl	%ecx, %ecx
000000010001139f	je	0x1000113b8
00000001000113a1	cmpl	$0x30, %ecx
00000001000113a4	jne	0x1000113b5
00000001000113a6	xorl	%ecx, %ecx
00000001000113a8	cmpb	$0x0, 0x1(%rax)
00000001000113ac	setne	%cl
00000001000113af	jmp	0x1000113b8
00000001000113b1	xorl	%ecx, %ecx
00000001000113b3	jmp	0x1000113b8
00000001000113b5	pushq	$0x1
00000001000113b7	popq	%rcx
00000001000113b8	movl	%ecx, (%rbx)
00000001000113ba	movl	%ecx, _fwp_reuse_verify(%rip)
00000001000113c0	addq	$0x8, %rsp
00000001000113c4	popq	%rbx
00000001000113c5	popq	%rbp
00000001000113c6	retq
00000001000113c7	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
00000001000113d0	pushq	%rbp
00000001000113d1	movq	%rsp, %rbp
00000001000113d4	pushq	%rbx
00000001000113d5	pushq	%rax
00000001000113d6	movq	%rdi, %rbx
00000001000113d9	leaq	0x890(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
00000001000113e0	callq	0x1000114ae                     ## symbol stub for: _getenv
00000001000113e5	testq	%rax, %rax
00000001000113e8	je	0x100011401
00000001000113ea	movzbl	(%rax), %ecx
00000001000113ed	testl	%ecx, %ecx
00000001000113ef	je	0x100011408
00000001000113f1	cmpl	$0x30, %ecx
00000001000113f4	jne	0x100011405
00000001000113f6	xorl	%ecx, %ecx
00000001000113f8	cmpb	$0x0, 0x1(%rax)
00000001000113fc	setne	%cl
00000001000113ff	jmp	0x100011408
0000000100011401	xorl	%ecx, %ecx
0000000100011403	jmp	0x100011408
0000000100011405	pushq	$0x1
0000000100011407	popq	%rcx
0000000100011408	movl	%ecx, (%rbx)
000000010001140a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100011410	addq	$0x8, %rsp
0000000100011414	popq	%rbx
0000000100011415	popq	%rbp
0000000100011416	retq
