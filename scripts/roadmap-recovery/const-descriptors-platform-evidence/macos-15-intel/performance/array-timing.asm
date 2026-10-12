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
0000000100000731	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
0000000100000736	leaq	0x1143c(%rip), %rdi             ## literal pool for: "FWP_SEED"
000000010000073d	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100000742	testq	%rax, %rax
0000000100000745	je	0x10000076d
0000000100000747	movq	%rax, %rbx
000000010000074a	cmpb	$0x0, (%rax)
000000010000074d	je	0x10000076d
000000010000074f	leaq	-0x68(%rbp), %rsi
0000000100000753	movq	%rbx, %rdi
0000000100000756	movl	$0xa, %edx
000000010000075b	callq	0x1000112ca                     ## symbol stub for: _strtoull
0000000100000760	movq	-0x68(%rbp), %rax
0000000100000764	cmpb	$0x0, (%rax)
0000000100000767	je	0x10000083a
000000010000076d	leaq	-0x58(%rbp), %rsi
0000000100000771	xorl	%edi, %edi
0000000100000773	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
0000000100000778	movq	(%r14), %rdi
000000010000077b	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100000780	xorl	%esi, %esi
0000000100000782	xorl	%edx, %edx
0000000100000784	callq	0x100011276                     ## symbol stub for: _setvbuf
0000000100000789	movl	$0x1, %esi
000000010000078e	movl	$0xd, %edi
0000000100000793	callq	0x100011288                     ## symbol stub for: _signal
0000000100000798	leaq	-0x58(%rbp), %rbx
000000010000079c	movq	%rbx, %rdi
000000010000079f	callq	0x10001124c                     ## symbol stub for: _pthread_attr_init
00000001000007a4	movq	_fwp_main_stack(%rip), %rsi
00000001000007ab	movq	%rbx, %rdi
00000001000007ae	callq	0x100011252                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007b3	leaq	_fwp_main_thread(%rip), %rdx
00000001000007ba	leaq	-0x70(%rbp), %rdi
00000001000007be	movq	%rbx, %rsi
00000001000007c1	xorl	%ecx, %ecx
00000001000007c3	callq	0x100011258                     ## symbol stub for: _pthread_create
00000001000007c8	testl	%eax, %eax
00000001000007ca	je	0x100000808
00000001000007cc	leaq	-0x68(%rbp), %rsi
00000001000007d0	movl	$0x3, %edi
00000001000007d5	callq	0x100011204                     ## symbol stub for: _getrlimit
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
000000010000080e	callq	0x10001125e                     ## symbol stub for: _pthread_join
0000000100000813	movq	(%r14), %rdi
0000000100000816	callq	0x1000111ce                     ## symbol stub for: _fflush
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
0000000100000854	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
00000001000008d2	callq	0x100011282                     ## symbol stub for: _sigaltstack
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
000000010000090b	callq	0x10001127c                     ## symbol stub for: _sigaction
0000000100000910	movl	$0xa, %edi
0000000100000915	movq	%rbx, %rsi
0000000100000918	xorl	%edx, %edx
000000010000091a	callq	0x10001127c                     ## symbol stub for: _sigaction
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
0000000100000959	leaq	0x11b7b(%rip), %rsi             ## literal pool for: "--man"
0000000100000960	movq	%rbx, %rdi
0000000100000963	callq	0x1000112a0                     ## symbol stub for: _strcmp
0000000100000968	testl	%eax, %eax
000000010000096a	je	0x100000a0f
0000000100000970	leaq	0x11b6a(%rip), %rsi             ## literal pool for: "--completions"
0000000100000977	movl	$0xd, %edx
000000010000097c	movq	%rbx, %rdi
000000010000097f	callq	0x1000112ac                     ## symbol stub for: _strncmp
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
0000000100000a20	callq	0x1000111e6                     ## symbol stub for: _fputs
0000000100000a25	xorl	%r13d, %r13d
0000000100000a28	jmp	0x100001643
0000000100000a2d	leaq	(%rdx,%rsi), %rcx
0000000100000a31	movq	%rcx, 0x8(%rax)
0000000100000a35	movq	%rdx, -0x168(%rbp)
0000000100000a3c	movq	%rdx, %rdi
0000000100000a3f	callq	0x10001116e                     ## symbol stub for: ___bzero
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
0000000100000a7c	callq	0x1000112a6                     ## symbol stub for: _strlen
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
0000000100000b02	callq	0x10001116e                     ## symbol stub for: ___bzero
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
0000000100000be0	callq	0x10001116e                     ## symbol stub for: ___bzero
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
0000000100000cc2	callq	0x10001121c                     ## symbol stub for: _memchr
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
0000000100000d44	leaq	0x119a7(%rip), %rdi             ## literal pool for: "usage: reduce64 <Array[F64]>\n\narguments:\n  <Array[F64]>  or one per line of standard input\n\noptions:\n  -h, --help  show this help\n"
0000000100000d4b	callq	0x1000111e6                     ## symbol stub for: _fputs
0000000100000d50	movq	(%rbx), %rdi
0000000100000d53	callq	0x1000111ce                     ## symbol stub for: _fflush
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
0000000100000e9d	callq	0x10001116e                     ## symbol stub for: ___bzero
0000000100000ea2	cmpl	$0x1, %r13d
0000000100000ea6	jbe	0x100000dd1
0000000100000eac	movq	0x12185(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000eb3	movq	(%rax), %rdi
0000000100000eb6	leaq	0x116da(%rip), %rsi             ## literal pool for: "%s\n"
0000000100000ebd	leaq	0x117d2(%rip), %rdx             ## literal pool for: "usage: reduce64 <Array[F64]>\n  (the last argument may instead be given as records on stdin)"
0000000100000ec4	xorl	%eax, %eax
0000000100000ec6	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100000ecb	jmp	0x100000f89
0000000100000ed0	cmpq	%rax, %rcx
0000000100000ed3	jne	0x100000f4d
0000000100000ed5	leaq	0x1150c(%rip), %rdi             ## literal pool for: "FWP_OUT"
0000000100000edc	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100000ee1	testq	%rax, %rax
0000000100000ee4	je	0x100000f94
0000000100000eea	leaq	0x114ff(%rip), %rsi             ## literal pool for: "bin"
0000000100000ef1	movq	%rax, %rdi
0000000100000ef4	callq	0x1000112a0                     ## symbol stub for: _strcmp
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
0000000100000f3e	callq	0x1000111f8                     ## symbol stub for: _fwrite
0000000100000f43	movq	(%r14), %rdi
0000000100000f46	callq	0x1000111ce                     ## symbol stub for: _fflush
0000000100000f4b	jmp	0x100000faf
0000000100000f4d	leaq	0x11821(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100000f54	movl	%r15d, %esi
0000000100000f57	movq	%r14, %rdx
0000000100000f5a	xorl	%eax, %eax
0000000100000f5c	callq	_fwp_strf
0000000100000f61	movq	0x120d0(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100000f68	movq	(%rcx), %rdi
0000000100000f6b	leaq	0x8(%rax), %r8
0000000100000f6f	leaq	0x1167d(%rip), %rsi             ## literal pool for: "%s: argument %d: %s\n"
0000000100000f76	leaq	0x10939(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000f7d	movl	$0x1, %ecx
0000000100000f82	xorl	%eax, %eax
0000000100000f84	callq	0x1000111da                     ## symbol stub for: _fprintf
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
0000000100000fd7	callq	0x1000111ce                     ## symbol stub for: _fflush
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
0000000100001013	callq	0x100011276                     ## symbol stub for: _setvbuf
0000000100001018	movq	(%r13), %rcx
000000010000101c	leaq	_fwp_in_pend(%rip), %r12
0000000100001023	movl	$0x1, %esi
0000000100001028	movl	$0x4, %edx
000000010000102d	movq	%r12, %rdi
0000000100001030	callq	0x1000111ec                     ## symbol stub for: _fread
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
0000000100001124	callq	0x1000111d4                     ## symbol stub for: _fgetc
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
0000000100001186	callq	0x1000111d4                     ## symbol stub for: _fgetc
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
00000001000011d2	callq	0x1000111ec                     ## symbol stub for: _fread
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
000000010000121d	callq	0x100011228                     ## symbol stub for: _memcpy
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
000000010000125b	callq	0x1000111ec                     ## symbol stub for: _fread
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
0000000100001323	leaq	0x10588(%rip), %rax             ## literal pool for: ""
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
000000010000140e	callq	0x10001116e                     ## symbol stub for: ___bzero
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
000000010000150b	callq	0x1000111ec                     ## symbol stub for: _fread
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
00000001000015a4	callq	0x1000111ce                     ## symbol stub for: _fflush
00000001000015a9	cmpl	$0x0, -0x174(%rbp)
00000001000015b0	jne	0x100001af3
00000001000015b6	movq	%r14, %rdi
00000001000015b9	callq	_fwp_emit_result
00000001000015be	movq	0x11a83(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000015c5	movq	(%rax), %rdi
00000001000015c8	callq	0x1000111ce                     ## symbol stub for: _fflush
00000001000015cd	jmp	0x100001079
00000001000015d2	leaq	0x10e77(%rip), %rsi             ## literal pool for: "%s: truncated frame\n"
00000001000015d9	movq	0x11a58(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000015e0	movq	(%rax), %rdi
00000001000015e3	leaq	0x102cc(%rip), %rdx             ## literal pool for: "reduce64"
00000001000015ea	xorl	%eax, %eax
00000001000015ec	callq	0x1000111da                     ## symbol stub for: _fprintf
00000001000015f1	movl	$0x3, %r13d
00000001000015f7	movq	-0x150(%rbp), %rdi
00000001000015fe	callq	0x1000111f2                     ## symbol stub for: _free
0000000100001603	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000160a	je	0x100001634
000000010000160c	movq	0x11a35(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100001613	movq	(%rbx), %rcx
0000000100001616	leaq	_fwp_exec.end(%rip), %rdi
000000010000161d	movl	$0x1, %esi
0000000100001622	movl	$0x5, %edx
0000000100001627	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000162c	movq	(%rbx), %rdi
000000010000162f	callq	0x1000111ce                     ## symbol stub for: _fflush
0000000100001634	movq	0x11a0d(%rip), %rax             ## literal pool symbol address: ___stdoutp
000000010000163b	movq	(%rax), %rdi
000000010000163e	callq	0x1000111ce                     ## symbol stub for: _fflush
0000000100001643	movl	%r13d, _fwp_exit_code(%rip)
000000010000164a	movq	0x119f7(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001651	movq	(%rax), %rdi
0000000100001654	callq	0x1000111ce                     ## symbol stub for: _fflush
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
0000000100001691	leaq	0x10e57(%rip), %rsi             ## literal pool for: "%s: option `--completions` needs a value (bash, zsh or fish)\n"
0000000100001698	leaq	0x10217(%rip), %rdx             ## literal pool for: "reduce64"
000000010000169f	jmp	0x100000ec4
00000001000016a4	movq	0x10(%r13), %rbx
00000001000016a8	leaq	0x10e7e(%rip), %rsi             ## literal pool for: "bash"
00000001000016af	movq	%rbx, %rdi
00000001000016b2	callq	0x1000112a0                     ## symbol stub for: _strcmp
00000001000016b7	xorl	%r13d, %r13d
00000001000016ba	testl	%eax, %eax
00000001000016bc	je	0x100001727
00000001000016be	leaq	0x10e6d(%rip), %rsi             ## literal pool for: "zsh"
00000001000016c5	movq	%rbx, %rdi
00000001000016c8	callq	0x1000112a0                     ## symbol stub for: _strcmp
00000001000016cd	testl	%eax, %eax
00000001000016cf	je	0x100001a97
00000001000016d5	leaq	0x10e5a(%rip), %rsi             ## literal pool for: "fish"
00000001000016dc	movq	%rbx, %rdi
00000001000016df	callq	0x1000112a0                     ## symbol stub for: _strcmp
00000001000016e4	testl	%eax, %eax
00000001000016e6	je	0x100001a9e
00000001000016ec	movq	%rbx, %rdi
00000001000016ef	callq	0x1000112a6                     ## symbol stub for: _strlen
00000001000016f4	movq	%rbx, %rdi
00000001000016f7	movq	%rax, %rsi
00000001000016fa	callq	_fwp_str_lossy
00000001000016ff	movq	0x11932(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100001706	movq	(%rcx), %rdi
0000000100001709	leaq	0x8(%rax), %rcx
000000010000170d	leaq	0x10e27(%rip), %rsi             ## literal pool for: "%s: unknown shell `%s` (bash, zsh or fish)\n"
0000000100001714	leaq	0x1019b(%rip), %rdx             ## literal pool for: "reduce64"
000000010000171b	xorl	%eax, %eax
000000010000171d	callq	0x1000111da                     ## symbol stub for: _fprintf
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
000000010000176e	callq	0x1000111ec                     ## symbol stub for: _fread
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
0000000100001804	callq	0x1000111ec                     ## symbol stub for: _fread
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
00000001000018b6	callq	0x100011228                     ## symbol stub for: _memcpy
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
0000000100001928	callq	0x100011228                     ## symbol stub for: _memcpy
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
000000010000195e	callq	0x1000111ec                     ## symbol stub for: _fread
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
0000000100001995	callq	0x1000111ec                     ## symbol stub for: _fread
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
0000000100001a50	pxor	0xf898(%rip), %xmm0
0000000100001a58	ptest	%xmm0, %xmm0
0000000100001a5d	je	0x100001b9c
0000000100001a63	movq	0x115ce(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001a6a	movq	(%rax), %rdi
0000000100001a6d	leaq	0x109aa(%rip), %rsi             ## literal pool for: "%s: input type mismatch: expected `%s`, got `%s`\n"
0000000100001a74	leaq	0xfe3b(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001a7b	leaq	0x10cf3(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100001a82	movq	%r14, %r8
0000000100001a85	xorl	%eax, %eax
0000000100001a87	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100001a8c	movl	$0x3, %r13d
0000000100001a92	jmp	0x100001643
0000000100001a97	movl	$0x1, %eax
0000000100001a9c	jmp	0x100001aa3
0000000100001a9e	movl	$0x2, %eax
0000000100001aa3	leaq	_fwp_cli_scripts(%rip), %rcx
0000000100001aaa	movq	(%rcx,%rax,8), %rdi
0000000100001aae	movq	0x11593(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001ab5	movq	(%rax), %rsi
0000000100001ab8	callq	0x1000111e6                     ## symbol stub for: _fputs
0000000100001abd	jmp	0x100001643
0000000100001ac2	movq	0x1156f(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001ac9	movq	(%rax), %rdi
0000000100001acc	movl	(%r15), %ecx
0000000100001acf	leaq	0x109ba(%rip), %rsi             ## literal pool for: "%s: cannot parse input `%.*s` as %s\n"
0000000100001ad6	leaq	0xfdd9(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001add	leaq	0x10c91(%rip), %r9              ## literal pool for: "Array[F64]"
0000000100001ae4	movq	%r14, %r8
0000000100001ae7	xorl	%eax, %eax
0000000100001ae9	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100001aee	jmp	0x1000015f1
0000000100001af3	movl	$0x1, %r13d
0000000100001af9	jmp	0x1000015f7
0000000100001afe	xorl	%r13d, %r13d
0000000100001b01	jmp	0x1000015f7
0000000100001b06	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100001b0b	jmp	0x100001b31
0000000100001b0d	leaq	0x10951(%rip), %rsi             ## literal pool for: "%s: bad switch frame\n"
0000000100001b14	jmp	0x1000015d9
0000000100001b19	movq	0x11518(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b20	movq	(%rax), %rdi
0000000100001b23	leaq	0x10951(%rip), %rsi             ## literal pool for: "%s: malformed value\n"
0000000100001b2a	jmp	0x1000015e3
0000000100001b2f	xorl	%eax, %eax
0000000100001b31	testl	%eax, %eax
0000000100001b33	js	0x100001b5f
0000000100001b35	movq	0x114fc(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b3c	movq	(%rax), %rdi
0000000100001b3f	leaq	0x1097f(%rip), %rsi             ## literal pool for: "%s: truncated header\n"
0000000100001b46	leaq	0xfd69(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001b4d	xorl	%eax, %eax
0000000100001b4f	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100001b54	movl	$0x3, %r13d
0000000100001b5a	jmp	0x100001643
0000000100001b5f	movq	0x114d2(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b66	movq	(%rax), %rdi
0000000100001b69	leaq	0x10945(%rip), %rsi             ## literal pool for: "%s: bad header\n"
0000000100001b70	jmp	0x100001b46
0000000100001b72	movq	0x114bf(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b79	movq	(%rax), %rdi
0000000100001b7c	leaq	0x10876(%rip), %rsi             ## literal pool for: "%s: unsupported protocol version %d\n"
0000000100001b83	leaq	0xfd2c(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001b8a	xorl	%eax, %eax
0000000100001b8c	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100001b91	movl	$0x3, %r13d
0000000100001b97	jmp	0x100001643
0000000100001b9c	movl	$0x0, -0x170(%rbp)
0000000100001ba6	jmp	0x100001062
0000000100001bab	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
0000000100001c18	leaq	0xfb11(%rip), %rdi              ## literal pool for: "{\"samples\":["
0000000100001c1f	callq	0x100011264                     ## symbol stub for: _puts
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
0000000100001c77	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
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
0000000100001cd6	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
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
0000000100001e0e	mulsd	0xf63a(%rip), %xmm0
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
0000000100001e45	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
0000000100001e4a	movdqa	-0x50(%rbp), %xmm0
0000000100001e4f	movdqa	%xmm0, -0xa0(%rbp)
0000000100001e57	pxor	%xmm0, %xmm0
0000000100001e5b	movq	%xmm0, -0x58(%rbp)
0000000100001e60	movsd	0xf5f0(%rip), %xmm2
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
0000000100001ecf	mulsd	0xf589(%rip), %xmm1
0000000100001ed7	addsd	0xf589(%rip), %xmm1
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
0000000100001f0b	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
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
0000000100001f69	leaq	0xf93f(%rip), %rsi              ## literal pool for: ",\n"
0000000100001f70	leaq	0xf93b(%rip), %rax              ## literal pool for: ""
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
0000000100001fc7	leaq	0xf7ab(%rip), %rdi              ## literal pool for: "%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%ld,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"collections\":%zu,\"collectionPauseSeconds\":%.9f,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}"
0000000100001fce	movq	%r12, %r8
0000000100001fd1	xorl	%r9d, %r9d
0000000100001fd4	movb	$0x1, %al
0000000100001fd6	callq	0x100011246                     ## symbol stub for: _printf
0000000100001fdb	incq	%rbx
0000000100001fde	cmpq	$0x5, %rbx
0000000100001fe2	jne	0x100001c40
0000000100001fe8	leaq	0xf8c4(%rip), %rdi              ## literal pool for: "]}"
0000000100001fef	callq	0x100011264                     ## symbol stub for: _puts
0000000100001ff4	xorl	%eax, %eax
0000000100001ff6	jmp	0x100002018
0000000100001ff8	subq	%rax, %rcx
0000000100001ffb	movq	0x11036(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002002	movq	(%rax), %rdi
0000000100002005	leaq	0xf731(%rip), %rsi              ## literal pool for: "unexpected collection or retained charged storage: %zu %ld\n"
000000010000200c	xorl	%eax, %eax
000000010000200e	callq	0x1000111da                     ## symbol stub for: _fprintf
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
0000000100002056	callq	0x10001119e                     ## symbol stub for: __dyld_image_count
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
0000000100002082	callq	0x10001119e                     ## symbol stub for: __dyld_image_count
0000000100002087	cmpl	%eax, %ebx
0000000100002089	jae	0x100002164
000000010000208f	movl	%ebx, %edi
0000000100002091	callq	0x100011192                     ## symbol stub for: __dyld_get_image_header
0000000100002096	testq	%rax, %rax
0000000100002099	je	0x100002080
000000010000209b	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
00000001000020a1	jne	0x100002080
00000001000020a3	movl	%ebx, %edi
00000001000020a5	movq	%rax, %r12
00000001000020a8	callq	0x100011198                     ## symbol stub for: __dyld_get_image_vmaddr_slide
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
0000000100002193	callq	0x1000111b0                     ## symbol stub for: _atexit
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
0000000100002201	leaq	0xf787(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002208	leaq	0x10571(%rip), %rdx             ## literal pool for: "too many program data segments for the collector"
000000010000220f	xorl	%eax, %eax
0000000100002211	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100002216	movl	$0x65, %edi
000000010000221b	callq	0x1000111c8                     ## symbol stub for: _exit
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
0000000100002258	leaq	0xf421(%rip), %rcx
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
0000000100002391	callq	0x10001116e                     ## symbol stub for: ___bzero
0000000100002396	movq	%rbx, (%r14)
0000000100002399	movq	%r14, %rax
000000010000239c	popq	%rbx
000000010000239d	popq	%r14
000000010000239f	popq	%rbp
00000001000023a0	retq
00000001000023a1	callq	_fwp_flush
00000001000023a6	movq	0x10c8b(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000023ad	movq	(%rax), %rdi
00000001000023b0	leaq	0xf5d8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000023b7	leaq	0x104b4(%rip), %rdx             ## literal pool for: "array too large"
00000001000023be	xorl	%eax, %eax
00000001000023c0	callq	0x1000111da                     ## symbol stub for: _fprintf
00000001000023c5	movl	$0x65, %edi
00000001000023ca	callq	0x1000111c8                     ## symbol stub for: _exit
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
0000000100002429	leaq	0xf55f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002430	leaq	0x1044b(%rip), %rdx             ## literal pool for: "internal: mutating an array view"
0000000100002437	xorl	%eax, %eax
0000000100002439	callq	0x1000111da                     ## symbol stub for: _fprintf
000000010000243e	movl	$0x65, %edi
0000000100002443	callq	0x1000111c8                     ## symbol stub for: _exit
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
0000000100002478	movsd	0xefd8(%rip), %xmm2
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
00000001000024eb	mulsd	0xef6d(%rip), %xmm1
00000001000024f3	addsd	0xef6d(%rip), %xmm1
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
00000001000025a9	mulss	0xeeef(%rip), %xmm0
00000001000025b1	addss	0xeeeb(%rip), %xmm0
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
000000010000274d	leaq	0xf252(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002754	leaq	0xf278(%rip), %rcx              ## literal pool for: "I8"
000000010000275b	jmp	0x10000276b
000000010000275d	leaq	0xf242(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002764	leaq	0xf237(%rip), %rcx              ## literal pool for: "I64"
000000010000276b	leaq	-0x90(%rbp), %rbx
0000000100002772	movl	$0x60, %esi
0000000100002777	movq	%rbx, %rdi
000000010000277a	xorl	%eax, %eax
000000010000277c	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100002781	callq	_fwp_flush
0000000100002786	movq	0x108ab(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000278d	movq	(%rax), %rdi
0000000100002790	leaq	0xf1f8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002797	movq	%rbx, %rdx
000000010000279a	xorl	%eax, %eax
000000010000279c	callq	0x1000111da                     ## symbol stub for: _fprintf
00000001000027a1	movl	$0x65, %edi
00000001000027a6	callq	0x1000111c8                     ## symbol stub for: _exit
00000001000027ab	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
0000000100002918	leaq	0xf087(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000291f	leaq	0xf0ad(%rip), %rcx              ## literal pool for: "I8"
0000000100002926	leaq	-0x90(%rbp), %rbx
000000010000292d	movl	$0x60, %esi
0000000100002932	movq	%rbx, %rdi
0000000100002935	xorl	%eax, %eax
0000000100002937	callq	0x10001128e                     ## symbol stub for: _snprintf
000000010000293c	callq	_fwp_flush
0000000100002941	movq	0x106f0(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002948	movq	(%rax), %rdi
000000010000294b	leaq	0xf03d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002952	movq	%rbx, %rdx
0000000100002955	xorl	%eax, %eax
0000000100002957	callq	0x1000111da                     ## symbol stub for: _fprintf
000000010000295c	movl	$0x65, %edi
0000000100002961	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100002966	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
00000001000029b9	leaq	0xefe6(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000029c0	leaq	0xf00c(%rip), %rcx              ## literal pool for: "I8"
00000001000029c7	leaq	-0x70(%rbp), %rbx
00000001000029cb	movl	$0x60, %esi
00000001000029d0	movq	%rbx, %rdi
00000001000029d3	xorl	%eax, %eax
00000001000029d5	callq	0x10001128e                     ## symbol stub for: _snprintf
00000001000029da	callq	_fwp_flush
00000001000029df	movq	0x10652(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000029e6	movq	(%rax), %rdi
00000001000029e9	leaq	0xef9f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000029f0	movq	%rbx, %rdx
00000001000029f3	xorl	%eax, %eax
00000001000029f5	callq	0x1000111da                     ## symbol stub for: _fprintf
00000001000029fa	movl	$0x65, %edi
00000001000029ff	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100002a04	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
0000000100002b52	leaq	0xee4d(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002b59	leaq	0xee42(%rip), %rcx              ## literal pool for: "I64"
0000000100002b60	leaq	-0x70(%rbp), %rbx
0000000100002b64	movl	$0x60, %esi
0000000100002b69	movq	%rbx, %rdi
0000000100002b6c	xorl	%eax, %eax
0000000100002b6e	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100002b73	callq	_fwp_flush
0000000100002b78	movq	0x104b9(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002b7f	movq	(%rax), %rdi
0000000100002b82	leaq	0xee06(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002b89	movq	%rbx, %rdx
0000000100002b8c	xorl	%eax, %eax
0000000100002b8e	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100002b93	movl	$0x65, %edi
0000000100002b98	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100002b9d	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
0000000100002c01	leaq	_fwp_drop1(%rip), %rdx
0000000100002c08	callq	_fwp_p_loop_own
0000000100002c0d	movq	%rax, %rbx
0000000100002c10	movq	%rax, %rdi
0000000100002c13	callq	_fwp_rc_share
0000000100002c18	movq	%rbx, %rax
0000000100002c1b	addq	$0x8, %rsp
0000000100002c1f	popq	%rbx
0000000100002c20	popq	%rbp
0000000100002c21	retq
0000000100002c22	nopw	%cs:(%rax,%rax)
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
0000000100002cc1	leaq	_fwp_drop3(%rip), %rdx
0000000100002cc8	callq	_fwp_p_loop_own
0000000100002ccd	movq	%rax, %rbx
0000000100002cd0	movq	%rax, %rdi
0000000100002cd3	callq	_fwp_rc_share
0000000100002cd8	movq	%rbx, %rax
0000000100002cdb	addq	$0x8, %rsp
0000000100002cdf	popq	%rbx
0000000100002ce0	popq	%rbp
0000000100002ce1	retq
0000000100002ce2	nopw	%cs:(%rax,%rax)
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
0000000100002d81	leaq	_fwp_drop5(%rip), %rdx
0000000100002d88	callq	_fwp_p_loop_own
0000000100002d8d	movq	%rax, %rbx
0000000100002d90	movq	%rax, %rdi
0000000100002d93	callq	_fwp_rc_share
0000000100002d98	movq	%rbx, %rax
0000000100002d9b	addq	$0x8, %rsp
0000000100002d9f	popq	%rbx
0000000100002da0	popq	%rbp
0000000100002da1	retq
0000000100002da2	nopw	%cs:(%rax,%rax)
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
0000000100002e01	leaq	_fwp_drop6(%rip), %rdx
0000000100002e08	callq	_fwp_p_loop_own
0000000100002e0d	movq	%rax, %rbx
0000000100002e10	movq	%rax, %rdi
0000000100002e13	callq	_fwp_rc_share
0000000100002e18	movq	%rbx, %rax
0000000100002e1b	addq	$0x8, %rsp
0000000100002e1f	popq	%rbx
0000000100002e20	popq	%rbp
0000000100002e21	retq
0000000100002e22	nopw	%cs:(%rax,%rax)
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
0000000100003089	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
00000001000030fc	callq	0x1000111f2                     ## symbol stub for: _free
0000000100003101	decq	0x12918(%rip)
0000000100003108	popq	%rbp
0000000100003109	retq
000000010000310a	callq	_fwp_flush
000000010000310f	movq	0xff22(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003116	movq	(%rax), %rdi
0000000100003119	leaq	0xe86f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003120	leaq	0xe841(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100003127	xorl	%eax, %eax
0000000100003129	callq	0x1000111da                     ## symbol stub for: _fprintf
000000010000312e	movl	$0x65, %edi
0000000100003133	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100003138	nopl	(%rax,%rax)
_fwp_flush:
0000000100003140	pushq	%rbp
0000000100003141	movq	%rsp, %rbp
0000000100003144	movq	_fwp_prog_out(%rip), %rdi
000000010000314b	testq	%rdi, %rdi
000000010000314e	je	0x100003155
0000000100003150	callq	0x1000111ce                     ## symbol stub for: _fflush
0000000100003155	movq	0xfeec(%rip), %rax              ## literal pool symbol address: ___stdoutp
000000010000315c	movq	(%rax), %rdi
000000010000315f	popq	%rbp
0000000100003160	jmp	0x1000111ce                     ## symbol stub for: _fflush
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
000000010000339d	leaq	0xe5eb(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000033a4	leaq	0xe5bd(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000033ab	xorl	%eax, %eax
00000001000033ad	callq	0x1000111da                     ## symbol stub for: _fprintf
00000001000033b2	movl	$0x65, %edi
00000001000033b7	callq	0x1000111c8                     ## symbol stub for: _exit
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
00000001000034d8	callq	0x10001116e                     ## symbol stub for: ___bzero
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
000000010000369d	leaq	0xe034(%rip), %rax
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
00000001000039e5	callq	0x10001116e                     ## symbol stub for: ___bzero
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
0000000100003ae8	callq	0x10001116e                     ## symbol stub for: ___bzero
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
0000000100003b11	movaps	0xd7e8(%rip), %xmm0
0000000100003b18	movups	%xmm0, 0x11031(%rip)
0000000100003b1f	movaps	0xd7ea(%rip), %xmm0
0000000100003b26	movups	%xmm0, 0x11033(%rip)
0000000100003b2d	movaps	0xd7ec(%rip), %xmm0
0000000100003b34	movups	%xmm0, 0x11035(%rip)
0000000100003b3b	movaps	0xd7ee(%rip), %xmm0
0000000100003b42	movups	%xmm0, 0x11037(%rip)
0000000100003b49	movaps	0xd7f0(%rip), %xmm0
0000000100003b50	movups	%xmm0, 0x11039(%rip)
0000000100003b57	movaps	0xd7f2(%rip), %xmm0
0000000100003b5e	movups	%xmm0, 0x1103b(%rip)
0000000100003b65	movaps	0xd7f4(%rip), %xmm0
0000000100003b6c	movups	%xmm0, 0x1103d(%rip)
0000000100003b73	movaps	0xd7f6(%rip), %xmm0
0000000100003b7a	movups	%xmm0, 0x1103f(%rip)
0000000100003b81	movaps	0xd7f8(%rip), %xmm0
0000000100003b88	movups	%xmm0, 0x11041(%rip)
0000000100003b8f	movaps	0xd7fa(%rip), %xmm0
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
0000000100003c30	callq	0x10001123a                     ## symbol stub for: _mmap
0000000100003c35	cmpq	$-0x1, %rax
0000000100003c39	jne	0x100003c9b
0000000100003c3b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100003c45	leaq	0x10000(%rbx), %rsi
0000000100003c4c	xorl	%edi, %edi
0000000100003c4e	xorl	%edx, %edx
0000000100003c50	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c55	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c5b	xorl	%r9d, %r9d
0000000100003c5e	callq	0x10001123a                     ## symbol stub for: _mmap
0000000100003c63	cmpq	$-0x1, %rax
0000000100003c67	jne	0x100003c9b
0000000100003c69	movabsq	$__mh_execute_header, %rbx
0000000100003c73	leaq	0x10000(%rbx), %rsi
0000000100003c7a	xorl	%edi, %edi
0000000100003c7c	xorl	%edx, %edx
0000000100003c7e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c83	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c89	xorl	%r9d, %r9d
0000000100003c8c	callq	0x10001123a                     ## symbol stub for: _mmap
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
0000000100003cfa	callq	0x10001123a                     ## symbol stub for: _mmap
0000000100003cff	cmpq	$-0x1, %rax
0000000100003d03	je	0x100003eae
0000000100003d09	movq	%rax, 0x11370(%rip)
0000000100003d10	leaq	0xdcbf(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003d17	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100003d1c	movl	$0x1, %r14d
0000000100003d22	testq	%rax, %rax
0000000100003d25	je	0x100003d52
0000000100003d27	movq	%rax, %rbx
0000000100003d2a	leaq	0xdcac(%rip), %rsi              ## literal pool for: "off"
0000000100003d31	movq	%rax, %rdi
0000000100003d34	callq	0x1000112a0                     ## symbol stub for: _strcmp
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
0000000100003d59	leaq	0xdc81(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100003d60	callq	0x1000111fe                     ## symbol stub for: _getenv
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
0000000100003d90	leaq	0xdc3f(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003d97	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100003d9c	testq	%rax, %rax
0000000100003d9f	je	0x100003db9
0000000100003da1	leaq	0xdc46(%rip), %rsi              ## literal pool for: "full"
0000000100003da8	movq	%rax, %rdi
0000000100003dab	callq	0x1000112a0                     ## symbol stub for: _strcmp
0000000100003db0	xorl	%ecx, %ecx
0000000100003db2	testl	%eax, %eax
0000000100003db4	setne	%cl
0000000100003db7	jmp	0x100003dbe
0000000100003db9	movl	$0x1, %ecx
0000000100003dbe	movl	%ecx, 0x11244(%rip)
0000000100003dc4	movl	$0x1, 0x11242(%rip)
0000000100003dce	leaq	0xdc1e(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
0000000100003dd5	callq	0x1000111fe                     ## symbol stub for: _getenv
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
0000000100003e05	leaq	0xdbf5(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
0000000100003e0c	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100003e11	testq	%rax, %rax
0000000100003e14	je	0x100003e20
0000000100003e16	movq	%rax, %rdi
0000000100003e19	callq	0x1000111bc                     ## symbol stub for: _atol
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
0000000100003e64	callq	0x10001123a                     ## symbol stub for: _mmap
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
0000000100003e95	callq	0x10001123a                     ## symbol stub for: _mmap
0000000100003e9a	leaq	0x1(%rax), %rcx
0000000100003e9e	cmpq	$0x2, %rcx
0000000100003ea2	jb	0x100003eae
0000000100003ea4	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100003ea9	jmp	0x100003ca4
0000000100003eae	movq	0xf183(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003eb5	movq	(%rax), %rcx
0000000100003eb8	leaq	0xdb50(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100003ebf	movl	$0x13, %esi
0000000100003ec4	movl	$0x1, %edx
0000000100003ec9	callq	0x1000111f8                     ## symbol stub for: _fwrite
0000000100003ece	movl	$0x66, %edi
0000000100003ed3	callq	0x1000111c8                     ## symbol stub for: _exit
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
000000010000407d	callq	0x10001116e                     ## symbol stub for: ___bzero
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
00000001000040b1	leaq	0xd957(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000040b8	movl	$0x13, %esi
00000001000040bd	movl	$0x1, %edx
00000001000040c2	callq	0x1000111f8                     ## symbol stub for: _fwrite
00000001000040c7	movl	$0x66, %edi
00000001000040cc	callq	0x1000111c8                     ## symbol stub for: _exit
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
000000010000428a	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000428f	shlq	$0x10, %r14
0000000100004293	addq	0x10d9e(%rip), %r14
000000010000429a	cmpl	$0x0, 0x10d6b(%rip)
00000001000042a1	je	0x1000042b0
00000001000042a3	movl	$0x10000, %esi                  ## imm = 0x10000
00000001000042a8	movq	%r14, %rdi
00000001000042ab	callq	0x10001116e                     ## symbol stub for: ___bzero
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
00000001000043d7	callq	0x100011240                     ## symbol stub for: _mprotect
00000001000043dc	testl	%eax, %eax
00000001000043de	jne	0x10000445a
00000001000043e0	movl	$0x1d, %edi
00000001000043e5	callq	0x1000112d0                     ## symbol stub for: _sysconf
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
0000000100004421	callq	0x100011240                     ## symbol stub for: _mprotect
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
0000000100004464	leaq	0xd5a4(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000446b	movl	$0x13, %esi
0000000100004470	movl	$0x1, %edx
0000000100004475	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000447a	movl	$0x66, %edi
000000010000447f	callq	0x1000111c8                     ## symbol stub for: _exit
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
00000001000044d5	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
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
0000000100004596	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000459b	movq	0x10ade(%rip), %rax
00000001000045a2	movq	0x10ab7(%rip), %rcx
00000001000045a9	jmp	0x100004556
00000001000045ab	movb	%r15b, -0xd1(%rbp)
00000001000045b2	leaq	-0xd0(%rbp), %rdi
00000001000045b9	callq	0x100011270                     ## symbol stub for: _setjmp
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
00000001000046fd	callq	0x100011270                     ## symbol stub for: _setjmp
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
000000010000479a	callq	0x100011216                     ## symbol stub for: _malloc
000000010000479f	movq	%rax, %rbx
00000001000047a2	cmpq	$0x1, %r14
00000001000047a6	movq	%r14, %rdi
00000001000047a9	adcq	$0x0, %rdi
00000001000047ad	movq	%rdi, -0x150(%rbp)
00000001000047b4	callq	0x100011216                     ## symbol stub for: _malloc
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
0000000100004820	callq	0x1000111f2                     ## symbol stub for: _free
0000000100004825	movq	%r12, %rdi
0000000100004828	callq	0x1000111f2                     ## symbol stub for: _free
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
0000000100004905	callq	0x1000111c2                     ## symbol stub for: _clock_gettime
000000010000490a	movq	-0x160(%rbp), %rax
0000000100004911	movq	-0x158(%rbp), %rcx
0000000100004918	subq	-0x170(%rbp), %rax
000000010000491f	cvtsi2sd	%rax, %xmm1
0000000100004924	mulsd	0xcb44(%rip), %xmm1
000000010000492c	subq	-0x168(%rbp), %rcx
0000000100004933	xorps	%xmm0, %xmm0
0000000100004936	cvtsi2sd	%rcx, %xmm0
000000010000493b	divsd	0xcb35(%rip), %xmm0
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
00000001000049e4	callq	0x100011228                     ## symbol stub for: _memcpy
00000001000049e9	movzbl	-0x124d(%r13), %eax
00000001000049f1	movb	%al, (%r12,%r15)
00000001000049f5	movq	%r14, %rdi
00000001000049f8	movq	%r13, %rsi
00000001000049fb	movq	%rbx, %rdx
00000001000049fe	callq	0x100011228                     ## symbol stub for: _memcpy
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
0000000100004a67	callq	0x100011228                     ## symbol stub for: _memcpy
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
0000000100004ad2	callq	0x10001116e                     ## symbol stub for: ___bzero
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
0000000100004bc9	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
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
0000000100004bfb	leaq	0xce21(%rip), %rsi              ## literal pool for: "fwp gc verify: a minor collection missed the reachable object at %p (kind %d, %zu bytes)\n"
0000000100004c02	xorl	%r14d, %r14d
0000000100004c05	movl	%r14d, %eax
0000000100004c08	movq	%r15, %rdx
0000000100004c0b	movq	%rbx, %r8
0000000100004c0e	movb	%r14b, -0xd2(%rbp)
0000000100004c15	callq	0x1000111da                     ## symbol stub for: _fprintf
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
0000000100004d8e	leaq	0xcce8(%rip), %rsi              ## literal pool for: "  from the old object at %p (kind %d, %u bytes), word %zu; its first words %lx %lx %lx\n"
0000000100004d95	movq	%rbx, %rdx
0000000100004d98	movq	%r14, %r9
0000000100004d9b	movzbl	-0xd2(%rbp), %eax
0000000100004da2	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100004da7	movl	0x8(%r12), %r8d
0000000100004dac	jmp	0x100004d40
0000000100004dae	callq	0x1000111aa                     ## symbol stub for: _abort
0000000100004db3	movq	0xe27e(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004dba	movq	(%rax), %rcx
0000000100004dbd	leaq	0xcc4b(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004dc4	movl	$0x13, %esi
0000000100004dc9	movl	$0x1, %edx
0000000100004dce	callq	0x1000111f8                     ## symbol stub for: _fwrite
0000000100004dd3	movl	$0x66, %edi
0000000100004dd8	callq	0x1000111c8                     ## symbol stub for: _exit
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
000000010000508d	callq	0x10001116e                     ## symbol stub for: ___bzero
0000000100005092	cmpq	$0x0, 0xffc6(%rip)
000000010000509a	je	0x100005554
00000001000050a0	movq	$0x0, -0x30(%rbp)
00000001000050a8	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
00000001000050b2	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000050bc	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000050c6	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000050d0	movdqa	0xc2c8(%rip), %xmm6
00000001000050d8	movdqa	0xc2d0(%rip), %xmm7
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
000000010000539e	callq	0x10001116e                     ## symbol stub for: ___bzero
00000001000053a3	pxor	%xmm8, %xmm8
00000001000053a8	movdqa	0xc000(%rip), %xmm7
00000001000053b0	movdqa	0xbfe8(%rip), %xmm6
00000001000053b8	jmp	0x100005350
00000001000053ba	movq	%rbx, %rdi
00000001000053bd	callq	_fwp_rc_forget_slot
00000001000053c2	pxor	%xmm8, %xmm8
00000001000053c7	movdqa	0xbfe1(%rip), %xmm7
00000001000053cf	movdqa	0xbfc9(%rip), %xmm6
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
000000010000542a	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000542f	movb	$0x0, (%r13)
0000000100005434	incq	%r15
0000000100005437	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005441	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
000000010000544b	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100005455	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
000000010000545f	movdqa	0xbf39(%rip), %xmm6
0000000100005467	movdqa	0xbf41(%rip), %xmm7
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
000000010000553f	movdqa	0xbe69(%rip), %xmm7
0000000100005547	movdqa	0xbe51(%rip), %xmm6
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
0000000100005671	callq	0x100011210                     ## symbol stub for: _madvise
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
0000000100005992	callq	0x10001126a                     ## symbol stub for: _realloc
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
00000001000059d3	leaq	0xc035(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000059da	movl	$0x13, %esi
00000001000059df	movl	$0x1, %edx
00000001000059e4	callq	0x1000111f8                     ## symbol stub for: _fwrite
00000001000059e9	movl	$0x66, %edi
00000001000059ee	callq	0x1000111c8                     ## symbol stub for: _exit
00000001000059f3	nopw	%cs:(%rax,%rax)
_f29:
0000000100005a00	pushq	%rbp
0000000100005a01	movq	%rsp, %rbp
0000000100005a04	pushq	%r15
0000000100005a06	pushq	%r14
0000000100005a08	pushq	%r13
0000000100005a0a	pushq	%r12
0000000100005a0c	pushq	%rbx
0000000100005a0d	subq	$0xd8, %rsp
0000000100005a14	movq	%rdi, %rbx
0000000100005a17	movq	0xd612(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005a1e	movq	(%rax), %rax
0000000100005a21	movq	%rax, -0x30(%rbp)
0000000100005a25	movq	%rdi, -0xa0(%rbp)
0000000100005a2c	movq	_fwp_cleanups(%rip), %rax
0000000100005a33	movq	%rax, -0x98(%rbp)
0000000100005a3a	leaq	_fwp_owner_release4(%rip), %rax
0000000100005a41	movq	%rax, -0x90(%rbp)
0000000100005a48	leaq	-0xa0(%rbp), %rax
0000000100005a4f	movq	%rax, -0x88(%rbp)
0000000100005a56	movq	$0x0, -0x80(%rbp)
0000000100005a5e	leaq	-0x98(%rbp), %r12
0000000100005a65	movq	%r12, -0xd0(%rbp)
0000000100005a6c	leaq	_fwp_owner_release5(%rip), %rax
0000000100005a73	movq	%rax, -0xc8(%rbp)
0000000100005a7a	leaq	-0x80(%rbp), %rax
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
0000000100005b0c	ja	0x100005f96
0000000100005b12	incb	%al
0000000100005b14	movb	%al, (%rdi)
0000000100005b16	movq	0x10(%rbx), %rdi
0000000100005b1a	movq	%rdi, -0x80(%rbp)
0000000100005b1e	movq	-0xd0(%rbp), %rax
0000000100005b25	movq	%rax, _fwp_cleanups(%rip)
0000000100005b2c	movq	0x8(%rbx), %r13
0000000100005b30	movsd	0x18(%rbx), %xmm0
0000000100005b35	testq	%r13, %r13
0000000100005b38	movsd	%xmm0, -0x70(%rbp)
0000000100005b3d	js	0x100005b66
0000000100005b3f	movq	(%rdi), %rax
0000000100005b42	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100005b4c	andq	%rax, %rcx
0000000100005b4f	cmpq	%r13, %rcx
0000000100005b52	jbe	0x100005b66
0000000100005b54	testq	%rax, %rax
0000000100005b57	js	0x100005c33
0000000100005b5d	leaq	0x8(%rdi), %rax
0000000100005b61	jmp	0x100005c37
0000000100005b66	callq	_fwp_drop0
0000000100005b6b	movsd	-0x70(%rbp), %xmm0
0000000100005b70	movsd	%xmm0, -0x48(%rbp)
0000000100005b75	movl	$0x10, %edi
0000000100005b7a	callq	_fwp_alloc_init
0000000100005b7f	movq	%rax, %r14
0000000100005b82	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100005b8c	movq	%rax, (%r14)
0000000100005b8f	movsd	-0x70(%rbp), %xmm0
0000000100005b94	movsd	%xmm0, 0x8(%r14)
0000000100005b9a	leaq	-0x48(%rbp), %rax
0000000100005b9e	movq	%r14, %rax
0000000100005ba1	subq	0xf490(%rip), %rax
0000000100005ba8	movq	0xf4b1(%rip), %rcx
0000000100005baf	shlq	$0x10, %rcx
0000000100005bb3	cmpq	%rcx, %rax
0000000100005bb6	jae	0x100005f52
0000000100005bbc	movq	0xf4bd(%rip), %rcx
0000000100005bc3	movq	%rax, %rdx
0000000100005bc6	shrq	$0x10, %rdx
0000000100005bca	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005bd1	leaq	(%rcx,%rdx), %r15
0000000100005bd5	movzbl	(%rcx,%rdx), %ecx
0000000100005bd9	cmpb	$0x2, %cl
0000000100005bdc	setne	%dl
0000000100005bdf	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005be5	setne	%sil
0000000100005be9	orb	%dl, %sil
0000000100005bec	jne	0x100005c04
0000000100005bee	addq	$0x228, %r15                    ## imm = 0x228
0000000100005bf5	cmpb	$-0x1, (%r15)
0000000100005bf9	je	0x100005c29
0000000100005bfb	movb	$0x1, (%r15)
0000000100005bff	jmp	0x100005f52
0000000100005c04	cmpb	$0x1, %cl
0000000100005c07	jne	0x100005f52
0000000100005c0d	movl	0x20(%r15), %ecx
0000000100005c11	imulq	%rcx, %rax
0000000100005c15	shrq	$0x20, %rax
0000000100005c19	addq	%rax, %r15
0000000100005c1c	addq	$0x228, %r15                    ## imm = 0x228
0000000100005c23	cmpb	$-0x1, (%r15)
0000000100005c27	jne	0x100005bfb
0000000100005c29	movq	%r15, %rdi
0000000100005c2c	callq	_fwp_rc_forget_slot
0000000100005c31	jmp	0x100005bfb
0000000100005c33	movq	0x10(%rdi), %rax
0000000100005c37	movsd	(%rax,%r13,8), %xmm0
0000000100005c3d	movq	_fwp_cleanups(%rip), %rax
0000000100005c44	movq	%rdi, -0xb8(%rbp)
0000000100005c4b	movq	%rax, -0x48(%rbp)
0000000100005c4f	leaq	_fwp_owner_release1(%rip), %rax
0000000100005c56	movq	%rax, -0x40(%rbp)
0000000100005c5a	leaq	-0xb8(%rbp), %rax
0000000100005c61	movq	%rax, -0x38(%rbp)
0000000100005c65	leaq	-0x48(%rbp), %r14
0000000100005c69	movq	%rdi, %rcx
0000000100005c6c	subq	0xf3c5(%rip), %rcx
0000000100005c73	movq	%r14, _fwp_cleanups(%rip)
0000000100005c7a	movq	0xf3df(%rip), %rax
0000000100005c81	shlq	$0x10, %rax
0000000100005c85	cmpq	%rax, %rcx
0000000100005c88	jae	0x100005cf3
0000000100005c8a	movq	0xf3ef(%rip), %rdx
0000000100005c91	movq	%rcx, %rax
0000000100005c94	shrq	$0x10, %rax
0000000100005c98	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100005c9f	leaq	(%rdx,%rsi), %rax
0000000100005ca3	movzbl	(%rdx,%rsi), %edx
0000000100005ca7	cmpb	$0x2, %dl
0000000100005caa	setne	%sil
0000000100005cae	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100005cb5	setne	%r8b
0000000100005cb9	orb	%sil, %r8b
0000000100005cbc	jne	0x100005cc6
0000000100005cbe	addq	$0x228, %rax                    ## imm = 0x228
0000000100005cc4	jmp	0x100005cdf
0000000100005cc6	cmpb	$0x1, %dl
0000000100005cc9	jne	0x100005cf3
0000000100005ccb	movl	0x20(%rax), %edx
0000000100005cce	imulq	%rdx, %rcx
0000000100005cd2	shrq	$0x20, %rcx
0000000100005cd6	addq	%rcx, %rax
0000000100005cd9	addq	$0x228, %rax                    ## imm = 0x228
0000000100005cdf	movzbl	(%rax), %ecx
0000000100005ce2	testb	%cl, %cl
0000000100005ce4	je	0x100005cf3
0000000100005ce6	cmpb	$-0x3, %cl
0000000100005ce9	ja	0x100005fb5
0000000100005cef	incb	%cl
0000000100005cf1	movb	%cl, (%rax)
0000000100005cf3	incq	%r13
0000000100005cf6	mulsd	0xb762(%rip), %xmm0
0000000100005cfe	addsd	0xb762(%rip), %xmm0
0000000100005d06	movsd	%xmm0, -0x78(%rbp)
0000000100005d0b	movq	-0x48(%rbp), %rax
0000000100005d0f	movq	%rax, _fwp_cleanups(%rip)
0000000100005d16	movq	%rdi, %r14
0000000100005d19	callq	_fwp_drop0
0000000100005d1e	movsd	-0x70(%rbp), %xmm0
0000000100005d23	addsd	-0x78(%rbp), %xmm0
0000000100005d28	movsd	%xmm0, -0x70(%rbp)
0000000100005d2d	movq	%r14, -0xb0(%rbp)
0000000100005d34	movq	_fwp_cleanups(%rip), %rax
0000000100005d3b	movq	%rax, -0x100(%rbp)
0000000100005d42	leaq	_fwp_owner_release2(%rip), %rax
0000000100005d49	movq	%rax, -0xf8(%rbp)
0000000100005d50	leaq	-0xb0(%rbp), %rax
0000000100005d57	movq	%rax, -0xf0(%rbp)
0000000100005d5e	leaq	-0x100(%rbp), %r12
0000000100005d65	movq	%r12, _fwp_cleanups(%rip)
0000000100005d6c	movq	%r13, -0x60(%rbp)
0000000100005d70	movq	%r14, -0x58(%rbp)
0000000100005d74	movsd	%xmm0, -0x50(%rbp)
0000000100005d79	movl	$0x20, %edi
0000000100005d7e	callq	_fwp_alloc_init
0000000100005d83	movq	%rax, %r15
0000000100005d86	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100005d90	movq	%rax, (%r15)
0000000100005d93	movq	%r13, 0x8(%r15)
0000000100005d97	movq	%r14, 0x10(%r15)
0000000100005d9b	movsd	-0x70(%rbp), %xmm0
0000000100005da0	movsd	%xmm0, 0x18(%r15)
0000000100005da6	leaq	-0x60(%rbp), %rax
0000000100005daa	movq	%r15, %rax
0000000100005dad	subq	0xf284(%rip), %rax
0000000100005db4	movq	0xf2a5(%rip), %rcx
0000000100005dbb	shlq	$0x10, %rcx
0000000100005dbf	cmpq	%rcx, %rax
0000000100005dc2	jae	0x100005e34
0000000100005dc4	movq	0xf2b5(%rip), %rcx
0000000100005dcb	movq	%rax, %rdx
0000000100005dce	shrq	$0x10, %rdx
0000000100005dd2	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005dd9	leaq	(%rcx,%rdx), %r14
0000000100005ddd	movzbl	(%rcx,%rdx), %ecx
0000000100005de1	cmpb	$0x2, %cl
0000000100005de4	setne	%dl
0000000100005de7	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005ded	setne	%sil
0000000100005df1	orb	%dl, %sil
0000000100005df4	jne	0x100005e09
0000000100005df6	addq	$0x228, %r14                    ## imm = 0x228
0000000100005dfd	cmpb	$-0x1, (%r14)
0000000100005e01	je	0x100005e2a
0000000100005e03	movb	$0x1, (%r14)
0000000100005e07	jmp	0x100005e34
0000000100005e09	cmpb	$0x1, %cl
0000000100005e0c	jne	0x100005e34
0000000100005e0e	movl	0x20(%r14), %ecx
0000000100005e12	imulq	%rcx, %rax
0000000100005e16	shrq	$0x20, %rax
0000000100005e1a	addq	%rax, %r14
0000000100005e1d	addq	$0x228, %r14                    ## imm = 0x228
0000000100005e24	cmpb	$-0x1, (%r14)
0000000100005e28	jne	0x100005e03
0000000100005e2a	movq	%r14, %rdi
0000000100005e2d	callq	_fwp_rc_forget_slot
0000000100005e32	jmp	0x100005e03
0000000100005e34	cmpq	%r12, _fwp_cleanups(%rip)
0000000100005e3b	jne	0x100005fda
0000000100005e41	movq	-0x100(%rbp), %rax
0000000100005e48	movq	%r15, -0xa8(%rbp)
0000000100005e4f	movq	%rax, -0xe8(%rbp)
0000000100005e56	leaq	_fwp_owner_release3(%rip), %rax
0000000100005e5d	movq	%rax, -0xe0(%rbp)
0000000100005e64	leaq	-0xa8(%rbp), %rax
0000000100005e6b	movq	%rax, -0xd8(%rbp)
0000000100005e72	leaq	-0xe8(%rbp), %r12
0000000100005e79	movq	%r12, _fwp_cleanups(%rip)
0000000100005e80	movq	%r15, -0x68(%rbp)
0000000100005e84	movl	$0x10, %edi
0000000100005e89	callq	_fwp_alloc_init
0000000100005e8e	movq	%rax, %r14
0000000100005e91	movabsq	$__mh_execute_header, %rax
0000000100005e9b	movq	%rax, (%r14)
0000000100005e9e	movq	%r15, 0x8(%r14)
0000000100005ea2	leaq	-0x68(%rbp), %rax
0000000100005ea6	movq	%r14, %rax
0000000100005ea9	subq	0xf188(%rip), %rax
0000000100005eb0	movq	0xf1a9(%rip), %rcx
0000000100005eb7	shlq	$0x10, %rcx
0000000100005ebb	cmpq	%rcx, %rax
0000000100005ebe	jae	0x100005f30
0000000100005ec0	movq	0xf1b9(%rip), %rcx
0000000100005ec7	movq	%rax, %rdx
0000000100005eca	shrq	$0x10, %rdx
0000000100005ece	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100005ed5	leaq	(%rcx,%rdx), %r15
0000000100005ed9	movzbl	(%rcx,%rdx), %ecx
0000000100005edd	cmpb	$0x2, %cl
0000000100005ee0	setne	%dl
0000000100005ee3	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100005ee9	setne	%sil
0000000100005eed	orb	%dl, %sil
0000000100005ef0	jne	0x100005f05
0000000100005ef2	addq	$0x228, %r15                    ## imm = 0x228
0000000100005ef9	cmpb	$-0x1, (%r15)
0000000100005efd	je	0x100005f26
0000000100005eff	movb	$0x1, (%r15)
0000000100005f03	jmp	0x100005f30
0000000100005f05	cmpb	$0x1, %cl
0000000100005f08	jne	0x100005f30
0000000100005f0a	movl	0x20(%r15), %ecx
0000000100005f0e	imulq	%rcx, %rax
0000000100005f12	shrq	$0x20, %rax
0000000100005f16	addq	%rax, %r15
0000000100005f19	addq	$0x228, %r15                    ## imm = 0x228
0000000100005f20	cmpb	$-0x1, (%r15)
0000000100005f24	jne	0x100005eff
0000000100005f26	movq	%r15, %rdi
0000000100005f29	callq	_fwp_rc_forget_slot
0000000100005f2e	jmp	0x100005eff
0000000100005f30	cmpq	%r12, _fwp_cleanups(%rip)
0000000100005f37	jne	0x100005fda
0000000100005f3d	movq	-0xe8(%rbp), %rax
0000000100005f44	movq	%rax, _fwp_cleanups(%rip)
0000000100005f4b	leaq	-0x98(%rbp), %r12
0000000100005f52	cmpq	%r12, _fwp_cleanups(%rip)
0000000100005f59	jne	0x100005fda
0000000100005f5b	movq	-0x98(%rbp), %rax
0000000100005f62	movq	%rax, _fwp_cleanups(%rip)
0000000100005f69	movq	%rbx, %rdi
0000000100005f6c	callq	_fwp_drop1
0000000100005f71	movq	0xd0b8(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100005f78	movq	(%rax), %rax
0000000100005f7b	cmpq	-0x30(%rbp), %rax
0000000100005f7f	jne	0x100005fdf
0000000100005f81	movq	%r14, %rax
0000000100005f84	addq	$0xd8, %rsp
0000000100005f8b	popq	%rbx
0000000100005f8c	popq	%r12
0000000100005f8e	popq	%r13
0000000100005f90	popq	%r14
0000000100005f92	popq	%r15
0000000100005f94	popq	%rbp
0000000100005f95	retq
0000000100005f96	callq	_fwp_rc_wide_dup
0000000100005f9b	movq	_fwp_cleanups(%rip), %rax
0000000100005fa2	movq	0x10(%rbx), %rdi
0000000100005fa6	movq	%rdi, -0x80(%rbp)
0000000100005faa	cmpq	%r14, %rax
0000000100005fad	je	0x100005b1e
0000000100005fb3	jmp	0x100005fda
0000000100005fb5	movq	%rdi, %r15
0000000100005fb8	movq	%rax, %rdi
0000000100005fbb	movsd	%xmm0, -0x78(%rbp)
0000000100005fc0	callq	_fwp_rc_wide_dup
0000000100005fc5	movsd	-0x78(%rbp), %xmm0
0000000100005fca	movq	%r15, %rdi
0000000100005fcd	cmpq	%r14, _fwp_cleanups(%rip)
0000000100005fd4	je	0x100005cf3
0000000100005fda	callq	0x1000111aa                     ## symbol stub for: _abort
0000000100005fdf	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100005fe4	nopw	%cs:(%rax,%rax)
_fwp_owner_release4:
0000000100005ff0	pushq	%rbp
0000000100005ff1	movq	%rsp, %rbp
0000000100005ff4	movq	(%rdi), %rdi
0000000100005ff7	popq	%rbp
0000000100005ff8	jmp	_fwp_drop1
0000000100005ffd	nopl	(%rax)
_fwp_owner_release5:
0000000100006000	pushq	%rbp
0000000100006001	movq	%rsp, %rbp
0000000100006004	movq	(%rdi), %rdi
0000000100006007	popq	%rbp
0000000100006008	jmp	_fwp_drop0
000000010000600d	nopl	(%rax)
_fwp_drop1:
0000000100006010	movq	%rdi, %rcx
0000000100006013	subq	0xf01e(%rip), %rcx
000000010000601a	movq	0xf03f(%rip), %rax
0000000100006021	shlq	$0x10, %rax
0000000100006025	cmpq	%rax, %rcx
0000000100006028	jae	0x1000060be
000000010000602e	movq	0xf04b(%rip), %rdx
0000000100006035	movq	%rcx, %rax
0000000100006038	shrq	$0x10, %rax
000000010000603c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100006043	leaq	(%rdx,%rsi), %rax
0000000100006047	movzbl	(%rdx,%rsi), %edx
000000010000604b	cmpb	$0x2, %dl
000000010000604e	setne	%sil
0000000100006052	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100006059	setne	%r8b
000000010000605d	orb	%sil, %r8b
0000000100006060	jne	0x10000606a
0000000100006062	addq	$0x228, %rax                    ## imm = 0x228
0000000100006068	jmp	0x100006083
000000010000606a	cmpb	$0x1, %dl
000000010000606d	jne	0x1000060be
000000010000606f	movl	0x20(%rax), %edx
0000000100006072	imulq	%rdx, %rcx
0000000100006076	shrq	$0x20, %rcx
000000010000607a	addq	%rcx, %rax
000000010000607d	addq	$0x228, %rax                    ## imm = 0x228
0000000100006083	movzbl	(%rax), %ecx
0000000100006086	testl	%ecx, %ecx
0000000100006088	je	0x1000060be
000000010000608a	cmpl	$0x1, %ecx
000000010000608d	jne	0x1000060b2
000000010000608f	pushq	%rbp
0000000100006090	movq	%rsp, %rbp
0000000100006093	pushq	%rbx
0000000100006094	pushq	%rax
0000000100006095	movq	0x10(%rdi), %rax
0000000100006099	movq	%rdi, %rbx
000000010000609c	movq	%rax, %rdi
000000010000609f	callq	_fwp_drop0
00000001000060a4	movq	%rbx, %rdi
00000001000060a7	addq	$0x8, %rsp
00000001000060ab	popq	%rbx
00000001000060ac	popq	%rbp
00000001000060ad	jmp	_fwp_rc_free_obj
00000001000060b2	cmpl	$0xff, %ecx
00000001000060b8	je	0x1000060bf
00000001000060ba	decb	%cl
00000001000060bc	movb	%cl, (%rax)
00000001000060be	retq
00000001000060bf	movq	%rax, %rdi
00000001000060c2	jmp	_fwp_rc_wide_drop
00000001000060c7	nopw	(%rax,%rax)
_fwp_rc_wide_dup:
00000001000060d0	pushq	%rbp
00000001000060d1	movq	%rsp, %rbp
00000001000060d4	pushq	%r14
00000001000060d6	pushq	%rbx
00000001000060d7	movq	%rdi, %rbx
00000001000060da	movq	%rdi, %rax
00000001000060dd	shrq	$0x11, %rax
00000001000060e1	xorl	%ebx, %eax
00000001000060e3	movl	%eax, %ecx
00000001000060e5	shrl	$0x9, %ecx
00000001000060e8	xorl	%eax, %ecx
00000001000060ea	movzbl	%cl, %eax
00000001000060ed	leaq	_fwp_gc(%rip), %rcx
00000001000060f4	leaq	(%rcx,%rax,8), %r14
00000001000060f8	addq	$0x1218, %r14                   ## imm = 0x1218
00000001000060ff	movq	0x1218(%rcx,%rax,8), %rax
0000000100006107	testq	%rax, %rax
000000010000610a	je	0x100006133
000000010000610c	cmpq	%rbx, (%rax)
000000010000610f	je	0x100006140
0000000100006111	nopw	%cs:(%rax,%rax)
0000000100006120	movq	%rax, %r14
0000000100006123	movq	0x10(%rax), %rax
0000000100006127	testq	%rax, %rax
000000010000612a	je	0x10000613a
000000010000612c	cmpq	%rbx, (%rax)
000000010000612f	jne	0x100006120
0000000100006131	jmp	0x10000613c
0000000100006133	cmpb	$-0x2, (%rbx)
0000000100006136	je	0x10000614e
0000000100006138	jmp	0x1000061a4
000000010000613a	xorl	%eax, %eax
000000010000613c	addq	$0x10, %r14
0000000100006140	cmpb	$-0x2, (%rbx)
0000000100006143	jne	0x100006186
0000000100006145	testq	%rax, %rax
0000000100006148	jne	0x1000061ed
000000010000614e	movl	$0x18, %edi
0000000100006153	callq	0x100011216                     ## symbol stub for: _malloc
0000000100006158	testq	%rax, %rax
000000010000615b	je	0x1000061c3
000000010000615d	movq	%rbx, (%rax)
0000000100006160	movq	$0xff, 0x8(%rax)
0000000100006168	movq	$0x0, 0x10(%rax)
0000000100006170	movq	%rax, (%r14)
0000000100006173	movb	$-0x1, (%rbx)
0000000100006176	leaq	0xf8a3(%rip), %rax
000000010000617d	movq	0xf89c(%rip), %rcx
0000000100006184	jmp	0x100006199
0000000100006186	testq	%rax, %rax
0000000100006189	je	0x1000061a4
000000010000618b	movq	0x8(%rax), %rcx
000000010000618f	cmpq	$-0x1, %rcx
0000000100006193	je	0x10000620c
0000000100006195	addq	$0x8, %rax
0000000100006199	incq	%rcx
000000010000619c	movq	%rcx, (%rax)
000000010000619f	popq	%rbx
00000001000061a0	popq	%r14
00000001000061a2	popq	%rbp
00000001000061a3	retq
00000001000061a4	callq	_fwp_flush
00000001000061a9	movq	0xce88(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061b0	movq	(%rax), %rdi
00000001000061b3	leaq	0xb7d5(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000061ba	leaq	0xb7a7(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000061c1	jmp	0x100006229
00000001000061c3	movq	0xce6e(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061ca	movq	(%rax), %rcx
00000001000061cd	leaq	0xb83b(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000061d4	movl	$0x13, %esi
00000001000061d9	movl	$0x1, %edx
00000001000061de	callq	0x1000111f8                     ## symbol stub for: _fwrite
00000001000061e3	movl	$0x66, %edi
00000001000061e8	callq	0x1000111c8                     ## symbol stub for: _exit
00000001000061ed	callq	_fwp_flush
00000001000061f2	movq	0xce3f(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061f9	movq	(%rax), %rdi
00000001000061fc	leaq	0xb78c(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006203	leaq	0xb8cf(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
000000010000620a	jmp	0x100006229
000000010000620c	callq	_fwp_flush
0000000100006211	movq	0xce20(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100006218	movq	(%rax), %rdi
000000010000621b	leaq	0xb76d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006222	leaq	0xb8d5(%rip), %rdx              ## literal pool for: "reference count overflow"
0000000100006229	xorl	%eax, %eax
000000010000622b	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100006230	movl	$0x65, %edi
0000000100006235	callq	0x1000111c8                     ## symbol stub for: _exit
000000010000623a	nopw	(%rax,%rax)
_fwp_owner_release1:
0000000100006240	pushq	%rbp
0000000100006241	movq	%rsp, %rbp
0000000100006244	movq	(%rdi), %rdi
0000000100006247	popq	%rbp
0000000100006248	jmp	_fwp_drop0
000000010000624d	nopl	(%rax)
_fwp_owner_release2:
0000000100006250	pushq	%rbp
0000000100006251	movq	%rsp, %rbp
0000000100006254	movq	(%rdi), %rdi
0000000100006257	popq	%rbp
0000000100006258	jmp	_fwp_drop0
000000010000625d	nopl	(%rax)
_fwp_record:
0000000100006260	testl	%edi, %edi
0000000100006262	je	0x100006312
0000000100006268	pushq	%rbp
0000000100006269	movq	%rsp, %rbp
000000010000626c	pushq	%r15
000000010000626e	pushq	%r14
0000000100006270	pushq	%rbx
0000000100006271	pushq	%rax
0000000100006272	movq	%rsi, %rbx
0000000100006275	movl	%edi, %r14d
0000000100006278	leaq	0x8(,%r14,8), %rax
0000000100006280	movl	%edi, %r15d
0000000100006283	movq	%rax, %rdi
0000000100006286	callq	_fwp_alloc_init
000000010000628b	movl	$0x0, (%rax)
0000000100006291	movl	%r15d, 0x4(%rax)
0000000100006295	cmpl	$0x8, %r15d
0000000100006299	jb	0x1000062ab
000000010000629b	movq	%rax, %rcx
000000010000629e	subq	%rbx, %rcx
00000001000062a1	addq	$0x8, %rcx
00000001000062a5	cmpq	$0x20, %rcx
00000001000062a9	jae	0x100006315
00000001000062ab	xorl	%ecx, %ecx
00000001000062ad	movq	%r14, %rsi
00000001000062b0	movq	%rcx, %rdx
00000001000062b3	andq	$0x3, %rsi
00000001000062b7	je	0x1000062d1
00000001000062b9	movq	%rcx, %rdx
00000001000062bc	nopl	(%rax)
00000001000062c0	movq	(%rbx,%rdx,8), %rdi
00000001000062c4	movq	%rdi, 0x8(%rax,%rdx,8)
00000001000062c9	incq	%rdx
00000001000062cc	decq	%rsi
00000001000062cf	jne	0x1000062c0
00000001000062d1	subq	%r14, %rcx
00000001000062d4	cmpq	$-0x4, %rcx
00000001000062d8	ja	0x100006355
00000001000062da	nopw	(%rax,%rax)
00000001000062e0	movq	(%rbx,%rdx,8), %rcx
00000001000062e4	movq	%rcx, 0x8(%rax,%rdx,8)
00000001000062e9	movq	0x8(%rbx,%rdx,8), %rcx
00000001000062ee	movq	%rcx, 0x10(%rax,%rdx,8)
00000001000062f3	movq	0x10(%rbx,%rdx,8), %rcx
00000001000062f8	movq	%rcx, 0x18(%rax,%rdx,8)
00000001000062fd	movq	0x18(%rbx,%rdx,8), %rcx
0000000100006302	movq	%rcx, 0x20(%rax,%rdx,8)
0000000100006307	addq	$0x4, %rdx
000000010000630b	cmpq	%rdx, %r14
000000010000630e	jne	0x1000062e0
0000000100006310	jmp	0x100006355
0000000100006312	xorl	%eax, %eax
0000000100006314	retq
0000000100006315	movl	%r14d, %ecx
0000000100006318	andl	$-0x4, %ecx
000000010000631b	leaq	(,%r14,8), %rdx
0000000100006323	andq	$-0x20, %rdx
0000000100006327	xorl	%esi, %esi
0000000100006329	nopl	(%rax)
0000000100006330	movups	(%rbx,%rsi), %xmm0
0000000100006334	movups	0x10(%rbx,%rsi), %xmm1
0000000100006339	movups	%xmm0, 0x8(%rax,%rsi)
000000010000633e	movups	%xmm1, 0x18(%rax,%rsi)
0000000100006343	addq	$0x20, %rsi
0000000100006347	cmpq	%rsi, %rdx
000000010000634a	jne	0x100006330
000000010000634c	cmpl	%r14d, %ecx
000000010000634f	jne	0x1000062ad
0000000100006355	addq	$0x8, %rsp
0000000100006359	popq	%rbx
000000010000635a	popq	%r14
000000010000635c	popq	%r15
000000010000635e	popq	%rbp
000000010000635f	retq
_fwp_owner_release3:
0000000100006360	pushq	%rbp
0000000100006361	movq	%rsp, %rbp
0000000100006364	movq	(%rdi), %rax
0000000100006367	subq	0xecca(%rip), %rax
000000010000636e	movq	0xeceb(%rip), %rcx
0000000100006375	shlq	$0x10, %rcx
0000000100006379	cmpq	%rcx, %rax
000000010000637c	jae	0x1000063e2
000000010000637e	movq	0xecfb(%rip), %rcx
0000000100006385	movq	%rax, %rdx
0000000100006388	shrq	$0x10, %rdx
000000010000638c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006393	leaq	(%rcx,%rdx), %rdi
0000000100006397	movzbl	(%rcx,%rdx), %ecx
000000010000639b	cmpb	$0x2, %cl
000000010000639e	setne	%dl
00000001000063a1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000063a7	setne	%sil
00000001000063ab	orb	%dl, %sil
00000001000063ae	jne	0x1000063b9
00000001000063b0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000063b7	jmp	0x1000063d3
00000001000063b9	cmpb	$0x1, %cl
00000001000063bc	jne	0x1000063e2
00000001000063be	movl	0x20(%rdi), %ecx
00000001000063c1	imulq	%rcx, %rax
00000001000063c5	shrq	$0x20, %rax
00000001000063c9	addq	%rax, %rdi
00000001000063cc	addq	$0x228, %rdi                    ## imm = 0x228
00000001000063d3	movzbl	(%rdi), %eax
00000001000063d6	cmpb	$0x2, %al
00000001000063d8	jb	0x1000063e2
00000001000063da	cmpb	$-0x1, %al
00000001000063dc	je	0x1000063e4
00000001000063de	decb	%al
00000001000063e0	movb	%al, (%rdi)
00000001000063e2	popq	%rbp
00000001000063e3	retq
00000001000063e4	popq	%rbp
00000001000063e5	jmp	_fwp_rc_wide_drop
00000001000063ea	nopw	(%rax,%rax)
_fwp_rc_free_obj:
00000001000063f0	pushq	%rbp
00000001000063f1	movq	%rsp, %rbp
00000001000063f4	pushq	%r15
00000001000063f6	pushq	%r14
00000001000063f8	pushq	%rbx
00000001000063f9	pushq	%rax
00000001000063fa	movq	%rdi, %rax
00000001000063fd	subq	0xec34(%rip), %rax
0000000100006404	movq	0xec55(%rip), %rcx
000000010000640b	shlq	$0x10, %rcx
000000010000640f	cmpq	%rcx, %rax
0000000100006412	jae	0x10000652f
0000000100006418	movq	0xec61(%rip), %rcx
000000010000641f	movq	%rax, %rdx
0000000100006422	shrq	$0x10, %rdx
0000000100006426	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
000000010000642d	leaq	(%rcx,%rdx), %rbx
0000000100006431	movzbl	(%rcx,%rdx), %r14d
0000000100006436	cmpb	$0x2, %r14b
000000010000643a	setne	%cl
000000010000643d	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006443	setne	%dl
0000000100006446	orb	%cl, %dl
0000000100006448	jne	0x10000645b
000000010000644a	leaq	0x228(%rbx), %rax
0000000100006451	cmpb	$0x1, (%rax)
0000000100006454	je	0x100006482
0000000100006456	jmp	0x10000652f
000000010000645b	cmpb	$0x1, %r14b
000000010000645f	jne	0x10000652f
0000000100006465	movl	0x20(%rbx), %ecx
0000000100006468	imulq	%rcx, %rax
000000010000646c	shrq	$0x20, %rax
0000000100006470	addq	%rbx, %rax
0000000100006473	addq	$0x228, %rax                    ## imm = 0x228
0000000100006479	cmpb	$0x1, (%rax)
000000010000647c	jne	0x10000652f
0000000100006482	movl	_fwp_reuse_verify(%rip), %eax
0000000100006488	testl	%eax, %eax
000000010000648a	js	0x1000064eb
000000010000648c	testl	%eax, %eax
000000010000648e	je	0x100006504
0000000100006490	cmpb	$0x1, 0x1(%rbx)
0000000100006494	jne	0x1000064a2
0000000100006496	cmpb	$0x2, %r14b
000000010000649a	jne	0x1000064ce
000000010000649c	movq	0x18(%rbx), %rdx
00000001000064a0	jmp	0x1000064d1
00000001000064a2	movl	$0xdead, (%rdi)                 ## imm = 0xDEAD
00000001000064a8	movl	0x4(%rdi), %edx
00000001000064ab	testq	%rdx, %rdx
00000001000064ae	je	0x10000652f
00000001000064b0	addq	$0x8, %rdi
00000001000064b4	shlq	$0x3, %rdx
00000001000064b8	leaq	0xaf81(%rip), %rsi
00000001000064bf	addq	$0x8, %rsp
00000001000064c3	popq	%rbx
00000001000064c4	popq	%r14
00000001000064c6	popq	%r15
00000001000064c8	popq	%rbp
00000001000064c9	jmp	0x100011234                     ## symbol stub for: _memset_pattern16
00000001000064ce	movl	0x8(%rbx), %edx
00000001000064d1	movq	%rdi, %rbx
00000001000064d4	movl	$0xdd, %esi
00000001000064d9	callq	0x10001122e                     ## symbol stub for: _memset
00000001000064de	movq	$0x0, (%rbx)
00000001000064e5	movb	$0x0, 0x8(%rbx)
00000001000064e9	jmp	0x10000652f
00000001000064eb	leaq	-0x1c(%rbp), %rax
00000001000064ef	movq	%rdi, %r15
00000001000064f2	movq	%rax, %rdi
00000001000064f5	callq	_fwp_rc_free_obj.cold.1
00000001000064fa	movq	%r15, %rdi
00000001000064fd	movl	-0x1c(%rbp), %eax
0000000100006500	testl	%eax, %eax
0000000100006502	jne	0x100006490
0000000100006504	movq	_fwp_gc(%rip), %rbx
000000010000650b	callq	_fwp_mem_free
0000000100006510	movq	_fwp_gc(%rip), %rax
0000000100006517	subq	%rbx, %rax
000000010000651a	cvtsi2sd	%rax, %xmm0
000000010000651f	addsd	0xece9(%rip), %xmm0
0000000100006527	movsd	%xmm0, 0xece1(%rip)
000000010000652f	addq	$0x8, %rsp
0000000100006533	popq	%rbx
0000000100006534	popq	%r14
0000000100006536	popq	%r15
0000000100006538	popq	%rbp
0000000100006539	retq
000000010000653a	nopw	(%rax,%rax)
_fwp_owned_entry29:
0000000100006540	pushq	%rbp
0000000100006541	movq	%rsp, %rbp
0000000100006544	movq	(%rdi), %rdi
0000000100006547	popq	%rbp
0000000100006548	jmp	_f29
000000010000654d	nopl	(%rax)
_fwp_caps29:
0000000100006550	movl	0x4(%rdi), %eax
0000000100006553	testl	%esi, %esi
0000000100006555	je	0x1000065b9
0000000100006557	testl	%eax, %eax
0000000100006559	je	0x100006611
000000010000655f	movq	0x8(%rdi), %rax
0000000100006563	subq	0xeace(%rip), %rax
000000010000656a	movq	0xeaef(%rip), %rcx
0000000100006571	shlq	$0x10, %rcx
0000000100006575	cmpq	%rcx, %rax
0000000100006578	jae	0x100006611
000000010000657e	movq	0xeafb(%rip), %rcx
0000000100006585	movq	%rax, %rdx
0000000100006588	shrq	$0x10, %rdx
000000010000658c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006593	leaq	(%rcx,%rdx), %rdi
0000000100006597	movzbl	(%rcx,%rdx), %ecx
000000010000659b	cmpb	$0x2, %cl
000000010000659e	setne	%dl
00000001000065a1	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000065a7	setne	%sil
00000001000065ab	orb	%dl, %sil
00000001000065ae	jne	0x1000065e4
00000001000065b0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000065b7	jmp	0x1000065fe
00000001000065b9	testl	%eax, %eax
00000001000065bb	je	_fwp_rc_free_obj
00000001000065c1	pushq	%rbp
00000001000065c2	movq	%rsp, %rbp
00000001000065c5	pushq	%rbx
00000001000065c6	pushq	%rax
00000001000065c7	movq	0x8(%rdi), %rax
00000001000065cb	movq	%rdi, %rbx
00000001000065ce	movq	%rax, %rdi
00000001000065d1	callq	_fwp_drop1
00000001000065d6	movq	%rbx, %rdi
00000001000065d9	addq	$0x8, %rsp
00000001000065dd	popq	%rbx
00000001000065de	popq	%rbp
00000001000065df	jmp	_fwp_rc_free_obj
00000001000065e4	cmpb	$0x1, %cl
00000001000065e7	jne	0x100006611
00000001000065e9	movl	0x20(%rdi), %ecx
00000001000065ec	imulq	%rcx, %rax
00000001000065f0	shrq	$0x20, %rax
00000001000065f4	addq	%rax, %rdi
00000001000065f7	addq	$0x228, %rdi                    ## imm = 0x228
00000001000065fe	movzbl	(%rdi), %eax
0000000100006601	testb	%al, %al
0000000100006603	je	0x100006611
0000000100006605	cmpb	$-0x2, %al
0000000100006607	jae	_fwp_rc_wide_dup
000000010000660d	incb	%al
000000010000660f	movb	%al, (%rdi)
0000000100006611	retq
0000000100006612	nopw	%cs:(%rax,%rax)
_fwp_args29:
0000000100006620	pushq	%rbp
0000000100006621	movq	%rsp, %rbp
0000000100006624	testl	%esi, %esi
0000000100006626	setne	%al
0000000100006629	testl	%edx, %edx
000000010000662b	sete	%cl
000000010000662e	orb	%al, %cl
0000000100006630	jne	0x1000066b0
0000000100006632	movq	(%rdi), %rax
0000000100006635	subq	0xe9fc(%rip), %rax
000000010000663c	movq	0xea1d(%rip), %rcx
0000000100006643	shlq	$0x10, %rcx
0000000100006647	cmpq	%rcx, %rax
000000010000664a	jae	0x1000066b0
000000010000664c	movq	0xea2d(%rip), %rcx
0000000100006653	movq	%rax, %rdx
0000000100006656	shrq	$0x10, %rdx
000000010000665a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006661	leaq	(%rcx,%rdx), %rdi
0000000100006665	movzbl	(%rcx,%rdx), %ecx
0000000100006669	cmpb	$0x2, %cl
000000010000666c	setne	%dl
000000010000666f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006675	setne	%sil
0000000100006679	orb	%dl, %sil
000000010000667c	jne	0x100006687
000000010000667e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006685	jmp	0x1000066a1
0000000100006687	cmpb	$0x1, %cl
000000010000668a	jne	0x1000066b0
000000010000668c	movl	0x20(%rdi), %ecx
000000010000668f	imulq	%rcx, %rax
0000000100006693	shrq	$0x20, %rax
0000000100006697	addq	%rax, %rdi
000000010000669a	addq	$0x228, %rdi                    ## imm = 0x228
00000001000066a1	movzbl	(%rdi), %eax
00000001000066a4	testb	%al, %al
00000001000066a6	je	0x1000066b0
00000001000066a8	cmpb	$-0x2, %al
00000001000066aa	jae	0x1000066b2
00000001000066ac	incb	%al
00000001000066ae	movb	%al, (%rdi)
00000001000066b0	popq	%rbp
00000001000066b1	retq
00000001000066b2	popq	%rbp
00000001000066b3	jmp	_fwp_rc_wide_dup
00000001000066b8	nopl	(%rax,%rax)
_fwp_arg_drop29:
00000001000066c0	pushq	%rbp
00000001000066c1	movq	%rsp, %rbp
00000001000066c4	testl	%esi, %esi
00000001000066c6	setne	%al
00000001000066c9	testl	%edx, %edx
00000001000066cb	sete	%cl
00000001000066ce	orb	%al, %cl
00000001000066d0	je	0x1000066d4
00000001000066d2	popq	%rbp
00000001000066d3	retq
00000001000066d4	movq	(%rdi), %rdi
00000001000066d7	popq	%rbp
00000001000066d8	jmp	_fwp_drop1
00000001000066dd	nopl	(%rax)
_fwp_p_loop_own:
00000001000066e0	pushq	%rbp
00000001000066e1	movq	%rsp, %rbp
00000001000066e4	pushq	%r15
00000001000066e6	pushq	%r14
00000001000066e8	pushq	%r13
00000001000066ea	pushq	%r12
00000001000066ec	pushq	%rbx
00000001000066ed	subq	$0xe8, %rsp
00000001000066f4	movq	%rdi, -0x78(%rbp)
00000001000066f8	movq	%rsi, -0x38(%rbp)
00000001000066fc	movq	%rsi, -0x70(%rbp)
0000000100006700	movq	%rdx, -0x68(%rbp)
0000000100006704	testq	%rdx, %rdx
0000000100006707	je	0x10000674c
0000000100006709	movq	_fwp_cleanups(%rip), %rax
0000000100006710	movq	%rax, -0x90(%rbp)
0000000100006717	leaq	_fwp_value_release(%rip), %rax
000000010000671e	movq	%rax, -0x88(%rbp)
0000000100006725	leaq	-0x70(%rbp), %rax
0000000100006729	movq	%rax, -0x80(%rbp)
000000010000672d	leaq	-0x90(%rbp), %rax
0000000100006734	movq	%rax, _fwp_cleanups(%rip)
000000010000673b	jmp	0x10000674c
000000010000673d	nopl	(%rax)
0000000100006740	incb	%al
0000000100006742	movb	%al, (%rdi)
0000000100006744	movq	%rsi, -0x38(%rbp)
0000000100006748	movq	%rsi, -0x70(%rbp)
000000010000674c	movl	_fwp_budget(%rip), %eax
0000000100006752	leal	-0x1(%rax), %ecx
0000000100006755	movl	%ecx, _fwp_budget(%rip)
000000010000675b	cmpl	$0x1, %eax
000000010000675e	jle	0x100006cdc
0000000100006764	movq	%rsi, -0x38(%rbp)
0000000100006768	movq	$0x0, -0x70(%rbp)
0000000100006770	movq	_fwp_fns(%rip), %rcx
0000000100006777	movq	-0x78(%rbp), %r9
000000010000677b	movl	(%r9), %edx
000000010000677e	shlq	$0x5, %rdx
0000000100006782	movq	0x18(%rcx,%rdx), %rax
0000000100006787	testq	%rax, %rax
000000010000678a	je	0x100006ba0
0000000100006790	leaq	(%rcx,%rdx), %r11
0000000100006794	leaq	(%rcx,%rdx), %r12
0000000100006798	addq	$0x18, %r12
000000010000679c	movl	$0x1, %r13d
00000001000067a2	xorl	%ecx, %ecx
00000001000067a4	leaq	-0x38(%rbp), %rdx
00000001000067a8	movl	$0x1, %r10d
00000001000067ae	nop
00000001000067b0	testb	$0x1, %cl
00000001000067b3	movl	$0x0, %esi
00000001000067b8	cmovneq	%r9, %rsi
00000001000067bc	movq	%rsi, -0x110(%rbp)
00000001000067c3	movq	%rdx, -0x108(%rbp)
00000001000067ca	movq	%rax, -0x100(%rbp)
00000001000067d1	movl	$0x0, -0xf8(%rbp)
00000001000067db	movl	0x4(%r9), %esi
00000001000067df	movl	%esi, -0xf4(%rbp)
00000001000067e5	movq	%r9, %r15
00000001000067e8	subq	0xe849(%rip), %r15
00000001000067ef	movl	%r10d, -0xf0(%rbp)
00000001000067f6	movq	0xe863(%rip), %rsi
00000001000067fd	shlq	$0x10, %rsi
0000000100006801	cmpq	%rsi, %r15
0000000100006804	movq	%rdx, -0x48(%rbp)
0000000100006808	jae	0x1000068b0
000000010000680e	movq	%r9, %r14
0000000100006811	movq	%r11, -0x40(%rbp)
0000000100006815	movl	%r10d, %ebx
0000000100006818	movq	0xe861(%rip), %r8
000000010000681f	movq	%r15, %rdi
0000000100006822	shrq	$0x10, %rdi
0000000100006826	imulq	$0x1228, %rdi, %r9              ## imm = 0x1228
000000010000682d	leaq	(%r8,%r9), %rdi
0000000100006831	movzbl	(%r8,%r9), %r9d
0000000100006836	cmpb	$0x2, %r9b
000000010000683a	setne	%r10b
000000010000683e	movq	%r15, %r8
0000000100006841	andq	$0xffff, %r8                    ## imm = 0xFFFF
0000000100006848	setne	%r11b
000000010000684c	orb	%r10b, %r11b
000000010000684f	jne	0x100006870
0000000100006851	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006858	movq	-0x48(%rbp), %rdx
000000010000685c	movl	%ebx, %r10d
000000010000685f	movq	-0x40(%rbp), %r11
0000000100006863	jmp	0x10000689a
0000000100006865	nopw	%cs:(%rax,%rax)
0000000100006870	cmpb	$0x1, %r9b
0000000100006874	movq	-0x48(%rbp), %rdx
0000000100006878	movl	%ebx, %r10d
000000010000687b	movq	-0x40(%rbp), %r11
000000010000687f	movq	%r14, %r9
0000000100006882	jne	0x1000068b0
0000000100006884	movl	0x20(%rdi), %r9d
0000000100006888	imulq	%r9, %r8
000000010000688c	shrq	$0x20, %r8
0000000100006890	addq	%r8, %rdi
0000000100006893	addq	$0x228, %rdi                    ## imm = 0x228
000000010000689a	cmpb	$0x0, (%rdi)
000000010000689d	movq	%r14, %r9
00000001000068a0	jne	0x1000068bc
00000001000068a2	nopw	%cs:(%rax,%rax)
00000001000068b0	testl	%r10d, %r10d
00000001000068b3	je	0x100006910
00000001000068b5	cmpq	$0x0, 0x18(%rax)
00000001000068ba	je	0x100006910
00000001000068bc	movq	_fwp_cleanups(%rip), %rdi
00000001000068c3	movq	%rdi, -0xe8(%rbp)
00000001000068ca	leaq	_fwp_apply_release(%rip), %rdi
00000001000068d1	movq	%rdi, -0xe0(%rbp)
00000001000068d8	leaq	-0x110(%rbp), %rdi
00000001000068df	movq	%rdi, -0xd8(%rbp)
00000001000068e6	leaq	-0xe8(%rbp), %rdi
00000001000068ed	movq	%rdi, _fwp_cleanups(%rip)
00000001000068f4	movb	$0x1, %dil
00000001000068f7	movl	%edi, -0x2c(%rbp)
00000001000068fa	testb	$0x1, %cl
00000001000068fd	je	0x10000691c
00000001000068ff	jmp	0x100006993
0000000100006904	nopw	%cs:(%rax,%rax)
0000000100006910	movl	$0x0, -0x2c(%rbp)
0000000100006917	testb	$0x1, %cl
000000010000691a	jne	0x100006993
000000010000691c	cmpq	%rsi, %r15
000000010000691f	jae	0x100006988
0000000100006921	movq	0xe758(%rip), %rax
0000000100006928	movq	%r15, %rcx
000000010000692b	shrq	$0x10, %rcx
000000010000692f	imulq	$0x1228, %rcx, %rcx             ## imm = 0x1228
0000000100006936	leaq	(%rax,%rcx), %rdi
000000010000693a	movzbl	(%rax,%rcx), %eax
000000010000693e	cmpb	$0x2, %al
0000000100006940	setne	%cl
0000000100006943	andq	$0xffff, %r15                   ## imm = 0xFFFF
000000010000694a	setne	%sil
000000010000694e	orb	%cl, %sil
0000000100006951	jne	0x10000695c
0000000100006953	addq	$0x228, %rdi                    ## imm = 0x228
000000010000695a	jmp	0x100006975
000000010000695c	cmpb	$0x1, %al
000000010000695e	jne	0x100006988
0000000100006960	movl	0x20(%rdi), %eax
0000000100006963	imulq	%rax, %r15
0000000100006967	shrq	$0x20, %r15
000000010000696b	addq	%r15, %rdi
000000010000696e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006975	movzbl	(%rdi), %eax
0000000100006978	testb	%al, %al
000000010000697a	je	0x100006988
000000010000697c	cmpb	$-0x2, %al
000000010000697e	jae	0x100006b7e
0000000100006984	incb	%al
0000000100006986	movb	%al, (%rdi)
0000000100006988	movq	%r9, -0x110(%rbp)
000000010000698f	movq	(%r12), %rax
0000000100006993	movl	(%r11), %r15d
0000000100006996	subl	0x4(%r9), %r15d
000000010000699a	cmpl	%r15d, %r13d
000000010000699d	movl	%r15d, -0x58(%rbp)
00000001000069a1	movl	%r13d, %r14d
00000001000069a4	cmovbl	%r13d, %r15d
00000001000069a8	cmpl	%r15d, %r10d
00000001000069ab	movl	%r15d, %esi
00000001000069ae	cmovbl	%r10d, %esi
00000001000069b2	movq	$0x0, -0xd0(%rbp)
00000001000069bd	leaq	(%rdx,%rsi,8), %rbx
00000001000069c1	movq	%rbx, -0xc8(%rbp)
00000001000069c8	movq	%rax, -0xc0(%rbp)
00000001000069cf	movl	$0x0, -0xb8(%rbp)
00000001000069d9	movl	0x4(%r9), %ecx
00000001000069dd	addl	%esi, %ecx
00000001000069df	movl	%ecx, -0xb4(%rbp)
00000001000069e5	movl	$0x0, -0xb0(%rbp)
00000001000069ef	xorl	%r13d, %r13d
00000001000069f2	movl	$0x0, %ecx
00000001000069f7	movl	%r10d, -0x5c(%rbp)
00000001000069fb	cmpl	%r10d, %r15d
00000001000069fe	movq	%rsi, -0x40(%rbp)
0000000100006a02	jbe	0x100006ab8
0000000100006a08	movl	%r14d, -0x54(%rbp)
0000000100006a0c	cmpq	$0x0, 0x18(%rax)
0000000100006a11	setne	%al
0000000100006a14	movl	%eax, -0x4c(%rbp)
0000000100006a17	je	0x100006a51
0000000100006a19	movq	_fwp_cleanups(%rip), %rax
0000000100006a20	movq	%rax, -0xa8(%rbp)
0000000100006a27	leaq	_fwp_apply_release(%rip), %rax
0000000100006a2e	movq	%rax, -0xa0(%rbp)
0000000100006a35	leaq	-0xd0(%rbp), %rax
0000000100006a3c	movq	%rax, -0x98(%rbp)
0000000100006a43	leaq	-0xa8(%rbp), %rax
0000000100006a4a	movq	%rax, _fwp_cleanups(%rip)
0000000100006a51	movl	%r15d, -0x50(%rbp)
0000000100006a55	subl	%esi, %r15d
0000000100006a58	cmpl	$0x1, %r15d
0000000100006a5c	adcl	$0x0, %r15d
0000000100006a60	shlq	$0x3, %r15
0000000100006a64	movl	%esi, %r14d
0000000100006a67	movq	%r9, %r13
0000000100006a6a	nopw	(%rax,%rax)
0000000100006a70	movq	(%r12), %rax
0000000100006a74	movl	0x4(%r13), %esi
0000000100006a78	addl	%r14d, %esi
0000000100006a7b	movq	%rbx, %rdi
0000000100006a7e	movl	$0x1, %edx
0000000100006a83	callq	*0x10(%rax)
0000000100006a86	movl	-0xb0(%rbp), %ecx
0000000100006a8c	incl	%ecx
0000000100006a8e	movl	%ecx, -0xb0(%rbp)
0000000100006a94	incl	%r14d
0000000100006a97	addq	$0x8, %rbx
0000000100006a9b	addq	$-0x8, %r15
0000000100006a9f	jne	0x100006a70
0000000100006aa1	movq	%r13, %r9
0000000100006aa4	movl	-0x54(%rbp), %r14d
0000000100006aa8	movq	-0x48(%rbp), %rdx
0000000100006aac	movl	-0x50(%rbp), %r15d
0000000100006ab0	movq	-0x40(%rbp), %rsi
0000000100006ab4	movl	-0x4c(%rbp), %r13d
0000000100006ab8	movl	%ecx, -0xb8(%rbp)
0000000100006abe	movq	$0x0, -0x110(%rbp)
0000000100006ac9	movl	%esi, -0xf8(%rbp)
0000000100006acf	movq	%r9, %rdi
0000000100006ad2	movl	%r15d, %esi
0000000100006ad5	callq	_fwp_apply_owned
0000000100006ada	movq	%rax, %r9
0000000100006add	testb	%r13b, %r13b
0000000100006ae0	movl	%r14d, %r13d
0000000100006ae3	je	0x100006b07
0000000100006ae5	leaq	-0xa8(%rbp), %rax
0000000100006aec	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006af3	jne	0x100006d2d
0000000100006af9	movq	-0xa8(%rbp), %rax
0000000100006b00	movq	%rax, _fwp_cleanups(%rip)
0000000100006b07	cmpb	$0x0, -0x2c(%rbp)
0000000100006b0b	movq	-0x48(%rbp), %rdx
0000000100006b0f	movl	-0x5c(%rbp), %r10d
0000000100006b13	movq	-0x40(%rbp), %rcx
0000000100006b17	je	0x100006b3b
0000000100006b19	leaq	-0xe8(%rbp), %rax
0000000100006b20	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006b27	jne	0x100006d2d
0000000100006b2d	movq	-0xe8(%rbp), %rax
0000000100006b34	movq	%rax, _fwp_cleanups(%rip)
0000000100006b3b	cmpl	-0x58(%rbp), %r13d
0000000100006b3f	jbe	0x100006c05
0000000100006b45	movl	%r15d, %eax
0000000100006b48	leaq	(%rdx,%rax,8), %rdx
0000000100006b4c	subl	%r15d, %r13d
0000000100006b4f	subl	%ecx, %r10d
0000000100006b52	movq	_fwp_fns(%rip), %rax
0000000100006b59	movl	(%r9), %ecx
0000000100006b5c	shlq	$0x5, %rcx
0000000100006b60	leaq	(%rax,%rcx), %r11
0000000100006b64	leaq	(%rax,%rcx), %r12
0000000100006b68	addq	$0x18, %r12
0000000100006b6c	movq	0x18(%rax,%rcx), %rax
0000000100006b71	movb	$0x1, %cl
0000000100006b73	testq	%rax, %rax
0000000100006b76	jne	0x1000067b0
0000000100006b7c	jmp	0x100006bc0
0000000100006b7e	movl	%r10d, %ebx
0000000100006b81	movq	%r11, %r15
0000000100006b84	movq	%r9, %r14
0000000100006b87	callq	_fwp_rc_wide_dup
0000000100006b8c	movq	%r14, %r9
0000000100006b8f	movq	%r15, %r11
0000000100006b92	movl	%ebx, %r10d
0000000100006b95	movq	-0x48(%rbp), %rdx
0000000100006b99	jmp	0x100006988
0000000100006b9e	nop
0000000100006ba0	movq	%r9, %rdi
0000000100006ba3	movq	%r9, %rbx
0000000100006ba6	callq	_fwp_rc_share
0000000100006bab	movl	$0x1, %r13d
0000000100006bb1	movq	%rbx, %r12
0000000100006bb4	leaq	-0x38(%rbp), %rdx
0000000100006bb8	jmp	0x100006bda
0000000100006bba	nopw	(%rax,%rax)
0000000100006bc0	movq	%rdx, %rbx
0000000100006bc3	movq	%r9, %rdi
0000000100006bc6	movq	%r9, %r12
0000000100006bc9	callq	_fwp_rc_share
0000000100006bce	testl	%r13d, %r13d
0000000100006bd1	je	0x100006cd1
0000000100006bd7	movq	%rbx, %rdx
0000000100006bda	movl	%r13d, %ebx
0000000100006bdd	xorl	%r14d, %r14d
0000000100006be0	movq	(%rdx,%r14,8), %rdi
0000000100006be4	movq	%rdx, %r15
0000000100006be7	callq	_fwp_rc_share
0000000100006bec	movq	%r15, %rdx
0000000100006bef	incq	%r14
0000000100006bf2	cmpq	%r14, %rbx
0000000100006bf5	jne	0x100006be0
0000000100006bf7	movq	%r12, %rdi
0000000100006bfa	movl	%r13d, %esi
0000000100006bfd	callq	_fwp_apply
0000000100006c02	movq	%rax, %r9
0000000100006c05	cmpq	$0xfff, %r9                     ## imm = 0xFFF
0000000100006c0c	ja	0x100006c20
0000000100006c0e	movl	%r9d, %eax
0000000100006c11	jmp	0x100006c23
0000000100006c13	nopw	%cs:(%rax,%rax)
0000000100006c20	movl	(%r9), %eax
0000000100006c23	movq	0x8(%r9), %rsi
0000000100006c27	testl	%eax, %eax
0000000100006c29	jne	0x100006cea
0000000100006c2f	movq	%rsi, %rax
0000000100006c32	subq	0xe3ff(%rip), %rax
0000000100006c39	movq	0xe420(%rip), %rcx
0000000100006c40	shlq	$0x10, %rcx
0000000100006c44	cmpq	%rcx, %rax
0000000100006c47	jae	0x100006744
0000000100006c4d	movq	0xe42c(%rip), %rcx
0000000100006c54	movq	%rax, %rdx
0000000100006c57	shrq	$0x10, %rdx
0000000100006c5b	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100006c62	leaq	(%rcx,%rdx), %rdi
0000000100006c66	movzbl	(%rcx,%rdx), %ecx
0000000100006c6a	cmpb	$0x2, %cl
0000000100006c6d	setne	%dl
0000000100006c70	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100006c76	setne	%r8b
0000000100006c7a	orb	%dl, %r8b
0000000100006c7d	jne	0x100006c90
0000000100006c7f	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006c86	jmp	0x100006cae
0000000100006c88	nopl	(%rax,%rax)
0000000100006c90	cmpb	$0x1, %cl
0000000100006c93	jne	0x100006744
0000000100006c99	movl	0x20(%rdi), %ecx
0000000100006c9c	imulq	%rcx, %rax
0000000100006ca0	shrq	$0x20, %rax
0000000100006ca4	addq	%rax, %rdi
0000000100006ca7	addq	$0x228, %rdi                    ## imm = 0x228
0000000100006cae	movzbl	(%rdi), %eax
0000000100006cb1	testb	%al, %al
0000000100006cb3	je	0x100006744
0000000100006cb9	cmpb	$-0x2, %al
0000000100006cbb	jb	0x100006740
0000000100006cc1	movq	%rsi, %rbx
0000000100006cc4	callq	_fwp_rc_wide_dup
0000000100006cc9	movq	%rbx, %rsi
0000000100006ccc	jmp	0x100006744
0000000100006cd1	xorl	%r13d, %r13d
0000000100006cd4	movq	%rbx, %rdx
0000000100006cd7	jmp	0x100006bf7
0000000100006cdc	callq	_fwp_preempt
0000000100006ce1	movq	-0x70(%rbp), %rsi
0000000100006ce5	jmp	0x100006764
0000000100006cea	movq	%rsi, -0x38(%rbp)
0000000100006cee	movq	-0x78(%rbp), %rax
0000000100006cf2	cmpq	$0x0, -0x68(%rbp)
0000000100006cf7	je	0x100006d17
0000000100006cf9	leaq	-0x90(%rbp), %rax
0000000100006d00	cmpq	%rax, _fwp_cleanups(%rip)
0000000100006d07	jne	0x100006d2d
0000000100006d09	movq	-0x90(%rbp), %rax
0000000100006d10	movq	%rax, _fwp_cleanups(%rip)
0000000100006d17	movq	-0x38(%rbp), %rax
0000000100006d1b	addq	$0xe8, %rsp
0000000100006d22	popq	%rbx
0000000100006d23	popq	%r12
0000000100006d25	popq	%r13
0000000100006d27	popq	%r14
0000000100006d29	popq	%r15
0000000100006d2b	popq	%rbp
0000000100006d2c	retq
0000000100006d2d	callq	0x1000111aa                     ## symbol stub for: _abort
0000000100006d32	nopw	%cs:(%rax,%rax)
_fwp_preempt:
0000000100006d40	movl	_fwp_slice(%rip), %ecx
0000000100006d46	testl	%ecx, %ecx
0000000100006d48	je	0x100006d51
0000000100006d4a	movl	%ecx, _fwp_budget(%rip)
0000000100006d50	retq
0000000100006d51	pushq	%rbp
0000000100006d52	movq	%rsp, %rbp
0000000100006d55	leaq	0xadbb(%rip), %rdi              ## literal pool for: "FWP_PREEMPT"
0000000100006d5c	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100006d61	movq	%rax, %rdi
0000000100006d64	movl	$0x2710, %eax                   ## imm = 0x2710
0000000100006d69	testq	%rdi, %rdi
0000000100006d6c	je	0x100006d7f
0000000100006d6e	cmpb	$0x0, (%rdi)
0000000100006d71	je	0x100006d7f
0000000100006d73	xorl	%esi, %esi
0000000100006d75	movl	$0xa, %edx
0000000100006d7a	callq	0x1000112c4                     ## symbol stub for: _strtoll
0000000100006d7f	leaq	-0x80000000(%rax), %rcx
0000000100006d86	cmpq	$-0x7fffffff, %rcx              ## imm = 0x80000001
0000000100006d8d	movl	$0x7fffffff, %ecx               ## imm = 0x7FFFFFFF
0000000100006d92	cmovael	%eax, %ecx
0000000100006d95	movl	%ecx, _fwp_slice(%rip)
0000000100006d9b	popq	%rbp
0000000100006d9c	movl	%ecx, _fwp_budget(%rip)
0000000100006da2	retq
0000000100006da3	nopw	%cs:(%rax,%rax)
_fwp_value_release:
0000000100006db0	pushq	%rbp
0000000100006db1	movq	%rsp, %rbp
0000000100006db4	movq	%rdi, %rax
0000000100006db7	movq	(%rdi), %rdi
0000000100006dba	movq	0x8(%rax), %rcx
0000000100006dbe	movq	$0x0, (%rax)
0000000100006dc5	testq	%rcx, %rcx
0000000100006dc8	setne	%al
0000000100006dcb	testq	%rdi, %rdi
0000000100006dce	setne	%dl
0000000100006dd1	andb	%al, %dl
0000000100006dd3	cmpb	$0x1, %dl
0000000100006dd6	jne	0x100006ddb
0000000100006dd8	popq	%rbp
0000000100006dd9	jmpq	*%rcx
0000000100006ddb	popq	%rbp
0000000100006ddc	retq
0000000100006ddd	nopl	(%rax)
_fwp_apply:
0000000100006de0	pushq	%rbp
0000000100006de1	movq	%rsp, %rbp
0000000100006de4	pushq	%r15
0000000100006de6	pushq	%r14
0000000100006de8	pushq	%r13
0000000100006dea	pushq	%r12
0000000100006dec	pushq	%rbx
0000000100006ded	subq	$0x38, %rsp
0000000100006df1	movq	%rdx, %rbx
0000000100006df4	movl	%esi, %r8d
0000000100006df7	movq	%rdi, %r15
0000000100006dfa	movq	0xc22f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100006e01	movq	(%rax), %rax
0000000100006e04	movq	%rax, -0x30(%rbp)
0000000100006e08	jmp	0x100006e2d
0000000100006e0a	nopw	(%rax,%rax)
0000000100006e10	leaq	(%rbx,%r14,8), %rbx
0000000100006e14	xorl	%ecx, %ecx
0000000100006e16	movq	%rax, %r15
0000000100006e19	movq	-0x48(%rbp), %r14
0000000100006e1d	movq	-0x50(%rbp), %rsp
0000000100006e21	movl	%edx, %r8d
0000000100006e24	cmpl	$0x1, %ecx
0000000100006e27	je	0x1000072d6
0000000100006e2d	movq	_fwp_fns(%rip), %rax
0000000100006e34	movl	(%r15), %ecx
0000000100006e37	movl	0x4(%r15), %r13d
0000000100006e3b	shlq	$0x5, %rcx
0000000100006e3f	leaq	(%rax,%rcx), %rdx
0000000100006e43	movl	(%rax,%rcx), %r12d
0000000100006e47	testq	%r13, %r13
0000000100006e4a	jne	0x100006e90
0000000100006e4c	leal	-0x1(%r12), %eax
0000000100006e51	cmpl	%r8d, %eax
0000000100006e54	jae	0x100006e90
0000000100006e56	movq	%rbx, %rdi
0000000100006e59	movq	%r8, %r15
0000000100006e5c	callq	*0x8(%rdx)
0000000100006e5f	movq	%r15, %r8
0000000100006e62	movq	%rax, %r15
0000000100006e65	cmpl	%r12d, %r8d
0000000100006e68	je	0x10000712b
0000000100006e6e	leaq	(%rbx,%r12,8), %rbx
0000000100006e72	subl	%r12d, %r8d
0000000100006e75	movl	$0x3, %ecx
0000000100006e7a	cmpl	$0x1, %ecx
0000000100006e7d	jne	0x100006e2d
0000000100006e7f	jmp	0x1000072d6
0000000100006e84	nopw	%cs:(%rax,%rax)
0000000100006e90	movq	%r14, -0x48(%rbp)
0000000100006e94	leal	(%r8,%r13), %r14d
0000000100006e98	cmpl	%r12d, %r14d
0000000100006e9b	movq	%r8, -0x40(%rbp)
0000000100006e9f	jb	0x1000070cd
0000000100006ea5	movq	%rdx, -0x58(%rbp)
0000000100006ea9	movq	%rsp, -0x50(%rbp)
0000000100006ead	movl	%r12d, %r14d
0000000100006eb0	cmpl	$0x2, %r12d
0000000100006eb4	movl	$0x1, %eax
0000000100006eb9	cmovael	%r12d, %eax
0000000100006ebd	shlq	$0x3, %rax
0000000100006ec1	callq	0x100011168                     ## symbol stub for: ____chkstk_darwin
0000000100006ec6	addq	$0xf, %rax
0000000100006eca	andq	$-0x10, %rax
0000000100006ece	subq	%rax, %rsp
0000000100006ed1	movq	%rsp, %rdi
0000000100006ed4	testq	%r13, %r13
0000000100006ed7	je	0x100006fb0
0000000100006edd	cmpl	$0x3, %r13d
0000000100006ee1	jbe	0x100006ef3
0000000100006ee3	movq	%rdi, %rax
0000000100006ee6	subq	%r15, %rax
0000000100006ee9	addq	$-0x8, %rax
0000000100006eed	cmpq	$0x20, %rax
0000000100006ef1	jae	0x100006f62
0000000100006ef3	xorl	%eax, %eax
0000000100006ef5	movq	%r13, %rdx
0000000100006ef8	movq	%rax, %rcx
0000000100006efb	andq	$0x3, %rdx
0000000100006eff	je	0x100006f21
0000000100006f01	movq	%rax, %rcx
0000000100006f04	nopw	%cs:(%rax,%rax)
0000000100006f10	movq	0x8(%r15,%rcx,8), %rsi
0000000100006f15	movq	%rsi, (%rdi,%rcx,8)
0000000100006f19	incq	%rcx
0000000100006f1c	decq	%rdx
0000000100006f1f	jne	0x100006f10
0000000100006f21	subq	%r13, %rax
0000000100006f24	cmpq	$-0x4, %rax
0000000100006f28	ja	0x100006fb0
0000000100006f2e	nop
0000000100006f30	movq	0x8(%r15,%rcx,8), %rax
0000000100006f35	movq	%rax, (%rdi,%rcx,8)
0000000100006f39	movq	0x10(%r15,%rcx,8), %rax
0000000100006f3e	movq	%rax, 0x8(%rdi,%rcx,8)
0000000100006f43	movq	0x18(%r15,%rcx,8), %rax
0000000100006f48	movq	%rax, 0x10(%rdi,%rcx,8)
0000000100006f4d	movq	0x20(%r15,%rcx,8), %rax
0000000100006f52	movq	%rax, 0x18(%rdi,%rcx,8)
0000000100006f57	addq	$0x4, %rcx
0000000100006f5b	cmpq	%rcx, %r13
0000000100006f5e	jne	0x100006f30
0000000100006f60	jmp	0x100006fb0
0000000100006f62	movl	%r13d, %eax
0000000100006f65	andl	$-0x4, %eax
0000000100006f68	leaq	(,%r13,8), %rcx
0000000100006f70	andq	$-0x20, %rcx
0000000100006f74	xorl	%edx, %edx
0000000100006f76	nopw	%cs:(%rax,%rax)
0000000100006f80	movups	0x8(%r15,%rdx), %xmm0
0000000100006f86	movups	0x18(%r15,%rdx), %xmm1
0000000100006f8c	movaps	%xmm0, (%rdi,%rdx)
0000000100006f90	movaps	%xmm1, 0x10(%rdi,%rdx)
0000000100006f95	addq	$0x20, %rdx
0000000100006f99	cmpq	%rdx, %rcx
0000000100006f9c	jne	0x100006f80
0000000100006f9e	cmpl	%r13d, %eax
0000000100006fa1	jne	0x100006ef5
0000000100006fa7	nopw	(%rax,%rax)
0000000100006fb0	subl	%r13d, %r14d
0000000100006fb3	movl	%r14d, -0x34(%rbp)
0000000100006fb7	movl	%r14d, %r14d
0000000100006fba	cmpl	%r13d, %r12d
0000000100006fbd	je	0x100007042
0000000100006fc3	cmpl	$0xd, -0x34(%rbp)
0000000100006fc7	ja	0x100007067
0000000100006fcd	xorl	%eax, %eax
0000000100006fcf	movq	%r14, %rdx
0000000100006fd2	movq	%rax, %rcx
0000000100006fd5	andq	$0x3, %rdx
0000000100006fd9	je	0x100006ff4
0000000100006fdb	movq	%rax, %rcx
0000000100006fde	nop
0000000100006fe0	movq	(%rbx,%rcx,8), %rsi
0000000100006fe4	leal	(%rcx,%r13), %r8d
0000000100006fe8	movq	%rsi, (%rdi,%r8,8)
0000000100006fec	incq	%rcx
0000000100006fef	decq	%rdx
0000000100006ff2	jne	0x100006fe0
0000000100006ff4	subq	%r14, %rax
0000000100006ff7	cmpq	$-0x4, %rax
0000000100006ffb	ja	0x100007042
0000000100006ffd	nopl	(%rax)
0000000100007000	movq	(%rbx,%rcx,8), %rax
0000000100007004	leal	(%rcx,%r13), %edx
0000000100007008	movq	%rax, (%rdi,%rdx,8)
000000010000700c	movq	0x8(%rbx,%rcx,8), %rax
0000000100007011	leal	(%rcx,%r13), %edx
0000000100007015	incl	%edx
0000000100007017	movq	%rax, (%rdi,%rdx,8)
000000010000701b	movq	0x10(%rbx,%rcx,8), %rax
0000000100007020	leal	0x2(%r13,%rcx), %edx
0000000100007025	movq	%rax, (%rdi,%rdx,8)
0000000100007029	movq	0x18(%rbx,%rcx,8), %rax
000000010000702e	leal	(%rcx,%r13), %edx
0000000100007032	addl	$0x3, %edx
0000000100007035	movq	%rax, (%rdi,%rdx,8)
0000000100007039	addq	$0x4, %rcx
000000010000703d	cmpq	%rcx, %r14
0000000100007040	jne	0x100007000
0000000100007042	movq	-0x58(%rbp), %rax
0000000100007046	callq	*0x8(%rax)
0000000100007049	movl	$0x1, %ecx
000000010000704e	movq	-0x40(%rbp), %rsi
0000000100007052	movl	%esi, %edx
0000000100007054	subl	-0x34(%rbp), %edx
0000000100007057	jne	0x100006e10
000000010000705d	movl	%esi, %edx
000000010000705f	movq	%rax, %r14
0000000100007062	jmp	0x100006e1d
0000000100007067	leaq	-0x1(%r14), %rax
000000010000706b	movl	%eax, %ecx
000000010000706d	addl	%r13d, %ecx
0000000100007070	jb	0x100006fcd
0000000100007076	shrq	$0x20, %rax
000000010000707a	movl	$0x0, %eax
000000010000707f	jne	0x100006fcf
0000000100007085	leaq	(%rdi,%r13,8), %rax
0000000100007089	subq	%rbx, %rax
000000010000708c	cmpq	$0x20, %rax
0000000100007090	jb	0x100006fcd
0000000100007096	movl	%r14d, %eax
0000000100007099	andl	$-0x4, %eax
000000010000709c	xorl	%ecx, %ecx
000000010000709e	nop
00000001000070a0	movups	(%rbx,%rcx,8), %xmm0
00000001000070a4	movups	0x10(%rbx,%rcx,8), %xmm1
00000001000070a9	leal	(%rcx,%r13), %edx
00000001000070ad	movups	%xmm0, (%rdi,%rdx,8)
00000001000070b1	movups	%xmm1, 0x10(%rdi,%rdx,8)
00000001000070b6	addq	$0x4, %rcx
00000001000070ba	cmpq	%rcx, %rax
00000001000070bd	jne	0x1000070a0
00000001000070bf	cmpl	%r14d, %eax
00000001000070c2	jne	0x100006fcf
00000001000070c8	jmp	0x100007042
00000001000070cd	movl	%r14d, %eax
00000001000070d0	cmpl	$0x7ff, %r14d                   ## imm = 0x7FF
00000001000070d7	ja	0x100007143
00000001000070d9	leaq	(,%rax,8), %rdx
00000001000070e1	addq	$0x17, %rdx
00000001000070e5	shrq	$0x4, %rdx
00000001000070e9	leaq	_fwp_gc(%rip), %rcx
00000001000070f0	movzbl	0xbe8(%rdx,%rcx), %edx
00000001000070f8	movl	0xb48(%rcx,%rdx,4), %esi
00000001000070ff	subq	%rsi, _fwp_gc(%rip)
0000000100007106	js	0x100007143
0000000100007108	leaq	(%rdx,%rdx,2), %rdx
000000010000710c	leaq	(%rcx,%rdx,8), %rcx
0000000100007110	addq	$0x788, %rcx                    ## imm = 0x788
0000000100007117	movq	(%rcx), %r12
000000010000711a	testq	%r12, %r12
000000010000711d	je	0x100007133
000000010000711f	movq	(%r12), %rax
0000000100007123	notq	%rax
0000000100007126	movq	%rax, (%rcx)
0000000100007129	jmp	0x100007162
000000010000712b	movq	%r15, %r14
000000010000712e	jmp	0x1000072d6
0000000100007133	movq	0x8(%rcx), %r12
0000000100007137	movq	0x10(%rcx), %rdx
000000010000713b	subq	%r12, %rdx
000000010000713e	cmpq	%rsi, %rdx
0000000100007141	jae	0x10000715a
0000000100007143	leaq	0x8(,%rax,8), %rdi
000000010000714b	movl	$0x2, %esi
0000000100007150	callq	_fwp_gc_alloc_slow
0000000100007155	movq	%rax, %r12
0000000100007158	jmp	0x10000716a
000000010000715a	leaq	(%r12,%rsi), %rax
000000010000715e	movq	%rax, 0x8(%rcx)
0000000100007162	movq	%r12, %rdi
0000000100007165	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000716a	movl	(%r15), %eax
000000010000716d	movl	%eax, (%r12)
0000000100007171	movl	%r14d, 0x4(%r12)
0000000100007176	testq	%r13, %r13
0000000100007179	movq	%r12, %r14
000000010000717c	movq	-0x40(%rbp), %rdi
0000000100007180	je	0x100007241
0000000100007186	xorl	%eax, %eax
0000000100007188	cmpl	$0x6, %r13d
000000010000718c	jb	0x1000071d6
000000010000718e	movq	%r14, %rcx
0000000100007191	subq	%r15, %rcx
0000000100007194	cmpq	$0x1f, %rcx
0000000100007198	jbe	0x1000071d6
000000010000719a	movl	%r13d, %eax
000000010000719d	andl	$-0x4, %eax
00000001000071a0	leaq	(,%r13,8), %rcx
00000001000071a8	andq	$-0x20, %rcx
00000001000071ac	xorl	%edx, %edx
00000001000071ae	nop
00000001000071b0	movups	0x8(%r15,%rdx), %xmm0
00000001000071b6	movups	0x18(%r15,%rdx), %xmm1
00000001000071bc	movups	%xmm0, 0x8(%r14,%rdx)
00000001000071c2	movups	%xmm1, 0x18(%r14,%rdx)
00000001000071c8	addq	$0x20, %rdx
00000001000071cc	cmpq	%rdx, %rcx
00000001000071cf	jne	0x1000071b0
00000001000071d1	cmpl	%r13d, %eax
00000001000071d4	je	0x100007241
00000001000071d6	movq	%r13, %rdx
00000001000071d9	movq	%rax, %rcx
00000001000071dc	andq	$0x3, %rdx
00000001000071e0	je	0x100007202
00000001000071e2	movq	%rax, %rcx
00000001000071e5	nopw	%cs:(%rax,%rax)
00000001000071f0	movq	0x8(%r15,%rcx,8), %rsi
00000001000071f5	movq	%rsi, 0x8(%r14,%rcx,8)
00000001000071fa	incq	%rcx
00000001000071fd	decq	%rdx
0000000100007200	jne	0x1000071f0
0000000100007202	subq	%r13, %rax
0000000100007205	cmpq	$-0x4, %rax
0000000100007209	ja	0x100007241
000000010000720b	nopl	(%rax,%rax)
0000000100007210	movq	0x8(%r15,%rcx,8), %rax
0000000100007215	movq	%rax, 0x8(%r14,%rcx,8)
000000010000721a	movq	0x10(%r15,%rcx,8), %rax
000000010000721f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100007224	movq	0x18(%r15,%rcx,8), %rax
0000000100007229	movq	%rax, 0x18(%r14,%rcx,8)
000000010000722e	movq	0x20(%r15,%rcx,8), %rax
0000000100007233	movq	%rax, 0x20(%r14,%rcx,8)
0000000100007238	addq	$0x4, %rcx
000000010000723c	cmpq	%rcx, %r13
000000010000723f	jne	0x100007210
0000000100007241	testl	%edi, %edi
0000000100007243	je	0x1000072d6
0000000100007249	movl	%edi, %eax
000000010000724b	cmpl	$0x13, %edi
000000010000724e	ja	0x1000072f8
0000000100007254	xorl	%ecx, %ecx
0000000100007256	movq	%rax, %rsi
0000000100007259	movq	%rcx, %rdx
000000010000725c	andq	$0x3, %rsi
0000000100007260	je	0x100007285
0000000100007262	movq	%rcx, %rdx
0000000100007265	nopw	%cs:(%rax,%rax)
0000000100007270	movq	(%rbx,%rdx,8), %rdi
0000000100007274	leal	(%rdx,%r13), %r8d
0000000100007278	movq	%rdi, 0x8(%r14,%r8,8)
000000010000727d	incq	%rdx
0000000100007280	decq	%rsi
0000000100007283	jne	0x100007270
0000000100007285	subq	%rax, %rcx
0000000100007288	cmpq	$-0x4, %rcx
000000010000728c	ja	0x1000072d6
000000010000728e	nop
0000000100007290	movq	(%rbx,%rdx,8), %rcx
0000000100007294	leal	(%rdx,%r13), %esi
0000000100007298	movq	%rcx, 0x8(%r14,%rsi,8)
000000010000729d	movq	0x8(%rbx,%rdx,8), %rcx
00000001000072a2	leal	(%rdx,%r13), %esi
00000001000072a6	incl	%esi
00000001000072a8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000072ad	movq	0x10(%rbx,%rdx,8), %rcx
00000001000072b2	leal	0x2(%r13,%rdx), %esi
00000001000072b7	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000072bc	movq	0x18(%rbx,%rdx,8), %rcx
00000001000072c1	leal	(%rdx,%r13), %esi
00000001000072c5	addl	$0x3, %esi
00000001000072c8	movq	%rcx, 0x8(%r14,%rsi,8)
00000001000072cd	addq	$0x4, %rdx
00000001000072d1	cmpq	%rdx, %rax
00000001000072d4	jne	0x100007290
00000001000072d6	movq	0xbd53(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000072dd	movq	(%rax), %rax
00000001000072e0	cmpq	-0x30(%rbp), %rax
00000001000072e4	jne	0x10000735f
00000001000072e6	movq	%r14, %rax
00000001000072e9	leaq	-0x28(%rbp), %rsp
00000001000072ed	popq	%rbx
00000001000072ee	popq	%r12
00000001000072f0	popq	%r13
00000001000072f2	popq	%r14
00000001000072f4	popq	%r15
00000001000072f6	popq	%rbp
00000001000072f7	retq
00000001000072f8	leaq	-0x1(%rax), %rdx
00000001000072fc	xorl	%ecx, %ecx
00000001000072fe	movl	%edx, %esi
0000000100007300	addl	%r13d, %esi
0000000100007303	jb	0x100007256
0000000100007309	shrq	$0x20, %rdx
000000010000730d	jne	0x100007256
0000000100007313	leaq	(%r14,%r13,8), %rcx
0000000100007317	subq	%rbx, %rcx
000000010000731a	addq	$0x8, %rcx
000000010000731e	cmpq	$0x20, %rcx
0000000100007322	jb	0x100007254
0000000100007328	movl	%eax, %ecx
000000010000732a	andl	$-0x4, %ecx
000000010000732d	xorl	%edx, %edx
000000010000732f	nop
0000000100007330	movups	(%rbx,%rdx,8), %xmm0
0000000100007334	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100007339	leal	(%rdx,%r13), %esi
000000010000733d	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100007343	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100007349	addq	$0x4, %rdx
000000010000734d	cmpq	%rdx, %rcx
0000000100007350	jne	0x100007330
0000000100007352	cmpl	%eax, %ecx
0000000100007354	jne	0x100007256
000000010000735a	jmp	0x1000072d6
000000010000735f	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100007364	nopw	%cs:(%rax,%rax)
_fwp_apply_release:
0000000100007370	pushq	%rbp
0000000100007371	movq	%rsp, %rbp
0000000100007374	pushq	%r14
0000000100007376	pushq	%rbx
0000000100007377	movq	(%rdi), %rbx
000000010000737a	movq	$0x0, (%rdi)
0000000100007381	movl	0x20(%rdi), %eax
0000000100007384	movl	0x18(%rdi), %ecx
0000000100007387	movl	%eax, %edx
0000000100007389	subl	%ecx, %edx
000000010000738b	je	0x1000073ba
000000010000738d	movq	0x10(%rdi), %rsi
0000000100007391	movq	0x18(%rsi), %r8
0000000100007395	testq	%r8, %r8
0000000100007398	je	0x1000073ba
000000010000739a	movq	%rcx, %rax
000000010000739d	shlq	$0x3, %rax
00000001000073a1	addq	0x8(%rdi), %rax
00000001000073a5	movl	0x1c(%rdi), %esi
00000001000073a8	addl	%ecx, %esi
00000001000073aa	movq	%rdi, %r14
00000001000073ad	movq	%rax, %rdi
00000001000073b0	callq	*%r8
00000001000073b3	movq	%r14, %rdi
00000001000073b6	movl	0x20(%r14), %eax
00000001000073ba	movl	%eax, 0x18(%rdi)
00000001000073bd	testq	%rbx, %rbx
00000001000073c0	je	0x1000073ce
00000001000073c2	movq	%rbx, %rdi
00000001000073c5	popq	%rbx
00000001000073c6	popq	%r14
00000001000073c8	popq	%rbp
00000001000073c9	jmp	_fwp_closure_drop
00000001000073ce	popq	%rbx
00000001000073cf	popq	%r14
00000001000073d1	popq	%rbp
00000001000073d2	retq
00000001000073d3	nopw	%cs:(%rax,%rax)
_fwp_apply_owned:
00000001000073e0	pushq	%rbp
00000001000073e1	movq	%rsp, %rbp
00000001000073e4	pushq	%r15
00000001000073e6	pushq	%r14
00000001000073e8	pushq	%r13
00000001000073ea	pushq	%r12
00000001000073ec	pushq	%rbx
00000001000073ed	subq	$0xa8, %rsp
00000001000073f4	movq	%rdx, %rbx
00000001000073f7	movl	%esi, %r13d
00000001000073fa	movq	0xbc2f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007401	movq	(%rax), %rax
0000000100007404	movq	%rax, -0x30(%rbp)
0000000100007408	movq	_fwp_fns(%rip), %rdx
000000010000740f	movl	(%rdi), %esi
0000000100007411	shlq	$0x5, %rsi
0000000100007415	movq	0x18(%rdx,%rsi), %rax
000000010000741a	testq	%rax, %rax
000000010000741d	je	0x100007836
0000000100007423	leaq	(%rdx,%rsi), %rcx
0000000100007427	addq	%rdx, %rsi
000000010000742a	addq	$0x18, %rsi
000000010000742e	movq	%rdi, %r12
0000000100007431	nopw	%cs:(%rax,%rax)
0000000100007440	movq	%rsi, -0x58(%rbp)
0000000100007444	movl	(%rcx), %r14d
0000000100007447	movl	0x4(%r12), %r15d
000000010000744c	movq	%rdi, -0xb0(%rbp)
0000000100007453	movq	%rbx, -0xa8(%rbp)
000000010000745a	movq	%rax, -0xa0(%rbp)
0000000100007461	movl	$0x0, -0x98(%rbp)
000000010000746b	movl	%r15d, -0x94(%rbp)
0000000100007472	movq	%rdi, %rcx
0000000100007475	subq	0xdbbc(%rip), %rcx
000000010000747c	movl	%r13d, -0x90(%rbp)
0000000100007483	movq	0xdbd6(%rip), %rdx
000000010000748a	shlq	$0x10, %rdx
000000010000748e	cmpq	%rdx, %rcx
0000000100007491	jae	0x100007500
0000000100007493	movq	0xdbe6(%rip), %rsi
000000010000749a	movq	%rcx, %rdx
000000010000749d	shrq	$0x10, %rdx
00000001000074a1	imulq	$0x1228, %rdx, %r8              ## imm = 0x1228
00000001000074a8	leaq	(%rsi,%r8), %rdx
00000001000074ac	movzbl	(%rsi,%r8), %esi
00000001000074b1	cmpb	$0x2, %sil
00000001000074b5	setne	%r9b
00000001000074b9	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000074c0	setne	%r8b
00000001000074c4	orb	%r9b, %r8b
00000001000074c7	jne	0x1000074e0
00000001000074c9	addq	$0x228, %rdx                    ## imm = 0x228
00000001000074d0	cmpb	$0x0, (%rdx)
00000001000074d3	jne	0x100007520
00000001000074d5	jmp	0x100007500
00000001000074d7	nopw	(%rax,%rax)
00000001000074e0	cmpb	$0x1, %sil
00000001000074e4	jne	0x100007500
00000001000074e6	movl	0x20(%rdx), %esi
00000001000074e9	imulq	%rsi, %rcx
00000001000074ed	shrq	$0x20, %rcx
00000001000074f1	addq	%rcx, %rdx
00000001000074f4	addq	$0x228, %rdx                    ## imm = 0x228
00000001000074fb	cmpb	$0x0, (%rdx)
00000001000074fe	jne	0x100007520
0000000100007500	cmpq	$0x0, 0x18(%rax)
0000000100007505	je	0x100007511
0000000100007507	testq	%r15, %r15
000000010000750a	jne	0x100007520
000000010000750c	cmpl	%r14d, %r13d
000000010000750f	jne	0x100007520
0000000100007511	xorl	%ecx, %ecx
0000000100007513	jmp	0x10000754e
0000000100007515	nopw	%cs:(%rax,%rax)
0000000100007520	movq	_fwp_cleanups(%rip), %rcx
0000000100007527	movq	%rcx, -0x80(%rbp)
000000010000752b	leaq	_fwp_apply_release(%rip), %rcx
0000000100007532	movq	%rcx, -0x78(%rbp)
0000000100007536	leaq	-0xb0(%rbp), %rcx
000000010000753d	movq	%rcx, -0x70(%rbp)
0000000100007541	leaq	-0x80(%rbp), %rcx
0000000100007545	movq	%rcx, _fwp_cleanups(%rip)
000000010000754c	movb	$0x1, %cl
000000010000754e	movq	%r13, -0x50(%rbp)
0000000100007552	addl	%r15d, %r13d
0000000100007555	cmpl	%r14d, %r13d
0000000100007558	movq	%rdi, -0x40(%rbp)
000000010000755c	movl	%ecx, -0x44(%rbp)
000000010000755f	jb	0x100007877
0000000100007565	movl	%r14d, %ecx
0000000100007568	subl	%r15d, %ecx
000000010000756b	movl	%ecx, -0x34(%rbp)
000000010000756e	movl	%ecx, %ecx
0000000100007570	movq	%rcx, -0x60(%rbp)
0000000100007574	testq	%r15, %r15
0000000100007577	jne	0x1000075a0
0000000100007579	testl	%r14d, %r14d
000000010000757c	je	0x1000075a0
000000010000757e	movl	-0x34(%rbp), %r15d
0000000100007582	movl	%r15d, -0x98(%rbp)
0000000100007589	movq	%rbx, %rdi
000000010000758c	callq	*(%rax)
000000010000758e	movq	%rax, %r12
0000000100007591	jmp	0x1000077c8
0000000100007596	nopw	%cs:(%rax,%rax)
00000001000075a0	movq	%rsp, -0x88(%rbp)
00000001000075a7	testl	%r14d, %r14d
00000001000075aa	movl	$0x1, %eax
00000001000075af	cmovnel	%r14d, %eax
00000001000075b3	shlq	$0x3, %rax
00000001000075b7	callq	0x100011168                     ## symbol stub for: ____chkstk_darwin
00000001000075bc	addq	$0xf, %rax
00000001000075c0	andq	$-0x10, %rax
00000001000075c4	subq	%rax, %rsp
00000001000075c7	movq	%rsp, %r13
00000001000075ca	testq	%r15, %r15
00000001000075cd	movq	-0x40(%rbp), %rdi
00000001000075d1	je	0x1000076a0
00000001000075d7	cmpl	$0x3, %r15d
00000001000075db	jbe	0x1000075ed
00000001000075dd	movq	%r13, %rax
00000001000075e0	subq	%r12, %rax
00000001000075e3	addq	$-0x8, %rax
00000001000075e7	cmpq	$0x20, %rax
00000001000075eb	jae	0x100007653
00000001000075ed	xorl	%eax, %eax
00000001000075ef	movq	%r15, %rdx
00000001000075f2	movq	%rax, %rcx
00000001000075f5	andq	$0x3, %rdx
00000001000075f9	je	0x100007612
00000001000075fb	movq	%rax, %rcx
00000001000075fe	nop
0000000100007600	movq	0x8(%r12,%rcx,8), %rsi
0000000100007605	movq	%rsi, (%r13,%rcx,8)
000000010000760a	incq	%rcx
000000010000760d	decq	%rdx
0000000100007610	jne	0x100007600
0000000100007612	subq	%r15, %rax
0000000100007615	cmpq	$-0x4, %rax
0000000100007619	ja	0x1000076a0
000000010000761f	nop
0000000100007620	movq	0x8(%r12,%rcx,8), %rax
0000000100007625	movq	%rax, (%r13,%rcx,8)
000000010000762a	movq	0x10(%r12,%rcx,8), %rax
000000010000762f	movq	%rax, 0x8(%r13,%rcx,8)
0000000100007634	movq	0x18(%r12,%rcx,8), %rax
0000000100007639	movq	%rax, 0x10(%r13,%rcx,8)
000000010000763e	movq	0x20(%r12,%rcx,8), %rax
0000000100007643	movq	%rax, 0x18(%r13,%rcx,8)
0000000100007648	addq	$0x4, %rcx
000000010000764c	cmpq	%rcx, %r15
000000010000764f	jne	0x100007620
0000000100007651	jmp	0x1000076a0
0000000100007653	movl	%r15d, %eax
0000000100007656	andl	$-0x4, %eax
0000000100007659	leaq	(,%r15,8), %rcx
0000000100007661	andq	$-0x20, %rcx
0000000100007665	xorl	%edx, %edx
0000000100007667	nopw	(%rax,%rax)
0000000100007670	movups	0x8(%r12,%rdx), %xmm0
0000000100007676	movups	0x18(%r12,%rdx), %xmm1
000000010000767c	movaps	%xmm0, (%r13,%rdx)
0000000100007682	movaps	%xmm1, 0x10(%r13,%rdx)
0000000100007688	addq	$0x20, %rdx
000000010000768c	cmpq	%rdx, %rcx
000000010000768f	jne	0x100007670
0000000100007691	cmpl	%r15d, %eax
0000000100007694	jne	0x1000075ef
000000010000769a	nopw	(%rax,%rax)
00000001000076a0	cmpl	%r15d, %r14d
00000001000076a3	movq	-0x58(%rbp), %r14
00000001000076a7	movq	-0x60(%rbp), %r9
00000001000076ab	je	0x1000077a0
00000001000076b1	cmpl	$0x9, -0x34(%rbp)
00000001000076b5	ja	0x100007748
00000001000076bb	xorl	%eax, %eax
00000001000076bd	movq	%r9, %rdx
00000001000076c0	movq	%rax, %rcx
00000001000076c3	andq	$0x3, %rdx
00000001000076c7	je	0x1000076e5
00000001000076c9	movq	%rax, %rcx
00000001000076cc	nopl	(%rax)
00000001000076d0	movq	(%rbx,%rcx,8), %rsi
00000001000076d4	leal	(%r15,%rcx), %r8d
00000001000076d8	movq	%rsi, (%r13,%r8,8)
00000001000076dd	incq	%rcx
00000001000076e0	decq	%rdx
00000001000076e3	jne	0x1000076d0
00000001000076e5	subq	%r9, %rax
00000001000076e8	cmpq	$-0x4, %rax
00000001000076ec	ja	0x1000077a0
00000001000076f2	nopw	%cs:(%rax,%rax)
0000000100007700	movq	(%rbx,%rcx,8), %rax
0000000100007704	leal	(%r15,%rcx), %edx
0000000100007708	movq	%rax, (%r13,%rdx,8)
000000010000770d	movq	0x8(%rbx,%rcx,8), %rax
0000000100007712	leal	(%r15,%rcx), %edx
0000000100007716	incl	%edx
0000000100007718	movq	%rax, (%r13,%rdx,8)
000000010000771d	movq	0x10(%rbx,%rcx,8), %rax
0000000100007722	leal	0x2(%r15,%rcx), %edx
0000000100007727	movq	%rax, (%r13,%rdx,8)
000000010000772c	movq	0x18(%rbx,%rcx,8), %rax
0000000100007731	leal	(%r15,%rcx), %edx
0000000100007735	addl	$0x3, %edx
0000000100007738	movq	%rax, (%r13,%rdx,8)
000000010000773d	addq	$0x4, %rcx
0000000100007741	cmpq	%rcx, %r9
0000000100007744	jne	0x100007700
0000000100007746	jmp	0x1000077a0
0000000100007748	leaq	-0x1(%r9), %rax
000000010000774c	movl	%eax, %ecx
000000010000774e	addl	%r15d, %ecx
0000000100007751	jb	0x1000076bb
0000000100007757	shrq	$0x20, %rax
000000010000775b	movl	$0x0, %eax
0000000100007760	jne	0x1000076bd
0000000100007766	movl	%r9d, %eax
0000000100007769	andl	$-0x4, %eax
000000010000776c	xorl	%ecx, %ecx
000000010000776e	nop
0000000100007770	movups	(%rbx,%rcx,8), %xmm0
0000000100007774	movups	0x10(%rbx,%rcx,8), %xmm1
0000000100007779	leal	(%r15,%rcx), %edx
000000010000777d	movups	%xmm0, (%r13,%rdx,8)
0000000100007783	movups	%xmm1, 0x10(%r13,%rdx,8)
0000000100007789	addq	$0x4, %rcx
000000010000778d	cmpq	%rcx, %rax
0000000100007790	jne	0x100007770
0000000100007792	cmpl	%r9d, %eax
0000000100007795	jne	0x1000076bd
000000010000779b	nopl	(%rax,%rax)
00000001000077a0	movq	(%r14), %rax
00000001000077a3	movl	$0x1, %esi
00000001000077a8	callq	*0x8(%rax)
00000001000077ab	movl	-0x34(%rbp), %r15d
00000001000077af	movl	%r15d, -0x98(%rbp)
00000001000077b6	movq	(%r14), %rax
00000001000077b9	movq	%r13, %rdi
00000001000077bc	callq	*(%rax)
00000001000077be	movq	%rax, %r12
00000001000077c1	movq	-0x88(%rbp), %rsp
00000001000077c8	cmpb	$0x0, -0x44(%rbp)
00000001000077cc	movq	-0x50(%rbp), %r13
00000001000077d0	movq	-0x40(%rbp), %rdi
00000001000077d4	je	0x1000077f2
00000001000077d6	leaq	-0x80(%rbp), %rax
00000001000077da	cmpq	%rax, _fwp_cleanups(%rip)
00000001000077e1	jne	0x100007c54
00000001000077e7	movq	-0x80(%rbp), %rax
00000001000077eb	movq	%rax, _fwp_cleanups(%rip)
00000001000077f2	callq	_fwp_closure_drop
00000001000077f7	subl	%r15d, %r13d
00000001000077fa	je	0x100007c32
0000000100007800	movq	-0x60(%rbp), %rax
0000000100007804	leaq	(%rbx,%rax,8), %rbx
0000000100007808	movq	_fwp_fns(%rip), %rax
000000010000780f	movl	(%r12), %edx
0000000100007813	shlq	$0x5, %rdx
0000000100007817	leaq	(%rax,%rdx), %rcx
000000010000781b	leaq	(%rax,%rdx), %rsi
000000010000781f	addq	$0x18, %rsi
0000000100007823	movq	0x18(%rax,%rdx), %rax
0000000100007828	movq	%r12, %rdi
000000010000782b	testq	%rax, %rax
000000010000782e	jne	0x100007440
0000000100007834	jmp	0x100007839
0000000100007836	movq	%rdi, %r12
0000000100007839	movq	%r12, %rdi
000000010000783c	callq	_fwp_rc_share
0000000100007841	testl	%r13d, %r13d
0000000100007844	je	0x100007861
0000000100007846	movl	%r13d, %r14d
0000000100007849	xorl	%r15d, %r15d
000000010000784c	nopl	(%rax)
0000000100007850	movq	(%rbx,%r15,8), %rdi
0000000100007854	callq	_fwp_rc_share
0000000100007859	incq	%r15
000000010000785c	cmpq	%r15, %r14
000000010000785f	jne	0x100007850
0000000100007861	movq	%r12, %rdi
0000000100007864	movl	%r13d, %esi
0000000100007867	movq	%rbx, %rdx
000000010000786a	callq	_fwp_apply
000000010000786f	movq	%rax, %r12
0000000100007872	jmp	0x100007c32
0000000100007877	movl	%r13d, %eax
000000010000787a	leaq	0x8(,%rax,8), %rdi
0000000100007882	callq	_fwp_alloc_init
0000000100007887	movq	-0x40(%rbp), %rdi
000000010000788b	movq	%rax, %r14
000000010000788e	movl	(%r12), %eax
0000000100007892	movl	%eax, (%r14)
0000000100007895	movl	%r13d, 0x4(%r14)
0000000100007899	movq	%r14, %rax
000000010000789c	subq	0xd795(%rip), %rax
00000001000078a3	movq	0xd7b6(%rip), %rcx
00000001000078aa	shlq	$0x10, %rcx
00000001000078ae	cmpq	%rcx, %rax
00000001000078b1	jae	0x10000792a
00000001000078b3	movq	0xd7c6(%rip), %rcx
00000001000078ba	movq	%rax, %rdx
00000001000078bd	shrq	$0x10, %rdx
00000001000078c1	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000078c8	leaq	(%rcx,%rdx), %r13
00000001000078cc	movzbl	(%rcx,%rdx), %ecx
00000001000078d0	cmpb	$0x2, %cl
00000001000078d3	setne	%dl
00000001000078d6	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000078dc	setne	%sil
00000001000078e0	orb	%dl, %sil
00000001000078e3	jne	0x1000078fa
00000001000078e5	addq	$0x228, %r13                    ## imm = 0x228
00000001000078ec	cmpb	$-0x1, (%r13)
00000001000078f1	je	0x10000791c
00000001000078f3	movb	$0x1, (%r13)
00000001000078f8	jmp	0x10000792a
00000001000078fa	cmpb	$0x1, %cl
00000001000078fd	jne	0x10000792a
00000001000078ff	movl	0x20(%r13), %ecx
0000000100007903	imulq	%rcx, %rax
0000000100007907	shrq	$0x20, %rax
000000010000790b	addq	%rax, %r13
000000010000790e	addq	$0x228, %r13                    ## imm = 0x228
0000000100007915	cmpb	$-0x1, (%r13)
000000010000791a	jne	0x1000078f3
000000010000791c	movq	%r13, %rdi
000000010000791f	callq	_fwp_rc_forget_slot
0000000100007924	movq	-0x40(%rbp), %rdi
0000000100007928	jmp	0x1000078f3
000000010000792a	movq	%r14, -0x68(%rbp)
000000010000792e	movq	_fwp_cleanups(%rip), %rax
0000000100007935	movq	%rax, -0xc8(%rbp)
000000010000793c	leaq	_fwp_rc_cleanup_cell(%rip), %rax
0000000100007943	movq	%rax, -0xc0(%rbp)
000000010000794a	leaq	-0x68(%rbp), %rax
000000010000794e	movq	%rax, -0xb8(%rbp)
0000000100007955	leaq	-0xc8(%rbp), %r13
000000010000795c	movq	%r13, _fwp_cleanups(%rip)
0000000100007963	testq	%r15, %r15
0000000100007966	je	0x100007a31
000000010000796c	xorl	%eax, %eax
000000010000796e	cmpl	$0x6, %r15d
0000000100007972	jb	0x1000079c6
0000000100007974	movq	%r14, %rcx
0000000100007977	subq	%r12, %rcx
000000010000797a	cmpq	$0x1f, %rcx
000000010000797e	jbe	0x1000079c6
0000000100007980	movl	%r15d, %eax
0000000100007983	andl	$-0x4, %eax
0000000100007986	leaq	(,%r15,8), %rcx
000000010000798e	andq	$-0x20, %rcx
0000000100007992	xorl	%edx, %edx
0000000100007994	nopw	%cs:(%rax,%rax)
00000001000079a0	movups	0x8(%r12,%rdx), %xmm0
00000001000079a6	movups	0x18(%r12,%rdx), %xmm1
00000001000079ac	movups	%xmm0, 0x8(%r14,%rdx)
00000001000079b2	movups	%xmm1, 0x18(%r14,%rdx)
00000001000079b8	addq	$0x20, %rdx
00000001000079bc	cmpq	%rdx, %rcx
00000001000079bf	jne	0x1000079a0
00000001000079c1	cmpl	%r15d, %eax
00000001000079c4	je	0x100007a31
00000001000079c6	movq	%r15, %rdx
00000001000079c9	movq	%rax, %rcx
00000001000079cc	andq	$0x3, %rdx
00000001000079d0	je	0x1000079f2
00000001000079d2	movq	%rax, %rcx
00000001000079d5	nopw	%cs:(%rax,%rax)
00000001000079e0	movq	0x8(%r12,%rcx,8), %rsi
00000001000079e5	movq	%rsi, 0x8(%r14,%rcx,8)
00000001000079ea	incq	%rcx
00000001000079ed	decq	%rdx
00000001000079f0	jne	0x1000079e0
00000001000079f2	subq	%r15, %rax
00000001000079f5	cmpq	$-0x4, %rax
00000001000079f9	ja	0x100007a31
00000001000079fb	nopl	(%rax,%rax)
0000000100007a00	movq	0x8(%r12,%rcx,8), %rax
0000000100007a05	movq	%rax, 0x8(%r14,%rcx,8)
0000000100007a0a	movq	0x10(%r12,%rcx,8), %rax
0000000100007a0f	movq	%rax, 0x10(%r14,%rcx,8)
0000000100007a14	movq	0x18(%r12,%rcx,8), %rax
0000000100007a19	movq	%rax, 0x18(%r14,%rcx,8)
0000000100007a1e	movq	0x20(%r12,%rcx,8), %rax
0000000100007a23	movq	%rax, 0x20(%r14,%rcx,8)
0000000100007a28	addq	$0x4, %rcx
0000000100007a2c	cmpq	%rcx, %r15
0000000100007a2f	jne	0x100007a00
0000000100007a31	cmpl	$0x0, -0x50(%rbp)
0000000100007a35	je	0x100007ac6
0000000100007a3b	movq	-0x50(%rbp), %rcx
0000000100007a3f	movl	%ecx, %eax
0000000100007a41	cmpl	$0x13, %ecx
0000000100007a44	ja	0x100007b45
0000000100007a4a	xorl	%ecx, %ecx
0000000100007a4c	movq	%rax, %rsi
0000000100007a4f	movq	%rcx, %rdx
0000000100007a52	andq	$0x3, %rsi
0000000100007a56	je	0x100007a75
0000000100007a58	movq	%rcx, %rdx
0000000100007a5b	nopl	(%rax,%rax)
0000000100007a60	movq	(%rbx,%rdx,8), %r9
0000000100007a64	leal	(%r15,%rdx), %r8d
0000000100007a68	movq	%r9, 0x8(%r14,%r8,8)
0000000100007a6d	incq	%rdx
0000000100007a70	decq	%rsi
0000000100007a73	jne	0x100007a60
0000000100007a75	subq	%rax, %rcx
0000000100007a78	cmpq	$-0x4, %rcx
0000000100007a7c	ja	0x100007ac6
0000000100007a7e	nop
0000000100007a80	movq	(%rbx,%rdx,8), %rcx
0000000100007a84	leal	(%r15,%rdx), %esi
0000000100007a88	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007a8d	movq	0x8(%rbx,%rdx,8), %rcx
0000000100007a92	leal	(%r15,%rdx), %esi
0000000100007a96	incl	%esi
0000000100007a98	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007a9d	movq	0x10(%rbx,%rdx,8), %rcx
0000000100007aa2	leal	0x2(%r15,%rdx), %esi
0000000100007aa7	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007aac	movq	0x18(%rbx,%rdx,8), %rcx
0000000100007ab1	leal	(%r15,%rdx), %esi
0000000100007ab5	addl	$0x3, %esi
0000000100007ab8	movq	%rcx, 0x8(%r14,%rsi,8)
0000000100007abd	addq	$0x4, %rdx
0000000100007ac1	cmpq	%rdx, %rax
0000000100007ac4	jne	0x100007a80
0000000100007ac6	movq	-0x58(%rbp), %rax
0000000100007aca	movq	(%rax), %rax
0000000100007acd	movl	$0x1, %esi
0000000100007ad2	callq	*0x8(%rax)
0000000100007ad5	movq	%r14, %rax
0000000100007ad8	subq	0xd559(%rip), %rax
0000000100007adf	movq	0xd57a(%rip), %rcx
0000000100007ae6	shlq	$0x10, %rcx
0000000100007aea	cmpq	%rcx, %rax
0000000100007aed	jae	0x100007be3
0000000100007af3	movq	0xd586(%rip), %rcx
0000000100007afa	movq	%rax, %rdx
0000000100007afd	shrq	$0x10, %rdx
0000000100007b01	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100007b08	leaq	(%rcx,%rdx), %r12
0000000100007b0c	movzbl	(%rcx,%rdx), %ecx
0000000100007b10	cmpb	$0x2, %cl
0000000100007b13	setne	%dl
0000000100007b16	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007b1c	setne	%sil
0000000100007b20	orb	%dl, %sil
0000000100007b23	jne	0x100007baf
0000000100007b29	addq	$0x228, %r12                    ## imm = 0x228
0000000100007b30	cmpb	$-0x1, (%r12)
0000000100007b35	je	0x100007bd6
0000000100007b3b	movb	$0x1, (%r12)
0000000100007b40	jmp	0x100007be3
0000000100007b45	leaq	-0x1(%rax), %rdx
0000000100007b49	xorl	%ecx, %ecx
0000000100007b4b	movl	%edx, %esi
0000000100007b4d	addl	%r15d, %esi
0000000100007b50	jb	0x100007a4c
0000000100007b56	shrq	$0x20, %rdx
0000000100007b5a	jne	0x100007a4c
0000000100007b60	leaq	(%r14,%r15,8), %rcx
0000000100007b64	subq	%rbx, %rcx
0000000100007b67	addq	$0x8, %rcx
0000000100007b6b	cmpq	$0x20, %rcx
0000000100007b6f	jb	0x100007a4a
0000000100007b75	movl	%eax, %ecx
0000000100007b77	andl	$-0x4, %ecx
0000000100007b7a	xorl	%edx, %edx
0000000100007b7c	nopl	(%rax)
0000000100007b80	movups	(%rbx,%rdx,8), %xmm0
0000000100007b84	movups	0x10(%rbx,%rdx,8), %xmm1
0000000100007b89	leal	(%r15,%rdx), %esi
0000000100007b8d	movups	%xmm0, 0x8(%r14,%rsi,8)
0000000100007b93	movups	%xmm1, 0x18(%r14,%rsi,8)
0000000100007b99	addq	$0x4, %rdx
0000000100007b9d	cmpq	%rdx, %rcx
0000000100007ba0	jne	0x100007b80
0000000100007ba2	cmpl	%eax, %ecx
0000000100007ba4	jne	0x100007a4c
0000000100007baa	jmp	0x100007ac6
0000000100007baf	cmpb	$0x1, %cl
0000000100007bb2	jne	0x100007be3
0000000100007bb4	movl	0x20(%r12), %ecx
0000000100007bb9	imulq	%rcx, %rax
0000000100007bbd	shrq	$0x20, %rax
0000000100007bc1	addq	%rax, %r12
0000000100007bc4	addq	$0x228, %r12                    ## imm = 0x228
0000000100007bcb	cmpb	$-0x1, (%r12)
0000000100007bd0	jne	0x100007b3b
0000000100007bd6	movq	%r12, %rdi
0000000100007bd9	callq	_fwp_rc_forget_slot
0000000100007bde	jmp	0x100007b3b
0000000100007be3	movq	-0x50(%rbp), %rax
0000000100007be7	movl	%eax, -0x98(%rbp)
0000000100007bed	movq	$0x0, -0x68(%rbp)
0000000100007bf5	cmpq	%r13, _fwp_cleanups(%rip)
0000000100007bfc	jne	0x100007c54
0000000100007bfe	movq	-0xc8(%rbp), %rax
0000000100007c05	movq	%rax, _fwp_cleanups(%rip)
0000000100007c0c	cmpb	$0x0, -0x44(%rbp)
0000000100007c10	movq	-0x40(%rbp), %rdi
0000000100007c14	je	0x100007c2a
0000000100007c16	leaq	-0x80(%rbp), %rcx
0000000100007c1a	cmpq	%rcx, %rax
0000000100007c1d	jne	0x100007c54
0000000100007c1f	movq	-0x80(%rbp), %rax
0000000100007c23	movq	%rax, _fwp_cleanups(%rip)
0000000100007c2a	callq	_fwp_closure_drop
0000000100007c2f	movq	%r14, %r12
0000000100007c32	movq	0xb3f7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100007c39	movq	(%rax), %rax
0000000100007c3c	cmpq	-0x30(%rbp), %rax
0000000100007c40	jne	0x100007c59
0000000100007c42	movq	%r12, %rax
0000000100007c45	leaq	-0x28(%rbp), %rsp
0000000100007c49	popq	%rbx
0000000100007c4a	popq	%r12
0000000100007c4c	popq	%r13
0000000100007c4e	popq	%r14
0000000100007c50	popq	%r15
0000000100007c52	popq	%rbp
0000000100007c53	retq
0000000100007c54	callq	0x1000111aa                     ## symbol stub for: _abort
0000000100007c59	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100007c5e	nop
_fwp_alloc:
0000000100007c60	pushq	%rbp
0000000100007c61	movq	%rsp, %rbp
0000000100007c64	pushq	%rbx
0000000100007c65	pushq	%rax
0000000100007c66	cmpq	$0x4000, %rdi                   ## imm = 0x4000
0000000100007c6d	ja	0x100007cc7
0000000100007c6f	leaq	0xf(%rdi), %rcx
0000000100007c73	shrq	$0x4, %rcx
0000000100007c77	leaq	_fwp_gc(%rip), %rax
0000000100007c7e	movzbl	0xbe8(%rcx,%rax), %ecx
0000000100007c86	movl	0xb48(%rax,%rcx,4), %esi
0000000100007c8d	subq	%rsi, _fwp_gc(%rip)
0000000100007c94	js	0x100007cc7
0000000100007c96	leaq	(%rcx,%rcx,2), %rcx
0000000100007c9a	leaq	(%rax,%rcx,8), %rax
0000000100007c9e	addq	$0x788, %rax                    ## imm = 0x788
0000000100007ca4	movq	(%rax), %rbx
0000000100007ca7	testq	%rbx, %rbx
0000000100007caa	je	0x100007cb7
0000000100007cac	movq	(%rbx), %rcx
0000000100007caf	notq	%rcx
0000000100007cb2	movq	%rcx, (%rax)
0000000100007cb5	jmp	0x100007cdf
0000000100007cb7	movq	0x8(%rax), %rbx
0000000100007cbb	movq	0x10(%rax), %rcx
0000000100007cbf	subq	%rbx, %rcx
0000000100007cc2	cmpq	%rsi, %rcx
0000000100007cc5	jae	0x100007cd7
0000000100007cc7	movl	$0x2, %esi
0000000100007ccc	addq	$0x8, %rsp
0000000100007cd0	popq	%rbx
0000000100007cd1	popq	%rbp
0000000100007cd2	jmp	_fwp_gc_alloc_slow
0000000100007cd7	leaq	(%rbx,%rsi), %rcx
0000000100007cdb	movq	%rcx, 0x8(%rax)
0000000100007cdf	movq	%rbx, %rdi
0000000100007ce2	callq	0x10001116e                     ## symbol stub for: ___bzero
0000000100007ce7	movq	%rbx, %rax
0000000100007cea	addq	$0x8, %rsp
0000000100007cee	popq	%rbx
0000000100007cef	popq	%rbp
0000000100007cf0	retq
0000000100007cf1	nopw	%cs:(%rax,%rax)
_fwp_closure_drop:
0000000100007d00	pushq	%rbp
0000000100007d01	movq	%rsp, %rbp
0000000100007d04	pushq	%r15
0000000100007d06	pushq	%r14
0000000100007d08	pushq	%rbx
0000000100007d09	subq	$0x238, %rsp                    ## imm = 0x238
0000000100007d10	movq	%rdi, %rax
0000000100007d13	subq	0xd31e(%rip), %rax
0000000100007d1a	movq	0xd33f(%rip), %rcx
0000000100007d21	shlq	$0x10, %rcx
0000000100007d25	cmpq	%rcx, %rax
0000000100007d28	jae	0x100007dc4
0000000100007d2e	movq	%rdi, %rsi
0000000100007d31	movq	0xd348(%rip), %rcx
0000000100007d38	movq	%rax, %rdx
0000000100007d3b	shrq	$0x10, %rdx
0000000100007d3f	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100007d46	leaq	(%rcx,%rdx), %rdi
0000000100007d4a	movzbl	(%rcx,%rdx), %ecx
0000000100007d4e	cmpb	$0x2, %cl
0000000100007d51	setne	%dl
0000000100007d54	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100007d5a	setne	%r8b
0000000100007d5e	orb	%dl, %r8b
0000000100007d61	jne	0x100007d6c
0000000100007d63	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007d6a	jmp	0x100007d86
0000000100007d6c	cmpb	$0x1, %cl
0000000100007d6f	jne	0x100007dc4
0000000100007d71	movl	0x20(%rdi), %ecx
0000000100007d74	imulq	%rcx, %rax
0000000100007d78	shrq	$0x20, %rax
0000000100007d7c	addq	%rax, %rdi
0000000100007d7f	addq	$0x228, %rdi                    ## imm = 0x228
0000000100007d86	movzbl	(%rdi), %eax
0000000100007d89	testl	%eax, %eax
0000000100007d8b	je	0x100007dc4
0000000100007d8d	cmpl	$0x1, %eax
0000000100007d90	jne	0x100007db5
0000000100007d92	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100007d99	callq	*(%rdi)
0000000100007d9b	movq	(%rax), %rdi
0000000100007d9e	testq	%rdi, %rdi
0000000100007da1	je	0x100007dd2
0000000100007da3	addq	$0x238, %rsp                    ## imm = 0x238
0000000100007daa	popq	%rbx
0000000100007dab	popq	%r14
0000000100007dad	popq	%r15
0000000100007daf	popq	%rbp
0000000100007db0	jmp	_fwp_closure_drop_push
0000000100007db5	cmpl	$0xff, %eax
0000000100007dba	je	0x100007ea6
0000000100007dc0	decb	%al
0000000100007dc2	movb	%al, (%rdi)
0000000100007dc4	addq	$0x238, %rsp                    ## imm = 0x238
0000000100007dcb	popq	%rbx
0000000100007dcc	popq	%r14
0000000100007dce	popq	%r15
0000000100007dd0	popq	%rbp
0000000100007dd1	retq
0000000100007dd2	leaq	-0x230(%rbp), %rbx
0000000100007dd9	movq	%rbx, -0x248(%rbp)
0000000100007de0	movq	$0x0, -0x240(%rbp)
0000000100007deb	movq	$0x40, -0x238(%rbp)
0000000100007df6	movq	_fwp_cleanups(%rip), %rcx
0000000100007dfd	movq	%rcx, -0x30(%rbp)
0000000100007e01	leaq	_fwp_closure_drop_release(%rip), %rcx
0000000100007e08	movq	%rcx, -0x28(%rbp)
0000000100007e0c	leaq	-0x248(%rbp), %rdi
0000000100007e13	movq	%rdi, -0x20(%rbp)
0000000100007e17	leaq	-0x30(%rbp), %r15
0000000100007e1b	movq	%r15, _fwp_cleanups(%rip)
0000000100007e22	movq	%rax, %r14
0000000100007e25	movq	%rdi, (%rax)
0000000100007e28	callq	_fwp_closure_drop_push
0000000100007e2d	nopl	(%rax)
0000000100007e30	movq	-0x240(%rbp), %rax
0000000100007e37	testq	%rax, %rax
0000000100007e3a	je	0x100007e71
0000000100007e3c	movq	-0x248(%rbp), %rcx
0000000100007e43	leaq	-0x1(%rax), %rdx
0000000100007e47	movq	%rdx, -0x240(%rbp)
0000000100007e4e	movq	-0x8(%rcx,%rax,8), %rdi
0000000100007e53	movq	_fwp_fns(%rip), %rax
0000000100007e5a	movl	(%rdi), %ecx
0000000100007e5c	shlq	$0x5, %rcx
0000000100007e60	movq	0x18(%rax,%rcx), %rax
0000000100007e65	testq	%rax, %rax
0000000100007e68	je	0x100007eb8
0000000100007e6a	xorl	%esi, %esi
0000000100007e6c	callq	*0x8(%rax)
0000000100007e6f	jmp	0x100007e30
0000000100007e71	cmpq	%r15, _fwp_cleanups(%rip)
0000000100007e78	jne	0x100007ee6
0000000100007e7a	movq	-0x30(%rbp), %rax
0000000100007e7e	movq	%rax, _fwp_cleanups(%rip)
0000000100007e85	movq	$0x0, (%r14)
0000000100007e8c	movq	-0x248(%rbp), %rdi
0000000100007e93	cmpq	%rbx, %rdi
0000000100007e96	je	0x100007dc4
0000000100007e9c	callq	0x1000111f2                     ## symbol stub for: _free
0000000100007ea1	jmp	0x100007dc4
0000000100007ea6	addq	$0x238, %rsp                    ## imm = 0x238
0000000100007ead	popq	%rbx
0000000100007eae	popq	%r14
0000000100007eb0	popq	%r15
0000000100007eb2	popq	%rbp
0000000100007eb3	jmp	_fwp_rc_wide_drop
0000000100007eb8	callq	_fwp_flush
0000000100007ebd	movq	0xb174(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100007ec4	movq	(%rax), %rdi
0000000100007ec7	leaq	0x9ac1(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007ece	leaq	0x9c4e(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100007ed5	xorl	%eax, %eax
0000000100007ed7	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100007edc	movl	$0x65, %edi
0000000100007ee1	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100007ee6	callq	0x1000111aa                     ## symbol stub for: _abort
0000000100007eeb	nopl	(%rax,%rax)
_fwp_closure_drop_push:
0000000100007ef0	pushq	%rbp
0000000100007ef1	movq	%rsp, %rbp
0000000100007ef4	pushq	%r15
0000000100007ef6	pushq	%r14
0000000100007ef8	pushq	%r13
0000000100007efa	pushq	%r12
0000000100007efc	pushq	%rbx
0000000100007efd	pushq	%rax
0000000100007efe	movq	%rsi, %rbx
0000000100007f01	movq	%rdi, %r14
0000000100007f04	movq	0x8(%rdi), %r13
0000000100007f08	cmpq	0x10(%rdi), %r13
0000000100007f0c	jne	0x100007f73
0000000100007f0e	movq	%r13, %rax
0000000100007f11	shrq	$0x3c, %rax
0000000100007f15	jne	0x100007f91
0000000100007f17	movq	%r13, %rdi
0000000100007f1a	shlq	$0x4, %rdi
0000000100007f1e	callq	0x100011216                     ## symbol stub for: _malloc
0000000100007f23	testq	%rax, %rax
0000000100007f26	je	0x100007fb0
0000000100007f2c	movq	%rax, %r15
0000000100007f2f	leaq	(,%r13,2), %rax
0000000100007f37	movq	%rax, -0x30(%rbp)
0000000100007f3b	movq	(%r14), %r12
0000000100007f3e	leaq	(,%r13,8), %rdx
0000000100007f46	movq	%r15, %rdi
0000000100007f49	movq	%r12, %rsi
0000000100007f4c	callq	0x100011228                     ## symbol stub for: _memcpy
0000000100007f51	leaq	0x18(%r14), %rax
0000000100007f55	cmpq	%rax, %r12
0000000100007f58	je	0x100007f66
0000000100007f5a	movq	%r12, %rdi
0000000100007f5d	callq	0x1000111f2                     ## symbol stub for: _free
0000000100007f62	movq	0x8(%r14), %r13
0000000100007f66	movq	%r15, (%r14)
0000000100007f69	movq	-0x30(%rbp), %rax
0000000100007f6d	movq	%rax, 0x10(%r14)
0000000100007f71	jmp	0x100007f76
0000000100007f73	movq	(%r14), %r15
0000000100007f76	leaq	0x1(%r13), %rax
0000000100007f7a	movq	%rax, 0x8(%r14)
0000000100007f7e	movq	%rbx, (%r15,%r13,8)
0000000100007f82	addq	$0x8, %rsp
0000000100007f86	popq	%rbx
0000000100007f87	popq	%r12
0000000100007f89	popq	%r13
0000000100007f8b	popq	%r14
0000000100007f8d	popq	%r15
0000000100007f8f	popq	%rbp
0000000100007f90	retq
0000000100007f91	callq	_fwp_flush
0000000100007f96	movq	0xb09b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100007f9d	movq	(%rax), %rdi
0000000100007fa0	leaq	0x99e8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007fa7	leaq	0x9ba3(%rip), %rdx              ## literal pool for: "closure cleanup too large"
0000000100007fae	jmp	0x100007fcd
0000000100007fb0	callq	_fwp_flush
0000000100007fb5	movq	0xb07c(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100007fbc	movq	(%rax), %rdi
0000000100007fbf	leaq	0x99c9(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007fc6	leaq	0x9b9e(%rip), %rdx              ## literal pool for: "out of memory"
0000000100007fcd	xorl	%eax, %eax
0000000100007fcf	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100007fd4	movl	$0x65, %edi
0000000100007fd9	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100007fde	nop
_fwp_closure_drop_release:
0000000100007fe0	pushq	%rbp
0000000100007fe1	movq	%rsp, %rbp
0000000100007fe4	pushq	%r14
0000000100007fe6	pushq	%rbx
0000000100007fe7	movq	%rdi, %rbx
0000000100007fea	leaq	_fwp_closure_drop_active(%rip), %rdi
0000000100007ff1	callq	*(%rdi)
0000000100007ff3	movq	$0x0, (%rax)
0000000100007ffa	movq	(%rbx), %rdi
0000000100007ffd	leaq	0x18(%rbx), %r14
0000000100008001	cmpq	%r14, %rdi
0000000100008004	je	0x10000800b
0000000100008006	callq	0x1000111f2                     ## symbol stub for: _free
000000010000800b	movq	%r14, (%rbx)
000000010000800e	movq	$0x0, 0x8(%rbx)
0000000100008016	popq	%rbx
0000000100008017	popq	%r14
0000000100008019	popq	%rbp
000000010000801a	retq
000000010000801b	nopl	(%rax,%rax)
_fwp_rc_cleanup_cell:
0000000100008020	pushq	%rbp
0000000100008021	movq	%rsp, %rbp
0000000100008024	movq	%rdi, %rax
0000000100008027	movq	(%rdi), %rdi
000000010000802a	movq	$0x0, (%rax)
0000000100008031	testq	%rdi, %rdi
0000000100008034	je	0x10000803c
0000000100008036	popq	%rbp
0000000100008037	jmp	_fwp_rc_free_obj
000000010000803c	popq	%rbp
000000010000803d	retq
000000010000803e	nop
_f32:
0000000100008040	pushq	%rbp
0000000100008041	movq	%rsp, %rbp
0000000100008044	pushq	%r15
0000000100008046	pushq	%r14
0000000100008048	pushq	%r13
000000010000804a	pushq	%r12
000000010000804c	pushq	%rbx
000000010000804d	subq	$0xd8, %rsp
0000000100008054	movq	%rdi, %rbx
0000000100008057	movq	0xafd2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000805e	movq	(%rax), %rax
0000000100008061	movq	%rax, -0x30(%rbp)
0000000100008065	movq	%rdi, -0x98(%rbp)
000000010000806c	movq	_fwp_cleanups(%rip), %rax
0000000100008073	movq	%rax, -0x90(%rbp)
000000010000807a	leaq	_fwp_owner_release10(%rip), %rax
0000000100008081	movq	%rax, -0x88(%rbp)
0000000100008088	leaq	-0x98(%rbp), %rax
000000010000808f	movq	%rax, -0x80(%rbp)
0000000100008093	movq	$0x0, -0x78(%rbp)
000000010000809b	leaq	-0x90(%rbp), %r12
00000001000080a2	movq	%r12, -0xe0(%rbp)
00000001000080a9	leaq	_fwp_owner_release11(%rip), %rax
00000001000080b0	movq	%rax, -0xd8(%rbp)
00000001000080b7	leaq	-0x78(%rbp), %rax
00000001000080bb	movq	%rax, -0xd0(%rbp)
00000001000080c2	leaq	-0xe0(%rbp), %r14
00000001000080c9	movq	%r14, _fwp_cleanups(%rip)
00000001000080d0	movq	0x10(%rdi), %rax
00000001000080d4	subq	0xcf5d(%rip), %rax
00000001000080db	movq	0xcf7e(%rip), %rcx
00000001000080e2	shlq	$0x10, %rcx
00000001000080e6	cmpq	%rcx, %rax
00000001000080e9	jae	0x100008153
00000001000080eb	movq	0xcf8e(%rip), %rcx
00000001000080f2	movq	%rax, %rdx
00000001000080f5	shrq	$0x10, %rdx
00000001000080f9	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008100	leaq	(%rcx,%rdx), %rdi
0000000100008104	movzbl	(%rcx,%rdx), %ecx
0000000100008108	cmpb	$0x2, %cl
000000010000810b	setne	%dl
000000010000810e	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008114	setne	%sil
0000000100008118	orb	%dl, %sil
000000010000811b	jne	0x100008126
000000010000811d	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008124	jmp	0x100008140
0000000100008126	cmpb	$0x1, %cl
0000000100008129	jne	0x100008153
000000010000812b	movl	0x20(%rdi), %ecx
000000010000812e	imulq	%rcx, %rax
0000000100008132	shrq	$0x20, %rax
0000000100008136	addq	%rax, %rdi
0000000100008139	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008140	movzbl	(%rdi), %eax
0000000100008143	testb	%al, %al
0000000100008145	je	0x100008153
0000000100008147	cmpb	$-0x3, %al
0000000100008149	ja	0x1000085c6
000000010000814f	incb	%al
0000000100008151	movb	%al, (%rdi)
0000000100008153	movq	0x10(%rbx), %rdi
0000000100008157	movq	%rdi, -0x78(%rbp)
000000010000815b	movq	-0xe0(%rbp), %rax
0000000100008162	movq	%rax, _fwp_cleanups(%rip)
0000000100008169	movq	0x8(%rbx), %r13
000000010000816d	movq	0x18(%rbx), %r14
0000000100008171	testq	%r13, %r13
0000000100008174	js	0x10000819d
0000000100008176	movq	(%rdi), %rax
0000000100008179	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100008183	andq	%rax, %rcx
0000000100008186	cmpq	%r13, %rcx
0000000100008189	jbe	0x10000819d
000000010000818b	testq	%rax, %rax
000000010000818e	js	0x100008260
0000000100008194	leaq	0x8(%rdi), %rax
0000000100008198	jmp	0x100008264
000000010000819d	movl	%r14d, %r15d
00000001000081a0	callq	_fwp_drop0
00000001000081a5	movq	%r15, -0x48(%rbp)
00000001000081a9	movl	$0x10, %edi
00000001000081ae	callq	_fwp_alloc_init
00000001000081b3	movq	%rax, %r14
00000001000081b6	movabsq	$0x100000001, %rax              ## imm = 0x100000001
00000001000081c0	movq	%rax, (%r14)
00000001000081c3	movq	%r15, 0x8(%r14)
00000001000081c7	leaq	-0x48(%rbp), %rax
00000001000081cb	movq	%r14, %rax
00000001000081ce	subq	0xce63(%rip), %rax
00000001000081d5	movq	0xce84(%rip), %rcx
00000001000081dc	shlq	$0x10, %rcx
00000001000081e0	cmpq	%rcx, %rax
00000001000081e3	jae	0x100008582
00000001000081e9	movq	0xce90(%rip), %rcx
00000001000081f0	movq	%rax, %rdx
00000001000081f3	shrq	$0x10, %rdx
00000001000081f7	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000081fe	leaq	(%rcx,%rdx), %r15
0000000100008202	movzbl	(%rcx,%rdx), %ecx
0000000100008206	cmpb	$0x2, %cl
0000000100008209	setne	%dl
000000010000820c	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008212	setne	%sil
0000000100008216	orb	%dl, %sil
0000000100008219	jne	0x100008231
000000010000821b	addq	$0x228, %r15                    ## imm = 0x228
0000000100008222	cmpb	$-0x1, (%r15)
0000000100008226	je	0x100008256
0000000100008228	movb	$0x1, (%r15)
000000010000822c	jmp	0x100008582
0000000100008231	cmpb	$0x1, %cl
0000000100008234	jne	0x100008582
000000010000823a	movl	0x20(%r15), %ecx
000000010000823e	imulq	%rcx, %rax
0000000100008242	shrq	$0x20, %rax
0000000100008246	addq	%rax, %r15
0000000100008249	addq	$0x228, %r15                    ## imm = 0x228
0000000100008250	cmpb	$-0x1, (%r15)
0000000100008254	jne	0x100008228
0000000100008256	movq	%r15, %rdi
0000000100008259	callq	_fwp_rc_forget_slot
000000010000825e	jmp	0x100008228
0000000100008260	movq	0x10(%rdi), %rax
0000000100008264	movss	(%rax,%r13,4), %xmm1
000000010000826a	movq	_fwp_cleanups(%rip), %rax
0000000100008271	movq	%rdi, -0xc8(%rbp)
0000000100008278	movq	%rax, -0x48(%rbp)
000000010000827c	leaq	_fwp_owner_release7(%rip), %rax
0000000100008283	movq	%rax, -0x40(%rbp)
0000000100008287	leaq	-0xc8(%rbp), %rax
000000010000828e	movq	%rax, -0x38(%rbp)
0000000100008292	leaq	-0x48(%rbp), %r15
0000000100008296	movq	%rdi, %rcx
0000000100008299	subq	0xcd98(%rip), %rcx
00000001000082a0	movq	%r15, _fwp_cleanups(%rip)
00000001000082a7	movq	0xcdb2(%rip), %rax
00000001000082ae	shlq	$0x10, %rax
00000001000082b2	cmpq	%rax, %rcx
00000001000082b5	jae	0x100008320
00000001000082b7	movq	0xcdc2(%rip), %rdx
00000001000082be	movq	%rcx, %rax
00000001000082c1	shrq	$0x10, %rax
00000001000082c5	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
00000001000082cc	leaq	(%rdx,%rsi), %rax
00000001000082d0	movzbl	(%rdx,%rsi), %edx
00000001000082d4	cmpb	$0x2, %dl
00000001000082d7	setne	%sil
00000001000082db	andq	$0xffff, %rcx                   ## imm = 0xFFFF
00000001000082e2	setne	%r8b
00000001000082e6	orb	%sil, %r8b
00000001000082e9	jne	0x1000082f3
00000001000082eb	addq	$0x228, %rax                    ## imm = 0x228
00000001000082f1	jmp	0x10000830c
00000001000082f3	cmpb	$0x1, %dl
00000001000082f6	jne	0x100008320
00000001000082f8	movl	0x20(%rax), %edx
00000001000082fb	imulq	%rdx, %rcx
00000001000082ff	shrq	$0x20, %rcx
0000000100008303	addq	%rcx, %rax
0000000100008306	addq	$0x228, %rax                    ## imm = 0x228
000000010000830c	movzbl	(%rax), %ecx
000000010000830f	testb	%cl, %cl
0000000100008311	je	0x100008320
0000000100008313	cmpb	$-0x3, %cl
0000000100008316	ja	0x1000085e5
000000010000831c	incb	%cl
000000010000831e	movb	%cl, (%rax)
0000000100008320	movd	%r14d, %xmm0
0000000100008325	mulss	0x9173(%rip), %xmm1
000000010000832d	addss	0x916f(%rip), %xmm1
0000000100008335	incq	%r13
0000000100008338	addss	%xmm0, %xmm1
000000010000833c	movss	%xmm1, -0x6c(%rbp)
0000000100008341	movq	-0x48(%rbp), %rax
0000000100008345	movq	%rax, _fwp_cleanups(%rip)
000000010000834c	movq	%rdi, %r14
000000010000834f	callq	_fwp_drop0
0000000100008354	movd	-0x6c(%rbp), %xmm0
0000000100008359	movd	%xmm0, %r12d
000000010000835e	movq	%r14, -0xc0(%rbp)
0000000100008365	movq	_fwp_cleanups(%rip), %rax
000000010000836c	movq	%rax, -0xb8(%rbp)
0000000100008373	leaq	_fwp_owner_release8(%rip), %rax
000000010000837a	movq	%rax, -0xb0(%rbp)
0000000100008381	leaq	-0xc0(%rbp), %rax
0000000100008388	movq	%rax, -0xa8(%rbp)
000000010000838f	leaq	-0xb8(%rbp), %rax
0000000100008396	movq	%rax, _fwp_cleanups(%rip)
000000010000839d	movq	%r13, -0x60(%rbp)
00000001000083a1	movq	%r14, -0x58(%rbp)
00000001000083a5	movq	%r12, -0x50(%rbp)
00000001000083a9	movl	$0x20, %edi
00000001000083ae	callq	_fwp_alloc_init
00000001000083b3	movq	%rax, %r15
00000001000083b6	movabsq	$0x300000000, %rax              ## imm = 0x300000000
00000001000083c0	movq	%rax, (%r15)
00000001000083c3	movq	%r13, 0x8(%r15)
00000001000083c7	movq	%r14, 0x10(%r15)
00000001000083cb	movq	%r12, 0x18(%r15)
00000001000083cf	leaq	-0x60(%rbp), %rax
00000001000083d3	movq	%r15, %rax
00000001000083d6	subq	0xcc5b(%rip), %rax
00000001000083dd	movq	0xcc7c(%rip), %rcx
00000001000083e4	shlq	$0x10, %rcx
00000001000083e8	cmpq	%rcx, %rax
00000001000083eb	jae	0x10000845d
00000001000083ed	movq	0xcc8c(%rip), %rcx
00000001000083f4	movq	%rax, %rdx
00000001000083f7	shrq	$0x10, %rdx
00000001000083fb	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008402	leaq	(%rcx,%rdx), %r14
0000000100008406	movzbl	(%rcx,%rdx), %ecx
000000010000840a	cmpb	$0x2, %cl
000000010000840d	setne	%dl
0000000100008410	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008416	setne	%sil
000000010000841a	orb	%dl, %sil
000000010000841d	jne	0x100008432
000000010000841f	addq	$0x228, %r14                    ## imm = 0x228
0000000100008426	cmpb	$-0x1, (%r14)
000000010000842a	je	0x100008453
000000010000842c	movb	$0x1, (%r14)
0000000100008430	jmp	0x10000845d
0000000100008432	cmpb	$0x1, %cl
0000000100008435	jne	0x10000845d
0000000100008437	movl	0x20(%r14), %ecx
000000010000843b	imulq	%rcx, %rax
000000010000843f	shrq	$0x20, %rax
0000000100008443	addq	%rax, %r14
0000000100008446	addq	$0x228, %r14                    ## imm = 0x228
000000010000844d	cmpb	$-0x1, (%r14)
0000000100008451	jne	0x10000842c
0000000100008453	movq	%r14, %rdi
0000000100008456	callq	_fwp_rc_forget_slot
000000010000845b	jmp	0x10000842c
000000010000845d	leaq	-0xb8(%rbp), %rax
0000000100008464	cmpq	%rax, _fwp_cleanups(%rip)
000000010000846b	jne	0x10000860a
0000000100008471	movq	-0xb8(%rbp), %rax
0000000100008478	movq	%r15, -0xa0(%rbp)
000000010000847f	movq	%rax, -0xf8(%rbp)
0000000100008486	leaq	_fwp_owner_release9(%rip), %rax
000000010000848d	movq	%rax, -0xf0(%rbp)
0000000100008494	leaq	-0xa0(%rbp), %rax
000000010000849b	movq	%rax, -0xe8(%rbp)
00000001000084a2	leaq	-0xf8(%rbp), %r12
00000001000084a9	movq	%r12, _fwp_cleanups(%rip)
00000001000084b0	movq	%r15, -0x68(%rbp)
00000001000084b4	movl	$0x10, %edi
00000001000084b9	callq	_fwp_alloc_init
00000001000084be	movq	%rax, %r14
00000001000084c1	movabsq	$__mh_execute_header, %rax
00000001000084cb	movq	%rax, (%r14)
00000001000084ce	movq	%r15, 0x8(%r14)
00000001000084d2	leaq	-0x68(%rbp), %rax
00000001000084d6	movq	%r14, %rax
00000001000084d9	subq	0xcb58(%rip), %rax
00000001000084e0	movq	0xcb79(%rip), %rcx
00000001000084e7	shlq	$0x10, %rcx
00000001000084eb	cmpq	%rcx, %rax
00000001000084ee	jae	0x100008560
00000001000084f0	movq	0xcb89(%rip), %rcx
00000001000084f7	movq	%rax, %rdx
00000001000084fa	shrq	$0x10, %rdx
00000001000084fe	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008505	leaq	(%rcx,%rdx), %r15
0000000100008509	movzbl	(%rcx,%rdx), %ecx
000000010000850d	cmpb	$0x2, %cl
0000000100008510	setne	%dl
0000000100008513	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008519	setne	%sil
000000010000851d	orb	%dl, %sil
0000000100008520	jne	0x100008535
0000000100008522	addq	$0x228, %r15                    ## imm = 0x228
0000000100008529	cmpb	$-0x1, (%r15)
000000010000852d	je	0x100008556
000000010000852f	movb	$0x1, (%r15)
0000000100008533	jmp	0x100008560
0000000100008535	cmpb	$0x1, %cl
0000000100008538	jne	0x100008560
000000010000853a	movl	0x20(%r15), %ecx
000000010000853e	imulq	%rcx, %rax
0000000100008542	shrq	$0x20, %rax
0000000100008546	addq	%rax, %r15
0000000100008549	addq	$0x228, %r15                    ## imm = 0x228
0000000100008550	cmpb	$-0x1, (%r15)
0000000100008554	jne	0x10000852f
0000000100008556	movq	%r15, %rdi
0000000100008559	callq	_fwp_rc_forget_slot
000000010000855e	jmp	0x10000852f
0000000100008560	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008567	jne	0x10000860a
000000010000856d	movq	-0xf8(%rbp), %rax
0000000100008574	movq	%rax, _fwp_cleanups(%rip)
000000010000857b	leaq	-0x90(%rbp), %r12
0000000100008582	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008589	jne	0x10000860a
000000010000858b	movq	-0x90(%rbp), %rax
0000000100008592	movq	%rax, _fwp_cleanups(%rip)
0000000100008599	movq	%rbx, %rdi
000000010000859c	callq	_fwp_drop3
00000001000085a1	movq	0xaa88(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
00000001000085a8	movq	(%rax), %rax
00000001000085ab	cmpq	-0x30(%rbp), %rax
00000001000085af	jne	0x10000860f
00000001000085b1	movq	%r14, %rax
00000001000085b4	addq	$0xd8, %rsp
00000001000085bb	popq	%rbx
00000001000085bc	popq	%r12
00000001000085be	popq	%r13
00000001000085c0	popq	%r14
00000001000085c2	popq	%r15
00000001000085c4	popq	%rbp
00000001000085c5	retq
00000001000085c6	callq	_fwp_rc_wide_dup
00000001000085cb	movq	_fwp_cleanups(%rip), %rax
00000001000085d2	movq	0x10(%rbx), %rdi
00000001000085d6	movq	%rdi, -0x78(%rbp)
00000001000085da	cmpq	%r14, %rax
00000001000085dd	je	0x10000815b
00000001000085e3	jmp	0x10000860a
00000001000085e5	movq	%rdi, %r12
00000001000085e8	movq	%rax, %rdi
00000001000085eb	movss	%xmm1, -0x6c(%rbp)
00000001000085f0	callq	_fwp_rc_wide_dup
00000001000085f5	movss	-0x6c(%rbp), %xmm1
00000001000085fa	movq	%r12, %rdi
00000001000085fd	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008604	je	0x100008320
000000010000860a	callq	0x1000111aa                     ## symbol stub for: _abort
000000010000860f	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100008614	nopw	%cs:(%rax,%rax)
_fwp_owner_release10:
0000000100008620	pushq	%rbp
0000000100008621	movq	%rsp, %rbp
0000000100008624	movq	(%rdi), %rdi
0000000100008627	popq	%rbp
0000000100008628	jmp	_fwp_drop3
000000010000862d	nopl	(%rax)
_fwp_owner_release11:
0000000100008630	pushq	%rbp
0000000100008631	movq	%rsp, %rbp
0000000100008634	movq	(%rdi), %rdi
0000000100008637	popq	%rbp
0000000100008638	jmp	_fwp_drop0
000000010000863d	nopl	(%rax)
_fwp_drop3:
0000000100008640	movq	%rdi, %rcx
0000000100008643	subq	0xc9ee(%rip), %rcx
000000010000864a	movq	0xca0f(%rip), %rax
0000000100008651	shlq	$0x10, %rax
0000000100008655	cmpq	%rax, %rcx
0000000100008658	jae	0x1000086ee
000000010000865e	movq	0xca1b(%rip), %rdx
0000000100008665	movq	%rcx, %rax
0000000100008668	shrq	$0x10, %rax
000000010000866c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008673	leaq	(%rdx,%rsi), %rax
0000000100008677	movzbl	(%rdx,%rsi), %edx
000000010000867b	cmpb	$0x2, %dl
000000010000867e	setne	%sil
0000000100008682	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008689	setne	%r8b
000000010000868d	orb	%sil, %r8b
0000000100008690	jne	0x10000869a
0000000100008692	addq	$0x228, %rax                    ## imm = 0x228
0000000100008698	jmp	0x1000086b3
000000010000869a	cmpb	$0x1, %dl
000000010000869d	jne	0x1000086ee
000000010000869f	movl	0x20(%rax), %edx
00000001000086a2	imulq	%rdx, %rcx
00000001000086a6	shrq	$0x20, %rcx
00000001000086aa	addq	%rcx, %rax
00000001000086ad	addq	$0x228, %rax                    ## imm = 0x228
00000001000086b3	movzbl	(%rax), %ecx
00000001000086b6	testl	%ecx, %ecx
00000001000086b8	je	0x1000086ee
00000001000086ba	cmpl	$0x1, %ecx
00000001000086bd	jne	0x1000086e2
00000001000086bf	pushq	%rbp
00000001000086c0	movq	%rsp, %rbp
00000001000086c3	pushq	%rbx
00000001000086c4	pushq	%rax
00000001000086c5	movq	0x10(%rdi), %rax
00000001000086c9	movq	%rdi, %rbx
00000001000086cc	movq	%rax, %rdi
00000001000086cf	callq	_fwp_drop0
00000001000086d4	movq	%rbx, %rdi
00000001000086d7	addq	$0x8, %rsp
00000001000086db	popq	%rbx
00000001000086dc	popq	%rbp
00000001000086dd	jmp	_fwp_rc_free_obj
00000001000086e2	cmpl	$0xff, %ecx
00000001000086e8	je	0x1000086ef
00000001000086ea	decb	%cl
00000001000086ec	movb	%cl, (%rax)
00000001000086ee	retq
00000001000086ef	movq	%rax, %rdi
00000001000086f2	jmp	_fwp_rc_wide_drop
00000001000086f7	nopw	(%rax,%rax)
_fwp_owner_release7:
0000000100008700	pushq	%rbp
0000000100008701	movq	%rsp, %rbp
0000000100008704	movq	(%rdi), %rdi
0000000100008707	popq	%rbp
0000000100008708	jmp	_fwp_drop0
000000010000870d	nopl	(%rax)
_fwp_owner_release8:
0000000100008710	pushq	%rbp
0000000100008711	movq	%rsp, %rbp
0000000100008714	movq	(%rdi), %rdi
0000000100008717	popq	%rbp
0000000100008718	jmp	_fwp_drop0
000000010000871d	nopl	(%rax)
_fwp_owner_release9:
0000000100008720	pushq	%rbp
0000000100008721	movq	%rsp, %rbp
0000000100008724	movq	(%rdi), %rax
0000000100008727	subq	0xc90a(%rip), %rax
000000010000872e	movq	0xc92b(%rip), %rcx
0000000100008735	shlq	$0x10, %rcx
0000000100008739	cmpq	%rcx, %rax
000000010000873c	jae	0x1000087a2
000000010000873e	movq	0xc93b(%rip), %rcx
0000000100008745	movq	%rax, %rdx
0000000100008748	shrq	$0x10, %rdx
000000010000874c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008753	leaq	(%rcx,%rdx), %rdi
0000000100008757	movzbl	(%rcx,%rdx), %ecx
000000010000875b	cmpb	$0x2, %cl
000000010000875e	setne	%dl
0000000100008761	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008767	setne	%sil
000000010000876b	orb	%dl, %sil
000000010000876e	jne	0x100008779
0000000100008770	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008777	jmp	0x100008793
0000000100008779	cmpb	$0x1, %cl
000000010000877c	jne	0x1000087a2
000000010000877e	movl	0x20(%rdi), %ecx
0000000100008781	imulq	%rcx, %rax
0000000100008785	shrq	$0x20, %rax
0000000100008789	addq	%rax, %rdi
000000010000878c	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008793	movzbl	(%rdi), %eax
0000000100008796	cmpb	$0x2, %al
0000000100008798	jb	0x1000087a2
000000010000879a	cmpb	$-0x1, %al
000000010000879c	je	0x1000087a4
000000010000879e	decb	%al
00000001000087a0	movb	%al, (%rdi)
00000001000087a2	popq	%rbp
00000001000087a3	retq
00000001000087a4	popq	%rbp
00000001000087a5	jmp	_fwp_rc_wide_drop
00000001000087aa	nopw	(%rax,%rax)
_fwp_owned_entry32:
00000001000087b0	pushq	%rbp
00000001000087b1	movq	%rsp, %rbp
00000001000087b4	movq	(%rdi), %rdi
00000001000087b7	popq	%rbp
00000001000087b8	jmp	_f32
00000001000087bd	nopl	(%rax)
_fwp_caps32:
00000001000087c0	movl	0x4(%rdi), %eax
00000001000087c3	testl	%esi, %esi
00000001000087c5	je	0x100008829
00000001000087c7	testl	%eax, %eax
00000001000087c9	je	0x100008881
00000001000087cf	movq	0x8(%rdi), %rax
00000001000087d3	subq	0xc85e(%rip), %rax
00000001000087da	movq	0xc87f(%rip), %rcx
00000001000087e1	shlq	$0x10, %rcx
00000001000087e5	cmpq	%rcx, %rax
00000001000087e8	jae	0x100008881
00000001000087ee	movq	0xc88b(%rip), %rcx
00000001000087f5	movq	%rax, %rdx
00000001000087f8	shrq	$0x10, %rdx
00000001000087fc	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008803	leaq	(%rcx,%rdx), %rdi
0000000100008807	movzbl	(%rcx,%rdx), %ecx
000000010000880b	cmpb	$0x2, %cl
000000010000880e	setne	%dl
0000000100008811	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008817	setne	%sil
000000010000881b	orb	%dl, %sil
000000010000881e	jne	0x100008854
0000000100008820	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008827	jmp	0x10000886e
0000000100008829	testl	%eax, %eax
000000010000882b	je	_fwp_rc_free_obj
0000000100008831	pushq	%rbp
0000000100008832	movq	%rsp, %rbp
0000000100008835	pushq	%rbx
0000000100008836	pushq	%rax
0000000100008837	movq	0x8(%rdi), %rax
000000010000883b	movq	%rdi, %rbx
000000010000883e	movq	%rax, %rdi
0000000100008841	callq	_fwp_drop3
0000000100008846	movq	%rbx, %rdi
0000000100008849	addq	$0x8, %rsp
000000010000884d	popq	%rbx
000000010000884e	popq	%rbp
000000010000884f	jmp	_fwp_rc_free_obj
0000000100008854	cmpb	$0x1, %cl
0000000100008857	jne	0x100008881
0000000100008859	movl	0x20(%rdi), %ecx
000000010000885c	imulq	%rcx, %rax
0000000100008860	shrq	$0x20, %rax
0000000100008864	addq	%rax, %rdi
0000000100008867	addq	$0x228, %rdi                    ## imm = 0x228
000000010000886e	movzbl	(%rdi), %eax
0000000100008871	testb	%al, %al
0000000100008873	je	0x100008881
0000000100008875	cmpb	$-0x2, %al
0000000100008877	jae	_fwp_rc_wide_dup
000000010000887d	incb	%al
000000010000887f	movb	%al, (%rdi)
0000000100008881	retq
0000000100008882	nopw	%cs:(%rax,%rax)
_fwp_args32:
0000000100008890	pushq	%rbp
0000000100008891	movq	%rsp, %rbp
0000000100008894	testl	%esi, %esi
0000000100008896	setne	%al
0000000100008899	testl	%edx, %edx
000000010000889b	sete	%cl
000000010000889e	orb	%al, %cl
00000001000088a0	jne	0x100008920
00000001000088a2	movq	(%rdi), %rax
00000001000088a5	subq	0xc78c(%rip), %rax
00000001000088ac	movq	0xc7ad(%rip), %rcx
00000001000088b3	shlq	$0x10, %rcx
00000001000088b7	cmpq	%rcx, %rax
00000001000088ba	jae	0x100008920
00000001000088bc	movq	0xc7bd(%rip), %rcx
00000001000088c3	movq	%rax, %rdx
00000001000088c6	shrq	$0x10, %rdx
00000001000088ca	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000088d1	leaq	(%rcx,%rdx), %rdi
00000001000088d5	movzbl	(%rcx,%rdx), %ecx
00000001000088d9	cmpb	$0x2, %cl
00000001000088dc	setne	%dl
00000001000088df	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000088e5	setne	%sil
00000001000088e9	orb	%dl, %sil
00000001000088ec	jne	0x1000088f7
00000001000088ee	addq	$0x228, %rdi                    ## imm = 0x228
00000001000088f5	jmp	0x100008911
00000001000088f7	cmpb	$0x1, %cl
00000001000088fa	jne	0x100008920
00000001000088fc	movl	0x20(%rdi), %ecx
00000001000088ff	imulq	%rcx, %rax
0000000100008903	shrq	$0x20, %rax
0000000100008907	addq	%rax, %rdi
000000010000890a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008911	movzbl	(%rdi), %eax
0000000100008914	testb	%al, %al
0000000100008916	je	0x100008920
0000000100008918	cmpb	$-0x2, %al
000000010000891a	jae	0x100008922
000000010000891c	incb	%al
000000010000891e	movb	%al, (%rdi)
0000000100008920	popq	%rbp
0000000100008921	retq
0000000100008922	popq	%rbp
0000000100008923	jmp	_fwp_rc_wide_dup
0000000100008928	nopl	(%rax,%rax)
_fwp_arg_drop32:
0000000100008930	pushq	%rbp
0000000100008931	movq	%rsp, %rbp
0000000100008934	testl	%esi, %esi
0000000100008936	setne	%al
0000000100008939	testl	%edx, %edx
000000010000893b	sete	%cl
000000010000893e	orb	%al, %cl
0000000100008940	je	0x100008944
0000000100008942	popq	%rbp
0000000100008943	retq
0000000100008944	movq	(%rdi), %rdi
0000000100008947	popq	%rbp
0000000100008948	jmp	_fwp_drop3
000000010000894d	nopl	(%rax)
_f35:
0000000100008950	pushq	%rbp
0000000100008951	movq	%rsp, %rbp
0000000100008954	pushq	%r15
0000000100008956	pushq	%r14
0000000100008958	pushq	%r13
000000010000895a	pushq	%r12
000000010000895c	pushq	%rbx
000000010000895d	subq	$0x158, %rsp                    ## imm = 0x158
0000000100008964	movq	%rdi, %rbx
0000000100008967	movq	0xa6c2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000896e	movq	(%rax), %rax
0000000100008971	movq	%rax, -0x30(%rbp)
0000000100008975	movq	%rdi, -0xd8(%rbp)
000000010000897c	movq	_fwp_cleanups(%rip), %rax
0000000100008983	movq	%rax, -0xd0(%rbp)
000000010000898a	leaq	_fwp_owner_release18(%rip), %rax
0000000100008991	movq	%rax, -0xc8(%rbp)
0000000100008998	leaq	-0xd8(%rbp), %rax
000000010000899f	movq	%rax, -0xc0(%rbp)
00000001000089a6	movq	$0x0, -0xb8(%rbp)
00000001000089b1	leaq	-0xd0(%rbp), %r15
00000001000089b8	movq	%r15, -0x110(%rbp)
00000001000089bf	leaq	_fwp_owner_release19(%rip), %rax
00000001000089c6	movq	%rax, -0x108(%rbp)
00000001000089cd	leaq	-0xb8(%rbp), %rax
00000001000089d4	movq	%rax, -0x100(%rbp)
00000001000089db	leaq	-0x110(%rbp), %r14
00000001000089e2	movq	%r14, _fwp_cleanups(%rip)
00000001000089e9	movq	0x10(%rdi), %rax
00000001000089ed	subq	0xc644(%rip), %rax
00000001000089f4	movq	0xc665(%rip), %rcx
00000001000089fb	shlq	$0x10, %rcx
00000001000089ff	cmpq	%rcx, %rax
0000000100008a02	jae	0x100008a6c
0000000100008a04	movq	0xc675(%rip), %rcx
0000000100008a0b	movq	%rax, %rdx
0000000100008a0e	shrq	$0x10, %rdx
0000000100008a12	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008a19	leaq	(%rcx,%rdx), %rdi
0000000100008a1d	movzbl	(%rcx,%rdx), %ecx
0000000100008a21	cmpb	$0x2, %cl
0000000100008a24	setne	%dl
0000000100008a27	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008a2d	setne	%sil
0000000100008a31	orb	%dl, %sil
0000000100008a34	jne	0x100008a3f
0000000100008a36	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008a3d	jmp	0x100008a59
0000000100008a3f	cmpb	$0x1, %cl
0000000100008a42	jne	0x100008a6c
0000000100008a44	movl	0x20(%rdi), %ecx
0000000100008a47	imulq	%rcx, %rax
0000000100008a4b	shrq	$0x20, %rax
0000000100008a4f	addq	%rax, %rdi
0000000100008a52	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008a59	movzbl	(%rdi), %eax
0000000100008a5c	testb	%al, %al
0000000100008a5e	je	0x100008a6c
0000000100008a60	cmpb	$-0x3, %al
0000000100008a62	ja	0x100008f78
0000000100008a68	incb	%al
0000000100008a6a	movb	%al, (%rdi)
0000000100008a6c	movq	0x10(%rbx), %rdi
0000000100008a70	movq	%rdi, -0xb8(%rbp)
0000000100008a77	movq	-0x110(%rbp), %rax
0000000100008a7e	movq	%rax, _fwp_cleanups(%rip)
0000000100008a85	movq	0x8(%rbx), %r12
0000000100008a89	movq	0x18(%rbx), %r13
0000000100008a8d	testq	%r12, %r12
0000000100008a90	js	0x100008ab9
0000000100008a92	movq	(%rdi), %rax
0000000100008a95	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100008a9f	andq	%rax, %rcx
0000000100008aa2	cmpq	%r12, %rcx
0000000100008aa5	jbe	0x100008ab9
0000000100008aa7	testq	%rax, %rax
0000000100008aaa	js	0x100008b8c
0000000100008ab0	leaq	0x8(%rdi), %rax
0000000100008ab4	jmp	0x100008b90
0000000100008ab9	callq	_fwp_drop0
0000000100008abe	movq	%r13, -0x90(%rbp)
0000000100008ac5	movl	$0x10, %edi
0000000100008aca	callq	_fwp_alloc_init
0000000100008acf	movq	%rax, %r14
0000000100008ad2	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100008adc	movq	%rax, (%r14)
0000000100008adf	movq	%r13, 0x8(%r14)
0000000100008ae3	leaq	-0x90(%rbp), %rax
0000000100008aea	movq	%r14, %rax
0000000100008aed	subq	0xc544(%rip), %rax
0000000100008af4	movq	0xc565(%rip), %rcx
0000000100008afb	shlq	$0x10, %rcx
0000000100008aff	cmpq	%rcx, %rax
0000000100008b02	jae	0x100008b7a
0000000100008b04	movq	%r15, %r12
0000000100008b07	movq	0xc572(%rip), %rcx
0000000100008b0e	movq	%rax, %rdx
0000000100008b11	shrq	$0x10, %rdx
0000000100008b15	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008b1c	leaq	(%rcx,%rdx), %r15
0000000100008b20	movzbl	(%rcx,%rdx), %ecx
0000000100008b24	cmpb	$0x2, %cl
0000000100008b27	setne	%dl
0000000100008b2a	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008b30	setne	%sil
0000000100008b34	orb	%dl, %sil
0000000100008b37	jne	0x100008b4c
0000000100008b39	addq	$0x228, %r15                    ## imm = 0x228
0000000100008b40	cmpb	$-0x1, (%r15)
0000000100008b44	je	0x100008b6d
0000000100008b46	movb	$0x1, (%r15)
0000000100008b4a	jmp	0x100008b77
0000000100008b4c	cmpb	$0x1, %cl
0000000100008b4f	jne	0x100008b77
0000000100008b51	movl	0x20(%r15), %ecx
0000000100008b55	imulq	%rcx, %rax
0000000100008b59	shrq	$0x20, %rax
0000000100008b5d	addq	%rax, %r15
0000000100008b60	addq	$0x228, %r15                    ## imm = 0x228
0000000100008b67	cmpb	$-0x1, (%r15)
0000000100008b6b	jne	0x100008b46
0000000100008b6d	movq	%r15, %rdi
0000000100008b70	callq	_fwp_rc_forget_slot
0000000100008b75	jmp	0x100008b46
0000000100008b77	movq	%r12, %r15
0000000100008b7a	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008b81	je	0x100008f3d
0000000100008b87	jmp	0x100008fb5
0000000100008b8c	movq	0x10(%rdi), %rax
0000000100008b90	movsbq	(%rax,%r12), %rcx
0000000100008b95	movq	_fwp_cleanups(%rip), %rax
0000000100008b9c	movq	%rdi, -0xf8(%rbp)
0000000100008ba3	movq	%rax, -0x180(%rbp)
0000000100008baa	leaq	_fwp_owner_release13(%rip), %rdx
0000000100008bb1	movq	%rdx, -0x178(%rbp)
0000000100008bb8	leaq	-0xf8(%rbp), %rdx
0000000100008bbf	movq	%rdx, -0x170(%rbp)
0000000100008bc6	leaq	-0x180(%rbp), %rdx
0000000100008bcd	movq	%rdx, _fwp_cleanups(%rip)
0000000100008bd4	addq	$-0x7f, %rcx
0000000100008bd8	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100008bdf	jbe	0x100008fbf
0000000100008be5	movq	%rdi, -0xf0(%rbp)
0000000100008bec	movq	%rax, -0x140(%rbp)
0000000100008bf3	leaq	_fwp_owner_release14(%rip), %rax
0000000100008bfa	movq	%rax, -0x138(%rbp)
0000000100008c01	leaq	-0xf0(%rbp), %rax
0000000100008c08	movq	%rax, -0x130(%rbp)
0000000100008c0f	leaq	-0x140(%rbp), %r14
0000000100008c16	movq	%rdi, %rcx
0000000100008c19	subq	0xc418(%rip), %rcx
0000000100008c20	movq	%r14, _fwp_cleanups(%rip)
0000000100008c27	movq	0xc432(%rip), %rax
0000000100008c2e	shlq	$0x10, %rax
0000000100008c32	cmpq	%rax, %rcx
0000000100008c35	jae	0x100008ca0
0000000100008c37	movq	0xc442(%rip), %rdx
0000000100008c3e	movq	%rcx, %rax
0000000100008c41	shrq	$0x10, %rax
0000000100008c45	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100008c4c	leaq	(%rdx,%rsi), %rax
0000000100008c50	movzbl	(%rdx,%rsi), %edx
0000000100008c54	cmpb	$0x2, %dl
0000000100008c57	setne	%sil
0000000100008c5b	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100008c62	setne	%r8b
0000000100008c66	orb	%sil, %r8b
0000000100008c69	jne	0x100008c73
0000000100008c6b	addq	$0x228, %rax                    ## imm = 0x228
0000000100008c71	jmp	0x100008c8c
0000000100008c73	cmpb	$0x1, %dl
0000000100008c76	jne	0x100008ca0
0000000100008c78	movl	0x20(%rax), %edx
0000000100008c7b	imulq	%rdx, %rcx
0000000100008c7f	shrq	$0x20, %rcx
0000000100008c83	addq	%rcx, %rax
0000000100008c86	addq	$0x228, %rax                    ## imm = 0x228
0000000100008c8c	movzbl	(%rax), %ecx
0000000100008c8f	testb	%cl, %cl
0000000100008c91	je	0x100008ca0
0000000100008c93	cmpb	$-0x3, %cl
0000000100008c96	ja	0x100008f9a
0000000100008c9c	incb	%cl
0000000100008c9e	movb	%cl, (%rax)
0000000100008ca0	movq	-0x140(%rbp), %rax
0000000100008ca7	movq	%rdi, -0x150(%rbp)
0000000100008cae	movq	%rdi, -0x148(%rbp)
0000000100008cb5	movq	%rax, -0x168(%rbp)
0000000100008cbc	leaq	_fwp_owner_release15(%rip), %rcx
0000000100008cc3	movq	%rcx, -0x160(%rbp)
0000000100008cca	leaq	-0x150(%rbp), %rcx
0000000100008cd1	movq	%rcx, -0x158(%rbp)
0000000100008cd8	leaq	-0x168(%rbp), %rcx
0000000100008cdf	movq	%rcx, _fwp_cleanups(%rip)
0000000100008ce6	incq	%r13
0000000100008ce9	jo	0x100008fcf
0000000100008cef	incq	%r12
0000000100008cf2	movq	%rax, _fwp_cleanups(%rip)
0000000100008cf9	movq	%rdi, %r14
0000000100008cfc	callq	_fwp_drop0
0000000100008d01	movq	%r14, -0xe8(%rbp)
0000000100008d08	movq	_fwp_cleanups(%rip), %rax
0000000100008d0f	movq	%rax, -0x90(%rbp)
0000000100008d16	leaq	_fwp_owner_release16(%rip), %rax
0000000100008d1d	movq	%rax, -0x88(%rbp)
0000000100008d24	leaq	-0xe8(%rbp), %rax
0000000100008d2b	movq	%rax, -0x80(%rbp)
0000000100008d2f	leaq	-0x90(%rbp), %rax
0000000100008d36	movq	%rax, _fwp_cleanups(%rip)
0000000100008d3d	movq	%r12, -0xa8(%rbp)
0000000100008d44	movq	%r14, -0xa0(%rbp)
0000000100008d4b	movq	%r13, -0x98(%rbp)
0000000100008d52	movl	$0x20, %edi
0000000100008d57	callq	_fwp_alloc_init
0000000100008d5c	movq	%rax, %r15
0000000100008d5f	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100008d69	movq	%rax, (%r15)
0000000100008d6c	movq	%r12, 0x8(%r15)
0000000100008d70	movq	%r14, 0x10(%r15)
0000000100008d74	movq	%r13, 0x18(%r15)
0000000100008d78	leaq	-0xa8(%rbp), %rax
0000000100008d7f	movq	%r15, %rax
0000000100008d82	subq	0xc2af(%rip), %rax
0000000100008d89	movq	0xc2d0(%rip), %rcx
0000000100008d90	shlq	$0x10, %rcx
0000000100008d94	cmpq	%rcx, %rax
0000000100008d97	jae	0x100008e09
0000000100008d99	movq	0xc2e0(%rip), %rcx
0000000100008da0	movq	%rax, %rdx
0000000100008da3	shrq	$0x10, %rdx
0000000100008da7	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008dae	leaq	(%rcx,%rdx), %r14
0000000100008db2	movzbl	(%rcx,%rdx), %ecx
0000000100008db6	cmpb	$0x2, %cl
0000000100008db9	setne	%dl
0000000100008dbc	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008dc2	setne	%sil
0000000100008dc6	orb	%dl, %sil
0000000100008dc9	jne	0x100008dde
0000000100008dcb	addq	$0x228, %r14                    ## imm = 0x228
0000000100008dd2	cmpb	$-0x1, (%r14)
0000000100008dd6	je	0x100008dff
0000000100008dd8	movb	$0x1, (%r14)
0000000100008ddc	jmp	0x100008e09
0000000100008dde	cmpb	$0x1, %cl
0000000100008de1	jne	0x100008e09
0000000100008de3	movl	0x20(%r14), %ecx
0000000100008de7	imulq	%rcx, %rax
0000000100008deb	shrq	$0x20, %rax
0000000100008def	addq	%rax, %r14
0000000100008df2	addq	$0x228, %r14                    ## imm = 0x228
0000000100008df9	cmpb	$-0x1, (%r14)
0000000100008dfd	jne	0x100008dd8
0000000100008dff	movq	%r14, %rdi
0000000100008e02	callq	_fwp_rc_forget_slot
0000000100008e07	jmp	0x100008dd8
0000000100008e09	leaq	-0x90(%rbp), %rax
0000000100008e10	cmpq	%rax, _fwp_cleanups(%rip)
0000000100008e17	jne	0x100008fb5
0000000100008e1d	movq	-0x90(%rbp), %rax
0000000100008e24	movq	%r15, -0xe0(%rbp)
0000000100008e2b	movq	%rax, -0x128(%rbp)
0000000100008e32	leaq	_fwp_owner_release17(%rip), %rax
0000000100008e39	movq	%rax, -0x120(%rbp)
0000000100008e40	leaq	-0xe0(%rbp), %rax
0000000100008e47	movq	%rax, -0x118(%rbp)
0000000100008e4e	leaq	-0x128(%rbp), %r12
0000000100008e55	movq	%r12, _fwp_cleanups(%rip)
0000000100008e5c	movq	%r15, -0xb0(%rbp)
0000000100008e63	movl	$0x10, %edi
0000000100008e68	callq	_fwp_alloc_init
0000000100008e6d	movq	%rax, %r14
0000000100008e70	movabsq	$__mh_execute_header, %rax
0000000100008e7a	movq	%rax, (%r14)
0000000100008e7d	movq	%r15, 0x8(%r14)
0000000100008e81	leaq	-0xb0(%rbp), %rax
0000000100008e88	movq	%r14, %rax
0000000100008e8b	subq	0xc1a6(%rip), %rax
0000000100008e92	movq	0xc1c7(%rip), %rcx
0000000100008e99	shlq	$0x10, %rcx
0000000100008e9d	cmpq	%rcx, %rax
0000000100008ea0	jae	0x100008f12
0000000100008ea2	movq	0xc1d7(%rip), %rcx
0000000100008ea9	movq	%rax, %rdx
0000000100008eac	shrq	$0x10, %rdx
0000000100008eb0	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008eb7	leaq	(%rcx,%rdx), %r15
0000000100008ebb	movzbl	(%rcx,%rdx), %ecx
0000000100008ebf	cmpb	$0x2, %cl
0000000100008ec2	setne	%dl
0000000100008ec5	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008ecb	setne	%sil
0000000100008ecf	orb	%dl, %sil
0000000100008ed2	jne	0x100008ee7
0000000100008ed4	addq	$0x228, %r15                    ## imm = 0x228
0000000100008edb	cmpb	$-0x1, (%r15)
0000000100008edf	je	0x100008f08
0000000100008ee1	movb	$0x1, (%r15)
0000000100008ee5	jmp	0x100008f12
0000000100008ee7	cmpb	$0x1, %cl
0000000100008eea	jne	0x100008f12
0000000100008eec	movl	0x20(%r15), %ecx
0000000100008ef0	imulq	%rcx, %rax
0000000100008ef4	shrq	$0x20, %rax
0000000100008ef8	addq	%rax, %r15
0000000100008efb	addq	$0x228, %r15                    ## imm = 0x228
0000000100008f02	cmpb	$-0x1, (%r15)
0000000100008f06	jne	0x100008ee1
0000000100008f08	movq	%r15, %rdi
0000000100008f0b	callq	_fwp_rc_forget_slot
0000000100008f10	jmp	0x100008ee1
0000000100008f12	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008f19	jne	0x100008fb5
0000000100008f1f	movq	-0x128(%rbp), %rax
0000000100008f26	movq	%rax, _fwp_cleanups(%rip)
0000000100008f2d	leaq	-0xd0(%rbp), %r15
0000000100008f34	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008f3b	jne	0x100008fb5
0000000100008f3d	movq	-0xd0(%rbp), %rax
0000000100008f44	movq	%rax, _fwp_cleanups(%rip)
0000000100008f4b	movq	%rbx, %rdi
0000000100008f4e	callq	_fwp_drop5
0000000100008f53	movq	0xa0d6(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008f5a	movq	(%rax), %rax
0000000100008f5d	cmpq	-0x30(%rbp), %rax
0000000100008f61	jne	0x100008fba
0000000100008f63	movq	%r14, %rax
0000000100008f66	addq	$0x158, %rsp                    ## imm = 0x158
0000000100008f6d	popq	%rbx
0000000100008f6e	popq	%r12
0000000100008f70	popq	%r13
0000000100008f72	popq	%r14
0000000100008f74	popq	%r15
0000000100008f76	popq	%rbp
0000000100008f77	retq
0000000100008f78	callq	_fwp_rc_wide_dup
0000000100008f7d	movq	_fwp_cleanups(%rip), %rax
0000000100008f84	movq	0x10(%rbx), %rdi
0000000100008f88	movq	%rdi, -0xb8(%rbp)
0000000100008f8f	cmpq	%r14, %rax
0000000100008f92	je	0x100008a77
0000000100008f98	jmp	0x100008fb5
0000000100008f9a	movq	%rdi, %r15
0000000100008f9d	movq	%rax, %rdi
0000000100008fa0	callq	_fwp_rc_wide_dup
0000000100008fa5	movq	%r15, %rdi
0000000100008fa8	cmpq	%r14, _fwp_cleanups(%rip)
0000000100008faf	je	0x100008ca0
0000000100008fb5	callq	0x1000111aa                     ## symbol stub for: _abort
0000000100008fba	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100008fbf	leaq	0x89e0(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100008fc6	leaq	0x8a06(%rip), %rcx              ## literal pool for: "I8"
0000000100008fcd	jmp	0x100008fdd
0000000100008fcf	leaq	0x89d0(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100008fd6	leaq	0x89c5(%rip), %rcx              ## literal pool for: "I64"
0000000100008fdd	leaq	-0x90(%rbp), %rbx
0000000100008fe4	movl	$0x60, %esi
0000000100008fe9	movq	%rbx, %rdi
0000000100008fec	xorl	%eax, %eax
0000000100008fee	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100008ff3	callq	_fwp_flush
0000000100008ff8	movq	0xa039(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008fff	movq	(%rax), %rdi
0000000100009002	leaq	0x8986(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100009009	movq	%rbx, %rdx
000000010000900c	xorl	%eax, %eax
000000010000900e	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100009013	movl	$0x65, %edi
0000000100009018	callq	0x1000111c8                     ## symbol stub for: _exit
000000010000901d	nopl	(%rax)
_fwp_owner_release18:
0000000100009020	pushq	%rbp
0000000100009021	movq	%rsp, %rbp
0000000100009024	movq	(%rdi), %rdi
0000000100009027	popq	%rbp
0000000100009028	jmp	_fwp_drop5
000000010000902d	nopl	(%rax)
_fwp_owner_release19:
0000000100009030	pushq	%rbp
0000000100009031	movq	%rsp, %rbp
0000000100009034	movq	(%rdi), %rdi
0000000100009037	popq	%rbp
0000000100009038	jmp	_fwp_drop0
000000010000903d	nopl	(%rax)
_fwp_drop5:
0000000100009040	movq	%rdi, %rcx
0000000100009043	subq	0xbfee(%rip), %rcx
000000010000904a	movq	0xc00f(%rip), %rax
0000000100009051	shlq	$0x10, %rax
0000000100009055	cmpq	%rax, %rcx
0000000100009058	jae	0x1000090ee
000000010000905e	movq	0xc01b(%rip), %rdx
0000000100009065	movq	%rcx, %rax
0000000100009068	shrq	$0x10, %rax
000000010000906c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009073	leaq	(%rdx,%rsi), %rax
0000000100009077	movzbl	(%rdx,%rsi), %edx
000000010000907b	cmpb	$0x2, %dl
000000010000907e	setne	%sil
0000000100009082	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009089	setne	%r8b
000000010000908d	orb	%sil, %r8b
0000000100009090	jne	0x10000909a
0000000100009092	addq	$0x228, %rax                    ## imm = 0x228
0000000100009098	jmp	0x1000090b3
000000010000909a	cmpb	$0x1, %dl
000000010000909d	jne	0x1000090ee
000000010000909f	movl	0x20(%rax), %edx
00000001000090a2	imulq	%rdx, %rcx
00000001000090a6	shrq	$0x20, %rcx
00000001000090aa	addq	%rcx, %rax
00000001000090ad	addq	$0x228, %rax                    ## imm = 0x228
00000001000090b3	movzbl	(%rax), %ecx
00000001000090b6	testl	%ecx, %ecx
00000001000090b8	je	0x1000090ee
00000001000090ba	cmpl	$0x1, %ecx
00000001000090bd	jne	0x1000090e2
00000001000090bf	pushq	%rbp
00000001000090c0	movq	%rsp, %rbp
00000001000090c3	pushq	%rbx
00000001000090c4	pushq	%rax
00000001000090c5	movq	0x10(%rdi), %rax
00000001000090c9	movq	%rdi, %rbx
00000001000090cc	movq	%rax, %rdi
00000001000090cf	callq	_fwp_drop0
00000001000090d4	movq	%rbx, %rdi
00000001000090d7	addq	$0x8, %rsp
00000001000090db	popq	%rbx
00000001000090dc	popq	%rbp
00000001000090dd	jmp	_fwp_rc_free_obj
00000001000090e2	cmpl	$0xff, %ecx
00000001000090e8	je	0x1000090ef
00000001000090ea	decb	%cl
00000001000090ec	movb	%cl, (%rax)
00000001000090ee	retq
00000001000090ef	movq	%rax, %rdi
00000001000090f2	jmp	_fwp_rc_wide_drop
00000001000090f7	nopw	(%rax,%rax)
_fwp_owner_release13:
0000000100009100	pushq	%rbp
0000000100009101	movq	%rsp, %rbp
0000000100009104	movq	(%rdi), %rdi
0000000100009107	popq	%rbp
0000000100009108	jmp	_fwp_drop0
000000010000910d	nopl	(%rax)
_fwp_owner_release14:
0000000100009110	pushq	%rbp
0000000100009111	movq	%rsp, %rbp
0000000100009114	movq	(%rdi), %rdi
0000000100009117	popq	%rbp
0000000100009118	jmp	_fwp_drop0
000000010000911d	nopl	(%rax)
_fwp_owner_release15:
0000000100009120	pushq	%rbp
0000000100009121	movq	%rsp, %rbp
0000000100009124	pushq	%rbx
0000000100009125	pushq	%rax
0000000100009126	movq	%rdi, %rbx
0000000100009129	movq	(%rdi), %rdi
000000010000912c	callq	_fwp_drop0
0000000100009131	movq	0x8(%rbx), %rdi
0000000100009135	addq	$0x8, %rsp
0000000100009139	popq	%rbx
000000010000913a	popq	%rbp
000000010000913b	jmp	_fwp_drop0
_fwp_owner_release16:
0000000100009140	pushq	%rbp
0000000100009141	movq	%rsp, %rbp
0000000100009144	movq	(%rdi), %rdi
0000000100009147	popq	%rbp
0000000100009148	jmp	_fwp_drop0
000000010000914d	nopl	(%rax)
_fwp_owner_release17:
0000000100009150	pushq	%rbp
0000000100009151	movq	%rsp, %rbp
0000000100009154	movq	(%rdi), %rax
0000000100009157	subq	0xbeda(%rip), %rax
000000010000915e	movq	0xbefb(%rip), %rcx
0000000100009165	shlq	$0x10, %rcx
0000000100009169	cmpq	%rcx, %rax
000000010000916c	jae	0x1000091d2
000000010000916e	movq	0xbf0b(%rip), %rcx
0000000100009175	movq	%rax, %rdx
0000000100009178	shrq	$0x10, %rdx
000000010000917c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009183	leaq	(%rcx,%rdx), %rdi
0000000100009187	movzbl	(%rcx,%rdx), %ecx
000000010000918b	cmpb	$0x2, %cl
000000010000918e	setne	%dl
0000000100009191	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009197	setne	%sil
000000010000919b	orb	%dl, %sil
000000010000919e	jne	0x1000091a9
00000001000091a0	addq	$0x228, %rdi                    ## imm = 0x228
00000001000091a7	jmp	0x1000091c3
00000001000091a9	cmpb	$0x1, %cl
00000001000091ac	jne	0x1000091d2
00000001000091ae	movl	0x20(%rdi), %ecx
00000001000091b1	imulq	%rcx, %rax
00000001000091b5	shrq	$0x20, %rax
00000001000091b9	addq	%rax, %rdi
00000001000091bc	addq	$0x228, %rdi                    ## imm = 0x228
00000001000091c3	movzbl	(%rdi), %eax
00000001000091c6	cmpb	$0x2, %al
00000001000091c8	jb	0x1000091d2
00000001000091ca	cmpb	$-0x1, %al
00000001000091cc	je	0x1000091d4
00000001000091ce	decb	%al
00000001000091d0	movb	%al, (%rdi)
00000001000091d2	popq	%rbp
00000001000091d3	retq
00000001000091d4	popq	%rbp
00000001000091d5	jmp	_fwp_rc_wide_drop
00000001000091da	nopw	(%rax,%rax)
_fwp_owned_entry35:
00000001000091e0	pushq	%rbp
00000001000091e1	movq	%rsp, %rbp
00000001000091e4	movq	(%rdi), %rdi
00000001000091e7	popq	%rbp
00000001000091e8	jmp	_f35
00000001000091ed	nopl	(%rax)
_fwp_caps35:
00000001000091f0	movl	0x4(%rdi), %eax
00000001000091f3	testl	%esi, %esi
00000001000091f5	je	0x100009259
00000001000091f7	testl	%eax, %eax
00000001000091f9	je	0x1000092b1
00000001000091ff	movq	0x8(%rdi), %rax
0000000100009203	subq	0xbe2e(%rip), %rax
000000010000920a	movq	0xbe4f(%rip), %rcx
0000000100009211	shlq	$0x10, %rcx
0000000100009215	cmpq	%rcx, %rax
0000000100009218	jae	0x1000092b1
000000010000921e	movq	0xbe5b(%rip), %rcx
0000000100009225	movq	%rax, %rdx
0000000100009228	shrq	$0x10, %rdx
000000010000922c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009233	leaq	(%rcx,%rdx), %rdi
0000000100009237	movzbl	(%rcx,%rdx), %ecx
000000010000923b	cmpb	$0x2, %cl
000000010000923e	setne	%dl
0000000100009241	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009247	setne	%sil
000000010000924b	orb	%dl, %sil
000000010000924e	jne	0x100009284
0000000100009250	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009257	jmp	0x10000929e
0000000100009259	testl	%eax, %eax
000000010000925b	je	_fwp_rc_free_obj
0000000100009261	pushq	%rbp
0000000100009262	movq	%rsp, %rbp
0000000100009265	pushq	%rbx
0000000100009266	pushq	%rax
0000000100009267	movq	0x8(%rdi), %rax
000000010000926b	movq	%rdi, %rbx
000000010000926e	movq	%rax, %rdi
0000000100009271	callq	_fwp_drop5
0000000100009276	movq	%rbx, %rdi
0000000100009279	addq	$0x8, %rsp
000000010000927d	popq	%rbx
000000010000927e	popq	%rbp
000000010000927f	jmp	_fwp_rc_free_obj
0000000100009284	cmpb	$0x1, %cl
0000000100009287	jne	0x1000092b1
0000000100009289	movl	0x20(%rdi), %ecx
000000010000928c	imulq	%rcx, %rax
0000000100009290	shrq	$0x20, %rax
0000000100009294	addq	%rax, %rdi
0000000100009297	addq	$0x228, %rdi                    ## imm = 0x228
000000010000929e	movzbl	(%rdi), %eax
00000001000092a1	testb	%al, %al
00000001000092a3	je	0x1000092b1
00000001000092a5	cmpb	$-0x2, %al
00000001000092a7	jae	_fwp_rc_wide_dup
00000001000092ad	incb	%al
00000001000092af	movb	%al, (%rdi)
00000001000092b1	retq
00000001000092b2	nopw	%cs:(%rax,%rax)
_fwp_args35:
00000001000092c0	pushq	%rbp
00000001000092c1	movq	%rsp, %rbp
00000001000092c4	testl	%esi, %esi
00000001000092c6	setne	%al
00000001000092c9	testl	%edx, %edx
00000001000092cb	sete	%cl
00000001000092ce	orb	%al, %cl
00000001000092d0	jne	0x100009350
00000001000092d2	movq	(%rdi), %rax
00000001000092d5	subq	0xbd5c(%rip), %rax
00000001000092dc	movq	0xbd7d(%rip), %rcx
00000001000092e3	shlq	$0x10, %rcx
00000001000092e7	cmpq	%rcx, %rax
00000001000092ea	jae	0x100009350
00000001000092ec	movq	0xbd8d(%rip), %rcx
00000001000092f3	movq	%rax, %rdx
00000001000092f6	shrq	$0x10, %rdx
00000001000092fa	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009301	leaq	(%rcx,%rdx), %rdi
0000000100009305	movzbl	(%rcx,%rdx), %ecx
0000000100009309	cmpb	$0x2, %cl
000000010000930c	setne	%dl
000000010000930f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009315	setne	%sil
0000000100009319	orb	%dl, %sil
000000010000931c	jne	0x100009327
000000010000931e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009325	jmp	0x100009341
0000000100009327	cmpb	$0x1, %cl
000000010000932a	jne	0x100009350
000000010000932c	movl	0x20(%rdi), %ecx
000000010000932f	imulq	%rcx, %rax
0000000100009333	shrq	$0x20, %rax
0000000100009337	addq	%rax, %rdi
000000010000933a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009341	movzbl	(%rdi), %eax
0000000100009344	testb	%al, %al
0000000100009346	je	0x100009350
0000000100009348	cmpb	$-0x2, %al
000000010000934a	jae	0x100009352
000000010000934c	incb	%al
000000010000934e	movb	%al, (%rdi)
0000000100009350	popq	%rbp
0000000100009351	retq
0000000100009352	popq	%rbp
0000000100009353	jmp	_fwp_rc_wide_dup
0000000100009358	nopl	(%rax,%rax)
_fwp_arg_drop35:
0000000100009360	pushq	%rbp
0000000100009361	movq	%rsp, %rbp
0000000100009364	testl	%esi, %esi
0000000100009366	setne	%al
0000000100009369	testl	%edx, %edx
000000010000936b	sete	%cl
000000010000936e	orb	%al, %cl
0000000100009370	je	0x100009374
0000000100009372	popq	%rbp
0000000100009373	retq
0000000100009374	movq	(%rdi), %rdi
0000000100009377	popq	%rbp
0000000100009378	jmp	_fwp_drop5
000000010000937d	nopl	(%rax)
_f37:
0000000100009380	pushq	%rbp
0000000100009381	movq	%rsp, %rbp
0000000100009384	pushq	%r15
0000000100009386	pushq	%r14
0000000100009388	pushq	%r13
000000010000938a	pushq	%r12
000000010000938c	pushq	%rbx
000000010000938d	subq	$0x158, %rsp                    ## imm = 0x158
0000000100009394	movq	%rdi, %rbx
0000000100009397	movq	0x9c92(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000939e	movq	(%rax), %rax
00000001000093a1	movq	%rax, -0x30(%rbp)
00000001000093a5	movq	%rdi, -0xd8(%rbp)
00000001000093ac	movq	_fwp_cleanups(%rip), %rax
00000001000093b3	movq	%rax, -0xd0(%rbp)
00000001000093ba	leaq	_fwp_owner_release26(%rip), %rax
00000001000093c1	movq	%rax, -0xc8(%rbp)
00000001000093c8	leaq	-0xd8(%rbp), %rax
00000001000093cf	movq	%rax, -0xc0(%rbp)
00000001000093d6	movq	$0x0, -0xb8(%rbp)
00000001000093e1	leaq	-0xd0(%rbp), %r12
00000001000093e8	movq	%r12, -0x130(%rbp)
00000001000093ef	leaq	_fwp_owner_release27(%rip), %rax
00000001000093f6	movq	%rax, -0x128(%rbp)
00000001000093fd	leaq	-0xb8(%rbp), %rax
0000000100009404	movq	%rax, -0x120(%rbp)
000000010000940b	leaq	-0x130(%rbp), %r15
0000000100009412	movq	%r15, _fwp_cleanups(%rip)
0000000100009419	movq	0x10(%rdi), %rax
000000010000941d	subq	0xbc14(%rip), %rax
0000000100009424	movq	0xbc35(%rip), %rcx
000000010000942b	shlq	$0x10, %rcx
000000010000942f	cmpq	%rcx, %rax
0000000100009432	jae	0x10000949c
0000000100009434	movq	0xbc45(%rip), %rcx
000000010000943b	movq	%rax, %rdx
000000010000943e	shrq	$0x10, %rdx
0000000100009442	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009449	leaq	(%rcx,%rdx), %rdi
000000010000944d	movzbl	(%rcx,%rdx), %ecx
0000000100009451	cmpb	$0x2, %cl
0000000100009454	setne	%dl
0000000100009457	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000945d	setne	%sil
0000000100009461	orb	%dl, %sil
0000000100009464	jne	0x10000946f
0000000100009466	addq	$0x228, %rdi                    ## imm = 0x228
000000010000946d	jmp	0x100009489
000000010000946f	cmpb	$0x1, %cl
0000000100009472	jne	0x10000949c
0000000100009474	movl	0x20(%rdi), %ecx
0000000100009477	imulq	%rcx, %rax
000000010000947b	shrq	$0x20, %rax
000000010000947f	addq	%rax, %rdi
0000000100009482	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009489	movzbl	(%rdi), %eax
000000010000948c	testb	%al, %al
000000010000948e	je	0x10000949c
0000000100009490	cmpb	$-0x3, %al
0000000100009492	ja	0x1000099a2
0000000100009498	incb	%al
000000010000949a	movb	%al, (%rdi)
000000010000949c	movq	0x10(%rbx), %r14
00000001000094a0	movq	%r14, -0xb8(%rbp)
00000001000094a7	movq	-0x130(%rbp), %rax
00000001000094ae	movq	%rax, _fwp_cleanups(%rip)
00000001000094b5	movq	0x8(%rbx), %r13
00000001000094b9	movsbq	0x18(%rbx), %r15
00000001000094be	testq	%r13, %r13
00000001000094c1	js	0x1000094ea
00000001000094c3	movq	(%r14), %rax
00000001000094c6	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000094d0	andq	%rax, %rcx
00000001000094d3	cmpq	%r13, %rcx
00000001000094d6	jbe	0x1000094ea
00000001000094d8	testq	%rax, %rax
00000001000094db	js	0x1000095b3
00000001000094e1	leaq	0x8(%r14), %rax
00000001000094e5	jmp	0x1000095b7
00000001000094ea	movq	%r14, %rdi
00000001000094ed	callq	_fwp_drop0
00000001000094f2	movq	%r15, -0x90(%rbp)
00000001000094f9	movl	$0x10, %edi
00000001000094fe	callq	_fwp_alloc_init
0000000100009503	movq	%rax, %r14
0000000100009506	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100009510	movq	%rax, (%r14)
0000000100009513	movq	%r15, 0x8(%r14)
0000000100009517	leaq	-0x90(%rbp), %rax
000000010000951e	movq	%r14, %rax
0000000100009521	subq	0xbb10(%rip), %rax
0000000100009528	movq	0xbb31(%rip), %rcx
000000010000952f	shlq	$0x10, %rcx
0000000100009533	cmpq	%rcx, %rax
0000000100009536	jae	0x10000995e
000000010000953c	movq	0xbb3d(%rip), %rcx
0000000100009543	movq	%rax, %rdx
0000000100009546	shrq	$0x10, %rdx
000000010000954a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009551	leaq	(%rcx,%rdx), %r15
0000000100009555	movzbl	(%rcx,%rdx), %ecx
0000000100009559	cmpb	$0x2, %cl
000000010000955c	setne	%dl
000000010000955f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009565	setne	%sil
0000000100009569	orb	%dl, %sil
000000010000956c	jne	0x100009584
000000010000956e	addq	$0x228, %r15                    ## imm = 0x228
0000000100009575	cmpb	$-0x1, (%r15)
0000000100009579	je	0x1000095a9
000000010000957b	movb	$0x1, (%r15)
000000010000957f	jmp	0x10000995e
0000000100009584	cmpb	$0x1, %cl
0000000100009587	jne	0x10000995e
000000010000958d	movl	0x20(%r15), %ecx
0000000100009591	imulq	%rcx, %rax
0000000100009595	shrq	$0x20, %rax
0000000100009599	addq	%rax, %r15
000000010000959c	addq	$0x228, %r15                    ## imm = 0x228
00000001000095a3	cmpb	$-0x1, (%r15)
00000001000095a7	jne	0x10000957b
00000001000095a9	movq	%r15, %rdi
00000001000095ac	callq	_fwp_rc_forget_slot
00000001000095b1	jmp	0x10000957b
00000001000095b3	movq	0x10(%r14), %rax
00000001000095b7	movsbq	(%rax,%r13), %r12
00000001000095bc	movq	_fwp_cleanups(%rip), %rax
00000001000095c3	movq	%r14, -0x118(%rbp)
00000001000095ca	movq	%rax, -0x178(%rbp)
00000001000095d1	leaq	_fwp_owner_release21(%rip), %rcx
00000001000095d8	movq	%rcx, -0x170(%rbp)
00000001000095df	leaq	-0x118(%rbp), %rcx
00000001000095e6	movq	%rcx, -0x168(%rbp)
00000001000095ed	leaq	-0x178(%rbp), %rcx
00000001000095f4	movq	%rcx, _fwp_cleanups(%rip)
00000001000095fb	leaq	-0x7f(%r12), %rcx
0000000100009600	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100009607	jbe	0x1000099e7
000000010000960d	movq	%r14, -0x110(%rbp)
0000000100009614	movq	%rax, -0x108(%rbp)
000000010000961b	leaq	_fwp_owner_release22(%rip), %rax
0000000100009622	movq	%rax, -0x100(%rbp)
0000000100009629	leaq	-0x110(%rbp), %rax
0000000100009630	movq	%rax, -0xf8(%rbp)
0000000100009637	leaq	-0x108(%rbp), %rcx
000000010000963e	movq	%r14, %rax
0000000100009641	subq	0xb9f0(%rip), %rax
0000000100009648	movq	%rcx, _fwp_cleanups(%rip)
000000010000964f	movq	0xba0a(%rip), %rcx
0000000100009656	shlq	$0x10, %rcx
000000010000965a	cmpq	%rcx, %rax
000000010000965d	jae	0x1000096c7
000000010000965f	movq	0xba1a(%rip), %rcx
0000000100009666	movq	%rax, %rdx
0000000100009669	shrq	$0x10, %rdx
000000010000966d	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009674	leaq	(%rcx,%rdx), %rdi
0000000100009678	movzbl	(%rcx,%rdx), %ecx
000000010000967c	cmpb	$0x2, %cl
000000010000967f	setne	%dl
0000000100009682	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009688	setne	%sil
000000010000968c	orb	%dl, %sil
000000010000968f	jne	0x10000969a
0000000100009691	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009698	jmp	0x1000096b4
000000010000969a	cmpb	$0x1, %cl
000000010000969d	jne	0x1000096c7
000000010000969f	movl	0x20(%rdi), %ecx
00000001000096a2	imulq	%rcx, %rax
00000001000096a6	shrq	$0x20, %rax
00000001000096aa	addq	%rax, %rdi
00000001000096ad	addq	$0x228, %rdi                    ## imm = 0x228
00000001000096b4	movzbl	(%rdi), %eax
00000001000096b7	testb	%al, %al
00000001000096b9	je	0x1000096c7
00000001000096bb	cmpb	$-0x3, %al
00000001000096bd	ja	0x1000099c4
00000001000096c3	incb	%al
00000001000096c5	movb	%al, (%rdi)
00000001000096c7	movq	-0x108(%rbp), %rax
00000001000096ce	movq	%rax, _fwp_cleanups(%rip)
00000001000096d5	movq	%r14, %rdi
00000001000096d8	callq	_fwp_drop0
00000001000096dd	movq	%r14, -0xf0(%rbp)
00000001000096e4	movq	_fwp_cleanups(%rip), %rax
00000001000096eb	movq	%rax, -0x160(%rbp)
00000001000096f2	leaq	_fwp_owner_release23(%rip), %rcx
00000001000096f9	movq	%rcx, -0x158(%rbp)
0000000100009700	leaq	-0xf0(%rbp), %rcx
0000000100009707	movq	%rcx, -0x150(%rbp)
000000010000970e	leaq	-0x160(%rbp), %rcx
0000000100009715	movq	%rcx, _fwp_cleanups(%rip)
000000010000971c	addq	%r15, %r12
000000010000971f	incq	%r12
0000000100009722	movsbq	%r12b, %rcx
0000000100009726	cmpq	%r12, %rcx
0000000100009729	jne	0x1000099e7
000000010000972f	incq	%r13
0000000100009732	movq	%r14, -0xe8(%rbp)
0000000100009739	movq	%rax, -0x90(%rbp)
0000000100009740	leaq	_fwp_owner_release24(%rip), %rax
0000000100009747	movq	%rax, -0x88(%rbp)
000000010000974e	leaq	-0xe8(%rbp), %rax
0000000100009755	movq	%rax, -0x80(%rbp)
0000000100009759	leaq	-0x90(%rbp), %rax
0000000100009760	movq	%rax, _fwp_cleanups(%rip)
0000000100009767	movq	%r13, -0xa8(%rbp)
000000010000976e	movq	%r14, -0xa0(%rbp)
0000000100009775	movq	%r12, -0x98(%rbp)
000000010000977c	movl	$0x20, %edi
0000000100009781	callq	_fwp_alloc_init
0000000100009786	movq	%rax, %r15
0000000100009789	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100009793	movq	%rax, (%r15)
0000000100009796	movq	%r13, 0x8(%r15)
000000010000979a	movq	%r14, 0x10(%r15)
000000010000979e	movq	%r12, 0x18(%r15)
00000001000097a2	leaq	-0xa8(%rbp), %rax
00000001000097a9	movq	%r15, %rax
00000001000097ac	subq	0xb885(%rip), %rax
00000001000097b3	movq	0xb8a6(%rip), %rcx
00000001000097ba	shlq	$0x10, %rcx
00000001000097be	cmpq	%rcx, %rax
00000001000097c1	jae	0x100009833
00000001000097c3	movq	0xb8b6(%rip), %rcx
00000001000097ca	movq	%rax, %rdx
00000001000097cd	shrq	$0x10, %rdx
00000001000097d1	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000097d8	leaq	(%rcx,%rdx), %r14
00000001000097dc	movzbl	(%rcx,%rdx), %ecx
00000001000097e0	cmpb	$0x2, %cl
00000001000097e3	setne	%dl
00000001000097e6	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000097ec	setne	%sil
00000001000097f0	orb	%dl, %sil
00000001000097f3	jne	0x100009808
00000001000097f5	addq	$0x228, %r14                    ## imm = 0x228
00000001000097fc	cmpb	$-0x1, (%r14)
0000000100009800	je	0x100009829
0000000100009802	movb	$0x1, (%r14)
0000000100009806	jmp	0x100009833
0000000100009808	cmpb	$0x1, %cl
000000010000980b	jne	0x100009833
000000010000980d	movl	0x20(%r14), %ecx
0000000100009811	imulq	%rcx, %rax
0000000100009815	shrq	$0x20, %rax
0000000100009819	addq	%rax, %r14
000000010000981c	addq	$0x228, %r14                    ## imm = 0x228
0000000100009823	cmpb	$-0x1, (%r14)
0000000100009827	jne	0x100009802
0000000100009829	movq	%r14, %rdi
000000010000982c	callq	_fwp_rc_forget_slot
0000000100009831	jmp	0x100009802
0000000100009833	leaq	-0x90(%rbp), %rax
000000010000983a	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009841	jne	0x1000099dd
0000000100009847	movq	-0x90(%rbp), %rax
000000010000984e	movq	%r15, -0xe0(%rbp)
0000000100009855	movq	%rax, -0x148(%rbp)
000000010000985c	leaq	_fwp_owner_release25(%rip), %rax
0000000100009863	movq	%rax, -0x140(%rbp)
000000010000986a	leaq	-0xe0(%rbp), %rax
0000000100009871	movq	%rax, -0x138(%rbp)
0000000100009878	leaq	-0x148(%rbp), %r12
000000010000987f	movq	%r12, _fwp_cleanups(%rip)
0000000100009886	movq	%r15, -0xb0(%rbp)
000000010000988d	movl	$0x10, %edi
0000000100009892	callq	_fwp_alloc_init
0000000100009897	movq	%rax, %r14
000000010000989a	movabsq	$__mh_execute_header, %rax
00000001000098a4	movq	%rax, (%r14)
00000001000098a7	movq	%r15, 0x8(%r14)
00000001000098ab	leaq	-0xb0(%rbp), %rax
00000001000098b2	movq	%r14, %rax
00000001000098b5	subq	0xb77c(%rip), %rax
00000001000098bc	movq	0xb79d(%rip), %rcx
00000001000098c3	shlq	$0x10, %rcx
00000001000098c7	cmpq	%rcx, %rax
00000001000098ca	jae	0x10000993c
00000001000098cc	movq	0xb7ad(%rip), %rcx
00000001000098d3	movq	%rax, %rdx
00000001000098d6	shrq	$0x10, %rdx
00000001000098da	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000098e1	leaq	(%rcx,%rdx), %r15
00000001000098e5	movzbl	(%rcx,%rdx), %ecx
00000001000098e9	cmpb	$0x2, %cl
00000001000098ec	setne	%dl
00000001000098ef	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000098f5	setne	%sil
00000001000098f9	orb	%dl, %sil
00000001000098fc	jne	0x100009911
00000001000098fe	addq	$0x228, %r15                    ## imm = 0x228
0000000100009905	cmpb	$-0x1, (%r15)
0000000100009909	je	0x100009932
000000010000990b	movb	$0x1, (%r15)
000000010000990f	jmp	0x10000993c
0000000100009911	cmpb	$0x1, %cl
0000000100009914	jne	0x10000993c
0000000100009916	movl	0x20(%r15), %ecx
000000010000991a	imulq	%rcx, %rax
000000010000991e	shrq	$0x20, %rax
0000000100009922	addq	%rax, %r15
0000000100009925	addq	$0x228, %r15                    ## imm = 0x228
000000010000992c	cmpb	$-0x1, (%r15)
0000000100009930	jne	0x10000990b
0000000100009932	movq	%r15, %rdi
0000000100009935	callq	_fwp_rc_forget_slot
000000010000993a	jmp	0x10000990b
000000010000993c	cmpq	%r12, _fwp_cleanups(%rip)
0000000100009943	jne	0x1000099dd
0000000100009949	movq	-0x148(%rbp), %rax
0000000100009950	movq	%rax, _fwp_cleanups(%rip)
0000000100009957	leaq	-0xd0(%rbp), %r12
000000010000995e	cmpq	%r12, _fwp_cleanups(%rip)
0000000100009965	jne	0x1000099dd
0000000100009967	movq	-0xd0(%rbp), %rax
000000010000996e	movq	%rax, _fwp_cleanups(%rip)
0000000100009975	movq	%rbx, %rdi
0000000100009978	callq	_fwp_drop6
000000010000997d	movq	0x96ac(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100009984	movq	(%rax), %rax
0000000100009987	cmpq	-0x30(%rbp), %rax
000000010000998b	jne	0x1000099e2
000000010000998d	movq	%r14, %rax
0000000100009990	addq	$0x158, %rsp                    ## imm = 0x158
0000000100009997	popq	%rbx
0000000100009998	popq	%r12
000000010000999a	popq	%r13
000000010000999c	popq	%r14
000000010000999e	popq	%r15
00000001000099a0	popq	%rbp
00000001000099a1	retq
00000001000099a2	callq	_fwp_rc_wide_dup
00000001000099a7	movq	_fwp_cleanups(%rip), %rax
00000001000099ae	movq	0x10(%rbx), %r14
00000001000099b2	movq	%r14, -0xb8(%rbp)
00000001000099b9	cmpq	%r15, %rax
00000001000099bc	je	0x1000094a7
00000001000099c2	jmp	0x1000099dd
00000001000099c4	callq	_fwp_rc_wide_dup
00000001000099c9	leaq	-0x108(%rbp), %rax
00000001000099d0	cmpq	%rax, _fwp_cleanups(%rip)
00000001000099d7	je	0x1000096c7
00000001000099dd	callq	0x1000111aa                     ## symbol stub for: _abort
00000001000099e2	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
00000001000099e7	leaq	0x7fb8(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000099ee	leaq	0x7fde(%rip), %rcx              ## literal pool for: "I8"
00000001000099f5	leaq	-0x90(%rbp), %rbx
00000001000099fc	movl	$0x60, %esi
0000000100009a01	movq	%rbx, %rdi
0000000100009a04	xorl	%eax, %eax
0000000100009a06	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100009a0b	callq	_fwp_flush
0000000100009a10	movq	0x9621(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100009a17	movq	(%rax), %rdi
0000000100009a1a	leaq	0x7f6e(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100009a21	movq	%rbx, %rdx
0000000100009a24	xorl	%eax, %eax
0000000100009a26	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100009a2b	movl	$0x65, %edi
0000000100009a30	callq	0x1000111c8                     ## symbol stub for: _exit
0000000100009a35	nopw	%cs:(%rax,%rax)
_fwp_owner_release26:
0000000100009a40	pushq	%rbp
0000000100009a41	movq	%rsp, %rbp
0000000100009a44	movq	(%rdi), %rdi
0000000100009a47	popq	%rbp
0000000100009a48	jmp	_fwp_drop6
0000000100009a4d	nopl	(%rax)
_fwp_owner_release27:
0000000100009a50	pushq	%rbp
0000000100009a51	movq	%rsp, %rbp
0000000100009a54	movq	(%rdi), %rdi
0000000100009a57	popq	%rbp
0000000100009a58	jmp	_fwp_drop0
0000000100009a5d	nopl	(%rax)
_fwp_drop6:
0000000100009a60	movq	%rdi, %rcx
0000000100009a63	subq	0xb5ce(%rip), %rcx
0000000100009a6a	movq	0xb5ef(%rip), %rax
0000000100009a71	shlq	$0x10, %rax
0000000100009a75	cmpq	%rax, %rcx
0000000100009a78	jae	0x100009b0e
0000000100009a7e	movq	0xb5fb(%rip), %rdx
0000000100009a85	movq	%rcx, %rax
0000000100009a88	shrq	$0x10, %rax
0000000100009a8c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009a93	leaq	(%rdx,%rsi), %rax
0000000100009a97	movzbl	(%rdx,%rsi), %edx
0000000100009a9b	cmpb	$0x2, %dl
0000000100009a9e	setne	%sil
0000000100009aa2	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009aa9	setne	%r8b
0000000100009aad	orb	%sil, %r8b
0000000100009ab0	jne	0x100009aba
0000000100009ab2	addq	$0x228, %rax                    ## imm = 0x228
0000000100009ab8	jmp	0x100009ad3
0000000100009aba	cmpb	$0x1, %dl
0000000100009abd	jne	0x100009b0e
0000000100009abf	movl	0x20(%rax), %edx
0000000100009ac2	imulq	%rdx, %rcx
0000000100009ac6	shrq	$0x20, %rcx
0000000100009aca	addq	%rcx, %rax
0000000100009acd	addq	$0x228, %rax                    ## imm = 0x228
0000000100009ad3	movzbl	(%rax), %ecx
0000000100009ad6	testl	%ecx, %ecx
0000000100009ad8	je	0x100009b0e
0000000100009ada	cmpl	$0x1, %ecx
0000000100009add	jne	0x100009b02
0000000100009adf	pushq	%rbp
0000000100009ae0	movq	%rsp, %rbp
0000000100009ae3	pushq	%rbx
0000000100009ae4	pushq	%rax
0000000100009ae5	movq	0x10(%rdi), %rax
0000000100009ae9	movq	%rdi, %rbx
0000000100009aec	movq	%rax, %rdi
0000000100009aef	callq	_fwp_drop0
0000000100009af4	movq	%rbx, %rdi
0000000100009af7	addq	$0x8, %rsp
0000000100009afb	popq	%rbx
0000000100009afc	popq	%rbp
0000000100009afd	jmp	_fwp_rc_free_obj
0000000100009b02	cmpl	$0xff, %ecx
0000000100009b08	je	0x100009b0f
0000000100009b0a	decb	%cl
0000000100009b0c	movb	%cl, (%rax)
0000000100009b0e	retq
0000000100009b0f	movq	%rax, %rdi
0000000100009b12	jmp	_fwp_rc_wide_drop
0000000100009b17	nopw	(%rax,%rax)
_fwp_owner_release21:
0000000100009b20	pushq	%rbp
0000000100009b21	movq	%rsp, %rbp
0000000100009b24	movq	(%rdi), %rdi
0000000100009b27	popq	%rbp
0000000100009b28	jmp	_fwp_drop0
0000000100009b2d	nopl	(%rax)
_fwp_owner_release22:
0000000100009b30	pushq	%rbp
0000000100009b31	movq	%rsp, %rbp
0000000100009b34	movq	(%rdi), %rdi
0000000100009b37	popq	%rbp
0000000100009b38	jmp	_fwp_drop0
0000000100009b3d	nopl	(%rax)
_fwp_owner_release23:
0000000100009b40	pushq	%rbp
0000000100009b41	movq	%rsp, %rbp
0000000100009b44	movq	(%rdi), %rdi
0000000100009b47	popq	%rbp
0000000100009b48	jmp	_fwp_drop0
0000000100009b4d	nopl	(%rax)
_fwp_owner_release24:
0000000100009b50	pushq	%rbp
0000000100009b51	movq	%rsp, %rbp
0000000100009b54	movq	(%rdi), %rdi
0000000100009b57	popq	%rbp
0000000100009b58	jmp	_fwp_drop0
0000000100009b5d	nopl	(%rax)
_fwp_owner_release25:
0000000100009b60	pushq	%rbp
0000000100009b61	movq	%rsp, %rbp
0000000100009b64	movq	(%rdi), %rax
0000000100009b67	subq	0xb4ca(%rip), %rax
0000000100009b6e	movq	0xb4eb(%rip), %rcx
0000000100009b75	shlq	$0x10, %rcx
0000000100009b79	cmpq	%rcx, %rax
0000000100009b7c	jae	0x100009be2
0000000100009b7e	movq	0xb4fb(%rip), %rcx
0000000100009b85	movq	%rax, %rdx
0000000100009b88	shrq	$0x10, %rdx
0000000100009b8c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009b93	leaq	(%rcx,%rdx), %rdi
0000000100009b97	movzbl	(%rcx,%rdx), %ecx
0000000100009b9b	cmpb	$0x2, %cl
0000000100009b9e	setne	%dl
0000000100009ba1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009ba7	setne	%sil
0000000100009bab	orb	%dl, %sil
0000000100009bae	jne	0x100009bb9
0000000100009bb0	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009bb7	jmp	0x100009bd3
0000000100009bb9	cmpb	$0x1, %cl
0000000100009bbc	jne	0x100009be2
0000000100009bbe	movl	0x20(%rdi), %ecx
0000000100009bc1	imulq	%rcx, %rax
0000000100009bc5	shrq	$0x20, %rax
0000000100009bc9	addq	%rax, %rdi
0000000100009bcc	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009bd3	movzbl	(%rdi), %eax
0000000100009bd6	cmpb	$0x2, %al
0000000100009bd8	jb	0x100009be2
0000000100009bda	cmpb	$-0x1, %al
0000000100009bdc	je	0x100009be4
0000000100009bde	decb	%al
0000000100009be0	movb	%al, (%rdi)
0000000100009be2	popq	%rbp
0000000100009be3	retq
0000000100009be4	popq	%rbp
0000000100009be5	jmp	_fwp_rc_wide_drop
0000000100009bea	nopw	(%rax,%rax)
_fwp_owned_entry37:
0000000100009bf0	pushq	%rbp
0000000100009bf1	movq	%rsp, %rbp
0000000100009bf4	movq	(%rdi), %rdi
0000000100009bf7	popq	%rbp
0000000100009bf8	jmp	_f37
0000000100009bfd	nopl	(%rax)
_fwp_caps37:
0000000100009c00	movl	0x4(%rdi), %eax
0000000100009c03	testl	%esi, %esi
0000000100009c05	je	0x100009c69
0000000100009c07	testl	%eax, %eax
0000000100009c09	je	0x100009cc1
0000000100009c0f	movq	0x8(%rdi), %rax
0000000100009c13	subq	0xb41e(%rip), %rax
0000000100009c1a	movq	0xb43f(%rip), %rcx
0000000100009c21	shlq	$0x10, %rcx
0000000100009c25	cmpq	%rcx, %rax
0000000100009c28	jae	0x100009cc1
0000000100009c2e	movq	0xb44b(%rip), %rcx
0000000100009c35	movq	%rax, %rdx
0000000100009c38	shrq	$0x10, %rdx
0000000100009c3c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009c43	leaq	(%rcx,%rdx), %rdi
0000000100009c47	movzbl	(%rcx,%rdx), %ecx
0000000100009c4b	cmpb	$0x2, %cl
0000000100009c4e	setne	%dl
0000000100009c51	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009c57	setne	%sil
0000000100009c5b	orb	%dl, %sil
0000000100009c5e	jne	0x100009c94
0000000100009c60	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009c67	jmp	0x100009cae
0000000100009c69	testl	%eax, %eax
0000000100009c6b	je	_fwp_rc_free_obj
0000000100009c71	pushq	%rbp
0000000100009c72	movq	%rsp, %rbp
0000000100009c75	pushq	%rbx
0000000100009c76	pushq	%rax
0000000100009c77	movq	0x8(%rdi), %rax
0000000100009c7b	movq	%rdi, %rbx
0000000100009c7e	movq	%rax, %rdi
0000000100009c81	callq	_fwp_drop6
0000000100009c86	movq	%rbx, %rdi
0000000100009c89	addq	$0x8, %rsp
0000000100009c8d	popq	%rbx
0000000100009c8e	popq	%rbp
0000000100009c8f	jmp	_fwp_rc_free_obj
0000000100009c94	cmpb	$0x1, %cl
0000000100009c97	jne	0x100009cc1
0000000100009c99	movl	0x20(%rdi), %ecx
0000000100009c9c	imulq	%rcx, %rax
0000000100009ca0	shrq	$0x20, %rax
0000000100009ca4	addq	%rax, %rdi
0000000100009ca7	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009cae	movzbl	(%rdi), %eax
0000000100009cb1	testb	%al, %al
0000000100009cb3	je	0x100009cc1
0000000100009cb5	cmpb	$-0x2, %al
0000000100009cb7	jae	_fwp_rc_wide_dup
0000000100009cbd	incb	%al
0000000100009cbf	movb	%al, (%rdi)
0000000100009cc1	retq
0000000100009cc2	nopw	%cs:(%rax,%rax)
_fwp_args37:
0000000100009cd0	pushq	%rbp
0000000100009cd1	movq	%rsp, %rbp
0000000100009cd4	testl	%esi, %esi
0000000100009cd6	setne	%al
0000000100009cd9	testl	%edx, %edx
0000000100009cdb	sete	%cl
0000000100009cde	orb	%al, %cl
0000000100009ce0	jne	0x100009d60
0000000100009ce2	movq	(%rdi), %rax
0000000100009ce5	subq	0xb34c(%rip), %rax
0000000100009cec	movq	0xb36d(%rip), %rcx
0000000100009cf3	shlq	$0x10, %rcx
0000000100009cf7	cmpq	%rcx, %rax
0000000100009cfa	jae	0x100009d60
0000000100009cfc	movq	0xb37d(%rip), %rcx
0000000100009d03	movq	%rax, %rdx
0000000100009d06	shrq	$0x10, %rdx
0000000100009d0a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009d11	leaq	(%rcx,%rdx), %rdi
0000000100009d15	movzbl	(%rcx,%rdx), %ecx
0000000100009d19	cmpb	$0x2, %cl
0000000100009d1c	setne	%dl
0000000100009d1f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009d25	setne	%sil
0000000100009d29	orb	%dl, %sil
0000000100009d2c	jne	0x100009d37
0000000100009d2e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009d35	jmp	0x100009d51
0000000100009d37	cmpb	$0x1, %cl
0000000100009d3a	jne	0x100009d60
0000000100009d3c	movl	0x20(%rdi), %ecx
0000000100009d3f	imulq	%rcx, %rax
0000000100009d43	shrq	$0x20, %rax
0000000100009d47	addq	%rax, %rdi
0000000100009d4a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009d51	movzbl	(%rdi), %eax
0000000100009d54	testb	%al, %al
0000000100009d56	je	0x100009d60
0000000100009d58	cmpb	$-0x2, %al
0000000100009d5a	jae	0x100009d62
0000000100009d5c	incb	%al
0000000100009d5e	movb	%al, (%rdi)
0000000100009d60	popq	%rbp
0000000100009d61	retq
0000000100009d62	popq	%rbp
0000000100009d63	jmp	_fwp_rc_wide_dup
0000000100009d68	nopl	(%rax,%rax)
_fwp_arg_drop37:
0000000100009d70	pushq	%rbp
0000000100009d71	movq	%rsp, %rbp
0000000100009d74	testl	%esi, %esi
0000000100009d76	setne	%al
0000000100009d79	testl	%edx, %edx
0000000100009d7b	sete	%cl
0000000100009d7e	orb	%al, %cl
0000000100009d80	je	0x100009d84
0000000100009d82	popq	%rbp
0000000100009d83	retq
0000000100009d84	movq	(%rdi), %rdi
0000000100009d87	popq	%rbp
0000000100009d88	jmp	_fwp_drop6
0000000100009d8d	nopl	(%rax)
_fwp_segv:
0000000100009d90	movq	_fwp_main_stack_top(%rip), %rax
0000000100009d97	testq	%rax, %rax
0000000100009d9a	je	0x100009dc4
0000000100009d9c	movq	0x18(%rsi), %rcx
0000000100009da0	subq	_fwp_main_stack_size(%rip), %rax
0000000100009da7	leaq	-0x100000(%rax), %rdx
0000000100009dae	addq	$0x100000, %rax                 ## imm = 0x100000
0000000100009db4	cmpq	%rcx, %rdx
0000000100009db7	setbe	%dl
0000000100009dba	cmpq	%rcx, %rax
0000000100009dbd	seta	%al
0000000100009dc0	testb	%al, %dl
0000000100009dc2	jne	0x100009dcb
0000000100009dc4	xorl	%esi, %esi
0000000100009dc6	jmp	0x100011288                     ## symbol stub for: _signal
0000000100009dcb	pushq	%rbp
0000000100009dcc	movq	%rsp, %rbp
0000000100009dcf	callq	_fwp_flush
0000000100009dd4	leaq	_fwp_segv.msg(%rip), %rsi
0000000100009ddb	movl	$0x1a, %edx
0000000100009de0	movl	$0x2, %edi
0000000100009de5	callq	0x1000112dc                     ## symbol stub for: _write
0000000100009dea	movl	$0x65, %edi
0000000100009def	callq	0x1000111a4                     ## symbol stub for: __exit
0000000100009df4	nopw	%cs:(%rax,%rax)
_fwp_str_lossy:
0000000100009e00	pushq	%rbp
0000000100009e01	movq	%rsp, %rbp
0000000100009e04	pushq	%r15
0000000100009e06	pushq	%r14
0000000100009e08	pushq	%r13
0000000100009e0a	pushq	%r12
0000000100009e0c	pushq	%rbx
0000000100009e0d	subq	$0x28, %rsp
0000000100009e11	movq	%rsi, %rbx
0000000100009e14	movq	%rdi, %r14
0000000100009e17	testq	%rsi, %rsi
0000000100009e1a	je	0x100009f51
0000000100009e20	xorl	%eax, %eax
0000000100009e22	jmp	0x100009e3c
0000000100009e24	nopw	%cs:(%rax,%rax)
0000000100009e30	incq	%rax
0000000100009e33	cmpq	%rbx, %rax
0000000100009e36	jae	0x100009f51
0000000100009e3c	movzbl	(%r14,%rax), %edi
0000000100009e41	testb	%dil, %dil
0000000100009e44	jns	0x100009e30
0000000100009e46	leal	0x3e(%rdi), %ecx
0000000100009e49	cmpb	$0x1e, %cl
0000000100009e4c	jae	0x100009e5f
0000000100009e4e	movl	$0x80, %ecx
0000000100009e53	movl	$0x1, %esi
0000000100009e58	movl	$0x1f, %edx
0000000100009e5d	jmp	0x100009e95
0000000100009e5f	movl	%edi, %ecx
0000000100009e61	andb	$-0x10, %cl
0000000100009e64	cmpb	$-0x20, %cl
0000000100009e67	jne	0x100009e7a
0000000100009e69	movl	$0x800, %ecx                    ## imm = 0x800
0000000100009e6e	movl	$0x2, %esi
0000000100009e73	movl	$0xf, %edx
0000000100009e78	jmp	0x100009e95
0000000100009e7a	leal	0x10(%rdi), %ecx
0000000100009e7d	cmpb	$0x4, %cl
0000000100009e80	ja	0x100009f6a
0000000100009e86	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100009e8b	movl	$0x3, %esi
0000000100009e90	movl	$0x7, %edx
0000000100009e95	movl	%esi, %esi
0000000100009e97	leaq	(%rax,%rsi), %r8
0000000100009e9b	cmpq	%rbx, %r8
0000000100009e9e	jae	0x100009f6a
0000000100009ea4	movzbl	0x1(%r14,%rax), %r8d
0000000100009eaa	movl	%r8d, %r9d
0000000100009ead	andl	$-0x40, %r9d
0000000100009eb1	cmpl	$0x80, %r9d
0000000100009eb8	jne	0x100009f6a
0000000100009ebe	andl	%edi, %edx
0000000100009ec0	leal	0x1(%rsi), %r9d
0000000100009ec4	movl	%edx, %edi
0000000100009ec6	shll	$0x6, %edi
0000000100009ec9	andl	$0x3f, %r8d
0000000100009ecd	orl	%edi, %r8d
0000000100009ed0	cmpl	$0x2, %r9d
0000000100009ed4	jne	0x100009edb
0000000100009ed6	movl	%r8d, %r9d
0000000100009ed9	jmp	0x100009f27
0000000100009edb	movzbl	0x2(%r14,%rax), %edx
0000000100009ee1	movl	%edx, %edi
0000000100009ee3	andl	$-0x40, %edi
0000000100009ee6	cmpl	$0x80, %edi
0000000100009eec	jne	0x100009f6a
0000000100009eee	movl	%r8d, %edi
0000000100009ef1	shll	$0x6, %edi
0000000100009ef4	andl	$0x3f, %edx
0000000100009ef7	orl	%edi, %edx
0000000100009ef9	cmpl	$0x3, %r9d
0000000100009efd	jne	0x100009f07
0000000100009eff	movl	%edx, %r9d
0000000100009f02	movl	%r8d, %edx
0000000100009f05	jmp	0x100009f27
0000000100009f07	movzbl	0x3(%r14,%rax), %r9d
0000000100009f0d	movl	%r9d, %edi
0000000100009f10	andl	$-0x40, %edi
0000000100009f13	cmpl	$0x80, %edi
0000000100009f19	jne	0x100009f6a
0000000100009f1b	movl	%edx, %edi
0000000100009f1d	shll	$0x6, %edi
0000000100009f20	andl	$0x3f, %r9d
0000000100009f24	orl	%edi, %r9d
0000000100009f27	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
0000000100009f2d	cmpl	$0x360, %edx                    ## imm = 0x360
0000000100009f33	je	0x100009f6a
0000000100009f35	cmpl	$0x10ffff, %edi                 ## imm = 0x10FFFF
0000000100009f3b	ja	0x100009f6a
0000000100009f3d	cmpl	%ecx, %r9d
0000000100009f40	jb	0x100009f6a
0000000100009f42	addq	%rsi, %rax
0000000100009f45	incq	%rax
0000000100009f48	cmpq	%rbx, %rax
0000000100009f4b	jb	0x100009e3c
0000000100009f51	movq	%r14, %rdi
0000000100009f54	movq	%rbx, %rsi
0000000100009f57	addq	$0x28, %rsp
0000000100009f5b	popq	%rbx
0000000100009f5c	popq	%r12
0000000100009f5e	popq	%r13
0000000100009f60	popq	%r14
0000000100009f62	popq	%r15
0000000100009f64	popq	%rbp
0000000100009f65	jmp	_fwp_str_new
0000000100009f6a	xorps	%xmm0, %xmm0
0000000100009f6d	movaps	%xmm0, -0x50(%rbp)
0000000100009f71	movq	$0x0, -0x40(%rbp)
0000000100009f79	xorl	%r13d, %r13d
0000000100009f7c	leaq	-0x50(%rbp), %r15
0000000100009f80	jmp	0x100009fb6
0000000100009f82	nopw	%cs:(%rax,%rax)
0000000100009f90	movb	%al, -0x29(%rbp)
0000000100009f93	movl	$0x1, %edx
0000000100009f98	movq	%r15, %rdi
0000000100009f9b	leaq	-0x29(%rbp), %rsi
0000000100009f9f	callq	_buf_put
0000000100009fa4	incq	%r13
0000000100009fa7	movq	%r13, %r12
0000000100009faa	movq	%r12, %r13
0000000100009fad	cmpq	%rbx, %r12
0000000100009fb0	jae	0x10000a0fd
0000000100009fb6	movzbl	(%r14,%r13), %eax
0000000100009fbb	testb	%al, %al
0000000100009fbd	jns	0x100009f90
0000000100009fbf	leal	0x20(%rax), %ecx
0000000100009fc2	cmpb	$-0x1f, %cl
0000000100009fc5	ja	0x100009ffb
0000000100009fc7	movl	%eax, %edx
0000000100009fc9	andb	$-0x10, %dl
0000000100009fcc	cmpb	$-0x20, %dl
0000000100009fcf	jne	0x10000a0b9
0000000100009fd5	cmpb	$-0x20, %al
0000000100009fd7	sete	%sil
0000000100009fdb	shlb	$0x5, %sil
0000000100009fdf	orb	$-0x80, %sil
0000000100009fe3	xorl	%edi, %edi
0000000100009fe5	cmpb	$-0x13, %al
0000000100009fe7	setne	%dil
0000000100009feb	shll	$0x5, %edi
0000000100009fee	orl	$0x9f, %edi
0000000100009ff4	movl	$0x2, %eax
0000000100009ff9	jmp	0x10000a008
0000000100009ffb	movl	$0xbf, %edi
000000010000a000	movb	$-0x80, %sil
000000010000a003	movl	$0x1, %eax
000000010000a008	xorl	%edx, %edx
000000010000a00a	leaq	0x1(%r13), %r12
000000010000a00e	cmpq	%rbx, %r12
000000010000a011	jae	0x10000a0a0
000000010000a017	movzbl	(%r14,%r12), %r8d
000000010000a01c	cmpb	%sil, %r8b
000000010000a01f	jb	0x10000a0a0
000000010000a021	cmpl	%r8d, %edi
000000010000a024	jb	0x10000a0a0
000000010000a026	cmpb	$-0x1e, %cl
000000010000a029	setae	%sil
000000010000a02d	leaq	0x2(%r13), %r12
000000010000a031	cmpq	%rbx, %r12
000000010000a034	setae	%dil
000000010000a038	movl	$0x1, %ecx
000000010000a03d	orb	%sil, %dil
000000010000a040	jne	0x10000a089
000000010000a042	movzbl	(%r14,%r12), %esi
000000010000a047	andb	$-0x40, %sil
000000010000a04b	negb	%sil
000000010000a04e	jno	0x10000a089
000000010000a050	leaq	0x3(%r13), %r12
000000010000a054	cmpq	%rbx, %r12
000000010000a057	setae	%sil
000000010000a05b	xorb	$0x1, %dl
000000010000a05e	movl	$0x2, %ecx
000000010000a063	orb	%sil, %dl
000000010000a066	jne	0x10000a089
000000010000a068	movzbl	0x3(%r14,%r13), %esi
000000010000a06e	andb	$-0x40, %sil
000000010000a072	xorl	%ecx, %ecx
000000010000a074	cmpb	$-0x80, %sil
000000010000a078	sete	%dl
000000010000a07b	negb	%sil
000000010000a07e	jno	0x10000a084
000000010000a080	leaq	0x4(%r13), %r12
000000010000a084	movb	%dl, %cl
000000010000a086	orl	$0x2, %ecx
000000010000a089	cmpl	%eax, %ecx
000000010000a08b	jne	0x10000a0a0
000000010000a08d	leaq	(%r14,%r13), %rsi
000000010000a091	movq	%r12, %rdx
000000010000a094	subq	%r13, %rdx
000000010000a097	movq	%r15, %rdi
000000010000a09a	jmp	0x10000a0af
000000010000a09c	nopl	(%rax)
000000010000a0a0	movl	$0x3, %edx
000000010000a0a5	movq	%r15, %rdi
000000010000a0a8	leaq	0x84b8(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a0af	callq	_buf_put
000000010000a0b4	jmp	0x100009faa
000000010000a0b9	leal	0x10(%rax), %edx
000000010000a0bc	cmpb	$0x4, %dl
000000010000a0bf	ja	0x10000a0e9
000000010000a0c1	cmpb	$-0x10, %al
000000010000a0c3	sete	%sil
000000010000a0c7	movl	$0x8f, %edi
000000010000a0cc	cmpb	$-0xc, %al
000000010000a0ce	je	0x10000a0d5
000000010000a0d0	movl	$0xbf, %edi
000000010000a0d5	shlb	$0x4, %sil
000000010000a0d9	orb	$-0x80, %sil
000000010000a0dd	movl	$0x3, %eax
000000010000a0e2	movb	$0x1, %dl
000000010000a0e4	jmp	0x10000a00a
000000010000a0e9	movl	$0x3, %edx
000000010000a0ee	movq	%r15, %rdi
000000010000a0f1	leaq	0x846f(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a0f8	jmp	0x100009f9f
000000010000a0fd	movq	-0x50(%rbp), %rbx
000000010000a101	movq	-0x48(%rbp), %rsi
000000010000a105	testq	%rbx, %rbx
000000010000a108	leaq	0x77a3(%rip), %rdi              ## literal pool for: ""
000000010000a10f	cmovneq	%rbx, %rdi
000000010000a113	callq	_fwp_str_new
000000010000a118	movq	%rax, %r14
000000010000a11b	movq	%rbx, %rdi
000000010000a11e	callq	0x1000111f2                     ## symbol stub for: _free
000000010000a123	movq	%r14, %rax
000000010000a126	addq	$0x28, %rsp
000000010000a12a	popq	%rbx
000000010000a12b	popq	%r12
000000010000a12d	popq	%r13
000000010000a12f	popq	%r14
000000010000a131	popq	%r15
000000010000a133	popq	%rbp
000000010000a134	retq
000000010000a135	nopw	%cs:(%rax,%rax)
_fwp_alloc_leaf:
000000010000a140	pushq	%rbp
000000010000a141	movq	%rsp, %rbp
000000010000a144	pushq	%rbx
000000010000a145	pushq	%rax
000000010000a146	movq	%rdi, %rsi
000000010000a149	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000a150	ja	0x10000a1ab
000000010000a152	leaq	0xf(%rsi), %rax
000000010000a156	shrq	$0x4, %rax
000000010000a15a	leaq	_fwp_gc(%rip), %rcx
000000010000a161	movzbl	0xbe8(%rax,%rcx), %edx
000000010000a169	movl	0xb48(%rcx,%rdx,4), %eax
000000010000a170	subq	%rax, _fwp_gc(%rip)
000000010000a177	js	0x10000a1ab
000000010000a179	leaq	(%rdx,%rdx,2), %rdx
000000010000a17d	leaq	(%rcx,%rdx,8), %rcx
000000010000a181	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000a188	movq	(%rcx), %rbx
000000010000a18b	testq	%rbx, %rbx
000000010000a18e	je	0x10000a19b
000000010000a190	movq	(%rbx), %rax
000000010000a193	notq	%rax
000000010000a196	movq	%rax, (%rcx)
000000010000a199	jmp	0x10000a1c5
000000010000a19b	movq	0x8(%rcx), %rbx
000000010000a19f	movq	0x10(%rcx), %rdx
000000010000a1a3	subq	%rbx, %rdx
000000010000a1a6	cmpq	%rax, %rdx
000000010000a1a9	jae	0x10000a1be
000000010000a1ab	movq	%rsi, %rdi
000000010000a1ae	movl	$0x1, %esi
000000010000a1b3	addq	$0x8, %rsp
000000010000a1b7	popq	%rbx
000000010000a1b8	popq	%rbp
000000010000a1b9	jmp	_fwp_gc_alloc_slow
000000010000a1be	addq	%rbx, %rax
000000010000a1c1	movq	%rax, 0x8(%rcx)
000000010000a1c5	movq	%rbx, %rdi
000000010000a1c8	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000a1cd	movq	%rbx, %rax
000000010000a1d0	addq	$0x8, %rsp
000000010000a1d4	popq	%rbx
000000010000a1d5	popq	%rbp
000000010000a1d6	retq
000000010000a1d7	nopw	(%rax,%rax)
_fwp_exec_call:
000000010000a1e0	pushq	%rbp
000000010000a1e1	movq	%rsp, %rbp
000000010000a1e4	pushq	%r15
000000010000a1e6	pushq	%r14
000000010000a1e8	pushq	%r13
000000010000a1ea	pushq	%r12
000000010000a1ec	pushq	%rbx
000000010000a1ed	subq	$0xd8, %rsp
000000010000a1f4	movq	%rsi, %rbx
000000010000a1f7	movq	%rdi, %r14
000000010000a1fa	movq	_fwp_handlers(%rip), %rax
000000010000a201	movq	%rax, -0x68(%rbp)
000000010000a205	movq	$0x0, -0x50(%rbp)
000000010000a20d	movq	_fwp_cleanups(%rip), %rax
000000010000a214	movq	%rax, -0x48(%rbp)
000000010000a218	leaq	-0x100(%rbp), %rdi
000000010000a21f	movq	%rdi, _fwp_handlers(%rip)
000000010000a226	callq	0x100011270                     ## symbol stub for: _setjmp
000000010000a22b	testl	%eax, %eax
000000010000a22d	je	0x10000a31b
000000010000a233	movq	-0x68(%rbp), %rax
000000010000a237	movq	%rax, _fwp_handlers(%rip)
000000010000a23e	movq	_fwp_prog_out(%rip), %rdi
000000010000a245	testq	%rdi, %rdi
000000010000a248	je	0x10000a24f
000000010000a24a	callq	0x1000111ce                     ## symbol stub for: _fflush
000000010000a24f	movq	0x8df2(%rip), %r12              ## literal pool symbol address: ___stdoutp
000000010000a256	movq	(%r12), %rdi
000000010000a25a	callq	0x1000111ce                     ## symbol stub for: _fflush
000000010000a25f	movq	-0x60(%rbp), %r14
000000010000a263	movq	-0x58(%rbp), %r15
000000010000a267	movq	(%r12), %rdi
000000010000a26b	callq	0x1000111ce                     ## symbol stub for: _fflush
000000010000a270	movq	0x8dc1(%rip), %r13              ## literal pool symbol address: ___stderrp
000000010000a277	movq	(%r13), %rdi
000000010000a27b	leaq	0x8386(%rip), %rsi              ## literal pool for: "%s: "
000000010000a282	leaq	0x762d(%rip), %rdx              ## literal pool for: "reduce64"
000000010000a289	xorl	%eax, %eax
000000010000a28b	callq	0x1000111da                     ## symbol stub for: _fprintf
000000010000a290	cmpl	$0x10, (%r15)
000000010000a294	jne	0x10000a2d4
000000010000a296	movq	0x8(%r15), %rdi
000000010000a29a	testq	%rdi, %rdi
000000010000a29d	je	0x10000a2d4
000000010000a29f	leaq	0x8367(%rip), %rsi              ## literal pool for: "IoError"
000000010000a2a6	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000a2ab	testl	%eax, %eax
000000010000a2ad	jne	0x10000a2d4
000000010000a2af	cmpl	$0x2, 0x10(%r15)
000000010000a2b4	jne	0x10000a2d4
000000010000a2b6	movq	0x10(%r14), %rdi
000000010000a2ba	movq	(%rdi), %rdx
000000010000a2bd	addq	$0x8, %rdi
000000010000a2c1	movq	(%r13), %rcx
000000010000a2c5	movl	$0x1, %esi
000000010000a2ca	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000a2cf	jmp	0x10000a365
000000010000a2d4	movq	(%r13), %r12
000000010000a2d8	xorps	%xmm0, %xmm0
000000010000a2db	movaps	%xmm0, -0x40(%rbp)
000000010000a2df	movq	$0x0, -0x30(%rbp)
000000010000a2e7	leaq	-0x40(%rbp), %rdi
000000010000a2eb	movq	%r14, %rsi
000000010000a2ee	movq	%r15, %rdx
000000010000a2f1	movl	$0x1, %ecx
000000010000a2f6	callq	_fwp_write
000000010000a2fb	movq	-0x40(%rbp), %rdi
000000010000a2ff	testq	%rdi, %rdi
000000010000a302	je	0x10000a35c
000000010000a304	movq	-0x38(%rbp), %rdx
000000010000a308	movl	$0x1, %esi
000000010000a30d	movq	%r12, %rcx
000000010000a310	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000a315	movq	-0x40(%rbp), %rdi
000000010000a319	jmp	0x10000a360
000000010000a31b	leaq	_fwp_gc(%rip), %rax
000000010000a322	movzbl	0xa8c8(%rip), %ecx
000000010000a329	movl	0xb48(%rax,%rcx,4), %edx
000000010000a330	movl	%edx, %esi
000000010000a332	subq	%rsi, _fwp_gc(%rip)
000000010000a339	js	0x10000a38c
000000010000a33b	leaq	(%rcx,%rcx,2), %rcx
000000010000a33f	leaq	(%rax,%rcx,8), %rax
000000010000a343	addq	$0x788, %rax                    ## imm = 0x788
000000010000a349	movq	(%rax), %r15
000000010000a34c	testq	%r15, %r15
000000010000a34f	je	0x10000a37c
000000010000a351	movq	(%r15), %rcx
000000010000a354	notq	%rcx
000000010000a357	movq	%rcx, (%rax)
000000010000a35a	jmp	0x10000a3a8
000000010000a35c	xorl	%eax, %eax
000000010000a35e	movl	%eax, %edi
000000010000a360	callq	0x1000111f2                     ## symbol stub for: _free
000000010000a365	movq	(%r13), %rsi
000000010000a369	movl	$0xa, %edi
000000010000a36e	callq	0x1000111e0                     ## symbol stub for: _fputc
000000010000a373	movl	$0x1, %ecx
000000010000a378	xorl	%eax, %eax
000000010000a37a	jmp	0x10000a3d4
000000010000a37c	movq	0x8(%rax), %r15
000000010000a380	movq	0x10(%rax), %rcx
000000010000a384	subq	%r15, %rcx
000000010000a387	cmpq	%rsi, %rcx
000000010000a38a	jae	0x10000a3a0
000000010000a38c	movl	$0x8, %edi
000000010000a391	movl	$0x2, %esi
000000010000a396	callq	_fwp_gc_alloc_slow
000000010000a39b	movq	%rax, %rdi
000000010000a39e	jmp	0x10000a3b3
000000010000a3a0	leaq	(%r15,%rsi), %rcx
000000010000a3a4	movq	%rcx, 0x8(%rax)
000000010000a3a8	movq	%r15, %rdi
000000010000a3ab	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000a3b0	movq	%r15, %rdi
000000010000a3b3	movq	$0x0, (%rdi)
000000010000a3ba	movl	$0x1, %esi
000000010000a3bf	movq	%r14, %rdx
000000010000a3c2	callq	_fwp_apply
000000010000a3c7	movq	-0x68(%rbp), %rcx
000000010000a3cb	movq	%rcx, _fwp_handlers(%rip)
000000010000a3d2	xorl	%ecx, %ecx
000000010000a3d4	movl	%ecx, (%rbx)
000000010000a3d6	addq	$0xd8, %rsp
000000010000a3dd	popq	%rbx
000000010000a3de	popq	%r12
000000010000a3e0	popq	%r13
000000010000a3e2	popq	%r14
000000010000a3e4	popq	%r15
000000010000a3e6	popq	%rbp
000000010000a3e7	retq
000000010000a3e8	nopl	(%rax,%rax)
_fwp_emit_result:
000000010000a3f0	pushq	%rbp
000000010000a3f1	movq	%rsp, %rbp
000000010000a3f4	pushq	%r15
000000010000a3f6	pushq	%r14
000000010000a3f8	pushq	%rbx
000000010000a3f9	subq	$0x28, %rsp
000000010000a3fd	movq	%rdi, %rbx
000000010000a400	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000a407	je	0x10000a52d
000000010000a40d	xorps	%xmm0, %xmm0
000000010000a410	movaps	%xmm0, -0x40(%rbp)
000000010000a414	movq	$0x0, -0x30(%rbp)
000000010000a41c	movb	%bl, -0x1d(%rbp)
000000010000a41f	leaq	-0x40(%rbp), %r15
000000010000a423	leaq	-0x1d(%rbp), %r14
000000010000a427	movl	$0x1, %edx
000000010000a42c	movq	%r15, %rdi
000000010000a42f	movq	%r14, %rsi
000000010000a432	callq	_buf_put
000000010000a437	movb	%bh, -0x1d(%rbp)
000000010000a43a	movl	$0x1, %edx
000000010000a43f	movq	%r15, %rdi
000000010000a442	movq	%r14, %rsi
000000010000a445	callq	_buf_put
000000010000a44a	movl	%ebx, %eax
000000010000a44c	shrl	$0x10, %eax
000000010000a44f	movb	%al, -0x1d(%rbp)
000000010000a452	movl	$0x1, %edx
000000010000a457	movq	%r15, %rdi
000000010000a45a	movq	%r14, %rsi
000000010000a45d	callq	_buf_put
000000010000a462	movl	%ebx, %eax
000000010000a464	shrl	$0x18, %eax
000000010000a467	movb	%al, -0x1d(%rbp)
000000010000a46a	movl	$0x1, %edx
000000010000a46f	movq	%r15, %rdi
000000010000a472	movq	%r14, %rsi
000000010000a475	callq	_buf_put
000000010000a47a	movq	%rbx, %rax
000000010000a47d	shrq	$0x20, %rax
000000010000a481	movb	%al, -0x1d(%rbp)
000000010000a484	movl	$0x1, %edx
000000010000a489	movq	%r15, %rdi
000000010000a48c	movq	%r14, %rsi
000000010000a48f	callq	_buf_put
000000010000a494	movq	%rbx, %rax
000000010000a497	shrq	$0x28, %rax
000000010000a49b	movb	%al, -0x1d(%rbp)
000000010000a49e	movl	$0x1, %edx
000000010000a4a3	movq	%r15, %rdi
000000010000a4a6	movq	%r14, %rsi
000000010000a4a9	callq	_buf_put
000000010000a4ae	movq	%rbx, %rax
000000010000a4b1	shrq	$0x30, %rax
000000010000a4b5	movb	%al, -0x1d(%rbp)
000000010000a4b8	movl	$0x1, %edx
000000010000a4bd	movq	%r15, %rdi
000000010000a4c0	movq	%r14, %rsi
000000010000a4c3	callq	_buf_put
000000010000a4c8	shrq	$0x38, %rbx
000000010000a4cc	movb	%bl, -0x1d(%rbp)
000000010000a4cf	movl	$0x1, %edx
000000010000a4d4	movq	%r15, %rdi
000000010000a4d7	movq	%r14, %rsi
000000010000a4da	callq	_buf_put
000000010000a4df	movb	$0x1, -0x1d(%rbp)
000000010000a4e3	movq	-0x38(%rbp), %rbx
000000010000a4e7	movl	%ebx, -0x1c(%rbp)
000000010000a4ea	movq	0x8b57(%rip), %r15              ## literal pool symbol address: ___stdoutp
000000010000a4f1	movq	(%r15), %rcx
000000010000a4f4	leaq	-0x1d(%rbp), %rdi
000000010000a4f8	movl	$0x1, %esi
000000010000a4fd	movl	$0x5, %edx
000000010000a502	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000a507	movq	-0x40(%rbp), %r14
000000010000a50b	testq	%rbx, %rbx
000000010000a50e	je	0x10000a523
000000010000a510	movq	(%r15), %rcx
000000010000a513	movl	$0x1, %esi
000000010000a518	movq	%r14, %rdi
000000010000a51b	movq	%rbx, %rdx
000000010000a51e	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000a523	movq	%r14, %rdi
000000010000a526	callq	0x1000111f2                     ## symbol stub for: _free
000000010000a52b	jmp	0x10000a592
000000010000a52d	movq	0x8b14(%rip), %r15              ## literal pool symbol address: ___stdoutp
000000010000a534	movq	(%r15), %r14
000000010000a537	xorps	%xmm0, %xmm0
000000010000a53a	movaps	%xmm0, -0x40(%rbp)
000000010000a53e	movq	$0x0, -0x30(%rbp)
000000010000a546	leaq	_d0(%rip), %rdx
000000010000a54d	leaq	-0x40(%rbp), %rdi
000000010000a551	movq	%rbx, %rsi
000000010000a554	movl	$0x1, %ecx
000000010000a559	callq	_fwp_write
000000010000a55e	movq	-0x40(%rbp), %rdi
000000010000a562	testq	%rdi, %rdi
000000010000a565	je	0x10000a57e
000000010000a567	movq	-0x38(%rbp), %rdx
000000010000a56b	movl	$0x1, %esi
000000010000a570	movq	%r14, %rcx
000000010000a573	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000a578	movq	-0x40(%rbp), %rdi
000000010000a57c	jmp	0x10000a580
000000010000a57e	xorl	%edi, %edi
000000010000a580	callq	0x1000111f2                     ## symbol stub for: _free
000000010000a585	movq	(%r15), %rsi
000000010000a588	movl	$0xa, %edi
000000010000a58d	callq	0x1000111e0                     ## symbol stub for: _fputc
000000010000a592	addq	$0x28, %rsp
000000010000a596	popq	%rbx
000000010000a597	popq	%r14
000000010000a599	popq	%r15
000000010000a59b	popq	%rbp
000000010000a59c	retq
000000010000a59d	nopl	(%rax)
_fwp_read_exact:
000000010000a5a0	pushq	%rbp
000000010000a5a1	movq	%rsp, %rbp
000000010000a5a4	pushq	%r15
000000010000a5a6	pushq	%r14
000000010000a5a8	pushq	%r12
000000010000a5aa	pushq	%rbx
000000010000a5ab	movq	%rsi, %rbx
000000010000a5ae	movq	%rdi, %r14
000000010000a5b1	movl	_fwp_in_npend(%rip), %eax
000000010000a5b7	movl	_fwp_in_ppos(%rip), %ecx
000000010000a5bd	testq	%rsi, %rsi
000000010000a5c0	setne	%dl
000000010000a5c3	cmpl	%eax, %ecx
000000010000a5c5	setl	%sil
000000010000a5c9	testb	%sil, %dl
000000010000a5cc	je	0x10000a63a
000000010000a5ce	cltq
000000010000a5d0	movslq	%ecx, %rsi
000000010000a5d3	movq	%rsi, %rdx
000000010000a5d6	notq	%rdx
000000010000a5d9	addq	%rax, %rdx
000000010000a5dc	leaq	-0x1(%rbx), %rcx
000000010000a5e0	cmpq	%rcx, %rdx
000000010000a5e3	cmovaeq	%rcx, %rdx
000000010000a5e7	incq	%rdx
000000010000a5ea	cmpq	$0x1f, %rdx
000000010000a5ee	jbe	0x10000a606
000000010000a5f0	leaq	_fwp_in_pend(%rip), %rdi
000000010000a5f7	movq	%r14, %r8
000000010000a5fa	subq	%rsi, %r8
000000010000a5fd	subq	%rdi, %r8
000000010000a600	cmpq	$0x20, %r8
000000010000a604	jae	0x10000a63f
000000010000a606	xorl	%r15d, %r15d
000000010000a609	movq	%rsi, %rcx
000000010000a60c	leaq	_fwp_in_pend(%rip), %rdx
000000010000a613	nopw	%cs:(%rax,%rax)
000000010000a620	movzbl	(%rcx,%rdx), %esi
000000010000a624	incq	%rcx
000000010000a627	movb	%sil, (%r14,%r15)
000000010000a62b	incq	%r15
000000010000a62e	cmpq	%rbx, %r15
000000010000a631	jae	0x10000a682
000000010000a633	cmpq	%rax, %rcx
000000010000a636	jl	0x10000a620
000000010000a638	jmp	0x10000a682
000000010000a63a	xorl	%r15d, %r15d
000000010000a63d	jmp	0x10000a688
000000010000a63f	movq	%rdx, %r15
000000010000a642	andq	$-0x20, %r15
000000010000a646	leaq	(%r15,%rsi), %rcx
000000010000a64a	addq	%rdi, %rsi
000000010000a64d	addq	$0x10, %rsi
000000010000a651	xorl	%edi, %edi
000000010000a653	nopw	%cs:(%rax,%rax)
000000010000a660	movups	-0x10(%rsi,%rdi), %xmm0
000000010000a665	movups	(%rsi,%rdi), %xmm1
000000010000a669	movups	%xmm0, (%r14,%rdi)
000000010000a66e	movups	%xmm1, 0x10(%r14,%rdi)
000000010000a674	addq	$0x20, %rdi
000000010000a678	cmpq	%rdi, %r15
000000010000a67b	jne	0x10000a660
000000010000a67d	cmpq	%r15, %rdx
000000010000a680	jne	0x10000a60c
000000010000a682	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a688	movq	0x89b1(%rip), %r12              ## literal pool symbol address: ___stdinp
000000010000a68f	nop
000000010000a690	movq	%rbx, %rdx
000000010000a693	subq	%r15, %rdx
000000010000a696	jbe	0x10000a6b6
000000010000a698	leaq	(%r14,%r15), %rdi
000000010000a69c	movq	(%r12), %rcx
000000010000a6a0	movl	$0x1, %esi
000000010000a6a5	callq	0x1000111ec                     ## symbol stub for: _fread
000000010000a6aa	addq	%rax, %r15
000000010000a6ad	testq	%rax, %rax
000000010000a6b0	jne	0x10000a690
000000010000a6b2	xorl	%eax, %eax
000000010000a6b4	jmp	0x10000a6bb
000000010000a6b6	movl	$0x1, %eax
000000010000a6bb	popq	%rbx
000000010000a6bc	popq	%r12
000000010000a6be	popq	%r14
000000010000a6c0	popq	%r15
000000010000a6c2	popq	%rbp
000000010000a6c3	retq
000000010000a6c4	nopw	%cs:(%rax,%rax)
_fwp_stdin_leb:
000000010000a6d0	pushq	%rbp
000000010000a6d1	movq	%rsp, %rbp
000000010000a6d4	pushq	%r15
000000010000a6d6	pushq	%r14
000000010000a6d8	pushq	%r13
000000010000a6da	pushq	%r12
000000010000a6dc	pushq	%rbx
000000010000a6dd	pushq	%rax
000000010000a6de	movq	%rdi, %rbx
000000010000a6e1	movq	$0x0, (%rdi)
000000010000a6e8	movq	$-0x7, %r14
000000010000a6ef	leaq	_fwp_in_pend(%rip), %r12
000000010000a6f6	movq	0x8943(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000a6fd	leaq	-0x29(%rbp), %r15
000000010000a701	nopw	%cs:(%rax,%rax)
000000010000a710	movslq	_fwp_in_ppos(%rip), %rax
000000010000a717	cmpl	_fwp_in_npend(%rip), %eax
000000010000a71d	jge	0x10000a740
000000010000a71f	leal	0x1(%rax), %ecx
000000010000a722	movzbl	(%rax,%r12), %eax
000000010000a727	movb	%al, -0x29(%rbp)
000000010000a72a	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a730	jmp	0x10000a75b
000000010000a732	nopw	%cs:(%rax,%rax)
000000010000a740	movq	(%r13), %rcx
000000010000a744	movl	$0x1, %esi
000000010000a749	movl	$0x1, %edx
000000010000a74e	movq	%r15, %rdi
000000010000a751	callq	0x1000111ec                     ## symbol stub for: _fread
000000010000a756	testq	%rax, %rax
000000010000a759	je	0x10000a79c
000000010000a75b	cmpq	$0x38, %r14
000000010000a75f	setne	%cl
000000010000a762	movzbl	-0x29(%rbp), %eax
000000010000a766	testb	$0x7e, %al
000000010000a768	sete	%dl
000000010000a76b	orb	%cl, %dl
000000010000a76d	je	0x10000a78e
000000010000a76f	addq	$0x7, %r14
000000010000a773	movzbl	%al, %eax
000000010000a776	movl	%eax, %edx
000000010000a778	andl	$0x7f, %edx
000000010000a77b	movl	%r14d, %ecx
000000010000a77e	shlq	%cl, %rdx
000000010000a781	orq	%rdx, (%rbx)
000000010000a784	testb	%al, %al
000000010000a786	jns	0x10000a795
000000010000a788	cmpq	$0x38, %r14
000000010000a78c	jbe	0x10000a710
000000010000a78e	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000a793	jmp	0x10000a79e
000000010000a795	movl	$0x1, %eax
000000010000a79a	jmp	0x10000a79e
000000010000a79c	xorl	%eax, %eax
000000010000a79e	addq	$0x8, %rsp
000000010000a7a2	popq	%rbx
000000010000a7a3	popq	%r12
000000010000a7a5	popq	%r13
000000010000a7a7	popq	%r14
000000010000a7a9	popq	%r15
000000010000a7ab	popq	%rbp
000000010000a7ac	retq
000000010000a7ad	nopl	(%rax)
_fwp_stdin_name_len:
000000010000a7b0	pushq	%rbp
000000010000a7b1	movq	%rsp, %rbp
000000010000a7b4	pushq	%r15
000000010000a7b6	pushq	%r14
000000010000a7b8	pushq	%r13
000000010000a7ba	pushq	%r12
000000010000a7bc	pushq	%rbx
000000010000a7bd	pushq	%rax
000000010000a7be	movq	%rdi, %rbx
000000010000a7c1	movq	$0x0, (%rdi)
000000010000a7c8	movq	$-0x7, %r14
000000010000a7cf	leaq	_fwp_in_pend(%rip), %r12
000000010000a7d6	movq	0x8863(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000a7dd	leaq	-0x29(%rbp), %r15
000000010000a7e1	nopw	%cs:(%rax,%rax)
000000010000a7f0	movslq	_fwp_in_ppos(%rip), %rax
000000010000a7f7	cmpl	_fwp_in_npend(%rip), %eax
000000010000a7fd	jge	0x10000a820
000000010000a7ff	leal	0x1(%rax), %ecx
000000010000a802	movzbl	(%rax,%r12), %eax
000000010000a807	movb	%al, -0x29(%rbp)
000000010000a80a	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a810	jmp	0x10000a83b
000000010000a812	nopw	%cs:(%rax,%rax)
000000010000a820	movq	(%r13), %rcx
000000010000a824	movl	$0x1, %esi
000000010000a829	movl	$0x1, %edx
000000010000a82e	movq	%r15, %rdi
000000010000a831	callq	0x1000111ec                     ## symbol stub for: _fread
000000010000a836	testq	%rax, %rax
000000010000a839	je	0x10000a891
000000010000a83b	cmpq	$0x38, %r14
000000010000a83f	setne	%cl
000000010000a842	movzbl	-0x29(%rbp), %eax
000000010000a846	testb	$0x7e, %al
000000010000a848	sete	%dl
000000010000a84b	orb	%cl, %dl
000000010000a84d	je	0x10000a875
000000010000a84f	addq	$0x7, %r14
000000010000a853	movzbl	%al, %eax
000000010000a856	movl	%eax, %edx
000000010000a858	andl	$0x7f, %edx
000000010000a85b	movl	%r14d, %ecx
000000010000a85e	shlq	%cl, %rdx
000000010000a861	orq	(%rbx), %rdx
000000010000a864	movq	%rdx, (%rbx)
000000010000a867	testb	%al, %al
000000010000a869	jns	0x10000a87c
000000010000a86b	cmpq	$0x38, %r14
000000010000a86f	jbe	0x10000a7f0
000000010000a875	movl	$0xffffffff, %ecx               ## imm = 0xFFFFFFFF
000000010000a87a	jmp	0x10000a893
000000010000a87c	movl	$0x1, %ecx
000000010000a881	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000a886	cmpq	$0x100000, %rdx                 ## imm = 0x100000
000000010000a88d	jbe	0x10000a893
000000010000a88f	jmp	0x10000a895
000000010000a891	xorl	%ecx, %ecx
000000010000a893	movl	%ecx, %eax
000000010000a895	addq	$0x8, %rsp
000000010000a899	popq	%rbx
000000010000a89a	popq	%r12
000000010000a89c	popq	%r13
000000010000a89e	popq	%r14
000000010000a8a0	popq	%r15
000000010000a8a2	popq	%rbp
000000010000a8a3	retq
000000010000a8a4	nopw	%cs:(%rax,%rax)
_fwp_decode:
000000010000a8b0	pushq	%rbp
000000010000a8b1	movq	%rsp, %rbp
000000010000a8b4	pushq	%r15
000000010000a8b6	pushq	%r14
000000010000a8b8	pushq	%r13
000000010000a8ba	pushq	%r12
000000010000a8bc	pushq	%rbx
000000010000a8bd	subq	$0x48, %rsp
000000010000a8c1	movq	0x8768(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000a8c8	movq	(%rax), %rax
000000010000a8cb	movq	%rax, -0x30(%rbp)
000000010000a8cf	movl	(%rsi), %eax
000000010000a8d1	xorl	%r8d, %r8d
000000010000a8d4	cmpq	$0x15, %rax
000000010000a8d8	ja	0x10000ae57
000000010000a8de	movq	%rdx, %r9
000000010000a8e1	movq	%rsi, %r15
000000010000a8e4	movq	%rdi, %r14
000000010000a8e7	leaq	0x84e(%rip), %rcx
000000010000a8ee	movslq	(%rcx,%rax,4), %rdx
000000010000a8f2	addq	%rcx, %rdx
000000010000a8f5	jmpq	*%rdx
000000010000a8f7	xorl	%ecx, %ecx
000000010000a8f9	cmpl	$0xa, %eax
000000010000a8fc	setne	%cl
000000010000a8ff	leaq	0x4(,%rcx,4), %rax
000000010000a907	movq	0x8(%r14), %rdx
000000010000a90b	movq	0x10(%r14), %rcx
000000010000a90f	subq	%rcx, %rdx
000000010000a912	cmpq	%rax, %rdx
000000010000a915	jb	0x10000ae57
000000010000a91b	movq	(%r14), %rdx
000000010000a91e	addq	%rcx, %rdx
000000010000a921	addq	%rax, %rcx
000000010000a924	movq	%rcx, 0x10(%r14)
000000010000a928	cmpq	$0x8, %rax
000000010000a92c	jae	0x10000a934
000000010000a92e	xorl	%esi, %esi
000000010000a930	xorl	%edi, %edi
000000010000a932	jmp	0x10000a999
000000010000a934	movl	%eax, %esi
000000010000a936	andl	$-0x8, %esi
000000010000a939	pmovzxbq	0x2(%rdx), %xmm0
000000010000a93f	pmovzxbq	0x6(%rdx), %xmm1
000000010000a945	pmovzxbq	0x4(%rdx), %xmm2
000000010000a94b	pmovzxbq	(%rdx), %xmm3
000000010000a950	movdqa	%xmm3, %xmm4
000000010000a954	psllq	$0x8, %xmm4
000000010000a959	pshufb	0x6a5e(%rip), %xmm2
000000010000a962	pblendw	$0xf, %xmm3, %xmm4              ## xmm4 = xmm3[0,1,2,3],xmm4[4,5,6,7]
000000010000a968	por	%xmm4, %xmm2
000000010000a96c	pshufb	0x6a5b(%rip), %xmm1
000000010000a975	pshufb	0x6a62(%rip), %xmm0
000000010000a97e	por	%xmm1, %xmm0
000000010000a982	por	%xmm2, %xmm0
000000010000a986	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000a98b	por	%xmm0, %xmm1
000000010000a98f	movq	%xmm1, %rdi
000000010000a994	cmpq	%rsi, %rax
000000010000a997	je	0x10000a9b7
000000010000a999	leal	(,%rsi,8), %ecx
000000010000a9a0	movzbl	(%rdx,%rsi), %r8d
000000010000a9a5	shlq	%cl, %r8
000000010000a9a8	orq	%r8, %rdi
000000010000a9ab	incq	%rsi
000000010000a9ae	addq	$0x8, %rcx
000000010000a9b2	cmpq	%rsi, %rax
000000010000a9b5	jne	0x10000a9a0
000000010000a9b7	movq	%rdi, (%r9)
000000010000a9ba	movl	$0x1, %r8d
000000010000a9c0	jmp	0x10000ae57
000000010000a9c5	movq	%r9, %r12
000000010000a9c8	leaq	-0x58(%rbp), %rsi
000000010000a9cc	movq	%r14, %rdi
000000010000a9cf	callq	_rd_leb
000000010000a9d4	testl	%eax, %eax
000000010000a9d6	je	0x10000ae54
000000010000a9dc	movq	-0x58(%rbp), %rbx
000000010000a9e0	movq	0x8(%r14), %rcx
000000010000a9e4	cmpq	%rcx, %rbx
000000010000a9e7	movl	$0x0, %r8d
000000010000a9ed	ja	0x10000ae57
000000010000a9f3	movq	0x10(%r14), %rax
000000010000a9f7	subq	%rax, %rcx
000000010000a9fa	cmpq	%rbx, %rcx
000000010000a9fd	jb	0x10000ae57
000000010000aa03	movq	(%r14), %r13
000000010000aa06	addq	%rax, %r13
000000010000aa09	addq	%rbx, %rax
000000010000aa0c	movq	%rax, 0x10(%r14)
000000010000aa10	cmpl	$0xc, (%r15)
000000010000aa14	movq	%r12, %rcx
000000010000aa17	jne	0x10000aa32
000000010000aa19	movq	%r13, %rdi
000000010000aa1c	movq	%rbx, %rsi
000000010000aa1f	callq	_fwp_valid_utf8
000000010000aa24	xorl	%r8d, %r8d
000000010000aa27	movq	%r12, %rcx
000000010000aa2a	testl	%eax, %eax
000000010000aa2c	je	0x10000ae57
000000010000aa32	movq	%r13, %rdi
000000010000aa35	movq	%rbx, %rsi
000000010000aa38	movq	%rcx, %rbx
000000010000aa3b	callq	_fwp_str_new
000000010000aa40	movq	%rax, (%rbx)
000000010000aa43	jmp	0x10000a9ba
000000010000aa48	movq	0x10(%r14), %rax
000000010000aa4c	cmpq	%rax, 0x8(%r14)
000000010000aa50	je	0x10000ae57
000000010000aa56	movq	(%r14), %rcx
000000010000aa59	leaq	0x1(%rax), %rdx
000000010000aa5d	movq	%rdx, 0x10(%r14)
000000010000aa61	movsbq	(%rcx,%rax), %rax
000000010000aa66	movq	%rax, (%r9)
000000010000aa69	jmp	0x10000a9ba
000000010000aa6e	movq	0x8(%r14), %rsi
000000010000aa72	movq	0x10(%r14), %rcx
000000010000aa76	movq	%rsi, %rdx
000000010000aa79	subq	%rcx, %rdx
000000010000aa7c	cmpq	$0x8, %rdx
000000010000aa80	jb	0x10000ae57
000000010000aa86	movq	(%r14), %rdx
000000010000aa89	leaq	0x8(%rcx), %rdi
000000010000aa8d	movq	%rdi, 0x10(%r14)
000000010000aa91	subq	%rdi, %rsi
000000010000aa94	cmpq	$0x8, %rsi
000000010000aa98	jb	0x10000ae57
000000010000aa9e	movq	%r9, %rbx
000000010000aaa1	movq	(%rdx,%rcx), %rdi
000000010000aaa5	leaq	0x10(%rcx), %rsi
000000010000aaa9	movq	%rsi, 0x10(%r14)
000000010000aaad	movq	0x8(%rdx,%rcx), %rsi
000000010000aab2	cmpl	$0x4, %eax
000000010000aab5	jne	0x10000ae3d
000000010000aabb	callq	_fwp_box_u128
000000010000aac0	movq	%rax, (%rbx)
000000010000aac3	jmp	0x10000a9ba
000000010000aac8	movq	%r9, -0x50(%rbp)
000000010000aacc	movq	0x38(%r15), %rbx
000000010000aad0	leaq	-0x58(%rbp), %rsi
000000010000aad4	movq	%r14, %rdi
000000010000aad7	callq	_rd_leb
000000010000aadc	testl	%eax, %eax
000000010000aade	je	0x10000ae54
000000010000aae4	movq	-0x58(%rbp), %r12
000000010000aae8	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000aaf2	cmpq	%rax, %r12
000000010000aaf5	movl	$0x0, %r8d
000000010000aafb	ja	0x10000ae57
000000010000ab01	movq	%rbx, %rdi
000000010000ab04	xorl	%esi, %esi
000000010000ab06	callq	_fwp_wire_empty_inner
000000010000ab0b	xorl	%r8d, %r8d
000000010000ab0e	testl	%eax, %eax
000000010000ab10	jne	0x10000ab1c
000000010000ab12	cmpq	0x8(%r14), %r12
000000010000ab16	ja	0x10000ae57
000000010000ab1c	cmpl	$0x11, (%r15)
000000010000ab20	jne	0x10000add4
000000010000ab26	movq	0x38(%r15), %rsi
000000010000ab2a	movq	%r12, %rdi
000000010000ab2d	callq	_fwp_array_new_packed
000000010000ab32	movq	%rax, %r13
000000010000ab35	testq	%r12, %r12
000000010000ab38	je	0x10000ab6f
000000010000ab3a	xorl	%ebx, %ebx
000000010000ab3c	movq	0x38(%r15), %rsi
000000010000ab40	movq	%r14, %rdi
000000010000ab43	leaq	-0x40(%rbp), %rdx
000000010000ab47	callq	_fwp_decode
000000010000ab4c	testl	%eax, %eax
000000010000ab4e	je	0x10000ae54
000000010000ab54	movq	-0x40(%rbp), %rdx
000000010000ab58	movq	0x38(%r15), %rcx
000000010000ab5c	movq	%r13, %rdi
000000010000ab5f	movq	%rbx, %rsi
000000010000ab62	callq	_fwp_array_store
000000010000ab67	incq	%rbx
000000010000ab6a	cmpq	%rbx, %r12
000000010000ab6d	jne	0x10000ab3c
000000010000ab6f	movq	-0x50(%rbp), %rax
000000010000ab73	movq	%r13, (%rax)
000000010000ab76	jmp	0x10000a9ba
000000010000ab7b	movq	%r9, -0x50(%rbp)
000000010000ab7f	leaq	-0x58(%rbp), %rsi
000000010000ab83	movq	%r14, %rdi
000000010000ab86	callq	_rd_leb
000000010000ab8b	testl	%eax, %eax
000000010000ab8d	je	0x10000ae54
000000010000ab93	movq	-0x58(%rbp), %r13
000000010000ab97	movslq	0x10(%r15), %rax
000000010000ab9b	cmpq	%rax, %r13
000000010000ab9e	movl	$0x0, %r8d
000000010000aba4	jae	0x10000ae57
000000010000abaa	movq	0x28(%r15), %rax
000000010000abae	movslq	(%rax,%r13,4), %rbx
000000010000abb2	leaq	0x8(,%rbx,8), %rdi
000000010000abba	callq	_fwp_alloc
000000010000abbf	movq	%rax, -0x48(%rbp)
000000010000abc3	movq	%rbx, -0x60(%rbp)
000000010000abc7	testq	%rbx, %rbx
000000010000abca	jle	0x10000ac08
000000010000abcc	movq	-0x60(%rbp), %rax
000000010000abd0	leaq	(,%rax,8), %rbx
000000010000abd8	xorl	%r12d, %r12d
000000010000abdb	movq	0x30(%r15), %rax
000000010000abdf	movq	(%rax,%r13,8), %rax
000000010000abe3	movq	(%rax,%r12), %rsi
000000010000abe7	movq	-0x48(%rbp), %rax
000000010000abeb	leaq	(%rax,%r12), %rdx
000000010000abef	movq	%r14, %rdi
000000010000abf2	callq	_fwp_decode
000000010000abf7	testl	%eax, %eax
000000010000abf9	je	0x10000ae54
000000010000abff	addq	$0x8, %r12
000000010000ac03	cmpq	%r12, %rbx
000000010000ac06	jne	0x10000abdb
000000010000ac08	movl	%r13d, %edi
000000010000ac0b	movq	-0x60(%rbp), %rsi
000000010000ac0f	movq	-0x48(%rbp), %rdx
000000010000ac13	callq	_fwp_data
000000010000ac18	jmp	0x10000b128
000000010000ac1d	movl	$0x1, %eax
000000010000ac22	jmp	0x10000a907
000000010000ac27	movl	$0x2, %eax
000000010000ac2c	jmp	0x10000a907
000000010000ac31	movq	0x8(%r14), %rcx
000000010000ac35	movq	0x10(%r14), %rax
000000010000ac39	subq	%rax, %rcx
000000010000ac3c	cmpq	$0x2, %rcx
000000010000ac40	jb	0x10000ae57
000000010000ac46	movq	(%r14), %rcx
000000010000ac49	leaq	0x2(%rax), %rdx
000000010000ac4d	movq	%rdx, 0x10(%r14)
000000010000ac51	movzbl	(%rcx,%rax), %edx
000000010000ac55	movzbl	0x1(%rcx,%rax), %eax
000000010000ac5a	shlq	$0x38, %rax
000000010000ac5e	shlq	$0x30, %rdx
000000010000ac62	orq	%rax, %rdx
000000010000ac65	sarq	$0x30, %rdx
000000010000ac69	movq	%rdx, (%r9)
000000010000ac6c	jmp	0x10000a9ba
000000010000ac71	movq	0x8(%r14), %rcx
000000010000ac75	movq	0x10(%r14), %rax
000000010000ac79	subq	%rax, %rcx
000000010000ac7c	cmpq	$0x4, %rcx
000000010000ac80	jb	0x10000ae57
000000010000ac86	movq	(%r14), %rcx
000000010000ac89	leaq	0x4(%rax), %rdx
000000010000ac8d	movq	%rdx, 0x10(%r14)
000000010000ac91	movzbl	(%rcx,%rax), %edx
000000010000ac95	movzbl	0x1(%rcx,%rax), %esi
000000010000ac9a	movzbl	0x2(%rcx,%rax), %edi
000000010000ac9f	movzbl	0x3(%rcx,%rax), %eax
000000010000aca4	shlq	$0x38, %rax
000000010000aca8	shlq	$0x30, %rdi
000000010000acac	shlq	$0x28, %rsi
000000010000acb0	shlq	$0x20, %rdx
000000010000acb4	orq	%rsi, %rdx
000000010000acb7	orq	%rdi, %rdx
000000010000acba	orq	%rax, %rdx
000000010000acbd	sarq	$0x20, %rdx
000000010000acc1	movq	%rdx, (%r9)
000000010000acc4	jmp	0x10000a9ba
000000010000acc9	movl	$0x4, %eax
000000010000acce	jmp	0x10000a907
000000010000acd3	movq	%r9, %r12
000000010000acd6	movq	0x40(%r15), %rdi
000000010000acda	xorl	%esi, %esi
000000010000acdc	callq	_fwp_wire_empty_inner
000000010000ace1	testl	%eax, %eax
000000010000ace3	setne	%r13b
000000010000ace7	jmp	0x10000acef
000000010000ace9	movq	%r9, %r12
000000010000acec	movb	$0x1, %r13b
000000010000acef	movq	0x38(%r15), %rbx
000000010000acf3	leaq	-0x58(%rbp), %rsi
000000010000acf7	movq	%r14, %rdi
000000010000acfa	callq	_rd_leb
000000010000acff	testl	%eax, %eax
000000010000ad01	je	0x10000ae54
000000010000ad07	movb	%r13b, -0x48(%rbp)
000000010000ad0b	movq	-0x58(%rbp), %r13
000000010000ad0f	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000ad19	cmpq	%rax, %r13
000000010000ad1c	movl	$0x0, %r8d
000000010000ad22	ja	0x10000ae57
000000010000ad28	movq	%r12, -0x50(%rbp)
000000010000ad2c	movq	%rbx, %rdi
000000010000ad2f	xorl	%esi, %esi
000000010000ad31	callq	_fwp_wire_empty_inner
000000010000ad36	testl	%eax, %eax
000000010000ad38	je	0x10000ae4a
000000010000ad3e	cmpq	$0x2, %r13
000000010000ad42	setae	%al
000000010000ad45	movzbl	-0x48(%rbp), %ecx
000000010000ad49	testb	%cl, %al
000000010000ad4b	je	0x10000ae7d
000000010000ad51	jmp	0x10000ae54
000000010000ad56	movslq	0x10(%r15), %rdi
000000010000ad5a	testq	%rdi, %rdi
000000010000ad5d	je	0x10000adc8
000000010000ad5f	shlq	$0x3, %rdi
000000010000ad63	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000ad6a	movq	%r9, -0x50(%rbp)
000000010000ad6e	ja	0x10000af08
000000010000ad74	leaq	0xf(%rdi), %rcx
000000010000ad78	shrq	$0x4, %rcx
000000010000ad7c	leaq	_fwp_gc(%rip), %rax
000000010000ad83	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000ad8b	movl	0xb48(%rax,%rcx,4), %esi
000000010000ad92	subq	%rsi, _fwp_gc(%rip)
000000010000ad99	js	0x10000af08
000000010000ad9f	leaq	(%rcx,%rcx,2), %rcx
000000010000ada3	leaq	(%rax,%rcx,8), %rax
000000010000ada7	addq	$0x788, %rax                    ## imm = 0x788
000000010000adad	movq	(%rax), %r12
000000010000adb0	testq	%r12, %r12
000000010000adb3	je	0x10000aef8
000000010000adb9	movq	(%r12), %rcx
000000010000adbd	notq	%rcx
000000010000adc0	movq	%rcx, (%rax)
000000010000adc3	jmp	0x10000af2b
000000010000adc8	movq	$0x0, (%r9)
000000010000adcf	jmp	0x10000a9ba
000000010000add4	cmpq	$0x7ff, %r12                    ## imm = 0x7FF
000000010000addb	ja	0x10000afe9
000000010000ade1	leaq	(,%r12,8), %rcx
000000010000ade9	addq	$0x17, %rcx
000000010000aded	shrq	$0x4, %rcx
000000010000adf1	leaq	_fwp_gc(%rip), %rax
000000010000adf8	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000ae00	movl	0xb48(%rax,%rcx,4), %esi
000000010000ae07	subq	%rsi, _fwp_gc(%rip)
000000010000ae0e	js	0x10000afe9
000000010000ae14	leaq	(%rcx,%rcx,2), %rcx
000000010000ae18	leaq	(%rax,%rcx,8), %rax
000000010000ae1c	addq	$0x788, %rax                    ## imm = 0x788
000000010000ae22	movq	(%rax), %r13
000000010000ae25	testq	%r13, %r13
000000010000ae28	je	0x10000afd5
000000010000ae2e	movq	(%r13), %rcx
000000010000ae32	notq	%rcx
000000010000ae35	movq	%rcx, (%rax)
000000010000ae38	jmp	0x10000b0aa
000000010000ae3d	callq	_fwp_box_u128
000000010000ae42	movq	%rax, (%rbx)
000000010000ae45	jmp	0x10000a9ba
000000010000ae4a	cmpq	0x8(%r14), %r13
000000010000ae4e	movzbl	-0x48(%rbp), %ecx
000000010000ae52	jbe	0x10000ae7d
000000010000ae54	xorl	%r8d, %r8d
000000010000ae57	movq	0x81d2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ae5e	movq	(%rax), %rax
000000010000ae61	cmpq	-0x30(%rbp), %rax
000000010000ae65	jne	0x10000b134
000000010000ae6b	movl	%r8d, %eax
000000010000ae6e	addq	$0x48, %rsp
000000010000ae72	popq	%rbx
000000010000ae73	popq	%r12
000000010000ae75	popq	%r13
000000010000ae77	popq	%r14
000000010000ae79	popq	%r15
000000010000ae7b	popq	%rbp
000000010000ae7c	retq
000000010000ae7d	testb	%cl, %cl
000000010000ae7f	movl	$0x0, %r8d
000000010000ae85	jne	0x10000ae8d
000000010000ae87	cmpq	0x8(%r14), %r13
000000010000ae8b	ja	0x10000ae57
000000010000ae8d	leaq	_fwp_empty_map(%rip), %r12
000000010000ae94	testq	%r13, %r13
000000010000ae97	je	0x10000af17
000000010000ae99	leaq	-0x40(%rbp), %rbx
000000010000ae9d	jmp	0x10000aeb9
000000010000ae9f	xorl	%esi, %esi
000000010000aea1	movq	-0x40(%rbp), %rdi
000000010000aea5	movq	0x38(%r15), %rcx
000000010000aea9	movq	%r12, %rdx
000000010000aeac	callq	_fwp_p_map_insert
000000010000aeb1	movq	%rax, %r12
000000010000aeb4	decq	%r13
000000010000aeb7	je	0x10000af17
000000010000aeb9	movq	$0x0, -0x68(%rbp)
000000010000aec1	movq	0x38(%r15), %rsi
000000010000aec5	movq	%r14, %rdi
000000010000aec8	movq	%rbx, %rdx
000000010000aecb	callq	_fwp_decode
000000010000aed0	testl	%eax, %eax
000000010000aed2	je	0x10000ae54
000000010000aed4	cmpl	$0x12, (%r15)
000000010000aed8	jne	0x10000ae9f
000000010000aeda	movq	0x40(%r15), %rsi
000000010000aede	movq	%r14, %rdi
000000010000aee1	leaq	-0x68(%rbp), %rdx
000000010000aee5	callq	_fwp_decode
000000010000aeea	testl	%eax, %eax
000000010000aeec	je	0x10000ae54
000000010000aef2	movq	-0x68(%rbp), %rsi
000000010000aef6	jmp	0x10000aea1
000000010000aef8	movq	0x8(%rax), %r12
000000010000aefc	movq	0x10(%rax), %rcx
000000010000af00	subq	%r12, %rcx
000000010000af03	cmpq	%rsi, %rcx
000000010000af06	jae	0x10000af23
000000010000af08	movl	$0x2, %esi
000000010000af0d	callq	_fwp_gc_alloc_slow
000000010000af12	movq	%rax, %r12
000000010000af15	jmp	0x10000af33
000000010000af17	movq	-0x50(%rbp), %rax
000000010000af1b	movq	%r12, (%rax)
000000010000af1e	jmp	0x10000a9ba
000000010000af23	leaq	(%r12,%rsi), %rcx
000000010000af27	movq	%rcx, 0x8(%rax)
000000010000af2b	movq	%r12, %rdi
000000010000af2e	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000af33	movl	0x10(%r15), %r13d
000000010000af37	testl	%r13d, %r13d
000000010000af3a	jle	0x10000af7f
000000010000af3c	movq	%r12, -0x48(%rbp)
000000010000af40	movq	%r12, %rbx
000000010000af43	xorl	%r12d, %r12d
000000010000af46	nopw	%cs:(%rax,%rax)
000000010000af50	movq	0x20(%r15), %rax
000000010000af54	movq	(%rax,%r12,8), %rsi
000000010000af58	movq	%r14, %rdi
000000010000af5b	movq	%rbx, %rdx
000000010000af5e	callq	_fwp_decode
000000010000af63	testl	%eax, %eax
000000010000af65	je	0x10000ae54
000000010000af6b	incq	%r12
000000010000af6e	movslq	0x10(%r15), %r13
000000010000af72	addq	$0x8, %rbx
000000010000af76	cmpq	%r13, %r12
000000010000af79	jl	0x10000af50
000000010000af7b	movq	-0x48(%rbp), %r12
000000010000af7f	testl	%r13d, %r13d
000000010000af82	je	0x10000afaf
000000010000af84	movl	%r13d, %ebx
000000010000af87	leaq	0x8(,%rbx,8), %rdi
000000010000af8f	callq	_fwp_alloc_init
000000010000af94	movl	$0x0, (%rax)
000000010000af9a	movl	%r13d, 0x4(%rax)
000000010000af9e	cmpl	$0x8, %r13d
000000010000afa2	jae	0x10000afbd
000000010000afa4	xorl	%ecx, %ecx
000000010000afa6	movq	-0x50(%rbp), %r8
000000010000afaa	jmp	0x10000b03c
000000010000afaf	xorl	%eax, %eax
000000010000afb1	movq	-0x50(%rbp), %r8
000000010000afb5	movq	%rax, (%r8)
000000010000afb8	jmp	0x10000a9ba
000000010000afbd	movq	%rax, %rcx
000000010000afc0	subq	%r12, %rcx
000000010000afc3	addq	$0x8, %rcx
000000010000afc7	cmpq	$0x20, %rcx
000000010000afcb	movq	-0x50(%rbp), %r8
000000010000afcf	jae	0x10000b003
000000010000afd1	xorl	%ecx, %ecx
000000010000afd3	jmp	0x10000b03c
000000010000afd5	movq	0x8(%rax), %r13
000000010000afd9	movq	0x10(%rax), %rcx
000000010000afdd	subq	%r13, %rcx
000000010000afe0	cmpq	%rsi, %rcx
000000010000afe3	jae	0x10000b0a2
000000010000afe9	leaq	0x8(,%r12,8), %rdi
000000010000aff1	movl	$0x2, %esi
000000010000aff6	callq	_fwp_gc_alloc_slow
000000010000affb	movq	%rax, %r13
000000010000affe	jmp	0x10000b0b2
000000010000b003	movl	%ebx, %ecx
000000010000b005	andl	$-0x4, %ecx
000000010000b008	leaq	(,%rbx,8), %rdx
000000010000b010	andq	$-0x20, %rdx
000000010000b014	xorl	%esi, %esi
000000010000b016	movdqu	(%r12,%rsi), %xmm0
000000010000b01c	movdqu	0x10(%r12,%rsi), %xmm1
000000010000b023	movdqu	%xmm0, 0x8(%rax,%rsi)
000000010000b029	movdqu	%xmm1, 0x18(%rax,%rsi)
000000010000b02f	addq	$0x20, %rsi
000000010000b033	cmpq	%rsi, %rdx
000000010000b036	jne	0x10000b016
000000010000b038	cmpl	%ebx, %ecx
000000010000b03a	je	0x10000b09a
000000010000b03c	movq	%rbx, %rsi
000000010000b03f	movq	%rcx, %rdx
000000010000b042	andq	$0x3, %rsi
000000010000b046	je	0x10000b061
000000010000b048	movq	%rcx, %rdx
000000010000b04b	nopl	(%rax,%rax)
000000010000b050	movq	(%r12,%rdx,8), %rdi
000000010000b054	movq	%rdi, 0x8(%rax,%rdx,8)
000000010000b059	incq	%rdx
000000010000b05c	decq	%rsi
000000010000b05f	jne	0x10000b050
000000010000b061	subq	%rbx, %rcx
000000010000b064	cmpq	$-0x4, %rcx
000000010000b068	ja	0x10000b09a
000000010000b06a	movq	(%r12,%rdx,8), %rcx
000000010000b06e	movq	%rcx, 0x8(%rax,%rdx,8)
000000010000b073	movq	0x8(%r12,%rdx,8), %rcx
000000010000b078	movq	%rcx, 0x10(%rax,%rdx,8)
000000010000b07d	movq	0x10(%r12,%rdx,8), %rcx
000000010000b082	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000b087	movq	0x18(%r12,%rdx,8), %rcx
000000010000b08c	movq	%rcx, 0x20(%rax,%rdx,8)
000000010000b091	addq	$0x4, %rdx
000000010000b095	cmpq	%rdx, %rbx
000000010000b098	jne	0x10000b06a
000000010000b09a	movq	%rax, (%r8)
000000010000b09d	jmp	0x10000a9ba
000000010000b0a2	leaq	(%rsi,%r13), %rcx
000000010000b0a6	movq	%rcx, 0x8(%rax)
000000010000b0aa	movq	%r13, %rdi
000000010000b0ad	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000b0b2	testq	%r12, %r12
000000010000b0b5	je	0x10000b126
000000010000b0b7	movq	%r13, -0x48(%rbp)
000000010000b0bb	movq	%r13, %rbx
000000010000b0be	movq	%r12, %r13
000000010000b0c1	movq	0x38(%r15), %rsi
000000010000b0c5	movq	%r14, %rdi
000000010000b0c8	movq	%rbx, %rdx
000000010000b0cb	callq	_fwp_decode
000000010000b0d0	testl	%eax, %eax
000000010000b0d2	je	0x10000ae54
000000010000b0d8	addq	$0x8, %rbx
000000010000b0dc	decq	%r13
000000010000b0df	jne	0x10000b0c1
000000010000b0e1	xorl	%r15d, %r15d
000000010000b0e4	movabsq	$0x200000001, %rbx              ## imm = 0x200000001
000000010000b0ee	leaq	-0x40(%rbp), %r14
000000010000b0f2	movq	-0x48(%rbp), %rax
000000010000b0f6	movq	-0x8(%rax,%r12,8), %r13
000000010000b0fb	movq	%r13, -0x40(%rbp)
000000010000b0ff	movq	%r15, -0x38(%rbp)
000000010000b103	movl	$0x18, %edi
000000010000b108	callq	_fwp_alloc_init
000000010000b10d	movq	%rbx, (%rax)
000000010000b110	movq	%r13, 0x8(%rax)
000000010000b114	movq	-0x48(%rbp), %r13
000000010000b118	movq	%r15, 0x10(%rax)
000000010000b11c	movq	%rax, %r15
000000010000b11f	decq	%r12
000000010000b122	jne	0x10000b0f2
000000010000b124	jmp	0x10000b128
000000010000b126	xorl	%eax, %eax
000000010000b128	movq	-0x50(%rbp), %rcx
000000010000b12c	movq	%rax, (%rcx)
000000010000b12f	jmp	0x10000a9ba
000000010000b134	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
000000010000b139	nopl	(%rax)
000000010000b13c	orb	$-0x7, %al
000000010000b13e	.byte 0xff #bad opcode
000000010000b13f	pushq	%rbp
000000010000b141	cli
000000010000b142	.byte 0xff #bad opcode
000000010000b143	pushq	-0x44000005(%rip)
000000010000b149	idivl	%edi
000000010000b14b	pushq	(%rdx)
000000010000b14d	stc
000000010000b14e	.byte 0xff #bad opcode
000000010000b14f	jmpq	*%rcx
000000010000b151	cli
000000010000b152	.byte 0xff #bad opcode
000000010000b153	.byte 0xff #bad opcode
000000010000b154	jmp	0x10000b150
000000010000b156	.byte 0xff #bad opcode
000000010000b157	decl	-0x44000005(%rbp)
000000010000b15d	idivl	%edi
000000010000b15f	pushq	(%rdx)
000000010000b161	stc
000000010000b162	.byte 0xff #bad opcode
000000010000b163	.byte 0xff #bad opcode
000000010000b164	movl	$0xbbfffff7, %ebx               ## imm = 0xBBFFFFF7
000000010000b169	idivl	%edi
000000010000b16b	decl	-0x76000008(%rcx)
000000010000b171	clc
000000010000b172	.byte 0xff #bad opcode
000000010000b173	.byte 0xff #bad opcode
000000010000b174	.byte 0x3f #bad opcode
000000010000b175	cli
000000010000b176	.byte 0xff #bad opcode
000000010000b177	decl	-0x3e50001(%rcx,%rdi,8)
000000010000b17e	.byte 0xff #bad opcode
000000010000b17f	decl	-0x4680001(%rcx,%rdi,8)
000000010000b186	.byte 0xff #bad opcode
000000010000b187	ljmpl	*-0x44000005(%rbp)
000000010000b18d	idivl	%edi
000000010000b18f	decl	(%rcx,%rdi,8)
000000010000b192	.byte 0xff #bad opcode
000000010000b193	jmpq	*0x66(%rsi)
000000010000b196	nopw	%cs:(%rax,%rax)
_fwp_valid_utf8:
000000010000b1a0	testq	%rsi, %rsi
000000010000b1a3	je	0x10000b302
000000010000b1a9	pushq	%rbp
000000010000b1aa	movq	%rsp, %rbp
000000010000b1ad	pushq	%rbx
000000010000b1ae	xorl	%ecx, %ecx
000000010000b1b0	jmp	0x10000b1cc
000000010000b1b2	nopw	%cs:(%rax,%rax)
000000010000b1c0	incq	%rcx
000000010000b1c3	cmpq	%rsi, %rcx
000000010000b1c6	jae	0x10000b2fa
000000010000b1cc	movzbl	(%rdi,%rcx), %r10d
000000010000b1d1	testb	%r10b, %r10b
000000010000b1d4	jns	0x10000b1c0
000000010000b1d6	leal	0x3e(%r10), %eax
000000010000b1da	cmpb	$0x1e, %al
000000010000b1dc	jae	0x10000b1f0
000000010000b1de	movl	$0x80, %edx
000000010000b1e3	movl	$0x1, %eax
000000010000b1e8	movl	$0x1f, %r8d
000000010000b1ee	jmp	0x10000b227
000000010000b1f0	movl	%r10d, %eax
000000010000b1f3	andb	$-0x10, %al
000000010000b1f5	cmpb	$-0x20, %al
000000010000b1f7	jne	0x10000b20b
000000010000b1f9	movl	$0x800, %edx                    ## imm = 0x800
000000010000b1fe	movl	$0x2, %eax
000000010000b203	movl	$0xf, %r8d
000000010000b209	jmp	0x10000b227
000000010000b20b	leal	0x10(%r10), %eax
000000010000b20f	cmpb	$0x4, %al
000000010000b211	ja	0x10000b308
000000010000b217	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000b21c	movl	$0x3, %eax
000000010000b221	movl	$0x7, %r8d
000000010000b227	movl	%eax, %r9d
000000010000b22a	leaq	(%rcx,%r9), %r11
000000010000b22e	xorl	%eax, %eax
000000010000b230	cmpq	%rsi, %r11
000000010000b233	jae	0x10000b2ff
000000010000b239	movzbl	0x1(%rdi,%rcx), %r11d
000000010000b23f	movl	%r11d, %ebx
000000010000b242	andl	$-0x40, %ebx
000000010000b245	cmpl	$0x80, %ebx
000000010000b24b	jne	0x10000b2ff
000000010000b251	andl	%r10d, %r8d
000000010000b254	leal	0x1(%r9), %ebx
000000010000b258	movl	%r8d, %r10d
000000010000b25b	shll	$0x6, %r10d
000000010000b25f	andl	$0x3f, %r11d
000000010000b263	orl	%r10d, %r11d
000000010000b266	cmpl	$0x2, %ebx
000000010000b269	jne	0x10000b277
000000010000b26b	movl	%r11d, %ebx
000000010000b26e	cmpl	%edx, %ebx
000000010000b270	jae	0x10000b2d2
000000010000b272	jmp	0x10000b2ff
000000010000b277	movzbl	0x2(%rdi,%rcx), %r8d
000000010000b27d	movl	%r8d, %r10d
000000010000b280	andl	$-0x40, %r10d
000000010000b284	cmpl	$0x80, %r10d
000000010000b28b	jne	0x10000b2ff
000000010000b28d	movl	%r11d, %r10d
000000010000b290	shll	$0x6, %r10d
000000010000b294	andl	$0x3f, %r8d
000000010000b298	orl	%r10d, %r8d
000000010000b29b	cmpl	$0x3, %ebx
000000010000b29e	jne	0x10000b2ac
000000010000b2a0	movl	%r8d, %ebx
000000010000b2a3	movl	%r11d, %r8d
000000010000b2a6	cmpl	%edx, %ebx
000000010000b2a8	jae	0x10000b2d2
000000010000b2aa	jmp	0x10000b2ff
000000010000b2ac	movzbl	0x3(%rdi,%rcx), %ebx
000000010000b2b1	movl	%ebx, %r10d
000000010000b2b4	andl	$-0x40, %r10d
000000010000b2b8	cmpl	$0x80, %r10d
000000010000b2bf	jne	0x10000b2ff
000000010000b2c1	movl	%r8d, %r10d
000000010000b2c4	shll	$0x6, %r10d
000000010000b2c8	andl	$0x3f, %ebx
000000010000b2cb	orl	%r10d, %ebx
000000010000b2ce	cmpl	%edx, %ebx
000000010000b2d0	jb	0x10000b2ff
000000010000b2d2	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000b2d9	ja	0x10000b2ff
000000010000b2db	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000b2e2	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000b2e9	je	0x10000b2ff
000000010000b2eb	addq	%r9, %rcx
000000010000b2ee	incq	%rcx
000000010000b2f1	cmpq	%rsi, %rcx
000000010000b2f4	jb	0x10000b1cc
000000010000b2fa	movl	$0x1, %eax
000000010000b2ff	popq	%rbx
000000010000b300	popq	%rbp
000000010000b301	retq
000000010000b302	movl	$0x1, %eax
000000010000b307	retq
000000010000b308	xorl	%eax, %eax
000000010000b30a	jmp	0x10000b2ff
000000010000b30c	nopl	(%rax)
_fwp_str_new:
000000010000b310	pushq	%rbp
000000010000b311	movq	%rsp, %rbp
000000010000b314	pushq	%r15
000000010000b316	pushq	%r14
000000010000b318	pushq	%rbx
000000010000b319	pushq	%rax
000000010000b31a	movq	%rsi, %r14
000000010000b31d	movq	%rdi, %rbx
000000010000b320	addq	$0x9, %rsi
000000010000b324	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000b32b	ja	0x10000b386
000000010000b32d	leaq	0x18(%r14), %rax
000000010000b331	shrq	$0x4, %rax
000000010000b335	leaq	_fwp_gc(%rip), %rcx
000000010000b33c	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b344	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b34b	subq	%rax, _fwp_gc(%rip)
000000010000b352	js	0x10000b386
000000010000b354	leaq	(%rdx,%rdx,2), %rdx
000000010000b358	leaq	(%rcx,%rdx,8), %rcx
000000010000b35c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b363	movq	(%rcx), %r15
000000010000b366	testq	%r15, %r15
000000010000b369	je	0x10000b376
000000010000b36b	movq	(%r15), %rax
000000010000b36e	notq	%rax
000000010000b371	movq	%rax, (%rcx)
000000010000b374	jmp	0x10000b39f
000000010000b376	movq	0x8(%rcx), %r15
000000010000b37a	movq	0x10(%rcx), %rdx
000000010000b37e	subq	%r15, %rdx
000000010000b381	cmpq	%rax, %rdx
000000010000b384	jae	0x10000b398
000000010000b386	movq	%rsi, %rdi
000000010000b389	movl	$0x1, %esi
000000010000b38e	callq	_fwp_gc_alloc_slow
000000010000b393	movq	%rax, %r15
000000010000b396	jmp	0x10000b3a7
000000010000b398	addq	%r15, %rax
000000010000b39b	movq	%rax, 0x8(%rcx)
000000010000b39f	movq	%r15, %rdi
000000010000b3a2	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000b3a7	movq	%r14, (%r15)
000000010000b3aa	leaq	0x8(%r15), %rdi
000000010000b3ae	movq	%rbx, %rsi
000000010000b3b1	movq	%r14, %rdx
000000010000b3b4	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000b3b9	movb	$0x0, 0x8(%r15,%r14)
000000010000b3bf	movq	%r15, %rax
000000010000b3c2	addq	$0x8, %rsp
000000010000b3c6	popq	%rbx
000000010000b3c7	popq	%r14
000000010000b3c9	popq	%r15
000000010000b3cb	popq	%rbp
000000010000b3cc	retq
000000010000b3cd	nopl	(%rax)
_buf_put:
000000010000b3d0	pushq	%rbp
000000010000b3d1	movq	%rsp, %rbp
000000010000b3d4	pushq	%r15
000000010000b3d6	pushq	%r14
000000010000b3d8	pushq	%r12
000000010000b3da	pushq	%rbx
000000010000b3db	movq	%rdi, %r14
000000010000b3de	movq	0x8(%rdi), %rdi
000000010000b3e2	cmpq	$-0x1, %rdi
000000010000b3e6	je	0x10000b488
000000010000b3ec	movq	%rdx, %rbx
000000010000b3ef	movq	$-0x2, %rax
000000010000b3f6	subq	%rdi, %rax
000000010000b3f9	cmpq	%rdx, %rax
000000010000b3fc	jb	0x10000b488
000000010000b402	leaq	(%rbx,%rdi), %rax
000000010000b406	incq	%rax
000000010000b409	movq	0x10(%r14), %rcx
000000010000b40d	cmpq	%rcx, %rax
000000010000b410	jbe	0x10000b43f
000000010000b412	testq	%rcx, %rcx
000000010000b415	movl	$0x40, %r15d
000000010000b41b	cmovneq	%rcx, %r15
000000010000b41f	movq	%rsi, %r12
000000010000b422	cmpq	%rax, %r15
000000010000b425	jae	0x10000b447
000000010000b427	nopw	(%rax,%rax)
000000010000b430	testq	%r15, %r15
000000010000b433	js	0x10000b444
000000010000b435	addq	%r15, %r15
000000010000b438	cmpq	%rax, %r15
000000010000b43b	jb	0x10000b430
000000010000b43d	jmp	0x10000b447
000000010000b43f	movq	(%r14), %rax
000000010000b442	jmp	0x10000b465
000000010000b444	movq	%rax, %r15
000000010000b447	movq	(%r14), %rdi
000000010000b44a	movq	%r15, %rsi
000000010000b44d	callq	0x10001126a                     ## symbol stub for: _realloc
000000010000b452	testq	%rax, %rax
000000010000b455	je	0x10000b488
000000010000b457	movq	%rax, (%r14)
000000010000b45a	movq	%r15, 0x10(%r14)
000000010000b45e	movq	0x8(%r14), %rdi
000000010000b462	movq	%r12, %rsi
000000010000b465	addq	%rax, %rdi
000000010000b468	movq	%rbx, %rdx
000000010000b46b	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000b470	addq	0x8(%r14), %rbx
000000010000b474	movq	%rbx, 0x8(%r14)
000000010000b478	movq	(%r14), %rax
000000010000b47b	movb	$0x0, (%rax,%rbx)
000000010000b47f	popq	%rbx
000000010000b480	popq	%r12
000000010000b482	popq	%r14
000000010000b484	popq	%r15
000000010000b486	popq	%rbp
000000010000b487	retq
000000010000b488	movq	0x7ba9(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000b48f	movq	(%rax), %rcx
000000010000b492	leaq	0x6576(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000b499	movl	$0x13, %esi
000000010000b49e	movl	$0x1, %edx
000000010000b4a3	callq	0x1000111f8                     ## symbol stub for: _fwrite
000000010000b4a8	movl	$0x66, %edi
000000010000b4ad	callq	0x1000111c8                     ## symbol stub for: _exit
000000010000b4b2	nopw	%cs:(%rax,%rax)
_buf_to_str:
000000010000b4c0	pushq	%rbp
000000010000b4c1	movq	%rsp, %rbp
000000010000b4c4	pushq	%r14
000000010000b4c6	pushq	%rbx
000000010000b4c7	movq	%rdi, %rbx
000000010000b4ca	movq	(%rdi), %rax
000000010000b4cd	movq	0x8(%rdi), %rsi
000000010000b4d1	testq	%rax, %rax
000000010000b4d4	leaq	0x63d7(%rip), %rdi              ## literal pool for: ""
000000010000b4db	cmovneq	%rax, %rdi
000000010000b4df	callq	_fwp_str_new
000000010000b4e4	movq	%rax, %r14
000000010000b4e7	movq	(%rbx), %rdi
000000010000b4ea	callq	0x1000111f2                     ## symbol stub for: _free
000000010000b4ef	movq	%r14, %rax
000000010000b4f2	popq	%rbx
000000010000b4f3	popq	%r14
000000010000b4f5	popq	%rbp
000000010000b4f6	retq
000000010000b4f7	nopw	(%rax,%rax)
_fwp_strf:
000000010000b500	pushq	%rbp
000000010000b501	movq	%rsp, %rbp
000000010000b504	pushq	%r15
000000010000b506	pushq	%r14
000000010000b508	pushq	%r13
000000010000b50a	pushq	%r12
000000010000b50c	pushq	%rbx
000000010000b50d	subq	$0xd8, %rsp
000000010000b514	movq	%rsi, -0xf8(%rbp)
000000010000b51b	movq	%rdx, -0xf0(%rbp)
000000010000b522	movq	%rcx, -0xe8(%rbp)
000000010000b529	movq	%r8, -0xe0(%rbp)
000000010000b530	movq	%r9, -0xd8(%rbp)
000000010000b537	testb	%al, %al
000000010000b539	je	0x10000b56a
000000010000b53b	movaps	%xmm0, -0xd0(%rbp)
000000010000b542	movaps	%xmm1, -0xc0(%rbp)
000000010000b549	movaps	%xmm2, -0xb0(%rbp)
000000010000b550	movaps	%xmm3, -0xa0(%rbp)
000000010000b557	movaps	%xmm4, -0x90(%rbp)
000000010000b55e	movaps	%xmm5, -0x80(%rbp)
000000010000b562	movaps	%xmm6, -0x70(%rbp)
000000010000b566	movaps	%xmm7, -0x60(%rbp)
000000010000b56a	movq	0x7abf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b571	movq	(%rax), %rax
000000010000b574	movq	%rax, -0x30(%rbp)
000000010000b578	leaq	-0x100(%rbp), %rax
000000010000b57f	movq	%rax, -0x40(%rbp)
000000010000b583	leaq	0x10(%rbp), %r13
000000010000b587	movq	%r13, -0x48(%rbp)
000000010000b58b	movabsq	$0x3000000008, %r12             ## imm = 0x3000000008
000000010000b595	movq	%r12, -0x50(%rbp)
000000010000b599	leaq	0x6fd5(%rip), %rdx              ## literal pool for: "cannot parse `%.*s` as %s"
000000010000b5a0	leaq	-0x50(%rbp), %rcx
000000010000b5a4	xorl	%edi, %edi
000000010000b5a6	xorl	%esi, %esi
000000010000b5a8	callq	0x1000112d6                     ## symbol stub for: _vsnprintf
000000010000b5ad	movslq	%eax, %rbx
000000010000b5b0	leaq	0x1(%rbx), %r14
000000010000b5b4	cmpq	$0x4000, %r14                   ## imm = 0x4000
000000010000b5bb	ja	0x10000b616
000000010000b5bd	leaq	0x10(%rbx), %rax
000000010000b5c1	shrq	$0x4, %rax
000000010000b5c5	leaq	_fwp_gc(%rip), %rcx
000000010000b5cc	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b5d4	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b5db	subq	%rax, _fwp_gc(%rip)
000000010000b5e2	js	0x10000b616
000000010000b5e4	leaq	(%rdx,%rdx,2), %rdx
000000010000b5e8	leaq	(%rcx,%rdx,8), %rcx
000000010000b5ec	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b5f3	movq	(%rcx), %r15
000000010000b5f6	testq	%r15, %r15
000000010000b5f9	je	0x10000b606
000000010000b5fb	movq	(%r15), %rax
000000010000b5fe	notq	%rax
000000010000b601	movq	%rax, (%rcx)
000000010000b604	jmp	0x10000b62f
000000010000b606	movq	0x8(%rcx), %r15
000000010000b60a	movq	0x10(%rcx), %rdx
000000010000b60e	subq	%r15, %rdx
000000010000b611	cmpq	%rax, %rdx
000000010000b614	jae	0x10000b628
000000010000b616	movq	%r14, %rdi
000000010000b619	movl	$0x1, %esi
000000010000b61e	callq	_fwp_gc_alloc_slow
000000010000b623	movq	%rax, %r15
000000010000b626	jmp	0x10000b63a
000000010000b628	addq	%r15, %rax
000000010000b62b	movq	%rax, 0x8(%rcx)
000000010000b62f	movq	%r15, %rdi
000000010000b632	movq	%r14, %rsi
000000010000b635	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000b63a	leaq	-0x100(%rbp), %rax
000000010000b641	movq	%rax, -0x40(%rbp)
000000010000b645	movq	%r13, -0x48(%rbp)
000000010000b649	movq	%r12, -0x50(%rbp)
000000010000b64d	leaq	0x6f21(%rip), %rdx              ## literal pool for: "cannot parse `%.*s` as %s"
000000010000b654	leaq	-0x50(%rbp), %rcx
000000010000b658	movq	%r15, %rdi
000000010000b65b	movq	%r14, %rsi
000000010000b65e	callq	0x1000112d6                     ## symbol stub for: _vsnprintf
000000010000b663	movq	%r15, %rdi
000000010000b666	movq	%rbx, %rsi
000000010000b669	callq	_fwp_str_new
000000010000b66e	movq	0x79bb(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b675	movq	(%rcx), %rcx
000000010000b678	cmpq	-0x30(%rbp), %rcx
000000010000b67c	jne	0x10000b690
000000010000b67e	addq	$0xd8, %rsp
000000010000b685	popq	%rbx
000000010000b686	popq	%r12
000000010000b688	popq	%r13
000000010000b68a	popq	%r14
000000010000b68c	popq	%r15
000000010000b68e	popq	%rbp
000000010000b68f	retq
000000010000b690	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
000000010000b695	nopw	%cs:(%rax,%rax)
_tp_value:
000000010000b6a0	pushq	%rbp
000000010000b6a1	movq	%rsp, %rbp
000000010000b6a4	pushq	%r15
000000010000b6a6	pushq	%r14
000000010000b6a8	pushq	%r13
000000010000b6aa	pushq	%r12
000000010000b6ac	pushq	%rbx
000000010000b6ad	subq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b6b4	movq	%rcx, %rbx
000000010000b6b7	movq	%rsi, %rax
000000010000b6ba	movq	0x796f(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b6c1	movq	(%rcx), %rcx
000000010000b6c4	movq	%rcx, -0x30(%rbp)
000000010000b6c8	testl	%edx, %edx
000000010000b6ca	je	0x10000b731
000000010000b6cc	cmpl	$0xc, (%rax)
000000010000b6cf	jne	0x10000b731
000000010000b6d1	movq	0x8(%rdi), %rsi
000000010000b6d5	movq	0x10(%rdi), %r15
000000010000b6d9	movq	%rbx, %r12
000000010000b6dc	movq	(%rdi), %rax
000000010000b6df	addq	%r15, %rax
000000010000b6e2	subq	%r15, %rsi
000000010000b6e5	jne	0x10000b7bc
000000010000b6eb	movq	%rdi, %rbx
000000010000b6ee	movq	%rax, %rdi
000000010000b6f1	callq	_fwp_str_new
000000010000b6f6	movq	%rax, (%r12)
000000010000b6fa	movq	0x8(%rbx), %rax
000000010000b6fe	movq	%rax, 0x10(%rbx)
000000010000b702	movl	$0x1, %r14d
000000010000b708	movq	0x7921(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b70f	movq	(%rax), %rax
000000010000b712	cmpq	-0x30(%rbp), %rax
000000010000b716	jne	0x10000cf2c
000000010000b71c	movl	%r14d, %eax
000000010000b71f	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b726	popq	%rbx
000000010000b727	popq	%r12
000000010000b729	popq	%r13
000000010000b72b	popq	%r14
000000010000b72d	popq	%r15
000000010000b72f	popq	%rbp
000000010000b730	retq
000000010000b731	movq	0x8(%rdi), %rsi
000000010000b735	movq	0x10(%rdi), %r15
000000010000b739	cmpq	%rsi, %r15
000000010000b73c	jae	0x10000b770
000000010000b73e	movq	(%rdi), %rcx
000000010000b741	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000b74b	nopl	(%rax,%rax)
000000010000b750	movzbl	(%rcx,%r15), %r9d
000000010000b755	cmpq	$0x20, %r9
000000010000b759	ja	0x10000b770
000000010000b75b	btq	%r9, %r8
000000010000b75f	jae	0x10000b770
000000010000b761	incq	%r15
000000010000b764	movq	%r15, 0x10(%rdi)
000000010000b768	cmpq	%r15, %rsi
000000010000b76b	jne	0x10000b750
000000010000b76d	movq	%rsi, %r15
000000010000b770	movl	(%rax), %ecx
000000010000b772	xorl	%r14d, %r14d
000000010000b775	cmpq	$0x15, %rcx
000000010000b779	ja	0x10000b708
000000010000b77b	leaq	0x17b2(%rip), %r8
000000010000b782	movslq	(%r8,%rcx,4), %r9
000000010000b786	addq	%r8, %r9
000000010000b789	jmpq	*%r9
000000010000b78c	movq	0x789d(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b793	movq	(%rcx), %rcx
000000010000b796	cmpq	-0x30(%rbp), %rcx
000000010000b79a	jne	0x10000cf2c
000000010000b7a0	movq	%rax, %rsi
000000010000b7a3	movq	%rbx, %rdx
000000010000b7a6	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b7ad	popq	%rbx
000000010000b7ae	popq	%r12
000000010000b7b0	popq	%r13
000000010000b7b2	popq	%r14
000000010000b7b4	popq	%r15
000000010000b7b6	popq	%rbp
000000010000b7b7	jmp	_tp_int
000000010000b7bc	xorl	%ecx, %ecx
000000010000b7be	jmp	0x10000b7cc
000000010000b7c0	incq	%rcx
000000010000b7c3	cmpq	%rsi, %rcx
000000010000b7c6	jae	0x10000b6eb
000000010000b7cc	movzbl	(%rax,%rcx), %r10d
000000010000b7d1	testb	%r10b, %r10b
000000010000b7d4	jns	0x10000b7c0
000000010000b7d6	leal	0x3e(%r10), %edx
000000010000b7da	cmpb	$0x1e, %dl
000000010000b7dd	jae	0x10000b7f2
000000010000b7df	movl	$0x80, %edx
000000010000b7e4	movl	$0x1, %r9d
000000010000b7ea	movl	$0x1f, %r8d
000000010000b7f0	jmp	0x10000b82e
000000010000b7f2	movl	%r10d, %edx
000000010000b7f5	andb	$-0x10, %dl
000000010000b7f8	cmpb	$-0x20, %dl
000000010000b7fb	jne	0x10000b810
000000010000b7fd	movl	$0x800, %edx                    ## imm = 0x800
000000010000b802	movl	$0x2, %r9d
000000010000b808	movl	$0xf, %r8d
000000010000b80e	jmp	0x10000b82e
000000010000b810	leal	0x10(%r10), %edx
000000010000b814	cmpb	$0x4, %dl
000000010000b817	ja	0x10000ce5c
000000010000b81d	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000b822	movl	$0x3, %r9d
000000010000b828	movl	$0x7, %r8d
000000010000b82e	movl	%r9d, %r9d
000000010000b831	leaq	(%rcx,%r9), %r11
000000010000b835	xorl	%r14d, %r14d
000000010000b838	cmpq	%rsi, %r11
000000010000b83b	jae	0x10000b708
000000010000b841	movzbl	0x1(%rax,%rcx), %r11d
000000010000b847	movl	%r11d, %ebx
000000010000b84a	andl	$-0x40, %ebx
000000010000b84d	cmpl	$0x80, %ebx
000000010000b853	jne	0x10000b708
000000010000b859	andl	%r10d, %r8d
000000010000b85c	leal	0x1(%r9), %ebx
000000010000b860	movl	%r8d, %r10d
000000010000b863	shll	$0x6, %r10d
000000010000b867	andl	$0x3f, %r11d
000000010000b86b	orl	%r10d, %r11d
000000010000b86e	cmpl	$0x2, %ebx
000000010000b871	jne	0x10000b878
000000010000b873	movl	%r11d, %ebx
000000010000b876	jmp	0x10000b8d3
000000010000b878	movzbl	0x2(%rax,%rcx), %r8d
000000010000b87e	movl	%r8d, %r10d
000000010000b881	andl	$-0x40, %r10d
000000010000b885	cmpl	$0x80, %r10d
000000010000b88c	jne	0x10000b708
000000010000b892	movl	%r11d, %r10d
000000010000b895	shll	$0x6, %r10d
000000010000b899	andl	$0x3f, %r8d
000000010000b89d	orl	%r10d, %r8d
000000010000b8a0	cmpl	$0x3, %ebx
000000010000b8a3	jne	0x10000b8ad
000000010000b8a5	movl	%r8d, %ebx
000000010000b8a8	movl	%r11d, %r8d
000000010000b8ab	jmp	0x10000b8d3
000000010000b8ad	movzbl	0x3(%rax,%rcx), %ebx
000000010000b8b2	movl	%ebx, %r10d
000000010000b8b5	andl	$-0x40, %r10d
000000010000b8b9	cmpl	$0x80, %r10d
000000010000b8c0	jne	0x10000b708
000000010000b8c6	movl	%r8d, %r10d
000000010000b8c9	shll	$0x6, %r10d
000000010000b8cd	andl	$0x3f, %ebx
000000010000b8d0	orl	%r10d, %ebx
000000010000b8d3	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000b8da	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000b8e1	je	0x10000b708
000000010000b8e7	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000b8ee	ja	0x10000b708
000000010000b8f4	cmpl	%edx, %ebx
000000010000b8f6	jb	0x10000b708
000000010000b8fc	addq	%r9, %rcx
000000010000b8ff	incq	%rcx
000000010000b902	cmpq	%rsi, %rcx
000000010000b905	jb	0x10000b7cc
000000010000b90b	jmp	0x10000b6eb
000000010000b910	movdqu	0x38(%rax), %xmm0
000000010000b915	movdqa	%xmm0, -0x130(%rbp)
000000010000b91d	xorl	%edx, %edx
000000010000b91f	cmpl	$0x13, %ecx
000000010000b922	sete	%dl
000000010000b925	pxor	%xmm0, %xmm0
000000010000b929	movdqa	%xmm0, -0x120(%rbp)
000000010000b931	movq	$0x0, -0x110(%rbp)
000000010000b93c	movl	%edx, -0x108(%rbp)
000000010000b942	leaq	0x6c68(%rip), %rdx              ## literal pool for: "set"
000000010000b949	leaq	0x6c65(%rip), %rcx              ## literal pool for: "map"
000000010000b950	cmoveq	%rdx, %rcx
000000010000b954	cmpq	%rsi, %r15
000000010000b957	jae	0x10000b990
000000010000b959	movq	(%rdi), %rdx
000000010000b95c	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000b966	nopw	%cs:(%rax,%rax)
000000010000b970	movzbl	(%rdx,%r15), %r9d
000000010000b975	cmpq	$0x20, %r9
000000010000b979	ja	0x10000b990
000000010000b97b	btq	%r9, %r8
000000010000b97f	jae	0x10000b990
000000010000b981	incq	%r15
000000010000b984	movq	%r15, 0x10(%rdi)
000000010000b988	cmpq	%r15, %rsi
000000010000b98b	jne	0x10000b970
000000010000b98d	movq	%rsi, %r15
000000010000b990	subq	%r15, %rsi
000000010000b993	xorl	%r14d, %r14d
000000010000b996	cmpq	$0x3, %rsi
000000010000b99a	jb	0x10000b708
000000010000b9a0	movq	(%rdi), %rdx
000000010000b9a3	movzwl	(%rdx,%r15), %esi
000000010000b9a8	xorw	(%rcx), %si
000000010000b9ab	movzbl	0x2(%rdx,%r15), %edx
000000010000b9b1	xorb	0x2(%rcx), %dl
000000010000b9b4	movzbl	%dl, %ecx
000000010000b9b7	orw	%si, %cx
000000010000b9ba	jne	0x10000b708
000000010000b9c0	movq	%rbx, %r12
000000010000b9c3	movq	%rax, %rbx
000000010000b9c6	addq	$0x3, %r15
000000010000b9ca	movq	%r15, 0x10(%rdi)
000000010000b9ce	leaq	0x6be4(%rip), %rsi              ## literal pool for: "{"
000000010000b9d5	leaq	0x6bdf(%rip), %rdx              ## literal pool for: "}"
000000010000b9dc	leaq	_tp_kv_item(%rip), %rcx
000000010000b9e3	leaq	-0x130(%rbp), %r8
000000010000b9ea	callq	_tp_list_of
000000010000b9ef	testl	%eax, %eax
000000010000b9f1	je	0x10000c57d
000000010000b9f7	cmpq	$0x0, -0x118(%rbp)
000000010000b9ff	je	0x10000c83a
000000010000ba05	leaq	_fwp_empty_map(%rip), %rax
000000010000ba0c	xorl	%r14d, %r14d
000000010000ba0f	movq	-0x120(%rbp), %rcx
000000010000ba16	movq	(%rcx,%r14,8), %rdi
000000010000ba1a	movq	0x8(%rcx,%r14,8), %rsi
000000010000ba1f	movq	0x38(%rbx), %rcx
000000010000ba23	movq	%rax, %rdx
000000010000ba26	callq	_fwp_p_map_insert
000000010000ba2b	addq	$0x2, %r14
000000010000ba2f	cmpq	-0x118(%rbp), %r14
000000010000ba36	jb	0x10000ba0f
000000010000ba38	jmp	0x10000c841
000000010000ba3d	pxor	%xmm0, %xmm0
000000010000ba41	movdqu	%xmm0, -0x118(%rbp)
000000010000ba49	movdqu	%xmm0, -0x128(%rbp)
000000010000ba51	movq	$0x0, -0x108(%rbp)
000000010000ba5c	movq	0x38(%rax), %rdx
000000010000ba60	movq	%rdx, -0x130(%rbp)
000000010000ba67	cmpl	$0x11, %ecx
000000010000ba6a	jne	0x10000bad5
000000010000ba6c	cmpq	%rsi, %r15
000000010000ba6f	jae	0x10000baa0
000000010000ba71	movq	(%rdi), %rcx
000000010000ba74	movabsq	$0x100002600, %rdx              ## imm = 0x100002600
000000010000ba7e	nop
000000010000ba80	movzbl	(%rcx,%r15), %r8d
000000010000ba85	cmpq	$0x20, %r8
000000010000ba89	ja	0x10000baa0
000000010000ba8b	btq	%r8, %rdx
000000010000ba8f	jae	0x10000baa0
000000010000ba91	incq	%r15
000000010000ba94	movq	%r15, 0x10(%rdi)
000000010000ba98	cmpq	%r15, %rsi
000000010000ba9b	jne	0x10000ba80
000000010000ba9d	movq	%rsi, %r15
000000010000baa0	subq	%r15, %rsi
000000010000baa3	xorl	%r14d, %r14d
000000010000baa6	cmpq	$0x5, %rsi
000000010000baaa	jb	0x10000b708
000000010000bab0	movq	(%rdi), %rcx
000000010000bab3	movl	$0x61727261, %edx               ## imm = 0x61727261
000000010000bab8	xorl	(%rcx,%r15), %edx
000000010000babc	movzbl	0x4(%rcx,%r15), %ecx
000000010000bac2	xorl	$0x79, %ecx
000000010000bac5	orl	%edx, %ecx
000000010000bac7	jne	0x10000b708
000000010000bacd	addq	$0x5, %r15
000000010000bad1	movq	%r15, 0x10(%rdi)
000000010000bad5	movq	%rax, -0x1d0(%rbp)
000000010000badc	leaq	0x6abe(%rip), %rsi              ## literal pool for: "["
000000010000bae3	leaq	0x6ab9(%rip), %rdx              ## literal pool for: "]"
000000010000baea	leaq	_tp_elem_item(%rip), %rcx
000000010000baf1	leaq	-0x130(%rbp), %r8
000000010000baf8	callq	_tp_list_of
000000010000bafd	movq	-0x120(%rbp), %r14
000000010000bb04	testl	%eax, %eax
000000010000bb06	je	0x10000bfe2
000000010000bb0c	movq	%rbx, -0x1e8(%rbp)
000000010000bb13	movq	-0x118(%rbp), %rbx
000000010000bb1a	testq	%rbx, %rbx
000000010000bb1d	je	0x10000c140
000000010000bb23	xorl	%r15d, %r15d
000000010000bb26	leaq	-0x1b0(%rbp), %r13
000000010000bb2d	nopl	(%rax)
000000010000bb30	movq	-0x8(%r14,%rbx,8), %r12
000000010000bb35	movq	%r12, -0x1b0(%rbp)
000000010000bb3c	movq	%r15, -0x1a8(%rbp)
000000010000bb43	movl	$0x18, %edi
000000010000bb48	callq	_fwp_alloc_init
000000010000bb4d	movabsq	$0x200000001, %rcx              ## imm = 0x200000001
000000010000bb57	movq	%rcx, (%rax)
000000010000bb5a	movq	%r12, 0x8(%rax)
000000010000bb5e	movq	%r15, 0x10(%rax)
000000010000bb62	movq	%rax, %r15
000000010000bb65	decq	%rbx
000000010000bb68	jne	0x10000bb30
000000010000bb6a	jmp	0x10000c142
000000010000bb6f	movq	%rbx, %r15
000000010000bb72	movq	%rax, %rbx
000000010000bb75	leaq	-0x130(%rbp), %rsi
000000010000bb7c	movl	$0x80, %edx
000000010000bb81	callq	_tp_token
000000010000bb86	xorl	%r14d, %r14d
000000010000bb89	cmpq	$0x7f, %rax
000000010000bb8d	ja	0x10000b708
000000010000bb93	movl	-0x130(%rbp), %edx
000000010000bb99	cmpl	$0x666e69, %edx                 ## imm = 0x666E69
000000010000bb9f	jne	0x10000bfac
000000010000bba5	movsd	0x58d3(%rip), %xmm0
000000010000bbad	movq	%rbx, %rcx
000000010000bbb0	jmp	0x10000c596
000000010000bbb5	testl	%edx, %edx
000000010000bbb7	jne	0x10000b6d9
000000010000bbbd	movq	0x746c(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000bbc4	movq	(%rax), %rax
000000010000bbc7	cmpq	-0x30(%rbp), %rax
000000010000bbcb	jne	0x10000cf2c
000000010000bbd1	movq	%rbx, %rsi
000000010000bbd4	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000bbdb	popq	%rbx
000000010000bbdc	popq	%r12
000000010000bbde	popq	%r13
000000010000bbe0	popq	%r14
000000010000bbe2	popq	%r15
000000010000bbe4	popq	%rbp
000000010000bbe5	jmp	_tp_quoted
000000010000bbea	pxor	%xmm0, %xmm0
000000010000bbee	movdqa	%xmm0, -0x110(%rbp)
000000010000bbf6	movdqa	%xmm0, -0x120(%rbp)
000000010000bbfe	movdqa	%xmm0, -0x130(%rbp)
000000010000bc06	cmpq	%rsi, %r15
000000010000bc09	jae	0x10000bc40
000000010000bc0b	movq	(%rdi), %rax
000000010000bc0e	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000bc18	nopl	(%rax,%rax)
000000010000bc20	movzbl	(%rax,%r15), %edx
000000010000bc25	cmpq	$0x20, %rdx
000000010000bc29	ja	0x10000bc40
000000010000bc2b	btq	%rdx, %rcx
000000010000bc2f	jae	0x10000bc40
000000010000bc31	incq	%r15
000000010000bc34	movq	%r15, 0x10(%rdi)
000000010000bc38	cmpq	%r15, %rsi
000000010000bc3b	jne	0x10000bc20
000000010000bc3d	movq	%rsi, %r15
000000010000bc40	subq	%r15, %rsi
000000010000bc43	xorl	%r14d, %r14d
000000010000bc46	cmpq	$0x5, %rsi
000000010000bc4a	jb	0x10000bc69
000000010000bc4c	movq	(%rdi), %rax
000000010000bc4f	movl	$0x65747962, %ecx               ## imm = 0x65747962
000000010000bc54	xorl	(%rax,%r15), %ecx
000000010000bc58	movzbl	0x4(%rax,%r15), %eax
000000010000bc5e	xorl	$0x73, %eax
000000010000bc61	orl	%ecx, %eax
000000010000bc63	je	0x10000c4ca
000000010000bc69	xorl	%edi, %edi
000000010000bc6b	callq	_fwp_mem_free
000000010000bc70	jmp	0x10000b708
000000010000bc75	movq	%rbx, %r15
000000010000bc78	movq	%rax, %rbx
000000010000bc7b	leaq	-0x130(%rbp), %rsi
000000010000bc82	movl	$0x100, %edx                    ## imm = 0x100
000000010000bc87	callq	_tp_token
000000010000bc8c	xorl	%r14d, %r14d
000000010000bc8f	cmpq	$0x2, %rax
000000010000bc93	jb	0x10000b708
000000010000bc99	cmpb	$0x30, -0x130(%rbp)
000000010000bca0	jne	0x10000b708
000000010000bca6	cmpb	$0x74, -0x12f(%rbp)
000000010000bcad	jne	0x10000b708
000000010000bcb3	leaq	-0x2(%rax), %rcx
000000010000bcb7	movslq	0x48(%rbx), %rdx
000000010000bcbb	cmpq	%rdx, %rcx
000000010000bcbe	ja	0x10000b708
000000010000bcc4	cmpq	$0x3, %rax
000000010000bcc8	jb	0x10000c6b6
000000010000bcce	movl	$0x2, %edx
000000010000bcd3	xorl	%ecx, %ecx
000000010000bcd5	movq	%r15, %rdi
000000010000bcd8	jmp	0x10000bf1b
000000010000bcdd	leaq	-0x130(%rbp), %rsi
000000010000bce4	movl	$0x10, %edx
000000010000bce9	callq	_tp_token
000000010000bcee	movzwl	-0x130(%rbp), %eax
000000010000bcf5	movl	%eax, %ecx
000000010000bcf7	xorl	$0x312b, %ecx                   ## imm = 0x312B
000000010000bcfd	movzbl	-0x12e(%rbp), %edx
000000010000bd04	orw	%cx, %dx
000000010000bd07	sete	%cl
000000010000bd0a	cmpw	$0x31, %ax
000000010000bd0e	sete	%dl
000000010000bd11	orb	%cl, %dl
000000010000bd13	movl	$0x1, %r14d
000000010000bd19	jne	0x10000bd46
000000010000bd1b	xorl	%r14d, %r14d
000000010000bd1e	cmpw	$0x30, %ax
000000010000bd22	je	0x10000bd46
000000010000bd24	movl	$0x312d, %eax                   ## imm = 0x312D
000000010000bd29	xorl	-0x130(%rbp), %eax
000000010000bd2f	movzbl	-0x12e(%rbp), %ecx
000000010000bd36	orw	%ax, %cx
000000010000bd39	jne	0x10000b708
000000010000bd3f	movq	$-0x1, %r14
000000010000bd46	movq	%r14, (%rbx)
000000010000bd49	jmp	0x10000b702
000000010000bd4e	movq	0x8(%rax), %r13
000000010000bd52	testq	%r13, %r13
000000010000bd55	movq	%rbx, -0x1e8(%rbp)
000000010000bd5c	je	0x10000bff2
000000010000bd62	movq	%rsi, %rbx
000000010000bd65	movq	%rdi, -0x1c8(%rbp)
000000010000bd6c	movq	%rax, -0x1d0(%rbp)
000000010000bd73	leaq	0x6843(%rip), %rsi              ## literal pool for: "Duration"
000000010000bd7a	movq	%r13, %rdi
000000010000bd7d	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000bd82	testl	%eax, %eax
000000010000bd84	je	0x10000c36e
000000010000bd8a	movq	-0x1d0(%rbp), %rax
000000010000bd91	movl	0x10(%rax), %r9d
000000010000bd95	cmpq	%rbx, %r15
000000010000bd98	movq	-0x1c8(%rbp), %rdx
000000010000bd9f	movq	%r9, -0x1d8(%rbp)
000000010000bda6	jae	0x10000bdd8
000000010000bda8	movq	%rbx, %rcx
000000010000bdab	movq	(%rdx), %rsi
000000010000bdae	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
000000010000bdb8	movzbl	(%rsi,%r15), %r8d
000000010000bdbd	cmpq	$0x20, %r8
000000010000bdc1	ja	0x10000bdd8
000000010000bdc3	btq	%r8, %rdi
000000010000bdc7	jae	0x10000bdd8
000000010000bdc9	incq	%r15
000000010000bdcc	movq	%r15, 0x10(%rdx)
000000010000bdd0	cmpq	%r15, %rcx
000000010000bdd3	jne	0x10000bdb8
000000010000bdd5	movq	%rcx, %r15
000000010000bdd8	addq	$0x10, %rax
000000010000bddc	movq	%rax, -0x1c0(%rbp)
000000010000bde3	movq	%r13, %rdi
000000010000bde6	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000bdeb	subq	%r15, %rbx
000000010000bdee	cmpq	%rax, %rbx
000000010000bdf1	jb	0x10000be16
000000010000bdf3	movq	%rax, %r12
000000010000bdf6	movq	-0x1c8(%rbp), %rax
000000010000bdfd	movq	(%rax), %rdi
000000010000be00	addq	%r15, %rdi
000000010000be03	movq	%r13, %rsi
000000010000be06	movq	%r12, %rdx
000000010000be09	callq	0x100011222                     ## symbol stub for: _memcmp
000000010000be0e	testl	%eax, %eax
000000010000be10	je	0x10000ca28
000000010000be16	movq	-0x1d0(%rbp), %rax
000000010000be1d	movq	-0x1c8(%rbp), %rdi
000000010000be24	movq	-0x1c0(%rbp), %r13
000000010000be2b	movq	-0x1d8(%rbp), %rcx
000000010000be32	movslq	%ecx, %rcx
000000010000be35	leaq	0x8(,%rcx,8), %rcx
000000010000be3d	leaq	_fwp_gc(%rip), %r12
000000010000be44	cmpq	$0x4000, %rcx                   ## imm = 0x4000
000000010000be4b	ja	0x10000c5c6
000000010000be51	leaq	0xf(%rcx), %rdx
000000010000be55	shrq	$0x4, %rdx
000000010000be59	movzbl	0xbe8(%rdx,%r12), %edx
000000010000be62	movl	0xb48(%r12,%rdx,4), %esi
000000010000be6a	subq	%rsi, _fwp_gc(%rip)
000000010000be71	js	0x10000c5c6
000000010000be77	leaq	(%rdx,%rdx,2), %rdx
000000010000be7b	leaq	(%r12,%rdx,8), %rdx
000000010000be7f	addq	$0x788, %rdx                    ## imm = 0x788
000000010000be86	movq	(%rdx), %r8
000000010000be89	testq	%r8, %r8
000000010000be8c	je	0x10000c5b2
000000010000be92	movq	%rdi, %r15
000000010000be95	movq	%rax, %rbx
000000010000be98	movq	(%r8), %rax
000000010000be9b	notq	%rax
000000010000be9e	movq	%rax, (%rdx)
000000010000bea1	movq	%r8, -0x1e0(%rbp)
000000010000bea8	movq	%r8, %rdi
000000010000beab	jmp	0x10000c6e0
000000010000beb0	movq	(%rdi), %r8
000000010000beb3	cmpq	%rsi, %r15
000000010000beb6	movq	%rdi, -0x1c8(%rbp)
000000010000bebd	movl	%edx, -0x1d8(%rbp)
000000010000bec3	movq	%rbx, -0x1e8(%rbp)
000000010000beca	jae	0x10000bf45
000000010000becc	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000bed6	nopw	%cs:(%rax,%rax)
000000010000bee0	movzbl	(%r8,%r15), %r9d
000000010000bee5	cmpq	$0x20, %r9
000000010000bee9	ja	0x10000bf45
000000010000beeb	btq	%r9, %rcx
000000010000beef	jae	0x10000bf45
000000010000bef1	incq	%r15
000000010000bef4	movq	%r15, 0x10(%rdi)
000000010000bef8	cmpq	%r15, %rsi
000000010000befb	jne	0x10000bee0
000000010000befd	movq	%rax, %rbx
000000010000bf00	movq	%rsi, %r15
000000010000bf03	jmp	0x10000c1be
000000010000bf08	leaq	(%rcx,%rcx,2), %rcx
000000010000bf0c	decq	%rcx
000000010000bf0f	incq	%rdx
000000010000bf12	cmpq	%rdx, %rax
000000010000bf15	je	0x10000c6c0
000000010000bf1b	movzbl	-0x130(%rbp,%rdx), %esi
000000010000bf23	cmpl	$0x30, %esi
000000010000bf26	je	0x10000bf3f
000000010000bf28	cmpl	$0x2d, %esi
000000010000bf2b	je	0x10000bf08
000000010000bf2d	cmpl	$0x2b, %esi
000000010000bf30	jne	0x10000ce5c
000000010000bf36	leaq	(%rcx,%rcx,2), %rcx
000000010000bf3a	incq	%rcx
000000010000bf3d	jmp	0x10000bf0f
000000010000bf3f	leaq	(%rcx,%rcx,2), %rcx
000000010000bf43	jmp	0x10000bf0f
000000010000bf45	cmpq	%rsi, %r15
000000010000bf48	jae	0x10000c135
000000010000bf4e	movabsq	$0x4000000000003, %r9           ## imm = 0x4000000000003
000000010000bf58	movq	%r15, %rcx
000000010000bf5b	jmp	0x10000bf70
000000010000bf5d	nopl	(%rax)
000000010000bf60	incq	%rcx
000000010000bf63	movq	%rcx, 0x10(%rdi)
000000010000bf67	cmpq	%rcx, %rsi
000000010000bf6a	je	0x10000c1bb
000000010000bf70	movzbl	(%r8,%rcx), %r10d
000000010000bf75	leal	-0x30(%r10), %r11d
000000010000bf79	cmpb	$0xa, %r11b
000000010000bf7d	jb	0x10000bf60
000000010000bf7f	movl	%r10d, %r11d
000000010000bf82	andb	$-0x21, %r11b
000000010000bf86	addb	$-0x41, %r11b
000000010000bf8a	cmpb	$0x1a, %r11b
000000010000bf8e	jb	0x10000bf60
000000010000bf90	movzbl	%r10b, %r10d
000000010000bf94	addl	$-0x2d, %r10d
000000010000bf98	cmpl	$0x32, %r10d
000000010000bf9c	ja	0x10000bfa4
000000010000bf9e	btq	%r10, %r9
000000010000bfa2	jb	0x10000bf60
000000010000bfa4	movq	%rax, %rbx
000000010000bfa7	jmp	0x10000c1c1
000000010000bfac	movl	$0x666e692d, %ecx               ## imm = 0x666E692D
000000010000bfb1	xorl	-0x130(%rbp), %ecx
000000010000bfb7	movzbl	-0x12c(%rbp), %esi
000000010000bfbe	orl	%ecx, %esi
000000010000bfc0	movq	%rbx, %rcx
000000010000bfc3	je	0x10000c58e
000000010000bfc9	cmpl	$0x4e614e, %edx                 ## imm = 0x4E614E
000000010000bfcf	jne	0x10000c5e5
000000010000bfd5	movsd	0x54b3(%rip), %xmm0
000000010000bfdd	jmp	0x10000c596
000000010000bfe2	movq	%r14, %rdi
000000010000bfe5	callq	_fwp_mem_free
000000010000bfea	xorl	%r14d, %r14d
000000010000bfed	jmp	0x10000b708
000000010000bff2	movslq	0x10(%rax), %rcx
000000010000bff6	testq	%rcx, %rcx
000000010000bff9	je	0x10000c660
000000010000bfff	leaq	0x10(%rax), %r13
000000010000c003	cmpl	$0x0, 0x48(%rax)
000000010000c007	je	0x10000be32
000000010000c00d	movq	%r13, -0x1c0(%rbp)
000000010000c014	movq	%rax, %rbx
000000010000c017	shlq	$0x3, %rcx
000000010000c01b	movq	%rdi, %r13
000000010000c01e	movq	%rcx, %rdi
000000010000c021	callq	_fwp_alloc
000000010000c026	movq	%rax, -0x1d8(%rbp)
000000010000c02d	leaq	0x65a3(%rip), %rsi              ## literal pool for: "("
000000010000c034	movq	%r13, %r12
000000010000c037	movq	%r13, %rdi
000000010000c03a	callq	_tp_eat
000000010000c03f	testl	%eax, %eax
000000010000c041	je	0x10000b708
000000010000c047	movq	-0x1c0(%rbp), %rax
000000010000c04e	cmpl	$0x0, (%rax)
000000010000c051	movq	%r12, %rdi
000000010000c054	jle	0x10000c101
000000010000c05a	xorl	%r13d, %r13d
000000010000c05d	movabsq	$0x100002600, %r15              ## imm = 0x100002600
000000010000c067	testq	%r13, %r13
000000010000c06a	je	0x10000c0c0
000000010000c06c	movq	0x8(%rdi), %rcx
000000010000c070	movq	0x10(%rdi), %rax
000000010000c074	cmpq	%rcx, %rax
000000010000c077	jae	0x10000c0a0
000000010000c079	movq	(%rdi), %rdx
000000010000c07c	movzbl	(%rdx,%rax), %esi
000000010000c080	cmpq	$0x20, %rsi
000000010000c084	ja	0x10000c0a0
000000010000c086	btq	%rsi, %r15
000000010000c08a	jae	0x10000c0a0
000000010000c08c	incq	%rax
000000010000c08f	movq	%rax, 0x10(%rdi)
000000010000c093	xorl	%r14d, %r14d
000000010000c096	cmpq	%rax, %rcx
000000010000c099	jne	0x10000c07c
000000010000c09b	jmp	0x10000b708
000000010000c0a0	xorl	%r14d, %r14d
000000010000c0a3	cmpq	%rax, %rcx
000000010000c0a6	je	0x10000b708
000000010000c0ac	movq	(%rdi), %rcx
000000010000c0af	cmpb	$0x2c, (%rcx,%rax)
000000010000c0b3	jne	0x10000b708
000000010000c0b9	incq	%rax
000000010000c0bc	movq	%rax, 0x10(%rdi)
000000010000c0c0	movq	0x20(%rbx), %rax
000000010000c0c4	movq	(%rax,%r13,8), %rsi
000000010000c0c8	movq	-0x1d8(%rbp), %rax
000000010000c0cf	leaq	(%rax,%r13,8), %rcx
000000010000c0d3	xorl	%r14d, %r14d
000000010000c0d6	movq	%r12, %rdi
000000010000c0d9	xorl	%edx, %edx
000000010000c0db	callq	_tp_value
000000010000c0e0	testl	%eax, %eax
000000010000c0e2	je	0x10000b708
000000010000c0e8	movq	%r12, %rdi
000000010000c0eb	incq	%r13
000000010000c0ee	movq	-0x1c0(%rbp), %rax
000000010000c0f5	movslq	(%rax), %rax
000000010000c0f8	cmpq	%rax, %r13
000000010000c0fb	jl	0x10000c067
000000010000c101	leaq	0x64d1(%rip), %rsi              ## literal pool for: ")"
000000010000c108	callq	_tp_eat
000000010000c10d	movl	$0x0, %r14d
000000010000c113	testl	%eax, %eax
000000010000c115	je	0x10000b708
000000010000c11b	movq	-0x1c0(%rbp), %rax
000000010000c122	movl	(%rax), %edi
000000010000c124	movq	-0x1d8(%rbp), %rsi
000000010000c12b	callq	_fwp_record
000000010000c130	jmp	0x10000cb02
000000010000c135	movq	%rax, %rbx
000000010000c138	movq	%r15, %rcx
000000010000c13b	jmp	0x10000c1c1
000000010000c140	xorl	%eax, %eax
000000010000c142	movq	%rax, %rbx
000000010000c145	movq	-0x120(%rbp), %rdi
000000010000c14c	callq	_fwp_mem_free
000000010000c151	movq	-0x1d0(%rbp), %rax
000000010000c158	cmpl	$0x11, (%rax)
000000010000c15b	jne	0x10000c1b3
000000010000c15d	movq	0x38(%rax), %r14
000000010000c161	testq	%rbx, %rbx
000000010000c164	je	0x10000c69a
000000010000c16a	movq	%rbx, %rax
000000010000c16d	xorl	%edi, %edi
000000010000c16f	nop
000000010000c170	incq	%rdi
000000010000c173	movq	0x10(%rax), %rax
000000010000c177	testq	%rax, %rax
000000010000c17a	jne	0x10000c170
000000010000c17c	movq	%r14, %rsi
000000010000c17f	callq	_fwp_array_new_packed
000000010000c184	movq	%rax, %r15
000000010000c187	xorl	%r12d, %r12d
000000010000c18a	movq	%rbx, %r13
000000010000c18d	nopl	(%rax)
000000010000c190	movq	0x8(%r13), %rdx
000000010000c194	movq	%r15, %rdi
000000010000c197	movq	%r12, %rsi
000000010000c19a	movq	%r14, %rcx
000000010000c19d	callq	_fwp_array_store
000000010000c1a2	incq	%r12
000000010000c1a5	movq	0x10(%r13), %r13
000000010000c1a9	testq	%r13, %r13
000000010000c1ac	jne	0x10000c190
000000010000c1ae	jmp	0x10000c6a7
000000010000c1b3	movq	%rbx, %r15
000000010000c1b6	jmp	0x10000c6a7
000000010000c1bb	movq	%rax, %rbx
000000010000c1be	movq	%rsi, %rcx
000000010000c1c1	subq	%r15, %rcx
000000010000c1c4	cmpq	$0xff, %rcx
000000010000c1cb	movl	$0xff, %r14d
000000010000c1d1	cmovbq	%rcx, %r14
000000010000c1d5	addq	%r15, %r8
000000010000c1d8	leaq	-0x130(%rbp), %rdi
000000010000c1df	movl	$0x100, %ecx                    ## imm = 0x100
000000010000c1e4	movq	%r8, %rsi
000000010000c1e7	movq	%r14, %rdx
000000010000c1ea	callq	0x10001117a                     ## symbol stub for: ___memcpy_chk
000000010000c1ef	movb	$0x0, -0x130(%rbp,%r14)
000000010000c1f8	movslq	0x10(%rbx), %r12
000000010000c1fc	testq	%r12, %r12
000000010000c1ff	movq	%rbx, -0x1d0(%rbp)
000000010000c206	jle	0x10000c23d
000000010000c208	movq	0x18(%rbx), %r13
000000010000c20c	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c211	xorl	%r15d, %r15d
000000010000c214	leaq	-0x130(%rbp), %r14
000000010000c21b	nopl	(%rax,%rax)
000000010000c220	movq	(%r13,%r15,8), %rdi
000000010000c225	movq	%r14, %rsi
000000010000c228	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000c22d	testl	%eax, %eax
000000010000c22f	cmovel	%r15d, %ebx
000000010000c233	incq	%r15
000000010000c236	cmpq	%r15, %r12
000000010000c239	jne	0x10000c220
000000010000c23b	jmp	0x10000c242
000000010000c23d	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c242	cmpl	$0x0, -0x1d8(%rbp)
000000010000c249	je	0x10000c2c6
000000010000c24b	testl	%ebx, %ebx
000000010000c24d	movq	-0x1c8(%rbp), %r13
000000010000c254	jns	0x10000c2bd
000000010000c256	movq	-0x1d0(%rbp), %rax
000000010000c25d	movq	0x8(%rax), %rdi
000000010000c261	xorl	%r14d, %r14d
000000010000c264	testq	%rdi, %rdi
000000010000c267	je	0x10000b708
000000010000c26d	leaq	0x631b(%rip), %rsi              ## literal pool for: "Bool"
000000010000c274	movq	%rax, %r12
000000010000c277	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000c27c	testl	%eax, %eax
000000010000c27e	jne	0x10000b708
000000010000c284	movq	%r12, %rdx
000000010000c287	movl	-0x130(%rbp), %eax
000000010000c28d	movl	%eax, %esi
000000010000c28f	xorl	$0x65757274, %esi               ## imm = 0x65757274
000000010000c295	movzbl	-0x12c(%rbp), %edi
000000010000c29c	orl	%esi, %edi
000000010000c29e	movl	$0x1, %esi
000000010000c2a3	cmovel	%esi, %ebx
000000010000c2a6	xorl	$0x736c6166, %eax               ## imm = 0x736C6166
000000010000c2ab	movzwl	-0x12c(%rbp), %esi
000000010000c2b2	xorl	$0x65, %esi
000000010000c2b5	orl	%eax, %esi
000000010000c2b7	jne	0x10000c2d4
000000010000c2b9	xorl	%ebx, %ebx
000000010000c2bb	jmp	0x10000c2dc
000000010000c2bd	movq	-0x1d0(%rbp), %rdx
000000010000c2c4	jmp	0x10000c2d4
000000010000c2c6	movq	-0x1d0(%rbp), %rdx
000000010000c2cd	movq	-0x1c8(%rbp), %r13
000000010000c2d4	testl	%ebx, %ebx
000000010000c2d6	js	0x10000ce5c
000000010000c2dc	movq	0x28(%rdx), %rax
000000010000c2e0	movl	%ebx, %esi
000000010000c2e2	movq	%rsi, -0x1d8(%rbp)
000000010000c2e9	movslq	(%rax,%rsi,4), %r15
000000010000c2ed	movl	%r15d, %r9d
000000010000c2f0	leaq	0x8(,%r15,8), %rdi
000000010000c2f8	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000c2ff	movq	%r9, -0x1e0(%rbp)
000000010000c306	ja	0x10000c647
000000010000c30c	leaq	0xf(%rdi), %rsi
000000010000c310	shrq	$0x4, %rsi
000000010000c314	leaq	_fwp_gc(%rip), %rax
000000010000c31b	movzbl	0xbe8(%rsi,%rax), %r8d
000000010000c324	movl	0xb48(%rax,%r8,4), %esi
000000010000c32c	subq	%rsi, _fwp_gc(%rip)
000000010000c333	js	0x10000c647
000000010000c339	leaq	(%r8,%r8,2), %r8
000000010000c33d	leaq	(%rax,%r8,8), %rax
000000010000c341	addq	$0x788, %rax                    ## imm = 0x788
000000010000c347	movq	(%rax), %r8
000000010000c34a	testq	%r8, %r8
000000010000c34d	je	0x10000c633
000000010000c353	movq	%rdx, %r14
000000010000c356	movq	(%r8), %rcx
000000010000c359	notq	%rcx
000000010000c35c	movq	%rcx, (%rax)
000000010000c35f	movq	%r8, -0x1c0(%rbp)
000000010000c366	movq	%r8, %rdi
000000010000c369	jmp	0x10000c876
000000010000c36e	leaq	-0x130(%rbp), %rsi
000000010000c375	movl	$0x80, %edx
000000010000c37a	movq	-0x1c8(%rbp), %rdi
000000010000c381	callq	_tp_token
000000010000c386	movq	%rax, %r14
000000010000c389	addq	%rbp, %rax
000000010000c38c	addq	$-0x130, %rax                   ## imm = 0xFED0
000000010000c392	movq	%rax, -0x1d0(%rbp)
000000010000c399	xorl	%ebx, %ebx
000000010000c39b	jmp	0x10000c3aa
000000010000c39d	incq	%rbx
000000010000c3a0	cmpq	$0x6, %rbx
000000010000c3a4	je	0x10000ce5c
000000010000c3aa	movq	%rbx, %r12
000000010000c3ad	shlq	$0x4, %r12
000000010000c3b1	leaq	_tp_value.units(%rip), %rax
000000010000c3b8	movq	(%r12,%rax), %r15
000000010000c3bc	movq	%r15, %rdi
000000010000c3bf	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000c3c4	movq	%r14, %r13
000000010000c3c7	subq	%rax, %r13
000000010000c3ca	jbe	0x10000c39d
000000010000c3cc	movq	-0x1d0(%rbp), %rdi
000000010000c3d3	subq	%rax, %rdi
000000010000c3d6	movq	%r15, %rsi
000000010000c3d9	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000c3de	testl	%eax, %eax
000000010000c3e0	jne	0x10000c39d
000000010000c3e2	leaq	_tp_value.units(%rip), %rax
000000010000c3e9	addq	%rax, %r12
000000010000c3ec	movl	$0x80, %ecx
000000010000c3f1	leaq	-0x1b0(%rbp), %rdi
000000010000c3f8	leaq	-0x130(%rbp), %rsi
000000010000c3ff	movq	%r13, %rdx
000000010000c402	callq	0x10001117a                     ## symbol stub for: ___memcpy_chk
000000010000c407	movb	$0x0, -0x1b0(%rbp,%r13)
000000010000c410	movzbl	-0x1b0(%rbp), %esi
000000010000c417	leal	-0x2b(%rsi), %eax
000000010000c41a	xorl	%ecx, %ecx
000000010000c41c	testb	$-0x3, %al
000000010000c41e	sete	%cl
000000010000c421	cmpq	%rcx, %r13
000000010000c424	je	0x10000c39d
000000010000c42a	jbe	0x10000c448
000000010000c42c	movzbl	-0x1b0(%rbp,%rcx), %edx
000000010000c434	addb	$-0x3a, %dl
000000010000c437	cmpb	$-0xa, %dl
000000010000c43a	jb	0x10000c39d
000000010000c440	incq	%rcx
000000010000c443	cmpq	%rcx, %r13
000000010000c446	jne	0x10000c42c
000000010000c448	xorl	%ecx, %ecx
000000010000c44a	testb	$-0x3, %al
000000010000c44c	sete	%cl
000000010000c44f	movzbl	-0x1b0(%rbp,%rcx), %r10d
000000010000c458	xorl	%r14d, %r14d
000000010000c45b	testb	%r10b, %r10b
000000010000c45e	je	0x10000ca64
000000010000c464	leaq	-0x1b0(%rbp), %rax
000000010000c46b	addq	%rax, %rcx
000000010000c46e	incq	%rcx
000000010000c471	xorl	%eax, %eax
000000010000c473	movl	$0xa, %edi
000000010000c478	movabsq	$-0x8000000000000000, %r9       ## imm = 0x8000000000000000
000000010000c482	xorl	%r8d, %r8d
000000010000c485	mulq	%rdi
000000010000c488	leaq	(%r8,%r8,4), %r8
000000010000c48c	leaq	(%rdx,%r8,2), %rdx
000000010000c490	movsbl	%r10b, %r8d
000000010000c494	addl	$-0x30, %r8d
000000010000c498	movslq	%r8d, %r10
000000010000c49b	movq	%r10, %r8
000000010000c49e	sarq	$0x3f, %r8
000000010000c4a2	addq	%r10, %rax
000000010000c4a5	adcq	%rdx, %r8
000000010000c4a8	cmpq	%rax, %r9
000000010000c4ab	movl	$0x0, %edx
000000010000c4b0	sbbq	%r8, %rdx
000000010000c4b3	jl	0x10000ce5c
000000010000c4b9	movzbl	(%rcx), %r10d
000000010000c4bd	incq	%rcx
000000010000c4c0	testb	%r10b, %r10b
000000010000c4c3	jne	0x10000c485
000000010000c4c5	jmp	0x10000ca69
000000010000c4ca	addq	$0x5, %r15
000000010000c4ce	movq	%r15, 0x10(%rdi)
000000010000c4d2	leaq	0x60c8(%rip), %rsi              ## literal pool for: "["
000000010000c4d9	leaq	0x60c3(%rip), %rdx              ## literal pool for: "]"
000000010000c4e0	leaq	_tp_byte_item(%rip), %rcx
000000010000c4e7	leaq	-0x130(%rbp), %r8
000000010000c4ee	callq	_tp_list_of
000000010000c4f3	testl	%eax, %eax
000000010000c4f5	je	0x10000c57d
000000010000c4fb	movq	%rbx, %r12
000000010000c4fe	pxor	%xmm0, %xmm0
000000010000c502	movdqa	%xmm0, -0x1b0(%rbp)
000000010000c50a	movq	$0x0, -0x1a0(%rbp)
000000010000c515	cmpq	$0x0, -0x118(%rbp)
000000010000c51d	je	0x10000c55c
000000010000c51f	xorl	%ebx, %ebx
000000010000c521	leaq	-0x1b0(%rbp), %r14
000000010000c528	leaq	-0x1b8(%rbp), %r15
000000010000c52f	movq	-0x120(%rbp), %rax
000000010000c536	movzbl	(%rax,%rbx,8), %eax
000000010000c53a	movb	%al, -0x1b8(%rbp)
000000010000c540	movl	$0x1, %edx
000000010000c545	movq	%r14, %rdi
000000010000c548	movq	%r15, %rsi
000000010000c54b	callq	_buf_put
000000010000c550	incq	%rbx
000000010000c553	cmpq	-0x118(%rbp), %rbx
000000010000c55a	jb	0x10000c52f
000000010000c55c	movq	-0x120(%rbp), %rdi
000000010000c563	callq	_fwp_mem_free
000000010000c568	leaq	-0x1b0(%rbp), %rdi
000000010000c56f	callq	_buf_to_str
000000010000c574	movq	%rax, (%r12)
000000010000c578	jmp	0x10000b702
000000010000c57d	movq	-0x120(%rbp), %rdi
000000010000c584	callq	_fwp_mem_free
000000010000c589	jmp	0x10000b708
000000010000c58e	movsd	0x4ef2(%rip), %xmm0
000000010000c596	cmpl	$0xa, (%rcx)
000000010000c599	cvtsd2ss	%xmm0, %xmm1
000000010000c59d	movd	%xmm1, %ecx
000000010000c5a1	movq	%xmm0, %rax
000000010000c5a6	cmoveq	%rcx, %rax
000000010000c5aa	movq	%rax, (%r15)
000000010000c5ad	jmp	0x10000b702
000000010000c5b2	movq	0x8(%rdx), %r9
000000010000c5b6	movq	0x10(%rdx), %r8
000000010000c5ba	subq	%r9, %r8
000000010000c5bd	cmpq	%rsi, %r8
000000010000c5c0	jae	0x10000c6c8
000000010000c5c6	movq	%rdi, %r15
000000010000c5c9	movq	%rax, %rbx
000000010000c5cc	movq	%rcx, %rdi
000000010000c5cf	movl	$0x2, %esi
000000010000c5d4	callq	_fwp_gc_alloc_slow
000000010000c5d9	movq	%rax, -0x1e0(%rbp)
000000010000c5e0	jmp	0x10000c6e5
000000010000c5e5	testq	%rax, %rax
000000010000c5e8	setne	%sil
000000010000c5ec	addb	$-0x2b, %dl
000000010000c5ef	testb	$-0x3, %dl
000000010000c5f2	sete	%dl
000000010000c5f5	andb	%sil, %dl
000000010000c5f8	movzbl	%dl, %esi
000000010000c5fb	movb	$0x1, %r8b
000000010000c5fe	movq	%rsi, %rdi
000000010000c601	cmpq	%rsi, %rax
000000010000c604	jbe	0x10000c859
000000010000c60a	movzbl	-0x130(%rbp,%rdi), %edx
000000010000c612	leal	-0x30(%rdx), %r9d
000000010000c616	cmpb	$0x9, %r9b
000000010000c61a	ja	0x10000cb11
000000010000c620	incq	%rdi
000000010000c623	cmpq	%rdi, %rax
000000010000c626	jne	0x10000c60a
000000010000c628	movq	%rax, %rdi
000000010000c62b	movq	%rax, %rdx
000000010000c62e	jmp	0x10000ce67
000000010000c633	movq	0x8(%rax), %r10
000000010000c637	movq	0x10(%rax), %r8
000000010000c63b	subq	%r10, %r8
000000010000c63e	cmpq	%rsi, %r8
000000010000c641	jae	0x10000c861
000000010000c647	movq	%rdx, %r14
000000010000c64a	movl	$0x2, %esi
000000010000c64f	callq	_fwp_gc_alloc_slow
000000010000c654	movq	%rax, -0x1c0(%rbp)
000000010000c65b	jmp	0x10000c87b
000000010000c660	leaq	0x5f70(%rip), %rsi              ## literal pool for: "("
000000010000c667	movq	%rdi, %r15
000000010000c66a	callq	_tp_eat
000000010000c66f	testl	%eax, %eax
000000010000c671	je	0x10000b708
000000010000c677	leaq	0x5f5b(%rip), %rsi              ## literal pool for: ")"
000000010000c67e	movq	%r15, %rdi
000000010000c681	callq	_tp_eat
000000010000c686	testl	%eax, %eax
000000010000c688	je	0x10000b708
000000010000c68e	movq	$0x0, (%rbx)
000000010000c695	jmp	0x10000b702
000000010000c69a	xorl	%edi, %edi
000000010000c69c	movq	%r14, %rsi
000000010000c69f	callq	_fwp_array_new_packed
000000010000c6a4	movq	%rax, %r15
000000010000c6a7	movq	-0x1e8(%rbp), %rax
000000010000c6ae	movq	%r15, (%rax)
000000010000c6b1	jmp	0x10000b702
000000010000c6b6	xorl	%ecx, %ecx
000000010000c6b8	movq	%rcx, (%r15)
000000010000c6bb	jmp	0x10000b702
000000010000c6c0	movq	%rcx, (%rdi)
000000010000c6c3	jmp	0x10000b702
000000010000c6c8	movq	%rdi, %r15
000000010000c6cb	movq	%rax, %rbx
000000010000c6ce	leaq	(%r9,%rsi), %rax
000000010000c6d2	movq	%rax, 0x8(%rdx)
000000010000c6d6	movq	%r9, -0x1e0(%rbp)
000000010000c6dd	movq	%r9, %rdi
000000010000c6e0	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000c6e5	movslq	(%r13), %rax
000000010000c6e9	leaq	0x1(%rax), %rsi
000000010000c6ed	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000c6f4	ja	0x10000c74b
000000010000c6f6	addq	$0x10, %rax
000000010000c6fa	shrq	$0x4, %rax
000000010000c6fe	movzbl	0xbe8(%rax,%r12), %ecx
000000010000c707	movl	0xb48(%r12,%rcx,4), %eax
000000010000c70f	subq	%rax, _fwp_gc(%rip)
000000010000c716	js	0x10000c74b
000000010000c718	leaq	(%rcx,%rcx,2), %rcx
000000010000c71c	leaq	(%r12,%rcx,8), %rcx
000000010000c720	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000c727	movq	(%rcx), %r12
000000010000c72a	testq	%r12, %r12
000000010000c72d	je	0x10000c73b
000000010000c72f	movq	(%r12), %rax
000000010000c733	notq	%rax
000000010000c736	movq	%rax, (%rcx)
000000010000c739	jmp	0x10000c764
000000010000c73b	movq	0x8(%rcx), %r12
000000010000c73f	movq	0x10(%rcx), %rdx
000000010000c743	subq	%r12, %rdx
000000010000c746	cmpq	%rax, %rdx
000000010000c749	jae	0x10000c75d
000000010000c74b	movq	%rsi, %rdi
000000010000c74e	movl	$0x1, %esi
000000010000c753	callq	_fwp_gc_alloc_slow
000000010000c758	movq	%rax, %r12
000000010000c75b	jmp	0x10000c76c
000000010000c75d	addq	%r12, %rax
000000010000c760	movq	%rax, 0x8(%rcx)
000000010000c764	movq	%r12, %rdi
000000010000c767	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000c76c	movslq	(%r13), %rsi
000000010000c770	incq	%rsi
000000010000c773	movq	%r12, %rdi
000000010000c776	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000c77b	movq	0x8(%r15), %rcx
000000010000c77f	movq	0x10(%r15), %rax
000000010000c783	cmpq	%rcx, %rax
000000010000c786	jae	0x10000c7b6
000000010000c788	movq	(%r15), %rdx
000000010000c78b	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000c795	movzbl	(%rdx,%rax), %edi
000000010000c799	cmpq	$0x20, %rdi
000000010000c79d	ja	0x10000c7b6
000000010000c79f	btq	%rdi, %rsi
000000010000c7a3	jae	0x10000c7b6
000000010000c7a5	incq	%rax
000000010000c7a8	movq	%rax, 0x10(%r15)
000000010000c7ac	cmpq	%rax, %rcx
000000010000c7af	jne	0x10000c795
000000010000c7b1	jmp	0x10000b708
000000010000c7b6	cmpq	%rax, %rcx
000000010000c7b9	je	0x10000b708
000000010000c7bf	movq	%r13, -0x1c0(%rbp)
000000010000c7c6	movq	(%r15), %rcx
000000010000c7c9	cmpb	$0x7b, (%rcx,%rax)
000000010000c7cd	jne	0x10000b708
000000010000c7d3	incq	%rax
000000010000c7d6	movq	%rax, 0x10(%r15)
000000010000c7da	leaq	0x5dda(%rip), %rsi              ## literal pool for: "}"
000000010000c7e1	movq	%r15, -0x1c8(%rbp)
000000010000c7e8	movq	%r15, %rdi
000000010000c7eb	callq	_tp_eat
000000010000c7f0	testl	%eax, %eax
000000010000c7f2	je	0x10000cbf2
000000010000c7f8	movq	-0x1c0(%rbp), %rax
000000010000c7ff	movslq	(%rax), %rdi
000000010000c802	testq	%rdi, %rdi
000000010000c805	movq	-0x1e8(%rbp), %rbx
000000010000c80c	movq	-0x1e0(%rbp), %rsi
000000010000c813	jle	0x10000c82d
000000010000c815	xorl	%r14d, %r14d
000000010000c818	xorl	%eax, %eax
000000010000c81a	cmpb	$0x0, (%r12,%rax)
000000010000c81f	je	0x10000b708
000000010000c825	incq	%rax
000000010000c828	cmpq	%rax, %rdi
000000010000c82b	jne	0x10000c81a
000000010000c82d	callq	_fwp_record
000000010000c832	movq	%rax, (%rbx)
000000010000c835	jmp	0x10000b702
000000010000c83a	leaq	_fwp_empty_map(%rip), %rax
000000010000c841	movq	-0x120(%rbp), %rdi
000000010000c848	movq	%rax, %rbx
000000010000c84b	callq	_fwp_mem_free
000000010000c850	movq	%rbx, (%r12)
000000010000c854	jmp	0x10000b702
000000010000c859	movq	%rsi, %rdx
000000010000c85c	jmp	0x10000ce67
000000010000c861	movq	%rdx, %r14
000000010000c864	leaq	(%r10,%rsi), %rcx
000000010000c868	movq	%rcx, 0x8(%rax)
000000010000c86c	movq	%r10, -0x1c0(%rbp)
000000010000c873	movq	%r10, %rdi
000000010000c876	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000c87b	movq	%r15, -0x1f0(%rbp)
000000010000c882	testl	%r15d, %r15d
000000010000c885	jle	0x10000c9e0
000000010000c88b	movq	%r14, %rax
000000010000c88e	xorl	%r15d, %r15d
000000010000c891	movabsq	$0x100002600, %r12              ## imm = 0x100002600
000000010000c89b	movq	0x30(%rax), %rcx
000000010000c89f	movq	-0x1d8(%rbp), %rdx
000000010000c8a6	movq	(%rcx,%rdx,8), %rcx
000000010000c8aa	movq	(%rcx,%r15,8), %rsi
000000010000c8ae	movq	0x8(%r13), %rdi
000000010000c8b2	movq	0x10(%r13), %rdx
000000010000c8b6	cmpq	%rdi, %rdx
000000010000c8b9	jae	0x10000c8e0
000000010000c8bb	movq	(%r13), %rcx
000000010000c8bf	nop
000000010000c8c0	movzbl	(%rcx,%rdx), %r8d
000000010000c8c5	cmpq	$0x20, %r8
000000010000c8c9	ja	0x10000c8e0
000000010000c8cb	btq	%r8, %r12
000000010000c8cf	jae	0x10000c8e0
000000010000c8d1	incq	%rdx
000000010000c8d4	movq	%rdx, 0x10(%r13)
000000010000c8d8	cmpq	%rdx, %rdi
000000010000c8db	jne	0x10000c8c0
000000010000c8dd	movq	%rdi, %rdx
000000010000c8e0	cmpl	$0x10, (%rsi)
000000010000c8e3	jne	0x10000c8f0
000000010000c8e5	cmpq	$0x0, 0x8(%rsi)
000000010000c8ea	je	0x10000c9a2
000000010000c8f0	xorl	%r8d, %r8d
000000010000c8f3	movq	-0x1c0(%rbp), %rax
000000010000c8fa	leaq	(%rax,%r15,8), %rcx
000000010000c8fe	cmpq	%rdi, %rdx
000000010000c901	jae	0x10000c915
000000010000c903	movq	(%r13), %rax
000000010000c907	cmpb	$0x28, (%rax,%rdx)
000000010000c90b	setne	%al
000000010000c90e	orb	%r8b, %al
000000010000c911	testb	$0x1, %al
000000010000c913	je	0x10000c946
000000010000c915	xorl	%r14d, %r14d
000000010000c918	movq	%r13, %rdi
000000010000c91b	xorl	%edx, %edx
000000010000c91d	callq	_tp_value
000000010000c922	testl	%eax, %eax
000000010000c924	movq	-0x1d0(%rbp), %rax
000000010000c92b	je	0x10000b708
000000010000c931	incq	%r15
000000010000c934	cmpq	-0x1e0(%rbp), %r15
000000010000c93b	jne	0x10000c89b
000000010000c941	jmp	0x10000c9e0
000000010000c946	incq	%rdx
000000010000c949	movq	%rdx, 0x10(%r13)
000000010000c94d	xorl	%r14d, %r14d
000000010000c950	movq	%r13, %rdi
000000010000c953	xorl	%edx, %edx
000000010000c955	callq	_tp_value
000000010000c95a	testl	%eax, %eax
000000010000c95c	je	0x10000b708
000000010000c962	movq	-0x1c8(%rbp), %r13
000000010000c969	movq	0x8(%r13), %rdx
000000010000c96d	movq	0x10(%r13), %rcx
000000010000c971	cmpq	%rdx, %rcx
000000010000c974	movq	-0x1d0(%rbp), %rax
000000010000c97b	jae	0x10000c9b5
000000010000c97d	movq	(%r13), %rsi
000000010000c981	movzbl	(%rsi,%rcx), %edi
000000010000c985	cmpq	$0x20, %rdi
000000010000c989	ja	0x10000c9b5
000000010000c98b	btq	%rdi, %r12
000000010000c98f	jae	0x10000c9b5
000000010000c991	incq	%rcx
000000010000c994	movq	%rcx, 0x10(%r13)
000000010000c998	cmpq	%rcx, %rdx
000000010000c99b	jne	0x10000c981
000000010000c99d	jmp	0x10000b708
000000010000c9a2	cmpl	$0x0, 0x10(%rsi)
000000010000c9a6	je	0x10000c9d8
000000010000c9a8	cmpl	$0x0, 0x48(%rsi)
000000010000c9ac	setne	%r8b
000000010000c9b0	jmp	0x10000c8f3
000000010000c9b5	cmpq	%rcx, %rdx
000000010000c9b8	je	0x10000b708
000000010000c9be	movq	(%r13), %rdx
000000010000c9c2	cmpb	$0x29, (%rdx,%rcx)
000000010000c9c6	jne	0x10000b708
000000010000c9cc	incq	%rcx
000000010000c9cf	movq	%rcx, 0x10(%r13)
000000010000c9d3	jmp	0x10000c931
000000010000c9d8	movb	$0x1, %r8b
000000010000c9db	jmp	0x10000c8f3
000000010000c9e0	movq	-0x1f0(%rbp), %r15
000000010000c9e7	testl	%r15d, %r15d
000000010000c9ea	movq	-0x1d8(%rbp), %rdi
000000010000c9f1	je	0x10000cbe3
000000010000c9f7	movq	-0x1e0(%rbp), %r14
000000010000c9fe	leaq	0x8(,%r14,8), %rdi
000000010000ca06	callq	_fwp_alloc_init
000000010000ca0b	movq	%rax, %rdi
000000010000ca0e	movl	%ebx, (%rax)
000000010000ca10	movl	%r15d, 0x4(%rax)
000000010000ca14	cmpl	$0x7, %r15d
000000010000ca18	ja	0x10000ca42
000000010000ca1a	xorl	%eax, %eax
000000010000ca1c	movq	-0x1c0(%rbp), %r8
000000010000ca23	jmp	0x10000cb8a
000000010000ca28	addq	%r12, %r15
000000010000ca2b	movq	-0x1c8(%rbp), %rdi
000000010000ca32	movq	%r15, 0x10(%rdi)
000000010000ca36	movq	-0x1d0(%rbp), %rax
000000010000ca3d	jmp	0x10000be24
000000010000ca42	movq	%rdi, %rax
000000010000ca45	movq	-0x1c0(%rbp), %r8
000000010000ca4c	subq	%r8, %rax
000000010000ca4f	addq	$0x8, %rax
000000010000ca53	cmpq	$0x20, %rax
000000010000ca57	jae	0x10000cb51
000000010000ca5d	xorl	%eax, %eax
000000010000ca5f	jmp	0x10000cb8a
000000010000ca64	xorl	%eax, %eax
000000010000ca66	xorl	%r8d, %r8d
000000010000ca69	movq	%rax, %rcx
000000010000ca6c	negq	%rcx
000000010000ca6f	movl	$0x0, %edi
000000010000ca74	sbbq	%r8, %rdi
000000010000ca77	cmpb	$0x2d, %sil
000000010000ca7b	cmovneq	%r8, %rdi
000000010000ca7f	cmovneq	%rax, %rcx
000000010000ca83	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000ca8d	cmpq	%rcx, %rax
000000010000ca90	movl	$0x0, %eax
000000010000ca95	sbbq	%rdi, %rax
000000010000ca98	jl	0x10000b708
000000010000ca9e	movq	0x8(%r12), %rsi
000000010000caa3	movq	%rcx, %rax
000000010000caa6	mulq	%rsi
000000010000caa9	imulq	%rsi, %rdi
000000010000caad	sarq	$0x3f, %rsi
000000010000cab1	imulq	%rcx, %rsi
000000010000cab5	addq	%rdx, %rsi
000000010000cab8	addq	%rsi, %rdi
000000010000cabb	movabsq	$-0x8000000000000000, %rcx      ## imm = 0x8000000000000000
000000010000cac5	addq	%rax, %rcx
000000010000cac8	adcq	$-0x1, %rdi
000000010000cacc	cmpq	$-0x1, %rdi
000000010000cad0	jne	0x10000b708
000000010000cad6	movq	%rax, -0x1b8(%rbp)
000000010000cadd	movl	$0x10, %edi
000000010000cae2	movq	%rax, %rbx
000000010000cae5	callq	_fwp_alloc_init
000000010000caea	movabsq	$__mh_execute_header, %rcx
000000010000caf4	movq	%rcx, (%rax)
000000010000caf7	movq	%rbx, 0x8(%rax)
000000010000cafb	leaq	-0x1b8(%rbp), %rcx
000000010000cb02	movq	-0x1e8(%rbp), %rcx
000000010000cb09	movq	%rax, (%rcx)
000000010000cb0c	jmp	0x10000b702
000000010000cb11	cmpb	$0x2e, %dl
000000010000cb14	jne	0x10000ce64
000000010000cb1a	leaq	0x1(%rdi), %rdx
000000010000cb1e	cmpq	%rax, %rdx
000000010000cb21	jae	0x10000cb41
000000010000cb23	movzbl	-0x130(%rbp,%rdx), %r8d
000000010000cb2c	addb	$-0x30, %r8b
000000010000cb30	cmpb	$0x9, %r8b
000000010000cb34	ja	0x10000cb41
000000010000cb36	incq	%rdx
000000010000cb39	cmpq	%rax, %rdx
000000010000cb3c	jb	0x10000cb23
000000010000cb3e	movq	%rax, %rdx
000000010000cb41	leaq	-0x1(%rdx), %r8
000000010000cb45	cmpq	%rdi, %r8
000000010000cb48	sete	%r8b
000000010000cb4c	jmp	0x10000ce67
000000010000cb51	movl	%r14d, %eax
000000010000cb54	andl	$-0x4, %eax
000000010000cb57	leaq	(,%r14,8), %rcx
000000010000cb5f	andq	$-0x20, %rcx
000000010000cb63	xorl	%edx, %edx
000000010000cb65	movdqu	(%r8,%rdx), %xmm0
000000010000cb6b	movups	0x10(%r8,%rdx), %xmm1
000000010000cb71	movdqu	%xmm0, 0x8(%rdi,%rdx)
000000010000cb77	movups	%xmm1, 0x18(%rdi,%rdx)
000000010000cb7c	addq	$0x20, %rdx
000000010000cb80	cmpq	%rdx, %rcx
000000010000cb83	jne	0x10000cb65
000000010000cb85	cmpl	%r14d, %eax
000000010000cb88	je	0x10000cbe3
000000010000cb8a	movq	%r14, %rdx
000000010000cb8d	movq	%rax, %rcx
000000010000cb90	andq	$0x3, %rdx
000000010000cb94	je	0x10000cbaa
000000010000cb96	movq	%rax, %rcx
000000010000cb99	movq	(%r8,%rcx,8), %rsi
000000010000cb9d	movq	%rsi, 0x8(%rdi,%rcx,8)
000000010000cba2	incq	%rcx
000000010000cba5	decq	%rdx
000000010000cba8	jne	0x10000cb99
000000010000cbaa	subq	%r14, %rax
000000010000cbad	cmpq	$-0x4, %rax
000000010000cbb1	ja	0x10000cbe3
000000010000cbb3	movq	(%r8,%rcx,8), %rax
000000010000cbb7	movq	%rax, 0x8(%rdi,%rcx,8)
000000010000cbbc	movq	0x8(%r8,%rcx,8), %rax
000000010000cbc1	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000cbc6	movq	0x10(%r8,%rcx,8), %rax
000000010000cbcb	movq	%rax, 0x18(%rdi,%rcx,8)
000000010000cbd0	movq	0x18(%r8,%rcx,8), %rax
000000010000cbd5	movq	%rax, 0x20(%rdi,%rcx,8)
000000010000cbda	addq	$0x4, %rcx
000000010000cbde	cmpq	%rcx, %r14
000000010000cbe1	jne	0x10000cbb3
000000010000cbe3	movq	-0x1e8(%rbp), %rax
000000010000cbea	movq	%rdi, (%rax)
000000010000cbed	jmp	0x10000b702
000000010000cbf2	movq	%r12, -0x1f8(%rbp)
000000010000cbf9	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000cc03	movl	$0xff, %r8d
000000010000cc09	leaq	-0x130(%rbp), %r9
000000010000cc10	movq	-0x1c8(%rbp), %rcx
000000010000cc17	movq	-0x1c0(%rbp), %r12
000000010000cc1e	movq	%rbx, -0x1d0(%rbp)
000000010000cc25	movq	(%rcx), %rbx
000000010000cc28	movq	0x8(%rcx), %r10
000000010000cc2c	movq	0x10(%rcx), %rsi
000000010000cc30	cmpq	%r10, %rsi
000000010000cc33	movq	%r10, -0x1f0(%rbp)
000000010000cc3a	jae	0x10000cc60
000000010000cc3c	movzbl	(%rbx,%rsi), %eax
000000010000cc40	cmpq	$0x20, %rax
000000010000cc44	ja	0x10000cc60
000000010000cc46	btq	%rax, %r13
000000010000cc4a	jae	0x10000cc60
000000010000cc4c	incq	%rsi
000000010000cc4f	movq	%rsi, 0x10(%rcx)
000000010000cc53	cmpq	%rsi, %r10
000000010000cc56	jne	0x10000cc3c
000000010000cc58	movq	%r10, %r14
000000010000cc5b	movq	%r10, %rsi
000000010000cc5e	jmp	0x10000ccb0
000000010000cc60	movabsq	$0x4000000000003, %rdi          ## imm = 0x4000000000003
000000010000cc6a	movq	%rsi, %r14
000000010000cc6d	cmpq	%r10, %rsi
000000010000cc70	jb	0x10000cc80
000000010000cc72	jmp	0x10000ccb0
000000010000cc74	incq	%r14
000000010000cc77	movq	%r14, 0x10(%rcx)
000000010000cc7b	cmpq	%r14, %r10
000000010000cc7e	je	0x10000ccad
000000010000cc80	movzbl	(%rbx,%r14), %eax
000000010000cc85	leal	-0x30(%rax), %edx
000000010000cc88	cmpb	$0xa, %dl
000000010000cc8b	jb	0x10000cc74
000000010000cc8d	movl	%eax, %edx
000000010000cc8f	andb	$-0x21, %dl
000000010000cc92	addb	$-0x41, %dl
000000010000cc95	cmpb	$0x1a, %dl
000000010000cc98	jb	0x10000cc74
000000010000cc9a	movzbl	%al, %eax
000000010000cc9d	addl	$-0x2d, %eax
000000010000cca0	cmpl	$0x32, %eax
000000010000cca3	ja	0x10000ccb0
000000010000cca5	btq	%rax, %rdi
000000010000cca9	jb	0x10000cc74
000000010000ccab	jmp	0x10000ccb0
000000010000ccad	movq	%r10, %r14
000000010000ccb0	movq	%r14, %r15
000000010000ccb3	subq	%rsi, %r15
000000010000ccb6	cmpq	$0xff, %r15
000000010000ccbd	cmovaeq	%r8, %r15
000000010000ccc1	addq	%rbx, %rsi
000000010000ccc4	movl	$0x100, %ecx                    ## imm = 0x100
000000010000ccc9	movq	%r9, %rdi
000000010000cccc	movq	%r15, %rdx
000000010000cccf	callq	0x10001117a                     ## symbol stub for: ___memcpy_chk
000000010000ccd4	movb	$0x0, -0x130(%rbp,%r15)
000000010000ccdd	movslq	(%r12), %rcx
000000010000cce1	testq	%rcx, %rcx
000000010000cce4	movq	-0x1d0(%rbp), %rax
000000010000cceb	jle	0x10000ce5c
000000010000ccf1	movq	%rbx, -0x200(%rbp)
000000010000ccf8	movq	0x18(%rax), %rax
000000010000ccfc	movq	%rax, -0x1d8(%rbp)
000000010000cd03	movl	$0xffffffff, %r15d              ## imm = 0xFFFFFFFF
000000010000cd09	xorl	%r13d, %r13d
000000010000cd0c	leaq	-0x130(%rbp), %r12
000000010000cd13	movq	-0x1d8(%rbp), %rax
000000010000cd1a	movq	(%rax,%r13,8), %rdi
000000010000cd1e	movq	%r12, %rsi
000000010000cd21	movq	%rcx, %rbx
000000010000cd24	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000cd29	movq	%rbx, %rcx
000000010000cd2c	testl	%eax, %eax
000000010000cd2e	cmovel	%r13d, %r15d
000000010000cd32	incq	%r13
000000010000cd35	cmpq	%r13, %rbx
000000010000cd38	jne	0x10000cd13
000000010000cd3a	testl	%r15d, %r15d
000000010000cd3d	movq	-0x1d0(%rbp), %rax
000000010000cd44	movq	-0x1c8(%rbp), %rcx
000000010000cd4b	movq	-0x1c0(%rbp), %r12
000000010000cd52	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000cd5c	movq	-0x200(%rbp), %rsi
000000010000cd63	movq	-0x1f0(%rbp), %rdi
000000010000cd6a	js	0x10000ce5c
000000010000cd70	cmpq	%rdi, %r14
000000010000cd73	jae	0x10000cd97
000000010000cd75	movzbl	(%rsi,%r14), %edx
000000010000cd7a	cmpq	$0x20, %rdx
000000010000cd7e	ja	0x10000cd97
000000010000cd80	btq	%rdx, %r13
000000010000cd84	jae	0x10000cd97
000000010000cd86	incq	%r14
000000010000cd89	movq	%r14, 0x10(%rcx)
000000010000cd8d	cmpq	%r14, %rdi
000000010000cd90	jne	0x10000cd75
000000010000cd92	jmp	0x10000ce5c
000000010000cd97	cmpq	%r14, %rdi
000000010000cd9a	je	0x10000ce5c
000000010000cda0	cmpb	$0x3d, (%rsi,%r14)
000000010000cda5	jne	0x10000ce5c
000000010000cdab	incq	%r14
000000010000cdae	movq	%r14, 0x10(%rcx)
000000010000cdb2	movq	0x20(%rax), %rax
000000010000cdb6	movl	%r15d, %ebx
000000010000cdb9	movq	(%rax,%rbx,8), %rsi
000000010000cdbd	movq	-0x1e0(%rbp), %rax
000000010000cdc4	leaq	(%rax,%rbx,8), %rcx
000000010000cdc8	movq	-0x1c8(%rbp), %rdi
000000010000cdcf	xorl	%edx, %edx
000000010000cdd1	callq	_tp_value
000000010000cdd6	movq	-0x1c8(%rbp), %rcx
000000010000cddd	testl	%eax, %eax
000000010000cddf	je	0x10000ce5c
000000010000cde1	movq	-0x1f8(%rbp), %rax
000000010000cde8	movb	$0x1, (%rax,%rbx)
000000010000cdec	movq	0x8(%rcx), %rdx
000000010000cdf0	movq	0x10(%rcx), %rax
000000010000cdf4	cmpq	%rdx, %rax
000000010000cdf7	jae	0x10000ce1a
000000010000cdf9	movq	(%rcx), %rsi
000000010000cdfc	movzbl	(%rsi,%rax), %edi
000000010000ce00	cmpq	$0x20, %rdi
000000010000ce04	ja	0x10000ce1a
000000010000ce06	btq	%rdi, %r13
000000010000ce0a	jae	0x10000ce1a
000000010000ce0c	incq	%rax
000000010000ce0f	movq	%rax, 0x10(%rcx)
000000010000ce13	cmpq	%rax, %rdx
000000010000ce16	jne	0x10000cdfc
000000010000ce18	jmp	0x10000ce2c
000000010000ce1a	cmpq	%rax, %rdx
000000010000ce1d	je	0x10000ce2c
000000010000ce1f	movq	(%rcx), %rdx
000000010000ce22	cmpb	$0x7d, (%rdx,%rax)
000000010000ce26	je	0x10000cf19
000000010000ce2c	movq	-0x1c8(%rbp), %rdi
000000010000ce33	leaq	0x57a1(%rip), %rsi              ## literal pool for: ","
000000010000ce3a	callq	_tp_eat
000000010000ce3f	movq	-0x1c8(%rbp), %rcx
000000010000ce46	testl	%eax, %eax
000000010000ce48	je	0x10000ce5c
000000010000ce4a	movl	$0xff, %r8d
000000010000ce50	leaq	-0x130(%rbp), %r9
000000010000ce57	jmp	0x10000cc25
000000010000ce5c	xorl	%r14d, %r14d
000000010000ce5f	jmp	0x10000b708
000000010000ce64	movq	%rdi, %rdx
000000010000ce67	cmpq	%rsi, %rdi
000000010000ce6a	jne	0x10000ce75
000000010000ce6c	testb	%r8b, %r8b
000000010000ce6f	jne	0x10000b708
000000010000ce75	cmpq	%rax, %rdx
000000010000ce78	jae	0x10000cede
000000010000ce7a	movzbl	-0x130(%rbp,%rdx), %esi
000000010000ce82	orl	$0x20, %esi
000000010000ce85	cmpl	$0x65, %esi
000000010000ce88	jne	0x10000cede
000000010000ce8a	leaq	0x1(%rdx), %rsi
000000010000ce8e	cmpq	%rax, %rsi
000000010000ce91	jae	0x10000ceac
000000010000ce93	movzbl	-0x130(%rbp,%rsi), %edi
000000010000ce9b	cmpl	$0x2d, %edi
000000010000ce9e	je	0x10000cea5
000000010000cea0	cmpl	$0x2b, %edi
000000010000cea3	jne	0x10000ceac
000000010000cea5	addq	$0x2, %rdx
000000010000cea9	movq	%rdx, %rsi
000000010000ceac	cmpq	%rax, %rsi
000000010000ceaf	jae	0x10000b708
000000010000ceb5	movq	%rsi, %rdx
000000010000ceb8	movzbl	-0x130(%rbp,%rdx), %edi
000000010000cec0	addb	$-0x30, %dil
000000010000cec4	cmpb	$0x9, %dil
000000010000cec8	ja	0x10000ced5
000000010000ceca	incq	%rdx
000000010000cecd	cmpq	%rdx, %rax
000000010000ced0	jne	0x10000ceb8
000000010000ced2	movq	%rax, %rdx
000000010000ced5	cmpq	%rsi, %rdx
000000010000ced8	je	0x10000b708
000000010000cede	cmpq	%rax, %rdx
000000010000cee1	jne	0x10000b708
000000010000cee7	cmpl	$0xa, (%rcx)
000000010000ceea	jne	0x10000cf06
000000010000ceec	leaq	-0x130(%rbp), %rdi
000000010000cef3	xorl	%esi, %esi
000000010000cef5	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000cefa	movd	%xmm0, %eax
000000010000cefe	movq	%rax, (%r15)
000000010000cf01	jmp	0x10000b702
000000010000cf06	leaq	-0x130(%rbp), %rdi
000000010000cf0d	xorl	%esi, %esi
000000010000cf0f	callq	0x1000112b8                     ## symbol stub for: _strtod
000000010000cf14	jmp	0x10000bbad
000000010000cf19	incq	%rax
000000010000cf1c	movq	%rax, 0x10(%rcx)
000000010000cf20	movq	-0x1f8(%rbp), %r12
000000010000cf27	jmp	0x10000c7f8
000000010000cf2c	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
000000010000cf31	nopl	(%rax)
000000010000cf34	popq	%rax
000000010000cf35	callq	0xe859cf39
000000010000cf3a	.byte 0xff #bad opcode
000000010000cf3b	lcalll	*-0x18(%rax)
000000010000cf3e	.byte 0xff #bad opcode
000000010000cf3f	lcalll	*-0x18(%rax)
000000010000cf42	.byte 0xff #bad opcode
000000010000cf43	lcalll	*-0x18(%rax)
000000010000cf46	.byte 0xff #bad opcode
000000010000cf47	lcalll	*-0x18(%rax)
000000010000cf4a	.byte 0xff #bad opcode
000000010000cf4b	lcalll	*-0x18(%rax)
000000010000cf4e	.byte 0xff #bad opcode
000000010000cf4f	lcalll	*-0x18(%rax)
000000010000cf52	.byte 0xff #bad opcode
000000010000cf53	lcalll	*-0x18(%rax)
000000010000cf56	.byte 0xff #bad opcode
000000010000cf57	lcalll	*-0x18(%rax)
000000010000cf5a	.byte 0xff #bad opcode
000000010000cf5b	.byte 0xff #bad opcode
000000010000cf5c	cmpl	%esp, %ebp
000000010000cf5e	.byte 0xff #bad opcode
000000010000cf5f	.byte 0xff #bad opcode
000000010000cf60	cmpl	%esp, %ebp
000000010000cf62	.byte 0xff #bad opcode
000000010000cf63	incl	-0x49000014(%rcx)
000000010000cf69	inb	%dx, %al
000000010000cf6a	.byte 0xff #bad opcode
000000010000cf6b	.byte 0xff #bad opcode
000000010000cf6c	jl	0x10000cf5d
000000010000cf6e	.byte 0xff #bad opcode
000000010000cf6f	decl	(%rcx)
000000010000cf71	jmp	0x10000cf72
000000010000cf73	lcalll	*(%rdx)
000000010000cf75	outb	%al, %dx
000000010000cf76	.byte 0xff #bad opcode
000000010000cf77	decl	(%rcx)
000000010000cf79	jmp	0x10000cf7a
000000010000cf7b	.byte 0xff #bad opcode
000000010000cf7c	fsubr	%st, %st(1)
000000010000cf7e	.byte 0xff #bad opcode
000000010000cf7f	.byte 0xff #bad opcode
000000010000cf80	fsubr	%st, %st(1)
000000010000cf82	.byte 0xff #bad opcode
000000010000cf83	incl	-0x13(%rcx)
000000010000cf86	.byte 0xff #bad opcode
000000010000cf87	ljmpl	*0xfffffed(%rcx)
000000010000cf8d	.byte 0x1f #bad opcode
000000010000cf8e	addb	%dl, 0x48(%rbp)
000000010000cf92	movl	%esp, %ebp
000000010000cf94	pushq	%r15
000000010000cf96	pushq	%r14
000000010000cf98	pushq	%r13
000000010000cf9a	pushq	%r12
000000010000cf9c	pushq	%rbx
000000010000cf9d	subq	$0xb8, %rsp
000000010000cfa4	movq	%rdx, %rbx
000000010000cfa7	movq	%rsi, %r15
000000010000cfaa	movq	0x607f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000cfb1	movq	(%rax), %rax
000000010000cfb4	movq	%rax, -0x30(%rbp)
000000010000cfb8	leaq	-0xb0(%rbp), %rsi
000000010000cfbf	movl	$0x80, %edx
000000010000cfc4	callq	_tp_token
000000010000cfc9	xorl	%r14d, %r14d
000000010000cfcc	cmpq	$0x7f, %rax
000000010000cfd0	ja	0x10000d00c
000000010000cfd2	leaq	-0xb0(%rbp), %r12
000000010000cfd9	movq	%r12, %rdi
000000010000cfdc	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000cfe1	movq	%r12, %rdi
000000010000cfe4	movq	%rax, %rsi
000000010000cfe7	callq	_fwp_str_new
000000010000cfec	movq	(%rax), %r11
000000010000cfef	testq	%r11, %r11
000000010000cff2	je	0x10000d00c
000000010000cff4	movq	%rax, %rcx
000000010000cff7	movzbl	0x8(%rax), %r8d
000000010000cffc	leal	-0x2b(%r8), %eax
000000010000d000	xorl	%edx, %edx
000000010000d002	testb	$-0x3, %al
000000010000d004	sete	%dl
000000010000d007	cmpq	%rdx, %r11
000000010000d00a	jne	0x10000d035
000000010000d00c	movq	0x601d(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000d013	movq	(%rax), %rax
000000010000d016	cmpq	-0x30(%rbp), %rax
000000010000d01a	jne	0x10000d3b9
000000010000d020	movl	%r14d, %eax
000000010000d023	addq	$0xb8, %rsp
000000010000d02a	popq	%rbx
000000010000d02b	popq	%r12
000000010000d02d	popq	%r13
000000010000d02f	popq	%r14
000000010000d031	popq	%r15
000000010000d033	popq	%rbp
000000010000d034	retq
000000010000d035	movl	(%r15), %r9d
000000010000d038	movl	0x48(%r15), %edi
000000010000d03c	jbe	0x10000d057
000000010000d03e	nop
000000010000d040	movzbl	0x8(%rcx,%rdx), %esi
000000010000d045	addb	$-0x3a, %sil
000000010000d049	cmpb	$-0xa, %sil
000000010000d04d	jb	0x10000d00c
000000010000d04f	incq	%rdx
000000010000d052	cmpq	%rdx, %r11
000000010000d055	jne	0x10000d040
000000010000d057	movl	%r9d, -0xb4(%rbp)
000000010000d05e	movq	%r8, -0xc0(%rbp)
000000010000d065	movq	%rdi, -0xd0(%rbp)
000000010000d06c	movq	%rbx, -0xc8(%rbp)
000000010000d073	xorl	%r15d, %r15d
000000010000d076	testb	$-0x3, %al
000000010000d078	sete	%r15b
000000010000d07c	xorl	%edi, %edi
000000010000d07e	movl	$0x0, %esi
000000010000d083	cmpq	%r15, %r11
000000010000d086	jbe	0x10000d141
000000010000d08c	xorl	%r14d, %r14d
000000010000d08f	movabsq	$-0x3333333333333333, %rbx      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000d099	xorl	%edi, %edi
000000010000d09b	xorl	%esi, %esi
000000010000d09d	nopl	(%rax)
000000010000d0a0	movq	%rsi, %r13
000000010000d0a3	movq	%rdi, %r12
000000010000d0a6	movq	%rdi, %rax
000000010000d0a9	movl	$0xa, %edx
000000010000d0ae	mulq	%rdx
000000010000d0b1	leaq	(%rsi,%rsi,4), %rsi
000000010000d0b5	leaq	(%rdx,%rsi,2), %rdx
000000010000d0b9	movsbl	0x8(%rcx,%r15), %esi
000000010000d0bf	addl	$-0x30, %esi
000000010000d0c2	movslq	%esi, %r8
000000010000d0c5	movq	%r8, %rsi
000000010000d0c8	sarq	$0x3f, %rsi
000000010000d0cc	movq	%rax, %rdi
000000010000d0cf	addq	%r8, %rdi
000000010000d0d2	adcq	%rdx, %rsi
000000010000d0d5	movq	%rsi, %r9
000000010000d0d8	shldq	$0x3f, %rdi, %r9
000000010000d0dd	movq	%rsi, %r8
000000010000d0e0	shrq	%r8
000000010000d0e3	movq	%r9, %r10
000000010000d0e6	addq	%r8, %r10
000000010000d0e9	adcq	$0x0, %r10
000000010000d0ed	movq	%r10, %rax
000000010000d0f0	mulq	%rbx
000000010000d0f3	shrq	$0x2, %rdx
000000010000d0f7	leaq	(%rdx,%rdx,4), %rax
000000010000d0fb	subq	%rax, %r10
000000010000d0fe	subq	%r10, %r9
000000010000d101	sbbq	$0x0, %r8
000000010000d105	movq	%r9, %r10
000000010000d108	movabsq	$-0x3333333333333334, %rax      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000d112	imulq	%rax, %r10
000000010000d116	movq	%r9, %rax
000000010000d119	mulq	%rbx
000000010000d11c	addq	%r10, %rdx
000000010000d11f	imulq	%rbx, %r8
000000010000d123	addq	%rdx, %r8
000000010000d126	xorq	%r13, %r8
000000010000d129	xorq	%r12, %rax
000000010000d12c	orq	%r8, %rax
000000010000d12f	jne	0x10000d00c
000000010000d135	incq	%r15
000000010000d138	cmpq	%r15, %r11
000000010000d13b	jne	0x10000d0a0
000000010000d141	movl	-0xb4(%rbp), %r11d
000000010000d148	cmpl	$0x9, %r11d
000000010000d14c	jne	0x10000d1b0
000000010000d14e	cmpb	$0x2d, -0xc0(%rbp)
000000010000d155	movq	-0xc8(%rbp), %rbx
000000010000d15c	jne	0x10000d16d
000000010000d15e	xorl	%r14d, %r14d
000000010000d161	movq	%rdi, %rax
000000010000d164	orq	%rsi, %rax
000000010000d167	jne	0x10000d00c
000000010000d16d	callq	_fwp_box_u128
000000010000d172	movq	%rax, %r15
000000010000d175	movq	%r15, -0xd8(%rbp)
000000010000d17c	movl	$0x10, %edi
000000010000d181	callq	_fwp_alloc_init
000000010000d186	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
000000010000d190	movq	%rcx, (%rax)
000000010000d193	movq	%r15, 0x8(%rax)
000000010000d197	leaq	-0xd8(%rbp), %rcx
000000010000d19e	movq	0x8(%rax), %rax
000000010000d1a2	movq	%rax, (%rbx)
000000010000d1a5	movl	$0x1, %r14d
000000010000d1ab	jmp	0x10000d00c
000000010000d1b0	movq	-0xc0(%rbp), %r10
000000010000d1b7	cmpb	$0x2d, %r10b
000000010000d1bb	sete	%cl
000000010000d1be	movabsq	$-0x8000000000000000, %rax      ## imm = 0x8000000000000000
000000010000d1c8	movq	%rsi, %rdx
000000010000d1cb	xorq	%rax, %rdx
000000010000d1ce	orq	%rdi, %rdx
000000010000d1d1	setne	%dl
000000010000d1d4	xorl	%r14d, %r14d
000000010000d1d7	movq	%rdi, %r8
000000010000d1da	negq	%r8
000000010000d1dd	movq	%rax, %r8
000000010000d1e0	sbbq	%rsi, %r8
000000010000d1e3	movq	-0xc8(%rbp), %rbx
000000010000d1ea	jb	0x10000d00c
000000010000d1f0	orb	%dl, %cl
000000010000d1f2	je	0x10000d00c
000000010000d1f8	xorl	%r14d, %r14d
000000010000d1fb	movq	%rdi, %r15
000000010000d1fe	negq	%r15
000000010000d201	movl	$0x0, %r9d
000000010000d207	sbbq	%rsi, %r9
000000010000d20a	cmpb	$0x2d, %r10b
000000010000d20e	cmovneq	%rdi, %r15
000000010000d212	cmovneq	%rsi, %r9
000000010000d216	cmpl	$0x14, %r11d
000000010000d21a	ja	0x10000d00c
000000010000d220	movl	%r11d, %ecx
000000010000d223	leaq	0x196(%rip), %rdx
000000010000d22a	movslq	(%rdx,%rcx,4), %rcx
000000010000d22e	addq	%rdx, %rcx
000000010000d231	jmpq	*%rcx
000000010000d233	movq	%r15, %rax
000000010000d236	addq	$-0x80, %rax
000000010000d23a	adcq	$-0x1, %r9
000000010000d23e	cmpq	$-0x100, %rax
000000010000d244	jmp	0x10000d27f
000000010000d246	movq	%r15, %rax
000000010000d249	addq	$-0x80000000, %rax              ## imm = 0x80000000
000000010000d24f	adcq	$-0x1, %r9
000000010000d253	movabsq	$-0x100000000, %rcx             ## imm = 0xFFFFFFFF00000000
000000010000d25d	cmpq	%rcx, %rax
000000010000d260	jmp	0x10000d27f
000000010000d262	xorl	%r14d, %r14d
000000010000d265	movl	$0xff, %eax
000000010000d26a	jmp	0x10000d296
000000010000d26c	movq	%r15, %rax
000000010000d26f	addq	$-0x8000, %rax                  ## imm = 0x8000
000000010000d275	adcq	$-0x1, %r9
000000010000d279	cmpq	$-0x10000, %rax                 ## imm = 0xFFFF0000
000000010000d27f	sbbq	$-0x1, %r9
000000010000d283	jb	0x10000d00c
000000010000d289	jmp	0x10000d175
000000010000d28e	xorl	%r14d, %r14d
000000010000d291	movl	$0xffff, %eax                   ## imm = 0xFFFF
000000010000d296	cmpq	%r15, %rax
000000010000d299	movl	$0x0, %eax
000000010000d29e	sbbq	%r9, %rax
000000010000d2a1	jb	0x10000d00c
000000010000d2a7	jmp	0x10000d175
000000010000d2ac	movq	%r15, %rax
000000010000d2af	shrq	$0x20, %rax
000000010000d2b3	orq	%r9, %rax
000000010000d2b6	jne	0x10000d00c
000000010000d2bc	jmp	0x10000d175
000000010000d2c1	movq	%r15, %rcx
000000010000d2c4	addq	%rax, %rcx
000000010000d2c7	adcq	$-0x1, %r9
000000010000d2cb	cmpq	$-0x1, %r9
000000010000d2cf	jne	0x10000d00c
000000010000d2d5	jmp	0x10000d175
000000010000d2da	movq	%r15, %rdi
000000010000d2dd	movq	%r9, %rsi
000000010000d2e0	callq	_fwp_box_u128
000000010000d2e5	jmp	0x10000d172
000000010000d2ea	xorl	%r14d, %r14d
000000010000d2ed	movq	-0xd0(%rbp), %rcx
000000010000d2f4	testl	%ecx, %ecx
000000010000d2f6	jle	0x10000d32d
000000010000d2f8	leal	-0x1(%rcx), %eax
000000010000d2fb	cmpl	$0x4f, %eax
000000010000d2fe	movl	$0x4f, %r8d
000000010000d304	cmovbl	%eax, %r8d
000000010000d308	incl	%r8d
000000010000d30b	movl	%r8d, %edi
000000010000d30e	andl	$0x7, %edi
000000010000d311	cmpl	$0x8, %ecx
000000010000d314	jae	0x10000d333
000000010000d316	movl	$0x1, %eax
000000010000d31b	xorl	%ecx, %ecx
000000010000d31d	jmp	0x10000d359
000000010000d31f	testq	%r9, %r9
000000010000d322	jne	0x10000d00c
000000010000d328	jmp	0x10000d175
000000010000d32d	xorl	%edx, %edx
000000010000d32f	xorl	%ecx, %ecx
000000010000d331	jmp	0x10000d38e
000000010000d333	andl	$0xf8, %r8d
000000010000d33a	movl	$0x1, %eax
000000010000d33f	xorl	%ecx, %ecx
000000010000d341	movl	$0x19a1, %esi                   ## imm = 0x19A1
000000010000d346	mulq	%rsi
000000010000d349	imulq	$0x19a1, %rcx, %rcx             ## imm = 0x19A1
000000010000d350	addq	%rdx, %rcx
000000010000d353	addl	$-0x8, %r8d
000000010000d357	jne	0x10000d346
000000010000d359	testl	%edi, %edi
000000010000d35b	je	0x10000d370
000000010000d35d	movl	$0x3, %esi
000000010000d362	mulq	%rsi
000000010000d365	leaq	(%rcx,%rcx,2), %rcx
000000010000d369	addq	%rdx, %rcx
000000010000d36c	decl	%edi
000000010000d36e	jne	0x10000d362
000000010000d370	addq	$-0x1, %rax
000000010000d374	adcq	$-0x1, %rcx
000000010000d378	movq	%rcx, %rdx
000000010000d37b	shrq	$0x3f, %rdx
000000010000d37f	addq	%rax, %rdx
000000010000d382	adcq	$0x0, %rcx
000000010000d386	shrdq	$0x1, %rcx, %rdx
000000010000d38b	sarq	%rcx
000000010000d38e	movq	%rdx, %rax
000000010000d391	negq	%rax
000000010000d394	movl	$0x0, %esi
000000010000d399	sbbq	%rcx, %rsi
000000010000d39c	cmpq	%r15, %rdx
000000010000d39f	sbbq	%r9, %rcx
000000010000d3a2	jl	0x10000d00c
000000010000d3a8	cmpq	%rax, %r15
000000010000d3ab	sbbq	%rsi, %r9
000000010000d3ae	jge	0x10000d175
000000010000d3b4	jmp	0x10000d00c
000000010000d3b9	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
000000010000d3be	nop
000000010000d3c0	jae	0x10000d3c0
000000010000d3c2	.byte 0xff #bad opcode
000000010000d3c3	ljmpl	*-0x1790001(%rsi,%rdi,8)
000000010000d3ca	.byte 0xff #bad opcode
000000010000d3cb	incl	(%rcx)
000000010000d3cd	.byte 0xff #bad opcode
000000010000d3ce	.byte 0xff #bad opcode
000000010000d3cf	lcalll	*(%rdx)
000000010000d3d1	.byte 0xff #bad opcode
000000010000d3d2	.byte 0xff #bad opcode
000000010000d3d3	jmpq	*-0x31000002(%rdx)
000000010000d3d9	.byte 0xfe #bad opcode
000000010000d3da	.byte 0xff #bad opcode
000000010000d3db	.byte 0xff #bad opcode
000000010000d3dc	inb	%dx, %al
000000010000d3dd	.byte 0xfe #bad opcode
000000010000d3de	.byte 0xff #bad opcode
000000010000d3df	lcalll	*-0x1(%rdi)
000000010000d3e2	.byte 0xff #bad opcode
000000010000d3e3	decl	-0x1(%rsp,%rdi,8)
000000010000d3e7	decl	-0x1(%rsp,%rdi,8)
000000010000d3eb	decl	-0x1(%rsp,%rdi,8)
000000010000d3ef	decl	-0x1(%rsp,%rdi,8)
000000010000d3f3	decl	-0x1(%rsp,%rdi,8)
000000010000d3f7	decl	-0x1(%rsp,%rdi,8)
000000010000d3fb	decl	-0x1(%rsp,%rdi,8)
000000010000d3ff	decl	-0x1(%rsp,%rdi,8)
000000010000d403	decl	-0x1(%rsp,%rdi,8)
000000010000d407	decl	-0x1(%rsp,%rdi,8)
000000010000d40b	decl	-0x1(%rsp,%rdi,8)
000000010000d40f	ljmpl	*(%rdx)
000000010000d411	.byte 0xff #bad opcode
000000010000d412	.byte 0xff #bad opcode
000000010000d413	jmpq	*0x66(%rsi)
000000010000d416	nopw	%cs:(%rax,%rax)
_tp_quoted:
000000010000d420	pushq	%rbp
000000010000d421	movq	%rsp, %rbp
000000010000d424	pushq	%r15
000000010000d426	pushq	%r14
000000010000d428	pushq	%r13
000000010000d42a	pushq	%r12
000000010000d42c	pushq	%rbx
000000010000d42d	subq	$0x28, %rsp
000000010000d431	movq	%rsi, %rbx
000000010000d434	movq	%rdi, %r15
000000010000d437	movq	0x8(%rdi), %rcx
000000010000d43b	movq	0x10(%rdi), %rax
000000010000d43f	cmpq	%rcx, %rax
000000010000d442	jae	0x10000d484
000000010000d444	movq	(%r15), %rdx
000000010000d447	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000d451	nopw	%cs:(%rax,%rax)
000000010000d460	movzbl	(%rdx,%rax), %edi
000000010000d464	cmpq	$0x20, %rdi
000000010000d468	ja	0x10000d484
000000010000d46a	btq	%rdi, %rsi
000000010000d46e	jae	0x10000d484
000000010000d470	incq	%rax
000000010000d473	movq	%rax, 0x10(%r15)
000000010000d477	cmpq	%rax, %rcx
000000010000d47a	jne	0x10000d460
000000010000d47c	xorl	%r14d, %r14d
000000010000d47f	jmp	0x10000d666
000000010000d484	xorl	%r14d, %r14d
000000010000d487	cmpq	%rcx, %rax
000000010000d48a	jae	0x10000d666
000000010000d490	movq	(%r15), %rdx
000000010000d493	cmpb	$0x22, (%rdx,%rax)
000000010000d497	jne	0x10000d666
000000010000d49d	incq	%rax
000000010000d4a0	movq	%rax, 0x10(%r15)
000000010000d4a4	xorps	%xmm0, %xmm0
000000010000d4a7	movaps	%xmm0, -0x50(%rbp)
000000010000d4ab	movq	$0x0, -0x40(%rbp)
000000010000d4b3	xorl	%r14d, %r14d
000000010000d4b6	cmpq	%rcx, %rax
000000010000d4b9	jae	0x10000d654
000000010000d4bf	leaq	-0x50(%rbp), %r12
000000010000d4c3	movq	0x5b36(%rip), %r13              ## literal pool symbol address: __DefaultRuneLocale
000000010000d4ca	nopw	(%rax,%rax)
000000010000d4d0	movq	(%r15), %rdx
000000010000d4d3	leaq	0x1(%rax), %rdi
000000010000d4d7	movq	%rdi, 0x10(%r15)
000000010000d4db	movzbl	(%rdx,%rax), %esi
000000010000d4df	cmpl	$0x5c, %esi
000000010000d4e2	je	0x10000d520
000000010000d4e4	cmpl	$0x22, %esi
000000010000d4e7	je	0x10000d678
000000010000d4ed	movb	%sil, -0x29(%rbp)
000000010000d4f1	movl	$0x1, %edx
000000010000d4f6	movq	%r12, %rdi
000000010000d4f9	leaq	-0x29(%rbp), %rsi
000000010000d4fd	callq	_buf_put
000000010000d502	movq	0x8(%r15), %rcx
000000010000d506	movq	0x10(%r15), %rax
000000010000d50a	cmpq	%rcx, %rax
000000010000d50d	jb	0x10000d4d0
000000010000d50f	jmp	0x10000d65d
000000010000d514	nopw	%cs:(%rax,%rax)
000000010000d520	cmpq	%rcx, %rdi
000000010000d523	jae	0x10000d65d
000000010000d529	leaq	0x2(%rax), %rsi
000000010000d52d	movq	%rsi, 0x10(%r15)
000000010000d531	movzbl	0x1(%rdx,%rax), %edi
000000010000d536	leal	-0x5c(%rdi), %r8d
000000010000d53a	cmpl	$0x19, %r8d
000000010000d53e	ja	0x10000d556
000000010000d540	leaq	0x2b9(%rip), %r9
000000010000d547	movslq	(%r9,%r8,4), %rdi
000000010000d54b	addq	%r9, %rdi
000000010000d54e	jmpq	*%rdi
000000010000d550	movb	$0x5c, -0x29(%rbp)
000000010000d554	jmp	0x10000d4f1
000000010000d556	cmpl	$0x22, %edi
000000010000d559	je	0x10000d611
000000010000d55f	cmpl	$0x30, %edi
000000010000d562	jne	0x10000d65d
000000010000d568	movb	$0x0, -0x29(%rbp)
000000010000d56c	jmp	0x10000d4f1
000000010000d56e	movb	$0x9, -0x29(%rbp)
000000010000d572	jmp	0x10000d4f1
000000010000d577	movb	$0xd, -0x29(%rbp)
000000010000d57b	jmp	0x10000d4f1
000000010000d580	movb	$0xa, -0x29(%rbp)
000000010000d584	jmp	0x10000d4f1
000000010000d589	cmpq	%rcx, %rsi
000000010000d58c	jae	0x10000d65d
000000010000d592	cmpb	$0x7b, (%rdx,%rsi)
000000010000d596	jne	0x10000d65d
000000010000d59c	leaq	0x3(%rax), %rsi
000000010000d5a0	movq	%rsi, 0x10(%r15)
000000010000d5a4	cmpq	%rcx, %rsi
000000010000d5a7	jae	0x10000d65d
000000010000d5ad	leaq	0x4(%rax), %rdi
000000010000d5b1	leaq	(%rdx,%rax), %r8
000000010000d5b5	addq	$0x3, %r8
000000010000d5b9	subq	%rax, %rcx
000000010000d5bc	addq	$-0x3, %rcx
000000010000d5c0	xorl	%edx, %edx
000000010000d5c2	xorl	%esi, %esi
000000010000d5c4	nopw	%cs:(%rax,%rax)
000000010000d5d0	movzbl	(%r8,%rdx), %r9d
000000010000d5d5	testb	$0x1, 0x3e(%r13,%r9,4)
000000010000d5db	je	0x10000d61a
000000010000d5dd	leaq	(%rdi,%rdx), %r9
000000010000d5e1	movq	%r9, 0x10(%r15)
000000010000d5e5	movsbl	(%r8,%rdx), %r9d
000000010000d5ea	shll	$0x4, %esi
000000010000d5ed	leal	-0x30(%r9), %r10d
000000010000d5f1	movl	%r9d, %r11d
000000010000d5f4	orl	$0x20, %r11d
000000010000d5f8	addl	$-0x57, %r11d
000000010000d5fc	cmpl	$0x3a, %r9d
000000010000d600	cmovll	%r10d, %r11d
000000010000d604	addl	%r11d, %esi
000000010000d607	incq	%rdx
000000010000d60a	cmpq	%rdx, %rcx
000000010000d60d	jne	0x10000d5d0
000000010000d60f	jmp	0x10000d65d
000000010000d611	movb	$0x22, -0x29(%rbp)
000000010000d615	jmp	0x10000d4f1
000000010000d61a	testl	%edx, %edx
000000010000d61c	je	0x10000d65d
000000010000d61e	cmpb	$0x7d, %r9b
000000010000d622	jne	0x10000d65d
000000010000d624	cmpl	$0x10ffff, %esi                 ## imm = 0x10FFFF
000000010000d62a	ja	0x10000d65d
000000010000d62c	movl	%esi, %ecx
000000010000d62e	andl	$0x1ff800, %ecx                 ## imm = 0x1FF800
000000010000d634	cmpl	$0xd800, %ecx                   ## imm = 0xD800
000000010000d63a	je	0x10000d65d
000000010000d63c	addq	%rdx, %rax
000000010000d63f	addq	$0x4, %rax
000000010000d643	movq	%rax, 0x10(%r15)
000000010000d647	movq	%r12, %rdi
000000010000d64a	callq	_fwp_utf8_put
000000010000d64f	jmp	0x10000d502
000000010000d654	xorl	%edi, %edi
000000010000d656	callq	0x1000111f2                     ## symbol stub for: _free
000000010000d65b	jmp	0x10000d666
000000010000d65d	movq	-0x50(%rbp), %rdi
000000010000d661	callq	0x1000111f2                     ## symbol stub for: _free
000000010000d666	movl	%r14d, %eax
000000010000d669	addq	$0x28, %rsp
000000010000d66d	popq	%rbx
000000010000d66e	popq	%r12
000000010000d670	popq	%r13
000000010000d672	popq	%r14
000000010000d674	popq	%r15
000000010000d676	popq	%rbp
000000010000d677	retq
000000010000d678	movq	-0x50(%rbp), %r14
000000010000d67c	movq	-0x48(%rbp), %rsi
000000010000d680	testq	%r14, %r14
000000010000d683	leaq	0x4228(%rip), %rdi              ## literal pool for: ""
000000010000d68a	cmovneq	%r14, %rdi
000000010000d68e	testq	%rsi, %rsi
000000010000d691	je	0x10000d7d3
000000010000d697	xorl	%eax, %eax
000000010000d699	jmp	0x10000d6a7
000000010000d69b	incq	%rax
000000010000d69e	cmpq	%rsi, %rax
000000010000d6a1	jae	0x10000d7d3
000000010000d6a7	movzbl	(%rdi,%rax), %r9d
000000010000d6ac	testb	%r9b, %r9b
000000010000d6af	jns	0x10000d69b
000000010000d6b1	leal	0x3e(%r9), %ecx
000000010000d6b5	cmpb	$0x1e, %cl
000000010000d6b8	jae	0x10000d6cc
000000010000d6ba	movl	$0x80, %ecx
000000010000d6bf	movl	$0x1, %r8d
000000010000d6c5	movl	$0x1f, %edx
000000010000d6ca	jmp	0x10000d706
000000010000d6cc	movl	%r9d, %ecx
000000010000d6cf	andb	$-0x10, %cl
000000010000d6d2	cmpb	$-0x20, %cl
000000010000d6d5	jne	0x10000d6e9
000000010000d6d7	movl	$0x800, %ecx                    ## imm = 0x800
000000010000d6dc	movl	$0x2, %r8d
000000010000d6e2	movl	$0xf, %edx
000000010000d6e7	jmp	0x10000d706
000000010000d6e9	leal	0x10(%r9), %ecx
000000010000d6ed	cmpb	$0x4, %cl
000000010000d6f0	ja	0x10000d7f1
000000010000d6f6	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000d6fb	movl	$0x3, %r8d
000000010000d701	movl	$0x7, %edx
000000010000d706	movl	%r8d, %r8d
000000010000d709	leaq	(%rax,%r8), %r10
000000010000d70d	cmpq	%rsi, %r10
000000010000d710	jae	0x10000d7f1
000000010000d716	movzbl	0x1(%rdi,%rax), %r10d
000000010000d71c	movl	%r10d, %r11d
000000010000d71f	andl	$-0x40, %r11d
000000010000d723	cmpl	$0x80, %r11d
000000010000d72a	jne	0x10000d7f1
000000010000d730	andl	%r9d, %edx
000000010000d733	leal	0x1(%r8), %r11d
000000010000d737	movl	%edx, %r9d
000000010000d73a	shll	$0x6, %r9d
000000010000d73e	andl	$0x3f, %r10d
000000010000d742	orl	%r9d, %r10d
000000010000d745	cmpl	$0x2, %r11d
000000010000d749	jne	0x10000d750
000000010000d74b	movl	%r10d, %r11d
000000010000d74e	jmp	0x10000d7a8
000000010000d750	movzbl	0x2(%rdi,%rax), %edx
000000010000d755	movl	%edx, %r9d
000000010000d758	andl	$-0x40, %r9d
000000010000d75c	cmpl	$0x80, %r9d
000000010000d763	jne	0x10000d7f1
000000010000d769	movl	%r10d, %r9d
000000010000d76c	shll	$0x6, %r9d
000000010000d770	andl	$0x3f, %edx
000000010000d773	orl	%r9d, %edx
000000010000d776	cmpl	$0x3, %r11d
000000010000d77a	jne	0x10000d784
000000010000d77c	movl	%edx, %r11d
000000010000d77f	movl	%r10d, %edx
000000010000d782	jmp	0x10000d7a8
000000010000d784	movzbl	0x3(%rdi,%rax), %r11d
000000010000d78a	movl	%r11d, %r9d
000000010000d78d	andl	$-0x40, %r9d
000000010000d791	cmpl	$0x80, %r9d
000000010000d798	jne	0x10000d7f1
000000010000d79a	movl	%edx, %r9d
000000010000d79d	shll	$0x6, %r9d
000000010000d7a1	andl	$0x3f, %r11d
000000010000d7a5	orl	%r9d, %r11d
000000010000d7a8	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000d7ae	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000d7b4	je	0x10000d7f1
000000010000d7b6	cmpl	$0x10ffff, %r9d                 ## imm = 0x10FFFF
000000010000d7bd	ja	0x10000d7f1
000000010000d7bf	cmpl	%ecx, %r11d
000000010000d7c2	jb	0x10000d7f1
000000010000d7c4	addq	%r8, %rax
000000010000d7c7	incq	%rax
000000010000d7ca	cmpq	%rsi, %rax
000000010000d7cd	jb	0x10000d6a7
000000010000d7d3	callq	_fwp_str_new
000000010000d7d8	movq	%rax, %r15
000000010000d7db	movq	%r14, %rdi
000000010000d7de	callq	0x1000111f2                     ## symbol stub for: _free
000000010000d7e3	movq	%r15, (%rbx)
000000010000d7e6	movl	$0x1, %r14d
000000010000d7ec	jmp	0x10000d666
000000010000d7f1	movq	%r14, %rdi
000000010000d7f4	callq	0x1000111f2                     ## symbol stub for: _free
000000010000d7f9	jmp	0x10000d47c
000000010000d7fe	nop
000000010000d800	pushq	%rax
000000010000d801	std
000000010000d802	.byte 0xff #bad opcode
000000010000d803	lcalll	*-0x2(%rbp)
000000010000d806	.byte 0xff #bad opcode
000000010000d807	lcalll	*-0x2(%rbp)
000000010000d80a	.byte 0xff #bad opcode
000000010000d80b	lcalll	*-0x2(%rbp)
000000010000d80e	.byte 0xff #bad opcode
000000010000d80f	lcalll	*-0x2(%rbp)
000000010000d812	.byte 0xff #bad opcode
000000010000d813	lcalll	*-0x2(%rbp)
000000010000d816	.byte 0xff #bad opcode
000000010000d817	lcalll	*-0x2(%rbp)
000000010000d81a	.byte 0xff #bad opcode
000000010000d81b	lcalll	*-0x2(%rbp)
000000010000d81e	.byte 0xff #bad opcode
000000010000d81f	lcalll	*-0x2(%rbp)
000000010000d822	.byte 0xff #bad opcode
000000010000d823	lcalll	*-0x2(%rbp)
000000010000d826	.byte 0xff #bad opcode
000000010000d827	lcalll	*-0x2(%rbp)
000000010000d82a	.byte 0xff #bad opcode
000000010000d82b	lcalll	*-0x2(%rbp)
000000010000d82e	.byte 0xff #bad opcode
000000010000d82f	lcalll	*-0x2(%rbp)
000000010000d832	.byte 0xff #bad opcode
000000010000d833	lcalll	*-0x2(%rbp)
000000010000d836	.byte 0xff #bad opcode
000000010000d837	lcalll	*-0x2(%rbp)
000000010000d83a	.byte 0xff #bad opcode
000000010000d83b	lcalll	*-0x2(%rbp)
000000010000d83e	.byte 0xff #bad opcode
000000010000d83f	lcalll	*-0x2(%rbp)
000000010000d842	.byte 0xff #bad opcode
000000010000d843	lcalll	*-0x2(%rbp)
000000010000d846	.byte 0xff #bad opcode
000000010000d847	incl	0x5dfffffd(%rax)
000000010000d84d	.byte 0xfe #bad opcode
000000010000d84e	.byte 0xff #bad opcode
000000010000d84f	lcalll	*-0x2(%rbp)
000000010000d852	.byte 0xff #bad opcode
000000010000d853	lcalll	*-0x2(%rbp)
000000010000d856	.byte 0xff #bad opcode
000000010000d857	pushq	-0x3(%rdi)
000000010000d85a	.byte 0xff #bad opcode
000000010000d85b	lcalll	*-0x2(%rbp)
000000010000d85e	.byte 0xff #bad opcode
000000010000d85f	ljmpl	*-0x3(%rsi)
000000010000d862	.byte 0xff #bad opcode
000000010000d863	decl	0xffffffd(%rcx)
000000010000d869	.byte 0x1f #bad opcode
000000010000d86a	testb	%al, (%rax)
000000010000d86c	addb	%al, (%rax)
000000010000d86e	addb	%al, (%rax)
_tp_eat:
000000010000d870	pushq	%rbp
000000010000d871	movq	%rsp, %rbp
000000010000d874	pushq	%r15
000000010000d876	pushq	%r14
000000010000d878	pushq	%r13
000000010000d87a	pushq	%r12
000000010000d87c	pushq	%rbx
000000010000d87d	pushq	%rax
000000010000d87e	movq	%rsi, %r14
000000010000d881	movq	%rdi, %rbx
000000010000d884	movq	0x8(%rdi), %r13
000000010000d888	movq	0x10(%rdi), %r12
000000010000d88c	cmpq	%r13, %r12
000000010000d88f	jae	0x10000d8c0
000000010000d891	movq	(%rbx), %rax
000000010000d894	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000d89e	nop
000000010000d8a0	movzbl	(%rax,%r12), %edx
000000010000d8a5	cmpq	$0x20, %rdx
000000010000d8a9	ja	0x10000d8c0
000000010000d8ab	btq	%rdx, %rcx
000000010000d8af	jae	0x10000d8c0
000000010000d8b1	incq	%r12
000000010000d8b4	movq	%r12, 0x10(%rbx)
000000010000d8b8	cmpq	%r12, %r13
000000010000d8bb	jne	0x10000d8a0
000000010000d8bd	movq	%r13, %r12
000000010000d8c0	movq	%r14, %rdi
000000010000d8c3	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000d8c8	subq	%r12, %r13
000000010000d8cb	xorl	%r15d, %r15d
000000010000d8ce	cmpq	%rax, %r13
000000010000d8d1	jb	0x10000d8f8
000000010000d8d3	movq	(%rbx), %rdi
000000010000d8d6	addq	%r12, %rdi
000000010000d8d9	movq	%r14, %rsi
000000010000d8dc	movq	%rax, %r14
000000010000d8df	movq	%rax, %rdx
000000010000d8e2	callq	0x100011222                     ## symbol stub for: _memcmp
000000010000d8e7	testl	%eax, %eax
000000010000d8e9	jne	0x10000d8f8
000000010000d8eb	addq	%r14, %r12
000000010000d8ee	movq	%r12, 0x10(%rbx)
000000010000d8f2	movl	$0x1, %r15d
000000010000d8f8	movl	%r15d, %eax
000000010000d8fb	addq	$0x8, %rsp
000000010000d8ff	popq	%rbx
000000010000d900	popq	%r12
000000010000d902	popq	%r13
000000010000d904	popq	%r14
000000010000d906	popq	%r15
000000010000d908	popq	%rbp
000000010000d909	retq
000000010000d90a	nopw	(%rax,%rax)
_tp_list_of:
000000010000d910	pushq	%rbp
000000010000d911	movq	%rsp, %rbp
000000010000d914	pushq	%r15
000000010000d916	pushq	%r14
000000010000d918	pushq	%r13
000000010000d91a	pushq	%r12
000000010000d91c	pushq	%rbx
000000010000d91d	subq	$0x28, %rsp
000000010000d921	movq	%r8, %r15
000000010000d924	movq	%rcx, -0x40(%rbp)
000000010000d928	movq	%rsi, %r8
000000010000d92b	movq	%rdi, %rbx
000000010000d92e	movq	0x8(%rdi), %r12
000000010000d932	movq	0x10(%rdi), %r13
000000010000d936	cmpq	%r12, %r13
000000010000d939	movq	%rdx, -0x30(%rbp)
000000010000d93d	jae	0x10000d970
000000010000d93f	movq	(%rbx), %rax
000000010000d942	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000d94c	nopl	(%rax)
000000010000d950	movzbl	(%rax,%r13), %esi
000000010000d955	cmpq	$0x20, %rsi
000000010000d959	ja	0x10000d970
000000010000d95b	btq	%rsi, %rcx
000000010000d95f	jae	0x10000d970
000000010000d961	incq	%r13
000000010000d964	movq	%r13, 0x10(%rbx)
000000010000d968	cmpq	%r13, %r12
000000010000d96b	jne	0x10000d950
000000010000d96d	movq	%r12, %r13
000000010000d970	movq	%r8, %rdi
000000010000d973	movq	%r8, -0x48(%rbp)
000000010000d977	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000d97c	movq	%rax, %r14
000000010000d97f	movq	%r12, %rcx
000000010000d982	subq	%r13, %rcx
000000010000d985	xorl	%eax, %eax
000000010000d987	cmpq	%r14, %rcx
000000010000d98a	jb	0x10000d9a9
000000010000d98c	movq	%r15, -0x38(%rbp)
000000010000d990	movq	(%rbx), %r15
000000010000d993	leaq	(%r15,%r13), %rdi
000000010000d997	movq	-0x48(%rbp), %rsi
000000010000d99b	movq	%r14, %rdx
000000010000d99e	callq	0x100011222                     ## symbol stub for: _memcmp
000000010000d9a3	testl	%eax, %eax
000000010000d9a5	je	0x10000d9b8
000000010000d9a7	xorl	%eax, %eax
000000010000d9a9	addq	$0x28, %rsp
000000010000d9ad	popq	%rbx
000000010000d9ae	popq	%r12
000000010000d9b0	popq	%r13
000000010000d9b2	popq	%r14
000000010000d9b4	popq	%r15
000000010000d9b6	popq	%rbp
000000010000d9b7	retq
000000010000d9b8	addq	%r13, %r14
000000010000d9bb	movq	%r14, 0x10(%rbx)
000000010000d9bf	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000d9c9	cmpq	%r12, %r14
000000010000d9cc	jae	0x10000da02
000000010000d9ce	movq	-0x30(%rbp), %rdi
000000010000d9d2	nopw	%cs:(%rax,%rax)
000000010000d9e0	movzbl	(%r15,%r14), %eax
000000010000d9e5	cmpq	$0x20, %rax
000000010000d9e9	ja	0x10000da06
000000010000d9eb	btq	%rax, %r13
000000010000d9ef	jae	0x10000da06
000000010000d9f1	incq	%r14
000000010000d9f4	movq	%r14, 0x10(%rbx)
000000010000d9f8	cmpq	%r14, %r12
000000010000d9fb	jne	0x10000d9e0
000000010000d9fd	movq	%r12, %r14
000000010000da00	jmp	0x10000da06
000000010000da02	movq	-0x30(%rbp), %rdi
000000010000da06	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000da0b	subq	%r14, %r12
000000010000da0e	cmpq	%rax, %r12
000000010000da11	jb	0x10000da30
000000010000da13	addq	%r14, %r15
000000010000da16	movq	%r15, %rdi
000000010000da19	movq	-0x30(%rbp), %rsi
000000010000da1d	movq	%rax, %r12
000000010000da20	movq	%rax, %rdx
000000010000da23	callq	0x100011222                     ## symbol stub for: _memcmp
000000010000da28	testl	%eax, %eax
000000010000da2a	je	0x10000db0a
000000010000da30	movq	%rbx, %rdi
000000010000da33	movq	-0x38(%rbp), %rsi
000000010000da37	callq	*-0x40(%rbp)
000000010000da3a	testl	%eax, %eax
000000010000da3c	je	0x10000d9a7
000000010000da42	movq	0x8(%rbx), %r15
000000010000da46	movq	0x10(%rbx), %r14
000000010000da4a	cmpq	%r15, %r14
000000010000da4d	jae	0x10000da82
000000010000da4f	movq	(%rbx), %rax
000000010000da52	movq	-0x30(%rbp), %r12
000000010000da56	nopw	%cs:(%rax,%rax)
000000010000da60	movzbl	(%rax,%r14), %ecx
000000010000da65	cmpq	$0x20, %rcx
000000010000da69	ja	0x10000da86
000000010000da6b	btq	%rcx, %r13
000000010000da6f	jae	0x10000da86
000000010000da71	incq	%r14
000000010000da74	movq	%r14, 0x10(%rbx)
000000010000da78	cmpq	%r14, %r15
000000010000da7b	jne	0x10000da60
000000010000da7d	movq	%r15, %r14
000000010000da80	jmp	0x10000da86
000000010000da82	movq	-0x30(%rbp), %r12
000000010000da86	movq	%r12, %rdi
000000010000da89	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000da8e	movq	%r15, %rcx
000000010000da91	subq	%r14, %rcx
000000010000da94	cmpq	%rax, %rcx
000000010000da97	jb	0x10000dab1
000000010000da99	movq	(%rbx), %rdi
000000010000da9c	addq	%r14, %rdi
000000010000da9f	movq	%r12, %rsi
000000010000daa2	movq	%rax, %r12
000000010000daa5	movq	%rax, %rdx
000000010000daa8	callq	0x100011222                     ## symbol stub for: _memcmp
000000010000daad	testl	%eax, %eax
000000010000daaf	je	0x10000db0a
000000010000dab1	cmpq	%r14, %r15
000000010000dab4	jbe	0x10000dae2
000000010000dab6	movq	(%rbx), %rax
000000010000dab9	nopl	(%rax)
000000010000dac0	movzbl	(%rax,%r14), %ecx
000000010000dac5	cmpq	$0x20, %rcx
000000010000dac9	ja	0x10000dae2
000000010000dacb	btq	%rcx, %r13
000000010000dacf	jae	0x10000dae2
000000010000dad1	incq	%r14
000000010000dad4	movq	%r14, 0x10(%rbx)
000000010000dad8	cmpq	%r14, %r15
000000010000dadb	jne	0x10000dac0
000000010000dadd	jmp	0x10000d9a7
000000010000dae2	cmpq	%r14, %r15
000000010000dae5	movl	$0x0, %eax
000000010000daea	je	0x10000d9a9
000000010000daf0	movq	(%rbx), %rcx
000000010000daf3	cmpb	$0x2c, (%rcx,%r14)
000000010000daf8	jne	0x10000d9a9
000000010000dafe	incq	%r14
000000010000db01	movq	%r14, 0x10(%rbx)
000000010000db05	jmp	0x10000da30
000000010000db0a	addq	%r14, %r12
000000010000db0d	movq	%r12, 0x10(%rbx)
000000010000db11	movl	$0x1, %eax
000000010000db16	jmp	0x10000d9a9
000000010000db1b	nopl	(%rax,%rax)
_tp_byte_item:
000000010000db20	pushq	%rbp
000000010000db21	movq	%rsp, %rbp
000000010000db24	pushq	%rbx
000000010000db25	pushq	%rax
000000010000db26	movq	%rsi, %rbx
000000010000db29	leaq	_tp_byte_item.u8d(%rip), %rsi
000000010000db30	leaq	-0x10(%rbp), %rdx
000000010000db34	callq	_tp_int
000000010000db39	testl	%eax, %eax
000000010000db3b	je	0x10000db50
000000010000db3d	movq	-0x10(%rbp), %rsi
000000010000db41	movq	%rbx, %rdi
000000010000db44	callq	_tp_push
000000010000db49	movl	$0x1, %eax
000000010000db4e	jmp	0x10000db52
000000010000db50	xorl	%eax, %eax
000000010000db52	addq	$0x8, %rsp
000000010000db56	popq	%rbx
000000010000db57	popq	%rbp
000000010000db58	retq
000000010000db59	nopl	(%rax)
_tp_token:
000000010000db60	pushq	%rbp
000000010000db61	movq	%rsp, %rbp
000000010000db64	pushq	%r15
000000010000db66	pushq	%r14
000000010000db68	pushq	%r12
000000010000db6a	pushq	%rbx
000000010000db6b	movq	%rsi, %r14
000000010000db6e	movq	%rdi, %rbx
000000010000db71	movq	(%rdi), %rsi
000000010000db74	movq	0x8(%rdi), %rax
000000010000db78	movq	0x10(%rdi), %r12
000000010000db7c	cmpq	%rax, %r12
000000010000db7f	jae	0x10000dbb5
000000010000db81	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000db8b	nopl	(%rax,%rax)
000000010000db90	movzbl	(%rsi,%r12), %edi
000000010000db95	cmpq	$0x20, %rdi
000000010000db99	ja	0x10000dbb5
000000010000db9b	btq	%rdi, %rcx
000000010000db9f	jae	0x10000dbb5
000000010000dba1	incq	%r12
000000010000dba4	movq	%r12, 0x10(%rbx)
000000010000dba8	cmpq	%r12, %rax
000000010000dbab	jne	0x10000db90
000000010000dbad	movq	%rax, %r12
000000010000dbb0	movq	%rax, %rcx
000000010000dbb3	jmp	0x10000dbfe
000000010000dbb5	cmpq	%rax, %r12
000000010000dbb8	jae	0x10000dbfb
000000010000dbba	leaq	0x6f(%rip), %rdi
000000010000dbc1	movq	%r12, %rcx
000000010000dbc4	jmp	0x10000dbe2
000000010000dbc6	nopw	%cs:(%rax,%rax)
000000010000dbd0	cmpl	$0x7d, %r8d
000000010000dbd4	je	0x10000dbfe
000000010000dbd6	incq	%rcx
000000010000dbd9	movq	%rcx, 0x10(%rbx)
000000010000dbdd	cmpq	%rcx, %rax
000000010000dbe0	je	0x10000dbb0
000000010000dbe2	movzbl	(%rsi,%rcx), %r8d
000000010000dbe7	leal	-0x9(%r8), %r9d
000000010000dbeb	cmpl	$0x54, %r9d
000000010000dbef	ja	0x10000dbd0
000000010000dbf1	movslq	(%rdi,%r9,4), %r8
000000010000dbf5	addq	%rdi, %r8
000000010000dbf8	jmpq	*%r8
000000010000dbfb	movq	%r12, %rcx
000000010000dbfe	subq	%r12, %rcx
000000010000dc01	leaq	-0x1(%rdx), %r15
000000010000dc05	cmpq	%rdx, %rcx
000000010000dc08	cmovbq	%rcx, %r15
000000010000dc0c	addq	%r12, %rsi
000000010000dc0f	movq	%r14, %rdi
000000010000dc12	movq	%r15, %rdx
000000010000dc15	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000dc1a	movb	$0x0, (%r14,%r15)
000000010000dc1f	movq	0x10(%rbx), %rax
000000010000dc23	subq	%r12, %rax
000000010000dc26	popq	%rbx
000000010000dc27	popq	%r12
000000010000dc29	popq	%r14
000000010000dc2b	popq	%r15
000000010000dc2d	popq	%rbp
000000010000dc2e	retq
000000010000dc2f	nop
000000010000dc30	.byte 0xce #bad opcode
000000010000dc31	.byte 0xff #bad opcode
000000010000dc32	.byte 0xff #bad opcode
000000010000dc33	decl	%esi
000000010000dc35	.byte 0xff #bad opcode
000000010000dc36	.byte 0xff #bad opcode
000000010000dc37	jmpq	*-0x59000001(%rsi)
000000010000dc3d	.byte 0xff #bad opcode
000000010000dc3e	.byte 0xff #bad opcode
000000010000dc3f	decl	%esi
000000010000dc41	.byte 0xff #bad opcode
000000010000dc42	.byte 0xff #bad opcode
000000010000dc43	jmpq	*-0x59000001(%rsi)
000000010000dc49	.byte 0xff #bad opcode
000000010000dc4a	.byte 0xff #bad opcode
000000010000dc4b	jmpq	*-0x59000001(%rsi)
000000010000dc51	.byte 0xff #bad opcode
000000010000dc52	.byte 0xff #bad opcode
000000010000dc53	jmpq	*-0x59000001(%rsi)
000000010000dc59	.byte 0xff #bad opcode
000000010000dc5a	.byte 0xff #bad opcode
000000010000dc5b	jmpq	*-0x59000001(%rsi)
000000010000dc61	.byte 0xff #bad opcode
000000010000dc62	.byte 0xff #bad opcode
000000010000dc63	jmpq	*-0x59000001(%rsi)
000000010000dc69	.byte 0xff #bad opcode
000000010000dc6a	.byte 0xff #bad opcode
000000010000dc6b	jmpq	*-0x59000001(%rsi)
000000010000dc71	.byte 0xff #bad opcode
000000010000dc72	.byte 0xff #bad opcode
000000010000dc73	jmpq	*-0x59000001(%rsi)
000000010000dc79	.byte 0xff #bad opcode
000000010000dc7a	.byte 0xff #bad opcode
000000010000dc7b	jmpq	*-0x59000001(%rsi)
000000010000dc81	.byte 0xff #bad opcode
000000010000dc82	.byte 0xff #bad opcode
000000010000dc83	jmpq	*-0x59000001(%rsi)
000000010000dc89	.byte 0xff #bad opcode
000000010000dc8a	.byte 0xff #bad opcode
000000010000dc8b	decl	%esi
000000010000dc8d	.byte 0xff #bad opcode
000000010000dc8e	.byte 0xff #bad opcode
000000010000dc8f	jmpq	*-0x59000001(%rsi)
000000010000dc95	.byte 0xff #bad opcode
000000010000dc96	.byte 0xff #bad opcode
000000010000dc97	jmpq	*-0x59000001(%rsi)
000000010000dc9d	.byte 0xff #bad opcode
000000010000dc9e	.byte 0xff #bad opcode
000000010000dc9f	jmpq	*-0x59000001(%rsi)
000000010000dca5	.byte 0xff #bad opcode
000000010000dca6	.byte 0xff #bad opcode
000000010000dca7	jmpq	*-0x31000001(%rsi)
000000010000dcad	.byte 0xff #bad opcode
000000010000dcae	.byte 0xff #bad opcode
000000010000dcaf	decl	%esi
000000010000dcb1	.byte 0xff #bad opcode
000000010000dcb2	.byte 0xff #bad opcode
000000010000dcb3	jmpq	*-0x59000001(%rsi)
000000010000dcb9	.byte 0xff #bad opcode
000000010000dcba	.byte 0xff #bad opcode
000000010000dcbb	decl	%esi
000000010000dcbd	.byte 0xff #bad opcode
000000010000dcbe	.byte 0xff #bad opcode
000000010000dcbf	jmpq	*-0x59000001(%rsi)
000000010000dcc5	.byte 0xff #bad opcode
000000010000dcc6	.byte 0xff #bad opcode
000000010000dcc7	jmpq	*-0x59000001(%rsi)
000000010000dccd	.byte 0xff #bad opcode
000000010000dcce	.byte 0xff #bad opcode
000000010000dccf	jmpq	*-0x59000001(%rsi)
000000010000dcd5	.byte 0xff #bad opcode
000000010000dcd6	.byte 0xff #bad opcode
000000010000dcd7	jmpq	*-0x59000001(%rsi)
000000010000dcdd	.byte 0xff #bad opcode
000000010000dcde	.byte 0xff #bad opcode
000000010000dcdf	jmpq	*-0x59000001(%rsi)
000000010000dce5	.byte 0xff #bad opcode
000000010000dce6	.byte 0xff #bad opcode
000000010000dce7	jmpq	*-0x59000001(%rsi)
000000010000dced	.byte 0xff #bad opcode
000000010000dcee	.byte 0xff #bad opcode
000000010000dcef	jmpq	*-0x31000001(%rsi)
000000010000dcf5	.byte 0xff #bad opcode
000000010000dcf6	.byte 0xff #bad opcode
000000010000dcf7	jmpq	*-0x59000001(%rsi)
000000010000dcfd	.byte 0xff #bad opcode
000000010000dcfe	.byte 0xff #bad opcode
000000010000dcff	jmpq	*-0x59000001(%rsi)
000000010000dd05	.byte 0xff #bad opcode
000000010000dd06	.byte 0xff #bad opcode
000000010000dd07	jmpq	*-0x59000001(%rsi)
000000010000dd0d	.byte 0xff #bad opcode
000000010000dd0e	.byte 0xff #bad opcode
000000010000dd0f	jmpq	*-0x59000001(%rsi)
000000010000dd15	.byte 0xff #bad opcode
000000010000dd16	.byte 0xff #bad opcode
000000010000dd17	jmpq	*-0x59000001(%rsi)
000000010000dd1d	.byte 0xff #bad opcode
000000010000dd1e	.byte 0xff #bad opcode
000000010000dd1f	jmpq	*-0x59000001(%rsi)
000000010000dd25	.byte 0xff #bad opcode
000000010000dd26	.byte 0xff #bad opcode
000000010000dd27	jmpq	*-0x59000001(%rsi)
000000010000dd2d	.byte 0xff #bad opcode
000000010000dd2e	.byte 0xff #bad opcode
000000010000dd2f	jmpq	*-0x59000001(%rsi)
000000010000dd35	.byte 0xff #bad opcode
000000010000dd36	.byte 0xff #bad opcode
000000010000dd37	jmpq	*-0x59000001(%rsi)
000000010000dd3d	.byte 0xff #bad opcode
000000010000dd3e	.byte 0xff #bad opcode
000000010000dd3f	jmpq	*-0x59000001(%rsi)
000000010000dd45	.byte 0xff #bad opcode
000000010000dd46	.byte 0xff #bad opcode
000000010000dd47	jmpq	*-0x59000001(%rsi)
000000010000dd4d	.byte 0xff #bad opcode
000000010000dd4e	.byte 0xff #bad opcode
000000010000dd4f	jmpq	*-0x59000001(%rsi)
000000010000dd55	.byte 0xff #bad opcode
000000010000dd56	.byte 0xff #bad opcode
000000010000dd57	jmpq	*-0x59000001(%rsi)
000000010000dd5d	.byte 0xff #bad opcode
000000010000dd5e	.byte 0xff #bad opcode
000000010000dd5f	jmpq	*-0x59000001(%rsi)
000000010000dd65	.byte 0xff #bad opcode
000000010000dd66	.byte 0xff #bad opcode
000000010000dd67	jmpq	*-0x59000001(%rsi)
000000010000dd6d	.byte 0xff #bad opcode
000000010000dd6e	.byte 0xff #bad opcode
000000010000dd6f	jmpq	*-0x59000001(%rsi)
000000010000dd75	.byte 0xff #bad opcode
000000010000dd76	.byte 0xff #bad opcode
000000010000dd77	jmpq	*-0x59000001(%rsi)
000000010000dd7d	.byte 0xff #bad opcode
000000010000dd7e	.byte 0xff #bad opcode
000000010000dd7f	decl	%esi
000000010000dd81	.byte 0xff #bad opcode
000000010000dd82	.byte 0xff #bad opcode
000000010000dd83	jmpq	*0x66(%rsi)
000000010000dd86	nopw	%cs:(%rax,%rax)
_tp_elem_item:
000000010000dd90	pushq	%rbp
000000010000dd91	movq	%rsp, %rbp
000000010000dd94	pushq	%r14
000000010000dd96	pushq	%rbx
000000010000dd97	subq	$0x10, %rsp
000000010000dd9b	movq	%rsi, %rbx
000000010000dd9e	movq	(%rsi), %rsi
000000010000dda1	xorl	%r14d, %r14d
000000010000dda4	leaq	-0x18(%rbp), %rcx
000000010000dda8	xorl	%edx, %edx
000000010000ddaa	callq	_tp_value
000000010000ddaf	testl	%eax, %eax
000000010000ddb1	je	0x10000ddc5
000000010000ddb3	movq	-0x18(%rbp), %rsi
000000010000ddb7	movq	%rbx, %rdi
000000010000ddba	callq	_tp_push
000000010000ddbf	movl	$0x1, %r14d
000000010000ddc5	movl	%r14d, %eax
000000010000ddc8	addq	$0x10, %rsp
000000010000ddcc	popq	%rbx
000000010000ddcd	popq	%r14
000000010000ddcf	popq	%rbp
000000010000ddd0	retq
000000010000ddd1	nopw	%cs:(%rax,%rax)
_tp_kv_item:
000000010000dde0	pushq	%rbp
000000010000dde1	movq	%rsp, %rbp
000000010000dde4	pushq	%r15
000000010000dde6	pushq	%r14
000000010000dde8	pushq	%rbx
000000010000dde9	subq	$0x18, %rsp
000000010000dded	movq	%rsi, %rbx
000000010000ddf0	movq	%rdi, %r14
000000010000ddf3	movq	$0x0, -0x20(%rbp)
000000010000ddfb	movq	(%rsi), %rsi
000000010000ddfe	xorl	%r15d, %r15d
000000010000de01	leaq	-0x28(%rbp), %rcx
000000010000de05	xorl	%edx, %edx
000000010000de07	callq	_tp_value
000000010000de0c	testl	%eax, %eax
000000010000de0e	je	0x10000de36
000000010000de10	cmpl	$0x0, 0x28(%rbx)
000000010000de14	je	0x10000de44
000000010000de16	xorl	%r14d, %r14d
000000010000de19	movq	-0x28(%rbp), %rsi
000000010000de1d	movq	%rbx, %rdi
000000010000de20	callq	_tp_push
000000010000de25	movq	%rbx, %rdi
000000010000de28	movq	%r14, %rsi
000000010000de2b	callq	_tp_push
000000010000de30	movl	$0x1, %r15d
000000010000de36	movl	%r15d, %eax
000000010000de39	addq	$0x18, %rsp
000000010000de3d	popq	%rbx
000000010000de3e	popq	%r14
000000010000de40	popq	%r15
000000010000de42	popq	%rbp
000000010000de43	retq
000000010000de44	movq	0x8(%r14), %rcx
000000010000de48	movq	0x10(%r14), %rax
000000010000de4c	cmpq	%rcx, %rax
000000010000de4f	jae	0x10000de81
000000010000de51	movq	(%r14), %rdx
000000010000de54	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000de5e	nop
000000010000de60	movzbl	(%rdx,%rax), %edi
000000010000de64	cmpq	$0x20, %rdi
000000010000de68	ja	0x10000de81
000000010000de6a	btq	%rdi, %rsi
000000010000de6e	jae	0x10000de81
000000010000de70	incq	%rax
000000010000de73	movq	%rax, 0x10(%r14)
000000010000de77	cmpq	%rax, %rcx
000000010000de7a	jne	0x10000de60
000000010000de7c	xorl	%r15d, %r15d
000000010000de7f	jmp	0x10000de36
000000010000de81	xorl	%r15d, %r15d
000000010000de84	cmpq	%rax, %rcx
000000010000de87	je	0x10000de36
000000010000de89	movq	(%r14), %rcx
000000010000de8c	cmpb	$0x3a, (%rcx,%rax)
000000010000de90	jne	0x10000de36
000000010000de92	incq	%rax
000000010000de95	movq	%rax, 0x10(%r14)
000000010000de99	movq	0x8(%rbx), %rsi
000000010000de9d	xorl	%r15d, %r15d
000000010000dea0	leaq	-0x20(%rbp), %rcx
000000010000dea4	movq	%r14, %rdi
000000010000dea7	xorl	%edx, %edx
000000010000dea9	callq	_tp_value
000000010000deae	testl	%eax, %eax
000000010000deb0	je	0x10000de36
000000010000deb2	movq	-0x20(%rbp), %r14
000000010000deb6	jmp	0x10000de19
000000010000debb	nopl	(%rax,%rax)
_fwp_p_map_insert:
000000010000dec0	pushq	%rbp
000000010000dec1	movq	%rsp, %rbp
000000010000dec4	pushq	%r15
000000010000dec6	pushq	%r14
000000010000dec8	pushq	%r13
000000010000deca	pushq	%r12
000000010000decc	pushq	%rbx
000000010000decd	subq	$0x38, %rsp
000000010000ded1	movq	%rdi, %r8
000000010000ded4	movq	(%rdx), %r12
000000010000ded7	movq	%rcx, -0x58(%rbp)
000000010000dedb	movl	(%rcx), %eax
000000010000dedd	cmpl	$0x4, %eax
000000010000dee0	movq	%rsi, -0x40(%rbp)
000000010000dee4	jb	0x10000df48
000000010000dee6	addl	$-0x5, %eax
000000010000dee9	cmpl	$0x4, %eax
000000010000deec	jae	0x10000dfad
000000010000def2	testq	%r12, %r12
000000010000def5	je	0x10000e022
000000010000defb	xorl	%r15d, %r15d
000000010000defe	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000df08	movq	%r12, %rcx
000000010000df0b	jmp	0x10000df1c
000000010000df0d	nopl	(%rax)
000000010000df10	movq	%rdi, %rcx
000000010000df13	cmpq	%rcx, %r15
000000010000df16	jae	0x10000e027
000000010000df1c	leaq	(%rcx,%r15), %rsi
000000010000df20	movq	%rsi, %rdi
000000010000df23	shrq	%rdi
000000010000df26	andq	%rax, %rsi
000000010000df29	movq	0x8(%rdx,%rsi,8), %rsi
000000010000df2e	cmpq	%r8, %rsi
000000010000df31	setne	%bl
000000010000df34	je	0x10000dfa8
000000010000df36	jae	0x10000df10
000000010000df38	incq	%rdi
000000010000df3b	movq	%rdi, %r15
000000010000df3e	cmpq	%rcx, %r15
000000010000df41	jb	0x10000df1c
000000010000df43	jmp	0x10000e027
000000010000df48	testq	%r12, %r12
000000010000df4b	je	0x10000e022
000000010000df51	xorl	%r15d, %r15d
000000010000df54	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000df5e	movq	%r12, %rcx
000000010000df61	jmp	0x10000df7c
000000010000df63	nopw	%cs:(%rax,%rax)
000000010000df70	movq	%rdi, %rcx
000000010000df73	cmpq	%rcx, %r15
000000010000df76	jae	0x10000e027
000000010000df7c	leaq	(%rcx,%r15), %rsi
000000010000df80	movq	%rsi, %rdi
000000010000df83	shrq	%rdi
000000010000df86	andq	%rax, %rsi
000000010000df89	movq	0x8(%rdx,%rsi,8), %rsi
000000010000df8e	cmpq	%r8, %rsi
000000010000df91	setne	%bl
000000010000df94	je	0x10000dfa8
000000010000df96	jge	0x10000df70
000000010000df98	incq	%rdi
000000010000df9b	movq	%rdi, %r15
000000010000df9e	cmpq	%rcx, %r15
000000010000dfa1	jb	0x10000df7c
000000010000dfa3	jmp	0x10000e027
000000010000dfa8	movq	%rdi, %r15
000000010000dfab	jmp	0x10000e027
000000010000dfad	testq	%r12, %r12
000000010000dfb0	je	0x10000e022
000000010000dfb2	xorl	%r15d, %r15d
000000010000dfb5	movq	%r12, %rax
000000010000dfb8	movq	%r12, -0x38(%rbp)
000000010000dfbc	jmp	0x10000dfd2
000000010000dfbe	nop
000000010000dfc0	movq	%r12, %rax
000000010000dfc3	movq	%r14, %rdx
000000010000dfc6	movq	%r13, %r8
000000010000dfc9	cmpq	%rax, %r15
000000010000dfcc	movq	-0x38(%rbp), %r12
000000010000dfd0	jae	0x10000e027
000000010000dfd2	movq	%rax, -0x50(%rbp)
000000010000dfd6	addq	%r15, %rax
000000010000dfd9	movq	%rax, %r12
000000010000dfdc	shrq	%r12
000000010000dfdf	movabsq	$0x1ffffffffffffffe, %rcx       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000dfe9	andq	%rcx, %rax
000000010000dfec	movq	%rdx, %r14
000000010000dfef	movq	0x8(%rdx,%rax,8), %rdi
000000010000dff4	movq	%r8, %r13
000000010000dff7	movq	%r8, %rsi
000000010000dffa	movq	-0x58(%rbp), %rdx
000000010000dffe	callq	_fwp_cmp
000000010000e003	testl	%eax, %eax
000000010000e005	setne	%bl
000000010000e008	je	0x10000e14b
000000010000e00e	jns	0x10000dfc0
000000010000e010	incq	%r12
000000010000e013	movq	%r12, %r15
000000010000e016	movq	%r14, %rdx
000000010000e019	movq	%r13, %r8
000000010000e01c	movq	-0x50(%rbp), %rax
000000010000e020	jmp	0x10000dfc9
000000010000e022	movb	$0x1, %bl
000000010000e024	xorl	%r15d, %r15d
000000010000e027	movzbl	%bl, %r14d
000000010000e02b	addq	%r12, %r14
000000010000e02e	movq	%r14, %rax
000000010000e031	shlq	$0x4, %rax
000000010000e035	leaq	0x8(%rax), %rdi
000000010000e039	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000e040	movq	%rdx, -0x30(%rbp)
000000010000e044	movq	%r8, -0x48(%rbp)
000000010000e048	ja	0x10000e0a3
000000010000e04a	addq	$0x17, %rax
000000010000e04e	shrq	$0x4, %rax
000000010000e052	leaq	_fwp_gc(%rip), %rcx
000000010000e059	movzbl	0xbe8(%rax,%rcx), %eax
000000010000e061	movl	0xb48(%rcx,%rax,4), %esi
000000010000e068	subq	%rsi, _fwp_gc(%rip)
000000010000e06f	js	0x10000e0a3
000000010000e071	leaq	(%rax,%rax,2), %rax
000000010000e075	leaq	(%rcx,%rax,8), %rax
000000010000e079	addq	$0x788, %rax                    ## imm = 0x788
000000010000e07f	movq	(%rax), %r13
000000010000e082	testq	%r13, %r13
000000010000e085	je	0x10000e093
000000010000e087	movq	(%r13), %rcx
000000010000e08b	notq	%rcx
000000010000e08e	movq	%rcx, (%rax)
000000010000e091	jmp	0x10000e0ba
000000010000e093	movq	0x8(%rax), %r13
000000010000e097	movq	0x10(%rax), %rcx
000000010000e09b	subq	%r13, %rcx
000000010000e09e	cmpq	%rsi, %rcx
000000010000e0a1	jae	0x10000e0b2
000000010000e0a3	movl	$0x2, %esi
000000010000e0a8	callq	_fwp_gc_alloc_slow
000000010000e0ad	movq	%rax, %r13
000000010000e0b0	jmp	0x10000e0c2
000000010000e0b2	leaq	(%rsi,%r13), %rcx
000000010000e0b6	movq	%rcx, 0x8(%rax)
000000010000e0ba	movq	%r13, %rdi
000000010000e0bd	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000e0c2	movq	%r14, (%r13)
000000010000e0c6	leaq	0x8(%r13), %r14
000000010000e0ca	movq	-0x30(%rbp), %rsi
000000010000e0ce	addq	$0x8, %rsi
000000010000e0d2	testb	%bl, %bl
000000010000e0d4	je	0x10000e11d
000000010000e0d6	movq	%r15, %rbx
000000010000e0d9	shlq	$0x4, %rbx
000000010000e0dd	movq	%r14, %rdi
000000010000e0e0	movq	%rbx, %rdx
000000010000e0e3	movq	%rsi, -0x30(%rbp)
000000010000e0e7	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000e0ec	movq	-0x48(%rbp), %rax
000000010000e0f0	movq	%rax, (%r14,%rbx)
000000010000e0f4	movq	-0x40(%rbp), %rax
000000010000e0f8	movq	%rax, 0x8(%r14,%rbx)
000000010000e0fd	leaq	(%r14,%rbx), %rdi
000000010000e101	addq	$0x10, %rdi
000000010000e105	addq	-0x30(%rbp), %rbx
000000010000e109	subq	%r15, %r12
000000010000e10c	shlq	$0x4, %r12
000000010000e110	movq	%rbx, %rsi
000000010000e113	movq	%r12, %rdx
000000010000e116	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000e11b	jmp	0x10000e139
000000010000e11d	shlq	$0x4, %r12
000000010000e121	movq	%r14, %rdi
000000010000e124	movq	%r12, %rdx
000000010000e127	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000e12c	shlq	$0x4, %r15
000000010000e130	movq	-0x40(%rbp), %rax
000000010000e134	movq	%rax, 0x8(%r14,%r15)
000000010000e139	movq	%r13, %rax
000000010000e13c	addq	$0x38, %rsp
000000010000e140	popq	%rbx
000000010000e141	popq	%r12
000000010000e143	popq	%r13
000000010000e145	popq	%r14
000000010000e147	popq	%r15
000000010000e149	popq	%rbp
000000010000e14a	retq
000000010000e14b	movq	%r12, %r15
000000010000e14e	movq	-0x38(%rbp), %r12
000000010000e152	movq	%r14, %rdx
000000010000e155	movq	%r13, %r8
000000010000e158	jmp	0x10000e027
000000010000e15d	nopl	(%rax)
_fwp_box_u128:
000000010000e160	pushq	%rbp
000000010000e161	movq	%rsp, %rbp
000000010000e164	pushq	%r14
000000010000e166	pushq	%rbx
000000010000e167	leaq	_fwp_gc(%rip), %rax
000000010000e16e	movzbl	0x6a7c(%rip), %edx
000000010000e175	movl	0xb48(%rax,%rdx,4), %ecx
000000010000e17c	subq	%rcx, _fwp_gc(%rip)
000000010000e183	js	0x10000e1b7
000000010000e185	leaq	(%rdx,%rdx,2), %rdx
000000010000e189	leaq	(%rax,%rdx,8), %rdx
000000010000e18d	addq	$0x3c8, %rdx                    ## imm = 0x3C8
000000010000e194	movq	(%rdx), %rax
000000010000e197	testq	%rax, %rax
000000010000e19a	je	0x10000e1a7
000000010000e19c	movq	(%rax), %rcx
000000010000e19f	notq	%rcx
000000010000e1a2	movq	%rcx, (%rdx)
000000010000e1a5	jmp	0x10000e1db
000000010000e1a7	movq	0x8(%rdx), %rax
000000010000e1ab	movq	0x10(%rdx), %r8
000000010000e1af	subq	%rax, %r8
000000010000e1b2	cmpq	%rcx, %r8
000000010000e1b5	jae	0x10000e1d4
000000010000e1b7	movq	%rdi, %rbx
000000010000e1ba	movl	$0x10, %edi
000000010000e1bf	movq	%rsi, %r14
000000010000e1c2	movl	$0x1, %esi
000000010000e1c7	callq	_fwp_gc_alloc_slow
000000010000e1cc	movq	%r14, %rsi
000000010000e1cf	movq	%rbx, %rdi
000000010000e1d2	jmp	0x10000e1e1
000000010000e1d4	addq	%rax, %rcx
000000010000e1d7	movq	%rcx, 0x8(%rdx)
000000010000e1db	xorps	%xmm0, %xmm0
000000010000e1de	movups	%xmm0, (%rax)
000000010000e1e1	movq	%rsi, 0x8(%rax)
000000010000e1e5	movq	%rdi, (%rax)
000000010000e1e8	popq	%rbx
000000010000e1e9	popq	%r14
000000010000e1eb	popq	%rbp
000000010000e1ec	retq
000000010000e1ed	nopl	(%rax)
_fwp_utf8_put:
000000010000e1f0	pushq	%rbp
000000010000e1f1	movq	%rsp, %rbp
000000010000e1f4	subq	$0x10, %rsp
000000010000e1f8	cmpl	$0x7f, %esi
000000010000e1fb	ja	0x10000e20b
000000010000e1fd	movb	%sil, -0x4(%rbp)
000000010000e201	movl	$0x1, %edx
000000010000e206	jmp	0x10000e2a8
000000010000e20b	movl	%esi, %eax
000000010000e20d	cmpl	$0x7ff, %esi                    ## imm = 0x7FF
000000010000e213	ja	0x10000e230
000000010000e215	shrl	$0x6, %eax
000000010000e218	orb	$-0x40, %al
000000010000e21a	movb	%al, -0x4(%rbp)
000000010000e21d	andb	$0x3f, %sil
000000010000e221	orb	$-0x80, %sil
000000010000e225	movb	%sil, -0x3(%rbp)
000000010000e229	movl	$0x2, %edx
000000010000e22e	jmp	0x10000e2a8
000000010000e230	cmpl	$0xffff, %esi                   ## imm = 0xFFFF
000000010000e236	ja	0x10000e25f
000000010000e238	shrl	$0xc, %eax
000000010000e23b	orb	$-0x20, %al
000000010000e23d	movb	%al, -0x4(%rbp)
000000010000e240	movl	%esi, %eax
000000010000e242	shrl	$0x6, %eax
000000010000e245	andb	$0x3f, %al
000000010000e247	orb	$-0x80, %al
000000010000e249	movb	%al, -0x3(%rbp)
000000010000e24c	andb	$0x3f, %sil
000000010000e250	orb	$-0x80, %sil
000000010000e254	movb	%sil, -0x2(%rbp)
000000010000e258	movl	$0x3, %edx
000000010000e25d	jmp	0x10000e2a8
000000010000e25f	shrl	$0x12, %eax
000000010000e262	movl	%esi, %ecx
000000010000e264	shrl	$0xc, %ecx
000000010000e267	andb	$0x3f, %cl
000000010000e26a	movl	%esi, %edx
000000010000e26c	shrl	$0x6, %edx
000000010000e26f	movd	%eax, %xmm0
000000010000e273	movzbl	%cl, %eax
000000010000e276	pinsrb	$0x1, %eax, %xmm0
000000010000e27c	andb	$0x3f, %dl
000000010000e27f	movzbl	%dl, %eax
000000010000e282	pinsrb	$0x2, %eax, %xmm0
000000010000e288	andb	$0x3f, %sil
000000010000e28c	movzbl	%sil, %eax
000000010000e290	pinsrb	$0x3, %eax, %xmm0
000000010000e296	por	0x3152(%rip), %xmm0
000000010000e29e	movd	%xmm0, -0x4(%rbp)
000000010000e2a3	movl	$0x4, %edx
000000010000e2a8	leaq	-0x4(%rbp), %rsi
000000010000e2ac	callq	_buf_put
000000010000e2b1	addq	$0x10, %rsp
000000010000e2b5	popq	%rbp
000000010000e2b6	retq
000000010000e2b7	nopw	(%rax,%rax)
_tp_push:
000000010000e2c0	pushq	%rbp
000000010000e2c1	movq	%rsp, %rbp
000000010000e2c4	pushq	%r15
000000010000e2c6	pushq	%r14
000000010000e2c8	pushq	%r13
000000010000e2ca	pushq	%r12
000000010000e2cc	pushq	%rbx
000000010000e2cd	pushq	%rax
000000010000e2ce	movq	%rsi, %rdx
000000010000e2d1	movq	%rdi, %r14
000000010000e2d4	movq	0x18(%rdi), %r15
000000010000e2d8	cmpq	0x20(%rdi), %r15
000000010000e2dc	jne	0x10000e34f
000000010000e2de	leaq	(%r15,%r15), %rax
000000010000e2e2	testq	%r15, %r15
000000010000e2e5	movl	$0x8, %r13d
000000010000e2eb	cmovneq	%rax, %r13
000000010000e2ef	movq	%r13, 0x20(%r14)
000000010000e2f3	movq	0x10(%r14), %r12
000000010000e2f7	shlq	$0x3, %r13
000000010000e2fb	cmpq	$0x4000, %r13                   ## imm = 0x4000
000000010000e302	movq	%rdx, -0x30(%rbp)
000000010000e306	ja	0x10000e365
000000010000e308	movq	%r13, %rcx
000000010000e30b	shrq	$0x4, %rcx
000000010000e30f	leaq	_fwp_gc(%rip), %rax
000000010000e316	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000e31e	movl	0xb48(%rax,%rcx,4), %esi
000000010000e325	subq	%rsi, _fwp_gc(%rip)
000000010000e32c	js	0x10000e365
000000010000e32e	leaq	(%rcx,%rcx,2), %rcx
000000010000e332	leaq	(%rax,%rcx,8), %rax
000000010000e336	addq	$0x788, %rax                    ## imm = 0x788
000000010000e33c	movq	(%rax), %rbx
000000010000e33f	testq	%rbx, %rbx
000000010000e342	je	0x10000e355
000000010000e344	movq	(%rbx), %rcx
000000010000e347	notq	%rcx
000000010000e34a	movq	%rcx, (%rax)
000000010000e34d	jmp	0x10000e384
000000010000e34f	movq	0x10(%r14), %rbx
000000010000e353	jmp	0x10000e3be
000000010000e355	movq	0x8(%rax), %rbx
000000010000e359	movq	0x10(%rax), %rcx
000000010000e35d	subq	%rbx, %rcx
000000010000e360	cmpq	%rsi, %rcx
000000010000e363	jae	0x10000e37c
000000010000e365	movq	%r13, %rdi
000000010000e368	movl	$0x2, %esi
000000010000e36d	callq	_fwp_gc_alloc_slow
000000010000e372	movq	%rax, %rbx
000000010000e375	testq	%r12, %r12
000000010000e378	jne	0x10000e391
000000010000e37a	jmp	0x10000e3b2
000000010000e37c	leaq	(%rbx,%rsi), %rcx
000000010000e380	movq	%rcx, 0x8(%rax)
000000010000e384	movq	%rbx, %rdi
000000010000e387	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000e38c	testq	%r12, %r12
000000010000e38f	je	0x10000e3b2
000000010000e391	shlq	$0x3, %r15
000000010000e395	cmpq	%r13, %r15
000000010000e398	cmovaeq	%r13, %r15
000000010000e39c	movq	%rbx, %rdi
000000010000e39f	movq	%r12, %rsi
000000010000e3a2	movq	%r15, %rdx
000000010000e3a5	callq	0x100011228                     ## symbol stub for: _memcpy
000000010000e3aa	movq	%r12, %rdi
000000010000e3ad	callq	_fwp_mem_free
000000010000e3b2	movq	%rbx, 0x10(%r14)
000000010000e3b6	movq	0x18(%r14), %r15
000000010000e3ba	movq	-0x30(%rbp), %rdx
000000010000e3be	leaq	0x1(%r15), %rax
000000010000e3c2	movq	%rax, 0x18(%r14)
000000010000e3c6	movq	%rdx, (%rbx,%r15,8)
000000010000e3ca	addq	$0x8, %rsp
000000010000e3ce	popq	%rbx
000000010000e3cf	popq	%r12
000000010000e3d1	popq	%r13
000000010000e3d3	popq	%r14
000000010000e3d5	popq	%r15
000000010000e3d7	popq	%rbp
000000010000e3d8	retq
000000010000e3d9	nopl	(%rax)
_fwp_cmp:
000000010000e3e0	pushq	%rbp
000000010000e3e1	movq	%rsp, %rbp
000000010000e3e4	pushq	%r15
000000010000e3e6	pushq	%r14
000000010000e3e8	pushq	%r13
000000010000e3ea	pushq	%r12
000000010000e3ec	pushq	%rbx
000000010000e3ed	subq	$0x38, %rsp
000000010000e3f1	movq	%rsi, %rbx
000000010000e3f4	movq	%rdi, %r14
000000010000e3f7	movl	(%rdx), %r13d
000000010000e3fa	cmpq	$0x15, %r13
000000010000e3fe	ja	0x10000e425
000000010000e400	movq	%rdx, %r15
000000010000e403	leaq	0x4ba(%rip), %rax
000000010000e40a	movslq	(%rax,%r13,4), %rcx
000000010000e40e	addq	%rax, %rcx
000000010000e411	jmpq	*%rcx
000000010000e413	xorl	%ecx, %ecx
000000010000e415	cmpq	%rbx, %r14
000000010000e418	setg	%cl
000000010000e41b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e420	cmovgel	%ecx, %eax
000000010000e423	jmp	0x10000e435
000000010000e425	xorl	%ecx, %ecx
000000010000e427	cmpq	%rbx, %r14
000000010000e42a	seta	%cl
000000010000e42d	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e432	cmovael	%ecx, %eax
000000010000e435	addq	$0x38, %rsp
000000010000e439	popq	%rbx
000000010000e43a	popq	%r12
000000010000e43c	popq	%r13
000000010000e43e	popq	%r14
000000010000e440	popq	%r15
000000010000e442	popq	%rbp
000000010000e443	retq
000000010000e444	movq	%rbx, %rsi
000000010000e447	movq	(%r14), %rbx
000000010000e44a	movq	(%rsi), %r15
000000010000e44d	addq	$0x8, %r14
000000010000e451	addq	$0x8, %rsi
000000010000e455	cmpq	%r15, %rbx
000000010000e458	movq	%r15, %rdx
000000010000e45b	cmovbq	%rbx, %rdx
000000010000e45f	movq	%r14, %rdi
000000010000e462	callq	0x100011222                     ## symbol stub for: _memcmp
000000010000e467	testl	%eax, %eax
000000010000e469	je	0x10000e805
000000010000e46f	sarl	$0x1f, %eax
000000010000e472	orl	$0x1, %eax
000000010000e475	jmp	0x10000e435
000000010000e477	movq	%r14, -0x30(%rbp)
000000010000e47b	movq	(%r14), %rax
000000010000e47e	movq	(%rbx), %r12
000000010000e481	cmpq	%r12, %rax
000000010000e484	movq	%r12, -0x38(%rbp)
000000010000e488	movq	%rax, -0x40(%rbp)
000000010000e48c	cmovbq	%rax, %r12
000000010000e490	testq	%r12, %r12
000000010000e493	je	0x10000e4fc
000000010000e495	movq	%rbx, %r14
000000010000e498	movq	0x38(%r15), %rax
000000010000e49c	movq	%rax, -0x48(%rbp)
000000010000e4a0	movl	$0x10, %ebx
000000010000e4a5	jmp	0x10000e4b9
000000010000e4a7	nopw	(%rax,%rax)
000000010000e4b0	addq	$0x10, %rbx
000000010000e4b4	decq	%r12
000000010000e4b7	je	0x10000e4fc
000000010000e4b9	movq	-0x30(%rbp), %rax
000000010000e4bd	movq	-0x8(%rax,%rbx), %rdi
000000010000e4c2	movq	-0x8(%r14,%rbx), %rsi
000000010000e4c7	movq	-0x48(%rbp), %rdx
000000010000e4cb	callq	_fwp_cmp
000000010000e4d0	testl	%eax, %eax
000000010000e4d2	jne	0x10000e435
000000010000e4d8	cmpl	$0x12, %r13d
000000010000e4dc	jne	0x10000e4b0
000000010000e4de	movq	-0x30(%rbp), %rax
000000010000e4e2	movq	(%rax,%rbx), %rdi
000000010000e4e6	movq	(%r14,%rbx), %rsi
000000010000e4ea	movq	0x40(%r15), %rdx
000000010000e4ee	callq	_fwp_cmp
000000010000e4f3	testl	%eax, %eax
000000010000e4f5	je	0x10000e4b0
000000010000e4f7	jmp	0x10000e435
000000010000e4fc	xorl	%ecx, %ecx
000000010000e4fe	movq	-0x38(%rbp), %rax
000000010000e502	cmpq	%rax, -0x40(%rbp)
000000010000e506	jmp	0x10000e42a
000000010000e50b	movq	(%r14), %rdx
000000010000e50e	movq	0x8(%r14), %rcx
000000010000e512	movq	(%rbx), %rdi
000000010000e515	movq	0x8(%rbx), %rsi
000000010000e519	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e51e	cmpq	%rdi, %rdx
000000010000e521	movq	%rcx, %r8
000000010000e524	sbbq	%rsi, %r8
000000010000e527	jb	0x10000e435
000000010000e52d	cmpq	%rdx, %rdi
000000010000e530	sbbq	%rcx, %rsi
000000010000e533	setb	%al
000000010000e536	movzbl	%al, %eax
000000010000e539	jmp	0x10000e435
000000010000e53e	movl	%r14d, %ecx
000000010000e541	sarl	$0x1f, %ecx
000000010000e544	shrl	%ecx
000000010000e546	xorl	%r14d, %ecx
000000010000e549	movl	%ebx, %edx
000000010000e54b	sarl	$0x1f, %edx
000000010000e54e	shrl	%edx
000000010000e550	xorl	%ebx, %edx
000000010000e552	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e557	cmpl	%edx, %ecx
000000010000e559	jl	0x10000e435
000000010000e55f	jmp	0x10000e589
000000010000e561	movq	%r14, %rcx
000000010000e564	sarq	$0x3f, %rcx
000000010000e568	shrq	%rcx
000000010000e56b	xorq	%r14, %rcx
000000010000e56e	movq	%rbx, %rdx
000000010000e571	sarq	$0x3f, %rdx
000000010000e575	shrq	%rdx
000000010000e578	xorq	%rbx, %rdx
000000010000e57b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e580	cmpq	%rdx, %rcx
000000010000e583	jl	0x10000e435
000000010000e589	setg	%al
000000010000e58c	movzbl	%al, %eax
000000010000e58f	jmp	0x10000e435
000000010000e594	movq	(%r14), %rdx
000000010000e597	movq	0x8(%r14), %rcx
000000010000e59b	movq	(%rbx), %rdi
000000010000e59e	movq	0x8(%rbx), %rsi
000000010000e5a2	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e5a7	cmpq	%rdi, %rdx
000000010000e5aa	movq	%rcx, %r8
000000010000e5ad	sbbq	%rsi, %r8
000000010000e5b0	jl	0x10000e435
000000010000e5b6	cmpq	%rdx, %rdi
000000010000e5b9	sbbq	%rcx, %rsi
000000010000e5bc	setl	%al
000000010000e5bf	movzbl	%al, %eax
000000010000e5c2	jmp	0x10000e435
000000010000e5c7	testq	%r14, %r14
000000010000e5ca	sete	%al
000000010000e5cd	testq	%rbx, %rbx
000000010000e5d0	sete	%cl
000000010000e5d3	orb	%al, %cl
000000010000e5d5	je	0x10000e80f
000000010000e5db	testq	%rbx, %rbx
000000010000e5de	setne	%cl
000000010000e5e1	orb	%al, %cl
000000010000e5e3	xorb	$0x1, %cl
000000010000e5e6	movzbl	%cl, %ecx
000000010000e5e9	testb	%al, %al
000000010000e5eb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e5f0	cmovel	%ecx, %eax
000000010000e5f3	testq	%rbx, %rbx
000000010000e5f6	cmovel	%ecx, %eax
000000010000e5f9	jmp	0x10000e435
000000010000e5fe	movq	%r14, %r13
000000010000e601	movq	%rbx, %r14
000000010000e604	movslq	0x10(%r15), %rbx
000000010000e608	testq	%rbx, %rbx
000000010000e60b	jle	0x10000e8ba
000000010000e611	movq	0x20(%r15), %r15
000000010000e615	xorl	%r12d, %r12d
000000010000e618	nopl	(%rax,%rax)
000000010000e620	movq	0x8(%r13,%r12,8), %rdi
000000010000e625	movq	0x8(%r14,%r12,8), %rsi
000000010000e62a	movq	(%r15,%r12,8), %rdx
000000010000e62e	callq	_fwp_cmp
000000010000e633	testl	%eax, %eax
000000010000e635	jne	0x10000e435
000000010000e63b	incq	%r12
000000010000e63e	xorl	%eax, %eax
000000010000e640	cmpq	%r12, %rbx
000000010000e643	jne	0x10000e620
000000010000e645	jmp	0x10000e435
000000010000e64a	movq	(%r14), %rax
000000010000e64d	movabsq	$0x7fffffffffffffff, %r13       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000e657	movq	%rax, -0x30(%rbp)
000000010000e65b	andq	%r13, %rax
000000010000e65e	movq	(%rbx), %rcx
000000010000e661	movq	%rcx, -0x48(%rbp)
000000010000e665	andq	%rcx, %r13
000000010000e668	cmpq	%r13, %rax
000000010000e66b	movq	%r13, -0x58(%rbp)
000000010000e66f	movq	%rax, -0x50(%rbp)
000000010000e673	cmovbq	%rax, %r13
000000010000e677	testq	%r13, %r13
000000010000e67a	je	0x10000e7d0
000000010000e680	movq	0x38(%r15), %r15
000000010000e684	leaq	0x8(%r14), %rax
000000010000e688	movq	%rax, -0x40(%rbp)
000000010000e68c	leaq	0x8(%rbx), %rax
000000010000e690	movq	%rax, -0x38(%rbp)
000000010000e694	xorl	%r12d, %r12d
000000010000e697	nopw	(%rax,%rax)
000000010000e6a0	movl	$0x8, %eax
000000010000e6a5	testq	%r15, %r15
000000010000e6a8	je	0x10000e6be
000000010000e6aa	movl	(%r15), %ecx
000000010000e6ad	cmpq	$0xa, %rcx
000000010000e6b1	ja	0x10000e6be
000000010000e6b3	leaq	0x301e(%rip), %rax
000000010000e6ba	movq	(%rax,%rcx,8), %rax
000000010000e6be	movq	-0x40(%rbp), %rcx
000000010000e6c2	cmpq	$0x0, -0x30(%rbp)
000000010000e6c7	jns	0x10000e6cd
000000010000e6c9	movq	0x10(%r14), %rcx
000000010000e6cd	movq	%rax, %rdx
000000010000e6d0	imulq	%r12, %rdx
000000010000e6d4	cmpq	$0x8, %rax
000000010000e6d8	je	0x10000e705
000000010000e6da	cmpq	$0x2, %rax
000000010000e6de	je	0x10000e6f5
000000010000e6e0	cmpq	$0x1, %rax
000000010000e6e4	jne	0x10000e713
000000010000e6e6	movzbl	(%rcx,%rdx), %ecx
000000010000e6ea	movl	(%r15), %eax
000000010000e6ed	testl	%eax, %eax
000000010000e6ef	movsbq	%cl, %rdi
000000010000e6f3	jmp	0x10000e71f
000000010000e6f5	movzwl	(%rcx,%rdx), %ecx
000000010000e6f9	movl	(%r15), %eax
000000010000e6fc	cmpl	$0x1, %eax
000000010000e6ff	movswq	%cx, %rdi
000000010000e703	jmp	0x10000e71f
000000010000e705	movq	(%rcx,%rdx), %rdi
000000010000e709	testq	%r15, %r15
000000010000e70c	je	0x10000e759
000000010000e70e	movl	(%r15), %eax
000000010000e711	jmp	0x10000e723
000000010000e713	movl	(%rcx,%rdx), %ecx
000000010000e716	movl	(%r15), %eax
000000010000e719	cmpl	$0x2, %eax
000000010000e71c	movslq	%ecx, %rdi
000000010000e71f	cmovneq	%rcx, %rdi
000000010000e723	cmpl	$0xa, %eax
000000010000e726	ja	0x10000e759
000000010000e728	movl	$0x484, %ecx                    ## imm = 0x484
000000010000e72d	btl	%eax, %ecx
000000010000e730	jb	0x10000e752
000000010000e732	movl	$0x1, %ecx
000000010000e737	movl	$0x21, %edx
000000010000e73c	btl	%eax, %edx
000000010000e73f	jb	0x10000e75e
000000010000e741	movl	$0x42, %ecx
000000010000e746	btl	%eax, %ecx
000000010000e749	jae	0x10000e759
000000010000e74b	movl	$0x2, %ecx
000000010000e750	jmp	0x10000e75e
000000010000e752	movl	$0x4, %ecx
000000010000e757	jmp	0x10000e75e
000000010000e759	movl	$0x8, %ecx
000000010000e75e	movq	-0x38(%rbp), %rax
000000010000e762	cmpq	$0x0, -0x48(%rbp)
000000010000e767	jns	0x10000e76d
000000010000e769	movq	0x10(%rbx), %rax
000000010000e76d	movq	%rcx, %rdx
000000010000e770	imulq	%r12, %rdx
000000010000e774	cmpq	$0x1, %rcx
000000010000e778	je	0x10000e798
000000010000e77a	cmpl	$0x2, %ecx
000000010000e77d	je	0x10000e78a
000000010000e77f	cmpl	$0x8, %ecx
000000010000e782	jne	0x10000e7a6
000000010000e784	movq	(%rax,%rdx), %rsi
000000010000e788	jmp	0x10000e7b4
000000010000e78a	cmpl	$0x1, (%r15)
000000010000e78e	movzwl	(%rax,%rdx), %eax
000000010000e792	movswq	%ax, %rsi
000000010000e796	jmp	0x10000e7b0
000000010000e798	cmpl	$0x0, (%r15)
000000010000e79c	movzbl	(%rax,%rdx), %eax
000000010000e7a0	movsbq	%al, %rsi
000000010000e7a4	jmp	0x10000e7b0
000000010000e7a6	cmpl	$0x2, (%r15)
000000010000e7aa	movl	(%rax,%rdx), %eax
000000010000e7ad	movslq	%eax, %rsi
000000010000e7b0	cmovneq	%rax, %rsi
000000010000e7b4	movq	%r15, %rdx
000000010000e7b7	callq	_fwp_cmp
000000010000e7bc	testl	%eax, %eax
000000010000e7be	jne	0x10000e435
000000010000e7c4	incq	%r12
000000010000e7c7	cmpq	%r12, %r13
000000010000e7ca	jne	0x10000e6a0
000000010000e7d0	xorl	%ecx, %ecx
000000010000e7d2	movq	-0x50(%rbp), %rax
000000010000e7d6	cmpq	-0x58(%rbp), %rax
000000010000e7da	jmp	0x10000e42a
000000010000e7df	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000e7e6	ja	0x10000e856
000000010000e7e8	movl	%r14d, %eax
000000010000e7eb	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000e7f2	jbe	0x10000e862
000000010000e7f4	movl	(%rbx), %ecx
000000010000e7f6	cmpl	%ecx, %eax
000000010000e7f8	je	0x10000e868
000000010000e7fa	seta	%al
000000010000e7fd	movzbl	%al, %ecx
000000010000e800	jmp	0x10000e42d
000000010000e805	xorl	%ecx, %ecx
000000010000e807	cmpq	%r15, %rbx
000000010000e80a	jmp	0x10000e42a
000000010000e80f	movq	0x38(%r15), %r15
000000010000e813	nopw	%cs:(%rax,%rax)
000000010000e820	movq	0x8(%r14), %rdi
000000010000e824	movq	0x8(%rbx), %rsi
000000010000e828	movq	%r15, %rdx
000000010000e82b	callq	_fwp_cmp
000000010000e830	testl	%eax, %eax
000000010000e832	jne	0x10000e435
000000010000e838	movq	0x10(%r14), %r14
000000010000e83c	movq	0x10(%rbx), %rbx
000000010000e840	testq	%r14, %r14
000000010000e843	sete	%al
000000010000e846	je	0x10000e5db
000000010000e84c	testq	%rbx, %rbx
000000010000e84f	jne	0x10000e820
000000010000e851	jmp	0x10000e5db
000000010000e856	movl	(%r14), %eax
000000010000e859	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000e860	ja	0x10000e7f4
000000010000e862	movl	%ebx, %ecx
000000010000e864	cmpl	%ecx, %eax
000000010000e866	jne	0x10000e7fa
000000010000e868	movq	%r14, %r13
000000010000e86b	movq	%rbx, %r14
000000010000e86e	movq	0x28(%r15), %rcx
000000010000e872	movl	%eax, %eax
000000010000e874	movslq	(%rcx,%rax,4), %rbx
000000010000e878	testq	%rbx, %rbx
000000010000e87b	jle	0x10000e8ba
000000010000e87d	movq	0x30(%r15), %rcx
000000010000e881	movq	(%rcx,%rax,8), %r15
000000010000e885	xorl	%r12d, %r12d
000000010000e888	nopl	(%rax,%rax)
000000010000e890	movq	0x8(%r13,%r12,8), %rdi
000000010000e895	movq	0x8(%r14,%r12,8), %rsi
000000010000e89a	movq	(%r15,%r12,8), %rdx
000000010000e89e	callq	_fwp_cmp
000000010000e8a3	testl	%eax, %eax
000000010000e8a5	jne	0x10000e435
000000010000e8ab	incq	%r12
000000010000e8ae	xorl	%eax, %eax
000000010000e8b0	cmpq	%r12, %rbx
000000010000e8b3	jne	0x10000e890
000000010000e8b5	jmp	0x10000e435
000000010000e8ba	xorl	%eax, %eax
000000010000e8bc	jmp	0x10000e435
000000010000e8c1	nopl	(%rax)
000000010000e8c4	sti
000000010000e8c6	.byte 0xff #bad opcode
000000010000e8c7	decl	-0x5(%rdi)
000000010000e8ca	.byte 0xff #bad opcode
000000010000e8cb	decl	-0x5(%rdi)
000000010000e8ce	.byte 0xff #bad opcode
000000010000e8cf	decl	-0x5(%rdi)
000000010000e8d2	.byte 0xff #bad opcode
000000010000e8d3	callq	*%rax
000000010000e8d5	cld
000000010000e8d6	.byte 0xff #bad opcode
000000010000e8d7	jmpq	*-0x5(%rcx)
000000010000e8da	.byte 0xff #bad opcode
000000010000e8db	jmpq	*-0x5(%rcx)
000000010000e8de	.byte 0xff #bad opcode
000000010000e8df	jmpq	*-0x5(%rcx)
000000010000e8e2	.byte 0xff #bad opcode
000000010000e8e3	jmpq	*-0x5(%rcx)
000000010000e8e6	.byte 0xff #bad opcode
000000010000e8e7	incl	-0x4(%rdi)
000000010000e8ea	.byte 0xff #bad opcode
000000010000e8eb	.byte 0xff #bad opcode
000000010000e8ec	jp	0x10000e8ea
000000010000e8ee	.byte 0xff #bad opcode
000000010000e8ef	lcalll	*-0x7f000004(%rbp)
000000010000e8f5	sti
000000010000e8f6	.byte 0xff #bad opcode
000000010000e8f7	incl	0x1bfffffb(%rax)
000000010000e8fd	.byte 0xff #bad opcode
000000010000e8fe	.byte 0xff #bad opcode
000000010000e8ff	incl	(%rbx)
000000010000e901	std
000000010000e902	.byte 0xff #bad opcode
000000010000e903	.byte 0xff #bad opcode
000000010000e904	cmpb	%ch, %bh
000000010000e906	.byte 0xff #bad opcode
000000010000e907	incl	-0x4c000003(%rsi)
000000010000e90d	sti
000000010000e90e	.byte 0xff #bad opcode
000000010000e90f	pushq	0x4ffffffb(%rbx)
000000010000e915	sti
000000010000e916	.byte 0xff #bad opcode
000000010000e917	decl	-0x5(%rdi)
000000010000e91a	.byte 0xff #bad opcode
000000010000e91b	decl	(%rdi)
000000010000e91d	.byte 0x1f #bad opcode
000000010000e91e	addb	%dl, 0x48(%rbp)
000000010000e922	movl	%esp, %ebp
000000010000e924	pushq	%r15
000000010000e926	pushq	%r14
000000010000e928	pushq	%r13
000000010000e92a	pushq	%r12
000000010000e92c	pushq	%rbx
000000010000e92d	subq	$0x268, %rsp                    ## imm = 0x268
000000010000e934	movq	0x46f5(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000e93b	movq	(%rax), %rax
000000010000e93e	movq	%rax, -0x30(%rbp)
000000010000e942	movl	(%rdx), %eax
000000010000e944	cmpq	$0x19, %rax
000000010000e948	ja	0x10000fc0b
000000010000e94e	movq	%rdx, %r15
000000010000e951	movq	%rsi, %r14
000000010000e954	movq	%rdi, %r13
000000010000e957	leaq	0x141e(%rip), %rdx
000000010000e95e	movslq	(%rdx,%rax,4), %rsi
000000010000e962	addq	%rdx, %rsi
000000010000e965	movq	%rdi, -0x278(%rbp)
000000010000e96c	jmpq	*%rsi
000000010000e96e	leaq	0x3ca0(%rip), %rdx              ## literal pool for: "%lld"
000000010000e975	jmp	0x10000e97e
000000010000e977	leaq	0x3c9c(%rip), %rdx              ## literal pool for: "%llu"
000000010000e97e	leaq	-0x270(%rbp), %rbx
000000010000e985	movl	$0x200, %esi                    ## imm = 0x200
000000010000e98a	movq	%rbx, %rdi
000000010000e98d	movq	%r14, %rcx
000000010000e990	xorl	%eax, %eax
000000010000e992	callq	0x10001128e                     ## symbol stub for: _snprintf
000000010000e997	jmp	0x10000fbf5
000000010000e99c	cmpl	$0x13, %eax
000000010000e99f	leaq	0x3ca5(%rip), %rax              ## literal pool for: "set{"
000000010000e9a6	leaq	0x3ca3(%rip), %rsi              ## literal pool for: "map{"
000000010000e9ad	cmoveq	%rax, %rsi
000000010000e9b1	movl	$0x4, %edx
000000010000e9b6	movq	%r13, %rdi
000000010000e9b9	callq	_buf_put
000000010000e9be	cmpq	$0x0, (%r14)
000000010000e9c2	je	0x10000ea9e
000000010000e9c8	movq	0x38(%r15), %rdx
000000010000e9cc	movq	0x8(%r14), %rsi
000000010000e9d0	movq	-0x278(%rbp), %rbx
000000010000e9d7	movq	%rbx, %rdi
000000010000e9da	xorl	%ecx, %ecx
000000010000e9dc	callq	_fwp_write
000000010000e9e1	cmpl	$0x12, (%r15)
000000010000e9e5	jne	0x10000ea0d
000000010000e9e7	leaq	0x3c67(%rip), %rsi              ## literal pool for: ": "
000000010000e9ee	movl	$0x2, %edx
000000010000e9f3	movq	%rbx, %rdi
000000010000e9f6	callq	_buf_put
000000010000e9fb	movq	0x10(%r14), %rsi
000000010000e9ff	movq	0x40(%r15), %rdx
000000010000ea03	movq	%rbx, %rdi
000000010000ea06	xorl	%ecx, %ecx
000000010000ea08	callq	_fwp_write
000000010000ea0d	cmpq	$0x2, (%r14)
000000010000ea11	jb	0x10000ea9e
000000010000ea17	leaq	0x20(%r14), %r13
000000010000ea1b	movl	$0x1, %r12d
000000010000ea21	jmp	0x10000ea3c
000000010000ea23	nopw	%cs:(%rax,%rax)
000000010000ea30	incq	%r12
000000010000ea33	addq	$0x10, %r13
000000010000ea37	cmpq	(%r14), %r12
000000010000ea3a	jae	0x10000ea9e
000000010000ea3c	movl	$0x2, %edx
000000010000ea41	movq	-0x278(%rbp), %rbx
000000010000ea48	movq	%rbx, %rdi
000000010000ea4b	leaq	0x3b42(%rip), %rsi              ## literal pool for: ", "
000000010000ea52	callq	_buf_put
000000010000ea57	movq	-0x8(%r13), %rsi
000000010000ea5b	movq	0x38(%r15), %rdx
000000010000ea5f	movq	%rbx, %rdi
000000010000ea62	xorl	%ecx, %ecx
000000010000ea64	callq	_fwp_write
000000010000ea69	cmpl	$0x12, (%r15)
000000010000ea6d	jne	0x10000ea30
000000010000ea6f	movl	$0x2, %edx
000000010000ea74	movq	-0x278(%rbp), %rbx
000000010000ea7b	movq	%rbx, %rdi
000000010000ea7e	leaq	0x3bd0(%rip), %rsi              ## literal pool for: ": "
000000010000ea85	callq	_buf_put
000000010000ea8a	movq	(%r13), %rsi
000000010000ea8e	movq	0x40(%r15), %rdx
000000010000ea92	movq	%rbx, %rdi
000000010000ea95	xorl	%ecx, %ecx
000000010000ea97	callq	_fwp_write
000000010000ea9c	jmp	0x10000ea30
000000010000ea9e	movb	$0x7d, -0x270(%rbp)
000000010000eaa5	leaq	-0x270(%rbp), %rsi
000000010000eaac	movl	$0x1, %edx
000000010000eab1	movq	-0x278(%rbp), %rdi
000000010000eab8	jmp	0x10000fc06
000000010000eabd	movq	0x8(%r15), %rbx
000000010000eac1	testq	%rbx, %rbx
000000010000eac4	je	0x10000f4b8
000000010000eaca	leaq	0x3aec(%rip), %rsi              ## literal pool for: "Duration"
000000010000ead1	movq	%rbx, %rdi
000000010000ead4	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000ead9	testl	%eax, %eax
000000010000eadb	je	0x10000f763
000000010000eae1	movq	%r15, -0x280(%rbp)
000000010000eae8	addq	$0x10, %r15
000000010000eaec	movq	%rbx, %rdi
000000010000eaef	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000eaf4	movq	%r13, %rdi
000000010000eaf7	movq	%rbx, %rsi
000000010000eafa	movq	%rax, %rdx
000000010000eafd	callq	_buf_put
000000010000eb02	movb	$0x20, -0x270(%rbp)
000000010000eb09	leaq	-0x270(%rbp), %rsi
000000010000eb10	movl	$0x1, %edx
000000010000eb15	movq	%r13, %rdi
000000010000eb18	callq	_buf_put
000000010000eb1d	xorl	%r12d, %r12d
000000010000eb20	jmp	0x10000f4d9
000000010000eb25	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000eb2c	ja	0x10000f2f4
000000010000eb32	movl	%r14d, %eax
000000010000eb35	jmp	0x10000f2f7
000000010000eb3a	movq	%r14, %xmm0
000000010000eb3f	movq	%xmm0, -0x278(%rbp)
000000010000eb47	ucomisd	%xmm0, %xmm0
000000010000eb4b	jp	0x10000fd6d
000000010000eb51	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000eb5b	andq	%r14, %rax
000000010000eb5e	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
000000010000eb68	cmpq	%rcx, %rax
000000010000eb6b	je	0x10000f478
000000010000eb71	movl	$0x1, %ebx
000000010000eb76	leaq	-0x270(%rbp), %r14
000000010000eb7d	nopl	(%rax)
000000010000eb80	movq	%r14, %rdi
000000010000eb83	movsd	-0x278(%rbp), %xmm0
000000010000eb8b	movl	%ebx, %esi
000000010000eb8d	callq	_fwp_format_g
000000010000eb92	movq	%r14, %rdi
000000010000eb95	xorl	%esi, %esi
000000010000eb97	callq	0x1000112b8                     ## symbol stub for: _strtod
000000010000eb9c	ucomisd	-0x278(%rbp), %xmm0
000000010000eba4	jne	0x10000ebac
000000010000eba6	jnp	0x10000f209
000000010000ebac	incl	%ebx
000000010000ebae	cmpl	$0x12, %ebx
000000010000ebb1	jne	0x10000eb80
000000010000ebb3	leaq	-0x270(%rbp), %rbx
000000010000ebba	movq	%rbx, %rdi
000000010000ebbd	movsd	-0x278(%rbp), %xmm0
000000010000ebc5	movl	$0x11, %esi
000000010000ebca	callq	_fwp_format_g
000000010000ebcf	movq	%rbx, %rdi
000000010000ebd2	jmp	0x10000f210
000000010000ebd7	movb	$0x3c, -0x270(%rbp)
000000010000ebde	leaq	-0x270(%rbp), %rsi
000000010000ebe5	movl	$0x1, %edx
000000010000ebea	movq	%r13, %rdi
000000010000ebed	callq	_buf_put
000000010000ebf2	movq	0x8(%r15), %rbx
000000010000ebf6	movq	%rbx, %rdi
000000010000ebf9	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000ebfe	movq	%r13, %rdi
000000010000ec01	movq	%rbx, %rsi
000000010000ec04	jmp	0x10000f2e0
000000010000ec09	movq	0x4420(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ec10	movq	(%rax), %rax
000000010000ec13	cmpq	-0x30(%rbp), %rax
000000010000ec17	jne	0x10000fd68
000000010000ec1d	leaq	0x3a06(%rip), %rsi              ## literal pool for: "<opaque>"
000000010000ec24	movl	$0x8, %edx
000000010000ec29	movq	%r13, %rdi
000000010000ec2c	jmp	0x10000f9b6
000000010000ec31	leaq	0x8(%r14), %rsi
000000010000ec35	movq	(%r14), %rdx
000000010000ec38	movq	0x43f1(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ec3f	movq	(%rax), %rax
000000010000ec42	testl	%ecx, %ecx
000000010000ec44	je	0x10000f616
000000010000ec4a	cmpq	-0x30(%rbp), %rax
000000010000ec4e	jne	0x10000fd68
000000010000ec54	movq	%r13, %rdi
000000010000ec57	jmp	0x10000f9b6
000000010000ec5c	movq	(%r14), %r9
000000010000ec5f	movq	0x8(%r14), %r8
000000010000ec63	movq	%r9, %rax
000000010000ec66	orq	%r8, %rax
000000010000ec69	je	0x10000f639
000000010000ec6f	xorl	%edi, %edi
000000010000ec71	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000ec7b	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000ec85	movq	%r8, %rbx
000000010000ec88	nopl	(%rax,%rax)
000000010000ec90	movq	%r8, %rcx
000000010000ec93	shldq	$0x3f, %r9, %rcx
000000010000ec98	shrq	%rbx
000000010000ec9b	movq	%rcx, %rsi
000000010000ec9e	addq	%rbx, %rsi
000000010000eca1	adcq	$0x0, %rsi
000000010000eca5	movq	%rsi, %rax
000000010000eca8	mulq	%r10
000000010000ecab	shrq	$0x2, %rdx
000000010000ecaf	leaq	(%rdx,%rdx,4), %rax
000000010000ecb3	subq	%rax, %rsi
000000010000ecb6	subq	%rsi, %rcx
000000010000ecb9	sbbq	$0x0, %rbx
000000010000ecbd	movq	%rcx, %rsi
000000010000ecc0	imulq	%r11, %rsi
000000010000ecc4	movq	%rcx, %rax
000000010000ecc7	mulq	%r10
000000010000ecca	addq	%rsi, %rdx
000000010000eccd	imulq	%r10, %rbx
000000010000ecd1	addq	%rdx, %rbx
000000010000ecd4	movq	%rax, %rcx
000000010000ecd7	addq	%rax, %rcx
000000010000ecda	leaq	(%rcx,%rcx,4), %rcx
000000010000ecde	movl	%r9d, %edx
000000010000ece1	subl	%ecx, %edx
000000010000ece3	orb	$0x30, %dl
000000010000ece6	movb	%dl, -0x70(%rbp,%rdi)
000000010000ecea	incq	%rdi
000000010000eced	cmpq	$0xa, %r9
000000010000ecf1	sbbq	$0x0, %r8
000000010000ecf5	movq	%rax, %r9
000000010000ecf8	movq	%rbx, %r8
000000010000ecfb	jae	0x10000ec90
000000010000ecfd	testl	%edi, %edi
000000010000ecff	jg	0x10000f642
000000010000ed05	jmp	0x10000edb5
000000010000ed0a	movq	(%r14), %r9
000000010000ed0d	movq	0x8(%r14), %r10
000000010000ed11	testq	%r10, %r10
000000010000ed14	js	0x10000f664
000000010000ed1a	movq	%r9, %rax
000000010000ed1d	orq	%r10, %rax
000000010000ed20	je	0x10000f782
000000010000ed26	xorl	%edi, %edi
000000010000ed28	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
000000010000ed32	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000ed3c	movq	%r10, %rbx
000000010000ed3f	nop
000000010000ed40	movq	%r10, %rcx
000000010000ed43	shldq	$0x3f, %r9, %rcx
000000010000ed48	shrq	%rbx
000000010000ed4b	movq	%rcx, %rsi
000000010000ed4e	addq	%rbx, %rsi
000000010000ed51	adcq	$0x0, %rsi
000000010000ed55	movq	%rsi, %rax
000000010000ed58	mulq	%r8
000000010000ed5b	shrq	$0x2, %rdx
000000010000ed5f	leaq	(%rdx,%rdx,4), %rax
000000010000ed63	subq	%rax, %rsi
000000010000ed66	subq	%rsi, %rcx
000000010000ed69	sbbq	$0x0, %rbx
000000010000ed6d	movq	%rcx, %rsi
000000010000ed70	imulq	%r11, %rsi
000000010000ed74	movq	%rcx, %rax
000000010000ed77	mulq	%r8
000000010000ed7a	addq	%rsi, %rdx
000000010000ed7d	imulq	%r8, %rbx
000000010000ed81	addq	%rdx, %rbx
000000010000ed84	movq	%rax, %rcx
000000010000ed87	addq	%rax, %rcx
000000010000ed8a	leaq	(%rcx,%rcx,4), %rcx
000000010000ed8e	movl	%r9d, %edx
000000010000ed91	subl	%ecx, %edx
000000010000ed93	orb	$0x30, %dl
000000010000ed96	movb	%dl, -0x70(%rbp,%rdi)
000000010000ed9a	incq	%rdi
000000010000ed9d	cmpq	$0xa, %r9
000000010000eda1	sbbq	$0x0, %r10
000000010000eda5	movq	%rax, %r9
000000010000eda8	movq	%rbx, %r10
000000010000edab	jae	0x10000ed40
000000010000edad	testl	%edi, %edi
000000010000edaf	jg	0x10000f78b
000000010000edb5	xorl	%eax, %eax
000000010000edb7	jmp	0x10000fbe6
000000010000edbc	movb	$0x5b, -0x270(%rbp)
000000010000edc3	leaq	-0x270(%rbp), %rsi
000000010000edca	movl	$0x1, %edx
000000010000edcf	movq	%r13, %rdi
000000010000edd2	callq	_buf_put
000000010000edd7	testq	%r14, %r14
000000010000edda	je	0x10000fad4
000000010000ede0	movq	0x38(%r15), %rdx
000000010000ede4	movq	0x8(%r14), %rsi
000000010000ede8	movq	%r13, %rdi
000000010000edeb	xorl	%ecx, %ecx
000000010000eded	callq	_fwp_write
000000010000edf2	movq	0x10(%r14), %r14
000000010000edf6	testq	%r14, %r14
000000010000edf9	je	0x10000fad4
000000010000edff	leaq	0x378e(%rip), %rbx              ## literal pool for: ", "
000000010000ee06	nopw	%cs:(%rax,%rax)
000000010000ee10	movl	$0x2, %edx
000000010000ee15	movq	%r13, %rdi
000000010000ee18	movq	%rbx, %rsi
000000010000ee1b	callq	_buf_put
000000010000ee20	movq	0x8(%r14), %rsi
000000010000ee24	movq	0x38(%r15), %rdx
000000010000ee28	movq	%r13, %rdi
000000010000ee2b	xorl	%ecx, %ecx
000000010000ee2d	callq	_fwp_write
000000010000ee32	movq	0x10(%r14), %r14
000000010000ee36	testq	%r14, %r14
000000010000ee39	jne	0x10000ee10
000000010000ee3b	jmp	0x10000fad4
000000010000ee40	movslq	0x48(%r15), %rbx
000000010000ee44	movl	%ebx, %r12d
000000010000ee47	leaq	0x3(%rbx), %rsi
000000010000ee4b	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000ee52	ja	0x10000f74e
000000010000ee58	leaq	0x12(%rbx), %rax
000000010000ee5c	shrq	$0x4, %rax
000000010000ee60	leaq	_fwp_gc(%rip), %rcx
000000010000ee67	movzbl	0xbe8(%rax,%rcx), %edx
000000010000ee6f	movl	0xb48(%rcx,%rdx,4), %eax
000000010000ee76	subq	%rax, _fwp_gc(%rip)
000000010000ee7d	js	0x10000f74e
000000010000ee83	leaq	(%rdx,%rdx,2), %rdx
000000010000ee87	leaq	(%rcx,%rdx,8), %rcx
000000010000ee8b	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000ee92	movq	(%rcx), %r15
000000010000ee95	testq	%r15, %r15
000000010000ee98	je	0x10000f73a
000000010000ee9e	movq	(%r15), %rax
000000010000eea1	notq	%rax
000000010000eea4	movq	%rax, (%rcx)
000000010000eea7	jmp	0x10000f8d2
000000010000eeac	cmpq	$-0x1, %r14
000000010000eeb0	leaq	0x36f1(%rip), %rax              ## literal pool for: "-1"
000000010000eeb7	leaq	0x2b13(%rip), %rcx              ## literal pool for: "0"
000000010000eebe	cmoveq	%rax, %rcx
000000010000eec2	cmpq	$0x1, %r14
000000010000eec6	leaq	0x36d8(%rip), %rbx              ## literal pool for: "+1"
000000010000eecd	cmovneq	%rcx, %rbx
000000010000eed1	movq	%rbx, %rdi
000000010000eed4	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000eed9	movq	0x4150(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000eee0	movq	(%rcx), %rcx
000000010000eee3	cmpq	-0x30(%rbp), %rcx
000000010000eee7	jne	0x10000fd68
000000010000eeed	movq	%r13, %rdi
000000010000eef0	movq	%rbx, %rsi
000000010000eef3	jmp	0x10000f9b3
000000010000eef8	movq	%r15, %r12
000000010000eefb	leaq	0x3742(%rip), %rsi              ## literal pool for: "array["
000000010000ef02	movl	$0x6, %edx
000000010000ef07	movq	%r13, %rdi
000000010000ef0a	callq	_buf_put
000000010000ef0f	movq	(%r14), %rsi
000000010000ef12	leaq	(,%rsi,2), %rax
000000010000ef1a	testq	%rax, %rax
000000010000ef1d	je	0x10000fad4
000000010000ef23	movq	0x38(%r12), %rdx
000000010000ef28	movl	$0x8, %eax
000000010000ef2d	testq	%rdx, %rdx
000000010000ef30	je	0x10000f7ad
000000010000ef36	movl	(%rdx), %ecx
000000010000ef38	cmpq	$0xa, %rcx
000000010000ef3c	movq	-0x278(%rbp), %r13
000000010000ef43	ja	0x10000f7b4
000000010000ef49	leaq	0x2788(%rip), %rax
000000010000ef50	movq	(%rax,%rcx,8), %rax
000000010000ef54	jmp	0x10000f7b4
000000010000ef59	leaq	0x36da(%rip), %rsi              ## literal pool for: "bytes["
000000010000ef60	movl	$0x6, %edx
000000010000ef65	movq	%r13, %rdi
000000010000ef68	callq	_buf_put
000000010000ef6d	cmpq	$0x0, (%r14)
000000010000ef71	movq	%r13, %rbx
000000010000ef74	je	0x10000f021
000000010000ef7a	movzbl	0x8(%r14), %ecx
000000010000ef7f	leaq	0x36bb(%rip), %rdx              ## literal pool for: "%u"
000000010000ef86	leaq	-0x270(%rbp), %r15
000000010000ef8d	movl	$0x200, %esi                    ## imm = 0x200
000000010000ef92	movq	%r15, %rdi
000000010000ef95	xorl	%eax, %eax
000000010000ef97	callq	0x10001128e                     ## symbol stub for: _snprintf
000000010000ef9c	movq	%r15, %rdi
000000010000ef9f	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000efa4	movq	%rbx, %rdi
000000010000efa7	movq	%r15, %rsi
000000010000efaa	movq	%rax, %rdx
000000010000efad	callq	_buf_put
000000010000efb2	cmpq	$0x2, (%r14)
000000010000efb6	jb	0x10000f021
000000010000efb8	movl	$0x9, %r13d
000000010000efbe	leaq	0x367c(%rip), %r15              ## literal pool for: "%u"
000000010000efc5	leaq	-0x270(%rbp), %r12
000000010000efcc	nopl	(%rax)
000000010000efd0	movl	$0x2, %edx
000000010000efd5	movq	%rbx, %rdi
000000010000efd8	leaq	0x35b5(%rip), %rsi              ## literal pool for: ", "
000000010000efdf	callq	_buf_put
000000010000efe4	movzbl	(%r14,%r13), %ecx
000000010000efe9	movl	$0x200, %esi                    ## imm = 0x200
000000010000efee	movq	%r12, %rdi
000000010000eff1	movq	%r15, %rdx
000000010000eff4	xorl	%eax, %eax
000000010000eff6	callq	0x10001128e                     ## symbol stub for: _snprintf
000000010000effb	movq	%r12, %rdi
000000010000effe	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000f003	movq	%rbx, %rdi
000000010000f006	movq	%r12, %rsi
000000010000f009	movq	%rax, %rdx
000000010000f00c	callq	_buf_put
000000010000f011	leaq	0x1(%r13), %rax
000000010000f015	addq	$-0x7, %r13
000000010000f019	cmpq	(%r14), %r13
000000010000f01c	movq	%rax, %r13
000000010000f01f	jb	0x10000efd0
000000010000f021	movb	$0x5d, -0x70(%rbp)
000000010000f025	leaq	-0x70(%rbp), %rsi
000000010000f029	movl	$0x1, %edx
000000010000f02e	movq	%rbx, %rdi
000000010000f031	jmp	0x10000fc06
000000010000f036	movd	%r14d, %xmm1
000000010000f03b	ucomiss	%xmm1, %xmm1
000000010000f03e	jp	0x10000fd6d
000000010000f044	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
000000010000f04b	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
000000010000f052	je	0x10000f48a
000000010000f058	cvtss2sd	%xmm1, %xmm0
000000010000f05c	leaq	-0x270(%rbp), %rbx
000000010000f063	movq	%rbx, %rdi
000000010000f066	movsd	%xmm0, -0x280(%rbp)
000000010000f06e	movl	$0x1, %esi
000000010000f073	movss	%xmm1, -0x278(%rbp)
000000010000f07b	callq	_fwp_format_g
000000010000f080	movq	%rbx, %rdi
000000010000f083	xorl	%esi, %esi
000000010000f085	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f08a	ucomiss	-0x278(%rbp), %xmm0
000000010000f091	jne	0x10000f099
000000010000f093	jnp	0x10000f209
000000010000f099	movq	%rbx, %rdi
000000010000f09c	movsd	-0x280(%rbp), %xmm0
000000010000f0a4	movl	$0x2, %esi
000000010000f0a9	callq	_fwp_format_g
000000010000f0ae	movq	%rbx, %rdi
000000010000f0b1	xorl	%esi, %esi
000000010000f0b3	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f0b8	ucomiss	-0x278(%rbp), %xmm0
000000010000f0bf	jne	0x10000f0c7
000000010000f0c1	jnp	0x10000f209
000000010000f0c7	movq	%rbx, %rdi
000000010000f0ca	movsd	-0x280(%rbp), %xmm0
000000010000f0d2	movl	$0x3, %esi
000000010000f0d7	callq	_fwp_format_g
000000010000f0dc	movq	%rbx, %rdi
000000010000f0df	xorl	%esi, %esi
000000010000f0e1	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f0e6	ucomiss	-0x278(%rbp), %xmm0
000000010000f0ed	jne	0x10000f0f5
000000010000f0ef	jnp	0x10000f209
000000010000f0f5	movq	%rbx, %rdi
000000010000f0f8	movsd	-0x280(%rbp), %xmm0
000000010000f100	movl	$0x4, %esi
000000010000f105	callq	_fwp_format_g
000000010000f10a	movq	%rbx, %rdi
000000010000f10d	xorl	%esi, %esi
000000010000f10f	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f114	ucomiss	-0x278(%rbp), %xmm0
000000010000f11b	jne	0x10000f123
000000010000f11d	jnp	0x10000f209
000000010000f123	movq	%rbx, %rdi
000000010000f126	movsd	-0x280(%rbp), %xmm0
000000010000f12e	movl	$0x5, %esi
000000010000f133	callq	_fwp_format_g
000000010000f138	movq	%rbx, %rdi
000000010000f13b	xorl	%esi, %esi
000000010000f13d	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f142	ucomiss	-0x278(%rbp), %xmm0
000000010000f149	jne	0x10000f151
000000010000f14b	jnp	0x10000f209
000000010000f151	movq	%rbx, %rdi
000000010000f154	movsd	-0x280(%rbp), %xmm0
000000010000f15c	movl	$0x6, %esi
000000010000f161	callq	_fwp_format_g
000000010000f166	movq	%rbx, %rdi
000000010000f169	xorl	%esi, %esi
000000010000f16b	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f170	ucomiss	-0x278(%rbp), %xmm0
000000010000f177	jne	0x10000f17f
000000010000f179	jnp	0x10000f209
000000010000f17f	movq	%rbx, %rdi
000000010000f182	movsd	-0x280(%rbp), %xmm0
000000010000f18a	movl	$0x7, %esi
000000010000f18f	callq	_fwp_format_g
000000010000f194	movq	%rbx, %rdi
000000010000f197	xorl	%esi, %esi
000000010000f199	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f19e	ucomiss	-0x278(%rbp), %xmm0
000000010000f1a5	jne	0x10000f1a9
000000010000f1a7	jnp	0x10000f209
000000010000f1a9	movq	%rbx, %rdi
000000010000f1ac	movsd	-0x280(%rbp), %xmm0
000000010000f1b4	movl	$0x8, %esi
000000010000f1b9	callq	_fwp_format_g
000000010000f1be	movq	%rbx, %rdi
000000010000f1c1	xorl	%esi, %esi
000000010000f1c3	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f1c8	movss	-0x278(%rbp), %xmm1
000000010000f1d0	ucomiss	%xmm1, %xmm0
000000010000f1d3	jne	0x10000f1d7
000000010000f1d5	jnp	0x10000f209
000000010000f1d7	movq	%rbx, %rdi
000000010000f1da	movsd	-0x280(%rbp), %xmm0
000000010000f1e2	movl	$0x9, %esi
000000010000f1e7	callq	_fwp_format_g
000000010000f1ec	movq	%rbx, %rdi
000000010000f1ef	xorl	%esi, %esi
000000010000f1f1	callq	0x1000112be                     ## symbol stub for: _strtof
000000010000f1f6	ucomiss	-0x278(%rbp), %xmm0
000000010000f1fd	jne	0x10000fd53
000000010000f203	jp	0x10000fd53
000000010000f209	leaq	-0x270(%rbp), %rdi
000000010000f210	movl	$0x2e, %esi
000000010000f215	callq	0x10001129a                     ## symbol stub for: _strchr
000000010000f21a	testq	%rax, %rax
000000010000f21d	jne	0x10000fbee
000000010000f223	leaq	-0x270(%rbp), %rdi
000000010000f22a	movl	$0x65, %esi
000000010000f22f	callq	0x10001129a                     ## symbol stub for: _strchr
000000010000f234	testq	%rax, %rax
000000010000f237	jne	0x10000fbee
000000010000f23d	leaq	0x339f(%rip), %rsi              ## literal pool for: "inf"
000000010000f244	leaq	-0x270(%rbp), %rdi
000000010000f24b	callq	0x1000112b2                     ## symbol stub for: _strstr
000000010000f250	testq	%rax, %rax
000000010000f253	jne	0x10000fbee
000000010000f259	leaq	0x338c(%rip), %rsi              ## literal pool for: "NaN"
000000010000f260	leaq	-0x270(%rbp), %rdi
000000010000f267	callq	0x1000112b2                     ## symbol stub for: _strstr
000000010000f26c	testq	%rax, %rax
000000010000f26f	jne	0x10000fbee
000000010000f275	leaq	0x33f7(%rip), %rsi              ## literal pool for: ".0"
000000010000f27c	leaq	-0x270(%rbp), %rdi
000000010000f283	movl	$0x200, %edx                    ## imm = 0x200
000000010000f288	callq	0x100011186                     ## symbol stub for: ___strcat_chk
000000010000f28d	jmp	0x10000fbee
000000010000f292	movq	0x3d97(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000f299	movq	(%rax), %rax
000000010000f29c	cmpq	-0x30(%rbp), %rax
000000010000f2a0	jne	0x10000fd68
000000010000f2a6	leaq	0x3372(%rip), %rsi              ## literal pool for: "<function>"
000000010000f2ad	movl	$0xa, %edx
000000010000f2b2	movq	%r13, %rdi
000000010000f2b5	jmp	0x10000f9b6
000000010000f2ba	leaq	0x3372(%rip), %rsi              ## literal pool for: "<file "
000000010000f2c1	movl	$0x6, %edx
000000010000f2c6	movq	%r13, %rdi
000000010000f2c9	callq	_buf_put
000000010000f2ce	addq	$0x10, %r14
000000010000f2d2	movq	%r14, %rdi
000000010000f2d5	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000f2da	movq	%r13, %rdi
000000010000f2dd	movq	%r14, %rsi
000000010000f2e0	movq	%rax, %rdx
000000010000f2e3	callq	_buf_put
000000010000f2e8	movb	$0x3e, -0x270(%rbp)
000000010000f2ef	jmp	0x10000fadb
000000010000f2f4	movl	(%r14), %eax
000000010000f2f7	movq	0x18(%r15), %rcx
000000010000f2fb	movl	%eax, %r12d
000000010000f2fe	movq	(%rcx,%r12,8), %rbx
000000010000f302	movq	%rbx, %rdi
000000010000f305	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000f30a	movq	%r13, %rdi
000000010000f30d	movq	%rbx, %rsi
000000010000f310	movq	%rax, %rdx
000000010000f313	callq	_buf_put
000000010000f318	movq	0x28(%r15), %rax
000000010000f31c	cmpl	$0x0, (%rax,%r12,4)
000000010000f321	jle	0x10000fc0b
000000010000f327	movq	%r12, %rcx
000000010000f32a	xorl	%r12d, %r12d
000000010000f32d	movq	%r15, -0x280(%rbp)
000000010000f334	movq	%rcx, -0x290(%rbp)
000000010000f33b	movq	%r14, -0x288(%rbp)
000000010000f342	jmp	0x10000f389
000000010000f344	nopw	%cs:(%rax,%rax)
000000010000f350	movq	-0x278(%rbp), %r13
000000010000f357	movq	%r13, %rdi
000000010000f35a	movq	%r15, %rsi
000000010000f35d	movq	%rbx, %rdx
000000010000f360	xorl	%ecx, %ecx
000000010000f362	callq	_fwp_write
000000010000f367	incq	%r12
000000010000f36a	movq	-0x280(%rbp), %r15
000000010000f371	movq	0x28(%r15), %rax
000000010000f375	movq	-0x290(%rbp), %rcx
000000010000f37c	movslq	(%rax,%rcx,4), %rax
000000010000f380	cmpq	%rax, %r12
000000010000f383	jge	0x10000fc0b
000000010000f389	movq	%r15, %rax
000000010000f38c	movq	0x8(%r14,%r12,8), %r15
000000010000f391	movq	0x30(%rax), %rax
000000010000f395	movq	(%rax,%rcx,8), %rax
000000010000f399	movq	(%rax,%r12,8), %rbx
000000010000f39d	movb	$0x20, -0x270(%rbp)
000000010000f3a4	movl	$0x1, %edx
000000010000f3a9	movq	%r13, %rdi
000000010000f3ac	leaq	-0x270(%rbp), %rsi
000000010000f3b3	callq	_buf_put
000000010000f3b8	movl	(%rbx), %eax
000000010000f3ba	cmpq	$0x10, %rax
000000010000f3be	ja	0x10000f350
000000010000f3c0	leaq	0xa1d(%rip), %rcx
000000010000f3c7	movslq	(%rcx,%rax,4), %rax
000000010000f3cb	addq	%rcx, %rax
000000010000f3ce	jmpq	*%rax
000000010000f3d0	movq	%r15, %rcx
000000010000f3d3	shrq	$0x3f, %rcx
000000010000f3d7	testl	%ecx, %ecx
000000010000f3d9	je	0x10000f350
000000010000f3df	movb	$0x28, -0x270(%rbp)
000000010000f3e6	movl	$0x1, %edx
000000010000f3eb	movq	-0x278(%rbp), %r13
000000010000f3f2	movq	%r13, %rdi
000000010000f3f5	leaq	-0x270(%rbp), %r14
000000010000f3fc	movq	%r14, %rsi
000000010000f3ff	callq	_buf_put
000000010000f404	movq	%r13, %rdi
000000010000f407	movq	%r15, %rsi
000000010000f40a	movq	%rbx, %rdx
000000010000f40d	xorl	%ecx, %ecx
000000010000f40f	callq	_fwp_write
000000010000f414	movb	$0x29, -0x270(%rbp)
000000010000f41b	movl	$0x1, %edx
000000010000f420	movq	%r13, %rdi
000000010000f423	movq	%r14, %rsi
000000010000f426	movq	-0x288(%rbp), %r14
000000010000f42d	callq	_buf_put
000000010000f432	jmp	0x10000f367
000000010000f437	xorl	%ecx, %ecx
000000010000f439	cmpq	$0x1000, %r15                   ## imm = 0x1000
000000010000f440	setae	%cl
000000010000f443	jmp	0x10000f3d7
000000010000f445	movq	0x8(%r15), %rcx
000000010000f449	jmp	0x10000f3d3
000000010000f44b	movl	%r15d, %ecx
000000010000f44e	shrl	$0x1f, %ecx
000000010000f451	jmp	0x10000f3d7
000000010000f453	movq	0x8(%rbx), %rdi
000000010000f457	testq	%rdi, %rdi
000000010000f45a	je	0x10000f350
000000010000f460	leaq	0x3156(%rip), %rsi              ## literal pool for: "Duration"
000000010000f467	callq	0x1000112a0                     ## symbol stub for: _strcmp
000000010000f46c	xorl	%ecx, %ecx
000000010000f46e	testl	%eax, %eax
000000010000f470	setne	%cl
000000010000f473	jmp	0x10000f3d7
000000010000f478	xorpd	%xmm0, %xmm0
000000010000f47c	movsd	-0x278(%rbp), %xmm1
000000010000f484	ucomisd	%xmm0, %xmm1
000000010000f488	jmp	0x10000f490
000000010000f48a	xorps	%xmm0, %xmm0
000000010000f48d	ucomiss	%xmm0, %xmm1
000000010000f490	leaq	0x314c(%rip), %rax              ## literal pool for: "inf"
000000010000f497	leaq	0x3149(%rip), %rsi              ## literal pool for: "-inf"
000000010000f49e	cmovaq	%rax, %rsi
000000010000f4a2	leaq	-0x270(%rbp), %rdi
000000010000f4a9	movl	$0x200, %edx                    ## imm = 0x200
000000010000f4ae	callq	0x10001118c                     ## symbol stub for: ___strcpy_chk
000000010000f4b3	jmp	0x10000fbee
000000010000f4b8	cmpl	$0x0, 0x10(%r15)
000000010000f4bd	je	0x10000faef
000000010000f4c3	movq	%r15, %rax
000000010000f4c6	addq	$0x10, %r15
000000010000f4ca	movq	%rax, -0x280(%rbp)
000000010000f4d1	cmpl	$0x0, 0x48(%rax)
000000010000f4d5	setne	%r12b
000000010000f4d9	testb	%r12b, %r12b
000000010000f4dc	movl	$0x28, %eax
000000010000f4e1	movl	$0x7b, %ecx
000000010000f4e6	cmovnel	%eax, %ecx
000000010000f4e9	movb	%cl, -0x270(%rbp)
000000010000f4ef	leaq	-0x270(%rbp), %rsi
000000010000f4f6	movl	$0x1, %edx
000000010000f4fb	movq	%r13, %rdi
000000010000f4fe	callq	_buf_put
000000010000f503	cmpl	$0x0, (%r15)
000000010000f507	movq	-0x280(%rbp), %r15
000000010000f50e	jle	0x10000f5fb
000000010000f514	testb	%r12b, %r12b
000000010000f517	jne	0x10000f54a
000000010000f519	movq	0x18(%r15), %rax
000000010000f51d	movq	(%rax), %rbx
000000010000f520	movq	%rbx, %rdi
000000010000f523	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000f528	movq	%r13, %rdi
000000010000f52b	movq	%rbx, %rsi
000000010000f52e	movq	%rax, %rdx
000000010000f531	callq	_buf_put
000000010000f536	leaq	0x311e(%rip), %rsi              ## literal pool for: " = "
000000010000f53d	movl	$0x3, %edx
000000010000f542	movq	%r13, %rdi
000000010000f545	callq	_buf_put
000000010000f54a	movq	0x8(%r14), %rsi
000000010000f54e	movq	0x20(%r15), %rax
000000010000f552	movq	(%rax), %rdx
000000010000f555	movq	%r13, %rdi
000000010000f558	xorl	%ecx, %ecx
000000010000f55a	callq	_fwp_write
000000010000f55f	cmpl	$0x2, 0x10(%r15)
000000010000f564	jl	0x10000f5fb
000000010000f56a	movl	$0x1, %ebx
000000010000f56f	jmp	0x10000f5a3
000000010000f571	nopw	%cs:(%rax,%rax)
000000010000f580	movq	0x8(%r14,%rbx,8), %rsi
000000010000f585	movq	0x20(%r15), %rax
000000010000f589	movq	(%rax,%rbx,8), %rdx
000000010000f58d	movq	%r13, %rdi
000000010000f590	xorl	%ecx, %ecx
000000010000f592	callq	_fwp_write
000000010000f597	incq	%rbx
000000010000f59a	movslq	0x10(%r15), %rax
000000010000f59e	cmpq	%rax, %rbx
000000010000f5a1	jge	0x10000f5fb
000000010000f5a3	movl	$0x2, %edx
000000010000f5a8	movq	%r13, %rdi
000000010000f5ab	leaq	0x2fe2(%rip), %rsi              ## literal pool for: ", "
000000010000f5b2	callq	_buf_put
000000010000f5b7	testb	%r12b, %r12b
000000010000f5ba	jne	0x10000f580
000000010000f5bc	movq	0x18(%r15), %rax
000000010000f5c0	movq	(%rax,%rbx,8), %r13
000000010000f5c4	movq	%r13, %rdi
000000010000f5c7	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000f5cc	movq	-0x278(%rbp), %rdi
000000010000f5d3	movq	%r13, %rsi
000000010000f5d6	movq	-0x278(%rbp), %r13
000000010000f5dd	movq	%rax, %rdx
000000010000f5e0	callq	_buf_put
000000010000f5e5	movl	$0x3, %edx
000000010000f5ea	movq	%r13, %rdi
000000010000f5ed	leaq	0x3067(%rip), %rsi              ## literal pool for: " = "
000000010000f5f4	callq	_buf_put
000000010000f5f9	jmp	0x10000f580
000000010000f5fb	testb	%r12b, %r12b
000000010000f5fe	movl	$0x29, %eax
000000010000f603	movl	$0x7d, %ecx
000000010000f608	cmovnel	%eax, %ecx
000000010000f60b	movb	%cl, -0x270(%rbp)
000000010000f611	jmp	0x10000fadb
000000010000f616	cmpq	-0x30(%rbp), %rax
000000010000f61a	jne	0x10000fd68
000000010000f620	movq	%r13, %rdi
000000010000f623	addq	$0x268, %rsp                    ## imm = 0x268
000000010000f62a	popq	%rbx
000000010000f62b	popq	%r12
000000010000f62d	popq	%r13
000000010000f62f	popq	%r14
000000010000f631	popq	%r15
000000010000f633	popq	%rbp
000000010000f634	jmp	_fwp_escape
000000010000f639	movb	$0x30, -0x70(%rbp)
000000010000f63d	movl	$0x1, %edi
000000010000f642	movl	%edi, %eax
000000010000f644	cmpq	$0x8, %rax
000000010000f648	jae	0x10000f654
000000010000f64a	xorl	%ecx, %ecx
000000010000f64c	movq	%rax, %rdx
000000010000f64f	jmp	0x10000f8a5
000000010000f654	cmpl	$0x20, %eax
000000010000f657	jae	0x10000f7f1
000000010000f65d	xorl	%ecx, %ecx
000000010000f65f	jmp	0x10000f84f
000000010000f664	movb	$0x2d, -0x270(%rbp)
000000010000f66b	xorl	%r8d, %r8d
000000010000f66e	negq	%r9
000000010000f671	movl	$0x0, %r11d
000000010000f677	sbbq	%r10, %r11
000000010000f67a	movl	$0x1, %r15d
000000010000f680	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000f68a	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000f694	movq	%r11, %r14
000000010000f697	nopw	(%rax,%rax)
000000010000f6a0	movq	%r11, %rcx
000000010000f6a3	shldq	$0x3f, %r9, %rcx
000000010000f6a8	shrq	%r14
000000010000f6ab	movq	%rcx, %rsi
000000010000f6ae	addq	%r14, %rsi
000000010000f6b1	adcq	$0x0, %rsi
000000010000f6b5	movq	%rsi, %rax
000000010000f6b8	mulq	%r10
000000010000f6bb	movl	%r15d, %edi
000000010000f6be	shrq	$0x2, %rdx
000000010000f6c2	leaq	(%rdx,%rdx,4), %rax
000000010000f6c6	subq	%rax, %rsi
000000010000f6c9	subq	%rsi, %rcx
000000010000f6cc	sbbq	$0x0, %r14
000000010000f6d0	movq	%rcx, %rsi
000000010000f6d3	movq	%rcx, %rax
000000010000f6d6	mulq	%r10
000000010000f6d9	imulq	%rbx, %rsi
000000010000f6dd	addq	%rsi, %rdx
000000010000f6e0	imulq	%r10, %r14
000000010000f6e4	addq	%rdx, %r14
000000010000f6e7	movq	%rax, %rcx
000000010000f6ea	addq	%rax, %rcx
000000010000f6ed	leaq	(%rcx,%rcx,4), %rcx
000000010000f6f1	movl	%r9d, %edx
000000010000f6f4	subl	%ecx, %edx
000000010000f6f6	orb	$0x30, %dl
000000010000f6f9	movb	%dl, -0x70(%rbp,%r8)
000000010000f6fe	incq	%r8
000000010000f701	leal	0x1(%rdi), %r15d
000000010000f705	cmpq	$0xa, %r9
000000010000f709	sbbq	$0x0, %r11
000000010000f70d	movq	%rax, %r9
000000010000f710	movq	%r14, %r11
000000010000f713	jae	0x10000f6a0
000000010000f715	testl	%r8d, %r8d
000000010000f718	jle	0x10000fb17
000000010000f71e	movl	%r8d, %eax
000000010000f721	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
000000010000f726	cmpq	$0x8, %rax
000000010000f72a	jae	0x10000fc31
000000010000f730	xorl	%ecx, %ecx
000000010000f732	movq	%rax, %rdx
000000010000f735	jmp	0x10000fd14
000000010000f73a	movq	0x8(%rcx), %r15
000000010000f73e	movq	0x10(%rcx), %rdx
000000010000f742	subq	%r15, %rdx
000000010000f745	cmpq	%rax, %rdx
000000010000f748	jae	0x10000f8cb
000000010000f74e	movq	%rsi, %rdi
000000010000f751	movl	$0x1, %esi
000000010000f756	callq	_fwp_gc_alloc_slow
000000010000f75b	movq	%rax, %r15
000000010000f75e	jmp	0x10000f8da
000000010000f763	movq	0x8(%r14), %rsi
000000010000f767	movq	%rsi, %rdx
000000010000f76a	sarq	$0x3f, %rdx
000000010000f76e	leaq	-0x270(%rbp), %rbx
000000010000f775	movq	%rbx, %rdi
000000010000f778	callq	_fwp_fmt_duration
000000010000f77d	jmp	0x10000fbf5
000000010000f782	movb	$0x30, -0x70(%rbp)
000000010000f786	movl	$0x1, %edi
000000010000f78b	movl	%edi, %eax
000000010000f78d	cmpq	$0x8, %rax
000000010000f791	jae	0x10000f79d
000000010000f793	xorl	%ecx, %ecx
000000010000f795	movq	%rax, %rdx
000000010000f798	jmp	0x10000fbc3
000000010000f79d	cmpl	$0x20, %eax
000000010000f7a0	jae	0x10000fb26
000000010000f7a6	xorl	%ecx, %ecx
000000010000f7a8	jmp	0x10000fb7e
000000010000f7ad	movq	-0x278(%rbp), %r13
000000010000f7b4	leaq	0x8(%r14), %rbx
000000010000f7b8	movq	%rbx, %rcx
000000010000f7bb	testq	%rsi, %rsi
000000010000f7be	jns	0x10000f7c4
000000010000f7c0	movq	0x10(%r14), %rcx
000000010000f7c4	cmpq	$0x1, %rax
000000010000f7c8	je	0x10000f9d1
000000010000f7ce	cmpq	$0x8, %rax
000000010000f7d2	je	0x10000f9cc
000000010000f7d8	cmpq	$0x2, %rax
000000010000f7dc	jne	0x10000f9dd
000000010000f7e2	cmpl	$0x1, (%rdx)
000000010000f7e5	movzwl	(%rcx), %eax
000000010000f7e8	movswq	%ax, %rsi
000000010000f7ec	jmp	0x10000f9e5
000000010000f7f1	movl	%edi, %edx
000000010000f7f3	andl	$0x1f, %edx
000000010000f7f6	movq	%rax, %rcx
000000010000f7f9	subq	%rdx, %rcx
000000010000f7fc	leaq	-0x260(%rbp), %rsi
000000010000f803	movdqa	0x1bf5(%rip), %xmm0
000000010000f80b	movq	%rax, %r8
000000010000f80e	nop
000000010000f810	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000f81a	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000f821	pshufb	%xmm0, %xmm2
000000010000f826	pshufb	%xmm0, %xmm1
000000010000f82b	movdqa	%xmm2, -0x10(%rsi)
000000010000f830	movdqa	%xmm1, (%rsi)
000000010000f834	addq	$-0x20, %r8
000000010000f838	addq	$0x20, %rsi
000000010000f83c	cmpq	%r8, %rdx
000000010000f83f	jne	0x10000f810
000000010000f841	testq	%rdx, %rdx
000000010000f844	je	0x10000fbe6
000000010000f84a	cmpl	$0x7, %edx
000000010000f84d	jbe	0x10000f8a5
000000010000f84f	movl	%edi, %edx
000000010000f851	andl	$0x7, %edx
000000010000f854	movq	%rax, %rsi
000000010000f857	subq	%rcx, %rsi
000000010000f85a	leaq	(%rcx,%rbp), %rdi
000000010000f85e	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000f865	movq	%rax, %rcx
000000010000f868	subq	%rdx, %rcx
000000010000f86b	movq	0x1b9d(%rip), %xmm0
000000010000f873	nopw	%cs:(%rax,%rax)
000000010000f880	movq	-0x78(%rbp,%rsi), %xmm1
000000010000f886	pshufb	%xmm0, %xmm1
000000010000f88b	movq	%xmm1, (%rdi)
000000010000f88f	addq	$-0x8, %rsi
000000010000f893	addq	$0x8, %rdi
000000010000f897	cmpq	%rsi, %rdx
000000010000f89a	jne	0x10000f880
000000010000f89c	testq	%rdx, %rdx
000000010000f89f	je	0x10000fbe6
000000010000f8a5	leaq	-0x70(%rbp), %rsi
000000010000f8a9	addq	%rsi, %rdx
000000010000f8ac	decq	%rdx
000000010000f8af	nop
000000010000f8b0	movzbl	(%rdx), %esi
000000010000f8b3	movb	%sil, -0x270(%rbp,%rcx)
000000010000f8bb	incq	%rcx
000000010000f8be	decq	%rdx
000000010000f8c1	cmpq	%rcx, %rax
000000010000f8c4	jne	0x10000f8b0
000000010000f8c6	jmp	0x10000fbe6
000000010000f8cb	addq	%r15, %rax
000000010000f8ce	movq	%rax, 0x8(%rcx)
000000010000f8d2	movq	%r15, %rdi
000000010000f8d5	callq	0x10001116e                     ## symbol stub for: ___bzero
000000010000f8da	movw	$0x7430, (%r15)                 ## imm = 0x7430
000000010000f8e0	testl	%r12d, %r12d
000000010000f8e3	jle	0x10000f98b
000000010000f8e9	movq	%rbx, %rcx
000000010000f8ec	negq	%rcx
000000010000f8ef	leaq	(%r12,%r15), %rsi
000000010000f8f3	incq	%rsi
000000010000f8f6	xorl	%edi, %edi
000000010000f8f8	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
000000010000f902	jmp	0x10000f93c
000000010000f904	nopw	%cs:(%rax,%rax)
000000010000f910	movb	$0x30, %r10b
000000010000f913	movb	%r10b, (%rsi,%rdi)
000000010000f917	testq	%rdx, %rdx
000000010000f91a	setne	%dl
000000010000f91d	testq	%r14, %r14
000000010000f920	sets	%r10b
000000010000f924	andb	%dl, %r10b
000000010000f927	movzbl	%r10b, %edx
000000010000f92b	subq	%rdx, %rax
000000010000f92e	addq	%r9, %rax
000000010000f931	decq	%rdi
000000010000f934	movq	%rax, %r14
000000010000f937	cmpq	%rdi, %rcx
000000010000f93a	je	0x10000f98b
000000010000f93c	movq	%r14, %rax
000000010000f93f	imulq	%r8
000000010000f942	movq	%rdx, %rax
000000010000f945	shrq	$0x3f, %rax
000000010000f949	addq	%rdx, %rax
000000010000f94c	leaq	(%rax,%rax,2), %r9
000000010000f950	movq	%r14, %rdx
000000010000f953	subq	%r9, %rdx
000000010000f956	negq	%r9
000000010000f959	addq	%r14, %r9
000000010000f95c	addq	$0x3, %r9
000000010000f960	cmpq	$-0x3, %rdx
000000010000f964	cmovbq	%rdx, %r9
000000010000f968	testq	%r9, %r9
000000010000f96b	je	0x10000f910
000000010000f96d	cmpq	$0x1, %r9
000000010000f971	jne	0x10000f980
000000010000f973	movb	$0x2b, %r10b
000000010000f976	xorl	%r9d, %r9d
000000010000f979	jmp	0x10000f913
000000010000f97b	nopl	(%rax,%rax)
000000010000f980	movb	$0x2d, %r10b
000000010000f983	movl	$0x1, %r9d
000000010000f989	jmp	0x10000f913
000000010000f98b	movb	$0x0, 0x2(%r15,%rbx)
000000010000f991	movq	%r15, %rdi
000000010000f994	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000f999	movq	0x3690(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000f9a0	movq	(%rcx), %rcx
000000010000f9a3	cmpq	-0x30(%rbp), %rcx
000000010000f9a7	jne	0x10000fd68
000000010000f9ad	movq	%r13, %rdi
000000010000f9b0	movq	%r15, %rsi
000000010000f9b3	movq	%rax, %rdx
000000010000f9b6	addq	$0x268, %rsp                    ## imm = 0x268
000000010000f9bd	popq	%rbx
000000010000f9be	popq	%r12
000000010000f9c0	popq	%r13
000000010000f9c2	popq	%r14
000000010000f9c4	popq	%r15
000000010000f9c6	popq	%rbp
000000010000f9c7	jmp	_buf_put
000000010000f9cc	movq	(%rcx), %rsi
000000010000f9cf	jmp	0x10000f9e9
000000010000f9d1	cmpl	$0x0, (%rdx)
000000010000f9d4	movzbl	(%rcx), %eax
000000010000f9d7	movsbq	%al, %rsi
000000010000f9db	jmp	0x10000f9e5
000000010000f9dd	cmpl	$0x2, (%rdx)
000000010000f9e0	movl	(%rcx), %eax
000000010000f9e2	movslq	%eax, %rsi
000000010000f9e5	cmovneq	%rax, %rsi
000000010000f9e9	movq	%r13, %rdi
000000010000f9ec	xorl	%ecx, %ecx
000000010000f9ee	callq	_fwp_write
000000010000f9f3	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000f9fd	decq	%rax
000000010000fa00	testq	%rax, (%r14)
000000010000fa03	je	0x10000fad4
000000010000fa09	movl	$0x1, %r15d
000000010000fa0f	jmp	0x10000fa4d
000000010000fa11	cmpl	$0x1, (%rdx)
000000010000fa14	movzwl	(%rcx,%rsi), %eax
000000010000fa18	movswq	%ax, %rsi
000000010000fa1c	cmovneq	%rax, %rsi
000000010000fa20	movq	-0x278(%rbp), %r13
000000010000fa27	movq	%r13, %rdi
000000010000fa2a	xorl	%ecx, %ecx
000000010000fa2c	callq	_fwp_write
000000010000fa31	incq	%r15
000000010000fa34	movq	(%r14), %rax
000000010000fa37	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000fa41	andq	%rcx, %rax
000000010000fa44	cmpq	%rax, %r15
000000010000fa47	jae	0x10000fad4
000000010000fa4d	movl	$0x2, %edx
000000010000fa52	movq	%r13, %rdi
000000010000fa55	leaq	0x2b38(%rip), %rsi              ## literal pool for: ", "
000000010000fa5c	callq	_buf_put
000000010000fa61	movq	0x38(%r12), %rdx
000000010000fa66	movl	$0x8, %eax
000000010000fa6b	testq	%rdx, %rdx
000000010000fa6e	je	0x10000fa83
000000010000fa70	movl	(%rdx), %ecx
000000010000fa72	cmpq	$0xa, %rcx
000000010000fa76	ja	0x10000fa83
000000010000fa78	leaq	0x1c59(%rip), %rax
000000010000fa7f	movq	(%rax,%rcx,8), %rax
000000010000fa83	cmpq	$0x0, (%r14)
000000010000fa87	movq	%rbx, %rcx
000000010000fa8a	jns	0x10000fa90
000000010000fa8c	movq	0x10(%r14), %rcx
000000010000fa90	movq	%rax, %rsi
000000010000fa93	imulq	%r15, %rsi
000000010000fa97	cmpq	$0x1, %rax
000000010000fa9b	je	0x10000fab6
000000010000fa9d	cmpq	$0x2, %rax
000000010000faa1	je	0x10000fa11
000000010000faa7	cmpq	$0x8, %rax
000000010000faab	jne	0x10000fac6
000000010000faad	movq	(%rcx,%rsi), %rsi
000000010000fab1	jmp	0x10000fa20
000000010000fab6	cmpl	$0x0, (%rdx)
000000010000fab9	movzbl	(%rcx,%rsi), %eax
000000010000fabd	movsbq	%al, %rsi
000000010000fac1	jmp	0x10000fa1c
000000010000fac6	cmpl	$0x2, (%rdx)
000000010000fac9	movl	(%rcx,%rsi), %eax
000000010000facc	movslq	%eax, %rsi
000000010000facf	jmp	0x10000fa1c
000000010000fad4	movb	$0x5d, -0x270(%rbp)
000000010000fadb	leaq	-0x270(%rbp), %rsi
000000010000fae2	movl	$0x1, %edx
000000010000fae7	movq	%r13, %rdi
000000010000faea	jmp	0x10000fc06
000000010000faef	movq	0x353a(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000faf6	movq	(%rax), %rax
000000010000faf9	cmpq	-0x30(%rbp), %rax
000000010000fafd	jne	0x10000fd68
000000010000fb03	leaq	0x2b4e(%rip), %rsi              ## literal pool for: "()"
000000010000fb0a	movl	$0x2, %edx
000000010000fb0f	movq	%r13, %rdi
000000010000fb12	jmp	0x10000f9b6
000000010000fb17	xorl	%eax, %eax
000000010000fb19	movb	$0x0, -0x26f(%rbp,%rax)
000000010000fb21	jmp	0x10000fbee
000000010000fb26	movl	%edi, %edx
000000010000fb28	andl	$0x1f, %edx
000000010000fb2b	movq	%rax, %rcx
000000010000fb2e	subq	%rdx, %rcx
000000010000fb31	leaq	-0x260(%rbp), %rsi
000000010000fb38	movdqa	0x18c0(%rip), %xmm0
000000010000fb40	movq	%rax, %r8
000000010000fb43	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000fb4d	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000fb54	pshufb	%xmm0, %xmm2
000000010000fb59	pshufb	%xmm0, %xmm1
000000010000fb5e	movdqa	%xmm2, -0x10(%rsi)
000000010000fb63	movdqa	%xmm1, (%rsi)
000000010000fb67	addq	$-0x20, %r8
000000010000fb6b	addq	$0x20, %rsi
000000010000fb6f	cmpq	%r8, %rdx
000000010000fb72	jne	0x10000fb43
000000010000fb74	testq	%rdx, %rdx
000000010000fb77	je	0x10000fbe6
000000010000fb79	cmpl	$0x7, %edx
000000010000fb7c	jbe	0x10000fbc3
000000010000fb7e	movl	%edi, %edx
000000010000fb80	andl	$0x7, %edx
000000010000fb83	movq	%rax, %rsi
000000010000fb86	subq	%rcx, %rsi
000000010000fb89	leaq	(%rcx,%rbp), %rdi
000000010000fb8d	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000fb94	movq	%rax, %rcx
000000010000fb97	subq	%rdx, %rcx
000000010000fb9a	movq	0x186e(%rip), %xmm0
000000010000fba2	movq	-0x78(%rbp,%rsi), %xmm1
000000010000fba8	pshufb	%xmm0, %xmm1
000000010000fbad	movq	%xmm1, (%rdi)
000000010000fbb1	addq	$-0x8, %rsi
000000010000fbb5	addq	$0x8, %rdi
000000010000fbb9	cmpq	%rsi, %rdx
000000010000fbbc	jne	0x10000fba2
000000010000fbbe	testq	%rdx, %rdx
000000010000fbc1	je	0x10000fbe6
000000010000fbc3	leaq	-0x70(%rbp), %rsi
000000010000fbc7	addq	%rsi, %rdx
000000010000fbca	decq	%rdx
000000010000fbcd	nopl	(%rax)
000000010000fbd0	movzbl	(%rdx), %esi
000000010000fbd3	movb	%sil, -0x270(%rbp,%rcx)
000000010000fbdb	incq	%rcx
000000010000fbde	decq	%rdx
000000010000fbe1	cmpq	%rcx, %rax
000000010000fbe4	jne	0x10000fbd0
000000010000fbe6	movb	$0x0, -0x270(%rbp,%rax)
000000010000fbee	leaq	-0x270(%rbp), %rbx
000000010000fbf5	movq	%rbx, %rdi
000000010000fbf8	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000fbfd	movq	%r13, %rdi
000000010000fc00	movq	%rbx, %rsi
000000010000fc03	movq	%rax, %rdx
000000010000fc06	callq	_buf_put
000000010000fc0b	movq	0x341e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fc12	movq	(%rax), %rax
000000010000fc15	cmpq	-0x30(%rbp), %rax
000000010000fc19	jne	0x10000fd68
000000010000fc1f	addq	$0x268, %rsp                    ## imm = 0x268
000000010000fc26	popq	%rbx
000000010000fc27	popq	%r12
000000010000fc29	popq	%r13
000000010000fc2b	popq	%r14
000000010000fc2d	popq	%r15
000000010000fc2f	popq	%rbp
000000010000fc30	retq
000000010000fc31	cmpl	$0x20, %eax
000000010000fc34	jae	0x10000fc3a
000000010000fc36	xorl	%ecx, %ecx
000000010000fc38	jmp	0x10000fcaf
000000010000fc3a	movl	%r8d, %edx
000000010000fc3d	andl	$0x1f, %edx
000000010000fc40	movq	%rax, %rcx
000000010000fc43	subq	%rdx, %rcx
000000010000fc46	movl	%edi, %esi
000000010000fc48	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
000000010000fc4e	leaq	(%rsi,%rbp), %r9
000000010000fc52	addq	$-0x80, %r9
000000010000fc56	movl	%edi, %r10d
000000010000fc59	andl	$0x1f, %r10d
000000010000fc5d	subq	%r10, %rsi
000000010000fc60	xorl	%r10d, %r10d
000000010000fc63	movdqa	0x1795(%rip), %xmm0
000000010000fc6b	movdqu	-0x10(%r9), %xmm1
000000010000fc71	movdqu	(%r9), %xmm2
000000010000fc76	pshufb	%xmm0, %xmm2
000000010000fc7b	pshufb	%xmm0, %xmm1
000000010000fc80	movdqu	%xmm2, -0x26f(%rbp,%r10)
000000010000fc8a	movdqu	%xmm1, -0x25f(%rbp,%r10)
000000010000fc94	addq	$0x20, %r10
000000010000fc98	addq	$-0x20, %r9
000000010000fc9c	cmpq	%r10, %rsi
000000010000fc9f	jne	0x10000fc6b
000000010000fca1	testq	%rdx, %rdx
000000010000fca4	je	0x10000fd46
000000010000fcaa	cmpl	$0x7, %edx
000000010000fcad	jbe	0x10000fd14
000000010000fcaf	movq	%rcx, %rsi
000000010000fcb2	movl	%r8d, %edx
000000010000fcb5	andl	$0x7, %edx
000000010000fcb8	movq	%rax, %rcx
000000010000fcbb	subq	%rdx, %rcx
000000010000fcbe	movq	%rsi, %r8
000000010000fcc1	negq	%r8
000000010000fcc4	leaq	(%r8,%rbp), %r9
000000010000fcc8	addq	$-0x70, %r9
000000010000fccc	movl	%edi, %r8d
000000010000fccf	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
000000010000fcd6	addq	%r8, %r9
000000010000fcd9	addq	$-0x8, %r9
000000010000fcdd	movl	%edi, %r10d
000000010000fce0	andl	$0x7, %r10d
000000010000fce4	subq	%r10, %r8
000000010000fce7	movq	0x1721(%rip), %xmm0
000000010000fcef	movq	(%r9), %xmm1
000000010000fcf4	pshufb	%xmm0, %xmm1
000000010000fcf9	movq	%xmm1, -0x26f(%rbp,%rsi)
000000010000fd02	addq	$0x8, %rsi
000000010000fd06	addq	$-0x8, %r9
000000010000fd0a	cmpq	%rsi, %r8
000000010000fd0d	jne	0x10000fcef
000000010000fd0f	testq	%rdx, %rdx
000000010000fd12	je	0x10000fd46
000000010000fd14	leaq	-0x70(%rbp), %rsi
000000010000fd18	addq	%rsi, %rdx
000000010000fd1b	decq	%rdx
000000010000fd1e	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
000000010000fd24	nopw	%cs:(%rax,%rax)
000000010000fd30	movzbl	(%rdx), %esi
000000010000fd33	movb	%sil, -0x26f(%rbp,%rcx)
000000010000fd3b	incq	%rcx
000000010000fd3e	decq	%rdx
000000010000fd41	cmpq	%rcx, %rdi
000000010000fd44	jne	0x10000fd30
000000010000fd46	movb	$0x0, -0x26f(%rbp,%rax)
000000010000fd4e	jmp	0x10000fbee
000000010000fd53	movq	%rbx, %rdi
000000010000fd56	movsd	-0x280(%rbp), %xmm0
000000010000fd5e	movl	$0x9, %esi
000000010000fd63	jmp	0x10000ebca
000000010000fd68	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
000000010000fd6d	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
000000010000fd77	jmp	0x10000fbee
000000010000fd7c	repne		jmp	0x10000fd7e
000000010000fd7f	pushq	%rdx
000000010000fd81	jmp	0x10000fd82
000000010000fd83	pushq	%rdx
000000010000fd85	jmp	0x10000fd86
000000010000fd87	pushq	%rdx
000000010000fd89	jmp	0x10000fd8a
000000010000fd8b	decl	-0x4000011(%rsi)
000000010000fd91	jmp	0x10000fd92
000000010000fd93	.byte 0xff #bad opcode
000000010000fd94	sti
000000010000fd95	jmp	0x10000fd96
000000010000fd97	.byte 0xff #bad opcode
000000010000fd98	sti
000000010000fd99	jmp	0x10000fd9a
000000010000fd9b	.byte 0xff #bad opcode
000000010000fd9c	sti
000000010000fd9d	jmp	0x10000fd9e
000000010000fd9f	jmpq	*%rax
000000010000fda1	outb	%al, %dx
000000010000fda2	.byte 0xff #bad opcode
000000010000fda3	.byte 0xff #bad opcode
000000010000fda4	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
000000010000fda9	inl	%dx, %eax
000000010000fdaa	.byte 0xff #bad opcode
000000010000fdab	pushq	-0x22000012(%rbp)
000000010000fdb1	.byte 0xf1 #bad opcode
000000010000fdb2	.byte 0xff #bad opcode
000000010000fdb3	ljmpl	*0x40ffffed(%rcx)
000000010000fdb9	lock
000000010000fdba	.byte 0xff #bad opcode
000000010000fdbb	incl	-0x13(%rcx)
000000010000fdbe	.byte 0xff #bad opcode
000000010000fdbf	.byte 0xff #bad opcode
000000010000fdc0	jl	0x10000fdb3
000000010000fdc2	.byte 0xff #bad opcode
000000010000fdc3	jmpq	*(%rax)
000000010000fdc5	inb	%dx, %al
000000010000fdc6	.byte 0xff #bad opcode
000000010000fdc7	jmpq	*(%rax)
000000010000fdc9	inb	%dx, %al
000000010000fdca	.byte 0xff #bad opcode
000000010000fdcb	incl	%esp
000000010000fdcd	lock
000000010000fdce	.byte 0xff #bad opcode
000000010000fdcf	pushq	(%rax)
000000010000fdd1	.byte 0xf1 #bad opcode
000000010000fdd2	.byte 0xff #bad opcode
000000010000fdd3	callq	*(%rsi)
000000010000fdd5	cmc
000000010000fdd6	.byte 0xff #bad opcode
000000010000fdd7	.byte 0xff #bad opcode
000000010000fdd8	cmc
000000010000fdda	.byte 0xff #bad opcode
000000010000fddb	decl	0x5bffffee(%rbp)
000000010000fde1	outb	%al, %dx
000000010000fde2	.byte 0xff #bad opcode
000000010000fde3	.byte 0xff #bad opcode
000000010000fde4	inb	%dx, %al
000000010000fde5	cmc
000000010000fde6	.byte 0xff #bad opcode
000000010000fde7	.byte 0xff #bad opcode
000000010000fde8	inb	%dx, %al
000000010000fde9	cmc
000000010000fdea	.byte 0xff #bad opcode
000000010000fdeb	.byte 0xff #bad opcode
000000010000fdec	inb	%dx, %al
000000010000fded	cmc
000000010000fdee	.byte 0xff #bad opcode
000000010000fdef	.byte 0xff #bad opcode
000000010000fdf0	inb	%dx, %al
000000010000fdf1	cmc
000000010000fdf2	.byte 0xff #bad opcode
000000010000fdf3	jmpq	*-0xa(%rcx)
000000010000fdf6	.byte 0xff #bad opcode
000000010000fdf7	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fdfb	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fdff	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe03	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe07	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe0b	jmpq	*-0xa(%rdi)
000000010000fe0e	.byte 0xff #bad opcode
000000010000fe0f	.byte 0xff #bad opcode
000000010000fe10	inb	%dx, %al
000000010000fe11	cmc
000000010000fe12	.byte 0xff #bad opcode
000000010000fe13	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe17	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe1b	callq	*-0xa(%rbx)
000000010000fe1e	.byte 0xff #bad opcode
000000010000fe1f	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe23	ljmpl	*-0xa(%rdi)
000000010000fe26	.byte 0xff #bad opcode
000000010000fe27	decl	(%rdi)
000000010000fe29	.byte 0x1f #bad opcode
000000010000fe2a	testb	%al, (%rax)
000000010000fe2c	addb	%al, (%rax)
000000010000fe2e	addb	%al, (%rax)
_fwp_escape:
000000010000fe30	pushq	%rbp
000000010000fe31	movq	%rsp, %rbp
000000010000fe34	pushq	%r15
000000010000fe36	pushq	%r14
000000010000fe38	pushq	%r13
000000010000fe3a	pushq	%r12
000000010000fe3c	pushq	%rbx
000000010000fe3d	subq	$0x18, %rsp
000000010000fe41	movq	%rdx, %r14
000000010000fe44	movq	%rsi, %r15
000000010000fe47	movq	%rdi, %rbx
000000010000fe4a	movq	0x31df(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fe51	movq	(%rax), %rax
000000010000fe54	movq	%rax, -0x30(%rbp)
000000010000fe58	movb	$0x22, -0x40(%rbp)
000000010000fe5c	leaq	-0x40(%rbp), %rsi
000000010000fe60	movl	$0x1, %edx
000000010000fe65	callq	_buf_put
000000010000fe6a	testq	%r14, %r14
000000010000fe6d	je	0x10000ff69
000000010000fe73	leaq	0x12a(%rip), %r12
000000010000fe7a	xorl	%r13d, %r13d
000000010000fe7d	jmp	0x10000fea1
000000010000fe7f	movl	$0x2, %edx
000000010000fe84	movq	%rbx, %rdi
000000010000fe87	leaq	0x27f4(%rip), %rsi              ## literal pool for: "\\r"
000000010000fe8e	nop
000000010000fe90	callq	_buf_put
000000010000fe95	incq	%r13
000000010000fe98	cmpq	%r13, %r14
000000010000fe9b	je	0x10000ff69
000000010000fea1	movzbl	(%r15,%r13), %eax
000000010000fea6	movzbl	%al, %ecx
000000010000fea9	leal	-0x9(%rcx), %edx
000000010000feac	cmpl	$0x19, %edx
000000010000feaf	ja	0x10000fed0
000000010000feb1	movslq	(%r12,%rdx,4), %rdx
000000010000feb5	addq	%r12, %rdx
000000010000feb8	jmpq	*%rdx
000000010000feba	movl	$0x2, %edx
000000010000febf	movq	%rbx, %rdi
000000010000fec2	leaq	0x27b6(%rip), %rsi              ## literal pool for: "\\t"
000000010000fec9	jmp	0x10000fe90
000000010000fecb	nopl	(%rax,%rax)
000000010000fed0	cmpl	$0x5c, %ecx
000000010000fed3	jne	0x10000fee6
000000010000fed5	movl	$0x2, %edx
000000010000feda	movq	%rbx, %rdi
000000010000fedd	leaq	0x2795(%rip), %rsi              ## literal pool for: "\\\\"
000000010000fee4	jmp	0x10000fe90
000000010000fee6	cmpb	$0x20, %al
000000010000fee8	setae	%dl
000000010000feeb	cmpb	$0x7f, %al
000000010000feed	setne	%sil
000000010000fef1	testb	%sil, %dl
000000010000fef4	jne	0x10000ff55
000000010000fef6	movl	$0x10, %esi
000000010000fefb	leaq	-0x40(%rbp), %r12
000000010000feff	movq	%r12, %rdi
000000010000ff02	leaq	0x277c(%rip), %rdx              ## literal pool for: "\\u{%x}"
000000010000ff09	xorl	%eax, %eax
000000010000ff0b	callq	0x10001128e                     ## symbol stub for: _snprintf
000000010000ff10	movq	%r12, %rdi
000000010000ff13	callq	0x1000112a6                     ## symbol stub for: _strlen
000000010000ff18	movq	%rbx, %rdi
000000010000ff1b	movq	%r12, %rsi
000000010000ff1e	leaq	0x7f(%rip), %r12
000000010000ff25	movq	%rax, %rdx
000000010000ff28	jmp	0x10000fe90
000000010000ff2d	movl	$0x2, %edx
000000010000ff32	movq	%rbx, %rdi
000000010000ff35	leaq	0x273a(%rip), %rsi              ## literal pool for: "\\\""
000000010000ff3c	jmp	0x10000fe90
000000010000ff41	movl	$0x2, %edx
000000010000ff46	movq	%rbx, %rdi
000000010000ff49	leaq	0x272c(%rip), %rsi              ## literal pool for: "\\n"
000000010000ff50	jmp	0x10000fe90
000000010000ff55	movb	%al, -0x40(%rbp)
000000010000ff58	movl	$0x1, %edx
000000010000ff5d	movq	%rbx, %rdi
000000010000ff60	leaq	-0x40(%rbp), %rsi
000000010000ff64	jmp	0x10000fe90
000000010000ff69	movb	$0x22, -0x40(%rbp)
000000010000ff6d	leaq	-0x40(%rbp), %rsi
000000010000ff71	movl	$0x1, %edx
000000010000ff76	movq	%rbx, %rdi
000000010000ff79	callq	_buf_put
000000010000ff7e	movq	0x30ab(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ff85	movq	(%rax), %rax
000000010000ff88	cmpq	-0x30(%rbp), %rax
000000010000ff8c	jne	0x10000ff9d
000000010000ff8e	addq	$0x18, %rsp
000000010000ff92	popq	%rbx
000000010000ff93	popq	%r12
000000010000ff95	popq	%r13
000000010000ff97	popq	%r14
000000010000ff99	popq	%r15
000000010000ff9b	popq	%rbp
000000010000ff9c	retq
000000010000ff9d	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
000000010000ffa2	nop
000000010000ffa4	.byte 0x16 #bad opcode
000000010000ffa5	.byte 0xff #bad opcode
000000010000ffa6	.byte 0xff #bad opcode
000000010000ffa7	lcalll	*0x42ffffff(%rbp)
000000010000ffad	.byte 0xff #bad opcode
000000010000ffae	.byte 0xff #bad opcode
000000010000ffaf	incl	-0x1(%rdx)
000000010000ffb2	.byte 0xff #bad opcode
000000010000ffb3	.byte 0xff #bad opcode
000000010000ffb4	.byte 0xdb #bad opcode
000000010000ffb5	.byte 0xfe #bad opcode
000000010000ffb6	.byte 0xff #bad opcode
000000010000ffb7	incl	-0x1(%rdx)
000000010000ffba	.byte 0xff #bad opcode
000000010000ffbb	incl	-0x1(%rdx)
000000010000ffbe	.byte 0xff #bad opcode
000000010000ffbf	incl	-0x1(%rdx)
000000010000ffc2	.byte 0xff #bad opcode
000000010000ffc3	incl	-0x1(%rdx)
000000010000ffc6	.byte 0xff #bad opcode
000000010000ffc7	incl	-0x1(%rdx)
000000010000ffca	.byte 0xff #bad opcode
000000010000ffcb	incl	-0x1(%rdx)
000000010000ffce	.byte 0xff #bad opcode
000000010000ffcf	incl	-0x1(%rdx)
000000010000ffd2	.byte 0xff #bad opcode
000000010000ffd3	incl	-0x1(%rdx)
000000010000ffd6	.byte 0xff #bad opcode
000000010000ffd7	incl	-0x1(%rdx)
000000010000ffda	.byte 0xff #bad opcode
000000010000ffdb	incl	-0x1(%rdx)
000000010000ffde	.byte 0xff #bad opcode
000000010000ffdf	incl	-0x1(%rdx)
000000010000ffe2	.byte 0xff #bad opcode
000000010000ffe3	incl	-0x1(%rdx)
000000010000ffe6	.byte 0xff #bad opcode
000000010000ffe7	incl	-0x1(%rdx)
000000010000ffea	.byte 0xff #bad opcode
000000010000ffeb	incl	-0x1(%rdx)
000000010000ffee	.byte 0xff #bad opcode
000000010000ffef	incl	-0x1(%rdx)
000000010000fff2	.byte 0xff #bad opcode
000000010000fff3	incl	-0x1(%rdx)
000000010000fff6	.byte 0xff #bad opcode
000000010000fff7	incl	-0x1(%rdx)
000000010000fffa	.byte 0xff #bad opcode
000000010000fffb	incl	-0x1(%rdx)
000000010000fffe	.byte 0xff #bad opcode
000000010000ffff	incl	-0x1(%rdx)
0000000100010002	.byte 0xff #bad opcode
0000000100010003	incl	-0x1(%rdx)
0000000100010006	.byte 0xff #bad opcode
0000000100010007	decl	0xfffffff(%rcx)
000000010001000d	.byte 0x1f #bad opcode
000000010001000e	addb	%dl, 0x48(%rbp)
0000000100010012	movl	%esp, %ebp
0000000100010014	pushq	%r15
0000000100010016	pushq	%r14
0000000100010018	pushq	%r13
000000010001001a	pushq	%r12
000000010001001c	pushq	%rbx
000000010001001d	subq	$0x88, %rsp
0000000100010024	movq	0x3005(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010001002b	movq	(%rax), %rax
000000010001002e	movq	%rax, -0x30(%rbp)
0000000100010032	movq	%rsi, %rax
0000000100010035	orq	%rdx, %rax
0000000100010038	je	0x100010309
000000010001003e	movq	%rdx, %r8
0000000100010041	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
000000010001004b	imulq	%rsi, %rcx
000000010001004f	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
0000000100010059	movq	%rsi, %rax
000000010001005c	mulq	%r9
000000010001005f	addq	%rcx, %rdx
0000000100010062	imulq	%r8, %r9
0000000100010066	addq	%rdx, %r9
0000000100010069	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
0000000100010073	addq	%rax, %rcx
0000000100010076	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
0000000100010080	adcq	%r9, %rax
0000000100010083	movq	%rax, %rdx
0000000100010086	shrdq	$0xd, %rcx, %rdx
000000010001008b	shldq	$0x33, %rcx, %rax
0000000100010090	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
000000010001009a	cmpq	%rax, %rcx
000000010001009d	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
00000001000100a2	sbbq	%rdx, %rax
00000001000100a5	jae	0x100010326
00000001000100ab	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
00000001000100b5	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
00000001000100bf	movq	%rsi, %rax
00000001000100c2	mulq	%r9
00000001000100c5	imulq	%rsi, %rcx
00000001000100c9	addq	%rcx, %rdx
00000001000100cc	imulq	%r8, %r9
00000001000100d0	addq	%rdx, %r9
00000001000100d3	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
00000001000100dd	addq	%rax, %rcx
00000001000100e0	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
00000001000100ea	adcq	%r9, %rax
00000001000100ed	movq	%rax, %rdx
00000001000100f0	shrdq	$0xb, %rcx, %rdx
00000001000100f5	shldq	$0x35, %rcx, %rax
00000001000100fa	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
0000000100010104	cmpq	%rcx, %rax
0000000100010107	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
000000010001010e	jb	0x100010348
0000000100010114	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
000000010001011e	imulq	%rsi, %rcx
0000000100010122	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
000000010001012c	movq	%rsi, %rax
000000010001012f	mulq	%r9
0000000100010132	addq	%rcx, %rdx
0000000100010135	imulq	%r8, %r9
0000000100010139	addq	%rdx, %r9
000000010001013c	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
0000000100010146	addq	%rax, %rcx
0000000100010149	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
0000000100010153	adcq	%r9, %rax
0000000100010156	movq	%rax, %rdx
0000000100010159	shrdq	$0x9, %rcx, %rdx
000000010001015e	shldq	$0x37, %rcx, %rax
0000000100010163	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
000000010001016d	cmpq	%rcx, %rax
0000000100010170	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
000000010001017a	sbbq	%rax, %rdx
000000010001017d	jb	0x100010448
0000000100010183	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
000000010001018d	imulq	%rsi, %rcx
0000000100010191	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
000000010001019b	movq	%rsi, %rax
000000010001019e	mulq	%r9
00000001000101a1	addq	%rcx, %rdx
00000001000101a4	imulq	%r8, %r9
00000001000101a8	addq	%rdx, %r9
00000001000101ab	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
00000001000101b5	addq	%rax, %rcx
00000001000101b8	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
00000001000101c2	adcq	%r9, %rax
00000001000101c5	movq	%rax, %rdx
00000001000101c8	shrdq	$0x6, %rcx, %rdx
00000001000101cd	shldq	$0x3a, %rcx, %rax
00000001000101d2	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
00000001000101dc	cmpq	%rcx, %rax
00000001000101df	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
00000001000101e9	sbbq	%rax, %rdx
00000001000101ec	jb	0x100010459
00000001000101f2	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
00000001000101fc	imulq	%rsi, %rcx
0000000100010200	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
000000010001020a	movq	%rsi, %rax
000000010001020d	mulq	%r9
0000000100010210	addq	%rcx, %rdx
0000000100010213	imulq	%r8, %r9
0000000100010217	addq	%rdx, %r9
000000010001021a	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
0000000100010224	addq	%rax, %rcx
0000000100010227	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
0000000100010231	adcq	%r9, %rax
0000000100010234	movq	%rax, %rdx
0000000100010237	shrdq	$0x3, %rcx, %rdx
000000010001023c	shldq	$0x3d, %rcx, %rax
0000000100010241	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
000000010001024b	cmpq	%rcx, %rax
000000010001024e	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
0000000100010258	sbbq	%rax, %rdx
000000010001025b	jb	0x10001046a
0000000100010261	testq	%r8, %r8
0000000100010264	js	0x10001088c
000000010001026a	xorl	%r10d, %r10d
000000010001026d	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010277	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010281	movq	%r8, %r14
0000000100010284	nopw	%cs:(%rax,%rax)
0000000100010290	movq	%r8, %rcx
0000000100010293	shldq	$0x3f, %rsi, %rcx
0000000100010298	shrq	%r14
000000010001029b	movq	%rcx, %r9
000000010001029e	addq	%r14, %r9
00000001000102a1	adcq	$0x0, %r9
00000001000102a5	movq	%r9, %rax
00000001000102a8	mulq	%r11
00000001000102ab	shrq	$0x2, %rdx
00000001000102af	leaq	(%rdx,%rdx,4), %rax
00000001000102b3	subq	%rax, %r9
00000001000102b6	subq	%r9, %rcx
00000001000102b9	sbbq	$0x0, %r14
00000001000102bd	movq	%rcx, %r9
00000001000102c0	imulq	%rbx, %r9
00000001000102c4	movq	%rcx, %rax
00000001000102c7	mulq	%r11
00000001000102ca	addq	%r9, %rdx
00000001000102cd	imulq	%r11, %r14
00000001000102d1	addq	%rdx, %r14
00000001000102d4	movq	%rax, %rcx
00000001000102d7	addq	%rax, %rcx
00000001000102da	leaq	(%rcx,%rcx,4), %rcx
00000001000102de	movl	%esi, %edx
00000001000102e0	subl	%ecx, %edx
00000001000102e2	orb	$0x30, %dl
00000001000102e5	movb	%dl, -0x70(%rbp,%r10)
00000001000102ea	incq	%r10
00000001000102ed	cmpq	$0xa, %rsi
00000001000102f1	sbbq	$0x0, %r8
00000001000102f5	movq	%rax, %rsi
00000001000102f8	movq	%r14, %r8
00000001000102fb	jae	0x100010290
00000001000102fd	testl	%r10d, %r10d
0000000100010300	jg	0x100010313
0000000100010302	xorl	%eax, %eax
0000000100010304	jmp	0x100010426
0000000100010309	movb	$0x30, -0x70(%rbp)
000000010001030d	movl	$0x1, %r10d
0000000100010313	movl	%r10d, %eax
0000000100010316	cmpq	$0x8, %rax
000000010001031a	jae	0x10001033f
000000010001031c	xorl	%ecx, %ecx
000000010001031e	movq	%rax, %rdx
0000000100010321	jmp	0x100010402
0000000100010326	movq	%rdi, %r14
0000000100010329	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
0000000100010333	leaq	_fwp_fmt_duration.units(%rip), %rbx
000000010001033a	jmp	0x100010479
000000010001033f	cmpl	$0x20, %eax
0000000100010342	jae	0x100010361
0000000100010344	xorl	%ecx, %ecx
0000000100010346	jmp	0x1000103bb
0000000100010348	movq	%rdi, %r14
000000010001034b	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
0000000100010355	leaq	0x3634(%rip), %rbx
000000010001035c	jmp	0x100010479
0000000100010361	movl	%r10d, %edx
0000000100010364	andl	$0x1f, %edx
0000000100010367	movq	%rax, %rcx
000000010001036a	subq	%rdx, %rcx
000000010001036d	leaq	-0xa0(%rbp), %rsi
0000000100010374	movdqa	0x1084(%rip), %xmm0
000000010001037c	movq	%rax, %r8
000000010001037f	nop
0000000100010380	movdqu	-0x90(%rbp,%r8), %xmm1
000000010001038a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010391	pshufb	%xmm0, %xmm2
0000000100010396	pshufb	%xmm0, %xmm1
000000010001039b	movdqa	%xmm2, -0x10(%rsi)
00000001000103a0	movdqa	%xmm1, (%rsi)
00000001000103a4	addq	$-0x20, %r8
00000001000103a8	addq	$0x20, %rsi
00000001000103ac	cmpq	%r8, %rdx
00000001000103af	jne	0x100010380
00000001000103b1	testq	%rdx, %rdx
00000001000103b4	je	0x100010426
00000001000103b6	cmpl	$0x7, %edx
00000001000103b9	jbe	0x100010402
00000001000103bb	movl	%r10d, %edx
00000001000103be	andl	$0x7, %edx
00000001000103c1	movq	%rax, %rsi
00000001000103c4	subq	%rcx, %rsi
00000001000103c7	leaq	(%rcx,%rbp), %r8
00000001000103cb	addq	$-0xb0, %r8
00000001000103d2	movq	%rax, %rcx
00000001000103d5	subq	%rdx, %rcx
00000001000103d8	movq	0x1030(%rip), %xmm0
00000001000103e0	movq	-0x78(%rbp,%rsi), %xmm1
00000001000103e6	pshufb	%xmm0, %xmm1
00000001000103eb	movq	%xmm1, (%r8)
00000001000103f0	addq	$-0x8, %rsi
00000001000103f4	addq	$0x8, %r8
00000001000103f8	cmpq	%rsi, %rdx
00000001000103fb	jne	0x1000103e0
00000001000103fd	testq	%rdx, %rdx
0000000100010400	je	0x100010426
0000000100010402	leaq	-0x70(%rbp), %rsi
0000000100010406	addq	%rsi, %rdx
0000000100010409	decq	%rdx
000000010001040c	nopl	(%rax)
0000000100010410	movzbl	(%rdx), %esi
0000000100010413	movb	%sil, -0xb0(%rbp,%rcx)
000000010001041b	incq	%rcx
000000010001041e	decq	%rdx
0000000100010421	cmpq	%rcx, %rax
0000000100010424	jne	0x100010410
0000000100010426	movb	$0x0, -0xb0(%rbp,%rax)
000000010001042e	leaq	0x225c(%rip), %rsi              ## literal pool for: "%sns"
0000000100010435	leaq	-0xb0(%rbp), %rdx
000000010001043c	xorl	%eax, %eax
000000010001043e	callq	0x100011294                     ## symbol stub for: _sprintf
0000000100010443	jmp	0x100010866
0000000100010448	movq	%rdi, %r14
000000010001044b	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
0000000100010450	leaq	0x3549(%rip), %rbx
0000000100010457	jmp	0x100010479
0000000100010459	movq	%rdi, %r14
000000010001045c	movl	$0xf4240, %edx                  ## imm = 0xF4240
0000000100010461	leaq	0x3548(%rip), %rbx
0000000100010468	jmp	0x100010479
000000010001046a	movq	%rdi, %r14
000000010001046d	movl	$0x3e8, %edx                    ## imm = 0x3E8
0000000100010472	leaq	0x3547(%rip), %rbx
0000000100010479	xorl	%ecx, %ecx
000000010001047b	movq	%rsi, %rdi
000000010001047e	movq	%r8, %rsi
0000000100010481	callq	0x100011174                     ## symbol stub for: ___divti3
0000000100010486	movq	%rax, %rcx
0000000100010489	movq	%rdx, %rsi
000000010001048c	testq	%rdx, %rdx
000000010001048f	js	0x100010540
0000000100010495	movq	%rcx, %rax
0000000100010498	orq	%rsi, %rax
000000010001049b	je	0x100010619
00000001000104a1	xorl	%r10d, %r10d
00000001000104a4	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000104ae	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000104b8	movq	%rsi, %r12
00000001000104bb	movq	%r14, %rdi
00000001000104be	nop
00000001000104c0	movq	%rsi, %r8
00000001000104c3	shldq	$0x3f, %rcx, %r8
00000001000104c8	shrq	%r12
00000001000104cb	movq	%r8, %r9
00000001000104ce	addq	%r12, %r9
00000001000104d1	adcq	$0x0, %r9
00000001000104d5	movq	%r9, %rax
00000001000104d8	mulq	%r11
00000001000104db	shrq	$0x2, %rdx
00000001000104df	leaq	(%rdx,%rdx,4), %rax
00000001000104e3	subq	%rax, %r9
00000001000104e6	subq	%r9, %r8
00000001000104e9	sbbq	$0x0, %r12
00000001000104ed	movq	%r8, %r9
00000001000104f0	imulq	%r15, %r9
00000001000104f4	movq	%r8, %rax
00000001000104f7	mulq	%r11
00000001000104fa	addq	%r9, %rdx
00000001000104fd	imulq	%r11, %r12
0000000100010501	addq	%rdx, %r12
0000000100010504	movq	%rax, %rdx
0000000100010507	addq	%rax, %rdx
000000010001050a	leaq	(%rdx,%rdx,4), %rdx
000000010001050e	movl	%ecx, %r8d
0000000100010511	subl	%edx, %r8d
0000000100010514	orb	$0x30, %r8b
0000000100010518	movb	%r8b, -0x70(%rbp,%r10)
000000010001051d	incq	%r10
0000000100010520	cmpq	$0xa, %rcx
0000000100010524	sbbq	$0x0, %rsi
0000000100010528	movq	%rax, %rcx
000000010001052b	movq	%r12, %rsi
000000010001052e	jae	0x1000104c0
0000000100010530	testl	%r10d, %r10d
0000000100010533	jg	0x100010626
0000000100010539	xorl	%eax, %eax
000000010001053b	jmp	0x100010716
0000000100010540	movb	$0x2d, -0xb0(%rbp)
0000000100010547	xorl	%r9d, %r9d
000000010001054a	negq	%rcx
000000010001054d	movl	$0x0, %r11d
0000000100010553	sbbq	%rsi, %r11
0000000100010556	movl	$0x1, %r13d
000000010001055c	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010566	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010570	movq	%r11, %r12
0000000100010573	nopw	%cs:(%rax,%rax)
0000000100010580	movq	%r11, %rsi
0000000100010583	shldq	$0x3f, %rcx, %rsi
0000000100010588	shrq	%r12
000000010001058b	movq	%rsi, %rdi
000000010001058e	addq	%r12, %rdi
0000000100010591	adcq	$0x0, %rdi
0000000100010595	movq	%rdi, %rax
0000000100010598	mulq	%r10
000000010001059b	movl	%r13d, %r8d
000000010001059e	shrq	$0x2, %rdx
00000001000105a2	leaq	(%rdx,%rdx,4), %rax
00000001000105a6	subq	%rax, %rdi
00000001000105a9	subq	%rdi, %rsi
00000001000105ac	sbbq	$0x0, %r12
00000001000105b0	movq	%rsi, %rdi
00000001000105b3	movq	%rsi, %rax
00000001000105b6	mulq	%r10
00000001000105b9	imulq	%r15, %rdi
00000001000105bd	addq	%rdi, %rdx
00000001000105c0	imulq	%r10, %r12
00000001000105c4	addq	%rdx, %r12
00000001000105c7	movq	%rax, %rdx
00000001000105ca	addq	%rax, %rdx
00000001000105cd	leaq	(%rdx,%rdx,4), %rdx
00000001000105d1	movl	%ecx, %esi
00000001000105d3	subl	%edx, %esi
00000001000105d5	orb	$0x30, %sil
00000001000105d9	movb	%sil, -0x70(%rbp,%r9)
00000001000105de	incq	%r9
00000001000105e1	leal	0x1(%r8), %r13d
00000001000105e5	cmpq	$0xa, %rcx
00000001000105e9	sbbq	$0x0, %r11
00000001000105ed	movq	%rax, %rcx
00000001000105f0	movq	%r12, %r11
00000001000105f3	jae	0x100010580
00000001000105f5	testl	%r9d, %r9d
00000001000105f8	movq	%r14, %rdi
00000001000105fb	jle	0x100010642
00000001000105fd	movl	%r9d, %eax
0000000100010600	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010605	cmpq	$0x8, %rax
0000000100010609	jae	0x100010723
000000010001060f	xorl	%ecx, %ecx
0000000100010611	movq	%rax, %rdx
0000000100010614	jmp	0x100010815
0000000100010619	movb	$0x30, -0x70(%rbp)
000000010001061d	movl	$0x1, %r10d
0000000100010623	movq	%r14, %rdi
0000000100010626	movl	%r10d, %eax
0000000100010629	cmpq	$0x8, %rax
000000010001062d	jae	0x100010639
000000010001062f	xorl	%ecx, %ecx
0000000100010631	movq	%rax, %rdx
0000000100010634	jmp	0x1000106f2
0000000100010639	cmpl	$0x20, %eax
000000010001063c	jae	0x100010649
000000010001063e	xorl	%ecx, %ecx
0000000100010640	jmp	0x1000106ab
0000000100010642	xorl	%eax, %eax
0000000100010644	jmp	0x100010846
0000000100010649	movl	%r10d, %edx
000000010001064c	andl	$0x1f, %edx
000000010001064f	movq	%rax, %rcx
0000000100010652	subq	%rdx, %rcx
0000000100010655	leaq	-0xa0(%rbp), %rsi
000000010001065c	movdqa	0xd9c(%rip), %xmm0
0000000100010664	movq	%rax, %r8
0000000100010667	nopw	(%rax,%rax)
0000000100010670	movdqu	-0x90(%rbp,%r8), %xmm1
000000010001067a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010681	pshufb	%xmm0, %xmm2
0000000100010686	pshufb	%xmm0, %xmm1
000000010001068b	movdqa	%xmm2, -0x10(%rsi)
0000000100010690	movdqa	%xmm1, (%rsi)
0000000100010694	addq	$-0x20, %r8
0000000100010698	addq	$0x20, %rsi
000000010001069c	cmpq	%r8, %rdx
000000010001069f	jne	0x100010670
00000001000106a1	testq	%rdx, %rdx
00000001000106a4	je	0x100010716
00000001000106a6	cmpl	$0x7, %edx
00000001000106a9	jbe	0x1000106f2
00000001000106ab	movl	%r10d, %edx
00000001000106ae	andl	$0x7, %edx
00000001000106b1	movq	%rax, %rsi
00000001000106b4	subq	%rcx, %rsi
00000001000106b7	leaq	(%rcx,%rbp), %r8
00000001000106bb	addq	$-0xb0, %r8
00000001000106c2	movq	%rax, %rcx
00000001000106c5	subq	%rdx, %rcx
00000001000106c8	movq	0xd40(%rip), %xmm0
00000001000106d0	movq	-0x78(%rbp,%rsi), %xmm1
00000001000106d6	pshufb	%xmm0, %xmm1
00000001000106db	movq	%xmm1, (%r8)
00000001000106e0	addq	$-0x8, %rsi
00000001000106e4	addq	$0x8, %r8
00000001000106e8	cmpq	%rsi, %rdx
00000001000106eb	jne	0x1000106d0
00000001000106ed	testq	%rdx, %rdx
00000001000106f0	je	0x100010716
00000001000106f2	leaq	-0x70(%rbp), %rsi
00000001000106f6	addq	%rsi, %rdx
00000001000106f9	decq	%rdx
00000001000106fc	nopl	(%rax)
0000000100010700	movzbl	(%rdx), %esi
0000000100010703	movb	%sil, -0xb0(%rbp,%rcx)
000000010001070b	incq	%rcx
000000010001070e	decq	%rdx
0000000100010711	cmpq	%rcx, %rax
0000000100010714	jne	0x100010700
0000000100010716	movb	$0x0, -0xb0(%rbp,%rax)
000000010001071e	jmp	0x10001084e
0000000100010723	cmpl	$0x20, %eax
0000000100010726	jae	0x10001072c
0000000100010728	xorl	%ecx, %ecx
000000010001072a	jmp	0x1000107a4
000000010001072c	movl	%r9d, %edx
000000010001072f	andl	$0x1f, %edx
0000000100010732	movq	%rax, %rcx
0000000100010735	subq	%rdx, %rcx
0000000100010738	movl	%r8d, %esi
000000010001073b	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010741	leaq	(%rsi,%rbp), %r10
0000000100010745	addq	$-0x80, %r10
0000000100010749	movl	%r8d, %r11d
000000010001074c	andl	$0x1f, %r11d
0000000100010750	subq	%r11, %rsi
0000000100010753	xorl	%r11d, %r11d
0000000100010756	movdqa	0xca2(%rip), %xmm0
000000010001075e	nop
0000000100010760	movdqu	-0x10(%r10), %xmm1
0000000100010766	movdqu	(%r10), %xmm2
000000010001076b	pshufb	%xmm0, %xmm2
0000000100010770	pshufb	%xmm0, %xmm1
0000000100010775	movdqu	%xmm2, -0xaf(%rbp,%r11)
000000010001077f	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100010789	addq	$0x20, %r11
000000010001078d	addq	$-0x20, %r10
0000000100010791	cmpq	%r11, %rsi
0000000100010794	jne	0x100010760
0000000100010796	testq	%rdx, %rdx
0000000100010799	je	0x100010846
000000010001079f	cmpl	$0x7, %edx
00000001000107a2	jbe	0x100010815
00000001000107a4	movq	%rcx, %rsi
00000001000107a7	movl	%r9d, %edx
00000001000107aa	andl	$0x7, %edx
00000001000107ad	movq	%rax, %rcx
00000001000107b0	subq	%rdx, %rcx
00000001000107b3	movq	%rsi, %r9
00000001000107b6	negq	%r9
00000001000107b9	leaq	(%r9,%rbp), %r10
00000001000107bd	addq	$-0x70, %r10
00000001000107c1	movl	%r8d, %r9d
00000001000107c4	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
00000001000107cb	addq	%r9, %r10
00000001000107ce	addq	$-0x8, %r10
00000001000107d2	movl	%r8d, %r11d
00000001000107d5	andl	$0x7, %r11d
00000001000107d9	subq	%r11, %r9
00000001000107dc	movq	0xc2c(%rip), %xmm0
00000001000107e4	nopw	%cs:(%rax,%rax)
00000001000107f0	movq	(%r10), %xmm1
00000001000107f5	pshufb	%xmm0, %xmm1
00000001000107fa	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100010803	addq	$0x8, %rsi
0000000100010807	addq	$-0x8, %r10
000000010001080b	cmpq	%rsi, %r9
000000010001080e	jne	0x1000107f0
0000000100010810	testq	%rdx, %rdx
0000000100010813	je	0x100010846
0000000100010815	leaq	-0x70(%rbp), %rsi
0000000100010819	addq	%rsi, %rdx
000000010001081c	decq	%rdx
000000010001081f	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010826	nopw	%cs:(%rax,%rax)
0000000100010830	movzbl	(%rdx), %esi
0000000100010833	movb	%sil, -0xaf(%rbp,%rcx)
000000010001083b	incq	%rcx
000000010001083e	decq	%rdx
0000000100010841	cmpq	%rcx, %r8
0000000100010844	jne	0x100010830
0000000100010846	movb	$0x0, -0xaf(%rbp,%rax)
000000010001084e	movq	(%rbx), %rcx
0000000100010851	leaq	0x1e34(%rip), %rsi              ## literal pool for: "%s%s"
0000000100010858	leaq	-0xb0(%rbp), %rdx
000000010001085f	xorl	%eax, %eax
0000000100010861	callq	0x100011294                     ## symbol stub for: _sprintf
0000000100010866	movq	0x27c3(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010001086d	movq	(%rax), %rax
0000000100010870	cmpq	-0x30(%rbp), %rax
0000000100010874	jne	0x100010a73
000000010001087a	addq	$0x88, %rsp
0000000100010881	popq	%rbx
0000000100010882	popq	%r12
0000000100010884	popq	%r13
0000000100010886	popq	%r14
0000000100010888	popq	%r15
000000010001088a	popq	%rbp
000000010001088b	retq
000000010001088c	movb	$0x2d, -0xb0(%rbp)
0000000100010893	xorl	%r10d, %r10d
0000000100010896	negq	%rsi
0000000100010899	movl	$0x0, %ebx
000000010001089e	sbbq	%r8, %rbx
00000001000108a1	movl	$0x1, %r12d
00000001000108a7	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
00000001000108b1	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
00000001000108bb	movq	%rbx, %r15
00000001000108be	nop
00000001000108c0	movq	%rbx, %rcx
00000001000108c3	shldq	$0x3f, %rsi, %rcx
00000001000108c8	shrq	%r15
00000001000108cb	movq	%rcx, %r8
00000001000108ce	addq	%r15, %r8
00000001000108d1	adcq	$0x0, %r8
00000001000108d5	movq	%r8, %rax
00000001000108d8	mulq	%r11
00000001000108db	movl	%r12d, %r9d
00000001000108de	shrq	$0x2, %rdx
00000001000108e2	leaq	(%rdx,%rdx,4), %rax
00000001000108e6	subq	%rax, %r8
00000001000108e9	subq	%r8, %rcx
00000001000108ec	sbbq	$0x0, %r15
00000001000108f0	movq	%rcx, %r8
00000001000108f3	movq	%rcx, %rax
00000001000108f6	mulq	%r11
00000001000108f9	imulq	%r14, %r8
00000001000108fd	addq	%r8, %rdx
0000000100010900	imulq	%r11, %r15
0000000100010904	addq	%rdx, %r15
0000000100010907	movq	%rax, %rcx
000000010001090a	addq	%rax, %rcx
000000010001090d	leaq	(%rcx,%rcx,4), %rcx
0000000100010911	movl	%esi, %edx
0000000100010913	subl	%ecx, %edx
0000000100010915	orb	$0x30, %dl
0000000100010918	movb	%dl, -0x70(%rbp,%r10)
000000010001091d	incq	%r10
0000000100010920	leal	0x1(%r9), %r12d
0000000100010924	cmpq	$0xa, %rsi
0000000100010928	sbbq	$0x0, %rbx
000000010001092c	movq	%rax, %rsi
000000010001092f	movq	%r15, %rbx
0000000100010932	jae	0x1000108c0
0000000100010934	testl	%r10d, %r10d
0000000100010937	jle	0x100010951
0000000100010939	movl	%r10d, %eax
000000010001093c	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010941	cmpq	$0x8, %rax
0000000100010945	jae	0x100010958
0000000100010947	xorl	%ecx, %ecx
0000000100010949	movq	%rax, %rdx
000000010001094c	jmp	0x100010a3c
0000000100010951	xorl	%eax, %eax
0000000100010953	jmp	0x100010a66
0000000100010958	cmpl	$0x20, %eax
000000010001095b	jae	0x100010961
000000010001095d	xorl	%ecx, %ecx
000000010001095f	jmp	0x1000109d7
0000000100010961	movl	%r10d, %edx
0000000100010964	andl	$0x1f, %edx
0000000100010967	movq	%rax, %rcx
000000010001096a	subq	%rdx, %rcx
000000010001096d	movl	%r9d, %esi
0000000100010970	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010976	leaq	(%rsi,%rbp), %r8
000000010001097a	addq	$-0x80, %r8
000000010001097e	movl	%r9d, %r11d
0000000100010981	andl	$0x1f, %r11d
0000000100010985	subq	%r11, %rsi
0000000100010988	xorl	%r11d, %r11d
000000010001098b	movdqa	0xa6d(%rip), %xmm0
0000000100010993	movdqu	-0x10(%r8), %xmm1
0000000100010999	movdqu	(%r8), %xmm2
000000010001099e	pshufb	%xmm0, %xmm2
00000001000109a3	pshufb	%xmm0, %xmm1
00000001000109a8	movdqu	%xmm2, -0xaf(%rbp,%r11)
00000001000109b2	movdqu	%xmm1, -0x9f(%rbp,%r11)
00000001000109bc	addq	$0x20, %r11
00000001000109c0	addq	$-0x20, %r8
00000001000109c4	cmpq	%r11, %rsi
00000001000109c7	jne	0x100010993
00000001000109c9	testq	%rdx, %rdx
00000001000109cc	je	0x100010a66
00000001000109d2	cmpl	$0x7, %edx
00000001000109d5	jbe	0x100010a3c
00000001000109d7	movq	%rcx, %rsi
00000001000109da	movl	%r10d, %edx
00000001000109dd	andl	$0x7, %edx
00000001000109e0	movq	%rax, %rcx
00000001000109e3	subq	%rdx, %rcx
00000001000109e6	movq	%rsi, %r8
00000001000109e9	negq	%r8
00000001000109ec	leaq	(%r8,%rbp), %r10
00000001000109f0	addq	$-0x70, %r10
00000001000109f4	movl	%r9d, %r8d
00000001000109f7	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
00000001000109fe	addq	%r8, %r10
0000000100010a01	addq	$-0x8, %r10
0000000100010a05	movl	%r9d, %r11d
0000000100010a08	andl	$0x7, %r11d
0000000100010a0c	subq	%r11, %r8
0000000100010a0f	movq	0x9f9(%rip), %xmm0
0000000100010a17	movq	(%r10), %xmm1
0000000100010a1c	pshufb	%xmm0, %xmm1
0000000100010a21	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100010a2a	addq	$0x8, %rsi
0000000100010a2e	addq	$-0x8, %r10
0000000100010a32	cmpq	%rsi, %r8
0000000100010a35	jne	0x100010a17
0000000100010a37	testq	%rdx, %rdx
0000000100010a3a	je	0x100010a66
0000000100010a3c	leaq	-0x70(%rbp), %rsi
0000000100010a40	addq	%rsi, %rdx
0000000100010a43	decq	%rdx
0000000100010a46	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100010a4d	nopl	(%rax)
0000000100010a50	movzbl	(%rdx), %esi
0000000100010a53	movb	%sil, -0xaf(%rbp,%rcx)
0000000100010a5b	incq	%rcx
0000000100010a5e	decq	%rdx
0000000100010a61	cmpq	%rcx, %r9
0000000100010a64	jne	0x100010a50
0000000100010a66	movb	$0x0, -0xaf(%rbp,%rax)
0000000100010a6e	jmp	0x10001042e
0000000100010a73	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100010a78	nopl	(%rax,%rax)
_fwp_format_g:
0000000100010a80	pushq	%rbp
0000000100010a81	movq	%rsp, %rbp
0000000100010a84	pushq	%r15
0000000100010a86	pushq	%r14
0000000100010a88	pushq	%r13
0000000100010a8a	pushq	%r12
0000000100010a8c	pushq	%rbx
0000000100010a8d	subq	$0x98, %rsp
0000000100010a94	movl	%esi, %r12d
0000000100010a97	movq	%rdi, %rbx
0000000100010a9a	movq	0x258f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010aa1	movq	(%rax), %rax
0000000100010aa4	movq	%rax, -0x30(%rbp)
0000000100010aa8	decl	%r12d
0000000100010aab	leaq	0x1bad(%rip), %rdx              ## literal pool for: "%.*e"
0000000100010ab2	leaq	-0x70(%rbp), %r13
0000000100010ab6	movl	$0x40, %esi
0000000100010abb	movq	%r13, %rdi
0000000100010abe	movl	%r12d, %ecx
0000000100010ac1	movsd	%xmm0, -0xb8(%rbp)
0000000100010ac9	movb	$0x1, %al
0000000100010acb	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100010ad0	movq	%r13, %rdi
0000000100010ad3	movl	$0x65, %esi
0000000100010ad8	callq	0x10001129a                     ## symbol stub for: _strchr
0000000100010add	movq	%rax, %r15
0000000100010ae0	leaq	0x1(%rax), %rdi
0000000100010ae4	callq	0x1000111b6                     ## symbol stub for: _atoi
0000000100010ae9	movl	%eax, %r14d
0000000100010aec	leal	-0x11(%r14), %eax
0000000100010af0	cmpl	$-0x17, %eax
0000000100010af3	ja	0x100010b5e
0000000100010af5	subq	%r13, %r15
0000000100010af8	leaq	-0xb0(%rbp), %r12
0000000100010aff	movl	$0x40, %ecx
0000000100010b04	movq	%r12, %rdi
0000000100010b07	movq	%r13, %rsi
0000000100010b0a	movq	%r15, %rdx
0000000100010b0d	callq	0x10001117a                     ## symbol stub for: ___memcpy_chk
0000000100010b12	movb	$0x0, -0xb0(%rbp,%r15)
0000000100010b1b	movq	%r12, %rdi
0000000100010b1e	movl	$0x2e, %esi
0000000100010b23	callq	0x10001129a                     ## symbol stub for: _strchr
0000000100010b28	testq	%rax, %rax
0000000100010b2b	sete	%al
0000000100010b2e	testq	%r15, %r15
0000000100010b31	sete	%cl
0000000100010b34	orb	%al, %cl
0000000100010b36	jne	0x100010bd6
0000000100010b3c	nopl	(%rax)
0000000100010b40	movzbl	-0xb1(%rbp,%r15), %eax
0000000100010b49	cmpl	$0x30, %eax
0000000100010b4c	jne	0x100010bc8
0000000100010b4e	movb	$0x0, -0xb1(%rbp,%r15)
0000000100010b57	decq	%r15
0000000100010b5a	jne	0x100010b40
0000000100010b5c	jmp	0x100010bd6
0000000100010b5e	subl	%r14d, %r12d
0000000100010b61	xorl	%ecx, %ecx
0000000100010b63	testl	%r12d, %r12d
0000000100010b66	cmovgl	%r12d, %ecx
0000000100010b6a	leaq	0x1afd(%rip), %rdx              ## literal pool for: "%.*f"
0000000100010b71	movl	$0x190, %esi                    ## imm = 0x190
0000000100010b76	movq	%rbx, %rdi
0000000100010b79	movsd	-0xb8(%rbp), %xmm0
0000000100010b81	movb	$0x1, %al
0000000100010b83	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100010b88	movq	%rbx, %rdi
0000000100010b8b	callq	0x1000112a6                     ## symbol stub for: _strlen
0000000100010b90	movq	%rax, %r14
0000000100010b93	movq	%rbx, %rdi
0000000100010b96	movl	$0x2e, %esi
0000000100010b9b	callq	0x10001129a                     ## symbol stub for: _strchr
0000000100010ba0	testq	%rax, %rax
0000000100010ba3	sete	%al
0000000100010ba6	testq	%r14, %r14
0000000100010ba9	sete	%cl
0000000100010bac	orb	%al, %cl
0000000100010bae	jne	0x100010c0b
0000000100010bb0	movzbl	-0x1(%rbx,%r14), %eax
0000000100010bb6	cmpl	$0x30, %eax
0000000100010bb9	jne	0x100010c2d
0000000100010bbb	movb	$0x0, -0x1(%rbx,%r14)
0000000100010bc1	decq	%r14
0000000100010bc4	jne	0x100010bb0
0000000100010bc6	jmp	0x100010c0b
0000000100010bc8	cmpl	$0x2e, %eax
0000000100010bcb	jne	0x100010bd6
0000000100010bcd	movb	$0x0, -0xb1(%rbp,%r15)
0000000100010bd6	movl	%r14d, %eax
0000000100010bd9	shrl	$0x1f, %eax
0000000100010bdc	leal	0x2b(,%rax,2), %r8d
0000000100010be4	movl	%r14d, %r9d
0000000100010be7	negl	%r9d
0000000100010bea	cmovsl	%r14d, %r9d
0000000100010bee	leaq	0x1a6f(%rip), %rdx              ## literal pool for: "%se%c%02d"
0000000100010bf5	leaq	-0xb0(%rbp), %rcx
0000000100010bfc	movl	$0x190, %esi                    ## imm = 0x190
0000000100010c01	movq	%rbx, %rdi
0000000100010c04	xorl	%eax, %eax
0000000100010c06	callq	0x10001128e                     ## symbol stub for: _snprintf
0000000100010c0b	movq	0x241e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010c12	movq	(%rax), %rax
0000000100010c15	cmpq	-0x30(%rbp), %rax
0000000100010c19	jne	0x100010c3a
0000000100010c1b	addq	$0x98, %rsp
0000000100010c22	popq	%rbx
0000000100010c23	popq	%r12
0000000100010c25	popq	%r13
0000000100010c27	popq	%r14
0000000100010c29	popq	%r15
0000000100010c2b	popq	%rbp
0000000100010c2c	retq
0000000100010c2d	cmpl	$0x2e, %eax
0000000100010c30	jne	0x100010c0b
0000000100010c32	movb	$0x0, -0x1(%rbx,%r14)
0000000100010c38	jmp	0x100010c0b
0000000100010c3a	callq	0x100011180                     ## symbol stub for: ___stack_chk_fail
0000000100010c3f	nop
_rd_leb:
0000000100010c40	movq	$0x0, (%rsi)
0000000100010c47	movq	0x8(%rdi), %r8
0000000100010c4b	movq	0x10(%rdi), %rdx
0000000100010c4f	cmpq	%rdx, %r8
0000000100010c52	jne	0x100010c57
0000000100010c54	xorl	%eax, %eax
0000000100010c56	retq
0000000100010c57	pushq	%rbp
0000000100010c58	movq	%rsp, %rbp
0000000100010c5b	movq	(%rdi), %rcx
0000000100010c5e	leaq	0x1(%rdx), %r9
0000000100010c62	movq	%r9, 0x10(%rdi)
0000000100010c66	movzbl	(%rcx,%rdx), %r10d
0000000100010c6b	andl	$0x7f, %r10d
0000000100010c6f	movq	%r10, (%rsi)
0000000100010c72	movl	$0x1, %eax
0000000100010c77	cmpb	$0x0, (%rcx,%rdx)
0000000100010c7b	js	0x100010c7f
0000000100010c7d	popq	%rbp
0000000100010c7e	retq
0000000100010c7f	cmpq	%r9, %r8
0000000100010c82	jne	0x100010c88
0000000100010c84	xorl	%eax, %eax
0000000100010c86	popq	%rbp
0000000100010c87	retq
0000000100010c88	leaq	0x2(%rdx), %r11
0000000100010c8c	movq	%r11, 0x10(%rdi)
0000000100010c90	movzbl	0x1(%rcx,%rdx), %r9d
0000000100010c96	andl	$0x7f, %r9d
0000000100010c9a	shll	$0x7, %r9d
0000000100010c9e	orq	%r10, %r9
0000000100010ca1	movq	%r9, (%rsi)
0000000100010ca4	cmpb	$0x0, 0x1(%rcx,%rdx)
0000000100010ca9	jns	0x100010c7d
0000000100010cab	cmpq	%r11, %r8
0000000100010cae	je	0x100010c84
0000000100010cb0	leaq	0x3(%rdx), %r11
0000000100010cb4	movq	%r11, 0x10(%rdi)
0000000100010cb8	movzbl	0x2(%rcx,%rdx), %r10d
0000000100010cbe	andl	$0x7f, %r10d
0000000100010cc2	shll	$0xe, %r10d
0000000100010cc6	orq	%r9, %r10
0000000100010cc9	movq	%r10, (%rsi)
0000000100010ccc	cmpb	$0x0, 0x2(%rcx,%rdx)
0000000100010cd1	jns	0x100010c7d
0000000100010cd3	cmpq	%r11, %r8
0000000100010cd6	je	0x100010c84
0000000100010cd8	leaq	0x4(%rdx), %r11
0000000100010cdc	movq	%r11, 0x10(%rdi)
0000000100010ce0	movzbl	0x3(%rcx,%rdx), %r9d
0000000100010ce6	andl	$0x7f, %r9d
0000000100010cea	shll	$0x15, %r9d
0000000100010cee	orq	%r10, %r9
0000000100010cf1	movq	%r9, (%rsi)
0000000100010cf4	cmpb	$0x0, 0x3(%rcx,%rdx)
0000000100010cf9	jns	0x100010c7d
0000000100010cfb	cmpq	%r11, %r8
0000000100010cfe	je	0x100010c84
0000000100010d00	leaq	0x5(%rdx), %r11
0000000100010d04	movq	%r11, 0x10(%rdi)
0000000100010d08	movzbl	0x4(%rcx,%rdx), %r10d
0000000100010d0e	andl	$0x7f, %r10d
0000000100010d12	shlq	$0x1c, %r10
0000000100010d16	orq	%r9, %r10
0000000100010d19	movq	%r10, (%rsi)
0000000100010d1c	cmpb	$0x0, 0x4(%rcx,%rdx)
0000000100010d21	jns	0x100010c7d
0000000100010d27	cmpq	%r11, %r8
0000000100010d2a	je	0x100010c84
0000000100010d30	leaq	0x6(%rdx), %r11
0000000100010d34	movq	%r11, 0x10(%rdi)
0000000100010d38	movzbl	0x5(%rcx,%rdx), %r9d
0000000100010d3e	andl	$0x7f, %r9d
0000000100010d42	shlq	$0x23, %r9
0000000100010d46	orq	%r10, %r9
0000000100010d49	movq	%r9, (%rsi)
0000000100010d4c	cmpb	$0x0, 0x5(%rcx,%rdx)
0000000100010d51	jns	0x100010c7d
0000000100010d57	cmpq	%r11, %r8
0000000100010d5a	je	0x100010c84
0000000100010d60	leaq	0x7(%rdx), %r11
0000000100010d64	movq	%r11, 0x10(%rdi)
0000000100010d68	movzbl	0x6(%rcx,%rdx), %r10d
0000000100010d6e	andl	$0x7f, %r10d
0000000100010d72	shlq	$0x2a, %r10
0000000100010d76	orq	%r9, %r10
0000000100010d79	movq	%r10, (%rsi)
0000000100010d7c	cmpb	$0x0, 0x6(%rcx,%rdx)
0000000100010d81	jns	0x100010c7d
0000000100010d87	cmpq	%r11, %r8
0000000100010d8a	je	0x100010c84
0000000100010d90	leaq	0x8(%rdx), %r9
0000000100010d94	movq	%r9, 0x10(%rdi)
0000000100010d98	movzbl	0x7(%rcx,%rdx), %r11d
0000000100010d9e	andl	$0x7f, %r11d
0000000100010da2	shlq	$0x31, %r11
0000000100010da6	orq	%r10, %r11
0000000100010da9	movq	%r11, (%rsi)
0000000100010dac	cmpb	$0x0, 0x7(%rcx,%rdx)
0000000100010db1	jns	0x100010c7d
0000000100010db7	cmpq	%r9, %r8
0000000100010dba	je	0x100010c84
0000000100010dc0	leaq	0x9(%rdx), %r9
0000000100010dc4	movq	%r9, 0x10(%rdi)
0000000100010dc8	movzbl	0x8(%rcx,%rdx), %r10d
0000000100010dce	andl	$0x7f, %r10d
0000000100010dd2	shlq	$0x38, %r10
0000000100010dd6	orq	%r11, %r10
0000000100010dd9	movq	%r10, (%rsi)
0000000100010ddc	cmpb	$0x0, 0x8(%rcx,%rdx)
0000000100010de1	jns	0x100010c7d
0000000100010de7	cmpq	%r9, %r8
0000000100010dea	je	0x100010c84
0000000100010df0	leaq	0xa(%rdx), %rax
0000000100010df4	movq	%rax, 0x10(%rdi)
0000000100010df8	movzbl	0x9(%rcx,%rdx), %edx
0000000100010dfd	movl	$0x0, %eax
0000000100010e02	testb	$0x7e, %dl
0000000100010e05	jne	0x100010c7d
0000000100010e0b	shlq	$0x3f, %rdx
0000000100010e0f	orq	%r10, %rdx
0000000100010e12	movq	%rdx, (%rsi)
0000000100010e15	xorl	%eax, %eax
0000000100010e17	cmpb	$0x0, (%rcx,%r9)
0000000100010e1c	setns	%al
0000000100010e1f	popq	%rbp
0000000100010e20	retq
0000000100010e21	nopw	%cs:(%rax,%rax)
_fwp_wire_empty_inner:
0000000100010e30	xorl	%eax, %eax
0000000100010e32	testq	%rdi, %rdi
0000000100010e35	je	0x100010edc
0000000100010e3b	cmpl	$0x10, (%rdi)
0000000100010e3e	jne	0x100010edc
0000000100010e44	pushq	%rbp
0000000100010e45	movq	%rsp, %rbp
0000000100010e48	pushq	%r15
0000000100010e4a	pushq	%r14
0000000100010e4c	pushq	%r12
0000000100010e4e	pushq	%rbx
0000000100010e4f	subq	$0x10, %rsp
0000000100010e53	testq	%rsi, %rsi
0000000100010e56	je	0x100010e6e
0000000100010e58	movq	%rsi, %rcx
0000000100010e5b	nopl	(%rax,%rax)
0000000100010e60	cmpq	%rdi, (%rcx)
0000000100010e63	je	0x100010ed0
0000000100010e65	movq	0x8(%rcx), %rcx
0000000100010e69	testq	%rcx, %rcx
0000000100010e6c	jne	0x100010e60
0000000100010e6e	movq	%rdi, -0x30(%rbp)
0000000100010e72	movq	%rsi, -0x28(%rbp)
0000000100010e76	movslq	0x10(%rdi), %r14
0000000100010e7a	testq	%r14, %r14
0000000100010e7d	jle	0x100010ec7
0000000100010e7f	movq	0x20(%rdi), %r15
0000000100010e83	movq	(%r15), %rdi
0000000100010e86	leaq	-0x30(%rbp), %rsi
0000000100010e8a	callq	_fwp_wire_empty_inner
0000000100010e8f	testl	%eax, %eax
0000000100010e91	je	0x100010ece
0000000100010e93	movl	$0x1, %ecx
0000000100010e98	leaq	-0x30(%rbp), %rbx
0000000100010e9c	nopl	(%rax)
0000000100010ea0	movq	%rcx, %r12
0000000100010ea3	cmpq	%rcx, %r14
0000000100010ea6	je	0x100010ebd
0000000100010ea8	movq	(%r15,%r12,8), %rdi
0000000100010eac	movq	%rbx, %rsi
0000000100010eaf	callq	_fwp_wire_empty_inner
0000000100010eb4	leaq	0x1(%r12), %rcx
0000000100010eb9	testl	%eax, %eax
0000000100010ebb	jne	0x100010ea0
0000000100010ebd	xorl	%eax, %eax
0000000100010ebf	cmpq	%r14, %r12
0000000100010ec2	setae	%al
0000000100010ec5	jmp	0x100010ed0
0000000100010ec7	movl	$0x1, %eax
0000000100010ecc	jmp	0x100010ed0
0000000100010ece	xorl	%eax, %eax
0000000100010ed0	addq	$0x10, %rsp
0000000100010ed4	popq	%rbx
0000000100010ed5	popq	%r12
0000000100010ed7	popq	%r14
0000000100010ed9	popq	%r15
0000000100010edb	popq	%rbp
0000000100010edc	retq
0000000100010edd	nopl	(%rax)
_fwp_gc_report:
0000000100010ee0	pushq	%rbp
0000000100010ee1	movq	%rsp, %rbp
0000000100010ee4	pushq	%r15
0000000100010ee6	pushq	%r14
0000000100010ee8	pushq	%r13
0000000100010eea	pushq	%r12
0000000100010eec	pushq	%rbx
0000000100010eed	subq	$0xb8, %rsp
0000000100010ef4	movq	0x431d(%rip), %rax
0000000100010efb	movq	_fwp_gc(%rip), %rcx
0000000100010f02	subq	%rcx, %rax
0000000100010f05	cvtsi2sd	%rax, %xmm0
0000000100010f0a	addsd	0x42de(%rip), %xmm0
0000000100010f12	movsd	%xmm0, -0x50(%rbp)
0000000100010f17	movsd	%xmm0, 0x42d1(%rip)
0000000100010f1f	movq	%rcx, 0x42f2(%rip)
0000000100010f26	movq	0x210b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100010f2d	movq	(%rax), %r15
0000000100010f30	movq	0x42a9(%rip), %rax
0000000100010f37	movq	%rax, -0x30(%rbp)
0000000100010f3b	movq	0x40de(%rip), %r14
0000000100010f42	movsd	0x42c6(%rip), %xmm0
0000000100010f4a	movsd	%xmm0, -0x38(%rbp)
0000000100010f4f	movq	0x40fa(%rip), %r12
0000000100010f56	movq	0x4273(%rip), %r13
0000000100010f5d	movq	0x4274(%rip), %rbx
0000000100010f64	movsd	0x428c(%rip), %xmm0
0000000100010f6c	movsd	%xmm0, -0x48(%rbp)
0000000100010f71	movsd	0x4287(%rip), %xmm0
0000000100010f79	movsd	%xmm0, -0x40(%rbp)
0000000100010f7e	leaq	-0xe0(%rbp), %rsi
0000000100010f85	xorl	%edi, %edi
0000000100010f87	callq	0x10001120a                     ## symbol stub for: _getrusage
0000000100010f8c	movq	$-0x1, %r8
0000000100010f93	testl	%eax, %eax
0000000100010f95	jne	0x100010fb0
0000000100010f97	movq	-0xc0(%rbp), %rax
0000000100010f9e	leaq	0x3ff(%rax), %r8
0000000100010fa5	testq	%rax, %rax
0000000100010fa8	cmovnsq	%rax, %r8
0000000100010fac	sarq	$0xa, %r8
0000000100010fb0	movq	%rbx, %xmm0
0000000100010fb5	movq	0x463(%rip), %xmm1
0000000100010fbd	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100010fc1	movapd	0x467(%rip), %xmm2
0000000100010fc9	subpd	%xmm2, %xmm0
0000000100010fcd	movapd	%xmm0, %xmm4
0000000100010fd1	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100010fd5	addsd	%xmm0, %xmm4
0000000100010fd9	movsd	0x4b7(%rip), %xmm6
0000000100010fe1	mulsd	%xmm6, %xmm4
0000000100010fe5	movq	%r13, %xmm5
0000000100010fea	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100010fee	subpd	%xmm2, %xmm5
0000000100010ff2	movapd	%xmm5, %xmm3
0000000100010ff6	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
0000000100010ffa	addsd	%xmm5, %xmm3
0000000100010ffe	mulsd	%xmm6, %xmm3
0000000100011002	movq	%r12, %xmm5
0000000100011007	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
000000010001100b	subpd	%xmm2, %xmm5
000000010001100f	movapd	%xmm5, %xmm2
0000000100011013	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
0000000100011017	addsd	%xmm5, %xmm2
000000010001101b	mulsd	%xmm6, %xmm2
000000010001101f	movsd	-0x50(%rbp), %xmm0
0000000100011024	movsd	-0x38(%rbp), %xmm1
0000000100011029	addsd	%xmm1, %xmm0
000000010001102d	mulsd	%xmm6, %xmm1
0000000100011031	mulsd	%xmm6, %xmm0
0000000100011035	cmpl	$0x0, 0x3fc0(%rip)
000000010001103c	leaq	0x181d(%rip), %rax              ## literal pool for: " (collection off)"
0000000100011043	leaq	0x868(%rip), %r9                ## literal pool for: ""
000000010001104a	cmoveq	%rax, %r9
000000010001104e	leaq	0x175c(%rip), %rsi              ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100011055	movq	%r15, %rdi
0000000100011058	movq	-0x30(%rbp), %rdx
000000010001105c	movq	%r14, %rcx
000000010001105f	movsd	-0x48(%rbp), %xmm5
0000000100011064	movsd	-0x40(%rbp), %xmm6
0000000100011069	movb	$0x7, %al
000000010001106b	callq	0x1000111da                     ## symbol stub for: _fprintf
0000000100011070	addq	$0xb8, %rsp
0000000100011077	popq	%rbx
0000000100011078	popq	%r12
000000010001107a	popq	%r13
000000010001107c	popq	%r14
000000010001107e	popq	%r15
0000000100011080	popq	%rbp
0000000100011081	retq
0000000100011082	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.1:
0000000100011090	pushq	%rbp
0000000100011091	movq	%rsp, %rbp
0000000100011094	pushq	$0x8
0000000100011096	popq	%rdi
0000000100011097	pushq	$0x2
0000000100011099	popq	%rsi
000000010001109a	callq	_fwp_gc_alloc_slow
000000010001109f	popq	%rbp
00000001000110a0	retq
00000001000110a1	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.2:
00000001000110b0	pushq	%rbp
00000001000110b1	movq	%rsp, %rbp
00000001000110b4	pushq	$0x1
00000001000110b6	popq	%rdi
00000001000110b7	pushq	$0x1
00000001000110b9	popq	%rsi
00000001000110ba	callq	_fwp_gc_alloc_slow
00000001000110bf	popq	%rbp
00000001000110c0	retq
00000001000110c1	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr.cold.1:
00000001000110d0	pushq	%rbp
00000001000110d1	movq	%rsp, %rbp
00000001000110d4	pushq	%rbx
00000001000110d5	pushq	%rax
00000001000110d6	movq	%rdi, %rbx
00000001000110d9	leaq	0x8e0(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
00000001000110e0	callq	0x1000111fe                     ## symbol stub for: _getenv
00000001000110e5	testq	%rax, %rax
00000001000110e8	je	0x100011101
00000001000110ea	movzbl	(%rax), %ecx
00000001000110ed	testl	%ecx, %ecx
00000001000110ef	je	0x100011108
00000001000110f1	cmpl	$0x30, %ecx
00000001000110f4	jne	0x100011105
00000001000110f6	xorl	%ecx, %ecx
00000001000110f8	cmpb	$0x0, 0x1(%rax)
00000001000110fc	setne	%cl
00000001000110ff	jmp	0x100011108
0000000100011101	xorl	%ecx, %ecx
0000000100011103	jmp	0x100011108
0000000100011105	pushq	$0x1
0000000100011107	popq	%rcx
0000000100011108	movl	%ecx, (%rbx)
000000010001110a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100011110	addq	$0x8, %rsp
0000000100011114	popq	%rbx
0000000100011115	popq	%rbp
0000000100011116	retq
0000000100011117	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
0000000100011120	pushq	%rbp
0000000100011121	movq	%rsp, %rbp
0000000100011124	pushq	%rbx
0000000100011125	pushq	%rax
0000000100011126	movq	%rdi, %rbx
0000000100011129	leaq	0x890(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100011130	callq	0x1000111fe                     ## symbol stub for: _getenv
0000000100011135	testq	%rax, %rax
0000000100011138	je	0x100011151
000000010001113a	movzbl	(%rax), %ecx
000000010001113d	testl	%ecx, %ecx
000000010001113f	je	0x100011158
0000000100011141	cmpl	$0x30, %ecx
0000000100011144	jne	0x100011155
0000000100011146	xorl	%ecx, %ecx
0000000100011148	cmpb	$0x0, 0x1(%rax)
000000010001114c	setne	%cl
000000010001114f	jmp	0x100011158
0000000100011151	xorl	%ecx, %ecx
0000000100011153	jmp	0x100011158
0000000100011155	pushq	$0x1
0000000100011157	popq	%rcx
0000000100011158	movl	%ecx, (%rbx)
000000010001115a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100011160	addq	$0x8, %rsp
0000000100011164	popq	%rbx
0000000100011165	popq	%rbp
0000000100011166	retq
