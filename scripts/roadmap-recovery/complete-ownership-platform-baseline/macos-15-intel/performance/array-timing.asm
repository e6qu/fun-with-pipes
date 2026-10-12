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
0000000100000731	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
0000000100000736	leaq	0x1141c(%rip), %rdi             ## literal pool for: "FWP_SEED"
000000010000073d	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100000742	testq	%rax, %rax
0000000100000745	je	0x10000076d
0000000100000747	movq	%rax, %rbx
000000010000074a	cmpb	$0x0, (%rax)
000000010000074d	je	0x10000076d
000000010000074f	leaq	-0x68(%rbp), %rsi
0000000100000753	movq	%rbx, %rdi
0000000100000756	movl	$0xa, %edx
000000010000075b	callq	0x1000112aa                     ## symbol stub for: _strtoull
0000000100000760	movq	-0x68(%rbp), %rax
0000000100000764	cmpb	$0x0, (%rax)
0000000100000767	je	0x10000083a
000000010000076d	leaq	-0x58(%rbp), %rsi
0000000100000771	xorl	%edi, %edi
0000000100000773	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
0000000100000778	movq	(%r14), %rdi
000000010000077b	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100000780	xorl	%esi, %esi
0000000100000782	xorl	%edx, %edx
0000000100000784	callq	0x100011256                     ## symbol stub for: _setvbuf
0000000100000789	movl	$0x1, %esi
000000010000078e	movl	$0xd, %edi
0000000100000793	callq	0x100011268                     ## symbol stub for: _signal
0000000100000798	leaq	-0x58(%rbp), %rbx
000000010000079c	movq	%rbx, %rdi
000000010000079f	callq	0x10001122c                     ## symbol stub for: _pthread_attr_init
00000001000007a4	movq	_fwp_main_stack(%rip), %rsi
00000001000007ab	movq	%rbx, %rdi
00000001000007ae	callq	0x100011232                     ## symbol stub for: _pthread_attr_setstacksize
00000001000007b3	leaq	_fwp_main_thread(%rip), %rdx
00000001000007ba	leaq	-0x70(%rbp), %rdi
00000001000007be	movq	%rbx, %rsi
00000001000007c1	xorl	%ecx, %ecx
00000001000007c3	callq	0x100011238                     ## symbol stub for: _pthread_create
00000001000007c8	testl	%eax, %eax
00000001000007ca	je	0x100000808
00000001000007cc	leaq	-0x68(%rbp), %rsi
00000001000007d0	movl	$0x3, %edi
00000001000007d5	callq	0x1000111e4                     ## symbol stub for: _getrlimit
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
000000010000080e	callq	0x10001123e                     ## symbol stub for: _pthread_join
0000000100000813	movq	(%r14), %rdi
0000000100000816	callq	0x1000111ae                     ## symbol stub for: _fflush
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
0000000100000854	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
00000001000008d2	callq	0x100011262                     ## symbol stub for: _sigaltstack
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
000000010000090b	callq	0x10001125c                     ## symbol stub for: _sigaction
0000000100000910	movl	$0xa, %edi
0000000100000915	movq	%rbx, %rsi
0000000100000918	xorl	%edx, %edx
000000010000091a	callq	0x10001125c                     ## symbol stub for: _sigaction
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
0000000100000959	leaq	0x11b5b(%rip), %rsi             ## literal pool for: "--man"
0000000100000960	movq	%rbx, %rdi
0000000100000963	callq	0x100011280                     ## symbol stub for: _strcmp
0000000100000968	testl	%eax, %eax
000000010000096a	je	0x100000a0f
0000000100000970	leaq	0x11b4a(%rip), %rsi             ## literal pool for: "--completions"
0000000100000977	movl	$0xd, %edx
000000010000097c	movq	%rbx, %rdi
000000010000097f	callq	0x10001128c                     ## symbol stub for: _strncmp
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
0000000100000a20	callq	0x1000111c6                     ## symbol stub for: _fputs
0000000100000a25	xorl	%r13d, %r13d
0000000100000a28	jmp	0x100001643
0000000100000a2d	leaq	(%rdx,%rsi), %rcx
0000000100000a31	movq	%rcx, 0x8(%rax)
0000000100000a35	movq	%rdx, -0x168(%rbp)
0000000100000a3c	movq	%rdx, %rdi
0000000100000a3f	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100000a7c	callq	0x100011286                     ## symbol stub for: _strlen
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
0000000100000b02	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100000be0	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100000cc2	callq	0x1000111fc                     ## symbol stub for: _memchr
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
0000000100000d44	leaq	0x11987(%rip), %rdi             ## literal pool for: "usage: reduce64 <Array[F64]>\n\narguments:\n  <Array[F64]>  or one per line of standard input\n\noptions:\n  -h, --help  show this help\n"
0000000100000d4b	callq	0x1000111c6                     ## symbol stub for: _fputs
0000000100000d50	movq	(%rbx), %rdi
0000000100000d53	callq	0x1000111ae                     ## symbol stub for: _fflush
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
0000000100000e9d	callq	0x10001114e                     ## symbol stub for: ___bzero
0000000100000ea2	cmpl	$0x1, %r13d
0000000100000ea6	jbe	0x100000dd1
0000000100000eac	movq	0x12185(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100000eb3	movq	(%rax), %rdi
0000000100000eb6	leaq	0x116ba(%rip), %rsi             ## literal pool for: "%s\n"
0000000100000ebd	leaq	0x117b2(%rip), %rdx             ## literal pool for: "usage: reduce64 <Array[F64]>\n  (the last argument may instead be given as records on stdin)"
0000000100000ec4	xorl	%eax, %eax
0000000100000ec6	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100000ecb	jmp	0x100000f89
0000000100000ed0	cmpq	%rax, %rcx
0000000100000ed3	jne	0x100000f4d
0000000100000ed5	leaq	0x114ec(%rip), %rdi             ## literal pool for: "FWP_OUT"
0000000100000edc	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100000ee1	testq	%rax, %rax
0000000100000ee4	je	0x100000f94
0000000100000eea	leaq	0x114df(%rip), %rsi             ## literal pool for: "bin"
0000000100000ef1	movq	%rax, %rdi
0000000100000ef4	callq	0x100011280                     ## symbol stub for: _strcmp
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
0000000100000f3e	callq	0x1000111d8                     ## symbol stub for: _fwrite
0000000100000f43	movq	(%r14), %rdi
0000000100000f46	callq	0x1000111ae                     ## symbol stub for: _fflush
0000000100000f4b	jmp	0x100000faf
0000000100000f4d	leaq	0x11801(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100000f54	movl	%r15d, %esi
0000000100000f57	movq	%r14, %rdx
0000000100000f5a	xorl	%eax, %eax
0000000100000f5c	callq	_fwp_strf
0000000100000f61	movq	0x120d0(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100000f68	movq	(%rcx), %rdi
0000000100000f6b	leaq	0x8(%rax), %r8
0000000100000f6f	leaq	0x1165d(%rip), %rsi             ## literal pool for: "%s: argument %d: %s\n"
0000000100000f76	leaq	0x10919(%rip), %rdx             ## literal pool for: "reduce64"
0000000100000f7d	movl	$0x1, %ecx
0000000100000f82	xorl	%eax, %eax
0000000100000f84	callq	0x1000111ba                     ## symbol stub for: _fprintf
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
0000000100000fd7	callq	0x1000111ae                     ## symbol stub for: _fflush
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
0000000100001013	callq	0x100011256                     ## symbol stub for: _setvbuf
0000000100001018	movq	(%r13), %rcx
000000010000101c	leaq	_fwp_in_pend(%rip), %r12
0000000100001023	movl	$0x1, %esi
0000000100001028	movl	$0x4, %edx
000000010000102d	movq	%r12, %rdi
0000000100001030	callq	0x1000111cc                     ## symbol stub for: _fread
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
0000000100001124	callq	0x1000111b4                     ## symbol stub for: _fgetc
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
0000000100001186	callq	0x1000111b4                     ## symbol stub for: _fgetc
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
00000001000011d2	callq	0x1000111cc                     ## symbol stub for: _fread
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
000000010000121d	callq	0x100011208                     ## symbol stub for: _memcpy
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
000000010000125b	callq	0x1000111cc                     ## symbol stub for: _fread
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
0000000100001323	leaq	0x10568(%rip), %rax             ## literal pool for: ""
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
000000010000140e	callq	0x10001114e                     ## symbol stub for: ___bzero
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
000000010000150b	callq	0x1000111cc                     ## symbol stub for: _fread
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
00000001000015a4	callq	0x1000111ae                     ## symbol stub for: _fflush
00000001000015a9	cmpl	$0x0, -0x174(%rbp)
00000001000015b0	jne	0x100001af3
00000001000015b6	movq	%r14, %rdi
00000001000015b9	callq	_fwp_emit_result
00000001000015be	movq	0x11a83(%rip), %rax             ## literal pool symbol address: ___stdoutp
00000001000015c5	movq	(%rax), %rdi
00000001000015c8	callq	0x1000111ae                     ## symbol stub for: _fflush
00000001000015cd	jmp	0x100001079
00000001000015d2	leaq	0x10e57(%rip), %rsi             ## literal pool for: "%s: truncated frame\n"
00000001000015d9	movq	0x11a58(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000015e0	movq	(%rax), %rdi
00000001000015e3	leaq	0x102ac(%rip), %rdx             ## literal pool for: "reduce64"
00000001000015ea	xorl	%eax, %eax
00000001000015ec	callq	0x1000111ba                     ## symbol stub for: _fprintf
00000001000015f1	movl	$0x3, %r13d
00000001000015f7	movq	-0x150(%rbp), %rdi
00000001000015fe	callq	0x1000111d2                     ## symbol stub for: _free
0000000100001603	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000160a	je	0x100001634
000000010000160c	movq	0x11a35(%rip), %rbx             ## literal pool symbol address: ___stdoutp
0000000100001613	movq	(%rbx), %rcx
0000000100001616	leaq	_fwp_exec.end(%rip), %rdi
000000010000161d	movl	$0x1, %esi
0000000100001622	movl	$0x5, %edx
0000000100001627	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000162c	movq	(%rbx), %rdi
000000010000162f	callq	0x1000111ae                     ## symbol stub for: _fflush
0000000100001634	movq	0x11a0d(%rip), %rax             ## literal pool symbol address: ___stdoutp
000000010000163b	movq	(%rax), %rdi
000000010000163e	callq	0x1000111ae                     ## symbol stub for: _fflush
0000000100001643	movl	%r13d, _fwp_exit_code(%rip)
000000010000164a	movq	0x119f7(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001651	movq	(%rax), %rdi
0000000100001654	callq	0x1000111ae                     ## symbol stub for: _fflush
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
0000000100001691	leaq	0x10e37(%rip), %rsi             ## literal pool for: "%s: option `--completions` needs a value (bash, zsh or fish)\n"
0000000100001698	leaq	0x101f7(%rip), %rdx             ## literal pool for: "reduce64"
000000010000169f	jmp	0x100000ec4
00000001000016a4	movq	0x10(%r13), %rbx
00000001000016a8	leaq	0x10e5e(%rip), %rsi             ## literal pool for: "bash"
00000001000016af	movq	%rbx, %rdi
00000001000016b2	callq	0x100011280                     ## symbol stub for: _strcmp
00000001000016b7	xorl	%r13d, %r13d
00000001000016ba	testl	%eax, %eax
00000001000016bc	je	0x100001727
00000001000016be	leaq	0x10e4d(%rip), %rsi             ## literal pool for: "zsh"
00000001000016c5	movq	%rbx, %rdi
00000001000016c8	callq	0x100011280                     ## symbol stub for: _strcmp
00000001000016cd	testl	%eax, %eax
00000001000016cf	je	0x100001a97
00000001000016d5	leaq	0x10e3a(%rip), %rsi             ## literal pool for: "fish"
00000001000016dc	movq	%rbx, %rdi
00000001000016df	callq	0x100011280                     ## symbol stub for: _strcmp
00000001000016e4	testl	%eax, %eax
00000001000016e6	je	0x100001a9e
00000001000016ec	movq	%rbx, %rdi
00000001000016ef	callq	0x100011286                     ## symbol stub for: _strlen
00000001000016f4	movq	%rbx, %rdi
00000001000016f7	movq	%rax, %rsi
00000001000016fa	callq	_fwp_str_lossy
00000001000016ff	movq	0x11932(%rip), %rcx             ## literal pool symbol address: ___stderrp
0000000100001706	movq	(%rcx), %rdi
0000000100001709	leaq	0x8(%rax), %rcx
000000010000170d	leaq	0x10e07(%rip), %rsi             ## literal pool for: "%s: unknown shell `%s` (bash, zsh or fish)\n"
0000000100001714	leaq	0x1017b(%rip), %rdx             ## literal pool for: "reduce64"
000000010000171b	xorl	%eax, %eax
000000010000171d	callq	0x1000111ba                     ## symbol stub for: _fprintf
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
000000010000176e	callq	0x1000111cc                     ## symbol stub for: _fread
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
0000000100001804	callq	0x1000111cc                     ## symbol stub for: _fread
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
00000001000018b6	callq	0x100011208                     ## symbol stub for: _memcpy
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
0000000100001928	callq	0x100011208                     ## symbol stub for: _memcpy
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
000000010000195e	callq	0x1000111cc                     ## symbol stub for: _fread
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
0000000100001995	callq	0x1000111cc                     ## symbol stub for: _fread
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
0000000100001a50	pxor	0xf878(%rip), %xmm0
0000000100001a58	ptest	%xmm0, %xmm0
0000000100001a5d	je	0x100001b9c
0000000100001a63	movq	0x115ce(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001a6a	movq	(%rax), %rdi
0000000100001a6d	leaq	0x1098a(%rip), %rsi             ## literal pool for: "%s: input type mismatch: expected `%s`, got `%s`\n"
0000000100001a74	leaq	0xfe1b(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001a7b	leaq	0x10cd3(%rip), %rcx             ## literal pool for: "Array[F64]"
0000000100001a82	movq	%r14, %r8
0000000100001a85	xorl	%eax, %eax
0000000100001a87	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100001a8c	movl	$0x3, %r13d
0000000100001a92	jmp	0x100001643
0000000100001a97	movl	$0x1, %eax
0000000100001a9c	jmp	0x100001aa3
0000000100001a9e	movl	$0x2, %eax
0000000100001aa3	leaq	_fwp_cli_scripts(%rip), %rcx
0000000100001aaa	movq	(%rcx,%rax,8), %rdi
0000000100001aae	movq	0x11593(%rip), %rax             ## literal pool symbol address: ___stdoutp
0000000100001ab5	movq	(%rax), %rsi
0000000100001ab8	callq	0x1000111c6                     ## symbol stub for: _fputs
0000000100001abd	jmp	0x100001643
0000000100001ac2	movq	0x1156f(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001ac9	movq	(%rax), %rdi
0000000100001acc	movl	(%r15), %ecx
0000000100001acf	leaq	0x1099a(%rip), %rsi             ## literal pool for: "%s: cannot parse input `%.*s` as %s\n"
0000000100001ad6	leaq	0xfdb9(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001add	leaq	0x10c71(%rip), %r9              ## literal pool for: "Array[F64]"
0000000100001ae4	movq	%r14, %r8
0000000100001ae7	xorl	%eax, %eax
0000000100001ae9	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100001aee	jmp	0x1000015f1
0000000100001af3	movl	$0x1, %r13d
0000000100001af9	jmp	0x1000015f7
0000000100001afe	xorl	%r13d, %r13d
0000000100001b01	jmp	0x1000015f7
0000000100001b06	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
0000000100001b0b	jmp	0x100001b31
0000000100001b0d	leaq	0x10931(%rip), %rsi             ## literal pool for: "%s: bad switch frame\n"
0000000100001b14	jmp	0x1000015d9
0000000100001b19	movq	0x11518(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b20	movq	(%rax), %rdi
0000000100001b23	leaq	0x10931(%rip), %rsi             ## literal pool for: "%s: malformed value\n"
0000000100001b2a	jmp	0x1000015e3
0000000100001b2f	xorl	%eax, %eax
0000000100001b31	testl	%eax, %eax
0000000100001b33	js	0x100001b5f
0000000100001b35	movq	0x114fc(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b3c	movq	(%rax), %rdi
0000000100001b3f	leaq	0x1095f(%rip), %rsi             ## literal pool for: "%s: truncated header\n"
0000000100001b46	leaq	0xfd49(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001b4d	xorl	%eax, %eax
0000000100001b4f	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100001b54	movl	$0x3, %r13d
0000000100001b5a	jmp	0x100001643
0000000100001b5f	movq	0x114d2(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b66	movq	(%rax), %rdi
0000000100001b69	leaq	0x10925(%rip), %rsi             ## literal pool for: "%s: bad header\n"
0000000100001b70	jmp	0x100001b46
0000000100001b72	movq	0x114bf(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100001b79	movq	(%rax), %rdi
0000000100001b7c	leaq	0x10856(%rip), %rsi             ## literal pool for: "%s: unsupported protocol version %d\n"
0000000100001b83	leaq	0xfd0c(%rip), %rdx              ## literal pool for: "reduce64"
0000000100001b8a	xorl	%eax, %eax
0000000100001b8c	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100001b91	movl	$0x3, %r13d
0000000100001b97	jmp	0x100001643
0000000100001b9c	movl	$0x0, -0x170(%rbp)
0000000100001ba6	jmp	0x100001062
0000000100001bab	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100001c18	leaq	0xfaf1(%rip), %rdi              ## literal pool for: "{\"samples\":["
0000000100001c1f	callq	0x100011244                     ## symbol stub for: _puts
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
0000000100001c77	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
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
0000000100001cd6	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
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
0000000100001e0e	mulsd	0xf61a(%rip), %xmm0
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
0000000100001e45	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
0000000100001e4a	movdqa	-0x50(%rbp), %xmm0
0000000100001e4f	movdqa	%xmm0, -0xa0(%rbp)
0000000100001e57	pxor	%xmm0, %xmm0
0000000100001e5b	movq	%xmm0, -0x58(%rbp)
0000000100001e60	movsd	0xf5d0(%rip), %xmm2
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
0000000100001ecf	mulsd	0xf569(%rip), %xmm1
0000000100001ed7	addsd	0xf569(%rip), %xmm1
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
0000000100001f0b	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
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
0000000100001f69	leaq	0xf91f(%rip), %rsi              ## literal pool for: ",\n"
0000000100001f70	leaq	0xf91b(%rip), %rax              ## literal pool for: ""
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
0000000100001fc7	leaq	0xf78b(%rip), %rdi              ## literal pool for: "%s{\"allocationInclusiveNs\":%llu,\"kernelNs\":%llu,\"hash\":\"%016llx\",\"requests\":%llu,\"requestedBytes\":%llu,\"liveChargedBytes\":%ld,\"peakChargedBytes\":%zu,\"retains\":%llu,\"nonlastReleases\":%llu,\"releaseChecks\":%llu,\"collections\":%zu,\"collectionPauseSeconds\":%.9f,\"chunkHighWaterBytes\":%zu,\"reservedVirtualBytes\":%zu}"
0000000100001fce	movq	%r12, %r8
0000000100001fd1	xorl	%r9d, %r9d
0000000100001fd4	movb	$0x1, %al
0000000100001fd6	callq	0x100011226                     ## symbol stub for: _printf
0000000100001fdb	incq	%rbx
0000000100001fde	cmpq	$0x5, %rbx
0000000100001fe2	jne	0x100001c40
0000000100001fe8	leaq	0xf8a4(%rip), %rdi              ## literal pool for: "]}"
0000000100001fef	callq	0x100011244                     ## symbol stub for: _puts
0000000100001ff4	xorl	%eax, %eax
0000000100001ff6	jmp	0x100002018
0000000100001ff8	subq	%rax, %rcx
0000000100001ffb	movq	0x11036(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002002	movq	(%rax), %rdi
0000000100002005	leaq	0xf711(%rip), %rsi              ## literal pool for: "unexpected collection or retained charged storage: %zu %ld\n"
000000010000200c	xorl	%eax, %eax
000000010000200e	callq	0x1000111ba                     ## symbol stub for: _fprintf
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
0000000100002056	callq	0x10001117e                     ## symbol stub for: __dyld_image_count
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
0000000100002082	callq	0x10001117e                     ## symbol stub for: __dyld_image_count
0000000100002087	cmpl	%eax, %ebx
0000000100002089	jae	0x100002164
000000010000208f	movl	%ebx, %edi
0000000100002091	callq	0x100011172                     ## symbol stub for: __dyld_get_image_header
0000000100002096	testq	%rax, %rax
0000000100002099	je	0x100002080
000000010000209b	cmpl	$0xfeedfacf, (%rax)             ## imm = 0xFEEDFACF
00000001000020a1	jne	0x100002080
00000001000020a3	movl	%ebx, %edi
00000001000020a5	movq	%rax, %r12
00000001000020a8	callq	0x100011178                     ## symbol stub for: __dyld_get_image_vmaddr_slide
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
0000000100002193	callq	0x100011190                     ## symbol stub for: _atexit
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
0000000100002201	leaq	0xf767(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002208	leaq	0x10551(%rip), %rdx             ## literal pool for: "too many program data segments for the collector"
000000010000220f	xorl	%eax, %eax
0000000100002211	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100002216	movl	$0x65, %edi
000000010000221b	callq	0x1000111a8                     ## symbol stub for: _exit
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
0000000100002258	leaq	0xf401(%rip), %rcx
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
0000000100002391	callq	0x10001114e                     ## symbol stub for: ___bzero
0000000100002396	movq	%rbx, (%r14)
0000000100002399	movq	%r14, %rax
000000010000239c	popq	%rbx
000000010000239d	popq	%r14
000000010000239f	popq	%rbp
00000001000023a0	retq
00000001000023a1	callq	_fwp_flush
00000001000023a6	movq	0x10c8b(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000023ad	movq	(%rax), %rdi
00000001000023b0	leaq	0xf5b8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000023b7	leaq	0x10494(%rip), %rdx             ## literal pool for: "array too large"
00000001000023be	xorl	%eax, %eax
00000001000023c0	callq	0x1000111ba                     ## symbol stub for: _fprintf
00000001000023c5	movl	$0x65, %edi
00000001000023ca	callq	0x1000111a8                     ## symbol stub for: _exit
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
0000000100002429	leaq	0xf53f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002430	leaq	0x1042b(%rip), %rdx             ## literal pool for: "internal: mutating an array view"
0000000100002437	xorl	%eax, %eax
0000000100002439	callq	0x1000111ba                     ## symbol stub for: _fprintf
000000010000243e	movl	$0x65, %edi
0000000100002443	callq	0x1000111a8                     ## symbol stub for: _exit
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
0000000100002478	movsd	0xefb8(%rip), %xmm2
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
00000001000024eb	mulsd	0xef4d(%rip), %xmm1
00000001000024f3	addsd	0xef4d(%rip), %xmm1
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
00000001000025a9	mulss	0xeecf(%rip), %xmm0
00000001000025b1	addss	0xeecb(%rip), %xmm0
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
000000010000274d	leaq	0xf232(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002754	leaq	0xf258(%rip), %rcx              ## literal pool for: "I8"
000000010000275b	jmp	0x10000276b
000000010000275d	leaq	0xf222(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002764	leaq	0xf217(%rip), %rcx              ## literal pool for: "I64"
000000010000276b	leaq	-0x90(%rbp), %rbx
0000000100002772	movl	$0x60, %esi
0000000100002777	movq	%rbx, %rdi
000000010000277a	xorl	%eax, %eax
000000010000277c	callq	0x10001126e                     ## symbol stub for: _snprintf
0000000100002781	callq	_fwp_flush
0000000100002786	movq	0x108ab(%rip), %rax             ## literal pool symbol address: ___stderrp
000000010000278d	movq	(%rax), %rdi
0000000100002790	leaq	0xf1d8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002797	movq	%rbx, %rdx
000000010000279a	xorl	%eax, %eax
000000010000279c	callq	0x1000111ba                     ## symbol stub for: _fprintf
00000001000027a1	movl	$0x65, %edi
00000001000027a6	callq	0x1000111a8                     ## symbol stub for: _exit
00000001000027ab	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100002918	leaq	0xf067(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
000000010000291f	leaq	0xf08d(%rip), %rcx              ## literal pool for: "I8"
0000000100002926	leaq	-0x90(%rbp), %rbx
000000010000292d	movl	$0x60, %esi
0000000100002932	movq	%rbx, %rdi
0000000100002935	xorl	%eax, %eax
0000000100002937	callq	0x10001126e                     ## symbol stub for: _snprintf
000000010000293c	callq	_fwp_flush
0000000100002941	movq	0x106f0(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002948	movq	(%rax), %rdi
000000010000294b	leaq	0xf01d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002952	movq	%rbx, %rdx
0000000100002955	xorl	%eax, %eax
0000000100002957	callq	0x1000111ba                     ## symbol stub for: _fprintf
000000010000295c	movl	$0x65, %edi
0000000100002961	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100002966	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
00000001000029b9	leaq	0xefc6(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000029c0	leaq	0xefec(%rip), %rcx              ## literal pool for: "I8"
00000001000029c7	leaq	-0x70(%rbp), %rbx
00000001000029cb	movl	$0x60, %esi
00000001000029d0	movq	%rbx, %rdi
00000001000029d3	xorl	%eax, %eax
00000001000029d5	callq	0x10001126e                     ## symbol stub for: _snprintf
00000001000029da	callq	_fwp_flush
00000001000029df	movq	0x10652(%rip), %rax             ## literal pool symbol address: ___stderrp
00000001000029e6	movq	(%rax), %rdi
00000001000029e9	leaq	0xef7f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000029f0	movq	%rbx, %rdx
00000001000029f3	xorl	%eax, %eax
00000001000029f5	callq	0x1000111ba                     ## symbol stub for: _fprintf
00000001000029fa	movl	$0x65, %edi
00000001000029ff	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100002a04	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100002b52	leaq	0xee2d(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100002b59	leaq	0xee22(%rip), %rcx              ## literal pool for: "I64"
0000000100002b60	leaq	-0x70(%rbp), %rbx
0000000100002b64	movl	$0x60, %esi
0000000100002b69	movq	%rbx, %rdi
0000000100002b6c	xorl	%eax, %eax
0000000100002b6e	callq	0x10001126e                     ## symbol stub for: _snprintf
0000000100002b73	callq	_fwp_flush
0000000100002b78	movq	0x104b9(%rip), %rax             ## literal pool symbol address: ___stderrp
0000000100002b7f	movq	(%rax), %rdi
0000000100002b82	leaq	0xede6(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100002b89	movq	%rbx, %rdx
0000000100002b8c	xorl	%eax, %eax
0000000100002b8e	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100002b93	movl	$0x65, %edi
0000000100002b98	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100002b9d	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100003089	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
00000001000030fc	callq	0x1000111d2                     ## symbol stub for: _free
0000000100003101	decq	0x12918(%rip)
0000000100003108	popq	%rbp
0000000100003109	retq
000000010000310a	callq	_fwp_flush
000000010000310f	movq	0xff22(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003116	movq	(%rax), %rdi
0000000100003119	leaq	0xe84f(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100003120	leaq	0xe821(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
0000000100003127	xorl	%eax, %eax
0000000100003129	callq	0x1000111ba                     ## symbol stub for: _fprintf
000000010000312e	movl	$0x65, %edi
0000000100003133	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100003138	nopl	(%rax,%rax)
_fwp_flush:
0000000100003140	pushq	%rbp
0000000100003141	movq	%rsp, %rbp
0000000100003144	movq	_fwp_prog_out(%rip), %rdi
000000010000314b	testq	%rdi, %rdi
000000010000314e	je	0x100003155
0000000100003150	callq	0x1000111ae                     ## symbol stub for: _fflush
0000000100003155	movq	0xfeec(%rip), %rax              ## literal pool symbol address: ___stdoutp
000000010000315c	movq	(%rax), %rdi
000000010000315f	popq	%rbp
0000000100003160	jmp	0x1000111ae                     ## symbol stub for: _fflush
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
000000010000339d	leaq	0xe5cb(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000033a4	leaq	0xe59d(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000033ab	xorl	%eax, %eax
00000001000033ad	callq	0x1000111ba                     ## symbol stub for: _fprintf
00000001000033b2	movl	$0x65, %edi
00000001000033b7	callq	0x1000111a8                     ## symbol stub for: _exit
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
00000001000034d8	callq	0x10001114e                     ## symbol stub for: ___bzero
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
000000010000369d	leaq	0xe014(%rip), %rax
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
00000001000039e5	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100003ae8	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100003b11	movaps	0xd7c8(%rip), %xmm0
0000000100003b18	movups	%xmm0, 0x11031(%rip)
0000000100003b1f	movaps	0xd7ca(%rip), %xmm0
0000000100003b26	movups	%xmm0, 0x11033(%rip)
0000000100003b2d	movaps	0xd7cc(%rip), %xmm0
0000000100003b34	movups	%xmm0, 0x11035(%rip)
0000000100003b3b	movaps	0xd7ce(%rip), %xmm0
0000000100003b42	movups	%xmm0, 0x11037(%rip)
0000000100003b49	movaps	0xd7d0(%rip), %xmm0
0000000100003b50	movups	%xmm0, 0x11039(%rip)
0000000100003b57	movaps	0xd7d2(%rip), %xmm0
0000000100003b5e	movups	%xmm0, 0x1103b(%rip)
0000000100003b65	movaps	0xd7d4(%rip), %xmm0
0000000100003b6c	movups	%xmm0, 0x1103d(%rip)
0000000100003b73	movaps	0xd7d6(%rip), %xmm0
0000000100003b7a	movups	%xmm0, 0x1103f(%rip)
0000000100003b81	movaps	0xd7d8(%rip), %xmm0
0000000100003b88	movups	%xmm0, 0x11041(%rip)
0000000100003b8f	movaps	0xd7da(%rip), %xmm0
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
0000000100003c30	callq	0x10001121a                     ## symbol stub for: _mmap
0000000100003c35	cmpq	$-0x1, %rax
0000000100003c39	jne	0x100003c9b
0000000100003c3b	movabsq	$0x400000000, %rbx              ## imm = 0x400000000
0000000100003c45	leaq	0x10000(%rbx), %rsi
0000000100003c4c	xorl	%edi, %edi
0000000100003c4e	xorl	%edx, %edx
0000000100003c50	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c55	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c5b	xorl	%r9d, %r9d
0000000100003c5e	callq	0x10001121a                     ## symbol stub for: _mmap
0000000100003c63	cmpq	$-0x1, %rax
0000000100003c67	jne	0x100003c9b
0000000100003c69	movabsq	$__mh_execute_header, %rbx
0000000100003c73	leaq	0x10000(%rbx), %rsi
0000000100003c7a	xorl	%edi, %edi
0000000100003c7c	xorl	%edx, %edx
0000000100003c7e	movl	$0x1042, %ecx                   ## imm = 0x1042
0000000100003c83	movl	$0xffffffff, %r8d               ## imm = 0xFFFFFFFF
0000000100003c89	xorl	%r9d, %r9d
0000000100003c8c	callq	0x10001121a                     ## symbol stub for: _mmap
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
0000000100003cfa	callq	0x10001121a                     ## symbol stub for: _mmap
0000000100003cff	cmpq	$-0x1, %rax
0000000100003d03	je	0x100003eae
0000000100003d09	movq	%rax, 0x11370(%rip)
0000000100003d10	leaq	0xdc9f(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003d17	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100003d1c	movl	$0x1, %r14d
0000000100003d22	testq	%rax, %rax
0000000100003d25	je	0x100003d52
0000000100003d27	movq	%rax, %rbx
0000000100003d2a	leaq	0xdc8c(%rip), %rsi              ## literal pool for: "off"
0000000100003d31	movq	%rax, %rdi
0000000100003d34	callq	0x100011280                     ## symbol stub for: _strcmp
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
0000000100003d59	leaq	0xdc61(%rip), %rdi              ## literal pool for: "FWP_GC_STATS"
0000000100003d60	callq	0x1000111de                     ## symbol stub for: _getenv
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
0000000100003d90	leaq	0xdc1f(%rip), %rdi              ## literal pool for: "FWP_GC"
0000000100003d97	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100003d9c	testq	%rax, %rax
0000000100003d9f	je	0x100003db9
0000000100003da1	leaq	0xdc26(%rip), %rsi              ## literal pool for: "full"
0000000100003da8	movq	%rax, %rdi
0000000100003dab	callq	0x100011280                     ## symbol stub for: _strcmp
0000000100003db0	xorl	%ecx, %ecx
0000000100003db2	testl	%eax, %eax
0000000100003db4	setne	%cl
0000000100003db7	jmp	0x100003dbe
0000000100003db9	movl	$0x1, %ecx
0000000100003dbe	movl	%ecx, 0x11244(%rip)
0000000100003dc4	movl	$0x1, 0x11242(%rip)
0000000100003dce	leaq	0xdbfe(%rip), %rdi              ## literal pool for: "FWP_GC_VERIFY"
0000000100003dd5	callq	0x1000111de                     ## symbol stub for: _getenv
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
0000000100003e05	leaq	0xdbd5(%rip), %rdi              ## literal pool for: "FWP_GC_STRESS"
0000000100003e0c	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100003e11	testq	%rax, %rax
0000000100003e14	je	0x100003e20
0000000100003e16	movq	%rax, %rdi
0000000100003e19	callq	0x10001119c                     ## symbol stub for: _atol
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
0000000100003e64	callq	0x10001121a                     ## symbol stub for: _mmap
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
0000000100003e95	callq	0x10001121a                     ## symbol stub for: _mmap
0000000100003e9a	leaq	0x1(%rax), %rcx
0000000100003e9e	cmpq	$0x2, %rcx
0000000100003ea2	jb	0x100003eae
0000000100003ea4	movl	$0x10000000, %ebx               ## imm = 0x10000000
0000000100003ea9	jmp	0x100003ca4
0000000100003eae	movq	0xf183(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100003eb5	movq	(%rax), %rcx
0000000100003eb8	leaq	0xdb30(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100003ebf	movl	$0x13, %esi
0000000100003ec4	movl	$0x1, %edx
0000000100003ec9	callq	0x1000111d8                     ## symbol stub for: _fwrite
0000000100003ece	movl	$0x66, %edi
0000000100003ed3	callq	0x1000111a8                     ## symbol stub for: _exit
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
000000010000407d	callq	0x10001114e                     ## symbol stub for: ___bzero
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
00000001000040b1	leaq	0xd937(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000040b8	movl	$0x13, %esi
00000001000040bd	movl	$0x1, %edx
00000001000040c2	callq	0x1000111d8                     ## symbol stub for: _fwrite
00000001000040c7	movl	$0x66, %edi
00000001000040cc	callq	0x1000111a8                     ## symbol stub for: _exit
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
000000010000428a	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000428f	shlq	$0x10, %r14
0000000100004293	addq	0x10d9e(%rip), %r14
000000010000429a	cmpl	$0x0, 0x10d6b(%rip)
00000001000042a1	je	0x1000042b0
00000001000042a3	movl	$0x10000, %esi                  ## imm = 0x10000
00000001000042a8	movq	%r14, %rdi
00000001000042ab	callq	0x10001114e                     ## symbol stub for: ___bzero
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
00000001000043d7	callq	0x100011220                     ## symbol stub for: _mprotect
00000001000043dc	testl	%eax, %eax
00000001000043de	jne	0x10000445a
00000001000043e0	movl	$0x1d, %edi
00000001000043e5	callq	0x1000112b0                     ## symbol stub for: _sysconf
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
0000000100004421	callq	0x100011220                     ## symbol stub for: _mprotect
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
0000000100004464	leaq	0xd584(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000446b	movl	$0x13, %esi
0000000100004470	movl	$0x1, %edx
0000000100004475	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000447a	movl	$0x66, %edi
000000010000447f	callq	0x1000111a8                     ## symbol stub for: _exit
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
00000001000044d5	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
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
0000000100004596	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000459b	movq	0x10ade(%rip), %rax
00000001000045a2	movq	0x10ab7(%rip), %rcx
00000001000045a9	jmp	0x100004556
00000001000045ab	movb	%r15b, -0xd1(%rbp)
00000001000045b2	leaq	-0xd0(%rbp), %rdi
00000001000045b9	callq	0x100011250                     ## symbol stub for: _setjmp
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
00000001000046fd	callq	0x100011250                     ## symbol stub for: _setjmp
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
000000010000479a	callq	0x1000111f6                     ## symbol stub for: _malloc
000000010000479f	movq	%rax, %rbx
00000001000047a2	cmpq	$0x1, %r14
00000001000047a6	movq	%r14, %rdi
00000001000047a9	adcq	$0x0, %rdi
00000001000047ad	movq	%rdi, -0x150(%rbp)
00000001000047b4	callq	0x1000111f6                     ## symbol stub for: _malloc
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
0000000100004820	callq	0x1000111d2                     ## symbol stub for: _free
0000000100004825	movq	%r12, %rdi
0000000100004828	callq	0x1000111d2                     ## symbol stub for: _free
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
0000000100004905	callq	0x1000111a2                     ## symbol stub for: _clock_gettime
000000010000490a	movq	-0x160(%rbp), %rax
0000000100004911	movq	-0x158(%rbp), %rcx
0000000100004918	subq	-0x170(%rbp), %rax
000000010000491f	cvtsi2sd	%rax, %xmm1
0000000100004924	mulsd	0xcb24(%rip), %xmm1
000000010000492c	subq	-0x168(%rbp), %rcx
0000000100004933	xorps	%xmm0, %xmm0
0000000100004936	cvtsi2sd	%rcx, %xmm0
000000010000493b	divsd	0xcb15(%rip), %xmm0
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
00000001000049e4	callq	0x100011208                     ## symbol stub for: _memcpy
00000001000049e9	movzbl	-0x124d(%r13), %eax
00000001000049f1	movb	%al, (%r12,%r15)
00000001000049f5	movq	%r14, %rdi
00000001000049f8	movq	%r13, %rsi
00000001000049fb	movq	%rbx, %rdx
00000001000049fe	callq	0x100011208                     ## symbol stub for: _memcpy
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
0000000100004a67	callq	0x100011208                     ## symbol stub for: _memcpy
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
0000000100004ad2	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100004bc9	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100004bfb	leaq	0xce01(%rip), %rsi              ## literal pool for: "fwp gc verify: a minor collection missed the reachable object at %p (kind %d, %zu bytes)\n"
0000000100004c02	xorl	%r14d, %r14d
0000000100004c05	movl	%r14d, %eax
0000000100004c08	movq	%r15, %rdx
0000000100004c0b	movq	%rbx, %r8
0000000100004c0e	movb	%r14b, -0xd2(%rbp)
0000000100004c15	callq	0x1000111ba                     ## symbol stub for: _fprintf
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
0000000100004d8e	leaq	0xccc8(%rip), %rsi              ## literal pool for: "  from the old object at %p (kind %d, %u bytes), word %zu; its first words %lx %lx %lx\n"
0000000100004d95	movq	%rbx, %rdx
0000000100004d98	movq	%r14, %r9
0000000100004d9b	movzbl	-0xd2(%rbp), %eax
0000000100004da2	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100004da7	movl	0x8(%r12), %r8d
0000000100004dac	jmp	0x100004d40
0000000100004dae	callq	0x10001118a                     ## symbol stub for: _abort
0000000100004db3	movq	0xe27e(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100004dba	movq	(%rax), %rcx
0000000100004dbd	leaq	0xcc2b(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
0000000100004dc4	movl	$0x13, %esi
0000000100004dc9	movl	$0x1, %edx
0000000100004dce	callq	0x1000111d8                     ## symbol stub for: _fwrite
0000000100004dd3	movl	$0x66, %edi
0000000100004dd8	callq	0x1000111a8                     ## symbol stub for: _exit
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
000000010000508d	callq	0x10001114e                     ## symbol stub for: ___bzero
0000000100005092	cmpq	$0x0, 0xffc6(%rip)
000000010000509a	je	0x100005554
00000001000050a0	movq	$0x0, -0x30(%rbp)
00000001000050a8	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
00000001000050b2	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
00000001000050bc	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
00000001000050c6	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
00000001000050d0	movdqa	0xc2a8(%rip), %xmm6
00000001000050d8	movdqa	0xc2b0(%rip), %xmm7
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
000000010000539e	callq	0x10001114e                     ## symbol stub for: ___bzero
00000001000053a3	pxor	%xmm8, %xmm8
00000001000053a8	movdqa	0xbfe0(%rip), %xmm7
00000001000053b0	movdqa	0xbfc8(%rip), %xmm6
00000001000053b8	jmp	0x100005350
00000001000053ba	movq	%rbx, %rdi
00000001000053bd	callq	_fwp_rc_forget_slot
00000001000053c2	pxor	%xmm8, %xmm8
00000001000053c7	movdqa	0xbfc1(%rip), %xmm7
00000001000053cf	movdqa	0xbfa9(%rip), %xmm6
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
000000010000542a	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000542f	movb	$0x0, (%r13)
0000000100005434	incq	%r15
0000000100005437	movabsq	$0x5555555555555555, %r9        ## imm = 0x5555555555555555
0000000100005441	movabsq	$0x3333333333333333, %r10       ## imm = 0x3333333333333333
000000010000544b	movabsq	$0xf0f0f0f0f0f0f0f, %r11        ## imm = 0xF0F0F0F0F0F0F0F
0000000100005455	movabsq	$0x101010101010101, %rbx        ## imm = 0x101010101010101
000000010000545f	movdqa	0xbf19(%rip), %xmm6
0000000100005467	movdqa	0xbf21(%rip), %xmm7
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
000000010000553f	movdqa	0xbe49(%rip), %xmm7
0000000100005547	movdqa	0xbe31(%rip), %xmm6
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
0000000100005671	callq	0x1000111f0                     ## symbol stub for: _madvise
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
0000000100005992	callq	0x10001124a                     ## symbol stub for: _realloc
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
00000001000059d3	leaq	0xc015(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000059da	movl	$0x13, %esi
00000001000059df	movl	$0x1, %edx
00000001000059e4	callq	0x1000111d8                     ## symbol stub for: _fwrite
00000001000059e9	movl	$0x66, %edi
00000001000059ee	callq	0x1000111a8                     ## symbol stub for: _exit
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
0000000100005cf6	mulsd	0xb742(%rip), %xmm0
0000000100005cfe	addsd	0xb742(%rip), %xmm0
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
0000000100005fda	callq	0x10001118a                     ## symbol stub for: _abort
0000000100005fdf	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100006153	callq	0x1000111f6                     ## symbol stub for: _malloc
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
00000001000061b3	leaq	0xb7b5(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
00000001000061ba	leaq	0xb787(%rip), %rdx              ## literal pool for: "internal: missing wide reference count"
00000001000061c1	jmp	0x100006229
00000001000061c3	movq	0xce6e(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061ca	movq	(%rax), %rcx
00000001000061cd	leaq	0xb81b(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
00000001000061d4	movl	$0x13, %esi
00000001000061d9	movl	$0x1, %edx
00000001000061de	callq	0x1000111d8                     ## symbol stub for: _fwrite
00000001000061e3	movl	$0x66, %edi
00000001000061e8	callq	0x1000111a8                     ## symbol stub for: _exit
00000001000061ed	callq	_fwp_flush
00000001000061f2	movq	0xce3f(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000061f9	movq	(%rax), %rdi
00000001000061fc	leaq	0xb76c(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006203	leaq	0xb8af(%rip), %rdx              ## literal pool for: "internal: stale wide reference count"
000000010000620a	jmp	0x100006229
000000010000620c	callq	_fwp_flush
0000000100006211	movq	0xce20(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100006218	movq	(%rax), %rdi
000000010000621b	leaq	0xb74d(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100006222	leaq	0xb8b5(%rip), %rdx              ## literal pool for: "reference count overflow"
0000000100006229	xorl	%eax, %eax
000000010000622b	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100006230	movl	$0x65, %edi
0000000100006235	callq	0x1000111a8                     ## symbol stub for: _exit
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
00000001000064b8	leaq	0xaf61(%rip), %rsi
00000001000064bf	addq	$0x8, %rsp
00000001000064c3	popq	%rbx
00000001000064c4	popq	%r14
00000001000064c6	popq	%r15
00000001000064c8	popq	%rbp
00000001000064c9	jmp	0x100011214                     ## symbol stub for: _memset_pattern16
00000001000064ce	movl	0x8(%rbx), %edx
00000001000064d1	movq	%rdi, %rbx
00000001000064d4	movl	$0xdd, %esi
00000001000064d9	callq	0x10001120e                     ## symbol stub for: _memset
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
0000000100006d2d	callq	0x10001118a                     ## symbol stub for: _abort
0000000100006d32	nopw	%cs:(%rax,%rax)
_fwp_preempt:
0000000100006d40	movl	_fwp_slice(%rip), %ecx
0000000100006d46	testl	%ecx, %ecx
0000000100006d48	je	0x100006d51
0000000100006d4a	movl	%ecx, _fwp_budget(%rip)
0000000100006d50	retq
0000000100006d51	pushq	%rbp
0000000100006d52	movq	%rsp, %rbp
0000000100006d55	leaq	0xad9b(%rip), %rdi              ## literal pool for: "FWP_PREEMPT"
0000000100006d5c	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100006d61	movq	%rax, %rdi
0000000100006d64	movl	$0x2710, %eax                   ## imm = 0x2710
0000000100006d69	testq	%rdi, %rdi
0000000100006d6c	je	0x100006d7f
0000000100006d6e	cmpb	$0x0, (%rdi)
0000000100006d71	je	0x100006d7f
0000000100006d73	xorl	%esi, %esi
0000000100006d75	movl	$0xa, %edx
0000000100006d7a	callq	0x1000112a4                     ## symbol stub for: _strtoll
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
0000000100006ec1	callq	0x100011148                     ## symbol stub for: ____chkstk_darwin
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
0000000100007165	callq	0x10001114e                     ## symbol stub for: ___bzero
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
000000010000735f	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
00000001000075b7	callq	0x100011148                     ## symbol stub for: ____chkstk_darwin
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
0000000100007c54	callq	0x10001118a                     ## symbol stub for: _abort
0000000100007c59	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
0000000100007ce2	callq	0x10001114e                     ## symbol stub for: ___bzero
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
0000000100007e9c	callq	0x1000111d2                     ## symbol stub for: _free
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
0000000100007ec7	leaq	0x9aa1(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007ece	leaq	0x9c2e(%rip), %rdx              ## literal pool for: "internal: owned closure without capture types"
0000000100007ed5	xorl	%eax, %eax
0000000100007ed7	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100007edc	movl	$0x65, %edi
0000000100007ee1	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100007ee6	callq	0x10001118a                     ## symbol stub for: _abort
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
0000000100007f1e	callq	0x1000111f6                     ## symbol stub for: _malloc
0000000100007f23	testq	%rax, %rax
0000000100007f26	je	0x100007fb0
0000000100007f2c	movq	%rax, %r15
0000000100007f2f	leaq	(,%r13,2), %rax
0000000100007f37	movq	%rax, -0x30(%rbp)
0000000100007f3b	movq	(%r14), %r12
0000000100007f3e	leaq	(,%r13,8), %rdx
0000000100007f46	movq	%r15, %rdi
0000000100007f49	movq	%r12, %rsi
0000000100007f4c	callq	0x100011208                     ## symbol stub for: _memcpy
0000000100007f51	leaq	0x18(%r14), %rax
0000000100007f55	cmpq	%rax, %r12
0000000100007f58	je	0x100007f66
0000000100007f5a	movq	%r12, %rdi
0000000100007f5d	callq	0x1000111d2                     ## symbol stub for: _free
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
0000000100007fa0	leaq	0x99c8(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007fa7	leaq	0x9b83(%rip), %rdx              ## literal pool for: "closure cleanup too large"
0000000100007fae	jmp	0x100007fcd
0000000100007fb0	callq	_fwp_flush
0000000100007fb5	movq	0xb07c(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100007fbc	movq	(%rax), %rdi
0000000100007fbf	leaq	0x99a9(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100007fc6	leaq	0x9b7e(%rip), %rdx              ## literal pool for: "out of memory"
0000000100007fcd	xorl	%eax, %eax
0000000100007fcf	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100007fd4	movl	$0x65, %edi
0000000100007fd9	callq	0x1000111a8                     ## symbol stub for: _exit
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
0000000100008006	callq	0x1000111d2                     ## symbol stub for: _free
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
0000000100008325	mulss	0x9153(%rip), %xmm1
000000010000832d	addss	0x914f(%rip), %xmm1
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
000000010000860a	callq	0x10001118a                     ## symbol stub for: _abort
000000010000860f	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
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
00000001000089b1	leaq	-0xd0(%rbp), %rax
00000001000089b8	movq	%rax, -0x118(%rbp)
00000001000089bf	leaq	_fwp_owner_release19(%rip), %rax
00000001000089c6	movq	%rax, -0x110(%rbp)
00000001000089cd	leaq	-0xb8(%rbp), %rax
00000001000089d4	movq	%rax, -0x108(%rbp)
00000001000089db	leaq	-0x118(%rbp), %r15
00000001000089e2	movq	%r15, _fwp_cleanups(%rip)
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
0000000100008a62	ja	0x100008f6d
0000000100008a68	incb	%al
0000000100008a6a	movb	%al, (%rdi)
0000000100008a6c	movq	0x10(%rbx), %r14
0000000100008a70	movq	%r14, -0xb8(%rbp)
0000000100008a77	movq	-0x118(%rbp), %rax
0000000100008a7e	movq	%rax, _fwp_cleanups(%rip)
0000000100008a85	movq	0x8(%rbx), %r12
0000000100008a89	movq	0x18(%rbx), %r13
0000000100008a8d	testq	%r12, %r12
0000000100008a90	js	0x100008ab9
0000000100008a92	movq	(%r14), %rax
0000000100008a95	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
0000000100008a9f	andq	%rax, %rcx
0000000100008aa2	cmpq	%r12, %rcx
0000000100008aa5	jbe	0x100008ab9
0000000100008aa7	testq	%rax, %rax
0000000100008aaa	js	0x100008b89
0000000100008ab0	leaq	0x8(%r14), %rax
0000000100008ab4	jmp	0x100008b8d
0000000100008ab9	movq	%r14, %rdi
0000000100008abc	callq	_fwp_drop0
0000000100008ac1	movq	%r13, -0x90(%rbp)
0000000100008ac8	movl	$0x10, %edi
0000000100008acd	callq	_fwp_alloc_init
0000000100008ad2	movq	%rax, %r14
0000000100008ad5	movabsq	$0x100000001, %rax              ## imm = 0x100000001
0000000100008adf	movq	%rax, (%r14)
0000000100008ae2	movq	%r13, 0x8(%r14)
0000000100008ae6	leaq	-0x90(%rbp), %rax
0000000100008aed	movq	%r14, %rax
0000000100008af0	subq	0xc541(%rip), %rax
0000000100008af7	movq	0xc562(%rip), %rcx
0000000100008afe	shlq	$0x10, %rcx
0000000100008b02	cmpq	%rcx, %rax
0000000100008b05	leaq	-0xd0(%rbp), %r12
0000000100008b0c	jae	0x100008f29
0000000100008b12	movq	0xc567(%rip), %rcx
0000000100008b19	movq	%rax, %rdx
0000000100008b1c	shrq	$0x10, %rdx
0000000100008b20	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008b27	leaq	(%rcx,%rdx), %r15
0000000100008b2b	movzbl	(%rcx,%rdx), %ecx
0000000100008b2f	cmpb	$0x2, %cl
0000000100008b32	setne	%dl
0000000100008b35	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008b3b	setne	%sil
0000000100008b3f	orb	%dl, %sil
0000000100008b42	jne	0x100008b5a
0000000100008b44	addq	$0x228, %r15                    ## imm = 0x228
0000000100008b4b	cmpb	$-0x1, (%r15)
0000000100008b4f	je	0x100008b7f
0000000100008b51	movb	$0x1, (%r15)
0000000100008b55	jmp	0x100008f29
0000000100008b5a	cmpb	$0x1, %cl
0000000100008b5d	jne	0x100008f29
0000000100008b63	movl	0x20(%r15), %ecx
0000000100008b67	imulq	%rcx, %rax
0000000100008b6b	shrq	$0x20, %rax
0000000100008b6f	addq	%rax, %r15
0000000100008b72	addq	$0x228, %r15                    ## imm = 0x228
0000000100008b79	cmpb	$-0x1, (%r15)
0000000100008b7d	jne	0x100008b51
0000000100008b7f	movq	%r15, %rdi
0000000100008b82	callq	_fwp_rc_forget_slot
0000000100008b87	jmp	0x100008b51
0000000100008b89	movq	0x10(%r14), %rax
0000000100008b8d	movsbq	(%rax,%r12), %rcx
0000000100008b92	movq	_fwp_cleanups(%rip), %rax
0000000100008b99	movq	%r14, -0x100(%rbp)
0000000100008ba0	movq	%rax, -0x178(%rbp)
0000000100008ba7	leaq	_fwp_owner_release13(%rip), %rdx
0000000100008bae	movq	%rdx, -0x170(%rbp)
0000000100008bb5	leaq	-0x100(%rbp), %rdx
0000000100008bbc	movq	%rdx, -0x168(%rbp)
0000000100008bc3	leaq	-0x178(%rbp), %rdx
0000000100008bca	movq	%rdx, _fwp_cleanups(%rip)
0000000100008bd1	addq	$-0x7f, %rcx
0000000100008bd5	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
0000000100008bdc	jbe	0x100008fab
0000000100008be2	movq	%r14, -0xf8(%rbp)
0000000100008be9	movq	%rax, -0x148(%rbp)
0000000100008bf0	leaq	_fwp_owner_release14(%rip), %rax
0000000100008bf7	movq	%rax, -0x140(%rbp)
0000000100008bfe	leaq	-0xf8(%rbp), %rax
0000000100008c05	movq	%rax, -0x138(%rbp)
0000000100008c0c	leaq	-0x148(%rbp), %r15
0000000100008c13	movq	%r14, %rax
0000000100008c16	subq	0xc41b(%rip), %rax
0000000100008c1d	movq	%r15, _fwp_cleanups(%rip)
0000000100008c24	movq	0xc435(%rip), %rcx
0000000100008c2b	shlq	$0x10, %rcx
0000000100008c2f	cmpq	%rcx, %rax
0000000100008c32	jae	0x100008c9c
0000000100008c34	movq	0xc445(%rip), %rcx
0000000100008c3b	movq	%rax, %rdx
0000000100008c3e	shrq	$0x10, %rdx
0000000100008c42	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008c49	leaq	(%rcx,%rdx), %rdi
0000000100008c4d	movzbl	(%rcx,%rdx), %ecx
0000000100008c51	cmpb	$0x2, %cl
0000000100008c54	setne	%dl
0000000100008c57	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008c5d	setne	%sil
0000000100008c61	orb	%dl, %sil
0000000100008c64	jne	0x100008c6f
0000000100008c66	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008c6d	jmp	0x100008c89
0000000100008c6f	cmpb	$0x1, %cl
0000000100008c72	jne	0x100008c9c
0000000100008c74	movl	0x20(%rdi), %ecx
0000000100008c77	imulq	%rcx, %rax
0000000100008c7b	shrq	$0x20, %rax
0000000100008c7f	addq	%rax, %rdi
0000000100008c82	addq	$0x228, %rdi                    ## imm = 0x228
0000000100008c89	movzbl	(%rdi), %eax
0000000100008c8c	testb	%al, %al
0000000100008c8e	je	0x100008c9c
0000000100008c90	cmpb	$-0x3, %al
0000000100008c92	ja	0x100008f8f
0000000100008c98	incb	%al
0000000100008c9a	movb	%al, (%rdi)
0000000100008c9c	movq	-0x148(%rbp), %rax
0000000100008ca3	movq	%rax, _fwp_cleanups(%rip)
0000000100008caa	movq	%r14, %rdi
0000000100008cad	callq	_fwp_drop0
0000000100008cb2	movq	%r14, -0xf0(%rbp)
0000000100008cb9	movq	_fwp_cleanups(%rip), %rax
0000000100008cc0	movq	%rax, -0x160(%rbp)
0000000100008cc7	leaq	_fwp_owner_release15(%rip), %rcx
0000000100008cce	movq	%rcx, -0x158(%rbp)
0000000100008cd5	leaq	-0xf0(%rbp), %rcx
0000000100008cdc	movq	%rcx, -0x150(%rbp)
0000000100008ce3	leaq	-0x160(%rbp), %rcx
0000000100008cea	movq	%rcx, _fwp_cleanups(%rip)
0000000100008cf1	incq	%r13
0000000100008cf4	jo	0x100008fbb
0000000100008cfa	incq	%r12
0000000100008cfd	movq	%r14, -0xe8(%rbp)
0000000100008d04	movq	%rax, -0x90(%rbp)
0000000100008d0b	leaq	_fwp_owner_release16(%rip), %rax
0000000100008d12	movq	%rax, -0x88(%rbp)
0000000100008d19	leaq	-0xe8(%rbp), %rax
0000000100008d20	movq	%rax, -0x80(%rbp)
0000000100008d24	leaq	-0x90(%rbp), %rax
0000000100008d2b	movq	%rax, _fwp_cleanups(%rip)
0000000100008d32	movq	%r12, -0xa8(%rbp)
0000000100008d39	movq	%r14, -0xa0(%rbp)
0000000100008d40	movq	%r13, -0x98(%rbp)
0000000100008d47	movl	$0x20, %edi
0000000100008d4c	callq	_fwp_alloc_init
0000000100008d51	movq	%rax, %r15
0000000100008d54	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100008d5e	movq	%rax, (%r15)
0000000100008d61	movq	%r12, 0x8(%r15)
0000000100008d65	movq	%r14, 0x10(%r15)
0000000100008d69	movq	%r13, 0x18(%r15)
0000000100008d6d	leaq	-0xa8(%rbp), %rax
0000000100008d74	movq	%r15, %rax
0000000100008d77	subq	0xc2ba(%rip), %rax
0000000100008d7e	movq	0xc2db(%rip), %rcx
0000000100008d85	shlq	$0x10, %rcx
0000000100008d89	cmpq	%rcx, %rax
0000000100008d8c	jae	0x100008dfe
0000000100008d8e	movq	0xc2eb(%rip), %rcx
0000000100008d95	movq	%rax, %rdx
0000000100008d98	shrq	$0x10, %rdx
0000000100008d9c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008da3	leaq	(%rcx,%rdx), %r14
0000000100008da7	movzbl	(%rcx,%rdx), %ecx
0000000100008dab	cmpb	$0x2, %cl
0000000100008dae	setne	%dl
0000000100008db1	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008db7	setne	%sil
0000000100008dbb	orb	%dl, %sil
0000000100008dbe	jne	0x100008dd3
0000000100008dc0	addq	$0x228, %r14                    ## imm = 0x228
0000000100008dc7	cmpb	$-0x1, (%r14)
0000000100008dcb	je	0x100008df4
0000000100008dcd	movb	$0x1, (%r14)
0000000100008dd1	jmp	0x100008dfe
0000000100008dd3	cmpb	$0x1, %cl
0000000100008dd6	jne	0x100008dfe
0000000100008dd8	movl	0x20(%r14), %ecx
0000000100008ddc	imulq	%rcx, %rax
0000000100008de0	shrq	$0x20, %rax
0000000100008de4	addq	%rax, %r14
0000000100008de7	addq	$0x228, %r14                    ## imm = 0x228
0000000100008dee	cmpb	$-0x1, (%r14)
0000000100008df2	jne	0x100008dcd
0000000100008df4	movq	%r14, %rdi
0000000100008df7	callq	_fwp_rc_forget_slot
0000000100008dfc	jmp	0x100008dcd
0000000100008dfe	leaq	-0x90(%rbp), %rax
0000000100008e05	cmpq	%rax, _fwp_cleanups(%rip)
0000000100008e0c	jne	0x100008fa1
0000000100008e12	movq	-0x90(%rbp), %rax
0000000100008e19	movq	%r15, -0xe0(%rbp)
0000000100008e20	movq	%rax, -0x130(%rbp)
0000000100008e27	leaq	_fwp_owner_release17(%rip), %rax
0000000100008e2e	movq	%rax, -0x128(%rbp)
0000000100008e35	leaq	-0xe0(%rbp), %rax
0000000100008e3c	movq	%rax, -0x120(%rbp)
0000000100008e43	leaq	-0x130(%rbp), %r12
0000000100008e4a	movq	%r12, _fwp_cleanups(%rip)
0000000100008e51	movq	%r15, -0xb0(%rbp)
0000000100008e58	movl	$0x10, %edi
0000000100008e5d	callq	_fwp_alloc_init
0000000100008e62	movq	%rax, %r14
0000000100008e65	movabsq	$__mh_execute_header, %rax
0000000100008e6f	movq	%rax, (%r14)
0000000100008e72	movq	%r15, 0x8(%r14)
0000000100008e76	leaq	-0xb0(%rbp), %rax
0000000100008e7d	movq	%r14, %rax
0000000100008e80	subq	0xc1b1(%rip), %rax
0000000100008e87	movq	0xc1d2(%rip), %rcx
0000000100008e8e	shlq	$0x10, %rcx
0000000100008e92	cmpq	%rcx, %rax
0000000100008e95	jae	0x100008f07
0000000100008e97	movq	0xc1e2(%rip), %rcx
0000000100008e9e	movq	%rax, %rdx
0000000100008ea1	shrq	$0x10, %rdx
0000000100008ea5	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100008eac	leaq	(%rcx,%rdx), %r15
0000000100008eb0	movzbl	(%rcx,%rdx), %ecx
0000000100008eb4	cmpb	$0x2, %cl
0000000100008eb7	setne	%dl
0000000100008eba	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100008ec0	setne	%sil
0000000100008ec4	orb	%dl, %sil
0000000100008ec7	jne	0x100008edc
0000000100008ec9	addq	$0x228, %r15                    ## imm = 0x228
0000000100008ed0	cmpb	$-0x1, (%r15)
0000000100008ed4	je	0x100008efd
0000000100008ed6	movb	$0x1, (%r15)
0000000100008eda	jmp	0x100008f07
0000000100008edc	cmpb	$0x1, %cl
0000000100008edf	jne	0x100008f07
0000000100008ee1	movl	0x20(%r15), %ecx
0000000100008ee5	imulq	%rcx, %rax
0000000100008ee9	shrq	$0x20, %rax
0000000100008eed	addq	%rax, %r15
0000000100008ef0	addq	$0x228, %r15                    ## imm = 0x228
0000000100008ef7	cmpb	$-0x1, (%r15)
0000000100008efb	jne	0x100008ed6
0000000100008efd	movq	%r15, %rdi
0000000100008f00	callq	_fwp_rc_forget_slot
0000000100008f05	jmp	0x100008ed6
0000000100008f07	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008f0e	jne	0x100008fa1
0000000100008f14	movq	-0x130(%rbp), %rax
0000000100008f1b	movq	%rax, _fwp_cleanups(%rip)
0000000100008f22	leaq	-0xd0(%rbp), %r12
0000000100008f29	cmpq	%r12, _fwp_cleanups(%rip)
0000000100008f30	jne	0x100008fa1
0000000100008f32	movq	-0xd0(%rbp), %rax
0000000100008f39	movq	%rax, _fwp_cleanups(%rip)
0000000100008f40	movq	%rbx, %rdi
0000000100008f43	callq	_fwp_drop5
0000000100008f48	movq	0xa0e1(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100008f4f	movq	(%rax), %rax
0000000100008f52	cmpq	-0x30(%rbp), %rax
0000000100008f56	jne	0x100008fa6
0000000100008f58	movq	%r14, %rax
0000000100008f5b	addq	$0x158, %rsp                    ## imm = 0x158
0000000100008f62	popq	%rbx
0000000100008f63	popq	%r12
0000000100008f65	popq	%r13
0000000100008f67	popq	%r14
0000000100008f69	popq	%r15
0000000100008f6b	popq	%rbp
0000000100008f6c	retq
0000000100008f6d	callq	_fwp_rc_wide_dup
0000000100008f72	movq	_fwp_cleanups(%rip), %rax
0000000100008f79	movq	0x10(%rbx), %r14
0000000100008f7d	movq	%r14, -0xb8(%rbp)
0000000100008f84	cmpq	%r15, %rax
0000000100008f87	je	0x100008a77
0000000100008f8d	jmp	0x100008fa1
0000000100008f8f	callq	_fwp_rc_wide_dup
0000000100008f94	cmpq	%r15, _fwp_cleanups(%rip)
0000000100008f9b	je	0x100008c9c
0000000100008fa1	callq	0x10001118a                     ## symbol stub for: _abort
0000000100008fa6	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
0000000100008fab	leaq	0x89d4(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100008fb2	leaq	0x89fa(%rip), %rcx              ## literal pool for: "I8"
0000000100008fb9	jmp	0x100008fc9
0000000100008fbb	leaq	0x89c4(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
0000000100008fc2	leaq	0x89b9(%rip), %rcx              ## literal pool for: "I64"
0000000100008fc9	leaq	-0x90(%rbp), %rbx
0000000100008fd0	movl	$0x60, %esi
0000000100008fd5	movq	%rbx, %rdi
0000000100008fd8	xorl	%eax, %eax
0000000100008fda	callq	0x10001126e                     ## symbol stub for: _snprintf
0000000100008fdf	callq	_fwp_flush
0000000100008fe4	movq	0xa04d(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100008feb	movq	(%rax), %rdi
0000000100008fee	leaq	0x897a(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100008ff5	movq	%rbx, %rdx
0000000100008ff8	xorl	%eax, %eax
0000000100008ffa	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100008fff	movl	$0x65, %edi
0000000100009004	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100009009	nopl	(%rax)
_fwp_owner_release18:
0000000100009010	pushq	%rbp
0000000100009011	movq	%rsp, %rbp
0000000100009014	movq	(%rdi), %rdi
0000000100009017	popq	%rbp
0000000100009018	jmp	_fwp_drop5
000000010000901d	nopl	(%rax)
_fwp_owner_release19:
0000000100009020	pushq	%rbp
0000000100009021	movq	%rsp, %rbp
0000000100009024	movq	(%rdi), %rdi
0000000100009027	popq	%rbp
0000000100009028	jmp	_fwp_drop0
000000010000902d	nopl	(%rax)
_fwp_drop5:
0000000100009030	movq	%rdi, %rcx
0000000100009033	subq	0xbffe(%rip), %rcx
000000010000903a	movq	0xc01f(%rip), %rax
0000000100009041	shlq	$0x10, %rax
0000000100009045	cmpq	%rax, %rcx
0000000100009048	jae	0x1000090de
000000010000904e	movq	0xc02b(%rip), %rdx
0000000100009055	movq	%rcx, %rax
0000000100009058	shrq	$0x10, %rax
000000010000905c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009063	leaq	(%rdx,%rsi), %rax
0000000100009067	movzbl	(%rdx,%rsi), %edx
000000010000906b	cmpb	$0x2, %dl
000000010000906e	setne	%sil
0000000100009072	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009079	setne	%r8b
000000010000907d	orb	%sil, %r8b
0000000100009080	jne	0x10000908a
0000000100009082	addq	$0x228, %rax                    ## imm = 0x228
0000000100009088	jmp	0x1000090a3
000000010000908a	cmpb	$0x1, %dl
000000010000908d	jne	0x1000090de
000000010000908f	movl	0x20(%rax), %edx
0000000100009092	imulq	%rdx, %rcx
0000000100009096	shrq	$0x20, %rcx
000000010000909a	addq	%rcx, %rax
000000010000909d	addq	$0x228, %rax                    ## imm = 0x228
00000001000090a3	movzbl	(%rax), %ecx
00000001000090a6	testl	%ecx, %ecx
00000001000090a8	je	0x1000090de
00000001000090aa	cmpl	$0x1, %ecx
00000001000090ad	jne	0x1000090d2
00000001000090af	pushq	%rbp
00000001000090b0	movq	%rsp, %rbp
00000001000090b3	pushq	%rbx
00000001000090b4	pushq	%rax
00000001000090b5	movq	0x10(%rdi), %rax
00000001000090b9	movq	%rdi, %rbx
00000001000090bc	movq	%rax, %rdi
00000001000090bf	callq	_fwp_drop0
00000001000090c4	movq	%rbx, %rdi
00000001000090c7	addq	$0x8, %rsp
00000001000090cb	popq	%rbx
00000001000090cc	popq	%rbp
00000001000090cd	jmp	_fwp_rc_free_obj
00000001000090d2	cmpl	$0xff, %ecx
00000001000090d8	je	0x1000090df
00000001000090da	decb	%cl
00000001000090dc	movb	%cl, (%rax)
00000001000090de	retq
00000001000090df	movq	%rax, %rdi
00000001000090e2	jmp	_fwp_rc_wide_drop
00000001000090e7	nopw	(%rax,%rax)
_fwp_owner_release13:
00000001000090f0	pushq	%rbp
00000001000090f1	movq	%rsp, %rbp
00000001000090f4	movq	(%rdi), %rdi
00000001000090f7	popq	%rbp
00000001000090f8	jmp	_fwp_drop0
00000001000090fd	nopl	(%rax)
_fwp_owner_release14:
0000000100009100	pushq	%rbp
0000000100009101	movq	%rsp, %rbp
0000000100009104	movq	(%rdi), %rdi
0000000100009107	popq	%rbp
0000000100009108	jmp	_fwp_drop0
000000010000910d	nopl	(%rax)
_fwp_owner_release15:
0000000100009110	pushq	%rbp
0000000100009111	movq	%rsp, %rbp
0000000100009114	movq	(%rdi), %rdi
0000000100009117	popq	%rbp
0000000100009118	jmp	_fwp_drop0
000000010000911d	nopl	(%rax)
_fwp_owner_release16:
0000000100009120	pushq	%rbp
0000000100009121	movq	%rsp, %rbp
0000000100009124	movq	(%rdi), %rdi
0000000100009127	popq	%rbp
0000000100009128	jmp	_fwp_drop0
000000010000912d	nopl	(%rax)
_fwp_owner_release17:
0000000100009130	pushq	%rbp
0000000100009131	movq	%rsp, %rbp
0000000100009134	movq	(%rdi), %rax
0000000100009137	subq	0xbefa(%rip), %rax
000000010000913e	movq	0xbf1b(%rip), %rcx
0000000100009145	shlq	$0x10, %rcx
0000000100009149	cmpq	%rcx, %rax
000000010000914c	jae	0x1000091b2
000000010000914e	movq	0xbf2b(%rip), %rcx
0000000100009155	movq	%rax, %rdx
0000000100009158	shrq	$0x10, %rdx
000000010000915c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009163	leaq	(%rcx,%rdx), %rdi
0000000100009167	movzbl	(%rcx,%rdx), %ecx
000000010000916b	cmpb	$0x2, %cl
000000010000916e	setne	%dl
0000000100009171	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009177	setne	%sil
000000010000917b	orb	%dl, %sil
000000010000917e	jne	0x100009189
0000000100009180	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009187	jmp	0x1000091a3
0000000100009189	cmpb	$0x1, %cl
000000010000918c	jne	0x1000091b2
000000010000918e	movl	0x20(%rdi), %ecx
0000000100009191	imulq	%rcx, %rax
0000000100009195	shrq	$0x20, %rax
0000000100009199	addq	%rax, %rdi
000000010000919c	addq	$0x228, %rdi                    ## imm = 0x228
00000001000091a3	movzbl	(%rdi), %eax
00000001000091a6	cmpb	$0x2, %al
00000001000091a8	jb	0x1000091b2
00000001000091aa	cmpb	$-0x1, %al
00000001000091ac	je	0x1000091b4
00000001000091ae	decb	%al
00000001000091b0	movb	%al, (%rdi)
00000001000091b2	popq	%rbp
00000001000091b3	retq
00000001000091b4	popq	%rbp
00000001000091b5	jmp	_fwp_rc_wide_drop
00000001000091ba	nopw	(%rax,%rax)
_fwp_owned_entry35:
00000001000091c0	pushq	%rbp
00000001000091c1	movq	%rsp, %rbp
00000001000091c4	movq	(%rdi), %rdi
00000001000091c7	popq	%rbp
00000001000091c8	jmp	_f35
00000001000091cd	nopl	(%rax)
_fwp_caps35:
00000001000091d0	movl	0x4(%rdi), %eax
00000001000091d3	testl	%esi, %esi
00000001000091d5	je	0x100009239
00000001000091d7	testl	%eax, %eax
00000001000091d9	je	0x100009291
00000001000091df	movq	0x8(%rdi), %rax
00000001000091e3	subq	0xbe4e(%rip), %rax
00000001000091ea	movq	0xbe6f(%rip), %rcx
00000001000091f1	shlq	$0x10, %rcx
00000001000091f5	cmpq	%rcx, %rax
00000001000091f8	jae	0x100009291
00000001000091fe	movq	0xbe7b(%rip), %rcx
0000000100009205	movq	%rax, %rdx
0000000100009208	shrq	$0x10, %rdx
000000010000920c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009213	leaq	(%rcx,%rdx), %rdi
0000000100009217	movzbl	(%rcx,%rdx), %ecx
000000010000921b	cmpb	$0x2, %cl
000000010000921e	setne	%dl
0000000100009221	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009227	setne	%sil
000000010000922b	orb	%dl, %sil
000000010000922e	jne	0x100009264
0000000100009230	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009237	jmp	0x10000927e
0000000100009239	testl	%eax, %eax
000000010000923b	je	_fwp_rc_free_obj
0000000100009241	pushq	%rbp
0000000100009242	movq	%rsp, %rbp
0000000100009245	pushq	%rbx
0000000100009246	pushq	%rax
0000000100009247	movq	0x8(%rdi), %rax
000000010000924b	movq	%rdi, %rbx
000000010000924e	movq	%rax, %rdi
0000000100009251	callq	_fwp_drop5
0000000100009256	movq	%rbx, %rdi
0000000100009259	addq	$0x8, %rsp
000000010000925d	popq	%rbx
000000010000925e	popq	%rbp
000000010000925f	jmp	_fwp_rc_free_obj
0000000100009264	cmpb	$0x1, %cl
0000000100009267	jne	0x100009291
0000000100009269	movl	0x20(%rdi), %ecx
000000010000926c	imulq	%rcx, %rax
0000000100009270	shrq	$0x20, %rax
0000000100009274	addq	%rax, %rdi
0000000100009277	addq	$0x228, %rdi                    ## imm = 0x228
000000010000927e	movzbl	(%rdi), %eax
0000000100009281	testb	%al, %al
0000000100009283	je	0x100009291
0000000100009285	cmpb	$-0x2, %al
0000000100009287	jae	_fwp_rc_wide_dup
000000010000928d	incb	%al
000000010000928f	movb	%al, (%rdi)
0000000100009291	retq
0000000100009292	nopw	%cs:(%rax,%rax)
_fwp_args35:
00000001000092a0	pushq	%rbp
00000001000092a1	movq	%rsp, %rbp
00000001000092a4	testl	%esi, %esi
00000001000092a6	setne	%al
00000001000092a9	testl	%edx, %edx
00000001000092ab	sete	%cl
00000001000092ae	orb	%al, %cl
00000001000092b0	jne	0x100009330
00000001000092b2	movq	(%rdi), %rax
00000001000092b5	subq	0xbd7c(%rip), %rax
00000001000092bc	movq	0xbd9d(%rip), %rcx
00000001000092c3	shlq	$0x10, %rcx
00000001000092c7	cmpq	%rcx, %rax
00000001000092ca	jae	0x100009330
00000001000092cc	movq	0xbdad(%rip), %rcx
00000001000092d3	movq	%rax, %rdx
00000001000092d6	shrq	$0x10, %rdx
00000001000092da	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000092e1	leaq	(%rcx,%rdx), %rdi
00000001000092e5	movzbl	(%rcx,%rdx), %ecx
00000001000092e9	cmpb	$0x2, %cl
00000001000092ec	setne	%dl
00000001000092ef	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000092f5	setne	%sil
00000001000092f9	orb	%dl, %sil
00000001000092fc	jne	0x100009307
00000001000092fe	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009305	jmp	0x100009321
0000000100009307	cmpb	$0x1, %cl
000000010000930a	jne	0x100009330
000000010000930c	movl	0x20(%rdi), %ecx
000000010000930f	imulq	%rcx, %rax
0000000100009313	shrq	$0x20, %rax
0000000100009317	addq	%rax, %rdi
000000010000931a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009321	movzbl	(%rdi), %eax
0000000100009324	testb	%al, %al
0000000100009326	je	0x100009330
0000000100009328	cmpb	$-0x2, %al
000000010000932a	jae	0x100009332
000000010000932c	incb	%al
000000010000932e	movb	%al, (%rdi)
0000000100009330	popq	%rbp
0000000100009331	retq
0000000100009332	popq	%rbp
0000000100009333	jmp	_fwp_rc_wide_dup
0000000100009338	nopl	(%rax,%rax)
_fwp_arg_drop35:
0000000100009340	pushq	%rbp
0000000100009341	movq	%rsp, %rbp
0000000100009344	testl	%esi, %esi
0000000100009346	setne	%al
0000000100009349	testl	%edx, %edx
000000010000934b	sete	%cl
000000010000934e	orb	%al, %cl
0000000100009350	je	0x100009354
0000000100009352	popq	%rbp
0000000100009353	retq
0000000100009354	movq	(%rdi), %rdi
0000000100009357	popq	%rbp
0000000100009358	jmp	_fwp_drop5
000000010000935d	nopl	(%rax)
_f37:
0000000100009360	pushq	%rbp
0000000100009361	movq	%rsp, %rbp
0000000100009364	pushq	%r15
0000000100009366	pushq	%r14
0000000100009368	pushq	%r13
000000010000936a	pushq	%r12
000000010000936c	pushq	%rbx
000000010000936d	subq	$0x158, %rsp                    ## imm = 0x158
0000000100009374	movq	%rdi, %rbx
0000000100009377	movq	0x9cb2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000937e	movq	(%rax), %rax
0000000100009381	movq	%rax, -0x30(%rbp)
0000000100009385	movq	%rdi, -0xd8(%rbp)
000000010000938c	movq	_fwp_cleanups(%rip), %rax
0000000100009393	movq	%rax, -0xd0(%rbp)
000000010000939a	leaq	_fwp_owner_release26(%rip), %rax
00000001000093a1	movq	%rax, -0xc8(%rbp)
00000001000093a8	leaq	-0xd8(%rbp), %rax
00000001000093af	movq	%rax, -0xc0(%rbp)
00000001000093b6	movq	$0x0, -0xb8(%rbp)
00000001000093c1	leaq	-0xd0(%rbp), %r12
00000001000093c8	movq	%r12, -0x130(%rbp)
00000001000093cf	leaq	_fwp_owner_release27(%rip), %rax
00000001000093d6	movq	%rax, -0x128(%rbp)
00000001000093dd	leaq	-0xb8(%rbp), %rax
00000001000093e4	movq	%rax, -0x120(%rbp)
00000001000093eb	leaq	-0x130(%rbp), %r15
00000001000093f2	movq	%r15, _fwp_cleanups(%rip)
00000001000093f9	movq	0x10(%rdi), %rax
00000001000093fd	subq	0xbc34(%rip), %rax
0000000100009404	movq	0xbc55(%rip), %rcx
000000010000940b	shlq	$0x10, %rcx
000000010000940f	cmpq	%rcx, %rax
0000000100009412	jae	0x10000947c
0000000100009414	movq	0xbc65(%rip), %rcx
000000010000941b	movq	%rax, %rdx
000000010000941e	shrq	$0x10, %rdx
0000000100009422	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009429	leaq	(%rcx,%rdx), %rdi
000000010000942d	movzbl	(%rcx,%rdx), %ecx
0000000100009431	cmpb	$0x2, %cl
0000000100009434	setne	%dl
0000000100009437	andq	$0xffff, %rax                   ## imm = 0xFFFF
000000010000943d	setne	%sil
0000000100009441	orb	%dl, %sil
0000000100009444	jne	0x10000944f
0000000100009446	addq	$0x228, %rdi                    ## imm = 0x228
000000010000944d	jmp	0x100009469
000000010000944f	cmpb	$0x1, %cl
0000000100009452	jne	0x10000947c
0000000100009454	movl	0x20(%rdi), %ecx
0000000100009457	imulq	%rcx, %rax
000000010000945b	shrq	$0x20, %rax
000000010000945f	addq	%rax, %rdi
0000000100009462	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009469	movzbl	(%rdi), %eax
000000010000946c	testb	%al, %al
000000010000946e	je	0x10000947c
0000000100009470	cmpb	$-0x3, %al
0000000100009472	ja	0x100009982
0000000100009478	incb	%al
000000010000947a	movb	%al, (%rdi)
000000010000947c	movq	0x10(%rbx), %r14
0000000100009480	movq	%r14, -0xb8(%rbp)
0000000100009487	movq	-0x130(%rbp), %rax
000000010000948e	movq	%rax, _fwp_cleanups(%rip)
0000000100009495	movq	0x8(%rbx), %r13
0000000100009499	movsbq	0x18(%rbx), %r15
000000010000949e	testq	%r13, %r13
00000001000094a1	js	0x1000094ca
00000001000094a3	movq	(%r14), %rax
00000001000094a6	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
00000001000094b0	andq	%rax, %rcx
00000001000094b3	cmpq	%r13, %rcx
00000001000094b6	jbe	0x1000094ca
00000001000094b8	testq	%rax, %rax
00000001000094bb	js	0x100009593
00000001000094c1	leaq	0x8(%r14), %rax
00000001000094c5	jmp	0x100009597
00000001000094ca	movq	%r14, %rdi
00000001000094cd	callq	_fwp_drop0
00000001000094d2	movq	%r15, -0x90(%rbp)
00000001000094d9	movl	$0x10, %edi
00000001000094de	callq	_fwp_alloc_init
00000001000094e3	movq	%rax, %r14
00000001000094e6	movabsq	$0x100000001, %rax              ## imm = 0x100000001
00000001000094f0	movq	%rax, (%r14)
00000001000094f3	movq	%r15, 0x8(%r14)
00000001000094f7	leaq	-0x90(%rbp), %rax
00000001000094fe	movq	%r14, %rax
0000000100009501	subq	0xbb30(%rip), %rax
0000000100009508	movq	0xbb51(%rip), %rcx
000000010000950f	shlq	$0x10, %rcx
0000000100009513	cmpq	%rcx, %rax
0000000100009516	jae	0x10000993e
000000010000951c	movq	0xbb5d(%rip), %rcx
0000000100009523	movq	%rax, %rdx
0000000100009526	shrq	$0x10, %rdx
000000010000952a	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009531	leaq	(%rcx,%rdx), %r15
0000000100009535	movzbl	(%rcx,%rdx), %ecx
0000000100009539	cmpb	$0x2, %cl
000000010000953c	setne	%dl
000000010000953f	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009545	setne	%sil
0000000100009549	orb	%dl, %sil
000000010000954c	jne	0x100009564
000000010000954e	addq	$0x228, %r15                    ## imm = 0x228
0000000100009555	cmpb	$-0x1, (%r15)
0000000100009559	je	0x100009589
000000010000955b	movb	$0x1, (%r15)
000000010000955f	jmp	0x10000993e
0000000100009564	cmpb	$0x1, %cl
0000000100009567	jne	0x10000993e
000000010000956d	movl	0x20(%r15), %ecx
0000000100009571	imulq	%rcx, %rax
0000000100009575	shrq	$0x20, %rax
0000000100009579	addq	%rax, %r15
000000010000957c	addq	$0x228, %r15                    ## imm = 0x228
0000000100009583	cmpb	$-0x1, (%r15)
0000000100009587	jne	0x10000955b
0000000100009589	movq	%r15, %rdi
000000010000958c	callq	_fwp_rc_forget_slot
0000000100009591	jmp	0x10000955b
0000000100009593	movq	0x10(%r14), %rax
0000000100009597	movsbq	(%rax,%r13), %r12
000000010000959c	movq	_fwp_cleanups(%rip), %rax
00000001000095a3	movq	%r14, -0x118(%rbp)
00000001000095aa	movq	%rax, -0x178(%rbp)
00000001000095b1	leaq	_fwp_owner_release21(%rip), %rcx
00000001000095b8	movq	%rcx, -0x170(%rbp)
00000001000095bf	leaq	-0x118(%rbp), %rcx
00000001000095c6	movq	%rcx, -0x168(%rbp)
00000001000095cd	leaq	-0x178(%rbp), %rcx
00000001000095d4	movq	%rcx, _fwp_cleanups(%rip)
00000001000095db	leaq	-0x7f(%r12), %rcx
00000001000095e0	cmpq	$-0x101, %rcx                   ## imm = 0xFEFF
00000001000095e7	jbe	0x1000099c7
00000001000095ed	movq	%r14, -0x110(%rbp)
00000001000095f4	movq	%rax, -0x108(%rbp)
00000001000095fb	leaq	_fwp_owner_release22(%rip), %rax
0000000100009602	movq	%rax, -0x100(%rbp)
0000000100009609	leaq	-0x110(%rbp), %rax
0000000100009610	movq	%rax, -0xf8(%rbp)
0000000100009617	leaq	-0x108(%rbp), %rcx
000000010000961e	movq	%r14, %rax
0000000100009621	subq	0xba10(%rip), %rax
0000000100009628	movq	%rcx, _fwp_cleanups(%rip)
000000010000962f	movq	0xba2a(%rip), %rcx
0000000100009636	shlq	$0x10, %rcx
000000010000963a	cmpq	%rcx, %rax
000000010000963d	jae	0x1000096a7
000000010000963f	movq	0xba3a(%rip), %rcx
0000000100009646	movq	%rax, %rdx
0000000100009649	shrq	$0x10, %rdx
000000010000964d	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009654	leaq	(%rcx,%rdx), %rdi
0000000100009658	movzbl	(%rcx,%rdx), %ecx
000000010000965c	cmpb	$0x2, %cl
000000010000965f	setne	%dl
0000000100009662	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009668	setne	%sil
000000010000966c	orb	%dl, %sil
000000010000966f	jne	0x10000967a
0000000100009671	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009678	jmp	0x100009694
000000010000967a	cmpb	$0x1, %cl
000000010000967d	jne	0x1000096a7
000000010000967f	movl	0x20(%rdi), %ecx
0000000100009682	imulq	%rcx, %rax
0000000100009686	shrq	$0x20, %rax
000000010000968a	addq	%rax, %rdi
000000010000968d	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009694	movzbl	(%rdi), %eax
0000000100009697	testb	%al, %al
0000000100009699	je	0x1000096a7
000000010000969b	cmpb	$-0x3, %al
000000010000969d	ja	0x1000099a4
00000001000096a3	incb	%al
00000001000096a5	movb	%al, (%rdi)
00000001000096a7	movq	-0x108(%rbp), %rax
00000001000096ae	movq	%rax, _fwp_cleanups(%rip)
00000001000096b5	movq	%r14, %rdi
00000001000096b8	callq	_fwp_drop0
00000001000096bd	movq	%r14, -0xf0(%rbp)
00000001000096c4	movq	_fwp_cleanups(%rip), %rax
00000001000096cb	movq	%rax, -0x160(%rbp)
00000001000096d2	leaq	_fwp_owner_release23(%rip), %rcx
00000001000096d9	movq	%rcx, -0x158(%rbp)
00000001000096e0	leaq	-0xf0(%rbp), %rcx
00000001000096e7	movq	%rcx, -0x150(%rbp)
00000001000096ee	leaq	-0x160(%rbp), %rcx
00000001000096f5	movq	%rcx, _fwp_cleanups(%rip)
00000001000096fc	addq	%r15, %r12
00000001000096ff	incq	%r12
0000000100009702	movsbq	%r12b, %rcx
0000000100009706	cmpq	%r12, %rcx
0000000100009709	jne	0x1000099c7
000000010000970f	incq	%r13
0000000100009712	movq	%r14, -0xe8(%rbp)
0000000100009719	movq	%rax, -0x90(%rbp)
0000000100009720	leaq	_fwp_owner_release24(%rip), %rax
0000000100009727	movq	%rax, -0x88(%rbp)
000000010000972e	leaq	-0xe8(%rbp), %rax
0000000100009735	movq	%rax, -0x80(%rbp)
0000000100009739	leaq	-0x90(%rbp), %rax
0000000100009740	movq	%rax, _fwp_cleanups(%rip)
0000000100009747	movq	%r13, -0xa8(%rbp)
000000010000974e	movq	%r14, -0xa0(%rbp)
0000000100009755	movq	%r12, -0x98(%rbp)
000000010000975c	movl	$0x20, %edi
0000000100009761	callq	_fwp_alloc_init
0000000100009766	movq	%rax, %r15
0000000100009769	movabsq	$0x300000000, %rax              ## imm = 0x300000000
0000000100009773	movq	%rax, (%r15)
0000000100009776	movq	%r13, 0x8(%r15)
000000010000977a	movq	%r14, 0x10(%r15)
000000010000977e	movq	%r12, 0x18(%r15)
0000000100009782	leaq	-0xa8(%rbp), %rax
0000000100009789	movq	%r15, %rax
000000010000978c	subq	0xb8a5(%rip), %rax
0000000100009793	movq	0xb8c6(%rip), %rcx
000000010000979a	shlq	$0x10, %rcx
000000010000979e	cmpq	%rcx, %rax
00000001000097a1	jae	0x100009813
00000001000097a3	movq	0xb8d6(%rip), %rcx
00000001000097aa	movq	%rax, %rdx
00000001000097ad	shrq	$0x10, %rdx
00000001000097b1	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000097b8	leaq	(%rcx,%rdx), %r14
00000001000097bc	movzbl	(%rcx,%rdx), %ecx
00000001000097c0	cmpb	$0x2, %cl
00000001000097c3	setne	%dl
00000001000097c6	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000097cc	setne	%sil
00000001000097d0	orb	%dl, %sil
00000001000097d3	jne	0x1000097e8
00000001000097d5	addq	$0x228, %r14                    ## imm = 0x228
00000001000097dc	cmpb	$-0x1, (%r14)
00000001000097e0	je	0x100009809
00000001000097e2	movb	$0x1, (%r14)
00000001000097e6	jmp	0x100009813
00000001000097e8	cmpb	$0x1, %cl
00000001000097eb	jne	0x100009813
00000001000097ed	movl	0x20(%r14), %ecx
00000001000097f1	imulq	%rcx, %rax
00000001000097f5	shrq	$0x20, %rax
00000001000097f9	addq	%rax, %r14
00000001000097fc	addq	$0x228, %r14                    ## imm = 0x228
0000000100009803	cmpb	$-0x1, (%r14)
0000000100009807	jne	0x1000097e2
0000000100009809	movq	%r14, %rdi
000000010000980c	callq	_fwp_rc_forget_slot
0000000100009811	jmp	0x1000097e2
0000000100009813	leaq	-0x90(%rbp), %rax
000000010000981a	cmpq	%rax, _fwp_cleanups(%rip)
0000000100009821	jne	0x1000099bd
0000000100009827	movq	-0x90(%rbp), %rax
000000010000982e	movq	%r15, -0xe0(%rbp)
0000000100009835	movq	%rax, -0x148(%rbp)
000000010000983c	leaq	_fwp_owner_release25(%rip), %rax
0000000100009843	movq	%rax, -0x140(%rbp)
000000010000984a	leaq	-0xe0(%rbp), %rax
0000000100009851	movq	%rax, -0x138(%rbp)
0000000100009858	leaq	-0x148(%rbp), %r12
000000010000985f	movq	%r12, _fwp_cleanups(%rip)
0000000100009866	movq	%r15, -0xb0(%rbp)
000000010000986d	movl	$0x10, %edi
0000000100009872	callq	_fwp_alloc_init
0000000100009877	movq	%rax, %r14
000000010000987a	movabsq	$__mh_execute_header, %rax
0000000100009884	movq	%rax, (%r14)
0000000100009887	movq	%r15, 0x8(%r14)
000000010000988b	leaq	-0xb0(%rbp), %rax
0000000100009892	movq	%r14, %rax
0000000100009895	subq	0xb79c(%rip), %rax
000000010000989c	movq	0xb7bd(%rip), %rcx
00000001000098a3	shlq	$0x10, %rcx
00000001000098a7	cmpq	%rcx, %rax
00000001000098aa	jae	0x10000991c
00000001000098ac	movq	0xb7cd(%rip), %rcx
00000001000098b3	movq	%rax, %rdx
00000001000098b6	shrq	$0x10, %rdx
00000001000098ba	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
00000001000098c1	leaq	(%rcx,%rdx), %r15
00000001000098c5	movzbl	(%rcx,%rdx), %ecx
00000001000098c9	cmpb	$0x2, %cl
00000001000098cc	setne	%dl
00000001000098cf	andq	$0xffff, %rax                   ## imm = 0xFFFF
00000001000098d5	setne	%sil
00000001000098d9	orb	%dl, %sil
00000001000098dc	jne	0x1000098f1
00000001000098de	addq	$0x228, %r15                    ## imm = 0x228
00000001000098e5	cmpb	$-0x1, (%r15)
00000001000098e9	je	0x100009912
00000001000098eb	movb	$0x1, (%r15)
00000001000098ef	jmp	0x10000991c
00000001000098f1	cmpb	$0x1, %cl
00000001000098f4	jne	0x10000991c
00000001000098f6	movl	0x20(%r15), %ecx
00000001000098fa	imulq	%rcx, %rax
00000001000098fe	shrq	$0x20, %rax
0000000100009902	addq	%rax, %r15
0000000100009905	addq	$0x228, %r15                    ## imm = 0x228
000000010000990c	cmpb	$-0x1, (%r15)
0000000100009910	jne	0x1000098eb
0000000100009912	movq	%r15, %rdi
0000000100009915	callq	_fwp_rc_forget_slot
000000010000991a	jmp	0x1000098eb
000000010000991c	cmpq	%r12, _fwp_cleanups(%rip)
0000000100009923	jne	0x1000099bd
0000000100009929	movq	-0x148(%rbp), %rax
0000000100009930	movq	%rax, _fwp_cleanups(%rip)
0000000100009937	leaq	-0xd0(%rbp), %r12
000000010000993e	cmpq	%r12, _fwp_cleanups(%rip)
0000000100009945	jne	0x1000099bd
0000000100009947	movq	-0xd0(%rbp), %rax
000000010000994e	movq	%rax, _fwp_cleanups(%rip)
0000000100009955	movq	%rbx, %rdi
0000000100009958	callq	_fwp_drop6
000000010000995d	movq	0x96cc(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100009964	movq	(%rax), %rax
0000000100009967	cmpq	-0x30(%rbp), %rax
000000010000996b	jne	0x1000099c2
000000010000996d	movq	%r14, %rax
0000000100009970	addq	$0x158, %rsp                    ## imm = 0x158
0000000100009977	popq	%rbx
0000000100009978	popq	%r12
000000010000997a	popq	%r13
000000010000997c	popq	%r14
000000010000997e	popq	%r15
0000000100009980	popq	%rbp
0000000100009981	retq
0000000100009982	callq	_fwp_rc_wide_dup
0000000100009987	movq	_fwp_cleanups(%rip), %rax
000000010000998e	movq	0x10(%rbx), %r14
0000000100009992	movq	%r14, -0xb8(%rbp)
0000000100009999	cmpq	%r15, %rax
000000010000999c	je	0x100009487
00000001000099a2	jmp	0x1000099bd
00000001000099a4	callq	_fwp_rc_wide_dup
00000001000099a9	leaq	-0x108(%rbp), %rax
00000001000099b0	cmpq	%rax, _fwp_cleanups(%rip)
00000001000099b7	je	0x1000096a7
00000001000099bd	callq	0x10001118a                     ## symbol stub for: _abort
00000001000099c2	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
00000001000099c7	leaq	0x7fb8(%rip), %rdx              ## literal pool for: "arithmetic overflow in %s"
00000001000099ce	leaq	0x7fde(%rip), %rcx              ## literal pool for: "I8"
00000001000099d5	leaq	-0x90(%rbp), %rbx
00000001000099dc	movl	$0x60, %esi
00000001000099e1	movq	%rbx, %rdi
00000001000099e4	xorl	%eax, %eax
00000001000099e6	callq	0x10001126e                     ## symbol stub for: _snprintf
00000001000099eb	callq	_fwp_flush
00000001000099f0	movq	0x9641(%rip), %rax              ## literal pool symbol address: ___stderrp
00000001000099f7	movq	(%rax), %rdi
00000001000099fa	leaq	0x7f6e(%rip), %rsi              ## literal pool for: "fwp: trap: %s\n"
0000000100009a01	movq	%rbx, %rdx
0000000100009a04	xorl	%eax, %eax
0000000100009a06	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100009a0b	movl	$0x65, %edi
0000000100009a10	callq	0x1000111a8                     ## symbol stub for: _exit
0000000100009a15	nopw	%cs:(%rax,%rax)
_fwp_owner_release26:
0000000100009a20	pushq	%rbp
0000000100009a21	movq	%rsp, %rbp
0000000100009a24	movq	(%rdi), %rdi
0000000100009a27	popq	%rbp
0000000100009a28	jmp	_fwp_drop6
0000000100009a2d	nopl	(%rax)
_fwp_owner_release27:
0000000100009a30	pushq	%rbp
0000000100009a31	movq	%rsp, %rbp
0000000100009a34	movq	(%rdi), %rdi
0000000100009a37	popq	%rbp
0000000100009a38	jmp	_fwp_drop0
0000000100009a3d	nopl	(%rax)
_fwp_drop6:
0000000100009a40	movq	%rdi, %rcx
0000000100009a43	subq	0xb5ee(%rip), %rcx
0000000100009a4a	movq	0xb60f(%rip), %rax
0000000100009a51	shlq	$0x10, %rax
0000000100009a55	cmpq	%rax, %rcx
0000000100009a58	jae	0x100009aee
0000000100009a5e	movq	0xb61b(%rip), %rdx
0000000100009a65	movq	%rcx, %rax
0000000100009a68	shrq	$0x10, %rax
0000000100009a6c	imulq	$0x1228, %rax, %rsi             ## imm = 0x1228
0000000100009a73	leaq	(%rdx,%rsi), %rax
0000000100009a77	movzbl	(%rdx,%rsi), %edx
0000000100009a7b	cmpb	$0x2, %dl
0000000100009a7e	setne	%sil
0000000100009a82	andq	$0xffff, %rcx                   ## imm = 0xFFFF
0000000100009a89	setne	%r8b
0000000100009a8d	orb	%sil, %r8b
0000000100009a90	jne	0x100009a9a
0000000100009a92	addq	$0x228, %rax                    ## imm = 0x228
0000000100009a98	jmp	0x100009ab3
0000000100009a9a	cmpb	$0x1, %dl
0000000100009a9d	jne	0x100009aee
0000000100009a9f	movl	0x20(%rax), %edx
0000000100009aa2	imulq	%rdx, %rcx
0000000100009aa6	shrq	$0x20, %rcx
0000000100009aaa	addq	%rcx, %rax
0000000100009aad	addq	$0x228, %rax                    ## imm = 0x228
0000000100009ab3	movzbl	(%rax), %ecx
0000000100009ab6	testl	%ecx, %ecx
0000000100009ab8	je	0x100009aee
0000000100009aba	cmpl	$0x1, %ecx
0000000100009abd	jne	0x100009ae2
0000000100009abf	pushq	%rbp
0000000100009ac0	movq	%rsp, %rbp
0000000100009ac3	pushq	%rbx
0000000100009ac4	pushq	%rax
0000000100009ac5	movq	0x10(%rdi), %rax
0000000100009ac9	movq	%rdi, %rbx
0000000100009acc	movq	%rax, %rdi
0000000100009acf	callq	_fwp_drop0
0000000100009ad4	movq	%rbx, %rdi
0000000100009ad7	addq	$0x8, %rsp
0000000100009adb	popq	%rbx
0000000100009adc	popq	%rbp
0000000100009add	jmp	_fwp_rc_free_obj
0000000100009ae2	cmpl	$0xff, %ecx
0000000100009ae8	je	0x100009aef
0000000100009aea	decb	%cl
0000000100009aec	movb	%cl, (%rax)
0000000100009aee	retq
0000000100009aef	movq	%rax, %rdi
0000000100009af2	jmp	_fwp_rc_wide_drop
0000000100009af7	nopw	(%rax,%rax)
_fwp_owner_release21:
0000000100009b00	pushq	%rbp
0000000100009b01	movq	%rsp, %rbp
0000000100009b04	movq	(%rdi), %rdi
0000000100009b07	popq	%rbp
0000000100009b08	jmp	_fwp_drop0
0000000100009b0d	nopl	(%rax)
_fwp_owner_release22:
0000000100009b10	pushq	%rbp
0000000100009b11	movq	%rsp, %rbp
0000000100009b14	movq	(%rdi), %rdi
0000000100009b17	popq	%rbp
0000000100009b18	jmp	_fwp_drop0
0000000100009b1d	nopl	(%rax)
_fwp_owner_release23:
0000000100009b20	pushq	%rbp
0000000100009b21	movq	%rsp, %rbp
0000000100009b24	movq	(%rdi), %rdi
0000000100009b27	popq	%rbp
0000000100009b28	jmp	_fwp_drop0
0000000100009b2d	nopl	(%rax)
_fwp_owner_release24:
0000000100009b30	pushq	%rbp
0000000100009b31	movq	%rsp, %rbp
0000000100009b34	movq	(%rdi), %rdi
0000000100009b37	popq	%rbp
0000000100009b38	jmp	_fwp_drop0
0000000100009b3d	nopl	(%rax)
_fwp_owner_release25:
0000000100009b40	pushq	%rbp
0000000100009b41	movq	%rsp, %rbp
0000000100009b44	movq	(%rdi), %rax
0000000100009b47	subq	0xb4ea(%rip), %rax
0000000100009b4e	movq	0xb50b(%rip), %rcx
0000000100009b55	shlq	$0x10, %rcx
0000000100009b59	cmpq	%rcx, %rax
0000000100009b5c	jae	0x100009bc2
0000000100009b5e	movq	0xb51b(%rip), %rcx
0000000100009b65	movq	%rax, %rdx
0000000100009b68	shrq	$0x10, %rdx
0000000100009b6c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009b73	leaq	(%rcx,%rdx), %rdi
0000000100009b77	movzbl	(%rcx,%rdx), %ecx
0000000100009b7b	cmpb	$0x2, %cl
0000000100009b7e	setne	%dl
0000000100009b81	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009b87	setne	%sil
0000000100009b8b	orb	%dl, %sil
0000000100009b8e	jne	0x100009b99
0000000100009b90	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009b97	jmp	0x100009bb3
0000000100009b99	cmpb	$0x1, %cl
0000000100009b9c	jne	0x100009bc2
0000000100009b9e	movl	0x20(%rdi), %ecx
0000000100009ba1	imulq	%rcx, %rax
0000000100009ba5	shrq	$0x20, %rax
0000000100009ba9	addq	%rax, %rdi
0000000100009bac	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009bb3	movzbl	(%rdi), %eax
0000000100009bb6	cmpb	$0x2, %al
0000000100009bb8	jb	0x100009bc2
0000000100009bba	cmpb	$-0x1, %al
0000000100009bbc	je	0x100009bc4
0000000100009bbe	decb	%al
0000000100009bc0	movb	%al, (%rdi)
0000000100009bc2	popq	%rbp
0000000100009bc3	retq
0000000100009bc4	popq	%rbp
0000000100009bc5	jmp	_fwp_rc_wide_drop
0000000100009bca	nopw	(%rax,%rax)
_fwp_owned_entry37:
0000000100009bd0	pushq	%rbp
0000000100009bd1	movq	%rsp, %rbp
0000000100009bd4	movq	(%rdi), %rdi
0000000100009bd7	popq	%rbp
0000000100009bd8	jmp	_f37
0000000100009bdd	nopl	(%rax)
_fwp_caps37:
0000000100009be0	movl	0x4(%rdi), %eax
0000000100009be3	testl	%esi, %esi
0000000100009be5	je	0x100009c49
0000000100009be7	testl	%eax, %eax
0000000100009be9	je	0x100009ca1
0000000100009bef	movq	0x8(%rdi), %rax
0000000100009bf3	subq	0xb43e(%rip), %rax
0000000100009bfa	movq	0xb45f(%rip), %rcx
0000000100009c01	shlq	$0x10, %rcx
0000000100009c05	cmpq	%rcx, %rax
0000000100009c08	jae	0x100009ca1
0000000100009c0e	movq	0xb46b(%rip), %rcx
0000000100009c15	movq	%rax, %rdx
0000000100009c18	shrq	$0x10, %rdx
0000000100009c1c	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009c23	leaq	(%rcx,%rdx), %rdi
0000000100009c27	movzbl	(%rcx,%rdx), %ecx
0000000100009c2b	cmpb	$0x2, %cl
0000000100009c2e	setne	%dl
0000000100009c31	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009c37	setne	%sil
0000000100009c3b	orb	%dl, %sil
0000000100009c3e	jne	0x100009c74
0000000100009c40	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009c47	jmp	0x100009c8e
0000000100009c49	testl	%eax, %eax
0000000100009c4b	je	_fwp_rc_free_obj
0000000100009c51	pushq	%rbp
0000000100009c52	movq	%rsp, %rbp
0000000100009c55	pushq	%rbx
0000000100009c56	pushq	%rax
0000000100009c57	movq	0x8(%rdi), %rax
0000000100009c5b	movq	%rdi, %rbx
0000000100009c5e	movq	%rax, %rdi
0000000100009c61	callq	_fwp_drop6
0000000100009c66	movq	%rbx, %rdi
0000000100009c69	addq	$0x8, %rsp
0000000100009c6d	popq	%rbx
0000000100009c6e	popq	%rbp
0000000100009c6f	jmp	_fwp_rc_free_obj
0000000100009c74	cmpb	$0x1, %cl
0000000100009c77	jne	0x100009ca1
0000000100009c79	movl	0x20(%rdi), %ecx
0000000100009c7c	imulq	%rcx, %rax
0000000100009c80	shrq	$0x20, %rax
0000000100009c84	addq	%rax, %rdi
0000000100009c87	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009c8e	movzbl	(%rdi), %eax
0000000100009c91	testb	%al, %al
0000000100009c93	je	0x100009ca1
0000000100009c95	cmpb	$-0x2, %al
0000000100009c97	jae	_fwp_rc_wide_dup
0000000100009c9d	incb	%al
0000000100009c9f	movb	%al, (%rdi)
0000000100009ca1	retq
0000000100009ca2	nopw	%cs:(%rax,%rax)
_fwp_args37:
0000000100009cb0	pushq	%rbp
0000000100009cb1	movq	%rsp, %rbp
0000000100009cb4	testl	%esi, %esi
0000000100009cb6	setne	%al
0000000100009cb9	testl	%edx, %edx
0000000100009cbb	sete	%cl
0000000100009cbe	orb	%al, %cl
0000000100009cc0	jne	0x100009d40
0000000100009cc2	movq	(%rdi), %rax
0000000100009cc5	subq	0xb36c(%rip), %rax
0000000100009ccc	movq	0xb38d(%rip), %rcx
0000000100009cd3	shlq	$0x10, %rcx
0000000100009cd7	cmpq	%rcx, %rax
0000000100009cda	jae	0x100009d40
0000000100009cdc	movq	0xb39d(%rip), %rcx
0000000100009ce3	movq	%rax, %rdx
0000000100009ce6	shrq	$0x10, %rdx
0000000100009cea	imulq	$0x1228, %rdx, %rdx             ## imm = 0x1228
0000000100009cf1	leaq	(%rcx,%rdx), %rdi
0000000100009cf5	movzbl	(%rcx,%rdx), %ecx
0000000100009cf9	cmpb	$0x2, %cl
0000000100009cfc	setne	%dl
0000000100009cff	andq	$0xffff, %rax                   ## imm = 0xFFFF
0000000100009d05	setne	%sil
0000000100009d09	orb	%dl, %sil
0000000100009d0c	jne	0x100009d17
0000000100009d0e	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009d15	jmp	0x100009d31
0000000100009d17	cmpb	$0x1, %cl
0000000100009d1a	jne	0x100009d40
0000000100009d1c	movl	0x20(%rdi), %ecx
0000000100009d1f	imulq	%rcx, %rax
0000000100009d23	shrq	$0x20, %rax
0000000100009d27	addq	%rax, %rdi
0000000100009d2a	addq	$0x228, %rdi                    ## imm = 0x228
0000000100009d31	movzbl	(%rdi), %eax
0000000100009d34	testb	%al, %al
0000000100009d36	je	0x100009d40
0000000100009d38	cmpb	$-0x2, %al
0000000100009d3a	jae	0x100009d42
0000000100009d3c	incb	%al
0000000100009d3e	movb	%al, (%rdi)
0000000100009d40	popq	%rbp
0000000100009d41	retq
0000000100009d42	popq	%rbp
0000000100009d43	jmp	_fwp_rc_wide_dup
0000000100009d48	nopl	(%rax,%rax)
_fwp_arg_drop37:
0000000100009d50	pushq	%rbp
0000000100009d51	movq	%rsp, %rbp
0000000100009d54	testl	%esi, %esi
0000000100009d56	setne	%al
0000000100009d59	testl	%edx, %edx
0000000100009d5b	sete	%cl
0000000100009d5e	orb	%al, %cl
0000000100009d60	je	0x100009d64
0000000100009d62	popq	%rbp
0000000100009d63	retq
0000000100009d64	movq	(%rdi), %rdi
0000000100009d67	popq	%rbp
0000000100009d68	jmp	_fwp_drop6
0000000100009d6d	nopl	(%rax)
_fwp_segv:
0000000100009d70	movq	_fwp_main_stack_top(%rip), %rax
0000000100009d77	testq	%rax, %rax
0000000100009d7a	je	0x100009da4
0000000100009d7c	movq	0x18(%rsi), %rcx
0000000100009d80	subq	_fwp_main_stack_size(%rip), %rax
0000000100009d87	leaq	-0x100000(%rax), %rdx
0000000100009d8e	addq	$0x100000, %rax                 ## imm = 0x100000
0000000100009d94	cmpq	%rcx, %rdx
0000000100009d97	setbe	%dl
0000000100009d9a	cmpq	%rcx, %rax
0000000100009d9d	seta	%al
0000000100009da0	testb	%al, %dl
0000000100009da2	jne	0x100009dab
0000000100009da4	xorl	%esi, %esi
0000000100009da6	jmp	0x100011268                     ## symbol stub for: _signal
0000000100009dab	pushq	%rbp
0000000100009dac	movq	%rsp, %rbp
0000000100009daf	callq	_fwp_flush
0000000100009db4	leaq	_fwp_segv.msg(%rip), %rsi
0000000100009dbb	movl	$0x1a, %edx
0000000100009dc0	movl	$0x2, %edi
0000000100009dc5	callq	0x1000112bc                     ## symbol stub for: _write
0000000100009dca	movl	$0x65, %edi
0000000100009dcf	callq	0x100011184                     ## symbol stub for: __exit
0000000100009dd4	nopw	%cs:(%rax,%rax)
_fwp_str_lossy:
0000000100009de0	pushq	%rbp
0000000100009de1	movq	%rsp, %rbp
0000000100009de4	pushq	%r15
0000000100009de6	pushq	%r14
0000000100009de8	pushq	%r13
0000000100009dea	pushq	%r12
0000000100009dec	pushq	%rbx
0000000100009ded	subq	$0x28, %rsp
0000000100009df1	movq	%rsi, %rbx
0000000100009df4	movq	%rdi, %r14
0000000100009df7	testq	%rsi, %rsi
0000000100009dfa	je	0x100009f31
0000000100009e00	xorl	%eax, %eax
0000000100009e02	jmp	0x100009e1c
0000000100009e04	nopw	%cs:(%rax,%rax)
0000000100009e10	incq	%rax
0000000100009e13	cmpq	%rbx, %rax
0000000100009e16	jae	0x100009f31
0000000100009e1c	movzbl	(%r14,%rax), %edi
0000000100009e21	testb	%dil, %dil
0000000100009e24	jns	0x100009e10
0000000100009e26	leal	0x3e(%rdi), %ecx
0000000100009e29	cmpb	$0x1e, %cl
0000000100009e2c	jae	0x100009e3f
0000000100009e2e	movl	$0x80, %ecx
0000000100009e33	movl	$0x1, %esi
0000000100009e38	movl	$0x1f, %edx
0000000100009e3d	jmp	0x100009e75
0000000100009e3f	movl	%edi, %ecx
0000000100009e41	andb	$-0x10, %cl
0000000100009e44	cmpb	$-0x20, %cl
0000000100009e47	jne	0x100009e5a
0000000100009e49	movl	$0x800, %ecx                    ## imm = 0x800
0000000100009e4e	movl	$0x2, %esi
0000000100009e53	movl	$0xf, %edx
0000000100009e58	jmp	0x100009e75
0000000100009e5a	leal	0x10(%rdi), %ecx
0000000100009e5d	cmpb	$0x4, %cl
0000000100009e60	ja	0x100009f4a
0000000100009e66	movl	$0x10000, %ecx                  ## imm = 0x10000
0000000100009e6b	movl	$0x3, %esi
0000000100009e70	movl	$0x7, %edx
0000000100009e75	movl	%esi, %esi
0000000100009e77	leaq	(%rax,%rsi), %r8
0000000100009e7b	cmpq	%rbx, %r8
0000000100009e7e	jae	0x100009f4a
0000000100009e84	movzbl	0x1(%r14,%rax), %r8d
0000000100009e8a	movl	%r8d, %r9d
0000000100009e8d	andl	$-0x40, %r9d
0000000100009e91	cmpl	$0x80, %r9d
0000000100009e98	jne	0x100009f4a
0000000100009e9e	andl	%edi, %edx
0000000100009ea0	leal	0x1(%rsi), %r9d
0000000100009ea4	movl	%edx, %edi
0000000100009ea6	shll	$0x6, %edi
0000000100009ea9	andl	$0x3f, %r8d
0000000100009ead	orl	%edi, %r8d
0000000100009eb0	cmpl	$0x2, %r9d
0000000100009eb4	jne	0x100009ebb
0000000100009eb6	movl	%r8d, %r9d
0000000100009eb9	jmp	0x100009f07
0000000100009ebb	movzbl	0x2(%r14,%rax), %edx
0000000100009ec1	movl	%edx, %edi
0000000100009ec3	andl	$-0x40, %edi
0000000100009ec6	cmpl	$0x80, %edi
0000000100009ecc	jne	0x100009f4a
0000000100009ece	movl	%r8d, %edi
0000000100009ed1	shll	$0x6, %edi
0000000100009ed4	andl	$0x3f, %edx
0000000100009ed7	orl	%edi, %edx
0000000100009ed9	cmpl	$0x3, %r9d
0000000100009edd	jne	0x100009ee7
0000000100009edf	movl	%edx, %r9d
0000000100009ee2	movl	%r8d, %edx
0000000100009ee5	jmp	0x100009f07
0000000100009ee7	movzbl	0x3(%r14,%rax), %r9d
0000000100009eed	movl	%r9d, %edi
0000000100009ef0	andl	$-0x40, %edi
0000000100009ef3	cmpl	$0x80, %edi
0000000100009ef9	jne	0x100009f4a
0000000100009efb	movl	%edx, %edi
0000000100009efd	shll	$0x6, %edi
0000000100009f00	andl	$0x3f, %r9d
0000000100009f04	orl	%edi, %r9d
0000000100009f07	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
0000000100009f0d	cmpl	$0x360, %edx                    ## imm = 0x360
0000000100009f13	je	0x100009f4a
0000000100009f15	cmpl	$0x10ffff, %edi                 ## imm = 0x10FFFF
0000000100009f1b	ja	0x100009f4a
0000000100009f1d	cmpl	%ecx, %r9d
0000000100009f20	jb	0x100009f4a
0000000100009f22	addq	%rsi, %rax
0000000100009f25	incq	%rax
0000000100009f28	cmpq	%rbx, %rax
0000000100009f2b	jb	0x100009e1c
0000000100009f31	movq	%r14, %rdi
0000000100009f34	movq	%rbx, %rsi
0000000100009f37	addq	$0x28, %rsp
0000000100009f3b	popq	%rbx
0000000100009f3c	popq	%r12
0000000100009f3e	popq	%r13
0000000100009f40	popq	%r14
0000000100009f42	popq	%r15
0000000100009f44	popq	%rbp
0000000100009f45	jmp	_fwp_str_new
0000000100009f4a	xorps	%xmm0, %xmm0
0000000100009f4d	movaps	%xmm0, -0x50(%rbp)
0000000100009f51	movq	$0x0, -0x40(%rbp)
0000000100009f59	xorl	%r13d, %r13d
0000000100009f5c	leaq	-0x50(%rbp), %r15
0000000100009f60	jmp	0x100009f96
0000000100009f62	nopw	%cs:(%rax,%rax)
0000000100009f70	movb	%al, -0x29(%rbp)
0000000100009f73	movl	$0x1, %edx
0000000100009f78	movq	%r15, %rdi
0000000100009f7b	leaq	-0x29(%rbp), %rsi
0000000100009f7f	callq	_buf_put
0000000100009f84	incq	%r13
0000000100009f87	movq	%r13, %r12
0000000100009f8a	movq	%r12, %r13
0000000100009f8d	cmpq	%rbx, %r12
0000000100009f90	jae	0x10000a0dd
0000000100009f96	movzbl	(%r14,%r13), %eax
0000000100009f9b	testb	%al, %al
0000000100009f9d	jns	0x100009f70
0000000100009f9f	leal	0x20(%rax), %ecx
0000000100009fa2	cmpb	$-0x1f, %cl
0000000100009fa5	ja	0x100009fdb
0000000100009fa7	movl	%eax, %edx
0000000100009fa9	andb	$-0x10, %dl
0000000100009fac	cmpb	$-0x20, %dl
0000000100009faf	jne	0x10000a099
0000000100009fb5	cmpb	$-0x20, %al
0000000100009fb7	sete	%sil
0000000100009fbb	shlb	$0x5, %sil
0000000100009fbf	orb	$-0x80, %sil
0000000100009fc3	xorl	%edi, %edi
0000000100009fc5	cmpb	$-0x13, %al
0000000100009fc7	setne	%dil
0000000100009fcb	shll	$0x5, %edi
0000000100009fce	orl	$0x9f, %edi
0000000100009fd4	movl	$0x2, %eax
0000000100009fd9	jmp	0x100009fe8
0000000100009fdb	movl	$0xbf, %edi
0000000100009fe0	movb	$-0x80, %sil
0000000100009fe3	movl	$0x1, %eax
0000000100009fe8	xorl	%edx, %edx
0000000100009fea	leaq	0x1(%r13), %r12
0000000100009fee	cmpq	%rbx, %r12
0000000100009ff1	jae	0x10000a080
0000000100009ff7	movzbl	(%r14,%r12), %r8d
0000000100009ffc	cmpb	%sil, %r8b
0000000100009fff	jb	0x10000a080
000000010000a001	cmpl	%r8d, %edi
000000010000a004	jb	0x10000a080
000000010000a006	cmpb	$-0x1e, %cl
000000010000a009	setae	%sil
000000010000a00d	leaq	0x2(%r13), %r12
000000010000a011	cmpq	%rbx, %r12
000000010000a014	setae	%dil
000000010000a018	movl	$0x1, %ecx
000000010000a01d	orb	%sil, %dil
000000010000a020	jne	0x10000a069
000000010000a022	movzbl	(%r14,%r12), %esi
000000010000a027	andb	$-0x40, %sil
000000010000a02b	negb	%sil
000000010000a02e	jno	0x10000a069
000000010000a030	leaq	0x3(%r13), %r12
000000010000a034	cmpq	%rbx, %r12
000000010000a037	setae	%sil
000000010000a03b	xorb	$0x1, %dl
000000010000a03e	movl	$0x2, %ecx
000000010000a043	orb	%sil, %dl
000000010000a046	jne	0x10000a069
000000010000a048	movzbl	0x3(%r14,%r13), %esi
000000010000a04e	andb	$-0x40, %sil
000000010000a052	xorl	%ecx, %ecx
000000010000a054	cmpb	$-0x80, %sil
000000010000a058	sete	%dl
000000010000a05b	negb	%sil
000000010000a05e	jno	0x10000a064
000000010000a060	leaq	0x4(%r13), %r12
000000010000a064	movb	%dl, %cl
000000010000a066	orl	$0x2, %ecx
000000010000a069	cmpl	%eax, %ecx
000000010000a06b	jne	0x10000a080
000000010000a06d	leaq	(%r14,%r13), %rsi
000000010000a071	movq	%r12, %rdx
000000010000a074	subq	%r13, %rdx
000000010000a077	movq	%r15, %rdi
000000010000a07a	jmp	0x10000a08f
000000010000a07c	nopl	(%rax)
000000010000a080	movl	$0x3, %edx
000000010000a085	movq	%r15, %rdi
000000010000a088	leaq	0x84b8(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a08f	callq	_buf_put
000000010000a094	jmp	0x100009f8a
000000010000a099	leal	0x10(%rax), %edx
000000010000a09c	cmpb	$0x4, %dl
000000010000a09f	ja	0x10000a0c9
000000010000a0a1	cmpb	$-0x10, %al
000000010000a0a3	sete	%sil
000000010000a0a7	movl	$0x8f, %edi
000000010000a0ac	cmpb	$-0xc, %al
000000010000a0ae	je	0x10000a0b5
000000010000a0b0	movl	$0xbf, %edi
000000010000a0b5	shlb	$0x4, %sil
000000010000a0b9	orb	$-0x80, %sil
000000010000a0bd	movl	$0x3, %eax
000000010000a0c2	movb	$0x1, %dl
000000010000a0c4	jmp	0x100009fea
000000010000a0c9	movl	$0x3, %edx
000000010000a0ce	movq	%r15, %rdi
000000010000a0d1	leaq	0x846f(%rip), %rsi              ## literal pool for: "\357\277\275"
000000010000a0d8	jmp	0x100009f7f
000000010000a0dd	movq	-0x50(%rbp), %rbx
000000010000a0e1	movq	-0x48(%rbp), %rsi
000000010000a0e5	testq	%rbx, %rbx
000000010000a0e8	leaq	0x77a3(%rip), %rdi              ## literal pool for: ""
000000010000a0ef	cmovneq	%rbx, %rdi
000000010000a0f3	callq	_fwp_str_new
000000010000a0f8	movq	%rax, %r14
000000010000a0fb	movq	%rbx, %rdi
000000010000a0fe	callq	0x1000111d2                     ## symbol stub for: _free
000000010000a103	movq	%r14, %rax
000000010000a106	addq	$0x28, %rsp
000000010000a10a	popq	%rbx
000000010000a10b	popq	%r12
000000010000a10d	popq	%r13
000000010000a10f	popq	%r14
000000010000a111	popq	%r15
000000010000a113	popq	%rbp
000000010000a114	retq
000000010000a115	nopw	%cs:(%rax,%rax)
_fwp_alloc_leaf:
000000010000a120	pushq	%rbp
000000010000a121	movq	%rsp, %rbp
000000010000a124	pushq	%rbx
000000010000a125	pushq	%rax
000000010000a126	movq	%rdi, %rsi
000000010000a129	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000a130	ja	0x10000a18b
000000010000a132	leaq	0xf(%rsi), %rax
000000010000a136	shrq	$0x4, %rax
000000010000a13a	leaq	_fwp_gc(%rip), %rcx
000000010000a141	movzbl	0xbe8(%rax,%rcx), %edx
000000010000a149	movl	0xb48(%rcx,%rdx,4), %eax
000000010000a150	subq	%rax, _fwp_gc(%rip)
000000010000a157	js	0x10000a18b
000000010000a159	leaq	(%rdx,%rdx,2), %rdx
000000010000a15d	leaq	(%rcx,%rdx,8), %rcx
000000010000a161	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000a168	movq	(%rcx), %rbx
000000010000a16b	testq	%rbx, %rbx
000000010000a16e	je	0x10000a17b
000000010000a170	movq	(%rbx), %rax
000000010000a173	notq	%rax
000000010000a176	movq	%rax, (%rcx)
000000010000a179	jmp	0x10000a1a5
000000010000a17b	movq	0x8(%rcx), %rbx
000000010000a17f	movq	0x10(%rcx), %rdx
000000010000a183	subq	%rbx, %rdx
000000010000a186	cmpq	%rax, %rdx
000000010000a189	jae	0x10000a19e
000000010000a18b	movq	%rsi, %rdi
000000010000a18e	movl	$0x1, %esi
000000010000a193	addq	$0x8, %rsp
000000010000a197	popq	%rbx
000000010000a198	popq	%rbp
000000010000a199	jmp	_fwp_gc_alloc_slow
000000010000a19e	addq	%rbx, %rax
000000010000a1a1	movq	%rax, 0x8(%rcx)
000000010000a1a5	movq	%rbx, %rdi
000000010000a1a8	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000a1ad	movq	%rbx, %rax
000000010000a1b0	addq	$0x8, %rsp
000000010000a1b4	popq	%rbx
000000010000a1b5	popq	%rbp
000000010000a1b6	retq
000000010000a1b7	nopw	(%rax,%rax)
_fwp_exec_call:
000000010000a1c0	pushq	%rbp
000000010000a1c1	movq	%rsp, %rbp
000000010000a1c4	pushq	%r15
000000010000a1c6	pushq	%r14
000000010000a1c8	pushq	%r13
000000010000a1ca	pushq	%r12
000000010000a1cc	pushq	%rbx
000000010000a1cd	subq	$0xd8, %rsp
000000010000a1d4	movq	%rsi, %rbx
000000010000a1d7	movq	%rdi, %r14
000000010000a1da	movq	_fwp_handlers(%rip), %rax
000000010000a1e1	movq	%rax, -0x68(%rbp)
000000010000a1e5	movq	$0x0, -0x50(%rbp)
000000010000a1ed	movq	_fwp_cleanups(%rip), %rax
000000010000a1f4	movq	%rax, -0x48(%rbp)
000000010000a1f8	leaq	-0x100(%rbp), %rdi
000000010000a1ff	movq	%rdi, _fwp_handlers(%rip)
000000010000a206	callq	0x100011250                     ## symbol stub for: _setjmp
000000010000a20b	testl	%eax, %eax
000000010000a20d	je	0x10000a2fb
000000010000a213	movq	-0x68(%rbp), %rax
000000010000a217	movq	%rax, _fwp_handlers(%rip)
000000010000a21e	movq	_fwp_prog_out(%rip), %rdi
000000010000a225	testq	%rdi, %rdi
000000010000a228	je	0x10000a22f
000000010000a22a	callq	0x1000111ae                     ## symbol stub for: _fflush
000000010000a22f	movq	0x8e12(%rip), %r12              ## literal pool symbol address: ___stdoutp
000000010000a236	movq	(%r12), %rdi
000000010000a23a	callq	0x1000111ae                     ## symbol stub for: _fflush
000000010000a23f	movq	-0x60(%rbp), %r14
000000010000a243	movq	-0x58(%rbp), %r15
000000010000a247	movq	(%r12), %rdi
000000010000a24b	callq	0x1000111ae                     ## symbol stub for: _fflush
000000010000a250	movq	0x8de1(%rip), %r13              ## literal pool symbol address: ___stderrp
000000010000a257	movq	(%r13), %rdi
000000010000a25b	leaq	0x8386(%rip), %rsi              ## literal pool for: "%s: "
000000010000a262	leaq	0x762d(%rip), %rdx              ## literal pool for: "reduce64"
000000010000a269	xorl	%eax, %eax
000000010000a26b	callq	0x1000111ba                     ## symbol stub for: _fprintf
000000010000a270	cmpl	$0x10, (%r15)
000000010000a274	jne	0x10000a2b4
000000010000a276	movq	0x8(%r15), %rdi
000000010000a27a	testq	%rdi, %rdi
000000010000a27d	je	0x10000a2b4
000000010000a27f	leaq	0x8367(%rip), %rsi              ## literal pool for: "IoError"
000000010000a286	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000a28b	testl	%eax, %eax
000000010000a28d	jne	0x10000a2b4
000000010000a28f	cmpl	$0x2, 0x10(%r15)
000000010000a294	jne	0x10000a2b4
000000010000a296	movq	0x10(%r14), %rdi
000000010000a29a	movq	(%rdi), %rdx
000000010000a29d	addq	$0x8, %rdi
000000010000a2a1	movq	(%r13), %rcx
000000010000a2a5	movl	$0x1, %esi
000000010000a2aa	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000a2af	jmp	0x10000a345
000000010000a2b4	movq	(%r13), %r12
000000010000a2b8	xorps	%xmm0, %xmm0
000000010000a2bb	movaps	%xmm0, -0x40(%rbp)
000000010000a2bf	movq	$0x0, -0x30(%rbp)
000000010000a2c7	leaq	-0x40(%rbp), %rdi
000000010000a2cb	movq	%r14, %rsi
000000010000a2ce	movq	%r15, %rdx
000000010000a2d1	movl	$0x1, %ecx
000000010000a2d6	callq	_fwp_write
000000010000a2db	movq	-0x40(%rbp), %rdi
000000010000a2df	testq	%rdi, %rdi
000000010000a2e2	je	0x10000a33c
000000010000a2e4	movq	-0x38(%rbp), %rdx
000000010000a2e8	movl	$0x1, %esi
000000010000a2ed	movq	%r12, %rcx
000000010000a2f0	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000a2f5	movq	-0x40(%rbp), %rdi
000000010000a2f9	jmp	0x10000a340
000000010000a2fb	leaq	_fwp_gc(%rip), %rax
000000010000a302	movzbl	0xa8e8(%rip), %ecx
000000010000a309	movl	0xb48(%rax,%rcx,4), %edx
000000010000a310	movl	%edx, %esi
000000010000a312	subq	%rsi, _fwp_gc(%rip)
000000010000a319	js	0x10000a36c
000000010000a31b	leaq	(%rcx,%rcx,2), %rcx
000000010000a31f	leaq	(%rax,%rcx,8), %rax
000000010000a323	addq	$0x788, %rax                    ## imm = 0x788
000000010000a329	movq	(%rax), %r15
000000010000a32c	testq	%r15, %r15
000000010000a32f	je	0x10000a35c
000000010000a331	movq	(%r15), %rcx
000000010000a334	notq	%rcx
000000010000a337	movq	%rcx, (%rax)
000000010000a33a	jmp	0x10000a388
000000010000a33c	xorl	%eax, %eax
000000010000a33e	movl	%eax, %edi
000000010000a340	callq	0x1000111d2                     ## symbol stub for: _free
000000010000a345	movq	(%r13), %rsi
000000010000a349	movl	$0xa, %edi
000000010000a34e	callq	0x1000111c0                     ## symbol stub for: _fputc
000000010000a353	movl	$0x1, %ecx
000000010000a358	xorl	%eax, %eax
000000010000a35a	jmp	0x10000a3b4
000000010000a35c	movq	0x8(%rax), %r15
000000010000a360	movq	0x10(%rax), %rcx
000000010000a364	subq	%r15, %rcx
000000010000a367	cmpq	%rsi, %rcx
000000010000a36a	jae	0x10000a380
000000010000a36c	movl	$0x8, %edi
000000010000a371	movl	$0x2, %esi
000000010000a376	callq	_fwp_gc_alloc_slow
000000010000a37b	movq	%rax, %rdi
000000010000a37e	jmp	0x10000a393
000000010000a380	leaq	(%r15,%rsi), %rcx
000000010000a384	movq	%rcx, 0x8(%rax)
000000010000a388	movq	%r15, %rdi
000000010000a38b	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000a390	movq	%r15, %rdi
000000010000a393	movq	$0x0, (%rdi)
000000010000a39a	movl	$0x1, %esi
000000010000a39f	movq	%r14, %rdx
000000010000a3a2	callq	_fwp_apply
000000010000a3a7	movq	-0x68(%rbp), %rcx
000000010000a3ab	movq	%rcx, _fwp_handlers(%rip)
000000010000a3b2	xorl	%ecx, %ecx
000000010000a3b4	movl	%ecx, (%rbx)
000000010000a3b6	addq	$0xd8, %rsp
000000010000a3bd	popq	%rbx
000000010000a3be	popq	%r12
000000010000a3c0	popq	%r13
000000010000a3c2	popq	%r14
000000010000a3c4	popq	%r15
000000010000a3c6	popq	%rbp
000000010000a3c7	retq
000000010000a3c8	nopl	(%rax,%rax)
_fwp_emit_result:
000000010000a3d0	pushq	%rbp
000000010000a3d1	movq	%rsp, %rbp
000000010000a3d4	pushq	%r15
000000010000a3d6	pushq	%r14
000000010000a3d8	pushq	%rbx
000000010000a3d9	subq	$0x28, %rsp
000000010000a3dd	movq	%rdi, %rbx
000000010000a3e0	cmpl	$0x0, _fwp_exec_binary_out(%rip)
000000010000a3e7	je	0x10000a50d
000000010000a3ed	xorps	%xmm0, %xmm0
000000010000a3f0	movaps	%xmm0, -0x40(%rbp)
000000010000a3f4	movq	$0x0, -0x30(%rbp)
000000010000a3fc	movb	%bl, -0x1d(%rbp)
000000010000a3ff	leaq	-0x40(%rbp), %r15
000000010000a403	leaq	-0x1d(%rbp), %r14
000000010000a407	movl	$0x1, %edx
000000010000a40c	movq	%r15, %rdi
000000010000a40f	movq	%r14, %rsi
000000010000a412	callq	_buf_put
000000010000a417	movb	%bh, -0x1d(%rbp)
000000010000a41a	movl	$0x1, %edx
000000010000a41f	movq	%r15, %rdi
000000010000a422	movq	%r14, %rsi
000000010000a425	callq	_buf_put
000000010000a42a	movl	%ebx, %eax
000000010000a42c	shrl	$0x10, %eax
000000010000a42f	movb	%al, -0x1d(%rbp)
000000010000a432	movl	$0x1, %edx
000000010000a437	movq	%r15, %rdi
000000010000a43a	movq	%r14, %rsi
000000010000a43d	callq	_buf_put
000000010000a442	movl	%ebx, %eax
000000010000a444	shrl	$0x18, %eax
000000010000a447	movb	%al, -0x1d(%rbp)
000000010000a44a	movl	$0x1, %edx
000000010000a44f	movq	%r15, %rdi
000000010000a452	movq	%r14, %rsi
000000010000a455	callq	_buf_put
000000010000a45a	movq	%rbx, %rax
000000010000a45d	shrq	$0x20, %rax
000000010000a461	movb	%al, -0x1d(%rbp)
000000010000a464	movl	$0x1, %edx
000000010000a469	movq	%r15, %rdi
000000010000a46c	movq	%r14, %rsi
000000010000a46f	callq	_buf_put
000000010000a474	movq	%rbx, %rax
000000010000a477	shrq	$0x28, %rax
000000010000a47b	movb	%al, -0x1d(%rbp)
000000010000a47e	movl	$0x1, %edx
000000010000a483	movq	%r15, %rdi
000000010000a486	movq	%r14, %rsi
000000010000a489	callq	_buf_put
000000010000a48e	movq	%rbx, %rax
000000010000a491	shrq	$0x30, %rax
000000010000a495	movb	%al, -0x1d(%rbp)
000000010000a498	movl	$0x1, %edx
000000010000a49d	movq	%r15, %rdi
000000010000a4a0	movq	%r14, %rsi
000000010000a4a3	callq	_buf_put
000000010000a4a8	shrq	$0x38, %rbx
000000010000a4ac	movb	%bl, -0x1d(%rbp)
000000010000a4af	movl	$0x1, %edx
000000010000a4b4	movq	%r15, %rdi
000000010000a4b7	movq	%r14, %rsi
000000010000a4ba	callq	_buf_put
000000010000a4bf	movb	$0x1, -0x1d(%rbp)
000000010000a4c3	movq	-0x38(%rbp), %rbx
000000010000a4c7	movl	%ebx, -0x1c(%rbp)
000000010000a4ca	movq	0x8b77(%rip), %r15              ## literal pool symbol address: ___stdoutp
000000010000a4d1	movq	(%r15), %rcx
000000010000a4d4	leaq	-0x1d(%rbp), %rdi
000000010000a4d8	movl	$0x1, %esi
000000010000a4dd	movl	$0x5, %edx
000000010000a4e2	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000a4e7	movq	-0x40(%rbp), %r14
000000010000a4eb	testq	%rbx, %rbx
000000010000a4ee	je	0x10000a503
000000010000a4f0	movq	(%r15), %rcx
000000010000a4f3	movl	$0x1, %esi
000000010000a4f8	movq	%r14, %rdi
000000010000a4fb	movq	%rbx, %rdx
000000010000a4fe	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000a503	movq	%r14, %rdi
000000010000a506	callq	0x1000111d2                     ## symbol stub for: _free
000000010000a50b	jmp	0x10000a572
000000010000a50d	movq	0x8b34(%rip), %r15              ## literal pool symbol address: ___stdoutp
000000010000a514	movq	(%r15), %r14
000000010000a517	xorps	%xmm0, %xmm0
000000010000a51a	movaps	%xmm0, -0x40(%rbp)
000000010000a51e	movq	$0x0, -0x30(%rbp)
000000010000a526	leaq	_d0(%rip), %rdx
000000010000a52d	leaq	-0x40(%rbp), %rdi
000000010000a531	movq	%rbx, %rsi
000000010000a534	movl	$0x1, %ecx
000000010000a539	callq	_fwp_write
000000010000a53e	movq	-0x40(%rbp), %rdi
000000010000a542	testq	%rdi, %rdi
000000010000a545	je	0x10000a55e
000000010000a547	movq	-0x38(%rbp), %rdx
000000010000a54b	movl	$0x1, %esi
000000010000a550	movq	%r14, %rcx
000000010000a553	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000a558	movq	-0x40(%rbp), %rdi
000000010000a55c	jmp	0x10000a560
000000010000a55e	xorl	%edi, %edi
000000010000a560	callq	0x1000111d2                     ## symbol stub for: _free
000000010000a565	movq	(%r15), %rsi
000000010000a568	movl	$0xa, %edi
000000010000a56d	callq	0x1000111c0                     ## symbol stub for: _fputc
000000010000a572	addq	$0x28, %rsp
000000010000a576	popq	%rbx
000000010000a577	popq	%r14
000000010000a579	popq	%r15
000000010000a57b	popq	%rbp
000000010000a57c	retq
000000010000a57d	nopl	(%rax)
_fwp_read_exact:
000000010000a580	pushq	%rbp
000000010000a581	movq	%rsp, %rbp
000000010000a584	pushq	%r15
000000010000a586	pushq	%r14
000000010000a588	pushq	%r12
000000010000a58a	pushq	%rbx
000000010000a58b	movq	%rsi, %rbx
000000010000a58e	movq	%rdi, %r14
000000010000a591	movl	_fwp_in_npend(%rip), %eax
000000010000a597	movl	_fwp_in_ppos(%rip), %ecx
000000010000a59d	testq	%rsi, %rsi
000000010000a5a0	setne	%dl
000000010000a5a3	cmpl	%eax, %ecx
000000010000a5a5	setl	%sil
000000010000a5a9	testb	%sil, %dl
000000010000a5ac	je	0x10000a61a
000000010000a5ae	cltq
000000010000a5b0	movslq	%ecx, %rsi
000000010000a5b3	movq	%rsi, %rdx
000000010000a5b6	notq	%rdx
000000010000a5b9	addq	%rax, %rdx
000000010000a5bc	leaq	-0x1(%rbx), %rcx
000000010000a5c0	cmpq	%rcx, %rdx
000000010000a5c3	cmovaeq	%rcx, %rdx
000000010000a5c7	incq	%rdx
000000010000a5ca	cmpq	$0x1f, %rdx
000000010000a5ce	jbe	0x10000a5e6
000000010000a5d0	leaq	_fwp_in_pend(%rip), %rdi
000000010000a5d7	movq	%r14, %r8
000000010000a5da	subq	%rsi, %r8
000000010000a5dd	subq	%rdi, %r8
000000010000a5e0	cmpq	$0x20, %r8
000000010000a5e4	jae	0x10000a61f
000000010000a5e6	xorl	%r15d, %r15d
000000010000a5e9	movq	%rsi, %rcx
000000010000a5ec	leaq	_fwp_in_pend(%rip), %rdx
000000010000a5f3	nopw	%cs:(%rax,%rax)
000000010000a600	movzbl	(%rcx,%rdx), %esi
000000010000a604	incq	%rcx
000000010000a607	movb	%sil, (%r14,%r15)
000000010000a60b	incq	%r15
000000010000a60e	cmpq	%rbx, %r15
000000010000a611	jae	0x10000a662
000000010000a613	cmpq	%rax, %rcx
000000010000a616	jl	0x10000a600
000000010000a618	jmp	0x10000a662
000000010000a61a	xorl	%r15d, %r15d
000000010000a61d	jmp	0x10000a668
000000010000a61f	movq	%rdx, %r15
000000010000a622	andq	$-0x20, %r15
000000010000a626	leaq	(%r15,%rsi), %rcx
000000010000a62a	addq	%rdi, %rsi
000000010000a62d	addq	$0x10, %rsi
000000010000a631	xorl	%edi, %edi
000000010000a633	nopw	%cs:(%rax,%rax)
000000010000a640	movups	-0x10(%rsi,%rdi), %xmm0
000000010000a645	movups	(%rsi,%rdi), %xmm1
000000010000a649	movups	%xmm0, (%r14,%rdi)
000000010000a64e	movups	%xmm1, 0x10(%r14,%rdi)
000000010000a654	addq	$0x20, %rdi
000000010000a658	cmpq	%rdi, %r15
000000010000a65b	jne	0x10000a640
000000010000a65d	cmpq	%r15, %rdx
000000010000a660	jne	0x10000a5ec
000000010000a662	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a668	movq	0x89d1(%rip), %r12              ## literal pool symbol address: ___stdinp
000000010000a66f	nop
000000010000a670	movq	%rbx, %rdx
000000010000a673	subq	%r15, %rdx
000000010000a676	jbe	0x10000a696
000000010000a678	leaq	(%r14,%r15), %rdi
000000010000a67c	movq	(%r12), %rcx
000000010000a680	movl	$0x1, %esi
000000010000a685	callq	0x1000111cc                     ## symbol stub for: _fread
000000010000a68a	addq	%rax, %r15
000000010000a68d	testq	%rax, %rax
000000010000a690	jne	0x10000a670
000000010000a692	xorl	%eax, %eax
000000010000a694	jmp	0x10000a69b
000000010000a696	movl	$0x1, %eax
000000010000a69b	popq	%rbx
000000010000a69c	popq	%r12
000000010000a69e	popq	%r14
000000010000a6a0	popq	%r15
000000010000a6a2	popq	%rbp
000000010000a6a3	retq
000000010000a6a4	nopw	%cs:(%rax,%rax)
_fwp_stdin_leb:
000000010000a6b0	pushq	%rbp
000000010000a6b1	movq	%rsp, %rbp
000000010000a6b4	pushq	%r15
000000010000a6b6	pushq	%r14
000000010000a6b8	pushq	%r13
000000010000a6ba	pushq	%r12
000000010000a6bc	pushq	%rbx
000000010000a6bd	pushq	%rax
000000010000a6be	movq	%rdi, %rbx
000000010000a6c1	movq	$0x0, (%rdi)
000000010000a6c8	movq	$-0x7, %r14
000000010000a6cf	leaq	_fwp_in_pend(%rip), %r12
000000010000a6d6	movq	0x8963(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000a6dd	leaq	-0x29(%rbp), %r15
000000010000a6e1	nopw	%cs:(%rax,%rax)
000000010000a6f0	movslq	_fwp_in_ppos(%rip), %rax
000000010000a6f7	cmpl	_fwp_in_npend(%rip), %eax
000000010000a6fd	jge	0x10000a720
000000010000a6ff	leal	0x1(%rax), %ecx
000000010000a702	movzbl	(%rax,%r12), %eax
000000010000a707	movb	%al, -0x29(%rbp)
000000010000a70a	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a710	jmp	0x10000a73b
000000010000a712	nopw	%cs:(%rax,%rax)
000000010000a720	movq	(%r13), %rcx
000000010000a724	movl	$0x1, %esi
000000010000a729	movl	$0x1, %edx
000000010000a72e	movq	%r15, %rdi
000000010000a731	callq	0x1000111cc                     ## symbol stub for: _fread
000000010000a736	testq	%rax, %rax
000000010000a739	je	0x10000a77c
000000010000a73b	cmpq	$0x38, %r14
000000010000a73f	setne	%cl
000000010000a742	movzbl	-0x29(%rbp), %eax
000000010000a746	testb	$0x7e, %al
000000010000a748	sete	%dl
000000010000a74b	orb	%cl, %dl
000000010000a74d	je	0x10000a76e
000000010000a74f	addq	$0x7, %r14
000000010000a753	movzbl	%al, %eax
000000010000a756	movl	%eax, %edx
000000010000a758	andl	$0x7f, %edx
000000010000a75b	movl	%r14d, %ecx
000000010000a75e	shlq	%cl, %rdx
000000010000a761	orq	%rdx, (%rbx)
000000010000a764	testb	%al, %al
000000010000a766	jns	0x10000a775
000000010000a768	cmpq	$0x38, %r14
000000010000a76c	jbe	0x10000a6f0
000000010000a76e	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000a773	jmp	0x10000a77e
000000010000a775	movl	$0x1, %eax
000000010000a77a	jmp	0x10000a77e
000000010000a77c	xorl	%eax, %eax
000000010000a77e	addq	$0x8, %rsp
000000010000a782	popq	%rbx
000000010000a783	popq	%r12
000000010000a785	popq	%r13
000000010000a787	popq	%r14
000000010000a789	popq	%r15
000000010000a78b	popq	%rbp
000000010000a78c	retq
000000010000a78d	nopl	(%rax)
_fwp_stdin_name_len:
000000010000a790	pushq	%rbp
000000010000a791	movq	%rsp, %rbp
000000010000a794	pushq	%r15
000000010000a796	pushq	%r14
000000010000a798	pushq	%r13
000000010000a79a	pushq	%r12
000000010000a79c	pushq	%rbx
000000010000a79d	pushq	%rax
000000010000a79e	movq	%rdi, %rbx
000000010000a7a1	movq	$0x0, (%rdi)
000000010000a7a8	movq	$-0x7, %r14
000000010000a7af	leaq	_fwp_in_pend(%rip), %r12
000000010000a7b6	movq	0x8883(%rip), %r13              ## literal pool symbol address: ___stdinp
000000010000a7bd	leaq	-0x29(%rbp), %r15
000000010000a7c1	nopw	%cs:(%rax,%rax)
000000010000a7d0	movslq	_fwp_in_ppos(%rip), %rax
000000010000a7d7	cmpl	_fwp_in_npend(%rip), %eax
000000010000a7dd	jge	0x10000a800
000000010000a7df	leal	0x1(%rax), %ecx
000000010000a7e2	movzbl	(%rax,%r12), %eax
000000010000a7e7	movb	%al, -0x29(%rbp)
000000010000a7ea	movl	%ecx, _fwp_in_ppos(%rip)
000000010000a7f0	jmp	0x10000a81b
000000010000a7f2	nopw	%cs:(%rax,%rax)
000000010000a800	movq	(%r13), %rcx
000000010000a804	movl	$0x1, %esi
000000010000a809	movl	$0x1, %edx
000000010000a80e	movq	%r15, %rdi
000000010000a811	callq	0x1000111cc                     ## symbol stub for: _fread
000000010000a816	testq	%rax, %rax
000000010000a819	je	0x10000a871
000000010000a81b	cmpq	$0x38, %r14
000000010000a81f	setne	%cl
000000010000a822	movzbl	-0x29(%rbp), %eax
000000010000a826	testb	$0x7e, %al
000000010000a828	sete	%dl
000000010000a82b	orb	%cl, %dl
000000010000a82d	je	0x10000a855
000000010000a82f	addq	$0x7, %r14
000000010000a833	movzbl	%al, %eax
000000010000a836	movl	%eax, %edx
000000010000a838	andl	$0x7f, %edx
000000010000a83b	movl	%r14d, %ecx
000000010000a83e	shlq	%cl, %rdx
000000010000a841	orq	(%rbx), %rdx
000000010000a844	movq	%rdx, (%rbx)
000000010000a847	testb	%al, %al
000000010000a849	jns	0x10000a85c
000000010000a84b	cmpq	$0x38, %r14
000000010000a84f	jbe	0x10000a7d0
000000010000a855	movl	$0xffffffff, %ecx               ## imm = 0xFFFFFFFF
000000010000a85a	jmp	0x10000a873
000000010000a85c	movl	$0x1, %ecx
000000010000a861	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000a866	cmpq	$0x100000, %rdx                 ## imm = 0x100000
000000010000a86d	jbe	0x10000a873
000000010000a86f	jmp	0x10000a875
000000010000a871	xorl	%ecx, %ecx
000000010000a873	movl	%ecx, %eax
000000010000a875	addq	$0x8, %rsp
000000010000a879	popq	%rbx
000000010000a87a	popq	%r12
000000010000a87c	popq	%r13
000000010000a87e	popq	%r14
000000010000a880	popq	%r15
000000010000a882	popq	%rbp
000000010000a883	retq
000000010000a884	nopw	%cs:(%rax,%rax)
_fwp_decode:
000000010000a890	pushq	%rbp
000000010000a891	movq	%rsp, %rbp
000000010000a894	pushq	%r15
000000010000a896	pushq	%r14
000000010000a898	pushq	%r13
000000010000a89a	pushq	%r12
000000010000a89c	pushq	%rbx
000000010000a89d	subq	$0x48, %rsp
000000010000a8a1	movq	0x8788(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000a8a8	movq	(%rax), %rax
000000010000a8ab	movq	%rax, -0x30(%rbp)
000000010000a8af	movl	(%rsi), %eax
000000010000a8b1	xorl	%r8d, %r8d
000000010000a8b4	cmpq	$0x15, %rax
000000010000a8b8	ja	0x10000ae37
000000010000a8be	movq	%rdx, %r9
000000010000a8c1	movq	%rsi, %r15
000000010000a8c4	movq	%rdi, %r14
000000010000a8c7	leaq	0x84e(%rip), %rcx
000000010000a8ce	movslq	(%rcx,%rax,4), %rdx
000000010000a8d2	addq	%rcx, %rdx
000000010000a8d5	jmpq	*%rdx
000000010000a8d7	xorl	%ecx, %ecx
000000010000a8d9	cmpl	$0xa, %eax
000000010000a8dc	setne	%cl
000000010000a8df	leaq	0x4(,%rcx,4), %rax
000000010000a8e7	movq	0x8(%r14), %rdx
000000010000a8eb	movq	0x10(%r14), %rcx
000000010000a8ef	subq	%rcx, %rdx
000000010000a8f2	cmpq	%rax, %rdx
000000010000a8f5	jb	0x10000ae37
000000010000a8fb	movq	(%r14), %rdx
000000010000a8fe	addq	%rcx, %rdx
000000010000a901	addq	%rax, %rcx
000000010000a904	movq	%rcx, 0x10(%r14)
000000010000a908	cmpq	$0x8, %rax
000000010000a90c	jae	0x10000a914
000000010000a90e	xorl	%esi, %esi
000000010000a910	xorl	%edi, %edi
000000010000a912	jmp	0x10000a979
000000010000a914	movl	%eax, %esi
000000010000a916	andl	$-0x8, %esi
000000010000a919	pmovzxbq	0x2(%rdx), %xmm0
000000010000a91f	pmovzxbq	0x6(%rdx), %xmm1
000000010000a925	pmovzxbq	0x4(%rdx), %xmm2
000000010000a92b	pmovzxbq	(%rdx), %xmm3
000000010000a930	movdqa	%xmm3, %xmm4
000000010000a934	psllq	$0x8, %xmm4
000000010000a939	pshufb	0x6a5e(%rip), %xmm2
000000010000a942	pblendw	$0xf, %xmm3, %xmm4              ## xmm4 = xmm3[0,1,2,3],xmm4[4,5,6,7]
000000010000a948	por	%xmm4, %xmm2
000000010000a94c	pshufb	0x6a5b(%rip), %xmm1
000000010000a955	pshufb	0x6a62(%rip), %xmm0
000000010000a95e	por	%xmm1, %xmm0
000000010000a962	por	%xmm2, %xmm0
000000010000a966	pshufd	$0xee, %xmm0, %xmm1             ## xmm1 = xmm0[2,3,2,3]
000000010000a96b	por	%xmm0, %xmm1
000000010000a96f	movq	%xmm1, %rdi
000000010000a974	cmpq	%rsi, %rax
000000010000a977	je	0x10000a997
000000010000a979	leal	(,%rsi,8), %ecx
000000010000a980	movzbl	(%rdx,%rsi), %r8d
000000010000a985	shlq	%cl, %r8
000000010000a988	orq	%r8, %rdi
000000010000a98b	incq	%rsi
000000010000a98e	addq	$0x8, %rcx
000000010000a992	cmpq	%rsi, %rax
000000010000a995	jne	0x10000a980
000000010000a997	movq	%rdi, (%r9)
000000010000a99a	movl	$0x1, %r8d
000000010000a9a0	jmp	0x10000ae37
000000010000a9a5	movq	%r9, %r12
000000010000a9a8	leaq	-0x58(%rbp), %rsi
000000010000a9ac	movq	%r14, %rdi
000000010000a9af	callq	_rd_leb
000000010000a9b4	testl	%eax, %eax
000000010000a9b6	je	0x10000ae34
000000010000a9bc	movq	-0x58(%rbp), %rbx
000000010000a9c0	movq	0x8(%r14), %rcx
000000010000a9c4	cmpq	%rcx, %rbx
000000010000a9c7	movl	$0x0, %r8d
000000010000a9cd	ja	0x10000ae37
000000010000a9d3	movq	0x10(%r14), %rax
000000010000a9d7	subq	%rax, %rcx
000000010000a9da	cmpq	%rbx, %rcx
000000010000a9dd	jb	0x10000ae37
000000010000a9e3	movq	(%r14), %r13
000000010000a9e6	addq	%rax, %r13
000000010000a9e9	addq	%rbx, %rax
000000010000a9ec	movq	%rax, 0x10(%r14)
000000010000a9f0	cmpl	$0xc, (%r15)
000000010000a9f4	movq	%r12, %rcx
000000010000a9f7	jne	0x10000aa12
000000010000a9f9	movq	%r13, %rdi
000000010000a9fc	movq	%rbx, %rsi
000000010000a9ff	callq	_fwp_valid_utf8
000000010000aa04	xorl	%r8d, %r8d
000000010000aa07	movq	%r12, %rcx
000000010000aa0a	testl	%eax, %eax
000000010000aa0c	je	0x10000ae37
000000010000aa12	movq	%r13, %rdi
000000010000aa15	movq	%rbx, %rsi
000000010000aa18	movq	%rcx, %rbx
000000010000aa1b	callq	_fwp_str_new
000000010000aa20	movq	%rax, (%rbx)
000000010000aa23	jmp	0x10000a99a
000000010000aa28	movq	0x10(%r14), %rax
000000010000aa2c	cmpq	%rax, 0x8(%r14)
000000010000aa30	je	0x10000ae37
000000010000aa36	movq	(%r14), %rcx
000000010000aa39	leaq	0x1(%rax), %rdx
000000010000aa3d	movq	%rdx, 0x10(%r14)
000000010000aa41	movsbq	(%rcx,%rax), %rax
000000010000aa46	movq	%rax, (%r9)
000000010000aa49	jmp	0x10000a99a
000000010000aa4e	movq	0x8(%r14), %rsi
000000010000aa52	movq	0x10(%r14), %rcx
000000010000aa56	movq	%rsi, %rdx
000000010000aa59	subq	%rcx, %rdx
000000010000aa5c	cmpq	$0x8, %rdx
000000010000aa60	jb	0x10000ae37
000000010000aa66	movq	(%r14), %rdx
000000010000aa69	leaq	0x8(%rcx), %rdi
000000010000aa6d	movq	%rdi, 0x10(%r14)
000000010000aa71	subq	%rdi, %rsi
000000010000aa74	cmpq	$0x8, %rsi
000000010000aa78	jb	0x10000ae37
000000010000aa7e	movq	%r9, %rbx
000000010000aa81	movq	(%rdx,%rcx), %rdi
000000010000aa85	leaq	0x10(%rcx), %rsi
000000010000aa89	movq	%rsi, 0x10(%r14)
000000010000aa8d	movq	0x8(%rdx,%rcx), %rsi
000000010000aa92	cmpl	$0x4, %eax
000000010000aa95	jne	0x10000ae1d
000000010000aa9b	callq	_fwp_box_u128
000000010000aaa0	movq	%rax, (%rbx)
000000010000aaa3	jmp	0x10000a99a
000000010000aaa8	movq	%r9, -0x50(%rbp)
000000010000aaac	movq	0x38(%r15), %rbx
000000010000aab0	leaq	-0x58(%rbp), %rsi
000000010000aab4	movq	%r14, %rdi
000000010000aab7	callq	_rd_leb
000000010000aabc	testl	%eax, %eax
000000010000aabe	je	0x10000ae34
000000010000aac4	movq	-0x58(%rbp), %r12
000000010000aac8	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000aad2	cmpq	%rax, %r12
000000010000aad5	movl	$0x0, %r8d
000000010000aadb	ja	0x10000ae37
000000010000aae1	movq	%rbx, %rdi
000000010000aae4	xorl	%esi, %esi
000000010000aae6	callq	_fwp_wire_empty_inner
000000010000aaeb	xorl	%r8d, %r8d
000000010000aaee	testl	%eax, %eax
000000010000aaf0	jne	0x10000aafc
000000010000aaf2	cmpq	0x8(%r14), %r12
000000010000aaf6	ja	0x10000ae37
000000010000aafc	cmpl	$0x11, (%r15)
000000010000ab00	jne	0x10000adb4
000000010000ab06	movq	0x38(%r15), %rsi
000000010000ab0a	movq	%r12, %rdi
000000010000ab0d	callq	_fwp_array_new_packed
000000010000ab12	movq	%rax, %r13
000000010000ab15	testq	%r12, %r12
000000010000ab18	je	0x10000ab4f
000000010000ab1a	xorl	%ebx, %ebx
000000010000ab1c	movq	0x38(%r15), %rsi
000000010000ab20	movq	%r14, %rdi
000000010000ab23	leaq	-0x40(%rbp), %rdx
000000010000ab27	callq	_fwp_decode
000000010000ab2c	testl	%eax, %eax
000000010000ab2e	je	0x10000ae34
000000010000ab34	movq	-0x40(%rbp), %rdx
000000010000ab38	movq	0x38(%r15), %rcx
000000010000ab3c	movq	%r13, %rdi
000000010000ab3f	movq	%rbx, %rsi
000000010000ab42	callq	_fwp_array_store
000000010000ab47	incq	%rbx
000000010000ab4a	cmpq	%rbx, %r12
000000010000ab4d	jne	0x10000ab1c
000000010000ab4f	movq	-0x50(%rbp), %rax
000000010000ab53	movq	%r13, (%rax)
000000010000ab56	jmp	0x10000a99a
000000010000ab5b	movq	%r9, -0x50(%rbp)
000000010000ab5f	leaq	-0x58(%rbp), %rsi
000000010000ab63	movq	%r14, %rdi
000000010000ab66	callq	_rd_leb
000000010000ab6b	testl	%eax, %eax
000000010000ab6d	je	0x10000ae34
000000010000ab73	movq	-0x58(%rbp), %r13
000000010000ab77	movslq	0x10(%r15), %rax
000000010000ab7b	cmpq	%rax, %r13
000000010000ab7e	movl	$0x0, %r8d
000000010000ab84	jae	0x10000ae37
000000010000ab8a	movq	0x28(%r15), %rax
000000010000ab8e	movslq	(%rax,%r13,4), %rbx
000000010000ab92	leaq	0x8(,%rbx,8), %rdi
000000010000ab9a	callq	_fwp_alloc
000000010000ab9f	movq	%rax, -0x48(%rbp)
000000010000aba3	movq	%rbx, -0x60(%rbp)
000000010000aba7	testq	%rbx, %rbx
000000010000abaa	jle	0x10000abe8
000000010000abac	movq	-0x60(%rbp), %rax
000000010000abb0	leaq	(,%rax,8), %rbx
000000010000abb8	xorl	%r12d, %r12d
000000010000abbb	movq	0x30(%r15), %rax
000000010000abbf	movq	(%rax,%r13,8), %rax
000000010000abc3	movq	(%rax,%r12), %rsi
000000010000abc7	movq	-0x48(%rbp), %rax
000000010000abcb	leaq	(%rax,%r12), %rdx
000000010000abcf	movq	%r14, %rdi
000000010000abd2	callq	_fwp_decode
000000010000abd7	testl	%eax, %eax
000000010000abd9	je	0x10000ae34
000000010000abdf	addq	$0x8, %r12
000000010000abe3	cmpq	%r12, %rbx
000000010000abe6	jne	0x10000abbb
000000010000abe8	movl	%r13d, %edi
000000010000abeb	movq	-0x60(%rbp), %rsi
000000010000abef	movq	-0x48(%rbp), %rdx
000000010000abf3	callq	_fwp_data
000000010000abf8	jmp	0x10000b108
000000010000abfd	movl	$0x1, %eax
000000010000ac02	jmp	0x10000a8e7
000000010000ac07	movl	$0x2, %eax
000000010000ac0c	jmp	0x10000a8e7
000000010000ac11	movq	0x8(%r14), %rcx
000000010000ac15	movq	0x10(%r14), %rax
000000010000ac19	subq	%rax, %rcx
000000010000ac1c	cmpq	$0x2, %rcx
000000010000ac20	jb	0x10000ae37
000000010000ac26	movq	(%r14), %rcx
000000010000ac29	leaq	0x2(%rax), %rdx
000000010000ac2d	movq	%rdx, 0x10(%r14)
000000010000ac31	movzbl	(%rcx,%rax), %edx
000000010000ac35	movzbl	0x1(%rcx,%rax), %eax
000000010000ac3a	shlq	$0x38, %rax
000000010000ac3e	shlq	$0x30, %rdx
000000010000ac42	orq	%rax, %rdx
000000010000ac45	sarq	$0x30, %rdx
000000010000ac49	movq	%rdx, (%r9)
000000010000ac4c	jmp	0x10000a99a
000000010000ac51	movq	0x8(%r14), %rcx
000000010000ac55	movq	0x10(%r14), %rax
000000010000ac59	subq	%rax, %rcx
000000010000ac5c	cmpq	$0x4, %rcx
000000010000ac60	jb	0x10000ae37
000000010000ac66	movq	(%r14), %rcx
000000010000ac69	leaq	0x4(%rax), %rdx
000000010000ac6d	movq	%rdx, 0x10(%r14)
000000010000ac71	movzbl	(%rcx,%rax), %edx
000000010000ac75	movzbl	0x1(%rcx,%rax), %esi
000000010000ac7a	movzbl	0x2(%rcx,%rax), %edi
000000010000ac7f	movzbl	0x3(%rcx,%rax), %eax
000000010000ac84	shlq	$0x38, %rax
000000010000ac88	shlq	$0x30, %rdi
000000010000ac8c	shlq	$0x28, %rsi
000000010000ac90	shlq	$0x20, %rdx
000000010000ac94	orq	%rsi, %rdx
000000010000ac97	orq	%rdi, %rdx
000000010000ac9a	orq	%rax, %rdx
000000010000ac9d	sarq	$0x20, %rdx
000000010000aca1	movq	%rdx, (%r9)
000000010000aca4	jmp	0x10000a99a
000000010000aca9	movl	$0x4, %eax
000000010000acae	jmp	0x10000a8e7
000000010000acb3	movq	%r9, %r12
000000010000acb6	movq	0x40(%r15), %rdi
000000010000acba	xorl	%esi, %esi
000000010000acbc	callq	_fwp_wire_empty_inner
000000010000acc1	testl	%eax, %eax
000000010000acc3	setne	%r13b
000000010000acc7	jmp	0x10000accf
000000010000acc9	movq	%r9, %r12
000000010000accc	movb	$0x1, %r13b
000000010000accf	movq	0x38(%r15), %rbx
000000010000acd3	leaq	-0x58(%rbp), %rsi
000000010000acd7	movq	%r14, %rdi
000000010000acda	callq	_rd_leb
000000010000acdf	testl	%eax, %eax
000000010000ace1	je	0x10000ae34
000000010000ace7	movb	%r13b, -0x48(%rbp)
000000010000aceb	movq	-0x58(%rbp), %r13
000000010000acef	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000acf9	cmpq	%rax, %r13
000000010000acfc	movl	$0x0, %r8d
000000010000ad02	ja	0x10000ae37
000000010000ad08	movq	%r12, -0x50(%rbp)
000000010000ad0c	movq	%rbx, %rdi
000000010000ad0f	xorl	%esi, %esi
000000010000ad11	callq	_fwp_wire_empty_inner
000000010000ad16	testl	%eax, %eax
000000010000ad18	je	0x10000ae2a
000000010000ad1e	cmpq	$0x2, %r13
000000010000ad22	setae	%al
000000010000ad25	movzbl	-0x48(%rbp), %ecx
000000010000ad29	testb	%cl, %al
000000010000ad2b	je	0x10000ae5d
000000010000ad31	jmp	0x10000ae34
000000010000ad36	movslq	0x10(%r15), %rdi
000000010000ad3a	testq	%rdi, %rdi
000000010000ad3d	je	0x10000ada8
000000010000ad3f	shlq	$0x3, %rdi
000000010000ad43	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000ad4a	movq	%r9, -0x50(%rbp)
000000010000ad4e	ja	0x10000aee8
000000010000ad54	leaq	0xf(%rdi), %rcx
000000010000ad58	shrq	$0x4, %rcx
000000010000ad5c	leaq	_fwp_gc(%rip), %rax
000000010000ad63	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000ad6b	movl	0xb48(%rax,%rcx,4), %esi
000000010000ad72	subq	%rsi, _fwp_gc(%rip)
000000010000ad79	js	0x10000aee8
000000010000ad7f	leaq	(%rcx,%rcx,2), %rcx
000000010000ad83	leaq	(%rax,%rcx,8), %rax
000000010000ad87	addq	$0x788, %rax                    ## imm = 0x788
000000010000ad8d	movq	(%rax), %r12
000000010000ad90	testq	%r12, %r12
000000010000ad93	je	0x10000aed8
000000010000ad99	movq	(%r12), %rcx
000000010000ad9d	notq	%rcx
000000010000ada0	movq	%rcx, (%rax)
000000010000ada3	jmp	0x10000af0b
000000010000ada8	movq	$0x0, (%r9)
000000010000adaf	jmp	0x10000a99a
000000010000adb4	cmpq	$0x7ff, %r12                    ## imm = 0x7FF
000000010000adbb	ja	0x10000afc9
000000010000adc1	leaq	(,%r12,8), %rcx
000000010000adc9	addq	$0x17, %rcx
000000010000adcd	shrq	$0x4, %rcx
000000010000add1	leaq	_fwp_gc(%rip), %rax
000000010000add8	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000ade0	movl	0xb48(%rax,%rcx,4), %esi
000000010000ade7	subq	%rsi, _fwp_gc(%rip)
000000010000adee	js	0x10000afc9
000000010000adf4	leaq	(%rcx,%rcx,2), %rcx
000000010000adf8	leaq	(%rax,%rcx,8), %rax
000000010000adfc	addq	$0x788, %rax                    ## imm = 0x788
000000010000ae02	movq	(%rax), %r13
000000010000ae05	testq	%r13, %r13
000000010000ae08	je	0x10000afb5
000000010000ae0e	movq	(%r13), %rcx
000000010000ae12	notq	%rcx
000000010000ae15	movq	%rcx, (%rax)
000000010000ae18	jmp	0x10000b08a
000000010000ae1d	callq	_fwp_box_u128
000000010000ae22	movq	%rax, (%rbx)
000000010000ae25	jmp	0x10000a99a
000000010000ae2a	cmpq	0x8(%r14), %r13
000000010000ae2e	movzbl	-0x48(%rbp), %ecx
000000010000ae32	jbe	0x10000ae5d
000000010000ae34	xorl	%r8d, %r8d
000000010000ae37	movq	0x81f2(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ae3e	movq	(%rax), %rax
000000010000ae41	cmpq	-0x30(%rbp), %rax
000000010000ae45	jne	0x10000b114
000000010000ae4b	movl	%r8d, %eax
000000010000ae4e	addq	$0x48, %rsp
000000010000ae52	popq	%rbx
000000010000ae53	popq	%r12
000000010000ae55	popq	%r13
000000010000ae57	popq	%r14
000000010000ae59	popq	%r15
000000010000ae5b	popq	%rbp
000000010000ae5c	retq
000000010000ae5d	testb	%cl, %cl
000000010000ae5f	movl	$0x0, %r8d
000000010000ae65	jne	0x10000ae6d
000000010000ae67	cmpq	0x8(%r14), %r13
000000010000ae6b	ja	0x10000ae37
000000010000ae6d	leaq	_fwp_empty_map(%rip), %r12
000000010000ae74	testq	%r13, %r13
000000010000ae77	je	0x10000aef7
000000010000ae79	leaq	-0x40(%rbp), %rbx
000000010000ae7d	jmp	0x10000ae99
000000010000ae7f	xorl	%esi, %esi
000000010000ae81	movq	-0x40(%rbp), %rdi
000000010000ae85	movq	0x38(%r15), %rcx
000000010000ae89	movq	%r12, %rdx
000000010000ae8c	callq	_fwp_p_map_insert
000000010000ae91	movq	%rax, %r12
000000010000ae94	decq	%r13
000000010000ae97	je	0x10000aef7
000000010000ae99	movq	$0x0, -0x68(%rbp)
000000010000aea1	movq	0x38(%r15), %rsi
000000010000aea5	movq	%r14, %rdi
000000010000aea8	movq	%rbx, %rdx
000000010000aeab	callq	_fwp_decode
000000010000aeb0	testl	%eax, %eax
000000010000aeb2	je	0x10000ae34
000000010000aeb4	cmpl	$0x12, (%r15)
000000010000aeb8	jne	0x10000ae7f
000000010000aeba	movq	0x40(%r15), %rsi
000000010000aebe	movq	%r14, %rdi
000000010000aec1	leaq	-0x68(%rbp), %rdx
000000010000aec5	callq	_fwp_decode
000000010000aeca	testl	%eax, %eax
000000010000aecc	je	0x10000ae34
000000010000aed2	movq	-0x68(%rbp), %rsi
000000010000aed6	jmp	0x10000ae81
000000010000aed8	movq	0x8(%rax), %r12
000000010000aedc	movq	0x10(%rax), %rcx
000000010000aee0	subq	%r12, %rcx
000000010000aee3	cmpq	%rsi, %rcx
000000010000aee6	jae	0x10000af03
000000010000aee8	movl	$0x2, %esi
000000010000aeed	callq	_fwp_gc_alloc_slow
000000010000aef2	movq	%rax, %r12
000000010000aef5	jmp	0x10000af13
000000010000aef7	movq	-0x50(%rbp), %rax
000000010000aefb	movq	%r12, (%rax)
000000010000aefe	jmp	0x10000a99a
000000010000af03	leaq	(%r12,%rsi), %rcx
000000010000af07	movq	%rcx, 0x8(%rax)
000000010000af0b	movq	%r12, %rdi
000000010000af0e	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000af13	movl	0x10(%r15), %r13d
000000010000af17	testl	%r13d, %r13d
000000010000af1a	jle	0x10000af5f
000000010000af1c	movq	%r12, -0x48(%rbp)
000000010000af20	movq	%r12, %rbx
000000010000af23	xorl	%r12d, %r12d
000000010000af26	nopw	%cs:(%rax,%rax)
000000010000af30	movq	0x20(%r15), %rax
000000010000af34	movq	(%rax,%r12,8), %rsi
000000010000af38	movq	%r14, %rdi
000000010000af3b	movq	%rbx, %rdx
000000010000af3e	callq	_fwp_decode
000000010000af43	testl	%eax, %eax
000000010000af45	je	0x10000ae34
000000010000af4b	incq	%r12
000000010000af4e	movslq	0x10(%r15), %r13
000000010000af52	addq	$0x8, %rbx
000000010000af56	cmpq	%r13, %r12
000000010000af59	jl	0x10000af30
000000010000af5b	movq	-0x48(%rbp), %r12
000000010000af5f	testl	%r13d, %r13d
000000010000af62	je	0x10000af8f
000000010000af64	movl	%r13d, %ebx
000000010000af67	leaq	0x8(,%rbx,8), %rdi
000000010000af6f	callq	_fwp_alloc_init
000000010000af74	movl	$0x0, (%rax)
000000010000af7a	movl	%r13d, 0x4(%rax)
000000010000af7e	cmpl	$0x8, %r13d
000000010000af82	jae	0x10000af9d
000000010000af84	xorl	%ecx, %ecx
000000010000af86	movq	-0x50(%rbp), %r8
000000010000af8a	jmp	0x10000b01c
000000010000af8f	xorl	%eax, %eax
000000010000af91	movq	-0x50(%rbp), %r8
000000010000af95	movq	%rax, (%r8)
000000010000af98	jmp	0x10000a99a
000000010000af9d	movq	%rax, %rcx
000000010000afa0	subq	%r12, %rcx
000000010000afa3	addq	$0x8, %rcx
000000010000afa7	cmpq	$0x20, %rcx
000000010000afab	movq	-0x50(%rbp), %r8
000000010000afaf	jae	0x10000afe3
000000010000afb1	xorl	%ecx, %ecx
000000010000afb3	jmp	0x10000b01c
000000010000afb5	movq	0x8(%rax), %r13
000000010000afb9	movq	0x10(%rax), %rcx
000000010000afbd	subq	%r13, %rcx
000000010000afc0	cmpq	%rsi, %rcx
000000010000afc3	jae	0x10000b082
000000010000afc9	leaq	0x8(,%r12,8), %rdi
000000010000afd1	movl	$0x2, %esi
000000010000afd6	callq	_fwp_gc_alloc_slow
000000010000afdb	movq	%rax, %r13
000000010000afde	jmp	0x10000b092
000000010000afe3	movl	%ebx, %ecx
000000010000afe5	andl	$-0x4, %ecx
000000010000afe8	leaq	(,%rbx,8), %rdx
000000010000aff0	andq	$-0x20, %rdx
000000010000aff4	xorl	%esi, %esi
000000010000aff6	movdqu	(%r12,%rsi), %xmm0
000000010000affc	movdqu	0x10(%r12,%rsi), %xmm1
000000010000b003	movdqu	%xmm0, 0x8(%rax,%rsi)
000000010000b009	movdqu	%xmm1, 0x18(%rax,%rsi)
000000010000b00f	addq	$0x20, %rsi
000000010000b013	cmpq	%rsi, %rdx
000000010000b016	jne	0x10000aff6
000000010000b018	cmpl	%ebx, %ecx
000000010000b01a	je	0x10000b07a
000000010000b01c	movq	%rbx, %rsi
000000010000b01f	movq	%rcx, %rdx
000000010000b022	andq	$0x3, %rsi
000000010000b026	je	0x10000b041
000000010000b028	movq	%rcx, %rdx
000000010000b02b	nopl	(%rax,%rax)
000000010000b030	movq	(%r12,%rdx,8), %rdi
000000010000b034	movq	%rdi, 0x8(%rax,%rdx,8)
000000010000b039	incq	%rdx
000000010000b03c	decq	%rsi
000000010000b03f	jne	0x10000b030
000000010000b041	subq	%rbx, %rcx
000000010000b044	cmpq	$-0x4, %rcx
000000010000b048	ja	0x10000b07a
000000010000b04a	movq	(%r12,%rdx,8), %rcx
000000010000b04e	movq	%rcx, 0x8(%rax,%rdx,8)
000000010000b053	movq	0x8(%r12,%rdx,8), %rcx
000000010000b058	movq	%rcx, 0x10(%rax,%rdx,8)
000000010000b05d	movq	0x10(%r12,%rdx,8), %rcx
000000010000b062	movq	%rcx, 0x18(%rax,%rdx,8)
000000010000b067	movq	0x18(%r12,%rdx,8), %rcx
000000010000b06c	movq	%rcx, 0x20(%rax,%rdx,8)
000000010000b071	addq	$0x4, %rdx
000000010000b075	cmpq	%rdx, %rbx
000000010000b078	jne	0x10000b04a
000000010000b07a	movq	%rax, (%r8)
000000010000b07d	jmp	0x10000a99a
000000010000b082	leaq	(%rsi,%r13), %rcx
000000010000b086	movq	%rcx, 0x8(%rax)
000000010000b08a	movq	%r13, %rdi
000000010000b08d	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000b092	testq	%r12, %r12
000000010000b095	je	0x10000b106
000000010000b097	movq	%r13, -0x48(%rbp)
000000010000b09b	movq	%r13, %rbx
000000010000b09e	movq	%r12, %r13
000000010000b0a1	movq	0x38(%r15), %rsi
000000010000b0a5	movq	%r14, %rdi
000000010000b0a8	movq	%rbx, %rdx
000000010000b0ab	callq	_fwp_decode
000000010000b0b0	testl	%eax, %eax
000000010000b0b2	je	0x10000ae34
000000010000b0b8	addq	$0x8, %rbx
000000010000b0bc	decq	%r13
000000010000b0bf	jne	0x10000b0a1
000000010000b0c1	xorl	%r15d, %r15d
000000010000b0c4	movabsq	$0x200000001, %rbx              ## imm = 0x200000001
000000010000b0ce	leaq	-0x40(%rbp), %r14
000000010000b0d2	movq	-0x48(%rbp), %rax
000000010000b0d6	movq	-0x8(%rax,%r12,8), %r13
000000010000b0db	movq	%r13, -0x40(%rbp)
000000010000b0df	movq	%r15, -0x38(%rbp)
000000010000b0e3	movl	$0x18, %edi
000000010000b0e8	callq	_fwp_alloc_init
000000010000b0ed	movq	%rbx, (%rax)
000000010000b0f0	movq	%r13, 0x8(%rax)
000000010000b0f4	movq	-0x48(%rbp), %r13
000000010000b0f8	movq	%r15, 0x10(%rax)
000000010000b0fc	movq	%rax, %r15
000000010000b0ff	decq	%r12
000000010000b102	jne	0x10000b0d2
000000010000b104	jmp	0x10000b108
000000010000b106	xorl	%eax, %eax
000000010000b108	movq	-0x50(%rbp), %rcx
000000010000b10c	movq	%rax, (%rcx)
000000010000b10f	jmp	0x10000a99a
000000010000b114	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
000000010000b119	nopl	(%rax)
000000010000b11c	orb	$-0x7, %al
000000010000b11e	.byte 0xff #bad opcode
000000010000b11f	pushq	%rbp
000000010000b121	cli
000000010000b122	.byte 0xff #bad opcode
000000010000b123	pushq	-0x44000005(%rip)
000000010000b129	idivl	%edi
000000010000b12b	pushq	(%rdx)
000000010000b12d	stc
000000010000b12e	.byte 0xff #bad opcode
000000010000b12f	jmpq	*%rcx
000000010000b131	cli
000000010000b132	.byte 0xff #bad opcode
000000010000b133	.byte 0xff #bad opcode
000000010000b134	jmp	0x10000b130
000000010000b136	.byte 0xff #bad opcode
000000010000b137	decl	-0x44000005(%rbp)
000000010000b13d	idivl	%edi
000000010000b13f	pushq	(%rdx)
000000010000b141	stc
000000010000b142	.byte 0xff #bad opcode
000000010000b143	.byte 0xff #bad opcode
000000010000b144	movl	$0xbbfffff7, %ebx               ## imm = 0xBBFFFFF7
000000010000b149	idivl	%edi
000000010000b14b	decl	-0x76000008(%rcx)
000000010000b151	clc
000000010000b152	.byte 0xff #bad opcode
000000010000b153	.byte 0xff #bad opcode
000000010000b154	.byte 0x3f #bad opcode
000000010000b155	cli
000000010000b156	.byte 0xff #bad opcode
000000010000b157	decl	-0x3e50001(%rcx,%rdi,8)
000000010000b15e	.byte 0xff #bad opcode
000000010000b15f	decl	-0x4680001(%rcx,%rdi,8)
000000010000b166	.byte 0xff #bad opcode
000000010000b167	ljmpl	*-0x44000005(%rbp)
000000010000b16d	idivl	%edi
000000010000b16f	decl	(%rcx,%rdi,8)
000000010000b172	.byte 0xff #bad opcode
000000010000b173	jmpq	*0x66(%rsi)
000000010000b176	nopw	%cs:(%rax,%rax)
_fwp_valid_utf8:
000000010000b180	testq	%rsi, %rsi
000000010000b183	je	0x10000b2e2
000000010000b189	pushq	%rbp
000000010000b18a	movq	%rsp, %rbp
000000010000b18d	pushq	%rbx
000000010000b18e	xorl	%ecx, %ecx
000000010000b190	jmp	0x10000b1ac
000000010000b192	nopw	%cs:(%rax,%rax)
000000010000b1a0	incq	%rcx
000000010000b1a3	cmpq	%rsi, %rcx
000000010000b1a6	jae	0x10000b2da
000000010000b1ac	movzbl	(%rdi,%rcx), %r10d
000000010000b1b1	testb	%r10b, %r10b
000000010000b1b4	jns	0x10000b1a0
000000010000b1b6	leal	0x3e(%r10), %eax
000000010000b1ba	cmpb	$0x1e, %al
000000010000b1bc	jae	0x10000b1d0
000000010000b1be	movl	$0x80, %edx
000000010000b1c3	movl	$0x1, %eax
000000010000b1c8	movl	$0x1f, %r8d
000000010000b1ce	jmp	0x10000b207
000000010000b1d0	movl	%r10d, %eax
000000010000b1d3	andb	$-0x10, %al
000000010000b1d5	cmpb	$-0x20, %al
000000010000b1d7	jne	0x10000b1eb
000000010000b1d9	movl	$0x800, %edx                    ## imm = 0x800
000000010000b1de	movl	$0x2, %eax
000000010000b1e3	movl	$0xf, %r8d
000000010000b1e9	jmp	0x10000b207
000000010000b1eb	leal	0x10(%r10), %eax
000000010000b1ef	cmpb	$0x4, %al
000000010000b1f1	ja	0x10000b2e8
000000010000b1f7	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000b1fc	movl	$0x3, %eax
000000010000b201	movl	$0x7, %r8d
000000010000b207	movl	%eax, %r9d
000000010000b20a	leaq	(%rcx,%r9), %r11
000000010000b20e	xorl	%eax, %eax
000000010000b210	cmpq	%rsi, %r11
000000010000b213	jae	0x10000b2df
000000010000b219	movzbl	0x1(%rdi,%rcx), %r11d
000000010000b21f	movl	%r11d, %ebx
000000010000b222	andl	$-0x40, %ebx
000000010000b225	cmpl	$0x80, %ebx
000000010000b22b	jne	0x10000b2df
000000010000b231	andl	%r10d, %r8d
000000010000b234	leal	0x1(%r9), %ebx
000000010000b238	movl	%r8d, %r10d
000000010000b23b	shll	$0x6, %r10d
000000010000b23f	andl	$0x3f, %r11d
000000010000b243	orl	%r10d, %r11d
000000010000b246	cmpl	$0x2, %ebx
000000010000b249	jne	0x10000b257
000000010000b24b	movl	%r11d, %ebx
000000010000b24e	cmpl	%edx, %ebx
000000010000b250	jae	0x10000b2b2
000000010000b252	jmp	0x10000b2df
000000010000b257	movzbl	0x2(%rdi,%rcx), %r8d
000000010000b25d	movl	%r8d, %r10d
000000010000b260	andl	$-0x40, %r10d
000000010000b264	cmpl	$0x80, %r10d
000000010000b26b	jne	0x10000b2df
000000010000b26d	movl	%r11d, %r10d
000000010000b270	shll	$0x6, %r10d
000000010000b274	andl	$0x3f, %r8d
000000010000b278	orl	%r10d, %r8d
000000010000b27b	cmpl	$0x3, %ebx
000000010000b27e	jne	0x10000b28c
000000010000b280	movl	%r8d, %ebx
000000010000b283	movl	%r11d, %r8d
000000010000b286	cmpl	%edx, %ebx
000000010000b288	jae	0x10000b2b2
000000010000b28a	jmp	0x10000b2df
000000010000b28c	movzbl	0x3(%rdi,%rcx), %ebx
000000010000b291	movl	%ebx, %r10d
000000010000b294	andl	$-0x40, %r10d
000000010000b298	cmpl	$0x80, %r10d
000000010000b29f	jne	0x10000b2df
000000010000b2a1	movl	%r8d, %r10d
000000010000b2a4	shll	$0x6, %r10d
000000010000b2a8	andl	$0x3f, %ebx
000000010000b2ab	orl	%r10d, %ebx
000000010000b2ae	cmpl	%edx, %ebx
000000010000b2b0	jb	0x10000b2df
000000010000b2b2	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000b2b9	ja	0x10000b2df
000000010000b2bb	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000b2c2	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000b2c9	je	0x10000b2df
000000010000b2cb	addq	%r9, %rcx
000000010000b2ce	incq	%rcx
000000010000b2d1	cmpq	%rsi, %rcx
000000010000b2d4	jb	0x10000b1ac
000000010000b2da	movl	$0x1, %eax
000000010000b2df	popq	%rbx
000000010000b2e0	popq	%rbp
000000010000b2e1	retq
000000010000b2e2	movl	$0x1, %eax
000000010000b2e7	retq
000000010000b2e8	xorl	%eax, %eax
000000010000b2ea	jmp	0x10000b2df
000000010000b2ec	nopl	(%rax)
_fwp_str_new:
000000010000b2f0	pushq	%rbp
000000010000b2f1	movq	%rsp, %rbp
000000010000b2f4	pushq	%r15
000000010000b2f6	pushq	%r14
000000010000b2f8	pushq	%rbx
000000010000b2f9	pushq	%rax
000000010000b2fa	movq	%rsi, %r14
000000010000b2fd	movq	%rdi, %rbx
000000010000b300	addq	$0x9, %rsi
000000010000b304	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000b30b	ja	0x10000b366
000000010000b30d	leaq	0x18(%r14), %rax
000000010000b311	shrq	$0x4, %rax
000000010000b315	leaq	_fwp_gc(%rip), %rcx
000000010000b31c	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b324	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b32b	subq	%rax, _fwp_gc(%rip)
000000010000b332	js	0x10000b366
000000010000b334	leaq	(%rdx,%rdx,2), %rdx
000000010000b338	leaq	(%rcx,%rdx,8), %rcx
000000010000b33c	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b343	movq	(%rcx), %r15
000000010000b346	testq	%r15, %r15
000000010000b349	je	0x10000b356
000000010000b34b	movq	(%r15), %rax
000000010000b34e	notq	%rax
000000010000b351	movq	%rax, (%rcx)
000000010000b354	jmp	0x10000b37f
000000010000b356	movq	0x8(%rcx), %r15
000000010000b35a	movq	0x10(%rcx), %rdx
000000010000b35e	subq	%r15, %rdx
000000010000b361	cmpq	%rax, %rdx
000000010000b364	jae	0x10000b378
000000010000b366	movq	%rsi, %rdi
000000010000b369	movl	$0x1, %esi
000000010000b36e	callq	_fwp_gc_alloc_slow
000000010000b373	movq	%rax, %r15
000000010000b376	jmp	0x10000b387
000000010000b378	addq	%r15, %rax
000000010000b37b	movq	%rax, 0x8(%rcx)
000000010000b37f	movq	%r15, %rdi
000000010000b382	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000b387	movq	%r14, (%r15)
000000010000b38a	leaq	0x8(%r15), %rdi
000000010000b38e	movq	%rbx, %rsi
000000010000b391	movq	%r14, %rdx
000000010000b394	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000b399	movb	$0x0, 0x8(%r15,%r14)
000000010000b39f	movq	%r15, %rax
000000010000b3a2	addq	$0x8, %rsp
000000010000b3a6	popq	%rbx
000000010000b3a7	popq	%r14
000000010000b3a9	popq	%r15
000000010000b3ab	popq	%rbp
000000010000b3ac	retq
000000010000b3ad	nopl	(%rax)
_buf_put:
000000010000b3b0	pushq	%rbp
000000010000b3b1	movq	%rsp, %rbp
000000010000b3b4	pushq	%r15
000000010000b3b6	pushq	%r14
000000010000b3b8	pushq	%r12
000000010000b3ba	pushq	%rbx
000000010000b3bb	movq	%rdi, %r14
000000010000b3be	movq	0x8(%rdi), %rdi
000000010000b3c2	cmpq	$-0x1, %rdi
000000010000b3c6	je	0x10000b468
000000010000b3cc	movq	%rdx, %rbx
000000010000b3cf	movq	$-0x2, %rax
000000010000b3d6	subq	%rdi, %rax
000000010000b3d9	cmpq	%rdx, %rax
000000010000b3dc	jb	0x10000b468
000000010000b3e2	leaq	(%rbx,%rdi), %rax
000000010000b3e6	incq	%rax
000000010000b3e9	movq	0x10(%r14), %rcx
000000010000b3ed	cmpq	%rcx, %rax
000000010000b3f0	jbe	0x10000b41f
000000010000b3f2	testq	%rcx, %rcx
000000010000b3f5	movl	$0x40, %r15d
000000010000b3fb	cmovneq	%rcx, %r15
000000010000b3ff	movq	%rsi, %r12
000000010000b402	cmpq	%rax, %r15
000000010000b405	jae	0x10000b427
000000010000b407	nopw	(%rax,%rax)
000000010000b410	testq	%r15, %r15
000000010000b413	js	0x10000b424
000000010000b415	addq	%r15, %r15
000000010000b418	cmpq	%rax, %r15
000000010000b41b	jb	0x10000b410
000000010000b41d	jmp	0x10000b427
000000010000b41f	movq	(%r14), %rax
000000010000b422	jmp	0x10000b445
000000010000b424	movq	%rax, %r15
000000010000b427	movq	(%r14), %rdi
000000010000b42a	movq	%r15, %rsi
000000010000b42d	callq	0x10001124a                     ## symbol stub for: _realloc
000000010000b432	testq	%rax, %rax
000000010000b435	je	0x10000b468
000000010000b437	movq	%rax, (%r14)
000000010000b43a	movq	%r15, 0x10(%r14)
000000010000b43e	movq	0x8(%r14), %rdi
000000010000b442	movq	%r12, %rsi
000000010000b445	addq	%rax, %rdi
000000010000b448	movq	%rbx, %rdx
000000010000b44b	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000b450	addq	0x8(%r14), %rbx
000000010000b454	movq	%rbx, 0x8(%r14)
000000010000b458	movq	(%r14), %rax
000000010000b45b	movb	$0x0, (%rax,%rbx)
000000010000b45f	popq	%rbx
000000010000b460	popq	%r12
000000010000b462	popq	%r14
000000010000b464	popq	%r15
000000010000b466	popq	%rbp
000000010000b467	retq
000000010000b468	movq	0x7bc9(%rip), %rax              ## literal pool symbol address: ___stderrp
000000010000b46f	movq	(%rax), %rcx
000000010000b472	leaq	0x6576(%rip), %rdi              ## literal pool for: "fwp: out of memory\n"
000000010000b479	movl	$0x13, %esi
000000010000b47e	movl	$0x1, %edx
000000010000b483	callq	0x1000111d8                     ## symbol stub for: _fwrite
000000010000b488	movl	$0x66, %edi
000000010000b48d	callq	0x1000111a8                     ## symbol stub for: _exit
000000010000b492	nopw	%cs:(%rax,%rax)
_buf_to_str:
000000010000b4a0	pushq	%rbp
000000010000b4a1	movq	%rsp, %rbp
000000010000b4a4	pushq	%r14
000000010000b4a6	pushq	%rbx
000000010000b4a7	movq	%rdi, %rbx
000000010000b4aa	movq	(%rdi), %rax
000000010000b4ad	movq	0x8(%rdi), %rsi
000000010000b4b1	testq	%rax, %rax
000000010000b4b4	leaq	0x63d7(%rip), %rdi              ## literal pool for: ""
000000010000b4bb	cmovneq	%rax, %rdi
000000010000b4bf	callq	_fwp_str_new
000000010000b4c4	movq	%rax, %r14
000000010000b4c7	movq	(%rbx), %rdi
000000010000b4ca	callq	0x1000111d2                     ## symbol stub for: _free
000000010000b4cf	movq	%r14, %rax
000000010000b4d2	popq	%rbx
000000010000b4d3	popq	%r14
000000010000b4d5	popq	%rbp
000000010000b4d6	retq
000000010000b4d7	nopw	(%rax,%rax)
_fwp_strf:
000000010000b4e0	pushq	%rbp
000000010000b4e1	movq	%rsp, %rbp
000000010000b4e4	pushq	%r15
000000010000b4e6	pushq	%r14
000000010000b4e8	pushq	%r13
000000010000b4ea	pushq	%r12
000000010000b4ec	pushq	%rbx
000000010000b4ed	subq	$0xd8, %rsp
000000010000b4f4	movq	%rsi, -0xf8(%rbp)
000000010000b4fb	movq	%rdx, -0xf0(%rbp)
000000010000b502	movq	%rcx, -0xe8(%rbp)
000000010000b509	movq	%r8, -0xe0(%rbp)
000000010000b510	movq	%r9, -0xd8(%rbp)
000000010000b517	testb	%al, %al
000000010000b519	je	0x10000b54a
000000010000b51b	movaps	%xmm0, -0xd0(%rbp)
000000010000b522	movaps	%xmm1, -0xc0(%rbp)
000000010000b529	movaps	%xmm2, -0xb0(%rbp)
000000010000b530	movaps	%xmm3, -0xa0(%rbp)
000000010000b537	movaps	%xmm4, -0x90(%rbp)
000000010000b53e	movaps	%xmm5, -0x80(%rbp)
000000010000b542	movaps	%xmm6, -0x70(%rbp)
000000010000b546	movaps	%xmm7, -0x60(%rbp)
000000010000b54a	movq	0x7adf(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b551	movq	(%rax), %rax
000000010000b554	movq	%rax, -0x30(%rbp)
000000010000b558	leaq	-0x100(%rbp), %rax
000000010000b55f	movq	%rax, -0x40(%rbp)
000000010000b563	leaq	0x10(%rbp), %r13
000000010000b567	movq	%r13, -0x48(%rbp)
000000010000b56b	movabsq	$0x3000000008, %r12             ## imm = 0x3000000008
000000010000b575	movq	%r12, -0x50(%rbp)
000000010000b579	leaq	0x6fd5(%rip), %rdx              ## literal pool for: "cannot parse `%.*s` as %s"
000000010000b580	leaq	-0x50(%rbp), %rcx
000000010000b584	xorl	%edi, %edi
000000010000b586	xorl	%esi, %esi
000000010000b588	callq	0x1000112b6                     ## symbol stub for: _vsnprintf
000000010000b58d	movslq	%eax, %rbx
000000010000b590	leaq	0x1(%rbx), %r14
000000010000b594	cmpq	$0x4000, %r14                   ## imm = 0x4000
000000010000b59b	ja	0x10000b5f6
000000010000b59d	leaq	0x10(%rbx), %rax
000000010000b5a1	shrq	$0x4, %rax
000000010000b5a5	leaq	_fwp_gc(%rip), %rcx
000000010000b5ac	movzbl	0xbe8(%rax,%rcx), %edx
000000010000b5b4	movl	0xb48(%rcx,%rdx,4), %eax
000000010000b5bb	subq	%rax, _fwp_gc(%rip)
000000010000b5c2	js	0x10000b5f6
000000010000b5c4	leaq	(%rdx,%rdx,2), %rdx
000000010000b5c8	leaq	(%rcx,%rdx,8), %rcx
000000010000b5cc	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000b5d3	movq	(%rcx), %r15
000000010000b5d6	testq	%r15, %r15
000000010000b5d9	je	0x10000b5e6
000000010000b5db	movq	(%r15), %rax
000000010000b5de	notq	%rax
000000010000b5e1	movq	%rax, (%rcx)
000000010000b5e4	jmp	0x10000b60f
000000010000b5e6	movq	0x8(%rcx), %r15
000000010000b5ea	movq	0x10(%rcx), %rdx
000000010000b5ee	subq	%r15, %rdx
000000010000b5f1	cmpq	%rax, %rdx
000000010000b5f4	jae	0x10000b608
000000010000b5f6	movq	%r14, %rdi
000000010000b5f9	movl	$0x1, %esi
000000010000b5fe	callq	_fwp_gc_alloc_slow
000000010000b603	movq	%rax, %r15
000000010000b606	jmp	0x10000b61a
000000010000b608	addq	%r15, %rax
000000010000b60b	movq	%rax, 0x8(%rcx)
000000010000b60f	movq	%r15, %rdi
000000010000b612	movq	%r14, %rsi
000000010000b615	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000b61a	leaq	-0x100(%rbp), %rax
000000010000b621	movq	%rax, -0x40(%rbp)
000000010000b625	movq	%r13, -0x48(%rbp)
000000010000b629	movq	%r12, -0x50(%rbp)
000000010000b62d	leaq	0x6f21(%rip), %rdx              ## literal pool for: "cannot parse `%.*s` as %s"
000000010000b634	leaq	-0x50(%rbp), %rcx
000000010000b638	movq	%r15, %rdi
000000010000b63b	movq	%r14, %rsi
000000010000b63e	callq	0x1000112b6                     ## symbol stub for: _vsnprintf
000000010000b643	movq	%r15, %rdi
000000010000b646	movq	%rbx, %rsi
000000010000b649	callq	_fwp_str_new
000000010000b64e	movq	0x79db(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b655	movq	(%rcx), %rcx
000000010000b658	cmpq	-0x30(%rbp), %rcx
000000010000b65c	jne	0x10000b670
000000010000b65e	addq	$0xd8, %rsp
000000010000b665	popq	%rbx
000000010000b666	popq	%r12
000000010000b668	popq	%r13
000000010000b66a	popq	%r14
000000010000b66c	popq	%r15
000000010000b66e	popq	%rbp
000000010000b66f	retq
000000010000b670	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
000000010000b675	nopw	%cs:(%rax,%rax)
_tp_value:
000000010000b680	pushq	%rbp
000000010000b681	movq	%rsp, %rbp
000000010000b684	pushq	%r15
000000010000b686	pushq	%r14
000000010000b688	pushq	%r13
000000010000b68a	pushq	%r12
000000010000b68c	pushq	%rbx
000000010000b68d	subq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b694	movq	%rcx, %rbx
000000010000b697	movq	%rsi, %rax
000000010000b69a	movq	0x798f(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b6a1	movq	(%rcx), %rcx
000000010000b6a4	movq	%rcx, -0x30(%rbp)
000000010000b6a8	testl	%edx, %edx
000000010000b6aa	je	0x10000b711
000000010000b6ac	cmpl	$0xc, (%rax)
000000010000b6af	jne	0x10000b711
000000010000b6b1	movq	0x8(%rdi), %rsi
000000010000b6b5	movq	0x10(%rdi), %r15
000000010000b6b9	movq	%rbx, %r12
000000010000b6bc	movq	(%rdi), %rax
000000010000b6bf	addq	%r15, %rax
000000010000b6c2	subq	%r15, %rsi
000000010000b6c5	jne	0x10000b79c
000000010000b6cb	movq	%rdi, %rbx
000000010000b6ce	movq	%rax, %rdi
000000010000b6d1	callq	_fwp_str_new
000000010000b6d6	movq	%rax, (%r12)
000000010000b6da	movq	0x8(%rbx), %rax
000000010000b6de	movq	%rax, 0x10(%rbx)
000000010000b6e2	movl	$0x1, %r14d
000000010000b6e8	movq	0x7941(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000b6ef	movq	(%rax), %rax
000000010000b6f2	cmpq	-0x30(%rbp), %rax
000000010000b6f6	jne	0x10000cf0c
000000010000b6fc	movl	%r14d, %eax
000000010000b6ff	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b706	popq	%rbx
000000010000b707	popq	%r12
000000010000b709	popq	%r13
000000010000b70b	popq	%r14
000000010000b70d	popq	%r15
000000010000b70f	popq	%rbp
000000010000b710	retq
000000010000b711	movq	0x8(%rdi), %rsi
000000010000b715	movq	0x10(%rdi), %r15
000000010000b719	cmpq	%rsi, %r15
000000010000b71c	jae	0x10000b750
000000010000b71e	movq	(%rdi), %rcx
000000010000b721	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000b72b	nopl	(%rax,%rax)
000000010000b730	movzbl	(%rcx,%r15), %r9d
000000010000b735	cmpq	$0x20, %r9
000000010000b739	ja	0x10000b750
000000010000b73b	btq	%r9, %r8
000000010000b73f	jae	0x10000b750
000000010000b741	incq	%r15
000000010000b744	movq	%r15, 0x10(%rdi)
000000010000b748	cmpq	%r15, %rsi
000000010000b74b	jne	0x10000b730
000000010000b74d	movq	%rsi, %r15
000000010000b750	movl	(%rax), %ecx
000000010000b752	xorl	%r14d, %r14d
000000010000b755	cmpq	$0x15, %rcx
000000010000b759	ja	0x10000b6e8
000000010000b75b	leaq	0x17b2(%rip), %r8
000000010000b762	movslq	(%r8,%rcx,4), %r9
000000010000b766	addq	%r8, %r9
000000010000b769	jmpq	*%r9
000000010000b76c	movq	0x78bd(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000b773	movq	(%rcx), %rcx
000000010000b776	cmpq	-0x30(%rbp), %rcx
000000010000b77a	jne	0x10000cf0c
000000010000b780	movq	%rax, %rsi
000000010000b783	movq	%rbx, %rdx
000000010000b786	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000b78d	popq	%rbx
000000010000b78e	popq	%r12
000000010000b790	popq	%r13
000000010000b792	popq	%r14
000000010000b794	popq	%r15
000000010000b796	popq	%rbp
000000010000b797	jmp	_tp_int
000000010000b79c	xorl	%ecx, %ecx
000000010000b79e	jmp	0x10000b7ac
000000010000b7a0	incq	%rcx
000000010000b7a3	cmpq	%rsi, %rcx
000000010000b7a6	jae	0x10000b6cb
000000010000b7ac	movzbl	(%rax,%rcx), %r10d
000000010000b7b1	testb	%r10b, %r10b
000000010000b7b4	jns	0x10000b7a0
000000010000b7b6	leal	0x3e(%r10), %edx
000000010000b7ba	cmpb	$0x1e, %dl
000000010000b7bd	jae	0x10000b7d2
000000010000b7bf	movl	$0x80, %edx
000000010000b7c4	movl	$0x1, %r9d
000000010000b7ca	movl	$0x1f, %r8d
000000010000b7d0	jmp	0x10000b80e
000000010000b7d2	movl	%r10d, %edx
000000010000b7d5	andb	$-0x10, %dl
000000010000b7d8	cmpb	$-0x20, %dl
000000010000b7db	jne	0x10000b7f0
000000010000b7dd	movl	$0x800, %edx                    ## imm = 0x800
000000010000b7e2	movl	$0x2, %r9d
000000010000b7e8	movl	$0xf, %r8d
000000010000b7ee	jmp	0x10000b80e
000000010000b7f0	leal	0x10(%r10), %edx
000000010000b7f4	cmpb	$0x4, %dl
000000010000b7f7	ja	0x10000ce3c
000000010000b7fd	movl	$0x10000, %edx                  ## imm = 0x10000
000000010000b802	movl	$0x3, %r9d
000000010000b808	movl	$0x7, %r8d
000000010000b80e	movl	%r9d, %r9d
000000010000b811	leaq	(%rcx,%r9), %r11
000000010000b815	xorl	%r14d, %r14d
000000010000b818	cmpq	%rsi, %r11
000000010000b81b	jae	0x10000b6e8
000000010000b821	movzbl	0x1(%rax,%rcx), %r11d
000000010000b827	movl	%r11d, %ebx
000000010000b82a	andl	$-0x40, %ebx
000000010000b82d	cmpl	$0x80, %ebx
000000010000b833	jne	0x10000b6e8
000000010000b839	andl	%r10d, %r8d
000000010000b83c	leal	0x1(%r9), %ebx
000000010000b840	movl	%r8d, %r10d
000000010000b843	shll	$0x6, %r10d
000000010000b847	andl	$0x3f, %r11d
000000010000b84b	orl	%r10d, %r11d
000000010000b84e	cmpl	$0x2, %ebx
000000010000b851	jne	0x10000b858
000000010000b853	movl	%r11d, %ebx
000000010000b856	jmp	0x10000b8b3
000000010000b858	movzbl	0x2(%rax,%rcx), %r8d
000000010000b85e	movl	%r8d, %r10d
000000010000b861	andl	$-0x40, %r10d
000000010000b865	cmpl	$0x80, %r10d
000000010000b86c	jne	0x10000b6e8
000000010000b872	movl	%r11d, %r10d
000000010000b875	shll	$0x6, %r10d
000000010000b879	andl	$0x3f, %r8d
000000010000b87d	orl	%r10d, %r8d
000000010000b880	cmpl	$0x3, %ebx
000000010000b883	jne	0x10000b88d
000000010000b885	movl	%r8d, %ebx
000000010000b888	movl	%r11d, %r8d
000000010000b88b	jmp	0x10000b8b3
000000010000b88d	movzbl	0x3(%rax,%rcx), %ebx
000000010000b892	movl	%ebx, %r10d
000000010000b895	andl	$-0x40, %r10d
000000010000b899	cmpl	$0x80, %r10d
000000010000b8a0	jne	0x10000b6e8
000000010000b8a6	movl	%r8d, %r10d
000000010000b8a9	shll	$0x6, %r10d
000000010000b8ad	andl	$0x3f, %ebx
000000010000b8b0	orl	%r10d, %ebx
000000010000b8b3	andl	$0x7fe0, %r8d                   ## imm = 0x7FE0
000000010000b8ba	cmpl	$0x360, %r8d                    ## imm = 0x360
000000010000b8c1	je	0x10000b6e8
000000010000b8c7	cmpl	$0x10ffff, %r10d                ## imm = 0x10FFFF
000000010000b8ce	ja	0x10000b6e8
000000010000b8d4	cmpl	%edx, %ebx
000000010000b8d6	jb	0x10000b6e8
000000010000b8dc	addq	%r9, %rcx
000000010000b8df	incq	%rcx
000000010000b8e2	cmpq	%rsi, %rcx
000000010000b8e5	jb	0x10000b7ac
000000010000b8eb	jmp	0x10000b6cb
000000010000b8f0	movdqu	0x38(%rax), %xmm0
000000010000b8f5	movdqa	%xmm0, -0x130(%rbp)
000000010000b8fd	xorl	%edx, %edx
000000010000b8ff	cmpl	$0x13, %ecx
000000010000b902	sete	%dl
000000010000b905	pxor	%xmm0, %xmm0
000000010000b909	movdqa	%xmm0, -0x120(%rbp)
000000010000b911	movq	$0x0, -0x110(%rbp)
000000010000b91c	movl	%edx, -0x108(%rbp)
000000010000b922	leaq	0x6c68(%rip), %rdx              ## literal pool for: "set"
000000010000b929	leaq	0x6c65(%rip), %rcx              ## literal pool for: "map"
000000010000b930	cmoveq	%rdx, %rcx
000000010000b934	cmpq	%rsi, %r15
000000010000b937	jae	0x10000b970
000000010000b939	movq	(%rdi), %rdx
000000010000b93c	movabsq	$0x100002600, %r8               ## imm = 0x100002600
000000010000b946	nopw	%cs:(%rax,%rax)
000000010000b950	movzbl	(%rdx,%r15), %r9d
000000010000b955	cmpq	$0x20, %r9
000000010000b959	ja	0x10000b970
000000010000b95b	btq	%r9, %r8
000000010000b95f	jae	0x10000b970
000000010000b961	incq	%r15
000000010000b964	movq	%r15, 0x10(%rdi)
000000010000b968	cmpq	%r15, %rsi
000000010000b96b	jne	0x10000b950
000000010000b96d	movq	%rsi, %r15
000000010000b970	subq	%r15, %rsi
000000010000b973	xorl	%r14d, %r14d
000000010000b976	cmpq	$0x3, %rsi
000000010000b97a	jb	0x10000b6e8
000000010000b980	movq	(%rdi), %rdx
000000010000b983	movzwl	(%rdx,%r15), %esi
000000010000b988	xorw	(%rcx), %si
000000010000b98b	movzbl	0x2(%rdx,%r15), %edx
000000010000b991	xorb	0x2(%rcx), %dl
000000010000b994	movzbl	%dl, %ecx
000000010000b997	orw	%si, %cx
000000010000b99a	jne	0x10000b6e8
000000010000b9a0	movq	%rbx, %r12
000000010000b9a3	movq	%rax, %rbx
000000010000b9a6	addq	$0x3, %r15
000000010000b9aa	movq	%r15, 0x10(%rdi)
000000010000b9ae	leaq	0x6be4(%rip), %rsi              ## literal pool for: "{"
000000010000b9b5	leaq	0x6bdf(%rip), %rdx              ## literal pool for: "}"
000000010000b9bc	leaq	_tp_kv_item(%rip), %rcx
000000010000b9c3	leaq	-0x130(%rbp), %r8
000000010000b9ca	callq	_tp_list_of
000000010000b9cf	testl	%eax, %eax
000000010000b9d1	je	0x10000c55d
000000010000b9d7	cmpq	$0x0, -0x118(%rbp)
000000010000b9df	je	0x10000c81a
000000010000b9e5	leaq	_fwp_empty_map(%rip), %rax
000000010000b9ec	xorl	%r14d, %r14d
000000010000b9ef	movq	-0x120(%rbp), %rcx
000000010000b9f6	movq	(%rcx,%r14,8), %rdi
000000010000b9fa	movq	0x8(%rcx,%r14,8), %rsi
000000010000b9ff	movq	0x38(%rbx), %rcx
000000010000ba03	movq	%rax, %rdx
000000010000ba06	callq	_fwp_p_map_insert
000000010000ba0b	addq	$0x2, %r14
000000010000ba0f	cmpq	-0x118(%rbp), %r14
000000010000ba16	jb	0x10000b9ef
000000010000ba18	jmp	0x10000c821
000000010000ba1d	pxor	%xmm0, %xmm0
000000010000ba21	movdqu	%xmm0, -0x118(%rbp)
000000010000ba29	movdqu	%xmm0, -0x128(%rbp)
000000010000ba31	movq	$0x0, -0x108(%rbp)
000000010000ba3c	movq	0x38(%rax), %rdx
000000010000ba40	movq	%rdx, -0x130(%rbp)
000000010000ba47	cmpl	$0x11, %ecx
000000010000ba4a	jne	0x10000bab5
000000010000ba4c	cmpq	%rsi, %r15
000000010000ba4f	jae	0x10000ba80
000000010000ba51	movq	(%rdi), %rcx
000000010000ba54	movabsq	$0x100002600, %rdx              ## imm = 0x100002600
000000010000ba5e	nop
000000010000ba60	movzbl	(%rcx,%r15), %r8d
000000010000ba65	cmpq	$0x20, %r8
000000010000ba69	ja	0x10000ba80
000000010000ba6b	btq	%r8, %rdx
000000010000ba6f	jae	0x10000ba80
000000010000ba71	incq	%r15
000000010000ba74	movq	%r15, 0x10(%rdi)
000000010000ba78	cmpq	%r15, %rsi
000000010000ba7b	jne	0x10000ba60
000000010000ba7d	movq	%rsi, %r15
000000010000ba80	subq	%r15, %rsi
000000010000ba83	xorl	%r14d, %r14d
000000010000ba86	cmpq	$0x5, %rsi
000000010000ba8a	jb	0x10000b6e8
000000010000ba90	movq	(%rdi), %rcx
000000010000ba93	movl	$0x61727261, %edx               ## imm = 0x61727261
000000010000ba98	xorl	(%rcx,%r15), %edx
000000010000ba9c	movzbl	0x4(%rcx,%r15), %ecx
000000010000baa2	xorl	$0x79, %ecx
000000010000baa5	orl	%edx, %ecx
000000010000baa7	jne	0x10000b6e8
000000010000baad	addq	$0x5, %r15
000000010000bab1	movq	%r15, 0x10(%rdi)
000000010000bab5	movq	%rax, -0x1d0(%rbp)
000000010000babc	leaq	0x6abe(%rip), %rsi              ## literal pool for: "["
000000010000bac3	leaq	0x6ab9(%rip), %rdx              ## literal pool for: "]"
000000010000baca	leaq	_tp_elem_item(%rip), %rcx
000000010000bad1	leaq	-0x130(%rbp), %r8
000000010000bad8	callq	_tp_list_of
000000010000badd	movq	-0x120(%rbp), %r14
000000010000bae4	testl	%eax, %eax
000000010000bae6	je	0x10000bfc2
000000010000baec	movq	%rbx, -0x1e8(%rbp)
000000010000baf3	movq	-0x118(%rbp), %rbx
000000010000bafa	testq	%rbx, %rbx
000000010000bafd	je	0x10000c120
000000010000bb03	xorl	%r15d, %r15d
000000010000bb06	leaq	-0x1b0(%rbp), %r13
000000010000bb0d	nopl	(%rax)
000000010000bb10	movq	-0x8(%r14,%rbx,8), %r12
000000010000bb15	movq	%r12, -0x1b0(%rbp)
000000010000bb1c	movq	%r15, -0x1a8(%rbp)
000000010000bb23	movl	$0x18, %edi
000000010000bb28	callq	_fwp_alloc_init
000000010000bb2d	movabsq	$0x200000001, %rcx              ## imm = 0x200000001
000000010000bb37	movq	%rcx, (%rax)
000000010000bb3a	movq	%r12, 0x8(%rax)
000000010000bb3e	movq	%r15, 0x10(%rax)
000000010000bb42	movq	%rax, %r15
000000010000bb45	decq	%rbx
000000010000bb48	jne	0x10000bb10
000000010000bb4a	jmp	0x10000c122
000000010000bb4f	movq	%rbx, %r15
000000010000bb52	movq	%rax, %rbx
000000010000bb55	leaq	-0x130(%rbp), %rsi
000000010000bb5c	movl	$0x80, %edx
000000010000bb61	callq	_tp_token
000000010000bb66	xorl	%r14d, %r14d
000000010000bb69	cmpq	$0x7f, %rax
000000010000bb6d	ja	0x10000b6e8
000000010000bb73	movl	-0x130(%rbp), %edx
000000010000bb79	cmpl	$0x666e69, %edx                 ## imm = 0x666E69
000000010000bb7f	jne	0x10000bf8c
000000010000bb85	movsd	0x58d3(%rip), %xmm0
000000010000bb8d	movq	%rbx, %rcx
000000010000bb90	jmp	0x10000c576
000000010000bb95	testl	%edx, %edx
000000010000bb97	jne	0x10000b6b9
000000010000bb9d	movq	0x748c(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000bba4	movq	(%rax), %rax
000000010000bba7	cmpq	-0x30(%rbp), %rax
000000010000bbab	jne	0x10000cf0c
000000010000bbb1	movq	%rbx, %rsi
000000010000bbb4	addq	$0x1d8, %rsp                    ## imm = 0x1D8
000000010000bbbb	popq	%rbx
000000010000bbbc	popq	%r12
000000010000bbbe	popq	%r13
000000010000bbc0	popq	%r14
000000010000bbc2	popq	%r15
000000010000bbc4	popq	%rbp
000000010000bbc5	jmp	_tp_quoted
000000010000bbca	pxor	%xmm0, %xmm0
000000010000bbce	movdqa	%xmm0, -0x110(%rbp)
000000010000bbd6	movdqa	%xmm0, -0x120(%rbp)
000000010000bbde	movdqa	%xmm0, -0x130(%rbp)
000000010000bbe6	cmpq	%rsi, %r15
000000010000bbe9	jae	0x10000bc20
000000010000bbeb	movq	(%rdi), %rax
000000010000bbee	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000bbf8	nopl	(%rax,%rax)
000000010000bc00	movzbl	(%rax,%r15), %edx
000000010000bc05	cmpq	$0x20, %rdx
000000010000bc09	ja	0x10000bc20
000000010000bc0b	btq	%rdx, %rcx
000000010000bc0f	jae	0x10000bc20
000000010000bc11	incq	%r15
000000010000bc14	movq	%r15, 0x10(%rdi)
000000010000bc18	cmpq	%r15, %rsi
000000010000bc1b	jne	0x10000bc00
000000010000bc1d	movq	%rsi, %r15
000000010000bc20	subq	%r15, %rsi
000000010000bc23	xorl	%r14d, %r14d
000000010000bc26	cmpq	$0x5, %rsi
000000010000bc2a	jb	0x10000bc49
000000010000bc2c	movq	(%rdi), %rax
000000010000bc2f	movl	$0x65747962, %ecx               ## imm = 0x65747962
000000010000bc34	xorl	(%rax,%r15), %ecx
000000010000bc38	movzbl	0x4(%rax,%r15), %eax
000000010000bc3e	xorl	$0x73, %eax
000000010000bc41	orl	%ecx, %eax
000000010000bc43	je	0x10000c4aa
000000010000bc49	xorl	%edi, %edi
000000010000bc4b	callq	_fwp_mem_free
000000010000bc50	jmp	0x10000b6e8
000000010000bc55	movq	%rbx, %r15
000000010000bc58	movq	%rax, %rbx
000000010000bc5b	leaq	-0x130(%rbp), %rsi
000000010000bc62	movl	$0x100, %edx                    ## imm = 0x100
000000010000bc67	callq	_tp_token
000000010000bc6c	xorl	%r14d, %r14d
000000010000bc6f	cmpq	$0x2, %rax
000000010000bc73	jb	0x10000b6e8
000000010000bc79	cmpb	$0x30, -0x130(%rbp)
000000010000bc80	jne	0x10000b6e8
000000010000bc86	cmpb	$0x74, -0x12f(%rbp)
000000010000bc8d	jne	0x10000b6e8
000000010000bc93	leaq	-0x2(%rax), %rcx
000000010000bc97	movslq	0x48(%rbx), %rdx
000000010000bc9b	cmpq	%rdx, %rcx
000000010000bc9e	ja	0x10000b6e8
000000010000bca4	cmpq	$0x3, %rax
000000010000bca8	jb	0x10000c696
000000010000bcae	movl	$0x2, %edx
000000010000bcb3	xorl	%ecx, %ecx
000000010000bcb5	movq	%r15, %rdi
000000010000bcb8	jmp	0x10000befb
000000010000bcbd	leaq	-0x130(%rbp), %rsi
000000010000bcc4	movl	$0x10, %edx
000000010000bcc9	callq	_tp_token
000000010000bcce	movzwl	-0x130(%rbp), %eax
000000010000bcd5	movl	%eax, %ecx
000000010000bcd7	xorl	$0x312b, %ecx                   ## imm = 0x312B
000000010000bcdd	movzbl	-0x12e(%rbp), %edx
000000010000bce4	orw	%cx, %dx
000000010000bce7	sete	%cl
000000010000bcea	cmpw	$0x31, %ax
000000010000bcee	sete	%dl
000000010000bcf1	orb	%cl, %dl
000000010000bcf3	movl	$0x1, %r14d
000000010000bcf9	jne	0x10000bd26
000000010000bcfb	xorl	%r14d, %r14d
000000010000bcfe	cmpw	$0x30, %ax
000000010000bd02	je	0x10000bd26
000000010000bd04	movl	$0x312d, %eax                   ## imm = 0x312D
000000010000bd09	xorl	-0x130(%rbp), %eax
000000010000bd0f	movzbl	-0x12e(%rbp), %ecx
000000010000bd16	orw	%ax, %cx
000000010000bd19	jne	0x10000b6e8
000000010000bd1f	movq	$-0x1, %r14
000000010000bd26	movq	%r14, (%rbx)
000000010000bd29	jmp	0x10000b6e2
000000010000bd2e	movq	0x8(%rax), %r13
000000010000bd32	testq	%r13, %r13
000000010000bd35	movq	%rbx, -0x1e8(%rbp)
000000010000bd3c	je	0x10000bfd2
000000010000bd42	movq	%rsi, %rbx
000000010000bd45	movq	%rdi, -0x1c8(%rbp)
000000010000bd4c	movq	%rax, -0x1d0(%rbp)
000000010000bd53	leaq	0x6843(%rip), %rsi              ## literal pool for: "Duration"
000000010000bd5a	movq	%r13, %rdi
000000010000bd5d	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000bd62	testl	%eax, %eax
000000010000bd64	je	0x10000c34e
000000010000bd6a	movq	-0x1d0(%rbp), %rax
000000010000bd71	movl	0x10(%rax), %r9d
000000010000bd75	cmpq	%rbx, %r15
000000010000bd78	movq	-0x1c8(%rbp), %rdx
000000010000bd7f	movq	%r9, -0x1d8(%rbp)
000000010000bd86	jae	0x10000bdb8
000000010000bd88	movq	%rbx, %rcx
000000010000bd8b	movq	(%rdx), %rsi
000000010000bd8e	movabsq	$0x100002600, %rdi              ## imm = 0x100002600
000000010000bd98	movzbl	(%rsi,%r15), %r8d
000000010000bd9d	cmpq	$0x20, %r8
000000010000bda1	ja	0x10000bdb8
000000010000bda3	btq	%r8, %rdi
000000010000bda7	jae	0x10000bdb8
000000010000bda9	incq	%r15
000000010000bdac	movq	%r15, 0x10(%rdx)
000000010000bdb0	cmpq	%r15, %rcx
000000010000bdb3	jne	0x10000bd98
000000010000bdb5	movq	%rcx, %r15
000000010000bdb8	addq	$0x10, %rax
000000010000bdbc	movq	%rax, -0x1c0(%rbp)
000000010000bdc3	movq	%r13, %rdi
000000010000bdc6	callq	0x100011286                     ## symbol stub for: _strlen
000000010000bdcb	subq	%r15, %rbx
000000010000bdce	cmpq	%rax, %rbx
000000010000bdd1	jb	0x10000bdf6
000000010000bdd3	movq	%rax, %r12
000000010000bdd6	movq	-0x1c8(%rbp), %rax
000000010000bddd	movq	(%rax), %rdi
000000010000bde0	addq	%r15, %rdi
000000010000bde3	movq	%r13, %rsi
000000010000bde6	movq	%r12, %rdx
000000010000bde9	callq	0x100011202                     ## symbol stub for: _memcmp
000000010000bdee	testl	%eax, %eax
000000010000bdf0	je	0x10000ca08
000000010000bdf6	movq	-0x1d0(%rbp), %rax
000000010000bdfd	movq	-0x1c8(%rbp), %rdi
000000010000be04	movq	-0x1c0(%rbp), %r13
000000010000be0b	movq	-0x1d8(%rbp), %rcx
000000010000be12	movslq	%ecx, %rcx
000000010000be15	leaq	0x8(,%rcx,8), %rcx
000000010000be1d	leaq	_fwp_gc(%rip), %r12
000000010000be24	cmpq	$0x4000, %rcx                   ## imm = 0x4000
000000010000be2b	ja	0x10000c5a6
000000010000be31	leaq	0xf(%rcx), %rdx
000000010000be35	shrq	$0x4, %rdx
000000010000be39	movzbl	0xbe8(%rdx,%r12), %edx
000000010000be42	movl	0xb48(%r12,%rdx,4), %esi
000000010000be4a	subq	%rsi, _fwp_gc(%rip)
000000010000be51	js	0x10000c5a6
000000010000be57	leaq	(%rdx,%rdx,2), %rdx
000000010000be5b	leaq	(%r12,%rdx,8), %rdx
000000010000be5f	addq	$0x788, %rdx                    ## imm = 0x788
000000010000be66	movq	(%rdx), %r8
000000010000be69	testq	%r8, %r8
000000010000be6c	je	0x10000c592
000000010000be72	movq	%rdi, %r15
000000010000be75	movq	%rax, %rbx
000000010000be78	movq	(%r8), %rax
000000010000be7b	notq	%rax
000000010000be7e	movq	%rax, (%rdx)
000000010000be81	movq	%r8, -0x1e0(%rbp)
000000010000be88	movq	%r8, %rdi
000000010000be8b	jmp	0x10000c6c0
000000010000be90	movq	(%rdi), %r8
000000010000be93	cmpq	%rsi, %r15
000000010000be96	movq	%rdi, -0x1c8(%rbp)
000000010000be9d	movl	%edx, -0x1d8(%rbp)
000000010000bea3	movq	%rbx, -0x1e8(%rbp)
000000010000beaa	jae	0x10000bf25
000000010000beac	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000beb6	nopw	%cs:(%rax,%rax)
000000010000bec0	movzbl	(%r8,%r15), %r9d
000000010000bec5	cmpq	$0x20, %r9
000000010000bec9	ja	0x10000bf25
000000010000becb	btq	%r9, %rcx
000000010000becf	jae	0x10000bf25
000000010000bed1	incq	%r15
000000010000bed4	movq	%r15, 0x10(%rdi)
000000010000bed8	cmpq	%r15, %rsi
000000010000bedb	jne	0x10000bec0
000000010000bedd	movq	%rax, %rbx
000000010000bee0	movq	%rsi, %r15
000000010000bee3	jmp	0x10000c19e
000000010000bee8	leaq	(%rcx,%rcx,2), %rcx
000000010000beec	decq	%rcx
000000010000beef	incq	%rdx
000000010000bef2	cmpq	%rdx, %rax
000000010000bef5	je	0x10000c6a0
000000010000befb	movzbl	-0x130(%rbp,%rdx), %esi
000000010000bf03	cmpl	$0x30, %esi
000000010000bf06	je	0x10000bf1f
000000010000bf08	cmpl	$0x2d, %esi
000000010000bf0b	je	0x10000bee8
000000010000bf0d	cmpl	$0x2b, %esi
000000010000bf10	jne	0x10000ce3c
000000010000bf16	leaq	(%rcx,%rcx,2), %rcx
000000010000bf1a	incq	%rcx
000000010000bf1d	jmp	0x10000beef
000000010000bf1f	leaq	(%rcx,%rcx,2), %rcx
000000010000bf23	jmp	0x10000beef
000000010000bf25	cmpq	%rsi, %r15
000000010000bf28	jae	0x10000c115
000000010000bf2e	movabsq	$0x4000000000003, %r9           ## imm = 0x4000000000003
000000010000bf38	movq	%r15, %rcx
000000010000bf3b	jmp	0x10000bf50
000000010000bf3d	nopl	(%rax)
000000010000bf40	incq	%rcx
000000010000bf43	movq	%rcx, 0x10(%rdi)
000000010000bf47	cmpq	%rcx, %rsi
000000010000bf4a	je	0x10000c19b
000000010000bf50	movzbl	(%r8,%rcx), %r10d
000000010000bf55	leal	-0x30(%r10), %r11d
000000010000bf59	cmpb	$0xa, %r11b
000000010000bf5d	jb	0x10000bf40
000000010000bf5f	movl	%r10d, %r11d
000000010000bf62	andb	$-0x21, %r11b
000000010000bf66	addb	$-0x41, %r11b
000000010000bf6a	cmpb	$0x1a, %r11b
000000010000bf6e	jb	0x10000bf40
000000010000bf70	movzbl	%r10b, %r10d
000000010000bf74	addl	$-0x2d, %r10d
000000010000bf78	cmpl	$0x32, %r10d
000000010000bf7c	ja	0x10000bf84
000000010000bf7e	btq	%r10, %r9
000000010000bf82	jb	0x10000bf40
000000010000bf84	movq	%rax, %rbx
000000010000bf87	jmp	0x10000c1a1
000000010000bf8c	movl	$0x666e692d, %ecx               ## imm = 0x666E692D
000000010000bf91	xorl	-0x130(%rbp), %ecx
000000010000bf97	movzbl	-0x12c(%rbp), %esi
000000010000bf9e	orl	%ecx, %esi
000000010000bfa0	movq	%rbx, %rcx
000000010000bfa3	je	0x10000c56e
000000010000bfa9	cmpl	$0x4e614e, %edx                 ## imm = 0x4E614E
000000010000bfaf	jne	0x10000c5c5
000000010000bfb5	movsd	0x54b3(%rip), %xmm0
000000010000bfbd	jmp	0x10000c576
000000010000bfc2	movq	%r14, %rdi
000000010000bfc5	callq	_fwp_mem_free
000000010000bfca	xorl	%r14d, %r14d
000000010000bfcd	jmp	0x10000b6e8
000000010000bfd2	movslq	0x10(%rax), %rcx
000000010000bfd6	testq	%rcx, %rcx
000000010000bfd9	je	0x10000c640
000000010000bfdf	leaq	0x10(%rax), %r13
000000010000bfe3	cmpl	$0x0, 0x48(%rax)
000000010000bfe7	je	0x10000be12
000000010000bfed	movq	%r13, -0x1c0(%rbp)
000000010000bff4	movq	%rax, %rbx
000000010000bff7	shlq	$0x3, %rcx
000000010000bffb	movq	%rdi, %r13
000000010000bffe	movq	%rcx, %rdi
000000010000c001	callq	_fwp_alloc
000000010000c006	movq	%rax, -0x1d8(%rbp)
000000010000c00d	leaq	0x65a3(%rip), %rsi              ## literal pool for: "("
000000010000c014	movq	%r13, %r12
000000010000c017	movq	%r13, %rdi
000000010000c01a	callq	_tp_eat
000000010000c01f	testl	%eax, %eax
000000010000c021	je	0x10000b6e8
000000010000c027	movq	-0x1c0(%rbp), %rax
000000010000c02e	cmpl	$0x0, (%rax)
000000010000c031	movq	%r12, %rdi
000000010000c034	jle	0x10000c0e1
000000010000c03a	xorl	%r13d, %r13d
000000010000c03d	movabsq	$0x100002600, %r15              ## imm = 0x100002600
000000010000c047	testq	%r13, %r13
000000010000c04a	je	0x10000c0a0
000000010000c04c	movq	0x8(%rdi), %rcx
000000010000c050	movq	0x10(%rdi), %rax
000000010000c054	cmpq	%rcx, %rax
000000010000c057	jae	0x10000c080
000000010000c059	movq	(%rdi), %rdx
000000010000c05c	movzbl	(%rdx,%rax), %esi
000000010000c060	cmpq	$0x20, %rsi
000000010000c064	ja	0x10000c080
000000010000c066	btq	%rsi, %r15
000000010000c06a	jae	0x10000c080
000000010000c06c	incq	%rax
000000010000c06f	movq	%rax, 0x10(%rdi)
000000010000c073	xorl	%r14d, %r14d
000000010000c076	cmpq	%rax, %rcx
000000010000c079	jne	0x10000c05c
000000010000c07b	jmp	0x10000b6e8
000000010000c080	xorl	%r14d, %r14d
000000010000c083	cmpq	%rax, %rcx
000000010000c086	je	0x10000b6e8
000000010000c08c	movq	(%rdi), %rcx
000000010000c08f	cmpb	$0x2c, (%rcx,%rax)
000000010000c093	jne	0x10000b6e8
000000010000c099	incq	%rax
000000010000c09c	movq	%rax, 0x10(%rdi)
000000010000c0a0	movq	0x20(%rbx), %rax
000000010000c0a4	movq	(%rax,%r13,8), %rsi
000000010000c0a8	movq	-0x1d8(%rbp), %rax
000000010000c0af	leaq	(%rax,%r13,8), %rcx
000000010000c0b3	xorl	%r14d, %r14d
000000010000c0b6	movq	%r12, %rdi
000000010000c0b9	xorl	%edx, %edx
000000010000c0bb	callq	_tp_value
000000010000c0c0	testl	%eax, %eax
000000010000c0c2	je	0x10000b6e8
000000010000c0c8	movq	%r12, %rdi
000000010000c0cb	incq	%r13
000000010000c0ce	movq	-0x1c0(%rbp), %rax
000000010000c0d5	movslq	(%rax), %rax
000000010000c0d8	cmpq	%rax, %r13
000000010000c0db	jl	0x10000c047
000000010000c0e1	leaq	0x64d1(%rip), %rsi              ## literal pool for: ")"
000000010000c0e8	callq	_tp_eat
000000010000c0ed	movl	$0x0, %r14d
000000010000c0f3	testl	%eax, %eax
000000010000c0f5	je	0x10000b6e8
000000010000c0fb	movq	-0x1c0(%rbp), %rax
000000010000c102	movl	(%rax), %edi
000000010000c104	movq	-0x1d8(%rbp), %rsi
000000010000c10b	callq	_fwp_record
000000010000c110	jmp	0x10000cae2
000000010000c115	movq	%rax, %rbx
000000010000c118	movq	%r15, %rcx
000000010000c11b	jmp	0x10000c1a1
000000010000c120	xorl	%eax, %eax
000000010000c122	movq	%rax, %rbx
000000010000c125	movq	-0x120(%rbp), %rdi
000000010000c12c	callq	_fwp_mem_free
000000010000c131	movq	-0x1d0(%rbp), %rax
000000010000c138	cmpl	$0x11, (%rax)
000000010000c13b	jne	0x10000c193
000000010000c13d	movq	0x38(%rax), %r14
000000010000c141	testq	%rbx, %rbx
000000010000c144	je	0x10000c67a
000000010000c14a	movq	%rbx, %rax
000000010000c14d	xorl	%edi, %edi
000000010000c14f	nop
000000010000c150	incq	%rdi
000000010000c153	movq	0x10(%rax), %rax
000000010000c157	testq	%rax, %rax
000000010000c15a	jne	0x10000c150
000000010000c15c	movq	%r14, %rsi
000000010000c15f	callq	_fwp_array_new_packed
000000010000c164	movq	%rax, %r15
000000010000c167	xorl	%r12d, %r12d
000000010000c16a	movq	%rbx, %r13
000000010000c16d	nopl	(%rax)
000000010000c170	movq	0x8(%r13), %rdx
000000010000c174	movq	%r15, %rdi
000000010000c177	movq	%r12, %rsi
000000010000c17a	movq	%r14, %rcx
000000010000c17d	callq	_fwp_array_store
000000010000c182	incq	%r12
000000010000c185	movq	0x10(%r13), %r13
000000010000c189	testq	%r13, %r13
000000010000c18c	jne	0x10000c170
000000010000c18e	jmp	0x10000c687
000000010000c193	movq	%rbx, %r15
000000010000c196	jmp	0x10000c687
000000010000c19b	movq	%rax, %rbx
000000010000c19e	movq	%rsi, %rcx
000000010000c1a1	subq	%r15, %rcx
000000010000c1a4	cmpq	$0xff, %rcx
000000010000c1ab	movl	$0xff, %r14d
000000010000c1b1	cmovbq	%rcx, %r14
000000010000c1b5	addq	%r15, %r8
000000010000c1b8	leaq	-0x130(%rbp), %rdi
000000010000c1bf	movl	$0x100, %ecx                    ## imm = 0x100
000000010000c1c4	movq	%r8, %rsi
000000010000c1c7	movq	%r14, %rdx
000000010000c1ca	callq	0x10001115a                     ## symbol stub for: ___memcpy_chk
000000010000c1cf	movb	$0x0, -0x130(%rbp,%r14)
000000010000c1d8	movslq	0x10(%rbx), %r12
000000010000c1dc	testq	%r12, %r12
000000010000c1df	movq	%rbx, -0x1d0(%rbp)
000000010000c1e6	jle	0x10000c21d
000000010000c1e8	movq	0x18(%rbx), %r13
000000010000c1ec	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c1f1	xorl	%r15d, %r15d
000000010000c1f4	leaq	-0x130(%rbp), %r14
000000010000c1fb	nopl	(%rax,%rax)
000000010000c200	movq	(%r13,%r15,8), %rdi
000000010000c205	movq	%r14, %rsi
000000010000c208	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000c20d	testl	%eax, %eax
000000010000c20f	cmovel	%r15d, %ebx
000000010000c213	incq	%r15
000000010000c216	cmpq	%r15, %r12
000000010000c219	jne	0x10000c200
000000010000c21b	jmp	0x10000c222
000000010000c21d	movl	$0xffffffff, %ebx               ## imm = 0xFFFFFFFF
000000010000c222	cmpl	$0x0, -0x1d8(%rbp)
000000010000c229	je	0x10000c2a6
000000010000c22b	testl	%ebx, %ebx
000000010000c22d	movq	-0x1c8(%rbp), %r13
000000010000c234	jns	0x10000c29d
000000010000c236	movq	-0x1d0(%rbp), %rax
000000010000c23d	movq	0x8(%rax), %rdi
000000010000c241	xorl	%r14d, %r14d
000000010000c244	testq	%rdi, %rdi
000000010000c247	je	0x10000b6e8
000000010000c24d	leaq	0x631b(%rip), %rsi              ## literal pool for: "Bool"
000000010000c254	movq	%rax, %r12
000000010000c257	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000c25c	testl	%eax, %eax
000000010000c25e	jne	0x10000b6e8
000000010000c264	movq	%r12, %rdx
000000010000c267	movl	-0x130(%rbp), %eax
000000010000c26d	movl	%eax, %esi
000000010000c26f	xorl	$0x65757274, %esi               ## imm = 0x65757274
000000010000c275	movzbl	-0x12c(%rbp), %edi
000000010000c27c	orl	%esi, %edi
000000010000c27e	movl	$0x1, %esi
000000010000c283	cmovel	%esi, %ebx
000000010000c286	xorl	$0x736c6166, %eax               ## imm = 0x736C6166
000000010000c28b	movzwl	-0x12c(%rbp), %esi
000000010000c292	xorl	$0x65, %esi
000000010000c295	orl	%eax, %esi
000000010000c297	jne	0x10000c2b4
000000010000c299	xorl	%ebx, %ebx
000000010000c29b	jmp	0x10000c2bc
000000010000c29d	movq	-0x1d0(%rbp), %rdx
000000010000c2a4	jmp	0x10000c2b4
000000010000c2a6	movq	-0x1d0(%rbp), %rdx
000000010000c2ad	movq	-0x1c8(%rbp), %r13
000000010000c2b4	testl	%ebx, %ebx
000000010000c2b6	js	0x10000ce3c
000000010000c2bc	movq	0x28(%rdx), %rax
000000010000c2c0	movl	%ebx, %esi
000000010000c2c2	movq	%rsi, -0x1d8(%rbp)
000000010000c2c9	movslq	(%rax,%rsi,4), %r15
000000010000c2cd	movl	%r15d, %r9d
000000010000c2d0	leaq	0x8(,%r15,8), %rdi
000000010000c2d8	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000c2df	movq	%r9, -0x1e0(%rbp)
000000010000c2e6	ja	0x10000c627
000000010000c2ec	leaq	0xf(%rdi), %rsi
000000010000c2f0	shrq	$0x4, %rsi
000000010000c2f4	leaq	_fwp_gc(%rip), %rax
000000010000c2fb	movzbl	0xbe8(%rsi,%rax), %r8d
000000010000c304	movl	0xb48(%rax,%r8,4), %esi
000000010000c30c	subq	%rsi, _fwp_gc(%rip)
000000010000c313	js	0x10000c627
000000010000c319	leaq	(%r8,%r8,2), %r8
000000010000c31d	leaq	(%rax,%r8,8), %rax
000000010000c321	addq	$0x788, %rax                    ## imm = 0x788
000000010000c327	movq	(%rax), %r8
000000010000c32a	testq	%r8, %r8
000000010000c32d	je	0x10000c613
000000010000c333	movq	%rdx, %r14
000000010000c336	movq	(%r8), %rcx
000000010000c339	notq	%rcx
000000010000c33c	movq	%rcx, (%rax)
000000010000c33f	movq	%r8, -0x1c0(%rbp)
000000010000c346	movq	%r8, %rdi
000000010000c349	jmp	0x10000c856
000000010000c34e	leaq	-0x130(%rbp), %rsi
000000010000c355	movl	$0x80, %edx
000000010000c35a	movq	-0x1c8(%rbp), %rdi
000000010000c361	callq	_tp_token
000000010000c366	movq	%rax, %r14
000000010000c369	addq	%rbp, %rax
000000010000c36c	addq	$-0x130, %rax                   ## imm = 0xFED0
000000010000c372	movq	%rax, -0x1d0(%rbp)
000000010000c379	xorl	%ebx, %ebx
000000010000c37b	jmp	0x10000c38a
000000010000c37d	incq	%rbx
000000010000c380	cmpq	$0x6, %rbx
000000010000c384	je	0x10000ce3c
000000010000c38a	movq	%rbx, %r12
000000010000c38d	shlq	$0x4, %r12
000000010000c391	leaq	_tp_value.units(%rip), %rax
000000010000c398	movq	(%r12,%rax), %r15
000000010000c39c	movq	%r15, %rdi
000000010000c39f	callq	0x100011286                     ## symbol stub for: _strlen
000000010000c3a4	movq	%r14, %r13
000000010000c3a7	subq	%rax, %r13
000000010000c3aa	jbe	0x10000c37d
000000010000c3ac	movq	-0x1d0(%rbp), %rdi
000000010000c3b3	subq	%rax, %rdi
000000010000c3b6	movq	%r15, %rsi
000000010000c3b9	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000c3be	testl	%eax, %eax
000000010000c3c0	jne	0x10000c37d
000000010000c3c2	leaq	_tp_value.units(%rip), %rax
000000010000c3c9	addq	%rax, %r12
000000010000c3cc	movl	$0x80, %ecx
000000010000c3d1	leaq	-0x1b0(%rbp), %rdi
000000010000c3d8	leaq	-0x130(%rbp), %rsi
000000010000c3df	movq	%r13, %rdx
000000010000c3e2	callq	0x10001115a                     ## symbol stub for: ___memcpy_chk
000000010000c3e7	movb	$0x0, -0x1b0(%rbp,%r13)
000000010000c3f0	movzbl	-0x1b0(%rbp), %esi
000000010000c3f7	leal	-0x2b(%rsi), %eax
000000010000c3fa	xorl	%ecx, %ecx
000000010000c3fc	testb	$-0x3, %al
000000010000c3fe	sete	%cl
000000010000c401	cmpq	%rcx, %r13
000000010000c404	je	0x10000c37d
000000010000c40a	jbe	0x10000c428
000000010000c40c	movzbl	-0x1b0(%rbp,%rcx), %edx
000000010000c414	addb	$-0x3a, %dl
000000010000c417	cmpb	$-0xa, %dl
000000010000c41a	jb	0x10000c37d
000000010000c420	incq	%rcx
000000010000c423	cmpq	%rcx, %r13
000000010000c426	jne	0x10000c40c
000000010000c428	xorl	%ecx, %ecx
000000010000c42a	testb	$-0x3, %al
000000010000c42c	sete	%cl
000000010000c42f	movzbl	-0x1b0(%rbp,%rcx), %r10d
000000010000c438	xorl	%r14d, %r14d
000000010000c43b	testb	%r10b, %r10b
000000010000c43e	je	0x10000ca44
000000010000c444	leaq	-0x1b0(%rbp), %rax
000000010000c44b	addq	%rax, %rcx
000000010000c44e	incq	%rcx
000000010000c451	xorl	%eax, %eax
000000010000c453	movl	$0xa, %edi
000000010000c458	movabsq	$-0x8000000000000000, %r9       ## imm = 0x8000000000000000
000000010000c462	xorl	%r8d, %r8d
000000010000c465	mulq	%rdi
000000010000c468	leaq	(%r8,%r8,4), %r8
000000010000c46c	leaq	(%rdx,%r8,2), %rdx
000000010000c470	movsbl	%r10b, %r8d
000000010000c474	addl	$-0x30, %r8d
000000010000c478	movslq	%r8d, %r10
000000010000c47b	movq	%r10, %r8
000000010000c47e	sarq	$0x3f, %r8
000000010000c482	addq	%r10, %rax
000000010000c485	adcq	%rdx, %r8
000000010000c488	cmpq	%rax, %r9
000000010000c48b	movl	$0x0, %edx
000000010000c490	sbbq	%r8, %rdx
000000010000c493	jl	0x10000ce3c
000000010000c499	movzbl	(%rcx), %r10d
000000010000c49d	incq	%rcx
000000010000c4a0	testb	%r10b, %r10b
000000010000c4a3	jne	0x10000c465
000000010000c4a5	jmp	0x10000ca49
000000010000c4aa	addq	$0x5, %r15
000000010000c4ae	movq	%r15, 0x10(%rdi)
000000010000c4b2	leaq	0x60c8(%rip), %rsi              ## literal pool for: "["
000000010000c4b9	leaq	0x60c3(%rip), %rdx              ## literal pool for: "]"
000000010000c4c0	leaq	_tp_byte_item(%rip), %rcx
000000010000c4c7	leaq	-0x130(%rbp), %r8
000000010000c4ce	callq	_tp_list_of
000000010000c4d3	testl	%eax, %eax
000000010000c4d5	je	0x10000c55d
000000010000c4db	movq	%rbx, %r12
000000010000c4de	pxor	%xmm0, %xmm0
000000010000c4e2	movdqa	%xmm0, -0x1b0(%rbp)
000000010000c4ea	movq	$0x0, -0x1a0(%rbp)
000000010000c4f5	cmpq	$0x0, -0x118(%rbp)
000000010000c4fd	je	0x10000c53c
000000010000c4ff	xorl	%ebx, %ebx
000000010000c501	leaq	-0x1b0(%rbp), %r14
000000010000c508	leaq	-0x1b8(%rbp), %r15
000000010000c50f	movq	-0x120(%rbp), %rax
000000010000c516	movzbl	(%rax,%rbx,8), %eax
000000010000c51a	movb	%al, -0x1b8(%rbp)
000000010000c520	movl	$0x1, %edx
000000010000c525	movq	%r14, %rdi
000000010000c528	movq	%r15, %rsi
000000010000c52b	callq	_buf_put
000000010000c530	incq	%rbx
000000010000c533	cmpq	-0x118(%rbp), %rbx
000000010000c53a	jb	0x10000c50f
000000010000c53c	movq	-0x120(%rbp), %rdi
000000010000c543	callq	_fwp_mem_free
000000010000c548	leaq	-0x1b0(%rbp), %rdi
000000010000c54f	callq	_buf_to_str
000000010000c554	movq	%rax, (%r12)
000000010000c558	jmp	0x10000b6e2
000000010000c55d	movq	-0x120(%rbp), %rdi
000000010000c564	callq	_fwp_mem_free
000000010000c569	jmp	0x10000b6e8
000000010000c56e	movsd	0x4ef2(%rip), %xmm0
000000010000c576	cmpl	$0xa, (%rcx)
000000010000c579	cvtsd2ss	%xmm0, %xmm1
000000010000c57d	movd	%xmm1, %ecx
000000010000c581	movq	%xmm0, %rax
000000010000c586	cmoveq	%rcx, %rax
000000010000c58a	movq	%rax, (%r15)
000000010000c58d	jmp	0x10000b6e2
000000010000c592	movq	0x8(%rdx), %r9
000000010000c596	movq	0x10(%rdx), %r8
000000010000c59a	subq	%r9, %r8
000000010000c59d	cmpq	%rsi, %r8
000000010000c5a0	jae	0x10000c6a8
000000010000c5a6	movq	%rdi, %r15
000000010000c5a9	movq	%rax, %rbx
000000010000c5ac	movq	%rcx, %rdi
000000010000c5af	movl	$0x2, %esi
000000010000c5b4	callq	_fwp_gc_alloc_slow
000000010000c5b9	movq	%rax, -0x1e0(%rbp)
000000010000c5c0	jmp	0x10000c6c5
000000010000c5c5	testq	%rax, %rax
000000010000c5c8	setne	%sil
000000010000c5cc	addb	$-0x2b, %dl
000000010000c5cf	testb	$-0x3, %dl
000000010000c5d2	sete	%dl
000000010000c5d5	andb	%sil, %dl
000000010000c5d8	movzbl	%dl, %esi
000000010000c5db	movb	$0x1, %r8b
000000010000c5de	movq	%rsi, %rdi
000000010000c5e1	cmpq	%rsi, %rax
000000010000c5e4	jbe	0x10000c839
000000010000c5ea	movzbl	-0x130(%rbp,%rdi), %edx
000000010000c5f2	leal	-0x30(%rdx), %r9d
000000010000c5f6	cmpb	$0x9, %r9b
000000010000c5fa	ja	0x10000caf1
000000010000c600	incq	%rdi
000000010000c603	cmpq	%rdi, %rax
000000010000c606	jne	0x10000c5ea
000000010000c608	movq	%rax, %rdi
000000010000c60b	movq	%rax, %rdx
000000010000c60e	jmp	0x10000ce47
000000010000c613	movq	0x8(%rax), %r10
000000010000c617	movq	0x10(%rax), %r8
000000010000c61b	subq	%r10, %r8
000000010000c61e	cmpq	%rsi, %r8
000000010000c621	jae	0x10000c841
000000010000c627	movq	%rdx, %r14
000000010000c62a	movl	$0x2, %esi
000000010000c62f	callq	_fwp_gc_alloc_slow
000000010000c634	movq	%rax, -0x1c0(%rbp)
000000010000c63b	jmp	0x10000c85b
000000010000c640	leaq	0x5f70(%rip), %rsi              ## literal pool for: "("
000000010000c647	movq	%rdi, %r15
000000010000c64a	callq	_tp_eat
000000010000c64f	testl	%eax, %eax
000000010000c651	je	0x10000b6e8
000000010000c657	leaq	0x5f5b(%rip), %rsi              ## literal pool for: ")"
000000010000c65e	movq	%r15, %rdi
000000010000c661	callq	_tp_eat
000000010000c666	testl	%eax, %eax
000000010000c668	je	0x10000b6e8
000000010000c66e	movq	$0x0, (%rbx)
000000010000c675	jmp	0x10000b6e2
000000010000c67a	xorl	%edi, %edi
000000010000c67c	movq	%r14, %rsi
000000010000c67f	callq	_fwp_array_new_packed
000000010000c684	movq	%rax, %r15
000000010000c687	movq	-0x1e8(%rbp), %rax
000000010000c68e	movq	%r15, (%rax)
000000010000c691	jmp	0x10000b6e2
000000010000c696	xorl	%ecx, %ecx
000000010000c698	movq	%rcx, (%r15)
000000010000c69b	jmp	0x10000b6e2
000000010000c6a0	movq	%rcx, (%rdi)
000000010000c6a3	jmp	0x10000b6e2
000000010000c6a8	movq	%rdi, %r15
000000010000c6ab	movq	%rax, %rbx
000000010000c6ae	leaq	(%r9,%rsi), %rax
000000010000c6b2	movq	%rax, 0x8(%rdx)
000000010000c6b6	movq	%r9, -0x1e0(%rbp)
000000010000c6bd	movq	%r9, %rdi
000000010000c6c0	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000c6c5	movslq	(%r13), %rax
000000010000c6c9	leaq	0x1(%rax), %rsi
000000010000c6cd	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000c6d4	ja	0x10000c72b
000000010000c6d6	addq	$0x10, %rax
000000010000c6da	shrq	$0x4, %rax
000000010000c6de	movzbl	0xbe8(%rax,%r12), %ecx
000000010000c6e7	movl	0xb48(%r12,%rcx,4), %eax
000000010000c6ef	subq	%rax, _fwp_gc(%rip)
000000010000c6f6	js	0x10000c72b
000000010000c6f8	leaq	(%rcx,%rcx,2), %rcx
000000010000c6fc	leaq	(%r12,%rcx,8), %rcx
000000010000c700	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000c707	movq	(%rcx), %r12
000000010000c70a	testq	%r12, %r12
000000010000c70d	je	0x10000c71b
000000010000c70f	movq	(%r12), %rax
000000010000c713	notq	%rax
000000010000c716	movq	%rax, (%rcx)
000000010000c719	jmp	0x10000c744
000000010000c71b	movq	0x8(%rcx), %r12
000000010000c71f	movq	0x10(%rcx), %rdx
000000010000c723	subq	%r12, %rdx
000000010000c726	cmpq	%rax, %rdx
000000010000c729	jae	0x10000c73d
000000010000c72b	movq	%rsi, %rdi
000000010000c72e	movl	$0x1, %esi
000000010000c733	callq	_fwp_gc_alloc_slow
000000010000c738	movq	%rax, %r12
000000010000c73b	jmp	0x10000c74c
000000010000c73d	addq	%r12, %rax
000000010000c740	movq	%rax, 0x8(%rcx)
000000010000c744	movq	%r12, %rdi
000000010000c747	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000c74c	movslq	(%r13), %rsi
000000010000c750	incq	%rsi
000000010000c753	movq	%r12, %rdi
000000010000c756	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000c75b	movq	0x8(%r15), %rcx
000000010000c75f	movq	0x10(%r15), %rax
000000010000c763	cmpq	%rcx, %rax
000000010000c766	jae	0x10000c796
000000010000c768	movq	(%r15), %rdx
000000010000c76b	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000c775	movzbl	(%rdx,%rax), %edi
000000010000c779	cmpq	$0x20, %rdi
000000010000c77d	ja	0x10000c796
000000010000c77f	btq	%rdi, %rsi
000000010000c783	jae	0x10000c796
000000010000c785	incq	%rax
000000010000c788	movq	%rax, 0x10(%r15)
000000010000c78c	cmpq	%rax, %rcx
000000010000c78f	jne	0x10000c775
000000010000c791	jmp	0x10000b6e8
000000010000c796	cmpq	%rax, %rcx
000000010000c799	je	0x10000b6e8
000000010000c79f	movq	%r13, -0x1c0(%rbp)
000000010000c7a6	movq	(%r15), %rcx
000000010000c7a9	cmpb	$0x7b, (%rcx,%rax)
000000010000c7ad	jne	0x10000b6e8
000000010000c7b3	incq	%rax
000000010000c7b6	movq	%rax, 0x10(%r15)
000000010000c7ba	leaq	0x5dda(%rip), %rsi              ## literal pool for: "}"
000000010000c7c1	movq	%r15, -0x1c8(%rbp)
000000010000c7c8	movq	%r15, %rdi
000000010000c7cb	callq	_tp_eat
000000010000c7d0	testl	%eax, %eax
000000010000c7d2	je	0x10000cbd2
000000010000c7d8	movq	-0x1c0(%rbp), %rax
000000010000c7df	movslq	(%rax), %rdi
000000010000c7e2	testq	%rdi, %rdi
000000010000c7e5	movq	-0x1e8(%rbp), %rbx
000000010000c7ec	movq	-0x1e0(%rbp), %rsi
000000010000c7f3	jle	0x10000c80d
000000010000c7f5	xorl	%r14d, %r14d
000000010000c7f8	xorl	%eax, %eax
000000010000c7fa	cmpb	$0x0, (%r12,%rax)
000000010000c7ff	je	0x10000b6e8
000000010000c805	incq	%rax
000000010000c808	cmpq	%rax, %rdi
000000010000c80b	jne	0x10000c7fa
000000010000c80d	callq	_fwp_record
000000010000c812	movq	%rax, (%rbx)
000000010000c815	jmp	0x10000b6e2
000000010000c81a	leaq	_fwp_empty_map(%rip), %rax
000000010000c821	movq	-0x120(%rbp), %rdi
000000010000c828	movq	%rax, %rbx
000000010000c82b	callq	_fwp_mem_free
000000010000c830	movq	%rbx, (%r12)
000000010000c834	jmp	0x10000b6e2
000000010000c839	movq	%rsi, %rdx
000000010000c83c	jmp	0x10000ce47
000000010000c841	movq	%rdx, %r14
000000010000c844	leaq	(%r10,%rsi), %rcx
000000010000c848	movq	%rcx, 0x8(%rax)
000000010000c84c	movq	%r10, -0x1c0(%rbp)
000000010000c853	movq	%r10, %rdi
000000010000c856	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000c85b	movq	%r15, -0x1f0(%rbp)
000000010000c862	testl	%r15d, %r15d
000000010000c865	jle	0x10000c9c0
000000010000c86b	movq	%r14, %rax
000000010000c86e	xorl	%r15d, %r15d
000000010000c871	movabsq	$0x100002600, %r12              ## imm = 0x100002600
000000010000c87b	movq	0x30(%rax), %rcx
000000010000c87f	movq	-0x1d8(%rbp), %rdx
000000010000c886	movq	(%rcx,%rdx,8), %rcx
000000010000c88a	movq	(%rcx,%r15,8), %rsi
000000010000c88e	movq	0x8(%r13), %rdi
000000010000c892	movq	0x10(%r13), %rdx
000000010000c896	cmpq	%rdi, %rdx
000000010000c899	jae	0x10000c8c0
000000010000c89b	movq	(%r13), %rcx
000000010000c89f	nop
000000010000c8a0	movzbl	(%rcx,%rdx), %r8d
000000010000c8a5	cmpq	$0x20, %r8
000000010000c8a9	ja	0x10000c8c0
000000010000c8ab	btq	%r8, %r12
000000010000c8af	jae	0x10000c8c0
000000010000c8b1	incq	%rdx
000000010000c8b4	movq	%rdx, 0x10(%r13)
000000010000c8b8	cmpq	%rdx, %rdi
000000010000c8bb	jne	0x10000c8a0
000000010000c8bd	movq	%rdi, %rdx
000000010000c8c0	cmpl	$0x10, (%rsi)
000000010000c8c3	jne	0x10000c8d0
000000010000c8c5	cmpq	$0x0, 0x8(%rsi)
000000010000c8ca	je	0x10000c982
000000010000c8d0	xorl	%r8d, %r8d
000000010000c8d3	movq	-0x1c0(%rbp), %rax
000000010000c8da	leaq	(%rax,%r15,8), %rcx
000000010000c8de	cmpq	%rdi, %rdx
000000010000c8e1	jae	0x10000c8f5
000000010000c8e3	movq	(%r13), %rax
000000010000c8e7	cmpb	$0x28, (%rax,%rdx)
000000010000c8eb	setne	%al
000000010000c8ee	orb	%r8b, %al
000000010000c8f1	testb	$0x1, %al
000000010000c8f3	je	0x10000c926
000000010000c8f5	xorl	%r14d, %r14d
000000010000c8f8	movq	%r13, %rdi
000000010000c8fb	xorl	%edx, %edx
000000010000c8fd	callq	_tp_value
000000010000c902	testl	%eax, %eax
000000010000c904	movq	-0x1d0(%rbp), %rax
000000010000c90b	je	0x10000b6e8
000000010000c911	incq	%r15
000000010000c914	cmpq	-0x1e0(%rbp), %r15
000000010000c91b	jne	0x10000c87b
000000010000c921	jmp	0x10000c9c0
000000010000c926	incq	%rdx
000000010000c929	movq	%rdx, 0x10(%r13)
000000010000c92d	xorl	%r14d, %r14d
000000010000c930	movq	%r13, %rdi
000000010000c933	xorl	%edx, %edx
000000010000c935	callq	_tp_value
000000010000c93a	testl	%eax, %eax
000000010000c93c	je	0x10000b6e8
000000010000c942	movq	-0x1c8(%rbp), %r13
000000010000c949	movq	0x8(%r13), %rdx
000000010000c94d	movq	0x10(%r13), %rcx
000000010000c951	cmpq	%rdx, %rcx
000000010000c954	movq	-0x1d0(%rbp), %rax
000000010000c95b	jae	0x10000c995
000000010000c95d	movq	(%r13), %rsi
000000010000c961	movzbl	(%rsi,%rcx), %edi
000000010000c965	cmpq	$0x20, %rdi
000000010000c969	ja	0x10000c995
000000010000c96b	btq	%rdi, %r12
000000010000c96f	jae	0x10000c995
000000010000c971	incq	%rcx
000000010000c974	movq	%rcx, 0x10(%r13)
000000010000c978	cmpq	%rcx, %rdx
000000010000c97b	jne	0x10000c961
000000010000c97d	jmp	0x10000b6e8
000000010000c982	cmpl	$0x0, 0x10(%rsi)
000000010000c986	je	0x10000c9b8
000000010000c988	cmpl	$0x0, 0x48(%rsi)
000000010000c98c	setne	%r8b
000000010000c990	jmp	0x10000c8d3
000000010000c995	cmpq	%rcx, %rdx
000000010000c998	je	0x10000b6e8
000000010000c99e	movq	(%r13), %rdx
000000010000c9a2	cmpb	$0x29, (%rdx,%rcx)
000000010000c9a6	jne	0x10000b6e8
000000010000c9ac	incq	%rcx
000000010000c9af	movq	%rcx, 0x10(%r13)
000000010000c9b3	jmp	0x10000c911
000000010000c9b8	movb	$0x1, %r8b
000000010000c9bb	jmp	0x10000c8d3
000000010000c9c0	movq	-0x1f0(%rbp), %r15
000000010000c9c7	testl	%r15d, %r15d
000000010000c9ca	movq	-0x1d8(%rbp), %rdi
000000010000c9d1	je	0x10000cbc3
000000010000c9d7	movq	-0x1e0(%rbp), %r14
000000010000c9de	leaq	0x8(,%r14,8), %rdi
000000010000c9e6	callq	_fwp_alloc_init
000000010000c9eb	movq	%rax, %rdi
000000010000c9ee	movl	%ebx, (%rax)
000000010000c9f0	movl	%r15d, 0x4(%rax)
000000010000c9f4	cmpl	$0x7, %r15d
000000010000c9f8	ja	0x10000ca22
000000010000c9fa	xorl	%eax, %eax
000000010000c9fc	movq	-0x1c0(%rbp), %r8
000000010000ca03	jmp	0x10000cb6a
000000010000ca08	addq	%r12, %r15
000000010000ca0b	movq	-0x1c8(%rbp), %rdi
000000010000ca12	movq	%r15, 0x10(%rdi)
000000010000ca16	movq	-0x1d0(%rbp), %rax
000000010000ca1d	jmp	0x10000be04
000000010000ca22	movq	%rdi, %rax
000000010000ca25	movq	-0x1c0(%rbp), %r8
000000010000ca2c	subq	%r8, %rax
000000010000ca2f	addq	$0x8, %rax
000000010000ca33	cmpq	$0x20, %rax
000000010000ca37	jae	0x10000cb31
000000010000ca3d	xorl	%eax, %eax
000000010000ca3f	jmp	0x10000cb6a
000000010000ca44	xorl	%eax, %eax
000000010000ca46	xorl	%r8d, %r8d
000000010000ca49	movq	%rax, %rcx
000000010000ca4c	negq	%rcx
000000010000ca4f	movl	$0x0, %edi
000000010000ca54	sbbq	%r8, %rdi
000000010000ca57	cmpb	$0x2d, %sil
000000010000ca5b	cmovneq	%r8, %rdi
000000010000ca5f	cmovneq	%rax, %rcx
000000010000ca63	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000ca6d	cmpq	%rcx, %rax
000000010000ca70	movl	$0x0, %eax
000000010000ca75	sbbq	%rdi, %rax
000000010000ca78	jl	0x10000b6e8
000000010000ca7e	movq	0x8(%r12), %rsi
000000010000ca83	movq	%rcx, %rax
000000010000ca86	mulq	%rsi
000000010000ca89	imulq	%rsi, %rdi
000000010000ca8d	sarq	$0x3f, %rsi
000000010000ca91	imulq	%rcx, %rsi
000000010000ca95	addq	%rdx, %rsi
000000010000ca98	addq	%rsi, %rdi
000000010000ca9b	movabsq	$-0x8000000000000000, %rcx      ## imm = 0x8000000000000000
000000010000caa5	addq	%rax, %rcx
000000010000caa8	adcq	$-0x1, %rdi
000000010000caac	cmpq	$-0x1, %rdi
000000010000cab0	jne	0x10000b6e8
000000010000cab6	movq	%rax, -0x1b8(%rbp)
000000010000cabd	movl	$0x10, %edi
000000010000cac2	movq	%rax, %rbx
000000010000cac5	callq	_fwp_alloc_init
000000010000caca	movabsq	$__mh_execute_header, %rcx
000000010000cad4	movq	%rcx, (%rax)
000000010000cad7	movq	%rbx, 0x8(%rax)
000000010000cadb	leaq	-0x1b8(%rbp), %rcx
000000010000cae2	movq	-0x1e8(%rbp), %rcx
000000010000cae9	movq	%rax, (%rcx)
000000010000caec	jmp	0x10000b6e2
000000010000caf1	cmpb	$0x2e, %dl
000000010000caf4	jne	0x10000ce44
000000010000cafa	leaq	0x1(%rdi), %rdx
000000010000cafe	cmpq	%rax, %rdx
000000010000cb01	jae	0x10000cb21
000000010000cb03	movzbl	-0x130(%rbp,%rdx), %r8d
000000010000cb0c	addb	$-0x30, %r8b
000000010000cb10	cmpb	$0x9, %r8b
000000010000cb14	ja	0x10000cb21
000000010000cb16	incq	%rdx
000000010000cb19	cmpq	%rax, %rdx
000000010000cb1c	jb	0x10000cb03
000000010000cb1e	movq	%rax, %rdx
000000010000cb21	leaq	-0x1(%rdx), %r8
000000010000cb25	cmpq	%rdi, %r8
000000010000cb28	sete	%r8b
000000010000cb2c	jmp	0x10000ce47
000000010000cb31	movl	%r14d, %eax
000000010000cb34	andl	$-0x4, %eax
000000010000cb37	leaq	(,%r14,8), %rcx
000000010000cb3f	andq	$-0x20, %rcx
000000010000cb43	xorl	%edx, %edx
000000010000cb45	movdqu	(%r8,%rdx), %xmm0
000000010000cb4b	movups	0x10(%r8,%rdx), %xmm1
000000010000cb51	movdqu	%xmm0, 0x8(%rdi,%rdx)
000000010000cb57	movups	%xmm1, 0x18(%rdi,%rdx)
000000010000cb5c	addq	$0x20, %rdx
000000010000cb60	cmpq	%rdx, %rcx
000000010000cb63	jne	0x10000cb45
000000010000cb65	cmpl	%r14d, %eax
000000010000cb68	je	0x10000cbc3
000000010000cb6a	movq	%r14, %rdx
000000010000cb6d	movq	%rax, %rcx
000000010000cb70	andq	$0x3, %rdx
000000010000cb74	je	0x10000cb8a
000000010000cb76	movq	%rax, %rcx
000000010000cb79	movq	(%r8,%rcx,8), %rsi
000000010000cb7d	movq	%rsi, 0x8(%rdi,%rcx,8)
000000010000cb82	incq	%rcx
000000010000cb85	decq	%rdx
000000010000cb88	jne	0x10000cb79
000000010000cb8a	subq	%r14, %rax
000000010000cb8d	cmpq	$-0x4, %rax
000000010000cb91	ja	0x10000cbc3
000000010000cb93	movq	(%r8,%rcx,8), %rax
000000010000cb97	movq	%rax, 0x8(%rdi,%rcx,8)
000000010000cb9c	movq	0x8(%r8,%rcx,8), %rax
000000010000cba1	movq	%rax, 0x10(%rdi,%rcx,8)
000000010000cba6	movq	0x10(%r8,%rcx,8), %rax
000000010000cbab	movq	%rax, 0x18(%rdi,%rcx,8)
000000010000cbb0	movq	0x18(%r8,%rcx,8), %rax
000000010000cbb5	movq	%rax, 0x20(%rdi,%rcx,8)
000000010000cbba	addq	$0x4, %rcx
000000010000cbbe	cmpq	%rcx, %r14
000000010000cbc1	jne	0x10000cb93
000000010000cbc3	movq	-0x1e8(%rbp), %rax
000000010000cbca	movq	%rdi, (%rax)
000000010000cbcd	jmp	0x10000b6e2
000000010000cbd2	movq	%r12, -0x1f8(%rbp)
000000010000cbd9	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000cbe3	movl	$0xff, %r8d
000000010000cbe9	leaq	-0x130(%rbp), %r9
000000010000cbf0	movq	-0x1c8(%rbp), %rcx
000000010000cbf7	movq	-0x1c0(%rbp), %r12
000000010000cbfe	movq	%rbx, -0x1d0(%rbp)
000000010000cc05	movq	(%rcx), %rbx
000000010000cc08	movq	0x8(%rcx), %r10
000000010000cc0c	movq	0x10(%rcx), %rsi
000000010000cc10	cmpq	%r10, %rsi
000000010000cc13	movq	%r10, -0x1f0(%rbp)
000000010000cc1a	jae	0x10000cc40
000000010000cc1c	movzbl	(%rbx,%rsi), %eax
000000010000cc20	cmpq	$0x20, %rax
000000010000cc24	ja	0x10000cc40
000000010000cc26	btq	%rax, %r13
000000010000cc2a	jae	0x10000cc40
000000010000cc2c	incq	%rsi
000000010000cc2f	movq	%rsi, 0x10(%rcx)
000000010000cc33	cmpq	%rsi, %r10
000000010000cc36	jne	0x10000cc1c
000000010000cc38	movq	%r10, %r14
000000010000cc3b	movq	%r10, %rsi
000000010000cc3e	jmp	0x10000cc90
000000010000cc40	movabsq	$0x4000000000003, %rdi          ## imm = 0x4000000000003
000000010000cc4a	movq	%rsi, %r14
000000010000cc4d	cmpq	%r10, %rsi
000000010000cc50	jb	0x10000cc60
000000010000cc52	jmp	0x10000cc90
000000010000cc54	incq	%r14
000000010000cc57	movq	%r14, 0x10(%rcx)
000000010000cc5b	cmpq	%r14, %r10
000000010000cc5e	je	0x10000cc8d
000000010000cc60	movzbl	(%rbx,%r14), %eax
000000010000cc65	leal	-0x30(%rax), %edx
000000010000cc68	cmpb	$0xa, %dl
000000010000cc6b	jb	0x10000cc54
000000010000cc6d	movl	%eax, %edx
000000010000cc6f	andb	$-0x21, %dl
000000010000cc72	addb	$-0x41, %dl
000000010000cc75	cmpb	$0x1a, %dl
000000010000cc78	jb	0x10000cc54
000000010000cc7a	movzbl	%al, %eax
000000010000cc7d	addl	$-0x2d, %eax
000000010000cc80	cmpl	$0x32, %eax
000000010000cc83	ja	0x10000cc90
000000010000cc85	btq	%rax, %rdi
000000010000cc89	jb	0x10000cc54
000000010000cc8b	jmp	0x10000cc90
000000010000cc8d	movq	%r10, %r14
000000010000cc90	movq	%r14, %r15
000000010000cc93	subq	%rsi, %r15
000000010000cc96	cmpq	$0xff, %r15
000000010000cc9d	cmovaeq	%r8, %r15
000000010000cca1	addq	%rbx, %rsi
000000010000cca4	movl	$0x100, %ecx                    ## imm = 0x100
000000010000cca9	movq	%r9, %rdi
000000010000ccac	movq	%r15, %rdx
000000010000ccaf	callq	0x10001115a                     ## symbol stub for: ___memcpy_chk
000000010000ccb4	movb	$0x0, -0x130(%rbp,%r15)
000000010000ccbd	movslq	(%r12), %rcx
000000010000ccc1	testq	%rcx, %rcx
000000010000ccc4	movq	-0x1d0(%rbp), %rax
000000010000cccb	jle	0x10000ce3c
000000010000ccd1	movq	%rbx, -0x200(%rbp)
000000010000ccd8	movq	0x18(%rax), %rax
000000010000ccdc	movq	%rax, -0x1d8(%rbp)
000000010000cce3	movl	$0xffffffff, %r15d              ## imm = 0xFFFFFFFF
000000010000cce9	xorl	%r13d, %r13d
000000010000ccec	leaq	-0x130(%rbp), %r12
000000010000ccf3	movq	-0x1d8(%rbp), %rax
000000010000ccfa	movq	(%rax,%r13,8), %rdi
000000010000ccfe	movq	%r12, %rsi
000000010000cd01	movq	%rcx, %rbx
000000010000cd04	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000cd09	movq	%rbx, %rcx
000000010000cd0c	testl	%eax, %eax
000000010000cd0e	cmovel	%r13d, %r15d
000000010000cd12	incq	%r13
000000010000cd15	cmpq	%r13, %rbx
000000010000cd18	jne	0x10000ccf3
000000010000cd1a	testl	%r15d, %r15d
000000010000cd1d	movq	-0x1d0(%rbp), %rax
000000010000cd24	movq	-0x1c8(%rbp), %rcx
000000010000cd2b	movq	-0x1c0(%rbp), %r12
000000010000cd32	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000cd3c	movq	-0x200(%rbp), %rsi
000000010000cd43	movq	-0x1f0(%rbp), %rdi
000000010000cd4a	js	0x10000ce3c
000000010000cd50	cmpq	%rdi, %r14
000000010000cd53	jae	0x10000cd77
000000010000cd55	movzbl	(%rsi,%r14), %edx
000000010000cd5a	cmpq	$0x20, %rdx
000000010000cd5e	ja	0x10000cd77
000000010000cd60	btq	%rdx, %r13
000000010000cd64	jae	0x10000cd77
000000010000cd66	incq	%r14
000000010000cd69	movq	%r14, 0x10(%rcx)
000000010000cd6d	cmpq	%r14, %rdi
000000010000cd70	jne	0x10000cd55
000000010000cd72	jmp	0x10000ce3c
000000010000cd77	cmpq	%r14, %rdi
000000010000cd7a	je	0x10000ce3c
000000010000cd80	cmpb	$0x3d, (%rsi,%r14)
000000010000cd85	jne	0x10000ce3c
000000010000cd8b	incq	%r14
000000010000cd8e	movq	%r14, 0x10(%rcx)
000000010000cd92	movq	0x20(%rax), %rax
000000010000cd96	movl	%r15d, %ebx
000000010000cd99	movq	(%rax,%rbx,8), %rsi
000000010000cd9d	movq	-0x1e0(%rbp), %rax
000000010000cda4	leaq	(%rax,%rbx,8), %rcx
000000010000cda8	movq	-0x1c8(%rbp), %rdi
000000010000cdaf	xorl	%edx, %edx
000000010000cdb1	callq	_tp_value
000000010000cdb6	movq	-0x1c8(%rbp), %rcx
000000010000cdbd	testl	%eax, %eax
000000010000cdbf	je	0x10000ce3c
000000010000cdc1	movq	-0x1f8(%rbp), %rax
000000010000cdc8	movb	$0x1, (%rax,%rbx)
000000010000cdcc	movq	0x8(%rcx), %rdx
000000010000cdd0	movq	0x10(%rcx), %rax
000000010000cdd4	cmpq	%rdx, %rax
000000010000cdd7	jae	0x10000cdfa
000000010000cdd9	movq	(%rcx), %rsi
000000010000cddc	movzbl	(%rsi,%rax), %edi
000000010000cde0	cmpq	$0x20, %rdi
000000010000cde4	ja	0x10000cdfa
000000010000cde6	btq	%rdi, %r13
000000010000cdea	jae	0x10000cdfa
000000010000cdec	incq	%rax
000000010000cdef	movq	%rax, 0x10(%rcx)
000000010000cdf3	cmpq	%rax, %rdx
000000010000cdf6	jne	0x10000cddc
000000010000cdf8	jmp	0x10000ce0c
000000010000cdfa	cmpq	%rax, %rdx
000000010000cdfd	je	0x10000ce0c
000000010000cdff	movq	(%rcx), %rdx
000000010000ce02	cmpb	$0x7d, (%rdx,%rax)
000000010000ce06	je	0x10000cef9
000000010000ce0c	movq	-0x1c8(%rbp), %rdi
000000010000ce13	leaq	0x57a1(%rip), %rsi              ## literal pool for: ","
000000010000ce1a	callq	_tp_eat
000000010000ce1f	movq	-0x1c8(%rbp), %rcx
000000010000ce26	testl	%eax, %eax
000000010000ce28	je	0x10000ce3c
000000010000ce2a	movl	$0xff, %r8d
000000010000ce30	leaq	-0x130(%rbp), %r9
000000010000ce37	jmp	0x10000cc05
000000010000ce3c	xorl	%r14d, %r14d
000000010000ce3f	jmp	0x10000b6e8
000000010000ce44	movq	%rdi, %rdx
000000010000ce47	cmpq	%rsi, %rdi
000000010000ce4a	jne	0x10000ce55
000000010000ce4c	testb	%r8b, %r8b
000000010000ce4f	jne	0x10000b6e8
000000010000ce55	cmpq	%rax, %rdx
000000010000ce58	jae	0x10000cebe
000000010000ce5a	movzbl	-0x130(%rbp,%rdx), %esi
000000010000ce62	orl	$0x20, %esi
000000010000ce65	cmpl	$0x65, %esi
000000010000ce68	jne	0x10000cebe
000000010000ce6a	leaq	0x1(%rdx), %rsi
000000010000ce6e	cmpq	%rax, %rsi
000000010000ce71	jae	0x10000ce8c
000000010000ce73	movzbl	-0x130(%rbp,%rsi), %edi
000000010000ce7b	cmpl	$0x2d, %edi
000000010000ce7e	je	0x10000ce85
000000010000ce80	cmpl	$0x2b, %edi
000000010000ce83	jne	0x10000ce8c
000000010000ce85	addq	$0x2, %rdx
000000010000ce89	movq	%rdx, %rsi
000000010000ce8c	cmpq	%rax, %rsi
000000010000ce8f	jae	0x10000b6e8
000000010000ce95	movq	%rsi, %rdx
000000010000ce98	movzbl	-0x130(%rbp,%rdx), %edi
000000010000cea0	addb	$-0x30, %dil
000000010000cea4	cmpb	$0x9, %dil
000000010000cea8	ja	0x10000ceb5
000000010000ceaa	incq	%rdx
000000010000cead	cmpq	%rdx, %rax
000000010000ceb0	jne	0x10000ce98
000000010000ceb2	movq	%rax, %rdx
000000010000ceb5	cmpq	%rsi, %rdx
000000010000ceb8	je	0x10000b6e8
000000010000cebe	cmpq	%rax, %rdx
000000010000cec1	jne	0x10000b6e8
000000010000cec7	cmpl	$0xa, (%rcx)
000000010000ceca	jne	0x10000cee6
000000010000cecc	leaq	-0x130(%rbp), %rdi
000000010000ced3	xorl	%esi, %esi
000000010000ced5	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000ceda	movd	%xmm0, %eax
000000010000cede	movq	%rax, (%r15)
000000010000cee1	jmp	0x10000b6e2
000000010000cee6	leaq	-0x130(%rbp), %rdi
000000010000ceed	xorl	%esi, %esi
000000010000ceef	callq	0x100011298                     ## symbol stub for: _strtod
000000010000cef4	jmp	0x10000bb8d
000000010000cef9	incq	%rax
000000010000cefc	movq	%rax, 0x10(%rcx)
000000010000cf00	movq	-0x1f8(%rbp), %r12
000000010000cf07	jmp	0x10000c7d8
000000010000cf0c	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
000000010000cf11	nopl	(%rax)
000000010000cf14	popq	%rax
000000010000cf15	callq	0xe859cf19
000000010000cf1a	.byte 0xff #bad opcode
000000010000cf1b	lcalll	*-0x18(%rax)
000000010000cf1e	.byte 0xff #bad opcode
000000010000cf1f	lcalll	*-0x18(%rax)
000000010000cf22	.byte 0xff #bad opcode
000000010000cf23	lcalll	*-0x18(%rax)
000000010000cf26	.byte 0xff #bad opcode
000000010000cf27	lcalll	*-0x18(%rax)
000000010000cf2a	.byte 0xff #bad opcode
000000010000cf2b	lcalll	*-0x18(%rax)
000000010000cf2e	.byte 0xff #bad opcode
000000010000cf2f	lcalll	*-0x18(%rax)
000000010000cf32	.byte 0xff #bad opcode
000000010000cf33	lcalll	*-0x18(%rax)
000000010000cf36	.byte 0xff #bad opcode
000000010000cf37	lcalll	*-0x18(%rax)
000000010000cf3a	.byte 0xff #bad opcode
000000010000cf3b	.byte 0xff #bad opcode
000000010000cf3c	cmpl	%esp, %ebp
000000010000cf3e	.byte 0xff #bad opcode
000000010000cf3f	.byte 0xff #bad opcode
000000010000cf40	cmpl	%esp, %ebp
000000010000cf42	.byte 0xff #bad opcode
000000010000cf43	incl	-0x49000014(%rcx)
000000010000cf49	inb	%dx, %al
000000010000cf4a	.byte 0xff #bad opcode
000000010000cf4b	.byte 0xff #bad opcode
000000010000cf4c	jl	0x10000cf3d
000000010000cf4e	.byte 0xff #bad opcode
000000010000cf4f	decl	(%rcx)
000000010000cf51	jmp	0x10000cf52
000000010000cf53	lcalll	*(%rdx)
000000010000cf55	outb	%al, %dx
000000010000cf56	.byte 0xff #bad opcode
000000010000cf57	decl	(%rcx)
000000010000cf59	jmp	0x10000cf5a
000000010000cf5b	.byte 0xff #bad opcode
000000010000cf5c	fsubr	%st, %st(1)
000000010000cf5e	.byte 0xff #bad opcode
000000010000cf5f	.byte 0xff #bad opcode
000000010000cf60	fsubr	%st, %st(1)
000000010000cf62	.byte 0xff #bad opcode
000000010000cf63	incl	-0x13(%rcx)
000000010000cf66	.byte 0xff #bad opcode
000000010000cf67	ljmpl	*0xfffffed(%rcx)
000000010000cf6d	.byte 0x1f #bad opcode
000000010000cf6e	addb	%dl, 0x48(%rbp)
000000010000cf72	movl	%esp, %ebp
000000010000cf74	pushq	%r15
000000010000cf76	pushq	%r14
000000010000cf78	pushq	%r13
000000010000cf7a	pushq	%r12
000000010000cf7c	pushq	%rbx
000000010000cf7d	subq	$0xb8, %rsp
000000010000cf84	movq	%rdx, %rbx
000000010000cf87	movq	%rsi, %r15
000000010000cf8a	movq	0x609f(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000cf91	movq	(%rax), %rax
000000010000cf94	movq	%rax, -0x30(%rbp)
000000010000cf98	leaq	-0xb0(%rbp), %rsi
000000010000cf9f	movl	$0x80, %edx
000000010000cfa4	callq	_tp_token
000000010000cfa9	xorl	%r14d, %r14d
000000010000cfac	cmpq	$0x7f, %rax
000000010000cfb0	ja	0x10000cfec
000000010000cfb2	leaq	-0xb0(%rbp), %r12
000000010000cfb9	movq	%r12, %rdi
000000010000cfbc	callq	0x100011286                     ## symbol stub for: _strlen
000000010000cfc1	movq	%r12, %rdi
000000010000cfc4	movq	%rax, %rsi
000000010000cfc7	callq	_fwp_str_new
000000010000cfcc	movq	(%rax), %r11
000000010000cfcf	testq	%r11, %r11
000000010000cfd2	je	0x10000cfec
000000010000cfd4	movq	%rax, %rcx
000000010000cfd7	movzbl	0x8(%rax), %r8d
000000010000cfdc	leal	-0x2b(%r8), %eax
000000010000cfe0	xorl	%edx, %edx
000000010000cfe2	testb	$-0x3, %al
000000010000cfe4	sete	%dl
000000010000cfe7	cmpq	%rdx, %r11
000000010000cfea	jne	0x10000d015
000000010000cfec	movq	0x603d(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000cff3	movq	(%rax), %rax
000000010000cff6	cmpq	-0x30(%rbp), %rax
000000010000cffa	jne	0x10000d399
000000010000d000	movl	%r14d, %eax
000000010000d003	addq	$0xb8, %rsp
000000010000d00a	popq	%rbx
000000010000d00b	popq	%r12
000000010000d00d	popq	%r13
000000010000d00f	popq	%r14
000000010000d011	popq	%r15
000000010000d013	popq	%rbp
000000010000d014	retq
000000010000d015	movl	(%r15), %r9d
000000010000d018	movl	0x48(%r15), %edi
000000010000d01c	jbe	0x10000d037
000000010000d01e	nop
000000010000d020	movzbl	0x8(%rcx,%rdx), %esi
000000010000d025	addb	$-0x3a, %sil
000000010000d029	cmpb	$-0xa, %sil
000000010000d02d	jb	0x10000cfec
000000010000d02f	incq	%rdx
000000010000d032	cmpq	%rdx, %r11
000000010000d035	jne	0x10000d020
000000010000d037	movl	%r9d, -0xb4(%rbp)
000000010000d03e	movq	%r8, -0xc0(%rbp)
000000010000d045	movq	%rdi, -0xd0(%rbp)
000000010000d04c	movq	%rbx, -0xc8(%rbp)
000000010000d053	xorl	%r15d, %r15d
000000010000d056	testb	$-0x3, %al
000000010000d058	sete	%r15b
000000010000d05c	xorl	%edi, %edi
000000010000d05e	movl	$0x0, %esi
000000010000d063	cmpq	%r15, %r11
000000010000d066	jbe	0x10000d121
000000010000d06c	xorl	%r14d, %r14d
000000010000d06f	movabsq	$-0x3333333333333333, %rbx      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000d079	xorl	%edi, %edi
000000010000d07b	xorl	%esi, %esi
000000010000d07d	nopl	(%rax)
000000010000d080	movq	%rsi, %r13
000000010000d083	movq	%rdi, %r12
000000010000d086	movq	%rdi, %rax
000000010000d089	movl	$0xa, %edx
000000010000d08e	mulq	%rdx
000000010000d091	leaq	(%rsi,%rsi,4), %rsi
000000010000d095	leaq	(%rdx,%rsi,2), %rdx
000000010000d099	movsbl	0x8(%rcx,%r15), %esi
000000010000d09f	addl	$-0x30, %esi
000000010000d0a2	movslq	%esi, %r8
000000010000d0a5	movq	%r8, %rsi
000000010000d0a8	sarq	$0x3f, %rsi
000000010000d0ac	movq	%rax, %rdi
000000010000d0af	addq	%r8, %rdi
000000010000d0b2	adcq	%rdx, %rsi
000000010000d0b5	movq	%rsi, %r9
000000010000d0b8	shldq	$0x3f, %rdi, %r9
000000010000d0bd	movq	%rsi, %r8
000000010000d0c0	shrq	%r8
000000010000d0c3	movq	%r9, %r10
000000010000d0c6	addq	%r8, %r10
000000010000d0c9	adcq	$0x0, %r10
000000010000d0cd	movq	%r10, %rax
000000010000d0d0	mulq	%rbx
000000010000d0d3	shrq	$0x2, %rdx
000000010000d0d7	leaq	(%rdx,%rdx,4), %rax
000000010000d0db	subq	%rax, %r10
000000010000d0de	subq	%r10, %r9
000000010000d0e1	sbbq	$0x0, %r8
000000010000d0e5	movq	%r9, %r10
000000010000d0e8	movabsq	$-0x3333333333333334, %rax      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000d0f2	imulq	%rax, %r10
000000010000d0f6	movq	%r9, %rax
000000010000d0f9	mulq	%rbx
000000010000d0fc	addq	%r10, %rdx
000000010000d0ff	imulq	%rbx, %r8
000000010000d103	addq	%rdx, %r8
000000010000d106	xorq	%r13, %r8
000000010000d109	xorq	%r12, %rax
000000010000d10c	orq	%r8, %rax
000000010000d10f	jne	0x10000cfec
000000010000d115	incq	%r15
000000010000d118	cmpq	%r15, %r11
000000010000d11b	jne	0x10000d080
000000010000d121	movl	-0xb4(%rbp), %r11d
000000010000d128	cmpl	$0x9, %r11d
000000010000d12c	jne	0x10000d190
000000010000d12e	cmpb	$0x2d, -0xc0(%rbp)
000000010000d135	movq	-0xc8(%rbp), %rbx
000000010000d13c	jne	0x10000d14d
000000010000d13e	xorl	%r14d, %r14d
000000010000d141	movq	%rdi, %rax
000000010000d144	orq	%rsi, %rax
000000010000d147	jne	0x10000cfec
000000010000d14d	callq	_fwp_box_u128
000000010000d152	movq	%rax, %r15
000000010000d155	movq	%r15, -0xd8(%rbp)
000000010000d15c	movl	$0x10, %edi
000000010000d161	callq	_fwp_alloc_init
000000010000d166	movabsq	$0x100000001, %rcx              ## imm = 0x100000001
000000010000d170	movq	%rcx, (%rax)
000000010000d173	movq	%r15, 0x8(%rax)
000000010000d177	leaq	-0xd8(%rbp), %rcx
000000010000d17e	movq	0x8(%rax), %rax
000000010000d182	movq	%rax, (%rbx)
000000010000d185	movl	$0x1, %r14d
000000010000d18b	jmp	0x10000cfec
000000010000d190	movq	-0xc0(%rbp), %r10
000000010000d197	cmpb	$0x2d, %r10b
000000010000d19b	sete	%cl
000000010000d19e	movabsq	$-0x8000000000000000, %rax      ## imm = 0x8000000000000000
000000010000d1a8	movq	%rsi, %rdx
000000010000d1ab	xorq	%rax, %rdx
000000010000d1ae	orq	%rdi, %rdx
000000010000d1b1	setne	%dl
000000010000d1b4	xorl	%r14d, %r14d
000000010000d1b7	movq	%rdi, %r8
000000010000d1ba	negq	%r8
000000010000d1bd	movq	%rax, %r8
000000010000d1c0	sbbq	%rsi, %r8
000000010000d1c3	movq	-0xc8(%rbp), %rbx
000000010000d1ca	jb	0x10000cfec
000000010000d1d0	orb	%dl, %cl
000000010000d1d2	je	0x10000cfec
000000010000d1d8	xorl	%r14d, %r14d
000000010000d1db	movq	%rdi, %r15
000000010000d1de	negq	%r15
000000010000d1e1	movl	$0x0, %r9d
000000010000d1e7	sbbq	%rsi, %r9
000000010000d1ea	cmpb	$0x2d, %r10b
000000010000d1ee	cmovneq	%rdi, %r15
000000010000d1f2	cmovneq	%rsi, %r9
000000010000d1f6	cmpl	$0x14, %r11d
000000010000d1fa	ja	0x10000cfec
000000010000d200	movl	%r11d, %ecx
000000010000d203	leaq	0x196(%rip), %rdx
000000010000d20a	movslq	(%rdx,%rcx,4), %rcx
000000010000d20e	addq	%rdx, %rcx
000000010000d211	jmpq	*%rcx
000000010000d213	movq	%r15, %rax
000000010000d216	addq	$-0x80, %rax
000000010000d21a	adcq	$-0x1, %r9
000000010000d21e	cmpq	$-0x100, %rax
000000010000d224	jmp	0x10000d25f
000000010000d226	movq	%r15, %rax
000000010000d229	addq	$-0x80000000, %rax              ## imm = 0x80000000
000000010000d22f	adcq	$-0x1, %r9
000000010000d233	movabsq	$-0x100000000, %rcx             ## imm = 0xFFFFFFFF00000000
000000010000d23d	cmpq	%rcx, %rax
000000010000d240	jmp	0x10000d25f
000000010000d242	xorl	%r14d, %r14d
000000010000d245	movl	$0xff, %eax
000000010000d24a	jmp	0x10000d276
000000010000d24c	movq	%r15, %rax
000000010000d24f	addq	$-0x8000, %rax                  ## imm = 0x8000
000000010000d255	adcq	$-0x1, %r9
000000010000d259	cmpq	$-0x10000, %rax                 ## imm = 0xFFFF0000
000000010000d25f	sbbq	$-0x1, %r9
000000010000d263	jb	0x10000cfec
000000010000d269	jmp	0x10000d155
000000010000d26e	xorl	%r14d, %r14d
000000010000d271	movl	$0xffff, %eax                   ## imm = 0xFFFF
000000010000d276	cmpq	%r15, %rax
000000010000d279	movl	$0x0, %eax
000000010000d27e	sbbq	%r9, %rax
000000010000d281	jb	0x10000cfec
000000010000d287	jmp	0x10000d155
000000010000d28c	movq	%r15, %rax
000000010000d28f	shrq	$0x20, %rax
000000010000d293	orq	%r9, %rax
000000010000d296	jne	0x10000cfec
000000010000d29c	jmp	0x10000d155
000000010000d2a1	movq	%r15, %rcx
000000010000d2a4	addq	%rax, %rcx
000000010000d2a7	adcq	$-0x1, %r9
000000010000d2ab	cmpq	$-0x1, %r9
000000010000d2af	jne	0x10000cfec
000000010000d2b5	jmp	0x10000d155
000000010000d2ba	movq	%r15, %rdi
000000010000d2bd	movq	%r9, %rsi
000000010000d2c0	callq	_fwp_box_u128
000000010000d2c5	jmp	0x10000d152
000000010000d2ca	xorl	%r14d, %r14d
000000010000d2cd	movq	-0xd0(%rbp), %rcx
000000010000d2d4	testl	%ecx, %ecx
000000010000d2d6	jle	0x10000d30d
000000010000d2d8	leal	-0x1(%rcx), %eax
000000010000d2db	cmpl	$0x4f, %eax
000000010000d2de	movl	$0x4f, %r8d
000000010000d2e4	cmovbl	%eax, %r8d
000000010000d2e8	incl	%r8d
000000010000d2eb	movl	%r8d, %edi
000000010000d2ee	andl	$0x7, %edi
000000010000d2f1	cmpl	$0x8, %ecx
000000010000d2f4	jae	0x10000d313
000000010000d2f6	movl	$0x1, %eax
000000010000d2fb	xorl	%ecx, %ecx
000000010000d2fd	jmp	0x10000d339
000000010000d2ff	testq	%r9, %r9
000000010000d302	jne	0x10000cfec
000000010000d308	jmp	0x10000d155
000000010000d30d	xorl	%edx, %edx
000000010000d30f	xorl	%ecx, %ecx
000000010000d311	jmp	0x10000d36e
000000010000d313	andl	$0xf8, %r8d
000000010000d31a	movl	$0x1, %eax
000000010000d31f	xorl	%ecx, %ecx
000000010000d321	movl	$0x19a1, %esi                   ## imm = 0x19A1
000000010000d326	mulq	%rsi
000000010000d329	imulq	$0x19a1, %rcx, %rcx             ## imm = 0x19A1
000000010000d330	addq	%rdx, %rcx
000000010000d333	addl	$-0x8, %r8d
000000010000d337	jne	0x10000d326
000000010000d339	testl	%edi, %edi
000000010000d33b	je	0x10000d350
000000010000d33d	movl	$0x3, %esi
000000010000d342	mulq	%rsi
000000010000d345	leaq	(%rcx,%rcx,2), %rcx
000000010000d349	addq	%rdx, %rcx
000000010000d34c	decl	%edi
000000010000d34e	jne	0x10000d342
000000010000d350	addq	$-0x1, %rax
000000010000d354	adcq	$-0x1, %rcx
000000010000d358	movq	%rcx, %rdx
000000010000d35b	shrq	$0x3f, %rdx
000000010000d35f	addq	%rax, %rdx
000000010000d362	adcq	$0x0, %rcx
000000010000d366	shrdq	$0x1, %rcx, %rdx
000000010000d36b	sarq	%rcx
000000010000d36e	movq	%rdx, %rax
000000010000d371	negq	%rax
000000010000d374	movl	$0x0, %esi
000000010000d379	sbbq	%rcx, %rsi
000000010000d37c	cmpq	%r15, %rdx
000000010000d37f	sbbq	%r9, %rcx
000000010000d382	jl	0x10000cfec
000000010000d388	cmpq	%rax, %r15
000000010000d38b	sbbq	%rsi, %r9
000000010000d38e	jge	0x10000d155
000000010000d394	jmp	0x10000cfec
000000010000d399	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
000000010000d39e	nop
000000010000d3a0	jae	0x10000d3a0
000000010000d3a2	.byte 0xff #bad opcode
000000010000d3a3	ljmpl	*-0x1790001(%rsi,%rdi,8)
000000010000d3aa	.byte 0xff #bad opcode
000000010000d3ab	incl	(%rcx)
000000010000d3ad	.byte 0xff #bad opcode
000000010000d3ae	.byte 0xff #bad opcode
000000010000d3af	lcalll	*(%rdx)
000000010000d3b1	.byte 0xff #bad opcode
000000010000d3b2	.byte 0xff #bad opcode
000000010000d3b3	jmpq	*-0x31000002(%rdx)
000000010000d3b9	.byte 0xfe #bad opcode
000000010000d3ba	.byte 0xff #bad opcode
000000010000d3bb	.byte 0xff #bad opcode
000000010000d3bc	inb	%dx, %al
000000010000d3bd	.byte 0xfe #bad opcode
000000010000d3be	.byte 0xff #bad opcode
000000010000d3bf	lcalll	*-0x1(%rdi)
000000010000d3c2	.byte 0xff #bad opcode
000000010000d3c3	decl	-0x1(%rsp,%rdi,8)
000000010000d3c7	decl	-0x1(%rsp,%rdi,8)
000000010000d3cb	decl	-0x1(%rsp,%rdi,8)
000000010000d3cf	decl	-0x1(%rsp,%rdi,8)
000000010000d3d3	decl	-0x1(%rsp,%rdi,8)
000000010000d3d7	decl	-0x1(%rsp,%rdi,8)
000000010000d3db	decl	-0x1(%rsp,%rdi,8)
000000010000d3df	decl	-0x1(%rsp,%rdi,8)
000000010000d3e3	decl	-0x1(%rsp,%rdi,8)
000000010000d3e7	decl	-0x1(%rsp,%rdi,8)
000000010000d3eb	decl	-0x1(%rsp,%rdi,8)
000000010000d3ef	ljmpl	*(%rdx)
000000010000d3f1	.byte 0xff #bad opcode
000000010000d3f2	.byte 0xff #bad opcode
000000010000d3f3	jmpq	*0x66(%rsi)
000000010000d3f6	nopw	%cs:(%rax,%rax)
_tp_quoted:
000000010000d400	pushq	%rbp
000000010000d401	movq	%rsp, %rbp
000000010000d404	pushq	%r15
000000010000d406	pushq	%r14
000000010000d408	pushq	%r13
000000010000d40a	pushq	%r12
000000010000d40c	pushq	%rbx
000000010000d40d	subq	$0x28, %rsp
000000010000d411	movq	%rsi, %rbx
000000010000d414	movq	%rdi, %r15
000000010000d417	movq	0x8(%rdi), %rcx
000000010000d41b	movq	0x10(%rdi), %rax
000000010000d41f	cmpq	%rcx, %rax
000000010000d422	jae	0x10000d464
000000010000d424	movq	(%r15), %rdx
000000010000d427	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000d431	nopw	%cs:(%rax,%rax)
000000010000d440	movzbl	(%rdx,%rax), %edi
000000010000d444	cmpq	$0x20, %rdi
000000010000d448	ja	0x10000d464
000000010000d44a	btq	%rdi, %rsi
000000010000d44e	jae	0x10000d464
000000010000d450	incq	%rax
000000010000d453	movq	%rax, 0x10(%r15)
000000010000d457	cmpq	%rax, %rcx
000000010000d45a	jne	0x10000d440
000000010000d45c	xorl	%r14d, %r14d
000000010000d45f	jmp	0x10000d646
000000010000d464	xorl	%r14d, %r14d
000000010000d467	cmpq	%rcx, %rax
000000010000d46a	jae	0x10000d646
000000010000d470	movq	(%r15), %rdx
000000010000d473	cmpb	$0x22, (%rdx,%rax)
000000010000d477	jne	0x10000d646
000000010000d47d	incq	%rax
000000010000d480	movq	%rax, 0x10(%r15)
000000010000d484	xorps	%xmm0, %xmm0
000000010000d487	movaps	%xmm0, -0x50(%rbp)
000000010000d48b	movq	$0x0, -0x40(%rbp)
000000010000d493	xorl	%r14d, %r14d
000000010000d496	cmpq	%rcx, %rax
000000010000d499	jae	0x10000d634
000000010000d49f	leaq	-0x50(%rbp), %r12
000000010000d4a3	movq	0x5b56(%rip), %r13              ## literal pool symbol address: __DefaultRuneLocale
000000010000d4aa	nopw	(%rax,%rax)
000000010000d4b0	movq	(%r15), %rdx
000000010000d4b3	leaq	0x1(%rax), %rdi
000000010000d4b7	movq	%rdi, 0x10(%r15)
000000010000d4bb	movzbl	(%rdx,%rax), %esi
000000010000d4bf	cmpl	$0x5c, %esi
000000010000d4c2	je	0x10000d500
000000010000d4c4	cmpl	$0x22, %esi
000000010000d4c7	je	0x10000d658
000000010000d4cd	movb	%sil, -0x29(%rbp)
000000010000d4d1	movl	$0x1, %edx
000000010000d4d6	movq	%r12, %rdi
000000010000d4d9	leaq	-0x29(%rbp), %rsi
000000010000d4dd	callq	_buf_put
000000010000d4e2	movq	0x8(%r15), %rcx
000000010000d4e6	movq	0x10(%r15), %rax
000000010000d4ea	cmpq	%rcx, %rax
000000010000d4ed	jb	0x10000d4b0
000000010000d4ef	jmp	0x10000d63d
000000010000d4f4	nopw	%cs:(%rax,%rax)
000000010000d500	cmpq	%rcx, %rdi
000000010000d503	jae	0x10000d63d
000000010000d509	leaq	0x2(%rax), %rsi
000000010000d50d	movq	%rsi, 0x10(%r15)
000000010000d511	movzbl	0x1(%rdx,%rax), %edi
000000010000d516	leal	-0x5c(%rdi), %r8d
000000010000d51a	cmpl	$0x19, %r8d
000000010000d51e	ja	0x10000d536
000000010000d520	leaq	0x2b9(%rip), %r9
000000010000d527	movslq	(%r9,%r8,4), %rdi
000000010000d52b	addq	%r9, %rdi
000000010000d52e	jmpq	*%rdi
000000010000d530	movb	$0x5c, -0x29(%rbp)
000000010000d534	jmp	0x10000d4d1
000000010000d536	cmpl	$0x22, %edi
000000010000d539	je	0x10000d5f1
000000010000d53f	cmpl	$0x30, %edi
000000010000d542	jne	0x10000d63d
000000010000d548	movb	$0x0, -0x29(%rbp)
000000010000d54c	jmp	0x10000d4d1
000000010000d54e	movb	$0x9, -0x29(%rbp)
000000010000d552	jmp	0x10000d4d1
000000010000d557	movb	$0xd, -0x29(%rbp)
000000010000d55b	jmp	0x10000d4d1
000000010000d560	movb	$0xa, -0x29(%rbp)
000000010000d564	jmp	0x10000d4d1
000000010000d569	cmpq	%rcx, %rsi
000000010000d56c	jae	0x10000d63d
000000010000d572	cmpb	$0x7b, (%rdx,%rsi)
000000010000d576	jne	0x10000d63d
000000010000d57c	leaq	0x3(%rax), %rsi
000000010000d580	movq	%rsi, 0x10(%r15)
000000010000d584	cmpq	%rcx, %rsi
000000010000d587	jae	0x10000d63d
000000010000d58d	leaq	0x4(%rax), %rdi
000000010000d591	leaq	(%rdx,%rax), %r8
000000010000d595	addq	$0x3, %r8
000000010000d599	subq	%rax, %rcx
000000010000d59c	addq	$-0x3, %rcx
000000010000d5a0	xorl	%edx, %edx
000000010000d5a2	xorl	%esi, %esi
000000010000d5a4	nopw	%cs:(%rax,%rax)
000000010000d5b0	movzbl	(%r8,%rdx), %r9d
000000010000d5b5	testb	$0x1, 0x3e(%r13,%r9,4)
000000010000d5bb	je	0x10000d5fa
000000010000d5bd	leaq	(%rdi,%rdx), %r9
000000010000d5c1	movq	%r9, 0x10(%r15)
000000010000d5c5	movsbl	(%r8,%rdx), %r9d
000000010000d5ca	shll	$0x4, %esi
000000010000d5cd	leal	-0x30(%r9), %r10d
000000010000d5d1	movl	%r9d, %r11d
000000010000d5d4	orl	$0x20, %r11d
000000010000d5d8	addl	$-0x57, %r11d
000000010000d5dc	cmpl	$0x3a, %r9d
000000010000d5e0	cmovll	%r10d, %r11d
000000010000d5e4	addl	%r11d, %esi
000000010000d5e7	incq	%rdx
000000010000d5ea	cmpq	%rdx, %rcx
000000010000d5ed	jne	0x10000d5b0
000000010000d5ef	jmp	0x10000d63d
000000010000d5f1	movb	$0x22, -0x29(%rbp)
000000010000d5f5	jmp	0x10000d4d1
000000010000d5fa	testl	%edx, %edx
000000010000d5fc	je	0x10000d63d
000000010000d5fe	cmpb	$0x7d, %r9b
000000010000d602	jne	0x10000d63d
000000010000d604	cmpl	$0x10ffff, %esi                 ## imm = 0x10FFFF
000000010000d60a	ja	0x10000d63d
000000010000d60c	movl	%esi, %ecx
000000010000d60e	andl	$0x1ff800, %ecx                 ## imm = 0x1FF800
000000010000d614	cmpl	$0xd800, %ecx                   ## imm = 0xD800
000000010000d61a	je	0x10000d63d
000000010000d61c	addq	%rdx, %rax
000000010000d61f	addq	$0x4, %rax
000000010000d623	movq	%rax, 0x10(%r15)
000000010000d627	movq	%r12, %rdi
000000010000d62a	callq	_fwp_utf8_put
000000010000d62f	jmp	0x10000d4e2
000000010000d634	xorl	%edi, %edi
000000010000d636	callq	0x1000111d2                     ## symbol stub for: _free
000000010000d63b	jmp	0x10000d646
000000010000d63d	movq	-0x50(%rbp), %rdi
000000010000d641	callq	0x1000111d2                     ## symbol stub for: _free
000000010000d646	movl	%r14d, %eax
000000010000d649	addq	$0x28, %rsp
000000010000d64d	popq	%rbx
000000010000d64e	popq	%r12
000000010000d650	popq	%r13
000000010000d652	popq	%r14
000000010000d654	popq	%r15
000000010000d656	popq	%rbp
000000010000d657	retq
000000010000d658	movq	-0x50(%rbp), %r14
000000010000d65c	movq	-0x48(%rbp), %rsi
000000010000d660	testq	%r14, %r14
000000010000d663	leaq	0x4228(%rip), %rdi              ## literal pool for: ""
000000010000d66a	cmovneq	%r14, %rdi
000000010000d66e	testq	%rsi, %rsi
000000010000d671	je	0x10000d7b3
000000010000d677	xorl	%eax, %eax
000000010000d679	jmp	0x10000d687
000000010000d67b	incq	%rax
000000010000d67e	cmpq	%rsi, %rax
000000010000d681	jae	0x10000d7b3
000000010000d687	movzbl	(%rdi,%rax), %r9d
000000010000d68c	testb	%r9b, %r9b
000000010000d68f	jns	0x10000d67b
000000010000d691	leal	0x3e(%r9), %ecx
000000010000d695	cmpb	$0x1e, %cl
000000010000d698	jae	0x10000d6ac
000000010000d69a	movl	$0x80, %ecx
000000010000d69f	movl	$0x1, %r8d
000000010000d6a5	movl	$0x1f, %edx
000000010000d6aa	jmp	0x10000d6e6
000000010000d6ac	movl	%r9d, %ecx
000000010000d6af	andb	$-0x10, %cl
000000010000d6b2	cmpb	$-0x20, %cl
000000010000d6b5	jne	0x10000d6c9
000000010000d6b7	movl	$0x800, %ecx                    ## imm = 0x800
000000010000d6bc	movl	$0x2, %r8d
000000010000d6c2	movl	$0xf, %edx
000000010000d6c7	jmp	0x10000d6e6
000000010000d6c9	leal	0x10(%r9), %ecx
000000010000d6cd	cmpb	$0x4, %cl
000000010000d6d0	ja	0x10000d7d1
000000010000d6d6	movl	$0x10000, %ecx                  ## imm = 0x10000
000000010000d6db	movl	$0x3, %r8d
000000010000d6e1	movl	$0x7, %edx
000000010000d6e6	movl	%r8d, %r8d
000000010000d6e9	leaq	(%rax,%r8), %r10
000000010000d6ed	cmpq	%rsi, %r10
000000010000d6f0	jae	0x10000d7d1
000000010000d6f6	movzbl	0x1(%rdi,%rax), %r10d
000000010000d6fc	movl	%r10d, %r11d
000000010000d6ff	andl	$-0x40, %r11d
000000010000d703	cmpl	$0x80, %r11d
000000010000d70a	jne	0x10000d7d1
000000010000d710	andl	%r9d, %edx
000000010000d713	leal	0x1(%r8), %r11d
000000010000d717	movl	%edx, %r9d
000000010000d71a	shll	$0x6, %r9d
000000010000d71e	andl	$0x3f, %r10d
000000010000d722	orl	%r9d, %r10d
000000010000d725	cmpl	$0x2, %r11d
000000010000d729	jne	0x10000d730
000000010000d72b	movl	%r10d, %r11d
000000010000d72e	jmp	0x10000d788
000000010000d730	movzbl	0x2(%rdi,%rax), %edx
000000010000d735	movl	%edx, %r9d
000000010000d738	andl	$-0x40, %r9d
000000010000d73c	cmpl	$0x80, %r9d
000000010000d743	jne	0x10000d7d1
000000010000d749	movl	%r10d, %r9d
000000010000d74c	shll	$0x6, %r9d
000000010000d750	andl	$0x3f, %edx
000000010000d753	orl	%r9d, %edx
000000010000d756	cmpl	$0x3, %r11d
000000010000d75a	jne	0x10000d764
000000010000d75c	movl	%edx, %r11d
000000010000d75f	movl	%r10d, %edx
000000010000d762	jmp	0x10000d788
000000010000d764	movzbl	0x3(%rdi,%rax), %r11d
000000010000d76a	movl	%r11d, %r9d
000000010000d76d	andl	$-0x40, %r9d
000000010000d771	cmpl	$0x80, %r9d
000000010000d778	jne	0x10000d7d1
000000010000d77a	movl	%edx, %r9d
000000010000d77d	shll	$0x6, %r9d
000000010000d781	andl	$0x3f, %r11d
000000010000d785	orl	%r9d, %r11d
000000010000d788	andl	$0x7fe0, %edx                   ## imm = 0x7FE0
000000010000d78e	cmpl	$0x360, %edx                    ## imm = 0x360
000000010000d794	je	0x10000d7d1
000000010000d796	cmpl	$0x10ffff, %r9d                 ## imm = 0x10FFFF
000000010000d79d	ja	0x10000d7d1
000000010000d79f	cmpl	%ecx, %r11d
000000010000d7a2	jb	0x10000d7d1
000000010000d7a4	addq	%r8, %rax
000000010000d7a7	incq	%rax
000000010000d7aa	cmpq	%rsi, %rax
000000010000d7ad	jb	0x10000d687
000000010000d7b3	callq	_fwp_str_new
000000010000d7b8	movq	%rax, %r15
000000010000d7bb	movq	%r14, %rdi
000000010000d7be	callq	0x1000111d2                     ## symbol stub for: _free
000000010000d7c3	movq	%r15, (%rbx)
000000010000d7c6	movl	$0x1, %r14d
000000010000d7cc	jmp	0x10000d646
000000010000d7d1	movq	%r14, %rdi
000000010000d7d4	callq	0x1000111d2                     ## symbol stub for: _free
000000010000d7d9	jmp	0x10000d45c
000000010000d7de	nop
000000010000d7e0	pushq	%rax
000000010000d7e1	std
000000010000d7e2	.byte 0xff #bad opcode
000000010000d7e3	lcalll	*-0x2(%rbp)
000000010000d7e6	.byte 0xff #bad opcode
000000010000d7e7	lcalll	*-0x2(%rbp)
000000010000d7ea	.byte 0xff #bad opcode
000000010000d7eb	lcalll	*-0x2(%rbp)
000000010000d7ee	.byte 0xff #bad opcode
000000010000d7ef	lcalll	*-0x2(%rbp)
000000010000d7f2	.byte 0xff #bad opcode
000000010000d7f3	lcalll	*-0x2(%rbp)
000000010000d7f6	.byte 0xff #bad opcode
000000010000d7f7	lcalll	*-0x2(%rbp)
000000010000d7fa	.byte 0xff #bad opcode
000000010000d7fb	lcalll	*-0x2(%rbp)
000000010000d7fe	.byte 0xff #bad opcode
000000010000d7ff	lcalll	*-0x2(%rbp)
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
000000010000d827	incl	0x5dfffffd(%rax)
000000010000d82d	.byte 0xfe #bad opcode
000000010000d82e	.byte 0xff #bad opcode
000000010000d82f	lcalll	*-0x2(%rbp)
000000010000d832	.byte 0xff #bad opcode
000000010000d833	lcalll	*-0x2(%rbp)
000000010000d836	.byte 0xff #bad opcode
000000010000d837	pushq	-0x3(%rdi)
000000010000d83a	.byte 0xff #bad opcode
000000010000d83b	lcalll	*-0x2(%rbp)
000000010000d83e	.byte 0xff #bad opcode
000000010000d83f	ljmpl	*-0x3(%rsi)
000000010000d842	.byte 0xff #bad opcode
000000010000d843	decl	0xffffffd(%rcx)
000000010000d849	.byte 0x1f #bad opcode
000000010000d84a	testb	%al, (%rax)
000000010000d84c	addb	%al, (%rax)
000000010000d84e	addb	%al, (%rax)
_tp_eat:
000000010000d850	pushq	%rbp
000000010000d851	movq	%rsp, %rbp
000000010000d854	pushq	%r15
000000010000d856	pushq	%r14
000000010000d858	pushq	%r13
000000010000d85a	pushq	%r12
000000010000d85c	pushq	%rbx
000000010000d85d	pushq	%rax
000000010000d85e	movq	%rsi, %r14
000000010000d861	movq	%rdi, %rbx
000000010000d864	movq	0x8(%rdi), %r13
000000010000d868	movq	0x10(%rdi), %r12
000000010000d86c	cmpq	%r13, %r12
000000010000d86f	jae	0x10000d8a0
000000010000d871	movq	(%rbx), %rax
000000010000d874	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000d87e	nop
000000010000d880	movzbl	(%rax,%r12), %edx
000000010000d885	cmpq	$0x20, %rdx
000000010000d889	ja	0x10000d8a0
000000010000d88b	btq	%rdx, %rcx
000000010000d88f	jae	0x10000d8a0
000000010000d891	incq	%r12
000000010000d894	movq	%r12, 0x10(%rbx)
000000010000d898	cmpq	%r12, %r13
000000010000d89b	jne	0x10000d880
000000010000d89d	movq	%r13, %r12
000000010000d8a0	movq	%r14, %rdi
000000010000d8a3	callq	0x100011286                     ## symbol stub for: _strlen
000000010000d8a8	subq	%r12, %r13
000000010000d8ab	xorl	%r15d, %r15d
000000010000d8ae	cmpq	%rax, %r13
000000010000d8b1	jb	0x10000d8d8
000000010000d8b3	movq	(%rbx), %rdi
000000010000d8b6	addq	%r12, %rdi
000000010000d8b9	movq	%r14, %rsi
000000010000d8bc	movq	%rax, %r14
000000010000d8bf	movq	%rax, %rdx
000000010000d8c2	callq	0x100011202                     ## symbol stub for: _memcmp
000000010000d8c7	testl	%eax, %eax
000000010000d8c9	jne	0x10000d8d8
000000010000d8cb	addq	%r14, %r12
000000010000d8ce	movq	%r12, 0x10(%rbx)
000000010000d8d2	movl	$0x1, %r15d
000000010000d8d8	movl	%r15d, %eax
000000010000d8db	addq	$0x8, %rsp
000000010000d8df	popq	%rbx
000000010000d8e0	popq	%r12
000000010000d8e2	popq	%r13
000000010000d8e4	popq	%r14
000000010000d8e6	popq	%r15
000000010000d8e8	popq	%rbp
000000010000d8e9	retq
000000010000d8ea	nopw	(%rax,%rax)
_tp_list_of:
000000010000d8f0	pushq	%rbp
000000010000d8f1	movq	%rsp, %rbp
000000010000d8f4	pushq	%r15
000000010000d8f6	pushq	%r14
000000010000d8f8	pushq	%r13
000000010000d8fa	pushq	%r12
000000010000d8fc	pushq	%rbx
000000010000d8fd	subq	$0x28, %rsp
000000010000d901	movq	%r8, %r15
000000010000d904	movq	%rcx, -0x40(%rbp)
000000010000d908	movq	%rsi, %r8
000000010000d90b	movq	%rdi, %rbx
000000010000d90e	movq	0x8(%rdi), %r12
000000010000d912	movq	0x10(%rdi), %r13
000000010000d916	cmpq	%r12, %r13
000000010000d919	movq	%rdx, -0x30(%rbp)
000000010000d91d	jae	0x10000d950
000000010000d91f	movq	(%rbx), %rax
000000010000d922	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000d92c	nopl	(%rax)
000000010000d930	movzbl	(%rax,%r13), %esi
000000010000d935	cmpq	$0x20, %rsi
000000010000d939	ja	0x10000d950
000000010000d93b	btq	%rsi, %rcx
000000010000d93f	jae	0x10000d950
000000010000d941	incq	%r13
000000010000d944	movq	%r13, 0x10(%rbx)
000000010000d948	cmpq	%r13, %r12
000000010000d94b	jne	0x10000d930
000000010000d94d	movq	%r12, %r13
000000010000d950	movq	%r8, %rdi
000000010000d953	movq	%r8, -0x48(%rbp)
000000010000d957	callq	0x100011286                     ## symbol stub for: _strlen
000000010000d95c	movq	%rax, %r14
000000010000d95f	movq	%r12, %rcx
000000010000d962	subq	%r13, %rcx
000000010000d965	xorl	%eax, %eax
000000010000d967	cmpq	%r14, %rcx
000000010000d96a	jb	0x10000d989
000000010000d96c	movq	%r15, -0x38(%rbp)
000000010000d970	movq	(%rbx), %r15
000000010000d973	leaq	(%r15,%r13), %rdi
000000010000d977	movq	-0x48(%rbp), %rsi
000000010000d97b	movq	%r14, %rdx
000000010000d97e	callq	0x100011202                     ## symbol stub for: _memcmp
000000010000d983	testl	%eax, %eax
000000010000d985	je	0x10000d998
000000010000d987	xorl	%eax, %eax
000000010000d989	addq	$0x28, %rsp
000000010000d98d	popq	%rbx
000000010000d98e	popq	%r12
000000010000d990	popq	%r13
000000010000d992	popq	%r14
000000010000d994	popq	%r15
000000010000d996	popq	%rbp
000000010000d997	retq
000000010000d998	addq	%r13, %r14
000000010000d99b	movq	%r14, 0x10(%rbx)
000000010000d99f	movabsq	$0x100002600, %r13              ## imm = 0x100002600
000000010000d9a9	cmpq	%r12, %r14
000000010000d9ac	jae	0x10000d9e2
000000010000d9ae	movq	-0x30(%rbp), %rdi
000000010000d9b2	nopw	%cs:(%rax,%rax)
000000010000d9c0	movzbl	(%r15,%r14), %eax
000000010000d9c5	cmpq	$0x20, %rax
000000010000d9c9	ja	0x10000d9e6
000000010000d9cb	btq	%rax, %r13
000000010000d9cf	jae	0x10000d9e6
000000010000d9d1	incq	%r14
000000010000d9d4	movq	%r14, 0x10(%rbx)
000000010000d9d8	cmpq	%r14, %r12
000000010000d9db	jne	0x10000d9c0
000000010000d9dd	movq	%r12, %r14
000000010000d9e0	jmp	0x10000d9e6
000000010000d9e2	movq	-0x30(%rbp), %rdi
000000010000d9e6	callq	0x100011286                     ## symbol stub for: _strlen
000000010000d9eb	subq	%r14, %r12
000000010000d9ee	cmpq	%rax, %r12
000000010000d9f1	jb	0x10000da10
000000010000d9f3	addq	%r14, %r15
000000010000d9f6	movq	%r15, %rdi
000000010000d9f9	movq	-0x30(%rbp), %rsi
000000010000d9fd	movq	%rax, %r12
000000010000da00	movq	%rax, %rdx
000000010000da03	callq	0x100011202                     ## symbol stub for: _memcmp
000000010000da08	testl	%eax, %eax
000000010000da0a	je	0x10000daea
000000010000da10	movq	%rbx, %rdi
000000010000da13	movq	-0x38(%rbp), %rsi
000000010000da17	callq	*-0x40(%rbp)
000000010000da1a	testl	%eax, %eax
000000010000da1c	je	0x10000d987
000000010000da22	movq	0x8(%rbx), %r15
000000010000da26	movq	0x10(%rbx), %r14
000000010000da2a	cmpq	%r15, %r14
000000010000da2d	jae	0x10000da62
000000010000da2f	movq	(%rbx), %rax
000000010000da32	movq	-0x30(%rbp), %r12
000000010000da36	nopw	%cs:(%rax,%rax)
000000010000da40	movzbl	(%rax,%r14), %ecx
000000010000da45	cmpq	$0x20, %rcx
000000010000da49	ja	0x10000da66
000000010000da4b	btq	%rcx, %r13
000000010000da4f	jae	0x10000da66
000000010000da51	incq	%r14
000000010000da54	movq	%r14, 0x10(%rbx)
000000010000da58	cmpq	%r14, %r15
000000010000da5b	jne	0x10000da40
000000010000da5d	movq	%r15, %r14
000000010000da60	jmp	0x10000da66
000000010000da62	movq	-0x30(%rbp), %r12
000000010000da66	movq	%r12, %rdi
000000010000da69	callq	0x100011286                     ## symbol stub for: _strlen
000000010000da6e	movq	%r15, %rcx
000000010000da71	subq	%r14, %rcx
000000010000da74	cmpq	%rax, %rcx
000000010000da77	jb	0x10000da91
000000010000da79	movq	(%rbx), %rdi
000000010000da7c	addq	%r14, %rdi
000000010000da7f	movq	%r12, %rsi
000000010000da82	movq	%rax, %r12
000000010000da85	movq	%rax, %rdx
000000010000da88	callq	0x100011202                     ## symbol stub for: _memcmp
000000010000da8d	testl	%eax, %eax
000000010000da8f	je	0x10000daea
000000010000da91	cmpq	%r14, %r15
000000010000da94	jbe	0x10000dac2
000000010000da96	movq	(%rbx), %rax
000000010000da99	nopl	(%rax)
000000010000daa0	movzbl	(%rax,%r14), %ecx
000000010000daa5	cmpq	$0x20, %rcx
000000010000daa9	ja	0x10000dac2
000000010000daab	btq	%rcx, %r13
000000010000daaf	jae	0x10000dac2
000000010000dab1	incq	%r14
000000010000dab4	movq	%r14, 0x10(%rbx)
000000010000dab8	cmpq	%r14, %r15
000000010000dabb	jne	0x10000daa0
000000010000dabd	jmp	0x10000d987
000000010000dac2	cmpq	%r14, %r15
000000010000dac5	movl	$0x0, %eax
000000010000daca	je	0x10000d989
000000010000dad0	movq	(%rbx), %rcx
000000010000dad3	cmpb	$0x2c, (%rcx,%r14)
000000010000dad8	jne	0x10000d989
000000010000dade	incq	%r14
000000010000dae1	movq	%r14, 0x10(%rbx)
000000010000dae5	jmp	0x10000da10
000000010000daea	addq	%r14, %r12
000000010000daed	movq	%r12, 0x10(%rbx)
000000010000daf1	movl	$0x1, %eax
000000010000daf6	jmp	0x10000d989
000000010000dafb	nopl	(%rax,%rax)
_tp_byte_item:
000000010000db00	pushq	%rbp
000000010000db01	movq	%rsp, %rbp
000000010000db04	pushq	%rbx
000000010000db05	pushq	%rax
000000010000db06	movq	%rsi, %rbx
000000010000db09	leaq	_tp_byte_item.u8d(%rip), %rsi
000000010000db10	leaq	-0x10(%rbp), %rdx
000000010000db14	callq	_tp_int
000000010000db19	testl	%eax, %eax
000000010000db1b	je	0x10000db30
000000010000db1d	movq	-0x10(%rbp), %rsi
000000010000db21	movq	%rbx, %rdi
000000010000db24	callq	_tp_push
000000010000db29	movl	$0x1, %eax
000000010000db2e	jmp	0x10000db32
000000010000db30	xorl	%eax, %eax
000000010000db32	addq	$0x8, %rsp
000000010000db36	popq	%rbx
000000010000db37	popq	%rbp
000000010000db38	retq
000000010000db39	nopl	(%rax)
_tp_token:
000000010000db40	pushq	%rbp
000000010000db41	movq	%rsp, %rbp
000000010000db44	pushq	%r15
000000010000db46	pushq	%r14
000000010000db48	pushq	%r12
000000010000db4a	pushq	%rbx
000000010000db4b	movq	%rsi, %r14
000000010000db4e	movq	%rdi, %rbx
000000010000db51	movq	(%rdi), %rsi
000000010000db54	movq	0x8(%rdi), %rax
000000010000db58	movq	0x10(%rdi), %r12
000000010000db5c	cmpq	%rax, %r12
000000010000db5f	jae	0x10000db95
000000010000db61	movabsq	$0x100002600, %rcx              ## imm = 0x100002600
000000010000db6b	nopl	(%rax,%rax)
000000010000db70	movzbl	(%rsi,%r12), %edi
000000010000db75	cmpq	$0x20, %rdi
000000010000db79	ja	0x10000db95
000000010000db7b	btq	%rdi, %rcx
000000010000db7f	jae	0x10000db95
000000010000db81	incq	%r12
000000010000db84	movq	%r12, 0x10(%rbx)
000000010000db88	cmpq	%r12, %rax
000000010000db8b	jne	0x10000db70
000000010000db8d	movq	%rax, %r12
000000010000db90	movq	%rax, %rcx
000000010000db93	jmp	0x10000dbde
000000010000db95	cmpq	%rax, %r12
000000010000db98	jae	0x10000dbdb
000000010000db9a	leaq	0x6f(%rip), %rdi
000000010000dba1	movq	%r12, %rcx
000000010000dba4	jmp	0x10000dbc2
000000010000dba6	nopw	%cs:(%rax,%rax)
000000010000dbb0	cmpl	$0x7d, %r8d
000000010000dbb4	je	0x10000dbde
000000010000dbb6	incq	%rcx
000000010000dbb9	movq	%rcx, 0x10(%rbx)
000000010000dbbd	cmpq	%rcx, %rax
000000010000dbc0	je	0x10000db90
000000010000dbc2	movzbl	(%rsi,%rcx), %r8d
000000010000dbc7	leal	-0x9(%r8), %r9d
000000010000dbcb	cmpl	$0x54, %r9d
000000010000dbcf	ja	0x10000dbb0
000000010000dbd1	movslq	(%rdi,%r9,4), %r8
000000010000dbd5	addq	%rdi, %r8
000000010000dbd8	jmpq	*%r8
000000010000dbdb	movq	%r12, %rcx
000000010000dbde	subq	%r12, %rcx
000000010000dbe1	leaq	-0x1(%rdx), %r15
000000010000dbe5	cmpq	%rdx, %rcx
000000010000dbe8	cmovbq	%rcx, %r15
000000010000dbec	addq	%r12, %rsi
000000010000dbef	movq	%r14, %rdi
000000010000dbf2	movq	%r15, %rdx
000000010000dbf5	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000dbfa	movb	$0x0, (%r14,%r15)
000000010000dbff	movq	0x10(%rbx), %rax
000000010000dc03	subq	%r12, %rax
000000010000dc06	popq	%rbx
000000010000dc07	popq	%r12
000000010000dc09	popq	%r14
000000010000dc0b	popq	%r15
000000010000dc0d	popq	%rbp
000000010000dc0e	retq
000000010000dc0f	nop
000000010000dc10	.byte 0xce #bad opcode
000000010000dc11	.byte 0xff #bad opcode
000000010000dc12	.byte 0xff #bad opcode
000000010000dc13	decl	%esi
000000010000dc15	.byte 0xff #bad opcode
000000010000dc16	.byte 0xff #bad opcode
000000010000dc17	jmpq	*-0x59000001(%rsi)
000000010000dc1d	.byte 0xff #bad opcode
000000010000dc1e	.byte 0xff #bad opcode
000000010000dc1f	decl	%esi
000000010000dc21	.byte 0xff #bad opcode
000000010000dc22	.byte 0xff #bad opcode
000000010000dc23	jmpq	*-0x59000001(%rsi)
000000010000dc29	.byte 0xff #bad opcode
000000010000dc2a	.byte 0xff #bad opcode
000000010000dc2b	jmpq	*-0x59000001(%rsi)
000000010000dc31	.byte 0xff #bad opcode
000000010000dc32	.byte 0xff #bad opcode
000000010000dc33	jmpq	*-0x59000001(%rsi)
000000010000dc39	.byte 0xff #bad opcode
000000010000dc3a	.byte 0xff #bad opcode
000000010000dc3b	jmpq	*-0x59000001(%rsi)
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
000000010000dc6b	decl	%esi
000000010000dc6d	.byte 0xff #bad opcode
000000010000dc6e	.byte 0xff #bad opcode
000000010000dc6f	jmpq	*-0x59000001(%rsi)
000000010000dc75	.byte 0xff #bad opcode
000000010000dc76	.byte 0xff #bad opcode
000000010000dc77	jmpq	*-0x59000001(%rsi)
000000010000dc7d	.byte 0xff #bad opcode
000000010000dc7e	.byte 0xff #bad opcode
000000010000dc7f	jmpq	*-0x59000001(%rsi)
000000010000dc85	.byte 0xff #bad opcode
000000010000dc86	.byte 0xff #bad opcode
000000010000dc87	jmpq	*-0x31000001(%rsi)
000000010000dc8d	.byte 0xff #bad opcode
000000010000dc8e	.byte 0xff #bad opcode
000000010000dc8f	decl	%esi
000000010000dc91	.byte 0xff #bad opcode
000000010000dc92	.byte 0xff #bad opcode
000000010000dc93	jmpq	*-0x59000001(%rsi)
000000010000dc99	.byte 0xff #bad opcode
000000010000dc9a	.byte 0xff #bad opcode
000000010000dc9b	decl	%esi
000000010000dc9d	.byte 0xff #bad opcode
000000010000dc9e	.byte 0xff #bad opcode
000000010000dc9f	jmpq	*-0x59000001(%rsi)
000000010000dca5	.byte 0xff #bad opcode
000000010000dca6	.byte 0xff #bad opcode
000000010000dca7	jmpq	*-0x59000001(%rsi)
000000010000dcad	.byte 0xff #bad opcode
000000010000dcae	.byte 0xff #bad opcode
000000010000dcaf	jmpq	*-0x59000001(%rsi)
000000010000dcb5	.byte 0xff #bad opcode
000000010000dcb6	.byte 0xff #bad opcode
000000010000dcb7	jmpq	*-0x59000001(%rsi)
000000010000dcbd	.byte 0xff #bad opcode
000000010000dcbe	.byte 0xff #bad opcode
000000010000dcbf	jmpq	*-0x59000001(%rsi)
000000010000dcc5	.byte 0xff #bad opcode
000000010000dcc6	.byte 0xff #bad opcode
000000010000dcc7	jmpq	*-0x59000001(%rsi)
000000010000dccd	.byte 0xff #bad opcode
000000010000dcce	.byte 0xff #bad opcode
000000010000dccf	jmpq	*-0x31000001(%rsi)
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
000000010000dcef	jmpq	*-0x59000001(%rsi)
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
000000010000dd5f	decl	%esi
000000010000dd61	.byte 0xff #bad opcode
000000010000dd62	.byte 0xff #bad opcode
000000010000dd63	jmpq	*0x66(%rsi)
000000010000dd66	nopw	%cs:(%rax,%rax)
_tp_elem_item:
000000010000dd70	pushq	%rbp
000000010000dd71	movq	%rsp, %rbp
000000010000dd74	pushq	%r14
000000010000dd76	pushq	%rbx
000000010000dd77	subq	$0x10, %rsp
000000010000dd7b	movq	%rsi, %rbx
000000010000dd7e	movq	(%rsi), %rsi
000000010000dd81	xorl	%r14d, %r14d
000000010000dd84	leaq	-0x18(%rbp), %rcx
000000010000dd88	xorl	%edx, %edx
000000010000dd8a	callq	_tp_value
000000010000dd8f	testl	%eax, %eax
000000010000dd91	je	0x10000dda5
000000010000dd93	movq	-0x18(%rbp), %rsi
000000010000dd97	movq	%rbx, %rdi
000000010000dd9a	callq	_tp_push
000000010000dd9f	movl	$0x1, %r14d
000000010000dda5	movl	%r14d, %eax
000000010000dda8	addq	$0x10, %rsp
000000010000ddac	popq	%rbx
000000010000ddad	popq	%r14
000000010000ddaf	popq	%rbp
000000010000ddb0	retq
000000010000ddb1	nopw	%cs:(%rax,%rax)
_tp_kv_item:
000000010000ddc0	pushq	%rbp
000000010000ddc1	movq	%rsp, %rbp
000000010000ddc4	pushq	%r15
000000010000ddc6	pushq	%r14
000000010000ddc8	pushq	%rbx
000000010000ddc9	subq	$0x18, %rsp
000000010000ddcd	movq	%rsi, %rbx
000000010000ddd0	movq	%rdi, %r14
000000010000ddd3	movq	$0x0, -0x20(%rbp)
000000010000dddb	movq	(%rsi), %rsi
000000010000ddde	xorl	%r15d, %r15d
000000010000dde1	leaq	-0x28(%rbp), %rcx
000000010000dde5	xorl	%edx, %edx
000000010000dde7	callq	_tp_value
000000010000ddec	testl	%eax, %eax
000000010000ddee	je	0x10000de16
000000010000ddf0	cmpl	$0x0, 0x28(%rbx)
000000010000ddf4	je	0x10000de24
000000010000ddf6	xorl	%r14d, %r14d
000000010000ddf9	movq	-0x28(%rbp), %rsi
000000010000ddfd	movq	%rbx, %rdi
000000010000de00	callq	_tp_push
000000010000de05	movq	%rbx, %rdi
000000010000de08	movq	%r14, %rsi
000000010000de0b	callq	_tp_push
000000010000de10	movl	$0x1, %r15d
000000010000de16	movl	%r15d, %eax
000000010000de19	addq	$0x18, %rsp
000000010000de1d	popq	%rbx
000000010000de1e	popq	%r14
000000010000de20	popq	%r15
000000010000de22	popq	%rbp
000000010000de23	retq
000000010000de24	movq	0x8(%r14), %rcx
000000010000de28	movq	0x10(%r14), %rax
000000010000de2c	cmpq	%rcx, %rax
000000010000de2f	jae	0x10000de61
000000010000de31	movq	(%r14), %rdx
000000010000de34	movabsq	$0x100002600, %rsi              ## imm = 0x100002600
000000010000de3e	nop
000000010000de40	movzbl	(%rdx,%rax), %edi
000000010000de44	cmpq	$0x20, %rdi
000000010000de48	ja	0x10000de61
000000010000de4a	btq	%rdi, %rsi
000000010000de4e	jae	0x10000de61
000000010000de50	incq	%rax
000000010000de53	movq	%rax, 0x10(%r14)
000000010000de57	cmpq	%rax, %rcx
000000010000de5a	jne	0x10000de40
000000010000de5c	xorl	%r15d, %r15d
000000010000de5f	jmp	0x10000de16
000000010000de61	xorl	%r15d, %r15d
000000010000de64	cmpq	%rax, %rcx
000000010000de67	je	0x10000de16
000000010000de69	movq	(%r14), %rcx
000000010000de6c	cmpb	$0x3a, (%rcx,%rax)
000000010000de70	jne	0x10000de16
000000010000de72	incq	%rax
000000010000de75	movq	%rax, 0x10(%r14)
000000010000de79	movq	0x8(%rbx), %rsi
000000010000de7d	xorl	%r15d, %r15d
000000010000de80	leaq	-0x20(%rbp), %rcx
000000010000de84	movq	%r14, %rdi
000000010000de87	xorl	%edx, %edx
000000010000de89	callq	_tp_value
000000010000de8e	testl	%eax, %eax
000000010000de90	je	0x10000de16
000000010000de92	movq	-0x20(%rbp), %r14
000000010000de96	jmp	0x10000ddf9
000000010000de9b	nopl	(%rax,%rax)
_fwp_p_map_insert:
000000010000dea0	pushq	%rbp
000000010000dea1	movq	%rsp, %rbp
000000010000dea4	pushq	%r15
000000010000dea6	pushq	%r14
000000010000dea8	pushq	%r13
000000010000deaa	pushq	%r12
000000010000deac	pushq	%rbx
000000010000dead	subq	$0x38, %rsp
000000010000deb1	movq	%rdi, %r8
000000010000deb4	movq	(%rdx), %r12
000000010000deb7	movq	%rcx, -0x58(%rbp)
000000010000debb	movl	(%rcx), %eax
000000010000debd	cmpl	$0x4, %eax
000000010000dec0	movq	%rsi, -0x40(%rbp)
000000010000dec4	jb	0x10000df28
000000010000dec6	addl	$-0x5, %eax
000000010000dec9	cmpl	$0x4, %eax
000000010000decc	jae	0x10000df8d
000000010000ded2	testq	%r12, %r12
000000010000ded5	je	0x10000e002
000000010000dedb	xorl	%r15d, %r15d
000000010000dede	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000dee8	movq	%r12, %rcx
000000010000deeb	jmp	0x10000defc
000000010000deed	nopl	(%rax)
000000010000def0	movq	%rdi, %rcx
000000010000def3	cmpq	%rcx, %r15
000000010000def6	jae	0x10000e007
000000010000defc	leaq	(%rcx,%r15), %rsi
000000010000df00	movq	%rsi, %rdi
000000010000df03	shrq	%rdi
000000010000df06	andq	%rax, %rsi
000000010000df09	movq	0x8(%rdx,%rsi,8), %rsi
000000010000df0e	cmpq	%r8, %rsi
000000010000df11	setne	%bl
000000010000df14	je	0x10000df88
000000010000df16	jae	0x10000def0
000000010000df18	incq	%rdi
000000010000df1b	movq	%rdi, %r15
000000010000df1e	cmpq	%rcx, %r15
000000010000df21	jb	0x10000defc
000000010000df23	jmp	0x10000e007
000000010000df28	testq	%r12, %r12
000000010000df2b	je	0x10000e002
000000010000df31	xorl	%r15d, %r15d
000000010000df34	movabsq	$0x1ffffffffffffffe, %rax       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000df3e	movq	%r12, %rcx
000000010000df41	jmp	0x10000df5c
000000010000df43	nopw	%cs:(%rax,%rax)
000000010000df50	movq	%rdi, %rcx
000000010000df53	cmpq	%rcx, %r15
000000010000df56	jae	0x10000e007
000000010000df5c	leaq	(%rcx,%r15), %rsi
000000010000df60	movq	%rsi, %rdi
000000010000df63	shrq	%rdi
000000010000df66	andq	%rax, %rsi
000000010000df69	movq	0x8(%rdx,%rsi,8), %rsi
000000010000df6e	cmpq	%r8, %rsi
000000010000df71	setne	%bl
000000010000df74	je	0x10000df88
000000010000df76	jge	0x10000df50
000000010000df78	incq	%rdi
000000010000df7b	movq	%rdi, %r15
000000010000df7e	cmpq	%rcx, %r15
000000010000df81	jb	0x10000df5c
000000010000df83	jmp	0x10000e007
000000010000df88	movq	%rdi, %r15
000000010000df8b	jmp	0x10000e007
000000010000df8d	testq	%r12, %r12
000000010000df90	je	0x10000e002
000000010000df92	xorl	%r15d, %r15d
000000010000df95	movq	%r12, %rax
000000010000df98	movq	%r12, -0x38(%rbp)
000000010000df9c	jmp	0x10000dfb2
000000010000df9e	nop
000000010000dfa0	movq	%r12, %rax
000000010000dfa3	movq	%r14, %rdx
000000010000dfa6	movq	%r13, %r8
000000010000dfa9	cmpq	%rax, %r15
000000010000dfac	movq	-0x38(%rbp), %r12
000000010000dfb0	jae	0x10000e007
000000010000dfb2	movq	%rax, -0x50(%rbp)
000000010000dfb6	addq	%r15, %rax
000000010000dfb9	movq	%rax, %r12
000000010000dfbc	shrq	%r12
000000010000dfbf	movabsq	$0x1ffffffffffffffe, %rcx       ## imm = 0x1FFFFFFFFFFFFFFE
000000010000dfc9	andq	%rcx, %rax
000000010000dfcc	movq	%rdx, %r14
000000010000dfcf	movq	0x8(%rdx,%rax,8), %rdi
000000010000dfd4	movq	%r8, %r13
000000010000dfd7	movq	%r8, %rsi
000000010000dfda	movq	-0x58(%rbp), %rdx
000000010000dfde	callq	_fwp_cmp
000000010000dfe3	testl	%eax, %eax
000000010000dfe5	setne	%bl
000000010000dfe8	je	0x10000e12b
000000010000dfee	jns	0x10000dfa0
000000010000dff0	incq	%r12
000000010000dff3	movq	%r12, %r15
000000010000dff6	movq	%r14, %rdx
000000010000dff9	movq	%r13, %r8
000000010000dffc	movq	-0x50(%rbp), %rax
000000010000e000	jmp	0x10000dfa9
000000010000e002	movb	$0x1, %bl
000000010000e004	xorl	%r15d, %r15d
000000010000e007	movzbl	%bl, %r14d
000000010000e00b	addq	%r12, %r14
000000010000e00e	movq	%r14, %rax
000000010000e011	shlq	$0x4, %rax
000000010000e015	leaq	0x8(%rax), %rdi
000000010000e019	cmpq	$0x4000, %rdi                   ## imm = 0x4000
000000010000e020	movq	%rdx, -0x30(%rbp)
000000010000e024	movq	%r8, -0x48(%rbp)
000000010000e028	ja	0x10000e083
000000010000e02a	addq	$0x17, %rax
000000010000e02e	shrq	$0x4, %rax
000000010000e032	leaq	_fwp_gc(%rip), %rcx
000000010000e039	movzbl	0xbe8(%rax,%rcx), %eax
000000010000e041	movl	0xb48(%rcx,%rax,4), %esi
000000010000e048	subq	%rsi, _fwp_gc(%rip)
000000010000e04f	js	0x10000e083
000000010000e051	leaq	(%rax,%rax,2), %rax
000000010000e055	leaq	(%rcx,%rax,8), %rax
000000010000e059	addq	$0x788, %rax                    ## imm = 0x788
000000010000e05f	movq	(%rax), %r13
000000010000e062	testq	%r13, %r13
000000010000e065	je	0x10000e073
000000010000e067	movq	(%r13), %rcx
000000010000e06b	notq	%rcx
000000010000e06e	movq	%rcx, (%rax)
000000010000e071	jmp	0x10000e09a
000000010000e073	movq	0x8(%rax), %r13
000000010000e077	movq	0x10(%rax), %rcx
000000010000e07b	subq	%r13, %rcx
000000010000e07e	cmpq	%rsi, %rcx
000000010000e081	jae	0x10000e092
000000010000e083	movl	$0x2, %esi
000000010000e088	callq	_fwp_gc_alloc_slow
000000010000e08d	movq	%rax, %r13
000000010000e090	jmp	0x10000e0a2
000000010000e092	leaq	(%rsi,%r13), %rcx
000000010000e096	movq	%rcx, 0x8(%rax)
000000010000e09a	movq	%r13, %rdi
000000010000e09d	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000e0a2	movq	%r14, (%r13)
000000010000e0a6	leaq	0x8(%r13), %r14
000000010000e0aa	movq	-0x30(%rbp), %rsi
000000010000e0ae	addq	$0x8, %rsi
000000010000e0b2	testb	%bl, %bl
000000010000e0b4	je	0x10000e0fd
000000010000e0b6	movq	%r15, %rbx
000000010000e0b9	shlq	$0x4, %rbx
000000010000e0bd	movq	%r14, %rdi
000000010000e0c0	movq	%rbx, %rdx
000000010000e0c3	movq	%rsi, -0x30(%rbp)
000000010000e0c7	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000e0cc	movq	-0x48(%rbp), %rax
000000010000e0d0	movq	%rax, (%r14,%rbx)
000000010000e0d4	movq	-0x40(%rbp), %rax
000000010000e0d8	movq	%rax, 0x8(%r14,%rbx)
000000010000e0dd	leaq	(%r14,%rbx), %rdi
000000010000e0e1	addq	$0x10, %rdi
000000010000e0e5	addq	-0x30(%rbp), %rbx
000000010000e0e9	subq	%r15, %r12
000000010000e0ec	shlq	$0x4, %r12
000000010000e0f0	movq	%rbx, %rsi
000000010000e0f3	movq	%r12, %rdx
000000010000e0f6	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000e0fb	jmp	0x10000e119
000000010000e0fd	shlq	$0x4, %r12
000000010000e101	movq	%r14, %rdi
000000010000e104	movq	%r12, %rdx
000000010000e107	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000e10c	shlq	$0x4, %r15
000000010000e110	movq	-0x40(%rbp), %rax
000000010000e114	movq	%rax, 0x8(%r14,%r15)
000000010000e119	movq	%r13, %rax
000000010000e11c	addq	$0x38, %rsp
000000010000e120	popq	%rbx
000000010000e121	popq	%r12
000000010000e123	popq	%r13
000000010000e125	popq	%r14
000000010000e127	popq	%r15
000000010000e129	popq	%rbp
000000010000e12a	retq
000000010000e12b	movq	%r12, %r15
000000010000e12e	movq	-0x38(%rbp), %r12
000000010000e132	movq	%r14, %rdx
000000010000e135	movq	%r13, %r8
000000010000e138	jmp	0x10000e007
000000010000e13d	nopl	(%rax)
_fwp_box_u128:
000000010000e140	pushq	%rbp
000000010000e141	movq	%rsp, %rbp
000000010000e144	pushq	%r14
000000010000e146	pushq	%rbx
000000010000e147	leaq	_fwp_gc(%rip), %rax
000000010000e14e	movzbl	0x6a9c(%rip), %edx
000000010000e155	movl	0xb48(%rax,%rdx,4), %ecx
000000010000e15c	subq	%rcx, _fwp_gc(%rip)
000000010000e163	js	0x10000e197
000000010000e165	leaq	(%rdx,%rdx,2), %rdx
000000010000e169	leaq	(%rax,%rdx,8), %rdx
000000010000e16d	addq	$0x3c8, %rdx                    ## imm = 0x3C8
000000010000e174	movq	(%rdx), %rax
000000010000e177	testq	%rax, %rax
000000010000e17a	je	0x10000e187
000000010000e17c	movq	(%rax), %rcx
000000010000e17f	notq	%rcx
000000010000e182	movq	%rcx, (%rdx)
000000010000e185	jmp	0x10000e1bb
000000010000e187	movq	0x8(%rdx), %rax
000000010000e18b	movq	0x10(%rdx), %r8
000000010000e18f	subq	%rax, %r8
000000010000e192	cmpq	%rcx, %r8
000000010000e195	jae	0x10000e1b4
000000010000e197	movq	%rdi, %rbx
000000010000e19a	movl	$0x10, %edi
000000010000e19f	movq	%rsi, %r14
000000010000e1a2	movl	$0x1, %esi
000000010000e1a7	callq	_fwp_gc_alloc_slow
000000010000e1ac	movq	%r14, %rsi
000000010000e1af	movq	%rbx, %rdi
000000010000e1b2	jmp	0x10000e1c1
000000010000e1b4	addq	%rax, %rcx
000000010000e1b7	movq	%rcx, 0x8(%rdx)
000000010000e1bb	xorps	%xmm0, %xmm0
000000010000e1be	movups	%xmm0, (%rax)
000000010000e1c1	movq	%rsi, 0x8(%rax)
000000010000e1c5	movq	%rdi, (%rax)
000000010000e1c8	popq	%rbx
000000010000e1c9	popq	%r14
000000010000e1cb	popq	%rbp
000000010000e1cc	retq
000000010000e1cd	nopl	(%rax)
_fwp_utf8_put:
000000010000e1d0	pushq	%rbp
000000010000e1d1	movq	%rsp, %rbp
000000010000e1d4	subq	$0x10, %rsp
000000010000e1d8	cmpl	$0x7f, %esi
000000010000e1db	ja	0x10000e1eb
000000010000e1dd	movb	%sil, -0x4(%rbp)
000000010000e1e1	movl	$0x1, %edx
000000010000e1e6	jmp	0x10000e288
000000010000e1eb	movl	%esi, %eax
000000010000e1ed	cmpl	$0x7ff, %esi                    ## imm = 0x7FF
000000010000e1f3	ja	0x10000e210
000000010000e1f5	shrl	$0x6, %eax
000000010000e1f8	orb	$-0x40, %al
000000010000e1fa	movb	%al, -0x4(%rbp)
000000010000e1fd	andb	$0x3f, %sil
000000010000e201	orb	$-0x80, %sil
000000010000e205	movb	%sil, -0x3(%rbp)
000000010000e209	movl	$0x2, %edx
000000010000e20e	jmp	0x10000e288
000000010000e210	cmpl	$0xffff, %esi                   ## imm = 0xFFFF
000000010000e216	ja	0x10000e23f
000000010000e218	shrl	$0xc, %eax
000000010000e21b	orb	$-0x20, %al
000000010000e21d	movb	%al, -0x4(%rbp)
000000010000e220	movl	%esi, %eax
000000010000e222	shrl	$0x6, %eax
000000010000e225	andb	$0x3f, %al
000000010000e227	orb	$-0x80, %al
000000010000e229	movb	%al, -0x3(%rbp)
000000010000e22c	andb	$0x3f, %sil
000000010000e230	orb	$-0x80, %sil
000000010000e234	movb	%sil, -0x2(%rbp)
000000010000e238	movl	$0x3, %edx
000000010000e23d	jmp	0x10000e288
000000010000e23f	shrl	$0x12, %eax
000000010000e242	movl	%esi, %ecx
000000010000e244	shrl	$0xc, %ecx
000000010000e247	andb	$0x3f, %cl
000000010000e24a	movl	%esi, %edx
000000010000e24c	shrl	$0x6, %edx
000000010000e24f	movd	%eax, %xmm0
000000010000e253	movzbl	%cl, %eax
000000010000e256	pinsrb	$0x1, %eax, %xmm0
000000010000e25c	andb	$0x3f, %dl
000000010000e25f	movzbl	%dl, %eax
000000010000e262	pinsrb	$0x2, %eax, %xmm0
000000010000e268	andb	$0x3f, %sil
000000010000e26c	movzbl	%sil, %eax
000000010000e270	pinsrb	$0x3, %eax, %xmm0
000000010000e276	por	0x3152(%rip), %xmm0
000000010000e27e	movd	%xmm0, -0x4(%rbp)
000000010000e283	movl	$0x4, %edx
000000010000e288	leaq	-0x4(%rbp), %rsi
000000010000e28c	callq	_buf_put
000000010000e291	addq	$0x10, %rsp
000000010000e295	popq	%rbp
000000010000e296	retq
000000010000e297	nopw	(%rax,%rax)
_tp_push:
000000010000e2a0	pushq	%rbp
000000010000e2a1	movq	%rsp, %rbp
000000010000e2a4	pushq	%r15
000000010000e2a6	pushq	%r14
000000010000e2a8	pushq	%r13
000000010000e2aa	pushq	%r12
000000010000e2ac	pushq	%rbx
000000010000e2ad	pushq	%rax
000000010000e2ae	movq	%rsi, %rdx
000000010000e2b1	movq	%rdi, %r14
000000010000e2b4	movq	0x18(%rdi), %r15
000000010000e2b8	cmpq	0x20(%rdi), %r15
000000010000e2bc	jne	0x10000e32f
000000010000e2be	leaq	(%r15,%r15), %rax
000000010000e2c2	testq	%r15, %r15
000000010000e2c5	movl	$0x8, %r13d
000000010000e2cb	cmovneq	%rax, %r13
000000010000e2cf	movq	%r13, 0x20(%r14)
000000010000e2d3	movq	0x10(%r14), %r12
000000010000e2d7	shlq	$0x3, %r13
000000010000e2db	cmpq	$0x4000, %r13                   ## imm = 0x4000
000000010000e2e2	movq	%rdx, -0x30(%rbp)
000000010000e2e6	ja	0x10000e345
000000010000e2e8	movq	%r13, %rcx
000000010000e2eb	shrq	$0x4, %rcx
000000010000e2ef	leaq	_fwp_gc(%rip), %rax
000000010000e2f6	movzbl	0xbe8(%rcx,%rax), %ecx
000000010000e2fe	movl	0xb48(%rax,%rcx,4), %esi
000000010000e305	subq	%rsi, _fwp_gc(%rip)
000000010000e30c	js	0x10000e345
000000010000e30e	leaq	(%rcx,%rcx,2), %rcx
000000010000e312	leaq	(%rax,%rcx,8), %rax
000000010000e316	addq	$0x788, %rax                    ## imm = 0x788
000000010000e31c	movq	(%rax), %rbx
000000010000e31f	testq	%rbx, %rbx
000000010000e322	je	0x10000e335
000000010000e324	movq	(%rbx), %rcx
000000010000e327	notq	%rcx
000000010000e32a	movq	%rcx, (%rax)
000000010000e32d	jmp	0x10000e364
000000010000e32f	movq	0x10(%r14), %rbx
000000010000e333	jmp	0x10000e39e
000000010000e335	movq	0x8(%rax), %rbx
000000010000e339	movq	0x10(%rax), %rcx
000000010000e33d	subq	%rbx, %rcx
000000010000e340	cmpq	%rsi, %rcx
000000010000e343	jae	0x10000e35c
000000010000e345	movq	%r13, %rdi
000000010000e348	movl	$0x2, %esi
000000010000e34d	callq	_fwp_gc_alloc_slow
000000010000e352	movq	%rax, %rbx
000000010000e355	testq	%r12, %r12
000000010000e358	jne	0x10000e371
000000010000e35a	jmp	0x10000e392
000000010000e35c	leaq	(%rbx,%rsi), %rcx
000000010000e360	movq	%rcx, 0x8(%rax)
000000010000e364	movq	%rbx, %rdi
000000010000e367	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000e36c	testq	%r12, %r12
000000010000e36f	je	0x10000e392
000000010000e371	shlq	$0x3, %r15
000000010000e375	cmpq	%r13, %r15
000000010000e378	cmovaeq	%r13, %r15
000000010000e37c	movq	%rbx, %rdi
000000010000e37f	movq	%r12, %rsi
000000010000e382	movq	%r15, %rdx
000000010000e385	callq	0x100011208                     ## symbol stub for: _memcpy
000000010000e38a	movq	%r12, %rdi
000000010000e38d	callq	_fwp_mem_free
000000010000e392	movq	%rbx, 0x10(%r14)
000000010000e396	movq	0x18(%r14), %r15
000000010000e39a	movq	-0x30(%rbp), %rdx
000000010000e39e	leaq	0x1(%r15), %rax
000000010000e3a2	movq	%rax, 0x18(%r14)
000000010000e3a6	movq	%rdx, (%rbx,%r15,8)
000000010000e3aa	addq	$0x8, %rsp
000000010000e3ae	popq	%rbx
000000010000e3af	popq	%r12
000000010000e3b1	popq	%r13
000000010000e3b3	popq	%r14
000000010000e3b5	popq	%r15
000000010000e3b7	popq	%rbp
000000010000e3b8	retq
000000010000e3b9	nopl	(%rax)
_fwp_cmp:
000000010000e3c0	pushq	%rbp
000000010000e3c1	movq	%rsp, %rbp
000000010000e3c4	pushq	%r15
000000010000e3c6	pushq	%r14
000000010000e3c8	pushq	%r13
000000010000e3ca	pushq	%r12
000000010000e3cc	pushq	%rbx
000000010000e3cd	subq	$0x38, %rsp
000000010000e3d1	movq	%rsi, %rbx
000000010000e3d4	movq	%rdi, %r14
000000010000e3d7	movl	(%rdx), %r13d
000000010000e3da	cmpq	$0x15, %r13
000000010000e3de	ja	0x10000e405
000000010000e3e0	movq	%rdx, %r15
000000010000e3e3	leaq	0x4ba(%rip), %rax
000000010000e3ea	movslq	(%rax,%r13,4), %rcx
000000010000e3ee	addq	%rax, %rcx
000000010000e3f1	jmpq	*%rcx
000000010000e3f3	xorl	%ecx, %ecx
000000010000e3f5	cmpq	%rbx, %r14
000000010000e3f8	setg	%cl
000000010000e3fb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e400	cmovgel	%ecx, %eax
000000010000e403	jmp	0x10000e415
000000010000e405	xorl	%ecx, %ecx
000000010000e407	cmpq	%rbx, %r14
000000010000e40a	seta	%cl
000000010000e40d	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e412	cmovael	%ecx, %eax
000000010000e415	addq	$0x38, %rsp
000000010000e419	popq	%rbx
000000010000e41a	popq	%r12
000000010000e41c	popq	%r13
000000010000e41e	popq	%r14
000000010000e420	popq	%r15
000000010000e422	popq	%rbp
000000010000e423	retq
000000010000e424	movq	%rbx, %rsi
000000010000e427	movq	(%r14), %rbx
000000010000e42a	movq	(%rsi), %r15
000000010000e42d	addq	$0x8, %r14
000000010000e431	addq	$0x8, %rsi
000000010000e435	cmpq	%r15, %rbx
000000010000e438	movq	%r15, %rdx
000000010000e43b	cmovbq	%rbx, %rdx
000000010000e43f	movq	%r14, %rdi
000000010000e442	callq	0x100011202                     ## symbol stub for: _memcmp
000000010000e447	testl	%eax, %eax
000000010000e449	je	0x10000e7e5
000000010000e44f	sarl	$0x1f, %eax
000000010000e452	orl	$0x1, %eax
000000010000e455	jmp	0x10000e415
000000010000e457	movq	%r14, -0x30(%rbp)
000000010000e45b	movq	(%r14), %rax
000000010000e45e	movq	(%rbx), %r12
000000010000e461	cmpq	%r12, %rax
000000010000e464	movq	%r12, -0x38(%rbp)
000000010000e468	movq	%rax, -0x40(%rbp)
000000010000e46c	cmovbq	%rax, %r12
000000010000e470	testq	%r12, %r12
000000010000e473	je	0x10000e4dc
000000010000e475	movq	%rbx, %r14
000000010000e478	movq	0x38(%r15), %rax
000000010000e47c	movq	%rax, -0x48(%rbp)
000000010000e480	movl	$0x10, %ebx
000000010000e485	jmp	0x10000e499
000000010000e487	nopw	(%rax,%rax)
000000010000e490	addq	$0x10, %rbx
000000010000e494	decq	%r12
000000010000e497	je	0x10000e4dc
000000010000e499	movq	-0x30(%rbp), %rax
000000010000e49d	movq	-0x8(%rax,%rbx), %rdi
000000010000e4a2	movq	-0x8(%r14,%rbx), %rsi
000000010000e4a7	movq	-0x48(%rbp), %rdx
000000010000e4ab	callq	_fwp_cmp
000000010000e4b0	testl	%eax, %eax
000000010000e4b2	jne	0x10000e415
000000010000e4b8	cmpl	$0x12, %r13d
000000010000e4bc	jne	0x10000e490
000000010000e4be	movq	-0x30(%rbp), %rax
000000010000e4c2	movq	(%rax,%rbx), %rdi
000000010000e4c6	movq	(%r14,%rbx), %rsi
000000010000e4ca	movq	0x40(%r15), %rdx
000000010000e4ce	callq	_fwp_cmp
000000010000e4d3	testl	%eax, %eax
000000010000e4d5	je	0x10000e490
000000010000e4d7	jmp	0x10000e415
000000010000e4dc	xorl	%ecx, %ecx
000000010000e4de	movq	-0x38(%rbp), %rax
000000010000e4e2	cmpq	%rax, -0x40(%rbp)
000000010000e4e6	jmp	0x10000e40a
000000010000e4eb	movq	(%r14), %rdx
000000010000e4ee	movq	0x8(%r14), %rcx
000000010000e4f2	movq	(%rbx), %rdi
000000010000e4f5	movq	0x8(%rbx), %rsi
000000010000e4f9	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e4fe	cmpq	%rdi, %rdx
000000010000e501	movq	%rcx, %r8
000000010000e504	sbbq	%rsi, %r8
000000010000e507	jb	0x10000e415
000000010000e50d	cmpq	%rdx, %rdi
000000010000e510	sbbq	%rcx, %rsi
000000010000e513	setb	%al
000000010000e516	movzbl	%al, %eax
000000010000e519	jmp	0x10000e415
000000010000e51e	movl	%r14d, %ecx
000000010000e521	sarl	$0x1f, %ecx
000000010000e524	shrl	%ecx
000000010000e526	xorl	%r14d, %ecx
000000010000e529	movl	%ebx, %edx
000000010000e52b	sarl	$0x1f, %edx
000000010000e52e	shrl	%edx
000000010000e530	xorl	%ebx, %edx
000000010000e532	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e537	cmpl	%edx, %ecx
000000010000e539	jl	0x10000e415
000000010000e53f	jmp	0x10000e569
000000010000e541	movq	%r14, %rcx
000000010000e544	sarq	$0x3f, %rcx
000000010000e548	shrq	%rcx
000000010000e54b	xorq	%r14, %rcx
000000010000e54e	movq	%rbx, %rdx
000000010000e551	sarq	$0x3f, %rdx
000000010000e555	shrq	%rdx
000000010000e558	xorq	%rbx, %rdx
000000010000e55b	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e560	cmpq	%rdx, %rcx
000000010000e563	jl	0x10000e415
000000010000e569	setg	%al
000000010000e56c	movzbl	%al, %eax
000000010000e56f	jmp	0x10000e415
000000010000e574	movq	(%r14), %rdx
000000010000e577	movq	0x8(%r14), %rcx
000000010000e57b	movq	(%rbx), %rdi
000000010000e57e	movq	0x8(%rbx), %rsi
000000010000e582	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e587	cmpq	%rdi, %rdx
000000010000e58a	movq	%rcx, %r8
000000010000e58d	sbbq	%rsi, %r8
000000010000e590	jl	0x10000e415
000000010000e596	cmpq	%rdx, %rdi
000000010000e599	sbbq	%rcx, %rsi
000000010000e59c	setl	%al
000000010000e59f	movzbl	%al, %eax
000000010000e5a2	jmp	0x10000e415
000000010000e5a7	testq	%r14, %r14
000000010000e5aa	sete	%al
000000010000e5ad	testq	%rbx, %rbx
000000010000e5b0	sete	%cl
000000010000e5b3	orb	%al, %cl
000000010000e5b5	je	0x10000e7ef
000000010000e5bb	testq	%rbx, %rbx
000000010000e5be	setne	%cl
000000010000e5c1	orb	%al, %cl
000000010000e5c3	xorb	$0x1, %cl
000000010000e5c6	movzbl	%cl, %ecx
000000010000e5c9	testb	%al, %al
000000010000e5cb	movl	$0xffffffff, %eax               ## imm = 0xFFFFFFFF
000000010000e5d0	cmovel	%ecx, %eax
000000010000e5d3	testq	%rbx, %rbx
000000010000e5d6	cmovel	%ecx, %eax
000000010000e5d9	jmp	0x10000e415
000000010000e5de	movq	%r14, %r13
000000010000e5e1	movq	%rbx, %r14
000000010000e5e4	movslq	0x10(%r15), %rbx
000000010000e5e8	testq	%rbx, %rbx
000000010000e5eb	jle	0x10000e89a
000000010000e5f1	movq	0x20(%r15), %r15
000000010000e5f5	xorl	%r12d, %r12d
000000010000e5f8	nopl	(%rax,%rax)
000000010000e600	movq	0x8(%r13,%r12,8), %rdi
000000010000e605	movq	0x8(%r14,%r12,8), %rsi
000000010000e60a	movq	(%r15,%r12,8), %rdx
000000010000e60e	callq	_fwp_cmp
000000010000e613	testl	%eax, %eax
000000010000e615	jne	0x10000e415
000000010000e61b	incq	%r12
000000010000e61e	xorl	%eax, %eax
000000010000e620	cmpq	%r12, %rbx
000000010000e623	jne	0x10000e600
000000010000e625	jmp	0x10000e415
000000010000e62a	movq	(%r14), %rax
000000010000e62d	movabsq	$0x7fffffffffffffff, %r13       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000e637	movq	%rax, -0x30(%rbp)
000000010000e63b	andq	%r13, %rax
000000010000e63e	movq	(%rbx), %rcx
000000010000e641	movq	%rcx, -0x48(%rbp)
000000010000e645	andq	%rcx, %r13
000000010000e648	cmpq	%r13, %rax
000000010000e64b	movq	%r13, -0x58(%rbp)
000000010000e64f	movq	%rax, -0x50(%rbp)
000000010000e653	cmovbq	%rax, %r13
000000010000e657	testq	%r13, %r13
000000010000e65a	je	0x10000e7b0
000000010000e660	movq	0x38(%r15), %r15
000000010000e664	leaq	0x8(%r14), %rax
000000010000e668	movq	%rax, -0x40(%rbp)
000000010000e66c	leaq	0x8(%rbx), %rax
000000010000e670	movq	%rax, -0x38(%rbp)
000000010000e674	xorl	%r12d, %r12d
000000010000e677	nopw	(%rax,%rax)
000000010000e680	movl	$0x8, %eax
000000010000e685	testq	%r15, %r15
000000010000e688	je	0x10000e69e
000000010000e68a	movl	(%r15), %ecx
000000010000e68d	cmpq	$0xa, %rcx
000000010000e691	ja	0x10000e69e
000000010000e693	leaq	0x301e(%rip), %rax
000000010000e69a	movq	(%rax,%rcx,8), %rax
000000010000e69e	movq	-0x40(%rbp), %rcx
000000010000e6a2	cmpq	$0x0, -0x30(%rbp)
000000010000e6a7	jns	0x10000e6ad
000000010000e6a9	movq	0x10(%r14), %rcx
000000010000e6ad	movq	%rax, %rdx
000000010000e6b0	imulq	%r12, %rdx
000000010000e6b4	cmpq	$0x8, %rax
000000010000e6b8	je	0x10000e6e5
000000010000e6ba	cmpq	$0x2, %rax
000000010000e6be	je	0x10000e6d5
000000010000e6c0	cmpq	$0x1, %rax
000000010000e6c4	jne	0x10000e6f3
000000010000e6c6	movzbl	(%rcx,%rdx), %ecx
000000010000e6ca	movl	(%r15), %eax
000000010000e6cd	testl	%eax, %eax
000000010000e6cf	movsbq	%cl, %rdi
000000010000e6d3	jmp	0x10000e6ff
000000010000e6d5	movzwl	(%rcx,%rdx), %ecx
000000010000e6d9	movl	(%r15), %eax
000000010000e6dc	cmpl	$0x1, %eax
000000010000e6df	movswq	%cx, %rdi
000000010000e6e3	jmp	0x10000e6ff
000000010000e6e5	movq	(%rcx,%rdx), %rdi
000000010000e6e9	testq	%r15, %r15
000000010000e6ec	je	0x10000e739
000000010000e6ee	movl	(%r15), %eax
000000010000e6f1	jmp	0x10000e703
000000010000e6f3	movl	(%rcx,%rdx), %ecx
000000010000e6f6	movl	(%r15), %eax
000000010000e6f9	cmpl	$0x2, %eax
000000010000e6fc	movslq	%ecx, %rdi
000000010000e6ff	cmovneq	%rcx, %rdi
000000010000e703	cmpl	$0xa, %eax
000000010000e706	ja	0x10000e739
000000010000e708	movl	$0x484, %ecx                    ## imm = 0x484
000000010000e70d	btl	%eax, %ecx
000000010000e710	jb	0x10000e732
000000010000e712	movl	$0x1, %ecx
000000010000e717	movl	$0x21, %edx
000000010000e71c	btl	%eax, %edx
000000010000e71f	jb	0x10000e73e
000000010000e721	movl	$0x42, %ecx
000000010000e726	btl	%eax, %ecx
000000010000e729	jae	0x10000e739
000000010000e72b	movl	$0x2, %ecx
000000010000e730	jmp	0x10000e73e
000000010000e732	movl	$0x4, %ecx
000000010000e737	jmp	0x10000e73e
000000010000e739	movl	$0x8, %ecx
000000010000e73e	movq	-0x38(%rbp), %rax
000000010000e742	cmpq	$0x0, -0x48(%rbp)
000000010000e747	jns	0x10000e74d
000000010000e749	movq	0x10(%rbx), %rax
000000010000e74d	movq	%rcx, %rdx
000000010000e750	imulq	%r12, %rdx
000000010000e754	cmpq	$0x1, %rcx
000000010000e758	je	0x10000e778
000000010000e75a	cmpl	$0x2, %ecx
000000010000e75d	je	0x10000e76a
000000010000e75f	cmpl	$0x8, %ecx
000000010000e762	jne	0x10000e786
000000010000e764	movq	(%rax,%rdx), %rsi
000000010000e768	jmp	0x10000e794
000000010000e76a	cmpl	$0x1, (%r15)
000000010000e76e	movzwl	(%rax,%rdx), %eax
000000010000e772	movswq	%ax, %rsi
000000010000e776	jmp	0x10000e790
000000010000e778	cmpl	$0x0, (%r15)
000000010000e77c	movzbl	(%rax,%rdx), %eax
000000010000e780	movsbq	%al, %rsi
000000010000e784	jmp	0x10000e790
000000010000e786	cmpl	$0x2, (%r15)
000000010000e78a	movl	(%rax,%rdx), %eax
000000010000e78d	movslq	%eax, %rsi
000000010000e790	cmovneq	%rax, %rsi
000000010000e794	movq	%r15, %rdx
000000010000e797	callq	_fwp_cmp
000000010000e79c	testl	%eax, %eax
000000010000e79e	jne	0x10000e415
000000010000e7a4	incq	%r12
000000010000e7a7	cmpq	%r12, %r13
000000010000e7aa	jne	0x10000e680
000000010000e7b0	xorl	%ecx, %ecx
000000010000e7b2	movq	-0x50(%rbp), %rax
000000010000e7b6	cmpq	-0x58(%rbp), %rax
000000010000e7ba	jmp	0x10000e40a
000000010000e7bf	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000e7c6	ja	0x10000e836
000000010000e7c8	movl	%r14d, %eax
000000010000e7cb	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000e7d2	jbe	0x10000e842
000000010000e7d4	movl	(%rbx), %ecx
000000010000e7d6	cmpl	%ecx, %eax
000000010000e7d8	je	0x10000e848
000000010000e7da	seta	%al
000000010000e7dd	movzbl	%al, %ecx
000000010000e7e0	jmp	0x10000e40d
000000010000e7e5	xorl	%ecx, %ecx
000000010000e7e7	cmpq	%r15, %rbx
000000010000e7ea	jmp	0x10000e40a
000000010000e7ef	movq	0x38(%r15), %r15
000000010000e7f3	nopw	%cs:(%rax,%rax)
000000010000e800	movq	0x8(%r14), %rdi
000000010000e804	movq	0x8(%rbx), %rsi
000000010000e808	movq	%r15, %rdx
000000010000e80b	callq	_fwp_cmp
000000010000e810	testl	%eax, %eax
000000010000e812	jne	0x10000e415
000000010000e818	movq	0x10(%r14), %r14
000000010000e81c	movq	0x10(%rbx), %rbx
000000010000e820	testq	%r14, %r14
000000010000e823	sete	%al
000000010000e826	je	0x10000e5bb
000000010000e82c	testq	%rbx, %rbx
000000010000e82f	jne	0x10000e800
000000010000e831	jmp	0x10000e5bb
000000010000e836	movl	(%r14), %eax
000000010000e839	cmpq	$0xfff, %rbx                    ## imm = 0xFFF
000000010000e840	ja	0x10000e7d4
000000010000e842	movl	%ebx, %ecx
000000010000e844	cmpl	%ecx, %eax
000000010000e846	jne	0x10000e7da
000000010000e848	movq	%r14, %r13
000000010000e84b	movq	%rbx, %r14
000000010000e84e	movq	0x28(%r15), %rcx
000000010000e852	movl	%eax, %eax
000000010000e854	movslq	(%rcx,%rax,4), %rbx
000000010000e858	testq	%rbx, %rbx
000000010000e85b	jle	0x10000e89a
000000010000e85d	movq	0x30(%r15), %rcx
000000010000e861	movq	(%rcx,%rax,8), %r15
000000010000e865	xorl	%r12d, %r12d
000000010000e868	nopl	(%rax,%rax)
000000010000e870	movq	0x8(%r13,%r12,8), %rdi
000000010000e875	movq	0x8(%r14,%r12,8), %rsi
000000010000e87a	movq	(%r15,%r12,8), %rdx
000000010000e87e	callq	_fwp_cmp
000000010000e883	testl	%eax, %eax
000000010000e885	jne	0x10000e415
000000010000e88b	incq	%r12
000000010000e88e	xorl	%eax, %eax
000000010000e890	cmpq	%r12, %rbx
000000010000e893	jne	0x10000e870
000000010000e895	jmp	0x10000e415
000000010000e89a	xorl	%eax, %eax
000000010000e89c	jmp	0x10000e415
000000010000e8a1	nopl	(%rax)
000000010000e8a4	sti
000000010000e8a6	.byte 0xff #bad opcode
000000010000e8a7	decl	-0x5(%rdi)
000000010000e8aa	.byte 0xff #bad opcode
000000010000e8ab	decl	-0x5(%rdi)
000000010000e8ae	.byte 0xff #bad opcode
000000010000e8af	decl	-0x5(%rdi)
000000010000e8b2	.byte 0xff #bad opcode
000000010000e8b3	callq	*%rax
000000010000e8b5	cld
000000010000e8b6	.byte 0xff #bad opcode
000000010000e8b7	jmpq	*-0x5(%rcx)
000000010000e8ba	.byte 0xff #bad opcode
000000010000e8bb	jmpq	*-0x5(%rcx)
000000010000e8be	.byte 0xff #bad opcode
000000010000e8bf	jmpq	*-0x5(%rcx)
000000010000e8c2	.byte 0xff #bad opcode
000000010000e8c3	jmpq	*-0x5(%rcx)
000000010000e8c6	.byte 0xff #bad opcode
000000010000e8c7	incl	-0x4(%rdi)
000000010000e8ca	.byte 0xff #bad opcode
000000010000e8cb	.byte 0xff #bad opcode
000000010000e8cc	jp	0x10000e8ca
000000010000e8ce	.byte 0xff #bad opcode
000000010000e8cf	lcalll	*-0x7f000004(%rbp)
000000010000e8d5	sti
000000010000e8d6	.byte 0xff #bad opcode
000000010000e8d7	incl	0x1bfffffb(%rax)
000000010000e8dd	.byte 0xff #bad opcode
000000010000e8de	.byte 0xff #bad opcode
000000010000e8df	incl	(%rbx)
000000010000e8e1	std
000000010000e8e2	.byte 0xff #bad opcode
000000010000e8e3	.byte 0xff #bad opcode
000000010000e8e4	cmpb	%ch, %bh
000000010000e8e6	.byte 0xff #bad opcode
000000010000e8e7	incl	-0x4c000003(%rsi)
000000010000e8ed	sti
000000010000e8ee	.byte 0xff #bad opcode
000000010000e8ef	pushq	0x4ffffffb(%rbx)
000000010000e8f5	sti
000000010000e8f6	.byte 0xff #bad opcode
000000010000e8f7	decl	-0x5(%rdi)
000000010000e8fa	.byte 0xff #bad opcode
000000010000e8fb	decl	(%rdi)
000000010000e8fd	.byte 0x1f #bad opcode
000000010000e8fe	addb	%dl, 0x48(%rbp)
000000010000e902	movl	%esp, %ebp
000000010000e904	pushq	%r15
000000010000e906	pushq	%r14
000000010000e908	pushq	%r13
000000010000e90a	pushq	%r12
000000010000e90c	pushq	%rbx
000000010000e90d	subq	$0x268, %rsp                    ## imm = 0x268
000000010000e914	movq	0x4715(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000e91b	movq	(%rax), %rax
000000010000e91e	movq	%rax, -0x30(%rbp)
000000010000e922	movl	(%rdx), %eax
000000010000e924	cmpq	$0x19, %rax
000000010000e928	ja	0x10000fbeb
000000010000e92e	movq	%rdx, %r15
000000010000e931	movq	%rsi, %r14
000000010000e934	movq	%rdi, %r13
000000010000e937	leaq	0x141e(%rip), %rdx
000000010000e93e	movslq	(%rdx,%rax,4), %rsi
000000010000e942	addq	%rdx, %rsi
000000010000e945	movq	%rdi, -0x278(%rbp)
000000010000e94c	jmpq	*%rsi
000000010000e94e	leaq	0x3ca0(%rip), %rdx              ## literal pool for: "%lld"
000000010000e955	jmp	0x10000e95e
000000010000e957	leaq	0x3c9c(%rip), %rdx              ## literal pool for: "%llu"
000000010000e95e	leaq	-0x270(%rbp), %rbx
000000010000e965	movl	$0x200, %esi                    ## imm = 0x200
000000010000e96a	movq	%rbx, %rdi
000000010000e96d	movq	%r14, %rcx
000000010000e970	xorl	%eax, %eax
000000010000e972	callq	0x10001126e                     ## symbol stub for: _snprintf
000000010000e977	jmp	0x10000fbd5
000000010000e97c	cmpl	$0x13, %eax
000000010000e97f	leaq	0x3ca5(%rip), %rax              ## literal pool for: "set{"
000000010000e986	leaq	0x3ca3(%rip), %rsi              ## literal pool for: "map{"
000000010000e98d	cmoveq	%rax, %rsi
000000010000e991	movl	$0x4, %edx
000000010000e996	movq	%r13, %rdi
000000010000e999	callq	_buf_put
000000010000e99e	cmpq	$0x0, (%r14)
000000010000e9a2	je	0x10000ea7e
000000010000e9a8	movq	0x38(%r15), %rdx
000000010000e9ac	movq	0x8(%r14), %rsi
000000010000e9b0	movq	-0x278(%rbp), %rbx
000000010000e9b7	movq	%rbx, %rdi
000000010000e9ba	xorl	%ecx, %ecx
000000010000e9bc	callq	_fwp_write
000000010000e9c1	cmpl	$0x12, (%r15)
000000010000e9c5	jne	0x10000e9ed
000000010000e9c7	leaq	0x3c67(%rip), %rsi              ## literal pool for: ": "
000000010000e9ce	movl	$0x2, %edx
000000010000e9d3	movq	%rbx, %rdi
000000010000e9d6	callq	_buf_put
000000010000e9db	movq	0x10(%r14), %rsi
000000010000e9df	movq	0x40(%r15), %rdx
000000010000e9e3	movq	%rbx, %rdi
000000010000e9e6	xorl	%ecx, %ecx
000000010000e9e8	callq	_fwp_write
000000010000e9ed	cmpq	$0x2, (%r14)
000000010000e9f1	jb	0x10000ea7e
000000010000e9f7	leaq	0x20(%r14), %r13
000000010000e9fb	movl	$0x1, %r12d
000000010000ea01	jmp	0x10000ea1c
000000010000ea03	nopw	%cs:(%rax,%rax)
000000010000ea10	incq	%r12
000000010000ea13	addq	$0x10, %r13
000000010000ea17	cmpq	(%r14), %r12
000000010000ea1a	jae	0x10000ea7e
000000010000ea1c	movl	$0x2, %edx
000000010000ea21	movq	-0x278(%rbp), %rbx
000000010000ea28	movq	%rbx, %rdi
000000010000ea2b	leaq	0x3b42(%rip), %rsi              ## literal pool for: ", "
000000010000ea32	callq	_buf_put
000000010000ea37	movq	-0x8(%r13), %rsi
000000010000ea3b	movq	0x38(%r15), %rdx
000000010000ea3f	movq	%rbx, %rdi
000000010000ea42	xorl	%ecx, %ecx
000000010000ea44	callq	_fwp_write
000000010000ea49	cmpl	$0x12, (%r15)
000000010000ea4d	jne	0x10000ea10
000000010000ea4f	movl	$0x2, %edx
000000010000ea54	movq	-0x278(%rbp), %rbx
000000010000ea5b	movq	%rbx, %rdi
000000010000ea5e	leaq	0x3bd0(%rip), %rsi              ## literal pool for: ": "
000000010000ea65	callq	_buf_put
000000010000ea6a	movq	(%r13), %rsi
000000010000ea6e	movq	0x40(%r15), %rdx
000000010000ea72	movq	%rbx, %rdi
000000010000ea75	xorl	%ecx, %ecx
000000010000ea77	callq	_fwp_write
000000010000ea7c	jmp	0x10000ea10
000000010000ea7e	movb	$0x7d, -0x270(%rbp)
000000010000ea85	leaq	-0x270(%rbp), %rsi
000000010000ea8c	movl	$0x1, %edx
000000010000ea91	movq	-0x278(%rbp), %rdi
000000010000ea98	jmp	0x10000fbe6
000000010000ea9d	movq	0x8(%r15), %rbx
000000010000eaa1	testq	%rbx, %rbx
000000010000eaa4	je	0x10000f498
000000010000eaaa	leaq	0x3aec(%rip), %rsi              ## literal pool for: "Duration"
000000010000eab1	movq	%rbx, %rdi
000000010000eab4	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000eab9	testl	%eax, %eax
000000010000eabb	je	0x10000f743
000000010000eac1	movq	%r15, -0x280(%rbp)
000000010000eac8	addq	$0x10, %r15
000000010000eacc	movq	%rbx, %rdi
000000010000eacf	callq	0x100011286                     ## symbol stub for: _strlen
000000010000ead4	movq	%r13, %rdi
000000010000ead7	movq	%rbx, %rsi
000000010000eada	movq	%rax, %rdx
000000010000eadd	callq	_buf_put
000000010000eae2	movb	$0x20, -0x270(%rbp)
000000010000eae9	leaq	-0x270(%rbp), %rsi
000000010000eaf0	movl	$0x1, %edx
000000010000eaf5	movq	%r13, %rdi
000000010000eaf8	callq	_buf_put
000000010000eafd	xorl	%r12d, %r12d
000000010000eb00	jmp	0x10000f4b9
000000010000eb05	cmpq	$0xfff, %r14                    ## imm = 0xFFF
000000010000eb0c	ja	0x10000f2d4
000000010000eb12	movl	%r14d, %eax
000000010000eb15	jmp	0x10000f2d7
000000010000eb1a	movq	%r14, %xmm0
000000010000eb1f	movq	%xmm0, -0x278(%rbp)
000000010000eb27	ucomisd	%xmm0, %xmm0
000000010000eb2b	jp	0x10000fd4d
000000010000eb31	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000eb3b	andq	%r14, %rax
000000010000eb3e	movabsq	$0x7ff0000000000000, %rcx       ## imm = 0x7FF0000000000000
000000010000eb48	cmpq	%rcx, %rax
000000010000eb4b	je	0x10000f458
000000010000eb51	movl	$0x1, %ebx
000000010000eb56	leaq	-0x270(%rbp), %r14
000000010000eb5d	nopl	(%rax)
000000010000eb60	movq	%r14, %rdi
000000010000eb63	movsd	-0x278(%rbp), %xmm0
000000010000eb6b	movl	%ebx, %esi
000000010000eb6d	callq	_fwp_format_g
000000010000eb72	movq	%r14, %rdi
000000010000eb75	xorl	%esi, %esi
000000010000eb77	callq	0x100011298                     ## symbol stub for: _strtod
000000010000eb7c	ucomisd	-0x278(%rbp), %xmm0
000000010000eb84	jne	0x10000eb8c
000000010000eb86	jnp	0x10000f1e9
000000010000eb8c	incl	%ebx
000000010000eb8e	cmpl	$0x12, %ebx
000000010000eb91	jne	0x10000eb60
000000010000eb93	leaq	-0x270(%rbp), %rbx
000000010000eb9a	movq	%rbx, %rdi
000000010000eb9d	movsd	-0x278(%rbp), %xmm0
000000010000eba5	movl	$0x11, %esi
000000010000ebaa	callq	_fwp_format_g
000000010000ebaf	movq	%rbx, %rdi
000000010000ebb2	jmp	0x10000f1f0
000000010000ebb7	movb	$0x3c, -0x270(%rbp)
000000010000ebbe	leaq	-0x270(%rbp), %rsi
000000010000ebc5	movl	$0x1, %edx
000000010000ebca	movq	%r13, %rdi
000000010000ebcd	callq	_buf_put
000000010000ebd2	movq	0x8(%r15), %rbx
000000010000ebd6	movq	%rbx, %rdi
000000010000ebd9	callq	0x100011286                     ## symbol stub for: _strlen
000000010000ebde	movq	%r13, %rdi
000000010000ebe1	movq	%rbx, %rsi
000000010000ebe4	jmp	0x10000f2c0
000000010000ebe9	movq	0x4440(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ebf0	movq	(%rax), %rax
000000010000ebf3	cmpq	-0x30(%rbp), %rax
000000010000ebf7	jne	0x10000fd48
000000010000ebfd	leaq	0x3a06(%rip), %rsi              ## literal pool for: "<opaque>"
000000010000ec04	movl	$0x8, %edx
000000010000ec09	movq	%r13, %rdi
000000010000ec0c	jmp	0x10000f996
000000010000ec11	leaq	0x8(%r14), %rsi
000000010000ec15	movq	(%r14), %rdx
000000010000ec18	movq	0x4411(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ec1f	movq	(%rax), %rax
000000010000ec22	testl	%ecx, %ecx
000000010000ec24	je	0x10000f5f6
000000010000ec2a	cmpq	-0x30(%rbp), %rax
000000010000ec2e	jne	0x10000fd48
000000010000ec34	movq	%r13, %rdi
000000010000ec37	jmp	0x10000f996
000000010000ec3c	movq	(%r14), %r9
000000010000ec3f	movq	0x8(%r14), %r8
000000010000ec43	movq	%r9, %rax
000000010000ec46	orq	%r8, %rax
000000010000ec49	je	0x10000f619
000000010000ec4f	xorl	%edi, %edi
000000010000ec51	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000ec5b	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000ec65	movq	%r8, %rbx
000000010000ec68	nopl	(%rax,%rax)
000000010000ec70	movq	%r8, %rcx
000000010000ec73	shldq	$0x3f, %r9, %rcx
000000010000ec78	shrq	%rbx
000000010000ec7b	movq	%rcx, %rsi
000000010000ec7e	addq	%rbx, %rsi
000000010000ec81	adcq	$0x0, %rsi
000000010000ec85	movq	%rsi, %rax
000000010000ec88	mulq	%r10
000000010000ec8b	shrq	$0x2, %rdx
000000010000ec8f	leaq	(%rdx,%rdx,4), %rax
000000010000ec93	subq	%rax, %rsi
000000010000ec96	subq	%rsi, %rcx
000000010000ec99	sbbq	$0x0, %rbx
000000010000ec9d	movq	%rcx, %rsi
000000010000eca0	imulq	%r11, %rsi
000000010000eca4	movq	%rcx, %rax
000000010000eca7	mulq	%r10
000000010000ecaa	addq	%rsi, %rdx
000000010000ecad	imulq	%r10, %rbx
000000010000ecb1	addq	%rdx, %rbx
000000010000ecb4	movq	%rax, %rcx
000000010000ecb7	addq	%rax, %rcx
000000010000ecba	leaq	(%rcx,%rcx,4), %rcx
000000010000ecbe	movl	%r9d, %edx
000000010000ecc1	subl	%ecx, %edx
000000010000ecc3	orb	$0x30, %dl
000000010000ecc6	movb	%dl, -0x70(%rbp,%rdi)
000000010000ecca	incq	%rdi
000000010000eccd	cmpq	$0xa, %r9
000000010000ecd1	sbbq	$0x0, %r8
000000010000ecd5	movq	%rax, %r9
000000010000ecd8	movq	%rbx, %r8
000000010000ecdb	jae	0x10000ec70
000000010000ecdd	testl	%edi, %edi
000000010000ecdf	jg	0x10000f622
000000010000ece5	jmp	0x10000ed95
000000010000ecea	movq	(%r14), %r9
000000010000eced	movq	0x8(%r14), %r10
000000010000ecf1	testq	%r10, %r10
000000010000ecf4	js	0x10000f644
000000010000ecfa	movq	%r9, %rax
000000010000ecfd	orq	%r10, %rax
000000010000ed00	je	0x10000f762
000000010000ed06	xorl	%edi, %edi
000000010000ed08	movabsq	$-0x3333333333333333, %r8       ## imm = 0xCCCCCCCCCCCCCCCD
000000010000ed12	movabsq	$-0x3333333333333334, %r11      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000ed1c	movq	%r10, %rbx
000000010000ed1f	nop
000000010000ed20	movq	%r10, %rcx
000000010000ed23	shldq	$0x3f, %r9, %rcx
000000010000ed28	shrq	%rbx
000000010000ed2b	movq	%rcx, %rsi
000000010000ed2e	addq	%rbx, %rsi
000000010000ed31	adcq	$0x0, %rsi
000000010000ed35	movq	%rsi, %rax
000000010000ed38	mulq	%r8
000000010000ed3b	shrq	$0x2, %rdx
000000010000ed3f	leaq	(%rdx,%rdx,4), %rax
000000010000ed43	subq	%rax, %rsi
000000010000ed46	subq	%rsi, %rcx
000000010000ed49	sbbq	$0x0, %rbx
000000010000ed4d	movq	%rcx, %rsi
000000010000ed50	imulq	%r11, %rsi
000000010000ed54	movq	%rcx, %rax
000000010000ed57	mulq	%r8
000000010000ed5a	addq	%rsi, %rdx
000000010000ed5d	imulq	%r8, %rbx
000000010000ed61	addq	%rdx, %rbx
000000010000ed64	movq	%rax, %rcx
000000010000ed67	addq	%rax, %rcx
000000010000ed6a	leaq	(%rcx,%rcx,4), %rcx
000000010000ed6e	movl	%r9d, %edx
000000010000ed71	subl	%ecx, %edx
000000010000ed73	orb	$0x30, %dl
000000010000ed76	movb	%dl, -0x70(%rbp,%rdi)
000000010000ed7a	incq	%rdi
000000010000ed7d	cmpq	$0xa, %r9
000000010000ed81	sbbq	$0x0, %r10
000000010000ed85	movq	%rax, %r9
000000010000ed88	movq	%rbx, %r10
000000010000ed8b	jae	0x10000ed20
000000010000ed8d	testl	%edi, %edi
000000010000ed8f	jg	0x10000f76b
000000010000ed95	xorl	%eax, %eax
000000010000ed97	jmp	0x10000fbc6
000000010000ed9c	movb	$0x5b, -0x270(%rbp)
000000010000eda3	leaq	-0x270(%rbp), %rsi
000000010000edaa	movl	$0x1, %edx
000000010000edaf	movq	%r13, %rdi
000000010000edb2	callq	_buf_put
000000010000edb7	testq	%r14, %r14
000000010000edba	je	0x10000fab4
000000010000edc0	movq	0x38(%r15), %rdx
000000010000edc4	movq	0x8(%r14), %rsi
000000010000edc8	movq	%r13, %rdi
000000010000edcb	xorl	%ecx, %ecx
000000010000edcd	callq	_fwp_write
000000010000edd2	movq	0x10(%r14), %r14
000000010000edd6	testq	%r14, %r14
000000010000edd9	je	0x10000fab4
000000010000eddf	leaq	0x378e(%rip), %rbx              ## literal pool for: ", "
000000010000ede6	nopw	%cs:(%rax,%rax)
000000010000edf0	movl	$0x2, %edx
000000010000edf5	movq	%r13, %rdi
000000010000edf8	movq	%rbx, %rsi
000000010000edfb	callq	_buf_put
000000010000ee00	movq	0x8(%r14), %rsi
000000010000ee04	movq	0x38(%r15), %rdx
000000010000ee08	movq	%r13, %rdi
000000010000ee0b	xorl	%ecx, %ecx
000000010000ee0d	callq	_fwp_write
000000010000ee12	movq	0x10(%r14), %r14
000000010000ee16	testq	%r14, %r14
000000010000ee19	jne	0x10000edf0
000000010000ee1b	jmp	0x10000fab4
000000010000ee20	movslq	0x48(%r15), %rbx
000000010000ee24	movl	%ebx, %r12d
000000010000ee27	leaq	0x3(%rbx), %rsi
000000010000ee2b	cmpq	$0x4000, %rsi                   ## imm = 0x4000
000000010000ee32	ja	0x10000f72e
000000010000ee38	leaq	0x12(%rbx), %rax
000000010000ee3c	shrq	$0x4, %rax
000000010000ee40	leaq	_fwp_gc(%rip), %rcx
000000010000ee47	movzbl	0xbe8(%rax,%rcx), %edx
000000010000ee4f	movl	0xb48(%rcx,%rdx,4), %eax
000000010000ee56	subq	%rax, _fwp_gc(%rip)
000000010000ee5d	js	0x10000f72e
000000010000ee63	leaq	(%rdx,%rdx,2), %rdx
000000010000ee67	leaq	(%rcx,%rdx,8), %rcx
000000010000ee6b	addq	$0x3c8, %rcx                    ## imm = 0x3C8
000000010000ee72	movq	(%rcx), %r15
000000010000ee75	testq	%r15, %r15
000000010000ee78	je	0x10000f71a
000000010000ee7e	movq	(%r15), %rax
000000010000ee81	notq	%rax
000000010000ee84	movq	%rax, (%rcx)
000000010000ee87	jmp	0x10000f8b2
000000010000ee8c	cmpq	$-0x1, %r14
000000010000ee90	leaq	0x36f1(%rip), %rax              ## literal pool for: "-1"
000000010000ee97	leaq	0x2b13(%rip), %rcx              ## literal pool for: "0"
000000010000ee9e	cmoveq	%rax, %rcx
000000010000eea2	cmpq	$0x1, %r14
000000010000eea6	leaq	0x36d8(%rip), %rbx              ## literal pool for: "+1"
000000010000eead	cmovneq	%rcx, %rbx
000000010000eeb1	movq	%rbx, %rdi
000000010000eeb4	callq	0x100011286                     ## symbol stub for: _strlen
000000010000eeb9	movq	0x4170(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000eec0	movq	(%rcx), %rcx
000000010000eec3	cmpq	-0x30(%rbp), %rcx
000000010000eec7	jne	0x10000fd48
000000010000eecd	movq	%r13, %rdi
000000010000eed0	movq	%rbx, %rsi
000000010000eed3	jmp	0x10000f993
000000010000eed8	movq	%r15, %r12
000000010000eedb	leaq	0x3742(%rip), %rsi              ## literal pool for: "array["
000000010000eee2	movl	$0x6, %edx
000000010000eee7	movq	%r13, %rdi
000000010000eeea	callq	_buf_put
000000010000eeef	movq	(%r14), %rsi
000000010000eef2	leaq	(,%rsi,2), %rax
000000010000eefa	testq	%rax, %rax
000000010000eefd	je	0x10000fab4
000000010000ef03	movq	0x38(%r12), %rdx
000000010000ef08	movl	$0x8, %eax
000000010000ef0d	testq	%rdx, %rdx
000000010000ef10	je	0x10000f78d
000000010000ef16	movl	(%rdx), %ecx
000000010000ef18	cmpq	$0xa, %rcx
000000010000ef1c	movq	-0x278(%rbp), %r13
000000010000ef23	ja	0x10000f794
000000010000ef29	leaq	0x2788(%rip), %rax
000000010000ef30	movq	(%rax,%rcx,8), %rax
000000010000ef34	jmp	0x10000f794
000000010000ef39	leaq	0x36da(%rip), %rsi              ## literal pool for: "bytes["
000000010000ef40	movl	$0x6, %edx
000000010000ef45	movq	%r13, %rdi
000000010000ef48	callq	_buf_put
000000010000ef4d	cmpq	$0x0, (%r14)
000000010000ef51	movq	%r13, %rbx
000000010000ef54	je	0x10000f001
000000010000ef5a	movzbl	0x8(%r14), %ecx
000000010000ef5f	leaq	0x36bb(%rip), %rdx              ## literal pool for: "%u"
000000010000ef66	leaq	-0x270(%rbp), %r15
000000010000ef6d	movl	$0x200, %esi                    ## imm = 0x200
000000010000ef72	movq	%r15, %rdi
000000010000ef75	xorl	%eax, %eax
000000010000ef77	callq	0x10001126e                     ## symbol stub for: _snprintf
000000010000ef7c	movq	%r15, %rdi
000000010000ef7f	callq	0x100011286                     ## symbol stub for: _strlen
000000010000ef84	movq	%rbx, %rdi
000000010000ef87	movq	%r15, %rsi
000000010000ef8a	movq	%rax, %rdx
000000010000ef8d	callq	_buf_put
000000010000ef92	cmpq	$0x2, (%r14)
000000010000ef96	jb	0x10000f001
000000010000ef98	movl	$0x9, %r13d
000000010000ef9e	leaq	0x367c(%rip), %r15              ## literal pool for: "%u"
000000010000efa5	leaq	-0x270(%rbp), %r12
000000010000efac	nopl	(%rax)
000000010000efb0	movl	$0x2, %edx
000000010000efb5	movq	%rbx, %rdi
000000010000efb8	leaq	0x35b5(%rip), %rsi              ## literal pool for: ", "
000000010000efbf	callq	_buf_put
000000010000efc4	movzbl	(%r14,%r13), %ecx
000000010000efc9	movl	$0x200, %esi                    ## imm = 0x200
000000010000efce	movq	%r12, %rdi
000000010000efd1	movq	%r15, %rdx
000000010000efd4	xorl	%eax, %eax
000000010000efd6	callq	0x10001126e                     ## symbol stub for: _snprintf
000000010000efdb	movq	%r12, %rdi
000000010000efde	callq	0x100011286                     ## symbol stub for: _strlen
000000010000efe3	movq	%rbx, %rdi
000000010000efe6	movq	%r12, %rsi
000000010000efe9	movq	%rax, %rdx
000000010000efec	callq	_buf_put
000000010000eff1	leaq	0x1(%r13), %rax
000000010000eff5	addq	$-0x7, %r13
000000010000eff9	cmpq	(%r14), %r13
000000010000effc	movq	%rax, %r13
000000010000efff	jb	0x10000efb0
000000010000f001	movb	$0x5d, -0x70(%rbp)
000000010000f005	leaq	-0x70(%rbp), %rsi
000000010000f009	movl	$0x1, %edx
000000010000f00e	movq	%rbx, %rdi
000000010000f011	jmp	0x10000fbe6
000000010000f016	movd	%r14d, %xmm1
000000010000f01b	ucomiss	%xmm1, %xmm1
000000010000f01e	jp	0x10000fd4d
000000010000f024	andl	$0x7fffffff, %r14d              ## imm = 0x7FFFFFFF
000000010000f02b	cmpl	$0x7f800000, %r14d              ## imm = 0x7F800000
000000010000f032	je	0x10000f46a
000000010000f038	cvtss2sd	%xmm1, %xmm0
000000010000f03c	leaq	-0x270(%rbp), %rbx
000000010000f043	movq	%rbx, %rdi
000000010000f046	movsd	%xmm0, -0x280(%rbp)
000000010000f04e	movl	$0x1, %esi
000000010000f053	movss	%xmm1, -0x278(%rbp)
000000010000f05b	callq	_fwp_format_g
000000010000f060	movq	%rbx, %rdi
000000010000f063	xorl	%esi, %esi
000000010000f065	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f06a	ucomiss	-0x278(%rbp), %xmm0
000000010000f071	jne	0x10000f079
000000010000f073	jnp	0x10000f1e9
000000010000f079	movq	%rbx, %rdi
000000010000f07c	movsd	-0x280(%rbp), %xmm0
000000010000f084	movl	$0x2, %esi
000000010000f089	callq	_fwp_format_g
000000010000f08e	movq	%rbx, %rdi
000000010000f091	xorl	%esi, %esi
000000010000f093	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f098	ucomiss	-0x278(%rbp), %xmm0
000000010000f09f	jne	0x10000f0a7
000000010000f0a1	jnp	0x10000f1e9
000000010000f0a7	movq	%rbx, %rdi
000000010000f0aa	movsd	-0x280(%rbp), %xmm0
000000010000f0b2	movl	$0x3, %esi
000000010000f0b7	callq	_fwp_format_g
000000010000f0bc	movq	%rbx, %rdi
000000010000f0bf	xorl	%esi, %esi
000000010000f0c1	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f0c6	ucomiss	-0x278(%rbp), %xmm0
000000010000f0cd	jne	0x10000f0d5
000000010000f0cf	jnp	0x10000f1e9
000000010000f0d5	movq	%rbx, %rdi
000000010000f0d8	movsd	-0x280(%rbp), %xmm0
000000010000f0e0	movl	$0x4, %esi
000000010000f0e5	callq	_fwp_format_g
000000010000f0ea	movq	%rbx, %rdi
000000010000f0ed	xorl	%esi, %esi
000000010000f0ef	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f0f4	ucomiss	-0x278(%rbp), %xmm0
000000010000f0fb	jne	0x10000f103
000000010000f0fd	jnp	0x10000f1e9
000000010000f103	movq	%rbx, %rdi
000000010000f106	movsd	-0x280(%rbp), %xmm0
000000010000f10e	movl	$0x5, %esi
000000010000f113	callq	_fwp_format_g
000000010000f118	movq	%rbx, %rdi
000000010000f11b	xorl	%esi, %esi
000000010000f11d	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f122	ucomiss	-0x278(%rbp), %xmm0
000000010000f129	jne	0x10000f131
000000010000f12b	jnp	0x10000f1e9
000000010000f131	movq	%rbx, %rdi
000000010000f134	movsd	-0x280(%rbp), %xmm0
000000010000f13c	movl	$0x6, %esi
000000010000f141	callq	_fwp_format_g
000000010000f146	movq	%rbx, %rdi
000000010000f149	xorl	%esi, %esi
000000010000f14b	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f150	ucomiss	-0x278(%rbp), %xmm0
000000010000f157	jne	0x10000f15f
000000010000f159	jnp	0x10000f1e9
000000010000f15f	movq	%rbx, %rdi
000000010000f162	movsd	-0x280(%rbp), %xmm0
000000010000f16a	movl	$0x7, %esi
000000010000f16f	callq	_fwp_format_g
000000010000f174	movq	%rbx, %rdi
000000010000f177	xorl	%esi, %esi
000000010000f179	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f17e	ucomiss	-0x278(%rbp), %xmm0
000000010000f185	jne	0x10000f189
000000010000f187	jnp	0x10000f1e9
000000010000f189	movq	%rbx, %rdi
000000010000f18c	movsd	-0x280(%rbp), %xmm0
000000010000f194	movl	$0x8, %esi
000000010000f199	callq	_fwp_format_g
000000010000f19e	movq	%rbx, %rdi
000000010000f1a1	xorl	%esi, %esi
000000010000f1a3	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f1a8	movss	-0x278(%rbp), %xmm1
000000010000f1b0	ucomiss	%xmm1, %xmm0
000000010000f1b3	jne	0x10000f1b7
000000010000f1b5	jnp	0x10000f1e9
000000010000f1b7	movq	%rbx, %rdi
000000010000f1ba	movsd	-0x280(%rbp), %xmm0
000000010000f1c2	movl	$0x9, %esi
000000010000f1c7	callq	_fwp_format_g
000000010000f1cc	movq	%rbx, %rdi
000000010000f1cf	xorl	%esi, %esi
000000010000f1d1	callq	0x10001129e                     ## symbol stub for: _strtof
000000010000f1d6	ucomiss	-0x278(%rbp), %xmm0
000000010000f1dd	jne	0x10000fd33
000000010000f1e3	jp	0x10000fd33
000000010000f1e9	leaq	-0x270(%rbp), %rdi
000000010000f1f0	movl	$0x2e, %esi
000000010000f1f5	callq	0x10001127a                     ## symbol stub for: _strchr
000000010000f1fa	testq	%rax, %rax
000000010000f1fd	jne	0x10000fbce
000000010000f203	leaq	-0x270(%rbp), %rdi
000000010000f20a	movl	$0x65, %esi
000000010000f20f	callq	0x10001127a                     ## symbol stub for: _strchr
000000010000f214	testq	%rax, %rax
000000010000f217	jne	0x10000fbce
000000010000f21d	leaq	0x339f(%rip), %rsi              ## literal pool for: "inf"
000000010000f224	leaq	-0x270(%rbp), %rdi
000000010000f22b	callq	0x100011292                     ## symbol stub for: _strstr
000000010000f230	testq	%rax, %rax
000000010000f233	jne	0x10000fbce
000000010000f239	leaq	0x338c(%rip), %rsi              ## literal pool for: "NaN"
000000010000f240	leaq	-0x270(%rbp), %rdi
000000010000f247	callq	0x100011292                     ## symbol stub for: _strstr
000000010000f24c	testq	%rax, %rax
000000010000f24f	jne	0x10000fbce
000000010000f255	leaq	0x33f7(%rip), %rsi              ## literal pool for: ".0"
000000010000f25c	leaq	-0x270(%rbp), %rdi
000000010000f263	movl	$0x200, %edx                    ## imm = 0x200
000000010000f268	callq	0x100011166                     ## symbol stub for: ___strcat_chk
000000010000f26d	jmp	0x10000fbce
000000010000f272	movq	0x3db7(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000f279	movq	(%rax), %rax
000000010000f27c	cmpq	-0x30(%rbp), %rax
000000010000f280	jne	0x10000fd48
000000010000f286	leaq	0x3372(%rip), %rsi              ## literal pool for: "<function>"
000000010000f28d	movl	$0xa, %edx
000000010000f292	movq	%r13, %rdi
000000010000f295	jmp	0x10000f996
000000010000f29a	leaq	0x3372(%rip), %rsi              ## literal pool for: "<file "
000000010000f2a1	movl	$0x6, %edx
000000010000f2a6	movq	%r13, %rdi
000000010000f2a9	callq	_buf_put
000000010000f2ae	addq	$0x10, %r14
000000010000f2b2	movq	%r14, %rdi
000000010000f2b5	callq	0x100011286                     ## symbol stub for: _strlen
000000010000f2ba	movq	%r13, %rdi
000000010000f2bd	movq	%r14, %rsi
000000010000f2c0	movq	%rax, %rdx
000000010000f2c3	callq	_buf_put
000000010000f2c8	movb	$0x3e, -0x270(%rbp)
000000010000f2cf	jmp	0x10000fabb
000000010000f2d4	movl	(%r14), %eax
000000010000f2d7	movq	0x18(%r15), %rcx
000000010000f2db	movl	%eax, %r12d
000000010000f2de	movq	(%rcx,%r12,8), %rbx
000000010000f2e2	movq	%rbx, %rdi
000000010000f2e5	callq	0x100011286                     ## symbol stub for: _strlen
000000010000f2ea	movq	%r13, %rdi
000000010000f2ed	movq	%rbx, %rsi
000000010000f2f0	movq	%rax, %rdx
000000010000f2f3	callq	_buf_put
000000010000f2f8	movq	0x28(%r15), %rax
000000010000f2fc	cmpl	$0x0, (%rax,%r12,4)
000000010000f301	jle	0x10000fbeb
000000010000f307	movq	%r12, %rcx
000000010000f30a	xorl	%r12d, %r12d
000000010000f30d	movq	%r15, -0x280(%rbp)
000000010000f314	movq	%rcx, -0x290(%rbp)
000000010000f31b	movq	%r14, -0x288(%rbp)
000000010000f322	jmp	0x10000f369
000000010000f324	nopw	%cs:(%rax,%rax)
000000010000f330	movq	-0x278(%rbp), %r13
000000010000f337	movq	%r13, %rdi
000000010000f33a	movq	%r15, %rsi
000000010000f33d	movq	%rbx, %rdx
000000010000f340	xorl	%ecx, %ecx
000000010000f342	callq	_fwp_write
000000010000f347	incq	%r12
000000010000f34a	movq	-0x280(%rbp), %r15
000000010000f351	movq	0x28(%r15), %rax
000000010000f355	movq	-0x290(%rbp), %rcx
000000010000f35c	movslq	(%rax,%rcx,4), %rax
000000010000f360	cmpq	%rax, %r12
000000010000f363	jge	0x10000fbeb
000000010000f369	movq	%r15, %rax
000000010000f36c	movq	0x8(%r14,%r12,8), %r15
000000010000f371	movq	0x30(%rax), %rax
000000010000f375	movq	(%rax,%rcx,8), %rax
000000010000f379	movq	(%rax,%r12,8), %rbx
000000010000f37d	movb	$0x20, -0x270(%rbp)
000000010000f384	movl	$0x1, %edx
000000010000f389	movq	%r13, %rdi
000000010000f38c	leaq	-0x270(%rbp), %rsi
000000010000f393	callq	_buf_put
000000010000f398	movl	(%rbx), %eax
000000010000f39a	cmpq	$0x10, %rax
000000010000f39e	ja	0x10000f330
000000010000f3a0	leaq	0xa1d(%rip), %rcx
000000010000f3a7	movslq	(%rcx,%rax,4), %rax
000000010000f3ab	addq	%rcx, %rax
000000010000f3ae	jmpq	*%rax
000000010000f3b0	movq	%r15, %rcx
000000010000f3b3	shrq	$0x3f, %rcx
000000010000f3b7	testl	%ecx, %ecx
000000010000f3b9	je	0x10000f330
000000010000f3bf	movb	$0x28, -0x270(%rbp)
000000010000f3c6	movl	$0x1, %edx
000000010000f3cb	movq	-0x278(%rbp), %r13
000000010000f3d2	movq	%r13, %rdi
000000010000f3d5	leaq	-0x270(%rbp), %r14
000000010000f3dc	movq	%r14, %rsi
000000010000f3df	callq	_buf_put
000000010000f3e4	movq	%r13, %rdi
000000010000f3e7	movq	%r15, %rsi
000000010000f3ea	movq	%rbx, %rdx
000000010000f3ed	xorl	%ecx, %ecx
000000010000f3ef	callq	_fwp_write
000000010000f3f4	movb	$0x29, -0x270(%rbp)
000000010000f3fb	movl	$0x1, %edx
000000010000f400	movq	%r13, %rdi
000000010000f403	movq	%r14, %rsi
000000010000f406	movq	-0x288(%rbp), %r14
000000010000f40d	callq	_buf_put
000000010000f412	jmp	0x10000f347
000000010000f417	xorl	%ecx, %ecx
000000010000f419	cmpq	$0x1000, %r15                   ## imm = 0x1000
000000010000f420	setae	%cl
000000010000f423	jmp	0x10000f3b7
000000010000f425	movq	0x8(%r15), %rcx
000000010000f429	jmp	0x10000f3b3
000000010000f42b	movl	%r15d, %ecx
000000010000f42e	shrl	$0x1f, %ecx
000000010000f431	jmp	0x10000f3b7
000000010000f433	movq	0x8(%rbx), %rdi
000000010000f437	testq	%rdi, %rdi
000000010000f43a	je	0x10000f330
000000010000f440	leaq	0x3156(%rip), %rsi              ## literal pool for: "Duration"
000000010000f447	callq	0x100011280                     ## symbol stub for: _strcmp
000000010000f44c	xorl	%ecx, %ecx
000000010000f44e	testl	%eax, %eax
000000010000f450	setne	%cl
000000010000f453	jmp	0x10000f3b7
000000010000f458	xorpd	%xmm0, %xmm0
000000010000f45c	movsd	-0x278(%rbp), %xmm1
000000010000f464	ucomisd	%xmm0, %xmm1
000000010000f468	jmp	0x10000f470
000000010000f46a	xorps	%xmm0, %xmm0
000000010000f46d	ucomiss	%xmm0, %xmm1
000000010000f470	leaq	0x314c(%rip), %rax              ## literal pool for: "inf"
000000010000f477	leaq	0x3149(%rip), %rsi              ## literal pool for: "-inf"
000000010000f47e	cmovaq	%rax, %rsi
000000010000f482	leaq	-0x270(%rbp), %rdi
000000010000f489	movl	$0x200, %edx                    ## imm = 0x200
000000010000f48e	callq	0x10001116c                     ## symbol stub for: ___strcpy_chk
000000010000f493	jmp	0x10000fbce
000000010000f498	cmpl	$0x0, 0x10(%r15)
000000010000f49d	je	0x10000facf
000000010000f4a3	movq	%r15, %rax
000000010000f4a6	addq	$0x10, %r15
000000010000f4aa	movq	%rax, -0x280(%rbp)
000000010000f4b1	cmpl	$0x0, 0x48(%rax)
000000010000f4b5	setne	%r12b
000000010000f4b9	testb	%r12b, %r12b
000000010000f4bc	movl	$0x28, %eax
000000010000f4c1	movl	$0x7b, %ecx
000000010000f4c6	cmovnel	%eax, %ecx
000000010000f4c9	movb	%cl, -0x270(%rbp)
000000010000f4cf	leaq	-0x270(%rbp), %rsi
000000010000f4d6	movl	$0x1, %edx
000000010000f4db	movq	%r13, %rdi
000000010000f4de	callq	_buf_put
000000010000f4e3	cmpl	$0x0, (%r15)
000000010000f4e7	movq	-0x280(%rbp), %r15
000000010000f4ee	jle	0x10000f5db
000000010000f4f4	testb	%r12b, %r12b
000000010000f4f7	jne	0x10000f52a
000000010000f4f9	movq	0x18(%r15), %rax
000000010000f4fd	movq	(%rax), %rbx
000000010000f500	movq	%rbx, %rdi
000000010000f503	callq	0x100011286                     ## symbol stub for: _strlen
000000010000f508	movq	%r13, %rdi
000000010000f50b	movq	%rbx, %rsi
000000010000f50e	movq	%rax, %rdx
000000010000f511	callq	_buf_put
000000010000f516	leaq	0x311e(%rip), %rsi              ## literal pool for: " = "
000000010000f51d	movl	$0x3, %edx
000000010000f522	movq	%r13, %rdi
000000010000f525	callq	_buf_put
000000010000f52a	movq	0x8(%r14), %rsi
000000010000f52e	movq	0x20(%r15), %rax
000000010000f532	movq	(%rax), %rdx
000000010000f535	movq	%r13, %rdi
000000010000f538	xorl	%ecx, %ecx
000000010000f53a	callq	_fwp_write
000000010000f53f	cmpl	$0x2, 0x10(%r15)
000000010000f544	jl	0x10000f5db
000000010000f54a	movl	$0x1, %ebx
000000010000f54f	jmp	0x10000f583
000000010000f551	nopw	%cs:(%rax,%rax)
000000010000f560	movq	0x8(%r14,%rbx,8), %rsi
000000010000f565	movq	0x20(%r15), %rax
000000010000f569	movq	(%rax,%rbx,8), %rdx
000000010000f56d	movq	%r13, %rdi
000000010000f570	xorl	%ecx, %ecx
000000010000f572	callq	_fwp_write
000000010000f577	incq	%rbx
000000010000f57a	movslq	0x10(%r15), %rax
000000010000f57e	cmpq	%rax, %rbx
000000010000f581	jge	0x10000f5db
000000010000f583	movl	$0x2, %edx
000000010000f588	movq	%r13, %rdi
000000010000f58b	leaq	0x2fe2(%rip), %rsi              ## literal pool for: ", "
000000010000f592	callq	_buf_put
000000010000f597	testb	%r12b, %r12b
000000010000f59a	jne	0x10000f560
000000010000f59c	movq	0x18(%r15), %rax
000000010000f5a0	movq	(%rax,%rbx,8), %r13
000000010000f5a4	movq	%r13, %rdi
000000010000f5a7	callq	0x100011286                     ## symbol stub for: _strlen
000000010000f5ac	movq	-0x278(%rbp), %rdi
000000010000f5b3	movq	%r13, %rsi
000000010000f5b6	movq	-0x278(%rbp), %r13
000000010000f5bd	movq	%rax, %rdx
000000010000f5c0	callq	_buf_put
000000010000f5c5	movl	$0x3, %edx
000000010000f5ca	movq	%r13, %rdi
000000010000f5cd	leaq	0x3067(%rip), %rsi              ## literal pool for: " = "
000000010000f5d4	callq	_buf_put
000000010000f5d9	jmp	0x10000f560
000000010000f5db	testb	%r12b, %r12b
000000010000f5de	movl	$0x29, %eax
000000010000f5e3	movl	$0x7d, %ecx
000000010000f5e8	cmovnel	%eax, %ecx
000000010000f5eb	movb	%cl, -0x270(%rbp)
000000010000f5f1	jmp	0x10000fabb
000000010000f5f6	cmpq	-0x30(%rbp), %rax
000000010000f5fa	jne	0x10000fd48
000000010000f600	movq	%r13, %rdi
000000010000f603	addq	$0x268, %rsp                    ## imm = 0x268
000000010000f60a	popq	%rbx
000000010000f60b	popq	%r12
000000010000f60d	popq	%r13
000000010000f60f	popq	%r14
000000010000f611	popq	%r15
000000010000f613	popq	%rbp
000000010000f614	jmp	_fwp_escape
000000010000f619	movb	$0x30, -0x70(%rbp)
000000010000f61d	movl	$0x1, %edi
000000010000f622	movl	%edi, %eax
000000010000f624	cmpq	$0x8, %rax
000000010000f628	jae	0x10000f634
000000010000f62a	xorl	%ecx, %ecx
000000010000f62c	movq	%rax, %rdx
000000010000f62f	jmp	0x10000f885
000000010000f634	cmpl	$0x20, %eax
000000010000f637	jae	0x10000f7d1
000000010000f63d	xorl	%ecx, %ecx
000000010000f63f	jmp	0x10000f82f
000000010000f644	movb	$0x2d, -0x270(%rbp)
000000010000f64b	xorl	%r8d, %r8d
000000010000f64e	negq	%r9
000000010000f651	movl	$0x0, %r11d
000000010000f657	sbbq	%r10, %r11
000000010000f65a	movl	$0x1, %r15d
000000010000f660	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
000000010000f66a	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
000000010000f674	movq	%r11, %r14
000000010000f677	nopw	(%rax,%rax)
000000010000f680	movq	%r11, %rcx
000000010000f683	shldq	$0x3f, %r9, %rcx
000000010000f688	shrq	%r14
000000010000f68b	movq	%rcx, %rsi
000000010000f68e	addq	%r14, %rsi
000000010000f691	adcq	$0x0, %rsi
000000010000f695	movq	%rsi, %rax
000000010000f698	mulq	%r10
000000010000f69b	movl	%r15d, %edi
000000010000f69e	shrq	$0x2, %rdx
000000010000f6a2	leaq	(%rdx,%rdx,4), %rax
000000010000f6a6	subq	%rax, %rsi
000000010000f6a9	subq	%rsi, %rcx
000000010000f6ac	sbbq	$0x0, %r14
000000010000f6b0	movq	%rcx, %rsi
000000010000f6b3	movq	%rcx, %rax
000000010000f6b6	mulq	%r10
000000010000f6b9	imulq	%rbx, %rsi
000000010000f6bd	addq	%rsi, %rdx
000000010000f6c0	imulq	%r10, %r14
000000010000f6c4	addq	%rdx, %r14
000000010000f6c7	movq	%rax, %rcx
000000010000f6ca	addq	%rax, %rcx
000000010000f6cd	leaq	(%rcx,%rcx,4), %rcx
000000010000f6d1	movl	%r9d, %edx
000000010000f6d4	subl	%ecx, %edx
000000010000f6d6	orb	$0x30, %dl
000000010000f6d9	movb	%dl, -0x70(%rbp,%r8)
000000010000f6de	incq	%r8
000000010000f6e1	leal	0x1(%rdi), %r15d
000000010000f6e5	cmpq	$0xa, %r9
000000010000f6e9	sbbq	$0x0, %r11
000000010000f6ed	movq	%rax, %r9
000000010000f6f0	movq	%r14, %r11
000000010000f6f3	jae	0x10000f680
000000010000f6f5	testl	%r8d, %r8d
000000010000f6f8	jle	0x10000faf7
000000010000f6fe	movl	%r8d, %eax
000000010000f701	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
000000010000f706	cmpq	$0x8, %rax
000000010000f70a	jae	0x10000fc11
000000010000f710	xorl	%ecx, %ecx
000000010000f712	movq	%rax, %rdx
000000010000f715	jmp	0x10000fcf4
000000010000f71a	movq	0x8(%rcx), %r15
000000010000f71e	movq	0x10(%rcx), %rdx
000000010000f722	subq	%r15, %rdx
000000010000f725	cmpq	%rax, %rdx
000000010000f728	jae	0x10000f8ab
000000010000f72e	movq	%rsi, %rdi
000000010000f731	movl	$0x1, %esi
000000010000f736	callq	_fwp_gc_alloc_slow
000000010000f73b	movq	%rax, %r15
000000010000f73e	jmp	0x10000f8ba
000000010000f743	movq	0x8(%r14), %rsi
000000010000f747	movq	%rsi, %rdx
000000010000f74a	sarq	$0x3f, %rdx
000000010000f74e	leaq	-0x270(%rbp), %rbx
000000010000f755	movq	%rbx, %rdi
000000010000f758	callq	_fwp_fmt_duration
000000010000f75d	jmp	0x10000fbd5
000000010000f762	movb	$0x30, -0x70(%rbp)
000000010000f766	movl	$0x1, %edi
000000010000f76b	movl	%edi, %eax
000000010000f76d	cmpq	$0x8, %rax
000000010000f771	jae	0x10000f77d
000000010000f773	xorl	%ecx, %ecx
000000010000f775	movq	%rax, %rdx
000000010000f778	jmp	0x10000fba3
000000010000f77d	cmpl	$0x20, %eax
000000010000f780	jae	0x10000fb06
000000010000f786	xorl	%ecx, %ecx
000000010000f788	jmp	0x10000fb5e
000000010000f78d	movq	-0x278(%rbp), %r13
000000010000f794	leaq	0x8(%r14), %rbx
000000010000f798	movq	%rbx, %rcx
000000010000f79b	testq	%rsi, %rsi
000000010000f79e	jns	0x10000f7a4
000000010000f7a0	movq	0x10(%r14), %rcx
000000010000f7a4	cmpq	$0x1, %rax
000000010000f7a8	je	0x10000f9b1
000000010000f7ae	cmpq	$0x8, %rax
000000010000f7b2	je	0x10000f9ac
000000010000f7b8	cmpq	$0x2, %rax
000000010000f7bc	jne	0x10000f9bd
000000010000f7c2	cmpl	$0x1, (%rdx)
000000010000f7c5	movzwl	(%rcx), %eax
000000010000f7c8	movswq	%ax, %rsi
000000010000f7cc	jmp	0x10000f9c5
000000010000f7d1	movl	%edi, %edx
000000010000f7d3	andl	$0x1f, %edx
000000010000f7d6	movq	%rax, %rcx
000000010000f7d9	subq	%rdx, %rcx
000000010000f7dc	leaq	-0x260(%rbp), %rsi
000000010000f7e3	movdqa	0x1bf5(%rip), %xmm0
000000010000f7eb	movq	%rax, %r8
000000010000f7ee	nop
000000010000f7f0	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000f7fa	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000f801	pshufb	%xmm0, %xmm2
000000010000f806	pshufb	%xmm0, %xmm1
000000010000f80b	movdqa	%xmm2, -0x10(%rsi)
000000010000f810	movdqa	%xmm1, (%rsi)
000000010000f814	addq	$-0x20, %r8
000000010000f818	addq	$0x20, %rsi
000000010000f81c	cmpq	%r8, %rdx
000000010000f81f	jne	0x10000f7f0
000000010000f821	testq	%rdx, %rdx
000000010000f824	je	0x10000fbc6
000000010000f82a	cmpl	$0x7, %edx
000000010000f82d	jbe	0x10000f885
000000010000f82f	movl	%edi, %edx
000000010000f831	andl	$0x7, %edx
000000010000f834	movq	%rax, %rsi
000000010000f837	subq	%rcx, %rsi
000000010000f83a	leaq	(%rcx,%rbp), %rdi
000000010000f83e	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000f845	movq	%rax, %rcx
000000010000f848	subq	%rdx, %rcx
000000010000f84b	movq	0x1b9d(%rip), %xmm0
000000010000f853	nopw	%cs:(%rax,%rax)
000000010000f860	movq	-0x78(%rbp,%rsi), %xmm1
000000010000f866	pshufb	%xmm0, %xmm1
000000010000f86b	movq	%xmm1, (%rdi)
000000010000f86f	addq	$-0x8, %rsi
000000010000f873	addq	$0x8, %rdi
000000010000f877	cmpq	%rsi, %rdx
000000010000f87a	jne	0x10000f860
000000010000f87c	testq	%rdx, %rdx
000000010000f87f	je	0x10000fbc6
000000010000f885	leaq	-0x70(%rbp), %rsi
000000010000f889	addq	%rsi, %rdx
000000010000f88c	decq	%rdx
000000010000f88f	nop
000000010000f890	movzbl	(%rdx), %esi
000000010000f893	movb	%sil, -0x270(%rbp,%rcx)
000000010000f89b	incq	%rcx
000000010000f89e	decq	%rdx
000000010000f8a1	cmpq	%rcx, %rax
000000010000f8a4	jne	0x10000f890
000000010000f8a6	jmp	0x10000fbc6
000000010000f8ab	addq	%r15, %rax
000000010000f8ae	movq	%rax, 0x8(%rcx)
000000010000f8b2	movq	%r15, %rdi
000000010000f8b5	callq	0x10001114e                     ## symbol stub for: ___bzero
000000010000f8ba	movw	$0x7430, (%r15)                 ## imm = 0x7430
000000010000f8c0	testl	%r12d, %r12d
000000010000f8c3	jle	0x10000f96b
000000010000f8c9	movq	%rbx, %rcx
000000010000f8cc	negq	%rcx
000000010000f8cf	leaq	(%r12,%r15), %rsi
000000010000f8d3	incq	%rsi
000000010000f8d6	xorl	%edi, %edi
000000010000f8d8	movabsq	$0x5555555555555556, %r8        ## imm = 0x5555555555555556
000000010000f8e2	jmp	0x10000f91c
000000010000f8e4	nopw	%cs:(%rax,%rax)
000000010000f8f0	movb	$0x30, %r10b
000000010000f8f3	movb	%r10b, (%rsi,%rdi)
000000010000f8f7	testq	%rdx, %rdx
000000010000f8fa	setne	%dl
000000010000f8fd	testq	%r14, %r14
000000010000f900	sets	%r10b
000000010000f904	andb	%dl, %r10b
000000010000f907	movzbl	%r10b, %edx
000000010000f90b	subq	%rdx, %rax
000000010000f90e	addq	%r9, %rax
000000010000f911	decq	%rdi
000000010000f914	movq	%rax, %r14
000000010000f917	cmpq	%rdi, %rcx
000000010000f91a	je	0x10000f96b
000000010000f91c	movq	%r14, %rax
000000010000f91f	imulq	%r8
000000010000f922	movq	%rdx, %rax
000000010000f925	shrq	$0x3f, %rax
000000010000f929	addq	%rdx, %rax
000000010000f92c	leaq	(%rax,%rax,2), %r9
000000010000f930	movq	%r14, %rdx
000000010000f933	subq	%r9, %rdx
000000010000f936	negq	%r9
000000010000f939	addq	%r14, %r9
000000010000f93c	addq	$0x3, %r9
000000010000f940	cmpq	$-0x3, %rdx
000000010000f944	cmovbq	%rdx, %r9
000000010000f948	testq	%r9, %r9
000000010000f94b	je	0x10000f8f0
000000010000f94d	cmpq	$0x1, %r9
000000010000f951	jne	0x10000f960
000000010000f953	movb	$0x2b, %r10b
000000010000f956	xorl	%r9d, %r9d
000000010000f959	jmp	0x10000f8f3
000000010000f95b	nopl	(%rax,%rax)
000000010000f960	movb	$0x2d, %r10b
000000010000f963	movl	$0x1, %r9d
000000010000f969	jmp	0x10000f8f3
000000010000f96b	movb	$0x0, 0x2(%r15,%rbx)
000000010000f971	movq	%r15, %rdi
000000010000f974	callq	0x100011286                     ## symbol stub for: _strlen
000000010000f979	movq	0x36b0(%rip), %rcx              ## literal pool symbol address: ___stack_chk_guard
000000010000f980	movq	(%rcx), %rcx
000000010000f983	cmpq	-0x30(%rbp), %rcx
000000010000f987	jne	0x10000fd48
000000010000f98d	movq	%r13, %rdi
000000010000f990	movq	%r15, %rsi
000000010000f993	movq	%rax, %rdx
000000010000f996	addq	$0x268, %rsp                    ## imm = 0x268
000000010000f99d	popq	%rbx
000000010000f99e	popq	%r12
000000010000f9a0	popq	%r13
000000010000f9a2	popq	%r14
000000010000f9a4	popq	%r15
000000010000f9a6	popq	%rbp
000000010000f9a7	jmp	_buf_put
000000010000f9ac	movq	(%rcx), %rsi
000000010000f9af	jmp	0x10000f9c9
000000010000f9b1	cmpl	$0x0, (%rdx)
000000010000f9b4	movzbl	(%rcx), %eax
000000010000f9b7	movsbq	%al, %rsi
000000010000f9bb	jmp	0x10000f9c5
000000010000f9bd	cmpl	$0x2, (%rdx)
000000010000f9c0	movl	(%rcx), %eax
000000010000f9c2	movslq	%eax, %rsi
000000010000f9c5	cmovneq	%rax, %rsi
000000010000f9c9	movq	%r13, %rdi
000000010000f9cc	xorl	%ecx, %ecx
000000010000f9ce	callq	_fwp_write
000000010000f9d3	movabsq	$0x7fffffffffffffff, %rax       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000f9dd	decq	%rax
000000010000f9e0	testq	%rax, (%r14)
000000010000f9e3	je	0x10000fab4
000000010000f9e9	movl	$0x1, %r15d
000000010000f9ef	jmp	0x10000fa2d
000000010000f9f1	cmpl	$0x1, (%rdx)
000000010000f9f4	movzwl	(%rcx,%rsi), %eax
000000010000f9f8	movswq	%ax, %rsi
000000010000f9fc	cmovneq	%rax, %rsi
000000010000fa00	movq	-0x278(%rbp), %r13
000000010000fa07	movq	%r13, %rdi
000000010000fa0a	xorl	%ecx, %ecx
000000010000fa0c	callq	_fwp_write
000000010000fa11	incq	%r15
000000010000fa14	movq	(%r14), %rax
000000010000fa17	movabsq	$0x7fffffffffffffff, %rcx       ## imm = 0x7FFFFFFFFFFFFFFF
000000010000fa21	andq	%rcx, %rax
000000010000fa24	cmpq	%rax, %r15
000000010000fa27	jae	0x10000fab4
000000010000fa2d	movl	$0x2, %edx
000000010000fa32	movq	%r13, %rdi
000000010000fa35	leaq	0x2b38(%rip), %rsi              ## literal pool for: ", "
000000010000fa3c	callq	_buf_put
000000010000fa41	movq	0x38(%r12), %rdx
000000010000fa46	movl	$0x8, %eax
000000010000fa4b	testq	%rdx, %rdx
000000010000fa4e	je	0x10000fa63
000000010000fa50	movl	(%rdx), %ecx
000000010000fa52	cmpq	$0xa, %rcx
000000010000fa56	ja	0x10000fa63
000000010000fa58	leaq	0x1c59(%rip), %rax
000000010000fa5f	movq	(%rax,%rcx,8), %rax
000000010000fa63	cmpq	$0x0, (%r14)
000000010000fa67	movq	%rbx, %rcx
000000010000fa6a	jns	0x10000fa70
000000010000fa6c	movq	0x10(%r14), %rcx
000000010000fa70	movq	%rax, %rsi
000000010000fa73	imulq	%r15, %rsi
000000010000fa77	cmpq	$0x1, %rax
000000010000fa7b	je	0x10000fa96
000000010000fa7d	cmpq	$0x2, %rax
000000010000fa81	je	0x10000f9f1
000000010000fa87	cmpq	$0x8, %rax
000000010000fa8b	jne	0x10000faa6
000000010000fa8d	movq	(%rcx,%rsi), %rsi
000000010000fa91	jmp	0x10000fa00
000000010000fa96	cmpl	$0x0, (%rdx)
000000010000fa99	movzbl	(%rcx,%rsi), %eax
000000010000fa9d	movsbq	%al, %rsi
000000010000faa1	jmp	0x10000f9fc
000000010000faa6	cmpl	$0x2, (%rdx)
000000010000faa9	movl	(%rcx,%rsi), %eax
000000010000faac	movslq	%eax, %rsi
000000010000faaf	jmp	0x10000f9fc
000000010000fab4	movb	$0x5d, -0x270(%rbp)
000000010000fabb	leaq	-0x270(%rbp), %rsi
000000010000fac2	movl	$0x1, %edx
000000010000fac7	movq	%r13, %rdi
000000010000faca	jmp	0x10000fbe6
000000010000facf	movq	0x355a(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fad6	movq	(%rax), %rax
000000010000fad9	cmpq	-0x30(%rbp), %rax
000000010000fadd	jne	0x10000fd48
000000010000fae3	leaq	0x2b4e(%rip), %rsi              ## literal pool for: "()"
000000010000faea	movl	$0x2, %edx
000000010000faef	movq	%r13, %rdi
000000010000faf2	jmp	0x10000f996
000000010000faf7	xorl	%eax, %eax
000000010000faf9	movb	$0x0, -0x26f(%rbp,%rax)
000000010000fb01	jmp	0x10000fbce
000000010000fb06	movl	%edi, %edx
000000010000fb08	andl	$0x1f, %edx
000000010000fb0b	movq	%rax, %rcx
000000010000fb0e	subq	%rdx, %rcx
000000010000fb11	leaq	-0x260(%rbp), %rsi
000000010000fb18	movdqa	0x18c0(%rip), %xmm0
000000010000fb20	movq	%rax, %r8
000000010000fb23	movdqu	-0x90(%rbp,%r8), %xmm1
000000010000fb2d	movdqu	-0x80(%rbp,%r8), %xmm2
000000010000fb34	pshufb	%xmm0, %xmm2
000000010000fb39	pshufb	%xmm0, %xmm1
000000010000fb3e	movdqa	%xmm2, -0x10(%rsi)
000000010000fb43	movdqa	%xmm1, (%rsi)
000000010000fb47	addq	$-0x20, %r8
000000010000fb4b	addq	$0x20, %rsi
000000010000fb4f	cmpq	%r8, %rdx
000000010000fb52	jne	0x10000fb23
000000010000fb54	testq	%rdx, %rdx
000000010000fb57	je	0x10000fbc6
000000010000fb59	cmpl	$0x7, %edx
000000010000fb5c	jbe	0x10000fba3
000000010000fb5e	movl	%edi, %edx
000000010000fb60	andl	$0x7, %edx
000000010000fb63	movq	%rax, %rsi
000000010000fb66	subq	%rcx, %rsi
000000010000fb69	leaq	(%rcx,%rbp), %rdi
000000010000fb6d	addq	$-0x270, %rdi                   ## imm = 0xFD90
000000010000fb74	movq	%rax, %rcx
000000010000fb77	subq	%rdx, %rcx
000000010000fb7a	movq	0x186e(%rip), %xmm0
000000010000fb82	movq	-0x78(%rbp,%rsi), %xmm1
000000010000fb88	pshufb	%xmm0, %xmm1
000000010000fb8d	movq	%xmm1, (%rdi)
000000010000fb91	addq	$-0x8, %rsi
000000010000fb95	addq	$0x8, %rdi
000000010000fb99	cmpq	%rsi, %rdx
000000010000fb9c	jne	0x10000fb82
000000010000fb9e	testq	%rdx, %rdx
000000010000fba1	je	0x10000fbc6
000000010000fba3	leaq	-0x70(%rbp), %rsi
000000010000fba7	addq	%rsi, %rdx
000000010000fbaa	decq	%rdx
000000010000fbad	nopl	(%rax)
000000010000fbb0	movzbl	(%rdx), %esi
000000010000fbb3	movb	%sil, -0x270(%rbp,%rcx)
000000010000fbbb	incq	%rcx
000000010000fbbe	decq	%rdx
000000010000fbc1	cmpq	%rcx, %rax
000000010000fbc4	jne	0x10000fbb0
000000010000fbc6	movb	$0x0, -0x270(%rbp,%rax)
000000010000fbce	leaq	-0x270(%rbp), %rbx
000000010000fbd5	movq	%rbx, %rdi
000000010000fbd8	callq	0x100011286                     ## symbol stub for: _strlen
000000010000fbdd	movq	%r13, %rdi
000000010000fbe0	movq	%rbx, %rsi
000000010000fbe3	movq	%rax, %rdx
000000010000fbe6	callq	_buf_put
000000010000fbeb	movq	0x343e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fbf2	movq	(%rax), %rax
000000010000fbf5	cmpq	-0x30(%rbp), %rax
000000010000fbf9	jne	0x10000fd48
000000010000fbff	addq	$0x268, %rsp                    ## imm = 0x268
000000010000fc06	popq	%rbx
000000010000fc07	popq	%r12
000000010000fc09	popq	%r13
000000010000fc0b	popq	%r14
000000010000fc0d	popq	%r15
000000010000fc0f	popq	%rbp
000000010000fc10	retq
000000010000fc11	cmpl	$0x20, %eax
000000010000fc14	jae	0x10000fc1a
000000010000fc16	xorl	%ecx, %ecx
000000010000fc18	jmp	0x10000fc8f
000000010000fc1a	movl	%r8d, %edx
000000010000fc1d	andl	$0x1f, %edx
000000010000fc20	movq	%rax, %rcx
000000010000fc23	subq	%rdx, %rcx
000000010000fc26	movl	%edi, %esi
000000010000fc28	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
000000010000fc2e	leaq	(%rsi,%rbp), %r9
000000010000fc32	addq	$-0x80, %r9
000000010000fc36	movl	%edi, %r10d
000000010000fc39	andl	$0x1f, %r10d
000000010000fc3d	subq	%r10, %rsi
000000010000fc40	xorl	%r10d, %r10d
000000010000fc43	movdqa	0x1795(%rip), %xmm0
000000010000fc4b	movdqu	-0x10(%r9), %xmm1
000000010000fc51	movdqu	(%r9), %xmm2
000000010000fc56	pshufb	%xmm0, %xmm2
000000010000fc5b	pshufb	%xmm0, %xmm1
000000010000fc60	movdqu	%xmm2, -0x26f(%rbp,%r10)
000000010000fc6a	movdqu	%xmm1, -0x25f(%rbp,%r10)
000000010000fc74	addq	$0x20, %r10
000000010000fc78	addq	$-0x20, %r9
000000010000fc7c	cmpq	%r10, %rsi
000000010000fc7f	jne	0x10000fc4b
000000010000fc81	testq	%rdx, %rdx
000000010000fc84	je	0x10000fd26
000000010000fc8a	cmpl	$0x7, %edx
000000010000fc8d	jbe	0x10000fcf4
000000010000fc8f	movq	%rcx, %rsi
000000010000fc92	movl	%r8d, %edx
000000010000fc95	andl	$0x7, %edx
000000010000fc98	movq	%rax, %rcx
000000010000fc9b	subq	%rdx, %rcx
000000010000fc9e	movq	%rsi, %r8
000000010000fca1	negq	%r8
000000010000fca4	leaq	(%r8,%rbp), %r9
000000010000fca8	addq	$-0x70, %r9
000000010000fcac	movl	%edi, %r8d
000000010000fcaf	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
000000010000fcb6	addq	%r8, %r9
000000010000fcb9	addq	$-0x8, %r9
000000010000fcbd	movl	%edi, %r10d
000000010000fcc0	andl	$0x7, %r10d
000000010000fcc4	subq	%r10, %r8
000000010000fcc7	movq	0x1721(%rip), %xmm0
000000010000fccf	movq	(%r9), %xmm1
000000010000fcd4	pshufb	%xmm0, %xmm1
000000010000fcd9	movq	%xmm1, -0x26f(%rbp,%rsi)
000000010000fce2	addq	$0x8, %rsi
000000010000fce6	addq	$-0x8, %r9
000000010000fcea	cmpq	%rsi, %r8
000000010000fced	jne	0x10000fccf
000000010000fcef	testq	%rdx, %rdx
000000010000fcf2	je	0x10000fd26
000000010000fcf4	leaq	-0x70(%rbp), %rsi
000000010000fcf8	addq	%rsi, %rdx
000000010000fcfb	decq	%rdx
000000010000fcfe	andl	$0x7fffffff, %edi               ## imm = 0x7FFFFFFF
000000010000fd04	nopw	%cs:(%rax,%rax)
000000010000fd10	movzbl	(%rdx), %esi
000000010000fd13	movb	%sil, -0x26f(%rbp,%rcx)
000000010000fd1b	incq	%rcx
000000010000fd1e	decq	%rdx
000000010000fd21	cmpq	%rcx, %rdi
000000010000fd24	jne	0x10000fd10
000000010000fd26	movb	$0x0, -0x26f(%rbp,%rax)
000000010000fd2e	jmp	0x10000fbce
000000010000fd33	movq	%rbx, %rdi
000000010000fd36	movsd	-0x280(%rbp), %xmm0
000000010000fd3e	movl	$0x9, %esi
000000010000fd43	jmp	0x10000ebaa
000000010000fd48	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
000000010000fd4d	movl	$0x4e614e, -0x270(%rbp)         ## imm = 0x4E614E
000000010000fd57	jmp	0x10000fbce
000000010000fd5c	repne		jmp	0x10000fd5e
000000010000fd5f	pushq	%rdx
000000010000fd61	jmp	0x10000fd62
000000010000fd63	pushq	%rdx
000000010000fd65	jmp	0x10000fd66
000000010000fd67	pushq	%rdx
000000010000fd69	jmp	0x10000fd6a
000000010000fd6b	decl	-0x4000011(%rsi)
000000010000fd71	jmp	0x10000fd72
000000010000fd73	.byte 0xff #bad opcode
000000010000fd74	sti
000000010000fd75	jmp	0x10000fd76
000000010000fd77	.byte 0xff #bad opcode
000000010000fd78	sti
000000010000fd79	jmp	0x10000fd7a
000000010000fd7b	.byte 0xff #bad opcode
000000010000fd7c	sti
000000010000fd7d	jmp	0x10000fd7e
000000010000fd7f	jmpq	*%rax
000000010000fd81	outb	%al, %dx
000000010000fd82	.byte 0xff #bad opcode
000000010000fd83	.byte 0xff #bad opcode
000000010000fd84	movl	$0xbefffff2, %edx               ## imm = 0xBEFFFFF2
000000010000fd89	inl	%dx, %eax
000000010000fd8a	.byte 0xff #bad opcode
000000010000fd8b	pushq	-0x22000012(%rbp)
000000010000fd91	.byte 0xf1 #bad opcode
000000010000fd92	.byte 0xff #bad opcode
000000010000fd93	ljmpl	*0x40ffffed(%rcx)
000000010000fd99	lock
000000010000fd9a	.byte 0xff #bad opcode
000000010000fd9b	incl	-0x13(%rcx)
000000010000fd9e	.byte 0xff #bad opcode
000000010000fd9f	.byte 0xff #bad opcode
000000010000fda0	jl	0x10000fd93
000000010000fda2	.byte 0xff #bad opcode
000000010000fda3	jmpq	*(%rax)
000000010000fda5	inb	%dx, %al
000000010000fda6	.byte 0xff #bad opcode
000000010000fda7	jmpq	*(%rax)
000000010000fda9	inb	%dx, %al
000000010000fdaa	.byte 0xff #bad opcode
000000010000fdab	incl	%esp
000000010000fdad	lock
000000010000fdae	.byte 0xff #bad opcode
000000010000fdaf	pushq	(%rax)
000000010000fdb1	.byte 0xf1 #bad opcode
000000010000fdb2	.byte 0xff #bad opcode
000000010000fdb3	callq	*(%rsi)
000000010000fdb5	cmc
000000010000fdb6	.byte 0xff #bad opcode
000000010000fdb7	.byte 0xff #bad opcode
000000010000fdb8	cmc
000000010000fdba	.byte 0xff #bad opcode
000000010000fdbb	decl	0x5bffffee(%rbp)
000000010000fdc1	outb	%al, %dx
000000010000fdc2	.byte 0xff #bad opcode
000000010000fdc3	.byte 0xff #bad opcode
000000010000fdc4	inb	%dx, %al
000000010000fdc5	cmc
000000010000fdc6	.byte 0xff #bad opcode
000000010000fdc7	.byte 0xff #bad opcode
000000010000fdc8	inb	%dx, %al
000000010000fdc9	cmc
000000010000fdca	.byte 0xff #bad opcode
000000010000fdcb	.byte 0xff #bad opcode
000000010000fdcc	inb	%dx, %al
000000010000fdcd	cmc
000000010000fdce	.byte 0xff #bad opcode
000000010000fdcf	.byte 0xff #bad opcode
000000010000fdd0	inb	%dx, %al
000000010000fdd1	cmc
000000010000fdd2	.byte 0xff #bad opcode
000000010000fdd3	jmpq	*-0xa(%rcx)
000000010000fdd6	.byte 0xff #bad opcode
000000010000fdd7	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fddb	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fddf	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fde3	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fde7	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fdeb	jmpq	*-0xa(%rdi)
000000010000fdee	.byte 0xff #bad opcode
000000010000fdef	.byte 0xff #bad opcode
000000010000fdf0	inb	%dx, %al
000000010000fdf1	cmc
000000010000fdf2	.byte 0xff #bad opcode
000000010000fdf3	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fdf7	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fdfb	callq	*-0xa(%rbx)
000000010000fdfe	.byte 0xff #bad opcode
000000010000fdff	ljmpl	*-0x1(%rbp,%rsi,8)
000000010000fe03	ljmpl	*-0xa(%rdi)
000000010000fe06	.byte 0xff #bad opcode
000000010000fe07	decl	(%rdi)
000000010000fe09	.byte 0x1f #bad opcode
000000010000fe0a	testb	%al, (%rax)
000000010000fe0c	addb	%al, (%rax)
000000010000fe0e	addb	%al, (%rax)
_fwp_escape:
000000010000fe10	pushq	%rbp
000000010000fe11	movq	%rsp, %rbp
000000010000fe14	pushq	%r15
000000010000fe16	pushq	%r14
000000010000fe18	pushq	%r13
000000010000fe1a	pushq	%r12
000000010000fe1c	pushq	%rbx
000000010000fe1d	subq	$0x18, %rsp
000000010000fe21	movq	%rdx, %r14
000000010000fe24	movq	%rsi, %r15
000000010000fe27	movq	%rdi, %rbx
000000010000fe2a	movq	0x31ff(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000fe31	movq	(%rax), %rax
000000010000fe34	movq	%rax, -0x30(%rbp)
000000010000fe38	movb	$0x22, -0x40(%rbp)
000000010000fe3c	leaq	-0x40(%rbp), %rsi
000000010000fe40	movl	$0x1, %edx
000000010000fe45	callq	_buf_put
000000010000fe4a	testq	%r14, %r14
000000010000fe4d	je	0x10000ff49
000000010000fe53	leaq	0x12a(%rip), %r12
000000010000fe5a	xorl	%r13d, %r13d
000000010000fe5d	jmp	0x10000fe81
000000010000fe5f	movl	$0x2, %edx
000000010000fe64	movq	%rbx, %rdi
000000010000fe67	leaq	0x27f4(%rip), %rsi              ## literal pool for: "\\r"
000000010000fe6e	nop
000000010000fe70	callq	_buf_put
000000010000fe75	incq	%r13
000000010000fe78	cmpq	%r13, %r14
000000010000fe7b	je	0x10000ff49
000000010000fe81	movzbl	(%r15,%r13), %eax
000000010000fe86	movzbl	%al, %ecx
000000010000fe89	leal	-0x9(%rcx), %edx
000000010000fe8c	cmpl	$0x19, %edx
000000010000fe8f	ja	0x10000feb0
000000010000fe91	movslq	(%r12,%rdx,4), %rdx
000000010000fe95	addq	%r12, %rdx
000000010000fe98	jmpq	*%rdx
000000010000fe9a	movl	$0x2, %edx
000000010000fe9f	movq	%rbx, %rdi
000000010000fea2	leaq	0x27b6(%rip), %rsi              ## literal pool for: "\\t"
000000010000fea9	jmp	0x10000fe70
000000010000feab	nopl	(%rax,%rax)
000000010000feb0	cmpl	$0x5c, %ecx
000000010000feb3	jne	0x10000fec6
000000010000feb5	movl	$0x2, %edx
000000010000feba	movq	%rbx, %rdi
000000010000febd	leaq	0x2795(%rip), %rsi              ## literal pool for: "\\\\"
000000010000fec4	jmp	0x10000fe70
000000010000fec6	cmpb	$0x20, %al
000000010000fec8	setae	%dl
000000010000fecb	cmpb	$0x7f, %al
000000010000fecd	setne	%sil
000000010000fed1	testb	%sil, %dl
000000010000fed4	jne	0x10000ff35
000000010000fed6	movl	$0x10, %esi
000000010000fedb	leaq	-0x40(%rbp), %r12
000000010000fedf	movq	%r12, %rdi
000000010000fee2	leaq	0x277c(%rip), %rdx              ## literal pool for: "\\u{%x}"
000000010000fee9	xorl	%eax, %eax
000000010000feeb	callq	0x10001126e                     ## symbol stub for: _snprintf
000000010000fef0	movq	%r12, %rdi
000000010000fef3	callq	0x100011286                     ## symbol stub for: _strlen
000000010000fef8	movq	%rbx, %rdi
000000010000fefb	movq	%r12, %rsi
000000010000fefe	leaq	0x7f(%rip), %r12
000000010000ff05	movq	%rax, %rdx
000000010000ff08	jmp	0x10000fe70
000000010000ff0d	movl	$0x2, %edx
000000010000ff12	movq	%rbx, %rdi
000000010000ff15	leaq	0x273a(%rip), %rsi              ## literal pool for: "\\\""
000000010000ff1c	jmp	0x10000fe70
000000010000ff21	movl	$0x2, %edx
000000010000ff26	movq	%rbx, %rdi
000000010000ff29	leaq	0x272c(%rip), %rsi              ## literal pool for: "\\n"
000000010000ff30	jmp	0x10000fe70
000000010000ff35	movb	%al, -0x40(%rbp)
000000010000ff38	movl	$0x1, %edx
000000010000ff3d	movq	%rbx, %rdi
000000010000ff40	leaq	-0x40(%rbp), %rsi
000000010000ff44	jmp	0x10000fe70
000000010000ff49	movb	$0x22, -0x40(%rbp)
000000010000ff4d	leaq	-0x40(%rbp), %rsi
000000010000ff51	movl	$0x1, %edx
000000010000ff56	movq	%rbx, %rdi
000000010000ff59	callq	_buf_put
000000010000ff5e	movq	0x30cb(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010000ff65	movq	(%rax), %rax
000000010000ff68	cmpq	-0x30(%rbp), %rax
000000010000ff6c	jne	0x10000ff7d
000000010000ff6e	addq	$0x18, %rsp
000000010000ff72	popq	%rbx
000000010000ff73	popq	%r12
000000010000ff75	popq	%r13
000000010000ff77	popq	%r14
000000010000ff79	popq	%r15
000000010000ff7b	popq	%rbp
000000010000ff7c	retq
000000010000ff7d	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
000000010000ff82	nop
000000010000ff84	.byte 0x16 #bad opcode
000000010000ff85	.byte 0xff #bad opcode
000000010000ff86	.byte 0xff #bad opcode
000000010000ff87	lcalll	*0x42ffffff(%rbp)
000000010000ff8d	.byte 0xff #bad opcode
000000010000ff8e	.byte 0xff #bad opcode
000000010000ff8f	incl	-0x1(%rdx)
000000010000ff92	.byte 0xff #bad opcode
000000010000ff93	.byte 0xff #bad opcode
000000010000ff94	.byte 0xdb #bad opcode
000000010000ff95	.byte 0xfe #bad opcode
000000010000ff96	.byte 0xff #bad opcode
000000010000ff97	incl	-0x1(%rdx)
000000010000ff9a	.byte 0xff #bad opcode
000000010000ff9b	incl	-0x1(%rdx)
000000010000ff9e	.byte 0xff #bad opcode
000000010000ff9f	incl	-0x1(%rdx)
000000010000ffa2	.byte 0xff #bad opcode
000000010000ffa3	incl	-0x1(%rdx)
000000010000ffa6	.byte 0xff #bad opcode
000000010000ffa7	incl	-0x1(%rdx)
000000010000ffaa	.byte 0xff #bad opcode
000000010000ffab	incl	-0x1(%rdx)
000000010000ffae	.byte 0xff #bad opcode
000000010000ffaf	incl	-0x1(%rdx)
000000010000ffb2	.byte 0xff #bad opcode
000000010000ffb3	incl	-0x1(%rdx)
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
000000010000ffe7	decl	0xfffffff(%rcx)
000000010000ffed	.byte 0x1f #bad opcode
000000010000ffee	addb	%dl, 0x48(%rbp)
000000010000fff2	movl	%esp, %ebp
000000010000fff4	pushq	%r15
000000010000fff6	pushq	%r14
000000010000fff8	pushq	%r13
000000010000fffa	pushq	%r12
000000010000fffc	pushq	%rbx
000000010000fffd	subq	$0x88, %rsp
0000000100010004	movq	0x3025(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010001000b	movq	(%rax), %rax
000000010001000e	movq	%rax, -0x30(%rbp)
0000000100010012	movq	%rsi, %rax
0000000100010015	orq	%rdx, %rax
0000000100010018	je	0x1000102e9
000000010001001e	movq	%rdx, %r8
0000000100010021	movabsq	$0xd2fe1d625c23f1d, %rcx        ## imm = 0xD2FE1D625C23F1D
000000010001002b	imulq	%rsi, %rcx
000000010001002f	movabsq	$0x1c52799e4f3b10d, %r9         ## imm = 0x1C52799E4F3B10D
0000000100010039	movq	%rsi, %rax
000000010001003c	mulq	%r9
000000010001003f	addq	%rcx, %rdx
0000000100010042	imulq	%r8, %r9
0000000100010046	addq	%rdx, %r9
0000000100010049	movabsq	$0x6baf6aa35234a000, %rcx       ## imm = 0x6BAF6AA35234A000
0000000100010053	addq	%rax, %rcx
0000000100010056	movabsq	$0x4e2fff937, %rax              ## imm = 0x4E2FFF937
0000000100010060	adcq	%r9, %rax
0000000100010063	movq	%rax, %rdx
0000000100010066	shrdq	$0xd, %rcx, %rdx
000000010001006b	shldq	$0x33, %rcx, %rax
0000000100010070	movabsq	$-0x6c89450955cadcb6, %rcx      ## imm = 0x9376BAF6AA35234A
000000010001007a	cmpq	%rax, %rcx
000000010001007d	movl	$0x4e2fff, %eax                 ## imm = 0x4E2FFF
0000000100010082	sbbq	%rdx, %rax
0000000100010085	jae	0x100010306
000000010001008b	movabsq	$-0x3a31c473c99e4d4d, %rcx      ## imm = 0xC5CE3B8C3661B2B3
0000000100010095	movabsq	$0x1a8d52046a475fc3, %r9        ## imm = 0x1A8D52046A475FC3
000000010001009f	movq	%rsi, %rax
00000001000100a2	mulq	%r9
00000001000100a5	imulq	%rsi, %rcx
00000001000100a9	addq	%rcx, %rdx
00000001000100ac	imulq	%r8, %r9
00000001000100b0	addq	%rdx, %r9
00000001000100b3	movabsq	$0x4f473f91d116a800, %rcx       ## imm = 0x4F473F91D116A800
00000001000100bd	addq	%rax, %rcx
00000001000100c0	movabsq	$0x494cff9a3f, %rax             ## imm = 0x494CFF9A3F
00000001000100ca	adcq	%r9, %rax
00000001000100cd	movq	%rax, %rdx
00000001000100d0	shrdq	$0xb, %rcx, %rdx
00000001000100d5	shldq	$0x35, %rcx, %rax
00000001000100da	movabsq	$-0x702c2e301b8bba55, %rcx      ## imm = 0x8FD3D1CFE47445AB
00000001000100e4	cmpq	%rcx, %rax
00000001000100e7	sbbq	$0x12533fe6, %rdx               ## imm = 0x12533FE6
00000001000100ee	jb	0x100010328
00000001000100f4	movabsq	$-0x68ea82c8d0468782, %rcx      ## imm = 0x97157D372FB9787E
00000001000100fe	imulq	%rsi, %rcx
0000000100010102	movabsq	$-0x71b831bdc5d16393, %r9       ## imm = 0x8E47CE423A2E9C6D
000000010001010c	movq	%rsi, %rax
000000010001010f	mulq	%r9
0000000100010112	addq	%rcx, %rdx
0000000100010115	imulq	%r8, %r9
0000000100010119	addq	%rdx, %r9
000000010001011c	movabsq	$-0x5ad34674bfabba00, %rcx      ## imm = 0xA52CB98B40544600
0000000100010126	addq	%rax, %rcx
0000000100010129	movabsq	$0x44b82fa09b5, %rax            ## imm = 0x44B82FA09B5
0000000100010133	adcq	%r9, %rax
0000000100010136	movq	%rax, %rdx
0000000100010139	shrdq	$0x9, %rcx, %rdx
000000010001013e	shldq	$0x37, %rcx, %rax
0000000100010143	movabsq	$-0x4a5ad34674bfabb9, %rcx      ## imm = 0xB5A52CB98B405447
000000010001014d	cmpq	%rcx, %rax
0000000100010150	movabsq	$0x44b82fa09, %rax              ## imm = 0x44B82FA09
000000010001015a	sbbq	%rax, %rdx
000000010001015d	jb	0x100010428
0000000100010163	movabsq	$-0x3a81dc0db2702a35, %rcx      ## imm = 0xC57E23F24D8FD5CB
000000010001016d	imulq	%rsi, %rcx
0000000100010171	movabsq	$0x790fb65668c26139, %r9        ## imm = 0x790FB65668C26139
000000010001017b	movq	%rsi, %rax
000000010001017e	mulq	%r9
0000000100010181	addq	%rcx, %rdx
0000000100010184	imulq	%r8, %r9
0000000100010188	addq	%rdx, %r9
000000010001018b	movabsq	$-0x5929670196d8f500, %rcx      ## imm = 0xA6D698FE69270B00
0000000100010195	addq	%rax, %rcx
0000000100010198	movabsq	$0x218def416bdb1, %rax          ## imm = 0x218DEF416BDB1
00000001000101a2	adcq	%r9, %rax
00000001000101a5	movq	%rax, %rdx
00000001000101a8	shrdq	$0x6, %rcx, %rdx
00000001000101ad	shldq	$0x3a, %rcx, %rax
00000001000101b2	movabsq	$-0x72c94b380cb6c7a7, %rcx      ## imm = 0x8D36B4C7F3493859
00000001000101bc	cmpq	%rcx, %rax
00000001000101bf	movabsq	$0x10c6f7a0b5ed, %rax           ## imm = 0x10C6F7A0B5ED
00000001000101c9	sbbq	%rax, %rdx
00000001000101cc	jb	0x100010439
00000001000101d2	movabsq	$0x6e978d4fdf3b645a, %rcx       ## imm = 0x6E978D4FDF3B645A
00000001000101dc	imulq	%rsi, %rcx
00000001000101e0	movabsq	$0x1cac083126e978d5, %r9        ## imm = 0x1CAC083126E978D5
00000001000101ea	movq	%rsi, %rax
00000001000101ed	mulq	%r9
00000001000101f0	addq	%rcx, %rdx
00000001000101f3	imulq	%r8, %r9
00000001000101f7	addq	%rdx, %r9
00000001000101fa	movabsq	$0x76c8b43958106248, %rcx       ## imm = 0x76C8B43958106248
0000000100010204	addq	%rax, %rcx
0000000100010207	movabsq	$0x10624dd2f1a9fbe, %rax        ## imm = 0x10624DD2F1A9FBE
0000000100010211	adcq	%r9, %rax
0000000100010214	movq	%rax, %rdx
0000000100010217	shrdq	$0x3, %rcx, %rdx
000000010001021c	shldq	$0x3d, %rcx, %rax
0000000100010221	movabsq	$-0x624dd2f1a9fbe76d, %rcx      ## imm = 0x9DB22D0E56041893
000000010001022b	cmpq	%rcx, %rax
000000010001022e	movabsq	$0x4189374bc6a7ef, %rax         ## imm = 0x4189374BC6A7EF
0000000100010238	sbbq	%rax, %rdx
000000010001023b	jb	0x10001044a
0000000100010241	testq	%r8, %r8
0000000100010244	js	0x10001086c
000000010001024a	xorl	%r10d, %r10d
000000010001024d	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010257	movabsq	$-0x3333333333333334, %rbx      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010261	movq	%r8, %r14
0000000100010264	nopw	%cs:(%rax,%rax)
0000000100010270	movq	%r8, %rcx
0000000100010273	shldq	$0x3f, %rsi, %rcx
0000000100010278	shrq	%r14
000000010001027b	movq	%rcx, %r9
000000010001027e	addq	%r14, %r9
0000000100010281	adcq	$0x0, %r9
0000000100010285	movq	%r9, %rax
0000000100010288	mulq	%r11
000000010001028b	shrq	$0x2, %rdx
000000010001028f	leaq	(%rdx,%rdx,4), %rax
0000000100010293	subq	%rax, %r9
0000000100010296	subq	%r9, %rcx
0000000100010299	sbbq	$0x0, %r14
000000010001029d	movq	%rcx, %r9
00000001000102a0	imulq	%rbx, %r9
00000001000102a4	movq	%rcx, %rax
00000001000102a7	mulq	%r11
00000001000102aa	addq	%r9, %rdx
00000001000102ad	imulq	%r11, %r14
00000001000102b1	addq	%rdx, %r14
00000001000102b4	movq	%rax, %rcx
00000001000102b7	addq	%rax, %rcx
00000001000102ba	leaq	(%rcx,%rcx,4), %rcx
00000001000102be	movl	%esi, %edx
00000001000102c0	subl	%ecx, %edx
00000001000102c2	orb	$0x30, %dl
00000001000102c5	movb	%dl, -0x70(%rbp,%r10)
00000001000102ca	incq	%r10
00000001000102cd	cmpq	$0xa, %rsi
00000001000102d1	sbbq	$0x0, %r8
00000001000102d5	movq	%rax, %rsi
00000001000102d8	movq	%r14, %r8
00000001000102db	jae	0x100010270
00000001000102dd	testl	%r10d, %r10d
00000001000102e0	jg	0x1000102f3
00000001000102e2	xorl	%eax, %eax
00000001000102e4	jmp	0x100010406
00000001000102e9	movb	$0x30, -0x70(%rbp)
00000001000102ed	movl	$0x1, %r10d
00000001000102f3	movl	%r10d, %eax
00000001000102f6	cmpq	$0x8, %rax
00000001000102fa	jae	0x10001031f
00000001000102fc	xorl	%ecx, %ecx
00000001000102fe	movq	%rax, %rdx
0000000100010301	jmp	0x1000103e2
0000000100010306	movq	%rdi, %r14
0000000100010309	movabsq	$0x34630b8a000, %rdx            ## imm = 0x34630B8A000
0000000100010313	leaq	_fwp_fmt_duration.units(%rip), %rbx
000000010001031a	jmp	0x100010459
000000010001031f	cmpl	$0x20, %eax
0000000100010322	jae	0x100010341
0000000100010324	xorl	%ecx, %ecx
0000000100010326	jmp	0x10001039b
0000000100010328	movq	%rdi, %r14
000000010001032b	movabsq	$0xdf8475800, %rdx              ## imm = 0xDF8475800
0000000100010335	leaq	0x3654(%rip), %rbx
000000010001033c	jmp	0x100010459
0000000100010341	movl	%r10d, %edx
0000000100010344	andl	$0x1f, %edx
0000000100010347	movq	%rax, %rcx
000000010001034a	subq	%rdx, %rcx
000000010001034d	leaq	-0xa0(%rbp), %rsi
0000000100010354	movdqa	0x1084(%rip), %xmm0
000000010001035c	movq	%rax, %r8
000000010001035f	nop
0000000100010360	movdqu	-0x90(%rbp,%r8), %xmm1
000000010001036a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010371	pshufb	%xmm0, %xmm2
0000000100010376	pshufb	%xmm0, %xmm1
000000010001037b	movdqa	%xmm2, -0x10(%rsi)
0000000100010380	movdqa	%xmm1, (%rsi)
0000000100010384	addq	$-0x20, %r8
0000000100010388	addq	$0x20, %rsi
000000010001038c	cmpq	%r8, %rdx
000000010001038f	jne	0x100010360
0000000100010391	testq	%rdx, %rdx
0000000100010394	je	0x100010406
0000000100010396	cmpl	$0x7, %edx
0000000100010399	jbe	0x1000103e2
000000010001039b	movl	%r10d, %edx
000000010001039e	andl	$0x7, %edx
00000001000103a1	movq	%rax, %rsi
00000001000103a4	subq	%rcx, %rsi
00000001000103a7	leaq	(%rcx,%rbp), %r8
00000001000103ab	addq	$-0xb0, %r8
00000001000103b2	movq	%rax, %rcx
00000001000103b5	subq	%rdx, %rcx
00000001000103b8	movq	0x1030(%rip), %xmm0
00000001000103c0	movq	-0x78(%rbp,%rsi), %xmm1
00000001000103c6	pshufb	%xmm0, %xmm1
00000001000103cb	movq	%xmm1, (%r8)
00000001000103d0	addq	$-0x8, %rsi
00000001000103d4	addq	$0x8, %r8
00000001000103d8	cmpq	%rsi, %rdx
00000001000103db	jne	0x1000103c0
00000001000103dd	testq	%rdx, %rdx
00000001000103e0	je	0x100010406
00000001000103e2	leaq	-0x70(%rbp), %rsi
00000001000103e6	addq	%rsi, %rdx
00000001000103e9	decq	%rdx
00000001000103ec	nopl	(%rax)
00000001000103f0	movzbl	(%rdx), %esi
00000001000103f3	movb	%sil, -0xb0(%rbp,%rcx)
00000001000103fb	incq	%rcx
00000001000103fe	decq	%rdx
0000000100010401	cmpq	%rcx, %rax
0000000100010404	jne	0x1000103f0
0000000100010406	movb	$0x0, -0xb0(%rbp,%rax)
000000010001040e	leaq	0x225c(%rip), %rsi              ## literal pool for: "%sns"
0000000100010415	leaq	-0xb0(%rbp), %rdx
000000010001041c	xorl	%eax, %eax
000000010001041e	callq	0x100011274                     ## symbol stub for: _sprintf
0000000100010423	jmp	0x100010846
0000000100010428	movq	%rdi, %r14
000000010001042b	movl	$0x3b9aca00, %edx               ## imm = 0x3B9ACA00
0000000100010430	leaq	0x3569(%rip), %rbx
0000000100010437	jmp	0x100010459
0000000100010439	movq	%rdi, %r14
000000010001043c	movl	$0xf4240, %edx                  ## imm = 0xF4240
0000000100010441	leaq	0x3568(%rip), %rbx
0000000100010448	jmp	0x100010459
000000010001044a	movq	%rdi, %r14
000000010001044d	movl	$0x3e8, %edx                    ## imm = 0x3E8
0000000100010452	leaq	0x3567(%rip), %rbx
0000000100010459	xorl	%ecx, %ecx
000000010001045b	movq	%rsi, %rdi
000000010001045e	movq	%r8, %rsi
0000000100010461	callq	0x100011154                     ## symbol stub for: ___divti3
0000000100010466	movq	%rax, %rcx
0000000100010469	movq	%rdx, %rsi
000000010001046c	testq	%rdx, %rdx
000000010001046f	js	0x100010520
0000000100010475	movq	%rcx, %rax
0000000100010478	orq	%rsi, %rax
000000010001047b	je	0x1000105f9
0000000100010481	xorl	%r10d, %r10d
0000000100010484	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
000000010001048e	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010498	movq	%rsi, %r12
000000010001049b	movq	%r14, %rdi
000000010001049e	nop
00000001000104a0	movq	%rsi, %r8
00000001000104a3	shldq	$0x3f, %rcx, %r8
00000001000104a8	shrq	%r12
00000001000104ab	movq	%r8, %r9
00000001000104ae	addq	%r12, %r9
00000001000104b1	adcq	$0x0, %r9
00000001000104b5	movq	%r9, %rax
00000001000104b8	mulq	%r11
00000001000104bb	shrq	$0x2, %rdx
00000001000104bf	leaq	(%rdx,%rdx,4), %rax
00000001000104c3	subq	%rax, %r9
00000001000104c6	subq	%r9, %r8
00000001000104c9	sbbq	$0x0, %r12
00000001000104cd	movq	%r8, %r9
00000001000104d0	imulq	%r15, %r9
00000001000104d4	movq	%r8, %rax
00000001000104d7	mulq	%r11
00000001000104da	addq	%r9, %rdx
00000001000104dd	imulq	%r11, %r12
00000001000104e1	addq	%rdx, %r12
00000001000104e4	movq	%rax, %rdx
00000001000104e7	addq	%rax, %rdx
00000001000104ea	leaq	(%rdx,%rdx,4), %rdx
00000001000104ee	movl	%ecx, %r8d
00000001000104f1	subl	%edx, %r8d
00000001000104f4	orb	$0x30, %r8b
00000001000104f8	movb	%r8b, -0x70(%rbp,%r10)
00000001000104fd	incq	%r10
0000000100010500	cmpq	$0xa, %rcx
0000000100010504	sbbq	$0x0, %rsi
0000000100010508	movq	%rax, %rcx
000000010001050b	movq	%r12, %rsi
000000010001050e	jae	0x1000104a0
0000000100010510	testl	%r10d, %r10d
0000000100010513	jg	0x100010606
0000000100010519	xorl	%eax, %eax
000000010001051b	jmp	0x1000106f6
0000000100010520	movb	$0x2d, -0xb0(%rbp)
0000000100010527	xorl	%r9d, %r9d
000000010001052a	negq	%rcx
000000010001052d	movl	$0x0, %r11d
0000000100010533	sbbq	%rsi, %r11
0000000100010536	movl	$0x1, %r13d
000000010001053c	movabsq	$-0x3333333333333333, %r10      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010546	movabsq	$-0x3333333333333334, %r15      ## imm = 0xCCCCCCCCCCCCCCCC
0000000100010550	movq	%r11, %r12
0000000100010553	nopw	%cs:(%rax,%rax)
0000000100010560	movq	%r11, %rsi
0000000100010563	shldq	$0x3f, %rcx, %rsi
0000000100010568	shrq	%r12
000000010001056b	movq	%rsi, %rdi
000000010001056e	addq	%r12, %rdi
0000000100010571	adcq	$0x0, %rdi
0000000100010575	movq	%rdi, %rax
0000000100010578	mulq	%r10
000000010001057b	movl	%r13d, %r8d
000000010001057e	shrq	$0x2, %rdx
0000000100010582	leaq	(%rdx,%rdx,4), %rax
0000000100010586	subq	%rax, %rdi
0000000100010589	subq	%rdi, %rsi
000000010001058c	sbbq	$0x0, %r12
0000000100010590	movq	%rsi, %rdi
0000000100010593	movq	%rsi, %rax
0000000100010596	mulq	%r10
0000000100010599	imulq	%r15, %rdi
000000010001059d	addq	%rdi, %rdx
00000001000105a0	imulq	%r10, %r12
00000001000105a4	addq	%rdx, %r12
00000001000105a7	movq	%rax, %rdx
00000001000105aa	addq	%rax, %rdx
00000001000105ad	leaq	(%rdx,%rdx,4), %rdx
00000001000105b1	movl	%ecx, %esi
00000001000105b3	subl	%edx, %esi
00000001000105b5	orb	$0x30, %sil
00000001000105b9	movb	%sil, -0x70(%rbp,%r9)
00000001000105be	incq	%r9
00000001000105c1	leal	0x1(%r8), %r13d
00000001000105c5	cmpq	$0xa, %rcx
00000001000105c9	sbbq	$0x0, %r11
00000001000105cd	movq	%rax, %rcx
00000001000105d0	movq	%r12, %r11
00000001000105d3	jae	0x100010560
00000001000105d5	testl	%r9d, %r9d
00000001000105d8	movq	%r14, %rdi
00000001000105db	jle	0x100010622
00000001000105dd	movl	%r9d, %eax
00000001000105e0	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
00000001000105e5	cmpq	$0x8, %rax
00000001000105e9	jae	0x100010703
00000001000105ef	xorl	%ecx, %ecx
00000001000105f1	movq	%rax, %rdx
00000001000105f4	jmp	0x1000107f5
00000001000105f9	movb	$0x30, -0x70(%rbp)
00000001000105fd	movl	$0x1, %r10d
0000000100010603	movq	%r14, %rdi
0000000100010606	movl	%r10d, %eax
0000000100010609	cmpq	$0x8, %rax
000000010001060d	jae	0x100010619
000000010001060f	xorl	%ecx, %ecx
0000000100010611	movq	%rax, %rdx
0000000100010614	jmp	0x1000106d2
0000000100010619	cmpl	$0x20, %eax
000000010001061c	jae	0x100010629
000000010001061e	xorl	%ecx, %ecx
0000000100010620	jmp	0x10001068b
0000000100010622	xorl	%eax, %eax
0000000100010624	jmp	0x100010826
0000000100010629	movl	%r10d, %edx
000000010001062c	andl	$0x1f, %edx
000000010001062f	movq	%rax, %rcx
0000000100010632	subq	%rdx, %rcx
0000000100010635	leaq	-0xa0(%rbp), %rsi
000000010001063c	movdqa	0xd9c(%rip), %xmm0
0000000100010644	movq	%rax, %r8
0000000100010647	nopw	(%rax,%rax)
0000000100010650	movdqu	-0x90(%rbp,%r8), %xmm1
000000010001065a	movdqu	-0x80(%rbp,%r8), %xmm2
0000000100010661	pshufb	%xmm0, %xmm2
0000000100010666	pshufb	%xmm0, %xmm1
000000010001066b	movdqa	%xmm2, -0x10(%rsi)
0000000100010670	movdqa	%xmm1, (%rsi)
0000000100010674	addq	$-0x20, %r8
0000000100010678	addq	$0x20, %rsi
000000010001067c	cmpq	%r8, %rdx
000000010001067f	jne	0x100010650
0000000100010681	testq	%rdx, %rdx
0000000100010684	je	0x1000106f6
0000000100010686	cmpl	$0x7, %edx
0000000100010689	jbe	0x1000106d2
000000010001068b	movl	%r10d, %edx
000000010001068e	andl	$0x7, %edx
0000000100010691	movq	%rax, %rsi
0000000100010694	subq	%rcx, %rsi
0000000100010697	leaq	(%rcx,%rbp), %r8
000000010001069b	addq	$-0xb0, %r8
00000001000106a2	movq	%rax, %rcx
00000001000106a5	subq	%rdx, %rcx
00000001000106a8	movq	0xd40(%rip), %xmm0
00000001000106b0	movq	-0x78(%rbp,%rsi), %xmm1
00000001000106b6	pshufb	%xmm0, %xmm1
00000001000106bb	movq	%xmm1, (%r8)
00000001000106c0	addq	$-0x8, %rsi
00000001000106c4	addq	$0x8, %r8
00000001000106c8	cmpq	%rsi, %rdx
00000001000106cb	jne	0x1000106b0
00000001000106cd	testq	%rdx, %rdx
00000001000106d0	je	0x1000106f6
00000001000106d2	leaq	-0x70(%rbp), %rsi
00000001000106d6	addq	%rsi, %rdx
00000001000106d9	decq	%rdx
00000001000106dc	nopl	(%rax)
00000001000106e0	movzbl	(%rdx), %esi
00000001000106e3	movb	%sil, -0xb0(%rbp,%rcx)
00000001000106eb	incq	%rcx
00000001000106ee	decq	%rdx
00000001000106f1	cmpq	%rcx, %rax
00000001000106f4	jne	0x1000106e0
00000001000106f6	movb	$0x0, -0xb0(%rbp,%rax)
00000001000106fe	jmp	0x10001082e
0000000100010703	cmpl	$0x20, %eax
0000000100010706	jae	0x10001070c
0000000100010708	xorl	%ecx, %ecx
000000010001070a	jmp	0x100010784
000000010001070c	movl	%r9d, %edx
000000010001070f	andl	$0x1f, %edx
0000000100010712	movq	%rax, %rcx
0000000100010715	subq	%rdx, %rcx
0000000100010718	movl	%r8d, %esi
000000010001071b	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010721	leaq	(%rsi,%rbp), %r10
0000000100010725	addq	$-0x80, %r10
0000000100010729	movl	%r8d, %r11d
000000010001072c	andl	$0x1f, %r11d
0000000100010730	subq	%r11, %rsi
0000000100010733	xorl	%r11d, %r11d
0000000100010736	movdqa	0xca2(%rip), %xmm0
000000010001073e	nop
0000000100010740	movdqu	-0x10(%r10), %xmm1
0000000100010746	movdqu	(%r10), %xmm2
000000010001074b	pshufb	%xmm0, %xmm2
0000000100010750	pshufb	%xmm0, %xmm1
0000000100010755	movdqu	%xmm2, -0xaf(%rbp,%r11)
000000010001075f	movdqu	%xmm1, -0x9f(%rbp,%r11)
0000000100010769	addq	$0x20, %r11
000000010001076d	addq	$-0x20, %r10
0000000100010771	cmpq	%r11, %rsi
0000000100010774	jne	0x100010740
0000000100010776	testq	%rdx, %rdx
0000000100010779	je	0x100010826
000000010001077f	cmpl	$0x7, %edx
0000000100010782	jbe	0x1000107f5
0000000100010784	movq	%rcx, %rsi
0000000100010787	movl	%r9d, %edx
000000010001078a	andl	$0x7, %edx
000000010001078d	movq	%rax, %rcx
0000000100010790	subq	%rdx, %rcx
0000000100010793	movq	%rsi, %r9
0000000100010796	negq	%r9
0000000100010799	leaq	(%r9,%rbp), %r10
000000010001079d	addq	$-0x70, %r10
00000001000107a1	movl	%r8d, %r9d
00000001000107a4	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
00000001000107ab	addq	%r9, %r10
00000001000107ae	addq	$-0x8, %r10
00000001000107b2	movl	%r8d, %r11d
00000001000107b5	andl	$0x7, %r11d
00000001000107b9	subq	%r11, %r9
00000001000107bc	movq	0xc2c(%rip), %xmm0
00000001000107c4	nopw	%cs:(%rax,%rax)
00000001000107d0	movq	(%r10), %xmm1
00000001000107d5	pshufb	%xmm0, %xmm1
00000001000107da	movq	%xmm1, -0xaf(%rbp,%rsi)
00000001000107e3	addq	$0x8, %rsi
00000001000107e7	addq	$-0x8, %r10
00000001000107eb	cmpq	%rsi, %r9
00000001000107ee	jne	0x1000107d0
00000001000107f0	testq	%rdx, %rdx
00000001000107f3	je	0x100010826
00000001000107f5	leaq	-0x70(%rbp), %rsi
00000001000107f9	addq	%rsi, %rdx
00000001000107fc	decq	%rdx
00000001000107ff	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
0000000100010806	nopw	%cs:(%rax,%rax)
0000000100010810	movzbl	(%rdx), %esi
0000000100010813	movb	%sil, -0xaf(%rbp,%rcx)
000000010001081b	incq	%rcx
000000010001081e	decq	%rdx
0000000100010821	cmpq	%rcx, %r8
0000000100010824	jne	0x100010810
0000000100010826	movb	$0x0, -0xaf(%rbp,%rax)
000000010001082e	movq	(%rbx), %rcx
0000000100010831	leaq	0x1e34(%rip), %rsi              ## literal pool for: "%s%s"
0000000100010838	leaq	-0xb0(%rbp), %rdx
000000010001083f	xorl	%eax, %eax
0000000100010841	callq	0x100011274                     ## symbol stub for: _sprintf
0000000100010846	movq	0x27e3(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
000000010001084d	movq	(%rax), %rax
0000000100010850	cmpq	-0x30(%rbp), %rax
0000000100010854	jne	0x100010a53
000000010001085a	addq	$0x88, %rsp
0000000100010861	popq	%rbx
0000000100010862	popq	%r12
0000000100010864	popq	%r13
0000000100010866	popq	%r14
0000000100010868	popq	%r15
000000010001086a	popq	%rbp
000000010001086b	retq
000000010001086c	movb	$0x2d, -0xb0(%rbp)
0000000100010873	xorl	%r10d, %r10d
0000000100010876	negq	%rsi
0000000100010879	movl	$0x0, %ebx
000000010001087e	sbbq	%r8, %rbx
0000000100010881	movl	$0x1, %r12d
0000000100010887	movabsq	$-0x3333333333333333, %r11      ## imm = 0xCCCCCCCCCCCCCCCD
0000000100010891	movabsq	$-0x3333333333333334, %r14      ## imm = 0xCCCCCCCCCCCCCCCC
000000010001089b	movq	%rbx, %r15
000000010001089e	nop
00000001000108a0	movq	%rbx, %rcx
00000001000108a3	shldq	$0x3f, %rsi, %rcx
00000001000108a8	shrq	%r15
00000001000108ab	movq	%rcx, %r8
00000001000108ae	addq	%r15, %r8
00000001000108b1	adcq	$0x0, %r8
00000001000108b5	movq	%r8, %rax
00000001000108b8	mulq	%r11
00000001000108bb	movl	%r12d, %r9d
00000001000108be	shrq	$0x2, %rdx
00000001000108c2	leaq	(%rdx,%rdx,4), %rax
00000001000108c6	subq	%rax, %r8
00000001000108c9	subq	%r8, %rcx
00000001000108cc	sbbq	$0x0, %r15
00000001000108d0	movq	%rcx, %r8
00000001000108d3	movq	%rcx, %rax
00000001000108d6	mulq	%r11
00000001000108d9	imulq	%r14, %r8
00000001000108dd	addq	%r8, %rdx
00000001000108e0	imulq	%r11, %r15
00000001000108e4	addq	%rdx, %r15
00000001000108e7	movq	%rax, %rcx
00000001000108ea	addq	%rax, %rcx
00000001000108ed	leaq	(%rcx,%rcx,4), %rcx
00000001000108f1	movl	%esi, %edx
00000001000108f3	subl	%ecx, %edx
00000001000108f5	orb	$0x30, %dl
00000001000108f8	movb	%dl, -0x70(%rbp,%r10)
00000001000108fd	incq	%r10
0000000100010900	leal	0x1(%r9), %r12d
0000000100010904	cmpq	$0xa, %rsi
0000000100010908	sbbq	$0x0, %rbx
000000010001090c	movq	%rax, %rsi
000000010001090f	movq	%r15, %rbx
0000000100010912	jae	0x1000108a0
0000000100010914	testl	%r10d, %r10d
0000000100010917	jle	0x100010931
0000000100010919	movl	%r10d, %eax
000000010001091c	andl	$0x7fffffff, %eax               ## imm = 0x7FFFFFFF
0000000100010921	cmpq	$0x8, %rax
0000000100010925	jae	0x100010938
0000000100010927	xorl	%ecx, %ecx
0000000100010929	movq	%rax, %rdx
000000010001092c	jmp	0x100010a1c
0000000100010931	xorl	%eax, %eax
0000000100010933	jmp	0x100010a46
0000000100010938	cmpl	$0x20, %eax
000000010001093b	jae	0x100010941
000000010001093d	xorl	%ecx, %ecx
000000010001093f	jmp	0x1000109b7
0000000100010941	movl	%r10d, %edx
0000000100010944	andl	$0x1f, %edx
0000000100010947	movq	%rax, %rcx
000000010001094a	subq	%rdx, %rcx
000000010001094d	movl	%r9d, %esi
0000000100010950	andl	$0x7fffffff, %esi               ## imm = 0x7FFFFFFF
0000000100010956	leaq	(%rsi,%rbp), %r8
000000010001095a	addq	$-0x80, %r8
000000010001095e	movl	%r9d, %r11d
0000000100010961	andl	$0x1f, %r11d
0000000100010965	subq	%r11, %rsi
0000000100010968	xorl	%r11d, %r11d
000000010001096b	movdqa	0xa6d(%rip), %xmm0
0000000100010973	movdqu	-0x10(%r8), %xmm1
0000000100010979	movdqu	(%r8), %xmm2
000000010001097e	pshufb	%xmm0, %xmm2
0000000100010983	pshufb	%xmm0, %xmm1
0000000100010988	movdqu	%xmm2, -0xaf(%rbp,%r11)
0000000100010992	movdqu	%xmm1, -0x9f(%rbp,%r11)
000000010001099c	addq	$0x20, %r11
00000001000109a0	addq	$-0x20, %r8
00000001000109a4	cmpq	%r11, %rsi
00000001000109a7	jne	0x100010973
00000001000109a9	testq	%rdx, %rdx
00000001000109ac	je	0x100010a46
00000001000109b2	cmpl	$0x7, %edx
00000001000109b5	jbe	0x100010a1c
00000001000109b7	movq	%rcx, %rsi
00000001000109ba	movl	%r10d, %edx
00000001000109bd	andl	$0x7, %edx
00000001000109c0	movq	%rax, %rcx
00000001000109c3	subq	%rdx, %rcx
00000001000109c6	movq	%rsi, %r8
00000001000109c9	negq	%r8
00000001000109cc	leaq	(%r8,%rbp), %r10
00000001000109d0	addq	$-0x70, %r10
00000001000109d4	movl	%r9d, %r8d
00000001000109d7	andl	$0x7fffffff, %r8d               ## imm = 0x7FFFFFFF
00000001000109de	addq	%r8, %r10
00000001000109e1	addq	$-0x8, %r10
00000001000109e5	movl	%r9d, %r11d
00000001000109e8	andl	$0x7, %r11d
00000001000109ec	subq	%r11, %r8
00000001000109ef	movq	0x9f9(%rip), %xmm0
00000001000109f7	movq	(%r10), %xmm1
00000001000109fc	pshufb	%xmm0, %xmm1
0000000100010a01	movq	%xmm1, -0xaf(%rbp,%rsi)
0000000100010a0a	addq	$0x8, %rsi
0000000100010a0e	addq	$-0x8, %r10
0000000100010a12	cmpq	%rsi, %r8
0000000100010a15	jne	0x1000109f7
0000000100010a17	testq	%rdx, %rdx
0000000100010a1a	je	0x100010a46
0000000100010a1c	leaq	-0x70(%rbp), %rsi
0000000100010a20	addq	%rsi, %rdx
0000000100010a23	decq	%rdx
0000000100010a26	andl	$0x7fffffff, %r9d               ## imm = 0x7FFFFFFF
0000000100010a2d	nopl	(%rax)
0000000100010a30	movzbl	(%rdx), %esi
0000000100010a33	movb	%sil, -0xaf(%rbp,%rcx)
0000000100010a3b	incq	%rcx
0000000100010a3e	decq	%rdx
0000000100010a41	cmpq	%rcx, %r9
0000000100010a44	jne	0x100010a30
0000000100010a46	movb	$0x0, -0xaf(%rbp,%rax)
0000000100010a4e	jmp	0x10001040e
0000000100010a53	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
0000000100010a58	nopl	(%rax,%rax)
_fwp_format_g:
0000000100010a60	pushq	%rbp
0000000100010a61	movq	%rsp, %rbp
0000000100010a64	pushq	%r15
0000000100010a66	pushq	%r14
0000000100010a68	pushq	%r13
0000000100010a6a	pushq	%r12
0000000100010a6c	pushq	%rbx
0000000100010a6d	subq	$0x98, %rsp
0000000100010a74	movl	%esi, %r12d
0000000100010a77	movq	%rdi, %rbx
0000000100010a7a	movq	0x25af(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010a81	movq	(%rax), %rax
0000000100010a84	movq	%rax, -0x30(%rbp)
0000000100010a88	decl	%r12d
0000000100010a8b	leaq	0x1bad(%rip), %rdx              ## literal pool for: "%.*e"
0000000100010a92	leaq	-0x70(%rbp), %r13
0000000100010a96	movl	$0x40, %esi
0000000100010a9b	movq	%r13, %rdi
0000000100010a9e	movl	%r12d, %ecx
0000000100010aa1	movsd	%xmm0, -0xb8(%rbp)
0000000100010aa9	movb	$0x1, %al
0000000100010aab	callq	0x10001126e                     ## symbol stub for: _snprintf
0000000100010ab0	movq	%r13, %rdi
0000000100010ab3	movl	$0x65, %esi
0000000100010ab8	callq	0x10001127a                     ## symbol stub for: _strchr
0000000100010abd	movq	%rax, %r15
0000000100010ac0	leaq	0x1(%rax), %rdi
0000000100010ac4	callq	0x100011196                     ## symbol stub for: _atoi
0000000100010ac9	movl	%eax, %r14d
0000000100010acc	leal	-0x11(%r14), %eax
0000000100010ad0	cmpl	$-0x17, %eax
0000000100010ad3	ja	0x100010b3e
0000000100010ad5	subq	%r13, %r15
0000000100010ad8	leaq	-0xb0(%rbp), %r12
0000000100010adf	movl	$0x40, %ecx
0000000100010ae4	movq	%r12, %rdi
0000000100010ae7	movq	%r13, %rsi
0000000100010aea	movq	%r15, %rdx
0000000100010aed	callq	0x10001115a                     ## symbol stub for: ___memcpy_chk
0000000100010af2	movb	$0x0, -0xb0(%rbp,%r15)
0000000100010afb	movq	%r12, %rdi
0000000100010afe	movl	$0x2e, %esi
0000000100010b03	callq	0x10001127a                     ## symbol stub for: _strchr
0000000100010b08	testq	%rax, %rax
0000000100010b0b	sete	%al
0000000100010b0e	testq	%r15, %r15
0000000100010b11	sete	%cl
0000000100010b14	orb	%al, %cl
0000000100010b16	jne	0x100010bb6
0000000100010b1c	nopl	(%rax)
0000000100010b20	movzbl	-0xb1(%rbp,%r15), %eax
0000000100010b29	cmpl	$0x30, %eax
0000000100010b2c	jne	0x100010ba8
0000000100010b2e	movb	$0x0, -0xb1(%rbp,%r15)
0000000100010b37	decq	%r15
0000000100010b3a	jne	0x100010b20
0000000100010b3c	jmp	0x100010bb6
0000000100010b3e	subl	%r14d, %r12d
0000000100010b41	xorl	%ecx, %ecx
0000000100010b43	testl	%r12d, %r12d
0000000100010b46	cmovgl	%r12d, %ecx
0000000100010b4a	leaq	0x1afd(%rip), %rdx              ## literal pool for: "%.*f"
0000000100010b51	movl	$0x190, %esi                    ## imm = 0x190
0000000100010b56	movq	%rbx, %rdi
0000000100010b59	movsd	-0xb8(%rbp), %xmm0
0000000100010b61	movb	$0x1, %al
0000000100010b63	callq	0x10001126e                     ## symbol stub for: _snprintf
0000000100010b68	movq	%rbx, %rdi
0000000100010b6b	callq	0x100011286                     ## symbol stub for: _strlen
0000000100010b70	movq	%rax, %r14
0000000100010b73	movq	%rbx, %rdi
0000000100010b76	movl	$0x2e, %esi
0000000100010b7b	callq	0x10001127a                     ## symbol stub for: _strchr
0000000100010b80	testq	%rax, %rax
0000000100010b83	sete	%al
0000000100010b86	testq	%r14, %r14
0000000100010b89	sete	%cl
0000000100010b8c	orb	%al, %cl
0000000100010b8e	jne	0x100010beb
0000000100010b90	movzbl	-0x1(%rbx,%r14), %eax
0000000100010b96	cmpl	$0x30, %eax
0000000100010b99	jne	0x100010c0d
0000000100010b9b	movb	$0x0, -0x1(%rbx,%r14)
0000000100010ba1	decq	%r14
0000000100010ba4	jne	0x100010b90
0000000100010ba6	jmp	0x100010beb
0000000100010ba8	cmpl	$0x2e, %eax
0000000100010bab	jne	0x100010bb6
0000000100010bad	movb	$0x0, -0xb1(%rbp,%r15)
0000000100010bb6	movl	%r14d, %eax
0000000100010bb9	shrl	$0x1f, %eax
0000000100010bbc	leal	0x2b(,%rax,2), %r8d
0000000100010bc4	movl	%r14d, %r9d
0000000100010bc7	negl	%r9d
0000000100010bca	cmovsl	%r14d, %r9d
0000000100010bce	leaq	0x1a6f(%rip), %rdx              ## literal pool for: "%se%c%02d"
0000000100010bd5	leaq	-0xb0(%rbp), %rcx
0000000100010bdc	movl	$0x190, %esi                    ## imm = 0x190
0000000100010be1	movq	%rbx, %rdi
0000000100010be4	xorl	%eax, %eax
0000000100010be6	callq	0x10001126e                     ## symbol stub for: _snprintf
0000000100010beb	movq	0x243e(%rip), %rax              ## literal pool symbol address: ___stack_chk_guard
0000000100010bf2	movq	(%rax), %rax
0000000100010bf5	cmpq	-0x30(%rbp), %rax
0000000100010bf9	jne	0x100010c1a
0000000100010bfb	addq	$0x98, %rsp
0000000100010c02	popq	%rbx
0000000100010c03	popq	%r12
0000000100010c05	popq	%r13
0000000100010c07	popq	%r14
0000000100010c09	popq	%r15
0000000100010c0b	popq	%rbp
0000000100010c0c	retq
0000000100010c0d	cmpl	$0x2e, %eax
0000000100010c10	jne	0x100010beb
0000000100010c12	movb	$0x0, -0x1(%rbx,%r14)
0000000100010c18	jmp	0x100010beb
0000000100010c1a	callq	0x100011160                     ## symbol stub for: ___stack_chk_fail
0000000100010c1f	nop
_rd_leb:
0000000100010c20	movq	$0x0, (%rsi)
0000000100010c27	movq	0x8(%rdi), %r8
0000000100010c2b	movq	0x10(%rdi), %rdx
0000000100010c2f	cmpq	%rdx, %r8
0000000100010c32	jne	0x100010c37
0000000100010c34	xorl	%eax, %eax
0000000100010c36	retq
0000000100010c37	pushq	%rbp
0000000100010c38	movq	%rsp, %rbp
0000000100010c3b	movq	(%rdi), %rcx
0000000100010c3e	leaq	0x1(%rdx), %r9
0000000100010c42	movq	%r9, 0x10(%rdi)
0000000100010c46	movzbl	(%rcx,%rdx), %r10d
0000000100010c4b	andl	$0x7f, %r10d
0000000100010c4f	movq	%r10, (%rsi)
0000000100010c52	movl	$0x1, %eax
0000000100010c57	cmpb	$0x0, (%rcx,%rdx)
0000000100010c5b	js	0x100010c5f
0000000100010c5d	popq	%rbp
0000000100010c5e	retq
0000000100010c5f	cmpq	%r9, %r8
0000000100010c62	jne	0x100010c68
0000000100010c64	xorl	%eax, %eax
0000000100010c66	popq	%rbp
0000000100010c67	retq
0000000100010c68	leaq	0x2(%rdx), %r11
0000000100010c6c	movq	%r11, 0x10(%rdi)
0000000100010c70	movzbl	0x1(%rcx,%rdx), %r9d
0000000100010c76	andl	$0x7f, %r9d
0000000100010c7a	shll	$0x7, %r9d
0000000100010c7e	orq	%r10, %r9
0000000100010c81	movq	%r9, (%rsi)
0000000100010c84	cmpb	$0x0, 0x1(%rcx,%rdx)
0000000100010c89	jns	0x100010c5d
0000000100010c8b	cmpq	%r11, %r8
0000000100010c8e	je	0x100010c64
0000000100010c90	leaq	0x3(%rdx), %r11
0000000100010c94	movq	%r11, 0x10(%rdi)
0000000100010c98	movzbl	0x2(%rcx,%rdx), %r10d
0000000100010c9e	andl	$0x7f, %r10d
0000000100010ca2	shll	$0xe, %r10d
0000000100010ca6	orq	%r9, %r10
0000000100010ca9	movq	%r10, (%rsi)
0000000100010cac	cmpb	$0x0, 0x2(%rcx,%rdx)
0000000100010cb1	jns	0x100010c5d
0000000100010cb3	cmpq	%r11, %r8
0000000100010cb6	je	0x100010c64
0000000100010cb8	leaq	0x4(%rdx), %r11
0000000100010cbc	movq	%r11, 0x10(%rdi)
0000000100010cc0	movzbl	0x3(%rcx,%rdx), %r9d
0000000100010cc6	andl	$0x7f, %r9d
0000000100010cca	shll	$0x15, %r9d
0000000100010cce	orq	%r10, %r9
0000000100010cd1	movq	%r9, (%rsi)
0000000100010cd4	cmpb	$0x0, 0x3(%rcx,%rdx)
0000000100010cd9	jns	0x100010c5d
0000000100010cdb	cmpq	%r11, %r8
0000000100010cde	je	0x100010c64
0000000100010ce0	leaq	0x5(%rdx), %r11
0000000100010ce4	movq	%r11, 0x10(%rdi)
0000000100010ce8	movzbl	0x4(%rcx,%rdx), %r10d
0000000100010cee	andl	$0x7f, %r10d
0000000100010cf2	shlq	$0x1c, %r10
0000000100010cf6	orq	%r9, %r10
0000000100010cf9	movq	%r10, (%rsi)
0000000100010cfc	cmpb	$0x0, 0x4(%rcx,%rdx)
0000000100010d01	jns	0x100010c5d
0000000100010d07	cmpq	%r11, %r8
0000000100010d0a	je	0x100010c64
0000000100010d10	leaq	0x6(%rdx), %r11
0000000100010d14	movq	%r11, 0x10(%rdi)
0000000100010d18	movzbl	0x5(%rcx,%rdx), %r9d
0000000100010d1e	andl	$0x7f, %r9d
0000000100010d22	shlq	$0x23, %r9
0000000100010d26	orq	%r10, %r9
0000000100010d29	movq	%r9, (%rsi)
0000000100010d2c	cmpb	$0x0, 0x5(%rcx,%rdx)
0000000100010d31	jns	0x100010c5d
0000000100010d37	cmpq	%r11, %r8
0000000100010d3a	je	0x100010c64
0000000100010d40	leaq	0x7(%rdx), %r11
0000000100010d44	movq	%r11, 0x10(%rdi)
0000000100010d48	movzbl	0x6(%rcx,%rdx), %r10d
0000000100010d4e	andl	$0x7f, %r10d
0000000100010d52	shlq	$0x2a, %r10
0000000100010d56	orq	%r9, %r10
0000000100010d59	movq	%r10, (%rsi)
0000000100010d5c	cmpb	$0x0, 0x6(%rcx,%rdx)
0000000100010d61	jns	0x100010c5d
0000000100010d67	cmpq	%r11, %r8
0000000100010d6a	je	0x100010c64
0000000100010d70	leaq	0x8(%rdx), %r9
0000000100010d74	movq	%r9, 0x10(%rdi)
0000000100010d78	movzbl	0x7(%rcx,%rdx), %r11d
0000000100010d7e	andl	$0x7f, %r11d
0000000100010d82	shlq	$0x31, %r11
0000000100010d86	orq	%r10, %r11
0000000100010d89	movq	%r11, (%rsi)
0000000100010d8c	cmpb	$0x0, 0x7(%rcx,%rdx)
0000000100010d91	jns	0x100010c5d
0000000100010d97	cmpq	%r9, %r8
0000000100010d9a	je	0x100010c64
0000000100010da0	leaq	0x9(%rdx), %r9
0000000100010da4	movq	%r9, 0x10(%rdi)
0000000100010da8	movzbl	0x8(%rcx,%rdx), %r10d
0000000100010dae	andl	$0x7f, %r10d
0000000100010db2	shlq	$0x38, %r10
0000000100010db6	orq	%r11, %r10
0000000100010db9	movq	%r10, (%rsi)
0000000100010dbc	cmpb	$0x0, 0x8(%rcx,%rdx)
0000000100010dc1	jns	0x100010c5d
0000000100010dc7	cmpq	%r9, %r8
0000000100010dca	je	0x100010c64
0000000100010dd0	leaq	0xa(%rdx), %rax
0000000100010dd4	movq	%rax, 0x10(%rdi)
0000000100010dd8	movzbl	0x9(%rcx,%rdx), %edx
0000000100010ddd	movl	$0x0, %eax
0000000100010de2	testb	$0x7e, %dl
0000000100010de5	jne	0x100010c5d
0000000100010deb	shlq	$0x3f, %rdx
0000000100010def	orq	%r10, %rdx
0000000100010df2	movq	%rdx, (%rsi)
0000000100010df5	xorl	%eax, %eax
0000000100010df7	cmpb	$0x0, (%rcx,%r9)
0000000100010dfc	setns	%al
0000000100010dff	popq	%rbp
0000000100010e00	retq
0000000100010e01	nopw	%cs:(%rax,%rax)
_fwp_wire_empty_inner:
0000000100010e10	xorl	%eax, %eax
0000000100010e12	testq	%rdi, %rdi
0000000100010e15	je	0x100010ebc
0000000100010e1b	cmpl	$0x10, (%rdi)
0000000100010e1e	jne	0x100010ebc
0000000100010e24	pushq	%rbp
0000000100010e25	movq	%rsp, %rbp
0000000100010e28	pushq	%r15
0000000100010e2a	pushq	%r14
0000000100010e2c	pushq	%r12
0000000100010e2e	pushq	%rbx
0000000100010e2f	subq	$0x10, %rsp
0000000100010e33	testq	%rsi, %rsi
0000000100010e36	je	0x100010e4e
0000000100010e38	movq	%rsi, %rcx
0000000100010e3b	nopl	(%rax,%rax)
0000000100010e40	cmpq	%rdi, (%rcx)
0000000100010e43	je	0x100010eb0
0000000100010e45	movq	0x8(%rcx), %rcx
0000000100010e49	testq	%rcx, %rcx
0000000100010e4c	jne	0x100010e40
0000000100010e4e	movq	%rdi, -0x30(%rbp)
0000000100010e52	movq	%rsi, -0x28(%rbp)
0000000100010e56	movslq	0x10(%rdi), %r14
0000000100010e5a	testq	%r14, %r14
0000000100010e5d	jle	0x100010ea7
0000000100010e5f	movq	0x20(%rdi), %r15
0000000100010e63	movq	(%r15), %rdi
0000000100010e66	leaq	-0x30(%rbp), %rsi
0000000100010e6a	callq	_fwp_wire_empty_inner
0000000100010e6f	testl	%eax, %eax
0000000100010e71	je	0x100010eae
0000000100010e73	movl	$0x1, %ecx
0000000100010e78	leaq	-0x30(%rbp), %rbx
0000000100010e7c	nopl	(%rax)
0000000100010e80	movq	%rcx, %r12
0000000100010e83	cmpq	%rcx, %r14
0000000100010e86	je	0x100010e9d
0000000100010e88	movq	(%r15,%r12,8), %rdi
0000000100010e8c	movq	%rbx, %rsi
0000000100010e8f	callq	_fwp_wire_empty_inner
0000000100010e94	leaq	0x1(%r12), %rcx
0000000100010e99	testl	%eax, %eax
0000000100010e9b	jne	0x100010e80
0000000100010e9d	xorl	%eax, %eax
0000000100010e9f	cmpq	%r14, %r12
0000000100010ea2	setae	%al
0000000100010ea5	jmp	0x100010eb0
0000000100010ea7	movl	$0x1, %eax
0000000100010eac	jmp	0x100010eb0
0000000100010eae	xorl	%eax, %eax
0000000100010eb0	addq	$0x10, %rsp
0000000100010eb4	popq	%rbx
0000000100010eb5	popq	%r12
0000000100010eb7	popq	%r14
0000000100010eb9	popq	%r15
0000000100010ebb	popq	%rbp
0000000100010ebc	retq
0000000100010ebd	nopl	(%rax)
_fwp_gc_report:
0000000100010ec0	pushq	%rbp
0000000100010ec1	movq	%rsp, %rbp
0000000100010ec4	pushq	%r15
0000000100010ec6	pushq	%r14
0000000100010ec8	pushq	%r13
0000000100010eca	pushq	%r12
0000000100010ecc	pushq	%rbx
0000000100010ecd	subq	$0xb8, %rsp
0000000100010ed4	movq	0x433d(%rip), %rax
0000000100010edb	movq	_fwp_gc(%rip), %rcx
0000000100010ee2	subq	%rcx, %rax
0000000100010ee5	cvtsi2sd	%rax, %xmm0
0000000100010eea	addsd	0x42fe(%rip), %xmm0
0000000100010ef2	movsd	%xmm0, -0x50(%rbp)
0000000100010ef7	movsd	%xmm0, 0x42f1(%rip)
0000000100010eff	movq	%rcx, 0x4312(%rip)
0000000100010f06	movq	0x212b(%rip), %rax              ## literal pool symbol address: ___stderrp
0000000100010f0d	movq	(%rax), %r15
0000000100010f10	movq	0x42c9(%rip), %rax
0000000100010f17	movq	%rax, -0x30(%rbp)
0000000100010f1b	movq	0x40fe(%rip), %r14
0000000100010f22	movsd	0x42e6(%rip), %xmm0
0000000100010f2a	movsd	%xmm0, -0x38(%rbp)
0000000100010f2f	movq	0x411a(%rip), %r12
0000000100010f36	movq	0x4293(%rip), %r13
0000000100010f3d	movq	0x4294(%rip), %rbx
0000000100010f44	movsd	0x42ac(%rip), %xmm0
0000000100010f4c	movsd	%xmm0, -0x48(%rbp)
0000000100010f51	movsd	0x42a7(%rip), %xmm0
0000000100010f59	movsd	%xmm0, -0x40(%rbp)
0000000100010f5e	leaq	-0xe0(%rbp), %rsi
0000000100010f65	xorl	%edi, %edi
0000000100010f67	callq	0x1000111ea                     ## symbol stub for: _getrusage
0000000100010f6c	movq	$-0x1, %r8
0000000100010f73	testl	%eax, %eax
0000000100010f75	jne	0x100010f90
0000000100010f77	movq	-0xc0(%rbp), %rax
0000000100010f7e	leaq	0x3ff(%rax), %r8
0000000100010f85	testq	%rax, %rax
0000000100010f88	cmovnsq	%rax, %r8
0000000100010f8c	sarq	$0xa, %r8
0000000100010f90	movq	%rbx, %xmm0
0000000100010f95	movq	0x463(%rip), %xmm1
0000000100010f9d	punpckldq	%xmm1, %xmm0            ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
0000000100010fa1	movapd	0x467(%rip), %xmm2
0000000100010fa9	subpd	%xmm2, %xmm0
0000000100010fad	movapd	%xmm0, %xmm4
0000000100010fb1	unpckhpd	%xmm0, %xmm4                    ## xmm4 = xmm4[1],xmm0[1]
0000000100010fb5	addsd	%xmm0, %xmm4
0000000100010fb9	movsd	0x4b7(%rip), %xmm6
0000000100010fc1	mulsd	%xmm6, %xmm4
0000000100010fc5	movq	%r13, %xmm5
0000000100010fca	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100010fce	subpd	%xmm2, %xmm5
0000000100010fd2	movapd	%xmm5, %xmm3
0000000100010fd6	unpckhpd	%xmm5, %xmm3                    ## xmm3 = xmm3[1],xmm5[1]
0000000100010fda	addsd	%xmm5, %xmm3
0000000100010fde	mulsd	%xmm6, %xmm3
0000000100010fe2	movq	%r12, %xmm5
0000000100010fe7	punpckldq	%xmm1, %xmm5            ## xmm5 = xmm5[0],xmm1[0],xmm5[1],xmm1[1]
0000000100010feb	subpd	%xmm2, %xmm5
0000000100010fef	movapd	%xmm5, %xmm2
0000000100010ff3	unpckhpd	%xmm5, %xmm2                    ## xmm2 = xmm2[1],xmm5[1]
0000000100010ff7	addsd	%xmm5, %xmm2
0000000100010ffb	mulsd	%xmm6, %xmm2
0000000100010fff	movsd	-0x50(%rbp), %xmm0
0000000100011004	movsd	-0x38(%rbp), %xmm1
0000000100011009	addsd	%xmm1, %xmm0
000000010001100d	mulsd	%xmm6, %xmm1
0000000100011011	mulsd	%xmm6, %xmm0
0000000100011015	cmpl	$0x0, 0x3fe0(%rip)
000000010001101c	leaq	0x181d(%rip), %rax              ## literal pool for: " (collection off)"
0000000100011023	leaq	0x868(%rip), %r9                ## literal pool for: ""
000000010001102a	cmoveq	%rax, %r9
000000010001102e	leaq	0x175c(%rip), %rsi              ## literal pool for: "fwp gc: %zu collections (%zu minor), %.1f MiB allocated (%.1f MiB freed by counts), heap %.1f MiB, live %.1f MiB (peak %.1f), pauses %.1f ms (max %.2f ms), max RSS %ld KiB%s\n"
0000000100011035	movq	%r15, %rdi
0000000100011038	movq	-0x30(%rbp), %rdx
000000010001103c	movq	%r14, %rcx
000000010001103f	movsd	-0x48(%rbp), %xmm5
0000000100011044	movsd	-0x40(%rbp), %xmm6
0000000100011049	movb	$0x7, %al
000000010001104b	callq	0x1000111ba                     ## symbol stub for: _fprintf
0000000100011050	addq	$0xb8, %rsp
0000000100011057	popq	%rbx
0000000100011058	popq	%r12
000000010001105a	popq	%r13
000000010001105c	popq	%r14
000000010001105e	popq	%r15
0000000100011060	popq	%rbp
0000000100011061	retq
0000000100011062	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.1:
0000000100011070	pushq	%rbp
0000000100011071	movq	%rsp, %rbp
0000000100011074	pushq	$0x8
0000000100011076	popq	%rdi
0000000100011077	pushq	$0x2
0000000100011079	popq	%rsi
000000010001107a	callq	_fwp_gc_alloc_slow
000000010001107f	popq	%rbp
0000000100011080	retq
0000000100011081	nopw	%cs:(%rax,%rax)
_fwp_main_thread.cold.2:
0000000100011090	pushq	%rbp
0000000100011091	movq	%rsp, %rbp
0000000100011094	pushq	$0x1
0000000100011096	popq	%rdi
0000000100011097	pushq	$0x1
0000000100011099	popq	%rsi
000000010001109a	callq	_fwp_gc_alloc_slow
000000010001109f	popq	%rbp
00000001000110a0	retq
00000001000110a1	nopw	%cs:(%rax,%rax)
_fwp_rc_free_arr.cold.1:
00000001000110b0	pushq	%rbp
00000001000110b1	movq	%rsp, %rbp
00000001000110b4	pushq	%rbx
00000001000110b5	pushq	%rax
00000001000110b6	movq	%rdi, %rbx
00000001000110b9	leaq	0x8e0(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
00000001000110c0	callq	0x1000111de                     ## symbol stub for: _getenv
00000001000110c5	testq	%rax, %rax
00000001000110c8	je	0x1000110e1
00000001000110ca	movzbl	(%rax), %ecx
00000001000110cd	testl	%ecx, %ecx
00000001000110cf	je	0x1000110e8
00000001000110d1	cmpl	$0x30, %ecx
00000001000110d4	jne	0x1000110e5
00000001000110d6	xorl	%ecx, %ecx
00000001000110d8	cmpb	$0x0, 0x1(%rax)
00000001000110dc	setne	%cl
00000001000110df	jmp	0x1000110e8
00000001000110e1	xorl	%ecx, %ecx
00000001000110e3	jmp	0x1000110e8
00000001000110e5	pushq	$0x1
00000001000110e7	popq	%rcx
00000001000110e8	movl	%ecx, (%rbx)
00000001000110ea	movl	%ecx, _fwp_reuse_verify(%rip)
00000001000110f0	addq	$0x8, %rsp
00000001000110f4	popq	%rbx
00000001000110f5	popq	%rbp
00000001000110f6	retq
00000001000110f7	nopw	(%rax,%rax)
_fwp_rc_free_obj.cold.1:
0000000100011100	pushq	%rbp
0000000100011101	movq	%rsp, %rbp
0000000100011104	pushq	%rbx
0000000100011105	pushq	%rax
0000000100011106	movq	%rdi, %rbx
0000000100011109	leaq	0x890(%rip), %rdi               ## literal pool for: "FWP_REUSE_VERIFY"
0000000100011110	callq	0x1000111de                     ## symbol stub for: _getenv
0000000100011115	testq	%rax, %rax
0000000100011118	je	0x100011131
000000010001111a	movzbl	(%rax), %ecx
000000010001111d	testl	%ecx, %ecx
000000010001111f	je	0x100011138
0000000100011121	cmpl	$0x30, %ecx
0000000100011124	jne	0x100011135
0000000100011126	xorl	%ecx, %ecx
0000000100011128	cmpb	$0x0, 0x1(%rax)
000000010001112c	setne	%cl
000000010001112f	jmp	0x100011138
0000000100011131	xorl	%ecx, %ecx
0000000100011133	jmp	0x100011138
0000000100011135	pushq	$0x1
0000000100011137	popq	%rcx
0000000100011138	movl	%ecx, (%rbx)
000000010001113a	movl	%ecx, _fwp_reuse_verify(%rip)
0000000100011140	addq	$0x8, %rsp
0000000100011144	popq	%rbx
0000000100011145	popq	%rbp
0000000100011146	retq
