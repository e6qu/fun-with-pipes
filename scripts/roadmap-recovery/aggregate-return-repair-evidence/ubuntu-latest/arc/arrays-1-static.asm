
/tmp/fwp-arc-4399/arrays-1-static-O2:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b9 0f 01 00 	mov    0x10fb9(%rip),%rax        # 12fc8 <__gmon_start__@Base>
    200f:	48 85 c0             	test   %rax,%rax
    2012:	74 02                	je     2016 <_init+0x16>
    2014:	ff d0                	call   *%rax
    2016:	48 83 c4 08          	add    $0x8,%rsp
    201a:	c3                   	ret

Disassembly of section .plt:

0000000000002020 <getenv@plt-0x10>:
    2020:	ff 35 ca 0f 01 00    	push   0x10fca(%rip)        # 12ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	ff 25 cc 0f 01 00    	jmp    *0x10fcc(%rip)        # 12ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    202c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002030 <getenv@plt>:
    2030:	ff 25 ca 0f 01 00    	jmp    *0x10fca(%rip)        # 13000 <getenv@GLIBC_2.2.5>
    2036:	68 00 00 00 00       	push   $0x0
    203b:	e9 e0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002040 <dl_iterate_phdr@plt>:
    2040:	ff 25 c2 0f 01 00    	jmp    *0x10fc2(%rip)        # 13008 <dl_iterate_phdr@GLIBC_2.2.5>
    2046:	68 01 00 00 00       	push   $0x1
    204b:	e9 d0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002050 <abort@plt>:
    2050:	ff 25 ba 0f 01 00    	jmp    *0x10fba(%rip)        # 13010 <abort@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <_exit@plt>:
    2060:	ff 25 b2 0f 01 00    	jmp    *0x10fb2(%rip)        # 13018 <_exit@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <strcpy@plt>:
    2070:	ff 25 aa 0f 01 00    	jmp    *0x10faa(%rip)        # 13020 <strcpy@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <sigaction@plt>:
    2080:	ff 25 a2 0f 01 00    	jmp    *0x10fa2(%rip)        # 13028 <sigaction@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <strtod@plt>:
    2090:	ff 25 9a 0f 01 00    	jmp    *0x10f9a(%rip)        # 13030 <strtod@GLIBC_2.2.5>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <clock_gettime@plt>:
    20a0:	ff 25 92 0f 01 00    	jmp    *0x10f92(%rip)        # 13038 <clock_gettime@GLIBC_2.17>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <write@plt>:
    20b0:	ff 25 8a 0f 01 00    	jmp    *0x10f8a(%rip)        # 13040 <write@GLIBC_2.2.5>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <fclose@plt>:
    20c0:	ff 25 82 0f 01 00    	jmp    *0x10f82(%rip)        # 13048 <fclose@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <strlen@plt>:
    20d0:	ff 25 7a 0f 01 00    	jmp    *0x10f7a(%rip)        # 13050 <strlen@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <mmap@plt>:
    20e0:	ff 25 72 0f 01 00    	jmp    *0x10f72(%rip)        # 13058 <mmap@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <strchr@plt>:
    20f0:	ff 25 6a 0f 01 00    	jmp    *0x10f6a(%rip)        # 13060 <strchr@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <snprintf@plt>:
    2100:	ff 25 62 0f 01 00    	jmp    *0x10f62(%rip)        # 13068 <snprintf@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <strtof@plt>:
    2110:	ff 25 5a 0f 01 00    	jmp    *0x10f5a(%rip)        # 13070 <strtof@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <memset@plt>:
    2120:	ff 25 52 0f 01 00    	jmp    *0x10f52(%rip)        # 13078 <memset@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <fputc@plt>:
    2130:	ff 25 4a 0f 01 00    	jmp    *0x10f4a(%rip)        # 13080 <fputc@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <pthread_attr_init@plt>:
    2140:	ff 25 42 0f 01 00    	jmp    *0x10f42(%rip)        # 13088 <pthread_attr_init@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <fgets@plt>:
    2150:	ff 25 3a 0f 01 00    	jmp    *0x10f3a(%rip)        # 13090 <fgets@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <strtoull@plt>:
    2160:	ff 25 32 0f 01 00    	jmp    *0x10f32(%rip)        # 13098 <strtoull@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <strcmp@plt>:
    2170:	ff 25 2a 0f 01 00    	jmp    *0x10f2a(%rip)        # 130a0 <strcmp@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <signal@plt>:
    2180:	ff 25 22 0f 01 00    	jmp    *0x10f22(%rip)        # 130a8 <signal@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <strtoll@plt>:
    2190:	ff 25 1a 0f 01 00    	jmp    *0x10f1a(%rip)        # 130b0 <strtoll@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <fprintf@plt>:
    21a0:	ff 25 12 0f 01 00    	jmp    *0x10f12(%rip)        # 130b8 <fprintf@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <sigemptyset@plt>:
    21b0:	ff 25 0a 0f 01 00    	jmp    *0x10f0a(%rip)        # 130c0 <sigemptyset@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <strtol@plt>:
    21c0:	ff 25 02 0f 01 00    	jmp    *0x10f02(%rip)        # 130c8 <strtol@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <memcpy@plt>:
    21d0:	ff 25 fa 0e 01 00    	jmp    *0x10efa(%rip)        # 130d0 <memcpy@GLIBC_2.14>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <fflush@plt>:
    21e0:	ff 25 f2 0e 01 00    	jmp    *0x10ef2(%rip)        # 130d8 <fflush@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <pthread_attr_setstack@plt>:
    21f0:	ff 25 ea 0e 01 00    	jmp    *0x10eea(%rip)        # 130e0 <pthread_attr_setstack@GLIBC_2.34>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <setvbuf@plt>:
    2200:	ff 25 e2 0e 01 00    	jmp    *0x10ee2(%rip)        # 130e8 <setvbuf@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <pthread_create@plt>:
    2210:	ff 25 da 0e 01 00    	jmp    *0x10eda(%rip)        # 130f0 <pthread_create@GLIBC_2.34>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <mprotect@plt>:
    2220:	ff 25 d2 0e 01 00    	jmp    *0x10ed2(%rip)        # 130f8 <mprotect@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <fopen@plt>:
    2230:	ff 25 ca 0e 01 00    	jmp    *0x10eca(%rip)        # 13100 <fopen@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <sysconf@plt>:
    2240:	ff 25 c2 0e 01 00    	jmp    *0x10ec2(%rip)        # 13108 <sysconf@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <__cxa_atexit@plt>:
    2250:	ff 25 ba 0e 01 00    	jmp    *0x10eba(%rip)        # 13110 <__cxa_atexit@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <sprintf@plt>:
    2260:	ff 25 b2 0e 01 00    	jmp    *0x10eb2(%rip)        # 13118 <sprintf@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <exit@plt>:
    2270:	ff 25 aa 0e 01 00    	jmp    *0x10eaa(%rip)        # 13120 <exit@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <fwrite@plt>:
    2280:	ff 25 a2 0e 01 00    	jmp    *0x10ea2(%rip)        # 13128 <fwrite@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <getrlimit@plt>:
    2290:	ff 25 9a 0e 01 00    	jmp    *0x10e9a(%rip)        # 13130 <getrlimit@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <pthread_join@plt>:
    22a0:	ff 25 92 0e 01 00    	jmp    *0x10e92(%rip)        # 13138 <pthread_join@GLIBC_2.34>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <sigaltstack@plt>:
    22b0:	ff 25 8a 0e 01 00    	jmp    *0x10e8a(%rip)        # 13140 <sigaltstack@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <strstr@plt>:
    22c0:	ff 25 82 0e 01 00    	jmp    *0x10e82(%rip)        # 13148 <strstr@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

00000000000022d0 <__cxa_finalize@plt>:
    22d0:	ff 25 02 0d 01 00    	jmp    *0x10d02(%rip)        # 12fd8 <__cxa_finalize@GLIBC_2.2.5>
    22d6:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000022e0 <_start>:
    22e0:	f3 0f 1e fa          	endbr64
    22e4:	31 ed                	xor    %ebp,%ebp
    22e6:	49 89 d1             	mov    %rdx,%r9
    22e9:	5e                   	pop    %rsi
    22ea:	48 89 e2             	mov    %rsp,%rdx
    22ed:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    22f1:	50                   	push   %rax
    22f2:	54                   	push   %rsp
    22f3:	45 31 c0             	xor    %r8d,%r8d
    22f6:	31 c9                	xor    %ecx,%ecx
    22f8:	48 8d 3d d1 06 00 00 	lea    0x6d1(%rip),%rdi        # 29d0 <main>
    22ff:	ff 15 ab 0c 01 00    	call   *0x10cab(%rip)        # 12fb0 <__libc_start_main@GLIBC_2.34>
    2305:	f4                   	hlt
    2306:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    230d:	00 00 00 

0000000000002310 <deregister_tm_clones>:
    2310:	48 8d 3d 79 28 01 00 	lea    0x12879(%rip),%rdi        # 14b90 <__TMC_END__>
    2317:	48 8d 05 72 28 01 00 	lea    0x12872(%rip),%rax        # 14b90 <__TMC_END__>
    231e:	48 39 f8             	cmp    %rdi,%rax
    2321:	74 15                	je     2338 <deregister_tm_clones+0x28>
    2323:	48 8b 05 8e 0c 01 00 	mov    0x10c8e(%rip),%rax        # 12fb8 <_ITM_deregisterTMCloneTable@Base>
    232a:	48 85 c0             	test   %rax,%rax
    232d:	74 09                	je     2338 <deregister_tm_clones+0x28>
    232f:	ff e0                	jmp    *%rax
    2331:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2338:	c3                   	ret
    2339:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002340 <register_tm_clones>:
    2340:	48 8d 3d 49 28 01 00 	lea    0x12849(%rip),%rdi        # 14b90 <__TMC_END__>
    2347:	48 8d 35 42 28 01 00 	lea    0x12842(%rip),%rsi        # 14b90 <__TMC_END__>
    234e:	48 29 fe             	sub    %rdi,%rsi
    2351:	48 89 f0             	mov    %rsi,%rax
    2354:	48 c1 ee 3f          	shr    $0x3f,%rsi
    2358:	48 c1 f8 03          	sar    $0x3,%rax
    235c:	48 01 c6             	add    %rax,%rsi
    235f:	48 d1 fe             	sar    $1,%rsi
    2362:	74 14                	je     2378 <register_tm_clones+0x38>
    2364:	48 8b 05 65 0c 01 00 	mov    0x10c65(%rip),%rax        # 12fd0 <_ITM_registerTMCloneTable@Base>
    236b:	48 85 c0             	test   %rax,%rax
    236e:	74 08                	je     2378 <register_tm_clones+0x38>
    2370:	ff e0                	jmp    *%rax
    2372:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2378:	c3                   	ret
    2379:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002380 <__do_global_dtors_aux>:
    2380:	f3 0f 1e fa          	endbr64
    2384:	80 3d 05 28 01 00 00 	cmpb   $0x0,0x12805(%rip)        # 14b90 <__TMC_END__>
    238b:	75 2b                	jne    23b8 <__do_global_dtors_aux+0x38>
    238d:	55                   	push   %rbp
    238e:	48 83 3d 42 0c 01 00 	cmpq   $0x0,0x10c42(%rip)        # 12fd8 <__cxa_finalize@GLIBC_2.2.5>
    2395:	00 
    2396:	48 89 e5             	mov    %rsp,%rbp
    2399:	74 0c                	je     23a7 <__do_global_dtors_aux+0x27>
    239b:	48 8b 3d b6 0d 01 00 	mov    0x10db6(%rip),%rdi        # 13158 <__dso_handle>
    23a2:	e8 29 ff ff ff       	call   22d0 <__cxa_finalize@plt>
    23a7:	e8 64 ff ff ff       	call   2310 <deregister_tm_clones>
    23ac:	c6 05 dd 27 01 00 01 	movb   $0x1,0x127dd(%rip)        # 14b90 <__TMC_END__>
    23b3:	5d                   	pop    %rbp
    23b4:	c3                   	ret
    23b5:	0f 1f 00             	nopl   (%rax)
    23b8:	c3                   	ret
    23b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000023c0 <frame_dummy>:
    23c0:	f3 0f 1e fa          	endbr64
    23c4:	e9 77 ff ff ff       	jmp    2340 <register_tm_clones>
    23c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000023d0 <free>:
    23d0:	48 85 ff             	test   %rdi,%rdi
    23d3:	74 68                	je     243d <free+0x6d>
    23d5:	8b 47 f4             	mov    -0xc(%rdi),%eax
    23d8:	48 f7 d8             	neg    %rax
    23db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    23e0:	b1 01                	mov    $0x1,%cl
    23e2:	86 0d 00 30 01 00    	xchg   %cl,0x13000(%rip)        # 153e8 <fwp_static+0x848>
    23e8:	84 c9                	test   %cl,%cl
    23ea:	75 f4                	jne    23e0 <free+0x10>
    23ec:	8b 54 07 f0          	mov    -0x10(%rdi,%rax,1),%edx
    23f0:	89 d1                	mov    %edx,%ecx
    23f2:	c1 e9 02             	shr    $0x2,%ecx
    23f5:	be 01 00 00 00       	mov    $0x1,%esi
    23fa:	48 d3 e6             	shl    %cl,%rsi
    23fd:	48 8d 0c 07          	lea    (%rdi,%rax,1),%rcx
    2401:	48 83 c1 f0          	add    $0xfffffffffffffff0,%rcx
    2405:	41 89 d0             	mov    %edx,%r8d
    2408:	41 83 e0 03          	and    $0x3,%r8d
    240c:	49 89 f1             	mov    %rsi,%r9
    240f:	49 c1 e9 02          	shr    $0x2,%r9
    2413:	4d 0f af c8          	imul   %r8,%r9
    2417:	4c 8d 05 82 27 01 00 	lea    0x12782(%rip),%r8        # 14ba0 <fwp_static>
    241e:	49 01 f1             	add    %rsi,%r9
    2421:	4c 29 0d b0 2f 01 00 	sub    %r9,0x12fb0(%rip)        # 153d8 <fwp_static+0x838>
    2428:	49 8b 74 d0 38       	mov    0x38(%r8,%rdx,8),%rsi
    242d:	48 89 34 07          	mov    %rsi,(%rdi,%rax,1)
    2431:	49 89 4c d0 38       	mov    %rcx,0x38(%r8,%rdx,8)
    2436:	c6 05 ab 2f 01 00 00 	movb   $0x0,0x12fab(%rip)        # 153e8 <fwp_static+0x848>
    243d:	c3                   	ret
    243e:	66 90                	xchg   %ax,%ax

0000000000002440 <malloc>:
    2440:	48 83 ff 01          	cmp    $0x1,%rdi
    2444:	48 83 d7 00          	adc    $0x0,%rdi
    2448:	eb 06                	jmp    2450 <fwp_pool_get>
    244a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002450 <fwp_pool_get>:
    2450:	53                   	push   %rbx
    2451:	48 81 ec d0 00 00 00 	sub    $0xd0,%rsp
    2458:	48 89 fb             	mov    %rdi,%rbx
    245b:	83 3d 3e 27 01 00 00 	cmpl   $0x0,0x1273e(%rip)        # 14ba0 <fwp_static>
    2462:	75 05                	jne    2469 <fwp_pool_get+0x19>
    2464:	e8 c7 06 00 00       	call   2b30 <fwp_static_init>
    2469:	48 81 fb 01 00 00 02 	cmp    $0x2000001,%rbx
    2470:	0f 83 1d 01 00 00    	jae    2593 <fwp_pool_get+0x143>
    2476:	48 83 fb 11          	cmp    $0x11,%rbx
    247a:	b8 10 00 00 00       	mov    $0x10,%eax
    247f:	48 0f 43 c3          	cmovae %rbx,%rax
    2483:	48 8d 48 10          	lea    0x10(%rax),%rcx
    2487:	48 0f bd c9          	bsr    %rcx,%rcx
    248b:	89 ce                	mov    %ecx,%esi
    248d:	bf 01 00 00 00       	mov    $0x1,%edi
    2492:	48 d3 e7             	shl    %cl,%rdi
    2495:	83 f6 3f             	xor    $0x3f,%esi
    2498:	48 c1 ef 02          	shr    $0x2,%rdi
    249c:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    24a3:	48 d3 c2             	rol    %cl,%rdx
    24a6:	48 01 d0             	add    %rdx,%rax
    24a9:	48 83 c0 10          	add    $0x10,%rax
    24ad:	48 01 f8             	add    %rdi,%rax
    24b0:	48 89 c2             	mov    %rax,%rdx
    24b3:	48 09 fa             	or     %rdi,%rdx
    24b6:	48 c1 ea 20          	shr    $0x20,%rdx
    24ba:	74 07                	je     24c3 <fwp_pool_get+0x73>
    24bc:	31 d2                	xor    %edx,%edx
    24be:	48 f7 f7             	div    %rdi
    24c1:	eb 04                	jmp    24c7 <fwp_pool_get+0x77>
    24c3:	31 d2                	xor    %edx,%edx
    24c5:	f7 f7                	div    %edi
    24c7:	c1 e6 02             	shl    $0x2,%esi
    24ca:	bf 00 01 00 00       	mov    $0x100,%edi
    24cf:	29 f7                	sub    %esi,%edi
    24d1:	48 83 f8 04          	cmp    $0x4,%rax
    24d5:	8d 14 88             	lea    (%rax,%rcx,4),%edx
    24d8:	0f 44 d7             	cmove  %edi,%edx
    24db:	89 d1                	mov    %edx,%ecx
    24dd:	c1 e9 02             	shr    $0x2,%ecx
    24e0:	b8 01 00 00 00       	mov    $0x1,%eax
    24e5:	48 d3 e0             	shl    %cl,%rax
    24e8:	89 d6                	mov    %edx,%esi
    24ea:	83 e6 03             	and    $0x3,%esi
    24ed:	48 89 c1             	mov    %rax,%rcx
    24f0:	48 c1 e9 02          	shr    $0x2,%rcx
    24f4:	48 0f af ce          	imul   %rsi,%rcx
    24f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    24ff:	00 
    2500:	40 b6 01             	mov    $0x1,%sil
    2503:	40 86 35 de 2e 01 00 	xchg   %sil,0x12ede(%rip)        # 153e8 <fwp_static+0x848>
    250a:	40 84 f6             	test   %sil,%sil
    250d:	75 f1                	jne    2500 <fwp_pool_get+0xb0>
    250f:	48 01 c1             	add    %rax,%rcx
    2512:	89 d6                	mov    %edx,%esi
    2514:	48 8d 3d 85 26 01 00 	lea    0x12685(%rip),%rdi        # 14ba0 <fwp_static>
    251b:	48 8b 44 f7 38       	mov    0x38(%rdi,%rsi,8),%rax
    2520:	48 85 c0             	test   %rax,%rax
    2523:	74 0b                	je     2530 <fwp_pool_get+0xe0>
    2525:	4c 8b 40 10          	mov    0x10(%rax),%r8
    2529:	4c 89 44 f7 38       	mov    %r8,0x38(%rdi,%rsi,8)
    252e:	eb 21                	jmp    2551 <fwp_pool_get+0x101>
    2530:	48 8b 35 99 26 01 00 	mov    0x12699(%rip),%rsi        # 14bd0 <fwp_static+0x30>
    2537:	48 8b 05 8a 26 01 00 	mov    0x1268a(%rip),%rax        # 14bc8 <fwp_static+0x28>
    253e:	48 29 c6             	sub    %rax,%rsi
    2541:	48 39 ce             	cmp    %rcx,%rsi
    2544:	72 46                	jb     258c <fwp_pool_get+0x13c>
    2546:	48 8d 34 08          	lea    (%rax,%rcx,1),%rsi
    254a:	48 89 35 77 26 01 00 	mov    %rsi,0x12677(%rip)        # 14bc8 <fwp_static+0x28>
    2551:	48 03 0d 80 2e 01 00 	add    0x12e80(%rip),%rcx        # 153d8 <fwp_static+0x838>
    2558:	48 89 0d 79 2e 01 00 	mov    %rcx,0x12e79(%rip)        # 153d8 <fwp_static+0x838>
    255f:	48 3b 0d 7a 2e 01 00 	cmp    0x12e7a(%rip),%rcx        # 153e0 <fwp_static+0x840>
    2566:	76 07                	jbe    256f <fwp_pool_get+0x11f>
    2568:	48 89 0d 71 2e 01 00 	mov    %rcx,0x12e71(%rip)        # 153e0 <fwp_static+0x840>
    256f:	c6 05 72 2e 01 00 00 	movb   $0x0,0x12e72(%rip)        # 153e8 <fwp_static+0x848>
    2576:	89 10                	mov    %edx,(%rax)
    2578:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
    257f:	48 83 c0 10          	add    $0x10,%rax
    2583:	48 81 c4 d0 00 00 00 	add    $0xd0,%rsp
    258a:	5b                   	pop    %rbx
    258b:	c3                   	ret
    258c:	c6 05 55 2e 01 00 00 	movb   $0x0,0x12e55(%rip)        # 153e8 <fwp_static+0x848>
    2593:	48 8d 15 c9 cd 00 00 	lea    0xcdc9(%rip),%rdx        # f363 <fwp_segv.msg+0xe3>
    259a:	48 8d 0d af cd 00 00 	lea    0xcdaf(%rip),%rcx        # f350 <fwp_segv.msg+0xd0>
    25a1:	4c 8d 0d b4 cd 00 00 	lea    0xcdb4(%rip),%r9        # f35c <fwp_segv.msg+0xdc>
    25a8:	48 89 e3             	mov    %rsp,%rbx
    25ab:	be c8 00 00 00       	mov    $0xc8,%esi
    25b0:	41 b8 00 80 00 00    	mov    $0x8000,%r8d
    25b6:	48 89 df             	mov    %rbx,%rdi
    25b9:	31 c0                	xor    %eax,%eax
    25bb:	e8 40 fb ff ff       	call   2100 <snprintf@plt>
    25c0:	48 63 d0             	movslq %eax,%rdx
    25c3:	bf 02 00 00 00       	mov    $0x2,%edi
    25c8:	48 89 de             	mov    %rbx,%rsi
    25cb:	e8 e0 fa ff ff       	call   20b0 <write@plt>
    25d0:	bf 66 00 00 00       	mov    $0x66,%edi
    25d5:	e8 86 fa ff ff       	call   2060 <_exit@plt>
    25da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000025e0 <calloc>:
    25e0:	41 56                	push   %r14
    25e2:	53                   	push   %rbx
    25e3:	50                   	push   %rax
    25e4:	48 85 f6             	test   %rsi,%rsi
    25e7:	74 0c                	je     25f5 <calloc+0x15>
    25e9:	48 89 f0             	mov    %rsi,%rax
    25ec:	48 f7 e7             	mul    %rdi
    25ef:	71 04                	jno    25f5 <calloc+0x15>
    25f1:	31 db                	xor    %ebx,%ebx
    25f3:	eb 27                	jmp    261c <calloc+0x3c>
    25f5:	48 0f af f7          	imul   %rdi,%rsi
    25f9:	48 83 fe 01          	cmp    $0x1,%rsi
    25fd:	48 89 f7             	mov    %rsi,%rdi
    2600:	48 83 d7 00          	adc    $0x0,%rdi
    2604:	49 89 f6             	mov    %rsi,%r14
    2607:	e8 44 fe ff ff       	call   2450 <fwp_pool_get>
    260c:	48 89 c3             	mov    %rax,%rbx
    260f:	48 89 c7             	mov    %rax,%rdi
    2612:	31 f6                	xor    %esi,%esi
    2614:	4c 89 f2             	mov    %r14,%rdx
    2617:	e8 04 fb ff ff       	call   2120 <memset@plt>
    261c:	48 89 d8             	mov    %rbx,%rax
    261f:	48 83 c4 08          	add    $0x8,%rsp
    2623:	5b                   	pop    %rbx
    2624:	41 5e                	pop    %r14
    2626:	c3                   	ret
    2627:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    262e:	00 00 

0000000000002630 <realloc>:
    2630:	48 85 ff             	test   %rdi,%rdi
    2633:	0f 84 d1 00 00 00    	je     270a <realloc+0xda>
    2639:	48 85 f6             	test   %rsi,%rsi
    263c:	0f 84 d8 00 00 00    	je     271a <realloc+0xea>
    2642:	41 57                	push   %r15
    2644:	41 56                	push   %r14
    2646:	41 54                	push   %r12
    2648:	53                   	push   %rbx
    2649:	50                   	push   %rax
    264a:	4c 8d 7f f0          	lea    -0x10(%rdi),%r15
    264e:	8b 47 f4             	mov    -0xc(%rdi),%eax
    2651:	4c 89 fb             	mov    %r15,%rbx
    2654:	48 29 c3             	sub    %rax,%rbx
    2657:	48 f7 d8             	neg    %rax
    265a:	8b 44 07 f0          	mov    -0x10(%rdi,%rax,1),%eax
    265e:	89 c1                	mov    %eax,%ecx
    2660:	c1 e9 02             	shr    $0x2,%ecx
    2663:	ba 01 00 00 00       	mov    $0x1,%edx
    2668:	48 d3 e2             	shl    %cl,%rdx
    266b:	83 e0 03             	and    $0x3,%eax
    266e:	48 29 fb             	sub    %rdi,%rbx
    2671:	48 01 d3             	add    %rdx,%rbx
    2674:	48 c1 ea 02          	shr    $0x2,%rdx
    2678:	48 0f af d0          	imul   %rax,%rdx
    267c:	48 01 d3             	add    %rdx,%rbx
    267f:	48 39 f3             	cmp    %rsi,%rbx
    2682:	0f 83 f3 00 00 00    	jae    277b <realloc+0x14b>
    2688:	49 89 fe             	mov    %rdi,%r14
    268b:	48 89 f7             	mov    %rsi,%rdi
    268e:	e8 bd fd ff ff       	call   2450 <fwp_pool_get>
    2693:	49 89 c4             	mov    %rax,%r12
    2696:	48 89 c7             	mov    %rax,%rdi
    2699:	4c 89 f6             	mov    %r14,%rsi
    269c:	48 89 da             	mov    %rbx,%rdx
    269f:	e8 2c fb ff ff       	call   21d0 <memcpy@plt>
    26a4:	41 8b 46 f4          	mov    -0xc(%r14),%eax
    26a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    26af:	00 
    26b0:	b1 01                	mov    $0x1,%cl
    26b2:	86 0d 30 2d 01 00    	xchg   %cl,0x12d30(%rip)        # 153e8 <fwp_static+0x848>
    26b8:	84 c9                	test   %cl,%cl
    26ba:	75 f4                	jne    26b0 <realloc+0x80>
    26bc:	49 29 c7             	sub    %rax,%r15
    26bf:	41 8b 07             	mov    (%r15),%eax
    26c2:	89 c1                	mov    %eax,%ecx
    26c4:	c1 e9 02             	shr    $0x2,%ecx
    26c7:	ba 01 00 00 00       	mov    $0x1,%edx
    26cc:	48 d3 e2             	shl    %cl,%rdx
    26cf:	89 c1                	mov    %eax,%ecx
    26d1:	83 e1 03             	and    $0x3,%ecx
    26d4:	48 89 d6             	mov    %rdx,%rsi
    26d7:	48 c1 ee 02          	shr    $0x2,%rsi
    26db:	48 0f af f1          	imul   %rcx,%rsi
    26df:	48 8d 0d ba 24 01 00 	lea    0x124ba(%rip),%rcx        # 14ba0 <fwp_static>
    26e6:	48 01 d6             	add    %rdx,%rsi
    26e9:	48 29 35 e8 2c 01 00 	sub    %rsi,0x12ce8(%rip)        # 153d8 <fwp_static+0x838>
    26f0:	48 8b 54 c1 38       	mov    0x38(%rcx,%rax,8),%rdx
    26f5:	49 89 57 10          	mov    %rdx,0x10(%r15)
    26f9:	4c 89 7c c1 38       	mov    %r15,0x38(%rcx,%rax,8)
    26fe:	c6 05 e3 2c 01 00 00 	movb   $0x0,0x12ce3(%rip)        # 153e8 <fwp_static+0x848>
    2705:	4c 89 e0             	mov    %r12,%rax
    2708:	eb 74                	jmp    277e <realloc+0x14e>
    270a:	48 83 fe 01          	cmp    $0x1,%rsi
    270e:	48 83 d6 00          	adc    $0x0,%rsi
    2712:	48 89 f7             	mov    %rsi,%rdi
    2715:	e9 36 fd ff ff       	jmp    2450 <fwp_pool_get>
    271a:	8b 47 f4             	mov    -0xc(%rdi),%eax
    271d:	0f 1f 00             	nopl   (%rax)
    2720:	b1 01                	mov    $0x1,%cl
    2722:	86 0d c0 2c 01 00    	xchg   %cl,0x12cc0(%rip)        # 153e8 <fwp_static+0x848>
    2728:	84 c9                	test   %cl,%cl
    272a:	75 f4                	jne    2720 <realloc+0xf0>
    272c:	48 29 c7             	sub    %rax,%rdi
    272f:	8b 47 f0             	mov    -0x10(%rdi),%eax
    2732:	89 c1                	mov    %eax,%ecx
    2734:	c1 e9 02             	shr    $0x2,%ecx
    2737:	ba 01 00 00 00       	mov    $0x1,%edx
    273c:	48 d3 e2             	shl    %cl,%rdx
    273f:	48 8d 4f f0          	lea    -0x10(%rdi),%rcx
    2743:	89 c6                	mov    %eax,%esi
    2745:	83 e6 03             	and    $0x3,%esi
    2748:	49 89 d0             	mov    %rdx,%r8
    274b:	49 c1 e8 02          	shr    $0x2,%r8
    274f:	4c 0f af c6          	imul   %rsi,%r8
    2753:	48 8d 35 46 24 01 00 	lea    0x12446(%rip),%rsi        # 14ba0 <fwp_static>
    275a:	49 01 d0             	add    %rdx,%r8
    275d:	4c 29 05 74 2c 01 00 	sub    %r8,0x12c74(%rip)        # 153d8 <fwp_static+0x838>
    2764:	48 8b 54 c6 38       	mov    0x38(%rsi,%rax,8),%rdx
    2769:	48 89 17             	mov    %rdx,(%rdi)
    276c:	48 89 4c c6 38       	mov    %rcx,0x38(%rsi,%rax,8)
    2771:	c6 05 70 2c 01 00 00 	movb   $0x0,0x12c70(%rip)        # 153e8 <fwp_static+0x848>
    2778:	31 c0                	xor    %eax,%eax
    277a:	c3                   	ret
    277b:	48 89 f8             	mov    %rdi,%rax
    277e:	48 83 c4 08          	add    $0x8,%rsp
    2782:	5b                   	pop    %rbx
    2783:	41 5c                	pop    %r12
    2785:	41 5e                	pop    %r14
    2787:	41 5f                	pop    %r15
    2789:	c3                   	ret
    278a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002790 <posix_memalign>:
    2790:	41 56                	push   %r14
    2792:	53                   	push   %rbx
    2793:	50                   	push   %rax
    2794:	48 89 fb             	mov    %rdi,%rbx
    2797:	48 83 fe 10          	cmp    $0x10,%rsi
    279b:	77 12                	ja     27af <posix_memalign+0x1f>
    279d:	48 83 fa 01          	cmp    $0x1,%rdx
    27a1:	48 83 d2 00          	adc    $0x0,%rdx
    27a5:	48 89 d7             	mov    %rdx,%rdi
    27a8:	e8 a3 fc ff ff       	call   2450 <fwp_pool_get>
    27ad:	eb 38                	jmp    27e7 <posix_memalign+0x57>
    27af:	49 89 f6             	mov    %rsi,%r14
    27b2:	48 01 f2             	add    %rsi,%rdx
    27b5:	48 89 d7             	mov    %rdx,%rdi
    27b8:	e8 93 fc ff ff       	call   2450 <fwp_pool_get>
    27bd:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    27c1:	48 ff c9             	dec    %rcx
    27c4:	49 f7 de             	neg    %r14
    27c7:	49 21 ce             	and    %rcx,%r14
    27ca:	49 39 c6             	cmp    %rax,%r14
    27cd:	74 18                	je     27e7 <posix_memalign+0x57>
    27cf:	8b 48 f0             	mov    -0x10(%rax),%ecx
    27d2:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
    27d6:	49 8d 56 f0          	lea    -0x10(%r14),%rdx
    27da:	41 89 4e f0          	mov    %ecx,-0x10(%r14)
    27de:	29 c2                	sub    %eax,%edx
    27e0:	41 89 56 f4          	mov    %edx,-0xc(%r14)
    27e4:	4c 89 f0             	mov    %r14,%rax
    27e7:	48 89 03             	mov    %rax,(%rbx)
    27ea:	31 c0                	xor    %eax,%eax
    27ec:	48 83 c4 08          	add    $0x8,%rsp
    27f0:	5b                   	pop    %rbx
    27f1:	41 5e                	pop    %r14
    27f3:	c3                   	ret
    27f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    27fb:	00 00 00 00 00 

0000000000002800 <aligned_alloc>:
    2800:	48 83 ff 10          	cmp    $0x10,%rdi
    2804:	77 10                	ja     2816 <aligned_alloc+0x16>
    2806:	48 83 fe 01          	cmp    $0x1,%rsi
    280a:	48 83 d6 00          	adc    $0x0,%rsi
    280e:	48 89 f7             	mov    %rsi,%rdi
    2811:	e9 3a fc ff ff       	jmp    2450 <fwp_pool_get>
    2816:	53                   	push   %rbx
    2817:	48 89 fb             	mov    %rdi,%rbx
    281a:	48 01 fe             	add    %rdi,%rsi
    281d:	48 89 f7             	mov    %rsi,%rdi
    2820:	e8 2b fc ff ff       	call   2450 <fwp_pool_get>
    2825:	48 8d 0c 03          	lea    (%rbx,%rax,1),%rcx
    2829:	48 ff c9             	dec    %rcx
    282c:	48 f7 db             	neg    %rbx
    282f:	48 21 cb             	and    %rcx,%rbx
    2832:	48 39 c3             	cmp    %rax,%rbx
    2835:	74 16                	je     284d <aligned_alloc+0x4d>
    2837:	8b 48 f0             	mov    -0x10(%rax),%ecx
    283a:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
    283e:	48 8d 53 f0          	lea    -0x10(%rbx),%rdx
    2842:	89 4b f0             	mov    %ecx,-0x10(%rbx)
    2845:	29 c2                	sub    %eax,%edx
    2847:	89 53 f4             	mov    %edx,-0xc(%rbx)
    284a:	48 89 d8             	mov    %rbx,%rax
    284d:	5b                   	pop    %rbx
    284e:	c3                   	ret
    284f:	90                   	nop

0000000000002850 <memalign>:
    2850:	48 83 ff 10          	cmp    $0x10,%rdi
    2854:	77 10                	ja     2866 <memalign+0x16>
    2856:	48 83 fe 01          	cmp    $0x1,%rsi
    285a:	48 83 d6 00          	adc    $0x0,%rsi
    285e:	48 89 f7             	mov    %rsi,%rdi
    2861:	e9 ea fb ff ff       	jmp    2450 <fwp_pool_get>
    2866:	53                   	push   %rbx
    2867:	48 89 fb             	mov    %rdi,%rbx
    286a:	48 01 fe             	add    %rdi,%rsi
    286d:	48 89 f7             	mov    %rsi,%rdi
    2870:	e8 db fb ff ff       	call   2450 <fwp_pool_get>
    2875:	48 8d 0c 03          	lea    (%rbx,%rax,1),%rcx
    2879:	48 ff c9             	dec    %rcx
    287c:	48 f7 db             	neg    %rbx
    287f:	48 21 cb             	and    %rcx,%rbx
    2882:	48 39 c3             	cmp    %rax,%rbx
    2885:	74 16                	je     289d <memalign+0x4d>
    2887:	8b 48 f0             	mov    -0x10(%rax),%ecx
    288a:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
    288e:	48 8d 53 f0          	lea    -0x10(%rbx),%rdx
    2892:	89 4b f0             	mov    %ecx,-0x10(%rbx)
    2895:	29 c2                	sub    %eax,%edx
    2897:	89 53 f4             	mov    %edx,-0xc(%rbx)
    289a:	48 89 d8             	mov    %rbx,%rax
    289d:	5b                   	pop    %rbx
    289e:	c3                   	ret
    289f:	90                   	nop

00000000000028a0 <valloc>:
    28a0:	41 56                	push   %r14
    28a2:	53                   	push   %rbx
    28a3:	50                   	push   %rax
    28a4:	49 89 fe             	mov    %rdi,%r14
    28a7:	bf 1e 00 00 00       	mov    $0x1e,%edi
    28ac:	e8 8f f9 ff ff       	call   2240 <sysconf@plt>
    28b1:	48 83 f8 10          	cmp    $0x10,%rax
    28b5:	77 17                	ja     28ce <valloc+0x2e>
    28b7:	49 83 fe 01          	cmp    $0x1,%r14
    28bb:	49 83 d6 00          	adc    $0x0,%r14
    28bf:	4c 89 f7             	mov    %r14,%rdi
    28c2:	48 83 c4 08          	add    $0x8,%rsp
    28c6:	5b                   	pop    %rbx
    28c7:	41 5e                	pop    %r14
    28c9:	e9 82 fb ff ff       	jmp    2450 <fwp_pool_get>
    28ce:	48 89 c3             	mov    %rax,%rbx
    28d1:	49 01 c6             	add    %rax,%r14
    28d4:	4c 89 f7             	mov    %r14,%rdi
    28d7:	e8 74 fb ff ff       	call   2450 <fwp_pool_get>
    28dc:	48 8d 0c 03          	lea    (%rbx,%rax,1),%rcx
    28e0:	48 ff c9             	dec    %rcx
    28e3:	48 f7 db             	neg    %rbx
    28e6:	48 21 cb             	and    %rcx,%rbx
    28e9:	48 39 c3             	cmp    %rax,%rbx
    28ec:	74 16                	je     2904 <valloc+0x64>
    28ee:	8b 48 f0             	mov    -0x10(%rax),%ecx
    28f1:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
    28f5:	48 8d 53 f0          	lea    -0x10(%rbx),%rdx
    28f9:	89 4b f0             	mov    %ecx,-0x10(%rbx)
    28fc:	29 c2                	sub    %eax,%edx
    28fe:	89 53 f4             	mov    %edx,-0xc(%rbx)
    2901:	48 89 d8             	mov    %rbx,%rax
    2904:	48 83 c4 08          	add    $0x8,%rsp
    2908:	5b                   	pop    %rbx
    2909:	41 5e                	pop    %r14
    290b:	c3                   	ret
    290c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002910 <pvalloc>:
    2910:	41 56                	push   %r14
    2912:	53                   	push   %rbx
    2913:	50                   	push   %rax
    2914:	49 89 fe             	mov    %rdi,%r14
    2917:	bf 1e 00 00 00       	mov    $0x1e,%edi
    291c:	e8 1f f9 ff ff       	call   2240 <sysconf@plt>
    2921:	4a 8d 3c 30          	lea    (%rax,%r14,1),%rdi
    2925:	48 ff cf             	dec    %rdi
    2928:	49 89 c6             	mov    %rax,%r14
    292b:	49 f7 de             	neg    %r14
    292e:	4c 21 f7             	and    %r14,%rdi
    2931:	48 83 f8 10          	cmp    $0x10,%rax
    2935:	77 14                	ja     294b <pvalloc+0x3b>
    2937:	48 83 ff 01          	cmp    $0x1,%rdi
    293b:	48 83 d7 00          	adc    $0x0,%rdi
    293f:	48 83 c4 08          	add    $0x8,%rsp
    2943:	5b                   	pop    %rbx
    2944:	41 5e                	pop    %r14
    2946:	e9 05 fb ff ff       	jmp    2450 <fwp_pool_get>
    294b:	48 89 c3             	mov    %rax,%rbx
    294e:	48 01 c7             	add    %rax,%rdi
    2951:	48 ff cb             	dec    %rbx
    2954:	e8 f7 fa ff ff       	call   2450 <fwp_pool_get>
    2959:	48 01 c3             	add    %rax,%rbx
    295c:	4c 21 f3             	and    %r14,%rbx
    295f:	48 39 c3             	cmp    %rax,%rbx
    2962:	74 16                	je     297a <pvalloc+0x6a>
    2964:	8b 48 f0             	mov    -0x10(%rax),%ecx
    2967:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
    296b:	48 8d 53 f0          	lea    -0x10(%rbx),%rdx
    296f:	89 4b f0             	mov    %ecx,-0x10(%rbx)
    2972:	29 c2                	sub    %eax,%edx
    2974:	89 53 f4             	mov    %edx,-0xc(%rbx)
    2977:	48 89 d8             	mov    %rbx,%rax
    297a:	48 83 c4 08          	add    $0x8,%rsp
    297e:	5b                   	pop    %rbx
    297f:	41 5e                	pop    %r14
    2981:	c3                   	ret
    2982:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2989:	1f 84 00 00 00 00 00 

0000000000002990 <malloc_usable_size>:
    2990:	48 85 ff             	test   %rdi,%rdi
    2993:	74 36                	je     29cb <malloc_usable_size+0x3b>
    2995:	8b 4f f4             	mov    -0xc(%rdi),%ecx
    2998:	48 89 f8             	mov    %rdi,%rax
    299b:	48 29 c8             	sub    %rcx,%rax
    299e:	48 f7 d9             	neg    %rcx
    29a1:	8b 54 0f f0          	mov    -0x10(%rdi,%rcx,1),%edx
    29a5:	89 d1                	mov    %edx,%ecx
    29a7:	c1 e9 02             	shr    $0x2,%ecx
    29aa:	be 01 00 00 00       	mov    $0x1,%esi
    29af:	48 d3 e6             	shl    %cl,%rsi
    29b2:	48 83 c0 f0          	add    $0xfffffffffffffff0,%rax
    29b6:	83 e2 03             	and    $0x3,%edx
    29b9:	48 29 f8             	sub    %rdi,%rax
    29bc:	48 01 f0             	add    %rsi,%rax
    29bf:	48 c1 ee 02          	shr    $0x2,%rsi
    29c3:	48 0f af f2          	imul   %rdx,%rsi
    29c7:	48 01 f0             	add    %rsi,%rax
    29ca:	c3                   	ret
    29cb:	31 c0                	xor    %eax,%eax
    29cd:	c3                   	ret
    29ce:	66 90                	xchg   %ax,%ax

00000000000029d0 <main>:
    29d0:	41 56                	push   %r14
    29d2:	53                   	push   %rbx
    29d3:	48 83 ec 58          	sub    $0x58,%rsp
    29d7:	48 8d 05 d2 f9 00 00 	lea    0xf9d2(%rip),%rax        # 123b0 <fwp_fn_table>
    29de:	48 89 05 7b 2d 01 00 	mov    %rax,0x12d7b(%rip)        # 15760 <fwp_fns>
    29e5:	4c 8b 35 d4 05 01 00 	mov    0x105d4(%rip),%r14        # 12fc0 <stdout@GLIBC_2.2.5>
    29ec:	49 8b 06             	mov    (%r14),%rax
    29ef:	48 89 05 72 2d 01 00 	mov    %rax,0x12d72(%rip)        # 15768 <fwp_prog_out>
    29f6:	48 89 35 73 2d 01 00 	mov    %rsi,0x12d73(%rip)        # 15770 <fwp_argv>
    29fd:	48 8d 35 74 2d 01 00 	lea    0x12d74(%rip),%rsi        # 15778 <fwp_start_time>
    2a04:	bf 01 00 00 00       	mov    $0x1,%edi
    2a09:	e8 92 f6 ff ff       	call   20a0 <clock_gettime@plt>
    2a0e:	48 8d 3d 8f cd 00 00 	lea    0xcd8f(%rip),%rdi        # f7a4 <fwp_segv.msg+0x524>
    2a15:	e8 16 f6 ff ff       	call   2030 <getenv@plt>
    2a1a:	48 85 c0             	test   %rax,%rax
    2a1d:	74 28                	je     2a47 <main+0x77>
    2a1f:	48 89 c3             	mov    %rax,%rbx
    2a22:	80 38 00             	cmpb   $0x0,(%rax)
    2a25:	74 20                	je     2a47 <main+0x77>
    2a27:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    2a2c:	48 89 df             	mov    %rbx,%rdi
    2a2f:	ba 0a 00 00 00       	mov    $0xa,%edx
    2a34:	e8 27 f7 ff ff       	call   2160 <strtoull@plt>
    2a39:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    2a3e:	80 38 00             	cmpb   $0x0,(%rax)
    2a41:	0f 84 ca 00 00 00    	je     2b11 <main+0x141>
    2a47:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    2a4c:	31 ff                	xor    %edi,%edi
    2a4e:	e8 4d f6 ff ff       	call   20a0 <clock_gettime@plt>
    2a53:	49 8b 3e             	mov    (%r14),%rdi
    2a56:	b9 00 00 01 00       	mov    $0x10000,%ecx
    2a5b:	31 f6                	xor    %esi,%esi
    2a5d:	31 d2                	xor    %edx,%edx
    2a5f:	e8 9c f7 ff ff       	call   2200 <setvbuf@plt>
    2a64:	be 01 00 00 00       	mov    $0x1,%esi
    2a69:	bf 0d 00 00 00       	mov    $0xd,%edi
    2a6e:	e8 0d f7 ff ff       	call   2180 <signal@plt>
    2a73:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    2a78:	48 89 df             	mov    %rbx,%rdi
    2a7b:	e8 c0 f6 ff ff       	call   2140 <pthread_attr_init@plt>
    2a80:	e8 ab 00 00 00       	call   2b30 <fwp_static_init>
    2a85:	48 c7 05 d0 06 01 00 	movq   $0x1000000,0x106d0(%rip)        # 13160 <fwp_main_stack>
    2a8c:	00 00 00 01 
    2a90:	48 8b 35 79 29 01 00 	mov    0x12979(%rip),%rsi        # 15410 <fwp_static+0x870>
    2a97:	ba 00 00 00 01       	mov    $0x1000000,%edx
    2a9c:	48 89 df             	mov    %rbx,%rdi
    2a9f:	e8 4c f7 ff ff       	call   21f0 <pthread_attr_setstack@plt>
    2aa4:	48 8d 15 b5 02 00 00 	lea    0x2b5(%rip),%rdx        # 2d60 <fwp_main_thread>
    2aab:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    2ab0:	48 89 de             	mov    %rbx,%rsi
    2ab3:	31 c9                	xor    %ecx,%ecx
    2ab5:	e8 56 f7 ff ff       	call   2210 <pthread_create@plt>
    2aba:	85 c0                	test   %eax,%eax
    2abc:	74 35                	je     2af3 <main+0x123>
    2abe:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    2ac3:	bf 03 00 00 00       	mov    $0x3,%edi
    2ac8:	e8 c3 f7 ff ff       	call   2290 <getrlimit@plt>
    2acd:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    2ad2:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    2ad6:	ba 00 00 80 00       	mov    $0x800000,%edx
    2adb:	48 0f 44 ca          	cmove  %rdx,%rcx
    2adf:	85 c0                	test   %eax,%eax
    2ae1:	48 0f 45 ca          	cmovne %rdx,%rcx
    2ae5:	48 89 0d 74 06 01 00 	mov    %rcx,0x10674(%rip)        # 13160 <fwp_main_stack>
    2aec:	e8 6f 02 00 00       	call   2d60 <fwp_main_thread>
    2af1:	eb 0c                	jmp    2aff <main+0x12f>
    2af3:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2af8:	31 f6                	xor    %esi,%esi
    2afa:	e8 a1 f7 ff ff       	call   22a0 <pthread_join@plt>
    2aff:	49 8b 3e             	mov    (%r14),%rdi
    2b02:	e8 d9 f6 ff ff       	call   21e0 <fflush@plt>
    2b07:	31 c0                	xor    %eax,%eax
    2b09:	48 83 c4 58          	add    $0x58,%rsp
    2b0d:	5b                   	pop    %rbx
    2b0e:	41 5e                	pop    %r14
    2b10:	c3                   	ret
    2b11:	0f b6 03             	movzbl (%rbx),%eax
    2b14:	83 f8 2d             	cmp    $0x2d,%eax
    2b17:	0f 84 2a ff ff ff    	je     2a47 <main+0x77>
    2b1d:	83 f8 2b             	cmp    $0x2b,%eax
    2b20:	0f 84 21 ff ff ff    	je     2a47 <main+0x77>
    2b26:	e9 28 ff ff ff       	jmp    2a53 <main+0x83>
    2b2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002b30 <fwp_static_init>:
    2b30:	41 57                	push   %r15
    2b32:	41 56                	push   %r14
    2b34:	41 55                	push   %r13
    2b36:	41 54                	push   %r12
    2b38:	53                   	push   %rbx
    2b39:	83 3d 60 20 01 00 00 	cmpl   $0x0,0x12060(%rip)        # 14ba0 <fwp_static>
    2b40:	0f 85 ee 01 00 00    	jne    2d34 <fwp_static_init+0x204>
    2b46:	c7 05 50 20 01 00 01 	movl   $0x1,0x12050(%rip)        # 14ba0 <fwp_static>
    2b4d:	00 00 00 
    2b50:	bf 1e 00 00 00       	mov    $0x1e,%edi
    2b55:	e8 e6 f6 ff ff       	call   2240 <sysconf@plt>
    2b5a:	48 89 c3             	mov    %rax,%rbx
    2b5d:	4c 8d b0 ff 9f d8 0b 	lea    0xbd89fff(%rax),%r14
    2b64:	49 89 c7             	mov    %rax,%r15
    2b67:	49 f7 df             	neg    %r15
    2b6a:	4d 21 fe             	and    %r15,%r14
    2b6d:	31 ff                	xor    %edi,%edi
    2b6f:	4c 89 f6             	mov    %r14,%rsi
    2b72:	ba 03 00 00 00       	mov    $0x3,%edx
    2b77:	b9 22 80 00 00       	mov    $0x8022,%ecx
    2b7c:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    2b82:	45 31 c9             	xor    %r9d,%r9d
    2b85:	e8 56 f5 ff ff       	call   20e0 <mmap@plt>
    2b8a:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    2b8e:	0f 84 aa 01 00 00    	je     2d3e <fwp_static_init+0x20e>
    2b94:	48 89 05 0d 20 01 00 	mov    %rax,0x1200d(%rip)        # 14ba8 <fwp_static+0x8>
    2b9b:	49 01 c6             	add    %rax,%r14
    2b9e:	4c 89 35 13 20 01 00 	mov    %r14,0x12013(%rip)        # 14bb8 <fwp_static+0x18>
    2ba5:	48 83 c0 0f          	add    $0xf,%rax
    2ba9:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
    2bad:	48 8d 88 00 00 00 02 	lea    0x2000000(%rax),%rcx
    2bb4:	48 89 05 0d 20 01 00 	mov    %rax,0x1200d(%rip)        # 14bc8 <fwp_static+0x28>
    2bbb:	48 89 05 fe 1f 01 00 	mov    %rax,0x11ffe(%rip)        # 14bc0 <fwp_static+0x20>
    2bc2:	48 89 0d 07 20 01 00 	mov    %rcx,0x12007(%rip)        # 14bd0 <fwp_static+0x30>
    2bc9:	4c 8d 73 ff          	lea    -0x1(%rbx),%r14
    2bcd:	48 01 d8             	add    %rbx,%rax
    2bd0:	48 05 ff ff ff 01    	add    $0x1ffffff,%rax
    2bd6:	4c 21 f8             	and    %r15,%rax
    2bd9:	48 89 05 18 28 01 00 	mov    %rax,0x12818(%rip)        # 153f8 <fwp_static+0x858>
    2be0:	48 c7 05 1d 28 01 00 	movq   $0x48a000,0x1281d(%rip)        # 15408 <fwp_static+0x868>
    2be7:	00 a0 48 00 
    2beb:	48 05 ff 9f 49 00    	add    $0x499fff,%rax
    2bf1:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    2bf7:	48 89 05 f2 27 01 00 	mov    %rax,0x127f2(%rip)        # 153f0 <fwp_static+0x850>
    2bfe:	48 c7 05 f7 27 01 00 	movq   $0x4000000,0x127f7(%rip)        # 15400 <fwp_static+0x860>
    2c05:	00 00 00 04 
    2c09:	48 01 d8             	add    %rbx,%rax
    2c0c:	48 05 ff ff ff 03    	add    $0x3ffffff,%rax
    2c12:	4c 21 f8             	and    %r15,%rax
    2c15:	48 8d 88 00 00 00 01 	lea    0x1000000(%rax),%rcx
    2c1c:	48 89 0d 8d 1f 01 00 	mov    %rcx,0x11f8d(%rip)        # 14bb0 <fwp_static+0x10>
    2c23:	48 89 05 e6 27 01 00 	mov    %rax,0x127e6(%rip)        # 15410 <fwp_static+0x870>
    2c2a:	45 31 e4             	xor    %r12d,%r12d
    2c2d:	4c 8d 2d 6c 1f 01 00 	lea    0x11f6c(%rip),%r13        # 14ba0 <fwp_static>
    2c34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2c3b:	00 00 00 00 00 
    2c40:	48 8b 3d 69 1f 01 00 	mov    0x11f69(%rip),%rdi        # 14bb0 <fwp_static+0x10>
    2c47:	4c 01 f7             	add    %r14,%rdi
    2c4a:	4c 21 ff             	and    %r15,%rdi
    2c4d:	48 8d 87 00 00 10 00 	lea    0x100000(%rdi),%rax
    2c54:	48 89 05 55 1f 01 00 	mov    %rax,0x11f55(%rip)        # 14bb0 <fwp_static+0x10>
    2c5b:	4b 89 bc e5 78 08 00 	mov    %rdi,0x878(%r13,%r12,8)
    2c62:	00 
    2c63:	48 89 de             	mov    %rbx,%rsi
    2c66:	31 d2                	xor    %edx,%edx
    2c68:	e8 b3 f5 ff ff       	call   2220 <mprotect@plt>
    2c6d:	44 89 e0             	mov    %r12d,%eax
    2c70:	83 f0 3f             	xor    $0x3f,%eax
    2c73:	43 89 84 a5 78 0a 00 	mov    %eax,0xa78(%r13,%r12,4)
    2c7a:	00 
    2c7b:	49 ff c4             	inc    %r12
    2c7e:	49 83 fc 40          	cmp    $0x40,%r12
    2c82:	75 bc                	jne    2c40 <fwp_static_init+0x110>
    2c84:	c7 05 8a 2a 01 00 40 	movl   $0x40,0x12a8a(%rip)        # 15718 <fwp_static+0xb78>
    2c8b:	00 00 00 
    2c8e:	48 8b 05 1b 1f 01 00 	mov    0x11f1b(%rip),%rax        # 14bb0 <fwp_static+0x10>
    2c95:	4c 01 f0             	add    %r14,%rax
    2c98:	4c 21 f8             	and    %r15,%rax
    2c9b:	48 89 05 7e 2a 01 00 	mov    %rax,0x12a7e(%rip)        # 15720 <fwp_static+0xb80>
    2ca2:	4c 01 f0             	add    %r14,%rax
    2ca5:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cab:	4c 21 f8             	and    %r15,%rax
    2cae:	48 89 05 73 2a 01 00 	mov    %rax,0x12a73(%rip)        # 15728 <fwp_static+0xb88>
    2cb5:	4c 01 f0             	add    %r14,%rax
    2cb8:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cbe:	4c 21 f8             	and    %r15,%rax
    2cc1:	48 89 05 68 2a 01 00 	mov    %rax,0x12a68(%rip)        # 15730 <fwp_static+0xb90>
    2cc8:	4c 01 f0             	add    %r14,%rax
    2ccb:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cd1:	4c 21 f8             	and    %r15,%rax
    2cd4:	48 89 05 5d 2a 01 00 	mov    %rax,0x12a5d(%rip)        # 15738 <fwp_static+0xb98>
    2cdb:	4c 01 f0             	add    %r14,%rax
    2cde:	48 05 00 00 10 00    	add    $0x100000,%rax
    2ce4:	4c 21 f8             	and    %r15,%rax
    2ce7:	48 89 05 52 2a 01 00 	mov    %rax,0x12a52(%rip)        # 15740 <fwp_static+0xba0>
    2cee:	4c 01 f0             	add    %r14,%rax
    2cf1:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cf7:	4c 21 f8             	and    %r15,%rax
    2cfa:	48 89 05 47 2a 01 00 	mov    %rax,0x12a47(%rip)        # 15748 <fwp_static+0xba8>
    2d01:	4c 01 f0             	add    %r14,%rax
    2d04:	48 05 00 00 10 00    	add    $0x100000,%rax
    2d0a:	4c 21 f8             	and    %r15,%rax
    2d0d:	48 89 05 3c 2a 01 00 	mov    %rax,0x12a3c(%rip)        # 15750 <fwp_static+0xbb0>
    2d14:	4c 01 f0             	add    %r14,%rax
    2d17:	48 05 00 00 10 00    	add    $0x100000,%rax
    2d1d:	4c 21 f8             	and    %r15,%rax
    2d20:	48 89 05 31 2a 01 00 	mov    %rax,0x12a31(%rip)        # 15758 <fwp_static+0xbb8>
    2d27:	48 05 00 00 10 00    	add    $0x100000,%rax
    2d2d:	48 89 05 7c 1e 01 00 	mov    %rax,0x11e7c(%rip)        # 14bb0 <fwp_static+0x10>
    2d34:	5b                   	pop    %rbx
    2d35:	41 5c                	pop    %r12
    2d37:	41 5d                	pop    %r13
    2d39:	41 5e                	pop    %r14
    2d3b:	41 5f                	pop    %r15
    2d3d:	c3                   	ret
    2d3e:	48 8d 35 fb c4 00 00 	lea    0xc4fb(%rip),%rsi        # f240 <fwp_static_init.msg>
    2d45:	ba 3b 00 00 00       	mov    $0x3b,%edx
    2d4a:	bf 02 00 00 00       	mov    $0x2,%edi
    2d4f:	e8 5c f3 ff ff       	call   20b0 <write@plt>
    2d54:	bf 66 00 00 00       	mov    $0x66,%edi
    2d59:	e8 02 f3 ff ff       	call   2060 <_exit@plt>
    2d5e:	66 90                	xchg   %ax,%ax

0000000000002d60 <fwp_main_thread>:
    2d60:	55                   	push   %rbp
    2d61:	48 89 e5             	mov    %rsp,%rbp
    2d64:	41 57                	push   %r15
    2d66:	41 56                	push   %r14
    2d68:	41 55                	push   %r13
    2d6a:	41 54                	push   %r12
    2d6c:	53                   	push   %rbx
    2d6d:	48 81 ec c8 01 00 00 	sub    $0x1c8,%rsp
    2d74:	83 3d d9 13 01 00 00 	cmpl   $0x0,0x113d9(%rip)        # 14154 <fwp_gc+0xfec>
    2d7b:	75 05                	jne    2d82 <fwp_main_thread+0x22>
    2d7d:	e8 4e 43 00 00       	call   70d0 <fwp_gc_init>
    2d82:	48 89 2d 67 14 01 00 	mov    %rbp,0x11467(%rip)        # 141f0 <fwp_gc+0x1088>
    2d89:	48 8d 3d 40 b7 00 00 	lea    0xb740(%rip),%rdi        # e4d0 <fwp_gc_find_data>
    2d90:	31 f6                	xor    %esi,%esi
    2d92:	e8 a9 f2 ff ff       	call   2040 <dl_iterate_phdr@plt>
    2d97:	83 3d ba 13 01 00 00 	cmpl   $0x0,0x113ba(%rip)        # 14158 <fwp_gc+0xff0>
    2d9e:	0f 95 c0             	setne  %al
    2da1:	83 3d 50 15 01 00 00 	cmpl   $0x0,0x11550(%rip)        # 142f8 <fwp_gc+0x1190>
    2da8:	0f 9f c1             	setg   %cl
    2dab:	20 c1                	and    %al,%cl
    2dad:	0f b6 c1             	movzbl %cl,%eax
    2db0:	89 05 a6 13 01 00    	mov    %eax,0x113a6(%rip)        # 1415c <fwp_gc+0xff4>
    2db6:	83 3d a7 13 01 00 00 	cmpl   $0x0,0x113a7(%rip)        # 14164 <fwp_gc+0xffc>
    2dbd:	74 0c                	je     2dcb <fwp_main_thread+0x6b>
    2dbf:	48 8d 3d ea b7 00 00 	lea    0xb7ea(%rip),%rdi        # e5b0 <fwp_gc_report>
    2dc6:	e8 75 be 00 00       	call   ec40 <atexit>
    2dcb:	48 8d 3d f7 c9 00 00 	lea    0xc9f7(%rip),%rdi        # f7c9 <fwp_segv.msg+0x549>
    2dd2:	e8 59 f2 ff ff       	call   2030 <getenv@plt>
    2dd7:	48 85 c0             	test   %rax,%rax
    2dda:	74 24                	je     2e00 <fwp_main_thread+0xa0>
    2ddc:	80 38 00             	cmpb   $0x0,(%rax)
    2ddf:	74 1f                	je     2e00 <fwp_main_thread+0xa0>
    2de1:	48 8d 35 21 c9 00 00 	lea    0xc921(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    2de8:	48 89 c7             	mov    %rax,%rdi
    2deb:	e8 80 f3 ff ff       	call   2170 <strcmp@plt>
    2df0:	85 c0                	test   %eax,%eax
    2df2:	74 0c                	je     2e00 <fwp_main_thread+0xa0>
    2df4:	48 8d 3d 05 ba 00 00 	lea    0xba05(%rip),%rdi        # e800 <fwp_static_report>
    2dfb:	e8 40 be 00 00       	call   ec40 <atexit>
    2e00:	83 3d 55 13 01 00 00 	cmpl   $0x0,0x11355(%rip)        # 1415c <fwp_gc+0xff4>
    2e07:	74 43                	je     2e4c <fwp_main_thread+0xec>
    2e09:	48 83 3d 77 13 01 00 	cmpq   $0x0,0x11377(%rip)        # 14188 <fwp_gc+0x1020>
    2e10:	00 
    2e11:	74 39                	je     2e4c <fwp_main_thread+0xec>
    2e13:	48 8b 05 5e 15 01 00 	mov    0x1155e(%rip),%rax        # 14378 <fwp_gc+0x1210>
    2e1a:	48 2b 05 47 03 01 00 	sub    0x10347(%rip),%rax        # 13168 <fwp_gc>
    2e21:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2e26:	f2 0f 58 05 22 15 01 	addsd  0x11522(%rip),%xmm0        # 14350 <fwp_gc+0x11e8>
    2e2d:	00 
    2e2e:	f2 0f 11 05 1a 15 01 	movsd  %xmm0,0x1151a(%rip)        # 14350 <fwp_gc+0x11e8>
    2e35:	00 
    2e36:	48 c7 05 37 15 01 00 	movq   $0x0,0x11537(%rip)        # 14378 <fwp_gc+0x1210>
    2e3d:	00 00 00 00 
    2e41:	48 c7 05 1c 03 01 00 	movq   $0x0,0x1031c(%rip)        # 13168 <fwp_gc>
    2e48:	00 00 00 00 
    2e4c:	48 8b 05 0d 03 01 00 	mov    0x1030d(%rip),%rax        # 13160 <fwp_main_stack>
    2e53:	48 8d 4d a0          	lea    -0x60(%rbp),%rcx
    2e57:	48 89 0d 42 29 01 00 	mov    %rcx,0x12942(%rip)        # 157a0 <fwp_main_stack_top>
    2e5e:	48 89 05 43 29 01 00 	mov    %rax,0x12943(%rip)        # 157a8 <fwp_main_stack_size>
    2e65:	48 8d 05 44 29 01 00 	lea    0x12944(%rip),%rax        # 157b0 <fwp_stack_guard_init.alt>
    2e6c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    2e70:	48 c7 45 c8 00 00 01 	movq   $0x10000,-0x38(%rbp)
    2e77:	00 
    2e78:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%rbp)
    2e7f:	48 8d 7d b8          	lea    -0x48(%rbp),%rdi
    2e83:	31 f6                	xor    %esi,%esi
    2e85:	e8 26 f4 ff ff       	call   22b0 <sigaltstack@plt>
    2e8a:	85 c0                	test   %eax,%eax
    2e8c:	0f 85 95 00 00 00    	jne    2f27 <fwp_main_thread+0x1c7>
    2e92:	48 8d bd 18 fe ff ff 	lea    -0x1e8(%rbp),%rdi
    2e99:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    2e9d:	66 0f 11 85 98 fe ff 	movupd %xmm0,-0x168(%rbp)
    2ea4:	ff 
    2ea5:	66 0f 11 85 88 fe ff 	movupd %xmm0,-0x178(%rbp)
    2eac:	ff 
    2ead:	66 0f 11 85 78 fe ff 	movupd %xmm0,-0x188(%rbp)
    2eb4:	ff 
    2eb5:	66 0f 11 85 68 fe ff 	movupd %xmm0,-0x198(%rbp)
    2ebc:	ff 
    2ebd:	66 0f 11 85 58 fe ff 	movupd %xmm0,-0x1a8(%rbp)
    2ec4:	ff 
    2ec5:	66 0f 11 85 48 fe ff 	movupd %xmm0,-0x1b8(%rbp)
    2ecc:	ff 
    2ecd:	66 0f 11 85 38 fe ff 	movupd %xmm0,-0x1c8(%rbp)
    2ed4:	ff 
    2ed5:	66 0f 11 85 28 fe ff 	movupd %xmm0,-0x1d8(%rbp)
    2edc:	ff 
    2edd:	66 0f 11 85 18 fe ff 	movupd %xmm0,-0x1e8(%rbp)
    2ee4:	ff 
    2ee5:	48 8d 05 a4 b9 00 00 	lea    0xb9a4(%rip),%rax        # e890 <fwp_segv>
    2eec:	48 89 85 10 fe ff ff 	mov    %rax,-0x1f0(%rbp)
    2ef3:	c7 85 98 fe ff ff 04 	movl   $0x8000004,-0x168(%rbp)
    2efa:	00 00 08 
    2efd:	e8 ae f2 ff ff       	call   21b0 <sigemptyset@plt>
    2f02:	48 8d 9d 10 fe ff ff 	lea    -0x1f0(%rbp),%rbx
    2f09:	bf 0b 00 00 00       	mov    $0xb,%edi
    2f0e:	48 89 de             	mov    %rbx,%rsi
    2f11:	31 d2                	xor    %edx,%edx
    2f13:	e8 68 f1 ff ff       	call   2080 <sigaction@plt>
    2f18:	bf 07 00 00 00       	mov    $0x7,%edi
    2f1d:	48 89 de             	mov    %rbx,%rsi
    2f20:	31 d2                	xor    %edx,%edx
    2f22:	e8 59 f1 ff ff       	call   2080 <sigaction@plt>
    2f27:	48 8b 15 3a 02 01 00 	mov    0x1023a(%rip),%rdx        # 13168 <fwp_gc>
    2f2e:	80 3d 7b 28 02 00 00 	cmpb   $0x0,0x2287b(%rip)        # 257b0 <caf0.st>
    2f35:	48 89 d0             	mov    %rdx,%rax
    2f38:	0f 85 a8 18 00 00    	jne    47e6 <fwp_main_thread+0x1a86>
    2f3e:	48 89 55 b0          	mov    %rdx,-0x50(%rbp)
    2f42:	48 b8 00 00 00 00 00 	movabs $0xc000000000000000,%rax
    2f49:	00 00 c0 
    2f4c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    2f50:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    2f57:	00 
    2f58:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    2f5c:	bf 01 00 00 00       	mov    $0x1,%edi
    2f61:	be 02 00 00 00       	mov    $0x2,%esi
    2f66:	e8 25 75 00 00       	call   a490 <fwp_data>
    2f6b:	48 89 c1             	mov    %rax,%rcx
    2f6e:	48 2b 0d 23 12 01 00 	sub    0x11223(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    2f75:	48 8b 15 44 12 01 00 	mov    0x11244(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    2f7c:	48 c1 e2 10          	shl    $0x10,%rdx
    2f80:	48 39 d1             	cmp    %rdx,%rcx
    2f83:	73 76                	jae    2ffb <fwp_main_thread+0x29b>
    2f85:	48 8b 15 54 12 01 00 	mov    0x11254(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    2f8c:	48 89 ce             	mov    %rcx,%rsi
    2f8f:	48 c1 ee 10          	shr    $0x10,%rsi
    2f93:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2f9a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2f9e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2fa5:	75 1d                	jne    2fc4 <fwp_main_thread+0x264>
    2fa7:	40 80 ff 02          	cmp    $0x2,%dil
    2fab:	75 17                	jne    2fc4 <fwp_main_thread+0x264>
    2fad:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2fb1:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2fb8:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2fbc:	74 2d                	je     2feb <fwp_main_thread+0x28b>
    2fbe:	41 c6 06 01          	movb   $0x1,(%r14)
    2fc2:	eb 37                	jmp    2ffb <fwp_main_thread+0x29b>
    2fc4:	40 80 ff 01          	cmp    $0x1,%dil
    2fc8:	75 31                	jne    2ffb <fwp_main_thread+0x29b>
    2fca:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2fce:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2fd2:	48 0f af ca          	imul   %rdx,%rcx
    2fd6:	48 c1 e9 20          	shr    $0x20,%rcx
    2fda:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2fde:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2fe5:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2fe9:	75 d3                	jne    2fbe <fwp_main_thread+0x25e>
    2feb:	4c 89 f7             	mov    %r14,%rdi
    2fee:	48 89 c3             	mov    %rax,%rbx
    2ff1:	e8 da 3a 00 00       	call   6ad0 <fwp_rc_forget_slot>
    2ff6:	48 89 d8             	mov    %rbx,%rax
    2ff9:	eb c3                	jmp    2fbe <fwp_main_thread+0x25e>
    2ffb:	48 b9 00 00 00 00 00 	movabs $0x3fd0000000000000,%rcx
    3002:	00 d0 3f 
    3005:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    3009:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    300d:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
    3011:	bf 01 00 00 00       	mov    $0x1,%edi
    3016:	be 02 00 00 00       	mov    $0x2,%esi
    301b:	e8 70 74 00 00       	call   a490 <fwp_data>
    3020:	48 89 c1             	mov    %rax,%rcx
    3023:	48 2b 0d 6e 11 01 00 	sub    0x1116e(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    302a:	48 8b 15 8f 11 01 00 	mov    0x1118f(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3031:	48 c1 e2 10          	shl    $0x10,%rdx
    3035:	48 39 d1             	cmp    %rdx,%rcx
    3038:	73 76                	jae    30b0 <fwp_main_thread+0x350>
    303a:	48 8b 15 9f 11 01 00 	mov    0x1119f(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3041:	48 89 ce             	mov    %rcx,%rsi
    3044:	48 c1 ee 10          	shr    $0x10,%rsi
    3048:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    304f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3053:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    305a:	75 1d                	jne    3079 <fwp_main_thread+0x319>
    305c:	40 80 ff 02          	cmp    $0x2,%dil
    3060:	75 17                	jne    3079 <fwp_main_thread+0x319>
    3062:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3066:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    306d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3071:	74 2d                	je     30a0 <fwp_main_thread+0x340>
    3073:	41 c6 06 01          	movb   $0x1,(%r14)
    3077:	eb 37                	jmp    30b0 <fwp_main_thread+0x350>
    3079:	40 80 ff 01          	cmp    $0x1,%dil
    307d:	75 31                	jne    30b0 <fwp_main_thread+0x350>
    307f:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3083:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3087:	48 0f af ca          	imul   %rdx,%rcx
    308b:	48 c1 e9 20          	shr    $0x20,%rcx
    308f:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3093:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    309a:	41 80 3e ff          	cmpb   $0xff,(%r14)
    309e:	75 d3                	jne    3073 <fwp_main_thread+0x313>
    30a0:	4c 89 f7             	mov    %r14,%rdi
    30a3:	48 89 c3             	mov    %rax,%rbx
    30a6:	e8 25 3a 00 00       	call   6ad0 <fwp_rc_forget_slot>
    30ab:	48 89 d8             	mov    %rbx,%rax
    30ae:	eb c3                	jmp    3073 <fwp_main_thread+0x313>
    30b0:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    30b7:	ff ff 7f 
    30ba:	4c 8d 69 01          	lea    0x1(%rcx),%r13
    30be:	4c 89 ad b0 fe ff ff 	mov    %r13,-0x150(%rbp)
    30c5:	48 89 85 b8 fe ff ff 	mov    %rax,-0x148(%rbp)
    30cc:	48 8d 95 b0 fe ff ff 	lea    -0x150(%rbp),%rdx
    30d3:	bf 01 00 00 00       	mov    $0x1,%edi
    30d8:	be 02 00 00 00       	mov    $0x2,%esi
    30dd:	e8 ae 73 00 00       	call   a490 <fwp_data>
    30e2:	48 89 c1             	mov    %rax,%rcx
    30e5:	48 2b 0d ac 10 01 00 	sub    0x110ac(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    30ec:	48 8b 15 cd 10 01 00 	mov    0x110cd(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    30f3:	48 c1 e2 10          	shl    $0x10,%rdx
    30f7:	48 39 d1             	cmp    %rdx,%rcx
    30fa:	73 76                	jae    3172 <fwp_main_thread+0x412>
    30fc:	48 8b 15 dd 10 01 00 	mov    0x110dd(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3103:	48 89 ce             	mov    %rcx,%rsi
    3106:	48 c1 ee 10          	shr    $0x10,%rsi
    310a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3111:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3115:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    311c:	75 1d                	jne    313b <fwp_main_thread+0x3db>
    311e:	40 80 ff 02          	cmp    $0x2,%dil
    3122:	75 17                	jne    313b <fwp_main_thread+0x3db>
    3124:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3128:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    312f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3133:	74 2d                	je     3162 <fwp_main_thread+0x402>
    3135:	41 c6 06 01          	movb   $0x1,(%r14)
    3139:	eb 37                	jmp    3172 <fwp_main_thread+0x412>
    313b:	40 80 ff 01          	cmp    $0x1,%dil
    313f:	75 31                	jne    3172 <fwp_main_thread+0x412>
    3141:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3145:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3149:	48 0f af ca          	imul   %rdx,%rcx
    314d:	48 c1 e9 20          	shr    $0x20,%rcx
    3151:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3155:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    315c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3160:	75 d3                	jne    3135 <fwp_main_thread+0x3d5>
    3162:	4c 89 f7             	mov    %r14,%rdi
    3165:	48 89 c3             	mov    %rax,%rbx
    3168:	e8 63 39 00 00       	call   6ad0 <fwp_rc_forget_slot>
    316d:	48 89 d8             	mov    %rbx,%rax
    3170:	eb c3                	jmp    3135 <fwp_main_thread+0x3d5>
    3172:	48 b9 00 00 00 00 00 	movabs $0x3ff8000000000000,%rcx
    3179:	00 f8 3f 
    317c:	48 89 8d c0 fe ff ff 	mov    %rcx,-0x140(%rbp)
    3183:	48 89 85 c8 fe ff ff 	mov    %rax,-0x138(%rbp)
    318a:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
    3191:	bf 01 00 00 00       	mov    $0x1,%edi
    3196:	be 02 00 00 00       	mov    $0x2,%esi
    319b:	e8 f0 72 00 00       	call   a490 <fwp_data>
    31a0:	49 89 c6             	mov    %rax,%r14
    31a3:	48 2b 05 ee 0f 01 00 	sub    0x10fee(%rip),%rax        # 14198 <fwp_gc+0x1030>
    31aa:	48 8b 0d 0f 10 01 00 	mov    0x1100f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    31b1:	48 c1 e1 10          	shl    $0x10,%rcx
    31b5:	48 39 c8             	cmp    %rcx,%rax
    31b8:	73 6f                	jae    3229 <fwp_main_thread+0x4c9>
    31ba:	48 8b 0d 1f 10 01 00 	mov    0x1101f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    31c1:	48 89 c2             	mov    %rax,%rdx
    31c4:	48 c1 ea 10          	shr    $0x10,%rdx
    31c8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    31cf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    31d3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    31d9:	75 1d                	jne    31f8 <fwp_main_thread+0x498>
    31db:	40 80 fe 02          	cmp    $0x2,%sil
    31df:	75 17                	jne    31f8 <fwp_main_thread+0x498>
    31e1:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    31e5:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    31ec:	41 80 3f ff          	cmpb   $0xff,(%r15)
    31f0:	74 2d                	je     321f <fwp_main_thread+0x4bf>
    31f2:	41 c6 07 01          	movb   $0x1,(%r15)
    31f6:	eb 31                	jmp    3229 <fwp_main_thread+0x4c9>
    31f8:	40 80 fe 01          	cmp    $0x1,%sil
    31fc:	75 2b                	jne    3229 <fwp_main_thread+0x4c9>
    31fe:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3202:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3206:	48 0f af c1          	imul   %rcx,%rax
    320a:	48 c1 e8 20          	shr    $0x20,%rax
    320e:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    3212:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3219:	41 80 3f ff          	cmpb   $0xff,(%r15)
    321d:	75 d3                	jne    31f2 <fwp_main_thread+0x492>
    321f:	4c 89 ff             	mov    %r15,%rdi
    3222:	e8 a9 38 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3227:	eb c9                	jmp    31f2 <fwp_main_thread+0x492>
    3229:	48 8d 35 20 fa 00 00 	lea    0xfa20(%rip),%rsi        # 12c50 <d0>
    3230:	4c 89 f7             	mov    %r14,%rdi
    3233:	e8 98 39 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    3238:	49 89 c7             	mov    %rax,%r15
    323b:	4c 89 f7             	mov    %r14,%rdi
    323e:	e8 ad b6 00 00       	call   e8f0 <fwp_drop0>
    3243:	31 db                	xor    %ebx,%ebx
    3245:	be 04 00 00 00       	mov    $0x4,%esi
    324a:	31 ff                	xor    %edi,%edi
    324c:	4c 89 fa             	mov    %r15,%rdx
    324f:	e8 cc 46 00 00       	call   7920 <f12>
    3254:	49 89 c6             	mov    %rax,%r14
    3257:	4c 89 ff             	mov    %r15,%rdi
    325a:	e8 a1 78 00 00       	call   ab00 <fwp_drop1>
    325f:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    3263:	f2 0f 11 45 d0       	movsd  %xmm0,-0x30(%rbp)
    3268:	45 31 ff             	xor    %r15d,%r15d
    326b:	45 31 e4             	xor    %r12d,%r12d
    326e:	31 ff                	xor    %edi,%edi
    3270:	48 85 db             	test   %rbx,%rbx
    3273:	78 3b                	js     32b0 <fwp_main_thread+0x550>
    3275:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    327c:	00 00 00 00 
    3280:	49 8b 06             	mov    (%r14),%rax
    3283:	48 89 c1             	mov    %rax,%rcx
    3286:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    328d:	ff ff 7f 
    3290:	48 21 d1             	and    %rdx,%rcx
    3293:	48 39 cb             	cmp    %rcx,%rbx
    3296:	73 18                	jae    32b0 <fwp_main_thread+0x550>
    3298:	48 85 c0             	test   %rax,%rax
    329b:	78 22                	js     32bf <fwp_main_thread+0x55f>
    329d:	49 8d 46 08          	lea    0x8(%r14),%rax
    32a1:	eb 20                	jmp    32c3 <fwp_main_thread+0x563>
    32a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    32aa:	84 00 00 00 00 00 
    32b0:	4c 89 f7             	mov    %r14,%rdi
    32b3:	e8 48 78 00 00       	call   ab00 <fwp_drop1>
    32b8:	31 c0                	xor    %eax,%eax
    32ba:	4c 89 ef             	mov    %r13,%rdi
    32bd:	eb 32                	jmp    32f1 <fwp_main_thread+0x591>
    32bf:	49 8b 46 10          	mov    0x10(%r14),%rax
    32c3:	f2 0f 10 04 d8       	movsd  (%rax,%rbx,8),%xmm0
    32c8:	48 ff c3             	inc    %rbx
    32cb:	f2 0f 59 05 3d bd 00 	mulsd  0xbd3d(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    32d2:	00 
    32d3:	f2 0f 58 05 3d bd 00 	addsd  0xbd3d(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    32da:	00 
    32db:	66 49 0f 6e cd       	movq   %r13,%xmm1
    32e0:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    32e4:	f2 0f 11 4d d0       	movsd  %xmm1,-0x30(%rbp)
    32e9:	b0 01                	mov    $0x1,%al
    32eb:	4d 89 f7             	mov    %r14,%r15
    32ee:	4d 89 f4             	mov    %r14,%r12
    32f1:	84 c0                	test   %al,%al
    32f3:	74 18                	je     330d <fwp_main_thread+0x5ad>
    32f5:	f3 0f 7e 45 d0       	movq   -0x30(%rbp),%xmm0
    32fa:	66 49 0f 7e c5       	movq   %xmm0,%r13
    32ff:	4d 89 fe             	mov    %r15,%r14
    3302:	48 85 db             	test   %rbx,%rbx
    3305:	0f 89 75 ff ff ff    	jns    3280 <fwp_main_thread+0x520>
    330b:	eb a3                	jmp    32b0 <fwp_main_thread+0x550>
    330d:	48 8d 35 3c f9 00 00 	lea    0xf93c(%rip),%rsi        # 12c50 <d0>
    3314:	e8 77 4a 00 00       	call   7d90 <fwp_show>
    3319:	49 89 c6             	mov    %rax,%r14
    331c:	48 2b 05 75 0e 01 00 	sub    0x10e75(%rip),%rax        # 14198 <fwp_gc+0x1030>
    3323:	48 8b 0d 96 0e 01 00 	mov    0x10e96(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    332a:	48 c1 e1 10          	shl    $0x10,%rcx
    332e:	48 39 c8             	cmp    %rcx,%rax
    3331:	73 6f                	jae    33a2 <fwp_main_thread+0x642>
    3333:	48 8b 0d a6 0e 01 00 	mov    0x10ea6(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    333a:	48 89 c2             	mov    %rax,%rdx
    333d:	48 c1 ea 10          	shr    $0x10,%rdx
    3341:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3348:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    334c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3352:	75 1d                	jne    3371 <fwp_main_thread+0x611>
    3354:	40 80 fe 02          	cmp    $0x2,%sil
    3358:	75 17                	jne    3371 <fwp_main_thread+0x611>
    335a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    335e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3365:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3369:	74 2d                	je     3398 <fwp_main_thread+0x638>
    336b:	41 c6 07 01          	movb   $0x1,(%r15)
    336f:	eb 31                	jmp    33a2 <fwp_main_thread+0x642>
    3371:	40 80 fe 01          	cmp    $0x1,%sil
    3375:	75 2b                	jne    33a2 <fwp_main_thread+0x642>
    3377:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    337b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    337f:	48 0f af c1          	imul   %rcx,%rax
    3383:	48 c1 e8 20          	shr    $0x20,%rax
    3387:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    338b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3392:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3396:	75 d3                	jne    336b <fwp_main_thread+0x60b>
    3398:	4c 89 ff             	mov    %r15,%rdi
    339b:	e8 30 37 00 00       	call   6ad0 <fwp_rc_forget_slot>
    33a0:	eb c9                	jmp    336b <fwp_main_thread+0x60b>
    33a2:	4c 89 f7             	mov    %r14,%rdi
    33a5:	48 83 c7 08          	add    $0x8,%rdi
    33a9:	49 8b 16             	mov    (%r14),%rdx
    33ac:	48 8b 0d b5 23 01 00 	mov    0x123b5(%rip),%rcx        # 15768 <fwp_prog_out>
    33b3:	be 01 00 00 00       	mov    $0x1,%esi
    33b8:	e8 c3 ee ff ff       	call   2280 <fwrite@plt>
    33bd:	48 8b 35 a4 23 01 00 	mov    0x123a4(%rip),%rsi        # 15768 <fwp_prog_out>
    33c4:	bf 0a 00 00 00       	mov    $0xa,%edi
    33c9:	e8 62 ed ff ff       	call   2130 <fputc@plt>
    33ce:	4c 89 f0             	mov    %r14,%rax
    33d1:	48 2b 05 c0 0d 01 00 	sub    0x10dc0(%rip),%rax        # 14198 <fwp_gc+0x1030>
    33d8:	48 8b 0d e1 0d 01 00 	mov    0x10de1(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    33df:	48 c1 e1 10          	shl    $0x10,%rcx
    33e3:	48 39 c8             	cmp    %rcx,%rax
    33e6:	73 7a                	jae    3462 <fwp_main_thread+0x702>
    33e8:	48 8b 0d f1 0d 01 00 	mov    0x10df1(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    33ef:	48 89 c2             	mov    %rax,%rdx
    33f2:	48 c1 ea 10          	shr    $0x10,%rdx
    33f6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    33fd:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3401:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3407:	75 13                	jne    341c <fwp_main_thread+0x6bc>
    3409:	40 80 fe 02          	cmp    $0x2,%sil
    340d:	75 0d                	jne    341c <fwp_main_thread+0x6bc>
    340f:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    3413:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    341a:	eb 21                	jmp    343d <fwp_main_thread+0x6dd>
    341c:	40 80 fe 01          	cmp    $0x1,%sil
    3420:	75 40                	jne    3462 <fwp_main_thread+0x702>
    3422:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3426:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    342a:	48 0f af c1          	imul   %rcx,%rax
    342e:	48 c1 e8 20          	shr    $0x20,%rax
    3432:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    3436:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    343d:	0f b6 07             	movzbl (%rdi),%eax
    3440:	85 c0                	test   %eax,%eax
    3442:	74 1e                	je     3462 <fwp_main_thread+0x702>
    3444:	83 f8 01             	cmp    $0x1,%eax
    3447:	75 0a                	jne    3453 <fwp_main_thread+0x6f3>
    3449:	4c 89 f7             	mov    %r14,%rdi
    344c:	e8 7f 7b 00 00       	call   afd0 <fwp_rc_free_obj>
    3451:	eb 0f                	jmp    3462 <fwp_main_thread+0x702>
    3453:	3d ff 00 00 00       	cmp    $0xff,%eax
    3458:	0f 84 f2 13 00 00    	je     4850 <fwp_main_thread+0x1af0>
    345e:	fe c8                	dec    %al
    3460:	88 07                	mov    %al,(%rdi)
    3462:	41 bf 00 00 00 80    	mov    $0x80000000,%r15d
    3468:	49 8d 87 00 00 00 40 	lea    0x40000000(%r15),%rax
    346f:	48 89 85 d0 fe ff ff 	mov    %rax,-0x130(%rbp)
    3476:	48 c7 85 d8 fe ff ff 	movq   $0x0,-0x128(%rbp)
    347d:	00 00 00 00 
    3481:	48 8d 95 d0 fe ff ff 	lea    -0x130(%rbp),%rdx
    3488:	bf 01 00 00 00       	mov    $0x1,%edi
    348d:	be 02 00 00 00       	mov    $0x2,%esi
    3492:	e8 f9 6f 00 00       	call   a490 <fwp_data>
    3497:	48 89 c1             	mov    %rax,%rcx
    349a:	48 2b 0d f7 0c 01 00 	sub    0x10cf7(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    34a1:	48 8b 15 18 0d 01 00 	mov    0x10d18(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    34a8:	48 c1 e2 10          	shl    $0x10,%rdx
    34ac:	48 39 d1             	cmp    %rdx,%rcx
    34af:	73 76                	jae    3527 <fwp_main_thread+0x7c7>
    34b1:	48 8b 15 28 0d 01 00 	mov    0x10d28(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    34b8:	48 89 ce             	mov    %rcx,%rsi
    34bb:	48 c1 ee 10          	shr    $0x10,%rsi
    34bf:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    34c6:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    34ca:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    34d1:	75 1d                	jne    34f0 <fwp_main_thread+0x790>
    34d3:	40 80 ff 02          	cmp    $0x2,%dil
    34d7:	75 17                	jne    34f0 <fwp_main_thread+0x790>
    34d9:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    34dd:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    34e4:	41 80 3e ff          	cmpb   $0xff,(%r14)
    34e8:	74 2d                	je     3517 <fwp_main_thread+0x7b7>
    34ea:	41 c6 06 01          	movb   $0x1,(%r14)
    34ee:	eb 37                	jmp    3527 <fwp_main_thread+0x7c7>
    34f0:	40 80 ff 01          	cmp    $0x1,%dil
    34f4:	75 31                	jne    3527 <fwp_main_thread+0x7c7>
    34f6:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    34fa:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    34fe:	48 0f af ca          	imul   %rdx,%rcx
    3502:	48 c1 e9 20          	shr    $0x20,%rcx
    3506:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    350a:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3511:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3515:	75 d3                	jne    34ea <fwp_main_thread+0x78a>
    3517:	4c 89 f7             	mov    %r14,%rdi
    351a:	48 89 c3             	mov    %rax,%rbx
    351d:	e8 ae 35 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3522:	48 89 d8             	mov    %rbx,%rax
    3525:	eb c3                	jmp    34ea <fwp_main_thread+0x78a>
    3527:	48 c7 85 e0 fe ff ff 	movq   $0x3e800000,-0x120(%rbp)
    352e:	00 00 80 3e 
    3532:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    3539:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    3540:	bf 01 00 00 00       	mov    $0x1,%edi
    3545:	be 02 00 00 00       	mov    $0x2,%esi
    354a:	e8 41 6f 00 00       	call   a490 <fwp_data>
    354f:	48 89 c1             	mov    %rax,%rcx
    3552:	48 2b 0d 3f 0c 01 00 	sub    0x10c3f(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    3559:	48 8b 15 60 0c 01 00 	mov    0x10c60(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3560:	48 c1 e2 10          	shl    $0x10,%rdx
    3564:	48 39 d1             	cmp    %rdx,%rcx
    3567:	73 76                	jae    35df <fwp_main_thread+0x87f>
    3569:	48 8b 15 70 0c 01 00 	mov    0x10c70(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3570:	48 89 ce             	mov    %rcx,%rsi
    3573:	48 c1 ee 10          	shr    $0x10,%rsi
    3577:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    357e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3582:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3589:	75 1d                	jne    35a8 <fwp_main_thread+0x848>
    358b:	40 80 ff 02          	cmp    $0x2,%dil
    358f:	75 17                	jne    35a8 <fwp_main_thread+0x848>
    3591:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3595:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    359c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    35a0:	74 2d                	je     35cf <fwp_main_thread+0x86f>
    35a2:	41 c6 06 01          	movb   $0x1,(%r14)
    35a6:	eb 37                	jmp    35df <fwp_main_thread+0x87f>
    35a8:	40 80 ff 01          	cmp    $0x1,%dil
    35ac:	75 31                	jne    35df <fwp_main_thread+0x87f>
    35ae:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    35b2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    35b6:	48 0f af ca          	imul   %rdx,%rcx
    35ba:	48 c1 e9 20          	shr    $0x20,%rcx
    35be:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    35c2:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    35c9:	41 80 3e ff          	cmpb   $0xff,(%r14)
    35cd:	75 d3                	jne    35a2 <fwp_main_thread+0x842>
    35cf:	4c 89 f7             	mov    %r14,%rdi
    35d2:	48 89 c3             	mov    %rax,%rbx
    35d5:	e8 f6 34 00 00       	call   6ad0 <fwp_rc_forget_slot>
    35da:	48 89 d8             	mov    %rbx,%rax
    35dd:	eb c3                	jmp    35a2 <fwp_main_thread+0x842>
    35df:	4c 89 bd f0 fe ff ff 	mov    %r15,-0x110(%rbp)
    35e6:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    35ed:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    35f4:	bf 01 00 00 00       	mov    $0x1,%edi
    35f9:	be 02 00 00 00       	mov    $0x2,%esi
    35fe:	e8 8d 6e 00 00       	call   a490 <fwp_data>
    3603:	48 89 c1             	mov    %rax,%rcx
    3606:	48 2b 0d 8b 0b 01 00 	sub    0x10b8b(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    360d:	48 8b 15 ac 0b 01 00 	mov    0x10bac(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3614:	48 c1 e2 10          	shl    $0x10,%rdx
    3618:	48 39 d1             	cmp    %rdx,%rcx
    361b:	73 76                	jae    3693 <fwp_main_thread+0x933>
    361d:	48 8b 15 bc 0b 01 00 	mov    0x10bbc(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3624:	48 89 ce             	mov    %rcx,%rsi
    3627:	48 c1 ee 10          	shr    $0x10,%rsi
    362b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3632:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3636:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    363d:	75 1d                	jne    365c <fwp_main_thread+0x8fc>
    363f:	40 80 ff 02          	cmp    $0x2,%dil
    3643:	75 17                	jne    365c <fwp_main_thread+0x8fc>
    3645:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3649:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3650:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3654:	74 2d                	je     3683 <fwp_main_thread+0x923>
    3656:	41 c6 06 01          	movb   $0x1,(%r14)
    365a:	eb 37                	jmp    3693 <fwp_main_thread+0x933>
    365c:	40 80 ff 01          	cmp    $0x1,%dil
    3660:	75 31                	jne    3693 <fwp_main_thread+0x933>
    3662:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3666:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    366a:	48 0f af ca          	imul   %rdx,%rcx
    366e:	48 c1 e9 20          	shr    $0x20,%rcx
    3672:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3676:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    367d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3681:	75 d3                	jne    3656 <fwp_main_thread+0x8f6>
    3683:	4c 89 f7             	mov    %r14,%rdi
    3686:	48 89 c3             	mov    %rax,%rbx
    3689:	e8 42 34 00 00       	call   6ad0 <fwp_rc_forget_slot>
    368e:	48 89 d8             	mov    %rbx,%rax
    3691:	eb c3                	jmp    3656 <fwp_main_thread+0x8f6>
    3693:	48 c7 85 00 ff ff ff 	movq   $0x3fc00000,-0x100(%rbp)
    369a:	00 00 c0 3f 
    369e:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
    36a5:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
    36ac:	bf 01 00 00 00       	mov    $0x1,%edi
    36b1:	be 02 00 00 00       	mov    $0x2,%esi
    36b6:	e8 d5 6d 00 00       	call   a490 <fwp_data>
    36bb:	49 89 c7             	mov    %rax,%r15
    36be:	48 2b 05 d3 0a 01 00 	sub    0x10ad3(%rip),%rax        # 14198 <fwp_gc+0x1030>
    36c5:	48 8b 0d f4 0a 01 00 	mov    0x10af4(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    36cc:	48 c1 e1 10          	shl    $0x10,%rcx
    36d0:	48 39 c8             	cmp    %rcx,%rax
    36d3:	73 6f                	jae    3744 <fwp_main_thread+0x9e4>
    36d5:	48 8b 0d 04 0b 01 00 	mov    0x10b04(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    36dc:	48 89 c2             	mov    %rax,%rdx
    36df:	48 c1 ea 10          	shr    $0x10,%rdx
    36e3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    36ea:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    36ee:	48 25 ff ff 00 00    	and    $0xffff,%rax
    36f4:	75 1d                	jne    3713 <fwp_main_thread+0x9b3>
    36f6:	40 80 fe 02          	cmp    $0x2,%sil
    36fa:	75 17                	jne    3713 <fwp_main_thread+0x9b3>
    36fc:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    3700:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3707:	41 80 3e ff          	cmpb   $0xff,(%r14)
    370b:	74 2d                	je     373a <fwp_main_thread+0x9da>
    370d:	41 c6 06 01          	movb   $0x1,(%r14)
    3711:	eb 31                	jmp    3744 <fwp_main_thread+0x9e4>
    3713:	40 80 fe 01          	cmp    $0x1,%sil
    3717:	75 2b                	jne    3744 <fwp_main_thread+0x9e4>
    3719:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    371d:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3721:	48 0f af c1          	imul   %rcx,%rax
    3725:	48 c1 e8 20          	shr    $0x20,%rax
    3729:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    372d:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3734:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3738:	75 d3                	jne    370d <fwp_main_thread+0x9ad>
    373a:	4c 89 f7             	mov    %r14,%rdi
    373d:	e8 8e 33 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3742:	eb c9                	jmp    370d <fwp_main_thread+0x9ad>
    3744:	48 8d 35 c5 f5 00 00 	lea    0xf5c5(%rip),%rsi        # 12d10 <d2>
    374b:	4c 89 ff             	mov    %r15,%rdi
    374e:	e8 7d 34 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    3753:	4c 89 f9             	mov    %r15,%rcx
    3756:	48 2b 0d 3b 0a 01 00 	sub    0x10a3b(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    375d:	49 89 c6             	mov    %rax,%r14
    3760:	48 8b 05 59 0a 01 00 	mov    0x10a59(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    3767:	48 c1 e0 10          	shl    $0x10,%rax
    376b:	48 39 c1             	cmp    %rax,%rcx
    376e:	0f 83 a0 00 00 00    	jae    3814 <fwp_main_thread+0xab4>
    3774:	48 8b 05 65 0a 01 00 	mov    0x10a65(%rip),%rax        # 141e0 <fwp_gc+0x1078>
    377b:	48 89 ca             	mov    %rcx,%rdx
    377e:	48 c1 ea 10          	shr    $0x10,%rdx
    3782:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3789:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
    378d:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3794:	75 13                	jne    37a9 <fwp_main_thread+0xa49>
    3796:	40 80 fe 02          	cmp    $0x2,%sil
    379a:	75 0d                	jne    37a9 <fwp_main_thread+0xa49>
    379c:	48 8d 3c 10          	lea    (%rax,%rdx,1),%rdi
    37a0:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    37a7:	eb 21                	jmp    37ca <fwp_main_thread+0xa6a>
    37a9:	40 80 fe 01          	cmp    $0x1,%sil
    37ad:	75 65                	jne    3814 <fwp_main_thread+0xab4>
    37af:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    37b3:	8b 44 10 20          	mov    0x20(%rax,%rdx,1),%eax
    37b7:	48 0f af c8          	imul   %rax,%rcx
    37bb:	48 c1 e9 20          	shr    $0x20,%rcx
    37bf:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    37c3:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    37ca:	0f b6 07             	movzbl (%rdi),%eax
    37cd:	85 c0                	test   %eax,%eax
    37cf:	74 43                	je     3814 <fwp_main_thread+0xab4>
    37d1:	83 f8 01             	cmp    $0x1,%eax
    37d4:	75 2f                	jne    3805 <fwp_main_thread+0xaa5>
    37d6:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    37da:	4c 89 ff             	mov    %r15,%rdi
    37dd:	e8 ee 77 00 00       	call   afd0 <fwp_rc_free_obj>
    37e2:	48 89 d9             	mov    %rbx,%rcx
    37e5:	48 2b 0d ac 09 01 00 	sub    0x109ac(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    37ec:	48 8b 05 cd 09 01 00 	mov    0x109cd(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    37f3:	48 c1 e0 10          	shl    $0x10,%rax
    37f7:	49 89 df             	mov    %rbx,%r15
    37fa:	48 39 c1             	cmp    %rax,%rcx
    37fd:	0f 82 71 ff ff ff    	jb     3774 <fwp_main_thread+0xa14>
    3803:	eb 0f                	jmp    3814 <fwp_main_thread+0xab4>
    3805:	3d ff 00 00 00       	cmp    $0xff,%eax
    380a:	0f 84 2f 10 00 00    	je     483f <fwp_main_thread+0x1adf>
    3810:	fe c8                	dec    %al
    3812:	88 07                	mov    %al,(%rdi)
    3814:	31 db                	xor    %ebx,%ebx
    3816:	45 31 ff             	xor    %r15d,%r15d
    3819:	45 31 e4             	xor    %r12d,%r12d
    381c:	45 31 ed             	xor    %r13d,%r13d
    381f:	31 ff                	xor    %edi,%edi
    3821:	eb 21                	jmp    3844 <fwp_main_thread+0xae4>
    3823:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    382a:	84 00 00 00 00 00 
    3830:	4c 89 f7             	mov    %r14,%rdi
    3833:	e8 f8 96 00 00       	call   cf30 <fwp_drop8>
    3838:	31 c0                	xor    %eax,%eax
    383a:	48 89 df             	mov    %rbx,%rdi
    383d:	4d 89 e6             	mov    %r12,%r14
    3840:	84 c0                	test   %al,%al
    3842:	74 5b                	je     389f <fwp_main_thread+0xb3f>
    3844:	4d 85 ff             	test   %r15,%r15
    3847:	78 e7                	js     3830 <fwp_main_thread+0xad0>
    3849:	49 8b 06             	mov    (%r14),%rax
    384c:	48 89 c1             	mov    %rax,%rcx
    384f:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    3856:	ff ff 7f 
    3859:	48 21 d1             	and    %rdx,%rcx
    385c:	49 39 cf             	cmp    %rcx,%r15
    385f:	73 cf                	jae    3830 <fwp_main_thread+0xad0>
    3861:	48 85 c0             	test   %rax,%rax
    3864:	78 06                	js     386c <fwp_main_thread+0xb0c>
    3866:	49 8d 46 08          	lea    0x8(%r14),%rax
    386a:	eb 04                	jmp    3870 <fwp_main_thread+0xb10>
    386c:	49 8b 46 10          	mov    0x10(%r14),%rax
    3870:	f3 42 0f 10 04 b8    	movss  (%rax,%r15,4),%xmm0
    3876:	49 ff c7             	inc    %r15
    3879:	f3 0f 59 05 83 b7 00 	mulss  0xb783(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    3880:	00 
    3881:	f3 0f 58 05 7f b7 00 	addss  0xb77f(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    3888:	00 
    3889:	66 0f 6e cb          	movd   %ebx,%xmm1
    388d:	f3 0f 58 c8          	addss  %xmm0,%xmm1
    3891:	66 0f 7e cb          	movd   %xmm1,%ebx
    3895:	b0 01                	mov    $0x1,%al
    3897:	4d 89 f4             	mov    %r14,%r12
    389a:	4d 89 f5             	mov    %r14,%r13
    389d:	eb 9e                	jmp    383d <fwp_main_thread+0xadd>
    389f:	48 8d 35 6a f4 00 00 	lea    0xf46a(%rip),%rsi        # 12d10 <d2>
    38a6:	e8 e5 44 00 00       	call   7d90 <fwp_show>
    38ab:	49 89 c6             	mov    %rax,%r14
    38ae:	48 2b 05 e3 08 01 00 	sub    0x108e3(%rip),%rax        # 14198 <fwp_gc+0x1030>
    38b5:	48 8b 0d 04 09 01 00 	mov    0x10904(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    38bc:	48 c1 e1 10          	shl    $0x10,%rcx
    38c0:	48 39 c8             	cmp    %rcx,%rax
    38c3:	73 6f                	jae    3934 <fwp_main_thread+0xbd4>
    38c5:	48 8b 0d 14 09 01 00 	mov    0x10914(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    38cc:	48 89 c2             	mov    %rax,%rdx
    38cf:	48 c1 ea 10          	shr    $0x10,%rdx
    38d3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    38da:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    38de:	48 25 ff ff 00 00    	and    $0xffff,%rax
    38e4:	75 1d                	jne    3903 <fwp_main_thread+0xba3>
    38e6:	40 80 fe 02          	cmp    $0x2,%sil
    38ea:	75 17                	jne    3903 <fwp_main_thread+0xba3>
    38ec:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    38f0:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    38f7:	41 80 3f ff          	cmpb   $0xff,(%r15)
    38fb:	74 2d                	je     392a <fwp_main_thread+0xbca>
    38fd:	41 c6 07 01          	movb   $0x1,(%r15)
    3901:	eb 31                	jmp    3934 <fwp_main_thread+0xbd4>
    3903:	40 80 fe 01          	cmp    $0x1,%sil
    3907:	75 2b                	jne    3934 <fwp_main_thread+0xbd4>
    3909:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    390d:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3911:	48 0f af c1          	imul   %rcx,%rax
    3915:	48 c1 e8 20          	shr    $0x20,%rax
    3919:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    391d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3924:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3928:	75 d3                	jne    38fd <fwp_main_thread+0xb9d>
    392a:	4c 89 ff             	mov    %r15,%rdi
    392d:	e8 9e 31 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3932:	eb c9                	jmp    38fd <fwp_main_thread+0xb9d>
    3934:	4c 89 f7             	mov    %r14,%rdi
    3937:	48 83 c7 08          	add    $0x8,%rdi
    393b:	49 8b 16             	mov    (%r14),%rdx
    393e:	48 8b 0d 23 1e 01 00 	mov    0x11e23(%rip),%rcx        # 15768 <fwp_prog_out>
    3945:	be 01 00 00 00       	mov    $0x1,%esi
    394a:	e8 31 e9 ff ff       	call   2280 <fwrite@plt>
    394f:	48 8b 35 12 1e 01 00 	mov    0x11e12(%rip),%rsi        # 15768 <fwp_prog_out>
    3956:	bf 0a 00 00 00       	mov    $0xa,%edi
    395b:	e8 d0 e7 ff ff       	call   2130 <fputc@plt>
    3960:	4c 89 f0             	mov    %r14,%rax
    3963:	48 2b 05 2e 08 01 00 	sub    0x1082e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    396a:	48 8b 0d 4f 08 01 00 	mov    0x1084f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    3971:	48 c1 e1 10          	shl    $0x10,%rcx
    3975:	48 39 c8             	cmp    %rcx,%rax
    3978:	73 7a                	jae    39f4 <fwp_main_thread+0xc94>
    397a:	48 8b 0d 5f 08 01 00 	mov    0x1085f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    3981:	48 89 c2             	mov    %rax,%rdx
    3984:	48 c1 ea 10          	shr    $0x10,%rdx
    3988:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    398f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3993:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3999:	75 13                	jne    39ae <fwp_main_thread+0xc4e>
    399b:	40 80 fe 02          	cmp    $0x2,%sil
    399f:	75 0d                	jne    39ae <fwp_main_thread+0xc4e>
    39a1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    39a5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    39ac:	eb 21                	jmp    39cf <fwp_main_thread+0xc6f>
    39ae:	40 80 fe 01          	cmp    $0x1,%sil
    39b2:	75 40                	jne    39f4 <fwp_main_thread+0xc94>
    39b4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    39b8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    39bc:	48 0f af c1          	imul   %rcx,%rax
    39c0:	48 c1 e8 20          	shr    $0x20,%rax
    39c4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    39c8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    39cf:	0f b6 07             	movzbl (%rdi),%eax
    39d2:	85 c0                	test   %eax,%eax
    39d4:	74 1e                	je     39f4 <fwp_main_thread+0xc94>
    39d6:	83 f8 01             	cmp    $0x1,%eax
    39d9:	75 0a                	jne    39e5 <fwp_main_thread+0xc85>
    39db:	4c 89 f7             	mov    %r14,%rdi
    39de:	e8 ed 75 00 00       	call   afd0 <fwp_rc_free_obj>
    39e3:	eb 0f                	jmp    39f4 <fwp_main_thread+0xc94>
    39e5:	3d ff 00 00 00       	cmp    $0xff,%eax
    39ea:	0f 84 6a 0e 00 00    	je     485a <fwp_main_thread+0x1afa>
    39f0:	fe c8                	dec    %al
    39f2:	88 07                	mov    %al,(%rdi)
    39f4:	48 c7 85 10 ff ff ff 	movq   $0xc,-0xf0(%rbp)
    39fb:	0c 00 00 00 
    39ff:	48 c7 85 18 ff ff ff 	movq   $0x0,-0xe8(%rbp)
    3a06:	00 00 00 00 
    3a0a:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
    3a11:	bf 01 00 00 00       	mov    $0x1,%edi
    3a16:	be 02 00 00 00       	mov    $0x2,%esi
    3a1b:	e8 70 6a 00 00       	call   a490 <fwp_data>
    3a20:	48 89 c1             	mov    %rax,%rcx
    3a23:	48 2b 0d 6e 07 01 00 	sub    0x1076e(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    3a2a:	48 8b 15 8f 07 01 00 	mov    0x1078f(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3a31:	48 c1 e2 10          	shl    $0x10,%rdx
    3a35:	48 39 d1             	cmp    %rdx,%rcx
    3a38:	73 76                	jae    3ab0 <fwp_main_thread+0xd50>
    3a3a:	48 8b 15 9f 07 01 00 	mov    0x1079f(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3a41:	48 89 ce             	mov    %rcx,%rsi
    3a44:	48 c1 ee 10          	shr    $0x10,%rsi
    3a48:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3a4f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3a53:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3a5a:	75 1d                	jne    3a79 <fwp_main_thread+0xd19>
    3a5c:	40 80 ff 02          	cmp    $0x2,%dil
    3a60:	75 17                	jne    3a79 <fwp_main_thread+0xd19>
    3a62:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3a66:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3a6d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3a71:	74 2d                	je     3aa0 <fwp_main_thread+0xd40>
    3a73:	41 c6 06 01          	movb   $0x1,(%r14)
    3a77:	eb 37                	jmp    3ab0 <fwp_main_thread+0xd50>
    3a79:	40 80 ff 01          	cmp    $0x1,%dil
    3a7d:	75 31                	jne    3ab0 <fwp_main_thread+0xd50>
    3a7f:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3a83:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3a87:	48 0f af ca          	imul   %rdx,%rcx
    3a8b:	48 c1 e9 20          	shr    $0x20,%rcx
    3a8f:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3a93:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3a9a:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3a9e:	75 d3                	jne    3a73 <fwp_main_thread+0xd13>
    3aa0:	4c 89 f7             	mov    %r14,%rdi
    3aa3:	48 89 c3             	mov    %rax,%rbx
    3aa6:	e8 25 30 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3aab:	48 89 d8             	mov    %rbx,%rax
    3aae:	eb c3                	jmp    3a73 <fwp_main_thread+0xd13>
    3ab0:	48 c7 85 20 ff ff ff 	movq   $0x0,-0xe0(%rbp)
    3ab7:	00 00 00 00 
    3abb:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    3ac2:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    3ac9:	bf 01 00 00 00       	mov    $0x1,%edi
    3ace:	be 02 00 00 00       	mov    $0x2,%esi
    3ad3:	e8 b8 69 00 00       	call   a490 <fwp_data>
    3ad8:	48 89 c1             	mov    %rax,%rcx
    3adb:	48 2b 0d b6 06 01 00 	sub    0x106b6(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    3ae2:	48 8b 15 d7 06 01 00 	mov    0x106d7(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3ae9:	48 c1 e2 10          	shl    $0x10,%rdx
    3aed:	48 39 d1             	cmp    %rdx,%rcx
    3af0:	73 76                	jae    3b68 <fwp_main_thread+0xe08>
    3af2:	48 8b 15 e7 06 01 00 	mov    0x106e7(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3af9:	48 89 ce             	mov    %rcx,%rsi
    3afc:	48 c1 ee 10          	shr    $0x10,%rsi
    3b00:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3b07:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3b0b:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3b12:	75 1d                	jne    3b31 <fwp_main_thread+0xdd1>
    3b14:	40 80 ff 02          	cmp    $0x2,%dil
    3b18:	75 17                	jne    3b31 <fwp_main_thread+0xdd1>
    3b1a:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3b1e:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3b25:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3b29:	74 2d                	je     3b58 <fwp_main_thread+0xdf8>
    3b2b:	41 c6 06 01          	movb   $0x1,(%r14)
    3b2f:	eb 37                	jmp    3b68 <fwp_main_thread+0xe08>
    3b31:	40 80 ff 01          	cmp    $0x1,%dil
    3b35:	75 31                	jne    3b68 <fwp_main_thread+0xe08>
    3b37:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3b3b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3b3f:	48 0f af ca          	imul   %rdx,%rcx
    3b43:	48 c1 e9 20          	shr    $0x20,%rcx
    3b47:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3b4b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3b52:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3b56:	75 d3                	jne    3b2b <fwp_main_thread+0xdcb>
    3b58:	4c 89 f7             	mov    %r14,%rdi
    3b5b:	48 89 c3             	mov    %rax,%rbx
    3b5e:	e8 6d 2f 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3b63:	48 89 d8             	mov    %rbx,%rax
    3b66:	eb c3                	jmp    3b2b <fwp_main_thread+0xdcb>
    3b68:	48 c7 85 30 ff ff ff 	movq   $0xffffffffffffff80,-0xd0(%rbp)
    3b6f:	80 ff ff ff 
    3b73:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    3b7a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
    3b81:	bf 01 00 00 00       	mov    $0x1,%edi
    3b86:	be 02 00 00 00       	mov    $0x2,%esi
    3b8b:	e8 00 69 00 00       	call   a490 <fwp_data>
    3b90:	49 89 c7             	mov    %rax,%r15
    3b93:	48 2b 05 fe 05 01 00 	sub    0x105fe(%rip),%rax        # 14198 <fwp_gc+0x1030>
    3b9a:	48 8b 0d 1f 06 01 00 	mov    0x1061f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    3ba1:	48 c1 e1 10          	shl    $0x10,%rcx
    3ba5:	48 39 c8             	cmp    %rcx,%rax
    3ba8:	73 6f                	jae    3c19 <fwp_main_thread+0xeb9>
    3baa:	48 8b 0d 2f 06 01 00 	mov    0x1062f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    3bb1:	48 89 c2             	mov    %rax,%rdx
    3bb4:	48 c1 ea 10          	shr    $0x10,%rdx
    3bb8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3bbf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3bc3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3bc9:	75 1d                	jne    3be8 <fwp_main_thread+0xe88>
    3bcb:	40 80 fe 02          	cmp    $0x2,%sil
    3bcf:	75 17                	jne    3be8 <fwp_main_thread+0xe88>
    3bd1:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    3bd5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3bdc:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3be0:	74 2d                	je     3c0f <fwp_main_thread+0xeaf>
    3be2:	41 c6 06 01          	movb   $0x1,(%r14)
    3be6:	eb 31                	jmp    3c19 <fwp_main_thread+0xeb9>
    3be8:	40 80 fe 01          	cmp    $0x1,%sil
    3bec:	75 2b                	jne    3c19 <fwp_main_thread+0xeb9>
    3bee:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3bf2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3bf6:	48 0f af c1          	imul   %rcx,%rax
    3bfa:	48 c1 e8 20          	shr    $0x20,%rax
    3bfe:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    3c02:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3c09:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3c0d:	75 d3                	jne    3be2 <fwp_main_thread+0xe82>
    3c0f:	4c 89 f7             	mov    %r14,%rdi
    3c12:	e8 b9 2e 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3c17:	eb c9                	jmp    3be2 <fwp_main_thread+0xe82>
    3c19:	48 8d 35 90 f0 00 00 	lea    0xf090(%rip),%rsi        # 12cb0 <d1>
    3c20:	4c 89 ff             	mov    %r15,%rdi
    3c23:	e8 a8 2f 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    3c28:	49 89 c6             	mov    %rax,%r14
    3c2b:	4c 89 ff             	mov    %r15,%rdi
    3c2e:	e8 8d ad 00 00       	call   e9c0 <fwp_drop4>
    3c33:	31 db                	xor    %ebx,%ebx
    3c35:	45 31 ff             	xor    %r15d,%r15d
    3c38:	45 31 e4             	xor    %r12d,%r12d
    3c3b:	45 31 ed             	xor    %r13d,%r13d
    3c3e:	31 ff                	xor    %edi,%edi
    3c40:	eb 22                	jmp    3c64 <fwp_main_thread+0xf04>
    3c42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3c49:	1f 84 00 00 00 00 00 
    3c50:	4c 89 f7             	mov    %r14,%rdi
    3c53:	e8 88 9a 00 00       	call   d6e0 <fwp_drop11>
    3c58:	31 c0                	xor    %eax,%eax
    3c5a:	48 89 df             	mov    %rbx,%rdi
    3c5d:	4d 89 e6             	mov    %r12,%r14
    3c60:	84 c0                	test   %al,%al
    3c62:	74 57                	je     3cbb <fwp_main_thread+0xf5b>
    3c64:	4d 85 ff             	test   %r15,%r15
    3c67:	78 e7                	js     3c50 <fwp_main_thread+0xef0>
    3c69:	49 8b 06             	mov    (%r14),%rax
    3c6c:	48 89 c1             	mov    %rax,%rcx
    3c6f:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    3c76:	ff ff 7f 
    3c79:	48 21 d1             	and    %rdx,%rcx
    3c7c:	49 39 cf             	cmp    %rcx,%r15
    3c7f:	73 cf                	jae    3c50 <fwp_main_thread+0xef0>
    3c81:	48 85 c0             	test   %rax,%rax
    3c84:	78 06                	js     3c8c <fwp_main_thread+0xf2c>
    3c86:	49 8d 46 08          	lea    0x8(%r14),%rax
    3c8a:	eb 04                	jmp    3c90 <fwp_main_thread+0xf30>
    3c8c:	49 8b 46 10          	mov    0x10(%r14),%rax
    3c90:	4a 0f be 04 38       	movsbq (%rax,%r15,1),%rax
    3c95:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    3c99:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    3c9f:	0f 86 dd 0b 00 00    	jbe    4882 <fwp_main_thread+0x1b22>
    3ca5:	48 ff c3             	inc    %rbx
    3ca8:	0f 80 e4 0b 00 00    	jo     4892 <fwp_main_thread+0x1b32>
    3cae:	49 ff c7             	inc    %r15
    3cb1:	b0 01                	mov    $0x1,%al
    3cb3:	4d 89 f4             	mov    %r14,%r12
    3cb6:	4d 89 f5             	mov    %r14,%r13
    3cb9:	eb a2                	jmp    3c5d <fwp_main_thread+0xefd>
    3cbb:	e8 30 65 00 00       	call   a1f0 <fwp_show_i64>
    3cc0:	49 89 c6             	mov    %rax,%r14
    3cc3:	48 2b 05 ce 04 01 00 	sub    0x104ce(%rip),%rax        # 14198 <fwp_gc+0x1030>
    3cca:	48 8b 0d ef 04 01 00 	mov    0x104ef(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    3cd1:	48 c1 e1 10          	shl    $0x10,%rcx
    3cd5:	48 39 c8             	cmp    %rcx,%rax
    3cd8:	73 6f                	jae    3d49 <fwp_main_thread+0xfe9>
    3cda:	48 8b 0d ff 04 01 00 	mov    0x104ff(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    3ce1:	48 89 c2             	mov    %rax,%rdx
    3ce4:	48 c1 ea 10          	shr    $0x10,%rdx
    3ce8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3cef:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3cf3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3cf9:	75 1d                	jne    3d18 <fwp_main_thread+0xfb8>
    3cfb:	40 80 fe 02          	cmp    $0x2,%sil
    3cff:	75 17                	jne    3d18 <fwp_main_thread+0xfb8>
    3d01:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    3d05:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3d0c:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3d10:	74 2d                	je     3d3f <fwp_main_thread+0xfdf>
    3d12:	41 c6 07 01          	movb   $0x1,(%r15)
    3d16:	eb 31                	jmp    3d49 <fwp_main_thread+0xfe9>
    3d18:	40 80 fe 01          	cmp    $0x1,%sil
    3d1c:	75 2b                	jne    3d49 <fwp_main_thread+0xfe9>
    3d1e:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3d22:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3d26:	48 0f af c1          	imul   %rcx,%rax
    3d2a:	48 c1 e8 20          	shr    $0x20,%rax
    3d2e:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    3d32:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3d39:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3d3d:	75 d3                	jne    3d12 <fwp_main_thread+0xfb2>
    3d3f:	4c 89 ff             	mov    %r15,%rdi
    3d42:	e8 89 2d 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3d47:	eb c9                	jmp    3d12 <fwp_main_thread+0xfb2>
    3d49:	4c 89 f7             	mov    %r14,%rdi
    3d4c:	48 83 c7 08          	add    $0x8,%rdi
    3d50:	49 8b 16             	mov    (%r14),%rdx
    3d53:	48 8b 0d 0e 1a 01 00 	mov    0x11a0e(%rip),%rcx        # 15768 <fwp_prog_out>
    3d5a:	be 01 00 00 00       	mov    $0x1,%esi
    3d5f:	e8 1c e5 ff ff       	call   2280 <fwrite@plt>
    3d64:	48 8b 35 fd 19 01 00 	mov    0x119fd(%rip),%rsi        # 15768 <fwp_prog_out>
    3d6b:	bf 0a 00 00 00       	mov    $0xa,%edi
    3d70:	e8 bb e3 ff ff       	call   2130 <fputc@plt>
    3d75:	4c 89 f0             	mov    %r14,%rax
    3d78:	48 2b 05 19 04 01 00 	sub    0x10419(%rip),%rax        # 14198 <fwp_gc+0x1030>
    3d7f:	48 8b 0d 3a 04 01 00 	mov    0x1043a(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    3d86:	48 c1 e1 10          	shl    $0x10,%rcx
    3d8a:	48 39 c8             	cmp    %rcx,%rax
    3d8d:	73 7a                	jae    3e09 <fwp_main_thread+0x10a9>
    3d8f:	48 8b 0d 4a 04 01 00 	mov    0x1044a(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    3d96:	48 89 c2             	mov    %rax,%rdx
    3d99:	48 c1 ea 10          	shr    $0x10,%rdx
    3d9d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3da4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3da8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3dae:	75 13                	jne    3dc3 <fwp_main_thread+0x1063>
    3db0:	40 80 fe 02          	cmp    $0x2,%sil
    3db4:	75 0d                	jne    3dc3 <fwp_main_thread+0x1063>
    3db6:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    3dba:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3dc1:	eb 21                	jmp    3de4 <fwp_main_thread+0x1084>
    3dc3:	40 80 fe 01          	cmp    $0x1,%sil
    3dc7:	75 40                	jne    3e09 <fwp_main_thread+0x10a9>
    3dc9:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3dcd:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3dd1:	48 0f af c1          	imul   %rcx,%rax
    3dd5:	48 c1 e8 20          	shr    $0x20,%rax
    3dd9:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    3ddd:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3de4:	0f b6 07             	movzbl (%rdi),%eax
    3de7:	85 c0                	test   %eax,%eax
    3de9:	74 1e                	je     3e09 <fwp_main_thread+0x10a9>
    3deb:	83 f8 01             	cmp    $0x1,%eax
    3dee:	75 0a                	jne    3dfa <fwp_main_thread+0x109a>
    3df0:	4c 89 f7             	mov    %r14,%rdi
    3df3:	e8 d8 71 00 00       	call   afd0 <fwp_rc_free_obj>
    3df8:	eb 0f                	jmp    3e09 <fwp_main_thread+0x10a9>
    3dfa:	3d ff 00 00 00       	cmp    $0xff,%eax
    3dff:	0f 84 5f 0a 00 00    	je     4864 <fwp_main_thread+0x1b04>
    3e05:	fe c8                	dec    %al
    3e07:	88 07                	mov    %al,(%rdi)
    3e09:	48 c7 85 40 ff ff ff 	movq   $0x3,-0xc0(%rbp)
    3e10:	03 00 00 00 
    3e14:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
    3e1b:	00 00 00 00 
    3e1f:	48 8d 95 40 ff ff ff 	lea    -0xc0(%rbp),%rdx
    3e26:	bf 01 00 00 00       	mov    $0x1,%edi
    3e2b:	be 02 00 00 00       	mov    $0x2,%esi
    3e30:	e8 5b 66 00 00       	call   a490 <fwp_data>
    3e35:	48 89 c1             	mov    %rax,%rcx
    3e38:	48 2b 0d 59 03 01 00 	sub    0x10359(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    3e3f:	48 8b 15 7a 03 01 00 	mov    0x1037a(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3e46:	48 c1 e2 10          	shl    $0x10,%rdx
    3e4a:	48 39 d1             	cmp    %rdx,%rcx
    3e4d:	73 76                	jae    3ec5 <fwp_main_thread+0x1165>
    3e4f:	48 8b 15 8a 03 01 00 	mov    0x1038a(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3e56:	48 89 ce             	mov    %rcx,%rsi
    3e59:	48 c1 ee 10          	shr    $0x10,%rsi
    3e5d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3e64:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3e68:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3e6f:	75 1d                	jne    3e8e <fwp_main_thread+0x112e>
    3e71:	40 80 ff 02          	cmp    $0x2,%dil
    3e75:	75 17                	jne    3e8e <fwp_main_thread+0x112e>
    3e77:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3e7b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3e82:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3e86:	74 2d                	je     3eb5 <fwp_main_thread+0x1155>
    3e88:	41 c6 06 01          	movb   $0x1,(%r14)
    3e8c:	eb 37                	jmp    3ec5 <fwp_main_thread+0x1165>
    3e8e:	40 80 ff 01          	cmp    $0x1,%dil
    3e92:	75 31                	jne    3ec5 <fwp_main_thread+0x1165>
    3e94:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3e98:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3e9c:	48 0f af ca          	imul   %rdx,%rcx
    3ea0:	48 c1 e9 20          	shr    $0x20,%rcx
    3ea4:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3ea8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3eaf:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3eb3:	75 d3                	jne    3e88 <fwp_main_thread+0x1128>
    3eb5:	4c 89 f7             	mov    %r14,%rdi
    3eb8:	48 89 c3             	mov    %rax,%rbx
    3ebb:	e8 10 2c 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3ec0:	48 89 d8             	mov    %rbx,%rax
    3ec3:	eb c3                	jmp    3e88 <fwp_main_thread+0x1128>
    3ec5:	48 c7 85 50 ff ff ff 	movq   $0x2,-0xb0(%rbp)
    3ecc:	02 00 00 00 
    3ed0:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    3ed7:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    3ede:	bf 01 00 00 00       	mov    $0x1,%edi
    3ee3:	be 02 00 00 00       	mov    $0x2,%esi
    3ee8:	e8 a3 65 00 00       	call   a490 <fwp_data>
    3eed:	48 89 c1             	mov    %rax,%rcx
    3ef0:	48 2b 0d a1 02 01 00 	sub    0x102a1(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    3ef7:	48 8b 15 c2 02 01 00 	mov    0x102c2(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    3efe:	48 c1 e2 10          	shl    $0x10,%rdx
    3f02:	48 39 d1             	cmp    %rdx,%rcx
    3f05:	73 76                	jae    3f7d <fwp_main_thread+0x121d>
    3f07:	48 8b 15 d2 02 01 00 	mov    0x102d2(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    3f0e:	48 89 ce             	mov    %rcx,%rsi
    3f11:	48 c1 ee 10          	shr    $0x10,%rsi
    3f15:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3f1c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3f20:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3f27:	75 1d                	jne    3f46 <fwp_main_thread+0x11e6>
    3f29:	40 80 ff 02          	cmp    $0x2,%dil
    3f2d:	75 17                	jne    3f46 <fwp_main_thread+0x11e6>
    3f2f:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3f33:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3f3a:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3f3e:	74 2d                	je     3f6d <fwp_main_thread+0x120d>
    3f40:	41 c6 06 01          	movb   $0x1,(%r14)
    3f44:	eb 37                	jmp    3f7d <fwp_main_thread+0x121d>
    3f46:	40 80 ff 01          	cmp    $0x1,%dil
    3f4a:	75 31                	jne    3f7d <fwp_main_thread+0x121d>
    3f4c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3f50:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3f54:	48 0f af ca          	imul   %rdx,%rcx
    3f58:	48 c1 e9 20          	shr    $0x20,%rcx
    3f5c:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3f60:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3f67:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3f6b:	75 d3                	jne    3f40 <fwp_main_thread+0x11e0>
    3f6d:	4c 89 f7             	mov    %r14,%rdi
    3f70:	48 89 c3             	mov    %rax,%rbx
    3f73:	e8 58 2b 00 00       	call   6ad0 <fwp_rc_forget_slot>
    3f78:	48 89 d8             	mov    %rbx,%rax
    3f7b:	eb c3                	jmp    3f40 <fwp_main_thread+0x11e0>
    3f7d:	48 c7 85 60 ff ff ff 	movq   $0x1,-0xa0(%rbp)
    3f84:	01 00 00 00 
    3f88:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    3f8f:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    3f96:	bf 01 00 00 00       	mov    $0x1,%edi
    3f9b:	be 02 00 00 00       	mov    $0x2,%esi
    3fa0:	e8 eb 64 00 00       	call   a490 <fwp_data>
    3fa5:	49 89 c7             	mov    %rax,%r15
    3fa8:	48 2b 05 e9 01 01 00 	sub    0x101e9(%rip),%rax        # 14198 <fwp_gc+0x1030>
    3faf:	48 8b 0d 0a 02 01 00 	mov    0x1020a(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    3fb6:	48 c1 e1 10          	shl    $0x10,%rcx
    3fba:	48 39 c8             	cmp    %rcx,%rax
    3fbd:	73 6f                	jae    402e <fwp_main_thread+0x12ce>
    3fbf:	48 8b 0d 1a 02 01 00 	mov    0x1021a(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    3fc6:	48 89 c2             	mov    %rax,%rdx
    3fc9:	48 c1 ea 10          	shr    $0x10,%rdx
    3fcd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3fd4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3fd8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3fde:	75 1d                	jne    3ffd <fwp_main_thread+0x129d>
    3fe0:	40 80 fe 02          	cmp    $0x2,%sil
    3fe4:	75 17                	jne    3ffd <fwp_main_thread+0x129d>
    3fe6:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    3fea:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3ff1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3ff5:	74 2d                	je     4024 <fwp_main_thread+0x12c4>
    3ff7:	41 c6 06 01          	movb   $0x1,(%r14)
    3ffb:	eb 31                	jmp    402e <fwp_main_thread+0x12ce>
    3ffd:	40 80 fe 01          	cmp    $0x1,%sil
    4001:	75 2b                	jne    402e <fwp_main_thread+0x12ce>
    4003:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4007:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    400b:	48 0f af c1          	imul   %rcx,%rax
    400f:	48 c1 e8 20          	shr    $0x20,%rax
    4013:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    4017:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    401e:	41 80 3e ff          	cmpb   $0xff,(%r14)
    4022:	75 d3                	jne    3ff7 <fwp_main_thread+0x1297>
    4024:	4c 89 f7             	mov    %r14,%rdi
    4027:	e8 a4 2a 00 00       	call   6ad0 <fwp_rc_forget_slot>
    402c:	eb c9                	jmp    3ff7 <fwp_main_thread+0x1297>
    402e:	48 8d 35 7b ec 00 00 	lea    0xec7b(%rip),%rsi        # 12cb0 <d1>
    4035:	4c 89 ff             	mov    %r15,%rdi
    4038:	e8 93 2b 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    403d:	49 89 c6             	mov    %rax,%r14
    4040:	4c 89 ff             	mov    %r15,%rdi
    4043:	e8 78 a9 00 00       	call   e9c0 <fwp_drop4>
    4048:	31 db                	xor    %ebx,%ebx
    404a:	45 31 ff             	xor    %r15d,%r15d
    404d:	45 31 e4             	xor    %r12d,%r12d
    4050:	45 31 ed             	xor    %r13d,%r13d
    4053:	31 ff                	xor    %edi,%edi
    4055:	eb 1d                	jmp    4074 <fwp_main_thread+0x1314>
    4057:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    405e:	00 00 
    4060:	4c 89 f7             	mov    %r14,%rdi
    4063:	e8 78 96 00 00       	call   d6e0 <fwp_drop11>
    4068:	31 c0                	xor    %eax,%eax
    406a:	48 89 df             	mov    %rbx,%rdi
    406d:	4d 89 e6             	mov    %r12,%r14
    4070:	84 c0                	test   %al,%al
    4072:	74 62                	je     40d6 <fwp_main_thread+0x1376>
    4074:	4d 85 ff             	test   %r15,%r15
    4077:	78 e7                	js     4060 <fwp_main_thread+0x1300>
    4079:	49 8b 06             	mov    (%r14),%rax
    407c:	48 89 c1             	mov    %rax,%rcx
    407f:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    4086:	ff ff 7f 
    4089:	48 21 d1             	and    %rdx,%rcx
    408c:	49 39 cf             	cmp    %rcx,%r15
    408f:	73 cf                	jae    4060 <fwp_main_thread+0x1300>
    4091:	48 85 c0             	test   %rax,%rax
    4094:	78 06                	js     409c <fwp_main_thread+0x133c>
    4096:	49 8d 46 08          	lea    0x8(%r14),%rax
    409a:	eb 04                	jmp    40a0 <fwp_main_thread+0x1340>
    409c:	49 8b 46 10          	mov    0x10(%r14),%rax
    40a0:	4a 0f be 04 38       	movsbq (%rax,%r15,1),%rax
    40a5:	48 8d 48 81          	lea    -0x7f(%rax),%rcx
    40a9:	48 81 f9 ff fe ff ff 	cmp    $0xfffffffffffffeff,%rcx
    40b0:	0f 86 cc 07 00 00    	jbe    4882 <fwp_main_thread+0x1b22>
    40b6:	48 01 c3             	add    %rax,%rbx
    40b9:	48 ff c3             	inc    %rbx
    40bc:	48 0f be c3          	movsbq %bl,%rax
    40c0:	48 39 d8             	cmp    %rbx,%rax
    40c3:	0f 85 b9 07 00 00    	jne    4882 <fwp_main_thread+0x1b22>
    40c9:	49 ff c7             	inc    %r15
    40cc:	b0 01                	mov    $0x1,%al
    40ce:	4d 89 f4             	mov    %r14,%r12
    40d1:	4d 89 f5             	mov    %r14,%r13
    40d4:	eb 97                	jmp    406d <fwp_main_thread+0x130d>
    40d6:	e8 15 61 00 00       	call   a1f0 <fwp_show_i64>
    40db:	49 89 c6             	mov    %rax,%r14
    40de:	48 2b 05 b3 00 01 00 	sub    0x100b3(%rip),%rax        # 14198 <fwp_gc+0x1030>
    40e5:	48 8b 0d d4 00 01 00 	mov    0x100d4(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    40ec:	48 c1 e1 10          	shl    $0x10,%rcx
    40f0:	48 39 c8             	cmp    %rcx,%rax
    40f3:	73 6f                	jae    4164 <fwp_main_thread+0x1404>
    40f5:	48 8b 0d e4 00 01 00 	mov    0x100e4(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    40fc:	48 89 c2             	mov    %rax,%rdx
    40ff:	48 c1 ea 10          	shr    $0x10,%rdx
    4103:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    410a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    410e:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4114:	75 1d                	jne    4133 <fwp_main_thread+0x13d3>
    4116:	40 80 fe 02          	cmp    $0x2,%sil
    411a:	75 17                	jne    4133 <fwp_main_thread+0x13d3>
    411c:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    4120:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    4127:	41 80 3f ff          	cmpb   $0xff,(%r15)
    412b:	74 2d                	je     415a <fwp_main_thread+0x13fa>
    412d:	41 c6 07 01          	movb   $0x1,(%r15)
    4131:	eb 31                	jmp    4164 <fwp_main_thread+0x1404>
    4133:	40 80 fe 01          	cmp    $0x1,%sil
    4137:	75 2b                	jne    4164 <fwp_main_thread+0x1404>
    4139:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    413d:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4141:	48 0f af c1          	imul   %rcx,%rax
    4145:	48 c1 e8 20          	shr    $0x20,%rax
    4149:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    414d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    4154:	41 80 3f ff          	cmpb   $0xff,(%r15)
    4158:	75 d3                	jne    412d <fwp_main_thread+0x13cd>
    415a:	4c 89 ff             	mov    %r15,%rdi
    415d:	e8 6e 29 00 00       	call   6ad0 <fwp_rc_forget_slot>
    4162:	eb c9                	jmp    412d <fwp_main_thread+0x13cd>
    4164:	4c 89 f7             	mov    %r14,%rdi
    4167:	48 83 c7 08          	add    $0x8,%rdi
    416b:	49 8b 16             	mov    (%r14),%rdx
    416e:	48 8b 0d f3 15 01 00 	mov    0x115f3(%rip),%rcx        # 15768 <fwp_prog_out>
    4175:	be 01 00 00 00       	mov    $0x1,%esi
    417a:	e8 01 e1 ff ff       	call   2280 <fwrite@plt>
    417f:	48 8b 35 e2 15 01 00 	mov    0x115e2(%rip),%rsi        # 15768 <fwp_prog_out>
    4186:	bf 0a 00 00 00       	mov    $0xa,%edi
    418b:	e8 a0 df ff ff       	call   2130 <fputc@plt>
    4190:	4c 89 f0             	mov    %r14,%rax
    4193:	48 2b 05 fe ff 00 00 	sub    0xfffe(%rip),%rax        # 14198 <fwp_gc+0x1030>
    419a:	48 8b 0d 1f 00 01 00 	mov    0x1001f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    41a1:	48 c1 e1 10          	shl    $0x10,%rcx
    41a5:	48 39 c8             	cmp    %rcx,%rax
    41a8:	73 7a                	jae    4224 <fwp_main_thread+0x14c4>
    41aa:	48 8b 0d 2f 00 01 00 	mov    0x1002f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    41b1:	48 89 c2             	mov    %rax,%rdx
    41b4:	48 c1 ea 10          	shr    $0x10,%rdx
    41b8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    41bf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    41c3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    41c9:	75 13                	jne    41de <fwp_main_thread+0x147e>
    41cb:	40 80 fe 02          	cmp    $0x2,%sil
    41cf:	75 0d                	jne    41de <fwp_main_thread+0x147e>
    41d1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    41d5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    41dc:	eb 21                	jmp    41ff <fwp_main_thread+0x149f>
    41de:	40 80 fe 01          	cmp    $0x1,%sil
    41e2:	75 40                	jne    4224 <fwp_main_thread+0x14c4>
    41e4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    41e8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    41ec:	48 0f af c1          	imul   %rcx,%rax
    41f0:	48 c1 e8 20          	shr    $0x20,%rax
    41f4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    41f8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    41ff:	0f b6 07             	movzbl (%rdi),%eax
    4202:	85 c0                	test   %eax,%eax
    4204:	74 1e                	je     4224 <fwp_main_thread+0x14c4>
    4206:	83 f8 01             	cmp    $0x1,%eax
    4209:	75 0a                	jne    4215 <fwp_main_thread+0x14b5>
    420b:	4c 89 f7             	mov    %r14,%rdi
    420e:	e8 bd 6d 00 00       	call   afd0 <fwp_rc_free_obj>
    4213:	eb 0f                	jmp    4224 <fwp_main_thread+0x14c4>
    4215:	3d ff 00 00 00       	cmp    $0xff,%eax
    421a:	0f 84 4e 06 00 00    	je     486e <fwp_main_thread+0x1b0e>
    4220:	fe c8                	dec    %al
    4222:	88 07                	mov    %al,(%rdi)
    4224:	48 8d 35 25 ea 00 00 	lea    0xea25(%rip),%rsi        # 12c50 <d0>
    422b:	31 db                	xor    %ebx,%ebx
    422d:	31 ff                	xor    %edi,%edi
    422f:	e8 9c 2a 00 00       	call   6cd0 <fwp_array_typed_new>
    4234:	49 89 c6             	mov    %rax,%r14
    4237:	31 ff                	xor    %edi,%edi
    4239:	e8 b2 a6 00 00       	call   e8f0 <fwp_drop0>
    423e:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    4245:	ff ff 7f 
    4248:	4c 8d 78 01          	lea    0x1(%rax),%r15
    424c:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    4250:	f2 0f 11 45 d0       	movsd  %xmm0,-0x30(%rbp)
    4255:	45 31 ed             	xor    %r13d,%r13d
    4258:	45 31 e4             	xor    %r12d,%r12d
    425b:	31 ff                	xor    %edi,%edi
    425d:	48 85 db             	test   %rbx,%rbx
    4260:	78 3e                	js     42a0 <fwp_main_thread+0x1540>
    4262:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4269:	1f 84 00 00 00 00 00 
    4270:	49 8b 06             	mov    (%r14),%rax
    4273:	48 89 c1             	mov    %rax,%rcx
    4276:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    427d:	ff ff 7f 
    4280:	48 21 d1             	and    %rdx,%rcx
    4283:	48 39 cb             	cmp    %rcx,%rbx
    4286:	73 18                	jae    42a0 <fwp_main_thread+0x1540>
    4288:	48 85 c0             	test   %rax,%rax
    428b:	78 22                	js     42af <fwp_main_thread+0x154f>
    428d:	49 8d 46 08          	lea    0x8(%r14),%rax
    4291:	eb 20                	jmp    42b3 <fwp_main_thread+0x1553>
    4293:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    429a:	84 00 00 00 00 00 
    42a0:	4c 89 f7             	mov    %r14,%rdi
    42a3:	e8 58 68 00 00       	call   ab00 <fwp_drop1>
    42a8:	31 c0                	xor    %eax,%eax
    42aa:	4c 89 ff             	mov    %r15,%rdi
    42ad:	eb 32                	jmp    42e1 <fwp_main_thread+0x1581>
    42af:	49 8b 46 10          	mov    0x10(%r14),%rax
    42b3:	f2 0f 10 04 d8       	movsd  (%rax,%rbx,8),%xmm0
    42b8:	48 ff c3             	inc    %rbx
    42bb:	f2 0f 59 05 4d ad 00 	mulsd  0xad4d(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    42c2:	00 
    42c3:	f2 0f 58 05 4d ad 00 	addsd  0xad4d(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    42ca:	00 
    42cb:	66 49 0f 6e cf       	movq   %r15,%xmm1
    42d0:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    42d4:	f2 0f 11 4d d0       	movsd  %xmm1,-0x30(%rbp)
    42d9:	b0 01                	mov    $0x1,%al
    42db:	4d 89 f5             	mov    %r14,%r13
    42de:	4d 89 f4             	mov    %r14,%r12
    42e1:	84 c0                	test   %al,%al
    42e3:	74 18                	je     42fd <fwp_main_thread+0x159d>
    42e5:	f3 0f 7e 45 d0       	movq   -0x30(%rbp),%xmm0
    42ea:	66 49 0f 7e c7       	movq   %xmm0,%r15
    42ef:	4d 89 ee             	mov    %r13,%r14
    42f2:	48 85 db             	test   %rbx,%rbx
    42f5:	0f 89 75 ff ff ff    	jns    4270 <fwp_main_thread+0x1510>
    42fb:	eb a3                	jmp    42a0 <fwp_main_thread+0x1540>
    42fd:	48 8d 35 4c e9 00 00 	lea    0xe94c(%rip),%rsi        # 12c50 <d0>
    4304:	e8 87 3a 00 00       	call   7d90 <fwp_show>
    4309:	49 89 c6             	mov    %rax,%r14
    430c:	48 2b 05 85 fe 00 00 	sub    0xfe85(%rip),%rax        # 14198 <fwp_gc+0x1030>
    4313:	48 8b 0d a6 fe 00 00 	mov    0xfea6(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    431a:	48 c1 e1 10          	shl    $0x10,%rcx
    431e:	48 39 c8             	cmp    %rcx,%rax
    4321:	73 6f                	jae    4392 <fwp_main_thread+0x1632>
    4323:	48 8b 0d b6 fe 00 00 	mov    0xfeb6(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    432a:	48 89 c2             	mov    %rax,%rdx
    432d:	48 c1 ea 10          	shr    $0x10,%rdx
    4331:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4338:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    433c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4342:	75 1d                	jne    4361 <fwp_main_thread+0x1601>
    4344:	40 80 fe 02          	cmp    $0x2,%sil
    4348:	75 17                	jne    4361 <fwp_main_thread+0x1601>
    434a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    434e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    4355:	41 80 3f ff          	cmpb   $0xff,(%r15)
    4359:	74 2d                	je     4388 <fwp_main_thread+0x1628>
    435b:	41 c6 07 01          	movb   $0x1,(%r15)
    435f:	eb 31                	jmp    4392 <fwp_main_thread+0x1632>
    4361:	40 80 fe 01          	cmp    $0x1,%sil
    4365:	75 2b                	jne    4392 <fwp_main_thread+0x1632>
    4367:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    436b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    436f:	48 0f af c1          	imul   %rcx,%rax
    4373:	48 c1 e8 20          	shr    $0x20,%rax
    4377:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    437b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    4382:	41 80 3f ff          	cmpb   $0xff,(%r15)
    4386:	75 d3                	jne    435b <fwp_main_thread+0x15fb>
    4388:	4c 89 ff             	mov    %r15,%rdi
    438b:	e8 40 27 00 00       	call   6ad0 <fwp_rc_forget_slot>
    4390:	eb c9                	jmp    435b <fwp_main_thread+0x15fb>
    4392:	4c 89 f7             	mov    %r14,%rdi
    4395:	48 83 c7 08          	add    $0x8,%rdi
    4399:	49 8b 16             	mov    (%r14),%rdx
    439c:	48 8b 0d c5 13 01 00 	mov    0x113c5(%rip),%rcx        # 15768 <fwp_prog_out>
    43a3:	be 01 00 00 00       	mov    $0x1,%esi
    43a8:	e8 d3 de ff ff       	call   2280 <fwrite@plt>
    43ad:	48 8b 35 b4 13 01 00 	mov    0x113b4(%rip),%rsi        # 15768 <fwp_prog_out>
    43b4:	bf 0a 00 00 00       	mov    $0xa,%edi
    43b9:	e8 72 dd ff ff       	call   2130 <fputc@plt>
    43be:	4c 89 f0             	mov    %r14,%rax
    43c1:	48 2b 05 d0 fd 00 00 	sub    0xfdd0(%rip),%rax        # 14198 <fwp_gc+0x1030>
    43c8:	48 8b 0d f1 fd 00 00 	mov    0xfdf1(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    43cf:	48 c1 e1 10          	shl    $0x10,%rcx
    43d3:	48 39 c8             	cmp    %rcx,%rax
    43d6:	73 7a                	jae    4452 <fwp_main_thread+0x16f2>
    43d8:	48 8b 0d 01 fe 00 00 	mov    0xfe01(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    43df:	48 89 c2             	mov    %rax,%rdx
    43e2:	48 c1 ea 10          	shr    $0x10,%rdx
    43e6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    43ed:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    43f1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    43f7:	75 13                	jne    440c <fwp_main_thread+0x16ac>
    43f9:	40 80 fe 02          	cmp    $0x2,%sil
    43fd:	75 0d                	jne    440c <fwp_main_thread+0x16ac>
    43ff:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    4403:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    440a:	eb 21                	jmp    442d <fwp_main_thread+0x16cd>
    440c:	40 80 fe 01          	cmp    $0x1,%sil
    4410:	75 40                	jne    4452 <fwp_main_thread+0x16f2>
    4412:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4416:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    441a:	48 0f af c1          	imul   %rcx,%rax
    441e:	48 c1 e8 20          	shr    $0x20,%rax
    4422:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    4426:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    442d:	0f b6 07             	movzbl (%rdi),%eax
    4430:	85 c0                	test   %eax,%eax
    4432:	74 1e                	je     4452 <fwp_main_thread+0x16f2>
    4434:	83 f8 01             	cmp    $0x1,%eax
    4437:	75 0a                	jne    4443 <fwp_main_thread+0x16e3>
    4439:	4c 89 f7             	mov    %r14,%rdi
    443c:	e8 8f 6b 00 00       	call   afd0 <fwp_rc_free_obj>
    4441:	eb 0f                	jmp    4452 <fwp_main_thread+0x16f2>
    4443:	3d ff 00 00 00       	cmp    $0xff,%eax
    4448:	0f 84 2a 04 00 00    	je     4878 <fwp_main_thread+0x1b18>
    444e:	fe c8                	dec    %al
    4450:	88 07                	mov    %al,(%rdi)
    4452:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    4456:	66 0f 29 85 10 fe ff 	movapd %xmm0,-0x1f0(%rbp)
    445d:	ff 
    445e:	48 8d 95 10 fe ff ff 	lea    -0x1f0(%rbp),%rdx
    4465:	bf 01 00 00 00       	mov    $0x1,%edi
    446a:	be 02 00 00 00       	mov    $0x2,%esi
    446f:	e8 1c 60 00 00       	call   a490 <fwp_data>
    4474:	48 89 c1             	mov    %rax,%rcx
    4477:	48 2b 0d 1a fd 00 00 	sub    0xfd1a(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    447e:	48 8b 15 3b fd 00 00 	mov    0xfd3b(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    4485:	48 c1 e2 10          	shl    $0x10,%rdx
    4489:	48 39 d1             	cmp    %rdx,%rcx
    448c:	73 76                	jae    4504 <fwp_main_thread+0x17a4>
    448e:	48 8b 15 4b fd 00 00 	mov    0xfd4b(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    4495:	48 89 ce             	mov    %rcx,%rsi
    4498:	48 c1 ee 10          	shr    $0x10,%rsi
    449c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    44a3:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    44a7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    44ae:	75 1d                	jne    44cd <fwp_main_thread+0x176d>
    44b0:	40 80 ff 02          	cmp    $0x2,%dil
    44b4:	75 17                	jne    44cd <fwp_main_thread+0x176d>
    44b6:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    44ba:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    44c1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    44c5:	74 2d                	je     44f4 <fwp_main_thread+0x1794>
    44c7:	41 c6 06 01          	movb   $0x1,(%r14)
    44cb:	eb 37                	jmp    4504 <fwp_main_thread+0x17a4>
    44cd:	40 80 ff 01          	cmp    $0x1,%dil
    44d1:	75 31                	jne    4504 <fwp_main_thread+0x17a4>
    44d3:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    44d7:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    44db:	48 0f af ca          	imul   %rdx,%rcx
    44df:	48 c1 e9 20          	shr    $0x20,%rcx
    44e3:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    44e7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    44ee:	41 80 3e ff          	cmpb   $0xff,(%r14)
    44f2:	75 d3                	jne    44c7 <fwp_main_thread+0x1767>
    44f4:	4c 89 f7             	mov    %r14,%rdi
    44f7:	48 89 c3             	mov    %rax,%rbx
    44fa:	e8 d1 25 00 00       	call   6ad0 <fwp_rc_forget_slot>
    44ff:	48 89 d8             	mov    %rbx,%rax
    4502:	eb c3                	jmp    44c7 <fwp_main_thread+0x1767>
    4504:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    450b:	00 00 00 00 
    450f:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    4516:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    451d:	bf 01 00 00 00       	mov    $0x1,%edi
    4522:	be 02 00 00 00       	mov    $0x2,%esi
    4527:	e8 64 5f 00 00       	call   a490 <fwp_data>
    452c:	48 89 c1             	mov    %rax,%rcx
    452f:	48 2b 0d 62 fc 00 00 	sub    0xfc62(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4536:	48 8b 15 83 fc 00 00 	mov    0xfc83(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    453d:	48 c1 e2 10          	shl    $0x10,%rdx
    4541:	48 39 d1             	cmp    %rdx,%rcx
    4544:	73 76                	jae    45bc <fwp_main_thread+0x185c>
    4546:	48 8b 15 93 fc 00 00 	mov    0xfc93(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    454d:	48 89 ce             	mov    %rcx,%rsi
    4550:	48 c1 ee 10          	shr    $0x10,%rsi
    4554:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    455b:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    455f:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4566:	75 1d                	jne    4585 <fwp_main_thread+0x1825>
    4568:	40 80 ff 02          	cmp    $0x2,%dil
    456c:	75 17                	jne    4585 <fwp_main_thread+0x1825>
    456e:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    4572:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    4579:	41 80 3e ff          	cmpb   $0xff,(%r14)
    457d:	74 2d                	je     45ac <fwp_main_thread+0x184c>
    457f:	41 c6 06 01          	movb   $0x1,(%r14)
    4583:	eb 37                	jmp    45bc <fwp_main_thread+0x185c>
    4585:	40 80 ff 01          	cmp    $0x1,%dil
    4589:	75 31                	jne    45bc <fwp_main_thread+0x185c>
    458b:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    458f:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4593:	48 0f af ca          	imul   %rdx,%rcx
    4597:	48 c1 e9 20          	shr    $0x20,%rcx
    459b:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    459f:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    45a6:	41 80 3e ff          	cmpb   $0xff,(%r14)
    45aa:	75 d3                	jne    457f <fwp_main_thread+0x181f>
    45ac:	4c 89 f7             	mov    %r14,%rdi
    45af:	48 89 c3             	mov    %rax,%rbx
    45b2:	e8 19 25 00 00       	call   6ad0 <fwp_rc_forget_slot>
    45b7:	48 89 d8             	mov    %rbx,%rax
    45ba:	eb c3                	jmp    457f <fwp_main_thread+0x181f>
    45bc:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    45c3:	00 
    45c4:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    45c8:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
    45cc:	bf 01 00 00 00       	mov    $0x1,%edi
    45d1:	be 02 00 00 00       	mov    $0x2,%esi
    45d6:	e8 b5 5e 00 00       	call   a490 <fwp_data>
    45db:	48 89 c1             	mov    %rax,%rcx
    45de:	48 2b 0d b3 fb 00 00 	sub    0xfbb3(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    45e5:	48 8b 15 d4 fb 00 00 	mov    0xfbd4(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    45ec:	48 c1 e2 10          	shl    $0x10,%rdx
    45f0:	48 39 d1             	cmp    %rdx,%rcx
    45f3:	73 76                	jae    466b <fwp_main_thread+0x190b>
    45f5:	48 8b 15 e4 fb 00 00 	mov    0xfbe4(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    45fc:	48 89 ce             	mov    %rcx,%rsi
    45ff:	48 c1 ee 10          	shr    $0x10,%rsi
    4603:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    460a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    460e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4615:	75 1d                	jne    4634 <fwp_main_thread+0x18d4>
    4617:	40 80 ff 02          	cmp    $0x2,%dil
    461b:	75 17                	jne    4634 <fwp_main_thread+0x18d4>
    461d:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    4621:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    4628:	41 80 3e ff          	cmpb   $0xff,(%r14)
    462c:	74 2d                	je     465b <fwp_main_thread+0x18fb>
    462e:	41 c6 06 01          	movb   $0x1,(%r14)
    4632:	eb 37                	jmp    466b <fwp_main_thread+0x190b>
    4634:	40 80 ff 01          	cmp    $0x1,%dil
    4638:	75 31                	jne    466b <fwp_main_thread+0x190b>
    463a:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    463e:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4642:	48 0f af ca          	imul   %rdx,%rcx
    4646:	48 c1 e9 20          	shr    $0x20,%rcx
    464a:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    464e:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    4655:	41 80 3e ff          	cmpb   $0xff,(%r14)
    4659:	75 d3                	jne    462e <fwp_main_thread+0x18ce>
    465b:	4c 89 f7             	mov    %r14,%rdi
    465e:	48 89 c3             	mov    %rax,%rbx
    4661:	e8 6a 24 00 00       	call   6ad0 <fwp_rc_forget_slot>
    4666:	48 89 d8             	mov    %rbx,%rax
    4669:	eb c3                	jmp    462e <fwp_main_thread+0x18ce>
    466b:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    4672:	00 
    4673:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    4677:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
    467b:	bf 01 00 00 00       	mov    $0x1,%edi
    4680:	be 02 00 00 00       	mov    $0x2,%esi
    4685:	e8 06 5e 00 00       	call   a490 <fwp_data>
    468a:	48 89 c1             	mov    %rax,%rcx
    468d:	48 2b 0d 04 fb 00 00 	sub    0xfb04(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4694:	48 8b 15 25 fb 00 00 	mov    0xfb25(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    469b:	48 c1 e2 10          	shl    $0x10,%rdx
    469f:	48 39 d1             	cmp    %rdx,%rcx
    46a2:	73 76                	jae    471a <fwp_main_thread+0x19ba>
    46a4:	48 8b 15 35 fb 00 00 	mov    0xfb35(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    46ab:	48 89 ce             	mov    %rcx,%rsi
    46ae:	48 c1 ee 10          	shr    $0x10,%rsi
    46b2:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    46b9:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    46bd:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    46c4:	75 1d                	jne    46e3 <fwp_main_thread+0x1983>
    46c6:	40 80 ff 02          	cmp    $0x2,%dil
    46ca:	75 17                	jne    46e3 <fwp_main_thread+0x1983>
    46cc:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    46d0:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    46d7:	41 80 3e ff          	cmpb   $0xff,(%r14)
    46db:	74 2d                	je     470a <fwp_main_thread+0x19aa>
    46dd:	41 c6 06 01          	movb   $0x1,(%r14)
    46e1:	eb 37                	jmp    471a <fwp_main_thread+0x19ba>
    46e3:	40 80 ff 01          	cmp    $0x1,%dil
    46e7:	75 31                	jne    471a <fwp_main_thread+0x19ba>
    46e9:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    46ed:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    46f1:	48 0f af ca          	imul   %rdx,%rcx
    46f5:	48 c1 e9 20          	shr    $0x20,%rcx
    46f9:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    46fd:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    4704:	41 80 3e ff          	cmpb   $0xff,(%r14)
    4708:	75 d3                	jne    46dd <fwp_main_thread+0x197d>
    470a:	4c 89 f7             	mov    %r14,%rdi
    470d:	48 89 c3             	mov    %rax,%rbx
    4710:	e8 bb 23 00 00       	call   6ad0 <fwp_rc_forget_slot>
    4715:	48 89 d8             	mov    %rbx,%rax
    4718:	eb c3                	jmp    46dd <fwp_main_thread+0x197d>
    471a:	48 89 c1             	mov    %rax,%rcx
    471d:	48 2b 0d 74 fa 00 00 	sub    0xfa74(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4724:	48 8b 15 95 fa 00 00 	mov    0xfa95(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    472b:	48 c1 e2 10          	shl    $0x10,%rdx
    472f:	48 39 d1             	cmp    %rdx,%rcx
    4732:	0f 83 9c 00 00 00    	jae    47d4 <fwp_main_thread+0x1a74>
    4738:	48 8b 15 a1 fa 00 00 	mov    0xfaa1(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    473f:	48 89 ce             	mov    %rcx,%rsi
    4742:	48 c1 ee 10          	shr    $0x10,%rsi
    4746:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    474d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4751:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4758:	75 13                	jne    476d <fwp_main_thread+0x1a0d>
    475a:	40 80 ff 02          	cmp    $0x2,%dil
    475e:	75 0d                	jne    476d <fwp_main_thread+0x1a0d>
    4760:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4764:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    476b:	eb 20                	jmp    478d <fwp_main_thread+0x1a2d>
    476d:	40 80 ff 01          	cmp    $0x1,%dil
    4771:	75 61                	jne    47d4 <fwp_main_thread+0x1a74>
    4773:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4777:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    477b:	48 0f af ca          	imul   %rdx,%rcx
    477f:	48 c1 e9 20          	shr    $0x20,%rcx
    4783:	48 01 cf             	add    %rcx,%rdi
    4786:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    478d:	0f b6 0f             	movzbl (%rdi),%ecx
    4790:	85 c9                	test   %ecx,%ecx
    4792:	74 40                	je     47d4 <fwp_main_thread+0x1a74>
    4794:	83 f9 01             	cmp    $0x1,%ecx
    4797:	75 2f                	jne    47c8 <fwp_main_thread+0x1a68>
    4799:	48 8b 58 10          	mov    0x10(%rax),%rbx
    479d:	48 89 c7             	mov    %rax,%rdi
    47a0:	e8 2b 68 00 00       	call   afd0 <fwp_rc_free_obj>
    47a5:	48 89 d9             	mov    %rbx,%rcx
    47a8:	48 2b 0d e9 f9 00 00 	sub    0xf9e9(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    47af:	48 8b 15 0a fa 00 00 	mov    0xfa0a(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    47b6:	48 c1 e2 10          	shl    $0x10,%rdx
    47ba:	48 89 d8             	mov    %rbx,%rax
    47bd:	48 39 d1             	cmp    %rdx,%rcx
    47c0:	0f 82 72 ff ff ff    	jb     4738 <fwp_main_thread+0x19d8>
    47c6:	eb 0c                	jmp    47d4 <fwp_main_thread+0x1a74>
    47c8:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    47ce:	74 79                	je     4849 <fwp_main_thread+0x1ae9>
    47d0:	fe c9                	dec    %cl
    47d2:	88 0f                	mov    %cl,(%rdi)
    47d4:	c6 05 d5 0f 02 00 01 	movb   $0x1,0x20fd5(%rip)        # 257b0 <caf0.st>
    47db:	48 8b 05 86 e9 00 00 	mov    0xe986(%rip),%rax        # 13168 <fwp_gc>
    47e2:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
    47e6:	48 83 3d 52 fb 00 00 	cmpq   $0x0,0xfb52(%rip)        # 14340 <fwp_gc+0x11d8>
    47ed:	00 
    47ee:	0f 85 ec 00 00 00    	jne    48e0 <fwp_main_thread+0x1b80>
    47f4:	83 3d 5d f9 00 00 00 	cmpl   $0x0,0xf95d(%rip)        # 14158 <fwp_gc+0xff0>
    47fb:	0f 85 df 00 00 00    	jne    48e0 <fwp_main_thread+0x1b80>
    4801:	48 39 c2             	cmp    %rax,%rdx
    4804:	0f 8f d6 00 00 00    	jg     48e0 <fwp_main_thread+0x1b80>
    480a:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    480e:	66 0f 2e 05 5a fb 00 	ucomisd 0xfb5a(%rip),%xmm0        # 14370 <fwp_gc+0x1208>
    4815:	00 
    4816:	0f 83 c4 00 00 00    	jae    48e0 <fwp_main_thread+0x1b80>
    481c:	48 8b 05 9d e7 00 00 	mov    0xe79d(%rip),%rax        # 12fc0 <stdout@GLIBC_2.2.5>
    4823:	48 8b 38             	mov    (%rax),%rdi
    4826:	e8 b5 d9 ff ff       	call   21e0 <fflush@plt>
    482b:	31 c0                	xor    %eax,%eax
    482d:	48 81 c4 c8 01 00 00 	add    $0x1c8,%rsp
    4834:	5b                   	pop    %rbx
    4835:	41 5c                	pop    %r12
    4837:	41 5d                	pop    %r13
    4839:	41 5e                	pop    %r14
    483b:	41 5f                	pop    %r15
    483d:	5d                   	pop    %rbp
    483e:	c3                   	ret
    483f:	e8 ac 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    4844:	e9 cb ef ff ff       	jmp    3814 <fwp_main_thread+0xab4>
    4849:	e8 a2 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    484e:	eb 84                	jmp    47d4 <fwp_main_thread+0x1a74>
    4850:	e8 9b 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    4855:	e9 08 ec ff ff       	jmp    3462 <fwp_main_thread+0x702>
    485a:	e8 91 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    485f:	e9 90 f1 ff ff       	jmp    39f4 <fwp_main_thread+0xc94>
    4864:	e8 87 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    4869:	e9 9b f5 ff ff       	jmp    3e09 <fwp_main_thread+0x10a9>
    486e:	e8 7d 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    4873:	e9 ac f9 ff ff       	jmp    4224 <fwp_main_thread+0x14c4>
    4878:	e8 73 64 00 00       	call   acf0 <fwp_rc_wide_drop>
    487d:	e9 d0 fb ff ff       	jmp    4452 <fwp_main_thread+0x16f2>
    4882:	48 8d 15 a9 ae 00 00 	lea    0xaea9(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    4889:	48 8d 0d ba ad 00 00 	lea    0xadba(%rip),%rcx        # f64a <fwp_segv.msg+0x3ca>
    4890:	eb 0e                	jmp    48a0 <fwp_main_thread+0x1b40>
    4892:	48 8d 15 99 ae 00 00 	lea    0xae99(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    4899:	48 8d 0d ac ae 00 00 	lea    0xaeac(%rip),%rcx        # f74c <fwp_segv.msg+0x4cc>
    48a0:	48 8d 9d 10 fe ff ff 	lea    -0x1f0(%rbp),%rbx
    48a7:	be 60 00 00 00       	mov    $0x60,%esi
    48ac:	48 89 df             	mov    %rbx,%rdi
    48af:	31 c0                	xor    %eax,%eax
    48b1:	e8 4a d8 ff ff       	call   2100 <snprintf@plt>
    48b6:	e8 e5 21 00 00       	call   6aa0 <fwp_flush>
    48bb:	48 8b 05 1e e7 00 00 	mov    0xe71e(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    48c2:	48 8b 38             	mov    (%rax),%rdi
    48c5:	48 8d 35 01 ac 00 00 	lea    0xac01(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    48cc:	48 89 da             	mov    %rbx,%rdx
    48cf:	31 c0                	xor    %eax,%eax
    48d1:	e8 ca d8 ff ff       	call   21a0 <fprintf@plt>
    48d6:	bf 65 00 00 00       	mov    $0x65,%edi
    48db:	e8 90 d9 ff ff       	call   2270 <exit@plt>
    48e0:	48 8b 0d f9 e6 00 00 	mov    0xe6f9(%rip),%rcx        # 12fe0 <stderr@GLIBC_2.2.5>
    48e7:	48 8b 39             	mov    (%rcx),%rdi
    48ea:	48 29 c2             	sub    %rax,%rdx
    48ed:	48 8d 35 b9 ae 00 00 	lea    0xaeb9(%rip),%rsi        # f7ad <fwp_segv.msg+0x52d>
    48f4:	31 c0                	xor    %eax,%eax
    48f6:	e8 a5 d8 ff ff       	call   21a0 <fprintf@plt>
    48fb:	bf c1 00 00 00       	mov    $0xc1,%edi
    4900:	e8 6b d9 ff ff       	call   2270 <exit@plt>
    4905:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    490c:	00 00 00 00 

0000000000004910 <e1>:
    4910:	50                   	push   %rax
    4911:	48 8b 3f             	mov    (%rdi),%rdi
    4914:	48 89 f8             	mov    %rdi,%rax
    4917:	48 2b 05 7a f8 00 00 	sub    0xf87a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    491e:	48 8b 0d 9b f8 00 00 	mov    0xf89b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    4925:	48 c1 e1 10          	shl    $0x10,%rcx
    4929:	48 39 c8             	cmp    %rcx,%rax
    492c:	73 63                	jae    4991 <e1+0x81>
    492e:	48 8b 0d ab f8 00 00 	mov    0xf8ab(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    4935:	48 89 c2             	mov    %rax,%rdx
    4938:	48 c1 ea 10          	shr    $0x10,%rdx
    493c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4943:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4947:	48 25 ff ff 00 00    	and    $0xffff,%rax
    494d:	75 1a                	jne    4969 <e1+0x59>
    494f:	40 80 fe 02          	cmp    $0x2,%sil
    4953:	75 14                	jne    4969 <e1+0x59>
    4955:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4959:	48 05 28 02 00 00    	add    $0x228,%rax
    495f:	80 38 00             	cmpb   $0x0,(%rax)
    4962:	74 2d                	je     4991 <e1+0x81>
    4964:	e9 af 00 00 00       	jmp    4a18 <e1+0x108>
    4969:	40 80 fe 01          	cmp    $0x1,%sil
    496d:	75 22                	jne    4991 <e1+0x81>
    496f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4973:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4977:	48 0f af c1          	imul   %rcx,%rax
    497b:	48 c1 e8 20          	shr    $0x20,%rax
    497f:	48 01 f0             	add    %rsi,%rax
    4982:	48 05 28 02 00 00    	add    $0x228,%rax
    4988:	80 38 00             	cmpb   $0x0,(%rax)
    498b:	0f 85 87 00 00 00    	jne    4a18 <e1+0x108>
    4991:	48 8d 35 b8 e2 00 00 	lea    0xe2b8(%rip),%rsi        # 12c50 <d0>
    4998:	e8 33 22 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    499d:	48 89 c1             	mov    %rax,%rcx
    49a0:	48 2b 0d f1 f7 00 00 	sub    0xf7f1(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    49a7:	48 8b 15 12 f8 00 00 	mov    0xf812(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    49ae:	48 c1 e2 10          	shl    $0x10,%rdx
    49b2:	48 39 d1             	cmp    %rdx,%rcx
    49b5:	73 5f                	jae    4a16 <e1+0x106>
    49b7:	48 8b 15 22 f8 00 00 	mov    0xf822(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    49be:	48 89 ce             	mov    %rcx,%rsi
    49c1:	48 c1 ee 10          	shr    $0x10,%rsi
    49c5:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    49cc:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    49d0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    49d7:	75 18                	jne    49f1 <e1+0xe1>
    49d9:	40 80 ff 02          	cmp    $0x2,%dil
    49dd:	75 12                	jne    49f1 <e1+0xe1>
    49df:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    49e3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    49ea:	80 39 00             	cmpb   $0x0,(%rcx)
    49ed:	74 27                	je     4a16 <e1+0x106>
    49ef:	eb 27                	jmp    4a18 <e1+0x108>
    49f1:	40 80 ff 01          	cmp    $0x1,%dil
    49f5:	75 1f                	jne    4a16 <e1+0x106>
    49f7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    49fb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    49ff:	48 0f af ca          	imul   %rdx,%rcx
    4a03:	48 c1 e9 20          	shr    $0x20,%rcx
    4a07:	48 01 f9             	add    %rdi,%rcx
    4a0a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4a11:	80 39 00             	cmpb   $0x0,(%rcx)
    4a14:	75 02                	jne    4a18 <e1+0x108>
    4a16:	59                   	pop    %rcx
    4a17:	c3                   	ret
    4a18:	e8 83 20 00 00       	call   6aa0 <fwp_flush>
    4a1d:	48 8b 05 bc e5 00 00 	mov    0xe5bc(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    4a24:	48 8b 38             	mov    (%rax),%rdi
    4a27:	48 8d 35 9f aa 00 00 	lea    0xaa9f(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    4a2e:	48 8d 15 6b aa 00 00 	lea    0xaa6b(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    4a35:	31 c0                	xor    %eax,%eax
    4a37:	e8 64 d7 ff ff       	call   21a0 <fprintf@plt>
    4a3c:	bf 65 00 00 00       	mov    $0x65,%edi
    4a41:	e8 2a d8 ff ff       	call   2270 <exit@plt>
    4a46:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4a4d:	00 00 00 

0000000000004a50 <e4>:
    4a50:	50                   	push   %rax
    4a51:	48 8b 3f             	mov    (%rdi),%rdi
    4a54:	48 89 f8             	mov    %rdi,%rax
    4a57:	48 2b 05 3a f7 00 00 	sub    0xf73a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    4a5e:	48 8b 0d 5b f7 00 00 	mov    0xf75b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    4a65:	48 c1 e1 10          	shl    $0x10,%rcx
    4a69:	48 39 c8             	cmp    %rcx,%rax
    4a6c:	73 63                	jae    4ad1 <e4+0x81>
    4a6e:	48 8b 0d 6b f7 00 00 	mov    0xf76b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    4a75:	48 89 c2             	mov    %rax,%rdx
    4a78:	48 c1 ea 10          	shr    $0x10,%rdx
    4a7c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4a83:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4a87:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4a8d:	75 1a                	jne    4aa9 <e4+0x59>
    4a8f:	40 80 fe 02          	cmp    $0x2,%sil
    4a93:	75 14                	jne    4aa9 <e4+0x59>
    4a95:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4a99:	48 05 28 02 00 00    	add    $0x228,%rax
    4a9f:	80 38 00             	cmpb   $0x0,(%rax)
    4aa2:	74 2d                	je     4ad1 <e4+0x81>
    4aa4:	e9 af 00 00 00       	jmp    4b58 <e4+0x108>
    4aa9:	40 80 fe 01          	cmp    $0x1,%sil
    4aad:	75 22                	jne    4ad1 <e4+0x81>
    4aaf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4ab3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4ab7:	48 0f af c1          	imul   %rcx,%rax
    4abb:	48 c1 e8 20          	shr    $0x20,%rax
    4abf:	48 01 f0             	add    %rsi,%rax
    4ac2:	48 05 28 02 00 00    	add    $0x228,%rax
    4ac8:	80 38 00             	cmpb   $0x0,(%rax)
    4acb:	0f 85 87 00 00 00    	jne    4b58 <e4+0x108>
    4ad1:	48 8d 35 d8 e1 00 00 	lea    0xe1d8(%rip),%rsi        # 12cb0 <d1>
    4ad8:	e8 f3 20 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    4add:	48 89 c1             	mov    %rax,%rcx
    4ae0:	48 2b 0d b1 f6 00 00 	sub    0xf6b1(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4ae7:	48 8b 15 d2 f6 00 00 	mov    0xf6d2(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    4aee:	48 c1 e2 10          	shl    $0x10,%rdx
    4af2:	48 39 d1             	cmp    %rdx,%rcx
    4af5:	73 5f                	jae    4b56 <e4+0x106>
    4af7:	48 8b 15 e2 f6 00 00 	mov    0xf6e2(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    4afe:	48 89 ce             	mov    %rcx,%rsi
    4b01:	48 c1 ee 10          	shr    $0x10,%rsi
    4b05:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4b0c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4b10:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4b17:	75 18                	jne    4b31 <e4+0xe1>
    4b19:	40 80 ff 02          	cmp    $0x2,%dil
    4b1d:	75 12                	jne    4b31 <e4+0xe1>
    4b1f:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4b23:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4b2a:	80 39 00             	cmpb   $0x0,(%rcx)
    4b2d:	74 27                	je     4b56 <e4+0x106>
    4b2f:	eb 27                	jmp    4b58 <e4+0x108>
    4b31:	40 80 ff 01          	cmp    $0x1,%dil
    4b35:	75 1f                	jne    4b56 <e4+0x106>
    4b37:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4b3b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4b3f:	48 0f af ca          	imul   %rdx,%rcx
    4b43:	48 c1 e9 20          	shr    $0x20,%rcx
    4b47:	48 01 f9             	add    %rdi,%rcx
    4b4a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4b51:	80 39 00             	cmpb   $0x0,(%rcx)
    4b54:	75 02                	jne    4b58 <e4+0x108>
    4b56:	59                   	pop    %rcx
    4b57:	c3                   	ret
    4b58:	e8 43 1f 00 00       	call   6aa0 <fwp_flush>
    4b5d:	48 8b 05 7c e4 00 00 	mov    0xe47c(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    4b64:	48 8b 38             	mov    (%rax),%rdi
    4b67:	48 8d 35 5f a9 00 00 	lea    0xa95f(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    4b6e:	48 8d 15 2b a9 00 00 	lea    0xa92b(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    4b75:	31 c0                	xor    %eax,%eax
    4b77:	e8 24 d6 ff ff       	call   21a0 <fprintf@plt>
    4b7c:	bf 65 00 00 00       	mov    $0x65,%edi
    4b81:	e8 ea d6 ff ff       	call   2270 <exit@plt>
    4b86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4b8d:	00 00 00 

0000000000004b90 <e9>:
    4b90:	50                   	push   %rax
    4b91:	48 8b 3f             	mov    (%rdi),%rdi
    4b94:	48 89 f8             	mov    %rdi,%rax
    4b97:	48 2b 05 fa f5 00 00 	sub    0xf5fa(%rip),%rax        # 14198 <fwp_gc+0x1030>
    4b9e:	48 8b 0d 1b f6 00 00 	mov    0xf61b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    4ba5:	48 c1 e1 10          	shl    $0x10,%rcx
    4ba9:	48 39 c8             	cmp    %rcx,%rax
    4bac:	73 63                	jae    4c11 <e9+0x81>
    4bae:	48 8b 0d 2b f6 00 00 	mov    0xf62b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    4bb5:	48 89 c2             	mov    %rax,%rdx
    4bb8:	48 c1 ea 10          	shr    $0x10,%rdx
    4bbc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4bc3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4bc7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4bcd:	75 1a                	jne    4be9 <e9+0x59>
    4bcf:	40 80 fe 02          	cmp    $0x2,%sil
    4bd3:	75 14                	jne    4be9 <e9+0x59>
    4bd5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4bd9:	48 05 28 02 00 00    	add    $0x228,%rax
    4bdf:	80 38 00             	cmpb   $0x0,(%rax)
    4be2:	74 2d                	je     4c11 <e9+0x81>
    4be4:	e9 af 00 00 00       	jmp    4c98 <e9+0x108>
    4be9:	40 80 fe 01          	cmp    $0x1,%sil
    4bed:	75 22                	jne    4c11 <e9+0x81>
    4bef:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4bf3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4bf7:	48 0f af c1          	imul   %rcx,%rax
    4bfb:	48 c1 e8 20          	shr    $0x20,%rax
    4bff:	48 01 f0             	add    %rsi,%rax
    4c02:	48 05 28 02 00 00    	add    $0x228,%rax
    4c08:	80 38 00             	cmpb   $0x0,(%rax)
    4c0b:	0f 85 87 00 00 00    	jne    4c98 <e9+0x108>
    4c11:	48 8d 35 f8 e0 00 00 	lea    0xe0f8(%rip),%rsi        # 12d10 <d2>
    4c18:	e8 b3 1f 00 00       	call   6bd0 <fwp_p_array_from_list_typed>
    4c1d:	48 89 c1             	mov    %rax,%rcx
    4c20:	48 2b 0d 71 f5 00 00 	sub    0xf571(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4c27:	48 8b 15 92 f5 00 00 	mov    0xf592(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    4c2e:	48 c1 e2 10          	shl    $0x10,%rdx
    4c32:	48 39 d1             	cmp    %rdx,%rcx
    4c35:	73 5f                	jae    4c96 <e9+0x106>
    4c37:	48 8b 15 a2 f5 00 00 	mov    0xf5a2(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    4c3e:	48 89 ce             	mov    %rcx,%rsi
    4c41:	48 c1 ee 10          	shr    $0x10,%rsi
    4c45:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4c4c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4c50:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4c57:	75 18                	jne    4c71 <e9+0xe1>
    4c59:	40 80 ff 02          	cmp    $0x2,%dil
    4c5d:	75 12                	jne    4c71 <e9+0xe1>
    4c5f:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4c63:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4c6a:	80 39 00             	cmpb   $0x0,(%rcx)
    4c6d:	74 27                	je     4c96 <e9+0x106>
    4c6f:	eb 27                	jmp    4c98 <e9+0x108>
    4c71:	40 80 ff 01          	cmp    $0x1,%dil
    4c75:	75 1f                	jne    4c96 <e9+0x106>
    4c77:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4c7b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4c7f:	48 0f af ca          	imul   %rdx,%rcx
    4c83:	48 c1 e9 20          	shr    $0x20,%rcx
    4c87:	48 01 f9             	add    %rdi,%rcx
    4c8a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4c91:	80 39 00             	cmpb   $0x0,(%rcx)
    4c94:	75 02                	jne    4c98 <e9+0x108>
    4c96:	59                   	pop    %rcx
    4c97:	c3                   	ret
    4c98:	e8 03 1e 00 00       	call   6aa0 <fwp_flush>
    4c9d:	48 8b 05 3c e3 00 00 	mov    0xe33c(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    4ca4:	48 8b 38             	mov    (%rax),%rdi
    4ca7:	48 8d 35 1f a8 00 00 	lea    0xa81f(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    4cae:	48 8d 15 eb a7 00 00 	lea    0xa7eb(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    4cb5:	31 c0                	xor    %eax,%eax
    4cb7:	e8 e4 d4 ff ff       	call   21a0 <fprintf@plt>
    4cbc:	bf 65 00 00 00       	mov    $0x65,%edi
    4cc1:	e8 aa d5 ff ff       	call   2270 <exit@plt>
    4cc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4ccd:	00 00 00 

0000000000004cd0 <e12>:
    4cd0:	50                   	push   %rax
    4cd1:	48 8b 57 10          	mov    0x10(%rdi),%rdx
    4cd5:	48 89 d0             	mov    %rdx,%rax
    4cd8:	48 2b 05 b9 f4 00 00 	sub    0xf4b9(%rip),%rax        # 14198 <fwp_gc+0x1030>
    4cdf:	48 8b 0d da f4 00 00 	mov    0xf4da(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    4ce6:	48 c1 e1 10          	shl    $0x10,%rcx
    4cea:	48 39 c8             	cmp    %rcx,%rax
    4ced:	73 64                	jae    4d53 <e12+0x83>
    4cef:	48 8b 0d ea f4 00 00 	mov    0xf4ea(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    4cf6:	48 89 c6             	mov    %rax,%rsi
    4cf9:	48 c1 ee 10          	shr    $0x10,%rsi
    4cfd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4d04:	44 0f b6 04 31       	movzbl (%rcx,%rsi,1),%r8d
    4d09:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4d0f:	75 1a                	jne    4d2b <e12+0x5b>
    4d11:	41 80 f8 02          	cmp    $0x2,%r8b
    4d15:	75 14                	jne    4d2b <e12+0x5b>
    4d17:	48 8d 04 31          	lea    (%rcx,%rsi,1),%rax
    4d1b:	48 05 28 02 00 00    	add    $0x228,%rax
    4d21:	80 38 00             	cmpb   $0x0,(%rax)
    4d24:	74 2d                	je     4d53 <e12+0x83>
    4d26:	e9 b2 00 00 00       	jmp    4ddd <e12+0x10d>
    4d2b:	41 80 f8 01          	cmp    $0x1,%r8b
    4d2f:	75 22                	jne    4d53 <e12+0x83>
    4d31:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    4d35:	8b 4c 31 20          	mov    0x20(%rcx,%rsi,1),%ecx
    4d39:	48 0f af c1          	imul   %rcx,%rax
    4d3d:	48 c1 e8 20          	shr    $0x20,%rax
    4d41:	4c 01 c0             	add    %r8,%rax
    4d44:	48 05 28 02 00 00    	add    $0x228,%rax
    4d4a:	80 38 00             	cmpb   $0x0,(%rax)
    4d4d:	0f 85 8a 00 00 00    	jne    4ddd <e12+0x10d>
    4d53:	48 8b 07             	mov    (%rdi),%rax
    4d56:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    4d5a:	48 89 c7             	mov    %rax,%rdi
    4d5d:	e8 be 2b 00 00       	call   7920 <f12>
    4d62:	48 89 c1             	mov    %rax,%rcx
    4d65:	48 2b 0d 2c f4 00 00 	sub    0xf42c(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4d6c:	48 8b 15 4d f4 00 00 	mov    0xf44d(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    4d73:	48 c1 e2 10          	shl    $0x10,%rdx
    4d77:	48 39 d1             	cmp    %rdx,%rcx
    4d7a:	73 5f                	jae    4ddb <e12+0x10b>
    4d7c:	48 8b 15 5d f4 00 00 	mov    0xf45d(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    4d83:	48 89 ce             	mov    %rcx,%rsi
    4d86:	48 c1 ee 10          	shr    $0x10,%rsi
    4d8a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4d91:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4d95:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4d9c:	75 18                	jne    4db6 <e12+0xe6>
    4d9e:	40 80 ff 02          	cmp    $0x2,%dil
    4da2:	75 12                	jne    4db6 <e12+0xe6>
    4da4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4da8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4daf:	80 39 00             	cmpb   $0x0,(%rcx)
    4db2:	74 27                	je     4ddb <e12+0x10b>
    4db4:	eb 27                	jmp    4ddd <e12+0x10d>
    4db6:	40 80 ff 01          	cmp    $0x1,%dil
    4dba:	75 1f                	jne    4ddb <e12+0x10b>
    4dbc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4dc0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4dc4:	48 0f af ca          	imul   %rdx,%rcx
    4dc8:	48 c1 e9 20          	shr    $0x20,%rcx
    4dcc:	48 01 f9             	add    %rdi,%rcx
    4dcf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4dd6:	80 39 00             	cmpb   $0x0,(%rcx)
    4dd9:	75 02                	jne    4ddd <e12+0x10d>
    4ddb:	59                   	pop    %rcx
    4ddc:	c3                   	ret
    4ddd:	e8 be 1c 00 00       	call   6aa0 <fwp_flush>
    4de2:	48 8b 05 f7 e1 00 00 	mov    0xe1f7(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    4de9:	48 8b 38             	mov    (%rax),%rdi
    4dec:	48 8d 35 da a6 00 00 	lea    0xa6da(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    4df3:	48 8d 15 a6 a6 00 00 	lea    0xa6a6(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    4dfa:	31 c0                	xor    %eax,%eax
    4dfc:	e8 9f d3 ff ff       	call   21a0 <fprintf@plt>
    4e01:	bf 65 00 00 00       	mov    $0x65,%edi
    4e06:	e8 65 d4 ff ff       	call   2270 <exit@plt>
    4e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004e10 <e15>:
    4e10:	41 56                	push   %r14
    4e12:	53                   	push   %rbx
    4e13:	50                   	push   %rax
    4e14:	48 8b 3f             	mov    (%rdi),%rdi
    4e17:	48 8d 35 f2 de 00 00 	lea    0xdef2(%rip),%rsi        # 12d10 <d2>
    4e1e:	e8 6d 2f 00 00       	call   7d90 <fwp_show>
    4e23:	48 89 c1             	mov    %rax,%rcx
    4e26:	48 2b 0d 6b f3 00 00 	sub    0xf36b(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4e2d:	48 8b 15 8c f3 00 00 	mov    0xf38c(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    4e34:	48 c1 e2 10          	shl    $0x10,%rdx
    4e38:	48 39 d1             	cmp    %rdx,%rcx
    4e3b:	0f 83 8d 00 00 00    	jae    4ece <e15+0xbe>
    4e41:	48 8b 35 98 f3 00 00 	mov    0xf398(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    4e48:	48 89 cf             	mov    %rcx,%rdi
    4e4b:	48 c1 ef 10          	shr    $0x10,%rdi
    4e4f:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4e56:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4e5b:	48 89 cf             	mov    %rcx,%rdi
    4e5e:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4e65:	75 30                	jne    4e97 <e15+0x87>
    4e67:	41 80 f9 02          	cmp    $0x2,%r9b
    4e6b:	75 2a                	jne    4e97 <e15+0x87>
    4e6d:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4e71:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4e78:	80 3b ff             	cmpb   $0xff,(%rbx)
    4e7b:	74 41                	je     4ebe <e15+0xae>
    4e7d:	c6 03 01             	movb   $0x1,(%rbx)
    4e80:	48 8b 15 39 f3 00 00 	mov    0xf339(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    4e87:	48 89 c1             	mov    %rax,%rcx
    4e8a:	48 2b 0d 07 f3 00 00 	sub    0xf307(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    4e91:	48 c1 e2 10          	shl    $0x10,%rdx
    4e95:	eb 37                	jmp    4ece <e15+0xbe>
    4e97:	41 80 f9 01          	cmp    $0x1,%r9b
    4e9b:	75 31                	jne    4ece <e15+0xbe>
    4e9d:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4ea1:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4ea6:	48 0f af fa          	imul   %rdx,%rdi
    4eaa:	48 c1 ef 20          	shr    $0x20,%rdi
    4eae:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4eb2:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4eb9:	80 3b ff             	cmpb   $0xff,(%rbx)
    4ebc:	75 bf                	jne    4e7d <e15+0x6d>
    4ebe:	48 89 df             	mov    %rbx,%rdi
    4ec1:	49 89 c6             	mov    %rax,%r14
    4ec4:	e8 07 1c 00 00       	call   6ad0 <fwp_rc_forget_slot>
    4ec9:	4c 89 f0             	mov    %r14,%rax
    4ecc:	eb af                	jmp    4e7d <e15+0x6d>
    4ece:	48 39 d1             	cmp    %rdx,%rcx
    4ed1:	73 5f                	jae    4f32 <e15+0x122>
    4ed3:	48 8b 15 06 f3 00 00 	mov    0xf306(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    4eda:	48 89 ce             	mov    %rcx,%rsi
    4edd:	48 c1 ee 10          	shr    $0x10,%rsi
    4ee1:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4ee8:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4eec:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4ef3:	75 18                	jne    4f0d <e15+0xfd>
    4ef5:	40 80 ff 02          	cmp    $0x2,%dil
    4ef9:	75 12                	jne    4f0d <e15+0xfd>
    4efb:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4eff:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4f06:	80 39 00             	cmpb   $0x0,(%rcx)
    4f09:	74 27                	je     4f32 <e15+0x122>
    4f0b:	eb 2d                	jmp    4f3a <e15+0x12a>
    4f0d:	40 80 ff 01          	cmp    $0x1,%dil
    4f11:	75 1f                	jne    4f32 <e15+0x122>
    4f13:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4f17:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4f1b:	48 0f af ca          	imul   %rdx,%rcx
    4f1f:	48 c1 e9 20          	shr    $0x20,%rcx
    4f23:	48 01 f9             	add    %rdi,%rcx
    4f26:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4f2d:	80 39 00             	cmpb   $0x0,(%rcx)
    4f30:	75 08                	jne    4f3a <e15+0x12a>
    4f32:	48 83 c4 08          	add    $0x8,%rsp
    4f36:	5b                   	pop    %rbx
    4f37:	41 5e                	pop    %r14
    4f39:	c3                   	ret
    4f3a:	e8 61 1b 00 00       	call   6aa0 <fwp_flush>
    4f3f:	48 8b 05 9a e0 00 00 	mov    0xe09a(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    4f46:	48 8b 38             	mov    (%rax),%rdi
    4f49:	48 8d 35 7d a5 00 00 	lea    0xa57d(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    4f50:	48 8d 15 49 a5 00 00 	lea    0xa549(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    4f57:	31 c0                	xor    %eax,%eax
    4f59:	e8 42 d2 ff ff       	call   21a0 <fprintf@plt>
    4f5e:	bf 65 00 00 00       	mov    $0x65,%edi
    4f63:	e8 08 d3 ff ff       	call   2270 <exit@plt>
    4f68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    4f6f:	00 

0000000000004f70 <e16>:
    4f70:	50                   	push   %rax
    4f71:	48 8b 3f             	mov    (%rdi),%rdi
    4f74:	48 89 f8             	mov    %rdi,%rax
    4f77:	48 2b 05 1a f2 00 00 	sub    0xf21a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    4f7e:	48 8b 0d 3b f2 00 00 	mov    0xf23b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    4f85:	48 c1 e1 10          	shl    $0x10,%rcx
    4f89:	48 39 c8             	cmp    %rcx,%rax
    4f8c:	73 63                	jae    4ff1 <e16+0x81>
    4f8e:	48 8b 0d 4b f2 00 00 	mov    0xf24b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    4f95:	48 89 c2             	mov    %rax,%rdx
    4f98:	48 c1 ea 10          	shr    $0x10,%rdx
    4f9c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4fa3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4fa7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4fad:	75 1a                	jne    4fc9 <e16+0x59>
    4faf:	40 80 fe 02          	cmp    $0x2,%sil
    4fb3:	75 14                	jne    4fc9 <e16+0x59>
    4fb5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4fb9:	48 05 28 02 00 00    	add    $0x228,%rax
    4fbf:	80 38 00             	cmpb   $0x0,(%rax)
    4fc2:	74 2d                	je     4ff1 <e16+0x81>
    4fc4:	e9 ca 00 00 00       	jmp    5093 <e16+0x123>
    4fc9:	40 80 fe 01          	cmp    $0x1,%sil
    4fcd:	75 22                	jne    4ff1 <e16+0x81>
    4fcf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4fd3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4fd7:	48 0f af c1          	imul   %rcx,%rax
    4fdb:	48 c1 e8 20          	shr    $0x20,%rax
    4fdf:	48 01 f0             	add    %rsi,%rax
    4fe2:	48 05 28 02 00 00    	add    $0x228,%rax
    4fe8:	80 38 00             	cmpb   $0x0,(%rax)
    4feb:	0f 85 a2 00 00 00    	jne    5093 <e16+0x123>
    4ff1:	48 8b 17             	mov    (%rdi),%rdx
    4ff4:	48 83 c7 08          	add    $0x8,%rdi
    4ff8:	48 8b 0d 69 07 01 00 	mov    0x10769(%rip),%rcx        # 15768 <fwp_prog_out>
    4fff:	be 01 00 00 00       	mov    $0x1,%esi
    5004:	e8 77 d2 ff ff       	call   2280 <fwrite@plt>
    5009:	48 8b 35 58 07 01 00 	mov    0x10758(%rip),%rsi        # 15768 <fwp_prog_out>
    5010:	bf 0a 00 00 00       	mov    $0xa,%edi
    5015:	e8 16 d1 ff ff       	call   2130 <fputc@plt>
    501a:	31 c0                	xor    %eax,%eax
    501c:	48 2b 05 75 f1 00 00 	sub    0xf175(%rip),%rax        # 14198 <fwp_gc+0x1030>
    5023:	48 8b 0d 96 f1 00 00 	mov    0xf196(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    502a:	48 c1 e1 10          	shl    $0x10,%rcx
    502e:	48 39 c1             	cmp    %rax,%rcx
    5031:	76 5c                	jbe    508f <e16+0x11f>
    5033:	48 8b 0d a6 f1 00 00 	mov    0xf1a6(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    503a:	48 89 c2             	mov    %rax,%rdx
    503d:	48 c1 ea 10          	shr    $0x10,%rdx
    5041:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5048:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    504c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5052:	75 17                	jne    506b <e16+0xfb>
    5054:	40 80 fe 02          	cmp    $0x2,%sil
    5058:	75 11                	jne    506b <e16+0xfb>
    505a:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    505e:	48 05 28 02 00 00    	add    $0x228,%rax
    5064:	80 38 00             	cmpb   $0x0,(%rax)
    5067:	74 26                	je     508f <e16+0x11f>
    5069:	eb 28                	jmp    5093 <e16+0x123>
    506b:	40 80 fe 01          	cmp    $0x1,%sil
    506f:	75 1e                	jne    508f <e16+0x11f>
    5071:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5075:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5079:	48 0f af c1          	imul   %rcx,%rax
    507d:	48 c1 e8 20          	shr    $0x20,%rax
    5081:	48 01 f0             	add    %rsi,%rax
    5084:	48 05 28 02 00 00    	add    $0x228,%rax
    508a:	80 38 00             	cmpb   $0x0,(%rax)
    508d:	75 04                	jne    5093 <e16+0x123>
    508f:	31 c0                	xor    %eax,%eax
    5091:	59                   	pop    %rcx
    5092:	c3                   	ret
    5093:	e8 08 1a 00 00       	call   6aa0 <fwp_flush>
    5098:	48 8b 05 41 df 00 00 	mov    0xdf41(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    509f:	48 8b 38             	mov    (%rax),%rdi
    50a2:	48 8d 35 24 a4 00 00 	lea    0xa424(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    50a9:	48 8d 15 f0 a3 00 00 	lea    0xa3f0(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    50b0:	31 c0                	xor    %eax,%eax
    50b2:	e8 e9 d0 ff ff       	call   21a0 <fprintf@plt>
    50b7:	bf 65 00 00 00       	mov    $0x65,%edi
    50bc:	e8 af d1 ff ff       	call   2270 <exit@plt>
    50c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    50c8:	0f 1f 84 00 00 00 00 
    50cf:	00 

00000000000050d0 <e24>:
    50d0:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    50d4:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    50d9:	0f 58 c8             	addps  %xmm0,%xmm1
    50dc:	66 0f 7e c8          	movd   %xmm1,%eax
    50e0:	48 89 c1             	mov    %rax,%rcx
    50e3:	48 2b 0d ae f0 00 00 	sub    0xf0ae(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    50ea:	48 8b 15 cf f0 00 00 	mov    0xf0cf(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    50f1:	48 c1 e2 10          	shl    $0x10,%rdx
    50f5:	48 39 d1             	cmp    %rdx,%rcx
    50f8:	73 5f                	jae    5159 <e24+0x89>
    50fa:	48 8b 15 df f0 00 00 	mov    0xf0df(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5101:	48 89 ce             	mov    %rcx,%rsi
    5104:	48 c1 ee 10          	shr    $0x10,%rsi
    5108:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    510f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5113:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    511a:	75 18                	jne    5134 <e24+0x64>
    511c:	40 80 ff 02          	cmp    $0x2,%dil
    5120:	75 12                	jne    5134 <e24+0x64>
    5122:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5126:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    512d:	80 39 00             	cmpb   $0x0,(%rcx)
    5130:	74 27                	je     5159 <e24+0x89>
    5132:	eb 26                	jmp    515a <e24+0x8a>
    5134:	40 80 ff 01          	cmp    $0x1,%dil
    5138:	75 1f                	jne    5159 <e24+0x89>
    513a:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    513e:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5142:	48 0f af ca          	imul   %rdx,%rcx
    5146:	48 c1 e9 20          	shr    $0x20,%rcx
    514a:	48 01 f9             	add    %rdi,%rcx
    514d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5154:	80 39 00             	cmpb   $0x0,(%rcx)
    5157:	75 01                	jne    515a <e24+0x8a>
    5159:	c3                   	ret
    515a:	50                   	push   %rax
    515b:	e8 40 19 00 00       	call   6aa0 <fwp_flush>
    5160:	48 8b 05 79 de 00 00 	mov    0xde79(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5167:	48 8b 38             	mov    (%rax),%rdi
    516a:	48 8d 35 5c a3 00 00 	lea    0xa35c(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5171:	48 8d 15 28 a3 00 00 	lea    0xa328(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5178:	31 c0                	xor    %eax,%eax
    517a:	e8 21 d0 ff ff       	call   21a0 <fprintf@plt>
    517f:	bf 65 00 00 00       	mov    $0x65,%edi
    5184:	e8 e7 d0 ff ff       	call   2270 <exit@plt>
    5189:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005190 <e25>:
    5190:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    5194:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    5199:	0f 59 c8             	mulps  %xmm0,%xmm1
    519c:	66 0f 7e c8          	movd   %xmm1,%eax
    51a0:	48 89 c1             	mov    %rax,%rcx
    51a3:	48 2b 0d ee ef 00 00 	sub    0xefee(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    51aa:	48 8b 15 0f f0 00 00 	mov    0xf00f(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    51b1:	48 c1 e2 10          	shl    $0x10,%rdx
    51b5:	48 39 d1             	cmp    %rdx,%rcx
    51b8:	73 5f                	jae    5219 <e25+0x89>
    51ba:	48 8b 15 1f f0 00 00 	mov    0xf01f(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    51c1:	48 89 ce             	mov    %rcx,%rsi
    51c4:	48 c1 ee 10          	shr    $0x10,%rsi
    51c8:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    51cf:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    51d3:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    51da:	75 18                	jne    51f4 <e25+0x64>
    51dc:	40 80 ff 02          	cmp    $0x2,%dil
    51e0:	75 12                	jne    51f4 <e25+0x64>
    51e2:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    51e6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    51ed:	80 39 00             	cmpb   $0x0,(%rcx)
    51f0:	74 27                	je     5219 <e25+0x89>
    51f2:	eb 26                	jmp    521a <e25+0x8a>
    51f4:	40 80 ff 01          	cmp    $0x1,%dil
    51f8:	75 1f                	jne    5219 <e25+0x89>
    51fa:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    51fe:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5202:	48 0f af ca          	imul   %rdx,%rcx
    5206:	48 c1 e9 20          	shr    $0x20,%rcx
    520a:	48 01 f9             	add    %rdi,%rcx
    520d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5214:	80 39 00             	cmpb   $0x0,(%rcx)
    5217:	75 01                	jne    521a <e25+0x8a>
    5219:	c3                   	ret
    521a:	50                   	push   %rax
    521b:	e8 80 18 00 00       	call   6aa0 <fwp_flush>
    5220:	48 8b 05 b9 dd 00 00 	mov    0xddb9(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5227:	48 8b 38             	mov    (%rax),%rdi
    522a:	48 8d 35 9c a2 00 00 	lea    0xa29c(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5231:	48 8d 15 68 a2 00 00 	lea    0xa268(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5238:	31 c0                	xor    %eax,%eax
    523a:	e8 61 cf ff ff       	call   21a0 <fprintf@plt>
    523f:	bf 65 00 00 00       	mov    $0x65,%edi
    5244:	e8 27 d0 ff ff       	call   2270 <exit@plt>
    5249:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005250 <e26>:
    5250:	41 56                	push   %r14
    5252:	53                   	push   %rbx
    5253:	50                   	push   %rax
    5254:	48 8b 3f             	mov    (%rdi),%rdi
    5257:	e8 94 4f 00 00       	call   a1f0 <fwp_show_i64>
    525c:	48 89 c1             	mov    %rax,%rcx
    525f:	48 2b 0d 32 ef 00 00 	sub    0xef32(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5266:	48 8b 15 53 ef 00 00 	mov    0xef53(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    526d:	48 c1 e2 10          	shl    $0x10,%rdx
    5271:	48 39 d1             	cmp    %rdx,%rcx
    5274:	0f 83 8d 00 00 00    	jae    5307 <e26+0xb7>
    527a:	48 8b 35 5f ef 00 00 	mov    0xef5f(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    5281:	48 89 cf             	mov    %rcx,%rdi
    5284:	48 c1 ef 10          	shr    $0x10,%rdi
    5288:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    528f:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    5294:	48 89 cf             	mov    %rcx,%rdi
    5297:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    529e:	75 30                	jne    52d0 <e26+0x80>
    52a0:	41 80 f9 02          	cmp    $0x2,%r9b
    52a4:	75 2a                	jne    52d0 <e26+0x80>
    52a6:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    52aa:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    52b1:	80 3b ff             	cmpb   $0xff,(%rbx)
    52b4:	74 41                	je     52f7 <e26+0xa7>
    52b6:	c6 03 01             	movb   $0x1,(%rbx)
    52b9:	48 8b 15 00 ef 00 00 	mov    0xef00(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    52c0:	48 89 c1             	mov    %rax,%rcx
    52c3:	48 2b 0d ce ee 00 00 	sub    0xeece(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    52ca:	48 c1 e2 10          	shl    $0x10,%rdx
    52ce:	eb 37                	jmp    5307 <e26+0xb7>
    52d0:	41 80 f9 01          	cmp    $0x1,%r9b
    52d4:	75 31                	jne    5307 <e26+0xb7>
    52d6:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    52da:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    52df:	48 0f af fa          	imul   %rdx,%rdi
    52e3:	48 c1 ef 20          	shr    $0x20,%rdi
    52e7:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    52eb:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    52f2:	80 3b ff             	cmpb   $0xff,(%rbx)
    52f5:	75 bf                	jne    52b6 <e26+0x66>
    52f7:	48 89 df             	mov    %rbx,%rdi
    52fa:	49 89 c6             	mov    %rax,%r14
    52fd:	e8 ce 17 00 00       	call   6ad0 <fwp_rc_forget_slot>
    5302:	4c 89 f0             	mov    %r14,%rax
    5305:	eb af                	jmp    52b6 <e26+0x66>
    5307:	48 39 d1             	cmp    %rdx,%rcx
    530a:	73 5f                	jae    536b <e26+0x11b>
    530c:	48 8b 15 cd ee 00 00 	mov    0xeecd(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5313:	48 89 ce             	mov    %rcx,%rsi
    5316:	48 c1 ee 10          	shr    $0x10,%rsi
    531a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5321:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5325:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    532c:	75 18                	jne    5346 <e26+0xf6>
    532e:	40 80 ff 02          	cmp    $0x2,%dil
    5332:	75 12                	jne    5346 <e26+0xf6>
    5334:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5338:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    533f:	80 39 00             	cmpb   $0x0,(%rcx)
    5342:	74 27                	je     536b <e26+0x11b>
    5344:	eb 2d                	jmp    5373 <e26+0x123>
    5346:	40 80 ff 01          	cmp    $0x1,%dil
    534a:	75 1f                	jne    536b <e26+0x11b>
    534c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5350:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5354:	48 0f af ca          	imul   %rdx,%rcx
    5358:	48 c1 e9 20          	shr    $0x20,%rcx
    535c:	48 01 f9             	add    %rdi,%rcx
    535f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5366:	80 39 00             	cmpb   $0x0,(%rcx)
    5369:	75 08                	jne    5373 <e26+0x123>
    536b:	48 83 c4 08          	add    $0x8,%rsp
    536f:	5b                   	pop    %rbx
    5370:	41 5e                	pop    %r14
    5372:	c3                   	ret
    5373:	e8 28 17 00 00       	call   6aa0 <fwp_flush>
    5378:	48 8b 05 61 dc 00 00 	mov    0xdc61(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    537f:	48 8b 38             	mov    (%rax),%rdi
    5382:	48 8d 35 44 a1 00 00 	lea    0xa144(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5389:	48 8d 15 10 a1 00 00 	lea    0xa110(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5390:	31 c0                	xor    %eax,%eax
    5392:	e8 09 ce ff ff       	call   21a0 <fprintf@plt>
    5397:	bf 65 00 00 00       	mov    $0x65,%edi
    539c:	e8 cf ce ff ff       	call   2270 <exit@plt>
    53a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    53a8:	0f 1f 84 00 00 00 00 
    53af:	00 

00000000000053b0 <e32>:
    53b0:	53                   	push   %rbx
    53b1:	48 83 ec 60          	sub    $0x60,%rsp
    53b5:	48 8b 47 08          	mov    0x8(%rdi),%rax
    53b9:	48 03 07             	add    (%rdi),%rax
    53bc:	48 0f be c8          	movsbq %al,%rcx
    53c0:	48 39 c1             	cmp    %rax,%rcx
    53c3:	75 7f                	jne    5444 <e32+0x94>
    53c5:	48 89 c1             	mov    %rax,%rcx
    53c8:	48 2b 0d c9 ed 00 00 	sub    0xedc9(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    53cf:	48 8b 15 ea ed 00 00 	mov    0xedea(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    53d6:	48 c1 e2 10          	shl    $0x10,%rdx
    53da:	48 39 d1             	cmp    %rdx,%rcx
    53dd:	73 5f                	jae    543e <e32+0x8e>
    53df:	48 8b 15 fa ed 00 00 	mov    0xedfa(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    53e6:	48 89 ce             	mov    %rcx,%rsi
    53e9:	48 c1 ee 10          	shr    $0x10,%rsi
    53ed:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    53f4:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    53f8:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    53ff:	75 18                	jne    5419 <e32+0x69>
    5401:	40 80 ff 02          	cmp    $0x2,%dil
    5405:	75 12                	jne    5419 <e32+0x69>
    5407:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    540b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5412:	80 39 00             	cmpb   $0x0,(%rcx)
    5415:	74 27                	je     543e <e32+0x8e>
    5417:	eb 66                	jmp    547f <e32+0xcf>
    5419:	40 80 ff 01          	cmp    $0x1,%dil
    541d:	75 1f                	jne    543e <e32+0x8e>
    541f:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5423:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5427:	48 0f af ca          	imul   %rdx,%rcx
    542b:	48 c1 e9 20          	shr    $0x20,%rcx
    542f:	48 01 f9             	add    %rdi,%rcx
    5432:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5439:	80 39 00             	cmpb   $0x0,(%rcx)
    543c:	75 41                	jne    547f <e32+0xcf>
    543e:	48 83 c4 60          	add    $0x60,%rsp
    5442:	5b                   	pop    %rbx
    5443:	c3                   	ret
    5444:	48 8d 15 e7 a2 00 00 	lea    0xa2e7(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    544b:	48 8d 0d f8 a1 00 00 	lea    0xa1f8(%rip),%rcx        # f64a <fwp_segv.msg+0x3ca>
    5452:	48 89 e3             	mov    %rsp,%rbx
    5455:	be 60 00 00 00       	mov    $0x60,%esi
    545a:	48 89 df             	mov    %rbx,%rdi
    545d:	31 c0                	xor    %eax,%eax
    545f:	e8 9c cc ff ff       	call   2100 <snprintf@plt>
    5464:	e8 37 16 00 00       	call   6aa0 <fwp_flush>
    5469:	48 8b 05 70 db 00 00 	mov    0xdb70(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5470:	48 8b 38             	mov    (%rax),%rdi
    5473:	48 8d 35 53 a0 00 00 	lea    0xa053(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    547a:	48 89 da             	mov    %rbx,%rdx
    547d:	eb 1d                	jmp    549c <e32+0xec>
    547f:	e8 1c 16 00 00       	call   6aa0 <fwp_flush>
    5484:	48 8b 05 55 db 00 00 	mov    0xdb55(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    548b:	48 8b 38             	mov    (%rax),%rdi
    548e:	48 8d 35 38 a0 00 00 	lea    0xa038(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5495:	48 8d 15 04 a0 00 00 	lea    0xa004(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    549c:	31 c0                	xor    %eax,%eax
    549e:	e8 fd cc ff ff       	call   21a0 <fprintf@plt>
    54a3:	bf 65 00 00 00       	mov    $0x65,%edi
    54a8:	e8 c3 cd ff ff       	call   2270 <exit@plt>
    54ad:	0f 1f 00             	nopl   (%rax)

00000000000054b0 <e33>:
    54b0:	41 56                	push   %r14
    54b2:	53                   	push   %rbx
    54b3:	50                   	push   %rax
    54b4:	48 8b 3f             	mov    (%rdi),%rdi
    54b7:	e8 34 4d 00 00       	call   a1f0 <fwp_show_i64>
    54bc:	48 89 c1             	mov    %rax,%rcx
    54bf:	48 2b 0d d2 ec 00 00 	sub    0xecd2(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    54c6:	48 8b 15 f3 ec 00 00 	mov    0xecf3(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    54cd:	48 c1 e2 10          	shl    $0x10,%rdx
    54d1:	48 39 d1             	cmp    %rdx,%rcx
    54d4:	0f 83 8d 00 00 00    	jae    5567 <e33+0xb7>
    54da:	48 8b 35 ff ec 00 00 	mov    0xecff(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    54e1:	48 89 cf             	mov    %rcx,%rdi
    54e4:	48 c1 ef 10          	shr    $0x10,%rdi
    54e8:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    54ef:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    54f4:	48 89 cf             	mov    %rcx,%rdi
    54f7:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    54fe:	75 30                	jne    5530 <e33+0x80>
    5500:	41 80 f9 02          	cmp    $0x2,%r9b
    5504:	75 2a                	jne    5530 <e33+0x80>
    5506:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    550a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    5511:	80 3b ff             	cmpb   $0xff,(%rbx)
    5514:	74 41                	je     5557 <e33+0xa7>
    5516:	c6 03 01             	movb   $0x1,(%rbx)
    5519:	48 8b 15 a0 ec 00 00 	mov    0xeca0(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5520:	48 89 c1             	mov    %rax,%rcx
    5523:	48 2b 0d 6e ec 00 00 	sub    0xec6e(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    552a:	48 c1 e2 10          	shl    $0x10,%rdx
    552e:	eb 37                	jmp    5567 <e33+0xb7>
    5530:	41 80 f9 01          	cmp    $0x1,%r9b
    5534:	75 31                	jne    5567 <e33+0xb7>
    5536:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    553a:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    553f:	48 0f af fa          	imul   %rdx,%rdi
    5543:	48 c1 ef 20          	shr    $0x20,%rdi
    5547:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    554b:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    5552:	80 3b ff             	cmpb   $0xff,(%rbx)
    5555:	75 bf                	jne    5516 <e33+0x66>
    5557:	48 89 df             	mov    %rbx,%rdi
    555a:	49 89 c6             	mov    %rax,%r14
    555d:	e8 6e 15 00 00       	call   6ad0 <fwp_rc_forget_slot>
    5562:	4c 89 f0             	mov    %r14,%rax
    5565:	eb af                	jmp    5516 <e33+0x66>
    5567:	48 39 d1             	cmp    %rdx,%rcx
    556a:	73 5f                	jae    55cb <e33+0x11b>
    556c:	48 8b 15 6d ec 00 00 	mov    0xec6d(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5573:	48 89 ce             	mov    %rcx,%rsi
    5576:	48 c1 ee 10          	shr    $0x10,%rsi
    557a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5581:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5585:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    558c:	75 18                	jne    55a6 <e33+0xf6>
    558e:	40 80 ff 02          	cmp    $0x2,%dil
    5592:	75 12                	jne    55a6 <e33+0xf6>
    5594:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5598:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    559f:	80 39 00             	cmpb   $0x0,(%rcx)
    55a2:	74 27                	je     55cb <e33+0x11b>
    55a4:	eb 2d                	jmp    55d3 <e33+0x123>
    55a6:	40 80 ff 01          	cmp    $0x1,%dil
    55aa:	75 1f                	jne    55cb <e33+0x11b>
    55ac:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    55b0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    55b4:	48 0f af ca          	imul   %rdx,%rcx
    55b8:	48 c1 e9 20          	shr    $0x20,%rcx
    55bc:	48 01 f9             	add    %rdi,%rcx
    55bf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    55c6:	80 39 00             	cmpb   $0x0,(%rcx)
    55c9:	75 08                	jne    55d3 <e33+0x123>
    55cb:	48 83 c4 08          	add    $0x8,%rsp
    55cf:	5b                   	pop    %rbx
    55d0:	41 5e                	pop    %r14
    55d2:	c3                   	ret
    55d3:	e8 c8 14 00 00       	call   6aa0 <fwp_flush>
    55d8:	48 8b 05 01 da 00 00 	mov    0xda01(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    55df:	48 8b 38             	mov    (%rax),%rdi
    55e2:	48 8d 35 e4 9e 00 00 	lea    0x9ee4(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    55e9:	48 8d 15 b0 9e 00 00 	lea    0x9eb0(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    55f0:	31 c0                	xor    %eax,%eax
    55f2:	e8 a9 cb ff ff       	call   21a0 <fprintf@plt>
    55f7:	bf 65 00 00 00       	mov    $0x65,%edi
    55fc:	e8 6f cc ff ff       	call   2270 <exit@plt>
    5601:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5608:	0f 1f 84 00 00 00 00 
    560f:	00 

0000000000005610 <e37>:
    5610:	41 56                	push   %r14
    5612:	53                   	push   %rbx
    5613:	50                   	push   %rax
    5614:	48 8b 3f             	mov    (%rdi),%rdi
    5617:	48 8d 35 32 d6 00 00 	lea    0xd632(%rip),%rsi        # 12c50 <d0>
    561e:	e8 6d 27 00 00       	call   7d90 <fwp_show>
    5623:	48 89 c1             	mov    %rax,%rcx
    5626:	48 2b 0d 6b eb 00 00 	sub    0xeb6b(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    562d:	48 8b 15 8c eb 00 00 	mov    0xeb8c(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5634:	48 c1 e2 10          	shl    $0x10,%rdx
    5638:	48 39 d1             	cmp    %rdx,%rcx
    563b:	0f 83 8d 00 00 00    	jae    56ce <e37+0xbe>
    5641:	48 8b 35 98 eb 00 00 	mov    0xeb98(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    5648:	48 89 cf             	mov    %rcx,%rdi
    564b:	48 c1 ef 10          	shr    $0x10,%rdi
    564f:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    5656:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    565b:	48 89 cf             	mov    %rcx,%rdi
    565e:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    5665:	75 30                	jne    5697 <e37+0x87>
    5667:	41 80 f9 02          	cmp    $0x2,%r9b
    566b:	75 2a                	jne    5697 <e37+0x87>
    566d:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    5671:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    5678:	80 3b ff             	cmpb   $0xff,(%rbx)
    567b:	74 41                	je     56be <e37+0xae>
    567d:	c6 03 01             	movb   $0x1,(%rbx)
    5680:	48 8b 15 39 eb 00 00 	mov    0xeb39(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5687:	48 89 c1             	mov    %rax,%rcx
    568a:	48 2b 0d 07 eb 00 00 	sub    0xeb07(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5691:	48 c1 e2 10          	shl    $0x10,%rdx
    5695:	eb 37                	jmp    56ce <e37+0xbe>
    5697:	41 80 f9 01          	cmp    $0x1,%r9b
    569b:	75 31                	jne    56ce <e37+0xbe>
    569d:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    56a1:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    56a6:	48 0f af fa          	imul   %rdx,%rdi
    56aa:	48 c1 ef 20          	shr    $0x20,%rdi
    56ae:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    56b2:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    56b9:	80 3b ff             	cmpb   $0xff,(%rbx)
    56bc:	75 bf                	jne    567d <e37+0x6d>
    56be:	48 89 df             	mov    %rbx,%rdi
    56c1:	49 89 c6             	mov    %rax,%r14
    56c4:	e8 07 14 00 00       	call   6ad0 <fwp_rc_forget_slot>
    56c9:	4c 89 f0             	mov    %r14,%rax
    56cc:	eb af                	jmp    567d <e37+0x6d>
    56ce:	48 39 d1             	cmp    %rdx,%rcx
    56d1:	73 5f                	jae    5732 <e37+0x122>
    56d3:	48 8b 15 06 eb 00 00 	mov    0xeb06(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    56da:	48 89 ce             	mov    %rcx,%rsi
    56dd:	48 c1 ee 10          	shr    $0x10,%rsi
    56e1:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    56e8:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    56ec:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    56f3:	75 18                	jne    570d <e37+0xfd>
    56f5:	40 80 ff 02          	cmp    $0x2,%dil
    56f9:	75 12                	jne    570d <e37+0xfd>
    56fb:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    56ff:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5706:	80 39 00             	cmpb   $0x0,(%rcx)
    5709:	74 27                	je     5732 <e37+0x122>
    570b:	eb 2d                	jmp    573a <e37+0x12a>
    570d:	40 80 ff 01          	cmp    $0x1,%dil
    5711:	75 1f                	jne    5732 <e37+0x122>
    5713:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5717:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    571b:	48 0f af ca          	imul   %rdx,%rcx
    571f:	48 c1 e9 20          	shr    $0x20,%rcx
    5723:	48 01 f9             	add    %rdi,%rcx
    5726:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    572d:	80 39 00             	cmpb   $0x0,(%rcx)
    5730:	75 08                	jne    573a <e37+0x12a>
    5732:	48 83 c4 08          	add    $0x8,%rsp
    5736:	5b                   	pop    %rbx
    5737:	41 5e                	pop    %r14
    5739:	c3                   	ret
    573a:	e8 61 13 00 00       	call   6aa0 <fwp_flush>
    573f:	48 8b 05 9a d8 00 00 	mov    0xd89a(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5746:	48 8b 38             	mov    (%rax),%rdi
    5749:	48 8d 35 7d 9d 00 00 	lea    0x9d7d(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5750:	48 8d 15 49 9d 00 00 	lea    0x9d49(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5757:	31 c0                	xor    %eax,%eax
    5759:	e8 42 ca ff ff       	call   21a0 <fprintf@plt>
    575e:	bf 65 00 00 00       	mov    $0x65,%edi
    5763:	e8 08 cb ff ff       	call   2270 <exit@plt>
    5768:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    576f:	00 

0000000000005770 <e45>:
    5770:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    5774:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    5779:	66 48 0f 7e c0       	movq   %xmm0,%rax
    577e:	48 89 c1             	mov    %rax,%rcx
    5781:	48 2b 0d 10 ea 00 00 	sub    0xea10(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5788:	48 8b 15 31 ea 00 00 	mov    0xea31(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    578f:	48 c1 e2 10          	shl    $0x10,%rdx
    5793:	48 39 d1             	cmp    %rdx,%rcx
    5796:	73 5f                	jae    57f7 <e45+0x87>
    5798:	48 8b 15 41 ea 00 00 	mov    0xea41(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    579f:	48 89 ce             	mov    %rcx,%rsi
    57a2:	48 c1 ee 10          	shr    $0x10,%rsi
    57a6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    57ad:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    57b1:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    57b8:	75 18                	jne    57d2 <e45+0x62>
    57ba:	40 80 ff 02          	cmp    $0x2,%dil
    57be:	75 12                	jne    57d2 <e45+0x62>
    57c0:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    57c4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    57cb:	80 39 00             	cmpb   $0x0,(%rcx)
    57ce:	74 27                	je     57f7 <e45+0x87>
    57d0:	eb 26                	jmp    57f8 <e45+0x88>
    57d2:	40 80 ff 01          	cmp    $0x1,%dil
    57d6:	75 1f                	jne    57f7 <e45+0x87>
    57d8:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    57dc:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    57e0:	48 0f af ca          	imul   %rdx,%rcx
    57e4:	48 c1 e9 20          	shr    $0x20,%rcx
    57e8:	48 01 f9             	add    %rdi,%rcx
    57eb:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    57f2:	80 39 00             	cmpb   $0x0,(%rcx)
    57f5:	75 01                	jne    57f8 <e45+0x88>
    57f7:	c3                   	ret
    57f8:	50                   	push   %rax
    57f9:	e8 a2 12 00 00       	call   6aa0 <fwp_flush>
    57fe:	48 8b 05 db d7 00 00 	mov    0xd7db(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5805:	48 8b 38             	mov    (%rax),%rdi
    5808:	48 8d 35 be 9c 00 00 	lea    0x9cbe(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    580f:	48 8d 15 8a 9c 00 00 	lea    0x9c8a(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5816:	31 c0                	xor    %eax,%eax
    5818:	e8 83 c9 ff ff       	call   21a0 <fprintf@plt>
    581d:	bf 65 00 00 00       	mov    $0x65,%edi
    5822:	e8 49 ca ff ff       	call   2270 <exit@plt>
    5827:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    582e:	00 00 

0000000000005830 <e46>:
    5830:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    5834:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    5839:	66 48 0f 7e c0       	movq   %xmm0,%rax
    583e:	48 89 c1             	mov    %rax,%rcx
    5841:	48 2b 0d 50 e9 00 00 	sub    0xe950(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5848:	48 8b 15 71 e9 00 00 	mov    0xe971(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    584f:	48 c1 e2 10          	shl    $0x10,%rdx
    5853:	48 39 d1             	cmp    %rdx,%rcx
    5856:	73 5f                	jae    58b7 <e46+0x87>
    5858:	48 8b 15 81 e9 00 00 	mov    0xe981(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    585f:	48 89 ce             	mov    %rcx,%rsi
    5862:	48 c1 ee 10          	shr    $0x10,%rsi
    5866:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    586d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5871:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5878:	75 18                	jne    5892 <e46+0x62>
    587a:	40 80 ff 02          	cmp    $0x2,%dil
    587e:	75 12                	jne    5892 <e46+0x62>
    5880:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5884:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    588b:	80 39 00             	cmpb   $0x0,(%rcx)
    588e:	74 27                	je     58b7 <e46+0x87>
    5890:	eb 26                	jmp    58b8 <e46+0x88>
    5892:	40 80 ff 01          	cmp    $0x1,%dil
    5896:	75 1f                	jne    58b7 <e46+0x87>
    5898:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    589c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    58a0:	48 0f af ca          	imul   %rdx,%rcx
    58a4:	48 c1 e9 20          	shr    $0x20,%rcx
    58a8:	48 01 f9             	add    %rdi,%rcx
    58ab:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    58b2:	80 39 00             	cmpb   $0x0,(%rcx)
    58b5:	75 01                	jne    58b8 <e46+0x88>
    58b7:	c3                   	ret
    58b8:	50                   	push   %rax
    58b9:	e8 e2 11 00 00       	call   6aa0 <fwp_flush>
    58be:	48 8b 05 1b d7 00 00 	mov    0xd71b(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    58c5:	48 8b 38             	mov    (%rax),%rdi
    58c8:	48 8d 35 fe 9b 00 00 	lea    0x9bfe(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    58cf:	48 8d 15 ca 9b 00 00 	lea    0x9bca(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    58d6:	31 c0                	xor    %eax,%eax
    58d8:	e8 c3 c8 ff ff       	call   21a0 <fprintf@plt>
    58dd:	bf 65 00 00 00       	mov    $0x65,%edi
    58e2:	e8 89 c9 ff ff       	call   2270 <exit@plt>
    58e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    58ee:	00 00 

00000000000058f0 <e47>:
    58f0:	50                   	push   %rax
    58f1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    58f5:	48 89 f0             	mov    %rsi,%rax
    58f8:	48 2b 05 99 e8 00 00 	sub    0xe899(%rip),%rax        # 14198 <fwp_gc+0x1030>
    58ff:	48 8b 0d ba e8 00 00 	mov    0xe8ba(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    5906:	48 c1 e1 10          	shl    $0x10,%rcx
    590a:	48 39 c8             	cmp    %rcx,%rax
    590d:	73 64                	jae    5973 <e47+0x83>
    590f:	48 8b 0d ca e8 00 00 	mov    0xe8ca(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    5916:	48 89 c2             	mov    %rax,%rdx
    5919:	48 c1 ea 10          	shr    $0x10,%rdx
    591d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5924:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5929:	48 25 ff ff 00 00    	and    $0xffff,%rax
    592f:	75 1a                	jne    594b <e47+0x5b>
    5931:	41 80 f8 02          	cmp    $0x2,%r8b
    5935:	75 14                	jne    594b <e47+0x5b>
    5937:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    593b:	48 05 28 02 00 00    	add    $0x228,%rax
    5941:	80 38 00             	cmpb   $0x0,(%rax)
    5944:	74 2d                	je     5973 <e47+0x83>
    5946:	e9 b2 00 00 00       	jmp    59fd <e47+0x10d>
    594b:	41 80 f8 01          	cmp    $0x1,%r8b
    594f:	75 22                	jne    5973 <e47+0x83>
    5951:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5955:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5959:	48 0f af c1          	imul   %rcx,%rax
    595d:	48 c1 e8 20          	shr    $0x20,%rax
    5961:	4c 01 c0             	add    %r8,%rax
    5964:	48 05 28 02 00 00    	add    $0x228,%rax
    596a:	80 38 00             	cmpb   $0x0,(%rax)
    596d:	0f 85 8a 00 00 00    	jne    59fd <e47+0x10d>
    5973:	48 8b 3f             	mov    (%rdi),%rdi
    5976:	48 8d 15 d3 d2 00 00 	lea    0xd2d3(%rip),%rdx        # 12c50 <d0>
    597d:	e8 be 49 00 00       	call   a340 <fwp_p_array_get_typed>
    5982:	48 89 c1             	mov    %rax,%rcx
    5985:	48 2b 0d 0c e8 00 00 	sub    0xe80c(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    598c:	48 8b 15 2d e8 00 00 	mov    0xe82d(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5993:	48 c1 e2 10          	shl    $0x10,%rdx
    5997:	48 39 d1             	cmp    %rdx,%rcx
    599a:	73 5f                	jae    59fb <e47+0x10b>
    599c:	48 8b 15 3d e8 00 00 	mov    0xe83d(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    59a3:	48 89 ce             	mov    %rcx,%rsi
    59a6:	48 c1 ee 10          	shr    $0x10,%rsi
    59aa:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    59b1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    59b5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    59bc:	75 18                	jne    59d6 <e47+0xe6>
    59be:	40 80 ff 02          	cmp    $0x2,%dil
    59c2:	75 12                	jne    59d6 <e47+0xe6>
    59c4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    59c8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    59cf:	80 39 00             	cmpb   $0x0,(%rcx)
    59d2:	74 27                	je     59fb <e47+0x10b>
    59d4:	eb 27                	jmp    59fd <e47+0x10d>
    59d6:	40 80 ff 01          	cmp    $0x1,%dil
    59da:	75 1f                	jne    59fb <e47+0x10b>
    59dc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    59e0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    59e4:	48 0f af ca          	imul   %rdx,%rcx
    59e8:	48 c1 e9 20          	shr    $0x20,%rcx
    59ec:	48 01 f9             	add    %rdi,%rcx
    59ef:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    59f6:	80 39 00             	cmpb   $0x0,(%rcx)
    59f9:	75 02                	jne    59fd <e47+0x10d>
    59fb:	59                   	pop    %rcx
    59fc:	c3                   	ret
    59fd:	e8 9e 10 00 00       	call   6aa0 <fwp_flush>
    5a02:	48 8b 05 d7 d5 00 00 	mov    0xd5d7(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5a09:	48 8b 38             	mov    (%rax),%rdi
    5a0c:	48 8d 35 ba 9a 00 00 	lea    0x9aba(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5a13:	48 8d 15 86 9a 00 00 	lea    0x9a86(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5a1a:	31 c0                	xor    %eax,%eax
    5a1c:	e8 7f c7 ff ff       	call   21a0 <fprintf@plt>
    5a21:	bf 65 00 00 00       	mov    $0x65,%edi
    5a26:	e8 45 c8 ff ff       	call   2270 <exit@plt>
    5a2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005a30 <e48>:
    5a30:	53                   	push   %rbx
    5a31:	48 83 ec 60          	sub    $0x60,%rsp
    5a35:	48 8b 47 08          	mov    0x8(%rdi),%rax
    5a39:	48 03 07             	add    (%rdi),%rax
    5a3c:	70 7f                	jo     5abd <e48+0x8d>
    5a3e:	48 89 c1             	mov    %rax,%rcx
    5a41:	48 2b 0d 50 e7 00 00 	sub    0xe750(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5a48:	48 8b 15 71 e7 00 00 	mov    0xe771(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5a4f:	48 c1 e2 10          	shl    $0x10,%rdx
    5a53:	48 39 d1             	cmp    %rdx,%rcx
    5a56:	73 5f                	jae    5ab7 <e48+0x87>
    5a58:	48 8b 15 81 e7 00 00 	mov    0xe781(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5a5f:	48 89 ce             	mov    %rcx,%rsi
    5a62:	48 c1 ee 10          	shr    $0x10,%rsi
    5a66:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5a6d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5a71:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5a78:	75 18                	jne    5a92 <e48+0x62>
    5a7a:	40 80 ff 02          	cmp    $0x2,%dil
    5a7e:	75 12                	jne    5a92 <e48+0x62>
    5a80:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5a84:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5a8b:	80 39 00             	cmpb   $0x0,(%rcx)
    5a8e:	74 27                	je     5ab7 <e48+0x87>
    5a90:	eb 66                	jmp    5af8 <e48+0xc8>
    5a92:	40 80 ff 01          	cmp    $0x1,%dil
    5a96:	75 1f                	jne    5ab7 <e48+0x87>
    5a98:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5a9c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5aa0:	48 0f af ca          	imul   %rdx,%rcx
    5aa4:	48 c1 e9 20          	shr    $0x20,%rcx
    5aa8:	48 01 f9             	add    %rdi,%rcx
    5aab:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5ab2:	80 39 00             	cmpb   $0x0,(%rcx)
    5ab5:	75 41                	jne    5af8 <e48+0xc8>
    5ab7:	48 83 c4 60          	add    $0x60,%rsp
    5abb:	5b                   	pop    %rbx
    5abc:	c3                   	ret
    5abd:	48 8d 15 6e 9c 00 00 	lea    0x9c6e(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    5ac4:	48 8d 0d 81 9c 00 00 	lea    0x9c81(%rip),%rcx        # f74c <fwp_segv.msg+0x4cc>
    5acb:	48 89 e3             	mov    %rsp,%rbx
    5ace:	be 60 00 00 00       	mov    $0x60,%esi
    5ad3:	48 89 df             	mov    %rbx,%rdi
    5ad6:	31 c0                	xor    %eax,%eax
    5ad8:	e8 23 c6 ff ff       	call   2100 <snprintf@plt>
    5add:	e8 be 0f 00 00       	call   6aa0 <fwp_flush>
    5ae2:	48 8b 05 f7 d4 00 00 	mov    0xd4f7(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5ae9:	48 8b 38             	mov    (%rax),%rdi
    5aec:	48 8d 35 da 99 00 00 	lea    0x99da(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5af3:	48 89 da             	mov    %rbx,%rdx
    5af6:	eb 1d                	jmp    5b15 <e48+0xe5>
    5af8:	e8 a3 0f 00 00       	call   6aa0 <fwp_flush>
    5afd:	48 8b 05 dc d4 00 00 	mov    0xd4dc(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5b04:	48 8b 38             	mov    (%rax),%rdi
    5b07:	48 8d 35 bf 99 00 00 	lea    0x99bf(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5b0e:	48 8d 15 8b 99 00 00 	lea    0x998b(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5b15:	31 c0                	xor    %eax,%eax
    5b17:	e8 84 c6 ff ff       	call   21a0 <fprintf@plt>
    5b1c:	bf 65 00 00 00       	mov    $0x65,%edi
    5b21:	e8 4a c7 ff ff       	call   2270 <exit@plt>
    5b26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    5b2d:	00 00 00 

0000000000005b30 <e49>:
    5b30:	50                   	push   %rax
    5b31:	48 8b 3f             	mov    (%rdi),%rdi
    5b34:	48 89 f8             	mov    %rdi,%rax
    5b37:	48 2b 05 5a e6 00 00 	sub    0xe65a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    5b3e:	48 8b 0d 7b e6 00 00 	mov    0xe67b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    5b45:	48 c1 e1 10          	shl    $0x10,%rcx
    5b49:	48 39 c8             	cmp    %rcx,%rax
    5b4c:	73 63                	jae    5bb1 <e49+0x81>
    5b4e:	48 8b 0d 8b e6 00 00 	mov    0xe68b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    5b55:	48 89 c2             	mov    %rax,%rdx
    5b58:	48 c1 ea 10          	shr    $0x10,%rdx
    5b5c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5b63:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5b67:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5b6d:	75 1a                	jne    5b89 <e49+0x59>
    5b6f:	40 80 fe 02          	cmp    $0x2,%sil
    5b73:	75 14                	jne    5b89 <e49+0x59>
    5b75:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5b79:	48 05 28 02 00 00    	add    $0x228,%rax
    5b7f:	80 38 00             	cmpb   $0x0,(%rax)
    5b82:	74 2d                	je     5bb1 <e49+0x81>
    5b84:	e9 a8 00 00 00       	jmp    5c31 <e49+0x101>
    5b89:	40 80 fe 01          	cmp    $0x1,%sil
    5b8d:	75 22                	jne    5bb1 <e49+0x81>
    5b8f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5b93:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5b97:	48 0f af c1          	imul   %rcx,%rax
    5b9b:	48 c1 e8 20          	shr    $0x20,%rax
    5b9f:	48 01 f0             	add    %rsi,%rax
    5ba2:	48 05 28 02 00 00    	add    $0x228,%rax
    5ba8:	80 38 00             	cmpb   $0x0,(%rax)
    5bab:	0f 85 80 00 00 00    	jne    5c31 <e49+0x101>
    5bb1:	e8 fa 4a 00 00       	call   a6b0 <f49>
    5bb6:	48 89 c1             	mov    %rax,%rcx
    5bb9:	48 2b 0d d8 e5 00 00 	sub    0xe5d8(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5bc0:	48 8b 15 f9 e5 00 00 	mov    0xe5f9(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5bc7:	48 c1 e2 10          	shl    $0x10,%rdx
    5bcb:	48 39 d1             	cmp    %rdx,%rcx
    5bce:	73 5f                	jae    5c2f <e49+0xff>
    5bd0:	48 8b 15 09 e6 00 00 	mov    0xe609(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5bd7:	48 89 ce             	mov    %rcx,%rsi
    5bda:	48 c1 ee 10          	shr    $0x10,%rsi
    5bde:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5be5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5be9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5bf0:	75 18                	jne    5c0a <e49+0xda>
    5bf2:	40 80 ff 02          	cmp    $0x2,%dil
    5bf6:	75 12                	jne    5c0a <e49+0xda>
    5bf8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5bfc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5c03:	80 39 00             	cmpb   $0x0,(%rcx)
    5c06:	74 27                	je     5c2f <e49+0xff>
    5c08:	eb 27                	jmp    5c31 <e49+0x101>
    5c0a:	40 80 ff 01          	cmp    $0x1,%dil
    5c0e:	75 1f                	jne    5c2f <e49+0xff>
    5c10:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5c14:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5c18:	48 0f af ca          	imul   %rdx,%rcx
    5c1c:	48 c1 e9 20          	shr    $0x20,%rcx
    5c20:	48 01 f9             	add    %rdi,%rcx
    5c23:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5c2a:	80 39 00             	cmpb   $0x0,(%rcx)
    5c2d:	75 02                	jne    5c31 <e49+0x101>
    5c2f:	59                   	pop    %rcx
    5c30:	c3                   	ret
    5c31:	e8 6a 0e 00 00       	call   6aa0 <fwp_flush>
    5c36:	48 8b 05 a3 d3 00 00 	mov    0xd3a3(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5c3d:	48 8b 38             	mov    (%rax),%rdi
    5c40:	48 8d 35 86 98 00 00 	lea    0x9886(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5c47:	48 8d 15 52 98 00 00 	lea    0x9852(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5c4e:	31 c0                	xor    %eax,%eax
    5c50:	e8 4b c5 ff ff       	call   21a0 <fprintf@plt>
    5c55:	bf 65 00 00 00       	mov    $0x65,%edi
    5c5a:	e8 11 c6 ff ff       	call   2270 <exit@plt>
    5c5f:	90                   	nop

0000000000005c60 <e50>:
    5c60:	50                   	push   %rax
    5c61:	48 89 f8             	mov    %rdi,%rax
    5c64:	48 8b 3f             	mov    (%rdi),%rdi
    5c67:	48 8b 0d 2a e5 00 00 	mov    0xe52a(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5c6e:	48 89 fe             	mov    %rdi,%rsi
    5c71:	48 29 ce             	sub    %rcx,%rsi
    5c74:	48 8b 15 45 e5 00 00 	mov    0xe545(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5c7b:	48 c1 e2 10          	shl    $0x10,%rdx
    5c7f:	48 39 d6             	cmp    %rdx,%rsi
    5c82:	73 68                	jae    5cec <e50+0x8c>
    5c84:	4c 8b 05 55 e5 00 00 	mov    0xe555(%rip),%r8        # 141e0 <fwp_gc+0x1078>
    5c8b:	49 89 f1             	mov    %rsi,%r9
    5c8e:	49 c1 e9 10          	shr    $0x10,%r9
    5c92:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5c99:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5c9e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5ca5:	75 1b                	jne    5cc2 <e50+0x62>
    5ca7:	41 80 fa 02          	cmp    $0x2,%r10b
    5cab:	75 15                	jne    5cc2 <e50+0x62>
    5cad:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5cb1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5cb8:	80 3e 00             	cmpb   $0x0,(%rsi)
    5cbb:	74 2f                	je     5cec <e50+0x8c>
    5cbd:	e9 24 01 00 00       	jmp    5de6 <e50+0x186>
    5cc2:	41 80 fa 01          	cmp    $0x1,%r10b
    5cc6:	75 24                	jne    5cec <e50+0x8c>
    5cc8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5ccc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5cd1:	49 0f af f0          	imul   %r8,%rsi
    5cd5:	48 c1 ee 20          	shr    $0x20,%rsi
    5cd9:	4c 01 d6             	add    %r10,%rsi
    5cdc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5ce3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5ce6:	0f 85 fa 00 00 00    	jne    5de6 <e50+0x186>
    5cec:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5cf0:	48 89 f0             	mov    %rsi,%rax
    5cf3:	48 29 c8             	sub    %rcx,%rax
    5cf6:	48 39 d0             	cmp    %rdx,%rax
    5cf9:	73 64                	jae    5d5f <e50+0xff>
    5cfb:	48 8b 0d de e4 00 00 	mov    0xe4de(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    5d02:	48 89 c2             	mov    %rax,%rdx
    5d05:	48 c1 ea 10          	shr    $0x10,%rdx
    5d09:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5d10:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5d15:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5d1b:	75 1a                	jne    5d37 <e50+0xd7>
    5d1d:	41 80 f8 02          	cmp    $0x2,%r8b
    5d21:	75 14                	jne    5d37 <e50+0xd7>
    5d23:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5d27:	48 05 28 02 00 00    	add    $0x228,%rax
    5d2d:	80 38 00             	cmpb   $0x0,(%rax)
    5d30:	74 2d                	je     5d5f <e50+0xff>
    5d32:	e9 af 00 00 00       	jmp    5de6 <e50+0x186>
    5d37:	41 80 f8 01          	cmp    $0x1,%r8b
    5d3b:	75 22                	jne    5d5f <e50+0xff>
    5d3d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5d41:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5d45:	48 0f af c1          	imul   %rcx,%rax
    5d49:	48 c1 e8 20          	shr    $0x20,%rax
    5d4d:	4c 01 c0             	add    %r8,%rax
    5d50:	48 05 28 02 00 00    	add    $0x228,%rax
    5d56:	80 38 00             	cmpb   $0x0,(%rax)
    5d59:	0f 85 87 00 00 00    	jne    5de6 <e50+0x186>
    5d5f:	48 8d 15 4a 5a 00 00 	lea    0x5a4a(%rip),%rdx        # b7b0 <fwp_drop7>
    5d66:	e8 c5 55 00 00       	call   b330 <fwp_p_loop_own>
    5d6b:	48 89 c1             	mov    %rax,%rcx
    5d6e:	48 2b 0d 23 e4 00 00 	sub    0xe423(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5d75:	48 8b 15 44 e4 00 00 	mov    0xe444(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5d7c:	48 c1 e2 10          	shl    $0x10,%rdx
    5d80:	48 39 d1             	cmp    %rdx,%rcx
    5d83:	73 5f                	jae    5de4 <e50+0x184>
    5d85:	48 8b 15 54 e4 00 00 	mov    0xe454(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5d8c:	48 89 ce             	mov    %rcx,%rsi
    5d8f:	48 c1 ee 10          	shr    $0x10,%rsi
    5d93:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5d9a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5d9e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5da5:	75 18                	jne    5dbf <e50+0x15f>
    5da7:	40 80 ff 02          	cmp    $0x2,%dil
    5dab:	75 12                	jne    5dbf <e50+0x15f>
    5dad:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5db1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5db8:	80 39 00             	cmpb   $0x0,(%rcx)
    5dbb:	74 27                	je     5de4 <e50+0x184>
    5dbd:	eb 27                	jmp    5de6 <e50+0x186>
    5dbf:	40 80 ff 01          	cmp    $0x1,%dil
    5dc3:	75 1f                	jne    5de4 <e50+0x184>
    5dc5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5dc9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5dcd:	48 0f af ca          	imul   %rdx,%rcx
    5dd1:	48 c1 e9 20          	shr    $0x20,%rcx
    5dd5:	48 01 f9             	add    %rdi,%rcx
    5dd8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5ddf:	80 39 00             	cmpb   $0x0,(%rcx)
    5de2:	75 02                	jne    5de6 <e50+0x186>
    5de4:	59                   	pop    %rcx
    5de5:	c3                   	ret
    5de6:	e8 b5 0c 00 00       	call   6aa0 <fwp_flush>
    5deb:	48 8b 05 ee d1 00 00 	mov    0xd1ee(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5df2:	48 8b 38             	mov    (%rax),%rdi
    5df5:	48 8d 35 d1 96 00 00 	lea    0x96d1(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5dfc:	48 8d 15 9d 96 00 00 	lea    0x969d(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5e03:	31 c0                	xor    %eax,%eax
    5e05:	e8 96 c3 ff ff       	call   21a0 <fprintf@plt>
    5e0a:	bf 65 00 00 00       	mov    $0x65,%edi
    5e0f:	e8 5c c4 ff ff       	call   2270 <exit@plt>
    5e14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5e1b:	00 00 00 00 00 

0000000000005e20 <e51>:
    5e20:	50                   	push   %rax
    5e21:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    5e25:	48 89 f0             	mov    %rsi,%rax
    5e28:	48 2b 05 69 e3 00 00 	sub    0xe369(%rip),%rax        # 14198 <fwp_gc+0x1030>
    5e2f:	48 8b 0d 8a e3 00 00 	mov    0xe38a(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    5e36:	48 c1 e1 10          	shl    $0x10,%rcx
    5e3a:	48 39 c8             	cmp    %rcx,%rax
    5e3d:	73 64                	jae    5ea3 <e51+0x83>
    5e3f:	48 8b 0d 9a e3 00 00 	mov    0xe39a(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    5e46:	48 89 c2             	mov    %rax,%rdx
    5e49:	48 c1 ea 10          	shr    $0x10,%rdx
    5e4d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5e54:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5e59:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5e5f:	75 1a                	jne    5e7b <e51+0x5b>
    5e61:	41 80 f8 02          	cmp    $0x2,%r8b
    5e65:	75 14                	jne    5e7b <e51+0x5b>
    5e67:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5e6b:	48 05 28 02 00 00    	add    $0x228,%rax
    5e71:	80 38 00             	cmpb   $0x0,(%rax)
    5e74:	74 2d                	je     5ea3 <e51+0x83>
    5e76:	e9 b2 00 00 00       	jmp    5f2d <e51+0x10d>
    5e7b:	41 80 f8 01          	cmp    $0x1,%r8b
    5e7f:	75 22                	jne    5ea3 <e51+0x83>
    5e81:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5e85:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5e89:	48 0f af c1          	imul   %rcx,%rax
    5e8d:	48 c1 e8 20          	shr    $0x20,%rax
    5e91:	4c 01 c0             	add    %r8,%rax
    5e94:	48 05 28 02 00 00    	add    $0x228,%rax
    5e9a:	80 38 00             	cmpb   $0x0,(%rax)
    5e9d:	0f 85 8a 00 00 00    	jne    5f2d <e51+0x10d>
    5ea3:	48 8b 3f             	mov    (%rdi),%rdi
    5ea6:	48 8d 15 63 ce 00 00 	lea    0xce63(%rip),%rdx        # 12d10 <d2>
    5ead:	e8 8e 44 00 00       	call   a340 <fwp_p_array_get_typed>
    5eb2:	48 89 c1             	mov    %rax,%rcx
    5eb5:	48 2b 0d dc e2 00 00 	sub    0xe2dc(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5ebc:	48 8b 15 fd e2 00 00 	mov    0xe2fd(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5ec3:	48 c1 e2 10          	shl    $0x10,%rdx
    5ec7:	48 39 d1             	cmp    %rdx,%rcx
    5eca:	73 5f                	jae    5f2b <e51+0x10b>
    5ecc:	48 8b 15 0d e3 00 00 	mov    0xe30d(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    5ed3:	48 89 ce             	mov    %rcx,%rsi
    5ed6:	48 c1 ee 10          	shr    $0x10,%rsi
    5eda:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ee1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ee5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5eec:	75 18                	jne    5f06 <e51+0xe6>
    5eee:	40 80 ff 02          	cmp    $0x2,%dil
    5ef2:	75 12                	jne    5f06 <e51+0xe6>
    5ef4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5ef8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5eff:	80 39 00             	cmpb   $0x0,(%rcx)
    5f02:	74 27                	je     5f2b <e51+0x10b>
    5f04:	eb 27                	jmp    5f2d <e51+0x10d>
    5f06:	40 80 ff 01          	cmp    $0x1,%dil
    5f0a:	75 1f                	jne    5f2b <e51+0x10b>
    5f0c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5f10:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5f14:	48 0f af ca          	imul   %rdx,%rcx
    5f18:	48 c1 e9 20          	shr    $0x20,%rcx
    5f1c:	48 01 f9             	add    %rdi,%rcx
    5f1f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5f26:	80 39 00             	cmpb   $0x0,(%rcx)
    5f29:	75 02                	jne    5f2d <e51+0x10d>
    5f2b:	59                   	pop    %rcx
    5f2c:	c3                   	ret
    5f2d:	e8 6e 0b 00 00       	call   6aa0 <fwp_flush>
    5f32:	48 8b 05 a7 d0 00 00 	mov    0xd0a7(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    5f39:	48 8b 38             	mov    (%rax),%rdi
    5f3c:	48 8d 35 8a 95 00 00 	lea    0x958a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5f43:	48 8d 15 56 95 00 00 	lea    0x9556(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5f4a:	31 c0                	xor    %eax,%eax
    5f4c:	e8 4f c2 ff ff       	call   21a0 <fprintf@plt>
    5f51:	bf 65 00 00 00       	mov    $0x65,%edi
    5f56:	e8 15 c3 ff ff       	call   2270 <exit@plt>
    5f5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005f60 <e52>:
    5f60:	50                   	push   %rax
    5f61:	48 8b 3f             	mov    (%rdi),%rdi
    5f64:	48 89 f8             	mov    %rdi,%rax
    5f67:	48 2b 05 2a e2 00 00 	sub    0xe22a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    5f6e:	48 8b 0d 4b e2 00 00 	mov    0xe24b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    5f75:	48 c1 e1 10          	shl    $0x10,%rcx
    5f79:	48 39 c8             	cmp    %rcx,%rax
    5f7c:	73 63                	jae    5fe1 <e52+0x81>
    5f7e:	48 8b 0d 5b e2 00 00 	mov    0xe25b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    5f85:	48 89 c2             	mov    %rax,%rdx
    5f88:	48 c1 ea 10          	shr    $0x10,%rdx
    5f8c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5f93:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5f97:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5f9d:	75 1a                	jne    5fb9 <e52+0x59>
    5f9f:	40 80 fe 02          	cmp    $0x2,%sil
    5fa3:	75 14                	jne    5fb9 <e52+0x59>
    5fa5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5fa9:	48 05 28 02 00 00    	add    $0x228,%rax
    5faf:	80 38 00             	cmpb   $0x0,(%rax)
    5fb2:	74 2d                	je     5fe1 <e52+0x81>
    5fb4:	e9 a8 00 00 00       	jmp    6061 <e52+0x101>
    5fb9:	40 80 fe 01          	cmp    $0x1,%sil
    5fbd:	75 22                	jne    5fe1 <e52+0x81>
    5fbf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5fc3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5fc7:	48 0f af c1          	imul   %rcx,%rax
    5fcb:	48 c1 e8 20          	shr    $0x20,%rax
    5fcf:	48 01 f0             	add    %rsi,%rax
    5fd2:	48 05 28 02 00 00    	add    $0x228,%rax
    5fd8:	80 38 00             	cmpb   $0x0,(%rax)
    5fdb:	0f 85 80 00 00 00    	jne    6061 <e52+0x101>
    5fe1:	e8 0a 6b 00 00       	call   caf0 <f52>
    5fe6:	48 89 c1             	mov    %rax,%rcx
    5fe9:	48 2b 0d a8 e1 00 00 	sub    0xe1a8(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    5ff0:	48 8b 15 c9 e1 00 00 	mov    0xe1c9(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    5ff7:	48 c1 e2 10          	shl    $0x10,%rdx
    5ffb:	48 39 d1             	cmp    %rdx,%rcx
    5ffe:	73 5f                	jae    605f <e52+0xff>
    6000:	48 8b 15 d9 e1 00 00 	mov    0xe1d9(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    6007:	48 89 ce             	mov    %rcx,%rsi
    600a:	48 c1 ee 10          	shr    $0x10,%rsi
    600e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6015:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6019:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6020:	75 18                	jne    603a <e52+0xda>
    6022:	40 80 ff 02          	cmp    $0x2,%dil
    6026:	75 12                	jne    603a <e52+0xda>
    6028:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    602c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6033:	80 39 00             	cmpb   $0x0,(%rcx)
    6036:	74 27                	je     605f <e52+0xff>
    6038:	eb 27                	jmp    6061 <e52+0x101>
    603a:	40 80 ff 01          	cmp    $0x1,%dil
    603e:	75 1f                	jne    605f <e52+0xff>
    6040:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6044:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6048:	48 0f af ca          	imul   %rdx,%rcx
    604c:	48 c1 e9 20          	shr    $0x20,%rcx
    6050:	48 01 f9             	add    %rdi,%rcx
    6053:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    605a:	80 39 00             	cmpb   $0x0,(%rcx)
    605d:	75 02                	jne    6061 <e52+0x101>
    605f:	59                   	pop    %rcx
    6060:	c3                   	ret
    6061:	e8 3a 0a 00 00       	call   6aa0 <fwp_flush>
    6066:	48 8b 05 73 cf 00 00 	mov    0xcf73(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    606d:	48 8b 38             	mov    (%rax),%rdi
    6070:	48 8d 35 56 94 00 00 	lea    0x9456(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6077:	48 8d 15 22 94 00 00 	lea    0x9422(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    607e:	31 c0                	xor    %eax,%eax
    6080:	e8 1b c1 ff ff       	call   21a0 <fprintf@plt>
    6085:	bf 65 00 00 00       	mov    $0x65,%edi
    608a:	e8 e1 c1 ff ff       	call   2270 <exit@plt>
    608f:	90                   	nop

0000000000006090 <e53>:
    6090:	50                   	push   %rax
    6091:	48 89 f8             	mov    %rdi,%rax
    6094:	48 8b 3f             	mov    (%rdi),%rdi
    6097:	48 8b 0d fa e0 00 00 	mov    0xe0fa(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    609e:	48 89 fe             	mov    %rdi,%rsi
    60a1:	48 29 ce             	sub    %rcx,%rsi
    60a4:	48 8b 15 15 e1 00 00 	mov    0xe115(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    60ab:	48 c1 e2 10          	shl    $0x10,%rdx
    60af:	48 39 d6             	cmp    %rdx,%rsi
    60b2:	73 68                	jae    611c <e53+0x8c>
    60b4:	4c 8b 05 25 e1 00 00 	mov    0xe125(%rip),%r8        # 141e0 <fwp_gc+0x1078>
    60bb:	49 89 f1             	mov    %rsi,%r9
    60be:	49 c1 e9 10          	shr    $0x10,%r9
    60c2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    60c9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    60ce:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    60d5:	75 1b                	jne    60f2 <e53+0x62>
    60d7:	41 80 fa 02          	cmp    $0x2,%r10b
    60db:	75 15                	jne    60f2 <e53+0x62>
    60dd:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    60e1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    60e8:	80 3e 00             	cmpb   $0x0,(%rsi)
    60eb:	74 2f                	je     611c <e53+0x8c>
    60ed:	e9 24 01 00 00       	jmp    6216 <e53+0x186>
    60f2:	41 80 fa 01          	cmp    $0x1,%r10b
    60f6:	75 24                	jne    611c <e53+0x8c>
    60f8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    60fc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    6101:	49 0f af f0          	imul   %r8,%rsi
    6105:	48 c1 ee 20          	shr    $0x20,%rsi
    6109:	4c 01 d6             	add    %r10,%rsi
    610c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6113:	80 3e 00             	cmpb   $0x0,(%rsi)
    6116:	0f 85 fa 00 00 00    	jne    6216 <e53+0x186>
    611c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6120:	48 89 f0             	mov    %rsi,%rax
    6123:	48 29 c8             	sub    %rcx,%rax
    6126:	48 39 d0             	cmp    %rdx,%rax
    6129:	73 64                	jae    618f <e53+0xff>
    612b:	48 8b 0d ae e0 00 00 	mov    0xe0ae(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    6132:	48 89 c2             	mov    %rax,%rdx
    6135:	48 c1 ea 10          	shr    $0x10,%rdx
    6139:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6140:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6145:	48 25 ff ff 00 00    	and    $0xffff,%rax
    614b:	75 1a                	jne    6167 <e53+0xd7>
    614d:	41 80 f8 02          	cmp    $0x2,%r8b
    6151:	75 14                	jne    6167 <e53+0xd7>
    6153:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6157:	48 05 28 02 00 00    	add    $0x228,%rax
    615d:	80 38 00             	cmpb   $0x0,(%rax)
    6160:	74 2d                	je     618f <e53+0xff>
    6162:	e9 af 00 00 00       	jmp    6216 <e53+0x186>
    6167:	41 80 f8 01          	cmp    $0x1,%r8b
    616b:	75 22                	jne    618f <e53+0xff>
    616d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6171:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6175:	48 0f af c1          	imul   %rcx,%rax
    6179:	48 c1 e8 20          	shr    $0x20,%rax
    617d:	4c 01 c0             	add    %r8,%rax
    6180:	48 05 28 02 00 00    	add    $0x228,%rax
    6186:	80 38 00             	cmpb   $0x0,(%rax)
    6189:	0f 85 87 00 00 00    	jne    6216 <e53+0x186>
    618f:	48 8d 15 fa 6f 00 00 	lea    0x6ffa(%rip),%rdx        # d190 <fwp_drop10>
    6196:	e8 95 51 00 00       	call   b330 <fwp_p_loop_own>
    619b:	48 89 c1             	mov    %rax,%rcx
    619e:	48 2b 0d f3 df 00 00 	sub    0xdff3(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    61a5:	48 8b 15 14 e0 00 00 	mov    0xe014(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    61ac:	48 c1 e2 10          	shl    $0x10,%rdx
    61b0:	48 39 d1             	cmp    %rdx,%rcx
    61b3:	73 5f                	jae    6214 <e53+0x184>
    61b5:	48 8b 15 24 e0 00 00 	mov    0xe024(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    61bc:	48 89 ce             	mov    %rcx,%rsi
    61bf:	48 c1 ee 10          	shr    $0x10,%rsi
    61c3:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    61ca:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    61ce:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    61d5:	75 18                	jne    61ef <e53+0x15f>
    61d7:	40 80 ff 02          	cmp    $0x2,%dil
    61db:	75 12                	jne    61ef <e53+0x15f>
    61dd:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    61e1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    61e8:	80 39 00             	cmpb   $0x0,(%rcx)
    61eb:	74 27                	je     6214 <e53+0x184>
    61ed:	eb 27                	jmp    6216 <e53+0x186>
    61ef:	40 80 ff 01          	cmp    $0x1,%dil
    61f3:	75 1f                	jne    6214 <e53+0x184>
    61f5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    61f9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    61fd:	48 0f af ca          	imul   %rdx,%rcx
    6201:	48 c1 e9 20          	shr    $0x20,%rcx
    6205:	48 01 f9             	add    %rdi,%rcx
    6208:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    620f:	80 39 00             	cmpb   $0x0,(%rcx)
    6212:	75 02                	jne    6216 <e53+0x186>
    6214:	59                   	pop    %rcx
    6215:	c3                   	ret
    6216:	e8 85 08 00 00       	call   6aa0 <fwp_flush>
    621b:	48 8b 05 be cd 00 00 	mov    0xcdbe(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6222:	48 8b 38             	mov    (%rax),%rdi
    6225:	48 8d 35 a1 92 00 00 	lea    0x92a1(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    622c:	48 8d 15 6d 92 00 00 	lea    0x926d(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    6233:	31 c0                	xor    %eax,%eax
    6235:	e8 66 bf ff ff       	call   21a0 <fprintf@plt>
    623a:	bf 65 00 00 00       	mov    $0x65,%edi
    623f:	e8 2c c0 ff ff       	call   2270 <exit@plt>
    6244:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    624b:	00 00 00 00 00 

0000000000006250 <e54>:
    6250:	50                   	push   %rax
    6251:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    6255:	48 89 f0             	mov    %rsi,%rax
    6258:	48 2b 05 39 df 00 00 	sub    0xdf39(%rip),%rax        # 14198 <fwp_gc+0x1030>
    625f:	48 8b 0d 5a df 00 00 	mov    0xdf5a(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    6266:	48 c1 e1 10          	shl    $0x10,%rcx
    626a:	48 39 c8             	cmp    %rcx,%rax
    626d:	73 64                	jae    62d3 <e54+0x83>
    626f:	48 8b 0d 6a df 00 00 	mov    0xdf6a(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    6276:	48 89 c2             	mov    %rax,%rdx
    6279:	48 c1 ea 10          	shr    $0x10,%rdx
    627d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6284:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6289:	48 25 ff ff 00 00    	and    $0xffff,%rax
    628f:	75 1a                	jne    62ab <e54+0x5b>
    6291:	41 80 f8 02          	cmp    $0x2,%r8b
    6295:	75 14                	jne    62ab <e54+0x5b>
    6297:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    629b:	48 05 28 02 00 00    	add    $0x228,%rax
    62a1:	80 38 00             	cmpb   $0x0,(%rax)
    62a4:	74 2d                	je     62d3 <e54+0x83>
    62a6:	e9 b2 00 00 00       	jmp    635d <e54+0x10d>
    62ab:	41 80 f8 01          	cmp    $0x1,%r8b
    62af:	75 22                	jne    62d3 <e54+0x83>
    62b1:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    62b5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    62b9:	48 0f af c1          	imul   %rcx,%rax
    62bd:	48 c1 e8 20          	shr    $0x20,%rax
    62c1:	4c 01 c0             	add    %r8,%rax
    62c4:	48 05 28 02 00 00    	add    $0x228,%rax
    62ca:	80 38 00             	cmpb   $0x0,(%rax)
    62cd:	0f 85 8a 00 00 00    	jne    635d <e54+0x10d>
    62d3:	48 8b 3f             	mov    (%rdi),%rdi
    62d6:	48 8d 15 d3 c9 00 00 	lea    0xc9d3(%rip),%rdx        # 12cb0 <d1>
    62dd:	e8 5e 40 00 00       	call   a340 <fwp_p_array_get_typed>
    62e2:	48 89 c1             	mov    %rax,%rcx
    62e5:	48 2b 0d ac de 00 00 	sub    0xdeac(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    62ec:	48 8b 15 cd de 00 00 	mov    0xdecd(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    62f3:	48 c1 e2 10          	shl    $0x10,%rdx
    62f7:	48 39 d1             	cmp    %rdx,%rcx
    62fa:	73 5f                	jae    635b <e54+0x10b>
    62fc:	48 8b 15 dd de 00 00 	mov    0xdedd(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    6303:	48 89 ce             	mov    %rcx,%rsi
    6306:	48 c1 ee 10          	shr    $0x10,%rsi
    630a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6311:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6315:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    631c:	75 18                	jne    6336 <e54+0xe6>
    631e:	40 80 ff 02          	cmp    $0x2,%dil
    6322:	75 12                	jne    6336 <e54+0xe6>
    6324:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6328:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    632f:	80 39 00             	cmpb   $0x0,(%rcx)
    6332:	74 27                	je     635b <e54+0x10b>
    6334:	eb 27                	jmp    635d <e54+0x10d>
    6336:	40 80 ff 01          	cmp    $0x1,%dil
    633a:	75 1f                	jne    635b <e54+0x10b>
    633c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6340:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6344:	48 0f af ca          	imul   %rdx,%rcx
    6348:	48 c1 e9 20          	shr    $0x20,%rcx
    634c:	48 01 f9             	add    %rdi,%rcx
    634f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6356:	80 39 00             	cmpb   $0x0,(%rcx)
    6359:	75 02                	jne    635d <e54+0x10d>
    635b:	59                   	pop    %rcx
    635c:	c3                   	ret
    635d:	e8 3e 07 00 00       	call   6aa0 <fwp_flush>
    6362:	48 8b 05 77 cc 00 00 	mov    0xcc77(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6369:	48 8b 38             	mov    (%rax),%rdi
    636c:	48 8d 35 5a 91 00 00 	lea    0x915a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6373:	48 8d 15 26 91 00 00 	lea    0x9126(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    637a:	31 c0                	xor    %eax,%eax
    637c:	e8 1f be ff ff       	call   21a0 <fprintf@plt>
    6381:	bf 65 00 00 00       	mov    $0x65,%edi
    6386:	e8 e5 be ff ff       	call   2270 <exit@plt>
    638b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006390 <e55>:
    6390:	50                   	push   %rax
    6391:	48 8b 3f             	mov    (%rdi),%rdi
    6394:	48 89 f8             	mov    %rdi,%rax
    6397:	48 2b 05 fa dd 00 00 	sub    0xddfa(%rip),%rax        # 14198 <fwp_gc+0x1030>
    639e:	48 8b 0d 1b de 00 00 	mov    0xde1b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    63a5:	48 c1 e1 10          	shl    $0x10,%rcx
    63a9:	48 39 c8             	cmp    %rcx,%rax
    63ac:	73 63                	jae    6411 <e55+0x81>
    63ae:	48 8b 0d 2b de 00 00 	mov    0xde2b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    63b5:	48 89 c2             	mov    %rax,%rdx
    63b8:	48 c1 ea 10          	shr    $0x10,%rdx
    63bc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    63c3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    63c7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    63cd:	75 1a                	jne    63e9 <e55+0x59>
    63cf:	40 80 fe 02          	cmp    $0x2,%sil
    63d3:	75 14                	jne    63e9 <e55+0x59>
    63d5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    63d9:	48 05 28 02 00 00    	add    $0x228,%rax
    63df:	80 38 00             	cmpb   $0x0,(%rax)
    63e2:	74 2d                	je     6411 <e55+0x81>
    63e4:	e9 a8 00 00 00       	jmp    6491 <e55+0x101>
    63e9:	40 80 fe 01          	cmp    $0x1,%sil
    63ed:	75 22                	jne    6411 <e55+0x81>
    63ef:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    63f3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    63f7:	48 0f af c1          	imul   %rcx,%rax
    63fb:	48 c1 e8 20          	shr    $0x20,%rax
    63ff:	48 01 f0             	add    %rsi,%rax
    6402:	48 05 28 02 00 00    	add    $0x228,%rax
    6408:	80 38 00             	cmpb   $0x0,(%rax)
    640b:	0f 85 80 00 00 00    	jne    6491 <e55+0x101>
    6411:	e8 3a 6e 00 00       	call   d250 <f55>
    6416:	48 89 c1             	mov    %rax,%rcx
    6419:	48 2b 0d 78 dd 00 00 	sub    0xdd78(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    6420:	48 8b 15 99 dd 00 00 	mov    0xdd99(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    6427:	48 c1 e2 10          	shl    $0x10,%rdx
    642b:	48 39 d1             	cmp    %rdx,%rcx
    642e:	73 5f                	jae    648f <e55+0xff>
    6430:	48 8b 15 a9 dd 00 00 	mov    0xdda9(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    6437:	48 89 ce             	mov    %rcx,%rsi
    643a:	48 c1 ee 10          	shr    $0x10,%rsi
    643e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6445:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6449:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6450:	75 18                	jne    646a <e55+0xda>
    6452:	40 80 ff 02          	cmp    $0x2,%dil
    6456:	75 12                	jne    646a <e55+0xda>
    6458:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    645c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6463:	80 39 00             	cmpb   $0x0,(%rcx)
    6466:	74 27                	je     648f <e55+0xff>
    6468:	eb 27                	jmp    6491 <e55+0x101>
    646a:	40 80 ff 01          	cmp    $0x1,%dil
    646e:	75 1f                	jne    648f <e55+0xff>
    6470:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6474:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6478:	48 0f af ca          	imul   %rdx,%rcx
    647c:	48 c1 e9 20          	shr    $0x20,%rcx
    6480:	48 01 f9             	add    %rdi,%rcx
    6483:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    648a:	80 39 00             	cmpb   $0x0,(%rcx)
    648d:	75 02                	jne    6491 <e55+0x101>
    648f:	59                   	pop    %rcx
    6490:	c3                   	ret
    6491:	e8 0a 06 00 00       	call   6aa0 <fwp_flush>
    6496:	48 8b 05 43 cb 00 00 	mov    0xcb43(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    649d:	48 8b 38             	mov    (%rax),%rdi
    64a0:	48 8d 35 26 90 00 00 	lea    0x9026(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    64a7:	48 8d 15 f2 8f 00 00 	lea    0x8ff2(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    64ae:	31 c0                	xor    %eax,%eax
    64b0:	e8 eb bc ff ff       	call   21a0 <fprintf@plt>
    64b5:	bf 65 00 00 00       	mov    $0x65,%edi
    64ba:	e8 b1 bd ff ff       	call   2270 <exit@plt>
    64bf:	90                   	nop

00000000000064c0 <e56>:
    64c0:	50                   	push   %rax
    64c1:	48 89 f8             	mov    %rdi,%rax
    64c4:	48 8b 3f             	mov    (%rdi),%rdi
    64c7:	48 8b 0d ca dc 00 00 	mov    0xdcca(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    64ce:	48 89 fe             	mov    %rdi,%rsi
    64d1:	48 29 ce             	sub    %rcx,%rsi
    64d4:	48 8b 15 e5 dc 00 00 	mov    0xdce5(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    64db:	48 c1 e2 10          	shl    $0x10,%rdx
    64df:	48 39 d6             	cmp    %rdx,%rsi
    64e2:	73 68                	jae    654c <e56+0x8c>
    64e4:	4c 8b 05 f5 dc 00 00 	mov    0xdcf5(%rip),%r8        # 141e0 <fwp_gc+0x1078>
    64eb:	49 89 f1             	mov    %rsi,%r9
    64ee:	49 c1 e9 10          	shr    $0x10,%r9
    64f2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    64f9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    64fe:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    6505:	75 1b                	jne    6522 <e56+0x62>
    6507:	41 80 fa 02          	cmp    $0x2,%r10b
    650b:	75 15                	jne    6522 <e56+0x62>
    650d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    6511:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6518:	80 3e 00             	cmpb   $0x0,(%rsi)
    651b:	74 2f                	je     654c <e56+0x8c>
    651d:	e9 24 01 00 00       	jmp    6646 <e56+0x186>
    6522:	41 80 fa 01          	cmp    $0x1,%r10b
    6526:	75 24                	jne    654c <e56+0x8c>
    6528:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    652c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    6531:	49 0f af f0          	imul   %r8,%rsi
    6535:	48 c1 ee 20          	shr    $0x20,%rsi
    6539:	4c 01 d6             	add    %r10,%rsi
    653c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6543:	80 3e 00             	cmpb   $0x0,(%rsi)
    6546:	0f 85 fa 00 00 00    	jne    6646 <e56+0x186>
    654c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6550:	48 89 f0             	mov    %rsi,%rax
    6553:	48 29 c8             	sub    %rcx,%rax
    6556:	48 39 d0             	cmp    %rdx,%rax
    6559:	73 64                	jae    65bf <e56+0xff>
    655b:	48 8b 0d 7e dc 00 00 	mov    0xdc7e(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    6562:	48 89 c2             	mov    %rax,%rdx
    6565:	48 c1 ea 10          	shr    $0x10,%rdx
    6569:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6570:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6575:	48 25 ff ff 00 00    	and    $0xffff,%rax
    657b:	75 1a                	jne    6597 <e56+0xd7>
    657d:	41 80 f8 02          	cmp    $0x2,%r8b
    6581:	75 14                	jne    6597 <e56+0xd7>
    6583:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6587:	48 05 28 02 00 00    	add    $0x228,%rax
    658d:	80 38 00             	cmpb   $0x0,(%rax)
    6590:	74 2d                	je     65bf <e56+0xff>
    6592:	e9 af 00 00 00       	jmp    6646 <e56+0x186>
    6597:	41 80 f8 01          	cmp    $0x1,%r8b
    659b:	75 22                	jne    65bf <e56+0xff>
    659d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    65a1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    65a5:	48 0f af c1          	imul   %rcx,%rax
    65a9:	48 c1 e8 20          	shr    $0x20,%rax
    65ad:	4c 01 c0             	add    %r8,%rax
    65b0:	48 05 28 02 00 00    	add    $0x228,%rax
    65b6:	80 38 00             	cmpb   $0x0,(%rax)
    65b9:	0f 85 87 00 00 00    	jne    6646 <e56+0x186>
    65bf:	48 8d 15 7a 73 00 00 	lea    0x737a(%rip),%rdx        # d940 <fwp_drop13>
    65c6:	e8 65 4d 00 00       	call   b330 <fwp_p_loop_own>
    65cb:	48 89 c1             	mov    %rax,%rcx
    65ce:	48 2b 0d c3 db 00 00 	sub    0xdbc3(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    65d5:	48 8b 15 e4 db 00 00 	mov    0xdbe4(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    65dc:	48 c1 e2 10          	shl    $0x10,%rdx
    65e0:	48 39 d1             	cmp    %rdx,%rcx
    65e3:	73 5f                	jae    6644 <e56+0x184>
    65e5:	48 8b 15 f4 db 00 00 	mov    0xdbf4(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    65ec:	48 89 ce             	mov    %rcx,%rsi
    65ef:	48 c1 ee 10          	shr    $0x10,%rsi
    65f3:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    65fa:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    65fe:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6605:	75 18                	jne    661f <e56+0x15f>
    6607:	40 80 ff 02          	cmp    $0x2,%dil
    660b:	75 12                	jne    661f <e56+0x15f>
    660d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6611:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6618:	80 39 00             	cmpb   $0x0,(%rcx)
    661b:	74 27                	je     6644 <e56+0x184>
    661d:	eb 27                	jmp    6646 <e56+0x186>
    661f:	40 80 ff 01          	cmp    $0x1,%dil
    6623:	75 1f                	jne    6644 <e56+0x184>
    6625:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6629:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    662d:	48 0f af ca          	imul   %rdx,%rcx
    6631:	48 c1 e9 20          	shr    $0x20,%rcx
    6635:	48 01 f9             	add    %rdi,%rcx
    6638:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    663f:	80 39 00             	cmpb   $0x0,(%rcx)
    6642:	75 02                	jne    6646 <e56+0x186>
    6644:	59                   	pop    %rcx
    6645:	c3                   	ret
    6646:	e8 55 04 00 00       	call   6aa0 <fwp_flush>
    664b:	48 8b 05 8e c9 00 00 	mov    0xc98e(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6652:	48 8b 38             	mov    (%rax),%rdi
    6655:	48 8d 35 71 8e 00 00 	lea    0x8e71(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    665c:	48 8d 15 3d 8e 00 00 	lea    0x8e3d(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    6663:	31 c0                	xor    %eax,%eax
    6665:	e8 36 bb ff ff       	call   21a0 <fprintf@plt>
    666a:	bf 65 00 00 00       	mov    $0x65,%edi
    666f:	e8 fc bb ff ff       	call   2270 <exit@plt>
    6674:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    667b:	00 00 00 00 00 

0000000000006680 <e57>:
    6680:	50                   	push   %rax
    6681:	48 8b 3f             	mov    (%rdi),%rdi
    6684:	48 89 f8             	mov    %rdi,%rax
    6687:	48 2b 05 0a db 00 00 	sub    0xdb0a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    668e:	48 8b 0d 2b db 00 00 	mov    0xdb2b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    6695:	48 c1 e1 10          	shl    $0x10,%rcx
    6699:	48 39 c8             	cmp    %rcx,%rax
    669c:	73 63                	jae    6701 <e57+0x81>
    669e:	48 8b 0d 3b db 00 00 	mov    0xdb3b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    66a5:	48 89 c2             	mov    %rax,%rdx
    66a8:	48 c1 ea 10          	shr    $0x10,%rdx
    66ac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    66b3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    66b7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    66bd:	75 1a                	jne    66d9 <e57+0x59>
    66bf:	40 80 fe 02          	cmp    $0x2,%sil
    66c3:	75 14                	jne    66d9 <e57+0x59>
    66c5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    66c9:	48 05 28 02 00 00    	add    $0x228,%rax
    66cf:	80 38 00             	cmpb   $0x0,(%rax)
    66d2:	74 2d                	je     6701 <e57+0x81>
    66d4:	e9 a8 00 00 00       	jmp    6781 <e57+0x101>
    66d9:	40 80 fe 01          	cmp    $0x1,%sil
    66dd:	75 22                	jne    6701 <e57+0x81>
    66df:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    66e3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    66e7:	48 0f af c1          	imul   %rcx,%rax
    66eb:	48 c1 e8 20          	shr    $0x20,%rax
    66ef:	48 01 f0             	add    %rsi,%rax
    66f2:	48 05 28 02 00 00    	add    $0x228,%rax
    66f8:	80 38 00             	cmpb   $0x0,(%rax)
    66fb:	0f 85 80 00 00 00    	jne    6781 <e57+0x101>
    6701:	e8 fa 72 00 00       	call   da00 <f57>
    6706:	48 89 c1             	mov    %rax,%rcx
    6709:	48 2b 0d 88 da 00 00 	sub    0xda88(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    6710:	48 8b 15 a9 da 00 00 	mov    0xdaa9(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    6717:	48 c1 e2 10          	shl    $0x10,%rdx
    671b:	48 39 d1             	cmp    %rdx,%rcx
    671e:	73 5f                	jae    677f <e57+0xff>
    6720:	48 8b 15 b9 da 00 00 	mov    0xdab9(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    6727:	48 89 ce             	mov    %rcx,%rsi
    672a:	48 c1 ee 10          	shr    $0x10,%rsi
    672e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6735:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6739:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6740:	75 18                	jne    675a <e57+0xda>
    6742:	40 80 ff 02          	cmp    $0x2,%dil
    6746:	75 12                	jne    675a <e57+0xda>
    6748:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    674c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6753:	80 39 00             	cmpb   $0x0,(%rcx)
    6756:	74 27                	je     677f <e57+0xff>
    6758:	eb 27                	jmp    6781 <e57+0x101>
    675a:	40 80 ff 01          	cmp    $0x1,%dil
    675e:	75 1f                	jne    677f <e57+0xff>
    6760:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6764:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6768:	48 0f af ca          	imul   %rdx,%rcx
    676c:	48 c1 e9 20          	shr    $0x20,%rcx
    6770:	48 01 f9             	add    %rdi,%rcx
    6773:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    677a:	80 39 00             	cmpb   $0x0,(%rcx)
    677d:	75 02                	jne    6781 <e57+0x101>
    677f:	59                   	pop    %rcx
    6780:	c3                   	ret
    6781:	e8 1a 03 00 00       	call   6aa0 <fwp_flush>
    6786:	48 8b 05 53 c8 00 00 	mov    0xc853(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    678d:	48 8b 38             	mov    (%rax),%rdi
    6790:	48 8d 35 36 8d 00 00 	lea    0x8d36(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6797:	48 8d 15 02 8d 00 00 	lea    0x8d02(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    679e:	31 c0                	xor    %eax,%eax
    67a0:	e8 fb b9 ff ff       	call   21a0 <fprintf@plt>
    67a5:	bf 65 00 00 00       	mov    $0x65,%edi
    67aa:	e8 c1 ba ff ff       	call   2270 <exit@plt>
    67af:	90                   	nop

00000000000067b0 <e58>:
    67b0:	50                   	push   %rax
    67b1:	48 89 f8             	mov    %rdi,%rax
    67b4:	48 8b 3f             	mov    (%rdi),%rdi
    67b7:	48 8b 0d da d9 00 00 	mov    0xd9da(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    67be:	48 89 fe             	mov    %rdi,%rsi
    67c1:	48 29 ce             	sub    %rcx,%rsi
    67c4:	48 8b 15 f5 d9 00 00 	mov    0xd9f5(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    67cb:	48 c1 e2 10          	shl    $0x10,%rdx
    67cf:	48 39 d6             	cmp    %rdx,%rsi
    67d2:	73 68                	jae    683c <e58+0x8c>
    67d4:	4c 8b 05 05 da 00 00 	mov    0xda05(%rip),%r8        # 141e0 <fwp_gc+0x1078>
    67db:	49 89 f1             	mov    %rsi,%r9
    67de:	49 c1 e9 10          	shr    $0x10,%r9
    67e2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    67e9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    67ee:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    67f5:	75 1b                	jne    6812 <e58+0x62>
    67f7:	41 80 fa 02          	cmp    $0x2,%r10b
    67fb:	75 15                	jne    6812 <e58+0x62>
    67fd:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    6801:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6808:	80 3e 00             	cmpb   $0x0,(%rsi)
    680b:	74 2f                	je     683c <e58+0x8c>
    680d:	e9 24 01 00 00       	jmp    6936 <e58+0x186>
    6812:	41 80 fa 01          	cmp    $0x1,%r10b
    6816:	75 24                	jne    683c <e58+0x8c>
    6818:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    681c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    6821:	49 0f af f0          	imul   %r8,%rsi
    6825:	48 c1 ee 20          	shr    $0x20,%rsi
    6829:	4c 01 d6             	add    %r10,%rsi
    682c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6833:	80 3e 00             	cmpb   $0x0,(%rsi)
    6836:	0f 85 fa 00 00 00    	jne    6936 <e58+0x186>
    683c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6840:	48 89 f0             	mov    %rsi,%rax
    6843:	48 29 c8             	sub    %rcx,%rax
    6846:	48 39 d0             	cmp    %rdx,%rax
    6849:	73 64                	jae    68af <e58+0xff>
    684b:	48 8b 0d 8e d9 00 00 	mov    0xd98e(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    6852:	48 89 c2             	mov    %rax,%rdx
    6855:	48 c1 ea 10          	shr    $0x10,%rdx
    6859:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6860:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6865:	48 25 ff ff 00 00    	and    $0xffff,%rax
    686b:	75 1a                	jne    6887 <e58+0xd7>
    686d:	41 80 f8 02          	cmp    $0x2,%r8b
    6871:	75 14                	jne    6887 <e58+0xd7>
    6873:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6877:	48 05 28 02 00 00    	add    $0x228,%rax
    687d:	80 38 00             	cmpb   $0x0,(%rax)
    6880:	74 2d                	je     68af <e58+0xff>
    6882:	e9 af 00 00 00       	jmp    6936 <e58+0x186>
    6887:	41 80 f8 01          	cmp    $0x1,%r8b
    688b:	75 22                	jne    68af <e58+0xff>
    688d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6891:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6895:	48 0f af c1          	imul   %rcx,%rax
    6899:	48 c1 e8 20          	shr    $0x20,%rax
    689d:	4c 01 c0             	add    %r8,%rax
    68a0:	48 05 28 02 00 00    	add    $0x228,%rax
    68a6:	80 38 00             	cmpb   $0x0,(%rax)
    68a9:	0f 85 87 00 00 00    	jne    6936 <e58+0x186>
    68af:	48 8d 15 5a 77 00 00 	lea    0x775a(%rip),%rdx        # e010 <fwp_drop15>
    68b6:	e8 75 4a 00 00       	call   b330 <fwp_p_loop_own>
    68bb:	48 89 c1             	mov    %rax,%rcx
    68be:	48 2b 0d d3 d8 00 00 	sub    0xd8d3(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    68c5:	48 8b 15 f4 d8 00 00 	mov    0xd8f4(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    68cc:	48 c1 e2 10          	shl    $0x10,%rdx
    68d0:	48 39 d1             	cmp    %rdx,%rcx
    68d3:	73 5f                	jae    6934 <e58+0x184>
    68d5:	48 8b 15 04 d9 00 00 	mov    0xd904(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    68dc:	48 89 ce             	mov    %rcx,%rsi
    68df:	48 c1 ee 10          	shr    $0x10,%rsi
    68e3:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    68ea:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    68ee:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    68f5:	75 18                	jne    690f <e58+0x15f>
    68f7:	40 80 ff 02          	cmp    $0x2,%dil
    68fb:	75 12                	jne    690f <e58+0x15f>
    68fd:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6901:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6908:	80 39 00             	cmpb   $0x0,(%rcx)
    690b:	74 27                	je     6934 <e58+0x184>
    690d:	eb 27                	jmp    6936 <e58+0x186>
    690f:	40 80 ff 01          	cmp    $0x1,%dil
    6913:	75 1f                	jne    6934 <e58+0x184>
    6915:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6919:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    691d:	48 0f af ca          	imul   %rdx,%rcx
    6921:	48 c1 e9 20          	shr    $0x20,%rcx
    6925:	48 01 f9             	add    %rdi,%rcx
    6928:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    692f:	80 39 00             	cmpb   $0x0,(%rcx)
    6932:	75 02                	jne    6936 <e58+0x186>
    6934:	59                   	pop    %rcx
    6935:	c3                   	ret
    6936:	e8 65 01 00 00       	call   6aa0 <fwp_flush>
    693b:	48 8b 05 9e c6 00 00 	mov    0xc69e(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6942:	48 8b 38             	mov    (%rax),%rdi
    6945:	48 8d 35 81 8b 00 00 	lea    0x8b81(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    694c:	48 8d 15 4d 8b 00 00 	lea    0x8b4d(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    6953:	31 c0                	xor    %eax,%eax
    6955:	e8 46 b8 ff ff       	call   21a0 <fprintf@plt>
    695a:	bf 65 00 00 00       	mov    $0x65,%edi
    695f:	e8 0c b9 ff ff       	call   2270 <exit@plt>
    6964:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    696b:	00 00 00 00 00 

0000000000006970 <e59>:
    6970:	50                   	push   %rax
    6971:	48 8b 3f             	mov    (%rdi),%rdi
    6974:	48 89 f8             	mov    %rdi,%rax
    6977:	48 2b 05 1a d8 00 00 	sub    0xd81a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    697e:	48 8b 0d 3b d8 00 00 	mov    0xd83b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    6985:	48 c1 e1 10          	shl    $0x10,%rcx
    6989:	48 39 c8             	cmp    %rcx,%rax
    698c:	73 63                	jae    69f1 <e59+0x81>
    698e:	48 8b 0d 4b d8 00 00 	mov    0xd84b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    6995:	48 89 c2             	mov    %rax,%rdx
    6998:	48 c1 ea 10          	shr    $0x10,%rdx
    699c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    69a3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    69a7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    69ad:	75 1a                	jne    69c9 <e59+0x59>
    69af:	40 80 fe 02          	cmp    $0x2,%sil
    69b3:	75 14                	jne    69c9 <e59+0x59>
    69b5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    69b9:	48 05 28 02 00 00    	add    $0x228,%rax
    69bf:	80 38 00             	cmpb   $0x0,(%rax)
    69c2:	74 2d                	je     69f1 <e59+0x81>
    69c4:	e9 a8 00 00 00       	jmp    6a71 <e59+0x101>
    69c9:	40 80 fe 01          	cmp    $0x1,%sil
    69cd:	75 22                	jne    69f1 <e59+0x81>
    69cf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    69d3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    69d7:	48 0f af c1          	imul   %rcx,%rax
    69db:	48 c1 e8 20          	shr    $0x20,%rax
    69df:	48 01 f0             	add    %rsi,%rax
    69e2:	48 05 28 02 00 00    	add    $0x228,%rax
    69e8:	80 38 00             	cmpb   $0x0,(%rax)
    69eb:	0f 85 80 00 00 00    	jne    6a71 <e59+0x101>
    69f1:	e8 da 76 00 00       	call   e0d0 <f59>
    69f6:	48 89 c1             	mov    %rax,%rcx
    69f9:	48 2b 0d 98 d7 00 00 	sub    0xd798(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    6a00:	48 8b 15 b9 d7 00 00 	mov    0xd7b9(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    6a07:	48 c1 e2 10          	shl    $0x10,%rdx
    6a0b:	48 39 d1             	cmp    %rdx,%rcx
    6a0e:	73 5f                	jae    6a6f <e59+0xff>
    6a10:	48 8b 15 c9 d7 00 00 	mov    0xd7c9(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    6a17:	48 89 ce             	mov    %rcx,%rsi
    6a1a:	48 c1 ee 10          	shr    $0x10,%rsi
    6a1e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6a25:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6a29:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6a30:	75 18                	jne    6a4a <e59+0xda>
    6a32:	40 80 ff 02          	cmp    $0x2,%dil
    6a36:	75 12                	jne    6a4a <e59+0xda>
    6a38:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6a3c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6a43:	80 39 00             	cmpb   $0x0,(%rcx)
    6a46:	74 27                	je     6a6f <e59+0xff>
    6a48:	eb 27                	jmp    6a71 <e59+0x101>
    6a4a:	40 80 ff 01          	cmp    $0x1,%dil
    6a4e:	75 1f                	jne    6a6f <e59+0xff>
    6a50:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6a54:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6a58:	48 0f af ca          	imul   %rdx,%rcx
    6a5c:	48 c1 e9 20          	shr    $0x20,%rcx
    6a60:	48 01 f9             	add    %rdi,%rcx
    6a63:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6a6a:	80 39 00             	cmpb   $0x0,(%rcx)
    6a6d:	75 02                	jne    6a71 <e59+0x101>
    6a6f:	59                   	pop    %rcx
    6a70:	c3                   	ret
    6a71:	e8 2a 00 00 00       	call   6aa0 <fwp_flush>
    6a76:	48 8b 05 63 c5 00 00 	mov    0xc563(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6a7d:	48 8b 38             	mov    (%rax),%rdi
    6a80:	48 8d 35 46 8a 00 00 	lea    0x8a46(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6a87:	48 8d 15 12 8a 00 00 	lea    0x8a12(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    6a8e:	31 c0                	xor    %eax,%eax
    6a90:	e8 0b b7 ff ff       	call   21a0 <fprintf@plt>
    6a95:	bf 65 00 00 00       	mov    $0x65,%edi
    6a9a:	e8 d1 b7 ff ff       	call   2270 <exit@plt>
    6a9f:	90                   	nop

0000000000006aa0 <fwp_flush>:
    6aa0:	50                   	push   %rax
    6aa1:	48 8b 3d c0 ec 00 00 	mov    0xecc0(%rip),%rdi        # 15768 <fwp_prog_out>
    6aa8:	48 85 ff             	test   %rdi,%rdi
    6aab:	74 05                	je     6ab2 <fwp_flush+0x12>
    6aad:	e8 2e b7 ff ff       	call   21e0 <fflush@plt>
    6ab2:	48 8b 05 07 c5 00 00 	mov    0xc507(%rip),%rax        # 12fc0 <stdout@GLIBC_2.2.5>
    6ab9:	48 8b 38             	mov    (%rax),%rdi
    6abc:	58                   	pop    %rax
    6abd:	e9 1e b7 ff ff       	jmp    21e0 <fflush@plt>
    6ac2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6ac9:	1f 84 00 00 00 00 00 

0000000000006ad0 <fwp_rc_forget_slot>:
    6ad0:	50                   	push   %rax
    6ad1:	80 3f ff             	cmpb   $0xff,(%rdi)
    6ad4:	74 02                	je     6ad8 <fwp_rc_forget_slot+0x8>
    6ad6:	58                   	pop    %rax
    6ad7:	c3                   	ret
    6ad8:	48 89 f8             	mov    %rdi,%rax
    6adb:	48 c1 e8 11          	shr    $0x11,%rax
    6adf:	31 f8                	xor    %edi,%eax
    6ae1:	89 c1                	mov    %eax,%ecx
    6ae3:	c1 e9 09             	shr    $0x9,%ecx
    6ae6:	31 c1                	xor    %eax,%ecx
    6ae8:	0f b6 c9             	movzbl %cl,%ecx
    6aeb:	48 8d 15 76 c6 00 00 	lea    0xc676(%rip),%rdx        # 13168 <fwp_gc>
    6af2:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6af9:	00 
    6afa:	48 85 c0             	test   %rax,%rax
    6afd:	0f 84 9e 00 00 00    	je     6ba1 <fwp_rc_forget_slot+0xd1>
    6b03:	48 39 38             	cmp    %rdi,(%rax)
    6b06:	74 23                	je     6b2b <fwp_rc_forget_slot+0x5b>
    6b08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6b0f:	00 
    6b10:	48 89 c1             	mov    %rax,%rcx
    6b13:	48 8b 40 10          	mov    0x10(%rax),%rax
    6b17:	48 85 c0             	test   %rax,%rax
    6b1a:	0f 84 81 00 00 00    	je     6ba1 <fwp_rc_forget_slot+0xd1>
    6b20:	48 39 38             	cmp    %rdi,(%rax)
    6b23:	75 eb                	jne    6b10 <fwp_rc_forget_slot+0x40>
    6b25:	48 83 c1 10          	add    $0x10,%rcx
    6b29:	eb 0b                	jmp    6b36 <fwp_rc_forget_slot+0x66>
    6b2b:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    6b2f:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    6b36:	48 8b 50 10          	mov    0x10(%rax),%rdx
    6b3a:	48 89 11             	mov    %rdx,(%rcx)
    6b3d:	8b 48 f4             	mov    -0xc(%rax),%ecx
    6b40:	b2 01                	mov    $0x1,%dl
    6b42:	86 15 a0 e8 00 00    	xchg   %dl,0xe8a0(%rip)        # 153e8 <fwp_static+0x848>
    6b48:	84 d2                	test   %dl,%dl
    6b4a:	75 f4                	jne    6b40 <fwp_rc_forget_slot+0x70>
    6b4c:	48 29 c8             	sub    %rcx,%rax
    6b4f:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
    6b53:	8b 70 f0             	mov    -0x10(%rax),%esi
    6b56:	89 f1                	mov    %esi,%ecx
    6b58:	c1 e9 02             	shr    $0x2,%ecx
    6b5b:	bf 01 00 00 00       	mov    $0x1,%edi
    6b60:	48 d3 e7             	shl    %cl,%rdi
    6b63:	89 f1                	mov    %esi,%ecx
    6b65:	83 e1 03             	and    $0x3,%ecx
    6b68:	49 89 f8             	mov    %rdi,%r8
    6b6b:	49 c1 e8 02          	shr    $0x2,%r8
    6b6f:	4c 0f af c1          	imul   %rcx,%r8
    6b73:	49 01 f8             	add    %rdi,%r8
    6b76:	4c 29 05 5b e8 00 00 	sub    %r8,0xe85b(%rip)        # 153d8 <fwp_static+0x838>
    6b7d:	48 8d 0d 1c e0 00 00 	lea    0xe01c(%rip),%rcx        # 14ba0 <fwp_static>
    6b84:	48 8b 7c f1 38       	mov    0x38(%rcx,%rsi,8),%rdi
    6b89:	48 89 38             	mov    %rdi,(%rax)
    6b8c:	48 89 54 f1 38       	mov    %rdx,0x38(%rcx,%rsi,8)
    6b91:	c6 05 50 e8 00 00 00 	movb   $0x0,0xe850(%rip)        # 153e8 <fwp_static+0x848>
    6b98:	48 ff 0d e1 df 00 00 	decq   0xdfe1(%rip)        # 14b80 <fwp_gc+0x1a18>
    6b9f:	58                   	pop    %rax
    6ba0:	c3                   	ret
    6ba1:	e8 fa fe ff ff       	call   6aa0 <fwp_flush>
    6ba6:	48 8b 05 33 c4 00 00 	mov    0xc433(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6bad:	48 8b 38             	mov    (%rax),%rdi
    6bb0:	48 8d 35 16 89 00 00 	lea    0x8916(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6bb7:	48 8d 15 1e 89 00 00 	lea    0x891e(%rip),%rdx        # f4dc <fwp_segv.msg+0x25c>
    6bbe:	31 c0                	xor    %eax,%eax
    6bc0:	e8 db b5 ff ff       	call   21a0 <fprintf@plt>
    6bc5:	bf 65 00 00 00       	mov    $0x65,%edi
    6bca:	e8 a1 b6 ff ff       	call   2270 <exit@plt>
    6bcf:	90                   	nop

0000000000006bd0 <fwp_p_array_from_list_typed>:
    6bd0:	41 56                	push   %r14
    6bd2:	53                   	push   %rbx
    6bd3:	50                   	push   %rax
    6bd4:	48 89 fb             	mov    %rdi,%rbx
    6bd7:	48 85 ff             	test   %rdi,%rdi
    6bda:	0f 84 ae 00 00 00    	je     6c8e <fwp_p_array_from_list_typed+0xbe>
    6be0:	31 ff                	xor    %edi,%edi
    6be2:	48 89 d8             	mov    %rbx,%rax
    6be5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6bec:	00 00 00 00 
    6bf0:	48 ff c7             	inc    %rdi
    6bf3:	48 8b 40 10          	mov    0x10(%rax),%rax
    6bf7:	48 85 c0             	test   %rax,%rax
    6bfa:	75 f4                	jne    6bf0 <fwp_p_array_from_list_typed+0x20>
    6bfc:	49 89 f6             	mov    %rsi,%r14
    6bff:	e8 cc 00 00 00       	call   6cd0 <fwp_array_typed_new>
    6c04:	48 85 db             	test   %rbx,%rbx
    6c07:	0f 84 88 00 00 00    	je     6c95 <fwp_p_array_from_list_typed+0xc5>
    6c0d:	b9 04 00 00 00       	mov    $0x4,%ecx
    6c12:	ba 84 04 00 00       	mov    $0x484,%edx
    6c17:	be 21 00 00 00       	mov    $0x21,%esi
    6c1c:	bf 42 00 00 00       	mov    $0x42,%edi
    6c21:	49 89 d8             	mov    %rbx,%r8
    6c24:	4d 89 f1             	mov    %r14,%r9
    6c27:	eb 18                	jmp    6c41 <fwp_p_array_from_list_typed+0x71>
    6c29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6c30:	4c 89 54 c8 e8       	mov    %r10,-0x18(%rax,%rcx,8)
    6c35:	4d 8b 40 10          	mov    0x10(%r8),%r8
    6c39:	48 ff c1             	inc    %rcx
    6c3c:	4d 85 c0             	test   %r8,%r8
    6c3f:	74 54                	je     6c95 <fwp_p_array_from_list_typed+0xc5>
    6c41:	48 83 38 00          	cmpq   $0x0,(%rax)
    6c45:	78 56                	js     6c9d <fwp_p_array_from_list_typed+0xcd>
    6c47:	4d 8b 50 08          	mov    0x8(%r8),%r10
    6c4b:	4d 85 c9             	test   %r9,%r9
    6c4e:	74 e0                	je     6c30 <fwp_p_array_from_list_typed+0x60>
    6c50:	45 8b 19             	mov    (%r9),%r11d
    6c53:	41 83 fb 0a          	cmp    $0xa,%r11d
    6c57:	77 d7                	ja     6c30 <fwp_p_array_from_list_typed+0x60>
    6c59:	44 0f a3 da          	bt     %r11d,%edx
    6c5d:	72 21                	jb     6c80 <fwp_p_array_from_list_typed+0xb0>
    6c5f:	44 0f a3 de          	bt     %r11d,%esi
    6c63:	72 22                	jb     6c87 <fwp_p_array_from_list_typed+0xb7>
    6c65:	44 0f a3 df          	bt     %r11d,%edi
    6c69:	73 c5                	jae    6c30 <fwp_p_array_from_list_typed+0x60>
    6c6b:	66 44 89 14 48       	mov    %r10w,(%rax,%rcx,2)
    6c70:	eb c3                	jmp    6c35 <fwp_p_array_from_list_typed+0x65>
    6c72:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c79:	1f 84 00 00 00 00 00 
    6c80:	44 89 54 88 f8       	mov    %r10d,-0x8(%rax,%rcx,4)
    6c85:	eb ae                	jmp    6c35 <fwp_p_array_from_list_typed+0x65>
    6c87:	44 88 54 08 04       	mov    %r10b,0x4(%rax,%rcx,1)
    6c8c:	eb a7                	jmp    6c35 <fwp_p_array_from_list_typed+0x65>
    6c8e:	31 ff                	xor    %edi,%edi
    6c90:	e8 3b 00 00 00       	call   6cd0 <fwp_array_typed_new>
    6c95:	48 83 c4 08          	add    $0x8,%rsp
    6c99:	5b                   	pop    %rbx
    6c9a:	41 5e                	pop    %r14
    6c9c:	c3                   	ret
    6c9d:	e8 fe fd ff ff       	call   6aa0 <fwp_flush>
    6ca2:	48 8b 05 37 c3 00 00 	mov    0xc337(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6ca9:	48 8b 38             	mov    (%rax),%rdi
    6cac:	48 8d 35 1a 88 00 00 	lea    0x881a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6cb3:	48 8d 15 6b 89 00 00 	lea    0x896b(%rip),%rdx        # f625 <fwp_segv.msg+0x3a5>
    6cba:	31 c0                	xor    %eax,%eax
    6cbc:	e8 df b4 ff ff       	call   21a0 <fprintf@plt>
    6cc1:	bf 65 00 00 00       	mov    $0x65,%edi
    6cc6:	e8 a5 b5 ff ff       	call   2270 <exit@plt>
    6ccb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006cd0 <fwp_array_typed_new>:
    6cd0:	41 56                	push   %r14
    6cd2:	53                   	push   %rbx
    6cd3:	50                   	push   %rax
    6cd4:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6cdb:	ff ff 1f 
    6cde:	48 39 c7             	cmp    %rax,%rdi
    6ce1:	0f 83 21 02 00 00    	jae    6f08 <fwp_array_typed_new+0x238>
    6ce7:	48 89 fb             	mov    %rdi,%rbx
    6cea:	48 85 f6             	test   %rsi,%rsi
    6ced:	74 23                	je     6d12 <fwp_array_typed_new+0x42>
    6cef:	8b 06                	mov    (%rsi),%eax
    6cf1:	48 83 f8 0a          	cmp    $0xa,%rax
    6cf5:	77 0e                	ja     6d05 <fwp_array_typed_new+0x35>
    6cf7:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    6cfc:	0f a3 c1             	bt     %eax,%ecx
    6cff:	0f 82 93 00 00 00    	jb     6d98 <fwp_array_typed_new+0xc8>
    6d05:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    6d0c:	00 
    6d0d:	e9 95 00 00 00       	jmp    6da7 <fwp_array_typed_new+0xd7>
    6d12:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    6d19:	00 
    6d1a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6d21:	77 68                	ja     6d8b <fwp_array_typed_new+0xbb>
    6d23:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    6d27:	48 c1 e8 04          	shr    $0x4,%rax
    6d2b:	48 8d 0d 36 c4 00 00 	lea    0xc436(%rip),%rcx        # 13168 <fwp_gc>
    6d32:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    6d39:	00 
    6d3a:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    6d41:	48 29 05 20 c4 00 00 	sub    %rax,0xc420(%rip)        # 13168 <fwp_gc>
    6d48:	78 41                	js     6d8b <fwp_array_typed_new+0xbb>
    6d4a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6d4e:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    6d52:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    6d59:	4c 8b 37             	mov    (%rdi),%r14
    6d5c:	4d 85 f6             	test   %r14,%r14
    6d5f:	74 0e                	je     6d6f <fwp_array_typed_new+0x9f>
    6d61:	49 8b 0e             	mov    (%r14),%rcx
    6d64:	48 f7 d1             	not    %rcx
    6d67:	48 89 0f             	mov    %rcx,(%rdi)
    6d6a:	e9 f8 00 00 00       	jmp    6e67 <fwp_array_typed_new+0x197>
    6d6f:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    6d76:	00 
    6d77:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    6d7e:	00 
    6d7f:	4c 29 f7             	sub    %r14,%rdi
    6d82:	48 39 c7             	cmp    %rax,%rdi
    6d85:	0f 83 ca 00 00 00    	jae    6e55 <fwp_array_typed_new+0x185>
    6d8b:	48 89 d7             	mov    %rdx,%rdi
    6d8e:	be 02 00 00 00       	mov    $0x2,%esi
    6d93:	e9 9c 00 00 00       	jmp    6e34 <fwp_array_typed_new+0x164>
    6d98:	48 8d 0d 01 85 00 00 	lea    0x8501(%rip),%rcx        # f2a0 <fwp_segv.msg+0x20>
    6d9f:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    6da3:	48 0f af cb          	imul   %rbx,%rcx
    6da7:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    6dab:	83 f8 0b             	cmp    $0xb,%eax
    6dae:	0f 87 66 ff ff ff    	ja     6d1a <fwp_array_typed_new+0x4a>
    6db4:	be ef 0d 00 00       	mov    $0xdef,%esi
    6db9:	0f a3 c6             	bt     %eax,%esi
    6dbc:	0f 83 58 ff ff ff    	jae    6d1a <fwp_array_typed_new+0x4a>
    6dc2:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    6dc9:	77 61                	ja     6e2c <fwp_array_typed_new+0x15c>
    6dcb:	48 83 c1 17          	add    $0x17,%rcx
    6dcf:	48 c1 e9 04          	shr    $0x4,%rcx
    6dd3:	48 8d 05 8e c3 00 00 	lea    0xc38e(%rip),%rax        # 13168 <fwp_gc>
    6dda:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    6de1:	00 
    6de2:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    6de9:	48 29 0d 78 c3 00 00 	sub    %rcx,0xc378(%rip)        # 13168 <fwp_gc>
    6df0:	78 3a                	js     6e2c <fwp_array_typed_new+0x15c>
    6df2:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6df6:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    6dfa:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6e01:	4c 8b 37             	mov    (%rdi),%r14
    6e04:	4d 85 f6             	test   %r14,%r14
    6e07:	74 0b                	je     6e14 <fwp_array_typed_new+0x144>
    6e09:	49 8b 06             	mov    (%r14),%rax
    6e0c:	48 f7 d0             	not    %rax
    6e0f:	48 89 07             	mov    %rax,(%rdi)
    6e12:	eb 3a                	jmp    6e4e <fwp_array_typed_new+0x17e>
    6e14:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    6e1b:	00 
    6e1c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6e23:	00 
    6e24:	4c 29 f7             	sub    %r14,%rdi
    6e27:	48 39 cf             	cmp    %rcx,%rdi
    6e2a:	73 12                	jae    6e3e <fwp_array_typed_new+0x16e>
    6e2c:	48 89 d7             	mov    %rdx,%rdi
    6e2f:	be 01 00 00 00       	mov    $0x1,%esi
    6e34:	e8 07 01 00 00       	call   6f40 <fwp_gc_alloc_slow>
    6e39:	49 89 c6             	mov    %rax,%r14
    6e3c:	eb 36                	jmp    6e74 <fwp_array_typed_new+0x1a4>
    6e3e:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    6e42:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    6e48:	4c 01 f1             	add    %r14,%rcx
    6e4b:	48 89 08             	mov    %rcx,(%rax)
    6e4e:	4c 89 f7             	mov    %r14,%rdi
    6e51:	31 f6                	xor    %esi,%esi
    6e53:	eb 1a                	jmp    6e6f <fwp_array_typed_new+0x19f>
    6e55:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    6e59:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    6e60:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    6e64:	48 89 11             	mov    %rdx,(%rcx)
    6e67:	4c 89 f7             	mov    %r14,%rdi
    6e6a:	31 f6                	xor    %esi,%esi
    6e6c:	48 89 c2             	mov    %rax,%rdx
    6e6f:	e8 ac b2 ff ff       	call   2120 <memset@plt>
    6e74:	49 89 1e             	mov    %rbx,(%r14)
    6e77:	4c 89 f0             	mov    %r14,%rax
    6e7a:	48 2b 05 17 d3 00 00 	sub    0xd317(%rip),%rax        # 14198 <fwp_gc+0x1030>
    6e81:	48 8b 0d 38 d3 00 00 	mov    0xd338(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    6e88:	48 c1 e1 10          	shl    $0x10,%rcx
    6e8c:	48 39 c8             	cmp    %rcx,%rax
    6e8f:	73 6c                	jae    6efd <fwp_array_typed_new+0x22d>
    6e91:	48 8b 0d 48 d3 00 00 	mov    0xd348(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    6e98:	48 89 c2             	mov    %rax,%rdx
    6e9b:	48 c1 ea 10          	shr    $0x10,%rdx
    6e9f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6ea6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6eaa:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6eb0:	75 1b                	jne    6ecd <fwp_array_typed_new+0x1fd>
    6eb2:	40 80 fe 02          	cmp    $0x2,%sil
    6eb6:	75 15                	jne    6ecd <fwp_array_typed_new+0x1fd>
    6eb8:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6ebc:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6ec3:	80 3b ff             	cmpb   $0xff,(%rbx)
    6ec6:	74 2b                	je     6ef3 <fwp_array_typed_new+0x223>
    6ec8:	c6 03 01             	movb   $0x1,(%rbx)
    6ecb:	eb 30                	jmp    6efd <fwp_array_typed_new+0x22d>
    6ecd:	40 80 fe 01          	cmp    $0x1,%sil
    6ed1:	75 2a                	jne    6efd <fwp_array_typed_new+0x22d>
    6ed3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6ed7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6edb:	48 0f af c1          	imul   %rcx,%rax
    6edf:	48 c1 e8 20          	shr    $0x20,%rax
    6ee3:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6ee7:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6eee:	80 3b ff             	cmpb   $0xff,(%rbx)
    6ef1:	75 d5                	jne    6ec8 <fwp_array_typed_new+0x1f8>
    6ef3:	48 89 df             	mov    %rbx,%rdi
    6ef6:	e8 d5 fb ff ff       	call   6ad0 <fwp_rc_forget_slot>
    6efb:	eb cb                	jmp    6ec8 <fwp_array_typed_new+0x1f8>
    6efd:	4c 89 f0             	mov    %r14,%rax
    6f00:	48 83 c4 08          	add    $0x8,%rsp
    6f04:	5b                   	pop    %rbx
    6f05:	41 5e                	pop    %r14
    6f07:	c3                   	ret
    6f08:	e8 93 fb ff ff       	call   6aa0 <fwp_flush>
    6f0d:	48 8b 05 cc c0 00 00 	mov    0xc0cc(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    6f14:	48 8b 38             	mov    (%rax),%rdi
    6f17:	48 8d 35 af 85 00 00 	lea    0x85af(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6f1e:	48 8d 15 de 85 00 00 	lea    0x85de(%rip),%rdx        # f503 <fwp_segv.msg+0x283>
    6f25:	31 c0                	xor    %eax,%eax
    6f27:	e8 74 b2 ff ff       	call   21a0 <fprintf@plt>
    6f2c:	bf 65 00 00 00       	mov    $0x65,%edi
    6f31:	e8 3a b3 ff ff       	call   2270 <exit@plt>
    6f36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    6f3d:	00 00 00 

0000000000006f40 <fwp_gc_alloc_slow>:
    6f40:	41 57                	push   %r15
    6f42:	41 56                	push   %r14
    6f44:	41 55                	push   %r13
    6f46:	41 54                	push   %r12
    6f48:	53                   	push   %rbx
    6f49:	89 f3                	mov    %esi,%ebx
    6f4b:	83 3d 02 d2 00 00 00 	cmpl   $0x0,0xd202(%rip)        # 14154 <fwp_gc+0xfec>
    6f52:	74 19                	je     6f6d <fwp_gc_alloc_slow+0x2d>
    6f54:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    6f5b:	72 24                	jb     6f81 <fwp_gc_alloc_slow+0x41>
    6f5d:	89 de                	mov    %ebx,%esi
    6f5f:	5b                   	pop    %rbx
    6f60:	41 5c                	pop    %r12
    6f62:	41 5d                	pop    %r13
    6f64:	41 5e                	pop    %r14
    6f66:	41 5f                	pop    %r15
    6f68:	e9 d3 04 00 00       	jmp    7440 <fwp_gc_alloc_big>
    6f6d:	49 89 fe             	mov    %rdi,%r14
    6f70:	e8 5b 01 00 00       	call   70d0 <fwp_gc_init>
    6f75:	4c 89 f7             	mov    %r14,%rdi
    6f78:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    6f7f:	73 dc                	jae    6f5d <fwp_gc_alloc_slow+0x1d>
    6f81:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    6f85:	48 c1 e8 04          	shr    $0x4,%rax
    6f89:	4c 8d 3d d8 c1 00 00 	lea    0xc1d8(%rip),%r15        # 13168 <fwp_gc>
    6f90:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    6f97:	00 00 
    6f99:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    6fa0:	00 
    6fa1:	48 83 3d bf c1 00 00 	cmpq   $0x0,0xc1bf(%rip)        # 13168 <fwp_gc>
    6fa8:	00 
    6fa9:	0f 89 8c 00 00 00    	jns    703b <fwp_gc_alloc_slow+0xfb>
    6faf:	83 3d 9e d1 00 00 00 	cmpl   $0x0,0xd19e(%rip)        # 14154 <fwp_gc+0xfec>
    6fb6:	75 11                	jne    6fc9 <fwp_gc_alloc_slow+0x89>
    6fb8:	49 89 fc             	mov    %rdi,%r12
    6fbb:	49 89 d5             	mov    %rdx,%r13
    6fbe:	e8 0d 01 00 00       	call   70d0 <fwp_gc_init>
    6fc3:	4c 89 ea             	mov    %r13,%rdx
    6fc6:	4c 89 e7             	mov    %r12,%rdi
    6fc9:	8b 0d 8d d1 00 00    	mov    0xd18d(%rip),%ecx        # 1415c <fwp_gc+0xff4>
    6fcf:	85 c9                	test   %ecx,%ecx
    6fd1:	74 2a                	je     6ffd <fwp_gc_alloc_slow+0xbd>
    6fd3:	48 8b 05 ae d1 00 00 	mov    0xd1ae(%rip),%rax        # 14188 <fwp_gc+0x1020>
    6fda:	48 85 c0             	test   %rax,%rax
    6fdd:	74 1e                	je     6ffd <fwp_gc_alloc_slow+0xbd>
    6fdf:	48 8b 0d aa d1 00 00 	mov    0xd1aa(%rip),%rcx        # 14190 <fwp_gc+0x1028>
    6fe6:	48 ff c1             	inc    %rcx
    6fe9:	48 89 0d a0 d1 00 00 	mov    %rcx,0xd1a0(%rip)        # 14190 <fwp_gc+0x1028>
    6ff0:	48 39 c1             	cmp    %rax,%rcx
    6ff3:	0f 8d c7 00 00 00    	jge    70c0 <fwp_gc_alloc_slow+0x180>
    6ff9:	31 c0                	xor    %eax,%eax
    6ffb:	eb 0d                	jmp    700a <fwp_gc_alloc_slow+0xca>
    6ffd:	b8 00 00 80 00       	mov    $0x800000,%eax
    7002:	85 c9                	test   %ecx,%ecx
    7004:	0f 85 b1 00 00 00    	jne    70bb <fwp_gc_alloc_slow+0x17b>
    700a:	48 8b 0d 67 d3 00 00 	mov    0xd367(%rip),%rcx        # 14378 <fwp_gc+0x1210>
    7011:	48 2b 0d 50 c1 00 00 	sub    0xc150(%rip),%rcx        # 13168 <fwp_gc>
    7018:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    701d:	f2 0f 58 05 2b d3 00 	addsd  0xd32b(%rip),%xmm0        # 14350 <fwp_gc+0x11e8>
    7024:	00 
    7025:	f2 0f 11 05 23 d3 00 	movsd  %xmm0,0xd323(%rip)        # 14350 <fwp_gc+0x11e8>
    702c:	00 
    702d:	48 89 05 44 d3 00 00 	mov    %rax,0xd344(%rip)        # 14378 <fwp_gc+0x1210>
    7034:	48 89 05 2d c1 00 00 	mov    %rax,0xc12d(%rip)        # 13168 <fwp_gc>
    703b:	89 d8                	mov    %ebx,%eax
    703d:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    7044:	49 01 c7             	add    %rax,%r15
    7047:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    704b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    704f:	48 83 c1 08          	add    $0x8,%rcx
    7053:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    7058:	48 85 c0             	test   %rax,%rax
    705b:	74 08                	je     7065 <fwp_gc_alloc_slow+0x125>
    705d:	48 8b 30             	mov    (%rax),%rsi
    7060:	48 f7 d6             	not    %rsi
    7063:	eb 39                	jmp    709e <fwp_gc_alloc_slow+0x15e>
    7065:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    706a:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    706f:	49 29 c0             	sub    %rax,%r8
    7072:	49 39 d0             	cmp    %rdx,%r8
    7075:	73 1b                	jae    7092 <fwp_gc_alloc_slow+0x152>
    7077:	49 89 ff             	mov    %rdi,%r15
    707a:	48 89 cf             	mov    %rcx,%rdi
    707d:	44 89 f6             	mov    %r14d,%esi
    7080:	49 89 d6             	mov    %rdx,%r14
    7083:	89 da                	mov    %ebx,%edx
    7085:	e8 e6 05 00 00       	call   7670 <fwp_gc_refill>
    708a:	4c 89 f2             	mov    %r14,%rdx
    708d:	4c 89 ff             	mov    %r15,%rdi
    7090:	eb 0f                	jmp    70a1 <fwp_gc_alloc_slow+0x161>
    7092:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    7096:	48 83 c1 10          	add    $0x10,%rcx
    709a:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    709e:	48 89 31             	mov    %rsi,(%rcx)
    70a1:	83 fb 01             	cmp    $0x1,%ebx
    70a4:	48 0f 44 d7          	cmove  %rdi,%rdx
    70a8:	48 89 c7             	mov    %rax,%rdi
    70ab:	31 f6                	xor    %esi,%esi
    70ad:	5b                   	pop    %rbx
    70ae:	41 5c                	pop    %r12
    70b0:	41 5d                	pop    %r13
    70b2:	41 5e                	pop    %r14
    70b4:	41 5f                	pop    %r15
    70b6:	e9 65 b0 ff ff       	jmp    2120 <memset@plt>
    70bb:	e8 30 08 00 00       	call   78f0 <fwp_gc_collect>
    70c0:	48 c7 05 c5 d0 00 00 	movq   $0x0,0xd0c5(%rip)        # 14190 <fwp_gc+0x1028>
    70c7:	00 00 00 00 
    70cb:	e8 20 08 00 00       	call   78f0 <fwp_gc_collect>

00000000000070d0 <fwp_gc_init>:
    70d0:	41 56                	push   %r14
    70d2:	53                   	push   %rbx
    70d3:	50                   	push   %rax
    70d4:	c7 05 76 d0 00 00 01 	movl   $0x1,0xd076(%rip)        # 14154 <fwp_gc+0xfec>
    70db:	00 00 00 
    70de:	0f 28 05 4b 7f 00 00 	movaps 0x7f4b(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    70e5:	0f 11 05 c4 cb 00 00 	movups %xmm0,0xcbc4(%rip)        # 13cb0 <fwp_gc+0xb48>
    70ec:	0f 28 05 4d 7f 00 00 	movaps 0x7f4d(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    70f3:	0f 11 05 c6 cb 00 00 	movups %xmm0,0xcbc6(%rip)        # 13cc0 <fwp_gc+0xb58>
    70fa:	0f 28 05 4f 7f 00 00 	movaps 0x7f4f(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    7101:	0f 11 05 c8 cb 00 00 	movups %xmm0,0xcbc8(%rip)        # 13cd0 <fwp_gc+0xb68>
    7108:	0f 28 05 51 7f 00 00 	movaps 0x7f51(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    710f:	0f 11 05 ca cb 00 00 	movups %xmm0,0xcbca(%rip)        # 13ce0 <fwp_gc+0xb78>
    7116:	0f 28 05 53 7f 00 00 	movaps 0x7f53(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    711d:	0f 11 05 cc cb 00 00 	movups %xmm0,0xcbcc(%rip)        # 13cf0 <fwp_gc+0xb88>
    7124:	0f 28 05 55 7f 00 00 	movaps 0x7f55(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    712b:	0f 11 05 ce cb 00 00 	movups %xmm0,0xcbce(%rip)        # 13d00 <fwp_gc+0xb98>
    7132:	0f 28 05 57 7f 00 00 	movaps 0x7f57(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    7139:	0f 11 05 d0 cb 00 00 	movups %xmm0,0xcbd0(%rip)        # 13d10 <fwp_gc+0xba8>
    7140:	0f 28 05 59 7f 00 00 	movaps 0x7f59(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    7147:	0f 11 05 d2 cb 00 00 	movups %xmm0,0xcbd2(%rip)        # 13d20 <fwp_gc+0xbb8>
    714e:	0f 28 05 5b 7f 00 00 	movaps 0x7f5b(%rip),%xmm0        # f0b0 <_IO_stdin_used+0xb0>
    7155:	0f 11 05 d4 cb 00 00 	movups %xmm0,0xcbd4(%rip)        # 13d30 <fwp_gc+0xbc8>
    715c:	0f 28 05 5d 7f 00 00 	movaps 0x7f5d(%rip),%xmm0        # f0c0 <_IO_stdin_used+0xc0>
    7163:	0f 11 05 d6 cb 00 00 	movups %xmm0,0xcbd6(%rip)        # 13d40 <fwp_gc+0xbd8>
    716a:	31 c9                	xor    %ecx,%ecx
    716c:	48 8d 05 f5 bf 00 00 	lea    0xbff5(%rip),%rax        # 13168 <fwp_gc>
    7173:	31 d2                	xor    %edx,%edx
    7175:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    717c:	00 00 00 00 
    7180:	89 d6                	mov    %edx,%esi
    7182:	c1 e6 04             	shl    $0x4,%esi
    7185:	48 ff c9             	dec    %rcx
    7188:	48 89 cf             	mov    %rcx,%rdi
    718b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7190:	48 89 f9             	mov    %rdi,%rcx
    7193:	48 ff c7             	inc    %rdi
    7196:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    719d:	77 f1                	ja     7190 <fwp_gc_init+0xc0>
    719f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    71a6:	00 
    71a7:	48 89 d6             	mov    %rdx,%rsi
    71aa:	48 83 ce 01          	or     $0x1,%rsi
    71ae:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    71b5:	74 26                	je     71dd <fwp_gc_init+0x10d>
    71b7:	89 f7                	mov    %esi,%edi
    71b9:	c1 e7 04             	shl    $0x4,%edi
    71bc:	0f 1f 40 00          	nopl   0x0(%rax)
    71c0:	49 89 c8             	mov    %rcx,%r8
    71c3:	48 ff c1             	inc    %rcx
    71c6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    71cd:	00 
    71ce:	77 f0                	ja     71c0 <fwp_gc_init+0xf0>
    71d0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    71d7:	48 83 c2 02          	add    $0x2,%rdx
    71db:	eb a3                	jmp    7180 <fwp_gc_init+0xb0>
    71dd:	e8 4e b9 ff ff       	call   2b30 <fwp_static_init>
    71e2:	48 8b 05 07 e2 00 00 	mov    0xe207(%rip),%rax        # 153f0 <fwp_static+0x850>
    71e9:	48 89 05 a8 cf 00 00 	mov    %rax,0xcfa8(%rip)        # 14198 <fwp_gc+0x1030>
    71f0:	48 8b 05 09 e2 00 00 	mov    0xe209(%rip),%rax        # 15400 <fwp_static+0x860>
    71f7:	48 c1 e8 10          	shr    $0x10,%rax
    71fb:	48 89 05 b6 cf 00 00 	mov    %rax,0xcfb6(%rip)        # 141b8 <fwp_gc+0x1050>
    7202:	48 8b 0d ff e1 00 00 	mov    0xe1ff(%rip),%rcx        # 15408 <fwp_static+0x868>
    7209:	48 89 0d d8 cf 00 00 	mov    %rcx,0xcfd8(%rip)        # 141e8 <fwp_gc+0x1080>
    7210:	48 8b 0d e1 e1 00 00 	mov    0xe1e1(%rip),%rcx        # 153f8 <fwp_static+0x858>
    7217:	48 89 0d c2 cf 00 00 	mov    %rcx,0xcfc2(%rip)        # 141e0 <fwp_gc+0x1078>
    721e:	48 89 05 a3 cf 00 00 	mov    %rax,0xcfa3(%rip)        # 141c8 <fwp_gc+0x1060>
    7225:	48 8d 3d e7 82 00 00 	lea    0x82e7(%rip),%rdi        # f513 <fwp_segv.msg+0x293>
    722c:	e8 ff ad ff ff       	call   2030 <getenv@plt>
    7231:	48 85 c0             	test   %rax,%rax
    7234:	74 2e                	je     7264 <fwp_gc_init+0x194>
    7236:	48 89 c3             	mov    %rax,%rbx
    7239:	48 8d 35 da 82 00 00 	lea    0x82da(%rip),%rsi        # f51a <fwp_segv.msg+0x29a>
    7240:	48 89 c7             	mov    %rax,%rdi
    7243:	e8 28 af ff ff       	call   2170 <strcmp@plt>
    7248:	85 c0                	test   %eax,%eax
    724a:	74 1f                	je     726b <fwp_gc_init+0x19b>
    724c:	48 8d 35 b6 84 00 00 	lea    0x84b6(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7253:	48 89 df             	mov    %rbx,%rdi
    7256:	e8 15 af ff ff       	call   2170 <strcmp@plt>
    725b:	31 c9                	xor    %ecx,%ecx
    725d:	85 c0                	test   %eax,%eax
    725f:	0f 95 c1             	setne  %cl
    7262:	eb 09                	jmp    726d <fwp_gc_init+0x19d>
    7264:	b9 01 00 00 00       	mov    $0x1,%ecx
    7269:	eb 02                	jmp    726d <fwp_gc_init+0x19d>
    726b:	31 c9                	xor    %ecx,%ecx
    726d:	89 0d e5 ce 00 00    	mov    %ecx,0xcee5(%rip)        # 14158 <fwp_gc+0xff0>
    7273:	48 8d 3d a4 82 00 00 	lea    0x82a4(%rip),%rdi        # f51e <fwp_segv.msg+0x29e>
    727a:	e8 b1 ad ff ff       	call   2030 <getenv@plt>
    727f:	31 c9                	xor    %ecx,%ecx
    7281:	48 85 c0             	test   %rax,%rax
    7284:	74 1b                	je     72a1 <fwp_gc_init+0x1d1>
    7286:	80 38 00             	cmpb   $0x0,(%rax)
    7289:	74 16                	je     72a1 <fwp_gc_init+0x1d1>
    728b:	48 8d 35 77 84 00 00 	lea    0x8477(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7292:	48 89 c7             	mov    %rax,%rdi
    7295:	e8 d6 ae ff ff       	call   2170 <strcmp@plt>
    729a:	31 c9                	xor    %ecx,%ecx
    729c:	85 c0                	test   %eax,%eax
    729e:	0f 95 c1             	setne  %cl
    72a1:	89 0d bd ce 00 00    	mov    %ecx,0xcebd(%rip)        # 14164 <fwp_gc+0xffc>
    72a7:	48 8d 3d 65 82 00 00 	lea    0x8265(%rip),%rdi        # f513 <fwp_segv.msg+0x293>
    72ae:	e8 7d ad ff ff       	call   2030 <getenv@plt>
    72b3:	48 85 c0             	test   %rax,%rax
    72b6:	74 18                	je     72d0 <fwp_gc_init+0x200>
    72b8:	48 8d 35 6c 82 00 00 	lea    0x826c(%rip),%rsi        # f52b <fwp_segv.msg+0x2ab>
    72bf:	48 89 c7             	mov    %rax,%rdi
    72c2:	e8 a9 ae ff ff       	call   2170 <strcmp@plt>
    72c7:	31 c9                	xor    %ecx,%ecx
    72c9:	85 c0                	test   %eax,%eax
    72cb:	0f 95 c1             	setne  %cl
    72ce:	eb 05                	jmp    72d5 <fwp_gc_init+0x205>
    72d0:	b9 01 00 00 00       	mov    $0x1,%ecx
    72d5:	89 0d 8d ce 00 00    	mov    %ecx,0xce8d(%rip)        # 14168 <fwp_gc+0x1000>
    72db:	c7 05 8b ce 00 00 01 	movl   $0x1,0xce8b(%rip)        # 14170 <fwp_gc+0x1008>
    72e2:	00 00 00 
    72e5:	48 8d 3d 44 82 00 00 	lea    0x8244(%rip),%rdi        # f530 <fwp_segv.msg+0x2b0>
    72ec:	e8 3f ad ff ff       	call   2030 <getenv@plt>
    72f1:	31 c9                	xor    %ecx,%ecx
    72f3:	48 85 c0             	test   %rax,%rax
    72f6:	74 1b                	je     7313 <fwp_gc_init+0x243>
    72f8:	80 38 00             	cmpb   $0x0,(%rax)
    72fb:	74 16                	je     7313 <fwp_gc_init+0x243>
    72fd:	48 8d 35 05 84 00 00 	lea    0x8405(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7304:	48 89 c7             	mov    %rax,%rdi
    7307:	e8 64 ae ff ff       	call   2170 <strcmp@plt>
    730c:	31 c9                	xor    %ecx,%ecx
    730e:	85 c0                	test   %eax,%eax
    7310:	0f 95 c1             	setne  %cl
    7313:	89 0d 53 ce 00 00    	mov    %ecx,0xce53(%rip)        # 1416c <fwp_gc+0x1004>
    7319:	48 8d 3d 1e 82 00 00 	lea    0x821e(%rip),%rdi        # f53e <fwp_segv.msg+0x2be>
    7320:	e8 0b ad ff ff       	call   2030 <getenv@plt>
    7325:	48 85 c0             	test   %rax,%rax
    7328:	74 14                	je     733e <fwp_gc_init+0x26e>
    732a:	48 89 c7             	mov    %rax,%rdi
    732d:	31 f6                	xor    %esi,%esi
    732f:	ba 0a 00 00 00       	mov    $0xa,%edx
    7334:	e8 87 ae ff ff       	call   21c0 <strtol@plt>
    7339:	48 89 c3             	mov    %rax,%rbx
    733c:	eb 02                	jmp    7340 <fwp_gc_init+0x270>
    733e:	31 db                	xor    %ebx,%ebx
    7340:	31 c0                	xor    %eax,%eax
    7342:	48 85 db             	test   %rbx,%rbx
    7345:	48 0f 4f c3          	cmovg  %rbx,%rax
    7349:	48 89 05 38 ce 00 00 	mov    %rax,0xce38(%rip)        # 14188 <fwp_gc+0x1020>
    7350:	48 8d 3d bc 81 00 00 	lea    0x81bc(%rip),%rdi        # f513 <fwp_segv.msg+0x293>
    7357:	e8 d4 ac ff ff       	call   2030 <getenv@plt>
    735c:	48 85 c0             	test   %rax,%rax
    735f:	74 2e                	je     738f <fwp_gc_init+0x2bf>
    7361:	49 89 c6             	mov    %rax,%r14
    7364:	80 38 00             	cmpb   $0x0,(%rax)
    7367:	74 26                	je     738f <fwp_gc_init+0x2bf>
    7369:	48 8d 35 aa 81 00 00 	lea    0x81aa(%rip),%rsi        # f51a <fwp_segv.msg+0x29a>
    7370:	4c 89 f7             	mov    %r14,%rdi
    7373:	e8 f8 ad ff ff       	call   2170 <strcmp@plt>
    7378:	85 c0                	test   %eax,%eax
    737a:	74 13                	je     738f <fwp_gc_init+0x2bf>
    737c:	48 8d 35 86 83 00 00 	lea    0x8386(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7383:	4c 89 f7             	mov    %r14,%rdi
    7386:	e8 e5 ad ff ff       	call   2170 <strcmp@plt>
    738b:	85 c0                	test   %eax,%eax
    738d:	75 5f                	jne    73ee <fwp_gc_init+0x31e>
    738f:	48 85 db             	test   %rbx,%rbx
    7392:	7f 5a                	jg     73ee <fwp_gc_init+0x31e>
    7394:	83 3d d1 cd 00 00 00 	cmpl   $0x0,0xcdd1(%rip)        # 1416c <fwp_gc+0x1004>
    739b:	75 51                	jne    73ee <fwp_gc_init+0x31e>
    739d:	48 8d 3d e5 81 00 00 	lea    0x81e5(%rip),%rdi        # f589 <fwp_segv.msg+0x309>
    73a4:	e8 87 ac ff ff       	call   2030 <getenv@plt>
    73a9:	48 85 c0             	test   %rax,%rax
    73ac:	74 18                	je     73c6 <fwp_gc_init+0x2f6>
    73ae:	80 38 00             	cmpb   $0x0,(%rax)
    73b1:	74 13                	je     73c6 <fwp_gc_init+0x2f6>
    73b3:	48 8d 35 4f 83 00 00 	lea    0x834f(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    73ba:	48 89 c7             	mov    %rax,%rdi
    73bd:	e8 ae ad ff ff       	call   2170 <strcmp@plt>
    73c2:	85 c0                	test   %eax,%eax
    73c4:	75 56                	jne    741c <fwp_gc_init+0x34c>
    73c6:	c7 05 88 cd 00 00 00 	movl   $0x0,0xcd88(%rip)        # 14158 <fwp_gc+0xff0>
    73cd:	00 00 00 
    73d0:	48 c7 05 9d cf 00 00 	movq   $0x800000,0xcf9d(%rip)        # 14378 <fwp_gc+0x1210>
    73d7:	00 00 80 00 
    73db:	48 c7 05 82 bd 00 00 	movq   $0x800000,0xbd82(%rip)        # 13168 <fwp_gc>
    73e2:	00 00 80 00 
    73e6:	48 83 c4 08          	add    $0x8,%rsp
    73ea:	5b                   	pop    %rbx
    73eb:	41 5e                	pop    %r14
    73ed:	c3                   	ret
    73ee:	e8 ad f6 ff ff       	call   6aa0 <fwp_flush>
    73f3:	48 8b 05 e6 bb 00 00 	mov    0xbbe6(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    73fa:	48 8b 38             	mov    (%rax),%rdi
    73fd:	48 8d 35 c9 80 00 00 	lea    0x80c9(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7404:	48 8d 15 41 81 00 00 	lea    0x8141(%rip),%rdx        # f54c <fwp_segv.msg+0x2cc>
    740b:	31 c0                	xor    %eax,%eax
    740d:	e8 8e ad ff ff       	call   21a0 <fprintf@plt>
    7412:	bf 65 00 00 00       	mov    $0x65,%edi
    7417:	e8 54 ae ff ff       	call   2270 <exit@plt>
    741c:	e8 7f f6 ff ff       	call   6aa0 <fwp_flush>
    7421:	48 8b 05 b8 bb 00 00 	mov    0xbbb8(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7428:	48 8b 38             	mov    (%rax),%rdi
    742b:	48 8d 35 9b 80 00 00 	lea    0x809b(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7432:	48 8d 15 61 81 00 00 	lea    0x8161(%rip),%rdx        # f59a <fwp_segv.msg+0x31a>
    7439:	eb d0                	jmp    740b <fwp_gc_init+0x33b>
    743b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007440 <fwp_gc_alloc_big>:
    7440:	55                   	push   %rbp
    7441:	41 57                	push   %r15
    7443:	41 56                	push   %r14
    7445:	41 55                	push   %r13
    7447:	41 54                	push   %r12
    7449:	53                   	push   %rbx
    744a:	50                   	push   %rax
    744b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    7452:	00 00 40 
    7455:	48 39 c7             	cmp    %rax,%rdi
    7458:	0f 83 ce 01 00 00    	jae    762c <fwp_gc_alloc_big+0x1ec>
    745e:	89 f5                	mov    %esi,%ebp
    7460:	48 89 fb             	mov    %rdi,%rbx
    7463:	48 29 3d fe bc 00 00 	sub    %rdi,0xbcfe(%rip)        # 13168 <fwp_gc>
    746a:	0f 89 80 00 00 00    	jns    74f0 <fwp_gc_alloc_big+0xb0>
    7470:	83 3d dd cc 00 00 00 	cmpl   $0x0,0xccdd(%rip)        # 14154 <fwp_gc+0xfec>
    7477:	75 05                	jne    747e <fwp_gc_alloc_big+0x3e>
    7479:	e8 52 fc ff ff       	call   70d0 <fwp_gc_init>
    747e:	8b 0d d8 cc 00 00    	mov    0xccd8(%rip),%ecx        # 1415c <fwp_gc+0xff4>
    7484:	85 c9                	test   %ecx,%ecx
    7486:	74 2a                	je     74b2 <fwp_gc_alloc_big+0x72>
    7488:	48 8b 05 f9 cc 00 00 	mov    0xccf9(%rip),%rax        # 14188 <fwp_gc+0x1020>
    748f:	48 85 c0             	test   %rax,%rax
    7492:	74 1e                	je     74b2 <fwp_gc_alloc_big+0x72>
    7494:	48 8b 0d f5 cc 00 00 	mov    0xccf5(%rip),%rcx        # 14190 <fwp_gc+0x1028>
    749b:	48 ff c1             	inc    %rcx
    749e:	48 89 0d eb cc 00 00 	mov    %rcx,0xcceb(%rip)        # 14190 <fwp_gc+0x1028>
    74a5:	48 39 c1             	cmp    %rax,%rcx
    74a8:	0f 8d ad 01 00 00    	jge    765b <fwp_gc_alloc_big+0x21b>
    74ae:	31 c0                	xor    %eax,%eax
    74b0:	eb 0d                	jmp    74bf <fwp_gc_alloc_big+0x7f>
    74b2:	b8 00 00 80 00       	mov    $0x800000,%eax
    74b7:	85 c9                	test   %ecx,%ecx
    74b9:	0f 85 97 01 00 00    	jne    7656 <fwp_gc_alloc_big+0x216>
    74bf:	48 8b 0d b2 ce 00 00 	mov    0xceb2(%rip),%rcx        # 14378 <fwp_gc+0x1210>
    74c6:	48 2b 0d 9b bc 00 00 	sub    0xbc9b(%rip),%rcx        # 13168 <fwp_gc>
    74cd:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    74d2:	f2 0f 58 05 76 ce 00 	addsd  0xce76(%rip),%xmm0        # 14350 <fwp_gc+0x11e8>
    74d9:	00 
    74da:	f2 0f 11 05 6e ce 00 	movsd  %xmm0,0xce6e(%rip)        # 14350 <fwp_gc+0x11e8>
    74e1:	00 
    74e2:	48 89 05 8f ce 00 00 	mov    %rax,0xce8f(%rip)        # 14378 <fwp_gc+0x1210>
    74e9:	48 89 05 78 bc 00 00 	mov    %rax,0xbc78(%rip)        # 13168 <fwp_gc>
    74f0:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    74f7:	49 c1 ee 10          	shr    $0x10,%r14
    74fb:	4c 89 f7             	mov    %r14,%rdi
    74fe:	e8 9d 02 00 00       	call   77a0 <fwp_gc_chunks>
    7503:	48 8b 0d d6 cc 00 00 	mov    0xccd6(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    750a:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    7511:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    7516:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    751b:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    7522:	01 
    7523:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    7528:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    752d:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    7531:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    7538:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    753f:	00 ff 
    7541:	0f 84 d2 00 00 00    	je     7619 <fwp_gc_alloc_big+0x1d9>
    7547:	41 c6 07 00          	movb   $0x0,(%r15)
    754b:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    7552:	0f 82 9b 00 00 00    	jb     75f3 <fwp_gc_alloc_big+0x1b3>
    7558:	49 83 fe 03          	cmp    $0x3,%r14
    755c:	ba 02 00 00 00       	mov    $0x2,%edx
    7561:	49 0f 43 d6          	cmovae %r14,%rdx
    7565:	48 8b 0d 74 cc 00 00 	mov    0xcc74(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    756c:	48 ff ca             	dec    %rdx
    756f:	be 01 00 00 00       	mov    $0x1,%esi
    7574:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    757b:	72 5a                	jb     75d7 <fwp_gc_alloc_big+0x197>
    757d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    7581:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    7588:	49 89 d0             	mov    %rdx,%r8
    758b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    758f:	49 f7 d8             	neg    %r8
    7592:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7599:	1f 84 00 00 00 00 00 
    75a0:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    75a7:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    75ae:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    75b4:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    75b8:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    75bc:	89 07                	mov    %eax,(%rdi)
    75be:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    75c5:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    75c9:	49 83 c1 02          	add    $0x2,%r9
    75cd:	48 83 c6 02          	add    $0x2,%rsi
    75d1:	49 83 f9 01          	cmp    $0x1,%r9
    75d5:	75 c9                	jne    75a0 <fwp_gc_alloc_big+0x160>
    75d7:	f6 c2 01             	test   $0x1,%dl
    75da:	74 17                	je     75f3 <fwp_gc_alloc_big+0x1b3>
    75dc:	4c 01 e1             	add    %r12,%rcx
    75df:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    75e6:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    75ea:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    75ef:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    75f3:	48 c1 e0 10          	shl    $0x10,%rax
    75f7:	48 03 05 9a cb 00 00 	add    0xcb9a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    75fe:	48 89 c7             	mov    %rax,%rdi
    7601:	31 f6                	xor    %esi,%esi
    7603:	48 89 da             	mov    %rbx,%rdx
    7606:	48 83 c4 08          	add    $0x8,%rsp
    760a:	5b                   	pop    %rbx
    760b:	41 5c                	pop    %r12
    760d:	41 5d                	pop    %r13
    760f:	41 5e                	pop    %r14
    7611:	41 5f                	pop    %r15
    7613:	5d                   	pop    %rbp
    7614:	e9 07 ab ff ff       	jmp    2120 <memset@plt>
    7619:	4c 89 ff             	mov    %r15,%rdi
    761c:	49 89 c5             	mov    %rax,%r13
    761f:	e8 ac f4 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    7624:	4c 89 e8             	mov    %r13,%rax
    7627:	e9 1b ff ff ff       	jmp    7547 <fwp_gc_alloc_big+0x107>
    762c:	48 8b 05 ad b9 00 00 	mov    0xb9ad(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7633:	48 8b 08             	mov    (%rax),%rcx
    7636:	48 8d 3d 9c 7f 00 00 	lea    0x7f9c(%rip),%rdi        # f5d9 <fwp_segv.msg+0x359>
    763d:	be 13 00 00 00       	mov    $0x13,%esi
    7642:	ba 01 00 00 00       	mov    $0x1,%edx
    7647:	e8 34 ac ff ff       	call   2280 <fwrite@plt>
    764c:	bf 66 00 00 00       	mov    $0x66,%edi
    7651:	e8 1a ac ff ff       	call   2270 <exit@plt>
    7656:	e8 95 02 00 00       	call   78f0 <fwp_gc_collect>
    765b:	48 c7 05 2a cb 00 00 	movq   $0x0,0xcb2a(%rip)        # 14190 <fwp_gc+0x1028>
    7662:	00 00 00 00 
    7666:	e8 85 02 00 00       	call   78f0 <fwp_gc_collect>
    766b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007670 <fwp_gc_refill>:
    7670:	55                   	push   %rbp
    7671:	41 57                	push   %r15
    7673:	41 56                	push   %r14
    7675:	41 55                	push   %r13
    7677:	41 54                	push   %r12
    7679:	53                   	push   %rbx
    767a:	50                   	push   %rax
    767b:	89 d5                	mov    %edx,%ebp
    767d:	41 89 f7             	mov    %esi,%r15d
    7680:	48 89 fb             	mov    %rdi,%rbx
    7683:	bf 01 00 00 00       	mov    $0x1,%edi
    7688:	e8 13 01 00 00       	call   77a0 <fwp_gc_chunks>
    768d:	49 89 c6             	mov    %rax,%r14
    7690:	4c 8b 25 49 cb 00 00 	mov    0xcb49(%rip),%r12        # 141e0 <fwp_gc+0x1078>
    7697:	48 8d 05 ca ba 00 00 	lea    0xbaca(%rip),%rax        # 13168 <fwp_gc>
    769e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    76a5:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    76aa:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    76af:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    76b4:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    76ba:	44 89 f9             	mov    %r15d,%ecx
    76bd:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    76c4:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    76c9:	b8 00 00 01 00       	mov    $0x10000,%eax
    76ce:	31 d2                	xor    %edx,%edx
    76d0:	f7 f1                	div    %ecx
    76d2:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    76d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    76dc:	48 01 c8             	add    %rcx,%rax
    76df:	48 0f ba e0 20       	bt     $0x20,%rax
    76e4:	73 07                	jae    76ed <fwp_gc_refill+0x7d>
    76e6:	31 d2                	xor    %edx,%edx
    76e8:	48 f7 f1             	div    %rcx
    76eb:	eb 04                	jmp    76f1 <fwp_gc_refill+0x81>
    76ed:	31 d2                	xor    %edx,%edx
    76ef:	f7 f1                	div    %ecx
    76f1:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    76f6:	48 83 3d 82 d4 00 00 	cmpq   $0x0,0xd482(%rip)        # 14b80 <fwp_gc+0x1a18>
    76fd:	00 
    76fe:	74 2e                	je     772e <fwp_gc_refill+0xbe>
    7700:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    7704:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    770b:	31 ed                	xor    %ebp,%ebp
    770d:	eb 0d                	jmp    771c <fwp_gc_refill+0xac>
    770f:	90                   	nop
    7710:	48 ff c5             	inc    %rbp
    7713:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    771a:	74 12                	je     772e <fwp_gc_refill+0xbe>
    771c:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    7721:	75 ed                	jne    7710 <fwp_gc_refill+0xa0>
    7723:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    7727:	e8 a4 f3 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    772c:	eb e2                	jmp    7710 <fwp_gc_refill+0xa0>
    772e:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    7732:	49 83 c7 08          	add    $0x8,%r15
    7736:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    773a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7741:	ba 00 10 00 00       	mov    $0x1000,%edx
    7746:	31 f6                	xor    %esi,%esi
    7748:	e8 d3 a9 ff ff       	call   2120 <memset@plt>
    774d:	49 c1 e6 10          	shl    $0x10,%r14
    7751:	4c 03 35 40 ca 00 00 	add    0xca40(%rip),%r14        # 14198 <fwp_gc+0x1030>
    7758:	83 3d 0d ca 00 00 00 	cmpl   $0x0,0xca0d(%rip)        # 1416c <fwp_gc+0x1004>
    775f:	74 0f                	je     7770 <fwp_gc_refill+0x100>
    7761:	ba 00 00 01 00       	mov    $0x10000,%edx
    7766:	4c 89 f7             	mov    %r14,%rdi
    7769:	31 f6                	xor    %esi,%esi
    776b:	e8 b0 a9 ff ff       	call   2120 <memset@plt>
    7770:	41 8b 07             	mov    (%r15),%eax
    7773:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    7777:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    777b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    777f:	48 0f af c8          	imul   %rax,%rcx
    7783:	4c 01 f1             	add    %r14,%rcx
    7786:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    778a:	4c 89 f0             	mov    %r14,%rax
    778d:	48 83 c4 08          	add    $0x8,%rsp
    7791:	5b                   	pop    %rbx
    7792:	41 5c                	pop    %r12
    7794:	41 5d                	pop    %r13
    7796:	41 5e                	pop    %r14
    7798:	41 5f                	pop    %r15
    779a:	5d                   	pop    %rbp
    779b:	c3                   	ret
    779c:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000077a0 <fwp_gc_chunks>:
    77a0:	53                   	push   %rbx
    77a1:	48 81 ec d0 00 00 00 	sub    $0xd0,%rsp
    77a8:	31 d2                	xor    %edx,%edx
    77aa:	48 83 ff 01          	cmp    $0x1,%rdi
    77ae:	0f 95 c2             	setne  %dl
    77b1:	48 8d 35 b0 b9 00 00 	lea    0xb9b0(%rip),%rsi        # 13168 <fwp_gc>
    77b8:	48 8b 8c d6 68 10 00 	mov    0x1068(%rsi,%rdx,8),%rcx
    77bf:	00 
    77c0:	48 8b 05 f9 c9 00 00 	mov    0xc9f9(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    77c7:	49 89 ca             	mov    %rcx,%r10
    77ca:	49 29 c2             	sub    %rax,%r10
    77cd:	73 5f                	jae    782e <fwp_gc_chunks+0x8e>
    77cf:	4c 8d 0c d5 68 10 00 	lea    0x1068(,%rdx,8),%r9
    77d6:	00 
    77d7:	4c 69 d9 28 12 00 00 	imul   $0x1228,%rcx,%r11
    77de:	4c 03 1d fb c9 00 00 	add    0xc9fb(%rip),%r11        # 141e0 <fwp_gc+0x1078>
    77e5:	45 31 c0             	xor    %r8d,%r8d
    77e8:	31 d2                	xor    %edx,%edx
    77ea:	eb 15                	jmp    7801 <fwp_gc_chunks+0x61>
    77ec:	0f 1f 40 00          	nopl   0x0(%rax)
    77f0:	31 d2                	xor    %edx,%edx
    77f2:	49 ff c8             	dec    %r8
    77f5:	49 81 c3 28 12 00 00 	add    $0x1228,%r11
    77fc:	4d 39 c2             	cmp    %r8,%r10
    77ff:	74 2f                	je     7830 <fwp_gc_chunks+0x90>
    7801:	41 80 3b 00          	cmpb   $0x0,(%r11)
    7805:	75 e9                	jne    77f0 <fwp_gc_chunks+0x50>
    7807:	48 ff c2             	inc    %rdx
    780a:	48 39 fa             	cmp    %rdi,%rdx
    780d:	75 e3                	jne    77f2 <fwp_gc_chunks+0x52>
    780f:	48 ff c1             	inc    %rcx
    7812:	48 89 c8             	mov    %rcx,%rax
    7815:	4c 29 c0             	sub    %r8,%rax
    7818:	49 89 04 31          	mov    %rax,(%r9,%rsi,1)
    781c:	48 29 3d 25 cb 00 00 	sub    %rdi,0xcb25(%rip)        # 14348 <fwp_gc+0x11e0>
    7823:	48 29 f9             	sub    %rdi,%rcx
    7826:	4c 29 c1             	sub    %r8,%rcx
    7829:	48 89 c8             	mov    %rcx,%rax
    782c:	eb 57                	jmp    7885 <fwp_gc_chunks+0xe5>
    782e:	31 d2                	xor    %edx,%edx
    7830:	48 29 d0             	sub    %rdx,%rax
    7833:	48 01 c7             	add    %rax,%rdi
    7836:	48 3b 3d 7b c9 00 00 	cmp    0xc97b(%rip),%rdi        # 141b8 <fwp_gc+0x1050>
    783d:	76 1b                	jbe    785a <fwp_gc_chunks+0xba>
    783f:	83 3d 16 c9 00 00 00 	cmpl   $0x0,0xc916(%rip)        # 1415c <fwp_gc+0xff4>
    7846:	74 12                	je     785a <fwp_gc_chunks+0xba>
    7848:	83 3d 11 c9 00 00 00 	cmpl   $0x0,0xc911(%rip)        # 14160 <fwp_gc+0xff8>
    784f:	75 09                	jne    785a <fwp_gc_chunks+0xba>
    7851:	f6 05 38 df 00 00 01 	testb  $0x1,0xdf38(%rip)        # 15790 <fwp_gc_chunks.retrying>
    7858:	74 34                	je     788e <fwp_gc_chunks+0xee>
    785a:	48 29 15 e7 ca 00 00 	sub    %rdx,0xcae7(%rip)        # 14348 <fwp_gc+0x11e0>
    7861:	48 39 3d 60 c9 00 00 	cmp    %rdi,0xc960(%rip)        # 141c8 <fwp_gc+0x1060>
    7868:	72 3a                	jb     78a4 <fwp_gc_chunks+0x104>
    786a:	48 89 3d 4f c9 00 00 	mov    %rdi,0xc94f(%rip)        # 141c0 <fwp_gc+0x1058>
    7871:	48 c1 e7 10          	shl    $0x10,%rdi
    7875:	48 3b 3d 34 c9 00 00 	cmp    0xc934(%rip),%rdi        # 141b0 <fwp_gc+0x1048>
    787c:	76 07                	jbe    7885 <fwp_gc_chunks+0xe5>
    787e:	48 89 3d 2b c9 00 00 	mov    %rdi,0xc92b(%rip)        # 141b0 <fwp_gc+0x1048>
    7885:	48 81 c4 d0 00 00 00 	add    $0xd0,%rsp
    788c:	5b                   	pop    %rbx
    788d:	c3                   	ret
    788e:	c6 05 fb de 00 00 01 	movb   $0x1,0xdefb(%rip)        # 15790 <fwp_gc_chunks.retrying>
    7895:	0f 57 c0             	xorps  %xmm0,%xmm0
    7898:	0f 11 05 31 c9 00 00 	movups %xmm0,0xc931(%rip)        # 141d0 <fwp_gc+0x1068>
    789f:	e8 4c 00 00 00       	call   78f0 <fwp_gc_collect>
    78a4:	4c 8b 05 55 db 00 00 	mov    0xdb55(%rip),%r8        # 15400 <fwp_static+0x860>
    78ab:	49 c1 e8 0a          	shr    $0xa,%r8
    78af:	48 8d 15 ad 7a 00 00 	lea    0x7aad(%rip),%rdx        # f363 <fwp_segv.msg+0xe3>
    78b6:	48 8d 0d 63 7d 00 00 	lea    0x7d63(%rip),%rcx        # f620 <fwp_segv.msg+0x3a0>
    78bd:	4c 8d 0d 5a 7d 00 00 	lea    0x7d5a(%rip),%r9        # f61e <fwp_segv.msg+0x39e>
    78c4:	48 89 e3             	mov    %rsp,%rbx
    78c7:	be c8 00 00 00       	mov    $0xc8,%esi
    78cc:	48 89 df             	mov    %rbx,%rdi
    78cf:	31 c0                	xor    %eax,%eax
    78d1:	e8 2a a8 ff ff       	call   2100 <snprintf@plt>
    78d6:	48 63 d0             	movslq %eax,%rdx
    78d9:	bf 02 00 00 00       	mov    $0x2,%edi
    78de:	48 89 de             	mov    %rbx,%rsi
    78e1:	e8 ca a7 ff ff       	call   20b0 <write@plt>
    78e6:	bf 66 00 00 00       	mov    $0x66,%edi
    78eb:	e8 70 a7 ff ff       	call   2060 <_exit@plt>

00000000000078f0 <fwp_gc_collect>:
    78f0:	50                   	push   %rax
    78f1:	e8 aa f1 ff ff       	call   6aa0 <fwp_flush>
    78f6:	48 8b 05 e3 b6 00 00 	mov    0xb6e3(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    78fd:	48 8b 38             	mov    (%rax),%rdi
    7900:	48 8d 35 c6 7b 00 00 	lea    0x7bc6(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7907:	48 8d 15 df 7c 00 00 	lea    0x7cdf(%rip),%rdx        # f5ed <fwp_segv.msg+0x36d>
    790e:	31 c0                	xor    %eax,%eax
    7910:	e8 8b a8 ff ff       	call   21a0 <fprintf@plt>
    7915:	bf 65 00 00 00       	mov    $0x65,%edi
    791a:	e8 51 a9 ff ff       	call   2270 <exit@plt>
    791f:	90                   	nop

0000000000007920 <f12>:
    7920:	55                   	push   %rbp
    7921:	41 57                	push   %r15
    7923:	41 56                	push   %r14
    7925:	41 55                	push   %r13
    7927:	41 54                	push   %r12
    7929:	53                   	push   %rbx
    792a:	50                   	push   %rax
    792b:	48 89 d3             	mov    %rdx,%rbx
    792e:	49 89 ff             	mov    %rdi,%r15
    7931:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    7938:	ff ff 7f 
    793b:	48 8b 02             	mov    (%rdx),%rax
    793e:	49 89 c6             	mov    %rax,%r14
    7941:	4d 21 e6             	and    %r12,%r14
    7944:	31 c9                	xor    %ecx,%ecx
    7946:	48 85 ff             	test   %rdi,%rdi
    7949:	4c 0f 4e f9          	cmovle %rcx,%r15
    794d:	4d 39 f7             	cmp    %r14,%r15
    7950:	4d 0f 43 fe          	cmovae %r14,%r15
    7954:	48 85 f6             	test   %rsi,%rsi
    7957:	48 0f 4f ce          	cmovg  %rsi,%rcx
    795b:	4d 29 fe             	sub    %r15,%r14
    795e:	4c 39 f1             	cmp    %r14,%rcx
    7961:	4c 0f 42 f1          	cmovb  %rcx,%r14
    7965:	4d 85 f6             	test   %r14,%r14
    7968:	74 10                	je     797a <f12+0x5a>
    796a:	48 89 d9             	mov    %rbx,%rcx
    796d:	48 85 c0             	test   %rax,%rax
    7970:	78 1b                	js     798d <f12+0x6d>
    7972:	49 83 fe 04          	cmp    $0x4,%r14
    7976:	73 1f                	jae    7997 <f12+0x77>
    7978:	eb 44                	jmp    79be <f12+0x9e>
    797a:	48 8d 35 cf b2 00 00 	lea    0xb2cf(%rip),%rsi        # 12c50 <d0>
    7981:	31 ff                	xor    %edi,%edi
    7983:	e8 48 f3 ff ff       	call   6cd0 <fwp_array_typed_new>
    7988:	e9 7e 00 00 00       	jmp    7a0b <f12+0xeb>
    798d:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7991:	49 83 fe 04          	cmp    $0x4,%r14
    7995:	72 27                	jb     79be <f12+0x9e>
    7997:	48 8b 09             	mov    (%rcx),%rcx
    799a:	48 89 ca             	mov    %rcx,%rdx
    799d:	48 c1 ea 02          	shr    $0x2,%rdx
    79a1:	48 be ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rsi
    79a8:	ff ff 1f 
    79ab:	48 21 d6             	and    %rdx,%rsi
    79ae:	83 e1 03             	and    $0x3,%ecx
    79b1:	48 83 f9 01          	cmp    $0x1,%rcx
    79b5:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    79b9:	4c 39 f6             	cmp    %r14,%rsi
    79bc:	76 5c                	jbe    7a1a <f12+0xfa>
    79be:	48 8d 35 8b b2 00 00 	lea    0xb28b(%rip),%rsi        # 12c50 <d0>
    79c5:	4c 89 f7             	mov    %r14,%rdi
    79c8:	e8 03 f3 ff ff       	call   6cd0 <fwp_array_typed_new>
    79cd:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    79d1:	49 c1 e7 03          	shl    $0x3,%r15
    79d5:	31 d2                	xor    %edx,%edx
    79d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    79de:	00 00 
    79e0:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    79e4:	48 89 ce             	mov    %rcx,%rsi
    79e7:	79 04                	jns    79ed <f12+0xcd>
    79e9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    79ed:	48 83 38 00          	cmpq   $0x0,(%rax)
    79f1:	0f 88 37 02 00 00    	js     7c2e <f12+0x30e>
    79f7:	4c 01 fe             	add    %r15,%rsi
    79fa:	48 8b 34 d6          	mov    (%rsi,%rdx,8),%rsi
    79fe:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    7a03:	48 ff c2             	inc    %rdx
    7a06:	49 39 d6             	cmp    %rdx,%r14
    7a09:	75 d5                	jne    79e0 <f12+0xc0>
    7a0b:	48 83 c4 08          	add    $0x8,%rsp
    7a0f:	5b                   	pop    %rbx
    7a10:	41 5c                	pop    %r12
    7a12:	41 5d                	pop    %r13
    7a14:	41 5e                	pop    %r14
    7a16:	41 5f                	pop    %r15
    7a18:	5d                   	pop    %rbp
    7a19:	c3                   	ret
    7a1a:	48 85 c0             	test   %rax,%rax
    7a1d:	78 09                	js     7a28 <f12+0x108>
    7a1f:	48 8d 43 08          	lea    0x8(%rbx),%rax
    7a23:	49 89 dd             	mov    %rbx,%r13
    7a26:	eb 08                	jmp    7a30 <f12+0x110>
    7a28:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    7a2c:	48 8b 43 10          	mov    0x10(%rbx),%rax
    7a30:	4a 8d 2c f8          	lea    (%rax,%r15,8),%rbp
    7a34:	48 8d 0d 2d b7 00 00 	lea    0xb72d(%rip),%rcx        # 13168 <fwp_gc>
    7a3b:	0f b6 05 10 c3 00 00 	movzbl 0xc310(%rip),%eax        # 13d52 <fwp_gc+0xbea>
    7a42:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    7a49:	48 8b 3d 18 b7 00 00 	mov    0xb718(%rip),%rdi        # 13168 <fwp_gc>
    7a50:	48 29 d7             	sub    %rdx,%rdi
    7a53:	48 89 3d 0e b7 00 00 	mov    %rdi,0xb70e(%rip)        # 13168 <fwp_gc>
    7a5a:	78 56                	js     7ab2 <f12+0x192>
    7a5c:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
    7a60:	4c 8d 04 f1          	lea    (%rcx,%rsi,8),%r8
    7a64:	49 83 c0 08          	add    $0x8,%r8
    7a68:	49 8b 00             	mov    (%r8),%rax
    7a6b:	48 85 c0             	test   %rax,%rax
    7a6e:	74 25                	je     7a95 <f12+0x175>
    7a70:	48 8b 08             	mov    (%rax),%rcx
    7a73:	48 f7 d1             	not    %rcx
    7a76:	49 89 08             	mov    %rcx,(%r8)
    7a79:	83 fa 19             	cmp    $0x19,%edx
    7a7c:	72 7e                	jb     7afc <f12+0x1dc>
    7a7e:	48 8d 78 18          	lea    0x18(%rax),%rdi
    7a82:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    7a86:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    7a8a:	48 83 c2 08          	add    $0x8,%rdx
    7a8e:	31 f6                	xor    %esi,%esi
    7a90:	49 89 c7             	mov    %rax,%r15
    7a93:	eb 5f                	jmp    7af4 <f12+0x1d4>
    7a95:	48 8b 44 f1 10       	mov    0x10(%rcx,%rsi,8),%rax
    7a9a:	4c 8b 44 f1 18       	mov    0x18(%rcx,%rsi,8),%r8
    7a9f:	4d 89 c1             	mov    %r8,%r9
    7aa2:	49 29 c1             	sub    %rax,%r9
    7aa5:	49 39 d1             	cmp    %rdx,%r9
    7aa8:	73 16                	jae    7ac0 <f12+0x1a0>
    7aaa:	49 89 c7             	mov    %rax,%r15
    7aad:	49 39 d1             	cmp    %rdx,%r9
    7ab0:	73 34                	jae    7ae6 <f12+0x1c6>
    7ab2:	bf 18 00 00 00       	mov    $0x18,%edi
    7ab7:	31 f6                	xor    %esi,%esi
    7ab9:	e8 82 f4 ff ff       	call   6f40 <fwp_gc_alloc_slow>
    7abe:	eb 3c                	jmp    7afc <f12+0x1dc>
    7ac0:	4c 8d 0c f1          	lea    (%rcx,%rsi,8),%r9
    7ac4:	49 83 c1 10          	add    $0x10,%r9
    7ac8:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
    7acc:	4d 89 39             	mov    %r15,(%r9)
    7acf:	48 85 c0             	test   %rax,%rax
    7ad2:	75 a5                	jne    7a79 <f12+0x159>
    7ad4:	48 89 3d 8d b6 00 00 	mov    %rdi,0xb68d(%rip)        # 13168 <fwp_gc>
    7adb:	4d 29 f8             	sub    %r15,%r8
    7ade:	4d 89 c1             	mov    %r8,%r9
    7ae1:	49 39 d1             	cmp    %rdx,%r9
    7ae4:	72 cc                	jb     7ab2 <f12+0x192>
    7ae6:	49 8d 04 17          	lea    (%r15,%rdx,1),%rax
    7aea:	48 89 44 f1 10       	mov    %rax,0x10(%rcx,%rsi,8)
    7aef:	4c 89 ff             	mov    %r15,%rdi
    7af2:	31 f6                	xor    %esi,%esi
    7af4:	e8 27 a6 ff ff       	call   2120 <memset@plt>
    7af9:	4c 89 f8             	mov    %r15,%rax
    7afc:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    7b00:	48 ff c1             	inc    %rcx
    7b03:	48 89 08             	mov    %rcx,(%rax)
    7b06:	4c 89 68 08          	mov    %r13,0x8(%rax)
    7b0a:	48 89 68 10          	mov    %rbp,0x10(%rax)
    7b0e:	4c 2b 2d 83 c6 00 00 	sub    0xc683(%rip),%r13        # 14198 <fwp_gc+0x1030>
    7b15:	48 8b 0d a4 c6 00 00 	mov    0xc6a4(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    7b1c:	48 c1 e1 10          	shl    $0x10,%rcx
    7b20:	49 39 cd             	cmp    %rcx,%r13
    7b23:	73 6a                	jae    7b8f <f12+0x26f>
    7b25:	48 8b 0d b4 c6 00 00 	mov    0xc6b4(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    7b2c:	4c 89 ea             	mov    %r13,%rdx
    7b2f:	48 c1 ea 10          	shr    $0x10,%rdx
    7b33:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7b3a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7b3e:	49 81 e5 ff ff 00 00 	and    $0xffff,%r13
    7b45:	75 13                	jne    7b5a <f12+0x23a>
    7b47:	40 80 fe 02          	cmp    $0x2,%sil
    7b4b:	75 0d                	jne    7b5a <f12+0x23a>
    7b4d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7b51:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7b58:	eb 21                	jmp    7b7b <f12+0x25b>
    7b5a:	40 80 fe 01          	cmp    $0x1,%sil
    7b5e:	75 2f                	jne    7b8f <f12+0x26f>
    7b60:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7b64:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7b68:	4c 0f af e9          	imul   %rcx,%r13
    7b6c:	49 c1 ed 20          	shr    $0x20,%r13
    7b70:	4a 8d 3c 2e          	lea    (%rsi,%r13,1),%rdi
    7b74:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7b7b:	0f b6 0f             	movzbl (%rdi),%ecx
    7b7e:	84 c9                	test   %cl,%cl
    7b80:	74 0d                	je     7b8f <f12+0x26f>
    7b82:	80 f9 fe             	cmp    $0xfe,%cl
    7b85:	0f 83 93 00 00 00    	jae    7c1e <f12+0x2fe>
    7b8b:	fe c1                	inc    %cl
    7b8d:	88 0f                	mov    %cl,(%rdi)
    7b8f:	48 89 c1             	mov    %rax,%rcx
    7b92:	48 2b 0d ff c5 00 00 	sub    0xc5ff(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    7b99:	48 8b 15 20 c6 00 00 	mov    0xc620(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    7ba0:	48 c1 e2 10          	shl    $0x10,%rdx
    7ba4:	48 39 d1             	cmp    %rdx,%rcx
    7ba7:	73 60                	jae    7c09 <f12+0x2e9>
    7ba9:	48 8b 15 30 c6 00 00 	mov    0xc630(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    7bb0:	48 89 ce             	mov    %rcx,%rsi
    7bb3:	48 c1 ee 10          	shr    $0x10,%rsi
    7bb7:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    7bbe:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    7bc2:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7bc9:	75 13                	jne    7bde <f12+0x2be>
    7bcb:	40 80 ff 02          	cmp    $0x2,%dil
    7bcf:	75 0d                	jne    7bde <f12+0x2be>
    7bd1:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    7bd5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7bdc:	eb 21                	jmp    7bff <f12+0x2df>
    7bde:	40 80 ff 01          	cmp    $0x1,%dil
    7be2:	75 25                	jne    7c09 <f12+0x2e9>
    7be4:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    7be8:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    7bec:	48 0f af ca          	imul   %rdx,%rcx
    7bf0:	48 c1 e9 20          	shr    $0x20,%rcx
    7bf4:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    7bf8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7bff:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7c03:	74 09                	je     7c0e <f12+0x2ee>
    7c05:	41 c6 06 01          	movb   $0x1,(%r14)
    7c09:	e9 fd fd ff ff       	jmp    7a0b <f12+0xeb>
    7c0e:	4c 89 f7             	mov    %r14,%rdi
    7c11:	49 89 c7             	mov    %rax,%r15
    7c14:	e8 b7 ee ff ff       	call   6ad0 <fwp_rc_forget_slot>
    7c19:	4c 89 f8             	mov    %r15,%rax
    7c1c:	eb e7                	jmp    7c05 <f12+0x2e5>
    7c1e:	49 89 c6             	mov    %rax,%r14
    7c21:	e8 3a 00 00 00       	call   7c60 <fwp_rc_wide_dup>
    7c26:	4c 89 f0             	mov    %r14,%rax
    7c29:	e9 61 ff ff ff       	jmp    7b8f <f12+0x26f>
    7c2e:	e8 6d ee ff ff       	call   6aa0 <fwp_flush>
    7c33:	48 8b 05 a6 b3 00 00 	mov    0xb3a6(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7c3a:	48 8b 38             	mov    (%rax),%rdi
    7c3d:	48 8d 35 89 78 00 00 	lea    0x7889(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7c44:	48 8d 15 da 79 00 00 	lea    0x79da(%rip),%rdx        # f625 <fwp_segv.msg+0x3a5>
    7c4b:	31 c0                	xor    %eax,%eax
    7c4d:	e8 4e a5 ff ff       	call   21a0 <fprintf@plt>
    7c52:	bf 65 00 00 00       	mov    $0x65,%edi
    7c57:	e8 14 a6 ff ff       	call   2270 <exit@plt>
    7c5c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007c60 <fwp_rc_wide_dup>:
    7c60:	41 56                	push   %r14
    7c62:	53                   	push   %rbx
    7c63:	50                   	push   %rax
    7c64:	48 89 fb             	mov    %rdi,%rbx
    7c67:	48 89 f8             	mov    %rdi,%rax
    7c6a:	48 c1 e8 11          	shr    $0x11,%rax
    7c6e:	31 d8                	xor    %ebx,%eax
    7c70:	89 c1                	mov    %eax,%ecx
    7c72:	c1 e9 09             	shr    $0x9,%ecx
    7c75:	31 c1                	xor    %eax,%ecx
    7c77:	0f b6 c1             	movzbl %cl,%eax
    7c7a:	48 8d 0d e7 b4 00 00 	lea    0xb4e7(%rip),%rcx        # 13168 <fwp_gc>
    7c81:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    7c85:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    7c8c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    7c93:	00 
    7c94:	48 85 c0             	test   %rax,%rax
    7c97:	74 1a                	je     7cb3 <fwp_rc_wide_dup+0x53>
    7c99:	48 39 18             	cmp    %rbx,(%rax)
    7c9c:	74 22                	je     7cc0 <fwp_rc_wide_dup+0x60>
    7c9e:	66 90                	xchg   %ax,%ax
    7ca0:	49 89 c6             	mov    %rax,%r14
    7ca3:	48 8b 40 10          	mov    0x10(%rax),%rax
    7ca7:	48 85 c0             	test   %rax,%rax
    7caa:	74 0e                	je     7cba <fwp_rc_wide_dup+0x5a>
    7cac:	48 39 18             	cmp    %rbx,(%rax)
    7caf:	75 ef                	jne    7ca0 <fwp_rc_wide_dup+0x40>
    7cb1:	eb 09                	jmp    7cbc <fwp_rc_wide_dup+0x5c>
    7cb3:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7cb6:	74 12                	je     7cca <fwp_rc_wide_dup+0x6a>
    7cb8:	eb 64                	jmp    7d1e <fwp_rc_wide_dup+0xbe>
    7cba:	31 c0                	xor    %eax,%eax
    7cbc:	49 83 c6 10          	add    $0x10,%r14
    7cc0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7cc3:	75 38                	jne    7cfd <fwp_rc_wide_dup+0x9d>
    7cc5:	48 85 c0             	test   %rax,%rax
    7cc8:	75 73                	jne    7d3d <fwp_rc_wide_dup+0xdd>
    7cca:	bf 18 00 00 00       	mov    $0x18,%edi
    7ccf:	e8 7c a7 ff ff       	call   2450 <fwp_pool_get>
    7cd4:	48 89 18             	mov    %rbx,(%rax)
    7cd7:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    7cde:	00 
    7cdf:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    7ce6:	00 
    7ce7:	49 89 06             	mov    %rax,(%r14)
    7cea:	c6 03 ff             	movb   $0xff,(%rbx)
    7ced:	48 8d 05 8c ce 00 00 	lea    0xce8c(%rip),%rax        # 14b80 <fwp_gc+0x1a18>
    7cf4:	48 8b 0d 85 ce 00 00 	mov    0xce85(%rip),%rcx        # 14b80 <fwp_gc+0x1a18>
    7cfb:	eb 13                	jmp    7d10 <fwp_rc_wide_dup+0xb0>
    7cfd:	48 85 c0             	test   %rax,%rax
    7d00:	74 1c                	je     7d1e <fwp_rc_wide_dup+0xbe>
    7d02:	48 8b 48 08          	mov    0x8(%rax),%rcx
    7d06:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    7d0a:	74 50                	je     7d5c <fwp_rc_wide_dup+0xfc>
    7d0c:	48 83 c0 08          	add    $0x8,%rax
    7d10:	48 ff c1             	inc    %rcx
    7d13:	48 89 08             	mov    %rcx,(%rax)
    7d16:	48 83 c4 08          	add    $0x8,%rsp
    7d1a:	5b                   	pop    %rbx
    7d1b:	41 5e                	pop    %r14
    7d1d:	c3                   	ret
    7d1e:	e8 7d ed ff ff       	call   6aa0 <fwp_flush>
    7d23:	48 8b 05 b6 b2 00 00 	mov    0xb2b6(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7d2a:	48 8b 38             	mov    (%rax),%rdi
    7d2d:	48 8d 35 99 77 00 00 	lea    0x7799(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7d34:	48 8d 15 a1 77 00 00 	lea    0x77a1(%rip),%rdx        # f4dc <fwp_segv.msg+0x25c>
    7d3b:	eb 3c                	jmp    7d79 <fwp_rc_wide_dup+0x119>
    7d3d:	e8 5e ed ff ff       	call   6aa0 <fwp_flush>
    7d42:	48 8b 05 97 b2 00 00 	mov    0xb297(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7d49:	48 8b 38             	mov    (%rax),%rdi
    7d4c:	48 8d 35 7a 77 00 00 	lea    0x777a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7d53:	48 8d 15 f7 78 00 00 	lea    0x78f7(%rip),%rdx        # f651 <fwp_segv.msg+0x3d1>
    7d5a:	eb 1d                	jmp    7d79 <fwp_rc_wide_dup+0x119>
    7d5c:	e8 3f ed ff ff       	call   6aa0 <fwp_flush>
    7d61:	48 8b 05 78 b2 00 00 	mov    0xb278(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    7d68:	48 8b 38             	mov    (%rax),%rdi
    7d6b:	48 8d 35 5b 77 00 00 	lea    0x775b(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7d72:	48 8d 15 fd 78 00 00 	lea    0x78fd(%rip),%rdx        # f676 <fwp_segv.msg+0x3f6>
    7d79:	31 c0                	xor    %eax,%eax
    7d7b:	e8 20 a4 ff ff       	call   21a0 <fprintf@plt>
    7d80:	bf 65 00 00 00       	mov    $0x65,%edi
    7d85:	e8 e6 a4 ff ff       	call   2270 <exit@plt>
    7d8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007d90 <fwp_show>:
    7d90:	41 57                	push   %r15
    7d92:	41 56                	push   %r14
    7d94:	53                   	push   %rbx
    7d95:	48 83 ec 20          	sub    $0x20,%rsp
    7d99:	48 89 f2             	mov    %rsi,%rdx
    7d9c:	48 89 fe             	mov    %rdi,%rsi
    7d9f:	0f 57 c0             	xorps  %xmm0,%xmm0
    7da2:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7da6:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7dad:	00 00 
    7daf:	48 89 e7             	mov    %rsp,%rdi
    7db2:	b9 01 00 00 00       	mov    $0x1,%ecx
    7db7:	e8 54 01 00 00       	call   7f10 <fwp_write>
    7dbc:	48 8b 04 24          	mov    (%rsp),%rax
    7dc0:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    7dc5:	48 85 c0             	test   %rax,%rax
    7dc8:	4c 8d 35 03 7c 00 00 	lea    0x7c03(%rip),%r14        # f9d2 <fwp_segv.msg+0x752>
    7dcf:	4c 0f 45 f0          	cmovne %rax,%r14
    7dd3:	49 8d 57 09          	lea    0x9(%r15),%rdx
    7dd7:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7dde:	77 61                	ja     7e41 <fwp_show+0xb1>
    7de0:	49 8d 4f 18          	lea    0x18(%r15),%rcx
    7de4:	48 c1 e9 04          	shr    $0x4,%rcx
    7de8:	48 8d 05 79 b3 00 00 	lea    0xb379(%rip),%rax        # 13168 <fwp_gc>
    7def:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7df6:	00 
    7df7:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7dfe:	48 29 0d 63 b3 00 00 	sub    %rcx,0xb363(%rip)        # 13168 <fwp_gc>
    7e05:	78 3a                	js     7e41 <fwp_show+0xb1>
    7e07:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7e0b:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7e0f:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7e16:	48 8b 1f             	mov    (%rdi),%rbx
    7e19:	48 85 db             	test   %rbx,%rbx
    7e1c:	74 0b                	je     7e29 <fwp_show+0x99>
    7e1e:	48 8b 03             	mov    (%rbx),%rax
    7e21:	48 f7 d0             	not    %rax
    7e24:	48 89 07             	mov    %rax,(%rdi)
    7e27:	eb 3a                	jmp    7e63 <fwp_show+0xd3>
    7e29:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    7e30:	00 
    7e31:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    7e38:	00 
    7e39:	48 29 df             	sub    %rbx,%rdi
    7e3c:	48 39 cf             	cmp    %rcx,%rdi
    7e3f:	73 12                	jae    7e53 <fwp_show+0xc3>
    7e41:	48 89 d7             	mov    %rdx,%rdi
    7e44:	be 01 00 00 00       	mov    $0x1,%esi
    7e49:	e8 f2 f0 ff ff       	call   6f40 <fwp_gc_alloc_slow>
    7e4e:	48 89 c3             	mov    %rax,%rbx
    7e51:	eb 1a                	jmp    7e6d <fwp_show+0xdd>
    7e53:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    7e57:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7e5d:	48 01 d9             	add    %rbx,%rcx
    7e60:	48 89 08             	mov    %rcx,(%rax)
    7e63:	48 89 df             	mov    %rbx,%rdi
    7e66:	31 f6                	xor    %esi,%esi
    7e68:	e8 b3 a2 ff ff       	call   2120 <memset@plt>
    7e6d:	4c 89 3b             	mov    %r15,(%rbx)
    7e70:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
    7e74:	4c 89 f6             	mov    %r14,%rsi
    7e77:	4c 89 fa             	mov    %r15,%rdx
    7e7a:	e8 51 a3 ff ff       	call   21d0 <memcpy@plt>
    7e7f:	42 c6 44 3b 08 00    	movb   $0x0,0x8(%rbx,%r15,1)
    7e85:	48 8b 04 24          	mov    (%rsp),%rax
    7e89:	48 85 c0             	test   %rax,%rax
    7e8c:	74 6a                	je     7ef8 <fwp_show+0x168>
    7e8e:	8b 48 f4             	mov    -0xc(%rax),%ecx
    7e91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e98:	0f 1f 84 00 00 00 00 
    7e9f:	00 
    7ea0:	b2 01                	mov    $0x1,%dl
    7ea2:	86 15 40 d5 00 00    	xchg   %dl,0xd540(%rip)        # 153e8 <fwp_static+0x848>
    7ea8:	84 d2                	test   %dl,%dl
    7eaa:	75 f4                	jne    7ea0 <fwp_show+0x110>
    7eac:	48 29 c8             	sub    %rcx,%rax
    7eaf:	8b 50 f0             	mov    -0x10(%rax),%edx
    7eb2:	89 d1                	mov    %edx,%ecx
    7eb4:	c1 e9 02             	shr    $0x2,%ecx
    7eb7:	be 01 00 00 00       	mov    $0x1,%esi
    7ebc:	48 d3 e6             	shl    %cl,%rsi
    7ebf:	48 8d 48 f0          	lea    -0x10(%rax),%rcx
    7ec3:	89 d7                	mov    %edx,%edi
    7ec5:	83 e7 03             	and    $0x3,%edi
    7ec8:	49 89 f0             	mov    %rsi,%r8
    7ecb:	49 c1 e8 02          	shr    $0x2,%r8
    7ecf:	4c 0f af c7          	imul   %rdi,%r8
    7ed3:	48 8d 3d c6 cc 00 00 	lea    0xccc6(%rip),%rdi        # 14ba0 <fwp_static>
    7eda:	49 01 f0             	add    %rsi,%r8
    7edd:	4c 29 05 f4 d4 00 00 	sub    %r8,0xd4f4(%rip)        # 153d8 <fwp_static+0x838>
    7ee4:	48 8b 74 d7 38       	mov    0x38(%rdi,%rdx,8),%rsi
    7ee9:	48 89 30             	mov    %rsi,(%rax)
    7eec:	48 89 4c d7 38       	mov    %rcx,0x38(%rdi,%rdx,8)
    7ef1:	c6 05 f0 d4 00 00 00 	movb   $0x0,0xd4f0(%rip)        # 153e8 <fwp_static+0x848>
    7ef8:	48 89 d8             	mov    %rbx,%rax
    7efb:	48 83 c4 20          	add    $0x20,%rsp
    7eff:	5b                   	pop    %rbx
    7f00:	41 5e                	pop    %r14
    7f02:	41 5f                	pop    %r15
    7f04:	c3                   	ret
    7f05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7f0c:	00 00 00 00 

0000000000007f10 <fwp_write>:
    7f10:	55                   	push   %rbp
    7f11:	41 57                	push   %r15
    7f13:	41 56                	push   %r14
    7f15:	41 55                	push   %r13
    7f17:	41 54                	push   %r12
    7f19:	53                   	push   %rbx
    7f1a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    7f21:	8b 02                	mov    (%rdx),%eax
    7f23:	48 83 f8 19          	cmp    $0x19,%rax
    7f27:	0f 87 26 12 00 00    	ja     9153 <fwp_write+0x1243>
    7f2d:	49 89 d7             	mov    %rdx,%r15
    7f30:	49 89 f6             	mov    %rsi,%r14
    7f33:	48 89 fd             	mov    %rdi,%rbp
    7f36:	48 8d 15 e3 71 00 00 	lea    0x71e3(%rip),%rdx        # f120 <_IO_stdin_used+0x120>
    7f3d:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    7f41:	48 01 d6             	add    %rdx,%rsi
    7f44:	48 89 3c 24          	mov    %rdi,(%rsp)
    7f48:	ff e6                	jmp    *%rsi
    7f4a:	48 8d 15 3e 77 00 00 	lea    0x773e(%rip),%rdx        # f68f <fwp_segv.msg+0x40f>
    7f51:	eb 07                	jmp    7f5a <fwp_write+0x4a>
    7f53:	48 8d 15 3a 77 00 00 	lea    0x773a(%rip),%rdx        # f694 <fwp_segv.msg+0x414>
    7f5a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7f5f:	be 00 02 00 00       	mov    $0x200,%esi
    7f64:	4c 89 ff             	mov    %r15,%rdi
    7f67:	4c 89 f1             	mov    %r14,%rcx
    7f6a:	31 c0                	xor    %eax,%eax
    7f6c:	e8 8f a1 ff ff       	call   2100 <snprintf@plt>
    7f71:	4c 89 ff             	mov    %r15,%rdi
    7f74:	e8 57 a1 ff ff       	call   20d0 <strlen@plt>
    7f79:	48 89 ef             	mov    %rbp,%rdi
    7f7c:	4c 89 fe             	mov    %r15,%rsi
    7f7f:	e9 c7 11 00 00       	jmp    914b <fwp_write+0x123b>
    7f84:	83 f8 13             	cmp    $0x13,%eax
    7f87:	48 8d 05 40 77 00 00 	lea    0x7740(%rip),%rax        # f6ce <fwp_segv.msg+0x44e>
    7f8e:	48 8d 35 3e 77 00 00 	lea    0x773e(%rip),%rsi        # f6d3 <fwp_segv.msg+0x453>
    7f95:	48 0f 44 f0          	cmove  %rax,%rsi
    7f99:	ba 04 00 00 00       	mov    $0x4,%edx
    7f9e:	48 89 ef             	mov    %rbp,%rdi
    7fa1:	e8 4a 13 00 00       	call   92f0 <buf_put>
    7fa6:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7faa:	0f 84 c3 00 00 00    	je     8073 <fwp_write+0x163>
    7fb0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7fb4:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7fb8:	48 8b 1c 24          	mov    (%rsp),%rbx
    7fbc:	48 89 df             	mov    %rbx,%rdi
    7fbf:	31 c9                	xor    %ecx,%ecx
    7fc1:	e8 4a ff ff ff       	call   7f10 <fwp_write>
    7fc6:	41 83 3f 12          	cmpl   $0x12,(%r15)
    7fca:	75 26                	jne    7ff2 <fwp_write+0xe2>
    7fcc:	48 8d 35 05 77 00 00 	lea    0x7705(%rip),%rsi        # f6d8 <fwp_segv.msg+0x458>
    7fd3:	ba 02 00 00 00       	mov    $0x2,%edx
    7fd8:	48 89 df             	mov    %rbx,%rdi
    7fdb:	e8 10 13 00 00       	call   92f0 <buf_put>
    7fe0:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7fe4:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7fe8:	48 89 df             	mov    %rbx,%rdi
    7feb:	31 c9                	xor    %ecx,%ecx
    7fed:	e8 1e ff ff ff       	call   7f10 <fwp_write>
    7ff2:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7ff6:	72 7b                	jb     8073 <fwp_write+0x163>
    7ff8:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    7ffc:	bd 01 00 00 00       	mov    $0x1,%ebp
    8001:	4c 8d 25 b9 76 00 00 	lea    0x76b9(%rip),%r12        # f6c1 <fwp_segv.msg+0x441>
    8008:	eb 12                	jmp    801c <fwp_write+0x10c>
    800a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8010:	48 ff c5             	inc    %rbp
    8013:	48 83 c3 10          	add    $0x10,%rbx
    8017:	49 3b 2e             	cmp    (%r14),%rbp
    801a:	73 57                	jae    8073 <fwp_write+0x163>
    801c:	ba 02 00 00 00       	mov    $0x2,%edx
    8021:	4c 8b 2c 24          	mov    (%rsp),%r13
    8025:	4c 89 ef             	mov    %r13,%rdi
    8028:	4c 89 e6             	mov    %r12,%rsi
    802b:	e8 c0 12 00 00       	call   92f0 <buf_put>
    8030:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    8034:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8038:	4c 89 ef             	mov    %r13,%rdi
    803b:	31 c9                	xor    %ecx,%ecx
    803d:	e8 ce fe ff ff       	call   7f10 <fwp_write>
    8042:	41 83 3f 12          	cmpl   $0x12,(%r15)
    8046:	75 c8                	jne    8010 <fwp_write+0x100>
    8048:	ba 02 00 00 00       	mov    $0x2,%edx
    804d:	4c 8b 2c 24          	mov    (%rsp),%r13
    8051:	4c 89 ef             	mov    %r13,%rdi
    8054:	48 8d 35 7d 76 00 00 	lea    0x767d(%rip),%rsi        # f6d8 <fwp_segv.msg+0x458>
    805b:	e8 90 12 00 00       	call   92f0 <buf_put>
    8060:	48 8b 33             	mov    (%rbx),%rsi
    8063:	49 8b 57 40          	mov    0x40(%r15),%rdx
    8067:	4c 89 ef             	mov    %r13,%rdi
    806a:	31 c9                	xor    %ecx,%ecx
    806c:	e8 9f fe ff ff       	call   7f10 <fwp_write>
    8071:	eb 9d                	jmp    8010 <fwp_write+0x100>
    8073:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    8078:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    807d:	ba 01 00 00 00       	mov    $0x1,%edx
    8082:	48 8b 3c 24          	mov    (%rsp),%rdi
    8086:	e9 c3 10 00 00       	jmp    914e <fwp_write+0x123e>
    808b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    808f:	4d 85 e4             	test   %r12,%r12
    8092:	0f 84 af 06 00 00    	je     8747 <fwp_write+0x837>
    8098:	48 8d 35 3c 76 00 00 	lea    0x763c(%rip),%rsi        # f6db <fwp_segv.msg+0x45b>
    809f:	4c 89 e7             	mov    %r12,%rdi
    80a2:	e8 c9 a0 ff ff       	call   2170 <strcmp@plt>
    80a7:	85 c0                	test   %eax,%eax
    80a9:	0f 84 36 0b 00 00    	je     8be5 <fwp_write+0xcd5>
    80af:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    80b3:	4c 89 e7             	mov    %r12,%rdi
    80b6:	e8 15 a0 ff ff       	call   20d0 <strlen@plt>
    80bb:	48 89 ef             	mov    %rbp,%rdi
    80be:	4c 89 e6             	mov    %r12,%rsi
    80c1:	48 89 c2             	mov    %rax,%rdx
    80c4:	e8 27 12 00 00       	call   92f0 <buf_put>
    80c9:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    80ce:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    80d3:	ba 01 00 00 00       	mov    $0x1,%edx
    80d8:	48 89 ef             	mov    %rbp,%rdi
    80db:	e8 10 12 00 00       	call   92f0 <buf_put>
    80e0:	31 db                	xor    %ebx,%ebx
    80e2:	e9 7f 06 00 00       	jmp    8766 <fwp_write+0x856>
    80e7:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    80ee:	0f 87 00 05 00 00    	ja     85f4 <fwp_write+0x6e4>
    80f4:	44 89 f0             	mov    %r14d,%eax
    80f7:	e9 fb 04 00 00       	jmp    85f7 <fwp_write+0x6e7>
    80fc:	66 49 0f 6e ce       	movq   %r14,%xmm1
    8101:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    8105:	0f 8a d2 11 00 00    	jp     92dd <fwp_write+0x13cd>
    810b:	66 0f 28 05 bd 6f 00 	movapd 0x6fbd(%rip),%xmm0        # f0d0 <_IO_stdin_used+0xd0>
    8112:	00 
    8113:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    8117:	66 0f 2e 05 01 6f 00 	ucomisd 0x6f01(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    811e:	00 
    811f:	0f 82 66 08 00 00    	jb     898b <fwp_write+0xa7b>
    8125:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    8129:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    812d:	e9 55 04 00 00       	jmp    8587 <fwp_write+0x677>
    8132:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    8137:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    813c:	ba 01 00 00 00       	mov    $0x1,%edx
    8141:	48 89 ef             	mov    %rbp,%rdi
    8144:	e8 a7 11 00 00       	call   92f0 <buf_put>
    8149:	4d 8b 77 08          	mov    0x8(%r15),%r14
    814d:	e9 82 04 00 00       	jmp    85d4 <fwp_write+0x6c4>
    8152:	48 8d 35 51 75 00 00 	lea    0x7551(%rip),%rsi        # f6aa <fwp_segv.msg+0x42a>
    8159:	ba 08 00 00 00       	mov    $0x8,%edx
    815e:	48 89 ef             	mov    %rbp,%rdi
    8161:	e9 5c 0d 00 00       	jmp    8ec2 <fwp_write+0xfb2>
    8166:	49 8d 76 08          	lea    0x8(%r14),%rsi
    816a:	49 8b 16             	mov    (%r14),%rdx
    816d:	85 c9                	test   %ecx,%ecx
    816f:	0f 84 13 07 00 00    	je     8888 <fwp_write+0x978>
    8175:	48 89 ef             	mov    %rbp,%rdi
    8178:	e9 45 0d 00 00       	jmp    8ec2 <fwp_write+0xfb2>
    817d:	4d 8b 0e             	mov    (%r14),%r9
    8180:	4d 8b 46 08          	mov    0x8(%r14),%r8
    8184:	4c 89 c8             	mov    %r9,%rax
    8187:	4c 09 c0             	or     %r8,%rax
    818a:	0f 84 11 07 00 00    	je     88a1 <fwp_write+0x991>
    8190:	31 ff                	xor    %edi,%edi
    8192:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    8199:	cc cc cc 
    819c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    81a3:	cc cc cc 
    81a6:	4c 89 c3             	mov    %r8,%rbx
    81a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    81b0:	4c 89 c1             	mov    %r8,%rcx
    81b3:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    81b8:	48 d1 eb             	shr    $1,%rbx
    81bb:	48 89 ce             	mov    %rcx,%rsi
    81be:	48 01 de             	add    %rbx,%rsi
    81c1:	48 83 d6 00          	adc    $0x0,%rsi
    81c5:	48 89 f0             	mov    %rsi,%rax
    81c8:	49 f7 e2             	mul    %r10
    81cb:	48 c1 ea 02          	shr    $0x2,%rdx
    81cf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    81d3:	48 29 c6             	sub    %rax,%rsi
    81d6:	48 29 f1             	sub    %rsi,%rcx
    81d9:	48 83 db 00          	sbb    $0x0,%rbx
    81dd:	48 89 ce             	mov    %rcx,%rsi
    81e0:	49 0f af f3          	imul   %r11,%rsi
    81e4:	48 89 c8             	mov    %rcx,%rax
    81e7:	49 f7 e2             	mul    %r10
    81ea:	48 01 f2             	add    %rsi,%rdx
    81ed:	49 0f af da          	imul   %r10,%rbx
    81f1:	48 01 d3             	add    %rdx,%rbx
    81f4:	48 89 c1             	mov    %rax,%rcx
    81f7:	48 01 c1             	add    %rax,%rcx
    81fa:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    81fe:	44 89 ca             	mov    %r9d,%edx
    8201:	29 ca                	sub    %ecx,%edx
    8203:	80 ca 30             	or     $0x30,%dl
    8206:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    820a:	48 ff c7             	inc    %rdi
    820d:	49 83 f9 0a          	cmp    $0xa,%r9
    8211:	49 83 d8 00          	sbb    $0x0,%r8
    8215:	49 89 c1             	mov    %rax,%r9
    8218:	49 89 d8             	mov    %rbx,%r8
    821b:	73 93                	jae    81b0 <fwp_write+0x2a0>
    821d:	85 ff                	test   %edi,%edi
    821f:	0f 8f 86 06 00 00    	jg     88ab <fwp_write+0x99b>
    8225:	e9 ab 00 00 00       	jmp    82d5 <fwp_write+0x3c5>
    822a:	4d 8b 06             	mov    (%r14),%r8
    822d:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    8231:	4d 85 c9             	test   %r9,%r9
    8234:	0f 88 93 06 00 00    	js     88cd <fwp_write+0x9bd>
    823a:	4c 89 c0             	mov    %r8,%rax
    823d:	4c 09 c8             	or     %r9,%rax
    8240:	0f 84 bc 09 00 00    	je     8c02 <fwp_write+0xcf2>
    8246:	31 ff                	xor    %edi,%edi
    8248:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    824f:	cc cc cc 
    8252:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8259:	cc cc cc 
    825c:	4c 89 cb             	mov    %r9,%rbx
    825f:	90                   	nop
    8260:	4c 89 c9             	mov    %r9,%rcx
    8263:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8268:	48 d1 eb             	shr    $1,%rbx
    826b:	48 89 ce             	mov    %rcx,%rsi
    826e:	48 01 de             	add    %rbx,%rsi
    8271:	48 83 d6 00          	adc    $0x0,%rsi
    8275:	48 89 f0             	mov    %rsi,%rax
    8278:	49 f7 e2             	mul    %r10
    827b:	48 c1 ea 02          	shr    $0x2,%rdx
    827f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    8283:	48 29 c6             	sub    %rax,%rsi
    8286:	48 29 f1             	sub    %rsi,%rcx
    8289:	48 83 db 00          	sbb    $0x0,%rbx
    828d:	48 89 ce             	mov    %rcx,%rsi
    8290:	49 0f af f3          	imul   %r11,%rsi
    8294:	48 89 c8             	mov    %rcx,%rax
    8297:	49 f7 e2             	mul    %r10
    829a:	48 01 f2             	add    %rsi,%rdx
    829d:	49 0f af da          	imul   %r10,%rbx
    82a1:	48 01 d3             	add    %rdx,%rbx
    82a4:	48 89 c1             	mov    %rax,%rcx
    82a7:	48 01 c1             	add    %rax,%rcx
    82aa:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    82ae:	44 89 c2             	mov    %r8d,%edx
    82b1:	29 ca                	sub    %ecx,%edx
    82b3:	80 ca 30             	or     $0x30,%dl
    82b6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    82ba:	48 ff c7             	inc    %rdi
    82bd:	49 83 f8 0a          	cmp    $0xa,%r8
    82c1:	49 83 d9 00          	sbb    $0x0,%r9
    82c5:	49 89 c0             	mov    %rax,%r8
    82c8:	49 89 d9             	mov    %rbx,%r9
    82cb:	73 93                	jae    8260 <fwp_write+0x350>
    82cd:	85 ff                	test   %edi,%edi
    82cf:	0f 8f 37 09 00 00    	jg     8c0c <fwp_write+0xcfc>
    82d5:	31 c0                	xor    %eax,%eax
    82d7:	e9 57 0e 00 00       	jmp    9133 <fwp_write+0x1223>
    82dc:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    82e1:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    82e6:	ba 01 00 00 00       	mov    $0x1,%edx
    82eb:	48 89 ef             	mov    %rbp,%rdi
    82ee:	e8 fd 0f 00 00       	call   92f0 <buf_put>
    82f3:	4d 85 f6             	test   %r14,%r14
    82f6:	0f 84 e6 0c 00 00    	je     8fe2 <fwp_write+0x10d2>
    82fc:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8300:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8304:	48 89 ef             	mov    %rbp,%rdi
    8307:	31 c9                	xor    %ecx,%ecx
    8309:	e8 02 fc ff ff       	call   7f10 <fwp_write>
    830e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    8312:	48 85 db             	test   %rbx,%rbx
    8315:	0f 84 c7 0c 00 00    	je     8fe2 <fwp_write+0x10d2>
    831b:	4c 8d 35 9f 73 00 00 	lea    0x739f(%rip),%r14        # f6c1 <fwp_segv.msg+0x441>
    8322:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8329:	1f 84 00 00 00 00 00 
    8330:	ba 02 00 00 00       	mov    $0x2,%edx
    8335:	48 89 ef             	mov    %rbp,%rdi
    8338:	4c 89 f6             	mov    %r14,%rsi
    833b:	e8 b0 0f 00 00       	call   92f0 <buf_put>
    8340:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8344:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8348:	48 89 ef             	mov    %rbp,%rdi
    834b:	31 c9                	xor    %ecx,%ecx
    834d:	e8 be fb ff ff       	call   7f10 <fwp_write>
    8352:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    8356:	48 85 db             	test   %rbx,%rbx
    8359:	75 d5                	jne    8330 <fwp_write+0x420>
    835b:	e9 82 0c 00 00       	jmp    8fe2 <fwp_write+0x10d2>
    8360:	4d 63 67 48          	movslq 0x48(%r15),%r12
    8364:	44 89 e3             	mov    %r12d,%ebx
    8367:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    836c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    8373:	0f 87 57 08 00 00    	ja     8bd0 <fwp_write+0xcc0>
    8379:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    837e:	48 c1 e9 04          	shr    $0x4,%rcx
    8382:	48 8d 05 df ad 00 00 	lea    0xaddf(%rip),%rax        # 13168 <fwp_gc>
    8389:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    8390:	00 
    8391:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    8398:	48 29 0d c9 ad 00 00 	sub    %rcx,0xadc9(%rip)        # 13168 <fwp_gc>
    839f:	0f 88 2b 08 00 00    	js     8bd0 <fwp_write+0xcc0>
    83a5:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    83a9:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    83ad:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    83b4:	4c 8b 3f             	mov    (%rdi),%r15
    83b7:	4d 85 ff             	test   %r15,%r15
    83ba:	0f 84 f4 07 00 00    	je     8bb4 <fwp_write+0xca4>
    83c0:	49 8b 07             	mov    (%r15),%rax
    83c3:	48 f7 d0             	not    %rax
    83c6:	48 89 07             	mov    %rax,(%rdi)
    83c9:	e9 2d 0a 00 00       	jmp    8dfb <fwp_write+0xeeb>
    83ce:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    83d2:	48 8d 05 c3 72 00 00 	lea    0x72c3(%rip),%rax        # f69c <fwp_segv.msg+0x41c>
    83d9:	48 8d 0d 29 73 00 00 	lea    0x7329(%rip),%rcx        # f709 <fwp_segv.msg+0x489>
    83e0:	48 0f 44 c8          	cmove  %rax,%rcx
    83e4:	49 83 fe 01          	cmp    $0x1,%r14
    83e8:	4c 8d 35 aa 72 00 00 	lea    0x72aa(%rip),%r14        # f699 <fwp_segv.msg+0x419>
    83ef:	4c 0f 45 f1          	cmovne %rcx,%r14
    83f3:	4c 89 f7             	mov    %r14,%rdi
    83f6:	e8 d5 9c ff ff       	call   20d0 <strlen@plt>
    83fb:	48 89 ef             	mov    %rbp,%rdi
    83fe:	4c 89 f6             	mov    %r14,%rsi
    8401:	e9 b9 0a 00 00       	jmp    8ebf <fwp_write+0xfaf>
    8406:	48 8d 35 ba 72 00 00 	lea    0x72ba(%rip),%rsi        # f6c7 <fwp_segv.msg+0x447>
    840d:	ba 06 00 00 00       	mov    $0x6,%edx
    8412:	48 89 ef             	mov    %rbp,%rdi
    8415:	e8 d6 0e 00 00       	call   92f0 <buf_put>
    841a:	49 8b 36             	mov    (%r14),%rsi
    841d:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    8424:	00 
    8425:	48 85 c0             	test   %rax,%rax
    8428:	0f 84 b4 0b 00 00    	je     8fe2 <fwp_write+0x10d2>
    842e:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8432:	b8 08 00 00 00       	mov    $0x8,%eax
    8437:	48 85 d2             	test   %rdx,%rdx
    843a:	74 13                	je     844f <fwp_write+0x53f>
    843c:	8b 0a                	mov    (%rdx),%ecx
    843e:	48 83 f9 0a          	cmp    $0xa,%rcx
    8442:	77 0b                	ja     844f <fwp_write+0x53f>
    8444:	48 8d 05 ad 6e 00 00 	lea    0x6ead(%rip),%rax        # f2f8 <fwp_segv.msg+0x78>
    844b:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    844f:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    8453:	4c 89 e9             	mov    %r13,%rcx
    8456:	48 85 f6             	test   %rsi,%rsi
    8459:	79 04                	jns    845f <fwp_write+0x54f>
    845b:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    845f:	48 83 f8 01          	cmp    $0x1,%rax
    8463:	0f 84 74 0a 00 00    	je     8edd <fwp_write+0xfcd>
    8469:	48 83 f8 08          	cmp    $0x8,%rax
    846d:	0f 84 65 0a 00 00    	je     8ed8 <fwp_write+0xfc8>
    8473:	48 83 f8 02          	cmp    $0x2,%rax
    8477:	0f 85 6c 0a 00 00    	jne    8ee9 <fwp_write+0xfd9>
    847d:	83 3a 01             	cmpl   $0x1,(%rdx)
    8480:	0f b7 01             	movzwl (%rcx),%eax
    8483:	48 0f bf f0          	movswq %ax,%rsi
    8487:	e9 65 0a 00 00       	jmp    8ef1 <fwp_write+0xfe1>
    848c:	48 8d 35 27 72 00 00 	lea    0x7227(%rip),%rsi        # f6ba <fwp_segv.msg+0x43a>
    8493:	ba 06 00 00 00       	mov    $0x6,%edx
    8498:	48 89 ef             	mov    %rbp,%rdi
    849b:	e8 50 0e 00 00       	call   92f0 <buf_put>
    84a0:	49 83 3e 00          	cmpq   $0x0,(%r14)
    84a4:	0f 84 a3 00 00 00    	je     854d <fwp_write+0x63d>
    84aa:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    84af:	48 8d 15 0e 72 00 00 	lea    0x720e(%rip),%rdx        # f6c4 <fwp_segv.msg+0x444>
    84b6:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    84bb:	be 00 02 00 00       	mov    $0x200,%esi
    84c0:	4c 89 ff             	mov    %r15,%rdi
    84c3:	31 c0                	xor    %eax,%eax
    84c5:	e8 36 9c ff ff       	call   2100 <snprintf@plt>
    84ca:	4c 89 ff             	mov    %r15,%rdi
    84cd:	e8 fe 9b ff ff       	call   20d0 <strlen@plt>
    84d2:	48 89 ef             	mov    %rbp,%rdi
    84d5:	4c 89 fe             	mov    %r15,%rsi
    84d8:	48 89 c2             	mov    %rax,%rdx
    84db:	e8 10 0e 00 00       	call   92f0 <buf_put>
    84e0:	49 83 3e 02          	cmpq   $0x2,(%r14)
    84e4:	72 67                	jb     854d <fwp_write+0x63d>
    84e6:	bb 09 00 00 00       	mov    $0x9,%ebx
    84eb:	4c 8d 3d cf 71 00 00 	lea    0x71cf(%rip),%r15        # f6c1 <fwp_segv.msg+0x441>
    84f2:	4c 8d 25 cb 71 00 00 	lea    0x71cb(%rip),%r12        # f6c4 <fwp_segv.msg+0x444>
    84f9:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    84fe:	66 90                	xchg   %ax,%ax
    8500:	ba 02 00 00 00       	mov    $0x2,%edx
    8505:	48 89 ef             	mov    %rbp,%rdi
    8508:	4c 89 fe             	mov    %r15,%rsi
    850b:	e8 e0 0d 00 00       	call   92f0 <buf_put>
    8510:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    8515:	be 00 02 00 00       	mov    $0x200,%esi
    851a:	4c 89 ef             	mov    %r13,%rdi
    851d:	4c 89 e2             	mov    %r12,%rdx
    8520:	31 c0                	xor    %eax,%eax
    8522:	e8 d9 9b ff ff       	call   2100 <snprintf@plt>
    8527:	4c 89 ef             	mov    %r13,%rdi
    852a:	e8 a1 9b ff ff       	call   20d0 <strlen@plt>
    852f:	48 89 ef             	mov    %rbp,%rdi
    8532:	4c 89 ee             	mov    %r13,%rsi
    8535:	48 89 c2             	mov    %rax,%rdx
    8538:	e8 b3 0d 00 00       	call   92f0 <buf_put>
    853d:	48 8d 43 01          	lea    0x1(%rbx),%rax
    8541:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    8545:	49 3b 1e             	cmp    (%r14),%rbx
    8548:	48 89 c3             	mov    %rax,%rbx
    854b:	72 b3                	jb     8500 <fwp_write+0x5f0>
    854d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    8552:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8557:	e9 90 0a 00 00       	jmp    8fec <fwp_write+0x10dc>
    855c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    8561:	0f 2e c9             	ucomiss %xmm1,%xmm1
    8564:	0f 8a 73 0d 00 00    	jp     92dd <fwp_write+0x13cd>
    856a:	0f 28 05 6f 6b 00 00 	movaps 0x6b6f(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    8571:	0f 54 c1             	andps  %xmm1,%xmm0
    8574:	0f 2e 05 91 6a 00 00 	ucomiss 0x6a91(%rip),%xmm0        # f00c <_IO_stdin_used+0xc>
    857b:	0f 82 6e 04 00 00    	jb     89ef <fwp_write+0xadf>
    8581:	0f 57 c0             	xorps  %xmm0,%xmm0
    8584:	0f 2e c8             	ucomiss %xmm0,%xmm1
    8587:	48 8d 05 62 71 00 00 	lea    0x7162(%rip),%rax        # f6f0 <fwp_segv.msg+0x470>
    858e:	48 8d 35 5a 71 00 00 	lea    0x715a(%rip),%rsi        # f6ef <fwp_segv.msg+0x46f>
    8595:	48 0f 47 f0          	cmova  %rax,%rsi
    8599:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    859e:	e8 cd 9a ff ff       	call   2070 <strcpy@plt>
    85a3:	e9 90 0b 00 00       	jmp    9138 <fwp_write+0x1228>
    85a8:	48 8d 35 f0 70 00 00 	lea    0x70f0(%rip),%rsi        # f69f <fwp_segv.msg+0x41f>
    85af:	ba 0a 00 00 00       	mov    $0xa,%edx
    85b4:	48 89 ef             	mov    %rbp,%rdi
    85b7:	e9 06 09 00 00       	jmp    8ec2 <fwp_write+0xfb2>
    85bc:	48 8d 35 f0 70 00 00 	lea    0x70f0(%rip),%rsi        # f6b3 <fwp_segv.msg+0x433>
    85c3:	ba 06 00 00 00       	mov    $0x6,%edx
    85c8:	48 89 ef             	mov    %rbp,%rdi
    85cb:	e8 20 0d 00 00       	call   92f0 <buf_put>
    85d0:	49 83 c6 10          	add    $0x10,%r14
    85d4:	4c 89 f7             	mov    %r14,%rdi
    85d7:	e8 f4 9a ff ff       	call   20d0 <strlen@plt>
    85dc:	48 89 ef             	mov    %rbp,%rdi
    85df:	4c 89 f6             	mov    %r14,%rsi
    85e2:	48 89 c2             	mov    %rax,%rdx
    85e5:	e8 06 0d 00 00       	call   92f0 <buf_put>
    85ea:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    85ef:	e9 f3 09 00 00       	jmp    8fe7 <fwp_write+0x10d7>
    85f4:	41 8b 06             	mov    (%r14),%eax
    85f7:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    85fb:	41 89 c5             	mov    %eax,%r13d
    85fe:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    8602:	4c 89 e7             	mov    %r12,%rdi
    8605:	e8 c6 9a ff ff       	call   20d0 <strlen@plt>
    860a:	48 89 ef             	mov    %rbp,%rdi
    860d:	4c 89 e6             	mov    %r12,%rsi
    8610:	48 89 c2             	mov    %rax,%rdx
    8613:	e8 d8 0c 00 00       	call   92f0 <buf_put>
    8618:	49 8b 47 28          	mov    0x28(%r15),%rax
    861c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    8621:	0f 8e 2c 0b 00 00    	jle    9153 <fwp_write+0x1243>
    8627:	45 31 e4             	xor    %r12d,%r12d
    862a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    862f:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    8634:	eb 3c                	jmp    8672 <fwp_write+0x762>
    8636:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    863d:	00 00 00 
    8640:	48 8b 2c 24          	mov    (%rsp),%rbp
    8644:	48 89 ef             	mov    %rbp,%rdi
    8647:	48 89 de             	mov    %rbx,%rsi
    864a:	4c 89 ea             	mov    %r13,%rdx
    864d:	31 c9                	xor    %ecx,%ecx
    864f:	e8 bc f8 ff ff       	call   7f10 <fwp_write>
    8654:	49 ff c4             	inc    %r12
    8657:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    865c:	49 8b 47 28          	mov    0x28(%r15),%rax
    8660:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    8665:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    8669:	49 39 c4             	cmp    %rax,%r12
    866c:	0f 8d e1 0a 00 00    	jge    9153 <fwp_write+0x1243>
    8672:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    8677:	49 8b 47 30          	mov    0x30(%r15),%rax
    867b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    867f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    8683:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    8688:	ba 01 00 00 00       	mov    $0x1,%edx
    868d:	48 89 ef             	mov    %rbp,%rdi
    8690:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8695:	e8 56 0c 00 00       	call   92f0 <buf_put>
    869a:	41 8b 45 00          	mov    0x0(%r13),%eax
    869e:	48 83 f8 10          	cmp    $0x10,%rax
    86a2:	77 9c                	ja     8640 <fwp_write+0x730>
    86a4:	48 8d 0d dd 6a 00 00 	lea    0x6add(%rip),%rcx        # f188 <_IO_stdin_used+0x188>
    86ab:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    86af:	48 01 c8             	add    %rcx,%rax
    86b2:	ff e0                	jmp    *%rax
    86b4:	48 89 d9             	mov    %rbx,%rcx
    86b7:	48 c1 e9 3f          	shr    $0x3f,%rcx
    86bb:	85 c9                	test   %ecx,%ecx
    86bd:	74 81                	je     8640 <fwp_write+0x730>
    86bf:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    86c4:	ba 01 00 00 00       	mov    $0x1,%edx
    86c9:	48 8b 2c 24          	mov    (%rsp),%rbp
    86cd:	48 89 ef             	mov    %rbp,%rdi
    86d0:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    86d5:	4c 89 fe             	mov    %r15,%rsi
    86d8:	e8 13 0c 00 00       	call   92f0 <buf_put>
    86dd:	48 89 ef             	mov    %rbp,%rdi
    86e0:	48 89 de             	mov    %rbx,%rsi
    86e3:	4c 89 ea             	mov    %r13,%rdx
    86e6:	31 c9                	xor    %ecx,%ecx
    86e8:	e8 23 f8 ff ff       	call   7f10 <fwp_write>
    86ed:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    86f2:	ba 01 00 00 00       	mov    $0x1,%edx
    86f7:	48 89 ef             	mov    %rbp,%rdi
    86fa:	4c 89 fe             	mov    %r15,%rsi
    86fd:	e8 ee 0b 00 00       	call   92f0 <buf_put>
    8702:	e9 4d ff ff ff       	jmp    8654 <fwp_write+0x744>
    8707:	31 c9                	xor    %ecx,%ecx
    8709:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    8710:	0f 93 c1             	setae  %cl
    8713:	eb a6                	jmp    86bb <fwp_write+0x7ab>
    8715:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8719:	eb 9c                	jmp    86b7 <fwp_write+0x7a7>
    871b:	89 d9                	mov    %ebx,%ecx
    871d:	c1 e9 1f             	shr    $0x1f,%ecx
    8720:	eb 99                	jmp    86bb <fwp_write+0x7ab>
    8722:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    8726:	48 85 ff             	test   %rdi,%rdi
    8729:	0f 84 11 ff ff ff    	je     8640 <fwp_write+0x730>
    872f:	48 8d 35 a5 6f 00 00 	lea    0x6fa5(%rip),%rsi        # f6db <fwp_segv.msg+0x45b>
    8736:	e8 35 9a ff ff       	call   2170 <strcmp@plt>
    873b:	31 c9                	xor    %ecx,%ecx
    873d:	85 c0                	test   %eax,%eax
    873f:	0f 95 c1             	setne  %cl
    8742:	e9 74 ff ff ff       	jmp    86bb <fwp_write+0x7ab>
    8747:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    874c:	0f 84 a7 08 00 00    	je     8ff9 <fwp_write+0x10e9>
    8752:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    8756:	4d 85 e4             	test   %r12,%r12
    8759:	0f 94 c0             	sete   %al
    875c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    8761:	0f 95 c3             	setne  %bl
    8764:	20 c3                	and    %al,%bl
    8766:	84 db                	test   %bl,%bl
    8768:	b8 28 00 00 00       	mov    $0x28,%eax
    876d:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    8772:	0f 45 c8             	cmovne %eax,%ecx
    8775:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8779:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    877e:	ba 01 00 00 00       	mov    $0x1,%edx
    8783:	48 89 ef             	mov    %rbp,%rdi
    8786:	e8 65 0b 00 00       	call   92f0 <buf_put>
    878b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8790:	0f 8e da 00 00 00    	jle    8870 <fwp_write+0x960>
    8796:	84 db                	test   %bl,%bl
    8798:	75 31                	jne    87cb <fwp_write+0x8bb>
    879a:	49 8b 47 18          	mov    0x18(%r15),%rax
    879e:	4c 8b 20             	mov    (%rax),%r12
    87a1:	4c 89 e7             	mov    %r12,%rdi
    87a4:	e8 27 99 ff ff       	call   20d0 <strlen@plt>
    87a9:	48 89 ef             	mov    %rbp,%rdi
    87ac:	4c 89 e6             	mov    %r12,%rsi
    87af:	48 89 c2             	mov    %rax,%rdx
    87b2:	e8 39 0b 00 00       	call   92f0 <buf_put>
    87b7:	48 8d 35 29 6f 00 00 	lea    0x6f29(%rip),%rsi        # f6e7 <fwp_segv.msg+0x467>
    87be:	ba 03 00 00 00       	mov    $0x3,%edx
    87c3:	48 89 ef             	mov    %rbp,%rdi
    87c6:	e8 25 0b 00 00       	call   92f0 <buf_put>
    87cb:	49 8b 76 08          	mov    0x8(%r14),%rsi
    87cf:	49 8b 47 20          	mov    0x20(%r15),%rax
    87d3:	48 8b 10             	mov    (%rax),%rdx
    87d6:	48 89 ef             	mov    %rbp,%rdi
    87d9:	31 c9                	xor    %ecx,%ecx
    87db:	e8 30 f7 ff ff       	call   7f10 <fwp_write>
    87e0:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    87e5:	0f 8c 85 00 00 00    	jl     8870 <fwp_write+0x960>
    87eb:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    87f1:	4c 8d 25 c9 6e 00 00 	lea    0x6ec9(%rip),%r12        # f6c1 <fwp_segv.msg+0x441>
    87f8:	eb 29                	jmp    8823 <fwp_write+0x913>
    87fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8800:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    8805:	49 8b 47 20          	mov    0x20(%r15),%rax
    8809:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    880d:	48 89 ef             	mov    %rbp,%rdi
    8810:	31 c9                	xor    %ecx,%ecx
    8812:	e8 f9 f6 ff ff       	call   7f10 <fwp_write>
    8817:	49 ff c5             	inc    %r13
    881a:	49 63 47 10          	movslq 0x10(%r15),%rax
    881e:	49 39 c5             	cmp    %rax,%r13
    8821:	7d 4d                	jge    8870 <fwp_write+0x960>
    8823:	ba 02 00 00 00       	mov    $0x2,%edx
    8828:	48 89 ef             	mov    %rbp,%rdi
    882b:	4c 89 e6             	mov    %r12,%rsi
    882e:	e8 bd 0a 00 00       	call   92f0 <buf_put>
    8833:	84 db                	test   %bl,%bl
    8835:	75 c9                	jne    8800 <fwp_write+0x8f0>
    8837:	49 8b 47 18          	mov    0x18(%r15),%rax
    883b:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    883f:	48 89 ef             	mov    %rbp,%rdi
    8842:	e8 89 98 ff ff       	call   20d0 <strlen@plt>
    8847:	48 8b 3c 24          	mov    (%rsp),%rdi
    884b:	48 89 ee             	mov    %rbp,%rsi
    884e:	48 8b 2c 24          	mov    (%rsp),%rbp
    8852:	48 89 c2             	mov    %rax,%rdx
    8855:	e8 96 0a 00 00       	call   92f0 <buf_put>
    885a:	ba 03 00 00 00       	mov    $0x3,%edx
    885f:	48 89 ef             	mov    %rbp,%rdi
    8862:	48 8d 35 7e 6e 00 00 	lea    0x6e7e(%rip),%rsi        # f6e7 <fwp_segv.msg+0x467>
    8869:	e8 82 0a 00 00       	call   92f0 <buf_put>
    886e:	eb 90                	jmp    8800 <fwp_write+0x8f0>
    8870:	84 db                	test   %bl,%bl
    8872:	b8 29 00 00 00       	mov    $0x29,%eax
    8877:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    887c:	0f 45 c8             	cmovne %eax,%ecx
    887f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8883:	e9 5f 07 00 00       	jmp    8fe7 <fwp_write+0x10d7>
    8888:	48 89 ef             	mov    %rbp,%rdi
    888b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8892:	5b                   	pop    %rbx
    8893:	41 5c                	pop    %r12
    8895:	41 5d                	pop    %r13
    8897:	41 5e                	pop    %r14
    8899:	41 5f                	pop    %r15
    889b:	5d                   	pop    %rbp
    889c:	e9 3f 0b 00 00       	jmp    93e0 <fwp_escape>
    88a1:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    88a6:	bf 01 00 00 00       	mov    $0x1,%edi
    88ab:	89 f8                	mov    %edi,%eax
    88ad:	48 83 f8 08          	cmp    $0x8,%rax
    88b1:	73 0a                	jae    88bd <fwp_write+0x9ad>
    88b3:	31 c9                	xor    %ecx,%ecx
    88b5:	48 89 c2             	mov    %rax,%rdx
    88b8:	e9 7a 04 00 00       	jmp    8d37 <fwp_write+0xe27>
    88bd:	83 f8 20             	cmp    $0x20,%eax
    88c0:	0f 83 68 03 00 00    	jae    8c2e <fwp_write+0xd1e>
    88c6:	31 c9                	xor    %ecx,%ecx
    88c8:	e9 10 04 00 00       	jmp    8cdd <fwp_write+0xdcd>
    88cd:	31 ff                	xor    %edi,%edi
    88cf:	49 f7 d8             	neg    %r8
    88d2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    88d8:	4d 19 ca             	sbb    %r9,%r10
    88db:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    88e0:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    88e7:	cc cc cc 
    88ea:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    88f1:	cc cc cc 
    88f4:	4c 89 d3             	mov    %r10,%rbx
    88f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    88fe:	00 00 
    8900:	4c 89 d1             	mov    %r10,%rcx
    8903:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8908:	48 d1 eb             	shr    $1,%rbx
    890b:	48 89 ce             	mov    %rcx,%rsi
    890e:	48 01 de             	add    %rbx,%rsi
    8911:	48 83 d6 00          	adc    $0x0,%rsi
    8915:	48 89 f0             	mov    %rsi,%rax
    8918:	49 f7 e1             	mul    %r9
    891b:	48 c1 ea 02          	shr    $0x2,%rdx
    891f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    8923:	48 29 c6             	sub    %rax,%rsi
    8926:	48 29 f1             	sub    %rsi,%rcx
    8929:	48 83 db 00          	sbb    $0x0,%rbx
    892d:	48 89 ce             	mov    %rcx,%rsi
    8930:	49 0f af f3          	imul   %r11,%rsi
    8934:	48 89 c8             	mov    %rcx,%rax
    8937:	49 f7 e1             	mul    %r9
    893a:	48 01 f2             	add    %rsi,%rdx
    893d:	49 0f af d9          	imul   %r9,%rbx
    8941:	48 01 d3             	add    %rdx,%rbx
    8944:	48 89 c1             	mov    %rax,%rcx
    8947:	48 01 c1             	add    %rax,%rcx
    894a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    894e:	44 89 c2             	mov    %r8d,%edx
    8951:	29 ca                	sub    %ecx,%edx
    8953:	80 ca 30             	or     $0x30,%dl
    8956:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    895a:	48 ff c7             	inc    %rdi
    895d:	49 83 f8 0a          	cmp    $0xa,%r8
    8961:	49 83 da 00          	sbb    $0x0,%r10
    8965:	49 89 c0             	mov    %rax,%r8
    8968:	49 89 da             	mov    %rbx,%r10
    896b:	73 93                	jae    8900 <fwp_write+0x9f0>
    896d:	85 ff                	test   %edi,%edi
    896f:	0f 8e 98 06 00 00    	jle    900d <fwp_write+0x10fd>
    8975:	89 f8                	mov    %edi,%eax
    8977:	48 83 f8 08          	cmp    $0x8,%rax
    897b:	0f 83 e4 07 00 00    	jae    9165 <fwp_write+0x1255>
    8981:	31 c9                	xor    %ecx,%ecx
    8983:	48 89 c2             	mov    %rax,%rdx
    8986:	e9 fc 08 00 00       	jmp    9287 <fwp_write+0x1377>
    898b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8990:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8995:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    899a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    89a0:	4c 89 f7             	mov    %r14,%rdi
    89a3:	66 0f 28 c1          	movapd %xmm1,%xmm0
    89a7:	89 ee                	mov    %ebp,%esi
    89a9:	e8 a2 16 00 00       	call   a050 <fwp_format_g>
    89ae:	4c 89 f7             	mov    %r14,%rdi
    89b1:	31 f6                	xor    %esi,%esi
    89b3:	e8 d8 96 ff ff       	call   2090 <strtod@plt>
    89b8:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    89be:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    89c2:	75 06                	jne    89ca <fwp_write+0xaba>
    89c4:	0f 8b 9e 03 00 00    	jnp    8d68 <fwp_write+0xe58>
    89ca:	ff c5                	inc    %ebp
    89cc:	83 fd 12             	cmp    $0x12,%ebp
    89cf:	75 cf                	jne    89a0 <fwp_write+0xa90>
    89d1:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    89d6:	4c 89 f7             	mov    %r14,%rdi
    89d9:	66 0f 28 c1          	movapd %xmm1,%xmm0
    89dd:	be 11 00 00 00       	mov    $0x11,%esi
    89e2:	e8 69 16 00 00       	call   a050 <fwp_format_g>
    89e7:	4c 89 f7             	mov    %r14,%rdi
    89ea:	e9 7e 03 00 00       	jmp    8d6d <fwp_write+0xe5d>
    89ef:	0f 57 c0             	xorps  %xmm0,%xmm0
    89f2:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    89f6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    89fb:	4c 89 f7             	mov    %r14,%rdi
    89fe:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    8a04:	be 01 00 00 00       	mov    $0x1,%esi
    8a09:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    8a0d:	e8 3e 16 00 00       	call   a050 <fwp_format_g>
    8a12:	4c 89 f7             	mov    %r14,%rdi
    8a15:	31 f6                	xor    %esi,%esi
    8a17:	e8 f4 96 ff ff       	call   2110 <strtof@plt>
    8a1c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a20:	75 06                	jne    8a28 <fwp_write+0xb18>
    8a22:	0f 8b 6f 01 00 00    	jnp    8b97 <fwp_write+0xc87>
    8a28:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a2d:	4c 89 f7             	mov    %r14,%rdi
    8a30:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8a36:	be 02 00 00 00       	mov    $0x2,%esi
    8a3b:	e8 10 16 00 00       	call   a050 <fwp_format_g>
    8a40:	4c 89 f7             	mov    %r14,%rdi
    8a43:	31 f6                	xor    %esi,%esi
    8a45:	e8 c6 96 ff ff       	call   2110 <strtof@plt>
    8a4a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a4e:	75 06                	jne    8a56 <fwp_write+0xb46>
    8a50:	0f 8b 41 01 00 00    	jnp    8b97 <fwp_write+0xc87>
    8a56:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a5b:	4c 89 f7             	mov    %r14,%rdi
    8a5e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8a64:	be 03 00 00 00       	mov    $0x3,%esi
    8a69:	e8 e2 15 00 00       	call   a050 <fwp_format_g>
    8a6e:	4c 89 f7             	mov    %r14,%rdi
    8a71:	31 f6                	xor    %esi,%esi
    8a73:	e8 98 96 ff ff       	call   2110 <strtof@plt>
    8a78:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a7c:	75 06                	jne    8a84 <fwp_write+0xb74>
    8a7e:	0f 8b 13 01 00 00    	jnp    8b97 <fwp_write+0xc87>
    8a84:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a89:	4c 89 f7             	mov    %r14,%rdi
    8a8c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8a92:	be 04 00 00 00       	mov    $0x4,%esi
    8a97:	e8 b4 15 00 00       	call   a050 <fwp_format_g>
    8a9c:	4c 89 f7             	mov    %r14,%rdi
    8a9f:	31 f6                	xor    %esi,%esi
    8aa1:	e8 6a 96 ff ff       	call   2110 <strtof@plt>
    8aa6:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8aaa:	75 06                	jne    8ab2 <fwp_write+0xba2>
    8aac:	0f 8b e5 00 00 00    	jnp    8b97 <fwp_write+0xc87>
    8ab2:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8ab7:	4c 89 f7             	mov    %r14,%rdi
    8aba:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8ac0:	be 05 00 00 00       	mov    $0x5,%esi
    8ac5:	e8 86 15 00 00       	call   a050 <fwp_format_g>
    8aca:	4c 89 f7             	mov    %r14,%rdi
    8acd:	31 f6                	xor    %esi,%esi
    8acf:	e8 3c 96 ff ff       	call   2110 <strtof@plt>
    8ad4:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8ad8:	75 06                	jne    8ae0 <fwp_write+0xbd0>
    8ada:	0f 8b b7 00 00 00    	jnp    8b97 <fwp_write+0xc87>
    8ae0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8ae5:	4c 89 f7             	mov    %r14,%rdi
    8ae8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8aee:	be 06 00 00 00       	mov    $0x6,%esi
    8af3:	e8 58 15 00 00       	call   a050 <fwp_format_g>
    8af8:	4c 89 f7             	mov    %r14,%rdi
    8afb:	31 f6                	xor    %esi,%esi
    8afd:	e8 0e 96 ff ff       	call   2110 <strtof@plt>
    8b02:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8b06:	75 06                	jne    8b0e <fwp_write+0xbfe>
    8b08:	0f 8b 89 00 00 00    	jnp    8b97 <fwp_write+0xc87>
    8b0e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8b13:	4c 89 f7             	mov    %r14,%rdi
    8b16:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b1c:	be 07 00 00 00       	mov    $0x7,%esi
    8b21:	e8 2a 15 00 00       	call   a050 <fwp_format_g>
    8b26:	4c 89 f7             	mov    %r14,%rdi
    8b29:	31 f6                	xor    %esi,%esi
    8b2b:	e8 e0 95 ff ff       	call   2110 <strtof@plt>
    8b30:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8b34:	75 02                	jne    8b38 <fwp_write+0xc28>
    8b36:	7b 5f                	jnp    8b97 <fwp_write+0xc87>
    8b38:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8b3d:	4c 89 f7             	mov    %r14,%rdi
    8b40:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b46:	be 08 00 00 00       	mov    $0x8,%esi
    8b4b:	e8 00 15 00 00       	call   a050 <fwp_format_g>
    8b50:	4c 89 f7             	mov    %r14,%rdi
    8b53:	31 f6                	xor    %esi,%esi
    8b55:	e8 b6 95 ff ff       	call   2110 <strtof@plt>
    8b5a:	0f 28 0c 24          	movaps (%rsp),%xmm1
    8b5e:	0f 2e c1             	ucomiss %xmm1,%xmm0
    8b61:	75 02                	jne    8b65 <fwp_write+0xc55>
    8b63:	7b 32                	jnp    8b97 <fwp_write+0xc87>
    8b65:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8b6a:	4c 89 f7             	mov    %r14,%rdi
    8b6d:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b73:	be 09 00 00 00       	mov    $0x9,%esi
    8b78:	e8 d3 14 00 00       	call   a050 <fwp_format_g>
    8b7d:	4c 89 f7             	mov    %r14,%rdi
    8b80:	31 f6                	xor    %esi,%esi
    8b82:	e8 89 95 ff ff       	call   2110 <strtof@plt>
    8b87:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8b8b:	0f 85 2c 07 00 00    	jne    92bd <fwp_write+0x13ad>
    8b91:	0f 8a 26 07 00 00    	jp     92bd <fwp_write+0x13ad>
    8b97:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8b9c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8ba1:	e8 4a 95 ff ff       	call   20f0 <strchr@plt>
    8ba6:	48 85 c0             	test   %rax,%rax
    8ba9:	0f 85 89 05 00 00    	jne    9138 <fwp_write+0x1228>
    8baf:	e9 d0 01 00 00       	jmp    8d84 <fwp_write+0xe74>
    8bb4:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    8bbb:	00 
    8bbc:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8bc3:	00 
    8bc4:	4c 29 ff             	sub    %r15,%rdi
    8bc7:	48 39 cf             	cmp    %rcx,%rdi
    8bca:	0f 83 1b 02 00 00    	jae    8deb <fwp_write+0xedb>
    8bd0:	48 89 d7             	mov    %rdx,%rdi
    8bd3:	be 01 00 00 00       	mov    $0x1,%esi
    8bd8:	e8 63 e3 ff ff       	call   6f40 <fwp_gc_alloc_slow>
    8bdd:	49 89 c7             	mov    %rax,%r15
    8be0:	e9 20 02 00 00       	jmp    8e05 <fwp_write+0xef5>
    8be5:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8be9:	48 89 f2             	mov    %rsi,%rdx
    8bec:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8bf0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8bf5:	4c 89 f7             	mov    %r14,%rdi
    8bf8:	e8 23 09 00 00       	call   9520 <fwp_fmt_duration>
    8bfd:	e9 3b 05 00 00       	jmp    913d <fwp_write+0x122d>
    8c02:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8c07:	bf 01 00 00 00       	mov    $0x1,%edi
    8c0c:	89 f8                	mov    %edi,%eax
    8c0e:	48 83 f8 08          	cmp    $0x8,%rax
    8c12:	73 0a                	jae    8c1e <fwp_write+0xd0e>
    8c14:	31 c9                	xor    %ecx,%ecx
    8c16:	48 89 c2             	mov    %rax,%rdx
    8c19:	e9 f2 04 00 00       	jmp    9110 <fwp_write+0x1200>
    8c1e:	83 f8 20             	cmp    $0x20,%eax
    8c21:	0f 83 f2 03 00 00    	jae    9019 <fwp_write+0x1109>
    8c27:	31 c9                	xor    %ecx,%ecx
    8c29:	e9 92 04 00 00       	jmp    90c0 <fwp_write+0x11b0>
    8c2e:	89 fa                	mov    %edi,%edx
    8c30:	83 e2 1f             	and    $0x1f,%edx
    8c33:	48 89 c1             	mov    %rax,%rcx
    8c36:	48 29 d1             	sub    %rdx,%rcx
    8c39:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    8c40:	00 
    8c41:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8c45:	49 89 c0             	mov    %rax,%r8
    8c48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8c4f:	00 
    8c50:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8c56:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    8c5d:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8c61:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8c65:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8c6a:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8c6f:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8c74:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8c78:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8c7d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8c82:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8c87:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8c8b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8c8f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8c93:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8c98:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8c9d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8ca2:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8ca6:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8cab:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8cb0:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8cb5:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8cb9:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8cbe:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8cc2:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8cc6:	48 83 c6 20          	add    $0x20,%rsi
    8cca:	4c 39 c2             	cmp    %r8,%rdx
    8ccd:	75 81                	jne    8c50 <fwp_write+0xd40>
    8ccf:	48 85 d2             	test   %rdx,%rdx
    8cd2:	0f 84 5b 04 00 00    	je     9133 <fwp_write+0x1223>
    8cd8:	83 fa 08             	cmp    $0x8,%edx
    8cdb:	72 5a                	jb     8d37 <fwp_write+0xe27>
    8cdd:	89 fa                	mov    %edi,%edx
    8cdf:	83 e2 07             	and    $0x7,%edx
    8ce2:	48 89 c6             	mov    %rax,%rsi
    8ce5:	48 29 ce             	sub    %rcx,%rsi
    8ce8:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    8cec:	48 83 c7 70          	add    $0x70,%rdi
    8cf0:	48 89 c1             	mov    %rax,%rcx
    8cf3:	48 29 d1             	sub    %rdx,%rcx
    8cf6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8cfa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8d00:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8d06:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8d0a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8d0f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8d14:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8d19:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8d1d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8d21:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8d25:	48 83 c7 08          	add    $0x8,%rdi
    8d29:	48 39 f2             	cmp    %rsi,%rdx
    8d2c:	75 d2                	jne    8d00 <fwp_write+0xdf0>
    8d2e:	48 85 d2             	test   %rdx,%rdx
    8d31:	0f 84 fc 03 00 00    	je     9133 <fwp_write+0x1223>
    8d37:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8d3c:	48 01 f2             	add    %rsi,%rdx
    8d3f:	48 ff ca             	dec    %rdx
    8d42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8d49:	1f 84 00 00 00 00 00 
    8d50:	0f b6 32             	movzbl (%rdx),%esi
    8d53:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8d58:	48 ff c1             	inc    %rcx
    8d5b:	48 ff ca             	dec    %rdx
    8d5e:	48 39 c8             	cmp    %rcx,%rax
    8d61:	75 ed                	jne    8d50 <fwp_write+0xe40>
    8d63:	e9 cb 03 00 00       	jmp    9133 <fwp_write+0x1223>
    8d68:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d6d:	be 2e 00 00 00       	mov    $0x2e,%esi
    8d72:	e8 79 93 ff ff       	call   20f0 <strchr@plt>
    8d77:	48 85 c0             	test   %rax,%rax
    8d7a:	48 8b 2c 24          	mov    (%rsp),%rbp
    8d7e:	0f 85 b4 03 00 00    	jne    9138 <fwp_write+0x1228>
    8d84:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d89:	be 65 00 00 00       	mov    $0x65,%esi
    8d8e:	e8 5d 93 ff ff       	call   20f0 <strchr@plt>
    8d93:	48 85 c0             	test   %rax,%rax
    8d96:	0f 85 9c 03 00 00    	jne    9138 <fwp_write+0x1228>
    8d9c:	48 8d 35 4d 69 00 00 	lea    0x694d(%rip),%rsi        # f6f0 <fwp_segv.msg+0x470>
    8da3:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8da8:	e8 13 95 ff ff       	call   22c0 <strstr@plt>
    8dad:	48 85 c0             	test   %rax,%rax
    8db0:	0f 85 82 03 00 00    	jne    9138 <fwp_write+0x1228>
    8db6:	48 8d 35 2e 69 00 00 	lea    0x692e(%rip),%rsi        # f6eb <fwp_segv.msg+0x46b>
    8dbd:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8dc2:	e8 f9 94 ff ff       	call   22c0 <strstr@plt>
    8dc7:	48 85 c0             	test   %rax,%rax
    8dca:	0f 85 68 03 00 00    	jne    9138 <fwp_write+0x1228>
    8dd0:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8dd5:	e8 f6 92 ff ff       	call   20d0 <strlen@plt>
    8dda:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8de1:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8de6:	e9 4d 03 00 00       	jmp    9138 <fwp_write+0x1228>
    8deb:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    8def:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8df5:	4c 01 f9             	add    %r15,%rcx
    8df8:	48 89 08             	mov    %rcx,(%rax)
    8dfb:	4c 89 ff             	mov    %r15,%rdi
    8dfe:	31 f6                	xor    %esi,%esi
    8e00:	e8 1b 93 ff ff       	call   2120 <memset@plt>
    8e05:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    8e0b:	85 db                	test   %ebx,%ebx
    8e0d:	0f 8e 98 00 00 00    	jle    8eab <fwp_write+0xf9b>
    8e13:	44 89 e1             	mov    %r12d,%ecx
    8e16:	48 f7 d9             	neg    %rcx
    8e19:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    8e1d:	48 ff c6             	inc    %rsi
    8e20:	31 ff                	xor    %edi,%edi
    8e22:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    8e29:	55 55 55 
    8e2c:	eb 2e                	jmp    8e5c <fwp_write+0xf4c>
    8e2e:	66 90                	xchg   %ax,%ax
    8e30:	41 b2 30             	mov    $0x30,%r10b
    8e33:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    8e37:	48 85 d2             	test   %rdx,%rdx
    8e3a:	0f 95 c2             	setne  %dl
    8e3d:	4d 85 f6             	test   %r14,%r14
    8e40:	41 0f 98 c2          	sets   %r10b
    8e44:	41 20 d2             	and    %dl,%r10b
    8e47:	41 0f b6 d2          	movzbl %r10b,%edx
    8e4b:	48 29 d0             	sub    %rdx,%rax
    8e4e:	4c 01 c8             	add    %r9,%rax
    8e51:	48 ff cf             	dec    %rdi
    8e54:	49 89 c6             	mov    %rax,%r14
    8e57:	48 39 f9             	cmp    %rdi,%rcx
    8e5a:	74 4f                	je     8eab <fwp_write+0xf9b>
    8e5c:	4c 89 f0             	mov    %r14,%rax
    8e5f:	49 f7 e8             	imul   %r8
    8e62:	48 89 d0             	mov    %rdx,%rax
    8e65:	48 c1 e8 3f          	shr    $0x3f,%rax
    8e69:	48 01 d0             	add    %rdx,%rax
    8e6c:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    8e70:	4c 89 f2             	mov    %r14,%rdx
    8e73:	4c 29 ca             	sub    %r9,%rdx
    8e76:	49 f7 d9             	neg    %r9
    8e79:	4d 01 f1             	add    %r14,%r9
    8e7c:	49 83 c1 03          	add    $0x3,%r9
    8e80:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8e84:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8e88:	4d 85 c9             	test   %r9,%r9
    8e8b:	74 a3                	je     8e30 <fwp_write+0xf20>
    8e8d:	49 83 f9 01          	cmp    $0x1,%r9
    8e91:	75 0d                	jne    8ea0 <fwp_write+0xf90>
    8e93:	41 b2 2b             	mov    $0x2b,%r10b
    8e96:	45 31 c9             	xor    %r9d,%r9d
    8e99:	eb 98                	jmp    8e33 <fwp_write+0xf23>
    8e9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8ea0:	41 b2 2d             	mov    $0x2d,%r10b
    8ea3:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8ea9:	eb 88                	jmp    8e33 <fwp_write+0xf23>
    8eab:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8eb1:	4c 89 ff             	mov    %r15,%rdi
    8eb4:	e8 17 92 ff ff       	call   20d0 <strlen@plt>
    8eb9:	48 89 ef             	mov    %rbp,%rdi
    8ebc:	4c 89 fe             	mov    %r15,%rsi
    8ebf:	48 89 c2             	mov    %rax,%rdx
    8ec2:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8ec9:	5b                   	pop    %rbx
    8eca:	41 5c                	pop    %r12
    8ecc:	41 5d                	pop    %r13
    8ece:	41 5e                	pop    %r14
    8ed0:	41 5f                	pop    %r15
    8ed2:	5d                   	pop    %rbp
    8ed3:	e9 18 04 00 00       	jmp    92f0 <buf_put>
    8ed8:	48 8b 31             	mov    (%rcx),%rsi
    8edb:	eb 18                	jmp    8ef5 <fwp_write+0xfe5>
    8edd:	83 3a 00             	cmpl   $0x0,(%rdx)
    8ee0:	0f b6 01             	movzbl (%rcx),%eax
    8ee3:	48 0f be f0          	movsbq %al,%rsi
    8ee7:	eb 08                	jmp    8ef1 <fwp_write+0xfe1>
    8ee9:	83 3a 02             	cmpl   $0x2,(%rdx)
    8eec:	8b 01                	mov    (%rcx),%eax
    8eee:	48 63 f0             	movslq %eax,%rsi
    8ef1:	48 0f 45 f0          	cmovne %rax,%rsi
    8ef5:	48 8b 2c 24          	mov    (%rsp),%rbp
    8ef9:	48 89 ef             	mov    %rbp,%rdi
    8efc:	31 c9                	xor    %ecx,%ecx
    8efe:	e8 0d f0 ff ff       	call   7f10 <fwp_write>
    8f03:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8f0a:	ff ff 7f 
    8f0d:	48 ff c8             	dec    %rax
    8f10:	49 85 06             	test   %rax,(%r14)
    8f13:	0f 84 c9 00 00 00    	je     8fe2 <fwp_write+0x10d2>
    8f19:	bb 01 00 00 00       	mov    $0x1,%ebx
    8f1e:	4c 8d 25 9c 67 00 00 	lea    0x679c(%rip),%r12        # f6c1 <fwp_segv.msg+0x441>
    8f25:	eb 39                	jmp    8f60 <fwp_write+0x1050>
    8f27:	83 3a 01             	cmpl   $0x1,(%rdx)
    8f2a:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    8f2e:	48 0f bf f0          	movswq %ax,%rsi
    8f32:	48 0f 45 f0          	cmovne %rax,%rsi
    8f36:	48 8b 2c 24          	mov    (%rsp),%rbp
    8f3a:	48 89 ef             	mov    %rbp,%rdi
    8f3d:	31 c9                	xor    %ecx,%ecx
    8f3f:	e8 cc ef ff ff       	call   7f10 <fwp_write>
    8f44:	48 ff c3             	inc    %rbx
    8f47:	49 8b 06             	mov    (%r14),%rax
    8f4a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    8f51:	ff ff 7f 
    8f54:	48 21 c8             	and    %rcx,%rax
    8f57:	48 39 c3             	cmp    %rax,%rbx
    8f5a:	0f 83 82 00 00 00    	jae    8fe2 <fwp_write+0x10d2>
    8f60:	ba 02 00 00 00       	mov    $0x2,%edx
    8f65:	48 89 ef             	mov    %rbp,%rdi
    8f68:	4c 89 e6             	mov    %r12,%rsi
    8f6b:	e8 80 03 00 00       	call   92f0 <buf_put>
    8f70:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8f74:	b8 08 00 00 00       	mov    $0x8,%eax
    8f79:	48 85 d2             	test   %rdx,%rdx
    8f7c:	74 13                	je     8f91 <fwp_write+0x1081>
    8f7e:	8b 0a                	mov    (%rdx),%ecx
    8f80:	48 83 f9 0a          	cmp    $0xa,%rcx
    8f84:	77 0b                	ja     8f91 <fwp_write+0x1081>
    8f86:	48 8d 05 6b 63 00 00 	lea    0x636b(%rip),%rax        # f2f8 <fwp_segv.msg+0x78>
    8f8d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8f91:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8f95:	4c 89 e9             	mov    %r13,%rcx
    8f98:	79 04                	jns    8f9e <fwp_write+0x108e>
    8f9a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8f9e:	48 89 c6             	mov    %rax,%rsi
    8fa1:	48 0f af f3          	imul   %rbx,%rsi
    8fa5:	48 83 f8 01          	cmp    $0x1,%rax
    8fa9:	74 19                	je     8fc4 <fwp_write+0x10b4>
    8fab:	48 83 f8 02          	cmp    $0x2,%rax
    8faf:	0f 84 72 ff ff ff    	je     8f27 <fwp_write+0x1017>
    8fb5:	48 83 f8 08          	cmp    $0x8,%rax
    8fb9:	75 19                	jne    8fd4 <fwp_write+0x10c4>
    8fbb:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    8fbf:	e9 72 ff ff ff       	jmp    8f36 <fwp_write+0x1026>
    8fc4:	83 3a 00             	cmpl   $0x0,(%rdx)
    8fc7:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    8fcb:	48 0f be f0          	movsbq %al,%rsi
    8fcf:	e9 5e ff ff ff       	jmp    8f32 <fwp_write+0x1022>
    8fd4:	83 3a 02             	cmpl   $0x2,(%rdx)
    8fd7:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    8fda:	48 63 f0             	movslq %eax,%rsi
    8fdd:	e9 50 ff ff ff       	jmp    8f32 <fwp_write+0x1022>
    8fe2:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8fe7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8fec:	ba 01 00 00 00       	mov    $0x1,%edx
    8ff1:	48 89 ef             	mov    %rbp,%rdi
    8ff4:	e9 55 01 00 00       	jmp    914e <fwp_write+0x123e>
    8ff9:	48 8d 35 e4 66 00 00 	lea    0x66e4(%rip),%rsi        # f6e4 <fwp_segv.msg+0x464>
    9000:	ba 02 00 00 00       	mov    $0x2,%edx
    9005:	48 89 ef             	mov    %rbp,%rdi
    9008:	e9 b5 fe ff ff       	jmp    8ec2 <fwp_write+0xfb2>
    900d:	31 c0                	xor    %eax,%eax
    900f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    9014:	e9 1f 01 00 00       	jmp    9138 <fwp_write+0x1228>
    9019:	89 fa                	mov    %edi,%edx
    901b:	83 e2 1f             	and    $0x1f,%edx
    901e:	48 89 c1             	mov    %rax,%rcx
    9021:	48 29 d1             	sub    %rdx,%rcx
    9024:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    902b:	00 
    902c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9030:	49 89 c0             	mov    %rax,%r8
    9033:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    9039:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    9040:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9044:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9048:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    904d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9052:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9057:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    905b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9060:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9065:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    906a:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    906e:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9072:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9076:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    907b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9080:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9085:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9089:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    908e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9093:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9098:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    909c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    90a1:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    90a5:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    90a9:	48 83 c6 20          	add    $0x20,%rsi
    90ad:	4c 39 c2             	cmp    %r8,%rdx
    90b0:	75 81                	jne    9033 <fwp_write+0x1123>
    90b2:	48 85 d2             	test   %rdx,%rdx
    90b5:	0f 84 78 00 00 00    	je     9133 <fwp_write+0x1223>
    90bb:	83 fa 08             	cmp    $0x8,%edx
    90be:	72 50                	jb     9110 <fwp_write+0x1200>
    90c0:	89 fa                	mov    %edi,%edx
    90c2:	83 e2 07             	and    $0x7,%edx
    90c5:	48 89 c6             	mov    %rax,%rsi
    90c8:	48 29 ce             	sub    %rcx,%rsi
    90cb:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    90cf:	48 83 c7 70          	add    $0x70,%rdi
    90d3:	48 89 c1             	mov    %rax,%rcx
    90d6:	48 29 d1             	sub    %rdx,%rcx
    90d9:	66 0f ef c0          	pxor   %xmm0,%xmm0
    90dd:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    90e3:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    90e7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    90ec:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    90f1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    90f6:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    90fa:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    90fe:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9102:	48 83 c7 08          	add    $0x8,%rdi
    9106:	48 39 f2             	cmp    %rsi,%rdx
    9109:	75 d2                	jne    90dd <fwp_write+0x11cd>
    910b:	48 85 d2             	test   %rdx,%rdx
    910e:	74 23                	je     9133 <fwp_write+0x1223>
    9110:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9115:	48 01 f2             	add    %rsi,%rdx
    9118:	48 ff ca             	dec    %rdx
    911b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9120:	0f b6 32             	movzbl (%rdx),%esi
    9123:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    9128:	48 ff c1             	inc    %rcx
    912b:	48 ff ca             	dec    %rdx
    912e:	48 39 c8             	cmp    %rcx,%rax
    9131:	75 ed                	jne    9120 <fwp_write+0x1210>
    9133:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    9138:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    913d:	4c 89 f7             	mov    %r14,%rdi
    9140:	e8 8b 8f ff ff       	call   20d0 <strlen@plt>
    9145:	48 89 ef             	mov    %rbp,%rdi
    9148:	4c 89 f6             	mov    %r14,%rsi
    914b:	48 89 c2             	mov    %rax,%rdx
    914e:	e8 9d 01 00 00       	call   92f0 <buf_put>
    9153:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    915a:	5b                   	pop    %rbx
    915b:	41 5c                	pop    %r12
    915d:	41 5d                	pop    %r13
    915f:	41 5e                	pop    %r14
    9161:	41 5f                	pop    %r15
    9163:	5d                   	pop    %rbp
    9164:	c3                   	ret
    9165:	83 f8 20             	cmp    $0x20,%eax
    9168:	73 07                	jae    9171 <fwp_write+0x1261>
    916a:	31 c9                	xor    %ecx,%ecx
    916c:	e9 b6 00 00 00       	jmp    9227 <fwp_write+0x1317>
    9171:	89 fe                	mov    %edi,%esi
    9173:	89 fa                	mov    %edi,%edx
    9175:	83 e2 1f             	and    $0x1f,%edx
    9178:	48 89 c1             	mov    %rax,%rcx
    917b:	48 29 d1             	sub    %rdx,%rcx
    917e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    9182:	49 83 c0 10          	add    $0x10,%r8
    9186:	48 29 d6             	sub    %rdx,%rsi
    9189:	45 31 c9             	xor    %r9d,%r9d
    918c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9190:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    9196:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    919b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    919f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    91a3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    91a8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    91ad:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    91b2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    91b6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    91bb:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    91c0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    91c5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    91c9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    91cd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    91d1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    91d6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    91db:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    91e0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    91e4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    91e9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    91ee:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    91f3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    91f7:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    91fe:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    9205:	00 00 00 
    9208:	49 83 c1 20          	add    $0x20,%r9
    920c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9210:	4c 39 ce             	cmp    %r9,%rsi
    9213:	0f 85 77 ff ff ff    	jne    9190 <fwp_write+0x1280>
    9219:	48 85 d2             	test   %rdx,%rdx
    921c:	0f 84 91 00 00 00    	je     92b3 <fwp_write+0x13a3>
    9222:	83 fa 08             	cmp    $0x8,%edx
    9225:	72 60                	jb     9287 <fwp_write+0x1377>
    9227:	48 89 ce             	mov    %rcx,%rsi
    922a:	41 89 f8             	mov    %edi,%r8d
    922d:	89 fa                	mov    %edi,%edx
    922f:	83 e2 07             	and    $0x7,%edx
    9232:	48 89 c1             	mov    %rax,%rcx
    9235:	48 29 d1             	sub    %rdx,%rcx
    9238:	49 89 f1             	mov    %rsi,%r9
    923b:	49 f7 d9             	neg    %r9
    923e:	49 01 e1             	add    %rsp,%r9
    9241:	49 83 c1 20          	add    $0x20,%r9
    9245:	4d 01 c1             	add    %r8,%r9
    9248:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    924c:	49 29 d0             	sub    %rdx,%r8
    924f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9253:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    9258:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    925c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9261:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9266:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    926b:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    926f:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    9275:	48 83 c6 08          	add    $0x8,%rsi
    9279:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    927d:	49 39 f0             	cmp    %rsi,%r8
    9280:	75 d1                	jne    9253 <fwp_write+0x1343>
    9282:	48 85 d2             	test   %rdx,%rdx
    9285:	74 2c                	je     92b3 <fwp_write+0x13a3>
    9287:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    928c:	48 01 f2             	add    %rsi,%rdx
    928f:	48 ff ca             	dec    %rdx
    9292:	89 fe                	mov    %edi,%esi
    9294:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    929b:	00 00 00 00 00 
    92a0:	0f b6 3a             	movzbl (%rdx),%edi
    92a3:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    92a8:	48 ff c1             	inc    %rcx
    92ab:	48 ff ca             	dec    %rdx
    92ae:	48 39 ce             	cmp    %rcx,%rsi
    92b1:	75 ed                	jne    92a0 <fwp_write+0x1390>
    92b3:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    92b8:	e9 7b fe ff ff       	jmp    9138 <fwp_write+0x1228>
    92bd:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    92c2:	4c 89 f7             	mov    %r14,%rdi
    92c5:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    92cb:	be 09 00 00 00       	mov    $0x9,%esi
    92d0:	e8 7b 0d 00 00       	call   a050 <fwp_format_g>
    92d5:	4c 89 f7             	mov    %r14,%rdi
    92d8:	e9 bf f8 ff ff       	jmp    8b9c <fwp_write+0xc8c>
    92dd:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    92e4:	00 
    92e5:	e9 4e fe ff ff       	jmp    9138 <fwp_write+0x1228>
    92ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000092f0 <buf_put>:
    92f0:	41 57                	push   %r15
    92f2:	41 56                	push   %r14
    92f4:	41 54                	push   %r12
    92f6:	53                   	push   %rbx
    92f7:	50                   	push   %rax
    92f8:	49 89 fe             	mov    %rdi,%r14
    92fb:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    92ff:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    9303:	0f 84 a2 00 00 00    	je     93ab <buf_put+0xbb>
    9309:	48 89 d3             	mov    %rdx,%rbx
    930c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    9313:	48 29 f8             	sub    %rdi,%rax
    9316:	48 39 d0             	cmp    %rdx,%rax
    9319:	0f 82 8c 00 00 00    	jb     93ab <buf_put+0xbb>
    931f:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    9323:	48 ff c0             	inc    %rax
    9326:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    932a:	48 39 c8             	cmp    %rcx,%rax
    932d:	76 30                	jbe    935f <buf_put+0x6f>
    932f:	48 85 c9             	test   %rcx,%rcx
    9332:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    9338:	4c 0f 45 f9          	cmovne %rcx,%r15
    933c:	49 89 f4             	mov    %rsi,%r12
    933f:	49 39 c7             	cmp    %rax,%r15
    9342:	73 23                	jae    9367 <buf_put+0x77>
    9344:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    934b:	00 00 00 00 00 
    9350:	4d 85 ff             	test   %r15,%r15
    9353:	78 0f                	js     9364 <buf_put+0x74>
    9355:	4d 01 ff             	add    %r15,%r15
    9358:	49 39 c7             	cmp    %rax,%r15
    935b:	72 f3                	jb     9350 <buf_put+0x60>
    935d:	eb 08                	jmp    9367 <buf_put+0x77>
    935f:	49 8b 06             	mov    (%r14),%rax
    9362:	eb 21                	jmp    9385 <buf_put+0x95>
    9364:	49 89 c7             	mov    %rax,%r15
    9367:	49 8b 3e             	mov    (%r14),%rdi
    936a:	4c 89 fe             	mov    %r15,%rsi
    936d:	e8 be 92 ff ff       	call   2630 <realloc>
    9372:	48 85 c0             	test   %rax,%rax
    9375:	74 34                	je     93ab <buf_put+0xbb>
    9377:	49 89 06             	mov    %rax,(%r14)
    937a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    937e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9382:	4c 89 e6             	mov    %r12,%rsi
    9385:	48 01 c7             	add    %rax,%rdi
    9388:	48 89 da             	mov    %rbx,%rdx
    938b:	e8 40 8e ff ff       	call   21d0 <memcpy@plt>
    9390:	49 03 5e 08          	add    0x8(%r14),%rbx
    9394:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    9398:	49 8b 06             	mov    (%r14),%rax
    939b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    939f:	48 83 c4 08          	add    $0x8,%rsp
    93a3:	5b                   	pop    %rbx
    93a4:	41 5c                	pop    %r12
    93a6:	41 5e                	pop    %r14
    93a8:	41 5f                	pop    %r15
    93aa:	c3                   	ret
    93ab:	48 8b 05 2e 9c 00 00 	mov    0x9c2e(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    93b2:	48 8b 08             	mov    (%rax),%rcx
    93b5:	48 8d 3d 1d 62 00 00 	lea    0x621d(%rip),%rdi        # f5d9 <fwp_segv.msg+0x359>
    93bc:	be 13 00 00 00       	mov    $0x13,%esi
    93c1:	ba 01 00 00 00       	mov    $0x1,%edx
    93c6:	e8 b5 8e ff ff       	call   2280 <fwrite@plt>
    93cb:	bf 66 00 00 00       	mov    $0x66,%edi
    93d0:	e8 9b 8e ff ff       	call   2270 <exit@plt>
    93d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    93dc:	00 00 00 00 

00000000000093e0 <fwp_escape>:
    93e0:	55                   	push   %rbp
    93e1:	41 57                	push   %r15
    93e3:	41 56                	push   %r14
    93e5:	41 55                	push   %r13
    93e7:	41 54                	push   %r12
    93e9:	53                   	push   %rbx
    93ea:	48 83 ec 18          	sub    $0x18,%rsp
    93ee:	49 89 d6             	mov    %rdx,%r14
    93f1:	49 89 f7             	mov    %rsi,%r15
    93f4:	48 89 fb             	mov    %rdi,%rbx
    93f7:	c6 04 24 22          	movb   $0x22,(%rsp)
    93fb:	48 89 e6             	mov    %rsp,%rsi
    93fe:	ba 01 00 00 00       	mov    $0x1,%edx
    9403:	e8 e8 fe ff ff       	call   92f0 <buf_put>
    9408:	4d 85 f6             	test   %r14,%r14
    940b:	0f 84 de 00 00 00    	je     94ef <fwp_escape+0x10f>
    9411:	48 89 e5             	mov    %rsp,%rbp
    9414:	4c 8d 2d b1 5d 00 00 	lea    0x5db1(%rip),%r13        # f1cc <_IO_stdin_used+0x1cc>
    941b:	45 31 e4             	xor    %r12d,%r12d
    941e:	eb 21                	jmp    9441 <fwp_escape+0x61>
    9420:	ba 02 00 00 00       	mov    $0x2,%edx
    9425:	48 89 df             	mov    %rbx,%rdi
    9428:	48 8d 35 e8 62 00 00 	lea    0x62e8(%rip),%rsi        # f717 <fwp_segv.msg+0x497>
    942f:	90                   	nop
    9430:	e8 bb fe ff ff       	call   92f0 <buf_put>
    9435:	49 ff c4             	inc    %r12
    9438:	4d 39 e6             	cmp    %r12,%r14
    943b:	0f 84 ae 00 00 00    	je     94ef <fwp_escape+0x10f>
    9441:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    9446:	0f b6 c8             	movzbl %al,%ecx
    9449:	8d 51 f7             	lea    -0x9(%rcx),%edx
    944c:	83 fa 19             	cmp    $0x19,%edx
    944f:	77 1f                	ja     9470 <fwp_escape+0x90>
    9451:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    9456:	4c 01 ea             	add    %r13,%rdx
    9459:	ff e2                	jmp    *%rdx
    945b:	ba 02 00 00 00       	mov    $0x2,%edx
    9460:	48 89 df             	mov    %rbx,%rdi
    9463:	48 8d 35 aa 62 00 00 	lea    0x62aa(%rip),%rsi        # f714 <fwp_segv.msg+0x494>
    946a:	eb c4                	jmp    9430 <fwp_escape+0x50>
    946c:	0f 1f 40 00          	nopl   0x0(%rax)
    9470:	83 f9 5c             	cmp    $0x5c,%ecx
    9473:	75 11                	jne    9486 <fwp_escape+0xa6>
    9475:	ba 02 00 00 00       	mov    $0x2,%edx
    947a:	48 89 df             	mov    %rbx,%rdi
    947d:	48 8d 35 8a 62 00 00 	lea    0x628a(%rip),%rsi        # f70e <fwp_segv.msg+0x48e>
    9484:	eb aa                	jmp    9430 <fwp_escape+0x50>
    9486:	3c 20                	cmp    $0x20,%al
    9488:	72 39                	jb     94c3 <fwp_escape+0xe3>
    948a:	3c 7f                	cmp    $0x7f,%al
    948c:	74 35                	je     94c3 <fwp_escape+0xe3>
    948e:	88 04 24             	mov    %al,(%rsp)
    9491:	ba 01 00 00 00       	mov    $0x1,%edx
    9496:	48 89 df             	mov    %rbx,%rdi
    9499:	48 89 ee             	mov    %rbp,%rsi
    949c:	eb 92                	jmp    9430 <fwp_escape+0x50>
    949e:	ba 02 00 00 00       	mov    $0x2,%edx
    94a3:	48 89 df             	mov    %rbx,%rdi
    94a6:	48 8d 35 5e 62 00 00 	lea    0x625e(%rip),%rsi        # f70b <fwp_segv.msg+0x48b>
    94ad:	eb 81                	jmp    9430 <fwp_escape+0x50>
    94af:	ba 02 00 00 00       	mov    $0x2,%edx
    94b4:	48 89 df             	mov    %rbx,%rdi
    94b7:	48 8d 35 53 62 00 00 	lea    0x6253(%rip),%rsi        # f711 <fwp_segv.msg+0x491>
    94be:	e9 6d ff ff ff       	jmp    9430 <fwp_escape+0x50>
    94c3:	be 10 00 00 00       	mov    $0x10,%esi
    94c8:	48 89 ef             	mov    %rbp,%rdi
    94cb:	48 8d 15 48 62 00 00 	lea    0x6248(%rip),%rdx        # f71a <fwp_segv.msg+0x49a>
    94d2:	31 c0                	xor    %eax,%eax
    94d4:	e8 27 8c ff ff       	call   2100 <snprintf@plt>
    94d9:	48 89 ef             	mov    %rbp,%rdi
    94dc:	e8 ef 8b ff ff       	call   20d0 <strlen@plt>
    94e1:	48 89 df             	mov    %rbx,%rdi
    94e4:	48 89 ee             	mov    %rbp,%rsi
    94e7:	48 89 c2             	mov    %rax,%rdx
    94ea:	e9 41 ff ff ff       	jmp    9430 <fwp_escape+0x50>
    94ef:	c6 04 24 22          	movb   $0x22,(%rsp)
    94f3:	48 89 e6             	mov    %rsp,%rsi
    94f6:	ba 01 00 00 00       	mov    $0x1,%edx
    94fb:	48 89 df             	mov    %rbx,%rdi
    94fe:	e8 ed fd ff ff       	call   92f0 <buf_put>
    9503:	48 83 c4 18          	add    $0x18,%rsp
    9507:	5b                   	pop    %rbx
    9508:	41 5c                	pop    %r12
    950a:	41 5d                	pop    %r13
    950c:	41 5e                	pop    %r14
    950e:	41 5f                	pop    %r15
    9510:	5d                   	pop    %rbp
    9511:	c3                   	ret
    9512:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9519:	1f 84 00 00 00 00 00 

0000000000009520 <fwp_fmt_duration>:
    9520:	41 57                	push   %r15
    9522:	41 56                	push   %r14
    9524:	41 54                	push   %r12
    9526:	53                   	push   %rbx
    9527:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    952e:	48 89 f0             	mov    %rsi,%rax
    9531:	48 09 d0             	or     %rdx,%rax
    9534:	0f 84 bf 02 00 00    	je     97f9 <fwp_fmt_duration+0x2d9>
    953a:	49 89 d0             	mov    %rdx,%r8
    953d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    9544:	e1 2f 0d 
    9547:	48 0f af ce          	imul   %rsi,%rcx
    954b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    9552:	27 c5 01 
    9555:	48 89 f0             	mov    %rsi,%rax
    9558:	49 f7 e1             	mul    %r9
    955b:	48 01 ca             	add    %rcx,%rdx
    955e:	4d 0f af c8          	imul   %r8,%r9
    9562:	49 01 d1             	add    %rdx,%r9
    9565:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    956c:	6a af 6b 
    956f:	48 01 c1             	add    %rax,%rcx
    9572:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    9579:	00 00 00 
    957c:	4c 11 c8             	adc    %r9,%rax
    957f:	48 89 c2             	mov    %rax,%rdx
    9582:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    9587:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    958c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    9593:	ba 76 93 
    9596:	48 39 c1             	cmp    %rax,%rcx
    9599:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    959e:	48 19 d0             	sbb    %rdx,%rax
    95a1:	0f 83 70 02 00 00    	jae    9817 <fwp_fmt_duration+0x2f7>
    95a7:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    95ae:	3b ce c5 
    95b1:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    95b8:	52 8d 1a 
    95bb:	48 89 f0             	mov    %rsi,%rax
    95be:	49 f7 e1             	mul    %r9
    95c1:	48 0f af ce          	imul   %rsi,%rcx
    95c5:	48 01 ca             	add    %rcx,%rdx
    95c8:	4d 0f af c8          	imul   %r8,%r9
    95cc:	49 01 d1             	add    %rdx,%r9
    95cf:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    95d6:	3f 47 4f 
    95d9:	48 01 c1             	add    %rax,%rcx
    95dc:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    95e3:	00 00 00 
    95e6:	4c 11 c8             	adc    %r9,%rax
    95e9:	48 89 c2             	mov    %rax,%rdx
    95ec:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    95f1:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    95f6:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    95fd:	d1 d3 8f 
    9600:	48 39 c8             	cmp    %rcx,%rax
    9603:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    960a:	0f 82 27 02 00 00    	jb     9837 <fwp_fmt_duration+0x317>
    9610:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    9617:	7d 15 97 
    961a:	48 0f af ce          	imul   %rsi,%rcx
    961e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    9625:	ce 47 8e 
    9628:	48 89 f0             	mov    %rsi,%rax
    962b:	49 f7 e1             	mul    %r9
    962e:	48 01 ca             	add    %rcx,%rdx
    9631:	4d 0f af c8          	imul   %r8,%r9
    9635:	49 01 d1             	add    %rdx,%r9
    9638:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    963f:	b9 2c a5 
    9642:	48 01 c1             	add    %rax,%rcx
    9645:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    964c:	04 00 00 
    964f:	4c 11 c8             	adc    %r9,%rax
    9652:	48 89 c2             	mov    %rax,%rdx
    9655:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    965a:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    965f:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    9666:	2c a5 b5 
    9669:	48 39 c8             	cmp    %rcx,%rax
    966c:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    9673:	00 00 00 
    9676:	48 19 c2             	sbb    %rax,%rdx
    9679:	0f 82 0d 03 00 00    	jb     998c <fwp_fmt_duration+0x46c>
    967f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    9686:	23 7e c5 
    9689:	48 0f af ce          	imul   %rsi,%rcx
    968d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    9694:	b6 0f 79 
    9697:	48 89 f0             	mov    %rsi,%rax
    969a:	49 f7 e1             	mul    %r9
    969d:	48 01 ca             	add    %rcx,%rdx
    96a0:	4d 0f af c8          	imul   %r8,%r9
    96a4:	49 01 d1             	add    %rdx,%r9
    96a7:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    96ae:	98 d6 a6 
    96b1:	48 01 c1             	add    %rax,%rcx
    96b4:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    96bb:	18 02 00 
    96be:	4c 11 c8             	adc    %r9,%rax
    96c1:	48 89 c2             	mov    %rax,%rdx
    96c4:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    96c9:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    96ce:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    96d5:	b4 36 8d 
    96d8:	48 39 c8             	cmp    %rcx,%rax
    96db:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    96e2:	10 00 00 
    96e5:	48 19 c2             	sbb    %rax,%rdx
    96e8:	0f 82 ad 02 00 00    	jb     999b <fwp_fmt_duration+0x47b>
    96ee:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    96f5:	8d 97 6e 
    96f8:	48 0f af ce          	imul   %rsi,%rcx
    96fc:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    9703:	08 ac 1c 
    9706:	48 89 f0             	mov    %rsi,%rax
    9709:	49 f7 e1             	mul    %r9
    970c:	48 01 ca             	add    %rcx,%rdx
    970f:	4d 0f af c8          	imul   %r8,%r9
    9713:	49 01 d1             	add    %rdx,%r9
    9716:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    971d:	b4 c8 76 
    9720:	48 01 c1             	add    %rax,%rcx
    9723:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    972a:	24 06 01 
    972d:	4c 11 c8             	adc    %r9,%rax
    9730:	48 89 c2             	mov    %rax,%rdx
    9733:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    9738:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    973d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    9744:	2d b2 9d 
    9747:	48 39 c8             	cmp    %rcx,%rax
    974a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    9751:	89 41 00 
    9754:	48 19 c2             	sbb    %rax,%rdx
    9757:	0f 82 4d 02 00 00    	jb     99aa <fwp_fmt_duration+0x48a>
    975d:	4d 85 c0             	test   %r8,%r8
    9760:	0f 88 d6 06 00 00    	js     9e3c <fwp_fmt_duration+0x91c>
    9766:	45 31 d2             	xor    %r10d,%r10d
    9769:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9770:	cc cc cc 
    9773:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    977a:	cc cc cc 
    977d:	4d 89 c6             	mov    %r8,%r14
    9780:	4c 89 c1             	mov    %r8,%rcx
    9783:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9788:	49 d1 ee             	shr    $1,%r14
    978b:	49 89 c9             	mov    %rcx,%r9
    978e:	4d 01 f1             	add    %r14,%r9
    9791:	49 83 d1 00          	adc    $0x0,%r9
    9795:	4c 89 c8             	mov    %r9,%rax
    9798:	49 f7 e3             	mul    %r11
    979b:	48 c1 ea 02          	shr    $0x2,%rdx
    979f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    97a3:	49 29 c1             	sub    %rax,%r9
    97a6:	4c 29 c9             	sub    %r9,%rcx
    97a9:	49 83 de 00          	sbb    $0x0,%r14
    97ad:	49 89 c9             	mov    %rcx,%r9
    97b0:	4c 0f af cb          	imul   %rbx,%r9
    97b4:	48 89 c8             	mov    %rcx,%rax
    97b7:	49 f7 e3             	mul    %r11
    97ba:	4c 01 ca             	add    %r9,%rdx
    97bd:	4d 0f af f3          	imul   %r11,%r14
    97c1:	49 01 d6             	add    %rdx,%r14
    97c4:	48 89 c1             	mov    %rax,%rcx
    97c7:	48 01 c1             	add    %rax,%rcx
    97ca:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    97ce:	89 f2                	mov    %esi,%edx
    97d0:	29 ca                	sub    %ecx,%edx
    97d2:	80 ca 30             	or     $0x30,%dl
    97d5:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    97da:	49 ff c2             	inc    %r10
    97dd:	48 83 fe 0a          	cmp    $0xa,%rsi
    97e1:	49 83 d8 00          	sbb    $0x0,%r8
    97e5:	48 89 c6             	mov    %rax,%rsi
    97e8:	4d 89 f0             	mov    %r14,%r8
    97eb:	73 93                	jae    9780 <fwp_fmt_duration+0x260>
    97ed:	45 85 d2             	test   %r10d,%r10d
    97f0:	7f 12                	jg     9804 <fwp_fmt_duration+0x2e4>
    97f2:	31 c0                	xor    %eax,%eax
    97f4:	e9 79 01 00 00       	jmp    9972 <fwp_fmt_duration+0x452>
    97f9:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    97fe:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9804:	44 89 d0             	mov    %r10d,%eax
    9807:	48 83 f8 08          	cmp    $0x8,%rax
    980b:	73 1e                	jae    982b <fwp_fmt_duration+0x30b>
    980d:	31 c9                	xor    %ecx,%ecx
    980f:	48 89 c2             	mov    %rax,%rdx
    9812:	e9 3d 01 00 00       	jmp    9954 <fwp_fmt_duration+0x434>
    9817:	49 89 fe             	mov    %rdi,%r14
    981a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    9821:	03 00 00 
    9824:	31 c0                	xor    %eax,%eax
    9826:	e9 8c 01 00 00       	jmp    99b7 <fwp_fmt_duration+0x497>
    982b:	83 f8 20             	cmp    $0x20,%eax
    982e:	73 1e                	jae    984e <fwp_fmt_duration+0x32e>
    9830:	31 c9                	xor    %ecx,%ecx
    9832:	e9 c3 00 00 00       	jmp    98fa <fwp_fmt_duration+0x3da>
    9837:	49 89 fe             	mov    %rdi,%r14
    983a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    9841:	00 00 00 
    9844:	b8 01 00 00 00       	mov    $0x1,%eax
    9849:	e9 69 01 00 00       	jmp    99b7 <fwp_fmt_duration+0x497>
    984e:	44 89 d2             	mov    %r10d,%edx
    9851:	83 e2 1f             	and    $0x1f,%edx
    9854:	48 89 c1             	mov    %rax,%rcx
    9857:	48 29 d1             	sub    %rdx,%rcx
    985a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    985f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9863:	49 89 c0             	mov    %rax,%r8
    9866:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    986d:	00 00 00 
    9870:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9877:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    987e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9882:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9886:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    988b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9890:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9895:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9899:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    989e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    98a3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    98a8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    98ac:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    98b0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    98b4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    98b9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    98be:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    98c3:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    98c7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    98cc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    98d1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    98d6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    98da:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    98df:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    98e3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    98e7:	48 83 c6 20          	add    $0x20,%rsi
    98eb:	4c 39 c2             	cmp    %r8,%rdx
    98ee:	75 80                	jne    9870 <fwp_fmt_duration+0x350>
    98f0:	48 85 d2             	test   %rdx,%rdx
    98f3:	74 7d                	je     9972 <fwp_fmt_duration+0x452>
    98f5:	83 fa 08             	cmp    $0x8,%edx
    98f8:	72 5a                	jb     9954 <fwp_fmt_duration+0x434>
    98fa:	44 89 d2             	mov    %r10d,%edx
    98fd:	83 e2 07             	and    $0x7,%edx
    9900:	48 89 c6             	mov    %rax,%rsi
    9903:	48 29 ce             	sub    %rcx,%rsi
    9906:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    990a:	48 89 c1             	mov    %rax,%rcx
    990d:	48 29 d1             	sub    %rdx,%rcx
    9910:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9914:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    991b:	00 00 00 00 00 
    9920:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    9926:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    992a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    992f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9934:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9939:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    993d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9942:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9946:	49 83 c0 08          	add    $0x8,%r8
    994a:	48 39 f2             	cmp    %rsi,%rdx
    994d:	75 d1                	jne    9920 <fwp_fmt_duration+0x400>
    994f:	48 85 d2             	test   %rdx,%rdx
    9952:	74 1e                	je     9972 <fwp_fmt_duration+0x452>
    9954:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9959:	48 01 f2             	add    %rsi,%rdx
    995c:	48 ff ca             	dec    %rdx
    995f:	90                   	nop
    9960:	0f b6 32             	movzbl (%rdx),%esi
    9963:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9967:	48 ff c1             	inc    %rcx
    996a:	48 ff ca             	dec    %rdx
    996d:	48 39 c8             	cmp    %rcx,%rax
    9970:	75 ee                	jne    9960 <fwp_fmt_duration+0x440>
    9972:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9976:	48 8d 35 b0 5d 00 00 	lea    0x5db0(%rip),%rsi        # f72d <fwp_segv.msg+0x4ad>
    997d:	48 89 e2             	mov    %rsp,%rdx
    9980:	31 c0                	xor    %eax,%eax
    9982:	e8 d9 88 ff ff       	call   2260 <sprintf@plt>
    9987:	e9 a1 04 00 00       	jmp    9e2d <fwp_fmt_duration+0x90d>
    998c:	49 89 fe             	mov    %rdi,%r14
    998f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9994:	b8 02 00 00 00       	mov    $0x2,%eax
    9999:	eb 1c                	jmp    99b7 <fwp_fmt_duration+0x497>
    999b:	49 89 fe             	mov    %rdi,%r14
    999e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    99a3:	b8 03 00 00 00       	mov    $0x3,%eax
    99a8:	eb 0d                	jmp    99b7 <fwp_fmt_duration+0x497>
    99aa:	49 89 fe             	mov    %rdi,%r14
    99ad:	ba e8 03 00 00       	mov    $0x3e8,%edx
    99b2:	b8 04 00 00 00       	mov    $0x4,%eax
    99b7:	31 c9                	xor    %ecx,%ecx
    99b9:	c1 e0 04             	shl    $0x4,%eax
    99bc:	48 8d 1d ad 93 00 00 	lea    0x93ad(%rip),%rbx        # 12d70 <fwp_fmt_duration.units>
    99c3:	48 01 c3             	add    %rax,%rbx
    99c6:	48 89 f7             	mov    %rsi,%rdi
    99c9:	4c 89 c6             	mov    %r8,%rsi
    99cc:	e8 bf 50 00 00       	call   ea90 <__divti3>
    99d1:	48 89 c1             	mov    %rax,%rcx
    99d4:	48 89 d6             	mov    %rdx,%rsi
    99d7:	48 85 d2             	test   %rdx,%rdx
    99da:	0f 88 b0 00 00 00    	js     9a90 <fwp_fmt_duration+0x570>
    99e0:	48 89 c8             	mov    %rcx,%rax
    99e3:	48 09 f0             	or     %rsi,%rax
    99e6:	0f 84 61 01 00 00    	je     9b4d <fwp_fmt_duration+0x62d>
    99ec:	45 31 d2             	xor    %r10d,%r10d
    99ef:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    99f6:	cc cc cc 
    99f9:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    9a00:	cc cc cc 
    9a03:	49 89 f4             	mov    %rsi,%r12
    9a06:	4c 89 f7             	mov    %r14,%rdi
    9a09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9a10:	49 89 f0             	mov    %rsi,%r8
    9a13:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    9a18:	49 d1 ec             	shr    $1,%r12
    9a1b:	4d 89 c1             	mov    %r8,%r9
    9a1e:	4d 01 e1             	add    %r12,%r9
    9a21:	49 83 d1 00          	adc    $0x0,%r9
    9a25:	4c 89 c8             	mov    %r9,%rax
    9a28:	49 f7 e3             	mul    %r11
    9a2b:	48 c1 ea 02          	shr    $0x2,%rdx
    9a2f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9a33:	49 29 c1             	sub    %rax,%r9
    9a36:	4d 29 c8             	sub    %r9,%r8
    9a39:	49 83 dc 00          	sbb    $0x0,%r12
    9a3d:	4d 89 c1             	mov    %r8,%r9
    9a40:	4d 0f af cf          	imul   %r15,%r9
    9a44:	4c 89 c0             	mov    %r8,%rax
    9a47:	49 f7 e3             	mul    %r11
    9a4a:	4c 01 ca             	add    %r9,%rdx
    9a4d:	4d 0f af e3          	imul   %r11,%r12
    9a51:	49 01 d4             	add    %rdx,%r12
    9a54:	48 89 c2             	mov    %rax,%rdx
    9a57:	48 01 c2             	add    %rax,%rdx
    9a5a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    9a5e:	41 89 c8             	mov    %ecx,%r8d
    9a61:	41 29 d0             	sub    %edx,%r8d
    9a64:	41 80 c8 30          	or     $0x30,%r8b
    9a68:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    9a6d:	49 ff c2             	inc    %r10
    9a70:	48 83 f9 0a          	cmp    $0xa,%rcx
    9a74:	48 83 de 00          	sbb    $0x0,%rsi
    9a78:	48 89 c1             	mov    %rax,%rcx
    9a7b:	4c 89 e6             	mov    %r12,%rsi
    9a7e:	73 90                	jae    9a10 <fwp_fmt_duration+0x4f0>
    9a80:	45 85 d2             	test   %r10d,%r10d
    9a83:	0f 8f d2 00 00 00    	jg     9b5b <fwp_fmt_duration+0x63b>
    9a89:	31 c0                	xor    %eax,%eax
    9a8b:	e9 12 02 00 00       	jmp    9ca2 <fwp_fmt_duration+0x782>
    9a90:	45 31 c0             	xor    %r8d,%r8d
    9a93:	48 f7 d9             	neg    %rcx
    9a96:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    9a9c:	49 19 f1             	sbb    %rsi,%r9
    9a9f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9aa3:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    9aaa:	cc cc cc 
    9aad:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9ab4:	cc cc cc 
    9ab7:	4d 89 cf             	mov    %r9,%r15
    9aba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9ac0:	4c 89 ce             	mov    %r9,%rsi
    9ac3:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9ac8:	49 d1 ef             	shr    $1,%r15
    9acb:	48 89 f7             	mov    %rsi,%rdi
    9ace:	4c 01 ff             	add    %r15,%rdi
    9ad1:	48 83 d7 00          	adc    $0x0,%rdi
    9ad5:	48 89 f8             	mov    %rdi,%rax
    9ad8:	49 f7 e2             	mul    %r10
    9adb:	48 c1 ea 02          	shr    $0x2,%rdx
    9adf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9ae3:	48 29 c7             	sub    %rax,%rdi
    9ae6:	48 29 fe             	sub    %rdi,%rsi
    9ae9:	49 83 df 00          	sbb    $0x0,%r15
    9aed:	48 89 f7             	mov    %rsi,%rdi
    9af0:	49 0f af fb          	imul   %r11,%rdi
    9af4:	48 89 f0             	mov    %rsi,%rax
    9af7:	49 f7 e2             	mul    %r10
    9afa:	48 01 fa             	add    %rdi,%rdx
    9afd:	4d 0f af fa          	imul   %r10,%r15
    9b01:	49 01 d7             	add    %rdx,%r15
    9b04:	48 89 c2             	mov    %rax,%rdx
    9b07:	48 01 c2             	add    %rax,%rdx
    9b0a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    9b0e:	89 ce                	mov    %ecx,%esi
    9b10:	29 d6                	sub    %edx,%esi
    9b12:	40 80 ce 30          	or     $0x30,%sil
    9b16:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    9b1b:	49 ff c0             	inc    %r8
    9b1e:	48 83 f9 0a          	cmp    $0xa,%rcx
    9b22:	49 83 d9 00          	sbb    $0x0,%r9
    9b26:	48 89 c1             	mov    %rax,%rcx
    9b29:	4d 89 f9             	mov    %r15,%r9
    9b2c:	73 92                	jae    9ac0 <fwp_fmt_duration+0x5a0>
    9b2e:	45 85 c0             	test   %r8d,%r8d
    9b31:	4c 89 f7             	mov    %r14,%rdi
    9b34:	7e 44                	jle    9b7a <fwp_fmt_duration+0x65a>
    9b36:	44 89 c0             	mov    %r8d,%eax
    9b39:	48 83 f8 08          	cmp    $0x8,%rax
    9b3d:	0f 83 68 01 00 00    	jae    9cab <fwp_fmt_duration+0x78b>
    9b43:	31 c9                	xor    %ecx,%ecx
    9b45:	48 89 c2             	mov    %rax,%rdx
    9b48:	e9 97 02 00 00       	jmp    9de4 <fwp_fmt_duration+0x8c4>
    9b4d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    9b52:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9b58:	4c 89 f7             	mov    %r14,%rdi
    9b5b:	44 89 d0             	mov    %r10d,%eax
    9b5e:	48 83 f8 08          	cmp    $0x8,%rax
    9b62:	73 0a                	jae    9b6e <fwp_fmt_duration+0x64e>
    9b64:	31 c9                	xor    %ecx,%ecx
    9b66:	48 89 c2             	mov    %rax,%rdx
    9b69:	e9 16 01 00 00       	jmp    9c84 <fwp_fmt_duration+0x764>
    9b6e:	83 f8 20             	cmp    $0x20,%eax
    9b71:	73 0e                	jae    9b81 <fwp_fmt_duration+0x661>
    9b73:	31 c9                	xor    %ecx,%ecx
    9b75:	e9 b0 00 00 00       	jmp    9c2a <fwp_fmt_duration+0x70a>
    9b7a:	31 c0                	xor    %eax,%eax
    9b7c:	e9 93 02 00 00       	jmp    9e14 <fwp_fmt_duration+0x8f4>
    9b81:	44 89 d2             	mov    %r10d,%edx
    9b84:	83 e2 1f             	and    $0x1f,%edx
    9b87:	48 89 c1             	mov    %rax,%rcx
    9b8a:	48 29 d1             	sub    %rdx,%rcx
    9b8d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9b92:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9b96:	49 89 c0             	mov    %rax,%r8
    9b99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9ba0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9ba7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    9bae:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9bb2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9bb6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9bbb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9bc0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9bc5:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9bc9:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9bce:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9bd3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9bd8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9bdc:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9be0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9be4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9be9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9bee:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9bf3:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9bf7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9bfc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9c01:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9c06:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9c0a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    9c0f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9c13:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9c17:	48 83 c6 20          	add    $0x20,%rsi
    9c1b:	4c 39 c2             	cmp    %r8,%rdx
    9c1e:	75 80                	jne    9ba0 <fwp_fmt_duration+0x680>
    9c20:	48 85 d2             	test   %rdx,%rdx
    9c23:	74 7d                	je     9ca2 <fwp_fmt_duration+0x782>
    9c25:	83 fa 08             	cmp    $0x8,%edx
    9c28:	72 5a                	jb     9c84 <fwp_fmt_duration+0x764>
    9c2a:	44 89 d2             	mov    %r10d,%edx
    9c2d:	83 e2 07             	and    $0x7,%edx
    9c30:	48 89 c6             	mov    %rax,%rsi
    9c33:	48 29 ce             	sub    %rcx,%rsi
    9c36:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    9c3a:	48 89 c1             	mov    %rax,%rcx
    9c3d:	48 29 d1             	sub    %rdx,%rcx
    9c40:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9c44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9c4b:	00 00 00 00 00 
    9c50:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    9c56:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9c5a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9c5f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9c64:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9c69:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9c6d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9c72:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9c76:	49 83 c0 08          	add    $0x8,%r8
    9c7a:	48 39 f2             	cmp    %rsi,%rdx
    9c7d:	75 d1                	jne    9c50 <fwp_fmt_duration+0x730>
    9c7f:	48 85 d2             	test   %rdx,%rdx
    9c82:	74 1e                	je     9ca2 <fwp_fmt_duration+0x782>
    9c84:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9c89:	48 01 f2             	add    %rsi,%rdx
    9c8c:	48 ff ca             	dec    %rdx
    9c8f:	90                   	nop
    9c90:	0f b6 32             	movzbl (%rdx),%esi
    9c93:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9c97:	48 ff c1             	inc    %rcx
    9c9a:	48 ff ca             	dec    %rdx
    9c9d:	48 39 c8             	cmp    %rcx,%rax
    9ca0:	75 ee                	jne    9c90 <fwp_fmt_duration+0x770>
    9ca2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9ca6:	e9 6e 01 00 00       	jmp    9e19 <fwp_fmt_duration+0x8f9>
    9cab:	83 f8 20             	cmp    $0x20,%eax
    9cae:	73 07                	jae    9cb7 <fwp_fmt_duration+0x797>
    9cb0:	31 c9                	xor    %ecx,%ecx
    9cb2:	e9 bd 00 00 00       	jmp    9d74 <fwp_fmt_duration+0x854>
    9cb7:	44 89 c6             	mov    %r8d,%esi
    9cba:	44 89 c2             	mov    %r8d,%edx
    9cbd:	83 e2 1f             	and    $0x1f,%edx
    9cc0:	48 89 c1             	mov    %rax,%rcx
    9cc3:	48 29 d1             	sub    %rdx,%rcx
    9cc6:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    9cca:	49 83 c1 30          	add    $0x30,%r9
    9cce:	48 29 d6             	sub    %rdx,%rsi
    9cd1:	45 31 d2             	xor    %r10d,%r10d
    9cd4:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9cd8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9cdf:	00 
    9ce0:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9ce6:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    9ceb:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9cef:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9cf3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9cf8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9cfd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9d02:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9d06:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9d0b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9d10:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9d15:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9d19:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9d1d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9d21:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9d26:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9d2b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9d30:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9d34:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9d39:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9d3e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9d43:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9d47:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9d4e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    9d55:	49 83 c2 20          	add    $0x20,%r10
    9d59:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    9d5d:	4c 39 d6             	cmp    %r10,%rsi
    9d60:	0f 85 7a ff ff ff    	jne    9ce0 <fwp_fmt_duration+0x7c0>
    9d66:	48 85 d2             	test   %rdx,%rdx
    9d69:	0f 84 a5 00 00 00    	je     9e14 <fwp_fmt_duration+0x8f4>
    9d6f:	83 fa 08             	cmp    $0x8,%edx
    9d72:	72 70                	jb     9de4 <fwp_fmt_duration+0x8c4>
    9d74:	48 89 ce             	mov    %rcx,%rsi
    9d77:	45 89 c1             	mov    %r8d,%r9d
    9d7a:	44 89 c2             	mov    %r8d,%edx
    9d7d:	83 e2 07             	and    $0x7,%edx
    9d80:	48 89 c1             	mov    %rax,%rcx
    9d83:	48 29 d1             	sub    %rdx,%rcx
    9d86:	49 89 f2             	mov    %rsi,%r10
    9d89:	49 f7 da             	neg    %r10
    9d8c:	49 01 e2             	add    %rsp,%r10
    9d8f:	49 83 c2 40          	add    $0x40,%r10
    9d93:	4d 01 ca             	add    %r9,%r10
    9d96:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9d9a:	49 29 d1             	sub    %rdx,%r9
    9d9d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9da1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9da8:	0f 1f 84 00 00 00 00 
    9daf:	00 
    9db0:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9db5:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9db9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9dbe:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9dc3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9dc8:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9dcc:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9dd2:	48 83 c6 08          	add    $0x8,%rsi
    9dd6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9dda:	49 39 f1             	cmp    %rsi,%r9
    9ddd:	75 d1                	jne    9db0 <fwp_fmt_duration+0x890>
    9ddf:	48 85 d2             	test   %rdx,%rdx
    9de2:	74 30                	je     9e14 <fwp_fmt_duration+0x8f4>
    9de4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9de9:	48 01 f2             	add    %rsi,%rdx
    9dec:	48 ff ca             	dec    %rdx
    9def:	44 89 c6             	mov    %r8d,%esi
    9df2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9df9:	1f 84 00 00 00 00 00 
    9e00:	44 0f b6 02          	movzbl (%rdx),%r8d
    9e04:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9e09:	48 ff c1             	inc    %rcx
    9e0c:	48 ff ca             	dec    %rdx
    9e0f:	48 39 ce             	cmp    %rcx,%rsi
    9e12:	75 ec                	jne    9e00 <fwp_fmt_duration+0x8e0>
    9e14:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9e19:	48 8b 0b             	mov    (%rbx),%rcx
    9e1c:	48 8d 35 05 59 00 00 	lea    0x5905(%rip),%rsi        # f728 <fwp_segv.msg+0x4a8>
    9e23:	48 89 e2             	mov    %rsp,%rdx
    9e26:	31 c0                	xor    %eax,%eax
    9e28:	e8 33 84 ff ff       	call   2260 <sprintf@plt>
    9e2d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    9e34:	5b                   	pop    %rbx
    9e35:	41 5c                	pop    %r12
    9e37:	41 5e                	pop    %r14
    9e39:	41 5f                	pop    %r15
    9e3b:	c3                   	ret
    9e3c:	45 31 c9             	xor    %r9d,%r9d
    9e3f:	48 f7 de             	neg    %rsi
    9e42:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    9e48:	4d 19 c2             	sbb    %r8,%r10
    9e4b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9e4f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9e56:	cc cc cc 
    9e59:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    9e60:	cc cc cc 
    9e63:	4d 89 d6             	mov    %r10,%r14
    9e66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9e6d:	00 00 00 
    9e70:	4c 89 d1             	mov    %r10,%rcx
    9e73:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9e78:	49 d1 ee             	shr    $1,%r14
    9e7b:	49 89 c8             	mov    %rcx,%r8
    9e7e:	4d 01 f0             	add    %r14,%r8
    9e81:	49 83 d0 00          	adc    $0x0,%r8
    9e85:	4c 89 c0             	mov    %r8,%rax
    9e88:	49 f7 e3             	mul    %r11
    9e8b:	48 c1 ea 02          	shr    $0x2,%rdx
    9e8f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9e93:	49 29 c0             	sub    %rax,%r8
    9e96:	4c 29 c1             	sub    %r8,%rcx
    9e99:	49 83 de 00          	sbb    $0x0,%r14
    9e9d:	49 89 c8             	mov    %rcx,%r8
    9ea0:	4c 0f af c3          	imul   %rbx,%r8
    9ea4:	48 89 c8             	mov    %rcx,%rax
    9ea7:	49 f7 e3             	mul    %r11
    9eaa:	4c 01 c2             	add    %r8,%rdx
    9ead:	4d 0f af f3          	imul   %r11,%r14
    9eb1:	49 01 d6             	add    %rdx,%r14
    9eb4:	48 89 c1             	mov    %rax,%rcx
    9eb7:	48 01 c1             	add    %rax,%rcx
    9eba:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    9ebe:	89 f2                	mov    %esi,%edx
    9ec0:	29 ca                	sub    %ecx,%edx
    9ec2:	80 ca 30             	or     $0x30,%dl
    9ec5:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    9eca:	49 ff c1             	inc    %r9
    9ecd:	48 83 fe 0a          	cmp    $0xa,%rsi
    9ed1:	49 83 da 00          	sbb    $0x0,%r10
    9ed5:	48 89 c6             	mov    %rax,%rsi
    9ed8:	4d 89 f2             	mov    %r14,%r10
    9edb:	73 93                	jae    9e70 <fwp_fmt_duration+0x950>
    9edd:	45 85 c9             	test   %r9d,%r9d
    9ee0:	7e 13                	jle    9ef5 <fwp_fmt_duration+0x9d5>
    9ee2:	44 89 c8             	mov    %r9d,%eax
    9ee5:	48 83 f8 08          	cmp    $0x8,%rax
    9ee9:	73 11                	jae    9efc <fwp_fmt_duration+0x9dc>
    9eeb:	31 c9                	xor    %ecx,%ecx
    9eed:	48 89 c2             	mov    %rax,%rdx
    9ef0:	e9 29 01 00 00       	jmp    a01e <fwp_fmt_duration+0xafe>
    9ef5:	31 c0                	xor    %eax,%eax
    9ef7:	e9 48 01 00 00       	jmp    a044 <fwp_fmt_duration+0xb24>
    9efc:	83 f8 20             	cmp    $0x20,%eax
    9eff:	73 07                	jae    9f08 <fwp_fmt_duration+0x9e8>
    9f01:	31 c9                	xor    %ecx,%ecx
    9f03:	e9 b5 00 00 00       	jmp    9fbd <fwp_fmt_duration+0xa9d>
    9f08:	44 89 ce             	mov    %r9d,%esi
    9f0b:	44 89 ca             	mov    %r9d,%edx
    9f0e:	83 e2 1f             	and    $0x1f,%edx
    9f11:	48 89 c1             	mov    %rax,%rcx
    9f14:	48 29 d1             	sub    %rdx,%rcx
    9f17:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    9f1b:	49 83 c0 30          	add    $0x30,%r8
    9f1f:	48 29 d6             	sub    %rdx,%rsi
    9f22:	45 31 d2             	xor    %r10d,%r10d
    9f25:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9f29:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    9f2f:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    9f34:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9f38:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9f3c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9f41:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9f46:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9f4b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9f4f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9f54:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9f59:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9f5e:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9f62:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9f66:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9f6a:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9f6f:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9f74:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9f79:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9f7d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9f82:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9f87:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9f8c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9f90:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9f97:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    9f9e:	49 83 c2 20          	add    $0x20,%r10
    9fa2:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9fa6:	4c 39 d6             	cmp    %r10,%rsi
    9fa9:	0f 85 7a ff ff ff    	jne    9f29 <fwp_fmt_duration+0xa09>
    9faf:	48 85 d2             	test   %rdx,%rdx
    9fb2:	0f 84 8c 00 00 00    	je     a044 <fwp_fmt_duration+0xb24>
    9fb8:	83 fa 08             	cmp    $0x8,%edx
    9fbb:	72 61                	jb     a01e <fwp_fmt_duration+0xafe>
    9fbd:	48 89 ce             	mov    %rcx,%rsi
    9fc0:	45 89 c8             	mov    %r9d,%r8d
    9fc3:	44 89 ca             	mov    %r9d,%edx
    9fc6:	83 e2 07             	and    $0x7,%edx
    9fc9:	48 89 c1             	mov    %rax,%rcx
    9fcc:	48 29 d1             	sub    %rdx,%rcx
    9fcf:	49 89 f2             	mov    %rsi,%r10
    9fd2:	49 f7 da             	neg    %r10
    9fd5:	49 01 e2             	add    %rsp,%r10
    9fd8:	49 83 c2 40          	add    $0x40,%r10
    9fdc:	4d 01 c2             	add    %r8,%r10
    9fdf:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9fe3:	49 29 d0             	sub    %rdx,%r8
    9fe6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9fea:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9fef:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9ff3:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9ff8:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9ffd:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    a002:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    a006:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    a00c:	48 83 c6 08          	add    $0x8,%rsi
    a010:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    a014:	49 39 f0             	cmp    %rsi,%r8
    a017:	75 d1                	jne    9fea <fwp_fmt_duration+0xaca>
    a019:	48 85 d2             	test   %rdx,%rdx
    a01c:	74 26                	je     a044 <fwp_fmt_duration+0xb24>
    a01e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    a023:	48 01 f2             	add    %rsi,%rdx
    a026:	48 ff ca             	dec    %rdx
    a029:	44 89 ce             	mov    %r9d,%esi
    a02c:	0f 1f 40 00          	nopl   0x0(%rax)
    a030:	44 0f b6 02          	movzbl (%rdx),%r8d
    a034:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    a039:	48 ff c1             	inc    %rcx
    a03c:	48 ff ca             	dec    %rdx
    a03f:	48 39 ce             	cmp    %rcx,%rsi
    a042:	75 ec                	jne    a030 <fwp_fmt_duration+0xb10>
    a044:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    a049:	e9 28 f9 ff ff       	jmp    9976 <fwp_fmt_duration+0x456>
    a04e:	66 90                	xchg   %ax,%ax

000000000000a050 <fwp_format_g>:
    a050:	55                   	push   %rbp
    a051:	41 57                	push   %r15
    a053:	41 56                	push   %r14
    a055:	41 55                	push   %r13
    a057:	41 54                	push   %r12
    a059:	53                   	push   %rbx
    a05a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    a061:	89 f5                	mov    %esi,%ebp
    a063:	48 89 fb             	mov    %rdi,%rbx
    a066:	ff cd                	dec    %ebp
    a068:	48 8d 15 85 56 00 00 	lea    0x5685(%rip),%rdx        # f6f4 <fwp_segv.msg+0x474>
    a06f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    a074:	be 40 00 00 00       	mov    $0x40,%esi
    a079:	4c 89 e7             	mov    %r12,%rdi
    a07c:	89 e9                	mov    %ebp,%ecx
    a07e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    a084:	b0 01                	mov    $0x1,%al
    a086:	e8 75 80 ff ff       	call   2100 <snprintf@plt>
    a08b:	4c 89 e7             	mov    %r12,%rdi
    a08e:	be 65 00 00 00       	mov    $0x65,%esi
    a093:	e8 58 80 ff ff       	call   20f0 <strchr@plt>
    a098:	49 89 c7             	mov    %rax,%r15
    a09b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    a09f:	45 31 ed             	xor    %r13d,%r13d
    a0a2:	31 f6                	xor    %esi,%esi
    a0a4:	ba 0a 00 00 00       	mov    $0xa,%edx
    a0a9:	e8 12 81 ff ff       	call   21c0 <strtol@plt>
    a0ae:	49 89 c6             	mov    %rax,%r14
    a0b1:	83 c0 ef             	add    $0xffffffef,%eax
    a0b4:	83 f8 e9             	cmp    $0xffffffe9,%eax
    a0b7:	77 5f                	ja     a118 <fwp_format_g+0xc8>
    a0b9:	4d 29 e7             	sub    %r12,%r15
    a0bc:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    a0c1:	4c 89 ef             	mov    %r13,%rdi
    a0c4:	4c 89 e6             	mov    %r12,%rsi
    a0c7:	4c 89 fa             	mov    %r15,%rdx
    a0ca:	e8 01 81 ff ff       	call   21d0 <memcpy@plt>
    a0cf:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    a0d5:	4c 89 ef             	mov    %r13,%rdi
    a0d8:	be 2e 00 00 00       	mov    $0x2e,%esi
    a0dd:	e8 0e 80 ff ff       	call   20f0 <strchr@plt>
    a0e2:	48 85 c0             	test   %rax,%rax
    a0e5:	0f 84 a8 00 00 00    	je     a193 <fwp_format_g+0x143>
    a0eb:	4d 85 ff             	test   %r15,%r15
    a0ee:	0f 84 9f 00 00 00    	je     a193 <fwp_format_g+0x143>
    a0f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a0fb:	00 00 00 00 00 
    a100:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    a106:	83 f8 30             	cmp    $0x30,%eax
    a109:	75 7d                	jne    a188 <fwp_format_g+0x138>
    a10b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    a111:	49 ff cf             	dec    %r15
    a114:	75 ea                	jne    a100 <fwp_format_g+0xb0>
    a116:	eb 7b                	jmp    a193 <fwp_format_g+0x143>
    a118:	44 29 f5             	sub    %r14d,%ebp
    a11b:	85 ed                	test   %ebp,%ebp
    a11d:	44 0f 4f ed          	cmovg  %ebp,%r13d
    a121:	48 8d 15 db 55 00 00 	lea    0x55db(%rip),%rdx        # f703 <fwp_segv.msg+0x483>
    a128:	be 90 01 00 00       	mov    $0x190,%esi
    a12d:	48 89 df             	mov    %rbx,%rdi
    a130:	44 89 e9             	mov    %r13d,%ecx
    a133:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    a139:	b0 01                	mov    $0x1,%al
    a13b:	e8 c0 7f ff ff       	call   2100 <snprintf@plt>
    a140:	48 89 df             	mov    %rbx,%rdi
    a143:	e8 88 7f ff ff       	call   20d0 <strlen@plt>
    a148:	49 89 c6             	mov    %rax,%r14
    a14b:	48 89 df             	mov    %rbx,%rdi
    a14e:	be 2e 00 00 00       	mov    $0x2e,%esi
    a153:	e8 98 7f ff ff       	call   20f0 <strchr@plt>
    a158:	48 85 c0             	test   %rax,%rax
    a15b:	74 69                	je     a1c6 <fwp_format_g+0x176>
    a15d:	4d 85 f6             	test   %r14,%r14
    a160:	74 64                	je     a1c6 <fwp_format_g+0x176>
    a162:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a169:	1f 84 00 00 00 00 00 
    a170:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    a176:	83 f8 30             	cmp    $0x30,%eax
    a179:	75 5d                	jne    a1d8 <fwp_format_g+0x188>
    a17b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    a181:	49 ff ce             	dec    %r14
    a184:	75 ea                	jne    a170 <fwp_format_g+0x120>
    a186:	eb 3e                	jmp    a1c6 <fwp_format_g+0x176>
    a188:	83 f8 2e             	cmp    $0x2e,%eax
    a18b:	75 06                	jne    a193 <fwp_format_g+0x143>
    a18d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    a193:	44 89 f0             	mov    %r14d,%eax
    a196:	c1 e8 1f             	shr    $0x1f,%eax
    a199:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    a1a0:	00 
    a1a1:	45 89 f1             	mov    %r14d,%r9d
    a1a4:	41 f7 d9             	neg    %r9d
    a1a7:	45 0f 48 ce          	cmovs  %r14d,%r9d
    a1ab:	48 8d 15 47 55 00 00 	lea    0x5547(%rip),%rdx        # f6f9 <fwp_segv.msg+0x479>
    a1b2:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    a1b7:	be 90 01 00 00       	mov    $0x190,%esi
    a1bc:	48 89 df             	mov    %rbx,%rdi
    a1bf:	31 c0                	xor    %eax,%eax
    a1c1:	e8 3a 7f ff ff       	call   2100 <snprintf@plt>
    a1c6:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    a1cd:	5b                   	pop    %rbx
    a1ce:	41 5c                	pop    %r12
    a1d0:	41 5d                	pop    %r13
    a1d2:	41 5e                	pop    %r14
    a1d4:	41 5f                	pop    %r15
    a1d6:	5d                   	pop    %rbp
    a1d7:	c3                   	ret
    a1d8:	83 f8 2e             	cmp    $0x2e,%eax
    a1db:	75 e9                	jne    a1c6 <fwp_format_g+0x176>
    a1dd:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    a1e3:	eb e1                	jmp    a1c6 <fwp_format_g+0x176>
    a1e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a1ec:	00 00 00 00 

000000000000a1f0 <fwp_show_i64>:
    a1f0:	41 57                	push   %r15
    a1f2:	41 56                	push   %r14
    a1f4:	53                   	push   %rbx
    a1f5:	48 83 ec 20          	sub    $0x20,%rsp
    a1f9:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    a200:	00 00 00 
    a203:	48 89 f9             	mov    %rdi,%rcx
    a206:	48 f7 d9             	neg    %rcx
    a209:	48 0f 48 cf          	cmovs  %rdi,%rcx
    a20d:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    a212:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    a217:	45 31 f6             	xor    %r14d,%r14d
    a21a:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    a221:	cc cc cc 
    a224:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a22b:	00 00 00 00 00 
    a230:	48 89 c8             	mov    %rcx,%rax
    a233:	49 f7 e1             	mul    %r9
    a236:	48 c1 ea 03          	shr    $0x3,%rdx
    a23a:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    a23d:	8d 04 80             	lea    (%rax,%rax,4),%eax
    a240:	41 89 ca             	mov    %ecx,%r10d
    a243:	41 29 c2             	sub    %eax,%r10d
    a246:	41 80 ca 30          	or     $0x30,%r10b
    a24a:	45 88 10             	mov    %r10b,(%r8)
    a24d:	49 01 f6             	add    %rsi,%r14
    a250:	49 ff c8             	dec    %r8
    a253:	48 83 f9 09          	cmp    $0x9,%rcx
    a257:	48 89 d1             	mov    %rdx,%rcx
    a25a:	77 d4                	ja     a230 <fwp_show_i64+0x40>
    a25c:	48 85 ff             	test   %rdi,%rdi
    a25f:	78 06                	js     a267 <fwp_show_i64+0x77>
    a261:	49 c1 fe 20          	sar    $0x20,%r14
    a265:	eb 11                	jmp    a278 <fwp_show_i64+0x88>
    a267:	49 01 f6             	add    %rsi,%r14
    a26a:	49 c1 fe 20          	sar    $0x20,%r14
    a26e:	48 89 e0             	mov    %rsp,%rax
    a271:	4c 29 f0             	sub    %r14,%rax
    a274:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    a278:	49 8d 56 09          	lea    0x9(%r14),%rdx
    a27c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    a283:	77 61                	ja     a2e6 <fwp_show_i64+0xf6>
    a285:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    a289:	48 c1 e9 04          	shr    $0x4,%rcx
    a28d:	48 8d 05 d4 8e 00 00 	lea    0x8ed4(%rip),%rax        # 13168 <fwp_gc>
    a294:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    a29b:	00 
    a29c:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    a2a3:	48 29 0d be 8e 00 00 	sub    %rcx,0x8ebe(%rip)        # 13168 <fwp_gc>
    a2aa:	78 3a                	js     a2e6 <fwp_show_i64+0xf6>
    a2ac:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    a2b0:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    a2b4:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    a2bb:	4c 8b 3f             	mov    (%rdi),%r15
    a2be:	4d 85 ff             	test   %r15,%r15
    a2c1:	74 0b                	je     a2ce <fwp_show_i64+0xde>
    a2c3:	49 8b 07             	mov    (%r15),%rax
    a2c6:	48 f7 d0             	not    %rax
    a2c9:	48 89 07             	mov    %rax,(%rdi)
    a2cc:	eb 3a                	jmp    a308 <fwp_show_i64+0x118>
    a2ce:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    a2d5:	00 
    a2d6:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    a2dd:	00 
    a2de:	4c 29 ff             	sub    %r15,%rdi
    a2e1:	48 39 cf             	cmp    %rcx,%rdi
    a2e4:	73 12                	jae    a2f8 <fwp_show_i64+0x108>
    a2e6:	48 89 d7             	mov    %rdx,%rdi
    a2e9:	be 01 00 00 00       	mov    $0x1,%esi
    a2ee:	e8 4d cc ff ff       	call   6f40 <fwp_gc_alloc_slow>
    a2f3:	49 89 c7             	mov    %rax,%r15
    a2f6:	eb 1a                	jmp    a312 <fwp_show_i64+0x122>
    a2f8:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    a2fc:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    a302:	4c 01 f9             	add    %r15,%rcx
    a305:	48 89 08             	mov    %rcx,(%rax)
    a308:	4c 89 ff             	mov    %r15,%rdi
    a30b:	31 f6                	xor    %esi,%esi
    a30d:	e8 0e 7e ff ff       	call   2120 <memset@plt>
    a312:	4c 29 f3             	sub    %r14,%rbx
    a315:	4d 89 37             	mov    %r14,(%r15)
    a318:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    a31c:	48 89 de             	mov    %rbx,%rsi
    a31f:	4c 89 f2             	mov    %r14,%rdx
    a322:	e8 a9 7e ff ff       	call   21d0 <memcpy@plt>
    a327:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    a32d:	4c 89 f8             	mov    %r15,%rax
    a330:	48 83 c4 20          	add    $0x20,%rsp
    a334:	5b                   	pop    %rbx
    a335:	41 5e                	pop    %r14
    a337:	41 5f                	pop    %r15
    a339:	c3                   	ret
    a33a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a340 <fwp_p_array_get_typed>:
    a340:	48 85 ff             	test   %rdi,%rdi
    a343:	78 3e                	js     a383 <fwp_p_array_get_typed+0x43>
    a345:	48 8b 0e             	mov    (%rsi),%rcx
    a348:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    a34f:	ff ff 7f 
    a352:	48 21 c8             	and    %rcx,%rax
    a355:	48 39 f8             	cmp    %rdi,%rax
    a358:	76 29                	jbe    a383 <fwp_p_array_get_typed+0x43>
    a35a:	b8 08 00 00 00       	mov    $0x8,%eax
    a35f:	48 85 d2             	test   %rdx,%rdx
    a362:	74 14                	je     a378 <fwp_p_array_get_typed+0x38>
    a364:	44 8b 02             	mov    (%rdx),%r8d
    a367:	49 83 f8 0a          	cmp    $0xa,%r8
    a36b:	77 0b                	ja     a378 <fwp_p_array_get_typed+0x38>
    a36d:	48 8d 05 84 4f 00 00 	lea    0x4f84(%rip),%rax        # f2f8 <fwp_segv.msg+0x78>
    a374:	4a 8b 04 c0          	mov    (%rax,%r8,8),%rax
    a378:	48 85 c9             	test   %rcx,%rcx
    a37b:	78 09                	js     a386 <fwp_p_array_get_typed+0x46>
    a37d:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
    a381:	eb 07                	jmp    a38a <fwp_p_array_get_typed+0x4a>
    a383:	31 c0                	xor    %eax,%eax
    a385:	c3                   	ret
    a386:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    a38a:	41 57                	push   %r15
    a38c:	41 56                	push   %r14
    a38e:	53                   	push   %rbx
    a38f:	48 83 ec 10          	sub    $0x10,%rsp
    a393:	48 0f af f8          	imul   %rax,%rdi
    a397:	48 83 f8 01          	cmp    $0x1,%rax
    a39b:	49 89 f6             	mov    %rsi,%r14
    a39e:	74 1f                	je     a3bf <fwp_p_array_get_typed+0x7f>
    a3a0:	48 83 f8 02          	cmp    $0x2,%rax
    a3a4:	74 0c                	je     a3b2 <fwp_p_array_get_typed+0x72>
    a3a6:	48 83 f8 08          	cmp    $0x8,%rax
    a3aa:	75 20                	jne    a3cc <fwp_p_array_get_typed+0x8c>
    a3ac:	48 8b 04 39          	mov    (%rcx,%rdi,1),%rax
    a3b0:	eb 27                	jmp    a3d9 <fwp_p_array_get_typed+0x99>
    a3b2:	83 3a 01             	cmpl   $0x1,(%rdx)
    a3b5:	0f b7 0c 39          	movzwl (%rcx,%rdi,1),%ecx
    a3b9:	48 0f bf c1          	movswq %cx,%rax
    a3bd:	eb 16                	jmp    a3d5 <fwp_p_array_get_typed+0x95>
    a3bf:	83 3a 00             	cmpl   $0x0,(%rdx)
    a3c2:	0f b6 0c 39          	movzbl (%rcx,%rdi,1),%ecx
    a3c6:	48 0f be c1          	movsbq %cl,%rax
    a3ca:	eb 09                	jmp    a3d5 <fwp_p_array_get_typed+0x95>
    a3cc:	83 3a 02             	cmpl   $0x2,(%rdx)
    a3cf:	8b 0c 39             	mov    (%rcx,%rdi,1),%ecx
    a3d2:	48 63 c1             	movslq %ecx,%rax
    a3d5:	48 0f 45 c1          	cmovne %rcx,%rax
    a3d9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a3de:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    a3e3:	bf 01 00 00 00       	mov    $0x1,%edi
    a3e8:	be 01 00 00 00       	mov    $0x1,%esi
    a3ed:	e8 9e 00 00 00       	call   a490 <fwp_data>
    a3f2:	48 89 c2             	mov    %rax,%rdx
    a3f5:	48 2b 15 9c 9d 00 00 	sub    0x9d9c(%rip),%rdx        # 14198 <fwp_gc+0x1030>
    a3fc:	48 8b 0d bd 9d 00 00 	mov    0x9dbd(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    a403:	48 c1 e1 10          	shl    $0x10,%rcx
    a407:	48 39 ca             	cmp    %rcx,%rdx
    a40a:	4c 89 f1             	mov    %r14,%rcx
    a40d:	73 77                	jae    a486 <fwp_p_array_get_typed+0x146>
    a40f:	48 8b 35 ca 9d 00 00 	mov    0x9dca(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    a416:	48 89 d7             	mov    %rdx,%rdi
    a419:	48 c1 ef 10          	shr    $0x10,%rdi
    a41d:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    a424:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    a429:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    a430:	75 1b                	jne    a44d <fwp_p_array_get_typed+0x10d>
    a432:	41 80 f8 02          	cmp    $0x2,%r8b
    a436:	75 15                	jne    a44d <fwp_p_array_get_typed+0x10d>
    a438:	48 8d 1c 3e          	lea    (%rsi,%rdi,1),%rbx
    a43c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a443:	80 3b ff             	cmpb   $0xff,(%rbx)
    a446:	74 2b                	je     a473 <fwp_p_array_get_typed+0x133>
    a448:	c6 03 01             	movb   $0x1,(%rbx)
    a44b:	eb 39                	jmp    a486 <fwp_p_array_get_typed+0x146>
    a44d:	41 80 f8 01          	cmp    $0x1,%r8b
    a451:	75 33                	jne    a486 <fwp_p_array_get_typed+0x146>
    a453:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    a457:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    a45b:	48 0f af d6          	imul   %rsi,%rdx
    a45f:	48 c1 ea 20          	shr    $0x20,%rdx
    a463:	4a 8d 1c 02          	lea    (%rdx,%r8,1),%rbx
    a467:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a46e:	80 3b ff             	cmpb   $0xff,(%rbx)
    a471:	75 d5                	jne    a448 <fwp_p_array_get_typed+0x108>
    a473:	48 89 df             	mov    %rbx,%rdi
    a476:	49 89 c7             	mov    %rax,%r15
    a479:	e8 52 c6 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    a47e:	4c 89 f8             	mov    %r15,%rax
    a481:	4c 89 f1             	mov    %r14,%rcx
    a484:	eb c2                	jmp    a448 <fwp_p_array_get_typed+0x108>
    a486:	48 83 c4 10          	add    $0x10,%rsp
    a48a:	5b                   	pop    %rbx
    a48b:	41 5e                	pop    %r14
    a48d:	41 5f                	pop    %r15
    a48f:	c3                   	ret

000000000000a490 <fwp_data>:
    a490:	55                   	push   %rbp
    a491:	41 57                	push   %r15
    a493:	41 56                	push   %r14
    a495:	41 55                	push   %r13
    a497:	41 54                	push   %r12
    a499:	53                   	push   %rbx
    a49a:	50                   	push   %rax
    a49b:	48 89 d3             	mov    %rdx,%rbx
    a49e:	89 f5                	mov    %esi,%ebp
    a4a0:	41 89 ff             	mov    %edi,%r15d
    a4a3:	41 89 f4             	mov    %esi,%r12d
    a4a6:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    a4ad:	00 
    a4ae:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    a4b5:	00 
    a4b6:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    a4bc:	0f 87 e6 00 00 00    	ja     a5a8 <fwp_data+0x118>
    a4c2:	49 8d 75 17          	lea    0x17(%r13),%rsi
    a4c6:	48 c1 ee 04          	shr    $0x4,%rsi
    a4ca:	48 8d 05 97 8c 00 00 	lea    0x8c97(%rip),%rax        # 13168 <fwp_gc>
    a4d1:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a4d8:	00 
    a4d9:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a4e0:	4c 8b 05 81 8c 00 00 	mov    0x8c81(%rip),%r8        # 13168 <fwp_gc>
    a4e7:	4d 89 c1             	mov    %r8,%r9
    a4ea:	49 29 d1             	sub    %rdx,%r9
    a4ed:	4c 89 0d 74 8c 00 00 	mov    %r9,0x8c74(%rip)        # 13168 <fwp_gc>
    a4f4:	0f 88 ae 00 00 00    	js     a5a8 <fwp_data+0x118>
    a4fa:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    a4fe:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    a502:	49 83 c2 08          	add    $0x8,%r10
    a506:	4d 8b 32             	mov    (%r10),%r14
    a509:	4d 85 f6             	test   %r14,%r14
    a50c:	74 29                	je     a537 <fwp_data+0xa7>
    a50e:	49 8b 06             	mov    (%r14),%rax
    a511:	48 f7 d0             	not    %rax
    a514:	49 89 02             	mov    %rax,(%r10)
    a517:	48 39 d7             	cmp    %rdx,%rdi
    a51a:	0f 83 ad 00 00 00    	jae    a5cd <fwp_data+0x13d>
    a520:	4c 01 f7             	add    %r14,%rdi
    a523:	4c 29 ea             	sub    %r13,%rdx
    a526:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    a52a:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    a52e:	48 83 c2 08          	add    $0x8,%rdx
    a532:	e9 8f 00 00 00       	jmp    a5c6 <fwp_data+0x136>
    a537:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    a53c:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    a541:	4d 29 f2             	sub    %r14,%r10
    a544:	49 39 d2             	cmp    %rdx,%r10
    a547:	72 2f                	jb     a578 <fwp_data+0xe8>
    a549:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    a54d:	48 83 c1 10          	add    $0x10,%rcx
    a551:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    a555:	4c 89 09             	mov    %r9,(%rcx)
    a558:	4d 85 f6             	test   %r14,%r14
    a55b:	75 ba                	jne    a517 <fwp_data+0x87>
    a55d:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a564:	00 
    a565:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a56c:	49 29 d0             	sub    %rdx,%r8
    a56f:	4c 89 05 f2 8b 00 00 	mov    %r8,0x8bf2(%rip)        # 13168 <fwp_gc>
    a576:	78 30                	js     a5a8 <fwp_data+0x118>
    a578:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a57c:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    a581:	4d 85 f6             	test   %r14,%r14
    a584:	74 10                	je     a596 <fwp_data+0x106>
    a586:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a58a:	48 83 c0 08          	add    $0x8,%rax
    a58e:	49 8b 0e             	mov    (%r14),%rcx
    a591:	48 f7 d1             	not    %rcx
    a594:	eb 2a                	jmp    a5c0 <fwp_data+0x130>
    a596:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    a59b:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    a5a0:	4c 29 f6             	sub    %r14,%rsi
    a5a3:	48 39 d6             	cmp    %rdx,%rsi
    a5a6:	73 0c                	jae    a5b4 <fwp_data+0x124>
    a5a8:	31 f6                	xor    %esi,%esi
    a5aa:	e8 91 c9 ff ff       	call   6f40 <fwp_gc_alloc_slow>
    a5af:	49 89 c6             	mov    %rax,%r14
    a5b2:	eb 19                	jmp    a5cd <fwp_data+0x13d>
    a5b4:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a5b8:	48 83 c0 10          	add    $0x10,%rax
    a5bc:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    a5c0:	48 89 08             	mov    %rcx,(%rax)
    a5c3:	4c 89 f7             	mov    %r14,%rdi
    a5c6:	31 f6                	xor    %esi,%esi
    a5c8:	e8 53 7b ff ff       	call   2120 <memset@plt>
    a5cd:	45 89 3e             	mov    %r15d,(%r14)
    a5d0:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    a5d4:	85 ed                	test   %ebp,%ebp
    a5d6:	0f 84 bb 00 00 00    	je     a697 <fwp_data+0x207>
    a5dc:	83 fd 08             	cmp    $0x8,%ebp
    a5df:	72 10                	jb     a5f1 <fwp_data+0x161>
    a5e1:	4c 89 f0             	mov    %r14,%rax
    a5e4:	48 29 d8             	sub    %rbx,%rax
    a5e7:	48 83 c0 08          	add    $0x8,%rax
    a5eb:	48 83 f8 20          	cmp    $0x20,%rax
    a5ef:	73 71                	jae    a662 <fwp_data+0x1d2>
    a5f1:	31 c0                	xor    %eax,%eax
    a5f3:	4c 89 e2             	mov    %r12,%rdx
    a5f6:	48 89 c1             	mov    %rax,%rcx
    a5f9:	48 83 e2 03          	and    $0x3,%rdx
    a5fd:	74 22                	je     a621 <fwp_data+0x191>
    a5ff:	48 89 c1             	mov    %rax,%rcx
    a602:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a609:	1f 84 00 00 00 00 00 
    a610:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    a614:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    a619:	48 ff c1             	inc    %rcx
    a61c:	48 ff ca             	dec    %rdx
    a61f:	75 ef                	jne    a610 <fwp_data+0x180>
    a621:	4c 29 e0             	sub    %r12,%rax
    a624:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    a628:	77 6d                	ja     a697 <fwp_data+0x207>
    a62a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a630:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    a634:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    a639:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    a63e:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    a643:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    a648:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    a64d:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    a652:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    a657:	48 83 c1 04          	add    $0x4,%rcx
    a65b:	49 39 cc             	cmp    %rcx,%r12
    a65e:	75 d0                	jne    a630 <fwp_data+0x1a0>
    a660:	eb 35                	jmp    a697 <fwp_data+0x207>
    a662:	44 89 e0             	mov    %r12d,%eax
    a665:	83 e0 fc             	and    $0xfffffffc,%eax
    a668:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    a66c:	31 c9                	xor    %ecx,%ecx
    a66e:	66 90                	xchg   %ax,%ax
    a670:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    a674:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    a679:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    a67f:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    a685:	48 83 c1 20          	add    $0x20,%rcx
    a689:	49 39 cd             	cmp    %rcx,%r13
    a68c:	75 e2                	jne    a670 <fwp_data+0x1e0>
    a68e:	4c 39 e0             	cmp    %r12,%rax
    a691:	0f 85 5c ff ff ff    	jne    a5f3 <fwp_data+0x163>
    a697:	4c 89 f0             	mov    %r14,%rax
    a69a:	48 83 c4 08          	add    $0x8,%rsp
    a69e:	5b                   	pop    %rbx
    a69f:	41 5c                	pop    %r12
    a6a1:	41 5d                	pop    %r13
    a6a3:	41 5e                	pop    %r14
    a6a5:	41 5f                	pop    %r15
    a6a7:	5d                   	pop    %rbp
    a6a8:	c3                   	ret
    a6a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000a6b0 <f49>:
    a6b0:	41 57                	push   %r15
    a6b2:	41 56                	push   %r14
    a6b4:	53                   	push   %rbx
    a6b5:	48 83 ec 30          	sub    $0x30,%rsp
    a6b9:	48 89 fb             	mov    %rdi,%rbx
    a6bc:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a6c0:	48 2b 05 d1 9a 00 00 	sub    0x9ad1(%rip),%rax        # 14198 <fwp_gc+0x1030>
    a6c7:	48 8b 0d f2 9a 00 00 	mov    0x9af2(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    a6ce:	48 c1 e1 10          	shl    $0x10,%rcx
    a6d2:	48 39 c8             	cmp    %rcx,%rax
    a6d5:	73 68                	jae    a73f <f49+0x8f>
    a6d7:	48 8b 0d 02 9b 00 00 	mov    0x9b02(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    a6de:	48 89 c2             	mov    %rax,%rdx
    a6e1:	48 c1 ea 10          	shr    $0x10,%rdx
    a6e5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a6ec:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a6f0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a6f6:	75 13                	jne    a70b <f49+0x5b>
    a6f8:	40 80 fe 02          	cmp    $0x2,%sil
    a6fc:	75 0d                	jne    a70b <f49+0x5b>
    a6fe:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a702:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a709:	eb 21                	jmp    a72c <f49+0x7c>
    a70b:	40 80 fe 01          	cmp    $0x1,%sil
    a70f:	75 2e                	jne    a73f <f49+0x8f>
    a711:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a715:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a719:	48 0f af c1          	imul   %rcx,%rax
    a71d:	48 c1 e8 20          	shr    $0x20,%rax
    a721:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    a725:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a72c:	0f b6 07             	movzbl (%rdi),%eax
    a72f:	84 c0                	test   %al,%al
    a731:	74 0c                	je     a73f <f49+0x8f>
    a733:	3c fe                	cmp    $0xfe,%al
    a735:	0f 83 d8 01 00 00    	jae    a913 <f49+0x263>
    a73b:	fe c0                	inc    %al
    a73d:	88 07                	mov    %al,(%rdi)
    a73f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    a743:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    a747:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    a74b:	4d 85 ff             	test   %r15,%r15
    a74e:	78 20                	js     a770 <f49+0xc0>
    a750:	48 8b 07             	mov    (%rdi),%rax
    a753:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    a75a:	ff ff 7f 
    a75d:	48 21 c1             	and    %rax,%rcx
    a760:	4c 39 f9             	cmp    %r15,%rcx
    a763:	76 0b                	jbe    a770 <f49+0xc0>
    a765:	48 85 c0             	test   %rax,%rax
    a768:	78 2e                	js     a798 <f49+0xe8>
    a76a:	48 8d 47 08          	lea    0x8(%rdi),%rax
    a76e:	eb 2c                	jmp    a79c <f49+0xec>
    a770:	e8 8b 03 00 00       	call   ab00 <fwp_drop1>
    a775:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    a77b:	48 89 df             	mov    %rbx,%rdi
    a77e:	e8 ad 01 00 00       	call   a930 <fwp_drop6>
    a783:	4c 89 ff             	mov    %r15,%rdi
    a786:	4c 89 f6             	mov    %r14,%rsi
    a789:	e8 52 02 00 00       	call   a9e0 <fwp_vbox1>
    a78e:	48 83 c4 30          	add    $0x30,%rsp
    a792:	5b                   	pop    %rbx
    a793:	41 5e                	pop    %r14
    a795:	41 5f                	pop    %r15
    a797:	c3                   	ret
    a798:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a79c:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    a7a1:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    a7a7:	f2 0f 59 05 61 48 00 	mulsd  0x4861(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    a7ae:	00 
    a7af:	f2 0f 58 05 61 48 00 	addsd  0x4861(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    a7b6:	00 
    a7b7:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    a7bd:	48 89 f8             	mov    %rdi,%rax
    a7c0:	48 2b 05 d1 99 00 00 	sub    0x99d1(%rip),%rax        # 14198 <fwp_gc+0x1030>
    a7c7:	49 ff c7             	inc    %r15
    a7ca:	48 8b 0d ef 99 00 00 	mov    0x99ef(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    a7d1:	48 c1 e1 10          	shl    $0x10,%rcx
    a7d5:	48 39 c8             	cmp    %rcx,%rax
    a7d8:	73 66                	jae    a840 <f49+0x190>
    a7da:	48 8b 0d ff 99 00 00 	mov    0x99ff(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    a7e1:	48 89 c2             	mov    %rax,%rdx
    a7e4:	48 c1 ea 10          	shr    $0x10,%rdx
    a7e8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a7ef:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a7f3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a7f9:	75 12                	jne    a80d <f49+0x15d>
    a7fb:	40 80 fe 02          	cmp    $0x2,%sil
    a7ff:	75 0c                	jne    a80d <f49+0x15d>
    a801:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a805:	48 05 28 02 00 00    	add    $0x228,%rax
    a80b:	eb 1f                	jmp    a82c <f49+0x17c>
    a80d:	40 80 fe 01          	cmp    $0x1,%sil
    a811:	75 2d                	jne    a840 <f49+0x190>
    a813:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a817:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a81b:	48 0f af c1          	imul   %rcx,%rax
    a81f:	48 c1 e8 20          	shr    $0x20,%rax
    a823:	48 01 f0             	add    %rsi,%rax
    a826:	48 05 28 02 00 00    	add    $0x228,%rax
    a82c:	0f b6 08             	movzbl (%rax),%ecx
    a82f:	84 c9                	test   %cl,%cl
    a831:	74 0d                	je     a840 <f49+0x190>
    a833:	80 f9 fe             	cmp    $0xfe,%cl
    a836:	0f 83 e1 00 00 00    	jae    a91d <f49+0x26d>
    a83c:	fe c1                	inc    %cl
    a83e:	88 08                	mov    %cl,(%rax)
    a840:	49 89 fe             	mov    %rdi,%r14
    a843:	e8 b8 02 00 00       	call   ab00 <fwp_drop1>
    a848:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    a84e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    a854:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    a859:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    a85e:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    a864:	45 31 ff             	xor    %r15d,%r15d
    a867:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a86c:	31 ff                	xor    %edi,%edi
    a86e:	be 03 00 00 00       	mov    $0x3,%esi
    a873:	e8 18 fc ff ff       	call   a490 <fwp_data>
    a878:	49 89 c6             	mov    %rax,%r14
    a87b:	48 2b 05 16 99 00 00 	sub    0x9916(%rip),%rax        # 14198 <fwp_gc+0x1030>
    a882:	48 8b 0d 37 99 00 00 	mov    0x9937(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    a889:	48 c1 e1 10          	shl    $0x10,%rcx
    a88d:	48 39 c8             	cmp    %rcx,%rax
    a890:	0f 83 e5 fe ff ff    	jae    a77b <f49+0xcb>
    a896:	48 8b 0d 43 99 00 00 	mov    0x9943(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    a89d:	48 89 c2             	mov    %rax,%rdx
    a8a0:	48 c1 ea 10          	shr    $0x10,%rdx
    a8a4:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a8ab:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a8af:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a8b5:	75 23                	jne    a8da <f49+0x22a>
    a8b7:	40 80 fe 02          	cmp    $0x2,%sil
    a8bb:	75 1d                	jne    a8da <f49+0x22a>
    a8bd:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    a8c1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a8c8:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a8cc:	74 33                	je     a901 <f49+0x251>
    a8ce:	41 c6 07 01          	movb   $0x1,(%r15)
    a8d2:	45 31 ff             	xor    %r15d,%r15d
    a8d5:	e9 a1 fe ff ff       	jmp    a77b <f49+0xcb>
    a8da:	40 80 fe 01          	cmp    $0x1,%sil
    a8de:	75 2b                	jne    a90b <f49+0x25b>
    a8e0:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a8e4:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a8e8:	48 0f af c1          	imul   %rcx,%rax
    a8ec:	48 c1 e8 20          	shr    $0x20,%rax
    a8f0:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    a8f4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a8fb:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a8ff:	75 cd                	jne    a8ce <f49+0x21e>
    a901:	4c 89 ff             	mov    %r15,%rdi
    a904:	e8 c7 c1 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    a909:	eb c3                	jmp    a8ce <f49+0x21e>
    a90b:	45 31 ff             	xor    %r15d,%r15d
    a90e:	e9 68 fe ff ff       	jmp    a77b <f49+0xcb>
    a913:	e8 48 d3 ff ff       	call   7c60 <fwp_rc_wide_dup>
    a918:	e9 22 fe ff ff       	jmp    a73f <f49+0x8f>
    a91d:	49 89 fe             	mov    %rdi,%r14
    a920:	48 89 c7             	mov    %rax,%rdi
    a923:	e8 38 d3 ff ff       	call   7c60 <fwp_rc_wide_dup>
    a928:	4c 89 f7             	mov    %r14,%rdi
    a92b:	e9 10 ff ff ff       	jmp    a840 <f49+0x190>

000000000000a930 <fwp_drop6>:
    a930:	48 89 f8             	mov    %rdi,%rax
    a933:	48 2b 05 5e 98 00 00 	sub    0x985e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    a93a:	48 8b 0d 7f 98 00 00 	mov    0x987f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    a941:	48 c1 e1 10          	shl    $0x10,%rcx
    a945:	48 39 c8             	cmp    %rcx,%rax
    a948:	0f 83 83 00 00 00    	jae    a9d1 <fwp_drop6+0xa1>
    a94e:	48 8b 0d 8b 98 00 00 	mov    0x988b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    a955:	48 89 c2             	mov    %rax,%rdx
    a958:	48 c1 ea 10          	shr    $0x10,%rdx
    a95c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a963:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a967:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a96d:	75 12                	jne    a981 <fwp_drop6+0x51>
    a96f:	40 80 fe 02          	cmp    $0x2,%sil
    a973:	75 0c                	jne    a981 <fwp_drop6+0x51>
    a975:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a979:	48 05 28 02 00 00    	add    $0x228,%rax
    a97f:	eb 1f                	jmp    a9a0 <fwp_drop6+0x70>
    a981:	40 80 fe 01          	cmp    $0x1,%sil
    a985:	75 4a                	jne    a9d1 <fwp_drop6+0xa1>
    a987:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a98b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a98f:	48 0f af c1          	imul   %rcx,%rax
    a993:	48 c1 e8 20          	shr    $0x20,%rax
    a997:	48 01 f0             	add    %rsi,%rax
    a99a:	48 05 28 02 00 00    	add    $0x228,%rax
    a9a0:	0f b6 08             	movzbl (%rax),%ecx
    a9a3:	85 c9                	test   %ecx,%ecx
    a9a5:	74 2a                	je     a9d1 <fwp_drop6+0xa1>
    a9a7:	83 f9 01             	cmp    $0x1,%ecx
    a9aa:	75 19                	jne    a9c5 <fwp_drop6+0x95>
    a9ac:	53                   	push   %rbx
    a9ad:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a9b1:	48 89 fb             	mov    %rdi,%rbx
    a9b4:	48 89 c7             	mov    %rax,%rdi
    a9b7:	e8 44 01 00 00       	call   ab00 <fwp_drop1>
    a9bc:	48 89 df             	mov    %rbx,%rdi
    a9bf:	5b                   	pop    %rbx
    a9c0:	e9 0b 06 00 00       	jmp    afd0 <fwp_rc_free_obj>
    a9c5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a9cb:	74 05                	je     a9d2 <fwp_drop6+0xa2>
    a9cd:	fe c9                	dec    %cl
    a9cf:	88 08                	mov    %cl,(%rax)
    a9d1:	c3                   	ret
    a9d2:	48 89 c7             	mov    %rax,%rdi
    a9d5:	e9 16 03 00 00       	jmp    acf0 <fwp_rc_wide_drop>
    a9da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a9e0 <fwp_vbox1>:
    a9e0:	41 56                	push   %r14
    a9e2:	53                   	push   %rbx
    a9e3:	48 83 ec 18          	sub    $0x18,%rsp
    a9e7:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    a9ec:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    a9f1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    a9f6:	83 ff 01             	cmp    $0x1,%edi
    a9f9:	74 5c                	je     aa57 <fwp_vbox1+0x77>
    a9fb:	85 ff                	test   %edi,%edi
    a9fd:	0f 85 ba 00 00 00    	jne    aabd <fwp_vbox1+0xdd>
    aa03:	31 ff                	xor    %edi,%edi
    aa05:	be 01 00 00 00       	mov    $0x1,%esi
    aa0a:	e8 81 fa ff ff       	call   a490 <fwp_data>
    aa0f:	48 89 c1             	mov    %rax,%rcx
    aa12:	48 2b 0d 7f 97 00 00 	sub    0x977f(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    aa19:	48 8b 15 a0 97 00 00 	mov    0x97a0(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    aa20:	48 c1 e2 10          	shl    $0x10,%rdx
    aa24:	48 39 d1             	cmp    %rdx,%rcx
    aa27:	0f 83 ca 00 00 00    	jae    aaf7 <fwp_vbox1+0x117>
    aa2d:	48 8b 15 ac 97 00 00 	mov    0x97ac(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    aa34:	48 89 ce             	mov    %rcx,%rsi
    aa37:	48 c1 ee 10          	shr    $0x10,%rsi
    aa3b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    aa42:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    aa46:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    aa4d:	75 72                	jne    aac1 <fwp_vbox1+0xe1>
    aa4f:	40 80 ff 02          	cmp    $0x2,%dil
    aa53:	74 53                	je     aaa8 <fwp_vbox1+0xc8>
    aa55:	eb 6a                	jmp    aac1 <fwp_vbox1+0xe1>
    aa57:	bf 01 00 00 00       	mov    $0x1,%edi
    aa5c:	be 01 00 00 00       	mov    $0x1,%esi
    aa61:	e8 2a fa ff ff       	call   a490 <fwp_data>
    aa66:	48 89 c1             	mov    %rax,%rcx
    aa69:	48 2b 0d 28 97 00 00 	sub    0x9728(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    aa70:	48 8b 15 49 97 00 00 	mov    0x9749(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    aa77:	48 c1 e2 10          	shl    $0x10,%rdx
    aa7b:	48 39 d1             	cmp    %rdx,%rcx
    aa7e:	73 77                	jae    aaf7 <fwp_vbox1+0x117>
    aa80:	48 8b 15 59 97 00 00 	mov    0x9759(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    aa87:	48 89 ce             	mov    %rcx,%rsi
    aa8a:	48 c1 ee 10          	shr    $0x10,%rsi
    aa8e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    aa95:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    aa99:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    aaa0:	75 1f                	jne    aac1 <fwp_vbox1+0xe1>
    aaa2:	40 80 ff 02          	cmp    $0x2,%dil
    aaa6:	75 19                	jne    aac1 <fwp_vbox1+0xe1>
    aaa8:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    aaac:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    aab3:	80 3b ff             	cmpb   $0xff,(%rbx)
    aab6:	74 2f                	je     aae7 <fwp_vbox1+0x107>
    aab8:	c6 03 01             	movb   $0x1,(%rbx)
    aabb:	eb 3a                	jmp    aaf7 <fwp_vbox1+0x117>
    aabd:	31 c0                	xor    %eax,%eax
    aabf:	eb 36                	jmp    aaf7 <fwp_vbox1+0x117>
    aac1:	40 80 ff 01          	cmp    $0x1,%dil
    aac5:	75 30                	jne    aaf7 <fwp_vbox1+0x117>
    aac7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    aacb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    aacf:	48 0f af ca          	imul   %rdx,%rcx
    aad3:	48 c1 e9 20          	shr    $0x20,%rcx
    aad7:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    aadb:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    aae2:	80 3b ff             	cmpb   $0xff,(%rbx)
    aae5:	75 d1                	jne    aab8 <fwp_vbox1+0xd8>
    aae7:	48 89 df             	mov    %rbx,%rdi
    aaea:	49 89 c6             	mov    %rax,%r14
    aaed:	e8 de bf ff ff       	call   6ad0 <fwp_rc_forget_slot>
    aaf2:	4c 89 f0             	mov    %r14,%rax
    aaf5:	eb c1                	jmp    aab8 <fwp_vbox1+0xd8>
    aaf7:	48 83 c4 18          	add    $0x18,%rsp
    aafb:	5b                   	pop    %rbx
    aafc:	41 5e                	pop    %r14
    aafe:	c3                   	ret
    aaff:	90                   	nop

000000000000ab00 <fwp_drop1>:
    ab00:	53                   	push   %rbx
    ab01:	48 89 f8             	mov    %rdi,%rax
    ab04:	48 2b 05 8d 96 00 00 	sub    0x968d(%rip),%rax        # 14198 <fwp_gc+0x1030>
    ab0b:	48 8b 0d ae 96 00 00 	mov    0x96ae(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    ab12:	48 c1 e1 10          	shl    $0x10,%rcx
    ab16:	48 39 c8             	cmp    %rcx,%rax
    ab19:	0f 83 9c 00 00 00    	jae    abbb <fwp_drop1+0xbb>
    ab1f:	48 8b 0d ba 96 00 00 	mov    0x96ba(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    ab26:	48 89 c2             	mov    %rax,%rdx
    ab29:	48 c1 ea 10          	shr    $0x10,%rdx
    ab2d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ab34:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ab38:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ab3e:	75 20                	jne    ab60 <fwp_drop1+0x60>
    ab40:	40 80 fe 02          	cmp    $0x2,%sil
    ab44:	75 1a                	jne    ab60 <fwp_drop1+0x60>
    ab46:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ab4a:	48 05 28 02 00 00    	add    $0x228,%rax
    ab50:	eb 2d                	jmp    ab7f <fwp_drop1+0x7f>
    ab52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab59:	1f 84 00 00 00 00 00 
    ab60:	40 80 fe 01          	cmp    $0x1,%sil
    ab64:	75 55                	jne    abbb <fwp_drop1+0xbb>
    ab66:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ab6a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ab6e:	48 0f af c1          	imul   %rcx,%rax
    ab72:	48 c1 e8 20          	shr    $0x20,%rax
    ab76:	48 01 f0             	add    %rsi,%rax
    ab79:	48 05 28 02 00 00    	add    $0x228,%rax
    ab7f:	0f b6 08             	movzbl (%rax),%ecx
    ab82:	85 c9                	test   %ecx,%ecx
    ab84:	74 35                	je     abbb <fwp_drop1+0xbb>
    ab86:	83 f9 01             	cmp    $0x1,%ecx
    ab89:	75 32                	jne    abbd <fwp_drop1+0xbd>
    ab8b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    ab8f:	79 3a                	jns    abcb <fwp_drop1+0xcb>
    ab91:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    ab95:	e8 46 00 00 00       	call   abe0 <fwp_rc_free_arr>
    ab9a:	48 89 d8             	mov    %rbx,%rax
    ab9d:	48 2b 05 f4 95 00 00 	sub    0x95f4(%rip),%rax        # 14198 <fwp_gc+0x1030>
    aba4:	48 8b 0d 15 96 00 00 	mov    0x9615(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    abab:	48 c1 e1 10          	shl    $0x10,%rcx
    abaf:	48 89 df             	mov    %rbx,%rdi
    abb2:	48 39 c8             	cmp    %rcx,%rax
    abb5:	0f 82 64 ff ff ff    	jb     ab1f <fwp_drop1+0x1f>
    abbb:	5b                   	pop    %rbx
    abbc:	c3                   	ret
    abbd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    abc3:	74 09                	je     abce <fwp_drop1+0xce>
    abc5:	fe c9                	dec    %cl
    abc7:	88 08                	mov    %cl,(%rax)
    abc9:	5b                   	pop    %rbx
    abca:	c3                   	ret
    abcb:	5b                   	pop    %rbx
    abcc:	eb 12                	jmp    abe0 <fwp_rc_free_arr>
    abce:	48 89 c7             	mov    %rax,%rdi
    abd1:	5b                   	pop    %rbx
    abd2:	e9 19 01 00 00       	jmp    acf0 <fwp_rc_wide_drop>
    abd7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    abde:	00 00 

000000000000abe0 <fwp_rc_free_arr>:
    abe0:	48 89 f8             	mov    %rdi,%rax
    abe3:	48 2b 05 ae 95 00 00 	sub    0x95ae(%rip),%rax        # 14198 <fwp_gc+0x1030>
    abea:	48 8b 0d cf 95 00 00 	mov    0x95cf(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    abf1:	48 c1 e1 10          	shl    $0x10,%rcx
    abf5:	48 39 c8             	cmp    %rcx,%rax
    abf8:	0f 83 e9 00 00 00    	jae    ace7 <fwp_rc_free_arr+0x107>
    abfe:	53                   	push   %rbx
    abff:	48 8b 0d da 95 00 00 	mov    0x95da(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    ac06:	48 89 c2             	mov    %rax,%rdx
    ac09:	48 c1 ea 10          	shr    $0x10,%rdx
    ac0d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ac14:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ac18:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ac1e:	75 1a                	jne    ac3a <fwp_rc_free_arr+0x5a>
    ac20:	40 80 fe 02          	cmp    $0x2,%sil
    ac24:	75 14                	jne    ac3a <fwp_rc_free_arr+0x5a>
    ac26:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ac2a:	48 05 28 02 00 00    	add    $0x228,%rax
    ac30:	80 38 01             	cmpb   $0x1,(%rax)
    ac33:	74 31                	je     ac66 <fwp_rc_free_arr+0x86>
    ac35:	e9 ac 00 00 00       	jmp    ace6 <fwp_rc_free_arr+0x106>
    ac3a:	40 80 fe 01          	cmp    $0x1,%sil
    ac3e:	0f 85 a2 00 00 00    	jne    ace6 <fwp_rc_free_arr+0x106>
    ac44:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ac48:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ac4c:	48 0f af c1          	imul   %rcx,%rax
    ac50:	48 c1 e8 20          	shr    $0x20,%rax
    ac54:	48 01 f0             	add    %rsi,%rax
    ac57:	48 05 28 02 00 00    	add    $0x228,%rax
    ac5d:	80 38 01             	cmpb   $0x1,(%rax)
    ac60:	0f 85 80 00 00 00    	jne    ace6 <fwp_rc_free_arr+0x106>
    ac66:	8b 0d 1c 9f 00 00    	mov    0x9f1c(%rip),%ecx        # 14b88 <fwp_reuse_verify>
    ac6c:	85 c9                	test   %ecx,%ecx
    ac6e:	78 0d                	js     ac7d <fwp_rc_free_arr+0x9d>
    ac70:	85 c9                	test   %ecx,%ecx
    ac72:	74 47                	je     acbb <fwp_rc_free_arr+0xdb>
    ac74:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    ac7b:	eb 69                	jmp    ace6 <fwp_rc_free_arr+0x106>
    ac7d:	48 89 fb             	mov    %rdi,%rbx
    ac80:	48 8d 3d 02 49 00 00 	lea    0x4902(%rip),%rdi        # f589 <fwp_segv.msg+0x309>
    ac87:	e8 a4 73 ff ff       	call   2030 <getenv@plt>
    ac8c:	31 c9                	xor    %ecx,%ecx
    ac8e:	48 85 c0             	test   %rax,%rax
    ac91:	74 1b                	je     acae <fwp_rc_free_arr+0xce>
    ac93:	80 38 00             	cmpb   $0x0,(%rax)
    ac96:	74 16                	je     acae <fwp_rc_free_arr+0xce>
    ac98:	48 8d 35 6a 4a 00 00 	lea    0x4a6a(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    ac9f:	48 89 c7             	mov    %rax,%rdi
    aca2:	e8 c9 74 ff ff       	call   2170 <strcmp@plt>
    aca7:	31 c9                	xor    %ecx,%ecx
    aca9:	85 c0                	test   %eax,%eax
    acab:	0f 95 c1             	setne  %cl
    acae:	89 0d d4 9e 00 00    	mov    %ecx,0x9ed4(%rip)        # 14b88 <fwp_reuse_verify>
    acb4:	48 89 df             	mov    %rbx,%rdi
    acb7:	85 c9                	test   %ecx,%ecx
    acb9:	75 b9                	jne    ac74 <fwp_rc_free_arr+0x94>
    acbb:	48 8b 1d a6 84 00 00 	mov    0x84a6(%rip),%rbx        # 13168 <fwp_gc>
    acc2:	e8 b9 00 00 00       	call   ad80 <fwp_mem_free>
    acc7:	48 8b 05 9a 84 00 00 	mov    0x849a(%rip),%rax        # 13168 <fwp_gc>
    acce:	48 29 d8             	sub    %rbx,%rax
    acd1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    acd6:	f2 0f 58 05 92 96 00 	addsd  0x9692(%rip),%xmm0        # 14370 <fwp_gc+0x1208>
    acdd:	00 
    acde:	f2 0f 11 05 8a 96 00 	movsd  %xmm0,0x968a(%rip)        # 14370 <fwp_gc+0x1208>
    ace5:	00 
    ace6:	5b                   	pop    %rbx
    ace7:	c3                   	ret
    ace8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    acef:	00 

000000000000acf0 <fwp_rc_wide_drop>:
    acf0:	53                   	push   %rbx
    acf1:	48 89 f8             	mov    %rdi,%rax
    acf4:	48 c1 e8 11          	shr    $0x11,%rax
    acf8:	31 f8                	xor    %edi,%eax
    acfa:	89 c1                	mov    %eax,%ecx
    acfc:	c1 e9 09             	shr    $0x9,%ecx
    acff:	31 c1                	xor    %eax,%ecx
    ad01:	0f b6 c1             	movzbl %cl,%eax
    ad04:	48 8d 0d 5d 84 00 00 	lea    0x845d(%rip),%rcx        # 13168 <fwp_gc>
    ad0b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    ad12:	00 
    ad13:	48 85 c0             	test   %rax,%rax
    ad16:	74 16                	je     ad2e <fwp_rc_wide_drop+0x3e>
    ad18:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ad1f:	00 
    ad20:	48 39 38             	cmp    %rdi,(%rax)
    ad23:	74 37                	je     ad5c <fwp_rc_wide_drop+0x6c>
    ad25:	48 8b 40 10          	mov    0x10(%rax),%rax
    ad29:	48 85 c0             	test   %rax,%rax
    ad2c:	75 f2                	jne    ad20 <fwp_rc_wide_drop+0x30>
    ad2e:	e8 6d bd ff ff       	call   6aa0 <fwp_flush>
    ad33:	48 8b 05 a6 82 00 00 	mov    0x82a6(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    ad3a:	48 8b 38             	mov    (%rax),%rdi
    ad3d:	48 8d 35 89 47 00 00 	lea    0x4789(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    ad44:	48 8d 15 91 47 00 00 	lea    0x4791(%rip),%rdx        # f4dc <fwp_segv.msg+0x25c>
    ad4b:	31 c0                	xor    %eax,%eax
    ad4d:	e8 4e 74 ff ff       	call   21a0 <fprintf@plt>
    ad52:	bf 65 00 00 00       	mov    $0x65,%edi
    ad57:	e8 14 75 ff ff       	call   2270 <exit@plt>
    ad5c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    ad60:	48 ff c9             	dec    %rcx
    ad63:	48 89 48 08          	mov    %rcx,0x8(%rax)
    ad67:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    ad6e:	75 0b                	jne    ad7b <fwp_rc_wide_drop+0x8b>
    ad70:	48 89 fb             	mov    %rdi,%rbx
    ad73:	e8 58 bd ff ff       	call   6ad0 <fwp_rc_forget_slot>
    ad78:	c6 03 fe             	movb   $0xfe,(%rbx)
    ad7b:	5b                   	pop    %rbx
    ad7c:	c3                   	ret
    ad7d:	0f 1f 00             	nopl   (%rax)

000000000000ad80 <fwp_mem_free>:
    ad80:	48 85 ff             	test   %rdi,%rdi
    ad83:	0f 84 17 02 00 00    	je     afa0 <fwp_mem_free+0x220>
    ad89:	48 8b 05 08 94 00 00 	mov    0x9408(%rip),%rax        # 14198 <fwp_gc+0x1030>
    ad90:	48 89 f9             	mov    %rdi,%rcx
    ad93:	48 29 c1             	sub    %rax,%rcx
    ad96:	48 8b 15 23 94 00 00 	mov    0x9423(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    ad9d:	48 c1 e2 10          	shl    $0x10,%rdx
    ada1:	48 39 d1             	cmp    %rdx,%rcx
    ada4:	0f 83 f6 01 00 00    	jae    afa0 <fwp_mem_free+0x220>
    adaa:	41 57                	push   %r15
    adac:	41 56                	push   %r14
    adae:	41 55                	push   %r13
    adb0:	41 54                	push   %r12
    adb2:	53                   	push   %rbx
    adb3:	4c 8b 25 26 94 00 00 	mov    0x9426(%rip),%r12        # 141e0 <fwp_gc+0x1078>
    adba:	4d 85 e4             	test   %r12,%r12
    adbd:	0f 84 d4 01 00 00    	je     af97 <fwp_mem_free+0x217>
    adc3:	49 89 cf             	mov    %rcx,%r15
    adc6:	49 c1 ef 10          	shr    $0x10,%r15
    adca:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    add1:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    add6:	83 fa 02             	cmp    $0x2,%edx
    add9:	0f 84 b9 00 00 00    	je     ae98 <fwp_mem_free+0x118>
    addf:	83 fa 01             	cmp    $0x1,%edx
    ade2:	0f 85 af 01 00 00    	jne    af97 <fwp_mem_free+0x217>
    ade8:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    adee:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    adf4:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    adf9:	0f b7 c7             	movzwl %di,%eax
    adfc:	31 d2                	xor    %edx,%edx
    adfe:	f7 f6                	div    %esi
    ae00:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    ae07:	89 c1                	mov    %eax,%ecx
    ae09:	48 d3 c2             	rol    %cl,%rdx
    ae0c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    ae10:	41 89 c2             	mov    %eax,%r10d
    ae13:	41 c1 ea 03          	shr    $0x3,%r10d
    ae17:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    ae1e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    ae23:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    ae2a:	4c 8d 3d 37 83 00 00 	lea    0x8337(%rip),%r15        # 13168 <fwp_gc>
    ae31:	49 01 d7             	add    %rdx,%r15
    ae34:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    ae38:	4d 01 e6             	add    %r12,%r14
    ae3b:	49 83 c6 08          	add    $0x8,%r14
    ae3f:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    ae43:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ae4a:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    ae51:	ff 
    ae52:	0f 84 49 01 00 00    	je     afa1 <fwp_mem_free+0x221>
    ae58:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    ae5c:	49 83 c7 08          	add    $0x8,%r15
    ae60:	c6 03 00             	movb   $0x0,(%rbx)
    ae63:	83 3d 02 93 00 00 00 	cmpl   $0x0,0x9302(%rip)        # 1416c <fwp_gc+0x1004>
    ae6a:	74 12                	je     ae7e <fwp_mem_free+0xfe>
    ae6c:	89 f2                	mov    %esi,%edx
    ae6e:	48 89 fb             	mov    %rdi,%rbx
    ae71:	31 f6                	xor    %esi,%esi
    ae73:	e8 a8 72 ff ff       	call   2120 <memset@plt>
    ae78:	48 89 df             	mov    %rbx,%rdi
    ae7b:	41 8b 36             	mov    (%r14),%esi
    ae7e:	49 8b 07             	mov    (%r15),%rax
    ae81:	48 f7 d0             	not    %rax
    ae84:	48 89 07             	mov    %rax,(%rdi)
    ae87:	49 89 3f             	mov    %rdi,(%r15)
    ae8a:	89 f0                	mov    %esi,%eax
    ae8c:	48 01 05 d5 82 00 00 	add    %rax,0x82d5(%rip)        # 13168 <fwp_gc>
    ae93:	e9 ff 00 00 00       	jmp    af97 <fwp_mem_free+0x217>
    ae98:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    ae9f:	48 01 c8             	add    %rcx,%rax
    aea2:	48 39 f8             	cmp    %rdi,%rax
    aea5:	0f 85 ec 00 00 00    	jne    af97 <fwp_mem_free+0x217>
    aeab:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    aeb0:	48 01 05 b1 82 00 00 	add    %rax,0x82b1(%rip)        # 13168 <fwp_gc>
    aeb7:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    aebd:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    aec1:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    aec8:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    aecf:	00 ff 
    aed1:	0f 84 e0 00 00 00    	je     afb7 <fwp_mem_free+0x237>
    aed7:	c6 03 00             	movb   $0x0,(%rbx)
    aeda:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    aedf:	48 85 c0             	test   %rax,%rax
    aee2:	0f 84 88 00 00 00    	je     af70 <fwp_mem_free+0x1f0>
    aee8:	48 8b 0d f1 92 00 00 	mov    0x92f1(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    aeef:	89 c2                	mov    %eax,%edx
    aef1:	83 e2 03             	and    $0x3,%edx
    aef4:	83 f8 04             	cmp    $0x4,%eax
    aef7:	73 04                	jae    aefd <fwp_mem_free+0x17d>
    aef9:	31 f6                	xor    %esi,%esi
    aefb:	eb 3b                	jmp    af38 <fwp_mem_free+0x1b8>
    aefd:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    af01:	41 89 c0             	mov    %eax,%r8d
    af04:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    af08:	31 f6                	xor    %esi,%esi
    af0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    af10:	c6 07 00             	movb   $0x0,(%rdi)
    af13:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    af1a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    af21:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    af28:	48 83 c6 04          	add    $0x4,%rsi
    af2c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    af33:	49 39 f0             	cmp    %rsi,%r8
    af36:	75 d8                	jne    af10 <fwp_mem_free+0x190>
    af38:	48 85 d2             	test   %rdx,%rdx
    af3b:	74 33                	je     af70 <fwp_mem_free+0x1f0>
    af3d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    af44:	4c 01 f6             	add    %r14,%rsi
    af47:	48 01 f1             	add    %rsi,%rcx
    af4a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    af51:	31 f6                	xor    %esi,%esi
    af53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    af5a:	84 00 00 00 00 00 
    af60:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    af64:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    af6b:	48 39 f2             	cmp    %rsi,%rdx
    af6e:	75 f0                	jne    af60 <fwp_mem_free+0x1e0>
    af70:	48 01 05 d1 93 00 00 	add    %rax,0x93d1(%rip)        # 14348 <fwp_gc+0x11e0>
    af77:	4c 3b 3d 5a 92 00 00 	cmp    0x925a(%rip),%r15        # 141d8 <fwp_gc+0x1070>
    af7e:	73 07                	jae    af87 <fwp_mem_free+0x207>
    af80:	4c 89 3d 51 92 00 00 	mov    %r15,0x9251(%rip)        # 141d8 <fwp_gc+0x1070>
    af87:	4c 3b 3d 42 92 00 00 	cmp    0x9242(%rip),%r15        # 141d0 <fwp_gc+0x1068>
    af8e:	73 07                	jae    af97 <fwp_mem_free+0x217>
    af90:	4c 89 3d 39 92 00 00 	mov    %r15,0x9239(%rip)        # 141d0 <fwp_gc+0x1068>
    af97:	5b                   	pop    %rbx
    af98:	41 5c                	pop    %r12
    af9a:	41 5d                	pop    %r13
    af9c:	41 5e                	pop    %r14
    af9e:	41 5f                	pop    %r15
    afa0:	c3                   	ret
    afa1:	49 89 fc             	mov    %rdi,%r12
    afa4:	48 89 df             	mov    %rbx,%rdi
    afa7:	e8 24 bb ff ff       	call   6ad0 <fwp_rc_forget_slot>
    afac:	4c 89 e7             	mov    %r12,%rdi
    afaf:	41 8b 36             	mov    (%r14),%esi
    afb2:	e9 a1 fe ff ff       	jmp    ae58 <fwp_mem_free+0xd8>
    afb7:	48 89 df             	mov    %rbx,%rdi
    afba:	e8 11 bb ff ff       	call   6ad0 <fwp_rc_forget_slot>
    afbf:	e9 13 ff ff ff       	jmp    aed7 <fwp_mem_free+0x157>
    afc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    afcb:	00 00 00 00 00 

000000000000afd0 <fwp_rc_free_obj>:
    afd0:	48 89 f8             	mov    %rdi,%rax
    afd3:	48 2b 05 be 91 00 00 	sub    0x91be(%rip),%rax        # 14198 <fwp_gc+0x1030>
    afda:	48 8b 0d df 91 00 00 	mov    0x91df(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    afe1:	48 c1 e1 10          	shl    $0x10,%rcx
    afe5:	48 39 c8             	cmp    %rcx,%rax
    afe8:	0f 83 b8 01 00 00    	jae    b1a6 <fwp_rc_free_obj+0x1d6>
    afee:	55                   	push   %rbp
    afef:	41 57                	push   %r15
    aff1:	41 56                	push   %r14
    aff3:	53                   	push   %rbx
    aff4:	50                   	push   %rax
    aff5:	48 8b 1d e4 91 00 00 	mov    0x91e4(%rip),%rbx        # 141e0 <fwp_gc+0x1078>
    affc:	48 89 c1             	mov    %rax,%rcx
    afff:	48 c1 e9 10          	shr    $0x10,%rcx
    b003:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    b00a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    b00f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b015:	75 1a                	jne    b031 <fwp_rc_free_obj+0x61>
    b017:	40 80 fd 02          	cmp    $0x2,%bpl
    b01b:	75 14                	jne    b031 <fwp_rc_free_obj+0x61>
    b01d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    b021:	48 05 28 02 00 00    	add    $0x228,%rax
    b027:	80 38 01             	cmpb   $0x1,(%rax)
    b02a:	74 32                	je     b05e <fwp_rc_free_obj+0x8e>
    b02c:	e9 6b 01 00 00       	jmp    b19c <fwp_rc_free_obj+0x1cc>
    b031:	40 80 fd 01          	cmp    $0x1,%bpl
    b035:	0f 85 61 01 00 00    	jne    b19c <fwp_rc_free_obj+0x1cc>
    b03b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    b03f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    b044:	48 0f af c2          	imul   %rdx,%rax
    b048:	48 c1 e8 20          	shr    $0x20,%rax
    b04c:	48 01 c8             	add    %rcx,%rax
    b04f:	48 05 28 02 00 00    	add    $0x228,%rax
    b055:	80 38 01             	cmpb   $0x1,(%rax)
    b058:	0f 85 3e 01 00 00    	jne    b19c <fwp_rc_free_obj+0x1cc>
    b05e:	8b 0d 24 9b 00 00    	mov    0x9b24(%rip),%ecx        # 14b88 <fwp_reuse_verify>
    b064:	85 c9                	test   %ecx,%ecx
    b066:	0f 88 c3 00 00 00    	js     b12f <fwp_rc_free_obj+0x15f>
    b06c:	85 c9                	test   %ecx,%ecx
    b06e:	0f 84 fd 00 00 00    	je     b171 <fwp_rc_free_obj+0x1a1>
    b074:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    b07a:	75 0d                	jne    b089 <fwp_rc_free_obj+0xb9>
    b07c:	40 80 fd 02          	cmp    $0x2,%bpl
    b080:	75 22                	jne    b0a4 <fwp_rc_free_obj+0xd4>
    b082:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    b087:	eb 20                	jmp    b0a9 <fwp_rc_free_obj+0xd9>
    b089:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    b08f:	8b 47 04             	mov    0x4(%rdi),%eax
    b092:	48 85 c0             	test   %rax,%rax
    b095:	0f 84 01 01 00 00    	je     b19c <fwp_rc_free_obj+0x1cc>
    b09b:	83 f8 04             	cmp    $0x4,%eax
    b09e:	73 26                	jae    b0c6 <fwp_rc_free_obj+0xf6>
    b0a0:	31 c9                	xor    %ecx,%ecx
    b0a2:	eb 6a                	jmp    b10e <fwp_rc_free_obj+0x13e>
    b0a4:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    b0a9:	48 89 fb             	mov    %rdi,%rbx
    b0ac:	be dd 00 00 00       	mov    $0xdd,%esi
    b0b1:	e8 6a 70 ff ff       	call   2120 <memset@plt>
    b0b6:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    b0bd:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    b0c1:	e9 d6 00 00 00       	jmp    b19c <fwp_rc_free_obj+0x1cc>
    b0c6:	89 c1                	mov    %eax,%ecx
    b0c8:	83 e1 fc             	and    $0xfffffffc,%ecx
    b0cb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    b0d2:	00 
    b0d3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    b0d7:	31 f6                	xor    %esi,%esi
    b0d9:	66 0f 28 05 0f 40 00 	movapd 0x400f(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    b0e0:	00 
    b0e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0e8:	0f 1f 84 00 00 00 00 
    b0ef:	00 
    b0f0:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    b0f6:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    b0fc:	48 83 c6 20          	add    $0x20,%rsi
    b100:	48 39 f2             	cmp    %rsi,%rdx
    b103:	75 eb                	jne    b0f0 <fwp_rc_free_obj+0x120>
    b105:	48 39 c1             	cmp    %rax,%rcx
    b108:	0f 84 8e 00 00 00    	je     b19c <fwp_rc_free_obj+0x1cc>
    b10e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    b115:	be ad de 
    b118:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b11f:	00 
    b120:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    b125:	48 ff c1             	inc    %rcx
    b128:	48 39 c8             	cmp    %rcx,%rax
    b12b:	75 f3                	jne    b120 <fwp_rc_free_obj+0x150>
    b12d:	eb 6d                	jmp    b19c <fwp_rc_free_obj+0x1cc>
    b12f:	49 89 ff             	mov    %rdi,%r15
    b132:	48 8d 3d 50 44 00 00 	lea    0x4450(%rip),%rdi        # f589 <fwp_segv.msg+0x309>
    b139:	e8 f2 6e ff ff       	call   2030 <getenv@plt>
    b13e:	31 c9                	xor    %ecx,%ecx
    b140:	48 85 c0             	test   %rax,%rax
    b143:	74 1b                	je     b160 <fwp_rc_free_obj+0x190>
    b145:	80 38 00             	cmpb   $0x0,(%rax)
    b148:	74 16                	je     b160 <fwp_rc_free_obj+0x190>
    b14a:	48 8d 35 b8 45 00 00 	lea    0x45b8(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    b151:	48 89 c7             	mov    %rax,%rdi
    b154:	e8 17 70 ff ff       	call   2170 <strcmp@plt>
    b159:	31 c9                	xor    %ecx,%ecx
    b15b:	85 c0                	test   %eax,%eax
    b15d:	0f 95 c1             	setne  %cl
    b160:	89 0d 22 9a 00 00    	mov    %ecx,0x9a22(%rip)        # 14b88 <fwp_reuse_verify>
    b166:	4c 89 ff             	mov    %r15,%rdi
    b169:	85 c9                	test   %ecx,%ecx
    b16b:	0f 85 03 ff ff ff    	jne    b074 <fwp_rc_free_obj+0xa4>
    b171:	48 8b 1d f0 7f 00 00 	mov    0x7ff0(%rip),%rbx        # 13168 <fwp_gc>
    b178:	e8 03 fc ff ff       	call   ad80 <fwp_mem_free>
    b17d:	48 8b 05 e4 7f 00 00 	mov    0x7fe4(%rip),%rax        # 13168 <fwp_gc>
    b184:	48 29 d8             	sub    %rbx,%rax
    b187:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    b18c:	f2 0f 58 05 dc 91 00 	addsd  0x91dc(%rip),%xmm0        # 14370 <fwp_gc+0x1208>
    b193:	00 
    b194:	f2 0f 11 05 d4 91 00 	movsd  %xmm0,0x91d4(%rip)        # 14370 <fwp_gc+0x1208>
    b19b:	00 
    b19c:	48 83 c4 08          	add    $0x8,%rsp
    b1a0:	5b                   	pop    %rbx
    b1a1:	41 5e                	pop    %r14
    b1a3:	41 5f                	pop    %r15
    b1a5:	5d                   	pop    %rbp
    b1a6:	c3                   	ret
    b1a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b1ae:	00 00 

000000000000b1b0 <fwp_owned_entry49>:
    b1b0:	48 8b 3f             	mov    (%rdi),%rdi
    b1b3:	e9 f8 f4 ff ff       	jmp    a6b0 <f49>
    b1b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b1bf:	00 

000000000000b1c0 <fwp_caps49>:
    b1c0:	53                   	push   %rbx
    b1c1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    b1c5:	74 56                	je     b21d <fwp_caps49+0x5d>
    b1c7:	48 89 fb             	mov    %rdi,%rbx
    b1ca:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    b1ce:	85 f6                	test   %esi,%esi
    b1d0:	74 51                	je     b223 <fwp_caps49+0x63>
    b1d2:	48 2b 3d bf 8f 00 00 	sub    0x8fbf(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    b1d9:	48 8b 05 e0 8f 00 00 	mov    0x8fe0(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    b1e0:	48 c1 e0 10          	shl    $0x10,%rax
    b1e4:	48 39 c7             	cmp    %rax,%rdi
    b1e7:	73 38                	jae    b221 <fwp_caps49+0x61>
    b1e9:	48 8b 05 f0 8f 00 00 	mov    0x8ff0(%rip),%rax        # 141e0 <fwp_gc+0x1078>
    b1f0:	48 89 f9             	mov    %rdi,%rcx
    b1f3:	48 c1 e9 10          	shr    $0x10,%rcx
    b1f7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    b1fe:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    b202:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    b209:	75 26                	jne    b231 <fwp_caps49+0x71>
    b20b:	80 fa 02             	cmp    $0x2,%dl
    b20e:	75 21                	jne    b231 <fwp_caps49+0x71>
    b210:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    b214:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b21b:	eb 33                	jmp    b250 <fwp_caps49+0x90>
    b21d:	85 f6                	test   %esi,%esi
    b21f:	74 0a                	je     b22b <fwp_caps49+0x6b>
    b221:	5b                   	pop    %rbx
    b222:	c3                   	ret
    b223:	e8 08 f7 ff ff       	call   a930 <fwp_drop6>
    b228:	48 89 df             	mov    %rbx,%rdi
    b22b:	5b                   	pop    %rbx
    b22c:	e9 9f fd ff ff       	jmp    afd0 <fwp_rc_free_obj>
    b231:	80 fa 01             	cmp    $0x1,%dl
    b234:	75 eb                	jne    b221 <fwp_caps49+0x61>
    b236:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    b23a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    b23e:	48 0f af f8          	imul   %rax,%rdi
    b242:	48 c1 ef 20          	shr    $0x20,%rdi
    b246:	48 01 d7             	add    %rdx,%rdi
    b249:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b250:	0f b6 07             	movzbl (%rdi),%eax
    b253:	84 c0                	test   %al,%al
    b255:	74 ca                	je     b221 <fwp_caps49+0x61>
    b257:	3c fe                	cmp    $0xfe,%al
    b259:	73 06                	jae    b261 <fwp_caps49+0xa1>
    b25b:	fe c0                	inc    %al
    b25d:	88 07                	mov    %al,(%rdi)
    b25f:	5b                   	pop    %rbx
    b260:	c3                   	ret
    b261:	5b                   	pop    %rbx
    b262:	e9 f9 c9 ff ff       	jmp    7c60 <fwp_rc_wide_dup>
    b267:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b26e:	00 00 

000000000000b270 <fwp_args49>:
    b270:	85 f6                	test   %esi,%esi
    b272:	0f 85 8a 00 00 00    	jne    b302 <fwp_args49+0x92>
    b278:	85 d2                	test   %edx,%edx
    b27a:	0f 84 82 00 00 00    	je     b302 <fwp_args49+0x92>
    b280:	48 8b 07             	mov    (%rdi),%rax
    b283:	48 2b 05 0e 8f 00 00 	sub    0x8f0e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    b28a:	48 8b 0d 2f 8f 00 00 	mov    0x8f2f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    b291:	48 c1 e1 10          	shl    $0x10,%rcx
    b295:	48 39 c8             	cmp    %rcx,%rax
    b298:	73 68                	jae    b302 <fwp_args49+0x92>
    b29a:	48 8b 0d 3f 8f 00 00 	mov    0x8f3f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    b2a1:	48 89 c2             	mov    %rax,%rdx
    b2a4:	48 c1 ea 10          	shr    $0x10,%rdx
    b2a8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b2af:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b2b3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b2b9:	75 13                	jne    b2ce <fwp_args49+0x5e>
    b2bb:	40 80 fe 02          	cmp    $0x2,%sil
    b2bf:	75 0d                	jne    b2ce <fwp_args49+0x5e>
    b2c1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b2c5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b2cc:	eb 21                	jmp    b2ef <fwp_args49+0x7f>
    b2ce:	40 80 fe 01          	cmp    $0x1,%sil
    b2d2:	75 2e                	jne    b302 <fwp_args49+0x92>
    b2d4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b2d8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b2dc:	48 0f af c1          	imul   %rcx,%rax
    b2e0:	48 c1 e8 20          	shr    $0x20,%rax
    b2e4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    b2e8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b2ef:	0f b6 07             	movzbl (%rdi),%eax
    b2f2:	84 c0                	test   %al,%al
    b2f4:	74 0c                	je     b302 <fwp_args49+0x92>
    b2f6:	3c fe                	cmp    $0xfe,%al
    b2f8:	0f 83 62 c9 ff ff    	jae    7c60 <fwp_rc_wide_dup>
    b2fe:	fe c0                	inc    %al
    b300:	88 07                	mov    %al,(%rdi)
    b302:	c3                   	ret
    b303:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b30a:	84 00 00 00 00 00 

000000000000b310 <fwp_arg_drop49>:
    b310:	85 f6                	test   %esi,%esi
    b312:	75 0c                	jne    b320 <fwp_arg_drop49+0x10>
    b314:	85 d2                	test   %edx,%edx
    b316:	74 08                	je     b320 <fwp_arg_drop49+0x10>
    b318:	48 8b 3f             	mov    (%rdi),%rdi
    b31b:	e9 10 f6 ff ff       	jmp    a930 <fwp_drop6>
    b320:	c3                   	ret
    b321:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b328:	0f 1f 84 00 00 00 00 
    b32f:	00 

000000000000b330 <fwp_p_loop_own>:
    b330:	55                   	push   %rbp
    b331:	41 57                	push   %r15
    b333:	41 56                	push   %r14
    b335:	41 55                	push   %r13
    b337:	41 54                	push   %r12
    b339:	53                   	push   %rbx
    b33a:	48 83 ec 28          	sub    $0x28,%rsp
    b33e:	49 89 d7             	mov    %rdx,%r15
    b341:	49 89 f4             	mov    %rsi,%r12
    b344:	49 89 fe             	mov    %rdi,%r14
    b347:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    b34c:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    b351:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    b356:	eb 15                	jmp    b36d <fwp_p_loop_own+0x3d>
    b358:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b35f:	00 
    b360:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    b365:	85 db                	test   %ebx,%ebx
    b367:	0f 85 f6 03 00 00    	jne    b763 <fwp_p_loop_own+0x433>
    b36d:	8b 05 21 a4 00 00    	mov    0xa421(%rip),%eax        # 15794 <fwp_budget>
    b373:	8d 48 ff             	lea    -0x1(%rax),%ecx
    b376:	89 0d 18 a4 00 00    	mov    %ecx,0xa418(%rip)        # 15794 <fwp_budget>
    b37c:	83 f8 01             	cmp    $0x1,%eax
    b37f:	0f 8e bf 03 00 00    	jle    b744 <fwp_p_loop_own+0x414>
    b385:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    b38a:	4c 8b 2d cf a3 00 00 	mov    0xa3cf(%rip),%r13        # 15760 <fwp_fns>
    b391:	41 8b 06             	mov    (%r14),%eax
    b394:	48 c1 e0 05          	shl    $0x5,%rax
    b398:	49 83 7c 05 18 00    	cmpq   $0x0,0x18(%r13,%rax,1)
    b39e:	0f 84 6c 01 00 00    	je     b510 <fwp_p_loop_own+0x1e0>
    b3a4:	4e 8d 04 28          	lea    (%rax,%r13,1),%r8
    b3a8:	49 83 c0 18          	add    $0x18,%r8
    b3ac:	49 01 c5             	add    %rax,%r13
    b3af:	bd 01 00 00 00       	mov    $0x1,%ebp
    b3b4:	31 f6                	xor    %esi,%esi
    b3b6:	4c 89 f0             	mov    %r14,%rax
    b3b9:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
    b3be:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b3c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b3cb:	00 00 00 00 00 
    b3d0:	40 f6 c6 01          	test   $0x1,%sil
    b3d4:	0f 85 86 00 00 00    	jne    b460 <fwp_p_loop_own+0x130>
    b3da:	48 89 c7             	mov    %rax,%rdi
    b3dd:	48 2b 3d b4 8d 00 00 	sub    0x8db4(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    b3e4:	48 8b 0d d5 8d 00 00 	mov    0x8dd5(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    b3eb:	48 c1 e1 10          	shl    $0x10,%rcx
    b3ef:	48 39 cf             	cmp    %rcx,%rdi
    b3f2:	73 6c                	jae    b460 <fwp_p_loop_own+0x130>
    b3f4:	48 8b 0d e5 8d 00 00 	mov    0x8de5(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    b3fb:	48 89 fa             	mov    %rdi,%rdx
    b3fe:	48 c1 ea 10          	shr    $0x10,%rdx
    b402:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b409:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b40d:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    b414:	75 13                	jne    b429 <fwp_p_loop_own+0xf9>
    b416:	40 80 fe 02          	cmp    $0x2,%sil
    b41a:	75 0d                	jne    b429 <fwp_p_loop_own+0xf9>
    b41c:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b420:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b427:	eb 20                	jmp    b449 <fwp_p_loop_own+0x119>
    b429:	40 80 fe 01          	cmp    $0x1,%sil
    b42d:	75 31                	jne    b460 <fwp_p_loop_own+0x130>
    b42f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b433:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b437:	48 0f af f9          	imul   %rcx,%rdi
    b43b:	48 c1 ef 20          	shr    $0x20,%rdi
    b43f:	48 01 f7             	add    %rsi,%rdi
    b442:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b449:	0f b6 0f             	movzbl (%rdi),%ecx
    b44c:	84 c9                	test   %cl,%cl
    b44e:	74 10                	je     b460 <fwp_p_loop_own+0x130>
    b450:	80 f9 fe             	cmp    $0xfe,%cl
    b453:	0f 83 9f 00 00 00    	jae    b4f8 <fwp_p_loop_own+0x1c8>
    b459:	fe c1                	inc    %cl
    b45b:	88 0f                	mov    %cl,(%rdi)
    b45d:	0f 1f 00             	nopl   (%rax)
    b460:	41 8b 5d 00          	mov    0x0(%r13),%ebx
    b464:	8b 70 04             	mov    0x4(%rax),%esi
    b467:	29 f3                	sub    %esi,%ebx
    b469:	39 dd                	cmp    %ebx,%ebp
    b46b:	41 89 dd             	mov    %ebx,%r13d
    b46e:	44 0f 42 ed          	cmovb  %ebp,%r13d
    b472:	45 89 ef             	mov    %r13d,%r15d
    b475:	45 39 ee             	cmp    %r13d,%r14d
    b478:	45 0f 42 fe          	cmovb  %r14d,%r15d
    b47c:	73 2d                	jae    b4ab <fwp_p_loop_own+0x17b>
    b47e:	44 89 ea             	mov    %r13d,%edx
    b481:	44 29 fa             	sub    %r15d,%edx
    b484:	4d 8b 00             	mov    (%r8),%r8
    b487:	44 89 f9             	mov    %r15d,%ecx
    b48a:	49 8d 3c cc          	lea    (%r12,%rcx,8),%rdi
    b48e:	44 01 fe             	add    %r15d,%esi
    b491:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    b496:	41 89 ec             	mov    %ebp,%r12d
    b499:	48 89 c5             	mov    %rax,%rbp
    b49c:	41 ff 50 10          	call   *0x10(%r8)
    b4a0:	48 89 e8             	mov    %rbp,%rax
    b4a3:	44 89 e5             	mov    %r12d,%ebp
    b4a6:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    b4ab:	48 89 c7             	mov    %rax,%rdi
    b4ae:	44 89 ee             	mov    %r13d,%esi
    b4b1:	4c 89 e2             	mov    %r12,%rdx
    b4b4:	e8 87 09 00 00       	call   be40 <fwp_apply_owned>
    b4b9:	39 dd                	cmp    %ebx,%ebp
    b4bb:	0f 86 cf 00 00 00    	jbe    b590 <fwp_p_loop_own+0x260>
    b4c1:	44 89 e9             	mov    %r13d,%ecx
    b4c4:	4d 8d 24 cc          	lea    (%r12,%rcx,8),%r12
    b4c8:	44 29 ed             	sub    %r13d,%ebp
    b4cb:	45 29 fe             	sub    %r15d,%r14d
    b4ce:	48 8b 0d 8b a2 00 00 	mov    0xa28b(%rip),%rcx        # 15760 <fwp_fns>
    b4d5:	8b 10                	mov    (%rax),%edx
    b4d7:	48 c1 e2 05          	shl    $0x5,%rdx
    b4db:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    b4df:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    b4e3:	49 83 c0 18          	add    $0x18,%r8
    b4e7:	40 b6 01             	mov    $0x1,%sil
    b4ea:	48 83 7c 11 18 00    	cmpq   $0x0,0x18(%rcx,%rdx,1)
    b4f0:	0f 85 da fe ff ff    	jne    b3d0 <fwp_p_loop_own+0xa0>
    b4f6:	eb 25                	jmp    b51d <fwp_p_loop_own+0x1ed>
    b4f8:	48 89 c3             	mov    %rax,%rbx
    b4fb:	4d 89 c7             	mov    %r8,%r15
    b4fe:	e8 5d c7 ff ff       	call   7c60 <fwp_rc_wide_dup>
    b503:	4d 89 f8             	mov    %r15,%r8
    b506:	48 89 d8             	mov    %rbx,%rax
    b509:	e9 52 ff ff ff       	jmp    b460 <fwp_p_loop_own+0x130>
    b50e:	66 90                	xchg   %ax,%ax
    b510:	bd 01 00 00 00       	mov    $0x1,%ebp
    b515:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
    b51a:	4c 89 f0             	mov    %r14,%rax
    b51d:	4c 8b 1d 74 8c 00 00 	mov    0x8c74(%rip),%r11        # 14198 <fwp_gc+0x1030>
    b524:	48 89 c2             	mov    %rax,%rdx
    b527:	4c 29 da             	sub    %r11,%rdx
    b52a:	48 8b 0d 8f 8c 00 00 	mov    0x8c8f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    b531:	48 c1 e1 10          	shl    $0x10,%rcx
    b535:	48 39 ca             	cmp    %rcx,%rdx
    b538:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    b53d:	0f 83 8d 00 00 00    	jae    b5d0 <fwp_p_loop_own+0x2a0>
    b543:	48 8b 35 96 8c 00 00 	mov    0x8c96(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    b54a:	48 89 d7             	mov    %rdx,%rdi
    b54d:	48 c1 ef 10          	shr    $0x10,%rdi
    b551:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    b558:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    b55d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    b564:	75 34                	jne    b59a <fwp_p_loop_own+0x26a>
    b566:	41 80 f8 02          	cmp    $0x2,%r8b
    b56a:	75 2e                	jne    b59a <fwp_p_loop_own+0x26a>
    b56c:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    b570:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b577:	80 3a 00             	cmpb   $0x0,(%rdx)
    b57a:	74 54                	je     b5d0 <fwp_p_loop_own+0x2a0>
    b57c:	e9 f6 01 00 00       	jmp    b777 <fwp_p_loop_own+0x447>
    b581:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b588:	0f 1f 84 00 00 00 00 
    b58f:	00 
    b590:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    b595:	e9 eb 00 00 00       	jmp    b685 <fwp_p_loop_own+0x355>
    b59a:	41 80 f8 01          	cmp    $0x1,%r8b
    b59e:	75 30                	jne    b5d0 <fwp_p_loop_own+0x2a0>
    b5a0:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    b5a4:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    b5a8:	48 0f af d6          	imul   %rsi,%rdx
    b5ac:	48 c1 ea 20          	shr    $0x20,%rdx
    b5b0:	4c 01 c2             	add    %r8,%rdx
    b5b3:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b5ba:	80 3a 00             	cmpb   $0x0,(%rdx)
    b5bd:	0f 85 b4 01 00 00    	jne    b777 <fwp_p_loop_own+0x447>
    b5c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b5ca:	84 00 00 00 00 00 
    b5d0:	85 ed                	test   %ebp,%ebp
    b5d2:	0f 84 a0 00 00 00    	je     b678 <fwp_p_loop_own+0x348>
    b5d8:	48 8b 15 01 8c 00 00 	mov    0x8c01(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    b5df:	89 ee                	mov    %ebp,%esi
    b5e1:	31 ff                	xor    %edi,%edi
    b5e3:	eb 2b                	jmp    b610 <fwp_p_loop_own+0x2e0>
    b5e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b5ec:	00 00 00 00 
    b5f0:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    b5f4:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    b5fb:	41 80 38 00          	cmpb   $0x0,(%r8)
    b5ff:	74 6f                	je     b670 <fwp_p_loop_own+0x340>
    b601:	e9 71 01 00 00       	jmp    b777 <fwp_p_loop_own+0x447>
    b606:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b60d:	00 00 00 
    b610:	4d 8b 04 fc          	mov    (%r12,%rdi,8),%r8
    b614:	4d 29 d8             	sub    %r11,%r8
    b617:	49 39 c8             	cmp    %rcx,%r8
    b61a:	73 54                	jae    b670 <fwp_p_loop_own+0x340>
    b61c:	4d 89 c1             	mov    %r8,%r9
    b61f:	49 c1 e9 10          	shr    $0x10,%r9
    b623:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    b62a:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    b62f:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    b636:	75 06                	jne    b63e <fwp_p_loop_own+0x30e>
    b638:	41 80 fa 02          	cmp    $0x2,%r10b
    b63c:	74 b2                	je     b5f0 <fwp_p_loop_own+0x2c0>
    b63e:	41 80 fa 01          	cmp    $0x1,%r10b
    b642:	75 2c                	jne    b670 <fwp_p_loop_own+0x340>
    b644:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    b648:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    b64d:	4d 0f af c1          	imul   %r9,%r8
    b651:	49 c1 e8 20          	shr    $0x20,%r8
    b655:	4d 01 d0             	add    %r10,%r8
    b658:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    b65f:	41 80 38 00          	cmpb   $0x0,(%r8)
    b663:	0f 85 0e 01 00 00    	jne    b777 <fwp_p_loop_own+0x447>
    b669:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b670:	48 ff c7             	inc    %rdi
    b673:	48 39 fe             	cmp    %rdi,%rsi
    b676:	75 98                	jne    b610 <fwp_p_loop_own+0x2e0>
    b678:	48 89 c7             	mov    %rax,%rdi
    b67b:	89 ee                	mov    %ebp,%esi
    b67d:	4c 89 e2             	mov    %r12,%rdx
    b680:	e8 5b 02 00 00       	call   b8e0 <fwp_apply>
    b685:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    b68b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    b690:	77 0e                	ja     b6a0 <fwp_p_loop_own+0x370>
    b692:	89 c3                	mov    %eax,%ebx
    b694:	eb 0c                	jmp    b6a2 <fwp_p_loop_own+0x372>
    b696:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b69d:	00 00 00 
    b6a0:	8b 18                	mov    (%rax),%ebx
    b6a2:	4c 8b 60 08          	mov    0x8(%rax),%r12
    b6a6:	85 db                	test   %ebx,%ebx
    b6a8:	0f 85 82 00 00 00    	jne    b730 <fwp_p_loop_own+0x400>
    b6ae:	4c 89 e7             	mov    %r12,%rdi
    b6b1:	48 2b 3d e0 8a 00 00 	sub    0x8ae0(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    b6b8:	48 8b 0d 01 8b 00 00 	mov    0x8b01(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    b6bf:	48 c1 e1 10          	shl    $0x10,%rcx
    b6c3:	48 39 cf             	cmp    %rcx,%rdi
    b6c6:	73 68                	jae    b730 <fwp_p_loop_own+0x400>
    b6c8:	48 8b 0d 11 8b 00 00 	mov    0x8b11(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    b6cf:	48 89 fa             	mov    %rdi,%rdx
    b6d2:	48 c1 ea 10          	shr    $0x10,%rdx
    b6d6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b6dd:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b6e1:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    b6e8:	75 13                	jne    b6fd <fwp_p_loop_own+0x3cd>
    b6ea:	40 80 fe 02          	cmp    $0x2,%sil
    b6ee:	75 0d                	jne    b6fd <fwp_p_loop_own+0x3cd>
    b6f0:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b6f4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b6fb:	eb 20                	jmp    b71d <fwp_p_loop_own+0x3ed>
    b6fd:	40 80 fe 01          	cmp    $0x1,%sil
    b701:	75 2d                	jne    b730 <fwp_p_loop_own+0x400>
    b703:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b707:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b70b:	48 0f af f9          	imul   %rcx,%rdi
    b70f:	48 c1 ef 20          	shr    $0x20,%rdi
    b713:	48 01 f7             	add    %rsi,%rdi
    b716:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b71d:	0f b6 0f             	movzbl (%rdi),%ecx
    b720:	84 c9                	test   %cl,%cl
    b722:	74 0c                	je     b730 <fwp_p_loop_own+0x400>
    b724:	80 f9 fe             	cmp    $0xfe,%cl
    b727:	73 25                	jae    b74e <fwp_p_loop_own+0x41e>
    b729:	fe c1                	inc    %cl
    b72b:	88 0f                	mov    %cl,(%rdi)
    b72d:	0f 1f 00             	nopl   (%rax)
    b730:	4d 85 ff             	test   %r15,%r15
    b733:	0f 84 27 fc ff ff    	je     b360 <fwp_p_loop_own+0x30>
    b739:	48 89 c7             	mov    %rax,%rdi
    b73c:	41 ff d7             	call   *%r15
    b73f:	e9 1c fc ff ff       	jmp    b360 <fwp_p_loop_own+0x30>
    b744:	e8 27 01 00 00       	call   b870 <fwp_preempt>
    b749:	e9 37 fc ff ff       	jmp    b385 <fwp_p_loop_own+0x55>
    b74e:	49 89 c5             	mov    %rax,%r13
    b751:	e8 0a c5 ff ff       	call   7c60 <fwp_rc_wide_dup>
    b756:	4c 89 e8             	mov    %r13,%rax
    b759:	4d 85 ff             	test   %r15,%r15
    b75c:	75 db                	jne    b739 <fwp_p_loop_own+0x409>
    b75e:	e9 fd fb ff ff       	jmp    b360 <fwp_p_loop_own+0x30>
    b763:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b768:	48 83 c4 28          	add    $0x28,%rsp
    b76c:	5b                   	pop    %rbx
    b76d:	41 5c                	pop    %r12
    b76f:	41 5d                	pop    %r13
    b771:	41 5e                	pop    %r14
    b773:	41 5f                	pop    %r15
    b775:	5d                   	pop    %rbp
    b776:	c3                   	ret
    b777:	e8 24 b3 ff ff       	call   6aa0 <fwp_flush>
    b77c:	48 8b 05 5d 78 00 00 	mov    0x785d(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    b783:	48 8b 38             	mov    (%rax),%rdi
    b786:	48 8d 35 40 3d 00 00 	lea    0x3d40(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    b78d:	48 8d 15 0c 3d 00 00 	lea    0x3d0c(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    b794:	31 c0                	xor    %eax,%eax
    b796:	e8 05 6a ff ff       	call   21a0 <fprintf@plt>
    b79b:	bf 65 00 00 00       	mov    $0x65,%edi
    b7a0:	e8 cb 6a ff ff       	call   2270 <exit@plt>
    b7a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b7ac:	00 00 00 00 

000000000000b7b0 <fwp_drop7>:
    b7b0:	48 89 f8             	mov    %rdi,%rax
    b7b3:	48 2b 05 de 89 00 00 	sub    0x89de(%rip),%rax        # 14198 <fwp_gc+0x1030>
    b7ba:	48 8b 0d ff 89 00 00 	mov    0x89ff(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    b7c1:	48 c1 e1 10          	shl    $0x10,%rcx
    b7c5:	48 39 c8             	cmp    %rcx,%rax
    b7c8:	0f 83 92 00 00 00    	jae    b860 <fwp_drop7+0xb0>
    b7ce:	48 8b 0d 0b 8a 00 00 	mov    0x8a0b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    b7d5:	48 89 c2             	mov    %rax,%rdx
    b7d8:	48 c1 ea 10          	shr    $0x10,%rdx
    b7dc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b7e3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b7e7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b7ed:	75 12                	jne    b801 <fwp_drop7+0x51>
    b7ef:	40 80 fe 02          	cmp    $0x2,%sil
    b7f3:	75 0c                	jne    b801 <fwp_drop7+0x51>
    b7f5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    b7f9:	48 05 28 02 00 00    	add    $0x228,%rax
    b7ff:	eb 1f                	jmp    b820 <fwp_drop7+0x70>
    b801:	40 80 fe 01          	cmp    $0x1,%sil
    b805:	75 59                	jne    b860 <fwp_drop7+0xb0>
    b807:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b80b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b80f:	48 0f af c1          	imul   %rcx,%rax
    b813:	48 c1 e8 20          	shr    $0x20,%rax
    b817:	48 01 f0             	add    %rsi,%rax
    b81a:	48 05 28 02 00 00    	add    $0x228,%rax
    b820:	0f b6 08             	movzbl (%rax),%ecx
    b823:	85 c9                	test   %ecx,%ecx
    b825:	74 39                	je     b860 <fwp_drop7+0xb0>
    b827:	83 f9 01             	cmp    $0x1,%ecx
    b82a:	75 28                	jne    b854 <fwp_drop7+0xa4>
    b82c:	8b 07                	mov    (%rdi),%eax
    b82e:	83 f8 01             	cmp    $0x1,%eax
    b831:	0f 84 99 f7 ff ff    	je     afd0 <fwp_rc_free_obj>
    b837:	85 c0                	test   %eax,%eax
    b839:	75 25                	jne    b860 <fwp_drop7+0xb0>
    b83b:	53                   	push   %rbx
    b83c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    b840:	48 89 fb             	mov    %rdi,%rbx
    b843:	48 89 c7             	mov    %rax,%rdi
    b846:	e8 e5 f0 ff ff       	call   a930 <fwp_drop6>
    b84b:	48 89 df             	mov    %rbx,%rdi
    b84e:	5b                   	pop    %rbx
    b84f:	e9 7c f7 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    b854:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    b85a:	74 05                	je     b861 <fwp_drop7+0xb1>
    b85c:	fe c9                	dec    %cl
    b85e:	88 08                	mov    %cl,(%rax)
    b860:	c3                   	ret
    b861:	48 89 c7             	mov    %rax,%rdi
    b864:	e9 87 f4 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    b869:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b870 <fwp_preempt>:
    b870:	8b 0d 22 9f 00 00    	mov    0x9f22(%rip),%ecx        # 15798 <fwp_slice>
    b876:	85 c9                	test   %ecx,%ecx
    b878:	74 07                	je     b881 <fwp_preempt+0x11>
    b87a:	89 0d 14 9f 00 00    	mov    %ecx,0x9f14(%rip)        # 15794 <fwp_budget>
    b880:	c3                   	ret
    b881:	50                   	push   %rax
    b882:	48 8d 3d c7 3e 00 00 	lea    0x3ec7(%rip),%rdi        # f750 <fwp_segv.msg+0x4d0>
    b889:	e8 a2 67 ff ff       	call   2030 <getenv@plt>
    b88e:	48 89 c7             	mov    %rax,%rdi
    b891:	b8 10 27 00 00       	mov    $0x2710,%eax
    b896:	48 85 ff             	test   %rdi,%rdi
    b899:	74 11                	je     b8ac <fwp_preempt+0x3c>
    b89b:	80 3f 00             	cmpb   $0x0,(%rdi)
    b89e:	74 0c                	je     b8ac <fwp_preempt+0x3c>
    b8a0:	31 f6                	xor    %esi,%esi
    b8a2:	ba 0a 00 00 00       	mov    $0xa,%edx
    b8a7:	e8 e4 68 ff ff       	call   2190 <strtoll@plt>
    b8ac:	48 8d 88 00 00 00 80 	lea    -0x80000000(%rax),%rcx
    b8b3:	48 81 f9 01 00 00 80 	cmp    $0xffffffff80000001,%rcx
    b8ba:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b8bf:	0f 43 c8             	cmovae %eax,%ecx
    b8c2:	89 0d d0 9e 00 00    	mov    %ecx,0x9ed0(%rip)        # 15798 <fwp_slice>
    b8c8:	48 83 c4 08          	add    $0x8,%rsp
    b8cc:	89 0d c2 9e 00 00    	mov    %ecx,0x9ec2(%rip)        # 15794 <fwp_budget>
    b8d2:	c3                   	ret
    b8d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b8da:	84 00 00 00 00 00 

000000000000b8e0 <fwp_apply>:
    b8e0:	55                   	push   %rbp
    b8e1:	48 89 e5             	mov    %rsp,%rbp
    b8e4:	41 57                	push   %r15
    b8e6:	41 56                	push   %r14
    b8e8:	41 55                	push   %r13
    b8ea:	41 54                	push   %r12
    b8ec:	53                   	push   %rbx
    b8ed:	48 83 ec 18          	sub    $0x18,%rsp
    b8f1:	48 89 d3             	mov    %rdx,%rbx
    b8f4:	49 89 ff             	mov    %rdi,%r15
    b8f7:	eb 23                	jmp    b91c <fwp_apply+0x3c>
    b8f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b900:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b904:	31 c9                	xor    %ecx,%ecx
    b906:	49 89 c7             	mov    %rax,%r15
    b909:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b90d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b911:	89 d6                	mov    %edx,%esi
    b913:	83 f9 01             	cmp    $0x1,%ecx
    b916:	0f 84 aa 04 00 00    	je     bdc6 <fwp_apply+0x4e6>
    b91c:	48 8b 05 3d 9e 00 00 	mov    0x9e3d(%rip),%rax        # 15760 <fwp_fns>
    b923:	41 8b 0f             	mov    (%r15),%ecx
    b926:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    b92a:	48 c1 e1 05          	shl    $0x5,%rcx
    b92e:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    b932:	4d 85 ed             	test   %r13,%r13
    b935:	75 39                	jne    b970 <fwp_apply+0x90>
    b937:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    b93c:	39 f2                	cmp    %esi,%edx
    b93e:	73 30                	jae    b970 <fwp_apply+0x90>
    b940:	48 89 df             	mov    %rbx,%rdi
    b943:	49 89 f7             	mov    %rsi,%r15
    b946:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b94a:	4c 89 fe             	mov    %r15,%rsi
    b94d:	49 89 c7             	mov    %rax,%r15
    b950:	44 39 e6             	cmp    %r12d,%esi
    b953:	0f 84 a4 02 00 00    	je     bbfd <fwp_apply+0x31d>
    b959:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    b95d:	44 29 e6             	sub    %r12d,%esi
    b960:	b9 03 00 00 00       	mov    $0x3,%ecx
    b965:	83 f9 01             	cmp    $0x1,%ecx
    b968:	75 b2                	jne    b91c <fwp_apply+0x3c>
    b96a:	e9 57 04 00 00       	jmp    bdc6 <fwp_apply+0x4e6>
    b96f:	90                   	nop
    b970:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b974:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    b978:	45 39 e6             	cmp    %r12d,%r14d
    b97b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b97f:	0f 82 1a 02 00 00    	jb     bb9f <fwp_apply+0x2bf>
    b985:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b989:	45 89 e3             	mov    %r12d,%r11d
    b98c:	41 83 fc 02          	cmp    $0x2,%r12d
    b990:	ba 01 00 00 00       	mov    $0x1,%edx
    b995:	41 0f 43 d4          	cmovae %r12d,%edx
    b999:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b9a0:	00 
    b9a1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b9a5:	48 89 e7             	mov    %rsp,%rdi
    b9a8:	48 29 d7             	sub    %rdx,%rdi
    b9ab:	48 89 fc             	mov    %rdi,%rsp
    b9ae:	4d 85 ed             	test   %r13,%r13
    b9b1:	0f 84 c9 00 00 00    	je     ba80 <fwp_apply+0x1a0>
    b9b7:	41 83 fd 04          	cmp    $0x4,%r13d
    b9bb:	72 10                	jb     b9cd <fwp_apply+0xed>
    b9bd:	48 89 fa             	mov    %rdi,%rdx
    b9c0:	4c 29 fa             	sub    %r15,%rdx
    b9c3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b9c7:	48 83 fa 20          	cmp    $0x20,%rdx
    b9cb:	73 65                	jae    ba32 <fwp_apply+0x152>
    b9cd:	31 d2                	xor    %edx,%edx
    b9cf:	4d 89 e8             	mov    %r13,%r8
    b9d2:	49 89 d2             	mov    %rdx,%r10
    b9d5:	49 83 e0 03          	and    $0x3,%r8
    b9d9:	74 16                	je     b9f1 <fwp_apply+0x111>
    b9db:	49 89 d2             	mov    %rdx,%r10
    b9de:	66 90                	xchg   %ax,%ax
    b9e0:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    b9e5:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b9e9:	49 ff c2             	inc    %r10
    b9ec:	49 ff c8             	dec    %r8
    b9ef:	75 ef                	jne    b9e0 <fwp_apply+0x100>
    b9f1:	4c 29 ea             	sub    %r13,%rdx
    b9f4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b9f8:	0f 87 82 00 00 00    	ja     ba80 <fwp_apply+0x1a0>
    b9fe:	66 90                	xchg   %ax,%ax
    ba00:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    ba05:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    ba09:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    ba0e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    ba13:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    ba18:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    ba1d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    ba22:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    ba27:	49 83 c2 04          	add    $0x4,%r10
    ba2b:	4d 39 d5             	cmp    %r10,%r13
    ba2e:	75 d0                	jne    ba00 <fwp_apply+0x120>
    ba30:	eb 4e                	jmp    ba80 <fwp_apply+0x1a0>
    ba32:	44 89 ea             	mov    %r13d,%edx
    ba35:	83 e2 fc             	and    $0xfffffffc,%edx
    ba38:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    ba3f:	00 
    ba40:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    ba44:	45 31 c0             	xor    %r8d,%r8d
    ba47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ba4e:	00 00 
    ba50:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    ba56:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    ba5c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    ba61:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    ba67:	49 83 c0 20          	add    $0x20,%r8
    ba6b:	4d 39 c1             	cmp    %r8,%r9
    ba6e:	75 e0                	jne    ba50 <fwp_apply+0x170>
    ba70:	4c 39 ea             	cmp    %r13,%rdx
    ba73:	0f 85 56 ff ff ff    	jne    b9cf <fwp_apply+0xef>
    ba79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ba80:	45 29 eb             	sub    %r13d,%r11d
    ba83:	45 89 de             	mov    %r11d,%r14d
    ba86:	45 39 ec             	cmp    %r13d,%r12d
    ba89:	0f 84 85 00 00 00    	je     bb14 <fwp_apply+0x234>
    ba8f:	41 83 fb 0e          	cmp    $0xe,%r11d
    ba93:	0f 83 a0 00 00 00    	jae    bb39 <fwp_apply+0x259>
    ba99:	31 d2                	xor    %edx,%edx
    ba9b:	4d 89 f0             	mov    %r14,%r8
    ba9e:	48 89 d6             	mov    %rdx,%rsi
    baa1:	49 83 e0 03          	and    $0x3,%r8
    baa5:	74 1d                	je     bac4 <fwp_apply+0x1e4>
    baa7:	48 89 d6             	mov    %rdx,%rsi
    baaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    bab0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    bab4:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    bab8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    babc:	48 ff c6             	inc    %rsi
    babf:	49 ff c8             	dec    %r8
    bac2:	75 ec                	jne    bab0 <fwp_apply+0x1d0>
    bac4:	4c 29 f2             	sub    %r14,%rdx
    bac7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    bacb:	77 47                	ja     bb14 <fwp_apply+0x234>
    bacd:	0f 1f 00             	nopl   (%rax)
    bad0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    bad4:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    bad8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    badc:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    bae1:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    bae5:	41 ff c0             	inc    %r8d
    bae8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    baec:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    baf1:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    baf6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    bafa:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    baff:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    bb03:	41 83 c0 03          	add    $0x3,%r8d
    bb07:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    bb0b:	48 83 c6 04          	add    $0x4,%rsi
    bb0f:	49 39 f6             	cmp    %rsi,%r14
    bb12:	75 bc                	jne    bad0 <fwp_apply+0x1f0>
    bb14:	45 89 dc             	mov    %r11d,%r12d
    bb17:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    bb1b:	b9 01 00 00 00       	mov    $0x1,%ecx
    bb20:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    bb24:	89 f2                	mov    %esi,%edx
    bb26:	44 29 e2             	sub    %r12d,%edx
    bb29:	0f 85 d1 fd ff ff    	jne    b900 <fwp_apply+0x20>
    bb2f:	89 f2                	mov    %esi,%edx
    bb31:	49 89 c6             	mov    %rax,%r14
    bb34:	e9 d4 fd ff ff       	jmp    b90d <fwp_apply+0x2d>
    bb39:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    bb3d:	89 d6                	mov    %edx,%esi
    bb3f:	44 01 ee             	add    %r13d,%esi
    bb42:	0f 82 51 ff ff ff    	jb     ba99 <fwp_apply+0x1b9>
    bb48:	48 c1 ea 20          	shr    $0x20,%rdx
    bb4c:	ba 00 00 00 00       	mov    $0x0,%edx
    bb51:	0f 85 44 ff ff ff    	jne    ba9b <fwp_apply+0x1bb>
    bb57:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    bb5b:	48 29 da             	sub    %rbx,%rdx
    bb5e:	48 83 fa 20          	cmp    $0x20,%rdx
    bb62:	0f 82 31 ff ff ff    	jb     ba99 <fwp_apply+0x1b9>
    bb68:	44 89 f2             	mov    %r14d,%edx
    bb6b:	83 e2 fc             	and    $0xfffffffc,%edx
    bb6e:	31 f6                	xor    %esi,%esi
    bb70:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    bb74:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    bb79:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    bb7d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    bb82:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    bb88:	48 83 c6 04          	add    $0x4,%rsi
    bb8c:	48 39 f2             	cmp    %rsi,%rdx
    bb8f:	75 df                	jne    bb70 <fwp_apply+0x290>
    bb91:	4c 39 f2             	cmp    %r14,%rdx
    bb94:	0f 85 01 ff ff ff    	jne    ba9b <fwp_apply+0x1bb>
    bb9a:	e9 75 ff ff ff       	jmp    bb14 <fwp_apply+0x234>
    bb9f:	44 89 f0             	mov    %r14d,%eax
    bba2:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    bba9:	77 72                	ja     bc1d <fwp_apply+0x33d>
    bbab:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    bbb2:	00 
    bbb3:	48 83 c2 17          	add    $0x17,%rdx
    bbb7:	48 c1 ea 04          	shr    $0x4,%rdx
    bbbb:	48 8d 0d a6 75 00 00 	lea    0x75a6(%rip),%rcx        # 13168 <fwp_gc>
    bbc2:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    bbc9:	00 
    bbca:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    bbd1:	48 29 15 90 75 00 00 	sub    %rdx,0x7590(%rip)        # 13168 <fwp_gc>
    bbd8:	78 43                	js     bc1d <fwp_apply+0x33d>
    bbda:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    bbde:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    bbe2:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    bbe9:	4c 8b 27             	mov    (%rdi),%r12
    bbec:	4d 85 e4             	test   %r12,%r12
    bbef:	74 14                	je     bc05 <fwp_apply+0x325>
    bbf1:	49 8b 04 24          	mov    (%r12),%rax
    bbf5:	48 f7 d0             	not    %rax
    bbf8:	48 89 07             	mov    %rax,(%rdi)
    bbfb:	eb 48                	jmp    bc45 <fwp_apply+0x365>
    bbfd:	4d 89 fe             	mov    %r15,%r14
    bc00:	e9 c1 01 00 00       	jmp    bdc6 <fwp_apply+0x4e6>
    bc05:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    bc0c:	00 
    bc0d:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    bc14:	00 
    bc15:	4c 29 e7             	sub    %r12,%rdi
    bc18:	48 39 d7             	cmp    %rdx,%rdi
    bc1b:	73 17                	jae    bc34 <fwp_apply+0x354>
    bc1d:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    bc24:	00 
    bc25:	be 02 00 00 00       	mov    $0x2,%esi
    bc2a:	e8 11 b3 ff ff       	call   6f40 <fwp_gc_alloc_slow>
    bc2f:	49 89 c4             	mov    %rax,%r12
    bc32:	eb 1b                	jmp    bc4f <fwp_apply+0x36f>
    bc34:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    bc38:	48 05 90 07 00 00    	add    $0x790,%rax
    bc3e:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    bc42:	48 89 08             	mov    %rcx,(%rax)
    bc45:	4c 89 e7             	mov    %r12,%rdi
    bc48:	31 f6                	xor    %esi,%esi
    bc4a:	e8 d1 64 ff ff       	call   2120 <memset@plt>
    bc4f:	41 8b 07             	mov    (%r15),%eax
    bc52:	41 89 04 24          	mov    %eax,(%r12)
    bc56:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    bc5b:	4d 85 ed             	test   %r13,%r13
    bc5e:	4d 89 e6             	mov    %r12,%r14
    bc61:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    bc65:	0f 84 c6 00 00 00    	je     bd31 <fwp_apply+0x451>
    bc6b:	31 c0                	xor    %eax,%eax
    bc6d:	41 83 fd 06          	cmp    $0x6,%r13d
    bc71:	72 53                	jb     bcc6 <fwp_apply+0x3e6>
    bc73:	4c 89 f1             	mov    %r14,%rcx
    bc76:	4c 29 f9             	sub    %r15,%rcx
    bc79:	48 83 f9 20          	cmp    $0x20,%rcx
    bc7d:	72 47                	jb     bcc6 <fwp_apply+0x3e6>
    bc7f:	44 89 e8             	mov    %r13d,%eax
    bc82:	83 e0 fc             	and    $0xfffffffc,%eax
    bc85:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    bc8c:	00 
    bc8d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    bc91:	31 d2                	xor    %edx,%edx
    bc93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bc9a:	84 00 00 00 00 00 
    bca0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    bca6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    bcac:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    bcb2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    bcb8:	48 83 c2 20          	add    $0x20,%rdx
    bcbc:	48 39 d1             	cmp    %rdx,%rcx
    bcbf:	75 df                	jne    bca0 <fwp_apply+0x3c0>
    bcc1:	4c 39 e8             	cmp    %r13,%rax
    bcc4:	74 6b                	je     bd31 <fwp_apply+0x451>
    bcc6:	4c 89 ea             	mov    %r13,%rdx
    bcc9:	48 89 c1             	mov    %rax,%rcx
    bccc:	48 83 e2 03          	and    $0x3,%rdx
    bcd0:	74 20                	je     bcf2 <fwp_apply+0x412>
    bcd2:	48 89 c1             	mov    %rax,%rcx
    bcd5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bcdc:	00 00 00 00 
    bce0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    bce5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    bcea:	48 ff c1             	inc    %rcx
    bced:	48 ff ca             	dec    %rdx
    bcf0:	75 ee                	jne    bce0 <fwp_apply+0x400>
    bcf2:	4c 29 e8             	sub    %r13,%rax
    bcf5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    bcf9:	77 36                	ja     bd31 <fwp_apply+0x451>
    bcfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bd00:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    bd05:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    bd0a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    bd0f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    bd14:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    bd19:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    bd1e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    bd23:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    bd28:	48 83 c1 04          	add    $0x4,%rcx
    bd2c:	49 39 cd             	cmp    %rcx,%r13
    bd2f:	75 cf                	jne    bd00 <fwp_apply+0x420>
    bd31:	85 ff                	test   %edi,%edi
    bd33:	0f 84 8d 00 00 00    	je     bdc6 <fwp_apply+0x4e6>
    bd39:	89 f8                	mov    %edi,%eax
    bd3b:	83 ff 14             	cmp    $0x14,%edi
    bd3e:	0f 83 94 00 00 00    	jae    bdd8 <fwp_apply+0x4f8>
    bd44:	31 c9                	xor    %ecx,%ecx
    bd46:	48 89 c6             	mov    %rax,%rsi
    bd49:	48 89 ca             	mov    %rcx,%rdx
    bd4c:	48 83 e6 03          	and    $0x3,%rsi
    bd50:	74 23                	je     bd75 <fwp_apply+0x495>
    bd52:	48 89 ca             	mov    %rcx,%rdx
    bd55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bd5c:	00 00 00 00 
    bd60:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    bd64:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    bd68:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    bd6d:	48 ff c2             	inc    %rdx
    bd70:	48 ff ce             	dec    %rsi
    bd73:	75 eb                	jne    bd60 <fwp_apply+0x480>
    bd75:	48 29 c1             	sub    %rax,%rcx
    bd78:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bd7c:	77 48                	ja     bdc6 <fwp_apply+0x4e6>
    bd7e:	66 90                	xchg   %ax,%ax
    bd80:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    bd84:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bd88:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bd8d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    bd92:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bd96:	ff c6                	inc    %esi
    bd98:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bd9d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    bda2:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    bda7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bdac:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    bdb1:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bdb5:	83 c6 03             	add    $0x3,%esi
    bdb8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bdbd:	48 83 c2 04          	add    $0x4,%rdx
    bdc1:	48 39 d0             	cmp    %rdx,%rax
    bdc4:	75 ba                	jne    bd80 <fwp_apply+0x4a0>
    bdc6:	4c 89 f0             	mov    %r14,%rax
    bdc9:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    bdcd:	5b                   	pop    %rbx
    bdce:	41 5c                	pop    %r12
    bdd0:	41 5d                	pop    %r13
    bdd2:	41 5e                	pop    %r14
    bdd4:	41 5f                	pop    %r15
    bdd6:	5d                   	pop    %rbp
    bdd7:	c3                   	ret
    bdd8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    bddc:	31 c9                	xor    %ecx,%ecx
    bdde:	89 d6                	mov    %edx,%esi
    bde0:	44 01 ee             	add    %r13d,%esi
    bde3:	0f 82 5d ff ff ff    	jb     bd46 <fwp_apply+0x466>
    bde9:	48 c1 ea 20          	shr    $0x20,%rdx
    bded:	0f 85 53 ff ff ff    	jne    bd46 <fwp_apply+0x466>
    bdf3:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    bdf7:	48 29 d9             	sub    %rbx,%rcx
    bdfa:	48 83 c1 08          	add    $0x8,%rcx
    bdfe:	48 83 f9 20          	cmp    $0x20,%rcx
    be02:	0f 82 3c ff ff ff    	jb     bd44 <fwp_apply+0x464>
    be08:	89 c1                	mov    %eax,%ecx
    be0a:	83 e1 fc             	and    $0xfffffffc,%ecx
    be0d:	31 d2                	xor    %edx,%edx
    be0f:	90                   	nop
    be10:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    be14:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    be19:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    be1d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    be23:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    be29:	48 83 c2 04          	add    $0x4,%rdx
    be2d:	48 39 d1             	cmp    %rdx,%rcx
    be30:	75 de                	jne    be10 <fwp_apply+0x530>
    be32:	48 39 c1             	cmp    %rax,%rcx
    be35:	0f 85 0b ff ff ff    	jne    bd46 <fwp_apply+0x466>
    be3b:	eb 89                	jmp    bdc6 <fwp_apply+0x4e6>
    be3d:	0f 1f 00             	nopl   (%rax)

000000000000be40 <fwp_apply_owned>:
    be40:	55                   	push   %rbp
    be41:	48 89 e5             	mov    %rsp,%rbp
    be44:	41 57                	push   %r15
    be46:	41 56                	push   %r14
    be48:	41 55                	push   %r13
    be4a:	41 54                	push   %r12
    be4c:	53                   	push   %rbx
    be4d:	48 83 ec 28          	sub    $0x28,%rsp
    be51:	48 89 d3             	mov    %rdx,%rbx
    be54:	41 89 f5             	mov    %esi,%r13d
    be57:	48 8b 05 02 99 00 00 	mov    0x9902(%rip),%rax        # 15760 <fwp_fns>
    be5e:	8b 17                	mov    (%rdi),%edx
    be60:	48 89 d6             	mov    %rdx,%rsi
    be63:	48 c1 e6 05          	shl    $0x5,%rsi
    be67:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    be6c:	48 85 c9             	test   %rcx,%rcx
    be6f:	0f 84 ca 02 00 00    	je     c13f <fwp_apply_owned+0x2ff>
    be75:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    be79:	49 83 c0 18          	add    $0x18,%r8
    be7d:	49 89 fc             	mov    %rdi,%r12
    be80:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    be84:	48 c1 e2 05          	shl    $0x5,%rdx
    be88:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    be8b:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    be90:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    be94:	41 39 c7             	cmp    %eax,%r15d
    be97:	0f 82 10 03 00 00    	jb     c1ad <fwp_apply_owned+0x36d>
    be9d:	41 89 c7             	mov    %eax,%r15d
    bea0:	45 29 f7             	sub    %r14d,%r15d
    bea3:	45 89 fa             	mov    %r15d,%r10d
    bea6:	85 c0                	test   %eax,%eax
    bea8:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    beac:	74 22                	je     bed0 <fwp_apply_owned+0x90>
    beae:	45 85 f6             	test   %r14d,%r14d
    beb1:	75 1d                	jne    bed0 <fwp_apply_owned+0x90>
    beb3:	48 89 df             	mov    %rbx,%rdi
    beb6:	ff 11                	call   *(%rcx)
    beb8:	49 89 c4             	mov    %rax,%r12
    bebb:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    bebf:	e9 35 02 00 00       	jmp    c0f9 <fwp_apply_owned+0x2b9>
    bec4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    becb:	00 00 00 00 00 
    bed0:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    bed4:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    bed8:	85 c0                	test   %eax,%eax
    beda:	b9 01 00 00 00       	mov    $0x1,%ecx
    bedf:	0f 45 c8             	cmovne %eax,%ecx
    bee2:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    bee9:	00 
    beea:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    beee:	49 89 e5             	mov    %rsp,%r13
    bef1:	49 29 cd             	sub    %rcx,%r13
    bef4:	4c 89 ec             	mov    %r13,%rsp
    bef7:	4d 85 f6             	test   %r14,%r14
    befa:	0f 84 d0 00 00 00    	je     bfd0 <fwp_apply_owned+0x190>
    bf00:	41 83 fe 04          	cmp    $0x4,%r14d
    bf04:	72 10                	jb     bf16 <fwp_apply_owned+0xd6>
    bf06:	4c 89 e9             	mov    %r13,%rcx
    bf09:	4c 29 e1             	sub    %r12,%rcx
    bf0c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    bf10:	48 83 f9 20          	cmp    $0x20,%rcx
    bf14:	73 6d                	jae    bf83 <fwp_apply_owned+0x143>
    bf16:	31 c9                	xor    %ecx,%ecx
    bf18:	4c 89 f6             	mov    %r14,%rsi
    bf1b:	48 89 ca             	mov    %rcx,%rdx
    bf1e:	48 83 e6 03          	and    $0x3,%rsi
    bf22:	74 1e                	je     bf42 <fwp_apply_owned+0x102>
    bf24:	48 89 ca             	mov    %rcx,%rdx
    bf27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bf2e:	00 00 
    bf30:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    bf35:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    bf3a:	48 ff c2             	inc    %rdx
    bf3d:	48 ff ce             	dec    %rsi
    bf40:	75 ee                	jne    bf30 <fwp_apply_owned+0xf0>
    bf42:	4c 29 f1             	sub    %r14,%rcx
    bf45:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bf49:	0f 87 81 00 00 00    	ja     bfd0 <fwp_apply_owned+0x190>
    bf4f:	90                   	nop
    bf50:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    bf55:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    bf5a:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    bf5f:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    bf64:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    bf69:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    bf6e:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    bf73:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    bf78:	48 83 c2 04          	add    $0x4,%rdx
    bf7c:	49 39 d6             	cmp    %rdx,%r14
    bf7f:	75 cf                	jne    bf50 <fwp_apply_owned+0x110>
    bf81:	eb 4d                	jmp    bfd0 <fwp_apply_owned+0x190>
    bf83:	44 89 f1             	mov    %r14d,%ecx
    bf86:	83 e1 fc             	and    $0xfffffffc,%ecx
    bf89:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    bf90:	00 
    bf91:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    bf95:	31 f6                	xor    %esi,%esi
    bf97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bf9e:	00 00 
    bfa0:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    bfa6:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    bfac:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    bfb2:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    bfb8:	48 83 c6 20          	add    $0x20,%rsi
    bfbc:	48 39 f2             	cmp    %rsi,%rdx
    bfbf:	75 df                	jne    bfa0 <fwp_apply_owned+0x160>
    bfc1:	4c 39 f1             	cmp    %r14,%rcx
    bfc4:	0f 85 4e ff ff ff    	jne    bf18 <fwp_apply_owned+0xd8>
    bfca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    bfd0:	44 39 f0             	cmp    %r14d,%eax
    bfd3:	0f 84 f7 00 00 00    	je     c0d0 <fwp_apply_owned+0x290>
    bfd9:	41 83 ff 0a          	cmp    $0xa,%r15d
    bfdd:	0f 83 95 00 00 00    	jae    c078 <fwp_apply_owned+0x238>
    bfe3:	31 c0                	xor    %eax,%eax
    bfe5:	4c 89 d2             	mov    %r10,%rdx
    bfe8:	48 89 c1             	mov    %rax,%rcx
    bfeb:	48 83 e2 03          	and    $0x3,%rdx
    bfef:	74 24                	je     c015 <fwp_apply_owned+0x1d5>
    bff1:	48 89 c1             	mov    %rax,%rcx
    bff4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bffb:	00 00 00 00 00 
    c000:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    c004:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    c008:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    c00d:	48 ff c1             	inc    %rcx
    c010:	48 ff ca             	dec    %rdx
    c013:	75 eb                	jne    c000 <fwp_apply_owned+0x1c0>
    c015:	4c 29 d0             	sub    %r10,%rax
    c018:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    c01c:	0f 87 ae 00 00 00    	ja     c0d0 <fwp_apply_owned+0x290>
    c022:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c029:	1f 84 00 00 00 00 00 
    c030:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    c034:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    c038:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    c03d:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    c042:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    c046:	ff c2                	inc    %edx
    c048:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    c04d:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    c052:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    c057:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    c05c:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    c061:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    c065:	83 c2 03             	add    $0x3,%edx
    c068:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    c06d:	48 83 c1 04          	add    $0x4,%rcx
    c071:	49 39 ca             	cmp    %rcx,%r10
    c074:	75 ba                	jne    c030 <fwp_apply_owned+0x1f0>
    c076:	eb 58                	jmp    c0d0 <fwp_apply_owned+0x290>
    c078:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    c07c:	89 c1                	mov    %eax,%ecx
    c07e:	44 01 f1             	add    %r14d,%ecx
    c081:	0f 82 5c ff ff ff    	jb     bfe3 <fwp_apply_owned+0x1a3>
    c087:	48 c1 e8 20          	shr    $0x20,%rax
    c08b:	b8 00 00 00 00       	mov    $0x0,%eax
    c090:	0f 85 4f ff ff ff    	jne    bfe5 <fwp_apply_owned+0x1a5>
    c096:	44 89 d0             	mov    %r10d,%eax
    c099:	83 e0 fc             	and    $0xfffffffc,%eax
    c09c:	31 c9                	xor    %ecx,%ecx
    c09e:	66 90                	xchg   %ax,%ax
    c0a0:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    c0a4:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    c0a9:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    c0ad:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    c0b3:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    c0b9:	48 83 c1 04          	add    $0x4,%rcx
    c0bd:	48 39 c8             	cmp    %rcx,%rax
    c0c0:	75 de                	jne    c0a0 <fwp_apply_owned+0x260>
    c0c2:	4c 39 d0             	cmp    %r10,%rax
    c0c5:	0f 85 1a ff ff ff    	jne    bfe5 <fwp_apply_owned+0x1a5>
    c0cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c0d0:	49 8b 00             	mov    (%r8),%rax
    c0d3:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    c0d7:	4c 89 f7             	mov    %r14,%rdi
    c0da:	be 01 00 00 00       	mov    $0x1,%esi
    c0df:	4d 89 c4             	mov    %r8,%r12
    c0e2:	ff 50 08             	call   *0x8(%rax)
    c0e5:	49 8b 04 24          	mov    (%r12),%rax
    c0e9:	4c 89 ef             	mov    %r13,%rdi
    c0ec:	ff 10                	call   *(%rax)
    c0ee:	49 89 c4             	mov    %rax,%r12
    c0f1:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    c0f5:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    c0f9:	4c 89 f7             	mov    %r14,%rdi
    c0fc:	e8 af 05 00 00       	call   c6b0 <fwp_closure_drop>
    c101:	45 29 fd             	sub    %r15d,%r13d
    c104:	0f 84 89 05 00 00    	je     c693 <fwp_apply_owned+0x853>
    c10a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    c10e:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    c112:	48 8b 05 47 96 00 00 	mov    0x9647(%rip),%rax        # 15760 <fwp_fns>
    c119:	41 8b 14 24          	mov    (%r12),%edx
    c11d:	48 89 d1             	mov    %rdx,%rcx
    c120:	48 c1 e1 05          	shl    $0x5,%rcx
    c124:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    c128:	49 83 c0 18          	add    $0x18,%r8
    c12c:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    c131:	4c 89 e7             	mov    %r12,%rdi
    c134:	48 85 c9             	test   %rcx,%rcx
    c137:	0f 85 43 fd ff ff    	jne    be80 <fwp_apply_owned+0x40>
    c13d:	eb 03                	jmp    c142 <fwp_apply_owned+0x302>
    c13f:	49 89 fc             	mov    %rdi,%r12
    c142:	48 8b 05 4f 80 00 00 	mov    0x804f(%rip),%rax        # 14198 <fwp_gc+0x1030>
    c149:	4c 89 e2             	mov    %r12,%rdx
    c14c:	48 29 c2             	sub    %rax,%rdx
    c14f:	48 8b 0d 6a 80 00 00 	mov    0x806a(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    c156:	48 c1 e1 10          	shl    $0x10,%rcx
    c15a:	48 39 ca             	cmp    %rcx,%rdx
    c15d:	0f 83 12 01 00 00    	jae    c275 <fwp_apply_owned+0x435>
    c163:	48 8b 35 76 80 00 00 	mov    0x8076(%rip),%rsi        # 141e0 <fwp_gc+0x1078>
    c16a:	48 89 d7             	mov    %rdx,%rdi
    c16d:	48 c1 ef 10          	shr    $0x10,%rdi
    c171:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    c178:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    c17d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    c184:	0f 85 c2 00 00 00    	jne    c24c <fwp_apply_owned+0x40c>
    c18a:	41 80 f8 02          	cmp    $0x2,%r8b
    c18e:	0f 85 b8 00 00 00    	jne    c24c <fwp_apply_owned+0x40c>
    c194:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    c198:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    c19f:	80 3a 00             	cmpb   $0x0,(%rdx)
    c1a2:	0f 84 cd 00 00 00    	je     c275 <fwp_apply_owned+0x435>
    c1a8:	e9 55 01 00 00       	jmp    c302 <fwp_apply_owned+0x4c2>
    c1ad:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    c1b1:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    c1b5:	44 89 f9             	mov    %r15d,%ecx
    c1b8:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    c1bf:	00 
    c1c0:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    c1c7:	0f 87 f0 01 00 00    	ja     c3bd <fwp_apply_owned+0x57d>
    c1cd:	48 c1 e1 03          	shl    $0x3,%rcx
    c1d1:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    c1d5:	49 c1 e8 04          	shr    $0x4,%r8
    c1d9:	48 8d 05 88 6f 00 00 	lea    0x6f88(%rip),%rax        # 13168 <fwp_gc>
    c1e0:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    c1e7:	00 00 
    c1e9:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    c1f0:	4c 8b 0d 71 6f 00 00 	mov    0x6f71(%rip),%r9        # 13168 <fwp_gc>
    c1f7:	4d 89 ca             	mov    %r9,%r10
    c1fa:	49 29 d2             	sub    %rdx,%r10
    c1fd:	4c 89 15 64 6f 00 00 	mov    %r10,0x6f64(%rip)        # 13168 <fwp_gc>
    c204:	0f 88 b3 01 00 00    	js     c3bd <fwp_apply_owned+0x57d>
    c20a:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    c20e:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    c212:	49 83 c3 08          	add    $0x8,%r11
    c216:	4d 8b 2b             	mov    (%r11),%r13
    c219:	4d 85 ed             	test   %r13,%r13
    c21c:	0f 84 24 01 00 00    	je     c346 <fwp_apply_owned+0x506>
    c222:	49 8b 45 00          	mov    0x0(%r13),%rax
    c226:	48 f7 d0             	not    %rax
    c229:	49 89 03             	mov    %rax,(%r11)
    c22c:	48 39 d7             	cmp    %rdx,%rdi
    c22f:	0f 83 ad 01 00 00    	jae    c3e2 <fwp_apply_owned+0x5a2>
    c235:	4c 01 ef             	add    %r13,%rdi
    c238:	48 29 ca             	sub    %rcx,%rdx
    c23b:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    c23f:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    c243:	48 83 c2 08          	add    $0x8,%rdx
    c247:	e9 8f 01 00 00       	jmp    c3db <fwp_apply_owned+0x59b>
    c24c:	41 80 f8 01          	cmp    $0x1,%r8b
    c250:	75 23                	jne    c275 <fwp_apply_owned+0x435>
    c252:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    c256:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    c25a:	48 0f af d6          	imul   %rsi,%rdx
    c25e:	48 c1 ea 20          	shr    $0x20,%rdx
    c262:	4c 01 c2             	add    %r8,%rdx
    c265:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    c26c:	80 3a 00             	cmpb   $0x0,(%rdx)
    c26f:	0f 85 8d 00 00 00    	jne    c302 <fwp_apply_owned+0x4c2>
    c275:	45 85 ed             	test   %r13d,%r13d
    c278:	0f 84 b2 00 00 00    	je     c330 <fwp_apply_owned+0x4f0>
    c27e:	48 8b 15 5b 7f 00 00 	mov    0x7f5b(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    c285:	44 89 ee             	mov    %r13d,%esi
    c288:	31 ff                	xor    %edi,%edi
    c28a:	eb 21                	jmp    c2ad <fwp_apply_owned+0x46d>
    c28c:	0f 1f 40 00          	nopl   0x0(%rax)
    c290:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    c294:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    c29b:	41 80 38 00          	cmpb   $0x0,(%r8)
    c29f:	75 61                	jne    c302 <fwp_apply_owned+0x4c2>
    c2a1:	48 ff c7             	inc    %rdi
    c2a4:	48 39 fe             	cmp    %rdi,%rsi
    c2a7:	0f 84 83 00 00 00    	je     c330 <fwp_apply_owned+0x4f0>
    c2ad:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    c2b1:	49 29 c0             	sub    %rax,%r8
    c2b4:	49 39 c8             	cmp    %rcx,%r8
    c2b7:	73 e8                	jae    c2a1 <fwp_apply_owned+0x461>
    c2b9:	4d 89 c1             	mov    %r8,%r9
    c2bc:	49 c1 e9 10          	shr    $0x10,%r9
    c2c0:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    c2c7:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    c2cc:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    c2d3:	75 06                	jne    c2db <fwp_apply_owned+0x49b>
    c2d5:	41 80 fa 02          	cmp    $0x2,%r10b
    c2d9:	74 b5                	je     c290 <fwp_apply_owned+0x450>
    c2db:	41 80 fa 01          	cmp    $0x1,%r10b
    c2df:	75 c0                	jne    c2a1 <fwp_apply_owned+0x461>
    c2e1:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    c2e5:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    c2ea:	4d 0f af c1          	imul   %r9,%r8
    c2ee:	49 c1 e8 20          	shr    $0x20,%r8
    c2f2:	4d 01 d0             	add    %r10,%r8
    c2f5:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    c2fc:	41 80 38 00          	cmpb   $0x0,(%r8)
    c300:	74 9f                	je     c2a1 <fwp_apply_owned+0x461>
    c302:	e8 99 a7 ff ff       	call   6aa0 <fwp_flush>
    c307:	48 8b 05 d2 6c 00 00 	mov    0x6cd2(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    c30e:	48 8b 38             	mov    (%rax),%rdi
    c311:	48 8d 35 b5 31 00 00 	lea    0x31b5(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    c318:	48 8d 15 81 31 00 00 	lea    0x3181(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    c31f:	31 c0                	xor    %eax,%eax
    c321:	e8 7a 5e ff ff       	call   21a0 <fprintf@plt>
    c326:	bf 65 00 00 00       	mov    $0x65,%edi
    c32b:	e8 40 5f ff ff       	call   2270 <exit@plt>
    c330:	4c 89 e7             	mov    %r12,%rdi
    c333:	44 89 ee             	mov    %r13d,%esi
    c336:	48 89 da             	mov    %rbx,%rdx
    c339:	e8 a2 f5 ff ff       	call   b8e0 <fwp_apply>
    c33e:	49 89 c4             	mov    %rax,%r12
    c341:	e9 4d 03 00 00       	jmp    c693 <fwp_apply_owned+0x853>
    c346:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    c34b:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    c350:	4d 29 eb             	sub    %r13,%r11
    c353:	49 39 d3             	cmp    %rdx,%r11
    c356:	72 34                	jb     c38c <fwp_apply_owned+0x54c>
    c358:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    c35c:	48 83 c6 10          	add    $0x10,%rsi
    c360:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    c364:	4c 89 16             	mov    %r10,(%rsi)
    c367:	4d 85 ed             	test   %r13,%r13
    c36a:	0f 85 bc fe ff ff    	jne    c22c <fwp_apply_owned+0x3ec>
    c370:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    c377:	00 00 
    c379:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    c380:	49 29 d1             	sub    %rdx,%r9
    c383:	4c 89 0d de 6d 00 00 	mov    %r9,0x6dde(%rip)        # 13168 <fwp_gc>
    c38a:	78 31                	js     c3bd <fwp_apply_owned+0x57d>
    c38c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    c390:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    c395:	4d 85 ed             	test   %r13,%r13
    c398:	74 11                	je     c3ab <fwp_apply_owned+0x56b>
    c39a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    c39e:	48 83 c0 08          	add    $0x8,%rax
    c3a2:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    c3a6:	48 f7 d1             	not    %rcx
    c3a9:	eb 2a                	jmp    c3d5 <fwp_apply_owned+0x595>
    c3ab:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    c3b0:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    c3b5:	4c 29 ee             	sub    %r13,%rsi
    c3b8:	48 39 d6             	cmp    %rdx,%rsi
    c3bb:	73 0c                	jae    c3c9 <fwp_apply_owned+0x589>
    c3bd:	31 f6                	xor    %esi,%esi
    c3bf:	e8 7c ab ff ff       	call   6f40 <fwp_gc_alloc_slow>
    c3c4:	49 89 c5             	mov    %rax,%r13
    c3c7:	eb 19                	jmp    c3e2 <fwp_apply_owned+0x5a2>
    c3c9:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    c3cd:	48 83 c0 10          	add    $0x10,%rax
    c3d1:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    c3d5:	48 89 08             	mov    %rcx,(%rax)
    c3d8:	4c 89 ef             	mov    %r13,%rdi
    c3db:	31 f6                	xor    %esi,%esi
    c3dd:	e8 3e 5d ff ff       	call   2120 <memset@plt>
    c3e2:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    c3e6:	41 8b 04 24          	mov    (%r12),%eax
    c3ea:	41 89 45 00          	mov    %eax,0x0(%r13)
    c3ee:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    c3f2:	4d 85 f6             	test   %r14,%r14
    c3f5:	0f 84 c6 00 00 00    	je     c4c1 <fwp_apply_owned+0x681>
    c3fb:	31 c0                	xor    %eax,%eax
    c3fd:	41 83 fe 06          	cmp    $0x6,%r14d
    c401:	72 53                	jb     c456 <fwp_apply_owned+0x616>
    c403:	4c 89 e9             	mov    %r13,%rcx
    c406:	4c 29 e1             	sub    %r12,%rcx
    c409:	48 83 f9 20          	cmp    $0x20,%rcx
    c40d:	72 47                	jb     c456 <fwp_apply_owned+0x616>
    c40f:	44 89 f0             	mov    %r14d,%eax
    c412:	83 e0 fc             	and    $0xfffffffc,%eax
    c415:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    c41c:	00 
    c41d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    c421:	31 d2                	xor    %edx,%edx
    c423:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c42a:	84 00 00 00 00 00 
    c430:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    c436:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    c43c:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    c442:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    c448:	48 83 c2 20          	add    $0x20,%rdx
    c44c:	48 39 d1             	cmp    %rdx,%rcx
    c44f:	75 df                	jne    c430 <fwp_apply_owned+0x5f0>
    c451:	4c 39 f0             	cmp    %r14,%rax
    c454:	74 6b                	je     c4c1 <fwp_apply_owned+0x681>
    c456:	4c 89 f2             	mov    %r14,%rdx
    c459:	48 89 c1             	mov    %rax,%rcx
    c45c:	48 83 e2 03          	and    $0x3,%rdx
    c460:	74 20                	je     c482 <fwp_apply_owned+0x642>
    c462:	48 89 c1             	mov    %rax,%rcx
    c465:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c46c:	00 00 00 00 
    c470:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    c475:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    c47a:	48 ff c1             	inc    %rcx
    c47d:	48 ff ca             	dec    %rdx
    c480:	75 ee                	jne    c470 <fwp_apply_owned+0x630>
    c482:	4c 29 f0             	sub    %r14,%rax
    c485:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    c489:	77 36                	ja     c4c1 <fwp_apply_owned+0x681>
    c48b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c490:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    c495:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    c49a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    c49f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    c4a4:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    c4a9:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    c4ae:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    c4b3:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    c4b8:	48 83 c1 04          	add    $0x4,%rcx
    c4bc:	49 39 ce             	cmp    %rcx,%r14
    c4bf:	75 cf                	jne    c490 <fwp_apply_owned+0x650>
    c4c1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    c4c5:	85 c9                	test   %ecx,%ecx
    c4c7:	0f 84 89 00 00 00    	je     c556 <fwp_apply_owned+0x716>
    c4cd:	89 c8                	mov    %ecx,%eax
    c4cf:	83 f9 14             	cmp    $0x14,%ecx
    c4d2:	0f 83 fb 00 00 00    	jae    c5d3 <fwp_apply_owned+0x793>
    c4d8:	31 c9                	xor    %ecx,%ecx
    c4da:	48 89 c6             	mov    %rax,%rsi
    c4dd:	48 89 ca             	mov    %rcx,%rdx
    c4e0:	48 83 e6 03          	and    $0x3,%rsi
    c4e4:	74 1f                	je     c505 <fwp_apply_owned+0x6c5>
    c4e6:	48 89 ca             	mov    %rcx,%rdx
    c4e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c4f0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    c4f4:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    c4f8:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    c4fd:	48 ff c2             	inc    %rdx
    c500:	48 ff ce             	dec    %rsi
    c503:	75 eb                	jne    c4f0 <fwp_apply_owned+0x6b0>
    c505:	48 29 c1             	sub    %rax,%rcx
    c508:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    c50c:	77 48                	ja     c556 <fwp_apply_owned+0x716>
    c50e:	66 90                	xchg   %ax,%ax
    c510:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    c514:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c518:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c51d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    c522:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c526:	ff c6                	inc    %esi
    c528:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c52d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    c532:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    c537:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c53c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    c541:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c545:	83 c6 03             	add    $0x3,%esi
    c548:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c54d:	48 83 c2 04          	add    $0x4,%rdx
    c551:	48 39 d0             	cmp    %rdx,%rax
    c554:	75 ba                	jne    c510 <fwp_apply_owned+0x6d0>
    c556:	49 8b 01             	mov    (%r9),%rax
    c559:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    c55d:	4c 89 f7             	mov    %r14,%rdi
    c560:	be 01 00 00 00       	mov    $0x1,%esi
    c565:	ff 50 08             	call   *0x8(%rax)
    c568:	4c 89 e8             	mov    %r13,%rax
    c56b:	48 2b 05 26 7c 00 00 	sub    0x7c26(%rip),%rax        # 14198 <fwp_gc+0x1030>
    c572:	48 8b 0d 47 7c 00 00 	mov    0x7c47(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    c579:	48 c1 e1 10          	shl    $0x10,%rcx
    c57d:	48 39 c8             	cmp    %rcx,%rax
    c580:	0f 83 02 01 00 00    	jae    c688 <fwp_apply_owned+0x848>
    c586:	48 8b 0d 53 7c 00 00 	mov    0x7c53(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    c58d:	48 89 c2             	mov    %rax,%rdx
    c590:	48 c1 ea 10          	shr    $0x10,%rdx
    c594:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c59b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c59f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c5a5:	0f 85 a5 00 00 00    	jne    c650 <fwp_apply_owned+0x810>
    c5ab:	40 80 fe 02          	cmp    $0x2,%sil
    c5af:	0f 85 9b 00 00 00    	jne    c650 <fwp_apply_owned+0x810>
    c5b5:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    c5b9:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c5c0:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c5c4:	0f 84 b1 00 00 00    	je     c67b <fwp_apply_owned+0x83b>
    c5ca:	41 c6 07 01          	movb   $0x1,(%r15)
    c5ce:	e9 b5 00 00 00       	jmp    c688 <fwp_apply_owned+0x848>
    c5d3:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c5d7:	31 c9                	xor    %ecx,%ecx
    c5d9:	89 d6                	mov    %edx,%esi
    c5db:	44 01 f6             	add    %r14d,%esi
    c5de:	0f 82 f6 fe ff ff    	jb     c4da <fwp_apply_owned+0x69a>
    c5e4:	48 c1 ea 20          	shr    $0x20,%rdx
    c5e8:	0f 85 ec fe ff ff    	jne    c4da <fwp_apply_owned+0x69a>
    c5ee:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    c5f5:	00 
    c5f6:	4c 01 e9             	add    %r13,%rcx
    c5f9:	48 29 d9             	sub    %rbx,%rcx
    c5fc:	48 83 c1 08          	add    $0x8,%rcx
    c600:	48 83 f9 20          	cmp    $0x20,%rcx
    c604:	0f 82 ce fe ff ff    	jb     c4d8 <fwp_apply_owned+0x698>
    c60a:	89 c1                	mov    %eax,%ecx
    c60c:	83 e1 fc             	and    $0xfffffffc,%ecx
    c60f:	31 d2                	xor    %edx,%edx
    c611:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c618:	0f 1f 84 00 00 00 00 
    c61f:	00 
    c620:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    c624:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    c629:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c62d:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    c633:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    c639:	48 83 c2 04          	add    $0x4,%rdx
    c63d:	48 39 d1             	cmp    %rdx,%rcx
    c640:	75 de                	jne    c620 <fwp_apply_owned+0x7e0>
    c642:	48 39 c1             	cmp    %rax,%rcx
    c645:	0f 85 8f fe ff ff    	jne    c4da <fwp_apply_owned+0x69a>
    c64b:	e9 06 ff ff ff       	jmp    c556 <fwp_apply_owned+0x716>
    c650:	40 80 fe 01          	cmp    $0x1,%sil
    c654:	75 32                	jne    c688 <fwp_apply_owned+0x848>
    c656:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c65a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c65e:	48 0f af c1          	imul   %rcx,%rax
    c662:	48 c1 e8 20          	shr    $0x20,%rax
    c666:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c66a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c671:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c675:	0f 85 4f ff ff ff    	jne    c5ca <fwp_apply_owned+0x78a>
    c67b:	4c 89 ff             	mov    %r15,%rdi
    c67e:	e8 4d a4 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    c683:	e9 42 ff ff ff       	jmp    c5ca <fwp_apply_owned+0x78a>
    c688:	4c 89 f7             	mov    %r14,%rdi
    c68b:	e8 20 00 00 00       	call   c6b0 <fwp_closure_drop>
    c690:	4d 89 ec             	mov    %r13,%r12
    c693:	4c 89 e0             	mov    %r12,%rax
    c696:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    c69a:	5b                   	pop    %rbx
    c69b:	41 5c                	pop    %r12
    c69d:	41 5d                	pop    %r13
    c69f:	41 5e                	pop    %r14
    c6a1:	41 5f                	pop    %r15
    c6a3:	5d                   	pop    %rbp
    c6a4:	c3                   	ret
    c6a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c6ac:	00 00 00 00 

000000000000c6b0 <fwp_closure_drop>:
    c6b0:	41 57                	push   %r15
    c6b2:	41 56                	push   %r14
    c6b4:	53                   	push   %rbx
    c6b5:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    c6bc:	48 89 f8             	mov    %rdi,%rax
    c6bf:	48 2b 05 d2 7a 00 00 	sub    0x7ad2(%rip),%rax        # 14198 <fwp_gc+0x1030>
    c6c6:	48 8b 0d f3 7a 00 00 	mov    0x7af3(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    c6cd:	48 c1 e1 10          	shl    $0x10,%rcx
    c6d1:	48 39 c8             	cmp    %rcx,%rax
    c6d4:	0f 83 91 00 00 00    	jae    c76b <fwp_closure_drop+0xbb>
    c6da:	48 89 fe             	mov    %rdi,%rsi
    c6dd:	48 8b 0d fc 7a 00 00 	mov    0x7afc(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    c6e4:	48 89 c2             	mov    %rax,%rdx
    c6e7:	48 c1 ea 10          	shr    $0x10,%rdx
    c6eb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c6f2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    c6f6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c6fc:	75 13                	jne    c711 <fwp_closure_drop+0x61>
    c6fe:	40 80 ff 02          	cmp    $0x2,%dil
    c702:	75 0d                	jne    c711 <fwp_closure_drop+0x61>
    c704:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c708:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c70f:	eb 20                	jmp    c731 <fwp_closure_drop+0x81>
    c711:	40 80 ff 01          	cmp    $0x1,%dil
    c715:	75 54                	jne    c76b <fwp_closure_drop+0xbb>
    c717:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c71b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c71f:	48 0f af c1          	imul   %rcx,%rax
    c723:	48 c1 e8 20          	shr    $0x20,%rax
    c727:	48 01 c7             	add    %rax,%rdi
    c72a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c731:	0f b6 07             	movzbl (%rdi),%eax
    c734:	85 c0                	test   %eax,%eax
    c736:	74 33                	je     c76b <fwp_closure_drop+0xbb>
    c738:	83 f8 01             	cmp    $0x1,%eax
    c73b:	75 1f                	jne    c75c <fwp_closure_drop+0xac>
    c73d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    c744:	ff ff 
    c746:	48 85 ff             	test   %rdi,%rdi
    c749:	74 2d                	je     c778 <fwp_closure_drop+0xc8>
    c74b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c752:	5b                   	pop    %rbx
    c753:	41 5e                	pop    %r14
    c755:	41 5f                	pop    %r15
    c757:	e9 b4 01 00 00       	jmp    c910 <fwp_closure_drop_push>
    c75c:	3d ff 00 00 00       	cmp    $0xff,%eax
    c761:	0f 84 56 01 00 00    	je     c8bd <fwp_closure_drop+0x20d>
    c767:	fe c8                	dec    %al
    c769:	88 07                	mov    %al,(%rdi)
    c76b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c772:	5b                   	pop    %rbx
    c773:	41 5e                	pop    %r14
    c775:	41 5f                	pop    %r15
    c777:	c3                   	ret
    c778:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    c77f:	00 00 
    c781:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    c788:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    c78d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    c792:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c799:	00 00 
    c79b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    c7a2:	00 00 
    c7a4:	48 8b 05 dd 8f 00 00 	mov    0x8fdd(%rip),%rax        # 15788 <fwp_cleanups>
    c7ab:	48 89 04 24          	mov    %rax,(%rsp)
    c7af:	48 8d 05 9a 02 00 00 	lea    0x29a(%rip),%rax        # ca50 <fwp_closure_drop_release>
    c7b6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    c7bb:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c7c0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    c7c5:	49 89 e7             	mov    %rsp,%r15
    c7c8:	4c 89 3d b9 8f 00 00 	mov    %r15,0x8fb9(%rip)        # 15788 <fwp_cleanups>
    c7cf:	49 89 3e             	mov    %rdi,(%r14)
    c7d2:	e8 39 01 00 00       	call   c910 <fwp_closure_drop_push>
    c7d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c7de:	00 00 
    c7e0:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c7e5:	48 85 c0             	test   %rax,%rax
    c7e8:	74 35                	je     c81f <fwp_closure_drop+0x16f>
    c7ea:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    c7ef:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c7f3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    c7f8:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    c7fd:	48 8b 05 5c 8f 00 00 	mov    0x8f5c(%rip),%rax        # 15760 <fwp_fns>
    c804:	8b 0f                	mov    (%rdi),%ecx
    c806:	48 c1 e1 05          	shl    $0x5,%rcx
    c80a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    c80f:	48 85 c0             	test   %rax,%rax
    c812:	0f 84 b6 00 00 00    	je     c8ce <fwp_closure_drop+0x21e>
    c818:	31 f6                	xor    %esi,%esi
    c81a:	ff 50 08             	call   *0x8(%rax)
    c81d:	eb c1                	jmp    c7e0 <fwp_closure_drop+0x130>
    c81f:	4c 39 3d 62 8f 00 00 	cmp    %r15,0x8f62(%rip)        # 15788 <fwp_cleanups>
    c826:	0f 85 d0 00 00 00    	jne    c8fc <fwp_closure_drop+0x24c>
    c82c:	48 8b 04 24          	mov    (%rsp),%rax
    c830:	48 89 05 51 8f 00 00 	mov    %rax,0x8f51(%rip)        # 15788 <fwp_cleanups>
    c837:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    c83e:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    c843:	48 39 d8             	cmp    %rbx,%rax
    c846:	0f 84 1f ff ff ff    	je     c76b <fwp_closure_drop+0xbb>
    c84c:	48 85 c0             	test   %rax,%rax
    c84f:	0f 84 16 ff ff ff    	je     c76b <fwp_closure_drop+0xbb>
    c855:	8b 48 f4             	mov    -0xc(%rax),%ecx
    c858:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c85f:	00 
    c860:	b2 01                	mov    $0x1,%dl
    c862:	86 15 80 8b 00 00    	xchg   %dl,0x8b80(%rip)        # 153e8 <fwp_static+0x848>
    c868:	84 d2                	test   %dl,%dl
    c86a:	75 f4                	jne    c860 <fwp_closure_drop+0x1b0>
    c86c:	48 29 c8             	sub    %rcx,%rax
    c86f:	8b 50 f0             	mov    -0x10(%rax),%edx
    c872:	89 d1                	mov    %edx,%ecx
    c874:	c1 e9 02             	shr    $0x2,%ecx
    c877:	be 01 00 00 00       	mov    $0x1,%esi
    c87c:	48 d3 e6             	shl    %cl,%rsi
    c87f:	48 8d 48 f0          	lea    -0x10(%rax),%rcx
    c883:	89 d7                	mov    %edx,%edi
    c885:	83 e7 03             	and    $0x3,%edi
    c888:	49 89 f0             	mov    %rsi,%r8
    c88b:	49 c1 e8 02          	shr    $0x2,%r8
    c88f:	4c 0f af c7          	imul   %rdi,%r8
    c893:	48 8d 3d 06 83 00 00 	lea    0x8306(%rip),%rdi        # 14ba0 <fwp_static>
    c89a:	49 01 f0             	add    %rsi,%r8
    c89d:	4c 29 05 34 8b 00 00 	sub    %r8,0x8b34(%rip)        # 153d8 <fwp_static+0x838>
    c8a4:	48 8b 74 d7 38       	mov    0x38(%rdi,%rdx,8),%rsi
    c8a9:	48 89 30             	mov    %rsi,(%rax)
    c8ac:	48 89 4c d7 38       	mov    %rcx,0x38(%rdi,%rdx,8)
    c8b1:	c6 05 30 8b 00 00 00 	movb   $0x0,0x8b30(%rip)        # 153e8 <fwp_static+0x848>
    c8b8:	e9 ae fe ff ff       	jmp    c76b <fwp_closure_drop+0xbb>
    c8bd:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c8c4:	5b                   	pop    %rbx
    c8c5:	41 5e                	pop    %r14
    c8c7:	41 5f                	pop    %r15
    c8c9:	e9 22 e4 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    c8ce:	e8 cd a1 ff ff       	call   6aa0 <fwp_flush>
    c8d3:	48 8b 05 06 67 00 00 	mov    0x6706(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    c8da:	48 8b 38             	mov    (%rax),%rdi
    c8dd:	48 8d 35 e9 2b 00 00 	lea    0x2be9(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    c8e4:	48 8d 15 71 2e 00 00 	lea    0x2e71(%rip),%rdx        # f75c <fwp_segv.msg+0x4dc>
    c8eb:	31 c0                	xor    %eax,%eax
    c8ed:	e8 ae 58 ff ff       	call   21a0 <fprintf@plt>
    c8f2:	bf 65 00 00 00       	mov    $0x65,%edi
    c8f7:	e8 74 59 ff ff       	call   2270 <exit@plt>
    c8fc:	e8 4f 57 ff ff       	call   2050 <abort@plt>
    c901:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c908:	0f 1f 84 00 00 00 00 
    c90f:	00 

000000000000c910 <fwp_closure_drop_push>:
    c910:	55                   	push   %rbp
    c911:	41 57                	push   %r15
    c913:	41 56                	push   %r14
    c915:	41 55                	push   %r13
    c917:	41 54                	push   %r12
    c919:	53                   	push   %rbx
    c91a:	50                   	push   %rax
    c91b:	48 89 f3             	mov    %rsi,%rbx
    c91e:	49 89 fe             	mov    %rdi,%r14
    c921:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    c925:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    c929:	0f 85 ca 00 00 00    	jne    c9f9 <fwp_closure_drop_push+0xe9>
    c92f:	4c 89 e8             	mov    %r13,%rax
    c932:	48 c1 e8 3c          	shr    $0x3c,%rax
    c936:	0f 85 db 00 00 00    	jne    ca17 <fwp_closure_drop_push+0x107>
    c93c:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    c943:	00 
    c944:	49 c1 e5 04          	shl    $0x4,%r13
    c948:	49 83 fd 01          	cmp    $0x1,%r13
    c94c:	49 83 d5 00          	adc    $0x0,%r13
    c950:	4c 89 ef             	mov    %r13,%rdi
    c953:	e8 f8 5a ff ff       	call   2450 <fwp_pool_get>
    c958:	49 89 c7             	mov    %rax,%r15
    c95b:	4d 8b 26             	mov    (%r14),%r12
    c95e:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c962:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    c969:	00 
    c96a:	48 89 c7             	mov    %rax,%rdi
    c96d:	4c 89 e6             	mov    %r12,%rsi
    c970:	e8 5b 58 ff ff       	call   21d0 <memcpy@plt>
    c975:	49 8d 46 18          	lea    0x18(%r14),%rax
    c979:	49 39 c4             	cmp    %rax,%r12
    c97c:	74 72                	je     c9f0 <fwp_closure_drop_push+0xe0>
    c97e:	4d 85 e4             	test   %r12,%r12
    c981:	74 6d                	je     c9f0 <fwp_closure_drop_push+0xe0>
    c983:	41 8b 44 24 f4       	mov    -0xc(%r12),%eax
    c988:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c98f:	00 
    c990:	b1 01                	mov    $0x1,%cl
    c992:	86 0d 50 8a 00 00    	xchg   %cl,0x8a50(%rip)        # 153e8 <fwp_static+0x848>
    c998:	84 c9                	test   %cl,%cl
    c99a:	75 f4                	jne    c990 <fwp_closure_drop_push+0x80>
    c99c:	49 29 c4             	sub    %rax,%r12
    c99f:	41 8b 44 24 f0       	mov    -0x10(%r12),%eax
    c9a4:	89 c1                	mov    %eax,%ecx
    c9a6:	c1 e9 02             	shr    $0x2,%ecx
    c9a9:	ba 01 00 00 00       	mov    $0x1,%edx
    c9ae:	48 d3 e2             	shl    %cl,%rdx
    c9b1:	49 8d 4c 24 f0       	lea    -0x10(%r12),%rcx
    c9b6:	89 c6                	mov    %eax,%esi
    c9b8:	83 e6 03             	and    $0x3,%esi
    c9bb:	48 89 d7             	mov    %rdx,%rdi
    c9be:	48 c1 ef 02          	shr    $0x2,%rdi
    c9c2:	48 0f af fe          	imul   %rsi,%rdi
    c9c6:	48 8d 35 d3 81 00 00 	lea    0x81d3(%rip),%rsi        # 14ba0 <fwp_static>
    c9cd:	48 01 d7             	add    %rdx,%rdi
    c9d0:	48 29 3d 01 8a 00 00 	sub    %rdi,0x8a01(%rip)        # 153d8 <fwp_static+0x838>
    c9d7:	48 8b 54 c6 38       	mov    0x38(%rsi,%rax,8),%rdx
    c9dc:	49 89 14 24          	mov    %rdx,(%r12)
    c9e0:	48 89 4c c6 38       	mov    %rcx,0x38(%rsi,%rax,8)
    c9e5:	c6 05 fc 89 00 00 00 	movb   $0x0,0x89fc(%rip)        # 153e8 <fwp_static+0x848>
    c9ec:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c9f0:	4d 89 3e             	mov    %r15,(%r14)
    c9f3:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    c9f7:	eb 03                	jmp    c9fc <fwp_closure_drop_push+0xec>
    c9f9:	4d 8b 3e             	mov    (%r14),%r15
    c9fc:	49 8d 45 01          	lea    0x1(%r13),%rax
    ca00:	49 89 46 08          	mov    %rax,0x8(%r14)
    ca04:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    ca08:	48 83 c4 08          	add    $0x8,%rsp
    ca0c:	5b                   	pop    %rbx
    ca0d:	41 5c                	pop    %r12
    ca0f:	41 5d                	pop    %r13
    ca11:	41 5e                	pop    %r14
    ca13:	41 5f                	pop    %r15
    ca15:	5d                   	pop    %rbp
    ca16:	c3                   	ret
    ca17:	e8 84 a0 ff ff       	call   6aa0 <fwp_flush>
    ca1c:	48 8b 05 bd 65 00 00 	mov    0x65bd(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    ca23:	48 8b 38             	mov    (%rax),%rdi
    ca26:	48 8d 35 a0 2a 00 00 	lea    0x2aa0(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    ca2d:	48 8d 15 56 2d 00 00 	lea    0x2d56(%rip),%rdx        # f78a <fwp_segv.msg+0x50a>
    ca34:	31 c0                	xor    %eax,%eax
    ca36:	e8 65 57 ff ff       	call   21a0 <fprintf@plt>
    ca3b:	bf 65 00 00 00       	mov    $0x65,%edi
    ca40:	e8 2b 58 ff ff       	call   2270 <exit@plt>
    ca45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ca4c:	00 00 00 00 

000000000000ca50 <fwp_closure_drop_release>:
    ca50:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    ca57:	ff ff 00 00 00 00 
    ca5d:	48 8b 17             	mov    (%rdi),%rdx
    ca60:	48 8d 47 18          	lea    0x18(%rdi),%rax
    ca64:	48 39 c2             	cmp    %rax,%rdx
    ca67:	74 75                	je     cade <fwp_closure_drop_release+0x8e>
    ca69:	48 85 d2             	test   %rdx,%rdx
    ca6c:	74 70                	je     cade <fwp_closure_drop_release+0x8e>
    ca6e:	8b 4a f4             	mov    -0xc(%rdx),%ecx
    ca71:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ca78:	0f 1f 84 00 00 00 00 
    ca7f:	00 
    ca80:	40 b6 01             	mov    $0x1,%sil
    ca83:	40 86 35 5e 89 00 00 	xchg   %sil,0x895e(%rip)        # 153e8 <fwp_static+0x848>
    ca8a:	40 84 f6             	test   %sil,%sil
    ca8d:	75 f1                	jne    ca80 <fwp_closure_drop_release+0x30>
    ca8f:	48 29 ca             	sub    %rcx,%rdx
    ca92:	8b 72 f0             	mov    -0x10(%rdx),%esi
    ca95:	89 f1                	mov    %esi,%ecx
    ca97:	c1 e9 02             	shr    $0x2,%ecx
    ca9a:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    caa0:	49 d3 e0             	shl    %cl,%r8
    caa3:	48 8d 4a f0          	lea    -0x10(%rdx),%rcx
    caa7:	41 89 f1             	mov    %esi,%r9d
    caaa:	41 83 e1 03          	and    $0x3,%r9d
    caae:	4d 89 c2             	mov    %r8,%r10
    cab1:	49 c1 ea 02          	shr    $0x2,%r10
    cab5:	4d 0f af d1          	imul   %r9,%r10
    cab9:	4c 8d 0d e0 80 00 00 	lea    0x80e0(%rip),%r9        # 14ba0 <fwp_static>
    cac0:	4d 01 c2             	add    %r8,%r10
    cac3:	4c 29 15 0e 89 00 00 	sub    %r10,0x890e(%rip)        # 153d8 <fwp_static+0x838>
    caca:	4d 8b 44 f1 38       	mov    0x38(%r9,%rsi,8),%r8
    cacf:	4c 89 02             	mov    %r8,(%rdx)
    cad2:	49 89 4c f1 38       	mov    %rcx,0x38(%r9,%rsi,8)
    cad7:	c6 05 0a 89 00 00 00 	movb   $0x0,0x890a(%rip)        # 153e8 <fwp_static+0x848>
    cade:	48 89 07             	mov    %rax,(%rdi)
    cae1:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    cae8:	00 
    cae9:	c3                   	ret
    caea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000caf0 <f52>:
    caf0:	41 57                	push   %r15
    caf2:	41 56                	push   %r14
    caf4:	53                   	push   %rbx
    caf5:	48 83 ec 20          	sub    $0x20,%rsp
    caf9:	48 89 fb             	mov    %rdi,%rbx
    cafc:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cb00:	48 2b 05 91 76 00 00 	sub    0x7691(%rip),%rax        # 14198 <fwp_gc+0x1030>
    cb07:	48 8b 0d b2 76 00 00 	mov    0x76b2(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    cb0e:	48 c1 e1 10          	shl    $0x10,%rcx
    cb12:	48 39 c8             	cmp    %rcx,%rax
    cb15:	73 68                	jae    cb7f <f52+0x8f>
    cb17:	48 8b 0d c2 76 00 00 	mov    0x76c2(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    cb1e:	48 89 c2             	mov    %rax,%rdx
    cb21:	48 c1 ea 10          	shr    $0x10,%rdx
    cb25:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cb2c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cb30:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cb36:	75 13                	jne    cb4b <f52+0x5b>
    cb38:	40 80 fe 02          	cmp    $0x2,%sil
    cb3c:	75 0d                	jne    cb4b <f52+0x5b>
    cb3e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cb42:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cb49:	eb 21                	jmp    cb6c <f52+0x7c>
    cb4b:	40 80 fe 01          	cmp    $0x1,%sil
    cb4f:	75 2e                	jne    cb7f <f52+0x8f>
    cb51:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cb55:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cb59:	48 0f af c1          	imul   %rcx,%rax
    cb5d:	48 c1 e8 20          	shr    $0x20,%rax
    cb61:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cb65:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cb6c:	0f b6 07             	movzbl (%rdi),%eax
    cb6f:	84 c0                	test   %al,%al
    cb71:	74 0c                	je     cb7f <f52+0x8f>
    cb73:	3c fe                	cmp    $0xfe,%al
    cb75:	0f 83 e5 02 00 00    	jae    ce60 <f52+0x370>
    cb7b:	fe c0                	inc    %al
    cb7d:	88 07                	mov    %al,(%rdi)
    cb7f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    cb83:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    cb87:	48 8b 43 18          	mov    0x18(%rbx),%rax
    cb8b:	4d 85 ff             	test   %r15,%r15
    cb8e:	78 27                	js     cbb7 <f52+0xc7>
    cb90:	48 8b 0f             	mov    (%rdi),%rcx
    cb93:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    cb9a:	ff ff 7f 
    cb9d:	48 21 ca             	and    %rcx,%rdx
    cba0:	4c 39 fa             	cmp    %r15,%rdx
    cba3:	76 12                	jbe    cbb7 <f52+0xc7>
    cba5:	48 85 c9             	test   %rcx,%rcx
    cba8:	0f 88 8e 00 00 00    	js     cc3c <f52+0x14c>
    cbae:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    cbb2:	e9 89 00 00 00       	jmp    cc40 <f52+0x150>
    cbb7:	41 89 c6             	mov    %eax,%r14d
    cbba:	e8 71 03 00 00       	call   cf30 <fwp_drop8>
    cbbf:	48 89 df             	mov    %rbx,%rdi
    cbc2:	e8 b9 02 00 00       	call   ce80 <fwp_drop9>
    cbc7:	48 c7 44 24 08 01 00 	movq   $0x1,0x8(%rsp)
    cbce:	00 00 
    cbd0:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    cbd5:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    cbda:	bf 01 00 00 00       	mov    $0x1,%edi
    cbdf:	be 01 00 00 00       	mov    $0x1,%esi
    cbe4:	e8 a7 d8 ff ff       	call   a490 <fwp_data>
    cbe9:	48 89 c1             	mov    %rax,%rcx
    cbec:	48 2b 0d a5 75 00 00 	sub    0x75a5(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    cbf3:	48 8b 15 c6 75 00 00 	mov    0x75c6(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    cbfa:	48 c1 e2 10          	shl    $0x10,%rdx
    cbfe:	48 39 d1             	cmp    %rdx,%rcx
    cc01:	0f 83 4f 02 00 00    	jae    ce56 <f52+0x366>
    cc07:	48 8b 15 d2 75 00 00 	mov    0x75d2(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    cc0e:	48 89 ce             	mov    %rcx,%rsi
    cc11:	48 c1 ee 10          	shr    $0x10,%rsi
    cc15:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cc1c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cc20:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    cc27:	0f 85 f3 01 00 00    	jne    ce20 <f52+0x330>
    cc2d:	40 80 ff 02          	cmp    $0x2,%dil
    cc31:	0f 84 d4 01 00 00    	je     ce0b <f52+0x31b>
    cc37:	e9 e4 01 00 00       	jmp    ce20 <f52+0x330>
    cc3c:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    cc40:	89 44 24 04          	mov    %eax,0x4(%rsp)
    cc44:	f3 42 0f 10 04 b9    	movss  (%rcx,%r15,4),%xmm0
    cc4a:	f3 0f 59 05 b2 23 00 	mulss  0x23b2(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    cc51:	00 
    cc52:	f3 0f 58 05 ae 23 00 	addss  0x23ae(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    cc59:	00 
    cc5a:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
    cc5f:	48 89 f8             	mov    %rdi,%rax
    cc62:	48 2b 05 2f 75 00 00 	sub    0x752f(%rip),%rax        # 14198 <fwp_gc+0x1030>
    cc69:	49 ff c7             	inc    %r15
    cc6c:	48 8b 0d 4d 75 00 00 	mov    0x754d(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    cc73:	48 c1 e1 10          	shl    $0x10,%rcx
    cc77:	48 39 c8             	cmp    %rcx,%rax
    cc7a:	73 66                	jae    cce2 <f52+0x1f2>
    cc7c:	48 8b 0d 5d 75 00 00 	mov    0x755d(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    cc83:	48 89 c2             	mov    %rax,%rdx
    cc86:	48 c1 ea 10          	shr    $0x10,%rdx
    cc8a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cc91:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cc95:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cc9b:	75 12                	jne    ccaf <f52+0x1bf>
    cc9d:	40 80 fe 02          	cmp    $0x2,%sil
    cca1:	75 0c                	jne    ccaf <f52+0x1bf>
    cca3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cca7:	48 05 28 02 00 00    	add    $0x228,%rax
    ccad:	eb 1f                	jmp    ccce <f52+0x1de>
    ccaf:	40 80 fe 01          	cmp    $0x1,%sil
    ccb3:	75 2d                	jne    cce2 <f52+0x1f2>
    ccb5:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ccb9:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ccbd:	48 0f af c1          	imul   %rcx,%rax
    ccc1:	48 c1 e8 20          	shr    $0x20,%rax
    ccc5:	48 01 f0             	add    %rsi,%rax
    ccc8:	48 05 28 02 00 00    	add    $0x228,%rax
    ccce:	0f b6 08             	movzbl (%rax),%ecx
    ccd1:	84 c9                	test   %cl,%cl
    ccd3:	74 0d                	je     cce2 <f52+0x1f2>
    ccd5:	80 f9 fe             	cmp    $0xfe,%cl
    ccd8:	0f 83 8c 01 00 00    	jae    ce6a <f52+0x37a>
    ccde:	fe c1                	inc    %cl
    cce0:	88 08                	mov    %cl,(%rax)
    cce2:	49 89 fe             	mov    %rdi,%r14
    cce5:	e8 46 02 00 00       	call   cf30 <fwp_drop8>
    ccea:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
    ccef:	f3 0f 58 44 24 04    	addss  0x4(%rsp),%xmm0
    ccf5:	66 0f 7e c0          	movd   %xmm0,%eax
    ccf9:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    ccfe:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    cd03:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    cd08:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    cd0d:	31 ff                	xor    %edi,%edi
    cd0f:	be 03 00 00 00       	mov    $0x3,%esi
    cd14:	e8 77 d7 ff ff       	call   a490 <fwp_data>
    cd19:	49 89 c6             	mov    %rax,%r14
    cd1c:	48 2b 05 75 74 00 00 	sub    0x7475(%rip),%rax        # 14198 <fwp_gc+0x1030>
    cd23:	48 8b 0d 96 74 00 00 	mov    0x7496(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    cd2a:	48 c1 e1 10          	shl    $0x10,%rcx
    cd2e:	48 39 c8             	cmp    %rcx,%rax
    cd31:	73 6f                	jae    cda2 <f52+0x2b2>
    cd33:	48 8b 0d a6 74 00 00 	mov    0x74a6(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    cd3a:	48 89 c2             	mov    %rax,%rdx
    cd3d:	48 c1 ea 10          	shr    $0x10,%rdx
    cd41:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cd48:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cd4c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cd52:	75 1d                	jne    cd71 <f52+0x281>
    cd54:	40 80 fe 02          	cmp    $0x2,%sil
    cd58:	75 17                	jne    cd71 <f52+0x281>
    cd5a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    cd5e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cd65:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cd69:	74 2d                	je     cd98 <f52+0x2a8>
    cd6b:	41 c6 07 01          	movb   $0x1,(%r15)
    cd6f:	eb 31                	jmp    cda2 <f52+0x2b2>
    cd71:	40 80 fe 01          	cmp    $0x1,%sil
    cd75:	75 2b                	jne    cda2 <f52+0x2b2>
    cd77:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cd7b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cd7f:	48 0f af c1          	imul   %rcx,%rax
    cd83:	48 c1 e8 20          	shr    $0x20,%rax
    cd87:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    cd8b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cd92:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cd96:	75 d3                	jne    cd6b <f52+0x27b>
    cd98:	4c 89 ff             	mov    %r15,%rdi
    cd9b:	e8 30 9d ff ff       	call   6ad0 <fwp_rc_forget_slot>
    cda0:	eb c9                	jmp    cd6b <f52+0x27b>
    cda2:	48 89 df             	mov    %rbx,%rdi
    cda5:	e8 d6 00 00 00       	call   ce80 <fwp_drop9>
    cdaa:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    cdb1:	00 00 
    cdb3:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    cdb8:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    cdbd:	31 ff                	xor    %edi,%edi
    cdbf:	be 01 00 00 00       	mov    $0x1,%esi
    cdc4:	e8 c7 d6 ff ff       	call   a490 <fwp_data>
    cdc9:	48 89 c1             	mov    %rax,%rcx
    cdcc:	48 2b 0d c5 73 00 00 	sub    0x73c5(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    cdd3:	48 8b 15 e6 73 00 00 	mov    0x73e6(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    cdda:	48 c1 e2 10          	shl    $0x10,%rdx
    cdde:	48 39 d1             	cmp    %rdx,%rcx
    cde1:	73 73                	jae    ce56 <f52+0x366>
    cde3:	48 8b 15 f6 73 00 00 	mov    0x73f6(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    cdea:	48 89 ce             	mov    %rcx,%rsi
    cded:	48 c1 ee 10          	shr    $0x10,%rsi
    cdf1:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cdf8:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cdfc:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    ce03:	75 1b                	jne    ce20 <f52+0x330>
    ce05:	40 80 ff 02          	cmp    $0x2,%dil
    ce09:	75 15                	jne    ce20 <f52+0x330>
    ce0b:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    ce0f:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ce16:	80 3b ff             	cmpb   $0xff,(%rbx)
    ce19:	74 2b                	je     ce46 <f52+0x356>
    ce1b:	c6 03 01             	movb   $0x1,(%rbx)
    ce1e:	eb 36                	jmp    ce56 <f52+0x366>
    ce20:	40 80 ff 01          	cmp    $0x1,%dil
    ce24:	75 30                	jne    ce56 <f52+0x366>
    ce26:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    ce2a:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    ce2e:	48 0f af ca          	imul   %rdx,%rcx
    ce32:	48 c1 e9 20          	shr    $0x20,%rcx
    ce36:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    ce3a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ce41:	80 3b ff             	cmpb   $0xff,(%rbx)
    ce44:	75 d5                	jne    ce1b <f52+0x32b>
    ce46:	48 89 df             	mov    %rbx,%rdi
    ce49:	49 89 c6             	mov    %rax,%r14
    ce4c:	e8 7f 9c ff ff       	call   6ad0 <fwp_rc_forget_slot>
    ce51:	4c 89 f0             	mov    %r14,%rax
    ce54:	eb c5                	jmp    ce1b <f52+0x32b>
    ce56:	48 83 c4 20          	add    $0x20,%rsp
    ce5a:	5b                   	pop    %rbx
    ce5b:	41 5e                	pop    %r14
    ce5d:	41 5f                	pop    %r15
    ce5f:	c3                   	ret
    ce60:	e8 fb ad ff ff       	call   7c60 <fwp_rc_wide_dup>
    ce65:	e9 15 fd ff ff       	jmp    cb7f <f52+0x8f>
    ce6a:	49 89 fe             	mov    %rdi,%r14
    ce6d:	48 89 c7             	mov    %rax,%rdi
    ce70:	e8 eb ad ff ff       	call   7c60 <fwp_rc_wide_dup>
    ce75:	4c 89 f7             	mov    %r14,%rdi
    ce78:	e9 65 fe ff ff       	jmp    cce2 <f52+0x1f2>
    ce7d:	0f 1f 00             	nopl   (%rax)

000000000000ce80 <fwp_drop9>:
    ce80:	48 89 f8             	mov    %rdi,%rax
    ce83:	48 2b 05 0e 73 00 00 	sub    0x730e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    ce8a:	48 8b 0d 2f 73 00 00 	mov    0x732f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    ce91:	48 c1 e1 10          	shl    $0x10,%rcx
    ce95:	48 39 c8             	cmp    %rcx,%rax
    ce98:	0f 83 83 00 00 00    	jae    cf21 <fwp_drop9+0xa1>
    ce9e:	48 8b 0d 3b 73 00 00 	mov    0x733b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    cea5:	48 89 c2             	mov    %rax,%rdx
    cea8:	48 c1 ea 10          	shr    $0x10,%rdx
    ceac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ceb3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ceb7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cebd:	75 12                	jne    ced1 <fwp_drop9+0x51>
    cebf:	40 80 fe 02          	cmp    $0x2,%sil
    cec3:	75 0c                	jne    ced1 <fwp_drop9+0x51>
    cec5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cec9:	48 05 28 02 00 00    	add    $0x228,%rax
    cecf:	eb 1f                	jmp    cef0 <fwp_drop9+0x70>
    ced1:	40 80 fe 01          	cmp    $0x1,%sil
    ced5:	75 4a                	jne    cf21 <fwp_drop9+0xa1>
    ced7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cedb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cedf:	48 0f af c1          	imul   %rcx,%rax
    cee3:	48 c1 e8 20          	shr    $0x20,%rax
    cee7:	48 01 f0             	add    %rsi,%rax
    ceea:	48 05 28 02 00 00    	add    $0x228,%rax
    cef0:	0f b6 08             	movzbl (%rax),%ecx
    cef3:	85 c9                	test   %ecx,%ecx
    cef5:	74 2a                	je     cf21 <fwp_drop9+0xa1>
    cef7:	83 f9 01             	cmp    $0x1,%ecx
    cefa:	75 19                	jne    cf15 <fwp_drop9+0x95>
    cefc:	53                   	push   %rbx
    cefd:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cf01:	48 89 fb             	mov    %rdi,%rbx
    cf04:	48 89 c7             	mov    %rax,%rdi
    cf07:	e8 24 00 00 00       	call   cf30 <fwp_drop8>
    cf0c:	48 89 df             	mov    %rbx,%rdi
    cf0f:	5b                   	pop    %rbx
    cf10:	e9 bb e0 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    cf15:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cf1b:	74 05                	je     cf22 <fwp_drop9+0xa2>
    cf1d:	fe c9                	dec    %cl
    cf1f:	88 08                	mov    %cl,(%rax)
    cf21:	c3                   	ret
    cf22:	48 89 c7             	mov    %rax,%rdi
    cf25:	e9 c6 dd ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    cf2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cf30 <fwp_drop8>:
    cf30:	53                   	push   %rbx
    cf31:	48 89 f8             	mov    %rdi,%rax
    cf34:	48 2b 05 5d 72 00 00 	sub    0x725d(%rip),%rax        # 14198 <fwp_gc+0x1030>
    cf3b:	48 8b 0d 7e 72 00 00 	mov    0x727e(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    cf42:	48 c1 e1 10          	shl    $0x10,%rcx
    cf46:	48 39 c8             	cmp    %rcx,%rax
    cf49:	0f 83 9c 00 00 00    	jae    cfeb <fwp_drop8+0xbb>
    cf4f:	48 8b 0d 8a 72 00 00 	mov    0x728a(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    cf56:	48 89 c2             	mov    %rax,%rdx
    cf59:	48 c1 ea 10          	shr    $0x10,%rdx
    cf5d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cf64:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cf68:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cf6e:	75 20                	jne    cf90 <fwp_drop8+0x60>
    cf70:	40 80 fe 02          	cmp    $0x2,%sil
    cf74:	75 1a                	jne    cf90 <fwp_drop8+0x60>
    cf76:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cf7a:	48 05 28 02 00 00    	add    $0x228,%rax
    cf80:	eb 2d                	jmp    cfaf <fwp_drop8+0x7f>
    cf82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cf89:	1f 84 00 00 00 00 00 
    cf90:	40 80 fe 01          	cmp    $0x1,%sil
    cf94:	75 55                	jne    cfeb <fwp_drop8+0xbb>
    cf96:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cf9a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cf9e:	48 0f af c1          	imul   %rcx,%rax
    cfa2:	48 c1 e8 20          	shr    $0x20,%rax
    cfa6:	48 01 f0             	add    %rsi,%rax
    cfa9:	48 05 28 02 00 00    	add    $0x228,%rax
    cfaf:	0f b6 08             	movzbl (%rax),%ecx
    cfb2:	85 c9                	test   %ecx,%ecx
    cfb4:	74 35                	je     cfeb <fwp_drop8+0xbb>
    cfb6:	83 f9 01             	cmp    $0x1,%ecx
    cfb9:	75 32                	jne    cfed <fwp_drop8+0xbd>
    cfbb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    cfbf:	79 3a                	jns    cffb <fwp_drop8+0xcb>
    cfc1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    cfc5:	e8 16 dc ff ff       	call   abe0 <fwp_rc_free_arr>
    cfca:	48 89 d8             	mov    %rbx,%rax
    cfcd:	48 2b 05 c4 71 00 00 	sub    0x71c4(%rip),%rax        # 14198 <fwp_gc+0x1030>
    cfd4:	48 8b 0d e5 71 00 00 	mov    0x71e5(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    cfdb:	48 c1 e1 10          	shl    $0x10,%rcx
    cfdf:	48 89 df             	mov    %rbx,%rdi
    cfe2:	48 39 c8             	cmp    %rcx,%rax
    cfe5:	0f 82 64 ff ff ff    	jb     cf4f <fwp_drop8+0x1f>
    cfeb:	5b                   	pop    %rbx
    cfec:	c3                   	ret
    cfed:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cff3:	74 0c                	je     d001 <fwp_drop8+0xd1>
    cff5:	fe c9                	dec    %cl
    cff7:	88 08                	mov    %cl,(%rax)
    cff9:	5b                   	pop    %rbx
    cffa:	c3                   	ret
    cffb:	5b                   	pop    %rbx
    cffc:	e9 df db ff ff       	jmp    abe0 <fwp_rc_free_arr>
    d001:	48 89 c7             	mov    %rax,%rdi
    d004:	5b                   	pop    %rbx
    d005:	e9 e6 dc ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    d00a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d010 <fwp_owned_entry52>:
    d010:	48 8b 3f             	mov    (%rdi),%rdi
    d013:	e9 d8 fa ff ff       	jmp    caf0 <f52>
    d018:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d01f:	00 

000000000000d020 <fwp_caps52>:
    d020:	53                   	push   %rbx
    d021:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d025:	74 56                	je     d07d <fwp_caps52+0x5d>
    d027:	48 89 fb             	mov    %rdi,%rbx
    d02a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d02e:	85 f6                	test   %esi,%esi
    d030:	74 51                	je     d083 <fwp_caps52+0x63>
    d032:	48 2b 3d 5f 71 00 00 	sub    0x715f(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    d039:	48 8b 05 80 71 00 00 	mov    0x7180(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    d040:	48 c1 e0 10          	shl    $0x10,%rax
    d044:	48 39 c7             	cmp    %rax,%rdi
    d047:	73 38                	jae    d081 <fwp_caps52+0x61>
    d049:	48 8b 05 90 71 00 00 	mov    0x7190(%rip),%rax        # 141e0 <fwp_gc+0x1078>
    d050:	48 89 f9             	mov    %rdi,%rcx
    d053:	48 c1 e9 10          	shr    $0x10,%rcx
    d057:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d05e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d062:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d069:	75 26                	jne    d091 <fwp_caps52+0x71>
    d06b:	80 fa 02             	cmp    $0x2,%dl
    d06e:	75 21                	jne    d091 <fwp_caps52+0x71>
    d070:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d074:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d07b:	eb 33                	jmp    d0b0 <fwp_caps52+0x90>
    d07d:	85 f6                	test   %esi,%esi
    d07f:	74 0a                	je     d08b <fwp_caps52+0x6b>
    d081:	5b                   	pop    %rbx
    d082:	c3                   	ret
    d083:	e8 f8 fd ff ff       	call   ce80 <fwp_drop9>
    d088:	48 89 df             	mov    %rbx,%rdi
    d08b:	5b                   	pop    %rbx
    d08c:	e9 3f df ff ff       	jmp    afd0 <fwp_rc_free_obj>
    d091:	80 fa 01             	cmp    $0x1,%dl
    d094:	75 eb                	jne    d081 <fwp_caps52+0x61>
    d096:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d09a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d09e:	48 0f af f8          	imul   %rax,%rdi
    d0a2:	48 c1 ef 20          	shr    $0x20,%rdi
    d0a6:	48 01 d7             	add    %rdx,%rdi
    d0a9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d0b0:	0f b6 07             	movzbl (%rdi),%eax
    d0b3:	84 c0                	test   %al,%al
    d0b5:	74 ca                	je     d081 <fwp_caps52+0x61>
    d0b7:	3c fe                	cmp    $0xfe,%al
    d0b9:	73 06                	jae    d0c1 <fwp_caps52+0xa1>
    d0bb:	fe c0                	inc    %al
    d0bd:	88 07                	mov    %al,(%rdi)
    d0bf:	5b                   	pop    %rbx
    d0c0:	c3                   	ret
    d0c1:	5b                   	pop    %rbx
    d0c2:	e9 99 ab ff ff       	jmp    7c60 <fwp_rc_wide_dup>
    d0c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d0ce:	00 00 

000000000000d0d0 <fwp_args52>:
    d0d0:	85 f6                	test   %esi,%esi
    d0d2:	0f 85 8a 00 00 00    	jne    d162 <fwp_args52+0x92>
    d0d8:	85 d2                	test   %edx,%edx
    d0da:	0f 84 82 00 00 00    	je     d162 <fwp_args52+0x92>
    d0e0:	48 8b 07             	mov    (%rdi),%rax
    d0e3:	48 2b 05 ae 70 00 00 	sub    0x70ae(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d0ea:	48 8b 0d cf 70 00 00 	mov    0x70cf(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d0f1:	48 c1 e1 10          	shl    $0x10,%rcx
    d0f5:	48 39 c8             	cmp    %rcx,%rax
    d0f8:	73 68                	jae    d162 <fwp_args52+0x92>
    d0fa:	48 8b 0d df 70 00 00 	mov    0x70df(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d101:	48 89 c2             	mov    %rax,%rdx
    d104:	48 c1 ea 10          	shr    $0x10,%rdx
    d108:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d10f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d113:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d119:	75 13                	jne    d12e <fwp_args52+0x5e>
    d11b:	40 80 fe 02          	cmp    $0x2,%sil
    d11f:	75 0d                	jne    d12e <fwp_args52+0x5e>
    d121:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d125:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d12c:	eb 21                	jmp    d14f <fwp_args52+0x7f>
    d12e:	40 80 fe 01          	cmp    $0x1,%sil
    d132:	75 2e                	jne    d162 <fwp_args52+0x92>
    d134:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d138:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d13c:	48 0f af c1          	imul   %rcx,%rax
    d140:	48 c1 e8 20          	shr    $0x20,%rax
    d144:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d148:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d14f:	0f b6 07             	movzbl (%rdi),%eax
    d152:	84 c0                	test   %al,%al
    d154:	74 0c                	je     d162 <fwp_args52+0x92>
    d156:	3c fe                	cmp    $0xfe,%al
    d158:	0f 83 02 ab ff ff    	jae    7c60 <fwp_rc_wide_dup>
    d15e:	fe c0                	inc    %al
    d160:	88 07                	mov    %al,(%rdi)
    d162:	c3                   	ret
    d163:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d16a:	84 00 00 00 00 00 

000000000000d170 <fwp_arg_drop52>:
    d170:	85 f6                	test   %esi,%esi
    d172:	75 0c                	jne    d180 <fwp_arg_drop52+0x10>
    d174:	85 d2                	test   %edx,%edx
    d176:	74 08                	je     d180 <fwp_arg_drop52+0x10>
    d178:	48 8b 3f             	mov    (%rdi),%rdi
    d17b:	e9 00 fd ff ff       	jmp    ce80 <fwp_drop9>
    d180:	c3                   	ret
    d181:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d188:	0f 1f 84 00 00 00 00 
    d18f:	00 

000000000000d190 <fwp_drop10>:
    d190:	48 89 f8             	mov    %rdi,%rax
    d193:	48 2b 05 fe 6f 00 00 	sub    0x6ffe(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d19a:	48 8b 0d 1f 70 00 00 	mov    0x701f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d1a1:	48 c1 e1 10          	shl    $0x10,%rcx
    d1a5:	48 39 c8             	cmp    %rcx,%rax
    d1a8:	0f 83 92 00 00 00    	jae    d240 <fwp_drop10+0xb0>
    d1ae:	48 8b 0d 2b 70 00 00 	mov    0x702b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d1b5:	48 89 c2             	mov    %rax,%rdx
    d1b8:	48 c1 ea 10          	shr    $0x10,%rdx
    d1bc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d1c3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d1c7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d1cd:	75 12                	jne    d1e1 <fwp_drop10+0x51>
    d1cf:	40 80 fe 02          	cmp    $0x2,%sil
    d1d3:	75 0c                	jne    d1e1 <fwp_drop10+0x51>
    d1d5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d1d9:	48 05 28 02 00 00    	add    $0x228,%rax
    d1df:	eb 1f                	jmp    d200 <fwp_drop10+0x70>
    d1e1:	40 80 fe 01          	cmp    $0x1,%sil
    d1e5:	75 59                	jne    d240 <fwp_drop10+0xb0>
    d1e7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d1eb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d1ef:	48 0f af c1          	imul   %rcx,%rax
    d1f3:	48 c1 e8 20          	shr    $0x20,%rax
    d1f7:	48 01 f0             	add    %rsi,%rax
    d1fa:	48 05 28 02 00 00    	add    $0x228,%rax
    d200:	0f b6 08             	movzbl (%rax),%ecx
    d203:	85 c9                	test   %ecx,%ecx
    d205:	74 39                	je     d240 <fwp_drop10+0xb0>
    d207:	83 f9 01             	cmp    $0x1,%ecx
    d20a:	75 28                	jne    d234 <fwp_drop10+0xa4>
    d20c:	8b 07                	mov    (%rdi),%eax
    d20e:	83 f8 01             	cmp    $0x1,%eax
    d211:	0f 84 b9 dd ff ff    	je     afd0 <fwp_rc_free_obj>
    d217:	85 c0                	test   %eax,%eax
    d219:	75 25                	jne    d240 <fwp_drop10+0xb0>
    d21b:	53                   	push   %rbx
    d21c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    d220:	48 89 fb             	mov    %rdi,%rbx
    d223:	48 89 c7             	mov    %rax,%rdi
    d226:	e8 55 fc ff ff       	call   ce80 <fwp_drop9>
    d22b:	48 89 df             	mov    %rbx,%rdi
    d22e:	5b                   	pop    %rbx
    d22f:	e9 9c dd ff ff       	jmp    afd0 <fwp_rc_free_obj>
    d234:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d23a:	74 05                	je     d241 <fwp_drop10+0xb1>
    d23c:	fe c9                	dec    %cl
    d23e:	88 08                	mov    %cl,(%rax)
    d240:	c3                   	ret
    d241:	48 89 c7             	mov    %rax,%rdi
    d244:	e9 a7 da ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    d249:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000d250 <f55>:
    d250:	41 57                	push   %r15
    d252:	41 56                	push   %r14
    d254:	41 54                	push   %r12
    d256:	53                   	push   %rbx
    d257:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    d25e:	48 89 fb             	mov    %rdi,%rbx
    d261:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d265:	48 2b 05 2c 6f 00 00 	sub    0x6f2c(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d26c:	48 8b 0d 4d 6f 00 00 	mov    0x6f4d(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d273:	48 c1 e1 10          	shl    $0x10,%rcx
    d277:	48 39 c8             	cmp    %rcx,%rax
    d27a:	73 68                	jae    d2e4 <f55+0x94>
    d27c:	48 8b 0d 5d 6f 00 00 	mov    0x6f5d(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d283:	48 89 c2             	mov    %rax,%rdx
    d286:	48 c1 ea 10          	shr    $0x10,%rdx
    d28a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d291:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d295:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d29b:	75 13                	jne    d2b0 <f55+0x60>
    d29d:	40 80 fe 02          	cmp    $0x2,%sil
    d2a1:	75 0d                	jne    d2b0 <f55+0x60>
    d2a3:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d2a7:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d2ae:	eb 21                	jmp    d2d1 <f55+0x81>
    d2b0:	40 80 fe 01          	cmp    $0x1,%sil
    d2b4:	75 2e                	jne    d2e4 <f55+0x94>
    d2b6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d2ba:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d2be:	48 0f af c1          	imul   %rcx,%rax
    d2c2:	48 c1 e8 20          	shr    $0x20,%rax
    d2c6:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d2ca:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d2d1:	0f b6 07             	movzbl (%rdi),%eax
    d2d4:	84 c0                	test   %al,%al
    d2d6:	74 0c                	je     d2e4 <f55+0x94>
    d2d8:	3c fe                	cmp    $0xfe,%al
    d2da:	0f 83 dc 02 00 00    	jae    d5bc <f55+0x36c>
    d2e0:	fe c0                	inc    %al
    d2e2:	88 07                	mov    %al,(%rdi)
    d2e4:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    d2e8:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    d2ec:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
    d2f0:	4d 85 e4             	test   %r12,%r12
    d2f3:	78 27                	js     d31c <f55+0xcc>
    d2f5:	49 8b 06             	mov    (%r14),%rax
    d2f8:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d2ff:	ff ff 7f 
    d302:	48 21 c1             	and    %rax,%rcx
    d305:	4c 39 e1             	cmp    %r12,%rcx
    d308:	76 12                	jbe    d31c <f55+0xcc>
    d30a:	48 85 c0             	test   %rax,%rax
    d30d:	0f 88 8e 00 00 00    	js     d3a1 <f55+0x151>
    d313:	49 8d 46 08          	lea    0x8(%r14),%rax
    d317:	e9 89 00 00 00       	jmp    d3a5 <f55+0x155>
    d31c:	4c 89 f7             	mov    %r14,%rdi
    d31f:	e8 bc 03 00 00       	call   d6e0 <fwp_drop11>
    d324:	48 89 df             	mov    %rbx,%rdi
    d327:	e8 04 03 00 00       	call   d630 <fwp_drop12>
    d32c:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
    d333:	00 00 
    d335:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    d33a:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    d33f:	bf 01 00 00 00       	mov    $0x1,%edi
    d344:	be 01 00 00 00       	mov    $0x1,%esi
    d349:	e8 42 d1 ff ff       	call   a490 <fwp_data>
    d34e:	48 89 c1             	mov    %rax,%rcx
    d351:	48 2b 0d 40 6e 00 00 	sub    0x6e40(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    d358:	48 8b 15 61 6e 00 00 	mov    0x6e61(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    d35f:	48 c1 e2 10          	shl    $0x10,%rdx
    d363:	48 39 d1             	cmp    %rdx,%rcx
    d366:	0f 83 41 02 00 00    	jae    d5ad <f55+0x35d>
    d36c:	48 8b 15 6d 6e 00 00 	mov    0x6e6d(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    d373:	48 89 ce             	mov    %rcx,%rsi
    d376:	48 c1 ee 10          	shr    $0x10,%rsi
    d37a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d381:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d385:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d38c:	0f 85 e5 01 00 00    	jne    d577 <f55+0x327>
    d392:	40 80 ff 02          	cmp    $0x2,%dil
    d396:	0f 84 c6 01 00 00    	je     d562 <f55+0x312>
    d39c:	e9 d6 01 00 00       	jmp    d577 <f55+0x327>
    d3a1:	49 8b 46 10          	mov    0x10(%r14),%rax
    d3a5:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    d3aa:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    d3ae:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    d3b4:	0f 86 16 02 00 00    	jbe    d5d0 <f55+0x380>
    d3ba:	4c 89 f0             	mov    %r14,%rax
    d3bd:	48 2b 05 d4 6d 00 00 	sub    0x6dd4(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d3c4:	48 8b 0d f5 6d 00 00 	mov    0x6df5(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d3cb:	48 c1 e1 10          	shl    $0x10,%rcx
    d3cf:	48 39 c8             	cmp    %rcx,%rax
    d3d2:	73 68                	jae    d43c <f55+0x1ec>
    d3d4:	48 8b 0d 05 6e 00 00 	mov    0x6e05(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d3db:	48 89 c2             	mov    %rax,%rdx
    d3de:	48 c1 ea 10          	shr    $0x10,%rdx
    d3e2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d3e9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d3ed:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d3f3:	75 13                	jne    d408 <f55+0x1b8>
    d3f5:	40 80 fe 02          	cmp    $0x2,%sil
    d3f9:	75 0d                	jne    d408 <f55+0x1b8>
    d3fb:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d3ff:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d406:	eb 21                	jmp    d429 <f55+0x1d9>
    d408:	40 80 fe 01          	cmp    $0x1,%sil
    d40c:	75 2e                	jne    d43c <f55+0x1ec>
    d40e:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d412:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d416:	48 0f af c1          	imul   %rcx,%rax
    d41a:	48 c1 e8 20          	shr    $0x20,%rax
    d41e:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d422:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d429:	0f b6 07             	movzbl (%rdi),%eax
    d42c:	84 c0                	test   %al,%al
    d42e:	74 0c                	je     d43c <f55+0x1ec>
    d430:	3c fe                	cmp    $0xfe,%al
    d432:	0f 83 8e 01 00 00    	jae    d5c6 <f55+0x376>
    d438:	fe c0                	inc    %al
    d43a:	88 07                	mov    %al,(%rdi)
    d43c:	4c 89 f7             	mov    %r14,%rdi
    d43f:	e8 9c 02 00 00       	call   d6e0 <fwp_drop11>
    d444:	49 ff c7             	inc    %r15
    d447:	0f 80 93 01 00 00    	jo     d5e0 <f55+0x390>
    d44d:	49 ff c4             	inc    %r12
    d450:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    d455:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    d45a:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    d45f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d464:	31 ff                	xor    %edi,%edi
    d466:	be 03 00 00 00       	mov    $0x3,%esi
    d46b:	e8 20 d0 ff ff       	call   a490 <fwp_data>
    d470:	49 89 c6             	mov    %rax,%r14
    d473:	48 2b 05 1e 6d 00 00 	sub    0x6d1e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d47a:	48 8b 0d 3f 6d 00 00 	mov    0x6d3f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d481:	48 c1 e1 10          	shl    $0x10,%rcx
    d485:	48 39 c8             	cmp    %rcx,%rax
    d488:	73 6f                	jae    d4f9 <f55+0x2a9>
    d48a:	48 8b 0d 4f 6d 00 00 	mov    0x6d4f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d491:	48 89 c2             	mov    %rax,%rdx
    d494:	48 c1 ea 10          	shr    $0x10,%rdx
    d498:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d49f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d4a3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d4a9:	75 1d                	jne    d4c8 <f55+0x278>
    d4ab:	40 80 fe 02          	cmp    $0x2,%sil
    d4af:	75 17                	jne    d4c8 <f55+0x278>
    d4b1:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d4b5:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d4bc:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d4c0:	74 2d                	je     d4ef <f55+0x29f>
    d4c2:	41 c6 07 01          	movb   $0x1,(%r15)
    d4c6:	eb 31                	jmp    d4f9 <f55+0x2a9>
    d4c8:	40 80 fe 01          	cmp    $0x1,%sil
    d4cc:	75 2b                	jne    d4f9 <f55+0x2a9>
    d4ce:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d4d2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d4d6:	48 0f af c1          	imul   %rcx,%rax
    d4da:	48 c1 e8 20          	shr    $0x20,%rax
    d4de:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d4e2:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d4e9:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d4ed:	75 d3                	jne    d4c2 <f55+0x272>
    d4ef:	4c 89 ff             	mov    %r15,%rdi
    d4f2:	e8 d9 95 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    d4f7:	eb c9                	jmp    d4c2 <f55+0x272>
    d4f9:	48 89 df             	mov    %rbx,%rdi
    d4fc:	e8 2f 01 00 00       	call   d630 <fwp_drop12>
    d501:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    d508:	00 00 
    d50a:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    d50f:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    d514:	31 ff                	xor    %edi,%edi
    d516:	be 01 00 00 00       	mov    $0x1,%esi
    d51b:	e8 70 cf ff ff       	call   a490 <fwp_data>
    d520:	48 89 c1             	mov    %rax,%rcx
    d523:	48 2b 0d 6e 6c 00 00 	sub    0x6c6e(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    d52a:	48 8b 15 8f 6c 00 00 	mov    0x6c8f(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    d531:	48 c1 e2 10          	shl    $0x10,%rdx
    d535:	48 39 d1             	cmp    %rdx,%rcx
    d538:	73 73                	jae    d5ad <f55+0x35d>
    d53a:	48 8b 15 9f 6c 00 00 	mov    0x6c9f(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    d541:	48 89 ce             	mov    %rcx,%rsi
    d544:	48 c1 ee 10          	shr    $0x10,%rsi
    d548:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d54f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d553:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d55a:	75 1b                	jne    d577 <f55+0x327>
    d55c:	40 80 ff 02          	cmp    $0x2,%dil
    d560:	75 15                	jne    d577 <f55+0x327>
    d562:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    d566:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    d56d:	80 3b ff             	cmpb   $0xff,(%rbx)
    d570:	74 2b                	je     d59d <f55+0x34d>
    d572:	c6 03 01             	movb   $0x1,(%rbx)
    d575:	eb 36                	jmp    d5ad <f55+0x35d>
    d577:	40 80 ff 01          	cmp    $0x1,%dil
    d57b:	75 30                	jne    d5ad <f55+0x35d>
    d57d:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d581:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d585:	48 0f af ca          	imul   %rdx,%rcx
    d589:	48 c1 e9 20          	shr    $0x20,%rcx
    d58d:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    d591:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    d598:	80 3b ff             	cmpb   $0xff,(%rbx)
    d59b:	75 d5                	jne    d572 <f55+0x322>
    d59d:	48 89 df             	mov    %rbx,%rdi
    d5a0:	49 89 c6             	mov    %rax,%r14
    d5a3:	e8 28 95 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    d5a8:	4c 89 f0             	mov    %r14,%rax
    d5ab:	eb c5                	jmp    d572 <f55+0x322>
    d5ad:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    d5b4:	5b                   	pop    %rbx
    d5b5:	41 5c                	pop    %r12
    d5b7:	41 5e                	pop    %r14
    d5b9:	41 5f                	pop    %r15
    d5bb:	c3                   	ret
    d5bc:	e8 9f a6 ff ff       	call   7c60 <fwp_rc_wide_dup>
    d5c1:	e9 1e fd ff ff       	jmp    d2e4 <f55+0x94>
    d5c6:	e8 95 a6 ff ff       	call   7c60 <fwp_rc_wide_dup>
    d5cb:	e9 6c fe ff ff       	jmp    d43c <f55+0x1ec>
    d5d0:	48 8d 15 5b 21 00 00 	lea    0x215b(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    d5d7:	48 8d 0d 6c 20 00 00 	lea    0x206c(%rip),%rcx        # f64a <fwp_segv.msg+0x3ca>
    d5de:	eb 0e                	jmp    d5ee <f55+0x39e>
    d5e0:	48 8d 15 4b 21 00 00 	lea    0x214b(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    d5e7:	48 8d 0d 5e 21 00 00 	lea    0x215e(%rip),%rcx        # f74c <fwp_segv.msg+0x4cc>
    d5ee:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    d5f3:	be 60 00 00 00       	mov    $0x60,%esi
    d5f8:	48 89 df             	mov    %rbx,%rdi
    d5fb:	31 c0                	xor    %eax,%eax
    d5fd:	e8 fe 4a ff ff       	call   2100 <snprintf@plt>
    d602:	e8 99 94 ff ff       	call   6aa0 <fwp_flush>
    d607:	48 8b 05 d2 59 00 00 	mov    0x59d2(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    d60e:	48 8b 38             	mov    (%rax),%rdi
    d611:	48 8d 35 b5 1e 00 00 	lea    0x1eb5(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    d618:	48 89 da             	mov    %rbx,%rdx
    d61b:	31 c0                	xor    %eax,%eax
    d61d:	e8 7e 4b ff ff       	call   21a0 <fprintf@plt>
    d622:	bf 65 00 00 00       	mov    $0x65,%edi
    d627:	e8 44 4c ff ff       	call   2270 <exit@plt>
    d62c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000d630 <fwp_drop12>:
    d630:	48 89 f8             	mov    %rdi,%rax
    d633:	48 2b 05 5e 6b 00 00 	sub    0x6b5e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d63a:	48 8b 0d 7f 6b 00 00 	mov    0x6b7f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d641:	48 c1 e1 10          	shl    $0x10,%rcx
    d645:	48 39 c8             	cmp    %rcx,%rax
    d648:	0f 83 83 00 00 00    	jae    d6d1 <fwp_drop12+0xa1>
    d64e:	48 8b 0d 8b 6b 00 00 	mov    0x6b8b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d655:	48 89 c2             	mov    %rax,%rdx
    d658:	48 c1 ea 10          	shr    $0x10,%rdx
    d65c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d663:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d667:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d66d:	75 12                	jne    d681 <fwp_drop12+0x51>
    d66f:	40 80 fe 02          	cmp    $0x2,%sil
    d673:	75 0c                	jne    d681 <fwp_drop12+0x51>
    d675:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d679:	48 05 28 02 00 00    	add    $0x228,%rax
    d67f:	eb 1f                	jmp    d6a0 <fwp_drop12+0x70>
    d681:	40 80 fe 01          	cmp    $0x1,%sil
    d685:	75 4a                	jne    d6d1 <fwp_drop12+0xa1>
    d687:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d68b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d68f:	48 0f af c1          	imul   %rcx,%rax
    d693:	48 c1 e8 20          	shr    $0x20,%rax
    d697:	48 01 f0             	add    %rsi,%rax
    d69a:	48 05 28 02 00 00    	add    $0x228,%rax
    d6a0:	0f b6 08             	movzbl (%rax),%ecx
    d6a3:	85 c9                	test   %ecx,%ecx
    d6a5:	74 2a                	je     d6d1 <fwp_drop12+0xa1>
    d6a7:	83 f9 01             	cmp    $0x1,%ecx
    d6aa:	75 19                	jne    d6c5 <fwp_drop12+0x95>
    d6ac:	53                   	push   %rbx
    d6ad:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d6b1:	48 89 fb             	mov    %rdi,%rbx
    d6b4:	48 89 c7             	mov    %rax,%rdi
    d6b7:	e8 24 00 00 00       	call   d6e0 <fwp_drop11>
    d6bc:	48 89 df             	mov    %rbx,%rdi
    d6bf:	5b                   	pop    %rbx
    d6c0:	e9 0b d9 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    d6c5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d6cb:	74 05                	je     d6d2 <fwp_drop12+0xa2>
    d6cd:	fe c9                	dec    %cl
    d6cf:	88 08                	mov    %cl,(%rax)
    d6d1:	c3                   	ret
    d6d2:	48 89 c7             	mov    %rax,%rdi
    d6d5:	e9 16 d6 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    d6da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d6e0 <fwp_drop11>:
    d6e0:	53                   	push   %rbx
    d6e1:	48 89 f8             	mov    %rdi,%rax
    d6e4:	48 2b 05 ad 6a 00 00 	sub    0x6aad(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d6eb:	48 8b 0d ce 6a 00 00 	mov    0x6ace(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d6f2:	48 c1 e1 10          	shl    $0x10,%rcx
    d6f6:	48 39 c8             	cmp    %rcx,%rax
    d6f9:	0f 83 9c 00 00 00    	jae    d79b <fwp_drop11+0xbb>
    d6ff:	48 8b 0d da 6a 00 00 	mov    0x6ada(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d706:	48 89 c2             	mov    %rax,%rdx
    d709:	48 c1 ea 10          	shr    $0x10,%rdx
    d70d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d714:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d718:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d71e:	75 20                	jne    d740 <fwp_drop11+0x60>
    d720:	40 80 fe 02          	cmp    $0x2,%sil
    d724:	75 1a                	jne    d740 <fwp_drop11+0x60>
    d726:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d72a:	48 05 28 02 00 00    	add    $0x228,%rax
    d730:	eb 2d                	jmp    d75f <fwp_drop11+0x7f>
    d732:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d739:	1f 84 00 00 00 00 00 
    d740:	40 80 fe 01          	cmp    $0x1,%sil
    d744:	75 55                	jne    d79b <fwp_drop11+0xbb>
    d746:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d74a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d74e:	48 0f af c1          	imul   %rcx,%rax
    d752:	48 c1 e8 20          	shr    $0x20,%rax
    d756:	48 01 f0             	add    %rsi,%rax
    d759:	48 05 28 02 00 00    	add    $0x228,%rax
    d75f:	0f b6 08             	movzbl (%rax),%ecx
    d762:	85 c9                	test   %ecx,%ecx
    d764:	74 35                	je     d79b <fwp_drop11+0xbb>
    d766:	83 f9 01             	cmp    $0x1,%ecx
    d769:	75 32                	jne    d79d <fwp_drop11+0xbd>
    d76b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    d76f:	79 3a                	jns    d7ab <fwp_drop11+0xcb>
    d771:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    d775:	e8 66 d4 ff ff       	call   abe0 <fwp_rc_free_arr>
    d77a:	48 89 d8             	mov    %rbx,%rax
    d77d:	48 2b 05 14 6a 00 00 	sub    0x6a14(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d784:	48 8b 0d 35 6a 00 00 	mov    0x6a35(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d78b:	48 c1 e1 10          	shl    $0x10,%rcx
    d78f:	48 89 df             	mov    %rbx,%rdi
    d792:	48 39 c8             	cmp    %rcx,%rax
    d795:	0f 82 64 ff ff ff    	jb     d6ff <fwp_drop11+0x1f>
    d79b:	5b                   	pop    %rbx
    d79c:	c3                   	ret
    d79d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d7a3:	74 0c                	je     d7b1 <fwp_drop11+0xd1>
    d7a5:	fe c9                	dec    %cl
    d7a7:	88 08                	mov    %cl,(%rax)
    d7a9:	5b                   	pop    %rbx
    d7aa:	c3                   	ret
    d7ab:	5b                   	pop    %rbx
    d7ac:	e9 2f d4 ff ff       	jmp    abe0 <fwp_rc_free_arr>
    d7b1:	48 89 c7             	mov    %rax,%rdi
    d7b4:	5b                   	pop    %rbx
    d7b5:	e9 36 d5 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    d7ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d7c0 <fwp_owned_entry55>:
    d7c0:	48 8b 3f             	mov    (%rdi),%rdi
    d7c3:	e9 88 fa ff ff       	jmp    d250 <f55>
    d7c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d7cf:	00 

000000000000d7d0 <fwp_caps55>:
    d7d0:	53                   	push   %rbx
    d7d1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d7d5:	74 56                	je     d82d <fwp_caps55+0x5d>
    d7d7:	48 89 fb             	mov    %rdi,%rbx
    d7da:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d7de:	85 f6                	test   %esi,%esi
    d7e0:	74 51                	je     d833 <fwp_caps55+0x63>
    d7e2:	48 2b 3d af 69 00 00 	sub    0x69af(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    d7e9:	48 8b 05 d0 69 00 00 	mov    0x69d0(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    d7f0:	48 c1 e0 10          	shl    $0x10,%rax
    d7f4:	48 39 c7             	cmp    %rax,%rdi
    d7f7:	73 38                	jae    d831 <fwp_caps55+0x61>
    d7f9:	48 8b 05 e0 69 00 00 	mov    0x69e0(%rip),%rax        # 141e0 <fwp_gc+0x1078>
    d800:	48 89 f9             	mov    %rdi,%rcx
    d803:	48 c1 e9 10          	shr    $0x10,%rcx
    d807:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d80e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d812:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d819:	75 26                	jne    d841 <fwp_caps55+0x71>
    d81b:	80 fa 02             	cmp    $0x2,%dl
    d81e:	75 21                	jne    d841 <fwp_caps55+0x71>
    d820:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d824:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d82b:	eb 33                	jmp    d860 <fwp_caps55+0x90>
    d82d:	85 f6                	test   %esi,%esi
    d82f:	74 0a                	je     d83b <fwp_caps55+0x6b>
    d831:	5b                   	pop    %rbx
    d832:	c3                   	ret
    d833:	e8 f8 fd ff ff       	call   d630 <fwp_drop12>
    d838:	48 89 df             	mov    %rbx,%rdi
    d83b:	5b                   	pop    %rbx
    d83c:	e9 8f d7 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    d841:	80 fa 01             	cmp    $0x1,%dl
    d844:	75 eb                	jne    d831 <fwp_caps55+0x61>
    d846:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d84a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d84e:	48 0f af f8          	imul   %rax,%rdi
    d852:	48 c1 ef 20          	shr    $0x20,%rdi
    d856:	48 01 d7             	add    %rdx,%rdi
    d859:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d860:	0f b6 07             	movzbl (%rdi),%eax
    d863:	84 c0                	test   %al,%al
    d865:	74 ca                	je     d831 <fwp_caps55+0x61>
    d867:	3c fe                	cmp    $0xfe,%al
    d869:	73 06                	jae    d871 <fwp_caps55+0xa1>
    d86b:	fe c0                	inc    %al
    d86d:	88 07                	mov    %al,(%rdi)
    d86f:	5b                   	pop    %rbx
    d870:	c3                   	ret
    d871:	5b                   	pop    %rbx
    d872:	e9 e9 a3 ff ff       	jmp    7c60 <fwp_rc_wide_dup>
    d877:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d87e:	00 00 

000000000000d880 <fwp_args55>:
    d880:	85 f6                	test   %esi,%esi
    d882:	0f 85 8a 00 00 00    	jne    d912 <fwp_args55+0x92>
    d888:	85 d2                	test   %edx,%edx
    d88a:	0f 84 82 00 00 00    	je     d912 <fwp_args55+0x92>
    d890:	48 8b 07             	mov    (%rdi),%rax
    d893:	48 2b 05 fe 68 00 00 	sub    0x68fe(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d89a:	48 8b 0d 1f 69 00 00 	mov    0x691f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d8a1:	48 c1 e1 10          	shl    $0x10,%rcx
    d8a5:	48 39 c8             	cmp    %rcx,%rax
    d8a8:	73 68                	jae    d912 <fwp_args55+0x92>
    d8aa:	48 8b 0d 2f 69 00 00 	mov    0x692f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d8b1:	48 89 c2             	mov    %rax,%rdx
    d8b4:	48 c1 ea 10          	shr    $0x10,%rdx
    d8b8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d8bf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d8c3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d8c9:	75 13                	jne    d8de <fwp_args55+0x5e>
    d8cb:	40 80 fe 02          	cmp    $0x2,%sil
    d8cf:	75 0d                	jne    d8de <fwp_args55+0x5e>
    d8d1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d8d5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d8dc:	eb 21                	jmp    d8ff <fwp_args55+0x7f>
    d8de:	40 80 fe 01          	cmp    $0x1,%sil
    d8e2:	75 2e                	jne    d912 <fwp_args55+0x92>
    d8e4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d8e8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d8ec:	48 0f af c1          	imul   %rcx,%rax
    d8f0:	48 c1 e8 20          	shr    $0x20,%rax
    d8f4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d8f8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d8ff:	0f b6 07             	movzbl (%rdi),%eax
    d902:	84 c0                	test   %al,%al
    d904:	74 0c                	je     d912 <fwp_args55+0x92>
    d906:	3c fe                	cmp    $0xfe,%al
    d908:	0f 83 52 a3 ff ff    	jae    7c60 <fwp_rc_wide_dup>
    d90e:	fe c0                	inc    %al
    d910:	88 07                	mov    %al,(%rdi)
    d912:	c3                   	ret
    d913:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d91a:	84 00 00 00 00 00 

000000000000d920 <fwp_arg_drop55>:
    d920:	85 f6                	test   %esi,%esi
    d922:	75 0c                	jne    d930 <fwp_arg_drop55+0x10>
    d924:	85 d2                	test   %edx,%edx
    d926:	74 08                	je     d930 <fwp_arg_drop55+0x10>
    d928:	48 8b 3f             	mov    (%rdi),%rdi
    d92b:	e9 00 fd ff ff       	jmp    d630 <fwp_drop12>
    d930:	c3                   	ret
    d931:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d938:	0f 1f 84 00 00 00 00 
    d93f:	00 

000000000000d940 <fwp_drop13>:
    d940:	48 89 f8             	mov    %rdi,%rax
    d943:	48 2b 05 4e 68 00 00 	sub    0x684e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    d94a:	48 8b 0d 6f 68 00 00 	mov    0x686f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    d951:	48 c1 e1 10          	shl    $0x10,%rcx
    d955:	48 39 c8             	cmp    %rcx,%rax
    d958:	0f 83 92 00 00 00    	jae    d9f0 <fwp_drop13+0xb0>
    d95e:	48 8b 0d 7b 68 00 00 	mov    0x687b(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    d965:	48 89 c2             	mov    %rax,%rdx
    d968:	48 c1 ea 10          	shr    $0x10,%rdx
    d96c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d973:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d977:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d97d:	75 12                	jne    d991 <fwp_drop13+0x51>
    d97f:	40 80 fe 02          	cmp    $0x2,%sil
    d983:	75 0c                	jne    d991 <fwp_drop13+0x51>
    d985:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d989:	48 05 28 02 00 00    	add    $0x228,%rax
    d98f:	eb 1f                	jmp    d9b0 <fwp_drop13+0x70>
    d991:	40 80 fe 01          	cmp    $0x1,%sil
    d995:	75 59                	jne    d9f0 <fwp_drop13+0xb0>
    d997:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d99b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d99f:	48 0f af c1          	imul   %rcx,%rax
    d9a3:	48 c1 e8 20          	shr    $0x20,%rax
    d9a7:	48 01 f0             	add    %rsi,%rax
    d9aa:	48 05 28 02 00 00    	add    $0x228,%rax
    d9b0:	0f b6 08             	movzbl (%rax),%ecx
    d9b3:	85 c9                	test   %ecx,%ecx
    d9b5:	74 39                	je     d9f0 <fwp_drop13+0xb0>
    d9b7:	83 f9 01             	cmp    $0x1,%ecx
    d9ba:	75 28                	jne    d9e4 <fwp_drop13+0xa4>
    d9bc:	8b 07                	mov    (%rdi),%eax
    d9be:	83 f8 01             	cmp    $0x1,%eax
    d9c1:	0f 84 09 d6 ff ff    	je     afd0 <fwp_rc_free_obj>
    d9c7:	85 c0                	test   %eax,%eax
    d9c9:	75 25                	jne    d9f0 <fwp_drop13+0xb0>
    d9cb:	53                   	push   %rbx
    d9cc:	48 8b 47 08          	mov    0x8(%rdi),%rax
    d9d0:	48 89 fb             	mov    %rdi,%rbx
    d9d3:	48 89 c7             	mov    %rax,%rdi
    d9d6:	e8 55 fc ff ff       	call   d630 <fwp_drop12>
    d9db:	48 89 df             	mov    %rbx,%rdi
    d9de:	5b                   	pop    %rbx
    d9df:	e9 ec d5 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    d9e4:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d9ea:	74 05                	je     d9f1 <fwp_drop13+0xb1>
    d9ec:	fe c9                	dec    %cl
    d9ee:	88 08                	mov    %cl,(%rax)
    d9f0:	c3                   	ret
    d9f1:	48 89 c7             	mov    %rax,%rdi
    d9f4:	e9 f7 d2 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    d9f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000da00 <f57>:
    da00:	41 57                	push   %r15
    da02:	41 56                	push   %r14
    da04:	41 55                	push   %r13
    da06:	41 54                	push   %r12
    da08:	53                   	push   %rbx
    da09:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    da10:	48 89 fb             	mov    %rdi,%rbx
    da13:	48 8b 47 10          	mov    0x10(%rdi),%rax
    da17:	48 2b 05 7a 67 00 00 	sub    0x677a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    da1e:	48 8b 0d 9b 67 00 00 	mov    0x679b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    da25:	48 c1 e1 10          	shl    $0x10,%rcx
    da29:	48 39 c8             	cmp    %rcx,%rax
    da2c:	73 68                	jae    da96 <f57+0x96>
    da2e:	48 8b 0d ab 67 00 00 	mov    0x67ab(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    da35:	48 89 c2             	mov    %rax,%rdx
    da38:	48 c1 ea 10          	shr    $0x10,%rdx
    da3c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    da43:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    da47:	48 25 ff ff 00 00    	and    $0xffff,%rax
    da4d:	75 13                	jne    da62 <f57+0x62>
    da4f:	40 80 fe 02          	cmp    $0x2,%sil
    da53:	75 0d                	jne    da62 <f57+0x62>
    da55:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    da59:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    da60:	eb 21                	jmp    da83 <f57+0x83>
    da62:	40 80 fe 01          	cmp    $0x1,%sil
    da66:	75 2e                	jne    da96 <f57+0x96>
    da68:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    da6c:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    da70:	48 0f af c1          	imul   %rcx,%rax
    da74:	48 c1 e8 20          	shr    $0x20,%rax
    da78:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    da7c:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    da83:	0f b6 07             	movzbl (%rdi),%eax
    da86:	84 c0                	test   %al,%al
    da88:	74 0c                	je     da96 <f57+0x96>
    da8a:	3c fe                	cmp    $0xfe,%al
    da8c:	0f 83 ea 02 00 00    	jae    dd7c <f57+0x37c>
    da92:	fe c0                	inc    %al
    da94:	88 07                	mov    %al,(%rdi)
    da96:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    da9a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    da9e:	4c 0f be 7b 18       	movsbq 0x18(%rbx),%r15
    daa3:	4d 85 e4             	test   %r12,%r12
    daa6:	78 27                	js     dacf <f57+0xcf>
    daa8:	49 8b 06             	mov    (%r14),%rax
    daab:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    dab2:	ff ff 7f 
    dab5:	48 21 c1             	and    %rax,%rcx
    dab8:	4c 39 e1             	cmp    %r12,%rcx
    dabb:	76 12                	jbe    dacf <f57+0xcf>
    dabd:	48 85 c0             	test   %rax,%rax
    dac0:	0f 88 8e 00 00 00    	js     db54 <f57+0x154>
    dac6:	49 8d 46 08          	lea    0x8(%r14),%rax
    daca:	e9 89 00 00 00       	jmp    db58 <f57+0x158>
    dacf:	4c 89 f7             	mov    %r14,%rdi
    dad2:	e8 09 fc ff ff       	call   d6e0 <fwp_drop11>
    dad7:	48 89 df             	mov    %rbx,%rdi
    dada:	e8 01 03 00 00       	call   dde0 <fwp_drop14>
    dadf:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
    dae6:	00 00 
    dae8:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    daed:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    daf2:	bf 01 00 00 00       	mov    $0x1,%edi
    daf7:	be 01 00 00 00       	mov    $0x1,%esi
    dafc:	e8 8f c9 ff ff       	call   a490 <fwp_data>
    db01:	48 89 c1             	mov    %rax,%rcx
    db04:	48 2b 0d 8d 66 00 00 	sub    0x668d(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    db0b:	48 8b 15 ae 66 00 00 	mov    0x66ae(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    db12:	48 c1 e2 10          	shl    $0x10,%rdx
    db16:	48 39 d1             	cmp    %rdx,%rcx
    db19:	0f 83 4c 02 00 00    	jae    dd6b <f57+0x36b>
    db1f:	48 8b 15 ba 66 00 00 	mov    0x66ba(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    db26:	48 89 ce             	mov    %rcx,%rsi
    db29:	48 c1 ee 10          	shr    $0x10,%rsi
    db2d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    db34:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    db38:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    db3f:	0f 85 f0 01 00 00    	jne    dd35 <f57+0x335>
    db45:	40 80 ff 02          	cmp    $0x2,%dil
    db49:	0f 84 d1 01 00 00    	je     dd20 <f57+0x320>
    db4f:	e9 e1 01 00 00       	jmp    dd35 <f57+0x335>
    db54:	49 8b 46 10          	mov    0x10(%r14),%rax
    db58:	4e 0f be 2c 20       	movsbq (%rax,%r12,1),%r13
    db5d:	49 8d 45 81          	lea    -0x7f(%r13),%rax
    db61:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    db67:	0f 86 23 02 00 00    	jbe    dd90 <f57+0x390>
    db6d:	4c 89 f0             	mov    %r14,%rax
    db70:	48 2b 05 21 66 00 00 	sub    0x6621(%rip),%rax        # 14198 <fwp_gc+0x1030>
    db77:	48 8b 0d 42 66 00 00 	mov    0x6642(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    db7e:	48 c1 e1 10          	shl    $0x10,%rcx
    db82:	48 39 c8             	cmp    %rcx,%rax
    db85:	73 68                	jae    dbef <f57+0x1ef>
    db87:	48 8b 0d 52 66 00 00 	mov    0x6652(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    db8e:	48 89 c2             	mov    %rax,%rdx
    db91:	48 c1 ea 10          	shr    $0x10,%rdx
    db95:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    db9c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dba0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dba6:	75 13                	jne    dbbb <f57+0x1bb>
    dba8:	40 80 fe 02          	cmp    $0x2,%sil
    dbac:	75 0d                	jne    dbbb <f57+0x1bb>
    dbae:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    dbb2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dbb9:	eb 21                	jmp    dbdc <f57+0x1dc>
    dbbb:	40 80 fe 01          	cmp    $0x1,%sil
    dbbf:	75 2e                	jne    dbef <f57+0x1ef>
    dbc1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dbc5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dbc9:	48 0f af c1          	imul   %rcx,%rax
    dbcd:	48 c1 e8 20          	shr    $0x20,%rax
    dbd1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    dbd5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dbdc:	0f b6 07             	movzbl (%rdi),%eax
    dbdf:	84 c0                	test   %al,%al
    dbe1:	74 0c                	je     dbef <f57+0x1ef>
    dbe3:	3c fe                	cmp    $0xfe,%al
    dbe5:	0f 83 9b 01 00 00    	jae    dd86 <f57+0x386>
    dbeb:	fe c0                	inc    %al
    dbed:	88 07                	mov    %al,(%rdi)
    dbef:	4c 89 f7             	mov    %r14,%rdi
    dbf2:	e8 e9 fa ff ff       	call   d6e0 <fwp_drop11>
    dbf7:	4b 8d 04 2f          	lea    (%r15,%r13,1),%rax
    dbfb:	48 ff c0             	inc    %rax
    dbfe:	48 0f be c8          	movsbq %al,%rcx
    dc02:	48 39 c1             	cmp    %rax,%rcx
    dc05:	0f 85 85 01 00 00    	jne    dd90 <f57+0x390>
    dc0b:	49 ff c4             	inc    %r12
    dc0e:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    dc13:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    dc18:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    dc1d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    dc22:	31 ff                	xor    %edi,%edi
    dc24:	be 03 00 00 00       	mov    $0x3,%esi
    dc29:	e8 62 c8 ff ff       	call   a490 <fwp_data>
    dc2e:	49 89 c6             	mov    %rax,%r14
    dc31:	48 2b 05 60 65 00 00 	sub    0x6560(%rip),%rax        # 14198 <fwp_gc+0x1030>
    dc38:	48 8b 0d 81 65 00 00 	mov    0x6581(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    dc3f:	48 c1 e1 10          	shl    $0x10,%rcx
    dc43:	48 39 c8             	cmp    %rcx,%rax
    dc46:	73 6f                	jae    dcb7 <f57+0x2b7>
    dc48:	48 8b 0d 91 65 00 00 	mov    0x6591(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    dc4f:	48 89 c2             	mov    %rax,%rdx
    dc52:	48 c1 ea 10          	shr    $0x10,%rdx
    dc56:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dc5d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dc61:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dc67:	75 1d                	jne    dc86 <f57+0x286>
    dc69:	40 80 fe 02          	cmp    $0x2,%sil
    dc6d:	75 17                	jne    dc86 <f57+0x286>
    dc6f:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    dc73:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    dc7a:	41 80 3f ff          	cmpb   $0xff,(%r15)
    dc7e:	74 2d                	je     dcad <f57+0x2ad>
    dc80:	41 c6 07 01          	movb   $0x1,(%r15)
    dc84:	eb 31                	jmp    dcb7 <f57+0x2b7>
    dc86:	40 80 fe 01          	cmp    $0x1,%sil
    dc8a:	75 2b                	jne    dcb7 <f57+0x2b7>
    dc8c:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dc90:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dc94:	48 0f af c1          	imul   %rcx,%rax
    dc98:	48 c1 e8 20          	shr    $0x20,%rax
    dc9c:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    dca0:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    dca7:	41 80 3f ff          	cmpb   $0xff,(%r15)
    dcab:	75 d3                	jne    dc80 <f57+0x280>
    dcad:	4c 89 ff             	mov    %r15,%rdi
    dcb0:	e8 1b 8e ff ff       	call   6ad0 <fwp_rc_forget_slot>
    dcb5:	eb c9                	jmp    dc80 <f57+0x280>
    dcb7:	48 89 df             	mov    %rbx,%rdi
    dcba:	e8 21 01 00 00       	call   dde0 <fwp_drop14>
    dcbf:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    dcc6:	00 00 
    dcc8:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    dccd:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    dcd2:	31 ff                	xor    %edi,%edi
    dcd4:	be 01 00 00 00       	mov    $0x1,%esi
    dcd9:	e8 b2 c7 ff ff       	call   a490 <fwp_data>
    dcde:	48 89 c1             	mov    %rax,%rcx
    dce1:	48 2b 0d b0 64 00 00 	sub    0x64b0(%rip),%rcx        # 14198 <fwp_gc+0x1030>
    dce8:	48 8b 15 d1 64 00 00 	mov    0x64d1(%rip),%rdx        # 141c0 <fwp_gc+0x1058>
    dcef:	48 c1 e2 10          	shl    $0x10,%rdx
    dcf3:	48 39 d1             	cmp    %rdx,%rcx
    dcf6:	73 73                	jae    dd6b <f57+0x36b>
    dcf8:	48 8b 15 e1 64 00 00 	mov    0x64e1(%rip),%rdx        # 141e0 <fwp_gc+0x1078>
    dcff:	48 89 ce             	mov    %rcx,%rsi
    dd02:	48 c1 ee 10          	shr    $0x10,%rsi
    dd06:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    dd0d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    dd11:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    dd18:	75 1b                	jne    dd35 <f57+0x335>
    dd1a:	40 80 ff 02          	cmp    $0x2,%dil
    dd1e:	75 15                	jne    dd35 <f57+0x335>
    dd20:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    dd24:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    dd2b:	80 3b ff             	cmpb   $0xff,(%rbx)
    dd2e:	74 2b                	je     dd5b <f57+0x35b>
    dd30:	c6 03 01             	movb   $0x1,(%rbx)
    dd33:	eb 36                	jmp    dd6b <f57+0x36b>
    dd35:	40 80 ff 01          	cmp    $0x1,%dil
    dd39:	75 30                	jne    dd6b <f57+0x36b>
    dd3b:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    dd3f:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    dd43:	48 0f af ca          	imul   %rdx,%rcx
    dd47:	48 c1 e9 20          	shr    $0x20,%rcx
    dd4b:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    dd4f:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    dd56:	80 3b ff             	cmpb   $0xff,(%rbx)
    dd59:	75 d5                	jne    dd30 <f57+0x330>
    dd5b:	48 89 df             	mov    %rbx,%rdi
    dd5e:	49 89 c6             	mov    %rax,%r14
    dd61:	e8 6a 8d ff ff       	call   6ad0 <fwp_rc_forget_slot>
    dd66:	4c 89 f0             	mov    %r14,%rax
    dd69:	eb c5                	jmp    dd30 <f57+0x330>
    dd6b:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    dd72:	5b                   	pop    %rbx
    dd73:	41 5c                	pop    %r12
    dd75:	41 5d                	pop    %r13
    dd77:	41 5e                	pop    %r14
    dd79:	41 5f                	pop    %r15
    dd7b:	c3                   	ret
    dd7c:	e8 df 9e ff ff       	call   7c60 <fwp_rc_wide_dup>
    dd81:	e9 10 fd ff ff       	jmp    da96 <f57+0x96>
    dd86:	e8 d5 9e ff ff       	call   7c60 <fwp_rc_wide_dup>
    dd8b:	e9 5f fe ff ff       	jmp    dbef <f57+0x1ef>
    dd90:	48 8d 15 9b 19 00 00 	lea    0x199b(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    dd97:	48 8d 0d ac 18 00 00 	lea    0x18ac(%rip),%rcx        # f64a <fwp_segv.msg+0x3ca>
    dd9e:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    dda3:	be 60 00 00 00       	mov    $0x60,%esi
    dda8:	48 89 df             	mov    %rbx,%rdi
    ddab:	31 c0                	xor    %eax,%eax
    ddad:	e8 4e 43 ff ff       	call   2100 <snprintf@plt>
    ddb2:	e8 e9 8c ff ff       	call   6aa0 <fwp_flush>
    ddb7:	48 8b 05 22 52 00 00 	mov    0x5222(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    ddbe:	48 8b 38             	mov    (%rax),%rdi
    ddc1:	48 8d 35 05 17 00 00 	lea    0x1705(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    ddc8:	48 89 da             	mov    %rbx,%rdx
    ddcb:	31 c0                	xor    %eax,%eax
    ddcd:	e8 ce 43 ff ff       	call   21a0 <fprintf@plt>
    ddd2:	bf 65 00 00 00       	mov    $0x65,%edi
    ddd7:	e8 94 44 ff ff       	call   2270 <exit@plt>
    dddc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000dde0 <fwp_drop14>:
    dde0:	48 89 f8             	mov    %rdi,%rax
    dde3:	48 2b 05 ae 63 00 00 	sub    0x63ae(%rip),%rax        # 14198 <fwp_gc+0x1030>
    ddea:	48 8b 0d cf 63 00 00 	mov    0x63cf(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    ddf1:	48 c1 e1 10          	shl    $0x10,%rcx
    ddf5:	48 39 c8             	cmp    %rcx,%rax
    ddf8:	0f 83 83 00 00 00    	jae    de81 <fwp_drop14+0xa1>
    ddfe:	48 8b 0d db 63 00 00 	mov    0x63db(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    de05:	48 89 c2             	mov    %rax,%rdx
    de08:	48 c1 ea 10          	shr    $0x10,%rdx
    de0c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    de13:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    de17:	48 25 ff ff 00 00    	and    $0xffff,%rax
    de1d:	75 12                	jne    de31 <fwp_drop14+0x51>
    de1f:	40 80 fe 02          	cmp    $0x2,%sil
    de23:	75 0c                	jne    de31 <fwp_drop14+0x51>
    de25:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    de29:	48 05 28 02 00 00    	add    $0x228,%rax
    de2f:	eb 1f                	jmp    de50 <fwp_drop14+0x70>
    de31:	40 80 fe 01          	cmp    $0x1,%sil
    de35:	75 4a                	jne    de81 <fwp_drop14+0xa1>
    de37:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    de3b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    de3f:	48 0f af c1          	imul   %rcx,%rax
    de43:	48 c1 e8 20          	shr    $0x20,%rax
    de47:	48 01 f0             	add    %rsi,%rax
    de4a:	48 05 28 02 00 00    	add    $0x228,%rax
    de50:	0f b6 08             	movzbl (%rax),%ecx
    de53:	85 c9                	test   %ecx,%ecx
    de55:	74 2a                	je     de81 <fwp_drop14+0xa1>
    de57:	83 f9 01             	cmp    $0x1,%ecx
    de5a:	75 19                	jne    de75 <fwp_drop14+0x95>
    de5c:	53                   	push   %rbx
    de5d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    de61:	48 89 fb             	mov    %rdi,%rbx
    de64:	48 89 c7             	mov    %rax,%rdi
    de67:	e8 74 f8 ff ff       	call   d6e0 <fwp_drop11>
    de6c:	48 89 df             	mov    %rbx,%rdi
    de6f:	5b                   	pop    %rbx
    de70:	e9 5b d1 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    de75:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    de7b:	74 05                	je     de82 <fwp_drop14+0xa2>
    de7d:	fe c9                	dec    %cl
    de7f:	88 08                	mov    %cl,(%rax)
    de81:	c3                   	ret
    de82:	48 89 c7             	mov    %rax,%rdi
    de85:	e9 66 ce ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    de8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000de90 <fwp_owned_entry57>:
    de90:	48 8b 3f             	mov    (%rdi),%rdi
    de93:	e9 68 fb ff ff       	jmp    da00 <f57>
    de98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    de9f:	00 

000000000000dea0 <fwp_caps57>:
    dea0:	53                   	push   %rbx
    dea1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    dea5:	74 56                	je     defd <fwp_caps57+0x5d>
    dea7:	48 89 fb             	mov    %rdi,%rbx
    deaa:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    deae:	85 f6                	test   %esi,%esi
    deb0:	74 51                	je     df03 <fwp_caps57+0x63>
    deb2:	48 2b 3d df 62 00 00 	sub    0x62df(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    deb9:	48 8b 05 00 63 00 00 	mov    0x6300(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    dec0:	48 c1 e0 10          	shl    $0x10,%rax
    dec4:	48 39 c7             	cmp    %rax,%rdi
    dec7:	73 38                	jae    df01 <fwp_caps57+0x61>
    dec9:	48 8b 05 10 63 00 00 	mov    0x6310(%rip),%rax        # 141e0 <fwp_gc+0x1078>
    ded0:	48 89 f9             	mov    %rdi,%rcx
    ded3:	48 c1 e9 10          	shr    $0x10,%rcx
    ded7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    dede:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    dee2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    dee9:	75 26                	jne    df11 <fwp_caps57+0x71>
    deeb:	80 fa 02             	cmp    $0x2,%dl
    deee:	75 21                	jne    df11 <fwp_caps57+0x71>
    def0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    def4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    defb:	eb 33                	jmp    df30 <fwp_caps57+0x90>
    defd:	85 f6                	test   %esi,%esi
    deff:	74 0a                	je     df0b <fwp_caps57+0x6b>
    df01:	5b                   	pop    %rbx
    df02:	c3                   	ret
    df03:	e8 d8 fe ff ff       	call   dde0 <fwp_drop14>
    df08:	48 89 df             	mov    %rbx,%rdi
    df0b:	5b                   	pop    %rbx
    df0c:	e9 bf d0 ff ff       	jmp    afd0 <fwp_rc_free_obj>
    df11:	80 fa 01             	cmp    $0x1,%dl
    df14:	75 eb                	jne    df01 <fwp_caps57+0x61>
    df16:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    df1a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    df1e:	48 0f af f8          	imul   %rax,%rdi
    df22:	48 c1 ef 20          	shr    $0x20,%rdi
    df26:	48 01 d7             	add    %rdx,%rdi
    df29:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    df30:	0f b6 07             	movzbl (%rdi),%eax
    df33:	84 c0                	test   %al,%al
    df35:	74 ca                	je     df01 <fwp_caps57+0x61>
    df37:	3c fe                	cmp    $0xfe,%al
    df39:	73 06                	jae    df41 <fwp_caps57+0xa1>
    df3b:	fe c0                	inc    %al
    df3d:	88 07                	mov    %al,(%rdi)
    df3f:	5b                   	pop    %rbx
    df40:	c3                   	ret
    df41:	5b                   	pop    %rbx
    df42:	e9 19 9d ff ff       	jmp    7c60 <fwp_rc_wide_dup>
    df47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    df4e:	00 00 

000000000000df50 <fwp_args57>:
    df50:	85 f6                	test   %esi,%esi
    df52:	0f 85 8a 00 00 00    	jne    dfe2 <fwp_args57+0x92>
    df58:	85 d2                	test   %edx,%edx
    df5a:	0f 84 82 00 00 00    	je     dfe2 <fwp_args57+0x92>
    df60:	48 8b 07             	mov    (%rdi),%rax
    df63:	48 2b 05 2e 62 00 00 	sub    0x622e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    df6a:	48 8b 0d 4f 62 00 00 	mov    0x624f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    df71:	48 c1 e1 10          	shl    $0x10,%rcx
    df75:	48 39 c8             	cmp    %rcx,%rax
    df78:	73 68                	jae    dfe2 <fwp_args57+0x92>
    df7a:	48 8b 0d 5f 62 00 00 	mov    0x625f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    df81:	48 89 c2             	mov    %rax,%rdx
    df84:	48 c1 ea 10          	shr    $0x10,%rdx
    df88:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    df8f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    df93:	48 25 ff ff 00 00    	and    $0xffff,%rax
    df99:	75 13                	jne    dfae <fwp_args57+0x5e>
    df9b:	40 80 fe 02          	cmp    $0x2,%sil
    df9f:	75 0d                	jne    dfae <fwp_args57+0x5e>
    dfa1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    dfa5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dfac:	eb 21                	jmp    dfcf <fwp_args57+0x7f>
    dfae:	40 80 fe 01          	cmp    $0x1,%sil
    dfb2:	75 2e                	jne    dfe2 <fwp_args57+0x92>
    dfb4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dfb8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dfbc:	48 0f af c1          	imul   %rcx,%rax
    dfc0:	48 c1 e8 20          	shr    $0x20,%rax
    dfc4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    dfc8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dfcf:	0f b6 07             	movzbl (%rdi),%eax
    dfd2:	84 c0                	test   %al,%al
    dfd4:	74 0c                	je     dfe2 <fwp_args57+0x92>
    dfd6:	3c fe                	cmp    $0xfe,%al
    dfd8:	0f 83 82 9c ff ff    	jae    7c60 <fwp_rc_wide_dup>
    dfde:	fe c0                	inc    %al
    dfe0:	88 07                	mov    %al,(%rdi)
    dfe2:	c3                   	ret
    dfe3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dfea:	84 00 00 00 00 00 

000000000000dff0 <fwp_arg_drop57>:
    dff0:	85 f6                	test   %esi,%esi
    dff2:	75 0c                	jne    e000 <fwp_arg_drop57+0x10>
    dff4:	85 d2                	test   %edx,%edx
    dff6:	74 08                	je     e000 <fwp_arg_drop57+0x10>
    dff8:	48 8b 3f             	mov    (%rdi),%rdi
    dffb:	e9 e0 fd ff ff       	jmp    dde0 <fwp_drop14>
    e000:	c3                   	ret
    e001:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e008:	0f 1f 84 00 00 00 00 
    e00f:	00 

000000000000e010 <fwp_drop15>:
    e010:	48 89 f8             	mov    %rdi,%rax
    e013:	48 2b 05 7e 61 00 00 	sub    0x617e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e01a:	48 8b 0d 9f 61 00 00 	mov    0x619f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e021:	48 c1 e1 10          	shl    $0x10,%rcx
    e025:	48 39 c8             	cmp    %rcx,%rax
    e028:	0f 83 92 00 00 00    	jae    e0c0 <fwp_drop15+0xb0>
    e02e:	48 8b 0d ab 61 00 00 	mov    0x61ab(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e035:	48 89 c2             	mov    %rax,%rdx
    e038:	48 c1 ea 10          	shr    $0x10,%rdx
    e03c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e043:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e047:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e04d:	75 12                	jne    e061 <fwp_drop15+0x51>
    e04f:	40 80 fe 02          	cmp    $0x2,%sil
    e053:	75 0c                	jne    e061 <fwp_drop15+0x51>
    e055:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e059:	48 05 28 02 00 00    	add    $0x228,%rax
    e05f:	eb 1f                	jmp    e080 <fwp_drop15+0x70>
    e061:	40 80 fe 01          	cmp    $0x1,%sil
    e065:	75 59                	jne    e0c0 <fwp_drop15+0xb0>
    e067:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e06b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e06f:	48 0f af c1          	imul   %rcx,%rax
    e073:	48 c1 e8 20          	shr    $0x20,%rax
    e077:	48 01 f0             	add    %rsi,%rax
    e07a:	48 05 28 02 00 00    	add    $0x228,%rax
    e080:	0f b6 08             	movzbl (%rax),%ecx
    e083:	85 c9                	test   %ecx,%ecx
    e085:	74 39                	je     e0c0 <fwp_drop15+0xb0>
    e087:	83 f9 01             	cmp    $0x1,%ecx
    e08a:	75 28                	jne    e0b4 <fwp_drop15+0xa4>
    e08c:	8b 07                	mov    (%rdi),%eax
    e08e:	83 f8 01             	cmp    $0x1,%eax
    e091:	0f 84 39 cf ff ff    	je     afd0 <fwp_rc_free_obj>
    e097:	85 c0                	test   %eax,%eax
    e099:	75 25                	jne    e0c0 <fwp_drop15+0xb0>
    e09b:	53                   	push   %rbx
    e09c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    e0a0:	48 89 fb             	mov    %rdi,%rbx
    e0a3:	48 89 c7             	mov    %rax,%rdi
    e0a6:	e8 35 fd ff ff       	call   dde0 <fwp_drop14>
    e0ab:	48 89 df             	mov    %rbx,%rdi
    e0ae:	5b                   	pop    %rbx
    e0af:	e9 1c cf ff ff       	jmp    afd0 <fwp_rc_free_obj>
    e0b4:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e0ba:	74 05                	je     e0c1 <fwp_drop15+0xb1>
    e0bc:	fe c9                	dec    %cl
    e0be:	88 08                	mov    %cl,(%rax)
    e0c0:	c3                   	ret
    e0c1:	48 89 c7             	mov    %rax,%rdi
    e0c4:	e9 27 cc ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    e0c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000e0d0 <f59>:
    e0d0:	41 57                	push   %r15
    e0d2:	41 56                	push   %r14
    e0d4:	53                   	push   %rbx
    e0d5:	48 83 ec 30          	sub    $0x30,%rsp
    e0d9:	48 89 fb             	mov    %rdi,%rbx
    e0dc:	48 8b 47 10          	mov    0x10(%rdi),%rax
    e0e0:	48 2b 05 b1 60 00 00 	sub    0x60b1(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e0e7:	48 8b 0d d2 60 00 00 	mov    0x60d2(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e0ee:	48 c1 e1 10          	shl    $0x10,%rcx
    e0f2:	48 39 c8             	cmp    %rcx,%rax
    e0f5:	73 68                	jae    e15f <f59+0x8f>
    e0f7:	48 8b 0d e2 60 00 00 	mov    0x60e2(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e0fe:	48 89 c2             	mov    %rax,%rdx
    e101:	48 c1 ea 10          	shr    $0x10,%rdx
    e105:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e10c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e110:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e116:	75 13                	jne    e12b <f59+0x5b>
    e118:	40 80 fe 02          	cmp    $0x2,%sil
    e11c:	75 0d                	jne    e12b <f59+0x5b>
    e11e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    e122:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e129:	eb 21                	jmp    e14c <f59+0x7c>
    e12b:	40 80 fe 01          	cmp    $0x1,%sil
    e12f:	75 2e                	jne    e15f <f59+0x8f>
    e131:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e135:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e139:	48 0f af c1          	imul   %rcx,%rax
    e13d:	48 c1 e8 20          	shr    $0x20,%rax
    e141:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    e145:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e14c:	0f b6 07             	movzbl (%rdi),%eax
    e14f:	84 c0                	test   %al,%al
    e151:	74 0c                	je     e15f <f59+0x8f>
    e153:	3c fe                	cmp    $0xfe,%al
    e155:	0f 83 d8 01 00 00    	jae    e333 <f59+0x263>
    e15b:	fe c0                	inc    %al
    e15d:	88 07                	mov    %al,(%rdi)
    e15f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    e163:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    e167:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    e16b:	4d 85 ff             	test   %r15,%r15
    e16e:	78 20                	js     e190 <f59+0xc0>
    e170:	48 8b 07             	mov    (%rdi),%rax
    e173:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    e17a:	ff ff 7f 
    e17d:	48 21 c1             	and    %rax,%rcx
    e180:	4c 39 f9             	cmp    %r15,%rcx
    e183:	76 0b                	jbe    e190 <f59+0xc0>
    e185:	48 85 c0             	test   %rax,%rax
    e188:	78 2e                	js     e1b8 <f59+0xe8>
    e18a:	48 8d 47 08          	lea    0x8(%rdi),%rax
    e18e:	eb 2c                	jmp    e1bc <f59+0xec>
    e190:	e8 6b c9 ff ff       	call   ab00 <fwp_drop1>
    e195:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    e19b:	48 89 df             	mov    %rbx,%rdi
    e19e:	e8 8d c7 ff ff       	call   a930 <fwp_drop6>
    e1a3:	4c 89 ff             	mov    %r15,%rdi
    e1a6:	4c 89 f6             	mov    %r14,%rsi
    e1a9:	e8 32 c8 ff ff       	call   a9e0 <fwp_vbox1>
    e1ae:	48 83 c4 30          	add    $0x30,%rsp
    e1b2:	5b                   	pop    %rbx
    e1b3:	41 5e                	pop    %r14
    e1b5:	41 5f                	pop    %r15
    e1b7:	c3                   	ret
    e1b8:	48 8b 47 10          	mov    0x10(%rdi),%rax
    e1bc:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    e1c1:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    e1c7:	f2 0f 59 05 41 0e 00 	mulsd  0xe41(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    e1ce:	00 
    e1cf:	f2 0f 58 05 41 0e 00 	addsd  0xe41(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    e1d6:	00 
    e1d7:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    e1dd:	48 89 f8             	mov    %rdi,%rax
    e1e0:	48 2b 05 b1 5f 00 00 	sub    0x5fb1(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e1e7:	49 ff c7             	inc    %r15
    e1ea:	48 8b 0d cf 5f 00 00 	mov    0x5fcf(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e1f1:	48 c1 e1 10          	shl    $0x10,%rcx
    e1f5:	48 39 c8             	cmp    %rcx,%rax
    e1f8:	73 66                	jae    e260 <f59+0x190>
    e1fa:	48 8b 0d df 5f 00 00 	mov    0x5fdf(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e201:	48 89 c2             	mov    %rax,%rdx
    e204:	48 c1 ea 10          	shr    $0x10,%rdx
    e208:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e20f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e213:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e219:	75 12                	jne    e22d <f59+0x15d>
    e21b:	40 80 fe 02          	cmp    $0x2,%sil
    e21f:	75 0c                	jne    e22d <f59+0x15d>
    e221:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e225:	48 05 28 02 00 00    	add    $0x228,%rax
    e22b:	eb 1f                	jmp    e24c <f59+0x17c>
    e22d:	40 80 fe 01          	cmp    $0x1,%sil
    e231:	75 2d                	jne    e260 <f59+0x190>
    e233:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e237:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e23b:	48 0f af c1          	imul   %rcx,%rax
    e23f:	48 c1 e8 20          	shr    $0x20,%rax
    e243:	48 01 f0             	add    %rsi,%rax
    e246:	48 05 28 02 00 00    	add    $0x228,%rax
    e24c:	0f b6 08             	movzbl (%rax),%ecx
    e24f:	84 c9                	test   %cl,%cl
    e251:	74 0d                	je     e260 <f59+0x190>
    e253:	80 f9 fe             	cmp    $0xfe,%cl
    e256:	0f 83 e1 00 00 00    	jae    e33d <f59+0x26d>
    e25c:	fe c1                	inc    %cl
    e25e:	88 08                	mov    %cl,(%rax)
    e260:	49 89 fe             	mov    %rdi,%r14
    e263:	e8 98 c8 ff ff       	call   ab00 <fwp_drop1>
    e268:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    e26e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    e274:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    e279:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    e27e:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    e284:	45 31 ff             	xor    %r15d,%r15d
    e287:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    e28c:	31 ff                	xor    %edi,%edi
    e28e:	be 03 00 00 00       	mov    $0x3,%esi
    e293:	e8 f8 c1 ff ff       	call   a490 <fwp_data>
    e298:	49 89 c6             	mov    %rax,%r14
    e29b:	48 2b 05 f6 5e 00 00 	sub    0x5ef6(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e2a2:	48 8b 0d 17 5f 00 00 	mov    0x5f17(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e2a9:	48 c1 e1 10          	shl    $0x10,%rcx
    e2ad:	48 39 c8             	cmp    %rcx,%rax
    e2b0:	0f 83 e5 fe ff ff    	jae    e19b <f59+0xcb>
    e2b6:	48 8b 0d 23 5f 00 00 	mov    0x5f23(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e2bd:	48 89 c2             	mov    %rax,%rdx
    e2c0:	48 c1 ea 10          	shr    $0x10,%rdx
    e2c4:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e2cb:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e2cf:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e2d5:	75 23                	jne    e2fa <f59+0x22a>
    e2d7:	40 80 fe 02          	cmp    $0x2,%sil
    e2db:	75 1d                	jne    e2fa <f59+0x22a>
    e2dd:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    e2e1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    e2e8:	41 80 3f ff          	cmpb   $0xff,(%r15)
    e2ec:	74 33                	je     e321 <f59+0x251>
    e2ee:	41 c6 07 01          	movb   $0x1,(%r15)
    e2f2:	45 31 ff             	xor    %r15d,%r15d
    e2f5:	e9 a1 fe ff ff       	jmp    e19b <f59+0xcb>
    e2fa:	40 80 fe 01          	cmp    $0x1,%sil
    e2fe:	75 2b                	jne    e32b <f59+0x25b>
    e300:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e304:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e308:	48 0f af c1          	imul   %rcx,%rax
    e30c:	48 c1 e8 20          	shr    $0x20,%rax
    e310:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    e314:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    e31b:	41 80 3f ff          	cmpb   $0xff,(%r15)
    e31f:	75 cd                	jne    e2ee <f59+0x21e>
    e321:	4c 89 ff             	mov    %r15,%rdi
    e324:	e8 a7 87 ff ff       	call   6ad0 <fwp_rc_forget_slot>
    e329:	eb c3                	jmp    e2ee <f59+0x21e>
    e32b:	45 31 ff             	xor    %r15d,%r15d
    e32e:	e9 68 fe ff ff       	jmp    e19b <f59+0xcb>
    e333:	e8 28 99 ff ff       	call   7c60 <fwp_rc_wide_dup>
    e338:	e9 22 fe ff ff       	jmp    e15f <f59+0x8f>
    e33d:	49 89 fe             	mov    %rdi,%r14
    e340:	48 89 c7             	mov    %rax,%rdi
    e343:	e8 18 99 ff ff       	call   7c60 <fwp_rc_wide_dup>
    e348:	4c 89 f7             	mov    %r14,%rdi
    e34b:	e9 10 ff ff ff       	jmp    e260 <f59+0x190>

000000000000e350 <fwp_owned_entry59>:
    e350:	48 8b 3f             	mov    (%rdi),%rdi
    e353:	e9 78 fd ff ff       	jmp    e0d0 <f59>
    e358:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e35f:	00 

000000000000e360 <fwp_caps59>:
    e360:	53                   	push   %rbx
    e361:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    e365:	74 56                	je     e3bd <fwp_caps59+0x5d>
    e367:	48 89 fb             	mov    %rdi,%rbx
    e36a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    e36e:	85 f6                	test   %esi,%esi
    e370:	74 51                	je     e3c3 <fwp_caps59+0x63>
    e372:	48 2b 3d 1f 5e 00 00 	sub    0x5e1f(%rip),%rdi        # 14198 <fwp_gc+0x1030>
    e379:	48 8b 05 40 5e 00 00 	mov    0x5e40(%rip),%rax        # 141c0 <fwp_gc+0x1058>
    e380:	48 c1 e0 10          	shl    $0x10,%rax
    e384:	48 39 c7             	cmp    %rax,%rdi
    e387:	73 38                	jae    e3c1 <fwp_caps59+0x61>
    e389:	48 8b 05 50 5e 00 00 	mov    0x5e50(%rip),%rax        # 141e0 <fwp_gc+0x1078>
    e390:	48 89 f9             	mov    %rdi,%rcx
    e393:	48 c1 e9 10          	shr    $0x10,%rcx
    e397:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    e39e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    e3a2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    e3a9:	75 26                	jne    e3d1 <fwp_caps59+0x71>
    e3ab:	80 fa 02             	cmp    $0x2,%dl
    e3ae:	75 21                	jne    e3d1 <fwp_caps59+0x71>
    e3b0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    e3b4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e3bb:	eb 33                	jmp    e3f0 <fwp_caps59+0x90>
    e3bd:	85 f6                	test   %esi,%esi
    e3bf:	74 0a                	je     e3cb <fwp_caps59+0x6b>
    e3c1:	5b                   	pop    %rbx
    e3c2:	c3                   	ret
    e3c3:	e8 68 c5 ff ff       	call   a930 <fwp_drop6>
    e3c8:	48 89 df             	mov    %rbx,%rdi
    e3cb:	5b                   	pop    %rbx
    e3cc:	e9 ff cb ff ff       	jmp    afd0 <fwp_rc_free_obj>
    e3d1:	80 fa 01             	cmp    $0x1,%dl
    e3d4:	75 eb                	jne    e3c1 <fwp_caps59+0x61>
    e3d6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    e3da:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    e3de:	48 0f af f8          	imul   %rax,%rdi
    e3e2:	48 c1 ef 20          	shr    $0x20,%rdi
    e3e6:	48 01 d7             	add    %rdx,%rdi
    e3e9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e3f0:	0f b6 07             	movzbl (%rdi),%eax
    e3f3:	84 c0                	test   %al,%al
    e3f5:	74 ca                	je     e3c1 <fwp_caps59+0x61>
    e3f7:	3c fe                	cmp    $0xfe,%al
    e3f9:	73 06                	jae    e401 <fwp_caps59+0xa1>
    e3fb:	fe c0                	inc    %al
    e3fd:	88 07                	mov    %al,(%rdi)
    e3ff:	5b                   	pop    %rbx
    e400:	c3                   	ret
    e401:	5b                   	pop    %rbx
    e402:	e9 59 98 ff ff       	jmp    7c60 <fwp_rc_wide_dup>
    e407:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e40e:	00 00 

000000000000e410 <fwp_args59>:
    e410:	85 f6                	test   %esi,%esi
    e412:	0f 85 8a 00 00 00    	jne    e4a2 <fwp_args59+0x92>
    e418:	85 d2                	test   %edx,%edx
    e41a:	0f 84 82 00 00 00    	je     e4a2 <fwp_args59+0x92>
    e420:	48 8b 07             	mov    (%rdi),%rax
    e423:	48 2b 05 6e 5d 00 00 	sub    0x5d6e(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e42a:	48 8b 0d 8f 5d 00 00 	mov    0x5d8f(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e431:	48 c1 e1 10          	shl    $0x10,%rcx
    e435:	48 39 c8             	cmp    %rcx,%rax
    e438:	73 68                	jae    e4a2 <fwp_args59+0x92>
    e43a:	48 8b 0d 9f 5d 00 00 	mov    0x5d9f(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e441:	48 89 c2             	mov    %rax,%rdx
    e444:	48 c1 ea 10          	shr    $0x10,%rdx
    e448:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e44f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e453:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e459:	75 13                	jne    e46e <fwp_args59+0x5e>
    e45b:	40 80 fe 02          	cmp    $0x2,%sil
    e45f:	75 0d                	jne    e46e <fwp_args59+0x5e>
    e461:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    e465:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e46c:	eb 21                	jmp    e48f <fwp_args59+0x7f>
    e46e:	40 80 fe 01          	cmp    $0x1,%sil
    e472:	75 2e                	jne    e4a2 <fwp_args59+0x92>
    e474:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e478:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e47c:	48 0f af c1          	imul   %rcx,%rax
    e480:	48 c1 e8 20          	shr    $0x20,%rax
    e484:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    e488:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e48f:	0f b6 07             	movzbl (%rdi),%eax
    e492:	84 c0                	test   %al,%al
    e494:	74 0c                	je     e4a2 <fwp_args59+0x92>
    e496:	3c fe                	cmp    $0xfe,%al
    e498:	0f 83 c2 97 ff ff    	jae    7c60 <fwp_rc_wide_dup>
    e49e:	fe c0                	inc    %al
    e4a0:	88 07                	mov    %al,(%rdi)
    e4a2:	c3                   	ret
    e4a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e4aa:	84 00 00 00 00 00 

000000000000e4b0 <fwp_arg_drop59>:
    e4b0:	85 f6                	test   %esi,%esi
    e4b2:	75 0c                	jne    e4c0 <fwp_arg_drop59+0x10>
    e4b4:	85 d2                	test   %edx,%edx
    e4b6:	74 08                	je     e4c0 <fwp_arg_drop59+0x10>
    e4b8:	48 8b 3f             	mov    (%rdi),%rdi
    e4bb:	e9 70 c4 ff ff       	jmp    a930 <fwp_drop6>
    e4c0:	c3                   	ret
    e4c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e4c8:	0f 1f 84 00 00 00 00 
    e4cf:	00 

000000000000e4d0 <fwp_gc_find_data>:
    e4d0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    e4d4:	48 85 f6             	test   %rsi,%rsi
    e4d7:	0f 84 be 00 00 00    	je     e59b <fwp_gc_find_data+0xcb>
    e4dd:	53                   	push   %rbx
    e4de:	48 8b 07             	mov    (%rdi),%rax
    e4e1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    e4e5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    e4e9:	45 31 c9             	xor    %r9d,%r9d
    e4ec:	48 8d 15 75 4c 00 00 	lea    0x4c75(%rip),%rdx        # 13168 <fwp_gc>
    e4f3:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    e4f9:	45 31 d2             	xor    %r10d,%r10d
    e4fc:	eb 0b                	jmp    e509 <fwp_gc_find_data+0x39>
    e4fe:	66 90                	xchg   %ax,%ax
    e500:	49 83 c1 38          	add    $0x38,%r9
    e504:	4c 39 c9             	cmp    %r9,%rcx
    e507:	74 22                	je     e52b <fwp_gc_find_data+0x5b>
    e509:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    e50e:	75 f0                	jne    e500 <fwp_gc_find_data+0x30>
    e510:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    e515:	48 01 c3             	add    %rax,%rbx
    e518:	48 39 d3             	cmp    %rdx,%rbx
    e51b:	77 e3                	ja     e500 <fwp_gc_find_data+0x30>
    e51d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    e522:	48 39 d3             	cmp    %rdx,%rbx
    e525:	45 0f 47 d3          	cmova  %r11d,%r10d
    e529:	eb d5                	jmp    e500 <fwp_gc_find_data+0x30>
    e52b:	31 c0                	xor    %eax,%eax
    e52d:	45 85 d2             	test   %r10d,%r10d
    e530:	0f 95 c0             	setne  %al
    e533:	74 6e                	je     e5a3 <fwp_gc_find_data+0xd3>
    e535:	66 85 f6             	test   %si,%si
    e538:	74 69                	je     e5a3 <fwp_gc_find_data+0xd3>
    e53a:	8b 05 b8 5d 00 00    	mov    0x5db8(%rip),%eax        # 142f8 <fwp_gc+0x1190>
    e540:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    e544:	45 31 c0             	xor    %r8d,%r8d
    e547:	eb 10                	jmp    e559 <fwp_gc_find_data+0x89>
    e549:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e550:	49 83 c0 38          	add    $0x38,%r8
    e554:	4c 39 c1             	cmp    %r8,%rcx
    e557:	74 45                	je     e59e <fwp_gc_find_data+0xce>
    e559:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    e55e:	75 f0                	jne    e550 <fwp_gc_find_data+0x80>
    e560:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    e566:	74 e8                	je     e550 <fwp_gc_find_data+0x80>
    e568:	83 f8 10             	cmp    $0x10,%eax
    e56b:	74 31                	je     e59e <fwp_gc_find_data+0xce>
    e56d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    e572:	4c 03 0f             	add    (%rdi),%r9
    e575:	4c 63 d0             	movslq %eax,%r10
    e578:	49 c1 e2 04          	shl    $0x4,%r10
    e57c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    e583:	00 
    e584:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    e589:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    e590:	00 
    e591:	ff c0                	inc    %eax
    e593:	89 05 5f 5d 00 00    	mov    %eax,0x5d5f(%rip)        # 142f8 <fwp_gc+0x1190>
    e599:	eb b5                	jmp    e550 <fwp_gc_find_data+0x80>
    e59b:	31 c0                	xor    %eax,%eax
    e59d:	c3                   	ret
    e59e:	b8 01 00 00 00       	mov    $0x1,%eax
    e5a3:	5b                   	pop    %rbx
    e5a4:	c3                   	ret
    e5a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    e5ac:	00 00 00 00 

000000000000e5b0 <fwp_gc_report>:
    e5b0:	55                   	push   %rbp
    e5b1:	41 57                	push   %r15
    e5b3:	41 56                	push   %r14
    e5b5:	41 55                	push   %r13
    e5b7:	41 54                	push   %r12
    e5b9:	53                   	push   %rbx
    e5ba:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    e5c1:	48 8b 05 b0 5d 00 00 	mov    0x5db0(%rip),%rax        # 14378 <fwp_gc+0x1210>
    e5c8:	48 8b 0d 99 4b 00 00 	mov    0x4b99(%rip),%rcx        # 13168 <fwp_gc>
    e5cf:	48 29 c8             	sub    %rcx,%rax
    e5d2:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    e5d7:	f2 0f 58 05 71 5d 00 	addsd  0x5d71(%rip),%xmm0        # 14350 <fwp_gc+0x11e8>
    e5de:	00 
    e5df:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    e5e5:	f2 0f 11 05 63 5d 00 	movsd  %xmm0,0x5d63(%rip)        # 14350 <fwp_gc+0x11e8>
    e5ec:	00 
    e5ed:	48 89 0d 84 5d 00 00 	mov    %rcx,0x5d84(%rip)        # 14378 <fwp_gc+0x1210>
    e5f4:	48 8b 05 e5 49 00 00 	mov    0x49e5(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    e5fb:	48 8b 28             	mov    (%rax),%rbp
    e5fe:	48 8b 1d 3b 5d 00 00 	mov    0x5d3b(%rip),%rbx        # 14340 <fwp_gc+0x11d8>
    e605:	4c 8b 3d 74 5b 00 00 	mov    0x5b74(%rip),%r15        # 14180 <fwp_gc+0x1018>
    e60c:	f2 0f 10 05 5c 5d 00 	movsd  0x5d5c(%rip),%xmm0        # 14370 <fwp_gc+0x1208>
    e613:	00 
    e614:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    e61a:	48 8b 05 8f 5b 00 00 	mov    0x5b8f(%rip),%rax        # 141b0 <fwp_gc+0x1048>
    e621:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    e626:	48 8b 05 03 5d 00 00 	mov    0x5d03(%rip),%rax        # 14330 <fwp_gc+0x11c8>
    e62d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    e632:	4c 8b 35 ff 5c 00 00 	mov    0x5cff(%rip),%r14        # 14338 <fwp_gc+0x11d0>
    e639:	f2 0f 10 05 17 5d 00 	movsd  0x5d17(%rip),%xmm0        # 14358 <fwp_gc+0x11f0>
    e640:	00 
    e641:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    e647:	f2 0f 10 05 11 5d 00 	movsd  0x5d11(%rip),%xmm0        # 14360 <fwp_gc+0x11f8>
    e64e:	00 
    e64f:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    e655:	48 8d 3d 46 12 00 00 	lea    0x1246(%rip),%rdi        # f8a2 <fwp_segv.msg+0x622>
    e65c:	48 8d 35 b5 10 00 00 	lea    0x10b5(%rip),%rsi        # f718 <fwp_segv.msg+0x498>
    e663:	e8 c8 3b ff ff       	call   2230 <fopen@plt>
    e668:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    e66f:	48 85 c0             	test   %rax,%rax
    e672:	74 4b                	je     e6bf <fwp_gc_report+0x10f>
    e674:	49 89 c5             	mov    %rax,%r13
    e677:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    e67c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    e681:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    e686:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    e68b:	be 00 01 00 00       	mov    $0x100,%esi
    e690:	48 89 c2             	mov    %rax,%rdx
    e693:	e8 b8 3a ff ff       	call   2150 <fgets@plt>
    e698:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    e69f:	48 85 c0             	test   %rax,%rax
    e6a2:	0f 85 f1 00 00 00    	jne    e799 <fwp_gc_report+0x1e9>
    e6a8:	4c 89 ef             	mov    %r13,%rdi
    e6ab:	e8 10 3a ff ff       	call   20c0 <fclose@plt>
    e6b0:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    e6b5:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    e6ba:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    e6bf:	66 49 0f 6e c6       	movq   %r14,%xmm0
    e6c4:	66 0f 6f 0d 34 0a 00 	movdqa 0xa34(%rip),%xmm1        # f100 <_IO_stdin_used+0x100>
    e6cb:	00 
    e6cc:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    e6d0:	66 0f 28 15 38 0a 00 	movapd 0xa38(%rip),%xmm2        # f110 <_IO_stdin_used+0x110>
    e6d7:	00 
    e6d8:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    e6dc:	66 0f 28 e0          	movapd %xmm0,%xmm4
    e6e0:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    e6e4:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    e6e8:	f2 0f 10 35 38 09 00 	movsd  0x938(%rip),%xmm6        # f028 <_IO_stdin_used+0x28>
    e6ef:	00 
    e6f0:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    e6f4:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    e6fa:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    e6fe:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    e702:	66 0f 28 dd          	movapd %xmm5,%xmm3
    e706:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    e70a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    e70e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    e712:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    e718:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    e71c:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    e720:	66 0f 28 d5          	movapd %xmm5,%xmm2
    e724:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    e728:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    e72c:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    e730:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    e736:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    e73c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    e740:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    e744:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    e748:	83 3d 0d 5a 00 00 00 	cmpl   $0x0,0x5a0d(%rip)        # 1415c <fwp_gc+0xff4>
    e74f:	48 8d 05 3a 11 00 00 	lea    0x113a(%rip),%rax        # f890 <fwp_segv.msg+0x610>
    e756:	4c 8d 0d 75 12 00 00 	lea    0x1275(%rip),%r9        # f9d2 <fwp_segv.msg+0x752>
    e75d:	4c 0f 44 c8          	cmove  %rax,%r9
    e761:	48 8d 35 73 10 00 00 	lea    0x1073(%rip),%rsi        # f7db <fwp_segv.msg+0x55b>
    e768:	48 89 ef             	mov    %rbp,%rdi
    e76b:	48 89 da             	mov    %rbx,%rdx
    e76e:	4c 89 f9             	mov    %r15,%rcx
    e771:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    e777:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    e77d:	4d 89 e0             	mov    %r12,%r8
    e780:	b0 07                	mov    $0x7,%al
    e782:	e8 19 3a ff ff       	call   21a0 <fprintf@plt>
    e787:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    e78e:	5b                   	pop    %rbx
    e78f:	41 5c                	pop    %r12
    e791:	41 5d                	pop    %r13
    e793:	41 5e                	pop    %r14
    e795:	41 5f                	pop    %r15
    e797:	5d                   	pop    %rbp
    e798:	c3                   	ret
    e799:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    e79e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    e7a4:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    e7a9:	eb 1e                	jmp    e7c9 <fwp_gc_report+0x219>
    e7ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    e7b0:	48 89 df             	mov    %rbx,%rdi
    e7b3:	be 00 01 00 00       	mov    $0x100,%esi
    e7b8:	4c 89 ea             	mov    %r13,%rdx
    e7bb:	e8 90 39 ff ff       	call   2150 <fgets@plt>
    e7c0:	48 85 c0             	test   %rax,%rax
    e7c3:	0f 84 df fe ff ff    	je     e6a8 <fwp_gc_report+0xf8>
    e7c9:	8b 44 24 50          	mov    0x50(%rsp),%eax
    e7cd:	44 31 f8             	xor    %r15d,%eax
    e7d0:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    e7d5:	83 f1 4d             	xor    $0x4d,%ecx
    e7d8:	09 c1                	or     %eax,%ecx
    e7da:	75 d4                	jne    e7b0 <fwp_gc_report+0x200>
    e7dc:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    e7e1:	75 cd                	jne    e7b0 <fwp_gc_report+0x200>
    e7e3:	48 89 ef             	mov    %rbp,%rdi
    e7e6:	31 f6                	xor    %esi,%esi
    e7e8:	ba 0a 00 00 00       	mov    $0xa,%edx
    e7ed:	e8 ce 39 ff ff       	call   21c0 <strtol@plt>
    e7f2:	49 89 c4             	mov    %rax,%r12
    e7f5:	eb b9                	jmp    e7b0 <fwp_gc_report+0x200>
    e7f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e7fe:	00 00 

000000000000e800 <fwp_static_report>:
    e800:	50                   	push   %rax
    e801:	48 8b 05 d8 47 00 00 	mov    0x47d8(%rip),%rax        # 12fe0 <stderr@GLIBC_2.2.5>
    e808:	48 8b 38             	mov    (%rax),%rdi
    e80b:	48 8b 15 a6 63 00 00 	mov    0x63a6(%rip),%rdx        # 14bb8 <fwp_static+0x18>
    e812:	48 2b 15 8f 63 00 00 	sub    0x638f(%rip),%rdx        # 14ba8 <fwp_static+0x8>
    e819:	48 c1 ea 0a          	shr    $0xa,%rdx
    e81d:	48 8b 0d dc 6b 00 00 	mov    0x6bdc(%rip),%rcx        # 15400 <fwp_static+0x860>
    e824:	48 c1 e9 0a          	shr    $0xa,%rcx
    e828:	4c 8b 05 81 59 00 00 	mov    0x5981(%rip),%r8        # 141b0 <fwp_gc+0x1048>
    e82f:	49 c1 e8 0a          	shr    $0xa,%r8
    e833:	4c 8b 0d fe 5a 00 00 	mov    0x5afe(%rip),%r9        # 14338 <fwp_gc+0x11d0>
    e83a:	49 c1 e9 0a          	shr    $0xa,%r9
    e83e:	4c 8b 15 9b 6b 00 00 	mov    0x6b9b(%rip),%r10        # 153e0 <fwp_static+0x840>
    e845:	49 c1 ea 0a          	shr    $0xa,%r10
    e849:	44 8b 1d cc 6e 00 00 	mov    0x6ecc(%rip),%r11d        # 1571c <fwp_static+0xb7c>
    e850:	48 83 ec 08          	sub    $0x8,%rsp
    e854:	48 8d 35 59 10 00 00 	lea    0x1059(%rip),%rsi        # f8b4 <fwp_segv.msg+0x634>
    e85b:	31 c0                	xor    %eax,%eax
    e85d:	68 00 04 00 00       	push   $0x400
    e862:	6a 08                	push   $0x8
    e864:	41 53                	push   %r11
    e866:	68 00 04 00 00       	push   $0x400
    e86b:	6a 40                	push   $0x40
    e86d:	68 00 40 00 00       	push   $0x4000
    e872:	41 52                	push   %r10
    e874:	68 00 80 00 00       	push   $0x8000
    e879:	ff 35 c1 5a 00 00    	push   0x5ac1(%rip)        # 14340 <fwp_gc+0x11d8>
    e87f:	e8 1c 39 ff ff       	call   21a0 <fprintf@plt>
    e884:	48 83 c4 50          	add    $0x50,%rsp
    e888:	58                   	pop    %rax
    e889:	c3                   	ret
    e88a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000e890 <fwp_segv>:
    e890:	48 8b 05 09 6f 00 00 	mov    0x6f09(%rip),%rax        # 157a0 <fwp_main_stack_top>
    e897:	48 85 c0             	test   %rax,%rax
    e89a:	74 22                	je     e8be <fwp_segv+0x2e>
    e89c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    e8a0:	48 2b 05 01 6f 00 00 	sub    0x6f01(%rip),%rax        # 157a8 <fwp_main_stack_size>
    e8a7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    e8ae:	48 39 ca             	cmp    %rcx,%rdx
    e8b1:	77 0b                	ja     e8be <fwp_segv+0x2e>
    e8b3:	48 05 00 00 10 00    	add    $0x100000,%rax
    e8b9:	48 39 c8             	cmp    %rcx,%rax
    e8bc:	77 07                	ja     e8c5 <fwp_segv+0x35>
    e8be:	31 f6                	xor    %esi,%esi
    e8c0:	e9 bb 38 ff ff       	jmp    2180 <signal@plt>
    e8c5:	50                   	push   %rax
    e8c6:	e8 d5 81 ff ff       	call   6aa0 <fwp_flush>
    e8cb:	48 8d 35 ae 09 00 00 	lea    0x9ae(%rip),%rsi        # f280 <fwp_segv.msg>
    e8d2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    e8d7:	bf 02 00 00 00       	mov    $0x2,%edi
    e8dc:	e8 cf 37 ff ff       	call   20b0 <write@plt>
    e8e1:	bf 65 00 00 00       	mov    $0x65,%edi
    e8e6:	e8 75 37 ff ff       	call   2060 <_exit@plt>
    e8eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000e8f0 <fwp_drop0>:
    e8f0:	53                   	push   %rbx
    e8f1:	48 89 f8             	mov    %rdi,%rax
    e8f4:	48 2b 05 9d 58 00 00 	sub    0x589d(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e8fb:	48 8b 0d be 58 00 00 	mov    0x58be(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e902:	48 c1 e1 10          	shl    $0x10,%rcx
    e906:	48 39 c8             	cmp    %rcx,%rax
    e909:	0f 83 96 00 00 00    	jae    e9a5 <fwp_drop0+0xb5>
    e90f:	48 8b 0d ca 58 00 00 	mov    0x58ca(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e916:	48 89 c2             	mov    %rax,%rdx
    e919:	48 c1 ea 10          	shr    $0x10,%rdx
    e91d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e924:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e928:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e92e:	75 20                	jne    e950 <fwp_drop0+0x60>
    e930:	40 80 fe 02          	cmp    $0x2,%sil
    e934:	75 1a                	jne    e950 <fwp_drop0+0x60>
    e936:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e93a:	48 05 28 02 00 00    	add    $0x228,%rax
    e940:	eb 2d                	jmp    e96f <fwp_drop0+0x7f>
    e942:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e949:	1f 84 00 00 00 00 00 
    e950:	40 80 fe 01          	cmp    $0x1,%sil
    e954:	75 4f                	jne    e9a5 <fwp_drop0+0xb5>
    e956:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e95a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e95e:	48 0f af c1          	imul   %rcx,%rax
    e962:	48 c1 e8 20          	shr    $0x20,%rax
    e966:	48 01 f0             	add    %rsi,%rax
    e969:	48 05 28 02 00 00    	add    $0x228,%rax
    e96f:	0f b6 08             	movzbl (%rax),%ecx
    e972:	85 c9                	test   %ecx,%ecx
    e974:	74 2f                	je     e9a5 <fwp_drop0+0xb5>
    e976:	83 f9 01             	cmp    $0x1,%ecx
    e979:	75 2c                	jne    e9a7 <fwp_drop0+0xb7>
    e97b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e97f:	e8 4c c6 ff ff       	call   afd0 <fwp_rc_free_obj>
    e984:	48 89 d8             	mov    %rbx,%rax
    e987:	48 2b 05 0a 58 00 00 	sub    0x580a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e98e:	48 8b 0d 2b 58 00 00 	mov    0x582b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e995:	48 c1 e1 10          	shl    $0x10,%rcx
    e999:	48 89 df             	mov    %rbx,%rdi
    e99c:	48 39 c8             	cmp    %rcx,%rax
    e99f:	0f 82 6a ff ff ff    	jb     e90f <fwp_drop0+0x1f>
    e9a5:	5b                   	pop    %rbx
    e9a6:	c3                   	ret
    e9a7:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e9ad:	74 06                	je     e9b5 <fwp_drop0+0xc5>
    e9af:	fe c9                	dec    %cl
    e9b1:	88 08                	mov    %cl,(%rax)
    e9b3:	5b                   	pop    %rbx
    e9b4:	c3                   	ret
    e9b5:	48 89 c7             	mov    %rax,%rdi
    e9b8:	5b                   	pop    %rbx
    e9b9:	e9 32 c3 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    e9be:	66 90                	xchg   %ax,%ax

000000000000e9c0 <fwp_drop4>:
    e9c0:	53                   	push   %rbx
    e9c1:	48 89 f8             	mov    %rdi,%rax
    e9c4:	48 2b 05 cd 57 00 00 	sub    0x57cd(%rip),%rax        # 14198 <fwp_gc+0x1030>
    e9cb:	48 8b 0d ee 57 00 00 	mov    0x57ee(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    e9d2:	48 c1 e1 10          	shl    $0x10,%rcx
    e9d6:	48 39 c8             	cmp    %rcx,%rax
    e9d9:	0f 83 96 00 00 00    	jae    ea75 <fwp_drop4+0xb5>
    e9df:	48 8b 0d fa 57 00 00 	mov    0x57fa(%rip),%rcx        # 141e0 <fwp_gc+0x1078>
    e9e6:	48 89 c2             	mov    %rax,%rdx
    e9e9:	48 c1 ea 10          	shr    $0x10,%rdx
    e9ed:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e9f4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e9f8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e9fe:	75 20                	jne    ea20 <fwp_drop4+0x60>
    ea00:	40 80 fe 02          	cmp    $0x2,%sil
    ea04:	75 1a                	jne    ea20 <fwp_drop4+0x60>
    ea06:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ea0a:	48 05 28 02 00 00    	add    $0x228,%rax
    ea10:	eb 2d                	jmp    ea3f <fwp_drop4+0x7f>
    ea12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ea19:	1f 84 00 00 00 00 00 
    ea20:	40 80 fe 01          	cmp    $0x1,%sil
    ea24:	75 4f                	jne    ea75 <fwp_drop4+0xb5>
    ea26:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ea2a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ea2e:	48 0f af c1          	imul   %rcx,%rax
    ea32:	48 c1 e8 20          	shr    $0x20,%rax
    ea36:	48 01 f0             	add    %rsi,%rax
    ea39:	48 05 28 02 00 00    	add    $0x228,%rax
    ea3f:	0f b6 08             	movzbl (%rax),%ecx
    ea42:	85 c9                	test   %ecx,%ecx
    ea44:	74 2f                	je     ea75 <fwp_drop4+0xb5>
    ea46:	83 f9 01             	cmp    $0x1,%ecx
    ea49:	75 2c                	jne    ea77 <fwp_drop4+0xb7>
    ea4b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    ea4f:	e8 7c c5 ff ff       	call   afd0 <fwp_rc_free_obj>
    ea54:	48 89 d8             	mov    %rbx,%rax
    ea57:	48 2b 05 3a 57 00 00 	sub    0x573a(%rip),%rax        # 14198 <fwp_gc+0x1030>
    ea5e:	48 8b 0d 5b 57 00 00 	mov    0x575b(%rip),%rcx        # 141c0 <fwp_gc+0x1058>
    ea65:	48 c1 e1 10          	shl    $0x10,%rcx
    ea69:	48 89 df             	mov    %rbx,%rdi
    ea6c:	48 39 c8             	cmp    %rcx,%rax
    ea6f:	0f 82 6a ff ff ff    	jb     e9df <fwp_drop4+0x1f>
    ea75:	5b                   	pop    %rbx
    ea76:	c3                   	ret
    ea77:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    ea7d:	74 06                	je     ea85 <fwp_drop4+0xc5>
    ea7f:	fe c9                	dec    %cl
    ea81:	88 08                	mov    %cl,(%rax)
    ea83:	5b                   	pop    %rbx
    ea84:	c3                   	ret
    ea85:	48 89 c7             	mov    %rax,%rdi
    ea88:	5b                   	pop    %rbx
    ea89:	e9 62 c2 ff ff       	jmp    acf0 <fwp_rc_wide_drop>
    ea8e:	66 90                	xchg   %ax,%ax

000000000000ea90 <__divti3>:
    ea90:	f3 0f 1e fa          	endbr64
    ea94:	55                   	push   %rbp
    ea95:	49 89 f8             	mov    %rdi,%r8
    ea98:	49 89 d2             	mov    %rdx,%r10
    ea9b:	49 89 cb             	mov    %rcx,%r11
    ea9e:	31 ff                	xor    %edi,%edi
    eaa0:	48 89 e5             	mov    %rsp,%rbp
    eaa3:	41 56                	push   %r14
    eaa5:	53                   	push   %rbx
    eaa6:	48 85 f6             	test   %rsi,%rsi
    eaa9:	79 13                	jns    eabe <__divti3+0x2e>
    eaab:	45 31 c9             	xor    %r9d,%r9d
    eaae:	49 f7 d8             	neg    %r8
    eab1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    eab8:	49 19 f1             	sbb    %rsi,%r9
    eabb:	4c 89 ce             	mov    %r9,%rsi
    eabe:	4c 89 da             	mov    %r11,%rdx
    eac1:	4d 85 db             	test   %r11,%r11
    eac4:	0f 88 f6 00 00 00    	js     ebc0 <__divti3+0x130>
    eaca:	4d 89 d6             	mov    %r10,%r14
    eacd:	75 31                	jne    eb00 <__divti3+0x70>
    eacf:	4c 39 f6             	cmp    %r14,%rsi
    ead2:	0f 83 b8 00 00 00    	jae    eb90 <__divti3+0x100>
    ead8:	48 89 f2             	mov    %rsi,%rdx
    eadb:	31 f6                	xor    %esi,%esi
    eadd:	4c 89 c0             	mov    %r8,%rax
    eae0:	49 f7 f6             	div    %r14
    eae3:	48 89 f2             	mov    %rsi,%rdx
    eae6:	48 85 ff             	test   %rdi,%rdi
    eae9:	74 0a                	je     eaf5 <__divti3+0x65>
    eaeb:	48 f7 d8             	neg    %rax
    eaee:	48 83 d2 00          	adc    $0x0,%rdx
    eaf2:	48 f7 da             	neg    %rdx
    eaf5:	5b                   	pop    %rbx
    eaf6:	41 5e                	pop    %r14
    eaf8:	5d                   	pop    %rbp
    eaf9:	c3                   	ret
    eafa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    eb00:	4c 39 de             	cmp    %r11,%rsi
    eb03:	0f 82 d5 00 00 00    	jb     ebde <__divti3+0x14e>
    eb09:	4d 0f bd d3          	bsr    %r11,%r10
    eb0d:	41 83 f2 3f          	xor    $0x3f,%r10d
    eb11:	44 89 d1             	mov    %r10d,%ecx
    eb14:	b8 40 00 00 00       	mov    $0x40,%eax
    eb19:	4c 89 f3             	mov    %r14,%rbx
    eb1c:	4d 89 f1             	mov    %r14,%r9
    eb1f:	48 d3 e2             	shl    %cl,%rdx
    eb22:	49 63 ca             	movslq %r10d,%rcx
    eb25:	49 89 f3             	mov    %rsi,%r11
    eb28:	48 29 c8             	sub    %rcx,%rax
    eb2b:	89 c1                	mov    %eax,%ecx
    eb2d:	48 d3 eb             	shr    %cl,%rbx
    eb30:	44 89 d1             	mov    %r10d,%ecx
    eb33:	49 d3 e1             	shl    %cl,%r9
    eb36:	89 c1                	mov    %eax,%ecx
    eb38:	48 09 d3             	or     %rdx,%rbx
    eb3b:	4c 89 c2             	mov    %r8,%rdx
    eb3e:	49 d3 eb             	shr    %cl,%r11
    eb41:	44 89 d1             	mov    %r10d,%ecx
    eb44:	48 d3 e6             	shl    %cl,%rsi
    eb47:	89 c1                	mov    %eax,%ecx
    eb49:	48 d3 ea             	shr    %cl,%rdx
    eb4c:	48 89 d0             	mov    %rdx,%rax
    eb4f:	4c 89 da             	mov    %r11,%rdx
    eb52:	48 09 f0             	or     %rsi,%rax
    eb55:	48 f7 f3             	div    %rbx
    eb58:	49 89 d3             	mov    %rdx,%r11
    eb5b:	48 89 c6             	mov    %rax,%rsi
    eb5e:	49 f7 e1             	mul    %r9
    eb61:	49 39 d3             	cmp    %rdx,%r11
    eb64:	0f 82 be 00 00 00    	jb     ec28 <__divti3+0x198>
    eb6a:	44 89 d1             	mov    %r10d,%ecx
    eb6d:	49 d3 e0             	shl    %cl,%r8
    eb70:	49 39 c0             	cmp    %rax,%r8
    eb73:	73 09                	jae    eb7e <__divti3+0xee>
    eb75:	49 39 d3             	cmp    %rdx,%r11
    eb78:	0f 84 aa 00 00 00    	je     ec28 <__divti3+0x198>
    eb7e:	48 89 f0             	mov    %rsi,%rax
    eb81:	31 f6                	xor    %esi,%esi
    eb83:	e9 5b ff ff ff       	jmp    eae3 <__divti3+0x53>
    eb88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    eb8f:	00 
    eb90:	4d 85 f6             	test   %r14,%r14
    eb93:	75 0d                	jne    eba2 <__divti3+0x112>
    eb95:	b8 01 00 00 00       	mov    $0x1,%eax
    eb9a:	31 d2                	xor    %edx,%edx
    eb9c:	49 f7 f6             	div    %r14
    eb9f:	49 89 c6             	mov    %rax,%r14
    eba2:	48 89 f0             	mov    %rsi,%rax
    eba5:	31 d2                	xor    %edx,%edx
    eba7:	49 f7 f6             	div    %r14
    ebaa:	48 89 c6             	mov    %rax,%rsi
    ebad:	4c 89 c0             	mov    %r8,%rax
    ebb0:	49 f7 f6             	div    %r14
    ebb3:	e9 2b ff ff ff       	jmp    eae3 <__divti3+0x53>
    ebb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ebbf:	00 
    ebc0:	49 f7 da             	neg    %r10
    ebc3:	48 f7 d7             	not    %rdi
    ebc6:	49 83 d3 00          	adc    $0x0,%r11
    ebca:	4d 89 d6             	mov    %r10,%r14
    ebcd:	49 f7 db             	neg    %r11
    ebd0:	4c 89 da             	mov    %r11,%rdx
    ebd3:	0f 84 f6 fe ff ff    	je     eacf <__divti3+0x3f>
    ebd9:	4c 39 de             	cmp    %r11,%rsi
    ebdc:	73 12                	jae    ebf0 <__divti3+0x160>
    ebde:	31 f6                	xor    %esi,%esi
    ebe0:	31 c0                	xor    %eax,%eax
    ebe2:	e9 fc fe ff ff       	jmp    eae3 <__divti3+0x53>
    ebe7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ebee:	00 00 
    ebf0:	49 0f bd c3          	bsr    %r11,%rax
    ebf4:	48 83 f0 3f          	xor    $0x3f,%rax
    ebf8:	41 89 c2             	mov    %eax,%r10d
    ebfb:	85 c0                	test   %eax,%eax
    ebfd:	0f 85 0e ff ff ff    	jne    eb11 <__divti3+0x81>
    ec03:	49 39 f3             	cmp    %rsi,%r11
    ec06:	72 0d                	jb     ec15 <__divti3+0x185>
    ec08:	31 f6                	xor    %esi,%esi
    ec0a:	31 c0                	xor    %eax,%eax
    ec0c:	4d 39 f0             	cmp    %r14,%r8
    ec0f:	0f 82 ce fe ff ff    	jb     eae3 <__divti3+0x53>
    ec15:	31 f6                	xor    %esi,%esi
    ec17:	b8 01 00 00 00       	mov    $0x1,%eax
    ec1c:	e9 c2 fe ff ff       	jmp    eae3 <__divti3+0x53>
    ec21:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ec28:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    ec2c:	31 f6                	xor    %esi,%esi
    ec2e:	e9 b0 fe ff ff       	jmp    eae3 <__divti3+0x53>
    ec33:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ec3a:	00 00 00 
    ec3d:	0f 1f 00             	nopl   (%rax)

000000000000ec40 <atexit>:
    ec40:	f3 0f 1e fa          	endbr64
    ec44:	48 8b 15 0d 45 00 00 	mov    0x450d(%rip),%rdx        # 13158 <__dso_handle>
    ec4b:	31 f6                	xor    %esi,%esi
    ec4d:	e9 fe 35 ff ff       	jmp    2250 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000ec54 <_fini>:
    ec54:	f3 0f 1e fa          	endbr64
    ec58:	48 83 ec 08          	sub    $0x8,%rsp
    ec5c:	48 83 c4 08          	add    $0x8,%rsp
    ec60:	c3                   	ret
